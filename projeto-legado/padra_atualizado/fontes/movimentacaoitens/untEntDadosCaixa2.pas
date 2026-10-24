{***************************}
{* qryConOpe -> CADOPE     *}
{* qryConCta -> CADCTA     *}
{* qryConPor -> CADPOR     *}
{************************JB*}
unit untEntDadosCaixa2;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus,
  ComCtrls, Buttons, ExtCtrls, untfuncoesSimples,Menus,
  untEntFreConLista, untEspelhoNota, QColorLabel, Uni, AppEvnts, DB, Math,
  untGnre, MemoFocus, untEntPagtoAntecipado, UniClientDataSet,
  untEntVendor, untEntOutrasDespesas, untTypesSistema, untCfgCfopCst,
  BitBtnLockedIncrem, untEntEmbalagens, frxClass, frxExportCSVTestabilidade,
  untDefineBaixaPedido, ComboBoxFocus, untDigCodBarBoleto, untFechamentoEstoque,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit, DateUtils, untCondicaoPagamentoCliente,
  untTValidaCorrespondenteContabil, untFuncoesRel, untTipoFreteAtc,
  untAuditoriaGravacaoSaldo;

type
  {$SCOPEDENUMS ON}
  TTipoEntrada = (Compra, Garantia);
  {$SCOPEDENUMS OFF}
  TFuncLiberarEntPedidoPorGarantia = function: boolean of object;
type
  TfrmEntDadosCaixa2 = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label3: TLabel;
    edtValFre: TEditFocus;
    Label28: TLabel;
    edtTotIte: TEditFocus;
    Label29: TLabel;
    edtVlrCon: TEditFocus;
    pnlContasPagar: TPanel;
    lblCodOpe: TLabel;
    edtCodOpe: TEditFocus;
    Label7: TLabel;
    mskCndPag: TMaskEditFocus;
    pnlBotoesEnt: TPanel;
    pgbDados: TProgressBar;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtNomOpe: TEditFocus;
    edtNomPor: TEditFocus;
    Label4: TLabel;
    edtDesEsp: TEditFocus;
    lblCodDig: TLabel;
    edtCodDig: TEditFocus;
    edtNomDig: TEditFocus;
    lblCodRep: TLabel;
    edtCodRep: TEditFocus;
    edtNomRep: TEditFocus;
    chkGraFin: TCheckBox;
    chkImprCp: TCheckBox;
    edtDesAce: TEditFocus;
    lbl1: TLabel;
    Label10: TLabel;
    lblInfCtp: TLabel;
    mmoHisCta: TMemoFocus;
    chkPgoAnt: TCheckBox;
    edtNumAD: TEditFocus;
    lblNumAD: TLabel;
    lblPesBru: TLabel;
    edtPesBru: TEditFocus;
    lblPesLiq: TLabel;
    edtPesLiq: TEditFocus;
    chkAtuPre: TCheckBox;
    btnCancelarEntrada: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnImpEspelho: TBitBtnLocked;
    btnConFre: TBitBtnLocked;
    btnConfDigitacao: TBitBtnLocked;
    btnGnre: TBitBtnLocked;
    btnDesmembraValores: TBitBtnLocked;
    btnVendor: TBitBtnLocked;
    btnOutDes: TBitBtnLocked;
    btnCalculaTotais: TBitBtnLocked;
    btnPgoAnt: TBitBtnLocked;
    lblCredFor: TLabel;
    cbxModFre: TComboBox;
    chkVeioBo: TCheckBox;
    chkDeposi: TCheckBox;
    pnlTipoFrete: TPanel;
    lbl2: TLabel;
    cbbTipFre: TComboBoxFocus;
    Label6: TLabel;
    edtQtdVol: TEditFocus;
    Label2: TLabel;
    edtEspVol: TEditFocus;
    lblBcoFor: TLabel;
    cbxBcoFor: TComboBoxFocus;
    FlwPnlBotoesEnt: TFlowPanel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    pnlTipoOP: TPanel;
    rdgTipoEntrada: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure btnCalculaTotaisClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnImpEspelhoClick(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure chkGraFinClick(Sender: TObject);
    procedure btnConFreClick(Sender: TObject);
    procedure btnConfDigitacaoClick(Sender: TObject);
    procedure btnGnreClick(Sender: TObject);
    procedure btnDesmembraValoresClick(Sender: TObject);
    procedure btnPgoAntClick(Sender: TObject);
    procedure chkPgoAntClick(Sender: TObject);
    procedure edtNumADKeyPress(Sender: TObject; var Key: Char);
    procedure mskCndPagExit(Sender: TObject);
    procedure btnVendorClick(Sender: TObject);
    procedure chkAtuPreClick(Sender: TObject);
    procedure btnOutDesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtDesEspExit(Sender: TObject);
    procedure edtValFreExit(Sender: TObject);
    procedure cbbTipFreChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkDeposiClick(Sender: TObject);
    procedure cbxBcoForDropDown(Sender: TObject);
    procedure cbxBcoForEnter(Sender: TObject);
    procedure cbxBcoForExit(Sender: TObject);
    procedure cbxBcoForChange(Sender: TObject);
    procedure cbxBcoForKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure mskCndPagKeyPress(Sender: TObject; var Key: Char);
    procedure cbxModFreChange(Sender: TObject);
  private
    { Private declarations }

    objFechamento: TFechamentoEstoque;
    CondicaoPagamentoCliente: TCondicaoPagamentoCliente;

    objDefBaixa: TDefineBaixaPedido;

    blnDescontaFreteDevolucao: Boolean;

    fltBonificacao: Double;
    fltValorDocumento: Double;

    objVendor: TEntVendor;
    objOutDes: TEntOutrasDespesas;
    objPgoAnt: TEntPagtoAntecipado;
    fltTotIteRet: Double;
    strCodDig   : String;
    strCodOpe   : String;
    strCndAnt   : String;
    objLisFre   : TFreConLista;
    obJGNRE     : TGnre;

    qryConPor   : TUniQuery;
    qryConCta   : TUniQuery;
    qryConOpe   : TUniQuery;
    qryPreAlt   : TUniQuery;
    qryCadPag   : TUniQuery;
    cdsCtpDet   : TUniClientDataSet;

    oleItensPedidos: OleVariant;
    objEspNota : TEspNota;

    lstBcoFor   : TStringList;
    intIdxBcoForAnt: Integer;

    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    Function fTemAntecipadoValorMenor: Boolean;
    procedure pAtualizaICMSFrete(fltAlqIcm: Double);
    procedure pAtualizarObjLisFre;

    function fAtualizaPedidoDevolucao(strNumFat,
                                      strEspFat,
                                      strVenFat,
                                      strDigFat,
                                      strCndfat: String;
                                      fltValFat: Double): Boolean;


    procedure pAjustaTelaPgoAntecipado;
    procedure pCalculaTotalGeral;
    procedure pCarregaOperador;
    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;
    procedure pCarregaEvento;
    procedure pAtribuiTabelas;
    procedure pCarregaDigitador;
    procedure pCarregaRepresentante;
    procedure pImprimeEtiqueta;
    procedure pHabilitaVendorOutrasDespesas;
    procedure pImprimeLiberacaoArmazenamento;
    procedure pMonstraItensImprimeLista(strItens: String);
    Procedure pCalculaValorDocumento;
    procedure pHabilitaCamposFinanceiro;
    procedure pHabilitaFinanceiro;
    procedure pHabilitaPagAntecipado;
    procedure pDeterminaTipoDeFrete;
    procedure pHabilitaRateioFrete;
    procedure pCarregaDadosBancariosFornecedor(strCodFor: String);
    function fTemItemMarmoreGranitoSemLoteADefinirCadastrado: Boolean;
    procedure pGerarLotesADefinirParaGranitoMarmore;
    function fObterTipoEntrada: TTipoEntrada;
    function fRetornaParcelas: String;
    function fRetCentroCustoDoc: String;
    function fLiberarValorBoleto: Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    blnEncargosNoFrete,
    blnTravarFinanceiroEstaDuplicado,
    blnPrecoPraticado,
    blnPedFilialGarantia : Boolean;
    tipRatFrete: TTipoRateioFrete;
    recNotEle: TRecInfoNotaEletronica;
    objEmbala: TEntEmbalagens;
    blnSintet: Boolean;
    strPedDev: String;
    dtaDtaEnt: TDateTime;
    dtaDtaDoc: TDateTime;
    strNumDoc: String;
    strSerie : String;
    strCodFor: String;
    strCodFaz: String;
    strEstFor: String;
    strEspDoc: String;
    strCodEmp: String;
    fltAlqFor: Double;

    objExcecaoCfopCst: TCfgCfopCst;

    blnDevolu: Boolean;
    blnConEqu: Boolean;
    blnLocEqu: Boolean;
    blnManterCFOPBonificao: Boolean;

    blnConfirma: Boolean;
    intNumIte: Integer;
    stlPedidos: TStringList;
    strConPag: String;
    qryEntMer: TUniQuery;
    strOrdIte: String;
    blnCarPro: Boolean;
    strAutDev: String;

    blnGarantia: Boolean;
    cdsMovGad  : TUniClientDataSet;
    blnRecCliGarantia: Boolean;
    arrLinDigCodbar: TarrLinDigCodbar;
    intQtdPar: Integer;

    fltCotDol: Double;

    onBeforeConfirmaEntrada : TGenericProcedure;
    onAfterConfirmaEntrada : TGenericProcedure;
    fEntPedidoPorGarantia: TFuncLiberarEntPedidoPorGarantia;

    arrDuplicata: TarrDuplicataPointer;
    strMatRev: String;

  end;


implementation
{$R+}

uses
  untConstantes, untPai, untFuncoes,untRelEstDigitacaoNotaEntrada,
  untRelEspNotaEnt, untEntEtiquetas, untDesmembrValores, untEntAutorizacaoRedPreco,
  untCadCta, untCadPag, untDigOcorrencia, untPesqAux, untPcmGer, untConsultas,
  untQckLiberacaoArmazenamento, untAlteraFornecedorEntrada, untEntConfirmaVencimento,
  untGeraMensagemPedidoCompraAtendido, untDuplicatas, untEntImprimeLista,
  untLotePrecosEfetivacaoCx, WinApi.Messages, untCadFornecedores,
  Contabilidade.Funcoes, Contabilidade.Consultas, untCadClientes,
  untCadTransportadoras,
  Faturamento.Consignacao.Classes,
  untTLiberacaoValorBoleto;
{$R *.dfm}

{ TfrmEntDadosCaixa2 }

Procedure TfrmEntDadosCaixa2.pCalculaValorDocumento;
Begin
  fltBonificacao    := fRetTotalBonificacaoEntMer;
  fltValorDocumento := fFormataFloat(fStrToFloat(edtVlrCon.Text) - fltBonificacao -
                                     IfThen(blnDescontaFreteDevolucao, fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text), 0), 2);
End;

procedure TfrmEntDadosCaixa2.pHabilitaFinanceiro;
Begin
  If (blnDevolu And (fStatusCndPag(mskCndPag.Text) = A_VISTA) And (fCfgSis('DEVCTP', varBoolean)) And (Not blnConEqu) And (Not blnLocEqu)) Or
     ((Not blnDevolu) And (fStatusCndPag(mskCndPag.Text) = A_VISTA) And (fCfgSis('OPTCTP', varBoolean)) And (Not blnConEqu) And (Not blnLocEqu)) Then
  Begin
    chkGraFin.Enabled := (Not chkPgoAnt.Checked);
    mmoHisCta.Enabled := True;
    lblInfCtp.Enabled := True;
  End
  Else
  Begin
    chkGraFin.Enabled := False;

    If chkPgoAnt.Checked Then
      chkGraFin.Checked := fTemAntecipadoValorMenor
    Else
      chkGraFin.Checked := True;


    mmoHisCta.Enabled := chkGraFin.Checked;
    lblInfCtp.Enabled := chkGraFin.Checked;
  End;
  If (chkGraFin.Checked Or chkPgoAnt.Checked) And blnTravarFinanceiroEstaDuplicado Then
  begin
    chkPgoAnt.Checked := False;
    chkGraFin.Checked := False;
  end;

