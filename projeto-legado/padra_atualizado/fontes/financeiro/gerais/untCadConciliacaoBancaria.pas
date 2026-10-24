{***********************}
{* qryConPor -> CADPOR *}
{* qryConEmp -> CADEMP *}
{********************JB*}

unit untCadConciliacaoBancaria;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DB, Uni, MaskEditFocus, AppEvnts,
  UniClientDataSet, UniDataSetProvider, ComCtrls, BitBtnLockedIncrem, untFuncoesSimples,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxLookAndFeels, untTypesSistema,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  System.DateUtils, cxButtons, Datasnap.Provider, cxProgressBar, cxContainer,
  cxGroupBox, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, System.Generics.Collections, untExtratoBaseClass, untFuncoesRel, untFuncoesRel2,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFechamentoFinanceiro,
  untMovBan, untFramePlanoDeContasMaskEdit, dxScreenTip, dxCustomHint, cxHint;

Type
  TRegistrosConciliarBancaria = class
  public
    Conciliado,
    Status,

    AutoIncremsUpdate: String
  End;

type
  TfrmCadConciliacaoBancaria = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    lblCreSel: TLabel;
    lblDebSel: TLabel;
    edtQtdSel: TEditFocus;
    edtCreSel: TEditFocus;
    edtDebSel: TEditFocus;
    edtDebGer: TEditFocus;
    lblDebGer: TLabel;
    edtCreGer: TEditFocus;
    lblCreGer: TLabel;
    Label12: TLabel;
    edtQtdGer: TEditFocus;
    lblDifSel: TLabel;
    edtDifSel: TEditFocus;
    lblDifGer: TLabel;
    edtDifGer: TEditFocus;
    pnlTotalFinal: TPanel;
    lblSaldoFin: TLabel;
    pnlFiltros: TPanel;
    pnlTotalInicial: TPanel;
    lblSaldoAnt: TLabel;
    rdgOpcao: TRadioGroup;
    Label1: TLabel;
    btnConfirmar: TBitBtnLocked;
    pgbProgresso: TProgressBar;
    chkLimFil: TCheckBox;
    lbl1: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    btnConsultar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    cxgConciliacaoBancariaView: TcxGridDBTableView;
    cxgConciliacaoBancariaLevel1: TcxGridLevel;
    cxgConciliacaoBancaria: TcxGrid;
    cmbAnaSin: TComboBox;
    shpMultSel: TShape;
    btnMovBan: TcxButton;
    btnLocRegVin: TBitBtnLocked;
    btnLocContraPart: TBitBtnLocked;
    btnLocContraPartValor: TBitBtnLocked;
    btnManCtp: TBitBtnLocked;
    btnAltDataLancto: TBitBtnLocked;
    tmrPiscarLBL: TTimer;
    grpExtratoPend: TcxGroupBox;
    lblConElePen: TLabel;
    btnConcilExtEletronico: TcxButton;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Panel1: TPanel;
    Shape1: TShape;
    Label8: TLabel;
    Shape2: TShape;
    Label9: TLabel;
    Label3: TLabel;
    Shape3: TShape;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    btnDesmarcarRegistros: TBitBtnLocked;
    btnMarcarRegistros: TBitBtnLocked;
    cxgConciliacaoBancariaViewCODPOR: TcxGridDBColumn;
    cxgConciliacaoBancariaViewDTALAN: TcxGridDBColumn;
    cxgConciliacaoBancariaViewCODOPE: TcxGridDBColumn;
    cxgConciliacaoBancariaViewNUMDOC: TcxGridDBColumn;
    cxgConciliacaoBancariaViewCODCTA: TcxGridDBColumn;
    cxgConciliacaoBancariaViewDESCTA: TcxGridDBColumn;
    cxgConciliacaoBancariaViewVALOR: TcxGridDBColumn;
    cxgConciliacaoBancariaViewCREDEB: TcxGridDBColumn;
    cxgConciliacaoBancariaViewHISBAN: TcxGridDBColumn;
    cxgConciliacaoBancariaViewCODEMP: TcxGridDBColumn;
    cxgConciliacaoBancariaViewDETALH: TcxGridDBColumn;
    cxgConciliacaoBancariaViewSEQTRANSF: TcxGridDBColumn;
    cxgConciliacaoBancariaViewNOMOPE: TcxGridDBColumn;
    cxgConciliacaoBancariaViewSTATUS: TcxGridDBColumn;
    cxgConciliacaoBancariaViewCONCILIADO: TcxGridDBColumn;
    cxgConciliacaoBancariaViewIGNORA: TcxGridDBColumn;
    cxgConciliacaoBancariaViewHISTORICO: TcxGridDBColumn;
    btnTransfBan: TcxButton;
    btnHistMovBan: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    btnManRcb: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConsultarClick(Sender: TObject);
    procedure pMarcarDesmarcarTodos(blnMarcar: Boolean);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure pSelecionaRegistro(Sender: TObject;
                                 AMarcarTodos: Boolean = False;
                                 AMarcando: Boolean = True);
    procedure pSelecionaRegistroAntes(Sender: TObject);
    procedure rdgOpcaoClick(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure cxgConciliacaoBancariaViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgConciliacaoBancariaViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cxgConciliacaoBancariaViewDblClick(Sender: TObject);
    procedure cmbAnaSinClick(Sender: TObject);
    procedure btnMovBanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLocRegVinClick(Sender: TObject);
    procedure btnLocContraPartClick(Sender: TObject);
    procedure btnLocContraPartValorClick(Sender: TObject);
    procedure btnManCtpClick(Sender: TObject);
    procedure btnAltDataLanctoClick(Sender: TObject);
    procedure btnMarcarRegistrosClick(Sender: TObject);
    procedure btnDesmarcarRegistrosClick(Sender: TObject);
    procedure cxgConciliacaoBancariaViewCellClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure tmrPiscarLBLTimer(Sender: TObject);
    procedure btnConcilExtEletronicoClick(Sender: TObject);
    procedure lblConElePenDblClick(Sender: TObject);
    procedure pnlCabecalhoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure rdgOpcaoEnter(Sender: TObject);
    procedure cmbAnaSinEnter(Sender: TObject);
    procedure cxgConciliacaoBancariaViewColumnSizeChanged(
      Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnTransfBanClick(Sender: TObject);
    procedure btnHistMovBanClick(Sender: TObject);
    procedure btnHistMovBanMouseEnter(Sender: TObject);
    procedure btnHistMovBanMouseLeave(Sender: TObject);
    procedure btnManRcbClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    qryConPor   : TUniQuery;
    qryConEmp   : TUniQuery;
    intPosF3    : Integer;
    intPosF4    : Integer;
    fltSaldoIni : Double;
    fltSaldoFin : Double;
    dtaDtaCon   : TDateTime;
    dspTmpMovBan: TUniDataSetProvider;
    cdsTmpMovBan: TUniClientDataSet;
    qryTmpMovBan: TUniQuery;
    dtsTmpMovBan: TDataSource;

    arrPortador : TConsultasArray;
    arrCCusto   : TConsultasArray;
    arrEmpresa  : TConsultasArray;
    strPortador : String;
    strCCusto   : String;
    strEmpresa  : String;
    blnHisBan     : Boolean;
    strCampoChave : String;

    intOpcaoAnt : integer;
    objFechamento: TFechamentoFinanceiro;

    FMovBanVinculadosNaoMarcados: String;
    FExtBanVinculadosNaoMarcados: String;
    dtaDtaLanc  : TDateTime;
    LIndexColumnIgnora : Integer;

    FListaRegistrosAtualizar: TList<TRegistrosConciliarBancaria>;

    Function fProcuraContraPartida(strCreDeb,
      strSeqCtp: String; dteDataLan: TDateTime): String;
//    function fRetornaInfConciliacao: String;

    procedure pCriarTemporaria;
    procedure pDeletarTemporaria;
    procedure pCarregaEmpresa;
    procedure pCarregaPortador;
    procedure pAtualizarMovBan;

    procedure AdicionaRegistroNaListaDeAtualizacao(ADataset: TDataset);
    procedure pAtualizarMovBanAnalitico;
    procedure pAtualizarMovBanSintetico;

    function fDeveAtualizar(ADataset: TDataset): Boolean;

    procedure pCalculaValoresInformativos(blnInicial: Boolean = False);
    procedure pCalculaValoresInicial;
    procedure pSaldoPortador;

    procedure pOpenTemporaria;
///    procedure pAfterScroll(DataSet: TDataSet);

    procedure pCriarColunasGrid;
    procedure pEfetuarUpdate(strCodCta, strAutInc: String; blnConciliar: Boolean; AItemUpdate: TRegistrosConciliarBancaria = Nil); overload;
    procedure pEfetuarUpdate(intPagCon: Integer; strCodCta : String; blnConciliar: Boolean); overload;
    procedure pRestauraGrid(recUltDupBaixada : TUltDupBaixada);
    procedure pChamarManutencaoCtp;
    procedure pChamarManutencaoCtr;

    function fConsultar(pgbStatus: TcxProgressBar) : Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pChamarTelaDetalhe;
    function AlterarDataLanctoMovBan(ADataset: TDataset; ADataAlterada: TDateTime): Boolean;
    procedure pAtualizarRegistroMovBan(strSeqLan: String; blnInserir: Boolean);
    procedure pAtualizaTela;
    procedure dtsTmpMovBanDataChange(Sender: TObject; Field: TField);
    procedure pVerificaLanPenEletronico;
    procedure DesvinculaExtratoEletronicoVarios(AAutoIncrems: String);
    function  fVerificaLancVinculado(strAutoIncrem: String): Boolean;

    function  TemLancamentoVinculadoNaBanExr(ACodCta, AAutInc: String): Boolean; Overload;
    function  TemLancamentoVinculadoNaBanExr(APagCon: Integer; ACodCta : String): Boolean; Overload;

    function  VerificaPortadorContaVinculada(ACodCta, AAutInc: String): Boolean; Overload;
    function  VerificaPortadorContaVinculada(APagCon: Integer; ACodCta : String): Boolean; Overload;

    function  ValidaVinculoLancamentos: Boolean;
    function  ValidaPortadorContaVinculada: Boolean;

    function  fConfirmaSaidaConciliacao: Boolean;
    function  fSeRegistroFoiAlterado: Boolean;
    procedure pReajustaPanelDosBotoes;

    function RetornaAutoIncremDeContraPartida(ADataset: TDataset): String;

    function ValidaDesconciliacaoDeRegistrosVinculadosAoExtrato: Boolean;
    procedure SelecionaRegistrosVinculadosNaoMarcados(ARegistrosMarcados: String);
    function DesconciliaRegistrosVinculadosNaoMarcados(pgbStatus: TcxProgressBar): Boolean;
    function fGetChaveLayoutGrid(TipoAnaSin: String): String;
    procedure TratarExibicaoColunas;
    function fValidaSelecionados(pgbStatus: TcxProgressBar): Boolean;
    function fGetFilterSelecionados: String;
    function fExisteSelecionados: Boolean;
    function fAjustaDataSelecionados(pgbStatus: TcxProgressBar): Boolean;
    function GetIndexColumn(ACampo:String): Integer;
    procedure pShowHint;
    procedure pMarcarCartoes;
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

    function RetornaAutoIncremLancamentosSintetico(ACodCta: String): String; overload;
    function RetornaAutoIncremLancamentosSintetico(APagCon: Integer; ACodCta : String): String; overload;

    Function fRetornaDadosMensagemTrava(AAutoIncrem: String): String;
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;


implementation

uses SysUtils, Variants, Graphics, StrUtils, untPesqAux, untFuncoesConsulta,
     untConsultas, System.UITypes, untFuncoes, untCadMovBancario, untCadCtaPagar,
     untGravando, untCadConcilBancNova, untConsExtBanPen,untLogCba, untCadCtaReceber,
     untRelCbaLogAcompMovBanNovo, untCadRec;

{$R *.dfm}

{*****************}
{* VALIDA CAMPOS *}
{**************RL*}
function TfrmCadConciliacaoBancaria.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited  fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************RL*}
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        mskDtaFin.Clear;
    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************RL*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And
        (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
         (StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If edtCodEmpresa.Text <> '000' Then
        Begin
          pCarregaEmpresa;
          If fEmptyStr(edtDesEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Empresa não está cadastrada!', ['&O k']);
            Result := False;
          End
          Else If (Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtDesEmpresa.Text <> '+1') Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else
        edtDesEmpresa.Text := 'TODAS';
    End

    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        If edtCodPor.Text <> '00000' Then
        Begin
          pCarregaPortador;
          If fEmptyStr(edtNomPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (High(arrEmpresa) > 0) And (Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmpresa)) Then
          Begin
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If (High(arrEmpresa) <= 0) And (Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmpresa.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End
      Else
        edtNomPor.Text := 'TODOS';
    End

    Else If (Sender = fraPlanoDeContas.mskCodCta) Then
    Begin
      If fraPlanoDeContas.mskCodCta.Text <> '0000000' Then
      Begin
        pEdtCodSelectExit(fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, arrCCusto, fRetDescCentroCusto, Nil, 'do Plano de Contas');

        If Length(arrCCusto) = 1 Then
          fraPlanoDeContas.mskCodCta.EditMask := '99.99.999;0;_'
        Else
          fraPlanoDeContas.mskCodCta.EditMask := '';

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
          Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadConciliacaoBancaria.fVerificaLancVinculado(
  strAutoIncrem: String): Boolean;
var
  qryConsulta: TUniQuery;
begin
  Result  := False;
  if strAutoIncrem <> '' then
  begin
    qryConsulta := fCriaQuery;
    with qryConsulta do
    begin
      Sql.Clear;
      Sql.Text := 'SELECT * FROM BANEXR WHERE EXR_BANINC = :BANINC';
      ParamByName('BANINC').AsString := strAutoIncrem;

      Open;

      Result := RecordCount > 0;

      Close;
    end;
    FreeAndNil(qryConsulta);
  end;
end;

function TfrmCadConciliacaoBancaria.TemLancamentoVinculadoNaBanExr(ACodCta, AAutInc: String): Boolean;
  Var
    LMovBan : TUniQuery;
    LSQL: String;
begin
  Try
    Result := True;
    LMovBan := fCriaQuery(Nil);
    LSQL := '';
    LSQL := LSQL + 'SELECT                                    ';
    LSQL := LSQL + '  *                                       ';
    LSQL := LSQL + 'FROM                                      ';
    LSQL := LSQL + '  MOVBAN                                  ';
    LSQL := LSQL + '  LEFT JOIN BANEXR                        ';
    LSQL := LSQL + '    ON EXR_BANINC = MOVBAN.AUTOINCREM     ';
    LSQL := LSQL + '  LEFT JOIN CADPOR                        ';
    LSQL := LSQL + '    ON POR_CODPOR = CTB_CODPOR            ';
    LSQL := LSQL + 'WHERE                                     ';
    LSQL := LSQL + '     CTB_CODCTA = :CODCTA                 ';
    LSQL := LSQL + ' AND CTB_DTACON IS NOT NULL               ';
    LSQL := LSQL + ' AND EXR_BANINC IS NULL                   ';
    LSQL := LSQL + ' AND POR_CCAAUT IS NOT NULL               ';
    LSQL := LSQL + ' AND POR_CONOFX = "S"                     ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      LSQL := LSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      LSQL := LSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      LSQL := LSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If Not fEmptyStr(AAutInc) Then
      LSQL := LSQL + ' AND MOVBAN.AUTOINCREM = :AUTINC ';


     Try
       LMovBan.Close;
       LMovBan.Sql.Clear;
       LMovBan.Sql.Add(LSQL);
       LMovBan.ParamByName('CODCTA').AsString := ACodCta;

       If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
       Begin
         LMovBan.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
         LMovBan.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
       End;

       If Not fEmptyStr(edtCodPor.Text) Then
         pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', LMovBan);

       If Not fEmptyStr(edtCodEmpresa.Text) Then
         pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', LMovBan);

       If Not fEmptyStr(AAutInc) Then
         LMovBan.ParamByName('AUTINC').AsString := AAutInc;

       LMovBan.Open;
       Result := Not LMovBan.IsEmpty; // Select Retorna os lançamento que não tem vinculo com a BANEXR
     Except
       On E : Exception Do
       Begin
         pMensagensErro(E.Message, '[TfrmCadConciliacaoBancaria.TemLancamentoVinculadoNaBanExr]');
       End;
     End;

  Finally
    FreeAndNil(LMovBan);
  End;

end;

function TfrmCadConciliacaoBancaria.GetIndexColumn(ACampo: String): Integer;
  Var
    LContador : Integer;
begin
  Result := -1;

  If ACampo.Equals('IGNORA') And (LIndexColumnIgnora > 0) Then
    Exit(LIndexColumnIgnora);

  For LContador := 0 To cxgConciliacaoBancariaView.ColumnCount - 1 Do
  Begin
    If cxgConciliacaoBancariaView.Columns[LContador].DataBinding.FieldName.Equals(ACampo) Then
      Result := cxgConciliacaoBancariaView.Columns[LContador].Index;
  End;
end;

procedure TfrmCadConciliacaoBancaria.lblConElePenDblClick(Sender: TObject);
var
 ExtBanc: TExtratoBancario;
begin
  inherited;

  ExtBanc := TfrmConsExtBanPen.fMostraCarregandoBanco('', edtCodPor.Text, true);

  if Assigned(ExtBanc) then
  begin
    self.Hide;
    TfrmCadConcilBancNova.pMostraCarregandoExtrato(ExtBanc);

    Self.Show;
  end;

  if edtCodPor.Text <> '' then
    pVerificaLanPenEletronico;

  if not qryTmpMovBan.IsEmpty then
    btnConsultar.Click;
end;

procedure TfrmCadConciliacaoBancaria.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmCadConciliacaoBancaria.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtNomPor,
                   qryConPor,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmpresa.Text) Then
  Begin
    If fValidaCampos(edtCodPor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadConciliacaoBancaria.fConfirmaSaidaConciliacao: Boolean;
begin
  Result := True;
  if fMensagem('Aviso', 'Deseja sair sem a confirmação dessa conciliação?', ['',''], 2) = 2 Then
    Result := False;
end;

function TfrmCadConciliacaoBancaria.fConsultar(pgbStatus: TcxProgressBar): Boolean;
begin
  pgbStatus.Position := 0;
  pStep(pgbStatus);
  pnlFiltros.Enabled := True;

  If btnConsultar.Focused Then
    SelectNext(ActiveControl,True,True);

  pnlCabecalho.Enabled := False;
  pStep(pgbStatus);
  pCriarTemporaria;
  pStep(pgbStatus);

  If Not fEmptyStr(edtCodPor.Text) Then
    pSaldoPortador
  Else
  Begin
    lblSaldoAnt.Caption := '';
    lblSaldoFin.Caption := '';
  End;

  pStep(pgbStatus);
  pCriarColunasGrid;
  pStep(pgbStatus);
  pStep(pgbStatus);
  Result := True;
end;

procedure TfrmCadConciliacaoBancaria.pCarregaEmpresa;
begin

  edtDesEmpresa.Clear;

  pPesquisaCadEmp(Nil, qryConEmp, edtCodEmpresa.Text);
  With qryConEmp Do
  Begin
    edtDesEmpresa.Text := FieldByName('EMP_NOMEMP').AsString
  End;

end;

procedure TfrmCadConciliacaoBancaria.pCarregaPortador;
begin

  edtNomPor.Clear;

  pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString
  End;

end;

procedure TfrmCadConciliacaoBancaria.pChamarManutencaoCtp;
  Var
    LCadCtaPagar: TfrmCadCtaPagar;
begin
  Try

    Try
      pCriarFormularios(TfrmCadCtaPagar, LCadCtaPagar);
      LCadCtaPagar.ShowModal;

      If Not fEmptyStr(LCadCtaPagar.recUltDupBaixada.strSeqLan) Then
        pRestauraGrid(LCadCtaPagar.recUltDupBaixada);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadConciliacaoBancaria.pChamarManutencaoCtp]');
    End;
  Finally
    pFreeAndNil(LCadCtaPagar);
  End;
end;

procedure TfrmCadConciliacaoBancaria.pChamarManutencaoCtr;
  Var
    recUltDupBaixada : TUltDupBaixada;
    frmCadCtaReceber: TfrmCadCtaReceber;
begin
  Try
    pCriarFormularios(TfrmCadCtaReceber, frmCadCtaReceber);
    frmCadCtaReceber.ShowModal;
    recUltDupBaixada := frmCadCtaReceber.recUltDupBaixada;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadConciliacaoBancaria.pChamarManutencaoCtr]');
  End;
  pFreeAndNil(frmCadCtaReceber);

  If Not fEmptyStr(recUltDupBaixada.strSeqLan) Then
    pRestauraGrid(recUltDupBaixada);

end;

procedure TfrmCadConciliacaoBancaria.pChamarTelaDetalhe;
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(78, 5338, [5339,5340,5341,5342,5343],
                        ['SEQLAN'],
                        [cdsTmpMovBan.FieldByName('SEQLAN').AsString],
                        nil,
                        nil,
                        True);
  End;

end;

procedure TfrmCadConciliacaoBancaria.pOpenTemporaria;
Begin
  Try

    With cdsTmpMovBan Do
    Begin
      dtsTmpMovBan.OnDataChange := nil;
      //****************************************//
      // CONFIGURAR FIELDS DA TABELA TEMPORÁRIA //
      //*************************************RL*//
      If (cmbAnaSin.ItemIndex = 0) Then
        (FieldByName('DTALAN') As TDateTimeField).EditMask := '99/99/9999;0';

      (FieldByName('VALOR') As TFloatField).DisplayFormat := '#,###0.00';
      dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'pOpenTemporaria');
      pSetFocus(edtCodPor);
    End;
  End;

End;

//***************************************//
// MONTA TABELA TEMPORÁRIA               //
//************************************RL*//
procedure TfrmCadConciliacaoBancaria.pCriarTemporaria;
  Var
    strSQL : String;
    strAnalitico: String;
begin
  Try
    Screen.Cursor := crSQLWait;
    Application.ProcessMessages;

    pDeletarTemporaria;

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  IF((CTB_DTACON <> 0) AND (CTB_DTACON IS NOT NULL), "S", "N") STATUS, ';
    strSQL := strSQL + '  IF((CTB_DTACON <> 0) AND (CTB_DTACON IS NOT NULL), "X", "") CONCILIADO, ';
    strSQL := strSQL + '  M.CTB_CODPOR AS "CODPOR", ';
    strSQL := strSQL + '  M.CTB_DTALAN AS "DTALAN", ';
    strSQL := strSQL + '  M.CTB_CODOPE AS "CODOPE", ';
    strSQL := strSQL + '  O.OPE_NOMOPE AS "NOMOPE", ';
    strSQL := strSQL + '  M.CTB_NUMDOC AS "NUMDOC", ';
    strSQL := strSQL + '  M.CTB_CODCTA AS "CODCTA", ';
    strSQL := strSQL + '  M.CTB_VALLAN AS "VALOR", ';
    strSQL := strSQL + '  M.CTB_CREDEB AS "CREDEB", ';
    strSQL := strSQL + '  M.CTB_HIST01 AS "HISTORICO", ';
    If blnHisBan Then
      strSQL := strSQL + '  CONCAT(IFNULL(M.CTB_HIST01, "")," ",IFNULL(CTB_HIST02, "")) AS "HISBAN", ';
    strSQL := strSQL + '  M.AUTOINCREM AS "AUTOINCREM", ';
    strSQL := strSQL + '  M.CTB_SEQLAN AS "SEQLAN", ';
    strSQL := strSQL + '  C.CTA_DESCTA AS "DESCTA", ';
    strSQL := strSQL + ' IF(M.CTB_CREDEB = "D", M.CTB_VALLAN, 0) AS GERDEB, ';
    strSQL := strSQL + ' IF(M.CTB_CREDEB = "C", M.CTB_VALLAN, 0) AS GERCRE, ';
    strSQL := strSQL + '  M.CTB_DTACON AS "DTACON", ';
    strSQL := strSQL + '  M.CTB_HORCON AS "HORCON", ';
    strSQL := strSQL + '  M.CTB_OPECON AS "OPECON", ';
    strSQL := strSQL + ' IF(IF((CTB_DTACON <> 0) AND (CTB_DTACON IS NOT NULL), "S", "N") = "S", 1.00, 0.00) AS QTDSEL, ';
//      strSQL := strSQL + ' IF(IF((CTB_DTACON <> "") AND (CTB_DTACON IS NOT NULL), "S", "N") = "S" AND M.CTB_CREDEB = "D", M.CTB_VALLAN, 0) AS TOTDEB, ';
//      strSQL := strSQL + ' IF(IF((CTB_DTACON <> "") AND (CTB_DTACON IS NOT NULL), "S", "N") = "S" AND M.CTB_CREDEB = "C", M.CTB_VALLAN, 0) AS TOTCRE, ';
    strSQL := strSQL + ' IF(M.CTB_CREDEB = "D", M.CTB_VALLAN, 0) AS TOTDEB, ';
    strSQL := strSQL + ' IF(M.CTB_CREDEB = "C", M.CTB_VALLAN, 0) AS TOTCRE, ';
    strSQL := strSQL + '  CTB_SEQCTP AS SEQCTP, ';
    strSQL := strSQL + '  M.CTB_CODEMP AS "CODEMP", ';
    strSQL := strSQL + '  IFNULL(M.CTB_PAGCON, 0) AS "PAGCON", ';
    strSQL := strSQL + '  CTB_ORIGEM AS ORIGEM, ';
    strSQL := strSQL + '  CTB_IGNORA AS IGNORA, ';
    strSQL := strSQL + '  M.CTB_SEQTRF  AS "SEQTRANSF" , ';
    strSQL := strSQL + '  "..." AS DETALH, ';
    strSQL := strSQL + '  (SELECT POR_DTAINI FROM CADPOR WHERE POR_CODPOR = M.CTB_CODPOR) as POR_DTAINI, ';
    strSQL := strSQL + '    COALESCE(CADBAN.BAN_NOMBAN, "") NOMBAN, ';
    strSQL := strSQL + '    IF( ';
    strSQL := strSQL + '      COALESCE(BANMCA.MCA_IDENTI, "") <> "", ';
    strSQL := strSQL + '      IF(BANMCA.MCA_IDENTI = "VALSTA","C", ';
    strSQL := strSQL + '        IF(BANMCA.MCA_IDENTI = "VALTAX","T", "D")),"" ';
    strSQL := strSQL + '    ) AS TIPMOV  ';

    strSQL := strSQL + '  FROM MOVBAN M ';
    strSQL := strSQL + '  LEFT JOIN CADCTA C ON M.CTB_CODCTA = C.CTA_CODCTA ';
    strSQL := strSQL + '  LEFT JOIN CADOPE O ON M.CTB_CODOPE = O.OPE_CODOPE ';

    strSQL := strSQL + '  LEFT JOIN BANMCA                          ';
    strSQL := strSQL + '    ON BANMCA.CTB_SEQLAN = M.CTB_SEQLAN     ';
    strSQL := strSQL + '  LEFT JOIN CADCAR                          ';
    strSQL := strSQL + '    ON CAR_CODCAR = BANMCA.MCA_CODCAR       ';
    strSQL := strSQL + '  LEFT JOIN CADBAN                          ';
    strSQL := strSQL + '    ON CAR_CODBAN = BAN_CODBAN              ';


    strSQL := strSQL + '  WHERE TRUE ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND M.CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'M.CTB_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(M.CTB_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(M.CTB_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + ' AND LOCATE(CTB_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'M.CTB_CODEMP','CODEMP');

    If Not fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
      strSQL := strSQL + fStrLocate(fraPlanoDeContas.mskCodCta, arrCCusto, 'M.CTB_CODCTA', 'CODCTA');

    If rdgOpcao.ItemIndex = 0 Then
      strSQL := strSQL + ' AND M.CTB_DTACON IS NOT NULL '

    Else If rdgOpcao.ItemIndex = 1 Then
      strSQL := strSQL + ' AND M.CTB_DTACON IS NULL ';

    If fCfgSis('USAAUT', varBoolean) Then
      strSQL := strSQL + ' AND M.CTB_TRFLIB<>"N" ';

    strSQL  := strSQL + ' GROUP BY M.AUTOINCREM  ';
    strSQL  := strSQL + ' ORDER BY ';
    strSQL := strSQL  + '   CODPOR, DTALAN, SEQLAN, CREDEB, NUMDOC ';

    strCampoChave := 'AUTOINCREM';

    {*****************************************}
    {* OPÇÃO SINTÉTICO.                      *}
    {**************************************MV*}
    If (cmbAnaSin.ItemIndex = 1) Then
    Begin
      strAnalitico := strSQL;
      strSQL := '';
      strSQL := strSQL + ' SELECT   ';
      strSQL := strSQL + '  STATUS, ';
      strSQL := strSQL + '  CONCILIADO, ';
      strSQL := strSQL + '  CODCTA, ';
      strSQL := strSQL + '  DESCTA, ';
      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  SUM(IF(CREDEB="C", 1, -1) * VALOR) AS VALOR, ';
      strSQL := strSQL + ' SUM(GERDEB) AS GERDEB, ';
      strSQL := strSQL + ' SUM(GERCRE) AS GERCRE, ';
      strSQL := strSQL + ' 0.00 AS QTDSEL, ';
      strSQL := strSQL + ' SUM(TOTCRE) AS TOTCRE, ';
      strSQL := strSQL + ' SUM(TOTDEB) AS TOTDEB  ';
      strSQL := strSQL +  'FROM (' + strAnalitico + ') AS TMP ';
      strSQL := strSQL +  'GROUP BY ';
      strSQL := strSQL +  '  CODCTA ';
      strSQL := strSQL +  'ORDER  BY ';
      strSQL := strSQL +  '  CODCTA ';
      strCampoChave := 'CODCTA';
    End
    Else If (cmbAnaSin.ItemIndex = 2) Then
    Begin
      strAnalitico := strSQL;
      strSQL := '';
      strSQL := strSQL + ' SELECT   ';
      strSQL := strSQL + '  STATUS, ';
      strSQL := strSQL + '  CONCILIADO, ';
      strSQL := strSQL + '  PAGCON, ';
      strSQL := strSQL + '  DTALAN, ';
      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  SUM(IF(CREDEB="C", 1, -1) * VALOR) AS VALOR, ';
      strSQL := strSQL + ' SUM(GERDEB) AS GERDEB, ';
      strSQL := strSQL + ' SUM(GERCRE) AS GERCRE, ';
      strSQL := strSQL + ' 0.00 AS QTDSEL, ';
      strSQL := strSQL + ' SUM(TOTCRE) AS TOTCRE, ';
      strSQL := strSQL + ' SUM(TOTDEB) AS TOTDEB  ';
      strSQL := strSQL + 'FROM (' + strAnalitico + ') AS TMP ';
      strSQL := strSQL + 'GROUP BY PAGCON ';
      strSQL := strSQL + 'ORDER BY PAGCON ';
      strCampoChave := 'PAGCON';
    End
    Else If (cmbAnaSin.ItemIndex = 3) Then
    Begin
      strAnalitico := strSQL;
      strSQL := '';
      strSQL := strSQL + ' SELECT   ';
      strSQL := strSQL + '  STATUS, ';
      strSQL := strSQL + '  CONCILIADO, ';
      strSQL := strSQL + '  PAGCON, ';
      strSQL := strSQL + '  CODCTA, ';
      strSQL := strSQL + '  DESCTA, ';
      strSQL := strSQL + '  DTALAN, ';
      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  SUM(IF(CREDEB="C", 1, -1) * VALOR) AS VALOR, ';
      strSQL := strSQL + ' SUM(GERDEB) AS GERDEB, ';
      strSQL := strSQL + ' SUM(GERCRE) AS GERCRE, ';
      strSQL := strSQL + ' 0.00 AS QTDSEL, ';
      strSQL := strSQL + ' SUM(TOTCRE) AS TOTCRE, ';
      strSQL := strSQL + ' SUM(TOTDEB) AS TOTDEB, ';
      strSQL := strSQL + ' CONCAT(PAGCON, CODCTA) AS PAGCTA ';
      strSQL := strSQL + 'FROM (' + strAnalitico + ') AS TMP ';
      strSQL := strSQL + 'GROUP BY PAGCON, CODCTA ';
      strSQL := strSQL + 'ORDER BY PAGCON, CODCTA ';
      strCampoChave := 'PAGCTA';
    End
    Else If (cmbAnaSin.ItemIndex = 4) Then
    begin
      strAnalitico := strSQL;
      strSQL := '';
      strSQL := strSQL + 'SELECT  ';
      strSQL := strSQL + '  STATUS, ';
      strSQL := strSQL + '  CONCILIADO, ';
      strSQL := strSQL + '  SEQLAN, ';
      strSQL := strSQL + '  CODPOR, ';
      strSQL := strSQL + '  DTALAN, ';
      strSQL := strSQL + '  CODOPE, ';
      strSQL := strSQL + '  NOMOPE, ';
      strSQL := strSQL + '  NUMDOC, ';
      strSQL := strSQL + '  CODCTA, ';
        strSQL := strSQL + '  IF(CREDEB = "C", SUM(GERCRE), SUM(GERDEB)) AS VALOR,';
      strSQL := strSQL + '  CREDEB, ';
      strSQL := strSQL + '  HISTORICO, ';
      If blnHisBan Then
        strSQL := strSQL + '  HISBAN, ';
      strSQL := strSQL + '  AUTOINCREM, ';
      strSQL := strSQL + '  DESCTA, ';
      strSQL := strSQL + '  CODEMP, ';
      strSQL := strSQL + '  SEQTRANSF, ';
      strSQL := strSQL + '  DETALH, ';
      strSQL := strSQL + '  NOMBAN, ';
      strSQL := strSQL + '  TIPMOV, ';
      strSQL := strSQL + ' SUM(GERDEB) AS GERDEB, ';
      strSQL := strSQL + ' SUM(GERCRE) AS GERCRE, ';
      strSQL := strSQL + ' 0.00 AS QTDSEL, ';
      strSQL := strSQL + ' SUM(TOTCRE) AS TOTCRE, ';
      strSQL := strSQL + ' SUM(TOTDEB) AS TOTDEB, ';
      strSQL := strSQL + ' CONCAT(PAGCON, CODCTA) AS PAGCTA, ';
      strSQL := strSQL + ' PAGCON ';
      strSQL := strSQL + 'FROM (' + strAnalitico + ') AS TMP ';
      strSQL := strSQL + 'GROUP BY DTALAN, NOMBAN, TIPMOV ';
      strSQL := strSQL + 'ORDER BY DTALAN, NOMBAN, TIPMOV ';
      strCampoChave := 'CODCTA';
    end;

    With qryTmpMovBan Do
    Begin
      Filter   := '';
      Filtered := False;

      Close;
      cdsTmpMovBan.Close;

      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryTmpMovBan);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryTmpMovBan);

      If Not fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        pSetaParam(fraPlanoDeContas.mskCodCta.Text, arrCCusto, strCCusto, 'CODCTA', qryTmpMovBan);

      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryTmpMovBan);

        dtsTmpMovBan.OnDataChange := nil;

        cdsTmpMovBan.SetProvider(dspTmpMovBan);
        cdsTmpMovBan.Open;

        cdsTmpMovBan.SetProvider(Nil);
        qryTmpMovBan.Close;

        dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
        If cxgConciliacaoBancaria.CanFocus And Self.Enabled Then
          pSetFocus(cxgConciliacaoBancaria);

        pOpenTemporaria;
      End
      Else
      Begin
        fMensagem('', 'Não ha dados a serem exibidos!', ['&Ok']);
        pnlCabecalho.Enabled := True;
        pnlFiltros.Enabled := True;
        pSetFocus(edtCodPor);
        btnCancelarClick(nil);
        Exit;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro('Erro ao tentar abrir consulta.' + Chr(13) + E.Message, '[pCriarTemporaria]');
      pSetFocus(edtCodPor);
    End;
  End;
  Application.ProcessMessages;

  pCalculaValoresInformativos(True);

  pCalculaValoresInicial;

  Screen.Cursor := crDefault;
end;

//***************************************//
// DELETAR TABELA TEMPORÁRIA             //
//************************************RL*//
procedure TfrmCadConciliacaoBancaria.pDeletarTemporaria;
Begin
  With cdsTmpMovBan Do
    If Active Then
      EmptyDataSet;
End;

procedure TfrmCadConciliacaoBancaria.FormCreate(Sender: TObject);
begin
  inherited;
  blnHisBan := (fCfgSis('HISBAN') = 'S');
  pRedimensionarTelaSeguindoMenuIniciar(self);
  //Para resolver problemas com redomensionamento ao usar goglobal
  If Self.Height < 200 Then
  Begin
    Self.Height := Screen.Height - 40;
    Self.Top    := 0;
  End;


  //******************************************//
  // CRIA E CONFIGURA COMPONENTES TEMPORÁRIOS //
  //***************************************RL*//
  qryTmpMovBan := fCriaQuery;
  dtsTmpMovBan := TDataSource.Create(Self);

  dspTmpMovBan := TUniDataSetProvider.Create(Self);
  cdsTmpMovBan := TUniClientDataSet.Create(Self);
  cdsTmpMovBan.AggregatesActive := True;
  cdsTmpMovBan.SetProvider(dspTmpMovBan);

  pCriaAggregate(cdsTmpMovBan, 'QTDSEL', 'TOT_QTDSEL', '#0');
  pCriaAggregate(cdsTmpMovBan, 'TOTCRE', 'TOT_TOTCRE');
  pCriaAggregate(cdsTmpMovBan, 'TOTDEB', 'TOT_TOTDEB');
  pCriaAggregate(cdsTmpMovBan, 'GERDEB', 'TOT_GERDEB');
  pCriaAggregate(cdsTmpMovBan, 'GERCRE', 'TOT_GERCRE');
  pCriaAggregate(cdsTmpMovBan, 'VALOR' , 'TOT_VALOR');

  dspTmpMovBan.DataSet := qryTmpMovBan;

  dtsTmpMovBan.DataSet                                 := cdsTmpMovBan;
  cxgConciliacaoBancariaView.DataController.DataSource := dtsTmpMovBan;

  qryConPor := fCriaQuery(Self);
  qryConEmp := fCriaQuery(Self);

  cxgConciliacaoBancariaViewHISBAN.Visible := blnHisBan;
  cxgConciliacaoBancariaViewHISTORICO.Visible := (blnHisBan = False);

//  pCriarColunasGrid;

end;

procedure TfrmCadConciliacaoBancaria.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);

  If Not untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico Then
    Self.Top := 0;
