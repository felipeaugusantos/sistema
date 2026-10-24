unit Contabilidade.Interfaces.Funcoes;

interface

uses EditFocus, Vcl.Controls, Uni, Classes, Forms, Vcl.StdCtrls, cxProgressBar,
     Data.DB, BitBtnLockedIncrem, untIZClient, untTypesSistema, untConstantes,
     cxGridDBTableView;

type
  IContabilidadeFuncoes = interface
    ['{CD37769F-7226-4C59-B3D8-302BE0676EFF}']
    function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
    function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
    function fMensagem(strTitulo   : string;
                       strTexto    : string;
                       arrOpcoes   : Array Of String;
                       intFocoBotao: Integer = 1;
                       blnSaiComEsc: Boolean = False;
                       intEstFon   : Integer = 1;
                       intWidBut   : Integer = 0;
                       blnAutosize : Boolean = False;
                       intSomarTop : Integer = 0): Integer;
    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fCampoTabela(strCampo      : String;
                          strNomTab     : String;
                          arrCampoChave : Array Of String;
                          arrValorChave : Array Of Variant;
                          blnLerBanco: Boolean = True): Variant;
    function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
    function fAtualizaProCod(strNomeTabela: String; conSegConexao: TUniConnection = Nil): String;
    function fStartTransaction:Boolean;
  	function fRollBack:Boolean;
	  function fCommit:Boolean;
    function fRetSqcNco(strCodEmp: String = ''): Longint;
    procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant; overload;
    procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
    function fPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                          Self     : TForm;                           {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                          edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                           {* Key                                         *}
                          Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                          blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                          blnResEmp: Boolean = False;                 {* Restringir empresas que usuário tem acesso  *}
                          strEmpresas: String = '';                   {* Empresas                                    *}
                          blnAceCtr: Boolean = False;                 {* Verifica se filtrará as empresas que o usuário tem acesso na Baixa de Contas a Receber *}
                          strAceCtr: String = ''): Boolean;           {* Empresas que o usuário possui acesso na Baixa de Contas a Receber        *}
    function fRetNomeEmpresa: String;
    function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True): String;
    function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
    procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
    function fChamaTelaGravando(fExecutarAcao: TFunctionFormGravando): Boolean;
    procedure pFreeAndNil(var frmForm);
    procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
    function fVerificaIntegridade(strNomFrm, strTabela: String; qryTabOriginal: TDataSet;
      blnGravar: Boolean = True; blnSoCriaTabela: Boolean = FALSE;
      strMotDel: String = ''; strOpeDel: String = ''; blnTabAux: Boolean = False): String;
    procedure pValidaProCod(strNomeTabela: String);
    function fAbrirTabela(NomeTabela:TDataSet):Boolean;
    function fUsaProCodigo(strNomeTabela: String): Boolean;
    function fLock_Unlock(strNomeTabela: String;
                          blnTrava: Boolean;
                          blnLoopTravamento: Boolean = True;
                          blnHourGlass: Boolean = FALSE;
                          strCon_Id: String = '';
                          blnMostraMsgTravamento: Boolean = True;
                          strOrigem: String = ''): Boolean;
    function fFecharTabela(NomeTabela:TDataSet):Boolean;
    function fVerificaDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean;
    function fRetTamCampo(strNomeTabela: String): Integer;
    function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    procedure pSetButton(NomeTabela:TDataSet;btnNovo,btnConfirma,btnExclui,btnCancela,btnEditar,btnLocalizar,btnSair:TBitBtnLocked);
    function fPesqHistoricoPadrao(Self     : TForm;                    {* Formulário                                  *}
                                  edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                  edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                  qryTabela: TUniQuery;                {* Query                                       *}
                                  Var chrKey: Char;                    {* Key                                         *}
                                  Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                  blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
    function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;
    function fSemMascaraPlaNco(strValor: String): String;
    function fNow: TDateTime;
    function fMskCon: String;
    function fRetHashString(strString: String): String;
    function fPesqPlanoContabil(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
    function fStrToFloat(strValorUnico: String): Double;
    function fRetNomeOperador(strCodOpe: String): String;
    function fEntraCons(strCodigo: String): Boolean;
    function fPesqOperador(Self     : TForm;                             {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                           edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                           {* Query                                       *}
                           Var chrKey: Char;                             {* Key                                         *}
                           Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                           blnConSim: Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                           blnAtivos: Boolean = False;                   {* Somente Operadores Ativos                   *}
                           blnGerentes: Boolean = False;                 {* Somente Operadores Gerentes                 *}
                           blnMecanicos: Boolean = False;                {* Somente Operadores Mecânicos                *}
                           blnVenRepre: Boolean = False;                 {* Somente Vendedor Interno/Representante Externo *}
                           blnCompradores: Boolean = False;              {* Somente Compradores                         *}
                           blnAdministrativo: Boolean = False;
                           blnSubGerentes: Boolean = False): Boolean; {* Somente Operadores Administrativos          *}
    procedure pCriarForm(ClasseForm: TFormClass; NomeForm: TForm);
    function fPesqLanCon(Self      : TForm;                                {* Formulário                                  *}
                         edtCodigo : TCustomEdit;                          {* Edit do Código                              *}
                         edtEmpLan : TCustomEdit;                          {* Edit da Empresa                             *}
                         qryConMvb : TUniQuery;                            {* Query                                       *}
                         Var chrKey: Char;                                 {* Key                                         *}
                         Var arrSel: TConsultasArray;                      {* Array de Consulta                           *}
                         blnConSim : Boolean = True): Boolean;
    function fPesqEventos(Self     : TForm;                           {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                          edtDescri: TEditFocus;                      {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                       {* Query                                       *}
                          Var chrKey: Char;                           {* Key                                         *}
                          Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                          blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                          blnFiltroExiFat: Boolean = False): Boolean; {* Consulta pesquisará somente eventos que serão exibidos no faturamento *}
    function fRetNomEvento(strCodEve: String): String;
    function fZCreate(Owner: TComponent; strSQL: String = ''): IZClient;
    function fTabelaExiste(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
    function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
    function fEhAdministrador(strCodOpe: String): Boolean;
    procedure pSetaParam(strText: String; arrLinha: TConsultasArray; Var strLinha: String; strNomPar: String; qryRelatorio: TUniQuery);
    function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
    function fRetForFilialTodos(blnLista: Boolean = False): String;
    function fRetClientesFilial: String;
    function fFloatToStrPonto(valor: double; inte,deci: integer): string;
    procedure pDesmarcaLista(edtCodigo: TCustomEdit;
                             Var arrLinha: TConsultasArray;
                             strTempTable: String = '';
                             intTamCamp: Integer = 0);
    function fRetNomeLinhaGrupo(strCodigo: String): String;
    function fPesqGrupo(Self     : TForm;                             {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                       {* Edit do Código                              *}
                        edtDescri: TEditFocus;                        {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                         {* Query                                       *}
                        Var chrKey: Char;                             {* Key                                         *}
                        Var arrSel: TConsultasArray;                  {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                    {* Consulta Simples ou Múltipla (multi select) *}
                        blnDesRes: Boolean = False): Boolean;         {* Mostrar Descricao Resumida(INDUSTRIAL)      *}
    procedure pEdtCodSelectExit(edtCodigo       : TCustomEdit;
                                edtDescri       : TEditFocus;
                            Var arrLinha        : TConsultasArray;
                                fncRetNome      : TfncRetNome;
                                fncRetNomeConst : TfncRetNomeConst;
                                strMsgErr       : String;
                                intTamCamp      : integer = 0;
                                blnNegar: Boolean = False;
                                strCodigo: String  = 'Código');
    function VS_strCodEmp : String;
    function VS_strClaCom : String;
    function VS_strClaVen : String;
    function VS_strClaDev : String;
    function strLoginUsuarioLogado : String;
    function VS_Date : TDateTime;
    function fGerarRelatorioExcel(cxgDados : TcxGridDBTableView; strTitulo : String): Boolean;
    procedure pObservacoes(strCaptionTela, strCaptionMensagem, strTexto: String);
    function Conexao: TUniConnection;
    function VS_stlTabNre: TStringList;
    function fRetornaNomeTabela(strString: String): String;
    function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
    function fGravaLogBco(strComand: String): Boolean;
    function fGravaLogRep(strComand, strTabela, strCarreg: String): Boolean;
    function fTabelaReplica(strNomTabela: String): Boolean;
    function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
  end;

implementation

end.
