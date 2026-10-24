{***************************}
{* qryConCli -> CADCLI     *}
{* qryConEmp -> CADEMP     *}
{************************JB*}
unit untImpBoletoIndiv;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Messages, Dialogs, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask, Uni,
  MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls, DB, untTypesSistema,
  Menus,  untfuncoesSimples, StrUtils, Printers, QColorLabel, AppEvnts,
  MemoFocus, UniClientDataSet, UniDataSetProvider, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, cxCheckBox,
  BitBtnLockedIncrem, dxCore, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, untGravando,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untMsgLiberacao,
  cxContainer, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxProgressBar,
  untTLock,untBaixaBusca,untTProrrogacaoDeTitulos;

type
  TfrmImpBoletoIndiv = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    pnlBotoesBaixa: TPanel;
    pnlAux2: TPanel;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    Label8: TLabel;
    edtNomCli: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodPorBai: TEditFocus;
    edtNomPorBai: TEditFocus;
    edtNosNum: TEditFocus;
    edtObsAg1: TEditFocus;
    edtObsAg2: TEditFocus;
    edtObsAg3: TEditFocus;
    Label9: TLabel;
    edtFiltro: TEditFocus;
    ColorLabel1: TColorLabel;
    edtHistor: TMemoFocus;
    Label11: TLabel;
    edtNomeBanco: TEditFocus;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    cxgDuplicatas: TcxGrid;
    cxgDuplicatasDados: TcxGridDBTableView;
    cxgDuplicatasNivel: TcxGridLevel;
    cxgDuplicatasCTR_NUMDUP: TcxGridDBColumn;
    cxgDuplicatasCTR_ESPDOC: TcxGridDBColumn;
    cxgDuplicatasCTR_CODEMP: TcxGridDBColumn;
    cxgDuplicatasCTR_CODCLI: TcxGridDBColumn;
    cxgDuplicatasCTR_DTACAD: TcxGridDBColumn;
    cxgDuplicatasCTR_DTAVEN: TcxGridDBColumn;
    cxgDuplicatasCTR_BOLETO: TcxGridDBColumn;
    cxgDuplicatasCTR_VALDUP: TcxGridDBColumn;
    pnlTotais: TPanel;
    Label6: TLabel;
    Label21: TLabel;
    edtTotalDuplicatas: TEditFocus;
    edtQtdSelecionadas: TEditFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxsSelecionado: TcxStyle;
    cxgDuplicatasCTR_MARDES: TcxGridDBColumn;
    rdgBoletos: TRadioGroup;
    cxgDuplicatasCLI_NOMCLI: TcxGridDBColumn;
    Label5: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    Label13: TLabel;
    edtEnvBol: TEditFocus;
    ColorLabel2: TColorLabel;
    lbl2: TLabel;
    edtEspDoc: TEditFocus;
    Label15: TLabel;
    edtTotalSelecionadas: TEditFocus;
    btnSelTodos: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    shpEmp: TShape;
    edtCartei: TEditFocus;
    lblCartei: TLabel;
    edtPerMul: TEditFocus;
    lblPerMul: TLabel;
    edtPerMor: TEditFocus;
    lblPerMor: TLabel;
    cxgDuplicatasCTR_VALCOR: TcxGridDBColumn;
    Label16: TLabel;
    edtTotalSelCor: TEditFocus;
    chkLimFil: TCheckBox;
    btnConsultar: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    spbAmpliar: TSpeedButton;
    FlwpnlBotoesBaixa: TFlowPanel;
    cxgDuplicatasCTR_DTAANT: TcxGridDBColumn;
    cxgDuplicatasCTR_JURALT: TcxGridDBColumn;
    cxgDuplicatasCTR_MULALT: TcxGridDBColumn;
    cxgDuplicatasCTR_CORANT: TcxGridDBColumn;
    rdgTipEmp: TRadioGroup;
    cxgDuplicatasCND_DESCRI: TcxGridDBColumn;
    cxgDuplicatasCTR_CODVEN: TcxGridDBColumn;
    cxgDuplicatasVENDEDOR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnSelTodosClick(Sender: TObject);
    procedure cxgDuplicatasDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDuplicatasDadosCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgDuplicatasDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDuplicatasCTR_BOLETOCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgDuplicatasDadosStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure cxgDuplicatasDadosDataControllerSortingChanged(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliChange(Sender: TObject);
    procedure rdgBoletosClick(Sender: TObject);
    procedure pBuscarIni;
    procedure pBuscarProx;
    procedure pOrdenaBoletos(cdsBoletos : TUniClientDataSet);
    procedure btnConsultarClick(Sender: TObject);
    procedure spbAmpliarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    frmBaixaBusca : TfrmBaixaBusca;
    qryGenGb1 : TUniQuery;
    qryConCli : TUniQuery;
    qryConEmp : TUniQuery;
    qryConPor : TUniQuery;
    fltTaxaJuros,
    fltTaxaMulta : Double;
    strValorFiltro : String;
    strCampoFiltro : String;
    strExtenso     : String;

    cpuCampos      : TCamposUso;

    strBoletoImpresso : String;

    blnImpressaoAutomatica : Boolean;
    blnImprimiuBoletos : Boolean;

    objMsg : TMensagemLiberacao;
    objLiberacao : TLiberacao;
    objLock : TLock;
    objProrrogacao : TProrrogacaoDeTitulos;
    blnReImprimeParcial : Boolean;

    {************************}
    { QRY GENERICA P\ CADREC }
    {*********************JB*}
    qryGenRec      : TUniQuery;
    qryGenRe2      : TUniQuery;

    FCodBco        : String;
    FValMor        : Double;
    FValDes        : Double;
    FCodPor        : String;
    FNosNum        : String;
    FValExt        : String;
    FValExt2       : String;
    FCodCar        : Integer;
    FBcoIni        : String;
    FMens01        : String;
    FMens02        : String;
    FCGCCLI        : String;
    FCEPCLI        : String;
    FDesCtr        : Double;
    FDtaAtu        : String;
    FPerMul        : String;
    FMulta_        : Double;
    FCodCli        : String;
    FNumDoc        : String;
    FEspDoc        : String;
    FEmpDoc        : String;
    FNomCli        : String;
    FEndCli        : String;
    FCidCli        : String;
    FEstCli        : String;
    FInsEst        : String;
    FUltPar        : String;
    strOrdCampo    : String;
    strOrdTipo     : String;
    FblnEhBoletoMeiaNota : Boolean;

    blnLiberado : Boolean;

    arrDupSel : TArrDupSel;

    function fVerificarSeOBoletoPodeSerEmitido(const strEspDoc: String): Boolean;
    procedure pAlterarFiltro;
    procedure pInicializaCamposUso;
    procedure pAtribuiCamposUso;
    procedure pFinalizaCamposUso;

    procedure pCarregaCliente;
    procedure pCarregaEmpresa;
    procedure pCarregaPortador;

    procedure pLimpaDados;
    procedure pMarcaDuplicata(blnMarcar: Boolean);

    procedure pCalculaTotalDuplicatas;
    procedure pStep(pgbStatus: TcxProgressBar);
    function  fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fReimpressaoBoleto:Integer;
    procedure pFormataCampos(DataSet: TDataSet);
    function fGeraListaBancosEnvio: TStringList;
    function fRetClientesBoleto: String;
    function fRetUltimaParcela(strCodCli, strCodEmp, strNumDup, strEspDoc: String): String;
    procedure pAdicionarDuplicataVencidaTrava;
    function fTravaDuplicatasVencidas: Boolean;
    function fLiberarDuplicatasVencidas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pCalculaValorCorrigido();
    function fAlteraVencimento(): Boolean;
    procedure CarregandoRegistros;
    procedure pRestauraVencimento();
    function fPesqSeqBai(strNumDup, strParcel, strEspDoc, strCodCli, strCodEmp: String): Boolean;
    function fInformacaoDesatualizada: Boolean;
    procedure pImprimindoBoletos;
    function fDuplicataTravada(strNumDup, strEspDoc, strCodEmp,
                               strCodCli, strParcel: String; blnMostraInfo: Boolean): Boolean;
    function fLiberaAlteracaoVencimento(): Boolean;
    function fLiberaImpressaoBaixaParcial(): Boolean;
    function fLiberaAlteracaoJurosMulta(): Boolean;
    function fRetornaHistProrrogacao(strNumDup,strParcel,strEspDoc,
                                     strCodEmp,strCodCli: String;intSeqBai : Integer): String;
    procedure fClienteTemCreditoDisponivel;
    procedure pOnShow;
  protected
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pSelecionaDuplicata(blnSelTodos: Boolean = False);

    {*****************************************}
    {* PROCEDURES ATRIBUIDAS AOS EVENTOS DO  *}
    {* cdsConsulta                           *}
    {**************************************MV*}
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

  published

    {*****************************************}
    {* PROPRIEDADES QUE SERÃO USADAS PARA A  *}
    {* IMPRESSÃO DO BOLETO                   *}
    {**************************************MV*}
    property strCodBco  : String  read FCodBco  write FCodBco;
    property fltValMor  : Double  read FValMor  write FValMor;
    property fltValDes  : Double  read FValDes  write FValDes;
    property strCodPor  : String  read FCodPor  write FCodPor;
    property strNosNum  : String  read FNosNum  write FNosNum;
    property strValExt  : String  read FValExt  write FValExt;
    property strValExt2 : String  read FValExt2 write FValExt2;
    property intCodCar  : Integer read FCodCar  write FCodCar;
    property strBcoIni  : String  read FBcoIni  write FBcoIni;
    property strMens01  : String  read FMens01  write FMens01;
    property strMens02  : String  read FMens02  write FMens02;
    property strCLICGC  : String  read FCGCCLI  write FCGCCLI;
    property strCLICEP  : String  read FCEPCLI  write FCEPCLI;
    property fltDesCtr  : Double  read FDesCtr  write FDesCtr;
    property strDtaAtu  : String  read FDtaAtu  write FDtaAtu;
    property strPerMul  : String  read FPerMul  write FPerMul;
    property fltMulta_  : Double  read FMulta_  write FMulta_;
    property strCodCli  : String  read FCodCli  write FCodCli;
    property strNumDoc  : String  read FNumDoc  write FNumDoc;
    property strEspDoc  : String  read FEspDoc  write FEspDoc;
    property strEmpDoc  : String  read FEmpDoc  write FEmpDoc;
    property strNomCli  : String  read FNomCli  write FNomCli;
    property strCidCli  : String  read FCidCli  write FCidCli;
    property strEstCli  : String  read FEstCli  write FEstCli;
    property strEndCli  : String  read FEndCli  write FEndCli;
    property strInsEst  : String  read FInsEst  write FInsEst;
    property strUltPar  : String  read FUltPar  write FUltPar;
    property blnEhBoletoMeiaNota : Boolean read FblnEhBoletoMeiaNota write FblnEhBoletoMeiaNota;

    class procedure pImprimirBoletos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; blnEhBoletoMeiaNota: Boolean = False);
  end;

implementation

uses
  untModulo,untFuncoes, untPesqAux, untPai, untFuncFat,
  untCadConfRelatorios, untConstantes,  untCnfBoleto, untValorPorExtenso,
  untConsultas, untImpEtiquetas, untBoleto, untFuncoesConsulta,
  untAlteraVencimento, untCadRec, untCfgRel,
  untMemo, untWaitWindow, untFuncoesRel, untFuncoesRel2;

{$R *.dfm}

{ TfrmImpBoletoIndiv }

