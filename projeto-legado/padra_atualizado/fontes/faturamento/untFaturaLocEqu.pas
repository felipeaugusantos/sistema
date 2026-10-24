unit untFaturaLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, EditFocus, Uni, cxContainer, cxTextEdit,
  cxCurrencyEdit, CurrencyEditFocus, MaskEditFocus, untFuncFat,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  UniClientDataSet, cadastro.Model.ContratoLocacaoEquipamentos,
  faturamento.Classes.FaturamentoLocEqu, untTypesLocEqu, frxExportPDF, frxDBSet,
  untTLock, untFuncoesLocEqu;

type
  TDocSel = Record
    strEmpDoc: String;
    strEspDoc: String;
    strNumDoc: String;
    strCodEql: String;
  End;

  TfrmFaturaLocEqu = class(TfrmPai)
    dtsContrato: TDataSource;
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    edtNumCon: TEditFocus;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    edtCodCli: TDBEditFocus;
    edtNomCli: TDBEditFocus;
    edtCodVen: TDBEditFocus;
    edtNomVen: TDBEditFocus;
    edtLocalizacao: TDBEditFocus;
    grpDetalhes: TGroupBox;
    btnConfirma: TBitBtnLocked;
    dtsEqlFat: TDataSource;
    lblInfoContrato: TLabel;
    btnImpRecibo: TBitBtnLocked;
    grbDuracao: TGroupBox;
    lblInicio: TLabel;
    lblTermino: TLabel;
    edtDtaIni: TDBEditFocus;
    edtDtaFin: TDBEditFocus;
    edtHorIni: TDBEditFocus;
    edtHorFin: TDBEditFocus;
    Label1: TLabel;
    edtNumPedAd: TEditFocus;
    Label2: TLabel;
    lblQtde: TLabel;
    edtQtde: TDBEditFocus;
    edtQtdDia: TDBEditFocus;
    lblTotEst: TLabel;
    Label4: TLabel;
    edtTotHorEst: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    btnExpandirTodos: TBitBtnLocked;
    btnRetrairTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    grdItens: TcxGridCitel;
    grdItensView: TcxGridDBTableViewCitel;
    grdItensEQL_CODIGO: TcxGridDBColumn;
    grdItensEQL_DESCRI: TcxGridDBColumn;
    grdItensEQD_TIPDUR: TcxGridDBColumn;
    grdItensEQL_NSERIE: TcxGridDBColumn;
    grdItensEQD_DTACOB: TcxGridDBColumn;
    grdItensEQD_DOCENV: TcxGridDBColumn;
    grdItensEQD_DTAFCOB: TcxGridDBColumn;
    grdItensEQD_DOCRET: TcxGridDBColumn;
    grdItensEQD_MARDES: TcxGridDBColumn;
    grdItensEQD_TOTEQL: TcxGridDBColumn;
    grdItensEQD_VALIPE: TcxGridDBColumn;
    grdItensEQF_VLJFAT: TcxGridDBColumn;
    grdItensEQF_VLAFAT: TcxGridDBColumn;
    grdItensEQF_VLRFAT: TcxGridDBColumn;
    grdItensEQF_VLRDSC: TcxGridDBColumn;
    grdItensEQF_VLRLIQ: TcxGridDBColumn;
    grdItensEQF_DTAENC: TcxGridDBColumn;
    grdItensEQD_VALTOT: TcxGridDBColumn;
    grdAcessoriosTableView: TcxGridDBTableViewCitel;
    grdAcessoriosTableViewCODIGO: TcxGridDBColumn;
    grdAcessoriosTableViewDESCRICAO: TcxGridDBColumn;
    grdAcessoriosTableViewQUANTIDADE: TcxGridDBColumn;
    grdAcessoriosTableViewEQA_SEQEQU: TcxGridDBColumn;
    grdAcessoriosTableViewEQA_SEQACL: TcxGridDBColumn;
    grdAcessoriosTableViewEQA_VLRCOB: TcxGridDBColumn;
    grdItensLvl: TcxGridLevel;
    grdAcessoriosLevel1: TcxGridLevel;
    cdsEqlDet: TUniClientDataSet;
    cdsEqlDetEQD_SEQCON: TStringField;
    cdsEqlDetEQL_DSCVEN: TFloatField;
    cdsEqlDetEQL_DSCSGE: TFloatField;
    cdsEqlDetEQL_DSCGER: TFloatField;
    cdsEqlDetEQL_VALLOC: TFloatField;
    cdsEqlDetEQD_VLLOCL: TFloatField;
    cdsEqlDetEQD_TOTLIQ: TFloatField;
    cdsEqlDetEQD_PERDES: TFloatField;
    cdsEqlDetEQL_VLRCAU: TFloatField;
    cdsEqlDetTIPO_CONTRATO: TStringField;
    cdsEqlDetEQD_VLRALT: TStringField;
    cdsEqlDetEQD_VALHOR: TFloatField;
    cdsEqlDetEQD_TOTEQL: TFloatField;
    cdsEqlDetEQD_DESCRI: TStringField;
    cdsEqlDetEQD_SEQEQL: TStringField;
    cdsEqlDetEQD_TIPDUR: TStringField;
    cdsEqlDetEQL_CODIGO: TStringField;
    cdsEqlDetEQD_NSERIE: TStringField;
    cdsEqlDetAUTOINCREM: TStringField;
    cdsEqlDetEQD_VALIPE: TFloatField;
    cdsEqlDetEQD_VALTOT: TFloatField;
    cdsEqlDetEQD_QTDDUR: TFloatField;
    cdsEqlDetEQF_VLJFAT: TFloatField;
    cdsEqlDetEQF_VLAFAT: TFloatField;
    cdsEqlDetEQF_VLRFAT: TFloatField;
    cdsEqlDetEQF_VLRDSC: TFloatField;
    cdsEqlDetEQF_VLRLIQ: TFloatField;
    cdsEqlDetEQF_DTAENC: TDateTimeField;
    cdsEqlDetEQD_MARDES: TStringField;
    cdsEqlDetEQD_DOCENV: TStringField;
    cdsEqlDetEQD_DOCRET: TStringField;
    cdsEqlDetEQD_DTAIPE: TDateTimeField;
    cdsEqlDetEQD_DTACOB: TDateTimeField;
    cdsEqlDetEQD_DTAFCOB: TDateTimeField;
    cdsEqlDetEQD_DTAENC: TDateTimeField;
    csdEqlAce: TUniClientDataSet;
    csdEqlAceCODIGO: TStringField;
    csdEqlAceDESCRICAO: TStringField;
    csdEqlAceQUANTIDADE: TFloatField;
    csdEqlAceEQA_SEQEQU: TStringField;
    csdEqlAceEQA_SEQACL: TStringField;
    csdEqlAceEQA_VLRCOB: TFloatField;
    dtsEqlAcl: TDataSource;
    dtsEqlDet: TDataSource;
    cdsEqlDetEQD_UTIFXN: TStringField;
    gbDuracaoContratoMensal: TGroupBox;
    pnlDuracaoMensal: TPanel;
    lblMesIni: TLabel;
    lblMesFin: TLabel;
    edtMesIni: TMaskEditFocus;
    edtMesFin: TMaskEditFocus;
    edtTotMesEst: TDBEditFocus;
    Splitter1: TSplitter;
    pnlFatura: TPanel;
    pnlObservacoes: TPanel;
    lblInfoHoraReferencia: TLabel;
    grpDadosFaturamento: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtDtaReferencia: TMaskEditFocus;
    edtHorReferencia: TMaskEditFocus;
    edtValorFaturamento: TEditFocus;
    edtVlrTotRestante: TEditFocus;
    edtVlrRestanteLiq: TEditFocus;
    edtVlrTotIpe: TEditFocus;
    chkEncerrarEquipamentos: TCheckBox;
    edtVltTotJaFatu: TEditFocus;
    edtVlrTot: TEditFocus;
    rdgOpcao: TRadioGroup;
    edtTotLocEqu: TEditFocus;
    edtTaxEnt: TEditFocus;
    grpFatura: TGroupBox;
    grdFatur: TcxGridCitel;
    grdFaturTableView: TcxGridDBTableViewCitel;
    grdFaturEQF_SEQEQL: TcxGridDBColumn;
    grdFaturEQF_DOCFAT: TcxGridDBColumn;
    grdFaturEQF_DTAFAT: TcxGridDBColumn;
    grdFaturEQF_DTAREF: TcxGridDBColumn;
    grdFaturEQF_HORREF: TcxGridDBColumn;
    grdFaturEQF_QTDHOR: TcxGridDBColumn;
    grdFaturColumn5: TcxGridDBColumn;
    grdFaturEQF_VALFAT: TcxGridDBColumn;
    grdFaturLevel: TcxGridLevel;
    frxContratoLocacao: TfrxReport;
    grdFaturEQF_NUMDOC: TcxGridDBColumn;
    grdFaturEQF_ESPDOC: TcxGridDBColumn;
    grdFaturEQF_EMPDOC: TcxGridDBColumn;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    cdsEqlDetEQF_VALDES: TFloatField;
    grdItensEQF_VALDES: TcxGridDBColumn;
    grdItensEQD_QTDEQU: TcxGridDBColumn;
    cdsEqlDetEQD_QTDEQU: TFloatField;
    csdEqlAceEQA_QTDTOT: TFloatField;
    grdAcessoriosTableViewEQA_QTDTOT: TcxGridDBColumn;
    Label3: TLabel;
    edtVlrAdc: TEditFocus;
    csdEqlAceEQA_VLRADC: TFloatField;
    grdAcessoriosTableViewEQA_VLRADC: TcxGridDBColumn;
    btnImpFatura: TBitBtnLocked;
    cdsFatura: TUniClientDataSet;
    cdsFaturaIMPRIM: TBooleanField;
    cdsFaturaCTR_NUMDUP: TStringField;
    cdsFaturaCTR_ESPDOC: TStringField;
    cdsFaturaCTR_CODEMP: TStringField;
    cdsFaturaCTR_PARCEL: TStringField;
    cdsFaturaCTR_DTAVEN: TDateField;
    cdsFaturaCTR_VALDUP: TFloatField;
    cdsEqlDetEQF_DIACAL: TFloatField;
    cdsEqlDetEQF_HORCAL: TFloatField;
    grdItensEQF_DIACAL: TcxGridDBColumn;
    grdItensEQF_HORCAL: TcxGridDBColumn;
    grdItensEQF_MESCAL: TcxGridDBColumn;
    cdsEqlDetEQF_MESCAL: TFloatField;
    lblLegendaEquipamento: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdgOpcaoClick(Sender: TObject);
    procedure grdItensViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdFaturTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnImpReciboClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExpandirTodosClick(Sender: TObject);
    procedure btnRetrairTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure chkEncerrarEquipamentosClick(Sender: TObject);
    procedure grdItensViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure grdItensViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure grdItensViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure grdFaturTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure btnImpFaturaClick(Sender: TObject);
  private
    qryContrato: TUniQuery;
    qryEqlFat: TUniQuery;
    objContrato: TContratoLocacaoEquipamentos;
    objFatura: TFaturamentoContrato;
    FDataReferencia: TDateTime;
    FBlnUtilizaAcessorios: Boolean;

    recSel: TDocSel;
    FintLocDec: Integer;
    FstrLocDec: String;
    FobjLock: TLock;

    function fCarregarContrato(strNumeroContrato: String;
      blnMostraMsg: Boolean = True; strNumPed: String = ''): Boolean;
    function fCarregaDetalhes: Boolean;
    function fCarregaFaturamentos(strCodContrato: String): Boolean;
    function fMaxReferencia(blnHoras: Boolean): TDateTime;
    function fMinReferencia(blnHoras: Boolean): TDateTime;
    function fValorFaturado(strNumeroContrato: String): Double;
    function fValorFaturar(): Double;

    function fCalculaValorTotalFaturar(strMarDes: String; strCodEql: String;
      fltPerDes, fltVlrDes, fltVlrLiq: Double; blnReacalcularDesconto: Boolean = False;
      blnReacalcularTotaisLiq: Boolean = False; blnAlterarValorManual: Boolean = False): TItemFaturamentoContrato;
    function fCalculaValorParcialFaturar(strMarDes: String; strCodEql: String;
      fltPerDes, fltVlrDes, fltVlrLiq: Double; blnReacalcularDesconto: Boolean = False;
      blnReacalcularTotaisLiq: Boolean = False; blnAlterarValorManual: Boolean = False): TItemFaturamentoContrato;
    function fTemEquipamentosSemDocumentoRetorno: Boolean;
    function fPodeMarcarEquipamento(const blnMostraMensagem: Boolean): Boolean;
    function fPermiteEncerrarContrato: Boolean;
    function fObterDataReferencia: TDateTime;

    procedure pImprimeRecibo(blnEnviarEmail: Boolean);
    procedure pLimpaCampos();
    procedure pCalculaValorFaturar(blnRecalcularDesconto: Boolean; blnReacalcularTotaisLiq: Boolean = False);
    procedure pAdicionarItemGrid(const aItem: TItemContratoLocacaoEquipamentos);
    procedure pAdicionarAcessorioGrid(const aItem: TAcessorioContratoLocacaoEquipamentos);
    procedure pAtualizaDadosFaturamentoGrid(const aItemFatura: TItemFaturamentoContrato);
    procedure pFormatarCampos;
    procedure pMarcarTodos(const blnMarcar: Boolean);
    procedure pMarcarEquipamento(const blnMarcar: Boolean; blnMostrarMensagem: Boolean = True);
    procedure pLimpardadosFaturamento;
    procedure pCalcularTotais;
    procedure pRecalcularFaturamento;
    procedure pEncerrarEquipamento;
    procedure pReiniciaCamposFaturamentoParcial;
    procedure pSugerirDataReferencia;
    function fBloquearEdicaoCamposDesconto: Boolean;
    procedure pHabilitarDesabilitarCamposDescontos(const blnHabilitar: Boolean);
    function fVerificaDescontoInformado: Boolean;
    procedure pAtivarLabelInfoContrato;
    procedure pImprimirFaturaContLoc;
    function fTemRegistroSelecionado: boolean;
    function ValidarDataReferencia(const AMostraMensagem: Boolean = True; ASeqEql: String = ''; AItemMarcado: Boolean = True): Boolean;
    function ValidarDataReferenciaDataEstimadaCapaContrato(const AMostraMensagem: Boolean = True): Boolean;
    function ValidarDataReferenciaDataEstimadaFinalCobrancaItem(const AMostraMensagem: Boolean = True; ASeqEql: String = ''; AItemMarcado: Boolean = True): Boolean;
    function ValidarExistemEquipamentosSemEnvio: Boolean;
    procedure pEncerrarContrato;
    function ValidarEncerrarContratoSemFaturar: Boolean;
    function ValidaConfirmacaoFaturamentoComEncerramento: Boolean;
    function ValidaConfirmacaoFaturamentoAntecipado: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux, untFuncoes,
  untGravando, untEditorFastImpressao, TypesRel,
  untFuncoesGenerica, untFuncoesImagem, untObservacao, untImpFaturaContrato;