end;

function TfrmCadConciliacaoBancaria.fGetChaveLayoutGrid(TipoAnaSin: String): String;
begin
  Result := Self.Name + '.' + cxgConciliacaoBancariaView.Name + '.' + TipoAnaSin;
end;

procedure TfrmCadConciliacaoBancaria.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If fVerificaAcessoSistema('frmConsultaCxGridNova') Then
  Begin
     If cdsTmpMovBan.Active Then
        fGetFuncoesCxGrid.pSalvarView(cxgConciliacaoBancariaView,
                                      fGetChaveLayoutGrid(cmbAnaSin.Text),
                                      cdsTmpMovBan,
                                      False,
                                      'S');
  End;

  if Self.Tag <> 2 Then
  Begin
    If fSeRegistroFoiAlterado Then
      if Not fConfirmaSaidaConciliacao Then
      Begin
        Self.Tag := 0;
        Abort;
      End;
  End;

  pDeletarTemporaria;

  FreeAndNil(qryTmpMovBan);
  FreeAndNil(dtsTmpMovBan);

  inherited;

end;

procedure TfrmCadConciliacaoBancaria.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    Self.Tag := 2;
    //If not(cdsTmpMovBan.isEmpty) Then
    If fSeRegistroFoiAlterado Then
      If Not fConfirmaSaidaConciliacao Then
      Begin
        Self.Tag := 0;
        Abort;
      End;

    If (ActiveControl) Is TRadioButton Then
    Begin
      pnlCabecalho.Enabled := True;
      pnlFiltros.Enabled := False;
      btnCancelar.Click;
    End
    Else If ((ActiveControl) <> Nil) And ((ActiveControl.Name) = '') Then
    Begin
      Close;
    End
    Else
    Begin
      SelectNext(ActiveControl, False, True);
    End;

  End
  {Else If (Key = VK_RETURN) Then
      SelectNext(ActiveControl, True, True)}
  Else If (Key = VK_F5) Then
    btnManCtp.Click
  Else If (Key = VK_F11) Then
    btnManRcb.Click
  Else If (Key = VK_F2) And (cmbAnaSin.ItemIndex = 0) Then
    btnLocContraPart.Click
  Else If (Key = VK_F3) And (cmbAnaSin.ItemIndex = 0) Then
    btnLocContraPartValor.Click
  Else If (Key = VK_F4) And (cmbAnaSin.ItemIndex = 0) Then
    btnLocRegVin.Click
  Else If (Key = VK_F6) And (cmbAnaSin.ItemIndex = 0) Then
    btnAltDataLancto.Click
  Else If (Key = VK_F8) Then
    btnMarcarRegistros.Click
  Else If (Key = VK_F9) Then
    btnDesmarcarRegistros.Click
  Else If (Key = VK_F10) Then
    btnConfirmar.Click;
end;

procedure TfrmCadConciliacaoBancaria.FormResize(Sender: TObject);
begin
  inherited;
  pReajustaPanelDosBotoes;
end;

procedure TfrmCadConciliacaoBancaria.FormShow(Sender: TObject);
begin
  inherited;
  btnMovBan.Visible := (rdgOpcao.ItemIndex = 1) And (cmbAnaSin.ItemIndex = 0);
  btnMovBan.Enabled := fVerificaAcessoSistema('frmCadMovBancario');
  btnHistMovBan.Enabled := (fVerificaAcessoSistema('frmRelCbaLogAcompMovBanNovo'));

  btnTransfBan.Visible := False;

  pReajustaPanelDosBotoes;

end;

procedure TfrmCadConciliacaoBancaria.btnConsultarClick(Sender: TObject);
begin
  lblSaldoAnt.Caption := '';
  lblSaldoFin.Caption := '';


  cxgConciliacaoBancariaView.OptionsView.ScrollBars := ssNone;
  If (fVerificaCampos) Then
  Begin
    cdsTmpMovBan.DisableControls;
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.lblGravando.Caption := 'Aguarde... Carregando.';
      frmGravando.strChave := 'PEDCOM';
      frmGravando.fExecutarAcao := fConsultar;
      frmGravando.ShowModal;

      cxgConciliacaoBancariaView.DataController.FocusedRowIndex := 0;

      If Not (cxgConciliacaoBancariaView.DataController.DataSource.DataSet.IsEmpty) Then
         btnTransfBan.Visible := fVerificaAcessoSistema('frmCadMovBancario_Te');

      if edtCodPor.Text <> '' then
        pVerificaLanPenEletronico;
    Except
      On E: Exception Do
      begin
        pMensagensErro(E.Message, '[TfrmCadConciliacaoBancaria.btnConsultarClick]');
        cdsTmpMovBan.EnableControls;
      end;
    End;
    pFreeAndNil(frmGravando);
  {  if (cdsTmpMovBan.Active) and (not cdsTmpMovBan.IsEmpty) then
      cdsTmpMovBan.First;}
    cxgConciliacaoBancariaView.OptionsView.ScrollBars := ssBoth;
    cdsTmpMovBan.Filter := '';
    cdsTmpMovBan.Filtered := False;
    cdsTmpMovBan.EnableControls;
  End;

end;

procedure TfrmCadConciliacaoBancaria.btnDesmarcarRegistrosClick(
  Sender: TObject);
begin
  inherited;
  if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) or (StrToIntDef(Trim(edtQtdSel.Text), 0) <= 0) then
  begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  end;

  If (btnDesmarcarRegistros.Enabled) Then
    pMarcarDesmarcarTodos(False);
end;

procedure TfrmCadConciliacaoBancaria.btnHistMovBanClick(Sender: TObject);
  Var
    frmRelCbaLogAcompMovBanNovo: TfrmRelCbaLogAcompMovBanNovo;
begin
  inherited;
  if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) then
  Begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelCbaLogAcompMovBanNovo, frmRelCbaLogAcompMovBanNovo);
    frmRelCbaLogAcompMovBanNovo.edtNumSeq.Text        := cdsTmpMovBan.FieldByName('SEQLAN').AsString;
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

procedure TfrmCadConciliacaoBancaria.btnHistMovBanMouseEnter(Sender: TObject);
begin
  inherited;
  pShowHint;
end;

procedure TfrmCadConciliacaoBancaria.btnHistMovBanMouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmCadConciliacaoBancaria.btnLocContraPartClick(Sender: TObject);
  Var
    intPosicao : Integer;
    blnAchou   : Boolean;
    strAutoInc : String;
    strCreDeb  : String;
    strTexto   : String;
