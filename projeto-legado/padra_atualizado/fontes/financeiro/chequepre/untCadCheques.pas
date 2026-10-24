{***************************}
{* qryConBco -> CADBCO     *}
{* qryConCli -> CADCLI     *}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{* qryConFor -> CADFOR     *}
{* qryConCid -> CADCID     *}
{************************JB*}
{***************************}
{* qryCadEmi -> CADEMI     *}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untCadCheques;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, ComCtrls, Buttons, ExtCtrls, Uni,
  Dialogs, DBCtrls, DBEditFocus, DB, Menus, EditFocus, AppEvnts, untConstantes,
  untPaiCadCds, UniDataSetProvider, UniClientDataSet, frxClass, frxDBSet, frxDMPExport,
  cxControls, cxContainer, cxEdit, cxLabel, untFuncoesGenerica, untLabelCgcCpf,
  untDBETipoCgcCpf, untDBECgcCpf, BitBtnLockedIncrem, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, untFuncFat,untTypesSistema, untFuncoes, untMskTelefone, Mask,
  Provider, frxExportCSVTestabilidade, System.Generics.Collections, Datasnap.DBClient, untLiberacao,
  untFechamentoFinanceiro, untRcxTResumoDeCaixa,
  untFramePlanoDeContasDBEditFocus;