End;

function TfrmEntDadosCaixa2.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strSenha: String;
  strCndPag: String;
  arrDatas: TDateArray;
  intContador: Integer;
  fltValorRestante: Double;
  intCont: Integer;
  oParametros: TParametrosDesmembraValoresCtaDet;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDesAce) Then
    Begin
      If fEmptyStr(edtDesAce.Text) Then
      Begin
        edtDesAce.Text := '0,00';
      End
      Else If (fStrToFloat(edtDesAce.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor da Despesa Acessória deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pCalculaTotalGeral;
      End;
    End

    Else If (Sender = edtDesEsp) Then
    Begin

      If fEmptyStr(edtDesEsp.Text) Then
      Begin
        edtDesEsp.Text := '0,00';
      End
      Else If fStrToFloat(edtDesEsp.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtDesEsp.Text) >= fStrToFloat(edtTotIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto deve ser menor que o total dos Itens!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pCalculaTotalGeral;
        If Result And pnlTipoFrete.Visible Then
        Begin
          blnMudarFoco := False;
          pSetFocus(cbbTipFre);
        End;
      End;
    End

    Else If (Sender = cbbTipFre) Then
    Begin

      If pnlTipoFrete.Visible And cbbTipFre.Enabled Then
      Begin

        If (cbbTipFre.ItemIndex = -1) And (fStrToFloat(edtValFre.Text) > 0) Then
        Begin
          pMensagemOk('Informe o Tipo de Rateio para o Frete!');
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtCodOpe) And (Sender.Parent.Enabled) Then
    Begin

      If fEmptyStr(edtCodOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O operador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        pCarregaOperador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse operador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (strCodOpe <> edtCodOpe.Text) Then
        Begin

          If (Not blnDevolu) Then
          Begin

            If (ffrmSenha(strSenha)) Then
            Begin

              If (strSenha <> fDecrypt(qryConOpe.FieldByName('OPE_SENOPE').AsString)) Then
              Begin
                fMensagem('ATENÇÃO!', 'Senha Invalida!', ['&O k']);
                edtNomOpe.Clear;
                Result := False;
              End
              Else
              Begin
                strCodOpe           := edtCodOpe.Text;
                objLisFre.strCodOpe := edtCodOpe.Text;
              End;

            End
            Else
            Begin
              Result := False;
            End;

          End
          Else
          Begin
            strCodOpe           := edtCodOpe.Text;
            objLisFre.strCodOpe := edtCodOpe.Text;
          End;

        End;

      End;

    End

    Else If (Sender = edtCodDig) And (Sender.Parent.Enabled) And (Sender.Visible) Then
    Begin

      If fEmptyStr(edtCodDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        pCarregaDigitador;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Digitador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          strCodDig := qryConOpe.FieldByName('OPE_CODOPE').AsString;
        End;

      End;

    End

    Else If (Sender = mskCndPag) And mskCndPag.Enabled And (Sender.Parent.Enabled) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad) And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento para recebimento de cliente (garantia) deve ser a vista!', ['&O k']);
        Result := False;
      End
      Else If blnConEqu And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000') Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento para entrada de conserto de equipamento deve ser a vista!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaCndPag(mskCndPag.Text, strCndPag, dtaDtaDoc, True) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
        Result := False;
      End
      Else If fEmptyStr(strCndPag) Then
      Begin
        Result := False;
      End

      Else If chkPgoAnt.Checked And (objPgoAnt.fRetQtdPagamentos + fQuantParcelasPagto(mskCndPag.Text) > 12) Then
      Begin
        pMensagemOk('A Quantidade de pagamentos antecipados mais a quantidades de parcelas restantes deve ser menor ou igual a 12!');
        Result := False;
      End

      Else If (blnBuscaPorChave)                     Or
              (fEmptyStr(arrDuplicata[0].dtaDtaVen)) Or
              (strCndAnt <> mskCndPag.Text)          Then
      Begin
        mskCndPag.Text := strCndPag;

        {********************************************}
        {* LIMPA A MATRIZ USADA NA FUNÇÃO DIGDUPLIC *}
        {*****************************************MV*}
        pZeraDigDuplic(arrDuplicata^);

        If fTemAntecipadoValorMenor Or (Not chkPgoAnt.Checked) Then
        Begin
          pCalculaValorDocumento;

          fltValorRestante  := fltValorDocumento;

          If fTemAntecipadoValorMenor Then
            fltValorRestante := fltValorRestante - objPgoAnt.fltTotSel;

          If fltValorRestante < 0 Then
          Begin
            pMensagemOk('O (Total da Nota) - (Pagamento Antecipado) - (Total da Bonificação) está resultando em um valor menor que zero!');
            Result := False;
          End;

          If fltValorRestante > 0 Then
          Begin

            Result := fDigDuplic(arrDuplicata^,
                                 mskCndPag.Text,
                                 0,
                                 fltValorRestante,
                                 (fStatusCndPag(mskCndPag.Text) = A_PRAZO),
                                 True,
                                 False,
                                 dtaDtaDoc,
                                 True,
                                 fStrToFloat(edtVlrCon.Text) - fStrToFloat(edtTotIte.Text),
                                 'S',
                                 fRetArred2ParcFornec(strCodFor),
                                 False,
                                 0,
                                 False,
                                 Nil,
                                 '',
                                 True,
                                 True,
                                 Nil,
                                 '',
                                 True,
                                 False);

            If chkPgoAnt.Checked Then
            Begin
              Result := Result And
                        objPgoAnt.fRecalculaPagamentosAntecipados(strNumDoc, strSerie, fltValorDocumento, objEspNota.arrParcelas, arrDuplicata^);
            End;

            If Result Then
            Begin

              intContador := 0;
              {*****************************************}
              {* REFAZ A CONDIÇÃO DE PAGAMENTO         *}
              {**************************************MV*}
              While (intContador <= 23)                          And
                    (ArrDuplicata[intContador].dtaDtaVen <> '')  Do
              Begin

                SetLength(arrDatas, intContador+1);
                arrDatas[intContador] := StrToDate(ArrDuplicata[intContador].dtaDtaVen);
                Inc(intContador);

              End;

              strCndPag      := fRetornaCndPag(arrDatas, dtaDtaDoc);
              mskCndPag.Text := strCndPag;
              strCndAnt      := mskCndPag.Text;
            End;

            If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked)
              And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000')
                And Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))
                  And (ArrDuplicata[0].strSequen <> '')
                    And Result Then
              Begin
                pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
                frmDigCodBarBoleto.arrLinDigCodbar := arrLinDigCodbar;
                frmDigCodBarBoleto.arrDuplicata := arrDuplicata;
              Try
                Try
                  frmDigCodBarBoleto.ShowModal;
                Except
                On E: Exception Do
                   Result := False;
                End;
                Finally
                Begin
                  arrLinDigCodbar   := frmDigCodBarBoleto.arrLinDigCodbar;
                  intQtdPar         := frmDigCodBarBoleto.intQtdPar;
                  FreeAndNil(frmDigCodBarBoleto);
                End;
              End;
            End;

          End;
        End;

        If (Result) Then
        Begin
          pHabilitaFinanceiro;
        End;

      End

      Else If (fCfgSis('CTPBOL', varBoolean)) And (chkVeioBo.Checked)
        And (fTiraCaracEspeciaisPonto(mskCndPag.Text) <> '01000')
          And Not fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text))
            And (ArrDuplicata[0].strSequen <> '') And Result Then
      Begin
        For intCont := 0 To (IIF(intQtdPar > 0,intQtdPar, 12) -1) Do
        Begin
          If fEmptyStr(arrLinDigCodbar[intCont].strCodBar) And fEmptyStr(arrLinDigCodbar[intCont].strLinDig) Then
          Begin
            pMensagemOk('A linha digitável e/ou código de barras deve ser preenchida de todas as parcelas!');
            Result := False;
            Exit;
          End
          Else
          Begin
            If Not fEmptyStr(arrLinDigCodbar[intCont].strCodBar) Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaCodBar(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
            If Not fEmptyStr(arrLinDigCodbar[intCont].strLinDig) And Result Then
            Begin
              Result := TfrmDigCodBarBoleto.fValidaLinDig(arrLinDigCodbar[intCont].strCodBar,
                                                          arrLinDigCodbar[intCont].strLinDig,
                                                          ArrDuplicata[intCont].curValor,
                                                          ArrDuplicata[intCont].dtaDtaVen);
            End;
          End;
        End;
      End;
    End

    Else If (Sender = edtNumAD) And (edtNumAD.Visible) Then
    Begin
      If fEmptyStr(edtNumAD.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar o número do AD!', ['&O k']);
        Result := False;
      End
      Else If Not fNumADCadastrado(edtNumAD.Text, strCodFor, VS_strCodEmp) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não existe este AD para este cliente!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) And (Sender.Parent.Enabled) Then
    Begin

      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEvento;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        fraCentroCusto.edtDesEve.Clear;
      End;

    End
    Else If (Sender = fraPlanoDeContas.MskCodCta) And (Sender.Parent.Enabled)  And (pnlContasPagar.Visible)  Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas da Baixa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
      
        pCarregaCentroCusto;
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          If blnDevolu Or (Not fCfgSis('USACTF', varBoolean)) Or blnGarantia Then
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);
            
          Result := False;
        End
        Else If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text) Then
          Result := False
        else If (blnBuscaPorChave) And (Not blnDevolu) then
        begin
          oParametros := TParametrosDesmembraValoresCtaDet.Create;
          try
            oParametros.strNumCta := fraPlanoDeContas.MskCodCta.Text;
            oParametros.strCodEve := NullAsStringValue;
            oParametros.frmCadPag := Self;
            oParametros.fltValDup := fStrToFloat(edtVlrCon.Text);
            oParametros.strCodEmp := VS_strCodEmp;
            oParametros.blnDireto := False;

            if fDesmembraValoresCtaDet(oParametros) then
            begin
              blnMudarFoco := False;
              fraPlanoDeContas.MskCodCta.Enabled := False;
              If fEmptyStr(oParametros.strCodCta) Then
                fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTAPRI')
              Else
                fraPlanoDeContas.MskCodCta.Text := oParametros.strCodCta;

              cdsCtpDet.Data := oParametros.cdsTemp.Data;

              pCarregaCentroCusto;
            end;
          finally
            oParametros.Free;
          end;
        end;
      End;
    End
    Else If (Sender = chkGraFin) And (chkGraFin.Enabled) Then
    Begin
      If fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad) And
         chkGraFin.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido gerar financeiro para recebimento de cliente (garantia)!', ['&O k']);
        Result := False;
      End
      Else If blnConEqu And chkGraFin.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido gerar financeiro para a entrada de conserto de equipamento!', ['&O k']);
        Result := False;
      End
      Else If blnLocEqu And chkGraFin.Checked Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido gerar financeiro para a entrada de locação de equipamento!', ['&O k']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodPor)       And
            (edtCodPor.Enabled)        And
            (edtCodPor.Parent.Enabled) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else If (fStatusCndPag(mskCndPag.Text) = A_VISTA) Or ((Not blnDevolu) And fCfgSis('CTPOBP', varBoolean)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do portador deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodRep) Then
    Begin
      If fEmptyStr(edtCodRep.Text) Then
      Begin
        edtNomRep.Clear;
      End
      Else
      Begin

        pCarregaRepresentante;
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse representante não está cadastrado!', ['&O k']);
          Result := False;
        End

      End;

    End

    Else If (Sender = edtPesBru) Then
    Begin

      If edtPesBru.Visible Then
      Begin

        If fStrToFloat(edtPesBru.Text) < 0 Then
        Begin
          Result := False;
          pMensagemOk('O Peso Bruto deve ser maior ou igual a zero!');
        End

        Else edtPesBru.Text := FormatFloat('#0.000', fStrToFloat(edtPesBru.Text));

      End;

    End

    Else If (Sender = edtPesLiq) Then
    Begin

      If edtPesLiq.Visible Then
      Begin

        If fStrToFloat(edtPesLiq.Text) < 0 Then
        Begin
          Result := False;
          pMensagemOk('O Peso Líquido deve ser maior ou igual a zero!');
        End

        Else If fStrToFloat(edtPesLiq.Text) > fStrToFloat(edtPesBru.Text) Then
        Begin
          Result := False;
          pMensagemOk('O Peso Líquido deve ser menor ou igual ao Peso Bruto!');
        End

        Else edtPesLiq.Text := FormatFloat('#0.000', fStrToFloat(edtPesLiq.Text));
        
      End;

    End

    Else If (Sender = edtQtdVol) Then
    Begin

      If fStrToFloat(edtQtdVol.Text) < 0 Then
      Begin
        Result := False;
        pMensagemOk('A quantidade de volumes deve ser maior ou igual a zero!');
      End

      Else edtQtdVol.Text := FormatFloat('#0.000', fStrToFloat(edtQtdVol.Text));

    End;


    If chkGraFin.Checked Then
    Begin
      chkImprCp.Enabled := True;
      mmoHisCta.Enabled := True;
    End
    Else
    Begin
      chkImprCp.Enabled := False;
      chkImprCp.Checked := False;
      mmoHisCta.Enabled := False;
      mmoHisCta.Clear;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;
                                          
