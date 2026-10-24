{***************************}
{* qryConPor -> CADPOR     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
unit untCadMovBancario;

interface

uses
  Classes, Controls, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, QColorLabel, Menus, EditFocus, DB, Uni, Windows,
  MaskEditFocus, AppEvnts, BitBtnLockedIncrem, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, strUtils, untMovBan,  Messages,
  UniClientDataSet, untLiberacao, System.Generics.Collections, untMsgLiberacao,
  System.IOUtils, dxScreenTip, cxClasses, dxCustomHint, cxHint,
  untFrameCentroCustoDBEditFocus, Vcl.Forms, untFechamentoFinanceiro,
  untRcxTResumoDeCaixa, untFramePlanoDeContasMaskEdit,
  untFramePlanoDeContasDBEditFocus, frxDBSet,untTValidaCorrespondenteContabil,
  untTMovBan, untTMovBanRepository, Aurelius.Types.Nullable,
  System.DateUtils;

type
  TfrmCadMovBancario = class(TfrmPaiCad)
    Label1: TLabel;
    dbeSeqLan: TDBEditFocus;
    Label2: TLabel;
    dbeCodPor: TDBEditFocus;
    Label3: TLabel;
    dbeDtaLan: TDBEditFocus;
    Label4: TLabel;
    dbeNumDoc: TDBEditFocus;
    dbeCreDeb: TDBEditFocus;
    Label6: TLabel;
    dbeValLan: TDBEditFocus;
    Label8: TLabel;
    dbeHisto01: TDBEditFocus;
    dbeHisto02: TDBEditFocus;
    ColorLabel1: TColorLabel;
    edtNomPor: TEditFocus;
    pnlFundo: TPanel;
    gpbContraPartida: TGroupBox;
    Label5: TLabel;
    edtNomPor2: TEditFocus;
    edtPortadorCaixa: TEditFocus;
    dtsMovBan: TDataSource;
    lblPorRes: TLabel;
    mskCompet: TMaskEditFocus;
    Label10: TLabel;
    pnlBotoesInfo: TPanel;
    btnAbrirPastaAnexos: TBitBtnLocked;
    btnHistMovBan: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    Label11: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    Label12: TLabel;
    fraCentroCusto: TfraCentroCustoDBEditFocus;
    chkGerCon: TCheckBox;
    edtCodigoCaixa: TEditFocus;
    edtDescricaoCaixa: TEditFocus;
    lblCaixa: TLabel;
    pnlEmpresaContraPartida: TPanel;
    lblEmpresa: TLabel;
    edtCodigoEmpresa: TEditFocus;
    edtDescricaoEmpresa: TEditFocus;
    fraPlanoDeContasCon: TfraPlanoDeContasMskEdit;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    btnImprimir: TBitBtnLocked;
    frxComprovanteMov: TfrxReport;
    frxDBGeral: TfrxDBDataset;
    frxDBContra: TfrxDBDataset;
    btnAlterarPortador: TBitBtnLocked;
    btnRegrasPortador: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    function dbeCodPorChamaCadastro(Key: Word): String;
    procedure btnGravarClick(Sender: TObject);
    procedure edtPortadorCaixaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPortadorCaixaExit(Sender: TObject);
    procedure edtPortadorCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAbrirPastaAnexosClick(Sender: TObject);
    procedure btnHistMovBanClick(Sender: TObject);
    procedure btnHistMovBanMouseLeave(Sender: TObject);
    procedure btnHistMovBanMouseEnter(Sender: TObject);
    function fraCentroCustodbeCodEveChamaCadastro(Key: Word): string;
    procedure edtCodigoCaixaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasConMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasConMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasConMskCodCtaEnter(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    function fraPlanoDeContasdbeCodCtaChamaCadastro(Key: Word): string;
    procedure btnImprimirClick(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
    procedure btnAlterarPortadorClick(Sender: TObject);
    procedure btnRegrasPortadorClick(Sender: TObject);
  private
    { Private declarations }
    strMsgErr: String;
    dtaDtaLan: TDateTime;
    strSeqPar: String;
    strDtaAnt,
    strPorAnt,
    strPlaAnt,
    strComAnt: String; //guarda os ultimos dados gravados de Data, Competencia, portador e Plano de Contas
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;
    qryConEmp: TUniQuery;
    FstrCodCta: String;
    FstrCodPor: String;
    FstrSeqLan: String;
    FstrCodEmp: String;
    FcdsLogMod: TUniClientDataSet;

    blnIniciaCadastro: Boolean;
    fltValLanLoc: Double;
    strHist01Loc,
    strCodPorLoc: String;
    dteDataLanLoc: TDate;
    strCreDebLoc: String;
    blnConcilLoc: Boolean;
    arrSeqLanLoc: TStringArray;
    strDtaLanAnterior: String;
    blnLiberouData: Boolean;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    objLiberacao  : TLiberacao;
    objFechamento: TFechamentoFinanceiro;
    AValorInicial: Double;
    ADataLancamentoInicial: TDateTime;

    objResumoDeCaixa: TResumoDeCaixa;
    ATamanhoContraPartida: Integer;

    strCodOpe: String;

    FPermiteLancarPosterior: Boolean;

    FDiasToleranciaPosterior: Integer;

    procedure pAlterarDataLanctoCadRec(AAutoIncremList: String;
      ADataAlterada: TDateTime);

    procedure pAlterarDataLanctoAdiantamento(AAutoIncremList: String;
      ADataAlterada: TDateTime);

    procedure pAlterarDataLanctoDepCheques(AAutoIncremList: String;
      ADataAlterada: TDateTime);

    procedure pAlterarDataLanctoCartoes(AAutoIncremList: String;
      ADataAlterada: TDateTime);

    procedure pAlterarDataLanctoTF_OP_CadRec(AAutoIncremList: String;
      ADataAlterada: TDateTime);

    Const ATamanhoInicial      : Integer = 317;

    procedure pLimpaEdits;
    procedure pAtribuiTabelas;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pHabilitaDesabilitaBotoes;
    function TransferenciaDeCaixaEmAberto: Boolean;
    function fRetDtaIniPortador(strCodPor: String): TDateTime;
    function fValidaCentroCusto: Boolean;
    function fVerificaSaldoPositivo(Var curSalPor, curSalFut: Currency; curValLan: Currency): Boolean;
    function fPermiteAlterarValorTipo: Boolean;

    procedure pCarregaCompetencia;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pSetCodCta(const Value: String);
    procedure pSetCodPor(const Value: String);
    procedure pSetSeqLan(const Value: String);
    function fGetSql: String;
    procedure pSetCodEmp(const Value: String);
    function fAtualizaContraPartida(strSeqCtp, strSeqLan, strCodEmp, strCreDeb: String; fltValor: Double; dteDtalan, ADtaLanSemAlterar: TDateTime; intGerCon: integer): Boolean;
    procedure pCriaClientLog;
    procedure CarregaContraPartida;
    procedure CarregaEmpresa;
    function VerificaValorAlteradoFecFin: Boolean;

    procedure pCarregaCaixa;

    procedure CarregaEmpresaContraPartida;
    procedure ExibeEmpresaContraPartida;
    procedure ExibeCamposCaixa(AVisivel: Boolean = True);
    procedure pImprimeComprovante;

    function fLoadReport: Boolean;

    procedure AtivarBotaoDeAlterarPortador;
    function AbreTelaNovoPortador(APortadorAtual: String): String;

    function ValidaDatadeLancamento(AInserindo: Boolean): Boolean;

    function fBloquearExclusaoMovBanComOrigem(AAutoinc: String; out AMensagem: String): Boolean;
    function fLancamentoPossuiOrigem(AAutoinc: String): Boolean;
  protected
    function fProximoCodigo: String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    procedure pInicializaIndices; override;
    procedure pCarregaPortador(Sender: TWinControl);
    procedure pCarregaCentroCusto(Sender: TWinControl);
    procedure pCarregaEventos;

    procedure pGetMovBan;
    function  fBuscaOrigemLancamento(strSeqLan : String) : Boolean;
    procedure pShowHint;
    function fGerarMovimentoBancario: Integer;
    function fLiberacaoParaExclusao: Boolean;

    function fExecutaAntesDoDelete : Boolean; override;
  public
    { Public declarations }
    blnCarregaMovimento: Boolean;
    strAutoIncremLoc: String;
    {***************************************************}
    {* VARIAVEL QUE IDENTIFICARA DE QUAL OPCAO DO MENU *}
    {* O FORM FOI CHAMADO:                             *}
    {* CB - MOVIMENTAÇÃO DE CONTA BANCO                *}
    {* TE - TRANFERENCIA DE VALORES                    *}
    {************************************************LU*}
    strTipMov: String;
    class procedure pMostraIniciandoCadastro(fltValLan: Double;
  strHist01: String; dteDataLan: TDate; strPorCod: String; strTipLan: String;
  var arrSeqLan: TStringArray; blnConciliado: Boolean = False; strTipMovi: String = 'CB');

    property strSeqLan : String read FstrSeqLan write pSetSeqLan;
    property strCodPor : String read FstrCodPor write pSetCodPor;
    property strCodCta : String read FstrCodCta write pSetCodCta;
    property strCodEmp : String read FstrCodEmp write pSetCodEmp;
    property cdsLogMod : TUniClientDataSet read FcdsLogMod write FcdsLogMod; // Log das Modificações;
  end;

var
  frmCadMovBancario: TfrmCadMovBancario;

implementation

uses SysUtils, Variants, untConstantes, untFuncoes, untfuncoesSimples,
  untPai, untPesqAux, untFuncIns, untCadCta, untCadRcxx, untConsultas,
  untFuncFat, untInfCodOpeLcCaixa, untLogCba,
  untGravaArquivoPasta,untRelCbaLogAcompMovBanNovo, untGravando,
  untCadMovBancarioPortador, untTCadMovBancarioPortador, untCadRec;

{$R *.dfm}

{ TfrmCadMovBancario }

function TfrmCadMovBancario.fPermiteAlterarValorTipo: Boolean;
begin
  Result := fEmptyStr(qryTabela.FieldByName('CTB_ORIGEM').AsString);
end;

function TfrmCadMovBancario.fProximoCodigo: String;
begin
  //*****************************************************//
  // START NA TRANSACAO, POIS O FOR UPDATE NAO FUNCIONA  //
  // SE NAO FORCAR O START DA TRANSACAO                  //
  //**************************************************ED*//
//  fStartTransaction;

  Result := fSeqContaBanco;
end;

function TfrmCadMovBancario.fraCentroCustodbeCodEveChamaCadastro(
  Key: Word): string;
begin
  inherited;
  fraCentroCusto.dbeCodEveChamaCadastro(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadMovBancario.fraPlanoDeContasConMskCodCtaEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer novo cadastro';

  fraPlanoDeContasCon.MskCodCtaEnter(Sender);
end;

procedure TfrmCadMovBancario.fraPlanoDeContasConMskCodCtaExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';

  If Trim(fraPlanoDeContasCon.MskCodCta.Text) = '' Then
    fraPlanoDeContasCon.edtDesCta.Clear;

  fraPlanoDeContasCon.MskCodCtaExit(Sender);
end;

procedure TfrmCadMovBancario.fraPlanoDeContasConMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;

begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasCon.MskCodCta, fraPlanoDeContasCon.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If fValidaCentroCusto Then
      Self.SelectNext(ActiveControl, True, True);
    pCarregaCentroCusto(fraPlanoDeContasCon.MskCodCta);
  End;

end;

function TfrmCadMovBancario.fraPlanoDeContasdbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadMovBancario.fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(fraPlanoDeContas.dbeCodCta.text)) and (fEmptyStr(dbeSeqLan.text)) Then
  Begin
     If (fCfgSis('UTICON', varBoolean)) Then
     Begin
        fraPlanoDeContasCon.mskCodCta.Text := fraPlanoDeContas.dbeCodCta.text;
        pCarregaCentroCusto(fraPlanoDeContasCon.mskCodCta);
     End;
  End;

  If fCfgSis('REPPLC', varBoolean) Then
  Begin
    If (strTipMov = 'TE') And (qryTabela.State In [dsInsert]) Then
    Begin
      fraPlanoDeContasCon.mskCodCta.Text := fraPlanoDeContas.dbeCodCta.text;
      pCarregaCentroCusto(fraPlanoDeContasCon.mskCodCta);
    End;
  End;

  fraPlanoDeContas.dbeCodCtaExit(Sender);
end;

procedure TfrmCadMovBancario.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
  strMask        : String;
  strCodEmp      : String;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  strMask := '';
  strCodEmp := dbeCodEmp.Field.Text;

  If fEntraCons(Key) Then
  Begin
    strMask := dtsMovBan.DataSet.FieldByName('CTB_CODCTA').EditMask;
    dtsMovBan.DataSet.FieldByName('CTB_CODCTA').EditMask := '';
  End;

  If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If fValidaCentroCusto Then
      Self.SelectNext(ActiveControl, True, True);
    pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);
  End;

  If Not fEmptyStr(strMask) Then
    dtsMovBan.DataSet.FieldByName('CTB_CODCTA').EditMask := strMask;

  dbeCodEmp.Field.Text := strCodEmp;

end;

procedure TfrmCadMovBancario.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadMovBancario.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor := fCriaQuery(Self);
  qryConEmp := fCriaQuery(Self);
  pCriaClientLog;

  strNomeCampo  := 'CTB_SEQLAN';

  strNomeTabela := 'MOVBAN';
  qryTabela     := fCriarQuery('SELECT * FROM MOVBAN WHERE FALSE', Self);

  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.AfterScroll := pAfterScroll;
  dtsMovBan.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeSeqLan;
  blnIniciaCadastro := False;
  blnCarregaMovimento := False;
  SetLength(arrSeqLanLoc, 0);

  FPermiteLancarPosterior := fCfgSis('DTACBH', varBoolean);

  FDiasToleranciaPosterior := fCfgSis('CTBTOL', varInteger);

  objLiberacao := TLiberacao.create;
  blnLiberouData := False;

  ATamanhoContraPartida := 436;
  objResumoDeCaixa := TResumoDeCaixa.Create;

  If (objResumoDeCaixa.strTipoFechamento <> 'C') Then
    ExibeCamposCaixa(False);

  ExibeEmpresaContraPartida;
  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;
end;

procedure TfrmCadMovBancario.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(FcdsLogMod);
  FreeAndNil(FValidaCorrespondenteContabil);
  inherited;
end;

function TfrmCadMovBancario.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dtaDtaIniPor,
    dtaDtaIniPorCP,
    dtaDtaRcx,
    dtaDtaAnt: TDateTime;
    blnCaixaAbertoHoje: Boolean;
begin
  Result := True;
  blnCaixaAbertoHoje := False;
  If (edtPortadorCaixa.Text = fCfgSis('PORRES')) And (strTipMov = 'TE') Then
    blnCaixaAbertoHoje := objResumoDeCaixa.fNecessitaFecharCaixa(False, dtaDtaRcx, edtCodigoCaixa.Text, False);

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O SEQUENCIAL                   *}
    {**************************************MV*}
    If (Sender = dbeSeqLan) Then
    Begin
      If (fEmptyStr(dbeSeqLan.Text)) And (dbeSeqLan.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Sequencial de Lançamento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          pLimparCampos;
          pCarregaPortador(Sender);
          pCarregaCentroCusto(Sender);
        End;
      End;
    End

    {*****************************************}
    {* VALIDA COMPETENCIA                    *}
    {**************************************BB*}
    Else if (Sender = mskCompet) then
    Begin
      If not fValidaDataStr('01/'+ mskCompet.Text) Then
      Begin
        pMensagemOk('Data informada na Competência não é válida!');
        Result := False;
      end

      Else If fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) Then
      Begin
        pMensagemOk('A Competência deve ser preenchida!');
        Result := False;
      End

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO PORTADOR           *}
    {**************************************MV*}
    Else If (Sender = dbeCodPor) Then
    Begin

      If fEmptyStr(dbeCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Portador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        if strCodPorLoc <> '' then
          qryTabela.FieldByName('CTB_CODPOR').Value := strCodPorLoc;

        pCarregaPortador(Sender);
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(qryConPor.FieldByName('POR_CODPOR').AsString, dbeCodEmp.Field.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End

        Else If (qryConPor.FieldByName('POR_TRANSF').AsString = 'N') And (strTipMov = 'TE') Then
        Begin
          fMensagem('ATENÇÃO', 'Não é permitida transferência para esse portador!', ['&O K']);
          Result := False;
        End

        Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(dbeCodPor.Text,dbeCodEmp.Text) Then
        Begin
          Result := False;
        End

        Else If (qryConPor.FieldByName('POR_MOVBAN').AsString = 'N') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar Movimento Bancário!',['&O K']);
          Result := False;
        End

        Else If qryConPor.FieldByName('POR_CODPOR').AsString = fCfgSis('PORRES') Then
        Begin
          fMensagem('ATENÇÃO', 'Este portador é o portador do resumo de caixa. Somente poderá ser utilizado na área ' +
                               'de contra-partida para transferência de valores para o caixa!', ['&O K']);
          Result := False;
        End

        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(dbeCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    {********************************************}
    {* VALIDA O CÓDIGO DO PORTADOR CONTRAPARTIDA*}
    {*****************************************RL*}
    Else If (Sender = edtPortadorCaixa) And (edtPortadorCaixa.Enabled) Then
    Begin
      If fEmptyStr(edtPortadorCaixa.Text) And (strTipMov = 'TE') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Portador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If (qryTabela.State = dsInsert) Then
          fraPlanoDeContasCon.MskCodCta.Enabled := True;

        If (Not fEmptyStr(edtPortadorCaixa.Text)) Then
        Begin
          pCarregaPortador(Sender);

          lblPorRes.Visible := (edtPortadorCaixa.Text = fCfgSis('PORRES'));
          ExibeCamposCaixa((objResumoDeCaixa.strTipoFechamento = 'C') And lblPorRes.Visible);
          ExibeEmpresaContraPartida;

          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End

          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(edtPortadorCaixa.Text, dbeCodEmp.Field.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If (edtPortadorCaixa.Text = dbeCodPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O portador de contra partida deve ser diferente do portador principal.', ['&Ok']);
            Result := False;
          End

          Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(edtPortadorCaixa.Text,
                                                                                        IIF(fEmptyStr(edtCodigoEmpresa.Text),dbeCodEmp.Text,edtCodigoEmpresa.Text)) Then
          Begin
            Result := False;
          End

          Else If (edtPortadorCaixa.Text = fCfgSis('PORRES')) And (strTipMov = 'TE') Then
          Begin

            If dbeCreDeb.Text <> 'D' Then
            Begin
              If fMensagem('', 'O tipo de lançamento deve ser (D)ébito. Deseja alterá-lo?', ['&Sim', '&Não']) = 1 Then
              Begin
                dbeCreDeb.Field.AsString := 'D';
                fraPlanoDeContasCon.MskCodCta.Enabled := False;
                fraPlanoDeContasCon.MskCodCta.Clear;
              End
              Else
                Result := False;
            End
            Else
            Begin
              If (Not blnCaixaAbertoHoje) And (dtaDtaRcx <> StrToDate(dbeDtaLan.Text)) Then
              Begin
                If fMensagem('', 'O caixa do dia ' + DateToStr(dtaDtaRcx) + ' ainda não foi fechado.' + #13#10 +
                                 'Deseja realizar a transferência com a data do caixa aberto?', ['&Sim', '&Não'], 2) = 1 Then
                Begin
                  dtaDtaAnt := dbeDtaLan.Field.AsDateTime;
                  dbeDtaLan.Field.AsDateTime := dtaDtaRcx;
                  Result := fValidaCampos(dbeDtaLan);
                  If Not Result Then
                    dbeDtaLan.Field.AsDateTime := dtaDtaAnt;
                End
                Else
                  Result := False;
              End;

              fraPlanoDeContasCon.MskCodCta.Enabled := False;
              fraPlanoDeContasCon.MskCodCta.Clear;
            End;
          End

          Else If (qryConPor.FieldByName('POR_TRANSF').AsString = 'N') And (strTipMov = 'TE') Then
          Begin
            fMensagem('ATENÇÃO', 'Não é permitida transferência para esse portador!', ['&O K']);
            Result := False;
          End

          Else If (qryConPor.FieldByName('POR_MOVBAN').AsString = 'N') Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar Movimento Bancário!',['&O K']);
            Result := False;
          End

          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtPortadorCaixa.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End;

    End

    {******************}
    {* VALIDA O CAIXA *}
    {***************AJ*}
    Else If (Sender = edtCodigoCaixa) And (edtCodigoCaixa.Enabled) And
            (edtCodigoCaixa.Visible) Then
    Begin
      If fEmptyStr(edtCodigoCaixa.Text) And (strTipMov = 'TE') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Caixa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If (qryTabela.State = dsInsert) Then
          edtCodigoCaixa.Enabled := True;

        If (Not fEmptyStr(edtCodigoCaixa.Text)) Then
        Begin
          pCarregaCaixa;

          If fEmptyStr(edtDescricaoCaixa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Caixa não está cadastrado ou não faz parte da empresa atual!', ['&O k']);
            Result := False;
          End

        End;
      End;

    End

    {*****************************************}
    {* VALIDA A DATA DE LANÇAMENTO           *}
    {**************************************MV*}
    Else If (Sender = dbeDtaLan) Then
    Begin
      if (dteDataLanLoc  <> 0) and (dteDataLanLoc  <> StrToDate(dbeDtaLan.Text))  and (not blnConcilLoc) then
          qryTabela.FieldByName('CTB_DTALAN').AsDateTime := dteDataLanLoc;

      dtaDtaIniPorCP := 0;
      Try
        dtaDtaIniPor := fRetDtaIniPortador(dbeCodPor.Text);
        If not Trim(edtPortadorCaixa.Text).Equals(EmptyStr) then
          dtaDtaIniPorCP := fRetDtaIniPortador(edtPortadorCaixa.Text);
        If fEmptyStr(Trim(fTiraCaracEspeciais(dbeDtaLan.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data do Lançamento deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (StrToDate(dbeDtaLan.Text) < dtaDtaIniPor) or
                ((not Trim(edtPortadorCaixa.Text).Equals(EmptyStr)) and
                 (StrToDate(dbeDtaLan.Text) < dtaDtaIniPorCP))      Then
        Begin
          fMensagem('ATENÇÃO!',
                    'A Data do Lançamento deve ser maior ou igual a ' +
                    IIF(dtaDtaIniPor > dtaDtaIniPorCp, DateToStr(dtaDtaIniPor), DateToStr(dtaDtaIniPorCp)) + ' !',
                    ['&O k']);
          Result := False;
        End

        {******************************************************************************}
        {* SE ALTERAR A DATA DE LANÇAMENTO, VERIFICA DIREITO DE ACESSO E **************}
        {* PEDE SENHA PARA LIBERAÇÃO. CASO CONTRÁRIO EXIBE A MENSAGEM 'SEM PERMISSÃO' *}
        {******************************************************************************}
        Else if (dbeDtaLan.Text <> strDtaLanAnterior) and (not blnLiberouData) and (qryTabela.State = dsEdit)  then
        begin
          if (qryTabela.FieldByName('CTB_ORIGEM').AsString = 'CTP') or
             (qryTabela.FieldByName('CTB_ORIGEM').AsString = 'CTR') or
             (fEmptyStr(qryTabela.FieldByName('CTB_ORIGEM').AsString)) then
          begin
            If fVerificaAcessoSistema('ALTDTAMOVBAN', strLoginUsuarioLogado) Then
            Begin
              objLiberacao.Clear;
              objLiberacao.strDirAce := 'ALTDTAMOVBAN';
              objLiberacao.objMsgLibera.pAddTexto('***  ALTERAR DATA DA MOVIMENTAÇÃO BANCÁRIA  ***', alCentro, teAmbos, '', 118);
              objLiberacao.objMsgLibera.pAddSeparador(118);
              objLiberacao.objMsgLibera.pAddTexto('Atenção! É de extrema responsabilidade da empresa permitir a alteração da data da movimentação bancária.');
              objLiberacao.objMsgLibera.pAddSeparador(118);
              objLiberacao.objMsgLibera.pAddTexto('***  Alterar data da movimentação bancária  ***', alCentro, teAmbos, '', 118);
              objLiberacao.strMsgSen := 'Alterar data da movimentação bancária.';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.strCodDig := strLoginUsuarioLogado;
              objLiberacao.pInformaNumDocEspDocCodEmp(
                                qryTabela.FieldByName('CTB_NUMDUP').AsString,
                                EmptyStr,
                                qryTabela.FieldByName('CTB_CODEMP').AsString);

              If not objLiberacao.fLibera Then
              begin
                blnLiberouData := False;
                Result := False;
              end
              else
              begin
                blnLiberouData := True;

                //SE LIBERA ALTERAÇÃO DE DATA, VERIFICA SE É LANÇAMENTO RETROATIVO
                If (DateToStr(dtaDtaLan) <> dbeDtaLan.Text) Then
                Begin
                  If (StrToDate(dbeDtaLan.Text) < VS_Date) And (fCfgSis('LANRET') <> '1') Then
                  Begin
                    If fCfgSis('LANRET') = '2' Then
                    Begin
                      If ffrmSenha(strSenha, 'Lançamento retroativo') Then
                      Begin
                        If (strSenha <> fCfgSis('SENRET')) Then
                        Begin
                          fMensagem('ATENÇÃO!', 'Senha inválida !', ['&O k']);
                          Result := False;
                        End;
                      End
                      Else
                      Begin
                        Result := False;
                      End;
                     End
                    Else
                    Begin
                      fMensagem('ATENÇÃO!', 'Sem permissão para lançamento retroativo !', ['&O k']);
                      Result := False;
                    End;
                  End;

                  If Result Then
                    dtaDtaLan := StrToDate(dbeDtaLan.Text);
                End;
              end;
            end
            else
            begin
              fMensagem('ATENÇÃO!', 'Sem permissão para alterar data de lançamento !', ['&O k']);
              blnLiberouData := False;
              Result := False;
            end;
          end;
        end

        Else If (edtPortadorCaixa.Text = fCfgSis('PORRES')) And (strTipMov = 'TE') And blnCaixaAbertoHoje Then
        Begin
          If (StrToDate(dbeDtaLan.Text) < VS_Date) Then
            fMensagem('', 'Não é possível fazer lançamentos no caixa com data retroativa pois já houve fechamento do caixa para esta data.', ['&Ok']);

          If (StrToDate(dbeDtaLan.Text) > VS_Date) Then
            fMensagem('', 'Não é possível fazer lançamentos no caixa com data futura.', ['&Ok']);

          If (StrToDate(dbeDtaLan.Text) <> VS_Date) Then
          Begin
            dbeDtaLan.Field.AsDateTime := VS_Date;
            Result := False;
          End;
        End

        Else If (DateToStr(dtaDtaLan) <> dbeDtaLan.Text) Then
        Begin
          If (StrToDate(dbeDtaLan.Text) < VS_Date) And (fCfgSis('LANRET') <> '1') Then
          Begin

            If fCfgSis('LANRET') = '2' Then
            Begin

              If ffrmSenha(strSenha, 'Lançamento retroativo') Then
              Begin
                If (strSenha <> fCfgSis('SENRET')) Then
                Begin
                  fMensagem('ATENÇÃO!', 'Senha inválida !', ['&O k']);
                  Result := False;
                End;
              End
              Else
              Begin
                Result := False;
              End;
             End
            Else
            Begin
              fMensagem('ATENÇÃO!', 'Sem permissão para lançamento retroativo !', ['&O k']);
              Result := False;
            End;
          End;

          If Result Then
            dtaDtaLan := StrToDate(dbeDtaLan.Text);
        End;

        //FECHAMENTO FINANCEIRO
        //VERIFICA SE É INSERÇÃO OU UMA ALTERAÇÃO DE DATA DE LANÇAMENTO
        if (qryTabela.State = dsInsert) then
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Field.Text, StrToDate(dbeDtaLan.Text)) then
              Result := False;

        if ((qryTabela.State = dsEdit) And (StrToDate(strDtaLanAnterior) <> StrToDate(dbeDtaLan.Text))) then
        begin
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Field.Text, StrToDate(strDtaLanAnterior)) then
            Result := False
          else
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Field.Text, StrToDate(dbeDtaLan.Text)) then
            Result := False;
        end;
      Except
        On E: EConvertError Do
        Begin
          fMensagem('ATENÇÃO!', dbeDtaLan.Text + ' não é uma data válida!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CAMPO CRÉDITO / DEBITO       *}
    {**************************************MV*}
    Else If (Sender = dbeCreDeb) Then
    Begin
      if strCreDebLoc <> '' then
        qryTabela.FieldByName('CTB_CREDEB').Value := strCreDebLoc;

      If fEmptyStr(dbeCreDeb.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo de Lançamento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeCreDeb.Text, 'C_D_') <= 0 Then
        Begin
          fMensagem('','O Tipo Lançamento deve ser preenchido com C ou D!', ['&O K']);
          Result := False;
        End;
      end;
    end

    {*****************************************}
    {* VALIDA O VALOR DO LANÇAMENTO          *}
    {**************************************MV*}
    Else If (Sender = dbeValLan) Then
    Begin
      If fEmptyStr(dbeValLan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Lançamento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        //FECHAMENTO FINANCEIRO
        If Not VerificaValorAlteradoFecFin Then
        Begin
          Result := False;
        end
        Else
        If fStrToFloat(dbeValLan.Text) <= 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Lançamento deve ser maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeValLan.Text) > MAX_VALMON Then
          Begin
            fMensagem('ATENÇÃO!', 'O Valor do Lançamento não pode ser maior que 9.999.999.999,99!', ['&O k']);
            Result := False;
          End
        End;
      End;
      if (fltValLanLoc <> 0) and (fltValLanLoc <> fStrToFloat(dbeValLan.Text)) then
        qryTabela.FieldByName('CTB_VALLAN').AsFloat := fltValLanLoc;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.dbeCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.dbeCodEve.Text) Then
      Begin
        pCarregaEventos;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        qryTabela.FieldByName('CTB_CODEVE').AsVariant := Null;
        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO              *}
    {**************************************MV*}
    Else If (Sender = fraPlanoDeContas.dbeCodCta) Then
    Begin
      If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Plano de Contas deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Not fValidaCentroCusto) Then
      Begin
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(Sender);
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.dbeCodCta.Text,dbeCodEmp.Text) Then
        Begin
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CENTRO DE CUSTO CONTRAPARTIDA*}
    {**************************************RL*}
    Else If (Sender = fraPlanoDeContasCon.MskCodCta) And (fraPlanoDeContasCon.MskCodCta.Enabled) Then
    Begin
      If (Sender = fraPlanoDeContasCon.MskCodCta) And (fEmptyStr(fraPlanoDeContasCon.MskCodCta.Text))  And (Not fEmptyStr(edtPortadorCaixa.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Plano de Conta deve ser preenchido!', ['&O k']);
        Result := False;
      End  
      Else If (Not fEmptyStr(fraPlanoDeContasCon.MskCodCta.Text)) Then
      Begin
        pCarregaCentroCusto(Sender);
        If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContasCon.MskCodCta.Text,
                                                                                         IIF(fEmptyStr(edtCodigoEmpresa.Text),dbeCodEmp.Text,edtCodigoEmpresa.Text)) Then
        Begin
          Result := False;
        End;
      End;
    End

    {*************************************}
    {* VALIDA A EMPRESA DA CONTRAPARTIDA *}
    {**********************************AJ*}
    Else If (Sender = edtCodigoEmpresa) And (edtCodigoEmpresa.Enabled) And
            (pnlEmpresaContraPartida.Visible) Then
    Begin
      If fEmptyStr(edtCodigoEmpresa.Text) And (strTipMov = 'TE') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da empresa ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin

        If (qryTabela.State = dsInsert) Then
          edtCodigoEmpresa.Enabled := True;

        If (Not fEmptyStr(edtCodigoEmpresa.Text)) Then
        Begin
          CarregaEmpresaContraPartida;

          If fEmptyStr(edtDescricaoEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End
          Else
          If Pos(edtCodigoEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
            Result := False;
          End;

        End;
      End;

    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadMovBancario.pImprimeComprovante;
  var
    strSQL: string;
    qryRelatorio: TUniQuery;
    qryContraRel: TUniQuery;
begin
  Try

    qryRelatorio := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '  M.CTB_CODCTA, ';
    strSQL := strSQL + '  M.CTB_CODPOR, ';
    strSQL := strSQL + '  M.CTB_CODOPE, ';
    strSQL := strSQL + '  M.CTB_DTALAN, ';
    strSQL := strSQL + '  M.CTB_NUMDOC, ';
    strSQL := strSQL + '  M.CTB_CREDEB, ';
    strSQL := strSQL + '  M.CTB_VALLAN, ';
    strSQL := strSQL + '  M.CTB_HIST01, ';
    strSQL := strSQL + '  M.CTB_HIST02, ';
    strSQL := strSQL + '  M.CTB_CODEMP, ';
    strSQL := strSQL + '  M.CTB_CODEVE, ';
    strSQL := strSQL + '  M.CTB_COMPET, ';
    strSQL := strSQL + '  M.CTB_GERCON, ';
    strSQL := strSQL + '  M.CTB_SEQCTP, ';
    strSQL := strSQL + '  M.CTB_EMPTRA, ';
    strSQL := strSQL + '  E.EMP_NOMEMP, ';
    strSQL := strSQL + '  P.POR_NOMPOR, ';
    strSQL := strSQL + '  C.CTA_DESCTA, ';
    strSQL := strSQL + '  V.EVE_DESEVE, ';
    strSQL := strSQL + '  O.OPE_NOMOPE  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVBAN M ';
    strSQL := strSQL + '  LEFT JOIN CADEMP E ';
    strSQL := strSQL + '    ON CTB_CODEMP = EMP_CODEMP ';
    strSQL := strSQL + '  LEFT JOIN CADPOR P ';
    strSQL := strSQL + '    ON CTB_CODPOR = POR_CODPOR ';
    strSQL := strSQL + '  LEFT JOIN CADCTA C ';
    strSQL := strSQL + '    ON CTB_CODCTA = CTA_CODCTA ';
    strSQL := strSQL + '  LEFT JOIN CADEVE V ';
    strSQL := strSQL + '    ON CTB_CODEVE = EVE_CODEVE ';
    strSQL := strSQL + '  LEFT JOIN CADOPE O ';
    strSQL := strSQL + '    ON CTB_CODOPE = OPE_CODOPE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTB_SEQLAN = :SEQLAN ';
    strSQL := strSQL + '   AND CTB_CODEMP = :CODEMP ';

    Try
      qryRelatorio.Close;
      qryRelatorio.SQL.Clear;
      qryRelatorio.SQL.Add(strSQL);
      qryRelatorio.ParamByName('SEQLAN').AsString := qryTabela.FieldByName('CTB_SEQLAN').AsString;
      qryRelatorio.ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTB_CODEMP').AsString;
      qryRelatorio.Open;

      frxDBGeral.DataSet := qryRelatorio;

      qryContraRel := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' SELECT CTB_CODCTA, ';
      strSQL := strSQL + '        CTB_CODPOR, ';
      strSQL := strSQL + '        CTB_GERCON, ';
      strSQL := strSQL + '        CTB_SEQTRF, ';
      strSQL := strSQL + '        CTA_DESCTA, ';
      strSQL := strSQL + '        CTB_GERCON, ';
      strSQL := strSQL + '        CTB_CODEMP, ';
      strSQL := strSQL + '        EMP_NOMEMP, ';
      strSQL := strSQL + '        CTB_CODOPE, ';
      strSQL := strSQL + '        POR_NOMPOR, ';
      strSQL := strSQL + '        OPE_NOMOPE  ';
      strSQL := strSQL + ' FROM MOVBAN ';
      strSQL := strSQL + ' LEFT JOIN CADEMP ';
      strSQL := strSQL + '   ON CTB_CODEMP = EMP_CODEMP ';
      strSQL := strSQL + ' LEFT JOIN CADPOR ';
      strSQL := strSQL + '   ON CTB_CODPOR = POR_CODPOR ';
      strSQL := strSQL + ' LEFT JOIN CADCTA ';
      strSQL := strSQL + '   ON CTB_CODCTA = CTA_CODCTA ';
      strSQL := strSQL + ' LEFT JOIN CADOPE ';
      strSQL := strSQL + '   ON CTB_CODOPE = OPE_CODOPE ';
      strSQL := strSQL + ' WHERE CTB_SEQCTP = :SEQCTP AND ';
      strSQL := strSQL + '       CTB_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '       CTB_CREDEB = :CREDEB AND ';
      strSQL := strSQL + '       CTB_DTALAN = :DTALAN     ';

      qryContraRel.Close;
      qryContraRel.SQL.Clear;
      qryContraRel.SQL.Add(strSQL);
      qryContraRel.ParamByName('SEQCTP').AsString := qryTabela.FieldByName('CTB_SEQCTP').AsString;
      qryContraRel.ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTB_CODEMP').AsString;

      If Not qryTabela.FieldByName('CTB_EMPTRA').AsString.IsEmpty Then
        qryContraRel.ParamByName('CODEMP').AsString   := qryTabela.FieldByName('CTB_EMPTRA').AsString;

      qryContraRel.ParamByName('CREDEB').AsString := IIF(qryTabela.FieldByName('CTB_CREDEB').AsString = 'C', 'D', 'C');
      qryContraRel.ParamByName('DTALAN').AsDateTime := qryTabela.FieldByName('CTB_DTALAN').AsDateTime;
      qryContraRel.Open;

      frxDBContra.DataSet := qryContraRel;

      fLoadReport;

      If Not fEmptyStr(edtCodigoEmpresa.Text) Then
      Begin
        If Assigned(frxComprovanteMov.FindObject('memNomEmpCon')) And Assigned(frxComprovanteMov.FindObject('memValEmpCon')) Then
        Begin
          TfrxMemoView(frxComprovanteMov.FindObject('memNomEmpCon')).Visible := True;
          TfrxMemoView(frxComprovanteMov.FindObject('memValEmpCon')).Visible := True;
        End;
      End
      Else
      Begin
        If Assigned(frxComprovanteMov.FindObject('memNomEmpCon')) And Assigned(frxComprovanteMov.FindObject('memValEmpCon')) Then
        Begin
          TfrxMemoView(frxComprovanteMov.FindObject('memNomEmpCon')).Visible := False;
          TfrxMemoView(frxComprovanteMov.FindObject('memValEmpCon')).Visible := False;
        End;
      End;

      If strTipMov = 'TE' Then
      Begin
        frxComprovanteMov.Script.Variables['NOMREL'] := 'Transferência de Conta Banco';

        If edtPortadorCaixa.Text = fCfgSis('PORRES') Then
          frxComprovanteMov.Script.Variables['NOMOPE'] := strCodOpe + ' - ' + fRetNomeOperador(strCodOpe)
        Else
          frxComprovanteMov.Script.Variables['NOMOPE'] := '';
      End
      Else
        frxComprovanteMov.Script.Variables['NOMREL'] := 'Comprovante de Movimentação';

      If frxComprovanteMov.PrepareReport Then
      Begin
        If fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
          pPreviewReport(Self.Name, Self.Caption + ' (Comprovante)', frxComprovanteMov)
        Else
          pPrintReport(Self.Name, Self.Caption + ' (Comprovante)', EmptyStr, frxComprovanteMov);
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End

  Finally
    FreeAndNil(qryRelatorio);
    FreeAndNil(qryContraRel);
  End;
end;

procedure TfrmCadMovBancario.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CTB_SEQLAN');
  stlCamInd.Add('CTB_DTALAN');
  stlCamInd.Add('CTB_NUMDOC');
  stlCamInd.Add('POR_NOMPOR');
  stlCamInd.Add('CTB_HIST01');
  stlCamInd.Add('CTB_HIST02');

  stlDesInd.Add('Sequência');
  stlDesInd.Add('Data Lançamento');
  stlDesInd.Add('Número Documento');
  stlDesInd.Add('Portador');
  stlDesInd.Add('Histórico 1');
  stlDesInd.Add('Histórico 2');

  pAtribuiTabelas;

end;

procedure TfrmCadMovBancario.btnImprimirClick(Sender: TObject);
begin
  inherited;
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit
  End
  Else If (qryTabela.State = dsEdit) Then
  Begin
    fMensagem('AVISO', 'É necessário não estar em edição para realizar essa operação!', ['&Ok']);
    Exit
  End
  Else
    TfrmGravando.fExecutarModal(pImprimeComprovante,'Gerando relatório... Aguarde...','');
end;

procedure TfrmCadMovBancario.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FValidaCorrespondenteContabil.LimparListas;
  pHabilitaCodigo(dbeSeqLan, dbeCodPor, False);
  pLimpaEdits;

  if strDtaAnt = '' Then
    dbeDtaLan.Field.AsDateTime := VS_Date
  else
    dbeDtaLan.Field.AsString := strDtaAnt;

  mskCompet.Text := strComAnt;
  dbeCodPor.Field.AsString := strPorAnt;

  If strPorAnt <> '' Then
    pCarregaPortador(dbeCodPor);

  fraPlanoDeContas.dbeCodCta.Field.AsString := strPlaAnt;

  If strPlaAnt <> '' Then
    pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);

  dbeCodEmp.Field.Text := VS_strCodEmp;
  qryTabela.FieldByName('CTB_CODEMP').AsString := VS_strCodEmp;
  CarregaEmpresa;

  If strTipMov = 'TE' Then
  Begin
    edtCodigoEmpresa.Text := VS_strCodEmp;
    CarregaEmpresaContraPartida;
  End;

  lblPorRes.Visible := False;
  ExibeCamposCaixa(False);
  ExibeEmpresaContraPartida;

  Self.Height              := ATamanhoContraPartida;
  gpbContraPartida.Enabled := True;
  fraPlanoDeContasCon.MskCodCta.Enabled := False;
  dtaDtaLan                := 0;
  chkGerCon.Enabled := True;

  Self.SelectFirst;

  pHabilitaDesabilitaBotoes;
end;

function TfrmCadMovBancario.AbreTelaNovoPortador(
  APortadorAtual: String): String;
  Var
    LCadMovBancarioPortador: TfrmCadMovBancarioPortador;
begin
  pCriarFormularios(TfrmCadMovBancarioPortador, LCadMovBancarioPortador);

  Try
    LCadMovBancarioPortador.PortadorAtual := APortadorAtual;
    LCadMovBancarioPortador.CodigoEmpresa := dbeCodEmp.Text;

    LCadMovBancarioPortador.ShowModal;

    Result := LCadMovBancarioPortador.NovoPortador;
  Finally
    FreeAndNil(LCadMovBancarioPortador);
  End;
end;

procedure TfrmCadMovBancario.AtivarBotaoDeAlterarPortador;
begin
  btnAlterarPortador.Enabled := False;

  If qryTabela.IsEmpty Then
    Exit;

  If Not qryTabela.FieldByName('CTB_DTACON').AsString.IsEmpty Then
    Exit;

  If Not qryTabela.FieldByName('CTB_SEQTRF').AsString.IsEmpty Then
    Exit;

  objFechamento.FechamentoFinanceiroJaRealizado(qryTabela.FieldByName('CTB_CODEMP').AsString,
                                                qryTabela.FieldByName('CTB_DTALAN').AsDateTime);

  If untMovBan.MovimentacaoBancariaProvenienteDeBaixaDoPix(qryTabela.FieldByName('CTB_SEQLAN').AsString,
                                                           qryTabela.FieldByName('CTB_ORIGEM').AsString,
                                                           qryTabela.FieldByName('CTB_CODEMP').AsString) Then
    Exit;

  btnAlterarPortador.Enabled := True;
end;

procedure TfrmCadMovBancario.btnAbrirPastaAnexosClick(Sender: TObject);
var
  strCaminhoPastaAntiga: String;
begin
  inherited;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);

    strCaminhoPastaAntiga := ExtractFilePath(Application.ExeName)+ 'ANEXOS_MOVBAN\' + qryTabela.FieldByName('AUTOINCREM').AsString ;

    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'ANEXOS_MOVBAN\' +
                                                            fStrZero( qryTabela.FieldByName('CTB_SEQLAN').AsString, 12  ) + '-' +
                                                            fStrZero( qryTabela.FieldByName('CTB_CODEMP').AsString, 3  ) + '-' +
                                                            fStrZero( qryTabela.FieldByName('AUTOINCREM').AsString, 20 ) ;
    if DirectoryExists( strCaminhoPastaAntiga ) then
    begin
       TDirectory.Move( strCaminhoPastaAntiga, frmGravaArquivoPasta.strCaminhoPasta );
       Sleep(500);
    end;

    frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos Anexos )';
    frmGravaArquivoPasta.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravaArquivoPasta);

end;

procedure TfrmCadMovBancario.btnAlterarClick(Sender: TObject);
begin
  strDtaLanAnterior := (dbeDtaLan.Text);
  dtaDtaLan := dbeDtaLan.Field.AsDateTime;

  If Not qryTabela.FieldByName('CTB_DTACON').IsNull Then
  Begin
    {*****************************************************************}
    {* EXISTIA UMA TRAVA QUE SE CONCILIADO NÃO ERA POSSÍVEL ALTERAR. *}
    {* AGORA SÓ É POSSÍVEL ALTERAR O HISTÓRICO. **********************}
    {*REQ*118811***************************************************MO*}
    dbeHisto01.Enabled  := True;
    dbeHisto02.Enabled  := True;
    btnIncluir.Enabled  := False;
    btnGravar.Enabled   := True;
    btnAlterar.Enabled  := False;
    btnExcluir.Enabled  := False;
    btnCancela.Enabled  := True;
    btnPesquisa.Enabled := False;
    btnSair.Enabled     := False;
    pSetFocus(dbeHisto01);
    qryTabela.Edit;
    Exit;
  End;

  mskCompet.Enabled := True;
  blnLiberouData := False;
  inherited;

  If blnAlterou Then
  Begin
    dtaDtaLan := dbeDtaLan.Field.AsDateTime;

    dbeSeqLan.Enabled := False;
    dbeCodPor.Enabled := False;
    chkGerCon.Enabled := False;
    edtPortadorCaixa.Enabled := False;
    fraPlanoDeContasCon.MskCodCta.Enabled := False;
    edtCodigoCaixa.Enabled := False;
    dbeCodEmp.Enabled := False;
    edtNomEmp.Enabled := False;
    edtCodigoEmpresa.Enabled := False;

    If Not fPermiteAlterarValorTipo Then
    Begin
      dbeCreDeb.Enabled := False;
      dbeValLan.Enabled := False;
    End;

    If dbeDtaLan.Enabled Then
      pSetFocus(dbeDtaLan)
    Else
      pSetFocus(mskCompet);

    AtivarBotaoDeAlterarPortador;
  End;
  pHabilitaDesabilitaBotoes;
  ADataLancamentoInicial := qryTabela.FieldByName('CTB_DTALAN').AsDateTime;
  AValorInicial          := fStrToFloat(dbeValLan.Text);
end;

procedure TfrmCadMovBancario.btnAlterarPortadorClick(Sender: TObject);
  Var
    LNovoPortador: String;

    LTipoBaixa: TTipoRegistroMovBan;

    LCadMovBancarioPortador: TCadMovBancarioPortador;

    LGravando: TfrmGravando;
begin
  inherited;
  If untMovBan.ExisteRegistroVinculadoNaBanExr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
  Begin
    fMensagem('ATENÇÃO', 'Esse registro está relacionado na Conciliação de Extrato ELetrônico.' + #13 +
                         'Operação cancelada!', ['&Ok']);

    Exit;
  End;

  Try
    LCadMovBancarioPortador := TCadMovBancarioPortador.Create(qryTabela.FieldByName('CTB_SEQLAN').AsString);

    LTipoBaixa := LCadMovBancarioPortador.RetornaTipoDeBaixaDaMOVBAN;

    If LTipoBaixa = trmNenhum Then
    Begin
      fMensagem('ATENÇÃO', 'Esse registro não pode ser alterado o portador, pois não é um registro de Baixa/Depósito ou esse já foi estornado/devolvido/cancelado.' + #13 +
                           'Operação cancelada!', ['&Ok']);

      Exit;
    End;

    LNovoPortador := AbreTelaNovoPortador(qryTabela.FieldByName('CTB_CODPOR').AsString);
    If LNovoPortador.IsEmpty Then
      Exit;

    If fMensagem('ATENÇÃO', 'Deseja realmente alterar o portador da Movimentação Bancária e suas dependências?',
                 ['&Sim', '&Não'], 2) = 2 Then
      Exit;

    btnCancela.Click;

    LCadMovBancarioPortador.TipoRegistroMovBan := LTipoBaixa;
    LCadMovBancarioPortador.NovoPortador := LNovoPortador;

    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.lblGravando.Caption := 'Aguarde... Alterando portador.';
    LGravando.pgbStatus.Visible := False;
    LGravando.fExecutarAcao := LCadMovBancarioPortador.AlterarPortadorLancamentos;
    LGravando.ShowModal;

    If LGravando.blnConfirma Then
    Begin
      qryTabela.Close;
      qryTabela.Open;
      fMensagem('ATENÇÃO', 'Portador dos registros alterados com sucesso.', ['&Ok']);
    End;

    FreeAndNil(LGravando);
  Finally
    FreeAndNil(LCadMovBancarioPortador);

    pCarregaPortador(dbeCodPor);
  End;
end;

procedure TfrmCadMovBancario.pCarregaPortador(Sender: TWinControl);
begin
  pPesquisaCadPor(Nil, qryConPor, IIF(Sender.Name = 'dbeCodPor', dbeCodPor.Text, edtPortadorCaixa.Text));

  With qryConPor Do
  Begin

    If Sender.Name = 'dbeCodPor' Then
      edtNomPor.Text := FieldByName('POR_NOMPOR').AsString
    Else
    Begin
      edtNomPor2.Text := FieldByName('POR_NOMPOR').AsString;
      If (qryTabela.State in dsEditModes) and (strTipMov = 'TE') Then
        qryTabela.FieldByName('CTB_HIST02').AsString := FieldByName('POR_NOMPOR').AsString;
    End;

  End;

end;

procedure TfrmCadMovBancario.pCriaClientLog;
begin
  FcdsLogMod := TUniClientDataSet.Create(Self);

  With FcdsLogMod.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'LOG_SEQLAN';
    DataType := ftString;
    Size     := 13;
  End;

  With FcdsLogMod.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'LOG_STATUS';
    DataType := ftString;
    Size     := 30;
  End;

  FcdsLogMod.CreateDataSet;
  FcdsLogMod.IndexFieldNames := 'LOG_SEQLAN';
end;

procedure TfrmCadMovBancario.pCarregaCaixa;
begin
  edtDescricaoCaixa.Clear;
  If Not fEmptyStr(edtCodigoCaixa.Text) Then
    edtDescricaoCaixa.Text := fCampoTabela('CAX_DESCRI',
                                           'CADCAX',
                                           ['CAX_CODCAX', 'CAX_CODEMP'],
                                           [edtCodigoCaixa.Text, VS_strCodEmp]);
end;

procedure TfrmCadMovBancario.pCarregaCentroCusto(Sender: TWinControl);
begin
  pPesquisaCadCta(qryConCta, qryConCta, IIF(Sender.Name = 'dbeCodCta', fraPlanoDeContas.dbeCodCta.Text, fraPlanoDeContasCon.MskCodCta.Text));
  With qryConCta Do
  Begin
    if fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) then
      fraPlanoDeContas.edtDesCta.Clear;

    if fEmptyStr(edtPortadorCaixa.Text) then
      fraPlanoDeContasCon.edtDesCta.Clear;

    If (Sender.Name = 'dbeCodCta') And
       (not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text)) Then
    begin
      fraPlanoDeContas.edtDesCta.Clear;
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    end
    Else
    if (not fEmptyStr(edtPortadorCaixa.Text)) then
    begin
      fraPlanoDeContasCon.edtDesCta.Clear;
      fraPlanoDeContasCon.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    end;

    If (Sender.Name = 'MskCodCta') Then
    begin
      fraPlanoDeContasCon.edtDesCta.Clear;
      fraPlanoDeContasCon.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    end;

  End;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmCadMovBancario.dbeCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     dbeCodPor,
                     edtNomPor,
                     qryConPor,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     dbeCodEmp.Field.Text)  then
    Begin
      If TWinControl(Sender).Name = 'dbeCodPor' Then
        dbeCodPor.Text := qryConPor.FieldByName('POR_CODPOR').AsString
      Else
        edtPortadorCaixa.Text := qryConPor.FieldByName('POR_CODPOR').AsString;

      If TWinControl(Sender).Name = 'dbeCodPor' Then
      Begin
        If (fValidaCampos(dbeCodPor)) Then
          Self.SelectNext(ActiveControl, True, True);
      End
      Else
      Begin
        If (fValidaCampos(edtPortadorCaixa)) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End;
  End;
