unit untCtrLiberaPedidosConf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Mask, MaskEditFocus, StdCtrls, EditFocus, Grids, Math,
  DBGridCitel, DBGrids, DBCtrls, DBEditFocus, Menus, ComCtrls, Buttons, ExtCtrls, DB, UniClientDataSet,
  Uni, AppEvnts, BitBtnLockedIncrem, StrUtils, MemDS, DBAccess, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, UITypes,
  cxLookAndFeelPainters, cxStyles, dxCore, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxProgressBar,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, untIFuncoesCXGrid, untFuncFat,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao,
  untAdiantamentoClienteGenerico, untImpBoletoIndiv, untCRM, untMostraDebCtrChq2;

Type
  TAcao = (opcLibera, opcNega);

type
  TfrmCtrLiberaPedidosConf = class(TfrmPaiSimples)
    Panel1: TPanel;
    pnlTopo: TPanel;
    dtsItens: TDataSource;
    pnlMeio: TPanel;
    pgcGeral: TPageControl;
    tbsItens: TTabSheet;
    pnlTotais: TPanel;
    qryTotais: TUniQuery;
    Panel2: TPanel;
    pnlMensagens: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    edtMenExp: TEditFocus;
    edtMenEx2: TEditFocus;
    edtMenEx3: TEditFocus;
    edtMenEx4: TEditFocus;
    pnlExiMsg: TPanel;
    cxgItens: TcxGrid;
    cxgItensDados: TcxGridDBTableView;
    cxgItensNivel: TcxGridLevel;
    pnlLegenda: TPanel;
    imgSetaBaixo: TImage;
    lblSetaBaixo: TLabel;
    Bevel1: TBevel;
    imgSetaCima: TImage;
    lblSetaCima: TLabel;
    Bevel2: TBevel;
    imgSetaDireita: TImage;
    lblSetaDireita: TLabel;
    Bevel3: TBevel;
    rdgTotProduto: TGroupBox;
    Label14: TLabel;
    lblPreCus: TLabel;
    lblMlPer: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label24: TLabel;
    Label2: TLabel;
    Label15: TLabel;
    Label23: TLabel;
    lblMargemLiqComDifal: TLabel;
    edtPreVen: TEditFocus;
    edtCusto: TEditFocus;
    edtMlPer: TEditFocus;
    edtMlVal: TEditFocus;
    edtIPIPer: TEditFocus;
    edtValIcms: TEditFocus;
    edtVenPer: TEditFocus;
    edtSitTrib: TEditFocus;
    edtTotDif: TEditFocus;
    edtPerFcp: TEditFocus;
    edtValFcp: TEditFocus;
    edtMargemLiqComDifal: TEditFocus;
    Label13: TLabel;
    FlwPnlBotoesLiberacao: TFlowPanel;
    btnConfirma: TBitBtnLocked;
    btnCadCli: TBitBtnLocked;
    btnOrdemProd: TBitBtnLocked;
    btnMotivoBloq: TBitBtnLocked;
    btnCompCusto: TBitBtnLocked;
    btnCadProduto: TBitBtnLocked;
    btnEstoqueLoja: TBitBtnLocked;
    btnCtaCorrente: TBitBtnLocked;
    btnResFinanc: TBitBtnLocked;
    btnFichaKardex: TBitBtnLocked;
    btnItensComp: TBitBtnLocked;
    btnPadrao: TBitBtnLocked;
    rdgTotPedido: TGroupBox;
    lblTotCus: TLabel;
    lblTotICM: TLabel;
    lblTotMLP: TLabel;
    lblPreSug: TLabel;
    lblDesTotPer: TLabel;
    lblLucroLiqComDifalTot: TLabel;
    lblTotalDifal: TLabel;
    lblTotalFCP: TLabel;
    edtTotCus: TEditFocus;
    edtTotIcm: TEditFocus;
    edtTotMLR: TEditFocus;
    edtTotMLP: TEditFocus;
    edtTotDes: TEditFocus;
    edtTotSug: TEditFocus;
    edtTotDesPer: TEditFocus;
    edtMargemLiqComDifalTot: TEditFocus;
    edtLucroLiqComDifalTot: TEditFocus;
    edtTotDifal: TEditFocus;
    edtTotFCP: TEditFocus;
    Label10: TLabel;
    edtDesEsp: TEditFocus;
    Label28: TLabel;
    edtVrTotIPI: TEditFocus;
    Label29: TLabel;
    edtVrTotST: TEditFocus;
    lblTotVen: TLabel;
    edtTotVen: TEditFocus;
    tbsCRM: TTabSheet;
    pnlCRM: TPanel;
    btnAlterarDataEntregaRetirada: TBitBtnLocked;
    btnAltMen: TBitBtnLocked;
    btnAltObs: TBitBtnLocked;
    Label34: TLabel;
    edtCustoReal: TEditFocus;
    Label17: TLabel;
    edtIPIVal: TEditFocus;
    edtPerIcms: TEditFocus;
    edtPerMargemBruta: TEditFocus;
    edtValMargemBruta: TEditFocus;
    edtAlDifa: TEditFocus;
    edtLucroLiqComDifal: TEditFocus;
    Label16: TLabel;
    edtTotCusRea: TEditFocus;
    Label20: TLabel;
    edtTotPerMargBrut: TEditFocus;
    edtTotValMargBrut: TEditFocus;
    Label22: TLabel;
    edtFCPSitTrib: TEditFocus;
    Label25: TLabel;
    edtVrTotFCPST: TEditFocus;
    pnlCndPag: TPanel;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    Panel3: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblCndPag: TLabel;
    Label12: TLabel;
    spbDuplicatas: TSpeedButton;
    lblBonificacao: TLabel;
    Label11: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    mskCndPag: TMaskEditFocus;
    edtNumDoc: TEditFocus;
    edtDtaEnt: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNumSite: TEditFocus;
    Panel4: TPanel;
    Label6: TLabel;
    Label9: TLabel;
    Label32: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    edtCodFpg: TEditFocus;
    edtDesFpg: TEditFocus;
    edtDtaEntrega: TEditFocus;
    Label33: TLabel;
    Label26: TLabel;
    edtVrFrete: TEditFocus;
    Label27: TLabel;
    edtVrDespAcess: TEditFocus;
    Label30: TLabel;
    Label31: TLabel;
    edtVrTotPed: TEditFocus;
    btnAltConPag: TBitBtnLocked;
    edtMens03: TEditFocus;
    edtMens04: TEditFocus;
    edtMens05: TEditFocus;
    btnAdiantPed: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCadProdutoClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnMotivoBloqClick(Sender: TObject);
    procedure btnResFinancClick(Sender: TObject);
    procedure btnCtaCorrenteClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure spbDuplicatasClick(Sender: TObject);
    procedure btnEstoqueLojaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pnlExiMsgClick(Sender: TObject);
    procedure cxgItensDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPadraoClick(Sender: TObject);
    procedure btnOrdemProdClick(Sender: TObject);
    procedure btnCompCustoClick(Sender: TObject);
    procedure btnFichaKardexClick(Sender: TObject);
    procedure btnItensCompClick(Sender: TObject);
    procedure FlwPnlBotoesLiberacaoClick(Sender: TObject);
    procedure pgcGeralChange(Sender: TObject);
    procedure btnAlterarDataEntregaRetiradaClick(Sender: TObject);
    procedure btnAltMenClick(Sender: TObject);
    procedure btnAltObsClick(Sender: TObject);
    procedure btnAltConPagClick(Sender: TObject);
    procedure edtPerIcmsEnter(Sender: TObject);
    procedure btnAdiantPedClick(Sender: TObject);
  private
    { Private declarations }

    fatVenda : TFatVenda;
    blnFecharTela: Boolean;
    cdsItens: TUniClientDataSet;

    mmsLayoutDefault: TMemoryStream;

    fltTotVen    : Double;
    fltTotCus    : Double;
    fltTotCusto  : Double;
    fltTotMed    : Double;
    fltTotMedRea : Double;
    fltTotVlC    : Double;
    fltTotDes    : Double;
    fltTotSug    : Double;
    fltTotMLR    : Double;
    fltTotMLP    : Double;
    fltTotICM    : Double;
    fltDesEsp    : Double;
    fltTotDifOri : Double;
    fltTotDifDes : Double;
    fltTotFCP    : Double;
    fltTotDifal  : Double;
    fltTotIpi    : Double;
    fltTot_ST    : Double;
    fltFCP_ST    : Double;
    fltVlrFrete  : Double;
    fltVlrDpAce  : Double;
    fltTotPed    : Double;

    fltTotMargemBrutaPer : Double;
    fltTotMargeBrutaValor: Double;

    strTipAbf : String;
    objLiberacao : TLiberacao;

    frmCRMLocal: TfrmCRM;

    function fRetValCmpFgoConsum(strNumDoc, strCodEmp: String): String;
    procedure pCalculTotais(pgbStatus: TcxProgressBar = nil);
    procedure pCalculaMargem(pgbStatus: TcxProgressBar = nil);
    procedure pAfterScroll(DataSet: TDataset);
    procedure pMostraStatus;
    procedure pMostraItens(pgbStatus: TcxProgressBar = nil);
    procedure pMontaGrid(pgbStatus: TcxProgressBar = nil);
    procedure pMostraEstoqueLojas;
    function fGetTodasEmpresas: TUniQuery;
    function fGetSaldoEmpWithQtdEntFut(strCodIte, strCodEmp: String): Double;
    procedure pMontaSaldoItens(cdsItensSaldo: TUniClientDataSet; pgbStatus: TcxProgressBar = nil);
    procedure pCarregarTela;
    function fCarregarTela(pgbStatus: TcxProgressBar = nil): Boolean;
    function fGetChaveLayoutGrid: String;
    procedure pPreencheMatrizECalculaDifalFCP;
    procedure pAtualizaInfoDifalFCP(strFdoInc: String);
    procedure pAtualizaMargemBruta;
    procedure pCriaCRM;
    function fAlteraMensagemPedido: Boolean;
    function fAlteraObsExpPedido: Boolean;
    function fPermiteTrocarFormaDePagamentoOutrasEmpresas: Boolean;
    procedure pAjustaCamposDeMensagem;
    procedure pCriarColunasDeSaldoEmpresaNaQueryItens(Var qryItens : TUniQuery);
    procedure pCriarColunasDeSaldoEmpreasNoGrid;
    procedure pAddCol(strField, strCaption: String; blnVisible: Boolean = True; blnSorting: Boolean = True; blnFiltering: Boolean = True);
    procedure pDesabilitarColunasDeSaldoEmpresa;
    procedure pHabilitarColunasDeSaldoEmpresa;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strObsL01: String;
    strObsL02: String;
    strDigLib: String;
    strPedLib: String;
    strTipLib: String;
    strTipOpe: String;
    blnLibPed: Boolean;
    stlTrava: TStringList;
    strAutIncPedido: string;
    blnAlterouMensagem: Boolean;
    blnAlterouFormaPagamento: Boolean;
    function fSubSelPrecoPromocao: String;

    class function fLiberacaoRemotaNoFinalVenda: Boolean;
    class function fMotivoDoBloqueio(strNTrava, strMotLib: String): String;
    class function fUsaLiberacaoPedidosConformeEscolhaDoOperador: Boolean;
    class function fVerificarPermissoesAcessoOperadorLiberacao(strTipLib: String): Boolean;
    class function fRealizarLiberacaoPedido(strNumDoc, strCodEmp, strCodCli, strTipLib, strTipOpe: String): Boolean;
  end;

var
  frmCtrLiberaPedidosConf: TfrmCtrLiberaPedidosConf;

implementation

uses untFuncoes, untFuncoesSimples, untCtrLiberaPedidosObs, untTypesSistema,
     untCadProdutos, untReimpressao, untFuncFatTypes, untTSituacaoPedidoVenda,
     untCtrMotBloPed, untResFinanceiro, untFuncoesAuxiliares, untCadClientes, untFatMostraEstoqueEmp,
     untCadLote, untLogVar, untGravando,untFormaPagtoNegociada,
     untCadPro, untDuplicatas, untAtualizaOcorrenciasCRM, untFuncoesCRM, untMensagemExplicativa,
     untOrdPro, untConstantes, untMsgLiberacao, untCadProdutosCompCusto,
     untFuncoesRel2, TypesRel, untTypesCRM, untFatMensagemNotaF11, untFatAltCondPagtoPedido,
     untIFatReservaSaldo, untTFatReservaSaldo, Shared.Functions.Types, untFuncoesRel,
     untFatDigTipoEntregaItens, untSelFatDigTipoEntregaItens, untConsultarAdiantamentos,
     untMargemMinima;

Const
  SQL_QTD  = '(FDO_QTDITE-FDO_QTDBAI)';
  SQL_VLR  = '(' + SQL_QTD + ' * (FDO_UNITAR + (FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + FDO_VALFCP /*<<REFORMA_FDO>>*/ - FDO_DESESP) / FDO_QTDITE))';
  SQL_VICM = '(FDO_VALICM - (FDO_VALICM / FDO_QTDITE * FDO_QTDBAI))';

{$R *.dfm}

procedure TfrmCtrLiberaPedidosConf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(mmsLayoutDefault);

  If Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(frmCRMLocal) then
    FreeAndNil(frmCRMLocal);

  fGetFuncoesCxGrid.pSalvarView(cxgItensDados, fGetChaveLayoutGrid, cdsItens);
end;

procedure TfrmCtrLiberaPedidosConf.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.Create;
  mmsLayoutDefault := TMemoryStream.Create;
  blnConfirma := False;
  blnFecharTela := False;
  fatVenda := TFatVenda.CreateInstance('PD');
  mskCndPag.EditMask := MASK_CONPAG;
  pgcGeral.ActivePage := tbsItens;
  strAutIncPedido := EmptyStr;
  blnAlterouMensagem := False;
  blnAlterouFormaPagamento := False;
  pAjustaCamposDeMensagem;
end;

procedure TfrmCtrLiberaPedidosConf.pAjustaCamposDeMensagem;
  Var
    intQtde: Integer;
    intCont: Integer;
begin
  intQtde := fCfgSis('QTPDOR', varInteger);

  For intCont := 1 To intQtde Do
  Begin
    If (FindComponent('edtMens0' + intCont.ToString) <> Nil) Then
      TEditFocus(FindComponent('edtMens0' + intCont.ToString)).Visible := True;

    If (intCont = intQtde) And (FindComponent('edtMens0' + IntToStr(intCont + 1)) <> Nil) Then
      btnAltMen.Top := TEditFocus(FindComponent('edtMens0' + IntToStr(intCont + 1))).Top + 1;
  End;
end;

procedure TfrmCtrLiberaPedidosConf.FormDestroy(Sender: TObject);
begin
  FreeANdNil(fatVenda);
  inherited;
end;

procedure TfrmCtrLiberaPedidosConf.btnCancelaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  Close;
end;

procedure TfrmCtrLiberaPedidosConf.FormShow(Sender: TObject);
begin
  pCarregarTela;
  tbsCRM.TabVisible := fCfgSis('UTICRM', varBoolean);
  btnAltMen.Visible := fCfgSis('ALTMEN', varBoolean);
  btnAltConPag.Visible := fCfgSis('ACPLPD', varBoolean);
  btnAltObs.Visible := btnAltMen.Visible;
  if tbsCRM.TabVisible then
  begin
    pCriaCRM;
  end;
end;

procedure TfrmCtrLiberaPedidosConf.pCarregarTela;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregarTela;
    frmAguarde.ShowModal;
    If Not frmAguarde.blnConfirma Then
      blnFecharTela := True;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmAguarde);
end;

procedure TfrmCtrLiberaPedidosConf.pCriaCRM;
begin
  pCriarFormularios(TfrmCRM, frmCRMLocal);
  frmCRMLocal.Align := alClient;
  frmCRMLocal.blnLiberaPedido := True;
  frmCRMLocal.edtCodCli.Text := edtCodCli.Text;
  frmCRMLocal.Dock(pnlCRM, pnlCRM.BoundsRect);
  frmCRMLocal.Show;
end;

procedure TfrmCtrLiberaPedidosConf.pgcGeralChange(Sender: TObject);
begin
  inherited;
  if pgcGeral.ActivePage = tbsItens then
  begin
    spbDuplicatas.Caption := 'Pressione [ F1 ] para visualizar as Duplicatas';
  end
  else
  begin
    spbDuplicatas.Caption := 'Clique para visualizar as Duplicatas';
  end;
end;

function TfrmCtrLiberaPedidosConf.fAlteraMensagemPedido: Boolean;
var
  qryAltMen: TUniQuery;
begin
  Result := False;

  If fEmptyStr(strAutIncPedido) Then
    Exit;

  qryAltMen := fCriaQuery;

  Try
    Try
      fStartTransaction;

      qryAltMen.Close;
      qryAltMen.SQL.Clear;
      qryAltMen.SQL.Text := ' UPDATE                               '+
                            '   FATGOR, AUXGOR                     '+
                            ' SET                                  '+
                            '   FGO_MEN001 = :MEN001,              '+
                            '   FGO_MEN002 = :MEN002,              '+
                            '   AUX_MEN003 = :MEN003,              '+
                            '   AUX_MEN004 = :MEN004,              '+
                            '   AUX_MEN005 = :MEN005               '+
                            ' WHERE                                '+
                            '   AUX_SEQGER = FATGOR.AUTOINCREM AND '+
                            '   FATGOR.AUTOINCREM = :AUTINC        ';

      qryAltMen.ParamByName('MEN001').AsString := edtMens01.Text;
      qryAltMen.ParamByName('MEN002').AsString := edtMens02.Text;
      qryAltMen.ParamByName('MEN003').AsString := edtMens03.Text;
      qryAltMen.ParamByName('MEN004').AsString := edtMens04.Text;
      qryAltMen.ParamByName('MEN005').AsString := edtMens05.Text;
      qryAltMen.ParamByName('AUTINC').AsString := strAutIncPedido;
      qryAltMen.ExecSQL;

      Result := fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
      End;
    End;
  Finally
    FreeAndNil(qryAltMen);
  End;
end;

function TfrmCtrLiberaPedidosConf.fAlteraObsExpPedido: Boolean;
var
  qryAltMen: TUniQuery;
