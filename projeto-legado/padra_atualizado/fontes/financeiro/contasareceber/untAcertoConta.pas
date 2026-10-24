{***************************}
{* qryConCli -> CADCLI     *}
{************************JB*}
unit untAcertoConta;

interface

uses
  Windows, Classes, Controls, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, EditFocus, DB, RLFilters,
  RLDraftFilter, Uni, AppEvnts, UniClientDataSet, frxClass, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,  System.UITypes,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, MemoFocus,
  cxGroupBox, Winapi.Messages, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, System.ImageList, Vcl.ImgList,
  untTypesSistema,untFuncoesConsulta, untTLock;

type
  TFiltrosDuplicata = (tpfMarcados, tpfPromocao, tpfSemPromocao, tpfSemFiltro);

  TfrmAcertoConta = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    pnlTotais: TPanel;
    rldFiltro: TRLDraftFilter;
    gpbTotalGeral: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edtTotalOriginalGer: TEditFocus;
    edtTotalCorrigidoGer: TEditFocus;
    gpbSelecionado: TGroupBox;
    Label21: TLabel;
    Label23: TLabel;
    edtTotalCorrigido: TEditFocus;
    edtTotalOriginal: TEditFocus;
    mskDtaIni: TcxDateEdit;
    Label6: TLabel;
    mskDtaFin: TcxDateEdit;
    Label3: TLabel;
    edtTotalDuplicataGer: TEditFocus;
    edtTotalDuplicata: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    edtHistor: TMemoFocus;
    edtCodPorBai: TEditFocus;
    chkListarImpressosEnviados: TCheckBox;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edtTotalOriSemPromoc: TEditFocus;
    edtTotalCorSemPromoc: TEditFocus;
    edtTotalDupSemPromoc: TEditFocus;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edtTotalOriPromoc: TEditFocus;
    edtTotalCorPromoc: TEditFocus;
    edtTotalDupPromoc: TEditFocus;
    cxGroupBox1: TcxGroupBox;
    Panel1: TPanel;
    Shape1: TShape;
    Label17: TLabel;
    edtNosNumBai: TEditFocus;
    Label10: TLabel;
    btnConsultar: TBitBtnLocked;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasDBTableView1CTR_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_ESPDOC: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_NOMCLI: TcxGridDBColumn;
    dbgDuplicatasDBTableView1POR_NOMPOR: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_CODEMP: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_DTACAD: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_TIPFOR: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_VALDUP: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_DTAPAG: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_VALMUL: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_VALJUR: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_VALCAL: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_ATRASO: TcxGridDBColumn;
    dbgDuplicatasDBTableView1ENVBCO: TcxGridDBColumn;
    dbgDuplicatasDBTableView1BOLIMP: TcxGridDBColumn;
    dbgDuplicatasDBTableView1PROMOC: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_MARDES: TcxGridDBColumn;
    dbgDuplicatasDBTableView1CTR_DESPCO: TcxGridDBColumn;
    pnlbotoesComp: TPanel;
    FlwPnlBotoesbaixa: TFlowPanel;
    btnAlteraPagamento: TBitBtnLocked;
    btnInfObranca: TBitBtnLocked;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    btnEmail: TBitBtnLocked;
    btnProdutos: TBitBtnLocked;
    btnRecalculaJuros: TBitBtnLocked;
    btnDespCobranca: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnNegVencto: TBitBtnLocked;
    btnReNegociacao: TBitBtnLocked;
    BtnAntecRecebiveis: TBitBtnLocked;
    img_f7: TImageList;
    btnSairBaixa: TBitBtnLocked;
    pnlSair: TPanel;
    Label22: TLabel;
    Shape2: TShape;
    edtDesRed: TEditFocus;
    edtCodRed: TEditFocus;
    Label24: TLabel;
    btnFormaPagto: TBitBtnLocked;
    lblTextoPix: TLabel;
    Label25: TLabel;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRecalculaJurosClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnDespCobrancaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnEmailClick(Sender: TObject);
    procedure btnReNegociacaoClick(Sender: TObject);
    procedure Shape1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
    procedure btnInfObrancaClick(Sender: TObject);
    procedure btnNegVenctoClick(Sender: TObject);
    procedure btnAlteraPagamentoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1DblClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure BtnAntecRecebiveisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnFormaPagtoClick(Sender: TObject);
  private
    strConPag    : String;
    dtaData      : TDateTime;
    fltJurosAtual: Double;
    fltMultaAtual: Double;

    qryConCli: TUniQuery;
    cdsCtaRec: TUniClientDataSet;
    dtsCtaRec: TDataSource;

    arrClientes: TConsultasArray;
    arrRede    : TConsultasArray;
    strClientes: String;
    strRede    : String;

    blnDescFinanSomenteAteVenc : boolean;
    objLock   : TLock;

    function fGetDataPagamento(cdsDup: TDataSet): Double;
    procedure pLimparTela;
    procedure pCalculaDespCobranca(fltDespCob: Double; strAplDesp: String);
    procedure pDespesaCobranca;
    procedure pNegociacaoVencimentos;
    procedure pCarregaCliente;
    procedure pCriaTemporaria;
    procedure pCalculaValorCorrigidoVerificaPromocao;
    procedure pCalculaDiasAtraso;
    procedure pMarcaTodas;
    procedure pDesmarcaTodas;
    procedure pCalculaTotalDuplicatas(edtValTot, edtValCor, edtValDup: TEditFocus; AFiltroDuplicatas: TFiltrosDuplicata = tpfSemFiltro);
    procedure pMarcaDuplicata(blnMarcar: Boolean; strDtaPag: String);
    procedure pSelecionaDuplicata;
    procedure pCalculaJuros(fltPerJur, fltPerMul: Double; strAplJur: String);
    procedure pRecalculaJuros;
    procedure pAfterScroll(DataSet: TDataSet);
    function fValidaDuplics(Var AValidaCliente : Boolean; AValidaApenasCliente : Boolean = False): Boolean;
    function fRetornaTotalPromocaoAG(strNumDoc, strCodEmp, strCodCli: String): Double;
    function fRetornaFiltroDuplicatas(AFiltroDuplicatas: TFiltrosDuplicata): String;
    procedure pAlteraDtaPagamento(dtaDtaPag: TDateTime; strAplicaDta: String);
    function fVerificaDataPagamentoDups: Boolean;
    procedure pReajustaPanelDosBotoes;
    procedure pReajustarBotoesRodape;
    procedure pCarregaRede;
    function fLockedByCurrentConnection(strChaLck: String): Boolean;

    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pImprimir(blnEmail: Boolean = False);
  end;


implementation

uses SysUtils, Variants, Graphics, Forms, StrUtils, UniDataSetProvider,
  untAceCtaData, untConsultas, untFuncoesRel, untFuncoes, untfuncoesSimples,
  untPesqAux, untCtrRecalculoJuros, untDigCndPagamento, untQckAcertoConta,
  untCfgRel, untDigEmail, untFuncoesRel2, TypesRel,
  untModuloSPR, untRelFatVendasClienteF9, untFuncoesAuxiliares, untTEnvioEmail,
  untDuplicatas, untAgrupDuplicatas, untGravando, untInfCobranca,
  untCtrDespCobranca, untCtrNegociacaoParcelamento, untParcelamento,
  untConstantes, untCtrAntecipacaoRecebiveis, untBaixaReceber, untPgtOnlineApi;

{$R *.dfm}

procedure TfrmAcertoConta.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmAcertoConta.fRetornaFiltroDuplicatas(
  AFiltroDuplicatas: TFiltrosDuplicata): String;
begin
  if AFiltroDuplicatas = tpfMarcados then
    Result :='CTR_MARDES = ' + QuotedStr('M');

  if AFiltroDuplicatas = tpfPromocao then
    Result :='PROMOC = ' + QuotedStr('S');

  if AFiltroDuplicatas = tpfSemPromocao then
    Result :='PROMOC = ' + QuotedStr('N');
end;

function TfrmAcertoConta.fRetornaTotalPromocaoAG(strNumDoc, strCodEmp,
  strCodCli: String): Double;
var
  qryConsulta: TUniQuery;
begin
  Result := 0;
  qryConsulta := fCriaQuery();
  qryConsulta.Sql.Clear;
  qryConsulta.Sql.Text := untFuncoesAuxiliares.fRetornaSQLDupAgrupadas();

  qryConsulta.ParamByName('NUMAGR').AsString := strNumDoc;
  qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
  qryConsulta.ParamByName('EMPAGR').AsString := strCodEmp;

 qryConsulta.Open;

  if not qryConsulta.IsEmpty then
  begin
    while not qryConsulta.Eof  do
    begin
      Result := Result + fRetornaTotalPromocaoPorDocumento(LeftStr(qryConsulta.FieldByName('CTR_DUPPAR').AsString, fTamDocCadRec),
                                                           qryConsulta.FieldByName('CTR_ESPDOC').AsString,
                                                           LeftStr(qryConsulta.FieldByName('CTR_CODEMP').AsString, 3),
                                                           qryConsulta.FieldByName('CTR_CODCLI').AsString);

      qryConsulta.Next
    end;

  end;

  qryConsulta.Close;
  FreeAndNil(qryConsulta);
end;

function TfrmAcertoConta.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {************************************}
    {* VALIDA O COD.CLIENTE             *}
    {*********************************AF*}
    If (Sender = edtCodCli) Then
    Begin
      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        If Not SameText(edtCodCli.Text, '00000000') Then
        Begin
          SetLength(arrClientes, 0);
          strClientes := '';

          pCarregaCliente;
          If fEmptyStr(edtNomCli.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodRed) Then
    Begin
      If Not fEmptyStr(edtCodRed.Text) Then
      Begin
        If Not SameText(edtCodRed.Text, '00000') Then
        Begin
          SetLength(arrRede, 0);
          strRede := '';

          pCarregaRede;
          If fEmptyStr(edtDesRed.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa rede de lojas não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        edtDesRed.Clear;
      End;

    End

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************AF*}
    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If (Sender = mskDtaIni) Then
      Begin
        mskDtaFin.Clear;
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          mskDtaFin.Enabled          := False;
         {btnRecalculaJuros.Enabled  := True;
          btnDespCobranca.Enabled    := True;
          btnNegVencto.Enabled       := True;
          btnImprimir.Enabled        := True;
          btnMarcar.Enabled          := True;
          btnDesmarcar.Enabled       := True;
          btnEmail.Enabled           := True;
          btnProdutos.Enabled        := True;
          btnAlteraPagamento.Enabled := True;

          pCriaTemporaria;}
        End
        Else
        Begin
          mskDtaFin.Enabled := True;
        End;

      End

      {*****************************************}
      {* VALIDA A DATA FINAL                   *}
      {**************************************AF*}
      Else If (Sender = mskDtaFin) Then
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin

          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
            Result := False;
          End
          Else
          Begin

            If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
              Result := False;
            End
            Else
            Begin
              {btnRecalculaJuros.Enabled  := True;
              btnDespCobranca.Enabled    := True;
              btnNegVencto.Enabled       := True;
              btnImprimir.Enabled        := True;
              btnMarcar.Enabled          := True;
              btnDesmarcar.Enabled       := True;
              btnEmail.Enabled           := True;
              btnProdutos.Enabled        := True;
              btnAlteraPagamento.Enabled := True;

              pCriaTemporaria;}
            End;

          End;
        End;
      End;

      {**28/05/2015****************************************************}
      {* FUNÇÃO VALIDA SE DATA ATENDE "PADRÃO FEBRABAN" (ANO >= 1900) *}
      {*************************************************************BB*}
      If Not fIsValidDate(Sender) Then
      Begin
        pMensagemOk('Data informada é inválida! Necessário correção.');
        Result := False;
      End;
    End;

  End;


  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmAcertoConta.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmAcertoConta.pCarregaRede;
