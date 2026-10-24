unit untEditorMetas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxVGrid,
  cxInplaceContainer, System.Generics.Collections, untTypesSistema, untConsultasRel,
  untPaiCad, Vcl.ComCtrls, cxClasses, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  UniClientDataSet, Uni, untEditorMetasRepository, cxTextEdit, EditFocus,
  cxContainer, dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxCurrencyEdit, Vcl.Mask, MaskEditFocus;

type
  TfrmEditorMetas = class(TfrmPaiCad)
    cxStyleRepository: TcxStyleRepository;
    cxHeaderNegrito: TcxStyle;
    cxGeralContent: TcxStyle;
    cxgMetasDBTableViewCitel: TcxGridDBTableViewCitel;
    cxgMetasLevel1: TcxGridLevel;
    cxgMetas: TcxGridCitel;
    dtsMetas: TDataSource;
    pnlFundoAbaGeral: TPanel;
    pnlBotoesAbaGeral: TPanel;
    btnCopiarMetas: TBitBtnLocked;
    pnlFundoAbaDigitacaoMetas: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodMet: TEditFocus;
    edtDesMet: TEditFocus;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDtaIni: TcxDateEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtDtaFin: TcxDateEdit;
    pnlColunasFiltrosEMetas: TPanel;
    pnlFiltros: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtNomDig: TEditFocus;
    edtCodDig: TEditFocus;
    edtNomRep: TEditFocus;
    edtCodRep: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodFor: TEditFocus;
    edtDesAtiFor: TEditFocus;
    edtAtiFor: TEditFocus;
    edtDesMar: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesLinGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    edtDesDepIte: TEditFocus;
    edtDepIte: TEditFocus;
    edtLinGru: TMaskEditFocus;
    pnlMetas: TPanel;
    lblPositivacaoClientes: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtPosCli: TcxCurrencyEdit;
    edtIteNot: TcxCurrencyEdit;
    edtValVen: TcxCurrencyEdit;
    edtVolLit: TcxCurrencyEdit;
    edtVolUni: TcxCurrencyEdit;
    edtMarLuc: TcxCurrencyEdit;
    btnHeranca: TBitBtnLocked;
    btnGerarMetas: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGerarMetasClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure cxgMetasDBTableViewCitelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgMetasDBTableViewCitelEditKeyDown(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
  private
    Const
      EXCLUDENTES : Array[1..3] Of String = ('edtCodVen', 'edtCodDig', 'edtCodRep');
    Type
      TFiltro = class
        NomeDoFiltro : String;
        NomeDaConsulta : TPesquisas;
        Selecao : TConsultasArray;
        TamanhoNoCds : Integer;
        CaptionNoCds : String;
        Tabela : String;
        CampoSQLExibicao : String;
        CampoSQLChave : String;
        CampoSQLCargaDados : String;
        InstrucaoJoinCargaDados : String;
        Cabecalho : Boolean;
        EditDescritivo : TCustomEdit;
      End;
      TDefinicaoMeta = class
        NomeDaMeta : String;
        CampoSQLCargaDados : String;
      End;
  private
    { Private declarations }
    FDicFiltros : TDictionary<String, TFiltro>;
    FDicDefMetas : TDictionary<String, TDefinicaoMeta>;
    FConsultasRel : TConsultasRel;
    FQryMetas : TUniQuery;
    FUsaCodigoAutomatico : Boolean;
    FEditorMetasRepository : TEditorMetasRepository;
    procedure ConstruirFiltros;
    procedure ConstruirDefinicaoDeMetas;
    procedure DestruirFiltros;
    procedure DestruirDefinicaoDeMetas;
    function TemMultiSelecaoNoFiltro(const AName : String) : Boolean;
    function TemValorNoFiltro(const AName: String): Boolean;
    function TemConsultaNoFiltro(const AName: String): Boolean;
    function GetConsultaDoFiltro(const AName: String): TPesquisas;
    procedure SetarSelecaoFiltro(const AName : String; const ASelecao: TConsultasArray);
    function GetSelecaoFiltro(const AName : String): TConsultasArray;
    procedure CriarColunasDosFiltrosNoGrid;
    procedure ValidarDigitacaoDosExcludentes(const AFilterName : String);
    function FiltroExcludente(const AName : String) : Boolean;
    procedure CriarColunasDasMetasNoGrid;
    procedure CriarColunasDoGrid;
    procedure CarregarDadosDasMetas(const ASQL : String);
    function GetSQLGeracaoDasMetas : String;
    function GetSQLMetasGeradas(const ACodigoMeta : String): String;
    function DeclaraCampoVirtualSQL(const AValue : Double; ADecimalPlaces : Integer): String;
    procedure HabilitarControlesParaEdicao(const AHabilita : Boolean);
    function ValidouDadosObrigatoriosParaGravacaoDaMeta(const AVerificarRegistrosDeMetas : Boolean): Boolean;
    function ValidouDadosParaGeracaoDasMetas: Boolean;
    function FiltroParticipaDaGeracaoDasMetas(const AName: String): Boolean;
    function DataValida(const AVariant : Variant): Boolean;
    procedure FocuInicial;
    function PreencheuFiltroPrincipal: Boolean;
    function PreeencheuAoMenosUmaMeta: Boolean;
    procedure IniciarEditor;
    procedure GravarEmpresas(const AAutoincrem : String);
    procedure ExcluirEmpresas(const AAutoincrem : String);
    procedure CarregarEmpresas(const AAutoincrem : String);
    procedure CarregarCabecalhoMetas(const AAutoincrem: String; const ACopiandoMetas : Boolean);
    procedure FormatarCamposDoTipoFloat(const ADataSet : TDataSet);
    procedure ExcluirMetas(const ACodigoMeta : String);
    procedure GravarMetas(const ACodigoMeta : String);
    function ValorStringDoCampoSeExiste(const AFieldName : String; const ADataSet : TDataSet): String;
    function ValorIntegerDoCampoSeExiste(const AFieldName : String; const ADataSet : TDataSet): Integer;
    function ValorDecimalDoCampoSeExiste(const AFieldName : String; const ADataSet : TDataSet): Double;
    procedure CarregarDadosMeta(const ACodigoMeta : String);
    procedure AtualizarFiltrosNoEditor(const ACodigoMeta : String);
    procedure AtualizarFiltro(const ACodigoMeta : String; const ANomeDoCampo: String; const ANomeDoFiltro : String; const AEditCodigo : TCustomEdit; const AEditDescricao : TCustomEdit);
    procedure pAtualizaStatusCopiarMetas;
    procedure AtribuirValoresPreGravacao;
    function GetNomeDaMetaPorCampoSQLCargaDados(const ACampoSQLCargaDados : String): String;
    procedure EfetivarHeranca(const AOperador : String; const AFieldNameOperador : String);
    procedure CarregarDadosEmTela(const AAutoIncrem : String; const ACodigoMeta : String);
    procedure FecharQryMetas;
    function GetEditDescritivoDoFiltro(const AName: String): TCustomEdit;
    procedure OnKeyPressConsultas(Sender: TObject; var Key : Char);
    function ValidarMultiSelecao(const ACodigoFiltro : TCustomEdit; const AMaxLength : Integer) : Boolean; overload;
    function ValidarMultiSelecao(Sender: TWinControl) : Boolean; overload;
    function GetLabel(AControle : TCustomEdit; AWinControl : TWinControl) : TLabel;
    procedure SetarTamanhoDosEditsDinamicos;
    procedure SairDoGridNoUltimoRegistro(var Key: Word);
    procedure LimparControles;
    function fHabilitaHerancaDeMetas: Boolean;
    function fTratarDadosDaSelecao(const ASelecao : TConsultasArray) : TConsultasArray;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses untHelperCxVerticalGrid, untFuncoesSimples, untFuncoesConsulta,
  untConsultas, System.StrUtils, untDigOperador, untFuncoes;

{$R *.dfm}

procedure TfrmEditorMetas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If (Not Self.blnAlterou) Then
    Exit;
  HabilitarControlesParaEdicao(True);
  FocuInicial;
end;

procedure TfrmEditorMetas.CarregarDadosEmTela(const AAutoIncrem : String; const ACodigoMeta : String);
begin
  CarregarEmpresas(AAutoIncrem);
  CarregarCabecalhoMetas(AAutoIncrem, False);
  AtualizarFiltrosNoEditor(ACodigoMeta);
  CarregarDadosMeta(ACodigoMeta);
end;

procedure TfrmEditorMetas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  HabilitarControlesParaEdicao(False);
  IniciarEditor;
  If (qryTabela.FieldByName('AUTOINCREM').AsString.IsEmpty) Then
    Exit;
  CarregarDadosEmTela(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('MET_CODIGO').AsString);
end;

procedure TfrmEditorMetas.btnCopiarMetasClick(Sender: TObject);
  Var
    LKey : Char;
    LArrSel : TConsultasArray;
    LQryCopiarMetas : TUniQuery;
begin
  inherited;
  LKey := '/';
  LQryCopiarMetas := fCriaQuery(Self);
  Try
    LQryCopiarMetas.SQL.Text := 'SELECT * FROM EDIMET WHERE FALSE';
    LQryCopiarMetas.Open;

    If Not fPesqEditorMetas(Self,
                            LQryCopiarMetas,
                            LKey,
                            LArrSel,
                            True) Then
      Exit;

    If (Not LQryCopiarMetas.Active) Then
      Exit;

    If (LQryCopiarMetas.IsEmpty) Then
      Exit;

    AtualizarFiltrosNoEditor(LQryCopiarMetas.FieldByName('MET_CODIGO').AsString);
    CarregarCabecalhoMetas(LQryCopiarMetas.FieldByName('AUTOINCREM').AsString, True);
    pSetFocus(btnGerarMetas);
  Finally
    FreeAndNil(LQryCopiarMetas);
  End;
end;

procedure TfrmEditorMetas.btnExcluirClick(Sender: TObject);
  Var
    LAutoIncDel : String;
    LCodigoMetaDel : String;
begin
  Try
    LAutoIncDel := qryTabela.FieldByName('AUTOINCREM').AsString;
    LCodigoMetaDel := qryTabela.FieldByName('MET_CODIGO').AsString;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    inherited;

    If blnExcluiu Then
      ExcluirEmpresas(LAutoIncDel);

    If blnExcluiu Then
      ExcluirMetas(LCodigoMetaDel);

    If blnExcluiu Then
      fCommit
    Else
      fRollBack;

    IniciarEditor;
    If (qryTabela.FieldByName('AUTOINCREM').AsString.IsEmpty) Then
      Exit;

    CarregarDadosEmTela(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('MET_CODIGO').AsString);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmEditorMetas.btnExcluirClick]');
    End;
  End;
