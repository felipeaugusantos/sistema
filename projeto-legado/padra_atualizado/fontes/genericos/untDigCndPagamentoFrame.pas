unit untDigCndPagamentoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Mask, MaskEditFocus, EditFocus,
  Vcl.ExtCtrls, Uni, untFuncFat, untLiberacao, strUtils, untTFuncoesPixAutcom,
  UniClientDataSet, untTlogLibRec, dxGDIPlusClasses;

type
  TfraDigCndPagamento = class(TFrame)
    pnlFundo: TPanel;
    pnlCndPag: TPanel;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    mskCndPag: TMaskEditFocus;
    pnlForPag: TPanel;
    Label2: TLabel;
    edtForPag: TEditFocus;
    edtDesForPag: TEditFocus;
    pnlDados: TPanel;
    Label1: TLabel;
    dbgDupAgru: TDBGridCitel;
    edtTotDup: TEditFocus;
    pnlChecks: TPanel;
    chkZerTax: TCheckBox;
    chkManPre: TCheckBox;
    pnlPrevisao: TPanel;
    lblPreVis: TLabel;
    mskPreVis: TMaskEditFocus;
    lblPagamentoPix: TLabel;
    chkCndPagTodos: TCheckBox;
    lblObs: TLabel;
    pnlTrocarCondPagamento: TPanel;
    lblTrocarCondPagamento: TLabel;
    imgAlerta: TImage;
    procedure OnFormCreate(Sender: TObject);
    function fConfirmaDados: Boolean;
    procedure OnFormShow(Sender: TObject);
    procedure pCarregaForPag;
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtForPagKeyPress(Sender: TObject; var Key: Char);
    procedure mskCndPagEnter(Sender: TObject);
    procedure mskCndPagKeyPress(Sender: TObject; var Key: Char);
    procedure mskCndPagKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskCndPagExit(Sender: TObject);
    procedure chkZerTaxClick(Sender: TObject);
    procedure chkManPreClick(Sender: TObject);
  strict private
    procedure pAtualizaMargemTotalDocumento;
  private
    { Private declarations }
    qryConCnd   : TUniQuery;
    strCndPagAnt: String;
    strAntCndPag: String;
    strFpgLib   : String;

    strConAux   : String;
    strCcnOrc   : String;
    strCodLib   : String;
    strCndLib   : String;
    strCodCndAnt: String;
    strSugCndCli: String; //Codigo cnd pgto sugestao no cadastro do cliente.
    objLiberacao : TLiberacao;

    FCondicaoPixLiberada: Boolean;
    FstrLinkPgtFormaEnvio: String;
    FstrLinkPgtDestinatario: String;
    FblnLinkPgtJaIndicado: Boolean;
    FstrEspDoc: String;

    procedure pAtribuiTabelas;
    procedure pMostraOpcZerarTaxJuros;
    function fUsaTipodeCliente: Boolean;
    function fUsaCndSeguro: Boolean;
    function fExisteCndPagCad: Boolean;
    function fMudouCliDoPedOrcComSugCndPagDiferente: Boolean;
    function fLiberouTrocaDaCondicaoSugerida(blnResult: Boolean): Boolean;
    function fDesconsiderarTipoDeClienteNoAgrupamento: Boolean;
    function fManterCondicaoDePagamentoDoClienteOriginal: Boolean;
    function fLiberarAgrupDupCtr(ADuplicatas: TUniClientDataSet): Boolean;
    function fExibeAlertaDeNaoUtilizacaoDeCredito(strCodCli: String): Boolean;

    procedure ValidacoesCondicaoPagamentoPix;
    procedure pAjustaPosicoesPnlChecks();
    function fValidaMargem: Boolean;
    function fFormasEnvioLinkPagamento(const AstrCodCnd: String; var AstrMsgOperador : String): Boolean ;
    procedure SetLinkPgtDestinatario(const Value: String);
    procedure SetLinkPgtFormaEnvio(const Value: String);
    function fCondicaoPagtoVinculadoAoCliente(ACodigoCliente: String): Boolean;
    function fVerificaVinculoCondicaoPagtoComPerfilCliente(ACodigoCliente: String): Boolean;
 public
    { Public declarations }
    blnAutSer: Boolean;
    qryConFpg: TUniQuery;
    qryCadCnd: TUniQuery;

    blnAutoHeight: Boolean;
    blnTamForm: Boolean;
    strCcnAnt : String;
    strCodCnd : String;
    strCndPag : String;
    strCodTpc : String;
    stlForPag : TStringList;
    stlCndPag : TStringList;
    blnConfirma: Boolean;
    blnPodeCancelar: Boolean;

    blnRcx_F3: Boolean;

    strCodCndAuxDv : String;
    strCodFpgAuxDv : String;

    blnHabZta: Boolean;
    blnHabMPr: Boolean;

    strCodVen: String;
    strCodDig: String;
    strNTrava: String;
    stlNumLib: TStringList;
    strCodCli,
    strNomCli: String;
    blnCnfDoc: Boolean;
    strCliAgr: String;

    blnIgnMar: Boolean;
    fltMarDoc: Double;
    fltValDoc: Double;
    strOpcDoc: String;

    fatVenda: TFatVenda;

    blnTravaNaoCompra: Boolean;
    strCndPedOrc: String; //Codigo condicao pgto pedido/orcamento carregado alimentado por fatvendas

    strCodigPagAoAbrir,
    strCondiPagAoAbrir,
    strFormaPagAoAbrir: String;
    blnTelaAgrupamento: Boolean;
    blnRecalculaPrecos : Boolean;
    blnEstaNaNovaTelaDeFechamento: Boolean;

    blnNenhumaCndPagEncontrada: Boolean;

    procedure pCarregaCondicao(blnMudou: Boolean = False);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
    procedure fExibeAlertaCondicaoNaoPermitida(strCodCli: String = '');

    procedure pConsultaAlpe;
    procedure pConsultaAlpeLimiteBoleto;

    function fVerificaSeAtualizaMargemTotalDocumento():Boolean;

    property LinkPgtFormaEnvio: String read FstrLinkPgtFormaEnvio write SetLinkPgtFormaEnvio;
    property LinkPgtDestinatario: String read FstrLinkPgtDestinatario write SetLinkPgtDestinatario;
    property LinkPgtJaIndicado: Boolean read FblnLinkPgtJaIndicado write FblnLinkPgtJaIndicado;
    property EspDoc: String read FstrEspDoc write FstrEspDoc;

  end;

implementation

uses untFuncoes, untfuncoesSimples,untPesqAux, untConsultas, untGravando,
     untConstantes, untFuncFatTypes, untFuncoesGenerica, untFatMostraObsCliente,
     untMsgLiberacao, untPai, untTypesSistema, untAlpeReceivablesSummaries,
     untTFuncoesAuxiliaresPix, untAlpePaymentProductsArrangements,
     untPgtOnlineUtil, untTPixDao;

{$R *.dfm}

{ TfraDigCndPagamento }

function TfraDigCndPagamento.fValidaMargem: Boolean;
Begin
 Result := False;

 If not Assigned(fatVenda) Then
   Exit;

 Result := fatVenda.fPermiteValidarMargemAndValorCodCnd() And
           (fCfgSis('USACND', VarBoolean)) And
           (fCfgSis('PFLCLI', VarBoolean)) And
           (fCfgSis('LIBCND') = '2')       And
           (qryConCnd.FindField('SUB_PERCND') <> Nil) and
           (not blnRcx_F3) And
           (fatVenda.fExecutarValidacaoMargemCondPagto_Documento) And
           (Not blnEstaNaNovaTelaDeFechamento) And
           (Not ((Pos(fatVenda.strOpcDoc, 'NE') > 0) And fatVenda.fDocumentoParaFornecedor));
End;

function TfraDigCndPagamento.fVerificaSeAtualizaMargemTotalDocumento: Boolean;
const
    str_EXIBIR_SOMENTE_CONDICOES_QUE_SATISFAZEM_REGRAS = '1';
begin
  Result := False;

  If (Assigned(fatVenda)) Then
  Begin
     If (fCfgSis('PFLCLI') = 'S') And
        (fCfgSis('LIBCND') = str_EXIBIR_SOMENTE_CONDICOES_QUE_SATISFAZEM_REGRAS) And
        (fCfgSis('CND_F3') = 'F') And
        (fatVenda.strOpcDocTrue = '11') Then
     begin
       Result := True;
     end;
  End;
end;

function TfraDigCndPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
 Var
   intIndReg: Integer;
   strMsgTmp: String;
   strAuxLibCnd: String;
   strAuxMrgMkp: String;
   strTpTrava: String;
   blnTravarMargemAvisarValor: Boolean;
   strSituacaoDocumento: String;
   strTipForCnd: String;
   blnAlterouPrevisao : Boolean;
   strTravaMargem: String;
   strTravaValor: String;
   strMsgOperadorLinkPgt: String;

begin
  Result := True;

  {*******************************************}
  {* VALIDA A DATA DE PREVISÃO DE ENTREGA    *}
  {****************************************BZ*}
  If (Sender = mskPreVis) And (pnlPrevisao.Visible) Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(mskPreVis.Text))) Then
    Begin
      fMensagem('ATENÇÃO!','A previsão deve ser preenchida!',['&OK']);
      Result := False;
    End
    Else If (StrToDateDef(mskPreVis.Text,0) < fatVenda.dtaGraPed) Then
    Begin
      fMensagem('ATENÇÃO!','A previsão deve ser maior ou igual a ' + DateToStr(fatVenda.dtaGraPed) + '!',['&OK']);
      Result := False;
    End
    Else
    Begin
      blnAlterouPrevisao := (fatVenda.dtaPreVis <> StrToDate(mskPreVis.Text));
      fatVenda.dtaPreVis := StrToDate(mskPreVis.Text);

      If edtCodCnd.Visible And (Not fEmptyStr(edtCodCnd.Text)) Then
      Begin
        strTipForCnd := fCampoTabela('CND_TIPFOR', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text], False);

        If ((Not SameText(strTipForCnd, 'OUTROS')) Or fEmptyStr(mskCndPag.Text) Or blnAlterouPrevisao) Then
        Begin
          pCarregaCondicao;
          fatVenda.strConPag := mskCndPag.Text;
        End;
      End;
    End;
  End

  {************************************}
  {* VALIDA A FORMA DE PAGAMENTO      *}
  {*********************************AF*}
  Else If (Sender = edtForPag) Then
  Begin

    If (fCfgSis('USAFPG', varBoolean)) And (pnlForPag.Visible) Then
    Begin

      If fEmptyStr(edtForPag.Text) Then
      Begin
        fMensagem('','O campo forma de pagamento deve ser preenchido!',['&OK']);
        Result := False;
      End
      Else If (Assigned(fatVenda)) And (Not fPermitirUsarFormaDePagamentoDinheiro(strOpcDoc, fatVenda.strEspDoc, edtForPag.Text)) Then
      begin
        Result := False;
      end
      Else if (strOpcDoc = 'CS') And (fStatusCndPag(mskCndPag.Text) = A_VISTA) And  MatchStr(edtForPag.text, ['006','007','013'])  then
      begin
        fMensagem('','A forma de pagamento deve ser dinheiro para o envio de mercadoria em consignação. '+
                     'Negociação do recebimento deve ser feita somente na rotina de faturamento!',['&OK']);
        Result := False;
      end
      Else If fRetornaStatusCadastro(edtForPag.Text, 'FPG', 'CADFPG', 'FPG_CODIGO') <> 'A' Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta forma de pagamento não pode ser utilizada pois está inativa!', ['&O k']);
        Result := False;
      End
      Else If Assigned(fatVenda) And ((Not fatVenda.fBaixaDuplicataAVista) And (edtForPag.Text = '009')) And
              (Pos(fatVenda.strOpcDoc, 'OR_PD_') <= 0) And
              (Not fatVenda.fPermiteFpgParceladoCI(edtForPag.Text))  Then
      Begin
        fMensagem('ATENÇÃO!', 'Sistema configurado para não baixar duplicatas à vista '+ #13#10 +
                              'não permite forma de pagamento "Parcelado"!', ['&Ok']);
        Result := False;
      End