{$R *.dfm}

procedure TfrmFaturaLocEqu.btnConfirmaClick(Sender: TObject);
var
  LConfirmar: Boolean;
  LEncerrar: Boolean;
begin
  inherited;

  LEncerrar := False;
  LConfirmar:= False;

  If (objFatura.ListaItens.Count = 0) And (Not objFatura.fVerificaTodosItensEncerrados) Then
  begin
    fMensagem('ATENÇÃO!', 'Não há equipamentos selecionados para faturamento.', ['&O k']);
    Exit;
  end;

  If (rdgOpcao.ItemIndex = 0) And fTemEquipamentosSemDocumentoRetorno Then
  Begin
    fMensagem('ATENÇÃO!', 'Existem equipamentos sem documento de retorno, portanto não poderá ser feito o faturamento total!', ['&O k']);
    Exit;
  End;

  If (rdgOpcao.ItemIndex = 1) And
     (fFormataFloat(fValorFaturar(), FintLocDec) = 0.00) And
     (Not chkEncerrarEquipamentos.Checked)Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenum valor a ser faturado!', ['&O k']);
    Exit;
  End;

  If (rdgOpcao.ItemIndex = 1) And
     (Not ObjFatura.fTemEquipamentosSemInspecaoEntrada) And
     (Not fTemEquipamentosSemDocumentoRetorno) And
     (fFormataFloat(fValorFaturar(), FintLocDec) = fFormataFloat(qryContrato.FieldByName('EQL_VALRES').AsFloat, FintLocDec)) And
     (fFormataFloat(qryContrato.FieldByName('EQL_TOTIPE').AsFloat, 2) = 0.00) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já foram informados todos os documentos de retorno e foram feitas todas as inspeções de entrada e nessas inspeções não foram informados valores de cobrança extra. Por favor, realize o faturamento total do contrato!', ['&O k']);
    Exit;
  End;

  If (rdgOpcao.ItemIndex = 1) And
     (Not ObjFatura.objValidaCtr.fContratoPossuiInspecaoEntradaAberto) And
     (ObjFatura.ValorTotalCobrancaInspecao > 0.00) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já foi informado data de retorno de todos os equipamentos e foi informado valor extra de cobrança. Por favor, realize o faturamento total do contrato!', ['&O k']);
    Exit;
  End;

  If objFatura.fTemEquipamentosEncerrados And (Not objFatura.fVerificaTodosItensEncerrados) Then
  Begin
    fMensagem('ATENÇÃO!', 'Existem equipamentos encerrados na seleção. Verifique.', ['&O k']);
    Exit;
  End;

  If (rdgOpcao.ItemIndex = 0) Then
  Begin
    LEncerrar := ValidarEncerrarContratoSemFaturar;
    If Not LEncerrar Then
      LConfirmar := ValidaConfirmacaoFaturamentoComEncerramento;
  End
  Else
  If (rdgOpcao.ItemIndex = 1) Then
  Begin
    LConfirmar := ValidaConfirmacaoFaturamentoAntecipado;
  End;

  If LEncerrar Then
    pEncerrarContrato
  Else
  If LConfirmar Then
  Begin
    If fMensagem('ATENÇÃO', 'Confirma o faturamento do contrato?', ['&Sim', '&Não']) = 2 Then
      Exit;

    objFatura.DataReferencia  := fObterDataReferencia;
    objFatura.TipoFaturamento := IIF(rdgOpcao.ItemIndex = 1, tpParcial, tpTotal);

    If rdgOpcao.ItemIndex = 0 Then
    Begin
      If Not fPermiteEncerrarContrato Then
        Exit;
    End;

    If objFatura.fConfirmarFaturamento(rdgOpcao.ItemIndex = 0) Then
    Begin
      FobjLock.fLock_Unlock(cst_TRAVA_FATURA_LOCEQU + objContrato.AutInc, False, False);
      fCarregarContrato(edtNumCon.Text, False);
      pMarcarTodos(False);
      If Not fEmptyStr(objFatura.MensagemRetorno) Then
        fMensagem('ATENÇÃO', objFatura.MensagemRetorno, ['&Ok']);

      recSel.strEmpDoc := objFatura.ObjFatVenda.strEmpDoc;
      recSel.strEspDoc := objFatura.ObjFatVenda.strEspDoc;
      recSel.strNumDoc := objFatura.ObjFatVenda.strNumDoc;

      If objFatura.blnFatEmitida Then
        pImprimeRecibo(True);

    End
    Else If Not fEmptyStr(objFatura.MensagemRetorno) Then
      fMensagem('ATENÇÃO', objFatura.MensagemRetorno , ['&Ok']);
  End;
end;

procedure TfrmFaturaLocEqu.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarTodos(False);
end;

procedure TfrmFaturaLocEqu.btnExpandirTodosClick(Sender: TObject);
begin
  inherited;

  If (grdItensView.DataController.DataSource.DataSet.Active) Then
    If (Not grdItensView.DataController.DataSource.DataSet.IsEmpty) Then
      grdItensView.ViewData.Expand(True);
end;

procedure TfrmFaturaLocEqu.btnImpFaturaClick(Sender: TObject);
begin
  inherited;
  If Not btnImpFatura.Visible Then
    Exit;
  If Not btnImpFatura.Enabled Then
    Exit;

  pImprimirFaturaContLoc;
end;

procedure TfrmFaturaLocEqu.btnImpReciboClick(Sender: TObject);
begin
  inherited;
  If Not btnImpRecibo.Visible Then
    Exit;
  If Not btnImpRecibo.Enabled Then
    Exit;

  pImprimeRecibo(False);
end;

procedure TfrmFaturaLocEqu.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  pMarcarTodos(True);
end;

procedure TfrmFaturaLocEqu.btnRetrairTodosClick(Sender: TObject);
begin
  inherited;

  If (grdItensView.DataController.DataSource.DataSet.Active) Then
    If (Not grdItensView.DataController.DataSource.DataSet.IsEmpty) Then
      grdItensView.ViewData.Collapse(True);
end;

procedure TfrmFaturaLocEqu.chkEncerrarEquipamentosClick(Sender: TObject);
var
  blnBloquearEdicaoDesc: Boolean;
begin

  inherited;

  blnBloquearEdicaoDesc := fBloquearEdicaoCamposDesconto;
  If (blnBloquearEdicaoDesc) And (fVerificaDescontoInformado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido inserir desconto em faturamento parcial com data de referência inferior à data final de cobrança! ' +
                          'Verifique a data de referência informada.', ['&O k']);
    Exit;
  End;
  pHabilitarDesabilitarCamposDescontos(Not blnBloquearEdicaoDesc);

  pEncerrarEquipamento;

end;

procedure TfrmFaturaLocEqu.edtNumConKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
    fValidaCampos(edtNumCon);
end;

procedure TfrmFaturaLocEqu.edtNumPedKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtNumPed, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmFaturaLocEqu.fBloquearEdicaoCamposDesconto: Boolean;
var
  dtaFCob: TDateTime;
  intRecNo: Integer;
  fltDuracaoEstimada,
  fltDuracaoCalculada: Double;
begin

  If Not fVerificaAcessoSistema('LOCDSF') Then
    Exit(True);

  If (rdgOpcao.ItemIndex = 0) Or
     ((rdgOpcao.ItemIndex = 1) And (chkEncerrarEquipamentos.Checked)) Then
    Exit(False);

  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    Result := False;
    While Not cdsEqlDet.Eof Do
    Begin
      If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        dtaFCob := fObtemData(cdsEqlDet.FieldByName('EQD_DTAFCOB').AsDateTime);

        fltDuracaoEstimada := IIF(cdsEqlDet.FieldByName('EQD_TIPDUR').AsString = 'H', objContrato.TotalHorasEstimadas,
                                 IIF(cdsEqlDet.FieldByName('EQD_TIPDUR').AsString = 'M', objContrato.TotalMesesEstimados,
                                   objContrato.TotalDiasEstimado));

        fltDuracaoCalculada := IIF(cdsEqlDet.FieldByName('EQD_TIPDUR').AsString = 'H', cdsEqlDet.FieldByName('EQF_HORCAL').AsFloat,
                                 IIF(cdsEqlDet.FieldByName('EQD_TIPDUR').AsString = 'M', cdsEqlDet.FieldByName('EQF_MESCAL').AsFloat,
                                   cdsEqlDet.FieldByName('EQF_DIACAL').AsFloat));

        Result :=  (StrToDate(edtDtaReferencia.Text) < dtaFCob) And
                   (fltDuracaoCalculada < fltDuracaoEstimada );

        If Result Then
          Break;
      End;
      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

function TfrmFaturaLocEqu.fCalculaValorParcialFaturar(strMarDes: String; strCodEql: String;
      fltPerDes, fltVlrDes, fltVlrLiq: Double; blnReacalcularDesconto: Boolean = False;
      blnReacalcularTotaisLiq: Boolean = False; blnAlterarValorManual: Boolean = False): TItemFaturamentoContrato;
var
  itemFatura: TItemFaturamentoContrato;
  itemContrato: TItemContratoLocacaoEquipamentos;
  dtRef : TDateTime;
  fltDuracaoEstimada,
  fltDuracaoCalculada: Double;
