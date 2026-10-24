unit untFatAltCondPagtoPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, DB,
  Uni, BitBtnLockedIncrem, Mask, MaskEditFocus,
  cxProgressBar, TypInfo, Faturamento.Classes.TAlterarPedido,
  Faturamento.Classes.TValidarVenda, frxClass, frxExportCSVTestabilidade,
  untLiberacao;

type
  TfrmFatAltCondPagtoPedido = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlBusca: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    pnlForPagAtu: TPanel;
    lbl7: TLabel;
    edtForPagAtu: TEditFocus;
    edtDesFpgAtu: TEditFocus;
    pnl2: TPanel;
    lbl8: TLabel;
    edtCodCndAtu: TEditFocus;
    mskCndPagAtu: TMaskEditFocus;
    edtDesCndAtu: TEditFocus;
    pnl3: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtCodCli: TEditFocus;
    edtDtaEnt: TEditFocus;
    edtDesCli: TEditFocus;
    edtValDocAtu: TEditFocus;
    pnlCondicao: TPanel;
    pnlCndPag: TPanel;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    mskCndPag: TMaskEditFocus;
    edtDesCnd: TEditFocus;
    pnlForPag: TPanel;
    lbl17: TLabel;
    edtForPag: TEditFocus;
    edtDesFpg: TEditFocus;
    pnl4: TPanel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    edtValDoc: TEditFocus;
    edtDtaVen01: TMaskEditFocus;
    edtDtaVen02: TMaskEditFocus;
    edtSeq2: TEditFocus;
    edtValPar01: TEditFocus;
    edtValPar02: TEditFocus;
    edtPar1: TEditFocus;
    edtDtaVen03: TMaskEditFocus;
    edtDtaVen04: TMaskEditFocus;
    edt7: TEditFocus;
    edtValPar03: TEditFocus;
    edtValPar04: TEditFocus;
    edt10: TEditFocus;
    edtDtaVen05: TMaskEditFocus;
    edtDtaVen06: TMaskEditFocus;
    edt11: TEditFocus;
    edtValPar05: TEditFocus;
    edtValPar06: TEditFocus;
    edt14: TEditFocus;
    edtDtaVen07: TMaskEditFocus;
    edtDtaVen08: TMaskEditFocus;
    edt15: TEditFocus;
    edtValPar07: TEditFocus;
    edtValPar08: TEditFocus;
    edt18: TEditFocus;
    edtDtaVen09: TMaskEditFocus;
    edtDtaVen10: TMaskEditFocus;
    edt19: TEditFocus;
    edtValPar09: TEditFocus;
    edtValPar10: TEditFocus;
    edt22: TEditFocus;
    edtDtaVen11: TMaskEditFocus;
    edtDtaVen12: TMaskEditFocus;
    edt23: TEditFocus;
    edtValPar11: TEditFocus;
    edtValPar12: TEditFocus;
    edt26: TEditFocus;
    lbl3: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    lbl20: TLabel;
    edtTotRec: TEditFocus;
    lbl21: TLabel;
    edtTotCtr: TEditFocus;
    btnCalcTotPed: TBitBtnLocked;
    tmrRecalcular: TTimer;
    EditFocus5: TEditFocus;
    edtDtaVen16: TMaskEditFocus;
    edtValPar16: TEditFocus;
    edtValPar15: TEditFocus;
    edtDtaVen15: TMaskEditFocus;
    EditFocus8: TEditFocus;
    EditFocus1: TEditFocus;
    edtDtaVen14: TMaskEditFocus;
    edtValPar14: TEditFocus;
    edtValPar13: TEditFocus;
    edtDtaVen13: TMaskEditFocus;
    EditFocus4: TEditFocus;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    EditFocus12: TEditFocus;
    edtDtaVen17: TMaskEditFocus;
    edtValPar17: TEditFocus;
    EditFocus9: TEditFocus;
    edtDtaVen18: TMaskEditFocus;
    edtValPar18: TEditFocus;
    EditFocus16: TEditFocus;
    edtDtaVen19: TMaskEditFocus;
    edtValPar19: TEditFocus;
    EditFocus13: TEditFocus;
    edtDtaVen20: TMaskEditFocus;
    edtValPar20: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EditFocus20: TEditFocus;
    edtDtaVen21: TMaskEditFocus;
    edtValPar21: TEditFocus;
    edtValPar22: TEditFocus;
    edtDtaVen22: TMaskEditFocus;
    EditFocus17: TEditFocus;
    EditFocus24: TEditFocus;
    edtDtaVen23: TMaskEditFocus;
    edtValPar23: TEditFocus;
    edtValPar24: TEditFocus;
    edtDtaVen24: TMaskEditFocus;
    EditFocus21: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure mskCndPagEnter(Sender: TObject);
    procedure mskCndPagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskCndPagKeyPress(Sender: TObject; var Key: Char);
    procedure edtForPagKeyPress(Sender: TObject; var Key: Char);
    procedure btnCalcTotPedClick(Sender: TObject);
    procedure edtCodCndChange(Sender: TObject);
    procedure tmrRecalcularTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    intSemaforoConsulta: Integer;
    intSemaforoValidar : Integer;

    objAltCnd: TAlterarPedido;

    stlForPag: TStringList;
    stlCndPag: TStringList;

    strCcnAnt: String;
    strCndAnt: String;
    strFpgAnt: String;
    strFpgLib: String;

    strUltCodCndRecalculado: String;
    strCodCndAnt: String;
    strConLib: String;
    strCndLib: String;

    objLiberacao : TLiberacao;

    FCondicaoPixJaLiberada: Boolean;

    blnTravaNaoCompra: Boolean;

    procedure pLimpaTela;
    procedure pAtualizaDadosPedido;
    procedure pAtualizaTotais;

    procedure pEnfaseBotaoRecalcular;
    function  fCarregaCondicao: Boolean;

    function ValidarModificacoesPix: Boolean;
    procedure pCarregaDespesasAcessorias;
    function fVerificaLimiteCredito(): Boolean;
  public
    { Public declarations }

    strUltimoPedido: String;
    blnLiberaPedido: Boolean;
    strNumPedLib: string;
    strCodEmpLib: string;
    blnAlterouFormaPagamento: Boolean;
    blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;

  end;

var
  frmFatAltCondPagtoPedido: TfrmFatAltCondPagtoPedido;

implementation

uses StrUtils, untConsultas, untPanelCxPedOrc, System.UITypes, untTypesSistema,
  untPnlDadosPedOrc, untFuncoes,
  untConstantes, untFuncoesSimples, untFuncFat, untAdiantamentoClienteGenerico,
  untTFuncoesPixAutcom, untTPixDao, untTiposPix;

{$R *.dfm}