type
  TRecConsulta = Record
    strCodCbo,
    strNumAge,
    strConCor,
    strCodCli,
    strDtaCad,
    strDtaVen,
    strHist01,
    strHist02,
    strCodEmp: String;
  End;

  TChaveCtr = Class
  public
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strParcel: String;
  End;

  TfrmCadCheques = class(TfrmPaiCadCds)
    tbsRepasse: TTabSheet;
    pnlDados1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeNumAge: TDBEditFocus;
    dbeConCor: TDBEditFocus;
    dbeNumChq: TDBEditFocus;
    Panel1: TPanel;
    Label5: TLabel;
    dbeCodCli: TDBEditFocus;
    Panel2: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    dbeValChq: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeHist02: TDBEditFocus;
    dbeHist01: TDBEditFocus;
    Label13: TLabel;
    lblNumNot: TLabel;
    dbeNumNot: TDBEditFocus;
    dbeDtaVen: TDBEditFocus;
    Panel3: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    dbeDtaDev: TDBEditFocus;
    dbeCtaDep: TDBEditFocus;
    dbeDtaDep: TDBEditFocus;
    Label20: TLabel;
    Label21: TLabel;
    dbeMotDev: TDBEditFocus;
    dbeCodPor: TDBEditFocus;
    Label23: TLabel;
    dbeObsRep: TDBEditFocus;
    dbeForRep: TDBEditFocus;
    Label24: TLabel;
    dbeDtaRep: TDBEditFocus;
    Label25: TLabel;
    pnlAcoes: TPanel;
    edtNomBan: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomPor: TEditFocus;
    edtNomFor: TEditFocus;
    tbsCustodia: TTabSheet;
    Label22: TLabel;
    Label26: TLabel;
    dbeCodPo2: TDBEditFocus;
    dbeDtaCus: TDBEditFocus;
    edtNomPo2: TEditFocus;
    dbeDocCus: TDBEditFocus;
    Label18: TLabel;
    pnlLeitor: TPanel;
    edtCheque: TEditFocus;
    lblCheque: TLabel;
    grbCMC7: TGroupBox;
    chkLeitor: TCheckBox;
    chkInfMan: TCheckBox;
    Label29: TLabel;
    dbeDtaDp2: TDBEditFocus;
    Label30: TLabel;
    dbeDtaDV2: TDBEditFocus;
    Label31: TLabel;
    dbeMotDv2: TDBEditFocus;
    dbeDevDef: TDBCheckBox;
    lblDupDev: TLabel;
    dbeDupDev: TDBEditFocus;
    Label32: TLabel;
    dbeTelChe: TDBEditFocus;
    Label33: TLabel;
    dbeTelNum: TDBEditFocus;
    tbs1: TTabSheet;
    edtNomOpe: TEditFocus;
    lbl6: TLabel;
    edtNomEmp: TEditFocus;
    DBEditFocus5: TDBEditFocus;
    lbl5: TLabel;
    DBEditFocus6: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    DBEditFocus1: TDBEditFocus;
    edtNomTel: TEditFocus;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    dtsConTel: TDataSource;
    edtDigChq: TEditFocus;
    Label34: TLabel;
    frxChqPreJ: TfrxReport;
    frxDBChqPre: TfrxDBDataset;
    frxChqPreM: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    lblCMC7: TLabel;
    dbeCodCmc: TDBEditFocus;
    pnlInfos: TPanel;
    lblInfo: TcxLabel;
    pnlTotais: TPanel;
    lbl7: TLabel;
    lbl8: TLabel;
    edtTotDig: TEditFocus;
    edtTotGer: TEditFocus;
    btnImprimir: TBitBtnLocked;
    btnCorrigeCheque: TBitBtnLocked;
    btnHistorico: TBitBtnLocked;
    btnHistReceb: TBitBtnLocked;
    btnTransfereCtR: TBitBtnLocked;
    Label9: TLabel;
    dbePorChq: TDBEditFocus;
    edtDesPorChq: TEditFocus;
    Panel4: TPanel;
    dbcNaoDep: TDBCheckBox;
    Label14: TLabel;
    dbeCodCid: TDBEditFocus;
    edtDesCid: TEditFocus;
    edtEstado: TEditFocus;
    Label28: TLabel;
    pnlDocume: TPanel;
    Label27: TLabel;
    dbeDocume: TDBEditFocus;
    dbeCodBco: TDBEditFocus;
    grpEmitente: TGroupBox;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    LabelCgcCpf1: TLabelCgcCpf;
    dbeEndere: TDBEditFocus;
    dbeTelEmi: TDBEditFocus;
    dbeNomEmi: TDBEditFocus;
    dbeNumCgc: TDBEditCgcCpf;
    dbeCgcCpf: TDBEditTipoCgcCpf;
    btnDepositoCheque: TBitBtnLocked;
    btnHistRecebLOG: TBitBtnLocked;
    btnCancelaDeposito: TBitBtnLocked;
    grbMovBan: TGroupBox;
    btnAltPortador: TBitBtnLocked;
    fraPlanoDeContasMov: TfraPlanoDeContasDBEditFocus;
    fraPlanoDeContasPla: TfraPlanoDeContasDBEditFocus;
    btnCancelTransfCtR: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    function dbeCodCliChamaCadastro(Key: Word): String;
    function dbeCodBcoChamaCadastro(Key: Word): String;
    procedure dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCorrigeChequeClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pgcDadosChange(Sender: TObject);
    procedure dbeCodCliEnter(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure chkLeitorClick(Sender: TObject);

    procedure pModCheque1;
    procedure pModCheque2;
    procedure chkInfManClick(Sender: TObject);
    procedure dbeDtaVenExit(Sender: TObject);
    procedure dbeDevDefClick(Sender: TObject);
    procedure btnHistRecebClick(Sender: TObject);
    procedure dbeTelCheExit(Sender: TObject);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnTransfereCtRClick(Sender: TObject);
    procedure dbePorChqKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNumCgcChange(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeDevDefExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeDtaDevExit(Sender: TObject);
    procedure dbeDtaDV2Exit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtTotDigChange(Sender: TObject);
    procedure btnDepositoChequeClick(Sender: TObject);
    procedure btnHistRecebLOGClick(Sender: TObject);
    procedure btnCancelaDepositoClick(Sender: TObject);
    procedure btnAltPortadorClick(Sender: TObject);
    procedure fraPlanoDeContasMovdbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure dbcNaoDepExit(Sender: TObject);
    procedure btnCancelTransfCtRClick(Sender: TObject);

  private
    { Private declarations }
    strCodPor,
    strCodCta: String;
    blnDefinePortCta : Boolean;
    fltValChqAnt,
    fltValLanAnt: Double;
    strSeqLan,
    strChqSvd,
    strMsgErr,
    strPorChqAnt,
    strCtaChqAnt,
    strCodPorCredMovBan,
    strCodPlanCredMovBan :String;

    strNumDup: String;   // DUPLICATA RELATIVA A DEVOLUCAO OU DEPOSITO POR TRANSF.

    strChaveCadPag: String;

    FPais: TPais;

    qryConFor   : TUniQuery;
    qryConCta   : TUniQuery;
    qryConPor   : TUniQuery;
    qryConCli   : TUniQuery;
    qryConBco   : TUniQuery;
    qryCadEmi   : TUniQuery;
    qryConTel   : TUniQuery;
    qryConCid   : TUniQuery;
    qryConsultaDebitos : TUniQuery;


    arrSeqLanLoc: TStringArray;

    recConsulta  : TRecConsulta;
    recInclusao  : TRecConsulta;

    strMotAnt       : String;
    dtaDevAnt       : TDateTime;

    strMt2Ant       : String;
    dtaDv2Ant       : TDateTime;

    strArqChqDev    : String;
    strTabCheque    : String;
    strTabTeleChq   : String;
    fltValAlt       : Double;
    strEmiAnt       : String;
    strCliAnt       : String;

    blnIniciaCadastro: Boolean;
    fltValLanLoc: Double;
    strHist01Loc,
    strCodPorLoc: String;
    dteDataLanLoc: TDate;

    strNumCgcAtual,
    strCgcCpfAtual,
    strNomEmiAtual,
    strEndereAtual,
    strTelEmiAtual:  String;


    strCheque       : String;
    strDigAnt       : String;
    blnVerificaCheque : Boolean;

    blnDevolvido: Boolean;

    blnCarregarCliente: Boolean;

    blnLiberaDebito : Boolean;

    dtaBkpVen: TDateTime;
    oblCtrBaixando: TObjectList<TChaveCtr>;
    fltTotDebGeral: Double;

    FblnTravaCli: Boolean;

    FPortadorContraPartidaNaDevolucao : String;
    FPortadorContaAReceber : String;
    FVendedorContaAReceber : String;
    objFechamento: TFechamentoFinanceiro;
    ADataCadastroInicial: TDateTime;

    FRotina: String;

    FLiberacaoTransferencias: Boolean;

    FRotinaChamada: String;

    FValorCOnfiguracaoDigitos: Integer;

    procedure pDesabilitaValorCheque;
    procedure pMostraDespositoAntetior;
    procedure pCarregaBanco;
    procedure pCarregaCliente;
    procedure pCarregaPortador;
    procedure pCarregaPortador2;
    procedure pCarregaCentroCusto;
    procedure pCarregaFornecedor;
    procedure pCarregaDadosAdicionais;
    procedure pHabilitaBtnTransfCtr;
    procedure pCarregaTelecheque;
    procedure pCarregaCidade;
    procedure pLimpaEdits;
    procedure pAfterOpenCds(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCriaGetLeitor;
    procedure pDesabilitaChequesDevolvidos;
    procedure pCarregaDadosAnteriores;
    procedure pMostraObsCliente;
    procedure pImprimeComprovante;
    procedure LimparDataSet;
    procedure pLimpaDtaDev;
    procedure pRecarregaChequeAberto;
    procedure pAtualizaPortadorEConta;
    procedure pAtualizaChequeMovBan;

    function fExisteCheque(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
    function fExisteDevolucao(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
    function fDadosChequeAnterior: Boolean;
    function fGravaHistoricoDevolucao: Boolean;
    function fMovimentoBancario(blnConciliado : Boolean = False): Boolean;
    function fGravaDebitoMovBan: Boolean;
    function fGravaMovBanTransferenciaContasReceber(strCreDeb: String): Boolean;
    function fGravaCadRecCheque(blnTransf: Boolean = False): Boolean;
    function fGravouDevolucao(Var blnErro: Boolean): Boolean;
    function fLimpaDadosBaixa: Boolean;
    function fTransfereChqReceber: Boolean;
    function fRetVendedorDocume(strDocume, strEspDoc, strCodEmp, strCodCli : String): String;
    function fSelecionaDataCadPag: TDate;
    function fPermiteAlterarVindoDoCaixa: Boolean;
    function fAbertoPeloContasAReceber: Boolean;
    function fGravaMovimentoBancario(strTipo: String;
                                     strPorChq: String = '';
                                     strCtaChq: String = '';
                                     fltValChq: Double = 0) : Boolean;
    function fGravaDebitoMovBanRefExclusao : Boolean;
    function fObrigatorioPortadorEConta: Boolean;

    function fExisteSegundaDevolução(strCodBco, strNumAge, strConCor,
      strNumChq: String): Boolean;

    function fEmitenteBloqueado(strNumCgc: String): Boolean;
    function fEmitenteCadastrado(strNumCgc: String): Boolean;
    function fRetDadosEmitente(strNumCgc: String;
                               Var strNomEmi,
                                   strEndere,
                                   strTele01: String): Boolean;
    function fGravaCadEmi(strNumCgc,
                          strCodEmp,
                          strCgcCpf,
                          strNomEmi,
                          strEndere,
                          strBairro,
                          strNumCep,
                          strCodCid,
                          strNumIes,
                          strNumR_g,
                          strTele01: String): Boolean;
    procedure pAtualizaQtdCheques;
    procedure pGravaLogChq(acdsDelChq: TUniClientDataSet; strStatus: String);
    function fConstaDebitos(strTbl: String; strParamSQL : String; stlMsgSenVar: TStrings) : Boolean;
    function fChamaSenhaVariavel(strMsg : String = '';
                                 strDirAce : String = '';
                                 strCfgSis : String = '';
                                 strMsgSen : String = '';
                                 strOperador : String = '';
                                 strCliente: String = ''): Boolean;
    procedure AtualizaNaoDep;
    procedure pBaixaCaixaSemTransf;
    function fGravaCadPagFornecedor(strCodFor, strCta_Pg, strCodEve: String): Boolean;
    function fDigDadosPagamento(var strCodFor, strCta_Pg, strCodEve: String): Boolean;
    function fGetSqlQryConsultaDebitoCadRec(strC_G_C: String): String;
    procedure pCarregaDadosIniciaisCadastro;
    procedure pCarregaChq;
    procedure pHabilitaBotoes;
    function fCarregaPortadorEVendedorContaReceber : Boolean;
    function fDefinePortCta: Boolean;

    function LancamentoVeioDoCaixaEEstaFechado: Boolean;

    function SelecionaPortadorEPlanoDeContasDeDebito: Boolean;

    procedure HabilitaAlteracaoLiberacaoCaixas;

    procedure DesabilitaAlteracaoLiberacaoCaixas;
    procedure pCancelaTransferenciaContasReceber;
    function fQueryContasReceber(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): TUniQuery;
    procedure pRetornaDadosDoMovBan(strAutIncCheque: string; var dtaDtaLan, horHorLan: TDateTime; Var strCodPor: String; Var ACodCta: String);

    procedure PreencheZerosCampoCheque;
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    function fExecutaAntesDoDelete : Boolean; override;
  public
    { Public declarations }
    strAutIncCadChq : String;
    blnResumida: Boolean;
    strCodOpe : String;
    blnJaIncluiu : Boolean;
    blnConfima: Boolean;
    blnPrazo  : Boolean;
    dtaDataChqPre: TDateTime;
    blnRepasse: Boolean;
    fltValTot : Double;
    fltValAtu : Double;
    strCliente: String;
    cdsChqRcx : TUniClientDataSet;
    blnChamadoDoManutencao: Boolean;

    strDocume : String;

    blnTroChq : Boolean; // Troco para cheque
    optTroco  : TOperacaoTroco;
    fltValorTroco: Double;
    {*****************************}
    {* CONDIÇÃO DE PAGAMENTO QUE *}
    {* DEVE SER SEGUIDA          *}
    {**************************AF*}
    strConPag : String;
    blnValidarVencConPag: Boolean;

    dicCheques: TDictionary<String, TChequeEmitido>;

    objLiberacao : TLiberacao;

    strConfDocsAutIncCadRec: String;

    property blnTravaCli: Boolean read FblnTravaCli write FblnTravaCli;

    property Rotina: String read FRotina write FRotina;

    property RotinaChamada: String read FRotinaChamada write FRotinaChamada;

    procedure pAddCtrBaixando(strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcel: String);
    class procedure pMostraIniciandoCadastro(fltValLan: Double; strHist01: String; dteDataLan: TDate; strCodPor: String;var arrSeqLan: TStringArray);
  end;

var
  frmCadCheques: TfrmCadCheques;
  strCodBan    : String;
  strNumChq    : String;
  strConCor    : String;
  strNumAge    : String;
  blnDigLei    : Boolean;

implementation

uses SysUtils, StrUtils, Variants, Math, untFuncIns,
  untFuncoesSimples, untPesqAux, untPai, untCorrigeCheque, untConsultas,
  untCadRec, untFuncoesRel, untFuncoesRel2,
  untFatMostraObsCliente, untDigPortador, untBaixaCheques, untCadChq, untMovBan,
  untCfgRel, untTCadChqRepository, untCadPag, untRcxDigPagamento,
  untTBanChqRepository, untDtaEscolha,untRelChqLogAcomp, untCancDepChequePreMod2,
  untPorCredMovBan, DateUtils;

{$R *.dfm}

procedure TfrmCadCheques.FormCreate(Sender: TObject);
begin
  inherited;
  strAutIncCadChq := '';
  strCodOpe         := strLoginUsuarioLogado;

  qryConPor         := fCriaQuery(Self);
  qryConTel         := fCriaQuery(Self);
  dtsConTel.DataSet := qryConTel;

  objLiberacao  := TLiberacao.Create;

  FPais := fSetaPais;

  qryCadEmi := fCriarQuery('SELECT * FROM CADEMI WHERE FALSE', Self);
  qryConBco := fCriarQuery('SELECT * FROM CADBCO WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConCid := fCriarQuery('SELECT * FROM CADCID WHERE FALSE', Self);
  pSetaQueryCadCli(qryConCli);

  FillChar(recConsulta,SizeOf(recConsulta),#0);
  FillChar(recInclusao,SizeOf(recInclusao),#0);
  blnResumida  := False;
  blnJaIncluiu := FALSE;
  blnConfima   := False;
  fltValAtu    := 0;
  fltValTot    := 0;
  strNomeCampo := 'CHQ_NUMCHQ';
  strEmiAnt    := '';
  strCliAnt    := '';
  strDigAnt    := '';
  strConPag    := '';
  dtaBkpVen    := 0;
  dtaDataChqPre:= 0;
  strChaveCadPag := '';

  {Se resolução disponível for inferior ou igual à (1366 x 768), ajusta a tela!}
  if (Screen.Width <= 1366) or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) then
    Self.Position := poScreenCenter;

  {*******************************************}
  {* LEITOR DE CHEQUE NA TELA.               *}
  {****************************************AC*}
  If (Not (chkLeitor.Checked)) Then
  Begin
    lblCheque.Visible := False;
    edtCheque.Visible := False;
    blnVerificaCheque := True;
  End;

  blnCarregarCliente        := True;
  oblCtrBaixando            := TObjectList<TChaveCtr>.Create();
  FblnTravaCli              := False;
  blnIniciaCadastro         := False;
  SetLength(arrSeqLanLoc, 0);

  blnValidarVencConPag := False;

  FRotina := '';

  FLiberacaoTransferencias := fCfgSis('USAAUT', varBoolean);

  FRotinaChamada := 'MANUTENÇÃO DE CHEQUES';
end;

procedure TfrmCadCheques.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(oblCtrBaixando);
  inherited;
end;

Procedure TfrmCadCheques.pDesabilitaValorCheque;
  Var
    LAlteraValor: Boolean;
Begin
  LAlteraValor := fCfgSis('CHQVAL', varBoolean);
  If FRotina = 'LIBERAÇÃO TRANSFERÊNCIAS' Then
    LAlteraValor := False;

  dbeValChq.Enabled := LAlteraValor;
  dbeValChq.TabStop := LAlteraValor;
End;

function TfrmCadCheques.fRetDadosEmitente(strNumCgc: String; var strNomEmi,
  strEndere, strTele01: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmi: TUniQuery;
begin
  Try
    qryGenEmi := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMI_NOMEMI, ';
    strSQL := strSQL + '  EMI_ENDERE, ';
    strSQL := strSQL + '  EMI_TELE01 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMI_C_G_C_ = :NUMCGC ';

    With qryGenEmi Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMCGC').AsString := strNumCgc;
      Open;
      strNomEmi := FieldByName('EMI_NOMEMI').AsString;
      strEndere := FieldByName('EMI_ENDERE').AsString;
      strTele01 := FieldByName('EMI_TELE01').AsString;
      Close;
    End;

    Result := (Not fEmptyStr(strNomEmi));

  Finally
    FreeAndNil(qryGenEmi);
  End;
end;

function TfrmCadCheques.fRetVendedorDocume(strDocume, strEspDoc, strCodEmp, strCodCli: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Self);
    Result := '';

    strSQL := '';
    strSQL := strSQL + 'SELECT                        ';
    strSQL := strSQL + '  DISTINCT DET_CODVEN         ';
    strSQL := strSQL + 'FROM                          ';
    strSQL := strSQL + ' (SELECT DISTINCT DET_CODVEN  ';
    strSQL := strSQL + '  FROM   MOVDET               ';
    strSQL := strSQL + '  WHERE  DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '    AND  DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '    AND  DET_CODEMP = :CODEMP ';
    strSQL := strSQL + '    AND  DET_CODCLI = :CODCLI ';
    strSQL := strSQL + ' ) AS A ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strDocume;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If Not (IsEmpty) Then
        Result := FieldByName('DET_CODVEN').AsString;

    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadCheques.fSelecionaDataCadPag: TDate;
var
  dtaDatDev: TDate;
  frmDtaEscolha: TfrmDtaEscolha;
begin

  If dbeDtaDv2.Field.Value > dbeDtaDev.Field.Value then
    dtaDatDev := dbeDtaDv2.Field.Value
  else
    dtaDatDev := dbeDtaDev.Field.Value;

  Try
    pCriarFormularios(TfrmDtaEscolha, frmDtaEscolha);
    frmDtaEscolha.Caption := 'Selecione a data para o Contas a Pagar';
    frmDtaEscolha.btnData1.Caption := 'Data da Devolução';
    frmDtaEscolha.btnData2.Caption := 'Data do Depósito';
    frmDtaEscolha.ShowModal;

    If frmDtaEscolha.opcValor = opData1 Then
      Result := dtaDatDev
    Else
      Result := IIF((cdsTabela.FieldByName('CHQ_DEVDEF').AsString = '1') AND (not cdsTabela.FieldByName('CHQ_DTAREP').IsNull) , cdsTabela.FieldByName('CHQ_DTAREP').AsDateTime, VS_Date);

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[untCadCheques.fSelecionaDataCadPag]');
    End;
  End;

  FreeAndNil(frmDtaEscolha);
end;

function TfrmCadCheques.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomEmi: String;
    strEndere: String;
    strTele01: String;
    strDocume: String;
    dtaData  : TDateTime;
    blnDebChq, blnDebCtr: Boolean;
    stlMsgSenVar: TStrings;
    fltCalcRest: Double;
begin
  Result  := True;
  dtaData := 0;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*******************************************}
    {* VALIDA CAMPO LEITOR CHEQUE              *}
    {****************************************AC*}
    If (edtCheque.Visible) Then
    Begin

      If (Sender = edtCheque) Then
      Begin

        If ((Length(Trim(edtCheque.Text)) <> 34) And chkLeitor.Checked) then
        begin
          fMensagem('ATENÇÃO!', 'Os dados do cheque não são válidos! Cheque carregado pelo leitor, deve conter 34 caracteres.', ['&O k']);
          Exit;
        end
        else
        If ((Length(Trim(edtCheque.Text)) <> 30) And chkInfMan.Checked And (fCfgSis('MODCHQ') = '1')) then
        begin
          fMensagem('ATENÇÃO!', 'Os dados do cheque não são válidos! Cheque configurado CFG_MODCHQ como "Modelo um", deve conter 30 caracteres.', ['&O k']);
          Exit;
        end
        else
        If ((Length(Trim(edtCheque.Text)) <> 32) And chkInfMan.Checked And (fCfgSis('MODCHQ') = '2')) then
        begin
          fMensagem('ATENÇÃO!', 'Os dados do cheque não são válidos! Cheque configurado CFG_MODCHQ como "Modelo dois", deve conter 32 caracteres.', ['&O k']);
          Exit;
        end
        else
        begin
          pCriaGetLeitor;
          pSetFocus(dbeCodCli);
        end;

        If Not blnVerificaCheque Then
        Begin
          Result := False;
        End;

      End;

    End;

    {*****************************************}
    {* VALIDA O CÓIDIGO DO BANCO             *}
    {**************************************MV*}
    If (Sender = dbeCodBco) Then
    Begin

      If fEmptyStr(dbeCodBco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaBanco;
        If qryConBco.FieldByName('BCO_CODBCO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A AGENCIA                      *}
    {**************************************MV*}
    Else If (Sender = dbeNumAge) Then
    Begin
      If fEmptyStr(dbeNumAge.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Agencia deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fEmptyStr(edtCheque.Text) Then
      Begin
        edtCheque.Visible := False;
        lblCheque.Visible := False;
        edtCheque.Enabled := False;
        chkInfMan.Checked := False;
        pSetFocus(dbeNumAge);
      End
    End

    {*****************************************}
    {* VALIDA  A CONTA CORRENTE              *}
    {**************************************MV*}
    Else If (Sender = dbeConCor) Then
    Begin

      If fEmptyStr(dbeConCor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Conta Corrente deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O NÚMERO DO CHEQUE             *}
    {**************************************MV*}
    Else If (Sender = dbeNumChq) Then
    Begin
      PreencheZerosCampoCheque;

      If fEmptyStr(dbeNumChq.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Cheque deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If blnResumida And fBuscaChqOutroTipo Then
      Begin
        fMensagem('ATENÇÃO!', 'Este Cheque já foi digitado em Cheque '+
                  IfThen(blnPrazo,'a Vista','Pré')+'!', ['&O k']);
        Result := False;
      End
      Else If blnResCai And fBuscaTrocChqAvisPre Then
      Else If (blnResumida) And (fExisteCheque(dbeCodBco.Text,dbeNumAge.Text,dbeConCor.Text,dbeNumChq.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Cheque digitado já existe no cadastro!', ['&O k']);
        Result := False;
      End
      Else If fExisteCheque(dbeCodBco.Text,dbeNumAge.Text,dbeConCor.Text,dbeNumChq.Text) And
             (fExisteSegundaDevolução(dbeCodBco.Text,dbeNumAge.Text,dbeConCor.Text,dbeNumChq.Text))
           Then
      Begin
        fMensagem('ATENÇÃO!', 'O  Cheque de Nº: '+ dbeNumChq.Text +' Consta como Devolvido!', ['&O k']);
        pLimpaEdits;
        pLimparCampos;
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave(blnGravacaoFisica) Then
        Begin
          (************************************************************)
          (* ESTAVA LIMPANDO OS DADOS PREENCHIDOS NA SEGUNDA INCLUSAO *)
          (*********************************************************LA*)
          If Not ( (cdsTabela.State = dsInsert) And
                   (blnJaIncluiu Or (Not fEmptyStr(recConsulta.strCodCbo)))
                 ) Then
          Begin
            strDocume := cdsTabela.fieldbyname('CHQ_DOCUME').AsString;
            dtaData   := cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime;
            If Not blnResCai And Not blnCtaRec Then
            Begin
              pLimparCampos;
              pLimpaEdits;
              pAtualizaPortadorEConta;
              qryConTel.Close;
            End;
            cdsTabela.fieldbyname('CHQ_DOCUME').AsString := strDocume;
            cdsTabela.fieldbyname('CHQ_TELCHE').AsString := 'N';

            If Not blnResumida Then
            Begin
              If ((qryTabela.State = dsInsert) Or (qryTabela.State = dsBrowse)) Then
                edtDigChq.Text := strCodOpe + '-' + fRetNomeOperador(strCodOpe);
            End
            Else
              edtDigChq.Text := strCodOpe + '-' + fRetNomeOperador(strCodOpe);
          End;
          edtNomBan.Text := qryConBco.FieldByName('BCO_NOMBCO').AsString;
          If fEmptyStr(fTiraCaracEspeciais(dbeDtaDev.Text)) Then
          Begin
            dbeMotDev.Enabled := False;
          End;
          If fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text)) Then
          Begin
            dbeMotDv2.Enabled := False;
          End;

          If cdsTabela.State <> dsEdit Then
            dbeValChq.Field.AsFloat := fltValTot - fltValAtu;

          If (fEmptyStr(recInclusao.strCodCbo)) Then
          Begin
            cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime := VS_Date;

            If fEmptyStr(strConPag) And (dtaDataChqPre = 0) Then
              cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime := VS_Date
            Else cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime := dtaData;

          End;

          if blnIniciaCadastro then
              pCarregaDadosIniciaisCadastro;
        End
        Else
        Begin

          If Not fVerificaAcessoSistema('PERVERTODOSCHQ') Then
          Begin
            If (Pos(qryTabela.FieldByName('CHQ_CODEMP').AsString, strEmpAcessoUsuarioLogado) <= 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Cheque informado pertence a empresa '+ qryTabela.FieldByName('CHQ_CODEMP').AsString +
                                    ', operador logado não possui direito de acesso a essa empresa!', ['&O k']);

              btnCancela.Click;
              LimparDataSet;
              pCarregaDadosAdicionais;
              pLimparCampos;
              pSetFocus(btnIncluir);
              Exit;
            End;
          End;



          pCarregaDadosAdicionais;
          pHabilitaBtnTransfCtr;

          blnDevolvido := fExisteDevolucao(dbeCodBco.Text,dbeNumAge.Text,dbeConCor.Text,dbeNumChq.Text);

          If (blnResCai Or blnCtaRec) Then
          Begin
            fltValAlt := cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat;
            pAtualizaQtdCheques;
          End;

          pDesabilitaValorCheque;

          if (cdsTabela.State = dsEdit) And (blnGravacaoFisica) then
            btnCancela.Click;

          {************************************************************}
          {* QUANDO NÃO É GRAVAÇÃO FÍSICA, PERMITE ALTERAR OU EXCLUIR *}
          {* UM CHEQUE OU CONTINUAR A INCLUSÃO DOS MESMOS             *}
          {********************************13/03/2018**Req. 98936**WS**}
          If Not blnGravacaoFisica Then
          Begin
            If cdsTabela.State = dsEdit Then
            Begin
              fMensagem('ATENÇÃO NA ALTERAÇÃO!', 'Este Cheque já foi Lançado, Altere os Dados do Mesmo!', ['&O k']);
              pSetFocus(dbeCodBco);
            End
            Else
            Begin
              pOnStateChange;
              pEnabled(Self, False);
              If fMensagem('AVISO', 'Este cheque já foi lançado! Deseja Alterá-lo ou Excluí-lo?', ['&Sim', '&Não']) = 2 Then
              Begin
                If fFormataFloat(fltValTot, 2) > fFormataFloat(fltValAtu, 2) Then
                Begin
                  edtTotDig.Text := FormatFloat('#.#,0',fltValAtu);
                  edtTotGer.Text := FormatFloat('#.#,0',fltValTot);
                  btnIncluir.Click;
                  fltValAlt := 0;
                End
              End;
            End;
          End;
        End;

      End;

      If Not (blnGravacaoFisica) And
         Not (blnResCai) And Not (blnCtaRec) Then
      Begin
        If (Assigned(dicCheques)) And
           (dicCheques.Count > 0) Then
        Begin
          If dicCheques.ContainsKey(dbeCodBco.Text+dbeNumAge.Text+dbeConCor.Text+dbeNumChq.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Cheque já informado: ' + #13+#10 +
                                  'Banco - ' + dbeCodBco.Text + ' Agência - ' + dbeNumAge.Text + #13+#10 +
                                  'Conta - ' + dbeConCor.Text + ' Cheque - ' + dbeNumChq.Text  + #13+#10 +
                                  'Valor - R$ ' + FormatFloat('#,##0.00', dicCheques[dbeCodBco.Text+dbeNumAge.Text+dbeConCor.Text+dbeNumChq.Text].fltValChq) + #13+#10 +
                                  'Verifique!', ['&O k']);
            Result := False;
          End;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO CLIENTE            *}
    {**************************************MV*}
    Else If (Sender = dbeCodCli) Then
    Begin
      If fEmptyStr(dbeCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If blnCarregarCliente Then
          pCarregaCliente;

        If qryConCli.FieldbyName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          strCliAnt := qryConCli.FieldbyName('CLI_CODCLI').AsString;

        If (blnBuscaPorChave) And (Not blnCarregarCliente) Then
          pMostraObsCliente;
      End;

    End

    {*****************************************}
    {* VALIDA O EMITENTE                     *}
    {**************************************MV*}
    Else If (Sender = dbeNomEmi) Then
    Begin
      If fEmptyStr(dbeNomEmi.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Emitente deve ser preenchido!', ['&O k']);
        Result := False;
      End
    End

    {*****************************************}
    {* VALIDA SE É CNPJ OU CPF               *}
    {**************************************MV*}
    Else If (Sender = dbeCgcCpf) Then
    Begin
      If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') Then
      Begin
        fMensagem('AVISO!', 'Para prosseguir escolha 1(CNPJ) ou 2(CPF)!', ['&O K']);
        Result := False;
        dbeCgcCpf.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA O CNPJ OU CPF                  *}
    {**************************************MV*}
    Else If (Sender = dbeNumCgc) Then
    Begin
      If fEmptyStr(dbeNumCgc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&O k']);
        Result := False;
        blnMudarFoco := False;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text);

        If (fEmitenteBloqueado(dbeNumCgc.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse emitente está bloqueado! Verifique.', ['&O k']);
          Result := False;
        End
        Else If (fRetDadosEmitente(dbeNumCgc.Text, strNomEmi, strEndere, strTele01)) And
                (dbeNumCgc.Text <> strEmiAnt)                                        And
                (cdsTabela.State in [dsInsert,dsEdit])                               Then
        Begin
          dbeNomEmi.Field.AsString := IIF(dbeNomEmi.Enabled,strNomEmi,dbeNomEmi.Field.AsString);
          dbeEndere.Field.AsString := IIF(dbeEndere.Enabled,strEndere,dbeEndere.Field.AsString);
          dbeTelEmi.Field.AsString := IIF(dbeTelEmi.Enabled,strTele01,dbeTelEmi.Field.AsString);
        End;

        If (Result) Then
          strEmiAnt := dbeNumCgc.Text;

      End;

      {* 22/01/2015 ***********************************************}
      {* VERIFICA PENDENCIAS PELO CPF/CNPJ DO EMITENTE DE CHEQUES *}
      {* DEVOLVIDOS E DOS RECEBER EM ABERTO QUE JA TENHAM VENCIDO *}
      {* RQ. 24730 *********************************************BB*}
      If Not blnLiberaDebito Then
      Begin
        If Not(fEmptyStr(dbeNumCgc.Text)) Then
        Begin
          stlMsgSenVar := TStringList.Create();
          try
            fltTotDebGeral := 0;
            blnDebChq := fConstaDebitos('CADCHQ', dbeNumCgc.text, stlMsgSenVar);
            blnDebCtr := fConstaDebitos('CADREC', dbeNumCgc.text, stlMsgSenVar);
            If blnDebChq Or blnDebCtr Then
            Begin
              stlMsgSenVar.Add(fPadL('TOTAL GERAL:', 95) + fPadL(FormatFloat('0.00', fltTotDebGeral), 16));
              If (Not fChamaSenhaVariavel(FRotinaChamada + #13 + #13 +
                                          'O CPF/CNPJ INFORMADO: ' + dbeNumCgC.text + ' POSSUI CHEQUES DEVOLVIDOS OU CONTAS A RECEBER EM ATRASO.' + #13#10 + stlMsgSenVar.Text,
                                          'CHQPENFIN',
                                          '',
                                          'CPF/CNPJ com cheques devolvidos ou débito vencido em aberto.',
                                          strLoginUsuarioLogado,
                                          dbeCodCli.Text + '-' + edtNomCli.Text)) Then
                Result := False
              Else
                blnLiberaDebito:= True;
            End;
          finally
            FreeAndNil(stlMsgSenVar);
          end;
        End;
      End;
    End

    {*********************************}
    {* VALIDA O TELEFONE DO EMITENTE *}
    {******************************BB*}

		Else If (Sender = dbeTelEmi)  Then
    Begin

    	If (Not fEmptyStr(TMaskEditTelefone(Sender).Text)) And
      (Not fValidaTelefone(TMaskEditTelefone(Sender).Text)) Then
      Begin
      	fMensagem('','Informe o telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
      	TMaskEditTelefone(Sender).Text := fAcertaMaskTel(TMaskEditTelefone(Sender).Text);
      End;

    End


    {*****************************************}
    {* VALIDA A DATA DE CADASTRO             *}
    {**************************************MV*}
    Else If (Sender = dbeDtaCad) Then
    Begin
      if dteDataLanLoc <> 0 then
        dbeDtaCad.DataSource.DataSet.FieldByName('CHQ_DTACAD').Value := dteDataLanLoc;

      If fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (blnResumida) And (blnPrazo) Then
      Begin
        If (StrToDateTimeDef(dbeDtaCad.Text, 0) < VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser maior ou igual a Data de Hoje!', ['&O k']);
          Result := False;
        End;
      End;

      //FECHAMENTO FINANCEIRO
      if not fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)) and Result Then
      begin
        if (cdsTabela.State = dsInsert) then
          if objFechamento.FechamentoFinanceiroJaRealizado(VS_StrCodEmp, StrToDate(dbeDtaCad.Text)) then
            Result := False;

        if ((cdsTabela.State = dsEdit) And (ADataCadastroInicial <> StrToDate(dbeDtaCad.Text))) then
        begin
          if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, ADataCadastroInicial) then
            Result := False
          else
          if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, StrToDate(dbeDtaCad.Text)) then
            Result := False;
        end;
      end;
    End

    {*****************************************}
    {* VALIDA A DATA DE VENCIMENTO           *}
    {**************************************MV*}
    Else If (Sender = dbeDtaVen) Then
    Begin
      if dteDataLanLoc <> 0 then
        dbeDtaVen.DataSource.DataSet.FieldByName('CHQ_DTAVEN').Value := dteDataLanLoc;

      If fEmptyStr(fTiraCaracEspeciais(dbeDtaVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text))) And (StrToDateDef(dbeDtaVen.Text, 0) < StrToDateDef(dbeDtaCad.Text, 0)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior ou igual que a data de cadastro!', ['&O k']);
          Result := False;
        End;
      End;

      If (blnResumida) And (blnPrazo) And (Result) Then
      Begin
        If (StrToDateTimeDef(dbeDtaVen.Text, 0) <= VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior que a Data de Hoje!', ['&O k']);
          Result := False;
        End;
      End;

      If blnValidarVencConPag Then
      begin
        if (StrToDateTimeDef(dbeDtaVen.Text, 0) > IncDay(VS_Date, StrToIntDef(Copy(strConPag, Length(strConPag)-2, 3), 0))) then
        begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento não pode ser maior que o dia limite da condição de pagamento!', ['&O k']);
          Result := False;
        end;
      end;
    End

    {*****************************************}
    {* VALIDA O VALOR DO CHEQUE              *}
    {**************************************MV*}
    Else If (Sender = dbeValChq) And dbeValChq.Enabled Then
    Begin
      if fltValLanLoc <> 0 then
         dbeValChq.Text := FormatFloat('#0.00', fltValLanLoc);

      If fEmptyStr(dbeValChq.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Cheque deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else If fStrToFloat(dbeValChq.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Cheque deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;

      If cdsTabela.State = dsEdit Then
        fltCalcRest := fltValTot - fltValAtu + fltValAlt
      Else
        fltCalcRest := fltValTot - fltValAtu;

      If (Not blnTroChq) And
         (fFormataFloat(fStrToFloat(dbeValChq.Text),2) > fFormataFloat((fltCalcRest),2)) And (fltValTot > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Cheque deve ser menor ou igual a: ' + FormatFloat('#.#,0', fltCalcRest), ['&O k']);
        Result := False;
      End;

      //FECHAMENTO FINANCEIRO
      If Result And (cdsTabela.State = dsEdit) And (fltValChqAnt <> fStrToFloat(dbeValChq.Text))  Then
        if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, StrToDate(dbeDtaCad.Text)) then
          Result := False;

      If Result And (cdsTabela.State = dsEdit) And blnGravacaoFisica
         And (fltValChqAnt <> fStrToFloat(dbeValChq.Text))  Then
      Begin
      
        If Not fEmptyStr(strChqSvd) Then
        Begin
          If ffrmSenha(strSenha, 'Senha para alteração do Valor') Then
          Begin
            If strSenha <> strChqSvd Then
              Result := False
          End
          Else
            Result := False;
        End;

        If Result Then
          fltValChqAnt := fStrToFloat(dbeValChq.Text)
        Else
          dbeValChq.Text := FormatFloat('#0.00', fltValChqAnt);

      End;
    End

    Else If (Sender = dbeTelChe) And dbeTelChe.Enabled Then
    Begin

      If Pos(dbeTelChe.Text, 'SN') = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe (S)im ou (N)não para Telecheque' , ['&O k']);
        Result := False;
      End

      Else
      Begin
        If (dbeTelChe.Text = 'N') Then
          dbeTelNum.Clear;
        dbeTelNum.Enabled := dbeTelChe.Enabled And (dbeTelChe.Text = 'S');
      End;

    End

    Else If (Sender = dbeTelNum) And dbeTelNum.Enabled Then
    Begin

      If (dbeTelChe.Text = 'S') And fEmptyStr(dbeTelNum.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código de Acesso do Telecheque' , ['&O k']);
        Result := False;
      End;

    End
    Else If (Sender = dbeDtaDev) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaDev.Text)) Then
      Begin
        dbeDtaDev.Field.Value := Null;
        dbeMotDev.Enabled     := False;
        dbeMotDev.Clear;
      End
      Else
      If StrToDateDef(dbeDtaDev.Text, 0) < dbeDtaDep.Field.AsDateTime Then
      Begin
        fMensagem('ATENÇÃO!', 'A data da devolução deve ser maior ou igual a data de depósito!', ['&O k']);
        Result := False;
      End
      Else
      if dbeDtaDep.Field.AsDateTime <=  VS_Date then
      begin
        //FECHAMENTO
        if (dbeDtaDev.Enabled) then
          if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, StrToDate(dbeDtaDev.Text)) then
            Result := False;

        If StrToDateDef(dbeDtaDev.Text, 0) > VS_Date Then
        Begin
          fMensagem('ATENÇÃO!', 'A data da devolução deve ser menor ou igual a data de hoje!', ['&O k']);
          Result := False;
        End;
       End
      Else
      Begin
        dbeMotDev.Enabled := True;

        If (Not dbeForRep.Field.IsNull)            And
           (Not fEmptyStr(dbeForRep.Field.Value)) Then
        Begin
          blnRepasse := True;
          dbeDevDef.Checked := True;
          dbeDevDef.Field.Value := dbeDevDef.ValueChecked;
        End;
      End;
    End

    Else If (Sender = dbeDtaDv2) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text)) Then
      Begin
        dbeDtaDv2.Field.Value := Null;
        dbeMotDv2.Enabled     := False;
        dbeMotDv2.Clear;
      End
      Else If StrToDateDef(dbeDtaDv2.Text, 0) < dbeDtaDp2.Field.AsDateTime Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data da segunda devolução deve ser maior ou igual a data de redepósito!', ['&O k']);
        Result := False;
      End
      Else
      if dbeDtaDv2.Field.AsDateTime <=  VS_Date then
      begin
        If StrToDateDef(dbeDtaDv2.Text, 0) > VS_Date Then
        Begin
          fMensagem('ATENÇÃO!', 'A data da devolução deve ser menor ou igual a data de hoje!', ['&O k']);
          Result := False;
        End;

        //FECHAMENTO
        if (dbeDtaDv2.Enabled) then
          if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, StrToDate(dbeDtaDv2.Text)) then
            Result := False;
      end
      Else
      Begin
        //FECHAMENTO
        if (dbeDtaDv2.Enabled) then
          if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, StrToDate(dbeDtaDv2.Text)) then
            Result := False;

        dbeMotDv2.Enabled := True;

        If (Not dbeForRep.Field.IsNull)            And
           (Not fEmptyStr(dbeForRep.Field.Value)) Then
        Begin
          blnRepasse := True;
          dbeDevDef.Checked := True;
          dbeDevDef.Field.Value := dbeDevDef.ValueChecked;
        End;
      End;
    End


    Else If (Sender = dbeDtaDp2) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaDp2.Text)) Then
      Begin
        dbeDtaDp2.Field.Value := Null;
      End
      Else If StrToDateDef(dbeDtaDp2.Text, 0) < dbeDtaDep.Field.AsDateTime Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Redepósito deve ser maior ou igual a data do primeiro deposito!', ['&O k']);
        Result := False;
      End
      Else If StrToDateDef(dbeDtaDp2.Text, 0) < dbeDtaDev.Field.AsDateTime Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Redepósito deve ser maior ou igual a data da primeira devolução!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbePorChq) And blnChamadoDoManutencao Then
    Begin
      If fEmptyStr(dbePorChq.Text) Then
      begin
        If fObrigatorioPortadorEConta Then
        Begin
          fMensagem('ATENÇÃO!', 'O Portador do Movimento Bancário deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
          edtDesPorChq.Clear;
      End
      Else
      Begin
        edtDesPorChq.Text := fRetNomPortador(dbePorChq.Text);
        If fEmptyStr(edtDesPorChq.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não encontrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(dbePorChq.Text) Or Not fEmpresaTemAcessoPortador(dbeCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(dbePorChq.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If Sender = dbeCodCid Then
    Begin
      If Not fEmptyStr(dbeCodCid.Text) Then
      Begin
        pCarregaCidade;

        If qryConCid.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End else
      begin
        dbeCodCid.Field.Value := Null;
      end;
    End

    Else If (Sender = fraPlanoDeContasMov.dbeCodCta) And blnChamadoDoManutencao Then
    Begin
      If fEmptyStr(fraPlanoDeContasMov.dbeCodCta.Text) Then
      begin
        If fObrigatorioPortadorEConta Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas do Movimento Bancário deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
          fraPlanoDeContasMov.edtDesCta.Clear;
      End
      Else
      Begin
        If (qryTabela.State = dsInsert) Then
        Begin
          pCarregaCentroCusto;

          If Not PlanoDeContasAtivo(fraPlanoDeContasMov.dbeCodCta.Text) Then
            Result := False;
        End
        Else
        Begin
          If qryConCta.FieldByName('CTA_CODCTA').AsString <> fraPlanoDeContasMov.dbeCodCta.Text Then
          Begin
            If Not PlanoDeContasAtivo(fraPlanoDeContasMov.dbeCodCta.Text) Then
              Result := False;
          End;
        End;

        If fEmptyStr(fraPlanoDeContasMov.edtDesCta.Text) then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
    
  End;

  If (Not Result) Then
  Begin
    Try
      pSetFocus(Sender);
    Except
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCheques.HabilitaAlteracaoLiberacaoCaixas;
begin
  If Rotina <> 'LIBERAÇÃO TRANSFERÊNCIAS' Then
    Exit;

  btnAlterar.Enabled := True;
  btnCorrigeCheque.Enabled := True;

  btnIncluir.Enabled := False;
  btnExcluir.Enabled := False;
  btnPesquisa.Enabled := False;
  btnImprimir.Enabled := False;
  btnDepositoCheque.Enabled := False;
  btnCancelaDeposito.Enabled := False;
  btnAltPortador.Enabled := False;
  btnTransfereCtr.Enabled := False;
  btnCancelTransfCtR.Enabled := False;
  btnHistReceb.Enabled := False;
  btnHistorico.Enabled := False;
  btnHistRecebLog.Enabled := False;
end;

function TfrmCadCheques.LancamentoVeioDoCaixaEEstaFechado: Boolean;
  Var
    fltUltFec: Double;
    dtaDtaFec: TDateTime;

    LResumoDeCaixa: TResumoDeCaixa;

    LDataLancamentoCaixa: TDateTime;
begin
  Result := (fCfgSis('RCXTCC') = 1);

  If Not Result Then
    Result := cdsTabela.FieldByName('CHQ_RESCAI').AsString <> '1';

  If Result Then
    Exit;

  LResumoDeCaixa := TResumoDeCaixa.Create;
  If qryTabela.FieldByName('CHQ_CODCAX').AsString.IsEmpty Then
    LResumoDeCaixa.strTipoFechamento := 'T';

  Try
    LResumoDeCaixa.fRetornaUltimoFechamento(fltUltFec,
                                            dtaDtaFec,
                                            cdsTabela.FieldByName('CHQ_CODCAX').AsString,
                                            cdsTabela.FieldByName('CHQ_EMPRCX').AsString);

    If Not Result Then
    Begin
      If cdsTabela.FieldByName('CHQ_DTATRA').AsDateTime <> 0 Then
      Begin
        LDataLancamentoCaixa := LResumoDeCaixa.RetornaDataDoLancamentoCaixa(cdsTabela.FieldByName('CHQ_SEQCON').AsInteger,
                                                                            cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime,
                                                                            cdsTabela.FieldByName('CHQ_EMPRCX').AsString,
                                                                            cdsTabela.FieldByName('CHQ_CODCAX').AsString);

        Result := LDataLancamentoCaixa <= dtaDtaFec;

        If Result Then
          Result := LDataLancamentoCaixa < VS_Date;
      End;
    End;
  Finally
    FreeAndNil(LResumoDeCaixa);
  End;
end;

procedure TfrmCadCheques.LimparDataSet;
begin
  Try
    qryTabela.Close;
    cdsTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
    qryTabela.Open;

    If qryTabela.FindField('AUTOINCREM') <> Nil Then
    Begin
      dspTabela.UpdateMode := upWhereKeyOnly;
      qryTabela.FieldByName('AUTOINCREM').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
    End;

    cdsTabela.Open;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadCheques.LimparDataSet]');
    End;
  End;
end;

function TfrmCadCheques.fGetSqlQryConsultaDebitoCadRec(strC_G_C: String): String;
var
  objChaveCtr: TChaveCtr;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CTR_VALDUP, ';
  Result := Result + '   CTR_JURSUJ, ';
  Result := Result + '   CTR_DESSUJ, ';
  Result := Result + '   CTR_DTAVEN, ';
  Result := Result + '   CTR_NUMDUP, ';
  Result := Result + '   CTR_PARCEL, ';
  Result := Result + '   CTR_ESPDOC, ';
  Result := Result + '   CTR_CODEMP, ';
  Result := Result + '   CTR_DTACAD, ';
  Result := Result + '   CLI_ATRMAX  ';
  Result := Result + ' FROM ';
  Result := Result + '   CADCLI ';
  Result := Result + '   LEFT JOIN CADREC ON CTR_CODCLI = CLI_CODCLI ';
  Result := Result + ' WHERE (';
  Result := Result + '   CLI_C_G_C_ = "' + strC_G_C + '" ';
  If fCfgSis('TRFTCR', varString) = '2' Then
  Begin
    Result := Result + '    OR CLI_CODRED = ';
    Result := Result + '    (SELECT ';
    Result := Result + '       CLI_CODRED ';
    Result := Result + '     FROM ';
    Result := Result + '       CADCLI ';
    Result := Result + '     WHERE CLI_C_G_C_ = "' + strC_G_C + '" ';
    Result := Result + '     LIMIT 1) ';
  End;
  Result := Result + ' ) AND CTR_DTAREC IS NULL ';
  Result := Result + '   AND CTR_VALDUP > 0 ';
  Result := Result + '   AND CTR_DTAVEN < CURDATE() ';

  If not fEmptyStr(strConfDocsAutIncCadRec) Then
    Result := Result + '   AND LOCATE(CADREC.AUTOINCREM, '+QuotedStr(strConfDocsAutIncCadRec)+' ) = 0 ';

  For objChaveCtr in oblCtrBaixando Do
  Begin
    Result := Result + '   AND ( ';
    Result := Result + '     NOT ( ';
    Result := Result + '       CTR_NUMDUP = ' + QuotedStr(objChaveCtr.strNumDoc);
    Result := Result + '       AND CTR_CODEMP = ' + QuotedStr(objChaveCtr.strCodEmp);
    Result := Result + '       AND CTR_ESPDOC = ' + QuotedStr(objChaveCtr.strEspDoc);
    Result := Result + '       AND CTR_CODCLI = ' + QuotedStr(objChaveCtr.strCodCli);
    Result := Result + '       AND CTR_PARCEL = ' + QuotedStr(objChaveCtr.strParcel);
    Result := Result + '     ) ';
    Result := Result + '   ) ';
  End;
end;

function fGetSqlQryConsultaDebitoCadChq(strC_G_C: String): String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CHQ_VALCHQ,';
  Result := Result + '   CHQ_DTAVEN,';
  Result := Result + '   CHQ_NUMAGE,';
  Result := Result + '   CHQ_CONCOR,';
  Result := Result + '   CHQ_NUMCHQ,';
  Result := Result + '   CHQ_DTACAD,';
  Result := Result + '   CHQ_DTADEV,';
  Result := Result + '   CHQ_DTADV2,';
  Result := Result + '   CHQ_DTADV3,';
  Result := Result + '   CHQ_MOTDEV,';
  Result := Result + '   CHQ_MOTDV2,';
  Result := Result + '   CHQ_MOTDV3,';
  Result := Result + '   CLI_ATRMAX ';
  Result := Result + ' FROM ';
  Result := Result + '   CADCHQ ';
  Result := Result + ' INNER JOIN CADCLI ';
  Result := Result + '   ON CLI_CODCLI = CHQ_CODCLI ';
  Result := Result + ' WHERE (';
  Result := Result + '   CHQ_C_G_C_ = "' + strC_G_C + '" ';
  If fCfgSis('TRFTCR', varString) = '2' Then
  Begin
    Result := Result + '    OR CLI_CODRED = ';
    Result := Result + '    (SELECT ';
    Result := Result + '       CLI_CODRED ';
    Result := Result + '     FROM ';
    Result := Result + '       CADCLI ';
    Result := Result + '     WHERE CLI_C_G_C_ = "' + strC_G_C + '" ';
    Result := Result + '     LIMIT 1)';
  End;
  Result := Result + ' ) AND ((CHQ_DTADEV IS NOT NULL AND CHQ_DTADP2 IS NULL) OR ';
  Result := Result + '    (CHQ_DTADV2 IS NOT NULL AND CHQ_DTADP3 IS NULL) OR ';
  Result := Result + '    (CHQ_DTADV3 IS NOT NULL)) ';
  Result := Result + '   AND CHQ_INCCTR = "N" ';
end;

function TfrmCadCheques.fConstaDebitos(strTbl: String; strParamSQL : String; stlMsgSenVar: TStrings) : Boolean;
var
  strSQL: String;
  blnPosAtr: Boolean;
  fltTotDeb: Double;
begin
  Result := True;
  strSQL := '';
  fltTotDeb := 0;
  blnPosAtr := False;

  If Not(fEmptyStr(strTbl)) Then
  Begin
    If (strTbl = 'CADCHQ') Then
      strSQL := fGetSqlQryConsultaDebitoCadChq(strParamSQL)
    Else if (strTbl = 'CADREC') Then
      strSQL := fGetSqlQryConsultaDebitoCadRec(strParamSQL);

    Try
      If (Not fEmptyStr(strSql)) Then
      Begin
        qryConsultaDebitos := fCriaQuery;

        With qryConsultaDebitos do
        begin
          Close;
          Sql.Clear;
          Sql.Add(strSQL);
          Open;

          If Not IsEmpty Then
          Begin
            stlMsgSenVar.Add('');
            If (strTbl = 'CADCHQ') Then
            Begin
              stlMsgSenVar.Add(fPadC('CHEQUES DEVOLVIDOS', 112));
              stlMsgSenVar.Add(fReplicatorStr('-', 112));
              stlMsgSenVar.Add('|' + fPadC('AGÊNCIA', 9) +
                               '|' + fPadC('CONTA', 10) +
                               '|' + fPadC('NR. CHEQUE', 12) +
                               '|' + fPadC('DT. CADASTRO', 12) +
                               '|' + fPadC('VENCIMENTO', 12) +
                               '|' + fPadC('DATA DEV.', 12) +
                               '|' + fPadC('MOTIVO DA DEV.', 20) +
                               '|' + fPadC('VALOR', 16) + '|');
            End
            Else if (strTbl = 'CADREC') Then
            Begin
              stlMsgSenVar.Add(fPadC('CONTAS A RECEBER EM ATRASO', 112));
              stlMsgSenVar.Add(fReplicatorStr('-', 112));
              stlMsgSenVar.Add('|' + fPadC('NR. DUPLICATA', 16) +
                               '|' + fPadC('PARCELA', 7) +
                               '|' + fPadC('ESPÉCIE', 8) +
                               '|' + fPadC('EMPRESA', 8) +
                               '|' + fPadC('DATA DE CADASTRO', 16) +
                               '|' + fPadC('VENCIMENTO', 16) +
                               '|' + fPadC('VALOR', 16) +
                               '|' + fPadC('VALOR CORRIGIDO', 16) + '|');
            End;
            stlMsgSenVar.Add(fReplicatorStr('-', 112));

            First;
            While Not Eof Do
            Begin
              If SameText(strTbl, 'CADCHQ') Then
              Begin
                stlMsgSenVar.Add('|' + fPadL(FieldByName('CHQ_NUMAGE').AsString, 9) +
                                 '|' + fPadL(FieldByName('CHQ_CONCOR').AsString, 10) +
                                 '|' + fPadL(FieldByName('CHQ_NUMCHQ').AsString, 12) +
                                 '|' + fPadC(FieldByName('CHQ_DTACAD').AsString, 12) +
                                 '|' + fPadC(FieldByName('CHQ_DTAVEN').AsString, 12) +
                                 '|' + fPadC(FieldByName('CHQ_DTADEV').AsString, 12) +
                                 '|' + fPadR(FieldByName('CHQ_MOTDEV').AsString, 20) +
                                 '|' + fPadL(FormatFloat('0.00', FieldByName('CHQ_VALCHQ').AsFloat), 16) +'|');

                If Not FieldByName('CHQ_DTADV2').IsNull Then
                  stlMsgSenVar.Add('|' + fPadR('', 59) +
                                   '|' + fPadC(FieldByName('CHQ_DTADV2').AsString, 12) +
                                   '|' + fPadR(FieldByName('CHQ_MOTDV2').AsString, 20) +
                                   '|' + fPadR('', 16) + '|');

                If Not FieldByName('CHQ_DTADV3').IsNull Then
                  stlMsgSenVar.Add('|' + fPadR('', 59) +
                                   '|' + fPadC(FieldByName('CHQ_DTADV3').AsString, 12) +
                                   '|' + fPadR(FieldByName('CHQ_MOTDV3').AsString, 20) +
                                   '|' + fPadR('', 16) + '|');

                fltTotDeb := fltTotDeb + FieldByName('CHQ_VALCHQ').AsFloat;

                If fCfgSis('CLIATR', varBoolean) Then
                Begin
                  If (FieldByName('CHQ_DTAVEN').AsDateTime + FieldByName('CLI_ATRMAX').AsInteger) < VS_Date Then
                    blnPosAtr := True;
                End
                Else
                Begin
                  If (FieldByName('CHQ_DTAVEN').AsDateTime + fCfgSis('ATRMAX', varInteger)) < VS_Date Then
                    blnPosAtr := True;
                End;
              End
              Else
              Begin
                stlMsgSenVar.Add('|' + fPadL(FieldByName('CTR_NUMDUP').AsString, 16) +
                                 '|' + fPadC(FieldByName('CTR_PARCEL').AsString, 7) +
                                 '|' + fPadC(FieldByName('CTR_ESPDOC').AsString, 8) +
                                 '|' + fPadC(FieldByName('CTR_CODEMP').AsString, 8) +
                                 '|' + fPadC(FieldByName('CTR_DTACAD').AsString, 16) +
                                 '|' + fPadC(FieldByName('CTR_DTAVEN').AsString, 16) +
                                 '|' + fPadL(FormatFloat('0.00', FieldByName('CTR_VALDUP').AsFloat), 16) +
                                 '|' + fPadL(FormatFloat('0.00', FieldByName('CTR_VALDUP').AsFloat +
                                                                 fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                     FieldByName('CTR_VALDUP').AsFloat)), 16) + '|');

                fltTotDeb := fltTotDeb + FieldByName('CTR_VALDUP').AsFloat + fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime, FieldByName('CTR_VALDUP').AsFloat);

                If fCfgSis('CLIATR', varBoolean) Then
                Begin
                  If (FieldByName('CTR_VALDUP').AsFloat > 0) And
                     ((FieldByName('CTR_DTAVEN').AsDateTime + FieldByName('CLI_ATRMAX').AsInteger) < VS_Date) Then
                    blnPosAtr := True;
                End
                Else
                Begin
                  If (FieldByName('CTR_VALDUP').AsFloat > 0) And
                     ((FieldByName('CTR_DTAVEN').AsDateTime + fCfgSis('ATRMAX', varInteger)) < VS_Date) Then
                    blnPosAtr := True;
                End;
              End;

              Next;
            End;
            If SameText(strTbl, 'CADCHQ') Then
            Begin
              stlMsgSenVar.Add(fReplicatorStr('-', 112));
              stlMsgSenVar.Add(fPadL('TOTAL EM CHEQUES DEVOLVIDOS:', 95) + fPadL(FormatFloat('0.00', fltTotDeb), 16));
            End
            Else
            Begin
              stlMsgSenVar.Add(fReplicatorStr('-', 112));
              stlMsgSenVar.Add(fPadL('TOTAL EM CONTAS EM ATRASO:', 95) + fPadL(FormatFloat('0.00', fltTotDeb), 16));
            End;
            fltTotDebGeral := fltTotDebGeral + fltTotDeb;
          End;
        End;

        Result := blnPosAtr And (fltTotDeb > 0);

        qryConsultaDebitos.Close;
        FreeAndNil(qryConsultaDebitos);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[untCadCheques.fConstaDebitos.' + strtbl + ']');
    End;
  End;

end;

{* 22/01/2015 ********************}
{* FUNÇÃO PARA CHAMAR FDIG1SENVAR *}
{* RQ 24730 *******************BB*}

function TfrmCadCheques.fAbertoPeloContasAReceber: Boolean;
begin
  Result := (Not blnChamadoDoManutencao) And (Not blnResCai);
end;

function TfrmCadCheques.fChamaSenhaVariavel(strMsg, strDirAce, strCfgSis,
  strMsgSen, strOperador: String; strCliente: String): Boolean;
begin
  Result := True;
  While (True) Do
  Begin
    Try
      objLiberacao.Clear;
      objLiberacao.strDirAce    := strDirAce;
      objLiberacao.strSenLib    := fCfgSis(strCfgSis);
      objLiberacao.strMsgSen    := strMsgSen;
      objLiberacao.blnMosMen    := True;
      objLiberacao.strCodOpe    := strOperador;
      objLiberacao.strCodDig    := strOperador;
      objLiberacao.strCliente   := strCliente;
      objLiberacao.objMsgLibera.pAddTexto(strMsg);

      If objLiberacao.fLibera Then
        Break
      else
        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
        Begin
          Result := False;
          Exit;
        End;

    Finally
      objLiberacao.Clear;
    End;

  End;
end;

procedure TfrmCadCheques.pCarregaBanco;
begin
  pPesquisaCadBco(qryConBco, qryConBco, dbeCodBco.Text);
  edtNomBan.Text := qryConBco.FieldByName('BCO_NOMBCO').AsString;
end;

procedure TfrmCadCheques.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, dbeCodCli.Text);
  edtNomCli.Text := qryConCli.FieldByName('CLI_NOMCLI').AsString;

  If (cdsTabela.State = dsInsert) And ((strCliAnt <> qryConCli.FieldByName('CLI_CODCLI').AsString) Or (fEmptyStr(dbeNomEmi.Text))) Then
  Begin
    With qryConCli Do
    Begin
      strCliAnt := qryConCli.FieldByName('CLI_CODCLI').AsString;
      cdsTabela.FieldByName('CHQ_NOMEMI').AsString := FieldByName('CLI_NOMCLI').AsString;
      cdsTabela.FieldByName('CHQ_TELEMI').AsString := FieldByName('CLI_FONE01').AsString;
      cdsTabela.FieldByName('CHQ_ENDERE').AsString := FieldByName('CLI_ENDERE').AsString;
      cdsTabela.FieldByName('CHQ_CGCCPF').AsString := FieldByName('CLI_CGCCPF').AsString;
      cdsTabela.FieldByName('CHQ_C_G_C_').AsString := FieldByName('CLI_C_G_C_').AsString;

      blnCarregarCliente := False;
      fValidaCampos(dbeCodCli, True);
      blnCarregarCliente := True;

    End;
  End;
end;

procedure TfrmCadCheques.pCarregaDadosAdicionais;
begin
  pCarregaBanco;
  pCarregaCliente;
  pCarregaPortador;
  pCarregaPortador2;
  pCarregaCentroCusto;
  pCarregaFornecedor;
  pCarregaDadosAnteriores;
  pCarregaCidade;
  If Not blnResumida Then
    pCarregaTelecheque;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnAlterar.Enabled       := False;
    btnExcluir.Enabled       := False;
    btnCorrigeCheque.Enabled := False;
    btnHistorico.Enabled     := False;
    btnHistReceb.Enabled     := False;
  End;

  strEmiAnt := dbeNumCgc.Text;
  lblDupDev.Visible       := cdsTabela.Active And (Not cdsTabela.FieldByName('CHQ_DTADV2').IsNull);
  dbeDupDev.Visible       := lblDupDev.Visible;

  If (Not fEmptyStr(cdsTabela.FieldByName('CHQ_DUPDEP').AsString)) Then
  Begin
    lblInfo.Caption := 'Este Cheque foi transferido para o Contas a Receber';
    lblInfo.Visible := True;

    btnTransfereCtR.Enabled := False;
    btnCancelTransfCtR.Enabled := True;
  End
  Else
  Begin
    lblInfo.Caption := '';
    lblInfo.Visible := False;
    btnCancelTransfCtR.Enabled := False;
  End;

  pDesabilitaChequesDevolvidos;

  HabilitaAlteracaoLiberacaoCaixas;
end;

procedure TfrmCadCheques.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CHQ_NUMCHQ');
  stlCamInd.Add('CHQ_CONCOR');
  stlCamInd.Add('BCO_NOMBCO');
  stlCamInd.Add('CHQ_NOMEMI');
  stlCamInd.Add('CLI_NOMCLI');
  stlCamInd.Add('CHQ_C_G_C_');
  stlCamInd.Add('CHQ_DTACAD');
  stlCamInd.Add('CHQ_DTAVEN');
  stlCamInd.Add('CAST(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2) AS DATE)');
  stlCamInd.Add('CHQ_VALCHQ');
  stlCamInd.Add('CHQ_DOCUME');
  stlCamInd.Add('CHQ_NUMCHQ+CHQ_VALCHQ');

  stlDesInd.Add('Nro. Cheque');
  stlDesInd.Add('Cta. Corrente');
  stlDesInd.Add('Nome Banco');
  stlDesInd.Add('Emitente');
  stlDesInd.Add('Nome Cliente');
  stlDesInd.Add('CNPJ');
  stlDesInd.Add('Data Cadastro');
  stlDesInd.Add('Vencimento');
  stlDesInd.Add('Data Deposito');
  stlDesInd.Add('Valor');
  stlDesInd.Add('Documento');
  stlDesInd.Add('Nro. Cheque/Valor');

end;

procedure TfrmCadCheques.pLimpaDtaDev;
begin

  fMensagem('','Você está cancelando uma operação durante a gravação no banco de dados, para assegurar a integridade dos dados o sistema irá fechar esta tela!', ['&OK']);
  btnSair.Click;

end;

procedure TfrmCadCheques.pLimpaEdits;
begin
  edtNomBan.Clear;
  edtNomCli.Clear;
  edtNomFor.Clear;
  fraPlanoDeContasPla.edtDesCta.Clear;
  edtNomPor.Clear;
  edtNomTel.Clear;
  edtNomEmp.Clear;
  edtNomOpe.Clear;
  edtDesCid.Clear;
  edtEstado.Clear;
  chkLeitor.Checked := False;
  chkInfMan.Checked := False;
  lblInfo.Caption := '';
  lblInfo.Visible := False;
end;

procedure TfrmCadCheques.btnExcluirClick(Sender: TObject);
VAR
  strAutoIncrem: String;
begin
  {**********************************}
  { TRAVA PARA NÃO ALTERAR/EXCLUIR   }
  {********************************LE}
  If Not blnChamadoDoManutencao Then
  Begin
    If Not (fCarregaChequesTransferidos(cdsTabela.FieldByName('CHQ_SEQCON').AsInteger,
            cdsTabela.FieldByName('CHQ_CODEMP').AsString,
            cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime).IsEmpty) And (fCfgSis('RCXTCC') = '2')Then
    Begin
      fMensagem('','Há cheques transferidos relativos a essa baixa!.' + #13 +
                'Para excluir este cheque cancelar o sequencial: '+cdsTabela.FieldByName('CHQ_SEQTRF').AsString+'.'+#13
                +'RESUMO DE CAIXA > F1 - LANÇAMENTOS > TF - TRANSFERÊNCIA > [F8] CANCELAMENTO DE TRANSFERÊNCIAS.',['O K']);
      btnCancela.Click;
      Exit;
    End;
  End;
  If (Not cdsTabela.FieldByName('CHQ_DTADEP').IsNull) Then
  Begin
    fMensagem('INFORMAÇÃO','Cheque não poderá ser excluído. Cheque já depositado.',['&OK']);
    Exit;
  End;

  If blnResumida Then
  Begin
    fltValAlt := cdsTabela.FieldbyName('CHQ_VALCHQ').AsFloat
  End;

  If fMovimentoBancario(True) Then
  Begin
    fMensagem('ATENÇÃO','A movimentação bancária do cheque já está conciliada, não é possível excluir o cheque',['&OK']);
    Exit;
  End;

  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(cdsTabela.FieldByName('CHQ_CODEMP').AsString, cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime) then
    Exit;

  Try

    strAutoIncrem := cdsTabela.FieldByName('AUTOINCREM').AsString;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    inherited;

    {*************************************}
    {* SE EXCLUIU ENTÃO ATUALIZA O VALOR *}
    {**********************************AF*}
    If (blnExcluiu) Then
    Begin
      fLock_Unlock('CADCHQ' + strAutoIncrem, False);
      FillChar(recInclusao,SizeOf(recInclusao),#0);
      blnJaIncluiu := False;
      strEmiAnt := '';
      fltValAtu := fltValAtu - fltValAlt;
      fltValAlt := 0;

      fCommit;
    End
    Else
    Begin
      fRollBack;
      fltValAlt := 0;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCheques.btnExcluirClick]');
    End;
  End;

  {********************************************}
  {* USO ESSES CAMPOS PARA O LEITOR DE CHEQUE *}
  {*****************************************AC*}
  chkLeitor.Checked := False;
  chkInfMan.Checked := False;
  lblCheque.Visible := False;
  edtCheque.Visible := False;
  edtCheque.Clear;

  pCarregaDadosAdicionais;
  pHabilitaBtnTransfCtr;
  If (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDV2.Text))) Then btnImprimir.Enabled := True;

  If fFormataFloat(fltValTot, 2) > fFormataFloat(fltValAtu, 2) Then
  Begin
    edtTotDig.Text := FormatFloat('#.#,0',fltValAtu);
    edtTotGer.Text := FormatFloat('#.#,0',fltValTot);
    btnIncluir.Click;
  End;

  DesabilitaAlteracaoLiberacaoCaixas;
end;

procedure TfrmCadCheques.btnImprimirClick(Sender: TObject);
begin
  inherited;
  If (cdsTabela.Active) And (Not fEmptyStr(dbeNumChq.Text)) And
     ( Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDV2.Text)) ) Then
  Begin
    pImprimeComprovante;
  End;
end;

procedure TfrmCadCheques.btnIncluirClick(Sender: TObject);
  Var
    stlDatas : TStringList;
    dtaDtaVen: TDateTime;
    frmPorCredMovban: TfrmPorCredMovban;
begin
  dbeCgcCpf.Enabled := True;
  dtaDtaVen := 0;
  {***********************************}
  {* CASO ESTEJA PREENCHIDA A CNDPAG *}
  {* CALCULA A DATA DE VENCIMENTO    *}
  {********************************AF*}
  If (dtaDataChqPre > 0) Then
  Begin
    dtaDtaVen := dtaDataChqPre;
    dtaBkpVen := dtaDtaVen;
  End
  Else If Not fEmptyStr(strConPag) Then
  Begin
    dtaDtaVen := 0;
    stlDatas  := TStringList.Create;
    stlDatas.Text := WrapText(fFormataCondPag(strConPag), #13#10, [')', '.'], 04);

    If ((cdsTabela.RecordCount+1) >= stlDatas.Count) Then
      dtaDtaVen := dtaBkpVen


    Else If Not fEmptyStr(AnsiReplaceStr(stlDatas[cdsTabela.RecordCount + 1],'.','')) Then
    Begin
      dtaDtaVen := VS_Date + StrToInt( AnsiReplaceStr(stlDatas[cdsTabela.RecordCount + 1],'.','') );
      dtaBkpVen := dtaDtaVen;
    End;

    FreeAndNil(stlDatas);
  End;

  inherited;
  lblDupDev.Visible := False;
  dbeDupDev.Visible := False;
  pHabilitaBotoes;

  strEmiAnt := '';
  strMotAnt := '';
  dtaDevAnt := 0;
  strMt2Ant := '';
  dtaDv2Ant := 0;

  {********************************************}
  {* USO ESSES CAMPOS PARA O LEITOR DE CHEQUE *}
  {*****************************************AC*}

  If edtCheque.Visible Then
  Begin
    edtCheque.Visible := False;
    lblCheque.Visible := False;
  End;

  pLimpaEdits;
  qryConTel.Close;

  cdsTabela.FieldByName('CHQ_NAODEP').AsString   := 'N';
  cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime := VS_Date;

  If ((Not fEmptyStr(strConPag)) And (dtaDtaVen <> 0)) Or (dtaDataChqPre > 0) Then
    cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime := dtaDtaVen
  Else
    cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime := VS_Date;

  cdsTabela.FieldByName('CHQ_TRFLIB').AsString   := 'S';

  cdsTabela.FieldByName('CHQ_INCCTR').AsString   := 'N';
  cdsTabela.FieldByName('CHQ_TELCHE').AsString   := 'N';
  dbeTelChe.Enabled := fVerificaAcessoSistema('TELECHE', strCodOpe);
  dbeTelNum.Enabled := False;

  If Not fEmptyStr(strCodOpe) Then
  Begin
    cdsTabela.FieldByName('CHQ_CODOPE').AsString   := strCodOpe;
    edtDigChq.Text := strCodOpe + '-' + fRetNomeOperador(strCodOpe);
  End;

  If Not fEmptyStr(strDocume) And (Length(strDocume) > 3) Then
    cdsTabela.FieldByName('CHQ_DOCUME').AsString   := strDocume;

  If blnResumida Then
    dbeValChq.Field.AsFloat := fltValTot - fltValAtu;

  edtDigChq.Text := strCodOpe + '-' + fRetNomeOperador(strCodOpe);

  dbeValChq.Enabled          := True;
  dbeValChq.TabStop          := True;
  btnCorrigeCheque.Enabled   := False;
  btnHistorico.Enabled       := False;
  btnHistReceb.Enabled       := False;
  btnImprimir.Enabled        := False;
  btnTransfereCtR.Enabled    := False;
  btnCancelTransfCtR.Enabled := False;
  btnAltPortador.Enabled     := False;

  dbeMotDev.Enabled        := False;
  dbeDtaDev.Enabled        := False;
  dbeDevDef.Enabled        := False;
  dbeDtaDv2.Enabled        := False;
  dbeMotDv2.Enabled        := False;
  dbeCodCli.ReadOnly       := (FblnTravaCli) And (blnCarregarCliente);

  If blnResCai Or blnCtaRec Then
    dbeDtaCad.Enabled := False;

  pSetFocus(dbeCodBco);

  If (fCfgSis('RDADCH', varBoolean)) Then
  Begin
    If blnJaIncluiu Or (blnResumida And blnPrazo And Not fEmptyStr(recInclusao.strCodCli))  Then
      fDadosChequeAnterior;
  End;

  If blnResumida Then
    btnSair.Enabled := True;

  AtualizaNaoDep;

  grbCMC7.Enabled   := True;
  chkLeitor.Enabled := True;
  chkInfMan.Enabled := True;
  chkInfMan.Checked := True;

  If blnChamadoDoManutencao Then
  Begin
    pCriarFormularios(TfrmPorCredMovban, frmPorCredMovban);
    frmPorCredMovban.Caption := 'Dados para crédito no Movimento Bancário';
    frmPorCredMovban.rdgTipoChequeClick(Self);
    frmPorCredMovban.ShowModal;

    If Not frmPorCredMovban.blnConfirma then
    Begin
      fMensagem('Atenção', 'Seleção obrigatória de tipo de cheque, portador e plano de contas',['&OK']);
      FreeAndNil(frmPorCredMovBan);
      btnCancela.Click;
      Exit;
    End;

    {*REQ*145940**********RP*}
    If Not fEmpresaTemAcessoPortador(frmPorCredMovBan.edtPorBai.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      FreeAndNil(frmPorCredMovBan);
      btnCancela.Click;
      Exit;
    End;

    strCodPorCredMovBan  := frmPorCredMovBan.edtPorBai.Text;
    strCodPlanCredMovBan := frmPorCredMovBan.fraPlanoDeContas.MskCodCta.Text;
    blnPrazo             := (frmPorCredMovBan.rdgTipoCheque.ItemIndex = 1);

    dbePorChq.Field.Value := strCodPorCredMovBan;
    fraPlanoDeContasMov.dbeCodCta.Field.Value := strCodPlanCredMovBan;

    edtDesPorChq.Text := fRetNomPortador(dbePorChq.Text);
    pCarregaCentroCusto;

    FreeAndNil(frmPorCredMovBan);
  End;
end;

procedure TfrmCadCheques.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaBotoes;
  fLock_Unlock('CADCHQ' + cdsTabela.FieldByName('AUTOINCREM').AsString, False);
  pCarregaDadosAdicionais;

  pHabilitaBtnTransfCtr;
  dbeCgcCpf.Enabled        := False;
  btnCorrigeCheque.Enabled := True;
  btnHistorico.Enabled     := True;
  btnHistReceb.Enabled     := True;
  btnAltPortador.Enabled   := False;
  strMsgErr := '';
  If (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDV2.Text))) Then btnImprimir.Enabled  := True;

  {********************************************}
  {* USO ESSES CAMPOS PARA O LEITOR DE CHEQUE *}
  {*****************************************AC*}
  chkLeitor.Checked := False;
  chkInfMan.Checked := False;
  edtCheque.Clear;

  fltValAlt := 0;
  strEmiAnt := '';

  If (Not fEmptyStr(strDigAnt)) Then
    edtDigChq.Text := strDigAnt + '-' + fRetNomeOperador(strDigAnt)
  Else
    edtDigChq.Clear;

  HabilitaAlteracaoLiberacaoCaixas;

  DesabilitaAlteracaoLiberacaoCaixas;
end;

procedure TfrmCadCheques.btnCancelaDepositoClick(Sender: TObject);
  Var
    frmCancDepChequePreMod2 : TfrmCancDepChequePreMod2;
begin
  If (btnCancelaDeposito.Enabled) And (Not cdsTabela.IsEmpty) Then
    begin
      try
        pCriarFormularios(TfrmCancDepChequePreMod2, frmCancDepChequePreMod2);

        frmCancDepChequePreMod2.EdtCodBco.Text := cdsTabela.FieldByName('CHQ_CODBCO').AsString;
        frmCancDepChequePreMod2.EdtNomBco.Text := fRetNomeBco(cdsTabela.FieldByName('CHQ_CODBCO').AsString);
        frmCancDepChequePreMod2.EdtNumAge.Text := cdsTabela.FieldByName('CHQ_NUMAGE').AsString;
        frmCancDepChequePreMod2.EdtConCor.Text := cdsTabela.FieldByName('CHQ_CONCOR').AsString;
        frmCancDepChequePreMod2.EdtNumChq.Text := cdsTabela.FieldByName('CHQ_NUMCHQ').AsString;
        frmCancDepChequePreMod2.ShowModal;

        pLimpaEdits;
        qryTabela.Refresh;
        pCarregaChq;
        pHabilitaBotoes;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmCadCheques.btnCancelaDepositoClick]');
      End;

      pFreeAndNil(frmCancDepChequePreMod2);
    end;