procedure TfrmEntDadosCaixa2.pCarregaCentroCusto;
begin
  If blnDevolu Or (Not fCfgSis('USACTF', varBoolean)) Or blnGarantia Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text, True, strCodFor);

  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmEntDadosCaixa2.pCarregaOperador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodOpe.Text);
  With qryConOpe Do
  Begin
    edtNomOpe.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmEntDadosCaixa2.pAtribuiTabelas;
begin
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
end;

procedure TfrmEntDadosCaixa2.FormCreate(Sender: TObject);
begin
  inherited;

  onBeforeConfirmaEntrada := nil;
  onAfterConfirmaEntrada := nil;

  blnManterCFOPBonificao := False;
  objFechamento := TFechamentoEstoque.Create(Self);

  intQtdPar := 0;

  objDefBaixa := TDefineBaixaPedido.Create(Self);

  objVendor := TEntVendor.Create(Self);

  objVendor.blnGravar := fCfgSis('CTPVND', varBoolean) And
                         fCfgSis('ENTCTP', varBoolean) And
                         (Not blnDevolu);

  btnVendor.Visible := objVendor.blnGravar;

  objOutDes := TEntOutrasDespesas.Create(Self);

  objPgoAnt :=  TEntPagtoAntecipado.Create;
  
  FillChar(recNotEle, SizeOf(recNotEle), #0);

  strOrdIte := '';
  strCodOpe := '';
  strCndAnt := '';

  {*****************************************}
  {* ABRE AS TABELAS USADAS NA INSERÇÃO    *}
  {**************************************MV*}
  qryConPor := fCriaQuery(Self);
  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);

  qryPreAlt.Open;
  qryCadPag.Open;

  If Not fCfgSis('ENTCTP', varBoolean) Then
  Begin

    pnlContasPagar.Enabled := False;
    pnlContasPagar.Visible := False;

    Self.Constraints.MaxHeight := Self.Constraints.MaxHeight - 63;
    Self.Constraints.MinHeight := Self.Constraints.MinHeight - 63;
    Self.Height := Self.Height - 63;

  End;

  fltTotIteRet := fRetornaTotIteRet;
  pAtribuiTabelas;

  blnConfirma := False;

  {**************************************}
  {* OBJETO DA GNRE                     *}
  {***********************************LA*}
  objGnre   := TGnre.Create(Self);
  objGnre.TipoChamada := tcGnrePadrao;

  {**************************************}
  {* OBJETO DE FRETE DE CONHECIMENTO    *}
  {***********************************LA*}
  objLisFre := TFreConLista.Create(Self, False, True);

  {**************************************}
  {* OBJETO DE ESPELHO DE NOTA          *}
  {***********************************JC*}
  objEspNota := TEspNota.Create(Self);

  cdsCtpDet := TUniClientDataSet.Create(Self);
  pCriaClientTemporariaCtpDet(strNumDoc, '', strSerie, strCodEmp, strCodFor, cdsCtpDet);

  blnPrecoPraticado := False;

  lstBcoFor := TStringList.Create;
  intIdxBcoForAnt := -1;

  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

procedure TfrmEntDadosCaixa2.FormDestroy(Sender: TObject);
begin
  inherited;
  lstBcoFor.Free;
end;

procedure TfrmEntDadosCaixa2.btnCalculaTotaisClick(Sender: TObject);
  Var
    qryGenMer,
    qryLeitura: TUniQuery;
    intNumReg,
    intQtdReg: Integer;
    fltTotFre: Double;
    fltTotIte: Double;
    fltFreRes: Double;
    fltAceRes: Double;
    fltDesAce: Double;
    fltQtdTot,
    fltQtdTotAnt,
    fltPesTot,
    fltPesTotAnt: Double;
begin
  inherited;

  If (fStrToFloat(edtValFre.Text) > 0) And (Not fVerificaPesoDosItensEntrada) Then
    Exit;

  If (pnlTipoFrete.Visible) And (cbbTipFre.ItemIndex = -1) And cbbTipFre.Enabled And (fStrToFloat(edtValFre.Text) > 0) Then
  Begin
    pMensagemOk('Informe o Tipo de Rateio para o Frete!');
    pSetFocus(cbbTipFre);
    Exit;
  End;

  Try
    fltPesTot    := 0;
    fltPesTotAnt := 0;
    fltQtdTot    := 0;
    fltQtdTotAnt := 0;
    case tipRatFrete of
      trfPropPesoItem : fltPesTot := fRetornaPesoEntrada(fltPesTotAnt);
      trfPropQtdItem  : fltQtdTot := fRetornaQtdeEntrada(fltQtdTotAnt);
      Else
      Begin
        fltPesTot    := 0;
        fltPesTotAnt := 0;
      End;

    end;

    qryGenMer  := fCriaQuery(Self);
    qryLeitura := fCriaQuery(Self);

    pCalculaTotalGeral;

    With qryLeitura Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT  ');
      SQL.Add('   TMP_ENTMER.AUTOINCREM, ');
      SQL.Add('   ENT_TOTITE,  ');
      SQL.Add('   ENT_QTDITE  ');

      If tipRatFrete = trfPropPesoItem Then
        SQL.Add(' , ENT_QTDITE * ITE_PESOIT AS PESITE ');

      SQL.Add(' FROM TMP_ENTMER');

      If tipRatFrete = trfPropPesoItem Then
        SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE');

      SQL.Add('  ORDER BY ENT_TOTITE DESC');
      Open;
    End;

    intNumReg := 0;
    intQtdReg := qryLeitura.RecordCount;

    fltTotFre := fStrToFloat(edtValFre.Text);
    fltDesAce := fStrToFloat(edtDesAce.Text);

    fltTotIte := fStrToFloat(edtTotIte.Text);

    fltFreRes := fltTotFre;
    fltAceRes := fltDesAce;

    If fEmptyStr(recNotEle.strAutInc) Or ((fltDesAce > 0) And (Not fVerificaValorVOutroXML(recNotEle.strAutInc))) Then
    While Not qryLeitura.Eof Do
    Begin
      inc(intNumReg);

      With qryGenMer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE TMP_ENTMER SET ');
        SQL.Add('   ENT_DESACE = :DESACE ');

        If fEmptyStr(recNotEle.strAutInc) Then
          SQL.Add('   ,ENT_VALFRE = :VALFRE  ');

        SQL.Add(' WHERE AUTOINCREM = :AUTINC ');

        If intNumReg = intQtdReg Then
        Begin
          If fEmptyStr(recNotEle.strAutInc) Then
            ParamByName('VALFRE').AsFloat := fltFreRes;

          ParamByName('DESACE').AsFloat := fltAceRes;
        End Else
        Begin
          If fStrToFloat(edtTotIte.Text) > 0 Then
          Begin

            If fEmptyStr(recNotEle.strAutInc) Then
            Begin
              case tipRatFrete of
                 trfPropPesoItem: Begin
                                    If fltPesTot > 0 Then
                                      ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('PESITE').AsFloat * (fltTotFre / fltPesTot), -2)
                                    Else
                                      ParamByName('VALFRE').AsFloat := 0;

                                  End;

                 trfPropQtdItem : ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_QTDITE').AsFloat * (fltTotFre / fltQtdTot), -2);

                 Else
                  If (RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltTotFre / fltTotIte), -2) > 0.01 ) Then
                    ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltTotFre / fltTotIte), -2)
                  Else
                    ParamByName('VALFRE').AsFloat := 0;

              end;
            End;

             If RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltDesAce / fltTotIte), -2) >= 0.01 Then
               ParamByName('DESACE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltDesAce / fltTotIte), -2)
             Else
               ParamByName('DESACE').AsFloat := 0;

          End
          Else
          Begin
            If fEmptyStr(recNotEle.strAutInc) Then
              ParamByName('VALFRE').AsFloat := 0;

            ParamByName('DESACE').AsFloat := 0;
          End;

          If fEmptyStr(recNotEle.strAutInc) Then
            If (RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltTotFre / fltTotIte), -2) > 0.01 ) Then
              fltFreRes := RoundTo(RoundTo(fltFreRes,-2) - RoundTo(qryGenMer.ParamByName('VALFRE').AsFloat, -2), -2);

          If  RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltDesAce / fltTotIte), -2) >= 0.01 Then
             fltAceRes := RoundTo(RoundTo(fltAceRes, -2) - RoundTo(qryGenMer.ParamByName('DESACE').AsFloat, -2), -2);

          If fltAceRes < 0 Then
            fltAceRes := 0;

          If fltFreRes < 0 Then
            fltFreRes := 0;
        End;

        ParamByName('AUTINC').AsString := qryLeitura.FieldByName('AUTOINCREM').AsString;

        ExecSQL;
        Close;
      End;

      qryLeitura.Next;

    End;

    Try
      pRateiaImpostos(qryEntMer,
                      xmlEntradaMercadoria,
                      objExcecaoCfopCst,
                      fStrToFloat(edtTotIte.Text),
                      fStrToFloat(edtValFre.Text),
                      fStrToFloat(edtDesEsp.Text),
                      0,
                      0,
                      0,
                      fStrToFloat(edtDesAce.Text),
                      0.0,
                      fltTotIteRet,
                      pgbDados,
                      fltAlqFor,
                      strEstFor,
                      strCodFor,
                      '',
                      0.0,
                      0,
                      blnDevolu,
                      False,
                      nil,
                      '',
                      0.0,
                      True,
                      recNotEle.strAutInc,
                      False,
                      '',
                      blnGarantia,
                      blnRecCliGarantia,
                      False, // blnNotaImp
                      False, // blnZonFra
                      strEspDoc,
                      (blnConEqu or blnLocEqu),
                      False,
                      tipRatFrete,
                      False,
                      False,
                      blnManterCFOPBonificao,
                      True);

    Except

      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmEntDadosCaixa2.btnCalculaTotaisClick]');
        Exit;
      End;
    End;

    pnlCabecalho.Enabled   := False;
    pnlContasPagar.Enabled := True;
    pnlTipoFrete.Enabled   := False;
    btnConfirma.Enabled    := True;
    pSetFocus(edtCodOpe);

  Finally
    FreeAndNil(qryGenMer);
    FreeAndNil(qryLeitura);
  End;