function TfrmFatAltCondPagtoPedido.ValidarModificacoesPix: Boolean;
  Var
    LStatusPix: String;
begin
  Result := Not objAltCnd.objVenda.DadosPixDaVenda.AlterarCondicaoDePagamento;
  If Result Then
    Exit;

  LStatusPix :=  TPixDao.RetornaStatusSePedidoPossuirPix(objAltCnd.objVenda.DadosPixDaVenda.EmpresaDoPix,
                                                         objAltCnd.objVenda.DadosPixDaVenda.TxIdPix);

  Result := LStatusPix.IsEmpty;
  If Result Then
    Exit;

  Result := MatchStr(LStatusPix, STATUS_PIX_ATIVO);

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Não é permitido alterar um pedido que possui Pix que já foi pago!', ['&Ok']);

    Exit;
  End;

  Result := Not TPixDao.PixGeradoEmPedidosDesmembrados(objAltCnd.objVenda.DadosPixDaVenda.EmpresaDoPix,
                                                       objAltCnd.objVenda.DadosPixDaVenda.TxIdPix);
  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Não é permitido alterar um pedido desmembrado que possui Pix ativo!', ['&Ok']);

    Exit;
  End;

  Result :=  fMensagem('ATENÇÃO', 'Esse pedido possui um Pix gerado ao cliente e ainda ativo. ' +
                                  'O pedido só poderá ser alterado para uma condição de pagamento que não utilize Pix.' + #13 +
                                  'Deseja continuar?', ['&Sim', '&Não'], 2) = 1;
  If Not Result Then
    Exit;

  objLiberacao.Clear;

  objLiberacao.objMsgLibera.pAddTexto('Permitir alterar a condição de pagamento de um pedido com Pix gerado e ativo.');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTexto('O pedido de venda ' + objAltCnd.objVenda.strNumDoc + '-' +
                                      'PD' + '-' + objAltCnd.objVenda.strEmpDoc);
  objLiberacao.objMsgLibera.pAddTexto('possui um Pix gerado ao cliente e ainda ativo.');

  objLiberacao.strSenFvu := 'V';

  objLiberacao.strDirAce := 'ALTPEDPIXATV';
  objLiberacao.strMsgSen := 'Permitir alterar a condição de pagamento de um pedido com Pix gerado e ativo';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

procedure TfrmFatAltCondPagtoPedido.tmrRecalcularTimer(Sender: TObject);
begin
  inherited;
  pEnfaseBotaoRecalcular;
end;

procedure TfrmFatAltCondPagtoPedido.edtCodCndChange(Sender: TObject);
begin
  inherited;
  tmrRecalcular.Enabled := True;
end;

procedure TfrmFatAltCondPagtoPedido.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCnd: TConsultasArray;
    strCndCli: String;
begin
  If edtCodCnd.Enabled And (Not edtCodCnd.ReadOnly) Then
  Begin
    If  fEntraCons(Key) Then
    Begin
      If fCfgSis('TRACND', varBoolean) Then
        strCndCli := objAltCnd.objVenda.strCodCli
      Else
        strCndCli := EmptyStr;

      If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, nil, Key, arrCnd, True, False,
                            IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conCndSimples),
                            0, 0, strCndCli, True) Then
      Begin
        objAltCnd.pCarregaCondicao(edtCodCnd.Text, objAltCnd.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);

        If fValidaCampos(edtCodCnd, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  End;
end;

procedure TfrmFatAltCondPagtoPedido.edtForPagKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  If (Not objAltCnd.objVenda.VS_blnUsaFpg) Or edtForPag.ReadOnly Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    If fPesqFormaPgto(conFpgBaiAvi, Self, edtForPag, edtDesFpg, Nil, Key, arrForma, False) Then
    Begin
      objAltCnd.pCarregaForPag(edtForPag.Text);

      If (fValidaCampos(edtForPag, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatAltCondPagtoPedido.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
  Var
    objfrmPnl: TPanelCxPedOrc;
    arrDoc: TConsultasArray;
begin
  If InterlockedIncrement(intSemaforoConsulta) = 0 Then
  Begin
    Try
      inherited;

      If fEntraCons(Key) Then
      Begin
        objfrmPnl  := TPanelCxPedOrc.Create(TfrmPnlDadosPedOrc, 'PD');

        If fPesqPedOrc(conPedCompleta, Self, 'PD', 'PD', VS_strCodEmp,
                       edtNumDoc, edtEspDoc, edtCodEmp, objAltCnd.qryFatGor, Key, arrDoc, True, objfrmPnl) Then
        Begin
          fValidaCampos(edtNumDoc, True);
        End;

        FreeAndNil(objfrmPnl);
      End;

      InterlockedDecrement(intSemaforoConsulta);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intSemaforoConsulta);
        pMensagensErro(E.Message, '[ConsultaFaturamento]');
      End;
    End;
  End
  ELse
    InterlockedDecrement(intSemaforoConsulta);
end;

function TfrmFatAltCondPagtoPedido.fCarregaCondicao: Boolean;
begin
  Result := (Not mskCndPag.Enabled)                                            Or
            (mskCndPag.readOnly)                                               Or
            (fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text, True, True, True))) Or
            ((edtCodCndAtu.Text <> edtCodCnd.Text) And (strCcnAnt <> edtCodCnd.Text));
end;

procedure TfrmFatAltCondPagtoPedido.pAtualizaDadosPedido;
begin
  With objAltCnd.objVenda Do
  Begin
    edtCodCli.Text    := strCodCli;
    edtDesCli.Text    := strCliNom;
    edtDtaEnt.Text    := IIF(dtaDtaEnt > 0, FormatDateTime('DD/MM/YYYY', dtaDtaEnt), '');
    edtCodCnd.Text    := strCodCnd;
    strCodCndAnt      := strCodCnd;
    strCndAnt         := strConPag;
    strUltCodCndRecalculado := strCodCnd;
    edtCodCndAtu.Text := strCodCnd;
    mskCndPag.Text    := strConPag;
    mskCndPagAtu.Text := strConPag;
    edtDesCnd.Text    := strDesCnd;
    edtDesCndAtu.Text := strDesCnd;
    edtForPag.Text    := strCodFpg;
    edtForPagAtu.Text := strCodFpg;
    edtForPag.Text    := strCodFpg;
    edtDesFpg.Text    := strDesFpg;
    edtDesFpgAtu.Text := strDesFpg;

    edtValDoc.Text    := FormatFloat('##,#0.00', fltTotOri);
    edtValDocAtu.Text := FormatFloat('##,#0.00', fltTotOri);
    edtCodVen.Text    := strCodVen;
    edtDesVen.Text    := strNomVen;

    edtTotRec.Text := FormatFloat('##,#0.00', fltDupRec + fltValAdt);
    edtTotCtr.Text := FormatFloat('##,#0.00', fltTotOri - fltDupRec);

    pnlCondicao.Enabled   := True;
    btnCalcTotPed.Enabled := True;
    pnlBusca.Enabled      := False;

    strConLib := '';
    strCndLib := '';

    If (fCfgSis('USACND', VarBoolean))                 And
       (fRetTipoForaConPag(edtCodCnd.Text) = 'OUTROS') Then
      mskCndPag.Enabled := True;

    pSetFocus(mskCndPag);
    pSetFocus(edtCodCnd);
  End;
