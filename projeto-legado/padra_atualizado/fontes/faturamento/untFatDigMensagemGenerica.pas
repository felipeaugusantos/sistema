{***************************}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untFatDigMensagemGenerica;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, Uni,
  ExtCtrls, EditFocus, untFuncFat, Mask, MaskEditFocus, QColorLabel,
  AppEvnts,  cxHint, strUtils, untFuncFatTypes,
  BitBtnLockedIncrem, ComboBoxFocus, dxScreenTip, cxClasses, dxCustomHint,
  frxClass, frxExportCSVTestabilidade, untLiberacao,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit, untValidacoesFrete;

type
  TfrmFatDigMensagemGenerica = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlFundo: TPanel;
    pnlTransportadora: TPanel;
    Label2: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    pnlDadosFrete: TPanel;
    lblValFre: TLabel;
    edtValFre: TEditFocus;
    Label4: TLabel;
    Label7: TLabel;
    edtNumReg: TEditFocus;
    pnlVolumes: TPanel;
    Label3: TLabel;
    edtQtdTra: TEditFocus;
    pnlEventos: TPanel;
    btnCalcFreSug: TSpeedButton;
    btnCalcVolume: TSpeedButton;
    HintControler: TcxHintStyleController;
    tmrHideHints: TTimer;
    btnMostraMargem: TBitBtnLocked;
    pnlMenExp: TPanel;
    lbl1: TLabel;
    edtMenExp: TEditFocus;
    edtMenEx2: TEditFocus;
    edtMenEx3: TEditFocus;
    edtMenEx4: TEditFocus;
    cmbTipFre: TComboBoxFocus;
    pnlDesAce: TPanel;
    Label23: TLabel;
    edtDesAce: TEditFocus;
    btnDespesasFaturamento: TBitBtnLocked;
    pnlContato: TPanel;
    lblCliCtt: TLabel;
    edtCliCtt: TEditFocus;
    btnPesquisarContato: TBitBtnLocked;
    btnAdicionarContato: TBitBtnLocked;
    pnlPlanoContas: TPanel;
    pnlGeral: TPanel;
    Label1: TLabel;
    edtMens01: TEditFocus;
    edtMens02: TEditFocus;
    chkEntUrg: TCheckBox;
    pnlTraRedesp: TPanel;
    Label5: TLabel;
    edtTraRedNom: TEditFocus;
    edtTraRedCod: TEditFocus;
    pnlProjeto: TPanel;
    Label8: TLabel;
    edtDesPrj: TEditFocus;
    edtCodPrj: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    pnlNotPau: TPanel;
    lblNotPau: TLabel;
    edtNotPau: TEditFocus;
    pnlRota: TPanel;
    lblRota: TLabel;
    edtCodRot: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlTipAte: TPanel;
    lblTipAte: TLabel;
    edtDesTpa: TEditFocus;
    edtCodTpa: TEditFocus;
    edtValFreCot: TEditFocus;
    lblFreCot: TLabel;
    pnlVolumeSepExc: TPanel;
    lblQtdTraSepExc: TLabel;
    edtQtdTraSepExc: TEditFocus;
    lblQtdTraSepNExc: TLabel;
    edtQtdTraSepNExc: TEditFocus;
    pnlEmpFat: TPanel;
    lblEmpFat: TLabel;
    edtCodEmpFat: TEditFocus;
    edtDesEmpFat: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure btnCalcFreSugClick(Sender: TObject);
    procedure btnCalcVolumeClick(Sender: TObject);
    procedure edtValFreEnter(Sender: TObject);
    procedure edtValFreExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrHideHintsTimer(Sender: TObject);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDespesasFaturamentoClick(Sender: TObject);
    procedure btnAdicionarContatoClick(Sender: TObject);
    procedure btnPesquisarContatoClick(Sender: TObject);
    procedure edtTraRedCodKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRotKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTpaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpFatKeyPress(Sender: TObject; var Key: Char);
  private
    objValidacoesFrete : TValidacoesFrete;
    qryConCta, qryCadTra: TUniQuery;
    strCodTraAnt: String;
    strTipFreAnt: String;
    fltValFreAnt: Double;
    fltValFreAntTrava: Double;
    fltFreCotAnt: Double;
    fltDesAceIPI: Double;

    intSemaforo: Integer;

    blnCalcFreteSugestaoRegia: Boolean;
    blnCalcFreteSugestaoTranp: Boolean;
    blnCalcFreteSugestaoItens: Boolean;
    blnSomenExibirSugestFrete: Boolean;
    blnCalcFreteSugestaoFaixa: Boolean;

    strCCuFpg: String;
    objLiberacao  : TLiberacao;

    blnZeraFrete: Boolean;

    strCodRotLib: String;
    stlRotLib : TStringList;
    blnLiberouTranspVaziaItensEntrega: Boolean;
    blnLiberouTranspVaziaItensRetira: Boolean;
    blnLiberouAlteraTranspOrcamento: Boolean;
    blnLiberouAlteraTranspItensRetira: Boolean;
    blnLiberouAlteraTranspItensEntrega: Boolean;

    function fGetInputPassarZeroEmitenteCIF: TInputPassarZeroEmitenteCIF;
    procedure pCarregaCentroCusto;
    procedure pCarregaCadTra;
    function  fMsgObrigatoria: Boolean;
    procedure pCalculaFreteSugestao;
    function fRetornaAlturaElementosRodape: Integer;
    procedure pSetaCentroCusto(strCCusto: String);
    function fValidaRota(strCodRot: String; var dtaDtaEnt: TDateTime): Boolean;
    function fRetCidadeEndEnt(strAutEnt: String): String;
    procedure pCalcVolumeSepExclusiva;
    function fExibePainelRota: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fatVenda        : TFatVenda;
    blnConfirma     : Boolean;
    blnPodeCancelar : Boolean;
    blnSenhaValidade: Boolean;
    procedure pOnShow;
  end;


implementation

uses  untPai, untPesqAux, untfuncoesSimples, Data.DB, untTypesSistema,
      untConsultas, untTipoFreteAtc, untConstantes, untCadClientes, untFuncoes,
      untMsgLiberacao, untProjetos, untValidacoesRotasRegiao;

{$R *.dfm}