begin
  Result := False;

  if fEmptyStr(strAutIncPedido) then
    Exit;

  qryAltMen := fCriaQuery;

  try
    qryAltMen.Close;
    qryAltMen.SQL.Clear;
    qryAltMen.SQL.Add('UPDATE FATGOR');
    qryAltMen.SQL.Add('SET FGO_MENEXP = :MENEXP,');
    qryAltMen.SQL.Add('FGO_MENEX2 = :MENEX2,');
    qryAltMen.SQL.Add('FGO_MENEX3 = :MENEX3,');
    qryAltMen.SQL.Add('FGO_MENEX4 = :MENEX4');
    qryAltMen.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryAltMen.ParamByName('MENEXP').AsString := edtMenExp.Text;
    qryAltMen.ParamByName('MENEX2').AsString := edtMenEx2.Text;
    qryAltMen.ParamByName('MENEX3').AsString := edtMenEx3.Text;
    qryAltMen.ParamByName('MENEX4').AsString := edtMenEx4.Text;
    qryAltMen.ParamByName('AUTINC').AsString := strAutIncPedido;

    qryAltMen.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryAltMen);
  end;
end;

function TfrmCtrLiberaPedidosConf.fCarregarTela(pgbStatus: TcxProgressBar = nil): Boolean;
  Var
    strCap: String;
    blnMostraCustoMargem: Boolean;
    strEmpLogada: String;