end;

procedure TfrmFatAltCondPagtoPedido.pAtualizaTotais;
  Var
    intParc: Integer;
    strParc: String;
begin
  With objAltCnd.objVenda Do
  Begin
    edtValDoc.Text := FormatFloat('##,#0.00', fltTotGer);
    edtTotRec.Text := FormatFloat('##,#0.00', fltDupRec + fltValAdt);
    edtTotCtr.Text := FormatFloat('##,#0.00', fltTotCadRec);

    For intParc := 0 To 23 Do
      With arrDuplicata[intParc] Do
      Begin
        strParc := fStrZero(intToStr(intParc + 1), 2);
        TMaskEditFocus(Self.FindComponent('edtDtaVen' + strParc)).Text := dtaDtaVen;
        TEditFocus    (Self.FindComponent('edtValPar' + strParc)).Text := FormatFloat('##,#0.00', curValor);
      End;
  End;
end;

procedure TfrmFatAltCondPagtoPedido.pCarregaDespesasAcessorias;
  Var
    fltVlrDesAce,
    fltPerDesAce,
    fltParDesAce: Double; //Valor por Condição a Prazo
begin
  fltVlrDesAce := 0;

  If fCobrarDespAcessCondPagto(edtCodCnd.Text, edtCodCli.Text, objAltCnd.objVenda.strTipPed) Then
  Begin
    fltVlrDesAce := fRetornaDesAceUnicoPorVenda(edtCodCnd.Text);
    fltPerDesAce := fRetornaDesAceCnd(edtCodCnd.Text);
    fltParDesAce := fRetornaDesAcePrazoCnd(edtCodCnd.Text, mskCndPag.Text);

    If fltPerDesAce > 0 Then
      fltVlrDesAce := fltVlrDesAce + (objAltCnd.objVenda.fltTotPro * fltPerDesAce / 100.00);

    fltVlrDesAce := fltVlrDesAce + fltParDesAce;
  End;

  fltVlrDesAce := fltVlrDesAce + fCfgSis('VLDEAC', varDouble);

  If fltVlrDesAce > 0 Then
    objAltCnd.objVenda.fltDesAce := fFormataFloat(fltVlrDesAce, 2)
  Else
    objAltCnd.objVenda.fltDesAce := objAltCnd.objVenda.fltDeADig; //mantém a despesa original
end;

procedure TfrmFatAltCondPagtoPedido.pLimpaTela;
  Const
    TAG_NAO_LIMPAR = 1;
    TAG_VALORES = 2;
  Var
    intIdx: Integer;
begin
  If Assigned(objAltCnd) And Assigned(objAltCnd.qryFatGor) Then
    pLiberaBloqueioPedido(objAltCnd.qryFatGor);

  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx].Tag <> TAG_NAO_LIMPAR Then
    Begin
      If Self.Components[intIdx] Is TEditFocus Then
        If Self.Components[intIdx].Tag = TAG_VALORES Then
          (Self.Components[intIdx] As TEditFocus).Text := '0,00'
        Else
          (Self.Components[intIdx] As TEditFocus).Clear;

      If Self.Components[intIdx] Is TMaskEditFocus Then
        (Self.Components[intIdx] As TMaskEditFocus).Clear;
    End;
  End;

  If (fCfgSis('USACND', VarBoolean)) Then
    mskCndPag.Enabled := False;

  edtCodEmp.Text := IIF(fEmptyStr(strCodEmpLib), VS_strCodEmp, strCodEmpLib);
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);
  edtEspDoc.Text := 'PD';

  strCcnAnt := '';
  strCndAnt := '';
  strFpgAnt := '';
  strFpgLib := '';
  strUltCodCndRecalculado := '';


  btnConfirma.Enabled   := False;
  pnlCondicao.Enabled   := False;
  btnCalcTotPed.Enabled := False;
  pnlBusca.Enabled      := True;

  SetLength(arrLogLib, 0);

  pSetFocus(edtNumDoc);
end;

function TfrmFatAltCondPagtoPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Var
  blnRecalcularPreco: Boolean;
  strSugCndCli: String;
  strCndSug: String;