procedure TfrmFatDigMensagemGenerica.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (fVerificaCampos) Then
  Begin
    {*********************************}
    { Verifica se é obrigatório a msg }
    {******************************RV*}
    If fMsgObrigatoria Then
    Begin
      blnConfirma := False;
      Exit;
    End;

    If pnlDesAce.Visible Then
    Begin
      fatVenda.fltDesAce := fStrToFloat(edtDesAce.Text);
      fatVenda.fltDeADig := fStrToFloat(edtDesAce.Text);
    End
    Else
    Begin
      If (Not fatVenda.fEhDevolucaoEspelhoOuParaFornecedor) And (Not (fatVenda.strOpcDoc = 'CI')) Then
      Begin
        fatVenda.fltDesAce := 0;
        fatVenda.fltDeADig := 0;
      End;
    End;

    fatVenda.strCodEve := fraCentroCusto.edtCodEve.Text;
    fatVenda.strMen001 := edtMens01.Text;
    fatVenda.strMen002 := edtMens02.Text;
    fatVenda.strMenExp := edtMenExp.Text;
    fatVenda.strMenEx2 := edtMenEx2.Text;
    fatVenda.strMenEx3 := edtMenEx3.Text;
    fatVenda.strMenEx4 := edtMenEx4.Text;

    fatVenda.strCodCta := fraPlanoDeContas.MskCodCta.Text;
    fatVenda.fltValFre := fStrToFloat(edtValFre.Text);
    fatVenda.strTipFre := fTipoFrete(cmbTipFre.Text);
    fatVenda.strNumReg := edtNumReg.Text;
    fatVenda.strCodTpA := edtCodTpa.Text;
    fatVenda.intQtdTra := StrToInt(edtQtdTra.Text);
    fatVenda.strEntUrg := IIF(chkEntUrg.Checked, 'S', 'N');
    fatVenda.strNomTra := edtNomTra.Text;
    fatVenda.strCodPrj := edtCodPrj.Text;
    fatVenda.strNomPrj := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [edtCodPrj.Text], False);

    If pnlVolumeSepExc.Visible Then
    Begin
      fatVenda.intQtdTraSepExc  := StrToIntDef(edtQtdTraSepExc.Text, 0);
      fatVenda.intQtdTraSepNExc := StrToIntDef(edtQtdTraSepNExc.Text, 0);
    End;

    if pnlNotPau.Visible then
      fatVenda.strNotPau := edtNotPau.Text;

    If pnlRota.Visible Then
    begin
      fatVenda.strCodRot := edtCodRot.Text;
    end
    else if (not fEmptyStr(fatVenda.strCodRot)) and (not fCfgSis('RECIEF', varBoolean)) and (fatVenda.blnBaiEntFut) then
    begin
      fatVenda.strCodRot := '';
    end;

    if edtValFreCot.Visible then
      fatVenda.fltFreCot := fStrToFloat(edtValFreCot.Text);

    pCalculaFreteSugestao;

    If (Not edtValFre.ReadOnly) And (Not blnSomenExibirSugestFrete) Then
    Begin
      If (blnCalcFreteSugestaoTranp) Or
         (blnCalcFreteSugestaoRegia) Or
         (blnCalcFreteSugestaoItens) Or
         (blnCalcFreteSugestaoFaixa) Then
      Begin
        If Not fatVenda.fValidaFreteSugestao(fatVenda.fltFreSug) Then
        Begin
          blnConfirma := False;
          Exit;
        End;
      End;
    End;

    If (fatVenda.fTravaAoZerarFrete(fltValFreAntTrava, fStrToFloat(edtValFre.Text))) Then
    Begin
      If Not fatVenda.fValidaFreteDigitado(fltValFreAntTrava) Then
      Begin
        blnConfirma := False;
        Exit;
      End;
    End;

    If fEmptyStr(fatVenda.strNumOrc) Then
      fatVenda.blnSetouTipoFreteSugestao := True;

    If (pnlEmpFat.Visible) Then
    Begin
      fatVenda.strEmpFatSemSaldo := edtCodEmpFat.Text;
      fatVenda.strEmpLog := VS_strCodEmp;
    End;

    If (Pos(fatVenda.strOpcDoc, 'DV_') > 0) And  (Pos(fatVenda.strEspDoc, 'DV_') > 0) And (Not fatVenda.fValidaDevolucaoComFreteSuperiorAoDocumentoOriginal) Then
    Begin
      blnConfirma := False;
      Exit;
    End;

    If (Assigned(objValidacoesFrete)) And (Not objValidacoesFrete.PermitePassarComFreteZeroEmitenteCIF(fGetInputPassarZeroEmitenteCIF)) Then
    Begin
      blnConfirma := False;
      Exit;
    End;

    blnConfirma := True;
    Close;

  End;

end;

procedure TfrmFatDigMensagemGenerica.btnDespesasFaturamentoClick(Sender: TObject);
begin
  inherited;
  If btnDespesasFaturamento.Visible And Assigned(fatVenda.objDespesasFaturamento) Then
  Begin
    fatVenda.objDespesasFaturamento.pExibirDigitacaoDespesas;
    edtDesAce.Text := FormatFloat('#,##0.00', fatVenda.objDespesasFaturamento.fltValorTotal);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigMensagemGenerica.btnMostraMargemClick(Sender: TObject);
begin
  inherited;
  If (btnMostraMargem.Enabled) And (btnMostraMargem.Visible) Then
  Begin

    If InterlockedIncrement(intSemaforo) = 0 Then
    Begin

      Try
        fatVenda.strCodTra := edtCodTra.Text;
        fatVenda.fltValFre := fStrToFloat(edtValFre.Text);
        pCalculaFreteSugestao;                
        fatVenda.pMostraMargemComFrete;
        pSetFocus(ActiveControl);

        InterlockedDecrement(intSemaforo);
      Except
        InterlockedDecrement(intSemaforo);
      End;

    End
    Else
      InterlockedDecrement(intSemaforo);

  End;
end;

procedure TfrmFatDigMensagemGenerica.btnPesquisarContatoClick(Sender: TObject);
  Var
    cKey: Char;
    arrContatos: TConsultasArray;
begin
  inherited;

  cKey := Char('/');

  If fPesqCliCtt(Self, edtCliCtt, nil, cKey, arrContatos, fatvenda.strCodcli) Then
    If (Length(arrContatos) > 0) Then
      fatvenda.strCliCtt := arrContatos[0].strCodigo;
end;

procedure TfrmFatDigMensagemGenerica.edtCodRotKeyPress(Sender: TObject; var Key: Char);
Var
  arrRotReg : TConsultasArray;
begin
  inherited;

  If fPesqEntregasRotasRegiaoPdOr(Self, edtCodRot, Nil, Nil, Key, arrRotReg, True,
     IIF(fEmptyStr(fRetCidadeEndEnt(fatVenda.strAutEnt)), fatVenda.strCodCid, fRetCidadeEndEnt(fatVenda.strAutEnt)),
     IIF(fEmptyStr(fRetCidadeEndEnt(fatVenda.strAutEnt)), fatVenda.strCliCep, fatVenda.strCepEnt),
     True,
     fatVenda.fltPesBru,
     fatVenda.strIncOrc) Then
  Begin
    If fValidaCampos(edtCodRot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigMensagemGenerica.FormShow(Sender: TObject);
begin
  pOnShow;
end;

procedure TfrmFatDigMensagemGenerica.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Not blnPodeCancelar) And (Not blnConfirma) Then
    Action := caNone;
end;

procedure TfrmFatDigMensagemGenerica.FormCreate(Sender: TObject);
  Var
    intTipFre: Integer;
begin
  inherited;

  cmbTipFre.Clear;
  For intTipFre In TiposFrete Do
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));

  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE', Self);

  intSemaforo := -1;
  blnPodeCancelar  := TRUE;
  blnSenhaValidade := FALSE;

  stlRotLib := TStringList.Create;

  objLiberacao := TLiberacao.create;
  blnLiberouTranspVaziaItensEntrega := False;
  blnLiberouTranspVaziaItensRetira := False;
  blnLiberouAlteraTranspOrcamento  := False;
  blnLiberouAlteraTranspItensRetira := False;
  blnLiberouAlteraTranspItensEntrega := False;
end;

procedure TfrmFatDigMensagemGenerica.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLiberacao);
  If (Assigned(objValidacoesFrete)) Then
    FreeAndNil(objValidacoesFrete);
end;

procedure TfrmFatDigMensagemGenerica.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F4: btnMostraMargem.Click;
    VK_F10: btnConfirmaDados.Click;
  End;
end;

function TfrmFatDigMensagemGenerica.fRetCidadeEndEnt(strAutEnt: String): String;
var
  qryCons: TUniQuery;
begin
  Result := '';
  If Not fEmptyStr(strAutEnt) Then
  Begin
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ETC_CIDENT FROM ENTCLI WHERE AUTOINCREM = :AUTINC');
        ParamByName('AUTINC').AsString := strAutEnt;
        Open;

        Result := FieldByName('ETC_CIDENT').AsString;
      End;
    Finally
      FreeAndNil(qryCons);
    End;
  End;

end;

procedure TfrmFatDigMensagemGenerica.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);

end;

function TfrmFatDigMensagemGenerica.fRetornaAlturaElementosRodape: Integer;
  Const
    intGordurinha = 15;
begin
  Result := intGordurinha + pnlConfirma.Height+ pnlInfo.Height;
end;

function TfrmFatDigMensagemGenerica.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  dtaDtaEnt  : TDateTime;
  strObgrot : String;
  strTipoItem: String;
  strMsgLiberacao: String;