begin
  inherited;
  if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) then
  begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  end;

  If (btnLocContraPart.Enabled) And (cdsTmpMovBan.Active) Then
  Begin
    {******************************}
    {* GUARDA A POSIÇÃO NA TABELA *}
    {**18/01/2008***************ER*}
    intPosicao := cdsTmpMovBan.Recno;

    repeat

      strAutoInc := cdsTmpMovBan.FieldByName('AUTOINCREM').AsString;

      {*****************************************}
      {* LOCALIZA LANCAMENTO DE CONTRA-PARTIDA *}
      {**18/01/2008*************************ER**}
      If Not fEmptyStr(cdsTmpMovBan.FieldByName('SEQCTP').AsString) Then
      Begin
        {**********************************************}
        {* VERIFICA SE O LANCAMENTO É DE DÉBITO       *}
        {* OU CRÉDITO PARA LOCALIZAR A CONTRA-PARTIDA *}
        {***14/02/2008*****************************ER**}
        If cdsTmpMovBan.FieldByName('CREDEB').AsString = 'C' Then
          strCreDeb := 'D'
        Else
          strCreDeb := 'C';

        blnAchou := cdsTmpMovBan.Locate('SEQCTP;CREDEB;DTALAN', VarArrayOf([cdsTmpMovBan.FieldByName('SEQCTP').Value, strCreDeb, cdsTmpMovBan.FieldByName('DTALAN').Value]),[]);

        If cdsTmpMovBan.Eof Then
          blnAchou := False;
      End
      Else
        blnAchou := False;

    until (Not blnAchou) Or (strAutoInc <> cdsTmpMovBan.FieldByName('AUTOINCREM').AsString);

    If Not blnAchou Then
    Begin
      {************************************************************}
      {* CASO NAO TENHA ACHADO NO GRID, VERIFICA NA TABELA MOVBAN *}
      {* COMPLETA, DESCONSIDERANDO OS FILTROS DA TELA             *}
      {*********************************************************LU*}
      strTexto := fProcuraContraPartida(strCreDeb,
                                        cdsTmpMovBan.FieldByName('SEQCTP').AsString,
                                        cdsTmpMovBan.FieldByName('DTALAN').AsDateTime);
      If Not fEmptyStr(strTexto) Then
        fMensagem('CONTRA-PARTIDA',strTexto, ['&OK'])
      Else
        fMensagem('','Lançamento de contra-partida não encontrado', ['&OK']);
      cdsTmpMovBan.RecNo := intPosicao;
    End;
  End;
end;

procedure TfrmCadConciliacaoBancaria.btnLocContraPartValorClick(
  Sender: TObject);
begin
  inherited;
  if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) then
  begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  end;

  If (btnLocContraPartValor.Enabled) And (cdsTmpMovBan.Active) Then
  Begin
    dtsTmpMovBan.OnDataChange := nil;
    If fEmptyStr(cdsTmpMovBan.Filter) Then
    Begin
      intPosF3 := cdsTmpMovBan.RecNo;
      cdsTmpMovBan.Filter := 'VALOR = ' + AnsiReplaceStr(cdsTmpMovBan.FieldByName('VALOR').AsString,'.','');
      cdsTmpMovBan.Filtered := True;
    End
    Else
    Begin
      cdsTmpMovBan.Filter := '';
      cdsTmpMovBan.Filtered := False;
      cdsTmpMovBan.RecNo := IIF(intPosF3 = 0, 1, intPosF3);
    End;
    dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
  End;
end;

procedure TfrmCadConciliacaoBancaria.btnLocRegVinClick(Sender: TObject);
begin
  inherited;
  if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) then
  begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  end;

  If (btnLocRegVin.Enabled) And (cdsTmpMovBan.Active) Then
  Begin
    dtsTmpMovBan.OnDataChange := nil;
    If fEmptyStr(cdsTmpMovBan.Filter) Then
    Begin
      intPosF4 := cdsTmpMovBan.RecNo;

      If cdsTmpMovBan.FieldByName('PAGCON').AsInteger <> 0 Then
        cdsTmpMovBan.Filter := 'PAGCON = ' + cdsTmpMovBan.FieldByName('PAGCON').AsString +
                               ' AND CODEMP = ' + QuotedStr(cdsTmpMovBan.FieldByName('CODEMP').AsString)
      Else
        cdsTmpMovBan.Filter := 'AUTOINCREM = ' + QuotedStr(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString);

      cdsTmpMovBan.Filtered := True;
    End
    Else
    Begin
      cdsTmpMovBan.Filter := '';
      cdsTmpMovBan.Filtered := False;
      cdsTmpMovBan.RecNo := IIF(intPosF4 = 0, 1, intPosF4);
    End;
    dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
  End;
end;

procedure TfrmCadConciliacaoBancaria.pReajustaPanelDosBotoes;
Var
  intWidth: Integer;
begin
  If (Self.Width <= 1280) Then
  Begin
    pnlBotoes.Height := 68;
    intWidth  := (Self.Width div 4);
    intWidth := intWidth - 4;
    btnSair.Left := btnHistMovBan.Left + 2;
    btnSair.Top := btnManRcb.Top;
  End
  Else
  If (Self.Width > 1280) And (Self.Width <= 1366) Then
  Begin
    pnlBotoes.Height := 48;
    intWidth  := (Self.Width div 6);
    intWidth := intWidth - 2;
    btnSair.Left := btnMarcarRegistros.Left + 2;
    btnSair.Top := btnManRcb.Top + 2;
  End
  Else
  Begin
    pnlBotoes.Height := 48;
    intWidth  := (Self.Width div 8);
    intWidth := intWidth - 2;
    btnSair.Left := btnHistMovBan.Left + 2;
    btnSair.Top := btnManRcb.Top + 2;
  End;

  if (intWidth < 213) Then
    intWidth := 213;

  btnLocContraPart.Width  := intWidth;
  btnLocContraPartValor.Width  := intWidth;
  btnLocRegVin.Width := intWidth;
  btnManCtp.Width := intWidth;
  btnAltDataLancto.Width := intWidth;
  btnMarcarRegistros.Width := intWidth;
  btnDesmarcarRegistros.Width := intWidth;
  btnHistMovBan.Width := intWidth;
  btnConfirmar.Width := intWidth;
  btnManRcb.Width := intWidth;
  btnSair.Width := intWidth;
end;

procedure TfrmCadConciliacaoBancaria.pRestauraGrid(
  recUltDupBaixada: TUltDupBaixada);
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  Try
    Screen.Cursor := crHourGlass;
    pCloneDataSet(cdsClone, cdsTmpMovBan);

    pCriarTemporaria;
    If Not fEmptyStr(edtCodPor.Text) Then
      pSaldoPortador;
    pCriarColunasGrid;

    If (cdsClone.FindField(strCampoChave) <> Nil) And
       (cdsTmpMovBan.FindField(strCampoChave) <> Nil)  Then
    Begin
      cdsTmpMovBan.DisableControls;
      pnlInfo.Caption := 'Aguarde, restaurando seleção do grid...';
      pgbProgresso.Visible := True;

      cdsClone.IndexFieldNames := strCampoChave;
      cdsTmpMovBan.IndexFieldNames := strCampoChave;

      cdsClone.Filter := 'STATUS = ' + QuotedStr('S');
      cdsClone.Filtered := True;

      pgbProgresso.Max := cdsClone.RecordCount;

      If Not cdsTmpMovBan.Active Then
        Exit;

      cdsClone.First;
      While Not cdsClone.Eof Do
      Begin
        pgbProgresso.Position := cdsClone.RecNo;
        pnlInfo.Caption := Format('Aguarde, restaurando seleção do grid [%s/%s]...', [IntToStr(cdsClone.RecNo), IntToStr(cdsClone.RecordCount)]);
        Application.ProcessMessages;

        If (cdsClone.FieldByName('STATUS').AsString = 'S') And
           (cdsTmpMovBan.FindKey([ cdsClone.FieldByName(strCampoChave).AsString ])) And
           (cdsTmpMovBan.FieldByName('STATUS').AsString <> 'S') Then
          pSelecionaRegistro(Nil);

        cdsClone.Next;
      End;

      If (strCampoChave = 'AUTOINCREM') And (cdsTmpMovBan.FindField('SEQLAN') <> Nil) Then
        cdsTmpMovBan.Locate('SEQLAN', recUltDupBaixada.strSeqLan, [])
      Else If (strCampoChave = 'CODCTA') Then
        cdsTmpMovBan.FindKey([recUltDupBaixada.strCodCta])
      Else If (strCampoChave = 'PAGCON') Then
        cdsTmpMovBan.FindKey([recUltDupBaixada.strPagCon])
      Else If (strCampoChave = 'PAGCTA') Then
        cdsTmpMovBan.FindKey([recUltDupBaixada.strPagCta]);

      cdsTmpMovBan.IndexFieldNames := '';
      pgbProgresso.Position := 0;
    End;
  Finally
    pgbProgresso.Visible := False;
    pnlInfo.Caption := '';
    cdsTmpMovBan.EnableControls;
    Screen.Cursor := crDefault;
  End;

  FreeAndNil(cdsClone);
end;

procedure TfrmCadConciliacaoBancaria.btnManCtpClick(Sender: TObject);
begin
  inherited;

  If fVerificaAcessoSistema('mnuCtaPagar') And
     fVerificaAcessoSistema('frmCadCtaPagar') Then
    pChamarManutencaoCtp
  Else
    pMensagemOk('Operador sem direito de acesso!');
end;

procedure TfrmCadConciliacaoBancaria.btnManRcbClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('mnuCtaReceber') And
     fVerificaAcessoSistema('frmCadCtaReceber') Then
    pChamarManutencaoCtr
  Else
    pMensagemOk('Operador sem direito de acesso!');

end;

procedure TfrmCadConciliacaoBancaria.btnMarcarRegistrosClick(Sender: TObject);
begin
  inherited;
  if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) then
  begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  end;

  If (btnMarcarRegistros.Enabled) Then
    pMarcarDesmarcarTodos(True);
end;

{***************************************************}
{* ATALHO PARA TELA DE MOVIMENTAÇÃO DE CONTA BANCO *}
{*RQ - 31697*************************************BB*}
procedure TfrmCadConciliacaoBancaria.btnMovBanClick(Sender: TObject);
begin
  If (cxgConciliacaoBancariaView.DataController.DataSource.DataSet.IsEmpty) Then
  Begin
    pMensagemOk('É Necessário selecionar um registro.');
    pSetFocus(cxgConciliacaoBancaria);
  End
  Else Begin
    Try
      with cxgConciliacaoBancariaView.DataController.DataSource.DataSet do
      begin
        if FieldByName('DTACON').AsFloat > 0 then
          raise Exception.Create('Selecione um registro Não Conciliado.');

        Try
          pCriarFormularios(TfrmCadMovBancario, FrmCadMovBancario);

          with frmCadMovBancario do
          Begin
            strSeqLan := FieldByName('SEQLAN').AsString;
            strCodPor := FieldByName('CODPOR').AsString;
            strCodCta := FieldByName('CODCTA').AsString;
            strCodEmp := FieldByName('CODEMP').AsString;

            ShowModal;

            If Not cdsLogMod.IsEmpty Then
            Begin
              cdsLogMod.First;
              While Not cdsLogMod.Eof Do
              Begin
                If (cdsLogMod.FieldByName('LOG_STATUS').AsString = 'INCLUSAO') Or
                   (cdsLogMod.FieldByName('LOG_STATUS').AsString = 'ALTERACAO') Then
                Begin
                  pAtualizarRegistroMovBan(cdsLogMod.FieldByName('LOG_SEQLAN').AsString,
                                           (cdsLogMod.FieldByName('LOG_STATUS').AsString = 'INCLUSAO'));
                End
                Else If (cdsLogMod.FieldByName('LOG_STATUS').AsString = 'EXCLUSAO') Then
                Begin
                  If cdsTmpMovBan.Locate('SEQLAN', cdsLogMod.FieldByName('LOG_SEQLAN').AsString, []) Then
                  Begin
                    If (cdsTmpMovBan.FieldByName('STATUS').AsString = 'S') Then
                      pSelecionaRegistro(Nil);
                    cdsTmpMovBan.Delete;
                  End;
                End;

                cdsLogMod.Next;
              End;

              cdsTmpMovBan.Locate('SEQLAN', strSeqLan, []);

              pCalculaValoresInformativos;
              pCalculaValoresInicial;
            End;
          End;
        Finally
          pFreeAndNil(frmCadMovBancario);
          pSetFocus(cxgConciliacaoBancaria);
        End;
      end;
    Except
      On E: Exception Do
      begin
        pMensagemOk(E.Message);
      end;
    End;
  End;
end;

procedure TfrmCadConciliacaoBancaria.btnSairClick(Sender: TObject);
begin
  Self.Tag := 2;

  If fSeRegistroFoiAlterado Then
    If Not fConfirmaSaidaConciliacao Then
    Begin
      Self.Tag := 0;
      Exit;
    End;

  inherited;
end;

procedure TfrmCadConciliacaoBancaria.btnConcilExtEletronicoClick(Sender: TObject);
begin
  inherited;
  self.Hide;
  pCriarForm(TfrmCadConcilBancNova);
  if edtCodPor.Text <> '' then
    pVerificaLanPenEletronico;
  if not qryTmpMovBan.IsEmpty then
    btnConsultar.Click;

  self.Show;

  btnTransfBan.Visible := fVerificaAcessoSistema('frmCadMovBancario_Te');
end;

procedure TfrmCadConciliacaoBancaria.btnTransfBanClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadMovBancario, frmCadMovBancario);
    frmCadMovBancario.strTipMov := 'TE';
    frmCadMovBancario.Caption := 'Transferência de Valores';
    frmCadMovBancario.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuCadMovBancario_TEClick]');
    End;
  End;

  pFreeAndNil(frmCadMovBancario);

end;

procedure TfrmCadConciliacaoBancaria.cxgConciliacaoBancariaViewCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  Var
    coluna : TcxgridDBColumn;
begin
  inherited;
  If ACellViewInfo = Nil Then
    Exit;

  If ACellViewInfo.Item = Nil Then
    Exit;

  If (ACellViewInfo.item.Caption <> 'Detalhe') Then
    Exit;

  coluna := cxgConciliacaoBancariaView.GetColumnByFieldName('DETALH');

  If (coluna <> Nil) And (ACellViewInfo.Item.Index = coluna.Index) And
     (cdsTmpMovBan.FindField('SEQLAN') <> Nil) And
     (cdsTmpMovBan.FindField('ORIGEM') <> Nil) Then
  Begin
    pChamarTelaDetalhe;
    AHandled := True;
  End;
end;

procedure TfrmCadConciliacaoBancaria.cxgConciliacaoBancariaViewColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  If fVerificaAcessoSistema('frmConsultaCxGridNova') Then
  Begin
     If cdsTmpMovBan.Active Then
        fGetFuncoesCxGrid.pSalvarView(cxgConciliacaoBancariaView,
                                     fGetChaveLayoutGrid(cmbAnaSin.Text),
                                     cdsTmpMovBan,
                                     False,
                                     'S');
  End;
end;

procedure TfrmCadConciliacaoBancaria.cxgConciliacaoBancariaViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strStatus: String;
    strConcil: String;
    strIgnora: String;
begin
  inherited;

  With cdsTmpMovBan Do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    If (FindField('STATUS') = Nil) Then
      Exit;


    strStatus := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, 0]);
    strConcil := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, 1]);


    If (strStatus = 'S') Then
      ACanvas.Font.Color := clBlue
    Else If (strConcil = 'X') Then
      ACanvas.Font.Color := clGreen;

    If (FindField('IGNORA') <> Nil) Then
    begin
      LIndexColumnIgnora := GetIndexColumn('IGNORA');
      If LIndexColumnIgnora > 0 Then
      Begin
        strIgnora := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, LIndexColumnIgnora]);
        If (strIgnora = 'S') And (strStatus = 'S') Then
        begin
          ACanvas.Font.Color   := clMedGray;
          ACanvas.Font.Style   := [fsStrikeOut, fsBold];
        end;
      End;
    end;

    If ACanvas.Brush.Color = clHighLight Then
    Begin
      if (strIgnora <> 'S') then
      Begin
        If (strStatus = 'S') Then
          ACanvas.Font.Color := clLime
        Else
          ACanvas.Font.Color := clWhite;
      End;
    End;
  End;
end;

procedure TfrmCadConciliacaoBancaria.cxgConciliacaoBancariaViewDblClick(
  Sender: TObject);