function TfrmImpBoletoIndiv.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO CLIENTE            *}
    {**************************************MV*}
    If (Sender = edtCodCli) Then
    Begin

      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtNomCli.Text := 'TODOS';

    End
    Else If (Sender = edtCodEmp) Then
    Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DA EMPRESA            *}
    {**************************************MV*}
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtNomEmp.Text := 'TODAS';
      End
      Else
      Begin
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = edtFiltro) Then
    Begin

    {*******************************************}
    {* VALIDA O TIPO DE FILTRO                 *}
    {****************************************MV*}
      If (Pos(edtFiltro.Text, 'VC') <= 0) Then
      begin
        fMensagem('ATENÇÃO!', 'O filtro deve ser preenchido com V ou C!', ['&O k']);
        Result := False;
      end;


    End
    Else If (Sender = mskDtaIni) Then
    Begin

    {*****************************************}
    {* VALIDA A DATA INICIAL                 *}
    {**************************************MV*}
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
      End;

    End
    Else If (Sender = mskDtaFin) Then
    Begin

    {*****************************************}
    {* VALIDA A DATA FINAL                   *}
    {**************************************MV*}
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else If (Sender = edtCodPor) Then
    Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO PORTADOR           *}
    {**************************************MV*}
      If fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Clear;
        edtDesPor.Text := 'TODOS';
      End
      Else
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If qryConPor.FieldByName('POR_IMPBOL').AsString = 'N' Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido usar esse portador para impressão de boletos!', ['&O k']);
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
      End;

    End
    Else If (Sender = edtEnvBol) Then
    Begin

    {***********************************}
    {* VALIDA RECEBE BOLETO POR E-MAIL *}
    {********************************JU*}
      If Not fEmptyStr(edtEnvBol.Text) Then
      Begin
        If (edtEnvBol.Text <> 'S') And (edtEnvBol.Text <> 'N') And (edtEnvBol.Text <> 'T') Then
        Begin
          fMensagem('','O campo Boleto por e-mail deve ser S, N ou T!',['&O K'],0);
          Result := False;
        End
        Else
        Begin
          If (fCfgSis('DACPOR', varBoolean))    And
             (fEmptyStr(strPortadoresOperador)) Then
          Begin
            fMensagem('', 'Operador não tem direito de acesso aos lançamentos de nenhum portador. Verifique as permissões no cadastro de operadores, aba financeiro!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If not fValidaCampos(edtCodPor) Then
            Begin
              Result := False;
              Sender := edtCodPor;
            End;
          End;
        End;
      End
      Else
      Begin
        fMensagem('','O campo Boleto por e-mail deve ser preenchido!',['&O K'],0);
        Result := False;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmImpBoletoIndiv.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmImpBoletoIndiv.pAtualizaTemporaria;
begin
  With cdsConsulta Do
  Begin
    If Not IsEmpty Then
    Begin
      (FieldByName('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
      (FieldByName('CTR_VALCOR') As TFloatField).DisplayFormat := '#,##0.00';
      pAtualizaDados(Nil);
      pSetFocus(cxgDuplicatas);
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Não há boletos para serem impressos!', ['&O k']);
      blnMudarFoco := False;
      pSetFocus(edtCodCli);
    End;
  End;

  pCalculaTotalDuplicatas;
end;

procedure TfrmImpBoletoIndiv.pCriaTemporaria;
  Var
    strSQL: String;
    blnImpNmPed: Boolean;
begin
  blnImpNmPed := fCfgSis('IPDMER', varBoolean);

  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + '  R.AUTOINCREM, ';
  strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
  strSQL := strSQL + '  CTR_PARCEL AS PARDUP, ';
  strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  {Regra para boletos impressos:
     1-Duplicata com Nosso Número(Responsável pela impressão Empresa);
     2-Duplicata com Data de Envio(Responsável pela impressão Banco);
     3-Duplicata Mercantil(Emitidas pelo banco 999)}
  strSQL := strSQL + '  IF((CTR_NOSNUM IS NOT NULL) OR ' +
                     '     (CTR_DTAENV IS NOT NULL) OR ' +
                     '     (CTR_BCOBOL = "999" AND CTR_DTABOL IS NOT NULL), "Sim", "Não") ' +
                     '  AS CTR_BOLETO, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_DESSUJ, ';
  strSQL := strSQL + '  CTR_JURSUJ, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  0.0000 AS CTR_VALCOR, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_EMAIL_, ';
  strSQL := strSQL + '  CTR_CODPOR, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_OBSAG1, ';
  strSQL := strSQL + '  CTR_OBSAG2, ';
  strSQL := strSQL + '  CTR_OBSAG3, ';
  strSQL := strSQL + '  CTR_PERDPO, ';
  strSQL := strSQL + '  CTR_QTDDAV, ';
  strSQL := strSQL + '  CTR_CARTEI, ';
  strSQL := strSQL + '  CTR_PERMOR, ';
  strSQL := strSQL + '  CTR_PERMUL, ';
  strSQL := strSQL + '  CTR_DTAENV, ';
  strSQL := strSQL + '  CTR_DTABOL, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_LINDIG, ';
  strSQL := strSQL + '  CTR_VALORI, ';
  strSQL := strSQL + '  IFNULL(CTR_BCOBOL, "") AS CTR_BCOBOL, ';
  strSQL := strSQL + '  IF(CTR_NOSNUM IS NOT NULL OR CTR_DTAENV IS NOT NULL, CONCAT(CTR_BCOBOL, "-", CTR_CARTEI), CTR_BCOBOL) AS CTR_CHAVE, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  "D" AS CTR_MARDES, ';
  strSQL := strSQL + '  "N" AS CTR_VNCALT, ';
  strSQL := strSQL + '  CTR_JURSUJ AS CTR_JSJBKP, ';
  strSQL := strSQL + '  CTR_DTAVEN AS CTR_DTVBKP, ';
  strSQL := strSQL + '  CTR_DTAVEN AS CTR_DTAANT, ';
  strSQL := strSQL + '  0.0000 AS CTR_JURALT, ';
  strSQL := strSQL + '  0.0000 AS CTR_MULALT, ';
  strSQL := strSQL + '  0.0000 AS CTR_CORANT  ';

  If blnImpNmPed Then
    strSQL := strSQL + ', M.DET_NUM_PD AS NUMPED '
  else
    strSQL := strSQL + ', CAST(" " AS CHAR(12)) AS NUMPED ';

  strSQL := strSQL + ', R.CTR_TX_PIX ';
  strSQL := strSQL + ', R.CTR_EMPPIX ';
  strSQL := strSQL + ', IF(R.CTR_CODCND IS NOT NULL, CONCAT(R.CTR_CODCND, "-", CN.CND_DESCRI),"") AS COND_PGTO, ';
  strSQL := strSQL + '  CTR_CODVEN,   ';
  strSQL := strSQL + '  CADOPE.OPE_NOMOPE AS VENDEDOR,   ';
  strSQL := strSQL + '  CTR_OBSV01 AS CTR_OBSV01,   ';
  strSQL := strSQL + '  CTR_OBSV02 AS CTR_OBSV02   ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ' + strNomeTabela + ' R ';
  strSQL := strSQL + '  JOIN CADCLI      ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON R.CTR_CODVEN = OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ';
  If blnImpNmPed Then
  Begin
    strSQL := strSQL + '  LEFT JOIN MOVDET M ON R.CTR_CODEMP = M.DET_CODEMP AND ';
    strSQL := strSQL + '                        R.CTR_NUMDUP = M.DET_NUMDOC AND ';
    strSQL := strSQL + '                        R.CTR_ESPDOC = M.DET_ESPDOC AND ';
    strSQL := strSQL + '                        R.CTR_CODCLI = M.DET_CODCLI ';
  End;

  strSQL := strSQL + '  LEFT JOIN CADCND CN ON CTR_CODCND = CND_CODIGO ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';
  strSQL := strSQL + '  CTR_VALDUP > 0 ';

  If Not fEmptyStr(strNumDoc) Then
    strSQL := strSQL + '  AND CTR_NUMDUP = :NUMDOC ';

  If Not fEmptyStr(edtCodCli.Text) Then
    strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodEmp.Text) Then
  begin
    if rdgTipEmp.ItemIndex = 0 then
      strSQL := strSQL + '  AND CTR_EMPORI = :CODEMP '
    else
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';
  end;

  If Not fEmptyStr(edtCodPor.Text) Then
    strSQL := strSQL + '  AND CTR_CODPOR = :CODPOR '
  Else If fCfgSis('DACPOR', varBoolean) Then
    strSQL := strSQL + 'AND (CTR_CODPOR IN (' + fStringSQLLocateToStringSQLIN(strPortadoresOperador) + ') OR CTR_CODPOR IS NULL ) ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
  Begin
    If (edtFiltro.Text = 'V') Then
      strSQL := strSQL + '  AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '  AND CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
  End;

  Case rdgBoletos.ItemIndex Of
    0: strSQL := strSQL + ' AND ((CTR_NOSNUM IS NULL AND CTR_DTAENV IS NOT NULL) OR (CTR_NOSNUM IS NOT NULL) OR (CTR_BCOBOL = "999" AND CTR_DTABOL IS NOT NULL)) ';
    1: strSQL := strSQL + ' AND (CTR_NOSNUM IS NULL AND CTR_DTAENV IS NULL AND COALESCE(CTR_BCOBOL, "") <> "999") ';
  End;

  If edtEnvBol.Text = 'S' Then
    strSQL := strSQL + '  AND CLI_ENVBOL = "S" '
  Else If edtEnvBol.Text = 'N' Then
    strSQL := strSQL + '  AND CLI_ENVBOL = "N" ';

  strSQL := strSQL + ' AND COALESCE(POR_IMPBOL, "S") = "S" ';

  cdsConsulta.AfterScroll := nil;

  With qryConsulta Do
  Begin
    cdsConsulta.DisableControls;
    Close;
    cdsConsulta.Close;

    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(edtCodCli.Text) Then
      ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Not fEmptyStr(strNumDoc) Then
      ParamByName('NUMDOC').AsString := strNumDoc;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Not fEmptyStr(edtCodPor.Text) Then
      ParamByName('CODPOR').AsString := edtCodPor.Text;

    If Not fEmptyStr(edtEspDoc.Text) Then
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    Open;
    pSetaClient(qryConsulta);
    pFormataCampos(qryConsulta);

    If fEmptyStr(cdsConsulta.IndexFieldNames) Then
      cdsConsulta.IndexFieldNames := 'CTR_NUMDUP;CTR_ESPDOC;CTR_CODEMP';

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);
    pFormataCampos(cdsConsulta);
    pCalculaValorCorrigido();
  End;

  lblCartei.Visible := rdgBoletos.ItemIndex = 0;
  edtCartei.Visible := rdgBoletos.ItemIndex = 0;
  lblPerMor.Visible := rdgBoletos.ItemIndex = 0;
  edtPerMor.Visible := rdgBoletos.ItemIndex = 0;
  lblPerMul.Visible := rdgBoletos.ItemIndex = 0;
  edtPerMul.Visible := rdgBoletos.ItemIndex = 0;

  cdsConsulta.AfterScroll := pAtualizaDados;

  pAtualizaDados(cdsConsulta);

  cdsConsulta.EnableControls;
end;

procedure TfrmImpBoletoIndiv.pDeletaTemporaria;
begin
  With cdsConsulta Do
    If Active Then
      EmptyDataSet;
end;

procedure TfrmImpBoletoIndiv.pAtualizaDados(DataSet: TDataSet);
begin
  With cdsConsulta Do
  Begin
    edtCodPorBai.Text := FieldByName('CTR_CODPOR').AsString;
    edtNomPorBai.Text := FieldByName('POR_NOMPOR').AsString;
    edtNomeBanco.Text := fRetNomeBco(FieldByName('CTR_BCOBOL').AsString);

    edtNosNum.Text    := FieldByName('CTR_NOSNUM').AsString;
    edtHistor.Texto   := FieldByName('CTR_HIST01').AsString;

    edtObsAg1.Text    := FieldByName('CTR_OBSAG1').AsString;
    edtObsAg2.Text    := FieldByName('CTR_OBSAG2').AsString;
    edtObsAg3.Text    := FieldByName('CTR_OBSAG3').AsString;

    If rdgBoletos.ItemIndex = 0 Then
    Begin
      edtCartei.Text    := FieldByName('CTR_CARTEI').AsString;
      edtPerMor.Text    := FloatToStrF(FieldByName('CTR_PERMOR').AsFloat, ffFixed, 12, fCfgSis('CSDMOR', VarInteger)) + '%';
      edtPerMul.Text    := FloatToStrF(FieldByName('CTR_PERMUL').AsFloat, ffFixed, 12, 02) + '%';
    End;
  End;
end;

procedure TfrmImpBoletoIndiv.pLimpaDados;
begin
  edtCodPorBai.Clear;
  edtNomPorBai.Clear;
  edtNomeBanco.Clear;
  edtCodPor.Clear;
  edtDesPor.Clear;
  edtEspDoc.Clear;
  edtEnvBol.Text := 'T';
  edtFiltro.Text := 'V';
  rdgBoletos.ItemIndex := 1;
  edtNosNum.Clear;
  edtHistor.Clear;
  edtNomCli.Clear;
  edtCartei.Clear;
  edtPerMor.Clear;
  edtPerMul.Clear;

  edtTotalDuplicatas.Clear;
  edtQtdSelecionadas.Clear;
  edtTotalSelecionadas.Clear;
  edtTotalSelCor.Clear;

  edtObsAg1.Clear;
  edtObsAg2.Clear;
  edtObsAg3.Clear;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;
  edtCodCli.Clear;
  objLock.pDestravarTodos;
end;

procedure TfrmImpBoletoIndiv.pSelecionaDuplicata(blnSelTodos: Boolean = False);
begin
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
  Begin
    Exit;
  End;

  If Not blnSelTodos Then
  Begin
    If Not cdsConsulta.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO','A duplicata não pode ser selecionada pois possui um Pix gerado e ativo!',['OK']);

      Exit;
    End;

    //MF: 282523 e 279633 - 15/05/2023
    If fVerificarSeOBoletoPodeSerEmitido(cdsConsulta.FieldByName('CTR_ESPDOC').AsString) Then
    Begin
      If Not fVerificaContRecNFAutorizadaSefaz(cdsConsulta.FieldByName('NRODUP').AsString,
                                               cdsConsulta.FieldByName('CTR_CODCLI').AsString,
                                               cdsConsulta.FieldByName('CTR_CODEMP').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este boleto não pode ser emitido, pois a nota fiscal não foi autorizada na SEFAZ. ' + #13#10 +
                              'Verifique a inconsistência no painel de notas fiscais e regularize para liberar esta operação.', ['&OK']);
        Exit;
      End;
    End;

    FillChar(arrDupSel, SizeOf(arrDupSel), #0);
    cdsConsulta.AfterScroll := nil;
  End;

  If cdsConsulta.FieldByName('CTR_MARDES').AsString <> 'M' Then
  Begin
    If fEmptyStr(cdsConsulta.FieldByName('CLI_C_G_C_').AsString) Then
      fMensagem('','O Cpf/Cnpj do cliente está vazio, favor preencher!',['OK'])

    Else If cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime < VS_Date Then
    Begin
      pAdicionarDuplicataVencidaTrava;
      If (Not blnSelTodos)  Then
      Begin
        If (fCfgSis('CTRDTA', varBoolean) = True) And
           (fMensagem('', 'Deseja alterar a data de vencimento?', ['&Sim', '&Não'], 2) = 1) Then
        Begin
          if (rdgBoletos.ItemIndex = 0) then
            fAvisoClienteTemCreditoDisponivel(fStringToArray(cdsConsulta.FieldByName('CTR_CODCLI').AsString));
          If fAlteraVencimento() Then
            pMarcaDuplicata(True);
        End
        Else
          pMarcaDuplicata(True);
      End;
    End
    Else
      pMarcaDuplicata(True);
  End
  Else If (Not blnSelTodos) Then
  Begin
    If cdsConsulta.FieldByName('CTR_VNCALT').AsString = 'S' Then
      pRestauraVencimento();

    pMarcaDuplicata(False);
  End;

  If Not blnSelTodos Then
  Begin
    pAtualizaTemporaria;
    cdsConsulta.AfterScroll := pAtualizaDados;
    pAtualizaDados(cdsConsulta);
  End;
end;

procedure TfrmImpBoletoIndiv.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmImpBoletoIndiv.pMarcaDuplicata(blnMarcar: Boolean);
begin
  Try
    If (blnMarcar) Then
    Begin
      {**********************************************************************************************}
      {* VERIFICAÇÃO SE O BOLETO FOI IMPRESSO PELO BANCO E AINDA NÃO CONFIRMOU O ARQUIVO DE RETORNO *}
      {**********************************************************************************************}
      If ((cdsConsulta.FieldByName('CTR_DTAENV').AsDateTime > 0)     And
           fEmptyStr(cdsConsulta.FieldByName('CTR_NOSNUM').AsString) And
           (Pos('VENDOR', cdsConsulta.FieldByName('CTR_CARTEI').AsString) <= 0) ) Then
      Begin
        fMensagem('','Duplicatas enviadas ao banco que ainda não foram confirmadas em arquivo retorno não podem ter o boleto impresso pela empresa!', ['&Ok']);
        Exit;
      End;

      if ((not fEmptyStr(cdsConsulta.FieldByName('CTR_CARTEI').AsString)) and (Pos('VENDOR', cdsConsulta.FieldByName('CTR_CARTEI').AsString) > 0)) then
      begin
        fMensagem('','Duplicata enviada ao banco em modo de financiamento(VENDOR), não será possível a impressão ou reimpressão dessa duplicata!', ['&Ok']);
        Exit;
      end;

      If (fCfgSis('LIBPED', VarBoolean)) Then
      Begin
        If (cdsConsulta.FieldByName('CTR_ESPDOC').AsString = 'PD') And
           (Not fPedidoLiberado(cdsConsulta.FieldByName('NRODUP').AsString,
                                cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                                cdsConsulta.FieldByName('CTR_CODEMP').AsString)) Then
        Begin
          fMensagem('','Este pedido de venda ainda não foi liberado pelo financeiro, '+
            'não será possível a impressão ou reimpressão dessa duplicata!', ['&Ok']);
          Exit;
        End;
      End;

      {****************************}
      {* TRAVA PARA BAIXA PARCIAL *}
      {**61106******************MO*}
      If (cdsConsulta.FieldByName('CTR_SEQBAI').AsInteger = 0) and
         fPesqSeqBai(cdsConsulta.FieldByName('NRODUP').AsString,
                     cdsConsulta.FieldByName('CTR_PARCEL').AsString,
                     cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                     cdsConsulta.FieldByName('CTR_CODCLI').AsString,
                     cdsConsulta.FieldByName('CTR_CODEMP').AsString) And
         (fEmptyStr(cdsConsulta.FieldByName('CTR_LINDIG').AsString)) And
         (((cdsConsulta.FieldByName('CTR_DTABOL').AsDateTime > 0) And
          (Not fEmptyStr(cdsConsulta.FieldByName('CTR_NOSNUM').AsString)) And
          (Not fEmptyStr(cdsConsulta.FieldByName('CTR_BCOBOL').AsString))
         ) Or
         ((Not fEmptyStr(cdsConsulta.FieldByName('CTR_BCOBOL').AsString)) And
          (cdsConsulta.FieldByName('CTR_DTAENV').AsDateTime > 0) And
          (fEmptyStr(cdsConsulta.FieldByName('CTR_NOSNUM').AsString)) And
          (cdsConsulta.FieldByName('CTR_DTABOL').AsDateTime <= 0)
         )) Then
      Begin
        {**************************************************}
        {* CONFIGURAÇÃO PARA REIMPRIMIR DUPLICATA PARCIAL *}
        {**61106****************************************MO*}
        IF (fCfgSis('RIMPPA', varBoolean)) THEN
        BEGIN
          {*******************************************************************}
          {* SE O RESPONSAVÉL DA IMPRESSÃO DO BOLETO SEJA O BANCO NÃO PODERÁ *}
          {***** SER REIMPRESSO O BOLETO DA DUPLICATA QUE CONTÉM PARCIAL. ****}
          {**REQ*61106*****************************************************MO*}
          If (fGetBancoConfig(0, cdsConsulta.FieldByName('CTR_CARTEI').AsString, 'RESPONS', '') = 'B') Then
          Begin
            fMensagem('','O boleto dessa duplicata foi impresso pelo banco onde a mesma é uma baixa parcial, portanto, não poderá ser reimpresso!', ['&Ok']);
            Exit;
          End
          else
          begin
            {*********************************************************************}
            {* VERIFICA PERMISSÃO DO DIREITO DE ACESSO E PEDE SENHA DE LIBERAÇÃO *}
            {*********************************************************************}
            If Not fVerificaAcessoSistema('RIMPPARCIAL') Then
            begin
              pMensagemOk('Usuário sem permissão para reimprimir boletos que sofreram baixa parcial!');
              Exit;
            end;
          end;
        end
        else
        begin
          fMensagem('','Já foi gerado boleto dessa duplicata. Para fazer a impressão do boleto da mesma, basta ir na manutenção do contas a receber, '+
                       'encontrar a duplicata e apagar os campos "nosso número", "banco" e "data de envio", caso estiverem preenchidos.', ['&Ok']);
          Exit;
        end;
      End;

      {*************************************************
       * Verificando se a duplicata não está com trava *
       **********************************************KP*}
      If fDuplicataTravada(cdsConsulta.FieldByName('CTR_NUMDUP').AsString,
                           cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                           cdsConsulta.FieldByName('CTR_CODEMP').AsString,
                           cdsConsulta.FieldByName('CTR_CODCLI').AsString,
                           cdsConsulta.FieldByName('CTR_PARCEL').AsString,
                           False) Then Exit;
    End;

    With cdsConsulta Do
    Begin
      Edit;
      FieldByName('CTR_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
      Post;

      objLock.fLock_Unlock('CADREC' +
               FieldByName('CTR_NUMDUP').AsString +
               FieldByName('CTR_ESPDOC').AsString +
               FieldByName('CTR_CODEMP').AsString +
               FieldByName('CTR_CODCLI').AsString +
               FieldByName('CTR_PARCEL').AsString, IIF(blnMarcar, True, False), False);
    End;
  Finally

  End;
end;

procedure TfrmImpBoletoIndiv.pRestauraVencimento;
begin
  cdsConsulta.Edit;
  cdsConsulta.FieldByName('CTR_VNCALT').AsString   := 'N';
  cdsConsulta.FieldByName('CTR_JURSUJ').AsFloat    := cdsConsulta.FieldByName('CTR_JSJBKP').AsFloat;
  cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime := cdsConsulta.FieldByName('CTR_DTVBKP').AsDateTime;
  cdsConsulta.Post;

  pCalculaValorCorrigido;
end;

procedure TfrmImpBoletoIndiv.rdgBoletosClick(Sender: TObject);
begin
  inherited;
  if not cdsConsulta.IsEmpty then
    pAlterarFiltro;
end;

procedure TfrmImpBoletoIndiv.spbAmpliarClick(Sender: TObject);
begin

  inherited;

  If not cdsConsulta.Active Then
    exit;

  If fEmptyStr(cdsConsulta.FieldByName('AUTOINCREM').AsString) then
    exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(219, 7731, [],
                        ['AUTINC'],
                        [cdsConsulta.FieldByName('AUTOINCREM').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmImpBoletoIndiv.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Pos('_VALDUP', strCampoFiltro) > 0 Then
      Accept := FloatToStrF(fStrToFloat(strValorFiltro),ffFixed,15,2) = FloatToStrF(DataSet.FieldByName(strCampoFiltro).AsFloat,ffFixed,15,2)
    Else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  End;
end;

procedure TfrmImpBoletoIndiv.FormCreate(Sender: TObject);
begin
  inherited;
  blnImpressaoAutomatica := False;
  blnImprimiuBoletos := False;

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);
  qryGenGb1 := fCriaQuery(Self);

  objLiberacao := TLiberacao.Create;
  objMsg := TMensagemLiberacao.Create(Self);
  objLock := TLock.Create;
  If fCfgSis('CTRPRO', varBoolean) Then
    objProrrogacao := TProrrogacaoDeTitulos.Create(ttAltVen);

  qryConsulta.Connection := frmModulo.GetCurrentConnection;
  cpuCampos := Nil;

  strNomeTabela := 'CADREC';

  {************************}
  { INSTÂNCIA QRY GENERICA }
  {*********************JB*}
  qryGenRec := fCriaQuery(Self);
  qryGenRe2 := fCriaQuery(Self);

  {******************************************}
  {* QUANDO UTILIZAR ESSE RECURSO, NÃO      *}
  {* ESQUECER DE "LIMPAR" O EVENTO, OU SEJA *}
  {* ATRIBUIR NIL AO EVENTO. VER (*) NO E-  *}
  {* VENTO "OnClose"                        *}
  {* AO FAZE-LO, FAVOR COLOCAR ESSE COMEN-  *}
  {* TARIO                                  *}
  {***************************************MV*}
  cdsConsulta.OnFilterRecord := pFilterRecord;

  pInicializaCamposUso;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodEmp.Text := VS_strCodEmp;

  pCarregaEmpresa;

  FillChar(arrDupSel, SizeOf(arrDupSel), #0);
  SetLength(arrLogLib, 0);
end;

procedure TfrmImpBoletoIndiv.FormActivate(Sender: TObject);
begin
  inherited;
  If blnImpressaoAutomatica Then
  Begin
    blnImpressaoAutomatica := False;

    btnConsultar.Click;
    btnSelTodos.Click;
    btnConfirma.Click;

    If blnImprimiuBoletos Then
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
  End;
end;

procedure TfrmImpBoletoIndiv.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pFinalizaCamposUso;
  pDeletaTemporaria;

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  if Assigned(objMsg) then
    FreeAndNil(objMsg);

  {*****************************************}
  {* BLOQUEIA O ACESSO À CONFIGURAÇÃO DOS  *}
  {* BOLETOS                               *}
  {**************************************MV*}
  blnLibCnf := False;

  FreeAndNil(objLock);
  If Assigned(objProrrogacao) Then
    FreeAndNil(objProrrogacao);
end;


procedure TfrmImpBoletoIndiv.pCalculaTotalDuplicatas;
  Var
    cdsAux: TUniClientDataSet;
    fltTotalSel, fltTotalCor: Double;
begin

  Try
    cdsAux := TUniClientDataSet.Create(Self);
    cdsAux.Data     := cdsConsulta.Data;

    With cdsAux Do
    Begin
      edtTotalDuplicatas.Text := IntToStr(RecordCount);
      Filter := 'CTR_MARDES = ' + QuotedStr('M');
      Filtered := True;
      edtQtdSelecionadas.Text := IntToStr(RecordCount);

      fltTotalSel := 0;
      fltTotalCor := 0;
      First;
      While Not Eof do
      Begin
        fltTotalSel := fltTotalSel + FieldByName('CTR_VALDUP').AsFloat;
        fltTotalCor := fltTotalCor + FieldByName('CTR_VALCOR').AsFloat;
        Next;
      End;
      edtTotalSelecionadas.Text := FormatFloat('#,##0.00', fltTotalSel);
      edtTotalSelCor.Text := FormatFloat('#,##0.00', fltTotalCor);

      Filtered := False;
    End;
  Finally

  End;

  FreeAndNil(cdsAux);
end;

procedure TfrmImpBoletoIndiv.pCalculaValorCorrigido;
var
  fltPerJur, fltPerMul, fltValDup, fltValdes, fltValAcr: Double;
  bkmPosicao: TBookmark;
begin
  fltPerJur := fCfgSis('JURATR', varDouble);
  fltPerMul := fCfgSis('MULATR', varDouble);

  With cdsConsulta Do
  Begin
    DisableControls;
    try
      bkmPosicao := GetBookmark;
      try
        First;
        While Not Eof Do
        Begin
          If FieldByName('CTR_VNCALT').AsString = 'N' then
          Begin

            If (fCfgSis('UTDEFN') = '1') Or (FieldByName('CTR_DTAVEN').AsDateTime >= VS_date) Then
              fltValdes := FieldByName('CTR_DESSUJ').AsFloat
            Else
              fltValdes := 0;

            fltValDup := FieldByName('CTR_VALDUP').AsFloat -
                         fltValdes +
                         FieldByName('CTR_JURSUJ').AsFloat +
                         FieldByName('CTR_DESCOB').AsFloat;

            fltValAcr := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                             fltValDup, fltPerJur, fltPerMul, 9999, FieldByName('CTR_BCOBOL').AsString);
          End
          Else
          Begin
            fltValDup := FieldByName('CTR_VALDUP').AsFloat;
            fltValAcr := FieldByName('CTR_JURSUJ').AsFloat;
          End;

          Edit;
          FieldByName('CTR_VALCOR').AsFloat := fltValDup + fltValAcr;
          Post;

          Next;
        End;
      Finally
        If BookmarkValid(bkmPosicao) Then
          GotoBookmark(bkmPosicao);
      End;
    finally
      EnableControls;
    end;
  End;
end;

procedure TfrmImpBoletoIndiv.edtCodCliChange(Sender: TObject);
begin
  inherited;
  if not cdsConsulta.IsEmpty then
    pAlterarFiltro;
end;

procedure TfrmImpBoletoIndiv.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpBoletoIndiv.btnIniBusClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBaixaBusca, frmBaixaBusca);
    frmBaixaBusca.ShowModal;
    TfrmGravando.fExecutarModal(pBuscarIni,'Aguarde... Localizando Título.','');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmImpBoletoIndiv.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBaixaBusca);

end;

procedure TfrmImpBoletoIndiv.btnLocProxClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pBuscarProx,'Aguarde... Localizando Título.','');
end;

procedure TfrmImpBoletoIndiv.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmImpBoletoIndiv.btnSelTodosClick(Sender: TObject);
begin
  inherited;

  if (not cdsConsulta.Active) or (cdsConsulta.IsEmpty) then
  begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&O k']);
    Exit;
  end;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Checando e Marcando Duplicatas';
  frmGravando.ShowModal;
end;

procedure TfrmImpBoletoIndiv.CarregandoRegistros;
begin
  pCriaTemporaria;
  pAtualizaTemporaria;
  objLock.pDestravarTodos;
end;

procedure TfrmImpBoletoIndiv.cxgDuplicatasCTR_BOLETOCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  ACanvas.Font.Style := [fsBold];

  If (AViewInfo.Value <> Null) And (AViewInfo.Value = 'Sim') Then
    ACanvas.Font.Color := clGreen
  Else
    ACanvas.Font.Color := clRed;
end;

procedure TfrmImpBoletoIndiv.cxgDuplicatasDadosCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmImpBoletoIndiv.cxgDuplicatasDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes: String;
begin
  inherited;
  If (AViewInfo.Item.SortOrder <> soNone) And
     (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDuplicatasCTR_MARDES.Index]);

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;

