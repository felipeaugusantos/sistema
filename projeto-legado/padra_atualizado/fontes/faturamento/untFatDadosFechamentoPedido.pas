unit untFatDadosFechamentoPedido;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls,  untFuncFat, Uni, AppEvnts, Mask, Math, UniClientDataSet,
  BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus, System.Generics.Collections,
  cxHint, TypInfo, dxScreenTip, cxClasses, untFuncFatTypes,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, cxProgressBar,
  untDadosFechamentoPedidoFrame, untDadosFechamentoPedidoTransportadoraFrame,
  untDadosFechamentoPedidoObservacoesFrame, untDigCndPagamentoFrame, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxGroupBox, untSelFaseObraFrame, untFatDigProfissionalFrame,
  untFatDigProfissionalVariosFrame, cxButtons, untGravando, Vcl.Samples.Gauges,
  untDescontoFinanceiroBoletoAdiantamentoFrame, untFatorParaFaturamentoFrame,
  untLiberacaoPedidoFrame, untTypesSistema, untHelperCitel, untCadDiversos,
  untDadosFechamentoPedidoInvoiceFrame, untNumeroDrawbackFrame,
  untClienteContaOrdemFrame, cxLabel, untPerguntasImpressaoVenda, cxStyles,
  untFuncoesGenerica;