end;

procedure TfrmEditorMetas.btnGerarMetasClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;
  If Not ValidouDadosObrigatoriosParaGravacaoDaMeta(False) Then
    Exit;
  If Not ValidouDadosParaGeracaoDasMetas Then
    Exit;
  If (FQryMetas.Active) And (Not FQryMetas.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Já existem registros de metas gerados, deseja gerar novamente descartando os dados anteriores?', ['&Sim', '&Não'], 2) = 2) Then
      Exit;
  End;
  CriarColunasDoGrid;
  CarregarDadosDasMetas(GetSQLGeracaoDasMetas);
  btnHeranca.Enabled := fHabilitaHerancaDeMetas;
end;

procedure TfrmEditorMetas.ExcluirEmpresas(const AAutoincrem: String);
begin
  FEditorMetasRepository.ExcluirEmpresas(AAutoincrem);
end;

procedure TfrmEditorMetas.ExcluirMetas(const ACodigoMeta: String);
begin
  FEditorMetasRepository.ExcluirMetas(ACodigoMeta);
end;

procedure TfrmEditorMetas.ConstruirDefinicaoDeMetas;
  Var
    LDefinicaoMeta : TDefinicaoMeta;
begin
  DestruirDefinicaoDeMetas;

  LDefinicaoMeta := TDefinicaoMeta.Create;
  LDefinicaoMeta.NomeDaMeta := 'edtPosCli';
  LDefinicaoMeta.CampoSQLCargaDados := 'REG_POSCLI';
  FDicDefMetas.Add(LDefinicaoMeta.NomeDaMeta, LDefinicaoMeta);

  LDefinicaoMeta := TDefinicaoMeta.Create;
  LDefinicaoMeta.NomeDaMeta := 'edtIteNot';
  LDefinicaoMeta.CampoSQLCargaDados := 'REG_ITENOT';
  FDicDefMetas.Add(LDefinicaoMeta.NomeDaMeta, LDefinicaoMeta);

  LDefinicaoMeta := TDefinicaoMeta.Create;
  LDefinicaoMeta.NomeDaMeta := 'edtValVen';
  LDefinicaoMeta.CampoSQLCargaDados := 'REG_VALVEN';
  FDicDefMetas.Add(LDefinicaoMeta.NomeDaMeta, LDefinicaoMeta);

  LDefinicaoMeta := TDefinicaoMeta.Create;
  LDefinicaoMeta.NomeDaMeta := 'edtVolLit';
  LDefinicaoMeta.CampoSQLCargaDados := 'REG_VOLLIT';
  FDicDefMetas.Add(LDefinicaoMeta.NomeDaMeta, LDefinicaoMeta);

  LDefinicaoMeta := TDefinicaoMeta.Create;
  LDefinicaoMeta.NomeDaMeta := 'edtVolUni';
  LDefinicaoMeta.CampoSQLCargaDados := 'REG_VOLUNI';
  FDicDefMetas.Add(LDefinicaoMeta.NomeDaMeta, LDefinicaoMeta);

  LDefinicaoMeta := TDefinicaoMeta.Create;
  LDefinicaoMeta.NomeDaMeta := 'edtMarLuc';
  LDefinicaoMeta.CampoSQLCargaDados := 'REG_MARLUC';
  FDicDefMetas.Add(LDefinicaoMeta.NomeDaMeta, LDefinicaoMeta);
end;

procedure TfrmEditorMetas.ConstruirFiltros;
  Var
    LFiltro : TFiltro;
begin
  DestruirFiltros;

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtCodVen';
  LFiltro.NomeDaConsulta := pesOperador;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 33;
  LFiltro.CaptionNoCds := 'Vendedor';
  LFiltro.Tabela := 'CADOPE';
  LFiltro.CampoSQLExibicao := 'CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS edtCodVen';
  LFiltro.CampoSQLChave := 'OPE_CODOPE';
  LFiltro.CampoSQLCargaDados := 'REG_CODVEN';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADOPE ON CADOPE.OPE_CODOPE = REG_CODVEN';
  LFiltro.EditDescritivo := edtNomVen;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtCodDig';
  LFiltro.NomeDaConsulta := pesOperador;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 33;
  LFiltro.CaptionNoCds := 'Digitador';
  LFiltro.Tabela := 'CADOPE';
  LFiltro.CampoSQLExibicao := 'CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS edtCodDig';
  LFiltro.CampoSQLChave := 'OPE_CODOPE';
  LFiltro.CampoSQLCargaDados := 'REG_CODDIG';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADOPE ON CADOPE.OPE_CODOPE = REG_CODDIG';
  LFiltro.EditDescritivo := edtNomDig;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtCodRep';
  LFiltro.NomeDaConsulta := pesOperador;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 33;
  LFiltro.CaptionNoCds := 'Representante';
  LFiltro.Tabela := 'CADOPE';
  LFiltro.CampoSQLExibicao := 'CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) AS edtCodRep';
  LFiltro.CampoSQLChave := 'OPE_CODOPE';
  LFiltro.CampoSQLCargaDados := 'REG_CODREP';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADOPE ON CADOPE.OPE_CODOPE = REG_CODREP';
  LFiltro.EditDescritivo := edtNomRep;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtCodFor';
  LFiltro.NomeDaConsulta := pesFornecedor;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 68;
  LFiltro.CaptionNoCds := 'Fornecedor';
  LFiltro.Tabela := 'CADFOR';
  LFiltro.CampoSQLExibicao := 'CONCAT(FOR_CODFOR, "-", FOR_NOMFOR) AS edtCodFor';
  LFiltro.CampoSQLChave := 'FOR_CODFOR';
  LFiltro.CampoSQLCargaDados := 'REG_CODFOR';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADFOR ON CADFOR.FOR_CODFOR = REG_CODFOR';
  LFiltro.EditDescritivo := edtNomFor;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtAtiFor';
  LFiltro.NomeDaConsulta := pesAtividade;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 53;
  LFiltro.CaptionNoCds := 'Atividade';
  LFiltro.Tabela := 'CADATI';
  LFiltro.CampoSQLExibicao := 'CONCAT(ATI_CODATI, "-", ATI_DESATI) AS edtAtiFor';
  LFiltro.CampoSQLChave := 'ATI_CODATI';
  LFiltro.CampoSQLCargaDados := 'REG_CODATI';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADATI ON CADATI.ATI_CODATI = REG_CODATI';
  LFiltro.EditDescritivo := edtDesAtiFor;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtCodMar';
  LFiltro.NomeDaConsulta := pesMarca;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 36;
  LFiltro.CaptionNoCds := 'Marca';
  LFiltro.Tabela := 'CADMAR';
  LFiltro.CampoSQLExibicao := 'CONCAT(MAR_CODMAR, "-", MAR_DESMAR) AS edtCodMar';
  LFiltro.CampoSQLChave := 'MAR_CODMAR';
  LFiltro.CampoSQLCargaDados := 'REG_CODMAR';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = REG_CODMAR';
  LFiltro.EditDescritivo := edtDesMar;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtLinGru';
  LFiltro.NomeDaConsulta := pesLinhaGrupo;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 56;
  LFiltro.CaptionNoCds := 'Linha/Grupo';
  LFiltro.Tabela := 'CADGRU';
  LFiltro.CampoSQLExibicao := 'CONCAT(GRU_CODGRU, "-", GRU_DESGRU) AS edtLinGru';
  LFiltro.CampoSQLChave := 'GRU_CODGRU';
  LFiltro.CampoSQLCargaDados := 'REG_CODGRU';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADGRU ON CADGRU.GRU_CODGRU = REG_CODGRU';
  LFiltro.EditDescritivo := edtDesLinGru;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtCodIte';
  LFiltro.NomeDaConsulta := pesProdutoSimples;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 65;
  LFiltro.CaptionNoCds := 'Produto';
  LFiltro.Tabela := 'CADITE';
  LFiltro.CampoSQLExibicao := 'CONCAT(ITE_CODITE, "-", ITE_DESITE) AS edtCodIte';
  LFiltro.CampoSQLChave := 'ITE_CODITE';
  LFiltro.CampoSQLCargaDados := 'REG_CODITE';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADITE ON CADITE.ITE_CODITE = REG_CODITE';
  LFiltro.EditDescritivo := edtDesIte;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtDepIte';
  LFiltro.NomeDaConsulta := pesDepartamento;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 43;
  LFiltro.CaptionNoCds := 'Departamento do Produto';
  LFiltro.Tabela := 'CADDEP';
  LFiltro.CampoSQLExibicao := 'CONCAT(DEP_CODIGO, "-", DEP_DESCRI) AS edtDepIte';
  LFiltro.CampoSQLChave := 'DEP_CODIGO';
  LFiltro.CampoSQLCargaDados := 'REG_CODDEP';
  LFiltro.InstrucaoJoinCargaDados := 'LEFT JOIN CADDEP ON CADDEP.DEP_CODIGO = REG_CODDEP';
  LFiltro.EditDescritivo := edtDesDepIte;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);

  LFiltro := TFiltro.Create;
  LFiltro.NomeDoFiltro := 'edtCodEmp';
  LFiltro.NomeDaConsulta := pesEmpresa;
  LFiltro.Selecao := [];
  LFiltro.TamanhoNoCds := 43;
  LFiltro.CaptionNoCds := 'Empresa';
  LFiltro.Tabela := 'CADEMP';
  LFiltro.Cabecalho := True;
  LFiltro.EditDescritivo := edtNomEmp;
  FDicFiltros.Add(LFiltro.NomeDoFiltro, LFiltro);