begin
  Result := nil;

  If Not Assigned(objFatura) Then
    Exit;

  Try
    If strMarDes = 'M' Then
    Begin
      dtRef := fObterDataReferencia;
      itemContrato := ObjContrato.fRetornaItemContrato(strCodEql);

      If ((Assigned(itemContrato)) and ( dtRef < itemContrato.DataInicialCobranca)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Verifique a data de referência informada. A data não pode ser inferior à data inicial de cobrança!', ['&O k']);
        Exit;
      End;

      objFatura.pCalcularTotais;
      itemFatura := objFatura.fRetornaItemFatura(strCodEql);
      If Not Assigned(itemFatura) Then
      Begin
        itemFatura := objFatura.fAddItemFaturar;
        itemFatura.itemContrato := itemContrato;
      End;
      itemFatura.blnAlterarValorManual := blnAlterarValorManual;
      itemFatura.pRecalcularFaturamentoParcial(dtRef, fltPerDes, fltVlrDes, fltVlrLiq, blnReacalcularDesconto, blnReacalcularTotaisLiq, chkEncerrarEquipamentos.Checked);


      fltDuracaoEstimada := IIF(itemContrato.TipoCalculoLocacao = tpHoras,
                                itemContrato.Contrato.TotalHorasEstimadas,
                                IIF(itemContrato.TipoCalculoLocacao = tpMensal,
                                    itemContrato.Contrato.TotalMesesEstimados,
                                    itemContrato.Contrato.TotalDiasEstimado));

      fltDuracaoCalculada := IIF(itemContrato.TipoCalculoLocacao = tpHoras,
                                itemFatura.HorasCalc,
                                IIF(itemContrato.TipoCalculoLocacao = tpMensal,
                                    itemFatura.MesesCalc,
                                    itemFatura.DiasCalc));


      If ((fltPerDes > 0) Or (fltVlrDes > 0)) And
         ((Assigned(itemContrato)) And
         (( dtRef < itemContrato.DataFinalCobranca) And (itemContrato.InspecaoEntradaRealizada)) Or
         ( dtRef < itemContrato.Contrato.DataFinalEstimada) And
         (Not itemContrato.InspecaoEntradaRealizada) And
         (itemContrato.blnValorLocacaoAlteradoManualmente)) And
         (Not chkEncerrarEquipamentos.Checked) And
         (fltDuracaoCalculada < fltDuracaoEstimada ) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível aplicar desconto em faturamento parcial para o item "' + strCodEql + '". ' +
                              'Verifique a data de referência informada!', ['&O k']);
        itemFatura.pRecalcularFaturamentoParcial(dtRef, 0, 0, fltVlrLiq, True, blnReacalcularTotaisLiq, chkEncerrarEquipamentos.Checked);
      End;

      pAtualizaDadosFaturamentoGrid(itemFatura);
      Result := itemFatura;

    End;

  Except
    On Erro: Exception Do
    Begin
      pMensagensErro(Erro.Message, '[TNotaFiscalContratoLocacao.fCalculaValorParcialFaturar]');
    End;
  End;
end;

function TfrmFaturaLocEqu.fCalculaValorTotalFaturar(strMarDes: String; strCodEql: String;
  fltPerDes, fltVlrDes, fltVlrLiq: Double; blnReacalcularDesconto: Boolean = False;
  blnReacalcularTotaisLiq: Boolean = False; blnAlterarValorManual: Boolean = False): TItemFaturamentoContrato;
var
  itemFatura: TItemFaturamentoContrato;
  itemContrato: TItemContratoLocacaoEquipamentos;
begin
  Result := nil;

  If Not Assigned(objFatura) Then
    Exit;

  Try
    If strMarDes = 'M' Then
    Begin
      itemFatura := objFatura.fRetornaItemFatura(strCodEql);

      If Not Assigned(itemFatura) Then
      Begin
        itemFatura := objFatura.fAddItemFaturar;
      End;

      If Assigned(itemFatura) Then
      Begin
        itemContrato := ObjContrato.fRetornaItemContrato(strCodEql);
        If Assigned(itemContrato) Then
        Begin
          itemFatura.itemContrato := itemContrato;
          itemFatura.DuracaoLocacao := itemContrato.Duracao;
          itemFatura.blnAlterarValorManual := blnAlterarValorManual;
          itemFatura.pRecalcularFaturamentoTotal(fltPerDes, fltVlrDes, fltVlrLiq, blnReacalcularDesconto, blnReacalcularTotaisLiq, chkEncerrarEquipamentos.Checked);
          pAtualizaDadosFaturamentoGrid(itemFatura);
        End;
        Result := itemFatura;
      End;
    End;
    objFatura.pCalcularTotais;
  Except
    On Erro: Exception Do
    Begin
      pMensagensErro(Erro.Message, '[TNotaFiscalContratoLocacao.fCalculaValorTotalFaturar]');
    End;
  End;
end;

function TfrmFaturaLocEqu.fCarregarContrato(strNumeroContrato: String;
  blnMostraMsg: Boolean = True; strNumPed: String = ''): Boolean;
var
  strSQL: String;
begin
  Result := True;
  strSQL := '';
  strSQL := strSQL + 'SELECT                                         ';
  strSQL := strSQL + '  CONEQL.AUTOINCREM,                           ';
  strSQL := strSQL + '  EQL_NROCON,                                  ';
  strSQL := strSQL + '  EQL_STATUS,                                  ';
  strSQL := strSQL + '  EQL_CODCLI,                                  ';
  strSQL := strSQL + '  CLI_NOMCLI,                                  ';
  strSQL := strSQL + '  CLI_CODCID,                                  ';
  strSQL := strSQL + '  CLI_I_E_S_,                                  ';
  strSQL := strSQL + '  CLI_CODATI,                                  ';
  strSQL := strSQL + '  CLI_ENDERE,                                  ';
  strSQL := strSQL + '  CLI_ENDNUM,                                  ';
  strSQL := strSQL + '  CLI_ENDCOM,                                  ';
  strSQL := strSQL + '  CLI_BAIRRO,                                  ';
  strSQL := strSQL + '  CLI_C_E_P_,                                  ';
  strSQL := strSQL + '  CLI_CODCID,                                  ';
  strSQL := strSQL + '  CLI_FONE01,                                  ';
  strSQL := strSQL + '  CLI_C_G_C_,                                  ';
  strSQL := strSQL + '  CLI_CGCCPF,                                  ';
  strSQL := strSQL + '  CLI_PERMFF,                                  ';
  strSQL := strSQL + '  CLI_PERMFV,                                  ';
  strSQL := strSQL + '  CLI_EMAIL_,                                  ';
  strSQL := strSQL + '  CLI_TABPRE,                                  ';
  strSQL := strSQL + '  EQL_CODVEN,                                  ';
  strSQL := strSQL + '  OPE_NOMOPE,                                  ';
  strSQL := strSQL + '  EQL_ENTCLI,                                  ';
  strSQL := strSQL + '  CONCAT(                                      ';
  strSQL := strSQL + '    ETC_ENDENT,                                ';
  strSQL := strSQL + '    " - ",                                     ';
  strSQL := strSQL + '    ETC_BAIENT,                                ';
  strSQL := strSQL + '    " - ",                                     ';
  strSQL := strSQL + '    CID_NOMCID,                                ';
  strSQL := strSQL + '    " - ",                                     ';
  strSQL := strSQL + '    CID_ESTADO                                 ';
  strSQL := strSQL + '  ) AS ETC_ENDENT,                             ';
  strSQL := strSQL + '  EQL_DTAINI,                                  ';
  strSQL := strSQL + '  EQL_HORINI,                                  ';
  strSQL := strSQL + '  EQL_DTAFIN,                                  ';
  strSQL := strSQL + '  EQL_HORFIN,                                  ';
  strSQL := strSQL + '  EQL_QTDEQU,                                  ';
  strSQL := strSQL + '  EQL_TOTHOR,                                  ';
  strSQL := strSQL + '  EQL_TOTCON,                                  ';
  strSQL := strSQL + '  EQL_TOTDIA,                                  ';
  strSQL := strSQL + '  SUM(IFNULL(EQD_VALIPE, 0.0)) AS EQL_TOTIPE,  ';
  strSQL := strSQL + '  EQL_TOTCON +                                 ';
  strSQL := strSQL + '    SUM(IFNULL(EQD_VALIPE, 0.0)) AS EQL_VALTOT,';
  strSQL := strSQL + '  :TOTFAT AS EQL_TOTFAT,                       ';
  strSQL := strSQL + '  EQL_TOTCON +                                 ';
  strSQL := strSQL + '    SUM(IFNULL(EQD_VALIPE, 0.0)) -             ';
  strSQL := strSQL + '    :TOTFAT AS EQL_VALRES,                     ';
  strSQL := strSQL + '  EQL_TOTMES,                                  ';
  strSQL := strSQL + '  EQL_MESINI,                                  ';
  strSQL := strSQL + '  EQL_MESFIN                                   ';
  strSQL := strSQL + 'FROM                                           ';
  strSQL := strSQL + '  CONEQL                                       ';
  strSQL := strSQL + 'INNER JOIN EQLDET                              ';
  strSQL := strSQL + '  ON EQD_SEQCON = CONEQL.AUTOINCREM            ';
  strSQL := strSQL + 'INNER JOIN CADCLI                              ';
  strSQL := strSQL + '  ON CLI_CODCLI = EQL_CODCLI                   ';
  strSQL := strSQL + 'INNER JOIN CADOPE                              ';
  strSQL := strSQL + '  ON OPE_CODOPE = EQL_CODVEN                   ';
  strSQL := strSQL + 'INNER JOIN ENTCLI                              ';
  strSQL := strSQL + '  ON ENTCLI.AUTOINCREM = EQL_ENTCLI            ';
  strSQL := strSQL + 'INNER JOIN CADCID                              ';
  strSQL := strSQL + '  ON CID_CODCID = ETC_CIDENT                   ';
  strSQL := strSQL + 'LEFT JOIN FATGOR                               ';
  strSQL := strSQL + '  ON EQL_AUT_PD = FATGOR.AUTOINCREM            ';
  strSQL := strSQL + 'WHERE TRUE                                     ';

  If Not fEmptyStr(strNumeroContrato) Then
    strSQL := strSQL + '  AND EQL_NROCON = :NROCON                   ';
  If (Not fEmptyStr(strNumPed))  And (Not fEmptyStr(strNumeroContrato)) Then
    strSQL := strSQL + '  AND EQL_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  If Not fEmptyStr(strNumPed) Then
  Begin
    strSQL := strSQL + '  AND FGO_CODEMP = :CODEMP          ';
    strSQL := strSQL + '  AND FGO_ESPDOC = "PD"             ';
    strSQL := strSQL + '  AND FGO_NUMDOC = :NUMDOC          ';
  End;
  strSQL := strSQL + 'GROUP BY CONEQL.AUTOINCREM            ';

  Try
    With qryContrato Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('TOTFAT').AsFloat := fValorFaturado(strNumeroContrato);

      If Not fEmptyStr(strNumeroContrato) Then
        ParamByName('NROCON').AsString := strNumeroContrato;

      If Not fEmptyStr(strNumPed) Then
      Begin
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('NUMDOC').AsString := strNumPed;
      End;

      pLimpaCampos;
      Open;

      If Result And IsEmpty Then
      Begin
        If blnMostraMsg Then
          fMensagem('ATENÇÃO', 'Contrato não encontrado!', ['&Ok']);
        Result := False;
        Exit;
      End;

      If Result And (FieldByName('EQL_STATUS').AsString = 'O') Then
      Begin
        If blnMostraMsg Then
          fMensagem('ATENÇÃO', 'Contrato não está ativo! Favor realizar a ativação do contrato antes do faturamento.', ['&Ok']);
        Result := False;
        Exit;
      End;

      If (ObjContrato.Status = 'C') Then
      Begin
        lblInfoContrato.Caption := 'Contrato Cancelado. Carregado somente para consulta.';
        lblInfoContrato.Visible := True;
      End;

      If Not fValidaTravasContrato(FieldByName('AUTOINCREM').AsString) Then
      Begin
        Result := False;
        Exit;
      End;

      recSel.strCodEql := EmptyStr;
      recSel.strEmpDoc := EmptyStr;
      recSel.strEspDoc := EmptyStr;
      recSel.strNumDoc := EmptyStr;

      ObjContrato.pLimpar;
      ObjContrato.fCarregarContrato('', strNumeroContrato, True, strNumPed);
      ObjFatura.pLimpar;

      edtNumPedAd.Text := objContrato.NumDocPedAdiantamento;
      edtNumPed.Text := Copy(objContrato.NumDocPedAdiantamento, 0, 12);
      edtNumCon.Text := objContrato.NroContrato;

      If ObjContrato.TipoDuracaoContrato = 'M' Then
      Begin
        grbDuracao.Visible := False;
        gbDuracaoContratoMensal.Visible := True;
        edtMesIni.Text := objContrato.strMesIni;
        edtMesFin.Text := objContrato.strMesFin;
        edtTotHorEst.Visible := False;
        edtTotMesEst.Visible := True;
        edtTotMesEst.Top := edtTotHorEst.Top;
        edtTotMesEst.Left := edtTotHorEst.Left;
        lblTotEst.Caption := 'Total de meses estimados:';
      End
      Else
      Begin
        grbDuracao.Visible := True;
        gbDuracaoContratoMensal.Visible := False;
        edtTotHorEst.Visible := True;
        lblTotEst.Caption := 'Total de horas estimadas:';
        edtTotMesEst.Visible := False;
      End;

      If Not(objContrato.fVerificaPedAdtGerado) Then
      Begin
        If blnMostraMsg Then
          fMensagem('ATENÇÃO', 'Contrato não possui pedido de adiantamento e não pode ser faturado!', ['&Ok']);
        Result := False;
        Exit;
      End;

      pSugerirDataReferencia;

      Result := Result And fCarregaDetalhes;

      Result := Result And fCarregaFaturamentos(FieldByName('AUTOINCREM').AsString);

      Result := Result And ValidarExistemEquipamentosSemEnvio;

      If Result Then
      Begin

        If Not(fEmptyStr(objContrato.AutInc)) Then
          FobjLock.fLock_Unlock(cst_TRAVA_FATURA_LOCEQU + objContrato.AutInc, True, False);

        rdgOpcaoClick(rdgOpcao);
        pMarcarTodos(False);

        btnConfirma.Enabled := (FieldByName('EQL_STATUS').AsString = 'A');
        grpDadosFaturamento.Enabled := (FieldByName('EQL_STATUS').AsString = 'A');
        btnImpRecibo.Enabled := True;
        btnImpFatura.Enabled := True;
      End
      Else
      Begin
        If cdsEqlDet.Active Then
          cdsEqlDet.EmptyDataSet;

        qryEqlFat.Close;
        qryContrato.Close;

        grpDadosFaturamento.Enabled := False;
        btnConfirma.Enabled := False;
        btnImpRecibo.Enabled := False;
        btnImpFatura.Enabled := False;
        pLimpaCampos();
      End;
      pAtivarLabelInfoContrato;
    End;
  Except
    On Erro: Exception Do
    Begin
      pMensagensErro(Erro.Message, '[TfrmFaturaLocEqu.fCarregarContrato]');
    End;
  End;
