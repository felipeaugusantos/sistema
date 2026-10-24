unit untDadosFechamentoPedidoFrame;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, DBEditFocus, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, untFuncFatTypes, untLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxGroupBox, UniClientDataSet;

type
  TfraDadosFechamentoPedidoFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlBombeamento: TGroupBox;
    lblTotalBombeamento: TLabel;
    lblQtdBombeamento: TLabel;
    lblPrecoBombeamento: TLabel;
    edtTotBom: TEditFocus;
    edtQtdBom: TEditFocus;
    edtPrcBom: TEditFocus;
    chkTaxMin: TCheckBox;
    pnlOutrasInformacoes: TGroupBox;
    btnPedCmp: TBitBtnLocked;
    pnlGerPen: TPanel;
    lbl2: TLabel;
    ColorLabel6: TColorLabel;
    edtGerPen: TEditFocus;
    pnlContato: TPanel;
    lblCliCtt: TLabel;
    edtCliCtt: TEditFocus;
    btnPesquisarContato: TBitBtnLocked;
    btnAdicionarContato: TBitBtnLocked;
    pnlTipAte: TPanel;
    lblTipAte: TLabel;
    edtDesTpa: TEditFocus;
    edtCodTpa: TEditFocus;
    pnlPorPed: TPanel;
    lbl7: TLabel;
    edtPorPed: TEditFocus;
    edtNomPorPed: TEditFocus;
    pnlOpcoesPV: TPanel;
    Label6: TLabel;
    cmbFinalidade: TComboBoxFocus;
    pnlTipoDeFaturamento: TGroupBox;
    lblTipFat: TColorLabel;
    lblPdvAlt: TLabel;
    Label11: TLabel;
    edtTipFat: TEditFocus;
    pnlFinalizacaoDoPedido: TGroupBox;
    chkPedExp: TCheckBox;
    chkEntUrg: TCheckBox;
    chkAgrIte: TCheckBox;
    pnlProjeto: TPanel;
    Label12: TLabel;
    edtCodPrj: TEditFocus;
    edtDesPrj: TEditFocus;
    edtValidade: TMaskEditFocus;
    lblValidade: TLabel;
    pnlTipOpe: TPanel;
    lblTipOpe: TLabel;
    edtTipOpe: TEditFocus;
    cblTipOpe2: TColorLabel;
    cblTipOpe: TColorLabel;
    pnlFinaliza: TPanel;
    edtFinaliza: TEditFocus;
    ColorLabel5: TColorLabel;
    lblFinPed: TLabel;
    pnlCategoria: TPanel;
    lblCategoria: TLabel;
    edtCodCategoria: TEditFocus;
    edtDesCat: TEditFocus;
    pnlEventos: TPanel;
    lblEventos: TLabel;
    edtDesEvento: TEditFocus;
    edtCodEvento: TEditFocus;
    cblTipOpe1: TColorLabel;
    cblTipOpe4: TColorLabel;
    cblTipOpe3: TColorLabel;
    cblTipOpe5: TColorLabel;
    cblTipOpe6: TColorLabel;
    pnlEmpFat: TPanel;
    lblEmpFat: TLabel;
    edtCodEmpFat: TEditFocus;
    edtDesEmpFat: TEditFocus;
    cblTipOpe7: TColorLabel;
    pnlClienteTipoOperacao: TPanel;
    lblCliTop: TLabel;
    edtCliTop: TEditFocus;
    edtNclTop: TEditFocus;
    btnItensPedidoRemessa: TBitBtnLocked;
    gpbRetornarContatoCliente: TGroupBox;
    Panel2: TPanel;
    lblDataRetorno: TLabel;
    lblHoraRetorno: TLabel;
    mskDataRetorno: TMaskEditFocus;
    mskHoraRetorno: TMaskEditFocus;
    procedure edtQtdTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipFatChange(Sender: TObject);
    procedure btnPedCmpClick(Sender: TObject);
    procedure edtPesLiqKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTpaKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorPedKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipOpeExit(Sender: TObject);
    procedure chkAgrIteClick(Sender: TObject);
    procedure chkTaxMinClick(Sender: TObject);
    procedure edtQtdBomExit(Sender: TObject);
    procedure cmbFinalidadeClick(Sender: TObject);
    procedure btnAdicionarContatoClick(Sender: TObject);
    procedure btnPesquisarContatoClick(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCategoriaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEventoKeyPress(Sender: TObject; var Key: Char);
    procedure chkEntUrgClick(Sender: TObject);
    procedure edtCodEmpFatKeyPress(Sender: TObject; var Key: Char);
    procedure btnItensPedidoRemessaClick(Sender: TObject);
    procedure edtCliTopKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipOpeChange(Sender: TObject);
    procedure edtCliTopExit(Sender: TObject);
  private
    { Private declarations }
    blnIniciandoTela: Boolean;

    blnPermitirEmissaoFF : Boolean;
    blnPermitirEmissaoBR : Boolean;
    blnAmostraContraOrdem: Boolean;
    blnSenhaValidade: Boolean;
    FblnLibEntUrgente: Boolean;

    dtaDtaLim: TDateTime;
    qryConPor: TUniQuery;
    qryCadPrj: TUniQuery;
    qryCadCat: TUniQuery;
    qryCliTop: TUniQuery;

    strTipOpeAnt: String;

    blnBonPed: Boolean;
    blnPcoOrd: Boolean;
    blnPedAmo: Boolean;
    blnPerDem: Boolean;
    blnPedUco: Boolean;
    blnRemCod: Boolean;
    blnVenExp: Boolean;

    objLiberacao: TLiberacao;

    procedure pOnShow;

    procedure pCalculaTotalBombeamento;

    function fExibirTipoAtendimento: Boolean;
    function fRetDataLimite: TDateTime;
    procedure pMostrarPanelTipFat;

    function fVerificaTipFatPerfilCondicao: Boolean;
    procedure pMostraAlertaPDVCitel;
    procedure pSetarFinalidade(strTipFat: String);
    function fFinalidade: TFinalidadeDocumento;
    procedure pPermBonifItens;
    function fFinalidadeDoPedidoCoerenteComTipoDeFaturamento: Boolean;
    function fPermiteEntregaComCupomFiscal: Boolean;
    function fRetTipFat: String;
    function fValidaAlterarGerarPedidosLojas: Boolean;
    procedure pValidaDireitoAcessoEntUrg;
    procedure pVoltarOpcaoEntUrg;

    function fTipoOperacaoRemessaContaOrdemSelecionada: Boolean;
    function fTemEmpFaturamentoSemSaldo: Boolean;
    procedure pPrepararExibicaoRetornoAoCliente;
    procedure pSetaDadosRetornoContatoCliente;
  public
    { Public declarations }
    objVenda: TFatVenda;
    qryDadosPedido: TUniQuery;
    blnLiberado: Boolean;
    bolNotifAgr: Boolean;
    blnEmitirBoletosAdiantamento: Boolean;
    blnEmitirBoletosAdtFecPD: Boolean;

    pCalcularTotalPedido: procedure(AInformacao: String = ''; ASteps: Integer = 1; AForcarCalculo: Boolean = False) of Object;
    pCarregarDespesasAcessorias: procedure(strTipoFaturamento: String) of Object;
    pHabilitarFatorParaFaturamento: procedure(strTipoFaturamento: String) of Object;
    pHabilitarLiberacaoPedido: procedure(blnHabilitar: Boolean) of Object;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;

    procedure OnAlterouCondicaoPagamento;

    function fConfirmaDados: Boolean;
  end;


implementation

uses untPesqAux, Data.DB, untTypesSistema, Math, untConsultas, untDigPedCmp,
     untTipoFreteAtc, untfuncoesSimples, untConstantes, untValidacoesRotasRegiao,
     untFatMostraItensFechamento, untCadClientes, untFuncoes, untPesoItem,
     untAdiantamentoClienteGenerico, untProjetos, untMsgLiberacao,
     untValidadorDaRegraValorEmissaoNFCePorEstado, untFatDigDadosUsoConsumo,
     untPnlDadosCliente, untPanelCxClientes, untFatItensRemessaContaOrdem,
     DateUtils;

{$R *.dfm}

procedure TfraDadosFechamentoPedidoFrame.btnAdicionarContatoClick(Sender: TObject);
  Var
    strCliCtt, strContato: String;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    frmCadClientes.strCodClienteIniciarCadastro := objVenda.strCodCli;
    frmCadClientes.blnCadContato := True;

    frmCadClientes.ShowModal();

    strCliCtt := frmCadClientes.strCodCliCtt;

    If (fEmptyStr(strCliCtt)) Then Begin
      fMensagem('ATENÇÃO!', 'Nenhum contato foi cadastrado!', ['&Ok']);
      objVenda.strCliCtt := '';
      edtCliCtt.Text     := '';
    End Else Begin
      strContato := fRetNomContatoCliente(strCliCtt);

      If (Not fEmptyStr(strContato)) Then Begin
        objVenda.strCliCtt := strCliCtt;
        edtCliCtt.Text     := strContato;
      End Else Begin
        fMensagem('ATENÇÃO!', 'Nenhum contato foi encontrado!', ['&Ok']);
        objVenda.strCliCtt := '';
        edtCliCtt.Text     := '';
      End;
    End;
  Finally
    pFreeAndNil(frmCadClientes);
  End;
end;

function TfraDadosFechamentoPedidoFrame.fConfirmaDados: Boolean;
  Var
    frmFatDigDadosUsoConsumo : TfrmFatDigDadosUsoConsumo;
begin
  inherited;
  Result := False;

  If (pnlOpcoesPV.Visible) And (cmbFinalidade.ItemIndex = -1) Then
  Begin
    pMensagemOk('ATENÇÃO: é necessário escolher a finalidade do pedido.');
    Exit;
  End;

  If (pnlOpcoesPV.Visible) And (fFinalidade = tfdCupomFiscal) Then
  Begin

    If objVenda.fPossuiBrindeProduto Then
    Begin
      pMensagemOk('Não é permitido emitir cupom fiscal para produto de brinde.');
      Exit;
    End
    Else If (Length(objVenda.strCliCgc) > 11) And
            (Not fCfgSis('EMIFPJ', varBoolean)) Then
    Begin
      pMensagemOk('Não é permitido emitir cupom fiscal para pessoa jurídica.');
      Exit;
    End
    Else If (Not fPermiteEmitirCupomParaForaDoEstado('IF', objVenda)) Then
    Begin
      Exit;
    End;

  End;

  If (pnlTipoDeFaturamento.Visible) And
     (edtTipFat.Text = 'C') And
     (fCfgSis('USNFCE', varBoolean)) And
     (Not fCfgSis('NFCEPJ', varBoolean)) And
     (Length(objVenda.strCliCgc) > 11) And
     (not fEmptyStr(objVenda.strCliIes)) Then
  Begin
    pMensagemOk('Não é permitido emitir NFCe para pessoa jurídica contribuinte.');
    Exit;
  End;

  if (pnlTipOpe.Visible) and (edtTipOpe.Text = 'A') and (edtTipFat.Text <> 'A') then
  begin
    pMensagemOk('ATENÇÃO: para o tipo de operação "Amostra" é necessário que o tipo de faturamento seja "Nota fiscal".');
    Exit;
  end;

  pSetaDadosRetornoContatoCliente;

  If edtValidade.Visible Then
    objVenda.dtaValOrc := StrToDate(edtValidade.Text)
  Else
    objVenda.dtaValOrc := 0;

  objVenda.strTipPed := edtTipFat.Text;

  objVenda.strTipOpe := edtTipOpe.Text;
  objVenda.strCliTop := edtCliTop.Text;

  If (pnlGerPen.Visible) Then
    objVenda.strGerPen := edtGerPen.Text
  Else
    objVenda.strGerPen := '';

  objVenda.strEntUrg := IIF(chkEntUrg.Checked, 'S', 'N');
  objVenda.strPD_Exp := IIF(chkPedExp.Checked, 'S', 'N');

  objVenda.blnAgrIte := chkAgrIte.Visible And chkAgrIte.Checked;

  objVenda.strCodTpA := edtCodTpa.Text;
  objVenda.strCodPrj := edtCodPrj.Text;
  objVenda.strNomPrj := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [edtCodPrj.Text], False);
  objVenda.strCodCat := edtCodCategoria.Text;
  objVenda.strCodEve := edtCodEvento.Text;
  objVenda.strEmpFatSemSaldo := edtCodEmpFat.Text;

  If pnlPorPed.Visible And edtPorPed.Enabled Then
    objVenda.strPorPed := edtPorPed.Text
  Else
    objVenda.strPorPed := EmptyStr;

  If (fFinalidade = tfdCupomFiscal) And (Not fValidaSePodeEmitirDAVPV(objVenda, objVenda.fltValFre, fFinalidade)) Then
    Exit;

  If Not fFinalidadeDoPedidoCoerenteComTipoDeFaturamento Then
    Exit;


    If (edtTipFat.Text = 'C') And (not fPermiteEntregaComCupomFiscal) And
        (Not objVenda.fHaveraDesmembramentoVenda) And (objVenda.fTemItensEntregaImediata(objVenda.arrMatItens)) And
        (fCfgSis('CUPENT') = '1') Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido emitir cupom fiscal quando informado valor de frete!', ['&Ok']);
    Exit;
  End;

    If (edtTipFat.Text = 'C') And (not fPermiteEntregaComCupomFiscal) And
        (objVenda.fltValFre > 0) And (objVenda.fPossuiSomenteItensRetira) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido emitir cupom fiscal quando informado valor de frete!', ['&Ok']);
      Exit;
    End;

    If (edtTipFat.Text = 'C') And (not fPermiteEntregaComCupomFiscal) And
        (objVenda.fltValFre > 0) And (fCfgSis('CUPENT') = '2') Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido emitir cupom fiscal quando informado valor de frete!', ['&Ok']);
      Exit;
    End;

  objVenda.blnCliExportacaoIndireta := fEhExportacaoIndireta(fCampoTabela('CLI_EXPIND', 'CADCLI', ['CLI_CODCLI'], [objVenda.strCodCli], False), objVenda.strTipOpe);
  objVenda.blnGravarDavPv := (fFinalidade = tfdCupomFiscal);

  pCalculaTotalBombeamento;

  If (edtTipOpe.Text = 'U') then
  Begin

    pCriarFormularios(TfrmFatDigDadosUsoConsumo, frmFatDigDadosUsoConsumo);

    Try

      If frmFatDigDadosUsoConsumo.ShowModal = mrOk Then
      Begin
        objVenda.strFornecedorUsoConsumo := frmFatDigDadosUsoConsumo.edtCodFor.Text;
        objVenda.strCentroCustoUsoConsumo := frmFatDigDadosUsoConsumo.fraPlanoDeContas.MskCodCta.Text;
        objVenda.strHistoricoUsoConsumo := frmFatDigDadosUsoConsumo.edtHistor.Text;
        objVenda.strEventoUsoConsumo := IIF(fCfgSis('EVUSCS', varBoolean), frmFatDigDadosUsoConsumo.edtCodEve.Text,'');
      End
      Else
      Begin
        Exit;
      End;

    Finally
      pFreeAndNil(frmFatDigDadosUsoConsumo);
    End;

  End;

  Result := True;