type
  TfrmFatDadosFechamentoPedido = class(TfrmPaiSimples, IFechamentoVendaObserver)
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    btnMostraMargem: TBitBtnLocked;
    btnSimularVenda: TBitBtnLocked;
    pnlLadoEsquerdo: TPanel;
    Shape1: TShape;
    pnlLadoDireito: TPanel;
    fraDadosPedido: TfraDadosFechamentoPedidoFrame;
    fraTransportadora: TfraDadosFechamentoPedidoTransportadoraFrame;
    pnlCondicaoPagamento: TcxGroupBox;
    fraPagamento: TfraDigCndPagamento;
    pnlFaseObra: TGroupBox;
    fraFaseObra: TfraSelFaseObraFrame;
    pnlProfissional: TGroupBox;
    fraDigProfissional: TfraFatDigProfissionalFrame;
    pnlProfissionalVarios: TGroupBox;
    fraDigProfissionalVarios: TfraFatDigProfissionalVariosFrame;
    pnlEntrega: TGroupBox;
    pnlDescricaoEndereco: TPanel;
    lblDescricaoEndereco: TLabel;
    btnAlterarEntrega: TBitBtnLocked;
    chkLocalDiferente: TCheckBox;
    fraObservacoes: TfraDadosFechamentoPedidoObservacoesFrame;
    pnlTotalDocumento: TGroupBox;
    pnlInformacoesTotalVenda: TPanel;
    lblTitProdutos: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label86: TLabel;
    lblTitTotalComImpostos: TLabel;
    lblTotalProdutos: TLabel;
    lblFrete: TLabel;
    lblDespesaAcessoria: TLabel;
    lblIPI: TLabel;
    lblST: TLabel;
    lblTotalComImpostos: TLabel;
    Label1: TLabel;
    lblFCPST: TLabel;
    lblTitDescontoEspecial: TLabel;
    lblDescontoEspecial: TLabel;
    fraDescFinanBoletoAdto: TfraDescontoFinanceiroBoletoAdiantamentoFrame;
    fraFatorParaFaturamento: TfraFatorParaFaturamentoFrame;
    fraLiberacaoPedido: TfraLiberacaoPedidoFrame;
    fraInvoice: TfraDadosFechamentoPedidoInvoiceFrame;
    fraNumeroDrawbackFrame: TfraNumeroDrawbackFrame;
    lblTitCreditoCliente: TLabel;
    lblCreditoCliente: TLabel;
    fraClienteContaOrdemFrame: TfraClienteContaOrdemFrame;
    pnlImpressao: TPanel;
    lblImpressao: TcxLabel;
    cxsGrid: TcxStyleRepository;
    cxsPadrao: TcxStyle;
    btnEspRascNF: TBitBtnLocked;
    btnTotalizadorEmp: TBitBtnLocked;
    pnlCPFCNPJCliente: TPanel;
    lblCPFCNPJCliente: TLabel;
    lblTitCBS: TLabel;
    lblCBS: TLabel;
    lblTitIBS: TLabel;
    lblIBS: TLabel;
    lblTitIS: TLabel;
    lblIS: TLabel;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSimularVendaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fraDigProfissionalVariosedtCodProExit(Sender: TObject);
    procedure btnAlterarEntregaClick(Sender: TObject);
    procedure pnlCondicaoPagamentoExit(Sender: TObject);
    procedure fraPagamentochkZerTaxClick(Sender: TObject);
    procedure fraDescFinanBoletoAdtochkBolVenClick(Sender: TObject);
    procedure chkLocalDiferenteClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fraTransportadoraedtValFreExit(Sender: TObject);
    procedure fraDigProfissionalVariosedtCodProEnter(Sender: TObject);
    procedure fraDigProfissionaledtCodProEnter(Sender: TObject);
    procedure fraDigProfissionaledtCodProExit(Sender: TObject);
    procedure fraTransportadorabtnCalcularFreteClick(Sender: TObject);
    procedure fraDadosPedidoedtTipOpeExit(Sender: TObject);
    procedure lblImpressaoClick(Sender: TObject);
    procedure btnEspRascNFClick(Sender: TObject);
    procedure btnTotalizadorEmpClick(Sender: TObject);
  private
    { Private declarations }
    FPerguntasImpressaoVenda: TPerguntasImpressaoVenda;
    FSemaforo: Integer;
    FAlterouCodigoTransportadora: Boolean;
    FAlterouCodigoTransRedespacho: Boolean;
    FInfUltimoCalculoTotal: TRecInfUltimoCalculoTotal;
    FInformacaoProcessamento: String;
    FStepsProcessamento: Integer;
    FRandomSteps: Boolean;
    FArrMatItensBkp: TMatrizFechamento;
    FCdsVendaBkp: TUniClientDataSet;
    FBackupVar: TObjectBackupVar;
    frmConfirmando: TfrmGravando;
    frmCalculando: TfrmGravando;

    FblnUltimaEscolhaFretePelaFrenet   : Boolean;
    FstrCodTraFreFat: String;
    FfltValorFretePelaFrenet : Double;
    FblnEspRascDANFE: Boolean;

    FblnSomarNovosImpostosDaReformaAoValorContabil : Boolean;

    procedure pSetarAvisosTravaRemota(blnAtivar: Boolean);
    function GetStyleVGridPerguntasImpressao: TcxStyle;
    function fDocumentoSelecionado: String;
    procedure pSalvaVariaveisPagamento;
    procedure pRestauraVariaveisPagamento;
    procedure pSalvarVariaveisVenda;
    procedure pRestaurarVariaveisVenda;
    procedure pAjustarAlturaTela(Var intHeightEsq, intHeightDir: Integer);
    procedure pOnLocalDiferenteClick;
    procedure pOnAlterarEntregaClick;
    procedure pAtribuirVariaveisParaObjVenda;
    procedure pAplicarRegraFiscalEnderecoEntrega;
    procedure pCalcularTotalPedido(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False);
    function fCalcularTotalPedido(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregarEnderecoEntrega;
    procedure pAtualizaTotalizacao;
    procedure pSetarHintDescontoEspecialComDesoneracao(const AExibeHint : Boolean);
    procedure pDefinirLocalEntregaDiferente;
    procedure pCarregarEnderecoEntregaPrincipal;
    procedure pReiniciarVariaveisCondicaoPagamento();
    function fConfirmarDados(pgbProgresso: TcxProgressBar): Boolean;
    function fValidarDigitacaoCondicaoPagamento(): Boolean;
    procedure pValidarCondicaoPagamentoAoIniciarTelaFechamento;
    procedure pAtualizarInformacoesCondicaoPagamento;
    procedure pAtualizarInformacoesUltimoCalculoTotalVenda();
    function fTeveAlteracaoQueInfluenciaNoTotalVenda(): Boolean;
    function fTeveAlteracaoNaCondicaoPagamento(): Boolean;
    function fAtualizarCondicaoPagamento(pgbProgresso: TcxProgressBar): Boolean;
    procedure pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
    procedure pAtualizaFrameTransportadora;
    function fPermitirAlterarFreteFrenet : Boolean;
    function fAlteraCadDiv(const strCodDivLocal: String): String;
    procedure pConfirmDados;
    function fZerarFreteAoCancelarDigitacaoDeFrete: Boolean;
    procedure pAjustarPainelBotaoImpressao;
    procedure pAjustarPainelPerguntasImpressao;
    procedure pValidaImpressaoOrcamentoComPreco(objPerguntasImpressao : TDadosImprimePdOrSep);
    procedure pAbrirPainelPerguntas(const intHeightEsq, intHeightDir: Integer);
    procedure pSetarCaptionBotaoConfirma;
    procedure pfraPagamentoedtForPagChange(Sender: TObject);
    procedure pExibirCNPJCPFCliente;
    function fValidouIBGE: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure NotificarProgressoFechamento(AInformacao: String; AMax, AProgress: Double);
  public
    { Public declarations }
    objVenda: TFatVenda;
    qryFatGor: TUniQuery;
    blnConfirma: Boolean;
    blnDescontaCreditoAutomatico: Boolean;

    fAtualizarDadosCondicaoPagamento: function(fraDigCndPagamento: TfraDigCndPagamento; blnValidacoes: Boolean = True): Boolean of object;

    fRealizarValidacoesFechamento: function(): Boolean of object;
    fRealizaFechamentoVenda: function(): Boolean of object;
    pAlteraEnderecoEntrega: procedure(
      const blnValidarClienteSeguradora: Boolean = True) of object;
    pAfterCalcTotGer: procedure() of object;
  end;


implementation

uses untPesqAux, Data.DB, untfuncoesSimples, untConstantes, untGerarEspelhoRascunhoDANFE,
     untEnderecoEntrega, untFatMostraItensFechamento, untFuncoes, untTipoFreteAtc,
     untBloquearTela, untFrenetConsulta, untLiberacao, EditFocus, untFuncIns, untFuncIns2,
     untFatTotalizadorEmpresa, untEndPartidaConsFrete, LalaMove.View.Consulta,
     CobrancaEletronica.Lib.Facade, CobrancaEletronica.Lib.Types;

{$R *.dfm}

procedure TfrmFatDadosFechamentoPedido.FormActivate(Sender: TObject);
begin
  inherited;
  pValidarCondicaoPagamentoAoIniciarTelaFechamento;
end;

function TfrmFatDadosFechamentoPedido.fZerarFreteAoCancelarDigitacaoDeFrete: Boolean;
begin
  Result := False;

  If Not (fCfgSis('FRETRA') = FRETRA_POR_FAIXA_FATURAMENTO) Then
    Exit;

  If (blnConfirma) Then
    Exit;

  Result := True;
end;

procedure TfrmFatDadosFechamentoPedido.pAjustarPainelPerguntasImpressao;
  Const
    WIDTH_COL2: Integer = 497;
    ROW_HEIGHT: Integer = 22;
    PERCENT_HEADER : Double = 0.7;
  Var
    intBorda : Integer;
begin
  If (Not FPerguntasImpressaoVenda.Panel.Visible) Then
    Exit;

  intBorda := 2;
  If fUsaLayoutNovo Then
    intBorda := 6;

  FPerguntasImpressaoVenda.Panel.Width := WIDTH_COL2 - pnlImpressao.Width - intBorda;
  FPerguntasImpressaoVenda.Panel.Left := pnlImpressao.Left - FPerguntasImpressaoVenda.Panel.Width;
  FPerguntasImpressaoVenda.Panel.Height := FPerguntasImpressaoVenda.GetQuantidadePerguntas * ROW_HEIGHT;
  FPerguntasImpressaoVenda.Panel.Top := (pnlImpressao.Top + pnlImpressao.Height) - FPerguntasImpressaoVenda.Panel.Height - 1;
  FPerguntasImpressaoVenda.SetarTamanhoHeaderVGrid(Trunc(FPerguntasImpressaoVenda.Panel.Width * PERCENT_HEADER));
end;

procedure TfrmFatDadosFechamentoPedido.lblImpressaoClick(Sender: TObject);
begin
  If (pnlImpressao.BevelInner = bvLowered) Then
  Begin
    pnlImpressao.BevelInner := bvNone;
    FPerguntasImpressaoVenda.Panel.Visible := False;
  End
  Else
  Begin
    pnlImpressao.BevelInner := bvLowered;
    FPerguntasImpressaoVenda.Panel.Visible := True;
    FPerguntasImpressaoVenda.Panel.Parent := Self;
    pAjustarPainelPerguntasImpressao;
  End;
end;

procedure TfrmFatDadosFechamentoPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If pnlCondicaoPagamento.Visible Then
    fraPagamento.OnFormClose(Sender, Action);

  If pnlProfissional.Visible Then
    fraDigProfissional.OnFormClose(Sender, Action);

  If pnlProfissionalVarios.Visible Then
    fraDigProfissionalVarios.OnFormClose(Sender, Action);

  If (Action <> caNone) And (Not blnConfirma) And pnlCondicaoPagamento.Visible Then
  Begin
    pReiniciarVariaveisCondicaoPagamento();
    pRestauraVariaveisPagamento;
  End;

  If (fZerarFreteAoCancelarDigitacaoDeFrete) Then
  Begin
    objVenda.fltValFre := 0;
  End;
end;

function TfrmFatDadosFechamentoPedido.GetStyleVGridPerguntasImpressao: TcxStyle;
begin
  Result := Nil;
  If (cxsGrid.Count > 0) Then
    Result := TcxStyle(cxsGrid.Items[0]);
end;

procedure TfrmFatDadosFechamentoPedido.FormCreate(Sender: TObject);
begin
  inherited;
  FPerguntasImpressaoVenda := TPerguntasImpressaoVenda.Create(GetStyleVGridPerguntasImpressao,
    procedure ()
    begin
      pSetFocus(btnConfirmaDados);
    end
  );
  FSemaforo := -1;
  blnConfirma := False;
  FblnSomarNovosImpostosDaReformaAoValorContabil := fSomarNovosImpostosDaReformaAoValorContabil;
  fraObservacoes.OnFormCreate;
  fraDescFinanBoletoAdto.OnFormCreate;
  fraFatorParaFaturamento.OnFormCreate;
  fraLiberacaoPedido.OnFormCreate;
  fraTransportadora.OnFormCreate;
  fraDadosPedido.OnFormCreate;
  fraNumeroDrawbackFrame.OnFormCreate;
  fraClienteContaOrdemFrame.OnFormCreate;

  If (Screen.Width < 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;

  pnlCondicaoPagamento.Visible := fCfgSis('CNDVEN') = 'F';

  If pnlCondicaoPagamento.Visible Then
  Begin
    fraPagamento.OnFormCreate(Sender);
    fraPagamento.blnAutoHeight := False;
  End;

  pnlFaseObra.Visible := fCfgSis('FASOBR', varBoolean);

  If pnlFaseObra.Visible Then
    fraFaseObra.OnFormCreate;

  pnlProfissional.Visible := (fCfgSis('TCOPRO') <> '4') And
                             (fCfgSis('NROPRO') = '2' ) And
                             (Not fCfgSis('ALTCOM', varBoolean)) And
                             (Not fEmptyStr(fCfgSis('PROFIS')));

  pnlProfissionalVarios.Visible := (fCfgSis('TCOPRO') <> '4') And
                                   (Not fCfgSis('ALTCOM', varBoolean)) And
                                   (fCfgSis('NROPRO') = '3' );

  blnDescontaCreditoAutomatico := False;

  If pnlProfissional.Visible Then
    fraDigProfissional.OnFormCreate;

  If pnlProfissionalVarios.Visible Then
    fraDigProfissionalvarios.OnFormCreate;
end;

procedure TfrmFatDadosFechamentoPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  fraObservacoes.OnFormDestroy;
  fraDescFinanBoletoAdto.OnFormDestroy;
  fraFatorParaFaturamento.OnFormDestroy;
  fraLiberacaoPedido.OnFormDestroy;
  fraTransportadora.OnFormDestroy;
  fraFaseObra.OnFormDestroy;
  fraDigProfissional.OnFormDestroy;
  fraDigProfissionalVarios.OnFormDestroy;
  fraDadosPedido.OnFormDestroy;
  fraNumeroDrawbackFrame.OnFormDestroy;
  fraClienteContaOrdemFrame.OnFormDestroy;
  FreeAndNil(FBackupVar);
  FreeAndNil(FPerguntasImpressaoVenda);
end;

procedure TfrmFatDadosFechamentoPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
  strCodPro: String;
  intNroPro: Integer;

begin
  inherited;
  Case Key Of
    VK_F1: If (pnlEntrega.Visible) Then
             btnAlterarEntrega.Click;
    VK_F4: btnMostraMargem.Click;
    VK_F5: btnSimularVenda.Click;
    VK_F6: btnTotalizadorEmp.Click;
    VK_F10: btnConfirmaDados.Click;
  End;

  intNroPro := StrToInt(fCfgSis('NROPRO'));
  if fIsInsert(Key) and (intNroPro > 1) Then
  Begin
    if fVerificaAcessoSistema('frmCadDiversos') then
    begin

      If (intNroPro = 2) then
        strCodPro := fraDigProfissional.edtCodPro.Text
      else
        strCodPro := fraDigProfissionalVarios.edtCodPro.Text;

      if fEmptyStr(strCodPro) or
         fEmptyStr(fCampoTabela('DIV_CODDIV', 'CADDIV', ['DIV_CODDIV'], [fStrZero(strCodPro, 8)])) then
        strCodTmp := fChamaCadDiv(Key)
      else
      begin
        objVenda.strCodDiv := '';
        strCodTmp := fAlteraCadDiv(fStrZero(strCodPro, 8));
      end;

      if (not fEmptyStr(strCodTmp)) then
      begin
        If (intNroPro = 2) then
        begin
          fraDigProfissional.edtCodPro.Text := strCodTmp;
          fraDigProfissional.edtDesPro.Text := fRetNomDiversos(strCodPro);
        end
        else
          If (intNroPro = 3) then
          begin
            fraDigProfissionalVarios.edtCodPro.Text := strCodTmp;
            fraDigProfissionalVarios.edtDesPro.Text := fRetNomDiversos(strCodPro);
          end;
      end;
    end;
  end;
end;

function TfrmFatDadosFechamentoPedido.fPermitirAlterarFreteFrenet: Boolean;
  var
    objLiberacao : TLiberacao;
begin
  objLiberacao := TLiberacao.create;

  Try
    objLiberacao.Clear;
    objLiberacao.strDirAce    := 'PERALTFRETEFRENET';
    objLiberacao.strMsgSen    := 'Alterar Frete da Frenet';
    objLiberacao.strCodOpe    := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.pAddTexto('Permitir alterar o frete para um valor menor que o escolhido pela Frenet (frete pela Frenet R$'+
    FloatToStr(fFormataFloat(FfltValorFretePelaFrenet,2))+').');

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmFatDadosFechamentoPedido.fraDadosPedidoedtTipOpeExit(
  Sender: TObject);
begin
  inherited;
  fraDadosPedido.edtTipOpeExit(Sender);
  If (fraDadosPedido.edtTipOpe.Text = 'C') And
     (fCfgSis('EXICOR', varBoolean)) And
     (fCfgSis('NVORPD', varBoolean)) Then
  Begin
    fraClienteContaOrdemFrame.Visible := True;
    Self.ClientHeight := Self.ClientHeight +
                         fRetornaSomaAlturaDosPaineisVisiveisEm(fraClienteContaOrdemFrame.pnlFundo);
  End
  Else
  Begin

    objVenda.strCliCEO := '';
    If (fraClienteContaOrdemFrame.Visible) Then
    Begin
      Self.ClientHeight := Self.ClientHeight -
                           fRetornaSomaAlturaDosPaineisVisiveisEm(fraClienteContaOrdemFrame.pnlFundo);

      fraClienteContaOrdemFrame.Visible := False;
    End;

  End;
end;

procedure TfrmFatDadosFechamentoPedido.fraDescFinanBoletoAdtochkBolVenClick(
  Sender: TObject);
begin
  inherited;
  fraDescFinanBoletoAdto.chkBolVenClick(Sender);
  fraDadosPedido.blnEmitirBoletosAdtFecPD := fraDescFinanBoletoAdto.chkBolVen.Checked;
end;

procedure TfrmFatDadosFechamentoPedido.fraDigProfissionaledtCodProEnter(
  Sender: TObject);
begin
  inherited;
  if fEmptyStr(fraDigProfissional.edtCodPro.Text) then
    pnlInfo.Caption := 'Pressione INSERT para inserir um novo cadastro.';
end;

procedure TfrmFatDadosFechamentoPedido.fraDigProfissionaledtCodProExit(
  Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmFatDadosFechamentoPedido.fraDigProfissionalVariosedtCodProEnter(
  Sender: TObject);
begin
  inherited;
  if fEmptyStr(fraDigProfissionalVarios.edtCodPro.Text) then
    pnlInfo.Caption := 'Pressione INSERT para inserir um novo cadastro.';
end;

procedure TfrmFatDadosFechamentoPedido.fraDigProfissionalVariosedtCodProExit(
  Sender: TObject);
begin
  inherited;
  fraDigProfissionalVarios.edtCodProExit(Sender);
  if fEmptyStr(fraDigProfissionalVarios.edtCodPro.Text) Then
    SelectNext(fraDigProfissionalVarios.dbgItens, True, True);

  pnlInfo.Caption := '';
end;

procedure TfrmFatDadosFechamentoPedido.fraPagamentochkZerTaxClick(
  Sender: TObject);
begin
  inherited;
  fraPagamento.chkZerTaxClick(Sender);
  If fraPagamento.chkZerTax.Focused Then
    SelectNext(fraPagamento.chkZerTax, True, True);
end;

procedure TfrmFatDadosFechamentoPedido.pfraPagamentoedtForPagChange(
  Sender: TObject);
begin
  inherited;

  If Not fraDescFinanBoletoAdto.Visible Then
    Exit;

  If fCfgSis('SUGBOL') = '3' Then
    fraDescFinanBoletoAdto.chkBolVen.Checked := False;

  If fraDescFinanBoletoAdto.fEhPedidoParaEmitirBoletoParaTodosVencimentos(fraPagamento.edtForPag.Text, objVenda.strNumOrc) Then
    fraDescFinanBoletoAdto.chkBolVen.Checked := fCfgSis('SUGBOL') = '1';

  If fraDescFinanBoletoAdto.fEhOrcamentoFechandoEmPedidoParaEmitirBoletoParaTodosVencimentos(fraPagamento.edtForPag.Text, objVenda.strOpcDoc, objVenda.strEspDoc) Then
     fraDescFinanBoletoAdto.chkBolVen.Checked := fCfgSis('SUGBOL') = '1';

  If fraDescFinanBoletoAdto.fUtilizaDefinicaoDeImpressaoDeBoletoNaCondicaoDePagamento(fraPagamento.edtForPag.Text, objVenda.strOpcDoc, objVenda.strEspDoc, objVenda.strNumOrc) Then
    fraDescFinanBoletoAdto.chkBolVen.Checked := IIF(fCampoTabela('CND_EMIBOL', 'CADCND', ['CND_CODIGO'], [fraPagamento.edtCodCnd.Text], False) = 1, True, False);
end;

procedure TfrmFatDadosFechamentoPedido.fraTransportadorabtnCalcularFreteClick(
  Sender: TObject);
  var
    frmFrenetConsulta : TfrmFrenetConsulta;
    frmLalaMoveConsulta : TfrmLalaMoveConsulta;
    LintIdx           : Integer;
    LEndPartida       : TRecEnderecoPartida;
begin
  If (fCfgSis('USALAL', varString) = 'S') Then
  Begin
    pCriarFormularios(TfrmLalaMoveConsulta, frmLalaMoveConsulta);
    Try
      frmLalaMoveConsulta.FatVenda := objVenda;
      frmLalaMoveConsulta.ShowModal;
      If (frmLalaMoveConsulta.blnConfirmou) Then
      Begin
        FstrCodTraFreFat := fraTransportadora.edtCodTra.Text;
        fValidaCampos(fraTransportadora.edtCodTra);
        FblnUltimaEscolhaFretePelaFrenet := True;
        FfltValorFretePelaFrenet := frmLalaMoveConsulta.fltValorDoFrete;
        fraTransportadora.edtValFre.Text := FloatToStr(frmLalaMoveConsulta.fltValorDoFrete);
        fraTransportadoraedtValFreExit(fraTransportadora.edtValFre);
        fraTransportadora.cmbTipFre.ItemIndex := 0;
        SelectNext(ActiveControl, True, True);
      End
      Else
        FblnUltimaEscolhaFretePelaFrenet := (Not fEmptyStr(objVenda.strQuotationIDLalaMove));
    Finally
      pFreeAndNil(frmLalaMoveConsulta);
    End;
    Exit;
  End;

  Try
    FillChar(LEndPartida, SizeOf(LEndPartida), #0);

    pCriarFormularios(TfrmFrenetConsulta, frmFrenetConsulta);
    frmFrenetConsulta.fatVenda  := objVenda;
    frmFrenetConsulta.strCodRot := fraTransportadora.edtCodRot.Text;

    If fCfgSis('ENPAFR', varBoolean) Then
    Begin
      If Not fSelecionaEnderecoPartida(LEndPartida) Then
        Exit;

      frmFrenetConsulta.recEndPartida := LEndPartida;
    End;

    frmFrenetConsulta.ShowModal;

    if frmFrenetConsulta.ModalResult = mrOK then
    Begin
      FblnUltimaEscolhaFretePelaFrenet := True;
      FfltValorFretePelaFrenet         := frmFrenetConsulta.fltValorDoFrete;

      fraTransportadora.edtCodTra.Text := frmFrenetConsulta.strCodigoTransportadora;
      FstrCodTraFreFat := frmFrenetConsulta.strCodigoTransportadora;
      fValidaCampos(fraTransportadora.edtCodTra);

      fraTransportadora.edtValFre.Text := FloatToStr(frmFrenetConsulta.fltValorDoFrete);
      fraTransportadoraedtValFreExit(fraTransportadora.edtValFre);

      for LintIdx := 1 to 5 do
      Begin
        if Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx)) <> Nil Then
          if (fEmptyStr(TEditFocus(Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx))).Text)) or
             (POS('DIAS APÓS A LIBERAÇÃO DO PEDIDO', TEditFocus(Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx))).Text) > 0) then
          Begin
            TEditFocus(Self.FindComponent('fraObservacoes').FindComponent('edtMens0'+intToStr(LintIdx))).Text := frmFrenetConsulta.strMensagemDoFrete;
            Break;
          End;
      End;

      objVenda.strAutIncEndPartida := LEndPartida.strAutoincrem;

      fraTransportadora.cmbTipFre.ItemIndex := 0;
    End
    Else
    Begin
      FblnUltimaEscolhaFretePelaFrenet := False;
    End;

  Finally
    pFreeAndNil(frmFrenetConsulta);
  End;