end;

procedure TfrmImpBoletoIndiv.cxgDuplicatasDadosDataControllerSortingChanged(
  Sender: TObject);
  Var
    strIndex: String;
    intCount: Integer;
begin
  inherited;
  {**********************************}
  {* PEGA OS DADOS DA ORDEM DO GRID *}
  {*******************************AF*}
  strIndex := '';
  For intCount := 0 To cxgDuplicatasDados.SortedItemCount -1 Do
  Begin
    strIndex := strIndex + cxgDuplicatasDados.SortedItems[intCount].DataBinding.FilterFieldName;

    If cxgDuplicatasDados.SortedItemCount -1 > intCount Then
      strIndex := strIndex + ';';
  End;

  cdsConsulta.IndexFieldNames := strIndex;
end;

procedure TfrmImpBoletoIndiv.cxgDuplicatasDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaDuplicata;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(edtCodCli);
    pDeletaTemporaria;
  End
end;

procedure TfrmImpBoletoIndiv.cxgDuplicatasDadosStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  Var
    ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData And (ARecord.Index > -1) Then
    With cxgDuplicatasDados.DataController Do
    Begin
      ARowInfo := GetRowInfo(ARecord.Index);
      If VarToStr(Values[ARowInfo.RecordIndex,
                         cxgDuplicatasDados.GetColumnByFieldName('CTR_MARDES').Index]) = 'M' Then
      Begin
        AStyle := cxsSelecionado;
      End;
    End;