end;

procedure TfrmEntDadosCaixa2.pCalculaTotalGeral;
begin
  If fEmptyStr(edtValFre.Text) Then
    edtValFre.Text := '0,00';

  If fEmptyStr(edtDesEsp.Text) Then
    edtDesEsp.Text := '0,00';

  If fEmptyStr(edtDesAce.Text) Then
    edtDesAce.Text := '0,00';

  edtVlrCon.Text := FloatToStrF(fStrToFloat(edtTotIte.Text) +
                                fStrToFloat(edtValFre.Text) +
                                fStrToFloat(edtDesAce.Text) -
                                fStrToFloat(edtDesEsp.Text), ffFixed, 12, 2);
end;

procedure TfrmEntDadosCaixa2.pHabilitaPagAntecipado;
Begin
  chkPgoAnt.Visible := Not blnDevolu;
  btnPgoAnt.Visible := Not blnDevolu;
End;

procedure TfrmEntDadosCaixa2.FormShow(Sender: TObject);
  Var
    blnBaiPed: Boolean;
    fltCredFor: Double;
    intModFreSelec: integer;
begin
  inherited;

  If fCfgSis('PDOBPG', varBoolean) Then
    mmoHisCta.Lines.Add(fObservacaoPedido(stlPedidos));

  pZeraDigDuplic(arrDuplicata^);

  intModFreSelec := StrToInt(cbxModFre.Text[1]);

  blnDescontaFreteDevolucao := blnDevolu and((fCfgSis('FREDEV') = 1) Or ((fCfgSis('FREDEV') = 3) And (intModFreSelec in[1, 3, 4, 9])));


  pHabilitaPagAntecipado;
  pDeterminaTipoDeFrete;
  edtNumAD.Text := strAutDev;
  
  objPgoAnt.pSetaFornecedor(strCodFor);
  
  If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    edtDesEsp.Text := FormatFloat('##0.00', recNotEle.fltValDes);
    edtDesAce.Text := FormatFloat('##0.00', recNotEle.fltOutras + recNotEle.fltValSeg);
  End;

  pCalculaTotalGeral;

  edtPesBru.Text := FormatFloat('#0.000', 0);
  edtPesLiq.Text := FormatFloat('#0.000', 0);

  If Not fCfgSis('PESENT', varBoolean) Then
  Begin
    lblPesBru.Visible := False;
    lblPesLiq.Visible := False;
    edtPesBru.Visible := False;
    edtPesLiq.Visible := False;
  End
  Else If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    edtPesBru.Text := FormatFloat('#0.000', recNotEle.fltPesBru);
    edtPesLiq.Text := FormatFloat('#0.000', recNotEle.fltPesLiq);
  End;

  edtEspVol.Text := recNotEle.strEspVol;
  edtQtdVol.Text := FormatFloat('#0.000', recNotEle.fltQtdVol);

  edtNumAD.Visible := False;
  If (blnDevolu) or (blnRecCliGarantia) Or (blnConEqu) Or (blnLocEqu) Then
  Begin

    lblCodOpe.Caption := 'Vendedor';

    chkVeioBo.Visible := False;
    chkDeposi.Visible := False;

    lblCodDig.Visible := True;
    edtCodDig.Visible := True;
    edtNomDig.Visible := True;

    btnImpEspelho.Visible := False;

    edtNumAD.Visible := (VS_strHabilitarCRM) And (fCfgSis('UTI_AD', varBoolean)) ;
    If (blnDevolu) Then
    begin
      If fCfgSis('EGCNDV') = '1' Then
        strConPag := '01000'
      Else If fCfgSis('EGCNDV') = '2' Then
      Begin
        CondicaoPagamentoCliente.pCarregaDados(strCodFor, '');
        If CondicaoPagamentoCliente.intQtdCndPag > 0 Then
        Begin
          edtCodPor.Text := CondicaoPagamentoCliente.strCodPor;
          strConPag := CondicaoPagamentoCliente.strCNDPAG;
        End;
      End;

      If fCfgSis('ELCNDV') = 'N' Then
      Begin
        mskCndPag.Enabled := False;
        If strConPag = '' Then
          strConPag := '01000';
      End;
    End;
  End
  Else
  Begin
    lblCodRep.Visible := False;
    edtCodRep.Visible := False;
    edtNomRep.Visible := False;
  End;

  lblNumAD.Visible := edtNumAD.Visible;

  pCarregaRepresentante;
  If (blnGarantia) then
    oleItensPedidos := fDefinePedidosABaixarGarantia(blnBaiPed, qryEntMer, fCfgSis('CNVEMB'),
                                                     {blnRefugo : Boolean =} False,
                                                     {blnBaixa  : Boolean =} False,
                                                     objDefBaixa)
  Else
    oleItensPedidos := fDefinePedidosABaixar(blnBaiPed, qryEntMer, stlPedidos,
                                             recNotEle.strAutInc,
                                             {blnEntradaSimplificada: Boolean = } False,
                                             {blnCaixaUm: Boolean =} False,
                                             objDefBaixa);

  If stlPedidos.Count > 0 Then
    btnConfDigitacao.Visible := True;

  pCarregaCentroCusto;

  btnDesmembraValores.Visible := (Not blnDevolu);

  If (Not btnDesmembraValores.Visible) Then
    pnlBotoesEnt.Height := pnlBotoesEnt.Height - btnDesmembraValores.Height;

  mskCndPag.Text := strConPag;

  mmoHisCta.Enabled := fCfgSis('INFCTP', varBoolean);
  lblInfCtp.Enabled := mmoHisCta.Enabled;

  chkAtuPre.Visible := fCfgSis('ATPRAU', varBoolean);

  If blnGarantia Or blnRecCliGarantia Or blnConEqu or blnLocEqu Then
  Begin
    btnCalculaTotaisClick(btnCalculaTotais);
    pnlCabecalho.Enabled   := False;
    pnlTipoFrete.Enabled   := False;
    pnlContasPagar.Enabled := True;
    pSetFocus(edtCodOpe);
  End;

  {********************************************************}
  {* EXIBE VALOR DE CREDITO DO FORNECEDOR SE CASO EXISTIR *}
  {******************************************************FC}
  fltCredFor := fRetCreditoByFornecedor(strCodFor);
  lblCredFor.Visible := fltCredFor > 0;
  lblCredFor.Caption := lblCredFor.Caption + ' ' + FloatToStrF(fltCredFor, ffCurrency, 9, 2);

  If (blnDevolu) then
  Begin
    btnConFre.Visible := False;
    btnGnre.Visible   := False;
    btnVendor.Visible := False;
    btnOutDes.Visible := False;
  End;

  pnlNomeForm.Caption := 'frmEntDadosSenhaAuxiliar';
  pHabilitaRateioFrete;

  pCarregaDadosBancariosFornecedor(strCodFor);
  pnlTipoOP.Visible := strEspDoc = 'PD';
end;

procedure TfrmEntDadosCaixa2.btnConfirmaClick(Sender: TObject);
  Var
    strDocCon,
    strDocFre,
    strSeqGer,
    strListaItens: String;
    blnConf: Boolean;
    strMotDev: String;
    fltConFre : Double;
    objAtuFor: TAlteraFornecedorEntrada;
    strAutIncCadFis : String;
    intCtpCon: LongInt;
    strAutIncMovGer: string;
    blnGravouMovDet,
    blnGerouLotDePreco,
    blnGerarLoteADefinirParaGranitos: Boolean;
    strBcoFor : String;
    frmLotePrecosEfetivacaoCx: TfrmLotePrecosEfetivacaoCx;
    ArrCteMov: TArrCteMov;
    blnResult: Boolean;
    strCodErrosAuditoria: String;
