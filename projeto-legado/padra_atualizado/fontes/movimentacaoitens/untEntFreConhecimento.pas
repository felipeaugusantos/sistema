{*********************************************************}
{* CADASTRO DE FRETE DE CONHECIMENTO                     *}
{*                                                       *}
{* DATA......: 31/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untEntFreConhecimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, untEntFreCon,
  EditFocus, Mask, DBCtrls, DBEditFocus, MaskEditFocus, DB, Uni,
  AppEvnts,  ComCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, BitBtnLockedIncrem, typInfo,
  Math, cxCheckBox, MemoFocus, untTypesSistema,  untZClient,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade, ComboBoxFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCurrencyEdit,
  untFrameCentroCustoEditFocus, cxGridBandedTableView, cxGridDBBandedTableView,
  cxTextEdit, untFramePlanoDeContasMaskEdit, untFrameCtaPagar, ContaPagar.TFrameCtaPagar , untFraPessoasCte;

type
  TfrmEntFreConhecimento = class(TfrmPai)
    pgcFrete: TPageControl;
    tbsFrete: TTabSheet;
    tbsNotas: TTabSheet;
    pnlNotas: TPanel;
    Label11: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtSerEnt: TEditFocus;
    edtEspEnt: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtNotEnt: TEditFocus;
    cxgNotas: TcxGrid;
    cxgNotasView: TcxGridDBTableView;
    cxgNotasViewDtaEnt: TcxGridDBColumn;
    cxgNotasViewColumn1: TcxGridDBColumn;
    cxgNotasViewColumn2: TcxGridDBColumn;
    cxgNotasViewColumn3: TcxGridDBColumn;
    cxgNotasViewColumn4: TcxGridDBColumn;
    cxgNotasViewColumn5: TcxGridDBColumn;
    cxgNotasVLRCON: TcxGridDBColumn;
    cxgNotasLevel1: TcxGridLevel;
    pnlDados: TPanel;
    pnlTopo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblCliFor: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodTra: TEditFocus;
    edtDesTra: TEditFocus;
    mskDtaEnt: TMaskEditFocus;
    mskDtaDoc: TMaskEditFocus;
    mskConPag: TMaskEditFocus;
    pnlPortador: TPanel;
    Label31: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    pnlClassificacoes: TPanel;
    bvlSeparador1: TBevel;
    bvlSeparador2: TBevel;
    bvlSeparador3: TBevel;
    bvlSeparador4: TBevel;
    bvlSeparador5: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    edtClaFi1: TEditFocus;
    edtClaFi2: TEditFocus;
    edtClaFi3: TEditFocus;
    edtClaFi4: TEditFocus;
    edtClaFi5: TEditFocus;
    edtValCo1: TEditFocus;
    edtValCo2: TEditFocus;
    edtValCo3: TEditFocus;
    edtValCo4: TEditFocus;
    edtValCo5: TEditFocus;
    edtValCoT: TEditFocus;
    edtBasIc1: TEditFocus;
    edtBasIc2: TEditFocus;
    edtBasIc3: TEditFocus;
    edtBasIc4: TEditFocus;
    edtBasIc5: TEditFocus;
    edtBasIcT: TEditFocus;
    edtAlqIc1: TEditFocus;
    edtAlqIc2: TEditFocus;
    edtAlqIc3: TEditFocus;
    edtAlqIc4: TEditFocus;
    edtAlqIc5: TEditFocus;
    edtAlqIcT: TEditFocus;
    edtValIc1: TEditFocus;
    edtValIc2: TEditFocus;
    edtValIc3: TEditFocus;
    edtValIc4: TEditFocus;
    edtValIc5: TEditFocus;
    edtValIcT: TEditFocus;
    edtValIs1: TEditFocus;
    edtValIs2: TEditFocus;
    edtValIs3: TEditFocus;
    edtValIs4: TEditFocus;
    edtValIs5: TEditFocus;
    edtValIsT: TEditFocus;
    edtBasSu1: TEditFocus;
    edtBasSu2: TEditFocus;
    edtBasSu3: TEditFocus;
    edtBasSu4: TEditFocus;
    edtBasSu5: TEditFocus;
    edtBasSuT: TEditFocus;
    edtValRe1: TEditFocus;
    edtValRe2: TEditFocus;
    edtValRe3: TEditFocus;
    edtValRe4: TEditFocus;
    edtValRe5: TEditFocus;
    edtValReT: TEditFocus;
    edtDesAc1: TEditFocus;
    edtDesAc2: TEditFocus;
    edtDesAc3: TEditFocus;
    edtDesAc4: TEditFocus;
    edtDesAc5: TEditFocus;
    edtDesAcT: TEditFocus;
    edtBasIp1: TEditFocus;
    edtBasIp2: TEditFocus;
    edtBasIp3: TEditFocus;
    edtBasIp4: TEditFocus;
    edtBasIp5: TEditFocus;
    edtBasIpT: TEditFocus;
    edtValIp1: TEditFocus;
    edtValIp2: TEditFocus;
    edtValIp3: TEditFocus;
    edtValIp4: TEditFocus;
    edtValIp5: TEditFocus;
    edtValIpT: TEditFocus;
    edtValOu1: TEditFocus;
    edtValOu2: TEditFocus;
    edtValOu3: TEditFocus;
    edtValOu4: TEditFocus;
    edtValOu5: TEditFocus;
    edtValOuT: TEditFocus;
    btnGravar: TBitBtnLocked;
    btnAltVal: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    lblBasAnt: TLabel;
    lblValAnt: TLabel;
    edtAntIc1: TEditFocus;
    edtBasAn1: TEditFocus;
    edtBasAn2: TEditFocus;
    edtAntIc2: TEditFocus;
    edtAntIc3: TEditFocus;
    edtBasAn3: TEditFocus;
    edtBasAn4: TEditFocus;
    edtAntIc4: TEditFocus;
    edtAntIc5: TEditFocus;
    edtBasAn5: TEditFocus;
    edtBasAnT: TEditFocus;
    edtAntIcT: TEditFocus;
    Label32: TLabel;
    edtChaveAcesso: TEditFocus;
    btnAbreXmlCte: TBitBtnLocked;
    Label33: TLabel;
    btnOutDes: TBitBtnLocked;
    tbsItens: TTabSheet;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensREFERE: TcxGridDBColumn;
    cxgItensUNIDAD: TcxGridDBColumn;
    cxgItensCODCST: TcxGridDBColumn;
    cxgItensANTPRO: TcxGridDBColumn;
    cxgItensANTFRE: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    prbProgresso: TProgressBar;
    cxgItensNUMDOC: TcxGridDBColumn;
    lblTipFre: TLabel;
    cbbTipFre: TComboBoxFocus;
    chkImprCp: TCheckBox;
    chkGravarFinanceiro: TCheckBox;
    btnCfgPis: TBitBtnLocked;
    btnCfgCof: TBitBtnLocked;
    lblPerRep: TLabel;
    edtPerRep: TEditFocus;
    cxgNotasPERREP: TcxGridDBColumn;
    btnBarBol: TBitBtnLocked;
    tbsRateioFrete: TTabSheet;
    cxgProdutosLevel1: TcxGridLevel;
    cxgProdutos: TcxGrid;
    cxvProdutos: TcxGridDBBandedTableView;
    cxvProdutosColumn1: TcxGridDBBandedColumn;
    cxvProdutosColumn2: TcxGridDBBandedColumn;
    cxvProdutosPERFRE: TcxGridDBBandedColumn;
    cxvProdutosColumn4: TcxGridDBBandedColumn;
    cxvProdutosColumn5: TcxGridDBBandedColumn;
    cxvProdutosColumn6: TcxGridDBBandedColumn;
    cxvProdutosColumn7: TcxGridDBBandedColumn;
    cxvProdutosColumn8: TcxGridDBBandedColumn;
    cxvProdutosColumn9: TcxGridDBBandedColumn;
    cxsRepositorio: TcxStyleRepository;
    cxsZebra: TcxStyle;
    cxvProdutosNUMDOC: TcxGridDBBandedColumn;
    cxsTotal: TcxStyle;
    Panel1: TPanel;
    Label35: TLabel;
    edtPerFreNota: TEditFocus;
    Label36: TLabel;
    cxvProdutosVALFRE: TcxGridDBBandedColumn;
    edtValorFreNota: TEditFocus;
    Label7: TLabel;
    Label37: TLabel;
    edtValDoc: TEditFocus;
    Label8: TLabel;
    cbxCODMOD: TComboBoxFocus;
    Label34: TLabel;
    fraCtaPagar: TfraCtaPagar;
    tbsPessoas: TTabSheet;
    pnlContainerPessoas: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtClaFi1KeyPress(Sender: TObject; var Key: Char);
    procedure edtValIc1Enter(Sender: TObject);
    procedure edtValIc2Enter(Sender: TObject);
    procedure edtValIc3Enter(Sender: TObject);
    procedure edtValIc4Enter(Sender: TObject);
    procedure edtValIc5Enter(Sender: TObject);
    procedure btnAltValClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure tbsFreteEnter(Sender: TObject);
    procedure tbsNotasEnter(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbreXmlCteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOutDesClick(Sender: TObject);
    procedure edtNotEntExit(Sender: TObject);
    procedure edtNumDocExit(Sender: TObject);
    procedure btnCfgPisClick(Sender: TObject);
    procedure btnCfgCofClick(Sender: TObject);
    procedure edtClaFi1Exit(Sender: TObject);
    procedure btnBarBolClick(Sender: TObject);
    procedure mskConPagExit(Sender: TObject);
    procedure edtValDocExit(Sender: TObject);
    procedure edtChaveAcessoExit(Sender: TObject);
    procedure chkGravarFinanceiroClick(Sender: TObject);
    procedure cxvProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure cbbTipFreChange(Sender: TObject);
    procedure pgcFreteChange(Sender: TObject);
    procedure cxvProdutosTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxvProdutosEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure fraCtaPagaredtCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraCtaPagarMemHistoKeyPress(Sender: TObject; var Key: Char);
    procedure fraCtaPagaredtVeioboClick(Sender: TObject);
    procedure fraCtaPagaredtCodEveKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryCadCta: TUniQuery;
    fraPessoasCTE: TfraPessoasCTE;
    qryCadFor: TUniQuery;
    objFrameCtaPagar: TFrameContaPagar;
    cdsCTEAnteriores: TZClient;

    intRatFre,
    intPaginasAtivas: Integer;

    fltFreteOriginal,
    fltOutDes: Double;

    blnCTPBOL: Boolean;

    Function fTotalFrete: Double;

    function fValidaCamposNotas(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    Function fVerificaOutrasDespesas: Boolean;

    function fRetSomaFreteConhecimentoDigitados(DataSet: TDataSet): Double;

    procedure pCarregaCentroCusto;
    procedure pCarregaDados;
    procedure pCarregaFornecedor;
    Procedure pLimpaDadosNota;
    procedure pGravaDados;

    procedure pCarregaDadosAntecipacao;
    procedure pLimpaPanel(pnlDadosItem: TPanel);

    procedure pHabilitaCodBarras;
    procedure pHabilitaDuplicatas;
    procedure pAtualizaPortador(blnBuscaPorChave : boolean);

    procedure pHabilitaDadosFrete;

    procedure pCalculaPercentualEquivalFrete;

    function fValidaValorTotalFrete: Boolean;
    procedure pTrataCamposICMS;

  public
    { Public declarations }

    objFreCon: TFreCon;

    // Antecipação no Frete do Conhecimento
    fltMaxIVA,
    fltAntIcT,
    fltBasAnT : Double;

    blnAlteracao: Boolean;

    //arrDuplicata: TarrDuplicataPointer;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmEntFreConhecimento: TfrmEntFreConhecimento;

implementation

uses untFuncoesSimples, untPesqAux, untCadCta, untConsultas, untDigCodBarBoleto, untConstantes,
     untFuncoes, untEntOutrasDespesas, untEntIcmsAntecipado, untDuplicatas,
  untTGerenciaModeloPermitidos;

{$R *.dfm}

{ TfrmEntFreConhecimento }

Const
  INDEX_TIPO_DIGITACAO_PERCENTUAL = 3;

  function TfrmEntFreConhecimento.fValidaValorTotalFrete: Boolean;
  Begin
    Result:= True;
    If (cbbTipFre.ItemIndex = 3) Then //Item = Informar os Percetuais por Item
      Result:= fStrToFloat(edtValDoc.Text) = fStrToFloat(edtValorFreNota.Text);
  End;

function TfrmEntFreConhecimento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  function fValidaData(strData : String): Boolean;
  Begin
    Result := (StrToDateDef(strData,0) > 0);

    if not Result then
      fMensagem('','A data informada não é uma data válida', ['&OK']);
  End;

  Var
    strCndPag: String;
Begin

  {***************************************}
  {* ESTOU UTILIZANDFO ESTE METODO PARA  *}
  {* ATRIBUIR DADOS PARA OS ATRIBUTOS DA *}
  {* CLASSE                              *}
  {************************************AF*}
  Result := True;

  Try
    If Not(fEmptyStr(edtValorFreNota.Text)) Then
    Begin
      If Not(fValidaValorTotalFrete) Then
      Begin
        fMensagem('','Total do Frete está diferente do Vlr. Total Conhecimentos Digitados!', ['&OK']);
        Result := False;
        Exit;
      End;
    End;

    If (Sender = edtNumDoc) Then
      objFreCon.strNumDoc := edtNumDoc.Text

    Else If (Sender = edtSerie) Then
      objFreCon.strSerie_ := edtSerie.Text


    Else If (Sender = fraCtaPagar.edtVeioNF) Then
      objFreCon.strVeioNF := fraCtaPagar.edtVeioNF.Text

    Else If (Sender = fraCtaPagar.edtUsaChq) Then
      objFreCon.strUsaChq := fraCtaPagar.edtUsaChq.Text

    Else If (Sender = fraCtaPagar.edtPrevis) Then
      objFreCon.strPrevis := fraCtaPagar.edtPrevis.Text

    Else If (Sender = fraCtaPagar.edtPagAnt) Then
      objFreCon.strPagAnt := fraCtaPagar.edtPagAnt.Text

    Else If (Sender = fraCtaPagar.edtUsoCon) Then
      objFreCon.strUsoCon := fraCtaPagar.edtUsoCon.Text

    Else If (Sender = fraCtaPagar.edtTipDoc) Then
      objFreCon.strTipDoc := fraCtaPagar.edtTipDoc.Text

    Else If (Sender = fraCtaPagar.LcbGuiaTributo) Then
      objFreCon.strGuiTri := IIF((fraCtaPagar.LcbGuiaTributo.KeyValue = Null),'0',fraCtaPagar.LcbGuiaTributo.KeyValue)

    Else If (Sender = fraCtaPagar.LcbTipoTributo) Then
      objFreCon.strTipTri := IIF((fraCtaPagar.LcbTipoTributo.KeyValue = Null),' ',fraCtaPagar.LcbTipoTributo.KeyValue)

    Else If (Sender = fraCtaPagar.edtDeposi) Then
      objFreCon.strDeposi := fraCtaPagar.edtDeposi.Text

    Else If (Sender = fraCtaPagar.cbxBcoFor) Then
      objFreCon.strBcoFor := IIF(fEmptyStr(fraCtaPagar.strBcoFor),objFreCon.strBcoFor,fraCtaPagar.strBcoFor)


    Else If (Sender = edtEspDoc) Then
      objFreCon.strEspDoc := edtEspDoc.Text

    Else If (Sender = cbxCODMOD) Then
      objFreCon.strModelo := cbxCODMOD.Text

    Else If (Sender = edtCodTra) Then
    Begin
      pCarregaFornecedor;
      objFreCon.strCodTra := edtCodTra.Text;

      If fEmptyStr(edtDesTra.Text) And (Not fEmptyStr(edtCodTra.Text)) Then
      Begin
        fMensagem('','Transportadora não encontrada!', ['&OK']);
        Result := False;
      End
      Else

      If objFreCon.strEntDoc <> '' Then
      Begin
        If (objFreCon.strEntDoc = edtNumDoc.Text) And (objFreCon.strEntFor = edtCodTra.Text) And (objFreCon.strEntSer = edtSerie.Text) Then
        begin
          fMensagem('','O Número do Documento, Série e Transportadora não devem ser iguais ao Número de Documento da Entrada, Série de Entrada e Código do Fornecedor da Entrada!', ['&OK']);
          Result := False;
        End;
      End;

      if Result then
      begin
        objFreCon.objPortadorFornecedor.strCodFor := edtCodTra.Text;
        pAtualizaPortador(blnBuscaPorChave);


        objFrameCtaPagar.strCodigo_Fornecedor    := edtCodTra.Text;
        objFrameCtaPagar.pCarregaDadosBancariosFornecedor;
        objFrameCtaPagar.pPosicionaContaFornecedor(objFreCon.strBcoFor);
      end;


    End

    Else If (Sender = mskConPag) Then
    Begin
      If fValidaCndPag(mskConPag.Text, strCndPag, StrToDateDef(mskDtaDoc.Text, VS_Date)) Then
      Begin
        mskConPag.Text      := strCndPag;
        objFreCon.strCndPag := strCndPag
      End

      Else
      Begin
        fMensagem('','Essa condição de pagamento não é valida!', ['&OK']);
        Result := False;
      End;
      //Habilita o campo apenas se o Condição de pagamento for a vista
      chkGravarFinanceiro.Enabled := mskConPag.Text = '01000';
      // Se for a Prazo
      If mskConPag.Text <> '01000' Then
        chkGravarFinanceiro.Checked := mskConPag.Text <> '01000';

      If blnBuscaPorChave And Result Then
        pHabilitaCodBarras;
    End

    Else If (Sender = fraCtaPagar.edtCodCta) Then
    Begin
      If Not fCfgSis('USACTF', varBoolean) Then
      Begin
        objFreCon.strCodCta := fraCtaPagar.edtCodCta.Text;
        fraCtaPagar.edtNomCta.Text      := objFreCon.strDesCta;
      End
      Else
      Begin
        objFreCon.strCodCta := fraCtaPagar.edtCodCta.Text;
        pCarregaCentroCusto;
      End;

      If fEmptyStr(fraCtaPagar.edtNomCta.Text) And (Not fEmptyStr(fraCtaPagar.edtCodCta.Text)) Then
      Begin
        If Not fCfgSis('USACTF', varBoolean) Then
          fMensagem('','Conta não encontrada!', ['&OK'])
        Else
          fMensagem('','Conta não encontrada ou não vinculada à transportadora!', ['&OK']);
          
        Result := False;
      End

      Else If (Not fValidaLinhaGrupoCadCta(fraCtaPagar.edtCodCta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
        Result := False;
      End

      Else If Not PlanoDeContasAtivo(fraCtaPagar.edtCodCta.Text) Then
        Result := False;

    End

    Else If (Sender = fraCtaPagar.edtCodEve) Then
    Begin

      If fEmptyStr(fraCtaPagar.edtCodEve.Text) Then
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;
       fraCtaPagar.edtDesEve.Clear;
      End Else
      Begin
       fraCtaPagar.edtDesEve.Text := fRetNomEvento(fraCtaPagar.edtCodEve);

        If fEmptyStr(fraCtaPagar.edtDesEve.Text) Then
        Begin
          pMensagemOk('Centro de Custos não encontrado!');
          Result := False;
        End;
      End;

      objFreCon.strCodEve := fraCtaPagar.edtCodEve.Text;
    End

    Else If (Sender = fraCtaPagar.MemHisto) Then
      objFreCon.strHis001 := fraCtaPagar.MemHisto.Text

    Else If (Sender = edtValDoc) Then
    Begin
      objFreCon.strValDoc := edtValDoc.Text;

      If blnBuscaPorChave And Result Then
        pHabilitaCodBarras;
    End

    Else If (Sender = edtChaveAcesso) Then
      objFreCon.strAcesso := edtChaveAcesso.Text

    Else If (Sender = mskDtaEnt) Then
    Begin
      Result := fValidaData(mskDtaEnt.Text);
      if Result then
        objFreCon.strDtaEnt := mskDtaEnt.Text;
    End
    Else If (Sender = mskDtaDoc) Then
    Begin
      Result := fValidaData(mskDtaDoc.Text);
      if Result then
        objFreCon.strDtaDoc := mskDtaDoc.Text
    End
    Else If (Sender = edtCodPor) And pnlPortador.Visible Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        pMensagemOk('Informe o código do portador para o Contas a Pagar!');
        Result := False;
      End Else
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          pMensagemOk('Portador não econtrado!');
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA COMPETENCIA                    *}
    {**************************************PA*}
    Else If (Sender = fraCtaPagar.edtCompet) And (fraCtaPagar.edtCompet.Enabled)  then
    Begin
      If not fValidaDataStr('01/'+ fraCtaPagar.edtCompet.Text) Then
      Begin
        pMensagemOk('Data informada na Competência não é válida!');
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(fraCtaPagar.edtCompet.Text)) Then
      Begin
        pMensagemOk('A Competência deve ser preenchida!');
        Result := False;
      End

    End

    {**************************************}
    {* 1 - CLASSIFICAÇÃO                  *}
    {***********************************AF*}
    Else If (Sender = edtClaFi1) Then
    Begin

      If pnlClassificacoes.Enabled Then
      Begin
        If Not TGerenciaModeloPermitidos.fModeloPermitidoParaCFOP(edtClaFi1.Text, cbxCODMOD.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Classificação Fiscal '+edtClaFi1.Text+' não pode ser utlizada no modelo '+cbxCODMOD.Text+'!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          objFreCon.strClaFi1 := edtClaFi1.Text;

          If blnBuscaPorChave Then
          Begin
            blnMudarFoco := False;
            pSetFocus(edtValCo1);
          End;
        End;
      End;

    End

    Else If (Sender = edtValCo1) Then
    Begin
      If pnlClassificacoes.Enabled Then
        objFreCon.strValCo1 := edtValCo1.Text;
    End

    Else If (Sender = edtBasIc1) Then
      objFreCon.strBasIc1 := edtBasIc1.Text

    Else If (Sender = edtAlqIc1) Then
      objFreCon.strAlqIc1 := edtAlqIc1.Text

    Else If (Sender = edtValIc1) Then
      objFreCon.strValIc1 := edtValIc1.Text

    Else If (Sender = edtValOu1) Then
      objFreCon.strValOu1 := edtValOu1.Text

    Else If (Sender = edtValIs1) Then
      objFreCon.strValIs1 := edtValIs1.Text

    Else If (Sender = edtValRe1) Then
      objFreCon.strValRe1 := edtValRe1.Text

    Else If (Sender = edtBasIp1) Then
      objFreCon.strBasIp1 := edtBasIp1.Text

    Else If (Sender = edtValIp1) Then
      objFreCon.strValIp1 := edtValIp1.Text

    Else If (Sender = edtBasSu1) Then
      objFreCon.strBasSu1 := edtBasSu1.Text

    Else If (Sender = edtDesAc1) Then
      objFreCon.strDesAc1 := edtDesAc1.Text

    {**************************************}
    {* 2 - CLASSIFICAÇÃO                  *}
    {***********************************AF*}
    Else If (Sender = edtClaFi2) Then
    Begin
      objFreCon.strClaFi2 := edtClaFi2.Text;

      If fEmptyStr(edtClaFi2.Text) And pnlClassificacoes.Enabled And blnBuscaPorChave Then
      Begin
        If Not TGerenciaModeloPermitidos.fModeloPermitidoParaCFOP(edtClaFi2.Text, cbxCODMOD.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Classificação Fiscal '+edtClaFi2.Text+' não pode ser utlizada no modelo '+cbxCodMod.Text+'!', ['&Ok']);
          Result := False;
        End
        Else
        Begin

          If pgcFrete.Visible Then
            pgcFrete.ActivePage := tbsFrete;

          pSetFocus(edtClaFi3);
          blnMudarFoco := False;
        End;
      End;
    End

    Else If (Sender = edtValCo2) Then
      objFreCon.strValCo2 := edtValCo2.Text

    Else If (Sender = edtBasIc2) Then
      objFreCon.strBasIc2 := edtBasIc2.Text

    Else If (Sender = edtAlqIc2) Then
      objFreCon.strAlqIc2 := edtAlqIc2.Text

    Else If (Sender = edtValIc2) Then
      objFreCon.strValIc2 := edtValIc2.Text

    Else If (Sender = edtValOu2) Then
      objFreCon.strValOu2 := edtValOu2.Text

    Else If (Sender = edtValIs2) Then
      objFreCon.strValIs2 := edtValIs2.Text

    Else If (Sender = edtValRe2) Then
      objFreCon.strValRe2 := edtValRe2.Text

    Else If (Sender = edtBasIp2) Then
      objFreCon.strBasIp2 := edtBasIp2.Text

    Else If (Sender = edtValIp2) Then
      objFreCon.strValIp2 := edtValIp2.Text

    Else If (Sender = edtBasSu2) Then
      objFreCon.strBasSu2 := edtBasSu2.Text

    Else If (Sender = edtDesAc2) Then
      objFreCon.strDesAc2 := edtDesAc2.Text

    Else If (Sender = cbbTipFre) Then
    Begin

      If cbbTipFre.Visible Then
      Begin

        If (cbbTipFre.ItemIndex = -1) Then
        Begin
          pMensagemOk('Informe o Tipo de Rateio para o Frete!');
          Result := False;
        End;

      End;

    End

    {**************************************}
    {* 3 - CLASSIFICAÇÃO                  *}
    {***********************************AF*}
    Else If (Sender = edtClaFi3) Then
    Begin
      objFreCon.strClaFi3 := edtClaFi3.Text;

      If fEmptyStr(edtClaFi3.Text) And pnlClassificacoes.Enabled And blnBuscaPorChave Then
      Begin
        If Not TGerenciaModeloPermitidos.fModeloPermitidoParaCFOP(edtClaFi3.Text, cbxCODMOD.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Classificação Fiscal '+edtClaFi3.Text+' não pode ser utlizada no modelo '+cbxCodMod.Text+'!', ['&Ok']);
          Result := False;
        End
        Else
        Begin

          If pgcFrete.Visible Then
            pgcFrete.ActivePage := tbsFrete;

          pSetFocus(edtClaFi4);
          blnMudarFoco := False;
        End;
      End;
    End

    Else If (Sender = edtValCo3) Then
      objFreCon.strValCo3 := edtValCo3.Text

    Else If (Sender = edtBasIc3) Then
      objFreCon.strBasIc3 := edtBasIc3.Text

    Else If (Sender = edtAlqIc3) Then
      objFreCon.strAlqIc3 := edtAlqIc3.Text

    Else If (Sender = edtValIc3) Then
      objFreCon.strValIc3 := edtValIc3.Text

    Else If (Sender = edtValOu3) Then
      objFreCon.strValOu3 := edtValOu3.Text

    Else If (Sender = edtValIs3) Then
      objFreCon.strValIs3 := edtValIs3.Text

    Else If (Sender = edtValRe3) Then
      objFreCon.strValRe3 := edtValRe3.Text

    Else If (Sender = edtBasIp3) Then
      objFreCon.strBasIp3 := edtBasIp3.Text

    Else If (Sender = edtValIp3) Then
      objFreCon.strValIp3 := edtValIp3.Text

    Else If (Sender = edtBasSu3) Then
      objFreCon.strBasSu3 := edtBasSu3.Text

    Else If (Sender = edtDesAc3) Then
      objFreCon.strDesAc3 := edtDesAc3.Text

    {**************************************}
    {* 4 - CLASSIFICAÇÃO                  *}
    {***********************************AF*}
    Else If (Sender = edtClaFi4) Then
    Begin
      objFreCon.strClaFi4 := edtClaFi4.Text;

      If fEmptyStr(edtClaFi4.Text) And pnlClassificacoes.Enabled And blnBuscaPorChave Then
      Begin
        If Not TGerenciaModeloPermitidos.fModeloPermitidoParaCFOP(edtClaFi4.Text, cbxCODMOD.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Classificação Fiscal '+edtClaFi4.Text+' não pode ser utlizada no modelo '+cbxCodMod.Text+'!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If pgcFrete.Visible Then
            pgcFrete.ActivePage := tbsFrete;

          pSetFocus(edtClaFi5);
          blnMudarFoco := False;
        End;
      End;
    End

    Else If (Sender = edtValCo4) Then
      objFreCon.strValCo4 := edtValCo4.Text

    Else If (Sender = edtBasIc4) Then
      objFreCon.strBasIc4 := edtBasIc4.Text

    Else If (Sender = edtAlqIc4) Then
      objFreCon.strAlqIc4 := edtAlqIc4.Text

    Else If (Sender = edtValIc4) Then
      objFreCon.strValIc4 := edtValIc4.Text

    Else If (Sender = edtValOu4) Then
      objFreCon.strValOu4 := edtValOu4.Text

    Else If (Sender = edtValIs4) Then
      objFreCon.strValIs4 := edtValIs4.Text

    Else If (Sender = edtValRe4) Then
      objFreCon.strValRe4 := edtValRe4.Text

    Else If (Sender = edtBasIp4) Then
      objFreCon.strBasIp4 := edtBasIp4.Text

    Else If (Sender = edtValIp4) Then
      objFreCon.strValIp4 := edtValIp4.Text

    Else If (Sender = edtBasSu4) Then
      objFreCon.strBasSu4 := edtBasSu4.Text

    Else If (Sender = edtDesAc4) Then
      objFreCon.strDesAc4 := edtDesAc4.Text

    {**************************************}
    {* 5 - CLASSIFICAÇÃO                  *}
    {***********************************AF*}
    Else If (Sender = edtClaFi5) Then
    Begin
      objFreCon.strClaFi5 := edtClaFi5.Text;

      If fEmptyStr(edtClaFi5.Text) And pnlClassificacoes.Enabled Then
      Begin
        If Not TGerenciaModeloPermitidos.fModeloPermitidoParaCFOP(edtClaFi5.Text, cbxCODMOD.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Classificação Fiscal '+edtClaFi5.Text+' não pode ser utlizada no modelo '+cbxCodMod.Text+'!', ['&Ok']);
          Result := False;
        End
        Else
        Begin

          pnlBotoes.Enabled := True;
          pSetFocus(btnGravar);
          blnMudarFoco := False;
        End;
      End;
    End

    Else If (Sender = edtValCo5) Then
      objFreCon.strValCo5 := edtValCo5.Text

    Else If (Sender = edtBasIc5) Then
      objFreCon.strBasIc5 := edtBasIc5.Text

    Else If (Sender = edtAlqIc5) Then
      objFreCon.strAlqIc5 := edtAlqIc5.Text

    Else If (Sender = edtValIc5) Then
      objFreCon.strValIc5 := edtValIc5.Text

    Else If (Sender = edtValOu5) Then
      objFreCon.strValOu5 := edtValOu5.Text

    Else If (Sender = edtValIs5) Then
      objFreCon.strValIs5 := edtValIs5.Text

    Else If (Sender = edtValRe5) Then
      objFreCon.strValRe5 := edtValRe5.Text

    Else If (Sender = edtBasIp5) Then
      objFreCon.strBasIp5 := edtBasIp5.Text

    Else If (Sender = edtValIp5) Then
      objFreCon.strValIp5 := edtValIp5.Text

    Else If (Sender = edtBasSu5) Then
      objFreCon.strBasSu5 := edtBasSu5.Text

    Else If (Sender = edtDesAc5) Then
      objFreCon.strDesAc5 := edtDesAc5.Text

   Else If (Sender = edtBasAn1) Then
      objFreCon.strBasAn1 := edtBasAn1.Text

    Else If (Sender = edtAntIc1) Then
      objFreCon.strAntIc1 := edtAntIc1.Text

    Else If (Sender = edtBasAn2) Then
      objFreCon.strBasAn2 := edtBasAn2.Text

    Else If (Sender = edtAntIc2) Then
      objFreCon.strAntIc2 := edtAntIc2.Text

   Else If (Sender = edtBasAn3) Then
      objFreCon.strBasAn3 := edtBasAn3.Text

    Else If (Sender = edtAntIc3) Then
      objFreCon.strAntIc3 := edtAntIc3.Text

   Else If (Sender = edtBasAn4) Then
      objFreCon.strBasAn4 := edtBasAn4.Text

    Else If (Sender = edtAntIc4) Then
      objFreCon.strAntIc4 := edtAntIc4.Text

   Else If (Sender = edtBasAn5) Then
      objFreCon.strBasAn5 := edtBasAn5.Text

    Else If (Sender = edtAntIc5) Then
      objFreCon.strAntIc5 := edtAntIc5.Text;

    edtValCoT.Text := objFreCon.strValCoT;
    edtBasIcT.Text := objFreCon.strBasIcT;
    edtAlqIcT.Text := objFreCon.strAlqIcT;
    edtValIcT.Text := objFreCon.strValIcT;
    edtValOuT.Text := objFreCon.strValOuT;
    edtValIsT.Text := objFreCon.strValIsT;
    edtValReT.Text := objFreCon.strValReT;
    edtBasIpT.Text := objFreCon.strBasIpT;
    edtValIpT.Text := objFreCon.strValIpT;
    edtBasSuT.Text := objFreCon.strBasSuT;
    edtDesAcT.Text := objFreCon.strDesAcT;
    edtBasAnT.Text := objFreCon.strBasAnT;
    edtAntIcT.Text := objFreCon.strAntIcT;

    If objFreCon.fVerificaDocumento Then
    Begin
      Result := False;
      fMensagem('','ja existe um documento com esses dados!',['&OK']);
    End;

    If Result And objFreCon.blnVarNot Then
      Result := fValidaCamposNotas(Sender, blnBuscaPorChave);

    If (Not Result) Then
      pSetFocus(Sender);

  Except
    On E: Exception Do
    Begin
      If pgcFrete.Visible Then
        pgcFrete.ActivePage := tbsFrete;

      pSetFocus(Sender);
      Result := False;
      pMensagemOk(E.Message); // NAO É PARA GERAR LOGERR
    End;
  End;

End;

Procedure TfrmEntFreConhecimento.pLimpaDadosNota;
Begin
  edtNotEnt.Clear;
  edtEspEnt.Clear;
  edtSerEnt.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtPerRep.Clear;
End;

procedure TfrmEntFreConhecimento.tbsFreteEnter(Sender: TObject);
begin
  inherited;

  btnAltVal.Visible  := True;
  btnExcluir.Visible := False;
  If Assigned(objFreCon.cdsNotEnt) Then
  begin
    pnlClassificacoes.Enabled := (Not objFreCon.cdsNotEnt.IsEmpty) And
                                 SameText(objFreCon.cdsNotEnt.FieldByName('ESPDOC').AsString, 'NF');

  End;
  If Not pnlClassificacoes.Enabled Then
    pLimpaPanel(pnlClassificacoes);

end;

procedure TfrmEntFreConhecimento.pLimpaPanel(pnlDadosItem: TPanel);
  Var
    intContador: Integer;
    edtTemp: TEditFocus;
Begin
  For intContador := 0 To pnlDadosItem.ControlCount -1 Do
  Begin

    If (pnlDadosItem.Controls[intContador] Is TEditFocus) Then
    Begin
      edtTemp := (pnlDadosItem.Controls[intContador] As TEditFocus);
      edtTemp.Clear;
    End

    Else If (pnlDadosItem.Controls[intContador] Is TPanel) Then
      pLimpaPanel(TPanel(pnlDadosItem.Controls[intContador]))

  End;
end;

procedure TfrmEntFreConhecimento.tbsNotasEnter(Sender: TObject);
begin
  inherited;

  btnAltVal.Visible  := False;
  btnExcluir.Visible := True;

end;

function TfrmEntFreConhecimento.fValidaCamposNotas(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    blnConFre: Boolean;
Begin
  Result := True;

  If (Sender = edtNotEnt) Then
  Begin

    If fEmptyStr(edtNotEnt.Text) Then
    Begin

      pLimpaDadosNota;

      If blnBuscaPorChave Then
      Begin

        If Not objFreCon.cdsNotEnt.IsEmpty Then
        Begin
          pnlBotoes.Enabled := True;

          pSetFocus(btnGravar);
          blnMudarFoco := False;
        End

        Else Result := False;

      End;

    End;

  End

  Else If (Sender = edtSerEnt) Then
  Begin

  End

  Else If (Sender = edtEspEnt) Then
  Begin

    If blnBuscaPorChave Then
    Begin

      If fEmptyStr(edtEspEnt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espécie do Documento deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If (Not objFreCon.cdsNotEnt.IsEmpty) And
              (Not SameText(objFreCon.cdsNotEnt.FieldByName('ESPDOC').AsString, edtEspEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Os documentos incluidos devem ser da mesma espécie!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCodFor) Then
  Begin

    If blnBuscaPorChave Then
    Begin

      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&O k']);
        Result := False;
      End Else
      Begin

        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fornecedor não econtrador!', ['&O k']);
          Result := False;
        End

        Else If Not objFreCon.fDocumentoExiste(edtNotEnt.Text, edtEspEnt.Text,
                                               edtSerEnt.Text, edtCodFor.Text,
                                               blnConFre,
                                               fltOutDes) Then
        Begin
          fMensagem('ATENÇÃO!', 'Documento não econtrado!', ['&O k']);
          Result := False;
        End

        Else If blnConFre Then
        Begin
          cdsCTEAnteriores := objFreCon.fCarregaCTESAnteriores(edtNotEnt.Text, edtEspEnt.Text, VS_strCodEmp, edtSerEnt.Text, edtCodFor.Text);
          If edtCodFor.Focused Then
          Begin
            Result :=  fPergunta('A Nota Fiscal ' + edtNotEnt.Text + ' já está associada ao CTE ' + cdsCTEAnteriores.FieldByName('FIS_NUMDOC').AsString + ' Deseja continuar?');
            If not Result Then
            Begin
              edtNotEnt.Text := '';
              edtEspEnt.Text := '';
              edtSerEnt.Text := '';
              edtCodFor.Text := '';
            End;
          End;
        End

        Else If (fltOutDes > 0) And (objFreCon.objOutDes.fltValOut > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa nota já possui Outras Despesas!', ['&O k']);
          Result := False;
        End;

      End;

    End;

  End

  Else If (Sender = edtPerRep) Then
  Begin

    If edtPerRep.Visible And blnBuscaPorChave Then
    Begin

      If fStrToFloat(edtPerRep.Text) <= 0 Then
      Begin
        pMensagemOk('Informe o percentual de representatividade da nota!');
        Result := False;
      End;

      If Result Then
        edtPerRep.Text := FormatFloat('#0.00', fStrToFloat(edtPerRep.Text));
    End;

  End;

End;

procedure TfrmEntFreConhecimento.pAtualizaPortador(blnBuscaPorChave : boolean);
begin
  if objFreCon.objPortadorFornecedor.fTravaPortador then
  begin
    edtCodPor.Enabled := False;
    edtCodPor.Text := objFreCon.objPortadorFornecedor.strCodPor;
    edtNomPor.Text := objFreCon.objPortadorFornecedor.strNomPor;
  end
  else
  begin
    edtCodPor.Enabled := True;
    if blnBuscaPorChave then
    begin
      edtCodPor.Text := objFreCon.objPortadorFornecedor.strCodPor;
      edtNomPor.Text := objFreCon.objPortadorFornecedor.strNomPor;
    end;
  end;
end;

procedure TfrmEntFreConhecimento.pCarregaDados;
Begin
  objFreCon.pAtualizaDados;
  edtNumDoc.Text := objFreCon.strNumDoc;
  edtSerie.Text  := objFreCon.strSerie_;

   // Se Objeto estiver vazio pega o default carregado pelo Frame
  fraCtaPagar.edtVeioNF.Text  := IIF(fEmptyStr(objFreCon.strVeioNF),fraCtaPagar.edtVeioNF.Text,objFreCon.strVeioNF);
  fraCtaPagar.edtUsaChq.Text  := IIF(fEmptyStr(objFreCon.strUsaChq),fraCtaPagar.edtUsaChq.Text,objFreCon.strUsaChq);
  fraCtaPagar.edtPrevis.Text  := IIF(fEmptyStr(objFreCon.strPrevis),fraCtaPagar.edtPrevis.Text,objFreCon.strPrevis);
  fraCtaPagar.edtPagAnt.Text  := IIF(fEmptyStr(objFreCon.strPagAnt),fraCtaPagar.edtPagAnt.Text,objFreCon.strPagAnt);
  fraCtaPagar.edtUsoCon.Text  := IIF(fEmptyStr(objFreCon.strUsoCon),fraCtaPagar.edtUsoCon.Text,objFreCon.strUsoCon);

  fraCtaPagar.edtTipDoc.Text  := IIF(fEmptyStr(objFreCon.strTipDoc),fraCtaPagar.edtTipDoc.Text,objFreCon.strTipDoc);
  objFrameCtaPagar.pValidaGuiaTributo;

  fraCtaPagar.LcbGuiaTributo.KeyValue  := IIF(fEmptyStr(objFreCon.strGuiTri),fraCtaPagar.LcbGuiaTributo.KeyValue,objFreCon.strGuiTri);
  objFrameCtaPagar.pChamaEventoSairComponenteGuiaTributo;

  fraCtaPagar.LcbTipoTributo.KeyValue  := IIF(fEmptyStr(objFreCon.strTipTri),fraCtaPagar.LcbTipoTributo.KeyValue,objFreCon.strTipTri);
  fraCtaPagar.edtDeposi.Text  := IIF(fEmptyStr(objFreCon.strDeposi),fraCtaPagar.edtDeposi.Text,objFreCon.strDeposi);

  edtEspDoc.Text := objFreCon.strEspDoc;
  edtCodTra.Text := objFreCon.strCodTra;
  // Carrega os dados para deposito
  objFrameCtaPagar.strCodigo_Fornecedor    := edtCodTra.Text;
  objFrameCtaPagar.pCarregaDadosBancariosFornecedor;
  objFrameCtaPagar.pPosicionaContaFornecedor(objFreCon.strBcoFor);

  edtDesTra.Text := objFreCon.strDesTra;
  mskConPag.Text := objFreCon.strCndPag;

  fraCtaPagar.edtCodCta.Text := objFreCon.strCodCta;
  fraCtaPagar.edtNomCta.Text := objFreCon.strDesCta;

  fraCtaPagar.edtCodEve.Text := objFreCon.strCodEve;
 fraCtaPagar.edtDesEve.Text := fRetNomEvento(fraCtaPagar.edtCodEve.Text);

  edtValDoc.Text := objFreCon.strValDoc;
  fraCtaPagar.MemHisto.Text := objFreCon.strHis001;

  If fEmptyStr(objFreCon.strDtaEnt) Then
    mskDtaEnt.Text := FormatDateTime('dd/mm/yyyy',VS_Date)
  Else
    mskDtaEnt.Text := objFreCon.strDtaEnt;

  If fEmptyStr(objFreCon.strComPet) Then
    fraCtaPagar.edtCompet.Text := FormatDateTime('mm/YYYY',StrToDate(mskDtaEnt.Text))
  Else
    fraCtaPagar.edtCompet.Text := objFreCon.strComPet;

  If fEmptyStr(objFreCon.strDtaDoc) Then
    mskDtaDoc.Text := FormatDateTime('dd/mm/yyyy',VS_Date)
  Else
    mskDtaDoc.Text := objFreCon.strDtaDoc;

  edtClaFi1.Text := objFreCon.strClaFi1;
  edtValCo1.Text := objFreCon.strValCo1;
  edtBasIc1.Text := objFreCon.strBasIc1;
  edtAlqIc1.Text := objFreCon.strAlqIc1;
  edtValIc1.Text := objFreCon.strValIc1;
  edtValOu1.Text := objFreCon.strValOu1;
  edtValIs1.Text := objFreCon.strValIs1;
  edtValRe1.Text := objFreCon.strValRe1;
  edtBasIp1.Text := objFreCon.strBasIp1;
  edtValIp1.Text := objFreCon.strValIp1;
  edtBasSu1.Text := objFreCon.strBasSu1;
  edtDesAc1.Text := objFreCon.strDesAc1;

  edtClaFi2.Text := objFreCon.strClaFi2;
  edtValCo2.Text := objFreCon.strValCo2;
  edtBasIc2.Text := objFreCon.strBasIc2;
  edtAlqIc2.Text := objFreCon.strAlqIc2;
  edtValIc2.Text := objFreCon.strValIc2;
  edtValOu2.Text := objFreCon.strValOu2;
  edtValIs2.Text := objFreCon.strValIs2;
  edtValRe2.Text := objFreCon.strValRe2;
  edtBasIp2.Text := objFreCon.strBasIp2;
  edtValIp2.Text := objFreCon.strValIp2;
  edtBasSu2.Text := objFreCon.strBasSu2;
  edtDesAc2.Text := objFreCon.strDesAc2;

  edtClaFi3.Text := objFreCon.strClaFi3;
  edtValCo3.Text := objFreCon.strValCo3;
  edtBasIc3.Text := objFreCon.strBasIc3;
  edtAlqIc3.Text := objFreCon.strAlqIc3;
  edtValIc3.Text := objFreCon.strValIc3;
  edtValOu3.Text := objFreCon.strValOu3;
  edtValIs3.Text := objFreCon.strValIs3;
  edtValRe3.Text := objFreCon.strValRe3;
  edtBasIp3.Text := objFreCon.strBasIp3;
  edtValIp3.Text := objFreCon.strValIp3;
  edtBasSu3.Text := objFreCon.strBasSu3;
  edtDesAc3.Text := objFreCon.strDesAc3;

  edtClaFi4.Text := objFreCon.strClaFi4;
  edtValCo4.Text := objFreCon.strValCo4;
  edtBasIc4.Text := objFreCon.strBasIc4;
  edtAlqIc4.Text := objFreCon.strAlqIc4;
  edtValIc4.Text := objFreCon.strValIc4;
  edtValOu4.Text := objFreCon.strValOu4;
  edtValIs4.Text := objFreCon.strValIs4;
  edtValRe4.Text := objFreCon.strValRe4;
  edtBasIp4.Text := objFreCon.strBasIp4;
  edtValIp4.Text := objFreCon.strValIp4;
  edtBasSu4.Text := objFreCon.strBasSu4;
  edtDesAc4.Text := objFreCon.strDesAc4;

  edtClaFi5.Text := objFreCon.strClaFi5;
  edtValCo5.Text := objFreCon.strValCo5;
  edtBasIc5.Text := objFreCon.strBasIc5;
  edtAlqIc5.Text := objFreCon.strAlqIc5;
  edtValIc5.Text := objFreCon.strValIc5;
  edtValOu5.Text := objFreCon.strValOu5;
  edtValIs5.Text := objFreCon.strValIs5;
  edtValRe5.Text := objFreCon.strValRe5;
  edtBasIp5.Text := objFreCon.strBasIp5;
  edtValIp5.Text := objFreCon.strValIp5;
  edtBasSu5.Text := objFreCon.strBasSu5;
  edtDesAc5.Text := objFreCon.strDesAc5;

  edtValCoT.Text := objFreCon.strValCoT;
  edtBasIcT.Text := objFreCon.strBasIcT;
  edtAlqIcT.Text := objFreCon.strAlqIcT;
  edtValIcT.Text := objFreCon.strValIcT;
  edtValOuT.Text := objFreCon.strValOuT;
  edtValIsT.Text := objFreCon.strValIsT;
  edtValReT.Text := objFreCon.strValReT;
  edtBasIpT.Text := objFreCon.strBasIpT;
  edtValIpT.Text := objFreCon.strValIpT;
  edtBasSuT.Text := objFreCon.strBasSuT;
  edtDesAcT.Text := objFreCon.strDesAcT;

  edtChaveAcesso.Text := objFreCon.strAcesso;

  cbxCodMod.Items.CommaText := fRetornaDadosModFis(edtChaveAcesso.Text);
  cbxCODMOD.ItemIndex := cbxCODMOD.Items.IndexOf(objFreCon.strModelo);

  edtCodPor.Text := objFreCon.strCodPor;
  edtNomPor.Text := fRetNomPortador(edtCodPor.Text);

  chkGravarFinanceiro.Checked := objFreCon.blnGraCTP;
  fraCtaPagar.edtVeioBo.Text := IIF(objFreCon.blnVeioBoleto,'S','N');

  pCarregaDadosAntecipacao;

  pAtualizaPortador(Not blnAlteracao);

  pHabilitaCodBarras;

  {Carrega as pessoas }
  fraPessoasCTE.edtRemetenteCNPJ.pSetPessoa(objFreCon.Remetente);
  fraPessoasCTE.edtEmitenteCNPJ.pSetPessoa(objFreCon.Emitente );
  fraPessoasCTE.edtExpedidorCNPJ.pSetPessoa(objFreCon.Expedidor);
  fraPessoasCTE.edtRecebedorCNPJ.pSetPessoa(objFreCon.Recebedor);
  fraPessoasCTE.edtDestinatarioCNPJ.pSetPessoa(objFreCon.Destinatario);
  fraPessoasCTE.edtTomadorCNPJ.pSetPessoa(objFreCon.Tomador);

  fraPessoasCTE.cmbTomador.ItemIndex := objFreCon.Tomador.intCodTomador+1;
  fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex := objFreCon.Tomador.intTipoDocumento;
End;

procedure TfrmEntFreConhecimento.pCarregaDadosAntecipacao;
begin
  If Not fTemAntecipacaoIcms Then
  Begin
    objFreCon.strBasAn1 := '0,00';
    objFreCon.strAntIc1 := '0,00';
    objFreCon.strBasAn2 := '0,00';
    objFreCon.strAntIc2 := '0,00';
    objFreCon.strBasAn3 := '0,00';
    objFreCon.strAntIc3 := '0,00';
    objFreCon.strBasAn4 := '0,00';
    objFreCon.strAntIc4 := '0,00';
    objFreCon.strBasAn5 := '0,00';
    objFreCon.strAntIc5 := '0,00';
  End;

  edtBasAn1.Text := objFreCon.strBasAn1;
  edtAntIc1.Text := objFreCon.strAntIc1;
  edtBasAn2.Text := objFreCon.strBasAn2;
  edtAntIc2.Text := objFreCon.strAntIc2;
  edtBasAn3.Text := objFreCon.strBasAn3;
  edtAntIc3.Text := objFreCon.strAntIc3;
  edtBasAn4.Text := objFreCon.strBasAn4;
  edtAntIc4.Text := objFreCon.strAntIc4;
  edtBasAn5.Text := objFreCon.strBasAn5;
  edtAntIc5.Text := objFreCon.strAntIc5;
  edtBasAnT.Text := objFreCon.strBasAnT;
  edtAntIcT.Text := objFreCon.strAntIcT;

  edtBasSu1.Text := objFreCon.strBasSu1;
  edtValRe1.Text := objFreCon.strValRe1;
  edtBasSu2.Text := objFreCon.strBasSu2;
  edtValRe2.Text := objFreCon.strValRe2;
  edtBasSu3.Text := objFreCon.strBasSu3;
  edtValRe3.Text := objFreCon.strValRe3;
  edtBasSu4.Text := objFreCon.strBasSu4;
  edtValRe4.Text := objFreCon.strValRe4;
  edtBasSu5.Text := objFreCon.strBasSu5;
  edtValRe5.Text := objFreCon.strValRe5;
  edtBasSuT.Text := objFreCon.strBasSuT;
  edtValReT.Text := objFreCon.strValReT;
end;

procedure TfrmEntFreConhecimento.pHabilitaDadosFrete;
begin
  If Not objFreCon.blnVarNot Then
    Exit;

  btnAbreXmlCte.Enabled := (Not objFreCon.cdsNotEnt.IsEmpty);
end;


procedure TfrmEntFreConhecimento.FormShow(Sender: TObject);
  Var
    intPaginasAtivas: Integer;
begin
  inherited;

  fraCtaPagar.objFrameCtaPagar := objFrameCtaPagar;
  fraCtaPagar.InicializaObjetoFrameContaPagar;

  tbsRateioFrete.TabVisible := (cbbTipFre.ItemIndex = INDEX_TIPO_DIGITACAO_PERCENTUAL) Or
                               (intRatFre In [4, 5]);

  If (Not objFreCon.blnVarNot) And (Not fTemAntecipacaoIcms) Then
  Begin
    tbsNotas.TabVisible := False;
    tbsItens.TabVisible := False;

    pSetFocus(edtNumDoc);
  End Else
  Begin
    pgcFrete.Visible         := True;
    pgcFrete.ActivePageIndex := 0;

    If objFreCon.blnVarNot Then
    Begin
      cxgNotasView.DataController.DataSource := objFreCon.cdsNotEnt.dtsSource;
      tbsNotas.TabVisible       := True;
      pSetFocus(edtNotEnt);
    End Else
    Begin
      tbsNotas.TabVisible    := False;
      cxgItensNUMDOC.Visible := False;
      pSetFocus(edtNumDoc);
    End;

    If fTemAntecipacaoIcms Then
    Begin
      tbsItens.TabVisible      := True;

      If Assigned(objFreCon.objIteAnt) Then
        cxgItensView.DataController.DataSource := objFreCon.objIteAnt.dtsSource;
    End Else
    Begin
      tbsItens.TabVisible      := False;
    End;

  End;

  pHabilitaDadosFrete;

  pAjustaNumeroPaginas(pgcFrete, intPaginasAtivas);

  pnlPortador.Visible       := True;

  pCarregaDados;

  cxvProdutosNUMDOC.Visible := objFreCon.blnVarNot;
  btnOutDes.Visible := Assigned(objFreCon.objOutDes);

  If objFreCon.qryTabela.IsEmpty Then
    objFreCon.qryTabela.Insert
  Else
    objFreCon.qryTabela.Edit;

  edtNotEnt.TamCampo  := fTamNumDoc();
  edtNotEnt.MaxLength := edtNotEnt.TamCampo;

  edtNumDoc.TamCampo  := edtNumDoc.TamCampo;
  edtNumDoc.MaxLength := edtNumDoc.TamCampo;
  {****************************************************}
  {* TRAVA ESPECIE DO DOC. COMO CT SPEED SO ACEITA CT *}
  {*************************************************GB*}
  edtEspDoc.Text    := 'CT';
  edtEspDoc.Enabled := False;

  cxgItensANTFRE.Properties.ReadOnly := Not fCfgSis('DESFRE', varBoolean);

  btnCfgPis.Visible := fCfgSis('UTIABR', varBoolean) And (objFreCon.tpFrete = tpfEntrada);
  btnCfgCof.Visible := btnCfgPis.Visible;

  lblPerRep.Visible      := objFreCon.blnPerRep;
  edtPerRep.Visible      := objFreCon.blnPerRep;
  cxgNotasPERREP.Visible := objFreCon.blnPerRep;

  fltFreteOriginal := fStrToFloat(edtValDoc.Text);
end;

procedure TfrmEntFreConhecimento.pHabilitaCodBarras;
Begin
  pHabilitaDuplicatas;

  btnBarBol.Enabled := (fraCtaPagar.edtVeioBo.Text = 'S')  And
                       (fTiraCaracEspeciaisPonto(mskConPag.Text) <> '01000') And
                       (Not fEmptyStr(fTiraCaracEspeciais(mskConPag.Text))) And
                       (fStrToFloat(edtValDoc.Text) > 0) And
                       blnCTPBOL;
End;

procedure TfrmEntFreConhecimento.pHabilitaDuplicatas;
Begin
  btnAltVal.Enabled := (fTiraCaracEspeciaisPonto(mskConPag.Text) <> '01000') And
                       (Not fEmptyStr(fTiraCaracEspeciais(mskConPag.Text))) And
                       (fStrToFloat(edtValDoc.Text) > 0);
End;

procedure TfrmEntFreConhecimento.btnCfgCofClick(Sender: TObject);
begin
  inherited;

  If Not btnCfgCof.Visible Then
    Exit;

  objFreCon.fSelecionaAbreviacaoCofinsEntrada(edtClaFi1.Text);
end;

procedure TfrmEntFreConhecimento.btnAbreXmlCteClick(Sender: TObject);
  Var
    opdOpenFile : TOpenDialog;
begin
  inherited;
  Try
    opdOpenFile := TOpenDialog.Create(Self) ;
    opdOpenFile.Filter := 'Arquivos Suportados|*.Xml';

    pSetFocus(edtNumDoc);
    objFreCon.strDtaEnt := mskDtaEnt.Text;
    objFreCon.blnImpVariosXml := True;

    if (opdOpenFile.Execute) then
    if (objFreCon.fCarregaArquivos(opdOpenFile.FileName, True, True, False)) Then
    Begin
      fraPessoasCTE.cmbTipoDocumentoAnexoCTE.Enabled := False;
      fraPessoasCTE.cmbTomador.Enabled := False;
      fraPessoasCTE.edtEmitenteCNPJ.pSetPessoa(objFreCon.Emitente);
      fraPessoasCTE.edtRemetenteCNPJ.pSetPessoa(objFreCon.Remetente);
      fraPessoasCTE.edtExpedidorCNPJ.pSetPessoa(objFreCon.Expedidor);
      fraPessoasCTE.edtRecebedorCNPJ.pSetPessoa(objFreCon.Recebedor);
      fraPessoasCTE.edtDestinatarioCNPJ.pSetPessoa(objFreCon.Destinatario);
      fraPessoasCTE.edtTomadorCNPJ.pSetPessoa(objFreCon.Tomador);

      fraPessoasCTE.edtEmitenteCNPJ.Enabled := False;
      fraPessoasCTE.edtRemetenteCNPJ.Enabled := False;
      fraPessoasCTE.edtExpedidorCNPJ.Enabled := False;
      fraPessoasCTE.edtRecebedorCNPJ.Enabled := False;
      fraPessoasCTE.edtDestinatarioCNPJ.Enabled := False;
      fraPessoasCTE.edtTomadorCNPJ.Enabled := False;


      case objFreCon.FtpDocFrete Of
        tpdfCompra: fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex :=  0;
        tpdfVenda:fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex := 1;
        tpdfDevolucaoVenda: fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex := 2;
        Else
          fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex := 0;
      End;
      fraPessoasCTE.cmbTomador.ItemIndex := objFreCon.Destinatario.intCodTomador + 1;
      pCarregaDados;

      pTrataCamposICMS;

      objFreCon.qryTabela.Edit;
    End
    else
      objFreCon.qryTabela.Insert;

  Finally
    FreeAndNil(opdOpenFile);
  End;

  pHabilitaCodBarras;
end;

procedure TfrmEntFreConhecimento.btnAltValClick(Sender: TObject);
Var
  arrDatas: TDateArray;
  intContad: Integer;
begin
  inherited;

  If Not btnAltVal.Visible Then
    Exit;

  If fVerificaCampos Then
  Begin
    {********************************************}
    {* ARMAZENA OS DADOS ATUAIS DO ARRDUPLICATA *}
    {*****************************************PZ*}
    //JOGA DO ArrDuplicata PARA arrDupTmp
    objFreCon.pControlaDigDuplicAtual(1);

    Try
      // JOGA FDuplic no arrDuplicata
      objFreCon.pMontaDuplicatasXMl;

      If fDigDuplic(objFreCon.arrDuplicata,
                    mskConPag.Text,
                    0,
                    fStrToFloat(edtValDoc.Text),
                    (fStatusCndPag(mskConPag.Text) = A_PRAZO),
                    True,
                    False,
                    StrToDateDef(mskDtaDoc.Text, 0),
                     True,
                    0,
                    'S',
                    fRetArred2ParcFornec(edtCodTra.Text),
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
                    False,
                    '',     // strCodCnd: String = '';
                    '',     // strCodVen: String = '';
                    Nil,    // fSenVar: TGenericFunctionWithArrayParam = Nil;
                    False,  // blnFatPed: Boolean = False;
                    False,  // blnAgrupVeio: Boolean = False;
                    Nil,    // objArredondamento: IArredondaParcela = Nil;
                    objFreCon.arrDuplicata[Low(objFreCon.arrDuplicata)].curValor > 0,   // blnManterValoesOriginais: Boolean = False;
                    False,  // blnMostrarOpcaoPadrao: Boolean = False;
                    0) Then // fltDescPrimeraParcela
    (*
      If (fDigDuplic(mskConPag.Text,
                 0,
                 fStrToFloat(edtValDoc.Text),
                 True,
                 True,
                 False,
                 strToDate(mskDtaDoc.Text),
                 True,
                 0,
                 'N')) Then *)
      Begin
        {*******************************}
        {* ARMAZENA OS DADOS REFERENTE *}
        {* AO FRETE CONHECIMENTO.      *}
        {****************************PZ*}

        // JOGA ARRDUPLICATAS NO FDuplic
        objFreCon.pSetDupicatas;

        //JOGA DO ArrDuplicata PARA arrDupFre
        objFreCon.pControlaDigDuplicAtual(4);
        objFreCon.blnAltDup := True;

        {*********************************}
        {* REFAZ A CONDIÇÃO DE PAGAMENTO *}
        {******************************PZ*}
        For intContad := 0 To Length(objFreCon.arrDuplicata) - 1  Do
        Begin
          If (objFreCon.arrDuplicata[intContad].dtaDtaVen <> '') Then
          Begin
            SetLength(arrDatas, intContad + 1);
            arrDatas[intContad] := strToDate(objFreCon.arrDuplicata[intContad].dtaDtaVen);
          End;
        End;

        mskConPag.Text := fRetornaCndPag(arrDatas, strToDate(mskDtaDoc.Text));
      End;

    Finally
      {****************************************}
      {* VOLTA OS VALORES PARA O ARRDUPLICATA *}
      {*************************************PZ*}
      //JOGA DO ArrDupTmp para ArrDuplicata
      objFreCon.pControlaDigDuplicAtual(2);
    End;

  End;

end;

procedure TfrmEntFreConhecimento.btnBarBolClick(Sender: TObject);
begin
  inherited;

  If Not btnBarBol.Enabled Then
    Exit;

  If Not btnBarBol.Visible Then
    Exit;

  If Not fValidaCampos(mskDtaDoc, True) Then
    Exit;

  If Not fValidaCampos(mskConPag, True) Then
    Exit;

  If Not fValidaCampos(edtValDoc, True) Then
    Exit;

  //JOGA DO ArrDuplicata PARA arrDupTmp
  objFreCon.pControlaDigDuplicAtual(1);

  Try
    // JOGA FDuplic no arrDuplicata
    objFreCon.pMontaDuplicatasXMl;

    If fEmptyStr(objFreCon.arrDuplicata[0].dtaDtaVen) Then
    Begin
      //JOGA DO ArrDupTmp para ArrDuplicata
      objFreCon.pControlaDigDuplicAtual(2);

      btnAltVal.Click;

      // JOGA FDuplic no arrDuplicata
      objFreCon.pMontaDuplicatasXMl;

      If fEmptyStr(objFreCon.arrDuplicata[0].dtaDtaVen) Then
        Exit;
    End;

    pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
    frmDigCodBarBoleto.arrLinDigCodbar := objFreCon.arrLinDigCodbar;
    frmDigCodBarBoleto.arrDuplicata := @objFreCon.arrDuplicata;
    Try
      frmDigCodBarBoleto.ShowModal;
    Finally
      Begin
        If frmDigCodBarBoleto.blnConfirma Then
        Begin
          objFreCon.pSetLinDigCodbar(frmDigCodBarBoleto.arrLinDigCodbar);
        End;
        FreeAndNil(frmDigCodBarBoleto);
      End;
    End;

  Finally
    //JOGA DO ArrDupTmp para ArrDuplicata
    objFreCon.pControlaDigDuplicAtual(2);
  End;

end;

procedure TfrmEntFreConhecimento.btnCfgPisClick(Sender: TObject);
begin
  inherited;

  If Not btnCfgPis.Visible Then
    Exit;

  objFreCon.fSelecionaAbreviacaoPisEntrada(edtClaFi1.Text);
end;

procedure TfrmEntFreConhecimento.btnExcluirClick(Sender: TObject);
begin
  inherited;

  objFreCon.pExcluiNotaEntrada;

  pHabilitaDadosFrete;
end;

procedure TfrmEntFreConhecimento.btnGravarClick(Sender: TObject);
begin
  inherited;

  Try
    pnlBotoes.Enabled := False;

    If btnBarBol.Enabled Then
    Begin

      If objFreCon.fAlterouDadosBoleto Then
      Begin
        btnBarBol.Click;
        Exit;
      End;

    End Else
    Begin
      objFreCon.pLimpaDadosBoleto;
    End;

    If Not objFreCon.fValidaNumDocComChaveAcesso Then
    Begin
      pMensagemOk('O número do documento deve ser igual ao número que compõe a chave de acesso');
      Exit;
    End;

    If Not objFreCon.fValidaPerRep Then
    Begin
      pMensagemOk('A soma do percentual de representatividade das notas deve ser igual a 100%');
      Exit;
    End;

    If (Not objFreCon.blnVarNot) And
       ((cbbTipFre.ItemIndex = INDEX_TIPO_DIGITACAO_PERCENTUAL) Or (intRatFre = 5)) And
       (Not objFreCon.fValidaRateioPercentual(objFreCon.cdsRateioProdutos)) Then
    Begin
      pMensagemOk('A soma do percentual dos fretes deve ser igual a 100%!');
      Exit;
    End;

    If (Not pnlClassificacoes.Enabled) Or objFreCon.fVerificaAlqPisCofEntrada(edtClaFi1.Text) Then
    Begin
      If objFreCon.strArquivoXML = '' Then
      begin
        If Not fraPessoasCTE.fValida Then
          Exit;
        objFreCon.Remetente := fraPessoasCTE.edtRemetenteCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
        objFreCon.Emitente := fraPessoasCTE.edtEmitenteCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
        objFreCon.Expedidor := fraPessoasCTE.edtExpedidorCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
        objFreCon.Recebedor := fraPessoasCTE.edtRecebedorCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
        objFreCon.Destinatario := fraPessoasCTE.edtDestinatarioCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
        case fraPessoasCTE.cmbTomador.ItemIndex -1 of
          0: objFreCon.Tomador := fraPessoasCTE.edtRemetenteCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
          1: objFreCon.Tomador := fraPessoasCTE.edtExpedidorCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
          2: objFreCon.Tomador := fraPessoasCTE.edtRecebedorCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
          3: objFreCon.Tomador := fraPessoasCTE.edtDestinatarioCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
        Else
          objFreCon.Tomador := fraPessoasCTE.edtTomadorCNPJ.fRetPessoa(fraPessoasCTE.cmbTomador.ItemIndex -1, fraPessoasCTE.cmbTipoDocumentoAnexoCTE.ItemIndex);
        End;

        If fraPessoasCTE.cmbTomador.ItemIndex = 0 Then
        Begin
          pMensagemOk('É preciso definir o Tomador!');
          pSetFocus(fraPessoasCTE.cmbTomador);
          Exit;
        End ;
      End;
      pGravaDados;
    End;

  Finally
    pnlBotoes.Enabled := True;
  End;

end;

procedure TfrmEntFreConhecimento.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If fValidaCamposNotas(edtEspEnt, True) And
     fValidaCamposNotas(edtSerEnt, True) And
     fValidaCamposNotas(edtEspEnt, True) And
     fValidaCamposNotas(edtPerRep, True) And
     fValidaCamposNotas(edtCodFor, True) And
     objFreCon.fIncluiNotaEntrada(edtNotEnt.Text, edtEspEnt.Text,
                                  edtSerEnt.Text, edtCodFor.Text,
                                  fltOutDes, fStrToFloat(edtPerRep.Text)) Then
  Begin
    If Assigned(objFreCon.objIteAnt) Then
      objFreCon.objIteAnt.fIncluiItensNota(edtNotEnt.Text, edtEspEnt.Text,
                                 edtSerEnt.Text, edtCodFor.Text, prbProgresso);


    pLimpaDadosNota;
    pHabilitaDadosFrete;
  End;

  pSetFocus(edtNotEnt);

end;

procedure TfrmEntFreConhecimento.btnOutDesClick(Sender: TObject);
begin
  inherited;

  If Not btnOutDes.Visible Then
    Exit;

  objFreCon.objOutDes.fInformaOutrasDespesas(objFreCon.arrDuplicata, '', StrToDateDef(mskDtaEnt.Text, VS_Date), True);
end;

procedure TfrmEntFreConhecimento.cxvProdutosEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_UP) Or (Key = VK_DOWN) Then
  Begin
    pCalculaPercentualEquivalFrete;
  End;

end;

procedure TfrmEntFreConhecimento.cxvProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  Case Key Of
    '-' : Key := #0;
  End;

end;

procedure TfrmEntFreConhecimento.fraCtaPagaredtCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;

  If Not fEntraCons(Key) Then
    Exit;

  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraCtaPagar.edtCodCta, fraCtaPagar.edtNomCta, Nil, Key, arrCentroCusto) Then
    Begin
      If Not fValidaLinhaGrupoCadCta(fraCtaPagar.edtCodCta.Text) Then
        fMensagem('', 'Linha / Grupo não permitido!', ['&Ok'])
      Else
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self, fraCtaPagar.edtCodCta, fraCtaPagar.edtNomCta, Nil, Key, arrCentroCusto, True, True, edtCodTra.Text) Then
    Begin
      If Not fValidaLinhaGrupoCadCta(fraCtaPagar.edtCodCta.Text) Then
        fMensagem('', 'Linha / Grupo não permitido!', ['&Ok'])
      Else
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End;

End;

procedure TfrmEntFreConhecimento.fraCtaPagaredtCodEveKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, fraCtaPagar.edtCodEve, fraCtaPagar.edtDesEve, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(fraCtaPagar.edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntFreConhecimento.fraCtaPagaredtVeioboClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodBarras;
end;

procedure TfrmEntFreConhecimento.fraCtaPagarMemHistoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey: String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

function TfrmEntFreConhecimento.fRetSomaFreteConhecimentoDigitados(DataSet: TDataSet): Double;
begin
  result:= 0;

  If (DataSet <> Nil) Then
  Begin
    DataSet.First;
    While Not(DataSet.Eof)  do
    Begin
      result:= result + DataSet.FieldByName('VALFRE').AsFloat;
      DataSet.Next;
    End;
  End;

end;

procedure TfrmEntFreConhecimento.pCalculaPercentualEquivalFrete;
  var
    fltPercente,
    fltValorFre,
    fltResultado: Double;
Begin

  If cxvProdutosVALFRE.Focused  then
  Begin
    If (cxvProdutos.DataController.DataSource.DataSet.State in [DsEdit]) Then
      cxvProdutos.DataController.DataSource.DataSet.Post;

    fltValorFre:= cxvProdutosVALFRE.DataBinding.Field.AsFloat;
    fltResultado:= (fltValorFre / fStrToFloat(edtValDoc.Text) * 100);
    cxvProdutosPERFRE.EditValue:= fltResultado;
    edtValorFreNota.Text:= FormatFloat(fMskDigitos(2), fRetSomaFreteConhecimentoDigitados(cxvProdutos.DataController.DataSource.DataSet));
  End
  Else
  If cxvProdutosPERFRE.Focused then
  Begin
    If (cxvProdutos.DataController.DataSource.DataSet.State in [DsEdit]) Then
      cxvProdutos.DataController.DataSource.DataSet.Post;

    fltPercente := cxvProdutosPERFRE.DataBinding.Field.AsFloat;
    fltResultado := ((fStrToFloat(edtValDoc.Text) * fltPercente) / 100);
    cxvProdutosVALFRE.EditValue:= fltResultado;
    edtValorFreNota.Text:= FormatFloat(fMskDigitos(2), fRetSomaFreteConhecimentoDigitados(cxvProdutos.DataController.DataSource.DataSet));
  End;

End;


procedure TfrmEntFreConhecimento.cxvProdutosTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;

  If fStrToFloat(AText) < 100 Then
    cxsTotal.Color := $00FF8000

  Else If fStrToFloat(AText) > 100 Then
    cxsTotal.Color := clRed
end;

procedure TfrmEntFreConhecimento.cbbTipFreChange(Sender: TObject);
begin
  inherited;

  tbsRateioFrete.TabVisible := (cbbTipFre.ItemIndex = INDEX_TIPO_DIGITACAO_PERCENTUAL) Or (intRatFre = 5);
  tbsRateioFrete.Caption    := '4 - Rateio do Frete';

  pAjustaNumeroPaginas(pgcFrete, intPaginasAtivas);
end;

procedure TfrmEntFreConhecimento.chkGravarFinanceiroClick(Sender: TObject);
begin
  inherited;
  objFreCon.blnGraCTP := chkGravarFinanceiro.Checked;
end;

Function TfrmEntFreConhecimento.fVerificaOutrasDespesas: Boolean;
Begin
  Result := True;

  If objFreCon.objOutDes.fltValOut = 0 Then
    Exit;

  With objFreCon.cdsNotEnt Do
  Begin
    First;

    While Not Eof Do
    Begin
      If FieldByName('OUTDES').AsFloat > 0 Then
      Begin
        pMensagemOk('A nota ' + FieldByName('NUMDOC').AsString + ' já possui outras despesas!');
        Result := False;
        Exit;
      End;

      Next;
    End;

  End;
End;

procedure TfrmEntFreConhecimento.pGravaDados;
Begin
  If fVerificaCampos Then
  Begin
    {**************************************}
    {* VERIFICAÇÃO DAS COLUNAS DE CLAFIS  *}
    {***********************************AF*}
    With objFreCon Do
    Begin
      If pnlClassificacoes.Enabled And
         (fFormataFloat(fStrToFloat(strValCo1),2) <> 0) And fEmptyStr(edtClaFi1.Text) Then
      Begin
        fMensagem('','Informe a Classificação Fiscal!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi1);
        Exit;
      End

      Else If fFormataFloat(fStrToFloat(strValCo1) +
                            fStrToFloat(strValCo2) +
                            fStrToFloat(strValCo3) +
                            fStrToFloat(strValCo4) +
                            fStrToFloat(strValCo5),2) <>
              fFormataFloat(fStrToFloat(edtValDoc.Text),2) Then
      Begin
        If (pnlClassificacoes.Enabled) Then
        Begin
          fMensagem('','A soma dos valores contábeis deve ser igual ao valor do documento!',['&OK']);

          If pgcFrete.Visible Then
            pgcFrete.ActivePage := tbsFrete;

          pSetFocus(edtValDoc);
          Exit;
        End;
      End

      Else If fFormataFloat(fStrToFloat(objFreCon.strBasIc1) +
                       fStrToFloat(strValIp1) +
                       fStrToFloat(strValRe1) +
                       fStrToFloat(strValIs1) +
                       fStrToFloat(strValOu1),2) <> fFormataFloat(fStrToFloat(objFreCon.strValCo1),2) Then
      Begin
        fMensagem('','Os valores informados (Vr. Contábil 1 = Base ICMS 1 + Vr.IPI 1 + Valor ICMS Sub 1 + Vr. Isentas 1 + Vr. Outras 1) estão divergentes.',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi1);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo1),2) = 0) And (Not fEmptyStr(edtClaFi1.Text)) Then
      Begin
        fMensagem('','Informe o Valor Contábil!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtValCo1);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo2),2) <> 0) And fEmptyStr(edtClaFi2.Text) Then
      Begin
        fMensagem('','Informe a Classificação Fiscal!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi2);
        Exit;
      End

      Else If fFormataFloat(fStrToFloat(strBasIc2) +
                            fStrToFloat(strValIp2) +
                            fStrToFloat(strValRe2) +
                            fStrToFloat(strValIs2) +
                            fStrToFloat(strValOu2),2) <> fFormataFloat(fStrToFloat(strValCo2),2) Then
      Begin
        fMensagem('','Os valores digitados (Vr. Contábil = Base ICMS + Vr.IPI + Valor ICMS Sub + Vr. Isentas + Vr. Outras) estão incorretos.',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi2);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo2),2) = 0) And (Not fEmptyStr(edtClaFi2.Text)) Then
      Begin
        fMensagem('','Informe o Valor Contábil!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtValCo2);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo3),2) <> 0) And fEmptyStr(edtClaFi3.Text) Then
      Begin
        fMensagem('','Informe a Classificação Fiscal!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi3);
        Exit;
      End

      Else If fFormataFloat(fStrToFloat(strBasIc3) +
                            fStrToFloat(strValIp3) +
                            fStrToFloat(strValRe3) +
                            fStrToFloat(strValIs3) +
                            fStrToFloat(strValOu3),2) <> fFormataFloat(fStrToFloat(strValCo3),2) Then
      Begin
        fMensagem('','Os valores digitados (Vr. Contábil = Base ICMS + Vr.IPI + Valor ICMS Sub + Vr. Isentas + Vr. Outras) estão incorretos.',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi3);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo3),2) = 0) And (Not fEmptyStr(edtClaFi3.Text)) Then
      Begin
        fMensagem('','Informe o Valor Contábil!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtValCo3);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo4),2) <> 0) And fEmptyStr(edtClaFi4.Text) Then
      Begin
        fMensagem('','Informe a Classificação Fiscal!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi4);
        Exit;
      End

      Else If fFormataFloat(fStrToFloat(strBasIc4) +
                            fStrToFloat(strValIp4) +
                            fStrToFloat(strValRe4) +
                            fStrToFloat(strValIs4) +
                            fStrToFloat(strValOu4),2) <> fFormataFloat(fStrToFloat(strValCo4),2) Then
      Begin
        fMensagem('','Os valores digitados (Vr. Contábil = Base ICMS + Vr.IPI + Valor ICMS Sub + Vr. Isentas + Vr. Outras) estão incorretos.',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi4);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo4),2) = 0) And (Not fEmptyStr(edtClaFi4.Text)) Then
      Begin
        fMensagem('','Informe o Valor Contábil!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtValCo4);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo5),2) <> 0) And fEmptyStr(edtClaFi5.Text) Then
      Begin
        fMensagem('','Informe a Classificação Fiscal!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi5);
        Exit;
      End

      Else If fFormataFloat(fStrToFloat(strBasIc5) +
                            fStrToFloat(strValIp5) +
                            fStrToFloat(strValRe5) +
                            fStrToFloat(strValIs5) +
                            fStrToFloat(strValOu5),2) <> fFormataFloat(fStrToFloat(strValCo5),2) Then
      Begin
        fMensagem('','Os valores digitados (Vr. Contábil = Base ICMS + Vr.IPI + Valor ICMS Sub + Vr. Isentas + Vr. Outras) estão incorretos.',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtClaFi5);
        Exit;
      End

      Else If (fFormataFloat(fStrToFloat(strValCo5),2) = 0) And (Not fEmptyStr(edtClaFi5.Text)) Then
      Begin
        fMensagem('','Informe o Valor Contábil!',['&OK']);

        If pgcFrete.Visible Then
          pgcFrete.ActivePage := tbsFrete;

        pSetFocus(edtValCo5);
        Exit;
      End;

      If blnVarNot Then
      Begin

        If pgcFrete.ActivePageIndex = 0 Then
        Begin

          pgcFrete.ActivePageIndex := 1;
          Exit;

        End Else
        Begin

          If cdsNotEnt.IsEmpty Then
          Begin
            pMensagemOk('Informe as Notas de Entrada!');
            pgcFrete.ActivePage := tbsNotas;
            Exit;
          End Else
          Begin

            If Not fVerificaOutrasDespesas Then
            Begin
              Exit;
            End;

          End;

        End;

      End;

    End;
    fltAntIcT := fStrToFloat(objFreCon.strAntIcT);
    fltBasAnT := fStrToFloat(objFreCon.strBasAnT);
    objFreCon.blnVeioBoleto :=(fraCtaPagar.edtVeioBo.Text = 'S');
    objFreCon.blnGraCTP := chkGravarFinanceiro.Checked;
    objFreCon.strComPet := fraCtaPagar.edtCompet.Text;

    objFreCon.pEnviaDados;
    objFreCon.qryTabela.Post;

    objFreCon.blnImprCp := chkImprCp.Checked;
    objFreCon.strCodPor := edtCodPor.Text;

    If objFreCon.blnVarNot Then
    Begin

    End Else
    Begin

      If Assigned(objFreCon.objIteAnt) And (Not objFreCon.objIteAnt.fSalvaIcmsAntecipadoFrete(prbProgresso)) Then
      Begin
        Exit;
      End;

    End;

    Close;

    ModalResult := mrOk;
    cbbTipFre.Visible := intRatFre = 3;
    lblTipFre.Visible := cbbTipFre.Visible;
  End;

End;

procedure TfrmEntFreConhecimento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not (ModalResult = MrOk) Then
  Begin
    objFreCon.qryTabela.Cancel;
    fltAntIcT := 0.00;
    fltBasAnT := 0.00;
  End;

  If Assigned(objFrameCtaPagar) Then
    FreeAndNil(objFrameCtaPagar);
end;

procedure TfrmEntFreConhecimento.mskConPagExit(Sender: TObject);
begin
  inherited;

  pHabilitaCodBarras;
end;

procedure TfrmEntFreConhecimento.pCarregaCentroCusto;
begin
  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryCadCta, qryCadCta, fraCtaPagar.edtCodCta.Text)
  Else
    pPesquisaCadCta(qryCadCta, qryCadCta, fraCtaPagar.edtCodCta.Text, True, edtCodTra.Text);
    
  fraCtaPagar.edtNomCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;

end;

procedure TfrmEntFreConhecimento.FormCreate(Sender: TObject);
begin
  inherited;
  fltFreteOriginal := 0;

  blnAlteracao := False;

  intRatFre := fCfgSis('RATFRE', varInteger);

  blnCTPBOL := fCfgSis('CTPBOL', varBoolean);

  btnBarBol.Visible := blnCTPBOL;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCadFor := fCriaQuery(Self);
  fltAntIcT := 0;
  fltBasAnT := 0;

  If Not fTemAntecipacaoIcms Then
  Begin
    edtBasAn1.Enabled := False;
    edtAntIc1.Enabled := False;
    edtBasAn2.Enabled := False;
    edtAntIc2.Enabled := False;
    edtBasAn3.Enabled := False;
    edtAntIc3.Enabled := False;
    edtBasAn4.Enabled := False;
    edtAntIc4.Enabled := False;
    edtBasAn5.Enabled := False;
    edtAntIc5.Enabled := False;
  End;

  fraPessoasCTE          := TfraPessoasCTE.Create(Self);
  fraPessoasCTE.Parent   := pnlContainerPessoas;
  fraPessoasCTE.FormPai  := Self;
  fraPessoasCTE.Container := pnlContainerPessoas;
  fraPessoasCTE.ControleQueReceberaOFocoAoTerminar := btnGravar;
  fraPessoasCTE.pInicializaComponentes(True);
  fraPessoasCTE.Top      := pnlContainerPessoas.Top + 2;
  fraPessoasCTE.Left     := pnlContainerPessoas.Left + 2;

  objFrameCtaPagar:= TFrameContaPagar.Create;
end;

procedure TfrmEntFreConhecimento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6: btnCfgPis.Click;
    VK_F7: btnCfgCof.Click;
    VK_F8: btnOutDes.Click;
    VK_F9: btnBarBol.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgProdutos) Then
               Begin
                 If cxvProdutos.Controller.FocusedColumn= cxvProdutosPERFRE Then
                 Begin
                   pCalculaPercentualEquivalFrete;
                   cxvProdutos.Controller.FocusNextCell(True);
                 End
                 Else
                 Begin
                   pCalculaPercentualEquivalFrete;
                   cxvProdutos.NavigatorButtons.Next.Click;
                 End;
               End;
  End;

end;

procedure TfrmEntFreConhecimento.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntFreConhecimento.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) And
     fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrSel) then
     if fValidaCampos(edtCodPor) then
       Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmEntFreConhecimento.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;

Begin

  If fPesqFornecedor(conForSimples, Self, edtCodTra, edtDesTra, qryCadFor, Key, arrFornec) Then
  Begin

    If fValidaCampos(edtCodTra,True) Then
      Self.SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmEntFreConhecimento.edtNotEntExit(Sender: TObject);
begin
  inherited;
  edtNotEnt.Text := fStrZero(edtNotEnt.Text, edtNotEnt.TamCampo);
end;

procedure TfrmEntFreConhecimento.edtNumDocExit(Sender: TObject);
begin
  inherited;
  edtNumDoc.Text := fStrZero(edtNumDoc.Text, edtNumDoc.TamCampo);
end;

procedure TfrmEntFreConhecimento.pCarregaFornecedor;
var
  fornecedor: TFornecedorDTO;
begin

  fornecedor := fRetFornecedorDTO(edtCodTra.Text);

  edtDesTra.Text := fornecedor.Nome;
  if mskConPag.Text ='' then
  begin
    mskConPag.Text := fornecedor.CondPagamento;
    mskConPag.OnExit(Self);
  end;

  if edtCodPor.Text = '' then
  begin
    edtCodPor.Text := fornecedor.Portador;
    edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
  end;

  if fraCtaPagar.edtCodCta.Text = '' then
  begin
    fraCtaPagar.edtCodCta.Text := fornecedor.PlanoContas;
    pCarregaCentroCusto;
    fraCtaPagar.edtCodCta.OnExit(Self);
  end;
end;

procedure TfrmEntFreConhecimento.pgcFreteChange(Sender: TObject);
begin
  inherited;

  If pgcFrete.ActivePage = tbsRateioFrete Then
  Begin

    If objFreCon.fIncluiProdutosRateioNotas And
       (Not Assigned(cxvProdutos.DataController.DataSource)) Then
      cxvProdutos.DataController.DataSource := objFreCon.cdsRateioProdutos.dtsSource;

    edtPerFreNota.Text := FormatFloat(fMskDigitos(2), objFreCon.fPercentualFreteSobreNotas(fTotalFrete));
    edtValorFreNota.Text:= FormatFloat(fMskDigitos(2), fRetSomaFreteConhecimentoDigitados(cxvProdutos.DataController.DataSource.DataSet));

  End;

end;

Function TfrmEntFreConhecimento.fTotalFrete: Double;
Begin
  If Assigned(objFreCon) Then
  Begin
    If objFreCon.blnVarNot Then
      Result := objFreCon.fltTotTodosFretes - fltFreteOriginal + fStrToFloat(edtValDoc.Text)
    Else
      Result := fStrToFloat(edtValDoc.Text);
  End

  Else Result := 0;
End;

procedure TfrmEntFreConhecimento.edtChaveAcessoExit(Sender: TObject);
begin
  inherited;

  cbxCodMod.Items.CommaText := fRetornaDadosModFis(edtChaveAcesso.Text);
  cbxCODMOD.ItemIndex := cbxCODMOD.Items.IndexOf(objFreCon.strModelo);
end;

procedure TfrmEntFreConhecimento.edtClaFi1Exit(Sender: TObject);
begin
  inherited;

  If Not objFreCon.fCarregaAbreviacaoPisCof(edtClaFi1.text) Then
    pSetFocus(edtClaFi1);

end;

procedure TfrmEntFreConhecimento.edtClaFi1KeyPress(Sender: TObject; var Key: Char);
  Var
    arrCFOP: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CFOP       *}
  {****************************RV*}
  If fPesqCFOP(Self, (Sender As TEditFocus), Nil, Nil, Key, arrCFOP) Then
  Begin
    If fValidaCampos((Sender As TEditFocus), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntFreConhecimento.edtValDocExit(Sender: TObject);
begin
  inherited;

  pHabilitaCodBarras;
end;

procedure TfrmEntFreConhecimento.edtValIc1Enter(Sender: TObject);
begin
  inherited;
  edtValIc1.Text := FloatToStrF((fStrToFloat(edtBasIc1.Text) * fStrToFloat(edtAlqIc1.Text))/100, ffFixed,12,2);
end;

procedure TfrmEntFreConhecimento.edtValIc2Enter(Sender: TObject);
begin
  inherited;
  edtValIc2.Text := FloatToStrF((fStrToFloat(edtBasIc2.Text) * fStrToFloat(edtAlqIc2.Text))/100, ffFixed,12,2);
end;

procedure TfrmEntFreConhecimento.edtValIc3Enter(Sender: TObject);
begin
  inherited;
  edtValIc3.Text := FloatToStrF((fStrToFloat(edtBasIc3.Text) * fStrToFloat(edtAlqIc3.Text))/100, ffFixed,12,2);
end;

procedure TfrmEntFreConhecimento.edtValIc4Enter(Sender: TObject);
begin
  inherited;
  edtValIc4.Text := FloatToStrF((fStrToFloat(edtBasIc4.Text) * fStrToFloat(edtAlqIc4.Text))/100, ffFixed,12,2);
end;

procedure TfrmEntFreConhecimento.edtValIc5Enter(Sender: TObject);
begin
  inherited;
  edtValIc5.Text := FloatToStrF((fStrToFloat(edtBasIc5.Text) * fStrToFloat(edtAlqIc5.Text))/100, ffFixed,12,2);
end;

procedure TfrmEntFreConhecimento.pTrataCamposICMS;
Var
  LblnSIMPAU: Boolean;
begin
  If (objFreCon.tpFrete = tpfEntrada) Then
  Begin
    LblnSIMPAU := fCfgSis('SIMPAU', varBoolean);
    edtBasIc1.Enabled := Not LblnSIMPAU;
    edtAlqIc1.Enabled := Not LblnSIMPAU;
    edtValIc1.Enabled := Not LblnSIMPAU;
    edtBasIc2.Enabled := Not LblnSIMPAU;
    edtAlqIc2.Enabled := Not LblnSIMPAU;
    edtValIc2.Enabled := Not LblnSIMPAU;
    edtBasIc3.Enabled := Not LblnSIMPAU;
    edtAlqIc3.Enabled := Not LblnSIMPAU;
    edtValIc3.Enabled := Not LblnSIMPAU;
    edtBasIc4.Enabled := Not LblnSIMPAU;
    edtAlqIc4.Enabled := Not LblnSIMPAU;
    edtValIc4.Enabled := Not LblnSIMPAU;
    edtBasIc5.Enabled := Not LblnSIMPAU;
    edtAlqIc5.Enabled := Not LblnSIMPAU;
    edtValIc5.Enabled := Not LblnSIMPAU;
    edtBasIcT.Enabled := Not LblnSIMPAU;
    edtAlqIcT.Enabled := Not LblnSIMPAU;
    edtValIcT.Enabled := Not LblnSIMPAU;
  End;
end;

end.