begin
  inherited;

  If (cdsTmpMovBan.IsEmpty) or (not cdsTmpMovBan.Active) Then
    Exit;

  If (cmbAnaSin.ItemIndex = 0) Or
     Not (cmbAnaSin.Enabled)   Then
  Begin
    If fCfgSis('TIPCCB', varInteger) = 1 Then
    begin
      if (cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') And
         (cdsTmpMovBan.FieldByName('CONCILIADO').AsString <> 'X') then
      begin
        if fVerificaLancVinculado(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString) then
        begin
          pMensagemOk('Este lançamento está vinculado com lançamentos importados pelo extrato bancário, para continuar é necessário desvincular os lançamentos!'+
                      fRetornaDadosMensagemTrava(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString));
          Exit;
        end;

        if Not ValidaPortadorContaVinculada then
        begin
          pMensagemOk('O portador deste lançamento está vinculado a conta corrente e só permite conciliação por extrato eletrônico!');
          Exit;
        end;

      end;
      pSelecionaRegistro(Sender);
    end
    Else
    begin
      if (cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') And
         (cdsTmpMovBan.FieldByName('CONCILIADO').AsString <> 'X') then
      begin
        if fVerificaLancVinculado(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString) then
        begin
          pMensagemOk('Este lançamento está vinculado com um ou mais lançamentos importados pelo extrato bancário, para continuar é necessário desvincular os lançamentos!'+
                      fRetornaDadosMensagemTrava(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString));
          Exit;
        end;

        if Not ValidaPortadorContaVinculada then
        begin
          pMensagemOk('O portador deste lançamento está vinculado a conta corrente e só permite conciliação por extrato eletrônico!');
          Exit;
        end;

      end;

      pSelecionaRegistroAntes(Sender);
    end;
  End
  Else
  Begin

    if cdsTmpMovBan.FieldByName('STATUS').AsString = 'N' then
    Begin
      if Not ValidaPortadorContaVinculada then
      begin
        pMensagemOk('O portador deste lançamento está vinculado a conta corrente e só permite conciliação por extrato eletrônico!');
        Exit;
      end;
    End;
    pSelecionaRegistro(Sender);
  End;

  If cdsTmpMovBan.FieldByName('STATUS').AsString = 'S' Then
    pMarcarCartoes;
end;

procedure TfrmCadConciliacaoBancaria.cxgConciliacaoBancariaViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
  Begin
    pnlCabecalho.Enabled := True;
    pnlFiltros.Enabled := False;
    btnCancelar.Click;
    cxgConciliacaoBancariaView.OptionsView.ScrollBars := ssNone;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (Not Assigned(cdsTmpMovBan)) Or
       (cdsTmpMovBan.IsEmpty) Then
      Exit;

    If (cmbAnaSin.ItemIndex = 0) Or
       Not (cmbAnaSin.Enabled)   Then
    Begin

      If Not fEmpresaTemAcessoPortador(cdsTmpMovBan.FieldByName('CODPOR').AsString,VS_strCodEmp) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit;
      End;

      If fCfgSis('TIPCCB', varInteger) = 1 Then
      begin
        if (cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') And
           (cdsTmpMovBan.FieldByName('CONCILIADO').AsString <> 'X') then
        begin
          if fVerificaLancVinculado(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString) then
          begin
            pMensagemOk('Este lançamento está vinculado com lançamentos importados pelo extrato bancário, para continuar é necessário desvincular os lançamentos!'+
                        fRetornaDadosMensagemTrava(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString));
            Exit;
          end;

          if Not ValidaPortadorContaVinculada then
          begin
            pMensagemOk('O portador deste lançamento está vinculado a conta corrente e só permite conciliação por extrato eletrônico!');
            Exit;
          end;

        end;
        pSelecionaRegistro(Sender);
      end
      Else
      begin
        if (cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') And
           (cdsTmpMovBan.FieldByName('CONCILIADO').AsString <> 'X') then
        begin
          if fVerificaLancVinculado(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString) then
          begin
            pMensagemOk('Este lançamento está vinculado com lançamentos importados pelo extrato bancário, para continuar é necessário desvincular os lançamentos!'+
                        fRetornaDadosMensagemTrava(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString));
            Exit;
          end;

          if Not ValidaPortadorContaVinculada then
          begin
            pMensagemOk('O portador deste lançamento está vinculado a conta corrente e só permite conciliação por extrato eletrônico!');
            Exit;
          end;
        end;
        pSelecionaRegistroAntes(Sender);
      end;
    End
    Else
    Begin
      if cdsTmpMovBan.FieldByName('STATUS').AsString = 'N' then
      begin
        if Not ValidaPortadorContaVinculada then
        begin
          pMensagemOk('O portador deste lançamento está vinculado a conta corrente e só permite conciliação por extrato eletrônico!');
          Exit;
        end;
      End;

      pSelecionaRegistro(Sender);
    End;

    If cdsTmpMovBan.FieldByName('STATUS').AsString = 'S' Then
      pMarcarCartoes;

    pSetFocus(cxgConciliacaoBancaria);
    Key := VK_DOWN;
  End;
end;

function TfrmCadConciliacaoBancaria.DesconciliaRegistrosVinculadosNaoMarcados(pgbStatus: TcxProgressBar): Boolean;
  Var
    LAtualiza: TUniQuery;
begin
  LAtualiza := fCriaQuery;
  Try
    LAtualiza.SQL.Text := 'DELETE FROM BANEXR ' +
                          'WHERE EXR_BANINC IN (' + FMovBanVinculadosNaoMarcados + ') ';
    LAtualiza.ExecSQL;

    LAtualiza.Close;
    LAtualiza.SQL.Text := 'UPDATE MOVBAN SET CTB_DTACON=NULL, CTB_HORCON=NULL, CTB_OPECON=NULL ' +
                          'WHERE AUTOINCREM IN (' + FMovBanVinculadosNaoMarcados + ') ';
    LAtualiza.ExecSQL;

    LAtualiza.Close;
    LAtualiza.SQL.Text := 'UPDATE EXTBAN SET EXT_DTACON = NULL, EXT_OPECON = NULL, EXT_HORCON = NULL, EXT_SITUAC = "N" '+
                          'WHERE AUTOINCREM IN ('+FExtBanVinculadosNaoMarcados+')' ;
    LAtualiza.ExecSQL;

    untMovBan.GravaLogCbaDosRegistros(FMovBanVinculadosNaoMarcados,
                                      '',
                                      'DESCONCILIOU LANÇAMENTO',
                                      Self.Name,
                                      pgbStatus);

    FMovBanVinculadosNaoMarcados := '';
    FExtBanVinculadosNaoMarcados := '';

    Result := True;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

procedure TfrmCadConciliacaoBancaria.DesvinculaExtratoEletronicoVarios(
  AAutoIncrems: String);
  var
    LAtualiza: TUniQuery;

    LExtratoAutoIncrens: String;
begin
  if AAutoIncrems.IsEmpty then
    Exit;

  LAtualiza := fCriaQuery;
  LExtratoAutoIncrens := EmptyStr;

  Try
    LAtualiza.SQL.Text := 'SELECT * FROM BANEXR WHERE EXR_BANINC IN (' + AAutoIncrems + ')';

    LAtualiza.Open;
    If LAtualiza.IsEmpty Then
      Exit;

    While Not LAtualiza.Eof do
    Begin
      LExtratoAutoIncrens := LExtratoAutoIncrens + '"' + LAtualiza.FieldByName('EXR_EXTINC').AsString + '",';

      LAtualiza.Next;
    End;
    LExtratoAutoIncrens := LeftStr(LExtratoAutoIncrens, LExtratoAutoIncrens.Length - 1);

    LAtualiza.Close;
    If Not LExtratoAutoIncrens.IsEmpty Then
    Begin
      LAtualiza.SQL.Text := 'UPDATE EXTBAN SET EXT_DTACON = NULL, EXT_OPECON = NULL, EXT_HORCON = NULL, EXT_SITUAC = "N" WHERE AUTOINCREM IN ('+LExtratoAutoIncrens+')' ;
      LAtualiza.ExecSQL;

      LAtualiza.SQL.Text := 'DELETE FROM BANEXR WHERE EXR_BANINC IN (' + AAutoIncrems + ')';
      LAtualiza.ExecSQL;
    End;
  Finally
    FreeAndNil(LAtualiza);
  End;

  if edtCodPor.Text <> '' then
    pVerificaLanPenEletronico;
end;

function TfrmCadConciliacaoBancaria.ValidaDesconciliacaoDeRegistrosVinculadosAoExtrato: Boolean;
  Var
    LFiltroAnterior,
    LAutoIncrems   : String;

    LprcScroll: TprcScroll;
begin
  Result := True;

  If (cdsTmpMovBan.FindField('STATUS') = Nil) Then
    Exit;

  LAutoIncrems := '';

  pDisableControls(cdsTmpMovBan, LprcScroll);

  LFiltroAnterior := cdsTmpMovBan.Filter;

  If Not fEmptyStr(LFiltroAnterior) Then
    cdsTmpMovBan.Filter := LFiltroAnterior + ' AND CONCILIADO=''X'' AND STATUS=''N'' '
  Else
    cdsTmpMovBan.Filter := 'CONCILIADO=''X'' AND STATUS=''N'' ';

  cdsTmpMovBan.Filtered := True;

  If Not cdsTmpMovBan.IsEmpty Then
  Begin
    cdsTmpMovBan.First;
    While Not cdsTmpMovBan.Eof Do
    Begin
      LAutoIncrems := LAutoIncrems + '"' + cdsTmpMovBan.FieldByName('AUTOINCREM').AsString + '",';

      cdsTmpMovBan.Next;
    End;
    LAutoIncrems := LeftStr(LAutoIncrems, LAutoIncrems.Length - 1);
  End;

  cdsTmpMovBan.Filter   := LFiltroAnterior;
  cdsTmpMovBan.Filtered := Not LFiltroAnterior.IsEmpty;

  pEnableControls(cdsTmpMovBan, LprcScroll);

  FMovBanVinculadosNaoMarcados := '';
  FExtBanVinculadosNaoMarcados := '';
  If Not LAutoIncrems.IsEmpty Then
    SelecionaRegistrosVinculadosNaoMarcados(LAutoIncrems);

  If Not FMovBanVinculadosNaoMarcados.IsEmpty Then
  Begin
    If fMensagem('CONFIRMAÇÃO', 'Os registros marcados para realizar a desconciliação foram vinculados ' +
                                'com outros registros na Conciliação de Extrato Eletrônico.' + #13 +
                                'Ao desconcilia-los, todos os outros registros serão desconciliados e desvinculados.' + #13 +
                                'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2 Then
    Begin
      FMovBanVinculadosNaoMarcados := '';
      FExtBanVinculadosNaoMarcados := '';
      Exit(False);
    End;
  End;
end;

//***************************************//
// SELECIONA REGISTRO PARA ATUALIZAÇÃO   //
//************************************RL*//
procedure TfrmCadConciliacaoBancaria.pSelecionaRegistro(Sender: TObject;
                                                        AMarcarTodos: Boolean = False;
                                                        AMarcando: Boolean = True);
begin
  If (Not cdsTmpMovBan.Active) Or (cdsTmpMovBan.IsEmpty) Then
  Begin
    Exit;
  End;

  dtsTmpMovBan.OnDataChange := nil;
  
  cdsTmpMovBan.Edit;

  If (cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') And AMarcando Then
  Begin

    If (fCfgSis('TIPCCB', varInteger) = 2) Then
    Begin
      if Not ValidaPortadorContaVinculada then
      begin
        cdsTmpMovBan.Cancel;
        dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
        If (cmbAnaSin.ItemIndex >= 1) Then
          pCalculaValoresInformativos;
        Exit;
      end;
    End;

    cdsTmpMovBan.FieldByName('STATUS').AsString := 'S';

    cdsTmpMovBan.FieldByName('QTDSEL').AsFloat := 1;

    With cdsTmpMovBan Do
    Begin
      If cmbAnaSin.ItemIndex = 0 Then
      Begin

        If FieldByName('CREDEB').AsString = 'C' Then
        Begin
          FieldByName('TOTCRE').AsFloat := FieldByName('VALOR').AsFloat;
          FieldByName('TOTDEB').AsFloat := 0;
        End Else
        Begin
          FieldByName('TOTCRE').AsFloat := 0;
          FieldByName('TOTDEB').AsFloat := FieldByName('VALOR').AsFloat
        End;

      End Else If cmbAnaSin.ItemIndex in [2,3] Then
      Begin

        If FieldByName('VALOR').AsFloat >= 0  Then
        Begin
          FieldByName('TOTCRE').AsFloat := FieldByName('VALOR').AsFloat;
          FieldByName('TOTDEB').AsFloat := 0;
        End Else
        Begin
          FieldByName('TOTCRE').AsFloat := 0;
          FieldByName('TOTDEB').AsFloat := FieldByName('VALOR').AsFloat
        End;

      End Else
      Begin
        FieldByName('TOTCRE').AsFloat := FieldByName('VALOR').AsFloat;
      End;
    End;

    {**************************}
    { SALDO FINAL DO PORTADOR  }
    {***********************LU*}

   { If Not fEmptyStr(edtCodPor.Text) Then
    Begin
      If (cmbAnaSin.ItemIndex = 0) Then
      Begin
        If cdsTmpMovBan.FieldByName('CREDEB').AsString = 'C' Then
        Begin
          fltSaldoFin := fltSaldoFin + cdsTmpMovBan.fieldbyname('VALOR').AsFloat;
          lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );
        End
        Else
        Begin
          fltSaldoFin := fltSaldoFin - cdsTmpMovBan.fieldbyname('VALOR').AsFloat;
          lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );
        End;
      End
      Else
      Begin
        fltSaldoFin := fltSaldoFin + cdsTmpMovBan.fieldbyname('VALOR').AsFloat;
        lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );
      End;
    End;    }
  End
  Else
  Begin


    If ((cdsTmpMovBan.FindField('IGNORA') = Nil) Or (cdsTmpMovBan.FieldByName('IGNORA').AsString <> 'S')) And
       Not ValidaVinculoLancamentos Then
    Begin
      cdsTmpMovBan.Cancel;
      dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;

      If (fCfgSis('TIPCCB', varInteger) = 1) Or (cmbAnaSin.ItemIndex >= 1) Then
        pCalculaValoresInformativos;

      pMensagemOk('Registro(s) anteriormente conciliados de forma manual não pode(m) '+
                  'ser desconciliado(s), pois, o portador vinculado utiliza conciliação por extrato eletrônico!');
      Exit;
    End;

    cdsTmpMovBan.FieldByName('STATUS').AsString := 'N';

    cdsTmpMovBan.FieldByName('QTDSEL').AsFloat  := 0;
    cdsTmpMovBan.FieldByName('TOTCRE').AsFloat  := 0;
    cdsTmpMovBan.FieldByName('TOTDEB').AsFloat  := 0;

    {**************************}
    { SALDO FINAL DO PORTADOR  }
    {***********************LU*}
    {If Not fEmptyStr(edtCodPor.Text) Then
    Begin
      If (cmbAnaSin.ItemIndex = 0) Then
      Begin
        If cdsTmpMovBan.FieldByName('CREDEB').AsString = 'C' Then
        Begin
          fltSaldoFin := fltSaldoFin - cdsTmpMovBan.fieldbyname('VALOR').AsFloat;
          lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );
        End
        Else
        Begin
          fltSaldoFin := fltSaldoFin + cdsTmpMovBan.fieldbyname('VALOR').AsFloat;
          lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );
        End;
      End
      Else
      Begin
        fltSaldoFin := fltSaldoFin - cdsTmpMovBan.fieldbyname('VALOR').AsFloat;
        lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );
      End;
    End;   }

  End;

  cdsTmpMovBan.Post;

  dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
  
  If (fCfgSis('TIPCCB', varInteger) = 1) Or
     (cmbAnaSin.ItemIndex >= 1)           Then
  Begin
    If Not AMarcarTodos Then
      pCalculaValoresInformativos;
  End;
end;

procedure TfrmCadConciliacaoBancaria.pSelecionaRegistroAntes(Sender: TObject);
  Var
    cdsAux: TUniClientDataSet;
    intRecNo: Integer;
    prcScroll: TprcScroll;

    procedure pSelecionaTodos;
    Begin
      intRecNo := cdsTmpMovBan.RecNo;

      Try
        dtsTmpMovBan.OnDataChange := nil;
        pDisableControls(cdsTmpMovBan, prcScroll);
        cdsTmpMovBan.Filter := cdsAux.Filter;
        cdsTmpMovBan.Filtered := True;
        cdsTmpMovBan.First;

        While Not cdsTmpMovBan.Eof Do
        Begin
          pSelecionaRegistro(Sender, True);
          cdsTmpMovBan.Next;
        End;

      Finally
        cdsTmpMovBan.Filter := '';
        cdsTmpMovBan.Filtered := False;
        cdsTmpMovBan.RecNo := intRecNo;
        pEnableControls(cdsTmpMovBan, prcScroll);
        dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
      End;
    End;

begin
  If (Not cdsTmpMovBan.Active) Or (cdsTmpMovBan.IsEmpty) Then
  Begin
    Exit;
  End;

  If cdsTmpMovBan.FieldByName('PAGCON').AsInteger <> 0 Then
  Begin

    Try
      dtsTmpMovBan.OnDataChange := nil;
      cdsAux := TUniClientDataSet.Create(Self);
      cdsAux.Data := cdsTmpMovBan.Data;

      cdsAux.Filter := 'PAGCON = ' + cdsTmpMovBan.FieldByName('PAGCON').AsString +
                       ' AND CODEMP = ' + QuotedStr(cdsTmpMovBan.FieldByName('CODEMP').AsString);

      cdsAux.Filtered := True;

      If cdsAux.RecordCount > 1 Then
        pSelecionaTodos
      Else
        pSelecionaRegistro(Sender);

      pCalculaValoresInformativos;

    Except
      On E: Exception Do
        pMensagensErro(E.message,'');
    End;
    FreeandNil(cdsAux);

    dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;
  End
  Else
  Begin
    pSelecionaRegistro(Sender);
    pCalculaValoresInformativos;
  End;

end;

procedure TfrmCadConciliacaoBancaria.pShowHint;
begin
  HintControler.ShowHint(Self.Left + btnHistMovBan.Left + btnHistMovBan.Width,
                         Self.Top + pnlBotoes.Top + btnHistMovBan.Top + btnHistMovBan.Height,
                         'ATENÇÃO',
                         'Apresentação do log das inclusão,'  + #13#10 +' alteração, exclusão e conciliação' + #13#10 +
                         'realizada diretamente na Movimentação Bancária.');
end;

procedure TfrmCadConciliacaoBancaria.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadConciliacaoBancaria.pVerificaLanPenEletronico;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  with qryConsulta do
  begin
    Sql.Clear;
    Sql.Text := ' SELECT * FROM EXTBAN WHERE EXT_DTACON IS NULL AND EXT_SITUAC <> "I" ';
    Sql.Text := Sql.Text + '  AND EXT_CODPOR = :CODPOR ';

    ParamByName('CODPOR').AsString :=  edtCodPor.Text;

    Open;

    if not IsEmpty then
    begin
      lblConElePen.Caption := 'Existem ' + IntToStr(RecordCount) + ' lançamento(s) pendentes!';
      lblConElePen.Visible := True;
      tmrPiscarLBL.Enabled := True;
    end
    else
    begin
      lblConElePen.Caption := '';
      lblConElePen.Visible := False;
      tmrPiscarLBL.Enabled := False;
    end;
  end;

  FreeAndNil(qryConsulta);
end;

procedure TfrmCadConciliacaoBancaria.pMarcarCartoes;
  Var
    blnStatus : Boolean;
    intCnt : Integer;
    stlAutInc : TStringList;
    intRecNo : Integer;
    LFilter  : String;
    LFiltered: Boolean;
    strCodEmp  : String;
    strPagCon  : String;
begin
  If (cmbAnaSin.ItemIndex = 0) And
     (cdsTmpMovBan.FieldByName('ORIGEM').AsString = 'MCA') Then
  Begin
    strCodEmp := cdsTmpMovBan.FieldByName('CODEMP').AsString;
    strPagCon := cdsTmpMovBan.FieldByName('PAGCON').AsString;

    stlAutInc := TStringList.Create;

    Try

      If (Assigned(cxgConciliacaoBancariaView.DataController.DataSet)) And
         (cxgConciliacaoBancariaView.DataController.Active) Then
      Begin
        If (cxgConciliacaoBancariaView.DataController.DataRowCount > 0) And
           (cxgConciliacaoBancariaView.DataController.DataSet.FindField(strCampoChave) <> Nil) Then
        Begin
          intRecNo  := cdsTmpMovBan.RecNo;
          LFilter   := cdsTmpMovBan.Filter;
          LFiltered := cdsTmpMovBan.Filtered;

          cdsTmpMovBan.DisableControls;

          cdsTmpMovBan.Filtered := False;
          cdsTmpMovBan.Filter := cxgConciliacaoBancariaView.DataController.Filter.FilterText;
          cdsTmpMovBan.Filtered := True;

          cdsTmpMovBan.First;
          While Not cdsTmpMovBan.Eof  Do
          Begin

            blnStatus := (cdsTmpMovBan.FieldByName('STATUS').AsString = 'S');

            If (cdsTmpMovBan.FieldByName('CODEMP').AsString = strCodEmp) And
               (cdsTmpMovBan.FieldByName('PAGCON').AsString = strPagCon) And
               (cdsTmpMovBan.FieldByName('ORIGEM').AsString = 'MCA') And
               (cdsTmpMovBan.FieldByName('PAGCON').AsString <> '0') And
               (Not blnStatus) Then
            Begin

               If Not fEmpresaTemAcessoPortador(cdsTmpMovBan.FieldByName('CODPOR').AsString,VS_strCodEmp) Then
               Begin
                    fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
               End Else
               Begin
                  If (cmbAnaSin.ItemIndex = 0) Or Not (cmbAnaSin.Enabled) Then
                  begin
                    If (Not fVerificaLancVinculado(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString)) And
                        ValidaPortadorContaVinculada Then
                      stlAutInc.Add(cdsTmpMovBan.FieldByName(strCampoChave).AsString);
                  end
                  else
                  begin
                    stlAutInc.Add(cdsTmpMovBan.FieldByName(strCampoChave).AsString);
                  end;
               End;
             End;
            cdsTmpMovBan.Next;
          End;

          Try
            If (stlAutInc.Count > 0) Then
            Begin
              cdsTmpMovBan.IndexFieldNames := strCampoChave;

              For intCnt := 0 To stlAutInc.Count -1 Do
              Begin

                Application.ProcessMessages;
                If cdsTmpMovBan.FindKey([stlAutInc.Strings[intCnt]]) Then
                  pSelecionaRegistro(Nil, True);
              End;
              cdsTmpMovBan.IndexFieldNames := '';
            End;
          Finally
            pCalculaValoresInformativos;

            cdsTmpMovBan.Filter   := LFilter;
            cdsTmpMovBan.Filtered := LFiltered ;
            cdsTmpMovBan.RecNo := intRecNo;
            cdsTmpMovBan.EnableControls;
          End;
        End;

      End;
    Finally
      FreeAndNil(stlAutInc);
    End;
  End;
end;

procedure TfrmCadConciliacaoBancaria.pMarcarDesmarcarTodos(blnMarcar: Boolean);
  Var
    intCnt : Integer;
    stlAutInc : TStringList;
    intRecNo : Integer;
    LFilter  : String;
    LFiltered: Boolean;
    LMensagemValidacao: String;