end;

function TfrmCadCheques.fQueryContasReceber(strNumDup,
                                            strParcel,
                                            strEspDoc,
                                            strCodEmp,
                                            strCodCli: String;
                                            intSeqBai: Integer): TUniQuery;
Var
  strSQL   : String;
  qryCadRec: TUniQuery;
begin
  qryCadRec := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT * ';
  strSQL := strSQL + ' FROM CADREC ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI ';

  qryCadRec.Close;
  qryCadRec.SQL.Add(strSQL);
  qryCadRec.ParamByName('NUMDUP').AsString  := strNumDup;
  qryCadRec.ParamByName('PARCEL').AsString  := strParcel;
  qryCadRec.ParamByName('ESPDOC').AsString  := strEspDoc;
  qryCadRec.ParamByName('CODEMP').AsString  := strCodEmp;
  qryCadRec.ParamByName('CODCLI').AsString  := strCodCli;
  qryCadRec.ParamByName('SEQBAI').AsInteger := intSeqBai;

  Result := qryCadRec;
end;

procedure TfrmCadCheques.pCancelaTransferenciaContasReceber;
var
  strDupDep: String;
  strNumDup: String;
  strParDup: String;
  strEspDup: String;
  strEmpDup: String;
  strCliDup: String;
  qryContasReceber: TUniQuery;
  blnCommit: Boolean;
  blnTemDup: Boolean;
  blnMaiorFechamento: TDateTime;
begin

  blnTemDup := False;

  If Not fEmptyStr(cdsTabela.FieldByName('CHQ_DUPDEP').AsString) Then
  Begin
    strDupDep := cdsTabela.FieldByName('CHQ_DUPDEP').AsString;
    strNumDup := Copy(strDupDep,  1, 12);
    strParDup := Copy(strDupDep, 14,  1);
    strEspDup := Copy(strDupDep, 18,  2);
    strEmpDup := Copy(strDupDep, 21,  3);
    strCliDup := Copy(strDupDep, 25,  8);

    qryContasReceber := fQueryContasReceber(strNumDup,
                                            strParDup,
                                            strEspDup,
                                            strEmpDup,
                                            strCliDup, 0);
    qryContasReceber.Open;

    If Not qryContasReceber.IsEmpty Then
    Begin
      blnTemDup := True;

      If Not qryContasReceber.FieldByName('CTR_DTAREC').IsNull Then
      Begin
        fMensagem('', 'A duplicata (' + strNumDup +
                                        strParDup + '-' +
                                        strEspDup + '-' +
                                        strEmpDup +
                            ') já está baixada, e não poderá ter a transferência cancelada!', ['&Ok']);
        Exit;
      End;

      If Not qryContasReceber.FieldByName('CTR_DTABOL').IsNull Then
      Begin
        fMensagem('', 'A duplicata (' + strNumDup +
                                        strParDup + '-' +
                                        strEspDup + '-' +
                                        strEmpDup +
                            ') possui BOLETO EMITIDO, e não poderá ter a transferência cancelada!', ['&Ok']);
        Exit;
      End;

      If Not qryContasReceber.FieldByName('CTR_TX_PIX').IsNull Then
      Begin
        fMensagem('', 'A duplicata (' + strNumDup +
                                        strParDup + '-' +
                                        strEspDup + '-' +
                                        strEmpDup +
                            ') possui PIX VINCULADO, e não poderá ter a transferência cancelada!', ['&Ok']);
        Exit;
      End;

    End;

    If (fCfgSis('UTICON', varBoolean)) Then
    Begin
      {************ ALTERADO VALIDAÇÃO DE FECHAMENTO FINANCEIRO. *************}
      {* A VALIDAÇÃO SERÁ FEITA COM A DATA DE CADASTROS DO CONTAS A RECEBER. *}
      {* SOLICITADO NO REQUISITO: 342838 *************************************}
      If (objFechamento.FechamentoFinanceiroJaRealizado(cdsTabela.FieldByName('CHQ_CODEMP').AsString,
                                                        {cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime,}
                                                        qryContasReceber.FieldByName('CTR_DTACAD').AsDateTime,
                                                        False) = True) then
      Begin
        blnMaiorFechamento := objFechamento.EncontraMaiorFechamento(cdsTabela.FieldByName('CHQ_CODEMP').AsString);
        fMensagem('', 'A transferência não poderá ser cancelada, pois existe fechamento financeiro para a empresa.' + #13+#10 +
                      'Empresa: ' + cdsTabela.FieldByName('CHQ_CODEMP').AsString +  ' - ' + 'Último Fechamento: ' + FormatDateTime('DD/MM/YYYY', blnMaiorFechamento)
                    , ['&Ok']);
        Exit;
      End;
    End;

  End;

  If (fMensagem('AVISO', 'Deseja cancelar a transferência do cheque enviado para o Contas a Receber?',
                ['&Sim', '&Não'], 1, False, 2) = 2) Then
    Exit;

  Try
    fStartTransaction;

    blnCommit := True;

    If (blnTemDup) Then
    Begin
      Try
        blnCommit := fApagaDuplicataContasReceber(qryContasReceber, Self.Name);
      Finally
        qryContasReceber.Close;
        FreeAndNil(qryContasReceber);
      End;

      If (blnCommit) Then
      Begin
        blnCommit := fGravaMovBanTransferenciaContasReceber('C');
      End;

    End;

    If (blnCommit) Then
    Begin
      cdsTabela.Edit;
      cdsTabela.FieldByName('CHQ_INCCTR').AsString := 'N';
      cdsTabela.FieldByName('CHQ_DUPDEP').Clear;
      cdsTabela.Post;

      pGravaLogChq(cdsTabela, 'CANC. TRANSF. CHEQUE PARA CNT. REC. (frmCadCheques.pCancelaTransferenciaContasReceber)');

      fCommit;
      fMensagem('Informação', 'Cancelamento de Transferência de Cheque executado com sucesso!', ['&O k']);
    End
    Else
    Begin
      fRollBack;
      pMensagensErro('A operação não pode ser concluída!','[TfrmCadCheques.pCancelaTransferenciaContasReceber]');
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[TfrmCadCheques.pCancelaTransferenciaContasReceber]');
    End;
  End;

  pCarregaDadosAdicionais;
  pHabilitaBtnTransfCtr;