end;

procedure TfrmImpBoletoIndiv.btnConfirmaClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModalA(pImprimindoBoletos, 'Aguarde, Imprimindo Boletos...', '');
end;

procedure TfrmImpBoletoIndiv.pImprimindoBoletos;
  Var
    arrCtrDup: TArrDupCtr;
    objBoleto: TBoleto;
    cdsAux: TUniClientDataSet;
    blnImpBol: Boolean;
    blnEtiCob: Boolean;
    stlBancosEnvio: TStringList;
    intContador: Integer;
    strPerMor: String;
    strPerMul: String;
    blnGerouLogLib: Boolean;
    fltDesSuj: Double;
    strHistorico: String;
    strCarteira: String;
    blnReimprime,
    blnProrrogado: Boolean;
    frmImpEtiquetas : TfrmImpEtiquetas;
    blnUsaModeloFaturamento: Boolean;
begin
  inherited;
  blnImprimiuBoletos := False;

  If (Not cdsConsulta.Active) or (cdsConsulta.IsEmpty) or (StrToIntDef(Trim(edtQtdSelecionadas.Text), 0) <= 0) Then
  begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&O k']);
    Exit;
  end;

  blnGerouLogLib  := False;
  Screen.Cursor   := crHourGlass;
  pnlInfo.Caption := 'Aguarde, imprimindo boletos...';
  blnImpBol       := True;
  blnEtiCob       := False;
  blnReimprime    := False;
  blnProrrogado   := False;
  If (Not fEmptyStr(edtQtdSelecionadas.Text)) And (StrToInt(edtQtdSelecionadas.Text) > 0) Then
  Begin

    If Not fTravaDuplicatasVencidas Then
      Exit;

    If Not fLiberaAlteracaoVencimento Then
      Exit;

    If Not fLiberaAlteracaoJurosMulta Then
      Exit;

    If Not fLiberaImpressaoBaixaParcial Then
      Exit;

    {****************************************}
    {* VERIFICA SE EXISTE BOLETO MARCADO JÁ *}
    {* IMPRESSO. SE EXISTIR, PEDE SENHA     *}
    {*************************************RV*}
    If (fReimpressaoBoleto > 0) Then
    Begin
      blnReimprime := True;
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.fGetObjectFromJson(objMsg.fGetJsonObject.ToJSON);
      objLiberacao.strDirAce := 'REIBOL';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;

      If objLiberacao.fLibera Then
        blnImpBol := True
      Else
        blnImpBol := False;
    End;

    If blnImpBol And fInformacaoDesatualizada  Then
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas marcadas que foram impressas por outro usuário. Realize a pesquisa novamente para efetuar a impressão ou a reimpressão desses boletos!', ['&OK']);
      blnImpBol := False;
    End;

    if blnImpBol and (rdgBoletos.ItemIndex = 1)then
      fClienteTemCreditoDisponivel;

    If blnImpBol Then
    Begin
      stlBancosEnvio := fGeraListaBancosEnvio;

      objBoleto := TBoleto.Create(Self, strNomeTabela, False);
      cdsAux          := TUniClientDataSet.Create(Self);
      cdsAux.Data     := cdsConsulta.Data;
      cdsAux.IndexFieldNames := cdsConsulta.IndexFieldNames;
      pOrdenaBoletos(cdsAux);

      For intContador := 0 To stlBancosEnvio.Count -1 Do
      Begin
        if blnReimprime then
        begin
          strCarteira := Copy(stlBancosEnvio[intContador], 5, Length(stlBancosEnvio[intContador]));
          cdsAux.Filter := 'CTR_MARDES = ' + QuotedStr('M') + IIF(fEmptyStr(Copy(stlBancosEnvio[intContador], 1, 3)),' AND CTR_BCOBOL = '''' ',
                           ' AND CTR_BCOBOL = ' + Copy(stlBancosEnvio[intContador], 1,3) + ' AND CTR_CARTEI = ' + QuotedStr(strCarteira));
        end
        else
          cdsAux.Filter := 'CTR_MARDES = ' + QuotedStr('M') + IIF(fEmptyStr(Copy(stlBancosEnvio[intContador], 1, 3)),' AND CTR_BCOBOL = '''' ',
                           ' AND CTR_BCOBOL = ' + Copy(stlBancosEnvio[intContador], 1,3));

        cdsAux.Filtered := True;

        SetLength(arrCtrDup,0);

        cdsAux.First;
        While Not cdsAux.Eof Do
        Begin
          SetLength(arrCtrDup,Length(arrCtrDup)+1);
          arrCtrDup[Length(arrCtrDup)-1].strNumDup := cdsAux.FieldByName('NRODUP').AsString;
          arrCtrDup[Length(arrCtrDup)-1].strParcel := cdsAux.FieldByName('PARDUP').AsString;
          arrCtrDup[Length(arrCtrDup)-1].strEspDoc := cdsAux.FieldByName('CTR_ESPDOC').AsString;
          arrCtrDup[Length(arrCtrDup)-1].strCodEmp := cdsAux.FieldByName('CTR_CODEMP').AsString;
          arrCtrDup[Length(arrCtrDup)-1].strCodCli := cdsAux.FieldByName('CTR_CODCLI').AsString;
          arrCtrDup[Length(arrCtrDup)-1].strMsgProrrogacao := fRetornaHistProrrogacao(cdsAux.FieldByName('NRODUP').AsString,cdsAux.FieldByName('PARDUP').AsString,
                                                                                      cdsAux.FieldByName('CTR_ESPDOC').AsString,cdsAux.FieldByName('CTR_CODEMP').AsString,
                                                                                      cdsAux.FieldByName('CTR_CODCLI').AsString,cdsAux.FieldByName('CTR_SEQBAI').AsInteger);
          arrCtrDup[Length(arrCtrDup)-1].strAutoIn := cdsAux.FieldByName('AUTOINCREM').AsString;
          If (cdsAux.FieldByName('CTR_VNCALT').AsString = 'S') Then
          Begin
            blnProrrogado := True;
            strHistorico := cdsAux.FieldByName('CTR_HIST01').AsString;
            strHistorico := strHistorico + #13 +
                            'Em ' + DateToStr(VS_Date) + ', ocorreu prorrogação do vencimento. ' +
                            'Operador: ' + strLoginUsuarioLogado + #13 +
                            'Vencimento Original: ' + cdsAux.FieldByName('CTR_DTVBKP').AsString + ' - ' +
                            'Vr.Original: ' + FormatFloat('#,##0.00', cdsAux.FieldByName('CTR_VALDUP').AsFloat) + #13 +
                            'Novo Vencimento    : ' + cdsAux.FieldByName('CTR_DTAVEN').AsString + ' - ' +
                            'Novo Valor : ' + FormatFloat('#,##0.00', cdsAux.FieldByName('CTR_VALCOR').AsFloat);
            strHistorico := strHistorico + #13 + 'Juros alterado de ' +
                            FormatFloat('#,##0.00', cdsAux.FieldByName('CTR_JSJBKP').AsFloat) + ' para ' +
                            FormatFloat('#,##0.00', cdsAux.FieldByName('CTR_JURSUJ').AsFloat) +
                            ' por motivo de prorrogação do vencimento.' + #13;
            arrCtrDup[Length(arrCtrDup)-1].strMsgProrrogacao := 'ULT. VENC.: ' + cdsAux.FieldByName('CTR_DTVBKP').AsString + ' - ' +
                                                                  'ULT.VLR.: ' + FormatFloat('#,##0.00', (cdsAux.FieldByName('CTR_VALDUP').AsFloat + cdsAux.FieldByName('CTR_JSJBKP').AsFloat));
            If cdsAux.FieldByName('CTR_DESSUJ').AsFloat <> 0 Then
            Begin
              If (fCfgSis('UTDEFN') = '1') Then
                fltDesSuj := cdsAux.FieldByName('CTR_DESSUJ').AsFloat
              Else
              Begin
                strHistorico := strHistorico + 'Desconto alterado de ' +
                                FormatFloat('#,##0.00', cdsAux.FieldByName('CTR_DESSUJ').AsFloat) +
                                ' para 0,00 por motivo de prorrogação do vencimento.' + #13;

                fltDesSuj := 0.0;
              End;
            End
            Else
              fltDesSuj := 0.0;

            If Not fGravaVencimento(cdsAux.FieldByName('CTR_DTAVEN').AsDateTime,
                                    fltDesSuj,
                                    cdsAux.FieldByName('CTR_JURSUJ').AsFloat,
                                    strHistorico,
                                    cdsAux.FieldByName('AUTOINCREM').AsString,
                                    Self.Name,
                                    arrCtrDup[Length(arrCtrDup)-1].strMsgProrrogacao) Then
              Raise Exception.Create('Não foi possível fazer a gravação do novo vencimento e acréscimos! Tente Novamente!')
            Else
            Begin
              If Assigned(objProrrogacao) Then
              Begin
                objProrrogacao.pAdicionarDuplicataNoArrayProrrogacao(cdsAux,cdsAux.RecNo);
                objProrrogacao.pInativarClientePorProrrogacao;
                objProrrogacao.pLimparArrays;
              End;
            End;

          End;

          cdsAux.Next;
        End;

        {*************************************************}
        {* PARA BOLETOS JÁ IMPRESSOS INFORMA A CARTEIRA, *}
        {* O PERCENTUAL DE MUTA E MORA DIÁRIA PERCENTUAL *}
        {*REQ-25848-22/01/2015*************************JU*}
        strPerMor := fFloatToStrVirgula(cdsAux.FieldByName('CTR_PERMOR').AsFloat, 12, fCfgSis('CSDMOR', VarInteger));
        strPerMul := fFloatToStrVirgula(cdsAux.FieldByName('CTR_PERMUL').AsFloat, 12, 2);

        // Req 168890
        blnUsaModeloFaturamento := VarToStrDef(fCampoTabela('EMA_STATUS', 'EMASAI',
                                   ['EMA_CODIGO', 'EMA_CODGRU', 'EMA_CODEMP', 'EMA_ENTSAI'],
                                   ['001', '008', VS_strCodEmp, 'S']), '') = 'A';

        objBoleto.blnEhBoletoMeiaNota := blnEhBoletoMeiaNota;

        objBoleto.pImprimir(cdsAux, arrCtrDup, Copy(stlBancosEnvio[intContador], 1, 3), False, False, False,
                            rdgBoletos.ItemIndex = 0, blnReImprimeParcial, cdsAux.FieldByName('CTR_CARTEI').AsString,
                            strPerMor, strPerMul, '', strOrdCampo, strOrdTipo, False, True, blnProrrogado, False,
                            False, blnUsaModeloFaturamento);

        blnImprimiuBoletos := True;

        blnEtiCob := objBoleto.blnEtiCob;

        If Not blnGerouLogLib Then
        Begin
          pGeraLogLiberacao(cdsAux.FieldByName('NRODUP').AsString,
                            cdsAux.FieldByName('CTR_ESPDOC').AsString,
                            cdsAux.FieldByName('CTR_CODEMP').AsString);

          blnGerouLogLib := True;
          SetLength(arrLogLib, 0);
        End;
      End;

      objMsg.Clear;
      FreeAndNil(objBoleto);
      FreeAndNil(cdsAux);
      SetLength(arrCtrDup,0);

      {******************************************}
      {* CASO SELECIONADO NA TELA ANTERIOR ABRE *}
      {* A IMPRESSAO DE ETIQUETAS DE COBRANÇA   *}
      {***************************************IV*}
      If blnEtiCob Then
      Begin
        If fMensagem('', 'Prepare a impressora para emitir as etiquetas' + #13#10 +
                         ' de cobrança dos boletos impressos. Confirma?', ['','']) = 1 Then
        Begin

          Try
            pCriarFormularios(TfrmImpEtiquetas, frmImpEtiquetas);
            frmImpEtiquetas.intTipEti := ETI_CLIENTES;
            frmImpEtiquetas.btnIniBusca.Visible := False;
            frmImpEtiquetas.blnViaBol := True;
            frmImpEtiquetas.strCliBol := fRetClientesBoleto;

            frmImpEtiquetas.showModal;
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[mnuEtiClientesClick]');
            End;
          End;
          pFreeAndNil(frmImpEtiquetas);

        End;
      End;


      If blnLibCnf Then
      Begin
        TfrmGravando.fExecutarModal(CarregandoRegistros,'Aguarde... Carregando Títulos.','');
      End
      Else
      Begin
        pDeletaTemporaria;

        IF chkLimFil.Checked THEN
        BEGIN
          pLimpaDados;
        END
        ELSE
        BEGIN
          TfrmGravando.fExecutarModal(CarregandoRegistros,'Aguarde... Carregando Títulos.','');
        END;

        pSetFocus(edtCodCli);
      End;

    End;
  End;

  pnlInfo.Caption := '';
  Screen.Cursor := crDefault;
  If Assigned(stlBancosEnvio) Then
    FreeAndNil(stlBancosEnvio);
