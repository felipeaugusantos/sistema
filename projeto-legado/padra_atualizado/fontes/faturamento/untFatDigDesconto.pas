unit untFatDigDesconto;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, untFuncFatTypes,
  ExtCtrls, untFuncFat, EditFocus, AppEvnts, BitBtnLockedIncrem, cxHint,
  cxProgressBar, dxScreenTip, cxClasses, dxCustomHint,
  frxClass, frxExportCSVTestabilidade, Windows, System.Math,
  System.StrUtils;

type
  TfrmFatDigDesconto = class(TfrmPaiSimples)
    Label2: TLabel;
    edtPorDes: TEditFocus;
    Label4: TLabel;
    edtDesEsp: TEditFocus;
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    pnlDigDescontos: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    pnlTotalComPromocao: TPanel;
    lblTotalComPromocao: TLabel;
    lblValorDescPromocao: TLabel;
    edtTotalComPromocao: TEditFocus;
    edtValorDescPromocao: TEditFocus;
    pnlTotalBruto: TPanel;
    lblTotalBruto: TLabel;
    edtTotalBruto: TEditFocus;
    pnlTotalSemPromocao: TPanel;
    lblTotalSemPromocao: TLabel;
    edtTotalSemPromocao: TEditFocus;
    pnlSubTotProd: TPanel;
    lblSubTotProd: TLabel;
    edtSubTotProd: TEditFocus;
    lblPercDescPromocao: TLabel;
    edtPercDescPromocao: TEditFocus;
    pnlTotalLiquido: TPanel;
    Label5: TLabel;
    edtTotalLiquido: TEditFocus;
    pnlTotalDescontos: TPanel;
    Label8: TLabel;
    edtTotalDescontos: TEditFocus;
    pnlInfDescSemPromocao: TPanel;
    lblInfDescSemPromocao: TLabel;
    lblVlrLiqComPromocao: TLabel;
    edtVlrLiqComPromocao: TEditFocus;
    lblPercDescSemPromocao: TLabel;
    edtPercDescSemPromocao: TEditFocus;
    lblValorDescSemPromocao: TLabel;
    edtValorDescSemPromocao: TEditFocus;
    lblVlrLiqSemPromocao: TLabel;
    edtVlrLiqSemPromocao: TEditFocus;
    pnlVlrLiqSemPromoDig: TPanel;
    Label1: TLabel;
    edtVlrLiqSemPromoDig: TEditFocus;
    pnlTotLiqSemPromoDig: TPanel;
    Label3: TLabel;
    edtTotLiqSemPromoDig: TEditFocus;
    pnlTotBrutoSemPromoc: TPanel;
    Label6: TLabel;
    edtTotBrutoSemPromoc: TEditFocus;
    pnlTotBrutoComPromoc: TPanel;
    Label7: TLabel;
    edtTotBrutoComPromoc: TEditFocus;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Label9: TLabel;
    edtTotDesPer: TEditFocus;
    Shape6: TShape;
    Shape7: TShape;
    Label10: TLabel;
    edtPerTotalDescontos: TEditFocus;
    pnlVlrCheckOut: TPanel;
    lblVlrCheckOut: TLabel;
    Shape8: TShape;
    edtVlrCheckOut: TEditFocus;
    pnlStIpi: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    edtValSbt: TEditFocus;
    edtValIPI: TEditFocus;
    btnMostraMargem: TBitBtnLocked;
    pnlCupomDesconto: TPanel;
    Label14: TLabel;
    Shape10: TShape;
    edtCupDes: TEditFocus;
    Shape9: TShape;
    Shape11: TShape;
    pnlEsquerda: TPanel;
    pnlDireita: TPanel;
    Bevel1: TBevel;
    lblVlrMinComPromocao: TLabel;
    edtVlrMinComPromocao: TEditFocus;
    lblVlrMinSemPromocao: TLabel;
    edtVlrMinSemPromocao: TEditFocus;
    edtVlrMinTotalProdutos: TEditFocus;
    lblVlrMinTotalProdutos: TLabel;
    lblValFcpSt: TLabel;
    edtValFcpSt: TEditFocus;
    lblDesCsh: TLabel;
    edtDesCsh: TEditFocus;
    pnlImpostosReforma: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtTotCBS: TEditFocus;
    edtTotIS: TEditFocus;
    edtTotIBS: TEditFocus;
    pnlTotalDaVenda: TPanel;
    Label13: TLabel;
    edtTotVen: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPorDesEnter(Sender: TObject);
    procedure edtDesEspEnter(Sender: TObject);
    procedure edtPorDesExit(Sender: TObject);
    procedure edtDesEspExit(Sender: TObject);
    procedure btnMostraMargemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCupDesChange(Sender: TObject);
  private
    const
      MSG_VALOR_LIQUIDO_MENOR_CUSTO : String = 'O desconto aplicado sobre os produtos "não promocionais" irá resultar em ' +
                                               'um valor líquido menor que o preço de custo!' + sLineBreak +
                                               '** Produtos promocionais também serão considerados no rateio';
  private
    { Private declarations }
    fltDesMinConf: Double;
    strPorDesAnt: String;
    strDesEspAnt: String;

    strSubTotAposPorDes: string;

    intConfirmando: integer;

    procedure pAtualizaTotalGeral(blnBuscaPorChave: Boolean);
    procedure pAtualizaTotalLiquido(blnBuscaPorChave: Boolean);
    function fTemDescontoDoProfissional: Boolean;
    function fRecalculaPorDesComoDesEsp: Boolean;

    procedure pCalculaTotais;
    function fCalculaTotais(pgbStatus: TcxProgressBar = nil): Boolean;
    function fBloqueiaDesEspComPorDesSeCupomEspecial: Boolean;
    function fRetTotItensCheckOutQueNaoTeraoDesApl: Double;
    function fEfetivarApuracaoPosRateio: Boolean;
    function fTemItensRelacionadosAoCombo(arrItens: TMatrizFechamento): Boolean;
    function fTravarPercentualDescontoItens(arrItens: TMatrizFechamento): Boolean;
    function fEhNecessarioCalcularTotGer: Boolean;
    procedure pCalculaTotGerAoConfirmarDesconto;
  protected
    procedure pAjustarAlturaForm;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnTemTro: Boolean;

    fltTotGerAnt: Double;
    fltDesEspAnt: Double;
    fltPorDesAnt: Double;
    fatVenda: TFatVenda;
    blnPosDesEsp: Boolean;

    fltDesMaxProfiss: Double;

    blnValidarValorMinimo: Boolean;

    pOnCalculaTotGer   : TOnProcessaItem;

    pFuncCalculaTotais : procedure(blnAplicaDescontos: Boolean = False;
                                   intAutIncCalcMar: Integer = -1;
                                   pgbStatus: TcxProgressBar = nil;
                                   blnRecalcularMarLuc: Boolean = True) of Object;

    pMostraMargem : procedure (blnFatDigDesconto:Boolean=False) of Object;

    procedure pAtualizaInformacoesVenda;
    procedure pCarregaTela;

    procedure pBloqueiaCaixaDeDesconto;
    procedure pDesbloqueiaCaixaDeDesconto;

  end;