begin
  If Not fEmptyStr(edtCodRed.Text) Then
    edtDesRed.Text := fRetNomeRedeLoja(edtCodRed.Text)
  Else
    edtDesRed.Clear;
end;

{*************************************}
{* CRIA A TABELA TEMPORARIA COM AS   *}
{* DUPLICATAS REFERENTES AO FILTRO   *}
{**********************************AF*}
procedure TfrmAcertoConta.pCriaTemporaria;
  Var
    strSQL: String;
    qryCtaRec: TUniQuery;
    dspCtaRec: TUniDataSetProvider;
begin
  fltJurosAtual := fCfgSis('JURATR', varDouble);
  fltMultaAtual := fCfgSis('MULATR', varDouble);
  Try
    cdsCtaRec.Close;
    qryCtaRec := fCriaQuery(Self);
    dspCtaRec := TUniDataSetProvider.Create(Self);
    dspCtaRec.DataSet := qryCtaRec;
    cdsCtaRec.SetProvider(dspCtaRec);
    objLock.pDestravarTodos;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
    strSQL := strSQL + '  R.CTR_ESPDOC AS CTR_ESPDOC, ';
    strSQL := strSQL + '  R.CTR_SEQBAI AS CTR_SEQBAI, ';
    strSQL := strSQL + '  R.CTR_DTAVEN AS CTR_DTAVEN, ';

    If blnDescFinanSomenteAteVenc Then
      strSQL := strSQL + ' IF((R.CTR_DTAVEN < CURDATE()), ' +
                         ' (R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(0.00, 0) - 0), ' +
                         ' (R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(0.00, 0) - IFNULL(R.CTR_DESSUJ, 0))) '+
                         '  AS CTR_VALDUP, '
    Else
      strSQL := strSQL + '  (R.CTR_VALDUP + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(0.00, 0) - IFNULL(R.CTR_DESSUJ, 0)) AS CTR_VALDUP, ';

    strSQL := strSQL + '  R.CTR_CODCLI AS CTR_CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS CLI_NOMCLI, ';
    strSQL := strSQL + '  CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI) AS CTR_NOMCLI, ';
//    strSQL := strSQL + '  IF(R.CTR_VALREC > 0, R.CTR_VALREC - (R.CTR_VALREC - IFNULL(R.CTR_VALJUR, 0) - IFNULL(R.CTR_VALCOB, 0) + IFNULL(R.CTR_VALDES, 0)), 0) AS CTR_DIFERE, '; //TODOS VAL. JUROS
    strSQL := strSQL + '  R.CTR_CODEMP AS CTR_CODEMP, ';
    strSQL := strSQL + '  R.CTR_CODPOR AS CTR_CODPOR, ';
    strSQL := strSQL + '  CONCAT(R.CTR_CODPOR, "-", P.POR_NOMPOR) AS POR_NOMPOR, ';
    strSQL := strSQL + '  R.CTR_NOSNUM AS CTR_NOSNUM, ';
    strSQL := strSQL + '  R.CTR_HIST01 AS CTR_HIST01, ';
    strSQL := strSQL + '  R.CTR_HIST02 AS CTR_HIST02, ';
    strSQL := strSQL + '  R.CTR_ADTCLI AS CTR_ADTCLI, ';
    strSQL := strSQL + '  R.CTR_CODEVE AS CTR_CODEVE, ';
    strSQL := strSQL + '  R.CTR_CODVEL AS CTR_CODVEL, ';
    strSQL := strSQL + '  "1" AS CTR_IDENTI, ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS CTR_DTAPAG, ';
    strSQL := strSQL + '  "CADREC" AS NOMARQ, ';
    strSQL := strSQL + '  " " AS CTR_MARDES, ';
    strSQL := strSQL + '  R.CTR_VALREC AS CTR_VALREC, ';
    strSQL := strSQL + '  R.CTR_VALORI AS CTR_VALORI, ';
//    strSQL := strSQL + '  R.CTR_VALJUR AS CTR_VALJUR, ';
    strSQL := strSQL + '  R.CTR_VALDES AS CTR_VALDES, ';
    strSQL := strSQL + '  R.CTR_DESCON AS CTR_DESCON, ';
    strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
    strSQL := strSQL + '  R.CTR_DESSUJ AS CTR_DESSUJ, ';
    strSQL := strSQL + '  R.CTR_VALDUP AS CTR_VALCAL, ';
    strSQL := strSQL + '  0.00 AS CTR_VALJUR, ';
    strSQL := strSQL + '  CTR_DESCOB AS CTR_DESPCO, ';
    strSQL := strSQL + '  0.00 AS CTR_ATRASO, ';
    strSQL := strSQL + '  0.00 AS CTR_VALMUL, ';
    strSQL := strSQL + '  R.CTR_DTAENV AS CTR_DTAENV, ';
    strSQL := strSQL + '  R.CTR_BCOBOL AS CTR_BCOBOL, ';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS CTR_DTAREC, ';
    strSQL := strSQL + '  R.CTR_DTACAD, ';
    strSQL := strSQL + '  R.CTR_TIPFOR, ';
    strSQL := strSQL + '  IF(R.CTR_DTAENV IS NULL OR R.CTR_DTAENV = 0, "NÃO", "SIM") AS ENVBCO, ';
    strSQL := strSQL + '  "N" AS PROMOC, ';
    strSQL := strSQL + '  IF(IF(CTR_BCOBOL = "778", TRUE, (R.CTR_NOSNUM IS NULL OR R.CTR_NOSNUM = "")), "NÃO", "SIM") AS BOLIMP, ';
    strSQL := strSQL + '  R.CTR_EMPPIX, ';
    strSQL := strSQL + '  R.CTR_TX_PIX  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';

    strSQL := strSQL + '  LEFT JOIN FATGOR ON FATGOR.FGO_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '                  AND FATGOR.FGO_NUMDOC = CTR_NUMDUP ';
    strSQL := strSQL + '                  AND FATGOR.FGO_ESPDOC = CTR_ESPDOC ';
    strSQL := strSQL + '                  AND FATGOR.FGO_CODEMP = CTR_CODEMP ';

    strSQL := strSQL + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  R.CTR_DTAREC IS NULL ';
    strSQL := strSQL + '  AND R.CTR_SEQBAI = 0 ';

    strSQL := strSQL + ' AND (IFNULL(FGO_BOLADT, 0.00) = 0.00) ';

    If Not fEmptyStr(edtCodRed.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRed, arrRede, 'C.CLI_CODRED', 'CODRED');

    If Not fEmptyStr(fCfgSis('POOCRE')) Then
      strSQL := strSQL + 'AND IF((R.CTR_VALDUP < 0),IFNULL(R.CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString+',TRUE)';

    If Not chkListarImpressosEnviados.Checked Then
    Begin
      strSQL := strSQL + '  AND (R.CTR_DTAENV IS NULL OR R.CTR_DTAENV = 0) ';
      strSQL := strSQL + '  AND IF(CTR_BCOBOL = "778", TRUE, (R.CTR_NOSNUM IS NULL OR R.CTR_NOSNUM = "")) ';
    End;

    If Not fEmptyStr(edtCodCli.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCli, arrClientes, 'R.CTR_CODCLI', 'CODCLI');

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      strSQL  := strSQL  + '  AND R.CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
    End;

    If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(R.CTR_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(R.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + '  AND R.CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

    With qryCtaRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCodRed.Text) Then
        pSetaParam(edtCodRed.Text, arrRede, strRede, 'CODRED', qryCtaRec);

      If Not fEmptyStr(edtCodCli.Text) Then
        pSetaParam(edtCodCli.Text, arrClientes, strClientes, 'CODCLI', qryCtaRec);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;
      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCtaRec);
        With cdsCtaRec Do
        Begin
          AfterScroll := nil;
          Open;
          DisableControls;
          (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTR_VALORI') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTR_VALCAL') As TFloatField).DisplayFormat := '#,##0.00';
//          (FieldByName('CTR_JUROS')  As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTR_VALMUL') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTR_VALJUR') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTR_DESPCO') As TFloatField).DisplayFormat := '#,##0.00';

          IndexFieldNames := 'CTR_DTAVEN;CTR_CODCLI;CTR_NUMDUP;CTR_CODEMP';

          pCalculaValorCorrigidoVerificaPromocao;
          pCalculaDiasAtraso;

          First;
          EnableControls;
        End;
        btnRecalculaJuros.Enabled := True;
        btnFormaPagto.Enabled     := fCfgSis('USAFPG', varBoolean);

        btnDespCobranca.Enabled    := True;
        btnNegVencto.Enabled       := True;
        btnImprimir.Enabled        := True;
        btnMarcar.Enabled          := True;
        btnDesmarcar.Enabled       := True;
        btnEmail.Enabled           := True;
        btnProdutos.Enabled        := True;
        btnAlteraPagamento.Enabled := True;
        btnInfObranca.Enabled      := True;
        btnReNegociacao.Enabled    := True;

        If (fCfgSis('CTRARC') = 'S') Then
           BtnAntecRecebiveis.enabled := True;

        pSetFocus(dbgDuplicatas);
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas!', ['&O k']);

        btnRecalculaJuros.Enabled := False;
        btnFormaPagto.Enabled     := False;

        btnDespCobranca.Enabled    := False;
        btnNegVencto.Enabled       := False;
        btnImprimir.Enabled        := False;
        btnMarcar.Enabled          := False;
        btnDesmarcar.Enabled       := False;
        btnEmail.Enabled           := False;
        btnProdutos.Enabled        := False;
        btnAlteraPagamento.Enabled := False;
        btnInfObranca.Enabled      := False;
        btnReNegociacao.Enabled    := False;
        BtnAntecRecebiveis.enabled := False;

        pSetFocus(edtCodCli);
      End;

      Close;
    End;

    pCalculaTotalDuplicatas(edtTotalOriPromoc,    edtTotalDupPromoc,    edtTotalCorPromoc,    tpfPromocao);
    pCalculaTotalDuplicatas(edtTotalOriSemPromoc, edtTotalDupSemPromoc, edtTotalCorSemPromoc, tpfSemPromocao);
    pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
    pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAcertoConta.pCriaTemporaria]');
  End;
  cdsCtaRec.SetProvider(nil);
  FreeAndNil(dspCtaRec);
  FreeAndNil(qryCtaRec);
  cdsCtaRec.AfterScroll := pAfterScroll;
end;