begin

  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      Try
        If InterlockedIncrement(intSemaforoValidar) = 0 Then
        Begin
          Result := fValidaUtilizarPedido(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, edtEspDoc.Text, objAltCnd.qryFatGor, blnLiberaPedido);

          If Result Then
          Begin
            blnMudarFoco := False;

            objAltCnd.strNumPed := edtNumDoc.Text;
            objAltCnd.strEmpPed := edtCodEmp.Text;

            strUltimoPedido := edtNumDoc.Text;

            Result := objAltCnd.fCarregarPedido;

            If Result Then
              Result := ValidarModificacoesPix;

            If Result Then
              pAtualizaDadosPedido;
          End;
        End;
      Finally
        InterlockedDecrement(intSemaforoValidar);
      End;
    End

    Else If (Sender = edtCodCnd) And (edtCodCnd.Visible) Then
    Begin
      If (fCarregaCondicao) Then
        objAltCnd.pCarregaCondicao(edtCodCnd.Text, objAltCnd.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);

      If fEmptyStr(edtCodCnd.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If fEmptyStr(objAltCnd.objVenda.strDesCnd) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&O k']);
        Result := False;
      End

      Else If (Not fEmpresaTemAcessoCondicaoPagto(edtCodCnd.Text, edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar esta condição. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
        Result := False;
      End

      Else If Not fPermiteUtilizarEstaCondPagamento(edtCodCnd.Text, TfatVenda.fUtilizarDataEmissaoCalcularDiaVencimento(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text)) Then
      Begin
        Result := False;
      End

      Else If (strConLib <> edtCodCnd.Text)                            And
              (edtCodCnd.Text <> edtCodCndAtu.Text)                    And
              (fTravarCondicaoPagamento(edtCodCnd.Text,
                                        mskCndPag.Text,
                                        objAltCnd.objVenda.strCodCli,
                                        objAltCnd.objVenda.strCodVen,
                                        objAltCnd.objVenda.strCodDig,
                                        objAltCnd.objVenda.strNTrava,
                                        '',
                                        objAltCnd.objVenda.stlNumLib,
                                        cdsVenda,
                                        objAltCnd.objVenda)) Then
      Begin
        Result := False;
      End;

      If Result And (edtCodCnd.Text <> strCodCndAnt) Or ((strFpgAnt <> edtForPag.Text) And (strFpgAnt <> '')) Then
      Begin
        strConLib := edtCodCnd.Text;

        If (fTiraCaracEspeciais(mskCndPag.Text, True, True, True) = fTiraCaracEspeciais(mskCndPagAtu.Text, True, True, True)) Or
           (fCarregaCondicao) Then
          strCndLib := fTiraCaracEspeciais(mskCndPag.Text, True, True, True);

        If (objAltCnd.blnAtualizaTabPreCnd) Then
        Begin
          objAltCnd.pCarregaCondicao(edtCodCnd.Text, objAltCnd.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);

          If (Not fEmptyStr(objAltCnd.objVenda.strDesCnd)) And
             (fEmptyStr(Trim(StringReplace(objAltCnd.objVenda.strCndTpm,'N','',[rfReplaceAll, rfIgnoreCase])))) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esta condição não pode ser utilizada pois a tabela de preço não foi preenchida!', ['&O k']);
            Result := False;
          End;
        End;

        If Result Then
        Begin
          If (Not objAltCnd.objVenda.fCondicaoPagtoClienteOk(edtCodCnd.Text)) Then
            Result := False;
        End;

        If (Result) Then
        Begin

          If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaCndPag(mskCndPag.Text, objAltCnd.objVenda.FConPag, VS_Date) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição de pagamento ' + fFormataCondPag(mskCndPag.Text) + ' ' +
                                  'não é valida!' + #13#10 +
                                  'Verifique se informou todas as parcelas e se as mesmas estão em ordem progressiva, ' +
                                  'exemplos válidos: (01)000, (01)030, (03)030.060.090', ['&O k']);
            Result := False;
          End
          Else If fEmptyStr(objAltCnd.objVenda.strConPag) Then
          Begin
            Result := False;
          End;

          mskCndPag.Text := objAltCnd.objVenda.strConPag;

          {*****************************************}
          {* CASO A CONDIÇÃO ESTEJA OK             *}
          {**************************************MV*}
          If Result And ((mskCndPag.Text <> strCndAnt) Or (Not objAltCnd.objVenda.blnVerPrzMed)) Then
            Result := objAltCnd.objVenda.fVerificaPrazoMedio(objAltCnd.objVenda.strConPag);

          If Result And ((mskCndPag.Text <> strCndAnt) Or (Not objAltCnd.objVenda.blnVerMaxPar)) Then
            Result := objAltCnd.objVenda.fVerificaQtdMaxParcelas(objAltCnd.objVenda.strConPag);

          If (Result) And (fCfgSis('RECCND', varBoolean) And
             (objAltCnd.objVenda.strConPag <> '01999')) And (fCfgSis('CNDVEN') = 'I') Then
          Begin
            {*****************************************}
            {* CALCULA FATOR REFERENTE À MEDIA DA    *}
            {* CONDIÇÃO DE PAGAMENTO                 *}
            {**************************************MV*}
            objAltCnd.objVenda.pCalculaTaxVpr;

            If fCfgSis('CNDVEN') = 'F' Then
              objAltCnd.objVenda.fltTaxVpr := 0;

            {*****************************************}
            {* RECALCULA OS PREÇOS                   *}
            {**************************************MV*}
            If (edtCodCnd.Text <> strCcnAnt) And
               ((objAltCnd.objVenda.fltTaxVpr >= 0.0) Or fCfgSis('RECCND', varBoolean)) Then
            Begin
              {************************************}
              {* CASO USAR FATOR P\ NOTA ESPECIAL *}
              {* NAO RECALCULA O PRECO            *}
              {*********************************JB*}
              If (objAltCnd.objVenda.fltFatNot = 0) And
                 (objAltCnd.blnRecalcularPrecosAoMudarCondicaoDePagamento) Then
              Begin
                objAltCnd.blnRecalculaPrecos := True;
              End;

            End;

          End;

          If (Result) Then
          Begin
            strCcnAnt := edtCodCnd.Text;

            If objAltCnd.blnAtualizaTabPreCnd And (fCfgSis('CNDVEN') = 'I') Then
            Begin
              objAltCnd.objVenda.pCalculaTaxVpr;
              objAltCnd.blnRecalculaPrecos := True;
              objAltCnd.blnAltTabelaPreco  := True;
            End;
          End;

          If (Result) And (fConfiguradoParaRecalcularSomenteItensEmPromocao) Then
          Begin
            objAltCnd.blnRecalculaPrecos := True;
          End;

        End;

      End;

      if (Result) and (fCfgSis('CNDPES',varBoolean)) then
      Begin
        objAltCnd.pCarregaCondicao(edtCodCnd.Text);
        objAltCnd.blnZerarDescontoDoItemRecalculoPrecos := False;

        {SE A CONDIÇÃO ATUAL FOR "ESPECIAL", CHECAR A LISTA DE PRODUTOS JÁ INSERIDOS - KM}
        if (objAltCnd.objVenda.blnCndEsp) then
        Begin
          if objAltCnd.objVenda.fProdutoForaCondEsp(objAltCnd.objVenda.strCodCnd) then
          Begin
            fMensagem('ATENÇÃO!','Essa condição de pagamento não poderá ser utilizada pois existem produtos não permitidos! ' +
                        'Favor verificar e excluir os itens fora da política de parcelamento.', ['&Ok']);
            Result := False;
          End
          Else {TODOS OS PRODUTOS PERTENCEM A CONDIÇÃO ESPECIAL, ENTÃO RECALCULA PREÇOS}
          Begin
            if (edtCodCnd.Text <> strCodCndAnt) then
              fMensagem('ATENÇÃO!', 'Foi escolhida uma condição de pagamento especial e os produtos terão seus preços de tabela definidos!', ['&Ok']);
            objAltCnd.blnZerarDescontoDoItemRecalculoPrecos := True;
          End;
        End;
      End;
      {*************************************************}
      {* NÃO PERMITE VENDA A PRAZO PARA CLI-CONSUMIDOR *}
      {**********************************************AF*}
      If (Result) And
         (fClienteConsumidor(objAltCnd.objVenda.strCliOri)) And
         (fStatusCndPag(objAltCnd.objVenda.strConPag) = A_PRAZO) And
         (Not fCfgSis('PRZCON', varBoolean)) Then
      Begin
        fMensagem('','A condição de pagamento não pode ser a prazo para cliente consumidor!',['&OK']);
        Result := False;
      End;

      If Result And (Not fEmptyStr(edtCodVen.Text)) And
        (Not objAltCnd.objVenda.fVendedorComCondicaoPagto(edtCodCnd.Text, mskCndPag.Text)) Then
      Begin
        Result := False;
      End;

      If Result Then
      Begin
        If Not TFuncoesPixAutcom.ValidacoesCondicaoDePagamentoPix(objAltCnd.objVenda, FCondicaoPixJaLiberada) Then
          Result := False;
      End;

      If Result Then
      Begin
        If (Not fClienteTemCndPagAssociado(objAltCnd.objVenda.strCodCli)) And
           (Not fEmptyStr(edtCodCnd.Text))                                And
           (edtCodCnd.Text <> strCodCndAnt)                               And
           (fCfgSis('TRACND', varBoolean))                                And
           (fCfgSis('CNDPRA', varString) = '2')                           Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Liberação da condição de pagamento para quando é utilizado trava de cliente por condição de pagamento, e não há condição de');
          objLiberacao.objMsgLibera.pAddTexto('pagamento vinculado ao cliente.');

          If Not fEmptyStr(objAltCnd.objVenda.strCodCnd) Then
            objLiberacao.objMsgLibera.pAddTextoCaption('Condição de pagamento', objAltCnd.objVenda.strCodCnd + '-' + objAltCnd.objVenda.strDesCnd);

          objLiberacao.strDirAce := 'CNDPRA';
          objLiberacao.strSenLib := fCfgSis('SENPRA');
          objLiberacao.strMsgSen := 'Condição de Pagamento';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCliente := edtCodCli.Text + '-' + edtDesCli.Text;
          objLiberacao.strCpfCnpj := fRetCgcCpf(edtCodCli.Text);

          If (Not objLiberacao.fLibera) Then
          Begin
            objAltCnd.objVenda.strCodCnd := '';
            objAltCnd.objVenda.strDesCnd := '';
            objAltCnd.objVenda.strCodFpg := '';
            objAltCnd.objVenda.strDesFpg := '';

            edtDesCnd.Text := '';
            mskCndPag.Text := '';
            edtForPag.Text := '';
            edtDesFpg.Text := '';
            Result := False;
          End
          Else
            objAltCnd.pCarregaCondicao(edtCodCnd.Text);
        End;
      End;

      If Result And (edtCodCnd.Text <> strCodCndAnt) Then
      Begin
        If objAltCnd.objVenda.fAcionarTravaVendasMaximoDiasNaoCompra(objAltCnd.objVenda.blnCndTravaCli,
                                                                     fStatusCndPag(objAltCnd.objVenda.strConPag),
                                                                     True) Then
        Begin
          If (Pos(objAltCnd.objVenda.strOpcDoc, 'VN_PD_OR_') > 0) And
             (Not blnTravaNaoCompra) And
             (Not objAltCnd.objVenda.fVerificaNaoCompra(blnTravaNaoCompra, fRetCodVenDef(objAltCnd.objVenda.strCodVen))) Then
            Result := False;
        End;
      End;

      strSugCndCli := objAltCnd.objVenda.fCondicaoPagtoClienteSugestao;

      If (Not fEmptyStr(objAltCnd.objVenda.strCodPagOri)) And (fEmptyStr(strCndSug)) Then
        strCndSug := objAltCnd.objVenda.strCodPagOri;

      If (Result)                                     And
         (edtCodCnd.Text <> strCodCndAnt)             And
         (fCfgSis('PFLCLI', varBoolean)               And
         fRetCampoCndPagto(strCcnAnt, 'CND_SENCND'))  And
         ((Not fEmptyStr(strSugCndCli) And (Not fEmptyStr(strCndSug)) And (edtCodCnd.Text <> strSugCndCli) And (edtCodCnd.Text <> strCndSug))) Then
      Begin

        objLiberacao.Clear;
        objliberacao.objMsgLibera.pAddTexto('Alteração da Condição de Pagamento sugerida.');
        objliberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto Sugerida'  , strCndSug + ' - ' + fRetDesConPag(strCndSug)           , 21);
        objliberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto Informada' , edtCodCnd.Text + ' - ' + fRetDesConPag(edtCodCnd.Text) , 21);

        If (objAltCnd.objVenda.fltTotGer > 0) Then
          objliberacao.objMsgLibera.pAddTextoCaption('Valor Total Documento' , FormatFloat('#,##0.00', objAltCnd.objVenda.fltTotGer) , 21);

        objLiberacao.strDirAce := 'SENCND';
        objLiberacao.strSenLib := fCfgSis('SENCND');
        objLiberacao.strMsgSen := 'Alteração da Condição de Pagamento';
        objLiberacao.strCodOpe := objAltCnd.objVenda.strCodVen;
        objLiberacao.strCodDig := objAltCnd.objVenda.strCodDig;
        objLiberacao.strCliente := (objAltCnd.objVenda.strCodCli + '-' + objAltCnd.objVenda.strCliOri);
        objLiberacao.strCpfCnpj := objAltCnd.objVenda.strCliCgc;

        Result := objAltCnd.objVenda.fFatMensagemLiberacao(objLiberacao);

      End;

      If Result And (edtCodCnd.Text <> strCodCndAnt) Then
      Begin
        Result := objAltCnd.objVenda.fVerificaConsultaDeCredito(objAltCnd.objVenda.strConPag,
                                                                objAltCnd.objVenda.strCodFpg,
                                                                objAltCnd.objVenda.strOpcDoc,
                                                                fRetCodVenDef(objAltCnd.objVenda.strCodVen));
      End;

      If Result And (edtCodCnd.Text <> strCodCndAnt)  Then
      Begin
        Result := objAltCnd.objVenda.fVerificaConsultaDadosCobranca(objAltCnd.objVenda.strConPag,
                                                                    objAltCnd.objVenda.strCodFpg,
                                                                    fRetCodVenDef(objAltCnd.objVenda.strCodVen));
      End;

      If Result And (edtCodCnd.Text <> strCodCndAnt) And
         (Not objAltCnd.objVenda.blnCliFil) And
         (Not fClienteConsumidor(objAltCnd.objVenda.strCliOri, True, True)) Then
      Begin
        Result := objAltCnd.objVenda.fDebitoCliente(objAltCnd.objVenda.strCodFpg,
                                                    objAltCnd.objVenda.strConPag, 2);

        If Result And (edtCodCnd.Text <> strCodCndAnt) Then
          Result := fVerificaLimiteCredito();
      End;

      If Result Then
        strCodCndAnt := edtCodCnd.Text;
    End

    {************************************}
    {* VALIDA A FORMA DE PAGAMENTO      *}
    {*********************************AF*}
    Else If (Sender = edtForPag) And (pnlForPag.Visible) Then
    Begin

      If (objAltCnd.objVenda.VS_blnUsaFpg) Then
      Begin
        objAltCnd.pCarregaForPag(edtForPag.Text);

        If fEmptyStr(edtForPag.Text) Then
        Begin
          fMensagem('','O campo forma de pagamento deve ser preenchido!',['&OK']);
          Result := False;
        End

        Else If fEmptyStr(objAltCnd.objVenda.strDesFpg) Then
        Begin
          fMensagem('','Forma de pagamento não encontrada!',['&OK']);
          Result := False;
        End

        Else If fRetornaStatusCadastro(edtForPag.Text, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esta forma de pagamento não pode ser utilizada pois está inativa!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          stlForPag.Clear;
          stlCndPag.Clear;

          If (fCfgSis('USATPC') = 'S') Then
            pCarregaFormasPagto(edtCodCli.Text, stlForPag, stlCndPag);

          If (stlForPag.Count > 0) And (stlForPag.IndexOf(edtForPag.Text) < 0) And
             (Not SameText(strFpgLib, edtForPag.Text)) Then
          Begin
            objLiberacao.Clear;

            pMsgFormasPagtoPermitidasCliente(edtForPag.Text, stlForPag, objLiberacao.objMsgLibera);

            If fCfgSis('FPGCLI', varBoolean) Then
            Begin
              objLiberacao.strDirAce := 'FPGSEN';
              objLiberacao.strSenLib := fCfgSis('FPGSEN');
              objLiberacao.strMsgSen := 'Forma pagamento não permitida';
              objLiberacao.strCodOpe := objAltCnd.objVenda.strCodVen;
              objLiberacao.strCodDig := objAltCnd.objVenda.strCodDig;
              objLiberacao.strCliente := objAltCnd.objVenda.strCodCli + '-' + objAltCnd.objVenda.strCliOri;
              objLiberacao.strCpfCnpj := objAltCnd.objVenda.strCliCgc;
              objLiberacao.fltValorVenda := objAltCnd.objVenda.fltTotGer;

              Result := objAltCnd.objVenda.fFatMensagemLiberacao(objLiberacao);

              If Result Then
                strFpgLib := edtForPag.Text
              Else
                strFpgLib := '';
            End

            Else REsult := False;

          End

          Else If (Pos(objAltCnd.objVenda.strOpcDoc, 'OR_PD_') <= 0) And (Not objAltCnd.objVenda.fBaixaDuplicataAVista) And (edtForPag.Text = '009') Then
          Begin
            fMensagem('ATENÇÃO!', 'Sistema configurado para não baixar duplicatas à vista '+ #13#10 +
                                  'não permite forma de pagamento "Parcelado"!', ['&Ok']);
            Result := False;
          End

          Else If fCfgSis('TFPF11', varBoolean) And (edtForPag.Text = '009') And (objAltCnd.objVenda.blnEnt_CD) Then
          Begin
            fMensagem('ATENÇÃO!', 'Sistema configurado para travar no F11 a forma de pagamento negociada, '+ #13#10 +
                                  'portanto não é permitido forma de pagamento "Parcelado" para entregas pelo CD!', ['&Ok']);
            Result := False;
          End;

          If (Result) And (objAltCnd.objVenda.VS_blnUsaFpg) And (Not fEmptyStr(edtForPag.Text)) And (Not fEmptyStr(mskCndPag.Text)) Then
          Begin

            If Pos(edtForPag.Text,'001_006_' + IIF(fCfgSis('PRACHC',varBoolean),'','002_007_')) > 0 Then
            Begin
              If (fStatusCndPag(mskCndPag.Text) <> A_VISTA) And (mskCndPag.Text <> '01999') Then
              Begin
                fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
                Result := False;
              End;
            End;

            {*******************************************}
            {* LIBERADO PARCELADO A VISTA PARA VENDER  *}
            {* PARA CLIENTE CONSUMIDOR                 *}
            {****************************************MV*}
            If Result And (Pos(edtForPag.Text,'008_010_') > 0) Then
            Begin
              If fStatusCndPag(mskCndPag.Text) = A_VISTA Then
              Begin
                fMensagem('','A condição de pagamento não pode ser a vista!',['&OK']);
                Result := False;
              End;
            End;

          End;

        End;

        If Result And fCfgSis('SOLCAR', varBoolean) And (Pos(edtForPag.Text, '007_') > 0) Then
        Begin
          If (activeControl = edtForPag) Or fEmptyStr(objAltCnd.objVenda.strCodCar) Then
          Begin
            Result := objAltCnd.objVenda.fPedeDadosCartao;
          End;
        End
        Else
        Begin
          objAltCnd.objVenda.strCodCar := '';
          objAltCnd.objVenda.intQtdPaC := 0;
        End;

      End;

      If Result Then
        strFpgAnt := edtForPag.Text;

    End

    Else If (Sender = mskCndPag) And (mskCndPag.Visible) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If StrToIntDef(Copy(mskCndPag.Text, 1, 2), 0 ) > 24 Then
      Begin
        fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
        Result := False;
      End

      Else If (Not edtCodCnd.Visible) And
              (Not objAltCnd.objVenda.blnCliFil) And
              (Not objAltCnd.objVenda.fCondicaoPagtoClienteOk(mskCndPag.Text)) Then
      Begin
        Result := False;
      End

      Else If (fTiraCaracEspeciais(mskCndPag.Text, True, True, True) <> fTiraCaracEspeciais(mskCndPagAtu.Text, True, True, True)) And
              (strCndLib <> fTiraCaracEspeciais(mskCndPag.Text, True, True, True))                                                And
              (fTravarCondicaoPagamento(edtCodCnd.Text,
                                        mskCndPag.Text,
                                        objAltCnd.objVenda.strCodCli,
                                        objAltCnd.objVenda.strCodVen,
                                        objAltCnd.objVenda.strCodDig,
                                        objAltCnd.objVenda.strNTrava,
                                        '',
                                        objAltCnd.objVenda.stlNumLib,
                                        cdsVenda,
                                        objAltCnd.objVenda)) Then
      Begin
        Result := False;
      End

      Else
      Begin
        strConLib                  := edtCodCnd.Text;
        strCndLib                  := fTiraCaracEspeciais(mskCndPag.Text, True, True, True);
        objAltCnd.objVenda.FConPag := fTiraCaracEspeciais(mskCndPag.Text, True, True, True);

        {*********************************************************************}
        {* VALIDAÇÃO DA COND. PAGTO PARA FORA SEMANA, DEZENA, QUINZENA E MES *}
        {******************************************************************LU*}
        If Pos(copy(mskCndPag.Text, 1, 2), 'FS_FD_FQ_FM') > 0 Then
        Begin
          mskCndPag.Text := fValidaCndPagFora(mskCndPag.Text);
          fValidaCampos(mskCndPag, False);
        End
        Else
        Begin
          If (copy(mskCndPag.Text, 1, 1) = 'F') Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If Not fValidaCndPag(mskCndPag.Text, objAltCnd.objVenda.FConPag, VS_Date) Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa condição de pagamento ' + fFormataCondPag(mskCndPag.Text) + ' ' +
                                    'não é valida!' + #13#10 +
                                    'Verifique se informou todas as parcelas e se as mesmas estão em ordem progressiva, ' +
                                    'exemplos válidos: (01)000, (01)030, (03)030.060.090', ['&O k']);
              Result := False;
            End
            Else
            Begin
              If fEmptyStr(objAltCnd.objVenda.strConPag) Then
                Result := False;
            End;
          End;
        End;
      End;

      If Result And (Not fCfgSis('USACND', varBoolean)) Then
      Begin
        Result := objAltCnd.objVenda.fCondicaoPagtoClienteOk(mskCndPag.Text);
      End;

      mskCndPag.Text := objAltCnd.objVenda.strConPag;

      {*****************************************}
      {* CASO A CONDIÇÃO ESTEJA OK             *}
      {**************************************MV*}
      If (Result) And ((strCndAnt <> mskCndPag.Text) Or (Not objAltCnd.objVenda.blnVerPrzMed)) Then
        Result := objAltCnd.objVenda.fVerificaPrazoMedio(objAltCnd.objVenda.strConPag);

      If (Result) And ((strCndAnt <> mskCndPag.Text) Or (Not objAltCnd.objVenda.blnVerMaxPar)) Then
        Result := objAltCnd.objVenda.fVerificaQtdMaxParcelas(objAltCnd.objVenda.strConPag);

      If (Result) And (fCfgSis('RECCND', varBoolean) And (objAltCnd.objVenda.strConPag <> '01999')) Then
      Begin

        {*****************************************}
        {* CALCULA FATOR REFERENTE À MEDIA DA    *}
        {* CONDIÇÃO DE PAGAMENTO                 *}
        {**************************************MV*}
        objAltCnd.objVenda.pCalculaTaxVpr;

        If fCfgSis('CNDVEN') = 'F' Then
          objAltCnd.objVenda.fltTaxVpr := 0;

        {*****************************************}
        {* RECALCULA OS PREÇOS                   *}
        {**************************************MV*}

        If (Not fEmptyStr(strCndAnt)) And
           ((strCndAnt <> objAltCnd.objVenda.strConPag) Or (strUltCodCndRecalculado <> edtCodCnd.Text)) And
           ((objAltCnd.objVenda.fltTaxVpr >= 0.0) Or fCfgSis('RECCND', varBoolean)) Then
        Begin
          blnRecalcularPreco := False;

          If fExibirMensagemManterPrecosOriginaisVendaTrocaCondicaoPagamento(objAltCnd.objVenda.strCodCnd) Then
          Begin
            {*********************************************}
            {* PERGUNTA MANTER O PRECO ORIGINAL          *}
            {******************************************FS*}
            If (fMensagem('AVISO!', 'Deseja manter os preços originais?', ['&Sim', '&Não']) = 1) Then
            Begin
              {*********************************************}
              {* SENHA P\ PERMITIR MANTER O PRECO ORIGINAL *}
              {******************************************JB*}
              If (Not (fEmptyStr(fCfgSis('SENMPR')))) Then
              Begin

                objLiberacao.Clear;
                objLiberacao.objMsgLibera.pAddTexto('Senha para manter os preços da venda quando trocar a condição de pagamento');

                objLiberacao.strDirAce := 'SENMPR';
                objLiberacao.strSenLib := fCfgSis('SENMPR');
                objLiberacao.strMsgSen := 'Senha para manter os preços da venda quando trocar a condição de pagamento';
                objLiberacao.strCodOpe := strLoginUsuarioLogado;
                objLiberacao.strCliente := edtCodCli.Text + '-' + edtDesCli.Text;
                objLiberacao.strCpfCnpj := objAltCnd.objVenda.strCliCgc;

                If (Not objAltCnd.objVenda.fFatMensagemLiberacao(objLiberacao))  Then
                Begin
                  fMensagem('','Senha incorreta!',['&OK']);
                  Result := False;
                End;

                If Result Then
                  objAltCnd.blnRecalculaPrecos := False;
              End;
            End
            Else
              blnRecalcularPreco := True;
          End
          Else
            blnRecalcularPreco := True;

          If blnRecalcularPreco And (fCfgSis('CNDVEN') = 'I') Then
            objAltCnd.blnRecalculaPrecos := True;
        End;
      End;

      {*************************************************}
      {* NÃO PERMITE VENDA A PRAZO PARA CLI-CONSUMIDOR *}
      {**********************************************AF*}
      If (Result) And
         (fClienteConsumidor(objAltCnd.objVenda.strCliOri)) And
         (fStatusCndPag(objAltCnd.objVenda.strConPag) = A_PRAZO) And
         (Not fCfgSis('PRZCON', varBoolean)) Then
      Begin
        fMensagem('','A condição de pagamento não pode ser a prazo para cliente consumidor!',['&OK']);
        Result := False;
      End;

      If (Result) Then
      Begin
        strUltCodCndRecalculado := objAltCnd.objVenda.strCodCnd;
        strCndAnt               := objAltCnd.objVenda.strConPag;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltCondPagtoPedido.mskCndPagEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskCndPag.Text) Then
    mskCndPag.EditMask := MASK_CONPAG2;
end;

procedure TfrmFatAltCondPagtoPedido.mskCndPagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If fEmptyStr(mskCndPag.Text) Then
    mskCndPag.EditMask := MASK_CONPAG2;
end;

procedure TfrmFatAltCondPagtoPedido.mskCndPagKeyPress(Sender: TObject;
  var Key: Char);
Var
  strKey: String;
begin
  inherited;
  If fEmptyStr(mskCndPag.Text) Then
  Begin
    strKey := Key;
    If (UpperCase(strKey) = 'F') Then
      mskCndPag.EditMask := 'll.999;0;_'
    Else
      mskCndPag.EditMask := MASK_CONPAG;
  End;
end;

procedure TfrmFatAltCondPagtoPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(objAltCnd) And Assigned(objAltCnd.qryFatGor) Then
    pLiberaBloqueioPedido(objAltCnd.qryFatGor);
end;

procedure TfrmFatAltCondPagtoPedido.FormCreate(Sender: TObject);
begin
  inherited;
  strConLib := '';
  strCndLib := '';

  intSemaforoConsulta := -1;
  intSemaforoValidar  := -1;

  stlForPag    := TStringList.Create;
  stlForPag.Sorted := True;
  stlForPag.Duplicates := dupIgnore;

  stlCndPag    := TStringList.Create;
  stlCndPag.Sorted := True;
  stlCndPag.Duplicates := dupIgnore;

  objAltCnd := TAlterarPedido.Create(Self);
  objAltCnd.blnModuloAltCondPagtoPedido := True;

  objAltCnd.edtCodCnd := edtCodCnd;
  objAltCnd.edtDesCnd := edtDesCnd;
  objAltCnd.edtForPag := edtForPag;
  objAltCnd.edtDesFpg := edtDesFpg;
  objAltCnd.mskCndPag := mskCndPag;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  objLiberacao := TLiberacao.Create;

  FCondicaoPixJaLiberada := False;
  blnLiberaPedido := False;
  strNumPedLib := EmptyStr;
  strCodEmpLib := EmptyStr;
  blnAlterouFormaPagamento := False;
  blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp := False;

  blnTravaNaoCompra := False;
end;

procedure TfrmFatAltCondPagtoPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objAltCnd)    Then FreeAndNil(objAltCnd);
  If Assigned(stlForPag)    Then FreeAndNil(stlForPag);
  If Assigned(stlCndPag)    Then FreeAndNil(stlCndPag);
  if Assigned(objLiberacao) Then FreeAndNil(objLiberacao);