end;

procedure TfrmFatDadosFechamentoPedido.fraTransportadoraedtValFreExit(Sender: TObject);
begin
  inherited;

  if (FblnUltimaEscolhaFretePelaFrenet) then
  Begin
    if fFormataFloat(StrToFloat(fraTransportadora.edtValFre.Text),2) < fFormataFloat(FfltValorFretePelaFrenet,2) then
    Begin
      if not fPermitirAlterarFreteFrenet then
      Begin
        fraTransportadora.edtValFre.Text := FloatToStr(FfltValorFretePelaFrenet);
        Abort;
      End;
    End;
  End;
end;

function TfrmFatDadosFechamentoPedido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := (inherited fValidaCampos(Sender, blnBuscaPorChave));

  If Result And pnlCondicaoPagamento.Visible Then
    Result := fraPagamento.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And pnlFaseObra.Visible Then
    Result := fraFaseObra.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And pnlProfissional.Visible Then
    Result := fraDigProfissional.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And pnlProfissionalVarios.Visible Then
    Result := fraDigProfissionalVarios.fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
    Result := fraObservacoes.fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
    Result := fraTransportadora.fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
    Result := fraDadosPedido.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And fraDescFinanBoletoAdto.Visible Then
    Result := fraDescFinanBoletoAdto.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And fraFatorParaFaturamento.Visible Then
    Result := fraFatorParaFaturamento.fValidaCampos(Sender, blnBuscaPorChave);

  If Result And fraLiberacaoPedido.Visible Then
    Result := fraLiberacaoPedido.fValidaCampos(Sender, blnBuscaPorChave);

  If fraInvoice.Visible Then
    Result := Result And fraInvoice.fValidaCampos(Sender, blnBuscaPorChave);

  If fraClienteContaOrdemFrame.Visible Then
    Result := Result And fraClienteContaOrdemFrame.fValidaCampos(Sender, blnBuscaPorChave);

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmFatDadosFechamentoPedido.fValidarDigitacaoCondicaoPagamento: Boolean;
  Var
    intHeightEsq: Integer;
    intHeightDir: Integer;
    frmConfirmandoCondPag: TfrmGravando;
