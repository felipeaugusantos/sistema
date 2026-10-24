unit untCadContratoLocEquip;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.strUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel, cxGrid,
  EditFocus, cxContainer, cxTextEdit, untPaiCad, Vcl.DBCtrls, DBEditFocus,
  Vcl.Mask, Uni, DBLookupComboBoxFocus, ComboBoxFocus, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, untCadLote, untLiberacao,
  untMsgLiberacao, untFuncFat, untTypesSistema, MaskEditFocus, cadastro.Model.ContratoLocacaoEquipamentos,
  cadastro.Model.EquipamentoLocacao, Datasnap.DBClient, cxCurrencyEdit,
  CurrencyEditFocus, untDigCndPagamentoFrame, cxGroupBox, UniClientDataSet, cadastro.Controller.ContratoLocacaoEquipamentos,
  dxBarBuiltInMenu, cxPC, DBAccess, untTypesLocEqu, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxCheckBox, untCliCtt, System.Contnrs, untTLock,
  faturamento.Classes.ManutencaoLocEqu, untGravando, cxProgressBar;

type
  TfrmCadContratoLocEquip = class(TfrmPaiCad)
    pnlCabecalho: TPanel;
    btnImprimir: TBitBtnLocked;
    lblNumCon: TLabel;
    edtNumCon: TDBEditFocus;
    lblStatus: TLabel;
    cmbStatus: TComboBoxFocus;
    dtsTabela: TDataSource;
    dtsEndereco: TDataSource;
    btnCancelarContrato: TBitBtnLocked;
    pnlTotal: TPanel;
    lblQtde: TLabel;
    edtTotCon: TDBEditFocus;
    lblTotCon: TLabel;
    edtQtde: TDBEditFocus;
    dtsEqlDet: TDataSource;
    btnExpandirTodos: TBitBtnLocked;
    btnRetrairTodos: TBitBtnLocked;
    dtsEqlAcl: TDataSource;
    pnlCondicaoPgto: TPanel;
    pnlCondicaoPagamento: TcxGroupBox;
    fraPagamento: TfraDigCndPagamento;
    pnlEquipamentos: TPanel;
    lblAut_PD: TLabel;
    csdEqlAce: TUniClientDataSet;
    csdEqlAceCODIGO: TStringField;
    csdEqlAceDESCRICAO: TStringField;
    csdEqlAceQUANTIDADE: TFloatField;
    csdEqlAceEQA_SEQEQU: TStringField;
    csdEqlAceEQA_SEQACL: TStringField;
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
    cdsEqlDetEQD_VLRALT: TStringField;
    cdsEqlDetEQD_VALHOR: TFloatField;
    cdsEqlDetEQD_TOTEQL: TFloatField;
    cdsEqlDetEQD_DESCRI: TStringField;
    cdsEqlDetEQD_SEQEQL: TStringField;
    cdsEqlDetEQD_TIPDUR: TStringField;
    cdsEqlDetEQL_CODIGO: TStringField;
    cdsEqlDetEQD_NSERIE: TStringField;
    cdsEqlDetAUTOINCREM: TStringField;
    cdsEqlDetTIPO_CONTRATO: TStringField;
    edtAutIncFatGor: TEditFocus;
    cdsEqlDetEQL_SITENC: TStringField;
    cdsEqlDetEQD_DTAENC: TDateTimeField;
    PCEquipamentos: TPageControl;
    tsNegociacao: TTabSheet;
    cxGridNegociacaoDiarias: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBTableViewCitel1QTDDIA: TcxGridDBColumn;
    cxGridDBTableViewCitel1VLRTOT: TcxGridDBColumn;
    cxGridDBTableViewCitel1VLRDIA: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlRodapeNegociacao: TPanel;
    tsEquipamentos: TTabSheet;
    grpDetalhes: TGroupBox;
    pnlAdicionarItens: TPanel;
    lblCodEql: TLabel;
    Label4: TLabel;
    lblValorLocacao: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label1: TLabel;
    edtCodEql: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    rgTipoDuracaoLocacao: TRadioGroup;
    edtVlrLoc: TCurrencyEditFocus;
    edtVlrTot: TCurrencyEditFocus;
    edtDesEql: TEditFocus;
    edtVlrDsc: TEditFocus;
    edtVlrLocLiq: TEditFocus;
    edtVlrTotLiq: TEditFocus;
    btnCancelaItem: TBitBtnLocked;
    cxGrdItens: TcxGridCitel;
    cxGrdItensView: TcxGridDBTableViewCitel;
    grdItensEQL_CODIGO: TcxGridDBColumn;
    grdItensEQL_DESCRI: TcxGridDBColumn;
    grdItensEQL_NSERIE: TcxGridDBColumn;
    grdItensTIPO_CONTRATO: TcxGridDBColumn;
    grdItensEQL_VALLOC: TcxGridDBColumn;
    grdItensEQL_TOTLOC: TcxGridDBColumn;
    grdItensEQD_PERDES: TcxGridDBColumn;
    grdItensEQD_VLLOCL: TcxGridDBColumn;
    grdItensEQD_TOTLIQ: TcxGridDBColumn;
    grdItensEQL_SITENC: TcxGridDBColumn;
    cxGrdAcessoriosTableView: TcxGridDBTableViewCitel;
    cxGrdAcessoriosTableViewCODIGO: TcxGridDBColumn;
    cxGrdAcessoriosTableViewDESCRICAO: TcxGridDBColumn;
    cxGrdAcessoriosTableViewQUANTIDADE: TcxGridDBColumn;
    cxGrdItensLvl: TcxGridLevel;
    cxGrdAcessorios: TcxGridLevel;
    pnlRodape: TPanel;
    lblInfo: TLabel;
    dtsNegociacaoDiarias: TUniDataSource;
    cdsNegociacaoDiarias: TUniClientDataSet;
    cdsNegociacaoDiariasQTDDIA: TIntegerField;
    cdsNegociacaoDiariasVLRTOT: TFloatField;
    cdsNegociacaoDiariasVLRDIA: TFloatField;
    cdsEqlDetEQL_VLRAQU: TFloatField;
    cdsEqlDetEQD_TOTDIA: TFloatField;
    cdsEqlDetEQD_TOTHOR: TFloatField;
    csdEqlAceEQA_VLRAQU: TFloatField;
    csdEqlAceEQA_TOTAQU: TFloatField;
    Label6: TLabel;
    edtTaxEnt: TDBEditFocus;
    cdsEqlDetEQD_TOTMES: TFloatField;
    cxGridPopupMenu1: TcxGridPopupMenu;
    cdsCliCtt: TUniClientDataSet;
    cdsCliCttCPFCTT: TStringField;
    cdsCliCttRG_CTT: TStringField;
    cdsCliCttNOMCTT: TStringField;
    cdsCliCttCGOCTT: TStringField;
    cdsCliCttNOMCGO: TStringField;
    cdsCliCttAUTOINCREM: TStringField;
    cdsCliCttMARCADO: TStringField;
    cdsCliCttCLI_CODCLI: TStringField;
    PCDadosContrato: TPageControl;
    tsDadosGerais: TTabSheet;
    pnlDadosContrato: TPanel;
    splResp: TSplitter;
    pnlDadosCliente: TPanel;
    lblEntCli: TLabel;
    lblCodVen: TLabel;
    lblCodCli: TLabel;
    cmbEntCli: TDBLookupComboBoxFocus;
    edtCodVen: TDBEditFocus;
    edtNomVen: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodCli: TDBEditFocus;
    pnlResponsaveis: TPanel;
    cxGridResponsaveis: TcxGridCitel;
    cxGridTableResponsavel: TcxGridDBTableViewCitel;
    cxGridTableResponsavelMARCADO: TcxGridDBColumn;
    cxGridTableResponsavelNOMCGO: TcxGridDBColumn;
    cxGridTableResponsavelNOMCTT: TcxGridDBColumn;
    cxGridTableResponsavelCPFCTT: TcxGridDBColumn;
    cxGridTableResponsavelRG_CTT: TcxGridDBColumn;
    cxGridResponsaveisLevel1: TcxGridLevel;
    pnlDuracao: TPanel;
    grbDuracao: TGroupBox;
    pnlDuracaoDiariaHora: TPanel;
    lblInicio: TLabel;
    lblTermino: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    edtDtaIni: TDBEditFocus;
    edtHorIni: TDBEditFocus;
    edtDtaFin: TDBEditFocus;
    edtHorFin: TDBEditFocus;
    edtTotDia: TDBEditFocus;
    edtTotHor: TDBEditFocus;
    pnlDuracaoMensal: TPanel;
    lblMesIni: TLabel;
    lblMesFin: TLabel;
    lblTotMes: TLabel;
    edtMesIni: TMaskEditFocus;
    edtMesFin: TMaskEditFocus;
    edtTotMes: TDBEditFocus;
    tsInfAdicionais: TTabSheet;
    Label10: TLabel;
    Label11: TLabel;
    edtEndObr: TDBEditFocus;
    edtNumCmp: TDBEditFocus;
    lblQtdEqu: TLabel;
    edtQtdEqu: TEditFocus;
    grdItensEQD_QTDEQU: TcxGridDBColumn;
    dtsCliCtt: TDataSource;
    cdsEqlDetEQD_QTDEQU: TFloatField;
    cxGridDBTableViewCitel1DTAEST: TcxGridDBColumn;
    cdsNegociacaoDiariasDTAEST: TDateTimeField;
    csdEqlAceEQA_QTDTOT: TFloatField;
    cxGrdAcessoriosTableViewEQA_QTDTOT: TcxGridDBColumn;
    btnEncerrarContrato: TBitBtnLocked;
    lblVlrAdcAcessorio: TLabel;
    edtVlrAdc: TDBEditFocus;
    csdEqlAceEQA_VLRADC: TFloatField;
    cxGrdAcessoriosTableViewColumn1: TcxGridDBColumn;
    cxGrdAcessoriosTableViewEQA_TOTADC: TcxGridDBColumn;
    csdEqlAceEQA_TOTADC: TFloatField;
    btnGerarPedidoAdt: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pCarregarContrato;
    procedure pCarregarContratoProrrogacao;
    procedure pCarregarContratoEdicao;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCodEqlKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure cxGrdItensViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarContratoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rgTipoDuracaoLocacaoExit(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnExpandirTodosClick(Sender: TObject);
    procedure btnRetrairTodosClick(Sender: TObject);
    procedure rgTipoDuracaoLocacaoClick(Sender: TObject);
    procedure cmbStatusClick(Sender: TObject);
    procedure edtTaxEntExit(Sender: TObject);
    procedure cxGridTableResponsavelMARCADOPropertiesChange(Sender: TObject);
    procedure cxGridTableResponsavelKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumCmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnEncerrarContratoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGerarPedidoAdtClick(Sender: TObject);

  private
    qryConCli: TUniQuery;
    qryEntCli: TUniQuery;
    qryConOpe: TUniQuery;
    qryCadEqL: TUniQuery;
    qryConCnd: TUniQuery;

    objLiberacao : TLiberacao;
    arrCadEql: TConsultasArray;
    arrEquipamentos: TConsultasArray;

    objContrato: TContratoLocacaoEquipamentos;
    objEquipamento: TEquipamentoLocacaoPrincipal;
    objItemContrato: TItemContratoLocacaoEquipamentos;

    objProrrogacao: TProrrogaContratoLocacao;

    strCodEqlAnt : String;
    FBlnUtilizaAcessorios: Boolean;
    FfltTotalAqu: Double;
    FblnValidarDtHr: Boolean;
    FintLocDec: Integer;
    FstrLocDec: String;
    FobjLock: TLock;
    FobjValidaCtr: TValidarContrato;
    FblnConsDadosCobLiberado: Boolean;
    strCodCndAnt: String;
    strCodCliAnt: String;
    FMensagemRetorno: String;

    procedure pCarregaCliente;
    procedure pCarregaVendedor;
    procedure pCarregaEnderecos;
    function fCarregaEquipamento(const aCodEql: String): Boolean;
    procedure pCarregaDetalhes;
    procedure pAtualizaTotais(blnGravarVlrAqu: Boolean = False);
    procedure pCalcularTotalAqu(blnGravarVlrAqu: Boolean = True);
    procedure pCalculaDuracaoContrato;
    function fValidaDataHora(): Boolean;
    function fValidaDataHoraContratoMensal(): Boolean;
    function fValidaDataHoraContratoPadrao(): Boolean;
    function DatasEHorasInformadas(): Boolean;
    function DatasInicialEFinalInformadas(): Boolean;
    function MesInicialEFinalInformado(): Boolean;

    function fVerificaProcessoExecucao(const strNomPro: String): Boolean;

    procedure pSetaStatus(strStatus: String);
    function fGravarContratoCancelado(): Boolean;
    function fSenhaCancelamentoContrato: Boolean;
    procedure pFormatarCampos;
    procedure pAdicionarItemGrid(const aItem: TItemContratoLocacaoEquipamentos);
    procedure pAtualizarItemGrid(const aItem: TItemContratoLocacaoEquipamentos);
    function fAdicionarItemObjContrato(const aItem: TItemContratoLocacaoEquipamentos): TItemContratoLocacaoEquipamentos;
    procedure pAtualizarItemObjContrato(const aItem: TItemContratoLocacaoEquipamentos);
    procedure pAdicionarAcessorioGrid(const aItem: TAcessorioContratoLocacaoEquipamentos);
    procedure pLimparEquipamento;
    procedure pRecalcularItem;
    procedure pEditarItem;
    procedure pCarregaTipoCalculoLocacao;
    procedure pCarregaTipoCalculoLocacaoHoras;
    procedure pCarregaTipoCalculoLocacaoDiarias;
    procedure pCarregaTipoCalculoLocacaoMensal;
    function fEquipamentoJaInseridoNesseContrato(const strCodEqu: String): Boolean;
    function fGerarPedidoVenda(pgbStatus: TcxProgressBar = nil): Boolean;
    procedure pLimparContrato;
    procedure pAddEquipamento(strCodEqui: String);
    procedure pHabilitaDesabilitaEdicaoContrato;
    procedure pAjustaTelaProrrogacao;
    procedure pAjustaTelaEmissaoContrato;
    procedure pHabilitaCamposProrrogacao;
    function fObtemDataInicial: TDateTime;
    function fObtemDataFinal: TDateTime;
    function fProcessaPedidoVenda: Boolean;
    function fProcessaPedidoVendaInterno(pgbStatus: TcxProgressBar = nil): Boolean;
    function fAtualizarPedidoVenda(pgbStatus: TcxProgressBar = nil): Boolean;
    procedure pFinalizaGravacaoContrato(blnGravou, blnExibirMensagem: Boolean);
    function fProrrogarContrato: Boolean;
    procedure pCarregarDiariasNegociacao(const objEquParam: TEquipamentoLocacaoPrincipal);
    function fObtemCampoHora(const aHora: String): TDateTime;
    procedure pHabilitaTipoCalculoLocacao;
    function fValidarValorLocacao: Boolean;
    procedure pCarregaContatos(strCodCli: String);
    procedure pAdicionaContatoCds(objContato: TCliCtt);
    function fGravarResponsaveisContrato: Boolean;
    procedure pForcaLimparAplicacao;
    function fValidaLimiteContrato: Boolean;
    function fRetornaPedidoAdt: String;
  public
    { Public declarations }
    blnProrrogacao: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pGravarItensContrato;
    procedure pAtualizarItensContrato;
    procedure pInserirItensContrato;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untConsultas, untPesqAux, untWord, untFuncoesGenerica,
  untFuncoesConsulta, untFuncoesRel, untFuncoesRel2, untFuncoes, untConstantes, Dateutils,
  untObservacao, MaskUtils, untFuncoesLocEqu, untPnlDadosEquLocacao,
  untPanelCxInfoEquLocacao,
  untValorPorExtenso, faturamento.Classes.ImpressaoLocEqu;

{ TfrmCadContratoLocEquip }

procedure TfrmCadContratoLocEquip.btnImprimirClick(Sender: TObject);
Var
  objImpCtr: TImpressaoLocacao;
  objCtrImp: TContratoLocacaoEquipamentos;
  blnErroApl: Boolean;
begin
  inherited;
  objCtrImp := TContratoLocacaoEquipamentos.Create;
  objImpCtr := TImpressaoLocacao.Create(objCtrImp);
  Try
    objImpCtr.ObjContrato.fCarregarContrato('', qryTabela.FieldByName('EQL_NROCON').AsString, True);
    If objImpCtr.fImprimirContrato(blnErroApl, blnProrrogacao) Then
    Begin
      If fMensagem('ATENÇÃO!', IIF(objImpCtr.ObjContrato.Status = 'O',
                                   'Orçamento',
                                   'Contrato') +
                               ' gerado com sucesso!' + #13 +
                               'Deseja abrir o documento?', ['&Sim', '&Não']) = 1 Then
         pExecArquivo(objImpCtr.strNomArquivo, Handle);
    End
    Else
    Begin
      If blnErroApl Then
      Begin
        fMensagem('ATENÇÃO!', 'O Sistema identificou falha na aplicação externa ao Autcom para impressão do documento. ' +
                          'Será realizada nova tentativa para impressão do documento. ' +
                          'Se o problema persistir finalize o LibreOffice manualmente pelo gerenciador de tarefas.' , ['&O k']);

        pForcaLimparAplicacao;
        objImpCtr.fImprimirContrato(blnErroApl, blnProrrogacao);
      End;
    End;

    If Not fEmptyStr(objImpCtr.strMensagemRetorno) Then
    Begin
      fMensagem('ATENÇÃO!', objImpCtr.strMensagemRetorno, ['&Ok']);
    End;

  Finally
    FreeAndNil(objCtrImp);
    FreeAndNil(objImpCtr);
  End;
end;

procedure TfrmCadContratoLocEquip.btnAdicionarClick(Sender: TObject);
var
  blnEdicaoItem: Boolean;
begin
  inherited;

  Try

    If (fStrToFloat(edtVlrLocLiq.Text) <= 0 ) And (fStrToFloat(edtVlrTotLiq.Text) <= 0 ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido inserir item com valor total líquido zerado. Verifique!', ['&Ok']);
      Exit;
    End;

    If (fStrToFloat(edtQtdEqu.Text) <= 0 ) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido inserir item com quantidade zerada. Verifique!', ['&Ok']);
      Exit;
    End;

    If Not fVerificaCampos Then
      Exit;

    If fEmptyStr(edtCodEql.Text) Then
      Exit;

    If not Assigned(objItemContrato) Then
      Exit;

    If fEmptyStr(objItemContrato.Equipamento.Codigo) Then
      Exit;

    If Not fValidarValorLocacao Then
      Exit;

    blnEdicaoItem := cdsEqlDet.State = dsEdit;

    If Not blnEdicaoItem Then
      blnEdicaoItem := cdsEqlDet.Locate('EQD_SEQEQL', objItemContrato.Equipamento.Codigo, []);

    If blnEdicaoItem  Then
    Begin
      pAtualizarItemObjContrato(objItemContrato);
      pAtualizarItemGrid(objItemContrato);
    End
    Else
    Begin
      pAdicionarItemGrid(fAdicionarItemObjContrato(objItemContrato));
    End;

    objItemContrato.pLimpar;
    pAtualizaTotais;
  Finally
    pLimparEquipamento;

    pSetFocus(edtCodEql);

    lblInfo.Font.Color := clInfoText;
    lblInfo.Caption := ' Pressione [DEL] para remover um equipamento ';
  End;

end;

function TfrmCadContratoLocEquip.fAdicionarItemObjContrato(const aItem: TItemContratoLocacaoEquipamentos): TItemContratoLocacaoEquipamentos;
Begin
  Result := ObjContrato.fAddItem(aItem);
End;

function TfrmCadContratoLocEquip.fAtualizarPedidoVenda(
  pgbStatus: TcxProgressBar): Boolean;
var
  objPedido: TPedidoContratoLocacao;
begin

  If Not pnlCondicaoPgto.Visible Then
  Begin
    Result := True;
    Exit;
  End;

  Result := False;
  objPedido := TPedidoContratoLocacao.Create(objContrato);
  Try
    Result := objPedido.fAtualizarPedido(pgbStatus);
  Finally
    If Not Result Then
      FMensagemRetorno := 'Não foi possível atualizar o pedido de adiantamento.';
    FreeAndNil(objPedido);
  End;
end;

procedure TfrmCadContratoLocEquip.pLimparContrato;
begin
  cdsEqlDet.EmptyDataSet;
  csdEqlAce.EmptyDataSet;
  cdsCliCtt.EmptyDataSet;
  objContrato.pLimpar;
  pLimparCampos;
  pLimparEquipamento;

  edtMesIni.Clear;
  edtMesFin.Clear;

  fraPagamento.strCcnAnt := EmptyStr;
  fraPagamento.mskCndPag.Clear;
  fraPagamento.edtCodCnd.Clear;
  fraPagamento.edtForPag.Clear;
  fraPagamento.edtDesForPag.Clear;

  If Not (fCfgSis('CTRMES', VarBoolean)) Then
    FblnValidarDtHr := True
  Else
    FblnValidarDtHr := False;

  FblnConsDadosCobLiberado := False;
  strCodCndAnt := EmptyStr;
  strCodCliAnt := EmptyStr;
end;

procedure TfrmCadContratoLocEquip.pLimparEquipamento;
Begin
  If Assigned(objEquipamento) Then
    objEquipamento.pLimpar;

  edtCodEql.Clear;
  edtDesEql.Clear;
  edtVlrLoc.Clear;
  edtVlrLoc.Clear;
  edtVlrTot.Clear;
  edtVlrDsc.Clear;
  edtVlrLocLiq.Clear;
  edtVlrTotLiq.Clear;
  rgTipoDuracaoLocacao.Enabled := True;
  edtQtdEqu.Clear;

  lblInfo.Font.Color := clInfoText;
  lblInfo.Caption := ' Pressione [DEL] para remover um equipamento ';

End;

function TfrmCadContratoLocEquip.fProcessaPedidoVenda: Boolean;
begin
  Try
    Result := fChamaTelaGravando(fProcessaPedidoVendaInterno, 'Aguarde, processando pedido de adiantamento ...');

    If Not Result Then
    Begin
      If Not objContrato.fVerificaPedAdtGerado Then
        Raise Exception.Create('Pedido de adiantamento não encontrado')
      Else
        Raise Exception.Create('Não foi possível processar o pedido de venda de adiantamento');
    End;

  Except
    On E: Exception Do
    Begin
      Raise;
    End;
  End;
end;

function TfrmCadContratoLocEquip.fProrrogarContrato: Boolean;
begin
  Result := True;

  If blnProrrogacao Then
  Begin
    Result := objProrrogacao.fConfirmarProrrogacaoContrato;
  End;

  If Not Result  Then
  Begin
    fMensagem('Atenção', objProrrogacao.MensagemRetorno ,['&OK']);
  End;
end;

function TfrmCadContratoLocEquip.fRetornaPedidoAdt: String;
var
  qry: TUniQuery;
begin
  Result := EmptyStr;

  qry := fCriaQuery;
  Try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT EQL_AUT_PD FROM CONEQL WHERE AUTOINCREM = :AUTINC');
    qry.ParamByName('AUTINC').AsString := objContrato.AutInc;
    qry.Open;

    If Not qry.IsEmpty Then
      Result := qry.FieldByName('EQL_AUT_PD').AsString;
  Finally
    FreeAndNil(qry);
  End;
end;

procedure TfrmCadContratoLocEquip.pRecalcularItem;
begin
  If Not Assigned(ObjItemContrato) Then
    Exit;

  Case rgTipoDuracaoLocacao.ItemIndex of
    0 : ObjItemContrato.TipoCalculoLocacao := tpDiaria;
    1 : ObjItemContrato.TipoCalculoLocacao := tpHoras;
    2 : ObjItemContrato.TipoCalculoLocacao := tpMensal;
  End;

  ObjItemContrato.pCalcularValorLocacao;

  edtVlrLoc.Text     := FormatFloat(FstrLocDec, ObjItemContrato.ValorLocacaoContratado);
  edtVlrTot.Text     := FormatFloat('#,##0.00', ObjItemContrato.ValorTotalLocacaoContratado);
  edtVlrDsc.Text     := FormatFloat('#,##0.00', ObjItemContrato.PercentualDesconto);
  edtVlrLocLiq.Text  := FormatFloat(FstrLocDec, ObjItemContrato.ValorLocacaoLiquido);
  edtVlrTotLiq.Text  := FormatFloat('#,##0.00', ObjItemContrato.ValorTotalLiquido);
end;

procedure TfrmCadContratoLocEquip.btnAlterarClick(Sender: TObject);
begin

  If blnProrrogacao Then
  Begin
    objProrrogacao.fAddContrato(ObjContrato);
    If Not objProrrogacao.fIniciarProrrogacaoContrato Then
    Begin
      fMensagem('ATENÇÃO!', objProrrogacao.MensagemRetorno, ['&Ok']);
      Exit;
    End;
  End;

  inherited;

  pHabilitaCodigo(edtNumCon, cmbStatus, False);
  pHabilitaDesabilitaEdicaoContrato;

  qryTabela.FieldByName('EQL_DTAALT').AsDateTime := fNow();

end;

procedure TfrmCadContratoLocEquip.btnCancelaClick(Sender: TObject);
begin
  inherited;

  cdsEqlDet.CancelUpdates;
  csdEqlAce.CancelUpdates;

  FobjLock.fLock_Unlock(IIF(blnProrrogacao, cst_TRAVA_PRORRO_LOCEQU, cst_TRAVA_CADCTR_LOCEQU) + objContrato.AutInc, False, False);
  pCarregarContrato;

  pHabilitaDesabilitaEdicaoContrato
end;

procedure TfrmCadContratoLocEquip.btnCancelaItemClick(Sender: TObject);
begin
  inherited;

  cdsEqlDet.Cancel;
  csdEqlAce.Cancel;

  pLimparEquipamento;
  If Assigned(objItemContrato) Then
    objItemContrato.pLimpar;

  pSetFocus(edtCodEql);
end;

procedure TfrmCadContratoLocEquip.btnCancelarContratoClick(Sender: TObject);
Var
  blnGravou: Boolean;
  objPedido: TPedidoContratoLocacao;
begin

  If Not(fVerificaAcessoSistema('CANLOCEQU', strLoginUsuarioLogado)) Then
  Begin
    If (Not fSenhaCancelamentoContrato) Then
      Exit;
  End;

  If fEmptyStr(objContrato.AutInc) Then
  Begin
    fMensagem('ATENÇÃO!', 'Contrato não carregado!', ['&Ok']);
    Exit;
  End;

  If fMensagem('ATENÇÃO!', 'Deseja realmente cancelar este contrato de locação de equipamentos?', ['&Sim', '&Não'], 2) = 1 Then
  Begin

    fStartTransaction;

    Try
      objPedido := TPedidoContratoLocacao.Create(objContrato);
      Try
        objPedido.fCancelarPedido;
      Finally
        FreeAndNil(objPedido);
      End;

      blnGravou := fGravarContratoCancelado();

      If blnGravou Then
        fCommit
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        blnGravou := False;
        pMensagensErro(E.Message, '[TfrmCadContratoLocEquip.btnCancelarContratoClick]');
      End;
    End;

    If blnGravou Then
    Begin
      pMensagemOk('Contrato de locação de equipamentos cancelado com sucesso!');
      pHabilitaDesabilitaEdicaoContrato;
    End;

  End;

end;

procedure TfrmCadContratoLocEquip.btnEncerrarContratoClick(Sender: TObject);
var
  objManCtr: TManutencaoContrato;
begin
  inherited;

  objManCtr := TManutencaoContrato.Create;
  Try
    objManCtr.Contrato.fCarregarContrato(qryTabela.FieldByName('AUTOINCREM').AsString);

    If fEmptyStr(objManCtr.Contrato.AutInc) Then
    Begin
      pMensagemOk('Contrato não carregado!');
      Exit;
    End;

    If objManCtr.fEncerrarContrato Then
    Begin
      pMensagemOk('Contrato de locação de equipamentos encerrado com sucesso!');
      pHabilitaDesabilitaEdicaoContrato;
      pSetaStatus('E');
    End
    Else If Not fEmptyStr(objManCtr.MensagemRetorno)Then
      pMensagemOk(objManCtr.MensagemRetorno);
  Finally
    FreeAndNil(objManCtr);
  End;
end;

procedure TfrmCadContratoLocEquip.btnExcluirClick(Sender: TObject);
begin
  inherited;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadContratoLocEquip.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pLimparContrato;
end;

procedure TfrmCadContratoLocEquip.btnExpandirTodosClick(Sender: TObject);
begin
  inherited;

  If (cxGrdItensView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGrdItensView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGrdItensView.ViewData.Expand(True);
end;

procedure TfrmCadContratoLocEquip.pAddEquipamento(strCodEqui: String);
Begin
  SetLength(arrEquipamentos, Length(arrEquipamentos) + 1);
  arrEquipamentos[Length(arrEquipamentos) - 1].strCodigo := strCodEqui;
End;

procedure TfrmCadContratoLocEquip.btnGerarPedidoAdtClick(Sender: TObject);
var
  blnGerou: Boolean;
begin
  inherited;

  If blnProrrogacao Then
    Exit;

  If Not (qryTabela.FieldByName('EQL_STATUS').AsString = 'A') Then
  Begin
    fMensagem('ATENÇÃO!', 'Contrato não está ativo.', ['&Ok']);
    Exit;
  End;

  If objContrato.fVerificaPedAdtGerado Then
  Begin
    fMensagem('ATENÇÃO!', 'Contrato já possui pedido de adiantamento vinculado, não é possível gerar um novo pedido.', ['&Ok']);
    Exit;
  End;

  Try
    blnGerou := fChamaTelaGravando(fGerarPedidoVenda, 'Aguarde...gerando pedido de adiantamento');

    If Not blnGerou Then
    Begin
      If Not objContrato.fVerificaPedAdtGerado Then
        Raise Exception.Create('Pedido de adiantamento não encontrado')
      Else
        Raise Exception.Create('Não foi possível gerar o pedido de venda de adiantamento');
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadContratoLocEquip.btnGerarPedidoAdtClick]');
    End;
  End;

end;

procedure TfrmCadContratoLocEquip.btnGravarClick(Sender: TObject);
var
  intRecNo: Integer;
  blnExibirMensagem: Boolean;
  blnGerouPedidoDeVenda: Boolean;
begin
  FMensagemRetorno := EmptyStr;

  pAtualizaTotais(True);

  blnExibirMensagem := True;

  blnGerouPedidoDeVenda := False;

  If Not fValidaLimiteContrato Then
    Exit;

  If (blnUsaVerificaCamposPai) And (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If pnlCondicaoPgto.Visible Then
  Begin
    qryTabela.FieldByName('EQL_CONPAG').AsString := fraPagamento.mskCndPag.Text;
    qryTabela.FieldByName('EQL_CODCND').AsString := fraPagamento.edtCodCnd.Text;
    qryTabela.FieldByName('EQL_CODFPG').AsString := fraPagamento.edtForPag.Text;

    ObjContrato.CondicaoPgto := fraPagamento.mskCndPag.Text;
    ObjContrato.CodCondicaoPgto := fraPagamento.edtCodCnd.Text;
    ObjContrato.CodFormaPgto := fraPagamento.edtForPag.Text;

    If Not FobjValidaCtr.fValidaCondicaoPgtoTipoCliente Then
      Exit;
  End;

  ObjContrato.Status := Copy(cmbStatus.Text, 0,1);

  If cdsEqlDet.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário informar ao menos um equipamento.', ['&Ok']);
    pSetFocus(edtCodEql);
    Exit;
  End;

  If fCfgSis('RESLOC', VarBoolean) And (ObjContrato.Responsavel.Count <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário informar ao menos um responsável.', ['&Ok']);
    Exit;
  End;

  cdsEqlDet.DisableControls;

  intRecNo := cdsEqlDet.RecNo;
  Try

    SetLength(arrEquipamentos, 0);
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      pAddEquipamento(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);
      cdsEqlDet.Next;
    End;

    If Not objContrato.fEquipamentoDisponivel(arrEquipamentos,
                                            edtNumCon.Text,
                                            False,
                                            IIF(objContrato.TipoDuracaoContrato = 'M',
                                                DateTimeToStr(objContrato.DataInicial),
                                                edtDtaIni.Text),
                                            edtHorIni.Text,
                                            IIF(objContrato.TipoDuracaoContrato = 'M',
                                                DateTimeToStr(objContrato.DataFinal),
                                                edtDtaFin.Text),
                                            edtHorFin.Text) Then
    Begin
      pSetFocus(edtCodEql);
      Exit;
    End;
  Finally
    cdsEqlDet.RecNo := intRecNo;
    cdsEqlDet.EnableControls;
  End;

  If (cmbStatus.Text[1] = 'A') And (Not blnProrrogacao) Then
  Begin
    If Not objContrato.fValidaPodeAtivarContrato Then
      Exit;
  End;

  If cmbStatus.Text = fStatusSituacaoContratoToStrSituacaoContrato(stAtivo) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Deseja realmente ' + IIF(blnProrrogacao, 'prorrogar', 'ativar') + ' este contrato? Após a ativação não será mais possível alterá-lo.', ['&Sim', '&Não']) = 2 Then
      Exit;

    If Not blnProrrogacao Then
      qryTabela.FieldByName('EQL_DTAATV').AsDateTime := fNow();
  End;

  Try
    Try
      inherited;

      If blnGravou Then
      Begin
        pGravarItensContrato;
        pAtualizaTotais;
      End;

      If cmbStatus.Text = fStatusSituacaoContratoToStrSituacaoContrato(stAtivo) Then
      Begin
        blnGerouPedidoDeVenda := fProcessaPedidoVenda;

        blnGravou := blnGravou  And blnGerouPedidoDeVenda;
      end;

      blnGravou := blnGravou  And  IIF(fProrrogarContrato, True, False);

      blnGravou := blnGravou  And  IIF(objContrato.fAlterarStatusContrato(Copy(cmbStatus.Text, 0,1)), True, False);

      blnGravou := blnGravou  And  fGravarResponsaveisContrato;

      If blnGravou Then
        fCommit
      Else
      Begin
        fRollBack;
      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;

        blnGravou := False;

        pMensagensErro(E.Message, '[TfrmCadContratoLocEquip.btnGravarClick]');
      End;
    End;

  Finally
    If (Not blnGravou) And (Not blnGerouPedidoDeVenda) And (qryTabela.FieldByName('EQL_TOTCON').AsFloat = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor total do contrato está zerado, portanto, o contrato não será ativado. Verifique se os itens foram incluídos corretamente.', ['&Ok']);
    End;

    pFinalizaGravacaoContrato(blnGravou, blnExibirMensagem);
  End;
end;

procedure TfrmCadContratoLocEquip.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pLimparContrato;

  pHabilitaDesabilitaEdicaoContrato;

  pSetaStatus('');

  pHabilitaCodigo(edtNumCon, cmbStatus, Not blnUsaProCodigo);

  qryTabela.FieldByName('EQL_DTACAD').AsDateTime := fNow();
end;

procedure TfrmCadContratoLocEquip.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';

  If blnProrrogacao Then
  Begin
    If fPesqProrrogacaoContratoLocEquip(Self, Nil, qryTabela, chrKey) Then
    Begin
      FobjLock.fLock_Unlock(IIF(blnProrrogacao, cst_TRAVA_PRORRO_LOCEQU, cst_TRAVA_CADCTR_LOCEQU) + objContrato.AutInc, False, False);
      objContrato.fCarregarContrato(qryTabela.FieldByName('AUTOINCREM').AsString);
      pSetFocus(btnAlterar);
    End;
  End
  Else
  Begin
    If fPesqContratoLocEquip(Self, Nil, Nil, qryTabela, chrKey, arrSel) Then
    Begin
      FobjLock.fLock_Unlock(IIF(blnProrrogacao, cst_TRAVA_PRORRO_LOCEQU, cst_TRAVA_CADCTR_LOCEQU) + objContrato.AutInc, False, False);
      objContrato.fCarregarContrato(qryTabela.FieldByName('AUTOINCREM').AsString);
      pSetFocus(btnAlterar);
    End;
  End;
end;

procedure TfrmCadContratoLocEquip.btnRetrairTodosClick(Sender: TObject);
begin
  inherited;

  If (cxGrdItensView.DataController.DataSource.DataSet.Active) Then
    If (Not cxGrdItensView.DataController.DataSource.DataSet.IsEmpty) Then
      cxGrdItensView.ViewData.Collapse(True);
end;

procedure TfrmCadContratoLocEquip.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    FblnConsDadosCobLiberado := False;

    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadContratoLocEquip.edtCodEqlKeyPress(Sender: TObject;
  var Key: Char);
Var
  dtmDtHrIni, dtmDtHrFin: TDateTime;
  objfrmPnl : TPanelCxInfoEquLocacao;
begin
  inherited;

  dtmDtHrIni := 0;
  dtmDtHrFin := 0;

  Try
    FblnValidarDtHr := True;

    If Assigned(objContrato) Then
    Begin
      dtmDtHrIni := objContrato.DataInicial + objContrato.HoraInicial;
      dtmDtHrFin := objContrato.DataFinal + objContrato.HoraFinal;
    End;

    objfrmPnl := TPanelCxInfoEquLocacao.Create(TfrmPnlDadosEquLocacao);
    objfrmPnl.strNomForm := self.name;

    If fPesqCadastroEquipLocacao(Self, edtCodEql, edtDesEql, qryCadEqL, Key, arrCadEql, False, edtNumCon.Text, dtmDtHrIni, dtmDtHrFin, objfrmPnl) Then
    Begin
      If fValidaCampos(edtCodEql, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmCadContratoLocEquip.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrVendedores: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrVendedores) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadContratoLocEquip.edtNumCmpKeyPress(Sender: TObject;
  var Key: Char);
var
  strDoc    : String;
  arrPedcompra: TConsultasArray;
begin
  inherited;

  If fPesqPedidoCompra(Self, edtNumCmp, nil, Key , arrPedcompra, strDoc, '', 0 , False) Then
  Begin
    If fValidaCampos(edtNumCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadContratoLocEquip.edtTaxEntExit(Sender: TObject);
begin
  inherited;

  If fValidaCampos(edtTaxEnt, True) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadContratoLocEquip.DatasEHorasInformadas: Boolean;
begin
  Result := DatasInicialEFinalInformadas Or
            MesInicialEFinalInformado;
end;

function TfrmCadContratoLocEquip.fEquipamentoJaInseridoNesseContrato(const strCodEqu: String): Boolean;
begin
  Result := False;
  cdsEqlDet.DisableControls;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof Do
    Begin
      If strCodEqu = cdsEqlDet.FieldByName('EQD_SEQEQL').AsString Then
      Begin
        Result := True;
        Break;
      End;
      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.EnableControls;
  End;
end;

function TfrmCadContratoLocEquip.fGravarContratoCancelado: Boolean;
begin

  Result := True;

  Try
    qryTabela.Edit;
    qryTabela.FieldByName('EQL_STATUS').AsString := 'C';
    qryTabela.Post;

    pSetaStatus(qryTabela.FieldByName('EQL_STATUS').AsString);
    btnAlterar.Enabled := qryTabela.FieldByName('EQL_STATUS').AsString = 'O';
    btnExcluir.Enabled := qryTabela.FieldByName('EQL_STATUS').AsString = 'O';

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadContratoLocEquip.fGravarContratoCancelado]');
    End;
  End;

end;

function TfrmCadContratoLocEquip.fGravarResponsaveisContrato: Boolean;
begin
  Try
    If fCfgSis('RESLOC', VarBoolean) Then
      Result := objContrato.fGravarResponsaveis
    Else
      Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadContratoLocEquip.fGravarResponsaveisContrato]');
    End;
  End;
end;

function TfrmCadContratoLocEquip.fObtemCampoHora(
  const aHora: String): TDateTime;
begin
  Try
    Result := StrToDateTime(FormatDateTime('hh:mm', StrToDateTime(aHora)))
  Except
    Result := 0;
  End;
end;

function TfrmCadContratoLocEquip.fObtemDataFinal: TDateTime;
begin
  Try
    If Not fEmptyDate(edtMesFin.Text) Then
      Result := fObtemDtaFiniMes(edtMesFin.Text)
    Else
      Result := StrToDateTime(edtDtaFin.Text + ' ' + edtHorFin.Text);
  Except
    Result := 0;
  End;
end;

function TfrmCadContratoLocEquip.fObtemDataInicial: TDateTime;
begin
  Try
    If Not fEmptyDate(edtMesIni.Text) Then
      Result := fObtemDtaIniMes(edtMesIni.Text)
    Else
      Result := StrToDateTime(edtDtaIni.Text + ' ' + edtHorIni.Text);
  Except
    Result := 0;
  End;
end;

procedure TfrmCadContratoLocEquip.FormActivate(Sender: TObject);
begin
  inherited;

  If fUsaLayoutNovo And fUsaDoisMonitores Then
    pCentralizarForm(Self);
end;

procedure TfrmCadContratoLocEquip.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLiberacao);
end;

procedure TfrmCadContratoLocEquip.FormCreate(Sender: TObject);
begin
  inherited;

  blnProrrogacao := False;
  objContrato := TContratoLocacaoEquipamentos.Create;
  objEquipamento := TEquipamentoLocacaoPrincipal.Create;
  objItemContrato := TItemContratoLocacaoEquipamentos.Create(objContrato);
  FobjValidaCtr := TValidarContrato.Create(objContrato);

  objProrrogacao := TProrrogaContratoLocacao.Create;

  strNomeTabela := 'CONEQL';
  strNomeCampo  := 'EQL_NROCON';

  qryTabela := fCriarQuery('SELECT * FROM CONEQL WHERE FALSE ', Self);
  dtsTabela.DataSet := qryTabela;
  qryTabela.AfterOpen := pAfterOpen;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := edtNumCon;

  cdsEqlDet.CreateDataSet;
  csdEqlAce.CreateDataSet;
  cdsNegociacaoDiarias.CreateDataSet;
  cdsCliCtt.CreateDataSet;

  pFormatarCampos;

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryEntCli := fCriarQuery('SELECT ENTCLI.AUTOINCREM, CONCAT(ETC_ENDENT, " - ", ETC_BAIENT, " - ", CID_NOMCID, " - ", CID_ESTADO) AS ETC_ENDENT FROM ENTCLI INNER JOIN CADCID ON CID_CODCID = ETC_CIDENT WHERE ETC_CODCLI = :CODCLI AND ETC_SITUAC = "A"', Self);
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryCadEqL := fCriarQuery('SELECT * FROM CADEQL WHERE FALSE', Self);

  dtsEndereco.DataSet := qryEntCli;

  objLiberacao := TLiberacao.Create;

  If fCfgSis('CPGCTR', VarBoolean) Then
  Begin
    fraPagamento.OnFormCreate(Sender);
    fraPagamento.blnAutoHeight := False;
    fraPagamento.OnFormShow(Sender);

    fraPagamento.mskCndPag.Left := fraPagamento.edtDesForPag.Left;
    fraPagamento.mskCndPag.Width := fraPagamento.edtDesForPag.Width;
    fraPagamento.Repaint;
  End
  Else
  Begin
    pnlCondicaoPgto.Visible := False;
    edtAutIncFatGor.Visible := False;
    edtAutIncFatGor.Visible := False;
  End;

  pnlCondicaoPgto.Enabled := False;
  qryConCnd    := fCriaQuery(Self);

  FBlnUtilizaAcessorios := fCfgSis('UTIACE', VarBoolean);
  cxGrdAcessorios.Visible := FBlnUtilizaAcessorios;
  btnExpandirTodos.Visible := FBlnUtilizaAcessorios;
  btnRetrairTodos.Visible := FBlnUtilizaAcessorios;


  If (fCfgSis('CTRMES', VarBoolean)) Then
  Begin
    pnlDuracaoMensal.Visible := True;
  End
  Else
  Begin
    pnlDuracaoMensal.Visible := False;
    pnlDuracao.Height := pnlDuracao.Height - pnlDuracaoMensal.Height;
  End;

  pHabilitaTipoCalculoLocacao;

  PCEquipamentos.ActivePage := tsEquipamentos;
  tsNegociacao.TabVisible := False;

  If Not (fCfgSis('CTRMES', VarBoolean)) Then
    FblnValidarDtHr := True
  Else
    FblnValidarDtHr := False;

  cxGridResponsaveis.Enabled := False;

  If Not (fCfgSis('RESLOC', VarBoolean))Then
  Begin
    splResp.Visible := False;
    pnlResponsaveis.Visible := False;
  End;

  FintLocDec := fCfgSis('LOCDEC', VarInteger);
  FstrLocDec := '#,##0.' + fStrZero('0', FintLocDec);

  FobjLock := TLock.Create;
  FblnConsDadosCobLiberado := False;

  Self.WindowState := wsMaximized;
end;

procedure TfrmCadContratoLocEquip.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(IIF(blnProrrogacao, cst_TRAVA_PRORRO_LOCEQU, cst_TRAVA_CADCTR_LOCEQU) + objContrato.AutInc, False, False);

  pFreeAndNil(objItemContrato);
  pFreeAndNil(objEquipamento);
  pFreeAndNil(objContrato);
  pFreeAndNil(qryConCnd);
  pFreeAndNil(objProrrogacao);
  FreeAndNil(FobjLock);
  FreeAndNil(FobjValidaCtr);
end;

procedure TfrmCadContratoLocEquip.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F6) And btnImprimir.Enabled Then
    btnImprimir.Click;
  If (Key = VK_F7) And btnCancelarContrato.Enabled Then
    btnCancelarContrato.Click;
  If Key = VK_F11 Then
    btnExpandirTodos.Click;
  If Key = VK_F12 Then
    btnRetrairTodos.Click;
end;

procedure TfrmCadContratoLocEquip.FormShow(Sender: TObject);
begin
  inherited;

  PCDadosContrato.ActivePage := tsDadosGerais;

  If blnProrrogacao Then
  Begin
    pAjustaTelaProrrogacao;
  End
  Else
    pAjustaTelaEmissaoContrato;

  pSetFocus(btnIncluir);
end;

function TfrmCadContratoLocEquip.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = cmbStatus) Then
    Begin
      If cmbStatus.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'A situação do contrato deve ser informada!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If qryConCli.FieldByName('CLI_STATUS').AsString <> 'A' Then
          Begin
            If qryTabela.State = dsInsert then
            begin
              fMensagem('ATENÇÃO!', 'Esse cliente está inativo!', ['&O k']);
              Result := False;
            end;
          End;

          If Result And ((Not FblnConsDadosCobLiberado) or (edtCodCli.Text <> strCodCliAnt)) And (Not fEmptyStr(fraPagamento.edtCodCnd.Text)) Then
          Begin
            Result := fVerificaConsultaDadosCobranca(IIF(Copy(cmbStatus.Text, 0,1) = 'O', 'OR', 'PD'),
                                                     edtCodCli.Text,
                                                     edtCodVen.Text,
                                                     fraPagamento.edtCodCnd.Text,
                                                     fraPagamento.mskCndPag.Text,
                                                     fraPagamento.edtForPag.Text);
            FblnConsDadosCobLiberado := Result;

            strCodCliAnt := edtCodCli.Text;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Vendedor ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaVendedor;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' Then
        Begin
          If qryTabela.State = dsInsert then
          begin
            fMensagem('ATENÇÃO!', 'Esse vendedor está inativo!', ['&O k']);
            Result := False;
          end;
        End;
      End;
    End

    Else If (Sender = cmbEntCli) Then
    Begin
      If fEmptyStr(cmbEntCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A localização deve ser informada!', ['&O k']);
        Result := False;
      End
    End

    Else If ((Sender = edtDtaIni) and fEmptyDate(edtMesIni.Text) and fEmptyDate(edtMesFin.Text)) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text)) And FblnValidarDtHr Then
      Begin
        fMensagem('ATENÇÃO!', 'A data inicial do contrato deve ser preenchida!', ['&O k']);
        If Not (fCfgSis('CTRMES', VarBoolean)) Then
          Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text))) Then
      Begin
        If (StrToDate(edtDtaIni.Text) < IncYear(VS_Date, -1)) Then
        Begin
          Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). ' +
                                  'Deseja continuar?',  ['&Sim', '&Não']) = 1;
        End;

        If Result Then
        Begin
          If (Not blnProrrogacao) And
             (qryTabela.State = dsInsert) And
             (fEmptyStr(fTiraCaracEspeciais(edtHorIni.Text, True, True, False, True)))  Then
          Begin
            If (Not fEmptyStr( fCfgSis('HORLCI', varString))) Then
            Begin
              edtHorIni.Text := fCfgSis('HORLCI', varString);
              qryTabela.FieldByName('EQL_HORINI').AsDateTime  :=  fObtemCampoHora(edtHorIni.Text);
            End;
          End;

          Result := fValidaDataHora();

          FblnValidarDtHr := True;
        End;
      End;

      If Result Then
        pCalculaDuracaoContrato();

    End

    Else If ((Sender = edtHorIni) and fEmptyDate(edtMesIni.Text) and fEmptyDate(edtMesFin.Text))  Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtHorIni.Text, True, True, False, True)) And FblnValidarDtHr Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora inicial do contrato deve ser preenchida!', ['&O k']);
        If Not (fCfgSis('CTRMES', VarBoolean)) Then
          Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(edtHorIni.Text, True, True, False, True))) Then
      Begin
        Result := fValidaDataHora();

        If Result Then
          pCalculaDuracaoContrato();

        FblnValidarDtHr := True;
      End;
    End

    Else If ((Sender = edtDtaFin) and fEmptyDate(edtMesIni.Text) and fEmptyDate(edtMesFin.Text))  Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text)) And FblnValidarDtHr Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final do contrato deve ser preenchida!', ['&O k']);
        If Not (fCfgSis('CTRMES', VarBoolean)) Then
          Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text))) Then
      Begin
        If (StrToDate(edtDtaFin.Text) < IncYear(VS_Date, -1)) Then
        Begin
          Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). ' +
                                  'Deseja continuar?',  ['&Sim', '&Não']) = 1;
        End;

        If Result Then
        Begin
          If (Not blnProrrogacao) And
             (qryTabela.State = dsInsert) And
             (fEmptyStr(fTiraCaracEspeciais(edtHorFin.Text, True, True, False, True)))  Then
          Begin
            If (Not fEmptyStr( fCfgSis('HORLCF', varString))) Then
            Begin
              edtHorFin.Text := fCfgSis('HORLCF', varString);
              qryTabela.FieldByName('EQL_HORFIN').AsDateTime  := fObtemCampoHora(edtHorFin.Text);
            End;
          End;

          Result := fValidaDataHora();

          If Result Then
            pCalculaDuracaoContrato();

          FblnValidarDtHr := True;
        End;
      End;
    End

    Else If ((Sender = edtHorFin) and fEmptyDate(edtMesIni.Text) and fEmptyDate(edtMesFin.Text))  Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtHorFin.Text, True, True, False, True)) And FblnValidarDtHr Then
      Begin
        fMensagem('ATENÇÃO!', 'A hora final do contrato deve ser preenchida!', ['&O k']);
        If Not (fCfgSis('CTRMES', VarBoolean)) Then
          Result := False;
      End
      Else If (Not fEmptyStr(fTiraCaracEspeciais(edtHorFin.Text, True, True, False, True))) Then
      Begin
        Result := fValidaDataHora();

        If Result Then
          pCalculaDuracaoContrato();

        FblnValidarDtHr := True;
      End;
    End

    Else If (Sender = edtMesIni) Then
    Begin
      If (Not fEmptyDate(edtMesIni.Text)) Then
        objContrato.TipoDuracaoContrato := 'M';

      If ((Not fEmptyDate(edtMesIni.Text)) And (Not fEmptyDate(edtMesFin.Text))) Then
      Begin
        Result := fValidaDataHora();

        If Result Then
          pCalculaDuracaoContrato();
      End;
    End

    Else If (Sender = edtMesFin)  Then
    Begin
      If ((Not fEmptyDate(edtMesFin.Text)) And fEmptyDate(edtMesIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O mês inicial deve ser preenchido!', ['&O k']);
        Result := False;
        Exit;
      End;

      Result := fValidaDataHora();

      If Result Then
        pCalculaDuracaoContrato();
    End

    Else If (Sender = edtCodEql) Then
    Begin
      If fEmptyStr(edtCodEql.Text) Then
      Begin
        edtDesEql.Clear;
        objItemContrato.pLimpar;
        pLimparEquipamento;
      End
      Else
      Begin
        FblnValidarDtHr := True;
        Result := fCarregaEquipamento(edtCodEql.Text);
      End;
    End

    Else If (Sender = edtVlrDsc) and Assigned(objItemContrato) Then
    Begin

      If fStrToFloat(edtVlrDsc.Text) <> ObjItemContrato.PercentualDesconto Then
      Begin

        If objItemContrato.blnValorLocacaoAlteradoManualmente Then
        Begin
          If fMensagem('ATENÇÃO!', 'O valor líquido de locação foi alterado manualmente, para recalcular o desconto será utilizado o valor inicial de locação. ' +
                                   'Deseja prosseguir? ', ['&Sim', '&Não']) = 1 Then

            objItemContrato.blnRecalcularVlrLocacao := True
          Else
            objItemContrato.blnRecalcularVlrLocacao := False;
        End;

        If objItemContrato.fValidarDesconto(fStrToFloat(edtVlrDsc.Text), 0) Then
        Begin
          If Not objItemContrato.blnValorLocacaoAlteradoManualmente Then
          Begin
            ObjItemContrato.PercentualDesconto := fStrToFloat(edtVlrDsc.Text);
            objItemContrato.blnRecalcularVlrLocacao := True;
            pRecalcularItem;
          End;
        End
        Else
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Desconto não permitido.', ['&O k']);
          pSetFocus(edtVlrDsc);
        End;
      End;

    End

    Else If (Sender = edtVlrLocLiq) Then
    Begin
      If Assigned(objItemContrato) Then
      Begin
        objItemContrato.pCalculaValorDesconto(fStrToFloat(edtVlrLocLiq.Text),0);
        If objItemContrato.blnDescontoLiberado Then
          pRecalcularItem
        Else
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Desconto não permitido.', ['&O k']);
          pSetFocus(edtVlrDsc);
        End;
      End;
    End

    Else If (Sender = edtTaxEnt) Then
    Begin
      If StrToFloatDef(edtTaxEnt.Text, 0) <>  objContrato.ValorTaxaEntrega Then
      Begin
        If StrToFloatDef(edtTaxEnt.Text, 0) < 0 Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Valor informado é inválido.', ['&O k']);
          pSetFocus(edtVlrDsc);
        End
        Else
        Begin
          objContrato.ValorTaxaEntrega := StrToFloatDef(edtTaxEnt.Text, 0);
          pAtualizaTotais;
        End;
      End;
    End

    Else If (Sender = edtVlrTotLiq) Then
    Begin
      If Not Assigned(objItemContrato) Then
        Exit;

      objItemContrato.pCalculaValorDesconto(0, fStrToFloat(edtVlrTotLiq.Text));
      If objItemContrato.blnDescontoLiberado Then
        pRecalcularItem
      Else
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Desconto não permitido.', ['&O k']);
        pSetFocus(edtVlrDsc);
      End;
    End

    Else If (Sender = edtQtdEqu) Then
    Begin
      If fEmptyStr(edtQtdEqu.Text) Then
      Begin
        edtQtdEqu.Text := '1';
        objItemContrato.Quantidade := 1;
      End
      Else
      Begin
        If (StrToFloatDef(edtQtdEqu.Text, 0) < 1) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido informar quantidade inferior à 1(uma) unidade. Verifique!', ['&O k']);
          Result := False;
        End;

        If Assigned(objItemContrato) Then
        Begin
          objItemContrato.Quantidade := StrToFloatDef(edtQtdEqu.Text, 0);
          pRecalcularItem;
        End;
      End;
    End;

    If pnlCondicaoPgto.Visible Then
    Begin

      If (Sender = fraPagamento.edtCodCnd) Then
      Begin
        If fEmptyStr(fraPagamento.edtCodCnd.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A condição de pagamento precisa ser informada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          Result := fraPagamento.fValidaCampos(Sender, blnBuscaPorChave);
          If Result And ((Not FblnConsDadosCobLiberado) or (fraPagamento.edtCodCnd.Text <> strCodCndAnt)) Then
          Begin
            Result := fVerificaConsultaDadosCobranca(IIF(Copy(cmbStatus.Text, 0,1) = 'O', 'OR', 'PD'),
                                                     edtCodCli.Text,
                                                     edtCodVen.Text,
                                                     fraPagamento.edtCodCnd.Text,
                                                     fraPagamento.mskCndPag.Text,
                                                     fraPagamento.edtForPag.Text);
            FblnConsDadosCobLiberado := Result;

            strCodCndAnt := fraPagamento.edtCodCnd.Text;
          End;
        End;
      End

      Else If (Sender = fraPagamento.mskCndPag) Then
      Begin
        If fEmptyStr(fraPagamento.mskCndPag.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A condição de pagamento precisa ser informada!', ['&O k']);
          Result := False;
        End
        Else
          Result := fraPagamento.fValidaCampos(Sender, blnBuscaPorChave);
      End

      Else If (Sender = fraPagamento.edtForPag) Then
      Begin
        If fEmptyStr(fraPagamento.edtForPag.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A forma de pagamento precisa ser informada!', ['&O k']);
          Result := False;
        End
        Else
          Result := fraPagamento.fValidaCampos(Sender, blnBuscaPorChave);
      End

      Else If (Sender = cxGridResponsaveis) And (fCfgSis('RESLOC', VarBoolean)) Then
      Begin
        If ObjContrato.Responsavel.Count <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Pelo menos um responsável deverá ser selecionado. Verifique!', ['&O k']);
          Result := False;
        End;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadContratoLocEquip.fValidaDataHora: Boolean;
begin

  If (objContrato.TipoDuracaoContrato = 'M') Then
    Result := fValidaDataHoraContratoMensal
  Else
    Result := fValidaDataHoraContratoPadrao;

  If Not Result Then
    fMensagem('ATENÇÃO!', ObjContrato.MensagemRetorno, ['&O k']);

end;

function TfrmCadContratoLocEquip.fValidaDataHoraContratoMensal: Boolean;
begin
  Result := True;

  If ((fEmptyStr(fTiraCaracEspeciais(edtMesIni.Text))) Or
      (fEmptyStr(fTiraCaracEspeciais(edtMesFin.Text)))) Then
    Exit;

  Result := objContrato.fValidarDatasContrato(fObtemDataInicial, fObtemDataFinal);
end;

function TfrmCadContratoLocEquip.fValidaDataHoraContratoPadrao: Boolean;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text)) Or
     fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text)) Then
    Exit;

  If fEmptyStr(fTiraCaracEspeciais(edtHorIni.Text, True, True, False, True)) Or
     fEmptyStr(fTiraCaracEspeciais(edtHorFin.Text, True, True, False, True))  Then
    Exit;

  Result := objContrato.fValidarDatasContrato(fObtemDataInicial, fObtemDataFinal);

end;

function TfrmCadContratoLocEquip.fValidaLimiteContrato: Boolean;
var
  objLib: TLiberacao;
begin
  If Not (fCfgSis('LIMCTR', VarBoolean)) Then
    Exit(True);

  If (qryConCli.FieldByName('CLI_LIMCTR').AsFloat <= 0) Then
    Exit(True);

  If (qryTabela.FieldByName('EQL_TOTCON').AsFloat <= qryConCli.FieldByName('CLI_LIMCTR').AsFloat) Then
    Exit(True);

  objLib := TLiberacao.Create;
  Try
    objLib.Clear;
    objLib.strDirAce    := 'LIMCTR';
    objLib.strCodOpe    := strLoginUsuarioLogado;
    objLib.strCodDig    := strLoginUsuarioLogado;
    objLib.strCliente   := (edtCodCli.Text + '-' + edtNomCli.Text);
    objLib.strCpfCnpj   := qryConCli.FieldByName('CLI_C_G_C_').AsString;
    objLib.objMsgLibera.pAddTexto('A T E N Ç Ã O - VALOR TOTAL DO CONTRATO MAIOR QUE LIMITE DE LOCAÇÃO DE EQUIPAMENTO');
    objLib.objMsgLibera.pAddTexto('');
    objLib.objMsgLibera.pAddTexto('VALOR DO LIMITE DE LOCAÇÃO......: ' + FormatFloat('###,#0.00', qryConCli.FieldByName('CLI_LIMCTR').AsFloat));
    objLib.objMsgLibera.pAddTexto('VALOR DO CONTRATO DE LOCAÇÃO....: ' + FormatFloat('###,#0.00', qryTabela.FieldByName('EQL_TOTCON').AsFloat));
    objLib.objMsgLibera.pAddTexto('');

    Result := objLib.fLibera;
  Finally
    FreeAndNil(objLib);
  End;
end;

procedure TfrmCadContratoLocEquip.cmbStatusClick(Sender: TObject);
begin
  inherited;

  Case cmbStatus.ItemIndex Of
    0: qryTabela.FieldByName('EQL_STATUS').AsString := 'O';
    1: qryTabela.FieldByName('EQL_STATUS').AsString := 'A';
    2: qryTabela.FieldByName('EQL_STATUS').AsString := 'E';
  End;
end;

procedure TfrmCadContratoLocEquip.cxGrdItensViewKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If cdsEqlDet.IsEmpty Then
    Exit;

  If Not (qryTabela.State in [dsInsert, dsEdit]) then
      Exit;

  If Key = VK_ESCAPE Then
  Begin
    If edtCodEql.CanFocus Then
      pSetFocus(edtCodEql)
    Else
      pEscapePressed;
  End;

  If (Key = VK_DELETE) Then
  Begin
    If blnProrrogacao Then
      Exit;

    If (fMensagem('Confirmação', 'Deseja realmente excluir este equipamento?', ['&Sim', '&Não']) = 1) Then
    Begin
      objContrato.fRemoveItem(cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);

      csdEqlAce.DisableControls;
      Try
        csdEqlAce.First;
        while Not csdEqlAce.EOF do
        Begin
          If csdEqlAce.FieldByName('EQA_SEQEQU').AsString = cdsEqlDet.FieldByName('EQD_SEQEQL').AsString Then
          Begin
            csdEqlAce.Delete;
            Continue;
          End;

          csdEqlAce.Next;
        End;
      Finally
        csdEqlAce.EnableControls;
      End;

      cdsEqlDet.Delete;
      pAtualizaTotais;
    End;
  End;

  If Key = VK_RETURN Then
  Begin
    pEditarItem;
  End;

end;

procedure TfrmCadContratoLocEquip.cxGridTableResponsavelKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fValidaCampos(cxGridResponsaveis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadContratoLocEquip.cxGridTableResponsavelMARCADOPropertiesChange(
  Sender: TObject);
begin
  inherited;

  If TcxCheckBox(Sender).Checked Then
  Begin
    If ObjContrato.fValidaResponsaveisContrato Then
    Begin
      ObjContrato.fAddResponsavel(cdsCliCtt.FieldByName('CLI_CODCLI').AsString,
                                 cdsCliCtt.FieldByName('AUTOINCREM').AsString);
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', ObjContrato.MensagemRetorno, ['&Ok']);
      TcxCheckBox(Sender).Checked := False;
    End;
  End
  Else ObjContrato.fRemoveResponsavel(cdsCliCtt.FieldByName('CLI_CODCLI').AsString,
                                      cdsCliCtt.FieldByName('AUTOINCREM').AsString);

end;

function TfrmCadContratoLocEquip.DatasInicialEFinalInformadas: Boolean;
begin
  Result := ((Not fEmptyStr(fTiraCaracEspeciais(edtDtaIni.Text))) And
            (Not fEmptyStr(fTiraCaracEspeciais(edtDtaFin.Text))) And
            (Not fEmptyStr(fTiraCaracEspeciais(edtHorIni.Text, True, True, False, True))) And
            (Not fEmptyStr(fTiraCaracEspeciais(edtHorFin.Text, True, True, False, True))));
end;

procedure TfrmCadContratoLocEquip.pAdicionarItemGrid(
  const aItem: TItemContratoLocacaoEquipamentos);
var
  intCnt: Integer;
begin
  cdsEqlDet.DisableControls;
  csdEqlAce.DisableControls;
  Try
    Try
      cdsEqlDet.Insert;
      cdsEqlDet.FieldByName('AUTOINCREM').AsString   := aItem.AutInc;
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
      cdsEqlDet.FieldByName('EQL_SITENC').AsString   := IIF(aItem.DataEncerramento > 0, 'Equipamento Encerrado', 'Equipamento Ativo');
      cdsEqlDet.FieldByName('EQD_DTAENC').AsDateTime := aItem.DataEncerramento;
      cdsEqlDet.FieldByName('EQL_VLRAQU').AsFloat    := aItem.Equipamento.ValorAqu;
      cdsEqlDet.FieldByName('EQD_TOTDIA').AsFloat    := IIF(aItem.TipoCalculoLocacao = tpDiaria, aItem.Contrato.TotalDias, 0);
      cdsEqlDet.FieldByName('EQD_TOTHOR').AsFloat    := IIF(aItem.TipoCalculoLocacao = tpHoras,  aItem.Contrato.TotalHoras, 0);
      cdsEqlDet.FieldByName('EQD_TOTMES').AsFloat    := IIF(aItem.TipoCalculoLocacao = tpMensal, aItem.Contrato.TotalMeses, 0);
      cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat    := aItem.Quantidade;
      cdsEqlDet.Post;

      For intCnt := 0 to aItem.Acessorios.Count-1  Do
      Begin
        pAdicionarAcessorioGrid(aItem.Acessorios[intCnt]);
      End;
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

procedure TfrmCadContratoLocEquip.pAdicionarAcessorioGrid(const aItem: TAcessorioContratoLocacaoEquipamentos);
Begin
  csdEqlAce.Insert;
  csdEqlAce.FieldByName('EQA_SEQEQU').AsString := aItem.CodEquipamento;
  csdEqlAce.FieldByName('EQA_SEQACL').AsString := aItem.Acessorio.AutInc;
  csdEqlAce.FieldByName('CODIGO').AsString     := aItem.Acessorio.Codigo;
  csdEqlAce.FieldByName('DESCRICAO').AsString  := aItem.Acessorio.Descricao;
  csdEqlAce.FieldByName('QUANTIDADE').AsFloat  := aItem.Quantidade;
  csdEqlAce.FieldByName('EQA_VLRAQU').AsFloat  := aItem.Acessorio.ValorAqu * (aItem.ItemEquipamento.Quantidade);
  csdEqlAce.FieldByName('EQA_TOTAQU').AsFloat  := aItem.Acessorio.ValorAqu * (aItem.ItemEquipamento.Quantidade * aItem.Quantidade);
  csdEqlAce.FieldByName('EQA_QTDTOT').AsFloat  := aItem.ItemEquipamento.Quantidade * aItem.Quantidade;
  csdEqlAce.FieldByName('EQA_VLRADC').AsFloat  := aItem.Acessorio.ValorAdicional;
  csdEqlAce.FieldByName('EQA_TOTADC').AsFloat  := aItem.ItemEquipamento.Quantidade * ( aItem.Quantidade * aItem.Acessorio.ValorAdicional );
  csdEqlAce.Post;
End;

procedure TfrmCadContratoLocEquip.pAfterOpen(DataSet: TDataSet);
begin
  pFormatarCampos;
  pCarregarContrato;
end;

procedure TfrmCadContratoLocEquip.pAjustaTelaEmissaoContrato;
begin
  Self.Caption := 'Contratos de Locação de Equipamentos';
  grdItensEQL_SITENC.Visible := False;
  btnGerarPedidoAdt.Visible := fVerificaAcessoSistema('GERADT', strLoginUsuarioLogado);
end;

procedure TfrmCadContratoLocEquip.pAjustaTelaProrrogacao;
begin
  Self.Caption := 'Prorrogação de Contrato';
  grdItensEQL_SITENC.Visible := True;
  pHabilitaCamposProrrogacao;
  btnGerarPedidoAdt.Visible := False;
end;

procedure TfrmCadContratoLocEquip.pHabilitaCamposProrrogacao;
begin
  If Not blnProrrogacao Then
    Exit;

  edtDtaFin.Enabled := True;
  edtHorFin.Enabled := True;

  btnCancelarContrato.Enabled := False;
  btnEncerrarContrato.Enabled := False;
  btnAlterar.Enabled := qryTabela.FieldByName('EQL_STATUS').AsString = 'A';
  btnExcluir.Enabled := False;
  btnIncluir.Enabled := False;
  edtCodCli.Enabled := False;
  edtDtaIni.Enabled := False;
  edtHorIni.Enabled := False;
  edtTaxEnt.Enabled := False;
  edtMesIni.Enabled := False;

  edtMesFin.Enabled := ObjContrato.TipoDuracaoContrato = 'M';
  edtDtaFin.Enabled := ObjContrato.TipoDuracaoContrato <> 'M';
  edtHorFin.Enabled := ObjContrato.TipoDuracaoContrato <> 'M';

  If Not blnProrrogacao Then
  Begin
    edtCodCli.Enabled := False;
    edtCodVen.Enabled := False;
    edtDtaIni.Enabled := False;
    edtHorIni.Enabled := False;
    pnlCondicaoPagamento.Enabled := False;
    edtCodEql.Enabled := False;
    cmbEntCli.Enabled := False;

    edtDtaFin.Enabled := False;
    edtHorFin.Enabled := False;
  End;
end;

procedure TfrmCadContratoLocEquip.pCarregarContrato;
begin
  ObjContrato.pLimpar;
  pLimparEquipamento;
  If Assigned(objItemContrato) Then
    objItemContrato.pLimpar;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  If blnProrrogacao Then
    pCarregarContratoProrrogacao
  Else
    pCarregarContratoEdicao;
end;

procedure TfrmCadContratoLocEquip.pCarregarContratoEdicao;
begin
  If Not(fValidaTravasContrato(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
    Exit;

  objContrato.fCarregarContrato(qryTabela.FieldByName('AUTOINCREM').AsString);

  pSetaStatus(objContrato.Status);

  pCarregaCliente();
  pCarregaVendedor();
  pCarregaDetalhes;

  fraPagamento.mskCndPag.Text := qryTabela.FieldByName('EQL_CONPAG').AsString;
  fraPagamento.edtCodCnd.Text := qryTabela.FieldByName('EQL_CODCND').AsString;
  fraPagamento.edtForPag.Text := qryTabela.FieldByName('EQL_CODFPG').AsString;
  fraPagamento.edtDesForPag.Text := objContrato.DescricaoFormPgto;

  edtAutIncFatGor.Text := objContrato.NumDocPedAdiantamento;

  btnAlterar.Enabled := objContrato.Status = 'O';
  btnExcluir.Enabled := objContrato.Status = 'O';

  edtMesIni.Text := objContrato.strMesIni;
  edtMesFin.Text := objContrato.strMesFin;

  btnCancelarContrato.Enabled := FobjValidaCtr.fPodeCancelarContrato;
  btnEncerrarContrato.Enabled := (objContrato.Status = 'A') ;
  strCodEqlAnt := EmptyStr;

  If Not(fEmptyStr(objContrato.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_CADCTR_LOCEQU + objContrato.AutInc, True, False);

end;

procedure TfrmCadContratoLocEquip.pCarregarContratoProrrogacao;
begin
  If Not(fValidaTravasContrato(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
    Exit;

  objContrato.fCarregarContrato(qryTabela.FieldByName('AUTOINCREM').AsString);
  objProrrogacao.fAddContrato(objContrato);

  If Not objProrrogacao.fValidarPodeProrrogarContato Then
  Begin
    fMensagem('ATENÇÃO!', objProrrogacao.MensagemRetorno, ['&Ok']);
    pLimparEquipamento;
    If Assigned(objItemContrato) Then
      objItemContrato.pLimpar;
    Exit;
  End;

  pSetaStatus(qryTabela.FieldByName('EQL_STATUS').AsString);
  pCarregaCliente();
  pCarregaVendedor();
  edtMesIni.Text := objContrato.strMesIni;
  edtMesFin.Text := objContrato.strMesFin;

  If objProrrogacao.blnProrrogacaoRealizada Then
    pCarregaDetalhes;

  fraPagamento.mskCndPag.Text := qryTabela.FieldByName('EQL_CONPAG').AsString;
  fraPagamento.edtCodCnd.Text := qryTabela.FieldByName('EQL_CODCND').AsString;
  fraPagamento.edtForPag.Text := qryTabela.FieldByName('EQL_CODFPG').AsString;
  fraPagamento.edtDesForPag.Text := objContrato.DescricaoFormPgto;

  edtAutIncFatGor.Text := objContrato.NumDocPedAdiantamento;

  btnIncluir.Enabled := False;
  btnAlterar.Enabled := qryTabela.FieldByName('EQL_STATUS').AsString = 'A';
  btnExcluir.Enabled := False;
  btnCancelarContrato.Enabled := False;
  btnEncerrarContrato.Enabled := False;
  strCodEqlAnt := EmptyStr;

  If Not(fEmptyStr(objContrato.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_PRORRO_LOCEQU + objContrato.AutInc, True, False);

end;

procedure TfrmCadContratoLocEquip.pCarregarDiariasNegociacao(const objEquParam: TEquipamentoLocacaoPrincipal);
var
  intCnt: Integer;
  fltVlrDiaria: Double;
begin
  If Not Assigned(objEquParam) Then
    Exit;

  tsNegociacao.TabVisible := objEquParam.Diarias.Count > 0;

  If cdsNegociacaoDiarias.Active Then
    cdsNegociacaoDiarias.EmptyDataSet;

  fltVlrDiaria := objEquParam.ValorLocacaoDiaria;

  cdsNegociacaoDiarias.Insert;
  cdsNegociacaoDiarias.FieldByName('QTDDIA').AsInteger := 1;
  cdsNegociacaoDiarias.FieldByName('VLRTOT').AsFloat   := fltVlrDiaria;
  cdsNegociacaoDiarias.FieldByName('VLRDIA').AsFloat   := fltVlrDiaria;
  cdsNegociacaoDiarias.FieldByName('DTAEST').AsDateTime:= (objContrato.DataInicial + 1);
  cdsNegociacaoDiarias.Post;

  For intCnt := 0 to objEquParam.Diarias.Count-1 Do
  Begin
    cdsNegociacaoDiarias.Insert;
    cdsNegociacaoDiarias.FieldByName('QTDDIA').AsInteger := objEquParam.Diarias[intCnt].QuantidadeDias;
    cdsNegociacaoDiarias.FieldByName('VLRTOT').AsFloat   := objEquParam.Diarias[intCnt].ValorTotal;
    cdsNegociacaoDiarias.FieldByName('VLRDIA').AsFloat   := objEquParam.Diarias[intCnt].ValorDiaria;
    cdsNegociacaoDiarias.FieldByName('DTAEST').AsDateTime:= (objContrato.DataInicial + objEquParam.Diarias[intCnt].QuantidadeDias);
    cdsNegociacaoDiarias.Post;
  End;
end;

procedure TfrmCadContratoLocEquip.pCalculaDuracaoContrato;
begin

  If Not DatasEHorasInformadas() Then
  Begin
    qryTabela.FieldByName('EQL_TOTHOR').Clear;
    qryTabela.FieldByName('EQL_TOTDIA').Clear;
    qryTabela.FieldByName('EQL_TOTMES').Clear;
    Exit;
  End;

  If (Not DatasInicialEFinalInformadas) And
      MesInicialEFinalInformado Then
  Begin
    objContrato.SugerirDataInicialContratoMensal(edtMesIni.Text, edtMesFin.Text);
  End;

  If Not objContrato.fAlterarDataTerminoContrato(fObtemDataInicial, fObtemDataFinal, edtMesIni.Text, edtMesFin.Text) Then
  Begin
    fMensagem('ATENÇÃO!', objContrato.MensagemRetorno, ['&O k']);
    Exit;
  End
  Else
  Begin
    pCarregaDetalhes;
    pAtualizaTotais;
  End;

  qryTabela.FieldByName('EQL_TIPDUR').AsString  := objContrato.TipoDuracaoContrato;
  qryTabela.FieldByName('EQL_TOTDIA').AsInteger := objContrato.TotalDias;
  qryTabela.FieldByName('EQL_TOTHOR').AsFloat   := objContrato.TotalHoras;
  qryTabela.FieldByName('EQL_TOTMES').AsFloat   := objContrato.TotalMeses;

  If objContrato.TipoDuracaoContrato  = 'M' Then
  Begin
    qryTabela.FieldByName('EQL_DTAINI').AsDateTime := objContrato.DataInicial;
    qryTabela.FieldByName('EQL_HORINI').AsDateTime := objContrato.HoraInicial;
    qryTabela.FieldByName('EQL_DTAFIN').AsDateTime := objContrato.DataFinal;
    qryTabela.FieldByName('EQL_HORFIN').AsDateTime := objContrato.HoraFinal;
  End;

  If Assigned(ObjItemContrato) Then
    pCarregarDiariasNegociacao(ObjItemContrato.Equipamento);
end;

procedure TfrmCadContratoLocEquip.pAtualizaTotais(blnGravarVlrAqu: Boolean = False);
begin
  objContrato.pCalculaTotais;
  If qryTabela.State in [dsInsert, dsEdit]  Then
  Begin
    qryTabela.FieldByName('EQL_TOTCON').AsFloat := objContrato.ValorTotalContrato;
    qryTabela.FieldByName('EQL_TOTADC').AsFloat := objContrato.ValorTotalAdicionalAcessorios;
    qryTabela.FieldByName('EQL_QTDEQU').AsFloat := objContrato.QuantidadeEquipamentos;
    qryTabela.FieldByName('EQL_TOTMES').AsFloat := objContrato.TotalMeses;
    qryTabela.FieldByName('EQL_TIPDUR').AsString := objContrato.TipoDuracaoContrato;
    qryTabela.FieldByName('EQL_MESINI').AsDateTime := objContrato.DataInicial;
    qryTabela.FieldByName('EQL_MESFIN').AsDateTime := objContrato.DataFinal;

    pCalcularTotalAqu(blnGravarVlrAqu);
  End;
end;

procedure TfrmCadContratoLocEquip.pCalcularTotalAqu(blnGravarVlrAqu: Boolean = True);
var
  intRecNo: Integer;
Begin
  FfltTotalAqu := 0;

  Try
    cdsEqlDet.DisableControls;
    intRecNo := cdsEqlDet.RecNo;
    Try
      cdsEqlDet.First;
      While Not cdsEqlDet.Eof Do
      Begin
        FfltTotalAqu := FfltTotalAqu + cdsEqlDet.FieldByName('EQL_VLRAQU').AsFloat;
        cdsEqlDet.Next;
      End;
    Finally
      cdsEqlDet.RecNo := intRecNo;
      cdsEqlDet.EnableControls;
    End;

    csdEqlAce.DisableControls;
    intRecNo := csdEqlAce.RecNo;
    Try
      csdEqlAce.First;
      While Not csdEqlAce.Eof Do
      Begin
        FfltTotalAqu := FfltTotalAqu + csdEqlAce.FieldByName('EQA_TOTAQU').AsFloat;
        csdEqlAce.Next;
      End;
    Finally
      csdEqlAce.RecNo := intRecNo;
      csdEqlAce.EnableControls;
    End;

  Finally
    If blnGravarVlrAqu Then
      qryTabela.FieldByName('EQL_TOTAQU').AsFloat := FfltTotalAqu;
  End;
End;

procedure TfrmCadContratoLocEquip.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  edtNomCli.Text := qryConCli.FieldByName('CLI_NOMCLI').AsString;
  fraPagamento.strCodCli    := edtCodCli.Text;
  pCarregaEnderecos();
  ObjContrato.CodCliente  := edtCodCli.Text;
  ObjContrato.NomCliente  := edtNomCli.Text;

  pCarregaContatos(ObjContrato.CodCliente);

end;

procedure TfrmCadContratoLocEquip.pCarregaContatos(strCodCli: String);
Var
  intCnt: Integer;
  lstContatos  : TObjectList;
  objCliCtt: TCliCtt;
begin

  lstContatos := TCliCtt.fRetContatos(strCodCli, False);
  Try
    cdsCliCtt.EmptyDataSet;

    For intCnt := 0 To lstContatos.Count -1 Do
    Begin
      objCliCtt := TCliCtt(lstContatos[intCnt]);
      pAdicionaContatoCds(objCliCtt);
    End;

  Finally
    FreeAndNil(lstContatos);
  End;
end;

procedure TfrmCadContratoLocEquip.pAdicionaContatoCds(objContato: TCliCtt);
begin
  cdsCliCtt.Append;

  TStringField(cdsCliCtt.FieldByName('CLI_CPFCTT')).EditMask := '999.999.999-99;0;';

  If FobjValidaCtr.fVerificaContatoInseridoContrato(objContato.strCodCli,
                                                    objContato.strAutoincrem) Then
    cdsCliCtt.FieldByName('MARCADO').AsString := 'S'
  Else
    cdsCliCtt.FieldByName('MARCADO').AsString := 'N';

  cdsCliCtt.FieldByName('CLI_CODCLI').AsString := objContato.strCodCli;
  cdsCliCtt.FieldByName('CLI_CPFCTT').AsString := objContato.strCpfCtt;
  cdsCliCtt.FieldByName('CLI_RG_CTT').AsString := objContato.strRg_Ctt;
  cdsCliCtt.FieldByName('CLI_NOMCTT').AsString := objContato.strNomCtt;
  cdsCliCtt.FieldByName('CLI_CGOCTT').AsString := objContato.strCgoCtt;
  cdsCliCtt.FieldByName('CLI_NOMCGO').AsString := objContato.strNomCgo;
  cdsCliCtt.FieldByName('AUTOINCREM').AsString := objContato.strAutoincrem;

  cdsCliCtt.Post;
end;


procedure TfrmCadContratoLocEquip.pCarregaDetalhes;
var
  intCont: Integer;
begin
  If cdsEqlDet.Active Then
    cdsEqlDet.EmptyDataSet;

  If csdEqlAce.Active Then
    csdEqlAce.EmptyDataSet;

  For intCont := 0 to objContrato.Itens.Count -1 Do
  Begin
    pAdicionarItemGrid(objContrato.Itens[intCont]);
  End;
end;

procedure TfrmCadContratoLocEquip.pCarregaEnderecos;
begin
  qryEntCli.Close;
  qryEntCli.ParamByName('CODCLI').AsString := edtCodCli.Text;
  qryEntCli.Open;

  If (qryTabela.State in [dsInsert, dsEdit]) And (qryEntCli.RecordCount = 1) Then
    qryTabela.FieldByName('EQL_ENTCLI').AsString := qryEntCli.FieldByName('AUTOINCREM').AsString;
end;

function TfrmCadContratoLocEquip.fCarregaEquipamento(const aCodEql: String): Boolean;
var
  frmObservacao: TfrmObservacao;
begin
  Result := True;

  If blnProrrogacao Then
    Exit;

  If cdsEqlDet.State <> dsEdit Then
  Begin
    If strCodEqlAnt <> aCodEql Then
    Begin
      If Assigned(objItemContrato) Then
      Begin
        objItemContrato.pLimpar;
      End;
    End;
  End;

  pLimparEquipamento;
  edtCodEql.Text := aCodEql;
  SetLength(arrEquipamentos, 0);
  pAddEquipamento(edtCodEql.Text);

  edtQtdEqu.Enabled := False;
  edtQtdEqu.Text := IIF(Assigned(objItemContrato), FloatToStr(objItemContrato.Quantidade), '1');

  If Not DatasEHorasInformadas Then
  Begin
    Result := False;
    pMensagemOk('As datas para cálculo do valor do contrato não foram informadas!');
    pSetFocus(edtCodEql);
    Exit;
  End;

  If Not objContrato.fEquipamentoDisponivel(arrEquipamentos,
                                            edtNumCon.Text,
                                            False,
                                            IIF(objContrato.TipoDuracaoContrato = 'M',
                                                DateTimeToStr(objContrato.DataInicial),
                                                edtDtaIni.Text),
                                            edtHorIni.Text,
                                            IIF(objContrato.TipoDuracaoContrato = 'M',
                                                DateTimeToStr(objContrato.DataFinal),
                                                edtDtaFin.Text),
                                            edtHorFin.Text) Then
  Begin
    Result := False;
    pSetFocus(edtCodEql);
    Exit;
  End;

  If cdsEqlDet.State <> dsEdit Then
    If fEquipamentoJaInseridoNesseContrato(edtCodEql.Text) Then
    Begin
      Result := False;
      pMensagemOk('O equipamento ' + edtCodEql.Text + ' já foi inserido nesse contrato!');
      pSetFocus(edtCodEql);
      Exit;
    End;

  objEquipamento.pCarregaEquipamento('', edtCodEql.Text);
  If Not objEquipamento.fValidarEquipamento Then
  Begin
    If objEquipamento.TravaInclusao Then
    Begin
      pCriarFormularios(TfrmObservacao, frmObservacao);
      Try
        frmObservacao.Caption := 'Equipamento ' + objEquipamento.Codigo + ' - ' + objEquipamento.Descricao +' com restrições: ';
        frmObservacao.lblMensagem.Visible := False;
        frmObservacao.memObs.Texto := objEquipamento.MensagemTravaInclusao;
        frmObservacao.memObs.SelStart := 0;
        frmObservacao.ShowModal;

        Result := False;
        pSetFocus(edtCodEql);
        Exit;
      Finally
        pFreeAndNil(frmObservacao);
      End;
    End
    Else
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', objEquipamento.Mensagem, ['&O k']);
      pSetFocus(edtCodEql);
      Exit;
    End;
  End
  Else
  Begin
    objItemContrato.Equipamento := objEquipamento;

    If objItemContrato.TipoCalculoLocacao = tpNone Then
      objItemContrato.pCarregarTipoLocacaoEquipamento;

    edtQtdEqu.Enabled := objEquipamento.blnNaoPossuiSerie;
    edtQtdEqu.Text := IIF(objEquipamento.blnNaoPossuiSerie, FloatToStr(objItemContrato.Quantidade), '1');
    pCarregaTipoCalculoLocacao;
    pRecalcularItem;

    If objItemContrato.ValorTotalLiquido <= 0 Then
    Begin
      If (objItemContrato.TipoCalculoLocacao = tpMensal) and (objContrato.TipoDuracaoContrato <> 'M') Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Foi selecionada opção para cálculo do valor mensal para o contrato para um item que não está em um contrato mensal. '  +
                              ' Verifique o preenchimento das datas de início do contrato ou selecione a opção em diárias ou horas para cálculo do valor do item!', ['&O k']);
        pSetFocus(edtCodEql);
        Exit;
      End
      Else
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Não é permitido inserir item sem valor ao contrato. Verifique!', ['&O k']);
        pSetFocus(edtCodEql);
        Exit;
      end;
    End;

    edtDesEql.Text := objEquipamento.Descricao;
  End;

  pCarregarDiariasNegociacao(objEquipamento);
  strCodEqlAnt := edtCodEql.Text;
end;

function TfrmCadContratoLocEquip.fValidarValorLocacao: Boolean;
begin
  Result := False;

  If Not(Assigned(objItemContrato)) Then
    Exit;

  Case rgTipoDuracaoLocacao.ItemIndex Of
    0 : Result := objItemContrato.Equipamento.ValorLocacaoDiaria > 0;
    1 : Result := objItemContrato.Equipamento.ValorLocacao > 0;
    2 : Result := objItemContrato.Equipamento.ValorLocacaoMensal > 0;
  End;
end;

function TfrmCadContratoLocEquip.fVerificaProcessoExecucao(
  const strNomPro: String): Boolean;
begin
  If fEmptyStr(strNomPro) Then
    Exit(False);

  Result := fProcessExists(strNomPro);
end;

function TfrmCadContratoLocEquip.MesInicialEFinalInformado: Boolean;
begin
  Result :=  ((Not fEmptyStr(fTiraCaracEspeciais(edtMesIni.Text))) And
             (Not fEmptyStr(fTiraCaracEspeciais(edtMesFin.Text))))
            ;
end;

procedure TfrmCadContratoLocEquip.pCarregaTipoCalculoLocacao;
Begin
  If Not Assigned(objItemContrato) Then
    Exit;

  pHabilitaTipoCalculoLocacao;

  Case objItemContrato.TipoCalculoLocacao of
    tpDiaria : pCarregaTipoCalculoLocacaoDiarias;
    tpHoras  : pCarregaTipoCalculoLocacaoHoras;
    tpMensal : pCarregaTipoCalculoLocacaoMensal;
  End;
End;

procedure TfrmCadContratoLocEquip.pCarregaTipoCalculoLocacaoDiarias;
begin
  rgTipoDuracaoLocacao.ItemIndex := 0;
  If (objItemContrato.Equipamento.ValorLocacao = 0) And
     (objItemContrato.Equipamento.ValorLocacaoMensal = 0) Then
  Begin
    lblInfo.Caption := 'Equipamento informado não tem definição de valor de horas em seu cadastro. Sendo assim, só é permitido contratar em diária.';
    lblInfo.Font.Color := clRed;
    rgTipoDuracaoLocacao.Enabled := False;
  End;
end;

procedure TfrmCadContratoLocEquip.pCarregaTipoCalculoLocacaoHoras;
begin
  rgTipoDuracaoLocacao.ItemIndex := 1;
  If (objItemContrato.Equipamento.ValorLocacaoDiaria = 0) And
     (objItemContrato.Equipamento.ValorLocacaoMensal = 0) Then
  Begin
    lblInfo.Caption := 'Equipamento informado não tem definição de valor de diária em seu cadastro. Sendo assim, só é permitido contratar em horas.';
    lblInfo.Font.Color := clRed;
    rgTipoDuracaoLocacao.Enabled := False;
  End;
end;

procedure TfrmCadContratoLocEquip.pCarregaTipoCalculoLocacaoMensal;
begin
  rgTipoDuracaoLocacao.ItemIndex := 2;
  If (objItemContrato.Equipamento.ValorLocacaoMensal > 0) And
     (objItemContrato.Equipamento.ValorLocacaoDiaria = 0) And
     (objItemContrato.Equipamento.ValorLocacao = 0) Then
  Begin
    lblInfo.Caption := 'Equipamento informado não tem definição de valor de locação diária/hora em seu cadastro. Sendo assim, só é permitido contratar em meses.';
    lblInfo.Font.Color := clRed;
    rgTipoDuracaoLocacao.Enabled := False;
  End;
end;

procedure TfrmCadContratoLocEquip.pCarregaVendedor;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodVen.Text);
  edtNomVen.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;

  ObjContrato.Vendedor.Codigo := edtCodVen.Text;
  ObjContrato.Vendedor.Nome := edtNomVen.Text;
end;

procedure TfrmCadContratoLocEquip.pEditarItem;
begin

  If Assigned(objItemContrato) Then
    objItemContrato.pLimpar;

  pLimparEquipamento;

  If cdsEqlDet.FieldByName('EQD_DTAENC').AsDateTime > 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível modificar um equipamento encerrado!', ['&O k']);
    Exit;
  End;

  edtCodEql.Text     := cdsEqlDet.FieldByName('EQD_SEQEQL').AsString;
  edtDesEql.Text     := cdsEqlDet.FieldByName('EQD_DESCRI').AsString;
  edtVlrLoc.Text     := FormatFloat(FstrLocDec, cdsEqlDet.FieldByName('EQD_VALHOR').AsFloat);
  edtVlrTot.Text     := FormatFloat('#,##0.00', cdsEqlDet.FieldByName('EQD_TOTEQL').AsFloat);
  edtVlrDsc.Text     := FormatFloat('#,##0.00', cdsEqlDet.FieldByName('EQD_PERDES').AsFloat);
  edtVlrLocLiq.Text  := FormatFloat(FstrLocDec, cdsEqlDet.FieldByName('EQD_VLLOCL').AsFloat);
  edtVlrTotLiq.Text  := FormatFloat('#,##0.00', cdsEqlDet.FieldByName('EQD_TOTLIQ').AsFloat);
  edtQtdEqu.Text     := FormatFloat('#,##0.00', cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat);

  ObjItemContrato.ValorLocacaoContratado  := cdsEqlDet.FieldByName('EQD_VALHOR').AsFloat;
  ObjItemContrato.ValorLocacaoContratado  := cdsEqlDet.FieldByName('EQD_VALHOR').AsFloat;
  ObjItemContrato.ValorTotalLocacaoContratado := cdsEqlDet.FieldByName('EQD_TOTEQL').AsFloat;
  ObjItemContrato.PercentualDesconto := cdsEqlDet.FieldByName('EQD_PERDES').AsFloat;
  ObjItemContrato.ValorLocacaoLiquido := cdsEqlDet.FieldByName('EQD_VLLOCL').AsFloat;
  ObjItemContrato.ValorTotalLiquido := cdsEqlDet.FieldByName('EQD_TOTLIQ').AsFloat;
  ObjItemContrato.blnValorLocacaoAlteradoManualmente := (cdsEqlDet.FieldByName('EQD_VLRALT').AsString = 'S');

  ObjItemContrato.TipoCalculoLocacao := fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(cdsEqlDet.FieldByName('EQD_TIPDUR').AsString);
  ObjItemContrato.pCarregar('', cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);
  ObjItemContrato.Quantidade := cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat;
  ObjItemContrato.pCalcularValorLocacao;
  pCarregaTipoCalculoLocacao;
  pCarregarDiariasNegociacao(ObjItemContrato.Equipamento);
  cdsEqlDet.Edit;
end;

procedure TfrmCadContratoLocEquip.pAtualizarItemGrid(
  const aItem: TItemContratoLocacaoEquipamentos);
begin
  cdsEqlDet.DisableControls;
  csdEqlAce.DisableControls;
  Try
    Try
      If Not cdsEqlDet.Locate('EQD_SEQEQL', aItem.Equipamento.Codigo, []) Then
        Exit;

      If cdsEqlDet.State <> dsEdit Then
        cdsEqlDet.Edit;

      cdsEqlDet.FieldByName('AUTOINCREM').AsString   := aItem.AutInc;
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
      cdsEqlDet.FieldByName('EQD_VLRALT').AsString   := IIF(aItem.blnValorLocacaoAlteradoManualmente, 'S', 'N') ;
      cdsEqlDet.FieldByName('EQL_VLRAQU').AsFloat    := aItem.Equipamento.ValorAqu;
      cdsEqlDet.FieldByName('EQD_TOTDIA').AsFloat    := IIF(aItem.TipoCalculoLocacao = tpDiaria, aItem.Contrato.TotalDias, 0);
      cdsEqlDet.FieldByName('EQD_TOTHOR').AsFloat    := IIF(aItem.TipoCalculoLocacao = tpHoras,  aItem.Contrato.TotalHoras, 0);
      cdsEqlDet.FieldByName('EQD_TOTMES').AsFloat    := IIF(aItem.TipoCalculoLocacao = tpMensal, aItem.Contrato.TotalMeses, 0);
      cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat    := aItem.Quantidade;

      cdsEqlDet.Post;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadContratoLocEquip.pAtualizarItemGrid]');
      End;
    End;
  Finally
    csdEqlAce.EnableControls;
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmCadContratoLocEquip.pAtualizarItemObjContrato(
  const aItem: TItemContratoLocacaoEquipamentos);
var
  itemContrato: TItemContratoLocacaoEquipamentos;
begin
  itemContrato := ObjContrato.fRetornaItemContrato(aItem.Equipamento.Codigo);
  itemContrato.ValorLocacaoContratado := aItem.ValorLocacaoContratado;
  itemContrato.ValorTotalLocacaoContratado := aItem.ValorTotalLocacaoContratado;
  itemContrato.PercentualDesconto := aItem.PercentualDesconto;
  itemContrato.ValorLocacaoLiquido := aItem.ValorLocacaoLiquido;
  itemContrato.ValorTotalLiquido := aItem.ValorTotalLiquido;
  itemContrato.blnValorLocacaoAlteradoManualmente := aItem.blnValorLocacaoAlteradoManualmente;
  itemContrato.TipoCalculoLocacao := aItem.TipoCalculoLocacao;
  itemContrato.blnRecalcularVlrLocacao := (Not aItem.blnValorLocacaoAlteradoManualmente);
  itemContrato.Quantidade := aItem.Quantidade;
  itemContrato.pCalcularValorLocacao;
end;

procedure TfrmCadContratoLocEquip.pFinalizaGravacaoContrato(blnGravou, blnExibirMensagem: Boolean);
begin
  If blnGravou Then
  Begin
    pHabilitaDesabilitaEdicaoContrato;

    If blnProrrogacao Then
    Begin
      If fMensagem('ATENÇÃO!', 'Deseja imprimir o contrato com os novos prazos e valores?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        btnImprimir.Click;
        blnExibirMensagem := False;
      End;
    End;

    If blnExibirMensagem Then
    Begin
      If blnGravou  Then
        pMensagemOk('Processo concluído com sucesso!')
      Else If Not fEmptyStr(FMensagemRetorno) Then
        fMensagem('ATENÇÃO!', FMensagemRetorno, ['&O k']);
    End;

  End
  Else
  Begin
    If (Not blnProrrogacao) And (cmbStatus.Text = fStatusSituacaoContratoToStrSituacaoContrato(stAtivo))  Then
    Begin
      objContrato.fAlterarStatusContrato('O');
    End;
  End;
end;

procedure TfrmCadContratoLocEquip.pForcaLimparAplicacao;
begin
  If fVerificaProcessoExecucao('soffice.bin') Then
    KillProcess('soffice.bin');
end;

procedure TfrmCadContratoLocEquip.pFormatarCampos;
begin
  TDateField(qryTabela.FieldByName('EQL_DTAINI')).EditMask := '99/99/9999';
  TDateField(qryTabela.FieldByName('EQL_DTAFIN')).EditMask := '99/99/9999';
  TTimeField(qryTabela.FieldByName('EQL_HORINI')).EditMask := '99:99';
  TTimeField(qryTabela.FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
  TTimeField(qryTabela.FieldByName('EQL_HORFIN')).EditMask := '99:99';
  TTimeField(qryTabela.FieldByName('EQL_HORFIN')).DisplayFormat  := 'hh:nn';
  TFloatField(qryTabela.FieldByName('EQL_TOTHOR')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('EQL_TOTDIA')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('EQL_TOTCON')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('EQL_TOTAQU')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('EQL_TAXENT')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('EQL_TOTADC')).DisplayFormat := '#,##0.00';

  TFloatField(cdsEqlDet.FieldByName('EQD_VALHOR')).DisplayFormat := FstrLocDec;
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTEQL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_PERDES')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_VLLOCL')).DisplayFormat := FstrLocDec;
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTLIQ')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQL_VLRCAU')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQL_VLRAQU')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTDIA')).DisplayFormat := '#,##0';
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTHOR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsEqlDet.FieldByName('EQD_TOTMES')).DisplayFormat := '#,##0';

  TFloatField(csdEqlAce.FieldByName('QUANTIDADE')).DisplayFormat := '#,##0.00';
  TFloatField(csdEqlAce.FieldByName('EQA_VLRAQU')).DisplayFormat := '#,##0.00';
  TFloatField(csdEqlAce.FieldByName('EQA_TOTAQU')).DisplayFormat := '#,##0.00';
  TFloatField(csdEqlAce.FieldByName('EQA_QTDTOT')).DisplayFormat := '#,##0.00';
  TFloatField(csdEqlAce.FieldByName('EQA_VLRADC')).DisplayFormat := '#,##0.00';
  TFloatField(csdEqlAce.FieldByName('EQA_TOTADC')).DisplayFormat := '#,##0.00';

end;

function TfrmCadContratoLocEquip.fGerarPedidoVenda(pgbStatus: TcxProgressBar = nil): Boolean;
var
  objPedido: TPedidoContratoLocacao;
begin
  Result := False;

  If Not pnlCondicaoPgto.Visible Then
  Begin
    Result := True;
    Exit;
  End;

  objPedido := TPedidoContratoLocacao.Create(objContrato);
  Try
    If ((objPedido.fGerarPedido(pgbStatus)) And (Not(fEmptyStr(objPedido.AutIncFatGor)))) Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('EQL_AUT_PD').AsString := objPedido.AutIncFatGor;
      qryTabela.Post;

      edtAutIncFatGor.Text := objPedido.NumDoc;
      Result := Not fEmptyStr(objPedido.NumDoc);
    End;
  Finally
    If Not Result Then
      FMensagemRetorno := 'Não foi possível gerar o pedido de adiantamento.';

    FreeAndNil(objPedido);
  End;
end;

function TfrmCadContratoLocEquip.fProcessaPedidoVendaInterno(pgbStatus: TcxProgressBar = nil): Boolean;
begin

  If Not fCfgSis('CPGCTR', VarBoolean) Then
    Exit(True);

  Result := False;

  objContrato.AutIncPedAdiantamento := fRetornaPedidoAdt;

  If (blnProrrogacao) Then
  Begin
     Result := fAtualizarPedidoVenda(pgbStatus);
  End
  Else If ((Not(blnProrrogacao)) And (Not(objContrato.fVerificaPedAdtGerado)))  Then
  Begin
    Result := fGerarPedidoVenda(pgbStatus);
  End;
end;

procedure TfrmCadContratoLocEquip.pGravarItensContrato;
begin
  If blnProrrogacao Then
    pAtualizaritensContrato
  Else
    pInserirItensContrato;
end;

procedure TfrmCadContratoLocEquip.pInserirItensContrato;
var
  item: TItemContratoLocacaoEquipamentos;
begin
  objContrato.AutInc := qryTabela.FieldByName('AUTOINCREM').AsString;
  objContrato.pExcluirItens;
  objContrato.pExcluirAcessorios;
  objContrato.pLimparItens;

  cdsEqlDet.DisableControls;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof  do
    Begin
      item := ObjContrato.fAddItem;
      item.Equipamento.Codigo          := cdsEqlDet.FieldByName('EQD_SEQEQL').AsString;
      item.Equipamento.pCarregaEquipamento('', cdsEqlDet.FieldByName('EQD_SEQEQL').AsString);
      item.TipoCalculoLocacao          := fStrTipoCalculoVlLocacaoToTipoCalculoVlLocacao(cdsEqlDet.FieldByName('EQD_TIPDUR').AsString);
      Item.ValorLocacaoContratado      := cdsEqlDet.FieldByName('EQD_VALHOR').AsFloat;
      Item.ValorTotalLocacaoContratado := cdsEqlDet.FieldByName('EQD_TOTEQL').AsFloat;
      Item.PercentualDesconto          := cdsEqlDet.FieldByName('EQD_PERDES').AsFloat;
      Item.ValorLocacaoLiquido         := cdsEqlDet.FieldByName('EQD_VLLOCL').AsFloat;
      Item.ValorTotalLiquido           := cdsEqlDet.FieldByName('EQD_TOTLIQ').AsFloat;
      Item.blnValorLocacaoAlteradoManualmente :=  cdsEqlDet.FieldByName('EQD_VLRALT').AsString = 'S';
      Item.blnRecalcularVlrLocacao     := (Not Item.blnValorLocacaoAlteradoManualmente);
      Item.Quantidade                  := cdsEqlDet.FieldByName('EQD_QTDEQU').AsFloat;
      Item.fInserir;

      Item.pAddAcessorios;
      Item.fInserirAcessorios;

      cdsEqlDet.Next;
    End;

    objContrato.pCalculaTotais;
    pAtualizaTotais;
  Finally
    cdsEqlDet.EnableControls;
  End;

end;

procedure TfrmCadContratoLocEquip.pAtualizaritensContrato;
var
  qry: TUniQuery;
  sqlUpdate: String;
begin

  qry := fCriaQuery;
  qry.DisableControls;

  sqlUpdate := 'UPDATE EQLDET               ' +
               'SET                         ' +
               '  EQD_TIPDUR = :EQD_TIPDUR, ' +
               '  EQD_VALHOR = :EQD_VALHOR, ' +
               '  EQD_TOTEQL = :EQD_TOTEQL, ' +
               '  EQD_PERDES = :EQD_PERDES, ' +
               '  EQD_VLLOCL = :EQD_VLLOCL, ' +
               '  EQD_TOTLIQ = :EQD_TOTLIQ, ' +
               '  EQD_VLRALT = :EQD_VLRALT, ' +
               '  EQD_VLRAQU = :EQD_VLRAQU, ' +
               '  EQD_TOTDIA = :EQD_TOTDIA, ' +
               '  EQD_TOTHOR = :EQD_TOTHOR, ' +
               '  EQD_TOTMES = :EQD_TOTMES  ' +
               'WHERE                       ' +
               '  AUTOINCREM = :AUTOINCREM  ';
  cdsEqlDet.DisableControls;
  Try
    cdsEqlDet.First;
    While Not cdsEqlDet.Eof  do
    Begin
      qry.SQL.Clear;
      qry.SQL.Add(sqlUpdate);
      qry.ParamByName('AUTOINCREM').AsString := cdsEqlDet.FieldByName('AUTOINCREM').AsString;
      qry.ParamByName('EQD_TIPDUR').AsString := cdsEqlDet.FieldByName('EQD_TIPDUR').AsString;
      qry.ParamByName('EQD_VALHOR').AsFLoat  := cdsEqlDet.FieldByName('EQD_VALHOR').AsFloat;
      qry.ParamByName('EQD_TOTEQL').AsFLoat  := cdsEqlDet.FieldByName('EQD_TOTEQL').AsFloat;
      qry.ParamByName('EQD_PERDES').AsFLoat  := cdsEqlDet.FieldByName('EQD_PERDES').AsFloat;
      qry.ParamByName('EQD_VLLOCL').AsFLoat  := cdsEqlDet.FieldByName('EQD_VLLOCL').AsFloat;
      qry.ParamByName('EQD_VLRALT').AsString := cdsEqlDet.FieldByName('EQD_VLRALT').AsString;
      qry.ParamByName('EQD_TOTLIQ').AsFLoat  := cdsEqlDet.FieldByName('EQD_TOTLIQ').AsFloat;
      qry.ParamByName('EQD_VLRAQU').AsFloat  := cdsEqlDet.FieldByName('EQL_VLRAQU').AsFloat;
      qry.ParamByName('EQD_TOTDIA').AsFloat  := cdsEqlDet.FieldByName('EQD_TOTDIA').AsFloat;
      qry.ParamByName('EQD_TOTHOR').AsFloat  := cdsEqlDet.FieldByName('EQD_TOTHOR').AsFloat;
      qry.ParamByName('EQD_TOTMES').AsFloat  := cdsEqlDet.FieldByName('EQD_TOTMES').AsFloat;

      qry.ExecSQL;

      cdsEqlDet.Next;
    End;
  Finally
    cdsEqlDet.EnableControls;
  End;
end;

procedure TfrmCadContratoLocEquip.pHabilitaDesabilitaEdicaoContrato;
begin
  cmbStatus.Enabled := False;
  btnAdicionar.Enabled := False;
  btnCancelaItem.Enabled := False;
  btnImprimir.Enabled := True;
  pnlCondicaoPgto.Enabled := False;
  cxGridResponsaveis.Enabled := False;

  If qryTabela.State = dsInsert then
  Begin
    cmbStatus.Enabled := True;
    btnAdicionar.Enabled := True;
    btnImprimir.Enabled := False;
    pnlCondicaoPgto.Enabled := True;
    btnCancelaItem.Enabled := True;
    cxGridResponsaveis.Enabled := True;
  End
  Else If qryTabela.State = dsEdit then
  Begin
    cmbStatus.Enabled := True;
    pnlCondicaoPgto.Enabled := True;
    btnAdicionar.Enabled := True;
    btnImprimir.Enabled := False;
    btnCancelaItem.Enabled := True;
    btnCancelaItem.Enabled := True;
    cxGridResponsaveis.Enabled := True;
  End;

  btnCancelarContrato.Enabled := FobjValidaCtr.fPodeCancelarContrato;
  btnAlterar.Enabled := qryTabela.FieldByName('EQL_STATUS').AsString = 'O';
  btnExcluir.Enabled := qryTabela.FieldByName('EQL_STATUS').AsString = 'O';
  btnEncerrarContrato.Enabled := qryTabela.FieldByName('EQL_STATUS').AsString = 'A';

  pHabilitaCamposProrrogacao;
end;

procedure TfrmCadContratoLocEquip.pHabilitaTipoCalculoLocacao;
begin
  rgTipoDuracaoLocacao.Items.Clear;
  rgTipoDuracaoLocacao.Items.Add('Dias');
  rgTipoDuracaoLocacao.Items.Add('Horas');

  If (Not Assigned(objItemContrato)) Then
    Exit;

  If (fCfgSis('CTRMES', VarBoolean)) And (objItemContrato.Equipamento.ValorLocacaoMensal > 0)  Then
  Begin
    rgTipoDuracaoLocacao.Items.Add('Meses');
  End;
end;

procedure TfrmCadContratoLocEquip.pInicializaIndices;
begin
  inherited;

end;

procedure TfrmCadContratoLocEquip.pSetaStatus(strStatus: String);
begin
  cmbStatus.Items.Clear;
  If (strStatus = 'O') Or fEmptyStr(strStatus) Then
  Begin
    cmbStatus.Items.Add('ORÇAMENTO');
    cmbStatus.Items.Add('ATIVO');
  End;

  If strStatus = 'A' Then
    cmbStatus.Items.Add('ATIVO');

  If strStatus = 'F' Then
    cmbStatus.Items.Add('FATURADO');

  If strStatus = 'C' Then
    cmbStatus.Items.Add('CANCELADO');

  If strStatus = 'E' Then
    cmbStatus.Items.Add('ENCERRADO');

  If fEmptyStr(strStatus) Then
    cmbStatus.ItemIndex := -1
  Else
    cmbStatus.ItemIndex := 0;
end;

procedure TfrmCadContratoLocEquip.rgTipoDuracaoLocacaoClick(Sender: TObject);
begin
  inherited;

  If Not fValidarValorLocacao Then
  Begin
    pMensagemOk('O Equipamento não possui valor de locação para a opção selecionada');
    pSetFocus(rgTipoDuracaoLocacao);
    Exit;
  End;

  pRecalcularItem;
end;

procedure TfrmCadContratoLocEquip.rgTipoDuracaoLocacaoExit(Sender: TObject);
begin
  inherited;

  pRecalcularItem;
end;

function TfrmCadContratoLocEquip.fSenhaCancelamentoContrato: Boolean;
Var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  strNTrava : String;
begin

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTexto('CANCELAMENTO DE CONTRATO DE LOCAÇÃO', alCentro, teAmbos, '', 99);
  objLiberacao.objMsgLibera.pAddSeparador(99);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'NÚM.CONTRATO'      , 19 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'           , 33 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT. INÍCIO'        , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. TÉRMINO'       , 12 , alCentro   , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('NÚM.CONTRATO'      , edtNumCon.text                          , 19 , alEsquerda );
  objLinha.pAddColuna('CLIENTE'           , edtCodCli.Text + '-' + edtNomCli.Text   , 33 , alEsquerda );
  objLinha.pAddColuna('DT. INÍCIO'        , edtDtaIni.Text                          , 12 , alCentro   );
  objLinha.pAddColuna('DT. TÉRMINO'       , edtDtaFin.Text                          , 12 , alCentro   );
  objTabela.lstLinhas.Add(objLinha);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddTexto('NECESSÁRIO INFORMAÇÃO DE SENHA', alCentro, teAmbos, '', 99);
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTextoCaption('EMPRESA  SOLICITANTE: ', VS_strCodEmp);
  objLiberacao.objMsgLibera.pAddTextoCaption('OPERADOR SOLICITANTE: ', strLoginUsuarioLogado + ' - ' +strDescriUsuarioLogado);

  objLiberacao.strDirAce := 'CANLOCEQU';
  objLiberacao.strMsgSen := 'Cancelar locação de equipamentos.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := fMensagemLiberacao(objLiberacao, strNTrava, nil);
end;

end.