end;

procedure TfrmFatAltCondPagtoPedido.FormShow(Sender: TObject);
begin
  inherited;
  pLimpaTela;

  objAltCnd.blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp := blnAlteraFormaPagamentoLiberacaoPedidoMultiEmp;

  If Not fCfgSis('USAFPG', VarBoolean) Then
  Begin
    pnlForPag.Enabled := False;
    pnlForPag.Visible := False;

    pnlForPagAtu.Enabled := False;
    pnlForPagAtu.Visible := False;

    edtForPag.Tag := 0;

    pnlDados.Height := pnlDados.Height - pnlForPagAtu.Height;
    pnlCondicao.Height := pnlCondicao.Height - pnlForPag.Height;

    Self.Height := Self.Height - pnlForPagAtu.Height - pnlForPag.Height;
  End;

  If Not fCfgSis('USACND', VarBoolean) Then
  Begin
    edtCodCndAtu.Visible := False;
    edtDesCndAtu.Visible := False;
    mskCndPagAtu.Left    := edtCodCndAtu.Left;
    mskCndPagAtu.Width   := edtDesCndAtu.Left + edtDesCndAtu.Width - edtCodCndAtu.Left;

    edtCodCnd.Visible := False;
    edtDesCnd.Visible := False;
    mskCndPag.Left    := edtCodCnd.Left;
    mskCndPag.Width   := edtDesCnd.Left + edtDesCnd.Width - edtCodCnd.Left;
  End;

  if (not fEmptyStr(strNumPedLib)) and (blnLiberaPedido) then
  begin
    edtNumDoc.Text := strNumPedLib;
    fValidaCampos(edtNumDoc, True);
  end;