end;

function TfraDadosFechamentoPedidoFrame.fExibirTipoAtendimento: Boolean;
begin
  Result := False;

  If objVenda.fEhVendaRapida(objVenda.strCodCli) And (Not fCfgSis('VRAMSG', varBoolean)) Then
    Exit(False);

  If Not fCfgSis('TIPATE', varBoolean) Then
    Exit(False);

  If ((objVenda.strEspDoc = 'PD') And fCfgSis('PEDTPA', varBoolean)) Then
    Exit(True);

  If ((objVenda.strEspDoc = 'OR') And fCfgSis('ORCTPA', varBoolean)) Then
    Exit(True);
end;

procedure TfraDadosFechamentoPedidoFrame.btnItensPedidoRemessaClick(
  Sender: TObject);
var
  frmFatItensRemessaContaOrdem: TfrmFatItensRemessaContaOrdem;
begin
  If Not fTipoOperacaoRemessaContaOrdemSelecionada Then
    Exit;

  pCriarFormularios(TfrmFatItensRemessaContaOrdem, frmFatItensRemessaContaOrdem);
  Try
    frmFatItensRemessaContaOrdem.objVenda := objVenda;
    If frmFatItensRemessaContaOrdem.ShowModal = mrOK Then
      frmFatItensRemessaContaOrdem.pGravarDadosCdsVenda;
  Finally
    pFreeAndNil(frmFatItensRemessaContaOrdem);
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.btnPedCmpClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmDigPedCmp, frmDigPedCmp);
  Try
    frmDigPedCmp.fatVenda := objVenda;
    If frmDigPedCmp.ShowModal = mrOK Then
      objVenda.npcNumCmp := frmDigPedCmp.npcNumCmp;
  Finally
    pFreeAndNil(frmDigPedCmp);
  End;
  SelectNext(btnPedCmp, True, True);
end;

procedure TfraDadosFechamentoPedidoFrame.btnPesquisarContatoClick(Sender: TObject);
  Var
    cKey: Char;
    arrContatos: TConsultasArray;
begin
  inherited;

  cKey := Char('/');

  If fPesqCliCtt(GetParentForm(self) as TForm, edtCliCtt, nil, cKey, arrContatos, objVenda.strCodcli) Then
    If (Length(arrContatos) > 0) Then
      objVenda.strCliCtt := arrContatos[0].strCodigo;
end;

procedure TfraDadosFechamentoPedidoFrame.chkAgrIteClick(Sender: TObject);
begin
  inherited;
  If bolNotifAgr And chkAgrIte.Checked And Not fPergunta('O sistema fará o agrupamento ' +
    'dos itens de mesmas características, somando suas quantidades. ' +
    'Este procedimento é irreversível. Confirma a operação?') Then
  Begin
    chkAgrIte.Checked := False;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.chkEntUrgClick(Sender: TObject);
begin
  pValidaDireitoAcessoEntUrg;
end;

procedure TfraDadosFechamentoPedidoFrame.chkTaxMinClick(Sender: TObject);
begin
  inherited;
  If chkTaxMin.Checked Then
  Begin
    lblTotalBombeamento.Caption := 'Taxa Mínima de Bombeamento:';
    edtTotBom.ReadOnly          := False;
    edtTotBom.TabStop           := True;
    lblPrecoBombeamento.Visible := False;
    edtPrcBom.Visible           := False;

    If Assigned(objVenda) Then
      objVenda.tbIteBom         := tbTaxaMinima;
  End
  Else
  Begin
    lblTotalBombeamento.Caption := 'Valor Total Bombeamento:';
    edtTotBom.ReadOnly          := True;
    edtTotBom.TabStop           := False;
    lblPrecoBombeamento.Visible := True;
    edtPrcBom.Visible           := True;

    If Assigned(objVenda) Then
      objVenda.tbIteBom         := tbItemBombeamento;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.cmbFinalidadeClick(Sender: TObject);
begin
  inherited;

  If Not fFinalidadeDoPedidoCoerenteComTipoDeFaturamento Then
  Begin
    Exit;
  End

  Else If (fFinalidade = tfdCupomFiscal) And Not fValidaSePodeEmitirDAVPV(objVenda, objVenda.fltValFre, fFinalidade) Then
  Begin
    Exit;
  End;

  pMostraAlertaPDVCitel;
end;

procedure TfraDadosFechamentoPedidoFrame.OnAlterouCondicaoPagamento;
begin
  If Assigned(pCarregarDespesasAcessorias) Then
    pCarregarDespesasAcessorias(edtTipFat.Text);
  objVenda.pHabilitarPortadorPedido(pnlPorPed, edtPorPed, edtNomPorPed);
  objVenda.pExibirPanelFinalizacaoPedido(pnlFinalizacaoDoPedido, lblFinPed, edtFinaliza, '', blnEmitirBoletosAdtFecPD);

end;

procedure TfraDadosFechamentoPedidoFrame.OnFormCreate;
begin
  inherited;
  blnLiberado := False;

  blnSenhaValidade := False;

  strTipOpeAnt := '';

  pnlGerPen.Visible  := (fCfgSis('UTIPEN', VarBoolean)) And
                        (Pos(fCfgSis('TIPEXP'), '3_4_') > 0);

  qryConPor := fCriaQuery(Self);
  qryCadPrj := fCriaQuery(Self);
  qryCadCat := fCriaQuery(Self);
  qryCliTop := fCriaQuery(Self);

  blnPermitirEmissaoFF := fPermiteEmissaoEspecie('FF');
  blnPermitirEmissaoBR := fPermiteEmissaoEspecie('BR');

  blnAmostraContraOrdem := fVerificaAcessoSistema('AMOREMCONORD');

  If (blnPermitirEmissaoFF) Then
    lblTipFat.Caption := '(A) - Nota Fiscal    (B) - FF    (C) - Cupom Fiscal'
  Else If SameText(edtTipOpe.Text, 'V') Then
    lblTipFat.Caption := '(A) - Nota Fiscal    (C) - Cupom Fiscal'
  else
    lblTipFat.Caption := '(A) - Nota Fiscal';

  objLiberacao := TLiberacao.create;
end;

procedure TfraDadosFechamentoPedidoFrame.OnFormDestroy;
begin
  FreeAndNil(qryCliTop);
  FreeAndNil(objLiberacao);
  inherited;
end;

function TfraDadosFechamentoPedidoFrame.fRetDataLimite: TDateTime;
  Var
    qryAux: TUniQuery;
    strData: String;
    strPeri: String;
begin
  qryAux := fCriaQuery(Self);
  strData := fCadEmp('PXDTEN');
  strPeri := fCadEmp('PXPEEN');

  If (Not fEmptyStr(strData)) Then
  Begin
    Result := StrToDate(strData);
    If Not fEmptyStr(strPeri) Then
    Begin
      If (strPeri = 'M') Then
        Result := Result + StrToTime('00:00:00')
      Else
        Result := Result + StrToTime('12:00:00');
    End;
  End
  Else
  Begin
    Result := 0;
  End;

  FreeAndNil(qryAux);
end;

function TfraDadosFechamentoPedidoFrame.fRetTipFat: String;
var
  fltValFat: Double;
  strTipFat: String;
begin
  Result := fCfgSis('TIPFAT');

  if fEmptyStr(objVenda.strCodCli) then
    Exit;

  fltValFat := fCampoTabela('CLI_FTNFES', 'CADCLI', ['CLI_CODCLI'], [objVenda.strCodCli], False);
  strTipFat := fCampoTabela('CLI_TIPFAT', 'CADCLI', ['CLI_CODCLI'], [objVenda.strCodCli], False);

  if (fCfgSis('TIPFAT', varString) = 'E') and (fCfgSis('FTNFES', varBoolean)) and (fCfgSis('SOLFNE', varBoolean)) then
    Result := IIF(fEmptyStr(strTipFat), 'A', strTipFat)
  else if (fCfgSis('FTNFES', varBoolean)) and (fltValFat > 0) then
    Result := strTipFat;

  if Result = 'E' then
    Result := 'A';
end;

function TfraDadosFechamentoPedidoFrame.fTemEmpFaturamentoSemSaldo: Boolean;
begin
  Result := False;

  if (fEmptyStr(objVenda.strEmpFatSemSaldo)) then
    Exit;

  if (objVenda.strCodCli <> objVenda.strCliAnt) then
    Exit;

  Result := True;
end;

function TfraDadosFechamentoPedidoFrame.fTipoOperacaoRemessaContaOrdemSelecionada: Boolean;
begin
  Result := False;

  If Not pnlClienteTipoOperacao.Visible Then
    Exit;

  If (edtTipOpe.Text <> 'R') Then
    Exit;

  If (Not blnRemCod) Then
    Exit;

  Result := True;
end;

procedure TfraDadosFechamentoPedidoFrame.pPermBonifItens;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  VS_intDecUni: Integer;
  intAgrupador: Integer;
  strMarMkp: String;
  fltPerDesIte: Double;
  strMsgTabPre: String;
  blnTabDif  : Boolean;
  cdsFatIteVen: TUniClientDataSet;

  function fLarguraTabela : integer;
  begin
    Result := 136 + IIF(strMarMkp = '99', 9, 0) + IIF((fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)), 4, 0);
  end;

  function fExisteTabelaPrecoDiferenteNosItens: Boolean;
  Var
    strTabTmp: String;
    cdsItensTmp: TUniClientDataSet;
  Begin
    Result := False;

    cdsItensTmp := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsItensTmp, cdsFatIteVen);

    With cdsItensTmp Do
    Begin
      First;

      strTabTmp := FieldByName('ITE_TABPRE').AsString;

      While Not Eof Do
      Begin
        If (strTabTmp <> FieldByName('ITE_TABPRE').AsString) Then
        Begin
          Result := True;
          Break;
        End;
        Next;
      End;

    End;
  End;