procedure TfrmAcertoConta.pLimparTela;
begin
  pSetFocus(edtCodCli);
  btnRecalculaJuros.Enabled  := False;
  btnDespCobranca.Enabled    := False;
  btnNegVencto.Enabled       := False;
  btnImprimir.Enabled        := False;
  btnMarcar.Enabled          := False;
  btnDesmarcar.Enabled       := False;
  btnEmail.Enabled           := False;
  btnProdutos.Enabled        := False;
  btnAlteraPagamento.Enabled := False;
  btnInfObranca.Enabled      := False;
  btnReNegociacao.Enabled    := False;
  //BtnAntecRecebiveis.Enabled := False;

  edtTotalCorrigidoGer.Text := '0.00';
  edtTotalCorrigido.Text    := '0.00';
  edtTotalDuplicataGer.Text := '0.00';
  edtTotalDuplicata.Text    := '0.00';
  edtTotalOriginalGer.Text  := '0.00';
  edtTotalOriginal.Text     := '0.00';
  SetLength(arrClientes, 0);
  SetLength(arrRede, 0);
  strClientes := '';
  strRede    := '';
  cdsCtaRec.Close;
  objLock.pDestravarTodos;
end;

procedure TfrmAcertoConta.pDespesaCobranca;
  Var
    blnConfirma: Boolean;
    fltDespCob : Double;
    strAplDesp : String;
    frmCtrDespCobranca: TfrmCtrDespCobranca;
begin
  fltDespCob    := 0.0;
  Screen.Cursor := crHourGlass;

  blnConfirma := False;

  Try
    pCriarFormularios(TfrmCtrDespCobranca, frmCtrDespCobranca);
    frmCtrDespCobranca.ShowModal;

    blnConfirma := frmCtrDespCobranca.blnConfirma;

    If blnConfirma Then
    Begin
      fltDespCob := fStrToFloat(frmCtrDespCobranca.edtDespCob.Text);
      strAplDesp := frmCtrDespCobranca.edtAplDesp.Text;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmAcertoConta.pRecalculaJuros]');
    End;
  End;

  pFreeAndNil(frmCtrDespCobranca);

  If (blnConfirma) Then
  Begin
    pCalculaDespCobranca(fltDespCob, strAplDesp);

    pCalculaTotalDuplicatas(edtTotalOriginalGer, edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
    pCalculaTotalDuplicatas(edtTotalOriginal, edtTotalCorrigido, edtTotalDuplicata, tpfMarcados);
  End;

  Screen.Cursor := crDefault;
end;


procedure TfrmAcertoConta.pDesmarcaTodas;
var
  intRecNo: Integer;
begin
  If cdsCtaRec.IsEmpty Then
    Exit;

  cdsCtaRec.AfterScroll := nil;
  intRecNo := cdsCtaRec.RecNo;
  cdsCtaRec.DisableControls;
  Try
    cdsCtaRec.First;
    While Not cdsCtaRec.Eof Do
    Begin
      pMarcaDuplicata(False, '');
      pCalculaJuros(fltJurosAtual, fltMultaAtual, 'D');
      cdsCtaRec.Next;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmAcertoConta.btnDesmarcarClick]');
  End;

  pCalculaTotalDuplicatas(edtTotalOriPromoc,    edtTotalDupPromoc,    edtTotalCorPromoc,    tpfPromocao);
  pCalculaTotalDuplicatas(edtTotalOriSemPromoc, edtTotalDupSemPromoc, edtTotalCorSemPromoc, tpfSemPromocao);
  pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
  pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);

  cdsCtaRec.RecNo := intRecNo;
  cdsCtaRec.EnableControls;
  cdsCtaRec.AfterScroll := pAfterScroll;
end;

procedure TfrmAcertoConta.pImprimir(blnEmail: Boolean);
  Var
    frmQckAcertoConta: TfrmQckAcertoConta;
    strNomeFila: String;
    strTipImp   : String;
    cdsRelCtr   : TUniClientDataSet;
    frxReport   : TfrxReport;
    intContador : Integer;
    blnContinua : Boolean;
    qryGenCli   : TUniQuery;
    strDest     : String;
    strEmailDest: String;
    blnConfirma : Boolean;
    strPath     : String;
    strFileName : String;
    strDestImp  : String;
    arrArquivos, arrDestinatarios : TStringArray;
    arrDuplicata: TarrDuplicata;

  function GetTemporaryDir: String;
  Var
    pNetpath: ARRAY[ 0..MAX_path - 1 ] of Char;
    nlength: Cardinal;
  Begin
    nlength := MAX_path;
    FillChar( pNetpath, SizeOF( pNetpath ), #0 );
    GetTemppath( nlength, pNetpath );
    Result := StrPas( pNetpath );
  End;

  function fBarraNoFinal(strPath: String) : String;
    Var
      strTmp : String;
  Begin
    strTmp := strPath;
    If Not (strTmp[Length(strTmp)] = '\') Then
      Result := strTmp + '\'
    Else
      Result := strTmp;
  End;

begin
  inherited;
  pZeraDigDuplic(arrDuplicata);
  cdsRelCtr := TUniClientDataSet.Create(Self);
  With cdsRelCtr Do
  Begin
    Data := cdsCtaRec.Data;
    IndexFieldNames := 'CTR_CODCLI;CTR_DTAVEN;CTR_NUMDUP;CTR_CODEMP';
    Filtered := False;
    Filter := 'CTR_MARDES = ' + QuotedStr('M');
    Filtered := True;
    First;

    If IsEmpty Then
      fMensagem('','Não há dados para gerar o relatório!',['&OK'])
    Else
    Begin
      If Not blnEmail Then Begin
        If fMensagem('','Saída',['&Vídeo','&Imprimir']) = 1 Then
          strDestImp := 'V'
        Else
          strDestImp := 'I';
      End;

      If (Not fEmptyStr(strConPag)) Then
        fDigDuplic(arrDuplicata, strConPag,0,fStrToFloat(edtTotalCorrigido.Text),False,False,False,VS_Date,False);

      Try
        pCriarFormularios(TfrmQckAcertoConta,frmQckAcertoConta);
        frmQckAcertoConta.dtsCtaRec.DataSet := cdsRelCtr;

        If Not blnEmail Then
        Begin
          pCarregaConfImpr(qryCfgRel, Self.Name);

          If strDestImp = 'I' Then
            blnContinua := fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False)
          Else
          Begin
            strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
            strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
            blnContinua := True;
          End;

        End
        Else
          blnContinua := True;

        If blnContinua Then
        Begin
          If (strTipImp = 'M') Then
            frxReport := frmQckAcertoConta.frxReportM
          Else
            frxReport := frmQckAcertoConta.frxReportJ;

          If Not fEmptyStr(strNomeFila) Then
          Begin
            frxReport.PrintOptions.ShowDialog := False;
            frxReport.PrintOptions.Printer    := strNomeFila;
          End;

          If (fEmptyStr(strConPag)) Then
            strConPag := 'A Vista';

          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            frxReport.Script.Variables['PERIODO'] := 'REFERENTE AO ' +
            IfThen(strTipImp = 'M', 'PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text,
                                    'PERÍODO DE ' + mskDtaIni.Text + ' À ' + mskDtaFin.Text)
          Else
            frxReport.Script.Variables['PERIODO'] := '';

          frxReport.Script.Variables['CLIENTE'] := 'CLIENTE: ' + edtCodCli.Text + ' - ' + edtNomCli.Text;

          If (Not (strConPag = 'A Vista')) Then
            frxReport.Script.Variables['CNDPAG'] := 'COND. PAGAMENTO: ' + fFormataCondPag(strConPag)
          Else
            frxReport.Script.Variables['CNDPAG'] := 'COND. PAGAMENTO: ' + strConPag;

          TfrxMemoView(frxReport.FindObject('mmoDetalhe')).Highlight.Color := fCfgSis('CORZEB');

          TfrxChild(frxReport.FindObject('ChildCndPag')).Visible := (strConPag <> 'A Vista');

          If TfrxChild(frxReport.FindObject('ChildCndPag')).Visible Then
          Begin
            TfrxMemoView(frxReport.FindObject('mmoDtaPag1')).Text := arrDuplicata[0].dtaDtaVen;
            TfrxMemoView(frxReport.FindObject('mmoValPag1')).Text := FloatToStrF(arrDuplicata[0].curValor, ffFixed, 12, 2);

            For intContador := 1 To 23 Do
            Begin

              If Not fEmptyStr(arrDuplicata[intContador].dtaDtaVen) Then
              Begin
                TfrxMemoView(frxReport.FindObject('mmoDtaPag'+IntToStr(intContador+1))).Text := arrDuplicata[intContador].dtaDtaVen;
                TfrxMemoView(frxReport.FindObject('mmoValPag'+IntToStr(intContador+1))).Text := FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2);
                TfrxMemoView(frxReport.FindObject('mmoDtaPag'+IntToStr(intContador+1))).Visible := True;
                TfrxMemoView(frxReport.FindObject('mmoValPag'+IntToStr(intContador+1))).Visible := True;
                TfrxChild(frxReport.FindObject('ChildCndPag')).Height := TfrxMemoView(frxReport.FindObject('mmoValPag'+IntToStr(intContador+1))).Top + TfrxMemoView(frxReport.FindObject('mmoValPag'+IntToStr(intContador+1))).Height;
              End;

            End;
          End;

          If Not blnEmail Then
          Begin
            If strDestImp = 'I' Then
            Begin
              If frxReport.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption, strNomeFila, frxReport);
            End
            Else
              pPreviewReport(Self.Name, Self.Caption, frxReport);
          End
          Else
          Begin
            If frxReport.PrepareReport Then
            Begin

              strPath := GetTemporaryDir;
              strPath := fBarraNoFinal(strPath);

              If DirectoryExists(strPath) Then
                strFileName := strPath + 'Acerto.pdf'
              Else
                strFileName := ExtractFilePath(Application.ExeName) + 'Acerto.pdf';

              frmQckAcertoConta.frxExpPDF.FileName    := strFileName;
              frmQckAcertoConta.frxExpPDF.DefaultPath := strPath;
              frmQckAcertoConta.frxExpPDF.ShowDialog  := False;
              frxReport.Export(frmQckAcertoConta.frxExpPDF);

              Try
                pCriarFormularios(TfrmDigEmail, frmDigEmail);
                qryGenCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
                pPesquisaCadCli(qryGenCli, qryGenCli, edtCodCli.Text);
                frmDigEmail.edtEmail.Text   := qryGenCli.FieldByName('CLI_EMAIL_').AsString;
                frmDigEmail.edtContato.Text := qryGenCli.FieldByName('CLI_CONTAT').AsString;
                blnConfirma := (frmDigEmail.ShowModal = mrOk);
                FreeAndNil(qryGenCli);

                If (blnConfirma) Then
                Begin
                  strDest      := frmDigEmail.edtContato.Text;
                  strEmailDest := frmDigEmail.edtEmail.Text;
                End;
              Except
                On E: Exception Do
                Begin
                  blnConfirma := False;
                  pMensagensErro(E.Message, '[frmAcertoConta.pImprimir]');
                End;
              End;
              pFreeAndNil(frmDigEmail);

              If blnConfirma Then Begin
                pCriarArrayAnexosEDestinatarios(strFileName, strEmailDest, arrDestinatarios, arrArquivos);
                TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, 'Acerto de Conta', arrDestinatarios, [], [], ['Segue arquivo em anexo.'], arrArquivos);
              End;

              SetForegroundWindow(VS_APPLICATION_HANDLE);
              DeleteFile(strFileName);
            End;
          End;
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmAcertoConta.pImprimir]');
        End;
      End;
      pFreeAndNil(frmQckAcertoConta);
    End;
  End;
  FreeAndNil(cdsRelCtr);
