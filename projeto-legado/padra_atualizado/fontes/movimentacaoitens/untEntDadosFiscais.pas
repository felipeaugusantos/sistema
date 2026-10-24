{***************************}
{* qryConCfo -> CADCFO     *}
{************************JB*}
unit untEntDadosFiscais;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni,
  Grids, DBGridCitel, DBGrids, EditFocus, DB, StrUtils, Menus, AppEvnts,
  untfuncoesSimples, Math, BitBtnLockedIncrem, UniClientDataSet, UniDataSetProvider,
  Mask, MaskEditFocus, untEntEmbalagens, frxClass, frxExportCSVTestabilidade, untCfgCfopCst,
  untTypesSistema, ComboBoxFocus, untLiberacao, untCadImpostosNFS, untEntRetencaoNotaServico,
  Faturamento.Consignacao.Classes, untTPerfilDespachanteAduaneiro;

type
  TfrmEntDadosFiscais = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlTitulo: TPanel;
    pnlBotoesDadFis: TPanel;
    pnlDesIte: TPanel;
    dbgItens: TDBGridCitel;
    pnlValores: TPanel;
    btnConfirma: TBitBtnLocked;
    Label1: TLabel;
    edtDesIte: TEditFocus;
    Label2: TLabel;
    edtRefere: TEditFocus;
    Label3: TLabel;
    edtCodUni: TEditFocus;
    lblTotIte: TLabel;
    edtTotIte: TEditFocus;
    Label4: TLabel;
    edtDesEsp: TEditFocus;
    edtDesAce: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtValFre: TEditFocus;
    edtTotGer: TEditFocus;
    Label8: TLabel;
    pgbDadosFiscais: TProgressBar;
    edtTotRet: TEditFocus;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    edtTotLiq: TEditFocus;
    edtTotIpi: TEditFocus;
    edtBasCof: TEditFocus;
    edtBasPis: TEditFocus;
    edtAlqCof: TEditFocus;
    edtAlqPis: TEditFocus;
    edtTotCof: TEditFocus;
    edtTotPis: TEditFocus;
    chkFreTri: TCheckBox;
    chkApliRed: TCheckBox;
    chkRetFre: TCheckBox;
    lblTotAnt: TLabel;
    edtTotAnt: TEditFocus;
    lblBasPis: TLabel;
    lblBasCof: TLabel;
    lblAlqPis: TLabel;
    lblAlqCof: TLabel;
    lblTotPis: TLabel;
    lblTotCof: TLabel;
    chkAbaDes: TCheckBox;
    lblDtaAnt: TLabel;
    mskDtaAnt: TMaskEditFocus;
    btnCalculaImpostos: TBitBtnLocked;
    btnCancelarEntrada: TBitBtnLocked;
    chkCreSub: TCheckBox;
    chkDescontoIncondicional: TCheckBox;
    pnlTipoFrete: TPanel;
    lbl1: TLabel;
    cbbTipFre: TComboBoxFocus;
    lblTotDes: TLabel;
    edtTotDes: TEditFocus;
    lblIcmDes: TLabel;
    lblDesPis: TLabel;
    edtICMDes: TEditFocus;
    edtDesPis: TEditFocus;
    btnCFOPTodos: TBitBtnLocked;
    lblPisCofinsCalcPorCfg: TLabel;
    pnlImpostosReforma: TPanel;
    lblBasRef: TLabel;
    edtBasRef: TEditFocus;
    lblAlqCbs: TLabel;
    edtAlqCbs: TEditFocus;
    lblVlrCbs: TLabel;
    edtVlrCbs: TEditFocus;
    lblAlqIbsUf: TLabel;
    edtAlqIbsUf: TEditFocus;
    lblVlrIbsUf: TLabel;
    edtVlrIbsUf: TEditFocus;
    lblAlqIbsMun: TLabel;
    edtAlqIbsMun: TEditFocus;
    lblVlrIbsMun: TLabel;
    edtVlrIbsMun: TEditFocus;
    lblBas_Is: TLabel;
    edtBas_Is: TEditFocus;
    lblAlq_Is: TLabel;
    edtAlq_Is: TEditFocus;
    lblVlr_Is: TLabel;
    edtVlr_Is: TEditFocus;
    pnlCfop: TPanel;
    Label7: TLabel;
    edtClaFis: TEditFocus;
    cmbNatOpe: TComboBoxFocus;
    pnlImpostos: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    lblBasAnt: TLabel;
    lblValAnt: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    edtCodFis: TEditFocus;
    edtVlrCon: TEditFocus;
    edtAlqIcm: TEditFocus;
    edtValIcm: TEditFocus;
    edtBasIpi: TEditFocus;
    edtAlqIpi: TEditFocus;
    edtValIpi: TEditFocus;
    edtIsento: TEditFocus;
    edtBasRet: TEditFocus;
    edtOutras: TEditFocus;
    edtBasIcm: TEditFocus;
    edtValRet: TEditFocus;
    edtBasAnt: TEditFocus;
    edtValAnt: TEditFocus;
    edtVleIpi: TEditFocus;
    edtVleRet: TEditFocus;
    edtBaeIpi: TEditFocus;
    edtAleIPI: TEditFocus;
    edtBaeRet: TEditFocus;
    edtValorFCP: TEditFocus;
    edtAliqFcp: TEditFocus;
    edtBasfcp: TEditFocus;
    edtBasfcpSub: TEditFocus;
    edtValorFCPSub: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelarEntradaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCalculaImpostosClick(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtTotIpiExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkFreTriClick(Sender: TObject);
    procedure edtValFreExit(Sender: TObject);
    procedure chkApliRedClick(Sender: TObject);
    procedure edtDesAceExit(Sender: TObject);
    procedure chkCreSubClick(Sender: TObject);
    procedure edtDesEspExit(Sender: TObject);
    procedure chkAbaDesClick(Sender: TObject);
    procedure edtCodFisKeyPress(Sender: TObject; var Key: Char);
    procedure edtAlqCofExit(Sender: TObject);
    procedure cbbTipFreExit(Sender: TObject);
    procedure cbbTipFreChange(Sender: TObject);
    procedure edtValFreEnter(Sender: TObject);
    procedure edtClaFisExit(Sender: TObject);
    procedure edtClaFisChange(Sender: TObject);
    procedure btnCFOPTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    strClaSub: String;
    frmEntRetencaoNotaServico: TfrmEntRetencaoNotaServico;
    qryConCfo: TUniQuery;
    cdsCadFis: TUniClientDataSet;
    blnSeparaICMDesoneradoDoDesconto,
    blnTemAnt: Boolean;
    strValFreEntObj: String;

    strEstEmp: String;

    fltBasRetFre: Double;  // BASE DE SUBSTITUICAO PARA FRETE
    fltBasAntFre: Double;  // BASE DE ANTECIPACAO  PARA FRETE

    fltAntFre: Double;     // TOTAL DE ICMS ANTECIPADO SOBRE FRETE + DESP ACESS;
    fltSubFre: Double;     // TOTAL DE ICMS SUBSTIUIDO SOBRE FRETE + DESP ACESS;

    fltTotIpiSav: Double;
    tipRatFrete: TTipoRateioFrete;
    objLiberacao : TLiberacao;

    FblnAcessadoViaRetornoConsignacao : Boolean;
    FTipoRetornoConsignacao           : tTipoRetornoConsignacao;

    FblnExibeReforma: Boolean;

    Function fIgualaCFOP(blnMensagem: Boolean): Boolean;
    Function fTemCFOP(strClaFis: String): Integer;
    Function fEstaNaClaCom(strClaFis: String): Boolean;
    function fValidaCFOPsItens: Boolean;

    Procedure pUpdateCFOP(strClaFis: String);
    procedure pHabilitaRateioFrete;
    procedure pInicializaClaSub;
    procedure pRecalculaIpi(blnValIpi: Boolean);
    procedure pHabilitaCheksTributacao;
    procedure pHabilitaTotSub;
    procedure pAtualizaEdtTotSub;

    procedure pDesabilitaCamposNFE;

    procedure pAtualizaTabela;

    procedure pCalculaTotalGeral;
    procedure pRecalculaTotalGeral(blnValIpi: Boolean = False);
    procedure pRecalculaValores;
    procedure pRecalculaValoresReforma(const AblnImpostoSeletivo: Boolean);

    procedure pAjustaCamposReforma;
    procedure pAjustaAlturaValores;
    function fValorReformaTela: Double;
    // Coluna da alíquota em uso no item: a efetiva (com redução) quando > 0, senão a nominal
    function fCampoAlqReforma(const ADataSet: TDataSet; const AstrCampoNominal: String): String;
    procedure pGetTextAlqReforma(Sender: TField; var Text: String; DisplayText: Boolean);

    procedure pAtualizaEdits(DataSet: TDataSet);
    procedure pLimpaEdits;

    procedure pDesabilitaPraticado;

    procedure pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
    procedure pHabilitaCamposValores(const AblnHabilita: Boolean);
    function fAtualizaItem: Boolean;
    function fConfirmaItemEditado: Boolean;

    Function fCalculaPisCofins: Boolean;

    Function fRetDescontoDaTela: Double;
    Function fValidaDescontos: Boolean;

    procedure pCalculaTotaisCabecalho;

    procedure pCalculaResumoDadosFiscais(strNumDoc, strSerie, strEspDoc, strCodFor: String;
      dtaDtaDoc, dtaDtaEnt: TDateTime; fltAlqEst: Double; strClaFis: String);

    procedure pCopiaTabela( strOrigem, strDestino: String );

    procedure pRecalculaSubstituicao;
    procedure pRateiaBasRetFrete;
    procedure pUpdateBasRet(fltBasRet: Double; strAutInc: String);
    procedure pUpdateBasAnt(fltBasAnt, fltValAnt: Double; strAutInc: String);

    Function fRetMaiorIVA: Double;
    function fRetAlqProdTributado: Double;
//    function fZerarPisCofins: Boolean;

    function fLiberaDivengencia: Boolean;

    procedure pTrocaValoresSubstituicao(strClaSub: String);

    procedure pRestauraDadosAnteriores;

    procedure pAtualizaDadosICMSAntecipado;
    procedure pDesmarcaICMSAntecipado;

    procedure pAtualizaColunasGridClaSub;

    function fTemItemComIpi: Boolean;

    function fValidaValorContabil(strClaFis: String;
                                  fltBasIcm,
                                  fltValIpi,
                                  fltVleIpi,
                                  fltValRet,
                                  fltVleRet,
                                  fltIsento,
                                  fltOutras,
                                  fltVlrCon,
                                  fltDesEsp,
                                  fltVFcpSt,
                                  fltReforma: Double): Boolean;
    function fPedeSenhaAlteracaoFrete: Boolean;
    function fValidaCodFiscal: Boolean;
    procedure pCarregaNatOperacao(strCodCfo: String);
    procedure pAtualizaComboNatOpe;
    procedure pSetaComboNatOpe(strClaFis: String);
    Function fValidaCodFiscalDosItens: Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pDeterminaTipoDeFrete;
  public
    fAoConfirmarEntrada: TAoConfirmarDocumento;
    { Public declarations }
    blnAutomatico: Boolean;
    blnTravarFinanceiroEstaDuplicado: Boolean;
    fltCotDol: Double;
    blnPresencial,
    blnPrecoPraticado,
    blnPedFilialGarantia: Boolean;
    blnZonFra: Boolean;
    strAutDev: String;
    blnSintet: Boolean;
    objEmbala: TEntEmbalagens;
    blnSimPau: Boolean;
    fltRetIte: Double;
    blnZeraIcmsDevolucao: Boolean;
    blnFulfillment: Boolean;
    PerfilDespachanteAduaneiro: TPerfilDespachanteAduaneiro;

    objExcecaoCfopCst: TCfgCfopCst;

    blnFornJaAtualizado: Boolean;

    blnEncargosNoFrete,
    blnCarPro: Boolean;
    recNotEle: TRecInfoNotaEletronica;
    fltDesEsp: Double;
    fltDesAce: Double;
    fltValFre: Double;
    fltTotRet: Double;
    fltTotAnt: Double; // TOTAL DE ICMS ANTECIPADO DOS PRODUTOS (SEM A PARTE DO FRETE)
    fltTotOri: Double;
    fltTotLiq: Double;
    fltTotIpi: Double;
    fltTotGPC: Double;

    fltTotIte: Double;
    fltTotIteRet: Double;

    strEstFor: String;
    strIesFor: String;
    strTipFor: String;
    strCgcCpf: String;
    strTipCgcCpf: String;
    fltAlqFor: Double;

    strCodFaz: String;

    strNumDoc: String;
    strSerie : String;
    strEspDoc: String;
    strCodFor: String;
    strCodRep: String;
    strCodVen: String;
    strPedDev: String;

    strOrdIte: String;

    dtaDtaDoc: TDateTime;
    dtaDtaEnt: TDateTime;

    strVeiBol: String;
    strDeposi: String;
    strCodEve: String;
    strCodCta: String;
    strBcoFor: String;

    qryEntMer: TUniQuery;
    dtsEntMer: TDataSource;

    stlPedidos: TStringList;

    strConpag: String;

    blnConEqu: Boolean;
    blnLocEqu: Boolean;
    blnDevolu: Boolean;
    blnConfirma: Boolean;
    blnGarantia: Boolean;
    cdsMovGad  : TUniClientDataSet;
    blnRecCliGarantia: Boolean;

    fltTotRetOri: Double;
    blnNotaImp : Boolean;

    arrDocOri: TStringArrayArray;
    strSeqGer: String;
    strFreOri: String;
    strChaNFe: String;
    strDocSel: String;

    arrClienteConsumidor: TStringArray;

    onBeforeConfirmaEntrada : TGenericProcedure;
    onAfterConfirmaEntrada : TGenericProcedure;

    arrDuplicata: TarrDuplicataPointer;

    blnManterIpi: Boolean;
    fltDesEspRecCliGarantia: Double;
    strMatRev: String;

    procedure pShow;

    procedure pRetornaBasesParaFrete(Var fltTotBasRet, fltTotBasAnt: Double);

    procedure pCalculaTributacaoFrete(    fltValIVA,
                                          fltAlqFre,
                                          fltValFre: Double;
                                      Var fltBasRet,
                                          fltTotRet: Double);

    property blnAcessadoViaRetornoConsignacao : Boolean                 read FblnAcessadoViaRetornoConsignacao write FblnAcessadoViaRetornoConsignacao;
    property TipoRetornoConsignacao           : tTipoRetornoConsignacao read FTipoRetornoConsignacao           write FTipoRetornoConsignacao;

  end;


implementation
{$R+}

uses untFuncoes, untPai, untConsultas, untEntDadosFiscaisResumo, untFuncFat,
  untDigOcorrencia, untConstantes, untCalculoPisCofins, untFuncoesGenerica,
  untMsgValidacaoContabil, untEntTestaCFOPS, untEntradaAutomatizada,
  untFatDigCFOP;

{$R *.dfm}

{ TfrmDadosFiscais }

function TfrmEntDadosFiscais.fValidaValorContabil(strClaFis: String;
                                  fltBasIcm,
                                  fltValIpi,
                                  fltVleIpi,
                                  fltValRet,
                                  fltVleRet,
                                  fltIsento,
                                  fltOutras,
                                  fltVlrCon,
                                  fltDesEsp,
                                  fltVFcpSt,
                                  fltReforma: Double): Boolean;
Begin
  {fltReforma: CBS + IBS + IS, parcela somada ao valor contábil fora de Outras/Isentas (como no livro fiscal)}
  Result := (fFormataFloat(fltBasIcm +
                           fltValIpi +
                           fltVleIpi +
                           fltValRet +
                           fltVleRet +
                           fltIsento +
                           fltVFcpSt +
                           fltOutras +
                           fltReforma, 2) = fFormataFloat(fltVlrCon, 2));

  If Not Result Then
    Result := (fFormataFloat(fltBasIcm +
                             fltValRet +
                             fltVleRet +
                             fltIsento +
                             fltVFcpSt +
                             fltOutras +
                             fltReforma, 2) = fFormataFloat(fltVlrCon, 2));

  If Not Result Then
    Result := (fFormataFloat(fltBasIcm / 2 +
                            fltValIpi +
                            fltVleIpi +
                            fltValRet +
                            fltVleRet +
                            fltIsento +
                            fltVFcpSt +
                            fltOutras +
                            fltReforma, 2) = fFormataFloat(fltVlrCon, 2)) And
               (Pos(strClaFis, '1910_2910') > 0);

   If (Not Result) And fConsideraICMSDesoneradoComDesconto(strEstEmp) Then
     Result := (fFormataFloat(fltBasIcm
                             - fltDesEsp
                             + fltValIpi
                             + fltVleIpi
                             + fltValRet
                             + fltVleRet
                             + fltIsento
                             + fltVFcpSt
                             + fltOutras
                             + fltReforma, 2) = fFormataFloat(fltVlrCon, 2));

  If Not Result Then
    Result := LeftStr(strClaFis, 1) = '3';
End;

function TfrmEntDadosFiscais.fTemItemComIpi: Boolean;
  Var
    qryEntrada: TUniQuery;
Begin
  qryEntrada := fCriaQuery(Self);
  With qryEntrada, SQL Do
  Begin
    Clear;
    Add('SELECT COUNT(*) AS QTDIPI FROM TMP_ENTTMP');
    Add('WHERE (ENT_VALIPI > 0) OR (ENT_VAEIPI > 0)');

    Open;

    Result := FieldByName('QTDIPI').AsInteger > 0;

    Close;
  End;
  FreeAndNil(qryEntrada);
End;

function TfrmEntDadosFiscais.fLiberaDivengencia: Boolean;
Begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Valores do XML divergentes dos valores da Entrada de Mercadorias');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('NUMERO DO DOCUMENTO', strNumDoc + '-' + strEspDoc + '-' + VS_strCodEmp + '-' + strSerie);
  objLiberacao.objMsgLibera.pAddTextoCaption('FORNECEDOR'         , strCodFor + '-' + fRetNomFornecedor(strCodFor));
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('ITEM'               , qryEntMer.FieldByName('ENT_CODITE').AsString + '-' + qryEntMer.FieldByName('ENT_DESITE').AsString);
  objLiberacao.objMsgLibera.pAddTextoCaption('CST DO XML'         , qryEntMer.FieldByName('ENT_SITXML').AsString + ', CST INFORMADA: ' + edtCodFis.Text + '.');

  objLiberacao.strDirAce := 'XMLDIF';
  objLiberacao.strSenLib := fCfgSis('XMLDIF');
  objLiberacao.strMsgSen := 'XML Divergente';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  objLiberacao.Clear;
End;

function TfrmEntDadosFiscais.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intDigCla: Integer; // primeiro numero do CFOP
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDesEsp) Then
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

      Else
      Begin
        edtTotLiq.Text := FormatFloat(fMskDigitos(2), ( fStrToFloat( edtTotIte.Text ) - fRetDescontoDaTela ));
      End;
    End

    Else If (Sender = edtICMDes) Then
    Begin

      If fEmptyStr(edtICMDes.Text) Then
      Begin
        edtICMDes.Text := '0,00';
      End
      Else If fStrToFloat(edtICMDes.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto de ICMS Desonerado deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtICMDes.Text) >= fStrToFloat(edtTotIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto de ICMS Desonerado deve ser menor que o total dos Itens!', ['&O k']);
        Result := False;
      End

      Else
      Begin
        edtTotLiq.Text := FormatFloat(fMskDigitos(2), ( fStrToFloat( edtTotIte.Text ) - fRetDescontoDaTela ));
      End;
    End

    Else If (Sender = edtDesPis) Then
    Begin

      If fEmptyStr(edtDesPis.Text) Then
      Begin
        edtDesPis.Text := '0,00';
      End
      Else If fStrToFloat(edtDesPis.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto de PIS/COFINS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtDesPis.Text) >= fStrToFloat(edtTotIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto de PIS/COFINS deve ser menor que o total dos Itens!', ['&O k']);
        Result := False;
      End

      Else
      Begin
        edtTotLiq.Text := FormatFloat(fMskDigitos(2), ( fStrToFloat( edtTotIte.Text ) - fRetDescontoDaTela ));
      End;
    End

    Else If (Sender = mskDtaAnt) Then
    Begin

      If mskDtaAnt.Visible Then
      Begin

        If fEmptyDate(mskDtaAnt.Text) Then
        Begin
          pMensagemOk('Informe a Data de Vencimento do ICMS antecipado!');
          Result := False;
        End

        Else If StrToDateDef(mskDtaAnt.Text, 0) < VS_Date Then
        Begin
          pMensagemOk('A Data de Vencimento do ICMS antecipado deve ser maior ou igual a data atual!');
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtDesAce) Then
    Begin
      If fEmptyStr(edtDesAce.Text) Then
      Begin
        edtDesAce.Text := '0,00';
      End
      Else If fStrToFloat(edtDesAce.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa acessória deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pCalculaTotalGeral;
      End;
    End

    Else If (Sender = edtTotIpi) Then
    Begin

      If fEmptyStr(edtTotIpi.Text) Then
      Begin
        edtTotIpi.Text := '0,00';
      End
      Else If fStrToFloat(edtTotIpi.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Total de IPI deve ser maior ou igual a Zero !', ['&O k']);
        Result := False;
      End

      Else If (fStrToFloat(edtTotIpi.Text) > 0) And (Not fTemItemComIpi) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para informar um valor de IPI é necessário que haja pelo menos um item com Valor de IPI maior que zero na nota!', ['&O k']);
        Result := False;
      End

      Else If blnBuscaPorChave Then
      Begin
        pCalculaTotalGeral;
      End;

    End

    Else If (Sender = edtTotRet) Then
    Begin

      If fEmptyStr(edtTotRet.Text) Then
      Begin
        edtValFre.Text := '0,00';
      End
      Else If fStrToFloat(edtTotRet.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Substituição deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pCalculaTotalGeral;
      End;

    End

    Else If (Sender = edtValFre) Then
    Begin
      If fEmptyStr(edtValFre.Text) Then
      Begin
        edtValFre.Text := '0,00';
      End
      Else If fStrToFloat(edtValFre.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Frete deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If Not fPedeSenhaAlteracaoFrete then
      Begin
        Result := False
      End
      Else
      Begin
        pCalculaTotalGeral;

        If blnBuscaPorChave Then
          edtValFreExit(edtValFre);
      End;
    End

    Else If (Sender = edtClaFis) Then
    Begin

      If fEmptyStr(edtClaFis.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CFOP deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        intDigCla := StrToInt(Copy(edtClaFis.Text, 1, 1));
        If (Not fVerificaClaFisExiste(edtClaFis.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse CFOP não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*****************************************}
        {* VALIDA CFOP INVÁLIDO PARA ENTRADA     *}
        {**************************************MV*}
        Else If (intDigCla >= 5) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação não permitida para nota de entrada!', ['&O k']);
          Result := False;
        End

        Else If (Not qryEntMer.IsEmpty) And blnConEqu And (Pos(edtClaFis.Text, fTransform(fCfgSis('CLACON'), 4)) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação não permitida para a operação de entrada de conserto de equipamento!', ['&O k']);
          Result := False;
        End
        Else If (Not qryEntMer.IsEmpty) And (AnsiEndsText('933', edtClaFis.Text)) And
                (qryEntMer.FieldByName('ENT_CODITE').AsString <> fCfgSis('ITESER')) And
                (qryEntMer.FieldByName('ENT_CODITE').AsString <> fCfgSis('SERTER')) And
                (qryEntMer.FieldByName('ENT_TIPPRO').AsString <> TIPO_PRODUTO_SPED[9,0]) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação permitida apenas para item de serviço!', ['&O k']);
          Result := False;
        End

        Else if ( RightStr(edtClaFis.Text, 3) = '353') then
        begin
          fMensagem('ATENÇÃO!', 'Classificação permitida apenas para Conhecimento de Frente!', ['&O k']);
          Result := False;
        end
        else if (strEstEmp = strEstFor) and (intDigCla <> 1) And (strEstFor <> 'EX') then
        begin
          fMensagem('ATENÇÃO!', 'Classificação permitida apenas para ' + IIf(blnDevolu, 'clientes', 'fornecedores') + ' de fora do estado!', ['&O k']);
          Result := False;
        end
        else if ((strEstEmp <> strEstFor) And (Not blnPresencial)) and (intDigCla <> 2) And (strEstFor <> 'EX') then
        begin
          fMensagem('ATENÇÃO!', 'Classificação permitida apenas para ' + IIf(blnDevolu, 'clientes', 'fornecedores') + ' de dentro do estado!', ['&O k']);
          Result := False;
        end
        else if blnNotaImp And (intDigCla <> 3) Then
        begin
          fMensagem('ATENÇÃO!', 'Indique uma classificação de nota de Importação!', ['&O k']);
          Result := False;
        end
        Else If (Not qryEntMer.IsEmpty) And
                (FblnAcessadoViaRetornoConsignacao) And
                (Pos(edtClaFis.Text, fTransform(fCfgSis('RETCON'), 4)) <= 0) And
                (Pos(edtClaFis.Text, fTransform(fCfgSis('CLADSC'), 4)) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'É permitido informar somente CFOP'+chr(39)+'S que estão vinculadas nas configurações!'+#13#10+
                                '(CFG_RETCON - Classificação Fiscal para Retorno de Mercadoria em Consignação) e'+#13#10+
                                '(CFG_CLADSC - Classificação Fiscal para Devolução Simbólica de Mercadoria em Consignação)', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtCodFis) Then
    Begin

      If edtCodFis.Enabled Then
      Begin

        If fEmptyStr(edtCodFis.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código Fiscal deve ser preenchido!', ['&O k']);
          Result := False;
        End

        Else If fEmptyStr(fRetSitTributaria(edtCodFis.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código Fiscal não encontrado!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtBasIcm) Then
    Begin

      If fEmptyStr(edtBasIcm.Text) Then
      Begin
        edtBasIcm.Text := '0,00';
      End
      Else If fStrToFloat(edtBasIcm.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A base de ICMS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaValores;

    End

    Else If (Sender = edtAlqIcm) Then
    Begin

      If fEmptyStr(edtAlqIcm.Text) Then
      Begin
        edtAlqIcm.Text := '0,00';
      End
      Else If fStrToFloat(edtAlqIcm.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota de ICMS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaValores;

    End

    Else If (Sender = edtBasfcpSub) Then
    Begin

      If fEmptyStr(edtBasfcpSub.Text) Then
      Begin
        edtBasfcpSub.Text := '0,00';
      End
      Else If fStrToFloat(edtBasfcpSub.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A base do Fundo de Combate a Pobreza Sub. deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaValores;

    End

    Else If (Sender = edtValorFCPSub) Then
    Begin

      If fEmptyStr(edtValorFCPSub.Text) Then
      Begin
        edtValorFCPSub.Text := '0,00';
      End
      Else If fStrToFloat(edtValorFCPSub.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Fundo de Combate a Pobreza Sub. deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaValores;

    End

    Else If (Sender = edtBasfcp) Then
    Begin

      If fEmptyStr(edtBasfcp.Text) Then
      Begin
        edtBasfcp.Text := '0,00';
      End
      Else If fStrToFloat(edtBasfcp.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Fundo de Combate a Pobreza deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(edtBasfcp.Text) > 0.0) And (fStrToFloat(edtValIcm.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Fundo de Combate a Pobreza deve ser Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaValores;

    End

    Else If (Sender = edtAliqFcp) Then
    Begin

      If fEmptyStr(edtAliqFcp.Text) Then
      Begin
        edtAliqFcp.Text := '0,00';
      End
      Else If fStrToFloat(edtAliqFcp.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota do Fundo de Combate a Pobreza deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else
        pRecalculaValores;

    End


    Else If (Sender = edtBasIpi) Then
    Begin

      If fEmptyStr(edtBasIpi.Text) Then
      Begin
        edtBasIpi.Text := '0,00';
      End
      Else If fStrToFloat(edtBasIpi.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A base de IPI deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pRecalculaTotalGeral;
      End;

    End

    Else If (Sender = edtAlqIpi) Then
    Begin

      If fEmptyStr(edtAlqIpi.Text) Then
      Begin
        edtAlqIpi.Text := '0,00';
      End
      Else If fStrToFloat(edtAlqIpi.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota de IPI deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        pRecalculaTotalGeral;
      End;

    End

    Else If (Sender = edtBasRet) Then
    Begin

      If fEmptyStr(edtBasRet.Text) Then
      Begin
        edtBasRet.Text := '0,00';
      End
      Else If fStrToFloat(edtBasRet.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Base de ICMS Substituído deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtValRet) Then
    Begin

      If fEmptyStr(edtValRet.Text) Then
      Begin
        edtValRet.Text := '0,00';
      End
      Else If fStrToFloat(edtValRet.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de ICMS Substituído deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtVleRet) Then
    Begin

      If fEmptyStr(edtVleRet.Text) Then
      Begin
        edtVleRet.Text := '0,00';
      End
      Else If fStrToFloat(edtVleRet.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Retido Não Creditado deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End


    Else If (Sender = edtBasAnt) And edtBasAnt.Visible Then
    Begin

      If fEmptyStr(edtBasAnt.Text) Then
      Begin
        edtBasAnt.Text := '0,00';
      End
      Else If fStrToFloat(edtBasAnt.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Base de ICMS Antecipado deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtValAnt) And edtValAnt.Visible Then
    Begin

      If fEmptyStr(edtValAnt.Text) Then
      Begin
        edtValAnt.Text := '0,00';
      End
      Else If fStrToFloat(edtValAnt.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de ICMS Antecipado deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = edtIsento) Then
    Begin

      If fEmptyStr(edtIsento.Text) Then
      Begin
        edtIsento.Text := '0,00';
      End
      Else If fStrToFloat(edtIsento.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Isentas deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End;

    End

    {Reforma: o valor é recalculado só quando o usuário digitou no campo (Modified), para não
     reescrever o valor vindo do XML (IS com alíquota específica por unidade não é base x alíquota)}
    Else If (Sender = edtBasRef) Then
    Begin

      If fEmptyStr(edtBasRef.Text) Then
      Begin
        edtBasRef.Text := '0,00';
      End
      Else If fStrToFloat(edtBasRef.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A base de IBS/CBS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If edtBasRef.Modified Then
        pRecalculaValoresReforma(False);

    End

    Else If (Sender = edtAlqCbs) Then
    Begin

      If fEmptyStr(edtAlqCbs.Text) Then
      Begin
        edtAlqCbs.Text := '0,00';
      End
      Else If fStrToFloat(edtAlqCbs.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota de CBS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If edtAlqCbs.Modified Then
        pRecalculaValoresReforma(False);

    End

    Else If (Sender = edtAlqIbsUf) Then
    Begin

      If fEmptyStr(edtAlqIbsUf.Text) Then
      Begin
        edtAlqIbsUf.Text := '0,00';
      End
      Else If fStrToFloat(edtAlqIbsUf.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota de IBS Estadual deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If edtAlqIbsUf.Modified Then
        pRecalculaValoresReforma(False);

    End

    Else If (Sender = edtAlqIbsMun) Then
    Begin

      If fEmptyStr(edtAlqIbsMun.Text) Then
      Begin
        edtAlqIbsMun.Text := '0,00';
      End
      Else If fStrToFloat(edtAlqIbsMun.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota de IBS Municipal deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If edtAlqIbsMun.Modified Then
        pRecalculaValoresReforma(False);

    End

    Else If (Sender = edtBas_Is) Then
    Begin

      If fEmptyStr(edtBas_Is.Text) Then
      Begin
        edtBas_Is.Text := '0,00';
      End
      Else If fStrToFloat(edtBas_Is.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A base do IS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else If edtBas_Is.Modified Then
        pRecalculaValoresReforma(True);

    End

    Else If (Sender = edtAlq_Is) Then
    Begin

      If fEmptyStr(edtAlq_Is.Text) Then
      Begin
        edtAlq_Is.Text := '0,00';
      End
      Else If fStrToFloat(edtAlq_Is.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Alíquota do IS deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If edtAlq_Is.Modified Then
          pRecalculaValoresReforma(True);

        {Último campo do item quando o pnlImpostosReforma está visível}
        If blnBuscaPorChave Then
          Result := fConfirmaItemEditado;
      End;

    End

    Else If (Sender = cbbTipFre) Then
    Begin

      If pnlTipoFrete.Visible And cbbTipFre.Enabled Then
      Begin

        If pnlTipoFrete.Visible And (cbbTipFre.ItemIndex = -1) And (fStrToFloat(edtValFre.Text) > 0) And cbbTipFre.Enabled Then
        Begin
          pMensagemOk('Informe o Tipo de Rateio para o Frete!');
          Result := False;
        End;
      End;

    End

    Else If (Sender = edtOutras) Then
    Begin

      If fEmptyStr(edtOutras.Text) Then
      Begin
        edtOutras.Text := '0,00';
      End
      Else If fStrToFloat(edtOutras.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Outras deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
       Else If blnBuscaPorChave And (Not FblnExibeReforma) Then
      Begin
        {Com o pnlImpostosReforma visível, o último campo passa a ser edtAlq_Is}
        Result := fConfirmaItemEditado;
      End;

    End;

  End;

  If Not Result Then
  Begin
    pSetFocus(Sender);
  End
  Else
  Begin
    //pRecalculaValores;
  End;
end;


function TfrmEntDadosFiscais.fConfirmaItemEditado: Boolean;
begin
  {Saída do último campo do item: confere o valor contábil e grava o item}
  Result := True;

  If Not fValidaValorContabil(edtClaFis.Text,
                              fStrToFloat(edtBasIcm.Text),
                              fStrToFloat(edtValIpi.Text),
                              fStrToFloat(edtVleIpi.Text),
                              fStrToFloat(edtValRet.Text),
                              fStrToFloat(edtVleRet.Text),
                              fStrToFloat(edtIsento.Text),
                              fStrToFloat(edtOutras.Text),
                              fStrToFloat(edtVlrCon.Text),
                              qryEntMer.FieldByName('ENT_DESESP').AsFloat,
                              qryEntMer.FieldByName('ENT_VFCPST').AsFloat,
                              fValorReformaTela) Then
  Begin
    pCriarFormularios(TfrmMsgValidacaoContabil, frmMsgValidacaoContabil);
    Try
      frmMsgValidacaoContabil.strClaSub := strClaSub;
      frmMsgValidacaoContabil.ShowModal;
    Finally
      pFreeAndNil(frmMsgValidacaoContabil);
    End;

    Result := False;
  End

  Else If (Not fEmptyStr(recNotEle.strAutInc)) And
          (Not fEmptyStr(qryEntMer.FieldByName('ENT_SITXML').AsString)) And
          (Not SameText(qryEntMer.FieldByName('ENT_SITXML').AsString, edtCodFis.Text)) And

          ((qryEntMer.FieldByName('ENT_CSTCAD').AsString = 'N') Or
           (Not SameText(edtCodFis.Text,
                         qryEntMer.FieldByName('ENT_CODFIS').AsString))
          ) And

          (Not fValidaCodFiscal) Then
  Begin
    Result := False;
  End

  Else
  Begin

    If fAtualizaItem Then
    Begin
      pRecalculaTotalGeral;
      {Req. 468382 - Total geral = soma do valor contábil dos itens, como depois do Calcula Impostos. A fórmula
       do cabeçalho (pCalculaTotalGeral) não tem IPI não creditado, FCP ST nem CBS/IBS/IS}
      pCalculaTotaisCabecalho;
      pLimpaEdits;
      pHabilitaCamposValores(False);
      dbgItens.Enabled := True;
      pSetFocus(dbgItens);
      btnConfirma.Enabled := True;
      pAtualizaEdits(Nil);
    End;
    blnMudarFoco := False;

  End;
end;

procedure TfrmEntDadosFiscais.pDeterminaTipoDeFrete;
Begin
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
end;

procedure TfrmEntDadosFiscais.pAtualizaDadosICMSAntecipado;
  Var
    qryUpdate: TUniQuery;
Begin
  If Not blnTemAnt Then
    Exit;

  qryUpdate := fCriaQuery(Self);

  With qryUpdate, SQL Do
  Begin
    Clear;
    Add('UPDATE TMP_ENTMER SET ');

    Add('  ENT_PERBAS = 0, ');
    Add('  ENT_BASICM = 0, ');
    Add('  ENT_ALQICM = 0, ');
    Add('  ENT_VALICM = 0, ');

    Add('  ENT_BASRET = 0, ');
    Add('  ENT_VALRET = 0, ');
    Add('  ENT_RETORI = 0  ');

    Add('WHERE ');
    Add('  ENT_ANTPRO = "S" ');

    ExecSQL;
  End;

  FreeAndNil(qryUpdate);
End;

procedure TfrmEntDadosFiscais.pDesmarcaICMSAntecipado;
  Var
    qryUpdate: TUniQuery;
Begin
  If Not blnTemAnt Then
    Exit;

  qryUpdate := fCriaQuery(Self);

  With qryUpdate, SQL Do
  Begin
    Clear;
    Add('UPDATE TMP_ENTMER SET ');
    Add('  ENT_ANTPRO = "N", ');
    Add('  ENT_ANTFRE = "S"  ');

    ExecSQL;
  End;

  FreeAndNil(qryUpdate);
End;

procedure TfrmEntDadosFiscais.pInicializaClaSub;
Begin
  strClaSub := fRegimeSubstituicaoTributaria;
  chkCreSub.Checked  := strClaSub = '2';
  pAtualizaColunasGridClaSub;
End;

procedure TfrmEntDadosFiscais.pAtualizaColunasGridClaSub;
Begin
{  If (strClaSub <> '1') Then
  Begin
    dbgItens.Columns[11].FieldName := 'ENT_BASRET';
    dbgItens.Columns[12].FieldName := 'ENT_VALRET';
  End
  Else
  Begin
    dbgItens.Columns[11].FieldName := 'ENT_BAERET';
    dbgItens.Columns[12].FieldName := 'ENT_VAERET';
  End;}
End;

procedure TfrmEntDadosFiscais.pHabilitaRateioFrete;
Begin
  If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    edtValFre.ReadOnly := True;
    edtValFre.TabStop  := False;

    edtDesAce.ReadOnly := True;
    edtDesAce.TabStop  := False;

    edtTotRet.ReadOnly := True;
    edtTotRet.TabStop  := False;
  End;
  cbbTipFre.Enabled := fStrToFloat(edtValFre.Text) > 0;
End;

procedure TfrmEntDadosFiscais.FormShow(Sender: TObject);
begin
  inherited;
  pShow;
end;

procedure TfrmEntDadosFiscais.pDesabilitaCamposNFE;
Begin
  If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    edtDesEsp.ReadOnly    := True;
    edtDesEsp.TabStop     := False;

    edtValFre.ReadOnly    := True;
    edtValFre.TabStop     := False;

    edtDesAce.ReadOnly    := True;
    edtDesAce.TabStop     := False;

    edtTotIpi.ReadOnly    := True;
    edtTotIpi.TabStop     := False;

    edtTotRet.ReadOnly    := True;
    edtTotRet.TabStop     := False;
  End;

  lblICMDes.Enabled := blnSeparaICMDesoneradoDoDesconto;
  edtICMDes.Enabled := blnSeparaICMDesoneradoDoDesconto;
  lblDesPis.Enabled := blnSeparaICMDesoneradoDoDesconto;

  If fCfgSis('SUFRAM', varBoolean) And (pnlCabecalho.Enabled) Then
  Begin
    lblDesPis.Enabled := fCfgSis('SUFRAM', varBoolean);
    edtDesPis.Enabled := fCfgSis('SUFRAM', varBoolean);
    edtDesPis.ReadOnly:= False;
  End
  Else
    edtDesPis.Enabled := blnSeparaICMDesoneradoDoDesconto;

  If blnSeparaICMDesoneradoDoDesconto Then
  Begin
    edtDesEsp.ReadOnly    := False;
    edtDesEsp.TabStop     := True;
  End;
End;

procedure TfrmEntDadosFiscais.pDesabilitaPraticado;
Begin
  If blnDevolu And blnPrecoPraticado Then
  Begin
    edtDesEsp.Enabled := False;
    edtDesAce.Enabled := False;
    edtTotIpi.Enabled := False;
    edtTotRet.Enabled := False;

    chkApliRed.Enabled := False;
    chkAbaDes.Enabled  := False;
    chkDescontoIncondicional.Enabled := False;
  End;
End;

procedure TfrmEntDadosFiscais.pAtualizaEdits;
begin

  With qryEntMer Do
  Begin
    edtClaFis.Text := FieldByName('ENT_CLAFIS').AsString;
    edtCodFis.Text := FieldByName('ENT_CODFIS').AsString;
    edtVlrCon.Text := FloatToStrF(FieldByName('ENT_VLRCON').AsFloat, ffFixed, 12, 2);
    edtAlqIcm.Text := FloatToStrF(FieldByName('ENT_ALQICM').AsFloat, ffFixed, 12, 2);
    edtValIcm.Text := FloatToStrF(FieldByName('ENT_VALICM').AsFloat, ffFixed, 12, 2);
    edtBasIcm.Text := FloatToStrF(FieldByName('ENT_BASICM').AsFloat, ffFixed, 12, 2);


    edtValIpi.Text := '0,00';
    edtAlqIpi.Text := '0,00';
    edtBasIpi.Text := '0,00';
    edtVleIpi.Text := '0,00';
    edtBaeIpi.Text := '0,00';
    edtAleIpi.Text := '0,00';

    edtBasRet.Text := '0,00';
    edtValRet.Text := '0,00';

    edtBaeRet.Text := '0,00';
    edtVleRet.Text := '0,00';


    If qryEntMer.FieldByName('ENT_BASIPI').AsFloat > 0 Then
    Begin


      edtBasIpi.Text := FloatToStrF(FieldByName('ENT_BASIPI').AsFloat, ffFixed, 12, 2);
      edtAlqIpi.Text := FloatToStrF(FieldByName('ENT_ALQIPI').AsFloat, ffFixed, 12, 2);
      edtValIpi.Text := FloatToStrF(FieldByName('ENT_VALIPI').AsFloat, ffFixed, 12, 2);
    End
    Else
    Begin



      edtVleIpi.Text := FloatToStrF(FieldByName('ENT_VAEIPI').AsFloat, ffFixed, 12, 2);
      edtBaeIpi.Text := FloatToStrF(FieldByName('ENT_BAEIPI').AsFloat, ffFixed, 12, 2);
      edtAleIpi.Text := FloatToStrF(FieldByName('ENT_ALEIPI').AsFloat, ffFixed, 12, 2);
    End;
    If FieldByName('ENT_VALRET').AsFloat > 0 Then
    Begin
      edtBasRet.Text := FloatToStrF(FieldByName('ENT_BASRET').AsFloat, ffFixed, 12, 2);
      edtValRet.Text := FloatToStrF(FieldByName('ENT_VALRET').AsFloat, ffFixed, 12, 2);
    End
    else
    Begin
      edtBaeRet.Text := FloatToStrF(qryEntMer.FieldByName('ENT_BAERET').AsFloat, ffFixed, 12, 2);
      edtVleRet.Text := FloatToStrF(qryEntMer.FieldByName('ENT_VAERET').AsFloat, ffFixed, 12, 2);
    End;

    edtBasAnt.Text := FloatToStrF(FieldByName('ENT_BASANT').AsFloat, ffFixed, 12, 2);
    edtValAnt.Text := FloatToStrF(FieldByName('ENT_VALANT').AsFloat, ffFixed, 12, 2);
    edtIsento.Text := FloatToStrF(FieldByName('ENT_ISENTO').AsFloat, ffFixed, 12, 2);
    edtOutras.Text := FloatToStrF(FieldByName('ENT_OUTRAS').AsFloat, ffFixed, 12, 2);

    edtBasfcpSub.Text   := FloatToStrF(FieldByName('ENT_BFCPST').AsFloat, ffFixed, 12, 2);
    edtValorFCPSub.Text := FloatToStrF(FieldByName('ENT_VFCPST').AsFloat, ffFixed, 12, 2);

    edtBasfcp.Text      := FloatToStrF(FieldByName('ENT_VBCFCP').AsFloat, ffFixed, 12, 2);
    edtAliqFcp.Text     := FloatToStrF(FieldByName('ENT_PERFCP').AsFloat, ffFixed, 12, 2);
    edtValorFCP.Text    := FloatToStrF(FieldByName('ENT_VALFCP').AsFloat, ffFixed, 12, 2);

    If FblnExibeReforma Then
    Begin
      edtBasRef.Text    := FloatToStrF(FieldByName('ENT_REFVBC').AsFloat, ffFixed, 12, 2);
      edtAlqCbs.Text    := FloatToStrF(FieldByName(fCampoAlqReforma(qryEntMer, 'ENT_RFCALQ')).AsFloat, ffFixed, 12, 4);
      edtVlrCbs.Text    := FloatToStrF(FieldByName('ENT_RFCVAL').AsFloat, ffFixed, 12, 2);
      edtAlqIbsUf.Text  := FloatToStrF(FieldByName(fCampoAlqReforma(qryEntMer, 'ENT_RFIUFA')).AsFloat, ffFixed, 12, 4);
      edtVlrIbsUf.Text  := FloatToStrF(FieldByName('ENT_RFIUFV').AsFloat, ffFixed, 12, 2);
      edtAlqIbsMun.Text := FloatToStrF(FieldByName(fCampoAlqReforma(qryEntMer, 'ENT_RFIMNA')).AsFloat, ffFixed, 12, 4);
      edtVlrIbsMun.Text := FloatToStrF(FieldByName('ENT_RFIMNV').AsFloat, ffFixed, 12, 2);
      edtBas_Is.Text    := FloatToStrF(FieldByName('ENT_RFSBAS').AsFloat, ffFixed, 12, 2);
      edtAlq_Is.Text    := FloatToStrF(FieldByName('ENT_RFSALQ').AsFloat, ffFixed, 12, 4);
      edtVlr_Is.Text    := FloatToStrF(FieldByName('ENT_RFSVLR').AsFloat, ffFixed, 12, 2);
    End;

    edtDesIte.Text := FieldByName('ENT_DESITE').AsString;
    edtRefere.Text := FieldByName('ENT_REFERE').AsString;
    edtCodUni.Text := FieldByName('ENT_CODUNI').AsString;
  End;

end;

function TfrmEntDadosFiscais.fAtualizaItem: Boolean;
  Var
    strSQL   : String;
    intRecNo : Integer;
    qryGenMer: TUniQuery;

begin
  Try


    Result := True;

    qryGenMer := fCriaQuery(Self);

    If Not fVerificaCampos Then
    Begin
      Result := False;
      Exit;
    End;

    intRecNo := qryEntMer.RecNo;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  TMP_ENTMER ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  ENT_CLAFIS = :CLAFIS, ';
    strSQL := strSQL + '  ENT_CODFIS = :CODFIS, ';
    strSQL := strSQL + '  ENT_NATOPE = :NATOPE, ';

    strSQL := strSQL + '  ENT_VLRCON = :VLRCON, ';
    strSQL := strSQL + '  ENT_BASICM = :BASICM, ';
    strSQL := strSQL + '  ENT_ALQICM = :ALQICM, ';
    strSQL := strSQL + '  ENT_VALICM = :VALICM, ';

(*
    strSQL := strSQL + '  ENT_BASIPI = :BASIPI, ';
    strSQL := strSQL + '  ENT_ALQIPI = :ALQIPI, ';
    strSQL := strSQL + '  ENT_VALIPI = :VALIPI, ';
*)

    If fCfgSis('LOTPRE',varBoolean) Then
    Begin
      strSQL := strSQL + '  ENT_IPIENT = :IPIENT, ';
      strSQL := strSQL + '  ENT_SUBSTI = ROUND(:SUBSTI / ENT_TOTITE * 100, 2), ';
    End;

    strSQL := strSQL + '  ENT_IPISUB = :VALIPI, ';
    strSQL := strSQL + '  ENT_BASRET = :BASRET, ';
    strSQL := strSQL + '  ENT_VALRET = :VALRET, ';
    strSQL := strSQL + '  ENT_BAERET = :BAERET, ';
    strSQL := strSQL + '  ENT_VAERET = :VAERET, ';
    strSQL := strSQL + '  ENT_BASANT = :BASANT, ';
    strSQL := strSQL + '  ENT_VALANT = :VALANT, ';
    strSQL := strSQL + '  ENT_ISENTO = :ISENTO, ';

    strSQL := strSQL + '  ENT_BFCPST = :BFCPST, ';
    strSQL := strSQL + '  ENT_VFCPST = :VFCPST, ';

    strSQL := strSQL + '  ENT_VALFCP = :VALFCP, ';
    strSQL := strSQL + '  ENT_VBCFCP = :BFCFCP, ';
    strSQL := strSQL + '  ENT_PERFCP = :PERFCP, ';

    If FblnExibeReforma Then
    Begin
      strSQL := strSQL + '  ENT_REFVBC = :REFVBC, ';
      strSQL := strSQL + '  ' + fCampoAlqReforma(qryEntMer, 'ENT_RFCALQ') + ' = :ALQCBS, ';
      strSQL := strSQL + '  ENT_RFCVAL = :VLRCBS, ';
      strSQL := strSQL + '  ' + fCampoAlqReforma(qryEntMer, 'ENT_RFIUFA') + ' = :ALQIUF, ';
      strSQL := strSQL + '  ENT_RFIUFV = :VLRIUF, ';
      strSQL := strSQL + '  ' + fCampoAlqReforma(qryEntMer, 'ENT_RFIMNA') + ' = :ALQIMN, ';
      strSQL := strSQL + '  ENT_RFIMNV = :VLRIMN, ';
      strSQL := strSQL + '  ENT_RFSBAS = :BAS_IS, ';
      strSQL := strSQL + '  ENT_RFSALQ = :ALQ_IS, ';
      strSQL := strSQL + '  ENT_RFSVLR = :VLR_IS, ';
      strSQL := strSQL + '  ENT_RFIVAL = :VLRIBS, ';
    End;

    strSQL := strSQL + '  ENT_OUTRAS = :OUTRAS ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

    With qryGenMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      {*****************************************}
      {* DADOS QUE SERÃO ATUALIZADOS           *}
      {**************************************MV*}
      ParamByName('CLAFIS').AsString := edtClaFis.Text;
      ParamByName('NATOPE').AsString := cmbNatOpe.Text;
      ParamByName('CODFIS').AsString := edtCodFis.Text;
      ParamByName('VLRCON').AsFloat  := fStrToFloat(edtVlrCon.Text);
      ParamByName('BASICM').AsFloat  := fStrToFloat(edtBasIcm.Text);
      ParamByName('ALQICM').AsFloat  := fStrToFloat(edtAlqIcm.Text);
      ParamByName('VALICM').AsFloat  := fStrToFloat(edtValIcm.Text);

(*      ParamByName('BASIPI').AsFloat  := fStrToFloat(edtBasIpi.Text);
      ParamByName('ALQIPI').AsFloat  := fStrToFloat(edtAlqIpi.Text);
      ParamByName('VALIPI').AsFloat  := fStrToFloat(edtValIpi.Text); *)

      If fCfgSis('LOTPRE',varBoolean) Then
      Begin
        qryGenMer.ParamByName('IPIENT').AsFloat  := fStrToFloat(edtAlqIpi.Text) + fStrToFloat(edtAleIPI.Text);
        ParamByName('SUBSTI').AsFloat  := fStrToFloat(edtValRet.Text) + fStrToFloat(edtValAnt.Text);
      End;

      If (strClaSub = '1') Then
      Begin
        ParamByName('BAERET').AsFloat  := fStrToFloat(edtBaeRet.Text);
        ParamByName('VAERET').AsFloat  := fStrToFloat(edtVleRet.Text);
        ParamByName('BASRET').AsFloat  := 0;
        ParamByName('VALRET').AsFloat  := 0;
      End
      Else
      Begin
        ParamByName('BASRET').AsFloat  := fStrToFloat(edtBasRet.Text);
        ParamByName('VALRET').AsFloat  := fStrToFloat(edtValRet.Text);
        ParamByName('BAERET').AsFloat  := 0;
        ParamByName('VAERET').AsFloat  := 0;
      End;

      ParamByName('BASANT').AsFloat  := fStrToFloat(edtBasAnt.Text);
      ParamByName('VALANT').AsFloat  := fStrToFloat(edtValAnt.Text);

      ParamByName('ISENTO').AsFloat  := fStrToFloat(edtIsento.Text);

      ParamByName('BFCPST').AsFloat  := fStrToFloat(edtBasfcpSub.Text);
      ParamByName('VFCPST').AsFloat  := fStrToFloat(edtValorFCPSub.Text);
      ParamByName('VALFCP').AsFloat  := fStrToFloat(edtValorFCP.Text);
      ParamByName('BFCFCP').AsFloat  := fStrToFloat(edtBasfcp.Text);
      ParamByName('PERFCP').AsFloat  := fStrToFloat(edtAliqFcp.Text);

      If FblnExibeReforma Then
      Begin
        ParamByName('REFVBC').AsFloat := fStrToFloat(edtBasRef.Text);
        ParamByName('ALQCBS').AsFloat := fStrToFloat(edtAlqCbs.Text);
        ParamByName('VLRCBS').AsFloat := fStrToFloat(edtVlrCbs.Text);
        ParamByName('ALQIUF').AsFloat := fStrToFloat(edtAlqIbsUf.Text);
        ParamByName('VLRIUF').AsFloat := fStrToFloat(edtVlrIbsUf.Text);
        ParamByName('ALQIMN').AsFloat := fStrToFloat(edtAlqIbsMun.Text);
        ParamByName('VLRIMN').AsFloat := fStrToFloat(edtVlrIbsMun.Text);
        ParamByName('BAS_IS').AsFloat := fStrToFloat(edtBas_Is.Text);
        ParamByName('ALQ_IS').AsFloat := fStrToFloat(edtAlq_Is.Text);
        ParamByName('VLR_IS').AsFloat := fStrToFloat(edtVlr_Is.Text);
        ParamByName('VLRIBS').AsFloat := fStrToFloat(edtVlrIbsUf.Text) +
                                         fStrToFloat(edtVlrIbsMun.Text);
      End;

      ParamByName('OUTRAS').AsFloat  := fStrToFloat(edtOutras.Text);

      {*****************************************}
      {* DADOS DO FILTRO                       *}
      {**************************************MV*}
      ParamByName('AUTINC').AsInteger := qryEntMer.FieldByName('AUTOINCREM').AsInteger;
      ExecSQL;
      Close;

    End;

    If (Pos(edtClaFis.Text, '1922_2922_1117_2117_') > 0) Then
      pUpdateCFOP(edtClaFis.Text);

    pAtualizaTabela;
    qryEntMer.RecNo := intRecNo;

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

procedure TfrmEntDadosFiscais.pAtualizaTabela;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_ENTMER ';
  If Not fEmptyStr(strOrdIte) Then
    strSQL := strSQL + 'ORDER BY ' + strOrdIte;

  With qryEntMer Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    (FieldByName('ENT_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_BASICM') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_ALQICM') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VALICM') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_BASIPI') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_ALQIPI') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VALIPI') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_ISENTO') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_BASRET') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VALRET') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_BAERET') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VAERET') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_BASANT') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VALANT') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_OUTRAS') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VFCPST') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_BFCPST') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_PERFCP') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VALFCP') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VBCFCP') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_VICMDE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ENT_DESCON') As TFloatField).DisplayFormat := '#,##0.00';

    If Assigned(FindField('ENT_RFCVAL')) Then
    Begin
      (FieldByName('ENT_REFVBC') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ENT_RFCVAL') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ENT_RFIUFV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ENT_RFIMNV') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ENT_RFSBAS') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ENT_RFSVLR') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('ENT_RFSALQ') As TFloatField).DisplayFormat := '#,##0.0000';
      FieldByName('ENT_RFCALQ').OnGetText := pGetTextAlqReforma;
      FieldByName('ENT_RFIUFA').OnGetText := pGetTextAlqReforma;
      FieldByName('ENT_RFIMNA').OnGetText := pGetTextAlqReforma;
    End;

  End;

end;

procedure TfrmEntDadosFiscais.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Return) Then
  Begin

    pAtualizaEdits(Nil);
    pHabilitaCamposValores(True);
    btnConfirma.Enabled := False;
    dbgItens.Enabled    := False;
    pSetFocus(edtClaFis);

  End
  Else If (Key = VK_Escape) Then
  Begin

    chkFreTri.Checked  := (fCfgSis('FRETRI', varBoolean));
    chkApliRed.Checked := (fCfgSis('REDSUB', varBoolean));
    pInicializaClaSub;

    pHabilitaCampos(pnlCabecalho, True);
    pHabilitaCampos(pnlTipoFrete, True);

    pHabilitaCamposValores(False);
    pHabilitaTotSub;

    pSetFocus(edtDesEsp);


    {*****************************************}
    {* VOLTA CONTEUDO ORIGINAL DA TABELA     *}
    {* PARA QUE POSSA APLICA DESCONTO        *}
    {**************************************MA*}
    pCopiaTabela( 'TMP_ENTTMP', 'TMP_ENTMER' );
    pRecalculaTotalGeral;

    dbgItens.Enabled    := False;
    btnConfirma.Enabled := False;
    pLimpaEdits;

    pDesabilitaPraticado;
    pHabilitaCheksTributacao;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmEntDadosFiscais.pLimpaEdits;
begin

  edtClaFis.Clear;
  edtCodFis.Clear;
  edtVlrCon.Clear;
  edtBasIcm.Clear;
  edtAlqIcm.Clear;
  edtValIcm.Clear;
  edtBasIpi.Clear;
  edtAlqIpi.Clear;
  edtValIpi.Clear;
  edtVleIpi.Clear;
  edtValRet.Clear;
  edtVleRet.Clear;
  edtBasRet.Clear;
  edtBasAnt.Clear;
  edtValAnt.Clear;
  edtIsento.Clear;
  edtOutras.Clear;
  edtBasfcpSub.Clear;
  edtValorFCPSub.Clear;
  edtBasfcp.Clear;
  edtAliqFcp.Clear;
  edtValorFCP.Clear;
  edtBasRef.Clear;
  edtAlqCbs.Clear;
  edtVlrCbs.Clear;
  edtAlqIbsUf.Clear;
  edtVlrIbsUf.Clear;
  edtAlqIbsMun.Clear;
  edtVlrIbsMun.Clear;
  edtBas_Is.Clear;
  edtAlq_Is.Clear;
  edtVlr_Is.Clear;

  edtDesIte.Clear;
  edtRefere.Clear;
  edtCodUni.Clear;

end;

procedure TfrmEntDadosFiscais.pRecalculaValores;
  Var
    fltValIcm,
    fltValFcp: Double;
//    fltValIpi: Double;
begin

  If (Not edtBasIcm.Enabled) Then
    Exit;

  If fEmptyStr(edtBasIcm.Text) Then
    edtBasIcm.Text := '0,00';

  If fEmptyStr(edtAlqIcm.Text) Then
    edtAlqIcm.Text := '0,00';

  If fEmptyStr(edtBasIpi.Text) Then
    edtBasIpi.Text := '0,00';

  If fEmptyStr(edtAlqIpi.Text) Then
    edtAlqIpi.Text := '0,00';

  If fEmptyStr(edtBasfcpSub.Text) Then
    edtBasfcpSub.Text := '0,00';

  If fEmptyStr(edtValorFCPSub.Text) Then
    edtValorFCPSub.Text := '0,00';

  If fEmptyStr(edtBasfcp.Text) Then
    edtBasfcp.Text := '0,00';

  If fEmptyStr(edtAliqFcp.Text) Then
    edtAliqFcp.Text := '0,00';

  If fEmptyStr(edtValorFCP.Text) Then
    edtValorFCP.Text := '0,00';

  fltValFcp := (fStrToFloat(edtBasfcp.Text) * fStrToFloat(edtAliqFcp.Text)) / 100.0;
  edtValorFCP.Text := FloatToStrF(fltValFcp, ffFixed, 12, 2);

  fltValIcm := (fStrToFloat(edtBasIcm.Text) * fStrToFloat(edtAlqIcm.Text)) / 100.0;
  edtValIcm.Text := FloatToStrF(fltValIcm, ffFixed, 12, 2);
end;

procedure TfrmEntDadosFiscais.pRecalculaValoresReforma(const AblnImpostoSeletivo: Boolean);
  Var
    fltReformaAnterior: Double;
begin
  fltReformaAnterior := fValorReformaTela;

  If AblnImpostoSeletivo Then
  Begin
    edtVlr_Is.Text := FloatToStrF((fStrToFloat(edtBas_Is.Text) * fStrToFloat(edtAlq_Is.Text)) / 100.0, ffFixed, 12, 2);
  End
  Else
  Begin
    { Base única de IBS e CBS, como no XML (vBC) e no MOVREF (REF_BASCAL) }
    edtVlrCbs.Text    := FloatToStrF((fStrToFloat(edtBasRef.Text) * fStrToFloat(edtAlqCbs.Text)) / 100.0, ffFixed, 12, 2);
    edtVlrIbsUf.Text  := FloatToStrF((fStrToFloat(edtBasRef.Text) * fStrToFloat(edtAlqIbsUf.Text)) / 100.0, ffFixed, 12, 2);
    edtVlrIbsMun.Text := FloatToStrF((fStrToFloat(edtBasRef.Text) * fStrToFloat(edtAlqIbsMun.Text)) / 100.0, ffFixed, 12, 2);
  End;

  { A Reforma é parcela somada ao valor contábil (untFuncoes.pRateiaImpostos), não repartida como
    Outras: o valor contábil do item acompanha a diferença }
  edtVlrCon.Text := FloatToStrF(fStrToFloat(edtVlrCon.Text) - fltReformaAnterior + fValorReformaTela, ffFixed, 12, 2);
end;

function TfrmEntDadosFiscais.fValorReformaTela: Double;
begin
  Result := 0;
  If Not FblnExibeReforma Then
    Exit;

  Result := fStrToFloat(edtVlrCbs.Text) +
            fStrToFloat(edtVlrIbsUf.Text) +
            fStrToFloat(edtVlrIbsMun.Text) +
            fStrToFloat(edtVlr_Is.Text);
end;

function TfrmEntDadosFiscais.fCampoAlqReforma(const ADataSet: TDataSet; const AstrCampoNominal: String): String;
  Var
    strCampoEfetiva: String;
begin
  If AstrCampoNominal = 'ENT_RFCALQ' Then
    strCampoEfetiva := 'ENT_RFCALE'
  Else If AstrCampoNominal = 'ENT_RFIUFA' Then
    strCampoEfetiva := 'ENT_RFIUFE'
  Else
    strCampoEfetiva := 'ENT_RFIMNE';

  { Efetiva vem preenchida só quando o XML tem redução de alíquota (gRed) }
  If ADataSet.FieldByName(strCampoEfetiva).AsFloat > 0 Then
    Result := strCampoEfetiva
  Else
    Result := AstrCampoNominal;
end;

procedure TfrmEntDadosFiscais.pGetTextAlqReforma(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  Text := FormatFloat('#,##0.0000', Sender.DataSet.FieldByName(fCampoAlqReforma(Sender.DataSet, Sender.FieldName)).AsFloat);
end;

procedure TfrmEntDadosFiscais.pAjustaCamposReforma;
  Const
    CAMPOS_REFORMA: Array[0..9] Of String = ('ENT_REFVBC', 'ENT_RFCALQ', 'ENT_RFCVAL', 'ENT_RFIUFA', 'ENT_RFIUFV',
                                             'ENT_RFIMNA', 'ENT_RFIMNV', 'ENT_RFSBAS', 'ENT_RFSALQ', 'ENT_RFSVLR');
  Var
    blnExibir: Boolean;
    intContador: Integer;
    Column: TColumn;
begin
  { Mesma condição que soma a Reforma no valor contábil (untFuncoes.pRateiaImpostos) }
  blnExibir := fSomarNovosImpostosDaReformaAoValorContabil And Assigned(qryEntMer.FindField('ENT_RFCVAL'));

  For intContador := Low(CAMPOS_REFORMA) To High(CAMPOS_REFORMA) Do
  Begin
    Column := fFindColumnByName(dbgItens, CAMPOS_REFORMA[intContador]);
    If Assigned(Column) Then
      Column.Visible := blnExibir;
  End;

  pnlImpostosReforma.Visible := blnExibir;
  pAjustaAlturaValores;

  FblnExibeReforma := blnExibir;
end;

procedure TfrmEntDadosFiscais.edtAlqCofExit(Sender: TObject);
begin
  inherited;
  pSetFocus(cbbTipFre);
end;

procedure TfrmEntDadosFiscais.edtClaFisChange(Sender: TObject);
begin
  inherited;
  pAtualizaComboNatOpe;
end;

procedure TfrmEntDadosFiscais.pSetaComboNatOpe(strClaFis: String);
begin
  If Not(fEmptyStr(strClaFis)) Then
  Begin
    pCarregaNatOperacao(strClaFis);

    If Not(fEmptyStr(qryEntMer.FieldByName('ENT_NATOPE').AsString)) Then
      cmbNatOpe.ItemIndex := cmbNatOpe.Items.IndexOf(qryEntMer.FieldByName('ENT_NATOPE').AsString)
    Else
      pAtualizaComboNatOpe;
  End;
end;

procedure TfrmEntDadosFiscais.edtClaFisExit(Sender: TObject);
begin
  inherited;
  pSetaComboNatOpe(edtClaFis.Text);
end;

procedure TfrmEntDadosFiscais.edtClaFisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCFOP: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CFOP       *}
  {****************************RV*}
  If fPesqCFOP(Self, edtClaFis, Nil, Nil, Key, arrCFOP) Then
  Begin
    If fValidaCampos(edtClaFis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntDadosFiscais.edtCodFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSitTrib: TConsultasArray;
begin
  inherited;
  If fPesqSitTributaria(Self, TEditFocus(Sender), Nil, Nil, Key, arrSitTrib) Then
  Begin
    If fValidaCampos(TEditFocus(Sender)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntDadosFiscais.edtDesAceExit(Sender: TObject);
begin
  inherited;
  pHabilitaCheksTributacao;
  pRecalculaSubstituicao;
end;

procedure TfrmEntDadosFiscais.edtDesEspExit(Sender: TObject);
begin
  inherited;
  pRecalculaSubstituicao;
end;

procedure TfrmEntDadosFiscais.pHabilitaCampos(Owner: TWinControl; blnHabilita: Boolean);
  Var
    intContador: Integer;
    edtTemp: TEdit;
    btnTemp: TBitBtnLocked;
    chkTmp : TCheckBox;
begin

  For intContador := 0 To Owner.ControlCount -1 Do
  Begin

    If (Owner.Controls[intContador] Is TEdit) Then
    Begin

      edtTemp := (Owner.Controls[intContador] As TEdit);
      If edtTemp.Tag = 99 Then
      Begin
        edtTemp.Enabled := blnHabilita;
      End;

    End

    Else If (Owner.Controls[intContador] Is TComboBoxFocus) Then
    Begin

      With (Owner.Controls[intContador] As TComboBoxFocus) Do
      If Tag = 99 Then
      Begin
        Enabled := blnHabilita;
      End;

    End

    Else If (Owner.Controls[intContador] Is TCheckBox) Then
    Begin

      chkTmp := (Owner.Controls[intContador] As TCheckBox);
      If chkTmp.Tag = 99 Then
      Begin
        chkTmp.Enabled := blnHabilita;
      End;

    End

    Else If (Owner.Controls[intContador] Is TBitBtnLocked) Then
    Begin

      btnTemp := (Owner.Controls[intContador] As TBitBtnLocked);
      If btnTemp.Tag = 99 Then
      Begin
        btnTemp.Enabled := blnHabilita;
      End;

    End;

  End;

  pDesabilitaPraticado;
  pDesabilitaCamposNFE;
end;

procedure TfrmEntDadosFiscais.pAjustaAlturaValores;
  Var
    intAltura: Integer;
    intContador: Integer;
begin
  { Altura do pnlValores = sub-painéis visíveis (alTop) + bordas. O form acompanha a diferença,
    para o dbgItens (alClient) manter a altura. Idempotente: o form é criado uma vez e reaberto pelo pShow }
  intAltura := pnlValores.BorderWidth;
  If pnlValores.BevelOuter <> bvNone Then
    intAltura := intAltura + pnlValores.BevelWidth;
  If pnlValores.BevelInner <> bvNone Then
    intAltura := intAltura + pnlValores.BevelWidth;
  intAltura := intAltura * 2;

  For intContador := 0 To pnlValores.ControlCount - 1 Do
    If pnlValores.Controls[intContador].Visible Then
      intAltura := intAltura + pnlValores.Controls[intContador].Height;

  Height := Height + (intAltura - pnlValores.Height);
  pnlValores.Height := intAltura;
end;

procedure TfrmEntDadosFiscais.pHabilitaCamposValores(const AblnHabilita: Boolean);
begin
  { Os campos do item ficam nos sub-painéis do pnlValores; pHabilitaCampos só percorre os filhos diretos }
  pHabilitaCampos(pnlCfop, AblnHabilita);
  pHabilitaCampos(pnlImpostos, AblnHabilita);
  pHabilitaCampos(pnlImpostosReforma, AblnHabilita);
end;

procedure TfrmEntDadosFiscais.btnCancelarEntradaClick(Sender: TObject);
begin
  pHabilitaCampos(pnlCabecalho, True);
  pHabilitaCampos(pnlTipoFrete, True);

  pHabilitaCamposValores(False);
  pHabilitaTotSub;

  pSetFocus(edtDesEsp);
  {*****************************************}
  {* VOLTA CONTEUDO ORIGINAL DA TABELA     *}
  {* PARA QUE POSSA APLICA DESCONTO        *}
  {**************************************MA*}
  pCopiaTabela( 'TMP_ENTTMP', 'TMP_ENTMER' );
  pDesmarcaICMSAntecipado;

  pRecalculaTotalGeral;

  dbgItens.Enabled    := False;
  btnConfirma.Enabled := False;
  pLimpaEdits;

  inherited;
  Close;
end;

procedure TfrmEntDadosFiscais.btnCFOPTodosClick(Sender: TObject);
  Var
    strClaFis : String;
    frmFatDigCFOP: TfrmFatDigCFOP;
begin
  inherited;
  strClaFis := EmptyStr;

  pCriarFormularios(TfrmFatDigCFOP, frmFatDigCFOP);
  Try
    frmFatDigCFOP.ShowModal;

    If (frmFatDigCFOP.ModalResult = mrOk) Then
      strClaFis := frmFatDigCFOP.edtClaFis.Text;
  Finally
    pFreeAndNil(frmFatDigCFOP);
  End;

  If Not fEmptyStr(strClaFis) Then
  Begin
    qryEntMer.First;
    While Not qryEntMer.Eof Do
    Begin
      edtClaFis.Text := strClaFis;
      If Not fValidaCampos(edtClaFis) Then
        Exit();

      pSetaComboNatOpe(edtClaFis.Text);
      qryEntMer.Next;
    End;

    pUpdateCFOP(strClaFis);
    pAtualizaTabela;
  End;
end;

procedure TfrmEntDadosFiscais.pCalculaTotalGeral;
begin

  If fEmptyStr(edtTotIte.Text) Then
    edtTotIte.Text := '0,00';

  If fEmptyStr(edtDesAce.Text) Then
    edtDesAce.Text := '0,00';

  If fEmptyStr(edtTotIpi.Text) Then
    edtTotIpi.Text := '0,00';

  If fEmptyStr(edtTotRet.Text) Then
    edtTotRet.Text := '0,00';

  If fEmptyStr(edtValFre.Text) Then
    edtValFre.Text := '0,00';

  If fEmptyStr(edtDesEsp.Text) Then
    edtDesEsp.Text := '0,00';

  edtTotGer.Text := FormatFloat(fMskDigitos(2),
                                fStrToFloat(edtTotLiq.Text) +
                                fStrToFloat(edtTotIpi.Text) +
                                fStrToFloat(edtDesAce.Text) +
                                fStrToFloat(edtTotRet.Text) +
                                fStrToFloat(edtValFre.Text));
end;

procedure TfrmEntDadosFiscais.pAtualizaComboNatOpe;
Begin
  pCarregaNatOperacao(edtClaFis.Text);
  cmbNatOpe.ItemIndex := cmbNatOpe.Items.IndexOf(qryEntMer.FieldByName('ENT_NATOPE').AsString);
End;

procedure TfrmEntDadosFiscais.pEscapePressed;
begin
  If (ActiveControl.Parent = pnlCfop)            Or
     (ActiveControl.Parent = pnlImpostos)        Or
     (ActiveControl.Parent = pnlImpostosReforma) Or
     ((ActiveControl) = dbgItens)          Then
  Begin
    dbgItens.Enabled := True;
    pSetFocus(dbgItens);
    btnConfirma.Enabled := True;
    pHabilitaCamposValores(False);
    pAtualizaComboNatOpe;
    pAtualizaEdits(Nil);
  End
  Else
  Begin
    inherited;
  End;

end;

procedure TfrmEntDadosFiscais.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  {*****************************************}
  {* (*) LIMPA EVENTO                      *}
  {**************************************MV*}
  qryEntMer.AfterScroll := Nil;

  If Not blnConfirma Then
  Begin
    pCopiaTabela( 'TMP_ENTTMP', 'TMP_ENTMER' );
    pDesmarcaICMSAntecipado;
  End;

  FreeAndNil(qryConCfo);
  If Assigned(frmEntRetencaoNotaServico) Then
    FreeAndNil(frmEntRetencaoNotaServico);
end;

Function TfrmEntDadosFiscais.fTemCFOP(strClaFis: String): Integer;
  Var
    qryClsFis: TUniQuery;
Begin
  qryClsFis := fCriaQuery;
  With qryClsFis, SQL Do
  Begin
    Add('SELECT COUNT(*) AS QTD FROM TMP_ENTMER');
    Add('WHERE ENT_CLAFIS = :CLAFIS');

    ParamByName('CLAFIS').AsString := strClaFis;

    Open;

    Result := FieldByName('QTD').AsInteger;
  End;
  FreeAndNil(qryClsFis);
End;

Procedure TfrmEntDadosFiscais.pUpdateCFOP(strClaFis: String);
  Var
    qryClsFis: TUniQuery;
Begin
  qryClsFis := fCriaQuery;
  With qryClsFis, SQL Do
  Begin
    Add('UPDATE TMP_ENTMER');
    Add('SET ENT_CLAFIS = :CLAFIS');

    ParamByName('CLAFIS').AsString := strClaFis;

    ExecSQL;
  End;
  FreeAndNil(qryClsFis);
End;

Function TfrmEntDadosFiscais.fIgualaCFOP(blnMensagem: Boolean): Boolean;
  Const
    ArrCFOP: Array[1..4] Of String[6] = ('1922', '2922', '1117', '2117');
  Var
    intQtdCfo,
    intIndice: Integer;
Begin
  Result := True;
  For intIndice := Low(ArrCFOP) To High(ArrCFOP) Do
  Begin
    intQtdCfo := fTemCFOP(String(ArrCFOP[intIndice]));

    If intQtdCfo > 0 Then
    Begin

      If Not blnMensagem Then
      Begin
        pUpdateCFOP(String(ArrCFOP[intIndice]));
      End
      Else If qryEntMer.RecordCount <> intQtdCfo Then
      Begin
        pMensagemOk('Quando houver um produto com CFOP ' + String(ArrCFOP[intIndice]) + ' todos os produtos deverão estar com a mesma CFOP!');
        Result := False;
      End;

    End;
  End;
End;

Function TfrmEntDadosFiscais.fRetDescontoDaTela: Double;
Begin
  Result :=  fStrToFloat(edtDesEsp.Text);

  If (blnSeparaICMDesoneradoDoDesconto) Or (fCfgSis('SUFRAM', varBoolean)) Then
    Result :=  Result + fStrToFloat(edtICMDes.Text) + fStrToFloat(edtDesPis.Text);

End;

Function TfrmEntDadosFiscais.fValidaDescontos: Boolean;
Begin
  If blnSeparaICMDesoneradoDoDesconto Then
    Result := RoundTo(fStrToFloat(edtDesEsp.Text) + fStrToFloat(edtICMDes.Text) + fStrToFloat(edtDesPis.Text), -2) = RoundTo(fStrToFloat(edtTotDes.Text), -2)
  Else
    Result := True;
End;

procedure TfrmEntDadosFiscais.btnCalculaImpostosClick(Sender: TObject);
  Var
    qryGenMer: TUniQuery;
    qryLeitura: TUniQuery;
    intNumReg,
    intQtdReg: Integer;
    fltFreAcu: Double;
    fltDesRes: Double;
    fltAceRat: Double;
    fltQtdTot,
    fltQtdTotAnt,
    fltPesTot,
    fltPesTotAnt: Double;
    blnControlar: Boolean;
    LqryEntMerAfterScroll: TDataSetNotifyEvent;
    blnZerouSt: Boolean;
begin
  If Not fPedeSenhaAlteracaoFrete then
    Exit;

  If (fStrToFloat(edtValFre.Text) > 0) And (tipRatFrete = trfPropPesoItem) And (Not fVerificaPesoDosItensEntrada) And (fEmptyStr(recNotEle.strAutInc)) Then
    Exit;

  If Not fValidaDescontos Then
  Begin
    pMensagemOk('A soma do "Desconto comercial"  + "ICMS Desonerado" + "Desconto PIS/COFINS" dever ser de ' +  edtTotDes.Text + ' !');
    pSetFocus(edtDesEsp);
    Exit;
  End;

  If (pnlTipoFrete.Visible) And (cbbTipFre.ItemIndex = -1) And (cbbTipFre.Enabled) Then
  Begin
    pMensagemOk('Informe o Tipo de Rateio para o Frete!');
    pSetFocus(cbbTipFre);
    Exit;
  End;
  Try

    fltPesTot := 0;
    fltQtdTot := 0;
    case tipRatFrete Of
      trfPropPesoItem : fltPesTot := fRetornaPesoEntrada(fltPesTotAnt);
      trfPropQtdItem  : fltQtdTot := fRetornaQtdeEntrada(fltQtdTotAnt);
    End;

    blnZerouSt := False;
    If (fEmptyStr(recNotEle.strAutInc)) And {Entrada Manual}
       (not (blnGarantia or blnRecCliGarantia or FblnAcessadoViaRetornoConsignacao or blnDevolu or  blnConEqu or blnLocEqu)) And {Entrada Mercadoria Normal}
       (fltTotRetOri > 0) And {Tem ST}
       (Not fEmptyStr(edtTotRet.Text)) And
       (fStrToFloat(edtTotRet.Text) = 0) {ST foi Zerada} Then
      blnZerouSt := True;


    pRestauraDadosAnteriores;

    qryGenMer := fCriaQuery(Self);

{

    If (fStrToFloat(edtTotIpi.Text) > 0) And (fRetTotIte = 0) And (chkCredIPI.Checked) Then
    Begin
      fMensagem('','Não será possível utilizar o crédito de IPI porque não existe nenhum produto relacionado com IPI!',['&OK']);
      Exit;
    End;

}

    btnConfirma.Enabled := False;

    pHabilitaCampos(pnlCabecalho, False);
    pHabilitaCampos(pnlTipoFrete, False);

    pHabilitaCamposValores(False);

    edtDesPis.Enabled:= False;
    lblDesPis.Enabled:= False;

    fltValFre := fStrToFloat(edtValFre.Text);

    fltDesEsp := fRetDescontoDaTela;

    fltDesAce := fStrToFloat(edtDesAce.Text);
    fltTotRet := fStrToFloat(edtTotRet.Text);

    fltAceRat := 0;

    qryLeitura := fCriaQuery(Self);

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

      Open;
    End;

    intNumReg := 0;
    intQtdReg := qryLeitura.RecordCount;

    fltFreAcu := 0;
    fltDesRes := fltDesAce;

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
            ParamByName('VALFRE').AsFloat := RoundTo(fltValFre - fltFreAcu, -2);

          ParamByName('DESACE').AsFloat := fltDesRes;
        End Else
        Begin

          If fltTotIte > 0 Then
          Begin

            If fltAceRat + RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltDesAce / fltTotIte), -2) > fltDesAce Then
              ParamByName('DESACE').AsFloat := fltDesAce - fltAceRat
            Else
              ParamByName('DESACE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltDesAce / fltTotIte), -2);

            If fEmptyStr(recNotEle.strAutInc) Then
            Begin
              ParamByName('VALFRE').AsFloat := 0.00;

              If fltValFre > 0 Then
              Begin
                case tipRatFrete Of
                  trfPropPesoItem: begin
                                      If fltFreAcu + RoundTo(qryLeitura.FieldByName('PESITE').AsFloat * (fltValFre / fltPesTot), -2) > fltValFre Then
                                        ParamByName('VALFRE').AsFloat := RoundTo(fltValFre - fltFreAcu, -2)
                                      Else
                                        ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('PESITE').AsFloat * (fltValFre / fltPesTot), -2)

                                   End;

                  trfPropQtdItem:  Begin
                                      If fltFreAcu + RoundTo(qryLeitura.FieldByName('ENT_QTDITE').AsFloat * (fltValFre / fltQtdTot), -2) > fltValFre Then
                                        ParamByName('VALFRE').AsFloat := RoundTo(fltValFre - fltFreAcu, -2)
                                      Else
                                        ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_QTDITE').AsFloat * (fltValFre / fltQtdTot), -2);
                                   End;

                  Else
                  Begin
                    If fltFreAcu + RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltValFre / fltTotIte), -2) > fltValFre Then
                      ParamByName('VALFRE').AsFloat := RoundTo(fltValFre - fltFreAcu, -2)
                    Else
                      ParamByName('VALFRE').AsFloat := RoundTo(qryLeitura.FieldByName('ENT_TOTITE').AsFloat * (fltValFre / fltTotIte), -2);
                  End;
                end;

              End;

            End;

          End Else
          Begin
            ParamByName('DESACE').AsFloat := 0;

            If fEmptyStr(recNotEle.strAutInc) Then
              ParamByName('VALFRE').AsFloat := 0;
          End;

          If fEmptyStr(recNotEle.strAutInc) Then
            fltFreAcu := fltFreAcu + ParamByName('VALFRE').AsFloat;

          fltDesRes := fltDesRes - ParamByName('DESACE').AsFloat;
          fltAceRat := fltAceRat + ParamByName('DESACE').AsFloat;
        End;

        ParamByName('AUTINC').AsString := qryLeitura.FieldByName('AUTOINCREM').AsString;

        ExecSQL;
        Close;
      End;

      qryLeitura.Next;

    End;

    FreeAndNil(qryLeitura);


    Try
      pRateiaImpostos(qryEntMer,
                      recNotEle.finalidadeXML,
                      objExcecaoCfopCst,
                      fltTotIte,
                      fltValFre,
                      fltDesEsp,
                      fStrToFloat(edtDesEsp.Text),
                      fStrToFloat(edtDesPis.Text),
                      RoundTo(fStrToFloat(edtDesPis.Text) /  fltTotIte * 100, -2),
                      fltDesAce,
                      fltTotRet,
                      fltTotIteRet,
                      pgbDadosFiscais,
                      fltAlqFor,
                      strEstFor,
                      strCodFor,
                      strTipFor,
                      RoundTo(fStrToFloat(edtTotIpi.Text) - fltTotIpi, -2),
                      fStrToFloat(edtTotIpi.Text),
                      blnDevolu,
                      recNotEle.blnICMSDesoneradoEstaNoDescontoComercial,
                      PerfilDespachanteAduaneiro,
                      strClaSub,
                      fltTotRetOri,
                      chkApliRed.Checked,
                      recNotEle.strAutInc,
                      chkFreTri.Checked,
                      recNotEle.strClaBri,
                      blnGarantia,
                      blnRecCliGarantia,
                      blnNotaImp,
                      blnZonFra,
                      strEspDoc,
                      blnConEqu or blnLocEqu,
                      chkDescontoIncondicional.Checked,
                      tipRatFrete,
                      blnPrecoPraticado,
                      blnPresencial,
                      False,
                      False,
                      FblnAcessadoViaRetornoConsignacao,
                      blnManterIpi,
                      blnZeraIcmsDevolucao,
                      blnZerouSt);


     If (fltTotRetOri <= 0.0)                                           Or
         (fFormataFloat(fltTotRetOri, 2) <> fFormataFloat(fltTotRet, 2)) Or
         (fltAntFre > 0) Then
      Begin
        pRateiaBasRetFrete;
      End;


      pCalculaTFCI(qryEntMer);

    Except
      On E: Exception Do
      Begin
        btnConfirma.Enabled := True;
        pHabilitaCampos(pnlCabecalho, True);
        pHabilitaCampos(pnlTipoFrete, True);

        pHabilitaTotSub;
        pMensagensErro(E.Message,'[TfrmEntDadosFiscais.btnCalculaImpostosClick]');
        Exit;
      End;
    End;

    fIgualaCFOP(False);

    pAtualizaTabela;

    If Not fCalculaPisCofins Then
    Begin
      btnConfirma.Enabled := True;
      pHabilitaCampos(pnlCabecalho, True);
      pHabilitaCampos(pnlTipoFrete, True);

      pHabilitaTotSub;
      Exit;
    End;

    pCalculaTotalGeral;

    If Not chkApliRed.Checked Then
      pAtualizaEdtTotSub;

    dbgItens.Enabled    := True;
    btnConfirma.Enabled := True;
    btnCFOPTodos.Enabled := True;
    pSetFocus(dbgItens);

    btnConfirma.Enabled := True;

  Finally
    If Assigned(qryGenMer) Then
      FreeAndNil(qryGenMer);
  End;
  pCalculaTotaisCabecalho;

  pDesabilitaPraticado;

  qryEntMer.First;
  blnControlar := Not qryEntMer.ControlsDisabled;
  LqryEntMerAfterScroll := qryEntMer.AfterScroll;
  Try
    qryEntMer.AfterScroll := Nil;
    if blncontrolar then
      qryEntMer.DisableControls;
    While Not qryEntMer.Eof Do
    Begin
      If (qryEntMer.FieldByName('ENT_NATOPE').IsNull) Or fEmptyStr(qryEntMer.FieldByName('ENT_NATOPE').AsString) Then
      Begin
        qryEntMer.Edit;
        qryEntMer.FieldByName('ENT_NATOPE').AsString:= fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(edtClaFis.text));
        qryEntMer.Post;
      End;
      qryEntMer.Next;
    End;
  Finally
    qryEntMer.AfterScroll := LqryEntMerAfterScroll;
    if blncontrolar then
      qryEntMer.EnableControls;
  end;
  pAtualizaComboNatOpe;

end;

procedure TfrmEntDadosFiscais.dbgItensDblClick(Sender: TObject);
  Var
    Key: Word;
    Shift: TShiftState;
begin
  inherited;
  Key := VK_Return;
  dbgItensKeyDown(Sender, Key, Shift);
end;

Function TfrmEntDadosFiscais.fRetMaiorIVA: Double;
  Var
    intRecNo: Integer;
    strTipAbf: String;
Begin
  Result := 0;

  If (blnDevolu) Or (blnConEqu) Or (blnLocEqu) Then
    strTipAbf := fGetTipoAbfCliente(strCodFor)
  Else
    strTipAbf := fGetTipoAbfFornecedor(strCodFor);

  Try
    With qryEntMer Do
    Begin
      intRecNo := qryEntMer.RecNo;
      qryEntMer.AfterScroll := Nil;
      DisableControls;
      First;

      While Not Eof Do
      Begin
        Result := Max(Result, fRetornaPercIVA(FieldByName('ENT_CODABF').AsString, strEstFor, strTipAbf));
        Next;
      End;

      qryEntMer.RecNo := intRecNo;
      EnableControls;

    End;

  Finally
    qryEntMer.AfterScroll := pAtualizaEdits;
  End;

End;

procedure TfrmEntDadosFiscais.pCalculaTributacaoFrete(    fltValIVA,
                                                          fltAlqFre,
                                                          fltValFre: Double;
                                                      Var fltBasRet,
                                                          fltTotRet: Double);
  Var
    fltFreVal: Double;
    fltRetFre: Double;
    fltAlqSub: Double;
    strEstado: String;
Begin
  strEstado := fCadEmp('ESTADO');

  fltAlqSub := 17;

  If Pos(strEstado, 'MG_PR_SP_') > 0 Then
    fltAlqSub := 18;

  If strEstado = 'RJ' Then
    fltAlqSub := 19;

  fltFreVal := fFormataFloat((fltValFre * fltAlqFre) / 100, 2);

  fltRetFre := (fltValFre * fltValIVA);
  fltRetFre := (fltRetFre * fltAlqSub) / 100;
  fltRetFre := fFormataFloat((fltRetFre - fltFreVal), 2);

  If fltRetFre < 0 Then
    fltRetFre := 0;

  fltBasRet := fltBasRet + (fltValFre * fltValIVA);
  fltTotRet := fltTotRet + fltRetFre;
End;

{*****************************************}
{* CALCULA UM RESUMO DOS DADOS FISCAIS   *}
{* DOS ITENS, SINTETIZANDO POR CLASSIFI- *}
{* CAÇÃO E ALIQUOTA                      *}
{**************************************MV*}
procedure TfrmEntDadosFiscais.pCalculaResumoDadosFiscais(strNumDoc, strSerie,
  strEspDoc, strCodFor: String; dtaDtaDoc, dtaDtaEnt: TDateTime; fltAlqEst: Double; strClaFis: String);
  Var
    intContador: Integer;
    strContador: String;
    intPosRT: Integer;
    strSQL: String;
    strCampos: String;
    strValores: String;

    //Dados referentes ao total
    fltVlrCon: Double;
    fltBasIcm: Double;
    fltValIcm: Double;
    fltIsento: Double;
    fltBasRet: Double;
    fltValRet: Double;
    fltBasAnt: Double;
    fltValAnt: Double;
    fltDesAce: Double;
    fltBasIpi: Double;
    fltValIpi: Double;

    fltBFCPST: Double;
    fltPFCPST: Double;
    fltVFCPST: Double;

    fltVBCFCP: Double;
    fltPERFCP: Double;
    fltVALFCP: Double;
    fltQBCMON: Double;
    fltVALMON: Double;
    fltQBCMOT: Double;
    fltVALMOT: Double;
    fltVLCBST: Double;
    fltVLIBST: Double;
    fltVL_IST: Double;
    fltTPROIS: Double;
    fltBCCBST: Double;
    fltBCIBST: Double;
    fltBC_IST: Double;
    fltOutras: Double;

    fltBaeRet: Double;
    fltBaeIPI: Double;
    fltVaeRet: Double;
    fltVaeIPI: Double;


    fltVlrConCol: Double;
    fltBasIcmCol: Double;
    fltValIcmCol: Double;

    qryGenFis: TUniQuery;

  procedure pAddValueByField(strField: String; varValue: Variant);
  Begin
    With cdsCadFis Do
    Begin
      FieldByName(strField).Value := varValue;
    End;
  End;

begin
  qryGenFis := fCriaQuery(Self);

  fltVlrCon := 0.0;
  fltBasIcm := 0.0;
  fltValIcm := 0.0;
  fltIsento := 0.0;
  fltBasRet := 0.0;
  fltValRet := 0.0;
  fltBasAnt := 0.0;
  fltValAnt := 0.0;
  fltDesAce := 0.0;
  fltValFre := 0.0;
  fltBasIpi := 0.0;
  fltValIpi := 0.0;
  fltOutras := 0.0;
  fltVaeRet := 0.0;
  fltVaeIpi := 0.0;
  fltBaeRet := 0.0;
  fltBaeIpi := 0.0;
  fltBFCPST := 0.0;
  fltPFCPST := 0.0;
  fltVFCPST := 0.0;
  fltVBCFCP := 0.0;
  fltPERFCP := 0.0;
  fltVALFCP := 0.0;
  fltQBCMON := 0.0;
  fltVALMON := 0.0;
  fltQBCMOT := 0.0;
  fltVALMOT := 0.0;
  fltVLCBST := 0.0;
  fltVLIBST := 0.0;
  fltVL_IST := 0.0;
  fltTPROIS := 0.0;
  fltBCCBST := 0.0;
  fltBCIBST := 0.0;
  fltBC_IST := 0.0;
  intContador := 1;

  strCampos  := '';
  strValores := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ENT_CLAFIS, ';
  strSQL := strSQL + '  ENT_ALQICM, ';
  strSQL := strSQL + '  SUM(ENT_VLRCON)  ' + IIf(chkDescontoIncondicional.Checked, ' - SUM(ENT_DESESP)' , '') + 'AS ENT_VLRCON, ';
  strSQL := strSQL + '  SUM(ENT_BASICM) AS ENT_BASICM, ';
  strSQL := strSQL + '  SUM(ENT_VALICM) AS ENT_VALICM, ';
  strSQL := strSQL + '  SUM(ENT_ISENTO) AS ENT_ISENTO, ';
  strSQL := strSQL + '  SUM(ENT_BASRET) AS ENT_BASRET, ';
  strSQL := strSQL + '  SUM(ENT_VALRET) AS ENT_VALRET, ';
  strSQL := strSQL + '  SUM(ENT_BASANT) AS ENT_BASANT, ';
  strSQL := strSQL + '  SUM(ENT_VALANT) AS ENT_VALANT, ';
  strSQL := strSQL + '  SUM(ENT_DESACE) AS ENT_DESACE, ';
  strSQL := strSQL + '  SUM(ENT_BASIPI) AS ENT_BASIPI, ';
  strSQL := strSQL + '  SUM(ENT_VALIPI) AS ENT_VALIPI, ';
  strSQL := strSQL + '  SUM(ENT_OUTRAS) AS ENT_OUTRAS, ';
  strSQL := strSQL + '  SUM(ENT_BAERET) AS ENT_BAERET, ';
  strSQL := strSQL + '  SUM(ENT_BAEIPI) AS ENT_BAEIPI, ';
  strSQL := strSQL + '  SUM(ENT_VAERET) AS ENT_VAERET, ';
  strSQL := strSQL + '  SUM(ENT_VAEIPI) AS ENT_VAEIPI, ';
  strSQL := strSQL + '  SUM(ENT_VALFRE) AS ENT_VALFRE, ';
  strSQL := strSQL + '  SUM(ENT_VFCPST) AS ENT_VFCPST, ';
  strSQL := strSQL + '  SUM(ENT_BFCPST) AS ENT_BFCPST, ';
  strSQL := strSQL + '  SUM(ENT_PFCPST) AS ENT_PFCPST, ';
  strSQL := strSQL + '  0 AS FIS_VREPIS, ';
  strSQL := strSQL + '  0 AS FIS_VRECOF, ';
  strSQL := strSQL + '  0 AS FIS_RECSSL, ';
  strSQL := strSQL + '  0 AS FIS_RETISS, ';
  strSQL := strSQL + '  0 AS FIS_REIRRF, ';
  strSQL := strSQL + '  0 AS FIS_REINSS, ';
  strSQL := strSQL + '  "" AS FIS_TB06RE, ';
  strSQL := strSQL + '  "" AS FIS_TB01RE, ';
  strSQL := strSQL + '  ENT_PERFCP AS ENT_PERFCP, ';
  strSQL := strSQL + '  SUM(ENT_VALFCP) AS ENT_VALFCP, ';
  strSQL := strSQL + '  SUM(ENT_VBCFCP) AS ENT_VBCFCP, ';
  strSQL := strSQL + '  SUM(ENT_QBCMON) AS ENT_QBCMON, ';
  strSQL := strSQL + '  ENT_ADREMN AS ENT_ADREMN, ';
  strSQL := strSQL + '  SUM(ENT_VALMON) AS ENT_VALMON, ';
  strSQL := strSQL + '  SUM(IFNULL(ENT_RFCVAL, 0)) AS ENT_VLRCBS, ';
  strSQL := strSQL + '  SUM(IFNULL(ENT_RFIVAL, 0)) AS ENT_VLRIBS, ';
  strSQL := strSQL + '  SUM(IFNULL(ENT_RFSVLR, 0)) AS ENT_VLR_IS, ';
  strSQL := strSQL + '  SUM(IFNULL(ENT_REFVBC, 0)) AS ENT_BASRT, ';
  strSQL := strSQL + '  SUM(IFNULL(ENT_RFSBAS, 0)) AS ENT_BAS_IS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_ENTMER ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  ENT_CLAFIS, ENT_ALQICM ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  ENT_CLAFIS, ENT_ALQICM ';

  cdsCadFis.Append;

  For intPosRT := 1 To 5 Do
  Begin
    pAddValueByField('FIS_VLCBS' + IntToStr(intPosRT), 0);
    pAddValueByField('FIS_VLIBS' + IntToStr(intPosRT), 0);
    pAddValueByField('FIS_VL_IS' + IntToStr(intPosRT), 0);
    pAddValueByField('FIS_BCCBS' + IntToStr(intPosRT), 0);
    pAddValueByField('FIS_BCIBS' + IntToStr(intPosRT), 0);
    pAddValueByField('FIS_BC_IS' + IntToStr(intPosRT), 0);
  End;

  {******************************************}
  {* SELECT QUE SINTETIZA POR CLASSIFICAÇÃO *}
  {* + ALIQUOTA                             *}
  {***************************************MV*}
  With qryGenFis Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    While (Not Eof) And (intContador <= 5) Do
    Begin

      strContador := IntToStr(intContador);

      fltVlrCon := fltVlrCon + FieldByName('ENT_VLRCON').AsFloat;
      fltBasIcm := fltBasIcm + FieldByName('ENT_BASICM').AsFloat;
      fltValIcm := fltValIcm + FieldByName('ENT_VALICM').AsFloat;
      fltIsento := fltIsento + FieldByName('ENT_ISENTO').AsFloat;
      fltBasRet := fltBasRet + FieldByName('ENT_BASRET').AsFloat;
      fltValRet := fltValRet + FieldByName('ENT_VALRET').AsFloat;
      fltBasAnt := fltBasAnt + FieldByName('ENT_BASANT').AsFloat;
      fltValAnt := fltValAnt + FieldByName('ENT_VALANT').AsFloat;
      fltDesAce := fltDesAce + FieldByName('ENT_DESACE').AsFloat;
      fltBasIpi := fltBasIpi + FieldByName('ENT_BASIPI').AsFloat;
      fltValIpi := fltValIpi + FieldByName('ENT_VALIPI').AsFloat;
      fltValFre := fltValFre + FieldByName('ENT_VALFRE').AsFloat;
      fltOutras := fltOutras + FieldByName('ENT_OUTRAS').AsFloat;
      fltVaeRet := fltVaeRet + FieldByName('ENT_VAERET').AsFloat;
      fltVaeIPI := fltVaeIPI + FieldByName('ENT_VAEIPI').AsFloat;
      fltBaeRet := fltBaeRet + FieldByName('ENT_BAERET').AsFloat;
      fltBaeIPI := fltBaeIPI + FieldByName('ENT_BAEIPI').AsFloat;

      fltVlrConCol := FieldByName('ENT_VLRCON').AsFloat;
      fltBasIcmCol := FieldByName('ENT_BASICM').AsFloat;
      fltValIcmCol := FieldByName('ENT_VALICM').AsFloat;

      fltBFCPST := fltBFCPST + FieldByName('ENT_BFCPST').AsFloat;
      fltPFCPST := fltPFCPST + FieldByName('ENT_PFCPST').AsFloat;
      fltVFCPST := fltVFCPST + FieldByName('ENT_VFCPST').AsFloat;

      fltVBCFCP := fltVBCFCP + FieldByName('ENT_VBCFCP').AsFloat;
      fltPERFCP := fltPERFCP + FieldByName('ENT_PERFCP').AsFloat;
      fltVALFCP := fltVALFCP + FieldByName('ENT_VALFCP').AsFloat;
      fltQBCMON := fltQBCMON + FieldByName('ENT_QBCMON').AsFloat;
      fltVALMON := fltVALMON + FieldByName('ENT_VALMON').AsFloat;
      fltQBCMOT := fltQBCMOT + FieldByName('ENT_QBCMON').AsFloat;
      fltVALMOT := fltVALMOT + FieldByName('ENT_VALMON').AsFloat;
      fltVLCBST := fltVLCBST + FieldByName('ENT_VLRCBS').AsFloat;
      fltVLIBST := fltVLIBST + FieldByName('ENT_VLRIBS').AsFloat;
      fltVL_IST := fltVL_IST + FieldByName('ENT_VLR_IS').AsFloat;
      fltBCCBST := fltBCCBST + FieldByName('ENT_BASRT').AsFloat;
      fltBCIBST := fltBCIBST + FieldByName('ENT_BASRT').AsFloat;
      fltBC_IST := fltBC_IST + FieldByName('ENT_BAS_IS').AsFloat;

      pAddValueByField('FIS_CLFSC' + strContador, FieldByName('ENT_CLAFIS').AsString);
      pAddValueByField('FIS_VLCON' + strContador, fltVlrConCol);
      pAddValueByField('FIS_BASIC' + strContador, fltBasIcmCol);
      pAddValueByField('FIS_ALQIC' + strContador, FieldByName('ENT_ALQICM').AsFloat);
      pAddValueByField('FIS_VLRIC' + strContador, fltValIcmCol);

      pAddValueByField('FIS_OUTRA' + strContador, FieldByName('ENT_OUTRAS').AsFloat);

      pAddValueByField('FIS_ISENT' + strContador, FieldByName('ENT_ISENTO').AsFloat);
      pAddValueByField('FIS_BCRET' + strContador, FieldByName('ENT_BASRET').AsFloat);
      pAddValueByField('FIS_RETID' + strContador, FieldByName('ENT_VALRET').AsFloat);
      pAddValueByField('FIS_BASAN' + strContador, FieldByName('ENT_BASANT').AsFloat);
      pAddValueByField('FIS_ANTIC' + strContador, FieldByName('ENT_VALANT').AsFloat);
      pAddValueByField('FIS_BASIP' + strContador, FieldByName('ENT_BASIPI').AsFloat);
      pAddValueByField('FIS_VLRIP' + strContador, FieldByName('ENT_VALIPI').AsFloat);
      pAddValueByField('FIS_DACES' + strContador, FieldByName('ENT_DESACE').AsFloat);
      pAddValueByField('FIS_VLFRE' + strContador, FieldByName('ENT_VALFRE').AsFloat);

      pAddValueByField('FIS_BAEIP' + strContador, FieldByName('ENT_BAEIPI').AsFloat);
      pAddValueByField('FIS_BAERE' + strContador, FieldByName('ENT_BAERET').AsFloat);
      pAddValueByField('FIS_VAEIP' + strContador, FieldByName('ENT_VAEIPI').AsFloat);
      pAddValueByField('FIS_VAERE' + strContador, FieldByName('ENT_VAERET').AsFloat);

      pAddValueByField('FIS_BFCPS' + strContador, FieldByName('ENT_BFCPST').AsFloat);
      pAddValueByField('FIS_PFCPS' + strContador, FieldByName('ENT_PFCPST').AsFloat);
      pAddValueByField('FIS_VFCPS' + strContador, FieldByName('ENT_VFCPST').AsFloat);

      pAddValueByField('FIS_ALQFCP', FieldByName('ENT_PERFCP').AsFloat);
      pAddValueByField('FIS_VLFCP' + strContador, FieldByName('ENT_VALFCP').AsFloat);
      pAddValueByField('FIS_BAFCP' + strContador, FieldByName('ENT_VBCFCP').AsFloat);
      pAddValueByField('FIS_QBCMO' + strContador, FieldByName('ENT_QBCMON').AsFloat);
      pAddValueByField('FIS_ADREM' + strContador, FieldByName('ENT_ADREMN').AsFloat);
      pAddValueByField('FIS_VALMO' + strContador, FieldByName('ENT_VALMON').AsFloat);
      pAddValueByField('FIS_VLCBS' + strContador, FieldByName('ENT_VLRCBS').AsFloat);
      pAddValueByField('FIS_VLIBS' + strContador, FieldByName('ENT_VLRIBS').AsFloat);
      pAddValueByField('FIS_VL_IS' + strContador, FieldByName('ENT_VLR_IS').AsFloat);
      pAddValueByField('FIS_BCCBS' + strContador, FieldByName('ENT_BASRT').AsFloat);
      pAddValueByField('FIS_BCIBS' + strContador, FieldByName('ENT_BASRT').AsFloat);
      pAddValueByField('FIS_BC_IS' + strContador, FieldByName('ENT_BAS_IS').AsFloat);
      Next;
      Inc(intContador);
    End;

  End;

  {*****************************************}
  {* CAMPOS REFERENTES AOS TOTAIS          *}
  {**************************************MV*}
  With qryGenFis Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  SUM(IFNULL(ENT_RFCVAL, 0)) AS TOT_CBS, ');
    SQL.Add('  SUM(IFNULL(ENT_RFIVAL, 0)) AS TOT_IBS, ');
    SQL.Add('  SUM(IFNULL(ENT_RFSVLR, 0)) AS TOT_IS, ');
    SQL.Add('  SUM(IFNULL(ENT_TOTITE, 0) + IFNULL(ENT_RFSVLR, 0)) AS TOT_PROIS ');
    SQL.Add('FROM TMP_ENTMER ');
    Open;
    fltVLCBST := FieldByName('TOT_CBS').AsFloat;
    fltVLIBST := FieldByName('TOT_IBS').AsFloat;
    fltVL_IST := FieldByName('TOT_IS').AsFloat;
    fltTPROIS := FieldByName('TOT_PROIS').AsFloat;
    Close;
  End;

  If (fltVLCBST + fltVLIBST + fltVL_IST) <= 0 Then
    fltTPROIS := 0;
  pAddValueByField('FIS_CLFSCT', null);
  pAddValueByField('FIS_VLCONT', fltVlrCon);
  pAddValueByField('FIS_BASICT', fltBasIcm);
  pAddValueByField('FIS_ALQICT', null);
  pAddValueByField('FIS_VLRICT', fltValIcm);
  pAddValueByField('FIS_OUTRAT', fltOutras);
  pAddValueByField('FIS_ISENTT', fltIsento);
  pAddValueByField('FIS_BCRETT', fltBasRet);
  pAddValueByField('FIS_RETIDT', fltValRet);
  pAddValueByField('FIS_BASANT', fltBasAnt);
  pAddValueByField('FIS_ANTICT', fltValAnt);
  pAddValueByField('FIS_BASIPT', fltBasIpi);
  pAddValueByField('FIS_VLRIPT', fltValIpi);
  pAddValueByField('FIS_DACEST', fltDesAce);
  pAddValueByField('FIS_VLFRET', fltValFre);
  pAddValueByField('FIS_VAERET', fltVaeRet);
  pAddValueByField('FIS_VAEIPI', fltVaeIpi);
  pAddValueByField('FIS_BAERET', fltBaeRet);
  pAddValueByField('FIS_BAEIPI', fltBaeIpi);

  {*****************************************}
  {* CAMPOS ESPECIFICOS DO LIVRO FISCAL    *}
  {**************************************MV*}
  pAddValueByField('FIS_NUMDOC', strNumDoc);
  pAddValueByField('FIS_SERIE_', strSerie);
  pAddValueByField('FIS_ESPDOC', strEspDoc);
  pAddValueByField('FIS_FORCLI', strCodFor);
  pAddValueByField('FIS_DTADOC', dtaDtaDoc);
  pAddValueByField('FIS_DTAENT', dtaDtaEnt);
  pAddValueByField('FIS_ESTADO', strEstFor);

  pAddValueByField('FIS_BFCPST', fltBFCPST);
  pAddValueByField('FIS_PFCPST', fltPFCPST);
  pAddValueByField('FIS_VFCPST', fltVFCPST);

  pAddValueByField('FIS_ENTSAI', 'E');
  pAddValueByField('FIS_TIP_FC', 'F');
  pAddValueByField('FIS_HISTOR', null);
  pAddValueByField('FIS_QBCMOT', fltQBCMOT);
  pAddValueByField('FIS_VALMOT', fltVALMOT);
  pAddValueByField('FIS_QBCMOT', fltQBCMOT);
  pAddValueByField('FIS_VALMOT', fltVALMOT);
  pAddValueByField('FIS_VLCBST', fltVLCBST);
  pAddValueByField('FIS_VLIBST', fltVLIBST);
  pAddValueByField('FIS_VL_IST', fltVL_IST);
  pAddValueByField('FIS_TPROIS', fltTPROIS);
  pAddValueByField('FIS_BCCBST', fltBCCBST);
  pAddValueByField('FIS_BCIBST', fltBCIBST);
  pAddValueByField('FIS_BC_IST', fltBC_IST);
  pAddValueByField('AUTOINCREM', Succ(cdsCadFis.RecordCount));
  {*********************************}
  {* GRAVANDO O REGISTRO NO CLIENT *}
  {******************************AN*}
  cdsCadFis.Post;

  FreeAndNil(qryGenFis);
end;

procedure TfrmEntDadosFiscais.pRecalculaIpi(blnValIpi: Boolean);
  Var
    qryEntAux: TUniQuery;
    fltIpiAcu: Double;
    strIteSer: String;
    strSerTer: String;
    fltFreAce: Double;
    fltBasIpi: Double;
    fltPerCor: Double;
    fltTotSer: Double;
    fltTmpDes: Double;
Begin
  If Not fEmptyStr(recNotEle.strAutInc) Then
    Exit;

  qryEntAux := fCriaQuery(Self);
  fltTotSer := fRetTotItemServ;
  strIteSer := fCfgSis('ITESER');
  strSerTer := fCfgSis('SERTER');
  With qryEntAux, SQL Do
  Begin
{    Close;
    Clear;
    Add('SELECT SUM(ENT_TOTITE) AS TOTITE FROM TMP_ENTMER');
    Add('WHERE ENT_VALIPI > 0');

    Open;

    fltTotIteIpi := FieldByName('TOTITE').AsFloat;
    }
    fltIpiAcu    := 0;

    Close;
    Clear;
    Add('SELECT * FROM TMP_ENTMER');
    Add('WHERE ENT_VALIPI > 0');
    Open;

    If chkFreTri.Checked Then
      fltFreAce := fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text)
    Else
      fltFreAce := 0;

    fltDesEsp    := fRetDescontoDaTela;

    While Not Eof Do
    Begin

      If fltTotIte <> 0 Then
        fltBasIpi := RoundTo((fltFreAce / fltTotIte) * FieldByName('ENT_TOTITE').AsFloat, -2)
      Else
        fltBasIpi := 0;

      If chkAbaDes.Checked Then
      Begin
        If ((fltTotIte-fltTotSer) <> 0) and (FieldByName('ENT_CODITE').AsString <> strIteSer)
                                        And (FieldByName('ENT_CODITE').AsString <> strSerTer)
                                        And (FieldByName('ENT_TIPPRO').AsString <> TIPO_PRODUTO_SPED[9,0]) Then
          fltPerCor := FieldByName('ENT_TOTITE').AsFloat / (fltTotIte - fltTotSer)
        Else
          fltPerCor := 0;
          fltTmpDes := fFormataFloat(fltDesEsp * fltPerCor, 2);
      End Else
      Begin
          fltTmpDes := 0;
      //  fltTmpDesRes := 0;
      End;

      Edit;

//      If intNumReg = RecordCount Then
//      Begin
//        FieldByName('ENT_BASIPI').AsFloat := FieldByName('ENT_BASIPU').AsFloat + fltFreRes - fltTmpDesRes;
//        FieldByName('ENT_BAEIPI').AsFloat := FieldByName('ENT_BASIPU').AsFloat + fltFreRes - fltTmpDesRes
//      End Else
//      Begin
        FieldByName('ENT_BASIPI').AsFloat := FieldByName('ENT_BASIPU').AsFloat + fltBasIpi - IIf(chkDescontoIncondicional.Checked, 0, fltTmpDes);
        FieldByName('ENT_BAEIPI').AsFloat := FieldByName('ENT_BASIPU').AsFloat + fltBasIpi - IIf(chkDescontoIncondicional.Checked, 0, fltTmpDes);
//      End;

      If blnValIpi Then
      Begin
        FieldByName('ENT_VALIPI').AsFloat := RoundTo(FieldByName('ENT_BASIPI').AsFloat *
                                             (FieldByName('ENT_ALQIPI').AsFloat / 100), -2);

        FieldByName('ENT_VAEIPI').AsFloat := RoundTo(FieldByName('ENT_BAEIPI').AsFloat *
                                             (FieldByName('ENT_ALQIPI').AsFloat / 100), -2);

        fltIpiAcu := fltIpiAcu + FieldByName('ENT_VALIPI').AsFloat;
      End;

      Post;

//      fltFreRes    := fltFreRes - fltBasIpi;
//      fltTmpDesRes := fltTmpDesRes - fltTmpDes;

      Next;
    End;

    If blnValIpi Then
    Begin
      If chkFreTri.Checked Then
        fltTotIpi := RoundTo(fltIpiAcu, -2)
      Else
        fltTotIpi := fltTotIpiSav;
    End;

    pAtualizaTabela;

    If blnValIpi Then
      pRecalculaTotalGeral(blnValIpi);
  End;

  FreeAndNil(qryEntAux);
End;

procedure TfrmEntDadosFiscais.pRetornaBasesParaFrete(Var fltTotBasRet, fltTotBasAnt: Double);
  Var
    strSQL: String;
    qryEntMer: TUniQuery;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(ENT_BASRET) + SUM(ENT_BAERET)         AS BASRET, ';
  strSQL := strSQL + '  SUM(IF(ENT_ANTFRE = "S", ENT_BASANT, 0)) AS BASANT  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  TMP_ENTMER ';

  qryEntMer := fCriarQuery(strSQL, Self);
  With qryEntMer Do
  Begin
    Open;

    fltTotBasRet := FieldByName('BASRET').AsFloat;
    fltTotBasAnt := FieldByName('BASANT').AsFloat;

    Close;
  End;

  FreeAndNil(qryEntMer);
End;

procedure TfrmEntDadosFiscais.pRecalculaSubstituicao;
  Var
    fltTotBasRet,
    fltTotBasAnt,
    fltValRetAntFre,
    fltBasRetAntFre,
    fltAlqEst,
    fltTotSub,
    fltFreAce: Double;
    fatVenda : TFatVenda;
Begin
  If (Not fEmptyStr(recNotEle.strAutInc)) Then
    Exit;

  fltFreAce    := fStrToFloat(edtValFre.Text) + fStrToFloat(edtDesAce.Text);

  fltSubFre    := 0;
  fltAntFre    := 0;

  fltBasRetFre := 0;
  fltBasAntFre := 0;

  fltValRetAntFre := 0;
  fltBasRetAntFre := 0;

  If (fltFreAce > 0) Then
  Begin
    fatVenda := TFatVenda.CreateInstance('', False);
    Try
      fatVenda.strCliEst := fCadEmp('ESTADO');
      fatVenda.pPegaDadosFiscais(fCadEmp('ESTADO'), strIesFor, 'N', strEstFor, False);
      fltAlqEst := fatVenda.fltAlqIcm;
    Finally
      FreeAndNil(fatVenda);
    End;

    pCalculaTributacaoFrete(fRetMaiorIVA, fltAlqEst, fltFreAce, fltBasRetAntFre, fltValRetAntFre);
  End;

  If chkRetFre.Checked Then
  Begin
    pRetornaBasesParaFrete(fltTotBasRet, fltTotBasAnt);

    If fFormataFloat(fltTotBasRet + fltTotBasAnt,2) <> 0 Then
    Begin
      fltSubFre    := fFormataFloat(fltValRetAntFre * fltTotBasRet / (fltTotBasRet + fltTotBasAnt), 2);
      fltBasRetFre := fFormataFloat(fltBasRetAntFre * fltTotBasRet / (fltTotBasRet + fltTotBasAnt), 2);
    End
    Else
    Begin
      fltSubFre    := 0;
      fltBasRetFre := 0;
    End;

    fltAntFre    := fltValRetAntFre - fltSubFre;
    fltBasAntFre := fltBasRetAntFre - fltBasRetFre;

    fltTotSub := fltRetIte + fltSubFre;
  End  Else
  Begin

    fltTotSub := fltRetIte;

  End;

  edtTotRet.Text := FloatToStrF(fltTotSub, ffFixed, 12, 2);
  edtTotAnt.Text := FloatToStrF(fltTotAnt + fltAntFre, ffFixed, 12, 2);

  pRecalculaIpi(True);
  pCalculaTotalGeral;
End;

procedure TfrmEntDadosFiscais.pUpdateBasAnt(fltBasAnt, fltValAnt: Double; strAutInc: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  TMP_ENTMER ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  ENT_BASANT = :BASANT, ';
  strSQL := strSQL + '  ENT_VALANT = :VALANT  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    qryGen.SQL.Text := strSQL;

    ParamByName('BASANT').AsFloat  := fltBasAnt;
    ParamByName('VALANT').AsFloat  := fltValAnt;

    ParamByName('AUTINC').AsString := strAutInc;

    ExecSQL;
  End;
  FreeAndNil(qryGen);
End;

procedure TfrmEntDadosFiscais.pUpdateBasRet(fltBasRet: Double; strAutInc: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  TMP_ENTMER ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  ENT_BASRET = :BASRET, ';
  strSQL := strSQL + '  ENT_BAERET = :BAERET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    qryGen.SQL.Text := strSQL;

    If (strClaSub = '1') Then
    Begin
      ParamByName('BAERET').AsFloat  := fltBasRet;
      ParamByName('BASRET').AsFloat  := 0;
    End
    Else
    Begin
      ParamByName('BASRET').AsFloat  := fltBasRet;
      ParamByName('BAERET').AsFloat  := 0;
    End;

    ParamByName('AUTINC').AsString := strAutInc;
    ExecSQL;
  End;
  FreeAndNil(qryGen);

End;

procedure TfrmEntDadosFiscais.pRateiaBasRetFrete;
  Var
    fltTotIte,
    fltBaseRestante,
    fltValorAntRestante,
    fltBaseItem,
    fltValAntItem,
    fltTotIteAnt: Double;
    strCamRet,
    strUltAutInc,
    strUltAutIncAnt: String;
Begin

  If (fltBasRetFre + fltBasAntFre) > 0 Then
  Begin
    strUltAutInc  := '';

    If (strClaSub = '1') Then
      strCamRet := 'ENT_BAERET'
    Else
      strCamRet := 'ENT_BASRET';

    pAtualizaTabela;
    With qryEntMer Do
    Begin
      DisableControls;

      fltTotIte    := 0;
      fltTotIteAnt := 0;

      First;

      While Not Eof Do
      Begin

        If (FieldByName('ENT_ANTFRE').AsString = 'S') Or
           ((Pos(FieldByName('ENT_CODFIS').AsString, CST_SUBSTITUICAO) > 0) And
            (FieldByName(strCamRet).AsFloat > 0)) Then
        Begin

          If (FieldByName('ENT_ANTFRE').AsString = 'S') Then
          Begin
            fltTotIteAnt    := fltTotIteAnt + FieldByName('ENT_TOTITE').AsFloat;
            strUltAutIncAnt := FieldByName('AUTOINCREM').AsString;
          End;

          fltTotIte    := fltTotIte + FieldByName('ENT_TOTITE').AsFloat;
          strUltAutInc := FieldByName('AUTOINCREM').AsString;

        End;

        Next;
      End;

      fltBaseRestante     := fltBasAntFre + fltBasRetFre;
      fltValorAntRestante := fltAntFre;

      First;
      While Not Eof Do
      Begin

        If (FieldByName('ENT_ANTFRE').AsString = 'S') Then
        Begin

          If strUltAutInc = FieldByName('AUTOINCREM').AsString Then
            fltBaseItem := fltBaseRestante
          Else
            fltBaseItem := RoundTo((FieldByName('ENT_TOTITE').AsFloat / fltTotIte) * (fltBasAntFre + fltBasRetFre), -2);

          If strUltAutIncAnt = FieldByName('AUTOINCREM').AsString Then
            fltValAntItem := fltValorAntRestante
          Else
            fltValAntItem := RoundTo((FieldByName('ENT_TOTITE').AsFloat / fltTotIteAnt) * fltAntFre, -2);

          pUpdateBasAnt(FieldByName('ENT_BASANT').AsFloat + fltBaseItem,
                        FieldByName('ENT_VALANT').AsFloat + fltValAntItem,
                        FieldByName('AUTOINCREM').AsString);

          fltBaseRestante     := fltBaseRestante     - fltBaseItem;
          fltValorAntRestante := fltValorAntRestante - fltValAntItem;

        End

        Else If ((Pos(FieldByName('ENT_CODFIS').AsString, CST_SUBSTITUICAO) > 0) And (FieldByName(strCamRet).AsFloat > 0)) Then
        Begin

          If strUltAutInc = FieldByName('AUTOINCREM').AsString Then
            fltBaseItem := fltBaseRestante
          Else
            fltBaseItem := RoundTo((FieldByName('ENT_TOTITE').AsFloat / fltTotIte) * (fltBasAntFre + fltBasRetFre), -2);

          pUpdateBasRet(FieldByName(strCamRet).AsFloat + fltBaseItem, FieldByName('AUTOINCREM').AsString);

          fltBaseRestante := fltBaseRestante - fltBaseItem;
        End;

        Next;
      End;

      EnableControls;
    End;

  End;
End;

Function TfrmEntDadosFiscais.fEstaNaClaCom(strClaFis: String): Boolean;
Begin
  VS_strClaCom := fTransform(fCfgSisL('CLACOM'), 4);

  Result := Pos(strClaFis, VS_strClaCom) > 0;
End;

function TfrmEntDadosFiscais.fValidaCFOPsItens: Boolean;
  Var
    strClaCon: String;
    qryClsFis: TUniQuery;
begin
  strClaCon := fTransform(fCfgSisL('CLACON'), 4);
  qryClsFis := fCriaQuery;

  With qryClsFis Do
  Begin
    SQL.Add('SELECT REPLACE(GROUP_CONCAT(DISTINCT ENT_CLAFIS), ",", "") AS CLAFIS FROM TMP_ENTMER');
    Open;

    Result := Pos(fTransform(FieldByName('CLAFIS').AsString, 4), strClaCon) > 0;
  End;

  FreeAndNil(qryClsFis);
end;

function TfrmEntDadosFiscais.fValidaCodFiscal: Boolean;
begin
  Result :=  fVerificaAcessoSistema('ALTCST');
  If not Result Then
    Result := fLiberaDivengencia;
  If Result  Then
    Result:= fGravaLogAltCST(strNumDoc,
                             qryEntMer.FieldByName('ENT_CODITE').AsString,
                             qryEntMer.FieldByName('ENT_CODFIS').AsString,
                             edtCodFis.Text)

end;

function TfrmEntDadosFiscais.fValidaCodFiscalDosItens: Boolean;
Var
  qryAux: TUniQuery;
begin

  Result := True;
  qryAux := fCriaQuery();
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('    SELECT                             ');
    qryAux.SQL.Add('           ENT_CODITE                  ');
    qryAux.SQL.Add('      FROM                             ');
    qryAux.SQL.Add('           TMP_ENTMER                  ');
    qryAux.SQL.Add('     WHERE                             ');
    qryAux.SQL.Add('           IFNULL(ENT_CODFIS, "") = "" ');
    qryAux.Open;

   If Not qryAux.IsEmpty Then
     Result := False;

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmEntDadosFiscais.btnConfirmaClick(Sender: TObject);
  Var
    fatVenda: TFatVenda;
    fltAlqEst: Double;
    strClaFis: String;
    strMotDev: String;
    blnConf:   Boolean;
    LfrmEntDadosFiscaisResumo: TfrmEntDadosFiscaisResumo;
    blnCliente: Boolean;
    cmpEntDadosFiscaisResumo: TComponent;
begin
  inherited;
  LfrmEntDadosFiscaisResumo := nil;

  If (Not btnConfirma.Enabled) Then
  Begin
    Exit;
  End;

  If Not fIgualaCFOP(True) Then
    Exit;

  If (fTemCFOP('1922') > 0) And (Not fEstaNaClaCom('1922')) Then
  Begin
    pMensagemOk('Cadastre a CFOP 1922 em Configurações/ Classificações Fiscais/ Classificação de Compras!');
    Exit;
  End;

  If (fTemCFOP('2922') > 0) And (Not fEstaNaClaCom('2922')) Then
  Begin
    pMensagemOk('Cadastre a CFOP 2922 em Configurações/ Classificações Fiscais/ Classificação de Compras!');
    Exit;
  End;

  If (fTemCFOP('1117') > 0) And fEstaNaClaCom('1117') Then
  Begin
    pMensagemOk('A CFOP 1117 deve ser removida de Configurações/  Classificações Fiscais/ Classificação de Compras, esta nota não gravará contas a pagar!');
    Exit;
  End;

  If (fTemCFOP('2117') > 0) And fEstaNaClaCom('2117') Then
  Begin
    pMensagemOk('A CFOP 2117 deve ser removida de Configurações/  Classificações Fiscais/ Classificação de Compras, esta nota não gravará contas a pagar!');
    Exit;
  End;

  If blnConEqu Then
  Begin
    If Not fValidaCFOPsItens Then
    Begin
      pMensagemOk('Existem CFOPs nos itens que não são válidos para entrada de conserto de equipamento. Verifique!');
      Exit;
    End;
  End;

  blnCliente := (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) or (FblnAcessadoViaRetornoConsignacao);
  If (Not blnFulfillment) And (Not TEntTestaCFOPS.fVerificaCFOPS(True, dtaDtaEnt, dtaDtaDoc, strNumDoc, strEspDoc, strSerie, strCodFor, blnCliente)) Then
    Exit;

  If Not fValidaCodFiscalDosItens Then
  Begin
    pMensagemOk('Existem itens sem informação no código de situação tributária (CST). Verifique!');
    Exit;
  End;

  fatVenda := TFatVenda.CreateInstance('', False);
  Try
    fatVenda.pPegaDadosFiscais(fCadEmp('ESTADO'), strIesFor, '', strEstFor, False);
    fltAlqEst := fatVenda.fltAlqIcm;
    strClaFis := fatVenda.strClaFis;
  Finally
    FreeAndNil(fatVenda);
  End;

  If (fRetFornecedorSimples(strCodFor)) Then
  Begin
    fltAlqEst := fRetAlqProdTributado;
  End;

  If (strEstFor = fCadEmp('ESTADO')) Then
    strClaFis := '1' + RightStr(strClaFis, 3)
  Else
    strClaFis := '2' + RightStr(strClaFis, 3);

  If (Not fEmptyStr(recNotEle.strAutInc)) And
     (Not fEmptyStr(recNotEle.strClaBri)) Then
    strClaFis := recNotEle.strClaBri;

  if blnNotaImp Then
    strClaFis := '3' + RightStr(strClaFis, 3);

  TEntradaAutomatizada.pCriaClientLivro(cdsCadFis, Self);
  pCalculaResumoDadosFiscais(strNumDoc, strSerie, strEspDoc, strCodFor, dtaDtaDoc, dtaDtaEnt, fltAlqEst, strClaFis);

  blnConf := True;

  {**********************************}
  {* DIGITA OCORRÊNCIA DA DEVOLUÇÃO *}
  {*******************************RV*}
  If blnDevolu  And (fEmptyStr(strAutDev)) And (recNotEle.finalidadeXML <> xmlDevolucaoEntradaEmitidaFornecedor)Then
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
    cmpEntDadosFiscaisResumo := Application.FindComponent('frmEntDadosFiscaisResumo');

    If Assigned(cmpEntDadosFiscaisResumo) Then
    Begin
      LfrmEntDadosFiscaisResumo := TfrmEntDadosFiscaisResumo(cmpEntDadosFiscaisResumo);
      pFreeAndNil(LfrmEntDadosFiscaisResumo);
    End;

    Try
      Try
        If fRetTotItemServ > 0 Then
        Begin
          If Assigned(frmEntRetencaoNotaServico) Then
            FreeAndNil(frmEntRetencaoNotaServico);


          frmEntRetencaoNotaServico := TfrmEntRetencaoNotaServico.fChamaEntRetencoesNotaServico(cdsCadFis,
                                                                     strNumDoc,
                                                                     'E',
                                                                     'F',
                                                                     strCodFor,
                                                                   fRetNomFornecedor(strCodFor),
                                                                   VS_StrCodEmp,
                                                                   strSerie,
                                                                   dtaDtaEnt,
                                                                   strEspDoc,
                                                                   dtaDtaDoc,
                                                                   '1933')

      End;

        pCriarFormularios(TfrmEntDadosFiscaisResumo, LfrmEntDadosFiscaisResumo);

        LfrmEntDadosFiscaisResumo.fltCotDol      := fltCotDol;
        LfrmEntDadosFiscaisResumo.frmEntRetencaoNotaServico :=  frmEntRetencaoNotaServico;
        LfrmEntDadosFiscaisResumo.blnPrecoPraticado := blnPrecoPraticado;
        LfrmEntDadosFiscaisResumo.blnFreIpi := fRateioFreteValorContabil(tipRatFrete);
        LfrmEntDadosFiscaisResumo.dtsCadFis.DataSet := cdsCadFis;
        LfrmEntDadosFiscaisResumo.blnTravarFinanceiroEstaDuplicado := blnTravarFinanceiroEstaDuplicado;
        LfrmEntDadosFiscaisResumo.blnNotaImp     := blnNotaImp;
        LfrmEntDadosFiscaisResumo.blnEncargosNoFrete := blnEncargosNoFrete;
        LfrmEntDadosFiscaisResumo.tipRatFrete    := tipRatFrete;
        LfrmEntDadosFiscaisResumo.blnFreTri      := chkFreTri.Checked;
        LfrmEntDadosFiscaisResumo.fltRetIte      := fltRetIte;
        LfrmEntDadosFiscaisResumo.fltValAnt      := fStrToFloat(edtTotAnt.Text);
        LfrmEntDadosFiscaisResumo.cdsMovGad      := cdsMovGad;
        LfrmEntDadosFiscaisResumo.blnGarantia    := blnGarantia;
        LfrmEntDadosFiscaisResumo.dtaIcmAnt      := StrToDateDef(mskDtaAnt.Text, 0);
        LfrmEntDadosFiscaisResumo.strAutDev      := strAutDev;
        LfrmEntDadosFiscaisResumo.objEmbala      := objEmbala;
        LfrmEntDadosFiscaisResumo.blnCarPro      := blnCarPro;
        LfrmEntDadosFiscaisResumo.recNotEle      := recNotEle;
        LfrmEntDadosFiscaisResumo.fraPlanoDeContas.MskCodCta.Text := strCodCta;
        LfrmEntDadosFiscaisResumo.strOrdIte      := strOrdIte;
        LfrmEntDadosFiscaisResumo.strNumDoc      := strNumDoc;
        LfrmEntDadosFiscaisResumo.strSerie       := strSerie;
        LfrmEntDadosFiscaisResumo.strEspDoc      := strEspDoc;
        LfrmEntDadosFiscaisResumo.strCodFor      := strCodFor;
        LfrmEntDadosFiscaisResumo.strCgcCpf      := strCgcCpf;
        LfrmEntDadosFiscaisResumo.strTipCgcCpf   := strTipCgcCpf;
        LfrmEntDadosFiscaisResumo.dtaDtaDoc      := dtaDtaDoc;
        LfrmEntDadosFiscaisResumo.dtaDtaent      := dtaDtaEnt;
        LfrmEntDadosFiscaisResumo.strEstFor      := strEstFor;
        LfrmEntDadosFiscaisResumo.PerfilDespachanteAduaneiro := PerfilDespachanteAduaneiro;
        LfrmEntDadosFiscaisResumo.strCodFaz      := strCodFaz;
        LfrmEntDadosFiscaisResumo.fltAlqFor      := fltAlqFor;
        LfrmEntDadosFiscaisResumo.blnDevolu      := blnDevolu;
        LfrmEntDadosFiscaisResumo.blnConEqu      := blnConEqu;
        LfrmEntDadosFiscaisResumo.blnLocEqu      := blnLocEqu;
        LfrmEntDadosFiscaisResumo.edtCodRep.Text := strCodRep;
        LfrmEntDadosFiscaisResumo.edtCodOpe.Text := strCodVen;
        LfrmEntDadosFiscaisResumo.edtValFre.Text := AnsiReplaceStr(edtValFre.Text, '.', '');
        LfrmEntDadosFiscaisResumo.edtDesAce.Text := AnsiReplaceStr(edtDesAce.Text, '.', '');
        LfrmEntDadosFiscaisResumo.fltAlqPis      := fStrToFloat(edtAlqPis.Text);
        LfrmEntDadosFiscaisResumo.fltAlqCof      := fStrToFloat(edtAlqCof.Text);
        LfrmEntDadosFiscaisResumo.fltTotPis      := fStrToFloat(edtTotPis.Text);
        LfrmEntDadosFiscaisResumo.fltTotCof      := fStrToFloat(edtTotCof.Text);
        LfrmEntDadosFiscaisResumo.fltBasPis      := fStrToFloat(edtBasPis.Text);
        LfrmEntDadosFiscaisResumo.fltBasCof      := fStrToFloat(edtBasCof.Text);
        LfrmEntDadosFiscaisResumo.intNumIte      := dbgItens.DataSource.DataSet.RecordCount;
        LfrmEntDadosFiscaisResumo.strPedDev      := strPedDev;
        LfrmEntDadosFiscaisResumo.qryEntMer      := qryEntMer;
        LfrmEntDadosFiscaisResumo.stlPedidos     := stlPedidos;
        LfrmEntDadosFiscaisResumo.strConPag      := strConPag;
        LfrmEntDadosFiscaisResumo.blnRecCliGarantia := blnRecCliGarantia;
        LfrmEntDadosFiscaisResumo.strMatRev      := strMatRev;

        if blnRecCliGarantia then
        begin
          LfrmEntDadosFiscaisResumo.fltDesEspRecCliGarantia := fltDesEspRecCliGarantia;
          LfrmEntDadosFiscaisResumo.fltTotIte := fltTotIte;
        end
        else begin
          LfrmEntDadosFiscaisResumo.fltDesEspRecCliGarantia := 0;
          LfrmEntDadosFiscaisResumo.fltTotIte := fltTotIte;
        end;

        LfrmEntDadosFiscaisResumo.strMotDev := strMotDev;
        LfrmEntDadosFiscaisResumo.blnFornJaAtualizado:= blnFornJaAtualizado;
        LfrmEntDadosFiscaisResumo.blnDescontoIncondicional  := chkDescontoIncondicional.Checked;
        LfrmEntDadosFiscaisResumo.strDocSel := strDocSel;

        LfrmEntDadosFiscaisResumo.onBeforeConfirmaEntrada := onBeforeConfirmaEntrada;
        LfrmEntDadosFiscaisResumo.onAfterConfirmaEntrada := onAfterConfirmaEntrada;
        LfrmEntDadosFiscaisResumo.fAoConfirmarEntrada := fAoConfirmarEntrada;

        LfrmEntDadosFiscaisResumo.arrDuplicata := arrDuplicata;

        LfrmEntDadosFiscaisResumo.arrDocOri      := arrDocOri;
        LfrmEntDadosFiscaisResumo.blnPedFilialGarantia := blnPedFilialGarantia;

        If (Not fEmptyStr(strCodEve)) Then
        Begin
          LfrmEntDadosFiscaisResumo.fraCentroCusto.edtCodEve.Text := strCodEve;
          LfrmEntDadosFiscaisResumo.fraCentroCusto.edtDesEve.Text := fRetNomEvento(strCodEve);
        End;

        If (Not fEmptyStr(strCodCta)) Then
        Begin
          LfrmEntDadosFiscaisResumo.fraPlanoDeContas.MskCodCta.Text := strCodCta;
          LfrmEntDadosFiscaisResumo.fraPlanoDeContas.edtDesCta.Text := fRetDescCentroCusto(strCodCta);
        End;

        LfrmEntDadosFiscaisResumo.arrClienteConsumidor := arrClienteConsumidor;

        if FblnAcessadoViaRetornoConsignacao then
        Begin
          LfrmEntDadosFiscaisResumo.blnAcessadoViaRetornoConsignacao := FblnAcessadoViaRetornoConsignacao;
          LfrmEntDadosFiscaisResumo.TipoRetornoConsignacao           := FTipoRetornoConsignacao;
        End;

        If (recNotEle.finalidadeXML = xmlRetornoSimbolico) Then
        Begin
          LfrmEntDadosFiscaisResumo.pShow;
          LfrmEntDadosFiscaisResumo.btnConfirma.Click;
        End
        Else
          LfrmEntDadosFiscaisResumo.showModal;

        strVeiBol   := IIF(LfrmEntDadosFiscaisResumo.chkVeiobo.Checked, 'S', 'N');
        strDeposi   := IIF(LfrmEntDadosFiscaisResumo.chkDeposi.Checked, 'S', 'N');
        strBcoFor   := LfrmEntDadosFiscaisResumo.strBcoFor;
        blnConfirma := LfrmEntDadosFiscaisResumo.blnConfirma;
        strSeqGer   := LfrmEntDadosFiscaisResumo.strAutInc;
        strChaNFe   := LfrmEntDadosFiscaisResumo.strChaNFe;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmEntDadosFiscais.btnConfirmaClick]');
        End;
      End;

    Finally
      If Assigned(frmEntRetencaoNotaServico) Then FreeAndNil(frmEntRetencaoNotaServico);
      If Assigned(LfrmEntDadosFiscaisResumo) Then pFreeAndNil(LfrmEntDadosFiscaisResumo);
    End;
  End;

  If (Not Assigned(qryConCfo)) Then
    qryConCfo := fCriarQuery('SELECT * FROM CADCFO WHERE FALSE', Self);

  If blnConfirma Then
  Begin
    If Assigned(cdsCadFis) Then
      FreeAndNil(cdsCadFis);
    Close;
  End
  Else
  Begin
    If blnAutomatico Then
      Close
    Else
     pRestauraDadosAnteriores;
  End;

end;

procedure TfrmEntDadosFiscais.pRecalculaTotalGeral(blnValIpi: Boolean = False);
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;

begin
  Try

    qryGenMer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(ENT_VALIPI) AS TOTIPI, ';
    strSQL := strSQL + '  SUM(IF(ENT_VALRET > 0, ENT_VALRET, ENT_VAERET)) AS TOTRET, ';
    strSQL := strSQL + '  SUM(ENT_VALANT) AS TOTANT  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';

    With qryGenMer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      edtTotIpi.Text := FloatToStrF(FieldByName('TOTIPI').AsFloat, ffFixed, 12, 2);

      If Not blnValIpi Then
      Begin

        If chkRetFre.Checked Then
        Begin

          edtTotRet.Text := FloatToStrF(FieldByName('TOTRET').AsFloat + fltSubFre, ffFixed, 12, 2);
          edtTotAnt.Text := FloatToStrF(FieldByName('TOTANT').AsFloat + fltAntFre, ffFixed, 12, 2);

        End Else
        Begin

          edtTotRet.Text := FloatToStrF(FieldByName('TOTRET').AsFloat, ffFixed, 12, 2);
          edtTotAnt.Text := FloatToStrF(FieldByName('TOTANT').AsFloat, ffFixed, 12, 2);

        End;

      End;

      Close;

    End;

    pCalculaTotalGeral;

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

procedure TfrmEntDadosFiscais.FormDestroy(Sender: TObject);
begin
  If Assigned(cdsCadFis) Then
    FreeAndNil(cdsCadFis);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

end;

procedure TfrmEntDadosFiscais.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) And (btnCFOPTodos.Enabled) And (btnCFOPTodos.Visible) Then
    btnCFOPTodos.Click;
end;

{*******************************************}
{* REALIZA A COPIA DE UMA TABELA           *}
{****************************************MA*}
procedure TfrmEntDadosFiscais.pCopiaTabela( strOrigem, strDestino: String );
  Var strSQL: String;
    qryGenDel: TUniQuery;

begin
  Try

    qryGenDel := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' DELETE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '    ' + strDestino;

    With qryGenDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSql;
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + ' INSERT ';
    strSQL := strSQL + ' INTO ' + strDestino;
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '    * ';
    strSQL := strSQL + ' FROM ' + strOrigem;
    If Not fEmptyStr(strOrdIte) Then
      strSQL := strSQL + ' ORDER BY ' + strOrdIte;

    With qryGenDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSql;
      Close;
    End;

  Finally
    FreeAndNil(qryGenDel);
  End;

End;

procedure TfrmEntDadosFiscais.edtTotIpiExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtTotIpi.Text) Then
  Begin
    edtTotIpi.Text := '0,00';
  End;
end;

Function TfrmEntDadosFiscais.fCalculaPisCofins: Boolean;
Var
  fltPerPis,
  fltPerCof: Double;
  fltTotPis: Double;
  fltTotCof: Double;
  fltBasPis: Double;
  fltBasCof: Double;

  CalcResult: TResultPisCofins;
  tmp: TCalculoPisCofins;

  fltValIpi,
  fltValRet: Double;
  strSitP_C: String;
begin
  Result := True;

  With qryEntMer Do
  Begin
    DisableControls;
    First;

    fltTotGPC := 0;

    fltPerPis := 0;
    fltPerCof := 0;
    fltBasPis := 0;
    fltBasCof := 0;
    fltTotPis := 0;
    fltTotCof := 0;
    strSitP_C := fDefineSit_P_C(VS_strCodEmp, strCodFor);


    While Not Eof Do
    Begin
      If FieldByName('ENT_VALIPI').AsFloat > 0 Then
        fltValIpi := FieldByName('ENT_VALIPI').AsFloat
      Else
        fltValIpi := FieldByName('ENT_VAEIPI').AsFloat;

      If FieldByName('ENT_VALRET').AsFloat > 0 Then
        fltValRet := FieldByName('ENT_VALRET').AsFloat
      Else
        fltValRet := FieldByName('ENT_VAERET').AsFloat;

      tmp := TCalculoPisCofins.Create;
      Try
        CalcResult := tmp.fCalculoPisCofins(VS_strCodEmp,
                                            FieldByName('ENT_CODITE').AsString,
                                            FieldByName('ENT_CLAFIS').AsString,
                                            FieldByName('ENT_CODFIS').AsString,
                                            strCodFor,
                                            IIf(fCfgSis('SIMPAU',varBoolean) and (fCfgSis('IGNSIM') = '1'), 'S', 'N'),
                                            strEspDoc,
                                            FieldByName('ENT_TOTITE').AsFloat,
                                            FieldByName('ENT_DESESP').AsFloat,
                                            fltValIpi,
                                            fltValRet,
                                            FieldByName('ENT_VALFRE').AsFloat,
                                            FieldByName('ENT_DESACE').AsFloat,
                                            FieldByName('ENT_VALICM').AsFloat,
                                            0,
                                            IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu  or blnLocEqu or FblnAcessadoViaRetornoConsignacao,'C','F'),
                                            FieldByName('ENT_INCPIS').AsString,
                                            strSitP_C,
                                            '',
                                            dtaDtaEnt,
                                            '',
                                            False,
                                            False,
                                            '',
                                            '',
                                            '',
                                            '',
                                            False,
                                            FieldByName('ENT_SITXML').AsString,
                                            FieldByName('ENT_ICMXML').ASFloat,
                                            FieldByName('ENT_CSTPIS').AsString,
                                            FieldByName('ENT_CSTCOF').AsString,
                                            FieldByName('ENT_VALPIS').AsFloat,
                                            FieldByName('ENT_VALCOF').AsFloat);
      Finally
        tmp.Destroy;
      End;

      Result := CalcResult.blnResult;

      If Not Result Then
        Exit;

      lblPisCofinsCalcPorCfg.Visible := CalcResult.blnCarregadoPelaCFG_SUFIPC;
      If CalcResult.dblBasePis > 0 Then
      Begin
        fltPerPis := CalcResult.dblAlqPis;
        fltPerCof := CalcResult.dblAlqCof;
      End;

      fltBasPis := fltBasPis + CalcResult.dblBasePis;
      fltBasCof := fltBasCof + CalcResult.dblBaseCof;
      fltTotPis := fltTotPis + CalcResult.dblValorPis;
      fltTotCof := fltTotCof + CalcResult.dblValorCof;

      Next;
    End;

    EnableControls;

    edtAlqPis.Text := FloatToStrF(fltPerPis, ffFixed, 12, 4);
    edtAlqCof.Text := FloatToStrF(fltPerCof, ffFixed, 12, 4);
    edtBasPis.Text := FormatFloat(fMskDigitos(2), fltBasPis);
    edtBasCof.Text := FormatFloat(fMskDigitos(2), fltBasCof);
    edtTotPis.Text := FormatFloat(fMskDigitos(2), fltTotPis);
    edtTotCof.Text := FormatFloat(fMskDigitos(2), fltTotCof);
  End;
end;

procedure TfrmEntDadosFiscais.pCarregaNatOperacao(strCodCfo: String);
var qryNatOpe: TUniQuery;
Begin
  Try
    qryNatOpe := fCriaQuery(Self);
    qryNatOpe.Close;
    qryNatOpe.SQL.Clear;
    qryNatOpe.SQL.Add('SELECT AUTOINCREM, NAT_DESCRI FROM NATCFO');
    qryNatOpe.SQL.Add('WHERE NAT_ATIVO_ = "S" ');
    qryNatOpe.SQL.Add('  AND NAT_CODCFO = :CODCFO');
    qryNatOpe.ParamByName('CODCFO').AsString := strCodCfo;
    qryNatOpe.Open;

    cmbNatOpe.Clear;
    qryNatOpe.First;
    While not qryNatOpe.eof do
    Begin                       //AJUSTE AQUI
      //cmbNatOpe.Items.Add(qryNatOpe.FieldByName('NAT_DESCRI').AsString );
      cmbNatOpe.Items.AddObject(qryNatOpe.FieldByName('NAT_DESCRI').AsString,TObject(qryNatOpe.FieldByName('AUTOINCREM').AsString));

      qryNatOpe.Next;
    End;

    If qryNatOpe.RecordCount > 0 Then
    Begin
      cmbNatOpe.ItemIndex := cmbNatOpe.Items.IndexOf(qryNatOpe.FieldByName('NAT_DESCRI').AsString);
    End;


  Finally
    FreeAndNil(qryNatOpe);
  End;

End;


procedure TfrmEntDadosFiscais.FormCreate(Sender: TObject);
begin
  inherited;
  fAoConfirmarEntrada := Nil;
  blnFornJaAtualizado:= False;
  blnManterIpi := False;
  blnAutomatico := False;
  objLiberacao := TLiberacao.Create;
  onBeforeConfirmaEntrada := nil;
  onAfterConfirmaEntrada := nil;
  blnZeraIcmsDevolucao := True;
  blnFulfillment := False;
  {*******************************************}
  {* ------------> ATENÇÃO <---------------- *}
  {* NÃO COLOCAR NADA NO ONCREATE DESSE FORM *}
  {* POIS O MESMO É CRIADO SOMENTE UMA VEZ   *}
  {* COLOCAR, SE NECESSÁRIO, NO ONSHOW       *}
  {****************************************MV*}
end;

procedure TfrmEntDadosFiscais.pHabilitaCheksTributacao;
Begin
  If (fStrToFloat(edtValFre.Text) > 0) Or
     (fStrToFloat(edtDesAce.Text) > 0) Then
  Begin
    chkFreTri.Enabled := True;
    chkRetFre.Enabled := True;
  End
  Else
  Begin
    chkFreTri.Enabled := False;
    chkRetFre.Enabled := False;
  End;
End;

procedure TfrmEntDadosFiscais.edtValFreEnter(Sender: TObject);
begin
  inherited;
  strValFreEntObj := edtValFre.Text;
end;

procedure TfrmEntDadosFiscais.edtValFreExit(Sender: TObject);
begin
  inherited;
  pHabilitaCheksTributacao;
  cbbTipFre.Enabled := fStrToFloat(edtValFre.Text) > 0;
  pRecalculaSubstituicao;

end;

procedure TfrmEntDadosFiscais.chkFreTriClick(Sender: TObject);
begin
  inherited;

  pRecalculaSubstituicao;

end;

function TfrmEntDadosFiscais.fPedeSenhaAlteracaoFrete: Boolean;
Begin
  Result := True;

  If  (fStrToFloat(strValFreEntObj) <> fStrToFloat(edtValFre.Text)) And
      (fStrToFloat(strFreOri) <> fStrToFloat(edtValFre.Text)) And blnDevolu And
      blnPrecoPraticado And Not fVerificaAcessoSistema('ALTFRE') Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTextoCaption('DOCUMENTO', strNumDoc + '-' + strEspDoc + '-' + strSerie + ' '+ VS_strCodEmp + '-' + fRetNomeEmpresa(VS_strCodEmp));
    objLiberacao.objMsgLibera.pAddTextoCaption('FORNECEDOR'         , strCodFor + '-' + fRetNomFornecedor(strCodFor));
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('VALOR DO FRETE DO DOCUMENTO DE VENDA ORIGINAL FOI ALTERADO.');
    objLiberacao.objMsgLibera.pAddTextoCaption('FRETE ORIGINAL: ', strFreOri);
    objLiberacao.objMsgLibera.pAddTextoCaption('FRETE ALTERADO: ', FormatFloat('#0.00',fStrToFloat(edtValFre.Text)));
    objLiberacao.objMsgLibera.pAddQuebra;

    objLiberacao.strDirAce := 'ALTFRE';
    objLiberacao.strMsgSen := 'VALOR DO FRETE ORIGINAL FOI ALTERADO.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnSempreVariavelUsuario := True;

    Result := objLiberacao.fLibera;

    objLiberacao.Clear;

    If Not Result then
      edtValFre.Text := strFreOri
    Else
      strValFreEntObj := edtValFre.Text;
  End;
end;


function TfrmEntDadosFiscais.fRetAlqProdTributado: Double;
  Var
    intRecNo: Integer;
    dtsItens: TDataSet;
begin

  Result := 0.0;

  dtsItens := dbgItens.DataSource.DataSet;

  intRecNo := dtsItens.RecNo;

  dtsItens.First;

  While (Not dtsItens.Eof) Do
  Begin

    If (dtsItens.FieldByName('ENT_CODFIS').AsString = '000') Then
    Begin
      Result := dtsItens.FieldByName('ENT_ALQICM').AsFloat;
    End;

    dtsItens.Next;
  End;

  If (intRecNo > 0) And (intRecNo <= dtsItens.RecordCount) Then
  Begin
    Try
      dtsItens.RecNo := intRecNo;
    Except
      //
    End;
  End;
end;

procedure TfrmEntDadosFiscais.pRestauraDadosAnteriores;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  TMP_ENTMER E, ');
  qryAux.SQL.Add('  TMP_ENTTMP T ');
  qryAux.SQL.Add('SET ');

  If fEmptyStr(recNotEle.strAutInc) Then
  Begin
    qryAux.SQL.Add('  E.ENT_BASIPI = T.ENT_BASIPI, ');
    qryAux.SQL.Add('  E.ENT_BAEIPI = T.ENT_BAEIPI, ');
    qryAux.SQL.Add('  E.ENT_BASANT = T.ENT_BASANT  ');
  End
  Else
  Begin
    qryAux.SQL.Add(' E.ENT_BASIPI = IF(E.ENT_BASIPI > 0, T.ENT_BASIPI, 0), ');
    qryAux.SQL.Add(' E.ENT_BAEIPI = IF(E.ENT_BAEIPI > 0, T.ENT_BAEIPI, 0), ');
    qryAux.SQL.Add(' E.ENT_BASANT = IF(E.ENT_BASANT > 0, T.ENT_BASANT, 0) ');
  End;

  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  E.AUTOINCREM = T.AUTOINCREM ');

  qryAux.ExecSQL;

  FreeAndNil(qryAux);

  pRecalculaIpi(False);

  pAtualizaTabela;
end;

procedure TfrmEntDadosFiscais.cbbTipFreChange(Sender: TObject);
begin
  inherited;
  case cbbTipFre.ItemIndex Of
    0 : tipRatFrete := trfPropValorItem;
    1 : tipRatFrete := trfPropPesoItem;
    2 : tipRatFrete := trfPropQtdItem;
  end;
end;

procedure TfrmEntDadosFiscais.cbbTipFreExit(Sender: TObject);
begin
  inherited;
  pSetFocus(btnCalculaImpostos);
end;

procedure TfrmEntDadosFiscais.chkAbaDesClick(Sender: TObject);
begin
  inherited;
  pRecalculaSubstituicao;
end;

procedure TfrmEntDadosFiscais.chkApliRedClick(Sender: TObject);
begin
  inherited;
  pHabilitaTotSub;
end;

procedure TfrmEntDadosFiscais.pTrocaValoresSubstituicao(strClaSub: String);
  Var
    qryEntMer: TUniQuery;
Begin
  qryEntMer := fCriaQuery(Self);

  With qryEntMer, SQL Do
  Begin
    Clear;
    Add('UPDATE TMP_ENTMER SET');

    If strClaSub = '1' Then
    Begin
      Add('ENT_BAERET = ENT_BASRET,');
      Add('ENT_VAERET = ENT_VALRET,');
      Add('ENT_BASRET = 0,');
      Add('ENT_VALRET = 0');
    End Else
    Begin
      Add('ENT_BASRET = ENT_BAERET,');
      Add('ENT_VALRET = ENT_VAERET,');
      Add('ENT_BAERET = 0,');
      Add('ENT_VAERET = 0');
    End;

    ExecSQL;

  End;

  FreeAndNil(qryEntMer);
End;

procedure TfrmEntDadosFiscais.chkCreSubClick(Sender: TObject);
begin
  inherited;

  chkCreSub.Enabled := False;

  If chkCreSub.Checked Then
  Begin

    If strClaSub <> '2' Then
      pTrocaValoresSubstituicao('2');

    strClaSub := '2';

  End Else
  Begin

    If strClaSub <> '1' Then
      pTrocaValoresSubstituicao('1');

    strClaSub := '1';
  End;

  chkCreSub.Enabled := True;
end;

procedure TfrmEntDadosFiscais.pHabilitaTotSub;
begin
  If Not chkApliRed.Checked Then
  Begin
    edtTotRet.Enabled := False;
    edtTotRet.Text    := FloatToStrF(fltTotRetOri, ffFixed, 12, 2);
  End
  Else
    edtTotRet.Enabled := True;

  pHabilitaRateioFrete;
end;

procedure TfrmEntDadosFiscais.pAtualizaEdtTotSub;
begin
  edtTotRet.Text := FloatToStrF(fCampoTabela('SUM(ENT_VALRET + ENT_VAERET)', 'TMP_ENTMER', [], []), ffFixed, 12, 2);
  edtTotAnt.Text := FloatToStrF(fCampoTabela('SUM(ENT_VALANT)', 'TMP_ENTMER', [], []), ffFixed, 12, 2);
end;

procedure TfrmEntDadosFiscais.pCalculaTotaisCabecalho;
  Var
    strSQL   : String;
    qryGenMer: TUniQuery;

begin
  Try

    qryGenMer := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(ENT_VLRCON)  ' + IIf(chkDescontoIncondicional.Checked, ' - SUM(ENT_DESESP)' , '') + 'AS ENT_VLRCON ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TMP_ENTMER ';

    With qryGenMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      edtTotGer.Text := FormatFloat(fMskDigitos(2), FieldByName('ENT_VLRCON').AsFloat);

      Close;
    End;

  Finally
    FreeAndNil(qryGenMer);
  End;

end;

procedure TfrmEntDadosFiscais.pShow;
var Column: TColumn;
    blnColumnVisible: Boolean;
Begin
  If blnRecCliGarantia Then
    edtDesEsp.Enabled := False;

  blnSeparaICMDesoneradoDoDesconto := fSeparaICMDesoneradoDoDesconto;

  lblTotDes.Visible := blnSeparaICMDesoneradoDoDesconto;
  edtTotDes.Visible := blnSeparaICMDesoneradoDoDesconto;

  strEstEmp := fCadEmp('ESTADO');

  fltBasRetFre := 0;
  fltAntFre    := 0;
  fltSubFre    := 0;
  pDeterminaTipoDeFrete;

  fltTotIte    := fStrToFloat(edtTotIte.Text);
  fltTotIteRet := fRetornaTotIteRet;

  fltTotIpiSav := fltTotIpi;

  lblBasPis.Enabled := Not blnSimPau;
  edtBasPis.Enabled := Not blnSimPau;
  lblAlqPis.Enabled := Not blnSimPau;
  edtAlqPis.Enabled := Not blnSimPau;
  lblTotPis.Enabled := Not blnSimPau;
  edtTotPis.Enabled := Not blnSimPau;

  lblBasCof.Enabled := Not blnSimPau;
  edtBasCof.Enabled := Not blnSimPau;
  lblAlqCof.Enabled := Not blnSimPau;
  edtAlqCof.Enabled := Not blnSimPau;
  lblTotCof.Enabled := Not blnSimPau;
  edtTotCof.Enabled := Not blnSimPau;

  blnTemAnt := fTemAntecipacaoIcms;

  If blnTemAnt Then
    chkRetFre.Caption := 'Calcular Retido/Antecipado para Frete';

  lblTotAnt.Visible := blnTemAnt;
  edtTotAnt.Visible := blnTemAnt;
  lblBasAnt.Visible := blnTemAnt;
  edtBasAnt.Visible := blnTemAnt;
  lblValAnt.Visible := blnTemAnt;
  edtValAnt.Visible := blnTemAnt;
  lblDtaAnt.Visible := blnTemAnt;
  mskDtaAnt.Visible := blnTemAnt;

  If mskDtaAnt.Visible Then
    mskDtaAnt.Text  := DateToStr(fProximoVencimentoIcmAnt(fCfgSis('ANTVEN', varInteger), dtaDtaEnt));

  fltTotOri := 0.0;
  fltDesEsp := 0.0;
  fltDesAce := 0.0;
  fltValFre := 0.0;
  fltTotLiq := 0.0;


  chkFreTri.Checked  := (fCfgSis('FRETRI', varBoolean));
  chkApliRed.Checked := (fCfgSis('REDSUB', varBoolean));
  pInicializaClaSub;

  If Not fEmptyStr(recNotEle.strAutInc) Then
  Begin
    edtBasPis.ReadOnly := True;
    edtBasPis.TabStop  := False;

    edtBasCof.ReadOnly := True;
    edtBasCof.TabStop  := False;

    edtAlqPis.ReadOnly := True;
    edtAlqPis.TabStop  := False;

    edtAlqCof.ReadOnly := True;
    edtAlqCof.TabStop  := False;

    fCalculaPisCofins;
  End;

  blnConfirma := False;

  //Cria uma Copia dos Itens da TABELA TMP_ENTMER
  pCopiaTabela( 'TMP_ENTMER', 'TMP_ENTTMP' );

  pAtualizaDadosICMSAntecipado;

  qryConCfo := fCriarQuery('SELECT * FROM CADCFO WHERE FALSE', Self);
  pAjustaCamposReforma;
  qryEntMer.AfterScroll := pAtualizaEdits;
  dtsEntMer := TDataSource.Create(Self);
  dtsEntMer.DataSet := qryEntMer;
  dbgItens.DataSource := dtsEntMer;

  pAtualizaTabela;
  
  pHabilitaCamposValores(False);
  dbgItens.Enabled    := False;

  If Self.Visible Then
    pSetFocus(edtDesEsp);

  btnConfirma.Enabled := False;
  pLimpaEdits;

  If (Not fEmptyStr(recNotEle.strAutInc)) Then
  Begin
    edtDesEsp.Text := FormatFloat(fMskDigitos(2), recNotEle.fltValDes);

    If blnSeparaICMDesoneradoDoDesconto Then
    Begin
      edtICMDes.Text := FormatFloat(fMskDigitos(2), recNotEle.fltICMDes);
      edtDesPis.Text := FormatFloat(fMskDigitos(2), recNotEle.fltDesPis);
      edtTotLiq.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtTotIte.Text) - recNotEle.fltValDes - recNotEle.fltICMDes - recNotEle.fltDesPis);

      edtTotDes.Text := FormatFloat(fMskDigitos(2), recNotEle.fltValDes + recNotEle.fltICMDes + recNotEle.fltDesPis);
    End Else
    Begin
      edtTotLiq.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtTotIte.Text) - recNotEle.fltValDes);
    End;

    edtDesAce.Text := FormatFloat(fMskDigitos(2), recNotEle.fltOutras + recNotEle.fltValSeg);
  end
  Else
  Begin
    If blnDevolu And blnSeparaICMDesoneradoDoDesconto Then
      edtTotDes.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtDesEsp.Text));
  End;

  If (Not fEmptyStr(recNotEle.strAutInc)) Or blnRecCliGarantia Then
  Begin
    edtCodFis.ReadOnly    := False;
    edtCodFis.TabStop     := True;
    edtCodFis.Enabled     := True;
    edtCodFis.color       := clWindow;
    edtCodFis.Normalcolor := clWindow;
  End;

  pCalculaTotalGeral;
  pHabilitaRateioFrete;

  edtClaFis.Text := qryEntMer.FieldByName('ENT_CLAFIS').AsString;

  pCarregaNatOperacao(edtClaFis.Text);
  If (qryEntMer.FieldByName('ENT_NATOPE').IsNull) Or fEmptyStr(qryEntMer.FieldByName('ENT_NATOPE').AsString) Then
  Begin

    qryEntMer.Edit;
    qryEntMer.FieldByName('ENT_NATOPE').AsString:= fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(edtClaFis.text));
    qryEntMer.Post;

    cmbNatOpe.ItemIndex := cmbNatOpe.Items.IndexOf(qryEntMer.FieldByName('ENT_NATOPE').AsString);

  End;


  pDesabilitaPraticado;
  pHabilitaCheksTributacao;

  pDesabilitaCamposNFE;

  pSetFocus(btnCalculaImpostos);
  btnCFOPTodos.Visible := TipoRetornoConsignacao = ttrEntradaManual;

  // Colunas de Desconto e Desconto Desonerado
  blnColumnVisible := ((fCfgSis('FRMCUS', varInteger) = 4) And (fCfgSis('SUFRAM', varBoolean)));
  Column := fFindColumnByName(dbgItens, 'ENT_VICMDE');
  If Assigned(Column) then
    Column.Visible := blnColumnVisible;
  Column := fFindColumnByName(dbgItens, 'ENT_DESCON');
  If Assigned(Column) then
    Column.Visible := blnColumnVisible;

  if Not blnRecCliGarantia then
    fltDesEspRecCliGarantia := 0;

  if blnRecCliGarantia then
  Begin
    chkDescontoIncondicional.Visible := False;
    chkDescontoIncondicional.Checked := False;
  End;


End;

end.