end;

procedure TfrmCadMovBancario.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaPortador(dbeCodPor);
  pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);
  CarregaContraPartida;
  CarregaEmpresa;
  pCarregaEventos;
  chkGerCon.Enabled := False;

  if not gpbContraPartida.Enabled then
    Self.Height := ATamanhoInicial;

  if blnConcilLoc then
   PostMessage(self.Handle, WM_CLOSE, 0, 0);

  pHabilitaDesabilitaBotoes;

  btnAlterarPortador.Enabled := False;
end;

procedure TfrmCadMovBancario.btnPesquisaClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    chrkey : Char;

begin

  chrKey := '/';

  If fPesqMovBancario(Self, dbeSeqLan, qryTabela, chrKey, arrSel, strNomeTabela) Then
  Begin
    pCarregaPortador(dbeCodPor);
    pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);
    pCarregaEventos;
    edtPortadorCaixa.Clear;
    fraPlanoDeContasCon.MskCodCta.Clear;
    edtCodigoCaixa.Clear;
    CarregaContraPartida;
    CarregaEmpresa;
    AValorInicial          := fStrToFloat(dbeValLan.Text);
    ADataLancamentoInicial := qryTabela.FieldByName('CTB_DTALAN').AsDateTime;
    chkGerCon.Enabled := False;

    If btnAlterar.Visible And btnAlterar.Enabled Then
      pSetFocus(btnAlterar);

    FValidaCorrespondenteContabil.LimparListas;
    FValidaCorrespondenteContabil.AddPortadorValidado(dbeCodPor.Text);
    FValidaCorrespondenteContabil.AddPortadorValidado(edtPortadorCaixa.Text);
    FValidaCorrespondenteContabil.AddPlanoDeContasValidado(fraPlanoDeContas.dbeCodCta.Text);
    FValidaCorrespondenteContabil.AddPlanoDeContasValidado(fraPlanoDeContasCon.MskCodCta.Text);
  End;
  pHabilitaDesabilitaBotoes;

  dbeCodEmp.Enabled := False;
  edtNomEmp.Enabled := False;