end;

procedure TfrmAcertoConta.pCalculaValorCorrigidoVerificaPromocao;
  Var
    fltValPro: Double;
  recMulJur: TRecMultaJuros;
begin
  With cdsCtaRec Do
  Begin
    DisableControls;
//    fltJurAtr := fCfgSis('JURATR', varDouble);

    First;
    While Not Eof Do
    Begin
      recMulJur := fCalculaMultaJuros(FieldByName('CTR_DTAVEN').AsDateTime,
                                      fGetDataPagamento(cdsCtaRec),
                                      FieldByName('CTR_VALDUP').AsFloat,
                                      fltJurosAtual,
                                      fltMultaAtual);
      Edit;
      FieldByName('CTR_VALCAL').AsFloat  := recMulJur.fltValorMulta +
                                            recMulJur.fltValorJuros +
                                            FieldByName('CTR_VALDUP').AsFloat +
                                            FieldByName('CTR_DESPCO').AsFloat;
      FieldByName('CTR_VALMUL').AsFloat  := recMulJur.fltValorMulta;
      FieldByName('CTR_VALJUR').AsFloat  := recMulJur.fltValorJuros;

      If (FieldByName('CTR_ESPDOC').AsString <> 'AG') Then
      Begin
        fltValPro := fRetornaTotalPromocaoPorDocumento(LeftStr(FieldByName('CTR_NUMDUP').AsString, fTamDocCadRec),
                                                       FieldByName('CTR_ESPDOC').AsString,
                                                       LeftStr(FieldByName('CTR_CODEMP').AsString, 3),
                                                       FieldByName('CTR_CODCLI').AsString);

      End
      else
      begin
        fltValPro := fRetornaTotalPromocaoAG(LeftStr(FieldByName('CTR_NUMDUP').AsString, fTamDocCadRec),
                                             LeftStr(FieldByName('CTR_CODEMP').AsString, 3),
                                             FieldByName('CTR_CODCLI').AsString);
      end;
      FieldByName('PROMOC').AsString := IIF(fltValPro > 0, 'S', 'N');

      Post;
      Next;
    End;

    EnableControls;
  End;
end;

procedure TfrmAcertoConta.pCalculaTotalDuplicatas(edtValTot, edtValCor,
      edtValDup: TEditFocus; AFiltroDuplicatas: TFiltrosDuplicata = tpfSemFiltro);
  Var
    cdsGen: TUniClientDataSet;
    fldValOri: TAggregateField;
    fldValCor: TAggregateField;
    fldValDup: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);

  fldValOri := TAggregateField.Create(Self);
  With fldValOri Do
  Begin
    FieldName := 'FLDVALORI';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTR_VALORI)';
    Active := True;
  End;

  fldValCor := TAggregateField.Create(Self);
  With fldValCor Do
  Begin
    FieldName := 'FLDVALCOR';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTR_VALCAL)';
    Active := True;
  End;

  fldValDup := TAggregateField.Create(Self);
  With fldValDup Do
  Begin
    FieldName := 'FLDVALDUP';
    DataSet := cdsGen;
    DisplayFormat := '#,##0.00';
    Expression := 'SUM(CTR_VALDUP)';
    Active := True;
  End;

  With cdsGen Do
  Begin
    Data := cdsCtaRec.Data;

    If AFiltroDuplicatas <> tpfSemFiltro Then
    Begin
      Filtered := False;
      Filter   := fRetornaFiltroDuplicatas(AFiltroDuplicatas);
      Filtered := True;
    End;

    AggregatesActive := True;

    edtValTot.Text := FormatFloat('#,##0.00', IIF(fldValOri.Value = Null, 0.00, fldValOri.Value));
    edtValCor.Text := FormatFloat('#,##0.00', IIF(fldValCor.Value = Null, 0.00, fldValCor.Value));
    edtValDup.Text := FormatFloat('#,##0.00', IIF(fldValDup.Value = Null, 0.00, fldValDup.Value));
  End;

  FreeAndNil(fldValOri);
  FreeAndNil(fldValCor);
  FreeAndNil(fldValDup);
  FreeAndNil(cdsGen);
end;

procedure TfrmAcertoConta.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  MarDes: String;
  Promoc, ValCal, ValJur: Variant;
begin
  inherited;
  If (cdsCtaRec.FindField('CTR_MARDES') = Nil) Then
    Exit;

  ValJur := AViewInfo.GridRecord.Values[dbgDuplicatasDBTableView1CTR_VALJUR.Index];
  ValCal := AViewInfo.GridRecord.Values[dbgDuplicatasDBTableView1CTR_VALCAL.Index];
  If (ValCal <> null) and (ValJur <> null) and (VarAsType(ValJur, varDouble) > 0.0) Then
    ACanvas.Font.Color := clRed;

  If ((AViewInfo.Item.Caption = 'Enviado') or (AViewInfo.Item.Caption = 'Impresso')) and (AViewInfo.Text = 'SIM') Then
    ACanvas.Font.Color := clRed;

  MarDes := VarAsType(AViewInfo.GridRecord.Values[dbgDuplicatasDBTableView1CTR_MARDES.Index], varString);
  If MarDes = 'M' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clYellow
    Else
      ACanvas.Font.Color := clBlue;
  End;

  Promoc := AViewInfo.GridRecord.Values[dbgDuplicatasDBTableView1PROMOC.Index];
  If Promoc <> null Then
    if (Promoc = 'S') and (MarDes <> 'M') then
      ACanvas.Font.Color := clTeal;
end;

procedure TfrmAcertoConta.dbgDuplicatasDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmAcertoConta.dbgDuplicatasDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    pSelecionaDuplicata;
end;

{*****************************************}
{* SELECIONA UMA DUPLICATA ABRE A TELA   *}
{* PARA DIGITAÇÃO DE VALORES             *}
{**************************************MV*}
procedure TfrmAcertoConta.pSelecionaDuplicata;
  Var
    frmAceCtaData : TfrmAceCtaData;
begin
  If cdsCtaRec.IsEmpty Then
    Exit;

  cdsCtaRec.AfterScroll := Nil;
  If cdsCtaRec.FieldByName('CTR_MARDES').AsString <> 'M' Then
  Begin
    Try
      pCriarFormularios(TfrmAceCtaData, frmAceCtaData);
      frmAceCtaData.mskDtaPag.Text := DateToStr(IIF(dtaData = 0, VS_Date, dtaData));
      frmAceCtaData.ShowModal;

      If frmAceCtaData.ModalResult = mrOK Then
      Begin
        dtaData := StrToDate(frmAceCtaData.mskDtaPag.Text);
        pMarcaDuplicata(True, DateToStr(dtaData));
        //pCalculaJuros(fltJurosAtual, fltMultaAtual, 'D');
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmAcertoConta.pSelecionaDuplicata]');
    End;

    pFreeAndNil(frmAceCtaData);
  End
  Else
  Begin
    pMarcaDuplicata(False, '');
    //pCalculaJuros(fltJurosAtual, fltMultaAtual, 'D');
  End;

  pCalculaTotalDuplicatas(edtTotalOriPromoc,    edtTotalDupPromoc,    edtTotalCorPromoc,    tpfPromocao);
  pCalculaTotalDuplicatas(edtTotalOriSemPromoc, edtTotalDupSemPromoc, edtTotalCorSemPromoc, tpfSemPromocao);
  pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
  pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);
  cdsCtaRec.AfterScroll := pAfterScroll;
  pSetFocus(Self);
end;

procedure TfrmAcertoConta.Shape1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  inherited;

end;

{*****************************************}
{* MARCA / DESMARCA UMA DUPLICATA        *}
{**************************************AF*}
procedure TfrmAcertoConta.pMarcaDuplicata(blnMarcar: Boolean; strDtaPag: String);
Var
  fltAtraso: Double;
  fltValDup: Double;
  recMulJur: TRecMultaJuros;
  strChaLck: String;
begin
  If blnMarcar Then
  Begin
    If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO','A duplicata não pode ser selecionada pois possui um Pix gerado e ativo!',['OK']);

      Exit;
    End;

    if TValidacoesPagamentoOnline.fAgrupamentoPossuiLinkPagamento(
        cdsCtaRec.FieldByName('NRODUP').AsString,
        cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
        cdsCtaRec.FieldByName('CTR_CODEMP').AsString,
        cdsCtaRec.FieldByName('CTR_CODCLI').AsString) then
    begin
      fMensagem('ATENÇÃO!', 'Não será possível selecionar esta duplicata pois existe link de pagamento! ', ['&O K']);
      Exit;
    end;

  End;

  strChaLck := 'CADREC' +
               cdsCtaRec.FieldByName('NRODUP').AsString +
               cdsCtaRec.FieldByName('CTR_ESPDOC').AsString +
               cdsCtaRec.FieldByName('CTR_CODEMP').AsString +
               cdsCtaRec.FieldByName('CTR_CODCLI').AsString;

  If blnMarcar Then
  Begin
    If (Not fLockedByCurrentConnection(strChaLck)) Then
    Begin
      If Not objLock.fLock_Unlock(strChaLck, True, False) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
        Exit;
      End;
    End;
  End
  Else
  Begin
    objLock.fLock_Unlock(strChaLck, False);
  End;

  With cdsCtaRec Do
  Begin
    fltValDup := FieldByName('CTR_VALDUP').AsFloat;

    Edit;
    FieldByName('CTR_MARDES').AsString := IIF(blnMarcar, 'M', 'D');

    If blnMarcar Then
    begin
      FieldByName('CTR_DTAPAG').AsDateTime := StrToDateTime(strDtaPag);
      fltAtraso := StrToDateTime(strDtaPag) - FieldByName('CTR_DTAVEN').AsDateTime;
    end
    Else
    begin
      FieldByName('CTR_DTAPAG').Value   := Null;
      fltAtraso := VS_Date - FieldByName('CTR_DTAVEN').AsDateTime;
    end;

    recMulJur := fCalculaMultaJuros(FieldByName('CTR_DTAVEN').AsDateTime,
                                    fGetDataPagamento(cdsCtaRec),
                                    FieldByName('CTR_VALDUP').AsFloat,
                                    fltJurosAtual,
                                    fltMultaAtual);

    FieldByName('CTR_VALDES').AsFloat  := 0.0;
    FieldByName('CTR_VALMUL').AsFloat  := recMulJur.fltValorMulta;
    FieldByName('CTR_VALJUR').AsFloat  := recMulJur.fltValorJuros;
    FieldByName('CTR_ATRASO').AsFloat := IIF(fltAtraso < 0, 0, fltAtraso);
    FieldByName('CTR_VALCAL').AsFloat  := fltValDup +
                                          recMulJur.fltValorMulta +
                                          recMulJur.fltValorJuros +
                                          FieldByName('CTR_DESPCO').AsFloat;
    Post;
  End;
end;

procedure TfrmAcertoConta.pMarcaTodas;
var
  intRecNo: Integer;
  frmAceCtaData : TfrmAceCtaData;

  LDuplicataPixGerado: Boolean;