end;

procedure TfrmEditorMetas.CriarColunasDoGrid;
begin
  cxgMetasDBTableViewCitel.ClearItems;
  CriarColunasDosFiltrosNoGrid;
  CriarColunasDasMetasNoGrid;
end;

procedure TfrmEditorMetas.CriarColunasDosFiltrosNoGrid;
  Var
    LColumn : TcxGridDbColumn;
    LFiltro : TFiltro;
begin
  cxgMetasDBTableViewCitel.BeginUpdate;
  Try
    For LFiltro In FDicFiltros.Values Do
    Begin
      If Not TemValorNoFiltro(LFiltro.NomeDoFiltro) Then
        Continue;
      If Not FiltroParticipaDaGeracaoDasMetas(LFiltro.NomeDoFiltro) Then
        Continue;
      LColumn := cxgMetasDBTableViewCitel.CreateColumn;
      LColumn.DataBinding.FieldName := LFiltro.NomeDoFiltro;
      LColumn.Caption := LFiltro.CaptionNoCds;
      LColumn.Editing := False;
      LColumn.Options.CellMerging := False;
      LColumn.Options.Focusing := False;
      If FiltroExcludente(LFiltro.NomeDoFiltro) Then
        LColumn.Index := 0;
    End;
  Finally
    cxgMetasDBTableViewCitel.EndUpdate;
  End;
end;

procedure TfrmEditorMetas.CriarColunasDasMetasNoGrid;
  Var
    LContador : Integer;
    LColumn : TcxGridDbColumn;
begin
  cxgMetasDBTableViewCitel.BeginUpdate;
  Try
    For LContador := 0 To Pred(pnlMetas.ControlCount) Do
    Begin
      If (Not (pnlMetas.Controls[LContador] Is TLabel)) Then
        Continue;

      If (TLabel(pnlMetas.Controls[LContador]).FocusControl = Nil) Then
        Continue;

      If (Not (TLabel(pnlMetas.Controls[LContador]).FocusControl Is TcxCurrencyEdit)) Then
        Continue;

      If fEmptyStr(TcxCurrencyEdit(TLabel(pnlMetas.Controls[LContador]).FocusControl).Text) Then
        Continue;

      LColumn := cxgMetasDBTableViewCitel.CreateColumn;
      LColumn.DataBinding.FieldName := TcxCurrencyEdit(TLabel(pnlMetas.Controls[LContador]).FocusControl).Name;
      LColumn.Caption := TLabel(pnlMetas.Controls[LContador]).Caption;
      LColumn.Editing := True;
    End;
  Finally
    cxgMetasDBTableViewCitel.EndUpdate;
  End;
end;

procedure TfrmEditorMetas.cxgMetasDBTableViewCitelEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  SairDoGridNoUltimoRegistro(Key);
end;

procedure TfrmEditorMetas.cxgMetasDBTableViewCitelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  SairDoGridNoUltimoRegistro(Key);
end;

procedure TfrmEditorMetas.SairDoGridNoUltimoRegistro(var Key: Word);
begin
  If Key <> VK_RETURN Then
    Exit;
  If cxgMetasDBTableViewCitel.Controller.FocusedRowIndex = cxgMetasDBTableViewCitel.ViewData.RowCount -1 Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmEditorMetas.OnKeyPressConsultas(Sender: TObject; var Key : Char);
  Var
    LValPar : String;
    LDesEdt : String;
    LConsultasArray : TConsultasArray;
    LEditDescritivo : TCustomEdit;
begin
  If Not fEntraCons(Key) Then
    Exit;

  LEditDescritivo := GetEditDescritivoDoFiltro(TCustomEdit(Sender).Name);
  If (LEditDescritivo = Nil) Then
    Raise Exception.Create(Format('Campo descritivo não foi encontrado para o elemento %s', [TCustomEdit(Sender).Name]));

  LConsultasArray := GetSelecaoFiltro(TCustomEdit(Sender).Name);

  If Not FConsultasRel.fPesqisaTabela(ArrDescPesquisa[GetConsultaDoFiltro(TCustomEdit(Sender).Name)], LValPar, LDesEdt, Self, Key, False, LConsultasArray) Then
    Exit;

  If (Length(LConsultasArray) > 1) Then
  Begin
    If (Sender Is TMaskEditFocus) Then
      TMaskEditFocus(Sender).Text := StringOfChar('0', Length(LConsultasArray[0].strCodigo))
    Else
      TCustomEdit(Sender).Text := StringOfChar('0', Length(LConsultasArray[0].strCodigo));
    LEditDescritivo.Text := '+1';
  End
  Else
  Begin
    If (Sender Is TMaskEditFocus) Then
      TMaskEditFocus(Sender).Text := LConsultasArray[0].strCodigo
    Else
      TCustomEdit(Sender).Text := LConsultasArray[0].strCodigo;
    LEditDescritivo.Text := TConsultasRel.fRetDescricao(LConsultasArray[0].strCodigo, GetConsultaDoFiltro(TCustomEdit(Sender).Name), True);
  End;

  SetarSelecaoFiltro(TCustomEdit(Sender).Name, LConsultasArray);
  ValidarDigitacaoDosExcludentes(TCustomEdit(Sender).Name);

  Key := #0;

  SelectNext(ActiveControl, True, True);
end;

procedure TfrmEditorMetas.DestruirDefinicaoDeMetas;
  Var
    LDefinicaoMeta : TDefinicaoMeta;
begin
  For LDefinicaoMeta In FDicDefMetas.Values Do
    LDefinicaoMeta.Destroy;
  FDicDefMetas.Clear;
end;

procedure TfrmEditorMetas.DestruirFiltros;
  Var
    LFiltro : TFiltro;
begin
  For LFiltro In FDicFiltros.Values Do
    LFiltro.Destroy;
  FDicFiltros.Clear;
end;

procedure TfrmEditorMetas.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  OnKeyPressConsultas(Sender, Key);
end;

procedure TfrmEditorMetas.FocuInicial;
begin
  If (Not FUsaCodigoAutomatico) Then
    pSetFocus(edtCodMet)
  Else
    pSetFocus(edtDesMet);
end;

