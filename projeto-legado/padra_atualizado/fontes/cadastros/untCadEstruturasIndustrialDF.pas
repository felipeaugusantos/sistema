{***************************}
{* qryConIte -> CADITE     *}
{* qryConCor -> CADCOR     *}
{* qryConFas -> CADFAS     *}
{************************JB*}
unit untCadEstruturasIndustrialDF;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, Uni, Grids, DBGridCitel, DBGrids, AppEvnts, frxClass, frxDBSet,
  DB, UniClientDataSet, UniDataSetProvider,  cxControls, cxContainer, cxEdit, cxLabel,
  cxDBLabel, untGeraExcel, untExcel, BitBtnLockedIncrem, MemDS, DBAccess,
  Provider, frxExportCSVTestabilidade, untZClient, StrUtils,
  untOrdProIndustrial, Datasnap.DBClient, Vcl.ComCtrls, untAnaliseMov,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, DateEditFocus, DateUtils,
  untLiberacao;

type
  TfrmCadEstruturasIndustrialDF = class(TfrmPai)
    pnlProdutos: TPanel;
    Label1: TLabel;
    edtDesProduto: TEditFocus;
    Label5: TLabel;
    Label10: TLabel;
    edtProdutos: TEditFocus;
    edtReferencia: TEditFocus;
    edtUnidade: TEditFocus;
    frxPaginaM: TfrxReport;
    frxPaginaJ: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    frxSemPrecoM: TfrxReport;
    frxSemPrecoJ: TfrxReport;
    frxPreCusM: TfrxReport;
    frxPreCusJ: TfrxReport;
    Label8: TLabel;
    edtCor: TEditFocus;
    edtDesCor: TEditFocus;
    Label9: TLabel;
    edtCodFormula: TEditFocus;
    pnlForDes: TPanel;
    Label15: TLabel;
    pnlTotais: TPanel;
    btnConfirma: TBitBtnLocked;
    btnEstrutura: TBitBtnLocked;
    btnComentario: TBitBtnLocked;
    btnMoveCima: TBitBtnLocked;
    btnMoveBaixo: TBitBtnLocked;
    btnApaga: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnSubstituir: TBitBtnLocked;
    pnlFormulaReal: TPanel;
    Panel3: TPanel;
    Label22: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    edtPVC: TEditFocus;
    edtCPVC: TEditFocus;
    edtPVCCPVC: TEditFocus;
    GroupBox1: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    edtMasSol: TEditFocus;
    edtVolSol: TEditFocus;
    btnImpFor: TBitBtnLocked;
    Panel1: TPanel;
    pnlPesos: TPanel;
    Label16: TLabel;
    Label14: TLabel;
    edtPesRea: TEditFocus;
    edtTotPes: TEditFocus;
    pnlCusKG: TPanel;
    lblTotCusKG: TLabel;
    edtTotCus: TEditFocus;
    pnlCusLT: TPanel;
    Label12: TLabel;
    edtTotCusLT: TEditFocus;
    pnlPercentualTotal: TPanel;
    Label13: TLabel;
    edtTotPer: TEditFocus;
    pnlPesoOficial: TPanel;
    edtPesReaOfi: TEditFocus;
    Label21: TLabel;
    edtTotPesOfi: TEditFocus;
    Label20: TLabel;
    Panel2: TPanel;
    lblCustoOfi: TLabel;
    edtTotCusOfi: TEditFocus;
    pnlCusLTOfi: TPanel;
    Label19: TLabel;
    edtTotCusLTOfi: TEditFocus;
    frxPreCusLitroM: TfrxReport;
    frxPreCusLitroJ: TfrxReport;
    pgcFormulacao: TPageControl;
    tbsFormula: TTabSheet;
    tbsAnalise: TTabSheet;
    pnlSubProdutos: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    edtDesSubProduto: TEditFocus;
    edtSubProduto: TEditFocus;
    edtSubReferencia: TEditFocus;
    edtSubUnidade: TEditFocus;
    edtSubQtdIte: TEditFocus;
    edtCodFas: TEditFocus;
    edtDesFas: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    edtSeq: TEditFocus;
    dbgDados: TDBGridCitel;
    pnlAnalises: TPanel;
    Label27: TLabel;
    edtCodAna: TEditFocus;
    edtDesAna: TEditFocus;
    btnConfirmaAnalise: TBitBtnLocked;
    btnCancelaAnalise: TBitBtnLocked;
    pgcResultadoAnalise: TPageControl;
    tbsIntervaloValores: TTabSheet;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtAnaMin: TEditFocus;
    edtAnaMax: TEditFocus;
    tbsDescricaoAberta: TTabSheet;
    Label31: TLabel;
    edtDescricaoResultadoAnalise: TEditFocus;
    dbgAnalise: TDBGridCitel;
    edtPerTol: TEditFocus;
    btnAtivaDesenvolvimento: TBitBtnLocked;
    Label32: TLabel;
    lblDataDesenvolvimento: TLabel;
    edtDataDesenvolvimento: TDateEditFocus;
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);

    procedure pCarregaProduto(qryConsulta: TUniQuery);
    procedure pCarregaSubProduto(qryConsulta: TUniQuery);
    procedure pCarregaCor(qryConsulta: TUniQuery);

    procedure edtSubProdutoKeyPress(Sender: TObject; var Key: Char);

    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria(intPosicao: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure pLimparDados;
    procedure pHabilitaCampos;
    procedure pDeletaItem;
    procedure pGravar(blnImpressao: Boolean);

    function fRetCustoItem(strCodite:String): String;
    function fRetPreVenda1(strCodIte:String): String;
    function fRetPreVenda2(strCodIte:String): String;
    function fRetPreVenda3(strCodIte:String): String;
    function fRetPreVenda4(strCodIte:String): String;
    function fRetPreVenda5(strCodIte:String): String;
    function fRetPreVenda6(strCodIte:String): String;
    function fRetPreVenda7(strCodIte:String): String;
    function fRetSeqGer: String;
    function fRetSeqIte(intSeqGer :  Integer): String;
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnEstruturaClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnComentarioClick(Sender: TObject);

    function  fCarregaEstrutura: Boolean;
    procedure btnMoveCimaClick(Sender: TObject);
    procedure btnMoveBaixoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApagaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCorExit(Sender: TObject);
    procedure edtCorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFasKeyPress(Sender: TObject; var Key: Char);
    procedure btnSubstituirClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnImpForClick(Sender: TObject);
    procedure edtPesReaChange(Sender: TObject);
    procedure pgcFormulacaoEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaAnaliseClick(Sender: TObject);
    procedure dbgAnaliseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgAnaliseDblClick(Sender: TObject);
    procedure edtCodAnaKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaAnaliseClick(Sender: TObject);
    procedure pgcResultadoAnaliseEnter(Sender: TObject);
    procedure btnAtivaDesenvolvimentoClick(Sender: TObject);

  private
    { Private declarations }
    strCusIte: String;
    fltDensid: Double;

    fltPerSol: Double;
    fltAbsOle: Double;
    strECarga: String;

    strPreVe1: String;
    strPreVe2: String;
    strPreVe3: String;
    strPreVe4: String;
    strPreVe5: String;
    strPreVe6: String;
    strPreVe7: String;
    strSeqGer: String;
    strDescri: String;
    qryConIte: TUniQuery;
    qryConCor: TUniQuery;
    qryConFas: TUniQuery;

    strAutoInc  : String;

    blnAltera: Boolean;
    strSeqAlt: String;

    intMaxSeqGer : Integer;
    fltTotPercen : Double;
    fltTotCusIte : Double;
    fltTotDensid : Double;

    //Usada somente no relatorio em excel
    strTabPreRel: String;

    //fltTotPer: Double; // total de percentual

    objOrdPro: TOrdProIndustrial;
    cdsGedAna : TZClient;

    objLiberacao : TLiberacao;

    function  fBuscaEstrutura( blnImportacao: Boolean ): String;
    procedure pCarregaItemAlteracao;

    procedure pAcertaSequencialItem;
    function  fRetDensidadeItem(strCodIte: String): Double;
    procedure pGeraExcel(blnPreCusRel, blnPreVenRel, blnRefereRel: Boolean; DataSet: TUniClientDataSet);

    function fPreVenTotal(dtsDados: TDataSet): Double;
    function fCustoTotal(dtsDados: TDataSet): Double;
    function fCustoTotalLT(dtsDados: TDataSet): Double;

    procedure pGeraPreVen(objExcel: TGeraExcel; blnRefere: Boolean);
    procedure pGeraPreCus(objExcel: TGeraExcel; blnRefere: Boolean);
    procedure pGeraNormal(objExcel: TGeraExcel; blnRefere: Boolean);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotaisVen(var Totais: TTotais; Dados: TDataSet);
    procedure pSomaTotaisCus(var Totais: TTotais; Dados: TDataSet);

    function  fRetornaPercentualRepresentacaoCusto(fltCusIte: Double): Double;
    procedure pAtualizaPorcentagemRepresentacaoCusto;
    procedure pTrocarSubstituirProduto;
    procedure pSubstituiOProdutoSelecionado(strCodIte, strDesIte, strRefere: String);

    Procedure pRetDadosFormula(strCodIte, strCodCor: String);

    procedure pCalcularTotaisProdutos;
    function fVerificaPermissaoDelEst: Boolean;
    function fSQLGedAna: String;
    procedure pCarregaEdicaoAnalise;
    procedure pFormataResultadoEsperadoAnalise(strTipRes: String);
    procedure pLimparDadosSubProduto;
    procedure pLimpaAnalise;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    procedure pGravaTemporaria(strSeqIte,
                               strCodIte,
                               strDescri,
                               strCodFas,
                               strDesFas: String;
                               fltQtdIte,
                               fltPerTol: Double;
                               intSeqGer: Integer);
  public
    blnConfirma: Boolean;
    strObs001: String;
    strObs002: String;
    strObs003: String;
    strObs004: String;
    strObs005: String;
    strObs006: String;
    strObs007: String;
    strComent: String;
    blnMPrPAg: Boolean; // Materia Prima e Produto a granel;
    { Public declarations }
  end;

implementation

uses SysUtils, untfuncoesSimples, untPesqAux, untObsEstrutura, untComentEstrutura,
  untGedMatInd, untOpcRelEstruturaIndustrial, untCfgRel, untConsultas, untSubsProdCadEstrIndus,
  untTypesSistema, untFuncFat, untPanelCxFormula, untPnlDadosFormula,
  untGerMatInd, OrdemProducaoIndustrial.Funcoes;

{$R *.dfm}


procedure TfrmCadEstruturasIndustrialDF.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryConIte, Key, arrSel,
                 True, nil, 'Consulta de Itens', '1', '', 0,
                 False, False, 0, cdrCodIte, '', False, '', '', True, False, False, '',
                 False, False, False, True) then
    Begin
      SelectNext(ActiveControl, True, True);
      //pHabilitaCampos;
      //pSetFocus(edtSubProduto);
      //pCarregaEstrutura;
    End;
  End;

end;

procedure TfrmCadEstruturasIndustrialDF.edtCodAnaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqAnalises(Self, edtCodAna, edtDesAna, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodAna, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.edtCodFasKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try

      If fPesqFases(Self, edtCodFas, edtDesFas, qryConFas, Key, arrSel) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadEstruturasIndustrial.edtCodFasKeyPress]');
      End;
    End;

  End;

end;

procedure TfrmCadEstruturasIndustrialDF.edtCorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtDesCor.Text) And (Not fEmptyStr(edtCor.Text))  Then
  Begin
    fMensagem('AVISO','Cor não encontrada.', ['&O K']);
    edtCor.Clear;
    pSetFocus(edtCor);
  End;


  If ( Not fEmptyStr(edtCor.Text) ) Then
  Begin
    pCarregaCor(qryConCor);
    if edtDataDesenvolvimento.Visible then
    begin
      edtDataDesenvolvimento.Date := VS_Date;
      pSetFocus(edtDataDesenvolvimento);
    end
    else
      pSetFocus(edtCodFormula);
  End;

end;

procedure TfrmCadEstruturasIndustrialDF.edtCorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCor : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqCores(Self, edtCor, edtDesCor, qryConCor, Key, arrCor) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.edtPesReaChange(Sender: TObject);
begin
  inherited;
  If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
  Begin
    pCalcularTotaisProdutos;
    pAtualizaPorcentagemRepresentacaoCusto;
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.edtProdutosExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;

  If ( Not fEmptyStr(edtProdutos.Text) ) Then
    pSetFocus(edtCor);