begin
  pgbProgresso.Visible := True;
  Screen.Cursor := crHourGlass;
  pnlInfo.Caption := 'Aguarde, ' + IIf(blnMarcar, 'marcando', 'desmarcando') + ' registros...';
  LMensagemValidacao := '';

  stlAutInc := TStringList.Create;
  Try
    pnlBotoes.Enabled := False;

    If (Assigned(cxgConciliacaoBancariaView.DataController.DataSet)) And
       (cxgConciliacaoBancariaView.DataController.Active) Then
    Begin
      With cxgConciliacaoBancariaView.DataController Do
      Begin
        If (DataRowCount > 0) And (DataSet.FindField(strCampoChave) <> Nil) Then
        Begin
          intRecNo  := cdsTmpMovBan.RecNo;
          LFilter   := cdsTmpMovBan.Filter;
          LFiltered := cdsTmpMovBan.Filtered;

          cdsTmpMovBan.DisableControls;

          cdsTmpMovBan.Filtered := False;
          cdsTmpMovBan.Filter := cxgConciliacaoBancariaView.DataController.Filter.FilterText;
          cdsTmpMovBan.Filtered := True;

          cdsTmpMovBan.First;
          While Not cdsTmpMovBan.Eof  Do
          Begin

            If (cmbAnaSin.ItemIndex = 0) Or  Not (cmbAnaSin.Enabled)   Then
            begin

              if ((cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') And
                 (cdsTmpMovBan.FieldByName('CONCILIADO').AsString <> 'X')) And blnMarcar then
              Begin

                If fVerificaLancVinculado(cdsTmpMovBan.FieldByName('AUTOINCREM').AsString) Then
                Begin
                  cdsTmpMovBan.Next;
                  LMensagemValidacao := 'Algum(ns) registro(s) não foi(ram) selecionado(s) porque está(ão) vinculado(s) a lançamentos '+
                                        'importados pelo extrato bancário. Para prosseguir, é necessário desvincular esses lançamentos.';
                  Continue;
                End;

                If Not ValidaPortadorContaVinculada Then
                Begin
                  cdsTmpMovBan.Next;
                  LMensagemValidacao := 'Algum(ns) registro(s) não foi(ram) selecionado(s) porque o portador está vinculado '+
                                        'à conta corrente e só permite conciliação por extrato eletrônico.';
                  Continue;
                End;

              End;

              stlAutInc.Add(cdsTmpMovBan.FieldByName(strCampoChave).AsString);
            end
            else
            begin

              If (cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') And blnMarcar then
              Begin
                If Not ValidaPortadorContaVinculada Then
                Begin
                  cdsTmpMovBan.Next;
                  LMensagemValidacao := 'Algum(ns) registro(s) não foi(ram) selecionado(s) porque o portador está vinculado '+
                                        'à conta corrente e só permite conciliação por extrato eletrônico.';
                  Continue;
                End;
              End;

              stlAutInc.Add(cdsTmpMovBan.FieldByName(strCampoChave).AsString);
            end;

            cdsTmpMovBan.Next;
          End;
          Try
            If (stlAutInc.Count > 0) Then
            Begin
              cdsTmpMovBan.IndexFieldNames := strCampoChave;
              pgbProgresso.Max := stlAutInc.Count;
              For intCnt := 0 To stlAutInc.Count -1 Do
              Begin
                pgbProgresso.Position := intCnt;
                Application.ProcessMessages;
                If cdsTmpMovBan.FindKey([stlAutInc.Strings[intCnt]]) Then
                  pSelecionaRegistro(Nil, True,blnMarcar);
              End;
              cdsTmpMovBan.IndexFieldNames := '';
            End;
          Finally
            pCalculaValoresInformativos;

            cdsTmpMovBan.Filter   := LFilter;
            cdsTmpMovBan.Filtered := LFiltered ;
            cdsTmpMovBan.RecNo := intRecNo;
            cdsTmpMovBan.EnableControls;
          End;
        End;
      End;
    End;

    If Not fEmptyStr(LMensagemValidacao) Then
      fMensagem('AVISO!', LMensagemValidacao, ['&O k']);

  Finally
    FreeAndNil(stlAutInc);
    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;
    pgbProgresso.Position := 0;
    pgbProgresso.Visible := False;

    pnlBotoes.Enabled := True;
  End;
end;

procedure TfrmCadConciliacaoBancaria.pnlCabecalhoClick(Sender: TObject);
begin
  inherited;

end;

//***************************************//
// ATUALIZAR REGISTROS SELECIONADOS      //
//************************************RL*//
{procedure TfrmCadConciliacaoBancaria.pAfterScroll(DataSet: TDataSet);
begin
  {If Not Assigned(cdsTmpMovBan) Then
    Exit;

  If Not cdsTmpMovBan.Active Then
    Exit;

  If cmbAnaSin.ItemIndex = 0 Then
  Begin
    If cdsTmpMovBan.FieldByName('CONCILIADO').AsString = 'X' Then
      pnlInfo.Caption := 'Conciliação - Data/Hora: ' + FormatDateTime('dd/mm/yyyy', cdsTmpMovBan.FieldByName('DTACON').AsDateTime) + ' ' +
             FormatDateTime('hh:mm:ss', cdsTmpMovBan.FieldByName('HORCON').AsDateTime) + ' Operador: ' +
             cdsTmpMovBan.FieldByName('OPECON').AsString + ' - ' + fRetNomeOperador(cdsTmpMovBan.FieldByName('OPECON').AsString)
    Else
      pnlInfo.Caption := '';
  End
  Else
    pnlInfo.Caption := '';}

//end;

procedure TfrmCadConciliacaoBancaria.pAlterarDataLanctoCadRec(AAutoIncremList: String;
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

procedure TfrmCadConciliacaoBancaria.pAlterarDataLanctoTF_OP_CadRec(AAutoIncremList: String;
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
      On E: Exception Do
      Begin
        Raise Exception.Create('[TfrmCadConciliacaoBancaria.AlterarDataLanctoTF_OP_CadRec] ' +E.Message);
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

procedure TfrmCadConciliacaoBancaria.pAlterarDataLanctoAdiantamento(AAutoIncremList: String;
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
           If (Not qryRcxSeq.IsEmpty) And (Not fEmptyStr(qryRcxSeq.FieldByName('MPX_SEQCON').AsString)) Then
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
         If (Not qryRcxSeq.IsEmpty) And (Not fEmptyStr(qryRcxSeq.FieldByName('CTB_SEQBAI').AsString)) Then
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
      Raise Exception.Create('[TfrmCadConciliacaoBancaria.pAlterarDataLanctoAdiantamento] ' +E.Message);
    End;
  End;
end;

procedure TfrmCadConciliacaoBancaria.AdicionaRegistroNaListaDeAtualizacao(
  ADataset: TDataset);
  Var
    LIndice: Integer;

    LNovoItem: TRegistrosConciliarBancaria;
begin
  For LIndice := 0 To FListaRegistrosAtualizar.Count - 1 Do
  Begin
    If Concat(FListaRegistrosAtualizar[LIndice].Conciliado,
              FListaRegistrosAtualizar[LIndice].Status)
      .Equals(Concat(ADataset.FieldByName('CONCILIADO').AsString,
                     ADataset.FieldByName('STATUS').AsString)) Then
    Begin
      FListaRegistrosAtualizar[LIndice].AutoIncremsUpdate := FListaRegistrosAtualizar[LIndice].AutoIncremsUpdate +
                                                             '"' + ADataset.FieldByName('AUTOINCREM').AsString + '",';

      Exit;
    End;
  End;

  LNovoItem := TRegistrosConciliarBancaria.Create;
  LNovoItem.Conciliado := ADataset.FieldByName('CONCILIADO').AsString;
  LNovoItem.Status := ADataset.FieldByName('STATUS').AsString;
  LNovoItem.AutoIncremsUpdate := '"' + ADataset.FieldByName('AUTOINCREM').AsString + '",';

  FListaRegistrosAtualizar.Add(LNovoItem);
end;

function TfrmCadConciliacaoBancaria.AlterarDataLanctoMovBan(ADataset: TDataset;
  ADataAlterada: TDateTime): Boolean;
  Var
    qryMovBan : TUniQuery;

    AAutoIncremContraPartida: String;
    AAutoIncremList: String;
begin
  Result := True;

  qryMovBan := fCriaQuery(Self);

  AAutoIncremContraPartida := RetornaAutoIncremDeContraPartida(ADataset);

  If Not AAutoIncremContraPartida.IsEmpty Then
  Begin
    qryMovBan.SQL.Text := 'SELECT * FROM MOVBAN WHERE AUTOINCREM IN (' + AAutoIncremContraPartida + ') AND CTB_DTACON IS NOT NULL';
    qryMovBan.Open;

    Result := qryMovBan.IsEmpty;
    If Not Result Then
    Begin
      fMensagem('ATENÇÃO', 'O lançamento de contra-partida desse registro já foi conciliado. Operação cancelada!', ['&OK']);
      FreeAndNil(qryMovBan);

      Exit;
    End;
  End;

  AAutoIncremList := '"' + ADataset.FieldByName('AUTOINCREM').AsString + '"';

  fStartTransaction;

  Try
    qryMovBan.Close;
    qryMovBan.SQL.Clear;
    qryMovBan.SQL.Add(' UPDATE MOVBAN ');
    qryMovBan.SQL.Add('    SET CTB_DTALAN = :DTALAN ');
    qryMovBan.SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
    qryMovBan.ParamByName('DTALAN').AsDateTime := ADataAlterada;
    qryMovBan.ParamByName('AUTINC').AsString := ADataset.FieldByName('AUTOINCREM').AsString;
    qryMovBan.ExecSQL;

    If Not AAutoIncremContraPartida.IsEmpty Then
    Begin
      qryMovBan.Close;
      qryMovBan.SQL.Text := 'UPDATE MOVBAN SET CTB_DTALAN = "' + FormatDateTime('yyyy/mm/dd', ADataAlterada) + '" ' +
                            ' WHERE AUTOINCREM IN (' + AAutoIncremContraPartida + ')';
      qryMovBan.ExecSQL;

      AAutoIncremList := AAutoIncremList + ',' + AAutoIncremContraPartida;
    End;

    pAlterarDataLanctoCadRec(AAutoIncremList, ADataAlterada);

    pAlterarDataLanctoTF_OP_CadRec(AAutoIncremList, ADataAlterada);

    pAlterarDataLanctoAdiantamento(AAutoIncremList, ADataAlterada);

    pAlterarDataLanctoDepCheques(AAutoIncremList, ADataAlterada);

    pAlterarDataLanctoCartoes(AAutoIncremList, ADataAlterada);

    FreeAndNil(qryMovBan);

    untLogCba.GravaLogCba(ADataset.FieldByName('AUTOINCREM').AsString,
                          'ALTEROU DATA LANÇAMENTO',
                          self.Name);
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;

      pMensagensErro('Ocorreu um erro ao atualizar a data de lançamento. ' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmCadConciliacaoBancaria.AlterarDataLanctoMovBan]');
    End;
  End;

end;

function TfrmCadConciliacaoBancaria.RetornaAutoIncremLancamentosSintetico(ACodCta: String): String;
var
  LConsulta: TUniQuery;
  LSQL: String;
begin
  Result := '';
  LConsulta := fCriaQuery;
  fExecutaSQL('SET SESSION group_concat_max_len = 1000000');
  try
    LSQL := 'SELECT GROUP_CONCAT(''"'', AUTOINCREM, ''"'') AS AUTOINCREMS FROM MOVBAN WHERE CTB_DTACON IS NOT NULL AND';

    LSQL := LSQL + ' CTB_CODCTA = :CODCTA ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      LSQL := LSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      LSQL := LSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      LSQL := LSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');
    try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Add(LSQL);

      LConsulta.ParamByName('CODCTA').AsString := ACodCta;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        LConsulta.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        LConsulta.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', LConsulta);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', LConsulta);

      LConsulta.Open;
      LConsulta.First;
      if not LConsulta.EOF then
        Result := LConsulta.Fields[0].AsString;
    except
      on E: Exception do
        raise Exception.Create('Problemas ao retornar autoincrem para atualizar extrato sintético. ' +
                               '[TfrmCadConciliacaoBancaria.RetornaAutoIncremLancamentosSintetico]' + E.Message);
    end;
  finally
    fExecutaSQL('SET SESSION group_concat_max_len = 65535');
    FreeAndNil(LConsulta);
  end;
end;

function TfrmCadConciliacaoBancaria.RetornaAutoIncremLancamentosSintetico(
  APagCon: Integer; ACodCta: String): String;
var
  LConsulta: TUniQuery;
  LSQL: String;
begin
  Result := '';
  LConsulta := fCriaQuery;
  fExecutaSQL('SET SESSION group_concat_max_len = 1000000');
  try
    LSQL := 'SELECT GROUP_CONCAT(''"'', AUTOINCREM, ''"'') AS AUTOINCREMS FROM MOVBAN WHERE CTB_DTACON IS NOT NULL AND';

    LSQL := LSQL + '  IFNULL(CTB_PAGCON, 0) = :PAGCON ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      LSQL := LSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      LSQL := LSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      LSQL := LSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If not fEmptyStr(ACodCta) Then
      LSQL := LSQL + ' AND CTB_CODCTA = :CODCTA ';

    If rdgOpcao.ItemIndex = 0 Then
      LSQL := LSQL + ' AND CTB_DTACON IS NOT NULL '
    Else If rdgOpcao.ItemIndex = 1 Then
      LSQL := LSQL + ' AND CTB_DTACON IS NULL ';

    try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Add(LSQL);

      LConsulta.ParamByName('PAGCON').AsInteger := APagCon;

      if not fEmptyStr(ACodCta) Then
        LConsulta.ParamByName('CODCTA').AsString := ACodCta;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        LConsulta.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
        LConsulta.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
      End;

      If Not fEmptyStr(edtCodPor.Text) Then
        pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', LConsulta);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', LConsulta);

      LConsulta.Open;
      LConsulta.First;
      if not LConsulta.EOF then
        Result := LConsulta.Fields[0].AsString;
    except
      on E: Exception do
        raise Exception.Create('Problemas ao retornar autoincrem para atualizar extrato sintético. ' +
                               '[TfrmCadConciliacaoBancaria.RetornaAutoIncremLancamentosSintetico]' + E.Message);
    end;
  finally
    fExecutaSQL('SET SESSION group_concat_max_len = 65535');
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadConciliacaoBancaria.pAtualizarMovBan;
begin
  Try
    dtaDtaCon := VS_Date;
    If fCfgSis('DTACCB') = 'S' Then
    Begin
      If cdsTmpMovBan.FieldByName('CONCILIADO').AsString <> 'X' Then
      Begin
        If Not ffrmDataNovo(dtaDtaCon, 'Data de Conciliação', 'Data de Conciliação: ') Then
          Exit
        Else If dtaDtaCon > VS_Date Then
        Begin
          fMensagem('', 'A data informada não pode ser maior que a data atual, pressione F10 e informe uma data menor ou igual a hoje!', ['&Ok']);
          Exit;
        End
        Else
        Begin
          If cdsTmpMovBan.FindField('CODEMP') <> Nil Then
          Begin
            if objFechamento.FechamentoFinanceiroJaRealizado(cdsTmpMovBan.FieldByName('CODEMP').AsString, dtaDtaCon) then
              Exit;
          End;
        End;
      End;
    End;

    If Not ValidaDesconciliacaoDeRegistrosVinculadosAoExtrato Then
      Exit;

    If (cmbAnaSin.ItemIndex = 0) Then
      pAtualizarMovBanAnalitico
    Else
      pAtualizarMovBanSintetico;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  If (fCfgSis('DTACCB') = 'S') And Not(cdsTmpMovBan.IsEmpty) Then
  Begin
    cdsTmpMovBan.Close;
    cdsTmpMovBan.Open;
  End;

  {*********************************************}
  {* SE CHECKBOX ESTIVER MARCADO, LIMPA A TELA *}
  {******************************************RV*}
  If chkLimFil.Checked Then
  Begin
    rdgOpcao.ItemIndex := 2;
    btnCancelar.Click;
    edtCodPor.Clear;
    edtNomPor.Clear;
    fraPlanoDeContas.mskCodCta.Clear;
    fraPlanoDeContas.edtDesCta.Clear;
    edtCodEmpresa.Clear;
    edtDesEmpresa.Clear;
    mskDtaIni.Clear;
    mskDtaFin.Clear;
    pnlCabecalho.Enabled := True;
    pnlFiltros.Enabled   := False;
    pSetFocus(edtCodPor);
  End
  Else If Not (cdsTmpMovBan.IsEmpty) Then
    pSetFocus(cxgConciliacaoBancaria)
  Else
    pSetFocus(edtCodPor);
end;

procedure TfrmCadConciliacaoBancaria.btnConfirmarClick(Sender: TObject);
begin
  inherited;
 if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) then
  begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  end;

  FMovBanVinculadosNaoMarcados := '';
  FExtBanVinculadosNaoMarcados := '';

  pAtualizarMovBan;
end;

function TfrmCadConciliacaoBancaria.fGetFilterSelecionados: String;
Begin
  Result := 'STATUS=''S'' AND CONCILIADO<>''X'' ' ;
End;

function TfrmCadConciliacaoBancaria.fExisteSelecionados: Boolean;
Begin
  Result := (fDoubleAggregate(cdsTmpMovBan, 'TOT_QTDSEL') > 0);
End;

function TfrmCadConciliacaoBancaria.fValidaSelecionados(pgbStatus: TcxProgressBar) : Boolean;
var
  LFiltroAnterior, strAutoIncrem: String;
  LRecNo: Integer;
Begin
  Result := False;
  try
    pgbStatus.Position := 0;
    pStep(pgbStatus);

    LRecNo := cdsTmpMovBan.RecNo;
    LFiltroAnterior := cdsTmpMovBan.Filter;

    cdsTmpMovBan.DisableControls;

    cdsTmpMovBan.Filter   := fGetFilterSelecionados;
    cdsTmpMovBan.Filtered := True;

    if (cdsTmpMovBan.RecordCount <= 0) then
    Begin
      cdsTmpMovBan.Filter   := LFiltroAnterior;
      cdsTmpMovBan.Filtered := Not LFiltroAnterior.IsEmpty;
      cdsTmpMovBan.RecNo := LRecNo;
      Exit;
    End;

    strAutoIncrem := EmptyStr;

    cdsTmpMovBan.First;
    While Not cdsTmpMovBan.Eof Do
    Begin
      strAutoIncrem := EmptyStr;
      pStep(pgbStatus);

      If (cdsTmpMovBan.FieldByName('CONCILIADO').AsString = 'X') Then
      Begin
        fMensagem('ATENÇÃO', 'Não é permitido alterar a data de lançamento de um registro já conciliado.', ['&Ok']);
        strAutoIncrem := cdsTmpMovBan.FieldByName('AUTOINCREM').AsString;
        Break;
      End;

      If (cdsTmpMovBan.FieldByName('POR_DTAINI').AsDateTime > 0) And
         (dtaDtaLanc < cdsTmpMovBan.FieldByName('POR_DTAINI').AsDateTime)
      Then
      Begin
        fMensagem('ATENÇÃO!', 'A data não pode ser menor que ' +
                  formatDateTime('DD/MM/YYYY', cdsTmpMovBan.FieldByName('POR_DTAINI').AsDateTime) +
                  ' para o portador '+cdsTmpMovBan.FieldByName('CODPOR').AsString+' - '+fRetNomPortador(cdsTmpMovBan.FieldByName('CODPOR').AsString)+'.', ['&O k']);
        strAutoIncrem := cdsTmpMovBan.FieldByName('AUTOINCREM').AsString;
        Break;
      End;

      //FECHAMENTO FINANCEIRO
      if objFechamento.FechamentoFinanceiroJaRealizado(cdsTmpMovBan.FieldByName('CODEMP').AsString, dtaDtaLanc) then
      Begin
        strAutoIncrem := cdsTmpMovBan.FieldByName('AUTOINCREM').AsString;
        Break;
      End;

      If (cdsTmpMovBan.FieldByName('DTALAN').AsDateTime = dtaDtaLanc) Then
      Begin
        cdsTmpMovBan.Next;
        Continue;
      End;

      cdsTmpMovBan.Next;
    End;

    Result := fEmptyStr(strAutoIncrem);
  finally
    pStep(pgbStatus);
    cdsTmpMovBan.Filter   := LFiltroAnterior;
    cdsTmpMovBan.Filtered := Not LFiltroAnterior.IsEmpty;
    if(not Result)then
      cdsTmpMovBan.Locate('AUTOINCREM',strAutoIncrem, []);

    cdsTmpMovBan.EnableControls;
  end;
End;

function TfrmCadConciliacaoBancaria.fAjustaDataSelecionados(pgbStatus: TcxProgressBar) : Boolean;
var
  LFiltroAnterior : String;
  LRecNo: Integer;
Begin

  LRecNo := cdsTmpMovBan.RecNo;
  try
    pgbStatus.Position := 0;
    pStep(pgbStatus);

    Result := False;
    LFiltroAnterior := cdsTmpMovBan.Filter;

    cdsTmpMovBan.DisableControls;
    cdsTmpMovBan.IndexFieldNames := strCampoChave;
    cdsTmpMovBan.Filter          := fGetFilterSelecionados;
    cdsTmpMovBan.Filtered        := True;

    cdsTmpMovBan.First;
    While Not cdsTmpMovBan.Eof Do
    Begin
      pStep(pgbStatus);

      If (cdsTmpMovBan.FieldByName('DTALAN').AsDateTime = dtaDtaLanc) Then
      Begin
        cdsTmpMovBan.Next;
        Continue;
      End;

      If AlterarDataLanctoMovBan(cdsTmpMovBan, dtaDtaLanc) Then
      Begin
        cdsTmpMovBan.Edit;
        cdsTmpMovBan.FieldByName('DTALAN').AsDateTime := dtaDtaLanc;
        cdsTmpMovBan.Post;
      End;

      cdsTmpMovBan.Next;
    End;

    Result := True;
  finally
    pStep(pgbStatus);
    cdsTmpMovBan.IndexFieldNames := '';
    cdsTmpMovBan.Filter          := LFiltroAnterior;
    cdsTmpMovBan.Filtered        := Not LFiltroAnterior.IsEmpty;
    cdsTmpMovBan.RecNo           := LRecNo;

    cdsTmpMovBan.EnableControls;
  End;
End;

procedure TfrmCadConciliacaoBancaria.btnAltDataLanctoClick(Sender: TObject);
  Var
    dtaDtaMin : TDateTime;
    LRecNo: Integer;
    LFiltroAnterior: String;

  function fGetFilter: String;
  Begin
    If Not fEmptyStr(cdsTmpMovBan.FieldByName('SEQCTP').AsString) Then
      Result := 'SEQCTP=' + cdsTmpMovBan.FieldByName('SEQCTP').AsString
    Else
      Result := 'AUTOINCREM=' + cdsTmpMovBan.FieldByName('AUTOINCREM').AsString;
  End;

begin
  inherited;
  dtaDtaLanc := 0;

  if (not cdsTmpMovBan.Active) or (cdsTmpMovBan.IsEmpty) then
  begin
    pMensagemOk('É necessário selecionar ao menos um registro!');
    Exit;
  end;

  If fVerificaAcessoSistema('ALTDLC') Then
  Begin
    If (not cdsTmpMovBan.Active) Then
      Exit;

    try
      if (fExisteSelecionados) then
      Begin
        LFiltroAnterior := cdsTmpMovBan.Filter;

        If not ffrmData(dtaDtaLanc, 'Altera Data de Lançamento', 'Data Lancto:') Then
        Begin
          Exit;
        End;

        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.lblGravando.Caption := 'Aguarde... Verificando selecionados...';
        frmGravando.strChave := 'PEDCOM';
        frmGravando.fExecutarAcao := fValidaSelecionados;
        frmGravando.ShowModal;

        if (not frmGravando.blnConfirma) then
           Exit;

        pFreeAndNil(frmGravando);

        //FreeAndnil(frmGravando);
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.lblGravando.Caption := 'Aguarde... Ajustando data...';
        frmGravando.strChave := 'PEDCOM';
        frmGravando.fExecutarAcao := fAjustaDataSelecionados;
        frmGravando.ShowModal;
      End
      else
      Begin
        LFiltroAnterior := cdsTmpMovBan.Filter;
        LRecNo          := cdsTmpMovBan.RecNo;

        If (cdsTmpMovBan.FieldByName('CONCILIADO').AsString = 'X') Then
        Begin
          fMensagem('ATENÇÃO', 'Não é permitido alterar a data de lançamento de um registro já conciliado.', ['&Ok']);
          Exit;
        End;

        dtaDtaLanc := cdsTmpMovBan.FieldByName('DTALAN').AsDateTime;
        dtaDtaMin  := fRetDataPortador(cdsTmpMovBan.FieldByName('CODPOR').AsString);

        If ffrmData(dtaDtaLanc,
                    'Altera Data de Lançamento',
                    'Data Lancto:',
                    dtaDtaMin) Then
        Begin
          //FECHAMENTO FINANCEIRO
          if objFechamento.FechamentoFinanceiroJaRealizado(cdsTmpMovBan.FieldByName('CODEMP').AsString, dtaDtaLanc) then
            Exit;

          If (cdsTmpMovBan.FieldByName('DTALAN').AsDateTime <> dtaDtaLanc) Then
          Begin
            If AlterarDataLanctoMovBan(cdsTmpMovBan, dtaDtaLanc) Then
            Begin
              cdsTmpMovBan.DisableControls;

              cdsTmpMovBan.Filter   := fGetFilter;
              cdsTmpMovBan.Filtered := True;

              While Not cdsTmpMovBan.Eof Do
              Begin
                cdsTmpMovBan.Edit;
                cdsTmpMovBan.FieldByName('DTALAN').AsDateTime := dtaDtaLanc;
                cdsTmpMovBan.Post;

                cdsTmpMovBan.Next;
              End;

              cdsTmpMovBan.Filter   := LFiltroAnterior;
              cdsTmpMovBan.Filtered := Not LFiltroAnterior.IsEmpty;
              cdsTmpMovBan.RecNo := LRecNo;

              cdsTmpMovBan.EnableControls;
            End;
          End;
        End;
      End;
    Finally

    End;
  End
  Else
    pMensagemOk('Operador sem direito de acesso!');
end;

procedure TfrmCadConciliacaoBancaria.btnCancelarClick(Sender: TObject);
begin
  inherited;
  qryTmpMovBan.Close;
  pDeletarTemporaria;
  SetLength(arrEmpresa, 0);

  pSetFocus(edtCodPor);
  pnlTotalInicial.Visible := False;
  pnlTotalFinal.Visible := False;

  lblSaldoAnt.Caption := '';
  lblSaldoFin.Caption := '';

  edtQtdSel.Clear;
  edtQtdGer.Clear;
  edtCreSel.Clear;
  edtCreGer.Clear;
  edtDebSel.Clear;
  edtDebGer.Clear;
  edtDifSel.Clear;
  edtDifGer.Clear;
end;

{***************************************************************************}
{* CALCULA TOTAIS INFORMATIVOS COMO TOTAL DE DUPLICATAS SELECIONADAS, ETC  *}
{************************************************************************LU*}
procedure TfrmCadConciliacaoBancaria.pCalculaValoresInformativos(blnInicial: Boolean = False);
  Var
    intTotSel: Integer;
    intRecNo : Integer;
    fltTotCre,
    fltTotDeb,
    fltSalFin: Double;
begin
  Try
    intTotSel := 0;
    fltTotCre := 0;
    fltTotDeb := 0;

//    edtQtdSel.Text := FormatFloat('#0',       fDoubleAggregate(cdsTmpMovBan, 'TOT_QTDSEL'));
//    edtCreSel.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTmpMovBan, 'TOT_TOTCRE'));
//    edtDebSel.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTmpMovBan, 'TOT_TOTDEB'));

    If Not blnInicial Then
      intRecNo := cdsTmpMovBan.RecNo
    Else
      intRecNo := 1;

    cdsTmpMovBan.DisableControls;
    cdsTmpMovBan.First;

    While Not cdsTmpMovBan.Eof Do
    Begin
      If cmbAnaSin.ItemIndex = 0 Then
      Begin
        intTotSel := intTotSel + IIF(cdsTmpMovBan.FieldByName('STATUS').AsString = 'S', 1, 0);
        fltTotCre := fltTotCre + IIF(cdsTmpMovBan.FieldByName('STATUS').AsString = 'S', cdsTmpMovBan.FieldByName('TOTCRE').AsFloat, 0);
        fltTotDeb := fltTotDeb + IIF(cdsTmpMovBan.FieldByName('STATUS').AsString = 'S', cdsTmpMovBan.FieldByName('TOTDEB').AsFloat, 0);
      End
      Else
      Begin
        intTotSel := intTotSel + IIF(cdsTmpMovBan.FieldByName('STATUS').AsString = 'S', 1, 0);
        fltTotCre := fltTotCre + IIF(cdsTmpMovBan.FieldByName('STATUS').AsString = 'S', cdsTmpMovBan.FieldByName('VALOR').AsFloat, 0);
      End;

      cdsTmpMovBan.Next;
    End;

    edtQtdSel.Text := FormatFloat('#0', intTotSel);
    edtCreSel.Text := FormatFloat('#,##0.00', fltTotCre);
    edtDebSel.Text := FormatFloat('#,##0.00', fltTotDeb);

    If blnInicial Then
    Begin
      cdsTmpMovBan.First;
      pSaldoPortador;
    End
    Else
      cdsTmpMovBan.RecNo := intRecNo;

    cdsTmpMovBan.EnableControls;

    edtDifSel.Text := FormatFloat('#,##0.00', fStrToFloat(edtCreSel.text) - fStrToFloat(edtDebSel.text));

    If (cmbAnaSin.ItemIndex <> 0) And
       (rdgOpcao.ItemIndex = 0)   Then
      edtCreSel.Text := edtDifSel.Text;

    fltSalFin := fltSaldoIni + fltTotCre - IIF(cmbAnaSin.ItemIndex = 0, fltTotDeb, IIF(rdgOpcao.ItemIndex = 0, fltTotDeb, 0));
    lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSalFin);

//    if cmbAnaSin.ItemIndex = 1 Then
//      edtCreSel.Text := edtDifSel.Text;

  Finally

  End;
end;

procedure TfrmCadConciliacaoBancaria.pCalculaValoresInicial;
begin
  Try
    edtQtdGer.Text := IntToStr(cdsTmpMovBan.RecordCount);

    edtCreGer.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTmpMovBan, 'TOT_GERCRE'));
    edtDebGer.Text := FormatFloat('#,##0.00', fDoubleAggregate(cdsTmpMovBan, 'TOT_GERDEB'));

    edtDifGer.Text := FormatFloat('#,##0.00', fStrToFloat(edtCreGer.text) - fStrToFloat(edtDebGer.text));

    If cmbAnaSin.ItemIndex <> 0 Then
      edtCreGer.Text := edtDifGer.Text;

  Finally

  End;