end;

class procedure TfrmImpBoletoIndiv.pImprimirBoletos(strNumDoc, strEspDoc,
  strCodEmp, strCodCli: String; blnEhBoletoMeiaNota: Boolean = False);
Var
  frmImpBoleto: TfrmImpBoletoIndiv;
begin
  pCriarFormularios(TfrmImpBoletoIndiv, frmImpBoleto);
  Try
    frmImpBoleto.strCodCli := strCodCli;
    frmImpBoleto.strNumDoc := strNumDoc;
    frmImpBoleto.strEspDoc := strEspDoc;
    frmImpBoleto.strEmpDoc := strCodEmp;
    frmImpBoleto.blnEhBoletoMeiaNota := blnEhBoletoMeiaNota;

    if blnEhBoletoMeiaNota then
      frmImpBoleto.pOnShow
    else
      frmImpBoleto.ShowModal;
  Finally
    pFreeAndNil(frmImpBoleto);
  End;
end;

procedure TfrmImpBoletoIndiv.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
  begin
    TfrmGravando.fExecutarModal(CarregandoRegistros,'Aguarde... Carregando Títulos.','');
  end;
end;

{*****************************************}
{* CRIA E INICIALIZA A VARIAVEL DO TIPO  *}
{* 'TCamposUso', BEM COMO PREPARA AS TA- *}
{* BELAS ENVOLVIDAS NO PROCESSO          *}
{**************************************MV*}
procedure TfrmImpBoletoIndiv.pInicializaCamposUso;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C.*, ';
  strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID, ';
  strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO, ';
  strSQL := strSQL + '  D2.CID_NOMCID AS CID_CIDCOB, ';
  strSQL := strSQL + '  D2.CID_ESTADO AS CID_ESTCOB, ';
  strSQL := strSQL + '  D3.CID_NOMCID AS CID_CIDENT, ';
  strSQL := strSQL + '  D3.CID_ESTADO AS CID_ESTENT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI AS C ';
  strSQL := strSQL + '  JOIN CADCID AS   D1 ON D1.CID_CODCID            = C.CLI_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADCID D2 ON IFNULL(C.CLI_CIDCOB, "") = IFNULL(D2.CID_CODCID, "") ';
  strSQL := strSQL + '  LEFT JOIN CADCID D3 ON IFNULL(C.CLI_CIDENT, "") = IFNULL(D3.CID_CODCID, "") ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  C.CLI_CODCLI = :CODCLI ';

  qryGenGb1.SQL.Clear;
  qryGenGb1.SQL.Add(strSQL);
  qryGenGb1.Open;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   R.*, ';
  strSQL := strSQL + '   O.OPE_NOMOPE AS OPE_NOMOPE, ';
  strSQL := strSQL + '   P.POR_NOMPOR AS POR_NOMPOR ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strNomeTabela + ' R ';
  strSQL := strSQL + '   JOIN CADOPE      O ON R.CTR_CODVEN = O.OPE_CODOPE ';
  strSQL := strSQL + '   LEFT JOIN CADPOR P ON R.CTR_CODPOR = P.POR_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  R.CTR_VALDUP > 0 AND ';
  strSQL := strSQL + '  R.CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  R.CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  R.CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  R.CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  R.CTR_CODCLI = :CODCLI ';

  qryGenRe2.SQL.Clear;
  qryGenRe2.SQL.Add(strSQL);
  qryGenRe2.Open;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SUM(CTR_VALDUP) AS CTR_TOTDUP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP';

  qryGenRec.SQL.Clear;
  qryGenRec.SQL.Add(strSQL);
  qryGenRec.Open;

  pAtribuiCamposUso;
end;

{********************************************}
{* FINALIZA A VARIAVEL DO TIPO 'TCamposUso' *}
{*****************************************MV*}
procedure TfrmImpBoletoIndiv.pFinalizaCamposUso;
begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
end;

procedure TfrmImpBoletoIndiv.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmImpBoletoIndiv.btnConfigurarClick]');
    End;
  End;

  pFreeAndNil(frmCadConfRelatorios);

  If cdsConsulta.Active Then
    pSetFocus(cxgDuplicatas)
  Else
    pSetFocus(edtCodCli);
end;

procedure TfrmImpBoletoIndiv.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    strSenha: String;
begin
  inherited;
  If (Shift = [ssShift]) And (Key = VK_F7) Then
  Begin
    If blnLibCnf Then
    Begin
      blnLibCnf            := False;
      pnlBotoesBaixa.Color := clBtnFace;
    End
    Else
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If strSenha = SEN_CNF Then
        Begin
          blnLibCnf            := True;
          pnlBotoesBaixa.Color := clNavy;
        End;
      End;
    End;
  End

  Else If (Shift = [ssShift]) And (Key = VK_F9) Then
  Begin
    Key := 0;
    If blnLibCnf Then
    Begin
      pCriarForm(TfrmCnfBoleto, frmCnfBoleto);
    End;
  End

  Else If (Key = VK_F4) Then
  Begin
    Key := 0;
    btnSelTodos.Click;
  End

  Else If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End

  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End

  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End

  Else If (Key = VK_RETURN) And ((ActiveControl) is TRadioButton) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmImpBoletoIndiv.FormShow(Sender: TObject);
begin
  inherited;
  pOnShow;
end;

procedure TfrmImpBoletoIndiv.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmImpBoletoIndiv.pCarregaPortador;
begin
  pPesquisaCadPor(qryConPor, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmImpBoletoIndiv.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpBoletoIndiv.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPor : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     edtDesPor,
                     Nil,
                     Key,
                     arrPor,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     True,
                     edtCodEmp.Text) Then
    Begin
      If fValidaCampos(edtCodPor) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmImpBoletoIndiv.pAlterarFiltro;
begin
  Self.Enabled := False;
  pDeletaTemporaria;
  pLimpaDados;
//  pSetFocus(edtCodCli);
  Self.Enabled := True;
end;


procedure TfrmImpBoletoIndiv.pAtribuiCamposUso;
begin
  If Assigned(cpuCampos) Then
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;
  cpuCampos.AdicionaCampos(qryGenGb1, 'CADCLI');

  strCodCli := qryGenGb1.FieldByName('CLI_CODCLI').AsString;
  strNomCli := qryGenGb1.FieldByName('CLI_NOMCLI').AsString;
  strInsEst := qryGenGb1.FieldByName('CLI_I_E_S_').AsString;

  {***************************************************************}
  {* GUARDO O CGC/CPF DO CLIENTE PARA PODER FORMATA-LO NO CNFBOL *}
  {************************************************************AC*}
  If (Length(AnsiReplaceStr(qryGenGb1.FieldByName('CLI_C_G_C_').AsString, '.', '')) = 11) Then
    strCLICGC := Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,1,3) + '.' +
                 Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,4,3) + '.' +
                 Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,7,3) + '-' +
                 Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,10,2)
  Else
    strCLICGC := Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,1,2) + '.' +
                 Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,3,3) + '.' +
                 Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,6,3) + '/' +
                 Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,9,4) + '-' +
                 Copy(qryGenGb1.FieldByName('CLI_C_G_C_').AsString,13,2);

  If (qryGenGb1.FieldByName('CLI_ENDCOB').IsNull) Or (qryGenGb1.FieldByName('CLI_ENDCOB').AsString = '') Then
    strEndCli := qryGenGb1.FieldByName('CLI_ENDERE').AsString + ', ' + qryGenGb1.FieldByName('CLI_ENDNUM').AsString 
  Else
    strEndCli := qryGenGb1.FieldByName('CLI_ENDCOB').AsString;

  If (qryGenGb1.FieldByName('CLI_ENDCOB').IsNull) Or (qryGenGb1.FieldByName('CLI_ENDCOB').AsString = '') Then
    strCidCli := qryGenGb1.FieldByName('CID_NOMCID').AsString
  Else
    strCidCli := qryGenGb1.FieldByName('CID_CIDCOB').AsString;

  If (qryGenGb1.FieldByName('CLI_ENDCOB').IsNull) Or (qryGenGb1.FieldByName('CLI_ENDCOB').AsString = '') Then
    strEstCli := qryGenGb1.FieldByName('CID_ESTADO').AsString
  Else
    strEstCli := qryGenGb1.FieldByName('CID_ESTCOB').AsString;

  {***********************************************************}
  {* GUARDO O CEP DO CLIENTE PARA PODER FORMATA-LO NO CNFBOL *}
  {********************************************************AC*}
  If (qryGenGb1.FieldByName('CLI_ENDCOB').IsNull) Or (qryGenGb1.FieldByName('CLI_ENDCOB').AsString = '') Then
    strCLICEP := Copy(qryGenGb1.FieldByName('CLI_C_E_P_').AsString,1,5) + '-' + Copy(qryGenGb1.FieldByName('CLI_C_E_P_').AsString,6,3)
  Else
    strCLICEP := Copy(qryGenGb1.FieldByName('CLI_CEPCOB').AsString,1,5) + '-' + Copy(qryGenGb1.FieldByName('CLI_CEPCOB').AsString,6,3);

  {************************************************************}
  {* -----------------------> ATENÇÃO <---------------------- *}
  {*                                                          *}
  {* NÃO ALTERAR O NOME "FIXO" 'CADREC' NA CHAMADA DESSA      *}
  {* FUNÇÃO!! O NOME DESSA TABELA DEVE SER O MESMO CADASTRADO *}
  {* NO ARQUIVO DE CONFIGURAÇÕES 'CNFBOL'                     *}
  {*********************************************************MV*}
  //cpuCampos.AdicionaCampos(frmModuloSPR.qryGen005, strNomeTabela);
  cpuCampos.AdicionaCampos(qryGenRe2, 'CADREC');
  cpuCampos.AdicionaCampos(qryGenRec, 'CADREC');

  fltValDes := qryGenRe2.FieldByName('CTR_VALDES').AsFloat;
  strUltPar := fRetUltimaParcela(qryGenRe2.FieldByName('CTR_CODCLI').AsString, qryGenRe2.FieldByName('CTR_CODEMP').AsString,
                                 qryGenRe2.FieldByName('CTR_NUMDUP').AsString, qryGenRe2.FieldByName('CTR_ESPDOC').AsString);

  If qryGenRe2.FieldByName('CTR_VALDUP').AsString <> '' Then
  Begin
    strExtenso := fRetExtensoNumero(AnsiReplaceStr(qryGenRe2.FieldByName('CTR_VALDUP').AsString,'-',''));
    strValExt  :=  AnsiUpperCase(Copy(strExtenso,1,50));
    strValExt2 := AnsiUpperCase(Copy(strExtenso,50,100));
  End;
end;

function TfrmImpBoletoIndiv.fPesqSeqBai(strNumDup, strParcel, strEspDoc, strCodCli, strCodEmp: String): Boolean;
var
  QryAux: TUniQuery;
  strSQL   : String;