end;

procedure TfrmFaturaLocEqu.FormCreate(Sender: TObject);
begin
  inherited;
  qryContrato := fCriaQuery(Self);
  qryContrato.AfterOpen := pAfterOpen;
  dtsContrato.DataSet := qryContrato;

  qryEqlFat := fCriaQuery(Self);
  dtsEqlFat.DataSet := qryEqlFat;

  objContrato := TContratoLocacaoEquipamentos.Create;
  objFatura := TFaturamentoContrato.Create(objContrato);
  cdsEqlDet.CreateDataSet;
  csdEqlAce.CreateDataSet;

  FintLocDec := fCfgSis('LOCDEC', VarInteger);
  FstrLocDec := '#,##0.' + fStrZero('0', FintLocDec);

  pFormatarCampos;

  FBlnUtilizaAcessorios := fCfgSis('UTIACE', VarBoolean);
  grdAcessoriosLevel1.Visible := FBlnUtilizaAcessorios;
  btnExpandirTodos.Visible := FBlnUtilizaAcessorios;
  btnRetrairTodos.Visible := FBlnUtilizaAcessorios;
  grdAcessoriosLevel1.Visible := FBlnUtilizaAcessorios;

  grdItensEQF_VLRDSC.Options.Editing := fVerificaAcessoSistema('LOCDSF');
  grdItensEQF_VLRLIQ.Options.Editing := fVerificaAcessoSistema('LOCDSF');
  grdItensEQF_VALDES.Options.Editing := fVerificaAcessoSistema('LOCDSF');

  gbDuracaoContratoMensal.Visible := False;
  gbDuracaoContratoMensal.Top := grbDuracao.Top;
  gbDuracaoContratoMensal.Left := grbDuracao.Left;
  edtTotMesEst.Visible := False;

  If fCfgSis('PDRCTR', VarBoolean) Then
  Begin
    edtNumPed.Visible := True;
  End
  Else
  Begin
    edtNumPed.Visible := False;
    lblNumPed.Visible := False;
    edtNumCon.Left := edtNomCli.Left;
    lblNumCon.Left := lblCodCli.Left;
  End;

  FobjLock := TLock.Create;

  lblLegendaEquipamento.Visible := False;

  Self.WindowState := wsMaximized;
end;

procedure TfrmFaturaLocEqu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_F1  : btnExpandirTodos.Click;
    VK_F2  : btnRetrairTodos.Click;
    VK_F3  : btnMarcarTodos.Click;
    VK_F4  : btnDesmarcarTodos.Click;
    VK_F10 : Begin
               If Not btnConfirma.Enabled Then
                 Exit;

               If (Shift = []) Then
                 btnConfirma.Click;
             End;
    VK_F11 : btnImpRecibo.Click;
    VK_F5  : btnImpFatura.Click;
  End;

end;

procedure TfrmFaturaLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  btnImpRecibo.Visible := fCfgSis('LECRSN', varBoolean);
  btnImpRecibo.Enabled := btnImpRecibo.Visible;

  If btnImpRecibo.Visible Then
    grpDadosFaturamento.Caption := '   Dados para emissão da fatura   ';

  pnlObservacoes.Visible := False;

  btnImpFatura.Visible := fCfgSis('LECRSN', varBoolean);
  btnImpFatura.Enabled := btnImpFatura.Visible;

  grdItensEQF_MESCAL.Visible := fCfgSis('CTRMES', VarBoolean);

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);



end;

function TfrmFaturaLocEqu.fPermiteEncerrarContrato: Boolean;
begin
  Result := True;

  ObjFatura.blnEncerrarContrato := (rdgOpcao.ItemIndex = 0);

  If Not(ObjFatura.blnEncerrarContrato) Then
    Exit(False);

  If Not ObjFatura.fValidaEncerramentoContrato Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', ObjFatura.MensagemRetorno, ['&O k']);
    pReiniciaCamposFaturamentoParcial;
    Exit;
  End
  Else
  Begin
    If Not fEmptyStr(ObjFatura.MensagemRetorno) Then
    Begin
      If fMensagem('ATENÇÃO', ObjFatura.MensagemRetorno, ['&Sim', '&Não']) = 2 Then
      Begin
        pReiniciaCamposFaturamentoParcial;
        Abort;
      End
      Else
        pRecalcularFaturamento;
    End
    Else
    Begin
      btnConfirma.Enabled := True;
      pRecalcularFaturamento;
    End;
  End;
end;

function TfrmFaturaLocEqu.fPodeMarcarEquipamento(const blnMostraMensagem: Boolean): Boolean;
begin
  If cdsEqlDet.FieldByName('EQD_DTAENC').AsDateTime > 0 Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Equipamento já foi encerrado.', ['&Ok']);

    Exit(False);
  End;

  If (cdsEqlDet.FieldByName('EQD_DTAIPE').AsDateTime <= 0) And (rdgOpcao.ItemIndex = 0) Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Equipamentos sem a inspeção de entrada.', ['&Ok']);

    Exit(False);
  End;

  If fEmptyStr(cdsEqlDet.FieldByName('EQD_DOCENV').AsString)  Then
  Begin
    If blnMostraMensagem Then
      fMensagem('ATENÇÃO', 'Não foi realizado envio do equipamento.', ['&Ok']);

    Exit(False);
  End;

  Result := ValidarDataReferencia(blnMostraMensagem, cdsEqlDet.FieldByName('AUTOINCREM').AsString, False);
end;

function TfrmFaturaLocEqu.fTemEquipamentosSemDocumentoRetorno: Boolean;
Var
  intRecNo: Integer;
begin
  If Not fCfgSis('VALDRT', VarBoolean) Then
    Exit(False);

  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    Result := False;
    While Not cdsEqlDet.Eof Do
    Begin
      If (cdsEqlDet.FieldByName('EQD_DOCRET').IsNull) or
         (fEmptyStr(cdsEqlDet.FieldByName('EQD_DOCRET').AsString)) Then
      Begin
        Result := True;
        Break
      End;

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

function TfrmFaturaLocEqu.fTemRegistroSelecionado: boolean;
begin
  result := false;
  cdsFatura.First;
  while not cdsFatura.eof do
  begin
    if cdsFatura.FieldByName('IMPRIM').AsBoolean then
    begin
      result := true;
      exit;
    end;
    cdsFatura.next;
  end;
end;