begin
  inherited;

  If Not btnConfirma.Enabled Then
    Exit;

  pSetFocus(btnConfirma);
  Application.ProcessMessages;

  If fVerificaCampos Then
  Begin
    if (fObterTipoEntrada = TTipoEntrada.Garantia) and Assigned(fEntPedidoPorGarantia) then
    begin
      if Not fEntPedidoPorGarantia then
      begin
        fMensagem('ATENÇÃO!', 'Em entrada por garantia só são permitidas as classificações configuradas para' + #13 +
                              'Garantia - Retorno de Fornecedor [CFG_CLARGR]!', ['&O k']);
        Exit;
      end;
    end;

    if (not fValidaVencimento(arrDuplicata^)) then
    begin
      pCriarFormularios(TfrmEntConfirmaVencimento, frmEntConfirmaVencimento);
      frmEntConfirmaVencimento.ShowModal;
      if frmEntConfirmaVencimento.ModalResult <> mrOk then
      begin
        pFreeAndNil(frmEntConfirmaVencimento);
        Exit;
      end
      else
        pFreeAndNil(frmEntConfirmaVencimento);
    end;

    If Not fLiberarValorBoleto Then
      Exit;

    btnConfirma.Enabled := False;

    pAtualizaICMSFrete(objLisFre.fGetAliquotaFrete);

    blnConf := True;
    {**********************************}
    {* DIGITA OCORRÊNCIA DA DEVOLUÇÃO *}
    {*******************************RV*}
    If blnDevolu Then
    Begin
      pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
      frmDigOcorrencia.ShowModal;
      If (frmDigOcorrencia.ModalResult = mrOk) Then
      Begin
        strMotDev := frmDigOcorrencia.strCodOco;
        blnConf := True;
      End
      Else
      Begin
        blnConf := False;
        pFreeAndNil(frmDigOcorrencia);
      end;
      pFreeAndNil(frmDigOcorrencia);
    End;

    If blnConf Then
    Begin

      blnGerarLoteADefinirParaGranitos := False;
      If fTemItemMarmoreGranitoSemLoteADefinirCadastrado then
        blnGerarLoteADefinirParaGranitos := True;


      If (not blnGarantia) And fCfgSis('ATUFOR', varBoolean) And (Pos(strCodFor, fRetForFilialTodos) = 0) And (Not blnDevolu) And (Not blnConEqu) And (Not blnLocEqu) Then
      Begin
         objAtuFor := TAlteraFornecedorEntrada.Create(Nil, strCodFor);
         objAtuFor.pMostraItens;
      End Else
      Begin
        objAtuFor := Nil;
      End;

      If (fMensagem('', 'Confirma gravação?', ['&Sim', '&Não']) = 1) And
         (blnDevolu Or
          fAbreTelaAutorizacao(False,
                               qryEntMer,
                               strNumDoc,
                               strEspDoc,
                               VS_strCodEmp,
                               strSerie,
                               strCodFor,
                               IIF(chkAtuPre.Checked, 'S', 'N'),
                               objAtuFor,
                               dtaDtaEnt,
                               blnPrecoPraticado,
                               blnConEqu or blnLocEqu,
                               fltCotDol,
                               blnEncargosNoFrete)) And
         objFechamento.fVeSeTravaFechamentoEstoque(traMovimentacao, dtaDtaEnt) Then
      Begin
        If Not objOutDes.blnRateioManual Then
          objOutDes.fRateiaOutrasDespesas;
        objVendor.fRateiaVendor;

        Try
          intCtpCon := fRetCtpCon;

          objAuditoriaSaldo.Limpar;

          fStartTransaction;

          If blnGerarLoteADefinirParaGranitos Then
            pGerarLotesADefinirParaGranitoMarmore;

          If Assigned(objAtuFor) Then
            objAtuFor.pAtualizaItens;

          strDocCon := strNumDoc + strEspDoc + VS_strCodEmp + strSerie + strCodFor;

          If Assigned(objLisFre) Then
          Begin
            strDocFre := '';
            fltConFre := objLisFre.fltValCon;
          End Else
          Begin
            strDocFre := '';
            fltConFre := 0;
          End;

          strBcoFor := '';
          If (cbxBcoFor.ItemIndex > -1) Then
            strBcoFor := lstBcoFor[cbxBcoFor.ItemIndex];

          blnResult := fConfirmaEntradaMercadorias(strSeqGer,
                                         strListaItens,
                                         ArrCteMov,
                                         blnGravouMovDet,
                                         blnGerouLotDePreco,
                                         strMatRev,
                                         False,
                                         objAtuFor,
                                         objDefBaixa,
                                         arrLinDigCodbar,
                                         fltCotDol,
                                         fStrToFloat(edtValFre.Text),
                                         edtCodOpe.Text,
                                         mskCndPag.Text,
                                         edtCodPor.Text,
                                         fraPlanoDeContas.MskCodCta.Text,
                                         strCodFor,
                                         strCodFaz,
                                         strNumDoc,
                                         strEspDoc,
                                         dtaDtaEnt,
                                         dtaDtaDoc,
                                         0,
                                         strSerie,
                                         strEstFor,
                                         IIF(chkVeiobo.Checked, 'S', 'N'),
                                         IIF(chkDeposi.Checked, 'S', 'N'),
                                         edtEspVol.Text,
                                         fStrToFloat(edtQtdVol.Text),
                                         fltAlqFor,
                                         pgbDados,
                                         fraCentroCusto.edtCodEve.Text,
                                         blnDevolu,
                                         strCodDig,
                                         edtCodRep.Text,
                                         chkGraFin.Checked,
                                         chkImprCp.Checked,
                                         mmoHisCta.Text,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         oleItensPedidos,
                                         strOrdIte,
                                         Self.Name,
                                         blnCarPro,
                                         recNotEle.strAutInc,
                                         cbxModFre.Text[1],
                                         '',
                                         strMotDev,
                                         qryEntMer,
                                         ObjVendor,
                                         ObjOutDes,
                                         cdsCtpDet,
                                         strAutIncCadFis,
                                         arrDuplicata^,
                                         objEmbala,
                                         Nil,
                                         strDocFre,
                                         fltConFre,
                                         edtNumAD.Text,
                                         intCtpCon,
                                         strAutIncMovGer,
                                         fStrToFloat(edtPesBru.Text),
                                         fStrToFloat(edtPesLiq.Text),
                                         IIF(chkAtuPre.Checked, 'S', 'N'),
                                         0,
                                         0,
                                         blnGarantia,
                                         blnRecCliGarantia,
                                         cdsMovGad,
                                         nil,
                                         blnPedFilialGarantia,
                                         blnConEqu or blnLocEqu,
                                         False,
                                         fRateioFreteValorContabil(tipRatFrete),
                                         blnPrecoPraticado,
                                         Nil,
                                         False,
                                         strBcoFor,
                                         '',
                                         Nil,
                                         '',
                                         Nil,
                                         onBeforeConfirmaEntrada,
                                         onAfterConfirmaEntrada,
                                         xmlEntradaMercadoria, //tpFinalidadeXML: tpeFinalidadeXML = xmlEntradaMercadoria;
                                         Nil, //frmEntRetencaoNotaServico: TfrmEntRetencaoNotaServico = nil;
                                         False, //AblnAcessadoViaRetornoConsignacao : Boolean = False;
                                         ttrImportacaoXML, //ATipoRetornoConsignacao : tTipoRetornoConsignacao = ttrImportacaoXML;
                                         '',
                                         '',
                                         False, //blnRetornoSimbolico: Boolean = False;
                                         Nil, // objEmissaoNotaEspecial : TEmissaoNotaEspecial =nil;
                                         '', // strEmpresaDeposito: String = '';
                                         blnEncargosNoFrete) And

               fAtualizaPedidoDevolucao(strNumDoc,
                                        strEspDoc,
                                        edtCodOpe.Text,
                                        strCodDig,
                                        mskCndPag.Text,
                                        fStrToFloat(edtVlrCon.Text)) And

               obJGNRE.fGravaGnre(strNumDoc, strEspDoc, strSerie, strCodFor, strCodOpe, Self.Name, chkImprCp.Checked, dtaDtaDoc, strAutIncCadFis) And

               ((Not chkPgoAnt.Checked) Or objPgoAnt.fGravaPgtosAntecipados(strSeqGer, strNumDoc, strSerie, fltValorDocumento));

          If blnResult Then
          Begin
            objAuditoriaSaldo.Adicionar(strAutIncMovGer, 'MOVGER');

            If (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
            Begin
              blnResult := False;
              fRollBack;
              pMostraErrosAuditoria(strCodErrosAuditoria);
            End;
          End;

          If blnResult Then
          Begin

            {*******************************************************}
            {* REALIZA GRAVAÇÃO DO FRETE DE CONHECIMENTO SE HOUVER *}
            {****************************************************AF*}
            If objLisFre.fConfirmaFreConhecimento(edtCodPor.Text, Self.Name, strSeqGer, ArrCteMov) Then
            Begin
              fCommit;

              TGeraMensagemPedidoCompraAtendido.pGerarNotificaoParaVendedoresComVendaPendente(strAutIncMovGer, stlPedidos, qryEntMer, edtCodOpe.Text);

              blnConfirma := True;

              pImprimeCPs;

              If fVerificaAcessoSistema('frmLotePrecosEfetivacao') And
                 fCfgSis('ENTEFE', varBoolean) And
                 blnGerouLotDePreco Then
              Begin
                pCriarFormularios(TfrmLotePrecosEfetivacaoCx, frmLotePrecosEfetivacaoCx);
                Try
                  frmLotePrecosEfetivacaoCx.pSetDocumentoDeEntradaLotePreco(strNumDoc,
                                                                            strEspDoc,
                                                                            strSerie,
                                                                            strCodFor,
                                                                            '',
                                                                            fltCotDol,
                                                                            True);
                  frmLotePrecosEfetivacaoCx.ShowModal;
                Finally
                  FreeAndNil(frmLotePrecosEfetivacaoCx);
                End;
              End;

              Close;

            End
            Else
              fRollBack;

          End
          Else
            fRollBack;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[TfrmEntDadosCaixa2.btnConfirmaClick]');
            fRollBack;
            blnConfirma := False;
          End;
        End;

      End;

      objFechamento.pDestravaFechamentoEstoque(traMovimentacao);

    End;
  End;

  If blnConfirma And (Not blnDevolu) And fCfgSis('ENTETI', varBoolean) And (Not fCfgSis('LOTPRE', varBoolean)) Then
    pImprimeEtiqueta;

  If blnConfirma AND fCfgSis('IMPLIB', varBoolean) Then
    pImprimeLiberacaoArmazenamento;

  If blnConfirma AND fCfgSis('ENTLIS', varBoolean) Then
    pMonstraItensImprimeLista(strListaItens);

  If Assigned(objAtuFor) Then
    FreeAndNil(objAtuFor);

  btnConfirma.Enabled := True;
end;

procedure TfrmEntDadosCaixa2.pMonstraItensImprimeLista(strItens: String);
  Var
    objImpLis: TEntImprimeLista;
Begin
  objImpLis := TEntImprimeLista.Create(Self, strItens);
  objImpLis.pMostraItens;
  FreeAndNil(objImpLis);
End;

procedure TfrmEntDadosCaixa2.pEscapePressed;
begin
  If (blnGarantia) Or (blnRecCliGarantia) Or (blnConEqu) Or blnLocEqu Then
  Begin
    inherited;
    Exit;
  End;

  If (ActiveControl.Parent = pnlCabecalho) Then
  Begin
    inherited;
  End
  Else If (ActiveControl.Parent = pnlContasPagar) Then
  Begin
    pnlCabecalho.Enabled   := True;
    pnlTipoFrete.Enabled   := True;
    pnlContasPagar.Enabled := False;
    btnConfirma.Enabled    := False;
    pSetFocus(edtValFre);
  End
  Else
  Begin

    If (pnlCabecalho.Enabled) Then
      pSetFocus(edtValFre)
    Else
      pSetFocus(edtCodOpe);

  End;
end;

procedure TfrmEntDadosCaixa2.pGerarLotesADefinirParaGranitoMarmore;
var qryGenerica, qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  qryGenerica := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT ENT_CODITE FROM TMP_ENTMER ');
    qryConsulta.SQL.Add('  LEFT JOIN CADLOT ON LOT_CODEMP = "' + VS_StrCodEmp + '"');
    qryConsulta.SQL.Add('                  AND LOT_NUMLOT = "A DEFINIR"');
    qryConsulta.SQL.Add('                  AND LOT_CODITE = ENT_CODITE  ');
    qryConsulta.SQL.Add(' WHERE ENT_GRAMAR = "S"  ');
    qryConsulta.SQL.Add('   AND CADLOT.AUTOINCREM IS NULL ');

    qryConsulta.Open;
    qryGenerica.SQL.Text := 'SELECT * FROM CADLOT WHERE FALSE';
    qryGenerica.Open;

    While Not qryConsulta.Eof Do
    Begin
      qryGenerica.Insert;
      qryGenerica.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOT', VS_StrCodEmp);
      qryGenerica.FieldByName('LOT_NUMLOT').AsString   := 'A DEFINIR';
      qryGenerica.FieldByName('LOT_CODEMP').AsString   := VS_StrCodEmp;
      qryGenerica.FieldByName('LOT_CODITE').AsString   := qryConsulta.FieldByName('ENT_CODITE').AsString;
      qryGenerica.FieldByName('LOT_DTAFAB').Value      := VS_Date;
      qryGenerica.FieldByName('LOT_DTAVAL').Value      := IncYear(VS_Date);
      qryGenerica.FieldByName('LOT_DTABAL').Value      := VS_Date -1;//Nao pode ser VS_date, na data de balanco nao pode existir movimentacao
      qryGenerica.FieldByName('LOT_SALBAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALDOS').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_ML_BAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SAL_ML').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_SALCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIGCON').AsString   := 'N';
      qryGenerica.FieldByName('LOT_ORDCON').Value      := Null;
      qryGenerica.FieldByName('LOT_DIFSAL').AsFloat    := 0;
      qryGenerica.FieldByName('LOT_LOCFIS').AsString   := '';
      qryGenerica.Post;
      qryConsulta.Next;
    End;

  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(qryGenerica);
  End;
end;

procedure TfrmEntDadosCaixa2.btnCancelarEntradaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmEntDadosCaixa2.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  Try
    if fPesqOperador(Self, edtCodOpe, edtNomOpe, qryConOpe, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodOpe, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmEntDadosCaixa2.edtCodOpeKeyPress]');
    End;
  End;
end;

procedure TfrmEntDadosCaixa2.mskCndPagExit(Sender: TObject);
begin
  inherited;

  pHabilitaVendorOutrasDespesas;
  
end;

procedure TfrmEntDadosCaixa2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_F7 : btnImpEspelho.Click;
    VK_F8 : btnOutDes.Click;
    VK_F6 : btnVendor.Click;
    VK_F5 : btnConFre.Click;
    VK_F4 : btnConfDigitacao.Click;
    VK_F2 : btnGnre.Click;
    VK_F3 : btnDesmembraValores.Click;
    VK_RETURN : If ActiveControl Is TComboBox Then
                  SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntDadosCaixa2.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnConfirma);
end;

procedure TfrmEntDadosCaixa2.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryConPor);
  FreeAndNil(qryPreAlt);
  FreeAndNil(qryCadPag);
  FreeAndNil(objPgoAnt);
  FreeAndNil(cdsCtpDet);
  FreeAndNil(FValidaCorrespondenteContabil);
end;

procedure TfrmEntDadosCaixa2.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    if fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, qryConPor, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    pCarregaPortador;

  End;