end;

procedure TfrmCadCheques.btnCancelTransfCtRClick(Sender: TObject);
var
  blnAcesso: Boolean;
begin

  blnAcesso := fVerificaAcessoSistema('CNTRCR', strCodOpe);

  If Not blnAcesso Then
  Begin
    blnAcesso := fChamaSenhaVariavel('Usuário sem acesso ao Cancelamento de Transferência de Cheques para o Contas a Receber.' + #13#10 +
                                     'DUPLICATA: ' +
                                      Copy(cdsTabela.FieldByName('CHQ_DUPDEP').AsString,  1, 12) + '-' +
                                      Copy(cdsTabela.FieldByName('CHQ_DUPDEP').AsString, 14,  1) +  #13#10 +
                                      'EMPRESA: ' +
                                      Copy(cdsTabela.FieldByName('CHQ_DUPDEP').AsString, 21,  3)
                                      ,
                                'CNTRCR',
                                '',
                                'Usuário sem acesso ao Cancelamento de Transferência de Cheques para o Contas a Receber. ' ,
                                strLoginUsuarioLogado,
                                dbeCodCli.Text + '-' + edtNomCli.Text);
    If blnAcesso then
      pGeraLogLiberacao('','','');
  End;

  If (blnAcesso) Then
    pCancelaTransferenciaContasReceber
  Else
    fMensagem('ATENÇÃO!', 'Usuário sem acesso para executar essa operação!', ['&O k']);
end;

procedure TfrmCadCheques.btnAlterarClick(Sender: TObject);
var
  blnExisteMovBanConciliada: Boolean;
  strMensagem: String;
begin
  inherited;
  strEmiAnt := '';
  strMensagem := '';
  If Not blnAlterou Then
    Exit;

  If Not fLock_Unlock('CADCHQ' + cdsTabela.FieldByName('AUTOINCREM').AsString, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + cdsTabela.FieldByName('AUTOINCREM').AsString), ['&Ok']);
    Exit;
  End;

  blnJaIncluiu := False;
  FillChar(recInclusao,SizeOf(recInclusao),#0);
  If blnGravacaoFisica Then
  Begin
    dbeCodBco.Enabled := False;
    dbeNumAge.Enabled := False;
    dbeConCor.Enabled := False;
    dbeNumChq.Enabled := False;
  End;
  strMsgErr := '';


  {*************************************************************}
  {  DESABILITA A POSSIBILIDADE DE ALTERAÇÃO DO VALOR DO CHEQUE }
  {  CASO HAJA DATA DE DEPOSITO OU DEVOLUÇÃO DO MESMO           }
  {**************************************************FA*********}

  blnExisteMovBanConciliada := fMovimentoBancario(True);

  dbeValChq.Enabled := (cdsTabela.FieldByName('CHQ_DTADEP').IsNull) and
                       (cdsTabela.FieldByName('CHQ_DTADEV').IsNull) and
                       (cdsTabela.FieldByName('CHQ_DTADP2').IsNull) and
                       (cdsTabela.FieldByName('CHQ_DTADV2').IsNull) and
                       (cdsTabela.FieldByName('CHQ_DTADP3').IsNull) and
                       (cdsTabela.FieldByName('CHQ_DTADV3').IsNull) and
                       (Not blnExisteMovBanConciliada);


  If blnExisteMovBanConciliada Then
  Begin
    dbePorChq.Enabled := False;
    fraPlanoDeContasMov.dbeCodCta.Enabled := False;
    dbeDtaCad.enabled := False;
    dbeDtaVen.enabled := False;
    dbeCodCli.Enabled := False;
    btnCorrigeCheque.Enabled := False;

    strMensagem := 'A movimentação bancária do cheque já está conciliada. Por essa razão é possível alterar somente os '  +
                   'dados do emitente e de depósito do cheque. ';

    pSetFocus(dbeCGCCpf);
  End
  Else
  Begin
    dbePorChq.Enabled        := (cdsTabela.FieldByName('AUTOINCREM').IsNull);
    btnAltPortador.Enabled   := (cdsTabela.State = dsEdit)     and
                                (not dbePorChq.Enabled)        and
                                (dbeDtaDep.Field.Value = Null) and
                                (dbeDtaDp2.Field.Value = Null) and
                                (blnChamadoDoManutencao);

    fraPlanoDeContasMov.dbeCodCta.Enabled :=  btnAltPortador.Enabled;
  End;

  {********************************************}
  {* USO ESSES CAMPOS PARA O LEITOR DE CHEQUE *}
  {*****************************************AC*}
  edtCheque.Visible := False;
  lblCheque.Visible := False;

  If blnResumida And fEmptyStr(strConPag) Then
  Begin
    fltValAlt := cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat;
  End;

  If cdsTabela.FieldByName('CHQ_RESCAI').AsString = '1' Then
    dbeDtaCad.Enabled := False;

  pgcDados.ActivePageIndex := 0;
  btnCorrigeCheque.Enabled := False;
  btnHistorico.Enabled     := False;
  btnHistReceb.Enabled     := False;
  btnImprimir.Enabled      := False;
  btnTransfereCtR.Enabled  := False;
  btnCancelTransfCtR.Enabled := False;

  If (dbeDtaDep.Field.IsNull) Then
  Begin
    dbeMotDev.Enabled := False;
    dbeDtaDev.Enabled := False;
    dbeDevDef.Enabled := False;
  End;

  If (dbeDtaDp2.Field.IsNull) Then
  Begin
    dbeMotDv2.Enabled := False;
    dbeDtaDv2.Enabled := False;
  End;
  
  If fEmptyStr(fTiraCaracEspeciais(dbeDtaDev.Text)) Then
  Begin
    dbeMotDev.Enabled := False;
  End;

  If fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text)) Then
  Begin
    dbeMotDv2.Enabled := False;
  End;

  If Not dbeDtaDev.Field.IsNull Then
  Begin
    dbeMotDev.Enabled := False;
    dbeDtaDev.Enabled := False;
    dbeDevDef.Enabled := False;
  End;

  If dbeCodCli.Enabled Then
    pSetFocus(dbeCodCli);

  strDigAnt    := LeftStr(edtDigChq.Text,3);
  strPorChqAnt := dbePorChq.Text;
  strCtaChqAnt := fraPlanoDeContasMov.dbeCodCta.Text;
  fltValLanAnt := fStrToFloat(dbeValChq.Text);

  If Not fCfgSis('CHQVAL', varBoolean) Then
    dbeValChq.Enabled := False;

  fltValChqAnt := fStrToFloat(dbeValChq.Text);
  dbeTelChe.Enabled := fVerificaAcessoSistema('TELECHE', strCodOpe);
  dbeTelNum.Enabled := dbeTelChe.Enabled And (dbeTelChe.Text = 'S');

  AtualizaNaoDep;

  grbCMC7.Enabled   := False;
  chkLeitor.Enabled := False;
  chkInfMan.Enabled := False;

  if ((cdsTabela.FieldByName('CHQ_DTADEP').Value <> Null) and (cdsTabela.FieldByName('CHQ_DTADEV').IsNull) or
      (cdsTabela.FieldByName('CHQ_DTADP2').Value <> Null) and (cdsTabela.FieldByName('CHQ_DTADV2').IsNull) or
      (dbeDevDef.Checked))  then
  begin
    strMensagem := 'O cheque já foi depositado. Por essa razão será possível alterar somente alguns campos. ';

    dbeCodCli.Enabled := False;
    dbeCgcCpf.Enabled := False;
    dbeNumCGC.Enabled := False;
    dbeNomEmi.Enabled := False;
    dbeEndere.Enabled := False;
    dbeTelEmi.Enabled := False;
    dbeDtaCad.Enabled := False;
    dbeDtaVen.Enabled := False;
  end
  else
  begin
    dbeCodCli.Enabled := True;
    dbeCgcCpf.Enabled := True;
    dbeNumCGC.Enabled := True;
    dbeNomEmi.Enabled := True;
    dbeEndere.Enabled := True;
    dbeTelEmi.Enabled := True;
    dbeDtaCad.Enabled := True;
    dbeDtaVen.Enabled := True;
  end;

  If Not fEmptyStr(strMensagem) Then
    fMensagem('Atenção',strMensagem,['&OK']);

  pHabilitaBotoes;

  If FRotina = 'LIBERAÇÃO TRANSFERÊNCIAS' Then
  Begin
    dbeValChq.Enabled := False;
    dbeDtaCad.Enabled := False;
    grbMovBan.Enabled := False;

    dbeDtaVen.Enabled := qryTabela.FieldByName('CHQ_DTACAD').AsString <>
                         qryTabela.FieldByName('CHQ_DTAVEN').AsString;
  End;
end;

procedure TfrmCadCheques.btnAltPortadorClick(Sender: TObject);
  Var
    frmDigPortador : TfrmDigPortador;
begin
  Inherited;

  If Not fPermiteAlterarVindoDoCaixa Then
  Begin
    fMensagem('Atenção','Não é permitido quando o cheque é proveniente do Resumo de Caixa e ainda não foi transferido.',['&OK']);
    Exit;
  End;

  pCriarFormularios(TfrmDigPortador, frmDigPortador);
  frmDigPortador.Caption           := 'Dados para Crédito no Movimento Bancário';
  frmDigPortador.edtPorBai.Text    := cdsTabela.FieldByName('CHQ_PORCHQ').AsString;
  frmDigPortador.bolMostraVendedor := False;
  frmDigPortador.pCarregaPortador;
  frmDigPortador.ShowModal;

  If frmDigPortador.blnConfirma Then
  Begin
    {*REQ*145940**********RP*}
    If Not fEmpresaTemAcessoPortador(frmDigPortador.strCodPor) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      Exit;
    End;

    cdsTabela.FieldByName('CHQ_PORCHQ').AsString := frmDigPortador.strCodPor;
    edtDesPorChq.Text := fRetNomPortador(dbePorChq.Text);
  End;

  If (cdsTabela.State = dsEdit) And (frmDigPortador.blnConfirma) Then
  Begin
    dbePorChq.Field.Value := frmDigPortador.strCodPor;
    edtDesPorChq.text     := fRetNomPortador(dbePorChq.Text);
  End;

  FreeAndNil(frmDigPortador);
  pSetFocus(btnGravar);
end;

procedure TfrmCadCheques.pCarregaCentroCusto;
begin
  if fraPlanoDeContasPla.dbeCodCta.Text <> '' then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContasPla.dbeCodCta.Text);
    fraPlanoDeContasPla.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
  end;

  if not fEmptyStr(fraPlanoDeContasMov.dbeCodCta.Text) then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContasMov.dbeCodCta.Text);
    fraPlanoDeContasMov.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
  end else
    fraPlanoDeContasMov.edtDesCta.Clear;
end;

procedure TfrmCadCheques.pCarregaChq;
begin
  if qryTabela.RecordCount = 0 then
    pLimparCampos;

  fAbrirTabelaCadastro('');

  blnJaIncluiu := False;
  FillChar(recInclusao,SizeOf(recInclusao),#0);
  pHabilitaBtnTransfCtr;
  pCarregaDadosAdicionais;

  strMotAnt := cdsTabela.FieldByName('CHQ_MOTDEV').AsString;
  strEmiAnt := cdsTabela.FieldByName('CHQ_C_G_C_').AsString;
  dtaDevAnt := cdsTabela.FieldByname('CHQ_DTADEV').AsDateTime;
  blnPrazo  := (cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime <> cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime);

  If (Not fEmptyStr(cdsTabela.FieldByName('CHQ_CODOPE').AsString)) Then
    edtDigChq.Text := cdsTabela.FieldByName('CHQ_CODOPE').AsString + '-' + fRetNomeOperador(cdsTabela.FieldByName('CHQ_CODOPE').AsString)
  Else
    edtDigChq.Clear;

  strDigAnt := cdsTabela.FieldByName('CHQ_CODOPE').AsString;

  If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    pSetFocus(btnAlterar);

  With recConsulta Do
  Begin
    strCliAnt := cdsTabela.FieldByName('CHQ_CODCLI').AsString;
    strCodCbo := cdsTabela.FieldByName('CHQ_CODBCO').AsString;
    strNumAge := cdsTabela.FieldByName('CHQ_NUMAGE').AsString;
    strConCor := cdsTabela.FieldByName('CHQ_CONCOR').AsString;
    strCodCli := cdsTabela.FieldByName('CHQ_CODCLI').AsString;
    strDtaVen := cdsTabela.FieldByName('CHQ_DTAVEN').AsString;
    strDtaCad := cdsTabela.FieldByName('CHQ_DTACAD').AsString;
    strHist01 := cdsTabela.FieldByName('CHQ_HIST01').AsString;
    strHist02 := cdsTabela.FieldByName('CHQ_HIST02').AsString;
    strCodEmp := cdsTabela.FieldByName('CHQ_CODEMP').AsString;
  End;

  ADataCadastroInicial := cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime;
  dbeCgcCpfExit(nil);
end;

procedure TfrmCadCheques.pCarregaCidade;
begin
  pPesquisaCadCid(qryConCid, qryConCid, dbeCodCid.Text);
  edtDesCid.Text := qryConCid.FieldByName('CID_NOMCID').AsString;
  edtEstado.Text := qryConCid.FieldByName('CID_ESTADO').AsString;
end;

procedure TfrmCadCheques.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, dbeCodPor.Text);
  edtNomPor.Text := qryConPor.FieldbyName('POR_NOMPOR').AsString;
end;

procedure TfrmCadCheques.pCarregaPortador2;
begin
  edtNomPo2.Clear;
  pPesquisaCadPor(Nil, qryConPor, dbeCodPo2.Text);
  edtNomPo2.Text := qryConPor.FieldbyName('POR_NOMPOR').AsString;
end;

function TfrmCadCheques.fCarregaPortadorEVendedorContaReceber : Boolean;
  Var
    frmDigPortador : TfrmDigPortador;
begin
  Result := True;

  try
    FPortadorContaAReceber := '';
    FVendedorContaAReceber := '';


    If (Not fEmptyStr(cdsTabela.FieldByName('CHQ_DOCUME').AsString)) And
       (Copy(cdsTabela.FieldByName('CHQ_DOCUME').AsString,1,6) <> 'DIVERS') Then
    Begin
      If (Pos('AG', cdsTabela.FieldByName('CHQ_DOCUME').AsString) > 0) And
         (Not CharInSet(cdsTabela.FieldByName('CHQ_DOCUME').AsString[13], ['A'..'Z'])) Then//Parcela com 1 digito
      Begin
        FVendedorContaAReceber := fRetVendedorDocume(Copy(cdsTabela.FieldByName('CHQ_DOCUME').AsString,1,12),
                                                     Copy(cdsTabela.FieldByName('CHQ_DOCUME').AsString,16,2),
                                                     Copy(cdsTabela.FieldByName('CHQ_DOCUME').AsString,18,3),
                                                          cdsTabela.FieldByName('CHQ_CODCLI').AsString);
      End
      Else
        FVendedorContaAReceber := fRetVendedorDocume(Copy(cdsTabela.FieldByName('CHQ_DOCUME').AsString,1,12),
                                                     Copy(cdsTabela.FieldByName('CHQ_DOCUME').AsString,14,2),
                                                     Copy(cdsTabela.FieldByName('CHQ_DOCUME').AsString,16,3),
                                                          cdsTabela.FieldByName('CHQ_CODCLI').AsString);
    End;

    Try
      pCriarFormularios(TfrmDigPortador, frmDigPortador);
      frmDigPortador.Caption        := 'Portador para gravação do Contas a Receber';
      frmDigPortador.blnTraVazio    := False;
      frmDigPortador.edtPorBai.Text := fRetornaPortadorCliente(dbeCodCli.Text);
      frmDigPortador.edtCodVen.Text := FVendedorContaAReceber;
      frmDigPortador.blnTraVazio    := fCfgSis('OBRPOR', varBoolean);
      frmDigPortador.pCarregaPortador;
      frmDigPortador.pCarregaVendedor;
      frmDigPortador.ShowModal;

      If frmDigPortador.blnConfirma Then
      Begin
        {*REQ*145940**********RP*}
        If Not fEmpresaTemAcessoPortador(frmDigPortador.strCodPor) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Exit(False);
        End;

        FPortadorContaAReceber := frmDigPortador.strCodPor;
        FVendedorContaAReceber := frmDigPortador.strCodVen;
      End
      Else
      Begin
        FreeAndNil(frmDigPortador);
        Exit(False);
      End;

    Except
      FreeAndNil(frmDigPortador);
      Exit(False);
    End;

  finally
    if Assigned(frmDigPortador) then
      FreeAndNil(frmDigPortador);
  end;
end;

procedure TfrmCadCheques.pCarregaTelecheque;
var
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  Q.CHQ_SEQTEL, ';
    strSQL := strSQL + '  Q.CHQ_PORORI, ';
    strSQL := strSQL + '  Q.CHQ_CODPOR, ';
    strSQL := strSQL + '  P.POR_NOMPOR, ';
    strSQL := strSQL + '  Q.CHQ_DTAENV, ';
    strSQL := strSQL + '  Q.CHQ_DOCUME, ';
    strSQL := strSQL + '  Q.CHQ_CODEMP, ';
    strSQL := strSQL + '  E.EMP_NOMEMP, ';
    strSQL := strSQL + '  Q.CHQ_CODOPE, ';
    strSQL := strSQL + '  O.OPE_NOMOPE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabTeleChq + ' Q ';
    strSQL := strSQL + '  INNER JOIN CADPOR P ON Q.CHQ_CODPOR = P.POR_CODPOR ';
    strSQL := strSQL + '  INNER JOIN CADEMP E ON Q.CHQ_CODEMP = E.EMP_CODEMP ';
    strSQL := strSQL + '  INNER JOIN CADOPE O ON Q.CHQ_CODOPE = O.OPE_CODOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  Q.CHQ_SEQCHQ = :CHQ_SEQCHQ ';

    qryConTel.Close;
    qryConTel.SQL.Text := strSQL;
    qryConTel.ParamByName('CHQ_SEQCHQ').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryConTel.Open;
    If (qryConTel.RecordCount > 0) Then
    Begin
      edtNomTel.Text := qryConTel.FieldByName('POR_NOMPOR').AsString;
      edtNomEmp.Text := qryConTel.FieldByName('EMP_NOMEMP').AsString;
      edtNomOpe.Text := qryConTel.FieldByName('OPE_NOMOPE').AsString;
    End
    Else
    Begin
      edtNomTel.Clear;
      edtNomEmp.Clear;
      edtNomOpe.Clear;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmCadCheques.pCarregaDadosAnteriores;
Begin
  strMotAnt := cdsTabela.FieldByName('CHQ_MOTDEV').AsString;
  dtaDevAnt := cdsTabela.FieldByname('CHQ_DTADEV').AsDateTime;
  strMt2Ant := cdsTabela.FieldByName('CHQ_MOTDV2').AsString;
  dtaDv2Ant := cdsTabela.FieldByname('CHQ_DTADV2').AsDateTime;
End;

procedure TfrmCadCheques.pCarregaDadosIniciaisCadastro;
begin
  if cdsTabela.State in [dsEdit, dsInsert] then
  begin
    if fltValLanLoc <> 0 then
      dbeValChq.DataSource.DataSet.FieldByName('CHQ_VALCHQ').Value := fltValLanLoc;

    if dteDataLanLoc <> 0 then
    begin
      dbeDtaCad.DataSource.DataSet.FieldByName('CHQ_DTACAD').Value := dteDataLanLoc;
      dbeDtaVen.DataSource.DataSet.FieldByName('CHQ_DTAVEN').Value := dteDataLanLoc;
    end;

    if strHist01Loc <> '' then
      dbeHist01.DataSource.DataSet.FieldByName('CHQ_HIST01').Value := strHist01Loc;
  end;
end;

procedure TfrmCadCheques.btnGravarClick(Sender: TObject);
  Var
    dtsUltSta : TDataSetState;
    blnRedepo : Boolean;
    objCheques: TChequeEmitido;
    blnGravar : Boolean;
    strCodFor : String;
    strCta_Pg : String;
    strCodEve : String;
    strCodBco,
    strNumAge,
    strConCor,
    strNumChq: String;
    frmBaixaCheques : TfrmBaixaCheques;
    dtaDtaPortador:TDate;
    frmDigPortador : TfrmDigPortador;