function TfrmFaturaLocEqu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  blnBloquearEdicaoDesc: Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  blnBloquearEdicaoDesc := False;

  If Result Then Begin

    If (Sender = edtNumCon) Then
    Begin
      If fEmptyStr(edtNumCon.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Informe o número do contrato.', ['&Ok']);
        Result := False;
      End
      Else
        Result := fCarregarContrato(edtNumCon.Text);
    End

    Else If (Sender = edtNumPed)  Then
    Begin
      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        fCarregarContrato('', False, edtNumPed.Text);
        If (fEmptyStr(edtNumCon.Text)) And (Not fEmptyStr(edtNumPed.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido informado não é da rotina de Locação de Equipamentos.', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDtaReferencia) And edtDtaReferencia.Enabled Then
    Begin
      Result := ValidarDataReferencia;

      If Result Then
      Begin
        If chkEncerrarEquipamentos.Checked Then
          pEncerrarEquipamento;

        If (blnBloquearEdicaoDesc) And (fVerificaDescontoInformado) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido inserir desconto em faturamento parcial com data de referência inferior à data final de cobrança! ' +
                                'Verifique a data de referência informada.', ['&O k']);
          Result := False;
        End;
        pHabilitarDesabilitarCamposDescontos(Not blnBloquearEdicaoDesc);
      End;
    End

    Else If (Sender = edtHorReferencia) And edtHorReferencia.Enabled Then
    Begin
      Result := ValidarDataReferencia;

      If Result Then
      Begin
        blnBloquearEdicaoDesc := fBloquearEdicaoCamposDesconto;
        If blnBloquearEdicaoDesc And fVerificaDescontoInformado Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido inserir desconto em faturamento parcial com data de referência inferior à data final de cobrança! ' +
                                'Verifique a data de referência informada.', ['&O k']);
          Result := False;
        End;
        pHabilitarDesabilitarCamposDescontos(Not blnBloquearEdicaoDesc);

        pRecalcularFaturamento();
      End;
    End;
  End;

  If ObjContrato.Status = 'A' Then
    btnConfirma.Enabled := Result;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmFaturaLocEqu.fValorFaturado(strNumeroContrato: String): Double;
var
  strSQL: String;
  qrySel: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                              ';
  strSQL := strSQL + '  SUM(EQF_VALFAT) AS EQF_TOTFAT     ';
  strSQL := strSQL + 'FROM                                ';
  strSQL := strSQL + '  EQLFAT                            ';
  strSQL := strSQL + 'INNER JOIN CONEQL                   ';
  strSQL := strSQL + '  ON CONEQL.AUTOINCREM = EQF_SEQCON ';
  strSQL := strSQL + 'WHERE EQL_NROCON = :NROCON          ';

  qrySel := fCriaQuery();
  Try
    With qrySel Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('NROCON').AsString := strNumeroContrato;
      Open;

      Result := FieldByName('EQF_TOTFAT').AsFloat;
    End;
  Finally
    FreeAndNil(qrySel);
  End;
end;

function TfrmFaturaLocEqu.fValorFaturar: Double;
var
  fltTotalFat: Double;
  intRecNo: Integer;
begin
  fltTotalFat := 0.0;

  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      fltTotalFat := fltTotalFat + (cdsEqlDet.FieldByName('EQF_VLAFAT').AsFloat);
      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;

  If fltTotalFat < 0 Then
    fltTotalFat := 0.0;

  Result := fltTotalFat;
end;

function TfrmFaturaLocEqu.fVerificaDescontoInformado: Boolean;
var
  intRecNo: Integer;
begin
  Result := False;

  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        Result := ((cdsEqlDet.FieldByName('EQF_VALDES').AsFloat > 0) Or
                   (cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat > 0)) And
                   (cdsEqlDet.FieldByName('EQD_VLRALT').AsString = 'F') ;

        If Result Then
          Break;
      End;
      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmFaturaLocEqu.grdFaturTableViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  recSel.strCodEql := grdFaturTableView.Controller.SelectedRows[0].Values[grdFaturEQF_SEQEQL.Index];
  recSel.strEmpDoc := grdFaturTableView.Controller.SelectedRows[0].Values[grdFaturEQF_EMPDOC.Index];
  recSel.strEspDoc := grdFaturTableView.Controller.SelectedRows[0].Values[grdFaturEQF_ESPDOC.Index];
  recSel.strNumDoc := grdFaturTableView.Controller.SelectedRows[0].Values[grdFaturEQF_NUMDOC.Index];
end;

procedure TfrmFaturaLocEqu.grdFaturTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: pSetFocus(grdItens);
    VK_RETURN: SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFaturaLocEqu.grdItensViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;

  pMarcarEquipamento((cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'D'), True);
end;

procedure TfrmFaturaLocEqu.grdItensViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If AViewInfo.GridRecord.Values[grdItensEQD_MARDES.Index] = 'M' Then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmFaturaLocEqu.grdItensViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
var
  fltVlrDesc,
  fltPerDesc,
  fltTotLiq: Double;
begin
  inherited;

  If not Assigned(AItem) then
    Exit;

  If not (AItem is TcxGridDBColumn) then
    Exit;

  Case Key of
    VK_RETURN,
    VK_UP,
    VK_DOWN,
    VK_LEFT,
    VK_RIGHT: Begin
                Try
                  If (AItem as TcxGridDBColumn).DataBinding.FieldName = 'EQF_VALDES' then
                  Begin
                    fltVlrDesc := IIF(fEmptyStr(AEdit.EditingValue), 0, AEdit.EditingValue);
                    cdsEqlDet.Edit;
                    cdsEqlDet.FieldByName('EQD_VLRALT').AsString := 'F';
                    cdsEqlDet.Post;
                    Case rdgOpcao.ItemIndex of
                      0: fCalculaValorTotalFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                                   cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                                   0,
                                                   fltVlrDesc,
                                                   cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat,
                                                   True, False, True);
                      1: fCalculaValorParcialFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                                     cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                                     0,
                                                     fltVlrDesc,
                                                     cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat,
                                                     True, False, True);
                    End;

                  End
                  Else
                  If (AItem as TcxGridDBColumn).DataBinding.FieldName = 'EQF_VLRDSC' then
                  Begin
                    fltPerDesc := IIF(fEmptyStr(AEdit.EditingValue), 0, AEdit.EditingValue);
                    cdsEqlDet.Edit;
                    cdsEqlDet.FieldByName('EQD_VLRALT').AsString := 'F';
                    cdsEqlDet.Post;
                    Case rdgOpcao.ItemIndex of
                      0: fCalculaValorTotalFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                                   cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                                   fltPerDesc,
                                                   0,
                                                   cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat, True, False, True);
                      1: fCalculaValorParcialFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                                     cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                                     fltPerDesc,
                                                     0,
                                                     cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat, True, False, True);
                    End;
                  End
                  Else
                  If (AItem as TcxGridDBColumn).DataBinding.FieldName = 'EQF_VLRLIQ' then
                  Begin
                    fltTotLiq := IIF(fEmptyStr(AEdit.EditingValue), 0, AEdit.EditingValue);
                    cdsEqlDet.Edit;
                    cdsEqlDet.FieldByName('EQD_VLRALT').AsString := 'F';
                    cdsEqlDet.Post;
                    Case rdgOpcao.ItemIndex of
                      0: fCalculaValorTotalFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                                   cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                                   cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat,
                                                   cdsEqlDet.FieldByName('EQF_VALDES').AsFloat,
                                                   fltTotLiq, False, True);
                      1: fCalculaValorParcialFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                                     cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                                     cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat,
                                                     cdsEqlDet.FieldByName('EQF_VALDES').AsFloat,
                                                     fltTotLiq, False, True);
                    End;
                  End;

                  pCalcularTotais;
                Except
                  On Erro: Exception Do
                  Begin
                    pMensagensErro(Erro.Message, '[TNotaFiscalContratoLocacao.grdItensViewEditKeyDown]');
                  End;
                End;
              End;
  End;
end;

procedure TfrmFaturaLocEqu.grdItensViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: pSetFocus(edtNumCon);
    VK_RETURN: pMarcarEquipamento((cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'D'), True);
  End;
end;

procedure TfrmFaturaLocEqu.pAdicionarAcessorioGrid(
  const aItem: TAcessorioContratoLocacaoEquipamentos);
begin
  csdEqlAce.Insert;
  csdEqlAce.FieldByName('EQA_SEQEQU').AsString := aItem.CodEquipamento;
  csdEqlAce.FieldByName('EQA_SEQACL').AsString := aItem.Acessorio.AutInc;
  csdEqlAce.FieldByName('CODIGO').AsString     := aItem.Acessorio.Codigo;
  csdEqlAce.FieldByName('DESCRICAO').AsString  := aItem.Acessorio.Descricao;
  csdEqlAce.FieldByName('QUANTIDADE').AsFloat  := aItem.Quantidade;
  csdEqlAce.FieldByName('EQA_VLRCOB').AsFloat  := aItem.ValorCobranca;
  csdEqlAce.FieldByName('EQA_QTDTOT').AsFloat  := aItem.Quantidade * aItem.ItemEquipamento.Quantidade;
  csdEqlAce.FieldByName('EQA_VLRADC').AsFloat  := (aItem.Quantidade * aItem.ItemEquipamento.Quantidade) * aItem.ValorAdicional;

  csdEqlAce.Post;
end;

procedure TfrmFaturaLocEqu.pAdicionarItemGrid(
  const aItem: TItemContratoLocacaoEquipamentos);
begin
  cdsEqlDet.DisableControls;
  csdEqlAce.DisableControls;
  Try
    Try
      cdsEqlDet.Insert;
      cdsEqlDet.FieldByName('EQD_MARDES').AsString   := 'D';
      cdsEqlDet.FieldByName('EQD_SEQEQL').AsString   := aItem.Equipamento.Codigo;
      cdsEqlDet.FieldByName('EQD_DESCRI').AsString   := aItem.Equipamento.Descricao;
      cdsEqlDet.FieldByName('EQD_NSERIE').AsString   := aItem.Equipamento.NumSerie;
      cdsEqlDet.FieldByName('TIPO_CONTRATO').AsString:= aItem.StrTipoCalculoLocacao;
      cdsEqlDet.FieldByName('EQD_TIPDUR').AsString   := arrTpCalculoVlLocacao[aItem.TipoCalculoLocacao];
      cdsEqlDet.FieldByName('EQD_VALHOR').AsFloat    := aItem.ValorLocacaoContratado;
      cdsEqlDet.FieldByName('EQD_TOTEQL').AsFloat    := aItem.ValorTotalLocacaoContratado;
      cdsEqlDet.FieldByName('EQD_PERDES').AsFloat    := aItem.PercentualDesconto;
      cdsEqlDet.FieldByName('EQD_VLLOCL').AsFloat    := aItem.ValorLocacaoLiquido;
      cdsEqlDet.FieldByName('EQD_TOTLIQ').AsFloat    := aItem.ValorTotalLiquido;
      cdsEqlDet.FieldByName('EQL_VLRCAU').AsFloat    := aItem.Equipamento.ValorCaucao;
      cdsEqlDet.FieldByName('EQD_VLRALT').AsString   := IIF(aItem.blnValorLocacaoAlteradoManualmente, 'S', 'N');
      cdsEqlDet.FieldByName('EQD_DOCENV').AsString   := aItem.strDocEnv;
      cdsEqlDet.FieldByName('EQD_DOCRET').AsString   := aItem.strDocRet;
      cdsEqlDet.FieldByName('EQD_QTDDUR').AsFloat    := aItem.Duracao;
      cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat    := aItem.Quantidade;

      cdsEqlDet.FieldByName('EQF_VALDES').AsFloat    := 0;
      cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat    := 0;
      cdsEqlDet.FieldByName('EQF_VLAFAT').AsFloat    := 0;
      cdsEqlDet.FieldByName('EQF_VLJFAT').AsFloat    := 0;
      cdsEqlDet.FieldByName('EQF_VLRFAT').AsFloat    := 0;
      cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat    := 0;
      cdsEqlDet.FieldByName('EQD_VALTOT').AsFloat    := 0;

      If aItem.DataEncerramento > 0 Then
        cdsEqlDet.FieldByName('EQD_DTAENC').AsDateTime := aItem.DataEncerramento
      Else
        cdsEqlDet.FieldByName('EQD_DTAENC').Clear;

      cdsEqlDet.FieldByName('EQF_DIACAL').AsFloat := 0;
      cdsEqlDet.FieldByName('EQF_HORCAL').AsFloat := 0;
      cdsEqlDet.FieldByName('EQF_MESCAL').AsFloat := 0;

      cdsEqlDet.FieldByName('EQD_VALIPE').AsFloat    := aItem.ValorCobranca;
      cdsEqlDet.FieldByName('EQD_VALTOT').AsFloat    := aItem.ValorTotal;
      cdsEqlDet.FieldByName('EQD_DTAIPE').AsDateTime := aItem.DataInspecaoEntrada;
      cdsEqlDet.FieldByName('EQD_UTIFXN').AsString   := aItem.strUtiFaixaNegociacao;
      cdsEqlDet.FieldByName('EQD_DTACOB').AsDateTime := aItem.DataInicialCobranca;
      cdsEqlDet.FieldByName('EQD_DTAFCOB').AsDateTime:= aItem.DataFinalCobranca;

      cdsEqlDet.Post;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadContratoLocEquip.pAdicionarItemGrid]');
      End;
    End;
  Finally
    csdEqlAce.EnableControls;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmFaturaLocEqu.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    TTimeField(FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
    TTimeField(FieldByName('EQL_HORFIN')).DisplayFormat := 'hh:nn';
    TFloatField(FieldByName('EQL_TOTHOR')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('EQL_TOTCON')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('EQL_TOTIPE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('EQL_VALTOT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('EQL_TOTFAT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('EQL_VALRES')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmFaturaLocEqu.pAtivarLabelInfoContrato;
begin
  lblInfoContrato.Visible := False;

  If (ObjContrato.Status = 'F') Then
  Begin
    lblInfoContrato.Caption := 'Contrato totalmente faturado. Carregado somente para consulta.';
    lblInfoContrato.Visible := True;
  End;

  If (ObjContrato.Status = 'E') Then
  Begin
    lblInfoContrato.Caption := 'Contrato Encerrado. Carregado somente para consulta.';
    lblInfoContrato.Visible := True;
  End;

  If (ObjContrato.Status = 'C') Then
  Begin
    lblInfoContrato.Caption := 'Contrato Cancelado. Carregado somente para consulta.';
    lblInfoContrato.Visible := True;
  End;
end;

procedure TfrmFaturaLocEqu.pAtualizaDadosFaturamentoGrid(
  const aItemFatura: TItemFaturamentoContrato);
begin
  If Not Assigned(aItemFatura) Then
    Exit;

  cdsEqlDet.DisableControls;
  Try
     Try
        cdsEqlDet.Edit;
        cdsEqlDet.FieldByName('EQD_VALIPE').AsFloat := aItemFatura.ValorCobranca;
        cdsEqlDet.FieldByName('EQF_VLJFAT').AsFloat := aItemFatura.ValorJaFaturado;
        cdsEqlDet.FieldByName('EQF_VLAFAT').AsFloat := aItemFatura.ValorAFaturar;
        cdsEqlDet.FieldByName('EQF_VLRFAT').AsFloat := aItemFatura.ValorRestanteAFaturar;
        cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat := aItemFatura.ValorDescontoFat;
        cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat := aItemFatura.ValorLiquidoRestante;
        cdsEqlDet.FieldByName('EQD_VALTOT').AsFloat := aItemFatura.ValorTotal;
        cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat := aItemFatura.ValorPerDescontoFat;
        cdsEqlDet.FieldByName('EQF_VALDES').AsFloat := aItemFatura.ValorDescontoFat;
        cdsEqlDet.FieldByName('EQF_DIACAL').AsFloat := aItemFatura.DiasCalc;
        cdsEqlDet.FieldByName('EQF_HORCAL').AsFloat := aItemFatura.HorasCalc;
        cdsEqlDet.FieldByName('EQF_MESCAL').AsFloat := aItemFatura.MesesCalc;

        lblLegendaEquipamento.Visible := (aItemFatura.itemContrato.ValorCobrancaTroca > 0) And (aItemFatura.itemContrato.InspecaoEntradaRealizada);
        If lblLegendaEquipamento.Visible Then
          lblLegendaEquipamento.Caption := 'Item possui valor de cobrança de troca no valor total de: R$ ' +  FormatFloat('#,##0.00', aItemFatura.itemContrato.ValorCobrancaTroca);

        cdsEqlDet.Post;
     except
       on Erro: Exception do
       begin
         pMensagensErro(Erro.Message, '[TNotaFiscalContratoLocacao.pAtualizaDadosFaturamentoGrid]');
       end;
     End;
  Finally
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmFaturaLocEqu.pCalcularTotais;
begin
  edtTotLocEqu.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotalEqlLocacao);
  ObjFatura.pCalcularTotais;
  edtVlrTotIpe.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotalCobrancaInspecao);
  edtVltTotJaFatu.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotalJaFaturado);
  edtVlrTotRestante.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotalRestante);
  edtVlrRestanteLiq.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotalRestanteLiquido);
  edtVlrTot.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotal);
  edtValorFaturamento.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotalFaturar);
  If ((ObjFatura.ValorTotalJaFaturado > 0) or (ObjFatura.objValidaCtr.fContratoPossuiValorFaturado)) Then
  Begin
    edtTaxEnt.Text := FormatFloat('#,##0.00', 0);
  End
  Else
  Begin
    edtTaxEnt.Text := FormatFloat('#,##0.00', ObjContrato.ValorTaxaEntrega);
  End;
  edtVlrAdc.Text := FormatFloat('#,##0.00', ObjFatura.ValorTotalAdicionalAcessorio);