end;

procedure TfrmFatAltCondPagtoPedido.btnCalcTotPedClick(Sender: TObject);
begin
  inherited;

  If fValidaPanel(pnlCndPag, True) And fValidaPanel(pnlForPag, True) Then
  Begin
    tmrRecalcular.Enabled := False;
    pEnfaseBotaoRecalcular;

    pCarregaDespesasAcessorias;

    If objAltCnd.fCalculaTotalPedido Then
    Begin
      pAtualizaTotais;
      btnConfirma.Enabled := True;      
    End;
  End;

end;

procedure TfrmFatAltCondPagtoPedido.pEnfaseBotaoRecalcular;
begin
  If tmrRecalcular.Enabled And btnCalcTotPed.Enabled Then
  Begin
    btnCalcTotPed.Font.Color := clRed;

    If fsBold In btnCalcTotPed.Font.Style Then
      btnCalcTotPed.Font.Style := []
    Else
      btnCalcTotPed.Font.Style := [fsBold];
  End
  Else
  Begin
    btnCalcTotPed.Font.Color := clBlack;
    btnCalcTotPed.Font.Style := [];
  End;

  btnConfirma.Enabled      := False;
end;

procedure TfrmFatAltCondPagtoPedido.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If btnConfirma.Enabled Then
  Begin
    If Not fEmptyStr(objAltCnd.objVenda.strInRqCp) Then
      objAltCnd.objVenda.pCarregaItensMovRcd;

    If objAltCnd.fGravarPedido Then
    Begin
      pMensagemOk('Pedido ' + objAltCnd.objVenda.strNumDoc + '-PD alterado com sucesso!');
      pLimpaTela;
      blnAlterouFormaPagamento := True;
    End
    Else
      pMensagemOk('Não foi possível alterar o pedido ' + objAltCnd.objVenda.strNumDoc + '-PD!');
  End;