procedure TfrmEditorMetas.SetarTamanhoDosEditsDinamicos;
begin
  edtCodMar.MaxLength := fTamCodMar;
  edtCodMar.TamCampo := edtCodMar.MaxLength;
  edtCodMar.CompZeros := True;
  edtCodIte.MaxLength := fTamCodIte;
  edtCodIte.TamCampo := edtCodIte.MaxLength;
  edtCodIte.CompZeros := True;
end;

procedure TfrmEditorMetas.FormCreate(Sender: TObject);
begin
  inherited;
  FDicFiltros := TDictionary<String, TFiltro>.Create;
  FDicDefMetas := TDictionary<String, TDefinicaoMeta>.Create;
  FConsultasRel := TConsultasRel.Create(Self);
  FQryMetas := fCriaQuery(Self);
  FQryMetas.CachedUpdates := True;
  FQryMetas.Options.SetFieldsReadOnly := False;
  strNomeTabela := 'EDIMET';
  strNomeCampo := 'MET_CODIGO';
  FUsaCodigoAutomatico := fUsaProCodigo(strNomeTabela);
  qryTabela := fCriaQuery(Self);
  FEditorMetasRepository := TEditorMetasRepository.Create;
  HabilitarControlesParaEdicao(False);
  SetarTamanhoDosEditsDinamicos;
end;

procedure TfrmEditorMetas.FormDestroy(Sender: TObject);
begin
  DestruirFiltros;
  FreeAndNil(FDicFiltros);
  DestruirDefinicaoDeMetas;
  FreeAndNil(FDicDefMetas);
  FreeAndNil(FConsultasRel);
  FreeAndNil(FQryMetas);
  FreeAndNil(FEditorMetasRepository);
  inherited;
  If Assigned(qryTabela) Then
    FreeAndNil(qryTabela);
end;

procedure TfrmEditorMetas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3:
    Begin
      If (btnCopiarMetas.Enabled And btnCopiarMetas.Visible) Then
        btnCopiarMetas.Click;
    End;
    VK_F4:
    Begin
      If (btnGerarMetas.Enabled And btnGerarMetas.Visible) Then
        btnGerarMetas.Click;
    End;
    VK_F6:
    Begin
      If (btnHeranca.Enabled And btnHeranca.Visible) Then
        btnHeranca.Click;
    End;
    VK_Return:
    Begin
      If (cxgMetasDBTableViewCitel.IsControlFocused) Then
        Exit;
      If (ActiveControl <> Nil) And (ActiveControl.ClassName = 'TcxCustomInnerTextEdit') Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmEditorMetas.FecharQryMetas;
begin
  If Not FQryMetas.Active Then
    Exit;

  If FQryMetas.IsEmpty Then
    Exit;

  FQryMetas.Close;
end;

procedure TfrmEditorMetas.LimparControles;
begin
  edtCodMet.Text := EmptyStr;
  edtDesMet.Text := EmptyStr;
  edtCodEmp.Text := EmptyStr;
  edtNomEmp.Text := EmptyStr;
  edtCodVen.Text := EmptyStr;
  edtNomVen.Text := EmptyStr;
  edtCodDig.Text := EmptyStr;
  edtNomDig.Text := EmptyStr;
  edtCodRep.Text := EmptyStr;
  edtNomRep.Text := EmptyStr;
  edtCodFor.Text := EmptyStr;
  edtNomFor.Text := EmptyStr;
  edtAtiFor.Text := EmptyStr;
  edtDesAtiFor.Text := EmptyStr;
  edtCodMar.Text := EmptyStr;
  edtDesMar.Text := EmptyStr;
  edtLinGru.Clear;
  edtDesLinGru.Text := EmptyStr;
  edtCodIte.Text := EmptyStr;
  edtDesIte.Text := EmptyStr;
  edtDepIte.Text := EmptyStr;
  edtDesDepIte.Text := EmptyStr;
  edtPosCli.Text := EmptyStr;
  edtIteNot.Text := EmptyStr;
  edtValVen.Text := EmptyStr;
  edtVolLit.Text := EmptyStr;
  edtVolUni.Text := EmptyStr;
  edtMarLuc.Text := EmptyStr;
  edtDtaIni.Text := EmptyStr;
  edtDtaFin.Text := EmptyStr;
end;

procedure TfrmEditorMetas.IniciarEditor;
begin
  LimparControles;
  ConstruirFiltros;
  ConstruirDefinicaoDeMetas;
  cxgMetasDBTableViewCitel.ClearItems;
  FecharQryMetas;
end;

procedure TfrmEditorMetas.FormShow(Sender: TObject);
begin
  inherited;
  IniciarEditor;
end;

function TfrmEditorMetas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  Try
    Try
      If (inherited fValidaCampos(Sender)) Then
      Begin
        If (Sender = edtDtaIni) Then
        Begin
          If (Not DataValida(StrToDateDef(edtDtaIni.Text,0))) Then
          Begin
            pMensagemOk('Data inicial inválida!');
            Result := False;
            Exit;
          End;
        End
        Else If (Sender = edtDtaFin) Then
        Begin
          If (Not DataValida(StrToDateDef(edtDtaFin.Text, 0))) Then
          Begin
            pMensagemOk('Data final inválida!');
            Result := False;
            Exit;
          End
          Else If DataValida(edtDtaIni.Text) Then
          Begin
            If StrToDateDef(edtDtaIni.Text, 0) > StrToDateDef(edtDtaFin.Text, 0) Then
            Begin
              pMensagemOk('A data inicial deve ser menor que a data final!');
              Result := False;
              Exit;
            End;
          End;
        End
        Else If (Sender = edtDesMet) Then
        Begin
          If fEmptyStr(edtDesMet.Text) Then
          Begin
            pMensagemOk('A descrição da meta deve ser preenchida!');
            Result := False;
            Exit;
          End;
        End
        Else If (Sender = edtCodEmp) Then
        Begin
          If fEmptyStr(edtCodEmp.Text) Then
          Begin
            pMensagemOk('A empresa deve ser preenchida!');
            Result := False;
            Exit;
          End;
          Result := ValidarMultiSelecao(edtCodEmp, edtCodEmp.MaxLength);
        End
        Else If (Sender = edtCodMet) And (Not FUsaCodigoAutomatico) And (edtCodMet.Enabled) Then
        Begin
          If fEmptyStr(edtCodMet.Text) Then
          Begin
            pMensagemOk('O código da meta deve ser preenchido!');
            Result := False;
            Exit;
          End;
        End
        Else If (Sender = edtDesMet) Then
        Begin
          If fEmptyStr(edtDesMet.Text) Then
          Begin
            pMensagemOk('A descrição da meta deve ser preenchida!');
            pSetFocus(edtDesMet);
            Exit;
          End;
        End
        Else
          Result := ValidarMultiSelecao(Sender);
      End;
    Except
      On E: ExceptionAutCom Do
      Begin
        Result := False;
        fMensagem('',E.Message, ['&OK']);
      End;
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEditorMetas.fValidaCampos]');
        Result := False;
      End;
    End;
  Finally
    pAtualizaStatusCopiarMetas;
    If (Not Result) Then
      pSetFocus(Sender);
  End;
end;

function TfrmEditorMetas.GetConsultaDoFiltro(const AName: String): TPesquisas;
  Var
    LFiltro : TFiltro;
begin
  Result := pesSemPesquisa;

  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;

  Result := LFiltro.NomeDaConsulta;
end;

function TfrmEditorMetas.GetEditDescritivoDoFiltro(const AName: String): TCustomEdit;
  Var
    LFiltro : TFiltro;
begin
  Result := Nil;

  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;

  Result := LFiltro.EditDescritivo;
end;

function TfrmEditorMetas.GetNomeDaMetaPorCampoSQLCargaDados(const ACampoSQLCargaDados : String): String;
  Var
    LDefinicaoMeta : TDefinicaoMeta;
begin
  Result := EmptyStr;
  For LDefinicaoMeta In FDicDefMetas.Values Do
  Begin
    If (LDefinicaoMeta.CampoSQLCargaDados = ACampoSQLCargaDados) Then
      Exit(LDefinicaoMeta.NomeDaMeta)
  End;
end;

function TfrmEditorMetas.DataValida(const AVariant : Variant): Boolean;
begin
  Try
    Result := fDataValida(VarToDateTime(AVariant));
  Except
    Result := False;
  End;
end;

function TfrmEditorMetas.GetLabel(AControle : TCustomEdit; AWinControl : TWinControl) : TLabel;
  Var
    LContador : Integer;
begin
  Result := Nil;
  For LContador := 0 To Pred(AWinControl.ControlCount) Do
  Begin
    If (Not (AWinControl.Controls[LContador] Is TLabel)) Then
      Continue;

    If (TLabel(AWinControl.Controls[LContador]).FocusControl = Nil) Then
      Continue;

    If (TLabel(AWinControl.Controls[LContador]).FocusControl <> AControle) Then
      Continue;

    Exit(TLabel(AWinControl.Controls[LContador]));
  End;