end;

procedure TfrmFaturaLocEqu.pCalculaValorFaturar(blnRecalcularDesconto: Boolean;
  blnReacalcularTotaisLiq: Boolean);
begin

  objFatura.DataReferencia  := fObterDataReferencia;
  If objFatura.DataReferencia <= 0 Then
    Exit;

  Case rdgOpcao.ItemIndex of
    0: fCalculaValorTotalFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                 cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                 cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat,
                                 cdsEqlDet.FieldByName('EQF_VALDES').AsFloat,
                                 cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat,
                                 blnRecalcularDesconto,
                                 blnReacalcularTotaisLiq,
                                 cdsEqlDet.FieldByName('EQD_VLRALT').AsString = 'F');
    1: fCalculaValorParcialFaturar(cdsEqlDet.FieldByName('EQD_MARDES').AsString,
                                   cdsEqlDet.FieldByName('EQD_SEQEQL').AsString,
                                   cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat,
                                   cdsEqlDet.FieldByName('EQF_VALDES').AsFloat,
                                   cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat,
                                   blnRecalcularDesconto,
                                   blnReacalcularTotaisLiq,
                                   cdsEqlDet.FieldByName('EQD_VLRALT').AsString = 'F');
  End;

  pCalcularTotais;
end;

procedure TfrmFaturaLocEqu.pEncerrarContrato;
var
  LEncerrou: Boolean;
begin
  try
    fStartTransaction;
    LEncerrou := ObjFatura.fEncerrarContrato(True);

    If LEncerrou Then
    Begin
      fCommit;
      FobjLock.fLock_Unlock(cst_TRAVA_FATURA_LOCEQU + objContrato.AutInc, False, False);
      fCarregarContrato(edtNumCon.Text, False);
    End
    Else
    Begin
      fRollback;

      If Not fEmptyStr( ObjFatura.MensagemRetorno) Then
        fMensagem('ATENÇÃO!', ObjFatura.MensagemRetorno  , ['&O k']);
    End;
  except
    fRollback;
  end;
end;

procedure TfrmFaturaLocEqu.pEncerrarEquipamento;
begin
  ObjFatura.DataReferencia := fObterDataReferencia;
  ObjFatura.pMarcaEncerrarItens(chkEncerrarEquipamentos.Checked);

  If Not chkEncerrarEquipamentos.Checked Then
  Begin
    btnConfirma.Enabled := True;
    pRecalcularFaturamento;
    Exit;
  End;

  If Not ObjFatura.fValidaEncerramentoContrato Then
  Begin
    fMensagem('ATENÇÃO!', ObjFatura.MensagemRetorno, ['&O k']);
    pReiniciaCamposFaturamentoParcial;
    Exit;
  End
  Else
  Begin
    If Not fEmptyStr(ObjFatura.MensagemRetorno) Then
    Begin
      If fMensagem('ATENÇÃO', ObjFatura.MensagemRetorno, ['&Sim', '&Não']) = 2 Then
      Begin
        pReiniciaCamposFaturamentoParcial;
        Abort;
      End
      Else
        pRecalcularFaturamento;
    End
    Else
    Begin
      btnConfirma.Enabled := True;
      pRecalcularFaturamento;
    End;
  End;
end;