end;

procedure TfrmCadMovBancario.btnRegrasPortadorClick(Sender: TObject);
  var
    LMensagem: String;
begin
  inherited;
  LMensagem := #13#10 +
               'Movimentações que podem ser alteradas:                  ' + #13#10 +
               ' - Registros de Baixas: Receber, Adiantamento, Pagar    ' + #13#10 +
               '   e Cartões.                                           ' + #13#10 +
               ' - Baixas não estornadas.                               ' + #13#10 +
               ' - Baixas não recebidas por Pix.                        ' + #13#10 +
               ' - Registros não originários de transferências de       ' + #13#10 +
               '   valores/Resumo de Caixa.                             ' + #13#10 +
               ' - Registros não conciliados;                           ' + #13#10;

  LMensagem := LMensagem + #13#10 +
               ' - Registros de Depósitos de Cheques.                   ' + #13#10 +
               ' - Depósitos não cancelados ou devolvidos.              ' + #13#10 +
               ' - Depósitos realizados em versões do Autcom que possuem' + #13#10 +
               '   essa função;                                         ' + #13#10;

  fMensagem('Regras para alteração do Portador',
            LMensagem,
            ['&Ok'],
            1,
            False,
            2,
            0,
            False,
            0,
            False,
            False,
            False,
            310);