end;

Function TfrmCadConciliacaoBancaria.fProcuraContraPartida(strCreDeb,
  strSeqCtp: String; dteDataLan: TDateTime): String;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTB_CODPOR, ';
    strSQL := strSQL + '   CTB_DTALAN, ';
    strSQL := strSQL + '   CTB_CODOPE, ';
    strSQL := strSQL + '   CTB_NUMDOC, ';
    strSQL := strSQL + '   CTA_DESCTA, ';
    strSQL := strSQL + '   CTB_VALLAN, ';
    strSQL := strSQL + '   CTB_CREDEB, ';
    strSQL := strSQL + '   CTB_CODEMP, ';
    strSQL := strSQL + '   CTB_HIST01 ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   MOVBAN ';
    strSQL := strSQL + '   LEFT JOIN CADCTA ON (CTB_CODCTA=CTA_CODCTA) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTB_CREDEB = :CREDEB AND ';
    strSQL := strSQL + '   CTB_SEQCTP = :SEQCTP AND ';
    strSQL := strSQL + '   CTB_DTALAN = :DTALAN     ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CREDEB').AsString := strCreDeb;
      ParamByName('SEQCTP').AsString := strSeqCtp;
      ParamByName('DTALAN').AsDateTime := dteDataLan;
      Open;

      If IsEmpty Then
        Result := EmptyStr
      Else
        Result := 'Portador: ' + fieldbyname('CTB_CODPOR').AsString +
                  ' - Operador: ' + fieldbyname('CTB_CODOPE').AsString +
                  ' - Dta Lan: ' + FormatDateTime('dd/mm/yyyy',fieldbyname('CTB_DTALAN').AsDateTime) + #13#10 +
                  ' Nº Doc: ' + fieldbyname('CTB_NUMDOC').AsString +
                  '  -  Valor: ' + FormatFloat('#.#,0',fieldbyname('CTB_VALLAN').AsFloat) +
                  '  -  C/D: ' + fieldbyname('CTB_CREDEB').AsString + #13#10 +
                  ' Plano de Contas: ' + fieldbyname('CTA_DESCTA').AsString + #13#10 +
                  ' Empresa: ' + Fieldbyname('CTB_CODEMP').AsString + #13#10 +
                  ' Histórico: ' + fieldbyname('CTB_HIST01').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
End;

procedure TfrmCadConciliacaoBancaria.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.mskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCCusto, False) Then
  begin
    if fValidaCampos(fraPlanoDeContas.mskCodCta, True) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmCadConciliacaoBancaria.fSeRegistroFoiAlterado: Boolean;
Var
  cdsClone : TUniClientDataSet;
begin
  Result := False;
  If not cdsTmpMovBan.isEmpty Then
  Begin
    cdsClone := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsClone, cdsTmpMovBan);

    Result := (cdsClone.Locate('CONCILIADO;STATUS', VarArrayOf(['X','N']),[])) Or
              (cdsClone.Locate('CONCILIADO;STATUS', VarArrayOf(['','S']),[]));

    FreeAndNil(cdsClone);
  End;
end;

{*****************************}
{* BUSCA O SALDO DO PORTADOR *}
{**************************LU*}
procedure TfrmCadConciliacaoBancaria.pSaldoPortador;
Var
  strSQL : String;
  strUnion : String;
  fltSalPor: Double;
  fltSalTmp: Double;
  qryMovim : TUniQuery;
Begin
  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;
  Try
    lblSaldoAnt.Caption := '0,00';
//    lblSaldoFin.Caption := '0,00';
    pnlTotalInicial.Visible := True;
    pnlTotalFinal.Visible   := True;

    fltSalPor := 0;

    fltSalTmp := fDoubleAggregate(cdsTmpMovBan, 'TOT_TOTCRE') - fDoubleAggregate(cdsTmpMovBan, 'TOT_TOTDEB');

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(IF(CTB_CREDEB = "C", CTB_VALLAN, -CTB_VALLAN)) AS TOTLAN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVBAN ';
    strSQL := strSQL + '  LEFT JOIN CADPOR ON CTB_CODPOR = POR_CODPOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTB_CODPOR = :CODPOR AND ';
    strSQL := strSQL + '  CTB_CODPOR = :CODPOR ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND CTB_DTALAN BETWEEN POR_DTAINI AND :DTAINI ';

    {*************************************}
    {* QD OPCAO FOR CONCILIADOS OU TODOS *}
    {**********************************LU*}
    If (rdgOpcao.ItemIndex = 0) Or (rdgOpcao.ItemIndex = 2) Then
    Begin

      {***************************************}
      {* QD O PERIODO NAO ESTIVER PREENCHIDO *}
      {************************************LU*}
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fltSaldoIni := fltSalPor;
        fltSaldoFin := fltSalPor + fltSalTmp;
        lblSaldoAnt.Caption := FormatFloat('#,##0.00', fltSaldoIni);
//        lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin);
      End
      Else
      Begin
        Try
          If rdgOpcao.ItemIndex = 0 Then
            strSQL := strSQL + '  AND CTB_DTACON IS NOT NULL ';

          If Not fEmptyStr(edtCodEmpresa.Text) Then
            strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP','CODEMP');

          strUnion := strSQL;

          qryMovim := fCriaQuery;
          With qryMovim Do
          Begin
            strSQL := '';
            strSQL := strSQL + 'SELECT  ';
            strSQL := strSQL + '  SUM(TOTLAN) AS TOTLAN ';
            strSQL := strSQL + 'FROM ( ' + strUnion;
            strSQL := strSQL + '  ) AS TAB ';

            Close;
            SQL.Clear;
            SQL.Add(strSQL);

            ParamByName('CODPOR').AsString := edtCodPor.Text;
            If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
              ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text) - 1;

            If Not fEmptyStr(edtCodEmpresa.Text) Then
              pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryMovim);

            Open;
          End;

          fltSaldoIni := fltSalPor + qryMovim.fieldbyname('TOTLAN').AsFloat;
          fltSaldoFin := fltSaldoIni + fltSalTmp;

          lblSaldoAnt.Caption := FormatFloat('#,##0.00', fltSaldoIni);
//          lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );

        Finally
          FreeAndNil(qryMovim);
        End;
      End;

    End
    Else
    {*************************************}
    {* QD OPCAO FOR NAO CONCILIADOS      *}
    {**********************************LU*}
    Begin

      Try
        strSQL := strSQL + '   AND CTB_DTACON IS NULL ';

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP','CODEMP');

        strUnion := strSQL;

        qryMovim := fCriaQuery;
        With qryMovim Do
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT  ';
          strSQL := strSQL + '  SUM(TOTLAN) AS TOTLAN ';
          strSQL := strSQL + 'FROM ( ' + strUnion;
          strSQL := strSQL + '  ) AS TAB ';

          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODPOR').AsString := edtCodPor.Text;
          If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text) - 1;


          If Not fEmptyStr(edtCodEmpresa.Text) Then
            pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryMovim);

          Open;
        End;

        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fltSaldoIni := fltSalPor;
          fltSaldoFin := fltSalPor + fltSalTmp;
        End
        Else
        Begin
          fltSaldoIni := fltSalPor + qryMovim.fieldbyname('TOTLAN').AsFloat;
          fltSaldoFin := fltSalPor + fltSaldoIni + fltSalTmp;
        End;

        lblSaldoAnt.Caption := FormatFloat('#,##0.00', fltSaldoIni );
//        lblSaldoFin.Caption := FormatFloat('#,##0.00', fltSaldoFin );
      Finally
        FreeAndNil(qryMovim);
      End;

    End;

  Finally

  End;
  Screen.Cursor := crDefault;
  Application.ProcessMessages;
End;

procedure TfrmCadConciliacaoBancaria.rdgOpcaoClick(Sender: TObject);
begin
  inherited;

  if fSeRegistroFoiAlterado Then
    if Not fConfirmaSaidaConciliacao Then
    Begin
      With rdgOpcao do
      Begin
        onClick   := Nil;
        ItemIndex := intOpcaoAnt;
        onClick   := rdgOpcaoClick;
      End;
      Abort;
    End;

  {*****************************************}
  {* TODOS, SOMENTE ANALÍTICO              *}
  {**************************************MV*}
  If (rdgOpcao.ItemIndex = 2) Then
  Begin
    cmbAnaSin.Enabled := False;
    cmbAnaSin.ItemIndex := 0;
    pAtualizaTela;
  End
  Else
  Begin
    cmbAnaSin.Enabled := True;
  End;

  btnMovBan.Visible := (rdgOpcao.ItemIndex = 1) And (cmbAnaSin.ItemIndex = 0);
  btnTransfBan.Visible := fVerificaAcessoSistema('frmCadMovBancario_Te');

  btnConsultar.Click;

end;

procedure TfrmCadConciliacaoBancaria.rdgOpcaoEnter(Sender: TObject);
begin
  inherited;
  intOpcaoAnt := rdgOpcao.ItemIndex;
end;

function TfrmCadConciliacaoBancaria.RetornaAutoIncremDeContraPartida(
  ADataset: TDataset): String;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    fExecutaSQL('SET SESSION group_concat_max_len = 1000000');

    LConsulta.SQL.Text := 'SELECT GROUP_CONCAT(CONCAT(''"'', AUTOINCREM, ''"'')) AS AUTOINCREMS FROM MOVBAN  ' +
                          'WHERE CTB_DTALAN = :DTALAN AND ' +
                          '   CTB_CODEMP = :CODEMP AND    ' +
                          '   CTB_SEQCTP = :SEQCTP AND    ' +
                          '   CTB_CREDEB = :CREDEB        ';

    LConsulta.ParamByName('DTALAN').AsDateTime := ADataset.FieldByName('DTALAN').AsDateTime;
    LConsulta.ParamByName('CODEMP').AsString   := ADataset.FieldByName('CODEMP').AsString;
    LConsulta.ParamByName('SEQCTP').AsString   := ADataset.FieldByName('SEQCTP').AsString;
    LConsulta.ParamByName('CREDEB').AsString   := 'D';
    If ADataset.FieldByName('CREDEB').AsString = 'D' Then
      LConsulta.ParamByName('CREDEB').AsString := 'C';

    LConsulta.Open;

    Result := LConsulta.FieldByName('AUTOINCREMS').AsString;
  Finally
    fExecutaSQL('SET SESSION group_concat_max_len = 65535');
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadConciliacaoBancaria.SelecionaRegistrosVinculadosNaoMarcados(ARegistrosMarcados: String);
  Var
    LRegistros: TUniQuery;
begin
  FMovBanVinculadosNaoMarcados := '';
  FExtBanVinculadosNaoMarcados := '';

  LRegistros := fCriaQuery;

  Try
    fExecutaSQL('SET SESSION group_concat_max_len = 1000000');

    LRegistros.SQL.Text := 'SELECT  '+
                           '   GROUP_CONCAT(DISTINCT CONCAT(''"'', EXR_BANINC, ''"'')) AS MOVBANS, ' +
                           '   GROUP_CONCAT(DISTINCT CONCAT(''"'', EXR_EXTINC, ''"'')) AS EXTBANS ' +
                           ' FROM BANEXR WHERE EXR_EXTINC IN ( ' +
                           '    SELECT EXR_EXTINC FROM BANEXR WHERE EXR_BANINC IN (' + ARegistrosMarcados + ')) ' +
                           ' AND EXR_BANINC NOT IN (' + ARegistrosMarcados + ')';

    LRegistros.Open;

    If Not LRegistros.IsEmpty Then
    Begin
      FMovBanVinculadosNaoMarcados := LRegistros.FieldByName('MOVBANS').AsString;
      FExtBanVinculadosNaoMarcados := LRegistros.FieldByName('EXTBANS').AsString;
    End;

  Finally
    fExecutaSQL('SET SESSION group_concat_max_len = 65535');
    FreeAndNil(LRegistros);
  End;

end;

function TfrmCadConciliacaoBancaria.TemLancamentoVinculadoNaBanExr(APagCon: Integer; ACodCta: String): Boolean;
  Var
    LMovBan : TUniQuery;
    LSQL: String;
begin
  Try
    Result := True;
    LMovBan := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + 'SELECT                                    ';
    LSQL := LSQL + '  *                                       ';
    LSQL := LSQL + 'FROM                                      ';
    LSQL := LSQL + '  MOVBAN                                  ';
    LSQL := LSQL + '  LEFT JOIN BANEXR                        ';
    LSQL := LSQL + '    ON EXR_BANINC = MOVBAN.AUTOINCREM     ';
    LSQL := LSQL + '  LEFT JOIN CADPOR                        ';
    LSQL := LSQL + '    ON POR_CODPOR = CTB_CODPOR            ';
    LSQL := LSQL + 'WHERE                                     ';
    LSQL := LSQL + '  IFNULL(CTB_PAGCON, 0) = :PAGCON         ';
    LSQL := LSQL + ' AND CTB_DTACON IS NOT NULL               ';
    LSQL := LSQL + ' AND EXR_BANINC IS NULL                   ';
    LSQL := LSQL + ' AND POR_CCAAUT IS NOT NULL               ';
    LSQL := LSQL + ' AND POR_CONOFX = "S"                     ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      LSQL := LSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      LSQL := LSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      LSQL := LSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If not fEmptyStr(ACodCta) Then
      LSQL := LSQL + ' AND CTB_CODCTA = :CODCTA ';

     Try
       LMovBan.Close;
       LMovBan.Sql.Clear;
       LMovBan.Sql.Add(LSQL);
       LMovBan.ParamByName('PAGCON').AsInteger := APagCon;

       If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
       Begin
         LMovBan.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
         LMovBan.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
       End;

       If Not fEmptyStr(edtCodPor.Text) Then
         pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', LMovBan);

       If Not fEmptyStr(edtCodEmpresa.Text) Then
         pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', LMovBan);

       If Not fEmptyStr(ACodCta) Then
         LMovBan.ParamByName('CODCTA').AsString := ACodCta;

       LMovBan.Open;
       Result := Not LMovBan.IsEmpty; // Select Retorna os lançamento que não tem vinculo com a BANEXR
     Except
       On E : Exception Do
       Begin
         pMensagensErro(E.Message, '[TfrmCadConciliacaoBancaria.TemLancamentoVinculadoNaBanExr]');
       End;
     End;

  Finally
    FreeAndNil(LMovBan);
  End;

end;


procedure TfrmCadConciliacaoBancaria.tmrPiscarLBLTimer(Sender: TObject);
begin
  inherited;
  with lblConElePen do
  begin
    if (visible = false) then
      visible := true
    else
      visible := false;

    application.ProcessMessages;
  end;
end;

function TfrmCadConciliacaoBancaria.ValidaPortadorContaVinculada: Boolean;
begin
  Result := True;

  Case cmbAnaSin.ItemIndex Of
    0: Begin
         Result := VerificaPortadorContaVinculada(cdsTmpMovBan.FieldByName('CODCTA').AsString,
                                                  cdsTmpMovBan.FieldByName('AUTOINCREM').AsString);
       End;
    1: Begin
         Result := VerificaPortadorContaVinculada(cdsTmpMovBan.FieldByName('CODCTA').AsString,'');
       End;
    2: Begin
         Result := VerificaPortadorContaVinculada(cdsTmpMovBan.FieldByName('PAGCON').AsInteger, '');
       End;
    3, 4: Begin
         Result := VerificaPortadorContaVinculada(cdsTmpMovBan.FieldByName('PAGCON').AsInteger,
                                                  cdsTmpMovBan.FieldByName('CODCTA').AsString);
       End;
  End;
end;

function TfrmCadConciliacaoBancaria.ValidaVinculoLancamentos: Boolean;
begin
  Result := True;

  Case cmbAnaSin.ItemIndex Of
    0: Begin
         Result := Not TemLancamentoVinculadoNaBanExr(cdsTmpMovBan.FieldByName('CODCTA').AsString,
                                                      cdsTmpMovBan.FieldByName('AUTOINCREM').AsString);
       End;
    1: Begin
         Result := Not TemLancamentoVinculadoNaBanExr(cdsTmpMovBan.FieldByName('CODCTA').AsString,'');
       End;
    2: Begin
         Result := Not TemLancamentoVinculadoNaBanExr(cdsTmpMovBan.FieldByName('PAGCON').AsInteger,'');
       End;
    3, 4: Begin
         Result := Not TemLancamentoVinculadoNaBanExr(cdsTmpMovBan.FieldByName('PAGCON').AsInteger,
                                                      cdsTmpMovBan.FieldByName('CODCTA').AsString);
       End;
  End;
end;

function TfrmCadConciliacaoBancaria.VerificaPortadorContaVinculada(APagCon: Integer; ACodCta: String): Boolean;
  Var
    LMovBan : TUniQuery;
    LSQL: String;
begin
  Try
    Result := True;
    LMovBan := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + 'SELECT                                    ';
    LSQL := LSQL + '  *                                       ';
    LSQL := LSQL + 'FROM                                      ';
    LSQL := LSQL + '  MOVBAN                                  ';
    LSQL := LSQL + '  LEFT JOIN CADPOR                        ';
    LSQL := LSQL + '    ON POR_CODPOR = CTB_CODPOR            ';
    LSQL := LSQL + 'WHERE                                     ';
    LSQL := LSQL + '  IFNULL(CTB_PAGCON, 0) = :PAGCON         ';
    LSQL := LSQL + ' AND CTB_DTACON IS NULL                   ';
    LSQL := LSQL + ' AND POR_CCAAUT IS NOT NULL               ';
    LSQL := LSQL + ' AND POR_CONOFX = "S"                     ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      LSQL := LSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      LSQL := LSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      LSQL := LSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If not fEmptyStr(ACodCta) Then
      LSQL := LSQL + ' AND CTB_CODCTA = :CODCTA ';

     Try
       LMovBan.Close;
       LMovBan.Sql.Clear;
       LMovBan.Sql.Add(LSQL);
       LMovBan.ParamByName('PAGCON').AsInteger := APagCon;

       If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
       Begin
         LMovBan.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
         LMovBan.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
       End;

       If Not fEmptyStr(edtCodPor.Text) Then
         pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', LMovBan);

       If Not fEmptyStr(edtCodEmpresa.Text) Then
         pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', LMovBan);

       If Not fEmptyStr(ACodCta) Then
         LMovBan.ParamByName('CODCTA').AsString := ACodCta;

       LMovBan.Open;
       Result := LMovBan.IsEmpty; // Select Retorna os lançamentos onde o portador tem vinculo de conta
     Except
       On E : Exception Do
       Begin
         pMensagensErro(E.Message, '[TfrmCadConciliacaoBancaria.TemLancamentoVinculadoNaBanExr]');
       End;
     End;

  Finally
    FreeAndNil(LMovBan);
  End;

end;

function TfrmCadConciliacaoBancaria.VerificaPortadorContaVinculada(ACodCta,AAutInc: String): Boolean;
  Var
    LMovBan : TUniQuery;
    LSQL: String;