end;

procedure TfrmEntDadosCaixa2.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

function TfrmEntDadosCaixa2.fRetornaParcelas: String;
  Var
    intContador  : Integer;
    strParcelas  : String;
    strAgrupamento: String;
    stlAgrupamentos: TStringList;
    intAgrup: Integer;
Begin
  stlAgrupamentos := TStringList.Create;
  stlAgrupamentos.Sorted     := True;
  stlAgrupamentos.Duplicates := dupIgnore;

  Try
    Try
      strAgrupamento := '';
      strParcelas := '';
      For intContador := 0 To Length(objEspNota.arrParcelas) -1 Do
      Begin
        If Not fEmptyStr(objEspNota.arrParcelas[intContador].strNumAgp) Then
          stlAgrupamentos.Add(String(objEspNota.arrParcelas[intContador].strNumAgp));

        {* Req. 455181 - arrLetras e Array[0..23] e arrParcelas e dinamico.  *}
        {* A guarda cobre SOMENTE o uso de arrLetras: um Break aqui abortaria *}
        {* tambem a coleta de stlAgrupamentos das parcelas seguintes.         *}
        If intContador <= High(arrLetras) Then
          strParcelas := strParcelas + String(arrLetras[intContador]) + ') ' + objEspNota.arrParcelas[intContador].strData + ' ' + objEspNota.arrParcelas[intContador].strValor +  ' Boleto: '+ objEspNota.arrParcelas[intContador].strVeioBo +'   ';
      End;

      If stlAgrupamentos.Count > 0 Then
      Begin
        For intAgrup := 0 To stlAgrupamentos.Count - 1 Do
          strAgrupamento := strAgrupamento + String(objEspNota.arrParcelas[intAgrup].strNumAgp) + ' ';
      End;

      Result := strParcelas;

      If Not fEmptyStr(strAgrupamento) Then
        Result := 'Agrupamento : ' + strAgrupamento + #13#10 + Result;

    Except
      Result := '';
    End;
  Finally
    stlAgrupamentos.Free;
  End;
End;

function TfrmEntDadosCaixa2.fRetCentroCustoDoc: String;
Begin
  If Length(objEspNota.arrParcelas) > 0 Then
    Result := fFormataCCusto(objEspNota.arrParcelas[0].strCodCta) + '-' + fRetDescCentroCusto(objEspNota.arrParcelas[0].strCodCta)
  Else
    Result := '';
End;

procedure TfrmEntDadosCaixa2.btnImpEspelhoClick(Sender: TObject);
  Var
    strGNRE: string;
    qrySetaVar: TUniQuery;
    frmRelEspNotaEnt: TfrmRelEspNotaEnt;

    Procedure pSetaParcelasEspelho;
      Var
        intContador: Integer;
    Begin
      If chkPgoAnt.Checked Then
        objPgoAnt.fRecalculaPagamentosAntecipados(strNumDoc, strSerie, fltValorDocumento, objEspNota.arrParcelas, arrDuplicata^);

      objEspNota.pZerarParcelas;

      For intContador := 0 To Length(arrDuplicata^) -1 Do
      Begin

        If Not fEmptyStr(ArrDuplicata[intContador].dtaDtaVen) Then
        Begin
          SetLength(objEspNota.arrParcelas, Succ(Length(objEspNota.arrParcelas)));
          objEspNota.arrParcelas[High(objEspNota.arrParcelas)].strData   := FormatDateTime('dd/mm/yy',StrToDateTime(ArrDuplicata[intContador].dtaDtaVen));
          objEspNota.arrParcelas[High(objEspNota.arrParcelas)].strValor  := FloatToStrF(ArrDuplicata[intContador].curValor,ffNumber,15,2);
          objEspNota.arrParcelas[High(objEspNota.arrParcelas)].strCodCta := fraPlanoDeContas.MskCodCta.Text;
        End;

      End;

    End;

    function fRetConhecimentoFrete: string;
    begin
      Result := '';
      if not objLisFre.IsEmpty then
      begin
        Result := fPadR('CONHECIMENTO DE FRETE', 25) +
                  fPadR('FORNECEDOR', 50) +
                  fPadR('', 5) +
                  fPadL('VALOR TOTAL', 16) +
                  fPadL('VR. PROP. AO DOCTO' + IIF(objEspNota.blnDedFre, ' (1)', ''), 30) +
                  fPadR('', 5) +
                  fPadR('CONDIÇÃO DE PAGAMENTO', 40);
        objLisFre.First;
        while not objLisFre.Eof do
        begin
          Result := Result + #13#10;
          Result := Result + fDescricaoFrete(cbxModFre.Text[1]);
          Result := Result + #13#10;
          Result := Result + fPadR(objLisFre.FieldByName('NUMDOC').AsString + '-' + objLisFre.FieldByName('ESPDOC').AsString + '-' + objLisFre.FieldByName('CODEMP').AsString + '-' + objLisFre.FieldByName('SERIE_').AsString, 25) +
                    fPadR(objLisFre.FieldByName('CODTRA').AsString + '-' + objLisFre.FieldByName('NOMTRA').AsString, 50) +
                    fPadR('', 5) +
                    fPadL(FormatFloat('#,##0.00', objLisFre.FieldByName('VALCON').AsFloat), 16) +
                    fPadL(FormatFloat('#,##0.00', objEspNota.fRetSomaConhecimento), 30) +
                    fPadR('', 5) +
                    fPadR(objEspNota.fCondPagtoConhecimentoFrete, 40);
          Result := Result + #13#10;
          Result := Result + objEspNota.fDuplicatasConhecimentoFrete(objLisFre.FieldByName('NUMDOC').AsString, objLisFre.FieldByName('ESPDOC').AsString, objLisFre.FieldByName('SERIE_').AsString, objLisFre.FieldByName('CODTRA').AsString);
          objLisFre.Next;
        end;
        objLisFre.First;
      end;
    end;

begin

  If Not (btnImpEspelho.Visible) Then
    Exit;

  If ((fValidaCampos(mskCndPag,False)) And
     (((Not fEmptyStr(strCndAnt)) And (mskCndPag.Text = strCndAnt)) Or chkPgoAnt.Checked)) Or blnManterCFOPBonificao Then
  Begin
    Try
      pSetaParcelasEspelho;

      if fCfgSis('ENTEDI', varBoolean) then
      begin

        { Preciso setar esses objetos no objEspNota pois as variáveis @VENDOR, @ICMANT, @OUTDES e @CONFRE vão usá-las }
        objEspNota.objLisFre := Self.objLisFre;
        objEspNota.objVendor := Self.objVendor;
        objEspNota.objOutDes := Self.objOutDes;

        If Assigned(objEspNota.objVendor) Then
          objEspNota.objVendor.fRateiaVendor;

        If Assigned(objEspNota.objOutDes) Then
          If Not objEspNota.objOutDes.blnRateioManual Then
            objEspNota.objOutDes.fRateiaOutrasDespesas;

        { objGnre é o único objeto que não sofre alterações depois de setado nessa unit, por isso pode ser usado direto }
        if Assigned(objGnre) And (Not fEmptyStr(objGnre.strValGnr)) then
          strGNRE := 'CONCAT(LPAD(FORMAT(:VALGNR, 2), 15, " "), RPAD("", 2, " "), RPAD(CONCAT(:CODFOR,"-",:NOMFOR), 73, " "), RPAD(DATE_FORMAT(:DTAVEN, "%d/%m/%Y"), 10, " "))'
        else
          strGNRE := '""';

        qrySetaVar := fCriaQuery;
        try
          qrySetaVar.Close;
          qrySetaVar.SQL.Clear;
          qrySetaVar.SQL.Add('SET @VENDOR   = :VENDOR;');
          qrySetaVar.SQL.Add('SET @ICMANT   = :ICMANT;');
          qrySetaVar.SQL.Add('SET @OUTDES   = :OUTDES;');
          qrySetaVar.SQL.Add('SET @CONFRE   = :CONFRE;');
          qrySetaVar.SQL.Add('SET @PEDIDOS  = :PEDIDOS;');
          qrySetaVar.SQL.Add('SET @PARCELAS = :PARCELAS;');
          qrySetaVar.SQL.Add('SET @PLACONTA = :PLACONTA;');
          qrySetaVar.SQL.Add('SET @GNRE     = ' + strGNRE + ';');

          qrySetaVar.ParamByName('VENDOR').AsString  := objEspNota.fRetVendorDigitacao;
          qrySetaVar.ParamByName('ICMANT').AsString  := objEspNota.fRetICMAntDigitacao;
          qrySetaVar.ParamByName('OUTDES').AsString  := objEspNota.fRetOutrasDespesasDigitacao;
          qrySetaVar.ParamByName('CONFRE').AsString  := fRetConhecimentoFrete;
          qrySetaVar.ParamByName('PEDIDOS').AsString := stlPedidos.Text;
          qrySetaVar.ParamByName('PARCELAS').AsString := fRetornaParcelas;
          qrySetaVar.ParamByName('PLACONTA').AsString := fRetCentroCustoDoc;

          if Assigned(objGnre) And (Not fEmptyStr(objGnre.strValGnr)) then
          begin
            qrySetaVar.ParamByName('VALGNR').AsFloat := fStrToFloat(objGnre.strValGnr);
            qrySetaVar.ParamByName('CODFOR').AsString := strCodFor;
            qrySetaVar.ParamByName('NOMFOR').AsString := fRetNomFornecedor(strCodFor);
            qrySetaVar.ParamByName('DTAVEN').AsDateTime := StrToDate(objGnre.strDtaVen);
          end;

          qrySetaVar.ExecSQL;
        finally
          FreeAndNil(qrySetaVar);
        end;

        if Assigned(prcExecutaRelatorio) then
          prcExecutaRelatorio(412, 19185, [19185],
                              ['CODEMP', 'NUMDOC', 'ESPDOC', 'SERIE_', 'CODFOR',
                               'DTAENT', 'DTADOC', 'CONPAG', 'CODOPE'],
                              [VS_strCodEmp, strNumDoc, strEspDoc, strSerie, strCodFor,
                               DateToStr(dtaDtaEnt), DateToStr(dtaDtaDoc), mskCndPag.Text, edtCodOpe.Text],
                              Sender, nil);

      end
      else
      begin

        pCriarFormularios(TfrmRelEspNotaEnt, frmRelEspNotaEnt);

        objEspNota.strPedidos := stlPedidos.Text;

        frmRelEspNotaEnt.objEspNota := objEspNota;
        frmRelEspNotaEnt.objGNRE    := obJGNRE;

        frmRelEspNotaEnt.blnEntMer  := True;

        frmRelEspNotaEnt.strCodFor  := strCodFor;
        frmRelEspNotaEnt.strNumDoc  := strNumDoc;
        frmRelEspNotaEnt.strEspDoc  := strEspDoc;
        frmRelEspNotaEnt.strSerie   := strSerie;
        frmRelEspNotaEnt.strCndPag  := mskCndPag.Text;
        frmRelEspNotaEnt.strDtaEnt  := DateToStr(dtaDtaEnt);
        frmRelEspNotaEnt.strDtaDoc  := DateToStr(dtaDtaDoc);
        frmRelEspNotaEnt.objLisFre  := objLisFre;
        frmRelEspNotaEnt.objVendor  := objVendor;
        frmRelEspNotaEnt.objOutDes  := objOutDes;
        frmRelEspNotaEnt.blnDevolu  := blnDevolu;
        frmRelEspNotaEnt.strCodOpe  := edtCodOpe.Text;
        frmRelEspNotaEnt.strNomOpe  := edtNomOpe.Text;

        If blnDevolu Then
          frmRelEspNotaEnt.Caption    := 'Relatório de Espelho Nota de Devolução (Entrada)';
        frmRelEspNotaEnt.ShowModal;
        FreeAndNil(frmRelEspNotaEnt);

      end;
      
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmEntDadosCaixa2.btnImpEspelhoClick]');
      End;
    End;
  End;