procedure TfrmFaturaLocEqu.pFormatarCampos;
begin
  TTimeField(cdsEqlDet.FieldByName('EQD_DTACOB')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsEqlDet.FieldByName('EQD_DTAFCOB')).DisplayFormat  := 'dd/mm/yyyy hh:nn';
  TTimeField(cdsEqlDet.FieldByName('EQD_DTAENC')).DisplayFormat  := 'dd/mm/yyyy';

  TFloatField(cdsEqlDet.FieldByName('EQD_VALHOR')).DisplayFormat := FstrLocDec;
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTEQL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_VALIPE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_VALTOT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_QTDDUR')).DisplayFormat := '#,##0.00';

  TFloatField(cdsEqlDet.FieldByName('EQF_VLJFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLAFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLRFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLRDSC')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VLRLIQ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQF_VALDES')).DisplayFormat := '#,##0.00';

  TFloatField(csdEqlAce.FieldByName('EQA_VLRCOB')).DisplayFormat := '#,##0.00';
  TFloatField(csdEqlAce.FieldByName('EQA_VLRADC')).DisplayFormat := '#,##0.00';

end;

procedure TfrmFaturaLocEqu.pHabilitarDesabilitarCamposDescontos(
  const blnHabilitar: Boolean);
var
  intRecNo: Integer;
begin
  grdItensEQF_VLRDSC.Options.Editing := blnHabilitar;
  grdItensEQF_VLRLIQ.Options.Editing := blnHabilitar;
  grdItensEQF_VALDES.Options.Editing := blnHabilitar;

  If Not blnHabilitar Then
  Begin
    cdsEqlDet.DisableControls;
    intRecNo := cdsEqlDet.RecNo;
    Try
      cdsEqlDet.First;
      While Not cdsEqlDet.Eof Do
      Begin
        If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M' Then
        Begin
          cdsEqlDet.Edit;
          cdsEqlDet.FieldByName('EQF_VALDES').AsFloat := 0;
          cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat := 0;
          cdsEqlDet.Post;
        End;
        cdsEqlDet.Next;
      End;
    Finally
      cdsEqlDet.RecNo := intRecNo;
      cdsEqlDet.EnableControls;
    End;
  End;
end;

procedure TfrmFaturaLocEqu.pImprimirFaturaContLoc;
Var
  qryFatura: TUniQuery;
  frmImpFaturaContrato: TfrmImpFaturaContrato;
  objImpressao: TImpressaoFatLocacao;

  objImpressaofat: TEditorFastImpressao;
  blnOk: Boolean;
  strTpLayout: string;
  strNomArq: String;
begin
  qryFatura := fCriaQuery;
  pCriarFormularios(TfrmImpFaturaContrato, frmImpFaturaContrato);
  objImpressao := TImpressaoFatLocacao.Create('frmFaturaLocEqu');
  cdsFatura.CreateDataSet;
  objImpressaofat := TEditorFastImpressao.Create(Nil);
  Try
    If Not objImpressao.fAddFatura(ObjContrato, recSel.strEspDoc, recSel.strEmpDoc, recSel.strNumDoc) Then
    Begin
      If Not fEmptyStr(objImpressao.strMensagemRetorno) Then
      Begin
        fMensagem('ATENÇÃO', objImpressao.strMensagemRetorno, ['&Ok']);
        Exit;
      End;
    End;

    qryFatura.Close;
    qryFatura.SQL.Clear;
    qryFatura.SQL.Add(' SELECT CTR_NUMDUP, ');
    qryFatura.SQL.Add('        CTR_ESPDOC, ');
    qryFatura.SQL.Add('        CTR_CODEMP, ');
    qryFatura.SQL.Add('        CTR_PARCEL, ');
    qryFatura.SQL.Add('        CTR_DTAVEN, ');
    qryFatura.SQL.Add('        CTR_VALDUP, ');
    qryFatura.SQL.Add('        CTR_DTAREC, ');
    qryFatura.SQL.Add('        CTR_VALREC  ');
    qryFatura.SQL.Add(' FROM CADREC ');
    qryFatura.SQL.Add(' WHERE CTR_NUMDUP = :NUMDOC ');
    qryFatura.SQL.Add('   AND CTR_ESPDOC = :ESPDOC ');
    qryFatura.SQL.Add('   AND CTR_CODEMP = :EMPDOC ');

    qryFatura.ParamByName('NUMDOC').asString := recSel.strNumDoc;
    qryFatura.ParamByName('ESPDOC').asString := recSel.strEspDoc;
    qryFatura.ParamByName('EMPDOC').asString := recSel.strEmpDoc;

    qryFatura.Open;

    If Not qryFatura.IsEmpty then
    Begin
      frmImpFaturaContrato.cdsSelecaoFaturas.DisableControls;
      frmImpFaturaContrato.cdsSelecaoFaturas.CreateDataSet;
      qryFatura.First;
      while not qryFatura.Eof do
      Begin
        frmImpFaturaContrato.cdsSelecaoFaturas.Insert;
        frmImpFaturaContrato.cdsSelecaoFaturasIMPRIM.AsBoolean      := False;
        frmImpFaturaContrato.cdsSelecaoFaturasCTR_NUMDUP.AsString   := qryFatura.FieldByName('CTR_NUMDUP').AsString;
        frmImpFaturaContrato.cdsSelecaoFaturasCTR_ESPDOC.AsString   := qryFatura.FieldByName('CTR_ESPDOC').AsString;
        frmImpFaturaContrato.cdsSelecaoFaturasCTR_CODEMP.AsString   := qryFatura.FieldByName('CTR_CODEMP').AsString;
        frmImpFaturaContrato.cdsSelecaoFaturasCTR_PARCEL.AsString   := qryFatura.FieldByName('CTR_PARCEL').AsString;
        frmImpFaturaContrato.cdsSelecaoFaturasCTR_DTAVEN.AsDateTime := qryFatura.FieldByName('CTR_DTAVEN').AsDateTime;
        frmImpFaturaContrato.cdsSelecaoFaturasCTR_VALDUP.AsFloat    := qryFatura.FieldByName('CTR_VALDUP').AsFloat;

        If not (qryFatura.FieldByName('CTR_DTAREC').isNull) Then
          frmImpFaturaContrato.cdsSelecaoFaturasCTR_DTAREC.Value := qryFatura.FieldByName('CTR_DTAREC').Value;

        frmImpFaturaContrato.cdsSelecaoFaturasCTR_VALREC.AsFloat    := qryFatura.FieldByName('CTR_VALREC').AsFloat;
        frmImpFaturaContrato.cdsSelecaoFaturas.Post;
        qryFatura.Next;
      End;

      frmImpFaturaContrato.cdsSelecaoFaturas.EnableControls;
      frmImpFaturaContrato.ShowModal;
      cdsFatura.CloneCursor(frmImpFaturaContrato.cdsSelecaoFaturas, true);
      if not fTemRegistroSelecionado then
      begin
        fMensagem('Atenção','Não foi selecionada nenhuma parcela para impressão.', ['&Ok']);
      end
      else
      begin
        if not frmImpFaturaContrato.blnFecharComEscape then
        begin
          blnOK := false;
          strTpLayout := 'Fatura Contrato de Locação';

          objImpressaofat.recDocume.strNumDoc := recSel.strNumDoc;
          objImpressaofat.recDocume.strCodEmp := recSel.strEmpDoc;
          objImpressaofat.recDocume.strEspDoc := recSel.strEspDoc;
          objImpressaofat.recDocume.strCodCli := qryContrato.FieldByName('EQL_CODCLI').AsString;
          objImpressaofat.tpeTipoEtiqueta     := tpeFaturaLocacao;

          objImpressaofat.recDocume.intQtdImp := 1;
          objImpressaofat.recDocume.blnVisPdf := True;
          objImpressaofat.recDocume.blnGerPdf := True;

          frmImpFaturaContrato.cdsSelecaoFaturas.First;
          while not frmImpFaturaContrato.cdsSelecaoFaturas.Eof do
          Begin
            If frmImpFaturaContrato.cdsSelecaoFaturas.FieldByName('IMPRIM').AsBoolean = True Then
            Begin
              objImpressaofat.recDocume.strParcel := frmImpFaturaContrato.cdsSelecaoFaturasCTR_PARCEL.AsString;
              strNomArq := Format('%s-%s-%s-%s',[recSel.strNumDoc, recSel.strEmpDoc, recSel.strEspDoc, objImpressaofat.recDocume.strParcel]);
              blnOk := objImpressaofat.fImprimeDocumento(tpaNormal, ExtractFilePath(Application.ExeName) + 'Faturas_contrato_locacao\', strNomArq);
            End;
            frmImpFaturaContrato.cdsSelecaoFaturas.Next;
          end;

          If Not blnOk Then
            pMensagemOk('Layout ' + strTpLayout + ' não está configurado.');
        End;
      end;
    End;
  Finally
    cdsFatura.Close;
    pFreeAndNil(frmImpFaturaContrato);
    FreeAndNil(objImpressaofat);
    FreeAndNil(objImpressao);
  End;
end;

procedure TfrmFaturaLocEqu.pLimpaCampos;
begin
  edtDtaReferencia.Text    := '';
  edtHorReferencia.Text    := '';
  edtValorFaturamento.Text := '';
  edtNumPedAd.Text := '';

  recSel.strCodEql := EmptyStr;
  recSel.strEmpDoc := EmptyStr;
  recSel.strEspDoc := EmptyStr;
  recSel.strNumDoc := EmptyStr;

  cdsEqlDet.EmptyDataSet;
  csdEqlAce.EmptyDataSet;
end;

procedure TfrmFaturaLocEqu.pLimpardadosFaturamento;
var
  itemContrato: TItemContratoLocacaoEquipamentos;
begin
  If Not Assigned(ObjFatura) Then
    Exit;

  ObjFatura.fRemoveItem(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);

  itemContrato := ObjContrato.fRetornaItemContrato(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);

  cdsEqlDet.Edit;
  cdsEqlDet.FieldByName('EQF_VLAFAT').AsFloat := 0;
  cdsEqlDet.FieldByName('EQF_VLRLIQ').AsFloat := 0;
  cdsEqlDet.FieldByName('EQF_VLRFAT').AsFloat := 0;
  cdsEqlDet.FieldByName('EQF_VLRDSC').AsFloat := IIF(assigned(itemContrato), itemContrato.PercentualDesconto, 0);
  cdsEqlDet.FieldByName('EQF_VALDES').AsFloat := IIF(assigned(itemContrato), itemContrato.ValorDesconto, 0);
  cdsEqlDet.Post;

  recSel.strCodEql := EmptyStr;
  recSel.strEmpDoc := EmptyStr;
  recSel.strEspDoc := EmptyStr;
  recSel.strNumDoc := EmptyStr;

  ObjFatura.pCalcularTotais;
  pCalcularTotais;

  lblLegendaEquipamento.Visible := False;
end;

procedure TfrmFaturaLocEqu.pMarcarEquipamento(const blnMarcar: Boolean;
  blnMostrarMensagem: Boolean);
begin
  If Not fPodeMarcarEquipamento(blnMostrarMensagem) Then
    Exit;

  cdsEqlDet.Edit;
  cdsEqlDet.FieldByName('EQD_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsEqlDet.Post;

  pLimpardadosFaturamento;
  If blnMarcar Then
    pCalculaValorFaturar(False, False);

  pCalcularTotais;


end;

procedure TfrmFaturaLocEqu.pMarcarTodos(const blnMarcar: Boolean);
var
  intRecNo: Integer;
begin
  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      pMarcarEquipamento(blnMarcar, False);

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmFaturaLocEqu.pRecalcularFaturamento;
Var
  intRecNo: Integer;
begin
  If Not Assigned(objFatura) Then
  Begin
    Exit;
  End;

  objFatura.DataReferencia  := fObterDataReferencia;
  objFatura.TipoFaturamento := IIF(rdgOpcao.ItemIndex = 1, tpParcial, tpTotal);

  cdsEqlDet.DisableControls;
  intRecNo := cdsEqlDet.RecNo;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If (cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M') Then
      Begin
        pCalculaValorFaturar(True, False);
      End;
      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmFaturaLocEqu.pReiniciaCamposFaturamentoParcial;
begin
  If chkEncerrarEquipamentos.Checked Then
  Begin
    ObjFatura.DataReferencia;
    edtDtaReferencia.Clear;
    edtHorReferencia.Clear;
    chkEncerrarEquipamentos.Checked := False;
    btnConfirma.Enabled := False;
  End
  Else
  Begin
    btnConfirma.Enabled := True;
  End;
end;

procedure TfrmFaturaLocEqu.pSugerirDataReferencia;
begin
  pnlObservacoes.Visible := False;
  Case rdgOpcao.ItemIndex Of
    0: Begin
         If objContrato.TipoDuracaoContrato = 'M' Then
         Begin
           edtDtaReferencia.Text := qryContrato.FieldByName('EQL_MESFIN').DisplayText;
           edtHorReferencia.Text := '23:59';
         End
         Else
         Begin
           edtDtaReferencia.Text := qryContrato.FieldByName('EQL_DTAFIN').DisplayText;
           edtHorReferencia.Text := qryContrato.FieldByName('EQL_HORFIN').DisplayText;
         End;
       End;
    1: Begin
           If objContrato.TipoDuracaoContrato = 'M' Then
           Begin
             edtDtaReferencia.Text := qryContrato.FieldByName('EQL_MESFIN').DisplayText;
             edtHorReferencia.Text := '23:59';
           End
           Else
           Begin
             ObjFatura.pVerificaDtaHraCobranca;
             If (ObjFatura.dtaIniCobranca + ObjFatura.hraIniCobranca) <> ObjFatura.Contrato.DataFinalEstimada  Then
             Begin
               pnlObservacoes.Visible := True;
             End;
             edtDtaReferencia.Text := DateTimeToStr(ObjFatura.dtaIniCobranca);
             edtHorReferencia.Text := FormatDateTime('hh:mm', ObjFatura.hraIniCobranca);
           End;
       End;
  End;
end;

procedure TfrmFaturaLocEqu.rdgOpcaoClick(Sender: TObject);
var
  blnBloquearEdicaoDesc: Boolean;
begin
  inherited;

  pSugerirDataReferencia;

  Case rdgOpcao.ItemIndex Of
    0: Begin
         edtDtaReferencia.Enabled := False;
         edtHorReferencia.Enabled := False;
         edtDtaReferencia.NormalColor := $00FFDFB8;
         edtHorReferencia.NormalColor := $00FFDFB8;
         ObjContrato.pCarregarDuracaoContrato;
         ObjContrato.pCarregarItensContrato;
         chkEncerrarEquipamentos.Enabled := False;
         pHabilitarDesabilitarCamposDescontos(True);
         pRecalcularFaturamento;
         btnConfirma.Enabled := True;
       End;
    1: Begin
         edtDtaReferencia.Enabled := True;
         edtHorReferencia.Enabled := True;
         edtDtaReferencia.NormalColor := clWindow;
         edtHorReferencia.NormalColor := clWindow;
         chkEncerrarEquipamentos.Enabled := True;
         chkEncerrarEquipamentos.Checked := False;
         blnBloquearEdicaoDesc:= fBloquearEdicaoCamposDesconto;
         If (blnBloquearEdicaoDesc) And fVerificaDescontoInformado Then
         Begin
           fMensagem('ATENÇÃO!', 'Não é permitido inserir desconto em faturamento parcial com data de referência inferior à data final de cobrança! ' +
                                 'Verifique a data de referência informada.', ['&O k']);
           Exit;
         End;
         pRecalcularFaturamento;
       End;
  End;
end;

function TfrmFaturaLocEqu.ValidaConfirmacaoFaturamentoAntecipado: Boolean;
begin
  Result := True;

  If ObjFatura.TodosEquipamentosMarcadosFaturar And
     (fFormataFloat(ObjFatura.ValorTotalRestante, FintLocDec) = 0.00) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para emitir fatura de sem valor restante a faturar deverá ser utilizada a opção "Faturamento total" do contrato"!', ['&O k']);
    Exit(False);
  End;

  If (fFormataFloat(ObjFatura.ValorTotalFaturar, FintLocDec) = 0.00) And
     (Not chkEncerrarEquipamentos.Checked)Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum valor a ser faturado!', ['&O k']);
    Exit(False);
  End;

  If (Not ObjFatura.fTemEquipamentosSemInspecaoEntrada) And
     (Not fTemEquipamentosSemDocumentoRetorno) And
     (fFormataFloat(ObjFatura.ValorTotalFaturar, FintLocDec) = fFormataFloat(ObjFatura.ValorTotalRestante, FintLocDec)) And
     (fFormataFloat(qryContrato.FieldByName('EQL_TOTIPE').AsFloat, 2) = 0.00) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já foram informados todos os documentos de retorno e foram feitas todas as inspeções de entrada e nessas inspeções não foram informados valores de cobrança extra. Por favor, realize o faturamento total do contrato!', ['&O k']);
    Exit(False);
  End;

  If (Not ObjFatura.objValidaCtr.fContratoPossuiInspecaoEntradaAberto) And
     (ObjFatura.ValorTotalCobrancaInspecao > 0.00) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já foi informado data de retorno de todos os equipamentos e foi informado valor extra de cobrança. Por favor, realize o faturamento total do contrato!', ['&O k']);
    Exit(False);
  End;

  If (chkEncerrarEquipamentos.Checked) Then
  Begin
    If (ObjFatura.fTemEquipamentosSemInspecaoEntrada) Then
    Begin
      fMensagem('ATENÇÃO!', 'Equipamento marcado para encerrar não possui inspeção de entrada, verifique!', ['&O k']);
      Exit(False);
    End;
  End;
end;

function TfrmFaturaLocEqu.ValidaConfirmacaoFaturamentoComEncerramento: Boolean;
begin
  Result := True;

  If fTemEquipamentosSemDocumentoRetorno Then
  Begin
    fMensagem('ATENÇÃO!', 'Existem equipamentos sem documento de retorno, portanto não poderá ser feito o faturamento total!', ['&O k']);
    Exit(False);
  End;

  If (ObjFatura.ValorTotalFaturar = 0.00) And
     (ObjFatura.objValidaCtr.fContratoPossuiInspecaoEntradaAberto) Then
  Begin
    fMensagem('ATENÇÃO', 'Não existem valores para serem faturados, portanto não será emitida nota fiscal de serviço.', ['&O k']);
    Exit(False);
  End;

end;

function TfrmFaturaLocEqu.ValidarDataReferencia(const AMostraMensagem: Boolean = True;
  ASeqEql: String = ''; AItemMarcado: Boolean = True): Boolean;
var
  dteTeste: TDateTime;
begin

  If fEmptyStr(fTiraCaracEspeciais(edtDtaReferencia.Text)) Then
  Begin
    If AMostraMensagem Then
      fMensagem('ATENÇÃO!', 'A data de referência deve ser preenchida!', ['&O k']);
    Exit(False)
  End
  Else
  If Not TryStrToDate(edtDtaReferencia.Text, dteTeste) Then
  Begin
    If AMostraMensagem Then
      fMensagem('ATENÇÃO!', 'Data de referência inválida!', ['&O k']);
    Exit(False)
  End
  Else
  If fEmptyStr(fTiraCaracEspeciais(edtHorReferencia.Text, True, True, False, True)) Then
  Begin
    If AMostraMensagem Then
      fMensagem('ATENÇÃO!', 'A hora de referência deve ser preenchida!', ['&O k']);
    Exit(False)
  End
  Else
  If Not TryStrToTime(edtHorReferencia.Text, dteTeste) Then
  Begin
    If AMostraMensagem Then
      fMensagem('ATENÇÃO!', 'Hora de referência inválida!', ['&O k']);
    Exit(False)
  End;

  If fCfgSis('VALDTF', VarBoolean)Then
    Result := ValidarDataReferenciaDataEstimadaCapaContrato(AMostraMensagem)
  Else
    Result := ValidarDataReferenciaDataEstimadaFinalCobrancaItem(AMostraMensagem, ASeqEql, AItemMarcado);
end;

function TfrmFaturaLocEqu.ValidarDataReferenciaDataEstimadaCapaContrato(const AMostraMensagem: Boolean = True): Boolean;
var
  dtaFinalEstimada: TDateTime;
begin
  Result := True;

  If rdgOpcao.ItemIndex = 0 Then
    Exit(True);

  If objContrato.TipoDuracaoContrato = 'M' Then
    dtaFinalEstimada := IncMonth(objContrato.DataInicialEstimada, objContrato.TotalMeses)
  Else
    dtaFinalEstimada := objContrato.DataInicialEstimada + objContrato.TotalDias;

  If (fObterDataReferencia <= fMinReferencia(True)) Then
  Begin
    If AMostraMensagem Then
      fMensagem('ATENÇÃO!', 'Data de referência não pode ser menor que a data inicial do contrato nem menor que a data referência da última fatura!', ['&O k']);
    Result := False;
  End
  Else
  If (fObterDataReferencia >  fMaxReferencia(True)) Then
  Begin
    If AMostraMensagem Then
      fMensagem('ATENÇÃO!', 'Data de referência não pode ser maior que a data final de contrato nem maior que a data final de cobrança do item!', ['&O k']);
    Result := False;
  End
  Else
  If (fObterDataReferencia > dtaFinalEstimada) Then
  Begin
    If AMostraMensagem Then
     fMensagem('ATENÇÃO!', 'Data de referência não pode ser maior que a data final do contrato!', ['&O k']);
    Result := False;
  End
end;

function TfrmFaturaLocEqu.ValidarDataReferenciaDataEstimadaFinalCobrancaItem(const AMostraMensagem: Boolean = True;
  ASeqEql: String = ''; AItemMarcado: Boolean = True): Boolean;
var
  LRec: Integer;
  LdtaFCob: TDateTime;
  LdtaICob: TDateTime;
  LDtaRef: TDateTime;
begin
  Result := True;

  If rdgOpcao.ItemIndex = 0 Then
    Exit(True);

  LDtaRef := fObterDataReferencia;
  LRec := cdsEqlDet.RecNo;
  cdsEqlDet.DisableControls;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.EOF Do
    Begin
      If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'M' Then
      Begin
        If AItemMarcado Then
        Begin
          If cdsEqlDet.FieldByName('EQD_MARDES').AsString = 'N' Then
            cdsEqlDet.Next;
        End;

        If Not fEmptyStr(ASeqEql) Then
        Begin
          If Not (cdsEqlDet.FieldByName('AUTOINCREM').AsString = ASeqEql) Then
            cdsEqlDet.Next;
        End;

        LdtaFCob := cdsEqlDet.FieldByName('EQD_DTAFCOB').AsDateTime ;
        LdtaICob := cdsEqlDet.FieldByName('EQD_DTACOB').AsDateTime ;

        If LDtaRef > LdtaFCob Then
        Begin
          If AMostraMensagem Then
            fMensagem('ATENÇÃO!', 'Data de referência não pode ser maior que a data final de cobrança do item  "' +
                                   cdsEqlDet.FieldByName('EQD_SEQEQL').AsString + '-' + cdsEqlDet.FieldByName('EQD_DESCRI').AsString + '" !', ['&O k']);
          Exit(False);
        End;

        If LDtaRef < LdtaICob Then
        Begin
          If AMostraMensagem Then
            fMensagem('ATENÇÃO!', 'Data de referência não pode ser menor que a data inicial de cobrança do item  "' +
                                   cdsEqlDet.FieldByName('EQD_SEQEQL').AsString + '-' + cdsEqlDet.FieldByName('EQD_DESCRI').AsString + '" !', ['&O k']);
          Exit(False);
        End;

      End;
      cdsEqlDet.Next;
    End;

  Finally
    cdsEqlDet.RecNo := LRec;
    cdsEqlDet.EnableControls;
  End;
end;

function TfrmFaturaLocEqu.ValidarEncerrarContratoSemFaturar: Boolean;
begin
  Result := False;

  If (ObjFatura.ValorTotalFaturar > 0.00) Then
    Exit(False);

  If (ObjFatura.objValidaCtr.fContratoPossuiInspecaoEntradaAberto) Then
    Exit(False);

  If (ObjFatura.ValorTotalFaturar = 0.00) Then
  Begin
    fMensagem('ATENÇÃO', 'Não existem valores para serem faturados, portanto não será emitida nota fiscal de serviço mas o contrato terá o status alterado para "FATURADO".', ['&O k']);
    Result := True;
  End;
end;

function TfrmFaturaLocEqu.ValidarExistemEquipamentosSemEnvio: Boolean;
var
  LCont: Integer;
  LNroDocSemEnv: Integer;
  LMarcar: Boolean;
begin
  LNroDocSemEnv := 0;
  LMarcar:= False;

  For LCont := 0 to objContrato.Itens.Count -1 Do
  Begin
    LMarcar := (objContrato.Itens[LCont].DataEncerramento <= 0) And
               (objContrato.Status = 'A') ;

    IF LMarcar Then
    Begin
      If fEmptyStr(objContrato.Itens[LCont].strDocEnv) Then
        Inc(LNroDocSemEnv);
    End;
  End;

  If LMarcar And (LNroDocSemEnv > 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Existem equipamentos neste contrato que ainda não foram enviados para o cliente!', ['&Ok']);
    Result := False;
    Exit;
  End
  Else
    Result := True;
end;

function TfrmFaturaLocEqu.fCarregaDetalhes: Boolean;
var
  intCnt,
  intCont: Integer;
begin
  If cdsEqlDet.Active Then
    cdsEqlDet.EmptyDataSet;

  If csdEqlAce.Active Then
    csdEqlAce.EmptyDataSet;

  For intCont := 0 to objContrato.Itens.Count -1 Do
  Begin
    pAdicionarItemGrid(objContrato.Itens[intCont]);
    For intCnt := 0 to objContrato.Itens[intCont].Acessorios.Count-1 Do
    Begin
      pAdicionarAcessorioGrid(objContrato.Itens[intCont].Acessorios[intCnt]);
    End;
  End;

  Result := True;
end;

function TfrmFaturaLocEqu.fCarregaFaturamentos(strCodContrato: String): Boolean;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  *,                       ';
  strSQL := strSQL + '  CONCAT(                  ';
  strSQL := strSQL + '    EQF_NUMDOC,            ';
  strSQL := strSQL + '    "-",                   ';
  strSQL := strSQL + '    EQF_ESPDOC,            ';
  strSQL := strSQL + '    "-",                   ';
  strSQL := strSQL + '    EQF_EMPDOC             ';
  strSQL := strSQL + '  ) AS EQF_DOCFAT          ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  EQLFAT                   ';
  strSQL := strSQL + 'WHERE EQF_SEQCON = :SEQCON ';

  With qryEqlFat Do
  Begin
    Close;
    SQL.Text := strSQL;
    ParamByName('SEQCON').AsString := strCodContrato;
    Open;

    TFloatField(FieldByName('EQF_QTDHOR')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('EQF_VALFAT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('EQF_HORREF')).DisplayFormat := 'hh:nn';
    FieldByName('EQF_CONPAG').EditMask := '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';

    Result := True;
  End;
end;

procedure TfrmFaturaLocEqu.pImprimeRecibo(blnEnviarEmail: Boolean);
Var
  objImpressao: TImpressaoFatLocacao;
begin
  objImpressao := TImpressaoFatLocacao.Create('frmFaturaLocEqu');
  Try
    If Not objImpressao.fAddFatura(ObjContrato,
                                   recSel.strEspDoc,
                                   recSel.strEmpDoc,
                                   recSel.strNumDoc) Then
    Begin
      If Not fEmptyStr(objImpressao.strMensagemRetorno) Then
      Begin
        fMensagem('ATENÇÃO', objImpressao.strMensagemRetorno, ['&Ok']);
        Exit;
      End;
    End;

    If Not objImpressao.fImprmirReciboFat(tpaNormal) Then
    Begin
      If Not fEmptyStr(objImpressao.strMensagemRetorno) Then
        fMensagem('ATENÇÃO', objImpressao.strMensagemRetorno, ['&Ok']);
    End;

    If blnEnviarEmail Then
    Begin
      If objImpressao.fImprmirReciboFat(tpaPDF) Then
      Begin
        fDisparaEmailAutomatico(recSel.strNumDoc, recSel.strEspDoc, recSel.strEspDoc, '',
                                'RL', '',  ObjContrato.CodCliente,  '', '', TGeraArquivoAnexoEmail.fNew(objImpressao.strNomArq));
      End
      Else
        If Not fEmptyStr(objImpressao.strMensagemRetorno) Then
          fMensagem('ATENÇÃO', objImpressao.strMensagemRetorno, ['&Ok']);
    End;

  Finally
    FreeAndNil(objImpressao);
  End;
end;

function TfrmFaturaLocEqu.fMaxReferencia(blnHoras: Boolean): TDateTime;
begin
  If objFatura.ListaItens.Count > 1 Then
  Begin
    If blnHoras Then
      Result := StrToDateTime(edtDtaFin.Text + ' ' + edtHorFin.Text)
    Else
      Result := StrToDate(edtDtaFin.Text);
  End
  Else
    Result := IIF(blnHoras, cdsEqlDet.FieldByName('EQD_DTAFCOB').AsDateTime,
                            fObtemData(cdsEqlDet.FieldByName('EQD_DTAFCOB').AsDateTime));
end;

function TfrmFaturaLocEqu.fMinReferencia(blnHoras: Boolean): TDateTime;
var
  intRecNo: Integer;
  dtmDthFat: TDateTime;
begin
  Result := 0;

  If fEmptyDate(edtDtaReferencia.Text) Then
    Exit;

  If fEmptyDate(edtHorReferencia.Text) Then
    Exit;

  qryEqlFat.DisableControls;
  intRecNo := qryEqlFat.RecNo;
  Try
    qryEqlFat.First;
    While Not qryEqlFat.Eof Do
    Begin
      If blnHoras Then
        dtmDthFat := StrToDateTimeDef(qryEqlFat.FieldByName('EQF_DTAREF').AsString + ' ' + qryEqlFat.FieldByName('EQF_HORREF').AsString, 0)
      Else
        dtmDthFat := StrToDateDef(qryEqlFat.FieldByName('EQF_DTAREF').AsString, 0);

      If dtmDthFat > Result Then
        Result := dtmDthFat;

      qryEqlFat.Next;
    End;
  Finally
    qryEqlFat.RecNo := intRecNo;
    qryEqlFat.EnableControls;
  End;

  If Result > 0 Then
    Exit;

  If objFatura.ListaItens.Count > 1 Then
  Begin
    If blnHoras Then
      Result := StrToDateTime(edtDtaIni.Text + ' ' + edtHorIni.Text)
    Else
      Result := StrToDate(edtDtaIni.Text);
    End
  Else
    Result := IIF(blnHoras, cdsEqlDet.FieldByName('EQD_DTACOB').AsDateTime,
                            fObtemData(cdsEqlDet.FieldByName('EQD_DTACOB').AsDateTime));
end;

function TfrmFaturaLocEqu.fObterDataReferencia: TDateTime;
begin
  Result := 0;
  Try
    If fEmptyDate(edtDtaReferencia.Text) Then
      Exit;

    If fEmptyDate(edtHorReferencia.Text) Then
      Exit;

    FDataReferencia := StrToDateTime(edtDtaReferencia.Text + ' ' + edtHorReferencia.Text);

    Result := FDataReferencia;
  Except
    Result := 0;
  End;
end;

procedure TfrmFaturaLocEqu.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(cst_TRAVA_FATURA_LOCEQU + objContrato.AutInc, False, False);
  FreeAndNil(FobjLock);

  If Assigned(objFatura) Then
    FreeAndNil(objFatura);

  If Assigned(objContrato) Then
    FreeAndNil(objContrato);

end;

end.
