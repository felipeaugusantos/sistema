unit untFatFormulacaoItens;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Math,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, untFuncoesSimples,
  ExtCtrls, Grids, DBGridCitel, DBGrids, StrUtils, DB, frxClass, Uni, AppEvnts, untFuncoesEtiquetas,
  MemoFocus, frxBarcode, frxDBSet, untZClient, untTypesSistema, TypesRel, IOUtils,
  BitBtnLockedIncrem, Mask, MaskEditFocus, frxExportCSVTestabilidade, untTipoTinta,
  UniClientDataSet, EditFocus, System.UITypes,
  Winapi.PsAPI, untTThreadNotificacao, System.ImageList, Vcl.ImgList, DateUtils,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox,
  untFuncTinta, untMovGer, untIFatOrdProTintaMaquina, untFatOrdProTintaMaquina,
  untFatDefineLotesPedidoWMSWrapper, untIFatDefineLotesPedidoWMS, untTransferencias,
  untITransferencias, untIFuncoesCRM, untFuncoesCRM, untAuditoriaGravacaoSaldo;

const
  cnstEspTinDet: String = 'NF_IF_PA_EP_FF_UC_';

type
  TfrmFatFormulacaoItens = class(TfrmPaiSimples)
    frxEtiqueta: TfrxReport;
    Panel1: TPanel;
    pnlCab: TPanel;
    rdgTipTin: TRadioGroup;
    dbgItens: TDBGridCitel;
    pnlBotoesFor: TPanel;
    frxBarCodeObject1: TfrxBarCodeObject;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Shape3: TShape;
    btnImprimir: TBitBtnLocked;
    btnBaixar: TBitBtnLocked;
    btnAtualizar: TBitBtnLocked;
    btnBaiTin: TBitBtnLocked;
    btnImpOrd: TBitBtnLocked;
    btnAltTipTin: TBitBtnLocked;
    btnApagar: TBitBtnLocked;
    btnCancelarForm: TBitBtnLocked;
    btnImpEtiqProd: TBitBtnLocked;
    gpbPeriodo: TGroupBox;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    btnCarregBaixa: TBitBtnLocked;
    btnDesmBaixa: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    tmrTmpOci: TTimer;
    tmrAtuFti: TTimer;
    memMenFor: TMemoFocus;
    lblSitFin: TLabel;
    btnExportarRegistros: TBitBtnLocked;
    pnlObsColorista: TPanel;
    dtsTinMaq: TDataSource;
    Label1: TLabel;
    edtObsColorista: TEdit;
    rdgTipoFormula: TRadioGroup;
    btnImpSep: TBitBtnLocked;
    btnRealizarAjuste: TBitBtnLocked;
    btnImpAjuste: TBitBtnLocked;
    imglSitFin: TImageList;
    cmbSitFin: TcxImageComboBox;
    btnPesquisar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarFormClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAltTipTinClick(Sender: TObject);
    procedure rdgTipTinClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnBaiTinClick(Sender: TObject);
    procedure btnImpOrdClick(Sender: TObject);
    procedure btnImpEtiqProdClick(Sender: TObject);
    procedure btnCarregBaixaClick(Sender: TObject);
    procedure btnDesmBaixaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure dbgItensTitleClick(Column: TColumn);
    procedure tmrAtuFtiTimer(Sender: TObject);
    procedure tmrTmpOciTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmbSitFinClick(Sender: TObject);
    procedure btnExportarRegistrosClick(Sender: TObject);
    procedure btnImpSepClick(Sender: TObject);
    procedure btnRealizarAjusteClick(Sender: TObject);
    procedure btnImpAjusteClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    { Private declarations }
    FFiltroCodIte,
    FFiltroCodCli,
    FFiltroNumDoc,
    FFiltroDocFat,
    FFiltroDtaCad: String;

    cdsTinMaq : TUniClientDataSet;
    qryFormul : TUniQuery;
    dtsFormul : TDataSource;
    intColAtu : Integer;

    strNomImp,
    strNomPro,
    strDesPro,
    strCfgExi: String;

    qryImpressao: TUniQuery;
    cpuCampos : TCamposUso;
    strTabFor : String;
    intQtdSel : Integer;
    VS_strCliFilLocal: String;
    FDiasData: Integer;

    DataDigEntrada : TDateTime;
    {*****************************************}
    {* MATRIZ QUE REPRESENTARÁ 1 LINHA DE    *}
    {* ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  *}
    {* COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS *}
    {**************************************MV*}
    arrLinhasEti: Array Of String;

    ftiDadosEtiq: TFormulEtiq;

    blnNOTFTI: Boolean;
    intATUFTI: Integer;
    intTMPOCI: Integer;
    intDURNOT: Integer;
    thrNotificacao: TThreadNotificacao;

    objImpOrdPro: IFatOrdProTintaMaquina;
    objLotePedidoWMS: IFatDefineLotesPedidoWMS;
    objTransfere: ITransferencias;
    objFuncoesCRM: IFuncoesCRM;

    blnSTFNTI : Boolean;

    blnUsaRotinaWMS: Boolean;
    blnUsaWMSRastreavel: Boolean;
    dicRetorno: TDicionario;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    procedure pMarcarBaixa;

    function fRetTintas: String;
    Function fBaixaTintas(strTintas, strCodOpe: String): Boolean;
    Function fBaixaFormulacao(strCodOpe: String; var strMsg: String; blnImprimiuEtiqEnt : Boolean = true ): Boolean;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;

    function fRetTabela : String;
    function fRetQuantidadeDevolucao : String;

    function fValidarDtEntrada(strDtaIni, strDtaFim : String) : Boolean;

    procedure pAtualizaDados(DataSet: TDataset);
    procedure pMostraFormulacoes;
    function fImpEtiquetasMatricial: Boolean;
    function fImpRegistro: Boolean;

    procedure pMudarTipoTinta;

    procedure pImpArrLinhasEti;
    function fBaixarColorantes: Boolean;
    procedure pAtualizaMovDetMls(Var stlDetMLs: TStringList; strCodAca, strEmpAca, strEspDoc: String);

    function fImprimeEtiquetaEntrega(strOperador: String = '') : boolean;


    function fRetSQLOrdemProdAvulsa : String;
    function fRetSQLVendasDiretas: String;
    function fRetSQLEmprestimos : String;

    function GravaTabelaDel(AFormulario, ATabela: String; ARegistroDeletado: TDataSet; strCodOpe: String): Boolean;
    procedure pApagarFormulacao;
    Procedure pRealizaExclusao(strCodOpe: String);
    Procedure pRealizarExclusaoFormulaTindorPorParte(strTblGer, strTblDet, strPreDet, strCodOpe: String);
    Procedure pRealizarExclusaoFormulaTindorCompleta(strTblGer, strTblDet, strPreDet, strCodOpe: String);
    procedure pImprimeEtiquetaFormulacao(strOperador: String);
    procedure pImprimeEtiquetaProducao;

    procedure pCriaTempEtiqFormulacao;
    procedure pAtualizaTempEtiqFormulacao;
    procedure pAdicionaFormulacoes(strAutInc: String);
    procedure pDeletaTempEtiFormulacao;

    function fVerificaCtrEmAberto: Boolean;

    procedure pChamaFormularioDadosEtiqProducao;
    function fEnt_Cd(qryTinDet: TDataSet): Boolean;
    procedure pDesmarcaBaixado;

    procedure pAddProgresso(strStatus: String);

    function fProdForaLojaFGO(qryTinDet: TDataSet): Boolean;
    function fProdForaLojaGER(qryTinDet: TDataSet): Boolean;
    function fProdForaLojaEntregaFutura(qryTinDet: TDataSet): Boolean;

    function fCupomPendenteCancelamento: Boolean;

    function fFormulacaoJaBaixada(strAutInc: String): Boolean;
    procedure pBaixaFormulacaoDocVenda(qryTinDet: TDataSet; strCodOpe: String);
    function fTinDetBaixado(strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca: String): Boolean;
    function fTinDorBaixado(strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca: String): Boolean;
    function fExpedicaoFaturada(qryTinDet: TDataSet) : Boolean;

    function fEspecieTE: String;

    procedure fBaixaDocumentoFuturo(strBaixar : String);

    procedure pInicializarNoticacoes;
    procedure pHabilitarNotificacoes(blnAtivar: Boolean);
    procedure pGerarThreadNotTinDisp;
    procedure pFinalizarThreadNotTinDisp(blnAtivarTimer: Boolean);

    function fExibeMensagemTintaNaoEncontrada: Boolean;

    function fRetornaSQLTindetBaixad: String;
    function fRetornaSQLTindetDesmarcaBaixad(qryTinDet: TDataSet): String;
    function fSituacaoFinanceiraPedidoOk(var strPenFin: String): Boolean;
    function fPermiteProsseguirAcao: Boolean;
    function fConferenciaPorCodigoBarras: Boolean;
    function fRotinaWMSComProdutoRastreavel(qryTinDet: TDataSet): Boolean;
    function fItemRastreavel(strCodItem : String) : Boolean;

    function fLoteInformadoCorretamenteParaProdutoRastreavel(
      qryTinDet: TDataSet): Boolean;

    function fDocumentoExiste(strAutInc, strEspDoc: String): Boolean;
    function fDocumentoBaixado(strAutInc, strEspDoc: String): Boolean;
    function fVerificaImpressaoEtiquetaEntrega(strAutoincrem: String): Boolean;


    procedure pImprimir;
    procedure pBaixar;
    procedure pAtualizar;
    procedure pBaixarPorTinta;
    procedure pImpOrdemProd;
    procedure pAltTipTinta;
    procedure pApagar;
    procedure pImpEtiProd;

    function fApenasBaixados: Boolean;


    function fRetSQLFormulacaoLoja(strSQL : String) : String;
    function fRetSQLFormulacaoAbastecimentoPorDeposito(strSQL: String): String;


    function fRetSQLFormulacaoCd(strSQL : String) : String;

    function fRetSQLFormulacaoForaLoja(strSQL : String) : String;
    function fItemTemLotDorGravado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte: String; blnVerificaSeparado : Boolean) : Boolean;
    procedure pDeletaLotDorGravado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte: String);
    function fVerificaExisteAjuste(): Boolean;
    function fRetornaAjuste(): String;
    function fAjuste(strNumFat: String): String;
    procedure pImprimeAjuste(strNumDoc, strEspDoc: String; intQtd: Integer);
    procedure pImprimeTicketIF(strNumDoc, strEspDoc, strCodCli: String; intQtd: Integer);
    function fEhBaixaPedidoProducaoForaLoja(strEmpFor: string): Boolean;
    procedure pAtualizaStatusProcessamento(Const strAutInc: String; Const blnProces: Boolean);
    function fRetornaUltimaVenda(strCodCli, strIdePro, strIteTin, strSeqGer: String): String;

    function fLiberaDesmarcarBaixaDocJaExpedido(strDocs: string): Boolean;
    function fEhAbastecimentoPorDepositoComProducaoForaDaLoja(qryTinDet: TDataSet): Boolean; Overload;
    function fEhAbastecimentoPorDepositoComProducaoForaDaLoja(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean; Overload;
    function fDocumentoEhAbastecimentoPorDepositoComProducaoForaDaLoja(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fTravaGeracaoTransferencia(strNomCam: String): Boolean;
    function fPainelEstaAberto: Boolean;
    procedure pSetaDadosClienteBaixa(strNomCam: String);
    procedure pDeletarRegistroPorFiltro;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strIteTin: String;
  end;

var
  frmFatFormulacaoItens: TfrmFatFormulacaoItens;

Const
  cSQLPD = 'SELECT               ' +
           '  FATDOR.FDO_IDEPRO, ' +
           '  FATDOR.FDO_ITETIN, ' +
           '  FATDOR.FDO_TIPPRE, ' +
           '  FATDOR.FDO_LINLIN, ' +
           '  FATDOR.FDO_CATALI, ' +
           '  FATDOR.FDO_LAZQUA, ' +
           '  FATDOR.FDO_QTDEMB, ' +
           '  FATDOR.FDO_QTDITE, ' +
           '  FATDOR.FDO_DESCRI, ' +
           '  FATDOR.FDO_VOLPRO, ' +
           '  FATDOR.FDO_CODDIL, ' +
           '  FATDOR.FDO_PORDIL, ' +
           '  FATDOR.FDO_DILCON, ' +
           '  FATDOR.FDO_PORCAT, ' +
           '  FORTIN.FOR_TIPCOR, ' +
           '  FORTIN.FOR_TEXBAS, ' +
           '  FORTIN.FOR_MODDIL, ' +
           '  FORTIN.FOR_ITECOB, ' +
           '  FATDOR.FDO_EMPITE, ' +
           '  FATDOR.FDO_CODEMP, ' +
           '  FATDOR.FDO_ITEEMB, ' +
           '  FATDOR.FDO_CODITE, ' +
           '  FATDOR.FDO_QTDITE, ' +
           '  FATDOR.FDO_QTDITE, ' +
           '  FATDOR.FDO_ITEEMB, ' +
           '  FATDOR.FDO_EMPPRD, ' +
           '  FATDOR.FDO_NUMDOC, ' +
           '  FATDOR.FDO_ESPDOC, ' +
           '  TINDOR.FDO_UNITAR, ' +
           '  TINDOR.FDO_UNIDAD  ' +
           'FROM                 ' +
           '  FATDOR             ' +
           '  LEFT JOIN TINDOR ON TINDOR.FDO_CODACA = FATDOR.FDO_CODACA AND TINDOR.FDO_EMPACA = FATDOR.FDO_EMPACA ' +
           '  LEFT JOIN FORTIN ON FATDOR.FDO_CODACA = FORTIN.FOR_CODACA AND FATDOR.FDO_EMPACA = FORTIN.FOR_EMPACA ' +
           'WHERE ' +
           '  FATDOR.FDO_NUMDOC = :NUMDOC AND ' +
           '  FATDOR.FDO_ESPDOC = :ESPDOC AND ' +
           '  FATDOR.FDO_CODEMP = :CODEMP AND ' +
           '  FATDOR.FDO_ITETIN = :ITETIN     ';

  cSQLVN = 'SELECT               ' +
           '  MOVDET.DET_IDEPRO, ' +
           '  MOVDET.DET_ITETIN, ' +
           '  MOVDET.DET_TIPPRE, ' +
           '  MOVDET.DET_LINLIN, ' +
           '  MOVDET.DET_CATALI, ' +
           '  MOVDET.DET_LAZQUA, ' +
           '  MOVDET.DET_QTDEMB, ' +
           '  MOVDET.DET_QTDITE, ' +
           '  MOVDET.DET_DESCRI, ' +
           '  MOVDET.DET_VOLPRO, ' +
           '  MOVDET.DET_CODDIL, ' +
           '  MOVDET.DET_PORDIL, ' +
           '  MOVDET.DET_DILCON, ' +
           '  MOVDET.DET_PORCAT, ' +
           '  FORTIN.FOR_TIPCOR, ' +
           '  FORTIN.FOR_TEXBAS, ' +
           '  FORTIN.FOR_MODDIL, ' +
           '  FORTIN.FOR_ITECOB, ' +
           '  "" AS DET_EMPITE,  ' +
           '  MOVDET.DET_CODEMP, ' +
           '  MOVDET.DET_ITEEMB, ' +
           '  MOVDET.DET_CODITE, ' +
           '  MOVDET.DET_QTDITE, ' +
           '  MOVDET.DET_QTDITE, ' +
           '  MOVDET.DET_ITEEMB, ' +
           '  TINDET.DET_EMPPRD, ' +
           '  MOVDET.DET_NUMDOC, ' +
           '  MOVDET.DET_ESPDOC, ' +
           '  MOVDET.DET_UNITAR, ' +
           '  MOVDET.DET_UNIDAD  ' +
           'FROM                 ' +
           '  MOVDET             ' +
           '  LEFT JOIN TINDET ON TINDET.DET_CODACA = MOVDET.DET_CODACA AND TINDET.DET_EMPACA = MOVDET.DET_EMPACA ' +
           '  LEFT JOIN FORTIN ON MOVDET.DET_CODACA = FORTIN.FOR_CODACA AND MOVDET.DET_EMPACA = FORTIN.FOR_EMPACA ' +
           'WHERE                             ' +
           '  MOVDET.DET_NUMDOC = :NUMDOC AND ' +
           '  MOVDET.DET_ESPDOC = :ESPDOC AND ' +
           '  MOVDET.DET_CODEMP = :CODEMP AND ' +
           '  MOVDET.DET_ITETIN = :ITETIN     ';

implementation

uses untAutcomDllTinta,
  untProdAcabado,
  untFuncMacro,
  untConstantes, untPai, untFuncoesRel,
  untCfgRel,
  untCadIte, untFatFormulSelTintas, untConfCodBarrasFormulacao,
  untDadosEtiqProducao, untIFatFormulacao, untFatFormulacaoFactory, untFatFormulacaoGeneric,
  untCadLote, untFatFormulacaoTintas,
  untMensagemSonora, untObservacao, untExportarArquivosTinta,
  untGravando, untTypesCRM, untValidaSituacaoFinanceiraPedido,
  untTMatrizSaldosColorantes, untILiberacao, untLiberacaoFactory,
  untMsgLiberacao, untAjusteEstoqueFormulacao, untFatImpressao,
  untFiltrosFormulacao;

{$R *.dfm}

{ TfrmFatFormulacaoItens }

function TfrmFatFormulacaoItens.fAjuste(strNumFat: String): String;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT * FROM MOVDET WHERE DET_NUMFAT = :NUMFAT     ');
    qryGen.SQL.Add('    AND DET_TIPFAT = "AJ" AND DET_ESPDOC = "ML"       ');
    qryGen.SQL.Add('    AND DET_CODEMP = :CODEMP                          ');
    qryGen.ParamByName('NUMFAT').AsString := strNumFat;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.Open;

    Result := FormatDateTime('dd/mm/yyyy', qryGen.FieldByName('DET_DTAFAT').AsDateTime) + ' | ' + qryGen.FieldByName('DET_NUMFAT').AsString + '-' +
      qryGen.FieldByName('DET_TIPFAT').AsString + '-' + VS_strCodEmp;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fApenasBaixados: Boolean;
Begin
    Result := IIF(gpbPeriodo.Caption = 'Período de Baixa', True, False);
End;


procedure TfrmFatFormulacaoItens.pAtualizaTempEtiqFormulacao;
  Var
    strSQL: String;
begin
  If (Not fTabelaExiste(strTabFor)) Then
    pCriaTempEtiqFormulacao;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + strTabFor;
  With qryFormul Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    (FieldByName('TMP_QTDBAS') As TFloatField).DisplayFormat := '#,#0.0';
  End;
end;

procedure TfrmFatFormulacaoItens.pAtualizaTemporaria;
  Var
    strNomCam: String;
    cdsNaoExiste: TUniClientDataSet;
    colSitFin : TColumn;

  procedure pAdicionaNaTempNaoExiste(strIdePro: String);
  begin
    cdsNaoExiste.Append;
    cdsNaoExiste.FieldByName('IDEPRO').AsString := strIdePro;
    cdsNaoExiste.Post;
  end;
begin
  pCriaTemporaria;

  cdsNaoExiste := TUniClientDataSet.Create(Self);
  With cdsNaoExiste.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'IDEPRO';
    DataType := ftString;
    Size     := 3;
  End;

  cdsNaoExiste.CreateDataSet;

  With cdsTinMaq Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin
      If (strCfgExi = 'PD') And (blnSTFNTI) Then
      Begin
        If (cmbSitFin.ItemIndex <> 0) Then
        Begin
          Case cmbSitFin.ItemIndex Of
            1:
            Begin
              If (cdsTinMaq.FieldByName('SITFIN').AsString = 'OK') Then
              Begin
                cdsTinMaq.Delete;
                Continue;
              End;
            End;
            2:
            Begin
              If (cdsTinMaq.FieldByName('SITFIN').AsString <> 'OK') Then
              Begin
                cdsTinMaq.Delete;
                Continue;
              End;
            End;
          End;
        End;
      End
      Else If (rdgTipTin.ItemIndex = 0) Then
      Begin
        Break;
      End;

      If (rdgTipTin.ItemIndex > 0) Then
      Begin
        If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
          strNomCam := 'DET_IDEPRO'
        Else
          strNomCam := 'FDO_IDEPRO';

        If Not cdsNaoExiste.Locate('IDEPRO', FieldByName(strNomCam).AsString, []) Then
        Begin
          If IsTintaExistente(FieldByName(strNomCam).AsString) Then
          Begin
            {***********************************************}
            {* RENNER INDUSTRIAL E ANNETTA -> MOSTRA COMO  *}
            {* INDUSTRIAL E O FUNCIONAMENTO É IGUAL        *}
            {* IMOBILIÁRIA                                 *}
            {********************************************NC*}
            If Pos(FieldByName(strNomCam).AsString, 'REN_ANN_SPA_AJA_MZD_INT_LEC_KIN_LIK_ADT_SIN_REP_MIF_PRT_ALV_') > 0 Then
            Begin
              If ((rdgTipTin.ItemIndex = 1) Or (rdgTipTin.ItemIndex = 2)) Then
                Delete
              Else
                Next;
            End
            Else
            Begin
              If ((rdgTipTin.ItemIndex = 1) and (fTipoTinta(FieldByName(strNomCam).AsString) <> ttImobiliaria)) Or
                ((rdgTipTin.ItemIndex = 2) and (fTipoTinta(FieldByName(strNomCam).AsString) <> ttAutomotiva )) Or
                ((rdgTipTin.ItemIndex = 3) and (fTipoTinta(FieldByName(strNomCam).AsString) <> ttIndustrial )) Then
                Delete
              Else
                Next;
            End;
          End
          Else
          Begin
            pAdicionaNaTempNaoExiste(FieldByName(strNomCam).AsString);
            Delete;
          End;
        End
        Else
          Delete;

        Continue;
      End;

      cdsTinMaq.Next;
    End;

    First;
    pDeletarRegistroPorFiltro;
    First;

    If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
    Begin
      strNumDoc := FieldByName('DET_NUMDOC').AsString;
      strEspDoc := FieldByName('DET_ESPDOC').AsString;
      strCodEmp := FieldByName('DET_CODEMP').AsString;
      strCodCli := FieldByName('DET_CODCLI').AsString;
      strIteTin := FieldByName('DET_ITETIN').AsString;

      TFloatField(FieldByName('DET_QTDITE')).DisplayFormat := '#,####0.0000';
      dbgItens.Columns[3].Visible  := False;
    End
    Else
    Begin
      strNumDoc := FieldByName('FDO_NUMDOC').AsString;
      strEspDoc := FieldByName('FDO_ESPDOC').AsString;
      strCodEmp := FieldByName('FDO_CODEMP').AsString;
      strCodCli := FieldByName('FDO_CODCLI').AsString;
      strIteTin := FieldByName('FDO_ITETIN').AsString;

      TFloatField(FieldByName('FDO_QTDITE')).DisplayFormat := '#,####0.0000';

      dbgItens.Columns[0].FieldName  := 'FDO_ENTRET';
      dbgItens.Columns[1].FieldName  := 'FDO_NUMDOC';
      dbgItens.Columns[2].FieldName  := 'FDO_ESPDOC';
      dbgItens.Columns[3].FieldName  := 'FGO_DOCFAT';
      dbgItens.Columns[4].FieldName  := 'FDO_CODEMP';
      dbgItens.Columns[5].FieldName  := 'FDO_CODVEN';
      dbgItens.Columns[6].FieldName  := 'FDO_DTAENT';
      dbgItens.Columns[7].FieldName  := 'FDO_HORENT';
      dbgItens.Columns[8].FieldName  := 'FDO_CODITE';
      dbgItens.Columns[9].FieldName  := 'FIS_NUMCOO';
      dbgItens.Columns[10].FieldName  := 'FDO_IDEPRO';
      dbgItens.Columns[11].FieldName := 'FDO_DESCRI';
      dbgItens.Columns[12].FieldName := 'UNI_DESUNI';
      dbgItens.Columns[13].FieldName := 'FDO_QTDITE';
      dbgItens.Columns[14].FieldName := 'FDO_TIPEMB';
      dbgItens.Columns[15].FieldName := 'FDO_NOMCLI';
    End;

    If fCfgSis('LOCRET') = 'S' Then
        dbgItens.Columns[0].Width := 160;

    colSitFin := fFindColumnByName(dbgItens, 'SITFIN');

    dbgItens.Columns[16].Visible := fCfgSis('LOTIMO') = 'S';
    dbgItens.Columns[21].Visible := fCfgSis('AJUFOR') = 'S';
    dbgItens.Columns[22].Visible := fCfgSis('EDTIUC') = 'S';



    If Assigned(colSitFin) Then
      colSitFin.Visible := (strCfgExi = 'PD') And (blnSTFNTI);

    EnableControls;
  End;

  If Assigned(cdsNaoExiste) Then
    FreeAndNil(cdsNaoExiste);
end;

procedure TfrmFatFormulacaoItens.pBaixaFormulacaoDocVenda(qryTinDet: TDataSet; strCodOpe: String);
var
  recFat: TDocumento;
  strSQL: String;

  function fRetDocFaturado(strNumDoc,
                           strEspDoc,
                           strEmpDoc,
                           strCodAca,
                           strEmpAca : String) : TDocumento;
  var
    qryAux : TUniQuery;
  const
    strSQL = 'SELECT          ' +
             '  D.FDO_NUMFAT, ' +
             '  D.FDO_TIPFAT, ' +
             '  D.FDO_EMPFAT  ' +
             'FROM            ' +
             '  FATGOR G      ' +
             '  INNER JOIN FATDOR D ON (D.FDO_SEQGER = G.AUTOINCREM) ' +
             'WHERE                        ' +
             '  D.FDO_NUMDOC = :NUMDOC AND ' +
             '  D.FDO_ESPDOC = :ESPDOC AND ' +
             '  D.FDO_CODEMP = :CODEMP AND ' +
             '  D.FDO_CODACA = :CODACA AND ' +
             '  D.FDO_EMPACA = :EMPACA AND ' +
             '  G.FGO_JAFATU = 1           ';

  begin

    Result.strNumDoc := '';
    Result.strEspDoc := '';
    Result.strCodEmp := '';

    qryAux := fCriaQuery;

    try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strEmpDoc;
      qryAux.ParamByName('CODACA').AsString := strCodAca;
      qryAux.ParamByName('EMPACA').AsString := strEmpAca;
      qryAux.Open;

      If Not qryAux.IsEmpty Then
      Begin
        Result.strNumDoc := qryAux.FieldByName('FDO_NUMFAT').AsString;
        Result.strEspDoc := qryAux.FieldByName('FDO_TIPFAT').AsString;
        Result.strCodEmp := qryAux.FieldByName('FDO_EMPFAT').AsString;
      End;

    finally
      FreeAndNil(qryAux);
    end;

  end;

  function fRetDocFuturo(strNumDoc,
                         strEspDoc,
                         strEmpDoc,
                         strCodAca,
                         strEmpAca : String) : TDocumento;
  var
    qryAux : TUniQuery;
  const
    strSQL = 'SELECT MD.DET_NUMDOC, MD.DET_ESPDOC, MD.DET_CODEMP ' +
             '  FROM FATDOR D ' +
             ' INNER JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM ' +
             ' INNER JOIN MOVDET MD ON MD.AUTOINCREM = E.FDO_INCFUT ' +
             'WHERE FDO_NUMDOC = :NUMDOC ' +
             '  AND FDO_CODEMP = :CODEMP ' +
             '  AND FDO_ESPDOC = :ESPDOC ' +
             '  AND FDO_CODACA = :CODACA ' +
             '  AND FDO_EMPACA = :EMPACA ';

  begin

    Result.strNumDoc := '';
    Result.strEspDoc := '';
    Result.strCodEmp := '';

    qryAux := fCriaQuery;

    try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strEmpDoc;
      qryAux.ParamByName('CODACA').AsString := strCodAca;
      qryAux.ParamByName('EMPACA').AsString := strEmpAca;
      qryAux.Open;

      If Not qryAux.IsEmpty Then
      Begin
        Result.strNumDoc := qryAux.FieldByName('DET_NUMDOC').AsString;
        Result.strEspDoc := qryAux.FieldByName('DET_ESPDOC').AsString;
        Result.strCodEmp := qryAux.FieldByName('DET_CODEMP').AsString;
      End;

    finally
      FreeAndNil(qryAux);
    end;

  end;

begin

  recFat := fRetDocFaturado(qryTinDet.FieldByName('FDO_NUMDOC').AsString,
                            qryTinDet.FieldByName('FDO_ESPDOC').AsString,
                            qryTinDet.FieldByName('FDO_CODEMP').AsString,
                            qryTinDet.FieldByName('FDO_CODACA').AsString,
                            qryTinDet.FieldByName('FDO_EMPACA').AsString);

  If (Not fEmptyStr(recFat.strNumDoc)) And (Not fTinDetBaixado(recFat.strNumDoc,
                                                               recFat.strCodEmp,
                                                               recFat.strEspDoc,
                                                               qryTinDet.FieldByName('FDO_CODACA').AsString,
                                                               qryTinDet.FieldByName('FDO_EMPACA').AsString)) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'UPDATE TINDET ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  DET_OPEBAI = "'+ strCodOpe + '",   ';
    strSQL := strSQL + '  DET_DTABAI = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  DET_HORBAI = ' + fCurrentTime + ', ';
    strSQL := strSQL + '  DET_BAIXAD = TRUE,         ';
    strSQL := strSQL + '  DET_MOTBAI = '+'"FORMULACAO TINTA DE MAQUINA - PEDIDO JÁ FATURADO"'+' ';
    strSQL := strSQL + 'WHERE                        ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMFAT AND   ';
    strSQL := strSQL + '  DET_ESPDOC = :TIPFAT AND   ';
    strSQL := strSQL + '  DET_CODEMP = :EMPFAT AND   ';
    strSQL := strSQL + '  DET_CODACA = :CODACA AND   ';
    strSQL := strSQL + '  DET_EMPACA = :EMPACA       ';

    pExecutaSQL(strSQL, ['NUMFAT','TIPFAT','EMPFAT','CODACA','EMPACA'],
                        [recFat.strNumDoc,
                         recFat.strEspDoc,
                         recFat.strCodEmp,
                         qryTinDet.FieldByName('FDO_CODACA').AsString,
                         qryTinDet.FieldByName('FDO_EMPACA').AsString]);
  End;

  If (strCfgExi = 'PD') and
     (fTinDorBaixado(qryTinDet.FieldByName('FDO_NUMDOC').AsString,
                     qryTinDet.FieldByName('FDO_CODEMP').AsString,
                     qryTinDet.FieldByName('FDO_ESPDOC').AsString,
                     qryTinDet.FieldByName('FDO_CODACA').AsString,
                     qryTinDet.FieldByName('FDO_EMPACA').AsString)) Then
  Begin

    recFat := fRetDocFuturo(qryTinDet.FieldByName('FDO_NUMDOC').AsString,
                            qryTinDet.FieldByName('FDO_ESPDOC').AsString,
                            qryTinDet.FieldByName('FDO_CODEMP').AsString,
                            qryTinDet.FieldByName('FDO_CODACA').AsString,
                            qryTinDet.FieldByName('FDO_EMPACA').AsString);

    if (Not fEmptyStr(recFat.strNumDoc)) then
    begin

      if (Not fTinDetBaixado(recFat.strNumDoc,
                             recFat.strCodEmp,
                             recFat.strEspDoc,
                             qryTinDet.FieldByName('FDO_CODACA').AsString,
                             qryTinDet.FieldByName('FDO_EMPACA').AsString)) Then
      Begin
        strSQL := '';
        strSQL := strSQL + 'UPDATE TINDET ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  DET_OPEBAI = "'+ strCodOpe + '",   ';
        strSQL := strSQL + '  DET_DTABAI = ' + fCurrentDate + ', ';
        strSQL := strSQL + '  DET_HORBAI = ' + fCurrentTime + ', ';
        strSQL := strSQL + '  DET_BAIXAD = TRUE          ';
        strSQL := strSQL + 'WHERE                        ';
        strSQL := strSQL + '  DET_NUMDOC = :NUMFAT AND   ';
        strSQL := strSQL + '  DET_ESPDOC = :TIPFAT AND   ';
        strSQL := strSQL + '  DET_CODEMP = :EMPFAT AND   ';
        strSQL := strSQL + '  DET_CODACA = :CODACA AND   ';
        strSQL := strSQL + '  DET_EMPACA = :EMPACA       ';

        pExecutaSQL(strSQL, ['NUMFAT','TIPFAT','EMPFAT','CODACA','EMPACA'],
                            [recFat.strNumDoc,
                             recFat.strEspDoc,
                             recFat.strCodEmp,
                             qryTinDet.FieldByName('FDO_CODACA').AsString,
                             qryTinDet.FieldByName('FDO_EMPACA').AsString]);
      End;
    end;
  end;
end;

procedure TfrmFatFormulacaoItens.pChamaFormularioDadosEtiqProducao;
begin
  Try
    pCriarFormularios(TfrmDadosEtiqProducao, frmDadosEtiqProducao);
    frmDadosEtiqProducao.ShowModal;

    If frmDadosEtiqProducao.blnConfirma Then
    Begin
      With frmDadosEtiqProducao Do
      Begin
        ftiDadosEtiq.strNomBas := edtNomBas.Text;
        ftiDadosEtiq.strCodigo := edtCodigo.Text;
        ftiDadosEtiq.strNumLot := edtLote.Text;
        ftiDadosEtiq.strDtaFab := edtFabric.Text;
        ftiDadosEtiq.strCompon := edtCompon.Text;
        ftiDadosEtiq.strReduto := edtRedutor.Text;
        ftiDadosEtiq.strConteu := edtConLiq.Text;
        ftiDadosEtiq.strDesTin := dbgItens.DataSource.DataSet.FieldByName('DET_DESCRI').AsString;
      End;
      pImprimeEtiquetaProducao;
    End;

  Finally
    FreeAndNil(frmDadosEtiqProducao);
  End;
end;

procedure TfrmFatFormulacaoItens.pCriaTempEtiqFormulacao;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE ' + strTabFor + ' (';
  strSQL := strSQL + '  TMP_FORMUL VARCHAR(50),     ';
  strSQL := strSQL + '  TMP_QTDBAS NUMERIC(12, 4) ) ';
  With qryFormul Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ExecSQL;
    Close;
  End;
end;

procedure TfrmFatFormulacaoItens.pCriaTemporaria;
  Var
    strSeqGerDocFat,
    strSQL,
    strSQL3,
    strSQLTmp: String;
    intContador: Integer;
    strBaixad : String;
    strSinal : String;
    strPenFin : String;
    qryTinMaq : TUniQuery;

  function fField(strCampo: String): TField;
  begin
  If (Pos(strCfgExi, 'O_OP_OD_OR_PD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP') Then
      Result := cdsTinMaq.FieldByName('FDO_' + strCampo)
    Else
      Result := cdsTinMaq.FieldByName('DET_' + strCampo);
  end;

  function fGetSQLVlrCon: String;
  Begin
    Result := '';
    Result := Result + ' (SELECT SUM( IF( COALESCE(SUBDOR.FDO_QTDBAI, 0) = 0, SUBDOR.FDO_TOTITE - SUBDOR.FDO_DESESP + SUBDOR.FDO_VALIPI + SUBDOR.FDO_TOTFRE + SUBDOR.FDO_VALRET, ';
    Result := Result + '         ROUND((SUBDOR.FDO_TOTITE - SUBDOR.FDO_DESESP + SUBDOR.FDO_VALIPI + SUBDOR.FDO_TOTFRE + SUBDOR.FDO_VALRET) - ';
    Result := Result + '           IFNULL( ( SELECT SUM(DET_VLRCON) ';
    Result := Result + '                       FROM MOVDET ';
    Result := Result + '                      WHERE DET_NUM_PD = SUBDOR.FDO_NUMDOC ';
    Result := Result + '                        AND DET_ESP_PD = SUBDOR.FDO_ESPDOC ';
    Result := Result + '                        AND DET_EMP_PD = SUBDOR.FDO_CODEMP ';
    Result := Result + '                        AND DET_CODITE = SUBDOR.FDO_CODITE ';
    Result := Result + '                        AND DET_IND_PD = SUBDOR.FDO_SEQIND ';
    Result := Result + '                        AND (SELECT COUNT(BRI_SEQDET) FROM BRIDET WHERE BRI_SEQDET = MOVDET.AUTOINCREM) = 0), 0) ';
    Result := Result + '              , 2))) ';
    Result := Result + '    FROM FATDOR SUBDOR ';
    Result := Result + '   WHERE SUBDOR.FDO_SEQGER = FATDOR.FDO_SEQGER) AS VLRCON ';
  End;

begin
  pgbProgresso.Position := 0;
  pgbProgresso.Visible := True;
  pgbProgresso.Max := 3;
  pAddProgresso('Aguarde... Carregando Documentos...');

  strSQL := '';
  strSQL3 := '';

  If (Not fApenasBaixados) Then
  Begin
    strBaixad := 'N';
    strSinal := '=';
  End
  Else
  Begin
    {**********************************************************************************}
    {* UTILIZANDO DESTA FORMA POIS O CAMPO TINDOR.FDO_BAIXAD TEM TRÊS POSSIBILIDADES: *}
    {* VALORES: "N" , "S" , "1"                                                       *}
    {*******************************************************************************RN*}
    strBaixad := 'N';
    strSinal := '<>';
  End;

  {**************************************************}
  {*CONTROLA A EXIBIÇÃO ( V = VENDA, O = ORÇAMENTO )*}
  {***********************************************PZ*}
  If (strCfgExi = 'V') Then
  Begin
    strSQL := strSQL + 'SELECT ';

    If fCfgSis('LOCRET') = 'S' Then
    Begin
      strSQL := strSQL + '  IF(MOVGER.GER_ENTFAT = "N" , ';
      strSQL := strSQL + '  CASE (SELECT DISTINCT EXT.FDO_LOCRET FROM FATDOR FAT ';
      strSQL := strSQL + '        LEFT JOIN EXTDOR EXT ON EXT.FDO_SEQFDO = FAT.AUTOINCREM ';
      strSQL := strSQL + '        WHERE FAT.FDO_CODACA = MOVDET.DET_CODACA ';
      strSQL := strSQL + '           AND FAT.FDO_EMPACA = MOVDET.DET_EMPACA ';
      strSQL := strSQL + '           AND FAT.FDO_NUMDOC = MOVDET.DET_NUM_PD ';
      strSQL := strSQL + '           AND FAT.FDO_ESPDOC = MOVDET.DET_ESP_PD ';
      strSQL := strSQL + '           AND FAT.FDO_CODEMP = MOVDET.DET_EMP_PD) ';
      strSQL := strSQL + '    WHEN "C" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('CAIXA', 1) + '" ';
      strSQL := strSQL + '    WHEN "B" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO', 3) + '" ';
      strSQL := strSQL + '    WHEN "B2" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO 2', 4) + '" ';
      strSQL := strSQL + '    ELSE "RETIRA ' + fVerificaDescAdicionalLocRet('EXPEDIÇÃO', 2) + '" ';
      strSQL := strSQL + '    END, IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';
    End
    Else
      strSQL := strSQL + '  IF(MOVGER.GER_ENTFAT = "N" , "RETIRA", IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';

    strSQL := strSQL + '  "N"  AS BAIXAOP, ';
    strSQL := strSQL + '  CAST(TINDET.DET_DESCRI AS CHAR(100)) AS DET_DESCRI, ';
    strSQL := strSQL + '  TINDET.DET_DTAENT AS DTAENT, ';
    strSQL := strSQL + '  TINDET.DET_HORENT AS HORENT, ';
    strSQL := strSQL + '  IF(TINDET.DET_AJUFOR = "S", "S", "N") AS AJUFOR,  ';
    strSQL := strSQL + fRetTabela +',';
    strSQL := strSQL + '  IF(TINDET.DET_ORDIMP = 0, "N", "S") AS ORDIMP, ';

    strSQL := strSQL + '  TINGER.GER_NOMCON, ';
    strSQL := strSQL + '  TINGER.GER_ENDCON, ';
    strSQL := strSQL + '  TINGER.GER_BAICON, ';
    strSQL := strSQL + '  TINGER.GER_CEPCON, ';
    strSQL := strSQL + '  TINGER.GER_CIDCON, ';
    strSQL := strSQL + '  TINGER.GER_TELCON, ';
    strSQL := strSQL + '  TINGER.GER_CGCCPF, ';
    strSQL := strSQL + '  TINGER.GER_CGCCON, ';
    strSQL := strSQL + '  TINGER.GER_IESCON, ';
    strSQL := strSQL + '  TINGER.GER_R_GCON, ';
    strSQL := strSQL + '  TINGER.GER_ESTADO, ';
    strSQL := strSQL + '  TINGER.GER_ESPDOC, ';
    strSQL := strSQL + '  TINGER.AUTOINCREM AS AUTINC, ';

    strSQL := strSQL + '  CADITE.ITE_CODMAR, ';
    strSQL := strSQL + '  CADITE.ITE_DESITE, ';
    strSQL := strSQL + '  CADITE.ITE_REFERE, ';
    strSQL := strSQL + '  CADITE.ITE_CODUNI, ';
    strSQL := strSQL + '  CADITE.ITE_CODFOR, ';

    strSQL := strSQL + '  ITEGER.ITE_PREVE1, ';
    strSQL := strSQL + '  ITEGER.ITE_PRECUS, ';
    strSQL := strSQL + '  ITEGER.ITE_PREMED, ';

    strSQL := strSQL + '  MOVDET.DET_CODFIS, ';
    strSQL := strSQL + '  MOVDET.DET_ITEEMB, ';
    strSQL := strSQL + '  MOVDET.DET_CODFPG, ';
    strSQL := strSQL + '  CADUNI.UNI_DESUNI, ';
    strSQL := strSQL + '  TINDET.AUTOINCREM AS CHAVE, ';

    strSQL := strSQL + '  CLI_CODCLI,        ';
    strSQL := strSQL + '  IF(TINGER.GER_NOMCON IS NULL OR TINGER.GER_NOMCON = "", CLI_NOMCLI, TINGER.GER_NOMCON) AS DET_NOMCLI, ';
    strSQL := strSQL + '  IFNULL(FORTIN.FOR_MODDIL, 0)  FOR_MODDIL, ';
    strSQL := strSQL + '  CAST(IFNULL(FORTIN.FOR_TEXBAS, "") AS CHAR(10)) AS FOR_TEXBAS, ';
    strSQL := strSQL + '  CAST(IFNULL(FORTIN.FOR_TIPCOR, "") AS CHAR(20)) AS FOR_TIPCOR, ';
    strSQL := strSQL + '  CAST(IFNULL(FORTIN.FOR_ITECOB, "") AS CHAR('+ fTamCodIte.ToString +')) AS FOR_ITECOB, ';
    strSQL := strSQL + '  CAST(IFNULL(FORTIN.FOR_UNIVER, "") AS CHAR(20)) AS FOR_UNIVER, ';

    strSQL := strSQL + ' (SELECT ';
    strSQL := strSQL + '    FIS_NUMCOO ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADFIS ';
    strSQL := strSQL + '  WHERE FIS_NUMDOC = MOVDET.DET_NUMDOC ';
    strSQL := strSQL + '    AND FIS_ESPDOC = MOVDET.DET_ESPDOC ';
    strSQL := strSQL + '    AND FIS_CODEMP = MOVDET.DET_CODEMP ';
    strSQL := strSQL + '    AND FIS_FORCLI = MOVDET.DET_CODCLI ';
    strSQL := strSQL + '    AND FIS_TIP_FC = MOVDET.DET_TIP_FC ';
    strSQL := strSQL + '    AND FIS_ORIDOC = MOVDET.DET_ORIDOC ) AS FIS_NUMCOO, ';

    strSQL := strSQL + '  IF(MOVGER.GER_ENTFAT = "N", 0 , IF(MOVDET.DET_DOCFUT <> "", 2, 1)) AS DESTINO, ';
    strSQL := strSQL + '   "OK" AS SITFIN, ';

    strSQL := strSQL + '  MOVDET.DET_DOCFUT, ';
    strSQL := strSQL + '  MOVDET.DET_ESPFUT, ';
    strSQL := strSQL + '  MOVDET.DET_EMPFUT,  ';

    strSQL := strSQL + ' ACA_CODBAR  AS CODBAR_ACA, ';
    strSQL := strSQL + ' EMB.ITE_CODBAR  AS CODBAR_EMB, ';
    strSQL := strSQL + ' CADITE.ITE_CODBAR AS CODBAR_BASE, ';

    strSQL := strSQL + ' EXPARQ.AUTOINCREM SEQ_EXPARQ, ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS DIRARQEXP, ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS CODSEP,    ';
    strSQL := strSQL + ' "0" AS SEPIMP,   ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS AUTINC_DOCORI, ';
    strSQL := strSQL + ' TINDET.DET_TIPFOR AS TIPFOR, ';
    strSQL := strSQL + ' TINDET.DET_OBSCOL AS OBSCOL, ';
    strSQL := strSQL + ' TINDET.DET_EMPACA AS EMPACA, ';
    strSQL := strSQL + ' TINDET.DET_CODACA AS CODACA, ';
    strSQL := strSQL + ' CAST("" AS CHAR(10)) AS DTAULT, ';
    strSQL := strSQL + '(SELECT CADLOT.LOT_NUMLOT     ';
    strSQL := strSQL + '   FROM CADLOT                ';
    strSQL := strSQL + ' WHERE CADLOT.LOT_CODITE = TINDET.DET_CODITE AND  ';
    strSQL := strSQL + '       CADLOT.LOT_CODEMP = :CODEMP AND            ';
    strSQL := strSQL + '       CADLOT.LOT_PRITIN = "S"                    ';
    strSQL := strSQL + ' LIMIT 1) AS NUMLOT,                              ';
    strSQL := strSQL + ' MOVDET.DET_SEQGER AS SEQGER_DOCFAT, ';
    strSQL := strSQL + '  "" AS FGO_NUMFAT                                ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TINDET ';
    strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = TINDET.DET_CODCLI ';
    strSQL := strSQL + '  JOIN TINGER ON TINGER.AUTOINCREM = TINDET.DET_SEQGER ';
    strSQL := strSQL + '  JOIN CADITE ON CADITE.ITE_CODITE = TINDET.DET_CODITE ';
    strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '                 AND ITEGER.ITE_CODEMP = :CODEMP ';
    strSQL := strSQL + '  JOIN MOVDET ON MOVDET.DET_CODACA = TINDET.DET_CODACA AND ';
    strSQL := strSQL + '                 MOVDET.DET_EMPACA = TINDET.DET_EMPACA AND ';
    strSQL := strSQL + '                 MOVDET.DET_NUMDOC = TINDET.DET_NUMDOC AND ';
    strSQL := strSQL + '                 MOVDET.DET_ESPDOC = TINDET.DET_ESPDOC AND ';
    strSQL := strSQL + '                 MOVDET.DET_CODEMP = TINDET.DET_CODEMP AND ';
    strSQL := strSQL + '                 MOVDET.DET_CODCLI = TINDET.DET_CODCLI AND ';
    strSQL := strSQL + '                 MOVDET.DET_PROEMB <> "S"  AND ';
    strSQL := strSQL + '                 MOVDET.DET_ENTFUT <> "S"      ';
    strSQL := strSQL + '  LEFT JOIN FORTIN ON MOVDET.DET_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = MOVDET.DET_EMPACA ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = UNI_CODUNI ';


    strSQL := strSQL + '  LEFT JOIN MOVGER ON MOVGER.AUTOINCREM =  MOVDET.DET_SEQGER ';
    strSQL := strSQL + '  LEFT JOIN EXPARQ ON EXPARQ.AUTOINCREM =  TINDET.AUTOINCREM ' ;

    //codigo de barras da formulacao
    strSQL := strSQL + '  LEFT JOIN CADACA ON ACA_CODACA = TINDET.DET_CODACA ';
    strSQL := strSQL + '                  AND ACA_CODEMP = TINDET.DET_EMPACA ';

    strSQL := strSQL + '  LEFT JOIN CADITE EMB ON EMB.ITE_CODITE = MOVDET.DET_ITEEMB ';

    strSQL := strSQL + 'WHERE ';

    If Not fApenasBaixados Then
    begin
      strSQL := strSQL + '  (TINDET.DET_BAIXAD = "N") AND ' ;

      If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
        strSQL := strSQL + '  TINDET.DET_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                                 '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';
    end
    Else
    Begin
      strSQL := strSQL + '  IFNULL(TINDET.DET_BAIXAD,"N") <> "N" AND ';
      strSQL := strSQL + '  TINDET.DET_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                               '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';
    End;

    strSQL := strSQL + '  TINDET.DET_ESPDOC <> "PA" AND ';
    strSQL := strSQL + '  TINDET.DET_EMPPRD = :CODEMP ';

  End
  Else If (strCfgExi = 'PA') Then
  Begin
    strSQL := fRetSQLOrdemProdAvulsa;
  End
  Else
  Begin
    strSQL := strSQL + 'SELECT                         ';

    If fCfgSis('LOCRET') = 'S' Then
    begin
      strSQL := strSQL + '  IF(EXTDOR.FDO_ENTRET = "R" , CASE EXTDOR.FDO_LOCRET ';
      strSQL := strSQL + '                               WHEN "C" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('CAIXA', 1) + '" ';
      strSQL := strSQL + '                               WHEN "B" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO', 3) + '" ';
      strSQL := strSQL + '                               WHEN "B2" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO 2', 4) + '" ';
      strSQL := strSQL + '                               ELSE "RETIRA ' + fVerificaDescAdicionalLocRet('EXPEDIÇÃO', 2) + '" ';
      strSQL := strSQL + '                               END, IF(FATDOR.FDO_ENTFUT  = "N", "ENT.IMEDIATA", "ENT.FUTURA")) AS FDO_ENTRET, ';
    end
    Else
      strSQL := strSQL + '  IF(EXTDOR.FDO_ENTRET = "R" , "RETIRA", IF(FATDOR.FDO_ENTFUT  = "N", "ENT.IMEDIATA", "ENT.FUTURA")) AS FDO_ENTRET, ';

    strSQL := strSQL + '  "N"  AS BAIXAOP,             ';
    strSQL := strSQL + '  CAST(TINDOR.FDO_DESCRI AS CHAR(100)) AS FDO_DESCRI, ';
    strSQL := strSQL + '  TINDOR.FDO_DTAENT AS DTAENT, ';
    strSQL := strSQL + '  TINDOR.FDO_HORENT AS HORENT, ';
    strSQL := strSQL + '  IF(TINDOR.FDO_AJUFOR = "S", "S", "N") AS AJUFOR,  ';
    strSQL := strSQL + fRetTabela +',';
    strSQL := strSQL + '  IF(TINDOR.FDO_ORDIMP = 0, "N", "S") AS ORDIMP, ';

    strSQL := strSQL + '  TINGOR.FGO_NOMCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_ENDCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_BAICON,           ';
    strSQL := strSQL + '  TINGOR.FGO_CEPCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_CIDCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_TELCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_CGCCPF,           ';
    strSQL := strSQL + '  TINGOR.FGO_CGCCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_IESCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_R_GCON,           ';
    strSQL := strSQL + '  TINGOR.FGO_ESTADO,           ';
    strSQL := strSQL + '  TINGOR.FGO_ESPDOC,           ';
    strSQL := strSQL + '  TINGOR.AUTOINCREM AS AUTINC, ';
    strSQL := strSQL + '  TINGOR.FGO_MENFOR,           ';
    strSQL := strSQL + '  FATGOR.FGO_ENT_CD,           ';
    strSQL := strSQL + '  FATDOR.FDO_EMPPRD,           ';

    strSQL := strSQL + '  CAST(IF(FATGOR.FGO_NUMFAT IS NULL OR FATGOR.FGO_NUMFAT = "", ';
    strSQL := strSQL + '          "", ';
    strSQL := strSQL + '          CONCAT(FATGOR.FGO_NUMFAT, "-", FATGOR.FGO_TIPFAT, "-", FATGOR.FGO_EMPFAT)) AS CHAR(19)) AS FGO_DOCFAT, ';

    strSQL := strSQL + '  FATGOR.FGO_NUMFAT,           ';
    strSQL := strSQL + '  FATGOR.FGO_TIPFAT,           ';
    strSQL := strSQL + '  FATGOR.FGO_EMPFAT,           ';
    strSQL := strSQL + '  EXTGOR.FGO_EMP_TE,           ';

    strSQL := strSQL + '  CADITE.ITE_CODMAR,           ';
    strSQL := strSQL + '  CADITE.ITE_DESITE,           ';
    strSQL := strSQL + '  CADITE.ITE_REFERE,           ';
    strSQL := strSQL + '  CADITE.ITE_CODUNI,           ';
    strSQL := strSQL + '  CADITE.ITE_CODFOR,           ';

    strSQL := strSQL + '  ITEGER.ITE_PREVE1,           ';
    strSQL := strSQL + '  ITEGER.ITE_PRECUS,           ';
    strSQL := strSQL + '  ITEGER.ITE_PREMED,           ';

    strSQL := strSQL + '  IFNULL(FORTIN.FOR_MODDIL, 0)  FOR_MODDIL, ';
    strSQL := strSQL + '  IFNULL(FORTIN.FOR_TEXBAS, CAST("" AS CHAR(01))) FOR_TEXBAS, ';
    strSQL := strSQL + '  IFNULL(FORTIN.FOR_TIPCOR, CAST("" AS CHAR(01))) FOR_TIPCOR, ';
    strSQL := strSQL + '  IFNULL(FORTIN.FOR_ITECOB, CAST("" AS CHAR(01))) FOR_ITECOB, ';
    strSQL := strSQL + '  IFNULL(FORTIN.FOR_UNIVER, CAST("" AS CHAR(01))) FOR_UNIVER, ';

    strSQL := strSQL + '  CADUNI.UNI_DESUNI, ';

    strSQL := strSQL + '  CLI_CODCLI,        ';
    strSQL := strSQL + '  IF(TINGOR.FGO_NOMCON IS NULL OR TINGOR.FGO_NOMCON = "", CLI_NOMCLI, TINGOR.FGO_NOMCON) AS FDO_NOMCLI, ';
    strSQL := strSQL + '  TINDOR.AUTOINCREM AS CHAVE ';

    strSQL := strSQL + '  , FATDOR.FDO_EMPPRD ';
    strSQL := strSQL + '  , FATDOR.FDO_VOLPRO ';
    strSQL := strSQL + '  , FATDOR.FDO_LAZQUA ';
    strSQL := strSQL + '  , FATDOR.FDO_ITEEMB ';

    strSQL := strSQL + '  , CAST(" " AS CHAR(09)) AS FIS_NUMCOO ';
    strSQL := strSQL + '  ,  IF(EXTDOR.FDO_ENTRET = "R", 0 , IF(FATDOR.FDO_ENTFUT = "N", 1, 2)) AS DESTINO, ';

    If (strCfgExi = 'PD') And (blnSTFNTI) Then
    Begin
      strSQL := strSQL + '   FATGOR.FGO_CONPAG AS CONPAG, ';

      strSQL := strSQL + '   (SELECT ';
      strSQL := strSQL + '      SUM(CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) ';
      strSQL := strSQL + '    FROM ';
      strSQL := strSQL + '      CADREC ';
      strSQL := strSQL + '    WHERE ';
      strSQL := strSQL + '      CTR_NUMDUP = FATGOR.FGO_NUMDOC AND ';
      strSQL := strSQL + '      CTR_ESPDOC = FATGOR.FGO_ESPDOC AND ';
      strSQL := strSQL + '      CTR_CODEMP = FATGOR.FGO_CODEMP AND ';
      strSQL := strSQL + '      CTR_CODCLI = FATGOR.FGO_CODCLI AND ';
      strSQL := strSQL + '      CTR_DTAREC IS NOT NULL) AS VALREC, ';

      strSQL := strSQL + '   (SELECT ';
      strSQL := strSQL + '      SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ';
      strSQL := strSQL + '    FROM ';
      strSQL := strSQL + '      ADTCLI ';
      strSQL := strSQL + '    WHERE ';
      strSQL := strSQL + '      ADT_NUMDOC = FATGOR.FGO_NUMDOC AND ';
      strSQL := strSQL + '      ADT_ESPDOC = FATGOR.FGO_ESPDOC AND ';
      strSQL := strSQL + '      ADT_CODEMP = FATGOR.FGO_CODEMP AND ';
      strSQL := strSQL + '      ADT_CODCLI = FATGOR.FGO_CODCLI) AS VALADT, ';

      strSQL := strSQL + '    ' + fGetSQLVlrCon + ',   ';

      strSQL := strSQL + '    EXTGOR.FGO_BOLADT AS BOLADT, ';
      strSQL := strSQL + '    EXTGOR.FGO_BOLVEN AS BOLVEN, ';
      strSQL := strSQL + '    FATGOR.FGO_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '    FATGOR.FGO_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '    FATGOR.FGO_CODEMP AS CODEMP, ';
      strSQL := strSQL + '    FATGOR.FGO_CODCLI AS CODCLI, ';
      strSQL := strSQL + '    FATGOR.FGO_CODFPG AS CODFPG, ';

      strSQL := strSQL + '    (SELECT ';
      strSQL := strSQL + '      GROUP_CONCAT(FPN_CODFPG) ';
      strSQL := strSQL + '    FROM ';
      strSQL := strSQL + '      FPGNEG ';
      strSQL := strSQL + '    WHERE ';
      strSQL := strSQL + '      FPGNEG.FPN_SEQFGO = FATGOR.AUTOINCREM) AS FPGNEG, ';

      If (Not fCfgSis('NPDF11', VarBoolean)) And (Not fCfgSis('NPRF11', VarBoolean)) Then
      Begin
        strSQL := strSQL + '  "N" AS ORIF11,';
      End
      Else
      Begin
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '    IF(COUNT(*) > 0, "S", "N") ';
        strSQL := strSQL + '  FROM ';
        strSQL := strSQL + '    FATDOR AS PEDORI ';
        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    PEDORI.FDO_NUMFAT = FATGOR.FGO_NUMDOC AND ';
        strSQL := strSQL + '    PEDORI.FDO_TIPFAT = FATGOR.FGO_ESPDOC AND ';
        strSQL := strSQL + '    PEDORI.FDO_EMPFAT = FATGOR.FGO_CODEMP) AS ORIF11, ';
      End;

      strSQL := strSQL + ' FATGOR.AUTOINCREM AS INCGOR, ';
      strSQL := strSQL + ' FATGOR.FGO_TIPOPE AS TIPOPE, ';
    End;

    strSQL := strSQL + '   "OK" AS SITFIN, ';

    strSQL := strSQL + '  ACA_CODBAR  AS CODBAR_ACA, ';
    strSQL := strSQL + '  EMB.ITE_CODBAR  AS CODBAR_EMB, ';
    strSQL := strSQL + '  CADITE.ITE_CODBAR AS CODBAR_BASE, ';

    strSQL := strSQL + ' EXPARQ.AUTOINCREM SEQ_EXPARQ, ';
    strSQL := strSQL + ' CAST("" AS CHAR(255)) AS DIRARQEXP, ';

    strSQL := strSQL + ' EXTGOR.FGO_SEPEXP AS CODSEP,   ';
    strSQL := strSQL + ' IF(FATGOR.FGO_SEPIMP = "N" OR IFNULL(FATGOR.FGO_SEPIMP,"") = "","0",IF(FATGOR.FGO_SEPIMP = "S","1",FATGOR.FGO_SEPIMP)) AS SEPIMP, ';
    strSQL := strSQL + ' FATDOR.AUTOINCREM AS AUTINC_DOCORI, ';

    strSQL := strSQL + ' TINDOR.FDO_TIPFOR AS TIPFOR, ';
    strSQL := strSQL + ' TINDOR.FDO_OBSCOL AS OBSCOL, ';
    strSQL := strSQL + ' TINDOR.FDO_EMPACA AS EMPACA, ';
    strSQL := strSQL + ' TINDOR.FDO_CODACA AS CODACA, ';
    strSQL := strSQL + ' CAST("" AS CHAR(10)) AS DTAULT,  ';
    strSQL := strSQL + '(SELECT CADLOT.LOT_NUMLOT     ';
    strSQL := strSQL + '   FROM CADLOT                ';
    strSQL := strSQL + ' WHERE CADLOT.LOT_CODITE = TINDOR.FDO_CODITE AND  ';
    strSQL := strSQL + '       CADLOT.LOT_CODEMP = :CODEMP AND            ';
    strSQL := strSQL + '       CADLOT.LOT_PRITIN = "S"                    ';
    strSQL := strSQL + ' LIMIT 1) AS NUMLOT,                              ';
    strSQL := strSQL + ' CAST("" AS CHAR(20)) AS SEQGER_DOCFAT ';
    strSQL := strSQL + 'FROM                           ';
    strSQL := strSQL + '  TINDOR                       ';
    strSQL := strSQL + '  JOIN CADCLI ON CLI_CODCLI = TINDOR.FDO_CODCLI        ';
    strSQL := strSQL + '  JOIN TINGOR ON TINGOR.AUTOINCREM = TINDOR.FDO_SEQGER ';
    strSQL := strSQL + '  JOIN FATGOR ON FATGOR.AUTOINCREM = TINGOR.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN FATDOR ON FATDOR.FDO_CODACA = TINDOR.FDO_CODACA ';
    strSQL := strSQL + '             AND FATDOR.FDO_EMPACA = TINDOR.FDO_EMPACA ';

    strSQL := strSQL + '             AND FATDOR.FDO_NUMDOC = TINDOR.FDO_NUMDOC ';
    strSQL := strSQL + '             AND FATDOR.FDO_ESPDOC = TINDOR.FDO_ESPDOC ';
    strSQL := strSQL + '             AND FATDOR.FDO_CODEMP = TINDOR.FDO_CODEMP ';

    // FOI COLOCADO AQUI PARA DIFERENCIAR A ESPECIE, JA QUE O CODACA E O EMPACA
    // SAO IGUAIS PARA PEDIDOS QUE FORAM ORIUNDOS DE UM ORÇAMENTO, SENDO ASSIM
    // DUPLICAVA OS REGISTROS NO GRID
    If (strCfgExi = 'OR') Then
      strSQL := strSQL + ' AND FATDOR.FDO_ESPDOC = "OR" '
    Else If (strCfgExi = 'PD') Then
      strSQL := strSQL + ' AND FATDOR.FDO_ESPDOC = "PD" '
    Else If Pos(strCfgExi, 'O_OP_OD_VP_DP_PE_AD_') > 0 Then
      strSQL := strSQL + ' :ESPECIE_1 ';

    strSQL := strSQL + '  JOIN CADITE ON CADITE.ITE_CODITE = TINDOR.FDO_CODITE ';
    strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '             AND ITEGER.ITE_CODEMP = :CODEMP ';
    strSQL := strSQL + '  LEFT JOIN FORTIN ON FATDOR.FDO_CODACA = FORTIN.FOR_CODACA ';
    strSQL := strSQL + '                  AND FORTIN.FOR_EMPACA = FATDOR.FDO_EMPACA ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = UNI_CODUNI ';
    strSQL := strSQL + '  LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';

    strSQL := strSQL + '  LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO  = FATDOR.AUTOINCREM ';

    //codigo de barras da formulacao
    strSQL := strSQL + '  LEFT JOIN CADACA ON ACA_CODACA = TINDOR.FDO_CODACA ';
    strSQL := strSQL + '                  AND ACA_CODEMP = TINDOR.FDO_EMPACA ';
    strSQL := strSQL + '  LEFT JOIN EXPARQ ON EXPARQ.AUTOINCREM = TINDOR.AUTOINCREM';

    strSQL := strSQL + '  LEFT JOIN CADITE EMB ON EMB.ITE_CODITE = FATDOR.FDO_ITEEMB ';

    If (Pos(strCfgExi,'O_OP_OD_VP_DP_OR_PE_AD_') <= 0) Then
      strSQL := strSQL + ' TABELA_TEMPORARIA ';

    strSQL := strSQL + 'WHERE (FDO_BAIXAD ' + strSinal + ' "' + strBaixad + '") ';
    strSQL := strSQL + '  AND FATDOR.FDO_ENTFUT <> "S" ';

    if fCfgSis('SEPFTI', varBoolean) then
      strSQL := strSQL + '  AND IF(FATGOR.FGO_SEPIMP = "N" OR IFNULL(FATGOR.FGO_SEPIMP, "") = "", "0", IF(FATGOR.FGO_SEPIMP = "S","1", FATGOR.FGO_SEPIMP)) IN ("1", "2") ';

    {Req.: 130709 - Oculta pedidos já agrupados!}
    strSQL := strSQL + '  AND (IFNULL(STRCMP((SELECT                                                         ';
    strSQL := strSQL + '                        IFNULL(G.FGO_ORIGEM, "AUTCOM")                               ';
    strSQL := strSQL + '                      FROM                                                           ';
    strSQL := strSQL + '                        FATGOR G                                                     ';
    strSQL := strSQL + '                      WHERE                                                          ';
    strSQL := strSQL + '                        G.FGO_NUMDOC = FATDOR.FDO_NUMFAT AND                         ';
    strSQL := strSQL + '                        G.FGO_ESPDOC = FATDOR.FDO_TIPFAT AND                         ';
    strSQL := strSQL + '                        G.FGO_CODEMP = FATDOR.FDO_EMPFAT), "AGRUPAMENTO"), -1) = -1) ';

    If (strCfgExi = 'OR') Then
      strSQL := strSQL + ' AND TINGOR.FGO_ESPDOC = "OR" '
    Else If (strCfgExi = 'PD') Then
    Begin
      strSQL := strSQL + ' AND TINGOR.FGO_ESPDOC = "PD" ';
      strSQL := strSQL + ' AND IFNULL(FATGOR.FGO_LIBERA, 0) > 0 ';
      strSQL := strSQL + ' AND IFNULL(FATGOR.FGO_LIBCOM, 0) > 0 ';
    End
    Else If Pos(strCfgExi, 'O_OP_OD_VP_DP_PE_AD_') > 0 Then
    Begin
      strSQL := strSQL + ' :ESPECIE_2 ';
      strSQL := strSQL + ' :LIBERA ';
      strSQL := strSQL + ' :LIBCOM ';
    End;

    If fApenasBaixados Then
    Begin
      strSQL := strSQL + ' AND (FDO_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) + '" AND "' +
                                                        FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '")';
    End
    else
    Begin
      If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
        strSQL := strSQL + ' AND (TINDOR.FDO_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                                     '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '")';
    end;

    If Pos(strCfgExi,'O_OP_OD_VP_DP_OR_PE_AD_') <= 0 Then
    begin
      strSQLTmp := strSQL;

      strSQL := fRetSQLFormulacaoLoja(strSQLTmp);

      strSQL := strSQL +' UNION  ALL '+ fRetSQLFormulacaoForaLoja(strSQLTmp);
      strSQL := strSQL +' UNION  ALL '+ fRetSQLFormulacaoCd(strSQLTmp);
      strSQL := strSQL +' UNION  ALL '+ fRetSQLFormulacaoAbastecimentoPorDeposito(strSQLTmp);

    end
    else
    begin
      strSQL := strSQL + ' AND ( ';
      strSQL := strSQL + '       (FATGOR.FGO_ENT_CD = "N" AND FATGOR.FGO_OPRFLJ = "N" AND FATGOR.FGO_CODEMP = :CODEMP) ';

      If (fCfgSis('ENT_CD', varBoolean))  Then
        strSQL := strSQL + '  OR (FATGOR.FGO_ENT_CD = "S" AND FATGOR.FGO_OPRFLJ = "N" AND EXTGOR.FGO_EMP_CD = :CODEMP) ';

      strSQL := strSQL + '    OR (FATGOR.FGO_ENT_CD = "N" AND FATGOR.FGO_OPRFLJ = "S" AND FATDOR.FDO_EMPPRD = :CODEMP) ';
      strSQL := strSQL + '     ) ';
    end;


    {**************************************************}
    {*CONTROLA A EXIBIÇÃO ( O = ORÇAMENTO/PEDIDO )    *}
    {**************************************************}
    If Pos(strCfgExi, 'O_OP_OD_VP_DP_PE_AD_') > 0 Then
    Begin
      strSQL3  := strSQL;

      If Pos(strCfgExi, 'O_OP_OD_AD_') > 0 Then
      Begin
        strSQL   := AnsiReplaceStr(strSQL,  ':ESPECIE_1', ' AND FATDOR.FDO_ESPDOC = "OR" ');
        strSQL   := AnsiReplaceStr(strSQL,  ':ESPECIE_2', ' AND TINGOR.FGO_ESPDOC = "OR" ');
        strSQL   := AnsiReplaceStr(strSQL,  ':LIBERA'   , ' ');
        strSQL   := AnsiReplaceStr(strSQL,  ':LIBCOM'   , ' ');
      End
      Else
      Begin
        strSQL := AnsiReplaceStr(strSQL,    ':ESPECIE_1', ' AND FATDOR.FDO_ESPDOC = "PD" ');
        strSQL := AnsiReplaceStr(strSQL,    ':ESPECIE_2', ' AND TINGOR.FGO_ESPDOC = "PD" ');
        strSQL := AnsiReplaceStr(strSQL,    ':LIBERA'   , ' AND IFNULL(FATGOR.FGO_LIBERA, 0) > 0 ');
        strSQL := AnsiReplaceStr(strSQL,    ':LIBCOM'   , ' AND IFNULL(FATGOR.FGO_LIBCOM, 0) > 0 ');
      End;

	  //PARA NAO APARECER O ORÇAMENTO EM QUE O PEDIDO FOI FATURADO	
	  If Pos(strCfgExi, 'O_OP_OD_AD_') > 0 Then
        strSQL   := strSQL + ' AND FATGOR.FGO_TIPFAT <> "PD" ';


      strSQL3  := AnsiReplaceStr(strSQL3, ':ESPECIE_1', ' AND FATDOR.FDO_ESPDOC = "PD" ');
      strSQL3  := AnsiReplaceStr(strSQL3, ':ESPECIE_2', ' AND TINGOR.FGO_ESPDOC = "PD" ');
      strSQL3  := AnsiReplaceStr(strSQL3, ':LIBERA'   , ' AND IFNULL(FATGOR.FGO_LIBERA, 0) > 0 ');
      strSQL3  := AnsiReplaceStr(strSQL3, ':LIBCOM'   , ' AND IFNULL(FATGOR.FGO_LIBCOM, 0) > 0 ');

      If Pos(strCfgExi, 'O_AD_') > 0 Then
      Begin
        strSQL   := strSQL + ' UNION ALL ' + strSQL3;
      End;

      If strCfgExi <> 'PE' Then
        strSQL := strSQl + ' UNION ALL ' + fRetSQLOrdemProdAvulsa;

      If strCfgExi = 'PE' Then
        strSQL := strSQL + ' UNION ALL ' + fRetSQLEmprestimos;

      If (Pos(strCfgExi, 'OD_DP_AD_') > 0) And (strCfgExi <> 'O') Then
        strSQL := strSQL + ' UNION ALL ' + fRetSQLVendasDiretas;
    End;

  End;

  strSQL  := strSQL + ' ORDER BY DESTINO , 4 DESC, 5 DESC';

  qryTinMaq := fCriaQuery;
  try
    qryTinMaq.SQL.Add(strSQL);
    qryTinMaq.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTinMaq.Open;

    If Assigned(cdsTinMaq) Then
      FreeAndNil(cdsTinMaq);

    cdsTinMaq := fCriaClientDatSet(qryTinMaq);
    dtsTinMaq.DataSet := cdsTinMaq;
    cdsTinMaq.AfterScroll := pAtualizaDados;
  finally
    FreeAndNil(qryTinMaq);
  end;

  With cdsTinMaq Do
  Begin
    If (strCfgExi = 'PD') And (blnSTFNTI) Then
      pAddProgresso('Aguarde... Atualizando Qtde. das Embalagens / Situação Financeira dos Pedidos...')
    Else
      pAddProgresso('Aguarde... Atualizando Quantidade das Embalagens...');

    DisableControls;
    First;

    While Not Eof Do
    Begin
      Edit;

      If fCfgSis('EDTIUC') = 'S' Then
      Begin
        If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
        Begin
          strSeqGerDocFat := cdsTinMaq.FieldByName('SEQGER_DOCFAT').AsString;
        End
        Else
        Begin
          strSeqGerDocFat := fCampoTabela('IFNULL(DET_SEQGER,"")', 'MOVDET', ['DET_NUM_PD',
                                                                              'DET_ESP_PD',
                                                                              'DET_EMP_PD'],
                                                                             [cdsTinMaq.FieldByName('FDO_NUMDOC').AsString,
                                                                              cdsTinMaq.FieldByName('FDO_ESPDOC').AsString,
                                                                              cdsTinMaq.FieldByName('FDO_CODEMP').AsString]);
        End;

        strSeqGerDocFat := Trim(strSeqGerDocFat);
        If Length(strSeqGerDocFat) = 20 Then
          strSeqGerDocFat := '"'+strSeqGerDocFat+'"';

        FieldByName('DTAULT').AsString := fRetornaUltimaVenda(FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODCLI').AsString,
                                                              FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_IDEPRO').AsString,
                                                              FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ITETIN').AsString,
                                                              strSeqGerDocFat);
      End;

      For intContador := 1 To 15 Do
      Begin
        With fField('QTDB' + fPadL(IntToStr(intContador), 2, '0')) Do
        Begin
          If (fField('QTDEMB').AsFloat > fField('QTDITE').AsFloat) Then
            AsFloat := AsFloat / fField('QTDITE').AsFloat
          Else If (fField('QTDEMB').AsFloat > 0) Then
            AsFloat := AsFloat / fField('QTDEMB').AsFloat
          Else
            AsFloat := AsFloat / fField('QTDITE').AsFloat;
        End;
      End;

      If (strCfgExi = 'PD') And (blnSTFNTI) Then
      Begin
        If fSituacaoFinanceiraPedidoOk(strPenFin) Then
          FieldByName('SITFIN').AsString := 'OK'
        Else
          FieldByName('SITFIN').AsString := '';
      End;

      Post;
      Next;
    End;

    First;
    EnableControls;
  End;

  pAddProgresso('');
  pgbProgresso.Visible := False;

  pTrimAppMemorySize;
end;

procedure TfrmFatFormulacaoItens.pDeletaLotDorGravado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte: String);
  Var
    qryLotDor : TUniQuery;
Begin
  Try
    qryLotDor := fCriaQuery();

    qryLotDor.SQL.Add(' SELECT LOTDOR.AUTOINCREM                              ');
    qryLotDor.SQL.Add(' FROM LOTDOR                                           ');
    qryLotDor.SQL.Add('   INNER JOIN FATDOR ON FATDOR.AUTOINCREM = LDO_SEQFDO ');
    qryLotDor.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC                            ');
    qryLotDor.SQL.Add('   AND FDO_ESPDOC = :ESPDOC                            ');
    qryLotDor.SQL.Add('   AND FDO_CODEMP = :CODEMP                            ');
    qryLotDor.SQL.Add('   AND FDO_CODCLI = :CODCLI                            ');
    qryLotDor.SQL.Add('   AND FDO_CODITE = :CODITE                            ');

    qryLotDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryLotDor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryLotDor.ParamByName('CODEMP').AsString := strCodEmp;
    qryLotDor.ParamByName('CODCLI').AsString := strCodCli;
    qryLotDor.ParamByName('CODITE').AsString := strCodIte;

    qryLotDor.Open;

    pExecutaSQL('DELETE FROM LOTDOR WHERE AUTOINCREM = ' + QuotedStr(qryLotDor.FieldByName('AUTOINCREM').AsString),[],[]);

    qryLotDor.Close;

  Finally
    FreeAndNil(qryLotDor);
  End;

end;

procedure TfrmFatFormulacaoItens.pDeletarRegistroPorFiltro;
Var
  LNomCam: String;
begin
  LNomCam := '';

  While Not cdsTinMaq.Eof Do
  Begin
    If Not fEmptyStr(FFiltroCodIte) Then
    Begin
      If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
        LNomCam := 'DET_CODITE'
      Else
        LNomCam := 'FDO_CODITE';

      If cdsTinMaq.FieldByName(LNomCam).AsString <> FFiltroCodIte Then
      Begin
        cdsTinMaq.Delete;
        Continue;
      End;
    End;

    If Not fEmptyStr(FFiltroCodCli) Then
    Begin
      If cdsTinMaq.FieldByName('CLI_CODCLI').AsString <> FFiltroCodCli Then
      Begin
        cdsTinMaq.Delete;
        Continue;
      End;
    End;

    If Not fEmptyStr(FFiltroNumDoc) Then
    Begin
      If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
        LNomCam := 'DET_NUMDOC'
      Else
        LNomCam := 'FDO_NUMDOC';

      If cdsTinMaq.FieldByName(LNomCam).AsString <> FFiltroNumDoc Then
      Begin
        cdsTinMaq.Delete;
        Continue;
      End;
    End;

    If Not fEmptyStr(FFiltroDocFat) Then
    Begin
      If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
        LNomCam := 'DET_ESPDOC'
      Else
        LNomCam := 'FDO_ESPDOC';

      If Pos(cdsTinMaq.FieldByName(LNomCam).AsString, 'OR_PD_') > 0 Then
      Begin
        If cdsTinMaq.FieldByName('FGO_NUMFAT').AsString <> FFiltroDocFat Then
        Begin
          cdsTinMaq.Delete;
          Continue;
        End;
      End
      Else
      Begin
        cdsTinMaq.Delete;
        Continue;
      End;
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(FFiltroDtaCad)) Then
    Begin
      If cdsTinMaq.FieldByName('DTAENT').AsDateTime <> StrToDate(FFiltroDtaCad) Then
      Begin
        cdsTinMaq.Delete;
        Continue;
      End;
    End;

    cdsTinMaq.Next;
  End;
end;

procedure TfrmFatFormulacaoItens.pDeletaTempEtiFormulacao;
  Var
    strSQL: String;
begin
  If fTabelaExiste(strTabFor) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'DROP TABLE ' + strTabFor;
    With qryFormul Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;
end;

procedure TfrmFatFormulacaoItens.pDeletaTemporaria;
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;
  If cdsTinMaq.Active Then
    cdsTinMaq.EmptyDataSet;
end;

procedure TfrmFatFormulacaoItens.FormShow(Sender: TObject);
begin
  inherited;
  VS_strCliFilLocal := fRetClientesFilial;
  strCfgExi := fCfgSis('EXIDOC');
  blnSTFNTI := (fCfgSis('STFNTI', varBoolean));

  If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
    memMenFor.Visible := False;

  btnImpEtiqProd.Visible := (strCfgExi = 'V') Or (strCfgExi = 'PA') ;

  lblSitFin.Visible := (strCfgExi = 'PD') And (blnSTFNTI);
  cmbSitFin.Visible := lblSitFin.Visible;
End;

procedure TfrmFatFormulacaoItens.btnCancelarFormClick(Sender: TObject);
begin
  If fApenasBaixados Then
  Begin
    btnImprimir.Enabled    := True;
    btnBaixar.Caption      := '[ F9 ] Baixar';
    btnAtualizar.Enabled   := True;
    btnBaiTin.Enabled      := True;
    btnImpOrd.Enabled      := True;
    btnAltTipTin.Enabled   := True;
    btnImpEtiqProd.Enabled := True;
    btnApagar.Enabled      := True;
    gpbPeriodo.Caption     := 'Período de Entrada';
    btnDesmBaixa.Visible   := True;

    mskDtaIni.Text := DateToStr(VS_Date - FDiasData);
    mskDtaFin.Text := DateToStr(VS_Date);

    btnAtualizar.Click;

    pSetFocus(mskDtaIni);

    Exit;
  End;

  inherited;
  Close;
end;

procedure TfrmFatFormulacaoItens.btnCarregBaixaClick(Sender: TObject);
begin
  inherited;
  FFiltroCodIte := '';
  FFiltroCodCli := '';
  FFiltroNumDoc := '';
  FFiltroDocFat := '';
  FFiltroDtaCad := '';

  pFinalizarThreadNotTinDisp(False);

  btnAtualizar.Click;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.btnDesmBaixaClick(Sender: TObject);
  Var
    strSenha : String;
    strCodOpe: String;
begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  If ffrmSenha(strSenha, 'Operador Solicitante') Then
  Begin
    strCodOpe := fRetCodVendedor(strSenha);

    If fEmptyStr(strCodOpe) Then
      pMensagemOk('Operador não cadastrado!')

    Else If Not fVerificaAcessoSistema('DESBOP', strCodOpe) Then
      pMensagemOk('Este operador não tem direitos para desmarcar baixa de uma formulação!')

    Else
    Begin
      btnImprimir.Enabled    := False;
      btnBaixar.Caption      := '[F9] Desmarcar';
      btnBaixar.Enabled      := False;
      btnAtualizar.Enabled   := False;
      btnBaiTin.Enabled      := False;
      btnImpOrd.Enabled      := False;
      btnAltTipTin.Enabled   := False;
      btnImpEtiqProd.Enabled := False;
      btnApagar.Enabled      := False;
      gpbPeriodo.Caption     := 'Período de Baixa';
      btnDesmBaixa.Visible   := False;

      mskDtaIni.Text := DateToStr(VS_Date - FDiasData);
      mskDtaFin.Text := DateToStr(VS_Date);

      pDeletaTemporaria;
      pSetFocus(mskDtaIni);

    End;

  End;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.btnExportarRegistrosClick(Sender: TObject);
begin
  inherited;
  If Not Assigned(cdsTinMaq) Then
    Exit;

  Try
    btnAtualizar.Click;
    Screen.Cursor := crDefault;

    pCriarFormularios(TfrmExportarArquivosTinta, frmExportarArquivosTinta);

    frmExportarArquivosTinta.cdsAux := TUniClientDataSet.Create(Nil);

    pCloneDataSet(frmExportarArquivosTinta.cdsAux , cdsTinMaq);

    frmExportarArquivosTinta.ShowModal;
  Finally
    If Assigned(frmExportarArquivosTinta) Then
      pFreeAndNil(frmExportarArquivosTinta);
  End;
end;

procedure TfrmFatFormulacaoItens.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  Case Key Of
    VK_Escape: btnCancelarForm.Click;
    VK_Return:
    Begin
      If (fPermiteProsseguirAcao) Then
      Begin
        If (Not fApenasBaixados) And (fCfgSis('ETIENT') = '1') Then
        Begin
          If Not (dbgItens.DataSource.DataSet.IsEmpty) Then
            pMostraFormulacoes;
        End
        Else
        Begin
          If (fApenasBaixados) Then
            pMarcarBaixa;
        End;
      End;
    End;
    VK_Delete: If (Not fApenasBaixados) Then btnApagar.Click;
  End;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.dbgItensTitleClick(Column: TColumn);
var
  idxName: string;
  ordenacao: TIndexOptions;
  intContador: Integer;
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;

  pFinalizarThreadNotTinDisp(False);

  for intcontador := 0 to dbgItens.Columns.count-1 do
  begin
    dbgItens.Columns[intContador].Color := clWhite;
  end;

  // configura a ordenação ascendente ou descendente
  if cdsTinMaq.IndexName = Column.FieldName + '_ASC' then
  begin
    idxName := Column.FieldName + '_DESC';
    ordenacao := [ixDescending];
  end
  else
  begin
    idxName := Column.FieldName + '_ASC';
    ordenacao := [];
  end;

  if cdsTinMaq.IndexDefs.IndexOf(idxName) < 0 then
    cdsTinMaq.AddIndex(idxName, Column.FieldName, ordenacao);

  cdsTinMaq.IndexDefs.Update;
  cdsTinMaq.IndexName := idxName;

  column.Color := clInfoBk;

  If cdsTinMaq.Active Then
    cdsTinMaq.First;

  inherited;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.pMarcarBaixa;
begin
  If (fApenasBaixados) Then
  begin
    dbgItens.DataSource.DataSet.Edit;

    If (dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString = 'N') Then
    begin
      dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString := 'S';
      Inc(intQtdSel);
    end
    else
    begin
      dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString := 'N';
      Dec(intQtdSel);
    end;

    dbgItens.DataSource.DataSet.Post;

    btnBaixar.Enabled := (intQtdSel > 0);

  end;
end;

procedure TfrmFatFormulacaoItens.pMostraFormulacoes;
Var
  strNomCam: String;
  intRecNo: Integer;
  fatFormulacao: IFatFormulacao;
  intRecordCount: Integer;
  strAutInc: String;

  procedure pAjustaTamanho(frmForm: TForm; btnConfirma: TBitBtnLocked; memNomBas: TMemo = Nil; strDescri: String = '');
  begin
    If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
      strNomCam := 'DET_CODITE'
    Else
      strNomCam := 'FDO_CODITE';

    If Assigned(memNomBas) Then
    Begin
      memNomBas.Text := 'BASE: ' + dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString + '-' +
                        fRetNomProduto(dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString);

      If Not fEmptyStr(strDescri) Then
        memNomBas.Text := memNomBas.Text + #13#10 + 'COR: ' + strDescri;
    End;
  end;

  function fDescri: String;
  begin
    If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
      Result := 'DET_DESCRI'
    Else
      Result := 'FDO_DESCRI';
  end;
begin
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  If (Not IsTintaExistente(dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString)) Then
  Begin
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
    Exit;
  End;

  If fExibeMensagemTintaNaoEncontrada Then
  Begin
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
    Exit;
  End;

  strAutInc := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;

  //Verifica se outra estacao ja esta utilizando o registro
  If (Not fLock_Unlock(strAutInc, True, False)) Then
  Begin
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                  fGetHostLock(dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString)  + '!', ['&Ok']);
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
    Exit;
  End;

  Try
    {************************************}
    {* ENTRA NO STATUS EM PROCESSAMENTO *}
    {*********************************RV*}
    pAtualizaStatusProcessamento(strAutInc, True);

    intRecNo := dbgItens.DataSource.DataSet.RecNo;

    intRecordCount := dbgItens.DataSource.DataSet.RecordCount;

    btnAtualizar.Click;

    If intRecordCount <> dbgItens.DataSource.DataSet.RecordCount Then
    Begin
      fMensagem('ATENÇÃO', 'Os documentos foram atualizados, por favor rever os documentos' + #13#10 +
                ' e executar a operação novamente !', ['&Ok']);
      Exit;
    End;

    dbgItens.DataSource.DataSet.RecNo := intRecNo;

    Screen.Cursor := crDefault;
    Application.ProcessMessages;

    If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
      strNomCam := 'DET_IDEPRO'
    Else
      strNomCam := 'FDO_IDEPRO';

    With cdsTinMaq Do
    Begin

      fatFormulacao := TFatFormulacaoFactory.GetIFatFormulacao(FieldByName(strNomCam).AsString);
      if Assigned(fatFormulacao) then
      begin
        frmFatFormulacaoGeneric := nil;
        Try
          Try
            frmFatFormulacaoGeneric := TfrmFatFormulacaoGeneric.Create(Self, fatFormulacao);
            frmFatFormulacaoGeneric.strEspDoc := Self.strEspDoc;
            pAjustaTamanho(frmFatFormulacaoGeneric, frmFatFormulacaoGeneric.btnImprimir, frmFatFormulacaoGeneric.mmoBase, FieldByName(fDescri).AsString);
            frmFatFormulacaoGeneric.strAutInc := FieldByName('AUTOINCREM').AsString;
            frmFatFormulacaoGeneric.strDescri := FieldByName(fDescri).AsString;
            frmFatFormulacaoGeneric.showModal;
          Except
            on E: Exception do
            begin
              raise;
            end;
          End;
        Finally
          if Assigned(frmFatFormulacaoGeneric) then
            FreeAndNil(frmFatFormulacaoGeneric);
        End;
      end
      else
      Begin
        Try
          frmFatFormulacaoTintas := TfrmFatFormulacaoTintas.Create(Nil);
          frmFatFormulacaoTintas.strEspDoc := Self.strEspDoc;

          if fTipoTinta(FieldByName(strNomCam).AsString) = ttImobiliaria then
            pAjustaTamanho(frmFatFormulacaoTintas, frmFatFormulacaoTintas.btnImprimir, frmFatFormulacaoTintas.mmoBase, FieldByName(fDescri).AsString);

          If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
            strNomCam := 'DET_IDEPRO'
          Else
            strNomCam := 'FDO_IDEPRO';

          frmFatFormulacaoTintas.strAutInc := FieldByName('AUTOINCREM').AsString;
          frmFatFormulacaoTintas.strIdePro := FieldByName(strNomCam).AsString;
          frmFatFormulacaoTintas.strDescri := FieldByName(fDescri).AsString;

          frmFatFormulacaoTintas.showModal;

        Finally
          FreeAndNil(frmFatFormulacaoTintas);
        End;
      End;

    End;

  Finally
    {**********************************}
    {* SAI DO STATUS EM PROCESSAMENTO *}
    {*******************************RV*}
    pAtualizaStatusProcessamento(strAutInc, False);

    fLock_Unlock(strAutInc, False, False);

    intRecNo := dbgItens.DataSource.DataSet.RecNo;

    btnAtualizar.Click;

    dbgItens.DataSource.DataSet.RecNo := Min(intRecNo, dbgItens.DataSource.DataSet.RecordCount);

    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  End;
end;

procedure TfrmFatFormulacaoItens.btnImpAjusteClick(Sender: TObject);
Var
  intQtdImp: Integer;
  strNumFat: String;
  intPos: Integer;
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;

  If Not fVerificaExisteAjuste Then
  Begin
    fMensagem('', 'Não existe nenhum ajuste vinculado a este documento!', ['&Ok']);
    Exit;
  End;

  intQtdImp := 1;

  If (fCfgSis('VIA_AJ', varBoolean)) Then
    intQtdImp := fGetMenu('Qtd. Vias', ['1 Via', '2 Vias', '3 Vias', '4 Vias'], 1)
  Else
  Begin
    If fCfgSis('QTDVAJ', varInteger) > 1 Then
      intQtdImp := fCfgSis('QTDVAJ', varInteger);
  End;

  {***********************************************************}
  {** VERIFICA A QUANTIDADE DE AJUSTE SE EXISTIR MAIS DE 1  **}
  {** HABILITA LISTA DE AJUSTES E A DATA QUE FOI FEITO O AJ **}
  {********************************************************RG*}

  strNumFat := fRetornaAjuste();
  intPos := Pos('|', strNumFat);
  strNumFat := Trim(Copy(strNumFat, intPos + 1, 12));

  If (Pos('AJ', fCfgSis('ESP40C')) > 0) Or (fCfgSis('MODIMP') = '1') Then
    pImprimeTicketIF(strNumFat, 'ML', fCfgSis('CLIAJU'), intQtdImp)
  Else
    pImprimeAjuste(strNumFat, 'ML', intQtdImp);
end;

procedure TfrmFatFormulacaoItens.btnImpEtiqProdClick(Sender: TObject);
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;

  TfrmGravando.fExecutarModalA(pImpEtiProd, 'Aguarde, Imprimindo etiqueta de produção ...', '');
end;

procedure TfrmFatFormulacaoItens.pImpEtiProd;
begin
  inherited;

  If (Not fPermiteProsseguirAcao) Then
    Exit;

  pFinalizarThreadNotTinDisp(False);

  If Not dbgItens.DataSource.DataSet.IsEmpty Then
    pChamaFormularioDadosEtiqProducao;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.btnImpOrdClick(Sender: TObject);
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;
  TfrmGravando.fExecutarModalA(pImpOrdemProd, 'Aguarde, Imprimindo ordem de produção ...', '');
end;

procedure TfrmFatFormulacaoItens.pImpOrdemProd;
  Var
    strMsgOpr: String;
    qryAux   : TUniQuery;
    blnImpOrd: Boolean;
    strChave : String;
begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  // Valida se existe registro na grid.
  If (dbgItens.DataSource.DataSet.IsEmpty) then
  begin
    fMensagem('','Selecione algum registro para continuar com a operação!', ['&Ok']);
    pFinalizarThreadNotTinDisp(True);
    Exit;
  end;

  If (Not fPermiteProsseguirAcao) Then
  Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If Not IsTintaExistente(dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString) Then Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If (dbgItens.DataSource.DataSet.FieldByName('ORDIMP').AsString = 'S') Then
  Begin
    If ffrmSenha(strSenha) And (Not fEmptyStr(fRetCodVendedor(strSenha))) And
       fVerificaAcessoSistema('OPJAIM', fRetCodVendedor(strSenha)) Then
      blnImpOrd := True
    Else
      blnImpOrd := False;
  End
  Else
    blnImpOrd := True;

  If blnImpOrd And (Assigned(objImpOrdPro)) Then
  Begin

    If (Pos(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ESPDOC').AsString, '_OR_PD_') > 0) Then
      strMsgOpr := 'Imprimir ordem de produção preliminar?'
    Else
      strMsgOpr := 'Imprimir ordem de produção?';

    objImpOrdPro.pSetaDocumento(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA')  , 'DET', 'FDO') + '_NUMDOC').AsString,
                                dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ESPDOC').AsString,
                                dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODEMP').AsString,
                                dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODCLI').AsString,
                                dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_EMPPRD').AsString,
                                dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODACA').AsString,
                                dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_EMPACA').AsString);

    If (objImpOrdPro.fGetTemFormula) Then
    Begin

      If (fMensagem('ATENÇÃO!', strMsgOpr, ['&Sim', '&Não']) = 1) Then
      Begin
        Try
          objImpOrdPro.pImprimeOrdProdTmp(False,
                                          dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPPRD').AsString);
        Finally
          SetForegroundWindow(Self.Handle);
        End;

        qryAux := fCriaQuery(Self);
        qryAux.SQL.Clear;
        qryAux.SQL.Add('  UPDATE                 ');

        If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
        Begin
          qryAux.SQL.Add('TINDET                 ');
          qryAux.SQL.Add('SET DET_ORDIMP = TRUE  ');
        End
        Else
        Begin
          qryAux.SQL.Add('  TINDOR              ');
          qryAux.SQL.Add('SET FDO_ORDIMP = TRUE  ');
        End;

        qryAux.SQL.Add('  WHERE                  ');
        qryAux.SQL.Add('    AUTOINCREM = :AUTINC ');

        qryAux.ParamByName('AUTINC').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;
        qryAux.ExecSQL;

        FreeAndNil(qryAux);

        strChave := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;

        btnAtualizar.Click;

        dbgItens.DataSource.DataSet.Locate('AUTOINCREM', strChave, []);
      End;
    End;
  End;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.btnImprimirClick(Sender: TObject);
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;
  TfrmGravando.fExecutarModalA(pImprimir, 'Aguarde, Realizando impressão ...', '');
end;

procedure TfrmFatFormulacaoItens.btnImpSepClick(Sender: TObject);
begin
  inherited;
  If Not Assigned(cdsTinMaq) Then
    Exit;

  If Assigned(objLotePedidoWMS) Then
    objLotePedidoWMS.fDigitaLotesPedidoWMS(cdsTinMaq.FieldByName('FDO_NUMDOC').AsString,
                                           cdsTinMaq.FieldByName('FDO_CODEMP').AsString,
                                           cdsTinMaq.FieldByName('FDO_CODCLI').AsString,
                                           cdsTinMaq.FieldByName('FDO_CODITE').AsString);
end;

procedure TfrmFatFormulacaoItens.btnPesquisarClick(Sender: TObject);
Var
  LFrmFiltrosFormulacao: TfrmFiltrosFormulacao;
  blnNaoFiltrou: Boolean;
begin
  inherited;
  Try
    pCriarFormularios(TfrmFiltrosFormulacao, LFrmFiltrosFormulacao);

    If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
      LFrmFiltrosFormulacao.blnDocFat := False;

    LFrmFiltrosFormulacao.ShowModal;

    If LFrmFiltrosFormulacao.ModalResult = mrOk Then
    Begin
      blnNaoFiltrou := False;
      FFiltroCodIte := LFrmFiltrosFormulacao.FCodIte;
      FFiltroCodCli := LFrmFiltrosFormulacao.FCodCli;
      FFiltroNumDoc := LFrmFiltrosFormulacao.FNumDoc;
      FFiltroDocFat := LFrmFiltrosFormulacao.FDocFat;
      FFiltroDtaCad := LFrmFiltrosFormulacao.FDtaIni;
    End
    Else
      blnNaoFiltrou := True;
  Finally
    If Assigned(LFrmFiltrosFormulacao) Then
      FreeAndNil(LFrmFiltrosFormulacao);
  End;

  If Not blnNaoFiltrou Then
    btnAtualizar.Click;
end;

procedure TfrmFatFormulacaoItens.btnRealizarAjusteClick(Sender: TObject);
Var
  frmAjuFor: TfrmAjusteEstoqueFormulacao;
  strNomCam: String;
  strNumDEE: String; //Documento + Especie + Empresa
  qryAux: TUniQuery;
  strChave: String;
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;

  Try
    If (Not IsTintaExistente(dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString)) Then
    Begin
      Application.ProcessMessages;
      Exit;
    End;

    frmAjuFor := TfrmAjusteEstoqueFormulacao.Create(Self);

    If (strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0)  Then
      strNomCam := 'DET_IDEPRO'
    Else
      strNomCam := 'FDO_IDEPRO';


    strNumDEE := Self.strNumDoc + '-' + Self.strEspDoc + '-' + Self.strCodEmp;

    frmAjuFor.strAutoincrem := cdsTinMaq.FieldByName('AUTOINCREM').AsString;
    frmAjuFor.strIdePro := cdsTinMaq.FieldByName(strNomCam).AsString;

    If (strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0) Then
      strNomCam := 'DET_CODVEN'
    Else
      strNomCam := 'FDO_CODVEN';

    frmAJuFor.strOperador := cdsTinMaq.FieldByName(strNomCam).AsString;

    If (strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0)  Then
      strNomCam := 'DET_DTAENT'
    Else
      strNomCam := 'FDO_DTAENT';

    frmAjuFor.dtaDtaEnt := VS_Date;
    frmAJuFor.strEspDoc := Self.strEspDoc;
    frmAjuFor.strNumDoc := strNumDEE;
    frmAjuFor.strCliente := Self.strCodCli;
    frmAjuFor.strDocumento := Self.strNumDoc;
    frmAjuFor.strEmpresa := Self.strCodEmp;
    frmAjuFor.strCodAca := cdsTinMaq.FieldByName('CODACA').AsString;
    frmAjuFor.strEmpAca := cdsTinMaq.FieldByName('EMPACA').AsString;

    If (strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0)  Then
      strNomCam := 'DET_CODITE'
    Else
      strNomCam := 'FDO_CODITE';

    frmAjuFor.strItem := cdsTinMaq.FieldByName(strNomCam).AsString;
    frmAJuFor.ShowModal;

    If frmAJuFor.blnAjuste Then
    Begin
      qryAux := fCriaQuery();
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('  UPDATE                  ');

      If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0)  Then
      Begin
        qryAux.SQL.Add('  TINDET              ');
        qryAux.SQL.Add('    SET DET_AJUFOR = "S"    ');
      End
      Else
      Begin
        qryAux.SQL.Add('  TINDOR              ');
        qryAux.SQL.Add('    SET FDO_AJUFOR = "S"        ');
      End;

      qryAux.SQL.Add('  WHERE                   ');
      qryAux.SQL.Add('    AUTOINCREM = :AUTINC          ');

      qryAux.ParamByName('AUTINC').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;
      qryAux.ExecSQL;

      FreeAndNil(qryAux);

      strChave := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;

      btnAtualizar.Click;

      dbgItens.DataSource.DataSet.Locate('AUTOINCREM', strChave, []);
    End;
  Finally
    FreeAndNil(frmAjuFor);
  End;
end;

procedure TfrmFatFormulacaoItens.pImprimir;
  Var
    qryAux   : TUniQuery;
    intRecNo : Integer;
    strCodOpe: String;
    strMsg   : String;
    blnImprimeEtiqEnt : Boolean;
    strOperador: String;
    objLiberacao : ILiberacao;
    strNumdoc,
    strEspDoc,
    strCodEmp  : String;
begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  strCodOpe := '';
  strOperador := '';

  // Valida se existe registro na grid.
  If (dbgItens.DataSource.DataSet.IsEmpty) then
  begin
    fMensagem('','Selecione algum registro para continuar com a operação!', ['&Ok']);
    pFinalizarThreadNotTinDisp(True);
    Exit;
  end;

  If (Not fPermiteProsseguirAcao) Then
  Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  {*************************************************}
  {* CONFIGURADO PARA IMPRIMIR ETIQUETAS SEPARADAS *}
  {**********************************************RV*}
  If (fCfgSis('ETIENT') = '1') Then
  Begin
    If (fMensagem('', 'Confirma impressão da etiqueta?', ['&Sim', '&Não']) = 2) Then Begin
      pFinalizarThreadNotTinDisp(True);
      Exit;
    End;

    If fCfgSis('SENENT') <> 'N' Then
    Begin
      If ffrmSenha(strSenha, 'Operador Solicitante:') Then
      Begin
        strCodOpe := fRetCodVendedor(strSenha);
        If fEmptyStr(strCodOpe) Then
        Begin
          pMensagemOk('Usuário não existente!');
          pFinalizarThreadNotTinDisp(True);
          Exit;
        End;
      End
      Else
      Begin
        pFinalizarThreadNotTinDisp(True);
        Exit;
      End;
    End;

    If Not fEmptyStr(strCodOpe) Then
      strOperador := strCodOpe + ' - ' + fRetNomVendRep(strCodOpe);

    If Not (fVerificaAcessoSistema('RIMETIENT', fRetCodVendedor(strCodOpe))) And
      (fVerificaImpressaoEtiquetaEntrega(dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString)) Then
    Begin
      objLiberacao := TLiberacaoFactory.fGetLiberacao();
      objLiberacao.objMsgLibera.Clear;
      objLiberacao.objMsgRemota.Clear;
      objLiberacao.objMsgLibera.lstRegistros.OwnsObjects := False;
      objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------------------------------');
      objLiberacao.objMsgLibera.pAddTexto('              REIMPRESSÃO DE ETIQUETA DE ENTREGA DE TINTOMÉTRICO                ');
      objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------------------------------');

      If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
      Begin
        strNumdoc := dbgItens.DataSource.DataSet.FieldByName('DET_NUMDOC').AsString;
        strEspDoc := dbgItens.DataSource.DataSet.FieldByName('DET_ESPDOC').AsString;
        strCodEmp := dbgItens.DataSource.DataSet.FieldByName('DET_CODEMP').AsString;

        objLiberacao.objMsgLibera.pAddTexto('Documento  : ' + dbgItens.DataSource.DataSet.FieldByName('DET_NUMDOC').AsString + '-' +
                                                              dbgItens.DataSource.DataSet.FieldByName('DET_ESPDOC').AsString + '-' +
                                                              dbgItens.DataSource.DataSet.FieldByName('DET_CODEMP').AsString);
        objLiberacao.objMsgLibera.pAddTexto('Cliente    : ' + dbgItens.DataSource.DataSet.FieldByName('DET_CODCLI').AsString + '-' +
                                                              dbgItens.DataSource.DataSet.FieldByName('DET_NOMCLI').AsString);
        objLiberacao.objMsgLibera.pAddTexto('Vendedor   : ' + dbgItens.DataSource.DataSet.FieldByName('DET_CODVEN').AsString + '-' +
                                                              fRetNomVendRep(dbgItens.DataSource.DataSet.FieldByName('DET_CODVEN').AsString));
        objLiberacao.objMsgLibera.pAddTexto('Produto    : ' + dbgItens.DataSource.DataSet.FieldByName('DET_IDEPRO').AsString + ' - ' +
                                                              dbgItens.DataSource.DataSet.FieldByName('DET_ITETIN').AsString);
        objLiberacao.objMsgLibera.pAddTexto('Quantidade : ' + FloatToStrF(dbgItens.DataSource.DataSet.FieldByName('DET_QTDITE').AsFloat, ffFixed, 10, fCfgSis('DECQTD', varInteger)));
      End
      Else
      Begin
        strNumdoc := dbgItens.DataSource.DataSet.FieldByName('FDO_NUMDOC').AsString;
        strEspDoc := dbgItens.DataSource.DataSet.FieldByName('FDO_ESPDOC').AsString;
        strCodEmp := dbgItens.DataSource.DataSet.FieldByName('FDO_CODEMP').AsString;

        objLiberacao.objMsgLibera.pAddTexto('Documento  : ' + dbgItens.DataSource.DataSet.FieldByName('FDO_NUMDOC').AsString + '-' +
                                                              dbgItens.DataSource.DataSet.FieldByName('FDO_ESPDOC').AsString + '-' +
                                                              dbgItens.DataSource.DataSet.FieldByName('FDO_CODEMP').AsString);
        objLiberacao.objMsgLibera.pAddTexto('Cliente    : ' + dbgItens.DataSource.DataSet.FieldByName('FDO_CODCLI').AsString + '-' +
                                                              dbgItens.DataSource.DataSet.FieldByName('FDO_NOMCLI').AsString);
        objLiberacao.objMsgLibera.pAddTexto('Vendedor   : ' + dbgItens.DataSource.DataSet.FieldByName('FDO_CODVEN').AsString + '-' +
                                                              fRetNomVendRep(dbgItens.DataSource.DataSet.FieldByName('FDO_CODVEN').AsString));
        objLiberacao.objMsgLibera.pAddTexto('Produto    : ' + dbgItens.DataSource.DataSet.FieldByName('FDO_IDEPRO').AsString + ' - ' +
                                                              dbgItens.DataSource.DataSet.FieldByName('FDO_ITETIN').AsString);
        objLiberacao.objMsgLibera.pAddTexto('Quantidade : ' + FloatToStrF(dbgItens.DataSource.DataSet.FieldByName('FDO_QTDITE').AsFloat, ffFixed, 10, fCfgSis('DECQTD', varInteger)));
      End;

      objLiberacao.strDirAce := 'RIMETIENT';
      objLiberacao.strMsgSen := 'Permitir Reimpressão de Etiqueta de Entrada';
      objLiberacao.strCodOpe := fRetCodVendedor(strCodOpe);
      objLiberacao.strCodDig := fRetCodVendedor(strCodOpe);

      objLiberacao.pInformaNumDocEspDocCodEmp(strNumDoc, strEspDoc, strCodEmp);

      If Not objLiberacao.fLibera Then
        Exit;
    End;

    if not fImprimeEtiquetaEntrega(strOperador) then Begin
      pFinalizarThreadNotTinDisp(True);
      Exit;
    End;

    qryAux := fCriaQuery(Self);
    qryAux.SQL.Clear;
    qryAux.SQL.Add('  UPDATE                 ');

    If (strCfgExi = 'V')Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      qryAux.SQL.Add('TINDET                 ');
      qryAux.SQL.Add('SET DET_IMPRES = TRUE  ');
    End
    Else
    Begin
      qryAux.SQL.Add('  TINDOR              ');
      qryAux.SQL.Add('SET FDO_IMPRES = TRUE  ');
    End;

    qryAux.SQL.Add('  WHERE                  ');
    qryAux.SQL.Add('    AUTOINCREM = :AUTINC ');

    qryAux.ParamByName('AUTINC').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;
    qryAux.ExecSQL;

    FreeAndNil(qryAux);

    intRecNo := dbgItens.DataSource.DataSet.RecNo;

    pDeletaTemporaria;
    pAtualizaTemporaria;

    If (intRecNo <= dbgItens.DataSource.DataSet.RecordCount) And (Not dbgItens.DataSource.DataSet.IsEmpty) Then
      dbgItens.DataSource.DataSet.RecNo := intRecNo;

  End
  {*************************************************}
  {* CONFIGURADO PARA IMPRIMIR ETIQUETAS JUNTAS    *}
  {**********************************************RV*}
  Else
  Begin

    If (fMensagem('', 'O sistema está configurado para imprimir a Etiqueta' + #13 +
                      'de Formulação junto com a Etiqueta de Entrega.' + #13 +
                      'Confirma impressão das etiquetas?', ['&Sim', '&Não']) = 2) Then Begin
      pFinalizarThreadNotTinDisp(True);
      Exit;
    End;

    If fCfgSis('SENENT') <> 'N' Then
    Begin
      If ffrmSenha(strSenha, 'Operador Solicitante:') Then
      Begin
        strCodOpe := fRetCodVendedor(strSenha);
        If fEmptyStr(strCodOpe) Then
        Begin
          pMensagemOk('Usuário não existente!');
          pFinalizarThreadNotTinDisp(True);
          Exit;
        End;
      End
      Else
      Begin
        pFinalizarThreadNotTinDisp(True);
        Exit;
      End;
    End
    Else
    Begin
      strCodOpe := fGetUsuarioLogado;
    End;

    If Not fEmptyStr(strCodOpe) Then
      strOperador := strCodOpe + ' - ' + fRetNomVendRep(strCodOpe);

    Try
      If fCfgSis('TRCTRF') <> 'N' Then
      Begin
        If Not fVerificaCtrEmAberto Then 
        Begin
          pFinalizarThreadNotTinDisp(True);
          Exit;
        End;
      End;

      blnImprimeEtiqEnt := fImprimeEtiquetaEntrega(strOperador);
      pImprimeEtiquetaFormulacao('');

      Try
        If fBaixaFormulacao(strCodOpe, strMsg, blnImprimeEtiqEnt) Then
        Begin
          fCommit;

          pFinalizarThreadNotTinDisp(True);

          If Not fEmptyStr(strMsg) Then
            pMensagemOk(strMsg);
        End
        Else
          fRollBack;

      Except

        On E: ExceptionAutCom Do
        Begin
          fRollBack;
          fMensagem('',E.Message, ['&Ok']);
        End;

        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[Baixar Formulação]');
        End;
      End;

    Finally
      pDeletaTemporaria;
      pAtualizaTemporaria;
      pDeletaTempEtiFormulacao;
    End;

  End;
end;

procedure TfrmFatFormulacaoItens.cmbSitFinClick(Sender: TObject);
begin
  inherited;
  btnAtualizar.Click;
end;

procedure TfrmFatFormulacaoItens.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pFinalizarThreadNotTinDisp(False);

  Case Key Of
    VK_F12: If btnImpAjuste.Visible Then btnImpAjuste.Click;
    VK_F11: If btnRealizarAjuste.Visible Then btnRealizarAjuste.Click;
    VK_F10: If btnImprimir.Enabled Then btnImprimir.Click;
    VK_F9:  btnBaixar.Click;
    VK_F8:  If btnAtualizar.Enabled Then btnAtualizar.Click;
    VK_F7:  If btnBaiTin.Enabled Then btnBaiTin.Click;
    VK_F6:  If btnImpOrd.Enabled Then btnImpOrd.Click;
    VK_F4:  If btnDesmBaixa.Visible Then btnDesmBaixa.Click;
    VK_F5:  If btnImpSep.Visible Then btnImpSep.Click;
    VK_F3:  If btnAltTipTin.Enabled Then pMudarTipoTinta;
    VK_F2:  Begin
              If btnImpEtiqProd.Enabled And btnImpEtiqProd.Visible Then
                btnImpEtiqProd.Click;
            End;
  End;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.dbgItensDblClick(Sender: TObject);
begin
  inherited;
  If Not Assigned(cdsTinMaq) Then
    Exit;

  If (Not fPermiteProsseguirAcao) Then
    Exit;

  pFinalizarThreadNotTinDisp(False);
  pMarcarBaixa;
  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    strNomCam: String;
begin
  inherited;
  If Not Assigned(cdsTinMaq) Then
    Exit;

  If (Not dbgItens.DataSource.DataSet.Active) Or
     (dbgItens.DataSource.DataSet.IsEmpty)    Then
  Begin
    Exit;
  End;

  If ((strCfgExi <> 'V') And (strCfgExi <> 'PA')) And (Column.FieldName = 'FIS_NUMCOO') And (Column.Visible) Then
    Column.Visible:=False;

  If (strCfgExi = 'V')Or (strCfgExi = 'PA')  Then
    strNomCam := 'DET_IMPRES'
  Else
    strNomCam := 'FDO_IMPRES';

  If (dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsInteger = 1) And (Not fApenasBaixados) Then
  Begin
    If (State = [gdSelected]) And (dbgItens.Focused) Then
      dbgItens.Canvas.Font.Color := clLime
    Else
      dbgItens.Canvas.Font.Color := clBlue;
  End;

  If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
    strNomCam := 'DET_PROCES'
  Else
    strNomCam := 'FDO_PROCES';

  If (dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsInteger = 1) And (Not fApenasBaixados) Then
    dbgItens.Canvas.Font.Color := clRed;

  If (dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString = 'S') then
    dbgItens.Canvas.Font.Color := clBlue;


  If (Column.FieldName = 'FDO_ENTRET') Then
  Begin

    If dbgItens.Canvas.Brush.Color <> clHighlight Then
    Begin

      If (dbgItens.DataSource.DataSet.FieldByName('DESTINO').AsInteger = 0) Then
      Begin
        dbgItens.Canvas.Font.Color := clGreen;
      End
      Else
      If (dbgItens.DataSource.DataSet.FieldByName('DESTINO').AsInteger = 1) Then
      Begin
        dbgItens.Canvas.Font.Color := clRed;
      End
      Else
      If (dbgItens.DataSource.DataSet.FieldByName('DESTINO').AsInteger = 2) Then
      Begin
        dbgItens.Canvas.Font.Color := clBlue;
      End;

    End;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  If (strCfgExi = 'PD') And (Column.FieldName = 'SITFIN') And (Column.Visible) Then
  Begin
    dbgItens.Canvas.FillRect(Rect);
    If dbgItens.DataSource.DataSet.FieldByName('SITFIN').AsString <> 'OK' Then
      imglSitFin.Draw(dbgItens.Canvas, Rect.Left + ((Column.Width - imglSitFin.Width) div 2), Rect.Top+1, 1)
    Else
      imglSitFin.Draw(dbgItens.Canvas, Rect.Left + ((Column.Width - imglSitFin.Width) div 2), Rect.Top+1, 2);
  End;
end;

function TfrmFatFormulacaoItens.fPainelEstaAberto: Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := True;

  If FileExists('nfe.citel') Or FileExists('nfe.310') Or (fCfgSis('VERNFE') = '4.00') Then
  Begin
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('SELECT IS_USED_LOCK("PAINEL_NFE_' + VS_strCodEmp + '")');
    qryAux.Open;

    Result := (Not fEmptyStr(qryAux.Fields[0].AsString));

    FreeAndNil(qryAux);
  End;
end;

function TfrmFatFormulacaoItens.fPermiteProsseguirAcao: Boolean;
  Var
    strPenFin : String;
begin
  Result := True;

  if strCfgExi.Equals('PD') And blnUsaRotinaWMS And (fCfgSis('TPLREC', varString) <> 'N') And
     fProdForaLojaFGO(cdsTinMaq) And
     (fTipoTinta(cdsTinMaq.FieldByName('FDO_IDEPRO').AsString) = ttImobiliaria) And
     (not fItemTemLotDorGravado(cdsTinMaq.FieldByName('FDO_NUMDOC').AsString,
                                cdsTinMaq.FieldByName('FDO_ESPDOC').AsString,
                                cdsTinMaq.FieldByName('FDO_CODEMP').AsString,
                                cdsTinMaq.FieldByName('FDO_CODCLI').AsString,
                                cdsTinMaq.FieldByName('FDO_CODITE').AsString,
                                False)) Then
  Begin
    Result := False;
    pMensagemOk('Formulação de outra loja, é preciso imprimir e realizar a separação da base antes de continuar!');
  End;

  If Not ((strCfgExi = 'PD') And (blnSTFNTI)) Then
    Exit;

  If Not Assigned(cdsTinMaq) Then
    Exit;

  If cdsTinMaq.IsEmpty Then
    Exit;

  If Not cdsTinMaq.Active Then
    Exit;

  If (Not fSituacaoFinanceiraPedidoOk(strPenFin)) And (btnDesmBaixa.Visible) Then
  Begin
    pMensagemOk(strPenFin + '!');
    Result := False;
  End;

end;

function TfrmFatFormulacaoItens.fItemTemLotDorGravado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte: String; blnVerificaSeparado : Boolean) : Boolean;
  Var
    qryLotDor : TUniQuery;
Begin
  Try
    qryLotDor := fCriaQuery();

    qryLotDor.SQL.Add(' SELECT LOTDOR.AUTOINCREM, LDO_SEPCOL, LDO_QTDSEP      ');
    qryLotDor.SQL.Add(' FROM LOTDOR                                           ');
    qryLotDor.SQL.Add('   INNER JOIN FATDOR ON FATDOR.AUTOINCREM = LDO_SEQFDO ');
    qryLotDor.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC                            ');
    qryLotDor.SQL.Add('   AND FDO_ESPDOC = :ESPDOC                            ');
    qryLotDor.SQL.Add('   AND FDO_CODEMP = :CODEMP                            ');
    qryLotDor.SQL.Add('   AND FDO_CODCLI = :CODCLI                            ');
    qryLotDor.SQL.Add('   AND FDO_CODITE = :CODITE                            ');

    qryLotDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryLotDor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryLotDor.ParamByName('CODEMP').AsString := strCodEmp;
    qryLotDor.ParamByName('CODCLI').AsString := strCodCli;
    qryLotDor.ParamByName('CODITE').AsString := strCodIte;

    qryLotDor.Open;

    Result := Not fEmptyStr(qryLotDor.FieldByName('AUTOINCREM').AsString);

    If Result And blnVerificaSeparado Then
      Result := qryLotDor.FieldByName('LDO_SEPCOL').AsString.Equals('S') Or (qryLotDor.FieldByName('LDO_QTDSEP').AsFloat > 0) ;

    qryLotDor.Close;

  Finally
    FreeAndNil(qryLotDor);
  End;

End;

function TfrmFatFormulacaoItens.fProdForaLojaGER(qryTinDet: TDataSet): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Self);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SQL_NO_CACHE        ');
    SQL.Add('  GER_OPRFLJ               ');
    SQL.Add('FROM                       ');
    SQL.Add('  MOVGER                   ');
    SQL.Add('WHERE                      ');
    SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    SQL.Add('  GER_CODEMP = :CODEMP AND ');
    SQL.Add('  GER_TIP_FC = "C"         ');

    ParamByName('NUMDOC').AsString := qryTinDet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA')  , 'DET', 'FDO') + '_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := qryTinDet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA')  , 'DET', 'FDO') + '_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := qryTinDet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA')  , 'DET', 'FDO') + '_CODEMP').AsString;
    Open;

    Result := (FieldByName('GER_OPRFLJ').AsString = 'S');

    Close;
  End;

  FreeAndNil(qryGen);
end;

function TfrmFatFormulacaoItens.fProdForaLojaEntregaFutura(
  qryTinDet: TDataSet): Boolean;
Var
  qryGen: TUniQuery;
Begin
  Result := False;

  If (strCfgExi <> 'V') Then
    Exit;

  If (Not fEmptyStr(qryTinDet.FieldByName('DET_DOCFUT').AsString)) Then
  Begin
    Try
      qryGen := fCriaQuery(Self);

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SQL_NO_CACHE        ');
        SQL.Add('  GER_OPRFLJ               ');
        SQL.Add('FROM                       ');
        SQL.Add('  MOVGER                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
        SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
        SQL.Add('  GER_CODEMP = :CODEMP AND ');
        SQL.Add('  GER_TIP_FC = "C"         ');

        ParamByName('NUMDOC').AsString := qryTinDet.FieldByName('DET_DOCFUT').AsString;
        ParamByName('ESPDOC').AsString := qryTinDet.FieldByName('DET_ESPFUT').AsString;
        ParamByName('CODEMP').AsString := qryTinDet.FieldByName('DET_EMPFUT').AsString;
        Open;

        Result := (FieldByName('GER_OPRFLJ').AsString = 'S');

        Close;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

function TfrmFatFormulacaoItens.fProdForaLojaFGO(qryTinDet: TDataSet): Boolean;
var
  qryGen: TUniQuery;
Begin
  Result := False;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Self);
      if (strCfgExi = 'V') Or (strCfgExi = 'PA') then
      begin
        qryGen.SQL.Text :=
          ' SELECT                     ' +
          '    FGO_OPRFLJ              ' +
          ' FROM                       ' +
          '   FATGOR                   ' +
          ' WHERE FGO_NUMFAT = :NUMDOC ' +
          '   AND FGO_TIPFAT = :ESPDOC ' +
          '   AND FGO_EMPFAT = :CODEMP ';
      end
      else
      begin
        qryGen.SQL.Text :=
          ' SELECT                     ' +
          '   FGO_OPRFLJ               ' +
          ' FROM                       ' +
          '   FATGOR                   ' +
          ' WHERE FGO_NUMDOC = :NUMDOC ' +
          '   AND FGO_ESPDOC = :ESPDOC ' +
          '   AND FGO_CODEMP = :CODEMP ';
      end;

      qryGen.ParamByName('NUMDOC').AsString := qryTinDet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString;
      qryGen.ParamByName('ESPDOC').AsString := qryTinDet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString;
      qryGen.ParamByName('CODEMP').AsString := qryTinDet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString;
      qryGen.Open;

      Result := (qryGen.FieldByName('FGO_OPRFLJ').AsString = 'S');
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fRetornaAjuste: String;
Var
  qryGen: TUniQuery;
  strSQL: String;
  arrAjustes: Array Of String;
  intAjuste: Integer;
  intPos: Integer;

begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    strSQL := strSQL + '  SELECT DISTINCT       ';
    strSQL := strSQL + '    GER_SEQGER,         ';
    strSQL := strSQL + '    GER_DOCGRI,         ';
    strSQL := strSQL + '    GER_ESPGRI          ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    GERAJU              ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    GER_CODACA = :CODACA AND      ';
    strSQL := strSQL + '    GER_EMPACA = :EMPACA AND      ';
    strSQL := strSQL + '    GER_DOCGRI = :NUMDOC AND      ';
    strSQL := strSQL + '    GER_ESPGRI = :ESPDOC AND      ';
    strSQL := strSQL + '    GER_CODITE = :CODITE          ';


    If Pos(strEspDoc, 'OR_PD_') > 0 Then
      strSQL := AnsiReplaceStr(strSQL, 'GER', 'FGO');

    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0), 'DET', 'FDO') + '_CODACA').AsString;
    qryGen.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0), 'DET', 'FDO') + '_EMPACA').AsString;
    qryGen.ParamByName('NUMDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0), 'DET', 'FDO') + '_NUMDOC').AsString;
    qryGen.ParamByName('ESPDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0), 'DET', 'FDO') + '_ESPDOC').AsString;
    qryGen.ParamByName('CODITE').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (Pos(strEspDoc, 'PA_') > 0), 'DET', 'FDO') + '_CODITE').AsString;
    qryGen.Open;

    SetLength(arrAjustes, 0);

    qryGen.First;

    If qryGen.RecordCount > 1 Then
    Begin
      While Not qryGen.Eof Do
      Begin
        SetLength(arrAjustes, Length(arrAjustes) + 1);
        arrAjustes[Length(arrAjustes) - 1] := fAjuste(qryGen.FieldByName(IfThen((strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'GER_SEQGER', 'FGO_SEQFGO')).AsString);
        qryGen.Next;
      End;

      intAjuste := fGetMenu('DT.AJUSTE  | NUM.AJUSTE ', arrAjustes, 1);

      If intAjuste > 0 Then
      Begin
        Result := arrAjustes[intAjuste - 1];
        intPos := Pos('|', Result);
        Result := Trim(Copy(Result, intPos + 1, Length(Result)));
      End
      Else
        Result := '';
    End
    Else
      Result := qryGen.FieldByName(IfThen((strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'GER_SEQGER', 'FGO_SEQFGO')).AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fRetornaSQLTindetBaixad: String;
begin
  Result := '';

  If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0)  Then
  Begin
    Result := Result + ' UPDATE TINDET                     ';
    Result := Result + '    SET DET_OPEBAI = :OPEBAI,      ';
    Result := Result + '        DET_DTABAI = ' + fCurrentDate + ', ';
    Result := Result + '        DET_HORBAI = :HORBAI,      ';
    Result := Result + '        DET_BAIXAD = TRUE          ';
  End
  Else
  Begin
    Result := Result + ' UPDATE TINDOR                     ';
    Result := Result + '    SET FDO_OPEBAI = :OPEBAI,      ';
    Result := Result + '        FDO_DTABAI = ' + fCurrentDate + ', ';
    Result := Result + '        FDO_HORBAI = :HORBAI,      ';
    Result := Result + '        FDO_BAIXAD = TRUE          ';
  End;

  Result := Result + ' WHERE                 ';
  Result := Result + '  AUTOINCREM = :AUTINC ';
end;

function TfrmFatFormulacaoItens.fRetornaSQLTindetDesmarcaBaixad(
  qryTinDet: TDataSet): String;

  function fGetSQLDesmarcaTindet: String;
  begin
    Result := '';
    Result := Result + 'UPDATE TINDET ';
    Result := Result + '   SET DET_OPEBAI = NULL,   ';
    Result := Result + '       DET_DTABAI = NULL,   ';
    Result := Result + '       DET_HORBAI = NULL,   ';
    Result := Result + '       DET_BAIXAD = "N"     ';
    Result := Result + ' WHERE DET_NUMDOC = :NUMDOC ';
    Result := Result + '   AND DET_CODEMP = :CODEMP ';
    Result := Result + '   AND DET_ESPDOC = :ESPDOC ';
    Result := Result + '   AND DET_CODACA = :CODACA ';
    Result := Result + '   AND DET_EMPACA = :EMPACA ';
  end;
begin
  Result := '';

  If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
  Begin
    Result := Result + 'UPDATE TINDET        ';
    Result := Result + 'SET                  ';
    Result := Result + '  DET_OPEBAI = NULL, ';
    Result := Result + '  DET_DTABAI = NULL, ';
    Result := Result + '  DET_HORBAI = NULL, ';
    Result := Result + '  DET_BAIXAD = "N"   ';
  End
  Else
  Begin
    if fTinDetBaixado(qryTinDet.FieldByName('FGO_NUMFAT').AsString, qryTinDet.FieldByName('FGO_EMPFAT').AsString,
                      qryTinDet.FieldByName('FGO_TIPFAT').AsString, qryTinDet.FieldByName('FDO_CODACA').AsString,
                      qryTinDet.FieldByName('FDO_EMPACA').AsString) then
    Begin
      pExecutaSQL(fGetSQLDesmarcaTindet,
                  ['NUMDOC','CODEMP','ESPDOC','CODACA','EMPACA'],
                  [qryTinDet.FieldByName('FGO_NUMFAT').AsString,
                   qryTinDet.FieldByName('FGO_EMPFAT').AsString,
                   qryTinDet.FieldByName('FGO_TIPFAT').AsString,
                   qryTinDet.FieldByName('FDO_CODACA').AsString,
                   qryTinDet.FieldByName('FDO_EMPACA').AsString]);
    End;

    Result := Result + 'UPDATE TINDOR        ';
    Result := Result + 'SET                  ';
    Result := Result + '  FDO_OPEBAI = NULL, ';
    Result := Result + '  FDO_DTABAI = NULL, ';
    Result := Result + '  FDO_HORBAI = NULL, ';
    Result := Result + '  FDO_BAIXAD = "N"   ';
  End;

  Result := Result + ' WHERE ';
  Result := Result + '   AUTOINCREM = :AUTINC ';
end;

function TfrmFatFormulacaoItens.fRetornaUltimaVenda(strCodCli, strIdePro, strIteTin, strSeqGer: String): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Result := '';
  qryGen := fCriaQuery();
  Try
    strSQL := strSQL + ' SELECT CAST(MAX(DET_DTAENT) AS DATETIME) ';
    strSQL := strSQL + '   FROM MOVDET ';
    strSQL := strSQL + '   WHERE ';
    If (strSeqGer <> '') Then
      strSQL := strSQL + '    DET_SEQGER NOT IN ('+strSeqGer+') AND ';
    strSQL := strSQL + '      DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '      IFNULL(DET_PROEMB, "N") <> "S" AND ';
    strSQL := strSQL + '      DET_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '      DET_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '      DET_ITETIN = :ITETIN AND ';
    strSQL := strSQL + '      DET_IDEPRO = :IDEPRO AND ';
    strSQL := strSQL + '      ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) OR (DET_ESPDOC = "ML" AND DET_ORIDOC="V") ';
    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';
    strSQL := strSQL + ' AND DET_DTAENT >= :DTACOR ';

    qryGen.Close;
    qryGen.SQL.Text := strSQL;
    qryGen.ParamByName('DTACOR').AsDate   := IncDay(VS_Date, -120);
    qryGen.ParamByName('CODCLI').AsString := strCodCli;
    qryGen.ParamByName('ITETIN').AsString := strIteTin;
    qryGen.ParamByName('IDEPRO').AsString := strIdePro;
    qryGen.ParamByName('CLAFIS').AsString := VS_strClaVen;
    qryGen.ParamByName('CLADEV').AsString := VS_strClaDev;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.Open;

    If (Not qryGen.IsEmpty) Then
      If (qryGen.Fields[0].AsDateTime > 0) Then
        Result := FormatDateTime('dd/mm/yyyy', qryGen.Fields[0].AsDateTime)
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fRetQuantidadeDevolucao: String;
begin
  If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
    Result := '(TINDET.DET_QTDITE - 0)'
  Else
    Result := '(TINDOR.FDO_QTDITE - 0)';
end;

function TfrmFatFormulacaoItens.fRetSQLEmprestimos: String;
begin
  Result := Result + 'SELECT ';

  If fCfgSis('LOCRET') = 'S' Then
  Begin
    Result := Result + '  IF(MOVGER.GER_ENTFAT = "N" , ';
    Result := Result + '  CASE (SELECT DISTINCT EXT.FDO_LOCRET FROM FATDOR FAT ';
    Result := Result + '  LEFT JOIN EXTDOR EXT ON     ';
    Result := Result + '    EXT.FDO_SEQFDO = FAT.AUTOINCREM   ';
    Result := Result + '  WHERE                       ';
    Result := Result + '    FAT.FDO_CODACA = MOVDET.DET_CODACA AND    ';
    Result := Result + '    FAT.FDO_EMPACA = MOVDET.DET_EMPACA AND    ';
    Result := Result + '    FAT.FDO_NUMDOC = MOVDET.DET_NUM_PD AND    ';
    Result := Result + '    FAT.FDO_ESPDOC = MOVDET.DET_ESP_PD AND    ';
    Result := Result + '    FAT.FDO_CODEMP = MOVDET.DET_EMP_PD) ';
    Result := Result + '    WHEN "C" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('CAIXA', 1) + '" ';
    Result := Result + '    WHEN "B" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO', 3) + '" ';
    Result := Result + '    WHEN "B2" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO 2', 4) + '" ';
    Result := Result + '    ELSE "RETIRA ' + fVerificaDescAdicionalLocRet('EXPEDIÇÃO', 2) + '" ';
    Result := Result + '    END, IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';
  End
  Else
    Result := Result + '  IF(MOVGER.GER_ENTFAT = "N" , "RETIRA", IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';

  Result := Result + '  "N"  AS BAIXAOP, ';
  Result := Result + '  CAST(TINDET.DET_DESCRI AS CHAR(100)) AS DET_DESCRI, ';
  Result := Result + '  TINDET.DET_DTAENT AS DTAENT, ';
  Result := Result + '  TINDET.DET_HORENT AS HORENT, ';
  Result := Result + '  IF(TINDET.DET_AJUFOR = "S", "S", "N") AS AJUFOR,  ';
  Result := Result + '  TINDET.DET_SEQGER , TINDET.AUTOINCREM , TINDET.DET_CODEMP, ';
  Result := Result + '  TINDET.DET_CODDIV , TINDET.DET_CODMAR , TINDET.DET_CODITE, ';
  Result := Result + '  TINDET.DET_CODVEN , TINDET.DET_CODCLI , TINDET.DET_NUMDOC, ';
  Result := Result + '  TINDET.DET_ESPDOC , TINDET.DET_DTAENT , TINDET.DET_HORENT, ';
  Result := Result + '  TINDET.DET_CONPAG , TINDET.DET_ESTADO , TINDET.DET_DESCRI , TINDET.DET_REFERE, ';
  Result := Result + '  TINDET.DET_UNIDAD , TINDET.DET_FORITE , ';
  Result := Result + '  (TINDET.DET_QTDITE - 0) AS DET_QTDITE,';
  Result := Result + '  TINDET.DET_INCPIS , TINDET.DET_NOTESP , TINDET.DET_IDEPRO, ';
  Result := Result + '  TINDET.DET_ITETIN , TINDET.DET_ITECHA , TINDET.DET_DESCOR, ';
  Result := Result + '  TINDET.DET_TIPEMB , TINDET.DET_QTDEMB , TINDET.DET_PREEMB, ';
  Result := Result + '  TINDET.DET_TIPPRE , TINDET.DET_MONTAD , TINDET.DET_A_N_O_ , TINDET.DET_FORM01, ';
  Result := Result + '  TINDET.DET_QTDB01 , TINDET.DET_FORM02 , TINDET.DET_QTDB02, ';
  Result := Result + '  TINDET.DET_FORM03 , TINDET.DET_QTDB03,  TINDET.DET_FORM04 , TINDET.DET_QTDB04 , ';
  Result := Result + '  TINDET.DET_FORM05,  TINDET.DET_QTDB05 , TINDET.DET_FORM06 , TINDET.DET_QTDB06, ';
  Result := Result + '  TINDET.DET_FORM07 , TINDET.DET_QTDB07 , TINDET.DET_FORM08 , TINDET.DET_QTDB08, ';
  Result := Result + '  TINDET.DET_FORM09 , TINDET.DET_QTDB09 , TINDET.DET_FORM10, ';
  Result := Result + '  TINDET.DET_QTDB10 , TINDET.DET_FORM11 , TINDET.DET_QTDB11 , TINDET.DET_FORM12, ';
  Result := Result + '  TINDET.DET_QTDB12 , TINDET.DET_FORM13 , TINDET.DET_QTDB13, ';
  Result := Result + '  TINDET.DET_FORM14 , TINDET.DET_QTDB14 , TINDET.DET_FORM15 , TINDET.DET_QTDB15, ';
  Result := Result + '  TINDET.DET_CODDIG , TINDET.DET_IMPRES, ';
  Result := Result + '  TINDET.DET_BAIXAD , TINDET.DET_CODACA , TINDET.DET_EMPACA ,';
	Result := Result + '  MOVDET.DET_UNITAR , MOVDET.DET_TOTITE, MOVDET.DET_LINLIN, 	';
  Result := Result + '  MOVDET.DET_CATALI , MOVDET.DET_CODDIL, ';
	Result := Result + '  MOVDET.DET_PORDIL , MOVDET.DET_DILCON, MOVDET.DET_PORCAT, ';
  Result := Result + '  TINDET.DET_OPEBAI , TINDET.DET_HORBAI, ';
	Result := Result + '  TINDET.DET_DTABAI , TINDET.DET_PROCES, TINDET.DET_ORDIMP, ';



  Result := Result + '  "" AS FDO_ITEC01, "" AS FDO_ITEC02, "" AS FDO_ITEC03, "" AS FDO_ITEC04,';
  Result := Result + '  "" AS FDO_ITEC05, "" AS FDO_ITEC06, "" AS FDO_ITEC07, "" AS FDO_ITEC08,';
  Result := Result + '  "" AS FDO_ITEC09, "" AS FDO_ITEC10, "" AS FDO_ITEC11, "" AS FDO_ITEC12,';
  Result := Result + '  "" AS FDO_ITEC13, "" AS FDO_ITEC14, "" AS FDO_ITEC15, "" AS FDO_ITEC16,';
  Result := Result + '  "" AS FDO_ITEC17, "" AS FDO_ITEC18, "" AS FDO_ITEC19, "" AS FDO_ITEC20,';


  Result := Result + ' 0 AS DET_TINAUT, TINDET.DET_LINTIN, TINDET.DET_FORM16, TINDET.DET_QTDB16,';
  Result := Result + ' TINDET.DET_FORM17, TINDET.DET_QTDB17, TINDET.DET_FORM18, TINDET.DET_QTDB18,';
  Result := Result + ' TINDET.DET_FORM19, TINDET.DET_QTDB19, TINDET.DET_FORM20, TINDET.DET_QTDB20,';



  Result := Result + '  IF(TINDET.DET_ORDIMP = 0, "N", "S") AS ORDIMP, ';
  Result := Result + '  TINGER.GER_NOMCON, ';
  Result := Result + '  TINGER.GER_ENDCON, ';
  Result := Result + '  TINGER.GER_BAICON, ';
  Result := Result + '  TINGER.GER_CEPCON, ';
  Result := Result + '  TINGER.GER_CIDCON, ';
  Result := Result + '  TINGER.GER_TELCON, ';
  Result := Result + '  TINGER.GER_CGCCPF, ';
  Result := Result + '  TINGER.GER_CGCCON, ';
  Result := Result + '  TINGER.GER_IESCON, ';
  Result := Result + '  TINGER.GER_R_GCON, ';
  Result := Result + '  TINGER.GER_ESTADO, ';
  Result := Result + '  TINGER.GER_ESPDOC, ';
  Result := Result + '  TINGER.AUTOINCREM AS AUTINC, ';

  Result := Result + '  "" AS FGO_MENFOR,';
  Result := Result + '  "" AS FGO_ENT_CD,';
  Result := Result + '  TINDET.DET_EMPPRD,';
  Result := Result + '  "" AS FGO_DOCFAT,';
  Result := Result + '  "" AS FGO_NUMFAT,';
  Result := Result + '  "" AS FGO_TIPFAT,';
  Result := Result + '  "" AS FGO_EMPFAT,';
  Result := Result + '  "" AS FGO_EMP_TE,';


  Result := Result + '  CADITE.ITE_CODMAR, ';
  Result := Result + '  CADITE.ITE_DESITE, ';
  Result := Result + '  CADITE.ITE_REFERE, ';
  Result := Result + '  CADITE.ITE_CODUNI, ';
  Result := Result + '  CADITE.ITE_CODFOR, ';

  Result := Result + '  ITEGER.ITE_PREVE1, ';
  Result := Result + '  ITEGER.ITE_PRECUS, ';
  Result := Result + '  ITEGER.ITE_PREMED, ';

  Result := Result + '  0  AS FOR_MODDIL, ';
  Result := Result + '  "" AS FOR_TEXBAS, ';
  Result := Result + '  "" AS FOR_TIPCOR, ';
  Result := Result + '  "" AS FOR_ITECOB, ';
  Result := Result + '  "" AS FOR_UNIVER, ';

  Result := Result + '  CADUNI.UNI_DESUNI,';
  Result := Result + '  CLI_CODCLI,';
  Result := Result + '  IF(TINGER.GER_NOMCON IS NULL OR TINGER.GER_NOMCON = "", CLI_NOMCLI, TINGER.GER_NOMCON) AS DET_NOMCLI, ';
  Result := Result + '  TINDET.AUTOINCREM AS CHAVE,';

  Result := Result + '  TINDET.DET_EMPPRD, ';
  Result := Result + '  TINDET.DET_VOLPRO, ';
  Result := Result + '  TINDET.DET_LAZQUA, ';
  Result := Result + '  NULL DET_ITEEMB, ';

  Result := Result + ' (SELECT ';
  Result := Result + '    FIS_NUMCOO ';
  Result := Result + '  FROM ';
  Result := Result + '    CADFIS ';
  Result := Result + '  WHERE FIS_NUMDOC = MOVDET.DET_NUMDOC ';
  Result := Result + '    AND FIS_ESPDOC = MOVDET.DET_ESPDOC ';
  Result := Result + '    AND FIS_CODEMP = MOVDET.DET_CODEMP ';
  Result := Result + '    AND FIS_FORCLI = MOVDET.DET_CODCLI ';
  Result := Result + '    AND FIS_TIP_FC = MOVDET.DET_TIP_FC ';
  Result := Result + '    AND FIS_ORIDOC = MOVDET.DET_ORIDOC ) AS FIS_NUMCOO, ';

  Result := Result + '  IF(MOVGER.GER_ENTFAT = "N", 0 , IF(MOVDET.DET_DOCFUT <> "", 2, 1)) AS DESTINO, ';
  Result := Result + '   "OK" AS SITFIN ';


  Result := Result + '  , ACA_CODBAR  AS CODBAR_ACA ';
  Result := Result + '  , EMB.ITE_CODBAR  AS CODBAR_EMB ';
  Result := Result + '  , CADITE.ITE_CODBAR AS CODBAR_BASE ';

  Result := Result + '  , EXPARQ.AUTOINCREM SEQ_EXPARQ ';
  Result := Result + '  , "" AS DIRARQEXP ';
  Result := Result + '  , "" AS CODSEP    ';
  Result := Result + '  , "0" AS SEPIMP   ';
  Result := Result + '  , "" AS AUTINC_DOCORI ';

  Result := Result + ' , TINDET.DET_TIPFOR AS TIPFOR';
  Result := Result + ' , TINDET.DET_OBSCOL AS OBSCOL';
  Result := Result + ' , TINDET.DET_EMPACA AS EMPACA';
  Result := Result + ' , TINDET.DET_CODACA AS CODACA';
  Result := Result + ' , CAST("" AS CHAR(10)) AS DTAULT ';
  Result := Result + ' , (SELECT CADLOT.LOT_NUMLOT     ';
  Result := Result + '   FROM CADLOT                ';
  Result := Result + ' WHERE CADLOT.LOT_CODITE = TINDET.DET_CODITE AND  ';
  Result := Result + '       CADLOT.LOT_CODEMP = :CODEMP AND            ';
  Result := Result + '       CADLOT.LOT_PRITIN = "S"                    ';
  Result := Result + ' LIMIT 1) AS NUMLOT                               ';
  Result := Result + ' , MOVDET.DET_SEQGER AS SEQGER_DOCFAT ';
  Result := Result + 'FROM ';
  Result := Result + '  TINDET ';
  Result := Result + '  JOIN CADCLI ON CLI_CODCLI = TINDET.DET_CODCLI ';
  Result := Result + '  JOIN TINGER ON TINGER.AUTOINCREM = TINDET.DET_SEQGER ';
  Result := Result + '  JOIN CADITE ON CADITE.ITE_CODITE = TINDET.DET_CODITE ';
  Result := Result + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '                 AND ITEGER.ITE_CODEMP = :CODEMP ';
  Result := Result + '  JOIN MOVDET ON MOVDET.DET_CODACA = TINDET.DET_CODACA AND ';
  Result := Result + '                 MOVDET.DET_EMPACA = TINDET.DET_EMPACA AND ';
  Result := Result + '                 MOVDET.DET_NUMDOC = TINDET.DET_NUMDOC AND ';
  Result := Result + '                 MOVDET.DET_ESPDOC = TINDET.DET_ESPDOC AND ';
  Result := Result + '                 MOVDET.DET_CODEMP = TINDET.DET_CODEMP AND ';
  Result := Result + '                 MOVDET.DET_CODCLI = TINDET.DET_CODCLI AND ';
  Result := Result + '                 MOVDET.DET_PROEMB <> "S"  AND ';
  Result := Result + '                 MOVDET.DET_ENTFUT <> "S"      ';
  Result := Result + '  LEFT JOIN FORTIN ON MOVDET.DET_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = MOVDET.DET_EMPACA ';
  Result := Result + '  LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = UNI_CODUNI ';


  Result := Result + '  LEFT JOIN MOVGER ON MOVGER.AUTOINCREM =  MOVDET.DET_SEQGER ';

  //codigo de barras da formulacao
  Result := Result + '  LEFT JOIN CADACA ON ACA_CODACA = TINDET.DET_CODACA ';
  Result := Result + '                  AND ACA_CODEMP = TINDET.DET_EMPACA ';

  Result := Result + '  LEFT JOIN CADITE EMB ON EMB.ITE_CODITE = MOVDET.DET_ITEEMB ';

  Result := Result + '  LEFT JOIN EXPARQ ON EXPARQ.AUTOINCREM = TINDET.AUTOINCREM ';

  Result := Result + 'WHERE ';

  If Not fApenasBaixados Then
  begin
    Result := Result + '  (TINDET.DET_BAIXAD = "N") AND ' ;

    If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
      Result := Result + '  TINDET.DET_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                               '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';

  end
  Else
  Begin
    Result := Result + '  IFNULL(TINDET.DET_BAIXAD,"N") <> "N" AND ';
    Result := Result + '  TINDET.DET_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) + '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';
  End;
  Result := Result + '  TINDET.DET_ESPDOC = "EP" AND ';
  Result := Result + '  TINDET.DET_EMPPRD = :CODEMP ';
end;

function TfrmFatFormulacaoItens.fRetSQLFormulacaoCd(strSQL: String): String;
Var
  strSQLTemp : String;
  qryAux     : TUniQuery;

  function fSQLEntCd: String;
  begin
    Result := '';
    Result := Result + ' ( ';
    Result := Result + '   (FATGOR.FGO_ENT_CD = "S" AND EXTGOR.FGO_EMP_CD = :CODEMP) ';
    {***********************************************************************************************************************************}
    {* A PARTIR DA VERSÃO 72.49, PEDIDOS DE TRANSFERÊNCIA VINDOS DE CLIENTE FILIAL PASSARAM A VIR COMO FGO_ENT_CD = S (REQ.: 162831).  *}
    {* ATÉ ENTÃO FGO_ENT_CD PARA ESSES PEDIDOS FICAVAM COM FGO_ENT_CD = N. NO REQ.: 133410 FOI ALTERADO O SISTEMA PARA QUE APARECESSEM *}
    {* ESSES PEDIDOS, NO ENTANTO, A FORMA COMO FOI FEITO, FEZ COM QUE NÃO APARECESSE MAIS OS PEDIDOS GRAVADOR PÓS VERSÃO 72.49         *}
    {* REVERTI O CÓDIGO DO REQUISITO 133410 E FIZ COMO CÓDIGO ABAIXO, PARA QUE FUNCIONE EM AMBOS CENÁRIOS DOS REQS.: 133410 E 190356   *}
    {* SE O CLIENTE TIVESSE TRABALHANDO SÓ COM CÓPIA POSTERIOR A 72.49 NÃO PRECISARIA DA LINHA ABAIXO, MAS A BELA ESTÁ TRABALHANDO COM *}
    {* UMA CÓPIA 72.44 (PD DE TRANSF COM FGO_ENT_CD=N) E 72.77 (PD DE TRANSF COM FGO_ENT_CD=S) OU SEJA, NO FUTURO POSSO EVENTUALMENTE  *}
    {* TIRAR A CONDIÇÃO ABAIXO                                                                                                         *}
    {********************************************************************************************************************REQ.:190356*VA*}
    If (Not fEmptyStr(VS_strCliFilLocal)) And (fCfgSis('ENT_CD', varBoolean)) And (fCfgSis('EMP_CD', varString) = VS_strCodEmp) Then
    Begin
      Result := Result + ' OR (FATGOR.FGO_CODCLI IN ('+VS_strCliFilLocal+') AND EXTGOR.FGO_EMP_TE = :CODEMP) ';
    End;
    {********************************************************************************************************************REQ.:190356*VA*}
    Result := Result + ' ) ';
  end;

begin
  If fTabelaExiste('TMP_FORMULACAO_CD') Then
    fDropTable('TMP_FORMULACAO_CD');

  strSQLTemp := ' JOIN TMP_FORMULACAO_CD ON TMP_FORMULACAO_CD.AUTOINCREM = FATGOR.AUTOINCREM';

  Try
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Text := ' CREATE TEMPORARY TABLE TMP_FORMULACAO_CD  '+
                       ' ( SELECT DISTINCT '+
                       '          FATGOR.AUTOINCREM '+
                       '     FROM FATGOR   '+
                       '     LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM  '+
                       '     LEFT JOIN TINGOR ON TINGOR.AUTOINCREM = FATGOR.AUTOINCREM  '+
                       '     LEFT JOIN TINDOR ON TINDOR.FDO_SEQGER = TINGOR.AUTOINCREM  '+
                       '    WHERE ' + fSQLEntCd +
                       '      AND FATGOR.FGO_OPRFLJ = "N"  '+
                       '      AND TINGOR.FGO_ESPDOC = "PD"  ';

    If fApenasBaixados Then
    begin
      qryAux.SQL.Text :=
        qryAux.SQL.Text + ' AND FDO_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                        '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +
                          '" AND FDO_BAIXAD <> "N" ); ';
    End
    else
    begin
      If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
      begin
        qryAux.SQL.Text :=
        qryAux.SQL.Text + ' AND TINDOR.FDO_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                                   '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +'"' ;
      end;

      qryAux.SQL.Text := qryAux.SQL.Text + ' AND FDO_BAIXAD = "N"); ';

    end;

    qryAux.SQL.Text :=  qryAux.SQL.Text + '    ALTER TABLE TMP_FORMULACAO_CD ADD KEY IDX_FORMULACAO_01 (AUTOINCREM);  ';

    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;

  Result := AnsiReplaceStr(strSQL,'TABELA_TEMPORARIA',strSQLTemp);
end;

function TfrmFatFormulacaoItens.fRetSQLFormulacaoForaLoja(strSQL: String): String;
Var
  strSQLTemp : String;
  qryAux     : TUniQuery;
begin
  If fTabelaExiste('TMP_FORMULACAO_OPRFLJ') Then
    fDropTable('TMP_FORMULACAO_OPRFLJ');

  strSQLTemp := ' JOIN TMP_FORMULACAO_OPRFLJ ON TMP_FORMULACAO_OPRFLJ.AUTOINCREM = FATGOR.AUTOINCREM ';

  Try
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Text := ' CREATE TEMPORARY TABLE TMP_FORMULACAO_OPRFLJ '+
                       '   ( SELECT DISTINCT '+
                       '            FATGOR.AUTOINCREM '+
                       '       FROM FATGOR '+
                       '       LEFT JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM '+
                       '                       AND FATDOR.FDO_ESPDOC = FATGOR.FGO_ESPDOC '+
                       '       LEFT JOIN TINGOR ON TINGOR.AUTOINCREM = FATGOR.AUTOINCREM '+
                       '                       AND TINGOR.FGO_ESPDOC = FATGOR.FGO_ESPDOC '+
                       '       LEFT JOIN TINDOR ON TINDOR.FDO_SEQGER = TINGOR.AUTOINCREM '+
                       '      WHERE FATGOR.FGO_ENT_CD = "N" '+
                       '        AND FATGOR.FGO_OPRFLJ = "S" '+
                       '        AND FDO_EMPPRD = :CODEMP '+
                       '        AND FATGOR.FGO_ESPDOC = "PD" '+
                       '        AND FATDOR.FDO_IDEPRO <> "NOR" ';

    If fApenasBaixados Then
    begin
      qryAux.SQL.Text :=
        qryAux.SQL.Text + ' AND FDO_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                        '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +
                          '" AND FDO_BAIXAD <> "N" ); ';
    End
    else
    begin
      If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
      begin
        qryAux.SQL.Text :=
          qryAux.SQL.Text + ' AND TINDOR.FDO_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                                     '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +'"' ;
      end;

      qryAux.SQL.Text := qryAux.SQL.Text + ' AND FDO_BAIXAD = "N"); ';

    end;

    qryAux.SQL.Text :=  qryAux.SQL.Text + ' ALTER TABLE TMP_FORMULACAO_OPRFLJ ADD KEY IDX_FORMULACAO_01 (AUTOINCREM);';

    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;

  Result := AnsiReplaceStr(strSQL,'TABELA_TEMPORARIA',strSQLTemp);
  Result := Result + ' AND FDO_EMPPRD = :CODEMP   ';
end;

function TfrmFatFormulacaoItens.fRetSQLFormulacaoLoja(strSQL: String): String;
Var
  strSQLTemp : String;
  qryAux     : TUniQuery;
begin

  If fTabelaExiste('TMP_FORMULACAO_LOJA') Then
    fDropTable('TMP_FORMULACAO_LOJA');

  strSQLTemp := ' JOIN TMP_FORMULACAO_LOJA ON TMP_FORMULACAO_LOJA.AUTOINCREM = FATGOR.AUTOINCREM ';

  Try
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Text := 'CREATE TEMPORARY TABLE TMP_FORMULACAO_LOJA '+
                       '   ( SELECT DISTINCT '+
                       '            FATGOR.AUTOINCREM '+
                       '       FROM FATGOR '+
                       '       LEFT JOIN TINGOR ON TINGOR.AUTOINCREM = FATGOR.AUTOINCREM '+
                       '       LEFT JOIN TINDOR ON TINDOR.FDO_SEQGER = TINGOR.AUTOINCREM '+
                       '      WHERE FATGOR.FGO_ENT_CD = "N" '+
                       '        AND FATGOR.FGO_OPRFLJ = "N" '+
                       '        AND TINGOR.FGO_CODEMP = :CODEMP '+
                       '        AND TINGOR.FGO_ESPDOC = "PD" ';
    If fApenasBaixados Then
    begin
      qryAux.SQL.Text :=
        qryAux.SQL.Text + ' AND FDO_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                            '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +
                          '" AND FDO_BAIXAD <> "N" ); ';
    End
    else
    begin
      If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
      begin
        qryAux.SQL.Text :=
          qryAux.SQL.Text + ' AND TINDOR.FDO_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                                     '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +'"';
      end;

      qryAux.SQL.Text := qryAux.SQL.Text + ' AND FDO_BAIXAD = "N"); ';

    end;

    qryAux.SQL.Text := qryAux.SQL.Text +' ALTER TABLE TMP_FORMULACAO_LOJA ADD KEY IDX_FORMULACAO_01 (AUTOINCREM);';

    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;

  Finally
    FreeAndNil(qryAux);
  End;

  Result := AnsiReplaceStr(strSQL,'TABELA_TEMPORARIA',strSQLTemp);
end;

function TfrmFatFormulacaoItens.fRetSQLFormulacaoAbastecimentoPorDeposito(strSQL: String): String;
Var
  strSQLTemp : String;
  qryAux     : TUniQuery;

  function fSQLEntCd: String;
  begin
    Result := '';
    Result := Result + ' ( ';
    Result := Result + '   (FATGOR.FGO_ENT_CD = "S" AND EXTGOR.FGO_EMP_CD = :CODEMP) ';
    Result := Result + ' ) ';
  end;

begin
  If fTabelaExiste('TMP_FORMULACAO_ABADEP') Then
    fDropTable('TMP_FORMULACAO_ABADEP');

  strSQLTemp := ' JOIN TMP_FORMULACAO_ABADEP ON TMP_FORMULACAO_ABADEP.AUTOINCREM = FATGOR.AUTOINCREM';

  Try
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Text := ' CREATE TEMPORARY TABLE TMP_FORMULACAO_ABADEP  '+
                       ' ( SELECT DISTINCT '+
                       '          FATGOR.AUTOINCREM '+
                       '     FROM FATGOR   '+
                       '     LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM  '+
                       '     LEFT JOIN TINGOR ON TINGOR.AUTOINCREM = FATGOR.AUTOINCREM  '+
                       '     LEFT JOIN TINDOR ON TINDOR.FDO_SEQGER = TINGOR.AUTOINCREM  '+
                       '    WHERE ' + fSQLEntCd +
                       '      AND EXTGOR.FGO_ABADEP = "S"  '+
                       '      AND FATGOR.FGO_OPRFLJ = "S"  '+
                       '      AND TINGOR.FGO_ESPDOC = "PD"  ';

    If fApenasBaixados Then
    begin
      qryAux.SQL.Text :=
        qryAux.SQL.Text + ' AND FDO_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                        '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +
                          '" AND FDO_BAIXAD <> "N" ); ';
    End
    else
    begin
      If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
      begin
        qryAux.SQL.Text :=
        qryAux.SQL.Text + ' AND TINDOR.FDO_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                                   '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) +'"' ;
      end;

      qryAux.SQL.Text := qryAux.SQL.Text + ' AND FDO_BAIXAD = "N"); ';

    end;

    qryAux.SQL.Text :=  qryAux.SQL.Text + '    ALTER TABLE TMP_FORMULACAO_ABADEP ADD KEY IDX_FORMULACAO_01 (AUTOINCREM);  ';

    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;

  Result := AnsiReplaceStr(strSQL,'TABELA_TEMPORARIA',strSQLTemp);
end;

function TfrmFatFormulacaoItens.fRetSQLOrdemProdAvulsa: String;
begin
  Result := Result + 'SELECT ';

  If fCfgSis('LOCRET') = 'S' Then
  Begin
    Result := Result + '  IF(MOVGER.GER_ENTFAT = "N" , ';
    Result := Result + '  CASE (SELECT DISTINCT EXT.FDO_LOCRET FROM FATDOR FAT ';
    Result := Result + '  LEFT JOIN EXTDOR EXT ON     ';
    Result := Result + '    EXT.FDO_SEQFDO = FAT.AUTOINCREM   ';
    Result := Result + '  WHERE                       ';
    Result := Result + '    FAT.FDO_CODACA = MOVDET.DET_CODACA AND    ';
    Result := Result + '    FAT.FDO_EMPACA = MOVDET.DET_EMPACA AND    ';
    Result := Result + '    FAT.FDO_NUMDOC = MOVDET.DET_NUM_PD AND    ';
    Result := Result + '    FAT.FDO_ESPDOC = MOVDET.DET_ESP_PD AND    ';
    Result := Result + '    FAT.FDO_CODEMP = MOVDET.DET_EMP_PD) ';
    Result := Result + '    WHEN "C" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('CAIXA', 1) + '" ';
    Result := Result + '    WHEN "B" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO', 3) + '" ';
    Result := Result + '    WHEN "B2" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO 2', 4) + '" ';
    Result := Result + '    ELSE "RETIRA ' + fVerificaDescAdicionalLocRet('EXPEDIÇÃO', 2) + '" ';
    Result := Result + '    END, IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';
  End
  Else
    Result := Result + '  IF(MOVGER.GER_ENTFAT = "N" , "RETIRA", IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';

  Result := Result + '  "N"  AS BAIXAOP, ';
  Result := Result + '  CAST(TINDET.DET_DESCRI AS CHAR(100)) AS DET_DESCRI, ';
  Result := Result + '  TINDET.DET_DTAENT AS DTAENT, ';
  Result := Result + '  TINDET.DET_HORENT AS HORENT, ';
  Result := Result + '  IF(TINDET.DET_AJUFOR = "S", "S", "N") AS AJUFOR,  ';
  Result := Result + '  TINDET.DET_SEQGER , TINDET.AUTOINCREM , TINDET.DET_CODEMP, ';
  Result := Result + '  TINDET.DET_CODDIV , TINDET.DET_CODMAR , TINDET.DET_CODITE, ';
  Result := Result + '  TINDET.DET_CODVEN , TINDET.DET_CODCLI , TINDET.DET_NUMDOC, ';
  Result := Result + '  TINDET.DET_ESPDOC , TINDET.DET_DTAENT , TINDET.DET_HORENT, ';
  Result := Result + '  TINDET.DET_CONPAG , TINDET.DET_ESTADO , TINDET.DET_DESCRI , TINDET.DET_REFERE, ';
  Result := Result + '  TINDET.DET_UNIDAD , TINDET.DET_FORITE , ';
  Result := Result + '  (TINDET.DET_QTDITE - 0) AS DET_QTDITE,';
  Result := Result + '  TINDET.DET_INCPIS , TINDET.DET_NOTESP , TINDET.DET_IDEPRO, ';
  Result := Result + '  TINDET.DET_ITETIN , TINDET.DET_ITECHA , TINDET.DET_DESCOR, ';
  Result := Result + '  TINDET.DET_TIPEMB , TINDET.DET_QTDEMB , TINDET.DET_PREEMB, ';
  Result := Result + '  TINDET.DET_TIPPRE , TINDET.DET_MONTAD , TINDET.DET_A_N_O_ , TINDET.DET_FORM01, ';
  Result := Result + '  TINDET.DET_QTDB01 , TINDET.DET_FORM02 , TINDET.DET_QTDB02, ';
  Result := Result + '  TINDET.DET_FORM03 , TINDET.DET_QTDB03,  TINDET.DET_FORM04 , TINDET.DET_QTDB04 , ';
  Result := Result + '  TINDET.DET_FORM05,  TINDET.DET_QTDB05 , TINDET.DET_FORM06 , TINDET.DET_QTDB06, ';
  Result := Result + '  TINDET.DET_FORM07 , TINDET.DET_QTDB07 , TINDET.DET_FORM08 , TINDET.DET_QTDB08, ';
  Result := Result + '  TINDET.DET_FORM09 , TINDET.DET_QTDB09 , TINDET.DET_FORM10, ';
  Result := Result + '  TINDET.DET_QTDB10 , TINDET.DET_FORM11 , TINDET.DET_QTDB11 , TINDET.DET_FORM12, ';
  Result := Result + '  TINDET.DET_QTDB12 , TINDET.DET_FORM13 , TINDET.DET_QTDB13, ';
  Result := Result + '  TINDET.DET_FORM14 , TINDET.DET_QTDB14 , TINDET.DET_FORM15 , TINDET.DET_QTDB15, ';
  Result := Result + '  TINDET.DET_CODDIG , TINDET.DET_IMPRES, ';
  Result := Result + '  TINDET.DET_BAIXAD , TINDET.DET_CODACA , TINDET.DET_EMPACA ,';
	Result := Result + '  MOVDET.DET_UNITAR , MOVDET.DET_TOTITE, MOVDET.DET_LINLIN, 	';
  Result := Result + '  MOVDET.DET_CATALI , MOVDET.DET_CODDIL, ';
	Result := Result + '  MOVDET.DET_PORDIL , MOVDET.DET_DILCON, MOVDET.DET_PORCAT, ';
  Result := Result + '  TINDET.DET_OPEBAI , TINDET.DET_HORBAI, ';
	Result := Result + '  TINDET.DET_DTABAI , TINDET.DET_PROCES, TINDET.DET_ORDIMP, ';



  Result := Result + '  "" AS FDO_ITEC01, "" AS FDO_ITEC02, "" AS FDO_ITEC03, "" AS FDO_ITEC04,';
  Result := Result + '  "" AS FDO_ITEC05, "" AS FDO_ITEC06, "" AS FDO_ITEC07, "" AS FDO_ITEC08,';
  Result := Result + '  "" AS FDO_ITEC09, "" AS FDO_ITEC10, "" AS FDO_ITEC11, "" AS FDO_ITEC12,';
  Result := Result + '  "" AS FDO_ITEC13, "" AS FDO_ITEC14, "" AS FDO_ITEC15, "" AS FDO_ITEC16,';
  Result := Result + '  "" AS FDO_ITEC17, "" AS FDO_ITEC18, "" AS FDO_ITEC19, "" AS FDO_ITEC20,';


  Result := Result + ' 0 AS DET_TINAUT, TINDET.DET_LINTIN, TINDET.DET_FORM16, TINDET.DET_QTDB16,';
  Result := Result + ' TINDET.DET_FORM17, TINDET.DET_QTDB17, TINDET.DET_FORM18, TINDET.DET_QTDB18,';
  Result := Result + ' TINDET.DET_FORM19, TINDET.DET_QTDB19, TINDET.DET_FORM20, TINDET.DET_QTDB20,';



  Result := Result + '  IF(TINDET.DET_ORDIMP = 0, "N", "S") AS ORDIMP, ';
  Result := Result + '  TINGER.GER_NOMCON, ';
  Result := Result + '  TINGER.GER_ENDCON, ';
  Result := Result + '  TINGER.GER_BAICON, ';
  Result := Result + '  TINGER.GER_CEPCON, ';
  Result := Result + '  TINGER.GER_CIDCON, ';
  Result := Result + '  TINGER.GER_TELCON, ';
  Result := Result + '  TINGER.GER_CGCCPF, ';
  Result := Result + '  TINGER.GER_CGCCON, ';
  Result := Result + '  TINGER.GER_IESCON, ';
  Result := Result + '  TINGER.GER_R_GCON, ';
  Result := Result + '  TINGER.GER_ESTADO, ';
  Result := Result + '  TINGER.GER_ESPDOC, ';
  Result := Result + '  TINGER.AUTOINCREM AS AUTINC, ';

  Result := Result + '  "" AS FGO_MENFOR,';
  Result := Result + '  "" AS FGO_ENT_CD,';
  Result := Result + '  TINDET.DET_EMPPRD,';
  Result := Result + '  "" AS FGO_DOCFAT,';
  Result := Result + '  "" AS FGO_NUMFAT,';
  Result := Result + '  "" AS FGO_TIPFAT,';
  Result := Result + '  "" AS FGO_EMPFAT,';
  Result := Result + '  "" AS FGO_EMP_TE,';


  Result := Result + '  CADITE.ITE_CODMAR, ';
  Result := Result + '  CADITE.ITE_DESITE, ';
  Result := Result + '  CADITE.ITE_REFERE, ';
  Result := Result + '  CADITE.ITE_CODUNI, ';
  Result := Result + '  CADITE.ITE_CODFOR, ';

  Result := Result + '  ITEGER.ITE_PREVE1, ';
  Result := Result + '  ITEGER.ITE_PRECUS, ';
  Result := Result + '  ITEGER.ITE_PREMED, ';

  Result := Result + '  0  AS FOR_MODDIL, ';
  Result := Result + '  "" AS FOR_TEXBAS, ';
  Result := Result + '  "" AS FOR_TIPCOR, ';
  Result := Result + '  "" AS FOR_ITECOB, ';
  Result := Result + '  "" AS FOR_UNIVER, ';

  Result := Result + '  CADUNI.UNI_DESUNI,';
  Result := Result + '  CLI_CODCLI,';
  Result := Result + '  IF(TINGER.GER_NOMCON IS NULL OR TINGER.GER_NOMCON = "", CLI_NOMCLI, TINGER.GER_NOMCON) AS DET_NOMCLI, ';
  Result := Result + '  TINDET.AUTOINCREM AS CHAVE,';

  Result := Result + '  TINDET.DET_EMPPRD, ';
  Result := Result + '  TINDET.DET_VOLPRO, ';
  Result := Result + '  TINDET.DET_LAZQUA, ';
  Result := Result + '  NULL DET_ITEEMB, ';

  Result := Result + ' (SELECT ';
  Result := Result + '    FIS_NUMCOO ';
  Result := Result + '  FROM ';
  Result := Result + '    CADFIS ';
  Result := Result + '  WHERE FIS_NUMDOC = MOVDET.DET_NUMDOC ';
  Result := Result + '    AND FIS_ESPDOC = MOVDET.DET_ESPDOC ';
  Result := Result + '    AND FIS_CODEMP = MOVDET.DET_CODEMP ';
  Result := Result + '    AND FIS_FORCLI = MOVDET.DET_CODCLI ';
  Result := Result + '    AND FIS_TIP_FC = MOVDET.DET_TIP_FC ';
  Result := Result + '    AND FIS_ORIDOC = MOVDET.DET_ORIDOC ) AS FIS_NUMCOO, ';

  Result := Result + '  IF(MOVGER.GER_ENTFAT = "N", 0 , IF(MOVDET.DET_DOCFUT <> "", 2, 1)) AS DESTINO, ';
  Result := Result + '   "OK" AS SITFIN ';


  Result := Result + '  , ACA_CODBAR  AS CODBAR_ACA ';
  Result := Result + '  , EMB.ITE_CODBAR  AS CODBAR_EMB ';
  Result := Result + '  , CADITE.ITE_CODBAR AS CODBAR_BASE ';

  Result := Result + '  , EXPARQ.AUTOINCREM SEQ_EXPARQ ';
  Result := Result + '  , "" AS DIRARQEXP ';
  Result := Result + '  , "" AS CODSEP    ';
  Result := Result + '  , "0" AS SEPIMP   ';
  Result := Result + '  , "" AS AUTINC_DOCORI ';

  Result := Result + ' , TINDET.DET_TIPFOR AS TIPFOR';
  Result := Result + ' , TINDET.DET_OBSCOL AS OBSCOL';
  Result := Result + ' , TINDET.DET_EMPACA AS EMPACA';
  Result := Result + ' , TINDET.DET_CODACA AS CODACA';
  Result := Result + ' , CAST("" AS CHAR(10)) AS DTAULT ';
  Result := Result + ' , (SELECT CADLOT.LOT_NUMLOT     ';
  Result := Result + '   FROM CADLOT                ';
  Result := Result + ' WHERE CADLOT.LOT_CODITE = TINDET.DET_CODITE AND  ';
  Result := Result + '       CADLOT.LOT_CODEMP = :CODEMP AND            ';
  Result := Result + '       CADLOT.LOT_PRITIN = "S"                    ';
  Result := Result + ' LIMIT 1) AS NUMLOT                               ';
  Result := Result + ' , MOVDET.DET_SEQGER AS SEQGER_DOCFAT ';
  Result := Result + 'FROM ';
  Result := Result + '  TINDET ';
  Result := Result + '  JOIN CADCLI ON CLI_CODCLI = TINDET.DET_CODCLI ';
  Result := Result + '  JOIN TINGER ON TINGER.AUTOINCREM = TINDET.DET_SEQGER ';
  Result := Result + '  JOIN CADITE ON CADITE.ITE_CODITE = TINDET.DET_CODITE ';
  Result := Result + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '                 AND ITEGER.ITE_CODEMP = :CODEMP ';
  Result := Result + '  JOIN MOVDET ON MOVDET.DET_CODACA = TINDET.DET_CODACA AND ';
  Result := Result + '                 MOVDET.DET_EMPACA = TINDET.DET_EMPACA AND ';
  Result := Result + '                 MOVDET.DET_NUMDOC = TINDET.DET_NUMDOC AND ';
  Result := Result + '                 MOVDET.DET_ESPDOC = TINDET.DET_ESPDOC AND ';
  Result := Result + '                 MOVDET.DET_CODEMP = TINDET.DET_CODEMP AND ';
  Result := Result + '                 MOVDET.DET_CODCLI = TINDET.DET_CODCLI AND ';
  Result := Result + '                 MOVDET.DET_PROEMB <> "S"  AND ';
  Result := Result + '                 MOVDET.DET_ENTFUT <> "S"      ';
  Result := Result + '  LEFT JOIN FORTIN ON MOVDET.DET_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = MOVDET.DET_EMPACA ';
  Result := Result + '  LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = UNI_CODUNI ';


  Result := Result + '  LEFT JOIN MOVGER ON MOVGER.AUTOINCREM =  MOVDET.DET_SEQGER ';

  //codigo de barras da formulacao
  Result := Result + '  LEFT JOIN CADACA ON ACA_CODACA = TINDET.DET_CODACA ';
  Result := Result + '                  AND ACA_CODEMP = TINDET.DET_EMPACA ';

  Result := Result + '  LEFT JOIN CADITE EMB ON EMB.ITE_CODITE = MOVDET.DET_ITEEMB ';

  Result := Result + '  LEFT JOIN EXPARQ ON EXPARQ.AUTOINCREM = TINDET.AUTOINCREM ';

  Result := Result + 'WHERE ';

  If Not fApenasBaixados Then
  begin
    Result := Result + '  (TINDET.DET_BAIXAD = "N") AND ' ;

    If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
      Result := Result + '  TINDET.DET_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                               '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';

  end
  Else
  Begin
    Result := Result + '  IFNULL(TINDET.DET_BAIXAD,"N") <> "N" AND ';
    Result := Result + '  TINDET.DET_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) + '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';
  End;
  Result := Result + '  TINDET.DET_ESPDOC = "PA" AND ';
  Result := Result + '  TINDET.DET_EMPPRD = :CODEMP ';
end;

function TfrmFatFormulacaoItens.fRetSQLVendasDiretas: String;
begin
  Result := Result + 'SELECT ';

  If fCfgSis('LOCRET') = 'S' Then
  Begin
    Result := Result + '  IF(MOVGER.GER_ENTFAT = "N", ';
    Result := Result + '  CASE (SELECT DISTINCT EXT.FDO_LOCRET FROM FATDOR FAT ';
    Result := Result + '  LEFT JOIN EXTDOR EXT ON     ';
    Result := Result + '    EXT.FDO_SEQFDO = FAT.AUTOINCREM   ';
    Result := Result + '  WHERE                       ';
    Result := Result + '    FAT.FDO_CODACA = MOVDET.DET_CODACA AND    ';
    Result := Result + '    FAT.FDO_EMPACA = MOVDET.DET_EMPACA AND    ';
    Result := Result + '    FAT.FDO_NUMDOC = MOVDET.DET_NUM_PD AND    ';
    Result := Result + '    FAT.FDO_ESPDOC = MOVDET.DET_ESP_PD AND    ';
    Result := Result + '    FAT.FDO_CODEMP = MOVDET.DET_EMP_PD) ';
    Result := Result + '    WHEN "C" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('CAIXA', 1) + '" ';
    Result := Result + '    WHEN "B" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO', 3) + '" ';
    Result := Result + '    WHEN "B2" THEN "RETIRA ' + fVerificaDescAdicionalLocRet('BALCÃO 2', 4) + '" ';
    Result := Result + '    ELSE "RETIRA ' + fVerificaDescAdicionalLocRet('EXPEDIÇÃO', 2) + '" ';
    Result := Result + '    END, IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';
  End
  Else
    Result := Result + '  IF(MOVGER.GER_ENTFAT = "N" , "RETIRA", IF(MOVGER.GER_ENTFUT = "S", "ENT.FUTURA", "ENT.IMEDIATA")) AS FDO_ENTRET, ';

  Result := Result + '  "N"  AS BAIXAOP, ';
  Result := Result + '  CAST(TINDET.DET_DESCRI AS CHAR(100)) AS DET_DESCRI, ';
  Result := Result + '  TINDET.DET_DTAENT AS DTAENT, ';
  Result := Result + '  TINDET.DET_HORENT AS HORENT, ';
  Result := Result + '  IF(TINDET.DET_AJUFOR = "S", "S", "N") AS AJUFOR,  ';
  Result := Result + '  TINDET.DET_SEQGER , TINDET.AUTOINCREM , TINDET.DET_CODEMP, ';
  Result := Result + '  TINDET.DET_CODDIV , TINDET.DET_CODMAR , TINDET.DET_CODITE, ';
  Result := Result + '  TINDET.DET_CODVEN , TINDET.DET_CODCLI , TINDET.DET_NUMDOC, ';
  Result := Result + '  TINDET.DET_ESPDOC , TINDET.DET_DTAENT , TINDET.DET_HORENT, ';
  Result := Result + '  TINDET.DET_CONPAG , TINDET.DET_ESTADO , TINDET.DET_DESCRI , TINDET.DET_REFERE, ';
  Result := Result + '  TINDET.DET_UNIDAD , TINDET.DET_FORITE , ';
  Result := Result + '  (TINDET.DET_QTDITE - 0) AS DET_QTDITE,';
  Result := Result + '  TINDET.DET_INCPIS , TINDET.DET_NOTESP , TINDET.DET_IDEPRO, ';
  Result := Result + '  TINDET.DET_ITETIN , TINDET.DET_ITECHA , TINDET.DET_DESCOR, ';
  Result := Result + '  TINDET.DET_TIPEMB , TINDET.DET_QTDEMB , TINDET.DET_PREEMB, ';
  Result := Result + '  TINDET.DET_TIPPRE , TINDET.DET_MONTAD , TINDET.DET_A_N_O_ , TINDET.DET_FORM01, ';
  Result := Result + '  TINDET.DET_QTDB01 , TINDET.DET_FORM02 , TINDET.DET_QTDB02, ';
  Result := Result + '  TINDET.DET_FORM03 , TINDET.DET_QTDB03,  TINDET.DET_FORM04 , TINDET.DET_QTDB04 , ';
  Result := Result + '  TINDET.DET_FORM05,  TINDET.DET_QTDB05 , TINDET.DET_FORM06 , TINDET.DET_QTDB06, ';
  Result := Result + '  TINDET.DET_FORM07 , TINDET.DET_QTDB07 , TINDET.DET_FORM08 , TINDET.DET_QTDB08, ';
  Result := Result + '  TINDET.DET_FORM09 , TINDET.DET_QTDB09 , TINDET.DET_FORM10, ';
  Result := Result + '  TINDET.DET_QTDB10 , TINDET.DET_FORM11 , TINDET.DET_QTDB11 , TINDET.DET_FORM12, ';
  Result := Result + '  TINDET.DET_QTDB12 , TINDET.DET_FORM13 , TINDET.DET_QTDB13, ';
  Result := Result + '  TINDET.DET_FORM14 , TINDET.DET_QTDB14 , TINDET.DET_FORM15 , TINDET.DET_QTDB15, ';
  Result := Result + '  TINDET.DET_CODDIG , TINDET.DET_IMPRES, ';
  Result := Result + '  TINDET.DET_BAIXAD , TINDET.DET_CODACA , TINDET.DET_EMPACA ,';
	Result := Result + '  MOVDET.DET_UNITAR , MOVDET.DET_TOTITE, MOVDET.DET_LINLIN, 	';
  Result := Result + '  MOVDET.DET_CATALI , MOVDET.DET_CODDIL, ';
	Result := Result + '  MOVDET.DET_PORDIL , MOVDET.DET_DILCON, MOVDET.DET_PORCAT, ';
  Result := Result + '  TINDET.DET_OPEBAI , TINDET.DET_HORBAI, ';
	Result := Result + '  TINDET.DET_DTABAI , TINDET.DET_PROCES, TINDET.DET_ORDIMP, ';



  Result := Result + '  "" AS FDO_ITEC01, "" AS FDO_ITEC02, "" AS FDO_ITEC03, "" AS FDO_ITEC04,';
  Result := Result + '  "" AS FDO_ITEC05, "" AS FDO_ITEC06, "" AS FDO_ITEC07, "" AS FDO_ITEC08,';
  Result := Result + '  "" AS FDO_ITEC09, "" AS FDO_ITEC10, "" AS FDO_ITEC11, "" AS FDO_ITEC12,';
  Result := Result + '  "" AS FDO_ITEC13, "" AS FDO_ITEC14, "" AS FDO_ITEC15, "" AS FDO_ITEC16,';
  Result := Result + '  "" AS FDO_ITEC17, "" AS FDO_ITEC18, "" AS FDO_ITEC19, "" AS FDO_ITEC20,';


  Result := Result + ' 0 AS DET_TINAUT, TINDET.DET_LINTIN, TINDET.DET_FORM16, TINDET.DET_QTDB16,';
  Result := Result + ' TINDET.DET_FORM17, TINDET.DET_QTDB17, TINDET.DET_FORM18, TINDET.DET_QTDB18,';
  Result := Result + ' TINDET.DET_FORM19, TINDET.DET_QTDB19, TINDET.DET_FORM20, TINDET.DET_QTDB20,';



  Result := Result + '  IF(TINDET.DET_ORDIMP = 0, "N", "S") AS ORDIMP, ';
  Result := Result + '  TINGER.GER_NOMCON, ';
  Result := Result + '  TINGER.GER_ENDCON, ';
  Result := Result + '  TINGER.GER_BAICON, ';
  Result := Result + '  TINGER.GER_CEPCON, ';
  Result := Result + '  TINGER.GER_CIDCON, ';
  Result := Result + '  TINGER.GER_TELCON, ';
  Result := Result + '  TINGER.GER_CGCCPF, ';
  Result := Result + '  TINGER.GER_CGCCON, ';
  Result := Result + '  TINGER.GER_IESCON, ';
  Result := Result + '  TINGER.GER_R_GCON, ';
  Result := Result + '  TINGER.GER_ESTADO, ';
  Result := Result + '  TINGER.GER_ESPDOC, ';
  Result := Result + '  TINGER.AUTOINCREM AS AUTINC, ';

  Result := Result + '  "" AS FGO_MENFOR,';
  Result := Result + '  "" AS FGO_ENT_CD,';
  Result := Result + '  TINDET.DET_EMPPRD,';
  Result := Result + '  "" AS FGO_DOCFAT,';
  Result := Result + '  "" AS FGO_NUMFAT,';
  Result := Result + '  "" AS FGO_TIPFAT,';
  Result := Result + '  "" AS FGO_EMPFAT,';
  Result := Result + '  "" AS FGO_EMP_TE,';


  Result := Result + '  CADITE.ITE_CODMAR, ';
  Result := Result + '  CADITE.ITE_DESITE, ';
  Result := Result + '  CADITE.ITE_REFERE, ';
  Result := Result + '  CADITE.ITE_CODUNI, ';
  Result := Result + '  CADITE.ITE_CODFOR, ';

  Result := Result + '  ITEGER.ITE_PREVE1, ';
  Result := Result + '  ITEGER.ITE_PRECUS, ';
  Result := Result + '  ITEGER.ITE_PREMED, ';

  Result := Result + '  0  AS FOR_MODDIL, ';
  Result := Result + '  "" AS FOR_TEXBAS, ';
  Result := Result + '  "" AS FOR_TIPCOR, ';
  Result := Result + '  "" AS FOR_ITECOB, ';
  Result := Result + '  "" AS FOR_UNIVER, ';

  Result := Result + '  CADUNI.UNI_DESUNI,';
  Result := Result + '  CLI_CODCLI,';
  Result := Result + '  IF(TINGER.GER_NOMCON IS NULL OR TINGER.GER_NOMCON = "", CLI_NOMCLI, TINGER.GER_NOMCON) AS DET_NOMCLI, ';
  Result := Result + '  TINDET.AUTOINCREM AS CHAVE,';

  Result := Result + '  TINDET.DET_EMPPRD, ';
  Result := Result + '  TINDET.DET_VOLPRO, ';
  Result := Result + '  TINDET.DET_LAZQUA, ';
  Result := Result + '  NULL DET_ITEEMB, ';

  Result := Result + ' (SELECT ';
  Result := Result + '    FIS_NUMCOO ';
  Result := Result + '  FROM ';
  Result := Result + '    CADFIS ';
  Result := Result + '  WHERE FIS_NUMDOC = MOVDET.DET_NUMDOC ';
  Result := Result + '    AND FIS_ESPDOC = MOVDET.DET_ESPDOC ';
  Result := Result + '    AND FIS_CODEMP = MOVDET.DET_CODEMP ';
  Result := Result + '    AND FIS_FORCLI = MOVDET.DET_CODCLI ';
  Result := Result + '    AND FIS_TIP_FC = MOVDET.DET_TIP_FC ';
  Result := Result + '    AND FIS_ORIDOC = MOVDET.DET_ORIDOC ) AS FIS_NUMCOO, ';

  Result := Result + '  IF(MOVGER.GER_ENTFAT = "N", 0 , IF(MOVDET.DET_DOCFUT <> "", 2, 1)) AS DESTINO, ';
  Result := Result + '   "OK" AS SITFIN ';


  Result := Result + '  , ACA_CODBAR  AS CODBAR_ACA ';
  Result := Result + '  , EMB.ITE_CODBAR  AS CODBAR_EMB ';
  Result := Result + '  , CADITE.ITE_CODBAR AS CODBAR_BASE ';

  Result := Result + '  , EXPARQ.AUTOINCREM SEQ_EXPARQ ';
  Result := Result + '  , "" AS DIRARQEXP ';
  Result := Result + '  , "" AS CODSEP    ';
  Result := Result + '  , "0" AS SEPIMP   ';
  Result := Result + '  , "" AS AUTINC_DOCORI ';

  Result := Result + ' , TINDET.DET_TIPFOR AS TIPFOR';
  Result := Result + ' , TINDET.DET_OBSCOL AS OBSCOL';
  Result := Result + ' , TINDET.DET_EMPACA AS EMPACA';
  Result := Result + ' , TINDET.DET_CODACA AS CODACA';
  Result := Result + ' , CAST("" AS CHAR(10)) AS DTAULT ';
  Result := Result + ' , (SELECT CADLOT.LOT_NUMLOT     ';
  Result := Result + '   FROM CADLOT                ';
  Result := Result + ' WHERE CADLOT.LOT_CODITE = TINDET.DET_CODITE AND  ';
  Result := Result + '       CADLOT.LOT_CODEMP = :CODEMP AND            ';
  Result := Result + '       CADLOT.LOT_PRITIN = "S"                    ';
  Result := Result + ' LIMIT 1) AS NUMLOT                               ';
  Result := Result + ' , MOVDET.DET_SEQGER AS SEQGER_DOCFAT ';
  Result := Result + 'FROM ';
  Result := Result + '  TINDET ';
  Result := Result + '  JOIN CADCLI ON CLI_CODCLI = TINDET.DET_CODCLI ';
  Result := Result + '  JOIN TINGER ON TINGER.AUTOINCREM = TINDET.DET_SEQGER ';
  Result := Result + '  JOIN CADITE ON CADITE.ITE_CODITE = TINDET.DET_CODITE ';
  Result := Result + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  Result := Result + '                 AND ITEGER.ITE_CODEMP = :CODEMP ';
  Result := Result + '  JOIN MOVDET ON MOVDET.DET_CODACA = TINDET.DET_CODACA AND ';
  Result := Result + '                 MOVDET.DET_EMPACA = TINDET.DET_EMPACA AND ';
  Result := Result + '                 MOVDET.DET_NUMDOC = TINDET.DET_NUMDOC AND ';
  Result := Result + '                 MOVDET.DET_ESPDOC = TINDET.DET_ESPDOC AND ';
  Result := Result + '                 MOVDET.DET_CODEMP = TINDET.DET_CODEMP AND ';
  Result := Result + '                 MOVDET.DET_CODCLI = TINDET.DET_CODCLI AND ';
  Result := Result + '                 MOVDET.DET_PROEMB <> "S"  AND ';
  Result := Result + '                 MOVDET.DET_ENTFUT <> "S"  AND ';
  Result := Result + '                ((MOVDET.DET_NUM_PD = "") OR (MOVDET.DET_NUM_PD IS NULL))   AND';
  Result := Result + '                ((MOVDET.DET_ESP_PD = "") OR (MOVDET.DET_ESP_PD IS NULL))   AND';
  Result := Result + '                ((MOVDET.DET_EMP_PD = "") OR (MOVDET.DET_EMP_PD IS NULL))      ';
  Result := Result + '  LEFT JOIN FORTIN ON MOVDET.DET_CODACA = FORTIN.FOR_CODACA AND FORTIN.FOR_EMPACA = MOVDET.DET_EMPACA ';
  Result := Result + '  LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = UNI_CODUNI ';


  Result := Result + '  LEFT JOIN MOVGER ON MOVGER.AUTOINCREM =  MOVDET.DET_SEQGER ';

  //codigo de barras da formulacao
  Result := Result + '  LEFT JOIN CADACA ON ACA_CODACA = TINDET.DET_CODACA ';
  Result := Result + '                  AND ACA_CODEMP = TINDET.DET_EMPACA ';

  Result := Result + '  LEFT JOIN CADITE EMB ON EMB.ITE_CODITE = MOVDET.DET_ITEEMB ';

  Result := Result + '  LEFT JOIN EXPARQ ON EXPARQ.AUTOINCREM = TINDET.AUTOINCREM ';

  Result := Result + 'WHERE ';

  If Not fApenasBaixados Then
  begin
    Result := Result + '  (TINDET.DET_BAIXAD = "N") AND ' ;

    If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
      Result := Result + '  TINDET.DET_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) +
                                               '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';

  end
  Else
  Begin
    Result := Result + '  IFNULL(TINDET.DET_BAIXAD,"N") <> "N" AND ';
    Result := Result + '  TINDET.DET_DTABAI BETWEEN "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaIni.Text)) + '" AND "' + FormatDateTime('yyyy-mm-dd',StrToDate(mskDtaFin.Text)) + '" AND ';
  End;
  Result := Result + '  TINDET.DET_ESPDOC <> "PA" AND ';
  Result := Result + '  TINDET.DET_EMPPRD = :CODEMP ';
end;

function TfrmFatFormulacaoItens.fRetTabela: String;
begin
  If (strCfgExi = 'V') Then
  Begin
    Result := '   TINDET.DET_SEQGER , TINDET.AUTOINCREM , TINDET.DET_CODEMP '+
              ' , TINDET.DET_CODDIV , TINDET.DET_CODMAR , TINDET.DET_CODITE '+
              ' , TINDET.DET_CODVEN , TINDET.DET_CODCLI , TINDET.DET_NUMDOC '+
              ' , TINDET.DET_ESPDOC , TINDET.DET_DTAENT , TINDET.DET_HORENT '+
              ' , TINDET.DET_CONPAG , TINDET.DET_ESTADO , TINDET.DET_DESCRI , TINDET.DET_REFERE '+
              ' , TINDET.DET_UNIDAD , TINDET.DET_FORITE , '+ fRetQuantidadeDevolucao +' AS DET_QTDITE '+
              ' , TINDET.DET_INCPIS , TINDET.DET_NOTESP , TINDET.DET_IDEPRO '+
              ' , TINDET.DET_ITETIN , TINDET.DET_ITECHA , TINDET.DET_DESCOR '+
              ' , TINDET.DET_TIPEMB , TINDET.DET_QTDEMB , TINDET.DET_PREEMB '+
              ' , TINDET.DET_TIPPRE , TINDET.DET_MONTAD , TINDET.DET_A_N_O_ , TINDET.DET_FORM01 '+
              ' , TINDET.DET_QTDB01 , TINDET.DET_FORM02 , TINDET.DET_QTDB02 '+
              ' , TINDET.DET_FORM03 , TINDET.DET_FORM04 , TINDET.DET_QTDB04 , TINDET.DET_FORM05 '+
              ' , TINDET.DET_QTDB05 , TINDET.DET_FORM06 , TINDET.DET_QTDB06 '+
              ' , TINDET.DET_FORM07 , TINDET.DET_QTDB07 , TINDET.DET_FORM08 , TINDET.DET_QTDB08 '+
              ' , TINDET.DET_FORM09 , TINDET.DET_QTDB09 , TINDET.DET_FORM10 '+
              ' , TINDET.DET_QTDB10 , TINDET.DET_FORM11 , TINDET.DET_QTDB11 , TINDET.DET_FORM12 '+
              ' , TINDET.DET_QTDB12 , TINDET.DET_FORM13 , TINDET.DET_QTDB13 '+
              ' , TINDET.DET_FORM14 , TINDET.DET_QTDB14 , TINDET.DET_FORM15 , TINDET.DET_QTDB15 '+
              ' , TINDET.DET_QTDB03 , TINDET.DET_CODDIG , TINDET.DET_IMPRES '+
              ' , TINDET.DET_BAIXAD , TINDET.DET_CODACA , TINDET.DET_EMPACA , TINDET.DET_GEROPR '+
              ' , TINDET.DET_CATALI , TINDET.DET_LINTIN , TINDET.DET_NUMOPR '+
              ' , TINDET.DET_EMPPRD , TINDET.DET_LAZQUA , TINDET.DET_VOLPRO , TINDET.DET_CODDIL '+
              ' , TINDET.DET_PORDIL , TINDET.DET_DILCON , TINDET.DET_PORCAT '+
              ' , TINDET.DET_OPEBAI , TINDET.DET_HORBAI , TINDET.DET_DTABAI , TINDET.DET_PROCES '+
              ' , TINDET.DET_ORDIMP , TINDET.DET_MOTBAI , TINDET.DET_FORM16 '+
              ' , TINDET.DET_QTDB16 , TINDET.DET_FORM17 , TINDET.DET_QTDB17 , TINDET.DET_FORM18 '+
              ' , TINDET.DET_QTDB18 , TINDET.DET_FORM19 , TINDET.DET_QTDB19 '+
              ' , TINDET.DET_FORM20 , TINDET.DET_QTDB20';
  End
  Else
  Begin
    Result := ' TINDOR.FDO_SEQGER, TINDOR.AUTOINCREM, TINDOR.FDO_CODEMP, '+
              ' TINDOR.FDO_CODDIV, TINDOR.FDO_CODMAR,'+
              ' TINDOR.FDO_CODITE, TINDOR.FDO_CODVEN, TINDOR.FDO_CODCLI, '+
              ' TINDOR.FDO_NUMDOC, TINDOR.FDO_ESPDOC, TINDOR.FDO_DTAENT,'+
              ' TINDOR.FDO_HORENT, TINDOR.FDO_CONPAG,'+
              ' TINDOR.FDO_ESTADO, TINDOR.FDO_DESCRI, TINDOR.FDO_REFERE, '+
              ' TINDOR.FDO_UNIDAD, TINDOR.FDO_FORITE, '+ fRetQuantidadeDevolucao +' AS FDO_QTDITE,'+
              ' TINDOR.FDO_INCPIS, TINDOR.FDO_NOTESP,'+
              ' TINDOR.FDO_IDEPRO, TINDOR.FDO_ITETIN, TINDOR.FDO_ITECHA, '+
              ' TINDOR.FDO_DESCOR, TINDOR.FDO_TIPEMB, TINDOR.FDO_QTDEMB,'+
              ' TINDOR.FDO_PREEMB, TINDOR.FDO_TIPPRE,'+
              ' TINDOR.FDO_MONTAD, TINDOR.FDO_A_N_O_, TINDOR.FDO_FORM01, '+
              ' TINDOR.FDO_QTDB01, TINDOR.FDO_FORM02, TINDOR.FDO_QTDB02,'+
              ' TINDOR.FDO_FORM03, TINDOR.FDO_QTDB03, '+
              ' TINDOR.FDO_FORM04, TINDOR.FDO_QTDB04, TINDOR.FDO_FORM05, '+
              ' TINDOR.FDO_QTDB05, TINDOR.FDO_FORM06, TINDOR.FDO_QTDB06,'+
              ' TINDOR.FDO_FORM07, TINDOR.FDO_QTDB07,'+
              ' TINDOR.FDO_FORM08, TINDOR.FDO_QTDB08, TINDOR.FDO_FORM09, '+
              ' TINDOR.FDO_QTDB09, TINDOR.FDO_FORM10, TINDOR.FDO_QTDB10,'+
              ' TINDOR.FDO_FORM11, TINDOR.FDO_QTDB11,'+
              ' TINDOR.FDO_FORM12, TINDOR.FDO_QTDB12, TINDOR.FDO_FORM13, '+
              ' TINDOR.FDO_QTDB13, TINDOR.FDO_FORM14, TINDOR.FDO_QTDB14,'+
              ' TINDOR.FDO_FORM15, TINDOR.FDO_QTDB15,'+
              ' TINDOR.FDO_CODDIG, TINDOR.FDO_IMPRES, TINDOR.FDO_BAIXAD, '+
              ' TINDOR.FDO_CODACA, TINDOR.FDO_EMPACA, TINDOR.FDO_UNITAR,'+
              ' TINDOR.FDO_TOTITE, TINDOR.FDO_LINLIN,'+
              ' TINDOR.FDO_CATALI, TINDOR.FDO_CODDIL, TINDOR.FDO_PORDIL, '+
              ' TINDOR.FDO_DILCON, TINDOR.FDO_PORCAT, TINDOR.FDO_OPEBAI, '+
              ' TINDOR.FDO_HORBAI, TINDOR.FDO_DTABAI,'+
              ' TINDOR.FDO_PROCES, TINDOR.FDO_ORDIMP, TINDOR.FDO_ITEC01, '+
              ' TINDOR.FDO_ITEC02, TINDOR.FDO_ITEC03, TINDOR.FDO_ITEC04,'+
              ' TINDOR.FDO_ITEC05, TINDOR.FDO_ITEC06,'+
              ' TINDOR.FDO_ITEC07, TINDOR.FDO_ITEC08, TINDOR.FDO_ITEC09, '+
              ' TINDOR.FDO_ITEC10, TINDOR.FDO_ITEC11, TINDOR.FDO_ITEC12,'+
              ' TINDOR.FDO_ITEC13, TINDOR.FDO_ITEC14,'+
              ' TINDOR.FDO_ITEC15, TINDOR.FDO_ITEC16, TINDOR.FDO_ITEC17, '+
              ' TINDOR.FDO_ITEC18, TINDOR.FDO_ITEC19, TINDOR.FDO_ITEC20,'+
              ' TINDOR.FDO_TINAUT, TINDOR.FDO_LINTIN,'+
              ' TINDOR.FDO_FORM16, TINDOR.FDO_QTDB16, TINDOR.FDO_FORM17, '+
              ' TINDOR.FDO_QTDB17, TINDOR.FDO_FORM18, TINDOR.FDO_QTDB18,'+
              ' TINDOR.FDO_FORM19, TINDOR.FDO_QTDB19,'+
              ' TINDOR.FDO_FORM20, TINDOR.FDO_QTDB20 ';

  End;
end;

Function TfrmFatFormulacaoItens.fRetTintas: String;
  Var
    stlTintas: TStringList;
    intRecNo: Integer;
    cdsNaoExiste: TUniClientDataSet;

  procedure pAdicionaNaTempNaoExiste(strIdePro: String);
  begin
    cdsNaoExiste.Append;
    cdsNaoExiste.FieldByName('IDEPRO').AsString := strIdePro;
    cdsNaoExiste.Post;
  end;
Begin
  stlTintas := TStringList.Create;
  stlTintas.Sorted := True;
  stlTintas.Duplicates := dupIgnore;

  cdsNaoExiste := TUniClientDataSet.Create(Self);
  With cdsNaoExiste.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'IDEPRO';
    DataType := ftString;
    Size     := 3;
  End;

  cdsNaoExiste.CreateDataSet;

  With cdsTinMaq Do
  Begin
    intRecNo := RecNo;
    DisableControls;

    First;

    While Not Eof Do
    Begin
      If Not cdsNaoExiste.Locate('IDEPRO', FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA')  , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString, []) Then
      Begin
        If IsTintaExistente(FieldByName(IIF(  (strCfgExi = 'V') Or (strCfgExi = 'PA')  , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString) Then
          stlTintas.Add(FieldByName(IIF( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString)
        Else
          pAdicionaNaTempNaoExiste(FieldByName(IIF( (strCfgExi = 'V')Or (strCfgExi = 'PA') ,  'DET_IDEPRO', 'FDO_IDEPRO')).AsString);
      End;
      Next;
    End;

    If intRecNo > 0 Then
      RecNo := intRecNo;

    EnableControls;

    Result := stlTintas.CommaText;
  End;

  FreeAndNil(stlTintas);
  FreeAndNil(cdsNaoExiste);
End;

function TfrmFatFormulacaoItens.fRotinaWMSComProdutoRastreavel(
  qryTinDet: TDataSet): Boolean;
var
  strNomCam : String;
  strCodite : String;
begin
  If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
    strNomCam := 'DET_IDEPRO'
  Else
    strNomCam := 'FDO_IDEPRO';

  strCodIte := qryTinDet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET_CODITE', 'FDO_CODITE')).AsString;

  Result := blnUsaWMSRastreavel And
           (strCfgExi = 'PD') And
           (fTipoTinta(qryTinDet.FieldByName(strNomCam).AsString) = ttImobiliaria) And
           (fItemRastreavel(strCodIte));
end;

function TfrmFatFormulacaoItens.fTinDetBaixado(strNumDoc, strCodEmp, strEspDoc,
  strCodAca, strEmpAca: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Self);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT TRUE   ');
      SQL.Add('   FROM TINDET ');
      SQL.Add('  WHERE DET_NUMDOC = :NUMDOC                      ');
      SQL.Add('    AND DET_CODEMP = :CODEMP                      ');
      SQL.Add('    AND DET_ESPDOC = :ESPDOC                      ');
      SQL.Add('    AND DET_CODACA = :CODACA                      ');
      SQL.Add('    AND DET_EMPACA = :EMPACA                      ');
      SQL.Add('    AND DET_BAIXAD <> ''N''                       ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODACA').AsString := strCodAca;
      ParamByName('EMPACA').AsString := strEmpAca;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fTinDorBaixado(strNumDoc, strCodEmp, strEspDoc,
  strCodAca, strEmpAca: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Self);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT TRUE   ');
      SQL.Add('   FROM TINDOR ');
      SQL.Add('  WHERE FDO_NUMDOC = :NUMDOC');
      SQL.Add('    AND FDO_CODEMP = :CODEMP');
      SQL.Add('    AND FDO_ESPDOC = :ESPDOC');
      SQL.Add('    AND FDO_CODACA = :CODACA');
      SQL.Add('    AND FDO_EMPACA = :EMPACA');
      SQL.Add('    AND FDO_BAIXAD <> "N"   ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODACA').AsString := strCodAca;
      ParamByName('EMPACA').AsString := strEmpAca;
      Open;

      Result := Not IsEmpty;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fTravaGeracaoTransferencia(strNomCam: String): Boolean;
begin
  Result := False;

  If Not (dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString <> VS_strCodEmp) Then
    Exit;

  If Not (fProdForaLojaFGO(dbgItens.DataSource.DataSet) Or fProdForaLojaGER(dbgItens.DataSource.DataSet) Or fProdForaLojaEntregaFutura(dbgItens.DataSource.DataSet)) Then
    Exit;

  If Not (fCfgSis('GTEPFL', varBoolean)) Then
    Exit;

  If Not (Assigned(objTransfere)) Then
    Exit;

  pSetaDadosClienteBaixa(strNomCam);

  If Not (fRetornaPrecoProdAcabadoPorCodigo(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODACA').AsString,
                                            dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_EMPACA').AsString,
                                            dicRetorno)) Then
    Exit;

  If Not (fCfgSis('NFEUSA', varString) = 'S') Then
    Exit;

  If Not (fCfgSis('PNLNFE', varString) = 'S') Then
    Exit;

  If (fEspecieTE <> 'NF') Then
    Exit;

  Result := Not fPainelEstaAberto;
end;

function TfrmFatFormulacaoItens.fValidarDtEntrada(strDtaIni,
  strDtaFim: String): Boolean;
begin
  Result := false;

  If (TryStrToDate(strDtaIni, DataDigEntrada)
   And TryStrToDate(strDtaFim, DataDigEntrada )) Then
    Result := true;
end;

function TfrmFatFormulacaoItens.fVerificaCtrEmAberto: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := True;

  If  (strCfgExi <> 'V') Then
    Exit;

  If True Then
  Begin
    qryGen := fCriaQuery(Self);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT                         ');
      SQL.Add('   SQL_NO_CACHE CND_CNDPAG      ');
      SQL.Add('   , CTR_DTAREC                 ');
      SQL.Add('   , CTR_SEQBAI                 ');
      SQL.Add('   , CTR_DTACAD                 ');
      SQL.Add('   , CTR_DTAVEN                 ');
      SQL.Add(' FROM                           ');
      SQL.Add('   CADREC                       ');
      SQL.Add('   JOIN CADCND                  ');
      SQL.Add('     ON CND_CODIGO = CTR_CODCND ');
      SQL.Add(' WHERE CTR_NUMDUP = :NUMDOC     ');
      SQL.Add('   AND CTR_ESPDOC = :ESPDOC     ');
      SQL.Add('   AND CTR_CODEMP = :CODEMP     ');

      ParamByName('NUMDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_NUMDOC', 'FDO_NUMDOC')).AsString;
      ParamByName('ESPDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_ESPDOC', 'FDO_ESPDOC')).AsString;
      ParamByName('CODEMP').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_CODEMP', 'FDO_CODEMP')).AsString;
      Open;

      If (FieldByName('CND_CNDPAG').AsString = '01000')
        And (FieldByName('CTR_DTAREC').IsNull)
        And (FieldByName('CTR_SEQBAI').AsInteger = 0)
        And (FieldByName('CTR_DTACAD').AsDateTime = FieldByName('CTR_DTAVEN').AsDateTime)

         {*******************************************************************************}
         {* QUANDO A VENDA FOR NA FORMA DE PAGAMENTO '015-A RECEBER' O SISTEMA NÃO DEVE *}
         {* VERIFICAR SE O TITULO FOI PAGO, SOLICITAÇÃO: CASA JARDIM 31/01/2013         *}
         {****************************************************************************RN*}
        And (dbgItens.DataSource.DataSet.FieldByName('DET_CODFPG').AsString <> '015')  Then
      Begin
        fMensagem('','O Contas a Receber deste Documento ainda não foi Baixado!', ['&Ok']);
        Result := False;
      End;

      Close;
    End;

    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fVerificaExisteAjuste(): Boolean;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('  SELECT        ');
    qryGen.SQL.Add('    *           ');
    qryGen.SQL.Add('  FROM          ');

    If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
      qryGen.SQL.Add('  GERAJU        ')
    Else
      qryGen.SQL.Add('  FGOAJU        ');

    qryGen.SQL.Add('  WHERE         ');

    If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      qryGen.SQL.Add('  GER_CODACA = :CODACA AND    ');
      qryGen.SQL.Add('  GER_EMPACA = :EMPACA AND    ');
      qryGen.SQL.Add('  GER_DOCGRI = :NUMDOC AND    ');
      qryGen.SQL.Add('  GER_ESPGRI = :ESPDOC AND    ');
      qryGen.SQL.Add('  GER_CODITE = :CODITE        ');

      qryGen.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_CODACA', 'FDO_CODACA')).AsString;
      qryGen.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_EMPACA', 'FDO_EMPACA')).AsString;
      qryGen.ParamByName('NUMDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_NUMDOC', 'FDO_NUMDOC')).AsString;
      qryGen.ParamByName('ESPDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_ESPDOC', 'FDO_ESPDOC')).AsString;
      qryGen.ParamByName('CODITE').AsString := dbgItens.DataSource.DataSet.FieldByName(IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_CODITE', 'FDO_CODITE')).AsString;
    End
    Else
    Begin
      qryGen.SQL.Add('  FGO_CODACA = :CODACA AND    ');
      qryGen.SQL.Add('  FGO_EMPACA = :EMPACA AND    ');
      qryGen.SQL.Add('  FGO_DOCGRI = :NUMDOC AND    ');
      qryGen.SQL.Add('  FGO_ESPGRI = :ESPDOC AND    ');
      qryGen.SQL.Add('  FGO_CODITE = :CODITE        ');

      qryGen.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_CODACA').AsString;
      qryGen.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_EMPACA').AsString;
      qryGen.ParamByName('NUMDOC').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_NUMDOC').AsString;
      qryGen.ParamByName('ESPDOC').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_ESPDOC').AsString;
      qryGen.ParamByName('CODITE').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_CODITE').AsString;
    End;

    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fVerificaImpressaoEtiquetaEntrega(
  strAutoincrem: String): Boolean;
Var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery();
    qryGen.Close;
    qryGen.SQL.Clear;

    If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
      qryGen.SQL.Add('  SELECT DET_IMPRES FROM TINDET WHERE AUTOINCREM = :AUTINC  ')
    Else
      qryGen.SQL.Add('  SELECT FDO_IMPRES FROM TINDOR WHERE AUTOINCREM = :AUTINC  ');

    qryGen.ParamByName('AUTINC').AsString := strAutoincrem;
    qryGen.Open;

    If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
      Result := (qryGen.FieldByName('DET_IMPRES').AsInteger = 1)
    Else
      Result := (qryGen.FieldByName('FDO_IMPRES').AsInteger = 1);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.GravaTabelaDel(AFormulario, ATabela: String;
  ARegistroDeletado: TDataSet; strCodOpe: String): Boolean;
Const
  LArrayCamposIgnorados: Array of String = ['OPEDEL', 'DTADEL', 'HORDEL', 'MOTDEL'];

  Var
    LCamposTabelaDelecao: String;
    LParametrosTabelaDelecao: String;
    LGravarTabelaDelecao: TUniQuery;
    LCampo: TField;

  procedure GeraListaDeCamposTabelaDelecao;
    Var
      LConsulta: TUniQuery;

      LCampo: TField;
  Begin
    Try
      LConsulta := fCriarQuery('SELECT * FROM DEL_' + ATabela + ' WHERE FALSE');
      LConsulta.Open;

      LCamposTabelaDelecao := '';
      LParametrosTabelaDelecao := '';

      For LCampo In LConsulta.Fields Do
      Begin
        LCamposTabelaDelecao := LCamposTabelaDelecao + LCampo.FieldName + ',';
        LParametrosTabelaDelecao := LParametrosTabelaDelecao + ':' + LCampo.FieldName + ',';
      End;

      LCamposTabelaDelecao := LeftStr(LCamposTabelaDelecao, LCamposTabelaDelecao.Length - 1);
      LParametrosTabelaDelecao := LeftStr(LParametrosTabelaDelecao, LParametrosTabelaDelecao.Length - 1);

    Finally
      FreeAndNil(LConsulta);
    End;
  End;

Begin
  Result := False;

  Try
    GeraListaDeCamposTabelaDelecao;
    LGravarTabelaDelecao := fCriaQuery;

    Try

      If Not ARegistroDeletado.IsEmpty Then
      Begin

        LGravarTabelaDelecao.SQL.Text := 'INSERT INTO DEL_' + ATabela + ' (' + LCamposTabelaDelecao + ') ' +
                               ' VALUES (' + LParametrosTabelaDelecao + ') ';

        For LCampo In ARegistroDeletado.Fields Do
        Begin
          If MatchStr(LCampo.FieldName, LArrayCamposIgnorados) Then
            Continue;

          If Not LGravarTabelaDelecao.SQL.Text.Contains(LCampo.FieldName) Then
            Continue;

          LGravarTabelaDelecao.ParamByName(LCampo.FieldName).Value := LCampo.Value;
        End;

        LGravarTabelaDelecao.ParamByName('OPEDEL').AsString     := strCodOpe;
        LGravarTabelaDelecao.ParamByName('DTADEL').AsDateTime   := VS_Date;
        LGravarTabelaDelecao.ParamByName('HORDEL').AsString     := FormatDateTime('hh:mm:ss', fTime());

        If LGravarTabelaDelecao.SQL.Text.Contains('MOTDEL') Then
          LGravarTabelaDelecao.ParamByName('MOTDEL').AsString     := '';


        LGravarTabelaDelecao.ExecSQL;
        Result:= True;
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(LGravarTabelaDelecao);
  End;
End;

procedure TfrmFatFormulacaoItens.btnBaiTinClick(Sender: TObject);
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;
  TfrmGravando.fExecutarModalA(pBaixarPorTinta, 'Aguarde, Baixando por tintas ...', '');
end;

procedure TfrmFatFormulacaoItens.pBaixarPorTinta;
  Var
    intIndice: Integer;
    sltTintas: TStringList;
    strTintas,
    strSenha: String;
begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  // Valida se existe registro na grid.
  If (dbgItens.DataSource.DataSet.IsEmpty) then
  begin
    fMensagem('','Selecione algum registro para continuar com a operação!', ['&Ok']);
    pFinalizarThreadNotTinDisp(True);
    Exit;
  end;

  If (Not fPermiteProsseguirAcao) Then
  Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If ffrmSenha(strSenha) And (Not fEmptyStr(fRetCodVendedor(strSenha))) And
     fVerificaAcessoSistema('BXVFRM', fRetCodVendedor(strSenha)) Then
  Begin

    pCriarFormularios(TfrmFatFormulSelTintas, frmFatFormulSelTintas);

    With frmFatFormulSelTintas Do
    Begin
      sltTintas := TStringList.Create;
      sltTintas.CommaText := fRetTintas;

      For intIndice := 0 To sltTintas.Count - 1 Do
        chkLisTin.Items.Add(fRetornaNomeTinta(sltTintas[intIndice]));

      If ShowModal = mrOk Then
      Begin
        For intIndice := 0 To chkLisTin.Count - 1 Do
          If chkLisTin.Checked[intIndice] Then
            strTintas := strTintas + sltTintas[intIndice] + ',';

        If fBaixaTintas(strTintas, fRetCodVendedor(strSenha)) Then
          pMensagemOk('Operação realizada com sucesso!');

        pDeletaTemporaria;
        pAtualizaTemporaria;
      End;

      FreeAndNil(sltTintas);
    End;

    FreeAndNil(frmFatFormulSelTintas);
  End;

  pFinalizarThreadNotTinDisp(True);
end;

Function TfrmFatFormulacaoItens.fBaixaTintas(strTintas, strCodOpe: String): Boolean;
  Var
    strMsg: String;
Begin
  With dbgItens.DataSource.DataSet Do
  Try
    DisableControls;
    First;

//    fStartTransaction;

    While Not Eof Do
    Begin

      If Pos(FieldByName(IIF( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString, strTintas) > 0 Then
      Begin

        If Not fBaixaFormulacao(strCodOpe, strMsg) Then
        Begin
          fRollBack;
          Break;
        End;

        fCommit;
      End;

      Next;
    End;

    EnableControls;

    Result := True;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      EnableControls;
      pMensagensErro(E.Message, '[TfrmFatFormulacaoItens.fBaixaTintas]');
    End;
  End;
End;

function TfrmFatFormulacaoItens.fConferenciaPorCodigoBarras: Boolean;
begin
  Try
    pCriarFormularios(TfrmConfCodBarrasFormulacao, frmConfCodBarrasFormulacao);
    frmConfCodBarrasFormulacao.cdsFormul :=
      fCriaClientDatset(dbgItens.DataSource.DataSet, False, Nil, True);
    frmConfCodBarrasFormulacao.strCfgExi := strCfgExi;
    frmConfCodBarrasFormulacao.ShowModal;
    Result := frmConfCodBarrasFormulacao.ModalResult = 1;
  Finally
    FreeAndNil(frmConfCodBarrasFormulacao);
  End;
end;

function TfrmFatFormulacaoItens.fCupomPendenteCancelamento: Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := False;
  If dbgItens.DataSource.DataSet.FieldByName(IfThen(  (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ESPDOC').AsString <> 'IF' Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  COUNT(*) AS QTD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADFIS ');
  qryAux.SQL.Add('  JOIN PAF_CANCELAMENTOS ON CAN_NUMSER = FIS_NUMSER AND ');
  qryAux.SQL.Add('                            CAN_NUMCOO = FIS_NUMCOO ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP ');

  qryAux.ParamByName('NUMDOC').AsString := dbgItens.DataSource.DataSet.FieldByName('DET_NUMDOC').AsString;
  qryAux.ParamByName('ESPDOC').AsString := dbgItens.DataSource.DataSet.FieldByName('DET_ESPDOC').AsString;
  qryAux.ParamByName('CODEMP').AsString := dbgItens.DataSource.DataSet.FieldByName('DET_CODEMP').AsString;
  qryAux.Open;

  If qryAux.FieldByName('QTD').AsInteger > 0 Then
  Begin
    Result := True;
    pMensagemOk('Este cupom já foi cancelado no PDV. A baixa não pode ser realizada.');
  End;

  FreeAndNil(qryAux);
end;

function TfrmFatFormulacaoItens.fDocumentoBaixado(strAutInc, strEspDoc: String): Boolean;
var
  qryGen: TUniQuery;
  strTabela: String;
  strCampo: String;
begin
  Try
    qryGen := fCriaQuery;

    qryGen.Close;
    qryGen.SQL.Clear;

    If (strCfgExi = 'V')  Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      strTabela := 'TINDET';
      strCampo  := 'DET_BAIXAD';
    End
    Else
    Begin
      strTabela := 'TINDOR';
      strCampo  := 'FDO_BAIXAD';
    End;

    qryGen.SQL.Add('  SELECT                     ');
    qryGen.SQL.Add('    TRUE                     ');
    qryGen.SQL.Add('  FROM                       ');
    qryGen.SQL.Add('    ' + strTabela + '        ');
    qryGen.SQL.Add('  WHERE                      ');
    qryGen.SQL.Add('    ' + strCampo + ' <> "N"  ');
    qryGen.SQL.Add('    AND AUTOINCREM = :AUTINC ');

    qryGen.ParamByName('AUTINC').AsString := strAutInc;
    qryGen.Open;

    Result := (Not qryGen.IsEmpty);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatFormulacaoItens.fDocumentoExiste(strAutInc, strEspDoc: String): Boolean;
var
  qryGen: TUniQuery;
  strTabela: String;
begin
  Try
    qryGen := fCriaQuery;

    qryGen.Close;
    qryGen.SQL.Clear;

    If (strCfgExi = 'V')  Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
      strTabela := 'TINGER'
    Else
      strTabela := 'TINGOR';

    qryGen.SQL.Add('  SELECT                  ');
    qryGen.SQL.Add('    TRUE                  ');
    qryGen.SQL.Add('  FROM                    ');
    qryGen.SQL.Add('    ' + strTabela + '     ');
    qryGen.SQL.Add('  WHERE                   ');
    qryGen.SQL.Add('    AUTOINCREM = :AUTINC  ');

    qryGen.ParamByName('AUTINC').AsString := strAutInc;
    qryGen.Open;

    Result := (Not qryGen.IsEmpty);
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatFormulacaoItens.fBaixaDocumentoFuturo(strBaixar: String);
Var
  qryAux : TUniQuery;
  strSQL,
  strNumDoc,
  strCodEmp,
  strCodCli,
  strEspDoc,
  strEmpAca,
  strCodAca: String;
begin
  strNumDoc := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_NUMDOC').AsString;
  strCodEmp := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODEMP').AsString;
  strCodCli := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODCLI').AsString;
  strEspDoc := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ESPDOC').AsString;
  strEmpAca := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_EMPACA').AsString;
  strCodAca := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODACA').AsString;

  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Text := ' SELECT DET_DOCFUT, DET_ESPFUT, DET_EMPFUT '+
                       '   FROM MOVDET '+
                       '  WHERE DET_NUMDOC = :NUMDOC '+
                       '    AND DET_CODEMP = :CODEMP '+
                       '    AND DET_CODCLI = :CODCLI '+
                       '    AND DET_ESPDOC = :ESPDOC '+
                       '    AND DET_EMPACA = :EMPACA '+
                       '    AND DET_CODACA = :CODACA ';


    qryAux.ParambyName('NUMDOC').AsString := strNumDoc;
    qryAux.ParambyName('CODEMP').AsString := strCodEmp;
    qryAux.ParambyName('CODCLI').AsString := strCodCli;
    qryAux.ParambyName('ESPDOC').AsString := strEspDoc;
    qryAux.ParambyName('EMPACA').AsString := strEmpAca;
    qryAux.ParambyName('CODACA').AsString := strCodAca;

    qryAux.Open;

    if not (fEmptyStr(qryAux.FieldbyName('DET_DOCFUT').AsString)) then
    begin
      if (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) then
      begin
        strSQL := 'UPDATE TINDET '+
                  '   SET DET_BAIXAD = "'+ strBaixar +'" '+
                  ' WHERE DET_NUMDOC = :NUMDOC '+
                  '   AND DET_CODEMP = :CODEMP '+
                  '   AND DET_ESPDOC = :ESPDOC '+
                  '   AND DET_CODACA = :CODACA '+
                  '   AND DET_EMPACA = :EMPACA '+
                  '   AND DET_CODCLI = :CODCLI ';
      end
      else
      begin
        strSQL := 'UPDATE TINDOR '+
                  '   SET FDO_BAIXAD = "'+ strBaixar +'" '+
                  ' WHERE FDO_NUMDOC = :NUMDOC '+
                  '   AND FDO_CODEMP = :CODEMP '+
                  '   AND FDO_ESPDOC = :ESPDOC '+
                  '   AND FDO_CODACA = :CODACA '+
                  '   AND FDO_EMPACA = :EMPACA '+
                  '   AND FDO_CODCLI = :CODCLI ';
      end;

      strNumDoc := qryAux.FieldByName('DET_DOCFUT').AsString;
      strEspDoc := qryAux.FieldByName('DET_ESPFUT').AsString;
      strCodEmp := qryAux.FieldByName('DET_EMPFUT').AsString;

      pExecutaSQL(strSQL, ['NUMDOC','CODEMP','CODCLI','ESPDOC','EMPACA','CODACA'],
                          [strNumDoc,
                           strCodEmp,
                           strCodCli,
                           strEspDoc,
                           strEmpAca,
                           strCodAca]);
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

Function TfrmFatFormulacaoItens.fBaixaFormulacao(strCodOpe: String; var strMsg: String; blnImprimiuEtiqEnt : Boolean = true): Boolean;
Var
  strNomCam  : String;
  objOcoCrm  : IAtuOcoCrm;
  intRecNo   : Integer;
  matrizSaldosColorantes : TClassMatrizSaldosColorantes;
  blnLocFor    : Boolean;
  qryForTin    : TUniQuery;
  objLiberacao : ILiberacao;
  objTabela    : TRegistroMsgLiberaTabela;
  objLinha     : TLinhaMsgLibera;
  intIndex     : Integer;
  strCodErrosAuditoria: String;
Begin
  Result := True;
  strMsg := '';

  If (strCfgExi = 'V') Or (strCfgExi = 'PA')  Then
    strNomCam := 'DET_CODEMP'
  Else
    strNomCam := 'FDO_CODEMP';

  If Not IsTintaExistente(dbgItens.DataSource.DataSet.FieldByName(IIF( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET_IDEPRO', 'FDO_IDEPRO')).AsString) Then
  Begin
    fRollBack;
    Result := False;
    Exit;
  End;

  If fFormulacaoJaBaixada(dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString) Then
  Begin
    fRollBack;
    fMensagem('Informação','Essa formulação já foi baixada, Favor Verificar !',['&Ok']);
    Result := False;
    Exit;
  End;

  //aqui dentro desta rotina tem um starttransaction
  If fRotinaWMSComProdutoRastreavel(dbgItens.DataSource.DataSet) Then
  Begin
    If (Not fLoteInformadoCorretamenteParaProdutoRastreavel(dbgItens.DataSource.DataSet)) Then
    Begin
      fRollBack;
      fMensagem('Informação','O Lote não foi informado. Não será possível prosseguir !',['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  If fTravaGeracaoTransferencia(strNomCam) Then
  Begin
    fRollBack;
    fMensagem('ATENÇÃO!', 'Atenção: o PainelNFe da loja (' +VS_strCodEmp+ ') não está aberto. Por favor verifique e realize a baixa novamente.', ['&Ok']);
    Result := False;
    Exit;
  End;

  {Req.: 136087 - Validar saldo de estoque, na baixa de Formulação de Tinta de Máquina, quando Produção Fora de Loja}
  If (fCfgSis('VALEST', varString) <> 'N')                       And
     ((dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString <> VS_strCodEmp) Or fEhAbastecimentoPorDepositoComProducaoForaDaLoja(dbgItens.DataSource.DataSet)) And
     (fProdForaLojaFGO(dbgItens.DataSource.DataSet) Or fProdForaLojaGER(dbgItens.DataSource.DataSet)) Then
  Begin

    qryForTin := fCriaQuery();

    Try

      qryForTin.Close;
      qryForTin.SQL.Clear;

      If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
        qryForTin.SQL.Add(cSQLVN)
      Else
        qryForTin.SQL.Add(cSQLPD);

      qryForTin.ParamByName('NUMDOC').AsString := strNumDoc;
      qryForTin.ParamByName('ESPDOC').AsString := strEspDoc;
      qryForTin.ParamByName('CODEMP').AsString := strCodEmp;
      qryForTin.ParamByName('ITETIN').AsString := strIteTin;
      qryForTin.Open;

      matrizSaldosColorantes := fDesfragmentaTintaSaldosOR(qryForTin, blnLocFor,
                                                           True,  //blnRecalculaSaldos
                                                           False, //blnImpTintaMaqOutroPedido
                                                           True); //blnProducaoForaDeLoja

      If blnLocFor Then
      Begin

        If fVisualizarSaldoTintas(matrizSaldosColorantes) Then
        Begin

          {Trava}
          If fCfgSis('VALEST', varString) = 'T' Then
          Begin

            If (fEmptyStr(fCfgSis('SENBFO'))) Then
            Begin
              fMensagem('','Este produto não possui saldo suficiente para esta baixa!',['&OK']);
              Exit(False);
            End;

            {Única instância na DLL não precisa liberar!}
            objLiberacao := TLiberacaoFactory.fGetLiberacao();

            objLiberacao.objMsgLibera.Clear;
            objLiberacao.objMsgRemota.Clear;

            {Seta para false para não matar os itens da lista, pois eles ainda possuem referência no objMsg e serão liberados por ele.}
            objLiberacao.objMsgLibera.lstRegistros.OwnsObjects := False;

            objLiberacao.objMsgLibera.pAddTexto('Este(s) produto(s) não possui saldo suficiente para esta baixa!');

            objTabela := TRegistroMsgLiberaTabela.Create;

            objLinha := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna('', 'PRODUTO' , 50, alEsquerda , teAutcom);
            objLinha.pAddColuna('', 'SALDO'   , 10, alCentro   , teAutcom);
            objLinha.pAddColuna('', 'QTD.SOL.', 10, alCentro   , teAutcom);
            objTabela.lstLinhas.Add(objLinha);

            For intIndex := 0 To matrizSaldosColorantes.Count -1 Do
            Begin
              If (matrizSaldosColorantes[intIndex].fltSaldoML >= matrizSaldosColorantes[intIndex].fltQtdFormAcu) Then
                Continue;

              objLinha := TLinhaMsgLibera.Create;
              objLinha.enuTipoLinha := tlValor;
              objLinha.pAddColuna('PRODUTO'  , matrizSaldosColorantes[intIndex].strCodIte +'-'+ matrizSaldosColorantes[intIndex].strDesIte , 50, alEsquerda , teAmbos);
              objLinha.pAddColuna('SALDO'    , FormatFloat('#,##0.000', matrizSaldosColorantes[intIndex].fltSaldoML)                 , 10, alDireita  , teAmbos);
              objLinha.pAddColuna('QTD.SOL.' , FormatFloat('#,##0.000', matrizSaldosColorantes[intIndex].fltQtdFormAcu)              , 10, alDireita  , teAmbos);
              objTabela.lstLinhas.Add(objLinha);
            End;

            objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

            objLiberacao.strDirAce  := 'PERBAIFOR';
            objLiberacao.strSenLib  := fCfgSis('SENBFO');
            objLiberacao.strMsgSen  := 'Liberação de produto sem saldo - Baixa Formulação Tinta de Máquina (Produção Fora de Loja)';
            objLiberacao.strCodOpe  := strLoginUsuarioLogado;
            objLiberacao.blnMosMen  := True;
            objLiberacao.strCliente := strCodCli;
            objLiberacao.blnIgnInc  := True;

            If Not objLiberacao.fLibera Then
              Exit(False);

          End;

        End;

      End;

    Finally
      FreeAndNil(qryForTin);
    End;

  End;

  objAuditoriaSaldo.Limpar;

  //StartTransaction tem que ficar aqui por conta da rotina acima
  fStartTransaction;

  Try
    if blnImprimiuEtiqEnt then
    begin
      pExecutaSQL(fRetornaSQLTindetBaixad, ['HORBAI','OPEBAI','AUTINC'],
                                           [Time, strCodOpe, dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString]);
    end;

    if strCfgExi.Equals('PD') And blnUsaRotinaWMS And (fCfgSis('TPLREC', varString) <> 'N') And
       fProdForaLojaFGO(cdsTinMaq) Then
    Begin
      If not fEhAbastecimentoPorDepositoComProducaoForaDaLoja(cdsTinMaq.FieldByName('FDO_NUMDOC').AsString,
                                                              cdsTinMaq.FieldByName('FDO_ESPDOC').AsString,
                                                              cdsTinMaq.FieldByName('FDO_CODEMP').AsString,
                                                              cdsTinMaq.FieldByName('FDO_CODCLI').AsString) Then
      Begin
        pDeletaLotDorGravado(cdsTinMaq.FieldByName('FDO_NUMDOC').AsString,
                             cdsTinMaq.FieldByName('FDO_ESPDOC').AsString,
                             cdsTinMaq.FieldByName('FDO_CODEMP').AsString,
                             cdsTinMaq.FieldByName('FDO_CODCLI').AsString,
                             cdsTinMaq.FieldByName('FDO_CODITE').AsString);
      End;
    End;

    fBaixaDocumentoFuturo('S');

    //Baixa a formulacao do documento de venda;
    If (strCfgExi <> 'V') And (strCfgExi <> 'PA') Then
      pBaixaFormulacaoDocVenda(dbgItens.DataSource.DataSet, strCodOpe);

    If ((dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString <> VS_strCodEmp) Or fEhAbastecimentoPorDepositoComProducaoForaDaLoja(dbgItens.DataSource.DataSet)) And
       (fProdForaLojaFGO(dbgItens.DataSource.DataSet) Or fProdForaLojaGER(dbgItens.DataSource.DataSet) Or fProdForaLojaEntregaFutura(dbgItens.DataSource.DataSet)) Then  //Or fEnt_Cd(qryTinDet)
    Begin
      intRecNo := dbgItens.DataSource.DataSet.RecNo;

      If Not fBaixarColorantes Then
        Result := False;

      {**********************************************}
      {* SE ESTIVER CONFIGURADO, GERA UMA "TE"      *}
      {* AUTOMATICAMENTE PARA A EMPRESA SOLICITANTE *}
      {*******************************************RV*}
      If fCfgSis('GTEPFL', varBoolean) And Result Then
      Begin

        If (Assigned(objTransfere)) Then
        Begin

          If dbgItens.DataSource.DataSet.RecNo <> intRecNo Then
          Begin
            fRollBack;
            Result := False;
            fMensagem('ATENÇÃO', 'Não foi possível a geração da Transferência de Estoque Automaticamente.' + #13#10 +
                                 'A Transferência de Estoque deverá ser feita manualmente.', ['&Ok']);
            Exit;
          End;

          With dbgItens.DataSource.DataSet Do
          Begin

            Try
              pSetaDadosClienteBaixa(strNomCam);

              If fRetornaPrecoProdAcabadoPorCodigo(FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODACA').AsString,
                                                   FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_EMPACA').AsString,
                                                   dicRetorno) Then
              Begin
                objTransfere.pSetaProdutoAcabado(FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_QTDITE').AsFloat);

                If Not objTransfere.fGeraTransferencia(fEspecieTE, True) Then
                  Result := False
                Else
                  strMsg := 'A ' + IIF(fEspecieTE = 'NF', 'Nota Fiscal Nº ', 'Transferência de Estoque Nº ')  + objTransfere.fGetNumeroTE +
                            ' foi gerada automaticamente ' +
                            'para a Empresa: ' + #13 + FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODEMP').AsString +
                            '-' + fRetNomeEmpresaSelec(FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODEMP').AsString);
              End;

            Except
              fRollBack;
              Result := False;
            End;

          End;

        End;

      End;

    End;

    If (Result) And (VS_strHabilitarCRM) Then
    Begin
      With dbgItens.DataSource.DataSet Do
      Begin
        Try
          If (strCfgExi = 'V') Or (strCfgExi = 'PA')  Then
            objOcoCrm := objFuncoesCRM.fAtualizaInformacoesCRM(FieldByName('DET_NUMDOC').AsString,
                                                 FieldByName('DET_ESPDOC').AsString,
                                                 FieldByName('DET_CODEMP').AsString,
                                                 FieldByName('CLI_CODCLI').AsString,
                                                 FieldByName('DET_NUMDOC').AsString,
                                                 FieldByName('DET_ESPDOC').AsString,
                                                 strLoginUsuarioLogado ,
                                                 afcNenhum)
          Else
            objOcoCrm := objFuncoesCRM.fAtualizaInformacoesCRM(FieldByName('FDO_NUMDOC').AsString,
                                                 FieldByName('FDO_ESPDOC').AsString,
                                                 FieldByName('FDO_CODEMP').AsString,
                                                 FieldByName('CLI_CODCLI').AsString,
                                                 FieldByName('FDO_NUMDOC').AsString,
                                                 FieldByName('FDO_ESPDOC').AsString,
                                                 strLoginUsuarioLogado ,
                                                 afcNenhum);

          objOcoCrm.strCodOco := objFuncoesCRM.fRetornaCodigoOcorrencia(objOcoCrm.strNumOrc,objOcoCrm.strEspOrc,objOcoCrm.strCodCli,objOcoCrm.strCodEmp,'');

          If Not fEmptyStr(objOcoCrm.strCodOco) Then
          Begin
            objOcoCrm.strDtaInc := VS_Date;
            objOcoCrm.strHorInc := fRetHoraServidor();
            objOcoCrm.strOpeHis := strLoginUsuarioLogado;
            objOcoCrm.strDtaAge := objOcoCrm.strDtaInc;
            objOcoCrm.strHorAge := objOcoCrm.strHorInc;
            objOcoCrm.strDtaCon := 0;
            objOcoCrm.strHorCon := 0;
            objOcoCrm.strCodSit := tciImpressaoSeparacao.fGetSituacao();
            If (strCfgExi = 'V')Or (strCfgExi = 'PA')  Then
              objOcoCrm.strDescri := 'TINTA FORMULADA - ' + FieldByName('DET_CODITE').AsString + ' - ' + FieldByName('DET_DESCRI').AsString + '<<csq>><<csq>>' +
                                     'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                      DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe)
            Else
              objOcoCrm.strDescri := 'TINTA FORMULADA - ' + FieldByName('FDO_CODITE').AsString + ' - ' + FieldByName('FDO_DESCRI').AsString + '<<csq>><<csq>>' +
                                     'Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                      DateToStr(VS_Date) + ' ' + TimeToStr(fNow) + ' - ' + objOcoCrm.strCodOpe + ' - ' + fRetNomeOperador(objOcoCrm.strCodOpe);

            objOcoCrm.pInsereHistoricoOcorrencia;
            objOcoCrm.pAtualizaOcorrencia;
          End;

        Finally
          objOcoCrm := nil;
        End;
      End;
    End;

    If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
    Begin
      Result := False;
      fRollBack;
      pMostraErrosAuditoria(strCodErrosAuditoria);
    End;
  Finally
    If Assigned(dicRetorno) Then
      FreeAndNil(dicRetorno);
  End;
End;

procedure TfrmFatFormulacaoItens.btnBaixarClick(Sender: TObject);
Var
  strAutoIncrem : String;
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;

  strAutoIncrem := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;

  If (Not fLock_Unlock(strAutoIncrem, True, False)) Then
  Begin
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +  fGetHostLock(strAutoIncrem)  + '!', ['&Ok']);
    Screen.Cursor := crDefault;
    Application.ProcessMessages;
    Exit;
  End;

  TfrmGravando.fExecutarModalA(pBaixar, 'Aguarde, Realizando baixa do(s) documento(s) ...', '');

  fLock_Unlock(strAutoIncrem, False, False);
end;

procedure TfrmFatFormulacaoItens.pBaixar;
  Var
    strCodOpe: String;
    strMsg   : String;

    function fEtiquetaBaixada: Boolean;
      Var
        strNomCam: String;
    begin
      inherited;
      If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
        strNomCam := 'DET_IMPRES'
      Else
        strNomCam := 'FDO_IMPRES';

      Result := (dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsInteger = 1);
    End;

begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  // Valida se existe registro na grid.
  If (dbgItens.DataSource.DataSet.IsEmpty) then
  begin
    fMensagem('','Selecione algum registro para continuar com a operação!', ['&Ok']);
    pFinalizarThreadNotTinDisp(True);
    Exit;
  end;


  If (Not fPermiteProsseguirAcao) Then
  Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If fApenasBaixados Then
  Begin
    pDesmarcaBaixado;
    btnCancelarForm.Click;
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If strCfgExi.Equals('PD') And blnUsaRotinaWMS And (fCfgSis('TPLREC', varString) <> 'N') And
     fProdForaLojaFGO(cdsTinMaq) And
     (Not fItemTemLotDorGravado(cdsTinMaq.FieldByName('FDO_NUMDOC').AsString,
                                cdsTinMaq.FieldByName('FDO_ESPDOC').AsString,
                                cdsTinMaq.FieldByName('FDO_CODEMP').AsString,
                                cdsTinMaq.FieldByName('FDO_CODCLI').AsString,
                                cdsTinMaq.FieldByName('FDO_CODITE').AsString,
                                True)) Then
  Begin
    pMensagemOk('A base ainda não foi separada no coletor, não é possível baixar essa formulação!');
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If (Not fDocumentoExiste(dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString,
                           strEspDoc))
  And  (Pos(strEspDoc, cnstEspTinDet) <= 0) Then
  Begin
    fMensagem('ATENÇÃO','O documento não poderá ser baixado, pois o mesmo foi modificado.' + #13#10 +
              'Os registros serão atualizados. Tente novamente !', ['&Ok']);
    btnAtualizar.Click;
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If (fDocumentoBaixado(dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString,
                        strEspDoc)) Then
  Begin
    fMensagem('ATENÇÃO','O documento selecionado já foi baixado.' + #13#10 +
              'Os registros serão atualizados. Tente novamente !', ['&Ok']);
    btnAtualizar.Click;
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  if fCfgSis('TRCTRF') <> 'N' then
  begin
    If Not fVerificaCtrEmAberto Then Begin
      pFinalizarThreadNotTinDisp(True);
      Exit;
    End;
  end;

  If fCfgSis('PAFECF', varBoolean) Then
  Begin
    If fCupomPendenteCancelamento Then
    Begin
      pFinalizarThreadNotTinDisp(True);
      Exit;
    End;
  End;

  If fExibeMensagemTintaNaoEncontrada Then
  Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If (fMensagem('ATENÇÃO!', 'Deseja baixar esse documento?', ['&Sim', '&Não']) = 2) Then Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If fCfgSis('COBAFO', VarBoolean) Then
  Begin
    If Not fConferenciaPorCodigoBarras Then
    Begin
      pFinalizarThreadNotTinDisp(True);
      Exit;
    End;
  End;

  If ffrmSenha(strSenha) Then
  Begin
    strCodOpe := fRetCodVendedor(strSenha);
    If fEmptyStr(strCodOpe) Then
    Begin
      pMensagemOk('Senha inválida');
      pFinalizarThreadNotTinDisp(True);
      Exit;
    End;
  End Else Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  If (Not fEtiquetaBaixada) And
     (fMensagem('','A etiqueta de entrega ainda não foi impressa. ' +
                   'Deseja baixar a formulação mesmo sem realizar a impressão?', ['','']) = 2) Then
  Begin
    pFinalizarThreadNotTinDisp(True);
    Exit;
  End;

  Try

//    fStartTransaction;

    If fBaixaFormulacao(strCodOpe, strMsg) Then
    Begin
      fCommit;

      pFinalizarThreadNotTinDisp(True);

      If Not fEmptyStr(strMsg) Then
        pMensagemOk(strMsg);
    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[Baixar Formulação]');
    End;
  End;

  pDeletaTemporaria;
  pAtualizaTemporaria;
end;

procedure TfrmFatFormulacaoItens.pAtualizaDados(DataSet: TDataset);
begin
  If (strCfgExi = 'V') Or (strCfgExi = 'PA') Then
  Begin
    strNumDoc := 'DET_NUMDOC';
    strEspDoc := 'DET_ESPDOC';
    strCodEmp := 'DET_CODEMP';
    strCodCli := 'DET_CODCLI';
    strIteTin := 'DET_ITETIN';
  End
  Else
  Begin
    strNumDoc := 'FDO_NUMDOC';
    strEspDoc := 'FDO_ESPDOC';
    strCodEmp := 'FDO_CODEMP';
    strCodCli := 'FDO_CODCLI';
    strIteTin := 'FDO_ITETIN';
  End;

  strNumDoc := DataSet.FieldByName(strNumDoc).AsString;
  strEspDoc := DataSet.FieldByName(strEspDoc).AsString;
  strCodEmp := DataSet.FieldByName(strCodEmp).AsString;
  strCodCli := DataSet.FieldByName(strCodCli).AsString;
  strIteTin := DataSet.FieldByName(strIteTin).AsString;

  edtObsColorista.Text     := cdsTinMaq.FieldByName('OBSCOL').AsString;
  rdgTipoFormula.ItemIndex := cdsTinMaq.FieldByName('TIPFOR').AsInteger;

  If Assigned(DataSet.FindField('FGO_MENFOR')) Then
  Begin
    memMenFor.Texto := DataSet.FieldByName('FGO_MENFOR').AsString;
  End;

  btnImpSep.Visible := strCfgExi.Equals('PD') And
                       blnUsaRotinaWMS And
                       (fCfgSis('TPLREC', varString) <> 'N') And
                       (fTipoTinta(cdsTinMaq.FieldByName('FDO_IDEPRO').AsString) = ttImobiliaria) And
                       fProdForaLojaFGO(cdsTinMaq);

  btnRealizarAjuste.Visible := fCfgSis('AJUFOR') = 'S';
  btnImpAjuste.Visible := fCfgSis('AJUFOR') = 'S';
end;

procedure TfrmFatFormulacaoItens.btnAtualizarClick(Sender: TObject);
begin
  If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    pMensagemOk('O campo data inicial deve ser preenchido!');
    pSetFocus(mskDtaIni);
    Exit;
  End;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
  Begin
    pMensagemOk('O campo data final deve ser preenchido!');
    pSetFocus(mskDtaFin);
    Exit;
  End;

  If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
  Begin
    pMensagemOk('A data inicial deve ser menor que a data final!');
    pSetFocus(mskDtaIni);
    Exit;
  End;

  If fValidarDtEntrada(mskDtaIni.Text, mskDtaFin.Text) Then
    TfrmGravando.fExecutarModalA(pAtualizar, 'Aguarde, Atualizando ...', '');
end;

procedure TfrmFatFormulacaoItens.pAtualizar;
begin
  inherited;
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  pDeletaTemporaria;
  pAtualizaTemporaria;
  dbgItens.DataSource.DataSet.AfterScroll := pAtualizaDados;
  pSetFocus(dbgItens);

  Screen.Cursor := crDefault;
end;

procedure TfrmFatFormulacaoItens.pAtualizaStatusProcessamento(Const strAutInc: String; Const blnProces: Boolean);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add(' UPDATE ');

    If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      qryAux.SQL.Add(' TINDET ');
      qryAux.SQL.Add('SET DET_PROCES = :PROCES ');
    End
    Else
    Begin
      qryAux.SQL.Add(' TINDOR ');
      qryAux.SQL.Add('SET FDO_PROCES = :PROCES ');
    End;

    qryAux.SQL.Add(' WHERE AUTOINCREM = :AUTINC ');

    qryAux.ParamByName('AUTINC').AsString  := strAutInc;
    qryAux.ParamByName('PROCES').AsInteger := IIF(blnProces, 1, 0);
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmFatFormulacaoItens.fBaixarColorantes: Boolean;
var
  qryArqFor: TUniQuery;
  arrFormul: TForMulTinDetArray;
  arrBaixaPigmentos: TBaixaPigmentosArray;
  stlItensTraMl: TStringList;

  strNumLot: String;
  objCadLot: TCadLot;

  intContador: Integer;
  fltQtdProduzir: Double;

  strCodEmb: String;
  strCodFis: String;
  strAutIncMger: String;
  strNumOpr: String;
  strAutIncTmp: String;
  stlDetMls: TStringList;
  strNumDocPr: string;
  arrDuplic : TarrDuplicata;

  recServicos: TDadosServicos;
  blnUsaChapinha: Boolean;
  strCodigoChapinha: String;
  strAutIncML: String;
  strAutIncTM: String;
begin
  Result := True;

  strNumOpr := '';
  fAjustaDataSistema;
  blnUsaChapinha := False;
  strCodigoChapinha := '';

  SetLength(arrBaixaPigmentos, 0);
  stlItensTraMl := TStringList.Create;
  qryArqFor := fCriaQuery(Self);
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  strNumDocPr := '';

  fltQtdProduzir := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_QTDITE').AsFloat;

  If Not fGTinForGeral(dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_IDEPRO').AsString,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ITETIN').AsString,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_TIPPRE').AsString,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET_LINTIN', 'FDO_LINLIN')).AsString,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CATALI').AsString,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_LAZQUA').AsInteger,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_QTDEMB').AsFloat,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_QTDITE').AsFloat,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_DESCRI').AsString,
                       qryArqFor,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_VOLPRO').AsFloat,
                       arrFormul,
                       arrBaixaPigmentos,
                       stlItensTraMl,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODDIL').AsString,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_PORDIL').AsFloat,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_DILCON').AsString,
                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_PORCAT').AsFloat,
                       dbgItens.DataSource.DataSet.FieldByName('FOR_TIPCOR').AsString,
                       dbgItens.DataSource.DataSet.FieldbyName('FOR_TEXBAS').AsString,
                       dbgItens.DataSource.DataSet.FieldbyName('FOR_MODDIL').AsInteger,
                       dbgItens.DataSource.DataSet.FieldbyName('FOR_ITECOB').AsString,
                       dbgItens.DataSource.DataSet.FieldbyName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_EMPPRD').AsString) Then
  Begin
    Raise Exception.CreateFmt('Não foi possível determinar a formulação para a tinta: [%s][%s][%s]',[
      dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString,
      dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_IDEPRO').AsString,
      dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ITETIN').AsString]);
  End;

  If (fTintaBaixaProduto(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_IDEPRO').AsString)) Then
  Begin
    strNumLot := '';

    If blnUsaRotinaWMS Then
    Begin
      objCadLot := TCadLot.Create(nil);
      strNumLot := objCadLot.fRetLotePrincipalTintaMaquina(dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODITE').AsString, VS_strCodEmp);
      FreeAndNil(objCadLot);
    End;

    Result := fAtualizaEstoqueCadIte(dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODITE').AsString,
                                     'S',
                                     fltQtdProduzir,
                                     0.0,
                                     strNumLot,
                                     True,
                                     False);

    If (Result) Then
    Begin

      strNumOpr := fRetSequencial('SEQOPR', VS_strCodEmp, fTamDocCadRec);

      Result := fGravaMovGer(strAutIncMger,
                             strNumOpr,
                             'RO',
                             VS_strCodEmp,
                             '',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODVEN').AsString,
                             '',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODCLI').AsString,
                             'C',
                             VS_Date,
                             fTime(),
                             VS_Date,
                             '01000',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ESTADO').AsString,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREVE1').AsFloat * fltQtdProduzir,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREVE1').AsFloat * fltQtdProduzir,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PRECUS').AsFloat * fltQtdProduzir,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREMED').AsFloat * fltQtdProduzir,
                             '2',
                             0.0,
                             0.0,
                             0.0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             False,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_ESPDOC').AsString,   //'',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString,   //'',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString,   //'',  // Empresa do Faturamento
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DTAENT').AsDateTime, //0,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,   //'',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CONPAG').AsString,   //'',
                             False,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             arrDuplic,
                             '',
                             'N',
                             '5999',
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             '',
                             '',
                             0.0,
                             recServicos,
                             0.0,
                             'V',
                             'N',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             'N',  // Consumidor final
                             'N',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString, //Clifat
                             '',  // Operador da Expedição
                             '',  // Separador da Expedição
                             '',
                             '',
                             'N',     // Entrega Futura
                             False, // Baixa de Entrega Futura
                             0.0,    // Margem de Lucro
                             0.0,                   // Base do retido (caso tivesse) com ipi e frete de entrada
                             0.0,                   // Valor do retido considerando a base acima.
                             'N',                  // Gerar produção fora da loja
                             '',                  // Numero do Registro - Correios ou Transportadora
                             VS_Date,
                             '',
                             'N',
                             '',
                             '',  // ENDEREÇO DE ENTREGA
                             '',  // Conteúdo do CNFNFE
                             '',
                             '',
                             True);

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutIncMger, 'MOVGER');
    End;

    If Result Then
    Begin
      strAutIncTmp := '';

      Result := fGravaMovDet(strAutIncTmp,
                             strAutIncMger,
                             strNumOpr,
                             'RO',
                             VS_strCodEmp,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODITE').AsString,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,
                             '',
                             dbgItens.DataSource.DataSet.FieldByName('ITE_CODMAR').AsString,
                             '',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,
                             VS_Date,
                             fTime(),
                             VS_Date,
                             '01000',
                             'C',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESTADO').AsString,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCRI').AsString,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_REFERE').AsString,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_CODUNI').AsString,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_CODFOR').AsString,
                             fltQtdProduzir,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREVE1').AsFloat,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREVE1').AsFloat,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREVE1').AsFloat,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREVE1').AsFloat * fltQtdProduzir,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREVE1').AsFloat * fltQtdProduzir,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PRECUS').AsFloat * fltQtdProduzir,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PREMED').AsFloat * fltQtdProduzir,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             '',
                             0.0,
                             0.0,
                             0.0,
                             '5999',
                             '000',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             False,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString,   //'',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString,   //'',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString,   //'',  // Empresa do Faturamento
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DTAENT').AsDateTime, //0,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,   //'',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CONPAG').AsString,   //'',
                             0.0,
                             'NOR',
                             'N',
                             '',
                             0.0,
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             'N',
                             '',
                             0.0,
                             '',
                             '',
                             '',
                             '',
                             '',
                             0,
                             '',
                             '',
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString, //CliFat
                             0,
                             0,
                             0.0,
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODACA').AsString, //codaca
                             dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPACA').AsString, //empaca
                             False,
                             False,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             'N',
                             '',
                             0,
                             dbgItens.DataSource.DataSet.FieldByName('ITE_PRECUS').AsFloat * fltQtdProduzir,
                             0.0,
                             0.0,
                             '',
                             strNumLot,
                             'N',
                             0.0,
                             0.0,
                             0.0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             0,
                             '',
                             0,
                             0,
                             0,
                             '',
                             '',
                             '',
                             0,
                             0,
                             0,
                             0);
    End;

  End;

  If Result Then
  Begin

    strCodEmb := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITEEMB').AsString;

    If (Not fEmptyStr(strCodEmb)) Then
    Begin
      strNumLot := '';

      If blnUsaRotinaWMS Then
      Begin
        objCadLot := TCadLot.Create(nil);
        strNumLot := objCadLot.fRetLotePrincipalTintaMaquina(strCodEmb, VS_strCodEmp);
        FreeAndNil(objCadLot);
      End;

      Result := fAtualizaEstoqueCadIte(strCodEmb,
                                       'S',
                                       fltQtdProduzir,
                                       0.0,
                                       strNumLot,
                                       True,
                                       False);

      If (Result) And (fEmptyStr(strNumOpr)) Then
      Begin

        strNumOpr := fRetSequencial('SEQOPR', VS_strCodEmp, fTamDocCadRec);

        Result := fGravaMovGer(strAutIncMger,
                               strNumOpr,
                               'RO',
                               VS_strCodEmp,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,
                               'C',
                               VS_Date,
                               fTime(),
                               VS_Date,
                               '01000',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESTADO').AsString,
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '2',
                               0.0,
                               0.0,
                               0.0,
                               0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               False,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString,   //'',  // Empresa do Faturamento
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DTAENT').AsDateTime, //0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CONPAG').AsString,   //'',
                               False,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               arrDuplic,
                               '',
                               'N',
                               '5999',
                               '',
                               '',
                               '',
                               0.0,
                               '',
                               '',
                               '',
                               0.0,
                               recServicos,
                               0.0,
                               'V',
                               'N',
                               '',
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               'N',  // Consumidor final
                               'N',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString, //CliFat
                               '',  // Operador da Expedição
                               '',  // Separador da Expedição
                               '',
                               '',
                               'N',     // Entrega Futura
                               False, // Baixa de Entrega Futura
                               0.0,    // Margem de Lucro
                               0.0,                   // Base do retido (caso tivesse) com ipi e frete de entrada
                               0.0,                   // Valor do retido considerando a base acima.
                               'N',                   // Gerar produção fora da loja
                               '',                    // Numero do Registro - Correios ou Transportadora
                               VS_Date,
                               '',
                               'N',
                               '',
                               '',   // ENDERECO DE ENTREGA
                               '',  // Conteúdo do CNFNFE
                               '',
                               '',
                               True);

        If Result Then
          objAuditoriaSaldo.Adicionar(strAutIncMger, 'MOVGER');
      End;

      If Result Then
      Begin
        strAutIncTmp := '';

        Result := fGravaMovDet(strAutIncTmp,
                               strAutIncMger,
                               strNumOpr,
                               'RO',
                               VS_strCodEmp,
                               strCodEmb,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODMAR').AsString,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,
                               VS_Date,
                               fTime(),
                               VS_Date,
                               '01000',
                               'C',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESTADO').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCRI').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_REFERE').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODUNI').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODFOR').AsString,
                               fltQtdProduzir,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '',
                               '',
                               0.0,
                               0.0,
                               0.0,
                               '5999',
                               '000',
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               False,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString,   //'',  // Empresa do Faturamento
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DTAENT').AsDateTime, //0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CONPAG').AsString,   //'',
                               0.0,
                               'NOR',
                               'N',
                               '',
                               0.0,
                               'N',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               'S',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               'N',
                               '',
                               0.0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               '',
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,  //CliFat
                               0,
                               0,
                               0.0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODACA').AsString, //codaca
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPACA').AsString, //empaca
                               False,
                               False,
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               'N',
                               '',
                               0,
                               0,
                               0.0,
                               0.0,
                               '',
                               strNumLot,
                               'N',
                               0.0,
                               0.0,
                               0.0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               '',
                               0,
                               0,
                               0,
                               '',
                               '',
                               '',
                               0,
                               0,
                               0,
                               0);

      End;


    End;
  End;

  {*********************************************************}
  {** VERIFICA SE UTILIZA CHAPINHA NA FÓRMULA ESPECIFICA  **}
  {******************************************************RG*}

  If Result Then
  Begin
    If Assigned(fUsaChapinhaTinta) Then
      blnUsaChapinha := fUsaChapinhaTinta(dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO').AsString, strIteTin);

    If blnUsaChapinha Then
    Begin
      If Assigned(fRetornaCodigoChapinha) Then
        strCodigoChapinha := fRetornaCodigoChapinha(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO').AsString);

      If fEmptyStr(strCodigoChapinha) Then
      Begin
        fMensagem('ATENÇÃO!', 'A fórmula ' + dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCRI').AsString + ', está sem o produto chapinha configurado.'
         + #13#10 + 'Favor entrar em contato com a Citel.', ['&OK']);
        Exit(False);
      End;
    End;

    If (blnUsaChapinha) And Not fEmptyStr(strCodigoChapinha) Then
    Begin
      strCodEmb := strCodigoChapinha;

      strNumLot := '';

      If blnUsaRotinaWMS Then
      Begin
        objCadLot := TCadLot.Create(nil);
        strNumLot := objCadLot.fRetLotePrincipalTintaMaquina(strCodEmb, VS_strCodEmp);
        FreeAndNil(objCadLot);
      End;

      Result := fAtualizaEstoqueCadIte(strCodEmb,
                                       'S',
                                       fltQtdProduzir,
                                       0.0,
                                       strNumLot,
                                       True,
                                       False);

      If Result Then
      Begin
        strAutIncTmp := '';
        Result := fGravaMovDet(strAutIncTmp,
                               strAutIncMger,
                               strNumOpr,
                               'RO',
                               VS_strCodEmp,
                               strCodEmb,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODMAR').AsString,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,
                               VS_Date,
                               fTime(),
                               VS_Date,
                               '01000',
                               'C',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESTADO').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCRI').AsString, //dtsForms.FieldByName('ITE_DESITE').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_REFERE').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODUNI').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODFOR').AsString,
                               fltQtdProduzir,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '',
                               '',
                               0.0,
                               0.0,
                               0.0,
                               '5999',
                               '000',
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               False,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString,   //'',  // Empresa do Faturamento
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DTAENT').AsDateTime, //0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,   //'',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CONPAG').AsString,   //'',
                               0.0,
                               'NOR',
                               'N',
                               '',
                               0.0,
                               'N',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               'S',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               'N',
                               '',
                               0.0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               '',
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,  //CliFat
                               0,
                               0,
                               0.0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODACA').AsString, //codaca
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPACA').AsString, //empaca
                               False,
                               False,
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               '',
                               0.0,
                               '',
                               0.0,
                               0.0,
                               0,
                               'N',
                               '',
                               0,
                               0,
                               0.0,
                               0.0,
                               '',
                               strNumLot,
                               'N',
                               0.0,
                               0.0,
                               0.0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               '',
                               0,
                               0,
                               0,
                               '',
                               '',
                               '',
                               0,
                               0,
                               0,
                               0);

      End;
    End;
  End;

  If Result Then
  begin

    strNumDocPr := fRetSequencialProducaoTintaMaquina_PR(VS_strCodEmp);
    Result := fGravaMovGer(strAutIncMger,                                    // Auto Incremento (Retorno)
                           strNumDocPr,                                    // Numero Documento
                           'PR',                                           // Espécie
                           VS_strCodEmp,                                   // Empresa
                           '',                                      // Transportadora
                           dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,                                      // Vendedor
                           '',     // Fornecedor
                           dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,     // Cliente
                           'C',          // Tipo ((C)liente / (F)ornecedor)
                           VS_Date,                                        // Data da Entrada
                           fTime(),                                        // Hora da Entrada
                           VS_Date,                                        // Data do Documento
                           '01000',                                      // Condição de Pagamento
                           dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESTADO').AsString,                                      // Estado do Cliente / Fornecedor
                           '',       // Nome do Consumidor
                           '',                                      // Endereço do Consumidor
                           '',                                      // Bairro do Consumidor
                           '',                                      // Cep do Consumidor
                           '',                                      // Cidade do Consumidor
                           '',                                      // Estado do Consumidor
                           '',                                      // Telefone do Consumidor
                           0,
                           '',                            // CNPJ / CGC
                           '',                                      // CNPJ / CGC do consumidor
                           '',                                      // Inscrição estadual do Consumidor
                           '',                                      // Rg do Consumidor
                           0.0,                                            // Base Simples Paulista
                           0.0,                                            // Base de IPI
                           0.0,                                            // Aliquota de IPI
                           0.0,                                            // Total de IPI
                           0.0,                                            // Base de ICMS
                           0.0,                                            // Aliquota de ICMS
                           0.0,                                            // Total de ICMS
                           0.0,                                            // Valor de Substituição
                           0.0,                                            // Aliquota de Substituição
                           0.0,                                            // Base de Substituição
                           0.0,                                            // Base de Substituição Simulada
                           0.0,                                            // Desconto Especial
                           0.0,                                            // Valor Contábil
                           0.0,                                            // Total dos Itens
                           0.0,                                            // Total de Custo
                           0.0,                                            // Total Médio
                           '2',                                      // Tipo de Frete
                           0.0,                                            // Valor do Frete
                           0.0,                                            // Peso Bruto
                           0.0,                                            // Peso Liquido
                           0.0,                                            // Volume
                           '',                                      // Especie
                           '',                                      // Marca
                           '',                                      // Mensagem 1
                           '',                                      // Mensagem 2
                           '',                                      // Mensagem 3
                           '',                                      // Mensagem 4
                           '',                                      // Mensagem 5
                           False,                                          // Indica se Faturado ou nao
                           '',                                             // Tipo de Faturamento
                           '',                                             // Numero de Faturamento
                           '',                                             // Empresa do Faturamento
                           0,                                              // Data de Faturamento
                           '',                                             // Vendedor do Faturamento
                           '',                                             // Condição de Pagamento do Faturamento
                           False,                                          // Devolução Especial
                           0.0,                                            // Valor do Faturamento
                           0.0,                                            // Valor Parcela 01
                           0.0,                                            // Valor Parcela 02
                           0.0,                                            // Valor Parcela 03
                           0.0,                                            // Valor Parcela 04
                           0.0,                                            // Valor Parcela 05
                           0.0,                                            // Valor Parcela 06
                           0.0,                                            // Valor Parcela 07
                           0.0,                                            // Valor Parcela 08
                           0.0,                                            // Valor Parcela 09
                           0.0,                                            // Valor Parcela 10
                           0.0,                                            // Valor Parcela 11
                           0.0,
                           arrDuplic,                                            // Valor Parcela 12
                           '',                                      // Série
                           'N',          // Nota Especial
                           '1999', // Classificação Fiscal 1
                           '',                                             // Classificação Fiscal 2
                           '',                                             // Classificação Fiscal 3
                           '',                                             // Natureza da Operação
                           0.0,                                            // Percentual de Desconto
                           '',                                      // Código do Digitador
                           '',                                      // Código da Condicao
                           '',                                      // Código da Forma de Pagamento
                           0,                                       // Fator para meia nota
                           recServicos,
                           0,
                           'V',                                            // Origem do Documento (V)enda (D)evolução
                           'N',                                      // Usa controle de entrega
                           '',                                      // Representante
                           0.0,                                            // Aliquota do IRPF (SERVIÇO)
                           0.0,                                            // Valor do IRPF (SERVIÇO + PRODUTO)
                           0.0,                                            // Aliquota do Pis (SERVIÇO)
                           0.0,                                            // Valor do Pis (SERVIÇO + PRODUTO)
                           0.0,                                            // Aliquota do Cofins (SERVIÇO)
                           0.0,                                            // Valor do Cofins (SERVIÇO + PRODUTO)
                           0.0,                                            // Aliquota do CSLL (SERVIÇO)
                           0.0,                                            // Valor do CSLL (SERVIÇO + PRODUTO)
                           0.0,                                            // Valor de IRPF que foi retido
                           0.0,                                            // Valor de PIS que foi retido
                           0.0,                                            // Valor de COFINS que foi retido
                           0.0,                                            // Valor de CSLL que foi retido
                           '',                                             // Notas de Documentos Acumulados
                           0.0,                                            // Aliquota do IRPF (PRODUTOS)
                           0.0,                                            // Aliquota do PIS (PRODUTOS)
                           0.0,                                            // Aliquota do COFINS (PRODUTOS)
                           0.0,                                            // Aliquota do CSLL (PRODUTOS)
                           0.0,                                            // Valor de SERVIÇO que foi retido
                           '',                                             // Notas de documentos acumulados (SERVIÇO)
                           0.0,                                            // Valor da Seguidade Social
                           0.0,                                            // Percentual da Seguridade Social
                           0.0,                                            // Valor do IRPF Retido (Produto)
                           0.0,                                            // Valor do IRPF Devido (Produto)
                           0.0,                                            // Valor do IRPF Retido (Serviço)
                           0.0,                                            // Valor do IRPF Devido (Serviço)
                           0.0,                                            // Valor do PIS Retido (Produto)
                           0.0,                                            // Valor do PIS Devido (Produto)
                           0.0,                                            // Valor do PIS Retido (Serviço)
                           0.0,                                            // Valor do PIS Devido (Serviço)
                           0.0,                                            // Valor do COFINS Retido (Produto)
                           0.0,                                            // Valor do COFINS Devido (Produto)
                           0.0,                                            // Valor do COFINS Retido (Serviço)
                           0.0,                                            // Valor do COFINS Devido (Serviço)
                           0.0,                                            // Valor do CSLL Retido (Produto)
                           0.0,                                            // Valor do CSLL Devido (Produto)
                           0.0,                                            // Valor do CSLL Retido (Serviço)
                           0.0,                                            // Valor do CSLL Devido (Serviço)
                           '',                                             // Ordem de Produção
                           0.0,                                            // Base Orgão Público
                           0.0,                                            // ICMS Orgão Público
                           0,                                      // Número do Conhecimento de Frete
                           'N',                                      // Consumidor final
                           'N',                                      // Entrega no faturamento
                           '',                                      // Cliente de Faturamento
                           '',                                      // Operador da Expedição
                           '',                                      // Separador da Expedição
                           '',                                      // Tabela de Preços utilizada
                           '',
                           'N',                                            // Entrega Futura
                           False,                                   // Baixa de Entrega Futura
                           0,                                      // Margem de Lucro
                           0.0,                                            // Base do retido (caso tivesse) com ipi e frete de entrada
                           0.0,                                            // Valor do retido considerando a base acima.
                           'N',                                      // Gerar produção fora da loja
                           '',                                      // Numero do Registro - Correios ou Transportadora
                           VS_Date,                                        // Data de Entrega no Romaneio
                           '',                                             // Classificação Fiscal 4
                           'N',                       // Auto Serviço
                           '',                                             // Codigo do Evento
                           '',                                      // AUTINC ENDEREÇO DE ENTREGA
                           '',                                             // Conteúdo do CNFNFE
                           '',                                      // Motivo da Devolução
                           '',
                           False,                                           // Imprime Duplicatas na NF-e
                           0,
                           0,
                           '');                                     // E-mail para NF-e

    If Result Then
      objAuditoriaSaldo.Adicionar(strAutIncMger, 'MOVGER');

    if Result then
    Begin
        If dbgItens.DataSource.DataSet.FindField(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODFIS') <> Nil Then
          strCodFis := dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODFIS').AsString
        Else
          strCodFis := '000';

        strAutIncTmp := '';

        Result := fGravaMovDet(strAutIncTmp,
                               strAutIncMger,
                               strNumDocPr,
                               'PR',
                               VS_strCodEmp,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODITE').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODMAR').AsString,
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,
                               VS_Date,
                               fTime(),
                               VS_Date,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CONPAG').AsString,
                               'C',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESTADO').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_DESITE').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_REFERE').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODUNI').AsString,
                               dbgItens.DataSource.DataSet.FieldByName('ITE_CODFOR').AsString,
                               fltQtdProduzir,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               '',
                               '',
                               0.0,
                               0.0,
                               0.0,
                               '1999',
                               strCodFis,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               0.0,
                               False,
                               '',
                               '',
                               '',  // Empresa do Faturamento
                               0,
                               '',
                               '',
                               0.0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_INCPIS').AsString,
                               '',
                               0.0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NOTESP').AsString,
                               '',
                               '',
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITECHA').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITETIN').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCOR').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_TIPEMB').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDEMB').AsFloat,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_PREEMB').AsFloat,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_TIPPRE').AsString,
                               0.0,
                               0.0,
                               0,
                               'N',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODDIG').AsString,
                               '',
                               '',
                               '',
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_LAZQUA').AsInteger,
                               'N',
                               '',
                               0.0,
                               '',
                               '',
                               '',
                               '',
                               '',
                               0,
                               '',
                               '',
                               '',
                               0,
                               0,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_VOLPRO').AsFloat,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODACA').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPACA').AsString,
                               False,
                               True,
                               '',
                               '',
                               '',
                               '',
                               '',
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET_LINTIN', 'FDO_LINLIN')).AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CATALI').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODDIL').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_PORDIL').AsFloat,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DILCON').AsString,
                               dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_PORCAT').AsFloat,
                               0.0,
                               0,
                               'N',
                               '',
                               0,
                               0,
                               0.0,
                               0.0,
                               '',
                               '',
                               'N',
                               0.0,
                               0.0,
                               0.0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               0,
                               '',
                               0,
                               0,
                               0,
                               '',
                               '',
                               '',
                               0,
                               0,
                               0,
                               0);
    End;
  end;

  If Result Then
  Begin
    Result := TProdAcabado.fAtualizaEstoque(dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODACA').AsString,
                                            dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPACA').AsString,
                                            VS_strCodEmp,
                                            'E',
                                            fltQtdProduzir);
  End;

  If Result Then
  Begin
    (**********************************************************************************************************)
    {* SOMENTE SERÁ BAIXA DE ESTOQUE DE TINTA DE MAQUINA QUANDO A CONFIGURACAO DA TINTA "USAFOR" ESTIVER = S. *}
    {* QUANDO A CONFIGURACAO "USAFOR" ESTIVER = N ENTAO NAO BAIXA A FORMULACAO.                               *}
    (*******************************************************************************************************AC*)
    If (fTintaGeraFormulacao(dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO').AsString))
    Or (fCfgSis('MODFOR') = '1') Then
    Begin

      For intContador := 0 To Length(arrBaixaPigmentos) -1 Do
      Begin
        strNumLot := '';

        If blnUsaRotinaWMS Then
        Begin
          objCadLot := TCadLot.Create(nil);
          strNumLot := objCadLot.fRetLotePrincipalTintaMaquina(arrBaixaPigmentos[intContador].strCodIte, VS_strCodEmp);
          FreeAndNil(objCadLot);
        End;

        If (Not fAtualizaEstoqueML(arrBaixaPigmentos[intContador].strCodIte,
                                   arrBaixaPigmentos[intContador].fltQtdBaixa*fltQtdProduzir,
                                   strNumLot)) Then
        Begin
          Result := False;
          Break;
        End;

      End;

      stlDetMls := Nil;

      If Not fBaixarEstoqueColorantes(fGravaMovGer,
                                      fGravaMovDet,
                                      arrBaixaPigmentos,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO').AsString,
                                      fltQtdProduzir,
                                      '5999',
                                      '',
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODVEN').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CONPAG').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESTADO').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_NOMCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_ENDCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_BAICON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_CEPCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_CIDCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_TELCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_CGCCPF').AsInteger,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_CGCCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_IESCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'GER', 'FGO') + '_R_GCON').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString,
                                      False,
                                      False,
                                      '',
                                      '',
                                      '',
                                      0.0,
                                      '',
                                      '',
                                      '',
                                      0.0,
                                      '',
                                      '',
                                      '',
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString,  //clifat
                                      '',
                                      '',
                                      '',
                                      False,
                                      0.0,
                                      VS_strCodEmp,
                                      '',
                                      '',
                                      stlDetMls,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString,
                                      strAutIncML,
                                      strAutIncTM,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODACA').AsString,
                                      dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPACA').AsString) Then
      Begin
        Result := False;
      End;

      If Result Then
      Begin
        objAuditoriaSaldo.Adicionar(strAutIncML, 'MOVGER');
        objAuditoriaSaldo.Adicionar(strAutIncTM, 'MOVGER');
      End;

      pAtualizaMovDetMls(stlDetMls,
        dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODACA').AsString,
        dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPACA').AsString,
        dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString);

      If Assigned(stlDetMls) Then
      Begin
        stlDetMls.Clear;
        FreeAndNil(stlDetMls);
      End;

    End;
  End;

  FreeAndNil(stlItensTraMl);
  FreeAndNil(qryArqFor);
end;

{*****************************************}
{* IMPRESSÃO EM MATRICIAL                *}
{**************************************AF*}
function TfrmFatFormulacaoItens.fImpEtiquetasMatricial: Boolean;
begin
  intColAtu := 1;

  TCfgRel.pCarregaConfImpr(qryCfgRel, Self.Name);
  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If Not fVerificaImpressora(strNomImp) Then
  Begin
    fMensagem('','Impressora configurada incorretamente!',['&OK']);
    Result := False;
    Exit;
  End;

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(qryImpressao, 'TINDET');

  With qryImpressao Do
  Begin
    First;
    Application.ProcessMessages;
    Result := fImpRegistro;
    Application.ProcessMessages;
    Next;

    {**********************************************************************************}
    {* É NECESSARIO CHAMAR ESSA PROCEDURE NESSE PONTO PARA QUE SAIA A ÚLTIMA ETIQUETA *}
    {*******************************************************************************MV*}
    pImpArrLinhasEti;

    qryImpressao.Close;
    qryImpressao.Open;
  End;
end;

function TfrmFatFormulacaoItens.fImpRegistro: Boolean;
  Var
    intQtdCol: Integer;
    intQtdColOri: Integer;
    intContador: Integer;
    intLinhaAtu: Integer;
    intLinha : Integer;
    intTamLinAnt: Integer;
    intNumCol: Integer;
    intQtdEti: Integer;
    intLinhaEti: Integer;
    strNumCol: String;
    strLinha : String;
    strSQL: String;
    qryCnfEti: TUniQuery;
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
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND ';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP     ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  Try
    qryCnfEti := fCriaQuery(Self);
    With qryCnfEti Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('TIPETI').AsString := 'TIN';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      intQtdEti := IIF(IsEmpty, 0, 1);

      Result := intQtdEti > 0;

      Try
        While (intQtdEti > 0) Do
        Begin
          First;

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

            cpuCampos := TCamposUso.Create;
            cpuCampos.AdicionaCampos(qryImpressao, 'TINDET');

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
          Dec(intQtdEti, (intQtdColOri+1) - intColAtu);

          Inc(intColAtu, intQtdCol);
          If intColAtu >= intQtdColOri+1 Then
          Begin
            pImpArrLinhasEti;
            intColAtu := 1;
          End;

        End;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[TfrmFatFormulacaoItens.fImpRegistro]');
        End;
      End;

    End;
  Finally
    FreeAndNil(qryCnfEti);
  End;
end;

procedure TfrmFatFormulacaoItens.pImpArrLinhasEti;
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

procedure TfrmFatFormulacaoItens.FormActivate(Sender: TObject);
begin
  inherited;
  //btnAtualizar.Click;
  pSetFocus(mskDtaIni);
  Screen.Cursor := crDefault;
end;

procedure TfrmFatFormulacaoItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If fTabelaExiste('TMP_FORMULACAO_OPRFLJ') Then
    fDropTable('TMP_FORMULACAO_OPRFLJ');

  If fTabelaExiste('TMP_FORMULACAO_CD') Then
    fDropTable('TMP_FORMULACAO_CD');

  If fTabelaExiste('TMP_FORMULACAO_LOJA') Then
    fDropTable('TMP_FORMULACAO_LOJA');

  If fTabelaExiste('TMP_FORMULACAO_ABADEP') Then
    fDropTable('TMP_FORMULACAO_ABADEP');

  If Assigned(cdsTinMaq) Then
    FreeAndNil(cdsTinMaq);

  If Assigned(dtsFormul) Then
    FreeAndNil(dtsFormul);

  If Assigned(qryFormul) Then
    FreeAndNil(qryFormul);

  If Assigned(qryImpressao) Then
    FreeAndNil(qryImpressao);

  If (Assigned(thrNotificacao)) Then
  Begin
    pHabilitarNotificacoes(False);
    Sleep(500);

    If (thrNotificacao.Started) Then
    Begin
      thrNotificacao.Terminate();
    End;

    thrNotificacao.Free();
  End;
end;

procedure TfrmFatFormulacaoItens.FormCreate(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;
  inherited;
  qryImpressao := fCriaQuery(Self);

  FDiasData := fCfgSis('ULDFOR', varInteger);
  objImpOrdPro  := TFatOrdProTintaMaquina.Create;
  objLotePedidoWMS := TFatDefineLotesPedidoWMSWrapper.Create;
  objTransfere := TTransferencias.Create;
  objFuncoesCRM := TFuncoesCRM.Create;

  qryFormul := fCriaQuery(Self);
  dtsFormul := fCriaDataSource(qryFormul);

  pInicializarNoticacoes();

  blnUsaRotinaWMS := fUsaRotinaWMS;
  blnUsaWMSRastreavel := blnUsaRotinaWMS And (fCfgSis('TMWMSR') = 'S');

  mskDtaIni.Text := DateToStr(VS_Date - FDiasData);
  mskDtaFin.Text := DateToStr(VS_Date);

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;

  FFiltroCodIte := '';
  FFiltroCodCli := '';
  FFiltroNumDoc := '';
  FFiltroDocFat := '';
  FFiltroDtaCad := '';
end;

procedure TfrmFatFormulacaoItens.btnAltTipTinClick(Sender: TObject);
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;
  TfrmGravando.fExecutarModalA(pAltTipTinta, 'Aguarde, Mudando tipo de tinta ...', '');
end;

procedure TfrmFatFormulacaoItens.pAltTipTinta;
begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  pMudarTipoTinta;

  pFinalizarThreadNotTinDisp(True);
end;

procedure TfrmFatFormulacaoItens.pMudarTipoTinta;
begin
  rdgTipTin.ItemIndex := (rdgTipTin.ItemIndex + 1) mod (rdgTipTin.Items.Count);
end;

Procedure TfrmFatFormulacaoItens.pRealizaExclusao(strCodOpe: String);
Var
  strTblGer: String;
  strTblDet: String;
  strPreDet: String;
  qryFormul: TUniQuery;
begin
  strTblGer := IIF((strCfgExi = 'V')Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'TINGER', 'TINGOR');
  strTblDet := IIF((strCfgExi = 'V')Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'TINDET', 'TINDOR');
  strPreDet := IIF((strCfgExi = 'V')Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'DET', 'FDO');

  qryFormul := fCriaQuery(Self);
  qryFormul.Close;
  qryFormul.SQL.Clear;
  qryFormul.SQL.Add('SELECT * FROM ' + strTblDet + ' WHERE ' + strPreDet + '_SEQGER = :SEQGER');
  qryFormul.ParamByName('SEQGER').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString;
  qryFormul.Open;


  If qryFormul.RecordCount > 1 Then
    pRealizarExclusaoFormulaTindorPorParte(strTblGer, strTblDet, strPreDet, strCodOpe)
  Else If qryFormul.RecordCount = 1 Then
    pRealizarExclusaoFormulaTindorCompleta(strTblGer, strTblDet, strPreDet, strCodOpe);
end;

Procedure TfrmFatFormulacaoItens.pRealizarExclusaoFormulaTindorCompleta(strTblGer, strTblDet, strPreDet, strCodOpe: String);
Var
  LQryFormul: TUniQuery;
  intRecNo: Integer;
begin
  LQryFormul := fCriaQuery(Self);
  LQryFormul.SQL.Add('SELECT * FROM ' + strTblGer + ' WHERE AUTOINCREM = :AUTOINCREM');
  LQryFormul.ParamByName('AUTOINCREM').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString;
  LQryFormul.Open;
  fVerificaIntegridade(Self.Name, strTblGer, LQryFormul, False, True);
  GravaTabelaDel(Self.Name, strTblGer, LQryFormul, strCodOpe);


  LQryFormul.Close;
  LQryFormul.SQL.Clear;
  LQryFormul.SQL.Add('SELECT * FROM ' + strTblDet + ' WHERE ' + strPreDet + '_SEQGER = :SEQGER');
  LQryFormul.ParamByName('SEQGER').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString;
  LQryFormul.Open;
  fVerificaIntegridade(Self.Name, strTblDet, LQryFormul, False, True);
  GravaTabelaDel(Self.Name, strTblDet, LQryFormul, strCodOpe);

  LQryFormul.Close;
  LQryFormul.SQL.Clear;
  LQryFormul.SQL.Add('DELETE FROM '+ strTblGer +' WHERE AUTOINCREM = :AUTOINCREM');
  LQryFormul.ParamByName('AUTOINCREM').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString;
  LQryFormul.ExecSQL;

  FreeAndNil(LQryFormul);

  intRecNo := dbgItens.DataSource.DataSet.RecNo;
  If intRecNo = dbgItens.DataSource.DataSet.RecordCount Then
    Dec(intRecNo);

  btnAtualizar.Click;

  Try
    dbgItens.DataSource.DataSet.RecNo := intRecNo;
  Except
    //
  End;
end;

Procedure TfrmFatFormulacaoItens.pRealizarExclusaoFormulaTindorPorParte(strTblGer, strTblDet, strPreDet, strCodOpe: String);
Var
  LQryFormul: TUniQuery;
  LStrSQL: String;
  intRecNo: Integer;
begin
  LQryFormul := fCriaQuery(Self);

  LStrSQL := '';
  LStrSQL := LStrSQL + ' SELECT * FROM ' + strTblDet + ' WHERE ';
  LStrSQL := LStrSQL +   strPreDet + '_SEQGER = :SEQGER AND    ';
  LStrSQL := LStrSQL +   strPreDet + '_CODACA = :CODACA AND    ';
  LStrSQL := LStrSQL +   strPreDet + '_EMPACA = :EMPACA;       ';

  LQryFormul.Close;
  LQryFormul.SQL.Clear;
  LQryFormul.SQL.Add(LStrSQL);
  LQryFormul.ParamByName('SEQGER').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString;
  LQryFormul.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName(strPreDet +'_CODACA').AsString;
  LQryFormul.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName(strPreDet +'_EMPACA').AsString;
  LQryFormul.Open;
  fVerificaIntegridade(Self.Name, strTblDet, LQryFormul, False, True);
  GravaTabelaDel(Self.Name, strTblDet, LQryFormul, strCodOpe);

  LStrSQL := '';
  LStrSQL := LStrSQL + 'DELETE FROM '+ strTblDet +' WHERE      ';
  LStrSQL := LStrSQL +   strPreDet + '_SEQGER = :SEQGER AND    ';
  LStrSQL := LStrSQL +   strPreDet + '_CODACA = :CODACA AND    ';
  LStrSQL := LStrSQL +   strPreDet + '_EMPACA = :EMPACA;       ';

  LQryFormul.Close;
  LQryFormul.SQL.Clear;
  LQryFormul.SQL.Add(LStrSQL);
  LQryFormul.ParamByName('SEQGER').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTINC').AsString;
  LQryFormul.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName(strPreDet +'_CODACA').AsString;
  LQryFormul.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName(strPreDet +'_EMPACA').AsString;
  LQryFormul.ExecSQL;

  FreeAndNil(LQryFormul);

  intRecNo := dbgItens.DataSource.DataSet.RecNo;
  If intRecNo = dbgItens.DataSource.DataSet.RecordCount Then
    Dec(intRecNo);

  btnAtualizar.Click;

  Try
    dbgItens.DataSource.DataSet.RecNo := intRecNo;
  Except
    //
  End;
end;

procedure TfrmFatFormulacaoItens.pSetaDadosClienteBaixa(strNomCam: String);
begin
  objTransfere.pSetaDadosIniciais(False);

  dicRetorno := objTransfere.fGetDicionario;

  If fEhBaixaPedidoProducaoForaLoja(dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString) then
  Begin
    dicRetorno['numdoc_pfl'] := cdsTinMaq.FieldByName('FDO_NUMDOC').AsString;
    dicRetorno['espdoc_pfl'] := cdsTinMaq.FieldByName('FDO_ESPDOC').AsString;
    dicRetorno['codemp_pfl'] := cdsTinMaq.FieldByName('FDO_CODEMP').AsString;
    dicRetorno['codven_pfl'] := cdsTinMaq.FieldByName('FDO_CODVEN').AsString;
  End;

  objTransfere.pSetaDadosCliente(fRetornaClienteFilial(dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODEMP').AsString),
                                                       dbgItens.DataSource.DataSet.FieldByName(IfThen( (strCfgExi = 'V') Or (strCfgExi = 'PA') , 'DET', 'FDO') + '_CODVEN').AsString);
end;

procedure TfrmFatFormulacaoItens.rdgTipTinClick(Sender: TObject);
begin
  inherited;
  btnAtualizar.Click;
end;

procedure TfrmFatFormulacaoItens.tmrAtuFtiTimer(Sender: TObject);
begin
  inherited;
  If (btnAtualizar.Enabled) And (btnAtualizar.Visible) Then Begin
    tmrAtuFti.Enabled := False;
    btnAtualizar.Click();
    tmrAtuFti.Enabled := True;
  End;
end;

procedure TfrmFatFormulacaoItens.tmrTmpOciTimer(Sender: TObject);
begin
  inherited;

  pGerarThreadNotTinDisp();
end;

procedure TfrmFatFormulacaoItens.pAddProgresso(strStatus: String);
begin
  pnlInfo.Caption := strStatus;
  pgbProgresso.Position := pgbProgresso.Position + 1;
  Application.ProcessMessages;
end;

procedure TfrmFatFormulacaoItens.pAdicionaFormulacoes(strAutInc: String);
  Var
    strSQL     : String;
    strFormul  : String;
    strCfgExi  : String;
    fltQtdBas  : Double;
    intContador: Integer;
    qryGen001  : TUniQuery;
begin
  qryGen001 := fCriaQuery(Nil);

  pAtualizaTempEtiqFormulacao;

  strCfgExi := fCfgSis('EXIDOC');

  strSQL := '';
  strSQL := strSQL + ' SELECT         ';
  strSQL := strSQL + '   DET_NUMDOC   ';
  strSQL := strSQL + '   , DET_ESPDOC ';
  strSQL := strSQL + '   , DET_CODEMP ';
  strSQL := strSQL + '   , DET_CODCLI ';
  strSQL := strSQL + '   , DET_CODITE ';
  strSQL := strSQL + '   , DET_CODACA ';
  strSQL := strSQL + '   , DET_EMPACA ';
  strSQL := strSQL + '   , DET_IDEPRO ';
  strSQL := strSQL + '   , DET_DESCRI ';
  strSQL := strSQL + '   , DET_TIPPRE ';
  strSQL := strSQL + '   , DET_DTAENT ';
  strSQL := strSQL + '   , DET_HORENT ';
  strSQL := strSQL + '   , DET_MONTAD ';
  strSQL := strSQL + '   , DET_A_N_O_ ';
  strSQL := strSQL + '   , DET_QTDEMB ';
  strSQL := strSQL + '   , IF(DET_QTDEMB > DET_QTDITE, DET_QTDITE, IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE)) AS QTD ';
  strSQL := strSQL + '   , OPE_NOMOPE AS DET_NOMOPE  ';
  strSQL := strSQL + '   , DET_ITETIN ';
  strSQL := strSQL + '   , IFNULL(FOR_CATALI, "") AS FOR_CATALI ';

  strSQL := strSQL + '   , CLI_NOMCLI ';
  strSQL := strSQL + '   , CLI_ENDERE ';
  strSQL := strSQL + '   , CLI_ENDNUM ';
  strSQL := strSQL + '   , CLI_BAIRRO ';
  strSQL := strSQL + '   , CID_NOMCID ';
  strSQL := strSQL + '   , CID_ESTADO ';
  strSQL := strSQL + '   , CLI_C_E_P_ ';
  strSQL := strSQL + '   , CLI_FONE01 ';
  strSQL := strSQL + '   , CLI_FONE02 ';
  strSQL := strSQL + '   , CONCAT(DET_NUMDOC,"-",DET_ESPDOC,"-",DET_CODEMP) AS DOCUME ';

  If (strCfgExi = 'V') Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
  Begin
    strSQL := strSQL + ' , DET_VOLPRO ';
    strSQL := strSQL + ' , DET_LINTIN ';
  End
  Else
  Begin
    strSQL := strSQL + ' , 0.0 AS DET_VOLPRO ';
    strSQL := strSQL + ' , DET_LINLIN ';
  End;

  for intContador := 1 to 20 do
  begin
    strSQL := strSQL + '   , DET_FORM' + fStrZero(intContador, 2) + ' ';
    strSQL := strSQL + '   , DET_QTDB' + fStrZero(intContador, 2) + ' / IF(DET_QTDEMB > DET_QTDITE, DET_QTDITE, IF(DET_QTDEMB > 0, DET_QTDEMB, DET_QTDITE)) AS DET_QTDB' + fStrZero(intContador, 2) + ' ';
  end;

  strSQL := strSQL + 'FROM ';

  If (Pos(strCfgExi, 'O_OR_PD_OP_OD_PE_DP_AD_') > 0) Or (strCfgExi = 'VP') And (Pos(strEspDoc, cnstEspTinDet) <= 0) Then
  Begin
    strSQL := AnsiReplaceStr(strSQL,'DET_','FDO_');
    strSQL := strSQL + '  TINDOR  ';

    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';

    strSQL := strSQL + '  LEFT JOIN CADOPE O ON OPE_CODOPE = FDO_CODVEN ';
  End
  Else
  Begin
    strSQL := strSQL + '  TINDET ';

    strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';

    strSQL := strSQL + '  LEFT JOIN CADOPE O ON OPE_CODOPE = DET_CODVEN ';
  End;

  strSQL := strSQL + ' LEFT JOIN FORTIN ON ' + IIF((strCfgExi = 'V')Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'DET_', 'FDO_') + 'CODACA = FOR_CODACA ';
  strSQL := strSQL + '                 AND ' + IIF((strCfgExi = 'V')Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'DET_', 'FDO_') + 'EMPACA = FOR_EMPACA ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + IIF((strCfgExi = 'V')Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0), 'TINDET', 'TINDOR') + '.AUTOINCREM = :AUTINC ';

  qryGen001.Close;
  qryGen001.SQL.Clear;
  qryGen001.SQL.Add(strSQL);
  qryGen001.ParamByName('AUTINC').AsString := strAutInc;
  qryGen001.Open;

  pCarregaDadosFormulEtiq(qryGen001, ftiDadosEtiq, true, strEspDoc);

  strSQL := '';
  strSQL := strSQL + STR_SQL_NAO_REPLICAR;
  strSQL := strSQL + ' INSERT INTO ' + strTabFor + ' ';
  strSQL := strSQL + ' VALUES ( ';
  strSQL := strSQL + '   :FORMUL, ';
  strSQL := strSQL + '   :QTDBAS ) ';

  For intContador := 1 To 20 Do
  Begin

    If (strCfgExi = 'V') Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      strFormul := qryGen001.FieldByName('DET_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      fltQtdBas := fFormataFloat(qryGen001.FieldByName('DET_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat, 1);
    End
    Else
    Begin
      strFormul := qryGen001.FieldByName('FDO_FORM' + fStrZero(IntToStr(intContador), 2)).AsString;
      fltQtdBas := fFormataFloat(qryGen001.FieldByName('FDO_QTDB' + fStrZero(IntToStr(intContador), 2)).AsFloat, 1);
    End;

    If (fEmptyStr(strFormul)) Then
      Break;

    With qryFormul Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('FORMUL').AsString := strFormul;
      ParamByName('QTDBAS').AsFloat  := fltQtdBas;
      ExecSQL;
      Close;
    End;

  End;

  qryGen001.Close;
  FreeAndNil(qryGen001);
  pAtualizaTempEtiqFormulacao;
end;

procedure TfrmFatFormulacaoItens.pApagarFormulacao;
  Var
    strSenha: String;
    strCodOpe: String;
begin
  If (Not dbgItens.DataSource.DataSet.Active) Or
     (dbgItens.DataSource.DataSet.IsEmpty)    Then
  Begin
    Exit;
  End;

  If ffrmSenha(strSenha, 'Operador Solicitante') Then
  Begin
    strCodOpe := fRetCodVendedor(strSenha);

    If fEmptyStr(strCodOpe) Then
    Begin
      fMensagem('ATENÇÃO!', 'Operador não cadastrado!', ['&Ok']);
    End
    Else If Not fVerificaAcessoSistema('DELFOR', strCodOpe) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este operador não tem direitos para excluir uma formulação!', ['&Ok']);
    End
    Else
    Begin
      pRealizaExclusao(strCodOpe);
    End;

  End;

end;

procedure TfrmFatFormulacaoItens.btnApagarClick(Sender: TObject);
begin
  If Not Assigned(cdsTinMaq) Then
    Exit;

  TfrmGravando.fExecutarModalA(pApagar, 'Aguarde, Apagando formulação ...', '');
end;

procedure TfrmFatFormulacaoItens.pApagar;
begin
  inherited;

  pFinalizarThreadNotTinDisp(False);

  pApagarFormulacao;

  pFinalizarThreadNotTinDisp(True);
end;

function TfrmFatFormulacaoItens.fImprimeEtiquetaEntrega(strOperador: String = ''): Boolean;
  Var
    tptTipTin: TTipoTinta;
    strNomCam: String;
    intContador: Integer;
    prmDllEtq: TParamDllEtiquetas;
    strNumCop : String;
begin
  Result := false;

  inherited;

  If (strCfgExi = 'V') Or (strCfgExi = 'PA')Then
    strNomCam := 'DET_IDEPRO'
  Else
    strNomCam := 'FDO_IDEPRO';

  If (Not IsTintaExistente(dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString)) Then
    Exit;

  tptTipTin := fTipoTinta(dbgItens.DataSource.DataSet.FieldByName(strNomCam).AsString);

  Try
    prmDllEtq := TParamDllEtiquetas.Create;
    prmDllEtq.tpeTipEtq := tpeEntregaTintaMaquina;
    prmDllEtq.strNumDoc := ShortString(strNumDoc);
    prmDllEtq.strEspDoc := ShortString(strEspDoc);
    prmDllEtq.tptTipTin := tptTipTin;
    prmDllEtq.strOperador := strOperador;
    prmDllEtq.strAutInc := ShortString(dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString);
    prmDllEtq.qryImpres := qryImpressao;

    {******************************************************************}
    {* VERIFICA NA CONFIGURAÇÃO LOCAL, SE NÃO HOUVER NADA CONFIGURADO *}
    {* RESPEITA A CONFIGURAÇÃO DO SISTEMA                             *}
    {****************************************************************FC}
    If Not fEmptyStr(VS_strEtiTintaMaq) Then
      prmDllEtq.blnImprim := SameText(VS_strEtiTintaMaq, 'L')
    Else
      prmDllEtq.blnImprim := fCfgSis('ETITIN') = 'L';

    If (strCfgExi = 'V')Or (strCfgExi = 'PA') Then
      prmDllEtq.intNumCop := dbgItens.DataSource.DataSet.FieldByName('DET_QTDITE').AsInteger
    Else
      prmDllEtq.intNumCop := dbgItens.DataSource.DataSet.FieldByName('FDO_QTDITE').AsInteger;

    if fCfgSis('ETINQD', varBoolean) Then
    Begin
      strNumCop := intToStr(prmDllEtq.intNumCop);
      If fInputQueryTipo('Digite o Número de Cópias', 'Número de Cópias', strNumCop, EditFocus.ttInteiro ) Then
        prmDllEtq.intNumCop := strToInt(strNumCop)
      Else
        Exit;
    End;

    if prmDllEtq.intNumCop > 1000 then
    begin
      fMensagem('', 'Não é possível a impressão do número solicitado de etiquetas.' + '('+IntToStr(prmDllEtq.intNumCop)+')' , ['&Ok']);
      Exit;
    end
    else
      Result := fImprimeEtiqueta(prmDllEtq);

    If prmDllEtq.blnImprim Then
    Begin

      qryImpressao.Close;

    End Else
    Begin
      cdsTinMaq.Tag := cdsTinMaq.FieldByName(IIF((cdsTinMaq.FindField('DET_QTDITE') <> Nil), 'DET', 'FDO') + '_QTDITE').AsInteger;

      For intContador := 1 To cdsTinMaq.Tag Do
      Begin
        Result := fImpEtiquetasMatricial;
      End;

      cdsTinMaq.Tag := 0;
    End;

    FreeAndNil(prmDllEtq);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatFormulacaoItens.fImprimeEtiquetaEntrega]');
  End;
end;

function TfrmFatFormulacaoItens.fItemRastreavel(strCodItem : String): Boolean;
Var
  qryAux : TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Text := 'SELECT ITE_RASTRE '+
                       '  FROM CADITE '+
                       ' WHERE ITE_CODITE = :CODITE';
    qryAux.ParamByName('CODITE').AsString := strCodItem;
    qryAux.Open;

    Result := qryAux.FieldByName('ITE_RASTRE').AsString = 'S';
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmFatFormulacaoItens.fLiberaDesmarcarBaixaDocJaExpedido(strDocs: string): Boolean;
Var
  objLiberacao : ILiberacao;
begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao();
  objLiberacao.objMsgLibera.Clear;
  objLiberacao.objMsgRemota.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Desmarcar Baixa de documento com expedição já realizada');
  objLiberacao.objMsgLibera.pAddSeparador(80);
  objLiberacao.objMsgLibera.pAddTexto('Documentos: ' + strDocs);
  objLiberacao.strDirAce := 'DBXEXR';
  objLiberacao.strMsgSen := 'Permitir Desmarcar Baixa de documento com expedição já realizada';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

function TfrmFatFormulacaoItens.fLoteInformadoCorretamenteParaProdutoRastreavel(
  qryTinDet: TDataSet): Boolean;
begin
  Result := Assigned(objLotePedidoWMS) And
    objLotePedidoWMS.fDigitaLotesPedidoWMS(
      qryTinDet.FieldByName('FDO_NUMDOC').AsString,
      qryTinDet.FieldByName('FDO_CODEMP').AsString,
      qryTinDet.FieldByName('CLI_CODCLI').AsString,
      qryTinDet.FieldByName('CODSEP').AsString, //CODSEP
      qryTinDet.FieldByName('AUTINC').AsString,
      qryTinDet.FieldByName('SEPIMP').AsString, //SEPIMP
      qryTinDet.FieldByName('AUTINC_DOCORI').AsString);
end;

procedure TfrmFatFormulacaoItens.pImprimeAjuste(strNumDoc, strEspDoc: String;
  intQtd: Integer);
Var
  strNomeFila: String;
  strTipImp: String;
  strNomeArquivo: String;
begin
  pImprimeFatImpTin('MOVDET', strNumDoc, strEspDoc, VS_strCodEmp, fCfgSis('CLIAJU'), 'C', '', False,
    strNomeArquivo, False, strTipImp, intQtd, impComPrecoGeral, 0, False, False, True, False, strNomeFila);
end;

procedure TfrmFatFormulacaoItens.pImprimeEtiquetaFormulacao(strOperador: String);
Var
  strNomCam: String;
  prmDllEtq: TParamDllEtiquetas;
begin
  If (strCfgExi = 'V')Or (strCfgExi = 'PA') Then
    strNomCam := 'DET_IDEPRO'
  Else
    strNomCam := 'FDO_IDEPRO';

  With cdsTinMaq Do
  Begin
    strTabFor := fNomeTabelaFormulacao(FieldByName(strNomCam).AsString); //Retorna as tabelas temporarias atraves das dlls das tintas

    If fEmptyStr(strTabFor) Then
    Begin
      If (FieldByName(strNomCam).AsString = 'SUV') Then
        strTabFor := 'TMP_FORSUV'

      Else If (FieldByName(strNomCam).AsString = 'BAU') Then
        strTabFor := 'TMP_FORBAU'

      Else If (FieldByName(strNomCam).AsString = 'QUA') Then
        strTabFor := 'TMP_FORQUA'

      Else If (FieldByName(strNomCam).AsString = 'CIA') Then
        strTabFor := 'TMP_FORCIA'

      Else If (FieldByName(strNomCam).AsString = 'ADV') Then
        strTabFor := 'TMP_FORSUV'

      Else If (FieldByName(strNomCam).AsString = 'ADT') Then
        strTabFor := 'TMP_FORADT'

      Else If (FieldByName(strNomCam).AsString = 'EUC') Then
        strTabFor := 'TMP_FOREUC'

      Else If (FieldByName(strNomCam).AsString = 'ALE') Then
        strTabFor := 'TMP_FORALE'

      Else If (FieldByName(strNomCam).AsString = 'REI') Then
        strTabFor := 'TMP_FORREI'

      Else If (FieldByName(strNomCam).AsString = 'FAR') Then
        strTabFor := 'TMP_FORBZA'

      Else If (FieldByName(strNomCam).AsString = 'DAC') Then
        strTabFor := 'TMP_FORDAC'

      Else If (FieldByName(strNomCam).AsString = 'SHE') Then
        strTabFor := 'TMP_FORSHE'

      Else If (FieldByName(strNomCam).AsString = 'LAZ') Then
        strTabFor := 'TMP_FORLAZ'

      Else If (FieldByName(strNomCam).AsString = 'BZI') Then
        strTabFor := 'TMP_FORBZI'

      Else If (FieldByName(strNomCam).AsString = 'BZA') Then
        strTabFor := 'TMP_FORBZA'

      Else If (FieldByName(strNomCam).AsString = 'SKY') Then
        strTabFor := 'TMP_FORSKY'

      Else If (FieldByName(strNomCam).AsString = 'CIM') Then
        strTabFor := 'TMP_FORCMI'

      Else If (FieldByName(strNomCam).AsString = 'CID') Then
        strTabFor := 'TMP_FORCID'

      Else If (FieldByName(strNomCam).AsString = 'LKS') Then
        strTabFor := 'TMP_FORLKS'

      Else If (FieldByName(strNomCam).AsString = 'LKC') Then
        strTabFor := 'TMP_FORLKC'

      Else If (FieldByName(strNomCam).AsString = 'FUT') Then
        strTabFor := 'TMP_FORFUT'

      Else If (FieldByName(strNomCam).AsString = 'MZI') Then
        strTabFor := 'TMP_FORMZI'

      Else If (FieldByName(strNomCam).AsString = 'KIL') Then
        strTabFor := 'TMP_FORKIL'

      Else If (FieldByName(strNomCam).AsString = 'GLA') Then
        strTabFor := 'TMP_FORGLA'

      Else If (FieldByName(strNomCam).AsString = 'SAL') Then
        strTabFor := 'TMP_FORSAL'

      Else If (FieldByName(strNomCam).AsString = 'DUP') Then
        strTabFor := 'TMP_FORDUP'

      Else If (FieldByName(strNomCam).AsString = 'STA') Then
        strTabFor := 'TMP_FORSTA'

      Else If (FieldByName(strNomCam).AsString = 'WCP') Then
        strTabFor := 'TMP_FORWCP'

      Else If (FieldByName(strNomCam).AsString = 'PPG') Then
        strTabFor := 'TMP_FORPPG'

      Else If (FieldByName(strNomCam).AsString = 'RSI') Then
        strTabFor := 'TMP_FORRSI'

      Else If (FieldByName(strNomCam).AsString = 'ANJ') Then
        strTabFor := 'TMP_FORANJ'

      Else If (FieldByName(strNomCam).AsString = 'WEG') Then
        strTabFor := 'TMP_FORWEG'

      Else If (FieldByName(strNomCam).AsString = 'MAE') Then
        strTabFor := 'TMP_FORMAE'

      Else If (FieldByName(strNomCam).AsString = 'SIN') Then
        strTabFor := 'TMP_FORSIN'

      Else If (FieldByName(strNomCam).AsString = 'MZA') Then
        strTabFor := 'TMP_FORMZA'

      Else If (FieldByName(strNomCam).AsString = 'MZD') Then
        strTabFor := 'TMP_FORMZD'

      Else If (FieldByName(strNomCam).AsString = 'NEX') Then
        strTabFor := 'TMP_FORNEX'

      Else If (FieldByName(strNomCam).AsString = 'IQU') Then
        strTabFor := 'TMP_FORIQU'

      Else If (FieldByName(strNomCam).AsString = 'LIK') Then
        strTabFor := 'TMP_FORLIK'

      Else If (FieldByName(strNomCam).AsString = 'REC') Then
        strTabFor := 'TMP_FORREC'

      Else If (FieldByName(strNomCam).AsString = 'GLO') Then
        strTabFor := 'TMP_FORGLO'

      Else If (FieldByName(strNomCam).AsString = 'AJA') Then
        strTabFor := 'TMP_FORAJA'

      Else If (FieldByName(strNomCam).AsString = 'LEC') Then
        strTabFor := 'TMP_FORLEC'

      Else If (FieldByName(strNomCam).AsString = 'REN') Then
        strTabFor := 'TMP_FORREN'

      Else If (FieldByName(strNomCam).AsString = 'ANN') Then
        strTabFor := 'TMP_FORANN'

      Else If (FieldByName(strNomCam).AsString = 'DOX') Then
        strTabFor := 'TMP_FORDOX'

      Else If (FieldByName(strNomCam).AsString = 'KIN') Then
        strTabFor := 'TMP_FORKIN'

      Else If (FieldByName(strNomCam).AsString = 'ROB') Then
        strTabFor := 'TMP_FORROB'

      Else If (FieldByName(strNomCam).AsString = 'MAX') Then
        strTabFor := 'TMP_FORMAX'

      Else If (FieldByName(strNomCam).AsString = 'ALP') Then
        strTabFor := 'TMP_FORALP';
    End;

    Try
      pCriaTempEtiqFormulacao;
      pAdicionaFormulacoes(FieldByName('AUTOINCREM').AsString);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pImprimeEtiquetaFormulacao]');
        Raise;
      End;
    End;

    prmDllEtq := TParamDllEtiquetas.Create;
    Try
      prmDllEtq.tpeTipEtq   := tpeFomulacaoTinta;
      prmDllEtq.dtsImpres   := qryFormul;
      prmDllEtq.ftiDadEti   := ftiDadosEtiq;
      prmDllEtq.strOperador := strOperador;

      fImprimeEtiqueta(prmDllEtq);
    Finally
      FreeAndNil(prmDllEtq);
    End;
  End;
end;

procedure TfrmFatFormulacaoItens.pImprimeEtiquetaProducao;
var
  prmDllEtq: TParamDllEtiquetas;
begin
  Try
    Try
      prmDllEtq := TParamDllEtiquetas.Create;
      prmDllEtq.tpeTipEtq := tpeProducaoTintaMaquina;
      prmDllEtq.dtsImpres := dbgItens.DataSource.DataSet;
      prmDllEtq.ftiDadEti := ftiDadosEtiq;
      dbgItens.DataSource.DataSet.Filtered := False;
      dbgItens.DataSource.DataSet.Filter := 'CHAVE = ' + QuotedStr(dbgItens.DataSource.DataSet.FieldByName('CHAVE').AsString);
      dbgItens.DataSource.DataSet.Filtered := True;
      fImprimeEtiqueta(prmDllEtq);
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[untImprimeEtiquetas.pImprimeEtiquetaProducao]');
      end;
    End;
  Finally
    dbgItens.DataSource.DataSet.Filtered := False;
    If Assigned(prmDllEtq) Then
      FreeAndNil(prmDllEtq);
  End;
end;

procedure TfrmFatFormulacaoItens.pImprimeTicketIF(strNumDoc, strEspDoc,
  strCodCli: String; intQtd: Integer);
Var
  strNomeArquivo: String;
begin
  Try
    pImprimeFatImpTin('MOVDET', strNumDoc, strEspDoc, VS_strCodEmp, strCodCli, 'C', '', False,
      strNomeArquivo, False, 'I', intQtd, impSemPrecoGeral, 0, False, True);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeTicketIF]');
    End;

  End;
end;

procedure TfrmFatFormulacaoItens.pInicializarNoticacoes;
begin
  blnNOTFTI := fCfgSis('NOTFTI', varBoolean);
  intATUFTI := fCfgSis('ATUFTI', varInteger);
  intTMPOCI := fCfgSis('TMPOCI', varInteger);
  intDURNOT := fCfgSis('DURNOT', varInteger);

  If (blnNOTFTI) Then Begin
    tmrAtuFti.Interval := intATUFTI * 1000;
    tmrTmpOci.Interval := intTmpOci * 1000;
  End Else Begin
    thrNotificacao := nil
  End;

  pHabilitarNotificacoes(blnNOTFTI);
end;

function TfrmFatFormulacaoItens.fEhBaixaPedidoProducaoForaLoja(strEmpFor: string): Boolean;
begin
  if (strCfgExi <> 'PD') then
    Exit(False);

  if not (fProdForaLojaFGO(cdsTinMaq)) then
    Exit(False);

  if (strEmpFor = VS_strCodEmp) then
    Exit(False);

  if not (fCfgSis('GTEPFL', varBoolean)) then
    Result := False
  else
    Result := True;
end;

function TfrmFatFormulacaoItens.fEnt_Cd(qryTinDet: TDataSet): Boolean;
var
  qryGen: TUniQuery;

  function fCmpEntCd: String;
  begin
    Result := ' FGO_ENT_CD ';
    {***********************************************************************************************************************************}
    {* A PARTIR DA VERSÃO 72.49, PEDIDOS DE TRANSFERÊNCIA VINDOS DE CLIENTE FILIAL PASSARAM A VIR COMO FGO_ENT_CD = S (REQ.: 162831).  *}
    {* ATÉ ENTÃO FGO_ENT_CD PARA ESSES PEDIDOS FICAVAM COM FGO_ENT_CD = N. NO REQ.: 133410 FOI ALTERADO O SISTEMA PARA QUE APARECESSEM *}
    {* ESSES PEDIDOS, NO ENTANTO, A FORMA COMO FOI FEITO, FEZ COM QUE NÃO APARECESSE MAIS OS PEDIDOS GRAVADOR PÓS VERSÃO 72.49         *}
    {* REVERTI O CÓDIGO DO REQUISITO 133410 E FIZ COMO CÓDIGO ABAIXO, PARA QUE FUNCIONE EM AMBOS CENÁRIOS DOS REQS.: 133410 E 190356   *}
    {* SE O CLIENTE TIVESSE TRABALHANDO SÓ COM CÓPIA POSTERIOR A 72.49 NÃO PRECISARIA DA LINHA ABAIXO, MAS A BELA ESTÁ TRABALHANDO COM *}
    {* UMA CÓPIA 72.44 (PD DE TRANSF COM FGO_ENT_CD=N) E 72.77 (PD DE TRANSF COM FGO_ENT_CD=S) OU SEJA, NO FUTURO POSSO EVENTUALMENTE  *}
    {* TIRAR A CONDIÇÃO ABAIXO                                                                                                         *}
    {********************************************************************************************************************REQ.:190356*VA*}
    If (Not fEmptyStr(VS_strCliFilLocal)) And (fCfgSis('ENT_CD', varBoolean)) And (fCfgSis('EMP_CD', varString) = VS_strCodEmp) Then
    Begin
      Result := ' IF((FGO_ENT_CD = "S") OR (FATGOR.FGO_CODCLI IN ('+VS_strCliFilLocal+') AND EXTGOR.FGO_EMP_TE = :CODEMP AND FATGOR.FGO_OPRFLJ = "N"), "S", "N") AS FGO_ENT_CD ';
    End;
    {********************************************************************************************************************REQ.:190356*VA*}
  end;

begin
  qryGen := nil;
  Result := false;
  Try
    Try
      qryGen := fCriaQuery(Self);
      if (strCfgExi = 'V')Or (strCfgExi = 'PA') then
      begin
        qryGen.SQL.Text :=
          ' SELECT                     ' +
          '   FGO_ENT_CD               ' +
          '   , FGO_OPRFLJ             ' +
          ' FROM                       ' +
          '   FATGOR                   ' +
          ' WHERE FGO_NUMFAT = :NUMDOC ' +
          '   AND FGO_TIPFAT = :ESPDOC ' +
          '   AND FGO_EMPFAT = :CODEMP ';
      end
      else
      begin
        qryGen.SQL.Text :=
          ' SELECT                     ' +
          fCmpEntCd +
          '   , FGO_OPRFLJ             ' +
          ' FROM                       ' +
          '   FATGOR LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '+
          ' WHERE FGO_NUMDOC = :NUMDOC ' +
          '   AND FGO_ESPDOC = :ESPDOC ' +
          '   AND FGO_CODEMP = :CODEMP ';
      end;

      qryGen.ParamByName('NUMDOC').AsString := qryTinDet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString;
      qryGen.ParamByName('ESPDOC').AsString := qryTinDet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString;
      qryGen.ParamByName('CODEMP').AsString := qryTinDet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString;
      qryGen.Open;

      Result := (qryGen.FieldByName('FGO_ENT_CD').AsString = 'S');
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
End;

function TfrmFatFormulacaoItens.fEspecieTE: String;
begin
  Result := 'TE';
  If fCfgSis('NFTEAU') = '1' Then
    Result := 'NF';
end;

function TfrmFatFormulacaoItens.fExibeMensagemTintaNaoEncontrada: Boolean;
var
  qryArqFor: TUniQuery;
  arrFormul: TForMulTinDetArray;
  arrBaixaPigmentos: TBaixaPigmentosArray;
  stlItensTraMl: TStringList;
  stlTintas: TStringList;
begin
  Result := False;

  If ((strCfgExi <> 'V' ) And (Pos(strCfgExi, 'AD_OD_DP_') <= 0)) Or
    ((Pos(strCfgExi, 'AD_OD_DP_') > 0) And (Pos(strEspDoc, cnstEspTinDet) <= 0)) Then
  Begin
    SetLength(arrBaixaPigmentos, 0);
    stlItensTraMl := TStringList.Create;
    qryArqFor     := fCriaQuery(Self);

    If Not fGTinForGeral(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO').AsString,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITETIN').AsString,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_TIPPRE').AsString,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET_LINTIN', 'FDO_LINLIN')).AsString,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CATALI').AsString,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_LAZQUA').AsInteger,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDEMB').AsFloat,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDITE').AsFloat,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCRI').AsString,
                         qryArqFor,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_VOLPRO').AsFloat,
                         arrFormul,
                         arrBaixaPigmentos,
                         stlItensTraMl,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODDIL').AsString,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_PORDIL').AsFloat,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DILCON').AsString,
                         dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_PORCAT').AsFloat,
                         dbgItens.DataSource.DataSet.FieldByName('FOR_TIPCOR').AsString,
                         dbgItens.DataSource.DataSet.FieldbyName('FOR_TEXBAS').AsString,
                         dbgItens.DataSource.DataSet.FieldbyName('FOR_MODDIL').AsInteger,
                         dbgItens.DataSource.DataSet.FieldbyName('FOR_ITECOB').AsString,
                         dbgItens.DataSource.DataSet.FieldbyName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_EMPPRD').AsString) Then
    Begin

      Result := True;

      Try
        stlTintas := TStringList.Create;

        stlTintas.Add('----------------------------------------------------------------------------------');
        stlTintas.Add('                                 A T E N Ç Ã O                                    ');
        stlTintas.Add('----------------------------------------------------------------------------------');
        stlTintas.Add('AS FÓRMULAS ABAIXO SOFRERAM ALTERAÇÕES EM SUA FORMULAÇÃO E NÃO FORAM LOCALIZADAS. ');
        stlTintas.Add('FAVOR REABRIR O DOCUMENTO ' + dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString + ' - ' + dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString + ' E INSERIR AS FÓRMULAS NOVAMENTE.' );
        stlTintas.Add('----------------------------------------------------------------------------------');
        stlTintas.Add('');
        stlTintas.Add('DESCRIÇÃO DA FÓRMULA: ' + dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_DESCRI').AsString);
        stlTintas.Add('UNIDADE.............: ' + dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_UNIDAD').AsString);
        stlTintas.Add('PREÇO DE VENDA......: ' + 'R$ ' + FloatToStrF(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_UNITAR').AsFloat, ffNumber, 12, 2));
        stlTintas.Add('QUANTIDADE..........: ' + FloatToStrF(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_QTDITE').AsFloat, ffFixed, 10, fCfgSis('DECQTD', varInteger)));
        stlTintas.Add('TINTA...............: ' + fRetornaNomeTinta(dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_IDEPRO').AsString));
        stlTintas.Add('MD5KEY..............: ' + dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ITETIN').AsString);
        stlTintas.Add('');
        stlTintas.Add('----------------------------------------------------------------------------------');

        pCriarFormularios(TfrmObservacao, frmObservacao);
        frmObservacao.Caption             := 'Tinta de máquina';
        frmObservacao.lblMensagem.Caption := 'Formulação não encontrada';
        frmObservacao.Height              := 328;
        frmObservacao.Width               := 650;
        frmObservacao.memObs.Font.Name    := 'Courier New';
        frmObservacao.memObs.Height       := 223;
        frmObservacao.memObs.Width        := 628;
        frmObservacao.memObs.Lines.Assign(stlTintas);
        frmObservacao.ShowModal;
      Finally
        If Assigned(frmObservacao) Then pFreeAndNil(frmObservacao);
        If Assigned(stlTintas)     Then pFreeAndNil(stlTintas);
        If Assigned(stlItensTraMl) Then pFreeAndNil(stlItensTraMl);
        If Assigned(qryArqFor)     Then pFreeAndNil(qryArqFor);
      End;
    End;
  End;
end;

function TfrmFatFormulacaoItens.fExpedicaoFaturada(qryTinDet: TDataSet) : Boolean;
var
  qryGen : TUNiQuery;
  strSQL : String;
begin
  qryGen := fCriaQuery;
  Try
    strSQL := '';

    If (strCfgExi = 'V') Or (strCfgExi = 'PA') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    begin

      strSQL := 'SELECT COUNT(*) AS QNTD     '+
                '  FROM FATDOR               '+
                ' WHERE FDO_TIPFAT = :TIPFAT '+
                '   AND FDO_NUMFAT = :NUMFAT '+
                '   AND FDO_EMPFAT = :EMPFAT ';

    end
    else
    begin
      strSQL := 'SELECT COUNT(*) AS QNTD     '+
                '  FROM FATDOR               '+
                ' WHERE FDO_JAFATU = ''1''   '+
                '   AND FDO_NUMDOC = :NUMDOC '+
                '   AND FDO_ESPDOC = :ESPDOC '+
                '   AND FDO_CODEMP = :CODEMP '+
                '   AND FDO_CODCLI = :CODCLI '+
                '   AND FDO_CODITE = :CODITE ';
    end;

    strSQL := strSQL + ' AND FDO_CODACA = :CODACA '+
                       ' AND FDO_EMPACA = :EMPACA ';

    qryGen.SQL.Clear;

    qryGen.Close;
    qryGen.SQL.Text := strSQL;

    If ((Pos(strCfgExi, 'DP_VP_') > 0) And (strCfgExi <> 'V')) And (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      qryGen.ParamByName('TIPFAT').AsString := qryTinDet.FieldByName('FDO_ESPDOC').AsString;
      qryGen.ParamByName('NUMFAT').AsString := qryTinDet.FieldByName('FDO_NUMDOC').AsString;
      qryGen.ParamByName('EMPFAT').AsString := qryTinDet.FieldByName('FDO_CODEMP').AsString;
    End
    Else If (strCfgExi = 'PE') And (strEspDoc = 'EP') Then
    Begin
      qryGen.ParamByName('TIPFAT').AsString := qryTinDet.FieldByName('FDO_ESPDOC').AsString;
      qryGen.ParamByName('NUMFAT').AsString := qryTinDet.FieldByName('FDO_NUMDOC').AsString;
      qryGen.ParamByName('EMPFAT').AsString := qryTinDet.FieldByName('FDO_CODEMP').AsString;
    End
    Else if (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      qryGen.ParamByName('TIPFAT').AsString := qryTinDet.FieldByName(IfThen((Pos(strCfgExi, 'O_OP_OD_AD_') > 0), 'FDO', 'DET') + '_ESPDOC').AsString;
      qryGen.ParamByName('NUMFAT').AsString := qryTinDet.FieldByName(IfThen((Pos(strCfgExi, 'O_OP_OD_AD_') > 0), 'FDO', 'DET') + '_NUMDOC').AsString;
      qryGen.ParamByName('EMPFAT').AsString := qryTinDet.FieldByName(IfThen((Pos(strCfgExi, 'O_OP_OD_AD_') > 0), 'FDO', 'DET') + '_CODEMP').AsString;
    End
    Else
    Begin
      qryGen.ParamByName('NUMDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_NUMDOC').AsString;
      qryGen.ParamByName('ESPDOC').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_ESPDOC').AsString;
      qryGen.ParamByName('CODEMP').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODEMP').AsString;
      qryGen.ParamByName('CODCLI').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODCLI').AsString;
      qryGen.ParamByName('CODITE').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((strCfgExi = 'V')Or (strCfgExi = 'PA'), 'DET', 'FDO') + '_CODITE').AsString;
    End;

    If ((Pos(strCfgExi, 'DP_VP_') > 0) And (strCfgExi <> 'V')) And (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      qryGen.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_CODACA').AsString;
      qryGen.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_EMPACA').AsString;
    End
    Else If (strCfgExi = 'PE') And (strEspDoc = 'EP') Then
    Begin
      qryGen.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_CODACA').AsString;
      qryGen.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_EMPACA').AsString;
    End
    Else If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
    Begin
      qryGen.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((Pos(strCfgExi, 'O_OP_OD_AD_') > 0), 'FDO', 'DET') + '_CODACA').AsString;
      qryGen.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName(IfThen((Pos(strCfgExi, 'O_OP_OD_AD_') > 0), 'FDO', 'DET') + '_EMPACA').AsString;
    End
    Else
    Begin
      qryGen.ParamByName('CODACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_CODACA').AsString;
      qryGen.ParamByName('EMPACA').AsString := dbgItens.DataSource.DataSet.FieldByName('FDO_EMPACA').AsString;
    End;

    qryGen.Open;

    Result := (qryGen.FieldByName('QNTD').AsInteger > 0);

  finally
    pFreeAndNil(qryGen);
  end;

end;

function TfrmFatFormulacaoItens.fFormulacaoJaBaixada(strAutInc: String): Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      If (strCfgExi = 'V')Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
      Begin
        SQL.Add('SELECT DET_BAIXAD AS BAIXAD ');
        SQL.Add('FROM TINDET ');
      End
      Else
      Begin
        SQL.Add('SELECT FDO_BAIXAD AS BAIXAD ');
        SQL.Add('  FROM TINDOR ');
      End;
      SQL.Add('WHERE                  ');
      SQL.Add('  AUTOINCREM = :AUTINC ');
      ParamByName('AUTINC').AsString := strAutInc;
      Open;

      Result := (FieldByName('BAIXAD').AsString = 'S') Or (FieldByName('BAIXAD').AsString = '1');
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatFormulacaoItens.pDesmarcaBaixado;
  Var
    StrDocs                : String;
    intCont                : Integer;
    StrListExecuta         : TStringList;
    StrListNaoExecuta      : TStringList;
    StrListDocsFatExp      : TStringList;
    StrListLiberados       : TStringList;
    StrListDocEspEmpFatExp : TStringList;
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strOpeLib,
    strCodVen              : String;
    strPrefix: String;
Begin

  strPrefix := IIF((strCfgExi = 'V') Or (strCfgExi = 'PA'), 'DET_', 'FDO_');

  try
    StrListExecuta         := TStringList.Create;
    StrListNaoExecuta      := TStringList.Create;
    StrListDocsFatExp      := TStringList.Create;
    StrListLiberados       := TStringList.Create;
    StrListDocEspEmpFatExp := TStringList.Create;

    dbgItens.DataSource.DataSet.DisableControls;

    dbgItens.DataSource.DataSet.First;

    while not dbgItens.DataSource.DataSet.Eof do
    begin
      If (dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString = 'S') Then
      begin
        If ((dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'CODEMP').AsString <> VS_strCodEmp) And
           ((Not (fEnt_Cd(dbgItens.DataSource.DataSet))) Or
           (fDocumentoEhAbastecimentoPorDepositoComProducaoForaDaLoja(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString,
                                                                      dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'ESPDOC').AsString,
                                                                      dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'CODEMP').AsString,
                                                                      dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'CODCLI').AsString)))) Then
        Begin
          If StrListNaoExecuta.IndexOf(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString) = -1 then
            StrListNaoExecuta.Add(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString)
        end
        else
          StrListExecuta.Add(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString);
      end;

      dbgItens.DataSource.DataSet.Next;
    end;

    if( StrListNaoExecuta.Count > 0 )then
    begin
      StrDocs := '';

      for intCont := 0 to StrListNaoExecuta.Count - 1 do
          StrDocs := StrDocs + '[' + StrListNaoExecuta[intCont] + '] ';

      pMensagemOk('Não é possível desmarcar os documentos baixados ' + StrDocs +', pois foram gerados como ' +
                  'produção fora de loja e isso ocasiona nas baixas dos colorantes. Deve ser realizada a devolução da tinta. ');

    end;

    if StrListExecuta.Count <= 0 then
      exit;

    dbgItens.DataSource.DataSet.First;

    StrListExecuta.Clear;

    while not dbgItens.DataSource.DataSet.Eof do
    begin
      If (dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString = 'S')
        and (StrListNaoExecuta.IndexOf(dbgItens.DataSource.DataSet.FieldByName( strPrefix + 'NUMDOC').AsString) = -1)  Then
      begin
        if (fExpedicaoFaturada(dbgItens.DataSource.DataSet)) and (fEnt_Cd(dbgItens.DataSource.DataSet)) then
        begin
          if (StrListDocsFatExp.IndexOf(dbgItens.DataSource.DataSet.FieldByName( strPrefix + 'NUMDOC').AsString) = -1) then
          begin
            StrListDocsFatExp.Add(dbgItens.DataSource.DataSet.FieldByName( strPrefix + 'NUMDOC').AsString);
            StrListDocEspEmpFatExp.Add(
              dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString + '-' +
              dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'ESPDOC').AsString + '-' +
              dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'CODEMP').AsString
              );
          end
        end
        else
          StrListExecuta.Add(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString);
      end;

      dbgItens.DataSource.DataSet.Next;
    end;

    if (StrListDocsFatExp.Count > 0) Then
    begin
      StrDocs := '';

      for intCont := 0 to StrListDocEspEmpFatExp.Count - 1 do
        StrDocs := StrDocs + '[' + StrListDocEspEmpFatExp[intCont] + '] ';

      If fLiberaDesmarcarBaixaDocJaExpedido(strDocs) then
      Begin
        For intCont := 0 to StrListDocsFatExp.Count - 1 do
        Begin
          StrListLiberados.Add(StrListDocsFatExp[intCont]);
          StrListExecuta.Add(StrListDocsFatExp[intCont]);
        End;
        StrListDocsFatExp.Clear;
        StrListDocEspEmpFatExp.Clear;
      End
      else
        pMensagemOk('Não é possível desmarcar os documentos baixados '+ StrDocs +', pois os mesmos já foram faturados na expedição.');

    end;

    if StrListExecuta.Count <= 0 then
      exit;


    //Verifica se a tinta é utilizada pelo cliente
    Try

      dbgItens.DataSource.DataSet.DisableControls;

      dbgItens.DataSource.DataSet.First;

      while not dbgItens.DataSource.DataSet.Eof do
      begin
        If (dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString = 'S') Then
        Begin

          If Not IsTintaExistente(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'IDEPRO').AsString) Then
          Begin
            dbgItens.DataSource.DataSet.EnableControls;
            Exit;
          End;
        End;

        dbgItens.DataSource.DataSet.Next;
      end;
    Finally
      dbgItens.DataSource.DataSet.EnableControls;
    End;

    If fMensagem('','Deseja realmente desmarcar a baixa?',['','']) = 1 Then
    Begin
      dbgItens.DataSource.DataSet.First;
      while not dbgItens.DataSource.DataSet.Eof do
      begin
        intQtdSel := 0;

        If (dbgItens.DataSource.DataSet.FieldByName('BAIXAOP').AsString = 'S')
          and ((StrListNaoExecuta.IndexOf(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString ) = -1)
           and (StrListDocsFatExp.IndexOf(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString ) = -1))Then
        begin

          Try

            pExecutaSQL(fRetornaSQLTindetDesmarcaBaixad(dbgItens.DataSource.DataSet),
                        ['AUTINC'],
                        [dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString]);

            fBaixaDocumentoFuturo('N');

            If (StrListLiberados.IndexOf(dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString ) > -1) Then
            Begin
              strNumDoc := dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'NUMDOC').AsString;
              strEspDoc := dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'ESPDOC').AsString;
              strCodEmp := dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'CODEMP').AsString;
              strOpeLib := strLoginUsuarioLogado;
              strCodVen := dbgItens.DataSource.DataSet.FieldByName(strPrefix + 'CODVEN').AsString;

              pGeraLogLiberacao(strNumDoc, strEspDoc, strCodEmp,
                'Liberação Desmarcar Baixa de documento com expedição já realizada',
                strOpeLib, strCodVen, Self.Caption);
            End;

          Except
            On E: Exception Do
              pMensagensErro(E.Message,'');
          End;
        end;

        dbgItens.DataSource.DataSet.Next;
      end;

    End;

  finally
    dbgItens.DataSource.DataSet.EnableControls;
    FreeAndNil(StrListExecuta);
    FreeAndNil(StrListNaoExecuta);
    FreeAndNil(StrListDocsFatExp);
    FreeAndNil(StrListLiberados);
    FreeAndNil(StrListDocEspEmpFatExp);
  end;
End;

procedure TfrmFatFormulacaoItens.pFinalizarThreadNotTinDisp(blnAtivarTimer: Boolean);
begin
  If (blnNOTFTI) Then Begin
    pHabilitarNotificacoes(blnAtivarTimer);

    If (Assigned(thrNotificacao)) And (thrNotificacao.Started) Then Begin
      thrNotificacao.Terminate();
      thrNotificacao.WaitFor();
      thrNotificacao := nil;
    End;
  End;
end;

procedure TfrmFatFormulacaoItens.pGerarThreadNotTinDisp;
begin
  If (Not Assigned(dbgItens.DataSource.DataSet)) Then
    Exit;

  dbgItens.DataSource.DataSet.DisableControls;
  Try
    dbgItens.DataSource.DataSet.Filtered := False;
    dbgItens.DataSource.DataSet.Filter := 'ORDIMP = ''N''';
    dbgItens.DataSource.DataSet.Filtered := True;

    If (dbgItens.DataSource.DataSet.IsEmpty) Then
      Exit;

    pHabilitarNotificacoes(False);
    thrNotificacao := TThreadNotificacao.Create(intDurNot);
  Finally
    dbgItens.DataSource.DataSet.Filtered := False;
    dbgItens.DataSource.DataSet.Filter := '';
    dbgItens.DataSource.DataSet.EnableControls;
  End;
end;

procedure TfrmFatFormulacaoItens.pHabilitarNotificacoes(blnAtivar: Boolean);
begin
  tmrAtuFti.Enabled := blnAtivar;
  tmrTmpOci.Enabled := blnAtivar;
end;

procedure TfrmFatFormulacaoItens.pAtualizaMovDetMls(var stlDetMLs: TStringList; strCodAca, strEmpAca, strEspDoc : String);
var
  qryAux: TUniQuery;
  intIndice: Integer;
begin
  qryAux := nil;
  Try
    Try
      If Assigned(stlDetMLs) Then
      Begin
        qryAux := fCriaQuery(Nil);
        qryAux.SQL.Add('UPDATE ');
        qryAux.SQL.Add('MOVDET ');
        qryAux.SQL.Add('SET ');
        qryAux.SQL.Add('  DET_CODACA = :CODACA,');
        qryAux.SQL.Add('  DET_EMPACA = :EMPACA ');
        qryAux.SQL.Add('WHERE ');
        qryAux.SQL.Add('  AUTOINCREM = :AUTINC ');

        For intIndice := 0 To stlDetMLs.Count - 1 Do
        Begin
          qryAux.Close;
          qryAux.ParamByName('CODACA').AsString := strCodAca;
          qryAux.ParamByName('EMPACA').AsString := strEmpAca;
          qryAux.ParamByName('AUTINC').AsString := stlDetMLs[intIndice];
          qryAux.ExecSQL;
        End;

        stlDetMLs.Clear;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    If Assigned(qryAux) Then
      FreeAndNil(qryAux);
  End;

end;

function TfrmFatFormulacaoItens.fSituacaoFinanceiraPedidoOk(var strPenFin: String): Boolean;
begin
  Result := fValidaSituacaoFinanceiraPedido(cdsTinMaq.FieldByName('NUMDOC').AsString,
                                            cdsTinMaq.FieldByName('ESPDOC').AsString,
                                            cdsTinMaq.FieldByName('CODEMP').AsString,
                                            strPenFin,
                                            True,
                                            True);
end;

function TfrmFatFormulacaoItens.fEhAbastecimentoPorDepositoComProducaoForaDaLoja(qryTinDet: TDataSet): Boolean;
begin
  Result := False;
  If Assigned(qryTinDet.FindField('FDO_NUMDOC')) And
     Assigned(qryTinDet.FindField('FDO_ESPDOC')) And
     Assigned(qryTinDet.FindField('FDO_CODEMP')) And
     Assigned(qryTinDet.FindField('FDO_CODCLI')) Then
  Begin
    Result := fEhAbastecimentoPorDepositoComProducaoForaDaLoja(qryTinDet.FieldByName('FDO_NUMDOC').AsString,
                                                               qryTinDet.FieldByName('FDO_ESPDOC').AsString,
                                                               qryTinDet.FieldByName('FDO_CODEMP').AsString,
                                                               qryTinDet.FieldByName('FDO_CODCLI').AsString);
  End;
end;

function TfrmFatFormulacaoItens.fEhAbastecimentoPorDepositoComProducaoForaDaLoja(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
begin
  Result := False;

  If fCfgSis('GTEPFL', varBoolean) Then
    Exit;

  Result := fDocumentoEhAbastecimentoPorDepositoComProducaoForaDaLoja(strNumDoc, strEspDoc, strCodEmp, strCodCli);
end;

function TfrmFatFormulacaoItens.fDocumentoEhAbastecimentoPorDepositoComProducaoForaDaLoja(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  Try
    qryGen.SQL.Text := 'SELECT FGO_ABADEP, FGO_OPRFLJ FROM FATGOR ' +
                       'LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '+
                       'WHERE FGO_NUMDOC = :NUMDOC ' +
                       '  AND FGO_ESPDOC = :ESPDOC ' +
                       '  AND FGO_CODEMP = :CODEMP ' +
                       '  AND FGO_CODCLI = :CODCLI ';

    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.ParamByName('CODCLI').AsString := strCodCli;
    qryGen.Open;

    Result := (qryGen.FieldByName('FGO_OPRFLJ').AsString = 'S') And
              (qryGen.FieldByName('FGO_ABADEP').AsString = 'S');

  Finally
    FreeAndNil(qryGen);
  End;
end;

end.