begin
  strCodFor := '';
  strCta_Pg := '';
  strCodEve := '';
  strMsgErr := '';
  strCodBco := '';
  strNumAge := '';
  strConCor := '';
  strNumChq := '';
  {*************************************}
  {* TRAVA PARA NÃO ALTERAR/EXCLUIR    *}
  {**********************************LE*}
  If (Not blnChamadoDoManutencao) And
     (FRotina <> 'LIBERAÇÃO TRANSFERÊNCIAS') Then
  Begin
    If Not (fCarregaChequesTransferidos(cdsTabela.FieldByName('CHQ_SEQCON').AsInteger,
                                        cdsTabela.FieldByName('CHQ_CODEMP').AsString,
                                        cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime).IsEmpty) And (fCfgSis('RCXTCC') = '2')Then
    Begin
      fMensagem('','Há cheques transferidos relativos a essa baixa!.' + #13 +
                   'Para alterar este cheque cancelar o sequencial: '+cdsTabela.FieldByName('CHQ_SEQTRF').AsString+'.'+#13
                 + 'RESUMO DE CAIXA > F1 - LANÇAMENTOS > TF - TRANSFERÊNCIA > [F8] CANCELAMENTO DE TRANSFERÊNCIAS.',['O K']);
      btnCancela.Click;
      Exit;
    End;
  End;

  //**************************************//
  // ATRIBUI A VARIÁVEL O ULTIMO STATE DA //
  // cdsTabela = DSInsert/DSEdit;         //
  //***********************************ED*//
  dtsUltSta := cdsTabela.State;

  If fEmptyStr(dbeCodPor.Field.AsString) Then
    dbeCodPor.Field.Clear;

  If dtsUltSta = dsInsert Then
    cdsTabela.FieldByName('CHQ_CODEMP').AsString := VS_strCodEmp;

  strNumCgcAtual := dbeNumCgc.Text;
  strCgcCpfAtual := dbeCgcCpf.Text;
  strNomEmiAtual := dbeNomEmi.Text;
  strEndereAtual := dbeEndere.Text;
  strTelEmiAtual := dbeTelEmi.Text;

  If fVerificaCampos Then
  Begin
    If FRotina = 'LIBERAÇÃO TRANSFERÊNCIAS' Then
    Begin
      If dbeDtaVen.Enabled Then
      Begin
        If dbeDtaVen.Field.Value <= dbeDtaCad.Field.Value Then
        Begin
          fMensagem('ATENÇÃO','A data de vencimento deve ser maior que a data de cadastro para cheque pré-datado.',['O K']);

          Exit;
        End;
      End;
    End;

    {****************************************************************
     PEDINDO O PORTADOR DA CONTRA PARTIDA DA DEVOLUÇÃO NESTE PONTO
     PARA EVITAR MENSAGENS DA TELA frmDigPortador DENTRO DA TRANSAÇÃO
     QUE SERÁ INICIADA NO BLOCO ABAIXO
    {**************************************************************GD}
    If  ((Not fEmptyStr(cdsTabela.FieldByName('CHQ_PORDEB').AsString)) and
       (((Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDev.Text))) And (dbeDtaDev.Field.AsDateTime <> dtaDevAnt)) Or
        ((Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text))) And (dbeDtaDv2.Field.AsDateTime <> dtaDv2Ant)))) And

    Not ((fCfgSis('CHQCTR',varBoolean)) And                                                                               {**********************************************}
        (((Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text))) And (dbeDtaDv2.Field.AsDateTime <> dtaDv2Ant)) OR          {* NÃO GRAVA A CONTRA PARTIDA SE FOR          *}
        ((cdsTabela.FieldByName('CHQ_DEVDEF').AsString = '1') And (cdsTabela.FieldByName('CHQ_DTAREP').IsNull)))) Then    {* SEGUNDA DEVOLUÇÃO OU DEVOLUÇÃO DEFINTIVA   *}
    Begin                                                                                                                 {* E ESTIVER CONFIGURADO PARA GRAVAR NO CADREC*}
      FPortadorContraPartidaNaDevolucao := cdsTabela.FieldByName('CHQ_PORDEB').AsString;                                  {*REQ. 36170 05/06/2015*********************JU*}
      Try
        pCriarFormularios(TfrmDigPortador, frmDigPortador);
        if dbeDtaDv2.Field.Value > dbeDtaDev.Field.Value then
          dtaDtaPortador := dbeDtaDv2.Field.Value
        else
          dtaDtaPortador := dbeDtaDev.Field.Value;
        frmDigPortador.setDataPortador(dtaDtaPortador);
        frmDigPortador.Caption := 'Portador para Contra Partida Movimento Bancário';
        frmDigPortador.edtPorBai.Text := cdsTabela.FieldByName('CHQ_PORDEB').AsString;
        frmDigPortador.bolMostraVendedor := False;
        frmDigPortador.pCarregaPortador;
        frmDigPortador.ShowModal;

        If frmDigPortador.blnConfirma Then
        Begin
          {*REQ*145940**********RP*}
          If Not fEmpresaTemAcessoPortador(frmDigPortador.strCodPor) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Exit;
          End;

          FPortadorContraPartidaNaDevolucao := frmDigPortador.strCodPor;
        End
        Else
        Begin
          FreeAndNil(frmDigPortador);
          btnCancela.Click;
          Exit;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message,'');
      End;
      if Assigned(frmDigPortador) then
        FreeAndNil(frmDigPortador);
    End;

    blnGravar := True;

    // TRATANDO ANTES DE GRAVAR SE O CHEQUE É ORIUNDO DE REPASSE OU NÃO PARA PODER
    // REALIZAR O MOVBAN ADEQUADAMENTE POIS O ATALHO ALT+G E TAMBÉM A NÃO LIMPEZA DA VARIAVEL
    // PODEM PREJUDICAR A GRAVAÇÃO.
    // REQ 67840
    blnRepasse := (Not dbeForRep.Field.IsNull) And (Not fEmptyStr(dbeForRep.Field.Value));

    If (blnGravar) Then
    Begin
      If (dbeDevDef.Checked) Then
      Begin
        {************************************************************}
        { CASO SEJA DEVOLUÇÃO DEFINITIVA, ATRIBUI DATA E MOTIVO DE   }
        { DEVOLUÇÃO 2 SOMENTE SE OS VALORES NÃO ESTIVEREM PREENCHIDOS}
        {********************************************************FA**}

        if cdsTabela.FieldByName('CHQ_MOTDV2').IsNull then
          cdsTabela.FieldByName('CHQ_MOTDV2').AsString   := cdsTabela.FieldByName('CHQ_MOTDEV').AsString;
        if cdsTabela.FieldByName('CHQ_DTADV2').isNull then
          cdsTabela.FieldByName('CHQ_DTADV2').AsDateTime := cdsTabela.FieldByName('CHQ_DTADEV').AsDateTime;
      End
      else
      begin
        dbeDevDef.Checked     := (not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) and (not cdsTabela.FieldByName('CHQ_DTADV2').IsNull);
        If Assigned(dbeDevDef.Field) Then
          dbeDevDef.Field.Value := dbeDevDef.ValueChecked;
        if Assigned(frmCadCheques) then
        begin
          dbeDevDef.Checked := (not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) and (not cdsTabela.FieldByName('CHQ_DTADV2').IsNull);
          if cdsTabela.state in [dsEdit,dsInsert] then
            cdsTabela.FieldByName('CHQ_DEVDEF').Value := IIF(dbeDevDef.Checked,1,0);
        end;
      end;

      If (dbeDevDef.Checked) And (Not dbeForRep.Field.IsNull) Then
      Begin
        strCodFor := dbeForRep.Field.AsString;
        blnGravar := fDigDadosPagamento(strCodFor, strCta_Pg, strCodEve);
      End;

      {****************************************************************
       PEDINDO O PORTADOR E VENDEDOR DA CONTA A RECEBER NESTE PONTO
       PARA EVITAR MENSAGENS DA TELA frmDigPortador DENTRO DA TRANSAÇÃO
       QUE SERÁ INICIADA NO BLOCO ABAIXO
      {**************************************************************GD}
      If fCfgSis('CHQCTR',varBoolean) And (Not dbeDtaDv2.Field.IsNull) Then
        if not fCarregaPortadorEVendedorContaReceber then
        begin
          btnCancela.Click;
          Exit;
        end;

      If (blnGravar) Then
      begin
        blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
        strNumDup := '';

        inherited;
        pHabilitaBotoes;
        If (blnGravou) Then
        Begin

          If Not (blnGravacaoFisica) And
             Not (blnResCai) And Not (blnCtaRec) Then
          Begin
            If Assigned(dicCheques) Then
            Begin
              objCheques.strCodBco := dbeCodBco.Text;
              objCheques.strNumAge := dbeNumAge.Text;
              objCheques.strConCor := dbeConCor.Text;
              objCheques.strNumchq := dbeNumChq.Text;
              objCheques.strDtaEmi := dbeDtaCad.Text;
              objCheques.strDtaBom := dbeDtaVen.Text;
              objCheques.fltValChq := fStrToFloat(dbeValChq.Text);

              dicCheques.AddOrSetValue(dbeCodBco.Text+dbeNumAge.Text +
                                       dbeConCor.Text+dbeNumChq.Text,
                                       objCheques);
            End;
          End;

          blnJaIncluiu := dtsUltSta = dsInsert;

          With recInclusao Do
          Begin
            strCodCbo := cdsTabela.FieldByName('CHQ_CODBCO').AsString;
            strNumAge := cdsTabela.FieldByName('CHQ_NUMAGE').AsString;
            strConCor := cdsTabela.FieldByName('CHQ_CONCOR').AsString;
            strCodCli := cdsTabela.FieldByName('CHQ_CODCLI').AsString;
            strDtaVen := cdsTabela.FieldByName('CHQ_DTAVEN').AsString;
            strDtaCad := cdsTabela.FieldByName('CHQ_DTACAD').AsString;
            strHist01 := cdsTabela.FieldByName('CHQ_HIST01').AsString;
            strHist02 := cdsTabela.FieldByName('CHQ_HIST02').AsString;
            strCodEmp := cdsTabela.FieldByName('CHQ_CODEMP').AsString;
          End;

          Try
            strEmiAnt := '';

            //*********************************//
            // GRAVA DEBITO NO MOVBAN SENDO    //
            // QUE O CHEQUE FOI DEVOLVIDO      //
            //******************************PB*//
            If fGravaDebitoMovBan And
            {********************************************}
            {* GRAVA O HISTÓRICO DE DEVOLUÇÃO CASO SEJA *}
            {* NECESSÁRIO                               *}
            {*****************************************MV*}
               fGravaHistoricoDevolucao And
               fGravaCadPagFornecedor(strCodFor, strCta_Pg, strCodEve) Then
            Begin
              pHabilitaBtnTransfCtr;
              blnGravou := False;
              pgcDados.ActivePageIndex := 0;
              btnCorrigeCheque.Enabled := True;
              btnHistorico.Enabled     := True;
              btnHistReceb.Enabled     := False;

              {************************************}
              {* SE O VALOR FOR ALTERADO PEGA E   *}
              {* SUBTRAI O VALOR ATERIOR PARA     *}
              {* ADICIONAR O NOVO                 *}
              {*********************************AF*}
              If fltValAlt > 0 Then
              Begin
                fltValAtu := fltValAtu - fltValAlt;
                fltValAlt := 0;
              End;

              If blnResumida Then
              Begin
                fltValAtu := fltValAtu + cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat
              End;
              If blnResumida And (Not fEmptyStr(strConPag)) And (fFormataFloat(fltValTot, 2) <= fFormataFloat(fltValAtu, 2)) Then
              Begin

                If cdsTabela.RecordCount < StrToInt(LeftStr(strConPag,2)) Then
                Begin
                  fRollBack;
                  pMensagemOk('O valor total não deve ser atingido sem a digitação de todos os cheques!');
                  fltValAtu := fltValAtu - cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat;
                  btnAlterar.Click;
                  pSetFocus(dbeValChq);
                  Exit;
                End;

              End;

              fGravaCadEmi(dbeNumCgc.Text,
                           VS_strCodEmp,
                           dbeCgcCpf.Text,
                           dbeNomEmi.Text,
                           dbeEndere.Text,
                           '',
                           '',
                           '',
                           '',
                           '',
                           dbeTelEmi.Text);

              pDesabilitaChequesDevolvidos;

              If Not fEmptyStr(strNumDup) Then
              Begin
                cdsTabela.Edit;
                cdsTabela.FieldByName('CHQ_DUPDEV').AsString := strNumDup + '-CH-A-' + cdsTabela.FieldByName('CHQ_CODEMP').AsString + '-' +
                                                                cdsTabela.FieldByName('CHQ_CODCLI').AsString;
                cdsTabela.Post;
              End;

              If Not fEmptyStr(strChaveCadPag) Then
              Begin
                cdsTabela.Edit;
                cdsTabela.FieldByName('CHQ_DUPCTP').AsString := strChaveCadPag;
                cdsTabela.Post;
                strChaveCadPag := '';
              End;

              If (cdsTabela.FieldByName('CHQ_FORREP').AsString = '') Then
              Begin
                cdsTabela.Edit;
                cdsTabela.FieldByName('CHQ_FORREP').Value := Null;
                cdsTabela.Post;
              End;

              If (dbeDevDef.Checked) Or (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text))) Then
              Begin
                If fCfgSis('CHQCTR') = 'S' Then
                Begin
                  cdsTabela.Edit;
                  cdsTabela.FieldByName('CHQ_INCCTR').AsString   := 'S';
                  cdsTabela.Post;
                End;
              End;

              If fAbertoPeloContasAReceber Then
              Begin
                cdsTabela.Edit;
                cdsTabela.FieldByName('CHQ_PORCHQ').AsString := IIF(blnPrazo,fCfgSis('PORCHP'),fCfgSis('PORCHV'));
                cdsTabela.Post;
              End;

              strCodBco := cdsTabela.FieldByName('CHQ_CODBCO').AsString;
              strNumAge := cdsTabela.FieldByName('CHQ_NUMAGE').AsString;
              strConCor := cdsTabela.FieldByName('CHQ_CONCOR').AsString;
              strNumChq := cdsTabela.FieldByName('CHQ_NUMCHQ').AsString;

              pCarregaDadosAnteriores;

              lblDupDev.Visible := (Not cdsTabela.FieldByName('CHQ_DTADV2').IsNull);
              dbeDupDev.Visible := lblDupDev.Visible;

              If blnChamadoDoManutencao Then
              Begin
                If blnJaIncluiu Then
                Begin
                  If Not fGravaMovimentoBancario('C') Then
                  Begin
                    fRollBack;
                    fMensagem('ATENÇÃO','Não gravou movimento bancário. Operação será cancelada!',['&OK']);
                    pLimpaDtaDev;
                    Exit;
                  End;
                End
                Else
                If fMovimentoBancario Then
                  pAtualizaChequeMovBan;
              End;

            End
            Else
            Begin
              fRollBack;
              pMensagemOk(strMsgErr);
              pLimpaDtaDev;
              Exit;
            End;

          Except
            On E: Exception Do
            Begin
              fRollBack;
              pLimpaDtaDev;
              pMensagensErro(E.Message, '[Gravação do Cheque]');
            End;
          End;

          fCommit;

          If Not blnResumida Then
          Begin
            pGravaLogChq(cdsTabela, IIF(dtsUltSta = DSInsert, 'INSERINDO', 'ALTERANDO') + '(frmCadCheques.btnGravarClick)');
          End;
          blnRedepo :=  (Not blnDevolvido) And
                        (Not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) And
                        cdsTabela.FieldByName('CHQ_DTADV2').IsNull And
                        cdsTabela.FieldByName('CHQ_DTADP2').IsNull And
                        fPergunta('Deseja redepositar o cheque?');


          If blnRedepo Then
          Begin
            fLock_Unlock('CADCHQ' + cdsTabela.FieldByName('AUTOINCREM').AsString, False);
            pCriarFormularios(TfrmBaixaCheques, frmBaixaCheques);

            frmBaixaCheques.edtCodEmp.Text := VS_strCodEmp;
            frmBaixaCheques.edtNomEmp.Text := fRetNomeEmpresa;
            frmBaixaCheques.mskDtaIni.Text := DateToStr(cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime);
            frmBaixaCheques.mskDtaFin.Text := DateToStr(cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime);

            if strCodPorLoc <> '' then
            begin
              SetLength(arrSeqLanLoc, 0);
              frmBaixaCheques.dteDtaRecFix   := dteDataLanLoc;
              frmBaixaCheques.strCodPorFix   := strCodPorLoc;
              frmBaixaCheques.fltValorBaixa  := fltValLanLoc;
            end;

            frmBaixaCheques.ShowModal;

            arrSeqLanLoc := frmBaixaCheques.arrSeqLan;

            FreeAndNil(frmBaixaCheques);

///            cdsTabela.RefreshRecord;
            cdsTabela.Refresh;

            pMostraDespositoAntetior;
            pCarregaDadosAdicionais;
            pHabilitaBtnTransfCtr;

            if Length(arrSeqLanLoc) > 0 then
            begin
              btnSair.Click;
              Exit;
            end;
          End;

          If (btnImprimir.Visible) And (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDV2.Text))) Then
            pImprimeComprovante;

          If (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDV2.Text))) Then
            btnImprimir.Enabled := True;
        End
        Else
        Begin
          fRollBack;
          fLock_Unlock('CADCHQ' + cdsTabela.FieldByName('AUTOINCREM').AsString, False);
          pLimpaDtaDev;
          Exit;
        End
      end
      Else
        fRollBack;

    End;

    //********************************************//
    // SE O ÚLTIMO STATE DA TABELA FOI DSInsert   //
    // ENTÃO QUANDO GRAVAR CHAMA A TELA DO LEITOR //
    // DE CHEQUES                                 //
    //*****************************************ED*//
    If (dtsUltSta = DSInsert) And blnDigLei And (chkLeitor.Checked Or chkInfMan.Checked) Then
    Begin
      {********************************************}
      {* USO ESSES CAMPOS PARA O LEITOR DE CHEQUE *}
      {*****************************************AC*}
      edtCheque.Clear;
      edtCheque.Enabled := True;
    End
    Else
    Begin
      chkLeitor.Checked := False;
      chkInfMan.Checked := False;
      edtCheque.Clear;
    End;

    If fFormataFloat(fltValTot, 2) > fFormataFloat(fltValAtu, 2) Then
    Begin
      edtTotDig.Text := FormatFloat('#.#,0',fltValAtu);
      edtTotGer.Text := FormatFloat('#.#,0',fltValTot);
      btnIncluir.Click;
    End
    Else
    Begin
      If blnResumida Then
      Begin

        If Not fEmptyStr(strConPag) Then
        Begin

          If (cdsTabela.RecordCount = StrToInt(LeftStr(strConPag,2))) Or
             ((fStrToFloat(edtTotDig.Text) + cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat) = fStrToFloat(edtTotGer.Text)) Then
            btnSair.Click;

        End
        Else
          btnSair.Click;

      End;
    End;
  End;

  btnAltPortador.Enabled := False;
  blnDevolvido := fExisteDevolucao(dbeCodBco.Text,dbeNumAge.Text,dbeConCor.Text,dbeNumChq.Text);
  pAtualizaQtdCheques;
  fLock_Unlock('CADCHQ' + cdsTabela.FieldByName('AUTOINCREM').AsString, False);
  If ((dbeCgcCpf.Text = '1') Or (dbeCgcCpf.Text = '2')) Then
    dbeCgcCpf.Enabled := False
  Else
    dbeCgcCpf.Enabled := True;

  HabilitaAlteracaoLiberacaoCaixas;
end;

procedure TfrmCadCheques.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;

  If fPesqCidade(Self, dbeCodCid, edtDesCid, Nil, Nil, Key, arrCidade) Then
  Begin
    if fValidaCampos(dbeCodCid, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaCidade;
  End;

end;

function TfrmCadCheques.dbeCodCliChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCli(Key);
end;

procedure TfrmCadCheques.dbcNaoDepExit(Sender: TObject);
begin
  inherited;
  if dbcNaoDep.Checked then
  begin
    If not(fVerificaAcessoSistema('PERDEPCHQ', strCodOpe)) then
      If (Not fChamaSenhaVariavel(FRotinaChamada + #13 + #13 +
                                          ' Permitir marcar a opção "Não depositar" no recebimento de cheques.',
                                          'PERDEPCHQ',
                                          '',
                                          '',
                                          strCodOpe,
                                          '')) Then
      begin
        dbcNaoDep.Checked  := False;
        cdsTabela.FieldByName('CHQ_NAODEP').AsString   := 'N';
      end;
  end;
end;

procedure TfrmCadCheques.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;

  If dbeCgcCpf.Text = '1' Then
    TStringField(cdsTabela.FieldByName('CHQ_C_G_C_')).EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
  If dbeCgcCpf.Text = '2' Then
    TStringField(cdsTabela.FieldByName('CHQ_C_G_C_')).EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_)
  Else
    TStringField(cdsTabela.FieldByName('CHQ_C_G_C_')).EditMask := '';

  pAtualizaPortadorEConta;
end;

function TfrmCadCheques.dbeCodBcoChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadBco(Key);
end;

procedure TfrmCadCheques.dbeCodBcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, dbeCodBco, edtNomBan, Nil, Key, arrBancos) Then
  Begin
    if fValidaCampos(dbeCodBco, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;
end;

procedure TfrmCadCheques.dbeCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If dbeCodCli.ReadOnly Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCheques.btnPesquisaClick(Sender: TObject);
  Var
    intOpcao: Integer;
    arrSel  : TConsultasArray;
    chrKey  : Char;
begin
  btnImprimir.Enabled := False;
  strEmiAnt := '';
  dbeCgcCpf.Enabled   := False;

  intOpcao := fMensagem('','OPÇÃO',['TODOS','DEPOSITADOS','EM ABERTO']);

  Try

    chrKey := '/';
    If fPesqCheques(Self, qryTabela, chrKey, arrSel, strNomeTabela, intOpcao) Then
     pCarregaChq;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadCheques.btnPesquisaClick]');
    End;
  End;

  {********************************************}
  {* USO ESSES CAMPOS PARA O LEITOR DE CHEQUE *}
  {*****************************************AC*}
  If cdsTabela.IsEmpty Then
  Begin
    chkLeitor.Checked := False;
    chkInfMan.Checked := False;
    lblCheque.Visible := False;
    edtCheque.Visible := False;
    edtCheque.Clear;
  End
  Else If edtCheque.Visible Then
    pSetFocus(edtCheque);

  blnDevolvido := fExisteDevolucao(dbeCodBco.Text,dbeNumAge.Text,dbeConCor.Text,dbeNumChq.Text);
  If (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDV2.Text))) Then btnImprimir.Enabled := True;

  pHabilitaBotoes;

  fraPlanoDeContasMov.dbeCodCta.Field.EditMask := '99.99.999;0;_';
  fraPlanoDeContasPla.dbeCodCta.Field.EditMask := '99.99.999;0;_';

  DesabilitaAlteracaoLiberacaoCaixas;
end;

procedure TfrmCadCheques.btnSairClick(Sender: TObject);
begin
  If (Not blnGravacaoFisica) And (cdsTabela.State in [dsInsert, dsEdit]) Then
  Begin
    If fMensagem('AVISO', 'Deseja Sair da Inclusão dos Cheques?', ['&Sim', '&Não']) = 1 Then
    Begin
      btnCancela.Click;
    End
    Else
    Begin
      Exit;
    End;
  End;
  inherited;
end;