begin
  If cdsCtaRec.IsEmpty Then
    Exit;

  LDuplicataPixGerado := False;

  intRecNo := cdsCtaRec.RecNo;
  cdsCtaRec.AfterScroll := Nil;
  Try
    cdsCtaRec.DisableControls;
    pCriarFormularios(TfrmAceCtaData, frmAceCtaData);
    frmAceCtaData.mskDtaPag.Text := DateToStr(IIF(dtaData = 0, VS_Date, dtaData));
    frmAceCtaData.ShowModal;

    If frmAceCtaData.ModalResult = mrOK Then
    Begin
      dtaData := StrToDate(frmAceCtaData.mskDtaPag.Text);
      cdsCtaRec.First;
      While Not cdsCtaRec.Eof Do
      Begin
        If Not cdsCtaRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
        Begin
          LDuplicataPixGerado := True;

          cdsCtaRec.Next;
          Continue;
        End;

        pMarcaDuplicata(True, DateToStr(dtaData));
        pCalculaJuros(fltJurosAtual, fltMultaAtual, 'D');
        cdsCtaRec.Next;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmAcertoConta.btnMarcarClick]');
  End;

  cdsCtaRec.RecNo := intRecNo;
  pFreeAndNil(frmAceCtaData);
  cdsCtaRec.EnableControls;

  If LDuplicataPixGerado Then
    fMensagem('ATENÇÃO!', 'Alguns documentos não foram selecionados pois possuem Pix gerados e ativos.', ['&Ok']);

  pCalculaTotalDuplicatas(edtTotalOriPromoc,    edtTotalDupPromoc,    edtTotalCorPromoc,    tpfPromocao);
  pCalculaTotalDuplicatas(edtTotalOriSemPromoc, edtTotalDupSemPromoc, edtTotalCorSemPromoc, tpfSemPromocao);
  pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
  pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);

  cdsCtaRec.AfterScroll := pAfterScroll;
end;

procedure TfrmAcertoConta.pCalculaDespCobranca(fltDespCob: Double; strAplDesp: String);
  Var
    intRecNo: Integer;
begin
  With cdsCtaRec Do
  Begin
    AfterScroll := Nil;
    If strAplDesp = 'D' Then
    Begin
      Try
        If FieldByName('CTR_VALDUP').AsFloat > 0 Then
        Begin
          Edit;
          FieldByName('CTR_VALCAL').AsFloat  := FieldByName('CTR_VALCAL').AsFloat -
                                                FieldByName('CTR_DESPCO').AsFloat;

          FieldByName('CTR_DESPCO').AsFloat  := fltDespCob;

          FieldByName('CTR_VALCAL').AsFloat  := FieldByName('CTR_VALCAL').AsFloat +
                                                FieldByName('CTR_DESPCO').AsFloat;
          Post;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmAcertoConta.pCalculaDespCobranca]');
      End;
    End
    Else
    Begin
      intRecNo := 0;

      Try
        DisableControls;
        intRecNo := RecNo;

        First;
        While Not Eof Do
        Begin
          If FieldByName('CTR_VALDUP').AsFloat > 0 Then
          Begin
            Edit;
            FieldByName('CTR_VALCAL').AsFloat  := FieldByName('CTR_VALCAL').AsFloat -
                                                  FieldByName('CTR_DESPCO').AsFloat;

            FieldByName('CTR_DESPCO').AsFloat  := fltDespCob;

            FieldByName('CTR_VALCAL').AsFloat  := FieldByName('CTR_VALCAL').AsFloat +
                                                  FieldByName('CTR_DESPCO').AsFloat;
            Post;
          End;

          Application.ProcessMessages;
          Next;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmAcertoConta.pCalculaDespCobranca]');
      End;

      RecNo := intRecNo;
      EnableControls;
    End;
    AfterScroll := pAfterScroll;
  End;
end;

procedure TfrmAcertoConta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  objLock.pDestravarTodos;
end;

procedure TfrmAcertoConta.FormCreate(Sender: TObject);
begin
  inherited;
  blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  cdsCtaRec := TUniClientDataSet.Create(Self);
  dtsCtaRec := fCriaDataSource(cdsCtaRec);
  dbgDuplicatasDBTableView1.DataController.DataSource := dtsCtaRec;
  cdsCtaRec.AfterScroll := pAfterScroll;
  btnProdutos.Glyph := nil;
  img_f7.GetBitmap(0,btnProdutos.Glyph);

  fltJurosAtual := fCfgSis('JURATR', varDouble);
  fltMultaAtual := fCfgSis('MULATR', varDouble);
  objLock := TLock.Create;
end;

procedure TfrmAcertoConta.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objLock) Then
    FreeAndNil(objLock);
end;

procedure TfrmAcertoConta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    pLimparTela

  Else If ((Key = VK_F9) And (Shift = [ssAlt])) Then
  Begin
    If (btnFormaPagto.Visible And btnFormaPagto.Enabled) Then
      btnFormaPagto.Click;
  End

  Else If ((Key = VK_F12) And (Shift = [ssAlt])) And (btnAntecRecebiveis.enabled) Then
          btnAntecRecebiveis.Click

  Else If (Key = VK_F4) And cdsCtaRec.Active Then
    btnMarcar.Click

  Else If (Key = VK_F5) And cdsCtaRec.Active Then
    btnDesmarcar.Click

  Else If (Key = VK_F6) And cdsCtaRec.Active Then
    btnEmail.Click

  Else If (Key = VK_F7) And cdsCtaRec.Active Then
    btnProdutos.Click

  Else If (Key = VK_F9) And btnDespCobranca.Enabled Then
    btnDespCobranca.Click

  Else If (Key = VK_F10) And btnImprimir.Enabled Then
    btnImprimir.Click

  Else If (Key = VK_F8) And btnRecalculaJuros.Enabled Then
    btnRecalculaJuros.Click

  Else If (Key = VK_F12) AND btnRenegociacao.Enabled then
    btnRenegociacao.Click

  Else If (Key = VK_F3) and btnInfObranca.Enabled then
    btnInfObranca.Click

  Else If (Key = VK_F11) And btnNegVencto.Enabled And btnNegVencto.Visible Then
    btnNegVencto.Click

  Else If (Key = VK_F2) And btnAlteraPagamento.Enabled Then
    btnAlteraPagamento.Click;

end;

procedure TfrmAcertoConta.FormResize(Sender: TObject);
begin
  inherited;
  pReajustarBotoesRodape;
end;

procedure TfrmAcertoConta.FormShow(Sender: TObject);
begin
  inherited;
  btnFormaPagto.Visible := (fCfgSis('BTNACE', varInteger) = 1);
  btnNegVencto.Visible := Not btnFormaPagto.Visible;
  BtnAntecRecebiveis.visible := (fCfgSis('CTRARC') = 'S');

  pReajustaPanelDosBotoes;
  pReajustarBotoesRodape;
  pSetFocus(edtCodCli);
end;

procedure TfrmAcertoConta.pAfterScroll(DataSet: TDataSet);
begin
  If DataSet.Active Then
  Begin

    edtCodPorBai.Text := DataSet.FieldByName('POR_NOMPOR').AsString;
    edtNosNumBai.Text := DataSet.FieldByName('CTR_NOSNUM').AsString;
    edtHistor.Text    := AnsiReplaceStr(DataSet.FieldByName('CTR_HIST01').AsString, '<<csq>>', #13#10);

  End;

  If (Not DataSet.IsEmpty) And
     (DataSet.FieldByName('CTR_ESPDOC').AsString = 'AG') Then
  begin
    btnProdutos.Caption := '[ F7 ] - Dupli. Agrup.';
    btnProdutos.Glyph := nil;
    img_f7.GetBitmap(1,btnProdutos.Glyph);
  end
  Else
  begin
    btnProdutos.Caption := '[ F7 ] - Produtos';
    btnProdutos.Glyph := nil;
    img_f7.GetBitmap(0,btnProdutos.Glyph);
  end;

end;

procedure TfrmAcertoConta.pAlteraDtaPagamento(dtaDtaPag: TDateTime; strAplicaDta: String);
var
  intRecNo: Integer;
  recMulJur: TRecMultaJuros;
  fltValDup: Double;
begin
  With cdsCtaRec Do
  Begin
    AfterScroll := Nil;
    If strAplicaDta = 'A' Then
    Begin

      Try
        if FieldByName('CTR_MARDES').AsString = 'M' then
        begin
          Edit;
          fltValDup := FieldByName('CTR_VALDUP').AsFloat;

          FieldByName('CTR_DTAPAG').AsDateTime := dtaDtaPag;

          recMulJur := fCalculaMultaJuros(FieldByName('CTR_DTAVEN').AsDateTime,
                                          dtaDtaPag,
                                          FieldByName('CTR_VALDUP').AsFloat,
                                          fltJurosAtual,
                                          fltMultaAtual);

          FieldByName('CTR_VALDES').AsFloat  := 0.0;
          FieldByName('CTR_VALMUL').AsFloat  := recMulJur.fltValorMulta;
          FieldByName('CTR_VALJUR').AsFloat  := recMulJur.fltValorJuros;
          FieldByName('CTR_VALCAL').AsFloat  := fltValDup +
                                                recMulJur.fltValorMulta +
                                                recMulJur.fltValorJuros +
                                                FieldByName('CTR_DESPCO').AsFloat;
          Post;
        end;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmAcertoConta.pCalculaDespCobranca]');
      End;
    End
    Else
    Begin
      intRecNo := 0;

      Try
        DisableControls;
        intRecNo := RecNo;

        First;
        While Not Eof Do
        Begin
          if FieldByName('CTR_MARDES').AsString = 'M' then
          begin
            Edit;
            fltValDup := FieldByName('CTR_VALDUP').AsFloat;

            FieldByName('CTR_DTAPAG').AsDateTime := dtaDtaPag;

            recMulJur := fCalculaMultaJuros(FieldByName('CTR_DTAVEN').AsDateTime,
                                            dtaDtaPag,
                                            FieldByName('CTR_VALDUP').AsFloat,
                                            fltJurosAtual,
                                            fltMultaAtual);

            FieldByName('CTR_VALDES').AsFloat  := 0.0;
            FieldByName('CTR_VALMUL').AsFloat  := recMulJur.fltValorMulta;
            FieldByName('CTR_VALJUR').AsFloat  := recMulJur.fltValorJuros;
            FieldByName('CTR_VALCAL').AsFloat  := fltValDup +
                                                  recMulJur.fltValorMulta +
                                                  recMulJur.fltValorJuros +
                                                  FieldByName('CTR_DESPCO').AsFloat;
            Post;
          end;

          Application.ProcessMessages;
          Next;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmAcertoConta.pAlteraDtaPagamento]');
      End;

      RecNo := intRecNo;
      EnableControls;
    End;
    AfterScroll := pAfterScroll;
  End;
end;

procedure TfrmAcertoConta.pCalculaDiasAtraso;
  Var
    fltAtraso : Double;
begin

  With cdsCtaRec Do
  Begin
    DisableControls;

    Filtered := False;
    Filter   := 'CTR_DTAVEN < ' + QuotedStr(FormatDateTime('yyyy-mm-dd', VS_Date));
    Filtered := True;

    First;

    While Not Eof Do
    Begin
      If (FieldByName('CTR_DTAPAG').IsNull) Or (FieldByName('CTR_DTAPAG').AsDateTime = 0) Then
        fltAtraso := VS_Date - FieldByName('CTR_DTAVEN').AsDateTime
      Else
        fltAtraso := FieldByName('CTR_DTAPAG').AsDateTime - FieldByName('CTR_DTAVEN').AsDateTime;

      Edit;

      FieldByName('CTR_ATRASO').AsFloat := fltAtraso;

      Post;

      Next;
    End;

    Filtered := False;

    EnableControls;
  End;