begin
  QryAux := fCriaQuery;

  Result := False;
  strSQL := '';
  strSQL := strSQL + ' SELECT CTR_SEQBAI FROM CADREC ';
  strSQL := strSQL + ' WHERE CTR_SEQBAI <> 0 AND ';
  strSQL := strSQL + '       CTR_NUMDUP = :NUMDUP AND ' ;
  strSQL := strSQL + '       CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '       CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '       CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '       CTR_CODEMP = :CODEMP ';

  Try
    With QryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := True;
    End;
  Finally
    FreeAndNil(QryAux);
  End;
end;

function TfrmImpBoletoIndiv.fReimpressaoBoleto:Integer;
  Var
    intRecNo: Integer;
    prcScroll : TprcScroll;
    I: Integer;
begin

  With cdsConsulta Do
  Begin
    intRecNo := RecNo;
    pDisableControls(cdsConsulta, prcScroll);
    Filter := '(CTR_MARDES = ''M'') AND ((CTR_NOSNUM IS NOT NULL) OR (CTR_BCOBOL = '+QuotedStr('999')+' AND CTR_DTABOL IS NOT NULL))';
    Filtered := True;

    Result := RecordCount;

    strBoletoImpresso := '';

    if (Result > 0) then
    begin
      First;
      objMsg.Clear;
      objMsg.pAddTexto('Existe(m) boleto(s) já impresso(s)');

      for I := 1 to CdsConsulta.RecordCount do
      begin
        strBoletoImpresso := '';

        strBoletoImpresso := IfThen(fEmptyStr(FieldByName('CTR_NUMDUP').AsString),'', ' Duplicata: ' + cdsConsulta.FieldByName('CTR_NUMDUP').AsString + ' ') +
        IfThen(fEmptyStr(FieldByName('CTR_CODEMP').AsString),'', ' Emp: ' + cdsConsulta.FieldByName('CTR_CODEMP').AsString + ' ') +
        IfThen(fEmptyStr(FieldByName('CTR_BCOBOL').AsString),'', ' Banco: ' + cdsConsulta.FieldByName('CTR_BCOBOL').AsString + ' ') +
        IfThen(fEmptyStr(FieldByName('CTR_BCOBOL').AsString),'', ' Carteira: ' + cdsConsulta.FieldByName('CTR_CARTEI').AsString + ' ') +
        IfThen(fEmptyStr(FieldByName('CTR_NOSNUM').AsString),'', ' Nosso Núm: ' + cdsConsulta.FieldByName('CTR_NOSNUM').AsString + ' ');

        objMsg.pAddTexto(strBoletoImpresso);
        CdsConsulta.Next;
      end;
    end;

    Filtered := False;
    RecNo := intRecNo;
    pEnableControls(cdsConsulta, prcScroll);
  End;
end;

function TfrmImpBoletoIndiv.fAlteraVencimento: Boolean;
var
  fltPerJur, fltPerMul, fltValDup, fltValdes, fltValAcr: Double;
  dteDataVenc: TDate;
  frmAlteraVencimento : TfrmAlteraVencimento;
begin
  pCriarFormularios(TfrmAlteraVencimento, frmAlteraVencimento);
  try
    frmAlteraVencimento.dteDataVenc   := cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime;
    frmAlteraVencimento.fltValDup     := cdsConsulta.FieldByName('CTR_VALDUP').AsFloat;
    frmAlteraVencimento.fltDesSuj     := cdsConsulta.FieldByName('CTR_DESSUJ').AsFloat;
    frmAlteraVencimento.fltJurSuj     := cdsConsulta.FieldByName('CTR_JURSUJ').AsFloat;
    frmAlteraVencimento.fltDesCob     := cdsConsulta.FieldByName('CTR_DESCOB').AsFloat;
    frmAlteraVencimento.strAutoincrem := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    frmAlteraVencimento.strBcoBol     := cdsConsulta.FieldByName('CTR_BCOBOL').AsString;
    frmAlteraVencimento.blnBoletoIndiv := True;
    frmAlteraVencimento.ShowModal;
    If frmAlteraVencimento.blnConfirma Then
    Begin
      fltPerJur := frmAlteraVencimento.fltTaxaJuros;
      fltPerMul := frmAlteraVencimento.fltTaxaMulta;
      dteDataVenc := frmAlteraVencimento.dteDataVenc;

      If (fCfgSis('UTDEFN') = '1') Or (cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime >= dteDataVenc) Then
        fltValdes := cdsConsulta.FieldByName('CTR_DESSUJ').AsFloat
      Else
        fltValdes := 0;

      fltValDup := cdsConsulta.FieldByName('CTR_VALDUP').AsFloat -
                   fltValdes +
                   cdsConsulta.FieldByName('CTR_JURSUJ').AsFloat +
                   cdsConsulta.FieldByName('CTR_DESCOB').AsFloat;

      fltValAcr := fCalculaJurosCadCtr(cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime,
                                       DateToStr(dteDataVenc),
                                       fltValDup, fltPerJur, fltPerMul, 9999, cdsConsulta.FieldByName('CTR_BCOBOL').AsString);

      cdsConsulta.Edit;
      cdsConsulta.FieldByName('CTR_VNCALT').AsString   := 'S';
      cdsConsulta.FieldByName('CTR_JURALT').AsFloat    := fFormataFloat(fltPerJur,2);
      cdsConsulta.FieldByName('CTR_MULALT').AsFloat    := fFormataFloat(fltPerMul,2);
      cdsConsulta.FieldByName('CTR_JURSUJ').AsFloat    := cdsConsulta.FieldByName('CTR_JURSUJ').AsFloat + fltValAcr;
      cdsConsulta.FieldByName('CTR_DTAANT').AsDateTime :=  cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime;
      cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime := dteDataVenc;
      cdsConsulta.FieldByName('CTR_CORANT').AsFloat    := cdsConsulta.FieldByName('CTR_VALCOR').AsFloat;
      cdsConsulta.FieldByName('CTR_VALCOR').AsFloat    := cdsConsulta.FieldByName('CTR_VALDUP').AsFloat -
                                                          fltValdes +
                                                          cdsConsulta.FieldByName('CTR_JURSUJ').AsFloat +
                                                          cdsConsulta.FieldByName('CTR_DESCOB').AsFloat;
      cdsConsulta.Post;

      Result := True;
    End
    Else
      Result := False;
  finally
    FreeAndNil(frmAlteraVencimento);
  end;
end;

function TfrmImpBoletoIndiv.fGeraListaBancosEnvio: TStringList;
  Var
    intRecNo: Integer;
    prcScroll : TprcScroll;
begin

  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;

  Try

    With cdsConsulta Do
    Begin
      intRecNo := RecNo;
      pDisableControls(cdsConsulta, prcScroll);
      Filter := '(CTR_MARDES = ''M'')';
      Filtered := True;

      First;
      While Not Eof Do
      Begin
        Result.Add(FieldByName('CTR_CHAVE').AsString);
        Next;
      End;

      Filtered := False;
      RecNo := intRecNo;
      pEnableControls(cdsConsulta, prcScroll);
    End;

  Finally

  End;

end;

function TfrmImpBoletoIndiv.fInformacaoDesatualizada: Boolean;
  Var
    intRecNo: Integer;
    prcScroll : TprcScroll;
    I: Integer;
    qryCons: TUniQuery;
begin
  objMsg.Clear;

  With cdsConsulta Do
  Begin
    intRecNo := RecNo;
    pDisableControls(cdsConsulta, prcScroll);

    Filter := '(CTR_MARDES = ''M'')';
    Filtered := True;

    If RecordCount > 0 Then
    Begin
      While Not Eof Do
      Begin
        qryCons := fCriaQuery;
        qryCons.Sql.Clear;
        qryCons.Sql.Text := ' SELECT CTR_NOSNUM FROM CADREC WHERE AUTOINCREM = :AUTOINC ' ;
        qryCons.ParamByName('AUTOINC').AsString := FieldByName('AUTOINCREM').AsString;

        qryCons.Open;

        strBoletoImpresso := '';

        If  (FieldByName('CTR_NOSNUM').Value <> qryCons.FieldByName('CTR_NOSNUM').Value) Then
        Begin
          objMsg.Clear;

          objMsg.pAddTexto('Existe(m) boleto(s) atualizados');

          for I := 1 to CdsConsulta.RecordCount do
          begin
            strBoletoImpresso := '';

            strBoletoImpresso := IfThen(fEmptyStr(FieldByName('CTR_NUMDUP').AsString),'', ' Duplicata: ' + cdsConsulta.FieldByName('CTR_NUMDUP').AsString + ' ') +
            IfThen(fEmptyStr(FieldByName('CTR_CODEMP').AsString),'', ' Emp: ' + cdsConsulta.FieldByName('CTR_CODEMP').AsString + ' ') +
            IfThen(fEmptyStr(FieldByName('CTR_BCOBOL').AsString),'', ' Banco: ' + cdsConsulta.FieldByName('CTR_BCOBOL').AsString + ' ') +
            IfThen(fEmptyStr(FieldByName('CTR_BCOBOL').AsString),'', ' Carteira: ' + cdsConsulta.FieldByName('CTR_CARTEI').AsString + ' ') +
            IfThen(fEmptyStr(FieldByName('CTR_NOSNUM').AsString),'', ' Nosso Núm: ' + cdsConsulta.FieldByName('CTR_NOSNUM').AsString + ' ');

            objMsg.pAddTexto(strBoletoImpresso);
          end;
        End;

        FreeAndNil(qryCons);

        CdsConsulta.Next;
      End;
    End;

    Filtered := False;
    RecNo := intRecNo;
    pEnableControls(cdsConsulta, prcScroll);
  End;

  If not objMsg.isEmpty Then
    Result := True
  Else
    Result := False;

  objMsg.Clear;
end;

function TfrmImpBoletoIndiv.fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;
   Var
    LDuplicatasComPixGerado: Boolean;
    blnDuplicatasNFNaoAutSefaz: Boolean;//MF: 282523 e 279633 - 15/05/2023