begin
  inherited;
  pInformacao('Aguarde, Carregando Pedido para Liberação...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  {*************************}
  {* CAPTION DO FORMULÁRIO *}
  {**********************RV*}
  If (strTipLib = '1') And fCfgSis('LPPDBL', varBoolean) Then
    strCap := 'Liberação de Pedidos - Financeiro - [Confirmação]'
  Else If (strTipLib = '1') And Not fCfgSis('LPPDBL', varBoolean) Then
    strCap := 'Liberação de Pedidos - [Confirmação]'
  Else If (strTipLib = '2') Then
    strCap := 'Liberação de Pedidos - Comercial - [Confirmação]';
  frmCtrLiberaPedidosConf.Caption := strCap;

  pSetFocus(cxgItens);

  strTipAbf := fGetTipoAbfCliente(edtCodCli.Text, fRetValCmpFgoConsum(Trim(edtNumDoc.Text), Trim(edtCodEmp.Text)));

  strEmpLogada := VS_strCodEmp;
  pSetaEmpresaLogada(edtCodEmp.Text);
  Try
    pMostraItens(pgbStatus);
    pPreencheMatrizECalculaDifalFCP;
    pCalculaMargem(pgbStatus);
    pCalculTotais(pgbStatus);
  Finally
    pSetaEmpresaLogada(strEmpLogada);
  End;
  pMontaGrid(pgbStatus);
  pMostraStatus;

  pInformacao('Aguarde, Carregando Pedido para Liberação...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  blnMostraCustoMargem := fCfgSis('ECMLBP', varBoolean) And fVerificaAcessoSistema('LIBPEDVISMLPC');

  lblPreCus.Visible := blnMostraCustoMargem;
  lblMlPer.Visible  := blnMostraCustoMargem;

  lblTotCus.Visible := blnMostraCustoMargem;
  lblTotMLP.Visible := blnMostraCustoMargem;

  lblMargemLiqComDifal.Visible    := blnMostraCustoMargem;
  lblLucroLiqComDifalTot.Visible  := blnMostraCustoMargem;

  edtTotFCP.Visible   := blnMostraCustoMargem;
  edtTotDifal.Visible := blnMostraCustoMargem;

  edtCusto.Visible  := blnMostraCustoMargem;
  edtMlPer.Visible  := blnMostraCustoMargem;
  edtMlVal.Visible  := blnMostraCustoMargem;

  edtTotCus.Visible := blnMostraCustoMargem;
  edtTotMLR.Visible := blnMostraCustoMargem;
  edtTotMLP.Visible := blnMostraCustoMargem;

  edtLucroLiqComDifal.Visible     := blnMostraCustoMargem;
  edtMargemLiqComDifal.Visible    := blnMostraCustoMargem;
  edtLucroLiqComDifalTot.Visible  := blnMostraCustoMargem;
  edtMargemLiqComDifalTot.Visible := blnMostraCustoMargem;

  pnlCndPag.Visible := fCfgSis('USACND', varBoolean);

  pnlMensagens.Height := (pnlExiMsg.Height + 1);
  pnlExiMsg.Caption := '>>> clique aqui para visualizar as mensagens do pedido <<<';

  If (strTipOpe = 'B') Then
    lblBonificacao.Visible := True;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  btnOrdemProd.Visible := fCfgSis('LBPDOP', varBoolean);
  btnAlterarDataEntregaRetirada.Visible := fCfgSis('ENTFAT', varBoolean) and fVerificaAcessoSistema('mnuPermitirAlterarDataEntrega');

  Result := True;
end;

function TfrmCtrLiberaPedidosConf.fPermiteTrocarFormaDePagamentoOutrasEmpresas: Boolean;
begin
  Result := True;

  if edtCodEmp.Text <> VS_strCodEmp then
  begin
    if not fCfgSis('ALPDEM', varBoolean) then
    begin
      fMensagem('', 'Pedido de outra empresa, não é permitido alterar a condição de pagamento!', ['&Ok']);
      Exit(False);
    end;
  end;
end;

class function TfrmCtrLiberaPedidosConf.fRealizarLiberacaoPedido(strNumDoc,
  strCodEmp, strCodCli, strTipLib, strTipOpe: String): Boolean;
Var
    strMsg: String;
    strObs: String;
    strDigLib: String;
    strObsL01: String;
    strObsL02: String;
    objReimpressao: TReimpressao;
    opcLibPed: TLibPed;
    opcAcao: TAcao;
    strCodigoLiberacao: String;

  function fInfPed(strCampo: String): Variant;
  begin
    If strCampo = 'AUTOINCREM' Then
      Result := fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, 'PD', strCodEmp])
    Else If strCampo = 'CODVE2' Then
      Result := fCampoTabela('FDO_' + strCampo, 'FATDOR', ['FDO_NUMDOC', 'FDO_ESPDOC', 'FDO_CODEMP'], [strNumDoc, 'PD', strCodEmp])
    Else
      Result := fCampoTabela('FGO_' + strCampo, 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, 'PD', strCodEmp]);
  end;

  function fRetObsAnterior: String;
    Var
      qryAux: TUniQuery;
  Begin
    Result := '';
    qryAux := fCriaQuery(nil);

    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  CONCAT(NPD_OBSNE1," ", NPD_OBSNE2) AS OBSVER ');
      SQL.Add('FROM ');
      SQL.Add('  NEGPED ');
      SQL.Add('WHERE NPD_NUMDOC = :NUMDOC ');
      SQL.Add('  AND NPD_CODCLI = :CODCLI ');
      SQL.Add('  AND NPD_CODEMP = :CODEMP ');
      SQL.Add('ORDER BY AUTOINCREM ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not EOF Do
        Begin
          Result := Result + FieldByName('OBSVER').AsString   + #13;
          Result := Result + '------------------------------' + #13;
          Next;
        End;
      End;
    End;

    FreeAndNil(qryAux);
  end;

  procedure pGerarLogLiberacaoTravas(strNumDoc, strCodEmp, strCodCli: String);
    Var
      qryLiberacao: TUniQuery;
      strNumLib: String;
      intBloqueio: Integer;
  Begin
    If Not (fLiberacaoRemotaNoFinalVenda And fUsaLiberacaoPedidosConformeEscolhaDoOperador) Then
      Exit;

    If (strTipLib <> '1') Then
      Exit;

    qryLiberacao := fCriaQuery;

    Try
      With qryLiberacao Do
      Begin
        SQL.Clear;
        SQL.Add('SELECT * FROM LIBPED ');
        SQL.Add('WHERE LPD_NUMDOC = :NUMDOC');
        SQL.Add('  AND LPD_ESPDOC = "PD"   ');
        SQL.Add('  AND LPD_CODEMP = :CODEMP');
        SQL.Add('  AND LPD_OPELIB IS NULL');

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        If fVerificarPermissoesAcessoOperadorLiberacao(strTipLib) Then
        Begin
          For intBloqueio := 0 To Length(arrLogAvi) -1 Do
            If Locate('LPD_DIRACE', arrLogAvi[intBloqueio].strDirAce, []) Then
            Begin
              Edit;
              FieldByName('LPD_DTALIB').AsDateTime := VS_Date;
              FieldByName('LPD_HORLIB').AsDateTime := fTime();
              FieldByName('LPD_OPELIB').AsString   := arrLogAvi[intBloqueio].strOpeLib;
              Post;
            End;
          Exit;
        End;

        First;

        While Not Eof Do
        Begin
          Edit;
          FieldByName('LPD_DTALIB').AsDateTime := VS_Date;
          FieldByName('LPD_HORLIB').AsDateTime := fTime();
          FieldByName('LPD_OPELIB').AsString   := strLoginUsuarioLogado;
          Post;

          strNumLib := fGeraNumLiberacao(FieldByName('LPD_DIRACE').AsString);

          fGravaLogVar(strNumLib,
                       FieldByName('LPD_INFLIB').AsString,
                       FieldByName('LPD_CODVEN').AsString,
                       FieldByName('LPD_CODDIG').AsString,
                       FieldByName('LPD_CODCLI').AsString,
                       '',
                       Nil,
                       Nil);

          strCodigoLiberacao := fCodigoLiberacaoLogLib(FieldByName('LPD_DIRACE').AsString);
          pGeraMatrizLiberacao(strLoginUsuarioLogado,
                               FieldByName('LPD_CODVEN').AsString,
                               FieldByName('LPD_INFBLO').AsString,
                               FieldByName('LPD_DIRACE').AsString,
                               strCodigoLiberacao,
                               '',
                               0,
                               strNumLib,
                               FieldByName('LPD_INFLIB').AsString,
                               False,
                               fRetornaXmlClientTravasMinimas(strNumLib, 'AUX_INFOF4'),
                               0,
                               0,
                               0,
                               FieldByName('LPD_DESACE').AsString,
                               frmCtrLiberaPedidosConf.Caption);

          pUpdateLogVar(strNumLib, strLoginUsuarioLogado);

          Next;
        End;

      End;

    Finally
      FreeAndNil(qryLiberacao);
    End;

  end;

  procedure pLiberaPedido(strNumDoc, strCodEmp, strCodCli: String);
    Var
      qryLiberacao: TUniQuery;
      objOcoCrm : TAtuOcoCrm;
  Begin
    qryLiberacao := fCriaQuery(nil);

    With qryLiberacao Do
    Begin
      SQL.Add(' UPDATE                   ');
      SQL.Add('   FATGOR                 ');
      SQL.Add(' SET                      ');
      If (strTipLib = '1') Then
      Begin
        SQL.Add('   FGO_OPELIB = :OPELIB,  ');
        SQL.Add('   FGO_DIGLIB = :DIGLIB,  ');
        SQL.Add('   FGO_DTALIB = :DTALIB,  ');
        SQL.Add('   FGO_HORLIB = :HORLIB,  ');
        SQL.Add('   FGO_OBSL01 = :OBSL01,  ');
        SQL.Add('   FGO_OBSL02 = :OBSL02,  ');
        SQL.Add('   FGO_LIBERA = :LIBERA   ');
      End
      Else If (strTipLib = '2') Then
      Begin
        SQL.Add('   FGO_OPELIC = :OPELIB,  ');
        SQL.Add('   FGO_DIGLIC = :DIGLIB,  ');
        SQL.Add('   FGO_DTALIC = :DTALIB,  ');
        SQL.Add('   FGO_HORLIC = :HORLIB,  ');
        SQL.Add('   FGO_OBSLC1 = :OBSL01,  ');
        SQL.Add('   FGO_OBSLC2 = :OBSL02,  ');
        SQL.Add('   FGO_LIBCOM = :LIBERA   ');
      End;
      SQL.Add(' WHERE                    ');
      SQL.Add('   FGO_NUMDOC=:NUMDOC AND ');
      SQL.Add('   FGO_ESPDOC="PD"    AND ');
      SQL.Add('   FGO_CODEMP=:CODEMP     ');

      ParamByName('DIGLIB').AsString   := strDigLib;
      ParamByName('OPELIB').AsString   := strLoginUsuarioLogado;
      ParamByName('DTALIB').AsDateTime := VS_Date;
      ParamByName('HORLIB').AsDateTime := fTime();
      ParamByName('OBSL01').AsString   := strObsL01;
      ParamByName('OBSL02').AsString   := strObsL02;
      ParamByName('LIBERA').AsInteger  := IIF((strTipLib = '1'), 2, 1);
      ParamByName('NUMDOC').AsString   := strNumDoc;
      ParamByName('CODEMP').AsString   := strCodEmp;

      ExecSQL;
      Close;

      If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
      begin
        objOcoCrm := fAtualizaInformacoesCRM(strNumDoc, 'PD', strCodEmp, strCodCli, '', '', fInfPed('CODVEN'), afcPedidoLiberado);
        try
          objOcoCrm.strNomFrm := '[TfrmCtrLiberaPedidosConf.fRealizarLiberacaoPedido]';
          objOcoCrm.pProcessaFatOcorrenciasCRM;
        finally
          FreeAndNil(objOcoCrm);
        end;
      end;

      pGerarLogLiberacaoTravas(strNumDoc, strCodEmp, strCodCli);
    End;

    FreeAndNil(qryLiberacao);
  End;

  procedure pGerarLogNegacoes(strNumDoc, strCodEmp, strCodCli: String);
    Var
      qryNegacao: TUniQuery;
  Begin
    qryNegacao := fCriaQuery(nil);

    With qryNegacao Do
    Begin
      SQL.Add('INSERT INTO ');
      SQL.Add('  NEGPED ( ');
      SQL.Add('    AUTOINCREM, ');
      SQL.Add('    NPD_CODEMP, ');
      SQL.Add('    NPD_CODCLI, ');
      SQL.Add('    NPD_NUMDOC, ');
      SQL.Add('    NPD_DTANEG, ');
      SQL.Add('    NPD_HORNEG, ');
      SQL.Add('    NPD_CODOPE, ');
      SQL.Add('    NPD_OBSNE1, ');
      SQL.Add('    NPD_OBSNE2) ');
      SQL.Add('  VALUES ( ');
      SQL.Add('    :AUTINC, ');
      SQL.Add('    :CODEMP, ');
      SQL.Add('    :CODCLI, ');
      SQL.Add('    :NUMDOC, ');
      SQL.Add('    :DTANEG, ');
      SQL.Add('    :HORNEG, ');
      SQL.Add('    :CODOPE, ');
      SQL.Add('    :OBSNE1, ');
      SQL.Add('    :OBSNE2) ');

      ParamByName('AUTINC').AsString   := fRetAutoIncrem('NEGPED', VS_strCodEmp);
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('NUMDOC').AsString   := strNumDoc;
      ParamByName('DTANEG').AsDatetime := VS_Date;
      ParamByName('HORNEG').AsDatetime := fTime();
      ParamByName('CODOPE').AsString   := strDigLib;
      ParamByName('OBSNE1').AsString   := strObsL01;
      ParamByName('OBSNE2').AsString   := strObsL02;

      ExecSQL;
      Close;
    End;

    FreeAndNil(qryNegacao);
  end;

  procedure pNegaPedido(strNumDoc, strCodEmp, strCodCli: String);
    Var
      qryNegacao: TUniQuery;
      objOcoCrm : TAtuOcoCrm;
  Begin
    qryNegacao := fCriaQuery(nil);

    With qryNegacao Do
    Begin
      SQL.Add('UPDATE ');
      SQL.Add('  EXTGOR E INNER JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ');
      SQL.Add('SET ');
      SQL.Add('  F.FGO_OBSL01 = :OBSL01,  ');
      SQL.Add('  F.FGO_OBSL02 = :OBSL02,  ');
      SQL.Add('  E.FGO_ENVLIB = "N"       ');
      SQL.Add('WHERE ');
      SQL.Add('  F.FGO_NUMDOC = :NUMDOC AND ');
      SQL.Add('  F.FGO_ESPDOC = "PD"    AND ');
      SQL.Add('  F.FGO_CODEMP = :CODEMP AND ');
      SQL.Add('  F.FGO_CODCLI = :CODCLI ');

      ParamByName('OBSL01').AsString   := strObsL01;
      ParamByName('OBSL02').AsString   := strObsL02;
      ParamByName('NUMDOC').AsString   := strNumDoc;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;

      ExecSQL;
      Close;
    End;

    If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
    begin
      objOcoCrm := fAtualizaInformacoesCRM(strNumDoc, 'PD', strCodEmp, strCodCli, '', '', fInfPed('CODVEN'),afcPedidoNegado);
      try
        objOcoCrm.strNomFrm := '[TfrmCtrLiberaPedidosConf.pNegaPedido]';
        objOcoCrm.pProcessaFatOcorrenciasCRM;
      finally
        FreeAndNil(objOcoCrm);
      end;
    end;

    pGerarLogNegacoes(strNumDoc, strCodEmp, strCodCli);
    FreeAndNil(qryNegacao);
  end;

  procedure pProcessaPedidosTransferencia(blnLibera: Boolean);
    Var
      qryPedTransf: TUniQuery;
  Begin
    qryPedTransf := fCriaQuery(nil);

    Try
      qryPedTransf.SQL.Add('SELECT FG.FGO_NUMDOC, FG.FGO_ESPDOC, FG.FGO_CODEMP, FG.FGO_CODCLI');
      qryPedTransf.SQL.Add('  FROM EXTGOR EG                                                 ');
      qryPedTransf.SQL.Add('  JOIN FATGOR FG ON EG.FGO_SEQFGO = FG.AUTOINCREM                ');
      qryPedTransf.SQL.Add(' WHERE EG.FGO_NMPDAB = :NUMDOC                                   ');
      qryPedTransf.SQL.Add('   AND EG.FGO_ESPDAB = "PD"                                      ');
      qryPedTransf.SQL.Add('   AND EG.FGO_EMPDAB = :CODEMP                                   ');
      qryPedTransf.SQL.Add('   AND IFNULL(FGO_DOCEND,  "") = ""                              ');
      qryPedTransf.SQL.Add('   AND IFNULL(FGO_ENVLIB, "S") = "S"                             ');
      qryPedTransf.SQL.Add('   AND FGO_VLRCON > 0                                            ');
      qryPedTransf.SQL.Add('   AND FGO_VLRCON > 0                                            ');
      qryPedTransf.SQL.Add('   AND FG.FGO_JAFATU = 0                                         ');
      If (strTipLib = '1') Then
        qryPedTransf.SQL.Add('   AND IFNULL(FGO_LIBERA, 0) = 0                               ')
      Else
        qryPedTransf.SQL.Add('   AND IFNULL(FGO_LIBCOM, 0) = 0                               ');

      qryPedTransf.ParamByName('NUMDOC').AsString := strNumDoc;
      qryPedTransf.ParamByName('CODEMP').AsString := strCodEmp;

      qryPedTransf.Open;

      While Not qryPedTransf.Eof Do
      Begin
        If blnLibera Then
          pLiberaPedido(qryPedTransf.FieldByName('FGO_NUMDOC').AsString,
                        qryPedTransf.FieldByName('FGO_CODEMP').AsString,
                        qryPedTransf.FieldByName('FGO_CODCLI').AsString)
        Else
          pNegaPedido(qryPedTransf.FieldByName('FGO_NUMDOC').AsString,
                      qryPedTransf.FieldByName('FGO_CODEMP').AsString,
                      qryPedTransf.FieldByName('FGO_CODCLI').AsString);

        qryPedTransf.Next;
      End;
    Finally
      FreeAndNil(qryPedTransf);
    End;
  end;

  function fVerificaLimCreOperador: Boolean;
    Var
      blnLibFin: Boolean;
      blnLimExc: Boolean;
      fltVlrExc: Double;
      fltLimCreOp: Double;
      fltDebCli: Double;
      fltLimCre: Double;
      fltValPed: Double;
      objLiberacao : TLiberacao;
      strNTrava : String;
  begin
    Result := True;

    If (fCfgSis('LMCROP', VarBoolean)) Then
    Begin
      strNTrava := fInfPed('NTRAVA');
      blnLibFin := (strTipLib = '1');
      blnLimExc := ((Length(strNTrava) >= 1) And (strNTrava[1] = 'S'));

      If blnLibFin
        And blnLimExc Then
      Begin
        fltDebCli := fRetDebitoCliente(strCodCli);
        fltLimCre := fLimiteCreditoCliente(strCodCli);
        fltValPed := IIF(fCfgSis('PDVLIM', VarBoolean), 0, fStrToFloat(fInfPed('VLRCON')));
        fltVlrExc := (fltDebCli + fltValPed) - fltLimCre;
        fltLimCreOp := fLimCredOperador('', strCodCli);

        If (fltVlrExc > fltLimCreOp) Then
        Begin
          objLiberacao := TLiberacao.Create;
          try
            objLiberacao.objMsgLibera.pAddTexto('O valor excedido do limite de crédito ultrapassa o limite permitido para o operador');
            objLiberacao.objMsgLibera.pAddQuebra;
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , strCodCli + '-' + fRetNomCliente(strCodCli) , 24, alDireita, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption('Valor Débitos Cliente'   , FloatToStrF(fltDebCli, ffFixed, 15, 2)  , 24, alDireita, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption('Valor Pedido Venda'      , FloatToStrF(fltValPed, ffFixed, 15, 2)  , 24, alDireita, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption('Valor Limite Crédito'    , FloatToStrF(fltLimCre, ffFixed, 15, 2)  , 24, alDireita, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption('Valor Excedido Lim Créd' , FloatToStrF(fltVlrExc, ffFixed, 15, 2)  , 24, alDireita, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption('Limite Crédito Operador' , FloatToStrF(fltLimCreOp, ffFixed, 15, 2), 24, alDireita, teAmbos, '', 15);

            objLiberacao.strDirAce := 'LIMCR';
            objLiberacao.strMsgSen := 'Limite crédito excedido';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.strCliente := (strCodCli + '-' + fRetNomCliente(strCodCli));

            Result := fMensagemLiberacao(objLiberacao, strNTrava, nil);
          finally
            FreeAndNil(objLiberacao);
          end;
        End;
      End;
    End;
  end;

  function fExecutarLiberacaoBloqueiosPedido: Boolean;
    Var
      objVenda: TFatVenda;
  begin
    If Not fVerificarPermissoesAcessoOperadorLiberacao(strTipLib) Then
      Exit(True);

    objVenda := TFatVenda.CreateInstance('PD');
    Try
      objVenda.strNumpok := fRetornaInformacaoVenda(strNumDoc, 'PD', strCodEmp, 'NUMPOK');
      objVenda.strEspDoc := 'PD';
      objVenda.strCodCli := strCodCli;
      objVenda.blnRealizandoLiberacaoPedido := True;
      objVenda.pMontaArrayTravasLogAviFinalVenda;
      Result := objVenda.fCarregaLiberacaoPedido(strNumDoc, 'PD', strCodEmp) And
                objVenda.fRealizarLiberacaoRemotaFinalVenda;
    Finally
      objVenda.Free;
    End;
  end;

begin
  opcAcao := opcLibera;
  strObs  := fRetObsAnterior;

  Try
    pCriarFormularios(TfrmCtrLiberaPedidosObs, frmCtrLiberaPedidosObs);

    If fEmptyStr(strObs) Then
    Begin
      frmCtrLiberaPedidosObs.pnlObsAnt.Visible := False;
      frmCtrLiberaPedidosObs.Height            := frmCtrLiberaPedidosObs.Height -
                                                  frmCtrLiberaPedidosObs.pnlObsAnt.Height;
    End
    Else
    Begin
      frmCtrLiberaPedidosObs.memObsAnt.Texto   := strObs;
      frmCtrLiberaPedidosObs.pnlObsAnt.Visible := True;
    End;

    frmCtrLiberaPedidosObs.blnFiltroFinanc := (strTipLib = '1');
    frmCtrLiberaPedidosObs.ShowModal;

    Result := frmCtrLiberaPedidosObs.blnConfirma;
    If Result Then
    Begin
      strObsL01 := frmCtrLiberaPedidosObs.edtObsL01.Text;
      strObsL02 := frmCtrLiberaPedidosObs.edtObsL02.Text;
      strDigLib := frmCtrLiberaPedidosObs.strCodDig;
      opcAcao   := IIF(frmCtrLiberaPedidosObs.rdbLibera.Checked, opcLibera, opcNega);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmCtrLiberaPedidosConf.btnConfirmaClick]');
    End;
  End;

  pFreeAndNil(frmCtrLiberaPedidosObs);

  If (Not Result) Then
    Exit;

  If (strTipOpe <> 'B')
    And (opcAcao = opcLibera)
    And (Not fVerificarPermissoesAcessoOperadorLiberacao(strTipLib))
    And (Not fVerificaLimCreOperador) Then
  Begin
    Result := False;
    Exit;
  End;

  If (opcAcao = opcLibera) And (Not fExecutarLiberacaoBloqueiosPedido) Then
  Begin
    Result := False;
    Exit;
  End;

  If (strTipOpe = 'B') Then
    strMsg := 'Confirmar Liberação de Pedido proveniente de Bonificação?'
  Else
  Begin
    If opcAcao = opcLibera Then
      strMsg := 'Confirma Liberação?'
    Else
      strMsg := 'Confirma Negação?';
  End;

  If (fMensagem('', strMsg, ['&Sim', '&Não']) = 2) Then
  Begin
    Result := False;
    Exit;
  End;

  Try
    fStartTransaction;

    Result := True;

    If opcAcao = opcLibera Then
      pLiberaPedido(strNumDoc, strCodEmp, strCodCli)
    Else
      pNegaPedido(strNumDoc, strCodEmp, strCodCli);

    {*****************************}
    {* LIBERA OU NEGA PEDIDOS    *}
    {* ATRELADOS AUTOMATICAMENTE *}
    {**************************FS*}
    pProcessaPedidosTransferencia(opcAcao = opcLibera);

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro('Erro ao liberar pedido: ' + E.Message, '[Liberação de Pedidos]');
      Result := False;
    End;
  End;

  Try
    If (Result) And (fCfgSis('IPPDLF') = 'L') Then
    Begin
      opcLibPed := libAmbos;

      If (fMensagem('ATENÇÃO', 'Imprimir o Pedido?', ['&Sim', '&Não']) = 2) Then
        opcLibPed := libSeparacao;

      objReimpressao := TReimpressao.Create(strNumDoc, 'PD', 0, 0, '', strCodEmp, '',
                                            False, '', fCfgSis('IMSELB', varBoolean), False, False, '', '',
                                            False, 0, False, '');

      objReimpressao.pReimprimeDocumento(False, False, False, (Not fCfgSis('LPPDBL', varBoolean)), True, opcPergunta, False, opcLibPed);
      objReimpressao.Destroy;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro na impressão do documento: ' + E.Message + '.', '[Liberação de Pedidos]');
    End;
  End;

  Try
    If (Result) And (opcAcao = opcLibera) Then
    Begin
      If (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(strNumDoc, 'PD', strCodEmp, strCodCli) > 0) And
         (fMensagem('ATENÇÃO', 'Imprimir boleto(s) do Pedido?', ['&Sim', '&Não']) = 1) Then
      Begin
        TfrmImpBoletoIndiv.pImprimirBoletos(strNumDoc, 'PD', strCodEmp, strCodCli);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro na impressão dos boletos: ' + E.Message + '.', '[Liberação de Pedidos]');
    End;
  End;

  TUpdateStatus.New(
    TParamStatus.New()
      .NumDoc(strNumDoc)
      .EspDoc('PD')
      .CodEmp(strCodEmp)
    ).pExecute();
end;

function TfrmCtrLiberaPedidosConf.fRetValCmpFgoConsum(strNumDoc, strCodEmp: String): String;
  Var
    qryGen : TUniQuery;
begin
  Result := '';

  If Not fCfgSis('USOREV', VarBoolean) Then
    Exit;

  qryGen := fCriaQuery(Self);
  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Text := ' SELECT IFNULL(FGO_CONSUM, "") '+
                  '   FROM FATGOR INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '+
                  '  WHERE FGO_NUMDOC = '+QuotedStr(strNumDoc)+
                  '    AND FGO_CODEMP = '+QuotedStr(strCodEmp)+
                  '    AND FGO_ESPDOC = "PD" ';
      Open;
      Result := Fields[0].Text;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCtrLiberaPedidosConf.fSubSelPrecoPromocao: String;
var
  strPraMed: String;
  intCotador: Integer;
  objItemPromo: TItemPromo;
begin
  strPraMed := '';
  strPraMed := strPraMed + ' ( 0 ';
  For intCotador := 1 To 24 Do
    strPraMed := strPraMed + ' + SUBSTR(FGO_CONPAG, ' + IntToStr(3 * intCotador) + ', 3) ';
  strPraMed := strPraMed + ' ) / SUBSTR(FGO_CONPAG, 1,2) ';

  objItemPromo := TItemPromo.Create;
  objItemPromo.strAndWhereCodEmp := ' FDO_CODEMP ';
  objItemPromo.strAndWhereCodIte := ' FDO_CODITE ';
  objItemPromo.strCodCli         := edtCodCli.Text;
  If fCfgSis('PRZPRO', varBoolean) Then
    objItemPromo.strPraMedio := '('+strPraMed +')';

  objItemPromo.strSelect := fRetSQLPrecoVendaPromo;
  Result := ' ('+objItemPromo.fRetSubQryPromo+') ';

  FreeAndNil(objItemPromo);
end;

class function TfrmCtrLiberaPedidosConf.fUsaLiberacaoPedidosConformeEscolhaDoOperador: Boolean;
begin
  Result := fCfgSis('LIBPED', VarBoolean) And fCfgSis('LBPDSN', VarBoolean);
end;

function TfrmCtrLiberaPedidosConf.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
End;

class function TfrmCtrLiberaPedidosConf.fVerificarPermissoesAcessoOperadorLiberacao(strTipLib: String): Boolean;
begin
  If Not fLiberacaoRemotaNoFinalVenda Then
    Exit(False);

  If Not fCfgSis('VPALPD', VarBoolean) Then
    Exit(False);

  If (strTipLib <> '1') Then
    Exit(False);

  Result := True;
end;

procedure TfrmCtrLiberaPedidosConf.btnCompCustoClick(Sender: TObject);
  Var
    frmCadProdutosCompCusto : TfrmCadProdutosCompCusto;
begin
  inherited;
  If Not fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
    frmCadprodutosCompCusto.strCodIte := cdsItens.FieldByName('FDO_CODITE').AsString;
    frmCadprodutosCompCusto.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmCadprodutosCompCusto);
end;

procedure TfrmCtrLiberaPedidosConf.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  Try
    btnConfirma.Enabled := False;
    blnConfirma := fRealizarLiberacaoPedido(edtNumDoc.Text, edtCodEmp.Text, edtCodCli.Text, strTipLib, strTipOpe);
  Finally
    btnConfirma.Enabled := True;
    If blnConfirma Then
      Self.Close;
  End;
end;

procedure TfrmCtrLiberaPedidosConf.btnCtaCorrenteClick(Sender: TObject);
begin
  inherited;
  TfrmMostraDebCtrChq2.pMostraContaCorrente(edtCodCli.Text);
end;

procedure TfrmCtrLiberaPedidosConf.pMontaSaldoItens(cdsItensSaldo: TUniClientDataSet; pgbStatus: TcxProgressBar = nil);
  Var
    fltQtdRes   : Double;
    fltQtdReG   : Double;
    fltSalExt   : Double;
    fltQtdDis   : Double;
    fltQtdSal   : Double;
    fltQtdSMl   : Double;
    fltCNV_ML   : Double;
    fltQtdDisTot: Double;
    objCadLot   : TCadLot;
    strNumLot   : String;
    blnPedCorte : Boolean;
    qryTmp      : TUniQuery;
begin
  If (fCfgSis('EXCOLP', varString) = 'N') Then
    Exit;

  pInformacao('Aguarde, Calculando saldo dos produtos...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  strNumLot := '';
  blnPedCorte := cdsItens.FieldByName('FGO_CORTE_').AsString = 'S';
  fltQtdDisTot := 0.00;

  objCadLot := TCadLot.Create(Self);

  With cdsItensSaldo Do
  Begin
    First;

    qryTmp := fGetTodasEmpresas;

    While (Not Eof) Do
    Begin
      If qryTmp <> Nil Then
      Begin
        qryTmp.First;

        While Not qryTmp.Eof Do
        Begin
          pProgresso(qryTmp.RecNo, qryTmp.RecordCount, pgbStatus);

          Edit;

          FieldByName('ITE_SALDIS').AsFloat := fGetSaldoEmpWithQtdEntFut(FieldByName('FDO_CODITE').AsString,
                                                                         qryTmp.FieldByName('EMP_CODEMP').AsString);

          If Not fEmptyStr(strNumLot) Then
            FieldByName('ITE_SALDIS').AsFloat := objCadLot.fSaldoLote( FieldByName('FDO_CODITE').AsString,
                                                                       qryTmp.FieldByName('EMP_CODEMP').AsString,
                                                                       strNumLot );

          fltQtdSal := FieldByName('ITE_SALDIS').AsFloat;
          fltQtdSMl := fCampoTabela('ITE_SAL_ML', 'ITEGER',
                                   ['ITE_CODITE', 'ITE_CODEMP'],
                                   [FieldByName('FDO_CODITE').AsString, qryTmp.FieldByName('EMP_CODEMP').AsString]);

          fltCNV_ML := IIF(FieldByName('ITE_CNV_ML').AsFloat <= 0, 1, FieldByName('ITE_CNV_ML').AsFloat);

          fltQtdRes := TSaldoReservado.New(
                         TReservaParametros.New()
                           .EmpresaItem(qryTmp.FieldByName('EMP_CODEMP').AsString)
                           .CodigoItem(FieldByName('FDO_CODITE').AsString)
                           .CodEmpresa(qryTmp.FieldByName('EMP_CODEMP').AsString)
                           .NumeroLote(strNumLot)
                           .TipoReserva(trsPedidoVenda)
                           .DesconsideraPedidosCorte(Not blnPedCorte)
                         ).fGetQuantidade();

          fltQtdReG := TSaldoReservado.New(
                         TReservaParametros.New()
                           .EmpresaItem(qryTmp.FieldByName('EMP_CODEMP').AsString)
                           .CodigoItem(FieldByName('FDO_CODITE').AsString)
                           .CodEmpresa(qryTmp.FieldByName('EMP_CODEMP').AsString)
                           .NumeroLote(strNumLot)
                           .TipoReserva(trsGarantia)
                           .DesconsideraPedidosCorte(Not blnPedCorte)
                         ).fGetQuantidade();

          fltSalExt := TSaldoReservado.New(
                         TReservaParametros.New()
                           .EmpresaItem(qryTmp.FieldByName('EMP_CODEMP').AsString)
                           .CodigoItem(FieldByName('FDO_CODITE').AsString)
                           .CodEmpresa(qryTmp.FieldByName('EMP_CODEMP').AsString)
                           .NumeroLote(strNumLot)
                           .TipoReserva(trsExterno)
                           .DesconsideraPedidosCorte(Not blnPedCorte)
                         ).fGetQuantidade();

          If (fltSalExt < 0) Then
            fltSalExt := 0;

          If (fCfgSis('MOVFUL', varString) = '2') Then
            fltSalExt := 0;

          fltQtdDis := (fltQtdSal + (fltQtdSMl / fltCNV_ML)) - (fltQtdRes + fltQtdReG) - fltSalExt;
          fltQtdDisTot := fltQtdDisTot + fltQtdDis;

          FieldByName('ITE_SAL' + qryTmp.FieldByName('EMP_CODEMP').AsString).AsFloat := fltQtdDis;

          Post;

          (FieldByName('ITE_SAL' + qryTmp.FieldByName('EMP_CODEMP').AsString) As TFloatField).DisplayFormat := '#,##0.000';

          qryTmp.Next;
        End;
      End;

      {*********************************}
      {* SALDO TOTAL DE TODAS AS LOJAS *}
      {*******************************FC}
      Edit;
      FieldByName('ITE_SALTOT').AsFloat := fltQtdDisTot;
      Post;

      (FieldByName('ITE_SALTOT') As TFloatField).DisplayFormat := '#,##0.000';

      fltQtdDisTot := 0.00;
      
      Next;
    End;
  End;

  FreeAndNil(objCadLot);

  If Assigned(qryTmp) Then
    FreeAndNil(qryTmp);
end;

procedure TfrmCtrLiberaPedidosConf.pMostraEstoqueLojas;
  Var
    strCodIte: String;
    strTabIte: String;
    fltQtdIte: Double;
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  fltQtdIte := 0.0;

  If cdsItens.Active And (Not cdsItens.IsEmpty) Then
  Begin
    strCodIte := cdsItens.FieldByName('FDO_CODITE').AsString;
    fltQtdIte := cdsItens.FieldByName('FDO_QTDITE').AsFloat;
    strTabIte := cdsItens.FieldByName('FDO_TABPRE').AsString;
  End;

  If fEmptyStr(strCodIte) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    frmFatMostraEstoqueEmp.blnFaturamento := True;
    frmFatMostraEstoqueEmp.strCodIte    := strCodIte;
    frmFatMostraEstoqueEmp.fltQtdIte    := fltQtdIte;
    frmFatMostraEstoqueEmp.strTabPre    := strTabIte;
    frmFatMostraEstoqueEmp.blnPedCorte  := cdsItens.FieldByName('FGO_CORTE_').AsString = 'S';
    frmFatMostraEstoqueEmp.edtItem.Text := strCodIte + ' - ' + fRetNomProduto(strCodIte);
    frmFatMostraEstoqueEmp.pnlSelecEmpresa.Visible := False;
    frmFatMostraEstoqueEmp.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
End;

procedure TfrmCtrLiberaPedidosConf.btnEstoqueLojaClick(Sender: TObject);
begin
  inherited;
  If btnEstoqueLoja.Visible Then
  Begin
    pMostraEstoqueLojas;
    pSetFocus(ActiveControl);
  End;
end;

procedure TfrmCtrLiberaPedidosConf.btnFichaKardexClick(Sender: TObject);
begin

  If cdsItens.IsEmpty Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
     prcExecutaRelatorio(34, 2951, [2951,2958],
                         ['CODEMP','CODITE'],
                         [VS_STRCODEMP,cdsItens.FieldByName('FDO_CODITE').AsString],
                         Sender);
end;

procedure TfrmCtrLiberaPedidosConf.btnItensCompClick(Sender: TObject);
begin

  If Not fVerificaAcessoSistema('ITECMP') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso aos Itens Comprados!', ['&O k']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(73, 5226, [],
                        ['CODITE','DESITE'],
                        [cdsItens.FieldByName('FDO_CODITE').AsString,
                        fRetNomProduto(cdsItens.FieldByName('FDO_CODITE').AsString)],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmCtrLiberaPedidosConf.pCalculaMargem(pgbStatus: TcxProgressBar = nil);
  Var
    fltCusIte,
    fltCusRea,
    fltMedRea,
    fltTotCusRea,
    fltUnitar,
    fltVlrCon,
    fltValIcm,
    fltQtdIte,
    fltMarPer,
    fltMarDin,
    fltPreSug,
    fltPreVen: Double;

    fltIcmSai : Double;
    fltOutVal : Double;
    fltDesOpe : Double;
    fltImpFed : Double;
    fltIcmCal : Double;
    fltDesOpeCli : Double;

    impSubIteEst: TImpostosSubItensEstrutura;
    calcCustoReal: TCalcCustoReal;

    blnCliFil : Boolean;
    fltProPreCus : Double;
    fltProPreVen : Double;
    fltProComVar : Double;
    fltProComAta : Double;
    fltProComDis : Double;
    intPraMedio : Integer;
    fltQtdDis: Double;
    fltDesF07: Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    item : TDadosFechamento;
    strComPro, strCodPro: String;
    fltFcp,
    fltDifal: Double;
    prcScroll: TprcScroll;
begin
  pInformacao('Aguarde, Calculando Margem dos produtos...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  fatVenda.pCarregaDadosClienteBaixa(edtCodCli.Text);
  blnCliFil := fatVenda.fClienteFilialVenda(edtCodCli.Text);

  pDisableControls(cdsItens, prcScroll);

  try
    With cdsItens Do
    Begin

      fltTotCus             := 0.00;
      fltTotCusto           := 0.00;
      fltTotMed             := 0.00;
      fltTotVen             := 0.00;
      fltTotVlC             := 0.00;
      fltTotDes             := 0.00;
      fltTotSug             := 0.00;
      fltTotMLR             := 0.00;
      fltTotICM             := 0.00;
      fltPreVen             := 0.00;
      fltDesEsp             := 0.00;
      fltTotCusRea          := 0.00;
      fltTotMedRea          := 0.00;
      fltTotDifOri          := 0.00;
      fltTotDifDes          := 0.00;
      fltTotFCP             := 0.00;
      fltTotDifal           := 0.00;
      fltTotIpi             := 0.00;
      fltTot_ST             := 0.00;
      fltFCP_ST             := 0.00;
      fltTotMargemBrutaPer  := 0.00;
      fltTotMargeBrutaValor := 0.00;
      fltVlrFrete           := 0.00;
      fltVlrDpAce           := 0.00;
      fltTotPed             := 0.00;

      First;
      While Not Eof Do
      Begin
        pProgresso(RecNo, RecordCount, pgbStatus);

        fltIcmSai := 0;
        fltOutVal := 0;
        fltDesOpe := 0;
        fltImpFed := 0;

        intPraMedio := fFloatToInt(fCalcMediaPagto(FieldByName('FGO_CONPAG').AsString));
        fltDesOpeCli := fCampoTabela('CLI_DESOPE', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text], False);
        If (fCfgSis('CLIDOP', varString) = 'N') Then
          fltDesOpeCli := 0;

        fatVenda.strClaFis := FieldByName('FDO_CLAFIS').AsString;

        impSubIteEst.strCodIte := FieldByName('FDO_CODITE').AsString;
        impSubIteEst.strEmpIte := FieldByName('FDO_EMPITE').AsString;
        impSubIteEst.fltQtdPai := FieldByName('FDO_QTDITE').AsFloat;
        impSubIteEst.fltUniPai := FieldByName('FDO_UNITAR').AsFloat;

        If fatVenda.fUtilizaPrecoSubItensEstrutura(Pos('ITEM ESPECIAL', FieldByName('FDO_DESCRI').AsString) > 0,
                                                   FieldByName('FDO_CODITE').AsString) Then
        Begin
          fatVenda.pRetImpostosSubItensEstrutura(impSubIteEst);
          fltIcmSai := impSubIteEst.fltIcmSai;
          fltOutVal := impSubIteEst.fltOutVal;
          fltDesOpe := impSubIteEst.fltDesOpe;
          fltImpFed := impSubIteEst.fltImpFed;
        End
        Else
        Begin
          pRetImpostosItem(FieldByName('FDO_CODITE').AsString,
                           fltIcmSai,
                           fltOutVal,
                           fltDesOpe,
                           fltImpFed,
                           Nil,
                           FieldByName('TABPRE').AsString,
                           FieldByName('FDO_EMPITE').AsString);
        End;

        fltFcp := FieldByName('ALQ_FCP').AsFloat;
        fltDifal := FieldByName('ALQ_DIFAL').AsFloat;

        fltOutVal := TFatVenda.fOutrosValoresParaMargem(FieldByName('ITE_COMTBL').AsFloat, FieldByName('FDO_UNILIQ').AsFloat, fltOutVal, fltOutVal, fCfgSis('DECUNI', varInteger));

        If (fCfgSis('IMPCF4') = 'S') Then
          fltIcmCal := fatVenda.fCalculaAliquota(FieldByName('FDO_CODITE').AsString, FieldByName('FDO_EMPITE').AsString,
                                                 IIF(fCfgSis('IMPDIG') = '1', FieldByName('ITE_IMPDIR').AsString, FieldByName('GER_IMPDIR').AsString))
        Else
          fltIcmCal := fltIcmSai;

        fltQtdIte := FieldByName('FDO_QTDITE').AsFloat;
        fltUnitar := FieldByName('FDO_UNILIQ').AsFloat;
        fltVlrCon := FieldByName('FDO_VLRCON').AsFloat;
        fltValIcm := FieldByName('FDO_VALICM').AsFloat;
        fltPreSug := FieldByName('FDO_PRESUG').AsFloat;
        fltPreVen := fltPreVen + fFormataFloat(fltUnitar * fltQtdIte, 2);
        fltDesEsp := fltDesEsp + FieldByName('FDO_DESESP').AsFloat;
        fltTotIpi := FieldByName('FGO_TOTIPI').AsFloat;
        fltTot_ST := FieldByName('FGO_TOTRET').AsFloat;
        fltFCP_ST := fltFCP_ST + FieldByName('FDO_VALFCP').AsFloat;
        fltVlrFrete := FieldByName('FGO_TOTFRE').AsFloat;
        fltVlrDpAce := FieldByName('FGO_DESACE').AsFloat;
        fltTotPed   := FieldByName('FGO_VLRCON').AsFloat;

        fltProPreCus := 0;
        fltProPreVen := 0;
        fltProComVar := 0;
        fltProComAta := 0;
        fltProComDis := 0;

        If (Not blnCliFil) And (FieldByName('FDO_PROMOC').AsString = 'S') Then
        Begin
          If Not (fRetornaPrecosPromocao(FieldByName('FDO_CODITE').AsString,
                                         FieldByName('FDO_CODCLI').AsString,
                                         VS_Date,
                                         fltQtdIte,
                                         0,
                                         0,
                                         intPraMedio,
                                         fltProPreCus,
                                         fltProPreVen,
                                         fltProComVar,
                                         fltProComAta,
                                         fltProComDis,
                                         fltQtdDis,
                                         fltDesF07,
                                         strComPro,
                                         strCodPro,
                                         blnParticiona,
                                         blnPromo,
                                         FieldByName('TABPRE').AsString,
                                         FieldByName('FGO_CODCND').AsString,
                                         '',
                                         '',
                                         True,
                                         False,
                                         '-1',
                                         ((FieldByName('FDO_ENTRET').AsString = 'E') And (FieldByName('FDO_ENTFUT').AsString = 'N')),
                                         ((FieldByName('FDO_ENTRET').AsString = 'E') And (FieldByName('FDO_ENTFUT').AsString = 'S')),
                                         FieldByName('FDO_MOTFUT').AsString,
                                         '',
                                         FieldByName('FDO_NUMDOC').AsString,
                                         FieldByName('FDO_ESPDOC').AsString)) Then
          Begin
            fltProPreCus := FieldByName('FDO_TOTCUS').AsFloat / FieldByName('FDO_QTDITE').AsFloat;
          End;

          If (blnPromo) Then
          Begin

            If not (cdsItens.State in ([dsInsert, dsEdit])) Then
              cdsItens.Edit;

            FieldByName('ITE_SITUAC').AsString := 'PROMO';

          End;

        End;

        fltMedRea := 0;

        If (FieldByName('FDO_IDEPRO').AsString = 'NOR') Then
        Begin
          If (Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) > 0) Then
          Begin
            fltCusRea := FieldByName('FDO_TOTCU2').AsFloat;
            fltMedRea := FieldByName('FDO_TOTMED').AsFloat / IIF(FieldByName('FDO_QTDITE').AsFloat <= 0, 1, FieldByName('FDO_QTDITE').AsFloat);
          End
          Else If (FieldByName('FDO_PROACA').AsString = 'S') Then
          Begin
            fltCusRea := FieldByName('FDO_PRCTIN').AsFloat;
            fltMedRea := FieldByName('FDO_TOTMED').AsFloat / IIF(FieldByName('FDO_QTDITE').AsFloat <= 0, 1, FieldByName('FDO_QTDITE').AsFloat);
          End
          Else
          Begin
            fltCusIte := FieldByName('ITE_PRECUS').AsFloat;

            If (FieldByName('FDO_PROMOC').AsString = 'S') And
               (fltProPreCus > 0) and
               (fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao) Then
            begin
              fltCusIte := fltProPreCus;
            end;

            If fCfgSis('JURCUS', VarBoolean) Then
              fltCusIte := fltCusIte * (1 + FieldByName('FDO_TAXJUR').AsFloat / 100);

            calcCustoReal := TCalcCustoReal.Create;
            calcCustoReal.fltUnitar := fltUnitar;
            calcCustoReal.fltPreCus := fltCusIte;
            calcCustoReal.fltOutVal := fltOutVal;
            calcCustoReal.fltIcmSai := fltIcmCal;
            calcCustoReal.fltImpFed := fltImpFed;
            calcCustoReal.fltDesOpe := fltDesOpe + fltDesOpeCli;
            calcCustoReal.fltFcp    := fltFcp;
            calcCustoReal.fltDifal  := fltDifal;

            fltCusRea := fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                                     FieldByName('FDO_CODITE').AsString,
                                                     FieldByName('FDO_EMPITE').AsString,
                                                     fltCusIte,
                                                     '',
                                                     calcCustoReal);

            calcCustoReal.fltPreCus := fFormataFloat(FieldByName('FDO_TOTMED').AsFloat / IIF(FieldByName('FDO_QTDITE').AsFloat <= 0, 1, FieldByName('FDO_QTDITE').AsFloat), 2);
            fltMedRea := fatVenda.fRetornaPrecoCusto(Preco_de_Custo_Real,
                                                     FieldByName('FDO_CODITE').AsString,
                                                     FieldByName('FDO_EMPITE').AsString,
                                                     0,
                                                     '',
                                                     calcCustoReal);

            FreeAndNil(calcCustoReal);
          End;
        End
        Else
          fltCusRea := FieldByName('FDO_TOTCU2').AsFloat / fltQtdIte;

        fltTotCusRea := fltTotCusRea + (fltCusRea * fltQtdIte);
        fltTotMedRea := fltTotMedRea + (fltMedRea * fltQtdIte);
        fltTotCusto  := fltTotCusto + FieldByName('FDO_TOTCUS').AsFloat;
        fltTotMed := fltTotMed + FieldByName('FDO_TOTMED').AsFloat;

        If (TMargemMinima.UsaPrecoMedio) Then
        Begin
          fltMarPer := fCalculaPrecoVenda(2,
                                          fFormataFloat(FieldByName('FDO_TOTMED').AsFloat / IIF(fltQtdIte <= 0, 1, fltQtdIte), 2),
                                          fltUnitar,
                                          0,
                                          fltIcmCal,
                                          fltImpFed,
                                          fltDesOpe + fltDesOpeCli,
                                          0,
                                          '',
                                          '',
                                          -1,
                                          0,
                                          False,
                                          fltDifal,
                                          fltFcp,
                                          fltOutVal);
          fltMarDin := (fltQtdIte * fltUnitar) - (fltQtdIte * fltMedRea);
        End
        Else
        Begin
          fltMarPer := fCalculaPrecoVenda(2, fltCusRea, fltUnitar, 0, 0, 0, 0, 0);
          fltMarDin := (fltQtdIte * fltUnitar) - (fltQtdIte * fltCusRea);
        End;

        fltTotCus := fltTotCus + (fltCusRea * fltQtdIte);
        fltTotVen := fltTotVen + (fltQtdIte * fltUnitar);
        fltTotSug := fltTotSug + (fltPreSug * fltQtdIte);
        fltTotVlC := fltTotVlC + fltVlrCon;

        If (TMargemMinima.UsaPrecoMedio) Then
          fltTotMLR := fltTotVen - fltTotMedRea
        Else
          fltTotMLR := fltTotVen - fltTotCus;

        fltTotICM := fltTotICM + fltValIcm;

        Edit;
        FieldByName('FDO_PRECUS').AsFloat := fltCusRea;
        FieldByName('FDO_CUSTOT').AsFloat := fltCusRea * fltQtdIte;
        FieldByName('FDO_MERTOT').AsFloat := fltMedRea * fltQtdIte;
        FieldByName('FDO_MARPER').AsFloat := fltMarPer;
        FieldByName('FDO_MARDIN').AsFloat := fltMarDin;
        Post;

        Next;
      End;

      {Totalização do DIFAL}
      For item In fatVenda.arrMatItens Do
      Begin
        fltTotDifOri := fltTotDifOri + item.recDifalFCP.fltDifOri;
        fltTotDifDes := fltTotDifDes + item.recDifalFCP.fltDifDes;
        fltTotFCP    := fltTotFCP    + item.recDifalFCP.fltValFcp;
        fltTotDifal  := fltTotDifal  + (item.recDifalFCP.fltDifOri + item.recDifalFCP.fltDifDes);
      end;

      If (TMargemMinima.UsaPrecoMedio) Then
      Begin
        fltTotMLP := fCalculaPrecoVenda(2,
                                        fltTotMedRea,
                                        fltTotVen,
                                        0,
                                        0,
                                        0,
                                        0,
                                        0,
                                        '',
                                        '',
                                        -1,
                                        0,
                                        False,
                                        0,
                                        0,
                                        0);
      End
      Else
        fltTotMLP := fCalculaPrecoVenda(2, fltTotCusRea, fltTotVen, 0, 0, 0, 0, 0);

      fltTotDes := (fltTotSug - fltPreVen);

      If (TMargemMinima.UsaPrecoMedio) Then
      Begin
        fltTotMargemBrutaPer  := fCalculaPrecoVenda(2, fltTotMed, fltTotVen, 0, 0, 0, 0, 0);
        fltTotMargeBrutaValor := fltTotVen - fltTotMed;
      End
      Else
      Begin
        fltTotMargemBrutaPer  := fCalculaPrecoVenda(2, fltTotCusto, fltTotVen, 0, 0, 0, 0, 0);
        fltTotMargeBrutaValor := fltTotVen - fltTotCusto;
      End;

      First;
    End;
  finally
    pEnableControls(cdsItens, prcScroll);
  end;
end;

procedure TfrmCtrLiberaPedidosConf.pCalculTotais(pgbStatus: TcxProgressBar = nil);
Begin

  pInformacao('Aguarde, Calculando Totais...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  edtTotCus.Text      := FormatFloat('#,##0.00', fltTotCusto);
  edtTotCusRea.Text   := FormatFloat('#,##0.00', fltTotCus);
  edtTotVen.Text      := FormatFloat('#,##0.00', fltTotVlC);
  edtTotMLR.Text      := FormatFloat('#,##0.00', fltTotMLR);
  edtTotMLP.Text      := fSuprimirZeroDireita(FormatFloat('#,##0.00', fltTotMLP));
  edtTotICM.Text      := FormatFloat('#,##0.00', fltTotICM);
  edtTotSug.Text      := FormatFloat('#,##0.00', fltTotSug);
  edtTotDes.Text      := FormatFloat('#,##0.00', fltTotDes);
  edtDesEsp.Text      := FormatFloat('#,##0.00', fltDesEsp);
  edtVrTotIPI.Text    := FormatFloat('#,##0.00', fltTotIpi);
  edtVrTotST.Text     := FormatFloat('#,##0.00', fltTot_ST);
  edtVrFrete.Text     := FormatFloat('#,##0.00', fltVlrFrete);
  edtVrDespAcess.Text := FormatFloat('#,##0.00', fltVlrDpAce);
  edtVrTotPed.Text    := FormatFloat('#,##0.00', fltTotPed);
  edtVrTotFCPST.Text  := FormatFloat('#,##0.00', fltFCP_ST);

  edtTotPerMargBrut.Text := fSuprimirZeroDireita(FormatFloat('#,##0.00', fltTotMargemBrutaPer));
  edtTotValMargBrut.Text := FormatFloat('#,##0.00', fltTotMargeBrutaValor);

  If (TMargemMinima.UsaPrecoMedio) Then
  Begin
    edtLucroLiqComDifalTot.Text := FloatToStrF((fltTotVen) - (fltTotMedRea + (fltTotDifOri + fltTotDifDes)), ffFixed, 12, 2);

    edtMargemLiqComDifalTot.Text := fSuprimirZeroDireita( FloatToStrF(fCalculaPrecoVenda(2,
                                                                      fltTotMedRea + (fltTotDifOri + fltTotDifDes),
                                                                      fltTotVen,
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0), ffFixed, 12, 2));
  End
  Else
  Begin
    {Cálculo do L.L com Difal (R$) e Margem L. com Difal (%) do *Pedido}
    edtLucroLiqComDifalTot.Text := FloatToStrF((fltTotVen) - (fltTotCus + (fltTotDifOri + fltTotDifDes)), ffFixed, 12, 2);

    edtMargemLiqComDifalTot.Text := fSuprimirZeroDireita( FloatToStrF(fCalculaPrecoVenda(2,
                                                                      fltTotCus + (fltTotDifOri + fltTotDifDes),
                                                                      fltTotVen,
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      0), ffFixed, 12, 2));
  End;

  edtTotFCP.Text   := FloatToStrF(fltTotFCP,   ffFixed, 12, 2);
  edtTotDifal.Text := FloatToStrF(fltTotDifal, ffFixed, 12, 2);

  If fltTotDes > 0 Then
  Begin
    edtTotDesPer.Text := fSuprimirZeroDireita(FormatFloat('#,##0.00', ((fltTotDes / fltTotSug) * 100)));
  End
  Else
  Begin
    edtTotDesPer.Text := fSuprimirZeroDireita(FormatFloat('#,##0.00', 0));
  End;

End;

procedure TfrmCtrLiberaPedidosConf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if pgcGeral.ActivePage = tbsCRM then
    Exit;

  If btnConfirma.Enabled Then
  Begin
    If (Key = VK_F10) Then
      btnConfirma.Click;
  End;

  If btnCompCusto.Enabled Then
  Begin
    If (Key = VK_F4) And (Shift = [ssCtrl]) Then
      btnCompCusto.Click;
  End;

  If btnMotivoBloq.Enabled Then
  Begin
    If (Key = VK_F4) And (Shift = []) Then
      btnMotivoBloq.Click;
  End;

  If btnAdiantPed.Visible Then
  Begin
    If (Key = VK_F5) And (Shift = [ssAlt]) Then
      btnAdiantPed.Click;
  End;

  If btnCadProduto.Enabled Then
  Begin
    If (Key = VK_F5) And (Shift = []) Then
      btnCadProduto.Click;
  End;

  If (Key = VK_F6) Then
  Begin
    btnEstoqueLoja.Click;
  End;

  If (Key = VK_F7) And (Shift = []) Then
  Begin
    btnCtaCorrente.Click;
  End;

  If (Key = VK_F8) Then
  Begin
    btnResFinanc.Click;
  End;

  If (Key = VK_F9) Then
  Begin
    btnOrdemProd.Click;
  End;

  If (Key = VK_F3) Then
  Begin
    btnCadCli.Click;
  End;

  If (Key = VK_F1) Then
  Begin
    spbDuplicatas.Click;
  End;

  If (Key = VK_F11) Then
  Begin
    btnItensComp.Click;
  End;

  If (Key = VK_F7) And (Shift = [ssCtrl]) Then
  Begin
    btnAltConPag.Click;
  End;

  If (Key = VK_Escape) Then
    btnCancela.Click;

end;

procedure TfrmCtrLiberaPedidosConf.btnAdiantPedClick(Sender: TObject);
var
  frmConsultarAdiantamentos: TfrmConsultarAdiantamentos;
begin
  inherited;
  pCriarFormularios(TfrmConsultarAdiantamentos, frmConsultarAdiantamentos);
  Try
    frmConsultarAdiantamentos.pApenasConsulta(edtNumDoc.Text, edtCodEmp.Text, True);
    frmConsultarAdiantamentos.ShowModal;
  Finally
    pFreeAndNil(frmConsultarAdiantamentos);
  End;
end;

procedure TfrmCtrLiberaPedidosConf.btnAltConPagClick(Sender: TObject);
var
  frmFatAltCondPagtoPedido: TfrmFatAltCondPagtoPedido;
begin
  inherited;

  if not btnAltConPag.Visible then
    Exit;

  if not fPermiteTrocarFormaDePagamentoOutrasEmpresas then
    Exit;

  pCriarFormularios(TfrmFatAltCondPagtoPedido, frmFatAltCondPagtoPedido);

  try
    frmFatAltCondPagtoPedido.blnLiberaPedido := True;
    frmFatAltCondPagtoPedido.strNumPedLib := edtNumDoc.Text;
    frmFatAltCondPagtoPedido.strCodEmpLib := edtCodEmp.Text;
    frmFatAltCondPagtoPedido.blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp := ((fCfgSis('ALPDEM', varBoolean)) And (edtCodEmp.Text <> VS_strCodEmp));
    frmFatAltCondPagtoPedido.ShowModal;

    blnAlterouFormaPagamento := frmFatAltCondPagtoPedido.blnAlterouFormaPagamento;

  finally
    pFreeAndNil(frmFatAltCondPagtoPedido);
  end;

  if blnAlterouFormaPagamento then
    Close;
end;

procedure TfrmCtrLiberaPedidosConf.btnAlterarDataEntregaRetiradaClick(
  Sender: TObject);
var
  frmSelFatDigTipoEntregaItens: TfrmSelFatDigTipoEntregaItens;
  fatVenda: TFatVenda;
begin
  inherited;
  objLiberacao.Clear;
  objLiberacao.strDirAce    := 'mnuPermitirAlterarDataEntrega';
  objLiberacao.strCodOpe    := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.pAddTexto('Alterar data de entrega / situação de retira dos produtos na liberação de pedidos');
  objLiberacao.objMsgLibera.pAddTexto('Pedido...: '+edtNumDoc.Text+' - '+'PD'+' - '+edtCodEmp.Text+'');
  objLiberacao.objMsgLibera.pAddTexto('Cliente..: '+edtCodCli.Text+' - '+fRetNomCliente(edtCodCli.Text)+'');
  objLiberacao.pInformaNumDocEspDocCodEmp(
                    edtNumDoc.Text,
                    'PD',
                    edtCodEmp.Text);

  If (Not objLiberacao.fLibera) Then
    Exit;

  Try
    pCriarFormularios(TfrmSelFatDigTipoEntregaItens, frmSelFatDigTipoEntregaItens);
    Try
      frmSelFatDigTipoEntregaItens.strNumDoc := edtNumDoc.Text;
      frmSelFatDigTipoEntregaItens.strEspDoc := 'PD';
      frmSelFatDigTipoEntregaItens.strCodEmp := edtCodEmp.Text;

      If (frmSelFatDigTipoEntregaItens.ShowModal = mrOk) And frmSelFatDigTipoEntregaItens.blnSelecao Then
      Begin
        pCriarFormularios(TfrmFatDigTipoEntregaItens, frmFatDigTipoEntregaItens);
        fatVenda := TFatVenda.CreateInstance('VN');
        try
          fatVenda.strCodCli := edtCodCli.Text;
//          fatVenda.strCliOri := cdsPedidos.FieldByName('CLI_NOMCLI').AsString;
//          fatVenda.strCodFpg := cdsPedidos.FieldByName('FGO_CODFPG').AsString;
//          fatVenda.strConPag := fCondicaoPagamentoSemMascara(cdsPedidos.FieldByName('FGO_CONPAG').AsString);
//          fatVenda.strObserv := cdsPedidos.FieldByName('CLI_OBSERV').AsString;

//          If fCfgSis('USACND', varBoolean) And fCfgSis('PFLCLI', varBoolean) Then
//            fatVenda.strCodCnd := cdsPedidos.FieldByName('FGO_CODCND').AsString;

          frmFatDigTipoEntregaItens.strCodEmpPosAltEmp := '';
          frmFatDigTipoEntregaItens.intAutIncPosAltEmp := -1;
          frmFatDigTipoEntregaItens.fatVenda := fatVenda;
          frmFatDigTipoEntregaItens.arrSelecaoAutoIncrem := frmSelFatDigTipoEntregaItens.arrSelecaoAutoIncrem;
          frmFatDigTipoEntregaItens.strNumDoc := edtNumDoc.Text;
          frmFatDigTipoEntregaItens.strEspDoc := 'PD';
          frmFatDigTipoEntregaItens.strCodEmp := edtCodEmp.Text;
          frmFatDigTipoEntregaItens.ShowModal;
          If frmFatDigTipoEntregaItens.blnAlterou Then
            edtDtaEntrega.Text := frmFatDigTipoEntregaItens.mskDtaEnt.Text;
        Finally
          FreeAndNil(fatVenda);
          pFreeAndNil(frmFatDigTipoEntregaItens);
        End;
      End;
    Finally
      pFreeAndNil(frmSelFatDigTipoEntregaItens);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCtrLiberaPedidosConf.btnAltMenClick(Sender: TObject);
var
  LfrmFatMensagemNotaF11: TfrmFatMensagemNotaF11;
begin
  inherited;
  pCriarFormularios(TfrmFatMensagemNotaF11, LfrmFatMensagemNotaF11);

  try
    LfrmFatMensagemNotaF11.opcTipoAlteraMensagem := opcLibPedMen;
    LfrmFatMensagemNotaF11.Caption := 'Alterar Mensagem';
    LfrmFatMensagemNotaF11.edtMens01.Text := edtMens01.Text;
    LfrmFatMensagemNotaF11.edtMens02.Text := edtMens02.Text;
    LfrmFatMensagemNotaF11.edtMens03.Text := edtMens03.Text;
    LfrmFatMensagemNotaF11.edtMens04.Text := edtMens04.Text;
    LfrmFatMensagemNotaF11.edtMens05.Text := edtMens05.Text;

    LfrmFatMensagemNotaF11.ShowModal;

    if LfrmFatMensagemNotaF11.blnConfirma then
    begin
      edtMens01.Text := LfrmFatMensagemNotaF11.edtMens01.Text;
      edtMens02.Text := LfrmFatMensagemNotaF11.edtMens02.Text;
      edtMens03.Text := LfrmFatMensagemNotaF11.edtMens03.Text;
      edtMens04.Text := LfrmFatMensagemNotaF11.edtMens04.Text;
      edtMens05.Text := LfrmFatMensagemNotaF11.edtMens05.Text;

      if fAlteraMensagemPedido then
      begin
        fMensagem('', 'Mensagem alterada com sucesso!', ['&Ok']);
        blnAlterouMensagem := True;
      end
      else
        fMensagem('ATENÇÃO', 'Erro ao alterar mensagem.', ['&Ok']);
    end;
  finally
    pFreeAndNil(LfrmFatMensagemNotaF11);
  end;
end;

procedure TfrmCtrLiberaPedidosConf.btnAltObsClick(Sender: TObject);
var
  LfrmFatMensagemNotaF11: TfrmFatMensagemNotaF11;
begin
  inherited;
  pCriarFormularios(TfrmFatMensagemNotaF11, LfrmFatMensagemNotaF11);

  try
    LfrmFatMensagemNotaF11.opcTipoAlteraMensagem := opcLibPedObs;
    LfrmFatMensagemNotaF11.Caption := 'Alterar Obs. para Faturamento/Expedição';
    LfrmFatMensagemNotaF11.edtMens01.Text := edtMenExp.Text;
    LfrmFatMensagemNotaF11.edtMens02.Text := edtMenEx2.Text;
    LfrmFatMensagemNotaF11.edtMens03.Text := edtMenEx3.Text;
    LfrmFatMensagemNotaF11.edtMens04.Text := edtMenEx4.Text;

    LfrmFatMensagemNotaF11.ShowModal;

    if LfrmFatMensagemNotaF11.blnConfirma then
    begin
      edtMenExp.Text := LfrmFatMensagemNotaF11.edtMens01.Text;
      edtMenEx2.Text := LfrmFatMensagemNotaF11.edtMens02.Text;
      edtMenEx3.Text := LfrmFatMensagemNotaF11.edtMens03.Text;
      edtMenEx4.Text := LfrmFatMensagemNotaF11.edtMens04.Text;

      if fAlteraObsExpPedido then
      begin
        fMensagem('', 'Obs. para faturamento/expedição alterada com sucesso!', ['&Ok']);
        blnAlterouMensagem := True;
      end
      else
        fMensagem('ATENÇÃO', 'Erro ao alterar Obs. para faturamento/expediçãos.', ['&Ok']);
    end;
  finally
    pFreeAndNil(LfrmFatMensagemNotaF11);
  end;
end;

procedure TfrmCtrLiberaPedidosConf.btnCadCliClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('frmCadClientes') Then
    Exit;

  Try
    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    frmCadClientes.strCodClienteIniciarCadastro := edtCodCli.Text;
    frmCadClientes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadClientes);
end;

procedure TfrmCtrLiberaPedidosConf.btnCadProdutoClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('frmCadProdutos') Then
    pCriarForm(TfrmCadProdutos, frmCadProdutos)
  Else
    pMensagemOk('Este usuário não tem permissão para acessar o cadastro de produtos.');
end;

procedure TfrmCtrLiberaPedidosConf.pCriarColunasDeSaldoEmpresaNaQueryItens(Var qryItens : TUniQuery);
  Var
    qryTmp : TUniQuery;
begin
  If (fCfgSis('EXCOLP', varString) = 'N') Then
    Exit;

  qryTmp := fGetTodasEmpresas;

  If qryTmp <> Nil Then
  Begin
    qryTmp.First;

    While Not qryTmp.Eof Do
    Begin
      qryItens.SQL.Add('  0.00 ITE_SAL' + qryTmp.FieldByName('EMP_CODEMP').AsString + ', ');
      qryTmp.Next;
    End;

    FreeAndNil(qryTmp);
  End;

  qryItens.SQL.Add('  0.00 ITE_SALTOT, ');
end;

procedure TfrmCtrLiberaPedidosConf.pMostraItens(pgbStatus: TcxProgressBar = nil);
  Var
    qryItens: TUniQuery;
Begin
  pInformacao('Aguarde, Carregado produtos do pedido...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  Screen.Cursor := crHourGlass;

  qryItens := fCriaQuery;

  try
    With qryItens Do
    Begin

      Close;
      SQL.Clear;

      SQL.Add('SELECT         ');
      SQL.Add('  " " AS AVAL, ');
      SQL.Add('  FATGOR.AUTOINCREM, ');
      SQL.Add('  FATGOR.AUTOINCREM AS FGOINC, ');
      SQL.Add('  FATDOR.AUTOINCREM AS FDOINC, ');
      SQL.Add('  FGO_TIPPED,  ');
      SQL.Add('  CAST("NORMAL" AS CHAR(8)) AS ITE_SITUAC, ');
      SQL.Add('  FDO_CODITE,  ');

      SQL.Add('  C.ITE_CODFAB,');

      SQL.Add('  FDO_TABPRE,  ');

      SQL.Add('  I.ITE_PRECUS,');
      SQL.Add('  I.ITE_PREMED,');
      SQL.Add('  I.ITE_PREVE1,');
      SQL.Add('  I.ITE_PREVE2,');
      SQL.Add('  I.ITE_PREVE3,');
      SQL.Add('  I.ITE_PREVE4,');
      SQL.Add('  I.ITE_PREVE5,');
      SQL.Add('  I.ITE_PREVE6,');
      SQL.Add('  I.ITE_PREVE7,');

      If (fCfgSis('PCMPRO', varString) = '1') Then
        SQL.Add('  0.00 AS ITE_COMTBL, ')
      Else
      Begin
        SQL.Add('  IFNULL((CASE IF(IFNULL(FDO_TABPRE, "") = "", FATGOR.FGO_TABPRE, FDO_TABPRE) ');
        SQL.Add('            WHEN "1" THEN I.ITE_COMTB1 ');
        SQL.Add('            WHEN "2" THEN I.ITE_COMTB2 ');
        SQL.Add('            WHEN "3" THEN I.ITE_COMTB3 ');
        SQL.Add('            WHEN "4" THEN I.ITE_COMTB4 ');
        SQL.Add('            WHEN "5" THEN I.ITE_COMTB5 ');
        SQL.Add('            WHEN "6" THEN I.ITE_COMTB6 ');
        SQL.Add('            WHEN "7" THEN I.ITE_COMTB7 ');
        SQL.Add('          END ), 0) AS ITE_COMTBL, ');
      End;

      SQL.Add('  IF(' + fSubSelPrecoPromocao + ' IS NULL, FDO_DESCRI, CONCAT("* ", FDO_DESCRI)) AS FDO_DESCRI, ');

      SQL.Add('  FDO_REFERE,  ');
      SQL.Add('  MAR_DESMAR,  ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -(' + SQL_QTD + '), ' + SQL_QTD + ') AS FDO_QTDITE, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -(' + SQL_VLR.Replace('/*<<REFORMA_FDO>>*/', fSqlValorReformaFdoRef('FATDOR.AUTOINCREM')) + '), ' +
                                             SQL_VLR.Replace('/*<<REFORMA_FDO>>*/', fSqlValorReformaFdoRef('FATDOR.AUTOINCREM')) + ') AS FDO_VLRCON, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -' + SQL_VICM + ', ' + SQL_VICM + ') AS FDO_VALICM, ');
      SQL.Add('  0.0000 AS FDO_MARPER, ');
      SQL.Add('  0.0000 AS FDO_MARDIN, ');
      SQL.Add('  0.0000 AS FDO_PRECUS, ');
      SQL.Add('  0.0000 AS FDO_CUSTOT, ');
      SQL.Add('  0.0000 AS FDO_MERTOT, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * FDO_UNITAR                                    AS FDO_UNITAR, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (FDO_TOTITE - FDO_DESESP) / FDO_QTDITE        AS FDO_UNILIQ, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (FDO_VALIPI / FDO_QTDITE)                     AS FDO_IPILIQ, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (FDO_TOTFRE / FDO_QTDITE)                     AS FDO_FRELIQ, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (FDO_DESESP / FDO_QTDITE)                     AS FDO_DESLIQ, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (FDO_DESACE / FDO_QTDITE)                     AS FDO_ACELIQ, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (' + SQL_QTD + ' * (FDO_TOTCUS / FDO_QTDITE)) AS FDO_TOTCUS, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (' + SQL_QTD + ' * (FDO_TOTMED / FDO_QTDITE)) AS FDO_TOTMED, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (' + SQL_QTD + ' * (FDO_TOTCU2 / FDO_QTDITE)) AS FDO_TOTCU2, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * (' + SQL_QTD + ' * (FDO_PRCTIN / FDO_QTDITE)) AS FDO_PRCTIN, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -1, 1) * FDO_UNIORI                                    AS FDO_UNIORI, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -FDO_ALQIPI, FDO_ALQIPI)       AS FDO_ALQIPI, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -FDO_VALRET, FDO_VALRET)       AS ITE_SUBSTI, ');
      SQL.Add('  IF(LEFT(FDO_CLAFIS,1)<5, -FDO_PERCOM, FDO_PERCOM)       AS FDO_PERCOM, ');
      SQL.Add('  FDO_CLAFIS,   ');
      SQL.Add('  FDO_CODFIS,   ');
      SQL.Add('  FDO_NUMDOC,   ');
      SQL.Add('  FDO_ESPDOC,   ');
      SQL.Add('  FDO_CODEMP,   ');
      SQL.Add('  FDO_DESESP,   ');
      SQL.Add('  FGO_NTRAVA,   ');
      SQL.Add('  FGO_MOTLIB,   ');
      SQL.Add('  FGO_LIBCOM,   ');
      SQL.Add('  FGO_CONPAG,   ');
      SQL.Add('  FGO_VLRCON,   ');
      SQL.Add('  FGO_TOTFRE,   ');
      SQL.Add('  FGO_VPAR01,   ');
      SQL.Add('  FGO_VPAR02,   ');
      SQL.Add('  FGO_VPAR03,   ');
      SQL.Add('  FGO_VPAR04,   ');
      SQL.Add('  FGO_VPAR05,   ');
      SQL.Add('  FGO_VPAR06,   ');
      SQL.Add('  FGO_VPAR07,   ');
      SQL.Add('  FGO_VPAR08,   ');
      SQL.Add('  FGO_VPAR09,   ');
      SQL.Add('  FGO_VPAR10,   ');
      SQL.Add('  FGO_VPAR11,   ');
      SQL.Add('  FGO_VPAR12,   ');
      SQL.Add('  FGO_CORTE_,   ');
      SQL.Add('  FDO_BASICM,   ');
      SQL.Add('  FDO_ALQICM,   ');
      SQL.Add('  FGO_VENPRE,   ');
      SQL.Add('  ETC_CIDENT,   ');
      SQL.Add('  FGO_ESTADO,   ');
      SQL.Add('  CLI_CONSUM,   ');
      SQL.Add('  CLI_CODATI,   ');
      SQL.Add('  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%", FGO_IESCON, CLI_I_E_S_) AS I_E_S_, ');
      SQL.Add('  ABF_CODABF,   ');

      If Not fEmptyStr(strTipAbf) Then
      Begin
        If fCampoExiste('ABFICM', 'ABF_BASICM' + strTipAbf, True) Then
          SQL.Add(' ABF_BASICM' + strTipAbf + ', ')
        Else
          SQL.Add(' 0.00 AS ABF_BASICM' + strTipAbf + ', ');
      End;

      SQL.Add('  0.00 ITE_SALDIS, ');
      SQL.Add('  C.ITE_CNV_ML, ');
      SQL.Add('  IF(IFNULL(FDO_UNIORI, 0) = 0, FDO_UNITAR, FDO_UNIORI) AS FDO_PRESUG, ');
      SQL.Add('  ((IF(IFNULL(FDO_UNIORI, 0) = 0, FDO_UNITAR, FDO_UNIORI) - FDO_UNITAR) / IF(IFNULL(FDO_UNIORI, 0) = 0, FDO_UNITAR, FDO_UNIORI)) * 100 AS FDO_DESCON, ');
      SQL.Add('  I.ITE_DESMAX, ');

      SQL.Add('  I.ITE_IMPDIR AS GER_IMPDIR, ');
      SQL.Add('  C.ITE_IMPDIR AS ITE_IMPDIR, ');
      SQL.Add('  IFNULL(FDO_TAXJUR, 0.00) AS FDO_TAXJUR, ');
      SQL.Add('  FDO_PROMOC,   ');
      SQL.Add('  FDO_ENTRET,   ');
      SQL.Add('  FDO_ENTFUT,   ');
      SQL.Add('  FDO_MOTFUT,   ');
      SQL.Add('  C.ITE_DESITE, ');
      SQL.Add('  FDO_PROACA,   ');
      SQL.Add('  FDO_IDEPRO,   ');
      SQL.Add('  FDO_CODCLI,   ');
      SQL.Add('  IF( IFNULL(FDO_TABPRE, "") = "", FGO_TABPRE, FDO_TABPRE) AS TABPRE, ');
      SQL.Add('  FGO_CODCND,   ');
      SQL.Add('  FDO_BASRET,   ');
      SQL.Add('  FDO_SEQIND,   ');
      SQL.Add('  FDO_SEQINC,   ');
      SQL.Add('  FDO_EMPITE,   ');

      pCriarColunasDeSaldoEmpresaNaQueryItens(qryItens);

      SQL.Add('  FGO_TOTPRO,      ');
      SQL.Add('  FGO_DESACE,      ');
      SQL.Add('  FGO_TOTIPI,      ');
      SQL.Add('  FGO_TOTRET,      ');
      SQL.Add('  FDO_TOTFRE,      ');
      SQL.Add('  EXTDOR.FDO_VALFCP,');
      SQL.Add('  FDO_TOTITE,      ');

      SQL.Add('  IFNULL(DORICD.ICD_PERFCP,0) AS ALQ_FCP, ');
      SQL.Add('  IF( IFNULL(DORICD.ICD_VALDES,0) > 0, (IFNULL(DORICD.ICD_ALQUFD,0) - IFNULL(DORICD.ICD_ALQINE,0)),0 ) AS ALQ_DIFAL ');

      SQL.Add('FROM           ');
      SQL.Add('  FATGOR       ');
      SQL.Add('  JOIN FATDOR   ON FDO_NUMDOC        = FGO_NUMDOC ');
      SQL.Add('               AND FDO_ESPDOC        = FGO_ESPDOC ');
      SQL.Add('               AND FDO_CODEMP        = FGO_CODEMP ');
      SQL.Add('  JOIN ITEGER I ON I.ITE_CODITE      = FDO_CODITE ');
      SQL.Add('               AND I.ITE_CODEMP      = FDO_CODEMP ');
      SQL.Add('  JOIN CADMAR   ON MAR_CODMAR        = FDO_CODMAR ');
      SQL.Add('  JOIN CADITE C ON C.ITE_CODITE      = FDO_CODITE ');
      SQL.Add('  JOIN EXTGOR   ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ');
      SQL.Add('  JOIN CADCLI   ON FDO_CODCLI = CLI_CODCLI ');

      If fCfgSis('TIPABF') = '1' Then
        SQL.Add(' JOIN ABFICM ON ABF_CODABF = C.ITE_CODABF ')
      Else
        SQL.Add(' JOIN ABFICM ON ABF_CODABF = I.ITE_CODABF ');

      SQL.Add('              AND ABF_ESTADO = FGO_ESTADO ');

      SQL.Add('  LEFT JOIN DORICD ON DORICD.ICD_SEQFDO = FATDOR.AUTOINCREM ');

      SQL.Add('  LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ');

      SQL.Add('  LEFT JOIN AUXGOR ON AUXGOR.AUX_SEQGER = FATGOR.AUTOINCREM ');

      SQL.Add('  LEFT JOIN ENTCLI ON ETC_CODCLI = FGO_CODCLI ');
      SQL.Add('                  AND IF(AUX_ENTGER IS NOT NULL, ENTCLI.AUTOINCREM = AUX_ENTGER, ');
      SQL.Add('                         ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = CLI_CODCLI)) ');

      SQL.Add('WHERE          ');
      SQL.Add('  FGO_NUMDOC = :NUMDOC        AND ');
      SQL.Add('  FGO_CODEMP = :CODEMP        AND ');
      SQL.Add('  FGO_ESPDOC = "PD"           AND ');
      SQL.Add('  FDO_QTDITE - FDO_QTDBAI > 0 ');

      SQL.Add('ORDER BY FDO_REFERE   ');

      ParamByName('CODEMP').AsString := Trim(edtCodEmp.Text);
      ParamByName('NUMDOC').AsString := Trim(edtNumDoc.Text);
      Open;

      Screen.Cursor := crDefault;

      If IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum Item referente ao pedido informado!', ['&O k']);
        blnFecharTela := True;
      End;

    End;

    cdsItens := fCriaClientDatset(qryItens, False, Self);

    With cdsItens Do
    Begin
      (FieldByName('FDO_QTDITE') As TFloatField).DisplayFormat := '#,##0.000';
      (FieldByName('FDO_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_VALICM') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_MARPER') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_MARDIN') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_UNITAR') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_PRESUG') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_DESCON') As TFloatField).DisplayFormat := '#,##0.00%';
      (FieldByName('FDO_CUSTOT') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_PRECUS') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_ALQIPI') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_SUBSTI') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_PERCOM') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ITE_DESMAX') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_UNILIQ') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_DESESP') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('FDO_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
    End;

    dtsItens.DataSet := cdsItens;
    cdsItens.AfterScroll := pAfterScroll;
    pMontaSaldoItens(cdsItens, pgbStatus);
  finally
    FreeAndNil(qryItens);
    Screen.Cursor := crDefault;
  end;