end;

procedure TfrmAcertoConta.pCalculaJuros(fltPerJur, fltPerMul: Double; strAplJur: String);
  Var
    recMulJur: TRecMultaJuros;
    intRecNo: Integer;
    strIdxFld: String;
begin
  With cdsCtaRec Do
  Begin
    If strAplJur = 'D' Then
    Begin
      {***************************************}
      {* CALCULA JUROS PARA O REGISTRO ATUAL *}
      {************************************AN*}
      Try
{        If (FieldByName('CTR_DTAPAG').IsNull) Or (FieldByName('CTR_DTAPAG').AsDateTime = 0) Then
        Begin
          fltValCor := fCalculaJurosAcert(FieldByName('CTR_DTAVEN').AsDateTime,
                                          VS_Date,
                                          FieldByName('CTR_VALDUP').AsFloat,
                                          fltPerJur,
                                          fltPerMul);
        End
        Else
        Begin
          fltValCor := fCalculaJurosAcert(FieldByName('CTR_DTAVEN').AsDateTime,
                                          FieldByName('CTR_DTAPAG').AsDateTime,
                                          FieldByName('CTR_VALDUP').AsFloat,
                                          fltPerJur,
                                          fltPerMul);
        End;}

        recMulJur := fCalculaMultaJuros(FieldByName('CTR_DTAVEN').AsDateTime,
                                        fGetDataPagamento(cdsCtaRec),
                                        FieldByName('CTR_VALDUP').AsFloat,
                                        fltPerJur,
                                        fltPerMul);

        {*******************************************}
        {* VALOR CALCULADO                         *}
        {****************************************MV*}
        Edit;
        FieldByName('CTR_VALMUL').AsFloat  := recMulJur.fltValorMulta;
        FieldByName('CTR_VALJUR').AsFloat  := recMulJur.fltValorJuros;
        FieldByName('CTR_VALCAL').AsFloat  := FieldByName('CTR_VALDUP').AsFloat +
                                              recMulJur.fltValorMulta +
                                              recMulJur.fltValorJuros +
                                              FieldByName('CTR_DESPCO').AsFloat;
        Post;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmAcertoConta.pCalculaJuros]');
      End;
    End
    Else
    Begin
      {**************************************}
      {* CALCULA JUROS PARA TODOS REGISTROS *}
      {***********************************AN*}
      intRecNo := 0;

      Try
        AfterScroll := Nil;
        DisableControls;
        intRecNo := RecNo;
        strIdxFld := IndexFieldNames;

        {* ORDENAR POR CLIENTE E VENCIMENTO *}
        IndexFieldNames := 'CTR_NOMCLI;CTR_DTAVEN';

        First;
        While Not Eof Do
        Begin
          {If (FieldByName('CTR_DTAPAG').IsNull) Or (FieldByName('CTR_DTAPAG').AsDateTime = 0) Then
          Begin
            fltValCor := fCalculaJurosAcert(FieldByName('CTR_DTAVEN').AsDateTime,
                                            VS_Date,
                                            FieldByName('CTR_VALDUP').AsFloat,
                                            fltPerJur,
                                            fltPerMul);
          End
          Else
          Begin
            fltValCor := fCalculaJurosAcert(FieldByName('CTR_DTAVEN').AsDateTime,
                                            FieldByName('CTR_DTAPAG').AsDateTime,
                                            FieldByName('CTR_VALDUP').AsFloat,
                                            fltPerJur,
                                            fltPerMul);
          End; }

          recMulJur := fCalculaMultaJuros(FieldByName('CTR_DTAVEN').AsDateTime,
                                          fGetDataPagamento(cdsCtaRec),
                                          FieldByName('CTR_VALDUP').AsFloat,
                                          fltPerJur,
                                          fltPerMul);

          {*******************************************}
          {* VALOR CALCULADO                         *}
          {****************************************MV*}
          Edit;
          FieldByName('CTR_VALMUL').AsFloat  := recMulJur.fltValorMulta;
          FieldByName('CTR_VALJUR').AsFloat  := recMulJur.fltValorJuros;
          FieldByName('CTR_VALCAL').AsFloat  := FieldByName('CTR_VALDUP').AsFloat +
                                                recMulJur.fltValorMulta +
                                                recMulJur.fltValorJuros +
                                                FieldByName('CTR_DESPCO').AsFloat;
          Post;

          Application.ProcessMessages;
          Next;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmAcertoConta.pCalculaJuros]');
      End;

      IndexFieldNames := strIdxFld;
      RecNo := intRecNo;
      EnableControls;
      AfterScroll := pAfterScroll;
    End;
  End;
end;

procedure TfrmAcertoConta.pRecalculaJuros;
Var
  blnConfirma: Boolean;
  fltPerJur  : Double;
  fltPerMul  : Double;
  strAplJur  : String;
  frmCtrRecalculoJuros : TfrmCtrRecalculoJuros;
begin
  fltPerJur     := 0.0;
  fltPerMul     := 0.0;
  Screen.Cursor := crHourGlass;
  cdsCtaRec.AfterScroll := Nil;

  blnConfirma := False;

  Try
    pCriarFormularios(TfrmCtrRecalculoJuros, frmCtrRecalculoJuros);
    frmCtrRecalculoJuros.blnPerMulta    := True;
    frmCtrRecalculoJuros.edtPerJur.Text := FloatToStrF(fltJurosAtual,ffFixed,12,2);
    frmCtrRecalculoJuros.edtPerMul.Text := FloatToStrF(fltMultaAtual,ffFixed,12,2);
    frmCtrRecalculoJuros.ShowModal;

    blnConfirma :=  frmCtrRecalculoJuros.blnConfirma;
    If blnConfirma Then
    Begin
      fltPerJur := fStrToFloat(frmCtrRecalculoJuros.edtPerJur.Text);
      fltPerMul := fStrToFloat(frmCtrRecalculoJuros.edtPerMul.Text);
      strAplJur := frmCtrRecalculoJuros.edtAplJur.Text;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmAcertoConta.pRecalculaJuros]');
    End;
  End;

  pFreeAndNil(frmCtrRecalculoJuros);

  Try
    If (blnConfirma) Then
    Begin

      If (strAplJur = 'T') And (fStrToFloat(edtTotalCorrigido.Text) > 0) Then
      Begin
        fMensagem('', 'Para efetuar o recalculo do juros, nenhuma duplicata pode estar selecionada!', ['&Ok']);
        Screen.Cursor := crDefault;
        Exit;
      End
      Else If (strAplJur = 'D')                                                     And
              (cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M') Then
      Begin
        fMensagem('', 'Para efetuar o recalculo do juros a duplicata não pode estar selecionada!', ['&Ok']);
        Screen.Cursor := crDefault;
        Exit;
      End;

      pCalculaJuros(fltPerJur, fltPerMul, strAplJur);
      
      fltJurosAtual := fltPerJur;
      fltMultaAtual := fltPerMul;

      pCalculaTotalDuplicatas(edtTotalOriPromoc,    edtTotalDupPromoc,    edtTotalCorPromoc,    tpfPromocao);
      pCalculaTotalDuplicatas(edtTotalOriSemPromoc, edtTotalDupSemPromoc, edtTotalCorSemPromoc, tpfSemPromocao);
      pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
      pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);
    End;

  Finally
    Screen.Cursor := crDefault;
    cdsCtaRec.AfterScroll := pAfterScroll;
  End;

end;

procedure TfrmAcertoConta.btnRecalculaJurosClick(Sender: TObject);
begin
  inherited;
  If Not cdsCtaRec.IsEmpty Then
    TfrmGravando.fExecutarModal(pRecalculaJuros, 'Aguarde... Recalculando Juros...', '');
end;

procedure TfrmAcertoConta.btnReNegociacaoClick(Sender: TObject);
  Var
    arrDocumentos: TDocumentosArray;
    intRecNo: Integer;
    strCaixa: String;
    blnSen12: Boolean;
    frmAgrupDuplicatas: TfrmAgrupDuplicatas;
    LValidaCliente : Boolean;
begin
  inherited;

  If cdsCtaRec.IsEmpty Then
    Exit;

  If Not fValidaDuplics(LValidaCliente) Then
  Begin
    If Not LValidaCliente Then
    Begin
      pMensagemOk('Há seleção de duplicatas de clientes diferentes, ' +
                  'portanto não será possível realizar a renegociação!');
    End
    Else
    Begin
      pMensagemOk('Há duplicatas enviadas para o banco ou com boletos impressos selecionados, ' +
                  'portanto não é possível realizar a renegociação! Favor desmarcar estes registros!');
    End;
    Exit;
  End;

  With cdsCtaRec Do
  Begin
    AfterScroll := Nil;
    DisableControls;

    intRecNo := RecNo;

    Filtered := False;
    Filter := 'CTR_MARDES = ' + QuotedStr('M');
    Filtered := True;

    First;

    If IsEmpty Then
    Begin
      pMensagemOk('Favor selecionar alguma duplicata para realizar a operação!');

      Filtered := False;
      RecNo := intRecNo;
      EnableControls;
      AfterScroll := pAfterScroll;
      Exit;
    End;

    blnSen12 := False;
    strCaixa := FieldByName('CTR_IDENTI').AsString;
    While Not Eof Do
    Begin
      If Not SameText(strCaixa, FieldByName('CTR_IDENTI').AsString) Then
      Begin
        blnSen12 := True;
        Break;
      End;

      SetLength(arrDocumentos, Length(arrDocumentos)+1);

      arrDocumentos[Length(arrDocumentos)-1].strNumDup := FieldByName('NRODUP').AsString;
      arrDocumentos[Length(arrDocumentos)-1].strEspDoc := FieldByName('CTR_ESPDOC').AsString;
      arrDocumentos[Length(arrDocumentos)-1].strParcel := FieldByName('PARDUP').AsString;
      arrDocumentos[Length(arrDocumentos)-1].strCodEmp := FieldByName('CTR_CODEMP').AsString;
      arrDocumentos[Length(arrDocumentos)-1].strCodCli := FieldByName('CTR_CODCLI').AsString;
      arrDocumentos[Length(arrDocumentos)-1].fltValJur := FieldByName('CTR_VALJUR').AsFloat;
      arrDocumentos[Length(arrDocumentos)-1].fltValMul := FieldByName('CTR_VALMUL').AsFloat;
      arrDocumentos[Length(arrDocumentos)-1].fltValCor := FieldByName('CTR_VALCAL').AsFloat;

      Next;
    End;

    Filtered := False;
    RecNo := intRecNo;
    EnableControls;
    AfterScroll := pAfterScroll;

    If blnSen12 Then
    Begin
      pMensagemOk('Não é possível fazer renegociação com documentos da senha principal e auxiliar juntos!');
      Exit;
    End;

    IF Length(arrDocumentos) > 0 Then
    Begin
      Try
        pCriarFormularios(TfrmAgrupDuplicatas, frmAgrupDuplicatas);
        frmAgrupDuplicatas.arrDocumentos := arrDocumentos;
        frmAgrupDuplicatas.btnRegraAgrup.Left  := frmAgrupDuplicatas.btnConfirma.Left;
        frmAgrupDuplicatas.btnConfigurar.Left  := frmAgrupDuplicatas.btnDesmarca.Left;
        frmAgrupDuplicatas.btnConfirma.Left    := frmAgrupDuplicatas.btnMarca.Left;
        frmAgrupDuplicatas.btnMarca.Visible    := False;
        frmAgrupDuplicatas.btnDesmarca.Visible := False;
        frmAgrupDuplicatas.intCx               := strToInt(strCaixa);
        frmAgrupDuplicatas.AFormVeio           := 'ACERTO';
        objLock.pDestravarTodos;
        frmAgrupDuplicatas.ShowModal;

        TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Carregando Duplicatas...', '');

      Except
        On E: Exception Do
          pMensagemOk(E.Message);
      End;
      FreeAndNil(frmAgrupDuplicatas);
    End;

  End;