begin
  Try
    Result := True;
    LMovBan := fCriaQuery(Nil);

    LSQL := '';
    LSQL := LSQL + 'SELECT                                    ';
    LSQL := LSQL + '  *                                       ';
    LSQL := LSQL + 'FROM                                      ';
    LSQL := LSQL + '  MOVBAN                                  ';
    LSQL := LSQL + '  LEFT JOIN CADPOR                        ';
    LSQL := LSQL + '    ON POR_CODPOR = CTB_CODPOR            ';
    LSQL := LSQL + 'WHERE                                     ';
    LSQL := LSQL + '     CTB_CODCTA = :CODCTA                 ';
    LSQL := LSQL + ' AND CTB_DTACON IS NULL                   ';
    LSQL := LSQL + ' AND POR_CCAAUT IS NOT NULL               ';
    LSQL := LSQL + ' AND POR_CONOFX = "S"                     ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      LSQL := LSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      LSQL := LSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      LSQL := LSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If Not fEmptyStr(AAutInc) Then
      LSQL := LSQL + ' AND MOVBAN.AUTOINCREM = :AUTINC ';

     Try
       LMovBan.Close;
       LMovBan.Sql.Clear;
       LMovBan.Sql.Add(LSQL);
       LMovBan.ParamByName('CODCTA').AsString := ACodCta;

       If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
       Begin
         LMovBan.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
         LMovBan.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
       End;

       If Not fEmptyStr(edtCodPor.Text) Then
         pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', LMovBan);

       If Not fEmptyStr(edtCodEmpresa.Text) Then
         pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', LMovBan);

       If Not fEmptyStr(AAutInc) Then
         LMovBan.ParamByName('AUTINC').AsString := AAutInc;

       LMovBan.Open;
       Result := LMovBan.IsEmpty; // Select Retorna os lançamentos onde o portador tem vinculo de conta
     Except
       On E : Exception Do
       Begin
         pMensagensErro(E.Message, '[TfrmCadConciliacaoBancaria.TemLancamentoVinculadoNaBanExr]');
       End;
     End;

  Finally
    FreeAndNil(LMovBan);
  End;

end;

procedure TfrmCadConciliacaoBancaria.pCriarColunasGrid;
  Type TRegistroGrid = Record
    strTitulos  : String;
    strCampos   : String;
    intTamanho  : Integer;
  End;

  Var
    intContador : Integer;
    intIndArr   : Integer;
    intRecNo    : Integer;
    arrGrid     : Array of TRegistroGrid;

  function fCompletaTamanhoGrid(intTamanhoColunas: Integer): Integer;
  begin
    Result := (cxgConciliacaoBancaria.Width - 25)-intTamanhoColunas;
  end;

  function fGetIndexArrGrid(strCampo: String): Integer;
    Var
      I: Integer;
  begin
    Result := -1;
    for I := Low(arrGrid) to High(arrGrid) do
      If arrGrid[I].strCampos = strCampo Then
      Begin
        Result := I;
        Break;
      End;
  end;

begin

  {****************************************}
  {* CUSTOMIZA O GRID DEPENDENDO DA OPÇÃO *}
  {*************************************JU*}

  Screen.Cursor := crSQLWait;

  If cmbAnaSin.ItemIndex = 0 Then
  Begin
    SetLength(arrGrid, 16);


    arrGrid[0].strTitulos := 'Status';
    arrGrid[0].strCampos  := 'STATUS';
    arrGrid[0].intTamanho := 1;
    arrGrid[1].strTitulos := 'CONCILIADO';
    arrGrid[1].strCampos  := 'CONCILIADO';
    arrGrid[1].intTamanho := 1;
    arrGrid[2].strTitulos := 'Portador';
    arrGrid[2].strCampos  := 'CODPOR';
    arrGrid[2].intTamanho := 48;
    arrGrid[3].strTitulos := 'Dta.Lan.';
    arrGrid[3].strCampos  := 'DTALAN';
    arrGrid[3].intTamanho := 68;
    arrGrid[4].strTitulos := 'Oper.';
    arrGrid[4].strCampos  := 'CODOPE';
    arrGrid[4].intTamanho := 35;
    arrGrid[5].strTitulos := 'Nome Operador';
    arrGrid[5].strCampos  := 'NOMOPE';
    arrGrid[5].intTamanho := 150;
    arrGrid[6].strTitulos := 'Nº Doc.';
    arrGrid[6].strCampos  := 'NUMDOC';
    arrGrid[6].intTamanho := 70;
    arrGrid[7].strTitulos := 'Pla. Contas';
    arrGrid[7].strCampos  := 'CODCTA';
    arrGrid[7].intTamanho := 80;
    arrGrid[8].strTitulos := 'Descrição';
    arrGrid[8].strCampos  := 'DESCTA';
    arrGrid[8].intTamanho := 160;
    arrGrid[9].strTitulos := 'Valor';
    arrGrid[9].strCampos  := 'VALOR';
    arrGrid[9].intTamanho := 80;
    arrGrid[10].strTitulos := 'C/D';
    arrGrid[10].strCampos  := 'CREDEB';
    arrGrid[10].intTamanho := 25;
    arrGrid[11].strTitulos := 'Histórico';
    arrGrid[11].strCampos  := IIF(blnHisBan,'HISBAN','HISTORICO');
    arrGrid[11].intTamanho := fCompletaTamanhoGrid(640);
    arrGrid[12].strTitulos := 'Emp.';
    arrGrid[12].strCampos  := 'CODEMP';
    arrGrid[12].intTamanho := 33;
    arrGrid[13].strTitulos := 'Seq. Transf.';
    arrGrid[13].strCampos  := 'SEQTRANSF';
    arrGrid[13].intTamanho := 80;
    arrGrid[14].strTitulos := 'Detalhe';
    arrGrid[14].strCampos  := 'DETALH';
    arrGrid[14].intTamanho := 41;
    arrGrid[15].strTitulos := 'Ignorados';
    arrGrid[15].strCampos  := 'IGNORA';
    arrGrid[15].intTamanho := 2;
  End
  Else If cmbAnaSin.ItemIndex = 1 Then
  Begin
    SetLength(arrGrid, 5);
    arrGrid[0].strTitulos := 'Status';
    arrGrid[0].strCampos  := 'STATUS';
    arrGrid[0].intTamanho := 1;

    arrGrid[1].strTitulos := 'CONCILIADO';
    arrGrid[1].strCampos  := 'CONCILIADO';
    arrGrid[1].intTamanho := 1;

    arrGrid[2].strTitulos := 'Plano de Contas';
    arrGrid[2].strCampos  := 'CODCTA';
    arrGrid[2].intTamanho := 100;

    arrGrid[3].strTitulos := 'Descrição';
    arrGrid[3].strCampos  := 'DESCTA';
    arrGrid[3].intTamanho := fCompletaTamanhoGrid(182);

    arrGrid[4].strTitulos := 'Valor';
    arrGrid[4].strCampos  := 'VALOR';
    arrGrid[4].intTamanho := 80;

  End
  Else If cmbAnaSin.ItemIndex = 2 Then
  Begin
    SetLength(arrGrid, 5);

    arrGrid[0].strTitulos := 'Status';
    arrGrid[0].strCampos  := 'STATUS';
    arrGrid[0].intTamanho := 1;

    arrGrid[1].strTitulos := 'CONCILIADO';
    arrGrid[1].strCampos  := 'CONCILIADO';
    arrGrid[1].intTamanho := 1;

    arrGrid[2].strTitulos := 'Sequêncial de Conferencia';
    arrGrid[2].strCampos  := 'PAGCON';
    arrGrid[2].intTamanho := 150;

    arrGrid[3].strTitulos := 'Data';
    arrGrid[3].strCampos  := 'DTALAN';
    arrGrid[3].intTamanho := 60;

    arrGrid[4].strTitulos := 'Valor';
    arrGrid[4].strCampos  := 'VALOR';
    arrGrid[4].intTamanho := 80;

  End
  Else If cmbAnaSin.ItemIndex = 3 Then
  Begin
    SetLength(arrGrid, 7);

    arrGrid[0].strTitulos := 'Status';
    arrGrid[0].strCampos  := 'STATUS';
    arrGrid[0].intTamanho := 1;

    arrGrid[1].strTitulos := 'CONCILIADO';
    arrGrid[1].strCampos  := 'CONCILIADO';
    arrGrid[1].intTamanho := 1;

    arrGrid[2].strTitulos := 'Sequêncial de Conferencia';
    arrGrid[2].strCampos  := 'PAGCON';
    arrGrid[2].intTamanho := 150;

    arrGrid[3].strTitulos := 'Plano de Contas';
    arrGrid[3].strCampos  := 'CODCTA';
    arrGrid[3].intTamanho := 100;

    arrGrid[4].strTitulos := 'Descrição';
    arrGrid[4].strCampos  := 'DESCTA';
    arrGrid[4].intTamanho := fCompletaTamanhoGrid(392);

    arrGrid[5].strTitulos := 'Data';
    arrGrid[5].strCampos  := 'DTALAN';
    arrGrid[5].intTamanho := 60;

    arrGrid[6].strTitulos := 'Valor';
    arrGrid[6].strCampos  := 'VALOR';
    arrGrid[6].intTamanho := 80;
  End
  Else If cmbAnaSin.ItemIndex = 4 Then
  begin
    SetLength(arrGrid, 17);

    arrGrid[0].strTitulos := 'Status';
    arrGrid[0].strCampos  := 'STATUS';
    arrGrid[0].intTamanho := 1;

    arrGrid[1].strTitulos := 'Conciliado';
    arrGrid[1].strCampos  := 'CONCILIADO';
    arrGrid[1].intTamanho := 1;

    arrGrid[2].strTitulos := 'Portador';
    arrGrid[2].strCampos  := 'CODPOR';
    arrGrid[2].intTamanho := 48;

    arrGrid[3].strTitulos := 'Dta.Lan.';
    arrGrid[3].strCampos  := 'DTALAN';
    arrGrid[3].intTamanho := 68;

    arrGrid[4].strTitulos := 'Oper.';
    arrGrid[4].strCampos  := 'CODOPE';
    arrGrid[4].intTamanho := 35;

    arrGrid[5].strTitulos := 'Nome Operador';
    arrGrid[5].strCampos  := 'NOMOPE';
    arrGrid[5].intTamanho := 150;

    arrGrid[6].strTitulos := 'Nº Doc.';
    arrGrid[6].strCampos  := 'NUMDOC';
    arrGrid[6].intTamanho := 70;

    arrGrid[7].strTitulos := 'Pla. Contas';
    arrGrid[7].strCampos  := 'CODCTA';
    arrGrid[7].intTamanho := 80;

    arrGrid[8].strTitulos := 'Descrição';
    arrGrid[8].strCampos  := 'DESCTA';
    arrGrid[8].intTamanho := 160;

    arrGrid[9].strTitulos := 'Valor';
    arrGrid[9].strCampos  := 'VALOR';
    arrGrid[9].intTamanho := 80;

    arrGrid[10].strTitulos := 'C/D/T';
    arrGrid[10].strCampos  := 'TIPMOV';
    arrGrid[10].intTamanho := 25;

    arrGrid[11].strTitulos := 'Histórico';
    arrGrid[11].strCampos  := IIF(blnHisBan,'HISBAN','HISTORICO');
    arrGrid[11].intTamanho := fCompletaTamanhoGrid(640);

    arrGrid[12].strTitulos := 'Emp.';
    arrGrid[12].strCampos  := 'CODEMP';
    arrGrid[12].intTamanho := 33;

    arrGrid[13].strTitulos := 'Seq. Transf.';
    arrGrid[13].strCampos  := 'SEQTRANSF';
    arrGrid[13].intTamanho := 80;

    arrGrid[14].strTitulos := 'Detalhe';
    arrGrid[14].strCampos  := 'DETALH';
    arrGrid[14].intTamanho := 41;

    arrGrid[15].strTitulos := 'Desc. Bandeira';
    arrGrid[15].strCampos  := 'NOMBAN';
    arrGrid[15].intTamanho := 41;

    arrGrid[16].strTitulos := 'Ignorados';
    arrGrid[16].strCampos  := 'IGNORA';
    arrGrid[16].intTamanho := 2;
  end;

  dtsTmpMovBan.OnDataChange := nil;
  cxgConciliacaoBancariaView.ClearItems;
  cxgConciliacaoBancariaView.DataController.CreateAllItems;

  For intContador := 0 To cxgConciliacaoBancariaView.ColumnCount - 1 Do
  Begin
    intIndArr := fGetIndexArrGrid(cxgConciliacaoBancariaView.Columns[intContador].DataBinding.FieldName);

    cxgConciliacaoBancariaView.Columns[intContador].Visible := intIndArr > 1;

    If intIndArr > 0 Then
      If arrGrid[intIndArr].strCampos = 'IGNORA' then
        cxgConciliacaoBancariaView.Columns[intContador].Visible := False;

    If intIndArr > -1 Then
    Begin
      cxgConciliacaoBancariaView.Columns[intContador].Caption := arrGrid[intIndArr].strTitulos;
      cxgConciliacaoBancariaView.Columns[intContador].Width   := arrGrid[intIndArr].intTamanho;
    End;
  End;

  dtsTmpMovBan.OnDataChange := dtsTmpMovBanDataChange;

  Screen.Cursor := crDefault;

  fGetFuncoesCxGrid.fCarregarView(cxgConciliacaoBancariaView,
                                                 fGetChaveLayoutGrid(cmbAnaSin.Text),
                                                 cdsTmpMovBan,
                                                 intRecNo,
                                                 False,
                                                 'S');
  TratarExibicaoColunas;

  cxgConciliacaoBancariaView.DataController.filter.Active := False;
  LIndexColumnIgnora := -1;
end;

procedure TfrmCadConciliacaoBancaria.cmbAnaSinClick(Sender: TObject);
begin
  inherited;

  if fSeRegistroFoiAlterado Then
    if Not fConfirmaSaidaConciliacao Then
    Begin
      With cmbAnaSin do
      Begin
        onChange  := Nil;
        ItemIndex := intOpcaoAnt;
        onChange  := cmbAnaSinClick;
      End;
      Abort;
    End;

  pAtualizaTela;
end;

procedure TfrmCadConciliacaoBancaria.cmbAnaSinEnter(Sender: TObject);
begin
  inherited;
  intOpcaoAnt := cmbAnaSin.ItemIndex;
end;

function TfrmCadConciliacaoBancaria.fDeveAtualizar(ADataset: TDataset): Boolean;
begin
  Result := False;

  If ADataset.FieldByName('CONCILIADO').AsString.Equals('X') Then
    Exit(ADataset.FieldByName('STATUS').AsString.Equals('N'));

  If ADataset.FieldByName('CONCILIADO').AsString.Trim.IsEmpty Then
     Exit(ADataset.FieldByName('STATUS').AsString.Equals('S'));
end;

procedure TfrmCadConciliacaoBancaria.pAtualizarMovBanAnalitico;
  Var
    strIncAtu    : String;
    prcScroll    : TprcScroll;
    blnConciliar : Boolean;
    blnAtualizado: Boolean;

    LGravando: TfrmGravando;

    LDatasetClone: TUniClientDataset;

    LItemUpdate: TRegistrosConciliarBancaria;
begin

  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;

  If Not cdsTmpMovBan.Active Then
    Exit;

  If cdsTmpMovBan.IsEmpty Then
    Exit;

  pDisableControls(cdsTmpMovBan, prcScroll);

  Try
    LDatasetClone := fCriaClientDatSet(cdsTmpMovBan);
    LDatasetClone.Open;

    LDatasetClone.IndexFieldNames := 'CONCILIADO;STATUS';

    strIncAtu := cdsTmpMovBan.FieldByName('AUTOINCREM').AsString;

    pnlInfo.Caption := 'Aguarde, gerando lista...';
    pgbProgresso.Visible := True;
    pgbProgresso.Max     := LDatasetClone.RecordCount;

    blnAtualizado := False;

    FListaRegistrosAtualizar := TList<TRegistrosConciliarBancaria>.Create;

    Try

      LDatasetClone.First;
      While Not LDatasetClone.Eof Do
      Begin
        If Not blnAtualizado Then
          blnAtualizado := fDeveAtualizar(LDatasetClone);

        If fDeveAtualizar(LDatasetClone) Then
          AdicionaRegistroNaListaDeAtualizacao(LDatasetClone);

        LDatasetClone.Next;
        pgbProgresso.Position := LDatasetClone.RecNo;
        Application.ProcessMessages;
      End;

      pnlInfo.Caption := 'Aguarde, atualizando...';

      fStartTransaction;

      LDatasetClone.First;
      For LItemUpdate In FListaRegistrosAtualizar Do
      Begin
        blnConciliar := LItemUpdate.Status.Equals('S');

        pEfetuarUpdate(EmptyStr,
                       LItemUpdate.AutoIncremsUpdate,
                       blnConciliar,
                       LItemUpdate);
      End;

      If Not FMovBanVinculadosNaoMarcados.IsEmpty Then
      Begin
        pCriarFormularios(TfrmGravando, LGravando);
        Try
          LGravando.lblGravando.Caption := 'Aguarde... Desconciliando registros.';
          LGravando.fExecutarAcao := DesconciliaRegistrosVinculadosNaoMarcados;
          LGravando.ShowModal;
        Finally
          FreeAndNil(LGravando);
        End;
      End;

      fCommit;

      cdsTmpMovBan.Close;
      pCriarTemporaria;

      If Not blnAtualizado Then
        pMensagemOk('Nenhum Registro Selecionado !')
      Else
        pMensagemOk('Atualização efetuada com sucesso !');

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[pAtualizarMovBanAnalitico]');
      End;
    End;

    If Not cdsTmpMovBan.IsEmpty Then
      cdsTmpMovBan.Locate('AUTOINCREM', strIncAtu, [])
    Else
    Begin
      edtQtdSel.Clear;
      edtCreSel.Clear;
      edtDebSel.Clear;
      edtDifSel.Clear;
      edtQtdGer.Clear;
      edtCreGer.Clear;
      edtDebGer.Clear;
      edtDifGer.Clear;
    End;
  Finally
    LDatasetClone.Close;
    FreeAndNil(LDatasetClone);

    FreeAndNil(FListaRegistrosAtualizar);

    pEnableControls(cdsTmpMovBan, prcScroll);

    pgbProgresso.Visible := False;
    pnlInfo.Caption := '';

    Screen.Cursor := crDefault;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadConciliacaoBancaria.pAtualizarMovBanSintetico;
  Var
    blnConciliar: Boolean;
    blnAtualizar: Boolean;
    blnAtualizado: Boolean;
    prcScroll: TprcScroll;

    LGravando: TfrmGravando;

    function fCampo(strCampo: string): TField;
    begin
      Result := cdsTmpMovBan.FieldByName(strCampo);
    end;

    function fDeveAtualizar: Boolean;
    begin
      Result := ((fCampo('CONCILIADO').AsString = 'X') And (fCampo('STATUS').AsString = 'N')) Or
                ((fCampo('CONCILIADO').AsString = '' ) And (fCampo('STATUS').AsString = 'S'));
    end;