procedure TfrmCadCheques.btnTransfereCtRClick(Sender: TObject);
begin
  inherited;

  If (cdsTabela.IsEmpty) Then
  Begin
    fMensagem('', 'Não é possível realizar essa operação em um arquivo vazio!', ['&O k']);
    Exit;
  End;

  If (Not dbeDtaDep.Field.IsNull) Then
  Begin
    If Not ((Not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) And
            (cdsTabela.FieldByName('CHQ_DTADP2').IsNull) And
            (cdsTabela.FieldByName('CHQ_DTADV2').IsNull)) Then
      Exit;
  End;

  If not fVerificaAcessoSistema('TRFCTR', strCodOpe) then
  begin
    fMensagem('ATENÇÃO!','Operador sem acesso para transferir cheque para o Contas a Receber. ' +
              #13#10 + 'Por favor verifique os direitos de acesso AUTCOM do operador.', ['&O K']);
    Exit;
  end;

  If (fMensagem('AVISO', 'Este cheque será transferido para o Contas a Receber,' +
                #13#10 + 'mantendo seu valor em aberto no C\C do cliente.  Este' +
                #13#10 + 'procedimento deve ser utilizado quando o mesmo deseja' +
                #13#10 + 'trocar o cheque por outra forma de pagamento.        ' +
                #13#10 + 'Deseja confirmar a operação?', ['&Sim', '&Não'], 1, False, 2) = 2) Then
    Exit;

  If Not fTransfereChqReceber Then
  Begin
    fMensagem('', 'Não foi possível realizar essa transferência!', ['&O k']);
  End;

  pCarregaDadosAdicionais;
  pHabilitaBtnTransfCtr;

end;

procedure TfrmCadCheques.FormShow(Sender: TObject);
  function fCalcValAtual: Double;
  begin
    Result := 0.00;

    With cdsChqRcx Do
      If Assigned(cdsChqRcx) And (Not IsEmpty) Then
        Result := TAggregateField(FieldByName('TOT_VALCHQ')).Value;

    Result := fFormataFloat(Result, 2);
  end;

begin

  dbeCgcCpf.Enabled := False;
  blnRepasse := False;
  strChqSvd := fCfgSis('CHQSVD');

  cdsTabela.AfterOpen := pAfterOpenCds;

  strCodPorCredMovBan  := '';
  strCodPlanCredMovBan := '';

  If blnResumida Then
  Begin

    strNomeTabela := 'TMP_CHEQUES';

    dbeDevDef.DataField := '';
    dbeDevDef.DataSource := Nil;
   {**********************************************************************************************}
   {*ALTERADO 22/01/2015 - TROCA DA VARIAVEL blnRescai POR blnResumida PARA AS MUDANÇAS DO CADCHQ*}
   {*******************************************************************************************BB*}
   {*SE QUE CHAMOU A TELA FOR O RESUMO *}//{* SE TELA FOR CHAMADA PELO RESUMO DE CAIXA E OU PELO *}
   {*DE CAIXA ENTÃO FAZ AS SEGUINTES   *}//{* CONTAS A RECER, ENTÃO FAZ AS MUDANÇAS. #ALTERAÇÃO# *}
   {*MUDANÇAS                          *}//{* blnRescai SOMENTE TRUE QNDO VIR DO RESUMO DE CAIXA *}
   {*********************************AF*}//{* RQ. 24730 ***************************************BB*}
   {*******************************************************************************************BB*}

    blnVerificaProcod        := False;
    blnUsaAutInc             := False;
    btnCorrigeCheque.Enabled := False;
    btnHistorico.Enabled     := False;
    btnHistReceb.Enabled     := False;
    pnlAcoes.Visible         := False;

    Self.Height              := Self.Height - pnlAcoes.Height - 115;
    Panel3.Visible           := False;
    pnlTotais.Visible        := True;
    lblNumNot.Visible        := False;
    dbeNumNot.Visible        := False;
    btnGravar.Left           := btnIncluir.Left;
    btnIncluir.Visible       := False;
    btnCancela.Visible       := False;
    btnPesquisa.Visible      := False;
    btnImprimir.Visible      := False;

    cdsTabela.ProviderName   := '';
    cdsTabela.Data           := cdsChqRcx.Data;
    cdsTabela.Open;

    strArqChqDev    := 'CHQDEV';
    strTabCheque    := 'CADCHQ';
    strTabTeleChq   := 'CHQTEL';

    fltValAtu := fCalcValAtual;

  End
  Else
  Begin
    dbeDevDef.DataSource := dtsTabela;
    dbeDevDef.DataField  := 'CHQ_DEVDEF';

    strNomeTabela   := 'CADCHQ';
    strTabCheque    := 'CADCHQ';
    strArqChqDev    := 'CHQDEV';
    strTabTeleChq   := 'CHQTEL';
    qryTabela       := fCriarQuery('SELECT * FROM CADCHQ WHERE FALSE', Self);
  End;

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeCodBco;
  arrCamposChave[1] := dbeNumAge;
  arrCamposChave[2] := dbeConCor;
  arrCamposChave[3] := dbeNumChq;

  intPaginasAtivas         := 1;
  pgcDados.ActivePageIndex := 0;

  btnTransfereCtR.Enabled  := False;
  btnCancelTransfCtR.Enabled := False;
  
  inherited;

  cdsTabela.AfterScroll := pAfterScroll;
    
  pCarregaDadosAdicionais;
  pHabilitaBtnTransfCtr;

  grbMovBan.Visible := blnChamadoDoManutencao;

  blnDigLei := False;

  If blnResumida Then
  Begin
    pgcDados.Pages[1].TabVisible := False;
    pgcDados.Pages[2].TabVisible := False;
    pgcDados.Pages[3].TabVisible := False;
    btnIncluir.Click;
  End;

  btnImprimir.Enabled := False;

  pAtualizaQtdCheques;

  {************************************************************}
  {* QUANDO NÃO É GRAVAÇÃO FÍSICA, PERMITE ALTERAR OU EXCLUIR *}
  {* UM CHEQUE OU CONTINUAR A INCLUSÃO DOS MESMOS             *}
  {********************************13/03/2018**Req. 98936**WS**}
{
  If blnResumida Then
  Begin
    btnAlterar.Visible      := False;
    btnExcluir.Visible      := False;
  End;
}

  FValorConfiguracaoDigitos := fCfgSis('CHQDIG', varInteger);

  if not femptyStr(strAutIncCadChq) then
  begin
    qryTabela.Close;
    qryTabela.SQL.Text := 'SELECT * FROM CADCHQ WHERE AUTOINCREM = ' + strAutIncCadChq.QuotedString;
    qryTabela.Open;
    pCarregaChq;
  end
  else if blnIniciaCadastro then
  begin
    btnIncluir.Click;
    pCarregaDadosIniciaisCadastro;
  end;
end;

procedure TfrmCadCheques.pAtualizaPortadorEConta;
begin
  If (strCodPorCredMovBan <> '') And (cdsTabela.State = dsInsert) Then
  Begin
    dbePorChq.Field.Value := strCodPorCredMovBan;
    fraPlanoDeContasMov.dbeCodCta.Field.Value := strCodPlanCredMovBan;

    edtDesPorChq.Text     := fRetNomPortador(dbePorChq.Text);
    pCarregaCentroCusto;
  End;
end;

procedure TfrmCadCheques.pAtualizaQtdCheques;
  Var
    intQtdChe: Integer;
Begin

  If Not fEmptyStr(strConPag) Then
  Begin
    lblInfo.Visible := True;
    intQtdChe       := StrToInt(LeftStr(strConPag,2)) - cdsTabela.RecordCount;

    If intQtdChe <= 0 Then
      lblInfo.Caption := ''
    Else
      lblInfo.Caption := IntToStr(intQtdChe) + ' cheques a serem digitados!';
  End;

  If blnResumida And (cdsTabela.State = dsEdit) Then
  Begin
    If Not fEmptyStr(lblInfo.Caption) Then
      lblInfo.Caption := lblInfo.Caption + #13#10;

    lblInfo.Caption := lblInfo.Caption + 'Alteração de cheque já digitado...';
    lblInfo.Visible := True;
  End;

End;

procedure TfrmCadCheques.btnCorrigeChequeClick(Sender: TObject);
  Var
    strCodBco: String;
    strNumAge: String;
    strConCor: String;
    strNumChq: String;
    strCodEmp: String;
    blnConfirma: Boolean;
    frmCorrigeCheque : TfrmCorrigeCheque;
begin
  inherited;

  blnConfirma := False;
  
  If cdsTabela.IsEmpty Then
  Begin
    fMensagem('', 'Não é possível realizar essa operação em um arquivo vazio!', ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCorrigeCheque, frmCorrigeCheque);
    frmCorrigeCheque.edtCodEmp.Enabled := FRotina <> 'LIBERAÇÃO TRANSFERÊNCIAS';
    frmCorrigeCheque.showModal;

    strCodBco   := frmCorrigeCheque.strCodBco;
    strNumAge   := frmCorrigeCheque.strNumAge;
    strConCor   := frmCorrigeCheque.strConCor;
    strNumChq   := frmCorrigeCheque.strNumChq;
    strCodEmp   := frmCorrigeCheque.strCodEmp;
    blnConfirma := frmCorrigeCheque.blnConfirma;

  Except
    On E: Exception Do
    Begin
      blnConfima := False;
      pMensagensErro(E.Message, '[frmCadCheques.btnCorrigeChequeClick]');
    End;
  End;

  pFreeAndNil(frmCorrigeCheque);

  pSetFocus(Self);

  {*****************************************}
  {* CASO O USUARIO CANCELOU, NÃO FAZ NADA *}
  {**************************************MV*}
  If Not blnConfirma Then
    Exit;

  {*****************************************}
  {* CASO NÃO DIGITOU NADA, NÃO FAZ NADA   *}
  {**************************************MV*}
  If (fEmptyStr(strCodBco)) And
     (fEmptyStr(strNumAge)) And
     (fEmptyStr(strConCor)) And
     (fEmptyStr(strNumChq)) And
     (fEmptyStr(strCodEmp)) Then
  Begin
    Exit;
  End;

  {*****************************************}
  {* ALTERA OS CAMPOS NECESSÁRIOS          *}
  {**************************************MV*}
  If Not fExisteCheque(strCodBco, strNumAge, strConCor, strNumChq) Then
  Begin
    cdsTabela.Edit;

    If Not fEmptyStr(strCodBco) Then
      cdsTabela.FieldByName('CHQ_CODBCO').AsString := strCodBco;

    If Not fEmptyStr(strNumAge) Then
      cdsTabela.FieldByName('CHQ_NUMAGE').AsString := strNumAge;

    If Not fEmptyStr(strConCor) Then
      cdsTabela.FieldByName('CHQ_CONCOR').AsString := strConCor;

    If Not fEmptyStr(strNumChq) Then
      cdsTabela.FieldByName('CHQ_NUMCHQ').AsString := strNumChq;

    cdsTabela.Post;
    pCarregaBanco;

  End
  Else
    fMensagem('', 'Já existe um registro com esses dados!', ['&O k']);
end;

procedure TfrmCadCheques.btnDepositoChequeClick(Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmBaixaCheques);
  pRecarregaChequeAberto;
  pHabilitaBotoes;
end;

procedure TfrmCadCheques.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F4 Then
  Begin
    If btnAltPortador.Enabled Then
      btnAltPortador.Click;
  End
  Else If Key = VK_F5 Then
  Begin
    If btnCancelTransfCtR.Enabled Then
      btnCancelTransfCtR.Click;
  End
  Else If Key = VK_F6 Then
  Begin
    If btnTransfereCtR.Enabled Then
      btnTransfereCtR.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    If btnHistReceb.Enabled Then
      btnHistReceb.Click;
  End
  Else If Key = VK_F8 Then
  Begin
    If btnCorrigeCheque.Enabled Then
      btnCorrigeCheque.Click;
  End
  Else If Key = VK_F9 Then
  Begin
    If btnHistorico.Enabled Then
      btnHistorico.Click;
  End
  Else If Key = VK_Escape Then
  Begin
    If edtCheque.Visible Then
    Begin
      blnDigLei := False;
      edtCheque.Clear;
      strCodBan := '';
      strNumChq := '';
      strConCor := '';
      strNumAge := '';
      edtCheque.Visible := False;
      lblCheque.Visible := False;
      chkLeitor.Checked := False;
      chkInfMan.Checked := False;
    End;
  End;
end;

function TfrmCadCheques.fEmitenteBloqueado(strNumCgc: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmi: TUniQuery;
begin
  Try
    qryGenEmi := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMI_BLOQUE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMI_C_G_C_ = :NUMCGC ';

    With qryGenEmi Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMCGC').AsString := strNumCgc;
      Open;

      Result := False;
      If (Not IsEmpty) Then
        If (FieldByName('EMI_BLOQUE').AsString = 'S') Then
          Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmi);
  End;
end;

function TfrmCadCheques.fEmitenteCadastrado(strNumCgc: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMI_C_G_C_ = :NUMCGC ';

  With qryCadEmi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMCGC').AsString := strNumCgc;
    Open;
    Result := RecordCount > 0;
  End;
end;

function TfrmCadCheques.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;

  Try
    If fMovimentoBancario Then
    Begin
      If Not fGravaDebitoMovBanRefExclusao Then
      Begin
        fRollback;
        fMensagem('ATENÇÃO','Não gravou movimento bancário. Operação será cancelada!',['&OK']);
        Exit(False);
      End;
    End;

    If blnGravacaoFisica Then
    Begin
      pGravaLogChq(cdsTabela, 'EXCLUINDO (frmCadCheques.pGravaDelLogChq)');
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCheques.fExecutaAntesDoDelete]');
      Exit(False);
    End;
  End;
end;

function TfrmCadCheques.fExisteCheque(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try

    Result := False;

    qryGenChq := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    With qryGenChq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('NUMAGE').AsString := strNumAge;
      ParamByName('CONCOR').AsString := strConCor;
      ParamByName('NUMCHQ').AsString := strNumChq;
      Open;
      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;
end;

function TfrmCadCheques.fExisteDevolucao(strCodBco, strNumAge, strConCor,
  strNumChq: String): Boolean;
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try

    Result := False;

    qryGenChq := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CHQ_DTADEV ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ     ';

    With qryGenChq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('NUMAGE').AsString := strNumAge;
      ParamByName('CONCOR').AsString := strConCor;
      ParamByName('NUMCHQ').AsString := strNumChq;
      Open;
      If FieldByName('CHQ_DTADEV').Value <> Null Then
        Result := True;

      Close;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;
end;

procedure TfrmCadCheques.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeForRep.Text);
  edtNomFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
end;

Procedure TfrmCadCheques.pAtualizaChequeMovBan;
var
  qryAux : TUniQuery;
Begin

  If (Not fEmptyStr(strPorChqAnt)) And
     (strPorChqAnt <> dbePorChq.Text) Then
  Begin
    fGravaMovimentoBancario('D', strPorChqAnt, strCtaChqAnt, fltValLanAnt);
    fGravaMovimentoBancario('C');
    strPorChqAnt := '';
    strCtaChqAnt := '';
    fltValLanAnt := 0;
    Exit;
  End;

  qryAux := fCriaQuery;

  Try

    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add(' UPDATE MOVBAN MV ');
      SQL.Add(' INNER JOIN BANCHQ BC ON BC.CTB_SEQLAN = MV.CTB_SEQLAN ');
      SQL.Add(' SET MV.CTB_DTALAN = :DTALAN, ');
      SQL.Add('     MV.CTB_CODCTA = :CODCTA, ');
      SQL.Add('     MV.CTB_VALLAN = :VALLAN, ');
      SQL.Add('     BC.CHQ_HIST01 = :HIST01, ');
      SQL.Add('     BC.CHQ_HIST02 = :HIST02, ');
      SQL.Add('     BC.CHQ_VALCHQ = :VALLAN  ');
      SQL.Add(' WHERE MV.CTB_SEQLAN = :SEQLAN ');
      ParamByName('DTALAN').AsDate   := strToDateDef(dbeDtaCad.Text, 0);
      ParamByName('CODCTA').AsString := fraPlanoDeContasMov.dbeCodCta.Text;
      ParamByname('VALLAN').AsFloat  := dbeValChq.Field.Value;
      ParamByname('HIST01').AsString := dbeHIST01.Text;
      ParamByname('HIST02').AsString := dbeHIST02.Text;
      ParamByName('SEQLAN').AsString := strSeqLan;

      ExecSQL;

    End;

  Finally
    FreeAndNil(qryAux);
  End;

End;

Function TfrmCadCheques.fGravaDebitoMovBan: Boolean;
  Var
    dtaDatLan: TDate;
    strHisChq: String;
    lstBanChq: TBanChqRepository;
begin
  //*********************************//
  //  GRAVACAO DO MOVBAN CASO O      //
  //  CHEQUE FOI DEVOLVIDO SENDO     //
  // LANCADO UM DEBITO NO MOVBAN     //
  //******************************PB*//
  Result := TRUE;
  lstBanChq := Nil;

  If ((Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDev.Text))) And (dbeDtaDev.Field.AsDateTime <> dtaDevAnt)) Or
     ((Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text))) And (dbeDtaDv2.Field.AsDateTime <> dtaDv2Ant)) Then
  Begin
    If dbeDtaDev.Field.AsDateTime <> dtaDevAnt Then
    Begin
      dtaDatLan := strToDateDef(dbeDtaDev.Text, 0);
      strHisChq := dbeMotDev.Text;
    End Else
    Begin
      dtaDatLan := strToDateDef(dbeDtaDv2.Text, 0);
      strHisChq := dbeMotDv2.Text;
    End;

    If fEmptyStr(fraPlanoDeContasPla.dbeCodCta.Text) Or fEmptyStr(dbeCodPor.Text) Then
    Begin
      strMsgErr := 'Os campos Portador(CHQ_CODPOR) e Plano de Contas(CHQ_CODCTA) não podem estar vazios para realizar esta operação.';
      Result := False;
      Exit;
    End;

    If fEmptyStr(fRetDescCentroCusto(fraPlanoDeContasPla.dbeCodCta.Text)) Then
    Begin
      strMsgErr := 'O campo Plano de Contas(CHQ_CODCTA) deve existir para realizar esta operação.';
      Result := False;
      Exit;
    End;

    IF dbePorChq.Field.Value <> NULL THEN
    BEGIN
      If fEmptyStr(fRetNomPortador(dbeCodPor.Text)) Then
      Begin
        strMsgErr := 'O campo Portador(CHQ_CODPOR) deve existir para realizar esta operação.';
        Result := False;
        Exit;
      End;
    END;

    lstBanChq := TBanChqRepository.Create;
    Try
      {*********************************************}
      {***** NÃO GRAVA MOVBAN CASO FOR REPASSE, ****}
      {**** JÁ É GRAVADO O MOVBAN NO REPASSE DO ****}
      {*** CONTAS A PAGAR, PORTANTO AQUI NAO TEM ***}
      {**** QUE SER GRAVADO NOVAMENTE, GERANDO *****}
      {*** ASSIM DOIS 'D' REFERENTES AO CHQ, TEM ***}
      {** QUE SER GERADO SOMENTE UM 'D' NO MOVBAN **}
      {*********************************************}
      {*REQ. 45013 30/11/2015********************MO*}
      If ((dbeCtaDep.Text <> 'REPASSE') And (not (blnRepasse))) then
      begin
        lstBanChq.fAdd(dbeCodBco.Text,
                       dbeNumAge.Text,
                       dbeConCor.Text,
                       dbeNumChq.Text,
                       dbeCodCli.Text,
                       dbeNomEmi.Text,
                       dbeHist01.Text,
                       dbeHist02.Text,
                       VS_strCodEmp,
                       '',
                       fStrToFloat(dbeValChq.Text));

        Result := fGravaMovBan(fraPlanoDeContasPla.dbeCodCta.Text,   // Centro de Custo
                               dbeCodPor.Text,                       // Portador da Baixa
                               strLoginUsuarioLogado,                // Operador da Baixa
                               dtaDatLan,                            // Data do Lançamento
                               fTime(),                              // Hora do Lançamento
                               dbeNumChq.Text,                       // Numero do Documento
                               'D',                                  // Credito / Debito
                               VS_strCodEmp,                         // Empresa da Baixa
                               fStrToFloat(dbeValChq.Text),          // Valor Do Lançamento
                               strHisChq,                            // Histórico 1
                               '',                                   // Histórico 2
                               '',                                   // Cliente da Duplicata
                               '',                                   // Fornecedor da Duplicata
                               dbeNumChq.Text,                       // Número da Duplicata
                               0,                                    // Sequencial de Baixa
                               '',                                   // Parcela da Duplicata
                               '',                                   // Empresa da Duplicata
                               '',                                   // Série
                               '',                                   // Código do Evento
                               '',                                   // Documento da Baixa
                               lstBanChq.fGetList,                   // Log Bancário
                               0,
                               0,
                               '',
                               '',
                               '',
                               '',
                               cdsTabela.FieldByName('AUTOINCREM').AsString
                              ) <> '';
      end;

      {**********************************************}
      {* NÃO GRAVA A CONTRA PARTIDA SE FOR          *}
      {* SEGUNDA DEVOLUÇÃO OU DEVOLUÇÃO DEFINTIVA   *}
      {* E ESTIVER CONFIGURADO PARA GRAVAR NO CADREC*}
      {*REQ. 36170 05/06/2015*********************JU*}
      If (fCfgSis('CHQCTR',varBoolean)) then
        if ((Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDv2.Text))) And ( dbeDtaDv2.Field.AsDateTime <> dtaDv2Ant)) OR
           ((cdsTabela.FieldByName('CHQ_DEVDEF').AsString = '1') AND ( cdsTabela.FieldByName('CHQ_DTAREP').IsNull)) Then
        Exit;

      {*****************************************}
      {* GRAVA A CONTRA PARTIDA                *}
      {**************************************MV*}
      If (Result) And (Not fEmptyStr(cdsTabela.FieldByName('CHQ_PORDEB').AsString)) Then
      Begin
        If fEmptyStr(cdsTabela.FieldByName('CHQ_CTADEB').AsString) Or fEmptyStr(FPortadorContraPartidaNaDevolucao) Then
        Begin
          strMsgErr := 'Os campos Portador Deb.(CHQ_PORDEB) e Plano de Contas Deb.(CHQ_CTADEB) não podem estar vazios para realizar esta operação.';
          Result := False;
          Exit;
        End;

        If fEmptyStr(fRetDescCentroCusto(cdsTabela.FieldByName('CHQ_CTADEB').AsString)) Then
        Begin
          strMsgErr := 'O campo Plano de Contas(CHQ_CTADEB) deve existir para realizar esta operação.';
          Result := False;
          Exit;
        End;

        If fEmptyStr(fRetNomPortador(FPortadorContraPartidaNaDevolucao)) Then
        Begin
          strMsgErr := 'O campo Portador(CHQ_PORDEB) deve existir para realizar esta operação.';
          Result := False;
          Exit;
        End;

        lstBanChq.pClear;
        lstBanChq.fAdd(dbeCodBco.Text,
                       dbeNumAge.Text,
                       dbeConCor.Text,
                       dbeNumChq.Text,
                       dbeCodCli.Text,
                       dbeNomEmi.Text,
                       dbeHist01.Text,
                       dbeHist02.Text,
                       VS_strCodEmp,
                       '',
                       fStrToFloat(dbeValChq.Text));

        Result := fGravaMovBan(cdsTabela.FieldByName('CHQ_CTADEB').AsString, // Centro de Custo
                               FPortadorContraPartidaNaDevolucao,            // Portador da Baixa
                               strLoginUsuarioLogado,                        // Operador da Baixa
                               dtaDatLan,                                    // Data do Lançamento
                               fTime(),                                      // Hora do Lançamento
                               dbeNumChq.Text,                               // Numero do Documento
                               'C',                                          // Credito / Debito
                               VS_strCodEmp,                                 // Empresa da Baixa
                               fStrToFloat(dbeValChq.Text),                  // Valor Do Lançamento
                               strHisChq,                                    // Histórico 1
                               '',                                           // Histórico 2
                               '',                                           // Cliente da Duplicata
                               '',                                           // Fornecedor da Duplicata
                               dbeNumChq.Text,                               // Número da Duplicata
                               0,                                            // Sequencial de Baixa
                               '',                                           // Parcela da Duplicata
                               '',                                           // Empresa da Duplicata
                               '',                                           // Série
                               '',                                           // Código do Evento
                               '',                                           // Documento da Baixa
                               lstBanChq.fGetList                            // Log Bancário
                              ) <> '';

      End;
    Finally
      FreeAndNil(lstBanChq);
    End;
  End;
end;

procedure TfrmCadCheques.pRetornaDadosDoMovBan(strAutIncCheque: string; var dtaDtaLan: TDateTime; var horHorLan: TDateTime; Var strCodPor: String; Var ACodCta: String);
var
  strSQL: String;
  qryMovBan: TUniQuery;
begin
  Try
    qryMovBan := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '    CTB_DTALAN, ';
    strSQL := strSQL + '    CTB_HORLAN, ';
    strSQL := strSQL + '    CTB_CODPOR, CTB_CODCTA ';
    strSQL := strSQL + ' FROM MOVBAN ';
    strSQL := strSQL + ' WHERE CTB_CODCHQ = :CTB_CODCHQ ';
    strSQL := strSQL + ' AND CTB_CREDEB = ''D'' ';
    strSQL := strSQL + ' AND CTB_HIST01 = ''TRANSF. CHEQUE PARA CNT. RECEBER'' ';
    strSQL := strSQL + ' ORDER BY CTB_SEQLAN DESC  ';
    strSQL := strSQL + ' LIMIT 1 ';

    qryMovBan.Close;
    qryMovBan.SQL.Clear;
    qryMovBan.SQL.Add(strSQL);
    qryMovBan.ParamByName('CTB_CODCHQ').AsString := strAutIncCheque;
    qryMovBan.Open;

    If (Not qryMovBan.IsEmpty) Then
    Begin
      strCodPor := qryMovBan.FieldByName('CTB_CODPOR').asString;
      dtaDtaLan := qryMovBan.FieldByName('CTB_DTALAN').AsDateTime;
      ACodCta := qryMovBan.FieldByName('CTB_CODCTA').asString;

      If (Not fEmptyStr(qryMovBan.FieldByName('CTB_HORLAN').asString)) Then
        horHorLan := qryMovBan.FieldByName('CTB_HORLAN').AsDateTime
      Else
        horHorLan := fTime();
    End
    Else
    Begin
      dtaDtaLan := VS_Date;
      horHorLan := fTime();
    End;

    qryMovBan.Close;

  Finally
    FreeAndNil(qryMovBan);
  End;

end;

function TfrmCadCheques.fGravaMovBanTransferenciaContasReceber(strCreDeb: String): Boolean;
Var
  lstBanChq: TBanChqRepository;
  strHist01: String;
  dtaDtaLan: TDateTime;
  horHorLan: TDateTime;
  blnGravarMovBan: Boolean;
  LPlanoContas: String;
begin
  Result := True;

  blnGravarMovBan := blnDefinePortCta;
  LPlanoContas := strCodCta;

  If (strCreDeb = 'D') Then
  Begin
    strHist01 := 'TRANSF. CHEQUE PARA CNT. RECEBER';
    dtaDtaLan := VS_Date;
    horHorLan := fTime();
  End
  Else
  Begin
    strHist01 := 'CANC. TRANSF. CHEQUE PARA CNT. RECEBER';

    pRetornaDadosDoMovBan(cdsTabela.FieldByName('AUTOINCREM').AsString, dtaDtaLan, horHorLan, strCodPor, LPlanoContas);

    if (strCodPor = '') Then
      strCodPor :=  cdsTabela.FieldByName('CHQ_PORCHQ').AsString;

    If LPlanoContas.IsEmpty Then
      LPlanoContas :=  cdsTabela.FieldByName('CHQ_CTACHQ').AsString;

    blnGravarMovBan := True;
  End;

  If (blnGravarMovBan) Then
  Begin
    lstBanChq := TBanChqRepository.Create;
    Try
      lstBanChq.pClear;
      lstBanChq.fAdd(dbeCodBco.Text,
                     dbeNumAge.Text,
                     dbeConCor.Text,
                     dbeNumChq.Text,
                     dbeCodCli.Text,
                     dbeNomEmi.Text,
                     dbeHist01.Text,
                     dbeHist02.Text,
                     VS_strCodEmp,
                     '',
                     fStrToFloat(dbeValChq.Text));

      Result := fGravaMovBan(LPlanoContas,                            // Centro de Custo
                             strCodPor,                            // Portador da Transferencia do caixa para o módulo de cheques
                             strLoginUsuarioLogado,                // Operador da Baixa
                             dtaDtaLan,                            // Data do Lançamento  //MF: 291414 - 05/07/23
                             horHorLan,                            // Hora do Lançamento  //MF: 291414 - 05/07/23
                             dbeNumChq.Text,                       // Numero do Documento
                             strCreDeb,                            // Credito / Debito //MF: 291414 - 04/07/23
                             VS_strCodEmp,                         // Empresa da Baixa
                             fStrToFloat(dbeValChq.Text),          // Valor Do Lançamento
                             strHist01,                            // Histórico 1 //MF: 291414 - 04/07/23
                             '',                                   // Histórico 2
                             '',                                   // Cliente da Duplicata
                             '',                                   // Fornecedor da Duplicata
                             dbeNumChq.Text,                       // Número da Duplicata
                             0,                                    // Sequencial de Baixa
                             '',                                   // Parcela da Duplicata
                             '',                                   // Empresa da Duplicata
                             '',                                   // Série
                             '',                                   // Código do Evento
                             '',                                   // Documento da Baixa
                             lstBanChq.fGetList,                   // Log Bancário
                             0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             cdsTabela.FieldByName('AUTOINCREM').AsString
                            ) <> '';
    Finally
      FreeAndNil(lstBanChq);
    End;
  End;
end;

Function TfrmCadCheques.fGravouDevolucao(Var blnErro:Boolean): Boolean;
  Var
    qryGenChqDev: TUniQuery;
    strSQL: String;
Begin
  Try
    blnErro := FALSE;
    {*************************************}
    {* VERIRFICA SE JA FOI GERADO CADREC *}
    {**********************************AF*}
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strArqChqDev;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CHQ_SEQGER = :SEQGER AND ';
    strSQL := strSQL + '   CHQ_DTADEV = :DTADEV ';

    qryGenChqDev := fCriaQuery();

    With qryGenChqDev Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString   := cdsTabela.FieldByName('AUTOINCREM').AsString;

      If cdsTabela.FieldByName('CHQ_DTADV2').IsNull Then
        ParamByName('DTADEV').AsDateTime := cdsTabela.FieldByName('CHQ_DTADEV').AsDateTime
      Else
        ParamByName('DTADEV').AsDateTime := cdsTabela.FieldByName('CHQ_DTADV2').AsDateTime;

      Open;

      Result := RecordCount > 0;

      Close;
    End;

    FreeAndNil(qryGenChqDev);

  Except
    On E: Exception Do
    Begin
      Result  := FALSE;
      blnErro := TRUE;
			pMensagensErro(E.Message,'[TfrmCadCheques.fGravouDevolucao]');
    End;
  End;
End;

Function TfrmCadCheques.fLimpaDadosBaixa: Boolean;
Begin
  Try
    Result := TRUE;

    With cdsTabela Do
    Begin

      Edit;

      FieldByName('CHQ_CDCTSV').Value := FieldByName('CHQ_CODCTA').Value;
      FieldByName('CHQ_CDPRSV').Value := FieldByName('CHQ_CODPOR').Value;
      FieldByName('CHQ_PRDBSV').Value := FieldByName('CHQ_PORDEB').Value;

      If fEmptyStr(FieldByName('CHQ_CTADEB').AsString) Then
        FieldByName('CHQ_CTADEB').Value := Null
      Else
        FieldByName('CHQ_CTDBSV').Value := FieldByName('CHQ_CTADEB').Value;

      If fEmptyStr(FieldByName('CHQ_CTADEP').AsString) Then
        FieldByName('CHQ_CTDPSV').Value := Null
      Else
        FieldByName('CHQ_CTDPSV').Value := FieldByName('CHQ_CTADEP').Value;

      FieldByName('CHQ_CTADEP').Value := Null;
      FieldByName('CHQ_DOCDEP').Value := Null;
      FieldByName('CHQ_CODPOR').Value := FieldByName('CHQ_CODPOR').Value;
      FieldByName('CHQ_PORDEB').Value := Null;
      FieldByName('CHQ_CTADEB').Value := Null;
      Post;
    End;
  Except
    On E: Exception Do
    Begin
      Result := FALSE;
			pMensagensErro(E.Message,'[TfrmCadCheques.fLimpaDadosBaixa]');
    End;
  End;
End;

function TfrmCadCheques.fMovimentoBancario(blnConciliado : Boolean = False): Boolean;
var
  qryAux:TUniQuery;
begin

  strSeqLan := '';

  qryAux := fCriaQuery;

  Try
    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT CTB_SEQLAN, CTB_DTACON FROM MOVBAN  ');
      SQL.Add(' WHERE CTB_CREDEB = "C" AND     ');
      SQL.Add('       CTB_CODPOR = :PORCHQ AND ');
      SQL.Add('       CTB_CODCHQ = :AUTINC     ');
      ParamByName('AUTINC').AsString := cdsTabela.FieldByName('AUTOINCREM').AsString;
      ParamByName('PORCHQ').AsString := IIF(fEmptyStr(strPorChqAnt),cdsTabela.FieldByName('CHQ_PORCHQ').AsString,strPorChqAnt);
      Open;

      Result := Not IsEmpty;

      If Result Then
        strSeqLan := FieldByName('CTB_SEQLAN').AsString;

      If Result And blnConciliado Then
        Result := Not FieldByName('CTB_DTACON').IsNull;

      Close;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadCheques.fObrigatorioPortadorEConta: Boolean;
begin
  Result := qryTabela.FieldByName('AUTOINCREM').IsNull Or fMovimentoBancario;
end;

function TfrmCadCheques.fGravaCadEmi(strNumCgc, strCodEmp, strCgcCpf, strNomEmi,
  strEndere, strBairro, strNumCep, strCodCid, strNumIes, strNumR_g,
  strTele01: String): Boolean;
begin
  If (Not qryCadEmi.Active) Then
  Begin
    qryCadEmi.Open;
  End;

  Try

    If (fEmitenteCadastrado(strNumCgc)) Then
    Begin
      qryCadEmi.Edit;
    End
    Else
    Begin
      qryCadEmi.Insert;
    End;

    cdsTabela.Edit;
    if strNumCgc <> strNumCgcAtual then
    begin
      cdsTabela.FieldByName('CHQ_C_G_C_').AsString  := strNumCgcAtual;
      qryCadEmi.FieldByName('EMI_C_G_C_').AsString  := strNumCgcAtual;
    end
    else
    begin
      cdsTabela.FieldByName('CHQ_C_G_C_').AsString  := strNumCgc;
      qryCadEmi.FieldByName('EMI_C_G_C_').AsString  := strNumCgc;
    end;

    qryCadEmi.FieldByName('EMI_CODEMP').AsString  := strCodEmp;

    if strCgcCpf <> strCgcCpfAtual then
    begin
      cdsTabela.FieldByName('CHQ_CGCCPF').AsInteger := StrToIntDef(strCgcCpfAtual, 0);
      qryCadEmi.FieldByName('EMI_CGCCPF').AsInteger := StrToIntDef(strCgcCpfAtual, 0);
    end
    else
    begin
      cdsTabela.FieldByName('CHQ_CGCCPF').AsInteger := StrToIntDef(strCgcCpf, 0);
      qryCadEmi.FieldByName('EMI_CGCCPF').AsInteger := StrToIntDef(strCgcCpf, 0);
    end;

    if strNomEmi <> strNomEmiAtual then
    begin
      cdsTabela.FieldByName('CHQ_NOMEMI').AsString  := strNomEmiAtual;
      qryCadEmi.FieldByName('EMI_NOMEMI').AsString  := strNomEmiAtual;
    end
    else
    begin
      cdsTabela.FieldByName('CHQ_NOMEMI').AsString  := strNomEmi;
      qryCadEmi.FieldByName('EMI_NOMEMI').AsString  := strNomEmi;
    end;

    if strEndere <> strEndereAtual then
    begin
      cdsTabela.FieldByName('CHQ_ENDERE').AsString  := strEndereAtual;
      qryCadEmi.FieldByName('EMI_ENDERE').AsString  := strEndereAtual;
    end
    else
    begin
      cdsTabela.FieldByName('CHQ_ENDERE').AsString  := strEndere;
      qryCadEmi.FieldByName('EMI_ENDERE').AsString  := strEndere;
    end;

    qryCadEmi.FieldByName('EMI_BAIRRO').AsString  := strBairro;
    qryCadEmi.FieldByName('EMI_C_E_P_').AsString  := strNumCep;

    If (fEmptyStr(strCodCid)) Then
      qryCadEmi.FieldByName('EMI_CODCID').Value := Null
    Else
      qryCadEmi.FieldByName('EMI_CODCID').AsString  := strCodCid;

    qryCadEmi.FieldByName('EMI_I_E_S_').AsString  := strNumIes;
    qryCadEmi.FieldByName('EMI_NUMR_G').AsString  := strNumR_g;

    if strTele01 <> strTelEmiAtual then
    begin
      cdsTabela.FieldByName('CHQ_TELEMI').AsString  := strTelEmiAtual;
      qryCadEmi.FieldByName('EMI_TELE01').AsString  := strTelEmiAtual;
    end
    else
    begin
      cdsTabela.FieldByName('CHQ_TELEMI').AsString  := strTele01;
      qryCadEmi.FieldByName('EMI_TELE01').AsString  := strTele01;
    end;

    qryCadEmi.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('CADEMI', VS_strCodEmp);
    qryCadEmi.FieldByName('EMI_BLOQUE').AsString  := 'N';
    cdsTabela.Post;
    qryCadEmi.Post;
    Result := True;

  Except
    On E: Exception Do
    Begin
      qryCadEmi.Cancel;

      Raise Exception.Create(E.Message + ' - [fGravaCadEmi]');
    End;
  End;
end;

function TfrmCadCheques.fGravaCadPagFornecedor(strCodFor, strCta_Pg,
  strCodEve: String): Boolean;
  Var
    strHist01,
    strNumDup : String;
    dtaCadPag : TDate;