end;

procedure TfrmCadMovBancario.CarregaContraPartida;
var
  qryContraPartida: TUniquery;
begin
  qryContraPartida := fCriaQuery;

  qryContraPartida.SQL.Clear;
  qryContraPartida.SQL.Add('SELECT CTB_CODCTA, ');
  qryContraPartida.SQL.Add('       CTB_CODPOR, ');
  qryContraPartida.SQL.Add('       CTB_GERCON, ');
  qryContraPartida.SQL.Add('       CTB_SEQTRF  ');
  qryContraPartida.SQL.Add('FROM MOVBAN ');
  qryContraPartida.SQL.Add('WHERE CTB_SEQCTP = :SEQCTP AND ');
  qryContraPartida.SQL.Add('      CTB_CODEMP = :CODEMP AND ');
  qryContraPartida.SQL.Add('      CTB_CREDEB = :CREDEB AND ');
  qryContraPartida.SQL.Add('      CTB_DTALAN = :DTALAN     ');
  qryContraPartida.ParamByName('SEQCTP').AsString   := qryTabela.FieldByName('CTB_SEQCTP').AsString;

  qryContraPartida.ParamByName('CODEMP').AsString   := qryTabela.FieldByName('CTB_CODEMP').AsString;
  If Not qryTabela.FieldByName('CTB_EMPTRA').AsString.IsEmpty Then
    qryContraPartida.ParamByName('CODEMP').AsString   := qryTabela.FieldByName('CTB_EMPTRA').AsString;

  qryContraPartida.ParamByName('CREDEB').AsString   := IIF(qryTabela.FieldByName('CTB_CREDEB').AsString = 'C', 'D', 'C');
  qryContraPartida.ParamByName('DTALAN').AsDateTime := qryTabela.FieldByName('CTB_DTALAN').AsDateTime;
  qryContraPartida.Open;

  ExibeCamposCaixa(False);

  if not qryContraPartida.isEmpty then
  begin
    edtPortadorCaixa.Text := qryContraPartida.FieldByName('CTB_CODPOR').AsString;
    fraPlanoDeContasCon.MskCodCta.Text := qryContraPartida.FieldByName('CTB_CODCTA').AsString;
    chkGerCon.Checked := qryContraPartida.FieldByName('CTB_GERCON').AsInteger = 1;

    edtCodigoEmpresa.Text := qryTabela.FieldByName('CTB_EMPTRA').AsString;

    edtCodigoCaixa.Clear;
    If edtPortadorCaixa.Text = fCfgSis('PORRES') Then
      edtCodigoCaixa.Text := fCampoTabela('RCX_CODCAX',
                                          'CADRCXX',
                                          ['RCX_SEQCON', 'RCX_CODEMP'],
                                          [qryContraPartida.FieldByName('CTB_SEQTRF').AsString, VS_strCodEmp]);

    ExibeCamposCaixa(Not fEmptyStr(edtCodigoCaixa.Text));

    pCarregaCaixa;
    pCarregaPortador(edtPortadorCaixa);
    pCarregaCentroCusto(fraPlanoDeContasCon.MskCodCta);
    CarregaEmpresaContraPartida;

    Self.Height              := ATamanhoContraPartida;
    gpbContraPartida.Enabled := True;
    fraPlanoDeContasCon.MskCodCta.Enabled := False;
    lblPorRes.Visible        := False;

    ExibeEmpresaContraPartida;
  end
  else
  begin
    Self.height := ATamanhoInicial;
    edtPortadorCaixa.Clear;
    fraPlanoDeContasCon.MskCodCta.Clear;
    edtCodigoCaixa.Clear;
    edtCodigoEmpresa.Clear;
    lblPorRes.Visible := False;

    If (fCfgSis('UTICON', varBoolean)) Then
      chkGerCon.Checked := (fCfgSis('GERMCT', varBoolean))
    Else
    chkGerCon.Checked := True;
  end;

  FreeAndNil(qryContraPartida);
end;

procedure TfrmCadMovBancario.CarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, dbeCodEmp.Field.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;

  dbeCodEmp.Enabled := False;
  edtNomEmp.Enabled := False;
end;

procedure TfrmCadMovBancario.CarregaEmpresaContraPartida;
begin
  edtDescricaoEmpresa.Clear;

  If fEmptyStr(edtCodigoEmpresa.Text) Then
    Exit;

  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodigoEmpresa.Text);

  edtDescricaoEmpresa.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
end;

function TfrmCadMovBancario.ValidaDatadeLancamento(
  AInserindo: Boolean): Boolean;
  Var
    LDataNovoLancamento: TDateTime;
begin
  LDataNovoLancamento := StrToDate(dbeDtaLan.Text);
  If Not AInserindo Then
  Begin
    If strDtaLanAnterior.Equals(dbeDtaLan.Text) Then
      LDataNovoLancamento := VS_Date;
  End;

  Result := FPermiteLancarPosterior;

  If Result Then
  Begin
    If FDiasToleranciaPosterior = 0 Then
      Exit;

    Result := DaysBetween(VS_Date, LDataNovoLancamento) <= FDiasToleranciaPosterior;

    If Not Result Then
      fMensagem('ATENÇÃO', 'A data de lançamento não pode ser posterior a ' + FDiasToleranciaPosterior.ToString +
                           ' dias da data atual.', ['&Ok']);

    Exit;
  End;

  Result := VS_Date >= LDataNovoLancamento;

  If Not Result Then
    fMensagem('ATENÇÃO', 'A data de lançamento não pode ser posterior a data atual.', ['&Ok']);
end;

function TfrmCadMovBancario.VerificaValorAlteradoFecFin: Boolean;
begin
  Result := True;

  if (qryTabela.State = dsEdit) And
     (AValorInicial <> fStrToFloat(dbeValLan.Text)) Then
  begin
    if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Field.Text, StrToDate(dbeDtaLan.Text)) then
      Result := False;
  end;
end;

procedure TfrmCadMovBancario.FormShow(Sender: TObject);
begin
  If strTipMov = 'TE' Then
    strNomeForm := Self.Name + '_TE';

  inherited;

  chkGerCon.Visible := (fCfgSis('UTICON', varBoolean)) and (fCfgSis('MOVBAN', varBoolean));

  If strTipMov = 'TE' Then
  Begin
    btnExcluir.Visible  := False;
    btnPesquisa.Visible := False;
    btnAlterar.Visible  := False;

    ExibeCamposCaixa(False);
    pnlEmpresaContraPartida.Visible := True;
  End;

  Self.Height := ATamanhoInicial;

  pCarregaPortador(dbeCodPor);
  pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);
  pCarregaEventos;

  btnHistMovBan.Enabled := (fVerificaAcessoSistema('frmRelCbaLogAcompMovBanNovo'));

  btnAlterarPortador.Visible := (fVerificaAcessoSistema('ALTPORMOVBAN')) And
                                (strTipMov <> 'TE');

  btnRegrasPortador.Visible := btnAlterarPortador.Visible;

{************************************************}
{* VERIFICA PROPERTIES (SEQLAN, CODPOR, CODCTA) *}
{*RQ - 31697**********************************BB*}
  if Not(fEmptyStr(strSeqLan)) And Not(fEmptyStr(strCodPor)) And Not(fEmptyStr(strCodCta)) then
    pGetMovBan;

  if blnIniciaCadastro then
  begin
    btnIncluir.Click;

    if fltValLanLoc <> 0 then
      dbeValLan.DataSource.DataSet.FieldByName('CTB_VALLAN').Value := fltValLanLoc;

    if dteDataLanLoc <> 0 then
    begin
      dbeDtaLan.DataSource.DataSet.FieldByName('CTB_DTALAN').Value := dteDataLanLoc;
      mskCompet.Text := FormatDateTime('mm/yyyy', dteDataLanLoc);
    end;

    if strHist01Loc <> '' then
    begin
      if Length(strHist01Loc) <= 40 then
        dbeHisto01.DataSource.DataSet.FieldByName('CTB_HIST01').Value := strHist01Loc
      else
      begin
        dbeHisto01.DataSource.DataSet.FieldByName('CTB_HIST01').Value := Copy(strHist01Loc, 1, 40);
        dbeHisto01.DataSource.DataSet.FieldByName('CTB_HIST02').Value := Trim(Copy(strHist01Loc, 41, Length(strHist01Loc)));
      end;

      dbeHisto01.Enabled := not blnConcilLoc;
    end;

    if strCodPorLoc <> '' then
    begin
      dbeCodPor.DataSource.DataSet.FieldByName('CTB_CODPOR').Value := strCodPorLoc;
      pCarregaPortador(dbeCodPor);
    end;

    if strCreDebLoc <> '' then
      dbeCreDeb.DataSource.DataSet.FieldByName('CTB_CREDEB').Value := strCreDebLoc;
  end;

  if blnCarregaMovimento then
  begin
    with qryTabela do
    begin
      Close;
      Sql.Text := 'SELECT * FROM MOVBAN WHERE AUTOINCREM = :AUTOINC ';
      ParamByName('AUTOINC').AsString := strAutoIncremLoc;

      Open;

      if not isEmpty then
      begin
        pCarregaPortador(dbeCodPor);
        pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);
        pCarregaEventos;

        If btnAlterar.Visible And btnAlterar.Enabled Then
          pSetFocus(btnAlterar);
      end;
    end;
  end;
end;

procedure TfrmCadMovBancario.pLimpaEdits;
begin
  edtNomPor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  edtNomPor2.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  fraPlanoDeContasCon.edtDesCta.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtPortadorCaixa.Clear;
  fraPlanoDeContasCon.MskCodCta.Clear;
  edtCodigoCaixa.Clear;
  edtDescricaoCaixa.Clear;
  edtCodigoEmpresa.Clear;
  edtDescricaoEmpresa.Clear;

  If (fCfgSis('UTICON', varBoolean)) Then
    chkGerCon.Checked := (fCfgSis('GERMCT', varBoolean))
  Else
  chkGerCon.Checked := True;

end;

class procedure TfrmCadMovBancario.pMostraIniciandoCadastro(fltValLan: Double;
  strHist01: String; dteDataLan: TDate; strPorCod: String; strTipLan: String;
  var arrSeqLan: TStringArray; blnConciliado: Boolean = False; strTipMovi: String = 'CB');
begin
  pCriarFormularios(TfrmCadMovBancario, frmCadMovBancario);
  try
    try
      if not MatchStr(strTipMovi, ['CB','TE']) then
        raise Exception.Create('Tipo de movimentação inválido. [TfrmCadMovBancario.pMostraIniciandoCadastro]' );

      with frmCadMovBancario do
      begin
        if strTipMovi = 'TE' then
          Caption := 'Transferência de Valores';
        blnIniciaCadastro := True;
        strTipMov     := strTipMovi;
        fltValLanLoc  := fltValLan;
        strHist01Loc  := strHist01;
        strCodPorLoc  := strPorCod;
        dteDataLanLoc := dteDataLan;
        strCreDebLoc  := strTipLan;
        blnConcilLoc  := blnConciliado;
        ShowModal;
        arrSeqLan     := arrSeqLanLoc;
      end;
    except
      On E: Exception Do
          pMensagensErro(E.Message, '[TfrmCadMovBancario.pMostraIniciandoCadastro]');
    end;
  finally
    pFreeAndNil(frmCadMovBancario);
  end;
end;

procedure TfrmCadMovBancario.pSetCodCta(const Value: String);
begin
  FstrCodCta := Value;
end;

procedure TfrmCadMovBancario.pSetCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TfrmCadMovBancario.pSetCodPor(const Value: String);
begin
  FstrCodPor := Value;
end;

procedure TfrmCadMovBancario.pSetSeqLan(const Value: String);
begin
  FstrSeqLan := Value;
end;

procedure TfrmCadMovBancario.pShowHint;
begin
  HintControler.ShowHint(Self.Left + btnHistMovBan.Left + btnHistMovBan.Width,
                         Self.Top + pnlBotoesInfo.Top + btnHistMovBan.Top + btnHistMovBan.Height,
                         'ATENÇÃO',
                         'Apresentação do log das inclusão, alteração, exclusão e conciliação' + #13#10 +
                         'realizada diretamente na Movimentação Bancária.');
end;

function TfrmCadMovBancario.TransferenciaDeCaixaEmAberto: Boolean;
  Var
    fltUltFec: Double;
    dtaDtaFec: TDateTime;

    LDataLancamentoCaixa: TDateTime;
    LCodigoCaixa: String;
begin
  Result := False;

  If fEmptyStr(qryTabela.FieldByName('CTB_SEQTRF').AsString) Then
    Exit;

  LCodigoCaixa := TResumoDeCaixa.RetornaCodigoDoCaixaDoLancamento(qryTabela.FieldByName('CTB_SEQTRF').AsInteger,
                                                                  qryTabela.FieldByName('CTB_DTALAN').AsDateTime,
                                                                  qryTabela.FieldByName('CTB_CODEMP').AsString);

  pRetornaUltimoFechamento(fltUltFec, dtaDtaFec, qryTabela.FieldByName('CTB_CODEMP').AsString, LCodigoCaixa);

  LDataLancamentoCaixa := TResumoDeCaixa.RetornaDataDoLancamentoCaixa(qryTabela.FieldByName('CTB_SEQTRF').AsInteger,
                                                                      qryTabela.FieldByName('CTB_DTALAN').AsDateTime,
                                                                      qryTabela.FieldByName('CTB_CODEMP').AsString,
                                                                      LCodigoCaixa);
  Result := Not (dtaDtaFec >= LDataLancamentoCaixa);