implementation

uses untfuncoesSimples, untGravando, untConstantes, untFatCupomDesconto,
     untTiposPix, Cashback.Classes;

{$R *.dfm}

procedure TfrmFatDigDesconto.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatDigDesconto.fTemItensRelacionadosAoCombo(arrItens: TMatrizFechamento): Boolean;
  Var
    intContador : Integer;
begin
  Result := False;
  For intContador := 0 To Length(arrItens)-1 Do
  Begin
    If (fatVenda.fItemRelacionadoCombo(arrItens[intContador])) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TfrmFatDigDesconto.fEfetivarApuracaoPosRateio: Boolean;
begin
  Result := True;

  If (fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDePromocao) Then
    Exit;

  If (fCfgSis('CMBDES', varString) = 'N') And (fTemItensRelacionadosAoCombo(fatVenda.arrMatItens)) Then
    Exit;

  Result := False;
end;

function TfrmFatDigDesconto.fEhNecessarioCalcularTotGer: Boolean;
begin
  Result := True;

  If (fatVenda.strOriF11 <> 'S') Then
    Exit;

  If (fatVenda.fltDesEsp <> 0) Then
    Exit;

  If (fatVenda.fltIcmOrg <> 0) Then
    Exit;

  If (fStrToFloat(edtPorDes.Text) <> 0) Then
    Exit;

  If (fStrToFloat(edtDesEsp.Text) <> 0) Then
    Exit;

  If (fStrToFloat(edtDesCsh.Text) <> 0) Then
    Exit;

  If (edtCupDes.Text <> EmptyStr) Then
    Exit;

  If (fFormataFloat(fltTotGerAnt, 2) <> (fFormataFloat(fatVenda.fltTotGer, 2))) Then
    Exit;

  If (fFormataFloat(fStrToFloat(edtPorDes.Text),2) <> fFormataFloat(fltPorDesAnt,2)) Then
    Exit;

  If (fFormataFloat(fStrToFloat(edtDesEsp.Text),2) <> fFormataFloat(fltDesEspAnt,2)) Then
    Exit;

  Result := False;
end;

procedure TfrmFatDigDesconto.pCalculaTotGerAoConfirmarDesconto;
begin
  If (Not fEhNecessarioCalcularTotGer) Then
    Exit;
  fatVenda.pCalculaTotGer(False, False, pOnCalculaTotGer);
end;

procedure TfrmFatDigDesconto.btnConfirmaDadosClick(Sender: TObject);
  Var
    blnResult: Boolean;

    function fTotalBombeamentoConcreto: Double;
    begin
      Result := 0.0;
      If (fatVenda.strOpcDoc = 'CN') And (fCfgSis('TPNFCR') = SECOL) Then
      Begin
        If fatVenda.fltTotBom = 0.0 Then
        Begin
          fatVenda.pCarregaTaxaBombeamentoPedOrc;
          Result := fatVenda.fltTotBom;

          fatVenda.fltTotBom := 0.0;
          fatVenda.fltPrcBom := 0.0;
          fatVenda.fltQtdBom := 0.0;
        End
        Else
          Result := fatVenda.fltTotBom;
      End;
    end;

    procedure pCancelaConfirmacao;
    begin
      edtSubTotProd.Text := FormatFloat('#,##0.00', fltTotGerAnt);

      edtPorDes.Text := FormatFloat('#,##0.00', fltPorDesAnt);
      edtDesEsp.Text := FormatFloat('#,##0.00', fltDesEspAnt);;

      strSubTotAposPorDes := '';

      edtPerTotalDescontos.Clear;
      edtTotalDescontos.Clear;
      edtTotalLiquido.Clear;
      edtTotVen.Clear;

      {********************************************}
      {* ATUALIZA OS TOTAIS GERAL/ LIQUIDO        *}
      {****************************************JC**}
      strPorDesAnt := '';
      fValidaCampos(edtPorDes, False);

      Self.Enabled := True;
      pSetFocus(edtPorDes);
      blnMudarFoco := False;

      blnResult := False;
    end;