end;

procedure TfrmCadEstruturasIndustrialDF.pCarregaProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtProdutos.Text, '', False, False, True, False, False, False, True);
  With qryConsulta Do
  Begin
    edtDesProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtUnidade.Text    := qryConsulta.FieldByName('ITE_CODUNI').AsString;
    blnMPrPAg          := fEhMateriaPrimaEProdutoAGranel(qryConsulta.FieldByName('ITE_CODITE').AsString);

  End
end;

procedure TfrmCadEstruturasIndustrialDF.edtSubProdutoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try

      if fPesqItem(conIteSimples, Self, edtSubProduto, edtDesSubProduto, qryConIte, Key, arrSel, True,
                   nil, 'Consulta de Itens', '1',
                  '',0,False,False,0,cdrCodIte,'',False,'','',True,False, False,'',True) then
      Begin
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.edtSubProdutoKeyPress]');
      End;
    End;

  End;

end;

procedure TfrmCadEstruturasIndustrialDF.pCarregaSubProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtSubProduto.Text, '', False, False, True, False, False, False, False, True);
  With qryConsulta Do
  Begin
    strCusIte := fRetCustoItem(edtSubProduto.Text);
    fltDensid := fRetDensidadeItem(edtSubProduto.Text);
    strPreVe1 := fRetPreVenda1(edtSubProduto.Text);
    strPreVe2 := fRetPreVenda2(edtSubProduto.Text);
    strPreVe3 := fRetPreVenda3(edtSubProduto.Text);
    strPreVe4 := fRetPreVenda4(edtSubProduto.Text);
    strPreVe5 := fRetPreVenda5(edtSubProduto.Text);
    strPreVe6 := fRetPreVenda6(edtSubProduto.Text);
    strPreVe7 := fRetPreVenda7(edtSubProduto.Text);

    fltPerSol := qryConsulta.FieldByName('ITE_PERSOL').AsFloat;
    fltAbsOle := qryConsulta.FieldByName('ITE_ABSOLE').AsFloat;
    strECarga := qryConsulta.FieldByName('ITE_ECARGA').AsString;

    edtDesSubProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtSubReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtSubUnidade.Text    := qryConsulta.FieldByName('ITE_CODUNI').AsString;
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pDeletaTemporaria;
begin
  If cdsConsulta.Active Then
    cdsConsulta.EmptyDataSet;

  If cdsGedAna.Active Then
    cdsGedAna.EmptyDataSet;
end;

procedure TfrmCadEstruturasIndustrialDF.pgcResultadoAnaliseEnter(
  Sender: TObject);
begin
  inherited;
  if pgcResultadoAnalise.ActivePage = tbsIntervaloValores then
    pSetFocus(edtAnaMin)
  else
    pSetFocus(edtDescricaoResultadoAnalise)
end;

procedure TfrmCadEstruturasIndustrialDF.pgcFormulacaoEnter(Sender: TObject);
begin
  inherited;
  if pgcFormulacao.ActivePage = tbsFormula then
    pSetFocus(edtSubProduto)
  else
    pSetFocus(edtCodAna);
end;

procedure TfrmCadEstruturasIndustrialDF.pAcertaSequencialItem;
Var
  intRecNo : Integer;
  intSeqIte: Integer;
begin

  Try

    With cdsConsulta Do
    Begin
      intRecNo  := RecNo;
      intSeqIte := 0;

      DisableControls;
      First;

      While Not Eof Do
      Begin
        If (FieldByName('DMT_SEQUEN').AsInteger <> RecNo) Then
        Begin
          Edit;
          FieldByName('DMT_SEQUEN').AsInteger := RecNo;
          Post;
        End;

        If (Not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
        Begin
          Inc(intSeqIte);

          Edit;
          FieldByName('DMT_SEQITE').AsString := IntToStr(intSeqIte);
          Post;
        End;

        Next;
      End;

      RecNo := intRecNo;
      EnableControls;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCadEstruturasIndustrial.pAcertaSequencialItem]');
  End;

end;

procedure TfrmCadEstruturasIndustrialDF.pAtualizaPorcentagemRepresentacaoCusto;
var
  fltValor: Double;
  intRecNo: Integer;