begin

  intAgrupador := -1;
  strMarMkp := fCfgSis('MARMKP');

  cdsFatIteVen := TUniClientDataSet.Create(Self);

  If objVenda.objMargemLucro.cdsItensMargem.IsEmpty Then
    objVenda.fCalculaMargemLucro(False, -1);

  pCloneDataSet(cdsFatIteVen, objVenda.objMargemLucro.cdsItensMargem);

  if cdsFatIteVen <> nil then
  begin
    objLiberacao.objMsgRemota.pAddTexto('Digitação de Pedido de Bonificação.');
    objLiberacao.objMsgRemota.pAddSeparador;
    objLiberacao.objMsgRemota.pAddTextoCaption('Dt.Emissão', FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()), 12);

    If (Not fEmptyStr(objVenda.strNumOrc)) Then
       objLiberacao.objMsgRemota.pAddTextoCaption('Documento', objVenda.strNumOrc + '-' + objVenda.strEspOrc + '-' + VS_strCodEmp, 12);

    objLiberacao.objMsgRemota.pAddTextoCaption('Cliente'     , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli)  , 12);
    objLiberacao.objMsgRemota.pAddTextoCaption('Vendedor'    , objVenda.strCodVen + '-' + fRetNomeOperador(objVenda.strCodVen), 12);
    objLiberacao.objMsgRemota.pAddTextoCaption('Vr.Document' , FloatToStrF(objVenda.fltTotGer, ffNumber, 12, 2)               , 12);
    objLiberacao.objMsgRemota.pAddTextoCaption('Cond. Pagto.', objVenda.strCodCnd + '-' + fRetDesConPag(objVenda.strCodCnd)   , 12);
    objLiberacao.objMsgRemota.pAddTextoCaption(''            , fFormataCondPag(objVenda.strConPag)                            , 12);
    objLiberacao.objMsgRemota.pAddTextoCaption('Forma Pagto.', objVenda.strCodFpg + '-' + fRetDescFpg(objVenda.strCodFpg)     , 12);

    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'Cod.'      , 5  , alEsquerda, teAutcom);
    objLinha.pAddColuna(''  , 'Unidade'   , 9  , alEsquerda, teAutcom);
    objLinha.pAddColuna(''  , 'Quantidade', 10 , alEsquerda, teAutcom);
    objLinha.pAddColuna(''  , 'Vl.Origi'  , 12 , alCentro  , teAutcom);
    objLinha.pAddColuna(''  , '(%)Desc'   , 10 , alCentro  , teAutcom);
    objLinha.pAddColuna(''  , 'Vl.Unit'   , 12 , alCentro  , teAutcom);
    objLinha.pAddColuna(''  , 'Pr.Custo'  , 12 , alCentro  , teAutcom);
    objLinha.pAddColuna(''  , '%M.Prop'   , 10 , alCentro  , teAutcom);
    objLinha.pAddColuna(''  , '%M.Prat'   , 10 , alCentro  , teAutcom);

    objLinha.pAddColuna('', 'Pr.Ult+Imp', 12 , alCentro  , teAutcom);
    objLinha.pAddColuna('', '%M.Ult+I'  , 10 , alCentro  , teAutcom);

    if strMarMkp = '99' then
      objLinha.pAddColuna('', '%Markup'   , 8  , alCentro  , teAutcom);

    if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
      objLinha.pAddColuna('', 'Emp'       , 3  , alCentro  , teAutcom);

    objTabela.lstLinhas.Add(objLinha);

    VS_intDecUni := fCfgSis('DECUNI', varInteger);

    blnTabDif    := True;
    strMsgTabPre := '';

    With cdsFatIteVen do
    begin

      First;

      If (Not fExisteTabelaPrecoDiferenteNosItens) Then
      Begin
        blnTabDif := False;
        strMsgTabPre := ' - Tabela de Preço: ' + FieldByName('ITE_TABPRE').AsString;
      End;

      while not Eof do
      begin
        inc(IntAgrupador);

        If FieldByName('ITE_UNIORI').AsFloat = 0 Then
          fltPerDesIte := 0.00
        Else
          fltPerDesIte := (1 - (FieldByName('ITE_UNITAR').AsFloat / FieldByName('ITE_UNIORI').AsFloat)) * 100;

        strMsgTabPre := '';

        If (blnTabDif) Then
          strMsgTabPre := ' - Tabela de Preço: ' + FieldByName('ITE_TABPRE').AsString;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.intAgrupador := intAgrupador;

        If (FieldByName('ITE_PROMOC').AsString = 'S') Then
          objLinha.pAddColuna('Item', '*' + FieldByName('ITE_CODITE').AsString + ' - ' + Copy(FieldByName('ITE_DESITE').AsString,1,109), fLarguraTabela - 3)
        Else
          objLinha.pAddColuna('Item', FieldByName('ITE_CODITE').AsString + ' - ' + Copy(FieldByName('ITE_DESITE').AsString,1,109), fLarguraTabela - 3);

        objTabela.lstLinhas.Add(objLinha);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.intAgrupador := intAgrupador;
        objLinha.pAddColuna(''     , '     '                                                 , 5                  , alEsquerda, teAutcom);
        objLinha.pAddColuna('Marca', Copy(FieldByName('ITE_DESMAR').AsString,1,100) + strMsgTabPre, fLarguraTabela - 10, alEsquerda, teAmbos   , True);
        objTabela.lstLinhas.Add(objLinha);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cod.'      , ''                                                                                         , 5  , alEsquerda , teAutcom);
        objLinha.pAddColuna('Unid.'     , Copy(FieldByName('ITE_SIGUNI').AsString,1,6)                                               , 9  , alEsquerda , teAmbos);
        objLinha.pAddColuna('Quantidade', FloatToStrf(FieldByName('ITE_QTDITE').AsFloat, ffFixed, 11, fCfgSis('DECQTD', varInteger)) , 10 , alEsquerda , teAmbos);
        objLinha.pAddColuna('Vl.Origi'  , FloatToStrf(FieldByName('ITE_UNIORI').AsFloat, ffFixed, 10, VS_intDecUni)                  , 12 , alDireita  , teAmbos);
        objLinha.pAddColuna('(%)Desc'   , FloatToStrf(fltPerDesIte                     , ffFixed, 10, VS_intDecUni)                  , 10 , alDireita  , teAmbos);
        objLinha.pAddColuna('Vl.Unit'   , FloatToStrf(FieldByName('ITE_UNITAR').AsFloat, ffFixed, 10, VS_intDecUni)                  , 12 , alDireita  , teAmbos);
        objLinha.pAddColuna('Pr.Custo'  , FloatToStrf(FieldByName('ITE_PRECUS').AsFloat, ffFixed, 10, VS_intDecUni)                  , 12 , alDireita  , teAmbos);
        objLinha.pAddColuna('%M.Prop'   , FloatToStrf(FieldByName('ITE_MARITE').AsFloat, ffFixed, 8, 2)                              , 10 , alDireita  , teAmbos);
        objLinha.pAddColuna('%M.Prat'   , FloatToStrf(FieldByName('ITE_MARLUC').AsFloat, ffFixed, 8, 2)                              , 10 , alDireita  , teAmbos);

        objLinha.pAddColuna('Pr.Ult+Imp', FloatToStrf(FieldByName('ITE_CUSIMP').AsFloat, ffFixed, 12, VS_intDecUni)                , 12 , alDireita  , teAmbos);
        objLinha.pAddColuna('%M.Ult+I'  , FloatToStrf(FieldByName('ITE_MARIMP').AsFloat, ffFixed, 10, 2)                            , 10 , alDireita  , teAmbos);

        if strMarMkp = '99' then
          objLinha.pAddColuna('%Markup'   , FloatToStrf(FieldByName('ITE_MARKUP').AsFloat, ffFixed, 8, 2), 8  , alDireita  , teAmbos);

        {Mostra empresa do item quando utiliza Multiloja!}
        if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
          objLinha.pAddColuna('Emp'       , FieldByName('ITE_EMPITE').AsString, 3  , alCentro  , teAmbos);

        objTabela.lstLinhas.Add(objLinha);
        Next;
      end;
    end;
    objLiberacao.objMsgRemota.lstRegistros.Add(objTabela);
    objLiberacao.blnSomenteMsgRemota := True;
  end;

end;

procedure TfraDadosFechamentoPedidoFrame.pPrepararExibicaoRetornoAoCliente;
begin
  gpbRetornarContatoCliente.Visible := fSolicitaRetornoContatoCliente(objVenda.strEspDoc);
  If (Not gpbRetornarContatoCliente.Visible) Then
    Exit;
  If ((Not VS_strHabilitarCRM) And (fCfgSis('GERLIG', varBoolean))) Then
  Begin
    lblHoraRetorno.Visible := False;
    mskHoraRetorno.Visible := False;
  End;
end;

function TfraDadosFechamentoPedidoFrame.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strMenEmiNF: String;
    blnHavDes  : Boolean;
    LblnPossuiBrinde : Boolean;
    strMensagemRegraValorMaximoNFCePorEstado: String;
    strEspeciesPermitidas: String;
    intIndice: integer;
    objLinha  : TLinhaMsgLibera;
    objTabela : TRegistroMsgLiberaTabela;

  function fCPFObrigatorio: Boolean;
  begin
    Result := False;

    {CPFNOB = Permitir a emissão de pedido e orçamento multi-loja ou de entrega pelo CD sem identificação válida (CPF/CNPJ)?}
    If (objVenda.fGeraNovoPedidoEntregaCD('S') Or objVenda.fPedidoMultiLoja) And
       (fCfgSis('CPFNOB', varBoolean)) Then
      Exit;

    If fCfgSis('CPFOBR', varBoolean) Then
    Begin
      if (objVenda.blnEnt_CD and fClienteConsumidor(objVenda.strCliOri)) then
      Begin
        If Not objVenda.fValidaCPFConsumidor Then
        Begin
          Result := True;
          strMenEmiNF := 'um documento de entrega pelo CD. Neste caso, a identificação do cliente é obrigatória para que o CD possa realizar a entrega.';
        End;
      End
      Else
      If (edtTipFat.Text = 'A') Or (edtTipFat.Text = 'D') Then
      Begin
        If Not objVenda.fPermiteNotaServicoSemCpf Then
        Begin
          Result := True;
          strMenEmiNF := 'Nota Fiscal'
        End;
      End
      Else If (edtTipFat.Text = 'C') Then
      Begin
        If objVenda.fGeraNovoPedidoEntregaCD('S') Then
        Begin
          Result := True;
          strMenEmiNF := 'um documento de entrega pelo CD. Neste caso, a identificação do cliente é obrigatória para que o CD possa realizar a entrega.';
        End
        Else If (objVenda.fPedidoMultiLoja) And
                ((objVenda.fGeraNovoPedidoEntregaImediata('S')) Or (objVenda.fGeraNovoPedidoRetiraOutraLoja('S')) Or (objVenda.fGeraNovoPedidoRetiraExpedicao('S'))) Then
        Begin
          Result := True;
          strMenEmiNF := 'um documento multi-loja que terá desmembramento. Neste cenário, é obrigatório um CPF / CNPJ válido para que o consumidor tenha identificação no documento que será gerado para a outra loja.';
        End;
      End;
    End;
  end;

  function fGetLetrasTipFat(blnFormata: Boolean): String;
    Var
      strResult : String;
      intCnt : Integer;
  begin
    Result := 'A';

    If (blnPermitirEmissaoFF or blnPermitirEmissaoBR) Then
      Result := Result + 'B';

    If (edtTipOpe.Text <> 'B') Then
      Result := Result + 'C';

    If fCfgSis('SOLFNE', varBoolean) And (objVenda.strEspDoc = 'PD') Then
      Result := Result + 'D';

    If (blnFormata) And (Length(Result) > 1) Then
    begin
      strResult := '';
      For intCnt := 1 To Length(Result) Do
      Begin
        If (intCnt = Length(Result)) Then
          strResult := strResult + ' ou ' + Result[intCnt]
        Else If (fEmptyStr(strResult)) Then
          strResult := Result[intCnt]
        Else
          strResult := strResult + ', ' + Result[intCnt];
      End;
      Result := strResult;
    end;
  end;