begin
  inherited;

  if (intSemaforoKeyDown >= 0) then
    Exit;

  Try
    Screen.Cursor := crHourGlass;

    If fVerificaCampos Then
    Begin
      blnResult := True;

      Self.AlphaBlend := True;
      Self.AlphaBlendValue := 0;

      fatVenda.blnUsaDesEspExpCalc := fatVenda.blnUsaDesEspExpCalcIni;
      If (fatVenda.blnUsaDesEspExpCalc) Then
      Begin
        //SE MUDOU O DESCONTO ESPECIAL DO PEDIDO AGRUPADO NÃO TEM O QUE FAZER,
        //O OPERADOR MUDOU O DOCUMENTO ORIGINAL ENTÃO O DESCONTO ESPECIAL SERÁ
        //RATEADO DE FORMA PROPORCIONAL E NÃO MAIS CONFORME O ORIGINAL
        If (fFormataFloat(fatVenda.fltDesEsp, 2) <> fFormataFloat(fltDesEspAnt, 2)) Or
           (fFormataFloat(fatVenda.fltDesEspConfF4, 2) > 0) Or
           ((fFormataFloat(fatVenda.fltDesEspF4, 2) > 0) And (fFormataFloat(fatVenda.fltDesEsp, 2) <> fFormataFloat(fatVenda.fltDesEspF4, 2))) Then
        Begin
          If (fMensagem('Atenção!', 'O valor do Desconto Especial foi modificado, em sendo assim esse valor será distribuído de '+
                                    'forma proporcional aos valores dos itens confirmados desconsiderando o desconto original dos documentos! '+
                                    ' Deseja prosseguir?', ['&Sim', '&Não']) = 1) Then
          Begin
            fatVenda.fltDesEspConfPed := fatVenda.fltDesEsp;
            fatVenda.blnUsaDesEspExpCalc := False;
            fatVenda.blnPedidoOrigemAgrupamento := False;
          End
          Else
          Begin
            blnResult := False;
            pCancelaConfirmacao;
          End;
        End;
      End;

      If blnResult Then
        pCalculaTotGerAoConfirmarDesconto;

      If blnResult And (fFormataFloat(fatVenda.fltDesEsp,2) < fFormataFloat(fatVenda.fltIcmOrg,2)) And
         (Not fatVenda.fPermiteDescontoComercialEmOperacaoZonaFrancaComDescontoDeIcms) Then
      Begin
        If fatVenda.strZonFra = 'S' Then
          fMensagem('', 'O valor do desconto não pode ser menor que o valor do ICMS!', ['&O k'])
        Else
          fMensagem('', 'O valor do desconto não pode ser menor que o valor do ICMS para Orgão Público!', ['&O k']);
        blnResult := False;

        fatVenda.fltDesEsp := fatVenda.fltIcmOrg;
        edtDesEsp.Text := FormatFloat('#,##0.00', fatVenda.fltDesEsp);
        pSetFocus(edtDesEsp);
        blnMudarFoco := False;
      End;

      If blnResult And ((fatVenda.fltDesEsp > 0.00) Or (fatVenda.fltPorDes > 0.00)) Then
      Begin
        {*********************************************************************}
        {* CASO CONFIGURADO PARA TRAZER COMO SUGESTAO O PRECO DE PROMOCAO    *}
        {* E O VALOR DO DOCUMENTO NAO FOR MENOR QUE O MINIMO (NAO TRAVOU)    *}
        {* ENTAO NAO DEVE FAZER O RATEIO DO DESCONTO ESPECIAL NOS ITENS      *}
        {* PROMOCAO, DO CONTRARIO SEMPRE DEVE FAZER O RATEIO MESMO NAS       *}
        {* PROMOCOES PARA EVITAR ITENS ABAIXO DO CUSTO E ATE MESMO NEGATIVOS *}
        {*********************************************************************}
        {* NECESSARIO TRAVAR ALEM DE NEGATIVOS TAMBEM PRECO ZERADO POIS,     *}
        {* OCASIONA ERRO AO IMPRIMIR UM CUPOM FISCAL                         *}
        {*****************************************************************JC**}
        If (fEfetivarApuracaoPosRateio) Then
        Begin
          If (fatVenda.fAposRateioTeraItemZerado) Then
          Begin
            pMensagemOk(fatVenda.fRetMensagemValorNegativoPelosDescontos);
            blnResult := False;
            pCancelaConfirmacao;
          End                                                                                  // PRECISA MELHOR ISSO. RONALDO PEDIU PARA FAZER ISSO POR ENQUANTO. ZANON(27/03/2013)
          Else If (fatVenda.fAposRateioTeraItemAbaixoCusto And (fCfgSis('MINCUS') <> 'N')) And (fatVenda.strOpcDoc <> 'CF') Then
          Begin
            If (fatVenda.fltPorDes > 0) And (fatVenda.fltDesEsp = 0) Then
              pMensagemOk('% de desconto informado (' + edtPorDes.Text + ')! ' + #13#10 +
                          MSG_VALOR_LIQUIDO_MENOR_CUSTO)
            Else If (fatVenda.fltPorDes = 0) And (fatVenda.fltDesEsp > 0) Then
              pMensagemOk('Desconto especial informado (' + edtDesEsp.Text + ')! ' + #13#10 +
                          MSG_VALOR_LIQUIDO_MENOR_CUSTO)
            Else
              pMensagemOk('Descontos informados! ' + #13#10 +
                          MSG_VALOR_LIQUIDO_MENOR_CUSTO);
            //blnResult := False;
            //pCancelaConfirmacao;
          End
        End;

        If blnResult And
           fatVenda.fTemItensVenda And
          (fStrToFloat(edtTotVen.Text) <= 0) And
          (Pos(fatVenda.strOpcDoc, 'PD_OR_VN') > 0) Then
        Begin
          pMensagemOk('O valor total da venda não pode ser menor ou igual à zero!');
          blnResult := False;
          pCancelaConfirmacao;
        End;
      End;

      If blnResult Then
      Begin
        (*******************************************************************************)
        (* SE FOR CONFIRMACAO VAI VERIFICAR O VALOR SOMENTE SE INFORMAR ALGUM DESCONTO *)
        (****************************************************************************LA*)
        If blnValidarValorMinimo Then
        Begin

          If (Pos(fatVenda.strOpcDoc, 'OU_OF_DV_CN_') <= 0) And
             (IIF(fatVenda.strOpcDoc <> 'CF', True, fatVenda.fCalculaDescontoConfirmacao(fltDesMinConf) > 0.00)) And
             ((fatVenda.fltPorDes > 0.0) Or (fatVenda.fltDesEsp > 0.0) Or (VS_strTRVEPR = '2')) Then
          Begin

            If fatVenda.strOriF11 <> 'S' Then
            Begin
              If Not fatVenda.fVerificaVrMinimo(fltTotGerAnt, (fStrToFloat(edtTotalLiquido.Text) + fStrToFloat(edtDesCsh.Text)), fatVenda.intPrzMed) Then
              Begin
                pCancelaConfirmacao;
              end;
            End;

          End;

        End;

      End;

      If blnResult Then
      Begin
        If (fCfgSis('GERCRE', varBoolean)) And
           (fFormataFloat(fatVenda.fltDupRec, 2) > 0.0) And
           (fFormataFloat(fatVenda.fltDupRec, 2) > fFormataFloat((fStrToFloat(edtTotalLiquido.Text) + fatVenda.fltValFre + fTotalBombeamentoConcreto), 2)) Then
        Begin
          If fMensagem('ATENÇÃO!', Format('Será gerado um crédito de R$ %f para esse cliente.' + #13#10 +
                                          'Deseja continuar?',
                                          [fatVenda.fltDupRec - (fStrToFloat(edtTotalLiquido.Text) +
                                                                 fatVenda.fltValFre +
                                                                 fTotalBombeamentoConcreto)]), ['&Sim', '&Não']) = 2 Then
          Begin
            pCancelaConfirmacao;
          End;
        End;
      End;

      If blnResult Then
      Begin
        If (fatVenda.fPermiteDescontoComercialEmOperacaoZonaFrancaComDescontoDeIcms) Then
          fatVenda.fltDesComercialZFM := fStrToFloat(edtTotDesPer.Text) + fStrToFloat(edtDesEsp.Text);

        fatVenda.fltDesEspRef := fatVenda.fCalculaDescontoConfirmacao(fltDesMinConf);

        If pnlCupomDesconto.Visible Then
          fatVenda.strCupDes := edtCupDes.Text;

        blnConfirma   := True;
        Screen.Cursor := crDefault;
        Close;
      End;

    End;
    Screen.Cursor := crDefault;

  Finally
    Self.AlphaBlend := False;
    Self.AlphaBlendValue := 255;
  End;

end;

procedure TfrmFatDigDesconto.btnMostraMargemClick(Sender: TObject);
begin
  inherited;

  If (btnMostraMargem.Enabled) And (btnMostraMargem.Visible) Then
  Begin

    If InterlockedIncrement(intConfirmando) = 0 Then
    Begin

      Try
        If fVerificaCampos Then
        Begin
          fatVenda.fltDesEsp := fStrToFloat(edtDesEsp.Text);
          pMostraMargem(True);
          pSetFocus(ActiveControl);
          blnMudarFoco := False;
        End;

        InterlockedDecrement(intConfirmando);
      Except
        InterlockedDecrement(intConfirmando);
      End;

    End
    Else
      InterlockedDecrement(intConfirmando);

  End;