end;

function TfrmEditorMetas.ValidarMultiSelecao(const ACodigoFiltro : TCustomEdit; const AMaxLength : Integer) : Boolean;
  Var
    LConsultasArray : TConsultasArray;
    LEdtDescritivo : TCustomEdit;
    LabelFiltro : TLabel;
    LDescricao : String;
begin
  Result := True;

  LEdtDescritivo := GetEditDescritivoDoFiltro(ACodigoFiltro.Name);

  If (fEmptyStr(fTiraCaracEspeciaisPonto(ACodigoFiltro.Text))) Then
  Begin
    SetarSelecaoFiltro(ACodigoFiltro.Name, []);
    ACodigoFiltro.Clear;
    If Assigned(LEdtDescritivo) Then
      LEdtDescritivo.Text := EmptyStr;
    Exit;
  End;

  If (TemMultiSelecaoNoFiltro(ACodigoFiltro.Name)) And (ACodigoFiltro.Text = fStrZero(String(ACodigoFiltro.Text), AMaxLength)) Then
    Exit;

  If (Not TemConsultaNoFiltro(ACodigoFiltro.Name)) Then
    Exit;

  If (LEdtDescritivo = Nil) Then
    Exit;

  ACodigoFiltro.Text := fStrZero(String(ACodigoFiltro.Text), AMaxLength);

  LDescricao := TConsultasRel.fRetDescricao(fTiraCaracEspeciaisPonto(ACodigoFiltro.Text), GetConsultaDoFiltro(ACodigoFiltro.Name));
  If fEmptyStr(LDescricao) Then
  Begin
    LabelFiltro := GetLabel(ACodigoFiltro, ACodigoFiltro.Parent);
    If LabelFiltro = Nil Then
      pMensagemOk('Valor inválido!')
    Else
      pMensagemOk(LabelFiltro.Caption + ' não encontrado(a)!');
    Result := False;
    Exit;
  End;

  LEdtDescritivo.Text := LDescricao;
  SetLength(LConsultasArray, 1);
  LConsultasArray[0].strCodigo := ACodigoFiltro.Text;
  SetarSelecaoFiltro(ACodigoFiltro.Name, LConsultasArray);
  ValidarDigitacaoDosExcludentes(ACodigoFiltro.Name);
end;

procedure TfrmEditorMetas.HabilitarControlesParaEdicao(const AHabilita: Boolean);
begin
  pnlCabecalho.Enabled := AHabilita;
  pnlColunasFiltrosEMetas.Enabled := AHabilita;
  cxgMetasDBTableViewCitel.OptionsData.Editing := AHabilita;
  btnGerarMetas.Enabled := AHabilita;
  btnCopiarMetas.Enabled := AHabilita;
  btnHeranca.Enabled := AHabilita;
  edtCodMet.Enabled := AHabilita;
  If (AHabilita) Then
  Begin
    edtCodMet.Enabled := (qryTabela.State = dsInsert) And (Not FUsaCodigoAutomatico);
    btnHeranca.Enabled := fHabilitaHerancaDeMetas;
  End;
end;

function TfrmEditorMetas.fHabilitaHerancaDeMetas: Boolean;
begin
  Result := False;

  If (Not Assigned(FQryMetas)) Then
    Exit;

  If (Not FQryMetas.Active) Then
    Exit;

  If (FQryMetas.IsEmpty) Then
    Exit;

  Result := True;
end;

procedure TfrmEditorMetas.pAtualizaStatusCopiarMetas;
  Var
    LFiltro : TFiltro;
begin
  btnCopiarMetas.Enabled := True;
  For LFiltro In FDicFiltros.Values Do
  Begin
    If (LFiltro.Cabecalho) Then
      Continue;
    If (Length(LFiltro.Selecao) = 0) Then
      Continue;
    If (Not LFiltro.Selecao[0].strCodigo.IsEmpty) Then
    Begin
      btnCopiarMetas.Enabled := False;
      Exit;
    End;
  End;
end;

procedure TfrmEditorMetas.pInicializaIndices;
begin
  inherited;
end;

function TfrmEditorMetas.GetSQLMetasGeradas(const ACodigoMeta : String): String;
  Var
    LFiltro : TFiltro;
    LSelect : String;
    LJoin : String;
    LWhere : String;
    LOrderBy : String;
    LCampoSelect : String;
    LArrMetasPreenchidas : TArray<String>;
    LContador : Integer;
begin
  LSelect := EmptyStr;
  LWhere := EmptyStr;
  LOrderBy := EmptyStr;
  LJoin := EmptyStr;
  For LFiltro In FDicFiltros.Values Do
  Begin
    If Not TemValorNoFiltro(LFiltro.NomeDoFiltro) Then
      Continue;
    If Not FiltroParticipaDaGeracaoDasMetas(LFiltro.NomeDoFiltro) Then
      Continue;
    LCampoSelect := LFiltro.CampoSQLExibicao;
    If LSelect.IsEmpty Then
      LSelect := LCampoSelect
    Else
      LSelect := LSelect + ', ' + LCampoSelect;
    LJoin := LJoin + LFiltro.InstrucaoJoinCargaDados + ' ';
    LWhere := LWhere + fSQLIn(LFiltro.Selecao, LFiltro.CampoSQLCargaDados, LWhere.IsEmpty, False) + ' ';
    If LOrderBy.IsEmpty Then
      LOrderBy := LFiltro.CampoSQLCargaDados
    Else
      LOrderBy := LOrderBy + ', ' + LFiltro.CampoSQLCargaDados;
  End;
  LArrMetasPreenchidas := FEditorMetasRepository.GetCamposMetasPreenchidos(ACodigoMeta);
  For LContador := 0 To Pred(Length(LArrMetasPreenchidas)) Do
  Begin
    LCampoSelect := Format('%s AS %s', [LArrMetasPreenchidas[LContador], GetNomeDaMetaPorCampoSQLCargaDados(LArrMetasPreenchidas[LContador])]);
    If LSelect.IsEmpty Then
      LSelect := LCampoSelect
    Else
      LSelect := LSelect + ', ' + LCampoSelect;
  End;
  Result := EmptyStr;
  If (Not LSelect.IsEmpty) Then
  Begin
    Result := Result + ' SELECT ' + LSelect;
    Result := Result + '   FROM EDMREG ';
    Result := Result + LJoin;
    Result := Result + '  WHERE REG_CODMET = ' + QuotedStr(ACodigoMeta);
    Result := Result + '  ORDER BY ' + LOrderBy;
  End;
end;

function TfrmEditorMetas.fTratarDadosDaSelecao(const ASelecao : TConsultasArray) : TConsultasArray;
  Var
    LContador : Integer;
begin
  SetLength(Result, 0);
  For LContador := Low(ASelecao) To High(ASelecao) Do
  Begin
    SetLength(Result, Length(Result) + 1);
    Result[Length(Result)-1] := ASelecao[LContador];
    Result[Length(Result)-1].strCodigo := AnsiReplaceStr(Result[Length(Result)-1].strCodigo, '.', EmptyStr);
  End;
end;

function TfrmEditorMetas.GetSQLGeracaoDasMetas : String;
  Var
    LFiltro : TFiltro;
    LSelect : String;
    LFrom : String;
    LWhere : String;
    LOrderBy : String;
    LCampoVirtual : String;
    LContador : Integer;
begin
  LSelect := EmptyStr;
  LFrom := EmptyStr;
  LWhere := EmptyStr;
  LOrderBy := EmptyStr;

  For LFiltro In FDicFiltros.Values Do
  Begin
    If Not TemValorNoFiltro(LFiltro.NomeDoFiltro) Then
      Continue;
    If Not FiltroParticipaDaGeracaoDasMetas(LFiltro.NomeDoFiltro) Then
      Continue;
    If LSelect.IsEmpty Then
      LSelect := LFiltro.CampoSQLExibicao
    Else
      LSelect := LSelect + ', ' + LFiltro.CampoSQLExibicao;
    If LFrom.IsEmpty Then
      LFrom := LFiltro.Tabela
    Else
      LFrom := LFrom + ', ' + LFiltro.Tabela;
    LWhere := LWhere + fSQLIn(fTratarDadosDaSelecao(LFiltro.Selecao), LFiltro.CampoSQLChave, LWhere.IsEmpty, False) + ' ';
    If LOrderBy.IsEmpty Then
      LOrderBy := LFiltro.CampoSQLChave
    Else
      LOrderBy := LOrderBy + ', ' + LFiltro.CampoSQLChave;
  End;

  For LContador := 0 To Pred(pnlMetas.ControlCount) Do
  Begin
    If (Not (pnlMetas.Controls[LContador] Is TLabel)) Then
      Continue;

    If (TLabel(pnlMetas.Controls[LContador]).FocusControl = Nil) Then
      Continue;

    If (Not (TLabel(pnlMetas.Controls[LContador]).FocusControl Is TcxCurrencyEdit)) Then
      Continue;

    If TcxCurrencyEdit(TLabel(pnlMetas.Controls[LContador]).FocusControl).Value = 0 Then
      Continue;

    LCampoVirtual := Format('%s AS %s ', [DeclaraCampoVirtualSQL(TcxCurrencyEdit(TLabel(pnlMetas.Controls[LContador]).FocusControl).Value, TcxCurrencyEdit(TLabel(pnlMetas.Controls[LContador]).FocusControl).Properties.DecimalPlaces), TcxCurrencyEdit(TLabel(pnlMetas.Controls[LContador]).FocusControl).Name]);
    If LSelect.IsEmpty Then
      LSelect := LCampoVirtual
    Else
      LSelect := LSelect + ', ' + LCampoVirtual;
  End;

  Result := EmptyStr;
  Result := Result + ' SELECT ' + LSelect;
  Result := Result + '   FROM ' + LFrom;
  Result := Result + '  WHERE ' + LWhere;
  Result := Result + '  ORDER BY ' + LOrderBy;