end;

procedure TfrmFatAltCondPagtoPedido.pEscapePressed;
begin
  If (ActiveControl <> edtNumDoc) Then
    pLimpaTela
  Else
    inherited;
end;

function TfrmFatAltCondPagtoPedido.fVerificaLimiteCredito(): Boolean;
  var
    fltValorCompra: Double;
    blnAplicarDescontos: Boolean;

    objParametrosMensagem: TParametrosMensagem;
Begin
  Result := True;

  if (fCfgSis('ALPKNK', varBoolean)) and
     (Pos(objAltCnd.objVenda.strCodCnd, fCfgSis('CNDBOL', varString)) > 0) then
  begin
    if fFormataFloat(objAltCnd.objVenda.fltTotGer, 2) > fFormataFloat(objAltCnd.objVenda.fltLimBolAlp, 2) then
    begin
      Result := False;

      objParametrosMensagem := TParametrosMensagem.Create;
      try
        objParametrosMensagem.Titulo := 'Alpe';
        objParametrosMensagem.Texto  := 'Cliente não possui limite suficiente!'+#13#10+
                                        'Valor Total do Pedido: ' + Format('%m', [objAltCnd.objVenda.fltTotGer])+#13#10+
                                        'Limite Alpe Disponível: ' + Format('%m', [objAltCnd.objVenda.fltLimBolAlp])+#13#10;
        objParametrosMensagem.Opcoes := ['&OK'];
        fMensagem(objParametrosMensagem);
      finally
        objParametrosMensagem.Free;
      end;
    end;

    Exit;
  end;

  fltValorCompra := objAltCnd.objVenda.fltTotGer;

  If (Not (Pos(objAltCnd.objVenda.strOpcDoc, 'OU_OV_NC_BR_TE_OE_EF_OF_CF_CI_CN_UC_DV_PR_DD_') > 0)) Then
  Begin
    blnAplicarDescontos := True;

    Result := objAltCnd.objVenda.fVerificaLimiteCredito(objAltCnd.objVenda.strConPag,
                                                        fLimiteCreditoCliente(objAltCnd.objVenda.strCodCli),
                                                        fltValorCompra,
                                                        True,
                                                        blnAplicarDescontos);
  End
  Else
    Result := True;

end;

end.