begin
  Result := True;

  FillChar(arrDupSel, SizeOf(arrDupSel), #0);

  cdsConsulta.AfterScroll := Nil;

  LDuplicatasComPixGerado := False;
  blnDuplicatasNFNaoAutSefaz := False;//MF: 282523 e 279633 - 15/05/2023

  cdsConsulta.DisableControls;
  cdsConsulta.First;
  pgbStatus.Properties.Max := cdsConsulta.RecordCount;
  While Not cdsConsulta.Eof Do
  Begin
    If Not cdsConsulta.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
    Begin
      LDuplicatasComPixGerado := True;

      pStep(pgbStatus);
      cdsConsulta.Next;
      Continue;
    End;

    //MF: 282523 e 279633 - 15/05/2023 - ini
    If fVerificarSeOBoletoPodeSerEmitido(cdsConsulta.FieldByName('CTR_ESPDOC').AsString) Then
    Begin
      If Not fVerificaContRecNFAutorizadaSefaz(cdsConsulta.FieldByName('NRODUP').AsString,
                                               cdsConsulta.FieldByName('CTR_CODCLI').AsString,
                                               cdsConsulta.FieldByName('CTR_CODEMP').AsString) Then
      Begin
        blnDuplicatasNFNaoAutSefaz := True;

        pStep(pgbStatus);
        cdsConsulta.Next;
        Continue;
      End;
    End;
    //MF: 282523 e 279633 - 15/05/2023 - fim

    pSelecionaDuplicata(True);
    pStep(pgbStatus);
    cdsConsulta.Next;
  End;

  If (Length(arrDupSel) > 0) Then
  Begin
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConsulta.RecordCount;
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando Duplicatas Vencidas';
    fLiberarDuplicatasVencidas(pgbStatus);
  End;

  If LDuplicatasComPixGerado Then
    fMensagem('ATENÇÃO', 'Algumas duplicatas não foram marcadas pois possui Pix ativo gerado.', ['&Ok']);

  //MF: 282523 e 279633 - 15/05/2023
  If blnDuplicatasNFNaoAutSefaz Then
    fMensagem('ATENÇÃO', 'Existem boletos não selecionados, pois suas respectivas notas fiscais não foram autorizadas na SEFAZ.'+ #13#10 +
                     'Verifique a inconsistência no painel de notas fiscais e regularize para liberar esta operação.', ['&Ok']);

  cdsConsulta.First;
  pAtualizaTemporaria;
  cdsConsulta.AfterScroll := pAtualizaDados;
  pAtualizaDados(cdsConsulta);

  cdsConsulta.EnableControls;
end;

procedure TfrmImpBoletoIndiv.pFormataCampos(DataSet: TDataSet);
  Var
    intIndex: integer;
Begin
  If DataSet.Active Then
    With DataSet, Fields Do
    For intIndex := 1 To Count - 1 Do
    Begin
      If (Fields[intIndex].FieldName <> 'CLI_NOMCLI')
        And (Fields[intIndex].FieldName <> 'COND_PGTO')
        And (Fields[intIndex].FieldName <> 'VENDEDOR') Then
        TStringField(Fields[intIndex]).Alignment := taCenter;

      Case Fields[intIndex].DataType Of

        ftFloat: Begin
                   TFloatField(Fields[intIndex]).DisplayFormat := '#0.00';
                   TFloatField(Fields[intIndex]).Alignment     := taRightJustify;
                 End;

        ftDate : TFloatField(Fields[intIndex]).EditMask        := '99/99/9999;1;_';

      End;
    End;
end;

function TfrmImpBoletoIndiv.fRetClientesBoleto: String;
  Var
    intRecNo: Integer;
    prcScroll: TprcScroll;
    strCodCli: String;
begin

  strCodCli := '';
  intRecNo  := 0;

  With cdsConsulta Do
  Try

    intRecNo := RecNo;
    pDisableControls(cdsConsulta, prcScroll);
    Filter := 'CTR_MARDES = ' + QuotedStr('M');
    Filtered := True;

    If Not IsEmpty Then
    Begin
      First;
      While Not Eof Do
      Begin
        If Pos(FieldByName('CTR_CODCLI').AsString, strCodCli) <= 0 Then
          strCodCli := strCodCli + '"' + FieldByName('CTR_CODCLI').AsString + '",';
          
        Next;
      End;
      strCodCli := LeftStr(strCodCli, Length(strCodCli) - 1);
    End;

  Finally
    Filtered := False;
    RecNo := intRecNo;
    pEnableControls(cdsConsulta, prcScroll);
  End;

  Result := strCodCli;

end;

function TfrmImpBoletoIndiv.fRetUltimaParcela(strCodCli, strCodEmp, strNumDup, strEspDoc: String): String;
  Var
    qryTmpPar: TUniQuery;
    strSQL   : String;
begin

  Result := '';

  strSQL := '';
  strSQL := strSQL + ' SELECT CTR_PARCEL          ';
  strSQL := strSQL + '   FROM                     ';
  strSQL := strSQL + '   '+ strNomeTabela          ;
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   CTR_NUMDUP     = :NUMDUP ';
  strSQL := strSQL + '   AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + '   AND CTR_ESPDOC = :ESPDOC ';
  strSQL := strSQL + ' ORDER BY CTR_PARCEL        ';

  qryTmpPar := fCriaQuery;
  Try
    With qryTmpPar Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('ESPDOC').AsString := strEspDoc;
      Open;

      Last;

      If Not IsEmpty Then
        Result := qryTmpPar.FieldByName('CTR_PARCEL').AsString;
    End;
  Finally
    FreeAndNil(qryTmpPar);
  End;
end;

function TfrmImpBoletoIndiv.fLiberaAlteracaoJurosMulta: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  intRecNo  : Integer;
  intAlt    : Integer;
  prcScroll : TprcScroll;
begin
  intAlt := 0;

  fltTaxaJuros    := fCfgSis('JURATR', varDouble);
  fltTaxaMulta    := fCfgSis('MULATR', varDouble);

  intRecNo := cdsConsulta.RecNo;
  pDisableControls(cdsConsulta, prcScroll);
  cdsConsulta.Filter := '(CTR_MARDES = ''M'')';
  cdsConsulta.Filtered := True;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(132);
  objLiberacao.objMsgLibera.pAddTexto('***  ALTERAÇÃO DE JUROS DE CONTAS A RECEBER NÃO PERMITIDO  *** ', alCentro, teAmbos, '', 117);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'     , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'       , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'      , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'       , 22 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'VLR. CORRIGIDO', 16 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , '% JUROS'       , 10 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , '% MULTA'       , 10 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'NOVO VLR. CORRIGIDO'      , 16 , alDireita  , teAutcom);

  objTabela.lstLinhas.Add(objLinha);
  cdsConsulta.First;
  FillChar(arrDupSel, SizeOf(arrDupSel), #0);
  While Not cdsConsulta.Eof Do
  Begin
    If ((fFormataFloat(fltTaxaJuros, 2) <> fFormataFloat(cdsConsulta.FieldByName('CTR_JURALT').AsFloat, 2)) Or
       (fFormataFloat(fltTaxaMulta, 2) <> fFormataFloat(cdsConsulta.FieldByName('CTR_MULALT').AsFloat, 2))) AND
       (cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime <> cdsConsulta.FieldByName('CTR_DTAANT').AsDateTime) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA'    , cdsConsulta.FieldByName('CTR_NUMDUP').AsString + '-' + cdsConsulta.FieldByName('CTR_PARCEL').AsString + '-' +
                                           cdsConsulta.FieldByName('CTR_ESPDOC').AsString + '-' + cdsConsulta.FieldByName('CTR_CODEMP').AsString          , 21 , alEsquerda );
      objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('CTR_DTACAD').AsDateTime)                                 , 10 , alCentro   );
      objLinha.pAddColuna('DT.VENC.'     , FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime)                                 , 10 , alCentro   );
      objLinha.pAddColuna('CLIENTE'      , cdsConsulta.FieldByName('CTR_CODCLI').AsString + '-' + cdsConsulta.FieldByName('CLI_NOMCLI').AsString          , 22 , alEsquerda );
      objLinha.pAddColuna('VLR. CORRIGIDO', FormatFloat('#,##0.00', cdsConsulta.FieldByName('CTR_CORANT').AsFloat)                                        , 16 , alDireita  );
      objLinha.pAddColuna('% JUROS'      , FormatFloat('#,##0.00', cdsConsulta.FieldByName('CTR_JURALT').AsFloat)                                         , 10 , alDireita  );
      objLinha.pAddColuna('% MULTA'      , FormatFloat('#,##0.00', cdsConsulta.FieldByName('CTR_MULALT').AsFloat)                                         , 10 , alDireita  );
      objLinha.pAddColuna('NOVO VLR. CORRIGIDO'      , FormatFloat('#,##0.00', cdsConsulta.FieldByName('CTR_VALCOR').AsFloat)                             , 16 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);
      Inc(intAlt);
    End;
    cdsConsulta.Next;
  End;
  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.objMsgLibera.pAddTextoCaption('Taxa juros config.'       , FormatFloat('#,##0.00', fltTaxaJuros)                                               , 35);
  objLiberacao.objMsgLibera.pAddTextoCaption('Taxa multa config.'       , FormatFloat('#,##0.00', fltTaxaMulta)                                               , 35);

  objLiberacao.strDirAce := 'ALTJUR';
  objLiberacao.strMsgSen := 'Alteração de juros de contas a receber';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    cdsConsulta.FieldByName('CTR_NUMDUP').AsString,
                    cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                    cdsConsulta.FieldByName('CTR_CODEMP').AsString);

  If intAlt > 0 Then
    Result := objLiberacao.fLibera
  Else
    Result := True;

  cdsConsulta.Filtered := False;
  cdsConsulta.RecNo := intRecNo;
  pEnableControls(cdsConsulta, prcScroll);
end;

function TfrmImpBoletoIndiv.fRetornaHistProrrogacao(strNumDup,strParcel,strEspDoc,
                                                    strCodEmp,strCodCli: String;intSeqBai : Integer): String;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;

begin
  Try
    qryGenRec := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MAX(CTR_DTAALT), ';
    strSQL := strSQL + '  CTR_HISPRO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CTRPRD  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI AND ';
    strSQL := strSQL + '  CTR_HISPRO IS NOT NULL   ';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;
      Result := FieldByName('CTR_HISPRO').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

procedure TfrmImpBoletoIndiv.fClienteTemCreditoDisponivel;
var
  intRecNo  : Integer;
  prcScroll : TprcScroll;
  arrCliente: TArrayString;
begin
  intRecNo := cdsConsulta.RecNo;
  pDisableControls(cdsConsulta, prcScroll);

  try
    cdsConsulta.Filter := '(CTR_MARDES = ''M'')';
    cdsConsulta.Filtered := True;

    try
      cdsConsulta.First;
      SetLength(arrCliente,0);

      While Not cdsConsulta.Eof Do
      Begin
        SetLength(arrCliente, length(arrCliente) + 1);
        arrCliente[Pred(length(arrCliente))] := cdsConsulta.FieldByName('CTR_CODCLI').AsString;

        cdsConsulta.Next;
      End;

      if length(arrCliente) > 0 then
        fAvisoClienteTemCreditoDisponivel(arrCliente);

    finally
      cdsConsulta.Filtered := False;
      cdsConsulta.RecNo := intRecNo;
    end;

  finally
    pEnableControls(cdsConsulta, prcScroll);
  end;
end;

function TfrmImpBoletoIndiv.fLiberaAlteracaoVencimento: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
  intRecNo  : Integer;
  intDtaAlt : Integer;
  prcScroll : TprcScroll;
begin
  intDtaAlt := 0;
  Result := True;

  If (fCfgSis('CTRDTA', varBoolean)) Then
  Begin

    intRecNo := cdsConsulta.RecNo;
    pDisableControls(cdsConsulta, prcScroll);
    cdsConsulta.Filter := '(CTR_MARDES = ''M'')';
    cdsConsulta.Filtered := True;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(120);
    objLiberacao.objMsgLibera.pAddTexto('***  Alteração da data de vencimento do boleto  *** ', alCentro, teAmbos, '', 117);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA'    , 21 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'      , 12 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'     , 12 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'      , 38 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'VR.DUPLICATA' , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'NOVA DT.VENC.', 12 , alCentro   , teAutcom);
    objTabela.lstLinhas.Add(objLinha);
    cdsConsulta.First;
    FillChar(arrDupSel, SizeOf(arrDupSel), #0);
    While Not cdsConsulta.Eof Do
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      If cdsConsulta.FieldByName('CTR_DTAVEN').AsString <> cdsConsulta.FieldByName('CTR_DTAANT').AsString Then
      Begin
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DUPLICATA'    , cdsConsulta.FieldByName('CTR_NUMDUP').AsString + '-' + cdsConsulta.FieldByName('CTR_PARCEL').AsString + '-' +
                                             cdsConsulta.FieldByName('CTR_ESPDOC').AsString + '-' + cdsConsulta.FieldByName('CTR_CODEMP').AsString          , 21 , alEsquerda );
        objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('CTR_DTACAD').AsDateTime)                                 , 12 , alCentro   );
        objLinha.pAddColuna('DT.VENC.'     , FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('CTR_DTAANT').AsDateTime)                                 , 12 , alCentro   );
        objLinha.pAddColuna('CLIENTE'      , cdsConsulta.FieldByName('CTR_CODCLI').AsString + '-' + cdsConsulta.FieldByName('CLI_NOMCLI').AsString          , 38 , alEsquerda );
        objLinha.pAddColuna('VR.DUPLICATA' , FormatFloat('#,##0.00', cdsConsulta.FieldByName('CTR_VALDUP').AsFloat)                                         , 12 , alDireita  );
        objLinha.pAddColuna('NOVA DT.VENC.', FormatDateTime('dd/MM/yyyy', cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime)                                 , 12 , alCentro   );
        objTabela.lstLinhas.Add(objLinha);
        Inc(intDtaAlt);
      End;
      cdsConsulta.Next;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    objLiberacao.strDirAce := 'ALTBOLVENC';
    objLiberacao.strSenLib := fCfgSis('CTRSDV');
    objLiberacao.strMsgSen := 'Alteração da data de vencimento do boleto.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.objMsgLibera.strTitulo := 'Alteração da data de vencimento do boleto.';

    objLiberacao.pInformaNumDocEspDocCodEmp(
                        cdsConsulta.FieldByName('CTR_NUMDUP').AsString,
                        cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                        cdsConsulta.FieldByName('CTR_CODEMP').AsString);

    If intDtaAlt > 0 Then
      Result := objLiberacao.fLibera
    Else
      Result := True;

    cdsConsulta.Filtered := False;
    cdsConsulta.RecNo := intRecNo;
    pEnableControls(cdsConsulta, prcScroll);
  End;
end;

function TfrmImpBoletoIndiv.fLiberaImpressaoBaixaParcial: Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    intRecNo  : Integer;
    intBaiPar : Integer;
    prcScroll : TprcScroll;