begin
  If Not pnlCondicaoPagamento.Visible Then
    Exit(True);

  If fraPagamento.blnConfirma And
    Not fTeveAlteracaoNaCondicaoPagamento Then
      Exit(True);

  pReiniciarVariaveisCondicaoPagamento();
  pAtribuirVariaveisParaObjVenda;

  pCriarFormularios(TfrmGravando, frmConfirmandoCondPag);
  Try
    frmConfirmandoCondPag.lblGravando.Caption := 'Aguarde, Validando dados de pagamento ...';
    frmConfirmandoCondPag.fExecutarAcao := fAtualizarCondicaoPagamento;
    frmConfirmandoCondPag.ShowModal;
    fraPagamento.blnConfirma := frmConfirmandoCondPag.blnConfirma;

    If Not fraPagamento.blnConfirma Then
      Exit(False);

    pAtualizarInformacoesUltimoCalculoTotalVenda();

    pAtualizaTotalizacao;

    fraDadosPedido.OnAlterouCondicaoPagamento;
    fraLiberacaoPedido.OnAlterouCondicaoPagamento;
    pAjustarAlturaTela(intHeightEsq, intHeightDir);
    pAjustarPainelBotaoImpressao;
    pAjustarPainelPerguntasImpressao;

    Result := True;
  Finally
    pFreeAndNil(frmConfirmandoCondPag);
  End;
end;

function TfrmFatDadosFechamentoPedido.fValidouIBGE: Boolean;
var
  strCodCid: String;
begin
  strCodCid := fCampoTabela('ETC_CIDENT', 'ENTCLI', ['AUTOINCREM'], [objVenda.strAutEnt]);
  Result := fValidaCodigoIBGE(strCodCid);
end;

function TfrmFatDadosFechamentoPedido.fAlteraCadDiv(
  const strCodDivLocal: String): String;
var
  frmCadDiversos: TfrmCadDiversos;
begin
  If Not fVerificaAcessoSistema('frmCadDiversos') Then
    Exit;

  pCriarFormularios(TfrmCadDiversos, frmCadDiversos);
  Try
    Try
      frmCadDiversos.strCodDiversosIniciarCadastro := strCodDivLocal;
      frmCadDiversos.ShowModal;
      Result := frmCadDiversos.strUltimoCodigo;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmCadDiversos);
  End;
end;