end;

function TfrmCadMovBancario.fRetDtaIniPortador(
  strCodPor: String): TDateTime;
  Var
    strSQL   : String;
    qryGenPor: TUniQuery;
begin
  Try
    qryGenPor := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  POR_DTAINI AS DTAINI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  POR_CODPOR = :CODPOR ';

    With qryGenPor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPOR').AsString := strCodPor;
      Open;
      Result := FieldByName('DTAINI').AsDateTime;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPor);
  End;

end;

procedure TfrmCadMovBancario.btnExcluirClick(Sender: TObject);
  Var
    strSeqLanExc : String;
    strAutoIncrem: String;
    qryBusca,
    qryDelete: TUniQuery;
    blnErro: Boolean;
    LMensagem: String;
begin
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If TransferenciaDeCaixaEmAberto Then
  Begin
    fMensagem('AVISO', 'Esta movimentação bancária é referente a uma transferência no resumo de caixa. ' + #13#10 +
                       'A exclusão desta movimentação não será permitida até que o caixa correspondente seja fechado.', ['&Ok']);
    Exit;
  End;

  If fBloquearExclusaoMovBanComOrigem(qryTabela.FieldByName('AUTOINCREM').AsString, LMensagem) Then
  Begin
    fMensagem('Atenção!', LMensagem, ['&O k']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If Not fLiberacaoParaExclusao Then
    Exit;

  blnErro   := False;
  qryBusca  := fCriaQuery(Self);
  qryDelete := fCriaQuery(Self);

  If Not qryTabela.FieldByName('CTB_DTACON').IsNull Then
  Begin
    fMensagem('', 'Não é possível excluir esse registro, pois o mesmo está conciliado. ' +
                  'Para ser possível estorná-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
    Exit;
  End;

  strSeqLanExc  := qryTabela.FieldByName('CTB_SEQLAN').AsString;
  strAutoIncrem := qryTabela.FieldByName('AUTOINCREM').AsString;

  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Field.Text, qryTabela.FieldByName('CTB_DTALAN').AsDateTime) then
    Exit;

  inherited;

  If (blnExcluiu) Then
  Begin
    if Self.Height = ATamanhoContraPartida then
      Self.Height := ATamanhoInicial;

    edtNomEmp.Clear;
    fraPlanoDeContas.edtDesCta.Clear;
    FcdsLogMod.Insert;
    FcdsLogMod.FieldByName('LOG_SEQLAN').AsString := strSeqLanExc;
    FcdsLogMod.FieldByName('LOG_STATUS').AsString := 'EXCLUSAO';
    FcdsLogMod.Post;

    //DELETANDO DA BANEXR
    Try
      qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('SELECT AUTOINCREM, EXR_EXTINC, EXR_BANINC ');
      qryBusca.SQL.Add('FROM BANEXR  ');
      qryBusca.SQL.Add('WHERE EXR_BANINC = :BANINC ');
      qryBusca.ParamByName('BANINC').AsString := strAutoIncrem;
      qryBusca.Open;

      If qryBusca.RecordCount > 0 then
      begin
        while not qryBusca.Eof Do
        begin
          qryDelete.Sql.Clear;
          qryDelete.Sql.Text := 'UPDATE EXTBAN SET EXT_DTACON = NULL, EXT_OPECON = NULL, EXT_HORCON = NULL, EXT_SITUAC = "N" WHERE AUTOINCREM IN (SELECT EXR_EXTINC FROM BANEXR WHERE EXR_BANINC = :BANINC)';
          qryDelete.ParambyName('BANINC').AsString := qryBusca.FieldByName('EXR_BANINC').AsString;
          qryDelete.ExecSql;

          qryDelete.Sql.Clear;
          qryDelete.Sql.Text := 'DELETE FROM BANEXR WHERE EXR_BANINC = :BANINC';
          qryDelete.ParambyName('BANINC').AsString := qryBusca.FieldByName('EXR_BANINC').AsString;
          qryDelete.ExecSql;
          qryBusca.Next;
        end;
      end;
    Except
      On e: Exception Do
      Begin
        fRollBack;
        strMsgErr := e.Message;
        blnErro := True;
      End;
    End;

    If Not blnErro Then
      fCommit
    else
    Begin
      fMensagem('Atenção', 'Ocorreu o seguinte erro ao desvincular os lançamentos: '+#13+'Erro:'+strMsgErr, ['&O k']);
      fRollBack;
      Exit;
    End;
  End
  Else
    fRollBack;

  FreeAndNil(qryBusca);
  FreeAndNil(qryDelete);
  pCarregaPortador(dbeCodPor);
  pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);
  CarregaContraPartida;
  CarregaEmpresa;
  pCarregaEventos;
  btnAbrirPastaAnexos.Enabled := False;
end;

function TfrmCadMovBancario.dbeCodPorChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadPor(Key);
  pAtribuiTabelas;
end;

procedure TfrmCadMovBancario.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin

    If FindField('CTB_CODCTA') <> nil Then
      TStringField(FieldByName('CTB_CODCTA')).EditMask := '99.99.999;0;_';

    If FindField('CTB_DTALAN') <> nil Then
      TDateField(FieldByName('CTB_DTALAN')).EditMask := '99/99/9999';

    If FindField('CTB_VALLAN') <> nil Then
      TFloatField(FieldByName('CTB_VALLAN')).DisplayFormat := '#,##0.00';

  End;
end;

procedure TfrmCadMovBancario.pAtribuiTabelas;
begin
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
end;

function TfrmCadMovBancario.fValidaCentroCusto: Boolean;
begin
  Result := True;
  If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.dbeCodCta.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Linha / Grupo de Plano de Contas não é permitido!', ['&O k']);
    Result := False;
  End
  Else If (qryTabela.State = dsInsert) Then
  Begin
    pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);

    If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
      Result := False;
  End
  Else
  Begin
    If qryConCta.FieldByName('CTA_CODCTA').AsString <> fraPlanoDeContas.dbeCodCta.Text Then
    Begin
      If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
        Result := False;
    End;
  End;
end;

function TfrmCadMovBancario.fVerificaSaldoPositivo(Var curSalPor, curSalFut: Currency; curValLan: Currency): Boolean;
begin

  If dbeCreDeb.Text = 'C' Then
    curSalPor := fRetSaldoAnterior(edtPortadorCaixa.Text, VS_Date, IIF(fCfgSis('TRFEMP', varBoolean), VS_strCodEmp, ''))
  Else
    curSalPor := fRetSaldoAnterior(dbeCodPor.Text, VS_Date, IIF(fCfgSis('TRFEMP', varBoolean), VS_strCodEmp, ''));

  curSalFut := curSalPor - curValLan;

  Result := curSalFut >= 0;

end;

procedure TfrmCadMovBancario.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.dbeCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.dbeCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCadMovBancario.pAlterarDataLanctoCadRec(AAutoIncremList: String;
  ADataAlterada: TDateTime);
Var
  qryMovBan : TUniQuery;
  qryCadRec : TUniQuery;
begin
  qryMovBan := fCriaQuery(Self);
  qryCadRec := fCriaQuery(Self);

  Try
    qryMovBan.Close;
    qryMovBan.SQL.Clear;
    qryMovBan.SQL.Add('SELECT ');
    qryMovBan.SQL.Add('  B.CTR_NUMDUP, ');
    qryMovBan.SQL.Add('  B.CTR_PARCEL, ');
    qryMovBan.SQL.Add('  B.CTR_CODEMP, ');
    qryMovBan.SQL.Add('  B.CTR_CODCLI, ');
    qryMovBan.SQL.Add('  B.CTR_ESPDOC,  ');
    qryMovBan.SQL.Add('  B.CTB_SEQLAN ');
    qryMovBan.SQL.Add(' FROM MOVBAN M ');
    qryMovBan.SQL.Add('   JOIN BANCTR B ON M.CTB_SEQLAN = B.CTB_SEQLAN ');
    qryMovBan.SQL.Add(' WHERE M.AUTOINCREM IN (' + AAutoIncremList + ') ');
    qryMovBan.Open;

    If (Not qryMovBan.IsEmpty) Then
    Begin
       qryMovBan.First;
       While Not qryMovBan.Eof Do
       Begin
          qryCadRec.Close;
          qryCadRec.SQL.Clear;
          qryCadRec.SQL.Add(' UPDATE CADREC ');
          qryCadRec.SQL.Add('    SET CTR_DTABAN = :DTABAN ');
          qryCadRec.SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP  ');
          qryCadRec.SQL.Add('    AND CTR_PARCEL = :PARCEL ');
          qryCadRec.SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
          qryCadRec.SQL.Add('    AND CTR_CODCLI = :CODCLI ');
          qryCadRec.SQL.Add('    AND CTR_CODEMP = :CODEMP ');
          qryCadRec.SQL.Add('    AND CTR_DOCBAI = :DOCBAI ');

          qryCadRec.ParamByName('DTABAN').AsDateTime := ADataAlterada;
          qryCadRec.ParamByName('NUMDUP').AsString := qryMovBan.FieldByName('CTR_NUMDUP').AsString;
          qryCadRec.ParamByName('PARCEL').AsString := qryMovBan.FieldByName('CTR_PARCEL').AsString;
          qryCadRec.ParamByName('ESPDOC').AsString := qryMovBan.FieldByName('CTR_ESPDOC').AsString;
          qryCadRec.ParamByName('CODCLI').AsString := qryMovBan.FieldByName('CTR_CODCLI').AsString;
          qryCadRec.ParamByName('CODEMP').AsString := qryMovBan.FieldByName('CTR_CODEMP').AsString;
          qryCadRec.ParamByName('DOCBAI').AsString := qryMovBan.FieldByName('CTB_SEQLAN').AsString;

          qryCadRec.ExecSQL;

          pGravaLogCtr(qryMovBan.FieldByName('CTR_NUMDUP').AsString,
                       qryMovBan.FieldByName('CTR_ESPDOC').AsString,
                       qryMovBan.FieldByName('CTR_CODCLI').AsString,
                       qryMovBan.FieldByName('CTR_CODEMP').AsString,
                       qryMovBan.FieldByName('CTR_PARCEL').AsString,
                       0,
                       'ALTEROU DATA LANÇAMENTO BANCÁRIO',
                       Self.Name,
                       0);
          qryMovBan.Next;
      End;
    End;

    FreeAndNil(qryCadRec);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmCadConciliacaoBancaria.AlterarDataLanctoCadRec] ' +E.Message);
    End;
  End;

end;

procedure TfrmCadMovBancario.pAlterarDataLanctoTF_OP_CadRec(AAutoIncremList: String;
  ADataAlterada: TDateTime);
Var
  qryMovBan : TUniQuery;
  qryCadRec : TUniQuery;
  qryRcxSeq : TUniQuery;
  qryAltTfop : TUniQuery;
begin
  qryMovBan := nil;
  qryCadRec := nil;
  qryRcxSeq := nil;
  qryAltTfop := nil;
  try
    qryMovBan := fCriaQuery(Self);
    qryCadRec := fCriaQuery(Self);
    qryRcxSeq := fCriaQuery(Self);
    qryAltTfop := fCriaQuery(Self);

    Try
      qryMovBan.Close;
      qryMovBan.SQL.Clear;
      qryMovBan.SQL.Add('SELECT ');
      qryMovBan.SQL.Add('  CTB_SEQTRF, CTB_CODEMP ');
      qryMovBan.SQL.Add(' FROM MOVBAN ');
      qryMovBan.SQL.Add(' WHERE AUTOINCREM IN (' + AAutoIncremList + ') ');
      qryMovBan.SQL.Add('   AND IFNULL(CTB_SEQTRF,0) > 0 ');
      qryMovBan.Open;

      If (Not qryMovBan.IsEmpty) Then
      Begin
         qryMovBan.First;

         qryRcxSeq.Close;
         qryRcxSeq.SQL.Clear;
         qryRcxSeq.SQL.Add('SELECT ');
         qryRcxSeq.SQL.Add(' RCX_SQTFOP, RCX_CODEMP ');
         qryRcxSeq.SQL.Add(' FROM CADRCXX ');
         qryRcxSeq.SQL.Add(' WHERE RCX_SEQCON = :SEQCON ');
         qryRcxSeq.SQL.Add('   AND RCX_CODEMP = :CODEMP ');
         qryRcxSeq.SQL.Add('   AND IFNULL(RCX_SEQCON,0) > 0 ');
         qryRcxSeq.ParamByName('SEQCON').AsInteger := qryMovBan.FieldByName('CTB_SEQTRF').AsInteger;
         qryRcxSeq.ParamByName('CODEMP').AsString  := qryMovBan.FieldByName('CTB_CODEMP').AsString;
         qryRcxSeq.Open;

         If (Not qryRcxSeq.IsEmpty) Then
         Begin

           If Not FemptyStr(qryRcxSeq.FieldByName('RCX_SQTFOP').AsString) Then
           Begin

              qryAltTfop.Close;
              qryAltTfop.SQL.Clear;
              qryAltTfop.SQL.Add(' SELECT ');
              qryAltTfop.SQL.Add('  RCX_NUMDUP, RCX_PARCEL, RCX_ESPDOC, RCX_CODCLI, RCX_CODEMP, RCX_SEQCON ');
              qryAltTfop.SQL.Add(' FROM CADRCXX WHERE RCX_SEQCON = :SEQCON ');
              qryAltTfop.SQL.Add('                AND RCX_CODEMP = :CODEMP ');
              qryAltTfop.ParamByName('SEQCON').AsInteger := qryRcxSeq.FieldByName('RCX_SQTFOP').AsInteger;
              qryAltTfop.ParamByName('CODEMP').AsString  := qryRcxSeq.FieldByName('RCX_CODEMP').AsString;
              qryAltTfop.Open;

              If (Not qryAltTfop.IsEmpty) Then
              Begin
                while not qryAltTfop.Eof do
                begin
                  qryCadRec.Close;
                  qryCadRec.SQL.Clear;
                  qryCadRec.SQL.Add(' UPDATE CADREC ');
                  qryCadRec.SQL.Add('    SET CTR_DTABAN = :DTABAN ');
                  qryCadRec.SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP  ');
                  qryCadRec.SQL.Add('    AND CTR_PARCEL = :PARCEL ');
                  qryCadRec.SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
                  qryCadRec.SQL.Add('    AND CTR_CODCLI = :CODCLI ');
                  qryCadRec.SQL.Add('    AND CTR_CODEMP = :CODEMP ');
                  qryCadRec.SQL.Add('    AND CTR_SEQCON = :SEQCON ');

                  qryCadRec.ParamByName('DTABAN').AsDateTime := ADataAlterada;
                  qryCadRec.ParamByName('NUMDUP').AsString := qryAltTfop.FieldByName('RCX_NUMDUP').AsString;
                  qryCadRec.ParamByName('PARCEL').AsString := qryAltTfop.FieldByName('RCX_PARCEL').AsString;
                  qryCadRec.ParamByName('ESPDOC').AsString := qryAltTfop.FieldByName('RCX_ESPDOC').AsString;
                  qryCadRec.ParamByName('CODCLI').AsString := qryAltTfop.FieldByName('RCX_CODCLI').AsString;
                  qryCadRec.ParamByName('CODEMP').AsString := qryAltTfop.FieldByName('RCX_CODEMP').AsString;
                  qryCadRec.ParamByName('SEQCON').AsInteger := qryAltTfop.FieldByName('RCX_SEQCON').AsInteger;

                  qryCadRec.ExecSQL;

                  pGravaLogCtr(qryAltTfop.FieldByName('RCX_NUMDUP').AsString,
                               qryAltTfop.FieldByName('RCX_ESPDOC').AsString,
                               qryAltTfop.FieldByName('RCX_CODCLI').AsString,
                               qryAltTfop.FieldByName('RCX_CODEMP').AsString,
                               qryAltTfop.FieldByName('RCX_PARCEL').AsString,
                               0,
                               'ALTEROU DATA LANÇAMENTO BANCÁRIO',
                               Self.Name,
                               0);

                  qryAltTfop.Next;
                end;

              End;

           End

         End;

      End;
    Except
      On E: ExceptionAutcom Do
        Raise ExceptionAutcom.Create(E.Message);

      On E: Exception Do
      Begin
        Raise Exception.Create('[TfrmCadMovBancario.AlterarDataLanctoTF_OP_CadRec] ' +E.Message);
      End;
    End;
  finally
    if Assigned(qryMovBan) then
      FreeAndNil(qryMovBan);

    if Assigned(qryCadRec) then
      FreeAndNil(qryCadRec);

    if Assigned(qryRcxSeq) then
      FreeAndNil(qryRcxSeq);

    if Assigned(qryAltTfop) then
      FreeAndNil(qryAltTfop);
  end;

end;

procedure TfrmCadMovBancario.pAlterarDataLanctoAdiantamento(AAutoIncremList: String;
  ADataAlterada: TDateTime);
Var
  qryMovBan : TUniQuery;
  qryAltAdt : TUniQuery;
  qryRcxSeq : TUniQuery;