End;

procedure TfrmCtrLiberaPedidosConf.pCriarColunasDeSaldoEmpreasNoGrid;
  Var
    qryEmp : TUniQuery;
begin
  If (fCfgSis('EXCOLP', varString) = 'N') Then
    Exit;

  qryEmp := fGetTodasEmpresas;

  qryEmp.First;
  While Not qryEmp.Eof Do
  Begin
    pAddCol('ITE_SAL' + qryEmp.FieldByName('EMP_CODEMP').AsString,
            'LOJA '   + qryEmp.FieldByName('EMP_CODEMP').AsString);
    qryEmp.Next;
  End;

  FreeAndNil(qryEmp);

  pAddCol('ITE_SALTOT', 'TOTAL');
end;

procedure TfrmCtrLiberaPedidosConf.pAddCol(strField, strCaption: String; blnVisible: Boolean = True;
  blnSorting: Boolean = True; blnFiltering: Boolean = True);
begin
  With cxgItensDados.CreateColumn, Options, DataBinding Do
  Begin
    Name      := cxgItensDados.Name + strField;
    FieldName := strField;
    Caption   := strCaption;
    Visible   := blnVisible;
    Sorting   := blnSorting;
    Filtering := blnFiltering;

    If (cdsItens.FindField(strField) <> Nil) Then
    Begin
      If cdsItens.FindField(strField).DataType = ftFloat Then
        HeaderAlignmentHorz := taRightJustify
      Else
        HeaderAlignmentHorz := taLeftJustify;
    End;
  End;