end;

procedure TfrmAcertoConta.edtCodCliExit(Sender: TObject);
begin
  inherited;
    pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmAcertoConta.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAcertoConta.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed,edtDesRed,arrRede,nil,fRetNomeRedeLoja,'da rede', 5);
end;

procedure TfrmAcertoConta.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAcertoConta.fGetDataPagamento(cdsDup: TDataSet): Double;
begin
  If (cdsDup.FieldByName('CTR_DTAPAG').IsNull) Or
     (cdsDup.FieldByName('CTR_DTAPAG').AsDateTime = 0) Then
    Result := VS_Date
  Else
    Result := cdsDup.FieldByName('CTR_DTAPAG').AsDateTime;
end;

function TfrmAcertoConta.fLockedByCurrentConnection(strChaLck: String): Boolean;
begin
  Result := (fGetIdConnectionLock(strChaLck) = fGetConnectionID) And
            (fGetIPConnectionLock(strChaLck) = GetIPAddressAsString);
end;

procedure TfrmAcertoConta.btnInfObrancaClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmInfCobranca);
end;

procedure TfrmAcertoConta.btnAlteraPagamentoClick(Sender: TObject);
var
  strAplDtaPag: String;
  frmAceCtaData : TfrmAceCtaData;
begin
  inherited;
  If fStrToFloat(edtTotalCorrigido.Text) = 0 Then
  Begin
    pMensagemOk('Para alterar a data de pagamento a duplicata deve estar selecionada!');
    Exit;
  End;

  if dtaData = 0 then
    dtaData := VS_Date;

  Try
    pCriarFormularios(TfrmAceCtaData, frmAceCtaData);
    frmAceCtaData.mskDtaPag.Text := DateToStr(dtaData);
    frmAceCtaData.blnAlteraPag   := True;
    frmAceCtaData.ShowModal;

    If frmAceCtaData.ModalResult = mrOK Then
    Begin
      dtaData := StrToDate(frmAceCtaData.mskDtaPag.Text);
      strAplDtaPag := frmAceCtaData.edtAlteraDtaPag.Text;
      pAlteraDtaPagamento(dtaData, strAplDtaPag);
    End;
    pFreeAndNil(frmAceCtaData);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmAcertoConta.btnAlteraPagamento]');
  end;

  pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
  pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);
  pSetFocus(Self);
end;

procedure TfrmAcertoConta.BtnAntecRecebiveisClick(Sender: TObject);
  Var
    intRecNo: Integer;
    frmBaixaReceber : TfrmBaixaReceber;
    LValidaCliente : Boolean;
begin
  inherited;

  If Not fValidaDuplics(LValidaCliente,True) Then
  Begin
    pMensagemOk('Há seleção de duplicatas de clientes diferentes, ' +
                'portanto não será possível realizar a Antecipação de Recebíveis!');
    Exit;
  End;

  If fEmptyStr(fCfgSis('CTRPAR')) Then
  Begin
     pMensagemOk('É necessário configurar o sistema para utilizar esta rotina!');
     Exit;
  End;

  If fCfgSis('PRCATR', varDouble) = 0 Then
  Begin
     pMensagemOk('O percentual utilizado para o cálculo não está configurado !');
     Exit;
  End;

  If Not cdsCtaRec.Active Then
  Begin
     pMensagemOk('Favor selecionar alguma duplicata para realizar a operação!');
     Exit;
  End;

  With cdsCtaRec Do
  Begin
    AfterScroll := Nil;
    DisableControls;
    intRecNo := RecNo;

    Filtered := False;
    Filter := 'CTR_MARDES = ' + QuotedStr('M');
    Filtered := True;

    First;

    If IsEmpty Then
    Begin
      pMensagemOk('Favor selecionar alguma duplicata para realizar a operação!');

      Filtered := False;
      RecNo := intRecNo;
      EnableControls;
      AfterScroll := pAfterScroll;
      Exit;
    End;
    Filtered := False;
    RecNo := intRecNo;
    EnableControls;
    AfterScroll := pAfterScroll;
  End;

  If Not fVerificaDataPagamentoDups Then
  Begin
     pMensagemOk('Para esse procedimento as datas de pagamento devem ser a iguais!');
     Exit;
  End;

  Try
    pCriarFormularios(TfrmCtrAntecipacaoRecebiveis, frmCtrAntecipacaoRecebiveis);
    frmCtrAntecipacaoRecebiveis.cdsCtaRecDups    := cdsCtaRec;
    frmCtrAntecipacaoRecebiveis.flTotalDups      := fStrToFloat(edtTotalDuplicata.Text);
    frmCtrAntecipacaoRecebiveis.StrCliente       := edtCodcli.Text;
    frmCtrAntecipacaoRecebiveis.ShowModal;

    If frmCtrAntecipacaoRecebiveis.blnGravou then
    Begin
       If fMensagem('ATENÇÃO', 'Deseja baixar as duplicatas geradas agora ?', ['Sim', 'Não']) = 1 Then
       Begin
          pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);
          frmBaixaReceber.strDupsGeradasAntec := frmCtrAntecipacaoRecebiveis.strDupsGeradas;
          frmBaixaReceber.ShowModal;
          pFreeAndNil(frmBaixaReceber);
       End;

    End;
    TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Carregando Duplicatas...', '');

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmCtrAntecipacaoRecebiveis);

end;

procedure TfrmAcertoConta.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodcli.Text) And fEmptyStr(edtCodRed.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O campo Cliente e/ou Rede de Lojas devem ser preenchidos!', ['&O k']);
    pSetFocus(edtCodCli);
    Exit;
  End;

  if fValidaCampos(edtCodCli, True) And fValidaCampos(mskDtaFin, True) then
  begin
    TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Carregando Duplicatas...', '');
  if cdsCtaRec.isEmpty then
    pSetFocus(edtCodCli)
  else
    pSetFocus(dbgDuplicatas);
  end;
end;

procedure TfrmAcertoConta.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pDesmarcaTodas, 'Aguarde... Carregando Duplicatas...', '');
end;

procedure TfrmAcertoConta.btnEmailClick(Sender: TObject);
begin
  inherited;
  if Not cdsCtaRec.IsEmpty then
    pImprimir(True);
end;

procedure TfrmAcertoConta.btnFormaPagtoClick(Sender: TObject);
  Var
    fltDias: Double;
    intRecNo: Integer;
    frmDigCndPagamento : TfrmDigCndPagamento;
begin
  inherited;
  Try
    pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
    frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Visible := False;
    frmDigCndPagamento.Height := frmDigCndPagamento.Height - frmDigCndPagamento.fraDigCndPagamento.pnlForPag.Height;
    frmDigCndPagamento.showModal;
    If frmDigCndPagamento.fraDigCndPagamento.blnConfirma Then
    Begin
      strConPag := frmDigCndPagamento.fraDigCndPagamento.strCndPag;
      fltDias := fCalcMediaPagto(strConPag);

      With cdsCtaRec Do
      Begin
        DisableControls;
        intRecNo := RecNo;

        Filtered := False;
        Filter := 'CTR_MARDES = ' + QuotedStr('M');
        Filtered := True;

        First;
        While Not Eof Do
        Begin
          Edit;
          FieldByName('CTR_DTAPAG').AsDateTime   := VS_Date + fltDias;
          //FieldByName('CTR_MARDES').AsString := 'M';
          Post;
          Next;
        End;

        Filtered := False;

        RecNo := intRecNo;

        EnableControls;
      End;

      pCalculaJuros(fltJurosAtual, fltMultaAtual, 'T');
      pCalculaTotalDuplicatas(edtTotalOriPromoc,    edtTotalDupPromoc,    edtTotalCorPromoc,    tpfPromocao);
      pCalculaTotalDuplicatas(edtTotalOriSemPromoc, edtTotalDupSemPromoc, edtTotalCorSemPromoc, tpfSemPromocao);
      pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
      pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);
    End;
  Except
    On E: Exception Do
    Begin
      cdsCtaRec.EnableControls;
      pMensagensErro(E.Message, '[frmAcertoConta.btnFormaPagtoClick]');
    End;
  End;

  pFreeAndNil(frmDigCndPagamento);
  pSetFocus(dbgDuplicatas);
end;

procedure TfrmAcertoConta.btnDespCobrancaClick(Sender: TObject);
{  Var
    fltDias: Double;
    intRecNo: Integer;}
begin
  inherited;
  If Not cdsCtaRec.IsEmpty Then
    pDespesaCobranca;
{  inherited;
  Try
    pCriarFormularios(TfrmDigCndPagamento, frmDigCndPagamento);
    frmDigCndPagamento.pnlForPag.Visible := False;
    frmDigCndPagamento.Height := frmDigCndPagamento.Height - frmDigCndPagamento.pnlForPag.Height;
    frmDigCndPagamento.showModal;
    If frmDigCndPagamento.blnConfirma Then
    Begin
      strConPag := frmDigCndPagamento.strCndPag;
      fltDias := fCalcMediaPagto(strConPag);

      With cdsCtaRec Do
      Begin
        DisableControls;
        intRecNo := RecNo;

        Filtered := False;
        Filter := 'CTR_MARDES = ' + QuotedStr('M');
        Filtered := True;

        First;
        While Not Eof Do
        Begin
          Edit;
          FieldByName('CTR_DTAPAG').AsDateTime   := VS_Date + fltDias;
          //FieldByName('CTR_MARDES').AsString := 'M';
          Post;
          Next;
        End;

        Filtered := False;

        RecNo := intRecNo;

        EnableControls;
      End;

      pCalculaJuros(fltJurosAtual, fltMultaAtual, 'T');
      pCalculaTotalDuplicatas(edtTotalOriPromoc,    edtTotalDupPromoc,    edtTotalCorPromoc,    tpfPromocao);
      pCalculaTotalDuplicatas(edtTotalOriSemPromoc, edtTotalDupSemPromoc, edtTotalCorSemPromoc, tpfSemPromocao);
      pCalculaTotalDuplicatas(edtTotalOriginalGer,  edtTotalCorrigidoGer, edtTotalDuplicataGer, tpfSemFiltro);
      pCalculaTotalDuplicatas(edtTotalOriginal,     edtTotalCorrigido,    edtTotalDuplicata,    tpfMarcados);
    End;
  Except
    On E: Exception Do
    Begin
      cdsCtaRec.EnableControls;
      pMensagensErro(E.Message, '[frmAcertoConta.btnFormaPagtoClick]');
    End;
  End;

  pFreeAndNil(frmDigCndPagamento);
  pSetFocus(dbgDuplicatas); }