begin
  If Not ((dbeDevDef.Checked) And (Not dbeForRep.Field.IsNull)) Then
  Begin
    Result := True;
    Exit;
  End;

  strHist01 := dbeHist01.Text + ' / ' +
               'Banco: ' + dbeCodBco.Text + ' - ' + edtNomBan.Text + #13#10 +
               'Conta Corrente: ' + dbeConCor.Text + ' / Nro do Cheque: ' + dbeNumChq.Text + ' / ' +
               'Data Cadastro: ' + dbeDtaCad.Text + ' / Vencimento: ' + dbeDtaVen.Text + #13#10 +
               'Documento: ' + dbeDocume.Text;

  dtaCadPag := fSelecionaDataCadPag;

  strNumDup := fRetSequencialCadPag;

  strChaveCadPag := strNumDup + '-A-' +
                    cdsTabela.FieldByName('CHQ_CODEMP').AsString + '-' + strCodFor;

  Result := fGravaCadPag(Self.Name,
                         'INCLUSÃO CADCHEQUE',
                         strCodFor,
                         strNumDup, // strNumDup
                         'A', // strParcel
                         cdsTabela.FieldByName('CHQ_CODEMP').AsString,
                         strCta_Pg,
                         '', // strSerie
                         0, // intSeqBai
                         { *****************************************************************************************}
                         { CASO O CHEQUE TENHA DEVOLUÇÃO DEFINITIVA EFETUA O CADASTRO DO CHEQUE NO CTAPAGAR         }
                         { COM DATA DE CADASTRO E VENCIMENTO IGUAIS A DATA DE REPASSE POIS O DOCUMENTO JÁ É VENCIDO }
                         { ************************************************************************************FA***}
                         dtaCadPag,
                         dtaCadPag,
                         cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat, // fltValDup
                         cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat, // fltValOri
                         'N', // strPrevis
                         'N', // strVeioBo
                         'N', // strDeposi
                         strHist01,
                         '', // strHist02
                         '', // strHisBai
                         '', // strPorBai
                         '', // strCtaBai
                         '', // strDocBai
                         '', // strOpeBai
                         0, // dtaDtaPag
                         0, // fltValPag
                         0, // fltValJur
                         0, // fltValDes
                         VS_strCodEmp, // strEmpGer
                         strCodEve, // strCodEve
                         'N', // strUsaChq
                         '', // strCodPor
                         '', // strNumDoc
                         0.0, // fltJurSuj
                         0.0, // fltDesSuj
                         0, // intSeqCon
                         False,
                         0,
                         '1', // strTipDoc
                         0,   // fltVendor
                         'N'  // strVeioNF
                         );
end;

function TfrmCadCheques.fGravaCadRecCheque(blnTransf: Boolean = False): Boolean;
  function fGetSeqCheque(strEmpChq: String): String;
  Var
    qryGenCtr: TUniQuery;
  begin
    Try
      qryGenCtr:= fCriaQuery;

      Repeat
        Result := fRetSequencial('PROCHQ', VS_strCodEmp, fTamDocCadRec);

        With qryGenCtr Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT  ');
          SQL.Add('  CTR_NUMDUP AS NUMDUP  ');
          SQL.Add('FROM  ');
          SQL.Add('  CADREC  ');
          SQL.Add('WHERE  ');
          SQL.Add('  CTR_NUMDUP = :NUMDUP AND  ');
          SQL.Add('  CTR_ESPDOC = "CH"    AND  ');
          SQL.Add('  CTR_CODEMP = :CODEMP  ');

          ParamByName('NUMDUP').AsString := Result;
          ParamByName('CODEMP').AsString := strEmpChq;

          Open;
        End;

      Until qryGenCtr.IsEmpty;

    Finally
      FreeAndNil(qryGenCtr);
    End;
  end;

  Var
    strEmpChq:      String;
    strHisChq:      String;
    strHist01:      String;
    strHist02:      String;
    LDtaVenCheque:  TDateTime;
    LDtaCadCadRec:  TDateTime;
    LDtaVenCadRec:  TDateTime;
    LValDupCadRec:  Double;
    LJurosSegerido: Double;