end;

procedure TfrmEditorMetas.GravarEmpresas(const AAutoincrem : String);
  Var
    LFiltro : TFiltro;
    LContador : Integer;
    LListEditorMetasEmpresaDto : TList<TEditorMetasEmpresaDto>;
    LEditorMetasEmpresaDto : TEditorMetasEmpresaDto;
begin
  LListEditorMetasEmpresaDto := TList<TEditorMetasEmpresaDto>.Create;
  Try
    FDicFiltros.TryGetValue('edtCodEmp', LFiltro);
    For LContador := Low(LFiltro.Selecao) To High(LFiltro.Selecao) Do
    Begin
      FillChar(LEditorMetasEmpresaDto, SizeOf(LEditorMetasEmpresaDto), #0);
      LEditorMetasEmpresaDto.CodigoEmpresa := LFiltro.Selecao[LContador].strCodigo;
      LListEditorMetasEmpresaDto.Add(LEditorMetasEmpresaDto);
    End;
    FEditorMetasRepository.GravarEmpresas(AAutoincrem, LListEditorMetasEmpresaDto);
  Finally
    FreeAndNil(LListEditorMetasEmpresaDto);
  End;
end;

function TfrmEditorMetas.ValorDecimalDoCampoSeExiste(const AFieldName: String;
  const ADataSet: TDataSet): Double;
  Var
    LField : TField;
begin
  Result := 0;

  LField := ADataSet.FindField(AFieldName);
  If (Not Assigned(LField)) Then
    Exit;

  Result := TFloatField(LField).Value;
end;

function TfrmEditorMetas.ValorIntegerDoCampoSeExiste(const AFieldName: String;
  const ADataSet: TDataSet): Integer;
  Var
    LField : TField;
begin
  Result := 0;

  LField := ADataSet.FindField(AFieldName);
  If (Not Assigned(LField)) Then
    Exit;

  Result := TIntegerField(LField).Value;
end;

function TfrmEditorMetas.ValorStringDoCampoSeExiste(const AFieldName : String; const ADataSet : TDataSet): String;
  Var
    LField : TField;
begin
  Result := EmptyStr;

  LField := ADataSet.FindField(AFieldName);
  If (Not Assigned(LField)) Then
    Exit;

  Result := TStringField(LField).AsString;
end;

procedure TfrmEditorMetas.GravarMetas(const ACodigoMeta: String);
  Var
    LListMetas : TList<TEditorMetasRegistrosDto>;
    LRegistro : TEditorMetasRegistrosDto;
begin
  LListMetas := TList<TEditorMetasRegistrosDto>.Create;
  Try
    FQryMetas.DisableControls;
    FQryMetas.First;
    While Not FQryMetas.Eof Do
    Begin
      FillChar(LRegistro, SizeOf(LRegistro), #0);
      LRegistro.CodigoVendedor := ValorStringDoCampoSeExiste('edtCodVen', FQryMetas);
      LRegistro.CodigoDigitador := ValorStringDoCampoSeExiste('edtCodDig', FQryMetas);
      LRegistro.CodigoRepresentante := ValorStringDoCampoSeExiste('edtCodRep', FQryMetas);
      LRegistro.CodigoMarca := ValorStringDoCampoSeExiste('edtCodMar', FQryMetas);
      LRegistro.CodigoLinhaGrupo := ValorStringDoCampoSeExiste('edtLinGru', FQryMetas);
      LRegistro.CodigoAtividade := ValorStringDoCampoSeExiste('edtAtiFor', FQryMetas);
      LRegistro.CodigoFornecedor := ValorStringDoCampoSeExiste('edtCodFor', FQryMetas);
      LRegistro.CodigoDepartamento := ValorStringDoCampoSeExiste('edtDepIte', FQryMetas);
      LRegistro.CodigoProduto := ValorStringDoCampoSeExiste('edtCodIte', FQryMetas);
      LRegistro.PosicaoClientes := ValorIntegerDoCampoSeExiste('edtPosCli', FQryMetas);
      LRegistro.ItensPorNota := ValorIntegerDoCampoSeExiste('edtIteNot', FQryMetas);
      LRegistro.ValorDeVenda := ValorDecimalDoCampoSeExiste('edtValVen', FQryMetas);
      LRegistro.VolumeVendasLitros := ValorDecimalDoCampoSeExiste('edtVolLit', FQryMetas);
      LRegistro.VolumeVendasUnidade := ValorDecimalDoCampoSeExiste('edtVolUni', FQryMetas);
      LRegistro.MargemLucro := ValorDecimalDoCampoSeExiste('edtMarLuc', FQryMetas);
      LListMetas.Add(LRegistro);
      FQryMetas.Next;
    End;
    FEditorMetasRepository.GravarDadosMeta(ACodigoMeta, LListMetas);
  Finally
    FQryMetas.EnableControls;
    FreeAndNil(LListMetas);
  End;
end;

function TfrmEditorMetas.DeclaraCampoVirtualSQL(const AValue : Double; ADecimalPlaces : Integer): String;
begin
  Try
    Result := fFloatToStrPonto(AValue, 12, ADecimalPlaces);
  Except
    Result := '0.00';
  End;
end;

procedure TfrmEditorMetas.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If Not ValidouDadosObrigatoriosParaGravacaoDaMeta(True) Then
    Exit;

  AtribuirValoresPreGravacao;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;

    If (Not Self.blnGravou) Then
    Begin
      fRollBack;
      Exit;
    End;

    ExcluirEmpresas(qryTabela.FieldByName('AUTOINCREM').AsString);
    GravarEmpresas(qryTabela.FieldByName('AUTOINCREM').AsString);
    ExcluirMetas(qryTabela.FieldByName('MET_CODIGO').AsString);
    GravarMetas(qryTabela.FieldByName('MET_CODIGO').AsString);

    fCommit;

    If fEmptyStr(edtCodMet.Text) Then
      edtCodMet.Text := qryTabela.FieldByName('MET_CODIGO').AsString;

    HabilitarControlesParaEdicao(False);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[TfrmEditorMetas.btnGravarClick]');
    End;
  End;
end;

procedure TfrmEditorMetas.EfetivarHeranca(const AOperador : String; const AFieldNameOperador : String);
  Var
    LCdsCloneRegistro : TUniClientDataSet;
    LFiltro : TFiltro;
    LFiltroHeranca : String;
    LNomeOperador : String;
begin
  LCdsCloneRegistro := fCriaClientDatset(FQryMetas, False, Self, True);
  Try
    LNomeOperador := fRetNomeOperador(AOperador);
    LCdsCloneRegistro.Edit;
    LCdsCloneRegistro.FieldByName(AFieldNameOperador).AsString := AOperador + '-' + LNomeOperador;
    LCdsCloneRegistro.Post;

    LFiltroHeranca := AFieldNameOperador + ' = ' + QuotedStr(AOperador + '-' + LNomeOperador);
    For LFiltro In FDicFiltros.Values Do
    Begin
      If (Not Assigned(FQryMetas.FindField(LFiltro.NomeDoFiltro))) Then
        Continue;
      If FQryMetas.FieldByName(LFiltro.NomeDoFiltro).IsNull Then
        Continue;
      If (AFieldNameOperador = LFiltro.NomeDoFiltro) Then
        Continue;
      LFiltroHeranca := LFiltroHeranca + ' AND ' + LFiltro.NomeDoFiltro + ' = ' + QuotedStr(FQryMetas.FieldByName(LFiltro.NomeDoFiltro).AsString);
    End;

    FQryMetas.DisableControls;
    Try
      FQryMetas.Filter := LFiltroHeranca;
      FQryMetas.Filtered := True;
      pCloneRegistro(FQryMetas, LCdsCloneRegistro, FQryMetas.RecordCount = 0);
    Finally
      FQryMetas.Filtered := False;
      FQryMetas.Filter := EmptyStr;
      FQryMetas.EnableControls;
    End;
  Finally
    FreeAndNil(LCdsCloneRegistro);
  End;
end;

procedure TfrmEditorMetas.btnHerancaClick(Sender: TObject);
  Var
    LColunaOperador : TcxGridDbColumn;
    LOperador : String;
    LFrmDigOperador : TfrmDigOperador;
begin
  If (Not FQryMetas.Active) Or
     (FQryMetas.IsEmpty) Or
     (cxgMetasDBTableViewCitel.ColumnCount = 0) Then
  Begin
    pMensagemOk('Selecione um registro para utilizar a herança!');
    Exit;
  End;

  LColunaOperador := cxgMetasDBTableViewCitel.Columns[0];

  pCriarFormularios(TfrmDigOperador, LFrmDigOperador);
  Try
    LOperador := EmptyStr;
    LFrmDigOperador.Caption := Format('Digite o código do %s', [LColunaOperador.Caption]);
    If LFrmDigOperador.ShowModal = MrOK Then
    Begin
      LOperador := LFrmDigOperador.edtCodOpe.Text;
      If LOperador.IsEmpty Then
        Exit;
      EfetivarHeranca(LOperador, LColunaOperador.DataBinding.FieldName);
    End;
  Finally
    pFreeAndNil(LFrmDigOperador);
  End;
end;

procedure TfrmEditorMetas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  IniciarEditor;
  HabilitarControlesParaEdicao(True);
  FocuInicial;
end;

procedure TfrmEditorMetas.btnPesquisaClick(Sender: TObject);
  Var
    LKey : Char;
    LArrSel : TConsultasArray;
begin
  inherited;
  LKey := '/';
  If Not fPesqEditorMetas(Self,
                          qryTabela,
                          LKey,
                          LArrSel,
                          True) Then
    Exit;

  If (Not qryTabela.Active) Then
    Exit;

  If (qryTabela.IsEmpty) Then
    Exit;

  CarregarDadosEmTela(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('MET_CODIGO').AsString);
end;

procedure TfrmEditorMetas.CarregarCabecalhoMetas(const AAutoincrem: String; const ACopiandoMetas : Boolean);
  Var
    LEditorMetasCabecalhoDto : TEditorMetasCabecalhoDto;
begin
  LEditorMetasCabecalhoDto := FEditorMetasRepository.CarregarMetasCabecalho(AAutoincrem);

  If (Not ACopiandoMetas) Then
  Begin
    edtCodMet.Text := LEditorMetasCabecalhoDto.Codigo;
    edtDesMet.Text := LEditorMetasCabecalhoDto.Descricao;
    edtDtaIni.Date := 0;
    edtDtaFin.Date := 0;
    If (LEditorMetasCabecalhoDto.DataInicial > 0) Then
      edtDtaIni.Date := LEditorMetasCabecalhoDto.DataInicial;
    If (LEditorMetasCabecalhoDto.DataFinal > 0) Then
      edtDtaFin.Date := LEditorMetasCabecalhoDto.DataFinal;
  End;

  edtPosCli.Text := EmptyStr;
  If (LEditorMetasCabecalhoDto.PositivacaoDeClientes > 0) Then
    edtPosCli.Value := LEditorMetasCabecalhoDto.PositivacaoDeClientes;

  edtIteNot.Text := EmptyStr;
  If (LEditorMetasCabecalhoDto.ItensPorNota > 0) Then
    edtIteNot.Value := LEditorMetasCabecalhoDto.ItensPorNota;

  edtValVen.Text := EmptyStr;
  If (LEditorMetasCabecalhoDto.ValorDeVenda > 0) Then
    edtValVen.Value := LEditorMetasCabecalhoDto.ValorDeVenda;

  edtVolLit.Text := EmptyStr;
  If (LEditorMetasCabecalhoDto.VolumeDeVendasEmLitros > 0) Then
    edtVolLit.Value := LEditorMetasCabecalhoDto.VolumeDeVendasEmLitros;

  edtVolUni.Text := EmptyStr;
  If (LEditorMetasCabecalhoDto.VolumeDeVendasEmUnidades > 0) Then
    edtVolUni.Value := LEditorMetasCabecalhoDto.VolumeDeVendasEmUnidades;

  edtMarLuc.Text := EmptyStr;
  If (LEditorMetasCabecalhoDto.MargemDeLucro > 0) Then
    edtMarLuc.Value := LEditorMetasCabecalhoDto.MargemDeLucro;
end;

procedure TfrmEditorMetas.FormatarCamposDoTipoFloat(const ADataSet : TDataSet);
  Var
    LContador : Integer;
begin
  For LContador := 0 To Pred(ADataSet.FieldCount) Do
  Begin
    If ADataSet.Fields[LContador].DataType <> ftFloat Then
      Continue;
    TFloatField(ADataSet.Fields[LContador]).DisplayFormat := '##,#0.00';
  End;
end;

procedure TfrmEditorMetas.CarregarDadosDasMetas(const ASQL : String);
begin
  If (ASQL.IsEmpty) Then
    Exit;

  FQryMetas.Close;
  FQryMetas.SQL.Text := ASQL;
  FQryMetas.Open;
  FormatarCamposDoTipoFloat(FQryMetas);
  dtsMetas.DataSet := FQryMetas;
  cxgMetasDBTableViewCitel.ApplyBestFit();
end;

procedure TfrmEditorMetas.CarregarDadosMeta(const ACodigoMeta: String);
begin
  CriarColunasDoGrid;
  CarregarDadosDasMetas(GetSQLMetasGeradas(ACodigoMeta));
  btnHeranca.Enabled := fHabilitaHerancaDeMetas;
end;

procedure TfrmEditorMetas.CarregarEmpresas(const AAutoincrem: String);
  Var
    LArrEmpresas : TConsultasArray;
    LListEditorMetasEmpresaDto : TList<TEditorMetasEmpresaDto>;
    LContador : Integer;
begin
  LListEditorMetasEmpresaDto := FEditorMetasRepository.CarregarEmpresas(AAutoincrem);
  Try
    SetLength(LArrEmpresas, 0);
    For LContador := 0 To Pred(LListEditorMetasEmpresaDto.Count) Do
    Begin
      SetLength(LArrEmpresas, Length(LArrEmpresas) + 1);
      LArrEmpresas[Length(LArrEmpresas)-1].strCodigo := LListEditorMetasEmpresaDto[LContador].CodigoEmpresa;
    End;
    SetarSelecaoFiltro('edtCodEmp', LArrEmpresas);

    edtCodEmp.Text := EmptyStr;
    edtNomEmp.Text := EmptyStr;

    If (Length(LArrEmpresas) > 1) Then
    Begin
      edtCodEmp.Text := StringOfChar('0', Length(LArrEmpresas[0].strCodigo));
      edtNomEmp.Text := '+1';
    End
    Else If (Length(LArrEmpresas) = 1) Then
    Begin
      edtCodEmp.Text := LArrEmpresas[0].strCodigo;
      edtNomEmp.Text := fRetNomeEmpresa(LArrEmpresas[0].strCodigo);
    End;
  Finally
    FreeAndNil(LListEditorMetasEmpresaDto);
  End;
end;

procedure TfrmEditorMetas.AtribuirValoresPreGravacao;
begin
  If (Not FUsaCodigoAutomatico) Then
    qryTabela.FieldByName('MET_CODIGO').AsString := edtCodMet.Text;
  qryTabela.FieldByName('MET_DESMET').AsString := edtDesMet.Text;

  qryTabela.FieldByName('MET_DTAINI').AsDateTime := StrToDate(edtDtaIni.Text);
  qryTabela.FieldByName('MET_DTAFIN').AsDateTime := StrToDate(edtDtaFin.Text);

  If (edtPosCli.Value <> 0) Then
    qryTabela.FieldByName('MET_POSCLI').AsInteger := fFloatToInt(edtPosCli.Value);
  If (edtIteNot.Value <> 0) Then
    qryTabela.FieldByName('MET_ITENOT').AsInteger := fFloatToInt(edtIteNot.Value);
  If (edtValVen.Value <> 0) Then
    qryTabela.FieldByName('MAT_VALVEN').AsFloat := edtValVen.Value;
  If (edtVolLit.Value <> 0) Then
    qryTabela.FieldByName('MET_VOLLIT').AsFloat := edtVolLit.Value;
  If (edtVolUni.Value <> 0) Then
    qryTabela.FieldByName('MET_VOLUNI').AsFloat := edtVolUni.Value;
  If (edtMarLuc.Value <> 0) Then
    qryTabela.FieldByName('MET_MARLUC').AsFloat := edtMarLuc.Value;
end;

procedure TfrmEditorMetas.AtualizarFiltro(const ACodigoMeta : String; const ANomeDoCampo: String; const ANomeDoFiltro : String; const AEditCodigo : TCustomEdit; const AEditDescricao : TCustomEdit);
  Var
    LConsultasArray : TConsultasArray;
begin
  LConsultasArray := FEditorMetasRepository.CarregaFiltroDasMetas(ACodigoMeta, ANomeDoCampo);
  SetarSelecaoFiltro(ANomeDoFiltro, LConsultasArray);
  If Length(LConsultasArray) > 1 Then
  Begin
    If (AEditCodigo Is TMaskEditFocus) Then
      TMaskEditFocus(AEditCodigo).Text := StringOfChar('0', Length(LConsultasArray[0].strCodigo))
    Else
      AEditCodigo.Text := StringOfChar('0', Length(LConsultasArray[0].strCodigo));
    AEditDescricao.Text := '+1';
  End
  Else If Length(LConsultasArray) = 1 Then
  Begin
    If (AEditCodigo Is TMaskEditFocus) Then
      TMaskEditFocus(AEditCodigo).Text := LConsultasArray[0].strCodigo
    Else
      AEditCodigo.Text := LConsultasArray[0].strCodigo;
    AEditDescricao.Text := TConsultasRel.fRetDescricao(LConsultasArray[0].strCodigo, GetConsultaDoFiltro(AEditCodigo.Name), True);
  End
  Else
  Begin
    AEditCodigo.Clear;
    AEditDescricao.Text := EmptyStr;
  End;
end;

procedure TfrmEditorMetas.AtualizarFiltrosNoEditor(const ACodigoMeta: String);
begin
  AtualizarFiltro(ACodigoMeta, 'REG_CODMAR', 'edtCodMar', edtCodMar, edtDesMar);
  AtualizarFiltro(ACodigoMeta, 'REG_CODGRU', 'edtLinGru', edtLinGru, edtDesLinGru);
  AtualizarFiltro(ACodigoMeta, 'REG_CODATI', 'edtAtiFor', edtAtiFor, edtDesAtiFor);
  AtualizarFiltro(ACodigoMeta, 'REG_CODFOR', 'edtCodFor', edtCodFor, edtNomFor);
  AtualizarFiltro(ACodigoMeta, 'REG_CODDEP', 'edtDepIte', edtDepIte, edtDesDepIte);
  AtualizarFiltro(ACodigoMeta, 'REG_CODITE', 'edtCodIte', edtCodIte, edtDesIte);
  AtualizarFiltro(ACodigoMeta, 'REG_CODVEN', 'edtCodVen', edtCodVen, edtNomVen);
  AtualizarFiltro(ACodigoMeta, 'REG_CODDIG', 'edtCodDig', edtCodDig, edtNomDig);
  AtualizarFiltro(ACodigoMeta, 'REG_CODREP', 'edtCodRep', edtCodRep, edtNomRep);
end;

function TfrmEditorMetas.GetSelecaoFiltro(const AName : String): TConsultasArray;
  Var
    LFiltro : TFiltro;
begin
  Result := [];
  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;
  Result := LFiltro.Selecao;
end;

procedure TfrmEditorMetas.SetarSelecaoFiltro(const AName : String; const ASelecao: TConsultasArray);
  Var
    LFiltro : TFiltro;
begin
  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;
  LFiltro.Selecao := ASelecao;
end;

function TfrmEditorMetas.TemMultiSelecaoNoFiltro(const AName: String): Boolean;
  Var
    LFiltro : TFiltro;
begin
  Result := False;

  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;

  Result := (Length(LFiltro.Selecao) > 1);
end;

function TfrmEditorMetas.TemValorNoFiltro(const AName: String): Boolean;
  Var
    LFiltro : TFiltro;
begin
  Result := False;

  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;

  Result := (Length(LFiltro.Selecao) > 0) And (Not fEmptyStr(LFiltro.Selecao[0].strCodigo));
end;

function TfrmEditorMetas.FiltroExcludente(const AName : String) : Boolean;
  Var
    LContador : Integer;
begin
  Result := False;
  For LContador := Low(EXCLUDENTES) To High(EXCLUDENTES) Do
  Begin
    If (AName = EXCLUDENTES[LContador]) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TfrmEditorMetas.FiltroParticipaDaGeracaoDasMetas(
  const AName: String): Boolean;
  Var
    LFiltro : TFiltro;
begin
  Result := False;

  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;

  Result := (Not LFiltro.Cabecalho);
end;

procedure TfrmEditorMetas.ValidarDigitacaoDosExcludentes(const AFilterName : String);
  Var
    LContador : Integer;
    LComponent : TComponent;
    LEdtDescritivo : TCustomEdit;
begin
  If Not FiltroExcludente(AFilterName) Then
    Exit;
  For LContador := Low(EXCLUDENTES) To High(EXCLUDENTES) Do
  Begin
    If (AFilterName = EXCLUDENTES[LContador]) Then
      Continue;
    SetarSelecaoFiltro(EXCLUDENTES[LContador], []);

    LComponent := FindComponent(EXCLUDENTES[LContador]);
    If (LComponent <> Nil) Then
    Begin
      TCustomEdit(LComponent).Text := EmptyStr;
      LEdtDescritivo := GetEditDescritivoDoFiltro(TCustomEdit(LComponent).Name);
      If (LEdtDescritivo <> Nil) Then
        LEdtDescritivo.Text := EmptyStr;
    End;
  End;
end;

function TfrmEditorMetas.ValidarMultiSelecao(Sender: TWinControl): Boolean;
begin
  Result := True;
  If (Sender Is TEditFocus) And (TemConsultaNoFiltro(TEditFocus(Sender).Name)) Then
    Exit(ValidarMultiSelecao(TEditFocus(Sender), TEditFocus(Sender).MaxLength))
  Else If (Sender Is TMaskEditFocus) And (TemConsultaNoFiltro(TMaskEditFocus(Sender).Name)) Then
    Exit(ValidarMultiSelecao(TMaskEditFocus(Sender), TMaskEditFocus(Sender).MaxLength));
end;

function TfrmEditorMetas.PreencheuFiltroPrincipal: Boolean;
  Var
    LContador : Integer;
    LComponent : TComponent;
begin
  Result := False;
  For LContador := Low(EXCLUDENTES) To High(EXCLUDENTES) Do
  Begin
    LComponent := FindComponent(EXCLUDENTES[LContador]);
    If (LComponent = Nil) Then
      Continue;
    If (Not String(TCustomEdit(LComponent).Text).IsEmpty) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TfrmEditorMetas.PreeencheuAoMenosUmaMeta: Boolean;
  Var
    LContador : Integer;
begin
  Result := False;
  For LContador := 0 To Pred(pnlMetas.ControlCount) Do
  Begin
    If (Not (pnlMetas.Controls[LContador] Is TLabel)) Then
      Continue;

    If (TLabel(pnlMetas.Controls[LContador]).FocusControl = Nil) Then
      Continue;

    If (Not (TLabel(pnlMetas.Controls[LContador]).FocusControl Is TcxCurrencyEdit)) Then
      Continue;

    If TcxCurrencyEdit(TLabel(pnlMetas.Controls[LContador]).FocusControl).Value = 0 Then
      Continue;

    Exit(True);
  End;
end;

function TfrmEditorMetas.ValidouDadosParaGeracaoDasMetas: Boolean;
begin
  Result := False;
  If (Not PreencheuFiltroPrincipal) Then
  Begin
    pMensagemOk('É necessário preencher o filtro principal (escolha uma das opções em negrito)!');
    Exit;
  End;
  If (Not PreeencheuAoMenosUmaMeta) Then
  Begin
    pMensagemOk('É necessário preencher ao menos uma meta!' + sLineBreak + 'Positivação de Clientes, Itens por Notas, etc...');
    Exit;
  End;
  Result := True;
end;

function TfrmEditorMetas.ValidouDadosObrigatoriosParaGravacaoDaMeta(const AVerificarRegistrosDeMetas : Boolean): Boolean;
begin
  Result := False;

  If (AVerificarRegistrosDeMetas) Then
  Begin
    If (Not FQryMetas.Active) Or
       (FQryMetas.IsEmpty) Then
    Begin
      pMensagemOk('Nenhum registro de meta foi incluido nesse cadastro, verifique!');
      Exit;
    End;
  End;

  Result := True;
end;

function TfrmEditorMetas.TemConsultaNoFiltro(const AName: String): Boolean;
  Var
    LFiltro : TFiltro;
begin
  Result := False;

  If Not FDicFiltros.TryGetValue(AName, LFiltro) Then
    Exit;

  Result := (LFiltro.NomeDaConsulta <> pesSemPesquisa);
end;

end.