begin
  If (Not cdsTmpMovBan.Active) Or cdsTmpMovBan.IsEmpty then
    Exit;

  Screen.Cursor := crSQLWait;
  Application.ProcessMessages;

  blnAtualizado := False;
  pDisableControls(cdsTmpMovBan, prcScroll);
  fStartTransaction;

  Try
    cdsTmpMovBan.First;
    While (Not cdsTmpMovBan.Eof) Do
    Begin
      blnAtualizar := False;

      {*****************************************}
      {* CASO TROUXE OS CONCILIADOS E DESMAR-  *}
      {* COU ALGUM CENTRO DE CUSTO, "DESCON-   *}
      {* CILIA".                               *}
      {**************************************MV*}
      blnConciliar := False;
      If (rdgOpcao.ItemIndex = 0) And (cdsTmpMovBan.FieldByName('STATUS').AsString = 'N') Then
      Begin
        blnAtualizar := True;
        blnConciliar := False;
      End
      {*****************************************}
      {* CASO TROUXE OS NÃO-CONCILIADOS E MAR- *}
      {* COU ALGUM CENTRO DE CUSTO, CONCILIA.  *}
      {**************************************MV*}
      Else If (rdgOpcao.ItemIndex = 1) And (cdsTmpMovBan.FieldByName('STATUS').AsString = 'S') Then
      Begin
        blnAtualizar := True;
        blnConciliar := True;
      End;

      blnAtualizado := blnAtualizado Or blnAtualizar;

      If blnAtualizar Then
      Begin
        Case cmbAnaSin.ItemIndex Of
          1: Begin
               pEfetuarUpdate(cdsTmpMovBan.FieldByName('CODCTA').AsString, '', blnConciliar);
             End;
          2: Begin
               pEfetuarUpdate(cdsTmpMovBan.FieldByName('PAGCON').AsInteger, '', blnConciliar);
             End;
          3, 4: Begin
               pEfetuarUpdate(cdsTmpMovBan.FieldByName('PAGCON').AsInteger, cdsTmpMovBan.FieldByName('CODCTA').AsString, blnConciliar);
             End;
        End;
      End;

      cdsTmpMovBan.Next;
    End;

    If Not FMovBanVinculadosNaoMarcados.IsEmpty Then
    Begin
      pCriarFormularios(TfrmGravando, LGravando);
      Try
        LGravando.lblGravando.Caption := 'Aguarde... Desconciliando registros.';
        LGravando.fExecutarAcao := DesconciliaRegistrosVinculadosNaoMarcados;
        LGravando.ShowModal;
      Finally
        FreeAndNil(LGravando);
      End;
    End;

    fCommit;

    cdsTmpMovBan.Close;

    Screen.Cursor := crDefault;
    Application.ProcessMessages;

    pCriarTemporaria;
    If blnAtualizado Then
      fMensagem('AVISO', 'Atualização efetuada com sucesso !', ['&O K'])
    Else
      fMensagem('AVISO', 'Nenhum Registro Selecionado !', ['&O K'])
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pAtualizarMovBanSintetico]');
    End;
  End;
  pEnableControls(cdsTmpMovBan, prcScroll);

  Screen.Cursor := crDefault;
  Application.ProcessMessages;
end;

procedure TfrmCadConciliacaoBancaria.pAtualizarRegistroMovBan(strSeqLan: String;
  blnInserir: Boolean);
  Var
    qryMovBan : TUniQuery;
    blnStatus : Boolean;
begin
  qryMovBan := fCriaQuery(Self);

  With qryMovBan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN');
    ParamByName('SEQLAN').AsString := strSeqLan;
    Open;
  End;

  blnStatus := False;

  If Not qryMovBan.IsEmpty Then
  Begin
    If (blnInserir) Then
    Begin
      cdsTmpMovBan.Insert;
      cdsTmpMovBan.FieldByName('SEQLAN').AsString := strSeqLan;
    End
    Else
    Begin
      If cdsTmpMovBan.Locate('SEQLAN', strSeqLan, []) Then
      Begin
        cdsTmpMovBan.Edit;
        blnStatus := (cdsTmpMovBan.FieldByName('STATUS').AsString = 'S');
      End;
    End;

    If cdsTmpMovBan.State In [dsInsert, dsEdit] Then
    Begin
      cdsTmpMovBan.FieldByName('STATUS').AsString := IIF(blnStatus, 'S', 'N');
      cdsTmpMovBan.FieldByName('CONCILIADO').AsString := IIF(qryMovBan.FieldByName('CTB_DTACON').IsNull, '', 'X');
      cdsTmpMovBan.FieldByName('CODPOR').AsString := qryMovBan.FieldByName('CTB_CODPOR').AsString;
      cdsTmpMovBan.FieldByName('DTALAN').AsDateTime := qryMovBan.FieldByName('CTB_DTALAN').AsDateTime;
      cdsTmpMovBan.FieldByName('CODOPE').AsString := qryMovBan.FieldByName('CTB_CODOPE').AsString;
      cdsTmpMovBan.FieldByName('NUMDOC').AsString := qryMovBan.FieldByName('CTB_NUMDOC').AsString;
      cdsTmpMovBan.FieldByName('CODCTA').AsString := qryMovBan.FieldByName('CTB_CODCTA').AsString;
      cdsTmpMovBan.FieldByName('VALOR').AsFloat := qryMovBan.FieldByName('CTB_VALLAN').AsFloat;
      cdsTmpMovBan.FieldByName('CREDEB').AsString := qryMovBan.FieldByName('CTB_CREDEB').AsString;
      If blnHisBan Then
        cdsTmpMovBan.FieldByName('HISBAN').AsString := qryMovBan.FieldByName('CTB_HIST01').AsString +' '+
                                                       qryMovBan.FieldByName('CTB_HIST02').AsString
      Else
        cdsTmpMovBan.FieldByName('HISTORICO').AsString := qryMovBan.FieldByName('CTB_HIST01').AsString;
      cdsTmpMovBan.FieldByName('AUTOINCREM').AsString := qryMovBan.FieldByName('AUTOINCREM').AsString;
      cdsTmpMovBan.FieldByName('DESCTA').AsString := fRetNomeConta(qryMovBan.FieldByName('CTB_CODCTA').AsString);
      cdsTmpMovBan.FieldByName('GERDEB').AsString := IIF(qryMovBan.FieldByName('CTB_CREDEB').AsString = 'D', qryMovBan.FieldByName('CTB_VALLAN').AsFloat, 0);
      cdsTmpMovBan.FieldByName('GERCRE').AsString := IIF(qryMovBan.FieldByName('CTB_CREDEB').AsString = 'C', qryMovBan.FieldByName('CTB_VALLAN').AsFloat, 0);
      cdsTmpMovBan.FieldByName('DTACON').AsDateTime := qryMovBan.FieldByName('CTB_DTACON').AsDateTime;
      cdsTmpMovBan.FieldByName('HORCON').AsDateTime := qryMovBan.FieldByName('CTB_HORCON').AsDateTime;
      cdsTmpMovBan.FieldByName('OPECON').AsString := qryMovBan.FieldByName('CTB_OPECON').AsString;
      cdsTmpMovBan.FieldByName('QTDSEL').AsInteger := IIF(blnStatus, 1, 0);
      cdsTmpMovBan.FieldByName('TOTDEB').AsString := IIF((blnStatus) And (qryMovBan.FieldByName('CTB_CREDEB').AsString = 'D'), qryMovBan.FieldByName('CTB_VALLAN').AsFloat, 0);
      cdsTmpMovBan.FieldByName('TOTCRE').AsString := IIF((blnStatus) And (qryMovBan.FieldByName('CTB_CREDEB').AsString = 'C'), qryMovBan.FieldByName('CTB_VALLAN').AsFloat, 0);
      cdsTmpMovBan.FieldByName('SEQCTP').AsString := qryMovBan.FieldByName('CTB_SEQCTP').AsString;
      cdsTmpMovBan.FieldByName('CODEMP').AsString := qryMovBan.FieldByName('CTB_CODEMP').AsString;
      cdsTmpMovBan.FieldByName('PAGCON').AsInteger := StrToIntDef(qryMovBan.FieldByName('CTB_PAGCON').AsString, 0);
      cdsTmpMovBan.FieldByName('ORIGEM').AsString := qryMovBan.FieldByName('CTB_ORIGEM').AsString;
      cdsTmpMovBan.Post;
    End;
  End;

  FreeAndNil(qryMovBan);
end;

procedure TfrmCadConciliacaoBancaria.pAtualizaTela;
begin
  If (cmbAnaSin.ItemIndex = 0) Then
  Begin
    lblCreSel.Caption := 'Total Créditos:';

    lblDebSel.Caption := 'Total Débitos:';
    lblDebSel.Visible := True;
    edtDebSel.Visible := True;

    lblDifSel.Caption := 'Diferença:';
    lblDifSel.Visible := True;
    edtDifSel.Visible := True;

    lblCreGer.Caption := 'Total Créditos:';

    lblDebGer.Visible := True;
    edtDebGer.Visible := True;

    lblDifGer.Visible := True;
    edtDifGer.Visible := True;
  End
  Else
  Begin
    lblCreSel.Caption := 'Total:';

    lblDebSel.Visible := False;
    edtDebSel.Visible := False;

    lblDifSel.Visible := False;
    edtDifSel.Visible := False;

    lblCreGer.Caption := 'Total:';

    lblDebGer.Visible := False;
    edtDebGer.Visible := False;

    lblDifGer.Visible := False;
    edtDifGer.Visible := False;

    cdsTmpMovBan.Filter := '';
  End;

  btnLocContraPart.Enabled := (cmbAnaSin.ItemIndex = 0);
  btnLocContraPartValor.Enabled := (cmbAnaSin.ItemIndex = 0);
  btnLocRegVin.Enabled := (cmbAnaSin.ItemIndex = 0);
  btnAltDataLancto.Enabled := (cmbAnaSin.ItemIndex = 0);
  btnMovBan.Visible := (rdgOpcao.ItemIndex = 1) And (cmbAnaSin.ItemIndex = 0);

  btnTransfBan.Visible := fVerificaAcessoSistema('frmCadMovBancario_Te');

  btnConsultar.Click;
end;

procedure TfrmCadConciliacaoBancaria.pEfetuarUpdate(intPagCon: Integer; strCodCta : String; blnConciliar: Boolean);
  Var
    strSQL: String;
    qryAux: TUniQuery;

    LHoraConciliacao: TTime;

    LValorInicialAutoIncrem: Integer;
    LAutoIncremLancamentos: String;
begin
  if (not blnConciliar) then
    LAutoIncremLancamentos := RetornaAutoIncremLancamentosSintetico(intPagCon, strCodCta);

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  MOVBAN ';
  strSQL := strSQL + 'SET ';

  LHoraConciliacao := fTime();

  If (blnConciliar) Then
  Begin
    strSQL := strSQL + '  CTB_DTACON = :DTACON, ';
    strSQL := strSQL + '  CTB_HORCON = :HORCON, ';
    strSQL := strSQL + '  CTB_OPECON = :OPECON  ';
  End
  Else
  Begin
    strSQL := strSQL + '  CTB_DTACON = NULL, ';
    strSQL := strSQL + '  CTB_HORCON = NULL, ';
    strSQL := strSQL + '  CTB_OCOIGN = NULL, ';
    strSQL := strSQL + '  CTB_IGNORA = NULL, ';
    strSQL := strSQL + '  CTB_OPECON = NULL  ';
  End;

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  IFNULL(CTB_PAGCON, 0) = :PAGCON ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(edtCodPor.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

  If not fEmptyStr(strCodCta) Then
    strSQL := strSQL + ' AND CTB_CODCTA = :CODCTA ';

  If rdgOpcao.ItemIndex = 0 Then
    strSQL := strSQL + ' AND CTB_DTACON IS NOT NULL '
  Else If rdgOpcao.ItemIndex = 1 Then
    strSQL := strSQL + ' AND CTB_DTACON IS NULL ';

  qryAux := fCriaQuery(Self);

  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);

    If (blnConciliar) Then
    Begin
      qryAux.ParamByName('DTACON').AsDateTime := dtaDtaCon;
      qryAux.ParamByName('HORCON').AsString   := FormatDateTime('hh:nn:ss', LHoraConciliacao);
      qryAux.ParamByName('OPECON').AsString   := strLoginUsuarioLogado;
    End;

    qryAux.ParamByName('PAGCON').AsInteger := intPagCon;

    if not fEmptyStr(strCodCta) Then
      qryAux.ParamByName('CODCTA').AsString := strCodCta;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      qryAux.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      qryAux.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(edtCodPor.Text) Then
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryAux);

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryAux);

    qryAux.ExecSQL;

    //GRAVANDO LOG
    qryAux.Close;
    qryAux.Sql.Clear;
    strSql := 'SELECT * FROM MOVBAN ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  IFNULL(CTB_PAGCON, 0) = :PAGCON ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If not fEmptyStr(strCodCta) Then
      strSQL := strSQL + ' AND CTB_CODCTA = :CODCTA ';

    If blnConciliar Then
      strSQL := strSQL + ' AND (CTB_DTACON=:DTACON AND CTB_HORCON=:HORCON AND CTB_OPECON=:OPECON) '
    Else
      strSQL := strSQL + ' AND CTB_DTACON IS NULL ';

    qryAux.Sql.Text := strSQL;

     If (blnConciliar) Then
    Begin
      qryAux.ParamByName('DTACON').AsDateTime := dtaDtaCon;
      qryAux.ParamByName('HORCON').AsString   := FormatDateTime('hh:nn:ss', LHoraConciliacao);
      qryAux.ParamByName('OPECON').AsString   := strLoginUsuarioLogado;
    End;

    qryAux.ParamByName('PAGCON').AsInteger := intPagCon;

    if not fEmptyStr(strCodCta) Then
      qryAux.ParamByName('CODCTA').AsString := strCodCta;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      qryAux.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      qryAux.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(edtCodPor.Text) Then
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryAux);

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryAux);

    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      pgbProgresso.Visible := True;

      pgbProgresso.Position := 0;
      pgbProgresso.Max := qryAux.RecordCount;

      LValorInicialAutoIncrem := Copy(fRetAutoIncrem('LOGCBA', VS_strCodEmp, qryAux.RecordCount), 4, 14).ToInt64;

      while not qryAux.Eof do
      begin
        untLogCba.GravaLogCba(qryAux.FieldByName('AUTOINCREM').AsString,
                              IIF(blnConciliar, 'CONCILIOU LANÇAMENTO', 'DESCONCILIOU LANÇAMENTO'),
                              Self.Name,
                              EmptyStr,
                              Nil,
                              EmptyStr,
                              fFormataAutInc(LValorInicialAutoIncrem, VS_strCodEmp));

        Inc(LValorInicialAutoIncrem);

        qryAux.Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    end;

    if not blnConciliar then
      DesvinculaExtratoEletronicoVarios(LAutoIncremLancamentos);
  Finally
    qryAux.Close;
    FreeAndNil(qryAux);

    pgbProgresso.Visible := False;
  End;
End;

procedure TfrmCadConciliacaoBancaria.pEfetuarUpdate(strCodCta, strAutInc: String;
  blnConciliar: Boolean; AItemUpdate: TRegistrosConciliarBancaria = Nil);
  Var
    strSQL: String;
    qryAux: TUniQuery;

    LItens: TStringList;

    LItemAtual: String;

    LValorInicialAutoIncrem: Integer;
    LAutoIncremLancamentos: String;
begin
  if (not blnConciliar) and (AItemUpdate = nil) then
    LAutoIncremLancamentos := RetornaAutoIncremLancamentosSintetico(strCodCta);

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  MOVBAN ';
  strSQL := strSQL + 'SET ';

  If (blnConciliar) Then
  Begin
    strSQL := strSQL + '  CTB_DTACON = :DTACON, ';
    strSQL := strSQL + '  CTB_HORCON = :HORCON, ';
    strSQL := strSQL + '  CTB_OPECON = :OPECON  ';
  End
  Else
  Begin
    strSQL := strSQL + '  CTB_DTACON = NULL, ';
    strSQL := strSQL + '  CTB_HORCON = NULL, ';
    strSQL := strSQL + '  CTB_OPECON = NULL, ';
    strSQL := strSQL + '  CTB_OCOIGN = NULL, ';
    strSQL := strSQL + '  CTB_IGNORA = NULL  ';

  End;

  strSQL := strSQL + 'WHERE ';

  If AItemUpdate = Nil Then
  Begin
    strSQL := strSQL + '  CTB_CODCTA = :CODCTA ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If rdgOpcao.ItemIndex = 0 Then
      strSQL := strSQL + ' AND CTB_DTACON IS NOT NULL '
    Else If rdgOpcao.ItemIndex = 1 Then
      strSQL := strSQL + ' AND CTB_DTACON IS NULL ';

    If Not fEmptyStr(strAutInc) Then
      strSQL := strSQL + ' AND AUTOINCREM = :AUTINC ';
  End
  Else
    strSQL := strSQL + ' AUTOINCREM IN (' +
                       LeftStr(AItemUpdate.AutoIncremsUpdate,
                               AItemUpdate.AutoIncremsUpdate.Length - 1) +
                       ') ';

  qryAux := fCriaQuery(Self);

  qryAux.SQL.Clear;
  qryAux.SQL.Add(strSQL);

  If (blnConciliar) Then
  Begin
    qryAux.ParamByName('DTACON').AsDateTime := dtaDtaCon;
    qryAux.ParamByName('HORCON').AsString   := FormatDateTime('hh:nn:ss', fTime());
    qryAux.ParamByName('OPECON').AsString   := strLoginUsuarioLogado;
  End;

  If AItemUpdate = Nil Then
  Begin
    qryAux.ParamByName('CODCTA').AsString := strCodCta;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      qryAux.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      qryAux.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(edtCodPor.Text) Then
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryAux);

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryAux);

    If Not fEmptyStr(strAutInc) Then
      qryAux.ParamByName('AUTINC').AsString := strAutInc;
  End;

  qryAux.ExecSQL;

  If AItemUpdate = Nil Then
  Begin
    //GRAVANDO LOG
    qryAux.Close;
    qryAux.Sql.Clear;
    strSql := 'SELECT * FROM MOVBAN ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTB_CODCTA = :CODCTA ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + ' AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'CTB_CODPOR', 'CODPOR');

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'CTB_CODEMP', 'CODEMP');

    If blnConciliar Then
      strSQL := strSQL + ' AND CTB_DTACON IS NOT NULL '
    Else
      strSQL := strSQL + ' AND CTB_DTACON IS NULL ';

    If Not fEmptyStr(strAutInc) Then
      strSQL := strSQL + ' AND AUTOINCREM = :AUTINC ';

    qryAux.Sql.Text := strSQL;

    qryAux.ParamByName('CODCTA').AsString := strCodCta;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      qryAux.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      qryAux.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(edtCodPor.Text) Then
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryAux);

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryAux);

    If Not fEmptyStr(strAutInc) Then
      qryAux.ParamByName('AUTINC').AsString := strAutInc;

    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      while not qryAux.Eof do
      begin
        untLogCba.GravaLogCba(qryAux.FieldByName('AUTOINCREM').AsString,
                              IIF(blnConciliar, 'CONCILIOU LANÇAMENTO', 'DESCONCILIOU LANÇAMENTO'),
                              Self.Name);

        qryAux.Next;
      end;
    end;

    if not blnConciliar then
      DesvinculaExtratoEletronicoVarios(LAutoIncremLancamentos);
  End
  Else
  Begin
    LItens := TStringList.Create;

    Try
      LItens.Delimiter := ',';
      LItens.StrictDelimiter := True;

      LItens.DelimitedText := AItemUpdate.AutoIncremsUpdate;

      pgbProgresso.Position := 0;
      pgbProgresso.Max := LItens.Count;

      LValorInicialAutoIncrem := Copy(fRetAutoIncrem('LOGCBA', VS_strCodEmp, LItens.Count - 1), 4, 14).ToInt64;

      For LItemAtual In LItens Do
      Begin
        If Not fRetSomenteNumeros(LItemAtual).IsEmpty Then
        Begin
          untLogCba.GravaLogCba(fRetSomenteNumeros(LItemAtual),
                                IIF(blnConciliar, 'CONCILIOU LANÇAMENTO', 'DESCONCILIOU LANÇAMENTO'),
                                Self.Name,
                                EmptyStr,
                                Nil,
                                EmptyStr,
                                fFormataAutInc(LValorInicialAutoIncrem, VS_strCodEmp));

          Inc(LValorInicialAutoIncrem);
        End;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;
    Finally
      FreeAndNil(LItens);
    End;

    if not blnConciliar then
      DesvinculaExtratoEletronicoVarios(LeftStr(AItemUpdate.AutoIncremsUpdate,
                                                AItemUpdate.AutoIncremsUpdate.Length - 1));
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCadConciliacaoBancaria.dtsTmpMovBanDataChange(Sender: TObject;
  Field: TField);
begin
  If Not Assigned(cdsTmpMovBan) Then
    Exit;

  If Not cdsTmpMovBan.Active Then
    Exit;

  If cmbAnaSin.ItemIndex = 0 Then
  Begin
    If cdsTmpMovBan.FieldByName('CONCILIADO').AsString = 'X' Then
      If (( cdsTmpMovBan.FindField('DTACON') <> Nil ) And
          ( cdsTmpMovBan.FindField('HORCON') <> Nil ) And
          ( cdsTmpMovBan.FindField('OPECON') <> Nil )) Then
        pnlInfo.Caption := 'Conciliação - Data/Hora: ' + FormatDateTime('dd/mm/yyyy', cdsTmpMovBan.FieldByName('DTACON').AsDateTime) + ' ' +
                           FormatDateTime('hh:mm:ss', cdsTmpMovBan.FieldByName('HORCON').AsDateTime) + ' Operador: ' +
                           cdsTmpMovBan.FieldByName('OPECON').AsString + ' - ' + fRetNomeOperador(cdsTmpMovBan.FieldByName('OPECON').AsString)
    Else
      pnlInfo.Caption := '';
  End
  Else
    pnlInfo.Caption := '';
end;

procedure TfrmCadConciliacaoBancaria.TratarExibicaoColunas;
{**********************************************************************************************************}
{* TRATA A EXIBIÇÃO OU NÃO DE COLUNAS DO CXGRID QUANDO POR ALGUM MOTIVO UMA COLUNA QUE NÃO DEVERÁ         *}
{* SER VISÍVEL ESTIVER SENDO RECUPERADA.                                                                  *}
{* VERIFICAR SE NÃO ENCONTRAR O CAMPO NA QUERY OU A COLUNA VIER SEM CAPTION, OCULTAR SUA VISUALIZAÇÃO     *}
{**********************************************************************************************KM - 186128*}
Var i : Integer;
begin
  for i := 0 to cxgConciliacaoBancariaView.ColumnCount - 1 Do
  begin
    if (cxgConciliacaoBancariaView.DataController.DataSet.FindField(TcxGridDBColumn(cxgConciliacaoBancariaView.Columns[i]).DataBinding.FieldName) = Nil) or
       (cxgConciliacaoBancariaView.Columns[i].Caption = '') then
    begin
      if cxgConciliacaoBancariaView.Columns[i].Visible then
        cxgConciliacaoBancariaView.Columns[i].Visible := False;
    end;
  end;
end;

procedure TfrmCadConciliacaoBancaria.pAlterarDataLanctoDepCheques(AAutoIncremList: String;
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
      Raise Exception.Create('[TfrmCadConciliacaoBancaria.pAlterarDataLanctoDepCheques] ' +E.Message);
    End;
  End;
end;

procedure TfrmCadConciliacaoBancaria.pAlterarDataLanctoCartoes(AAutoIncremList: String;
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
      Raise Exception.Create('[TfrmCadConciliacaoBancaria.pAlterarDataLanctoCartoes] ' +E.Message);
    End;
  End;
end;

Function TfrmCadConciliacaoBancaria.fRetornaDadosMensagemTrava(AAutoIncrem: String): String;
Var
  qryDadosEXR : TUniQuery;
  qryDadosExtban : TUniQuery;
  msg : String;
begin
  qryDadosEXR    := fCriaQuery(Self);
  qryDadosExtban := fCriaQuery(Self);
  msg := '';

  Try
    qryDadosEXR.Close;
    qryDadosEXR.SQL.Clear;
    qryDadosEXR.SQL.Add('SELECT EXR_EXTINC FROM BANEXR WHERE BANEXR.EXR_BANINC = :AUTOINC LIMIT 1 ');

    qryDadosEXR.ParamByName('AUTOINC').AsString := AAutoIncrem;

    qryDadosEXR.Open;

    If (Not qryDadosEXR.IsEmpty) Then
    Begin
      qryDadosEXR.First;

      qryDadosExtban.Close;
      qryDadosExtban.SQL.Clear;

      qryDadosExtban.SQL.Add(' SELECT ');
      qryDadosExtban.SQL.Add('   EXT_CODPOR, EXT_DTALAN, EXT_VALLAN FROM BANEXR EXR ');
      qryDadosExtban.SQL.Add(' INNER JOIN EXTBAN EXB ON EXB.AUTOINCREM = EXR.EXR_EXTINC ');
      qryDadosExtban.SQL.Add(' WHERE EXB.AUTOINCREM = :AUTOINC ');
      qryDadosExtban.ParamByName('AUTOINC').AsString := qryDadosEXR.FieldByName('EXR_EXTINC').AsString;
      qryDadosExtban.Open;

      If (Not qryDadosEXR.IsEmpty) Then
      Begin
         msg := #10#13 +
                'EXTRATO: PORTADOR: ' + qryDadosExtban.FieldByName('EXT_CODPOR').AsString +#10#13+
                ' DATA LANÇAMENTO: ' + FormatDateTime('dd/mm/yyyy',qryDadosExtban.FieldByName('EXT_DTALAN').AsDateTime) +#10#13+
                ' VALOR: ' + FormatFloat('#,##0.00',qryDadosExtban.FieldByName('EXT_VALLAN').AsFloat);
      End;

    End;

    Result := msg;

    If Assigned(qryDadosExtban) Then
       FreeAndNil(qryDadosExtban);

    If Assigned(qryDadosEXR) Then
       FreeAndNil(qryDadosEXR);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmCadConciliacaoBancaria.fRetornaDadosMensagemTrava] ' +E.Message);
    End;
  End;
end;

end.