end;

procedure TfrmAcertoConta.btnImprimirClick(Sender: TObject);
begin
  pImprimir;
end;

procedure TfrmAcertoConta.btnMarcarClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pMarcaTodas, 'Aguarde... Carregando Duplicatas...', '');
end;

procedure TfrmAcertoConta.btnNegVenctoClick(Sender: TObject);
begin
  inherited;
  If fStrToFloat(edtTotalCorrigido.Text) = 0 Then
  Begin
    pMensagemOk('Valor total selecionado deve ser maior que zero!');
    Exit;
  End;

 { If Not fValidaDuplics Then
  Begin
    pMensagemOk('Há duplicatas enviadas para o banco ou com boletos impressos selecionados, ' +
                'portanto não é possível realizar a renegociação! Favor desmarcar estes registros!');
    Exit;
  End;  }

  TfrmGravando.fExecutarModalA(pNegociacaoVencimentos,'Aguarde, Realizando negociação...', '');
end;

procedure TfrmAcertoConta.pNegociacaoVencimentos;
  Var
    documento: TDocAgrupamento;
    objParcelamento: TParcelamento;
    LValidaCliente : Boolean;
    LRecNo : Integer;
begin
  LRecNo := cdsCtaRec.RecNo;
  Try

    Try
      objParcelamento := TParcelamento.Create;

      objParcelamento.dtaDataBase  := IIF(dtaData = 0, VS_Date, dtaData);
      objParcelamento.fltValorCorrigido := fStrToFloat(edtTotalCorrigido.Text);
      objParcelamento.blnSimulacao := (Not fValidaDuplics(LValidaCliente));
      objParcelamento.cdsCadRec.Data :=  cdsCtaRec.Data;

      objParcelamento.cdsCadRec.Filtered := False;
      objParcelamento.cdsCadRec.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
      objParcelamento.cdsCadRec.Filtered := True;

      objParcelamento.objLock :=  objLock;

      cdsCtaRec.AfterScroll := nil;
      cdsCtaRec.DisableControls;
      cdsCtaRec.First;

      While Not cdsCtaRec.Eof Do
      Begin

        If cdsCtaRec.FieldByName('CTR_MARDES').AsString = 'M' Then
        Begin
          documento.strNumDoc := cdsCtaRec.FieldByName('NRODUP').AsString;
          documento.strParcel := cdsCtaRec.FieldByName('PARDUP').AsString;
          documento.strEspDoc := cdsCtaRec.FieldByName('CTR_ESPDOC').AsString;
          documento.strCodEmp := cdsCtaRec.FieldByName('CTR_CODEMP').AsString;
          documento.strCodCli := cdsCtaRec.FieldByName('CTR_CODCLI').AsString;
          documento.dtaDtaVen := cdsCtaRec.FieldByName('CTR_DTAVEN').AsDateTime;
          documento.dtaDtaPag := cdsCtaRec.FieldByName('CTR_DTAPAG').AsDateTime;
          documento.fltValOri := cdsCtaRec.FieldByName('CTR_VALDUP').AsFloat;
          documento.fltValMul := cdsCtaRec.FieldByName('CTR_VALMUL').AsFloat;
          documento.fltValJur := cdsCtaRec.FieldByName('CTR_VALJUR').AsFloat;
          documento.fltDesCob := cdsCtaRec.FieldByName('CTR_DESPCO').AsFloat;
          documento.fltValCor := cdsCtaRec.FieldByName('CTR_VALCAL').AsFloat;
          documento.intDiaAtr := cdsCtaRec.FieldByName('CTR_ATRASO').AsInteger;

          objParcelamento.pAdicionarDocumentoAgrupamento(documento);
        End;

        cdsCtaRec.Next;
      End;

      If objParcelamento.fDigitarDadosParcelamento Then
      Begin
        TfrmGravando.fExecutarModalA(objParcelamento.pRealizarAgrupamento,
                                    'Aguarde, Realizando Agrupamento...', '');
        pLimparTela;
      End;

    Except
      On E: ExceptionAutcom Do
      Begin
        pMensagemOk(E.Message);
      End;

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    If Not cdsCtaRec.IsEmpty Then
      cdsCtaRec.RecNo := LRecNo;
    cdsCtaRec.EnableControls;
    cdsCtaRec.AfterScroll := pAfterScroll;

    If Assigned(objParcelamento) Then
      FreeAndNil(objParcelamento);
  End;

end;

procedure TfrmAcertoConta.btnProdutosClick(Sender: TObject);
var
  frmRelFatVendasClienteF9: TfrmRelFatVendasClienteF9;
begin
  inherited;

  If Not cdsCtaRec.IsEmpty Then
  Begin
    If (cdsCtaRec.FieldByName('CTR_ESPDOC').AsString = 'AG') Then
    Begin
      pMostraDuplicatasAgrupadas(LeftStr(cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, fTamDocCadRec),
                                 LeftStr(cdsCtaRec.FieldByName('CTR_CODEMP').AsString, 3),
                                 cdsCtaRec.FieldByName('CTR_CODCLI').AsString,
                                 False,
                                 True);
    End
    Else
    Begin
      Try
        pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);
        frmRelFatVendasClienteF9.dtsRelVenCli.DataSet := frmModuloSPR.qryRelatorio;
        frmRelFatVendasClienteF9.blnMosVenMtl := fCfgSis('VENMTL', varBoolean);
        frmRelFatVendasClienteF9.blnMosPromoc := True;

        With frmRelFatVendasClienteF9 Do
        Begin
          pMostrarProdutos(
            LeftStr(cdsCtaRec.FieldByName('CTR_NUMDUP').AsString, fTamDocCadRec),
            cdsCtaRec.FieldByName('CTR_ESPDOC').AsString,
            LeftStr(cdsCtaRec.FieldByName('CTR_CODEMP').AsString, 3),
            False,
            cdsCtaRec.FieldByName('CTR_CODCLI').AsString);

          ShowModal;
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[btnProdutosClick]');
        End;
      End;

      pFreeAndNil(frmRelFatVendasClienteF9);
    End;
  End;
end;


function TfrmAcertoConta.fValidaDuplics(Var AValidaCliente : Boolean; AValidaApenasCliente :Boolean = False): Boolean;
  Var
    cdsAux: TUniClientDataSet;
    LCodCli : String;
Begin

  Try
    cdsAux := TUniClientDataSet.Create(Nil);
    cdsAux.Data := cdsCtaRec.Data;
    Result := True;

    With cdsAux Do
    Begin
      DisableControls;

      Filtered := False;
      Filter := 'CTR_MARDES = ' + QuotedStr('M');
      Filtered := True;

      First;
      LCodCli := FieldByName('CTR_CODCLI').AsString;
      While Not Eof Do
      Begin

        If Not AValidaApenasCliente Then
        Begin
          AValidaCliente := FieldByName('CTR_CODCLI').AsString.Equals(LCodCli);

          If ((Not fEmptyStr(FieldByName('CTR_DTAENV').AsString)) Or
             ((Not fEmptyStr(FieldByName('CTR_NOSNUM').AsString)) And
              (FieldByName('CTR_BCOBOL').AsString <> '778'))) Or
              (Not AValidaCliente) Then
          Begin
            Result := False;
            Break;
          End;
        End
        Else
        Begin
          AValidaCliente := FieldByName('CTR_CODCLI').AsString.Equals(LCodCli);

          If (Not AValidaCliente) Then
          Begin
            Result := False;
            Break;
          End;
        End;

        Next;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(cdsAux);
End;

function TfrmAcertoConta.fVerificaDataPagamentoDups: Boolean;
  Var
    cdsAux: TUniClientDataSet;
    vdtaPag : String;
Begin

  Try
    cdsAux := TUniClientDataSet.Create(Nil);
    cdsAux.Data := cdsCtaRec.Data;
    Result := True;

    With cdsAux Do
    Begin
      DisableControls;

      Filtered := False;
      Filter   := 'CTR_MARDES = ' + QuotedStr('M');
      Filtered := True;

      First;

      vdtaPag := FieldByName('CTR_DTAPAG').AsString;

      While Not Eof Do
      Begin
        If (FieldByName('CTR_DTAPAG').AsString <> vdtaPag) Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(cdsAux);
End;

procedure TfrmAcertoConta.pReajustaPanelDosBotoes;
begin
  If FlwPnlBotoesbaixa.Height = 22 Then
  Begin
     pnlBotoesBaixa.Height := FlwPnlBotoesbaixa.Height + 3;
  End;
end;

procedure TfrmAcertoConta.pReajustarBotoesRodape;
Var i : Integer;
begin
  {*********************************************************************************}
  {* MANTÉM O btnSairBaixa SEMPRE ALINHADO COM O ÚLTIMO BOTÃO DA PRIMEIRA FILEIRA, *}
  {* AO ALTERAR O TAMANHO OU ADICIONAR ALGUM BOTÃO, VERIFICAR SE ESTÁ ALINHADO     *}
  {* ALTERA O WIDTH DOS BOTOES DO FlwPnlBotoesbaixa PARA SE ALINHAREM CORRETAMENTE *}
  {******************************************************************************AM/KM*}
  // No Layout novo os botões se perdiam, por isso é feito essa verifcação
  If Not untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico Then
  begin
    for i := 0 to FlwPnlBotoesbaixa.ControlCount - 1 do
    begin
      FlwPnlBotoesbaixa.Controls[i].Width := btnConsultar.Width;
    end;
    { * AO ADICIONAR ALGUM BOTÃO, REALIZAR ESSE INCREMENTO NO ULTIMO BOTÃO DA PRIMEIRA FILEIRA *}
    If btnFormaPagto.Visible Then
      btnFormaPagto.Width := btnFormaPagto.Width + 5
    Else
      btnImprimir.Width := btnConsultar.Width + 5;

    btnSairBaixa.Width := btnConsultar.Width + 5;
    btnSairBaixa.Left := FlwPnlBotoesBaixa.Width - btnSairBaixa.Width - 3;
  end
  Else
  Begin
    If Self.WindowState = wsMaximized Then
    begin
      for i := 0 to FlwPnlBotoesbaixa.ControlCount - 1 do
      begin
        FlwPnlBotoesbaixa.Controls[i].Width := btnConsultar.Width + 1;
      end;
      { * AO ADICIONAR ALGUM BOTÃO, REALIZAR ESSE INCREMENTO NO ULTIMO BOTÃO DA PRIMEIRA FILEIRA *}
      If btnFormaPagto.Visible Then
        btnFormaPagto.Width := btnFormaPagto.Width + 6
      Else
        btnImprimir.Width := btnConsultar.Width + 6;

      btnSairBaixa.Width := btnConsultar.Width + 6;
      btnSairBaixa.Left := FlwPnlBotoesBaixa.Width - btnSairBaixa.Width - 3
    end
    Else
    begin
      for i := 0 to FlwPnlBotoesbaixa.ControlCount - 1 do
      begin
        FlwPnlBotoesbaixa.Controls[i].Width := btnConsultar.Width;
      end;
      btnSairBaixa.Width := btnConsultar.Width;
      btnSairBaixa.Left := FlwPnlBotoesBaixa.Width - btnSairBaixa.Width - 2;
    end;
  End;
end;

end.