begin
  pCalcularTotaisProdutos;
  intRecNo := 0;
  Try
    intRecNo := cdsConsulta.RecNo;
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If Not fEmptyStr(cdsConsulta.FieldByName('DMT_ITESUB').AsString) Then
      Begin
        cdsConsulta.Edit;

        cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat := fFormataFloat((( cdsConsulta.FieldByName('DMT_CUSITE').AsFloat * cdsConsulta.FieldByName('DMT_QTDITE').AsFloat)/100),4);
        cdsConsulta.FieldByName('DMT_CUS_LT').AsFloat := fFormataFloat((( cdsConsulta.FieldByName('DMT_CUSITE').AsFloat * cdsConsulta.FieldByName('DMT_QTDITE').AsFloat)/100) * fStrToFloat(edtPesRea.Text),4);

        fltValor := fRetornaPercentualRepresentacaoCusto(cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat);
        cdsConsulta.FieldByName('DMT_REPCUS').AsFloat := fFormataFloat(fltValor,2);

        cdsConsulta.Post;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
    cdsConsulta.RecNo := intRecNo;
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pAtualizaTemporaria(intPosicao: Integer);
begin
  With cdsConsulta Do
  Begin
    If (RecordCount > 0) And (RecordCount >= intPosicao) Then
      RecNo := intPosicao;

    (FieldByName('DMT_QTDITE') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;
    (FieldByName('DMT_CUSCAL') As TFloatField).DisplayFormat := '##0.0000';
    (FieldByName('DMT_REPCUS') As TFloatField).DisplayFormat := '##0.00';
    (FieldByName('DMT_PERTOL') As TFloatField).DisplayFormat := edtPerTol.EditFormat;
  End;

end;

function TfrmCadEstruturasIndustrialDF.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
Var
  blnRepEst: Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtProdutos) Then
    Begin

      If fEmptyStr(edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o código do produto!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaProduto(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código do produto não encontrado!',['&O K']);
          Result := False;
        End

        Else pRetDadosFormula(edtProdutos.Text, edtCor.Text);
      End;

    End
    Else

    If (Sender = edtSubProduto) Then
    Begin

      blnRepEst := fCfgSis('REPEST', varBoolean);

      If (fEmptyStr(edtSubProduto.Text)) Then
      Begin

        If (Not cdsConsulta.IsEmpty) Then
        Begin
          pSetFocus(dbgDados);
          blnMudarFoco := False;
        End
        Else
          Result := False;
      End
      Else If (edtSubProduto.Text = edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Sub. Produto não pode ser igual a Estrutura!',['&OK']);
        Result := False;
      End
      Else If (Not blnRepEst) And (Not blnAltera) And cdsConsulta.Locate('DMT_ITESUB', edtSubProduto.Text, []) Then
      Begin
        fMensagem('ATENÇÃO','Esse item já se encontra na estrutura!',['&O K']);
        Result := False;
      End
      Else
      Begin

        If Not fEmptyStr(edtSubProduto.Text) Then
          pCarregaSubProduto(qryConIte);

        If fEmptyStr(edtDesSubProduto.Text) And (Not fEmptyStr(edtSubProduto.Text))  Then
        Begin
          fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtSubQtdIte) Then
    Begin

      If Not fEmptyStr(edtSubProduto.Text) Then
      Begin

        If fEmptyStr(edtSubQtdIte.Text) Then
        Begin
          fMensagem('ATENÇÃO','Digite a quantidade do produto!',['&O K']);
          Result := False;
        End
        Else
        If fStrToFloat(edtSubQtdIte.Text) <= 0.00 Then
        Begin
          fMensagem('ATENÇÃO','A quantidade do produto deve ser maior que Zero !',['&O K']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtPerTol) Then
    Begin

      If fEmptyStr(edtPerTol.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o % de Tolerância do produto!',['&O K']);
        Result := False;
      End
      Else
      If fStrToFloat(edtPerTol.Text) < 0.00 Then
      Begin
        fMensagem('ATENÇÃO','O % de Tolerância deve ser maior ou igual a Zero !',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtSeq) Then
    Begin
      if (blnAltera) And fEmptyStr(EdtSeq.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Sequência deve ser Preenchida !',['&O K']);
        Result := False;
      End;

      pCalcularTotaisProdutos;

      if (blnAltera) And ( (StrToIntDef(EdtSeq.Text,0) <= 0) or (StrToIntDef(EdtSeq.Text,0) > intMaxSeqGer)) Then
      Begin
        fMensagem('ATENÇÃO','A Sequência deve estar entre 1 e ' + intToStr(intMaxSeqGer) + ' !',['&O K']);
        Result := False;
      End;



    End

    Else If (Sender = edtCor) Then
    Begin

      If fEmptyStr(edtCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite a Cor!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaCor(qryConCor);
        If qryConCor.FieldByName('COR_CODCOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código da cor não encontrado!',['&O K']);
          Result := False;
        End

        Else pRetDadosFormula(edtProdutos.Text, edtCor.Text);
      End;

      if Result And blnMPrPAg then
      Begin
        if fQuantidadeEstruturasProduto(edtProdutos.Text, edtCor.Text, 'GEDMAT') > 0 then
        Begin
          fMensagem('ATENÇÃO','Só é permitido cadastrar uma Cor para Estruturas de Classificação Matéria Prima e Produto a Granel !',['&O K']);
          Result := False;
        End;

      End;


    End

    Else If (Sender = edtCodFormula) Then
    Begin
      If blnValidaIndividual Then
      Begin
        If (fCarregaEstrutura) Then
        Begin
          pAtualizaTemporaria(1);
          pHabilitaCampos;
          pSetFocus(edtSubProduto);
          pnlProdutos.Enabled := False;
        End
        Else
          Result := False;
      End;

    End

    {*****************}
    {* VALIDA A FASE *}
    {**************PZ*}
    Else If (Sender = edtCodFas) Then
    Begin
      If (Not fEmptyStr(edtCodFas.Text)) Then
      Begin
        edtDesFas.Text := fRetDescricaoFase(edtCodFas.Text);

        If (fEmptyStr(edtDesFas.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Fase não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesFas.Clear;
    End

    Else If (Sender = edtPesRea) Then
    Begin

      If fStrToFloat(edtPesRea.Text) <= 0 Then
      Begin

        fMensagem('ATENÇÃO!', 'Informe o peso específico real!', ['&O k']);
        Result := False;

      End;

    End

    Else If (Sender = edtCodAna) And blnValidaIndividual Then
    Begin
      If Not fEmptyStr(edtCodAna.Text) Then
      Begin
        edtDesAna.Text := fCampoTabela('ANA_DESCRI', 'CADANA', ['ANA_CODANA'], [edtCodAna.Text]);
        If fEmptyStr(edtDesAna.Text) Then
          Result := fMensagem('', 'Código de Análise Inválido!', ['&OK']) = -1;
      End
      Else
      Begin
        edtCodAna.Clear;
        pSetFocus(dbgAnalise);
        blnMudarFoco := False;
      End;

      pFormataResultadoEsperadoAnalise(fCampoTabela('ANA_TIPRES', 'CADANA', ['ANA_CODANA'], [edtCodAna.Text]));
    End

    Else If (pgcResultadoAnalise.ActivePage = tbsIntervaloValores) and (Sender = edtAnaMin) And blnValidaIndividual Then
    Begin
      If fStrToFloat(edtAnaMin.Text) < 0 Then
      Begin
        Result := fMensagem('', 'O valor mínimo para análise deve ser maior ou igual a zero!', ['&OK']) = -1;
      End;

    End

    Else If (pgcResultadoAnalise.ActivePage = tbsIntervaloValores) and (Sender = edtAnaMax) And blnValidaIndividual Then
    Begin
      If fStrToFloat(edtAnaMax.Text) < 0 Then
      Begin
        Result := fMensagem('', 'O valor máximo para análise deve ser maior ou igual a zero!', ['&OK']) = -1;
      End
      Else
      If fStrToFloat(edtAnaMax.Text) < fStrToFloat(edtAnaMin.Text) Then
        Result := fMensagem('', 'O valor máximo deve ser maior ou igual ao valor mínimo!', ['&OK']) = -1;

    End

    Else If (pgcResultadoAnalise.ActivePage = tbsDescricaoAberta) and (Sender = edtDescricaoResultadoAnalise) And blnValidaIndividual Then
    Begin
      If fEmptyStr(edtDescricaoResultadoAnalise.Text) Then
      Begin
        Result := fMensagem('', 'Preencha a descrição do resultado esperado!', ['&OK']) = -1;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEstruturasIndustrialDF.FormCreate(Sender: TObject);
  Var
    intIndex : Integer;
begin
  inherited;

  objLiberacao := TLiberacao.Create;
  pgcFormulacao.ActivePageIndex := 0;

  edtSubQtdIte.EditFormat := fMskDigitos(3);
  edtSubQtdIte.Text       := FormatFloat(edtSubQtdIte.EditFormat, 0);

  objOrdPro := TOrdProIndustrial.Create(Self);

  //Analise
  cdsGedAna := TZClient.Create(Self, fSQLGedAna);
  dbgAnalise.DataSource := cdsGedAna.dtsSource;

  pnlCusLT.Visible := (fCfgSis('CUSCAD', varInteger) = 2);
  pnlCusLTOfi.Visible := pnlCusLT.Visible;
  If pnlCusLT.Visible Then
  Begin
    lblTotCusKG.Caption := 'Total Custo (KG)';
    lblCustoOfi.Caption := 'Total Custo (KG)';


    For intIndex := 0 to dbgDados.Columns.Count -1 Do
    Begin
      If dbgDados.Columns[intIndex].FieldName = 'DMT_CUSCAL' Then
        dbgDados.Columns[intIndex].Title.Caption := 'Custo (KG)'
      Else If dbgDados.Columns[intIndex].FieldName = 'DMT_CUS_LT' Then
        dbgDados.Columns[intIndex].Visible := True;
    End;
  End;

  edtPerTol.EditFormat := fMskDigitos(4);
  edtPerTol.Text       := FormatFloat(edtPerTol.EditFormat, 0);

  edtDataDesenvolvimento.Visible := fCfgSis('DTAFOR', varBoolean);
  lblDataDesenvolvimento.Visible := edtDataDesenvolvimento.Visible;

  pLimparDados;

end;

procedure TfrmCadEstruturasIndustrialDF.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsGedAna);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

Function TfrmCadEstruturasIndustrialDF.fSQLGedAna : String;
Begin
  Result := '';
  Result := Result + ' SELECT G.*, ANA_DESCRI, ANA_TIPRES,                       ';
  Result := Result + ' REPLACE( CASE ANA_TIPRES                                   ';
  Result := Result + '   WHEN 1 THEN CONCAT(  CAST(GAN_LIMMIN AS DECIMAL(12,2))  ';
  Result := Result + '                      , " a "                              ';
  Result := Result + '                      , CAST(GAN_LIMMAX AS DECIMAL(12,2))) ';
  Result := Result + '   WHEN 2 THEN GAN_DESRES                                  ';
  Result := Result + ' END,".",",") AS RESULTADOESPERADO                         ';
  Result := Result + ' FROM GEDANA G                                             ';
  Result := Result + '   INNER JOIN CADANA ON ANA_CODANA = GAN_CODANA            ';
  Result := Result + ' WHERE G.GAN_SEQGMT = :SEQGMT                              ';
End;

procedure TfrmCadEstruturasIndustrialDF.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    //pSetFocus(edtSubProduto);
    Exit;
  End;

  pCalcularTotaisProdutos;

  pGravaTemporaria(fRetSeqIte(StrToIntDef(edtSeq.text,0)),
                  edtSubProduto.Text,
                  edtDesSubProduto.Text,
                  edtCodFas.Text,
                  edtDesFas.Text,
                  fStrToFloat( edtSubQtdIte.Text ),
                  fStrToFloat( edtPerTol.Text ),
                  StrToIntDef(edtSeq.Text, 0));
  pLimparDadosSubProduto;

  pSetFocus(edtSubProduto);
  btnConfirma.Enabled   := True;
  btnImprimir.Enabled   := True;
  btnAtivaDesenvolvimento.Enabled := True;
  btnImpFor.Enabled     := True;
  btnComentario.Enabled := True;

  If (cdsConsulta.RecordCount > 1) Then
  Begin
    btnMoveCima.Enabled  := True;
    btnMoveBaixo.Enabled := True;
  End;

  blnAltera := False;
  strSeqAlt := '';
end;

function TfrmCadEstruturasIndustrialDF.fPreVenTotal(dtsDados: TDataSet): Double;
begin
  Result := dtsDados.FieldByName('DMT_QTDITE').AsFloat *
            dtsDados.FieldByName('ITE_PREVE' + strTabPreRel).AsFloat;
end;

function TfrmCadEstruturasIndustrialDF.fCustoTotal(dtsDados: TDataSet): Double;
begin
  Result := dtsDados.FieldByName('DMT_QTDITE').AsFloat *
            dtsDados.FieldByName('ITE_PRECUS').AsFloat / 100;
end;

function TfrmCadEstruturasIndustrialDF.fCustoTotalLT(dtsDados: TDataSet): Double;
Begin
  Result := (dtsDados.FieldByName('DMT_QTDITE').AsFloat *
             dtsDados.FieldByName('ITE_PRECUS').AsFloat / 100) * fStrToFloat(edtPesRea.Text);
End;

procedure TfrmCadEstruturasIndustrialDF.pGeraExcel(blnPreCusRel, blnPreVenRel,
  blnRefereRel: Boolean; DataSet: TUniClientDataSet);
var
  objExcel: TGeraExcel;
begin
  Try
    objExcel := TGeraExcel.Create(DataSet, nil);

    If blnPreVenRel Then
    Begin
      pGeraPreVen(objExcel,blnRefereRel);
      objExcel.OnSomaResumo  := pSomaTotaisVen;
    End
    Else If blnPreCusRel Then
    Begin
      pGeraPreCus(objExcel,blnRefereRel);
      objExcel.OnSomaResumo  := pSomaTotaisCus;
    End  
    Else
      pGeraNormal(objExcel,blnRefereRel);

    objExcel.strNomRel := 'CHECK LIST EXPEDIÇÃO';
    objExcel.AddFiltro('ESTRUTURA: ' + edtDesProduto.Text);

    If blnPreVenRel Or blnPreCusRel Then
      objExcel.OnMontaResumo := pMontaResumo;

    objExcel.fGerarRelatorio;
  Finally
    FreeAndNil(objExcel);
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pGeraNormal(objExcel: TGeraExcel;
  blnRefere: Boolean);
begin
  objExcel.AddCampo('DMT_QTDITE', 'QTD');
  If blnRefere Then
    objExcel.AddCampo('DMT_REFERE', 'ITEM')
  Else
    objExcel.AddCampo('DMT_DESCRI', 'ITEM');
  objExcel.AddCampo('FAS_DESFAS', 'FASE');
end;

procedure TfrmCadEstruturasIndustrialDF.pGeraPreCus(objExcel: TGeraExcel;
  blnRefere: Boolean);
begin
  If blnRefere Then
    objExcel.AddCampo('DMT_REFERE', 'ITEM')
  Else
    objExcel.AddCampo('DMT_DESCRI', 'ITEM');
  objExcel.AddCampo('FAS_DESFAS', 'FASE');
  objExcel.AddCampo('DMT_QTDITE', 'QTD. ITEM');
  objExcel.AddCampo('ITE_PRECUS', 'CUS. ITEM');

  If pnlCusLT.Visible Then
  Begin
    objExcel.AddCampo(fCustoTotal, 'CUSTO_TOTAL', 'CUS. TOTAL (KG)', 4);
    objExcel.AddCampo(fCustoTotalLT, 'CUSTO_TOTAL_LT', 'CUS. TOTAL (LT)', 4);
  End
  Else
    objExcel.AddCampo(fCustoTotal, 'CUSTO_TOTAL', 'CUS. TOTAL', 4);

  objExcel.AddCampo('ITE_PREMED', 'VLR. MEDIO');
  objExcel.AddCampo('ITE_DTAULT', 'ULT. COMPRA');
end;

procedure TfrmCadEstruturasIndustrialDF.pGeraPreVen(objExcel: TGeraExcel; blnRefere: Boolean);
begin
  If blnRefere Then
    objExcel.AddCampo('DMT_REFERE', 'ITEM')
  Else
    objExcel.AddCampo('DMT_DESCRI', 'ITEM');
  objExcel.AddCampo('FAS_DESFAS', 'FASE');
  objExcel.AddCampo('DMT_QTDITE', 'QTD');
  objExcel.AddCampo('ITE_PREVE' + strTabPreRel, 'VLR. ITEM');
  objExcel.AddCampo(fPreVenTotal, 'VENDA_TOTAL', 'VLR. TOTAL');
end;

procedure TfrmCadEstruturasIndustrialDF.pGravaTemporaria(strSeqIte,
                                                       strCodIte,
                                                       strDescri,
                                                       strCodFas,
                                                       strDesFas: String;
                                                       fltQtdIte,
                                                       fltPerTol : Double;
                                                       intSeqGer: Integer);
  Var
    intSequen: Integer;
    intRecNo : Integer;
    intNewIte: Integer;
    blnSeqIte: Boolean;
begin

  intNewIte := 0;

  If fEmptyStr(strCusIte) Then
    strCusIte := '0.00';

  If fEmptyStr(strPreVe1) Then
    strPreVe1 := '0.00';

  If fEmptyStr(strPreVe2) Then
    strPreVe2 := '0.00';

  If fEmptyStr(strPreVe3) Then
    strPreVe3 := '0.00';

  If fEmptyStr(strPreVe4) Then
    strPreVe4 := '0.00';

  If fEmptyStr(strPreVe5) Then
    strPreVe5 := '0.00';

  If fEmptyStr(strPreVe6) Then
    strPreVe6 := '0.00';

  If fEmptyStr(strPreVe7) Then
    strPreVe7 := '0.00';

  If (Not blnAltera) Then
  Begin
    With cdsConsulta Do
    Begin
      if (intSeqGer <= 0) Then
        intSequen := StrToIntDef(fRetSeqGer, 1)
      Else
        intSequen := intSeqGer;

      if (intSeqGer > 0) Then
      Begin
        //Avança os Itens Apos o intPos
        DisableControls;
        Last;
        While (FieldByName('DMT_SEQUEN').AsInteger >= intSequen) and (not Bof) Do
        Begin
          Edit;

          FieldByName('DMT_SEQUEN').AsInteger := FieldByName('DMT_SEQUEN').AsInteger + 1;
          If (StrToIntDef(FieldByName('DMT_SEQITE').AsString,0) > 0) and (not fEmptyStr(strSeqIte)) Then
          begin
            strSeqIte := FieldByName('DMT_SEQITE').AsString;
            FieldByName('DMT_SEQITE').AsInteger  := FieldByName('DMT_SEQITE').AsInteger + 1;
          end;

          Post;
          Prior;
        End;
        EnableControls;

      End;

      Insert;
      FieldByName('DMT_ITESUB').AsString  := strCodIte;
      FieldByName('DMT_SEQUEN').AsInteger := intSequen;
      FieldByName('DMT_SEQITE').AsString  := strSeqIte;
      FieldByName('DMT_CODEMP').AsString  := VS_strCodEmp;
      FieldByName('DMT_QTDITE').AsFloat   := fltQtdIte;
      FieldByName('DMT_CUSITE').AsFloat   := fStrToFloat(strCusIte);
      FieldByName('DMT_CUSCAL').AsFloat   := fFormataFloat(((fStrToFloat(strCusIte) * fltQtdIte)/100),4);
      FieldByName('DMT_DENSID').AsFloat   := fltDensid;

      FieldByName('ITE_PERSOL').AsFloat   := fltPerSol;
      FieldByName('ITE_ABSOLE').AsFloat   := fltAbsOle;
      FieldByName('ITE_ECARGA').AsString  := strECarga;

      FieldByName('ITE_PREVE1').AsFloat   := fStrToFloat(strPreVe1);
      FieldByName('ITE_PREVE2').AsFloat   := fStrToFloat(strPreVe2);
      FieldByName('ITE_PREVE3').AsFloat   := fStrToFloat(strPreVe3);
      FieldByName('ITE_PREVE4').AsFloat   := fStrToFloat(strPreVe4);
      FieldByName('ITE_PREVE5').AsFloat   := fStrToFloat(strPreVe5);
      FieldByName('ITE_PREVE6').AsFloat   := fStrToFloat(strPreVe6);
      FieldByName('ITE_PREVE7').AsFloat   := fStrToFloat(strPreVe7);
      FieldByName('DMT_SEQGER').AsInteger := 1;
      FieldByName('DMT_PERTOL').AsFloat   := fltPerTol;

      If Not fEmptyStr(strCodIte) Then
        FieldByName('DMT_DESCRI').AsString  := edtDesSubProduto.Text
      Else
        FieldByName('DMT_DESCRI').AsString  := strDescri;

      FieldByName('DMT_REFERE').AsString  := edtSubReferencia.Text;

      FieldByName('DMT_CODFAS').AsString  := strCodFas;
      FieldByName('FAS_DESFAS').AsString  := strDesFas;

      Post;
      pAtualizaPorcentagemRepresentacaoCusto;
    End;
  End
  Else
  Begin
    pCalcularTotaisProdutos;

    if (intSeqGer <= 0) or (intSeqGer > intMaxSeqGer) Then
    Begin
      fMensagem('ATENÇÃO','A Sequência deve estar entre 1 e ' + intToStr(intMaxSeqGer) + ' !',['&O K']);
      Abort;
    End;

    cdsConsulta.IndexFieldNames := '';
    If (cdsConsulta.Locate('DMT_SEQUEN', strSeqAlt, [])) Then
    Begin
      blnSeqIte := not fEmptyStr(cdsConsulta.FieldByName('DMT_SEQITE').AsString); // So Organiza Seq. Materia Prima se movimentar a Seq. de Materia Prima, se não mantem ordem.
      With cdsConsulta Do
      Begin
        if (intSeqGer > 0) and (intSeqGer <> StrToIntDef(strSeqAlt,0)) Then
        Begin
          DisableControls;
          intNewIte := 1;
          intRecNo := RecNo;
          First;

          if intSeqGer < StrToIntDef(strSeqAlt,0) Then
          Begin
            While (not Eof) Do
            Begin
              If (FieldByName('DMT_SEQUEN').AsInteger >= intSeqGer)
                 and (FieldByName('DMT_SEQUEN').AsInteger < StrToIntDef(strSeqAlt,0)) Then
              Begin
                Edit;
                FieldByName('DMT_SEQUEN').AsInteger := FieldByName('DMT_SEQUEN').AsInteger + 1;

                if blnSeqIte and (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  FieldByName('DMT_SEQITE').AsInteger := FieldByName('DMT_SEQITE').AsInteger + 1;
                Post;

              End
              Else
                If (FieldByName('DMT_SEQUEN').AsInteger <= intSeqGer)
                   And (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  intNewIte := FieldByName('DMT_SEQITE').AsInteger + 1;

              Next;
            End;

          End
          else
          begin
            While (Not Eof) Do
            Begin
              If (FieldByName('DMT_SEQUEN').AsInteger <= intSeqGer)
                 and (FieldByName('DMT_SEQUEN').AsInteger >= StrToIntDef(strSeqAlt,0)) Then
              Begin
                Edit;
                FieldByName('DMT_SEQUEN').AsInteger := FieldByName('DMT_SEQUEN').AsInteger - 1;

                if blnSeqIte and (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  FieldByName('DMT_SEQITE').AsInteger := FieldByName('DMT_SEQITE').AsInteger - 1;
                Post;

                if (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  intNewIte := FieldByName('DMT_SEQITE').AsInteger + 1;

              End;

              Next;
            End;

          End;
          RecNo := intRecNo;
          EnableControls;
        end;


        cdsConsulta.Edit;

        if (intSeqGer > 0) And (intSeqGer <> StrToIntDef(strSeqAlt,0)) Then
        Begin
          cdsConsulta.FieldByName('DMT_SEQUEN').AsInteger := intSeqGer;
          If not fEmptyStr(cdsConsulta.FieldByName('DMT_SEQITE').AsString) Then
            cdsConsulta.FieldByName('DMT_SEQITE').AsInteger := intNewIte;
        End;

        cdsConsulta.FieldByName('DMT_DESCRI').AsString  := strDescri;
        cdsConsulta.FieldByName('DMT_QTDITE').AsFloat  := fltQtdIte;
        cdsConsulta.FieldByName('DMT_DENSID').AsFloat  := fltDensid;
        cdsConsulta.FieldByName('DMT_CODFAS').AsString := strCodFas;

        cdsConsulta.FieldByName('ITE_PERSOL').AsFloat   := fltPerSol;
        cdsConsulta.FieldByName('ITE_ABSOLE').AsFloat   := fltAbsOle;
        cdsConsulta.FieldByName('ITE_ECARGA').AsString  := strECarga;

        cdsConsulta.FieldByName('FAS_DESFAS').AsString := strDesFas;
        cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat  := fFormataFloat(((fStrToFloat(strCusIte) * fltQtdIte)/100),4);
        cdsConsulta.FieldByName('DMT_PERTOL').AsFloat  := fltPerTol;
        cdsConsulta.Post;

        pAtualizaPorcentagemRepresentacaoCusto;

      End;
    End;
    cdsConsulta.IndexFieldNames := 'DMT_SEQUEN';
    cdsConsulta.Locate('DMT_SEQUEN', intSeqGer, []);

  End;

  cdsConsulta.AggregatesActive := False;
  cdsConsulta.AggregatesActive := True;  

end;

procedure TfrmCadEstruturasIndustrialDF.pLimparDados;
begin

  dbgDados.Refresh;
  pnlProdutos.Enabled    := True;
  pnlSubProdutos.Enabled := False;
  edtProdutos.ReadOnly   := False;
  edtProdutos.Clear;
  pSetFocus(edtProdutos);
  edtReferencia.Clear;
  edtUnidade.Clear;
  edtDesProduto.Clear;
  edtCor.ReadOnly        := False;
  edtCor.Clear;
  edtDesCor.Clear;
  edtCodFormula.ReadOnly := False;
  edtCodFormula.Clear;
  dbgAnalise.Enabled     := False;
  pnlAnalises.Enabled    := False;
  edtDataDesenvolvimento.Clear;

  edtPesRea.ReadOnly     := False;
  edtPesRea.Clear;

  dbgDados.Enabled       := False;
  btnConfirma.Enabled    := False;
  btnApaga.Enabled       := False;
  btnImprimir.Enabled    := False;
  btnAtivaDesenvolvimento.Enabled := False;
  btnImpFor.Enabled      := False;
  btnEstrutura.Enabled   := True;
  btnComentario.Enabled  := False;
  btnMoveCima.Enabled    := False;
  btnMoveBaixo.Enabled   := False;
  btnSubstituir.Enabled  := False;

  strObs001 := '';
  strObs002 := '';
  strObs003 := '';
  strObs004 := '';
  strObs005 := '';
  strObs006 := '';
  strObs007 := '';

  pDeletaTemporaria;
  pCalcularTotaisProdutos;
  pLimparDadosSubProduto;

  pgcFormulacao.ActivePageIndex := 0;
  
end;

procedure TfrmCadEstruturasIndustrialDF.pLimparDadosSubProduto;
begin
  edtSubProduto.Clear;
  edtDesSubProduto.Clear;
  edtSubReferencia.Clear;
  edtSubUnidade.Clear;
  edtSubQtdIte.Clear;
  edtCodFas.Clear;
  edtDesFas.Clear;
  edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, 0);
  edtPerTol.Text    := FormatFloat(edtSubQtdIte.EditFormat, 0);
  strSeqGer         := '';
  edtSeq.Text       := '';
end;

procedure TfrmCadEstruturasIndustrialDF.pMontaResumo(Excel: TExcel;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    Escrever(ProximaLinha, 04, 'TOTAL GERAL');
    Alinhamento(LinhaAtual, 04, Direita);

    Escrever(LinhaAtual,   05, Quebra.Totais['fltTotPro']);
    If pnlCusLT.Visible Then
      Escrever(LinhaAtual,   06, Quebra.Totais['fltTotProLT']);

    FormatoNumerico(LinhaAtual, 05, '#.##0,0000');
    FormatoNumerico(LinhaAtual, 06, '#.##0,0000');

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pSomaTotaisCus(var Totais: TTotais;
  Dados: TDataSet);
begin
  With Dados Do
  Begin
    Totais['fltTotPro'] := Totais['fltTotPro'] + (FieldByName('DMT_QTDITE').AsFloat * FieldByName('ITE_PRECUS').AsFloat / 100);
    Totais['fltTotProLT'] := Totais['fltTotProLT'] + ((FieldByName('DMT_QTDITE').AsFloat * FieldByName('ITE_PRECUS').AsFloat / 100) * fStrToFloat(edtPesRea.Text));
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pSomaTotaisVen(var Totais: TTotais;
  Dados: TDataSet);
begin
  With Dados Do
  Begin
    Totais['fltTotPro'] := Totais['fltTotPro'] + (FieldByName('DMT_QTDITE').AsFloat *
    FieldByName('ITE_PREVE' + strTabPreRel).AsFloat);
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pSubstituiOProdutoSelecionado(
  strCodIte, strDesIte, strRefere: String);
var
  strIteCus: String;
  fltIteQtd: Double;
  intRecNo : Integer;
begin
  strIteCus := fRetCustoItem(strCodIte);
  fltIteQtd := cdsConsulta.FieldByName('DMT_QTDITE').AsFloat;
  intRecNo  := cdsConsulta.RecNo;

  With cdsConsulta Do
  Begin
    Edit;
    FieldByName('DMT_ITESUB').AsString  := strCodIte;
    FieldByName('DMT_CODEMP').AsString  := VS_strCodEmp;
    FieldByName('DMT_CUSITE').AsFloat   := fStrToFloat(strIteCus);
    FieldByName('DMT_CUSCAL').AsFloat   := fFormataFloat(((fStrToFloat(strIteCus) * fltIteQtd)/100),4);
    FieldByName('DMT_DENSID').AsFloat   := fRetDensidadeItem(strCodIte);
    FieldByName('ITE_PREVE1').AsFloat   := fStrToFloat(fRetPreVenda1(strCodIte));
    FieldByName('ITE_PREVE2').AsFloat   := fStrToFloat(fRetPreVenda2(strCodIte));
    FieldByName('ITE_PREVE3').AsFloat   := fStrToFloat(fRetPreVenda3(strCodIte));
    FieldByName('ITE_PREVE4').AsFloat   := fStrToFloat(fRetPreVenda4(strCodIte));
    FieldByName('ITE_PREVE5').AsFloat   := fStrToFloat(fRetPreVenda5(strCodIte));
    FieldByName('ITE_PREVE6').AsFloat   := fStrToFloat(fRetPreVenda6(strCodIte));
    FieldByName('ITE_PREVE7').AsFloat   := fStrToFloat(fRetPreVenda7(strCodIte));
    FieldByName('DMT_DESCRI').AsString  := strDesIte;
    FieldByName('DMT_REFERE').AsString  := strRefere;
    Post;

    pAtualizaPorcentagemRepresentacaoCusto;

    cdsConsulta.RecNo := intRecNo;
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pTrocarSubstituirProduto;
  Var
    frmSubsProdCadEstrIndus: TfrmSubsProdCadEstrIndus;
begin
  Try
    pCriarFormularios(TfrmSubsProdCadEstrIndus, frmSubsProdCadEstrIndus);
    frmSubsProdCadEstrIndus.edtProSel.Text    := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
    frmSubsProdCadEstrIndus.edtDesProSel.Text := cdsConsulta.FieldByName('DMT_DESCRI').AsString;
    frmSubsProdCadEstrIndus.ShowModal;
    If frmSubsProdCadEstrIndus.blnConfirma Then
      pSubstituiOProdutoSelecionado(frmSubsProdCadEstrIndus.edtProSub.Text,
                                    frmSubsProdCadEstrIndus.edtDesProSub.Text,
                                    frmSubsProdCadEstrIndus.edtProSubRef.Text);
  Finally
    FreeAndNil(frmSubsProdCadEstrIndus);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetCustoItem(strCodIte:String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try

    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PRECUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      OPen;
      Result := FieldByName('ITE_PRECUS').AsString;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function TfrmCadEstruturasIndustrialDF.fRetDensidadeItem(strCodIte:String): Double;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try

    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_DENSID ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      OPen;
      Result := FieldByName('ITE_DENSID').AsFloat;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function TfrmCadEstruturasIndustrialDF.fRetornaPercentualRepresentacaoCusto(fltCusIte: Double): Double;
begin
  Result := 0;
  If fltTotCusIte > 0 Then
    Result := ((fltCusIte * 100) / fltTotCusIte);
end;

function TfrmCadEstruturasIndustrialDF.fRetPreVenda1(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE1 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE1').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetPreVenda2(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE2 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE2').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetPreVenda3(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE3 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE3').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetPreVenda4(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE4 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE4').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetPreVenda5(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE5 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE5').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetPreVenda6(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE6 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE6').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetPreVenda7(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE7 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE7').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrialDF.fRetSeqGer: String;
begin
  pCalcularTotaisProdutos;

  With cdsConsulta Do
  Begin
    Result := IntToStr(intMaxSeqGer + 1);
  End;

end;

function TfrmCadEstruturasIndustrialDF.fRetSeqIte(intSeqGer :  Integer): String;
var
  intSeqIte: Integer;
  intSeqTmp: Integer;
  intRecNo : Integer;
begin
  With cdsConsulta Do
  Begin
    intRecNo  := RecNo;

    DisableControls;
    First;

    If (Not IsEmpty) Then
    Begin
      If fEmptyStr(FieldByName('DMT_SEQITE').AsString) Then
        intSeqIte := 0
      Else
        intSeqIte := FieldByName('DMT_SEQITE').AsInteger
    End Else
      intSeqIte := 0;

    While Not Eof Do
    Begin
      if (intSeqGer = 0) or (intSeqGer <= FieldByName('DMT_SEQUEN').AsInteger) Then
      Begin
        intSeqTmp := StrToIntDef(FieldByName('DMT_SEQITE').AsString, 0);

        If (intSeqIte < intSeqTmp) Then
          intSeqIte := intSeqTmp;
      End;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;

    if (intSeqGer = 0) Then
      Result := intToStr(intSeqIte + 1)
    Else
      Result := intToStr(intSeqIte);
      
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pHabilitaCampos;
begin
  pnlSubProdutos.Enabled := True;
  dbgDados.Enabled       := True;
  dbgAnalise.Enabled     := True;
  pnlAnalises.Enabled    := True;
  pnlProdutos.Enabled    := False;
  btnEstrutura.Enabled   := False;
end;

procedure TfrmCadEstruturasIndustrialDF.btnCancelaAnaliseClick(Sender: TObject);
begin
  inherited;
  pLimpaAnalise;
end;

procedure TfrmCadEstruturasIndustrialDF.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparDadosSubProduto;
  pSetFocus(edtSubProduto);

  blnAltera := False;
  strSeqAlt := '';
end;

procedure TfrmCadEstruturasIndustrialDF.btnEstruturaClick(Sender: TObject);
begin
  fBuscaEstrutura( False );
end;

procedure TfrmCadEstruturasIndustrialDF.pDeletaItem;
begin
  Try

    If blnAltera Then
      Exit;

    If Not cdsConsulta.IsEmpty Then
    Begin
      cdsConsulta.Delete;
      pAcertaSequencialItem;
    End;

    pCalcularTotaisProdutos;    

    If cdsConsulta.IsEmpty Then
    Begin
      btnConfirma.Enabled   := False;
      btnImprimir.Enabled   := False;
      btnAtivaDesenvolvimento.Enabled := False;
      btnImpFor.Enabled     := False;
      btnComentario.Enabled := False;
      btnMoveCima.Enabled   := False;
      btnMoveBaixo.Enabled  := False;
      btnSubstituir.Enabled := False;
    End;
  Finally

  End;

end;

procedure TfrmCadEstruturasIndustrialDF.dbgAnaliseDblClick(Sender: TObject);
begin
  inherited;
  pCarregaEdicaoAnalise;
end;

procedure TfrmCadEstruturasIndustrialDF.dbgAnaliseKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = []) Then
  Begin
    If (Key = VK_DELETE) Then
    Begin
      If fMensagem('', 'Deseja Remover essa Análise?', ['&Sim', '&Não']) = 1 Then
      Begin
        cdsGedAna.Delete;
      End;
      Key := 0;
    End

    Else If (key = VK_RETURN) Then
    Begin
      pCarregaEdicaoAnalise;
      Key := 0;
    End;

  End;
end;

procedure TfrmCadEstruturasIndustrialDF.pCarregaEdicaoAnalise;
Begin
  pFormataResultadoEsperadoAnalise(cdsGedAna.FieldByName('ANA_TIPRES').AsString);

  edtCodAna.Text := cdsGedAna.FieldByName('GAN_CODANA').AsString;
  edtDesAna.Text := cdsGedAna.FieldByName('ANA_DESCRI').AsString;
  edtAnaMin.Text := FormatFloat(edtAnaMin.EditFormat, cdsGedAna.FieldByName('GAN_LIMMIN').AsFloat);
  edtAnaMax.Text := FormatFloat(edtAnaMax.EditFormat, cdsGedAna.FieldByName('GAN_LIMMAX').AsFloat);
  edtDescricaoResultadoAnalise.Text := cdsGedAna.FieldByName('GAN_DESRES').AsString;
  pSetFocus(edtCodAna);
End;

procedure TfrmCadEstruturasIndustrialDF.pFormataResultadoEsperadoAnalise(strTipRes : String);
begin
  case TTipoResultadoAnalise(StrToIntDef(strTipRes, 1)) Of
    traNull, traIntervaloValores :
    begin
      pgcResultadoAnalise.ActivePage := tbsIntervaloValores;
      edtDescricaoResultadoAnalise.Clear;

      if cdsGedAna.State in [dsEdit, dsInsert] then
        cdsGedAna.FieldByName('GAN_DESRES').Clear;

    end;
    traDescricaoAberta :
    begin

      pgcResultadoAnalise.ActivePage := tbsDescricaoAberta;
      edtAnaMin.clear;
      edtAnaMax.clear;

      if cdsGedAna.State in [dsEdit, dsInsert] then
      begin
        cdsGedAna.FieldByName('GAN_LIMMIN').clear;
        cdsGedAna.FieldByName('GAN_LIMMAX').clear;
      end;

    end;
  end;
end;

procedure TfrmCadEstruturasIndustrialDF.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnCancelaItem.Click;
  End
  Else If (Key = VK_Return) Then
  Begin
    pCarregaItemAlteracao;
  End
  Else If (Key = VK_Delete) Then
  Begin
    pDeletaItem;
  End
(*
  Else If (Key = VK_Prior) Then
  Begin
    Key := 0;
    btnMoveCima.Click;
  End
  Else If (Key = VK_Next) Then
  Begin
    Key := 0;
    btnMoveBaixo.Click;
  End;
  *)
end;

procedure TfrmCadEstruturasIndustrialDF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;

  FreeAndNil(qryConCor);
end;

procedure TfrmCadEstruturasIndustrialDF.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (ActiveControl.Parent = pnlSubProdutos) Then
  Begin

    Key := 0;

    If ( fMensagem( '', 'Cancela edição da Estrutura?', ['&Sim', '&Não'], 2 ) = 2 ) Then
      Exit;

    pLimparDados;
  End;

  inherited;

  If btnEstrutura.Enabled Then
  Begin
    If (Key = VK_F3) Then
      btnEstrutura.Click;
  End;

  If btnImprimir.Enabled Then
  Begin
    If (Key = VK_F5) Then
      btnImprimir.Click;
  End;

  If btnSubstituir.Enabled Then
  Begin
    If (Key = VK_F6) Then
      btnSubstituir.Click;
  End;

  If btnComentario.Enabled Then
  Begin
    If (Key = VK_INSERT) Then
      btnComentario.Click;
  End;

  If btnConfirma.Enabled Then
  Begin
    If (Key = VK_F10) Then
      btnConfirma.Click;
  End;

  If btnApaga.Enabled Then
  Begin

    If (Key = VK_F2) Then
    Begin
      btnApaga.Click;
      Key := 0;
    End;

  End;

  If (Key = VK_RETURN) And (ActiveControl Is TRadioButton) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadEstruturasIndustrialDF.btnConfirmaAnaliseClick(
  Sender: TObject);
begin
  If not fValidaPanel(pnlAnalises, True) Then
    Exit;

  If not fValidaCampos(edtDescricaoResultadoAnalise, True) Then
    Exit;


  If cdsGedAna.Locate('GAN_CODANA', edtCodAna.Text, []) Then
    cdsGedAna.Edit
  Else
    cdsGedAna.Append;

  cdsGedAna.FieldByName('GAN_CODANA').AsString := edtCodAna.Text;
  cdsGedAna.FieldByName('ANA_DESCRI').AsString := edtDesAna.Text;
  cdsGedAna.FieldByName('GAN_LIMMIN').AsFloat  := fStrToFloat(edtAnaMin.Text);
  cdsGedAna.FieldByName('GAN_LIMMAX').AsFloat  := fStrToFloat(edtAnaMax.Text);
  cdsGedAna.FieldByName('GAN_DESRES').AsString := edtDescricaoResultadoAnalise.Text ;

  If pgcResultadoAnalise.ActivePage = tbsIntervaloValores then
    cdsGedAna.FieldByName('RESULTADOESPERADO').AsString :=   FormatFloat('#,##0.00', cdsGedAna.FieldByName('GAN_LIMMIN').AsFloat)
                                                           + ' a '
                                                           + FormatFloat('#,##0.00', cdsGedAna.FieldByName('GAN_LIMMAX').AsFloat)
  else
    cdsGedAna.FieldByName('RESULTADOESPERADO').AsString := cdsGedAna.FieldByName('GAN_DESRES').AsString;

  cdsGedAna.Post;

  pLimpaAnalise;
end;

procedure TfrmCadEstruturasIndustrialDF.pLimpaAnalise;
Begin
  edtCodAna.Clear;
  edtDesAna.Clear;
  edtAnaMin.Text := '0,00';
  edtAnaMax.Text := '0,00';
  edtDescricaoResultadoAnalise.Clear;
  pSetFocus(edtCodAna);
End;

procedure TfrmCadEstruturasIndustrialDF.btnConfirmaClick(Sender: TObject);
Begin
  inherited;
  pGravar(False);
End;

procedure TfrmCadEstruturasIndustrialDF.pGravar(blnImpressao: Boolean);
  Var
    strSQL: String;
    qryGerMat : TUniQuery;
    intSequen: Integer;
    strCodFormulacao: String;
    fltTotPer: Double;
begin
  If Not fValidaCampos(edtPesRea, True) Then
    Exit;

  pCalcularTotaisProdutos;    

  strCodFormulacao := '';

  fltTotPer := fFormataFloat(fltTotPercen, 3);

  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 subproduto!', ['&Ok']);
    Exit;
  End;

  If (((fltTotPer > 0) And (fltTotPer < 100)) Or ((fltTotPer > 0) And (fltTotPer > 100))) then
  Begin
    fMensagem('ATENÇÃO!', 'O percentual total dos Sub. Produtos tem que fechar ' +
                          'em 100% !', ['&Ok']);
    Exit;
  End;

  Try

    If Not blnImpressao Then
    Begin
      pCriarFormularios(TfrmObsEstrutura, frmObsEstrutura);

      frmObsEstrutura.edtObs01.Text := strObs001;
      frmObsEstrutura.edtObs02.Text := strObs002;
      frmObsEstrutura.edtObs03.Text := strObs003;
      frmObsEstrutura.edtObs04.Text := strObs004;
      frmObsEstrutura.edtObs05.Text := strObs005;
      frmObsEstrutura.edtObs06.Text := strObs006;
      frmObsEstrutura.edtObs07.Text := strObs007;

      frmObsEstrutura.ShowModal;

      blnConfirma := frmObsEstrutura.blnConfirma;

      If blnConfirma Then
      Begin
        strObs001 := frmObsEstrutura.edtObs01.Text;
        strObs002 := frmObsEstrutura.edtObs02.Text;
        strObs003 := frmObsEstrutura.edtObs03.Text;
        strObs004 := frmObsEstrutura.edtObs04.Text;
        strObs005 := frmObsEstrutura.edtObs05.Text;
        strObs006 := frmObsEstrutura.edtObs06.Text;
        strObs007 := frmObsEstrutura.edtObs07.Text;
      End;

      pFreeAndNil(frmObsEstrutura);
    End

    Else blnConfirma := True;

    if blnMPrPAg Then
      pGravaAGranelComoAcabado(edtProdutos.Text, edtCor.Text);

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.btnConfirmaClick]');
    End;
  End;


  {********************************************}
  {* VERIFICA SE A ESTRUTURA EXISTE NO BANCO  *}
  {* SE EXISTIR APAGA                         *}
  {*****************************************LB*}

  If blnConfirma Then
  Begin
    Try
      fStartTransaction;

      strCodFormulacao := edtCodFormula.Text;

      If Not fEmptyStr(strCodFormulacao) Then
      Begin
        Try
          qryGerMat := fCriaQuery(Self);

          strSQL := '';
          strSQL := strSQL + 'DELETE FROM ';
          strSQL := strSQL + '  GEDMAT ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  GMT_CODITE = :CODITE AND ';
          strSQL := strSQL + '  GMT_CODCOR = :CODCOR AND ';
          strSQL := strSQL + '  GMT_FORMUL = :CODFOR ';

          With qryGerMat Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODITE').AsString := edtProdutos.Text;
            ParamByName('CODCOR').AsString := edtCor.Text;
            ParamByName('CODFOR').AsString := strCodFormulacao;
            ExecSQL;
            Close;
          End;

        Finally
          FreeAndNil(qryGerMat);
        End;
      End;

      {***********************************}
      {* EFETUA A GRAVAÇÃO NO BANCO      *}
      {********************************LB*}
      fGravaGedMat(strAutoInc,
                   VS_strCodEmp,
                   edtProdutos.Text,
                   edtCor.Text,
                   strCodFormulacao,
                   edtReferencia.Text,
                   strObs001,
                   strObs002,
                   strObs003,
                   strObs004,
                   'A',
                   fStrToFloat(edtPesRea.Text),
                   strObs005,
                   strObs006,
                   strObs007,
                   edtDataDesenvolvimento.Date);

      edtCodFormula.Text := strCodFormulacao;

      With cdsConsulta Do
      Begin
        intSequen := 0;
        DisableControls;
        First;
        While Not (Eof) Do
        Begin
          If fEmptyStr(FieldByName('DMT_ITESUB').AsString) Then
            strDescri := FieldByName('DMT_DESCRI').AsString
          Else
            strDescri := '';

          intSequen := intSequen + 1;
          fGravaDedMat(strAutoInc,
                       intSequen,
                       FieldByName('DMT_SEQITE').AsString,
                       VS_strCodEmp,
                       FieldByName('DMT_ITESUB').AsString,
                       strDescri,
                       FieldByName('DMT_DESPCA').AsString,
                       FieldByName('DMT_QTDITE').AsFloat,
                       FieldByName('DMT_PERTOL').AsFloat,
                       FieldByName('DMT_CODFAS').AsString);

          Next;
        End;
      End;

      fGravaGedAna(strAutoInc, cdsGedAna);

      fCommit;

      If Not blnImpressao Then
        fMensagem('Informação!','Fórmula : ' + edtCodFormula.Text + #13#10 +
                                'Produto Estrutura : ' + edtProdutos.Text + ' - ' + edtDesProduto.Text + #13#10 +
                                'incluída com sucesso!',['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[frmCadEstruturasIndustrialDF.btnConfirmaClick]');
      End;
    End;

    If Not blnImpressao Then
    Begin
      cdsConsulta.Close;
      pLimparDados;
    End;

  End;

  cdsConsulta.EnableControls;
end;

procedure TfrmCadEstruturasIndustrialDF.btnComentarioClick(Sender: TObject);
begin
  inherited;
  Try

    If (blnAltera) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido inserir comentários em modo de alteração!', ['&O k']);
      Exit;
    End;

    pCriarFormularios(TfrmComentEstrutura,frmComentEstrutura);
    frmComentEstrutura.blnIndustrial  := True;
    frmComentEstrutura.edtComentario.MaxLength := 100;
    frmComentEstrutura.edtComentario.TamCampo  := 100;
    frmComentEstrutura.ShowModal;

    blnConfirma := frmComentEstrutura.blnConfirma;


    If blnConfirma Then
    Begin
      strComent := frmComentEstrutura.edtComentario.Text;
      pGravaTemporaria('', '', strComent,
                       frmComentEstrutura.edtCodFas.Text,
                       frmComentEstrutura.edtDesFas.Text,
                       0.00,
                       0.00,
                       StrToIntDef(frmComentEstrutura.edtSeq.Text,0));
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.btnComentarioClick]');
    End;
  End;

  pFreeAndNil(frmComentEstrutura);

end;

procedure TfrmCadEstruturasIndustrialDF.pCarregaCor(qryConsulta: TUniQuery);
begin
  pPesquisaCadCor(qryConsulta, qryConsulta, edtCor.Text);
  With qryConsulta Do
  Begin
    edtDesCor.Text := qryConsulta.FieldByName('COR_DESCOR').AsString;
  End
end;

function TfrmCadEstruturasIndustrialDF.fCarregaEstrutura: Boolean;
  Var
    strSQL: String;
    blnImpEstrutura: Boolean;
    strCodIte: String;
    strCodCor: String;
    strCodFor: String;
    qryGerMat : TUniQuery;
    strEstrutura: String;

  procedure pCarregaAnalise(strSeqGmt : String);
  begin
    cdsGedAna.qryQuery.Close;
    cdsGedAna.qryQuery.ParamByName('SEQGMT').AsString := strSeqGmt;
    cdsGedAna.fAbreClient(True, 'TfrmCadEstruturasIndustrial.fCarregaEstrutura');

    (cdsGedAna.FieldByName('GAN_LIMMIN') As TFloatField).DisplayFormat := edtAnaMin.EditFormat;
    (cdsGedAna.FieldByName('GAN_LIMMAX') As TFloatField).DisplayFormat := edtAnaMax.EditFormat;
  end;
begin
  Result := False;

  blnImpEstrutura := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT  ';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  GMT_CODITE, ';
  strSQL := strSQL + '  GMT_STATUS,  ';
  strSQL := strSQL + '  GMT_DTAFOR  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GEDMAT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GMT_CODITE = :CODITE AND ';
  strSQL := strSQL + '  GMT_CODCOR = :CODCOR AND ';
  strSQL := strSQL + '  GMT_FORMUL = :CODFOR ';

  Try
    qryGerMat := fCriaQuery(Self);

    With qryGerMat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtProdutos.Text;
      ParamByName('CODCOR').AsString := edtCor.Text;
      ParamByName('CODFOR').AsString := edtCodFormula.Text;
      Open;

      pCarregaAnalise(FieldByName('AUTOINCREM').AsString);
      If IsEmpty Then
      Begin

        If (Not fEmptyStr(edtCodFormula.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa formula não está cadastrada!', ['&O k']);
          Exit;
        end;

        btnApaga.Enabled := False;
        blnImpEstrutura  := True;

        strAutoInc := '';

        if edtDataDesenvolvimento.Visible and (DateTimeToUnix(edtDataDesenvolvimento.Date) <= 0 ) then
          edtDataDesenvolvimento.Date := VS_Date;
      End
      Else
      Begin
        btnApaga.Enabled := True;

        strAutoInc := FieldByName('AUTOINCREM').AsString;

        if edtDataDesenvolvimento.Visible then
        begin
          if FieldByName('GMT_DTAFOR').AsDateTime > 0  then
            edtDataDesenvolvimento.Date :=  FieldByName('GMT_DTAFOR').AsDateTime
          else
            edtDataDesenvolvimento.Date := VS_Date;;
        end;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGerMat);
  End;

  strCodIte := '';
  strCodCor := '';
  strCodFor := '';
  strEstrutura := '';

  If blnImpEstrutura And
     (fMensagem('', 'Importar  Estrutura?', ['&Sim', '&Não']) = 1) Then
  Begin
    strEstrutura := fBuscaEstrutura( True );
    strCodIte := Copy(strEstrutura,1,Pos('+',strEstrutura) - 1);
    strEstrutura := Copy(strEstrutura,Pos('+',strEstrutura) + 1,Length(strEstrutura));
    strCodCor := Copy(strEstrutura,1,Pos('+',strEstrutura) - 1);
    strEstrutura := Copy(strEstrutura,Pos('+',strEstrutura) + 1,Length(strEstrutura));
    strCodFor := strEstrutura;
  End;

  blnMudarFoco := False;

  strSQL := '';
  strSQL := strSQL + '  SELECT ';
  strSQL := strSQL + '    DMT_SEQUEN, ';
  strSQL := strSQL + '    DMT_SEQITE, ';
  strSQL := strSQL + '    DMT_CODEMP, ';
  strSQL := strSQL + '    DMT_ITESUB, ';
  strSQL := strSQL + '    IF(DMT_ITESUB IS NULL, DMT_DESCRI, ITE_DESITE) AS DMT_DESCRI, ';
  strSQL := strSQL + '    ITE_REFERE AS DMT_REFERE, ';
  strSQL := strSQL + '    DMT_QTDITE, ';
  strSQL := strSQL + '    DMT_PERTOL, ';
  strSQL := strSQL + '    DMT_DESPCA, ';
  strSQL := strSQL + '    DMT_CODFAS, ';
  strSQL := strSQL + '    IFNULL(ITE_PRECUS, 0) AS DMT_CUSITE, ';
  strSQL := strSQL + '    (IFNULL(ITE_PRECUS, 0) * DMT_QTDITE) / 100 AS DMT_CUSCAL, ';
  strSQL := strSQL + '    (((IFNULL(ITE_PRECUS, 0) * DMT_QTDITE) / 100) * GMT_PESREA) AS DMT_CUS_LT, ';
  strSQL := strSQL + '    ITE_DENSID AS DMT_DENSID, ';

  strSQL := strSQL + '    ITE_PREVE1, ';
  strSQL := strSQL + '    ITE_PREVE2, ';
  strSQL := strSQL + '    ITE_PREVE3, ';
  strSQL := strSQL + '    ITE_PREVE4, ';
  strSQL := strSQL + '    ITE_PREVE5, ';
  strSQL := strSQL + '    ITE_PREVE6, ';
  strSQL := strSQL + '    ITE_PREVE7, ';

  strSQL := strSQL + '    G.GMT_OBS001, ';
  strSQL := strSQL + '    G.GMT_OBS002, ';
  strSQL := strSQL + '    G.GMT_OBS003, ';
  strSQL := strSQL + '    G.GMT_OBS004, ';
  strSQL := strSQL + '    G.GMT_OBS005, ';
  strSQL := strSQL + '    G.GMT_OBS006, ';
  strSQL := strSQL + '    G.GMT_OBS007, ';
  strSQL := strSQL + '    G.GMT_DTAFOR, ';

  strSQL := strSQL + '    IFNULL(ITE_PRECUS, 0) AS ITE_PRECUS, ';
  strSQL := strSQL + '    IFNULL(ITE_DENSID, 0) AS ITE_DENSID, ';
  strSQL := strSQL + '    ITE_PREMED, ';
  strSQL := strSQL + '    ITE_DTAULT, ';

  strSQL := strSQL + '    ITE_ECARGA, ';
  strSQL := strSQL + '    ITE_PERSOL, ';
  strSQL := strSQL + '    ITE_ABSOLE, ';

  strSQL := strSQL + '    FAS_DESFAS, ';

  strSQL := strSQL + '    DMT_SEQGER,  ';
  strSQL := strSQL + '    DMT_QTDITE AS DMT_REPCUS  '; //campo calculado. o campo dmt_qtdite é somente para retornar um float.
  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    DEDMAT ';
  strSQL := strSQL + '    JOIN GEDMAT G ON DMT_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '    LEFT JOIN CADITE ON DMT_ITESUB = CADITE.ITE_CODITE ';
  strSQL := strSQL + '    LEFT JOIN ITEGER I ON DMT_ITESUB = I.ITE_CODITE AND I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + '    LEFT JOIN CADFAS   ON FAS_CODFAS =   DMT_CODFAS ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    G.GMT_CODITE = :CODITE AND ';
  strSQL := strSQL + '    G.GMT_CODCOR = :CODCOR AND ';
  strSQL := strSQL + '    G.GMT_FORMUL = :CODFOR ';

  With qryConsulta Do
  Begin
    cdsConsulta.Close;
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If ( blnImpEstrutura ) And ( Not fEmptyStr( strCodIte ) ) Then
    Begin
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODCOR').AsString := strCodCor;
      ParamByName('CODFOR').AsString := strCodFor;
    End
    Else
    Begin
      ParamByName('CODITE').AsString := edtProdutos.Text;
      ParamByName('CODCOR').AsString := edtCor.Text;
      ParamByName('CODFOR').AsString := edtCodFormula.Text;
    End;

    Open;

    TFloatField(FieldByName('DMT_QTDITE')).DisplayFormat := edtSubQtdIte.EditFormat;
    TFloatField(FieldByName('DMT_QTDITE')).EditFormat    := edtSubQtdIte.EditFormat;
    TFloatField(FieldByName('DMT_PERTOL')).DisplayFormat := edtPerTol.EditFormat;
    TFloatField(FieldByName('DMT_PERTOL')).EditFormat    := edtPerTol.EditFormat;

    strObs001 := FieldByName('GMT_OBS001').AsString;
    strObs002 := FieldByName('GMT_OBS002').AsString;
    strObs003 := FieldByName('GMT_OBS003').AsString;
    strObs004 := FieldByName('GMT_OBS004').AsString;
    strObs005 := FieldByName('GMT_OBS005').AsString;
    strObs006 := FieldByName('GMT_OBS006').AsString;
    strObs007 := FieldByName('GMT_OBS007').AsString;

    pSetaClient(qryConsulta);

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);

    cdsConsulta.IndexFieldNames := 'DMT_SEQUEN';
  End;

  If Not cdsConsulta.IsEmpty Then
  Begin
    strSeqGer := cdsConsulta.FieldByName('DMT_SEQGER').AsString;

    pCarregaAnalise(strSeqGer);

    //se tiver análise na importação, pergunta se o usuário deseja importar
    if blnImpEstrutura and (not cdsGedAna.IsEmpty)  then
      if fMensagem('', 'Deseja Importar Análises da Estrutura?', ['&Sim', '&Não']) = 2 then
        cdsGedAna.EmptyDataSet;

    btnConfirma.Enabled   := True;
    btnImprimir.Enabled   := True;
    btnAtivaDesenvolvimento.Enabled := True;
    btnImpFor.Enabled     := True;
    btnComentario.Enabled := True;
    btnMoveCima.Enabled   := True;
    btnMoveBaixo.Enabled  := True;
    pAtualizaPorcentagemRepresentacaoCusto;

    If Not fEmptyStr(strCodFor) And (Not blnImpEstrutura) Then
      edtCodFormula.Text := strCodFor;
  End
  Else
    edtCodFormula.Clear;

  pRetDadosFormula(edtProdutos.Text, edtCor.Text);

  Result := True;
end;

procedure TfrmCadEstruturasIndustrialDF.btnMoveCimaClick(Sender: TObject);
  Var
    intSeqAtu: Integer;
    intSeqAnt: Integer;

    strSeqIteAtu: String;
    strSeqIteAnt: String;

    blnMudSeq: Boolean;
begin
  inherited;

  If (blnAltera) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido mover itens em modo de alteração!', ['&O k']);
    Exit;
  End;

  With cdsConsulta Do
  If (RecNo > 1) Then
  Begin
    intSeqAtu    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAtu := FieldByName('DMT_SEQITE').AsString;

    Prior;

    intSeqAnt    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAnt := FieldByName('DMT_SEQITE').AsString;

    blnMudSeq := (Not fEmptyStr(strSeqIteAtu)) And (Not fEmptyStr(strSeqIteAnt));

    If Locate('DMT_SEQUEN', intSeqAtu, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := MaxInt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAtu, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := 'AAAAAA';
      Post;
    End;

    If Locate('DMT_SEQUEN', intSeqAnt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAtu;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAnt, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAtu;
      Post;
    End;

    If Locate('DMT_SEQUEN', MaxInt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAnt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', 'AAAAAA', [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAnt;
      Post;
    End;

  End;
end;

procedure TfrmCadEstruturasIndustrialDF.btnSubstituirClick(Sender: TObject);
begin
  inherited;
  pTrocarSubstituirProduto;
end;

procedure TfrmCadEstruturasIndustrialDF.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnSubstituir.Enabled := (Not cdsConsulta.IsEmpty) And
                           (Not fEmptyStr(cdsConsulta.FieldByName('DMT_ITESUB').AsString));
end;

procedure TfrmCadEstruturasIndustrialDF.btnMoveBaixoClick(Sender: TObject);
  Var
    intSeqAtu: Integer;
    intSeqAnt: Integer;

    strSeqIteAtu: String;
    strSeqIteAnt: String;

    blnMudSeq: Boolean;
begin
  inherited;

  If (blnAltera) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido mover itens em modo de alteração!', ['&O k']);
    Exit;
  End;

  With cdsConsulta Do
  If (RecNo < RecordCount) Then
  Begin
    intSeqAtu    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAtu := FieldByName('DMT_SEQITE').AsString;

    Next;

    intSeqAnt    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAnt := FieldByName('DMT_SEQITE').AsString;

    blnMudSeq := (Not fEmptyStr(strSeqIteAtu)) And (Not fEmptyStr(strSeqIteAnt));

    If Locate('DMT_SEQUEN', intSeqAtu, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := MaxInt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAtu, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := 'AAAAAA';
      Post;
    End;

    If Locate('DMT_SEQUEN', intSeqAnt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAtu;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAnt, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAtu;
      Post;
    End;

    If Locate('DMT_SEQUEN', MaxInt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAnt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', 'AAAAAA', [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAnt;
      Post;
    End;

  End;
end;

function TfrmCadEstruturasIndustrialDF.fBuscaEstrutura( blnImportacao: Boolean ): String;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
    objFrmPnl: TPanelCxFormula;
begin
  objFrmPnl := TPanelCxFormula.Create(TfrmPnlDadosFormula);
  if not Assigned(qryTabela) then
    qryTabela := fCriaQuery(nil);
  Try
    chrKey := '/';

    If fPesqEstruturaIndustrialDF(Self, nil, qryTabela, chrKey, arrSel, True,
               'Consulta de Desenvolvimento de Fórmulas', objFrmPnl) Then
    Begin

      If blnImportacao Then
      Begin
        Result := qryTabela.FieldByName('GMT_CODITE').AsString + '+' +
                  qryTabela.FieldByName('GMT_CODCOR').AsString + '+' +
                  qryTabela.FieldByName('GMT_FORMUL').AsString;
      End
      Else
      Begin

        edtProdutos.Text   := qryTabela.FieldByName('GMT_CODITE').AsString;
        edtCor.Text        := qryTabela.FieldByName('GMT_CODCOR').AsString;
        edtCodFormula.Text := qryTabela.FieldByName('GMT_FORMUL').AsString;
        edtPesRea.Text     := FormatFloat('#,##0.0000', qryTabela.FieldByName('GMT_PESREA').AsFloat);

        if edtDataDesenvolvimento.Visible then
        begin
          if qryTabela.FieldByName('GMT_DTAFOR').AsDateTime > 0  then
            edtDataDesenvolvimento.Date :=  qryTabela.FieldByName('GMT_DTAFOR').AsDateTime
          else
            edtDataDesenvolvimento.Date := VS_Date;;
        end;

        pCarregaProduto(qryConIte);
        pCarregaCor(qryConCor);
        fCarregaEstrutura;
        pAtualizaTemporaria(1);
        pHabilitaCampos;
        pSetFocus(edtSubProduto);

      End;

    End;
  Finally
    FreeAndNil(objFrmPnl);
  End;

End;

procedure TfrmCadEstruturasIndustrialDF.FormShow(Sender: TObject);
begin
  inherited;
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryConCor := fCriarQuery('SELECT * FROM CADCOR WHERE FALSE', Self);
  qryConFas := fCriarQuery('SELECT * FROM CADFAS WHERE FALSE', Self);

  blnAltera := False;
  strSeqAlt := '';

  pSetaCodIte( edtProdutos );
  pSetaCodIte( edtSubProduto );

end;

function TfrmCadEstruturasIndustrialDF.fVerificaPermissaoDelEst : Boolean;
Begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('APAGAR ESTRUTURA');
  objLiberacao.objMsgLibera.pAddTextoCaption('ESTRUTURA'         , edtProdutos.Text + ' - ' + edtDesProduto.Text);
  objLiberacao.objMsgLibera.pAddTextoCaption('REFERÊNCIA'        , edtReferencia.Text);
  objLiberacao.objMsgLibera.pAddTextoCaption('COR'               , edtCor.Text + ' - ' + edtDesCor.Text);
  objLiberacao.objMsgLibera.pAddTextoCaption('CÓDIGO DA FÓRMULA' , edtCodFormula.Text);
  objLiberacao.objMsgLibera.pAddQuebra;

  cdsConsulta.DisableControls;
  cdsConsulta.First;
  While not cdsConsulta.Eof Do
  Begin
    objLiberacao.objMsgLibera.pAddTexto(cdsConsulta.FieldByName('DMT_ITESUB').AsString + ' - ' +
                                        cdsConsulta.FieldByName('DMT_DESCRI').AsString);

    cdsConsulta.Next;
  End;
  cdsConsulta.First;
  cdsConsulta.EnableControls;

  objLiberacao.strDirAce := 'DELEST';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;

  Result := objLiberacao.fLibera;


End;

procedure TfrmCadEstruturasIndustrialDF.btnApagaClick(Sender: TObject);
Var
  strSql: String;
  qryGenMat : TUniQuery;
begin
  if not fVerificaPermissaoDelEst Then
    Exit;

  inherited;

  Try

    qryGenMat := fCriaQuery(Self);

    If ( fEmptyStr( edtProdutos.Text ) Or fEmptyStr( strSeqGer ) ) Then
    Begin
      fMensagem('AVISO','É necessário selecionar uma estrutura antes.', ['&O K']);
      Exit;
    End;

    If ( fMensagem( '', 'Apagar Estrutura?', ['&Sim', '&Não'], 2 ) = 2 ) Then
      Exit;

    With qryGenMat Do
    Begin


      strSql := '';
      strSql := strSql + ' SELECT * FROM DEDMAT ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'DEDMAT', qryGenMat);
        Next;
      End;
      Close;

      strSql := '';
      strSql := strSql + ' DELETE FROM DEDMAT ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      ExecSql;
      Close;


      strSql := '';
      strSql := strSql + ' SELECT * FROM GEDMAT ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'GEDMAT', qryGenMat);
        Next;
      End;
      Close;

      strSql := '';
      strSql := strSql + ' DELETE FROM GEDMAT ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      ExecSql;
      Close;

    End;

    pLimparDados;

  Finally
    FreeAndNil(qryGenMat);
  End;
end;

procedure TfrmCadEstruturasIndustrialDF.btnAtivaDesenvolvimentoClick(Sender: TObject);
  Var
    strSql : String;
    strCodFormulacao : String;
    strAutoIncL : String;
    strDescriL : String;
    intSequen : Integer;
    qryGenMat : TUniQuery;
begin
  inherited;
  if fMensagem('', 'A fórmula selecionada será inserida no cadastro de fórmulas e excluída do cadastro de desenvolvimento. Deseja continuar?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    fStartTransaction;

    strCodFormulacao := IntToStr(fRetornaSequencialItemEstrutura(edtProdutos.Text));

    {***********************************}
    {* EFETUA A GRAVAÇÃO NO BANCO      *}
    {********************************LB*}
    fGravaGerMat(strAutoIncL,
                 VS_strCodEmp,
                 edtProdutos.Text,
                 edtCor.Text,
                 strCodFormulacao,
                 edtReferencia.Text,
                 strObs001,
                 strObs002,
                 strObs003,
                 strObs004,
                 IIF(strCodFormulacao = '1', 'A', 'I'),
                 fStrToFloat(edtPesRea.Text),
                 VS_Date,
                 fNow(),
                 0,
                 0,
                 False,
                 strObs005,
                 strObs006,
                 strObs007,
                 edtDataDesenvolvimento.Date);

    With cdsConsulta Do
    Begin
      intSequen := 0;
      First;
      While Not (Eof) Do
      Begin
        If fEmptyStr(FieldByName('DMT_ITESUB').AsString) Then
          strDescriL := FieldByName('DMT_DESCRI').AsString
        Else
          strDescriL := '';

        intSequen := intSequen + 1;
        fGravaDetMat(strAutoIncL,
                     intSequen,
                     FieldByName('DMT_SEQITE').AsString,
                     VS_strCodEmp,
                     FieldByName('DMT_ITESUB').AsString,
                     strDescriL,
                     FieldByName('DMT_DESPCA').AsString,
                     FieldByName('DMT_QTDITE').AsFloat,
                     FieldByName('DMT_PERTOL').AsFloat,
                     FieldByName('DMT_CODFAS').AsString);

        Next;
      End;
    End;

    fGravaGeiAna(strAutoIncL, cdsGedAna);

    qryGenMat := fCriaQuery;
    With qryGenMat Do
    Begin

      strSql := '';
      strSql := strSql + ' SELECT * FROM DEDMAT ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'DEDMAT', qryGenMat);
        Next;
      End;
      Close;

      strSql := '';
      strSql := strSql + ' DELETE FROM DEDMAT ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      ExecSql;
      Close;


      strSql := '';
      strSql := strSql + ' SELECT * FROM GEDMAT ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'GEDMAT', qryGenMat);
        Next;
      End;
      Close;

      strSql := '';
      strSql := strSql + ' DELETE FROM GEDMAT ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      ExecSql;
      Close;

    End;
    FreeAndNil(qryGenMat);

    fCommit;

    fMensagem('Informação!','Fórmula : ' + strCodFormulacao + #13#10 +
                            'Produto Estrutura : ' + edtProdutos.Text + ' - ' + edtDesProduto.Text + #13#10 +
                            'incluída com sucesso!',['&Ok']);

    pLimparDados;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.btnConfirmaClick]');
    End;
  End;

end;

procedure TfrmCadEstruturasIndustrialDF.btnImpForClick(Sender: TObject);
begin
  inherited;

  If fPergunta('A estrutura será gravada para realizar a impressão. Confirma?') Then
  Begin
    pGravar(True);
    objOrdPro.pImprimessaoDesenvOP(strAutoInc, edtProdutos.Text, edtCor.Text);
  End;

end;

procedure TfrmCadEstruturasIndustrialDF.btnImprimirClick(Sender: TObject);
Var
  strNomeFila: String;
  strTipImp: String;
  qckRel: TfrxReport;
  strTabPre: String;
  blnPreVen: Boolean;
  blnPreCus: Boolean;
  blnRefere: Boolean;
  blnGExcel: Boolean;
  strPesEsp: String;
  frmOpcRelEstruturaIndustrial: TfrmOpcRelEstruturaIndustrial;
begin
  inherited;
  pCriarFormularios(TfrmOpcRelEstruturaIndustrial, frmOpcRelEstruturaIndustrial);
  frmOpcRelEstruturaIndustrial.ShowModal;
  If (frmOpcRelEstruturaIndustrial.ModalResult = mrOk) Then
  Begin
    blnPreCus := frmOpcRelEstruturaIndustrial.rdbPrecoCus.Checked;
    blnPreVen := frmOpcRelEstruturaIndustrial.rdbPrecoVen.Checked;
    strTabPre := frmOpcRelEstruturaIndustrial.cbTabPreco.Text;
    blnRefere := frmOpcRelEstruturaIndustrial.rdbReferenc.Checked;
    blnGExcel := frmOpcRelEstruturaIndustrial.chkExcel.Checked;
    strTabPreRel := strTabPre;

    If Not blnGExcel Then
    Begin
      frxRelatorio.DataSet := cdsConsulta;

      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

      If (strTipImp = 'M') Then
      Begin
        If blnPreVen Then
          qckRel := frxPaginaM
        Else If blnPreCus Then
        Begin
          If pnlCusLT.Visible Then
            qckRel := frxPreCusLitroM
          Else
            qckRel := frxPreCusM;
        End
        Else
          qckRel := frxSemPrecoM;
      End
      Else
      Begin
        If blnPreVen Then
          qckRel := frxPaginaJ
        Else If blnPreCus Then
        Begin
          If pnlCusLT.Visible Then
            qckRel := frxPreCusLitroJ
          Else
            qckRel := frxPreCusJ;
        End
        Else
          qckRel := frxSemPrecoJ;
      End;

      qckRel.Script.Variables['EMPRESA']   := fRetNomeEmpresa;
      qckRel.Script.Variables['ESTRUTURA'] := 'ESTRUTURA: ' + edtDesProduto.Text;

      If blnPreVen Then
      Begin
        TfrxMemoView(qckRel.FindObject('rdbValIte')).Text := '[<frxRelatorio."ITE_PREVE' + strTabPre + '">]';
        TfrxMemoView(qckRel.FindObject('rdbValTot')).Text := '[<frxRelatorio."ITE_PREVE' + strTabPre + '"> * <frxRelatorio."DMT_QTDITE">]';
        TfrxMemoView(qckRel.FindObject('rdbSumTot')).Text := '[SUM(<frxRelatorio."ITE_PREVE' + strTabPre + '"> * <frxRelatorio."DMT_QTDITE">,rlbDetalhes)]';
      End
      Else If blnPreCus Then
      Begin
        TfrxMemoView(qckRel.FindObject('rdbValIte')).Text := '[<frxRelatorio."ITE_PRECUS">]';
        TfrxMemoView(qckRel.FindObject('rdbValTot')).Text := '[<frxRelatorio."ITE_PRECUS"> * <frxRelatorio."DMT_QTDITE"> / 100]';
        TfrxMemoView(qckRel.FindObject('rdbSumTot')).Text := '[SUM(<frxRelatorio."ITE_PRECUS"> * <frxRelatorio."DMT_QTDITE"> / 100,rlbDetalhes)]';

        If pnlCusLT.Visible Then
        Begin
          strPesEsp := ReplaceStr(FormatFloat('0.0000',fStrToFloat(edtPesRea.Text)), ',', '.');
          TfrxMemoView(qckRel.FindObject('rdbValTotLT')).Text := '[(<frxRelatorio."ITE_PRECUS"> * <frxRelatorio."DMT_QTDITE"> / 100) * ' + strPesEsp + ']';
          TfrxMemoView(qckRel.FindObject('rdbSumTotLT')).Text := '[SUM((<frxRelatorio."ITE_PRECUS"> * <frxRelatorio."DMT_QTDITE"> / 100) * ' + strPesEsp + ',rlbDetalhes)]';
        End;

      End;

      If blnRefere Then
        TfrxMemoView(qckRel.FindObject('rdbDesIte')).Text := '[<frxRelatorio."DMT_REFERE">]'
      Else
        TfrxMemoView(qckRel.FindObject('rdbDesIte')).Text := '[<frxRelatorio."DMT_DESCRI">]';

      pPreviewReport(Self.Name, Self.Caption, qckRel);
    End
    Else
      pGeraExcel(blnPreCus, blnPreVen, blnRefere, cdsConsulta);
  End;

  pFreeAndNil(frmOpcRelEstruturaIndustrial);
end;

procedure TfrmCadEstruturasIndustrialDF.pCarregaItemAlteracao;
begin
  If (cdsConsulta.IsEmpty) Then
    Exit;

  // SE NAO É COMENTARIO
  If Not fEmptyStr(cdsConsulta.FieldByName('DMT_ITESUB').AsString) Then
  Begin
    edtSubProduto.Text := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
    pCarregaSubProduto(qryConIte);

    edtCodFas.Text := cdsConsulta.FieldByName('DMT_CODFAS').AsString;
    edtDesFas.Text := fRetDescricaoFase(edtCodFas.Text);
    edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DMT_QTDITE').AsFloat);
    edtPerTol.Text := FormatFloat(edtPerTol.EditFormat, cdsConsulta.FieldByName('DMT_PERTOL').AsFloat);

    pSetFocus(edtCodFas);

    blnAltera   := True;
    strSeqAlt   := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;
    edtSeq.Text := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;
  End
  Else
  Begin

    pCriarFormularios(TfrmComentEstrutura,frmComentEstrutura);
    With frmComentEstrutura Do
    Begin
      edtComentario.MaxLength := 100;
      edtComentario.TamCampo  := 100;

      edtComentario.Text := cdsConsulta.FieldByName('DMT_DESCRI').AsString;
      edtCodFas.Text     := cdsConsulta.FieldByName('DMT_CODFAS').AsString;
      edtDesFas.Text     := fRetDescricaoFase(cdsConsulta.FieldByName('DMT_CODFAS').AsString);
      edtSeq.Text        := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;

      frmComentEstrutura.ShowModal;

      If frmComentEstrutura.blnConfirma Then
      Begin
        blnAltera   := True;
        strSeqAlt   := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;

        strComent := edtComentario.Text;
        pGravaTemporaria('', '', strComent,
                         edtCodFas.Text,
                         edtDesFas.Text,
                         0.00,
                         0.00,
                         StrToIntDef(frmComentEstrutura.edtSeq.Text,0));
      End;
    End;

    pFreeAndNil(frmComentEstrutura);

  End;

end;

procedure TfrmCadEstruturasIndustrialDF.pCalcularTotaisProdutos;
  var
    cdsDados: TUniClientDataSet;
    fltPVC,
    fltCPVC,
    fltPVCCPVC,
    fltMassaSolidos,
    fltVolumeSolidos: Double;
begin
  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    cdsDados := TUniClientDataSet.Create(nil);
    cdsDados.Data := cdsConsulta.Data;

    pCalculaPesoEspecificoSubItens(cdsDados,
                                   intMaxSeqGer,
                                   fltTotPercen,
                                   fltTotCusIte,
                                   fltTotDensid,
                                   fltPVC,
                                   fltCPVC,
                                   fltPVCCPVC,
                                   fltMassaSolidos,
                                   fltVolumeSolidos,
                                   True);

    FreeAndNil(cdsDados);
  End;

  edtTotPer.Text := FormatFloat('#,##0.000',  fltTotPercen);
  edtTotCus.Text := FormatFloat('#,##0.0000', fltTotCusIte);
  edtTotCusLT.Text := FormatFloat('#,##0.0000', fltTotCusIte * fStrToFloat(edtPesRea.Text));
  edtTotPes.Text := FormatFloat('#,##0.0000', fltTotDensid);

  edtPVC.Text     := FormatFloat('#,##0.00',  fltPVC);
  edtCPVC.Text    := FormatFloat('#,##0.00',  fltCPVC);
  edtPVCCPVC.Text := FormatFloat('#,##0.00',  fltPVCCPVC);

  edtMasSol.Text := FormatFloat('#,##0.00',  fltMassaSolidos);
  edtVolSol.Text := FormatFloat('#,##0.00',  fltVolumeSolidos);
end;

Procedure TfrmCadEstruturasIndustrialDF.pRetDadosFormula(strCodIte, strCodCor: String);
  Var
    cdsConsulta: TZClient;
    intMaxSeqGer: Integer;
    fltTotPercen,
    fltTotCusIte,
    fltTotDensid,
    fltPesRea: Double;
    strCodFor: String;

    fltPVC,
    fltCPVC,
    fltPVCCPVC,
    fltMassaSolidos,
    fltVolumeSolidos: Double;
Begin
  intMaxSeqGer := 0;
  fltTotPercen := 0;
  fltTotCusIte := 0;
  fltTotDensid := 0;
  fltPesRea    := 0;

  If (Not fEmptyStr(strCodIte)) And (Not fEmptyStr(strCodCor)) Then
  Begin
    strCodFor    := fCampoTabela('GMT_FORMUL', 'GEIMAT',
                                 ['GMT_CODITE', 'GMT_CODCOR', 'GMT_STATUS'],
                                 [strCodIte, strCodCor, 'A']);

    fltPesRea    := fCampoTabela('GMT_PESREA', 'GEIMAT',
                                 ['GMT_CODITE', 'GMT_CODCOR', 'GMT_STATUS'],
                                 [strCodIte, strCodCor, 'A']);

    cdsConsulta := TZClient.Create(Self);

    If fCarregaEstruturaIndustrial(cdsConsulta.qryQuery,
                                   cdsConsulta,
                                   strCodIte,
                                   strCodCor,
                                   strCodFor) Then
      pCalculaPesoEspecificoSubItens(cdsConsulta,
                                     intMaxSeqGer,
                                     fltTotPercen, fltTotCusIte, fltTotDensid,
                                     fltPVC,
                                     fltCPVC,
                                     fltPVCCPVC,
                                     fltMassaSolidos,
                                     fltVolumeSolidos);
    FreeAndNil(cdsConsulta);
  End;

  edtTotCusOfi.Text := FormatFloat('#,##0.0000', fltTotCusIte);
  edtTotCusLTOfi.Text := FormatFloat('#,##0.0000', fltTotCusIte * fStrToFloat(edtPesReaOfi.Text));
  edtTotPesOfi.Text := FormatFloat('#,##0.0000', fltTotDensid);
  edtPesReaOfi.Text := FormatFloat('#,##0.0000', fltPesRea);
End;

end.