begin
  qryMovBan := fCriaQuery(Self);
  qryAltAdt := fCriaQuery(Self);
  qryRcxSeq := fCriaQuery(Self);

  Try
    qryMovBan.Close;
    qryMovBan.SQL.Clear;
    qryMovBan.SQL.Add('SELECT ');
    qryMovBan.SQL.Add('  CTB_SEQTRF, CTB_CODEMP ');
    qryMovBan.SQL.Add(' FROM MOVBAN ');
    qryMovBan.SQL.Add(' WHERE AUTOINCREM IN (' + AAutoIncremList + ') ');
    qryMovBan.SQL.Add('   AND IFNULL(CTB_SEQTRF,0) > 0 ');
    qryMovBan.Open;

    If (Not qryMovBan.IsEmpty) Then
    Begin
       qryMovBan.First;

       qryRcxSeq.Close;
       qryRcxSeq.SQL.Clear;
       qryRcxSeq.SQL.Add('SELECT ');
       qryRcxSeq.SQL.Add(' RCX_SQTFOP, RCX_CODEMP ');
       qryRcxSeq.SQL.Add(' FROM CADRCXX ');
       qryRcxSeq.SQL.Add(' WHERE RCX_SEQCON = :SEQCON ');
       qryRcxSeq.SQL.Add('   AND RCX_CODEMP = :CODEMP ');
       qryRcxSeq.SQL.Add('   AND IFNULL(RCX_SEQCON,0) > 0 ');
       qryRcxSeq.ParamByName('SEQCON').AsInteger := qryMovBan.FieldByName('CTB_SEQTRF').AsInteger;
       qryRcxSeq.ParamByName('CODEMP').AsString  := qryMovBan.FieldByName('CTB_CODEMP').AsString;
       qryRcxSeq.Open;

       If (Not qryRcxSeq.IsEmpty) Then
       Begin

         If Not FemptyStr(qryRcxSeq.FieldByName('RCX_SQTFOP').AsString) Then
         Begin
            qryAltAdt.Close;
            qryAltAdt.SQL.Clear;
            qryAltAdt.SQL.Add(' UPDATE ADTCLI ');
            qryAltAdt.SQL.Add('    SET ADT_DTABAN = :DTABAN ');
            qryAltAdt.SQL.Add('  WHERE ADT_SEQCON = :SQTFOP ');
            qryAltAdt.SQL.Add('    AND ADT_EMPLAN = :CODEMP ');
            qryAltAdt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
            qryAltAdt.ParamByName('SQTFOP').AsString   := qryRcxSeq.FieldByName('RCX_SQTFOP').AsString;
            qryAltAdt.ParamByName('CODEMP').AsString   := qryRcxSeq.FieldByName('RCX_CODEMP').AsString;
            qryAltAdt.ExecSQL;
         End
         Else
         Begin

           // pix qrcode pelo caixa
           qryRcxSeq.Close;
           qryRcxSeq.SQL.Clear;
           qryRcxSeq.SQL.Add('SELECT ');
           qryRcxSeq.SQL.Add(' MPX_SEQCON, MPX_SEQTRF, MPX_CODEMP ');
           qryRcxSeq.SQL.Add('  FROM ');
           qryRcxSeq.SQL.Add(' MOVPIX ');
           qryRcxSeq.SQL.Add(' WHERE MPX_SEQTRF = :SEQCON ');
           qryRcxSeq.SQL.Add('   AND MPX_CODEMP = :CODEMP ');
           qryRcxSeq.SQL.Add('   AND MPX_STATUS = ''CONCLUIDA'' ');
           qryRcxSeq.ParamByName('SEQCON').AsInteger := qryMovBan.FieldByName('CTB_SEQTRF').AsInteger;
           qryRcxSeq.ParamByName('CODEMP').AsString  := qryMovBan.FieldByName('CTB_CODEMP').AsString;
           qryRcxSeq.Open;
           If (Not qryRcxSeq.IsEmpty) And (Not FemptyStr(qryRcxSeq.FieldByName('MPX_SEQCON').AsString)) Then
           Begin
              qryAltAdt.Close;
              qryAltAdt.SQL.Clear;
              qryAltAdt.SQL.Add(' UPDATE ADTCLI ');
              qryAltAdt.SQL.Add('    SET ADT_DTABAN = :DTABAN ');
              qryAltAdt.SQL.Add('  WHERE ADT_SEQCON = :SQTFOP ');
              qryAltAdt.SQL.Add('    AND ADT_EMPLAN = :CODEMP ');
              qryAltAdt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
              qryAltAdt.ParamByName('SQTFOP').AsString   := qryRcxSeq.FieldByName('MPX_SEQCON').AsString;
              qryAltAdt.ParamByName('CODEMP').AsString   := qryRcxSeq.FieldByName('MPX_CODEMP').AsString;
              qryAltAdt.ExecSQL;
           End

         End;

       End;

    End
    Else
    Begin

      qryMovBan.Close;
      qryMovBan.SQL.Clear;
      qryMovBan.SQL.Add('SELECT ');
      qryMovBan.SQL.Add(' B.CTB_SEQLAN, ');
      qryMovBan.SQL.Add(' M.CTB_CODEMP, ');
      qryMovBan.SQL.Add(' M.CTB_SEQBAI,  ');
      qryMovBan.SQL.Add(' B.CTR_SEQBAI  ');
      qryMovBan.SQL.Add(' FROM MOVBAN M ');
      qryMovBan.SQL.Add('   JOIN BANCTR B ON M.CTB_SEQLAN = B.CTB_SEQLAN ');
      qryMovBan.SQL.Add(' WHERE M.AUTOINCREM IN ('+ AAutoIncremList + ') ');
      qryMovBan.Open;
      If (Not qryMovBan.IsEmpty) Then
      Begin
         If (Not fEmptyStr(qryMovBan.FieldByName('CTB_SEQBAI').AsString)) or (Not femptyStr(qryMovBan.FieldByName('CTR_SEQBAI').AsString)) Then
         Begin
           qryAltAdt.Close;
           qryAltAdt.SQL.Clear;
           qryAltAdt.SQL.Add(' UPDATE ADTCLI ');
           qryAltAdt.SQL.Add('    SET ADT_DTABAN = :DTABAN ');
           qryAltAdt.SQL.Add('  WHERE ADT_SEQCON = :SEQCON ');
           qryAltAdt.SQL.Add('    AND ADT_EMPLAN = :CODEMP ');
           qryAltAdt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
           qryAltAdt.ParamByName('SEQCON').AsString   := IIF( Not fEmptyStr(qryMovBan.FieldByName('CTB_SEQBAI').AsString),
                                                              qryMovBan.FieldByName('CTB_SEQBAI').AsString, qryMovBan.FieldByName('CTR_SEQBAI').AsString);
           qryAltAdt.ParamByName('CODEMP').AsString   := qryMovBan.FieldByName('CTB_CODEMP').AsString;
           qryAltAdt.ExecSQL;
         End;
      End
      Else
      Begin
         //BUSCA PELO SEQBAI.
         qryRcxSeq.Close;
         qryRcxSeq.SQL.Clear;
         qryRcxSeq.SQL.Add('SELECT ');
         qryRcxSeq.SQL.Add('  CTB_SEQBAI, CTB_CODEMP ');
         qryRcxSeq.SQL.Add(' FROM MOVBAN ');
         qryRcxSeq.SQL.Add(' WHERE AUTOINCREM IN (' + AAutoIncremList + ') ');
         qryRcxSeq.Open;
         If (Not qryRcxSeq.IsEmpty) And (Not FEmptyStr(qryRcxSeq.FieldByName('CTB_SEQBAI').AsString)) Then
         Begin
            qryAltAdt.Close;
            qryAltAdt.SQL.Clear;
            qryAltAdt.SQL.Add(' UPDATE ADTCLI ');
            qryAltAdt.SQL.Add('    SET ADT_DTABAN = :DTABAN ');
            qryAltAdt.SQL.Add('  WHERE ADT_SEQCON = :SEQCON ');
            qryAltAdt.SQL.Add('    AND ADT_EMPLAN = :CODEMP ');
            qryAltAdt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
            qryAltAdt.ParamByName('SEQCON').AsString   := qryRcxSeq.FieldByName('CTB_SEQBAI').AsString;
            qryAltAdt.ParamByName('CODEMP').AsString   := qryRcxSeq.FieldByName('CTB_CODEMP').AsString;
            qryAltAdt.ExecSQL;
         End;
      End;

    End;

    If Assigned(qryMovBan) Then
       FreeAndNil(qryMovBan);

    If Assigned(qryAltAdt) Then
       FreeAndNil(qryAltAdt);

    If Assigned(qryRcxSeq) Then
       FreeAndNil(qryRcxSeq);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmCadMovBancario.pAlterarDataLanctoAdiantamento] ' +E.Message);
    End;
  End;
end;

procedure TfrmCadMovBancario.btnGravarClick(Sender: TObject);
  Var
    curSalPor: Currency;
    curSalFut: Currency;
    curValLan: Currency;
    strCD_Atu: String;
    blnInserindo : Boolean;
    strSeqRcx: String;
    blnGeraCreditoCaixa: Boolean;
    objListaMovBan: TList<TMovBan>;
    objMovBan: TMovBan;
    repMovBan: TMovBanRepository;
    fltValor: Double;
    dtaDataFechamento: TDateTime;
    SMensagemLog,
    SSequenciaLancamentoContraPartida : string;
    AGravaContraPartida: Boolean;

    LEmpresaContrapartida: String;
begin
  If Not fValidacoesBotaoGravarPai Then
    Exit;

  AGravaContraPartida := False;
  LEmpresaContrapartida := dbeCodEmp.Field.Text;

  If strTipMov = 'TE' Then
  Begin
    curValLan := fStrToFloat(dbeValLan.Text);

    If Not fVerificaSaldoPositivo(curSalPor, curSalFut, curValLan) Then
    Begin

      If curSalPor < 0 Then
      Begin
        curSalPor := curSalPor * -1;
        strCD_Atu := 'D';
      End
      Else
        strCD_Atu := 'C';

      curSalFut := curSalFut * -1;

      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'TRFVAL';
      objLiberacao.strSenLib    := fCfgSis('TRFVAL');
      objLiberacao.strMsgSen    := 'Transferência de Valores -  Movimentação de Conta Banco';
      objLiberacao.blnMosMen    := True;
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.strCodDig    := strLoginUsuarioLogado;


      if dbeCreDeb.Text = 'C' then
        objLiberacao.objMsgLibera.pAddTexto('O portador ' + edtPortadorCaixa.Text + ' - ' +  edtNomPor2.Text + ' ficará com saldo negativo.')
      else
        objLiberacao.objMsgLibera.pAddTexto('O portador ' + dbeCodPor.Text + ' - ' +  edtNomPor.Text + ' ficará com saldo negativo.');

      objLiberacao.objMsgLibera.pAddTextoCaption('Saldo Atual', FormatFloat('#,##0.00', curSalPor) + ' ' + strCD_Atu, 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor Lanç.', dbeValLan.Text + ' D'                               , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Novo Saldo' , FormatFloat('#,##0.00', curSalFut) + ' D'           , 11);
      objLiberacao.pInformaNumDocEspDocCodEmp(
                        qryTabela.FieldByName('CTB_NUMDUP').AsString,
                        EmptyStr,
                        qryTabela.FieldByName('CTB_CODEMP').AsString);

      If Not objLiberacao.fLibera then
        Exit;

    End;
  End;

  blnGeraCreditoCaixa := (edtPortadorCaixa.Text = fCfgSis('PORRES')) And (strTipMov = 'TE');

  objResumoDeCaixa.fRetornaUltimoFechamento(fltValor, dtaDataFechamento, edtCodigoCaixa.Text);

  If (blnGeraCreditoCaixa) then
  Begin
    If (objResumoDeCaixa.strTipoFechamento <> 'C') And
       (dtaDataFechamento = dbeDtaLan.Field.AsDateTime) Then
    begin
      fMensagem('ATENÇÃO', 'Não é possível realizar transferências ao portador ' + edtPortadorCaixa.Text + ' com o caixa do dia fechado!', ['&Ok'], 1);
      Exit;
    end;

    Try
      pCriarFormularios(TfrmInfCodOpeLcCaixa, frmInfCodOpeLcCaixa);
      frmInfCodOpeLcCaixa.ShowModal;
      strCodOpe := frmInfCodOpeLcCaixa.strCodOpe;
    Finally
      FreeAndNil(frmInfCodOpeLcCaixa);
    End;

  End;

  if (blnGeraCreditoCaixa) and fEmptyStr(strCodOpe) Then
  begin
    btnCancelaClick(Sender);
    pLimpaEdits;
  end
  else
  begin
    qryTabela.FieldByName('CTB_CODOPE').AsString   := strLoginUsuarioLogado;
    qryTabela.FieldByName('CTB_HORLAN').AsDateTime := fTime();
    qryTabela.FieldByName('CTB_COMPET').AsString := mskCompet.Text;

    If Not fEmptyStr(edtCodigoEmpresa.Text) Then
    Begin
      If Not blnGeraCreditoCaixa Then
      Begin
        qryTabela.FieldByName('CTB_EMPTRA').AsString := edtCodigoEmpresa.Text;
        LEmpresaContrapartida := edtCodigoEmpresa.Text;
      End;
    End;

    if (blnConcilLoc) And (qryTabela.State = dsInsert) then
    begin
      qryTabela.FieldByName('CTB_DTACON').AsDateTime := VS_Date;
      qryTabela.FieldByName('CTB_HORCON').AsDateTime := fTime();
      qryTabela.FieldByName('CTB_OPECON').AsString   := strLoginUsuarioLogado;
    end;

    blnInserindo := (qryTabela.State = dsInsert);

    If (TWinControl(Sender).Name = 'btnGravar') And
       (Not fEmptyStr(edtPortadorCaixa.Text)) And
       (Not fEmptyStr(fraPlanoDeContasCon.MskCodCta.Text)) And
       (fEmptyStr(qryTabela.FieldByName('CTB_SEQCTP').AsString)) Then
      strSeqPar := fRetSequencial('SCTPAR')
    Else
      strSeqPar := '';

    If Not fEmptyStr(strSeqPar) Then
    begin
      qryTabela.FieldByName('CTB_SEQCTP').AsString := strSeqPar;
      AGravaContraPartida := True;
    end;

    If Not ValidaDatadeLancamento(blnInserindo) Then
      Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    Try
      inherited;

      If blnGravou Then
      Begin
        {*********************************************}
        {* VALIDACAO DE INTEGRIDADE POS-GRAVACAO     *}
        {* REQ 432962 - Previne lancamento gravado   *}
        {* com CTB_SEQLAN vazio por perda de conexao *}
        {*******************************************VF}
        If fEmptyStr(qryTabela.FieldByName('CTB_SEQLAN').AsString) Then
        Begin
          qryTabela.Delete;
          fRollback;
          fMensagem('ATENCAO!',
            'Falha na gravacao do lancamento: o Sequencial (CTB_SEQLAN) nao foi gerado ' +
            'corretamente, possivelmente devido a uma instabilidade na conexao com o servidor. ' +
            'O lancamento nao foi salvo. Por favor, tente novamente.',
            ['&Ok']);
          Exit;
        End;

        If (fEmptyStr(strSeqPar)) and (Not fEmptyStr(qryTabela.FieldByName('CTB_SEQCTP').AsString)) Then
        Begin
          If LEmpresaContraPartida.Trim.IsEmpty Then
              LEmpresaContraPartida := IIF(qryTabela.FieldByName('CTB_EMPTRA').AsString.Trim.IsEmpty,
                                           qryTabela.FieldByName('CTB_CODEMP').AsString,
                                           qryTabela.FieldByName('CTB_EMPTRA').AsString);

          If Not fAtualizaContraPartida(qryTabela.FieldByName('CTB_SEQCTP').AsString,
                                        qryTabela.FieldByName('CTB_SEQLAN').AsString,
                                        LEmpresaContraPartida,
                                        qryTabela.FieldByName('CTB_CREDEB').AsString,
                                        qryTabela.FieldByName('CTB_VALLAN').AsFloat,
                                        qryTabela.FieldByName('CTB_DTALAN').AsDateTime,
                                        ADataLancamentoInicial,
                                        fGerarMovimentoBancario) Then
            Exit;
        End;

        If (blnInserindo) Then
        Begin
          FcdsLogMod.Insert;
          FcdsLogMod.FieldByName('LOG_SEQLAN').AsString := qryTabela.FieldByName('CTB_SEQLAN').AsString;
          FcdsLogMod.FieldByName('LOG_STATUS').AsString := 'INCLUSAO';
          FcdsLogMod.Post;

          SMensagemLog := IIF(strTipMov = 'TE', 'TRANSFERENCIA', 'INCLUSAO');

          //Grava alguns campos para a próxima inserção
          strDtaAnt := dbeDtaLan.Text;
          strComAnt := mskCompet.Text;
          strPorAnt := dbeCodPor.Text;
          strPlaAnt := fraPlanoDeContas.dbeCodCta.Text;
        End
        Else
        Begin
          If Not FcdsLogMod.FindKey([qryTabela.FieldByName('CTB_SEQLAN').AsString]) Then
          Begin
            FcdsLogMod.Insert;
            FcdsLogMod.FieldByName('LOG_SEQLAN').AsString := qryTabela.FieldByName('CTB_SEQLAN').AsString;
            FcdsLogMod.FieldByName('LOG_STATUS').AsString := 'ALTERACAO';
            FcdsLogMod.Post;
          End;

          SMensagemLog := 'ALTERACAO';

          If (qryTabela.FieldByName('CTB_DTALAN').AsDateTime <> StrToDate(strDtaLanAnterior)) Then
          Begin
             pAlterarDataLanctoCadRec(QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString), qryTabela.FieldByName('CTB_DTALAN').AsDateTime);

             pAlterarDataLanctoTF_OP_CadRec(QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString), qryTabela.FieldByName('CTB_DTALAN').AsDateTime);

             pAlterarDataLanctoAdiantamento(QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString), qryTabela.FieldByName('CTB_DTALAN').AsDateTime);

             pAlterarDataLanctoDepCheques(QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString), qryTabela.FieldByName('CTB_DTALAN').AsDateTime);

             pAlterarDataLanctoCartoes(QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString), qryTabela.FieldByName('CTB_DTALAN').AsDateTime);
          End;

        End;

        untLogCba.pGravaLogCba(qryTabela.FieldByName('CTB_SEQLAN').AsString, SMensagemLog, self.Name);
        pGeraLogLiberacao(qryTabela.FieldByName('CTB_SEQLAN').AsString,'',VS_strCodEmp);
        mskCompet.Enabled := False;

        If blnGeraCreditoCaixa Then
        Begin
          //GERAR CRÉDITO CAIXA
          IF not fEmptyStr( fRetNomeOperador(strCodOpe) ) THEN
          BEGIN
            if fGravaCadRcx(strSeqRcx,
                            '',                         // Cliente
                            strCodOpe,                  // Operador
                            '',                         // Documento
                            'LC',                       // Espécie
                            VS_strCodEmp,               // Empresa
                            dbeDtaLan.Field.AsDateTime, // Data de Cadastro
                            fTime(),                    // Hora de Cadastro
                            '',                         // Duplicata
                            '',                         // Parcela
                            'REF. TRANSFERÊNCIA',       // Descrição
                            '',                         // Juros / Desconto
                            '',                         // Identificação de Fechamento
                            '',                         // Forma de Pagamento
                            dbeValLan.Field.AsFloat,    // Valor do Documento
                            0.0,                        // Valor do Desconto
                            0.0,                        // Valor do Juros
                            dbeValLan.Field.AsFloat,    // Dinheiro recebido
                            0.0,                        // Cheque a vista
                            0.0,                        // Cheque pre datado
                            0.0,                        // Valor em Cartã
                            0.0,                        // Valor em Ordem de Pagamento
                            0.0,                        // Valor do Crédito
                            0.0,                        // Valor em Financiamento
                            0.0,                        // Valor de outros
                            0.0,                        // Venda a prazo
                            '',                         // Num. do Romaneio
                            StrToInt(fRetRcxCon),       // Sequencial de Controle
                            0,                          // Sequencial de Baixa (Duplicata)
                            fCfgSisL('SQFCRX'),         // Sequencial de Fechamento parcial de caixa
                            '',                         // Empresa da Duplicata
                            '',                         // MotDes
                            2,                          // Identificação do Caixa
                            0,
                            0,
                            0,
                            0,
                            0,
                            'N',
                            '',
                            edtCodigoCaixa.Text) then
            begin
              fCommit;
            end
            else
            begin
              qryTabela.Delete;
              fraPlanoDeContasCon.edtDesCta.Clear;
              edtNomPor2.Clear;
              fraCentroCusto.edtDesEve.Clear;
              fraPlanoDeContas.edtDesCta.Clear;
              edtNomPor.Clear;
              fRollBack;
            end;
          end
          else
            fRollback;
        End
        Else
        Begin
          //GRAVA CONTRA PARTIDA
          If (TWinControl(Sender).Name = 'btnGravar') And
             (Not fEmptyStr(edtPortadorCaixa.Text)) And
             (Not fEmptyStr(fraPlanoDeContasCon.MskCodCta.Text)) And
             (AGravaContraPartida) Then
          begin

            Try
              If LEmpresaContraPartida.Trim.IsEmpty Then
                LEmpresaContraPartida := IIF(qryTabela.FieldByName('CTB_EMPTRA').AsString.Trim.IsEmpty,
                                             qryTabela.FieldByName('CTB_CODEMP').AsString,
                                             qryTabela.FieldByName('CTB_EMPTRA').AsString);

              SSequenciaLancamentoContraPartida :=
                fGravaMovBan(fraPlanoDeContasCon.MskCodCta.Text,
                            edtPortadorCaixa.Text,
                            strLoginUsuarioLogado,
                            qryTabela.FieldByName('CTB_DTALAN').AsDateTime,
                            qryTabela.FieldByName('CTB_HORLAN').AsDateTime,
                            qryTabela.FieldByName('CTB_NUMDOC').AsString,
                            IIF(qryTabela.FieldByName('CTB_CREDEB').AsString = 'C', 'D', 'C'),
                            LEmpresaContraPartida,
                            qryTabela.FieldByName('CTB_VALLAN').AsFloat,
                            qryTabela.FieldByName('CTB_HIST01').AsString,
                            edtNomPor.Text,
                            qryTabela.FieldByName('CTB_CODCLI').AsString,
                            qryTabela.FieldByName('CTB_CODFOR').AsString,
                            qryTabela.FieldByName('CTB_NUMDOC').AsString,
                            qryTabela.FieldByName('CTB_SEQBAI').AsInteger,
                            qryTabela.FieldByName('CTB_PARCEL').AsString,
                            qryTabela.FieldByName('CTB_EMPDUP').AsString,
                            qryTabela.FieldByName('CTB_SERIE_').AsString,
                            qryTabela.FieldByName('CTB_CODEVE').AsString,
                            '', //strDocBai: String;
                            Nil, // Log Bancário
                            0, //intSeqTrf: Integer = 0; Sequencial de Transferencia de Caixa
                            0, //intSeqCon: Integer = 0;
                            '', //strCompet: String = ''
                            strSeqPar,
                            '',
                            '',
                            '',
                            '',
                            fGerarMovimentoBancario,
                            True,
                            Nil,
                            IIF(edtCodigoEmpresa.Text <> '', qryTabela.FieldByName('CTB_CODEMP').AsString, ''));

              If Not fEmptyStr(SSequenciaLancamentoContraPartida) Then
              Begin
                //Gravando log da contra-partida (Transferência de valores)
                untLogCba.pGravaLogCba(SSequenciaLancamentoContraPartida, SMensagemLog, self.Name);
                FCommit;
              End
              Else
              Begin
                fRollBack;
              End;

              gpbContraPartida.Enabled := False;
              fraPlanoDeContasCon.MskCodCta.Enabled        := False;
            Except
              On E: Exception Do
              Begin
                fRollBack;

                pMensagensErro('Ocorreu um erro ao gravar o lançamento de contra partida.' + #13 +
                               'Erro gerado: ' + E.Message, '[TfrmCadMovBancario.btnGravarClick]');

                Exit;
              End;
            End;
            fraPlanoDeContasCon.MskCodCta.Enabled        := False;
            fraPlanoDeContasCon.MskCodCta.Enabled := False;
          end
          ELSE
            FCommit;
        End;

        dtaDtaLan := 0;

        if fEmptyStr(edtPortadorCaixa.Text) then
        begin
          Self.height := ATamanhoInicial;
          edtPortadorCaixa.Clear;
          fraPlanoDeContasCon.MskCodCta.Clear;
          lblPorRes.Visible := False;
        end;

        if blnIniciaCadastro then
        begin
          if (blnConcilLoc) and (blnInserindo) Then
          begin
            repMovBan := TMovBanRepository.Create;
            objListaMovBan :=  repMovBan.fRetDocumentos(0, qryTabela.FieldByName('CTB_CODEMP').AsString, qryTabela.FieldByName('CTB_SEQLAN').AsString);

            If Assigned(objListaMovBan) Then
            Begin
              If objListaMovBan.Count > 0 Then
              Begin
                For objMovBan in objListaMovBan Do
                  untLogCba.GravaLogCba(objMovBan.strAutInc, 'CONCILIOU LANÇAMENTO', self.Name);
              End;
            End;

            FreeAndNil(repMovBan);
          end;

          SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
          arrSeqLanLoc[Length(arrSeqLanLoc)-1] := qryTabela.FieldByName('CTB_SEQLAN').AsString;
          btnSair.Click;
          Exit;
        end;

        //GRAVANCO LOGLIB SE TIVER ALTERAÇÃO DE DATA DE LANÇAMENTO PARA ORIGEM CTR OU CTP
        If blnLiberouData Then
          blnLiberouData := False;
      End
      else
        fRollback;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        PMensagensErro(E.Message, '[TfrmCadMovBancario.btnGravarClick]');
      End;
    End;
  end;
  pHabilitaDesabilitaBotoes;

  btnAlterarPortador.Enabled := False;