end;

procedure TfrmEntDadosCaixa2.btnOutDesClick(Sender: TObject);
begin
  inherited;

  If Not (btnOutDes.Enabled And btnOutDes.Visible) Then
    Exit;

  objOutDes.blnConverteQtdItensEmb := ((fCfgSis('CNVEMB', varString) <> 'N') And (Not blnDevolu) And (Not blnRecCliGarantia) And (Not blnConEqu) And (Not blnLocEqu));
  objOutDes.fInformaOutrasDespesas(arrDuplicata^, strCodFor, dtaDtaEnt);

  pAtualizarObjLisFre;
  objLisFre.pSetValorRpa(objOutDes.fTotalFreteRpa, objOutDes.tipRatFreteRPA);
end;

procedure TfrmEntDadosCaixa2.pAtualizarObjLisFre;
begin
  objLisFre.strEspNot := strEspDoc;
  objLisFre.fltTotIte := fStrToFloat(edtTotIte.Text);;
  objLisFre.tipRatFrete := tipRatFrete;
  objLisFre.fltVlrCon := fStrToFloat(edtVlrCon.Text);
  objLisFre.fltTotLiq := fStrToFloat(edtTotIte.Text) - fStrToFloat(edtDesEsp.Text);
  objLisFre.strCodPor := edtCodPor.Text;
end;

procedure TfrmEntDadosCaixa2.btnPgoAntClick(Sender: TObject);
begin
  inherited;

  pCalculaValorDocumento;
  chkPgoAnt.Checked := objPgoAnt.fSelecionaDuplicatas(fltValorDocumento, fltBonificacao);

  pAjustaTelaPgoAntecipado;

  SelectNext(ActiveControl, True, True);
  {If chkPgoAnt.Checked Then
  Begin
    pSetFocus(chkImprCp);
  End Else
  Begin
    pSetFocus(mskCndPag);
  End;}
end;

procedure TfrmEntDadosCaixa2.btnVendorClick(Sender: TObject);
begin
  inherited;

  If Not (btnVendor.Enabled And btnVendor.Visible) Then
    Exit;
    
  objVendor.fInformaVendor(strCodFor);

end;

procedure TfrmEntDadosCaixa2.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmEntDadosCaixa2.pCarregaDadosBancariosFornecedor(
  strCodFor: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    cbxBcoFor.Clear;
    lstBcoFor.Clear;
    With qryGen, SQL Do
    Begin
      Clear;
      Add(getSQLDadosBancariosFornecedor);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;

      While Not Eof Do
      Begin
        cbxBcoFor.Items.Add(Trim(FieldByName('DESC_CONTA').AsString));
        lstBcoFor.Add(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

      Close;
    End;
  Finally
    If Pred(cbxBcoFor.Items.Count) >= intIdxBcoForAnt Then
      cbxBcoFor.ItemIndex := intIdxBcoForAnt;
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmEntDadosCaixa2.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodDig.Text, True);
  With qryConOpe Do
  Begin
    edtNomDig.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmEntDadosCaixa2.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  Try
    if fPesqOperador(Self, edtCodRep, edtNomRep, qryConOpe, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodRep, True) Then
        SelectNext(ActiveControl, True, True);
    End;

    pCarregaRepresentante;

  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmEntDadosCaixa2.edtCodRepKeyPress]');
    End;
  End;
end;

procedure TfrmEntDadosCaixa2.edtDesEspExit(Sender: TObject);
begin
  inherited;
  pSetFocus(cbbTipFre);
end;

procedure TfrmEntDadosCaixa2.edtNumADKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
(*
  If fPesqAgendamentoDevolucao(Self, edtNumAD, Nil, Key, strCodFor) Then
  Begin
    If fValidaCampos(edtNumAD) Then
      SelectNext(edtNumAD, True, True);
  End;
  *)
end;

procedure TfrmEntDadosCaixa2.edtValFreExit(Sender: TObject);
begin
  inherited;
  pHabilitaRateioFrete;
end;

procedure TfrmEntDadosCaixa2.pCarregaRepresentante;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodRep.Text);
  With qryConOpe Do
  Begin
    edtNomRep.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmEntDadosCaixa2.pHabilitaVendorOutrasDespesas;
Begin
  objVendor.blnGravar := (fStatusCndPag(mskCndPag.Text) = A_VISTA) Or
                          chkGraFin.Checked;

  btnVendor.Enabled := objVendor.blnGravar;

  btnOutDes.Enabled := (fStatusCndPag(mskCndPag.Text) <> A_VISTA) Or
                       ((fStatusCndPag(mskCndPag.Text) = A_VISTA) And
                         chkGraFin.Checked);
End;

procedure TfrmEntDadosCaixa2.cbbTipFreChange(Sender: TObject);
begin
  inherited;
  case cbbTipFre.ItemIndex Of
    0 : tipRatFrete := trfPropValorItem;
    1 : tipRatFrete := trfPropPesoItem;
    2 : tipRatFrete := trfPropQtdItem;
  end;

end;

procedure TfrmEntDadosCaixa2.cbxBcoForChange(Sender: TObject);
begin
  inherited;
  intIdxBcoForAnt := cbxBcoFor.ItemIndex;
end;

procedure TfrmEntDadosCaixa2.cbxBcoForDropDown(Sender: TObject);
begin
  inherited;
  SendMessage(cbxBcoFor.Handle, CB_SETDROPPEDWIDTH, 315, 0);
end;

procedure TfrmEntDadosCaixa2.cbxBcoForEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para incluir/alterar dados bancários do fornecedor';
end;

procedure TfrmEntDadosCaixa2.cbxBcoForExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmEntDadosCaixa2.cbxBcoForKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key =  VK_Insert) Then
  Begin
    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

    try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := strCodFor;
      frmCadFornecedores.fMskCon := fMskCon;
      frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
      frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
      frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
      frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
      frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
      frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
      frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
      frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
      frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
      frmCadFornecedores.ShowModal;
    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
      pCarregaDadosBancariosFornecedor(strCodFor);
      pFreeAndNil(frmCadFornecedores);
    End;

  End;
end;

procedure TfrmEntDadosCaixa2.cbxModFreChange(Sender: TObject);
var intModFreSelec: integer;
    blnDescontaFreteDevolucaoOriginal: Boolean;
begin
  If blnDevolu Then
  Begin
    blnDescontaFreteDevolucaoOriginal := blnDescontaFreteDevolucao;
    intModFreSelec := StrToInt(cbxModFre.Text[1]);
    blnDescontaFreteDevolucao := blnDevolu and((fCfgSis('FREDEV') = 1) Or ((fCfgSis('FREDEV') = 3) And (intModFreSelec in[1, 3, 4, 9])));
    If blnDescontaFreteDevolucaoOriginal <> blnDescontaFreteDevolucao Then
      fValidaCampos(mskCndPag)
  End;

end;

procedure TfrmEntDadosCaixa2.chkAtuPreClick(Sender: TObject);
  Var
    strSenOpe: String;
begin
  inherited;

  If chkAtuPre.Checked Then
  Begin
  
    If Not (ffrmSenha(strSenOpe, 'Desativar atualização Preço') And
            fVerificaAcessoSistema('NAOATUPRE', fRetCodVendedor(strSenOpe))) Then
    Begin
      pMensagemOk('Operador sem direito de acesso!');
      chkAtuPre.Checked := False;
    End;

  End;
end;

procedure TfrmEntDadosCaixa2.chkDeposiClick(Sender: TObject);
begin
  inherited;
  cbxBcoFor.Enabled := chkDeposi.Checked;

  If Not cbxBcoFor.Enabled Then
    cbxBcoFor.ItemIndex := -1;
end;

procedure TfrmEntDadosCaixa2.chkGraFinClick(Sender: TObject);
begin
  inherited;

  pHabilitaCamposFinanceiro;
end;

procedure TfrmEntDadosCaixa2.pHabilitaCamposFinanceiro;
Begin
  If (chkGraFin.Checked Or chkPgoAnt.Checked) And blnTravarFinanceiroEstaDuplicado Then
  begin
    fMensagem('ATENÇÃO!', 'Já existe uma duplicata no contas a pagar com esses dados!', ['&O k']);
    chkPgoAnt.Checked := False;
    chkGraFin.Checked := False;
  End;
  edtCodPor.Enabled := chkGraFin.Checked;
  mmoHisCta.Enabled := chkGraFin.Checked;
  lblInfCtp.Enabled := chkGraFin.Checked;

  If Not mmoHisCta.Enabled Then
    mmoHisCta.Clear;

  If Not edtCodPor.Enabled Then
  Begin
    edtCodPor.Text := '';
    edtNomPor.Text := '';
  End;

  pHabilitaVendorOutrasDespesas;
End;

procedure TfrmEntDadosCaixa2.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If blnDevolu Or (Not fCfgSis('USACTF', varBoolean)) Or blnGarantia Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
      If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
      End
      Else
      Begin
        If fValidaCampos(fraPlanoDeContas.MskCodCta, true) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
      pCarregaCentroCusto;
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, strCodFor) Then
    Begin
      If Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não permitido!', ['&O k']);
      End
      Else
      Begin
        If fValidaCampos(fraPlanoDeContas.MskCodCta, true) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
      pCarregaCentroCusto;
    End;
  End;

end;

Function TfrmEntDadosCaixa2.fTemAntecipadoValorMenor: Boolean;
Begin
  Result := (RoundTo(objPgoAnt.fltTotSel, -2) < RoundTo(fStrToFloat(edtVlrCon.Text), -2)) And chkPgoAnt.Checked;
End;

function TfrmEntDadosCaixa2.fTemItemMarmoreGranitoSemLoteADefinirCadastrado: Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD FROM TMP_ENTMER ');
    qryConsulta.SQL.Add('  INNER JOIN CADLOT ON LOT_CODEMP = "' + VS_StrCodEmp + '"');
    qryConsulta.SQL.Add('                  AND LOT_NUMLOT = ENT_NUMLOT  ');
    qryConsulta.SQL.Add('                  AND LOT_CODITE = ENT_CODITE  ');
    qryConsulta.SQL.Add(' WHERE ENT_GRAMAR = "S"  ');
    qryConsulta.SQL.Add('   AND ENT_NUMLOT = "A DEFINIR"  ');

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger = 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmEntDadosCaixa2.pAjustaTelaPgoAntecipado;
Begin
  If chkPgoAnt.Checked Then
  Begin
    btnPgoAnt.Enabled := True;
    chkGraFin.Enabled := False;
    chkGraFin.Checked := fTemAntecipadoValorMenor;
    mskCndPag.Enabled := fTemAntecipadoValorMenor;
    mskCndPag.Clear;
    pZeraDigDuplic(arrDuplicata^);
  End Else
  Begin
    btnPgoAnt.Enabled := False;
    mskCndPag.Clear;
    pZeraDigDuplic(arrDuplicata^);

    mskCndPag.Enabled := True;
    objPgoAnt.pSetaListaSelecao(Nil);
    pHabilitaFinanceiro;
  End;

  pHabilitaCamposFinanceiro;

  If (chkGraFin.Checked Or chkPgoAnt.Checked) And blnTravarFinanceiroEstaDuplicado Then
    begin
      fMensagem('ATENÇÃO!', 'Já existe uma duplicata no contas a pagar com esses dados!', ['&O k']);
      chkGraFin.Checked := False;
      chkPgoAnt.Checked := False;
    End;

End;

procedure TfrmEntDadosCaixa2.chkPgoAntClick(Sender: TObject);
begin
  inherited;

  pAjustaTelaPgoAntecipado;
end;