//        Else If fCfgSis('TFPF11', varBoolean) And (edtForPag.Text = '009') And (fatVenda.blnEnt_CD) Then
//        Begin
//          fMensagem('ATENÇÃO!', 'Sistema configurado para travar no F11 a forma de pagamento negociada, '+ #13#10 +
//                                'portanto não é permitido forma de pagamento "Parcelado" para entregas pelo CD!', ['&Ok']);
//          Result := False;
//        End
      Else
      Begin
        pCarregaForPag;
        If ( Not qryConFpg.IsEmpty ) Then
        Begin

          stlForPag.Clear;
          stlCndPag.Clear;

          If fUsaTipodeCliente And (Not fDesconsiderarTipoDeClienteNoAgrupamento) Then
            pCarregaFormasPagto(strCodCli, stlForPag, stlCndPag);

          If (Assigned(fatVenda)) And (fatVenda.strOpcDoc = 'CI') And (edtForPag.Text = '013') And
             (Not fCadRecCIQuitado(fatVenda.strTabelaConfMi, strMsgTmp)) Then
          Begin
            pMsgTravaConfCupomUtilizacaoCredito(strMsgTmp);
            Result := False;
          End;

          If ((blnCnfDoc) And (edtForPag.Text = '013') And (Assigned(fatVenda)) And (Not (fatVenda.strOpcDoc = 'CI'))) Then
          Begin
            fMensagem('ATENÇÃO!','Essa forma de pagamento não é permitida para confirmação de documentos', ['&O k']);
            Result := False;
          End

          Else If (stlForPag.Count > 0) And (stlForPag.IndexOf(edtForPag.Text) < 0) And
                  (Not SameText(strFpgLib, edtForPag.Text)) And
                  (  fEmptyStr(strCodFpgAuxDv) Or ( (Not fEmptyStr(strCodFpgAuxDv)) And (edtForPag.Text<>strCodFpgAuxDv) )  ) Then
          Begin
            objLiberacao.Clear;
            pMsgFormasPagtoPermitidasCliente(edtForPag.Text, stlForPag, objLiberacao.objMsgLibera);

            If fCfgSis('FPGCLI', varBoolean) Then
            Begin
              objLiberacao.strDirAce := 'FPGSEN';
              objLiberacao.strSenLib := fCfgSis('FPGSEN');
              objLiberacao.strMsgSen := 'Forma pagamento não permitida';
              objLiberacao.strCodOpe := strCodVen;
              objLiberacao.strCodDig := strCodDig;
              objLiberacao.strCliente := strCodCli + '-' + strNomCli;
              objLiberacao.strCpfCnpj := fRetCgcCpf(strCodCli);
              If Assigned(fatVenda) Then
                objLiberacao.strSequencialUnicoDtaHra := fatVenda.FSequencialUnicoDtaHrLogVar;
              if Assigned(fatVenda) then
                objLiberacao.fltValorVenda := fatVenda.fltTotGer
              else
                objLiberacao.fltValorVenda := 0.0;
              Result := fMensagemLiberacao(objLiberacao, strNTrava, stlNumLib);

              If Result Then
                strFpgLib := edtForPag.Text
              Else
                strFpgLib := '';

            End
            Else
              REsult := False;

          End;

          If ( SameText(edtForPag.Text, '008')  ) And
             ( MidStr(strCndPag, 1, 2) <>  '01' ) And
             ( MidStr(strCndPag, 3, 3) =  '000' ) And
             ( MidStr(strCndPag, 6, 3) <> '000' ) And
             ( Assigned(fatVenda)               ) And
             ( fatVenda.fBaixaDuplicataAVista   ) Then
          Begin
            fMensagem('','Quando for parcelado e a primeira parcela for a vista, a forma de pagamento deve ser parcelada (009)!',['&OK']);
            Result := False;
          End;

        End
        Else
        Begin
          fMensagem('','Forma de pagamento não encontrada!',['&OK']);
          Result := False;
        End;
      End;

      If Result And SameText(edtForPag.Text, '016') And
         (fStatusCndPag(mskCndPag.Text) <> A_VISTA) Then
      Begin
        fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
        Result := False;
      End;

      If (Assigned(fatVenda)) And (Result) And (fatVenda.strOpcDoc = 'PA') And
         (fStatusCndPag(mskCndPag.Text) <> A_VISTA) Then
      Begin
        fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
        Result := False;
      End;

      If Result And (Pos(edtForPag.Text,'008_010_') > 0) Then
      Begin
        If fStatusCndPag(mskCndPag.Text) = A_VISTA Then
        Begin
          fMensagem('','A condição de pagamento não pode ser a vista!',['&OK']);
          Result := False;
        End;
      End;