end;

procedure TfrmCtrLiberaPedidosConf.pMontaGrid(pgbStatus: TcxProgressBar = nil);
  Var
    intRecNo: Integer;
    blnMostraCustoMargem: Boolean;
begin
  pInformacao('Aguarde, Criando Grid dos produtos...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  blnMostraCustoMargem := (fCfgSis('ECMLBP', varString) = 'S') And fVerificaAcessoSistema('LIBPEDVISMLPC');
  cxgItensDados.BeginUpdate;
  Try
    cxgItensDados.ClearItems;

    pAddCol('AVAL', 'Aval.', True, False, False);

    pAddCol('ITE_SITUAC', 'Situação');
    pAddCol('FGO_TIPPED', 'Tipo');
    pAddCol('FDO_CODITE', 'Código');
    pAddCol('ITE_CODFAB', 'Cód.Fábrica');
    pAddCol('FDO_DESCRI', 'Descrição');
    pAddCol('FDO_REFERE', 'Referência');
    pAddCol('MAR_DESMAR', 'Marca');
    pAddCol('FDO_QTDITE', 'Quantidade');
    pAddCol('FDO_TABPRE', 'TP');
    pAddCol('FDO_PRESUG', 'Pr.Ven.Sugerido');
    pAddCol('FDO_UNITAR', 'Pr.Unit.Venda');
    pAddCol('FDO_DESCON', 'Desc.Concedido');

    pAddCol('ITE_DESMAX', 'Desc.Máx.Produto', VS_strTRADES = '2');

    pAddCol('FDO_PRECUS', 'Pr.Unit.Custo');
    pAddCol('FDO_UNILIQ', 'Pr.Unit.Ven.Líq.');
    pAddCol('FDO_TOTITE', 'Total Item');
    pAddCol('FDO_DESESP', 'Desc.Especial');
    pAddCol('FDO_VLRCON', 'Preço Venda');

    pAddCol('FDO_CUSTOT', 'Custo Real', blnMostraCustoMargem);
    pAddCol('FDO_MARPER', 'M.L. %'     , blnMostraCustoMargem);
    pAddCol('FDO_MARDIN', 'M.L. R$'    , blnMostraCustoMargem);

    pAddCol('FDO_ALQIPI', '% I.P.I.');
    pAddCol('FDO_VALICM', 'Vlr.ICMS.');
    pAddCol('ITE_SUBSTI', 'Subst.Trib.');
    pAddCol('FDO_PERCOM', '% Comiss.Vend.');

    pCriarColunasDeSaldoEmpreasNoGrid;

    pAddCol('ITE_PREVE1', 'Preço Venda 1', False);
    pAddCol('ITE_PREVE2', 'Preço Venda 2', False);
    pAddCol('ITE_PREVE3', 'Preço Venda 3', False);
    pAddCol('ITE_PREVE4', 'Preço Venda 4', False);
    pAddCol('ITE_PREVE5', 'Preço Venda 5', False);
    pAddCol('ITE_PREVE6', 'Preço Venda 6', False);
    pAddCol('ITE_PREVE7', 'Preço Venda 7', False);

    pAddCol('FDO_IDEPRO', 'Id.Tinta', False);
    pAddCol('FDO_UNIORI', 'Un.Ori.', False);

    pAddCol('FDO_PROMOC', 'Promocional', False);
  Finally
    cxgItensDados.EndUpdate;
  End;

  pInformacao('Aguarde, Ajustando Grid dos produtos...', pgbStatus);
  pProgresso(0, 0, pgbStatus);

  cxgItensDados.BeginUpdate;
  try
    cxgItensDados.ApplyBestFit;
  finally
    cxgItensDados.EndUpdate;
  end;

  cxgItensDados.StoreToStream(mmsLayoutDefault);

  If fGetFuncoesCxGrid.fCarregarView(cxgItensDados, fGetChaveLayoutGrid, cdsItens, intRecNo) Then
  Begin
    cxgItensDados.GetColumnByFieldName('ITE_DESMAX').Visible := VS_strTRADES = '2';
    cxgItensDados.GetColumnByFieldName('FDO_CUSTOT').Visible := blnMostraCustoMargem;
    cxgItensDados.GetColumnByFieldName('FDO_MARPER').Visible := blnMostraCustoMargem;
    cxgItensDados.GetColumnByFieldName('FDO_MARDIN').Visible := blnMostraCustoMargem;
    pDesabilitarColunasDeSaldoEmpresa;
    pHabilitarColunasDeSaldoEmpresa;
  End;

  pSetFocus(cxgItens);
end;

procedure TfrmCtrLiberaPedidosConf.pDesabilitarColunasDeSaldoEmpresa;
  Var
    intCnt : Integer;
begin
  If (fCfgSis('EXCOLP', varString) = 'S') Then
    Exit;
  For intCnt := 0 To cxgItensDados.ColumnCount-1 Do
  Begin
    If (Not fEmptyStr(cxgItensDados.Columns[intCnt].DataBinding.FieldName)) Then
      Continue;
    If (Pos('ITE_SAL', cxgItensDados.Columns[intCnt].Name) <= 0) Then
      Continue;
    cxgItensDados.Columns[intCnt].Visible := False;
  End;
end;

procedure TfrmCtrLiberaPedidosConf.pHabilitarColunasDeSaldoEmpresa;
  Var
    intCnt : Integer;
begin
  If (fCfgSis('EXCOLP', varString) = 'N') Then
    Exit;
  For intCnt := 0 To cxgItensDados.ColumnCount-1 Do
  Begin
    If cxgItensDados.Columns[intCnt].Visible Then
      Continue;
    If (Pos('ITE_SAL', cxgItensDados.Columns[intCnt].Name) <= 0) Then
      Continue;
    cxgItensDados.Columns[intCnt].Visible := True;
  End;
end;

function TfrmCtrLiberaPedidosConf.fGetChaveLayoutGrid: String;
begin
  Result := Self.Name + '.' + strTipLib + '.' + cxgItensDados.Name;
end;

procedure TfrmCtrLiberaPedidosConf.pMostraStatus;
begin
  {***************************}
  {* MOSTRA STATUS DO PEDIDO *}
  {************************RV*}
  If (strPedLib = '0') And
     ((fCfgSis('AGDLBT', VarBoolean) Or ((fCfgSis('LPPDBL') = 'S') And
                                         (fCfgSis('AGDLIB', VarBoolean) Or (fCfgSis('LIBVIS') = 'S'))))) Then
  Begin
    If cdsItens.FieldByName('FGO_LIBCOM').AsInteger = 0 Then
    Begin
      pnlInfo.Font.Color := clRed;
      pnlInfo.Font.Style := [fsBold];
      pnlInfo.Visible    := True;
      pnlInfo.Caption    := 'AGUARDANDO LIBERAÇÃO DA GERÊNCIA!';
    End;
  End;
end;

procedure TfrmCtrLiberaPedidosConf.pnlExiMsgClick(Sender: TObject);
begin
  inherited;
  If (pnlMensagens.Height = (pnlExiMsg.Height + 1)) Then
  Begin
    pnlMensagens.Height := 180;
    pnlExiMsg.Caption := '>>> clique aqui para ocultar as mensagens do pedido <<<';
  End
  Else
  Begin
    pnlMensagens.Height := (pnlExiMsg.Height + 1);
    pnlExiMsg.Caption := '>>> clique aqui para visualizar as mensagens do pedido <<<';
  End;
end;

procedure TfrmCtrLiberaPedidosConf.pAtualizaInfoDifalFCP(strFdoInc: String);
  Var
    item : TDadosFechamento;
begin
  edtTotDif.Text := '0,00';
  edtAlDifa.Text := '0,00';
  edtPerFcp.Text := '0,00';
  edtValFcp.Text := '0,00';

  edtLucroLiqComDifal.Text  := '0,00';
  edtMargemLiqComDifal.Text := '0,00';

  For item In fatVenda.arrMatItens Do
  Begin
    If (item.strAutIncDet = strFdoInc) Then
    Begin
      edtTotDif.Text := FloatToStrF(item.recDifalFCP.fltDifOri + item.recDifalFCP.fltDifDes, ffFixed, 12, 2);
      edtAlDifa.Text := fSuprimirZeroDireita(FloatToStrF(item.recDifalFCP.fltAlDifa, ffFixed, 12, 2));
      edtPerFcp.Text := fSuprimirZeroDireita(FloatToStrF(item.recDifalFCP.fltPerFcp, ffFixed, 12, 2));
      edtValFcp.Text := FloatToStrF(item.recDifalFCP.fltValFcp, ffFixed, 12, 2);

      If (TMargemMinima.UsaPrecoMedio) Then
      Begin
        edtLucroLiqComDifal.Text := FloatToStrF((cdsItens.FieldByName('FDO_UNILIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat) -
                                                (cdsItens.FieldByName('FDO_MERTOT').AsFloat + (item.recDifalFCP.fltDifOri + item.recDifalFCP.fltDifDes)), ffFixed, 12, 2);

        edtMargemLiqComDifal.Text := fSuprimirZeroDireita(FloatToStrF(fCalculaPrecoVenda(2,
                                                                                         cdsItens.FieldByName('FDO_MERTOT').AsFloat + (item.recDifalFCP.fltDifOri + item.recDifalFCP.fltDifDes),
                                                                                         cdsItens.FieldByName('FDO_UNILIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat,
                                                                                         0,
                                                                                         0,
                                                                                         0,
                                                                                         0,
                                                                                         0), ffFixed, 12, 2));
      End
      Else
      Begin
        {Cálculo do L.L com Difal (R$) e Margem L. com Difal (%) do *Produto}
        edtLucroLiqComDifal.Text := FloatToStrF(
        (cdsItens.FieldByName('FDO_UNILIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat) -
        (cdsItens.FieldByName('FDO_CUSTOT').AsFloat + (item.recDifalFCP.fltDifOri + item.recDifalFCP.fltDifDes)), ffFixed, 12, 2);

        edtMargemLiqComDifal.Text := fSuprimirZeroDireita(FloatToStrF(fCalculaPrecoVenda(2,
                                                                                         cdsItens.FieldByName('FDO_CUSTOT').AsFloat + (item.recDifalFCP.fltDifOri + item.recDifalFCP.fltDifDes),
                                                                                         cdsItens.FieldByName('FDO_UNILIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat,
                                                                                         0,
                                                                                         0,
                                                                                         0,
                                                                                         0,
                                                                                         0), ffFixed, 12, 2));
      End;

      Break;

    End;
  End;
end;

procedure TfrmCtrLiberaPedidosConf.pAtualizaMargemBruta;
begin
  If (TMargemMinima.UsaPrecoMedio) Then
  Begin
    edtPerMargemBruta.Text := fSuprimirZeroDireita(FloatToStrF(fCalculaPrecoVenda(2, cdsItens.FieldByName('FDO_TOTMED').AsFloat, (cdsItens.FieldByName('FDO_QTDITE').AsFloat * cdsItens.FieldByName('FDO_UNILIQ').AsFloat), 0, 0, 0, 0, 0) , ffFixed, 12, 2));
    edtValMargemBruta.Text := FloatToStrF((cdsItens.FieldByName('FDO_QTDITE').AsFloat * cdsItens.FieldByName('FDO_UNILIQ').AsFloat) - cdsItens.FieldByName('FDO_TOTMED').AsFloat , ffFixed, 12, 2);
  End
  Else
  Begin
    edtPerMargemBruta.Text := fSuprimirZeroDireita(FloatToStrF(fCalculaPrecoVenda(2, cdsItens.FieldByName('FDO_TOTCUS').AsFloat, (cdsItens.FieldByName('FDO_QTDITE').AsFloat * cdsItens.FieldByName('FDO_UNILIQ').AsFloat), 0, 0, 0, 0, 0) , ffFixed, 12, 2));
    edtValMargemBruta.Text := FloatToStrF((cdsItens.FieldByName('FDO_QTDITE').AsFloat * cdsItens.FieldByName('FDO_UNILIQ').AsFloat) - cdsItens.FieldByName('FDO_TOTCUS').AsFloat , ffFixed, 12, 2);
  End;
end;

procedure TfrmCtrLiberaPedidosConf.pPreencheMatrizECalculaDifalFCP;
var
  intPosicao : Integer;
  prcScroll: TprcScroll;
begin
  pDisableControls(cdsItens, prcScroll);

  try
    SetLength(fatVenda.arrMatItens, 0);

    fatVenda.strCodCli := edtCodCli.Text;
    //  > fatVenda.fltPeBaDf

    fatVenda.strCodFor := '';
    fatVenda.strOpcDoc := 'PD';
    fatVenda.strClaFis := '';
    fatVenda.blnNCFornecedor := False;
    fatVenda.strNotImp := 'N';
    fatVenda.blnVendaPresencial := (cdsItens.FieldByName('FGO_VENPRE').AsString = 'S');
    fatVenda.strEstEnt := fRetNomCidade(cdsItens.FieldByName('ETC_CIDENT').AsString, 1);
    fatVenda.blnCliFil := fatVenda.fClienteFilialVenda(edtCodCli.Text);
    fatVenda.strCliEst := cdsItens.FieldByName('FGO_ESTADO').AsString;
    fatVenda.strCliCon := cdsItens.FieldByName('CLI_CONSUM').AsString;
    fatVenda.strCliIes := cdsItens.FieldByName('I_E_S_').AsString;
    fatVenda.strCliAti := cdsItens.FieldByName('CLI_CODATI').AsString;

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      SetLength(fatVenda.arrMatItens, Length(fatVenda.arrMatItens) + 1);
      intPosicao := Length(fatVenda.arrMatItens) - 1;

      If fEmptyStr(fatVenda.strClaFis) Then
        fatVenda.strClaFis := cdsItens.FieldByName('FDO_CLAFIS').AsString;

      fatVenda.arrMatItens[intPosicao].strAutIncDet := cdsItens.FieldByName('FDOINC').AsString;
      fatVenda.arrMatItens[intPosicao].strCodIte := cdsItens.FieldByName('FDO_CODITE').AsString;
      fatVenda.arrMatItens[intPosicao].strCodFis := cdsItens.FieldByName('FDO_CODFIS').AsString;
      fatVenda.arrMatItens[intPosicao].strIteAbf := cdsItens.FieldByName('FDO_CODITE').AsString;
      fatVenda.arrMatItens[intPosicao].strCodAbf := cdsItens.FieldByName('ABF_CODABF').AsString;
      fatVenda.arrMatItens[intPosicao].opcINFesp := opcVazio;

      fatVenda.arrMatItens[intPosicao].fltBas__S := 0;
      If Not fEmptyStr(strTipAbf) Then
        fatVenda.arrMatItens[intPosicao].fltBas__S := cdsItens.FieldByName('ABF_BASICM' + strTipAbf).AsFloat;

      fatVenda.arrMatItens[intPosicao].fltDesEsp := fFormataFloat(cdsItens.FieldByName('FDO_DESLIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat, 2);
      fatVenda.arrMatItens[intPosicao].fltTotIte := fFormataFloat(cdsItens.FieldByName('FDO_UNILIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat, 2);
      fatVenda.arrMatItens[intPosicao].fltValIpi := fFormataFloat(cdsItens.FieldByName('FDO_IPILIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat, 2);
      fatVenda.arrMatItens[intPosicao].fltValFre := fFormataFloat(cdsItens.FieldByName('FDO_FRELIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat, 2);
      //fatVenda.arrMatItens[intPosicao].fltDesAce := fFormataFloat(cdsItens.FieldByName('FDO_ACELIQ').AsFloat * cdsItens.FieldByName('FDO_QTDITE').AsFloat, 2);
      fatVenda.arrMatItens[intPosicao].fltAlqIcm := cdsItens.FieldByName('FDO_ALQICM').AsFloat;
      fatVenda.arrMatItens[intPosicao].fltBasIcm := cdsItens.FieldByName('FDO_BASICM').AsFloat;
      fatVenda.arrMatItens[intPosicao].strCodSit := cdsItens.FieldByName('FDO_CODFIS').AsString;
      fatVenda.arrMatItens[intPosicao].fltQtdIte := cdsItens.FieldByName('FDO_QTDITE').AsFloat;
      fatVenda.arrMatItens[intPosicao].fltBasRet := cdsItens.FieldByName('FDO_BASRET').AsFloat;

      fatVenda.pCalculaGravaICMSUFDestino('', '', fatVenda.arrMatItens[intPosicao]);

      cdsItens.Next;
    End;
  finally
    pEnableControls(cdsItens, prcScroll);
  end;
end;

procedure TfrmCtrLiberaPedidosConf.spbDuplicatasClick(Sender: TObject);
  Var
    intCont: Integer;
    strFpgNeg: String;
    arrValores: TDoubleArray;

  function fCampo(strCampo: String): Tfield;
  begin
    Result := cdsItens.FieldByName('FGO_' + strCampo);
  end;

begin
  inherited;

  If cdsItens.IsEmpty Then
    Exit;

  fatVenda.strCodFpg := edtCodFpg.Text;
  fatVenda.objFormasPagtoNegociada.pCarregarFormasPagtoNegociadas(cdsItens.FieldByName('FGOINC').AsString);

  If (fatVenda.strCodFpg = '009') And
     (Not fEmptyStr(fatVenda.objFormasPagtoNegociada.fGetFormasPagtoSelecionadas)) Then
  Begin
    strFpgNeg := fatVenda.fDefinirMsgFormasPagamentoNegociada('Formas de Pagamento Negociadas no Pedido de Venda' +
      #13#10 + STRING_FORMAS_PAGTO_NEGOCIADAS);

    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);

    Try
      frmMensagemExplicativa.Caption := 'Formas de Pagamento Negociadas';
      frmMensagemExplicativa.Width   := 600;
      frmMensagemExplicativa.Height  := 300;
      frmMensagemExplicativa.mmoInstru.Lines.Add(strFpgNeg);
      frmMensagemExplicativa.ShowModal;
    Finally
      pFreeAndNil(frmMensagemExplicativa);
    End;

    Exit;
  End;

  SetLength(arrValores, StrToIntDef(LeftStr(fCampo('CONPAG').AsString, 2), 0));
  pCarregaDuplicatasCND(1,cdsItens.FieldByName('AUTOINCREM').AsString, fatVenda.arrDuplicataCND);

  For intCont := 1 To Length(arrValores) Do
    arrValores[intCont-1] := fatVenda.arrDuplicataCND[intCont-1].curValor;

  fDigDuplic(fatVenda.arrDuplicata,
             fCampo('CONPAG').AsString,
             0,
             Sum(arrValores),
             True,
             False,
             False,
             VS_Date,
             False,
             0,
             'N',
             False,
             False,
             0,
             False,
             arrValores,
             '',
             True,
             False);
end;

procedure TfrmCtrLiberaPedidosConf.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharTela) Then
    Close;
end;

procedure TfrmCtrLiberaPedidosConf.pAfterScroll(DataSet: TDataSet);
Begin
  edtCusto.Text       := FloatToStrF(cdsItens.FieldByName('FDO_TOTCUS').AsFloat, ffFixed, 12, 2);
  edtCustoReal.Text   := FloatToStrF(cdsItens.FieldByName('FDO_CUSTOT').AsFloat, ffFixed, 12, 2);
  edtPreVen.Text      := FloatToStrF(cdsItens.FieldByName('FDO_VLRCON').AsFloat, ffFixed, 12, 2);
  edtMlPer.Text       := fSuprimirZeroDireita(FloatToStrF(cdsItens.FieldByName('FDO_MARPER').AsFloat, ffFixed, 12, 2));
  edtMlVal.Text       := FloatToStrF(cdsItens.FieldByName('FDO_MARDIN').AsFloat, ffFixed, 12, 2);
  edtIPIPer.Text      := fSuprimirZeroDireita(FloatToStrF(cdsItens.FieldByName('FDO_ALQIPI').AsFloat, ffFixed, 12, 2));
  edtIPIVal.Text      := FloatToStrF(cdsItens.FieldByName('FDO_IPILIQ').AsFloat, ffFixed, 12, 2);
  edtPerIcms.Text     := fSuprimirZeroDireita(FloatToStrF(cdsItens.FieldByName('FDO_ALQICM').AsFloat, ffFixed, 12, 2));
  edtValIcms.Text     := FloatToStrF(cdsItens.FieldByName('FDO_VALICM').AsFloat, ffFixed, 12, 2);
  edtSitTrib.Text     := FloatToStrF(cdsItens.FieldByName('ITE_SUBSTI').AsFloat, ffFixed, 12, 2);
  edtVenPer.Text      := fSuprimirZeroDireita(FloatToStrF(cdsItens.FieldByName('FDO_PERCOM').AsFloat, ffFixed, 12, 2));
  edtFCPSitTrib.Text  := FloatToStrF(cdsItens.FieldByName('FDO_VALFCP').AsFloat, ffFixed, 12, 2);



  pAtualizaInfoDifalFCP(cdsItens.FieldByName('FDOINC').AsString);
  pAtualizaMargemBruta;
End;

procedure TfrmCtrLiberaPedidosConf.btnMotivoBloqClick(Sender: TObject);
  Var
    qryBloq: TUniQuery;
    iCont: integer;
begin

  inherited;

  If fLiberacaoRemotaNoFinalVenda And fUsaLiberacaoPedidosConformeEscolhaDoOperador And (Not blnLibPed) Then
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(195, 7523, [],
                          ['NUMDOC','ESPDOC','CODEMP'],
                          [cdsItens.FieldByName('FDO_NUMDOC').AsString,
                          cdsItens.FieldByName('FDO_ESPDOC').AsString,
                          cdsItens.FieldByName('FDO_CODEMP').AsString],
                          Sender,
                          ['NUMDOC','ESPDOC','CODEMP'],
                          False);
    End;

    Exit;

  End;

  {******************************************************************}
  {*      CARREGA OS CAMPOS DA TELA MOTIVO BLOQUEIO PEDIDOS         *}
  {****************************************************************PZ}
  Try
    qryBloq := fCriaQuery;

    qryBloq.SQL.Clear;
    qryBloq.SQL.Add('SELECT SQL_NO_CACHE ');
    qryBloq.SQL.Add('  EMP_NOMEMP,       ');
    qryBloq.SQL.Add('  LOG_DTACAD,       ');
    qryBloq.SQL.Add('  LOG_HRACAD,       ');
    qryBloq.SQL.Add('  LOG_OBSERV,       ');
    qryBloq.SQL.Add('  LOG_CODOPE,       ');
    qryBloq.SQL.Add('  LOG_CODVEN,       ');
    qryBloq.SQL.Add('  P.OPE_NOMOPE AS OPE_NOMOPE, ');
    qryBloq.SQL.Add('  V.OPE_NOMOPE AS OPE_NOMVEN  ');
    qryBloq.SQL.Add('FROM     ');
    qryBloq.SQL.Add('  LOGLIB ');
    qryBloq.SQL.Add('  LEFT JOIN CADOPE P ON P.OPE_CODOPE = LOG_CODOPE ');
    qryBloq.SQL.Add('  LEFT JOIN CADOPE V ON V.OPE_CODOPE = LOG_CODVEN ');
    qryBloq.SQL.Add('  LEFT JOIN CADEMP   ON   EMP_CODEMP = LOG_CODEMP ');
    qryBloq.SQL.Add('WHERE    ');
    qryBloq.SQL.Add('  LOG_NUMDOC = :NUMDOC AND ');
    qryBloq.SQL.Add('  LOG_ESPDOC = :ESPDOC AND ');
    qryBloq.SQL.Add('  LOG_CODEMP = :EMPDOC     ');
    qryBloq.SQL.Add('ORDER BY ');
    qryBloq.SQL.Add('  LOG_DTACAD DESC,     ');
    qryBloq.SQL.Add('  LOG_HRACAD DESC      ');

    qryBloq.ParamByName('NUMDOC').AsString := cdsItens.FieldByName('FDO_NUMDOC').AsString;
    qryBloq.ParamByName('ESPDOC').AsString := cdsItens.FieldByName('FDO_ESPDOC').AsString;
    qryBloq.ParamByName('EMPDOC').AsString := cdsItens.FieldByName('FDO_CODEMP').AsString;

    qryBloq.Open;

    If Not qryBloq.IsEmpty Then
    Begin
      pCriarFormularios(TfrmCtrMotBloPed,frmCtrMotBloPed);
      frmCtrMotBloPed.edtPed.Text    := cdsItens.FieldByName('FDO_NUMDOC').AsString;
      frmCtrMotBloPed.edtEspDoc.Text := cdsItens.FieldByName('FDO_ESPDOC').AsString;
      frmCtrMotBloPed.edtDtaCad.Text := qryBloq.FieldByName('LOG_DTACAD').AsString;
      frmCtrMotBloPed.edtHorCad.Text := qryBloq.FieldByName('LOG_HRACAD').AsString;
      frmCtrMotBloPed.edtCodEmp.Text := cdsItens.FieldByName('FDO_CODEMP').AsString;
      frmCtrMotBloPed.edtDesEmp.Text := qryBloq.FieldByName('EMP_NOMEMP').AsString;
      frmCtrMotBloPed.edtCodVen.Text := qryBloq.FieldByName('LOG_CODVEN').AsString;
      frmCtrMotBloPed.edtDesVen.Text := qryBloq.FieldByName('OPE_NOMVEN').AsString;
      frmCtrMotBloPed.edtCodOpe.Text := qryBloq.FieldByName('LOG_CODOPE').AsString;
      frmCtrMotBloPed.edtDesOpe.Text := qryBloq.FieldByName('OPE_NOMOPE').AsString;

      for iCont := 0 to stlTrava.Count-1 do
      begin
        frmCtrMotBloPed.memObserv.Lines.Add(stlTrava.Strings[iCont]);
      end;

      if stlTrava.Count = 0 then
      begin
        If (strTipLib = '1') Then
          frmCtrMotBloPed.memObserv.Lines.Add(
            fMotivoDoBloqueio(
              cdsItens.FieldByName('FGO_NTRAVA').AsString,
              cdsItens.FieldByName('FGO_MOTLIB').AsString))

        Else If (strTipLib = '2') Then
          frmCtrMotBloPed.memObserv.Lines.Add(cdsItens.FieldByName('FGO_MOTLIB').AsString);
      end;

      frmCtrMotBloPed.ShowModal;
    End
    Else
    Begin
      fMensagem(
        'ATENÇÃO!',
        fMotivoDoBloqueio(
          cdsItens.FieldByName('FGO_NTRAVA').AsString,
          cdsItens.FieldByName('FGO_MOTLIB').AsString),
        ['&Ok']);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'btnMotivoBloqClick');
  End;

  FreeAndNil(qryBloq);
  pFreeAndNil(frmCtrMotBloPed);
end;

procedure TfrmCtrLiberaPedidosConf.btnOrdemProdClick(Sender: TObject);
  Var
    objOrdPro: TOrdPro;
    qryItem: TDataSet;
    blnExiste: Boolean;
begin
  inherited;

  If (Not btnOrdemProd.Visible) Then
    Exit;

  If Not fVerificaAcessoSistema('frmOrdProdGerAutom') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso à rotina de geração da Ordem de Produção!', ['&OK']);
    Exit;
  End;

  qryItem := cxgItensDados.DataController.DataSource.DataSet;

  If Not fItemEstrutura(qryItem.FieldByName('FDO_CODITE').AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Só é pertimida a geração de Ordem de Produção para Item Estrutura!', ['&OK']);
    Exit;
  End;

  If (fMensagem('ATENÇÃO!', 'Confirma geração de Ordem de Produção!', ['&Sim', '&Não']) = 2) Then
  Begin
    Exit
  End;

  Try

    fStartTransaction;
    objOrdPro := TOrdPro.Create(Self, True);
    objOrdPro.pLimpaDados;

    objOrdPro.strNumDoc := edtNumDoc.Text;
    objOrdPro.strEspDoc := 'PD';
    objOrdPro.strCodEmp := edtCodEmp.Text;
    objOrdPro.strCodCli := edtCodCli.Text;
    objOrdPro.strCodIte := qryItem.FieldByName('FDO_CODITE').AsString;
    objOrdPro.strQtdApr := AnsiReplaceStr(qryItem.FieldByName('FDO_QTDITE').AsString, '.', '');
    objOrdPro.strQtdPro := '0.0';
    objOrdPro.strConfer := fRetNomVendRep(strLoginUsuarioLogado);
    objOrdPro.strDtaPro := FormatDateTime('DD/MM/YYYY', VS_Date);
    objOrdPro.strDtaCad := DateToStr(VS_Date);
    objOrdPro.strSeqInd := qryItem.FieldByName('FDO_SEQINC').AsString;
    objOrdPro.strObs001 := 'GERADO PELA LIB. DE PEDIDOS';
    objOrdPro.strObs002 := 'DOCUMENTO: ' + edtNumDoc.Text + '-PD';

    blnExiste := False;
    If (Not objOrdPro.fOrdemProducaoExiste) Then
    Begin
      objOrdPro.strNumPed := edtNumDoc.Text;
      objOrdPro.strEspPed := 'PD';;
      objOrdPro.strEmpPed := edtCodEmp.Text;

      objOrdPro.fInsereOrdemProducao;
      objOrdPro.fDefinirOrdemProducaoItem;
    End Else
    Begin
      fMensagem('ATENÇÃO!', 'A Ordem de Produção referente a esse produto já foi gerada!!', ['&Ok']);
      blnExiste := True;
    End;
    FreeAndNil(objOrdPro);

    fCommit;

    If (Not blnExiste) Then
      fMensagem('ATENÇÃO!', 'Ordem de Produção gerada com sucesso!', ['&Ok']);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Geração de Ordem de Produção]');
    End;
  End;

end;

procedure TfrmCtrLiberaPedidosConf.btnPadraoClick(Sender: TObject);
begin
  inherited;
  btnPadrao.Enabled := False;
  mmsLayoutDefault.Position := 0;
  cxgItensDados.RestoreFromStream(mmsLayoutDefault);
  btnPadrao.Enabled := True;
end;

procedure TfrmCtrLiberaPedidosConf.btnResFinancClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
    frmResFinanceiro.strCodCli                                   := edtCodCli.Text;
    frmResFinanceiro.blnPermiteEditarArquivosDeConsultaDeCredito := True;
    frmResFinanceiro.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmResFinanceiro);
end;

procedure TfrmCtrLiberaPedidosConf.cxgItensDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Type
    TArrPoint = Array Of TPoint;

  Var
    strTabPre: String;
    fltUnitar, fltPreVen: Double;

    function fRetPnt(X, Y: Integer): TPoint;
    begin
      Result.X := AViewInfo.Bounds.Left + X;
      Result.Y := AViewInfo.Bounds.Top  + Y;
    end;

    function fSetaDireita: TArrPoint;
    begin
      SetLength(Result, 8);
      Result[0] := fRetPnt(04, 06);
      Result[1] := fRetPnt(10, 06);
      Result[2] := fRetPnt(10, 02);
      Result[3] := fRetPnt(16, 08);
      Result[4] := fRetPnt(10, 14);
      Result[5] := fRetPnt(10, 10);
      Result[6] := fRetPnt(04, 10);
      Result[7] := fRetPnt(04, 06);
    end;

    function fSetaCima: TArrPoint;
    begin
      SetLength(Result, 8);
      Result[0] := fRetPnt(10, 02);
      Result[1] := fRetPnt(16, 08);
      Result[2] := fRetPnt(12, 08);
      Result[3] := fRetPnt(12, 12);
      Result[4] := fRetPnt(08, 12);
      Result[5] := fRetPnt(08, 08);
      Result[6] := fRetPnt(04, 08);
      Result[7] := fRetPnt(10, 02);
    End;

    function fSetaBaixo: TArrPoint;
    begin
      SetLength(Result, 8);
      Result[0] := fRetPnt(08, 01);
      Result[1] := fRetPnt(12, 01);
      Result[2] := fRetPnt(12, 06);
      Result[3] := fRetPnt(16, 06);
      Result[4] := fRetPnt(10, 12);
      Result[5] := fRetPnt(04, 06);
      Result[6] := fRetPnt(08, 06);
      Result[7] := fRetPnt(08, 01);
    End;

    procedure pDrawPoligon(p: TArrPoint; c: TColor);
    begin
      ACanvas.Brush.Color := clWhite;
      ACanvas.FillRect(AViewInfo.Bounds);
      ACanvas.Brush.Color := c;
      ACanvas.Polygon(p);
      ADone := True;
    end;

    function fGetValue(strField: String): Variant;
    begin
      Result := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgItensDados.GetColumnByFieldName(strField).Index];
    end;

begin
  inherited;

  If (Not AViewInfo.GridRecord.IsData) Or
     (AViewInfo.GridRecord.Index = -1) Then
    Exit;

  If (AViewInfo.Item.SortOrder <> soNone) And
     (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;

  If AViewInfo.Item.Index = cxgItensDados.GetColumnByFieldName('AVAL').Index Then
  Begin
    strTabPre := VarToStr(fGetValue('FDO_TABPRE'));

    If IfNull(fGetValue('FDO_DESESP'), 0) > 0 Then
      fltUnitar := fFormataFloat(IfNull(fGetValue('FDO_UNILIQ'), 0), 2)
    Else
      fltUnitar := fFormataFloat(IfNull(fGetValue('FDO_UNITAR'), 0), 2);

    If fEmptyStr(strTabPre) Then
      strTabPre := '1';

    If (fGetValue('FDO_IDEPRO') <> 'NOR') or (fGetValue('FDO_PROMOC') = 'S') Then
      fltPreVen := fFormataFloat(IfNull(fGetValue('FDO_UNIORI'), 0), 2)
    Else
      fltPreVen := fFormataFloat(IfNull(fGetValue('ITE_PREVE'+strTabPre), 0), 2);

    If fltUnitar = fltPreVen Then
    Begin
      pDrawPoligon(fSetaDireita, clBlue);
    End
    Else If fltUnitar > fltPreVen Then
    Begin
      pDrawPoligon(fSetaCima, clGreen);
    End
    Else
    Begin
      pDrawPoligon(fSetaBaixo, clRed);
    End;

    Exit;
  End;

  If AViewInfo.Item.Index = cxgItensDados.GetColumnByFieldName('FDO_MARDIN').Index Then
  Begin
    If fStrToFloat(VarToStr(fGetValue('FDO_MARDIN'))) < 0 Then
    Begin
      ACanvas.Font.Color := clRed;

      If ACanvas.Brush.Color = clHighLight Then
        ACanvas.Font.Color := clWhite;
    End;
  End;

  If AViewInfo.Item.Caption = 'Situação' Then
  Begin

    ACanvas.Font.Color := clBlack;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, AViewInfo.Item.Index]) = 'PROMO' Then
    Begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.FillRect(AViewInfo.Bounds);
    End;

  End;

end;

procedure TfrmCtrLiberaPedidosConf.edtPerIcmsEnter(Sender: TObject);
begin
  inherited;
  If (Sender.ClassType = TEditFocus) Then
    If TEditFocus(Sender).ReadOnly Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCtrLiberaPedidosConf.fGetSaldoEmpWithQtdEntFut(strCodIte, strCodEmp: String): Double;
  Var
    qryIteSal: TUniQuery;
begin
  Result := 0.00;

  Try
    qryIteSal := fCriaQuery(Nil);

    With qryIteSal Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add(' SELECT ');

      If fUsaQtdPendenteEntregaFutura Then
      Begin
        SQL.Add('  I.ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('I', True) + ' AS ITE_SALDOS  ');
      End
      Else
        SQL.Add('  I.ITE_SALDOS  ');

      SQL.Add(' FROM ');
      SQL.Add('   ITEGER I ');
      SQL.Add('   JOIN CADITE C ON I.ITE_CODITE = C.ITE_CODITE ');
      SQL.Add(' WHERE I.ITE_CODEMP = :CODEMP ');
      SQL.Add('   AND I.ITE_CODITE = :CODITE ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      If Not IsEmpty Then
        Result := FieldByName('ITE_SALDOS').AsFloat;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGetSaldoEmpWithQtdEntFut]');
    End;
  end;

  FreeAndNil(qryIteSal);
end;

function TfrmCtrLiberaPedidosConf.fGetTodasEmpresas: TUniQuery;
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  Result := nil;

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE  ';
    strSQL := strSQL + '   EMP_CODEMP, ';
    strSQL := strSQL + '   EMP_NOMEMP ';
    strSQL := strSQL + ' FROM CADEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      Open;

      If Not IsEmpty Then
        Result := qryGen
      Else
        FreeAndNil(qryGen);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGetTodasEmpresas]');
    End;
  end;
end;

class function TfrmCtrLiberaPedidosConf.fLiberacaoRemotaNoFinalVenda: Boolean;
begin
  Result := (fCfgSis('HABREM',varBoolean) And (fCfgSis('TRAREM') = '2'));
end;

procedure TfrmCtrLiberaPedidosConf.FlwPnlBotoesLiberacaoClick(Sender: TObject);
begin
  inherited;

end;

{********************** TRAVAS ATÉ O MOMENTO *************************}
{* POSIÇÃO 1 - LIMITE DE CRÉDITO EXCEDIDO "LIMCR"                    *}
{* POSIÇÃO 2 - LIBERAÇÃO DE CLIENTE QUE NÃO COMPRA A XX DIAS "COMPR" *}
{* POSIÇÃO 3 - VALOR UNITÁRIO MENOR QUE O PREÇO MÍNIMO "PRMIN"       *}
{* POSIÇÃO 4 - VENDA COM VALOR MÍNIMO EXIGIDO "VEMIN"                *}
{* POSIÇÃO 5 - LIBERAÇÃO DO CLIENTE COM DÉBITO EM ATRASO "DEATR"     *}
{* POSIÇÃO 6 - LIBERAÇÃO DE MARGEM DE LUCRO "MARGE"                  *}
{* POSIÇÃO 7 - LIBERAÇÃO DE CONSULTA DE CRÉDITO CLIENTE "CONCC"      *}
{* POSIÇÃO 8 - LIBERAÇÃO DE VALOR DE CREDIÁRIO "VLCRE"               *}
{* POSIÇÃO 8 - LIBERAÇÃO DE VALOR DE CREDIÁRIO "VLCRE"               *}
{* POSIÇÃO 9 - BLOQUEADO PELA GERÊNCIA "AGLIB"                       *}
{* POSIÇÃO 10- BONIFICAÇÃO - BLOQUEADO PELO DEP. FINANCEIRO "BOFIN"  *}
{* POSIÇÃO 11- BONIFICAÇÃO - BLOQUEADO PELA GERÊNCIA "AGBOM"         *}
{******************************************************************AF*}
class function TfrmCtrLiberaPedidosConf.fMotivoDoBloqueio(strNTrava, strMotLib: String): String;
begin
  Result := '';

  If Not fEmptyStr(strNTrava) Then
  Begin
    If (Length(strNTrava) >= 1) And (strNTrava[1] = 'S') Then
      Result := Result + 'LIMITE DE CRÉDITO EXCEDIDO' + #13#10;

    If (Length(strNTrava) >= 2) And (strNTrava[2] = 'S') Then
      Result := Result + 'LIBERAÇÃO DE CLIENTE QUE NÃO COMPRA A XX DIAS' + #13#10;

    If (Length(strNTrava) >= 3) And (strNTrava[3] = 'S') Then
      Result := Result + 'VALOR UNITÁRIO MENOR QUE O PREÇO MÍNIMO' + #13#10;

    If (Length(strNTrava) >= 4) And (strNTrava[4] = 'S') Then
      Result := Result + 'VENDA COM VALOR MÍNIMO EXIGIDO' + #13#10;

    If (Length(strNTrava) >= 5) And (strNTrava[5] = 'S') Then
      Result := Result + 'LIBERAÇÃO DO CLIENTE COM DÉBITO EM ATRASO' + #13#10;

    If (Length(strNTrava) >= 6) And (strNTrava[6] = 'S') Then
      Result := Result + 'LIBERAÇÃO DE MARGEM DE LUCRO' + #13#10;

    If (Length(strNTrava) >= 7) And (strNTrava[7] = 'S') Then
      Result := Result + 'LIBERAÇÃO DE CONSULTA DE CRÉDITO' + #13#10;

    If (Length(strNTrava) >= 8) And (strNTrava[8] = 'S') Then
      Result := Result + 'LIBERAÇÃO DE VALOR DE CREDIÁRIO' + #13#10;

    //O caractere contido em strNTrava[9] está repetindo o anterior (strNTrava[8]) e portanto será ignorado neste teste.

    If (Length(strNTrava) >= 10) And (strNTrava[10] = 'S') Then
      Result := Result + 'PEDIDO BLOQUEADO PELA GERÊNCIA' + #13#10;

    If (Length(strNTrava) >= 11) And (strNTrava[11] = 'S') Then
      Result := Result + 'BONIFICAÇÃO - BLOQUEADO PELO DEP. FINANCEIRO' + #13#10;

    If (Length(strNTrava) >= 12) And (strNTrava[12] = 'S') Then
      Result := Result + 'BONIFICAÇÃO - BLOQUEADO PELA GERÊNCIA' + #13#10;

    If (Length(strNTrava) >= 13) And (strNTrava[13] = 'S') Then
      Result := Result + 'NECESSÁRIA ATUALIZAÇÃO DOS DADOS DE COBRANÇA DO CLIENTE' + #13#10;

    If (Length(strNTrava) >= 15) And (strNTrava[15] = 'S') Then
      Result := Result + 'PEDIDO POSSUI ITENS SEM ESTOQUE' + #13#10;

    If strNTrava = 'NNNNNNNNSNNNNNNNNNNN' then
      Result := Result + 'PEDIDO BLOQUEADO PELA GERÊNCIA, MOTIVO: ' + strMotLib
  End
  Else
    Result := Result + 'PEDIDO SEM MOTIVO DE BLOQUEIO' + #13#10;
end;

end.