procedure TfrmEntDadosCaixa2.btnConFreClick(Sender: TObject);
begin
  inherited;

  If (tipRatFrete = trfPropPesoItem) And (Not fVerificaPesoDosItensEntrada) Then
    Exit;

  objLisFre.strEspNot := strEspDoc;
  objLisFre.tipRatFrete := tipRatFrete;
  objLisFre.fltTotIte := fStrToFloat(edtTotIte.Text);
  objLisFre.fltVlrCon := fStrToFloat(edtVlrCon.Text);
  objLisFre.fltTotLiq := fStrToFloat(edtTotIte.Text) - fStrToFloat(edtDesEsp.Text);
  objLisFre.pGridConhecimento;

end;

function TfrmEntDadosCaixa2.fAtualizaPedidoDevolucao(strNumFat,
                                                     strEspFat,
                                                     strVenFat,
                                                     strDigFat,
                                                     strCndfat: String;
                                                     fltValFat: Double): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  Result  := True;

  If fEmptyStr(strPedDev) Then
    Exit;

  Try

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  FATGOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FGO_NUMFAT = :NUMFAT, ';
    strSQL := strSQL + '  FGO_TIPFAT = :ESPFAT, ';
    strSQL := strSQL + '  FGO_JAFATU = TRUE, ';
    strSQL := strSQL + '  FGO_DTAFAT = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  FGO_VENFAT = :VENFAT, ';
    strSQL := strSQL + '  FGO_DIGFAT = :DIGFAT, ';
    strSQL := strSQL + '  FGO_CNDFAT = :CNDFAT, ';
    strSQL := strSQL + '  FGO_VALFAT = :VALFAT  ';


    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strPedDev;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('NUMFAT').AsString := strNumFat;
      ParamByName('ESPFAT').AsString := strEspFat;

      If (fEmptyStr(strVenFat)) Then
        ParamByName('VENFAT').Value := Null
      Else
        ParamByName('VENFAT').AsString := strVenFat;

      If (fEmptyStr(strDigFat)) Then
        ParamByName('DIGFAT').Value := Null
      Else
        ParamByName('DIGFAT').AsString := strDigFat;

      ParamByName('CNDFAT').AsString := strCndFat;
      ParamByName('VALFAT').AsFloat  := fltValFat;

      ExecSQL;
      Close;

    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  FATDOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FDO_NUMFAT = :NUMFAT, ';
    strSQL := strSQL + '  FDO_TIPFAT = :ESPFAT, ';
    strSQL := strSQL + '  FDO_JAFATU = TRUE, ';
    strSQL := strSQL + '  FDO_DTAFAT = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  FDO_VENFAT = :VENFAT, ';
    strSQL := strSQL + '  FDO_EMPFAT = :CODEMP, ';
    strSQL := strSQL + '  FDO_CNDFAT = :CNDFAT, ';
    strSQL := strSQL + '  FDO_VALFAT = :VALFAT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FDO_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

    With qryGen Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strPedDev;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      ParamByName('NUMFAT').AsString := strNumFat;
      ParamByName('ESPFAT').AsString := strEspFat;

      If (fEmptyStr(strVenFat)) Then
        ParamByName('VENFAT').Value := Null
      Else
        ParamByName('VENFAT').AsString := strVenFat;

      ParamByName('CNDFAT').AsString := strCndFat;
      ParamByName('VALFAT').AsFloat  := fltValFat;
      ExecSQL;
      Close;

    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaPedidoDevolucao]');
    End;
  End;

end;


function TfrmEntDadosCaixa2.fLiberarValorBoleto: Boolean;
Var
  RecParametrosLiberacaoValorBoleto: TRecParametrosLiberacaoValorBoleto;
Begin
  pCalculaValorDocumento;
  RecParametrosLiberacaoValorBoleto.Create(strNumDoc, strSerie);
  RecParametrosLiberacaoValorBoleto.strCodFor := strCodFor;
  RecParametrosLiberacaoValorBoleto.strNomFor := fRetNomFornecedor(strCodFor);
  RecParametrosLiberacaoValorBoleto.strCodOpe := edtCodOpe.Text;
  RecParametrosLiberacaoValorBoleto.strCodDig := edtCodDig.Text;

  RecParametrosLiberacaoValorBoleto.blnAcessoViaPreNota := False;
  RecParametrosLiberacaoValorBoleto.fltValorContabil := fltValorDocumento;
  RecParametrosLiberacaoValorBoleto.fltValorDocumento := fltValorDocumento;

  RecParametrosLiberacaoValorBoleto.fltTotAdiantamento := objPgoAnt.fltTotUso;
  RecParametrosLiberacaoValorBoleto.arrDuplicata := ArrDuplicata;
  Result := TLiberacaoValorBoleto.fLiberarValorBoleto(RecParametrosLiberacaoValorBoleto);
end;

function TfrmEntDadosCaixa2.fObterTipoEntrada: TTipoEntrada;
begin
  Result :=  TTipoEntrada(ord(rdgTipoEntrada.ItemIndex));
end;

procedure TfrmEntDadosCaixa2.btnConfDigitacaoClick(Sender: TObject);
  Var
    frmRelEstDigitacaoNotaEntrada: TfrmRelEstDigitacaoNotaEntrada;
begin
  inherited;
  If Not btnConfDigitacao.Visible Then
    Exit;

  Try
    pCriarFormularios(TfrmRelEstDigitacaoNotaEntrada, frmRelEstDigitacaoNotaEntrada);
    frmRelEstDigitacaoNotaEntrada.pImprimeRelatorio(oleItensPedidos);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEntDadosCaixa2.btnConfDigitacaoClick]');
    End;
  End;

  pFreeAndNil(frmRelEstDigitacaoNotaEntrada);

end;

procedure TfrmEntDadosCaixa2.btnGnreClick(Sender: TObject);
begin
  inherited;

  obJGNRE.pTelaGnre(Not fEmptyStr(recNotEle.strAutInc), fCfgSis('FORGNE'));
  obJGNRE.fAtualizaValorGnre;
end;

procedure TfrmEntDadosCaixa2.pImprimeEtiqueta;
Begin
  TfrmEntEtiquetas.pImpEtiEntradaMercadorias(strNumDoc, strEspDoc, strCodFor, strSerie);
End;

procedure TfrmEntDadosCaixa2.pImprimeLiberacaoArmazenamento;
  Var
    frmQckLiberacaoArmazenamento: TfrmQckLiberacaoArmazenamento;
begin
  pCriarFormularios(TfrmQckLiberacaoArmazenamento,frmQckLiberacaoArmazenamento);
  With frmQckLiberacaoArmazenamento Do
    pImprimir(strNumDoc, strEspDoc, strSerie, strCodFor, VS_strCodEmp, 'frmEntMercadorias_LIBARM', '', 'F', oriLibEntradaDadosCaixa);
  FreeAndNil(frmQckLiberacaoArmazenamento);

end;

procedure TfrmEntDadosCaixa2.btnDesmembraValoresClick(Sender: TObject);
  Var
    frmDesmembrValores : TfrmDesmembrValores;
  procedure pCarregaDadosTmpCtpDet;
  begin
    If Assigned(cdsCtpDet) Then
    Begin
      If Not cdsCtpDet.Active Then
        cdsCtpDet.Open;
    End;
  end;
begin
  inherited;

  If (Not btnDesmembraValores.Visible) Then
    Exit;

  Try
    pCarregaDadosTmpCtpDet;

    pCriarFormularios(TfrmDesmembrValores, frmDesmembrValores);
    frmDesmembrValores.DatasetCtpDet := cdsCtpDet;
    frmDesmembrValores.strNumDup := '';
    frmDesmembrValores.strParcel := '';
    frmDesmembrValores.strSerie  := '';
    frmDesmembrValores.strCodEmp := '';
    frmDesmembrValores.strCodFor := '';
    frmDesmembrValores.fltValTot := fStrToFloat(edtVlrCon.Text);

    frmDesmembrValores.blnEntMer := True;

    frmDesmembrValores.FValidaCorrespondenteContabil := Self.FValidaCorrespondenteContabil;

    frmDesmembrValores.showModal;

    If Not cdsCtpDet.IsEmpty Then
    Begin
      fraPlanoDeContas.MskCodCta.Enabled := False;

      If fEmptyStr(frmDesmembrValores.strCodCta) Then
        fraPlanoDeContas.MskCodCta.Text    := fCfgSis('CTAPRI')
      Else
        fraPlanoDeContas.MskCodCta.Text    := frmDesmembrValores.strCodCta;

      pCarregaCentroCusto;

      SelectNext(fraPlanoDeContas.MskCodCta, True, True);
    End
    Else
    Begin
      fraPlanoDeContas.MskCodCta.Enabled := True;

      pSetFocus(fraPlanoDeContas.MskCodCta);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmEntDadosCaixa2.btnDesmembraValoresClick]');
    End;
  End;
  pFreeAndNil(frmDesmembrValores);
end;

procedure TfrmEntDadosCaixa2.pDeterminaTipoDeFrete;
  Var
    intRatFre: Integer;
Begin
  intRatFre := fCfgSis('RATFRE', varInteger);
  pnlTipoFrete.Visible := intRatFre = 3;

  case fCfgSis('RATFRE', varInteger) Of
    1 : tipRatFrete := trfPropValorItem;
    2 : tipRatFrete := trfPropPesoItem;
    3 : tipRatFrete := trfDefinirEntrada;
    4 : tipRatFrete := trfPropQtdItem;
  End;

  pnlTipoFrete.Visible := tipRatFrete In [trfDefinirEntrada, trfInformarPercentuais];

  If Not pnlTipoFrete.Visible Then
    pnlCabecalho.Height := pnlCabecalho.Height - pnlTipoFrete.Height
  Else
    cbbTipFre.ItemIndex := 0;
End;

procedure TfrmEntDadosCaixa2.pHabilitaRateioFrete;
Begin
  cbbTipFre.Enabled := fStrToFloat(edtValFre.Text) > 0;
End;

procedure TfrmEntDadosCaixa2.mskCndPagKeyPress(Sender: TObject; var Key: Char);
var
  arrCnd: TConsultasArray;
  qryPesquisa: TUniQuery;
begin
  inherited;
  If blnDevolu then
    If CondicaoPagamentoCliente.intQtdCndPag > 1 Then
      If mskCndPag.Enabled  Then
      Begin
        qryPesquisa := fCriaQuery;
        Try
          If fPesqCondicoesPgto(Self, nil, nil, qryPesquisa, Key, arrCnd, True, False,
                                IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conCndSimples),
                                0, 0, strCodFor, True) Then
          Begin
            CondicaoPagamentoCliente.pCarregaDados(strCodFor, qryPesquisa.FieldByName('CND_CNDPAG').AsString);
            If CondicaoPagamentoCliente.intQtdCndPag > 0 Then
            Begin
              edtCodPor.Text := CondicaoPagamentoCliente.strCodPor;
              fValidaCampos(edtCodPor);
              mskCndPag.Text := CondicaoPagamentoCliente.strCNDPAG;
            End;
          End;
        Finally
          FreeAndNil(qryPesquisa)
        End;
      End;
end;


procedure TfrmEntDadosCaixa2.pAtualizaICMSFrete(fltAlqIcm: Double);
  var qryComand : TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    If fltAlqIcm > -1 Then
    Begin
     qryComand.SQL.Add('UPDATE TMP_ENTMER SET ENT_ICMCFR = :ENT_ICMCFR');
     qryComand.ParamByName('ENT_ICMCFR').AsFloat := fltAlqIcm;
    End
    Else
     qryComand.SQL.Add('UPDATE TMP_ENTMER SET ENT_ICMCFR = ENT_ALQICM');
    qryComand.ExecSql;
  Finally
    FreeAndNil(qryComand);
  End;


end;
end.