end;

procedure TfrmFatDigDesconto.edtCupDesChange(Sender: TObject);
begin
  inherited;
  If edtCupDes.Focused And fEmptyStr(edtCupDes.Text) Then
    edtDesEsp.Text := FloatToStrF(0.00, ffFixed, 12, 2);
end;

procedure TfrmFatDigDesconto.edtDesEspEnter(Sender: TObject);
begin
  inherited;
  strDesEspAnt := edtDesEsp.Text;
end;

procedure TfrmFatDigDesconto.edtDesEspExit(Sender: TObject);
begin
  inherited;
  If ( fFormataFloat(fStrToFloat(edtDesEsp.Text),2) <> fFormataFloat(fStrToFloat(strDesEspAnt),2) ) Then
    fValidaCampos(edtDesEsp, True);
end;

procedure TfrmFatDigDesconto.edtPorDesEnter(Sender: TObject);
begin
  inherited;
  strPorDesAnt := edtPorDes.Text;
end;

procedure TfrmFatDigDesconto.edtPorDesExit(Sender: TObject);
begin
  inherited;
  If ( fFormataFloat(fStrToFloat(edtPorDes.Text),2) <> fFormataFloat(fStrToFloat(strPorDesAnt),2) ) Then
  Begin
    fValidaCampos(edtPorDes, True);
  End;

end;

function TfrmFatDigDesconto.fTravarPercentualDescontoItens(arrItens: TMatrizFechamento): Boolean;
  Var
    intContador : Integer;
begin
  Result := True;

  If (fStrToFloat(edtPorDes.Text) <= 0.00) Then
  Begin
    Result := False;
    Exit;
  End;

  For intContador := 0 To Length(arrItens)-1 Do
  Begin
    If (arrItens[intContador].strCodIte <> fCfgSis('ITEFRE')) And
       (arrItens[intContador].strCodIte <> fCfgSis('ITEMAN')) And
       (arrItens[intContador].strCodIte <> fCfgSis('ITELAN')) And
       (arrItens[intContador].strCodIte <> fCfgSis('ITEBOM')) And
       (arrItens[intContador].strCodIte <> fCfgSis('ITETAX')) And
       ((arrItens[intContador].strPromoc <> 'S') Or fatVenda.fPermiteDescontoPromocao(arrItens[intContador].strCodPro, tapcdePromocaoCorrente, fatVenda.fEhItemCarregadoJuntoPDouOR(arrItens[intContador]))) And
       (fatVenda.fFlagDoItemPermiteRatearDesconto(arrItens[intContador])) And
       (Not fEhItemServico(fatVenda.arrMatItens[intContador].strCodIte)) Then
    Begin
      Result := False;
      Break;
    End;
  End;
end;