{       If Assigned(fatVenda) And Result And
         SameText(edtForPag.Text, '016') And (Pos(fatVenda.strOpcDoc, 'PD_OR_') > 0) Then
      Begin
        If fatVenda.fTemItensEntregaImediata(fatVenda.arrMatItens) And (fCfgSis('NPDF11', varBoolean)) Then
        Begin
          pMensagemOk('Forma de pagamento não permitido para documento que ' +
                      'possui itens de entrega imediata, pois o sistema esta ' +
                      'configurado para gerar um novo pedido de venda!');
          Result := False;
        End
        Else If fatVenda.fTemItensRetira(fatVenda.arrMatItens, opOutraEmpresa) And (fCfgSis('NPRF11', varBoolean)) Then
        Begin
          pMensagemOk('Forma de pagamento não permitido para documento que ' +
                      'possui itens de retira de outra loja, pois o sistema esta ' +
                      'configurado para gerar um novo pedido de venda!');
          Result := False;
        End
        Else If fatVenda.fTemItensRetira(fatVenda.arrMatItens, opTodasEmpresas, opLocalRetiraExpedicao) And (fCfgSis('LOCRET', varBoolean)) Then
        Begin
          pMensagemOk('Forma de pagamento não permitido para documento que ' +
                      'possui itens de retira expedição, pois o sistema ' +
                      'irá gerar um novo pedido de venda!');
          Result := False;
        End
        Else If fatVenda.fTemItensEmpresaCD(fatVenda.arrMatItens) And (fCfgSis('ENT_CD', varBoolean)) Then
        Begin
          pMensagemOk('Forma de pagamento não permitido para documento que ' +
                      'possui itens para faturamento em outra empresa, pois o ' +
                      'sistema irá gerar um novo pedido de venda para a empresa!');
          Result := False;
        End;
      End;}

    End;

  End

  Else If (Sender = mskCndPag) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If ((Assigned(fatVenda))          And
             (((fTiraCaracEspeciais(strCndLib, True, True, True)    <> fTiraCaracEspeciais(mskCndPag.Text, True, True, True))                                    And
               (fTiraCaracEspeciais(strAntCndPag, True, True, True) <> fTiraCaracEspeciais(mskCndPag.Text, True, True, True))) Or (strCodLib <> edtCodCnd.Text)) And
               (fTravarCondicaoPagamento(edtCodCnd.Text, mskCndPag.Text, fatVenda.strCodCli, fatVenda.strCodVen, fatVenda.strCodDig, fatVenda.strNTrava, '', fatVenda.stlNumLib, cdsVenda, fatVenda))) Or
            ((Not Assigned(fatVenda))                                                                                                                            And
             (((fTiraCaracEspeciais(strCndLib, True, True, True) <> fTiraCaracEspeciais(mskCndPag.Text, True, True, True))                                       And
               (fTiraCaracEspeciais(strAntCndPag, True, True, True) <> fTiraCaracEspeciais(mskCndPag.Text, True, True, True))) Or (strCodLib <> edtCodCnd.Text)) And
               (fTravarCondicaoPagamento(edtCodCnd.Text, mskCndPag.Text, strCliAgr, strLoginUsuarioLogado, strLoginUsuarioLogado, '', '', Nil, cdsVenda, fatVenda)))          Then
    Begin
      Result := False;
    End

    Else
    Begin
      strCodLib := edtCodCnd.Text;
      strCndLib := fTiraCaracEspeciais(mskCndPag.Text, True, True, True);

      If (Result) and (fCfgSis('CNDPES', VarBoolean)) Then
      Begin
        {SE A CONDIÇÃO ATUAL FOR "ESPECIAL", CHECAR A LISTA DE PRODUTOS JÁ INSERIDOS - KM}
        if (Assigned(fatVenda)) Then
        Begin
          fatVenda.strCodCnd := edtCodCnd.Text;
          fatVenda.blnCndEsp := (fRetEspConPag(edtCodCnd.Text) = 'S');
          blnRecalculaPrecos := False;
          if (fatVenda.blnCndEsp) then
          Begin
            if fatVenda.fProdutoForaCondEsp(fatVenda.strCodCnd) then
            Begin
              fMensagem('ATENÇÃO!','Essa condição de pagamento não poderá ser utilizada pois existem produtos não permitidos! ' +
                          'Favor verificar e excluir os itens fora da política de parcelamento.', ['&Ok']);
              Result := False;
            End
            else {TODOS OS PRODUTOS PERTENCEM A CONDIÇÃO ESPECIAL, ENTÃO RECALCULA PREÇOS}
            Begin
              If (edtCodCnd.Text <> strCcnAnt) Then
                fMensagem('ATENÇÃO!', 'Foi escolhida uma condição de pagamento especial e os produtos terão seus preços de tabela definidos!', ['&Ok']);

              blnRecalculaPrecos := True;
            End;
          End;
        End;
      End;


      {**********************************************}
      {* NÃO PERMITE VENDA A PRAZO PARA CONSIGNAÇÃO *}
      {*******************************************MM*}
      If Assigned(fatVenda) Then
      Begin
        If (fatVenda.StrOpcDoc = 'CS') And (fStatusCndPag(mskCndPag.Text) = A_PRAZO) Then
        Begin
          fMensagem('','A condição de pagamento não pode ser a prazo para envio de mercadoria em consignação!',['&OK']);
          Result := False;
        End;
      End;

      If (Assigned(fatVenda)) And (Result) And (fatVenda.strOpcDoc = 'PA') And
         (fStatusCndPag(mskCndPag.Text) <> A_VISTA) Then
      Begin
        fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
        Result := False;
      End;

      If Result And (Assigned(fatVenda)) And fatVenda.fEhConsertoEquipamento And (fStatusCndPag(mskCndPag.Text) = A_PRAZO) Then
      Begin
        fMensagem('','A condição de pagamento deve ser a vista para nota de conserto de equipamento!',['&OK']);
        Result := False;
      End;

      If Result And (Not fVerificaVinculoCondicaoPagtoComPerfilCliente(strCodCli)) Then
      Begin
        fMensagem('ATENÇÃO', 'A condição de pagamento selecionada não está vinculada ao cadastro do cliente.', ['&OK']);
        Result := False;
      End;

      If Assigned(fatVenda) And fUsaCndSeguro Then
      Begin
        If Not fValidaCndPag(mskCndPag.Text, strCndPag, VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
          Result := False;
        End

        Else
        Begin
          mskCndPag.Text := strCndPag;
          Result := fatVenda.fCondicaoPagtoClienteOk(mskCndPag.Text);

          fatVenda.blnCndTravaCli := (fRetTraCliConPag(edtCodCnd.Text) = 'S');
          fatVenda.strConPag := strCndPag;

          If Result                                  And
             (Not SameText(strCndPagAnt, strCndPag)) Then
          Begin
            If fatVenda.fAcionarTravaVendasMaximoDiasNaoCompra(fatVenda.blnCndTravaCli, fStatusCndPag(fatVenda.strConPag), False) Then
              pRemoverTravaLogAvi('COMPR', fatVenda.strNTrava);

            blnTravaNaoCompra := False;
          End;

          If fatVenda.fAcionarTravaVendasMaximoDiasNaoCompra(fatVenda.blnCndTravaCli, fStatusCndPag(fatVenda.strConPag), True) Then
          Begin
            If Result                    And
               (fCfgSis('CNDVEN') = 'F') Then
            Begin
              If (Pos(fatVenda.strOpcDoc, 'VN_PD_OR_') > 0)                               And
                 (Not blnTravaNaoCompra)                                                  And
                 (Not fatVenda.fVerificaNaoCompra(blnTravaNaoCompra, fatVenda.strCodVen)) Then
                Result := False;
            End;
          End;

          If Result Then
          Begin
            strCndPagAnt   := fTiraCaracEspeciais(mskCndPag.Text);
            pMostraOpcZerarTaxJuros;
          End;
        End;
      End

      Else
      Begin
        {**************************************}
        { SE FOR AVISTA, MOSTRA OPCAO DE ZERAR }
        { TAXA DE JUROS                        }
        {***********************************JB*}
        pMostraOpcZerarTaxJuros;

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

          stlForPag.Clear;
          stlCndPag.Clear;

          If fUsaTipodeCliente And (Not fDesconsiderarTipoDeClienteNoAgrupamento) Then
            pCarregaFormasPagto(strCodCli, stlForPag, stlCndPag);

          If (copy(mskCndPag.Text, 1, 1) = 'F') Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
            Result := False;
          End

          Else If (fCfgSis('USACND') <> 'S') And
                  (stlCndPag.Count > 0)      And
                  (Not stlCndPag.Find(mskCndPag.Text, intIndReg)) Then
          Begin
            If ((fCfgSis('IGNTPC') = 'N') and (blnTelaAgrupamento)) Then
            Begin
              pMsgCondicoesPagtoPermitidasCliente(mskCndPag.Text, stlCndPag);
              Result := False;
            End;
          End

          Else
          If (Result) Then
          Begin
            If (Pos(strOpcDoc, 'VN_PD_OR_') > 0) Then
              Result := fValidaCndPag(mskCndPag.Text, strCndPag, VS_Date, False, strCodCli)
            Else
              Result := fValidaCndPag(mskCndPag.Text, strCndPag, VS_Date);

            If Not Result Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
            End
            Else
            Begin
              If fEmptyStr(strCndPag) Then
                Result := False
              Else
              Begin
                {*****************************************}
                {* SE ESTIVER UTILIZANDO TIPO DE CLIENTE *}
                {**************************************AF*}
                If fUsaTipodeCliente Then
                Begin
                  {******************************************}
                  {* SE FOR 022 OU 023 VENDA APENAS A VISTA *}
                  {***************************************AF*}
                  If Pos(strCodTpc, '022_023_') > 0 Then
                  Begin
                    If fStatusCndPag(strCndPag) <> A_VISTA Then
                    Begin
                      fMensagem('','A condição de pagamento deve ser a vista!',['&OK']);
                      Result := False;
                    End;
                  End;
                End;

                If Result                                  And
                   (Not SameText(strCndPagAnt, strCndPag)) And
                   (Assigned(fatVenda))                    Then
                Begin
                  fatVenda.blnCndTravaCli := (fRetTraCliConPag(edtCodCnd.Text) = 'S');

                  If fatVenda.fAcionarTravaVendasMaximoDiasNaoCompra(fatVenda.blnCndTravaCli, fStatusCndPag(fatVenda.strConPag), False) Then
                    pRemoverTravaLogAvi('COMPR', fatVenda.strNTrava);

                  blnTravaNaoCompra := False;
                End;

                If Assigned(fatVenda) And fatVenda.fAcionarTravaVendasMaximoDiasNaoCompra(fatVenda.blnCndTravaCli, fStatusCndPag(fatVenda.strConPag), True) Then
                Begin
                  If Result                    And
                     (fCfgSis('CNDVEN') = 'F') Then
                  Begin
                    If (Pos(fatVenda.strOpcDoc, 'VN_PD_OR_') > 0)                               And
                       (Not blnTravaNaoCompra)                                                  And
                       (Not fatVenda.fVerificaNaoCompra(blnTravaNaoCompra, fatVenda.strCodVen)) Then
                      Result := False;
                  End;
                End;

                If Result And Assigned(fatVenda) And (fCfgSis('USACND') = 'S') And (strCndPagAnt <> mskCndPag.Text) And ( (qryConCnd.FieldByName('CND_PARMIN').AsFloat > 0) Or (qryConCnd.FieldByName('CND_PARMAX').AsFloat > 0) ) Then
                Begin
                  fatVenda.strConPag := mskCndPag.Text;
                  fatVenda.strCodCnd := edtCodCnd.Text;
                  fatVenda.strCodFpg := edtForPag.Text;

                  If Not fatVenda.fVerificaCondPagtoParcelaMinima(qryConCnd.FieldByName('CND_PARMIN').AsFloat,
                                                                  qryConCnd.FieldByName('CND_PARMAX').AsFloat,
                                                                  qryConCnd.FieldByName('CND_TRAPAR').AsString,
                                                                  qryConCnd.FieldByName('CND_CODIGO').AsString) Then
                  Begin
                    If Not fEmptyStr(strCcnAnt) Then
                    Begin
                      edtCodCnd.Text := strCcnAnt;
                      pCarregaCondicao(True);
                    End;

                    Result := False;
                  End;
                End;

                If Result Then
                Begin
                  mskCndPag.Text := strCndPag;
                  strCndPagAnt   := fTiraCaracEspeciais(mskCndPag.Text);
                  pMostraOpcZerarTaxJuros;
                End;
              End;
            End;
          End;
        End;
      End;
    End;
  End
  Else

  If (Sender = edtCodCnd)  And (edtCodCnd.Visible) Then
  Begin

    If fEmptyStr(edtCodCnd.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A condição deve ser preenchida!', ['&O k']);
      Result := False;
    End;

    If Assigned(fatVenda) And (fCfgSis('TRVMKP') = 'I') Then
    Begin
      If (strCcnAnt <> edtCodCnd.Text) Then
        fatVenda.blnTrocouCndPagtoIni := True;
    End;

    If (fatVenda <> Nil) And (fatVenda.blnMeiaNota) and (fatVenda.strOpcDoc = 'CF') Then
    begin
      fltMarDoc := 0 ;
      fltValDoc := 0 ;
    End;

    If  (Result) And
            (Assigned(fatVenda)) And
            (  fEmptyStr(strCodCndAuxDv) Or ( (Not fEmptyStr(strCodCndAuxDv)) And (edtCodCnd.Text<>strCodCndAuxDv) )  ) And
            (Not fatVenda.fCondicaoPagtoClienteOk(edtCodCnd.Text)) Then
    Begin
      Result := False;
    End

    Else If Result And (Assigned(fatVenda)) And (Not fPermiteUtilizarEstaCondPagamento(edtCodCnd.Text, fatVenda.fUtilizarDataEmissaoCalcularDiaVencimento)) Then
    Begin
      Result := False;
    End;

    If (Result) And fExisteCndPagCad And (fCfgSis('CNDPES', VarBoolean)) Then
    Begin
      {SE A CONDIÇÃO ATUAL FOR "ESPECIAL", CHECAR A LISTA DE PRODUTOS JÁ INSERIDOS - KM}
      If (Assigned(fatVenda)) Then
      Begin
        fatVenda.blnCndEsp := (fRetEspConPag(edtCodCnd.Text) = 'S');
        If (fatVenda.blnCndEsp) Then
        Begin
          If ((not blnRcx_F3) And (fCfgSis('CNDVEN') = 'F')) And
             ((fatVenda.fltDesEsp > 0) Or (fatVenda.fltPorDes > 0)) Then
          Begin
            fMensagem('ATENÇÃO!','Não é permitido utilizar condição de pagamento especial quando foi aplicado desconto na venda!', ['&Ok']);
            Result := False;
          End
          Else If fatVenda.fProdutoForaCondEsp(edtCodCnd.Text) Then
          Begin
            fMensagem('ATENÇÃO!','Essa condição de pagamento não poderá ser utilizada pois existem produtos não permitidos! ' +
                        'Favor verificar e excluir os itens fora da política de parcelamento.', ['&Ok']);
            Result := False;
          End
          Else {TODOS OS PRODUTOS PERTENCEM A CONDIÇÃO ESPECIAL, ENTÃO RECALCULA PREÇOS}
          Begin
            If (edtCodCnd.Text <> strCcnAnt) Then
              fMensagem('ATENÇÃO!', 'Foi escolhida uma condição de pagamento especial e os produtos terão seus preços de tabela definidos!', ['&Ok']);
          End;
        End;
      End;
    End;

    If (Result) And (Not fEmptyStr(edtCodCnd.Text)) And (fExisteCndPagCad) Then
    Begin
      If (Not fEmpresaTemAcessoCondicaoPagto(edtCodCnd.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar a condição: '+edtCodCnd.Text+'. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
        Result := False;
      End;
    End;

    // se tiver link de pagamento, mostra a janela com as formas de envio
    if (Result) and ((not FblnLinkPgtJaIndicado) or (edtCodCnd.Text <> strCcnAnt)) and (not fFormasEnvioLinkPagamento(edtCodCnd.Text, strMsgOperadorLinkPgt)) then
    begin
      fMensagem('ATENÇÃO!', ifThen(fEmptyStr(strMsgOperadorLinkPgt),'Para usar uma condição de pagamento de link de pagamento é necessário escolher uma forma de envio do Link!', strMsgOperadorLinkPgt) , ['&O k']);
      Result := False;
      edtCodCnd.Text := strCcnAnt;
      pCarregaCondicao(True);
    end ;
    //
    If Result And (Not fVerificaVinculoCondicaoPagtoComPerfilCliente(strCodCli)) Then
    Begin
      fMensagem('ATENÇÃO', 'A condição de pagamento selecionada não está vinculada ao cadastro do cliente.', ['&OK']);
      Result := False;
    End;

    If (Result) And ( edtCodCnd.Text <> strCcnAnt ) Or ( (Not fEmptyStr(strCodCndAuxDv)) And (edtCodCnd.Text<>strCodCndAuxDv) ) Then
    Begin
      pCarregaCondicao(True);
      stlForPag.Clear;
      stlCndPag.Clear;

      If fUsaTipodeCliente And (Not fDesconsiderarTipoDeClienteNoAgrupamento) Then
        pCarregaFormasPagto(strCodCli, stlForPag, stlCndPag);

      If qryConCnd.FieldByName('CND_CODIGO').IsNull Then
      Begin
        blnNenhumaCndPagEncontrada := fVerificaSeAtualizaMargemTotalDocumento();
        fExibeAlertaCondicaoNaoPermitida(strCodCli);
        Result := False;
      End
      Else If (Not fEmpresaTemAcessoCondicaoPagto(qryConCnd.FieldByName('CND_CODIGO').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar a condição: '+edtCodCnd.Text+'. Verifique o Cadastro de Condições de Pagamento - Aba "Empresas Acesso".' , ['&O k']);
        Result := False;

        If Not fEmptyStr(strCcnAnt) Then
        Begin
          edtCodCnd.Text := strCcnAnt;
          pCarregaCondicao(True);
        End;

      End

      Else If blnRcx_F3 And (qryConCnd.FieldByName('CND_RCX_F3').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta condição de pagamento não é permitida no F3 (checkout) do caixa!' , ['&O k']);
        Result := False;
      End

      Else If Result And fValidaMargem Then
      Begin
        //1 MARGEM E VALOR FORA DO INTERVALO
        //2 MARGEM FORA DO INTERVALO
        //3 VALOR FORA DO INTERVALO
        strSituacaoDocumento := qryConCnd.FieldByName('SUB_PERCND').AsString;

        blnTravarMargemAvisarValor := False;

        If ((fatVenda.strOpcDoc = 'OR') And (Not fatVenda.fOrcamentoComoPedido)) Then
        Begin
          strTpTrava := fatVenda.fRetornaTipoTravaSeOrcamentoComPerfilCondicao('CND_TRORFI', edtCodCnd.Text);
          If (Pos(strSituacaoDocumento, '1_3_') > 0) Then
          Begin
            If (strSituacaoDocumento = '1') Then //MARGEM E VALOR FORA DO INTERVALO
            Begin
              If Pos(strTpTrava, 'A_N_') > 0 Then //"OR" CONFIGURADO PARA APENAS AVSAR OU NÃO EXIBIDA NADA
              Begin
                strSituacaoDocumento := '2'; //SÓ MOSTRA A MARGEM;
                blnTravarMargemAvisarValor := (strTpTrava = 'A') //"OR" CONFIGURADO PARA APENAS AVSAR
              End;

              strTpTrava := 'T';
            End
            Else If (strSituacaoDocumento = '3') Then //VALOR FORA DO INTERVALO
            Begin
              If (strTpTrava = 'N') Then
                strSituacaoDocumento := '0'; //NÃO EXIBE NADA
            End;
          End;
        End
        Else
        Begin
          strTravaMargem := fRetornaTravaPerfilCondicao('CND_TRAMAR', edtCodCnd.Text);
          strTravaValor  := fRetornaTravaPerfilCondicao('CND_TRAFAT', edtCodCnd.Text);

          If (strSituacaoDocumento = '1') Then
          Begin
            strTpTrava := IIF(((strTravaMargem = 'N') Or (strTravaValor = 'N')), 'N', 'S');
          End
          Else If (strSituacaoDocumento = '2') Then
          Begin
            strTpTrava := strTravaMargem;
          End
          Else If (strSituacaoDocumento = '3') Then
          Begin
            strTpTrava := strTravaValor;
          End;
        End;

        If strSituacaoDocumento <> '0' Then
        Begin
          strAuxMrgMkp := IIF(fMargem_ou_Markup='MARGEM','Margem','Markup');

          objLiberacao.Clear;
          If strSituacaoDocumento = '1' Then
          Begin
            objLiberacao.strDirAceAuxiliar := 'INTFAT'+qryConCnd.FieldByName('CND_CODIGO').AsString+fltValDoc.ToString()+' '+
                                              'INTMAR'+qryConCnd.FieldByName('CND_CODIGO').AsString+fltMarDoc.ToString();
            strAuxLibCnd := 'Valor do documento e '+IIF(fMargem_ou_Markup='MARGEM','margem','markup')+' fora do intervalo permitido conforme perfil da condição de pagamento'
          End
          Else If strSituacaoDocumento = '2' Then
          Begin
            objLiberacao.strDirAceAuxiliar := 'INTMAR'+qryConCnd.FieldByName('CND_CODIGO').AsString+fltMarDoc.ToString();
            strAuxLibCnd := strAuxMrgMkp+' do documento fora do intervalo permitido conforme perfil da condição de pagamento'
          End
          Else If strSituacaoDocumento = '3' Then
          Begin
            objLiberacao.strDirAceAuxiliar := 'INTFAT'+qryConCnd.FieldByName('CND_CODIGO').AsString+fltValDoc.ToString();
            strAuxLibCnd := 'Valor do documento fora do intervalo permitido conforme perfil da condição de pagamento';
          End;

          pRemoverTravaLogAviAux('LIBSEN');
          pRemoverTravaLogAviAux('INTFAT');
          pRemoverTravaLogAviAux('INTMAR');

          objLiberacao.objMsgLibera.pAddTexto(strAuxLibCnd);

          objLiberacao.objMsgLibera.pAddSeparador(100);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'   , Copy(fatVenda.strCodCli + '-' + fRetNomCliente(fatVenda.strCodCli), 1, 57), 10);
          objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'  , fFormataCpfCgc(fatVenda.strCliCgc, fSetaPais)                             , 10);
          objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'  , Copy(fatVenda.strCodVen + '-' + fRetNomVendRep(fatVenda.strCodVen), 1, 57), 10);
          objLiberacao.objMsgLibera.pAddSeparador(100);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cond.Pagto', edtCodCnd.Text + '-' + fRetDesConPag(edtCodCnd.Text)                      , 10);
          objLiberacao.objMsgLibera.pAddTextoCaption('          ', fFormataCondPag(qryConCnd.FieldByName('CND_CNDPAG').AsString)             , 10);
          objLiberacao.objMsgLibera.pAddSeparador(100);
          If (Pos(strSituacaoDocumento, '1_3_') > 0) Or (blnTravarMargemAvisarValor) Then
          Begin
            objLiberacao.objMsgLibera.pAddTextoCaption('Faturamento Mínimo Permitido' , FormatFloat('#,##0.00', qryConCnd.FieldByName('CND_FATMIN').AsFloat), 28, alCentro, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption('Faturamento Máximo Permitido' , FormatFloat('#,##0.00', qryConCnd.FieldByName('CND_FATMAX').AsFloat), 28, alCentro, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption('Faturamento deste documento'  , FormatFloat('#,##0.00', fltValDoc)                                  , 28, alCentro, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddSeparador(100);
          End;
          If (Pos(strSituacaoDocumento, '1_2_') > 0) Then
          Begin
            objLiberacao.objMsgLibera.pAddTextoCaption(strAuxMrgMkp+' Mínima Permitido'      , FormatFloat('#,##0.00', qryConCnd.FieldByName('CND_MARMIN').AsFloat), 28, alCentro, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption(strAuxMrgMkp+' Máxima Permitido'      , FormatFloat('#,##0.00', qryConCnd.FieldByName('CND_MARMAX').AsFloat), 28, alCentro, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddTextoCaption(strAuxMrgMkp+' deste documento'       , FormatFloat('#,##0.00', fltMarDoc)                                  , 28, alCentro, teAmbos, '', 15);
            objLiberacao.objMsgLibera.pAddSeparador(100);
          End;
          If blnTravarMargemAvisarValor Then
          Begin
            objLiberacao.objMsgLibera.pAddTexto('');
            objLiberacao.objMsgLibera.pAddSeparador(100);
            objLiberacao.objMsgLibera.pAddTexto('OBS.: A indicação de "Faturamento" fora do intervalo "Mínimo/Máximo" permitido é apenas um AVISO');
            objLiberacao.objMsgLibera.pAddTexto('      conforme definido no cadastro da condição de pagamento!');
            objLiberacao.objMsgLibera.pAddSeparador(100);
          End;

          If ((fatVenda.strOpcDoc = 'OR') And (Not fatVenda.fOrcamentoComoPedido)) Then
          Begin
            objLiberacao.strDirAce := 'LIBSEN';
            objLiberacao.strSenLib := fCfgSis('LIBSEN');
            objLiberacao.strMsgSen := strAuxLibCnd;
            objLiberacao.strCodOpe := fatVenda.strCodVen;
            objLiberacao.strCodDig := fatVenda.strCodDig;
            objLiberacao.blnTraTel := (strTpTrava = 'T');

            Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
          End
          Else
          Begin
            If (strTpTrava = 'S') Then
            Begin
              objLiberacao.strDirAce := 'LIBSEN';
              objLiberacao.strSenLib := fCfgSis('LIBSEN');
              objLiberacao.strMsgSen := strAuxLibCnd;
              objLiberacao.strCodOpe := fatVenda.strCodVen;
              objLiberacao.strCodDig := fatVenda.strCodDig;
              objLiberacao.blnTraTel := True;

              Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
            End
            Else
            Begin
              objLiberacao.strDirAce := 'NENHUM';
              objLiberacao.blnTraTel := False;

              fatVenda.fFatMensagemLiberacao(objLiberacao);

              Result := False;
            End;
          End;

          If (Not Result) And (Not fEmptyStr(strCcnAnt)) Then
          Begin
            edtCodCnd.Text := strCcnAnt;
            pCarregaCondicao(True);
          End;
        End;
      End
      Else If Result And (Assigned(fatVenda)) And fatVenda.fEhConsertoEquipamento And (fStatusCndPag(mskCndPag.Text) = A_PRAZO) Then
      Begin
        fMensagem('','A condição de pagamento deve ser a vista para nota de conserto de equipamento!',['&OK']);
        Result := False;

        If Not fEmptyStr(strCcnAnt) Then
        Begin
          edtCodCnd.Text := strCcnAnt;
          pCarregaCondicao(True);
        End;
      End
      Else If ((Assigned(fatVenda))          And
               (strCodLib <> edtCodCnd.Text) And
               (fTravarCondicaoPagamento(edtCodCnd.Text, mskCndPag.Text, fatVenda.strCodCli, fatVenda.strCodVen, fatVenda.strCodDig, fatVenda.strNTrava, '', fatVenda.stlNumLib, cdsVenda, fatVenda))) Or
              ((Not Assigned(fatVenda))      And
               (strCodLib <> edtCodCnd.Text) And
               (fTravarCondicaoPagamento(edtCodCnd.Text, mskCndPag.Text, strCliAgr, strLoginUsuarioLogado, strLoginUsuarioLogado, '', '', Nil, cdsVenda, fatVenda))) Then
      Begin
        Result      := False;
        strCndLib   := fTiraCaracEspeciais(mskCndPag.Text, True, True, True);
      End
      Else
      Begin
        strCodLib := edtCodCnd.Text;
        strCndLib := fTiraCaracEspeciais(mskCndPag.Text, True, True, True);
      End;

      If (blnTelaAgrupamento) then
      Begin
        Result := CalculaPrazoMedioCondicaoPagamento(strCndLib, 0, 0, blnTelaAgrupamento);
        If Not Result then
          Result := fLiberarAgrupDupCtr((dbgDupAgru.DataSource.DataSet as TUniClientDataSet));
      End;

      If (Result)                      And
         (Not fEmptyStr(strCcnAnt))    And
         Assigned(fatVenda)            And
         (edtCodCnd.Text <> strCcnAnt) Then
      Begin
        fatVenda.blnCndTravaCli := (fRetTraCliConPag(edtCodCnd.Text) = 'S');

        If fatVenda.fAcionarTravaVendasMaximoDiasNaoCompra(fatVenda.blnCndTravaCli, fStatusCndPag(fatVenda.strConPag), False) Then
        Begin
          pRemoverTravaLogAvi('COMPR', fatVenda.strNTrava)
        End
        Else If (fCfgSis('PFLCLI', varBoolean)) Then
        Begin
          If (fRetTraCliConPag(strCcnAnt) = 'S') Then
            pRemoverTravaLogAvi('COMPR', fatVenda.strNTrava);
        End;

        blnTravaNaoCompra := False;
      End;

      {**********************************************}
      {* NÃO PERMITE VENDA A PRAZO PARA CONSIGNAÇÃO *}
      {*******************************************MM*}
      If Result And Assigned(fatVenda) Then
      Begin
        If (fatVenda.StrOpcDoc = 'CS') And
           (fStatusCndPag(mskCndPag.Text) = A_PRAZO) Then
        Begin
          fMensagem('','A condição de pagamento não pode ser a prazo para envio de mercadoria em consignação!',['&OK']);
          Result := False;
        End;
      End;

      {*********************************}
      {*TRAVA DE ALTERAÇÃO DE CND PGTO.*}
      {50660**************************LE}
      If (Result) And (Assigned(fatVenda)) Then
      Begin
        Result := fLiberouTrocaDaCondicaoSugerida(Result);

        {Req.: 110336 - Correção - Não estava retornando a condição no ESC da senha.}
        If Not Result Then
        begin
          edtCodCnd.Text := strCcnAnt;
          pCarregaCondicao;
        End;

      End;

      If Result And Assigned(fatVenda) And (fCfgSis('USACND') = 'S') And
         (Not blnEstaNaNovaTelaDeFechamento) And
         ((qryConCnd.FieldByName('CND_PARMIN').AsFloat > 0) Or (qryConCnd.FieldByName('CND_PARMAX').AsFloat > 0)) Then
      Begin
        fatVenda.strConPag := mskCndPag.Text;
        fatVenda.strCodCnd := edtCodCnd.Text;
        fatVenda.strCodFpg := edtForPag.Text;
        if (blnRcx_F3) and (fEmptyStr(fatVenda.strNumOrc)) then
        begin
          fatVenda.strConPagOri := fatVenda.strConPag ;
        end ;

        If Not fatVenda.fVerificaCondPagtoParcelaMinima(qryConCnd.FieldByName('CND_PARMIN').AsFloat,
                                                        qryConCnd.FieldByName('CND_PARMAX').AsFloat,
                                                        qryConCnd.FieldByName('CND_TRAPAR').AsString,
                                                        qryConCnd.FieldByName('CND_CODIGO').AsString) Then
        Begin
          If Not fEmptyStr(strCcnAnt) Then
          Begin
            edtCodCnd.Text := strCcnAnt;
            pCarregaCondicao(True);
          End;

          Result := False;
        End;
      End;

      If Result And
         (Not Assigned(fatVenda))         And
         (fCfgSis('USACND') = 'S')        And
         (stlCndPag.Count > 0)            And
         (Not stlCndPag.Find(edtCodCnd.Text, intIndReg)) Then
      Begin
        If ((fCfgSis('IGNTPC') = 'N') and (blnTelaAgrupamento)) Then
        Begin
          pMsgCondicoesPagtoPermitidasCliente(edtCodCnd.Text, stlCndPag);
          Result := False;
        End;
      End

      Else If (blnBuscaPorChave) And Result Then
      Begin
        strCcnAnt := edtCodCnd.Text;
        strCndPagAnt := fTiraCaracEspeciais(mskCndPag.Text);
        fValidaCampos(mskCndPag, blnBuscaPorChave);
      End;

    End;

    If Result And Assigned(fatVenda) And
       (Not fatVenda.fVendedorComCondicaoPagto(edtCodCnd.Text, mskCndPag.Text)) Then
    Begin
      Result := False;
    End;

    If Assigned(fatVenda) Then
      fatVenda.blnCndTravaCli := (fRetTraCliConPag(edtCodCnd.Text) = 'S');

    If (Assigned(fatVenda)) And (fatVenda.fAcionarTravaVendasMaximoDiasNaoCompra(fatVenda.blnCndTravaCli, fStatusCndPag(fatVenda.strConPag), True)) Then
    Begin
      If Result                    And
         (fCfgSis('CNDVEN') = 'F') Then
      Begin
        If (Pos(fatVenda.strOpcDoc, 'VN_PD_OR_') > 0)                               And
           (Not blnTravaNaoCompra)                                                  And
           (Not fatVenda.fVerificaNaoCompra(blnTravaNaoCompra, fatVenda.strCodVen)) Then
          Result := False;
      End;
    End;

    If Result                                And
       Assigned(fatVenda)                    And
       SameText(fatVenda.strOpcDoc, 'DV')    And
      (Not fEmptyStr(edtForPag.Text))        And
      (Pos(edtForPag.Text, '001_008_') <= 0) Then
    Begin
      fMensagem('','A forma da condição de pagamento para devolução deve ser DINHEIRO (001) ou FATURADO (008)!',['&OK']);
      Result := False;
    End;

    If Result And Assigned(fatVenda) Then
    Begin
      If (Not fClienteTemCndPagAssociado(strCodCli)) And
         (Not fEmptyStr(edtCodCnd.Text))             And
         (Not fatVenda.fDocumentoParaFornecedor)     And
         (edtCodCnd.Text <> strCodCndAnt)            And
         (fCfgSis('TRACND', varBoolean))             And
         (Pos(fatVenda.strOpcDoc, 'OU_OE_EF_OF_') <= 0) And
         (fCfgSis('CNDPRA', varString) = '2') Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Liberação da condição de pagamento para quando é utilizado trava de cliente por condição de pagamento, e não há condição de');
        objLiberacao.objMsgLibera.pAddTexto('pagamento vinculado ao cliente.');

        If Assigned(fatVenda) Then
        Begin
          If Not fEmptyStr(fatVenda.strCodCnd) Then
            objLiberacao.objMsgLibera.pAddTextoCaption('Condição de pagamento', fatVenda.strCodCnd + '-' + fRetDesConPag(fatVenda.strCodCnd));
        End;

        objLiberacao.strDirAce := 'CNDPRA';
        objLiberacao.strSenLib := fCfgSis('SENPRA');
        objLiberacao.strMsgSen := 'Condição de Pagamento';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCliente := strCodCli + '-' + strNomCli;
        objLiberacao.strCpfCnpj := fRetCgcCpf(strCodCli);


        If (Not objLiberacao.fLibera) Then
        Begin
          If Assigned(fatVenda) Then
          Begin
            fatVenda.strCodCnd := '';
            fatVenda.strDesCnd := '';
            fatVenda.strCodFpg := '';
            fatVenda.strDesFpg := '';
          End;

          mskCndPag.Text     := '';
          edtForPag.Text     := '';
          edtDesForPag.Text  := '';
          Result := False;
        End
        Else
          pCarregaCondicao;
      End;
    End;

    If Result and Assigned(fatVenda) Then
    Begin
      If Not TFuncoesPixAutcom.ValidacoesCondicaoDePagamentoPix(fatVenda, FCondicaoPixLiberada) Then
        Result := False;
    End;

    If (Result) And (Assigned(fatVenda)) Then
    Begin
      If (MatchStr(fatVenda.strOpcDoc, ['PD','OR','VN'])) Then
      Begin
        If ((Not fEmptyStr(strCodCndAnt)) And (strCodCndAnt <> edtCodCnd.Text)) Or
           (fEmptyStr(strCodCndAnt) And ((Not fEmptyStr(fatVenda.strCodPagOri)) And (fatVenda.strCodPagOri <> edtCodCnd.Text))) Then
        Begin
          fatVenda.fltDeADig := 0;
        End;
      End;
    End;

    If Result Then
    Begin
      strCodCndAnt := edtCodCnd.Text;
      strCndPagAnt := fTiraCaracEspeciais(mskCndPag.Text);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfraDigCndPagamento.fUsaCndSeguro: Boolean;
begin
  Result := False;
  If Assigned(fatVenda) Then
  Begin
    Result := (Not fCfgSis('USACND', varBoolean));
  End
end;

procedure TfraDigCndPagamento.OnFormCreate(Sender: TObject);
begin
  inherited;
  pAtribuiTabelas;
  blnAutoHeight     := True;
  blnConfirma       := False;
  blnPodeCancelar   := True;
  blnRcx_F3         := False;
  strCcnAnt         := '';
  chkManPre.Visible := False;
  chkZerTax.Visible := False;
  blnHabZta         := False;
  blnHabMPr         := False;
  blnTamForm        := False;
  blnTelaAgrupamento:= False;
  blnEstaNaNovaTelaDeFechamento := False;

  strCodCli := '';
  strNomCli := '';
  stlNumLib := Nil;
  strCodCndAnt := '';
  strCndPagAnt := '';

  strCliAgr := '';
  strSugCndCli := '';

  blnIgnMar := False;

  blnAutSer := False;
  blnCnfDoc := False;

  blnTravaNaoCompra := False;

  stlForPag := TStringList.Create;
  stlCndPag := TStringList.Create;
  objLiberacao := TLiberacao.Create;
  mskCndPag.EditMask := MASK_CONPAG;

  blnRecalculaPrecos := False;

  FCondicaoPixLiberada := False;
  FblnLinkPgtJaIndicado := False;

  pAjustaPosicoesPnlChecks;
end;

function TfraDigCndPagamento.fConfirmaDados: Boolean;
  Var
    blnDevCon : Boolean;
begin
  inherited;
  Result := True;
  blnDevCon := fCfgSis('DEVCON', varBoolean);
  {*****************************************}
  {* DEVOLUÇÃO NÃO PERMITIDA PARA CLICON   *}
  {**************************************AF*}
  If (Assigned(fatVenda))  And
    (fClienteConsumidor(fRetNomCliente(strCodCli), False, True)) And
    (fatVenda.strOpcDoc = 'DV') And
    ((Not blnDevCon)Or (Not fatVenda.fEhDevolucaoAVista(mskCndPag.Text))) Then
  Begin
    If (Not blnDevCon) Then
      fMensagem('', 'Devolução não permitida! Para efetuar este processo, '+
                    'habilite a configuração "CFG_DEVCON" - Permitir devolução para cliente consumidor '+
                    'sem trocar o cliente?!', ['&Ok'])
    Else
      fMensagem('', 'Devolução a prazo não permitida para cliente consumidor! ', ['&Ok']);
    Exit(False);
  End;

  If (Assigned(fatVenda)) And (fatVenda.blnLiberacaoRemotaNoFinalVenda) And (Not fLogAviExists('SENCND')) Then
  Begin
    If (Not fLiberouTrocaDaCondicaoSugerida(True)) Then
    Exit(False);
  End;

  blnConfirma := Result;
end;

function TfraDigCndPagamento.fDesconsiderarTipoDeClienteNoAgrupamento: Boolean;
begin
  Result := (fCfgSis('IGNTPC') = 'S') and (blnTelaAgrupamento);
end;

procedure TfraDigCndPagamento.OnFormShow(Sender: TObject);
  Var
    blnVerEsp : Boolean;
    dtaBasTmp: TDateTime;
begin
  inherited;
  strFpgLib := '';

  strCcnOrc := strCcnAnt;
  strCodLib := '';

  If Assigned(fatVenda) Then
    fatVenda.strCndLib := '';

  If Assigned(fatVenda) Then
    blnVerEsp := fatVenda.strOpcDoc <> 'EP'
  Else
    blnVerEsp := True;

  If (fCfgSis('USACND', varBoolean)) And blnVerEsp Then
  Begin
    strAntCndPag := mskCndPag.Text;
    edtCodCnd.Visible := True;
    mskCndPag.Color   := $00FFDFB8;
    mskCndPag.Left    := 175;
    mskCndPag.Width   := 531;
    mskCndPag.Enabled := False;

    If Assigned(fatVenda) Then
      strCodCndAnt := fatVenda.strCodCnd;

    If (Not fEmptyStr(edtCodCnd.Text)) And (fEmptyStr(mskCndPag.Text)) Then
      pCarregaCondicao;

    If (qryConCnd.Active)Then
    Begin
      If (qryConCnd.FieldByName('CND_TIPFOR').AsString = 'OUTROS') Then
      Begin
        mskCndPag.Enabled := True;
        mskCndPag.Text := strAntCndPag;
      End;

      If ((Assigned(fatVenda))                   And
          (Not fEmptyStr(fatVenda.strConPagOri)) And
          (edtCodCnd.Text = strCcnOrc))          And                     // QUANDO ESTIVER CARREGANDO UM PEDIDO/ORÇAMENTO IRÁ MANTER A CONDIÇÃO DO PEDIDO/ORÇAMENTO
          ((qryConCnd.FieldByName('CND_TIPFOR').AsString = 'OUTROS') Or ((Not fMudouCliDoPedOrcComSugCndPagDiferente) And (Not fEmptyStr(fatVenda.strNumOrc) And (fatVenda.fCarregaCondicaoPedido)))) And
          (not fatVenda.fRecebidoPorPix) Then
      Begin
        If (edtCodCnd.Text <> strCcnAnt) Then
          strCcnOrc := '';

        mskCndPag.Text := fatVenda.strConPagOri;

        If ((Not fEmptyStr(strCcnAnt)) And (strCcnAnt <> qryConCnd.FieldByName('CND_CODIGO').AsString)) Or
           (fConPagFora(qryConCnd.FieldByName('CND_TIPFOR').AsString)) Or
           ((Not fEmptyStr(fatVenda.strCodPagOri)) And (fatVenda.strCodPagOri <> fatVenda.strCodCnd)) Then
        Begin
          mskCndPag.Text := qryConCnd.FieldByName('CND_CNDPAG').AsString;
        End;

        strConAux := '';

        dtaBasTmp := IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date);

        With qryConCnd Do
        Begin
          If (fConPagFora(FieldByName('CND_TIPFOR').AsString)) Then
          Begin
            mskCndPag.Text := fRetCondicao(fatVenda.fRetConPagRef(qryConCnd.FieldByName('CND_CODIGO').AsString),
                                           fatVenda.dtaUltDtaAlt,
                                           FieldByName('CND_CODIGO').AsString,
                                           FieldByName('CND_TIPFOR').AsString,
                                           mskCndPag.Text,
                                           dtaBasTmp,
                                           fatVenda.strOpcDoc,
                                           fatVenda.strCodCid);
            strConAux := mskCndPag.Text;
          End;
        End;

        If Assigned(fatVenda) And (Not fatVenda.fDocumentoParaFornecedor) Then
        Begin
          {***************************************************************************************************}
          {* CFG_CNDNEO DEVERIA NEM EXISTIR POIS O COMPORTAMENTO DE USAR A CONDIÇÃO ORIGINAL DO PEDIDO       *}
          {* SÓ É VÁLIDA PARA FORA = OUTROS. ISSO DE USAR SEMPRE A CONDIÇÃO DO PEDIDO FOI CRIADO PELO        *}
          {* REQ.: 38147 PORÉM FOI REFORMADO/QUEBRADO EM SUA ESSÊNCIA PELO REQ.: 48229, EXCETO NESSA TELA.   *}
          {* FOI CRIADA A CONFIGURAÇÃO POIS PODE TER CLIENTES QUE SE HABITUARAM A TRABALHAR DESSA FORMA      *}
          {* PORÉM ELA FICA INCOERENTE UMA VEZ QUE, OS VENCIMENTOS DE FORA=NENHUM SÃO REAJUSTADOS CASO O     *}
          {* CLIENTE TEM DIA FIXO SEMANA/MÊS DEFINIDO NO CADASTRO. (RECLAMAÇÃO DESTE REQ.: 143257)           *}
          {* SE POR VENTURA ALGUM CLIENTE RECLAMAR QUE VENCIMENTOS ESTÃO FICANDO DIVERGENTES ENTRE O QUE FOI *}
          {* GRAVADO NO PEDIDO/ORÇAMENTO E O QUE FICOU NO DOCUMENTO FATURADO PEÇAM PARA QUE COLOQUEM         *}
          {* CFG_CNDNEO=NÃO                                                                                  *}
          {************************************************************************************************VA*}
          {* REMOVIDA CFG_CNDNEO PORQUE SÓ DA PROBLEMA. QUANDO UMA CONDIÇÃO É NENHUM 01001 COM JUROS E ESSE  *}
          {* PEDIDO É GRAVADO NUMA SEXTA (CONDIÇÃO É ALTERADA AUTOMATICAMENTE PARA SEGUNDA 01003 MAS COBRANDO*}
          {* O JUROS DE SÓ UM DIA O QUE ESTÁ CERTO) MAS CASO ESSE PEDIDO SEJA ALTERADO NA MESMA SEXTA FEIRA  *}
          {* O SISTEMA ELE IRÁ COBRAR 3 DIAS DE JUROS, O QUE ESTÁ ERRADO. COMO DESCRITO ACIMA NÃO FAZ MUITO  *}
          {* SENTIDO RESOLVI REMOVER ESSA CONFIGURAÇÃO QUE SE FAZ O SISTEMA SE COMPORTAR DE FORMA            *}
          {* ESQUIZOFRÊNICA OU SE USA FORMA OUTROS ONDE A CONDIÇÃO SE AJUSTA CONFORME A DATA DE ALTERAÇÃO    *}
          {* OU SE USA NENHUM ONDE A CONDIÇÃO É SEMPRE FIXA. SE ALGUÉM RECLAMAR TEM QUE PENSAR UMA FORMA DE  *}
          {* TRATAR ESSA SITUAÇÃO CASO VOLTE ESSA CONFIGURAÇÃO.                                              *}
          {************************************************************************************REQ.:334804.VA*}
          If (fEmptyStr(strConAux)) And (Pos(qryConCnd.FieldByName('CND_TIPFOR').AsString, 'OUTROS_') <= 0) Then
            strConAux := fRetConPagCodCnd(qryConCnd.FieldByName('CND_CODIGO').AsString)
          Else
            strConAux := mskCndPag.Text;

          mskCndPag.Text := fRetCondicaoDiaFixoCliente(fatVenda.fRetConPagRef(qryConCnd.FieldByName('CND_CODIGO').AsString),
                                                       fatVenda.dtaUltDtaAlt,
                                                       fatVenda.strCodCli,
                                                       strConAux,
                                                       dtaBasTmp,
                                                       fatVenda.strOpcDoc,
                                                       fatVenda.strCodCid);
        End;

        If Assigned(fatVenda) Then
        Begin
          If fCfgSis('AJPZDF', VarBoolean) And (fatVenda.strOpcDoc = 'CP') Then
          Begin
            If (fConPagFora(fRetTipoForaConPag(fatVenda.strCodCndResolvidoEmConflito))) Or fClienteTemDiaFixo(fatVenda.strCodCli)  Then
              If (fatVenda.strCodCndResolvidoEmConflito = qryConCnd.FieldByName('CND_CODIGO').AsString) Then
                mskCndPag.Text := fatVenda.strConPagResolvidoEmConflito;
          End;
        End;
      End;
    End;

  End
  Else
  Begin

    edtCodCnd.Visible := False;
    mskCndPag.Enabled := True;
    mskCndPag.Left    := edtCodCnd.Left;
    mskCndPag.Width   := 598;
    mskCndPag.Color   := clWhite;

  End;

  pnlPrevisao.Visible := False;

  If Assigned(fatVenda) Then
    pnlPrevisao.Visible := fUsaPrevisaoDeEntregaNoFinal(fatVenda.strOpcDoc);

  If not pnlPrevisao.Visible Then
    If blnAutoHeight Then
      GetParentForm(Self).Height := GetParentForm(Self).Height - pnlPrevisao.Height;

  If (Not fCfgSis('USAFPG', varBoolean)) Then
  Begin
    pnlForPag.Visible := False;
    If blnAutoHeight Then
      GetParentForm(Self).Height := GetParentForm(Self).Height - pnlForPag.Height;
  End;

  If Not(blnTamForm) Then
  Begin
    pnlDados.Visible := False;
    If blnAutoHeight Then
      GetParentForm(Self).Height := GetParentForm(Self).Height - pnlDados.Height{ + pnlZerTax.Height};
  End;

  If Not Assigned(qryConFpg) Then
    qryConFpg := fCriaQuery(Self);

  If blnAutSer Then
  Begin
    If fEmptyStr(edtForPag.Text) Then
      edtForPag.Text := '001';
    fValidaCampos(edtForPag);
  End;

  If Assigned(fatVenda) And
     (fatVenda.strOpcDoc = 'EP') Then
  Begin
    fatVenda.strConPag    := fCndEmp;
    mskCndPag.Text        := fatVenda.strConPag;
    mskCndPag.Enabled     := False;

    edtCodCnd.Visible     := False;
    mskCndPag.Left        := edtCodCnd.Left;

    pnlForPag.Visible     := False;

    If (fatVenda.VS_blnUsaFpg) Then
      fatVenda.strCodFpg := '001';
  End;

  If Assigned(fatVenda) And (Pos(fatVenda.strOpcDoc, 'DV_PR_DD_') > 0) Then
  Begin
    If Not fCfgSis('ALCNDV', varBoolean) Then
    Begin
      mskCndPag.Enabled  := False;
      edtCodCnd.Visible  := False;
      mskCndPag.Left     := edtCodCnd.Left;
    End;

    {*******************************************************}
    {* NAS DEVOLUÇÕES SE O USUÁRIO PÔDE ALTERAR A CONDIÇÃO *}
    {* DE PAGTO ENTÃO ELE TEM QUE PODER ALTERAR A FORMA    *}
    {****************************************************VA*}
    If Not ((fatVenda.strOpcDoc = 'DV') And
            (fCfgSis('USAFPG', varBoolean)) And
            (fCfgSis('CNDVEN') = 'F') And
            (fCfgSis('ALCNDV', varBoolean))) Then
    Begin
      pnlForPag.Visible  := False;
    End;
  End;

  pMostraOpcZerarTaxJuros;

  If (fatVenda <> Nil) And (fatVenda.blnMeiaNota) and (fatVenda.strOpcDoc <> 'CF') Then
  Begin
    edtCodCnd.Enabled := False;
    mskCndPag.Enabled := False;
  End;

  blnHabMpr := blnHabMpr And Assigned(fatVenda) And fatVenda.blnBaixaEmprestimos;

  If blnHabMPr Then
  Begin
    chkManPre.Visible := True;

    pAjustaPosicoesPnlChecks;
  End;

  If (Assigned(fatvenda)) Then
  Begin
    If (Not fatVenda.fPermiteAlterarCondFormaPagtoConfNFConcreto) Then
    Begin
      edtCodCnd.Enabled := False;
      edtForPag.Enabled := False;
      mskCndPag.Enabled := False;
    End;

    If (Not fatVenda.fPermiteAlterarCondFormaPagtoPedido) Then
    Begin
      edtCodCnd.Enabled := False;
      edtForPag.Enabled := False;
      mskCndPag.Enabled := False;
    End;

    if fatVenda.fPedidoComPixPagoLiberadoParaAlteracao then
    begin
      edtCodCnd.Enabled := False;
      edtForPag.Enabled := False;
      mskCndPag.Enabled := False;
    end ;

  End;

  If edtCodCnd.Visible Then
    strCodigPagAoAbrir := edtCodCnd.Text;
  If mskCndPag.Visible Then
    strCondiPagAoAbrir := mskCndPag.Text;
  If edtForPag.Visible Then
    strFormaPagAoAbrir := edtForPag.Text;

  If (blnRcx_F3) And
     (fCfgSis('CND_F3') = 'F') And
     (edtCodCnd.Visible) And
     (Not fEmptyStr(edtCodCnd.Text)) Then
  Begin
    VS_ExibirMensagemAoUsuario := False;
    Try
      fValidaCampos(edtCodCnd);
    Finally
      VS_ExibirMensagemAoUsuario := True;
    End;
  End;
end;

procedure TfraDigCndPagamento.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCnd: TConsultasArray;
    strCndCli: String;
    strCliPorCre: String;
begin
  inherited;
  strCndCli := EmptyStr;
  strCliPorCre := EmptyStr;

  If (Not fCfgSis('USACND', varBoolean)) Then
    Exit;

  If edtCodCnd.Enabled And (Not edtCodCnd.ReadOnly) Then
  Begin

    If Assigned(fatVenda) Then
    Begin
      If (Pos(fatVenda.strOpcDoc, 'OU_OE_OF_EF_') <= 0) And
         (fCfgSis('TRACND', varBoolean)) And
         (Not fatVenda.fDocumentoParaFornecedor) Then
        strCndCli := strCodCli;
    End;

    If Not fMostraCreditoComPortador(strCodCli) Then
    Begin
      strCliPorCre := strCodCli;
    End;

    pAtualizaMargemTotalDocumento;
    {*******************************}
    {* NOVA CONSULTA DE COND. PGTO *}
    {****************************RV*}
    If fPesqCondicoesPgto(GetParentForm(Self)as TForm, edtCodCnd, Nil, Nil, Key, arrCnd, True, False,
                          IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conCndSimples), fltMarDoc,
                          fltValDoc, strCndCli, True, Assigned(fatVenda), blnRcx_F3, strCliPorCre, blnIgnMar) Then
    Begin
      if fValidaCampos(edtCodCnd, True) then
        SelectNext(GetParentForm(Self).ActiveControl, True, True);
    End;
  End;
end;

procedure TfraDigCndPagamento.pConsultaAlpe;
var
  objAlpeCondicao: TReceivablesSummaries;
  i, p: Integer;
begin
  objAlpeCondicao := TControllerReceivablesSummaries.fGet(fatVenda.strCliCgc);

  if objAlpeCondicao <> nil then
  begin
    fatVenda.fltCreAlp := objAlpeCondicao.content[0].items[0].amount;
    lblObs.Visible := True;
    lblObs.Caption := 'Saldo Alpe: '+Format('%m', [fatVenda.fltCreAlp]);

    for p := 0 to Length(objAlpeCondicao.content[0].relationship.properties)-1 do
    begin
      if objAlpeCondicao.content[0].relationship.properties[p].code = 'supplier-parcels' then
        mskCndPag.Text := fStrZero(objAlpeCondicao.content[0].relationship.properties[p].value[0].ToString,2);

      if objAlpeCondicao.content[0].relationship.properties[p].code = 'supplier-paymentTerm' then
        for i := 0 to Length(objAlpeCondicao.content[0].relationship.properties[p].value)-1 do
        begin
          mskCndPag.Text := mskCndPag.Text +
                            fStrZero(objAlpeCondicao.content[0].relationship.properties[1].value[i].ToString,3);
        end;
    end;

    FreeAndNil(objAlpeCondicao);
  end;
end;

procedure TfraDigCndPagamento.pConsultaAlpeLimiteBoleto;
var
  fltLimiteTotal,
  fltLimiteUtilizado,
  fltLimiteDisponivel,
  fltTotalDebito: Double;

  blnStopSupply: Boolean;
  blnFilPed: Boolean;

  strMsg,
  strPedidos: String;
begin
  fltLimiteTotal := 0.0;
  fltLimiteUtilizado := 0.0;
  fltLimiteDisponivel := 0.0;
  fatVenda.fltLimBolAlp := 0.0;
  fltTotalDebito := 0.0;

  if not TControllerPaymentProductsArrangements.fConsultaAlpeLimiteBoleto(fatVenda.strCliCgc,
                                                                          fltLimiteTotal,
                                                                          fltLimiteUtilizado,
                                                                          fltLimiteDisponivel,
                                                                          blnStopSupply,
                                                                          strMsg) then
  begin
    if blnStopSupply then
    begin
      lblObs.Visible := True;
      lblObs.Caption := 'StopSupply: ' + strMsg;
    end;

    Exit;
  end;

  if fCfgSis('PDALLM', varBoolean) then
  begin
    strPedidos := fatVenda.strNumOrc;

    if not fEmptyStr(fatVenda.strNumDocsPD) then
      strPedidos := fatVenda.strNumDocsPD;

    blnFilPed := ((Pos(fatVenda.strOpcDoc, 'PD_VN_') > 0) And (fatVenda.strEspOrc = 'PD')) Or (Not fEmptyStr(fatVenda.strNumDocsPD));

    fltTotalDebito := fRetTotalPedidoVendaAberto(fatVenda.strCodCli, IIF(blnFilPed, strPedidos, ''), True);
  end;

  fltLimiteUtilizado := fltLimiteUtilizado + fltTotalDebito;
  fatVenda.fltLimBolAlp := fltLimiteDisponivel - fltTotalDebito;

  lblObs.Visible := True;
  lblObs.Caption := 'Limites Alpe -'+
                    ' Limite Total: '+Format('%m', [fltLimiteTotal])+
                    '   Limite Utilizado: '+Format('%m', [fltLimiteUtilizado])+
                    '   Limite Disponível: '+Format('%m', [fatVenda.fltLimBolAlp]);
end;

procedure TfraDigCndPagamento.pCarregaCondicao(blnMudou: Boolean = False);
  Var
    strOpcDocTmp: String;
    dtaPreVisTmp: TDateTime;
    dtaBasTmp: TDateTime;
    strConPagRef: String;
    dtaUltDtaAlt: TDateTime;
    strCodCid: String;
    strCodCli: String;
begin
  lblObs.Visible := False;

  If Assigned(fatVenda) Then
    strCodCli := fatVenda.strCodCli
  Else
    strCodCli := EmptyStr;

  pAtualizaMargemTotalDocumento;
  pPesquisaCadCnd(qryCadCnd,
                  qryConCnd,
                  edtCodCnd.Text,
                  fltMarDoc,
                  fltValDoc,
                  Assigned(fatVenda),
                  strCodCli,
                  blnIgnMar);


  lblPagamentoPix.Visible := False;

  If ( Not qryConCnd.IsEmpty ) Then
  Begin
    With qryConCnd Do
    Begin

      strConAux := '';

      If ( FieldByName('CND_TIPFOR').AsString = 'OUTROS' ) Then
      Begin
        mskCndPag.Enabled     := True;
        mskCndPag.Color       := clWindow;
        mskCndPag.NormalColor := clWindow;
        mskCndPag.Text        := FieldByName('CND_CNDPAG').AsString;
      End
      Else
      Begin
        If Assigned(fatVenda) Then
        Begin
          dtaPreVisTmp := fatVenda.dtaPreVis;
          strOpcDocTmp := fatVenda.strOpcDoc;
          strConPagRef := fatVenda.fRetConPagRef(FieldByName('CND_CODIGO').AsString);
          dtaUltDtaAlt := fatVenda.dtaUltDtaAlt;
        End
        Else
        Begin
          dtaPreVisTmp := 0;
          strOpcDocTmp := '';
          strConPagRef := '';
          dtaUltDtaAlt := 0;
        End;

        dtaBasTmp := IIF(dtaPreVisTmp > 0, dtaPreVisTmp, VS_Date);

        mskCndPag.Enabled     := False;
        mskCndPag.Color       := $00FFDFB8;
        mskCndPag.NormalColor := $00FFDFB8;

        if Assigned(fatVenda) then
          strCodCid := fatVenda.strCodCid
        else
          strCodCid := '';

        mskCndPag.Text        := fRetCondicao(strConPagRef,
                                              dtaUltDtaAlt,
                                              FieldByName('CND_CODIGO').AsString,
                                              FieldByName('CND_TIPFOR').AsString,
                                              FieldByName('CND_CNDPAG').AsString,
                                              dtaBasTmp,
                                              strOpcDocTmp,
                                              strCodCid);

        If (fConPagFora(FieldByName('CND_TIPFOR').AsString)) Then
        Begin                                      
          strConAux := mskCndPag.Text; 
        End;
      End;

      If ((Not blnMudou) And (Assigned(fatVenda)) And
          (Not fEmptyStr(fatVenda.strConPagOri))) And          // QUANDO ESTIVER CARREGANDO UM PEDIDO/ORÇAMENTO IRÁ MANTER A CONDIÇÃO DO PEDIDO/ORÇAMENTO
          ((FieldByName('CND_TIPFOR').AsString = 'OUTROS') Or ((Not fMudouCliDoPedOrcComSugCndPagDiferente) And (Not fEmptyStr(fatVenda.strNumOrc)) And (fatVenda.fCarregaCondicaoPedido))) and
          (not fatVenda.fRecebidoPorPix) Then
      Begin

        If (FieldByName('CND_TIPFOR').AsString = 'OUTROS') Then
        Begin
          mskCndPag.Text := fatVenda.strConPagOri;
        End
        Else If (FieldByName('CND_TIPFOR').AsString = 'NENHUM') Then
        Begin
          If ((Not fEmptyStr(fatVenda.strNumOrc)) And (fatVenda.strCodCli <> fatVenda.strCliAnt)) Then
          Begin
            If fManterCondicaoDePagamentoDoClienteOriginal Then
            Begin
              strCcnAnt      := '';
              edtCodCnd.Text := fatVenda.strCodPagOri;
              mskCndPag.Text := fatVenda.strConPagOri;
            End;
          End
          Else
          Begin
            mskCndPag.Text := fatVenda.strConPagOri;
          End;
        End;

      End;

      If (Assigned(fatVenda)) And
         (fatVenda.strOpcDoc = 'LE') And
         (Not fEmptyStr(fatVenda.strCodPagOri)) And
         (qryConCnd.FieldByName('CND_CODIGO').AsString =  fatVenda.strCodPagOri) And
         (qryConCnd.FieldByName('CND_CNDPAG').AsString <> fatVenda.strConPagOri) Then
      Begin
        mskCndPag.Text := fatVenda.strConPagOri;
      End;

      If Assigned(fatVenda) And (Not fatVenda.fDocumentoParaFornecedor) Then
      Begin
        {***************************************************************************************************}
        {* CFG_CNDNEO DEVERIA NEM EXISTIR POIS O COMPORTAMENTO DE USAR A CONDIÇÃO ORIGINAL DO PEDIDO       *}
        {* SÓ É VÁLIDA PARA FORA = OUTROS. ISSO DE USAR SEMPRE A CONDIÇÃO DO PEDIDO FOI CRIADO PELO        *}
        {* REQ.: 38147 PORÉM FOI REFORMADO/QUEBRADO EM SUA ESSÊNCIA PELO REQ.: 48229, EXCETO NESSA TELA.   *}
        {* FOI CRIADA A CONFIGURAÇÃO POIS PODE TER CLIENTES QUE SE HABITUARAM A TRABALHAR DESSA FORMA      *}
        {* PORÉM ELA FICA INCOERENTE UMA VEZ QUE, OS VENCIMENTOS DE FORA=NENHUM SÃO REAJUSTADOS CASO O     *}
        {* CLIENTE TEM DIA FIXO SEMANA/MÊS DEFINIDO NO CADASTRO. (RECLAMAÇÃO DESTE REQ.: 143257)           *}
        {* SE POR VENTURA ALGUM CLIENTE RECLAMAR QUE VENCIMENTOS ESTÃO FICANDO DIVERGENTES ENTRE O QUE FOI *}
        {* GRAVADO NO PEDIDO/ORÇAMENTO E O QUE FICOU NO DOCUMENTO FATURADO PEÇAM PARA QUE COLOQUEM         *}
        {* CFG_CNDNEO=NÃO                                                                                  *}
        {************************************************************************************************VA*}
        {* REMOVIDA CFG_CNDNEO PORQUE SÓ DA PROBLEMA. QUANDO UMA CONDIÇÃO É NENHUM 01001 COM JUROS E ESSE  *}
        {* PEDIDO É GRAVADO NUMA SEXTA (CONDIÇÃO É ALTERADA AUTOMATICAMENTE PARA SEGUNDA 01003 MAS COBRANDO*}
        {* O JUROS DE SÓ UM DIA O QUE ESTÁ CERTO) MAS CASO ESSE PEDIDO SEJA ALTERADO NA MESMA SEXTA FEIRA  *}
        {* O SISTEMA ELE IRÁ COBRAR 3 DIAS DE JUROS, O QUE ESTÁ ERRADO. COMO DESCRITO ACIMA NÃO FAZ MUITO  *}
        {* SENTIDO RESOLVI REMOVER ESSA CONFIGURAÇÃO QUE SE FAZ O SISTEMA SE COMPORTAR DE FORMA            *}
        {* ESQUIZOFRÊNICA OU SE USA FORMA OUTROS ONDE A CONDIÇÃO SE AJUSTA CONFORME A DATA DE ALTERAÇÃO    *}
        {* OU SE USA NENHUM ONDE A CONDIÇÃO É SEMPRE FIXA. SE ALGUÉM RECLAMAR TEM QUE PENSAR UMA FORMA DE  *}
        {* TRATAR ESSA SITUAÇÃO CASO VOLTE ESSA CONFIGURAÇÃO.                                              *}
        {************************************************************************************REQ.:334804.VA*}
        If (fEmptyStr(strConAux)) And (Pos(FieldByName('CND_TIPFOR').AsString, 'OUTROS_') <= 0) Then
          strConAux := fRetConPagCodCnd(FieldByName('CND_CODIGO').AsString)
        Else
          strConAux := mskCndPag.Text;

        dtaBasTmp := IIF(fatVenda.dtaPreVis > 0, fatVenda.dtaPreVis, VS_Date);

        mskCndPag.Text := fRetCondicaoDiaFixoCliente(fatVenda.fRetConPagRef(FieldByName('CND_CODIGO').AsString),
                                                     fatVenda.dtaUltDtaAlt,
                                                     fatVenda.strCodCli,
                                                     strConAux,
                                                     dtaBasTmp,
                                                     fatVenda.strOpcDoc,
                                                     fatVenda.strCodCid);
      End;

      If Assigned(fatVenda) Then
      Begin
        If fCfgSis('AJPZDF', VarBoolean) And (fatVenda.strOpcDoc = 'CP') Then
        Begin
          If (fConPagFora(fRetTipoForaConPag(fatVenda.strCodCndResolvidoEmConflito))) Or fClienteTemDiaFixo(fatVenda.strCodCli) Then
            If (fatVenda.strCodCndResolvidoEmConflito = qryConCnd.FieldByName('CND_CODIGO').AsString) Then
              mskCndPag.Text := fatVenda.strConPagResolvidoEmConflito;
        End;
      End;

      if (fCfgSis('USAALP', varBoolean)) and
         (edtCodCnd.Text = fCfgSis('CPGALP', varString)) then
        TfrmGravando.fExecutarModal(pConsultaAlpe, 'Aguarde, comunicando com a ALPE ...', '');

      if (fCfgSis('ALPKNK', varBoolean)) and
         (Pos(edtCodCnd.Text, fCfgSis('CNDBOL', varString)) > 0) then
        TfrmGravando.fExecutarModal(pConsultaAlpeLimiteBoleto, 'Aguarde, comunicando com a ALPE ...', '');

      edtForPag.ReadOnly := False;
      edtForPag.TabStop  := True;

      If (fCfgSis('USAFPG', varBoolean)) And (Not fEmptyStr(FieldByName('CND_CODFPG').AsString)) And
         (Not fEmptyStr(edtCodCnd.Text)) And (edtForPag.Enabled) Then
      Begin
        If Assigned(fatVenda) Then
        Begin
          If (fatVenda.strOpcDoc = 'DV') And fCfgSis('DVVORI', varBoolean) And (fCfgSis('USACND', varBoolean)) Then
          Begin
            If (fStatusCndPag(mskCndPag.Text) = A_VISTA) Then
              edtForPag.Text := '001'
            Else
              edtForPag.Text := '008';
          End
          Else If (fatVenda.strOpcDoc = 'CI') And (Not fEmptyStr(fatVenda.strCodFpg)) And (fCfgSis('PROCTR') = '1') Then
            edtForPag.Text := fatVenda.strCodFpg
          Else
            edtForPag.Text := FieldByName('CND_CODFPG').AsString;
        End
        Else
          edtForPag.Text := FieldByName('CND_CODFPG').AsString;

        edtForPag.ReadOnly := True;
        edtForPag.TabStop  := False;

        If Assigned(fatVenda) Then
        Begin
          If ((fatVenda.strOpcDoc = 'CI' ) And fCfgSisL('INFIEL', varBoolean)) Or
             ((fatVenda.strOpcDoc = 'CI' ) And (fCfgSis('PROCTR') = '1')) Then
          Begin
            edtForPag.ReadOnly := False;
            edtForPag.TabStop  := True;
          End;
        End;

        pCarregaForPag;
      End;

      If Assigned(fatVenda) Then
      Begin
        fatVenda.fltDMVCnd := FieldByName('CND_DESMAX').AsFloat;
        fatVenda.fltDMGCnd := FieldByName('CND_DESMGE').AsFloat;
        fatVenda.fltDMSCnd := FieldByName('CND_DESMSU').AsFloat;
        fatVenda.fltTxJCnd := FieldByName('CND_TXJURO').AsFloat;
        fatVenda.strCAbDes := FieldByName('CND_ABADES').AsString;
        fatVenda.strTipFor := FieldByName('CND_TIPFOR').AsString;
        fatVenda.strAbDeCc := FieldByName('CND_ABDECC').AsString;
        fatVenda.strJurPro := FieldByName('CND_JURPRO').AsString;
        fatVenda.strCndTbP := FieldByName('CND_TABPRE').AsString;
        fatVenda.strCndTpm := FieldByName('CND_PRETAB').AsString;
        fatVenda.strDesCnd := FieldByName('CND_DESCRI').AsString;

        ValidacoesCondicaoPagamentoPix;
      End;

    End;

  End;

end;

procedure TfraDigCndPagamento.edtForPagKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  If (Not fCfgSis('USAFPG', varBoolean)) Then
    Exit;

  If fEntraCons(Key) And (Not edtForPag.ReadOnly) Then
  Begin
    {***********************************}
    {* NOVA CONSULTA DE FORMA DE PAGTO *}
    {********************************RV*}
    If fPesqFormaPgto(conFpgBaiAvi, GetParentForm(Self) as TForm, edtForPag, edtDesForPag, Nil, Key, arrForma) Then
    Begin
      If (fValidaCampos(edtForPag, True)) Then
        SelectNext(GetParentForm(Self).ActiveControl, True, True);
    End;
    pCarregaForPag;
  End;
  pCarregaForPag;

end;

function TfraDigCndPagamento.fLiberarAgrupDupCtr(
  ADuplicatas: TUniClientDataSet): Boolean;
Var
  sumValDup,
  sumValCor    : Double;
  objLiberacao : TLiberacao;
  objTabela    : TRegistroMsgLiberaTabela;
  objLinha     : TLinhaMsgLibera;
  APrazoMedio  : Integer;
begin
  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  objLiberacao := TLiberacao.Create;

  APrazoMedio := fCfgSis('PRZCND', varInteger);
  Try
    With ADuplicatas Do
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(125);
      objLiberacao.objMsgLibera.pAddTexto(
        'A CONDIÇÃO DE PAGAMENTO SELECIONADA É MAIOR QUE O PRAZO MÉDIO CONFIGURADO: '+
        IntToStr(APrazoMedio) + ' DIAS.', alCentro, teAmbos, '',125);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
      objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      sumValDup := 0;
      sumValCor := 0;

      First;
      While Not Eof Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('NRODUP').AsString,12)
                                               + FieldByName('PARDUP').AsString + '-'
                                               + FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
        objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
        objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
        objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
        objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        sumValDup := sumValDup + FieldByName('CTR_VALDUP').AsFloat;
        sumValCor := sumValCor + FieldByName('CTR_VALCOR').AsFloat;

        Next;
      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''                , 'TOTAIS'                                , 89 , alDireita, teAutcom );
      objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(sumValDup, ffNumber, 9, 2) , 13 , alDireita  );
      objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(sumValCor, ffNumber, 9, 2) , 16 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


      objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', '', 25 , alDireita, teAmbos, '', 6);
      objLiberacao.objMsgLibera.pAddSeparador(125);
    End;

    objLiberacao.strDirAce := 'CTRPADPMM';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Agrupa Duplicatas Ctr';
    objLiberacao.objMsgLibera.strTitulo := 'Permitir agrupar duplicatas com prazo médio maior que o configurado.';

    Result := objLiberacao.fLibera;

    if Result then
    Begin
      objLiberacao.strCodOpe := objLiberacao.strOperador;
      TLogLibRec.pInsereLogLigTMP(objLiberacao, ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                                  ADuplicatas.FieldByName('CTR_ESPDOC').AsString,
                                  ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                                  Self.Name);
      SetLength(arrLogLib, Length(arrLogLib) - 1);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '');
    End;
  End;
  Screen.Cursor := crDefault;
end;

function TfraDigCndPagamento.fLiberouTrocaDaCondicaoSugerida(blnResult: Boolean): Boolean;
begin

  Result := blnResult;

  If (Result) And (Assigned(fatVenda)) Then
  Begin
    If (fEmptyStr(strSugCndCli)) Then
      strSugCndCli := fatVenda.fCondicaoPagtoClienteSugestao;

    If (Not fEmptyStr(fatVenda.strCodPagOri)) And (fEmptyStr(strCndPedOrc)) Then
      strCndPedOrc := fatVenda.strCodPagOri;

    If (Result) And
       (fCfgSis('PFLCLI', varBoolean) And
       fRetCampoCndPagto(strSugCndCli, 'CND_SENCND'))  And //'Solicitar Senha para Alterar Cnd. Pagamento Sugerida?' TEM QUE ESTAR 'SIM'
       ((Not fEmptyStr(strSugCndCli) And (Not fEmptyStr(strCndPedOrc)) And (edtCodCnd.Text <> strSugCndCli) And (edtCodCnd.Text <> strCndPedOrc))) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Alteração da Condição de Pagamento sugerida.');
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto Sugerida'    , strSugCndCli + ' - ' + fRetDesConPag(strSugCndCli)    , 21);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto Informada'   , edtCodCnd.Text + ' - ' + fRetDesConPag(edtCodCnd.Text), 21);

      If (fatVenda.fltTotGer > 0) Then
        objLiberacao.objMsgLibera.pAddTextoCaption('Valor Total Documento' , FormatFloat('#,##0.00', fatVenda.fltTotGer)           , 21);

      objLiberacao.strDirAce := 'SENCND';
      objLiberacao.strSenLib := fCfgSis('SENCND');
      objLiberacao.strMsgSen := 'Alteração da Condição de Pagamento';
      objLiberacao.strCodOpe := fatVenda.strCodVen;
      objLiberacao.strCodDig := fatVenda.strCodDig;
      objLiberacao.strCliente := (fatVenda.strCodCli + '-' + fatVenda.strCliOri);
      objLiberacao.strCpfCnpj := fatVenda.strCliCgc;

      Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
    End;

    If (Result) And (Not fEmptyStr(fatVenda.strCodPagOri)) Then
      strCndPedOrc := edtCodCnd.Text;
  End;
end;

procedure TfraDigCndPagamento.fExibeAlertaCondicaoNaoPermitida(strCodCli: String = '');
var
  blnMostrarMensagem: Boolean;
begin
  If (Not fEmptyStr(strCodCli)) And (fExibeAlertaDeNaoUtilizacaoDeCredito(strCodCli)) Then
    fMensagem('ATENÇÃO!', 'Condição de pagamento de utilização de crédito não permitida. Cliente sem crédito cadastrado!', ['&O k'])
  Else If fExisteCndPagCad And blnNenhumaCndPagEncontrada Then
    fMensagem('ATENÇÃO!', 'Condição de Pagamento não permitida. Valor/Margem da venda está fora do limite mínimo/máximo!'+#10#13+
                          'Sistema configurado para permitir somente condições que se enquadrem nos limites mínimo/máximo de Valor/Margem (CFG_LIBCND). Ajuste o cadastro do cliente!', ['&O k'])
  Else If fExisteCndPagCad And ((fltMarDoc > 0) Or (fltValDoc > 0)) Then
  Begin
    blnMostrarMensagem := True;

    If (fCfgSis('CNDVEN') = 'F') And
       (fCfgSis('LIBCND') = '1') And
       (fPermitirIgnorarTravaMargemDoCliente(strCodCli)) Then
      blnMostrarMensagem := False;

    If blnMostrarMensagem Then
      fMensagem('ATENÇÃO!', 'Condição de Pagamento não permitida. Valor/Margem da venda está fora do limite mínimo/máximo cadastrado para esta condição!', ['&O k'])
  End
  Else
    fMensagem('ATENÇÃO!', 'Essa condição não está cadastrada!', ['&O k']);
end;

function TfraDigCndPagamento.fExibeAlertaDeNaoUtilizacaoDeCredito(
  strCodCli: String): Boolean;
begin
  Result := False;

  If fMostraCreditoComPortador(strCodCli) Then
    Exit;

  If fCampoTabela('CND_CODFPG', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text]) = '013' Then
    Result := True;
end;

function TfraDigCndPagamento.fExisteCndPagCad: Boolean;
begin
  Result := Not fEmptyStr(fCampoTabela('CND_CODIGO', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text]));
end;

function TfraDigCndPagamento.fFormasEnvioLinkPagamento(const AstrCodCnd: String; var AstrMsgOperador : String): Boolean;
var
  LFormaEnvio: TOpcaoRetorno ;
  LstrMeioEnvioSelecionado: String ;
  LstrEspDoc: String ;
  LstrCodFpg: String ;
begin
  Result := True ;
  AstrMsgOperador := '' ;

  Self.LinkPgtFormaEnvio   := '' ;
  Self.LinkPgtDestinatario := '' ;
  Self.FblnLinkPgtJaIndicado := False ;
  LstrEspDoc := FstrEspDoc ;
  if Assigned(fatVenda) then
    if fatVenda.strEspDoc = 'PD' then
      LstrEspDoc := fatVenda.strEspDoc
    else
      LstrEspDoc := fatVenda.strOpcDoc ;

  LstrCodFpg := fCampoTabela('CND_CODFPG', 'CADCND', ['CND_CODIGO'], [AstrCodCnd], False) ;

  if not fVerificaEnviaLinkPagtoOnline(LstrEspDoc,
                                       LstrCodFpg,
                                       AstrCodCnd) then
    Exit ;

  if not fEscolheFormaEnvio(LFormaEnvio,
                            LstrMeioEnvioSelecionado,
                            AstrMsgOperador,
                            strCodCli) then
    Exit(False) ;

  Self.LinkPgtFormaEnvio   := ArrayOpcaoRetorno[LFormaEnvio] ;
  Self.LinkPgtDestinatario := LstrMeioEnvioSelecionado ;
  Self.FblnLinkPgtJaIndicado := True ;
end;

function TfraDigCndPagamento.fMudouCliDoPedOrcComSugCndPagDiferente: Boolean;
begin
  If Not Assigned(fatVenda) Then
    Result := False
  Else
    Result := fatVenda.fMudouCliDoPedOrcComSugCndPagDiferente;
end;

procedure TfraDigCndPagamento.pCarregaForPag;
begin
  If Not Assigned(qryConFpg) Then
    qryConFpg := fCriaQuery(Self);

  pPesquisaCadFpg(qryConFpg, qryConFpg, edtForPag.Text);
  edtDesForPag.Text := qryConFpg.FieldByName('FPG_DESCRI').AsString;
end;

procedure TfraDigCndPagamento.pAtribuiTabelas;
  Var
    blnLibCnd: Boolean;
    strSQL: String;
Begin
  strSQL := ' SELECT CADCND.*, ';

  If (fCfgSis('PFLCLI') = 'S') And
     (fCfgSis('CNDVEN') = 'F') Then
  Begin
    If (fCfgSis('LIBCND') = '1')            And
       ((fltMarDoc > 0) Or (fltValDoc > 0)) Then
      blnLibCnd := True
    Else
      blnLibCnd := False;
  End
  Else
    blnLibCnd := True;

  If blnLibCnd Then
    strSQL := strSQL + ' 0 AS SUB_PERCND '
  Else
    strSQL := strSQL + fRetornaSubQueryFaixasForaCondicao(fltMarDoc, fltValDoc, blnIgnMar) + ' AS SUB_PERCND ';

  strSQL := strSQL + ' FROM CADCND WHERE FALSE ';
  qryCadCnd := fCriarQuery(strSQL, Self);
  qryConCnd := qryCadCnd;
End;


procedure TfraDigCndPagamento.mskCndPagEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskCndPag.Text) Then
    mskCndPag.EditMask := MASK_CONPAG2;
end;

procedure TfraDigCndPagamento.mskCndPagKeyPress(Sender: TObject;
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

procedure TfraDigCndPagamento.mskCndPagKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If fEmptyStr(mskCndPag.Text) Then
    mskCndPag.EditMask := MASK_CONPAG2;

end;

procedure TfraDigCndPagamento.OnFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Not blnPodeCancelar) And (Not blnConfirma) Then
    Action := caNone
  Else
  Begin
    If Assigned(stlForPag) Then
      FreeAndNil(stlForPag);
    If Assigned(stlCndPag) Then
      FreeAndNil(stlCndPag);
    if Assigned(objLiberacao) then
      FreeAndNil(objLiberacao);
  End;
end;

procedure TfraDigCndPagamento.mskCndPagExit(Sender: TObject);
begin
  inherited;

  pMostraOpcZerarTaxJuros;

end;

procedure TfraDigCndPagamento.pMostraOpcZerarTaxJuros;
begin
  {**************************************}
  { SE FOR AVISTA, MOSTRA OPCAO DE ZERAR }
  { TAXA DE JUROS                        }
  {***********************************JB*}
  If blnHabZta Then
  Begin
    chkZerTax.Visible := fStatusCndPag(mskCndPag.Text) = A_PRAZO;
  End;

end;

procedure TfraDigCndPagamento.SetLinkPgtDestinatario(const Value: String);
begin
  FstrLinkPgtDestinatario := Value;
  if Assigned(fatVenda) then
    fatVenda.strLinkPgtDestinatario := FstrLinkPgtDestinatario ;
end;

procedure TfraDigCndPagamento.SetLinkPgtFormaEnvio(const Value: String);
begin
  FstrLinkPgtFormaEnvio := Value;
  if Assigned(fatVenda) then
    fatVenda.strLinkPgtFormaEnvio := FstrLinkPgtFormaEnvio ;
end;

procedure TfraDigCndPagamento.ValidacoesCondicaoPagamentoPix;
var
  LAutoIncremChavePix: String;
begin
  fatVenda.DadosPixDaVenda.GerarPixDaVenda := False;
  If fCfgSis('USAPIX', varBoolean) Then
    fatVenda.DadosPixDaVenda.GerarPixDaVenda := qryConCnd.FieldByName('CND_RECPIX').AsString = 'S';

  If Not MatchStr(fatVenda.strOpcDoc, ['CP', 'VN', 'CF', 'CI']) Then
  begin
    lblPagamentoPix.Visible := fatVenda.DadosPixDaVenda.GerarPixDaVenda And
                               (Not MatchStr(fatVenda.strOpcDoc, ['CF', 'OR']));
    LAutoIncremChavePix := fCfgSis('CHAPIX');
    if TPixDao.ChavePixUtilizaTefScope(LAutoIncremChavePix) = 'S' then
      lblPagamentoPix.Caption := 'O QR Code Pix será gerado somente ao finalizar o pagamento.';
  end
  Else
  Begin
    If Not fatVenda.DadosPixDaVenda.TxIdPix.IsEmpty Then
    Begin
      If Not fatVenda.DadosPixDaVenda.AlterarCondicaoDePagamento Then
      Begin
        edtCodCnd.Enabled := False;
        mskCndPag.Enabled := False;

        lblPagamentoPix.Visible := False;
      End;
    End
    Else
    Begin
      lblPagamentoPix.Visible := MatchStr(Concat(qryConCnd.FieldByName('CND_RECPIX').AsString, fatVenda.strOpcDoc),['SVN', 'SCF', 'SCP']);

      fatVenda.DadosPixDaVenda.AlterarCondicaoDePagamento := Not MatchStr(fatVenda.strOpcDoc, ['VN', 'OR', 'CP', 'CF']);

      If MatchStr(fatVenda.strOpcDoc, ['VN', 'CP', 'CF']) Then
      Begin
        If Assigned(fatVenda.DadosPixDaVenda.ObjetoPixPago) Then
        Begin
          If TFuncoesPix.VerificaPixComStatusConcluidoEComValorPago(fatVenda.DadosPixDaVenda.ObjetoPixPago) Then
          Begin
            edtCodCnd.Enabled := False;
            mskCndPag.Enabled := False;
            edtForPag.Enabled := False;
            chkZerTax.Enabled := False;
            chkZerTax.OnClick := nil ;
            try
              chkZerTax.Checked := fatVenda.blnZerTax ;
            finally
              chkZerTax.OnClick := chkZerTaxClick ;
            end ;
          End;
        End;
      End;
    End;
  End;

  If fCfgSis('F11ORD', varString) = 'O' Then
  Begin
    If blnRcx_F3 Then
      lblPagamentoPix.Visible := False;
  End;

  pAjustaPosicoesPnlChecks;
end;

procedure TfraDigCndPagamento.pAjustaPosicoesPnlChecks();
const intPosIni = 108;
begin
  chkZerTax.Left := intPosIni;
  chkManPre.Left := intPosIni;
  lblPagamentoPix.Left := intPosIni;

  If (lblPagamentoPix.Visible) And (chkZerTax.Visible) And (chkManPre.Visible) Then
  Begin
    lblPagamentoPix.Left := 2;
    chkZerTax.Left := lblPagamentoPix.Left + lblPagamentoPix.Width;
    chkManPre.Left := chkZerTax.Left + chkZerTax.Width;
  End
  Else If (chkZerTax.Visible) And (lblPagamentoPix.Visible) Then
    chkZerTax.Left := lblPagamentoPix.Left + lblPagamentoPix.Width
  Else If (chkZerTax.Visible) And (chkManPre.Visible) Then
    chkManPre.Left := chkZerTax.Left + chkZerTax.Width
  Else If (lblPagamentoPix.Visible) And (chkManPre.Visible) Then
    chkManPre.Left := lblPagamentoPix.Left + lblPagamentoPix.Width;
end;

procedure TfraDigCndPagamento.chkManPreClick(Sender: TObject);
begin
  inherited;

  If chkManPre.Checked Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Baixa de Empréstimo - Manter os Preços na Geração do FF');

    objLiberacao.strDirAce := 'BAIEMPMP';
    objLiberacao.strMsgSen := 'Baixa de Empréstimo - Manter os Preços na Geração do FF';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    If Assigned(fatVenda) Then
      objLiberacao.strSequencialUnicoDtaHra := fatVenda.FSequencialUnicoDtaHrLogVar;

    If Not fMensagemLiberacao(objLiberacao, strNTrava, stlNumLib) Then
    Begin
      chkManPre.Checked := False;
    End;
  End;

  pAjustaPosicoesPnlChecks;

end;

procedure TfraDigCndPagamento.chkZerTaxClick(Sender: TObject);
begin
  inherited;

  If chkZerTax.Checked Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Zerar Taxa de Juros - necessário digitação de senha para liberação!');
    objLiberacao.objMsgLibera.pAddSeparador(65);
    objLiberacao.objMsgLibera.pAddTextoCaption('Condição de Pagamento', edtCodCnd.Text + '-' + fatVenda.strDesCnd + StringOfChar(' ', 15), 21);
    objLiberacao.objMsgLibera.pAddTextoCaption('Forma de Pagamento', (fatVenda.strCodFpg+'-'+edtDesForPag.Text), 21);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor desta Venda', FormatFloat('#,##0.00', fatVenda.fltTotGer) , 21);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', fatVenda.strCodCli + '-' + Copy(fatVenda.strCliNom,1,65), 21);
    objLiberacao.objMsgLibera.pAddTextoCaption('Nome Fantasia', fRetNomFantasia(fatVenda.strCodCli), 21);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ', fFormataCpfCgc(fatVenda.strCliCgc, fSetaPais), 21);
    objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor', fatVenda.strCodVen + '-' + Copy(fatVenda.strNomVen,1,70), 21);
    objLiberacao.objMsgLibera.pAddSeparador(65);

    objLiberacao.strDirAce := 'SENZTA';
    objLiberacao.strSenLib := '';
    objLiberacao.strMsgSen := 'Liberação para Zerar Taxa de Juros';
    objLiberacao.strCodOpe := strCodVen;
    objLiberacao.strCodDig := strCodDig;

    If Assigned(fatVenda) Then
      objLiberacao.strSequencialUnicoDtaHra := fatVenda.FSequencialUnicoDtaHrLogVar;

    If Not fMensagemLiberacao(objLiberacao, strNTrava, stlNumLib) Then
    Begin
      fMensagem('','Senha para Zerar Taxa de Juros incorreta!',['&OK']);
      chkZerTax.Checked := False;
    End;
  End
  Else
  Begin
    If Assigned(fatVenda) Then
    Begin
      pRemoverTravaLogAvi('SENZTA', strNTrava);
    End;
  End;
end;

function TfraDigCndPagamento.fUsaTipodeCliente: Boolean;
begin
  Result := False;

  If (fCfgSis('USATPC') = 'S') Then
  Begin
     If Assigned(fatVenda) Then
     Begin
       Result := (Not fatVenda.fDocumentoParaFornecedor);
     End
     Else
        Result := True;
  End;

end;

procedure TfraDigCndPagamento.pAtualizaMargemTotalDocumento;
begin
  If (fVerificaSeAtualizaMargemTotalDocumento()) Then
  Begin
    fltMarDoc := fatVenda.fRetornaMargemPraticadaDocumento(blnIgnMar);
    fltValDoc := fatVenda.fltTotGer;
  End;
end;

function TfraDigCndPagamento.fManterCondicaoDePagamentoDoClienteOriginal: Boolean;
begin
  Result := ((Not fMudouCliDoPedOrcComSugCndPagDiferente) And (Not fEmptyStr(fatVenda.strNumOrc)) And (fatVenda.fCarregaCondicaoPedido));

  If Result Then
    Result := not fEmptyStr(fCampoTabela('CND_CODCND', 'CLICND', ['CND_CODCLI', 'CND_CODCND'], [fatVenda.strCodCli, fatVenda.strCodPagOri]));

end;

function TfraDigCndPagamento.fVerificaVinculoCondicaoPagtoComPerfilCliente(ACodigoCliente: String): Boolean;
begin
  Result := True;

  If fEmptyStr(ACodigoCliente) Then
    Exit;

  If Not blnTelaAgrupamento Then
    Exit;

  If Not fCfgSis('PERAGR', varBoolean) Then
    Exit;

  Result := fCondicaoPagtoVinculadoAoCliente(ACodigoCliente);
end;

function TfraDigCndPagamento.fCondicaoPagtoVinculadoAoCliente(ACodigoCliente: String): Boolean;
var
  LConsulta: TUniQuery;
  LUsaCadastroCondicaoPagto: Boolean;
  LCondicaoPagto: String;
begin
  Result := True;
  LUsaCadastroCondicaoPagto := fCfgSis('USACND', varBoolean);

  If LUsaCadastroCondicaoPagto Then
  Begin
    If fEmptyStr(edtCodCnd.Text) Then
      Exit;
  End
  Else
  Begin
    LCondicaoPagto := fTiraCaracEspeciais(mskCndPag.Text, True, True, True);
    If fEmptyStr(LCondicaoPagto) Then
      Exit;
  End;

  LConsulta := Nil;
  Try
    LConsulta := fCriaQuery;

    If LUsaCadastroCondicaoPagto Then
    Begin
      LConsulta.SQL.Add('SELECT 1 FROM CLICND WHERE CND_CODCLI = :CODCLI AND CND_CODCND = :CODCND');
      LConsulta.ParamByName('CODCND').AsString := edtCodCnd.Text;
    End
    Else
    Begin
      LConsulta.SQL.Add('SELECT 1 FROM CLICND WHERE CND_CODCLI = :CODCLI AND CND_CNDPAG = :CNDPAG');
      LConsulta.ParamByName('CNDPAG').AsString := LCondicaoPagto;
    End;
    LConsulta.ParamByName('CODCLI').AsString := ACodigoCliente;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.