begin

  Result := True;

  If (Sender = fraPlanoDeContas.MskCodCta) And (pnlPlanoContas.Visible) Then
  Begin
    If Not fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
    Begin
      pCarregaCentroCusto;
      If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        if fraPlanoDeContas.MskCodCta.Visible then
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;
    End
    Else
    Begin
      fraPlanoDeContas.MskCodCta.Clear;
    End;

  End

  Else If (Sender = edtCodRot) And pnlRota.Visible Then
  Begin
    If Not fEmptyStr(edtCodRot.Text) Then
    Begin

      If strCodRotLib <> edtCodRot.Text Then
      Begin
        If Not fValidaRota(edtCodRot.Text, dtaDtaEnt) Then
        Begin
          fMensagem('ATENÇÃO!', 'Rota não permitida!', ['&Ok']);
          Result := False;
          strCodRotLib := '';
        End
        Else
          strCodRotLib := edtCodRot.Text;
      End;
    End
    Else
    Begin
      If (fatVenda.strEspDoc <> 'PR')  Then
      Begin
        strObgrot :=  fCampoTabela('TRA_OBGROT', 'CADTRA', ['TRA_CODTRA'], [edtCodTra.text]);
        if (fCfgSis('OBGROT', varString) = '1') or
           ((strObgRot = 'S') and (fCfgSis('OBGROT', varString) = '2'))then
        begin
          fMensagem('ATENÇÃO!', 'O Campo Rota deve ser preenchido!', ['&O k']);
          Result := False;
        end;
      End;
    End;
  End

  Else If (Sender = edtCodTra) And pnlTransportadora.Visible Then
  Begin
    If (fEmptyStr(edtCodTra.Text)) Then
    Begin
      If (Not blnLiberouTranspVaziaItensEntrega) And (fCfgSis('SEMTRA', varBoolean)) And (fatVenda.fTemItensEntregaImediata) And (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Limpar a transportadora quando houver itens de entrega imediata no Orçamento, Pedido ou Venda Normal.');
        objLiberacao.objMsgLibera.pAddSeparador(75);
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , fatVenda.strCodCli + '-' + fRetNomCliente(fatVenda.strCodCli) , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', fatVenda.fltTotGer)                   , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)            , 24);

        objLiberacao.strDirAce  := 'SEMTRA';
        objLiberacao.strMsgSen  := 'Limpar a transportadora quando houver itens de entrega imediata no Orçamento, Pedido ou Venda Normal.';
        objLiberacao.strCodOpe  := fatVenda.strCodVen;
        objLiberacao.strCodDig  := fatVenda.strCodDig;

        If Not objLiberacao.fLibera Then
        Begin
          edtNomTra.Clear;
          fMensagem('ATENÇÃO!', 'Transportadora não informada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtNomTra.Clear;
          blnLiberouTranspVaziaItensEntrega := True;
        End;
      End

      Else If (Not blnLiberouTranspVaziaItensRetira) And (fCfgSis('SERTRA', varBoolean)) And (fatVenda.fTemItensRetira) And (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Limpar a transportadora quando houver itens de retira no Orçamento, Pedido ou Venda Normal.');
        objLiberacao.objMsgLibera.pAddSeparador(75);
        objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , fatVenda.strCodCli + '-' + fRetNomCliente(fatVenda.strCodCli) , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', fatVenda.fltTotGer)                   , 24);
        objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)            , 24);

        objLiberacao.strDirAce  := 'SERTRA';
        objLiberacao.strMsgSen  := 'Limpar a transportadora quando houver itens de retira no Orçamento, Pedido ou Venda Normal.';
        objLiberacao.strCodOpe  := fatVenda.strCodVen;
        objLiberacao.strCodDig  := fatVenda.strCodDig;

        If Not objLiberacao.fLibera Then
        Begin
          edtNomTra.Clear;
          fMensagem('ATENÇÃO!', 'Transportadora não informada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          edtNomTra.Clear;
          blnLiberouTranspVaziaItensRetira := True;
        End;
      End

      Else
      Begin
        edtNomTra.Clear;
      End;
    End
    Else
    Begin
      If (fCfgSis('PERATF', varBoolean)) And (fCfgSis('FRETRA', varString) = FRETRA_POR_FAIXA_FATURAMENTO) Then
      Begin
        If (Not fatVenda.fVerificaTransportadoraVinculadaFreteFaixaFaturamento(edtCodTra.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Transportadora não atende a faixa de faturamento!', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (Not SameText(edtCodTra.Text, strCodTraAnt)) Then
      Begin
        If (Not blnLiberouAlteraTranspOrcamento) And (fatVenda.strEspDoc = 'OR') Then
         Begin
          strTipoItem := '';
          If (fatVenda.fTemItensEntregaImediata) And (fCfgSis('SATOIE', varBoolean)) Then //AINDA A DEFINIR
            strTipoItem := 'E'
          Else If (fatVenda.fTemItensRetira) And (fCfgSis('SATOIR', varBoolean)) Then
            strTipoItem := 'R';

          If Not fEmptyStr(strTipoItem) Then
          Begin
            strMsgLiberacao := IIF(strTipoItem = 'E', 'entrega imediata', 'retira');

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Alterar a transportadora quando houver itens de ' + strMsgLiberacao + ' no Orçamento.');
            objLiberacao.objMsgLibera.pAddSeparador(75);
            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , fatVenda.strCodCli + '-' + fRetNomCliente(fatVenda.strCodCli) , 24);
            objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', fatVenda.fltTotGer)                   , 24);
            objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)      , 24);
            objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Atual'    , edtCodTra.Text + '-' + fRetNomTransportadora(edtCodTra.Text)  , 24);

            objLiberacao.strDirAce := IIF(strTipoItem = 'E', 'SATOIE', 'SATOIR');
            objLiberacao.strMsgSen := 'Alterar a transportadora quando houver itens de ' + strMsgLiberacao + ' no Orçamento.';
            objLiberacao.strCodOpe := fatVenda.strCodVen;
            objLiberacao.strCodDig := fatVenda.strCodDig;

            If Not objLiberacao.fLibera Then
            Begin
              edtCodTra.Text := strCodTraAnt;
              fMensagem('ATENÇÃO!', 'Transportadora não alterada!', ['&Ok']);
              Result := False;
            End
            Else
            Begin
              blnLiberouAlteraTranspOrcamento := True;
            End;
          End;
        End

        Else If (Not blnLiberouAlteraTranspItensRetira) And (fCfgSis('ALRTRA', varBoolean)) And (fatVenda.fTemItensRetira) And (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And (Pos(fatVenda.strEspDoc, 'PD_VN_FF_CF_') > 0) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Alterar a transportadora quando houver itens de retira no Pedido ou Venda Normal.');
          objLiberacao.objMsgLibera.pAddSeparador(75);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , fatVenda.strCodCli + '-' + fRetNomCliente(fatVenda.strCodCli) , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', fatVenda.fltTotGer)                   , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)      , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Atual'    , edtCodTra.Text + '-' + fRetNomTransportadora(edtCodTra.Text)  , 24);

          objLiberacao.strDirAce  := 'ALRTRA';
          objLiberacao.strMsgSen  := 'Alterar a transportadora quando houver itens de retira no Pedido ou Venda Normal.';
          objLiberacao.strCodOpe  := fatVenda.strCodVen;
          objLiberacao.strCodDig  := fatVenda.strCodDig;

          If Not objLiberacao.fLibera Then
          Begin
            edtCodTra.Text := strCodTraAnt;
            fMensagem('ATENÇÃO!', 'Transportadora não alterada!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            blnLiberouAlteraTranspItensRetira := True;
          End;
        End

        Else If (Not blnLiberouAlteraTranspItensEntrega) And (fCfgSis('ALMTRA', varBoolean)) And (fatVenda.fTemItensEntregaImediata) And (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And (Pos(fatVenda.strEspDoc, 'PD_VN_FF_CF_') > 0) Then
        Begin

          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Alterar a transportadora quando houver itens de entrega imediata no Pedido ou Venda Normal.');
          objLiberacao.objMsgLibera.pAddSeparador(75);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , fatVenda.strCodCli + '-' + fRetNomCliente(fatVenda.strCodCli) , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Documento'      , FormatFloat('#,##0.00', fatVenda.fltTotGer)                   , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Anterior' , strCodTraAnt + '-' + fRetNomTransportadora(strCodTraAnt)      , 24);
          objLiberacao.objMsgLibera.pAddTextoCaption('Transportadora Atual'    , edtCodTra.Text + '-' + fRetNomTransportadora(edtCodTra.Text)  , 24);

          objLiberacao.strDirAce  := 'ALMTRA';
          objLiberacao.strMsgSen  := 'Alterar a transportadora quando houver itens de entrega imediata no Pedido ou Venda Normal.';
          objLiberacao.strCodOpe  := fatVenda.strCodVen;
          objLiberacao.strCodDig  := fatVenda.strCodDig;

          If Not objLiberacao.fLibera Then
          Begin
            edtCodTra.Text := strCodTraAnt;
            fMensagem('ATENÇÃO!', 'Transportadora não alterada!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            blnLiberouAlteraTranspItensEntrega := True;
          End;
        End
      End;

      If Result Then
      Begin
        pCarregaCadTra;
        If qryCadTra.FieldByName('TRA_CODTRA').IsNull Then
        Begin


          If (blnCalcFreteSugestaoTranp) Then
          Begin

            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoTranp, fRetMsgTransportadoraNaoEncontrada(fatVenda.fRetornaStrCodCidEntAtual),
                                                                 fRetMsgTransportadoraNaoEncontrada), ['&Ok']);
          End
          Else
          If (blnCalcFreteSugestaoRegia) Then
          Begin

            fMensagem('ATENÇÃO!', IIF(blnCalcFreteSugestaoRegia, fRetMsgTransportadoraNaoEncontrada(fatVenda.fRetornaStrCodRegEntAtual, True),
                                                                 fRetMsgTransportadoraNaoEncontrada('', True)), ['&Ok']);
          End;

          Result := False;

        End

        Else If (Not fRetTransportadoraAtiva(edtCodTra.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Transportadora está inativada!', ['&Ok']);
          Result := False;
        End

        Else
        Begin
          If (Pos(fatVenda.strOpcDoc, 'CF_') <= 0) And (Not fatVenda.blnBaiEntFut) And (fatVenda.fPermitirFreteNoFaturamento) And (Not blnZeraFrete) Then
          Begin
            If (blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia) And (Not blnSomenExibirSugestFrete) And (blnBuscaPorChave) Then
            Begin

              pCalculaFreteSugestao;
              If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
                edtValFre.Text := '0,00'
              Else If (fCfgSis('CARFRE', varString) = 'N') Or
                      (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?', ['','']) = 1) Then
                edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);
            End
            Else

            Begin

              If (Not blnCalcFreteSugestaoTranp) And
                 (Not blnCalcFreteSugestaoRegia) And
                 (Not blnCalcFreteSugestaoItens) And
                 (Not blnCalcFreteSugestaoFaixa) And
                 (((fStrToFloat(edtValFre.Text) = 0) And fEmptyStr(fatVenda.strNumOrc)) Or
                 (Not SameText(edtCodTra.Text, strCodTraAnt))) Then
              Begin
                If (fCfgSis('CARFRE', varString) = 'N') Or
                   ((qryCadTra.FieldByName('TRA_VALFRE').AsFloat > 0) And
                   (fMensagem('', 'Deseja carregar o valor do frete da transportadora selecionada?' + #13#10 + 'Valor ' + FormatFloat('#0.00', qryCadTra.FieldByName('TRA_VALFRE').AsFloat), ['','']) = 1)) Then
                  edtValFre.Text := FormatFloat('#0.00', qryCadTra.FieldByName('TRA_VALFRE').AsFloat);
              End
              Else
              If ((blnCalcFreteSugestaoItens Or (blnCalcFreteSugestaoFaixa)) And
                 (Not SameText(edtCodTra.Text, strCodTraAnt))) Then
              Begin
                pCalculaFreteSugestao;
                If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
                  edtValFre.Text := '0,00'
                Else
                  edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);
              End;
            End;
          End;
        End;
      End;
    End;

    If Result Then
    Begin
      strCodTraAnt := edtCodTra.Text;
      If blnBuscaPorChave Then
        fltValFreAntTrava := fStrToFloat(edtValFre.Text);
    End;

    fatVenda.strCodTra := edtCodTra.Text;
  End

  Else If (Sender = edtTraRedCod) Then
  Begin
    If (fEmptyStr(edtTraRedCod.Text)) Then
      edtTraRedNom.Clear
    Else
    Begin
      edtTraRedNom.Text := fRetNomTransportadora(edtTraRedCod.Text);

      If fEmptyStr(edtTraRedNom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End;

    fatVenda.strTraRdp := edtTraRedCod.Text;
  End

  Else If (Sender = edtValFre) And pnlDadosFrete.Visible Then
  Begin

    If (Not fEmptyStr(edtValFre.Text)) Then
    Begin

      If fStrToFloat(edtValFre.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do frete deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      {*********************************************************}
      {* SE CASO A VENDA FOR MAIOR QUE O VALOR DE CONFIGURAÇÃO *}
      {* DE INSEÇÃO DO FRETE, NÃO DEIXA COBRAR O FRETE.        *}
      {*******************************************************FC}
      Else If (fFormataFloat(fltValFreAnt, 2) <> fFormataFloat(fStrToFloat(edtValFre.Text), 2)) And
              (fFormataFloat(fatVenda.fltTotPro - fatVenda.fltDesEsp, 2) >= fFormataFloat(fatVenda.fltVlMinF, 2)) And
              (fStrToFloat(edtValFre.Text) > 0.0) Then
      Begin
        If fMensagem('ATENÇÃO!', 'O Valor da venda é maior / igual ao valor mínimo para isenção da cobrança do frete. O que deseja fazer?'
                               , ['&Continuar e zerar o frete', '&Manter o frete digitado'], 1, False, 1, 210) = 1 Then
          edtValFre.Text := '0,00';
      End;

      fltValFreAnt := fStrToFloat(edtValFre.Text);

      If (Pos(fatVenda.strOpcDoc, 'VN_CP_') > 0) And (fatVenda.strEspDoc = 'IF') And pnlDesAce.Visible Then
      Begin
        fatVenda.fltDesAce := fStrToFloat(edtDesAce.Text);
        fatVenda.fltDeADig := fStrToFloat(edtDesAce.Text);
        fatVenda.fltValFre := fStrToFloat(edtValFre.Text);
        fatVenda.fltFreDig := fStrToFloat(edtValFre.Text);

        fatVenda.pCalculaTotGer(False, True);

        fltDesAceIPI := fatVenda.fValorTotalDeIpiComoDespesaAcessoria;

        If fltDesAceIPI > 0 Then
        Begin
          edtDesAce.Text := FormatFloat('#,##0.00', fltDesAceIPI);
        End;
      End;

    End;
  End

  Else If (Sender = cmbTipFre) And pnlDadosFrete.Visible Then
  Begin
    If (fCfgSis('TRPPRM', varBoolean)) And (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido!', ['&O k']);
    End

    Else If (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Or
         (Not fPermiteFreteProprio(fTipoFrete(cmbTipFre.Text))) Then
    Begin
      Result := False;
    End
    Else
    Begin
      If (fTipoFrete(cmbTipFre.Text) = '9') And (fStrToFloat(edtValFre.Text) > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido:' +#13+
                              'Emitente(CIF), Destinatário(FOB) ou Terceiros', ['&O k']);
        Result := False;
      End;
    End;

    If Result And
      blnCalcFreteSugestaoFaixa And
      (fTipoFrete(cmbTipFre.Text) <> strTipFreAnt) And
      (Not fatVenda.blnBaiEntFut) Then
    Begin
      pCalculaFreteSugestao;
      If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
        edtValFre.Text := '0,00'
      Else
        edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);
    End;

    If Not fTipoFretePermitidoTransportadora(edtCodTra.Text, fTipoFrete(cmbTipFre.Text)) Then
    Begin
      If Not fatVenda.fLiberaTipoFreteNaoPermitidoTransportadora(edtCodTra.Text,  cmbTipFre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de frete: "' + cmbTipFre.Text + '" ' + sLineBreak +
                              'não se encontra na lista de tipos de fretes permitidos para a transportadora.' + sLineBreak +
                              'Verifique o cadatro da transportadora.', ['&OK']);
        Result := False;
      End;
    End;

    If Result Then
      strTipFreAnt := fTipoFrete(cmbTipFre.Text);
  End

  Else If (Sender = edtDesAce) And (pnlDesAce.Visible) Then
  Begin

    If (Not fEmptyStr(edtDesAce.Text)) Then
    Begin

      If (fStrtoFloat(edtDesAce.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor da despesa acessória deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = edtQtdTra) And pnlVolumes.Visible Then
  Begin

    If (Not fEmptyStr(edtQtdTra.Text)) Then
    Begin
      If fStrToFloat(edtQtdTra.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

      If pnlVolumeSepExc.Visible Then
      Begin
        edtQtdTraSepNExc.Text := FloatToStrF(fStrToFloat(edtQtdTra.Text) - fStrToFloat(edtQtdTraSepExc.Text), ffFixed, 12, 0);

        If fStrToFloat(edtQtdTraSepNExc.Text) < 0.0 Then
        Begin
          pMensagemOk('O campo "Volume dos itens de Separação não Exclusiva" não pode ficar negativo. '+
            'Ajuste o Volume para poder continuar (ele deve ser maior ou igual ao volume dos itens '+
            'de separação exclusiva) ou revise as configurações de cálculo de volume, pois o volume '+
            'dos itens de separação exclusiva devem seguir as configurações de cálculo de volume do Sistema.');
          Result := False;
        End;

        If fStrToFloat(edtQtdTra.Text) <> (fStrToFloat(edtQtdTraSepExc.Text) + fStrToFloat(edtQtdTraSepNExc.Text)) Then
        Begin
          pMensagemOk('O Volume deve ser igual à soma dos campos "Volume dos itens de Separação Exclusiva" e '+
            '"Volume dos itens de Separação Não Exclusiva". Realize o ajuste do campo do volume para poder continuar.');
          Result := False;
        End;
      End;
    End;

  End

  Else If (Sender = fraCentroCusto.edtCodEve) And pnlEventos.Visible Then
  begin
    If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    Begin
      fraCentroCusto.edtDesEve.Text := fRetNomEventoExiFat(fraCentroCusto.edtCodEve);
      If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End
    Else
    begin
      fraCentroCusto.edtDesEve.Clear;

      if fCfgSis('OBGCCF', varBoolean) then
      begin
        fMensagem('','Atenção! É obrigatório o preenchimento do campo "Centro de Custos" conforme definido na configuração CFG_OBGCCF.',['&OK']);
        Result := False
      end;
    end;
  end

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
      If Not TProjeto.fClienteTemProjetoAtivo(fatVenda.strCodCli, edtCodPrj.Text) Then
      Begin
        fMensagem('', 'Projeto não encontrado para o cliente do pedido!', ['&Ok']);
        Result := False;
        edtDesPrj.Clear;
      End;
    End;
  End

  Else If (Sender = edtNotPau) And (pnlNotPau.Visible) Then
  Begin
    If Not (MatchStr(edtNotPau.Text, ['S', 'N'])) Then
    Begin
      fMensagem('', 'Nota Fiscal Paulista deve ser preenchido com "S" ou "N"!', ['&OK']);
      Result := False;
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
        fMensagem('ATENÇÃO!', 'O Tipo de Atendimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodEmpFat) And (pnlEmpFat.Visible) Then
  Begin
    if fEmptyStr(edtCodEmpFat.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Empresa de Faturamento deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesEmpFat.Text := fRetNomeEmpresa(edtCodEmpFat.Text);
      If fEmptyStr(edtDesEmpFat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtValFreCot) and (edtValFreCot.Visible) Then
  Begin

    If (Not fEmptyStr(edtValFreCot.Text)) Then
    Begin

      If fStrToFloat(edtValFreCot.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do frete cotado deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
    End
    Else
      edtValFreCot.Text := '0,00';

    fltFreCotAnt := StrToFloatDef(edtValFreCot.Text,0);
  End;

  If (Not Result) Then
  Begin
    pSetFocus(Sender);
  End;

end;

function TfrmFatDigMensagemGenerica.fValidaRota(strCodRot: String; var dtaDtaEnt: TDateTime): Boolean;
var
  objRotReg : TRotReg;
begin
  objRotReg := nil;
  Try
    Try
      objRotReg           := TRotReg.Create(Self);
      objRotReg.strCodRot := strCodRot;
      objRotReg.fltPesBru := fatVenda.fltPesBru;
      objRotReg.fltTotPro := fatVenda.fltTotPro;
      objRotReg.strCodVen := fatVenda.strCodVen;
      objRotReg.strCodDig := fatVenda.strCodDig;
      objRotReg.strNumOrc := IIF(fEmptyStr(fatVenda.strNumOrc),'',fatVenda.strNumOrc + '-' + fatVenda.strEspDoc + '-' + VS_strCodEmp);
      objRotReg.strCodCli := fatVenda.strCodCli;
      objRotReg.strSeqFgo := fatVenda.strIncOrc;
      objRotReg.strEspDoc := fatVenda.strEspDoc;

      Result := objRotReg.fIniciaValidacoes;

      dtaDtaEnt := objRotReg.dtaDtaEnt;

      If Result Then
      Begin
        edtCodTra.Text := objRotReg.fRetTranspRota;
        edtNomTra.Text := fRetNomTransportadora(edtCodTra.Text);
      End;
    Except
      On E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[fValidaRota]');
      End;
    End;
  Finally
    objRotReg.Free;
  End;
end;

procedure TfrmFatDigMensagemGenerica.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmFatDigMensagemGenerica.pOnShow;
  Var
    strTipFat: String;
    fltPerDesAce: Double;
    fltVlrDesAce: Double;
    fltParDesAce: Double; //Valor por Condição a Prazo
begin
  inherited;

  If (Pos(fatVenda.strOpcDoc, 'CF_CI_CT_CS_') > 0) Then
    edtValFre.ReadOnly := (Not fCfgSis('ALFECF', varBoolean))
  Else If fatVenda.blnCliFil Then
    edtValFre.ReadOnly := (Not fCfgSis('ALFRTR', varBoolean))
  Else
    edtValFre.ReadOnly := (Not fCfgSis('ALTFRE', varBoolean)) Or (fatVenda.blnBaiEntFut);

  edtValFre.ReadOnly := (edtValFre.ReadOnly) Or (Not fatVenda.fPermitirFreteNoFaturamento);
  edtValFre.TabStop  := (Not edtValFre.ReadOnly);

  lblFreCot.Visible := fCfgSis('TRACOT', varBoolean) and (SameText(fatVenda.strEspDoc, 'FF'));
  edtValFreCot.Visible := lblFreCot.Visible;

  pnlVolumeSepExc.Visible := pnlVolumes.Visible And fCfgSis('SEPEXC', varBoolean);

  blnCalcFreteSugestaoRegia := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_REGIAO);
  blnCalcFreteSugestaoTranp := (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE);
  blnCalcFreteSugestaoItens := (fCfgSis('FRETRA') = FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA);
  blnCalcFreteSugestaoFaixa := (fCfgSis('FRETRA') = FRETRA_POR_FAIXA_FATURAMENTO);
  blnSomenExibirSugestFrete := (fCfgSis('SUGFRE') = '2');

  pnlTraRedesp.Visible := fCfgSis('UTTRDP', varBoolean);

  btnMostraMargem.Visible := (Pos(fatVenda.strOpcDoc, 'VN_') > 0) And
                             (blnCalcFreteSugestaoTranp Or
                              blnCalcFreteSugestaoRegia Or
                              blnCalcFreteSugestaoItens Or
                              blnCalcFreteSugestaoFaixa);

  fraCentroCusto.edtCodEve.Text := fatVenda.strCodEve;
  fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve.Text);

  edtMens01.Text := fatVenda.strMen001;
  edtMens02.Text := fatVenda.strMen002;

  edtMenExp.Text := fatVenda.strMenExp;
  edtMenEx2.Text := fatVenda.strMenEx2;
  edtMenEx3.Text := fatVenda.strMenEx3;
  edtMenEx4.Text := fatVenda.strMenEx4;

  pnlMenExp.Visible := fatVenda.strOpcDoc = 'VN';

  pnlNotPau.Visible := (fatVenda.strOpcDoc = 'CF') and (fatVenda.strEspDoc = 'IF') and (fatVenda.fUFsDestTribItems.Contains('SP')) and fCfgSis('NFPCLI', varBoolean);

  fraPlanoDeContas.MskCodCta.Text := fatVenda.strCodCta;
  pCarregaCentroCusto;
  edtCodTra.Text := fatVenda.strCodTra;
  edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fltValFre);
  edtValFreCot.Text := FormatFloat('#,##0.00', fatVenda.fltFreCot);
  cmbTipFre.ItemIndex := cmbTipFre.Items.IndexOf(fDescricaoFrete(fatVenda.strTipFre));
  edtNumReg.Text := fatVenda.strNumReg;

  edtCliCtt.Text := fRetNomContatoCliente(fatVenda.strCliCtt);

  If fCfgSis('AUTCTT', VarBoolean) And (Not fEmptyStr(fatVenda.strCliCtt)) Then
  Begin
    btnPesquisarContato.Enabled := False;
    btnAdicionarContato.Enabled := False;
  End;

  edtQtdTra.Text := IntToStr(fatVenda.intQtdTra);

  If pnlVolumeSepExc.Visible Then
  Begin
    edtQtdTraSepExc.Text  := IntToStr(fatVenda.intQtdTraSepExc);
    edtQtdTraSepNExc.Text := IntToStr(fatVenda.intQtdTraSepNExc);
  End;

  If (Not fEmptyStr(fatVenda.strCodTra)) Then
  Begin
    edtCodTra.Text := fatVenda.strCodTra;
  End
  Else
  Begin
    If (Not fEmptyStr(fCfgSis('TRASUG'))) Then
      edtCodTra.Text := fCfgSis('TRASUG');
  End;
  pCarregaCadTra;

  edtTraRedCod.Text := fatVenda.strTraRdp;
  fValidaCampos(edtTraRedCod);

  If pnlDadosFrete.Visible And
    (Not blnCalcFreteSugestaoTranp) And
    (Not blnCalcFreteSugestaoRegia) And
    (Not blnCalcFreteSugestaoItens) And
    (Not blnCalcFreteSugestaoFaixa) And
    (Not fEmptyStr(edtCodTra.Text)) Then
  Begin
    If fEmptyStr(fatVenda.strNumOrc) Then
    Begin
      If (fatVenda.fltFreDig <= 0) Then
        fatVenda.fltFreDig := qryCadTra.FieldByName('TRA_VALFRE').AsFloat;
    End
    Else
    Begin
      If (fatVenda.fltFreDig <= 0) And (fatVenda.fTemItensEntrega(fatVenda.arrMatItens)) And (qryCadTra.FieldByName('TRA_VALFRE').AsFloat > 0) Then
      Begin
        If fMensagem('ATENÇÃO!', 'Foi detectado itens com entrega!' + #10#13 +
                                  'Deseja carregar o frete de R$ '+FormatFloat(',0.00', qryCadTra.FieldByName('TRA_VALFRE').AsFloat)+'?', ['&Sim', '&Não']) = 1 Then
          fatVenda.fltFreDig := qryCadTra.FieldByName('TRA_VALFRE').AsFloat;
      End;
    End;
  End;

  edtValFre.Text        := IfThen(Not fatVenda.fPermitirFreteNoFaturamento, '0,00', FormatFloat('#,##0.00', fatVenda.fltFreDig));

  cmbTipFre.ItemIndex   := cmbTipFre.Items.IndexOf(fDescricaoFrete(fatVenda.fGetTipoFreteSugestao));
  cmbTipFre.Enabled     := fatVenda.fPermitirFreteNoFaturamento;

  btnCalcFreSug.Visible := False;

  If (blnCalcFreteSugestaoItens Or
      blnCalcFreteSugestaoTranp Or
      blnCalcFreteSugestaoRegia Or
      blnCalcFreteSugestaoFaixa) And
     (Not blnSomenExibirSugestFrete) And
     (fatVenda.fPermitirFreteNoFaturamento) And
     (Not fatVenda.blnBaiEntFut) Then
  Begin
    btnCalcFreSug.Visible := (Not edtValFre.ReadOnly);

    If (fEmptyStr(fatVenda.strNumOrc)) And (Pos(fatVenda.strOpcDoc, 'CF_CI_CT_CP_TR_DV_') <= 0) Then
    Begin
      pCalculaFreteSugestao;
      If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
        edtValFre.Text := '0,00'
      Else
        edtValFre.Text := FloatToStrF(fatVenda.fltFreSug, ffNumber, 12, 2);
    End;

  End;

  blnZeraFrete := (fCfgSis('ZERFRE', varBoolean)) and (fatVenda.fPossuiSomenteItensRetira) And
                  (Not MatchStr(fatVenda.strOpcDoc, ['NE','CF','CI','CP']));

  If (blnZeraFrete) Then
  Begin
    edtValFre.Text := '0,00';
    edtValFre.Enabled := False;
    fatVenda.blnZerouFrete_CFG_ZERFRE := True;
  End
  Else
    fatVenda.blnZerouFrete_CFG_ZERFRE := False;


  blnConfirma    := False;

  fatVenda.strCodTraAnt := edtCodTra.Text;
  fatVenda.strNomTraAnt := edtNomTra.Text;
  fatVenda.fltValFreAnt := StrToFloatDef(edtValFre.Text,0);

  If (SameText(fatVenda.strEspDoc, 'DV')) And
     (Not fEmptyStr(fCfgSis('CTRCDV')))   Then
    strCCuFpg := fCfgSis('CTRCDV')
  Else
    strCCuFpg := fRetCCustoFpg(fatVenda.strCodFpg);

  If (Not fCfgSis('CTAFAT', varBoolean))                 Or
     (Pos(fatVenda.strEspDoc, 'IF_IV_MI_FF_TR_DV') <= 0) Or
     (Pos(fatVenda.strClaFis, VS_strClaVen) <= 0)        Then
  Begin
    pnlPlanoContas.Visible := False;
  End
  Else
  Begin
    If (fatVenda.fExibirCentroDeCustoNoFaturamento) Then
      pSetaCentroCusto(strCCuFpg);
  End;

  pnlEventos.Visible := fCfgSis('EVEFAT', varBoolean) And
                        (Pos(fatVenda.strEspDoc, 'MI_FF_NF_EL_IF_IV_D1_TR_DV_') > 0) And
                        (fatVenda.strOpcDoc <> 'OF');

  If Assigned(fatVenda.objDespesasFaturamento) And (Pos(fatVenda.strEspDoc, 'MI_FF_') > 0) Then
  Begin
    pnlDesAce.Visible  := True;
    if not fCfgSis('ALDAVF', varBoolean) then
    begin
      edtDesAce.ReadOnly := True;
      edtDesAce.TabStop  := False;
      edtDesAce.Color    := $00FFDFB8;
    end;
    edtDesAce.Text     := FormatFloat('#,##0.00', fatVenda.objDespesasFaturamento.fltValorTotal);
    btnDespesasFaturamento.Visible := True;
  End
  Else If (fatVenda.strCliDAc = 'S') And (Pos(fatVenda.strOpcDoc, 'VN_') > 0) Then
  Begin
    fltVlrDesAce := 0;

    strTipFat := '';

    If fCfgSis('TPDCEX') = '1' Then
    Begin
      If fatVenda.strEspDoc = 'NF' Then strTipFat := 'A';
      If fatVenda.strEspDoc = 'FF' Then strTipFat := 'B';
      If fatVenda.strEspDoc = 'IF' Then strTipFat := 'C';
    End;

    If fCobrarDespAcessCondPagto(fatVenda.strCodCnd, fatVenda.strCodCli, strTipfat) Then
    Begin
      fltVlrDesAce := fRetornaDesAceUnicoPorVenda(fatVenda.strCodCnd);
      fltPerDesAce := fRetornaDesAceCnd(fatVenda.strCodCnd);
      fltParDesAce := fRetornaDesAcePrazoCnd(fatVenda.strCodCnd, fatVenda.strConPag);

      If fltPerDesAce > 0 Then
        fltVlrDesAce := fltVlrDesAce + fatVenda.fltTotPro * fltPerDesAce / 100.00;

      fltVlrDesAce := fltVlrDesAce + fltParDesAce;
    End;

    fltVlrDesAce := fltVlrDesAce + fCfgSis('VLDEAC', varDouble);

    If fltVlrDesAce > 0 Then
    Begin
      pnlDesAce.Visible  := True;
      edtDesAce.Text := FormatFloat('#,##0.00', fltVlrDesAce);
      if not fCfgSis('ALDAVF', varBoolean) then
      begin
        edtDesAce.ReadOnly := True;
        edtDesAce.TabStop  := False;
        edtDesAce.Color    := $00FFDFB8;
      end;
      btnDespesasFaturamento.Visible := False;
    End
    Else
      pnlDesAce.Visible := False;
  End
  Else
    pnlDesAce.Visible := False;

  chkEntUrg.Checked := fatVenda.strEntUrg = 'S';

  { Req.: 227012
  If (fatVenda.strOpcDoc = 'DV') And
     (fCfgSis('FRETRA') = FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA) Then
  Begin
    edtCodTra.Enabled := False;
  End;
  }

  pnlTipAte.Visible := (fatVenda.strOpcDoc = 'VN') And fCfgSis('VNDTPA', varBoolean);

  pnlProjeto.Visible := TProjeto.fClienteTemProjetoAtivo(fatVenda.strCodCli);

  If pnlProjeto.Visible Then
  Begin
    If Not fEmptyStr(fatVenda.strCodPrj) Then
    Begin
      edtCodPrj.Text := fatVenda.strCodPrj;
      fValidaCampos(edtCodPrj);
    End;

    edtCodPrj.Enabled := (fatVenda.strOpcDoc <> 'DV');
  End;

  strCodTraAnt := edtCodTra.Text;
  strTipFreAnt := fTipoFrete(cmbTipFre.Text);
  fltValFreAnt := fStrToFloat(edtValFre.Text);
  fltValFreAntTrava := fStrToFloat(edtValFre.Text);
  fltFreCotAnt := StrToFloatDef(edtValFreCot.Text,0);

  if edtDesAce.Enabled then
  begin
    edtDesAce.Enabled := fCfgSis('ALDAVF', varBoolean);
  end;

  If (Pos(fatVenda.strOpcDoc, 'VN_CP_') > 0) And (fatVenda.strEspDoc = 'IF') Then
  Begin
    fltDesAceIPI := fatVenda.fValorTotalDeIpiComoDespesaAcessoria;

    If fltDesAceIPI > 0 Then
    Begin
      pnlDesAce.Visible  := True;
      edtDesAce.Text := FormatFloat('#,##0.00', fltDesAceIPI);
      edtDesAce.ReadOnly := True;
      edtDesAce.TabStop  := False;
      edtDesAce.Color    := $00FFDFB8;
      btnDespesasFaturamento.Visible := False;
    End
  End;

  If (fatVenda.fZerarValFreDV) Then
  Begin
    edtValFre.Text := '0,00';
    fatVenda.pZerarValFreDV;
  End;

  If Not fEmptyStr(fatVenda.strCodTpA) Then
  Begin
    edtCodTpa.Text := fatVenda.strCodTpA;
    fValidaCAmpos(edtCodTpa);

    If pnlTipAte.Visible Then
    Begin
      If (Not fEmptyStr(fatVenda.strNumOrc)) And
         (Not fEmptyStr(edtDesTpa.Text)) And
         (Not fVerificaAcessoSistema('mnuAlteracaoTipoAtendPed')) Then
      Begin
         edtCodTpa.Enabled := False;
         edtCodTpa.Color   := edtDesTpa.Color;
      End;
    End;
  End;

  {**********************************************}
  {* VERIFICA SE UTILIZA A CONFIGURAÇÃO DA ROTA *}
  {* E REALIZA OS DEVIDOS TRATAMENTOS       :-) *}
  {******************************************TS**}
  strCodRotLib      := '';
  pnlRota.Visible := False;

  If (fExibePainelRota) Then
  Begin
    pnlRota.Visible := True;

    If Not fEmptyStr(fatVenda.strCodRot) Then
    Begin
      edtCodRot.Text := fatVenda.strCodRot;
      fValidaCampos(edtCodRot);
    End;
  End;

  if fatVenda.fRecebidoPorPix then
  begin
    edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fltValFre) ;
    edtCodTra.Text := fatVenda.strCodTra;
    pCarregaCadTra;
    edtValFre.Enabled := False ;
    edtCodTra.Enabled := False ;
    btnMostraMargem.Enabled := False ;
    cmbTipFre.Enabled := False ;
    btnDespesasFaturamento.Enabled := False ;
  end ;

  pnlEmpFat.Visible := (Pos(fatVenda.strOpcDoc, 'VN_') > 0) And fCfgSis('FATSSA', varBoolean);

  If (pnlEmpFat.Visible) Then
  Begin
    If Not fEmptyStr(fatVenda.strEmpFatSemSaldo) Then
      edtCodEmpFat.Text := fatVenda.strEmpFatSemSaldo
    Else If (Length(fatVenda.strCliCgc) > 11) Then
      edtCodEmpFat.Text := fCfgSis('SSAEPJ')
    Else
      edtCodEmpFat.Text := fCfgSis('SSAEPF');

    If Not fEmptyStr(edtCodEmpFat.Text) Then
      edtDesEmpFat.Text := fRetNomeEmpresa(edtCodEmpFat.Text);
  End;

  {************************************************************************************}
  { SEMPRE DEIXE ESSSA CHAMADA POR ÚLTIMO E COLOQUE NOVOS ELEMENTOS DENTRO DE pnlFundo }
  { EM "SUB-PAINEIS" COM ALIGN alTop, COMO OS DEMAIS                                   }
  {*********************************************************************************VA*}
  Self.ClientHeight := fRetornaSomaAlturaDosPaineisVisiveisEm(pnlFundo) + fRetornaAlturaElementosRodape;

  lblValFre.Caption := IIF(fatVenda.blnConsiderarValorDoFreteNaTravaDePreco,
                           'Frete à Cobrar:',
                           'Valor do Frete:');

  objValidacoesFrete := TValidacoesFrete.Create(fatVenda);
end;

function TfrmFatDigMensagemGenerica.fExibePainelRota : Boolean;
begin
  Result := False;

  If ((fCfgSis('RECIEF', varBoolean)) And (fatVenda.blnBaiEntFut) And (fatVenda.strEspDoc = 'PD')) Then
  Begin
    Result := True;
    Exit;
  End;

  If ((fatVenda.strEspDoc = 'PR') and (fCfgSis('REGCID', varBoolean))) Then
  Begin
    Result := True;
    Exit;
  End;

end;

function TfrmFatDigMensagemGenerica.fGetInputPassarZeroEmitenteCIF: TInputPassarZeroEmitenteCIF;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.EditValFre := edtValFre;
  Result.ComboTipFre := cmbTipFre;
  Result.CodigoTransportadora := edtCodTra.Text;
end;

procedure TfrmFatDigMensagemGenerica.pSetaCentroCusto(strCCusto: String);
begin
  fraPlanoDeContas.MskCodCta.Text := strCCusto;
  pCarregaCentroCusto;
end;

procedure TfrmFatDigMensagemGenerica.tmrHideHintsTimer(Sender: TObject);
begin
  inherited;
  If Screen.ActiveForm <> Self Then
    HintControler.HideHint;
end;

procedure TfrmFatDigMensagemGenerica.btnAdicionarContatoClick(Sender: TObject);
  Var
    strCliCtt, strContato: String;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    frmCadClientes.strCodClienteIniciarCadastro := fatvenda.strCodCli;
    frmCadClientes.blnCadContato := True;

    frmCadClientes.ShowModal();

    strCliCtt := frmCadClientes.strCodCliCtt;

    If (fEmptyStr(strCliCtt)) Then Begin
      fMensagem('ATENÇÃO!', 'Nenhum contato foi cadastrado!', ['&Ok']);
      fatvenda.strCliCtt := '';
      edtCliCtt.Text     := '';
    End Else Begin
      strContato := fRetNomContatoCliente(strCliCtt);

      If (Not fEmptyStr(strContato)) Then Begin
        fatvenda.strCliCtt := strCliCtt;
        edtCliCtt.Text     := strContato;
      End Else Begin
        fMensagem('ATENÇÃO!', 'Nenhum contato foi encontrado!', ['&Ok']);
        fatvenda.strCliCtt := '';
        edtCliCtt.Text     := '';
      End;
    End;
  Finally
    pFreeAndNil(frmCadClientes);
  End;
end;

procedure TfrmFatDigMensagemGenerica.btnCalcFreSugClick(Sender: TObject);
begin
  inherited;
  If (fatVenda.fPermitirFreteNoFaturamento) Then
  Begin
    pCalculaFreteSugestao;
    If (fatVenda.fltTotPro - fatVenda.fltDesEsp >= fatVenda.fltVlMinF) Then
      edtValFre.Text := '0,00'
    Else If fMensagem('', 'Deseja carregar o valor do frete sugestão?', ['', '']) = 1 Then
      edtValFre.Text := FormatFloat('#,##0.00', fatVenda.fltFreSug);
  End;
end;

procedure TfrmFatDigMensagemGenerica.btnCalcVolumeClick(Sender: TObject);
begin
  inherited;
  edtQtdTra.Text := FloatToStrF(fatVenda.fRetVolumes, ffFixed, 12, 0);
  If pnlVolumeSepExc.Visible Then
    pCalcVolumeSepExclusiva;
end;

procedure TfrmFatDigMensagemGenerica.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigMensagemGenerica.pCarregaCadTra;
begin

  If ((Not blnCalcFreteSugestaoTranp) And (Not blnCalcFreteSugestaoRegia)) Then
    pPesquisaCadTra(qryCadTra, qryCadTra, edtCodTra.Text)
  Else
  Begin
    If (blnCalcFreteSugestaoRegia) Then
      pPesquisaCadTraRegFrete(qryCadTra, qryCadTra, edtCodTra.Text, fatVenda.fRetornaStrCodRegEntAtual)
    Else
      pPesquisaCadTraCidFrete(qryCadTra, qryCadTra, edtCodTra.Text, fatVenda.fRetornaStrCodCidEntAtual);
  End;

  With qryCadTra Do
  Begin
    edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString
  End;
end;

procedure TfrmFatDigMensagemGenerica.edtCodTpaKeyPress(Sender: TObject;
  var Key: Char);
var
  arrTpaAte: TConsultasArray;
begin
  inherited;

  If fPesqTipoAtendimento(Self, edtCodTpa, edtDesTpa, Nil, Key, arrTpaAte) Then
  Begin
    if fValidaCampos(edtCodTpa, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigMensagemGenerica.edtCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp  : TConsultasArray;
  TipoConTra : TTipoConsultaTransportad;
  strCidReg  : String;
begin

  inherited;

  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If (blnCalcFreteSugestaoTranp) Then
  Begin
    TipoConTra := conTraCidFrete;
    strCidReg  := fatVenda.fRetornaStrCodCidEntAtual;
  End
  Else If (blnCalcFreteSugestaoRegia) Then
  Begin
    TipoConTra := conTraRegFrete;
    strCidReg  := fatVenda.fRetornaStrCodRegEntAtual;
  End
  Else
  Begin
    TipoConTra := conTraCompleta;
    strCidReg  := '';
  End;

  If fPesqTransportadora(TipoConTra, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp, True, strCidReg, 'S', fatVenda.fltTotGer) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatDigMensagemGenerica.edtTraRedCodKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTra : TConsultasArray;
begin
  inherited;
  If fPesqTransportadora(conTraCompleta, Self, edtTraRedCod, edtTraRedNom, Nil, Key, arrTra, True) Then
  Begin
    If fValidaCampos(edtTraRedCod, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatDigMensagemGenerica.edtValFreEnter(Sender: TObject);
begin
  inherited;
  pCalculaFreteSugestao;

  If blnSomenExibirSugestFrete Then
  Begin
    HintControler.ShowHint(Self.Left + pnlDadosFrete.Left + edtValFre.Left + edtValFre.Width,
                           15 + Self.Top + pnlDadosFrete.Top + edtValFre.Top + edtValFre.Height,
                           'Valor do frete sugestão: ' + FormatFloat('#,##0.00', fatVenda.fltFreSug), '');
  End;
end;

procedure TfrmFatDigMensagemGenerica.pCalculaFreteSugestao;
begin
  If (blnCalcFreteSugestaoTranp Or
      blnCalcFreteSugestaoRegia Or
      blnCalcFreteSugestaoItens Or
      blnCalcFreteSugestaoFaixa) And
      (not blnZeraFrete) Then
  Begin
    If (blnCalcFreteSugestaoTranp Or blnCalcFreteSugestaoRegia) Then
      fatVenda.fCalculaSugestaoFreteTransportadora(edtCodTra.Text, True, blnCalcFreteSugestaoRegia)
    Else
    If blnCalcFreteSugestaoItens Then
      fatVenda.fCalculaSugestaoFreteProdutos(edtCodTra.Text, True)
    Else
    If blnCalcFreteSugestaoFaixa Then
      fatVenda.fCalculaSugestaoFreteFaixaFaturamento(edtCodTra.Text, cmbTipFre.Text);
  End;
end;

procedure TfrmFatDigMensagemGenerica.pCalcVolumeSepExclusiva;
begin
  edtQtdTraSepExc.Text  := FloatToStrF(fatVenda.fRetVolumesSepExc, ffFixed, 12, 0);
  edtQtdTraSepNExc.Text := FloatToStrF(fStrToFloat(edtQtdTra.Text) - fStrToFloat(edtQtdTraSepExc.Text), ffFixed, 12, 0);
end;

procedure TfrmFatDigMensagemGenerica.edtValFreExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

function TfrmFatDigMensagemGenerica.fMsgObrigatoria: Boolean;
begin
  Result := False;
  If (fCfgSis('OBRMSG') = 'S') And (Not fatVenda.fEhVendaRapida(fatVenda.strCodCli)) Then
  Begin
    If (edtMens01.Text = '') Or (edtMens02.Text = '') Then
    Begin
      fMensagem('ATENÇÃO!', 'Mensagem obrigatória!', ['&Ok']);
      If (edtMens01.Text = '') Then
      Begin
        pSetFocus(edtMens01);
      End
      Else
      Begin
        pSetFocus(edtMens02);
      End;
      Result := True;
    End;
  End;
end;

procedure TfrmFatDigMensagemGenerica.edtCodEmpFatKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmpresa: TConsultasArray;
begin
  If fEntraCons(Key) Then
  begin
    If fPesqEmpresa(conEmpSimples, Self, edtCodEmpFat, edtDesEmpFat, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(edtCodEmpFat, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmFatDigMensagemGenerica.edtCodPrjKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPrj : TConsultasArray;
begin
  If fPesqProjetos(Self, edtCodPrj, edtDesPrj, qryTabela, Key, arrPrj, True, fatvenda.strCodcli) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