begin

  Result := True;

  If (Sender = edtValidade) And (edtValidade.Visible) And (edtValidade.Enabled) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(edtValidade.Text, True, True)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de validade do orçamento deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (StrToDate(edtValidade.Text) < VS_Date) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de validade do orçamento deve ser maior ou igual à data atual!', ['&O k']);
      Result := False;
    End
    Else If (StrToDate(edtValidade.Text) > objVenda.dtaGraPed + fCfgSis('ORCVEN', varInteger)) Then
    Begin
      If Not blnSenhaValidade Then
      Begin
        objLiberacao.Clear;

        objLiberacao.objMsgLibera.pAddTexto('A data de validade do orçamento não pode ser maior que ' + DateToStr(objVenda.dtaGraPed + fCfgSis('ORCVEN', varInteger)) + '!');

        objLiberacao.strDirAce                := 'VALORC';
        objLiberacao.strMsgSen                := TRegistroMsgLiberaTexto(objLiberacao.objMsgLibera.lstRegistros[0]).strTexto;
        objLiberacao.strCodOpe                := strLoginUsuarioLogado;
        objLiberacao.blnSempreVariavelUsuario := True;


        Result := objLiberacao.fLibera;
        blnSenhaValidade := Result;
      End;
    End;
  End

  Else If (Sender = edtQtdBom) And (pnlBombeamento.Visible) Then
  Begin
    If chkTaxMin.Checked Then
    Begin
      If (fStrToFloat(edtTotBom.Text) > 0.0) And (fStrToFloat(edtQtdBom.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade de bombeamento de concreto deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      If (Not fEmptyStr(edtQtdBom.Text)) Then
      Begin
        If (fStrtoFloat(edtQtdBom.Text) < 0.0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de bombeamento de concreto deve ser maior ou igual a Zero!', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End

  Else If (Sender = edtPrcBom) And (pnlBombeamento.Visible) Then
  Begin

    If (Not fEmptyStr(edtPrcBom.Text)) Then
    Begin

      If (fStrtoFloat(edtPrcBom.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do bombeamento de concreto deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

      If (fStrtoFloat(edtQtdBom.Text) > 0.0) And (fStrtoFloat(edtPrcBom.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço do bombeamento de concreto deve ser informado!', ['&O k']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtTotBom) And (pnlBombeamento.Visible) And (chkTaxMin.Checked) Then
  Begin
    If (Not fEmptyStr(edtTotBom.Text)) Then
    Begin
      If (fStrtoFloat(edtTotBom.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor da taxa mínima do bombeamento de concreto deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

      If (fStrtoFloat(edtQtdBom.Text) > 0.0) And (fStrtoFloat(edtTotBom.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor da taxa mínima do bombeamento de concreto deve ser informado!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodTpa) And pnlTipAte.Visible Then
  Begin
    edtDesTpa.Text := fRetNomTipoAtend(edtCodTpa.Text);

    If Not fEmptyStr(fTiraCaracEspeciais(edtCodTpa.Text)) Then
    Begin
      If fEmptyStr(edtDesTpa.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este Tipo de Atendimento não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      If fCfgSis('OBRTPA', VarBoolean) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo de Atendimento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCodPrj) And pnlProjeto.Visible Then
  Begin
    If Not fEmptyStr(edtCodPrj.Text) Then
    Begin
      edtDesPrj.Text := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [edtCodPrj.Text], False);

      If fEmptyStr(edtDesPrj.Text) Then
      Begin
        fMensagem('', 'Projeto não encontrado !', ['&Ok']);
        Result := False;
        edtDesPrj.Clear;
      End
      Else
      If Not TProjeto.fClienteTemProjetoAtivo(objVenda.strCodCli, edtCodPrj.Text) Then
      Begin
        fMensagem('', 'Projeto não encontrado para o cliente do pedido!', ['&Ok']);
        Result := False;
        edtDesPrj.Clear;
      End;
    End;
  End

  Else If (Sender = edtTipOpe) And pnlTipOpe.Visible Then
  Begin

    If (Not MatchStr(edtTipOpe.Text, ['V','B','C','A','D','U','E','R'])) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação deve ser (V)enda, (B)onificação, (C)onta e Ordem, (A)mostra, (D)emonstração, (U)so/Consumo, (E) Venda para fins de exportação CFOP x501 ou (R)emessa Conta e Ordem!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'B') And (Not blnBonPed) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação Não permitido!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'C') And (Not blnPcoOrd) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação Não permitido!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'A') And (Not blnPedAmo) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação Não permitido!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'D') And (Not blnPerDem) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação Não permitido!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'U') And (Not blnPedUco) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação Não permitido!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'R') And (Not blnRemCod) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação Não permitido!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'E') And (Not blnVenExp) Then
    Begin
      fMensagem('ATENÇÃO!', 'Tipo de Operação Não permitido!', ['&Ok']);
      Result := False;
    End
    Else If (edtTipOpe.Text = 'D') And (edtTipOpe.Text <> strTipOpeAnt) And (Not fVerificaAcessoSistema('PERDEM')) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'PERDEM';
      objLiberacao.strMsgSen    := 'Digitação de Pedido de Demonstração';
      objLiberacao.strCodOpe    := objVenda.strCodVen;
      objLiberacao.strCodDig    := objVenda.strCodDig;
      objLiberacao.objMsgLibera.pAddTexto('Digitação de Pedido de Demonstração.');
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Emissão', FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()), 12);

      If (Not fEmptyStr(objVenda.strNumOrc)) Then
         objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objVenda.strNumOrc + '-' + objVenda.strEspOrc + '-' + VS_strCodEmp, 12);

      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'     , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli)  , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'    , objVenda.strCodVen + '-' + fRetNomeOperador(objVenda.strCodVen), 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Document' , FloatToStrF(objVenda.fltTotGer, ffNumber, 12, 2)               , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto.', objVenda.strCodCnd + '-' + fRetDesConPag(objVenda.strCodCnd)   , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption(''            , fFormataCondPag(objVenda.strConPag)                            , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto.', objVenda.strCodFpg + '-' + fRetDescFpg(objVenda.strCodFpg)     , 12);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cód.'       , fTamCodIte, alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'  , 70 , alEsquerda   , teAutcom);
      objLinha.pAddColuna(''  , 'UN'         , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Quantidade' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unitário', 11 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Total'   , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      for intIndice := 0 to Length(objVenda.arrMatItens) -1 do
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cód.'       , objVenda.arrMatItens[intIndice].strCodIte , fTamCodIte, alCentro  );
        objLinha.pAddColuna('Descrição'  , objVenda.arrMatItens[intIndice].strDesIte , 70 , alEsquerda);
        objLinha.pAddColuna('UN'         , objVenda.arrMatItens[intIndice].strCodUni , 4  , alCentro  );
        objLinha.pAddColuna('Quantidade' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), objVenda.arrMatItens[intIndice].fltQtdIte) , 12 , alDireita );
        objLinha.pAddColuna('Vr.Unitário', FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltUniTar) , 11 , alDireita );
        objLinha.pAddColuna('Vr.Total'   , FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltTotIte) , 16 , alDireita );
        objTabela.lstLinhas.Add(objLinha);
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      if objVenda.fFatMensagemLiberacao(objLiberacao) then
      Begin
        objVenda.strCodVen := objLiberacao.strCodOpe;
        objVenda.strCodDig := objLiberacao.strCodDig;
      end
      else
      begin
        Result := False;
        edtTipOpe.Text := 'V';
      End;
    End
    Else If (edtTipOpe.Text = 'B') And
            (fCfgSis('BONCND') <> objVenda.strCodCnd) And
            (Not fEmptyStr(fRetDesConPag(fCfgSis('BONCND')))) Then
    Begin
      pMensagemOk('É obrigatória a utilização da Condição de Pagamento "' +
                  fCfgSis('BONCND') + ' - ' + fRetDesConPag(fCfgSis('BONCND')) +
                  '" para pedido de bonificação. Você deve alterá-la para ' +
                  'conseguir fechar o pedido de bonificação.');
      Result := False;
    End
    Else If (edtTipOpe.Text = 'B') And (edtTipOpe.Text <> strTipOpeAnt) And (Not fVerificaAcessoSistema('PERBON')) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'PERBON';
      objLiberacao.strMsgSen    := 'Digitação de Pedido de Bonificação';
      objLiberacao.strCodOpe    := objVenda.strCodVen;
      objLiberacao.strCodDig    := objVenda.strCodDig;
      objLiberacao.objMsgLibera.pAddTexto('Digitação de Pedido de Bonificação.');
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Emissão', FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()), 12);

      If (Not fEmptyStr(objVenda.strNumOrc)) Then
         objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objVenda.strNumOrc + '-' + objVenda.strEspOrc + '-' + VS_strCodEmp, 12);

      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'     , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli)  , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'    , objVenda.strCodVen + '-' + fRetNomeOperador(objVenda.strCodVen), 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Document' , FloatToStrF(objVenda.fltTotGer, ffNumber, 12, 2)               , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto.', objVenda.strCodCnd + '-' + fRetDesConPag(objVenda.strCodCnd)   , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption(''            , fFormataCondPag(objVenda.strConPag)                            , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto.', objVenda.strCodFpg + '-' + fRetDescFpg(objVenda.strCodFpg)     , 12);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cód.'       , fTamCodIte, alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'  , 70 , alEsquerda   , teAutcom);
      objLinha.pAddColuna(''  , 'UN'         , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Quantidade' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unitário', 11 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Total'   , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      for intIndice := 0 to Length(objVenda.arrMatItens) -1 do
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cód.'       , objVenda.arrMatItens[intIndice].strCodIte , fTamCodIte, alCentro  );
        objLinha.pAddColuna('Descrição'  , objVenda.arrMatItens[intIndice].strDesIte , 70 , alEsquerda);
        objLinha.pAddColuna('UN'         , objVenda.arrMatItens[intIndice].strCodUni , 4  , alCentro  );
        objLinha.pAddColuna('Quantidade' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), objVenda.arrMatItens[intIndice].fltQtdIte) , 12 , alDireita );
        objLinha.pAddColuna('Vr.Unitário', FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltUniTar) , 11 , alDireita );
        objLinha.pAddColuna('Vr.Total'   , FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltTotIte) , 16 , alDireita );
        objTabela.lstLinhas.Add(objLinha);
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      pPermBonifItens;

      if objVenda.fFatMensagemLiberacao(objLiberacao) then
      Begin
        objVenda.strCodVen := objLiberacao.strCodOpe;
        objVenda.strCodDig := objLiberacao.strCodDig;
      end
      else
      begin
        Result := False;
        edtTipOpe.Text := 'V';
      End;

    End
    Else If (edtTipOpe.Text = 'C') And (edtTipOpe.Text <> strTipOpeAnt) And (Not blnAmostraContraOrdem) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'AMOREMCONORD';
      objLiberacao.strMsgSen    := 'Digitação de Pedido de Conta e Ordem';
      objLiberacao.strCodOpe    := objVenda.strCodVen;
      objLiberacao.strCodDig    := objVenda.strCodDig;
      objLiberacao.objMsgLibera.pAddTexto('Digitação de Pedido de Conta e Ordem.');
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Emissão', FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()), 12);

      If (Not fEmptyStr(objVenda.strNumOrc)) Then
         objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objVenda.strNumOrc + '-' + objVenda.strEspOrc + '-' + VS_strCodEmp, 12);

      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'     , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli)  , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'    , objVenda.strCodVen + '-' + fRetNomeOperador(objVenda.strCodVen), 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Document' , FloatToStrF(objVenda.fltTotGer, ffNumber, 12, 2)               , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto.', objVenda.strCodCnd + '-' + fRetDesConPag(objVenda.strCodCnd)   , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption(''            , fFormataCondPag(objVenda.strConPag)                            , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto.', objVenda.strCodFpg + '-' + fRetDescFpg(objVenda.strCodFpg)     , 12);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cód.'       , fTamCodIte, alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'  , 70 , alEsquerda   , teAutcom);
      objLinha.pAddColuna(''  , 'UN'         , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Quantidade' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unitário', 11 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Total'   , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      for intIndice := 0 to Length(objVenda.arrMatItens) -1 do
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cód.'       , objVenda.arrMatItens[intIndice].strCodIte , fTamCodIte, alCentro  );
        objLinha.pAddColuna('Descrição'  , objVenda.arrMatItens[intIndice].strDesIte , 70 , alEsquerda);
        objLinha.pAddColuna('UN'         , objVenda.arrMatItens[intIndice].strCodUni , 4  , alCentro  );
        objLinha.pAddColuna('Quantidade' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), objVenda.arrMatItens[intIndice].fltQtdIte) , 12 , alDireita );
        objLinha.pAddColuna('Vr.Unitário', FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltUniTar) , 11 , alDireita );
        objLinha.pAddColuna('Vr.Total'   , FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltTotIte) , 16 , alDireita );
        objTabela.lstLinhas.Add(objLinha);
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      if objVenda.fFatMensagemLiberacao(objLiberacao) then
      Begin
        objVenda.strCodVen := objLiberacao.strCodOpe;
        objVenda.strCodDig := objLiberacao.strCodDig;
      end
      else
      begin
        Result := False;
        edtTipOpe.Text := 'V';
      End;

    End
    Else If (edtTipOpe.Text = 'A') And (edtTipOpe.Text <> strTipOpeAnt) And (Not fVerificaAcessoSistema('PEDAMO')) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'PEDAMO';
      objLiberacao.strMsgSen    := 'Digitação de Pedido de Amostra';
      objLiberacao.strCodOpe    := objVenda.strCodVen;
      objLiberacao.strCodDig    := objVenda.strCodDig;
      objLiberacao.objMsgLibera.pAddTexto('Digitação de Pedido de Amostra.');
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Emissão', FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()), 12);

      If (Not fEmptyStr(objVenda.strNumOrc)) Then
         objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objVenda.strNumOrc + '-' + objVenda.strEspOrc + '-' + VS_strCodEmp, 12);

      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'     , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli)  , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'    , objVenda.strCodVen + '-' + fRetNomeOperador(objVenda.strCodVen), 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Document' , FloatToStrF(objVenda.fltTotGer, ffNumber, 12, 2)               , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto.', objVenda.strCodCnd + '-' + fRetDesConPag(objVenda.strCodCnd)   , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption(''            , fFormataCondPag(objVenda.strConPag)                            , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto.', objVenda.strCodFpg + '-' + fRetDescFpg(objVenda.strCodFpg)     , 12);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cód.'       , fTamCodIte, alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'  , 70 , alEsquerda   , teAutcom);
      objLinha.pAddColuna(''  , 'UN'         , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Quantidade' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unitário', 11 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Total'   , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      for intIndice := 0 to Length(objVenda.arrMatItens) -1 do
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cód.'       , objVenda.arrMatItens[intIndice].strCodIte , fTamCodIte, alCentro  );
        objLinha.pAddColuna('Descrição'  , objVenda.arrMatItens[intIndice].strDesIte , 70 , alEsquerda);
        objLinha.pAddColuna('UN'         , objVenda.arrMatItens[intIndice].strCodUni , 4  , alCentro  );
        objLinha.pAddColuna('Quantidade' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), objVenda.arrMatItens[intIndice].fltQtdIte) , 12 , alDireita );
        objLinha.pAddColuna('Vr.Unitário', FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltUniTar) , 11 , alDireita );
        objLinha.pAddColuna('Vr.Total'   , FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltTotIte) , 16 , alDireita );
        objTabela.lstLinhas.Add(objLinha);
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      if objVenda.fFatMensagemLiberacao(objLiberacao) then
      Begin
        objVenda.strCodVen := objLiberacao.strCodOpe;
        objVenda.strCodDig := objLiberacao.strCodDig;
      end
      else
      begin
        Result := False;
        edtTipOpe.Text := 'V';
      End;
    End
    Else If (edtTipOpe.Text = 'U') And (edtTipOpe.Text <> strTipOpeAnt) And (Not fVerificaAcessoSistema('PEDUCO')) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'PEDUCO';
      objLiberacao.strMsgSen    := 'Digitação de Pedido de Uso e Consumo';
      objLiberacao.strCodOpe    := objVenda.strCodVen;
      objLiberacao.strCodDig    := objVenda.strCodDig;
      objLiberacao.objMsgLibera.pAddTexto('Digitação de Pedido de Uso e Consumo.');
      objLiberacao.objMsgLibera.pAddSeparador;
      objLiberacao.objMsgLibera.pAddTextoCaption('Dt.Emissão', FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()), 12);

      If (Not fEmptyStr(objVenda.strNumOrc)) Then
         objLiberacao.objMsgLibera.pAddTextoCaption('Documento', objVenda.strNumOrc + '-' + objVenda.strEspOrc + '-' + VS_strCodEmp, 12);

      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'     , objVenda.strCodCli + '-' + fRetNomCliente(objVenda.strCodCli)  , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'    , objVenda.strCodVen + '-' + fRetNomeOperador(objVenda.strCodVen), 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vr.Document' , FloatToStrF(objVenda.fltTotGer, ffNumber, 12, 2)               , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto.', objVenda.strCodCnd + '-' + fRetDesConPag(objVenda.strCodCnd)   , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption(''            , fFormataCondPag(objVenda.strConPag)                            , 12);
      objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto.', objVenda.strCodFpg + '-' + fRetDescFpg(objVenda.strCodFpg)     , 12);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'Cód.'       , fTamCodIte, alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Descrição'  , 70 , alEsquerda   , teAutcom);
      objLinha.pAddColuna(''  , 'UN'         , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'Quantidade' , 12 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Unitário', 11 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'Vr.Total'   , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      for intIndice := 0 to Length(objVenda.arrMatItens) -1 do
      begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('Cód.'       , objVenda.arrMatItens[intIndice].strCodIte , fTamCodIte, alCentro  );
        objLinha.pAddColuna('Descrição'  , objVenda.arrMatItens[intIndice].strDesIte , 70 , alEsquerda);
        objLinha.pAddColuna('UN'         , objVenda.arrMatItens[intIndice].strCodUni , 4  , alCentro  );
        objLinha.pAddColuna('Quantidade' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), objVenda.arrMatItens[intIndice].fltQtdIte) , 12 , alDireita );
        objLinha.pAddColuna('Vr.Unitário', FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltUniTar) , 11 , alDireita );
        objLinha.pAddColuna('Vr.Total'   , FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.arrMatItens[intIndice].fltTotIte) , 16 , alDireita );
        objTabela.lstLinhas.Add(objLinha);
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      if objVenda.fFatMensagemLiberacao(objLiberacao) then
      Begin
        objVenda.strCodVen := objLiberacao.strCodOpe;
        objVenda.strCodDig := objLiberacao.strCodDig;
      end
      else
      begin
        Result := False;
        edtTipOpe.Text := 'V';
      End;
    End;

    If Result Then
    Begin
      If blnBuscaPorChave And (strTipOpeAnt <> edtTipOpe.Text) Then
        objVenda.pExibirPanelFinalizacaoPedido(pnlFinalizacaoDoPedido, lblFinPed, edtFinaliza, edtTipOpe.Text, blnEmitirBoletosAdtFecPD);

      strTipOpeAnt := edtTipOpe.Text;
    End;

    If Not fCfgSis('AGDLBT', VarBoolean) And Assigned(pHabilitarLiberacaoPedido) Then
    Begin
      If (Result) And (edtTipOpe.Text = 'B') And (fCfgSis('AGDLIB', VarBoolean)) Then
        pHabilitarLiberacaoPedido(False)
      Else
        pHabilitarLiberacaoPedido(True);
    End;

    if edtTipOpe.Text = 'A' then
      edtTipFat.Text := 'A';

    if (edtTipOpe.Text = 'B') and fCfgSis('PROKIT', varBoolean) then
    Begin
      LblnPossuiBrinde := objVenda.fPossuiBrindeProduto;

      if not LblnPossuiBrinde  then
        LblnPossuiBrinde := objVenda.fPossuiBrindeServico;

      if LblnPossuiBrinde then
      Begin
        fMensagem('ATENÇÃO!', 'Foram adicionados itens como brinde e neste caso não é '+
          'permitido finalizar o pedido com o tipo de operação "Bonificação". Remova a opção de brinde dos itens ou escolha um tipo de operação '+
          'diferente para finalizar o pedido!', ['&Ok']);
        Result := False;
      End;
    End;

    If (Not fTipoOperacaoRemessaContaOrdemSelecionada) And
       (Not fEmptyStr(edtNclTop.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Cliente Remessa só pode ser preenchido para ' +
                            'o tipo de operação (R)emessa de Conta e Ordem!', ['&Ok']);
      Result := False;
    End;

    If (Result) And
       (fTipoOperacaoRemessaContaOrdemSelecionada) And
       (Not fEmptyStr(edtNclTop.Text)) Then
      TfrmFatItensRemessaContaOrdem.pCarregaValoresRemessa(cdsVenda);

  End

  Else If (Sender = edtTipFat) And (pnlTipoDeFaturamento.Enabled) And (pnlTipoDeFaturamento.Visible) Then
  Begin
    blnHavDes := objVenda.fHaveraDesmembramentoVenda;

    If (Pos(edtTipFat.Text, fGetLetrasTipFat(False) ) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O tipo de faturamento deve ser ' + fGetLetrasTipFat(True) + '!', ['&Ok']);
      Result := False;
    End

    Else If (edtTipFat.Text = 'C') And
         (Not fPermiteEmitirCupomParaForaDoEstado('IF', objVenda)) Then
    Begin
      Result := False;
    End

    Else If (edtTipFat.Text = 'C') and (objVenda.fPossuiBrindeProduto) Then
    begin
      fMensagem('ATENÇÃO!', 'Não é permitido emitir cupom fiscal para produto de brinde.', ['&Ok']);
      Result := False;
    end

    Else If (edtTipFat.Text = 'C') And (fCfgSis('IF_PRZ') = 'N') And (objVenda.strConPag <> '01000') Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal com condição de pagamento a Prazo,'+#13#10+
                            'pois nas Configurações de Faturamento não há permissão !', ['&O k']);
      Result := False;
    End

    Else If (fCfgSis('ENCDIF') = 'N') And (edtTipFat.Text = 'C') And (objVenda.blnEnt_CD) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal quando entrega através do CD!', ['&Ok']);
      Result := False;
    End

    Else If (edtTipFat.Text = 'C')                             And
            (Not blnHavDes)                                    And
            (objVenda.fTemEntregaFutura(objVenda.arrMatItens)) And
            (fCfgSis('CUPNOT') = '1')                          And
            (Not fCfgSis('HEFCOE', varBoolean))                Then
    Begin
      pMensagemOk('Não é permitido Cupom Fiscal para Entrega Futura!');
      Result := False;
    End

    Else If (edtTipFat.Text = 'C')                                    And
            (Not  blnHavDes)                                          And
            (objVenda.fTemItensEntregaImediata(objVenda.arrMatItens)) And
            (fCfgSis('CUPENT') = '1')                                 Then
    Begin
      pMensagemOk('Não é permitido Cupom Fiscal para Entrega Imediata!');
      Result := False;
    End

    Else If (edtTipFat.Text = 'C') And (objVenda.fltTotIpi > 0) And (not objVenda.fPermiteCupomFiscalComIPI(edtTipFat.Text)) Then
    Begin
      pMensagemOk('Não é permitido Cupom Fiscal para pedido com IPI!');
      Result := False;
    End

    Else If (edtTipFat.Text = 'C') And (objVenda.fltValFre <> 0) And (objVenda.fBloqueiaCupomComFreteQuandoSATouNFCE) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitdo informar frete para Cupom Fiscal', ['&Ok']);
      Result := False;
    End

    Else If (SameText(edtTipFat.Text, 'C')) And (objVenda.blnCliFil) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido Cupom Fiscal para Cliente Filial', ['&O k']);
      Result := False;
    End

    Else if (SameText(edtTipFat.Text,'C') and  fCfgSis('USNFCE', varBoolean)) Then
    begin
      strMensagemRegraValorMaximoNFCePorEstado :=
        TValidadorDaRegraValorEmissaoNFCePorEstado.
          fRetornarValidacaoDaRegraValorEmissaoNFCePorEstado(
            fCadEmp('ESTADO'),
            objVenda.strCliCgc,
            'NFCe',
            objVenda.fltTotGer);

      if Not fEmptyStr(strMensagemRegraValorMaximoNFCePorEstado) then
      begin
        fMensagem('ATENÇÃO!', strMensagemRegraValorMaximoNFCePorEstado, ['&O k']);
        Result := False;
      end;
    end;


    If Result And fCPFObrigatorio Then
    Begin
      If (fEmptyStr(objVenda.strCliCgc)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Cliente não possui CPF / CNPJ. Não será permitido emitir ' + strMenEmiNF + '.', ['&Ok']);
        Result := False;
      End
      Else If (fReplicatorStr(objVenda.strCliCgc[1], Length(objVenda.strCliCgc)) = objVenda.strCliCgc) And
              (objVenda.fTrocaUFEndEntrega <> 'EX') Then
      Begin
        fMensagem('ATENÇÃO!', 'O CPF / CNPJ do cliente não é válido para emitir ' + strMenEmiNF + '.', ['&Ok']);
        Result := False;
      End;
    End;

    If Result And fCfgSis('PFLCLI', varBoolean) Then
    Begin
      Result := fVerificaTipFatPerfilCondicao;
        
      If Not Result Then
        fMensagem('ATENÇÃO!', 'Esse Tipo de Faturamento não é permitido pelo tipo de perfil da condição de pagamento!', ['&Ok']);
    End;

    If Result And (Pos(edtTipFat.Text, 'B_D_') > 0) Then
    Begin
      If (Not blnPermitirEmissaoFF) Then
        Result := False
      Else
        Result := objVenda.fPermiteEmissaoFFPeloTipoDePedido(edtTipFat.Text);
    End;

    If Result And objVenda.blnVendaPresencial Then
    Begin
      If Not objVenda.fValidaEspecieVendaPresencial(objVenda.fTipFatToEspecie(edtTipFat.Text), strEspeciesPermitidas) Then
      Begin
        pMensagemOk(Format(MSG_ESPECIES_PERMITIDAS_VENDA_PRESENCIAL, [strEspeciesPermitidas]));
        Result := False;
      End;
    End;

    If Result And objVenda.fPermiteIPISemDadosConsumidor Then
    Begin
      pCalcularTotalPedido('', 1, True);
      If Assigned(pCarregarDespesasAcessorias) Then
        pCarregarDespesasAcessorias(edtTipFat.Text);
    End;

    pMostraAlertaPDVCitel;
  End

  Else If (Sender = edtPorPed) And (pnlPorPed.Visible) And (edtPorPed.Enabled) Then
  Begin
    If Not fEmptyStr(edtPorPed.Text) Then
    Begin
      edtNomPorPed.Text := fRetNomPortador(edtPorPed.Text);
      If fEmptyStr(edtNomPorPed.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
        Result := False;
      End
      {*REQ*145940**********RP*}
      Else If Not fEmpresaTemAcessoPortador(edtPorPed.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Result := False;
      End
      Else If Not fPortadorPermiteBoletoFaturamento(edtPorPed.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Portador não é permitido para impressão de boletos no Faturamento!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'O portador deve ser preenchido.!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtGerPen) And (pnlGerPen.Visible) Then
  Begin
    If (fEmptyStr(edtGerPen.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Gerar Pendencia deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (Pos(edtGerPen.Text, 'S_N_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Gerar Pendencia deve ser S ou N!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = mskDataRetorno) And (gpbRetornarContatoCliente.Visible) Then
  Begin
    If (Not fEmptyDate(mskDataRetorno.Text)) And (VS_Date > StrToDateTimeDef(mskDataRetorno.Text, 0)) Then
    Begin
      fMensagem('', 'A Data de retorno deve ser maior que a data atual!', ['&OK']);
      Result := False;
    End;
  End

  Else If (Sender = mskHoraRetorno) And (gpbRetornarContatoCliente.Visible) And (mskHoraRetorno.Visible) Then
  Begin
    If (Not fEmptyDate(mskDataRetorno.Text)) And (fEmptyTime(mskHoraRetorno.Text)) Then
    Begin
      fMensagem('', 'A hora do retorno deve ser preenchida!', ['&OK']);
      Result := False;
    End
    Else If (Not fEmptyTime(mskHoraRetorno.Text)) Then
    Begin
      If (fEmptyDate(mskDataRetorno.Text)) Then
      Begin
        fMensagem('', 'A data de retorno deve ser preenchida!', ['&OK']);
        Result := False;
      End
      Else If (StrToDateTime(Concat(DateToStr(VS_Date), ' ', TimeToStr(fTime()))) >=
          StrToDateTime(Concat(mskDataRetorno.Text, ' ', mskHoraRetorno.Text)))  Then
      Begin
        fMensagem('', 'A data e hora deve ser maior que a data e hora atual!', ['&OK']);
        Result := False;
      End
      Else If (DaysBetween(StrToDate(mskDataRetorno.Text), fRetDataServidor) > fCfgSis('MAXAGE', varInteger)) Then
      Begin
        fMensagem('', 'O período de retorno não pode ultrapassar ' + fCfgSis('MAXAGE', varString) + ' dias!', ['&OK']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtFinaliza) And pnlFinalizacaoDoPedido.Visible Then
  Begin
    Result := (Pos(edtFinaliza.Text, 'SN') > 0);

    If Result And fCfgSis('PD_EXP', varBoolean) And
      (Not chkPedExp.Checked) And (edtFinaliza.Text = 'S') Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido "' + lblFinPed.Caption + '" igual a "S" enquanto não ' +
        'Liberar o pedido para expedição faturar !', ['&O k']);
      Result := False;
    End;

    If (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(objVenda.strNumOrc,
      objVenda.strEspOrc, objVenda.strEmpOri, objVenda.strCliAnt) > 0) Then
    Begin
      If ((blnEmitirBoletosAdiantamento) and (Result))Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido "' + lblFinPed.Caption + '" igual a "S" enquanto ' +
                              'os boletos de adiantamento estiverem pendentes de baixa pela remessa bancária !', ['&O k']);

        Result := False;
      End
      Else
      Begin
        objVenda.blnAtualizarDuplicataBoletoAdiantamento := True;
      End;

    End;

    if (Result) and (not fValidaAlterarGerarPedidosLojas) then
    begin
      fMensagem('ATENÇÃO!', 'Não é permitido "' + lblFinPed.Caption + '" igual a "N" em pedidos ' +
                            'com condição de pagamento à prazo marcado para emitir boleto de adiantamento!', ['&O k']);

      Result := False;
    end;

    If Result Then
    Begin
      objVenda.blnFinali := edtFinaliza.Text = 'S';
      If objVenda.blnFinali Then
        objVenda.blnFinaliEnabled := edtFinaliza.Enabled;
    End;
  End

  Else If (Sender = edtCodEvento) And pnlEventos.Visible Then
  begin
    If Not fEmptyStr(edtCodEvento.Text) Then
    Begin
      edtDesEvento.Text := fRetNomEventoExiFat(edtCodEvento.Text);
      If fEmptyStr(edtDesEvento.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Centro de Custo não encontrado!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      edtDesEvento.Clear;

      if fCfgSis('OBGCCF', varBoolean) then
      begin
        fMensagem('','Atenção! É obrigatório o preenchimento do campo "Centro de Custos" conforme definido na configuração CFG_OBGCCF.',['&OK']);
        Result := False
      end;
    End;
  end

  Else If (Sender = edtCodEmpFat) And pnlEmpFat.Visible Then
  begin
    edtDesEmpFat.Text := fRetNomeEmpresa(edtCodEmpFat.Text);

    If Not fEmptyStr(edtCodEmpFat.Text) Then
    Begin
      If fEmptyStr(edtDesEmpFat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'A Empresa de Faturamento deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  end

  Else If (Sender = edtCodCategoria) And pnlCategoria.Visible Then
  Begin

    If Not fEmptyStr(edtCodCategoria.Text) Then
    Begin

      edtDesCat.Text := fRetDescCatego(edtCodCategoria.Text, objVenda.strEspDoc);

      If fEmptyStr(edtDesCat.Text) Then
      Begin
        fMensagem('', 'Categoria não encontrada!', ['&Ok']);
        edtDesCat.Clear;
        Result := False;
      End;

    End
    Else
    Begin

      fMensagem('', 'Categoria não informada!', ['&Ok']);
      Result := False;

      If edtDesCat.CanFocus Then
        pSetFocus(edtDesCat);

    End

  End
  Else If (Sender = edtCliTop) And (pnlTipOpe.Visible) And (edtTipOpe.Text = 'R') Then
  Begin
    If Not fEmptyStr(edtCliTop.Text) Then
    Begin
      edtNclTop.Text := fRetNomCliente(edtCliTop.Text);

      If fEmptyStr(edtNclTop.Text) Then
      Begin
        fMensagem('', 'Cliente Remessa não informado!', ['&Ok']);
        edtNclTop.Clear;
        Result := False;
      End;

    End
    Else
    Begin
      fMensagem('', 'Cliente Remessa não informado!', ['&Ok']);
      Result := False;
    End;

  End;

  If Result And Not blnIniciandoTela Then
    pCalcularTotalPedido();

  If Not Result Then
    pSetFocus(Sender);

end;

function TfraDadosFechamentoPedidoFrame.fValidaAlterarGerarPedidosLojas: Boolean;
begin
  Result := True;

  if (edtFinaliza.Text = 'S') then
    Exit;

  if (fStatusCndPag(objVenda.strConPag) <> A_PRAZO) then
    Exit;

  if (not blnEmitirBoletosAdtFecPD) then
    Exit;

  Result := False;
end;

function TfraDadosFechamentoPedidoFrame.fVerificaTipFatPerfilCondicao: Boolean;
  Var
    strTipFat: String;
begin
  If fEmptyStr(objVenda.strCodCnd) Then
  Begin
    Result := True;
    Exit;
  End;

  strTipFat := fCampoTabela('CND_TIPFAT', 'CADCND', ['CND_CODIGO'], [objVenda.strCodCnd]);
  Result := Pos(edtTipFat.Text , strTipFat) > 0;
end;

procedure TfraDadosFechamentoPedidoFrame.edtCliTopExit(Sender: TObject);
begin
  If Not fTipoOperacaoRemessaContaOrdemSelecionada Then
  Begin
    edtCliTop.Clear;
    edtNclTop.Clear;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.edtCliTopKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel    : TConsultasArray;
  objfrmPnl : TPanelCxClientes;
begin
  If Not fTipoOperacaoRemessaContaOrdemSelecionada Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    Try
      objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
      Try
        objfrmPnl.strNomForm := GetParentForm(Self).Name;
        If fPesqCliente(conCliCompleta, GetParentForm(self) as TForm, edtCliTop, edtNclTop, qryCliTop,
                        Key, arrSel, True, objfrmPnl) then
        Begin
          If (fValidaCampos(edtCliTop, True)) Then
            Self.SelectNext(GetParentForm(Self).ActiveControl, True, True);
        End
        Else
          pPesquisaCadCli(qryCliTop, qryCliTop, edtCliTop.Text);
      Finally
        FreeAndNil(objfrmPnl);
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[edtCliTopKeyPress]');
    End;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.edtCodCategoriaKeyPress(Sender: TObject; var Key: Char);
var
  arrCategorias : TConsultasArray;
begin

  if fPesqCategoriaOrPd(GetParentForm(self) as TForm, edtCodCategoria, edtDesCat, qryCadCat, Key, arrCategorias, True, objVenda.strEspDoc) then
  begin
    If fValidaCampos(edtCodCategoria, True) Then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  end;

end;

procedure TfraDadosFechamentoPedidoFrame.edtCodPrjKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPrj : TConsultasArray;
begin
  If fPesqProjetos(GetParentForm(self) as TForm, edtCodPrj, edtDesPrj, qryCadPrj, Key, arrPrj, True, objVenda.strCodcli) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.edtCodTpaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTpaAte: TConsultasArray;
begin
  inherited;
  {****************************************}
  {* NOVA CONSULTA DE TIPO DE ATENDIMENTO *}
  {*************************************MM*}
  If fPesqTipoAtendimento(GetParentForm(self) as TForm, edtCodTpa, edtDesTpa, Nil, Key, arrTpaAte) Then
  Begin
    if fValidaCampos(edtCodTpa, True) then
      SelectNext(GetParentForm(self).ActiveControl, True, True);
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.pCalculaTotalBombeamento;
begin

  {Valores já calculados na frmFatDigDadosConcreto,
   quando opção J_A_MASSA_CONCRETO}
  If (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
  Begin
    objVenda.fltQtdBom := 0.0;
    objVenda.fltPrcBom := 0.0;
    objVenda.fltTotBom := 0.0;
  End;

  If pnlBombeamento.Visible Then
  Begin
    If objVenda.tbIteBom = tbItemBombeamento Then
    Begin
      objVenda.fltQtdBom := fStrToFloat(edtQtdBom.Text);
      objVenda.fltPrcBom := fStrToFloat(edtPrcBom.Text);
      objVenda.fltTotBom := fFormataFloat(objVenda.fltQtdBom * objVenda.fltPrcBom, 2);

      edtTotBom.Text := FormatFloat('#,##0.00', objVenda.fltTotBom);
    End
    Else
    Begin
      objVenda.fltQtdBom := fStrToFloat(edtQtdBom.Text);
      objVenda.fltTotBom := fStrToFloat(edtTotBom.Text);

      If objVenda.fltQtdBom <> 0 Then
        objVenda.fltPrcBom := fFormataFloat(objVenda.fltTotBom / objVenda.fltQtdBom, objVenda.VS_intDecUni)
      Else
        objVenda.fltPrcBom := 0.0;

      edtPrcBom.Text := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.fltPrcBom);
    End;
  End;
  pCalcularTotalPedido('Calculando valor total bombeamento');
end;

procedure TfraDadosFechamentoPedidoFrame.edtPesLiqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key, ['-']) Then
  Begin
    Key := #0;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.edtPorPedKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples, GetParentForm(self) as TForm, edtPorPed, edtNomPorPed, qryConPor, Key, arrSel, True,
                     'Consulta de Portadores', 'S') then
    Begin
      If fValidaCampos(edtPorPed, True) Then
        SelectNext(edtPorPed, True, True);
    End;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.edtQtdBomExit(Sender: TObject);
begin
  inherited;
  pCalculaTotalBombeamento;
end;

procedure TfraDadosFechamentoPedidoFrame.edtQtdTraKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key, [',', '.', '-']) Then
  Begin
    Key := #0;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.edtTipFatChange(Sender: TObject);
begin
  inherited;
  If Assigned(pHabilitarFatorParaFaturamento) Then
    If Not pnlTipoDeFaturamento.Visible Then
      pHabilitarFatorParaFaturamento('')
    Else
      pHabilitarFatorParaFaturamento(edtTipFat.Text);

  pSetarFinalidade(edtTipFat.Text);

  If (objVenda.strCliDAc = 'S') And (Pos(objVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
    If Assigned(pCarregarDespesasAcessorias) Then
      pCarregarDespesasAcessorias(edtTipFat.Text);
end;

procedure TfraDadosFechamentoPedidoFrame.edtTipOpeChange(Sender: TObject);
begin
  edtCliTop.Clear;
  edtNclTop.Clear;
end;

procedure TfraDadosFechamentoPedidoFrame.edtTipOpeExit(Sender: TObject);
begin
  inherited;
  If (blnPermitirEmissaoBR) And (SameText(edtTipOpe.Text, 'B')) Then
    lblTipFat.Caption := '(A) - Nota Fiscal    (B) - BR'
  Else If (SameText(edtTipOpe.Text, 'B')) Then
    lblTipFat.Caption := '(A) - Nota Fiscal'
  Else If (blnPermitirEmissaoFF) Then
    lblTipFat.Caption := '(A) - Nota Fiscal    (B) - FF    (C) - Cupom Fiscal'
  Else
    lblTipFat.Caption := '(A) - Nota Fiscal    (C) - Cupom Fiscal';

  If fCfgSis('SOLFNE', varBoolean) And (objVenda.strEspDoc = 'PD') Then
    lblTipFat.Caption := lblTipFat.Caption + '  (D) - Divisível';

  lblTipFat.Repaint;
end;

function TfraDadosFechamentoPedidoFrame.fFinalidade: TFinalidadeDocumento;
begin
  Result := TFinalidadeDocumento(cmbFinalidade.ItemIndex);
end;

function TfraDadosFechamentoPedidoFrame.fFinalidadeDoPedidoCoerenteComTipoDeFaturamento: Boolean;
begin
  Result := True;

  If (pnlOpcoesPV.Visible) And (pnlTipoDeFaturamento.Visible) Then
  Begin
    If (fFinalidade = tfdCupomFiscal) And (edtTipFat.Text <> 'C') Then
    Begin
      pMensagemOk('Não é permitido finalidade do pedido para Cupom Fiscal quando Tipo de Faturamento não for Cupom Fiscal.');
      Result := False;
    End

    Else If (fFinalidade = tfdNotaFiscal) And (edtTipFat.Text = 'C') Then
    Begin
      pMensagemOk('Não é permitido finalidade do pedido para Nota Fiscal quando Tipo de Faturamento for Cupom Fiscal.');
      Result := False;
    End;
  End;
end;

function TfraDadosFechamentoPedidoFrame.fPermiteEntregaComCupomFiscal: Boolean;
begin
  Result := True;
  if (Not objVenda.fPermiteFreteNoCupomFiscal)  then
  begin
    if (objVenda.fltValFre > 0.0) then
    begin
      Result := False;
    end
    else
    if (objVenda.fRetValItemFrete > 0.0) then
    begin
      Result := False;
    end;
  end;
end;

procedure TfraDadosFechamentoPedidoFrame.pMostrarPanelTipFat;
  Var
    blnEntrega_CD: Boolean;
    blnTpdCexMat: Boolean;
    strEmpCfg: String;
begin
  If objVenda.strEspDoc = 'OR' Then
  Begin
    edtTipFat.Text := '';
    pnlTipoDeFaturamento.Visible := False;
    Exit;
  End;

  blnEntrega_CD := objVenda.blnEnt_CD;

  blnTpdCexMat := True;
  If (blnEntrega_CD) And (objVenda.strEspDoc = 'PD') Then
  Begin
    strEmpCfg := fCfgSis('EMP_CD');
    blnTpdCexMat := (fCfgSis('TPDCEX', varString, strEmpCfg) = '2');
  End;

  If (
       ( (Pos(VS_strTipExp, '3_4_5_') <= 0) And (blnTpdCexMat)) Or
       ( (Pos(VS_strTipExp, '3_4_5_') > 0)  And (fCfgSis('TPDCEX') = '2') )
     )   {Se for pedido com itens de entrega CD e cliente filial deve pedir o tipo de faturamento}
     And (Not (objVenda.fSomenteItensParaEmpresasCD And objVenda.blnCliFil)) And
     (Not fPermiteDefinirTipoDeFaturamentoNoPedidoMesmoUsandoExpedicaoPorDocumentoFaturado) Then
  Begin
    edtTipFat.Text    := '';
    pnlTipoDeFaturamento.Visible := False;
  End
  Else
  Begin
    edtTipFat.Text := fRetTipFat;

    If Not fCfgSis('SOLFNE', varBoolean) Then
    Begin
      If edtTipFat.Text = 'D' Then
        edtTipFat.Text := '';
    End;

    If (Not blnPermitirEmissaoFF) And (edtTipOpe.Text <> 'B') And (edtTipFat.Text = 'B') Then
      edtTipFat.Text := '';

    If (Not blnPermitirEmissaoBR) And (edtTipOpe.Text = 'B') And (edtTipFat.Text = 'B') Then
      edtTipFat.Text := '';

    pnlTipoDeFaturamento.Visible := True;
    edtTipFatChange(edtTipFat);
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.pOnShow;
begin
  inherited;

  pPrepararExibicaoRetornoAoCliente;
  btnPedCmp.Visible := (objVenda.strEspDoc = 'PD') Or (objVenda.strEspDoc = 'OR');

  {Req: 101586: Validade - Para "Orçamento" ou "Venda Normal" que grave ou carregue "Orçamento"}
  If (objVenda.strOpcDoc = 'OR') Or ((objVenda.strOpcDoc = 'VN') And (objVenda.strEspDoc = 'OR')) Then
    lblValidade.Visible := fCfgSis('IFVLOR', varBoolean);

  edtValidade.Visible := lblValidade.Visible;

  If edtValidade.Visible Then
  Begin
    If objVenda.dtaValOrc = 0 Then
    Begin
      edtValidade.Text := DateToStr(objVenda.dtaGraPed + fCfgSis('ORCVEN', varInteger));
      edtValidade.Enabled := (StrToDate(edtValidade.Text) > VS_Date);
    End
    Else
    Begin
      edtValidade.Text := DateToStr(objVenda.dtaValOrc);
      edtValidade.Enabled := ((StrToDate(edtValidade.Text) < VS_Date) And
                             (objVenda.dtaGraPed + fCfgSis('ORCVEN', varInteger) > VS_Date)) Or
                             (objVenda.dtaValOrc <> objVenda.dtaValOrcOri);
    End;
  End;

  chkPedExp.Visible := fCfgSis('PD_EXP', varBoolean);

  chkAgrIte.Visible := fCfgSis('AGRITE', varBoolean) And (Pos(objVenda.strEspDoc, 'PD_OR_') > 0);
  chkAgrIte.Checked := chkAgrIte.Visible And fCfgSis('DEFAGR', varBoolean);

  pMostrarPanelTipFat;

  dtaDtaLim := fRetDataLimite;

  blnBonPed := fCfgSis('BONPED', varBoolean);
  blnPcoOrd := fCfgSis('PCOORD', varBoolean);
  blnPedAmo := fCfgSis('PEDAMO', varBoolean);
  blnPerDem := fCfgSis('PERDEM', varBoolean);
  blnPedUco := fCfgSis('PEDUCO', varBoolean);
  blnRemCod := fCfgSis('HBFPRC', varBoolean);
  blnVenExp := fCfgSis('HOPEEP', varBoolean);

  If (pnlGerPen.Visible) Then
  Begin
    If fEmptyStr(objVenda.strGerPen) Then
      edtGerPen.Text := fCfgSis('GERPEN', varString) //Sugestao
    Else
      edtGerPen.Text := objVenda.strGerPen;
  End;

  chkEntUrg.Checked := objVenda.strEntUrg = 'S';
  chkPedExp.Checked := objVenda.strPD_Exp = 'S';

  pnlCategoria.Visible := False;

  If ((fCfgSis('UTICAO', varBoolean)) And (objVenda.strEspDoc = 'OR')) Or
     ((fCfgSis('UTICAP', varBoolean)) And (objVenda.strEspDoc = 'PD')) Then
  Begin
    pnlCategoria.Visible := True;
  End;

  If Not pnlCategoria.Visible Then
    pnlCategoria.Parent.Height := pnlCategoria.Parent.Height - pnlCategoria.Height;

  If pnlCategoria.Visible Then
  Begin
    If Not fEmptyStr(objVenda.strCodCat) Then
    Begin
      edtCodCategoria.Text := objVenda.strCodCat;
      fValidaCampos(edtCodCategoria);
    End;
  End;

  pnlEventos.Visible := fCfgSis('EVEFAT', varBoolean);
  if not pnlEventos.Visible then
    pnlEventos.Parent.Height := pnlEventos.Parent.Height - pnlEventos.Height;

  if pnlEventos.Visible then
  begin
    if not fEmptyStr(objVenda.strCodEve) then
    begin
      edtCodEvento.Text := objVenda.strCodEve;
      edtDesEvento.Text := fRetNomEvento(edtCodEvento.Text);
    end;
  end;

  pnlEmpFat.Visible := (objVenda.strEspDoc = 'PD') And fCfgSis('FATSSA', varBoolean);
  If Not pnlEmpFat.Visible Then
    pnlEmpFat.Parent.Height := pnlEmpFat.Parent.Height - pnlEmpFat.Height;

  If pnlEmpFat.Visible Then
  Begin
    If fTemEmpFaturamentoSemSaldo Then
      edtCodEmpFat.Text := objVenda.strEmpFatSemSaldo
    Else If (Length(objVenda.strCliCgc) > 11) Then
      edtCodEmpFat.Text := fCfgSis('SSAEPJ')
    Else
      edtCodEmpFat.Text := fCfgSis('SSAEPF');

    If Not fEmptyStr(edtCodEmpFat.Text) Then
      edtDesEmpFat.Text := fRetNomeEmpresa(edtCodEmpFat.Text);
  End;

  pnlTipOpe.Visible := SameText(objVenda.strEspDoc, 'PD');
  edtTipOpe.Text := 'V';
  cblTipOpe1.Visible := blnBonPed and pnlTipOpe.Visible;
  cblTipOpe2.Visible := blnPcoOrd and pnlTipOpe.Visible;
  cblTipOpe3.Visible := blnPedAmo and pnlTipOpe.Visible;
  cblTipOpe4.Visible := blnPerDem and pnlTipOpe.Visible;
  cblTipOpe5.Visible := blnPedUco and pnlTipOpe.Visible;
  cblTipOpe6.Visible := blnVenExp and pnlTipOpe.Visible;
  cblTipOpe7.Visible := blnRemCod and pnlTipOpe.Visible;

  If (Not blnRemCod) Then
  Begin
    pnlClienteTipoOperacao.Visible := False;
    pnlClienteTipoOperacao.Enabled := False;

    pnlTipOpe.Height := pnlTipOpe.Height
                      - pnlClienteTipoOperacao.Height;

    pnlTipOpe.Parent.Height := pnlTipOpe.Parent.Height
                             - pnlClienteTipoOperacao.Height;
  End;

  If (cblTipOpe1.Visible) or (cblTipOpe2.Visible) or (cblTipOpe3.Visible) or 
     (cblTipOpe4.Visible) or (cblTipOpe5.Visible) or (cblTipOpe6.Visible) or
     (cblTipOpe7.Visible) Then
  Begin
    edtTipOpe.Text := objVenda.strTipOpe;

    If fTipoOperacaoRemessaContaOrdemSelecionada Then
    Begin
      edtCliTop.Text := objVenda.strCliTop;
      fValidaCampos(edtCliTop);
    End;
  End;

  If Not pnlTipOpe.Visible Then
    pnlTipOpe.Parent.Height := pnlTipOpe.Parent.Height - pnlTipOpe.Height;

  If Pos(VS_strTipExp, '3_4_5_') > 0 Then
  Begin

    If (fEmptyStr(objVenda.strTipPed) And (fCfgSis('TPDCEX') = '1')) Then
    Begin
      edtTipFat.Text := fRetTipFat;

      If Not fCfgSis('SOLFNE', varBoolean) Then
      Begin
        If edtTipFat.Text = 'D' Then
          edtTipFat.Text := '';
      End;

      If (Not blnPermitirEmissaoFF) And (edtTipOpe.Text <> 'B') And (edtTipFat.Text = 'B') Then
        edtTipFat.Text := '';

      If (Not blnPermitirEmissaoBR) And (edtTipOpe.Text = 'B') And (edtTipFat.Text = 'B') Then
        edtTipFat.Text := '';

      If objVenda.strEspDoc = 'OR' Then
        edtTipFat.Text := '';
    End
    Else
      edtTipFat.Text := objVenda.strTipPed;

  End;

  If Assigned(pCarregarDespesasAcessorias) Then
    pCarregarDespesasAcessorias(edtTipFat.Text);

  edtCliCtt.Text := fRetNomContatoCliente(objVenda.strCliCtt);

  If fCfgSis('AUTCTT', VarBoolean) And (Not fEmptyStr(objVenda.strCliCtt)) Then
  Begin
    btnPesquisarContato.Enabled := False;
    btnAdicionarContato.Enabled := False;
  End;

  pnlTipAte.Visible := fExibirTipoAtendimento;

  If Not pnlTipAte.Visible Then
    pnlTipAte.Parent.Height := pnlTipAte.Parent.Height - pnlTipAte.Height;

  If fCfgSis('SOLFNE', varBoolean) And (objVenda.strEspDoc = 'PD') Then
    lblTipFat.Caption := lblTipFat.Caption + '  (D) - Divisível';

  If pnlTipAte.Visible And
     fEmptyStr(objVenda.strNumOrc) And
     fEmptyStr(objVenda.strCodTpA) Then
  Begin
    objVenda.strCodTpA := fCfgSis('SUGTPA');
  End;

  If Not fEmptyStr(objVenda.strCodTpA) Then
  Begin
    edtCodTpa.Text := objVenda.strCodTpA;
    fValidaCAmpos(edtCodTpa);

    If pnlTipAte.Visible Then
    Begin
      If (Not fEmptyStr(objVenda.strNumOrc)) And
         (Not fEmptyStr(edtDesTpa.Text)) And
         (Not fVerificaAcessoSistema('mnuAlteracaoTipoAtendPed')) Then
      Begin
         edtCodTpa.Enabled := False;
         edtCodTpa.Color   := edtDesTpa.Color;
      End;
    End;
  End;

  pnlPorPed.Visible := fCfgSis('PORPED', VarBoolean) And (objVenda.strEspDoc = 'PD');

  If Not pnlPorPed.Visible Then
    pnlPorPed.Parent.Height := pnlPorPed.Parent.Height - pnlPorPed.Height;

  objVenda.pHabilitarPortadorPedido(pnlPorPed, edtPorPed, edtNomPorPed);

  pnlOpcoesPV.Visible := False;
  cmbFinalidade.ItemIndex := -1;
  If (fCfgSis('PAFECF', varBoolean)) Then
  Begin
    pnlOpcoesPV.Visible := True;
  End;

  If Not pnlOpcoesPV.Visible Then
    pnlOpcoesPV.Parent.Height := pnlOpcoesPV.Parent.Height - pnlOpcoesPV.Height;

  pnlProjeto.Visible := TProjeto.fClienteTemProjetoAtivo(objVenda.strCodCli);
  If Not pnlProjeto.Visible Then
    pnlProjeto.Parent.Height := pnlProjeto.Parent.Height - pnlProjeto.Height;

  If pnlProjeto.Visible Then
  Begin
    If Not fEmptyStr(objVenda.strCodPrj) Then
    Begin
      edtCodPrj.Text := objVenda.strCodPrj;
      fValidaCampos(edtCodPrj);
    End;
  End;

  pSetarFinalidade(edtTipFat.Text);

  If (objVenda.blnGravarDavPv) Then
  Begin
    If (Not objVenda.blnHerancaOrcamentoPedido) Then
    Begin
      cmbFinalidade.ItemIndex := Integer(tfdCupomFiscal);
    End;
  End
  Else If (Not fEmptyStr(objVenda.strNumOrc)) Then
  Begin
    cmbFinalidade.ItemIndex := Integer(tfdNotaFiscal);
  End;

  pnlBombeamento.Visible := objVenda.blnTaxaBombeamentoPedOrc;

  edtPrcBom.EditFormat := fMskDigitos(objVenda.VS_intDecUni);

  If objVenda.blnTaxaBombeamentoPedOrc And Not fEmptyStr(objVenda.strNumOrc) Then
    objVenda.pCarregaTaxaBombeamentoPedOrc;

  If (objVenda.fltQtdBom > 0) And
     (objVenda.fltPrcBom > 0) And
     (objVenda.fltTotBom > 0) And
     (pnlBombeamento.Visible) Then
  Begin
    edtPrcBom.Text    := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), objVenda.fltPrcBom);
    edtQtdBom.Text    := FormatFloat('#,##0.00', objVenda.fltQtdBom);
    edtTotBom.Text    := FormatFloat('#,##0.00', objVenda.fltTotBom);

    {Não vai ter taxa mínima na JA!}
    If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
    Begin
      chkTaxMin.Checked := False;
      chkTaxMin.Visible := False;
      objVenda.tbIteBom := tbItemBombeamento;
    End
    Else
      chkTaxMin.Checked := IIF(objVenda.tbIteBom = tbTaxaMinima, True, False);

  End
  Else
    objVenda.tbIteBom := tbItemBombeamento;

  If objVenda.blnTaxaBombeamentoPedOrc Then
  Begin
    edtTipFat.Enabled := False;
    edtTipFat.Text    := 'A';
  End;

  objVenda.pExibirPanelFinalizacaoPedido(pnlFinalizacaoDoPedido, lblFinPed, edtFinaliza, '', blnEmitirBoletosAdtFecPD);

  If pnlBombeamento.Visible Then
    pCalculaTotalBombeamento
  Else If Not objVenda.fExecutandoNovoFechamentoOrcamentoPedidoCndPagFinal Then
    pCalcularTotalPedido;

  If Not fVerificaAcessoSistema('ALTFNE') Then
    edtTipFat.Enabled := False;

  If (objVenda.blnCliFil) And (fRetornaClienteFilial(VS_strCodEmp) = objVenda.strCodCli) Then
    lblFinPed.Caption := 'Finalizar o ' + IIF(objVenda.strEspDoc = 'PD', 'Pedido', 'Orçamento') + ' e gerar a solicitação de abastecimento para as lojas?';
end;

procedure TfraDadosFechamentoPedidoFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.pSetaDadosRetornoContatoCliente;
begin
  If (Not gpbRetornarContatoCliente.Visible) Then
    Exit;

  objVenda.dtaDtaAgeRet := StrToDateDef(mskDataRetorno.Text, 0);

  If (mskHoraRetorno.Visible) Then
    objVenda.horHorAgeRet := StrToDateTimeDef(mskHoraRetorno.Text, 0);
end;

procedure TfraDadosFechamentoPedidoFrame.pSetarFinalidade(strTipFat: String);
begin
  If (pnlOpcoesPV.Visible) And (cmbFinalidade.Visible) Then
  Begin
    If (strTipFat = 'A') Then
      cmbFinalidade.ItemIndex := Integer(tfdNotaFiscal)
    Else If (strTipFat = 'C') Then
      cmbFinalidade.ItemIndex := Integer(tfdCupomFiscal);
  End;
end;

procedure TfraDadosFechamentoPedidoFrame.pMostraAlertaPDVCitel;
begin
  lblPdvAlt.Visible:=(pnlTipoDeFaturamento.Enabled) And (pnlTipoDeFaturamento.Visible) And
    (pnlOpcoesPV.Visible) And (fFinalidade = tfdCupomFiscal) And (edtTipFat.Text = 'C') And (fCfgSis('PAFECF', varBoolean));
end;

procedure TfraDadosFechamentoPedidoFrame.edtCodEmpFatKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmpresa: TConsultasArray;
begin
  If fEntraCons(Key) Then
  begin
    If fPesqEmpresa(conEmpSimples, GetParentForm(Self) As TForm, edtCodEmpFat, edtDesEmpFat, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(edtCodEmpFat, True) Then
        SelectNext(GetParentForm(Self).ActiveControl, True, True);
    End;
  end;
end;

procedure TfraDadosFechamentoPedidoFrame.edtCodEventoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEvento: TConsultasArray;
begin
  If fEntraCons(Key) Then
  begin
    If fPesqEventos(GetParentForm(self) as TForm, edtCodEvento, edtDesEvento, Nil, Key, arrEvento, True, True) Then
    Begin
      If fValidaCampos(edtCodEvento, True) Then
        SelectNext(GetParentForm(self).ActiveControl, True, True);
    End;
  end;
end;

procedure TfraDadosFechamentoPedidoFrame.pValidaDireitoAcessoEntUrg;
var
  objLiberacao: TLiberacao;
  strUrgente: String;
begin
  if (FblnLibEntUrgente) or ((objVenda.strEspDoc <> 'PD') and (objVenda.strEspDoc <> 'OR')) then
    Exit;

  FblnLibEntUrgente := True;

  if not fVerificaAcessoSistema('ALTURGPD', strLoginUsuarioLogado) then
  begin
    objLiberacao := TLiberacao.Create;
    try
      if chkEntUrg.Checked then
        strUrgente := 'MARCAR'
      else
        strUrgente := 'DESMARCAR';

      objLiberacao.objMsgLibera.pAddTexto('Operador sem permissão para alterar opção "Urgente" no Orçamento/Pedido de venda');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('Solicitação de liberação para ' + strUrgente + ' opção "Urgente"');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.strDirAce  := 'ALTURGPD';
      objLiberacao.strSenLib  := fCfgSis('SENLBD');
      objLiberacao.strMsgSen  := 'Alteração de opção "Urgente" no pedido de venda';
      objLiberacao.strCodOpe  := strLoginUsuarioLogado;
      objLiberacao.strCliente := objVenda.strCodCli + '-' + objVenda.strCliNom;
      objLiberacao.strCpfCnpj := objVenda.strCliCgc;

      FblnLibEntUrgente := objLiberacao.fLibera;

      if not FblnLibEntUrgente then
        pVoltarOpcaoEntUrg;
    finally
      FreeAndNil(objLiberacao);
    end;
  end;
end;

procedure TfraDadosFechamentoPedidoFrame.pVoltarOpcaoEntUrg;
var
  ntfCheckBox: TNotifyEvent;
begin
  ntfCheckBox := chkEntUrg.OnClick;
  chkEntUrg.OnClick := nil;
  chkEntUrg.Checked := not chkEntUrg.Checked;
  chkEntUrg.OnClick := ntfCheckBox;
end;

end.