end;

procedure TfrmCadMovBancario.ExibeCamposCaixa(AVisivel: Boolean = True);
begin
  lblCaixa.Visible := AVisivel;
  edtCodigoCaixa.Visible := AVisivel;
  edtDescricaoCaixa.Visible := AVisivel;
end;

procedure TfrmCadMovBancario.ExibeEmpresaContraPartida;
begin
  pnlEmpresaContraPartida.Visible := Not fEmptyStr(edtCodigoEmpresa.Text);

  If Not pnlEmpresaContraPartida.Visible Then
    pnlEmpresaContraPartida.Visible := (strTipMov = 'TE');

  If pnlEmpresaContraPartida.Visible Then
    pnlEmpresaContraPartida.Visible := Not lblPorRes.Visible;

  If objResumoDeCaixa.strTipoFechamento <> 'C' Then
  Begin
    ATamanhoContraPartida := 436;

    lblPorRes.Top := 66;
    gpbContraPartida.Height := 83;
    chkGerCon.Top := 66;

    If pnlEmpresaContraPartida.Visible Then
    Begin
      ATamanhoContraPartida := 443;

      lblPorRes.Top := 89;
      gpbContraPartida.Height := 106;
      chkGerCon.Top := 87;
    End;
  End;

  Self.Height := ATamanhoContraPartida;
end;

procedure TfrmCadMovBancario.btnHistMovBanClick(Sender: TObject);
  Var
    frmRelCbaLogAcompMovBanNovo: TfrmRelCbaLogAcompMovBanNovo;
begin
  inherited;
  If (qryTabela.IsEmpty) Or (fEmptyStr(dbeSeqLan.Text))Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelCbaLogAcompMovBanNovo, frmRelCbaLogAcompMovBanNovo);
    frmRelCbaLogAcompMovBanNovo.edtNumSeq.Text        := qryTabela.FieldByName('CTB_SEQLAN').AsString;
    frmRelCbaLogAcompMovBanNovo.blnVeioMovimentacao   := True;
    frmRelCbaLogAcompMovBanNovo.pCarregaCampos;
    //frmRelCbaLogAcompMovBanNovo.btnPadraoClick(Sender);

    if frmRelCbaLogAcompMovBanNovo.qryConsulta.IsEmpty then
      fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k'])
    else
      frmRelCbaLogAcompMovBanNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[frmRelCbaLogAcompMovBanNovo.btnHistMovBan]');
  End;
  pFreeAndNil(frmRelCbaLogAcompMovBanNovo);

end;

procedure TfrmCadMovBancario.btnHistMovBanMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint;
end;

procedure TfrmCadMovBancario.btnHistMovBanMouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

function TfrmCadMovBancario.fAtualizaContraPartida(strSeqCtp, strSeqLan, strCodEmp, strCreDeb: String; fltValor: Double; dteDtalan, ADtaLanSemAlterar: TDateTime; intGerCon: Integer): Boolean;
Var
    objMov: TMovBan;
    repMovBan: TMovBanRepository;
Begin
  Result := True;

  If fEmptyStr(strSeqCtp) Or fEmptyStr(strSeqLan) Or fEmptyStr(strCodEmp) Or (dteDtalan = null) Then
    Exit;

  Try
    repMovBan := TMovBanRepository.Create;
    objMov    := repMovBan.fRetContraPartida(strSeqCtp, strSeqLan, strCodEmp, ADtaLanSemAlterar);

    If Assigned(objMov) Then
    Begin
      If (objMov.fltValLan <> fltValor) Or (strCreDeb = objMov.strCreDeb) Or (objMov.dtaDtaLan <> dteDtalan) Then
      Begin
        if objMov.dtaDtaCon <> SNull then
        begin
          Result := False;
          fRollBack;
          fMensagem('ATENÇÃO', 'O lançamento de contra partida está conciliado! ' + #13#10 + ' Não é possível alterar o valor ou o tipo desse lançamento! ', ['&O K']);
          Exit;
        end;

        If strCreDeb = 'D' Then
          objMov.strCreDeb := 'C'
        Else
          objMov.strCreDeb := 'D';

        objMov.dtaDtaLan := dteDtalan;
        objMov.fltValLan := fltValor;
        objMov.intGerCon := intGerCon;
        repMovBan.pAtualizar;

        If (dteDtalan <> StrToDate(strDtaLanAnterior)) Then
        Begin
          pAlterarDataLanctoCadRec(QuotedStr(objMov.strAutInc), dteDtalan);

          pAlterarDataLanctoTF_OP_CadRec(QuotedStr(objMov.strAutInc), dteDtalan);

          pAlterarDataLanctoAdiantamento(QuotedStr(objMov.strAutInc), dteDtalan);

          pAlterarDataLanctoDepCheques(QuotedStr(objMov.strAutInc), dteDtalan);

          pAlterarDataLanctoCartoes(QuotedStr(objMov.strAutInc), dteDtalan);
        End;

        untLogCba.GravaLogCba(objMov.strAutInc, 'ALTERACAO', self.Name);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, 'Erro na geração da contra partida!');
    End;
  End;

  FreeAndNil(repMovBan);
End;

function TfrmCadMovBancario.fBuscaOrigemLancamento(strSeqLan: String): Boolean;
Var
  qryMovBan : TUniQuery;
  strSql: String;
begin
  Try
    Result := False;
    qryMovBan := fCriaQuery(Nil);

    Try
      strSql := '';
      strSql := strSql + ' SELECT *             ';
      strSql := strSql + ' FROM LOGCBA          ';
      strSql := strSql + ' WHERE                ';
      strSql := strSql + ' CTB_SEQLAN =:SEQLAN  ';

      With qryMovBan Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQLAN').AsString := strSeqLan;
        Open;
        If Not isEmpty Then
        Begin
          Result := True;
        End;
      End;
    Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelCbaLogAcompMovBanNovo.fBuscaOrigemLancamento]');
    End;
  Finally
   pFreeAndNil(qryMovBan);
  End;
end;

function TfrmCadMovBancario.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;

  untLogCba.GravaLogCba(qryTabela.FieldByName('AUTOINCREM').AsString,
                        'EXCLUSAO',
                        Self.Name);
end;

procedure TfrmCadMovBancario.edtPortadorCaixaChange(Sender: TObject);
begin
  inherited;

  If (Trim(edtPortadorCaixa.Text) <> '') Then
    fraPlanoDeContasCon.MskCodCta.Enabled := True
  Else
    fraPlanoDeContasCon.MskCodCta.Enabled := False;

  chkGerCon.Enabled := fraPlanoDeContasCon.MskCodCta.Enabled;
end;

procedure TfrmCadMovBancario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End
    Else
    Begin
      SelectNext(ActiveControl, False, True);
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
      SelectNext(ActiveControl, True, True);
  End;
end;

{**********************************************}
{* VALIDA SE A DATA DE LANÇAMENTO É RETROATIVA*}
{*******************************************RL*}
procedure TfrmCadMovBancario.edtPortadorCaixaExit(Sender: TObject);
begin
  inherited;

  If Trim(edtPortadorCaixa.Text) = '' Then
    edtNomPor2.Clear;
end;

{*************************************}
{* CHAMA NOVA CONSULTA DE PORTADORES *}
{**********************************JU*}
procedure TfrmCadMovBancario.edtPortadorCaixaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;