begin
  intBaiPar := 0;

  intRecNo := cdsConsulta.RecNo;
  pDisableControls(cdsConsulta, prcScroll);
  cdsConsulta.Filter := '(CTR_MARDES = ''M'')';
  cdsConsulta.Filtered := True;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('***  REIMPRIMIR BOLETOS BAIXADOS PARCIALMENTE  ***', alCentro, teAmbos, '', 118);
  objLiberacao.objMsgLibera.pAddSeparador(118);
  objLiberacao.objMsgLibera.pAddTexto('Atenção! É de responsábilidade da empresa acessar o sistema do banco e alterar o valor do boleto que será reimpresso.');
  objLiberacao.objMsgLibera.pAddTexto('Não poderá ser enviada uma nova remessa bancária desse boleto com o novo valor, porque o nosso número já consta');
  objLiberacao.objMsgLibera.pAddTexto('no sistema bancário.');
  objLiberacao.objMsgLibera.pAddSeparador(118);
  objLiberacao.objMsgLibera.pAddTexto('***  Reimprimir boletos baixados parcialmente  ***', alCentro, teAmbos, '', 118);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'    , 14 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'ESP.'         , 4  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'EMP'          , 3  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'      , 26 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'BANCO'        , 5  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'NOSSO NÚMERO' , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DATA ENVIO'   , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VALOR ANTIGO' , 13 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VALOR NOVO'   , 12 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);
  cdsConsulta.First;
  While Not cdsConsulta.Eof Do
  Begin
    If (cdsConsulta.FieldByName('CTR_SEQBAI').AsInteger = 0) and
       fPesqSeqBai(cdsConsulta.FieldByName('NRODUP').AsString,
                   cdsConsulta.FieldByName('CTR_PARCEL').AsString,
                   cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                   cdsConsulta.FieldByName('CTR_CODCLI').AsString,
                   cdsConsulta.FieldByName('CTR_CODEMP').AsString) And
       (fEmptyStr(cdsConsulta.FieldByName('CTR_LINDIG').AsString)) And
       (((cdsConsulta.FieldByName('CTR_DTABOL').AsDateTime > 0) And
        (Not fEmptyStr(cdsConsulta.FieldByName('CTR_NOSNUM').AsString)) And
        (Not fEmptyStr(cdsConsulta.FieldByName('CTR_BCOBOL').AsString))
       ) Or
       ((Not fEmptyStr(cdsConsulta.FieldByName('CTR_BCOBOL').AsString)) And
        (cdsConsulta.FieldByName('CTR_DTAENV').AsDateTime > 0) And
        (fEmptyStr(cdsConsulta.FieldByName('CTR_NOSNUM').AsString)) And
        (cdsConsulta.FieldByName('CTR_DTABOL').AsDateTime <= 0)
       )) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA'    , cdsConsulta.FieldByName('CTR_NUMDUP').AsString                                                        , 14 , alEsquerda );
      objLinha.pAddColuna('ESP.'         , cdsConsulta.FieldByName('CTR_ESPDOC').AsString                                                        , 4  , alCentro   );
      objLinha.pAddColuna('EMP'          , cdsConsulta.FieldByName('CTR_CODEMP').AsString                                                        , 3  , alCentro   );
      objLinha.pAddColuna('CLIENTE'      , cdsConsulta.FieldByName('CTR_CODCLI').AsString + '-' + cdsConsulta.FieldByName('CLI_NOMCLI').AsString , 26 , alEsquerda );
      objLinha.pAddColuna('BANCO'        , cdsConsulta.FieldByName('CTR_BCOBOL').AsString                                                        , 5  , alCentro   );
      objLinha.pAddColuna('NOSSO NÚMERO' , cdsConsulta.FieldByName('CTR_NOSNUM').AsString                                                        , 12 , alCentro   );
      objLinha.pAddColuna('DATA ENVIO'   , cdsConsulta.FieldByName('CTR_DTAENV').AsString                                                        , 10 , alCentro   );
      objLinha.pAddColuna('VALOR ANTIGO' , FormatFloat('#,##0.00', fStrToFloat(cdsConsulta.FieldByName('CTR_VALORI').AsString))                  , 13 , alDireita  );
      objLinha.pAddColuna('VALOR NOVO'   , FormatFloat('#,##0.00', fStrToFloat(cdsConsulta.FieldByName('CTR_VALCOR').AsString))                  , 12 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);
      inc(intBaiPar);
    End;
    cdsConsulta.Next;
  End;
  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
  objLiberacao.strDirAce := 'RIMPPARCIAL';
  objLiberacao.strSenLib := fCfgSis('LIBBOL');
  objLiberacao.strMsgSen := 'Reimprimir boletos baixados parcialmente.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                      cdsConsulta.FieldByName('CTR_NUMDUP').AsString,
                      cdsConsulta.FieldByName('CTR_ESPDOC').AsString,
                      cdsConsulta.FieldByName('CTR_CODEMP').AsString);

  If (intBaiPar > 0) Then
  Begin
    If Not objLiberacao.fLibera Then
    begin
      blnReImprimeParcial := False;
      Result := False;
    end
    else
    begin
      blnReImprimeParcial := True;
      Result := True;
    end;
  End
  Else
    Result := True;
  cdsConsulta.Filtered := False;
  cdsConsulta.RecNo := intRecNo;
  pEnableControls(cdsConsulta, prcScroll);
end;

function TfrmImpBoletoIndiv.fLiberarDuplicatasVencidas(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    intCnt : Integer;
    strSavIndex : String;
begin
  Result := True;

  strSavIndex := cdsConsulta.IndexFieldNames;
  Try
    cdsConsulta.IndexFieldNames := 'CTR_NUMDUP;CTR_ESPDOC;CTR_CODEMP';
    For intCnt := Low(arrDupSel) To High(arrDupSel) Do
    Begin
      If cdsConsulta.FindKey([arrDupSel[intCnt].strNumDoc + arrDupSel[intCnt].strParcel,
                              arrDupSel[intCnt].strEspDoc,
                              arrDupSel[intCnt].strCodEmp]) Then
        pMarcaDuplicata(True);
        pStep(pgbStatus);
    End;
  Finally
    cdsConsulta.IndexFieldNames := strSavIndex;
    FillChar(arrDupSel, SizeOf(arrDupSel), #0);
  End;
end;

procedure TfrmImpBoletoIndiv.pAdicionarDuplicataVencidaTrava;
begin
  SetLength(arrDupSel, Length(arrDupSel) + 1);
  arrDupSel[Length(arrDupSel) - 1].strNumDoc := cdsConsulta.FieldByName('NRODUP').AsString;
  arrDupSel[Length(arrDupSel) - 1].strEspDoc := cdsConsulta.FieldByName('CTR_ESPDOC').AsString;
  arrDupSel[Length(arrDupSel) - 1].strCodEmp := cdsConsulta.FieldByName('CTR_CODEMP').AsString;
  arrDupSel[Length(arrDupSel) - 1].strCodCli := cdsConsulta.FieldByName('CTR_CODCLI').AsString;
  arrDupSel[Length(arrDupSel) - 1].dtaDtaCad := cdsConsulta.FieldByName('CTR_DTACAD').AsDateTime;
  arrDupSel[Length(arrDupSel) - 1].dtaDtaVen := cdsConsulta.FieldByName('CTR_DTAVEN').AsDateTime;
  arrDupSel[Length(arrDupSel) - 1].fltVlrRec := cdsConsulta.FieldByName('CTR_VALDUP').AsFloat;
  arrDupSel[Length(arrDupSel) - 1].strParcel := cdsConsulta.FieldByName('PARDUP').AsString;
  arrDupSel[Length(arrDupSel) - 1].strSeqBai := '';
end;

function TfrmImpBoletoIndiv.fTravaDuplicatasVencidas: Boolean;
  Var
    intCnt : Integer;
    fltTotDup : Double;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    intRecNo  : Integer;
    prcScroll : TprcScroll;
    arrDups   : TArrDupSel;
begin
  intRecNo := cdsConsulta.RecNo;
  pDisableControls(cdsConsulta, prcScroll);
  cdsConsulta.Filter := '(CTR_MARDES = ''M'')';
  cdsConsulta.Filtered := True;

  cdsConsulta.First;
  FillChar(arrDupSel, SizeOf(arrDupSel), #0);
  While Not cdsConsulta.Eof Do
  Begin
    If cdsConsulta.FieldByName('CTR_DTAANT').AsDateTime < VS_Date Then
    Begin
      pAdicionarDuplicataVencidaTrava;
    end;
    cdsConsulta.Next;
  End;

  cdsConsulta.Filtered := False;
  cdsConsulta.RecNo := intRecNo;
  pEnableControls(cdsConsulta, prcScroll);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('IMPRESSÃO DE DUPLICATAS VENCIDAS NÃO PERMITIDO!', alCentro, teAmbos, '', 89);

  fltTotDup := 0;

  objTabela := TRegistroMsgLiberaTabela.Create;
  arrDups := arrDupSel ;
  For intCnt := Low(arrDups) To High(arrDups) Do
  Begin
    fltTotDup := fltTotDup + arrDups[intCnt].fltVlrRec;

    If intCnt = Low(ArrDupSel) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'  , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'    , 21 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CADASTRO', 11 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENCTO'  , 10 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VALOR'      , 19 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);
    End;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DOCUMENTO'  , arrDups[intCnt].strNumDoc +
                                       arrDups[intCnt].strParcel + '-' +
                                       arrDups[intCnt].strEspDoc + '-' +
                                       arrDups[intCnt].strCodEmp                                                   , 17 , alEsquerda );
    objLinha.pAddColuna('CLIENTE'    , arrDups[intCnt].strCodCli + '-' + fRetNomCliente(arrDups[intCnt].strCodCli) , 21 , alEsquerda );
    objLinha.pAddColuna('DT.CADASTRO', FormatDateTime('dd/mm/yyyy', arrDups[intCnt].dtaDtaCad)                     , 11 , alCentro   );
    objLinha.pAddColuna('DT.VENCTO'  , FormatDateTime('dd/mm/yyyy', arrDups[intCnt].dtaDtaVen)                     , 10 , alCentro   );
    objLinha.pAddColuna('VALOR'      , FloatToStrF(arrDups[intCnt].fltVlrRec, ffFixed, 11, 2)                      , 19 , alDireita  );
    objTabela.lstLinhas.Add(objLinha);

    If intCnt = High(ArrDupSel) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''      , 'TOTAL'                                , 65 , alDireita, teAutcom );
      objLinha.pAddColuna('VALOR' , FloatToStrF(fltTotDup, ffFixed, 11, 2) , 19 , alDireita);
      objTabela.lstLinhas.Add(objLinha);

    End;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'IMPBVE';
  objLiberacao.strSenLib := fCfgSisL('IMPBVE');
  objLiberacao.strMsgSen := 'Impressão de duplicatas vencidas';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  If (Length(ArrDupSel) > 0) Then
    Result := objLiberacao.fLibera
  Else
    Result := True;
end;

procedure TfrmImpBoletoIndiv.pBuscarIni;
begin
  If (Not fEmptyStr(frmBaixaBusca.strValorFiltro)) Then
    Begin
      strValorFiltro := frmBaixaBusca.strValorFiltro;
      strCampoFiltro := frmBaixaBusca.strCampoFiltro;
      If Not cdsConsulta.FindFirst Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas de acordo com a busca!', ['&O k']);
      End;
    End;
end;

procedure TfrmImpBoletoIndiv.pBuscarProx;
begin
  If (Not cdsConsulta.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsConsulta.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há duplicatas de acordo com a busca!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmImpBoletoIndiv.pOnShow;
begin
  blnLiberado := fVerificaAcessoSistema('IMPBOLEMP');

  shpEmp.Brush.Color  := clRed;

  If (Not blnLiberado) Then
    edtCodEmp.Enabled := False
  Else
    shpEmp.Brush.Color  := clGreen;

  If Not fEmptyStr(strCodCli) Then
  Begin
    edtCodCli.Text := strCodCli;
    fValidaCampos(edtCodCli, true);
  End;

  If Not fEmptyStr(strNumDoc) Then
  Begin
    mskDtaIni.Text := '';
    mskDtaFin.Text := '';

    edtEspDoc.Text := strEspDoc;
    edtCodEmp.Text := strEmpDoc;

    rdgBoletos.ItemIndex := 1;

    edtEspDoc.Enabled := False;
    edtCodEmp.Enabled := False;
    edtCodCli.Enabled := False;
    edtCodEmp.Enabled := False;
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;

    pCarregaEmpresa;

    Self.Caption := 'Impressão de Boletos (' + strNumDoc + '-' +
      strEspDoc + '-' + strEmpDoc + ')';

    blnImpressaoAutomatica := True;
  End;

  If blnEhBoletoMeiaNota Then
  Begin
    If blnImpressaoAutomatica Then
    Begin
      blnImpressaoAutomatica := False;

      btnConsultar.Click;
      btnSelTodos.Click;
      btnConfirma.Click;

      If blnImprimiuBoletos Then
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    End;
  End;
end;

procedure TfrmImpBoletoIndiv.pOrdenaBoletos(cdsBoletos : TUniClientDataSet);
Var
  intCol : Integer;
begin
  strOrdCampo := '';
  strOrdTipo  := '';

  For intCol := 0 To cxgDuplicatasDados.ColumnCount -1 Do
  Begin
    If cxgDuplicatasDados.Columns[intCol].SortOrder <> soNone Then
    Begin
      strOrdCampo := cxgDuplicatasDados.Columns[intCol].DataBinding.FieldName;
      strOrdTipo  := IIF(cxgDuplicatasDados.Columns[intCol].SortOrder = soDescending,'DESC','ASC');
    End;
  End;

  If Not fEmptyStr(strOrdCampo) Then
    strOrdCampo := strOrdCampo + ';';

  pOrdenaDataSet(cdsBoletos, strOrdCampo, strOrdTipo);
end;

function TfrmImpBoletoIndiv.fDuplicataTravada(strNumDup, strEspDoc, strCodEmp,
  strCodCli, strParcel: String; blnMostraInfo: Boolean): Boolean;
  Var
    strChaLck: String;
    strInfDup: String;
begin
  Application.ProcessMessages;
  Result := False;

  strChaLck := 'CADREC' +
               strNumDup +
               strEspDoc +
               strCodEmp +
               strCodCli;

  If blnMostraInfo Then
  Begin
    strInfDup := ' - ' + strNumDup + '-' +
                         strEspDoc + '-' +
                         strCodEmp;
  End
  Else
    strInfDup := '';

  If Not fEmptyStr(fGetHostLock(strChaLck)) Then
  Begin
    If Assigned(frmWaitWindow) Then
      frmWaitWindow.Hide;
    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck) + strInfDup, ['&OK']);
    Result := True;
    Exit;
  End;

  strChaLck := strChaLck + strParcel;
  If Not objLock.fLock_Unlock(strChaLck, True, False) Then
  Begin

    If Assigned(frmWaitWindow) Then
      frmWaitWindow.Hide;

    If Not fEmptyStr(strInfDup) Then
      strInfDup := strInfDup + ' Parc: ' + strParcel;

    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck) + strInfDup, ['&OK']);
    Result := True;
    Exit;
  End;
end;

function TfrmImpBoletoIndiv.fVerificarSeOBoletoPodeSerEmitido(const strEspDoc: String): Boolean;
begin
  Result := False;

  If (blnEhBoletoMeiaNota) Then
    Exit;

  Result := (strEspDoc = 'NF');
End;

end.