Begin
  Try
    if FVendedorContaAReceber = '' then
    begin
      Result    := False;
      strMsgErr := 'É obrigatório informar o código do vendedor, ao transferir o cheque para o contas a receber!' + #13 ;
      Exit;
    end;

   {***********************************}
   { ARMAZENA A EMPRESA DO CHEQUE      }
   {********************************JB*}
    strEmpChq := cdsTabela.FieldByName('CHQ_CODEMP').AsString;

    If (dbeTelChe.Text = 'S') Then
      strHisChq := 'TELECHEQUE: ' + dbeTelNum.Text
    Else strHisChq := 'TELECHEQUE NÃO';

    LDtaVenCheque := StrToDateDef(dbeDtaVen.Text, 0);
    LDtaVenCadRec := LDtaVenCheque;
    LDtaCadCadRec := StrToDateDef(dbeDtaCad.Text, 0);
    LValDupCadRec := fStrToFloat(dbeValChq.Text);
    LJurosSegerido:= 0;

    If blnTransf Then
    Begin
      strHist01 := 'TRANSFERENCIA PARA O CONTAS A RECEBER ' +
                   'REF. A CHQ. No: ' + dbeNumChq.Text + ', AGE: ' + dbeNumAge.Text + #13#10 +
                   'EMITENTE: ' + dbeNomEmi.Text +
                   IIF(fEmptyStr(dbeHist01.Text), '', #13#10 + dbeHist01.Text) +
                   IIF(fEmptyStr(dbeHist02.Text), '', #13#10 + dbeHist02.Text);
      strHist02 := '';

      LDtaVenCadRec := VS_Date;
      LDtaCadCadRec := VS_Date;
      LJurosSegerido:= fCalculaJurosCadCtr(LDtaVenCheque, LValDupCadRec);
    End
    Else
    Begin
      strHist01 := 'DTA.TIT: ' + dbeDtaCad.Text + ', ' +
                   'REF. A CHQ. No: ' + dbeNumChq.Text + ', AGE: ' + dbeNumAge.Text + #13#10 +
                   'EMITENTE: ' + dbeNomEmi.Text +
                   IIF(fEmptyStr(dbeHist01.Text), '', #13#10 + dbeHist01.Text) +
                   IIF(fEmptyStr(dbeHist02.Text), '', #13#10 + dbeHist02.Text) +
                   #13#10 + strHisChq;
      strHist02 := 'CNT.COR: ' + dbeConCor.Text + ', BCO: ' + dbeCodBco.Text;
    End;

    {***********************************************}
    { PEGA O CODIGO SEQUENCIAL DA EMPRESA DE ORIGEM }
    {********************************************JB*}
    strNumDup := fGetSeqCheque(strEmpChq);

    Result := fGravaCadRec(Self.Name,
                           'INCLUSÃO',
                           strNumDup,
                           'A',
                           0,
                           'CH',
                           dbeCodCli.Text,
                           strEmpChq,
                           FVendedorContaAReceber,
                           strLoginUsuarioLogado,
                           FPortadorContaAReceber,
                           LDtaCadCadRec,
                           LDtaVenCadRec,
                           LValDupCadRec,    //Valor da duplicata
                           LValDupCadRec,    //Valor Original
                           0,
                           'N',
                           strHist01,
                           strHist02,
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           'N',
                           '',
                           '',
                           '',
                           '',
                           False,
                           strCodCta,
                           0,
                           LValDupCadRec,    //GrvOri
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           0,
                           '',
                           0,
                           0,
                           'N',
                           0,
                           LJurosSegerido);
  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      strMsgErr := strMsgErr + 'Ocorreu um erro ao gerar Contas a Receber!' + #13 + E.Message + #13;
    End;
  End;

End;

function TfrmCadCheques.fGravaMovimentoBancario(strTipo: String;
                                                strPorChq: String = '';
                                                strCtaChq: String = '';
                                                fltValChq: Double = 0) : Boolean;
var
  strHisChq: String;
  lstBanChq: TBanChqRepository;
begin
  lstBanChq := Nil;

  strHisChq := 'REF.CH ' + dbeCodBco.Text + '-' + dbeNumAge.Text + '-' +
                           dbeConCor.Text + '-' + dbeNumChq.Text;

  lstBanChq := TBanChqRepository.Create;
  Try
    lstBanChq.fAdd(dbeCodBco.Text,
                   dbeNumAge.Text,
                   dbeConCor.Text,
                   dbeNumChq.Text,
                   dbeCodCli.Text,
                   dbeNomEmi.Text,
                   dbeHist01.Text,
                   dbeHist02.Text,
                   VS_strCodEmp,
                   '',
                   IIF(fltValChq=0,fStrToFloat(dbeValChq.Text),fltValChq));

    Result := fGravaMovBan(IIF(fEmptyStr(strCtaChq),fraPlanoDeContasMov.dbeCodCta.Text,strCtaChq), // Centro de Custo
                           IIF(fEmptyStr(strPorChq),dbePorChq.Text,strPorChq), // Portador da Baixa
                           strLoginUsuarioLogado,                // Operador da Baixa
                           VS_Date,                              // Data do Lançamento
                           fTime(),                              // Hora do Lançamento
                           dbeNumChq.Text,                       // Numero do Documento
                           strTipo,                              // Credito / Debito
                           VS_strCodEmp,                         // Empresa da Baixa
                           IIF(fltValChq=0,fStrToFloat(dbeValChq.Text),fltValChq), // Valor Do Lançamento
                           strHisChq,                            // Histórico 1
                           '',                                   // Histórico 2
                           '',                                   // Cliente da Duplicata
                           '',                                   // Fornecedor da Duplicata
                           dbeNumChq.Text,                       // Número da Duplicata
                           0,                                    // Sequencial de Baixa
                           '',                                   // Parcela da Duplicata
                           '',                                   // Empresa da Duplicata
                           '',                                   // Série
                           '',                                   // Código do Evento
                           '',                                   // Documento da Baixa
                           lstBanChq.fGetList,                   // Log Bancário
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           cdsTabela.FieldByName('AUTOINCREM').AsString
                          ) <> '';

  Finally
    FreeAndNil(lstBanChq);
  End;
end;

Function TfrmCadCheques.fGravaHistoricoDevolucao: Boolean;
  Var
    blnErro  : Boolean;
    dtaDtaDep: TDate;
    dtaDtaDev: TDate;
    blnGraDev: Boolean;
Begin
  Result  := TRUE;
  blnErro := FALSE;

  If ((Not dbeDtaDev.Field.IsNull) And (dbeDtaDev.Field.AsDateTime <> dtaDevAnt)) Or
     ((Not dbeDtaDv2.Field.IsNull) And (dbeDtaDv2.Field.AsDateTime <> dtaDv2Ant)) Then
  Begin

    blnGraDev := fGravouDevolucao(blnErro);

    If Not blnGraDev Then
    Begin
    
      If cdsTabela.FieldByName('CHQ_DTADP2').IsNull Then
        dtaDtaDep := cdsTabela.FieldByName('CHQ_DTADEP').AsDateTime
      Else
        dtaDtaDep := cdsTabela.FieldByName('CHQ_DTADP2').AsDateTime;

      If cdsTabela.FieldByName('CHQ_DTADV2').IsNull Then
        dtaDtaDev := cdsTabela.FieldByName('CHQ_DTADEV').AsDateTime
      Else
        dtaDtaDev := cdsTabela.FieldByName('CHQ_DTADV2').AsDateTime;

      Result := (Not blnErro) And fGravaChqDev(cdsTabela.FieldByName('AUTOINCREM').AsString,
                                               cdsTabela.FieldByName('CHQ_NUMCHQ').AsString,
                                               cdsTabela.FieldByName('CHQ_CONCOR').AsString,
                                               cdsTabela.FieldByName('CHQ_NUMAGE').AsString,
                                               cdsTabela.FieldByName('CHQ_CODBCO').AsString,
                                               cdsTabela.FieldByName('CHQ_CTADEP').AsString,
                                               dtaDtaDep,
                                               cdsTabela.FieldByName('CHQ_DOCDEP').AsString,
                                               cdsTabela.FieldByName('CHQ_CODPOR').AsString,
                                               cdsTabela.FieldByName('CHQ_CODCTA').AsString,
                                               dtaDtaDev,
                                               cdsTabela.FieldByName('CHQ_MOTDEV').AsString,
                                               cdsTabela.FieldByName('CHQ_CODEMP').AsString);

    End;

    Result := (Not blnErro) And Result And fLimpaDadosBaixa;

    If Result And fCfgSis('CHQCTR',varBoolean) And (Not dbeDtaDv2.Field.IsNull) Then
    Begin
      Result := fGravaCadRecCheque; // and fInsereMovBan;
    End;

  End;
End;

procedure TfrmCadCheques.FormClose(Sender: TObject; var Action: TCloseAction);
  Var
    blnConfSaida: Boolean;
begin
  fltValAtu := RoundTo(fltValAtu, -2);
  fltValTot := RoundTo(fltValTot, -2);

  optTroco      := otNada;
  fltValorTroco := 0.0;

  If (cdsTabela.State = dsInsert) Or (cdsTabela.State = dsEdit) Then
  Begin
    If Not blnResumida Then
    Begin
      Action := caNone;
      inherited;
      Exit;
    End;
  End;

  If fFormataFloat(fltValTot, 2) = fFormataFloat(fltValAtu, 2) Then
  Begin
    inherited;

    cdsTabela.AfterOpen := Nil;
    blnConfima := True;
  End
  Else
  Begin

    If (blnTroChq) And (fFormataFloat(fltValAtu, 2) > fFormataFloat(fltValTot, 2)) And fEmptyStr(strConPag) Then
    Begin

      Case fMensagem('', 'Deseja:', ['&Crédito', '&Troco', 'C&ancelar']) Of
        1: optTroco := otCredito;
        2: optTroco := otTroco;
        Else optTroco := otNada;
      End;

      blnConfSaida := (optTroco <> otNada);
      blnConfima := blnConfSaida;
    End
    Else
    Begin
      If Not blnResumida Then
      Begin
        blnConfSaida := fMensagem('','Cheque(s) digitado(s) somam R$ ' + FloatToStrF(fltValAtu,ffFixed,15,2) + ' é diferente de R$ ' + FloatToStrF(fltValTot,ffFixed,15,2) + ', deseja sair da Manutenção de Cheques?',['&Sim','&Não']) = 1;
        blnConfima := False;
      End
      Else
      Begin
        blnConfSaida := True;
        blnConfima := False;
      End;
    End;

    If blnConfSaida Then
    Begin
      If (Not blnResumida) Or (blnTroChq) Then
      Begin
        inherited;
        cdsTabela.AfterOpen := Nil;

        If optTroco <> otNada Then
          fltValorTroco := fltValAtu - fltValTot;
      End
      Else
      Begin
        If cdsTabela.State In [dsEdit, dsInsert] Then
           cdsTabela.Cancel;

        // APAGANDO OS REGISTROS DA TEMPORÁRIA
        cdsTabela.EmptyDataSet;
        cdsTabela.AfterOpen := Nil;
        cdsTabela.AfterScroll := nil;

        Action := caFree;

        Exit;
      End;
    End
    Else
    Begin
      Action     := caNone;
      blnConfima := False;
    End;

  End;

  If Not cdsTabela.IsEmpty Then
    //pTravaDestravaCheque(strNewChvLck, False);

  fLock_Unlock('CADCHQ' + cdsTabela.FieldByName('AUTOINCREM').AsString, False);
  cdsTabela.AfterScroll := nil;

  If Action <> caNone Then
    FreeAndNil(qryCadEmi);
end;

procedure TfrmCadCheques.pCriaGetLeitor;
begin
  {*******************************************}
  {* INCLUI ESSA CHAMADA PARA SUBSTIRUIR A   *}
  {* CHAMADA ACIMA COMENTADA.                *}
  {****************************************AC*}
  If fCfgSis('MODCHQ') = '1' Then
  Begin
    pModCheque1;
  End
  Else If fCfgSis('MODCHQ') = '2' Then
  Begin
    pModCheque2;
  End;

  If Not fEmptyStr(strCodBan) And
     Not fEmptyStr(strNumChq) And
     Not fEmptyStr(strConCor) And
     Not fEmptyStr(strNumAge) Then
  Begin

    dbeCodCmc.Field.Text := edtCheque.Text;

    dbeCodBco.Field.Text := strCodBan;
    dbeNumChq.Field.Text := strNumChq;
    dbeConCor.Field.Text := strConCor;
    dbeNumAge.Field.Text := strNumAge;
    cdsTabela.FieldByName('CHQ_DTACAD').AsDateTime := VS_Date;

    If fEmptyStr(strConPag) Then
      cdsTabela.FieldByName('CHQ_DTAVEN').AsDateTime := VS_Date;

    If fBuscaPorCamposChave Then
    Begin
      If blnResumida Then
      Begin
        fltValAlt := cdsTabela.FieldByName('CHQ_VALCHQ').AsFloat;
      End;

      pCarregaDadosAdicionais;
      pHabilitaBtnTransfCtr;
      pAtualizaQtdCheques;            
      pSetFocus(dbeCodCli);
    End
    Else
    Begin
      pCarregaBanco;
      pSetFocus(dbeCodCli);
    End;

  End;
End;

procedure TfrmCadCheques.pAddCtrBaixando(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strParcel: String);
var
  objCtrBaixando: TChaveCtr;
begin
  objCtrBaixando := TChaveCtr.Create();

  objCtrBaixando.strNumDoc := strNumDoc;
  objCtrBaixando.strEspDoc := strEspDoc;
  objCtrBaixando.strCodEmp := strCodEmp;
  objCtrBaixando.strCodCli := strCodCli;
  objCtrBaixando.strParcel := strParcel;

  oblCtrBaixando.Add(objCtrBaixando);
end;

{*****************************************}
{* ADICIONADA NO AFTER OPEN DA cdsTabela *}
{**************************************AF*}
procedure TfrmCadCheques.pAfterOpenCds(DataSet: TDataSet);
Begin
  With DataSet Do
  Begin

    If FindField('CHQ_TELEMI') <> nil Then
      TStringField(FieldByName('CHQ_TELEMI')).EditMask := fRetMascaraFonePais;

    If FindField('CHQ_DTACAD') <> nil Then
      TDateField(FieldByName('CHQ_DTACAD')).EditMask := '99/99/9999';

    If FindField('CHQ_DTAVEN') <> nil Then
      TDateField(FieldByName('CHQ_DTAVEN')).EditMask := '99/99/9999';

    If FindField('CHQ_VALCHQ') <> nil Then
      TFloatField(FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';

    If FindField('CHQ_DTADEV') <> nil Then
      TDateField(FieldByName('CHQ_DTADEV')).EditMask := '99/99/9999';

    If FindField('CHQ_DTARDP') <> nil Then
      TDateField(FieldByName('CHQ_DTARDP')).EditMask := '99/99/9999';

    If FindField('CHQ_DTAREP') <> nil Then
      TDateField(FieldByName('CHQ_DTAREP')).EditMask := '99/99/9999';

    If FindField('CHQ_DTADP2') <> nil Then
      TDateField(FieldByName('CHQ_DTADP2')).EditMask := '99/99/9999';

    If FindField('CHQ_DTADV2') <> nil Then
      TDateField(FieldByName('CHQ_DTADV2')).EditMask := '99/99/9999';

  End;
End;

procedure TfrmCadCheques.pgcDadosChange(Sender: TObject);
begin
  inherited;
  If pgcDados.ActivePageIndex = 1 Then
    pCarregaFornecedor
  Else If pgcDados.ActivePageIndex = 2 Then
    pCarregaPortador2;
end;

function TfrmCadCheques.fGravaDebitoMovBanRefExclusao : Boolean;
var
  strHisChq: String;
  lstBanChq: TBanChqRepository;
begin
  lstBanChq := Nil;

  strHisChq := 'EXC.CH ' + Concat(cdsTabela.FieldByName('CHQ_CODBCO').AsString,'-',
                                  cdsTabela.FieldByName('CHQ_NUMAGE').AsString,'-',
                                  cdsTabela.FieldByName('CHQ_CONCOR').AsString,'-',
                                  cdsTabela.FieldByName('CHQ_NUMCHQ').AsString);

  lstBanChq := TBanChqRepository.Create;
  Try
    lstBanChq.fAdd(dbeCodBco.Text,
                   dbeNumAge.Text,
                   dbeConCor.Text,
                   dbeNumChq.Text,
                   dbeCodCli.Text,
                   dbeNomEmi.Text,
                   dbeHist01.Text,
                   dbeHist02.Text,
                   VS_strCodEmp,
                   '',
                   fStrToFloat(dbeValChq.Text));

    Result := fGravaMovBan(fraPlanoDeContasMov.dbeCodCta.Text,   // Centro de Custo
                           dbePorChq.Text,                       // Portador da Baixa
                           strLoginUsuarioLogado,                // Operador da Baixa
                           VS_Date,                              // Data do Lançamento
                           fTime(),                              // Hora do Lançamento
                           dbeNumChq.Text,                       // Numero do Documento
                           'D',                                  // Credito / Debito
                           VS_strCodEmp,                         // Empresa da Baixa
                           fStrToFloat(dbeValChq.Text),          // Valor Do Lançamento
                           strHisChq,                            // Histórico 1
                           '',                                   // Histórico 2
                           '',                                   // Cliente da Duplicata
                           '',                                   // Fornecedor da Duplicata
                           dbeNumChq.Text,                       // Número da Duplicata
                           0,                                    // Sequencial de Baixa
                           '',                                   // Parcela da Duplicata
                           '',                                   // Empresa da Duplicata
                           '',                                   // Série
                           '',                                   // Código do Evento
                           '',                                   // Documento da Baixa
                           lstBanChq.fGetList                    // Log Bancário
                          ) <> '';

  Finally
    FreeAndNil(lstBanChq);
  End;
end;

procedure TfrmCadCheques.pGravaLogChq(acdsDelChq: TUniClientDataSet; strStatus: String);
Var
  repCadChq: TCadChqRepository;
begin
  repCadChq := TCadChqRepository.Create;
  repCadChq.pGravaLog(acdsDelChq.FieldByName('CHQ_CODBCO').AsString, acdsDelChq.FieldByName('CHQ_NUMAGE').AsString,
                      acdsDelChq.FieldByName('CHQ_CONCOR').AsString, acdsDelChq.FieldByName('CHQ_NUMCHQ').AsString,
                      strStatus);
  FreeAndNil(repCadChq);
end;

procedure TfrmCadCheques.pHabilitaBotoes;
begin
  btnDepositoCheque.Enabled := (cdsTabela.State = dsBrowse);

  btnCancelaDeposito.Enabled :=
    (cdsTabela.State = dsBrowse) and
    (fVerificaAcessoSistema('frmCancDepChequePre')) and
    (fChequeEstaDepositado(cdsTabela.FieldByName('CHQ_CODBCO').AsString,
                           cdsTabela.FieldByName('CHQ_NUMAGE').AsString,
                           cdsTabela.FieldByName('CHQ_CONCOR').AsString,
                           cdsTabela.FieldByName('CHQ_NUMCHQ').AsString,
                           cdsTabela.FieldByName('CHQ_CODEMP').AsString));
end;

procedure TfrmCadCheques.pHabilitaBtnTransfCtr;
begin
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnTransfereCtR.Enabled  := False;
  End
  else
  begin
    btnTransfereCtR.Enabled := (Not cdsTabela.IsEmpty) And cdsTabela.Active And
                               (cdsTabela.FieldByName('CHQ_INCCTR').AsString <> 'S') And
                               (
                                (cdsTabela.FieldByName('CHQ_DTADEP').IsNull) And
                                (Not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) Or
                                (
                                 (Not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) And
                                 (cdsTabela.FieldByName('CHQ_DTADP2').IsNull) And
                                 (cdsTabela.FieldByName('CHQ_DTADV2').IsNull)
                                )
                                Or
                                (
                                 (Not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) And
                                 (Not cdsTabela.FieldByName('CHQ_DTADP2').IsNull) And
                                 (Not cdsTabela.FieldByName('CHQ_DTADV2').IsNull)
                                )
                                Or
                                (
                                 (cdsTabela.FieldByName('CHQ_DTADEV').IsNull) And
                                 (cdsTabela.FieldByName('CHQ_DTADP2').IsNull) And
                                 (cdsTabela.FieldByName('CHQ_DTADV2').IsNull) And
                                 (cdsTabela.FieldByName('CHQ_DUPDEP').IsNull) And
                                 (cdsTabela.FieldByName('CHQ_DTADEP').IsNull)
                                )
                               );
  end;
end;

procedure TfrmCadCheques.dbeCodCliEnter(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(strCliente) Then
  Begin
    dbeCodCli.Text := strCliente;
    pCarregaCliente;
  End;
end;

procedure TfrmCadCheques.pMostraDespositoAntetior;
Begin
  dbeCtaDep.DataField                     := 'CHQ_CTADEP';
  fraPlanoDeContasPla.dbeCodCta.DataField := 'CHQ_CODCTA';
  dbeCodPor.DataField                     := 'CHQ_CODPOR';

  If ((Not dbeDtaDv2.Field.IsNull) Or
     ((Not dbeDtaDev.Field.IsNull) And (dbeDtaDp2.Field.IsNull))) And
     (Not qryTabela.FieldByName('CHQ_CDPRSV').AsString.IsEmpty) Then
  Begin
    dbeCtaDep.DataField                     := 'CHQ_CTDPSV';
    fraPlanoDeContasPla.dbeCodCta.DataField := 'CHQ_CDCTSV';
    dbeCodPor.DataField                     := 'CHQ_CDPRSV';
  End;
End;

class procedure TfrmCadCheques.pMostraIniciandoCadastro(fltValLan: Double;
  strHist01: String; dteDataLan: TDate; strCodPor: String;var arrSeqLan: TStringArray);
begin
  pCriarFormularios(TfrmCadCheques, frmCadCheques);
  try
    with frmCadCheques do
    begin
      blnIniciaCadastro := True;
      blnChamadoDoManutencao := True;

      fltValLanLoc  := fltValLan;
      strHist01Loc  := strHist01;
      strCodPorLoc  := strCodPor;
      dteDataLanLoc := dteDataLan;

      RotinaChamada := 'CONCILIAÇÃO DE EXTRATO ELETRÔNICO';

      ShowModal;

      arrSeqLan     := arrSeqLanLoc;
    end;
  except
    On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadCheques.pMostraIniciandoCadastro]');
  end;
  pFreeAndNil(frmCadCheques);
end;

procedure TfrmCadCheques.pRecarregaChequeAberto;
Var
  strAutoincrem : String;
begin
  strAutoincrem  := cdsTabela.FieldByName('AUTOINCREM').AsString;
  if not fEmptyStr(strAutoincrem) then
   begin
    qryTabela.Close;
    qryTabela.SQL.Text := 'SELECT * FROM CADCHQ WHERE AUTOINCREM = ' + strAutoincrem.QuotedString;
    qryTabela.Open;
    pCarregaChq;
   end;
end;
procedure TfrmCadCheques.PreencheZerosCampoCheque;
begin
  If FValorConfiguracaoDigitos <= 0 Then
    Exit;

  If Not dbeNumChq.DataSource.DataSet.Active THen
    Exit;

  If dbeNumChq.DataSource.DataSet.State <> dsInsert Then
    Exit;

  If Not dbeNumChq.Enabled Then
    Exit;

  If fEmptyStr(dbeNumChq.Text) Then
    Exit;

  If Length(Trim(dbeNumChq.Text)) < FValorConfiguracaoDigitos Then
    dbeNumChq.Text := fStrZero(Trim(dbeNumChq.Text), FValorConfiguracaoDigitos);
end;

function TfrmCadCheques.SelecionaPortadorEPlanoDeContasDeDebito: Boolean;
  Var
    LPorCredMovban: TfrmPorCredMovban;
begin
  pCriarFormularios(TfrmPorCredMovban, LPorCredMovban);
  Try
    LPorCredMovban.Caption := 'Dados para débito no Movimento Bancário';

    LPorCredMovban.rdgTipoCheque.ItemIndex := 0;
    If cdsTabela.FieldByName('CHQ_DTACAD').AsString <> cdsTabela.FieldByName('CHQ_DTAVEN').AsString Then
      LPorCredMovban.rdgTipoCheque.ItemIndex := 1;

    LPorCredMovban.rdgTipoCheque.Enabled := False;
    LPorCredMovban.edtCodPorBai.Text := strCodPor;
    LPorCredMovban.fraPlanoDeContas.MskCodCta.Text := strCodCta;
    LPorCredMovban.TipoLancamento := 'débito';
    LPorCredMovban.ShowModal;

    Result := LPorCredMovban.blnConfirma;
    If Not Result Then
      Exit;

    Result := fEmpresaTemAcessoPortador(LPorCredMovBan.edtPorBai.Text);

    If Not Result Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso". Operação cancelada.', ['&Ok']);
      Exit;
    End;

    strCodPor := LPorCredMovBan.edtPorBai.Text;
    strCodCta := LPorCredMovBan.fraPlanoDeContas.MskCodCta.Text;
  Finally
    FreeAndNil(LPorCredMovBan);
  End;
end;

procedure TfrmCadCheques.pDesabilitaChequesDevolvidos;
begin
  If (Not dbeDtaDv2.Field.IsNull) Or
     (Not fEmptyStr(cdsTabela.FieldByName('CHQ_DUPDEP').AsString)) Then
  Begin
    btnAlterar.Enabled         := False;
    btnExcluir.Enabled         := False;
    btnCorrigeCheque.Enabled   := False;
    btnHistorico.Enabled       := True;
    btnHistReceb.Enabled       := True;
    btnTransfereCtR.Enabled    := False;
  End Else
  Begin
    btnAlterar.Enabled       := (cdsTabela.State <> dsEdit) And (cdsTabela.State <> dsInsert);
    btnExcluir.Enabled       := (cdsTabela.State <> dsEdit) And (cdsTabela.State <> dsInsert);
    btnCorrigeCheque.Enabled := True;
    btnHistorico.Enabled     := True;
    btnHistReceb.Enabled     := True;

   pBaixaCaixaSemTransf;
  End;

  pMostraDespositoAntetior;
end;

{******************************************}
{* CHEQUES RECEBIDOS PELO CAIXA NÃO PODEM *}
{* SER EXCLUIDOS                          *}
{REQ45200*******************************LE*}
procedure TfrmCadCheques.pBaixaCaixaSemTransf;
begin
  If Not Assigned(qryTabela) Then
    Exit;

  If (Not LancamentoVeioDoCaixaEEstaFechado) Then
  Begin
    btnAlterar.Enabled         := False;
    btnExcluir.Enabled         := False;
    btnCorrigeCheque.Enabled   := False;
    btnHistorico.Enabled       := False;
    btnHistReceb.Enabled       := False;
    btnTransfereCtR.Enabled    := False;
    btnCancelTransfCtR.Enabled := False;
  End
  Else
  Begin
    btnAlterar.Enabled       := qryTabela.FieldByName('CHQ_INCCTR').AsString <> 'S';
    btnExcluir.Enabled       := qryTabela.FieldByName('CHQ_INCCTR').AsString <> 'S';
    btnCorrigeCheque.Enabled := qryTabela.FieldByName('CHQ_INCCTR').AsString <> 'S';
    btnHistorico.Enabled     := qryTabela.FieldByName('CHQ_INCCTR').AsString <> 'S';
    btnHistReceb.Enabled     := qryTabela.FieldByName('CHQ_INCCTR').AsString <> 'S';
  End;

  HabilitaAlteracaoLiberacaoCaixas;
end;

procedure TfrmCadCheques.btnHistoricoClick(Sender: TObject);
begin

  inherited;

  If cdsTabela.IsEmpty Then
  Begin
    fMensagem('', 'Não é possível realizar essa operação em um arquivo vazio!', ['&O k']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(135, 6195, [],
                        ['AUTINC'],
                        [cdsTabela.FieldByName('AUTOINCREM').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadCheques.chkLeitorClick(Sender: TObject);
begin
  inherited;
  If chkLeitor.Checked Then
    chkInfMan.Checked := FALSE;

  edtCheque.Visible := False;
  lblCheque.Visible := False;
  edtCheque.Enabled := False;
  If (chkLeitor.Checked) Then
  Begin
    edtCheque.Visible := True;
    lblCheque.Visible := True;
    edtCheque.Enabled := True;
    blnDigLei         := True;
    pSetFocus(edtCheque);
  End
  Else
  Begin
    if Not blnResumida Then
      pSetFocus(btnIncluir)
    Else
      pSetFocus(dbeCodBco);
  End;
end;

procedure TfrmCadCheques.edtTotDigChange(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmCadCheques.pModCheque1;
  Var
    blnVerifica: Boolean;
begin
  strCheque := Trim(edtCheque.Text);
  blnVerifica := True;
  blnVerificaCheque := True;
  //********************************************//
  // VERIFICA SE A LEITORA DE CHEQUES RETORNOU  //
  // INFORMAÇÕES VÁLIDAS. A STRING DEVER SER    //
  // DIFERENTE DE "!" E NÃO PODE ESTA EM BRANCO //
  //*****************************************ED*//
  If (strCheque = '!') Or
     fEmptyStr(strCheque) Then
  Begin
    fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
    edtCheque.SelectAll;
    pSetFocus(edtCheque);
    blnVerifica := False;
    blnVerificaCheque := blnVerifica;
  End;

  If blnVerifica Then
  Begin

    strCodBan := '';
    strNumChq := '';
    strConCor := '';
    strNumAge := '';

    //*************************************//
    // VERIFICA SE O PRIMEIRO CARACTER DA  //
    // STRING E IGUAL A "<" E O ÚLTIMO     //
    // CARACTER E IGUAL A "?". SE SIM      //
    // ENTAO QUER DIZER QUE A LEITURA ESTÁ //
    // CORRETA                             //
    //**********************************ED*//
    If chkInfMan.Checked Or
       ((LeftStr(strCheque, 1) = '<') And
        (RightStr(strCheque, 1) = ':')) Then
    Begin

      If chkInfMan.Checked Then
      Begin
        strCodBan := Copy(strCheque, 01, 03);
        strNumChq := Copy(strCheque, 12, 06);

        strNumAge := Copy(strCheque, 04, 04);

        If (strCodBan = '341') Or (strCodBan = '399') Then
          strConCor := Copy(strCheque, 24, 06)
        Else If strCodBan = '104' Then
          strConCor := Copy(strCheque, 21, 09)
        else if strCodBan = '033' Then
          strConCor := Copy(strCheque, 22, 02) + '0' + Copy(strCheque, 24, 06)
        Else If strCodBan = '001' Then
          strConCor := IfThen(Copy(strCheque, 23, 01) <> '0', Copy(strCheque, 23, 07), Copy(strCheque, 24, 06))
        Else
          strConCor := Copy(strCheque, 23, 07);


        Insert('-',strConCor,Length(strConCor));
      End Else
      Begin
        strCodBan := Copy(strCheque, 02, 03);
        strNumChq := Copy(strCheque, 14, 06);

        strNumAge := Copy(strCheque, 05, 04);

        If (strCodBan = '341') Or (strCodBan = '399') Then
          strConCor := Copy(strCheque, 27, 06)
        Else If strCodBan = '104' Then
          strConCor := Copy(strCheque, 24, 09)
        else if strCodBan = '033' Then
          strConCor := Copy(strCheque, 25, 02) + '0' + Copy(strCheque, 27, 06)
        Else If strCodBan = '001' Then
          strConCor := IfThen(Copy(strCheque, 26, 01) <> '0', Copy(strCheque, 26, 07), Copy(strCheque, 27, 06))
        Else
          strConCor := Copy(strCheque, 26, 07);
        Insert('-',strConCor,Length(strConCor));
      End;

      If fCfgSis('MODCHQ') = '1' Then
      Begin
        edtCheque.Visible := False;
        lblCheque.Visible := False;
      End

    End
    Else
    Begin
      fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
      edtCheque.SelectAll;
      pSetFocus(edtCheque);
      blnVerificaCheque := False;
    End;

  End;
end;

procedure TfrmCadCheques.pModCheque2;
  Var
    blnVerifica: Boolean;
begin
  strCheque   := Trim(edtCheque.Text);
  blnVerifica := True;
  blnVerificaCheque := True;
  //********************************************//
  // VERIFICA SE A LEITORA DE CHEQUES RETORNOU  //
  // INFORMAÇÕES VÁLIDAS. A STRING DEVER SER    //
  // DIFERENTE DE "!" E NÃO PODE ESTA EM BRANCO //
  //*****************************************LB*//
  If (strCheque = '!') Or
     fEmptyStr(strCheque) Then
  Begin
    fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
    edtCheque.SelectAll;
    pSetFocus(edtCheque);
    blnVerifica := False;
    blnVerificaCheque := blnVerifica;
  End;

  If blnVerifica Then
  Begin

    strCodBan := '';
    strNumChq := '';
    strConCor := '';
    strNumAge := '';

    If chkInfMan.Checked Or
      ((LeftStr(strCheque, 1) = '<') And (Length(Trim(strCheque)) = 34)) Then
    Begin

      If chkInfMan.Checked Then
      Begin
        strCodBan := Copy(strCheque, 01, 03);
        strNumChq := Copy(strCheque, 12, 06);
        strConCor := Copy(strCheque, 24, 08);
        Insert('-',strConCor,8);
        strNumAge := Copy(strCheque, 04, 04);
      End Else
      Begin
        strCodBan := Copy(strCheque, 02, 03);
        strNumChq := Copy(strCheque, 14, 06);
        strConCor := Copy(strCheque, 24, 09);
        strNumAge := Copy(strCheque, 05, 04);
      End;

      If fCfgSis('MODCHQ') = '2' Then
      Begin
        edtCheque.Visible := False;
        lblCheque.Visible := False;
      End

    End
    Else
    Begin
      fMensagem('', 'Os dados do cheque não são válidos!', ['&O k']);
      edtCheque.SelectAll;
      pSetFocus(edtCheque);
      blnVerificaCheque := False;
    End;

  End;
end;

function TfrmCadCheques.fDadosChequeAnterior:Boolean;
begin
  Result := True;
  With recInclusao Do
  Begin
    cdsTabela.FieldByName('CHQ_CODBCO').AsString := strCodCbo;
    cdsTabela.FieldByName('CHQ_NUMAGE').AsString := strNumAge;
    cdsTabela.FieldByName('CHQ_CONCOR').AsString := strConCor;
    cdsTabela.FieldByName('CHQ_CODCLI').AsString := strCodCli;

    If fEmptyStr(strConPag) Then
      cdsTabela.FieldByName('CHQ_DTAVEN').AsString := strDtaVen;
      
    cdsTabela.FieldByName('CHQ_DTACAD').AsString := strDtaCad;
    cdsTabela.FieldByName('CHQ_HIST01').AsString := strHist01;
    cdsTabela.FieldByName('CHQ_HIST02').AsString := strHist02;
    cdsTabela.FieldByName('CHQ_CODEMP').AsString := strCodEmp;
  End;
End;

function TfrmCadCheques.fDefinePortCta: Boolean;
Var
  qryGer: TUniQuery;
  strTipChq: String;

  LDadosVazios: Boolean;
Begin
  strTipChq := 'CHP';
  If qryTabela.FieldByName('CHQ_DTACAD').AsDateTime = qryTabela.FieldByName('CHQ_DTAVEN').AsDateTime Then
    strTipChq := 'CHV';

  If cdsTabela.FieldByName('CHQ_DTADEP').IsNull Then
  Begin
    strCodPor := cdsTabela.FieldByName('CHQ_PORCHQ').AsString;
    strCodCta := cdsTabela.FieldByName('CHQ_CTACHQ').AsString;

    LDadosVazios := cdsTabela.FieldByName('CHQ_PORCHQ').AsString.IsEmpty;
    If Not LDadosVazios Then
      LDadosVazios := cdsTabela.FieldByName('CHQ_CTACHQ').AsString.IsEmpty;

    Result := Not LDadosVazios;

    If Result Then
      Exit;
  End;

  qryGer := fCriaQuery;
  Try
    qryGer.SQL.Clear;
    qryGer.SQL.Add('SELECT                    ');
    qryGer.SQL.Add('  CTB_CODPOR,             ');
    qryGer.SQL.Add('  CTB_CODCTA              ');
    qryGer.SQL.Add('FROM                      ');
    qryGer.SQL.Add('  MOVBAN                  ');
    qryGer.SQL.Add('WHERE CTB_SEQTRF = :SEQTRF');
    qryGer.SQL.Add('  AND CTB_CODEMP = :CODEMP');
    qryGer.SQL.Add('  AND CTB_HIST01 LIKE ''TF CAIXA%%(' + strTipChq + ') - %''');

    qryGer.ParamByName('SEQTRF').AsInteger := qryTabela.FieldByName('CHQ_SEQTRF').AsInteger;
    qryGer.ParamByName('CODEMP').AsString  := qryTabela.FieldByName('CHQ_CODEMP').AsString;
    qryGer.Open;

    strCodPor := qryGer.FieldByName('CTB_CODPOR').AsString;
    strCodCta := qryGer.FieldByName('CTB_CODCTA').AsString;

    Result := not qryGer.IsEmpty;
  Finally
    FreeAndNil(qryGer);
  End;
End;

function TfrmCadCheques.fDigDadosPagamento(var strCodFor, strCta_Pg,
  strCodEve: String): Boolean;
  Var
    frmRcxDigPagamento : TfrmRcxDigPagamento;
begin
  Try
    pCriarFormularios(TfrmRcxDigPagamento, frmRcxDigPagamento);
    frmRcxDigPagamento.edtCodFor.Text := strCodFor;
    frmRcxDigPagamento.pCarregaFornecedor;
    frmRcxDigPagamento.edtCodFor.Enabled := False;
    frmRcxDigPagamento.ShowModal;
    Result := frmRcxDigPagamento.blnConfirma;
    If (Result) Then
    Begin
      strCodFor := frmRcxDigPagamento.edtCodFor.Text;
      strCta_Pg := frmRcxDigPagamento.fraPlanoDeContas.mskCodCta.Text;
      strCodEve := frmRcxDigPagamento.fraCentroCusto.edtCodEve.Text;
    End
    Else
    Begin
      strCodFor := '';
      strCta_Pg := '';
      strCodEve := '';
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadCheques.fDigDadosPagamento]');
    End;
  End;
  pFreeAndNil(frmRcxDigPagamento);
end;

procedure TfrmCadCheques.chkInfManClick(Sender: TObject);
begin
  inherited;
  If chkInfMan.Checked Then
    chkLeitor.Checked := FALSE;

  edtCheque.Visible := False;
  lblCheque.Visible := False;
  edtCheque.Enabled := False;
  If (chkInfMan.Checked) Then
  Begin
    edtCheque.Visible := True;
    lblCheque.Visible := True;
    edtCheque.Enabled := True;
    blnDigLei         := True;
    pSetFocus(dbeCodBco);
  End
  Else
  Begin
    If Not blnResumida Then
    Begin
      pSetFocus(btnIncluir);
    End
    Else
    Begin
      pSetFocus(dbeCodBco);
    End;
  End;
end;

procedure TfrmCadCheques.pAfterScroll(DataSet: TDataSet);
  Var
    strDoc: String;
    strDocumento: String;
Begin
  If Not blnResumida Then
    strDocumento := cdsTabela.FieldByName('CHQ_DOCUME').AsString
  Else
    strDocumento := strDocume;

  strDocumento := AnsiReplaceStr(strDocumento, '-', '');

  strDoc := copy(strDocumento, 1, 3);

  edtDesPorChq.Text := fRetNomPortador(cdsTabela.FieldByName('CHQ_PORCHQ').AsString);

  If (Not fEmptyStr(strDoc)) And (strDoc <> 'DIV') Then
  Begin
    strDoc := copy(strDocumento, 6, 1);
    If (strDoc <> '-') And (Pos('AG', strDocumento) <= 0) Then
    Begin
      If Length(strDocumento) = 14 Then
        cdsTabela.FieldByName('CHQ_DOCUME').EditMask := '999999999999-ll-999-lll;0;_'
      Else
        cdsTabela.FieldByName('CHQ_DOCUME').EditMask := '999999999999l-ll-999-lll;0;_';
    End
    Else
      cdsTabela.FieldByName('CHQ_DOCUME').EditMask := '';
  End
  Else
    cdsTabela.FieldByName('CHQ_DOCUME').EditMask := '';

End;

procedure TfrmCadCheques.dbeDtaDevExit(Sender: TObject);
begin
  inherited;
  If cdsTabela.FieldByName('CHQ_DTADEV').Value <> null then
     dbeMotDev.Enabled := True;
end;

procedure TfrmCadCheques.dbeDtaDV2Exit(Sender: TObject);
begin
  inherited;
  If cdsTabela.FieldByName('CHQ_DTADV2').Value <> null then
  begin
     dbeMotDv2.Enabled := True;
     pSetFocus(dbeMotDv2);
  end;
end;

procedure TfrmCadCheques.dbeDtaVenExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeDtaVen, True);
end;

procedure TfrmCadCheques.dbeNumCgcChange(Sender: TObject);
begin
  inherited;
  blnLiberaDebito := False;
end;

procedure TfrmCadCheques.dbePorChqKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqPortador(conSimples, Self, dbePorChq, edtDesPorChq, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbePorChq) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCheques.dbeTelCheExit(Sender: TObject);
begin
  inherited;
  dbeTelNum.Enabled := dbeTelChe.Enabled And (dbeTelChe.Text = 'S');
end;

procedure TfrmCadCheques.DesabilitaAlteracaoLiberacaoCaixas;
begin
  If Not FLiberacaoTransferencias Then
    Exit;

  If qryTabela.IsEmpty Then
    Exit;

  If qryTabela.FieldByName('CHQ_TRFLIB').AsString <> 'N' Then
    Exit;

  If FRotina = 'LIBERAÇÃO TRANSFERÊNCIAS' Then
    Exit;

  btnPesquisa.Enabled := True;
  btnIncluir.Enabled := True;
  btnHistRecebLog.Enabled := True;

  btnAlterar.Enabled := False;
  btnCorrigeCheque.Enabled := False;
  btnExcluir.Enabled := False;
  btnImprimir.Enabled := False;
  btnDepositoCheque.Enabled := False;
  btnCancelaDeposito.Enabled := False;
  btnAltPortador.Enabled := False;
  btnTransfereCtr.Enabled := False;
  btnCancelTransfCtR.Enabled := False;
  btnHistReceb.Enabled := False;
  btnHistorico.Enabled := False;

  fMensagem('ATENÇÃO', 'O cheque não pode ser alterado pois a transferência não foi liberada.', ['&Ok']);
end;

procedure TfrmCadCheques.dbeDevDefClick(Sender: TObject);
begin
  inherited;
  If dbeDevDef.Checked Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(dbeDtaDev.Text)) Then
    Begin
      dbeDevDef.Checked := False;
    End;
  End;
end;

procedure TfrmCadCheques.dbeDevDefExit(Sender: TObject);
begin
  inherited;
  If (cdsTabela.State in [dsInsert, dsEdit]) And
     ((Not dbeDtaDev.Field.IsNull) Or (Not dbeDtaDV2.Field.IsNull)) And
     ((Not dbeForRep.Field.IsNull) And (Not fEmptyStr(dbeForRep.Field.Value))) And
     (Not dbeDevDef.Checked) Then
  Begin
    dbeDevDef.Checked := True;
    dbeDevDef.Field.Value := dbeDevDef.ValueChecked;
    fMensagem('', 'A devolução definitiva deve permanecer marcada, pois o cheque devolvido já foi repassado ao fornecedor!', ['&OK']);
  End;
end;


procedure TfrmCadCheques.btnHistRecebClick(Sender: TObject);
begin

  inherited;

  If (cdsTabela.IsEmpty) Or (cdsTabela.State = dsInsert) Then
  Begin
    fMensagem('', 'Não é possível realizar essa operação em um arquivo vazio!', ['&O k']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(92, 5601, [],
                        ['CODBCO','NUMAGE','CONCOR','NUMCHQ','CODEMP'],
                        [dbeCodBco.Text,
                        dbeNumAge.Text,
                        dbeConCor.Text,
                        dbeNumChq.Text,
                        Vs_StrCodEmp],
                        Sender,
                        nil,
                        True);
  End;

end;


procedure TfrmCadCheques.btnHistRecebLOGClick(Sender: TObject);
Var
   frmRelChqLogAcomp: TfrmRelChqLogAcomp;
begin

  inherited;

  If (cdsTabela.IsEmpty) Or (fEmptyStr(dbeCodBco.Text))Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelChqLogAcomp, frmRelChqLogAcomp);
    frmRelChqLogAcomp.edtCodBco.Text          := cdsTabela.FieldByName('CHQ_CODBCO').AsString;
    frmRelChqLogAcomp.edtAgencia.Text         := cdsTabela.FieldByName('CHQ_NUMAGE').AsString;
    frmRelChqLogAcomp.edtConCor.Text          := cdsTabela.FieldByName('CHQ_CONCOR').AsString;
    frmRelChqLogAcomp.edtNumChq.Text          := cdsTabela.FieldByName('CHQ_NUMCHQ').AsString;
    frmRelChqLogAcomp.blnVeioManutencao  := True;
    frmRelChqLogAcomp.pCarregaCampos;
    if frmRelChqLogAcomp.qryConsulta.IsEmpty then
      fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k'])
    else
      frmRelChqLogAcomp.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmRelChqLogAcomp.btnHistRecebLOG]');
  End;
  pFreeAndNil(frmRelChqLogAcomp);
end;

{*************************************************}
{ MOSTRA A OBS DO CLIENTE DEFINIDO NO CAD. CHEQUE }
{**********************************************JB*}
procedure TfrmCadCheques.pMostraObsCliente;
  Var
    qryGenCli: TUniQuery;
begin
  Try
    qryGenCli := fCriaQuery(Self);

    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  CLI_OBSERV AS OBSERV ');
      SQL.Add('FROM ');
      SQL.Add('  CADCLI ');
      SQL.Add('WHERE ');
      SQL.Add('  CLI_CODCLI = :CODCLI AND ');
      SQL.Add('  CLI_OBSERV IS NOT NULL   ');
      ParamByName('CODCLI').AsString := dbeCodCli.Text;
      Open;

      If (fEmptyStr(FieldByName('OBSERV').AsString)) Or
         (Not (fCfgSis('EXOBSC', varBoolean))) Then
        Exit;

      Try
        pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
        frmFatMostraObsCliente.memObserv.Texto := FieldByName('OBSERV').AsString;
        frmFatMostraObsCliente.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pMostraObsCliente]');
        End;
      End;
      pFreeAndNil(frmFatMostraObsCliente);

    End;

  Finally
    FreeAndNil(qryGenCli);
  End;
end;


function TfrmCadCheques.fExisteSegundaDevolução(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;

begin
  Try

    Result := False;

    qryGenChq := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + strTabCheque + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CHQ_NUMAGE = :NUMAGE AND ';
    strSQL := strSQL + '  CHQ_CONCOR = :CONCOR AND ';
    strSQL := strSQL + '  CHQ_NUMCHQ = :NUMCHQ AND ';
    strSQL := strSQL + '  CHQ_DTADV2 IS NOT NULL; ';

    With qryGenChq Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('NUMAGE').AsString := strNumAge;
      ParamByName('CONCOR').AsString := strConCor;
      ParamByName('NUMCHQ').AsString := strNumChq;
      Open;
      If FieldByName('QTD').AsInteger > 0 Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenChq);
  End;

end;

procedure TfrmCadCheques.pImprimeComprovante;
  Var
    strNomImp: String;
    strTipImp: String;
    frxDoc: TfrxReport;
    qryCfgRel: TUniQuery;
Begin

  qryCfgRel := fCriaQuery(Self);
  pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;
  FreeAndNil(qryCfgRel);

  Try

    Try

      If strTipImp = 'M' Then
           frxDoc := frxChqPreM
      Else frxDoc := frxChqPreJ;

      If fMensagem('', 'Imprimir comprovante de Cheque sem Fundo?', ['&Sim', '&Não']) = 1 Then
      Begin

        frxDoc.Script.Variables['NOMBCO'] := edtNomBan.Text;
        frxDoc.Script.Variables['NOMCLI'] := edtNomCli.Text;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxDoc.PrintOptions.Printer    := strNomImp;
          frxDoc.PrintOptions.PrintMode  := pmDefault;
          frxDoc.PrintOptions.ShowDialog := False;

          If frxDoc.PrepareReport Then
            pPrintReport(Self.Name, Self.Caption + ' (Comprovante)', strNomImp, frxDoc);
        End
        Else
          pPreviewReport(Self.Name, Self.Caption + ' (Comprovante)', frxDoc);

      End;

    Except
      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmCadCheques.pImprimeComprovante]');
      End;
    End;

  Finally
    pnlInfo.Caption := '';
  End;

End;

function TfrmCadCheques.fTransfereChqReceber: Boolean;
  Var
    LMensagemPortador: Integer;
Begin

  Result := True;

  If ((dbeDtaDep.Field.IsNull) Or
      ((Not cdsTabela.FieldByName('CHQ_DTADEV').IsNull) And
       (cdsTabela.FieldByName('CHQ_DTADP2').IsNull) And
       (cdsTabela.FieldByName('CHQ_DTADV2').IsNull)) )

  Or

     (( (Not dbeDtaDep.Field.IsNull) And dbeDtaDp2.Field.IsNull ) Or
      ((Not cdsTabela.FieldByName('CHQ_DTADV2').IsNull))) Then
  Begin
    //FECHAMENTO FINANCEIRO
    {* ALTERADO VALIDAÇÃO DE FECHAMENTO FINANCEIRO *************************}
    {* AGORA SERÁ VALIDADO A DATA ATUAL(DATA QUE SERA GERADO O FINANCIERO) *}
    {* SOLICITADO NO REQUISITO: 342838 *************************************}

    if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, VS_Date) then
    begin
      Result := False;
      Exit;
    end;

    If cdsTabela.FieldByName('CHQ_INCCTR').AsString = 'S' Then
    Begin
      Result := False;
      Exit;
    End;

    Try
      if not fCarregaPortadorEVendedorContaReceber then
      begin
        Result := False;
        Exit;
      end;

      blnDefinePortCta := fDefinePortCta();

      If Not blnDefinePortCta Then
      Begin
        LMensagemPortador := fMensagem('Confirmação', 'Não foi possível definir um portador/plano de contas para debitar o valor do cheque. ' +
                                                      'Deseja selecionar o portador/plano de contas para gerar o lançamento de débito?',
                                                      ['&Sim', '&Não'], 1);

        Result := LMensagemPortador = 1;
        If Not Result Then
        Begin
          If fMensagem('Confirmação', 'Não foi selecionado um portador/plano de contas para debitar o valor do cheque. ' +
                                      'O lançamento de débito não será realizado.' + #13 +
                                      'Deseja realmente continuar?',
                       ['&Sim', '&Não'], 1) = 2 Then
            Exit;

          Result := True;
        End;

        blnDefinePortCta := LMensagemPortador = 1;

        If Not blnDefinePortCta Then
        Begin
          strCodPor:='';
          strCodCta:='';
        End
        Else
        Begin
          Result := SelecionaPortadorEPlanoDeContasDeDebito;

          blnDefinePortCta := Result;
        End;

        If Not Result Then
          Exit;
      End;

      fStartTransaction;
      strNumDup := '';
      strMsgErr := '';

      Result := fGravaCadRecCheque(True);

      If Result Then
        Result := fGravaMovBanTransferenciaContasReceber('D');

      If Result Then
      Begin

        With cdsTabela Do
        Begin
          Edit;

          FieldByName('CHQ_INCCTR').AsString := 'S';
          FieldByName('CHQ_DTATRA').AsDateTime := VS_Date;
          FieldByName('CHQ_DUPDEP').AsString   := fStrZero(strNumDup, fTamDocCadRec) + '-A-0-CH-' +
                                                  FieldByName('CHQ_CODEMP').AsString + '-' + FieldByName('CHQ_CODCLI').AsString;
          Post;
        End;

        pGravaLogChq(cdsTabela, 'TRANSF. CHEQUE PARA CNT. REC. (frmCadCheques.fTransfereChqReceber)');

      End;

      strNumDup := '';

      If Result Then
        fCommit
      Else fRollBack;

      if strMsgErr <> '' then
      begin
        fMensagem('Atenção', 'Ocorreram os seguintes erros: ' + #13 +
                              strMsgErr ,['&OK']);
      end;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message,'[TfrmCadCheques.fLimpaDadosBaixa]');
      End;
    End;

  End;

end;

function TfrmCadCheques.fPermiteAlterarVindoDoCaixa: Boolean;
begin
  Result := LancamentoVeioDoCaixaEEstaFechado;
end;

procedure TfrmCadCheques.fraPlanoDeContasMovdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;

  If fPesqCentroCusto(Self, fraPlanoDeContasMov.dbeCodCta, fraPlanoDeContasMov.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(fraPlanoDeContasMov.dbeCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;

end;

procedure TfrmCadCheques.AtualizaNaoDep;
Begin
  dbcNaoDep.ReadOnly := not ( (fEmptyDate(dbeDtaDep.Text)) Or
                              ( (not fEmptyDate(dbeDtaDev.Text)) And fEmptyDate(dbeDtaDp2.Text)) );
End;

end.