begin
  inherited;

  if fPesqPortador(conSimples,
                   Self,
                   edtPortadorCaixa,
                   edtNomPor2,
                   nil,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   dbeCodEmp.Field.Text)  then
  Begin
    If fValidaCampos(edtPortadorCaixa, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMovBancario.edtCodigoCaixaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCaixa: TConsultasArray;
begin
  inherited;
  If fPesqCaixas(Self, edtCodigoCaixa, edtDescricaoCaixa, Nil, Key, arrCaixa, True, VS_strCodEmp, True) Then
  Begin
    If fValidaCampos(edtCodigoCaixa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovBancario.edtCodigoEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodigoEmpresa, edtDescricaoEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodigoEmpresa) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadMovBancario.fGerarMovimentoBancario: Integer;
begin
  Result := 1;

  if not gpbContraPartida.Visible then
    Exit;

  if not chkGerCon.Visible then
    exit;

  Result := IIF(chkGerCon.Checked, 1, 0);
end;

{**************************}
{* CARREGA SQL PGETMOVBAN *}
{*RQ - 31697************BB*}
function TfrmCadMovBancario.fGetSql : String;
begin
  Result := '';
  Result := Result + ' SELECT * FROM ' + strNomeTabela + ' WHERE TRUE ';
  Result := Result + ' AND CTB_SEQLAN = ' + QuotedStr(strSeqLan);
  Result := Result + ' AND CTB_CODPOR = ' + QuotedStr(strCodPor);
  Result := Result + ' AND CTB_CODCTA = ' + QuotedStr(strCodCta);
end;

function TfrmCadMovBancario.fLiberacaoParaExclusao: Boolean;
var
  qryVerif : TUniQuery;
begin
  Result := True;

  qryVerif := fCriaQuery(Self);
  Try
    qryVerif.SQL.Text := ' SELECT COUNT(*) AS QTD ' +
                         '   FROM MOVBAN M ' +
                         '   JOIN CADRCXX X ON X.RCX_SEQCON = M.CTB_SEQTRF ' +
                         '                 AND X.RCX_CODEMP = M.CTB_CODEMP ' +
                         '  WHERE M.AUTOINCREM = :AUTOINCREM ' +
                         '    AND IFNULL(M.CTB_SEQTRF, 0) > 0 ' +
                         '    AND IFNULL(X.RCX_ORDREC, 0) <> 0 ';
    qryVerif.ParamByName('AUTOINCREM').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryVerif.Open;

    If (Not qryVerif.IsEmpty) And (qryVerif.FieldByName('QTD').AsInteger > 0) Then
    Begin
      fMensagem('ATENÇÃO',
        'Não é permitido excluir este lançamento bancário.' + #13#10 +
        'Ele está vinculado ao recebimento de uma Ordem de Pagamento.' + #13#10 +
        'Para desfazer esta operação, utilize o Estorno na rotina de Caixa.',
        ['&O K']);
      Result := False;
      Exit;
    End;

    If Not fVerificaAcessoSistema('EXCLUIRMOVBAN', strLoginUsuarioLogado) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.strDirAce := 'EXCLUIRMOVBAN';
      objLiberacao.objMsgLibera.pAddTexto('***  EXCLUSÃO DA MOVIMENTAÇÃO BANCÁRIA  ***', alCentro, teAmbos, '', 118);
      objLiberacao.objMsgLibera.pAddSeparador(118);
      objLiberacao.objMsgLibera.pAddTexto('Atenção! É de extrema responsabilidade da empresa permitir a exclusão da movimentação bancária.');
      objLiberacao.objMsgLibera.pAddSeparador(118);
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTextoCaption('Sequêncial'         , qryTabela.FieldByName('CTB_SEQLAN').AsString                           , 19);
      objLiberacao.objMsgLibera.pAddTextoCaption('Data de Lançamento' , qryTabela.FieldByName('CTB_DTALAN').AsString                           , 19);
      objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'            , qryTabela.FieldByName('CTB_CODEMP').AsString +' - '+ fRetNomeEmpresa(qryTabela.FieldByName('CTB_CODEMP').AsString) , 19);
      objLiberacao.objMsgLibera.pAddTextoCaption('Portador'           , qryTabela.FieldByName('CTB_CODPOR').AsString +' - '+ fRetNomPortador(qryTabela.FieldByName('CTB_CODPOR').AsString) , 19);
      objLiberacao.objMsgLibera.pAddTextoCaption('Tipo do Lançamento' , IIF((qryTabela.FieldByName('CTB_CREDEB').AsString = 'C'),'Crédito','Débito')                          , 19);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor'              , 'R$'+FormatFloat('#,###,##0.00',  qryTabela.FieldByName('CTB_VALLAN').AsFloat )                          , 19);

      objLiberacao.strMsgSen := 'Exclusão da movimentação bancária.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;
      objLiberacao.pInformaNumDocEspDocCodEmp(
                        qryTabela.FieldByName('CTB_NUMDUP').AsString,
                        EmptyStr,
                        qryTabela.FieldByName('CTB_CODEMP').AsString);

      Result := objLiberacao.fLibera;
    End;

  Finally
    FreeAndNil(qryVerif);
  End;
end;

function TfrmCadMovBancario.fLoadReport: Boolean;
  Var
   mmsLoad: TStream;
   qryLayImp: TUniQuery;
Begin
  Result := False;

  qryLayImp := fCriaQuery(nil);

  Try
    With qryLayImp, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT * FROM ');
      Add('  LAYIMP');
      Add('WHERE');
      Add('  LAY_TIPLAY = :TIPLAY AND  ');
      Add('  LAY_CODEMP = :CODEMP AND  ');
      Add('  LAY_CODLAY = :CODLAY      ');

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODLAY').AsString := 'COMPMV';

      ParamByName('TIPLAY').AsString := 'L';

      Add('ORDER BY');
      Add('  LAY_DTAALT DESC,');
      Add('  LAY_HORALT DESC ');
      Add('LIMIT 1');
      Open;

      If Not IsEmpty Then
      Begin
        Try
          Result := True;
          mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);

          frxComprovanteMov.LoadFromStream(mmsLoad);
          frxComprovanteMov.Variables.Clear;
        Finally
          pFreeAndNil(mmsLoad);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

  pFreeAndNil(qryLayImp);
end;

{*********************************************}
{* CARREGA REGISTRO DO MOVBAN EM TELA QUANDO *}
{** CHAMADO PELA TELA CONCILIAÇÃO BANCÁRIA ***}
{*RQ - 31697*******************************BB*}
procedure TfrmCadMovBancario.pGetMovBan;
begin
  Try
    if Assigned(qryTabela) then
    begin
      with qryTabela do
      Begin
        Close;
        Sql.Clear;
        Sql.Text := fGetSql;
        Open;

        if not(isEmpty) then
        begin
          pCarregaPortador(dbeCodPor);
          pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta);
          pCarregaEventos;

          If btnAlterar.Visible And btnAlterar.Enabled Then
            pSetFocus(btnAlterar);
        end
        Else
          pMensagemOk('Não foi possível Encontrar a Movimentação de Conta Banco.');

      End;
    end;
  Except
    On E: Exception Do
    begin
      pMensagemOk('Não foi possível Carregar a Movimentação de Conta Banco.' + #13#10 + E.Message);
    end;
  End;
end;

procedure TfrmCadMovBancario.pCarregaCompetencia;
begin
  mskCompet.Enabled := False;

  if (qryTabela.State = dsInsert) or (qryTabela.State = dsEdit) then
      mskCompet.Enabled := True;

  if FEmptyStr(qryTabela.FieldByName('CTB_COMPET').AsString) then
  begin
    mskCompet.Text := '';

    if (qryTabela.State = dsInsert) then
    begin
      mskCompet.Text := FormatDateTime('mm/YYYY', fNow());
    end;
  end
  else
    mskCompet.Text := qryTabela.FieldByName('CTB_COMPET').AsString;
end;

procedure TfrmCadMovBancario.pAfterScroll(DataSet: TDataSet);
begin
  pCarregaCompetencia;
end;

procedure TfrmCadMovBancario.pHabilitaDesabilitaBotoes;
begin
  If (qryTabela.Active) And Not(qryTabela.IsEmpty) Then
  Begin
    btnAbrirPastaAnexos.Enabled := Not(qryTabela.State = dsInsert);
    btnImprimir.Enabled := Not(qryTabela.State = dsInsert);
    If Not (fEmptyStr(dbeSeqLan.Text)) Then
    Begin
      btnHistMovBan.Enabled := fBuscaOrigemLancamento(dbeSeqLan.Text);
    End
    Else
      btnHistMovBan.Enabled := False;

    btnHistMovBan.Enabled := (fVerificaAcessoSistema('frmRelCbaLogAcompMovBanNovo'));

    If fCfgSis('USAAUT', varBoolean) Then
    Begin
      If qryTabela.FieldByName('CTB_TRFLIB').AsString = 'N' Then
      Begin
        btnAlterar.Enabled := False;
        btnExcluir.Enabled := False;

        fMensagem('ATENÇÃO', 'Não é possível alterar o registro pois não foi feita sua liberação.', ['&Ok']);
      End;
    End;
  End;
end;

procedure TfrmCadMovBancario.pAlterarDataLanctoDepCheques(AAutoIncremList: String;
  ADataAlterada: TDateTime);
Var
  qryMovBan : TUniQuery;
  qryAltChq : TUniQuery;
  qryCheques : TUniQuery;
begin
  qryMovBan := fCriaQuery(Self);
  qryAltChq := fCriaQuery(Self);
  qryCheques := fCriaQuery(Self);

  Try
      qryMovBan.Close;
      qryMovBan.SQL.Clear;
      qryMovBan.SQL.Add('SELECT ');
      qryMovBan.SQL.Add('  B.CTB_SEQLAN, ');
      qryMovBan.SQL.Add('  M.CTB_SEQDEP, ');
      qryMovBan.SQL.Add('  M.CTB_CODEMP  ');
      qryMovBan.SQL.Add(' FROM MOVBAN M  ');
      qryMovBan.SQL.Add('   JOIN BANCHQ B ON M.CTB_SEQLAN = B.CTB_SEQLAN ');
      qryMovBan.SQL.Add(' WHERE M.AUTOINCREM IN ('+ AAutoIncremList + ') ');
      qryMovBan.Open;

      If (Not qryMovBan.IsEmpty) Then
      Begin

        qryCheques.Close;
        qryCheques.SQL.Clear;
        qryCheques.SQL.Add('SELECT ');
        qryCheques.SQL.Add('  AUTOINCREM, ');
        qryCheques.SQL.Add('  CHQ_SEQDP1, ');
        qryCheques.SQL.Add('  CHQ_SEQDP2  ');
        qryCheques.SQL.Add(' FROM CADCHQ  ');
        qryCheques.SQL.Add('  WHERE CHQ_SEQDP1 = :SEQLAN ');
        qryCheques.SQL.Add(' UNION ALL ');
        qryCheques.SQL.Add(' SELECT ');
        qryCheques.SQL.Add('  AUTOINCREM, ');
        qryCheques.SQL.Add('  CHQ_SEQDP1, ');
        qryCheques.SQL.Add('  CHQ_SEQDP2  ');
        qryCheques.SQL.Add(' FROM CADCHQ  ');
        qryCheques.SQL.Add('  WHERE CHQ_SEQDP2 = :SEQLAN ');
        qryCheques.ParamByName('SEQLAN').AsString := qryMovBan.FieldByName('CTB_SEQLAN').AsString;
        qryCheques.Open;

        If (Not qryCheques.IsEmpty) Then
        Begin

           qryCheques.First;
           While Not qryCheques.eof Do
           Begin
             qryAltChq.Close;
             qryAltChq.SQL.Clear;
             qryAltChq.SQL.Add(' UPDATE CADCHQ ');

             If qryCheques.FieldByName('CHQ_SEQDP2').AsString = qryMovBan.FieldByName('CTB_SEQLAN').AsString Then
                qryAltChq.SQL.Add(' SET CHQ_DTABA2 = :DTABAN ')
             Else
             If qryCheques.FieldByName('CHQ_SEQDP1').AsString = qryMovBan.FieldByName('CTB_SEQLAN').AsString Then
                qryAltChq.SQL.Add(' SET CHQ_DTABA1 = :DTABAN ');

             qryAltChq.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
             qryAltChq.ParamByName('DTABAN').AsDateTime := ADataAlterada;
             qryAltChq.ParamByName('AUTOIN').AsString   := qryCheques.FieldByName('AUTOINCREM').AsString;
             qryAltChq.ExecSQL;

             qryCheques.Next;
           End;

        End;

    End;

    If Assigned(qryMovBan) Then
       FreeAndNil(qryMovBan);

    If Assigned(qryAltChq) Then
       FreeAndNil(qryAltChq);

    If Assigned(qryCheques) Then
       FreeAndNil(qryCheques);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmCadMovBancario.pAlterarDataLanctoDepCheques] ' +E.Message);
    End;
  End;
end;

procedure TfrmCadMovBancario.pAlterarDataLanctoCartoes(AAutoIncremList: String;
  ADataAlterada: TDateTime);
Var
  qryMovBan : TUniQuery;
  qryAltCrt : TUniQuery;
begin
  qryMovBan := fCriaQuery(Self);
  qryAltCrt := fCriaQuery(Self);

  Try
    qryMovBan.Close;
    qryMovBan.SQL.Clear;
    qryMovBan.SQL.Add('SELECT ');
    qryMovBan.SQL.Add('  B.CTB_SEQLAN, ');
    qryMovBan.SQL.Add('  B.MCA_CODEMP, B.MCA_CODCLI, B.MCA_NUMDUP, B.MCA_PARCEL ');
    qryMovBan.SQL.Add(' FROM MOVBAN M  ');
    qryMovBan.SQL.Add('   JOIN BANMCA B ON M.CTB_SEQLAN = B.CTB_SEQLAN ');
    qryMovBan.SQL.Add(' WHERE M.AUTOINCREM IN ('+ AAutoIncremList + ') ');
    qryMovBan.Open;

    If (Not qryMovBan.IsEmpty) Then
    Begin
      qryMovBan.First;

      While Not qryMovBan.Eof Do
      Begin
        qryAltCrt.Close;
        qryAltCrt.SQL.Clear;
        qryAltCrt.SQL.Add(' UPDATE MOVCAR ');
        qryAltCrt.SQL.Add('  SET MCA_DTABAN = :DTABAN ');
        qryAltCrt.SQL.Add('  WHERE ');
        qryAltCrt.SQL.Add('        MCA_CODEMP = :CODEMP ');
        qryAltCrt.SQL.Add('    AND MCA_CODCLI = :CODCLI ');
        qryAltCrt.SQL.Add('    AND MCA_NUMDUP = :NUMDUP ');
        qryAltCrt.SQL.Add('    AND MCA_PARCEL = :PARCEL ');
        qryAltCrt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
        qryAltCrt.ParamByName('CODEMP').AsString   := qryMovBan.FieldByName('MCA_CODEMP').AsString;
        qryAltCrt.ParamByName('CODCLI').AsString   := qryMovBan.FieldByName('MCA_CODCLI').AsString;
        qryAltCrt.ParamByName('NUMDUP').AsString   := qryMovBan.FieldByName('MCA_NUMDUP').AsString;
        qryAltCrt.ParamByName('PARCEL').AsString   := qryMovBan.FieldByName('MCA_PARCEL').AsString;
        qryAltCrt.ExecSQL;

        qryMovBan.Next;
      End;

    End;

    If Assigned(qryMovBan) Then
       FreeAndNil(qryMovBan);

    If Assigned(qryAltCrt) Then
       FreeAndNil(qryAltCrt);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmCadMovBancario.pAlterarDataLanctoCartoes] ' +E.Message);
    End;
  End;
end;

function TfrmCadMovBancario.fBloquearExclusaoMovBanComOrigem(AAutoinc: String; out AMensagem: String): Boolean;
var
  LPreMensagem: String;
begin
  AMensagem := '';
  Result := fLancamentoPossuiOrigem(AAutoinc);

  If Not Result Then
    Exit;

  LPreMensagem := 'Exclusão não permitida! Este lançamento tem origem ['+ qryTabela.FieldByName('CTB_ORIGEM').AsString +']. ';

  AMensagem :=  LPreMensagem + #13#10 + 'Só serão permitidas exclusões de registros que não possuem origem vinculada.';

  If fCfgSis('UTICON', varBoolean) Then
    Exit;

  If Not fCfgSis('EXCLOR', varBoolean) Then
    Exit;

  AMensagem := '';

  If fVerificaAcessoSistema('EXCLUIRMOVBANCOMORIGEM', strLoginUsuarioLogado) Then
    Exit(False);

  Try
    objLiberacao.Clear;

    objLiberacao.strDirAce := 'EXCLUIRMOVBANCOMORIGEM';
    objLiberacao.objMsgLibera.pAddTexto('***  PERMITIR EXCLUIR REGISTROS DE MOVIMENTAÇÃO BANCÁRIA COM ORIGEM  ***', alCentro, teAmbos, '', 118);
    objLiberacao.objMsgLibera.pAddSeparador(118);
    objLiberacao.objMsgLibera.pAddTexto('Atenção! É de extrema responsabilidade da empresa permitir a exclusão da movimentação bancária com origem.');
    objLiberacao.objMsgLibera.pAddSeparador(118);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Sequêncial'         , qryTabela.FieldByName('CTB_SEQLAN').AsString                           , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Data de Lançamento' , qryTabela.FieldByName('CTB_DTALAN').AsString                           , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'            , qryTabela.FieldByName('CTB_CODEMP').AsString +' - '+ fRetNomeEmpresa(qryTabela.FieldByName('CTB_CODEMP').AsString) , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Portador'           , qryTabela.FieldByName('CTB_CODPOR').AsString +' - '+ fRetNomPortador(qryTabela.FieldByName('CTB_CODPOR').AsString) , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Tipo do Lançamento' , IIF((qryTabela.FieldByName('CTB_CREDEB').AsString = 'C'),'Crédito','Débito')                          , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor'              , 'R$'+FormatFloat('#,###,##0.00',  qryTabela.FieldByName('CTB_VALLAN').AsFloat )                          , 19);
    objLiberacao.objMsgLibera.pAddTextoCaption('Origem'              , qryTabela.FieldByName('CTB_ORIGEM').AsString                          , 19);

    objLiberacao.strMsgSen := 'Permitir excluir lançamentos com origem.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.pInformaNumDocEspDocCodEmp(qryTabela.FieldByName('CTB_NUMDUP').AsString,
                                            EmptyStr,
                                            qryTabela.FieldByName('CTB_CODEMP').AsString);
    Result := Not objLiberacao.fLibera;

    If Result Then
      AMensagem := LPreMensagem + #13#10 + 'Operador não possui permissão para excluir registros com origem vinculada.';
  Finally
    objLiberacao.Clear;
  End;
end;

function TfrmCadMovBancario.fLancamentoPossuiOrigem(AAutoinc: String): Boolean;
var
  LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Result := False;
  Try
    LConsulta := fCriaQuery;
    Try
      LConsulta.SQL.Text := ' SELECT CTB_ORIGEM FROM MOVBAN WHERE AUTOINCREM = :AUTINC '+
                             ' AND IFNULL(CTB_ORIGEM, '''') <> '''' ';
      LConsulta.ParamByName('AUTINC').AsString := AAutoinc;
      LConsulta.Open;

      Result := Not LConsulta.IsEmpty;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[frmCadMovBancario.fLancamentoPossuiOrigem]');
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

end.