function TfrmFatDadosFechamentoPedido.fAtualizarCondicaoPagamento(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  pgbProgresso.Visible := False;

  If Assigned(frmConfirmando) Then
    frmConfirmando.Repaint;

  Result := fraPagamento.fConfirmaDados And fAtualizarDadosCondicaoPagamento(fraPagamento);
end;

procedure TfrmFatDadosFechamentoPedido.NotificarProgressoFechamento(
  AInformacao: String; AMax, AProgress: Double);
begin
  If Not Assigned(frmConfirmando) Then
    Exit;

  frmConfirmando.pgbStatus.Properties.Max := AMax;
  frmConfirmando.lblGravando.Caption      := AInformacao;
  frmConfirmando.pgbStatus.Position       := AProgress;
  frmConfirmando.pgbStatus.Visible        := AProgress > 0;

  pProcessMessages;
end;

procedure TfrmFatDadosFechamentoPedido.FormShow(Sender: TObject);
  Var
    intHeightEsq: Integer;
    intHeightDir: Integer;
begin
  FArrMatItensBkp   := objVenda.arrMatItens;
  FCdsVendaBkp      := fCriaTemporaria(Self);
  FCdsVendaBkp.Data := cdsVenda.Data;
  FBackupVar        := TObjectBackupVar.Create(objVenda);
  FblnEspRascDANFE  := False;

  fraDescFinanBoletoAdto.objVenda := objVenda;
  fraDescFinanBoletoAdto.pCalcularTotalPedido := Self.pCalcularTotalPedido;

  fraPagamento.edtForPag.OnChange := pfraPagamentoedtForPagChange;

  fraFatorParaFaturamento.objVenda := objVenda;
  fraLiberacaoPedido.objVenda := objVenda;
  fraFaseObra.objVenda := objVenda;
  fraObservacoes.objVenda := objVenda;

  fraDigProfissional.objVenda := objVenda;
  fraDigProfissionalVarios.objVenda := objVenda;

  fraTransportadora.objVenda := objVenda;
  fraTransportadora.qryDadosPedido := qryFatGor;

  fraNumeroDrawbackFrame.objVenda := objVenda;
  fraNumeroDrawbackFrame.onConfirm := pConfirmDados;

  fraDadosPedido.objVenda := objVenda;
  fraDadosPedido.qryDadosPedido := qryFatGor;
  fraDadosPedido.pCalcularTotalPedido := Self.pCalcularTotalPedido;
  fraDadosPedido.pCarregarDespesasAcessorias := fraTransportadora.pCarregarDespesasAcessorias;
  fraDadosPedido.pHabilitarFatorParaFaturamento := fraFatorParaFaturamento.pHabilitarFatorParaFaturamento;
  fraDadosPedido.pHabilitarLiberacaoPedido := fraLiberacaoPedido.pHabilitarLiberacaoPedido;

  objVenda.blnPediuEnderecoEntrega := True;
  FPerguntasImpressaoVenda.ExibePerguntaSeparacaoPedido := objVenda.fPoderaImprimirSeparacaoDePedido;
  FPerguntasImpressaoVenda.MontarPerguntas(fDocumentoSelecionado);

  pCarregarEnderecoEntrega;

  If (Not fEmptyStr(objVenda.strNumOrc)) Then
    objVenda.strCodTra := objVenda.fVerificaTranspDoctoDifEndEntrega;

  fraTransportadora.strCodTra := objVenda.strCodTra;

  If pnlCondicaoPagamento.Visible Then
  Begin
    fraPagamento.blnEstaNaNovaTelaDeFechamento := True;
    fraPagamento.OnFormShow(Sender);

    if fUsaPrevisaoDeEntregaNoFinal(objVenda.strOpcDoc) then
      fraPagamento.mskPreVis.Text := DateToStr(IIF(objVenda.dtaPreVis = 0,
        fAcertaDataParaDiaUteis(VS_Date, fCfgSis('DIASPD', varInteger)), objVenda.dtaPreVis));
  End;

  If pnlFaseObra.Visible Then
    fraFaseObra.OnFormShow;

  If pnlProfissional.Visible Then
    fraDigProfissional.OnFormShow;

  If pnlProfissionalVarios.Visible Then
    fraDigProfissionalVarios.OnFormShow;

  fraObservacoes.OnFormShow;
  fraTransportadora.OnFormShow;
  fraDescFinanBoletoAdto.OnFormShow;
  fraDadosPedido.OnFormShow;
  fraFatorParaFaturamento.OnFormShow;
  fraLiberacaoPedido.OnFormShow;
  fraNumeroDrawbackFrame.OnFormShow;

  If (fFormataFloat(fraTransportadora.fltVlrDesAce, 2) <> fFormataFloat(objVenda.fltDesAce, 2)) Then
  Begin
    If fMensagem('', 'O valor da Despesa Acessória sofreu alteração.'+#13+
                     'Deseja carregar o novo valor ?', ['', '']) = 1 Then
    Begin
      fraTransportadora.edtDesAce.Text := FormatFloat('#,##0.00', fraTransportadora.fltVlrDesAce);
    End;
  End;

  btnSimularVenda.Visible := fCfgSis('SOLFNE', varBoolean);

  btnMostraMargem.Visible := (Pos(objVenda.strOpcDoc, 'VN_OR_PD_') > 0) And
                              fVerificaAcessoSistema('VIMLF4');

  btnTotalizadorEmp.Visible := fCfgSis('EMPFAT', varBoolean);

  btnEspRascNF.Visible := False;

  if fVerificaAcessoSistema('VESPPD', strLoginUsuarioLogado) then
    btnEspRascNF.Visible := True;

  If pnlCondicaoPagamento.Visible Then
    If Not fraPagamento.pnlPrevisao.Visible Then
      pnlCondicaoPagamento.Height := pnlCondicaoPagamento.Height -
        fraPagamento.pnlPrevisao.Height;

  fraInvoice.Visible := fCfgSis('USAVOI', varBoolean) And ((objVenda.strCliEst = 'EX') Or (objVenda.fTrocaUFEndEntrega = 'EX'));

  If fraInvoice.Visible Then
  Begin
    fraInvoice.objVenda := objVenda;
    fraInvoice.OnFormShow;
  End;

  fraClienteContaOrdemFrame.objVenda := objVenda;
  fraClienteContaOrdemFrame.OnFormShow;

  pAjustarAlturaTela(intHeightEsq, intHeightDir);
  pAjustarPainelBotaoImpressao;
  pAbrirPainelPerguntas(intHeightEsq, intHeightDir);
  pSetarCaptionBotaoConfirma;

  fraTransportadora.btnCalcularFrete.Visible := (fCfgSis('FREUSA', varBoolean)) or
                                                (fCfgSis('QLPUSA', varBoolean)) or
                                                (fCfgSis('ITPUTI', varBoolean)) or
                                                (fCfgSis('USALAL', varBoolean));

  FblnUltimaEscolhaFretePelaFrenet   := False;
  FfltValorFretePelaFrenet           := 0.00;
  pExibirCNPJCPFCliente;

  FstrCodTraFreFat := EmptyStr;

  if (fEmptyStr(objVenda.strFreTipApi)) or
     (objVenda.strFreTipApi = 'MANUAL') then
    objVenda.strFreTipApi := 'MANUAL'
  else
  begin
    FstrCodTraFreFat := objVenda.strCodTra;
    FblnUltimaEscolhaFretePelaFrenet := True;
    FfltValorFretePelaFrenet         := objVenda.fltVlrFreFat;
  end;
end;

procedure TfrmFatDadosFechamentoPedido.pExibirCNPJCPFCliente;
begin
  lblCPFCNPJCliente.Caption := 'CNPJ/CPF: ' + fFormataCpfCgc(objVenda.strCliCgc, fSetaPais);
  pnlCPFCNPJCliente.Visible := fCfgSis('NVORPD', varBoolean) And fCfgSis('EXIDCF', varBoolean);

  pnlDescricaoEndereco.Align := alTop;
  pnlDescricaoEndereco.Align := alBottom;
end;

procedure TfrmFatDadosFechamentoPedido.btnSimularVendaClick(Sender: TObject);
begin
  inherited;
  If Not btnSimularVenda.Visible Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  TfrmFatMostraItensFechamento.pSimularFechamentoVenda(objVenda,
    fStrToFloat(fraTransportadora.edtValFre.Text),
    fStrToFloat(fraTransportadora.edtDesAce.Text),
    fraDadosPedido.edtTipFat.Text, fraDadosPedido.edtTipOpe.Text,
    fStrToFloat(fraFatorParaFaturamento.edtFatCal.Text),
    fraFatorParaFaturamento.edtTipoFator.Text);
end;

procedure TfrmFatDadosFechamentoPedido.btnTotalizadorEmpClick(Sender: TObject);
  Var
    frmFatTotalizadorEmpresa: TfrmFatTotalizadorEmpresa;
begin
  inherited;

  If Not btnTotalizadorEmp.Visible Then
    Exit;

  pCriarFormularios(TfrmFatTotalizadorEmpresa, frmFatTotalizadorEmpresa);
  Try
    frmFatTotalizadorEmpresa.cdsDados.Data := cdsVenda.Data;
    frmFatTotalizadorEmpresa.ShowModal;
  Finally
    pFreeAndNil(frmFatTotalizadorEmpresa);
  End;
end;

procedure TfrmFatDadosFechamentoPedido.chkLocalDiferenteClick(Sender: TObject);
begin
  inherited;
  TfrmBloquearTela.fExecutarOperacao(pOnLocalDiferenteClick);
end;

procedure TfrmFatDadosFechamentoPedido.btnAlterarEntregaClick(Sender: TObject);
begin
  inherited;

  if pnlProfissional.Visible then
    objVenda.fInsereEnderecoProfissionalComoEndEnt(fraDigProfissional.edtCodPro.Text)
  else if pnlProfissionalVarios.Visible then
    objVenda.fInsereEnderecoProfissionalComoEndEnt('', fraDigProfissionalVarios.cdsGrid);

  TfrmBloquearTela.fExecutarOperacao(pOnAlterarEntregaClick);
end;

procedure TfrmFatDadosFechamentoPedido.pAtribuirVariaveisParaObjVenda;
begin
  If fraTransportadora.Visible Then
  Begin
    objVenda.fltValFre := fStrToFloat(fraTransportadora.edtValFre.Text);
    objVenda.fltDesAce := fStrToFloat(fraTransportadora.edtDesAce.Text);
  End;

  If fraDadosPedido.pnlBombeamento.Visible Then
  Begin
    objVenda.fltTotBom := fStrToFloat(fraDadosPedido.edtTotBom.Text);
  End;

  objVenda.strTipOpe := fraDadosPedido.edtTipOpe.Text;
  objVenda.strTipPed := IIF(fCfgSis('TPDCEX', varInteger) = 2, '', fraDadosPedido.edtTipFat.Text);
end;

procedure TfrmFatDadosFechamentoPedido.pAtualizaFrameTransportadora;
begin
  FAlterouCodigoTransportadora  := False;
  FAlterouCodigoTransRedespacho := False;

  fraTransportadora.cmbTipFre.ItemIndex := fraTransportadora.cmbTipFre.Items.IndexOf(fDescricaoFrete(IfThen(Not objVenda.fPermitirFreteNoFaturamento, '9', objVenda.strTipFre)));
  fraTransportadora.cmbTipFre.Enabled   := objVenda.fPermitirFreteNoFaturamento;

  If (objVenda.strCodTra <> fraTransportadora.edtCodTra.Text) Then
  Begin
    fraTransportadora.edtCodTra.Text := objVenda.strCodTra;
    FAlterouCodigoTransportadora := True;
  End;

  FAlterouCodigoTransRedespacho := (objVenda.strTraRdp <> fraTransportadora.edtTraRedCod.Text);
  If FAlterouCodigoTransRedespacho Then
    fraTransportadora.edtTraRedCod.Text := objVenda.strTraRdp;

  If fraTransportadora.Visible Then
    fraTransportadora.pCarregarDespesasAcessoriasImpostoDeImportacao;
end;

procedure TfrmFatDadosFechamentoPedido.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDadosFechamentoPedido.btnConfirmaDadosClick(Sender: TObject);
begin
  if not fValidouIBGE then
    Exit;

  pSalvarVariaveisVenda;
  Try
    pSetarAvisosTravaRemota(True);

    if FstrCodTraFreFat <> fraTransportadora.edtCodTra.Text then
    begin
      objVenda.strQlpPlaVei := EmptyStr;
      objVenda.fltQlpDist   := 0;
      objVenda.fltQlpVlrCmb := 0;
      objVenda.fltQlpVlrPed := 0;
      objVenda.intCodtab    := 0;
      objVenda.strCotid_    := EmptyStr;
      objVenda.strFreTipApi := 'MANUAL';
      FblnUltimaEscolhaFretePelaFrenet := False;
    end;

    pCriarFormularios(TfrmGravando, frmConfirmando);
    Try
      frmConfirmando.lblGravando.Caption := MSG_AGUARDE_REALIZANDO_FECHAMENTO_VENDA;
      frmConfirmando.fExecutarAcao := fConfirmarDados;
      frmConfirmando.ShowModal;
      blnConfirma := frmConfirmando.blnConfirma;
    Finally
      pFreeAndNil(frmConfirmando);
    End;
  Finally
    pSetarAvisosTravaRemota(False);

    If not FblnEspRascDANFE Then
    Begin
      If blnConfirma Then
        Self.Close
      Else
        pRestaurarVariaveisVenda;
     End;
  End;
end;

function TfrmFatDadosFechamentoPedido.fConfirmarDados(pgbProgresso: TcxProgressBar): Boolean;
begin
  inherited;
  Result := False;

  pgbProgresso.Visible := False;

  fraTransportadora.blnExigeCodRota := fraDadosPedido.edtFinaliza.Text = 'N';

  If Assigned(frmConfirmando) Then
    frmConfirmando.Repaint;

  If Not fVerificaCampos Then
    Exit;

  If Not fValidarDigitacaoCondicaoPagamento() Then
  Begin
    SelectFirst;
    Exit;
  End;

  If ((objVenda.strEspDoc = 'PD') Or
      (objVenda.strOpcDoc = 'PD')) And
     (pnlCondicaoPagamento.Visible) Then
  Begin
    TFacadeCobrancaEletronica.fValidaCadastroClienteCobrancaEletronica(
             objVenda.strCodCli, objVenda.strCodCnd, tcPagarMe);
  End;

  If pnlFaseObra.Visible Then
    If Not fraFaseObra.fConfirmaDados Then
      Exit;

  If pnlProfissional.Visible Then
    If Not fraDigProfissional.fConfirmaDados Then
      Exit;

  If pnlProfissionalVarios.Visible Then
    If Not fraDigProfissionalVarios.fConfirmaDados Then
      Exit;

  If Not fraObservacoes.fConfirmaDados Then
    Exit;

  If fraDescFinanBoletoAdto.Visible Then
    If Not fraDescFinanBoletoAdto.fConfirmaDados Then
      Exit;

  If fraFatorParaFaturamento.Visible Then
    If Not fraFatorParaFaturamento.fConfirmaDados Then
      Exit;

  If fraLiberacaoPedido.Visible Then
    If Not fraLiberacaoPedido.fConfirmaDados Then
      Exit;

  If Not fraTransportadora.fConfirmaDados Then
    Exit;

  If fraInvoice.Visible Then
    If Not fraInvoice.fConfirmaDados Then
      Exit;

  If Not fraDadosPedido.fConfirmaDados Then
    Exit;

  If fraClienteContaOrdemFrame.Visible Then
    If Not fraClienteContaOrdemFrame.fConfirmaDados Then
      Exit;

  If Not fRealizarValidacoesFechamento() Then
    Exit;

  If FblnEspRascDANFE Then
  Begin
    Result := True;
    Exit;
  End;

  If (Assigned(objVenda)) Then
  Begin
    FPerguntasImpressaoVenda.SetarResultadoPerguntas(fDocumentoSelecionado, objVenda.objPerguntasImpressaoDocumento, objVenda.objPerguntasImpressaoSeparacao);
    pValidaImpressaoOrcamentoComPreco(objVenda.objPerguntasImpressaoDocumento);
  End;

  If Not fRealizaFechamentoVenda() Then
    Exit;

  Result := True;
end;

function TfrmFatDadosFechamentoPedido.fDocumentoSelecionado: String;
begin
  If fEmptyStr(objVenda.strEspDoc) Then
    Result := objVenda.strOpcDoc
  Else
    Result := objVenda.strEspDoc;
end;

function TfrmFatDadosFechamentoPedido.fTeveAlteracaoNaCondicaoPagamento: Boolean;
begin
  Result := True;
  If (FInfUltimoCalculoTotal.strCodCnd = fraPagamento.edtCodCnd.Text) And
     (FInfUltimoCalculoTotal.strConPag = fraPagamento.mskCndPag.Text) And
     (FInfUltimoCalculoTotal.strCodFpg = fraPagamento.edtForPag.Text) And
     (FInfUltimoCalculoTotal.blnZerTax = fraPagamento.chkZerTax.Checked) Then
  Begin
    Result := False;
  End;
end;

function TfrmFatDadosFechamentoPedido.fTeveAlteracaoQueInfluenciaNoTotalVenda: Boolean;
begin
  Result := True;
  If (FInfUltimoCalculoTotal.fltValFre = objVenda.fltValFre) And
     (FInfUltimoCalculoTotal.fltDesAce = objVenda.fltDesAce) And
     (FInfUltimoCalculoTotal.strTipOpe = objVenda.strTipOpe) And
     (FInfUltimoCalculoTotal.strTipPed = objVenda.strTipPed) And
     (FInfUltimoCalculoTotal.fltTotBom = objVenda.fltTotBom) And
     (FInfUltimoCalculoTotal.strUfTrib = objVenda.fUFsDestTribItems) Then
  Begin
    Result := False;
  End;
end;

procedure TfrmFatDadosFechamentoPedido.btnMostraMargemClick(Sender: TObject);
begin
  inherited;
  If (Not btnMostraMargem.Enabled) Then
    Exit;

  If (Not btnMostraMargem.Visible) Then
    Exit;

  Try
    If InterlockedIncrement(FSemaforo) = 0 Then
    Begin
      objVenda.strCodTra := fraTransportadora.edtCodTra.Text;
      objVenda.fltValFre := fStrToFloat(fraTransportadora.edtValFre.Text);
      fraTransportadora.pCalculaFreteSugestao;
      objVenda.pMostraMargemComFrete;
      pSetFocus(ActiveControl);
    End;
  Finally
    InterlockedDecrement(FSemaforo);
  End;
end;

procedure TfrmFatDadosFechamentoPedido.pCalcularTotalPedido(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False);
begin
  If Not AForcarCalculo Then
    If fCheckParent(ActiveControl, fraPagamento) Then
      Exit;

  pAtribuirVariaveisParaObjVenda;

  If Not AForcarCalculo Then
    If Not fTeveAlteracaoQueInfluenciaNoTotalVenda Then
      Exit;

  If AInformacao.IsEmpty Then
    AInformacao := 'Calculando total dos produto(s) (%s)';

  FInformacaoProcessamento := 'Aguarde, ' + AInformacao + ' ...';

  FStepsProcessamento := ASteps;
  FRandomSteps        := ASteps = 0;

  If FRandomSteps Then
    FStepsProcessamento := 1;

  pCriarFormularios(TfrmGravando, frmCalculando);
  Try
    frmCalculando.lblGravando.Caption := AInformacao;
    frmCalculando.fExecutarAcao := fCalcularTotalPedido;
    frmCalculando.ShowModal;
  Finally
    pFreeAndNil(frmCalculando);
  End;
end;

function TfrmFatDadosFechamentoPedido.fCalcularTotalPedido(pgbProgresso: TcxProgressBar): Boolean;
begin
  pAtualizarInformacoesCondicaoPagamento;

  objVenda.pCalculaTotGer(False, True, pOnProcessaItem);

  pAtualizarInformacoesUltimoCalculoTotalVenda();

  pAtualizaTotalizacao;

  If Assigned(pAfterCalcTotGer) Then
    pAfterCalcTotGer;

  Result := True;
end;

procedure TfrmFatDadosFechamentoPedido.pCarregarEnderecoEntrega;
begin
  chkLocalDiferente.Enabled := (Not fClienteConsumidor(objVenda.strCodCli, False, True)) And
                               (objVenda.fTemItensEntrega);

  pDefinirLocalEntregaDiferente;

  If Not chkLocalDiferente.Enabled Then
    chkLocalDiferente.Checked := False;

  If Not chkLocalDiferente.Checked Then
    pCarregarEnderecoEntregaPrincipal;
end;

procedure TfrmFatDadosFechamentoPedido.pCarregarEnderecoEntregaPrincipal;
begin
  If objVenda.strAutEnt <> fRetEnderecoPadraoFat(objVenda.strCodCli) Then
  Begin
    objVenda.strAutEnt := fRetEnderecoPadraoFat(objVenda.strCodCli);
    If Not fEmptyStr(objVenda.strAutEnt) Then
    Begin
      objVenda.objEndEnt.pRetEnderecoEntrega(objVenda.strAutEnt, objVenda.strCodCli);
      objVenda.objEndEnt.recEndere.blnAltera := True;
      objVenda.pEnderecoToFatVenda;
    End
    Else
    Begin
      FillChar(objVenda.objEndEnt.recEndere, SizeOf(objVenda.objEndEnt.recEndere), #0);
      FillChar(objVenda.enderecoEntrega, SizeOf(objVenda.enderecoEntrega), #0);
    End;
  End;
end;

procedure TfrmFatDadosFechamentoPedido.pConfirmDados;
begin
  pSetFocus(btnConfirmaDados);
end;

procedure TfrmFatDadosFechamentoPedido.pDefinirLocalEntregaDiferente;
begin
  chkLocalDiferente.Checked :=
    IIF(fCampoTabela('ETC_ENDFAT', 'ENTCLI', ['AUTOINCREM'], [objVenda.strAutEnt]) = 'S', False, True)
      And Not fEmptyStr(objVenda.strAutEnt);

  lblDescricaoEndereco.Caption := 'Endereço de Entrega: ' + objVenda.fDescricaoEnderecoEntrega;
end;

procedure TfrmFatDadosFechamentoPedido.pAtualizarInformacoesCondicaoPagamento;
begin
  If pnlCondicaoPagamento.Visible Then
  Begin
    objVenda.pAtualizaInformacoesCondPagamento;
    objVenda.pCalculaTaxVpr;
    objVenda.blnTaxVpr := True;
    objVenda.blnDeCndF := True;
    If fraPagamento.chkZerTax.Checked Then
    Begin
      objVenda.fltTaxVpr := 0;
      objVenda.blnTaxVpr := False;
    End;
  End;
end;

procedure TfrmFatDadosFechamentoPedido.pAtualizarInformacoesUltimoCalculoTotalVenda;
begin
  //Condicao de pagamento
  If pnlCondicaoPagamento.Visible Then
  Begin
    FInfUltimoCalculoTotal.strCodCnd := fraPagamento.edtCodCnd.Text;
    FInfUltimoCalculoTotal.strConPag := fraPagamento.mskCndPag.Text;
    FInfUltimoCalculoTotal.strCodFpg := fraPagamento.edtForPag.Text;
    FInfUltimoCalculoTotal.blnZerTax := fraPagamento.chkZerTax.Checked;
  End;
  //Dados da tela
  FInfUltimoCalculoTotal.fltValFre := objVenda.fltValFre;
  FInfUltimoCalculoTotal.fltDesAce := objVenda.fltDesAce;
  FInfUltimoCalculoTotal.strTipOpe := objVenda.strTipOpe;
  FInfUltimoCalculoTotal.strTipPed := objVenda.strTipPed;
  FInfUltimoCalculoTotal.fltTotBom := objVenda.fltTotBom;
  FInfUltimoCalculoTotal.strUfTrib := objVenda.fUFsDestTribItems;
end;

procedure TfrmFatDadosFechamentoPedido.pnlCondicaoPagamentoExit(
  Sender: TObject);
begin
  inherited;

  If (Assigned(ActiveControl)) And (ActiveControl.Name = 'btnCancelaDados') Then
  Begin
    If pnlCondicaoPagamento.Visible Then
    Begin
      pReiniciarVariaveisCondicaoPagamento;
      FillChar(FInfUltimoCalculoTotal, SizeOf(FInfUltimoCalculoTotal), #0);
    End;
    Exit;
  End;

  If Not fValidarDigitacaoCondicaoPagamento() Then
    SelectFirst;
end;

procedure TfrmFatDadosFechamentoPedido.pOnAlterarEntregaClick;
begin
  pAlteraEnderecoEntrega(False);
  pDefinirLocalEntregaDiferente;

  If (Not fEmptyStr(objVenda.strNumOrc)) Then
    objVenda.strCodTra := objVenda.fVerificaTranspDoctoDifEndEntrega;

  TfrmGravando.fExecutarModal(pAtualizaFrameTransportadora, 'Aguarde, Atualizando transportadora ...', '');

  If objVenda.fAtendeRegraFiscalEndEntrega Then
    TfrmGravando.fExecutarModal(pAplicarRegraFiscalEnderecoEntrega, 'Aguarde, Aplicando Regra Fiscal do endereço de entrega ...', '')
  Else
    pCalcularTotalPedido('Atualizando endereço de entrega', 0);

  SelectNext(btnAlterarEntrega, True, True);

  If FAlterouCodigoTransportadora Then
    fValidaCampos(fraTransportadora.edtCodTra, True);

  If FAlterouCodigoTransRedespacho Then
    fValidaCampos(fraTransportadora.edtTraRedCod, True);
end;

procedure TfrmFatDadosFechamentoPedido.pOnLocalDiferenteClick;
begin
  If Not chkLocalDiferente.Checked Then
  Begin
    pCarregarEnderecoEntregaPrincipal;

    TfrmGravando.fExecutarModal(pAtualizaFrameTransportadora, 'Aguarde, Atualizando transportadora ...', '');

    If objVenda.fAtendeRegraFiscalEndEntrega Then
      TfrmGravando.fExecutarModal(pAplicarRegraFiscalEnderecoEntrega, 'Aguarde, Aplicando Regra Fiscal do endereço de entrega ...', '')
    Else
      pCalcularTotalPedido('Atualizando endereço de entrega', 0);
  End
  Else If chkLocalDiferente.Focused Then
    btnAlterarEntrega.Click;

  lblDescricaoEndereco.Caption := 'Endereço de Entrega: ' + objVenda.fDescricaoEnderecoEntrega;

  If FAlterouCodigoTransportadora Then
    fValidaCampos(fraTransportadora.edtCodTra, True);

  If FAlterouCodigoTransRedespacho Then
    fValidaCampos(fraTransportadora.edtTraRedCod, True);
end;

procedure TfrmFatDadosFechamentoPedido.pOnProcessaItem(const item: TDadosFechamento; index, count: Integer; AInfo: String = '');
Var
  LPos: Integer;
  LMax: Integer;
begin
  If Assigned(frmCalculando) Then
  Begin
    LPos := Succ(Index);
    LMax := Count -1;
    If (LPos Mod FStepsProcessamento = 0) Or (LPos = LMax) Then
    Begin
      If AInfo.IsEmpty Or FRandomSteps Then
        AInfo := FInformacaoProcessamento;
      pInformacao(Format(AInfo, [item.strCodIte + '-' + fPadR(item.strDesIte, 10)]), frmCalculando.pgbStatus);
      pProgresso(LPos, LMax, frmCalculando.pgbStatus);
      If FRandomSteps Then
        FStepsProcessamento := RandomRange(1, 10);
    End;
  End;
end;

procedure TfrmFatDadosFechamentoPedido.pAplicarRegraFiscalEnderecoEntrega;
begin
  cdsVenda.Data := FCdsVendaBkp.Data;

  cdsVenda.LogChanges := False;

  objVenda.pFormataDecimaisGrid(cdsVenda);

  objVenda.pPreencheMatrizFechamento('', pOnProcessaItem);

  If pnlCondicaoPagamento.Visible Then
    fAtualizarDadosCondicaoPagamento(fraPagamento, False)
  Else
  Begin
    pCalcularTotalPedido('Aplicando Regra Fiscal do endereço de entrega', 0, True);

    If objVenda.fHouveAlteracaoRegraTributariaItensAposCalculaTotger() Then
      pCalcularTotalPedido('', 1, True);
  End;
end;

procedure TfrmFatDadosFechamentoPedido.pReiniciarVariaveisCondicaoPagamento;
begin
  fraPagamento.blnConfirma := False;
  objVenda.fltTaxJur := 0;
  objVenda.fltTaxVpr := 0;
  objVenda.blnTaxVpr := False;
  objVenda.blnDeCndF := False;
  objVenda.arrMatItens := FArrMatItensBkp;
  cdsVenda.CloneData(FCdsVendaBkp);
  cdsVenda.LogChanges := False;
  objVenda.pFormataDecimaisGrid(cdsVenda);
end;

procedure TfrmFatDadosFechamentoPedido.pSalvarVariaveisVenda;
begin
  FBackupVar.SetBackupVar(['fltValFre', 'fltDesAce', 'strEspDoc', 'fltPorDes', 'fltDesEsp']);
end;

procedure TfrmFatDadosFechamentoPedido.pRestaurarVariaveisVenda;
begin
  FBackupVar.GetBackupVar(['fltValFre', 'fltDesAce', 'strEspDoc', 'fltPorDes', 'fltDesEsp']);
end;

procedure TfrmFatDadosFechamentoPedido.pSetarAvisosTravaRemota(
  blnAtivar: Boolean);
begin
  If (Not Assigned(objVenda)) Then
    Exit;

  If (blnAtivar) Then
    objVenda.blnExibirAvisosTravaRemota := (Not fLiberacaoRemotaNoFinalVenda)
  Else
    objVenda.blnExibirAvisosTravaRemota := True;
end;

procedure TfrmFatDadosFechamentoPedido.pSetarCaptionBotaoConfirma;
begin
  btnConfirmaDados.Width := 105;
  btnConfirmaDados.Caption := '[F10] Confirma';
  If (fDocumentoSelecionado = 'OR') Then
  Begin
    btnConfirmaDados.Caption := '[F10] Gravar Orçamento';
    btnConfirmaDados.Width := 150;
  End
  Else If (fDocumentoSelecionado = 'PD') Then
  Begin
    btnConfirmaDados.Caption := '[F10] Gravar Pedido';
    btnConfirmaDados.Width := 150;
  End;
end;

procedure TfrmFatDadosFechamentoPedido.pSalvaVariaveisPagamento;
begin
  FBackupVar.SetBackupVar(['strCodCnd', 'strConPag', 'strCodFpg']);
end;

procedure TfrmFatDadosFechamentoPedido.pValidaImpressaoOrcamentoComPreco(objPerguntasImpressao : TDadosImprimePdOrSep);
  Var
    blnLiberouComSenha : Boolean;
begin
  If (Not Assigned(objVenda)) Then
    Exit;

  If Not Assigned(objPerguntasImpressao) Then
    Exit;

  If (fDocumentoSelecionado <> 'OR') Then
    Exit;

  If (Not fEscolheuOrcamentoComPreco(objPerguntasImpressao.opcComSemPreco)) Then
    Exit;

  If (Not fCfgSis('ORCSPR', varBoolean)) Then
    Exit;

  If (fEmptyStr(fCfgSis('SENPRE'))) Then
    Exit;

  blnLiberouComSenha := objVenda.fLiberouSenhaParaImprimirDocumentoComPreco;

  If (Not blnLiberouComSenha) Then
    objPerguntasImpressao.opcComSemPreco := impSemPrecoGeral;
end;

procedure TfrmFatDadosFechamentoPedido.pRestauraVariaveisPagamento;
begin
  FBackupVar.GetBackupVar(['strCodCnd', 'strConPag', 'strCodFpg']);
end;

procedure TfrmFatDadosFechamentoPedido.pValidarCondicaoPagamentoAoIniciarTelaFechamento;
begin
  pSalvaVariaveisPagamento;

  If objVenda.strNumOrc.IsEmpty Then
    Exit;

  If Not pnlCondicaoPagamento.Visible Then
    Exit;

  If fEmptyStr(fraPagamento.edtCodCnd.Text) Then
    Exit;

  If fEmptyStr(fraPagamento.mskCndPag.Text) Then
    Exit;

  If fEmptyStr(fraPagamento.edtForPag.Text) Then
    Exit;

  If Not fValidarDigitacaoCondicaoPagamento() Then
    pSetFocus(fraPagamento.edtCodCnd);

  pCalcularTotalPedido();
end;

procedure TfrmFatDadosFechamentoPedido.pAbrirPainelPerguntas(const intHeightEsq, intHeightDir: Integer);
  Const
    TOLERANCIA : Integer = 5;
  Var
    intHeightDisponivel : Integer;
begin
  If (intHeightEsq > intHeightDir) Then
    intHeightDisponivel := intHeightEsq - intHeightDir
  Else
    intHeightDisponivel := intHeightDir - intHeightEsq;

  If ((intHeightDisponivel+TOLERANCIA) < lblImpressao.Height) Then
    Exit;

  lblImpressaoClick(Self);
end;

procedure TfrmFatDadosFechamentoPedido.pAjustarAlturaTela(Var intHeightEsq, intHeightDir: Integer);
  Const
    intGordurinha = 50;

  function fRetornaAlturaElementosRodape: Integer;
  begin
    Result := intGordurinha + pnlConfirma.Height + pnlInfo.Height;
  end;

begin
  intHeightEsq := 0;

  If pnlEntrega.Visible Then
    intHeightEsq := intHeightEsq + pnlEntrega.Height;

  If pnlFaseObra.Visible Then
    intHeightEsq := intHeightEsq + pnlFaseObra.Height;

  If pnlProfissional.Visible Then
    intHeightEsq := intHeightEsq + pnlProfissional.Height;

  If pnlProfissionalVarios.Visible Then
    intHeightEsq := intHeightEsq + pnlProfissionalVarios.Height;

  If pnlTotalDocumento.Visible Then
    intHeightEsq := intHeightEsq + pnlTotalDocumento.Height;

  If pnlCondicaoPagamento.Visible Then
    intHeightEsq := intHeightEsq + fRetornaSomaAlturaDosPaineisVisiveisEm(fraPagamento.pnlFundo);

  If fraInvoice.Visible Then
    intHeightEsq := intHeightEsq + fRetornaSomaAlturaDosPaineisVisiveisEm(fraInvoice.pnlFundo);

  intHeightEsq :=  intHeightEsq + fRetornaSomaAlturaDosPaineisVisiveisEm(fraTransportadora.pnlFundo);

  fraDadosPedido.Height := fRetornaSomaAlturaDosPaineisVisiveisEm(fraDadosPedido.pnlFundo);

  intHeightDir := fRetornaSomaAlturaDosPaineisVisiveisEm(fraObservacoes.pnlFundo) +
                  fRetornaSomaAlturaDosPaineisVisiveisEm(fraDadosPedido.pnlFundo);

  If fraDescFinanBoletoAdto.Visible Then
    intHeightDir := intHeightDir + fRetornaSomaAlturaDosPaineisVisiveisEm(fraDescFinanBoletoAdto.pnlFundo);

  If fraFatorParaFaturamento.Visible Then
    intHeightDir := intHeightDir + fRetornaSomaAlturaDosPaineisVisiveisEm(fraFatorParaFaturamento.pnlFundo);

  If fraLiberacaoPedido.Visible Then
    intHeightDir := intHeightDir + fRetornaSomaAlturaDosPaineisVisiveisEm(fraLiberacaoPedido.pnlFundo);

  If fraNumeroDrawbackFrame.Visible Then
    intHeightDir := intHeightDir + fRetornaSomaAlturaDosPaineisVisiveisEm(fraNumeroDrawbackFrame.pnlDrawBackFrame);

  If fraClienteContaOrdemFrame.Visible Then
    intHeightDir := intHeightDir + fRetornaSomaAlturaDosPaineisVisiveisEm(fraClienteContaOrdemFrame.pnlFundo);

  Self.ClientHeight := Max(intHeightEsq, intHeightDir) + fRetornaAlturaElementosRodape;
end;

procedure TfrmFatDadosFechamentoPedido.pAjustarPainelBotaoImpressao;
  const
    DIFERENCA_BORDA : Integer = 5;
begin
  pnlImpressao.Visible := False;

  If (FPerguntasImpressaoVenda.GetQuantidadePerguntas = 0) Then
    Exit;

  pnlImpressao.Visible := True;
  pnlImpressao.Top := pnlConfirma.Top - pnlImpressao.Height - DIFERENCA_BORDA;
  pnlImpressao.Left := pnlConfirma.Width - pnlImpressao.Width - DIFERENCA_BORDA;
  pnlImpressao.BringToFront;
end;

procedure TfrmFatDadosFechamentoPedido.pSetarHintDescontoEspecialComDesoneracao(const AExibeHint : Boolean);
  Var
    strTextoHint : String;
begin
  lblDescontoEspecial.ShowHint := AExibeHint;
  If (AExibeHint) Then
  Begin
    strTextoHint := 'Desconto Comercial: ' + FormatFloat('#,##0.00', objVenda.fltDesComercialZFM) + sLineBreak +
                    'Desoneração: ' + FormatFloat('#,##0.00', objVenda.fltIcmOrg);
    lblDescontoEspecial.Hint := strTextoHint;
    lblDescontoEspecial.Caption := lblDescontoEspecial.Caption;
  End
  Else
    lblDescontoEspecial.Hint := '';
end;

procedure TfrmFatDadosFechamentoPedido.pAtualizaTotalizacao;
  Var
    fltCreCli: Double;
    blnMostrarCredito: Boolean;
    blnExibeDesonerado : Boolean;
begin
  lblTotalProdutos.Caption    := FormatFloat(fMskDigitos(2), objVenda.fltTotPro);

  If objVenda.fltTotSer > 0 Then
  Begin
    lblTitProdutos.Caption    := '    Total dos Produtos/Serviços:';
    lblTotalProdutos.Caption  := FormatFloat(fMskDigitos(2), objVenda.fltTotPro + objVenda.fltTotSer);
  End;

  If objVenda.fltDesEsp > 0 Then
  Begin
    blnExibeDesonerado := objVenda.fPermiteDescontoComercialEmOperacaoZonaFrancaComDescontoDeIcms;
    lblDescontoEspecial.Caption := IIF(blnExibeDesonerado, ' ** ', '') + FormatFloat(fMskDigitos(2), objVenda.fltDesEsp);
    pSetarHintDescontoEspecialComDesoneracao(blnExibeDesonerado);
  End
  Else
  Begin
    lblDescontoEspecial.Visible := False;
    lblTitDescontoEspecial.Visible := False;
    lblTitProdutos.Top := lblDescontoEspecial.Top;
    lblTotalProdutos.Top := lblDescontoEspecial.Top;
  End;

  blnMostrarCredito := (blnDescontaCreditoAutomatico) And (Pos(objVenda.strCodFpg, '009_013_') = 0);

  fltCreCli := 0;
  If blnMostrarCredito Then
  Begin
    fltCreCli := IIF(fGetTotalCreditosCliente(objVenda.strCodCli) < objVenda.fltTotGer, fGetTotalCreditosCliente(objVenda.strCodCli), objVenda.fltTotGer);
    lblCreditoCliente.Caption := FormatFloat(fMskDigitos(2), fltCreCli);
    lblCreditoCliente.Visible := True;
    lblTitCreditoCliente.Visible := True;
  End
  Else
  Begin
    lblCreditoCliente.Visible := False;
    lblTitCreditoCliente.Visible := False;
  End;

  lblTitCBS.Visible := FblnSomarNovosImpostosDaReformaAoValorContabil;
  lblCBS.Visible := FblnSomarNovosImpostosDaReformaAoValorContabil;
  lblTitIBS.Visible := FblnSomarNovosImpostosDaReformaAoValorContabil;
  lblIBS.Visible := FblnSomarNovosImpostosDaReformaAoValorContabil;
  lblTitIS.Visible := FblnSomarNovosImpostosDaReformaAoValorContabil;
  lblIS.Visible := FblnSomarNovosImpostosDaReformaAoValorContabil;

  lblDespesaAcessoria.Caption := FormatFloat(fMskDigitos(2), objVenda.fltDesAce);
  lblFrete.Caption            := FormatFloat(fMskDigitos(2), objVenda.fltValFre);
  lblIPI.Caption              := FormatFloat(fMskDigitos(2), objVenda.fltTotIpi);
  lblST.Caption               := FormatFloat(fMskDigitos(2), objVenda.fltTotRet);
  lblFCPST.Caption            := FormatFloat(fMskDigitos(2), objVenda.fltTotFcpST);
  If (FblnSomarNovosImpostosDaReformaAoValorContabil) Then
  Begin
    lblCBS.Caption            := FormatFloat(fMskDigitos(2), objVenda.fltTotCBS);
    lblIBS.Caption            := FormatFloat(fMskDigitos(2), objVenda.fltTotIBS);
    lblIS.Caption             := FormatFloat(fMskDigitos(2), objVenda.fltTotIS);
  End
  Else
  Begin
    lblTotalComImpostos.Top := lblCBS.Top;
    lblTitTotalComImpostos.Top := lblTitCBS.Top;
  End;
  lblTotalComImpostos.Caption := FormatFloat(fMskDigitos(2), objVenda.fltTotGer);

  If blnMostrarCredito Then
    lblTotalComImpostos.Caption := FormatFloat(fMskDigitos(2), objVenda.fltTotGer - fltCreCli);
end;

procedure TfrmFatDadosFechamentoPedido.btnEspRascNFClick(Sender: TObject);
var
  objGerarEspelho: TGerarEspelhoRascunhoDANFE;
begin
  inherited;

  try
    objGerarEspelho := TGerarEspelhoRascunhoDANFE.Create(VS_strCodEmp, objVenda);
    blnConfirma       := False;
    FblnEspRascDANFE  := True;
    btnConfirmaDados.Click ;

    if (not blnConfirma) then
      Exit;

    objGerarEspelho.fGerarEspelho(objVenda.fOpcDocClaSub);
  finally
    blnConfirma        := False;
    FblnEspRascDANFE   := False;
    FreeAndNil(objGerarEspelho);
  end;
end;

end.