function TfrmFatDigDesconto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  LCupomDesconto: TFatCupomDesconto;

  function fPixJaRecebido: Boolean;
  begin
    Result := False;
    If Assigned(fatVenda.DadosPixDaVenda.ObjetoPixPago) Then
      If MatchStr(fatVenda.DadosPixDaVenda.ObjetoPixPago.Status, STATUS_PIX_PAGO) Then
        Result := True;
  end;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtPorDes) And (edtPorDes.Enabled) Then
    Begin
      If fEmptyStr(edtPorDes.Text) Then
      Begin
        edtPorDes.Text := '0,00';
      End;

      If (fPixJaRecebido) And (fFormataFloat(fStrToFloat(edtPorDes.Text),2) <> fFormataFloat(fltPorDesAnt,2)) Then
      Begin
        fMensagem('ATENÇÃO', 'Não é permitido alterar o desconto de uma venda que já tenha Pix recebido.', ['&Ok']);
        Result := False;
      End;

      if (not fCfgSis('DESNEG',varBoolean)) and (fStrToFloat(edtPorDes.Text) < 0) then
      begin
        fMensagem('ATENÇÃO!', 'Não é permitido aplicar um desconto negativo (acréscimo) no faturamento! (CFG_DESNEG)', ['&Ok']);
        Result := False;
      end;

      If (Result) And (fBloqueiaDesEspComPorDesSeCupomEspecial) Then
      Begin
        edtPorDes.SelectAll;
        Result := False;
      End;

      If (Result) And
         (fatVenda.fBloquearPercentualDescontoNoFechamentoDaVenda(fStrToFloat(edtPorDes.Text), True)) Then
      Begin
        edtPorDes.SelectAll;
        Result := False;
      End;

      If (Result) And
         (fCfgSis('CMBDES', varString) = 'N') And
         (fTravarPercentualDescontoItens(fatVenda.arrMatItens)) Then
      Begin
        pMensagemOk('Percentual de desconto informado não permitido, pois nesta venda ' +
                    'foram informados apenas produtos que não permitem deduzir desconto, '+
                    'o percentual não pode ser aplicado nessas condições!');
        edtPorDes.SelectAll;
        Result := False;
      End;

      If (Result) And fTemDescontoDoProfissional And (fltDesMaxProfiss > 0) And (fStrToFloat(edtPorDes.Text) > fltDesMaxProfiss) Then
      Begin
        pMensagemOk('Desconto máximo em percentual permitido para este cliente ' +
                    'profissional é de (' + FormatFloat('#,##0.00', fltDesMaxProfiss) + '%)!');
        edtPorDes.SelectAll;
        Result := False;
      End;

      If (Result) And (strPorDesAnt <> FormatFloat(edtPorDes.EditFormat, fStrToFloat(edtPorDes.Text))) Then
      Begin
        {If (fatVenda.blnTemAlgumItemEmPromocao) And
           (Not fatVenda.fPermiteDescontoPromocao) And
           (fStrToFloat(edtPorDes.Text) <> 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O desconto será aplicado apenas nos itens que não estão em promoção!', ['&Ok']);
        End;}

        strPorDesAnt := FormatFloat(edtPorDes.EditFormat, fStrToFloat(edtPorDes.Text));
        strSubTotAposPorDes := FloatToStrF(fltTotGerAnt, ffFixed, 12, 2);

        pAtualizaTotalGeral(blnBuscaPorChave);

        If (fRecalculaPorDesComoDesEsp) And (fStrToFloat(edtPorDes.Text) > 0.0) Then
        Begin
          If fatVenda.fCarregaValorBrutoParaAplicarDescontoProfissional Then
          Begin
            edtDesEsp.Text := FloatToStrF(fltTotGerAnt - fStrToFloat(strSubTotAposPorDes) + fltDesMinConf, ffFixed, 12, 2);
            edtDesEsp.Hint := 'Desconto Especial (' + edtDesEsp.Text + ') = ' +
                              'Desconto Especial Anterior (' + FloatToStrF(fltDesMinConf, ffFixed, 12, 2) + ') + ' +
                              'Desconto Profissional de ' + strPorDesAnt + '% (' + FloatToStrF(fltTotGerAnt - fStrToFloat(strSubTotAposPorDes), ffFixed, 12, 2) + ')';
          End
          Else
            edtDesEsp.Text := FloatToStrF(fltTotGerAnt - fStrToFloat(strSubTotAposPorDes), ffFixed, 12, 2);

          strSubTotAposPorDes := FloatToStrF(fltTotGerAnt, ffFixed, 12, 2);
          edtPorDes.Text      := '0,00';
          strPorDesAnt        := '0,00';
          fatVenda.fltPorDes  := 0.00;
        End;

        {************************************************************************}
        {* CASO TROCOU O PERCENTUAL DE DESCONTO DEVE RECALCULAR O TOTAL LIQUIDO *}
        {* INDEPENDENTEMENTE SE O VALOR DESCONTO ESPECIAL É O MESMO             *}
        {************************************************************************}
        strDesEspAnt := '';
        fValidaCampos(edtDesEsp, False);
        pSetFocus(edtDesEsp);
      End;

    End

    Else If (Sender = edtDesEsp) And (edtDesEsp.Enabled) Then
    Begin

      If fEmptyStr(edtDesEsp.Text) Then
      Begin
        edtDesEsp.Text := '0,00';
      End;

      If (fPixJaRecebido) And (fFormataFloat(fStrToFloat(edtDesEsp.Text),2) <> fFormataFloat(fltDesEspAnt,2)) Then
      Begin
        fMensagem('ATENÇÃO', 'Não é permitido alterar o desconto de uma venda que já tenha Pix recebido.', ['&Ok']);
        Result := False;
      End

      Else If (fStrToFloat(edtDesEsp.Text) < 0) Then
      Begin
        fMensagem('','O Desconto Especial deve ser maior ou igual a zero!',['&OK']);
        Result := False;
      End

      Else If (fBloqueiaDesEspComPorDesSeCupomEspecial) Then
      Begin
        edtDesEsp.SelectAll;
        Result := False;
      End

      Else If (fatvenda.fBloquearDescontoEspecialNoFechamentoDaVenda(fStrToFloat(edtDesEsp.Text), True)) Then
      Begin
        edtDesEsp.SelectAll;
        Result := False;
      End
      Else
      Begin
        fatVenda.fltDesEsp := fStrToFloat(edtDesEsp.Text);

        If fatVenda.fltDesEsp >= fltTotGerAnt Then
        Begin
          If (Pos(fatVenda.strOpcDoc, 'PD_OR_VN_') > 0) And Self.Active Then
            fMensagem('Atenção!', 'O valor do Desconto Especial: '+FormatFloat('#,##0.00', fFormataFloat(fatVenda.fltDesEsp,2))+', supera ou iguala o valor da venda!', ['&O k']);

          Result := False;
          edtPerTotalDescontos.Clear;
          edtTotalDescontos.Clear;
          edtTotalLiquido.Clear;
          edtTotVen.Clear;
        End
        Else If (fatVenda.strOpcDoc = 'CF') And (fatVenda.fltDesEsp < fltDesMinConf) Then
        Begin
          fMensagem('ATENÇÃO!', 'O desconto deve ser maior ou igual a ' + FloatToStrF(fltDesMinConf, ffFixed, 12, 2), ['&Ok']);
          Result := False;
        End
        Else If (strDesEspAnt <> FormatFloat(edtDesEsp.EditFormat, fStrToFloat(edtDesEsp.Text))) Then
        Begin
          strDesEspAnt := FormatFloat(edtDesEsp.EditFormat, fStrToFloat(edtDesEsp.Text));
          If (pnlStIpi.Visible) Then
            fatVenda.pCalculaTotGer(False, False, pOnCalculaTotGer);
          pAtualizaTotalLiquido(blnBuscaPorChave);
        End;
      End;
    End

    Else If (Sender = edtCupDes) And pnlCupomDesconto.Visible Then
    Begin
      If Not fEmptyStr(edtCupDes.Text) Then
      Begin
        edtDesEsp.ReadOnly := True;
        LCupomDesconto := TFatCupomDesconto.Create(fatVenda);

        If Not LCupomDesconto.PodeUtilizarCupom(edtCupDes.Text) Then
        Begin
          Result := False;
          edtDesEsp.Text := FloatToStrF(0.00, ffFixed, 12, 2);
        End
        Else
        Begin
          edtDesEsp.Text := FloatToStrF(LCupomDesconto.GetDescontoCupom(edtCupDes.Text), ffFixed, 12, 2);
          strDesEspAnt := '';
          fValidaCampos(edtDesEsp, False);
          pSetFocus(edtDesEsp);
        End;

      End
      Else
        edtDesEsp.ReadOnly := False;
    End;

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
    blnMudarFoco := False;
  End;
end;

function TfrmFatDigDesconto.fTemDescontoDoProfissional: Boolean;
begin
  Result := (fCfgSis('CLIDES') = 'S'  ) And     // Usa desconto do profissional
            (fCfgSis('DCVBVL') = 'B'  ) And     // carregar preco bruto
            (fCfgSis('DPDIDE') = '2'  ) And     // aplicar desconto da tela de desconto especial
            (fatVenda.fltDescProfissional > 0); // Cliente possui desconto do Profissional
end;

function TfrmFatDigDesconto.fRecalculaPorDesComoDesEsp: Boolean;
begin
  Result := (fatVenda.strOpcDoc = 'CF') Or
            (fCfgSis('DESVAL', varBoolean) And Not fTemDescontoDoProfissional);
end;

function TfrmFatDigDesconto.fRetTotItensCheckOutQueNaoTeraoDesApl: Double;
begin
   Result := 0;
   If pnlVlrCheckOut.Visible Then
     Result := fatVenda.fltTotProChkSemDesApl;
end;

procedure TfrmFatDigDesconto.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaTela;
end;

procedure TfrmFatDigDesconto.pCarregaTela;

  procedure pFoco(blnPorDes : Boolean);
  begin

    If (blnPorDes) Then
      pSetFocus(edtPorDes)
    Else
      pSetFocus(edtDesEsp);

    blnMudarFoco := False;

  end;

begin
  If fatVenda.blnUtilizouCashback Then
    edtDesCsh.Text := FormatFloat('#,##0.00', fatVenda.fltDesCsh);

  btnMostraMargem.Visible := Assigned(pMostraMargem);

  If btnMostraMargem.Visible Then
    btnMostraMargem.Visible := fVerificaAcessoSistema('VIMLF4');

  blnConfirma := False;
  If (fatVenda.strOpcDoc = 'CF') Then
    fltDesMinConf := fStrToFloat(edtDesEsp.Text);

  If fCfgSis('PTCCKO', varBoolean) Then
  Begin
    fltPorDesAnt := fatVenda.fltDescProfissional;
    edtPorDes.Text := FormatFloat('#,##0.00', fatVenda.fltDescProfissional);
  End;

  If fatVenda.fCarregaValorBrutoParaAplicarDescontoProfissional Then
  Begin
    fltPorDesAnt := fatVenda.fltDescProfissional;
    edtPorDes.Text := FormatFloat('#,##0.00', fatVenda.fltDescProfissional);

    strSubTotAposPorDes := '';
    edtPerTotalDescontos.Clear;
    edtTotalDescontos.Clear;
    edtTotalLiquido.Clear;
    edtTotVen.Clear;

    pBloqueiaCaixaDeDesconto;

    If fCfgSis('EDIDEP', VarBoolean) Then
    Begin
      pDesbloqueiaCaixaDeDesconto;
      fltDesMaxProfiss := fatVenda.fltDescProfissional;
      blnPosDesEsp     := False;
    End;

  End;

  fValidaCampos(edtPorDes, False);
  fValidaCampos(edtDesEsp, True);

  pFoco((Not blnPosDesEsp) And (Not edtPorDes.ReadOnly));

  pnlCupomDesconto.Visible := fatVenda.fPermiteInformarCupomDesconto And
    edtDesEsp.Enabled And (Not edtdesEsp.ReadOnly);

  If pnlCupomDesconto.Visible Then
  Begin
    edtCupDes.Text := fatVenda.strCupDes;
    If Not fEmptyStr(edtCupDes.Text) Then
    Begin
      pSetFocus(edtCupDes);
      fValidaCampos(edtCupDes, True);
    End;
  End;

  if fatVenda.fRecebidoPorPix then
  begin
    edtPorDes.Enabled := False ;
    edtDesEsp.Enabled := False ;
    edtCupDes.Enabled := False ;
    btnMostraMargem.Enabled := False ;
  end ;

  pAjustarAlturaForm;
end;

procedure TfrmFatDigDesconto.pDesbloqueiaCaixaDeDesconto;
begin
  edtPorDes.ReadOnly := False;
  edtPorDes.TabStop  := True;
  edtPorDes.Color    := clWindow;
end;

procedure TfrmFatDigDesconto.FormCreate(Sender: TObject);
begin
  inherited;
  pOnCalculaTotGer         := Nil;
  pFuncCalculaTotais       := Nil;
  pMostraMargem            := Nil;
  blnPosDesEsp             := False;
  fltDesMaxProfiss         := 0.00;
  intConfirmando           := -1;

  //Se a condicao de pagamento for no final e a trava de preco tambem no final
  //nao deve validar o valor minimo agora, pois o mesmo sera verificado
  //apos a digitacao da condicao de pagamento...
  blnValidarValorMinimo    := Not ((fCfgSis('USACND', varBoolean)) And
                                   (VS_strTRVEPR = '2') And
                                   (fCfgSis('CNDVEN', varString) = 'F'));

  edtDesEsp.ReadOnly  := not fCfgSis('EXIDES', varBoolean);
  if edtDesEsp.ReadOnly then
  begin
    edtDesEsp.Color       := $00FFDFB8;
    edtDesEsp.NormalColor := $00FFDFB8;
    edtDesEsp.TabStop     := False;
    edtDesEsp.FocusColor  := clSilver
  end;

  blnMudarFoco := False;
  pnlImpostosReforma.Visible := fSomarNovosImpostosDaReformaAoValorContabil;
  if not pnlImpostosReforma.Visible then
    pnlStIpi.Height := pnlStIpi.Height - pnlImpostosReforma.Height
end;

procedure TfrmFatDigDesconto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If btnMostraMargem.Visible And (Key = VK_F4) and btnMostraMargem.Enabled Then
    btnMostraMargem.Click;
end;

procedure TfrmFatDigDesconto.pAtualizaTotalGeral(blnBuscaPorChave: Boolean);
  var
    intContador: Integer;
    fltTotGer   : Double;
    fltTotIteTmp: Double;
    fltDesConTmp: Double;
begin
  Try
    edtPorDes.Enabled := False;
    edtDesEsp.Enabled := False;
    //btnConfirmaDados.Enabled := False;

    pnlInfo.Caption := 'Aguarde, Calculando...';

    fatVenda.fltPorDes := fStrToFloat(edtPorDes.Text);

    fatVenda.pVoltaVrUnitarioSemDesconto(fatVenda.fVerificaImpRateadoDescOrgaoPublico);

    fltTotGer := 0;

    For intContador := 0 To Length(fatVenda.arrMatItens)-1 Do
      if not fEhItemServico(fatVenda.arrMatItens[intContador].strCodIte) then
      begin
        fatVenda.pCalcPorDes(fatVenda.arrMatItens[intContador], fltTotIteTmp, fltDesConTmp);
        fltTotGer := fltTotGer + fltTotIteTmp;
      End;

    strSubTotAposPorDes := FormatFloat('#,##0.00', fltTotGer);

    pCalculaTotais;
  Finally
    edtPorDes.Enabled := True;
    edtDesEsp.Enabled := True;
    //btnConfirmaDados.Enabled := True;

    If blnBuscaPorChave Then
    Begin
      pSetFocus(edtPorDes);
      blnMudarFoco := False;
    End;

    pnlInfo.Caption := '';
  End;
end;

function TfrmFatDigDesconto.fBloqueiaDesEspComPorDesSeCupomEspecial: Boolean;
begin
  Result := (fCfgSis('RDCPES', varBoolean)) And
            (fatVenda.strOpcDoc = 'CE') And
            (fStrToFloat(edtPorDes.Text) > 0) And
            (fStrToFloat(edtDesEsp.Text) > 0);

  If Result Then
    fMensagem('ATENÇÃO!', 'Na emissão de Cupom Especial o "Desconto Especial" e "% de Desconto" não '+
                          'podem ser usados simultaneamente pois "CFG_RDCPES: '+fRetNomCfg('RDCPES')+'" está SIM.', ['&Ok']);
end;

procedure TfrmFatDigDesconto.pAtualizaTotalLiquido(blnBuscaPorChave: Boolean);
begin
  Try
    edtPorDes.Enabled := False;
    edtDesEsp.Enabled := False;
    //btnConfirmaDados.Enabled := False;

    pnlInfo.Caption := 'Aguarde, Calculando...';

    edtTotalLiquido.Text := FormatFloat('#,##0.00', fStrToFloat(strSubTotAposPorDes) - fStrToFloat(edtDesEsp.Text) - fStrToFloat(edtDesCsh.Text));

    edtTotDesPer.Text := FormatFloat('#,##0.00', fStrToFloat(edtSubTotProd.Text) - fStrToFloat(strSubTotAposPorDes));

    edtTotCBS.Text   := FormatFloat('#,##0.00', fatVenda.fltTotCBS);
    edtTotIBS.Text   := FormatFloat('#,##0.00', fatVenda.fltTotIBS);
    edtTotIS.Text    := FormatFloat('#,##0.00', fatVenda.fltTotIS);
    edtValIpi.Text   := FormatFloat('#,##0.00', fatVenda.fltTotIpi);
    edtValSbt.Text   := FormatFloat('#,##0.00', fatVenda.fltTotRet);
    edtValFcpSt.Text := FormatFloat('#,##0.00', fatVenda.fltTotFcpST);

    edtTotVen.Text := FormatFloat('#,##0.00', fStrToFloat(edtTotalLiquido.Text) + fStrToFloat(edtValSbt.Text) + fStrToFloat(edtValFcpSt.Text) + fStrToFloat(edtValIPI.Text) + fStrToFloat(edtTotCBS.Text) + fStrToFloat(edtTotIBS.Text) + fStrToFloat(edtTotIS.Text) );

    If pnlTotalDescontos.Visible Then
    Begin
      edtTotalDescontos.Text := FormatFloat('#,##0.00', fStrToFloat(edtTotalBruto.Text) - fStrToFloat(edtTotalLiquido.Text));

      If fStrToFloat(edtTotalBruto.Text) = 0 Then
        edtPerTotalDescontos.Text := '0,00'
      Else
        edtPerTotalDescontos.Text := FormatFloat('#,##0.00', fStrToFloat(edtTotalDescontos.Text) / fStrToFloat(edtTotalBruto.Text) * 100);
    End;

    If pnlTotLiqSemPromoDig.Visible Then
    Begin
      edtTotLiqSemPromoDig.Text := FormatFloat('#,##0.00', fStrToFloat(edtVlrLiqSemPromoDig.Text) -
                                                           fStrToFloat(edtTotDesPer.Text) -
                                                           fStrToFloat(edtDesEsp.Text) -
                                                           fStrToFloat(edtDesCsh.Text));
    End;

    If (fatVenda.strOpcDoc = 'CF') And (fStrToFloat(edtTotalLiquido.Text) <= 0) Then
    Begin
      edtPerTotalDescontos.Clear;
      edtTotalDescontos.Clear;
      edtTotalLiquido.Clear;
      edtTotVen.Clear;
    End;

    pCalculaTotais;
  Finally
    edtPorDes.Enabled := True;
    edtDesEsp.Enabled := True;
    //btnConfirmaDados.Enabled := True;

    If (blnBuscaPorChave) and (pnlDigDescontos.Visible) Then
    Begin
      pSetFocus(edtDesEsp);
      blnMudarFoco := False;
    End;

    pnlInfo.Caption := '';
  End;
end;

procedure TfrmFatDigDesconto.pBloqueiaCaixaDeDesconto;
begin
  edtPorDes.ReadOnly := True;
  edtPorDes.TabStop  := False;
  edtPorDes.Color    := $00FFDFB8;
end;

procedure TfrmFatDigDesconto.pCalculaTotais;
  Var
    frmAguarde: TfrmGravando;
begin
  If Not Assigned(pFuncCalculaTotais) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    try
      frmAguarde.fExecutarAcao := fCalculaTotais;
      frmAguarde.ShowModal;
    finally
      pFreeAndNil(frmAguarde);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmFatDigDesconto.pAjustarAlturaForm;
  Var
    intHeightEsq: Integer;
    intHeightDir: Integer;
    intControl: Integer;
begin
  intHeightEsq := 0;
  intHeightDir := 0;

  For intControl := 0 To pnlEsquerda.ControlCount - 1 Do
    If (pnlEsquerda.Controls[intControl] Is TPanel) And pnlEsquerda.Controls[intControl].Visible Then
      Inc(intHeightEsq, pnlEsquerda.Controls[intControl].Height);

  For intControl := 0 To pnlDireita.ControlCount - 1 Do
    If (pnlDireita.Controls[intControl] Is TPanel) And pnlDireita.Controls[intControl].Visible Then
      Inc(intHeightDir, pnlDireita.Controls[intControl].Height);

  Self.ClientHeight := Max(intHeightEsq, intHeightDir) + pnlConfirma.Height + pnlStatus.Height + 15;
end;

procedure TfrmFatDigDesconto.pAtualizaInformacoesVenda;
  Var
    blnExibePrecoTabelaVenda: Boolean;
    fltPorDesTmpAux: Double;
begin
  blnExibePrecoTabelaVenda := (fCfgSis('PRETAB') = 'S') And
                              (Pos(fatVenda.strOpcDoc, 'VN_PD_OR_') > 0) And
                              (fCfgSis('TPNFCR') <> PRESTCON);

  pnlInfDescSemPromocao.Visible := (Not fatVenda.fPermiteDescontoPromocao('', tapcdeOlhandoTodosItens));
  pnlVlrLiqSemPromoDig.Visible  := pnlInfDescSemPromocao.Visible;
  pnlTotLiqSemPromoDig.Visible  := pnlInfDescSemPromocao.Visible;

  edtDesCsh.Visible := (fCfgSis('CBKUTI', varBoolean)) And
                       (MatchStr(fatVenda.strOpcDoc, ARR_DOCUMENTOS_UTILIZACAO_CASHBACK));
  lblDesCsh.Visible := edtDesCsh.Visible;

  If (Not edtDesCsh.Visible) Then
  Begin
    pnlDigDescontos.Height := pnlDigDescontos.Height
                            - edtDesCsh.Height;
  End;

  edtVlrCheckOut.Text := FormatFloat('#,##0.00', fRetTotItensCheckOutQueNaoTeraoDesApl);

  If fCfgSis('EXIVMP', varBoolean) Then
  Begin
    fltPorDesTmpAux := fatVenda.fltPorDesTmp;
    Try
      //para alimentar a property "fltTotMinCPro"
      fatVenda.fVerificaVrMinimo(0, 0, 0, '', False, False);
    Finally
      If (Not fEmptyStr(fatVenda.strNumOrc)) And (fltPorDesTmpAux > 0) And (Not fatVenda.blnHerancaOrcamentoPedido) Then
        fatVenda.fltPorDesTmp := fltPorDesTmpAux
    End;

    lblVlrMinComPromocao.Visible   := True;
    edtVlrMinComPromocao.Visible   := True;
    edtVlrMinComPromocao.Text      := FormatFloat('#,##0.00', fatVenda.fltTotMinCPro);
    lblVlrMinSemPromocao.Visible   := True;
    edtVlrMinSemPromocao.Visible   := True;
    edtVlrMinSemPromocao.Text      := FormatFloat('#,##0.00', fatVenda.fltTotMinSPro);
    lblVlrMinTotalProdutos.Visible := True;
    edtVlrMinTotalProdutos.Visible := True;
    edtVlrMinTotalProdutos.Text    := FormatFloat('#,##0.00', fatVenda.fltTotMinProd);
  End
  Else
  Begin
    lblVlrMinComPromocao.Visible   := False;
    edtVlrMinComPromocao.Visible   := False;
    lblVlrMinSemPromocao.Visible   := False;
    edtVlrMinSemPromocao.Visible   := False;
    lblVlrMinTotalProdutos.Visible := False;
    edtVlrMinTotalProdutos.Visible := False;
  End;

  If (Not blnExibePrecoTabelaVenda) Or
     (fatVenda.fRegraPrecoSugestaoAtiva = TRegraPrecoSugestao.PrecoDeTabela) Then
  Begin
    {*************************}
    {* PRODUTOS COM PROMOCAO *}
    {**********************JC*}
    edtTotalComPromocao.Text := FormatFloat('#,##0.00', fatVenda.fltTotCPro);

    lblPercDescPromocao.Visible  := False;
    edtPercDescPromocao.Visible  := False;

    lblValorDescPromocao.Visible := False;
    edtValorDescPromocao.Visible := False;

    lblVlrLiqComPromocao.Visible := False;
    edtVlrLiqComPromocao.Visible := False;

    pnlTotalComPromocao.Height   := pnlTotalComPromocao.Height  -
                                    edtPercDescPromocao.Height  -
                                    edtValorDescPromocao.Height -
                                    edtVlrLiqComPromocao.Height;

    {*************************}
    {* PRODUTOS SEM PROMOCAO *}
    {**********************JC*}
    edtTotalSemPromocao.Text  := FormatFloat('#,##0.00', fatVenda.fltTotSPro);
    edtVlrLiqSemPromoDig.Text := FormatFloat('#,##0.00', fatVenda.fltTotSPro - fRetTotItensCheckOutQueNaoTeraoDesApl);

    lblPercDescSemPromocao.Visible  := False;
    edtPercDescSemPromocao.Visible  := False;

    lblValorDescSemPromocao.Visible := False;
    edtValorDescSemPromocao.Visible := False;

    lblVlrLiqSemPromocao.Visible    := False;
    edtVlrLiqSemPromocao.Visible    := False;

    pnlTotalSemPromocao.Height      := pnlTotalSemPromocao.Height     -
                                       edtPercDescSemPromocao.Height  -
                                       edtValorDescSemPromocao.Height -
                                       edtVlrLiqSemPromocao.Height;

    {*************************}
    {* TOTAIS DOS PRODUTOS   *}
    {**********************JC*}
    pnlTotBrutoSemPromoc.Visible := False;
    pnlTotBrutoComPromoc.Visible := False;
    pnlTotalDescontos.Visible    := False;
    pnlTotalBruto.Visible        := False;
    lblSubTotProd.Caption        := 'Valor Total dos Produtos:';
  End
  Else
  Begin
    {*************************}
    {* PRODUTOS COM PROMOCAO *}
    {**********************JC*}
    edtTotalComPromocao.Text  := FormatFloat('#,##0.00', fatVenda.fltTotBruCPro);
    edtTotBrutoComPromoc.Text := FormatFloat('#,##0.00', fatVenda.fltTotBruCPro);
    edtValorDescPromocao.Text := FormatFloat('#,##0.00', fatVenda.fltTotBruCPro - fatVenda.fltTotCPro);

    If fatVenda.fltTotBruCPro = 0 Then
      edtPercDescPromocao.Text := '0,00'
    Else
      edtPercDescPromocao.Text := FormatFloat('#,##0.00', (fatVenda.fltTotBruCPro - fatVenda.fltTotCPro) / fatVenda.fltTotBruCPro * 100);

    edtVlrLiqComPromocao.Text  := FormatFloat('#,##0.00', fatVenda.fltTotCPro);

    {*************************}
    {* PRODUTOS SEM PROMOCAO *}
    {**********************JC*}
    edtTotalSemPromocao.Text     := FormatFloat('#,##0.00', fatVenda.fltTotBruSPro);
    edtTotBrutoSemPromoc.Text    := FormatFloat('#,##0.00', fatVenda.fltTotBruSPro);
    edtValorDescSemPromocao.Text := FormatFloat('#,##0.00', fatVenda.fltTotBruSPro - fatVenda.fltTotSPro);

    If fatVenda.fltTotBruSPro = 0 Then
      edtPercDescSemPromocao.Text := '0,00'
    Else
      edtPercDescSemPromocao.Text := FormatFloat('#,##0.00', (fatVenda.fltTotBruSPro - fatVenda.fltTotSPro) / fatVenda.fltTotBruSPro * 100);

    edtVlrLiqSemPromoDig.Text := FormatFloat('#,##0.00', fatVenda.fltTotSPro - fRetTotItensCheckOutQueNaoTeraoDesApl);
    edtVlrLiqSemPromocao.Text := FormatFloat('#,##0.00', fatVenda.fltTotSPro);

    {*************************}
    {* TOTAIS DOS PRODUTOS   *}
    {**********************JC*}
    edtTotalBruto.Text := FormatFloat('#,##0.00', fatVenda.fltTotBruCPro + fatVenda.fltTotBruSPro);
  End;

  If Not edtVlrMinComPromocao.Visible Then
    pnlTotalComPromocao.Height := pnlTotalComPromocao.Height - edtVlrMinComPromocao.Height;

  If Not edtVlrMinSemPromocao.Visible Then
    pnlTotalSemPromocao.Height := pnlTotalSemPromocao.Height - edtVlrMinSemPromocao.Height;

  If Not edtVlrMinTotalProdutos.Visible Then
    pnlSubTotProd.Height := pnlSubTotProd.Height - edtVlrMinTotalProdutos.Height;

  edtSubTotProd.Text := FormatFloat('#,##0.00', fatVenda.fltTotGer);
  edtValIpi.Text     := FormatFloat('#,##0.00', fatVenda.fltTotIpi);
  edtValSbt.Text     := FormatFloat('#,##0.00', fatVenda.fltTotRet);
  edtValFcpSt.Text   := FormatFloat('#,##0.00', fatVenda.fltTotFcpST);
  edtTotCBS.Text     := FormatFloat('#,##0.00', fatVenda.fltTotCBS);
  edtTotIBS.Text     := FormatFloat('#,##0.00', fatVenda.fltTotIBS);
  edtTotIS.Text      := FormatFloat('#,##0.00', fatVenda.fltTotIS);

  If (fFormataFloat(fatVenda.fltTotIpi + fatVenda.fltTotRet + fatVenda.fltTotCBS + fatVenda.fltTotIBS + fatVenda.fltTotIS, 2) = 0) Then
    pnlStIpi.Visible := False;
End;

function TfrmFatDigDesconto.fCalculaTotais(pgbStatus: TcxProgressBar = nil): Boolean;
begin
  pInformacao('Aguarde, Calculando total dos produtos...', pgbStatus);

  If (Assigned(pFuncCalculaTotais)) Then
    pFuncCalculaTotais(True, -1, pgbStatus);

  Result := True;
end;

end.

