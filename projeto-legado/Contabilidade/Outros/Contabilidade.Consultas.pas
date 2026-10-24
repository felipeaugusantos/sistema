unit Contabilidade.Consultas;

interface

uses Forms, Uni, untTypesSistema, EditFocus, Vcl.StdCtrls, MaskEditFocus,
     untClassPanelCx, cxGridCustomTableView, untConsultas, Contabilidade.Interfaces;

function fPesqPlanoContabil(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                            strTplAco: String = ''): Boolean; overload;

function fPesqPlanoContabil(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean;                  {* Consulta Simples ou Múltipla (multi select) *}
                            strTplAco: String;
                            blnExibirSinteticas: boolean;
                            strAjuLiq: string = '';
                            blnNatAju: boolean = False;
                            strTipMov: string = '';
                            strNatAjuLacs: string = '';
                            strNatAjuLalur: string = ''): Boolean; overload;

function fPesqPlanoContabil(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean;                  {* Consulta Simples ou Múltipla (multi select) *}
                            strTplAco: String;
                            blnExibirSinteticas: boolean;
                            blnModoRelatorio: boolean;
                            strAjuLiq: string = '';
                            blnNatAju: boolean = False;
                            strTipMov: string = '';
                            strNatAjuLacs: string = '';
                            strNatAjuLalur: string = '';
                            strPatrim: string = '';
                            blnApenasSubconta: boolean = False;
                            blnApenasSintetica: boolean = False): Boolean; overload;


function fPesqPlanoContabilEcf(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                            strTplAco: String = '';
                            blnCodRefIsNull: boolean = False): Boolean;

function fPesqHistoricoPadrao(Self     : TForm;                    {* Formulário                                  *}
                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                              edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                {* Query                                       *}
                              Var chrKey: Char;                    {* Key                                         *}
                              Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                              blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                              strCodEmp: string = '';              {* Código da empresa, utilizado quando CFG_HISTPL habiltiada, se vazio usa empresa logada *}
                              strHisTpl: string = ''): Boolean;    {* Cfg Histpl (valor em edição na tela de configurações)*}

function fPesqClientesCont(ASelf     : TForm;                    {* Formulário                                  *}
                           AedtCodigo: TCustomEdit;              {* Edit do Código                              *}
                           AedtDescri: TEditFocus;               {* Edit da Descrição                           *}
                           AqryTabela: TUniQuery;                {* Query                                       *}
                           Var AchrKey: Char;                    {* Key                                         *}
                           Var AarrSel: TConsultasArray;         {* Array de Seleção                            *}
                           AblnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqFornecedoresCont(ASelf     : TForm;                    {* Formulário                                  *}
                               AedtCodigo: TCustomEdit;              {* Edit do Código                              *}
                               AedtDescri: TEditFocus;               {* Edit da Descrição                           *}
                               AqryTabela: TUniQuery;                {* Query                                       *}
                               Var AchrKey: Char;                    {* Key                                         *}
                               Var AarrSel: TConsultasArray;         {* Array de Seleção                            *}
                               AblnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqNotasExplicativas(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                var chrKey: Char;                    {* Key                                         *}
                                blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqLanCon(Self      : TForm;                                {* Formulário                                  *}
                     edtCodigo : TCustomEdit;                          {* Edit do Código                              *}
                     edtEmpLan : TCustomEdit;                          {* Edit da Empresa                             *}
                     qryConMvb : TUniQuery;                            {* Query                                       *}
                     Var chrKey: Char;                                 {* Key                                         *}
                     Var arrSel: TConsultasArray;                      {* Array de Consulta                           *}
                     Var TipoPesquisa: TPesquisaLancamentoContabil ;   {* Tipo Pesquisa lancon/lote/lote lançado      *}
                     blnConSim : Boolean = True): Boolean;

function fPesqTipoDePlanoDeContaContabil(Self     : TForm;                    {* Formulário                                  *}
                                         edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                         edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                         qryTabela: TUniQuery;                {* Query                                       *}
                                         Var chrKey: Char;                    {* Key                                         *}
                                         Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                         blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqLancamentosPeriodicos(Self     : TForm;                    {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                    edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                    qryTabela: TUniQuery;                {* Query                                       *}
                                    Var chrKey: Char;                    {* Key                                         *}
                                    Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                    blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqSignatarios(Self     : TForm;                      {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                          edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                  {* Query                                       *}
                          Var chrKey: Char;                      {* Key                                         *}
                          Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                          blnConSim: Boolean = True):Boolean;    {* Consulta Simples ou Múltipla (multi select) *}

function fPesqCadDefDRE(Self     : TForm;                          {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                        edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                      {* Query                                       *}
                        Var chrKey: Char;                          {* Key                                         *}
                        Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulos: string = ''): Boolean;         {* Título S/N (Vazio = todos)                  *}

function fPesqAbreviacaoContabilProdutos(Self     : TForm;                          {* Formulário                                  *}
                                         edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                                         edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                                         qryTabela: TUniQuery;                      {* Query                                       *}
                                         Var chrKey: Char;                          {* Key                                         *}
                                         Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                                         blnConSim: Boolean = True): Boolean;       {* Consulta Simples                            *}

function fPesqInscricoesCadastrais(Self     : TForm;                    {* Formulário                                  *}
                                   edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                   edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                   qryTabela: TUniQuery;                {* Query                                       *}
                                   Var chrKey: Char;                    {* Key                                         *}
                                   Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                   blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqLotContabil(Self     : TForm;                    {* Formulário                                  *}
                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                          qryTabela: TUniQuery;                {* Query                                       *}
                          Var chrKey: Char;                    {* Key                                         *}
                                   Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                   blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqNaturezaDosAjustes(Self     : TForm;                    {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                 edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                {* Query                                       *}
                                 Var chrKey: Char;                    {* Key                                         *}
                                 Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                 strTipo: Char = 'T';                 {* [A]dição [E]xclusão [C]ompensação [T]odos   *}
                                 blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqTipoDaTabelaDinamicaDoEcf(Self     : TForm;                    {* Formulário                                  *}
                                        edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                        edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                        qryTabela: TUniQuery;                {* Query                                       *}
                                        Var chrKey: Char;                    {* Key                                         *}
                                        Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                        blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqHistoricoDosLancamentos(Self     : TForm;                    {* Formulário                                  *}
                                      edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                      edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                      qryTabela: TUniQuery;                {* Query                                       *}
                                      Var chrKey: Char;                    {* Key                                         *}
                                      Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                      blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqPlanoPreferencial(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqECFDemonstrativo(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                                strBloco: String = '';               {* Bloco ECF *}
                                strRegistro: String = '';            {* Registro ECF *}
                                strTipo: String = '';                {* Tipo Registro ECF *}
                                strTipoLan: String = ''              {* Tipo Lançamento Registro ECF *}
                                ): Boolean;

function fPesqECFPadraoRFBParteB(Self     : TForm;                    {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                 edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                {* Query                                       *}
                                 Var chrKey: Char;                    {* Key                                         *}
                                 Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                 blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                                 strTributo: String = ''              {* Tributo ECF *}
                                ): Boolean;

function fPesqContaControlada(Self     : TForm;                    {* Formulário                                  *}
                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                              edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                {* Query                                       *}
                              Var chrKey: Char;                    {* Key                                         *}
                              Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                              blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                              llTipo: TLacsLalur = llNada;         {* Lalur/lacs *}
                              strVinculoTbDinamicaPtB: string = ''): Boolean; {* vinculo tabela dinamica Lalur/lacs *}

function fPesqTransferenciaSaldosPlanoContasAnterior(Self     : TForm;                    {* Formulário                                  *}
                                                     qryTabela: TUniQuery;                {* Query                                       *}
                                                     Var chrKey: Char;                    {* Key                                         *}
                                                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fCampoTabelaPlanco(strCampo : String;
                            arrCampoChave: Array Of String;
                            arrValorChave: Array Of Variant;
                            blnSempreLerBanco: Boolean = True;
                            strOrderBy: String = ''):Variant ;

function fPesqDemonstracaoFluxoCaixa(Self     : TForm;                    {* Formulário                                  *}
                                     edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                     edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                     qryTabela: TUniQuery;                {* Query                                       *}
                                     Var chrKey: Char;                    {* Key                                         *}
                                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                     blnConSim: Boolean): Boolean;

function fPesqNotaExplicativaV2(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean;
                                intExercicio: integer=0): Boolean;

function fPesqDemonstracaoResultadoAbrangente(Self     : TForm;                    {* Formulário                                  *}
                                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                              edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                              qryTabela: TUniQuery;                {* Query                                       *}
                                              Var chrKey: Char;                    {* Key                                         *}
                                              Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                              blnConSim: Boolean): Boolean;

function fPesqDemonstracaoValorAdicionado(Self     : TForm;                    {* Formulário                                  *}
                                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                          edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                          qryTabela: TUniQuery;                {* Query                                       *}
                                          Var chrKey: Char;                    {* Key                                         *}
                                          Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                          blnConSim: Boolean): Boolean;

function fPesqDemonstracaoMutacaoPatrimonioLiquido(Self     : TForm;                    {* Formulário                                  *}
                                                   edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                                   edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                                   qryTabela: TUniQuery;                {* Query                                       *}
                                                   Var chrKey: Char;                    {* Key                                         *}
                                                   Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                   blnConSim: Boolean): Boolean;

function fPesqDemonstracaoMutacaoPatrimonioLiquidoNtExpl(Self     : TForm;                    {* Formulário                                  *}
                                                         edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                                         edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                                         qryTabela: TUniQuery;                {* Query                                       *}
                                                         Var chrKey: Char;                    {* Key                                         *}
                                                         Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                         blnConSim: Boolean): Boolean;

function fPesqDemonstracaoMutacaoPatrimonioLiquidoMovimentacao(Self     : TForm;                    {* Formulário                                  *}
                                                               edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                                               edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                                               qryTabela: TUniQuery;                {* Query                                       *}
                                                               Var chrKey: Char;                    {* Key                                         *}
                                                               Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                               blnConSim: Boolean): Boolean;

function fPesqHistoricoMovimentacao(Self     : TForm;                    {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                    edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                    qryTabela: TUniQuery;                {* Query                                       *}
                                    Var chrKey: Char;                    {* Key                                         *}
                                    Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                    blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqNaturezaJuridica(Self     : TForm;                    {* Formulário                                  *}
                               edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                               edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                {* Query                                       *}
                               Var chrKey: Char;                    {* Key                                         *}
                               Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                               blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqCentroCustoContabil(Self     : TForm;                     {* Formulário                                         *}
                          edtCodigo: TCustomEdit;               {* Edit do Código                                     *}
                          edtDescri: TEditFocus;                {* Edit da Descrição                                  *}
                          qryTabela: TUniQuery;                   {* Query                                              *}
                          Var chrKey: Char;                     {* Key                                                *}
                          Var arrSel: TConsultasArray;          {* Array de Seleção                                   *}
                          blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select)        *}
                          blnUsaCtf: Boolean = False;           {* Só mostra os Plano de Contas vinculados do CADFOR *}
                          strCodFor: String  = ''): Boolean;    {* Código da empresa se blnUsaCtf = True              *}

function fPesqTipoImobilizado(Self: TForm;                            {* Formulario                                  *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                              edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                   {* Query                                       *}
                              Var chrKey: Char;                       {* Key                                         *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                               blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}

function fPesqExercicioLucroPresumido(Self     : TForm;                    {* Formulário                                  *}
                                      edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                      edtCodEmp: TCustomEdit;              {* Edit do CodEmp                              *}
                                      qryTabela: TUniQuery;                {* Query                                       *}
                                      Var chrKey: Char;                    {* Key                                         *}
                                      Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                      blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

function fPesqEmpresaComForTri(Self     : TForm;            {* Formulário                                  *}
                               edtCodigo: TCustomEdit;      {* Edit do Código                              *}
                               edtDescri: TEditFocus;       {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;        {* Query                                       *}
                               Var chrKey: Char;            {* Key                                         *}
                               Var arrSel: TConsultasArray; {* Array de Seleção                            *}
                               blnConSim: Boolean = True;   {* Consulta Simples ou Múltipla (multi select) *}
                               strExerci: String = ''): Boolean; {* Exercio Forma Tributação                    *}

implementation

uses untFuncoesSimples, SysUtils, Contabilidade.Funcoes, System.MaskUtils,
data.db, UniClientDataSet, Classes, DBEditFocus ;

Type
  TDefConPlanoContabil = Class(TDefConsulta)
  private
    strMskCon : String;
    procedure pDisplayPlanoContabil(Sender: TcxCustomGridTableItem;
                                    ARecord: TcxCustomGridRecord;
                                    var AText: string);
  public
    constructor Create(arrCampos : TStringArray); reintroduce;
    destructor Destroy; reintroduce;
  end;

  TDefMascaraCentroCusto = Class(TDefConsulta)
  private
    procedure pDisplayCodigo(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string);

  public

    Constructor Create; Reintroduce;
  End;

procedure pHabilitaPeriodoProcBetween(const ADefConsulta : TDefConPlanoContabil) ;
begin
  if not fCampoExiste('CFGCON', 'CFG_PERIOD') then
    ADefConsulta.pIncluiCampoBetween(['CON_DTALAN']) ;
end ;

function fPesqPlanoContabil(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                            strTplAco: String = ''): Boolean;
begin
  Result := fPesqPlanoContabil(Self,
                               edtCodigo,
                               edtDescri,
                               qryTabela,
                               chrKey,
                               arrSel,
                               blnConSim,
                               strTplAco,
                               True,
                               False);
end;

function fPesqPlanoContabil(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean;                  {* Consulta Simples ou Múltipla (multi select) *}
                            strTplAco: String;
                            blnExibirSinteticas: boolean;
                            strAjuLiq: string = '';
                            blnNatAju: boolean = False;
                            strTipMov: string = '';
                            strNatAjuLacs: string = '';
                            strNatAjuLalur: string = ''): Boolean; overload;
begin
  Result := fPesqPlanoContabil(Self,
                               edtCodigo,
                               edtDescri,
                               qryTabela,
                               chrKey,
                               arrSel,
                               blnConSim,
                               strTplAco,
                               blnExibirSinteticas,
                               False,
                               strAjuLiq,
                               blnNatAju,
                               strTipMov,
                               strNatAjuLacs,
                               strNatAjuLalur);
end;

function fPesqPlanoContabil(Self     : TForm;                    {* Formulário                                  *}
                            edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                            edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                            qryTabela: TUniQuery;                {* Query                                       *}
                            Var chrKey: Char;                    {* Key                                         *}
                            Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                            blnConSim: Boolean;                  {* Consulta Simples ou Múltipla (multi select) *}
                            strTplAco: String;
                            blnExibirSinteticas: boolean;
                            blnModoRelatorio: boolean;
                            strAjuLiq: string = '';
                            blnNatAju: boolean = False;
                            strTipMov: string = '';
                            strNatAjuLacs: string = '';
                            strNatAjuLalur: string = '';
                            strPatrim: string = '';
                            blnApenasSubconta: boolean = False;
                            blnApenasSintetica: boolean = False): Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objDefConsultaPlanoContabil: TDefConPlanoContabil;
    strWhere : String;
    LArrCampos : array of string ;
begin
  Result := False;

  if blnApenasSintetica then
    blnExibirSinteticas := True;

  If fEntraCons(chrKey) Then
  Begin

    Try
      if fEmptyStr(strTplAco) then
        strTplAco := fRetTplacoEmpresaLogada ;

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  NCO_CODCON,       ';
      strSQL := strSQL + '  NCO_DESCRI,       ';
      if fCfgCtrnum = 'N' then
      begin
        strSQL := strSQL + '  NCO_CONRED,       ';
      end
      else
      begin
        strSQL := strSQL + '  CAST(NCO_CONRED AS UNSIGNED) AS NCO_CONRED, ';
      end;
      strSQL := strSQL + '  NCO_NATURE,       ';
      if blnNatAju then
      begin
        strSQL := strSQL + '  NAT_DESCRI,       ';
      end;
      if fCfgExpEcd = 'S' then
      begin
        strSQL := strSQL + '  NCO_CTAREF,       ';
        strSQL := strSQL + '  NRE_DESCRI,       ';
      end ;
      strSQL := strSQL + '  PLANCO.AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  PLANCO            ';
      if blnNatAju then
      begin
        strSQL := strSQL + '  INNER JOIN NATAJU ON PLANCO.NCO_NATAJU = NATAJU.NAT_CODIGO ';
      end;
      if fCfgExpEcd = 'S' then
      begin
        strSQL := strSQL + '  LEFT JOIN PLANRE ON PLANCO.NCO_CTAREF = PLANRE.NRE_CODREF ';
      end ;

      strWhere := ' WHERE NCO_TPLACO = ' + strTplAco.QuotedString;

      if blnApenasSubconta then
        strWhere := strWhere + ' AND NCO_SUBCNT = "S" ';

      if (not blnExibirSinteticas) then
      begin
        strWhere := strWhere + ' AND IFNULL(NCO_NATURE,"A") <> "S" ';
      end
      else if fCfgCtntsi = 'N'  then
      begin
        if not blnModoRelatorio then
        begin
           strWhere := strWhere + ' AND IFNULL(NCO_NATURE,"A") = "A" ';
        end ;
      end
      else if blnApenasSintetica then
      begin
        strWhere := strWhere + ' AND IFNULL(NCO_NATURE,"A") = "S" ';
      end;

      objDefConsultaPlanoContabil := TDefConPlanoContabil.Create(['NCO_CODCON']);

      if not fEmptyStr(strAjuLiq) then
      begin
        strWhere := strWhere + ' AND NCO_AJULIQ = ' + fQuotedStr(strAjuLiq) ;
      end;

      if not fEmptyStr(strPatrim) then
      begin
        strWhere := strWhere + ' AND NCO_PATRIM = ' + fQuotedStr(strPatrim) ;
      end;

      if blnNatAju then
      begin
        if not fEmptyStr(strTipMov) then
        begin
          strWhere := strWhere + ' AND NAT_TIPMOV IN (' + strTipMov + ') ' ;
        end;

        if not fEmptyStr(strNatAjuLacs) then
        begin
          strWhere := strWhere + ' AND NAT_GERLAC = ' + fQuotedStr(strNatAjuLacs) ;
        end;

        if not fEmptyStr(strNatAjuLalur) then
        begin
          strWhere := strWhere + ' AND NAT_GERLAL = ' + fQuotedStr(strNatAjuLalur) ;
        end;

        objDefConsultaPlanoContabil.pIncluiSubConsulta('NAT_DESCRI', 'NATAJU.NAT_DESCRI');

        LArrCampos := ['Código',
                       'Descrição',
                       'Conta Reduzida',
                       'Natureza',
                       'Natureza Ajuste'
                      ] ;

      end
      else
      begin
        LArrCampos := ['Código',
                       'Descrição',
                       'Conta Reduzida',
                       'Natureza'
                       ] ;
      end;

      if fCfgExpEcd = 'S' then
      begin
        objDefConsultaPlanoContabil.pIncluiSubConsulta('NRE_DESCRI', 'PLANRE.NRE_DESCRI');

        SetLength(LArrCampos, Length(LArrCampos)+2);
        LArrCampos[High(LArrCampos)-1] := 'Código Conta Referencial' ;
        LArrCampos[High(LArrCampos)] := 'Conta Referencial' ;
      end ;
      SetLength(LArrCampos, Length(LArrCampos)+1);
      LArrCampos[High(LArrCampos)] := 'AUTOINCREM' ;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   LArrCampos,
                   ['NCO_DESCRI','NCO_CODCON'],
                   '',
                   'PLANCO',
                   Self.Name,
                   'Consulta de Plano Contábil',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'NCO_CODCON',
                   objDefConsultaPlanoContabil) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('NCO_CODCON').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('NCO_CODCON').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('NCO_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 20)
            Else
              edtCodigo.Text := fStrZero('0', 20);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      FreeAndNil(objDefConsultaPlanoContabil);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqPlanoContabilEcf(Self     : TForm;                    {* Formulário                                  *}
                               edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                               edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                {* Query                                       *}
                               Var chrKey: Char;                    {* Key                                         *}
                               Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                               blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                               strTplAco: String = '';
                               blnCodRefIsNull: boolean = False) : Boolean;
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objDefConsultaPlanoContabil: TDefConPlanoContabil;
    strWhere : String;
    LStrTplaco : string;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      if fEmptyStr(strTplAco) then
      begin
        LStrTplaco := fRetTplacoEmpresaLogada ;
      end
      else
      begin
        LStrTplaco := strTplAco ;
      end;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  NCO_CODCON,       ';
      strSQL := strSQL + '  NCO_DESCRI,       ';
      if fCfgCtrnum = 'N' then
      begin
        strSQL := strSQL + '  NCO_CONRED,       ';
      end
      else
      begin
        strSQL := strSQL + '  CAST(NCO_CONRED AS UNSIGNED) AS NCO_CONRED, ';
      end;
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  PLANCO            ';

      strWhere := ' WHERE TRUE ';
      strWhere := strWhere + ' AND NCO_TPLACO = ' + LStrTplaco.QuotedString;

      if blnCodRefIsNull then
        strWhere := strWhere + ' AND NCO_CTAREF IS NULL ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objDefConsultaPlanoContabil := TDefConPlanoContabil.Create(['NCO_CODCON']);

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'Conta Reduzida',
                   'AUTOINCREM'],
                   ['NCO_DESCRI','NCO_CODCON'],
                   '',
                   'PLANCO',
                   Self.Name,
                   'Consulta de Plano Contábil',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'NCO_CODCON',
                   objDefConsultaPlanoContabil) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('NCO_CODCON').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('NCO_CODCON').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('NCO_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 20)
            Else
              edtCodigo.Text := fStrZero('0', 20);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      FreeAndNil(objDefConsultaPlanoContabil);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqHistoricoPadrao(Self     : TForm;                    {* Formulário                                  *}
                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                              edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                {* Query                                       *}
                              Var chrKey: Char;                    {* Key                                         *}
                              Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                              blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                              strCodEmp: string = '';              {* Código da empresa, utilizado quando CFG_HISTPL habiltiada, se vazio usa empresa logada *}
                              strHisTpl: string = ''): Boolean;    {* Cfg Histpl (valor em edição na tela de configurações)*}
  Var
    strSQL, strWhere    : String;
    LstrCodEmp: string;
    LblnHisTpl: Boolean;
    qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  PAD_CODIGO,       ';
      strSQL := strSQL + '  PAD_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  HISPAD            ';

      LstrCodEmp := strCodEmp.Trim;
      if LstrCodEmp.IsEmpty then
        LstrCodEmp := VS_strCodEmp;

      if (not strHisTpl.IsEmpty) and (LstrCodEmp = VS_strCodEmp) then
        LblnHisTpl := strHisTpl.Equals('S')
      else
        LblnHisTpl := fCfgHisTpl;

      if LblnHisTpl then
        strWhere := ' WHERE PAD_TPLACO = ' + QuotedStr(fRetTplacoEmpresaLogada(LstrCodEmp))
      else
        strWhere := ' WHERE IFNULL(PAD_TPLACO, "") = "" ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['PAD_DESCRI','PAD_CODIGO'],
                   '',
                   'HISPAD',
                   Self.Name,
                   'Consulta de Histórico Padrão',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'PAD_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('PAD_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('PAD_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('PAD_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqExercicioLucroPresumido(Self     : TForm;                    {* Formulário                                  *}
                                      edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                      edtCodEmp: TCustomEdit;              {* Edit do CodEmp                              *}
                                      qryTabela: TUniQuery;                {* Query                                       *}
                                      Var chrKey: Char;                    {* Key                                         *}
                                      Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                      blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE       ';
      strSQL := strSQL + '  APG_EXERCI,             ';
      strSQL := strSQL + '  APG_CODEMP,             ';
      strSQL := strSQL + '  EMP_NOMEMP,             ';
      strSQL := strSQL + '  APCSLG.AUTOINCREM       ';
      strSQL := strSQL + 'FROM                      ';
      strSQL := strSQL + '  APCSLG                  ';
      strSQL := strSQL + 'INNER JOIN CADEMP ON      ';
      strSQL := strSQL + '  EMP_CODEMP = APG_CODEMP ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Ano Exercício','Cód. Empresa', 'Empresa', 'AUTOINCREM'],
                   ['APG_EXERCI','APG_CODEMP','EMP_NOMEMP', 'AUTOINCREM'],
                   '',
                   'APCSLG',
                   Self.Name,
                   'Consulta de Ano Exercício do Imposto de Renda',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('APG_EXERCI').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('APG_EXERCI').AsString;
        End;

        If Assigned(edtCodEmp) Then
          edtCodEmp.Text := qryConsulta.FieldByName('APG_CODEMP').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := ''
            Else
              edtCodigo.Text := ''
          End;

          If Assigned(edtCodEmp) Then
            edtCodEmp.Text := '';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqClientesCont(ASelf     : TForm;                    {* Formulário                                  *}
                           AedtCodigo: TCustomEdit;              {* Edit do Código                              *}
                           AedtDescri: TEditFocus;               {* Edit da Descrição                           *}
                           AqryTabela: TUniQuery;                {* Query                                       *}
                           Var AchrKey: Char;                    {* Key                                         *}
                           Var AarrSel: TConsultasArray;         {* Array de Seleção                            *}
                           AblnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
Var
  LstrSQL     : String;
  LqryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(AchrKey) Then
  Begin

    Try

      AchrKey := #0;

      LstrSQL := '';
      LstrSQL := LstrSQL + 'SELECT SQL_NO_CACHE ';
      LstrSQL := LstrSQL + '  CLI_CODCLI,       ';
      LstrSQL := LstrSQL + '  CLI_NOMCLI,       ';
      LstrSQL := LstrSQL + '  AUTOINCREM        ';
      LstrSQL := LstrSQL + 'FROM                ';
      LstrSQL := LstrSQL + '  CADCLI            ';

      If Not Assigned(AqryTabela) Then
        LqryConsulta := fCriaQuery(Nil)
      Else
        LqryConsulta := AqryTabela;

      If fConsulta([LstrSQL],
                  ['Código',
                   'Nome',
                   'AUTOINCREM'],
                   ['CLI_NOMCLI','CLI_CODCLI'],
                   '',
                   'CADCLI',
                   ASelf.Name,
                   'Consulta de Clientes',
                   LqryConsulta,
                   Nil,
                   AblnConSim,
                   AarrSel,
                   'CLI_CODCLI') Then
      Begin

        If Assigned(AedtCodigo) then
        Begin
          If (AedtCodigo Is TMaskEditFocus) Then
            (AedtCodigo As TMaskEditFocus).Text := LqryConsulta.FieldByName('CLI_CODCLI').AsString
          Else
            AedtCodigo.Text := LqryConsulta.FieldByName('CLI_CODCLI').AsString;
        End;

        If Assigned(AedtDescri) Then
          AedtDescri.Text := LqryConsulta.FieldByName('CLI_NOMCLI').AsString;

        If (Length(AarrSel) > 1) Then
        Begin

          If Assigned(AedtCodigo) then
          Begin
            If (AedtCodigo Is TMaskEditFocus) Then
              (AedtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              AedtCodigo.Text := fStrZero('0', 8);
          End;

          If Assigned(AedtDescri) Then
            AedtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(AqryTabela) Then
          FreeAndNil(LqryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqFornecedoresCont(ASelf     : TForm;                    {* Formulário                                  *}
                               AedtCodigo: TCustomEdit;              {* Edit do Código                              *}
                               AedtDescri: TEditFocus;               {* Edit da Descrição                           *}
                               AqryTabela: TUniQuery;                {* Query                                       *}
                               Var AchrKey: Char;                    {* Key                                         *}
                               Var AarrSel: TConsultasArray;         {* Array de Seleção                            *}
                               AblnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
Var
  LstrSQL     : String;
  LqryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(AchrKey) Then
  Begin

    Try

      AchrKey := #0;

      LstrSQL := '';
      LstrSQL := LstrSQL + 'SELECT SQL_NO_CACHE ';
      LstrSQL := LstrSQL + '  FOR_CODFOR,       ';
      LstrSQL := LstrSQL + '  FOR_NOMFOR,       ';
      LstrSQL := LstrSQL + '  FOR_NOMFAN,       ';
      LstrSQL := LstrSQL + '  AUTOINCREM        ';
      LstrSQL := LstrSQL + 'FROM                ';
      LstrSQL := LstrSQL + '  CADFOR            ';

      If Not Assigned(AqryTabela) Then
        LqryConsulta := fCriaQuery(Nil)
      Else
        LqryConsulta := AqryTabela;

      If fConsulta([LstrSQL],
                  ['Código',
                   'Razão Social',
                   'Nome Fantasia',
                   'AUTOINCREM'],
                   ['FOR_CODFOR','FOR_NOMFOR', 'FOR_NOMFAN'],
                   '',
                   'CADFOR',
                   ASelf.Name,
                   'Consulta de Fornecedores',
                   LqryConsulta,
                   Nil,
                   AblnConSim,
                   AarrSel,
                   'FOR_CODFOR') Then
      Begin

        If Assigned(AedtCodigo) then
        Begin
          If (AedtCodigo Is TMaskEditFocus) Then
            (AedtCodigo As TMaskEditFocus).Text := LqryConsulta.FieldByName('FOR_CODFOR').AsString
          Else
            AedtCodigo.Text := LqryConsulta.FieldByName('FOR_CODFOR').AsString;
        End;

        If Assigned(AedtDescri) Then
          AedtDescri.Text := LqryConsulta.FieldByName('FOR_NOMFAN').AsString;

        If (Length(AarrSel) > 1) Then
        Begin

          If Assigned(AedtCodigo) then
          Begin
            If (AedtCodigo Is TMaskEditFocus) Then
              (AedtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              AedtCodigo.Text := fStrZero('0', 8);
          End;

          If Assigned(AedtDescri) Then
            AedtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(AqryTabela) Then
          FreeAndNil(LqryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqNotasExplicativas(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                var chrKey: Char;                    {* Key                                         *}
                                blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
    arrSel : TConsultasArray;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  EXP_DTAINI,       ';
      strSQL := strSQL + '  EXP_DTAFIN,       ';
      strSQL := strSQL + '  EXP_CODCON,       ';
      strSQL := strSQL + '  EXP_NOTEXP,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  NOTEXP            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('EXP_NOTEXP', 'REPLACE(EXP_NOTEXP,"<<csq>>"," ")');

      If fConsulta([strSQL],
                  ['Data Inicial da Apuração',
                   'Data Final da Apuração',
                   'Código da Conta',
                   'Nota Explicativa',
                   'AUTOINCREM'],
                   ['EXP_DTAFIN'],
                   '',
                   'NOTEXP',
                   Self.Name,
                   'Consulta de Notas Explicativas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('AUTOINCREM').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('AUTOINCREM').AsString;
        End;

        Result := True;
      End;

      FreeAndNil(objConsulta);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fProcuraNoFiltro(const AarrFiltros: array of string; const AstrFiltro: string):boolean ;
var
  LintCnt: integer ;
  LblnAchou: boolean ;
begin
  LblnAchou := False ;
  for LintCnt := Low(AarrFiltros) to High(AarrFiltros) do
  begin
    if pos(AarrFiltros[LintCnt], AstrFiltro) > 0  then
    begin
      LblnAchou := True ;
      break ;
    end;
  end;
  Result := LblnAchou ;
end;

function fRemoveFiltroSubCosulta(const AarrFiltros: array of string; const AstrFiltro: string):string ;
var
  LlstLista: TStringList ;
  LstrAux: string ;
  LintCnt: integer;
  LstrRetorno: string ;
begin
  result := AstrFiltro ;

  if Length(AarrFiltros) = 0 then
  begin
    exit ;
  end;

  LstrAux := StringReplace(AstrFiltro, ' AND ', '|', [rfReplaceAll]) ;
  LstrRetorno := '' ;
  LlstLista := TStringList.Create() ;
  try
    LlstLista.Delimiter := '|' ;
    LlstLista.StrictDelimiter := True ;
    LlstLista.DelimitedText := LstrAux ;
    for LintCnt := 0 to LlstLista.Count-1 do
    begin
      if fProcuraNoFiltro(AarrFiltros, LlstLista[LintCnt]) then
      begin
        continue ;
      end;

      if fEmptyStr(LstrRetorno) then
      begin
        LstrRetorno := trim(LlstLista[LintCnt]) ;
      end
      else
      begin
        LstrRetorno := LstrRetorno + ' AND ' + trim(LlstLista[LintCnt]) ;
      end;

    end;

    if fEmptyStr(LstrRetorno) then
    begin
      LstrRetorno := 'TRUE' ;
    end;

    result := LstrRetorno ;
  finally
    FreeAndNil(LlstLista) ;
  end;
end;

procedure pAjustaFiltroUnionPesqLanCon(Var strParamPorReferencia1: String; strParamPorValor1: String; cdsConsulta: TUniClientDataSet);
var
  LstrFiltroLancon: string ;
  LstrFiltroLo2lan: string ;
begin
  if fEmptyStr(strParamPorValor1) then
  begin
    LstrFiltroLancon := ' FALSE ' ;
    LstrFiltroLo2lan := ' FALSE ' ;
  end
  else
  begin
    LstrFiltroLancon := fRemoveFiltroSubCosulta(['DES_CONCRE', 'DES_CONDEB', 'LOTLAN', 'CON_INCDOC'], strParamPorValor1 ) ;
    LstrFiltroLo2lan := StringReplace(LstrFiltroLancon, 'CON_', 'LAN_', [rfReplaceAll]) ;
  end;

  strParamPorReferencia1 := StringReplace(strParamPorReferencia1, '<<FILTRO_LANCON_UNION>>', LstrFiltroLancon, [rfReplaceAll]);
  strParamPorReferencia1 := StringReplace(strParamPorReferencia1, '<<FILTRO_LO2LAN_UNION>>', LstrFiltroLo2lan, [rfReplaceAll]);

end;

function fPesqLanCon(Self      : TForm;                                {* Formulário                                  *}
                     edtCodigo : TCustomEdit;                          {* Edit do Código                              *}
                     edtEmpLan : TCustomEdit;                          {* Edit da Empresa                             *}
                     qryConMvb : TUniQuery;                            {* Query                                       *}
                     Var chrKey: Char;                                 {* Key                                         *}
                     Var arrSel: TConsultasArray;                      {* Array de Consulta                           *}
                     Var TipoPesquisa: TPesquisaLancamentoContabil ;   {* Tipo Pesquisa lancon/lote/lote lançado      *}
                     blnConSim : Boolean = True): Boolean;

  Var
    arrTitCol  : TColunasArray;
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConPlanoContabil;
    blnLoteNovo : boolean;
    LAutoInc : string ;
    LLote: string ;
    LStrAutoIncRetorno: string ;
    LStrTipo: string ;
    LStrEmpLan: string ;
    LblnCON_PAGAME: boolean ;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  blnLoteNovo := fTabelaExiste('LO2LAN') ;
  LblnCON_PAGAME := fCampoExiste('LANCON', 'CON_PAGAME');

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   CON_EMPLAN, '; pAddNomeColuna('Empresa de Lançamento');
      strSQL := strSQL + '   CON_DTALAN, '; pAddNomeColuna('Data Lançamento');
      strSQL := strSQL + '   CON_CONDEB, '; pAddNomeColuna('Conta Débito');
      strSQL := strSQL + '   DES_CONDEB, '; pAddNomeColuna('Descrição Conta Débito');
      strSQL := strSQL + '   CON_CONCRE, '; pAddNomeColuna('Conta Crédito');
      strSQL := strSQL + '   DES_CONCRE, '; pAddNomeColuna('Descrição Conta Crédito');
      strSQL := strSQL + '   CON_VALLAN, '; pAddNomeColuna('Valor');
      strSQL := strSQL + '   CON_HISTOR, '; pAddNomeColuna('Histórico');
      strSQL := strSQL + '   CON_TIPLAN, '; pAddNomeColuna('Tipo Lançamento');
      strSQL := strSQL + '   CON_INCDOC, '; pAddNomeColuna('Chave Lançamento');
      if blnLoteNovo then
      begin
        strSQL := strSQL + '   LAN_NUMLOT, '; pAddNomeColuna('Número Lote');
        strSQL := strSQL + '   LOTLAN,     '; pAddNomeColuna('Lote Lançado?');
      end ;
      if LblnCON_PAGAME then
      begin
        strSQL := strSQL + '   CON_PAGAME,     '; pAddNomeColuna('Pagamentos');
      end ;
      strSQL := strSQL + '   L.AUTOINCREM ';
      strSQL := strSQL + ' FROM ( ';
      strSQL := strSQL + ' 	SELECT L.CON_EMPLAN, ';
      strSQL := strSQL + ' 		L.CON_DTALAN, ';
      strSQL := strSQL + ' 		L.CON_CONCRE, ';
      strSQL := strSQL + ' 		L.CON_CONDEB, ';
      strSQL := strSQL + ' 		L.CON_VALLAN, ';
      strSQL := strSQL + ' 		L.CON_TIPLAN, ';
      strSQL := strSQL + ' 		LO2LAN.LAN_NUMLOT, ';
      strSQL := strSQL + ' 		L.CON_HISPAD, ';
      strSQL := strSQL + ' 		CAST(CASE WHEN LO2LAN.LAN_CODLAN IS NULL THEN NULL ELSE "S" END AS CHAR(1)) AS LOTLAN, ';
      strSQL := strSQL + ' 		REPLACE(UPPER(COALESCE(CON_HISTOR,"")), "<<CSQ>>", "") AS CON_HISTOR, ';
      strSQL := strSQL + ' 		L.CON_INCDOC, ';
      if LblnCON_PAGAME then
      begin
        strSQL := strSQL + '   L.CON_PAGAME, ';
      end ;
      strSQL := strSQL + ' 		CAST(CONCAT(L.AUTOINCREM,"A") AS CHAR(21)) AS AUTOINCREM ';
      strSQL := strSQL + ' 	   FROM LANCON L ';
      strSQL := strSQL + '      INNER JOIN CADEMP E  ON L.CON_EMPLAN = E.EMP_CODEMP ';
      if blnLoteNovo then
      begin
        strSQL := strSQL + ' 	    LEFT JOIN LO2LAN ON L.AUTOINCREM = LO2LAN.LAN_CODLAN ';
      end ;
      strSQL := strSQL + '      LEFT JOIN HISPAD ON L.CON_HISPAD = HISPAD.PAD_CODIGO ';
      if fCfgHisTpl then
        strSQL := strSQL + ' AND HISPAD.PAD_TPLACO = E.EMP_TPLACO '
      else
        strSQL := strSQL + ' AND IFNULL(HISPAD.PAD_TPLACO, "") = "" ';


      strSQL := strSQL + '      LEFT JOIN PLANCO CONCRE ON L.CON_CONCRE = CONCRE.NCO_CODCON AND CONCRE.NCO_TPLACO = E.EMP_TPLACO ';
      strSQL := strSQL + '      LEFT JOIN PLANCO CONDEB ON L.CON_CONDEB = CONDEB.NCO_CODCON AND CONDEB.NCO_TPLACO = E.EMP_TPLACO ';

      strSQL := strSQL + '      WHERE <<FILTRO_LANCON_UNION>> ';
      if blnLoteNovo then
      begin
        strSQL := strSQL + ' 	UNION ALL ';
        strSQL := strSQL + ' 	SELECT LAN_EMPLAN AS CON_EMPLAN, ';
        strSQL := strSQL + ' 	       LAN_DTALAN AS CON_DTALAN, ';
        strSQL := strSQL + ' 	       LAN_CONCRE AS CON_CONCRE, ';
        strSQL := strSQL + ' 	       LAN_CONDEB AS CON_CONDEB, ';
        strSQL := strSQL + ' 	       LAN_VALLAN AS CON_VALLAN, ';
        strSQL := strSQL + ' 	       LAN_TIPLAN AS CON_TIPLAN, ';
        strSQL := strSQL + ' 	       LAN_NUMLOT, ';
        strSQL := strSQL + ' 	       LAN_HISPAD AS CON_HISPAD, ';
        strSQL := strSQL + ' 	       CAST("N" AS CHAR(1)) AS LOTLAN, ';
        strSQL := strSQL + ' 	       LAN_HISTOR AS CON_HISTOR, ';
        strSQL := strSQL + ' 	       CAST(NULL AS CHAR(20)) AS CON_INCDOC, ';
        if LblnCON_PAGAME then
        begin
          strSQL := strSQL + '       CAST(NULL AS CHAR(30)) AS CON_PAGAME, ';
        end ;
        strSQL := strSQL + ' 	       CAST(CONCAT(L.AUTOINCREM,"B") AS CHAR(21)) AS AUTOINCREM ';
        strSQL := strSQL + ' 	   FROM LO2LAN L ';

        strSQL := strSQL + '      INNER JOIN CADEMP E  ON L.LAN_EMPLAN = E.EMP_CODEMP ';
        strSQL := strSQL + '      LEFT JOIN PLANCO CONCRE ON L.LAN_CONCRE = CONCRE.NCO_CODCON AND CONCRE.NCO_TPLACO = E.EMP_TPLACO ';
        strSQL := strSQL + '      LEFT JOIN PLANCO CONDEB ON L.LAN_CONDEB = CONDEB.NCO_CODCON AND CONDEB.NCO_TPLACO = E.EMP_TPLACO ';

        strSQL := strSQL + ' 	WHERE L.LAN_CODLAN IS NULL AND <<FILTRO_LO2LAN_UNION>> ';
      end ;
      strSQL := strSQL + ' ) AS L ';
      strSQL := strSQL + '    INNER JOIN CADEMP E ON L.CON_EMPLAN = E.EMP_CODEMP ';
      strSQL := strSQL + '    LEFT JOIN PLANCO CONCRE ON L.CON_CONCRE = CONCRE.NCO_CODCON AND CONCRE.NCO_TPLACO = E.EMP_TPLACO ';
      strSQL := strSQL + '    LEFT JOIN PLANCO CONDEB ON L.CON_CONDEB = CONDEB.NCO_CODCON AND CONDEB.NCO_TPLACO = E.EMP_TPLACO ';

      If Not Assigned(qryConMvb) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryConMvb;

      objConsulta := TDefConPlanoContabil.Create(['CON_CONCRE', 'CON_CONDEB', 'HISPAD']);
      objConsulta.pIncluiSubConsulta('DES_CONCRE', 'CONCRE.NCO_DESCRI');
      objConsulta.pIncluiSubConsulta('DES_CONDEB', 'CONDEB.NCO_DESCRI');

      pHabilitaPeriodoProcBetween(objConsulta) ;

      objConsulta.BeforeAtualiza := pAjustaFiltroUnionPesqLanCon ;

      If fConsulta([strSQL],
                   arrTitCol,
                   ['CON_EMPLAN','CON_DTALAN'],
                   'AUTOINCREM',
                   'LANCON',
                   Self.Name,
                   'Consulta de Lançamentos Contábeis',
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        if Length(arrSel) = 0 then
        begin
          exit ;
        end ;

        LStrAutoIncRetorno := copy(arrSel[0].strCodigo, 1, length(arrSel[0].strCodigo)-1) ;
        LStrTipo := copy(arrSel[0].strCodigo, length(arrSel[0].strCodigo), 1) ;
        If Assigned(edtCodigo) then
        Begin
          LAutoInc := LStrAutoIncRetorno ;
          if LStrTipo = 'B' then  ///B --> lote pendente
          begin
            TipoPesquisa := plcLote ;
          end
          else //// A --> lancon
          begin
            lLote := fCampoTabela('LAN_NUMLOT', 'LO2LAN', ['LAN_CODLAN'], [LStrAutoIncRetorno]) ;
            if fEmptyStr(lLote) then
            begin
              TipoPesquisa := plcLancon ;
            end
            else
            begin
              TipoPesquisa := plcLoteLancado ;
            end ;
          end ;

          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := LAutoInc
          Else
            edtCodigo.Text := LAutoInc;
        End;

        If Assigned(edtEmpLan) then
        Begin
          if LStrTipo = 'B' then
          begin
            LStrEmpLan := fCampoTabela('LAN_EMPLAN', 'LO2LAN', ['AUTOINCREM'], [LStrAutoIncRetorno]) ;
          end
          else
          begin
            LStrEmpLan := fCampoTabela('CON_EMPLAN', 'LANCON', ['AUTOINCREM'], [LStrAutoIncRetorno]) ;
          end ;

          If (edtEmpLan Is TMaskEditFocus) Then
            (edtEmpLan As TMaskEditFocus).Text := LStrEmpLan
          Else
            edtEmpLan.Text := LStrEmpLan;
        End;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 8)
            Else
              edtCodigo.Text := fStrZero('0', 8);
          End;
        End;
        Result := True;
      End;

      If Not Assigned(qryConMvb) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  End;
End;

function fPesqTipoDePlanoDeContaContabil(Self     : TForm;                    {* Formulário                                  *}
                                         edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                         edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                         qryTabela: TUniQuery;                {* Query                                       *}
                                         Var chrKey: Char;                    {* Key                                         *}
                                         Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                         blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  ACO_CODIGO,       ';
      strSQL := strSQL + '  ACO_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  TPLACO            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['ACO_DESCRI','ACO_CODIGO'],
                   '',
                   'TPLACO',
                   Self.Name,
                   'Consulta de Tipo de Plano de Conta Contábil',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'ACO_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ACO_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ACO_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('ACO_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqLancamentosPeriodicos(Self     : TForm;                    {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                    edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                    qryTabela: TUniQuery;                {* Query                                       *}
                                    Var chrKey: Char;                    {* Key                                         *}
                                    Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                    blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  GER_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  PERGER            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Descrição',
                   'AUTOINCREM'],
                   ['GER_DESCRI'],
                   '',
                   'PERGER',
                   Self.Name,
                   'Consulta de Lançamentos Periódicos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('AUTOINCREM').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('AUTOINCREM').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('GER_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;


function fPesqSignatarios(Self     : TForm;                      {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                {* Edit do Código                              *}
                          edtDescri: TEditFocus;                 {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                  {* Query                                       *}
                          Var chrKey: Char;                      {* Key                                         *}
                          Var arrSel: TConsultasArray;           {* Array de Seleção                            *}
                          blnConSim: Boolean = True):Boolean;    {* Consulta Simples ou Múltipla (multi select) *}
Var
  strSQL,
  strWhere    : String;
  qryConsulta : TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '   CSE_NOMSIG,       ';
      strSQL := strSQL + '   CSE_DOCSIG,       ';
      strSQL := strSQL + '   CSE_DESQUA,       ';
      strSQL := strSQL + '   CSE_CODQUA,       ';
      strSQL := strSQL + '   CSE_NUMCRC,       ';
      strSQL := strSQL + '   CSE_EMASIG,       ';
      strSQL := strSQL + '   CSE_TELSIG,       ';
      strSQL := strSQL + '   CSE_UFEXCR,       ';
      strSQL := strSQL + '   CSE_NUMCER,       ';
      strSQL := strSQL + '   CSE_DTACER,       ';
      strSQL := strSQL + '   CSE_SIGRES,       ';
      strSQL := strSQL + '   CADCSE.AUTOINCREM ';
      strSQL := strSQL + ' FROM CADCSE         ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Nome Signatário',
                   'Documento Signatário',
                   'Qualificação do Assinante',
                   'Código Qualificação',
                   'Número CRC',
                   'E-mail Signatário',
                   'Telefone Signatario',
                   'UF de Expedição',
                   'Número da Certidão',
                   'Data de Validade da Certidão',
                   'Signatário Responsável',
                   'AUTOINCREM'],
                   ['CSE_NOMSIG','CSE_DOCSIG','CSE_DESQUA','CSE_CODQUA','CSE_NUMCRC','CSE_EMASIG','CSE_TELSIG','CSE_UFEXCR','CSE_NUMCER','CSE_DTACER','CSE_SIGRES'],
                   '',
                   'CADCSE',
                   Self.Name,
                   'Consulta de Signatários',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM') Then
      Begin
        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqAbreviacaoContabilProdutos(Self     : TForm;                          {* Formulário                                  *}
                                         edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                                         edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                                         qryTabela: TUniQuery;                      {* Query                                       *}
                                         Var chrKey: Char;                          {* Key                                         *}
                                         Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                                         blnConSim: Boolean = True): Boolean;       {* Consulta Simples                            *}
  Var
    strSQL: String;
    qryConsulta: TUniQuery;
    arrCampos: Array Of String;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  COG_CODIGO,       ';
      strSQL := strSQL + '  COG_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  ABFCOG            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      SetLength(arrCampos, 3);
      arrCampos[0] := 'Código';
      arrCampos[1] := 'Descrição';
      arrCampos[2] := 'AUTOINCREM';

      If fConsulta([strSQL],
                   arrCampos,
                   ['COG_DESCRI','COG_CODIGO'],
                   '',
                   'ABFCOG',
                   Self.Name,
                   'Consulta de Abreviação Contábil Produtos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'COG_CODIGO',
                   Nil) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('COG_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('COG_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('COG_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 12)
            Else
              edtCodigo.Text := fStrZero('0', 12);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  End;
end;

function fPesqCadDefDRE(Self     : TForm;                          {* Formulário                                  *}
                        edtCodigo: TCustomEdit;                    {* Edit do Código                              *}
                        edtDescri: TEditFocus;                     {* Edit da Descrição                           *}
                        qryTabela: TUniQuery;                      {* Query                                       *}
                        Var chrKey: Char;                          {* Key                                         *}
                        Var arrSel: TConsultasArray;               {* Array de Seleção                            *}
                        blnConSim: Boolean = True;                 {* Consulta Simples ou Múltipla (multi select) *}
                        strTitulos: string = ''): Boolean;         {* Título S/N (Vazio = todos)                  *}
  Var
    strSQL: String;
    qryConsulta: TUniQuery;
    arrCampos: Array Of String;
    strWhere : string;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  DRE_CODDRE,       ';
      strSQL := strSQL + '  DRE_DESCRI,       ';
      strSQL := strSQL + '  DRE_TITULO,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADDRE            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      SetLength(arrCampos, 4);
      arrCampos[0] := 'Código';
      arrCampos[1] := 'Descrição';
      arrCampos[2] := 'Título';
      arrCampos[3] := 'AUTOINCREM';

      strWhere := '';

      if not fEmptyStr(strTitulos) then
        strWhere := ' WHERE DRE_TITULO = ' + QuotedStr(strTitulos);

      If fConsulta([strSQL, strWhere],
                   arrCampos,
                   ['DRE_DESCRI','DRE_CODDRE','DRE_TITULO'],
                   '',
                   'CADDRE',
                   Self.Name,
                   'Consulta de Definições DRE',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DRE_CODDRE',
                   Nil) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DRE_CODDRE').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DRE_CODDRE').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('DRE_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 12)
            Else
              edtCodigo.Text := fStrZero('0', 12);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  End;
end;

function fPesqInscricoesCadastrais(Self     : TForm;                    {* Formulário                                  *}
                                   edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                   edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                   qryTabela: TUniQuery;                {* Query                                       *}
                                   Var chrKey: Char;                    {* Key                                         *}
                                   Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                   blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  INS_CODINS,       ';
      strSQL := strSQL + '  INS_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  OUTINS            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['INS_DESCRI','INS_CODINS'],
                   '',
                   'OUTINS',
                   Self.Name,
                   'Consulta de Outras Inscrições',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'INS_CODINS') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('INS_CODINS').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('INS_CODINS').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('INS_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqLotContabil(Self     : TForm;                    {* Formulário                                  *}
                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                          qryTabela: TUniQuery;                {* Query                                       *}
                          Var chrKey: Char;                    {* Key                                         *}
                          Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                          blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  var
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('NROLOTE', 'CONCAT(LEFT(CON_NUMLOT, 6), "-", CAST(SUBSTR(CON_NUMLOT, 7, 24) AS UNSIGNED))');

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  NROLOTE,          ';
      strSQL := strSQL + '  CON_NUMLAN,       ';
      strSQL := strSQL + '  CON_VALPRE,       ';
      strSQL := strSQL + '  CON_CODOPE,       ';
      strSQL := strSQL + '  CON_DTALAN,       ';
      strSQL := strSQL + '  CON_DTAFEC,       ';
      strSQL := strSQL + '  CON_NUMLOT,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  LOTCON            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Lote',
                   'Número de Lançamentos',
                   'Valor Previsto',
                   'Operador',
                   'Data Lançamento',
                   'Data Fechamento',
                   ''],
                   ['CON_NUMLOT','CON_DTALAN'],
                   '',
                   'LOTCON',
                   Self.Name,
                   'Consulta de Lotes Contábeis',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CON_NUMLOT',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CON_NUMLOT').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CON_NUMLOT').AsString;
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqNaturezaDosAjustes(Self     : TForm;                    {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                 edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                {* Query                                       *}
                                 Var chrKey: Char;                    {* Key                                         *}
                                 Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                 strTipo: Char = 'T';                 {* [A]dição [E]xclusão [C]ompensação [T]odos   *}
                                 blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL, strWhere: String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;
{
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  NAT_CODIGO,       ';
      strSQL := strSQL + '  NAT_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  NATAJU            ';
}

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + ' NAT_CODIGO, ';
      strSQL := strSQL + ' NAT_DESCRI, ';
      strSQL := strSQL + ' CASE ';
      strSQL := strSQL + '   WHEN NAT_TIPMOV = "A" THEN "ADIÇÃO" ';
      strSQL := strSQL + '   WHEN NAT_TIPMOV = "E" THEN "EXCLUSÃO" ';
      strSQL := strSQL + '   WHEN NAT_TIPMOV = "C" THEN "COMPENSAÇÃO" ';
      strSQL := strSQL + ' END AS TIPCTA, ';
      strSQL := strSQL + ' NAT_GERLAL, ';
      strSQL := strSQL + ' NAT_GERLAC, ';
      strSQL := strSQL + ' NAT_CODLAL, ';
      strSQL := strSQL + ' DSC_TBDELU, ';
      strSQL := strSQL + ' NAT_CODLAC, ';
      strSQL := strSQL + ' DSC_TBDELA, ';
      strSQL := strSQL + ' NATAJU.AUTOINCREM ';
      strSQL := strSQL + 'FROM NATAJU ';
      strSQL := strSQL + 'LEFT JOIN ECFDEM ECFLALU ON ECFLALU.DEM_CODDEM = NAT_CODLAL AND NAT_BLCLAL = ECFLALU.DEM_BLCECF AND NAT_REGLAL = ECFLALU.DEM_REGECF ';
      strSQL := strSQL + 'LEFT JOIN ECFDEM ECFLACS ON ECFLACS.DEM_CODDEM = NAT_CODLAC AND NAT_BLCLAC = ECFLACS.DEM_BLCECF AND NAT_REGLAC = ECFLACS.DEM_REGECF ';


      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('DSC_TBDELU', 'ECFLALU.DEM_DESCRI');
      objConsulta.pIncluiSubConsulta('DSC_TBDELA', 'ECFLACS.DEM_DESCRI');

      strWhere := '';

      If Not fEmptyStr(strTipo) Then
      Begin
        If strTipo <> 'T' Then
          strWhere := strWhere + ' WHERE NAT_TIPMOV = "'+ strTipo +'" ';
      End;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                  ['Código',
                   'Descrição',
                   'Movimentação',
                   'LALUR',
                   'LACS',
                   'Cód.Tabela LALUR',
                   'Desc.Tabela LALUR',
                   'Cód.Tabela LACS',
                   'Desc.Tabela LACS'],
                   ['NAT_CODIGO','NAT_DESCRI','TIPCTA','NAT_GERLAL','NAT_GERLAC','NAT_CODLAL','DSC_TBDELU','NAT_CODLAC','DSC_TBDELA'],
                   '',
                   'NATAJU',
                   Self.Name,
                   'Consulta de Natureza de Ajustes LALUR/LACS',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'NAT_CODIGO',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('NAT_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('NAT_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('NAT_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqTipoDaTabelaDinamicaDoEcf(Self     : TForm;                    {* Formulário                                  *}
                                        edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                        edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                        qryTabela: TUniQuery;                {* Query                                       *}
                                        Var chrKey: Char;                    {* Key                                         *}
                                        Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                        blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  ECF_CODIGO,       ';
      strSQL := strSQL + '  ECF_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  TABECF            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['ECF_CODIGO','ECF_DESCRI'],
                   '',
                   'TABECF',
                   Self.Name,
                   'Tipo da tabela dinâmica do ECF - LALUR/LACS',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'ECF_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('ECF_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('ECF_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('ECF_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqHistoricoDosLancamentos(Self     : TForm;                    {* Formulário                                  *}
                                      edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                      edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                      qryTabela: TUniQuery;                {* Query                                       *}
                                      Var chrKey: Char;                    {* Key                                         *}
                                      Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                      blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  HIS_CODIGO,       ';
      strSQL := strSQL + '  HIS_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  HISLAN            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição'],
                   ['HIS_CODIGO','HIS_DESCRI'],
                   '',
                   'HISLAN',
                   Self.Name,
                   'Histórico dos lançamentos',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'HIS_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('HIS_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('HIS_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('HIS_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqPlanoPreferencial(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  NRE_CODREF,       ';
      strSQL := strSQL + '  NRE_DESCRI,       ';
      strSQL := strSQL + '  NRE_DTAINI,       ';
      strSQL := strSQL + '  NRE_DTAFIN,       ';
      strSQL := strSQL + '  "" AS AUTOINCREM  ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  PLANRE            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Código',    'Descrição', 'Vigência Inicial', 'Vigência Final'],
                   ['NRE_CODREF','NRE_DESCRI', 'NRE_DTAINI', 'NRE_DTAFIN'],
                   'NRE_CODREF',
                   'PLANRE',
                   Self.Name,
                   'Plano Referencial',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'NRE_CODREF') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('NRE_CODREF').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('NRE_CODREF').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('NRE_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqECFDemonstrativo(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                                strBloco: String = '';               {* Bloco ECF *}
                                strRegistro: String = '';            {* Registro ECF *}
                                strTipo: String = '';                {* Tipo Registro ECF *}
                                strTipoLan: String = ''              {* Tipo Lançamento Registro ECF *}
                                ): Boolean;
Var
  strSQL, strWhere     : String;
  qryConsulta: TUniQuery;
  strCSLL: String ;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;
      strCSLL := fRetDemEcdCSLL(strBloco, strRegistro, strTipo, strTipoLan) ;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  DEM_CODDEM,       ';
      strSQL := strSQL + '  DEM_DESCRI,       ';
      strSQL := strSQL + '  DEM_DTAINI,       ';
      strSQL := strSQL + '  DEM_DTAFIN,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  ECFDEM            ';

      strWhere := '';
      if not fEmptyStr(strBloco) then
        strWhere := strWhere + ' AND DEM_BLCECF = ' + strBloco.QuotedString;

      if not fEmptyStr(strRegistro) then
        strWhere := strWhere + ' AND DEM_REGECF = ' + strRegistro.QuotedString;

      if not fEmptyStr(strTipo) then
        strWhere := strWhere + ' AND DEM_TIPDEM IN (' + strTipo + ') ';

      if not fEmptyStr(strTipoLan) then
        strWhere := strWhere + ' AND DEM_TIPLAN = ' + strTipoLan.QuotedString;

      if not fEmptyStr(strWhere) then
      begin
        strWhere := ' (TRUE ' + strWhere + ') ';
        if not fEmptyStr(strCSLL) then
        begin
          strWhere := strWhere + ' OR AUTOINCREM IN (' + strCSLL + ') '
        end;
        strWhere := ' WHERE (' + strWhere + ') ';
      end;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   ['Código',    'Descrição', 'Vigência Inicial', 'Vigência Final'],
                   ['AUTOINCREM'],
                   'DEM_CODDEM',
                   'ECFDEM',
                   Self.Name,
                   'Demonstrativo ECF',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DEM_CODDEM').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DEM_CODDEM').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('DEM_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqECFPadraoRFBParteB(Self     : TForm;                    {* Formulário                                  *}
                                 edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                 edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                 qryTabela: TUniQuery;                {* Query                                       *}
                                 Var chrKey: Char;                    {* Key                                         *}
                                 Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                 blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                                 strTributo: String = ''              {* Tributo ECF *}
                                ): Boolean;
Var
  strSQL, strWhere     : String;
  qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  LLB_CODIGO,       ';
      strSQL := strSQL + '  LLB_DESCRI,       ';
      strSQL := strSQL + '  LLB_DTAINI,       ';
      strSQL := strSQL + '  LLB_DTAFIN,       ';
      strSQL := strSQL + '  CAST("" AS CHAR(1)) AS AUTOINCREM  ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  ECFLLB            ';

      strWhere := '';
      if not fEmptyStr(strTributo) then
        strWhere := strWhere + ' AND LLB_TRIBUT IN ( ' + strTributo + ') ';

      if not fEmptyStr(strWhere) then
      begin
        strWhere := ' WHERE TRUE ' + strWhere ;
      end;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   ['Código',    'Descrição', 'Vigência Inicial', 'Vigência Final'],
                   ['LLB_CODIGO','LLB_DESCRI', 'LLB_DTAINI', 'LLB_DTAFIN'],
                   'LLB_CODIGO',
                   'ECFLLB',
                   Self.Name,
                   'Tabela Padrão RFB - Parte B',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'LLB_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('LLB_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('LLB_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('LLB_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqContaControlada(Self     : TForm;                    {* Formulário                                  *}
                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                              edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                {* Query                                       *}
                              Var chrKey: Char;                    {* Key                                         *}
                              Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                              blnConSim: Boolean = True;           {* Consulta Simples ou Múltipla (multi select) *}
                              llTipo: TLacsLalur = llNada;          {* Lalur/lacs *}
                              strVinculoTbDinamicaPtB: string = ''): Boolean; {* vinculo tabela dinamica Lalur/lacs *}
  Var
    strSQL, strWhere: String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  CTA_CODCON,       ';
      strSQL := strSQL + '  CTA_DESCRI,       ';
      strSQL := strSQL + '  CTA_GRLALU,       ';
      strSQL := strSQL + '  CTA_GRLACS,       ';
      strSQL := strSQL + '  CTA_TBDELU,       ';
      strSQL := strSQL + '  DSC_TBDELU,       ';
      strSQL := strSQL + '  CTA_TBDBLU,       ';
      strSQL := strSQL + '  DSC_TBDBLU,       ';
      strSQL := strSQL + '  CTA_TBDELA,       ';
      strSQL := strSQL + '  DSC_TBDELA,       ';
      strSQL := strSQL + '  CTA_TBDBLA,       ';
      strSQL := strSQL + '  DSC_TBDBLA,       ';
      strSQL := strSQL + '  CTA_CODEMP,       ';
      strSQL := strSQL + '  CTACON.AUTOINCREM ';
      strSQL := strSQL + 'FROM CTACON         ';
      strSQL := strSQL + 'LEFT JOIN ECFDEM ECFLALU ON ECFLALU.DEM_CODDEM = CTA_TBDELU AND CTA_BLDELU = ECFLALU.DEM_BLCECF AND CTA_RGDELU = ECFLALU.DEM_REGECF ';
      strSQL := strSQL + 'LEFT JOIN ECFLLB TABLALU ON TABLALU.LLB_CODIGO = CTA_TBDBLU ';
      strSQL := strSQL + 'LEFT JOIN ECFDEM ECFLACS ON ECFLACS.DEM_CODDEM = CTA_TBDELA AND CTA_BLDELA = ECFLACS.DEM_BLCECF AND CTA_RGDELA = ECFLACS.DEM_REGECF ';
      strSQL := strSQL + 'LEFT JOIN ECFLLB TABLACS ON TABLACS.LLB_CODIGO = CTA_TBDBLA ';

      strWhere := ' WHERE TRUE ' ;
      if llTipo = llLacs then
      begin
        strWhere := strWhere + ' AND CTACON.CTA_GRLACS = ' + QuotedStr('S');
        if not fEmptyStr(strVinculoTbDinamicaPtB) then
        begin
          strWhere := strWhere + ' AND CTACON.CTA_TBDBLA = ' + QuotedStr(strVinculoTbDinamicaPtB);
        end;
      end
      else if llTipo = llLalur then
      begin
        strWhere := strWhere + ' AND CTACON.CTA_GRLALU = ' + QuotedStr('S');
        if not fEmptyStr(strVinculoTbDinamicaPtB) then
        begin
          strWhere := strWhere + ' AND CTACON.CTA_TBDBLU = ' + QuotedStr(strVinculoTbDinamicaPtB);
        end;
      end;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiSubConsulta('DSC_TBDELU', 'ECFLALU.DEM_DESCRI');
      objConsulta.pIncluiSubConsulta('DSC_TBDBLU', 'TABLALU.LLB_DESCRI');
      objConsulta.pIncluiSubConsulta('DSC_TBDELA', 'ECFLACS.DEM_DESCRI');
      objConsulta.pIncluiSubConsulta('DSC_TBDBLA', 'TABLACS.LLB_DESCRI');

      If fConsulta([strSQL, strWhere],
                   ['Código', 'Descrição', 'LALUR', 'LACS',
                    'Código Tabela LALUR Parte A', 'Descrição Tabela LALUR Parte A',
                    'Código Tabela LALUR Parte B', 'Descrição Tabela LALUR Parte B',
                    'Código Tabela LACS Parte A', 'Descrição Tabela LACS Parte A',
                    'Código Tabela LACS Parte B', 'Descrição Tabela LACS Parte B',
                    'Código Empresa'],
                   ['CTA_CODCON', 'CTA_DESCRI', 'CTA_GRLALU', 'CTA_GRLACS',
                    'CTA_TBDELU', 'CTA_TBDBLU', 'CTA_TBDELA', 'CTA_TBDBLA',
                    'DSC_TBDELU', 'DSC_TBDBLU', 'DSC_TBDELA', 'DSC_TBDBLA',
                    'CTA_CODEMP'],
                   'AUTOINCREM',
                   'CTACON',
                   Self.Name,
                   'Contas Controladas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('CTA_CODCON').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CTA_CODCON').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CTA_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      FreeAndNil(objConsulta);

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqTransferenciaSaldosPlanoContasAnterior(Self     : TForm;                    {* Formulário                                  *}
                                                     qryTabela: TUniQuery;                {* Query                                       *}
                                                     Var chrKey: Char;                    {* Key                                         *}
                                                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                     blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    arrTitCol  : TColunasArray;
    strSQL     : String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConPlanoContabil;
    strWhere : String;

    Procedure pAddNomeColuna(strNomCol: String);
    Begin
      SetLength(arrTitCol, Succ(Length(arrTitCol)));
      arrTitCol[High(arrTitCol)] := strNomCol;
    End;

Begin
  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    chrKey := #0;

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT COA_CODEMP,  '; pAddNomeColuna('Empresa');
      strSQL := strSQL + '        COA_COMPET,  '; pAddNomeColuna('Competência');
      strSQL := strSQL + '        COA_PLAANT,  '; pAddNomeColuna('Conta Anterior');
      strSQL := strSQL + '        COA_PLANOV,  '; pAddNomeColuna('Conta Nova');
      strSQL := strSQL + '        DES_CONNOV,  '; pAddNomeColuna('Descrição Conta Novo');
      strSQL := strSQL + '        COA_VALLAN,  '; pAddNomeColuna('Valor');
      strSQL := strSQL + '        COA_INDSIT,  '; pAddNomeColuna('Situação');
      strSQL := strSQL + '        L.AUTOINCREM ';
      strSQL := strSQL + '   FROM TSPCOA L ';
      strSQL := strSQL + '   INNER JOIN CADEMP E ON L.COA_CODEMP = E.EMP_CODEMP ';
      strSQL := strSQL + '   LEFT JOIN PLANCO CONNOV ON COA_PLANOV = CONNOV.NCO_CODCON AND CONNOV.NCO_TPLACO = E.EMP_TPLACO  ';

      strWhere := '';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      objConsulta := TDefConPlanoContabil.Create(['COA_PLANOV']);
      objConsulta.pIncluiSubConsulta('DES_CONNOV', 'CONNOV.NCO_DESCRI');

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['COA_CODEMP','COA_COMPET'],
                   'AUTOINCREM',
                   'TSPCOA',
                   Self.Name,
                   'Consulta de Transferência de Saldos de Plano de Contas Anterior',
                   qryConsulta,
                   nil,
                   blnConSim,
                   arrSel,
                   'AUTOINCREM',
                   objConsulta) Then
      Begin
        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);

      FreeAndNil(objConsulta);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  End;
end;

function fCampoTabelaPlanco(strCampo : String;
                            arrCampoChave: Array Of String;
                            arrValorChave: Array Of Variant;
                            blnSempreLerBanco: Boolean = True;
                            strOrderBy: String = ''):Variant ;
var
  LarrCampoChave: Array Of String;
  LarrValorChave: Array Of Variant;
  ////
  LarrCampoChaveSemEmp: Array Of String;
  LarrValorChaveSemEmp: Array Of Variant;
  intCnt : integer ;
begin
  ///inicializa os arrays Local
  for intCnt := Low(arrCampoChave) to High(arrCampoChave) do
  begin
    setLength(LarrCampoChave, Length(LarrCampoChave)+1) ;
    LarrCampoChave[High(LarrCampoChave)] := arrCampoChave[intCnt] ;
    ///
    setLength(LarrCampoChaveSemEmp, Length(LarrCampoChaveSemEmp)+1) ;
    LarrCampoChaveSemEmp[High(LarrCampoChaveSemEmp)] := arrCampoChave[intCnt] ;
  end;
  for intCnt := Low(arrValorChave) to High(arrValorChave) do
  begin
    setLength(LarrValorChave, Length(LarrValorChave)+1) ;
    LarrValorChave[High(LarrValorChave)] := arrValorChave[intCnt] ;
    ///
    setLength(LarrValorChaveSemEmp, Length(LarrValorChaveSemEmp)+1) ;
    LarrValorChaveSemEmp[High(LarrValorChaveSemEmp)] := arrValorChave[intCnt] ;
  end;

  if fCfgCtntsi = 'N' then
  begin
    setLength(LarrCampoChave, Length(LarrCampoChave)+1) ;
    LarrCampoChave[High(LarrCampoChave)] := 'NCO_NATURE' ;
    setLength(LarrValorChave, Length(LarrValorChave)+1) ;
    LarrValorChave[High(LarrValorChave)] := 'A' ;
    ///
    setLength(LarrCampoChaveSemEmp, Length(LarrCampoChaveSemEmp)+1) ;
    LarrCampoChaveSemEmp[High(LarrCampoChaveSemEmp)] := 'NCO_NATURE' ;
    setLength(LarrValorChaveSemEmp, Length(LarrValorChaveSemEmp)+1) ;
    LarrValorChaveSemEmp[High(LarrValorChaveSemEmp)] := 'A' ;
  end;

  ///tplaco
  setLength(LarrCampoChave, Length(LarrCampoChave)+1) ;
  LarrCampoChave[High(LarrCampoChave)] := 'NCO_TPLACO' ;
  setLength(LarrValorChave, Length(LarrValorChave)+1) ;
  LarrValorChave[High(LarrValorChave)] := fRetTplacoEmpresaLogada ;

  Result := trim(fCampoTabela(strCampo, 'PLANCO', LarrCampoChave, LarrValorChave, blnSempreLerBanco, strOrderBy));
  if fEmptyStr(Result) then
  begin
    Result := trim(fCampoTabela(strCampo, 'PLANCO', LarrCampoChaveSemEmp, LarrValorChaveSemEmp, blnSempreLerBanco, strOrderBy));
  end;

end;

function fPesqDemonstracaoFluxoCaixa(Self     : TForm;                    {* Formulário                                  *}
                                     edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                     edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                     qryTabela: TUniQuery;                {* Query                                       *}
                                     Var chrKey: Char;                    {* Key                                         *}
                                     Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                     blnConSim: Boolean): Boolean;
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  DFC_EXERCI, DFC_CODEMP     ';
      strSQL := strSQL + 'FROM                         ';
      strSQL := strSQL + '  PARDFC                     ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Exercício', 'Código Empresa'],
                   ['DFC_EXERCI', 'DFC_CODEMP'],
                   '',
                   'PARDFC',
                   Self.Name,
                   'Consulta de Demonstração Fluxo Caixa',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DFC_EXERCI') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DFC_EXERCI').AsString + '|' + qryConsulta.FieldByName('DFC_CODEMP').AsString + '|'
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DFC_EXERCI').AsString + '|' + qryConsulta.FieldByName('DFC_CODEMP').AsString + '|' ;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 4)
            Else
              edtCodigo.Text := fStrZero('0', 4);
          End;

        End
        else if Length(arrSel) = 1 Then
          arrSel[0].strCodigo := qryConsulta.FieldByName('DFC_EXERCI').AsString + '|' + qryConsulta.FieldByName('DFC_CODEMP').AsString + '|' ;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqNotaExplicativaV2(Self     : TForm;                    {* Formulário                                  *}
                                edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                qryTabela: TUniQuery;                {* Query                                       *}
                                Var chrKey: Char;                    {* Key                                         *}
                                Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                blnConSim: Boolean;
                                intExercicio: integer=0): Boolean;
Var
  strSQL     : String;
  strWhere   : String;
  qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + ' SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '   EXP_CODIGO, ';
      strSQL := strSQL + '   EXP_NOTEXP, ';
      strSQL := strSQL + '   EXP_ANOINI, ';
      strSQL := strSQL + '   EXP_ANOFIN ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   NTEXPL ';

      strWhere := '' ;
      if intExercicio > 0 then
      begin
        strWhere := 'WHERE '+ IntToStr(intExercicio) +' BETWEEN COALESCE(EXP_ANOINI,0) AND CASE WHEN COALESCE(EXP_ANOINI,0) = 0 THEN 9999 ELSE EXP_ANOINI END ' ;
      end;

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   ['Código', 'Nota Explicativa', 'Exerc. De', 'Exerc. Até'],
                   ['EXP_CODIGO', 'EXP_NOTEXP', 'EXP_ANOINI', 'EXP_ANOFIN'],
                   '',
                   'NTEXPL',
                   Self.Name,
                   'Consulta de Nota Explicativa',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'EXP_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EXP_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EXP_CODIGO').AsString;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqDemonstracaoResultadoAbrangente(Self     : TForm;                    {* Formulário                                  *}
                                              edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                              edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                              qryTabela: TUniQuery;                {* Query                                       *}
                                              Var chrKey: Char;                    {* Key                                         *}
                                              Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                              blnConSim: Boolean): Boolean;
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  DRA_EXERCI, DRA_CODEMP     ';
      strSQL := strSQL + 'FROM                         ';
      strSQL := strSQL + '  PARDRA                     ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Exercício', 'Código Empresa'],
                   ['DRA_EXERCI', 'DRA_CODEMP'],
                   '',
                   'PARDRA',
                   Self.Name,
                   'Consulta de Demonstração Resultado Abrangente',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DRA_EXERCI') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DRA_EXERCI').AsString + '|' + qryConsulta.FieldByName('DRA_CODEMP').AsString + '|'
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DRA_EXERCI').AsString + '|' + qryConsulta.FieldByName('DRA_CODEMP').AsString + '|';
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 4)
            Else
              edtCodigo.Text := fStrZero('0', 4);
          End;

        End
        else if Length(arrSel) = 1 Then
          arrSel[0].strCodigo := qryConsulta.FieldByName('DRA_EXERCI').AsString + '|' + qryConsulta.FieldByName('DRA_CODEMP').AsString + '|' ;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqDemonstracaoValorAdicionado(Self     : TForm;                    {* Formulário                                  *}
                                          edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                          edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                          qryTabela: TUniQuery;                {* Query                                       *}
                                          Var chrKey: Char;                    {* Key                                         *}
                                          Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                          blnConSim: Boolean): Boolean;
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  DVA_EXERCI, DVA_CODEMP     ';
      strSQL := strSQL + 'FROM                         ';
      strSQL := strSQL + '  PARDVA                     ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Exercício', 'Código Empresa'],
                   ['DVA_EXERCI', 'DVA_CODEMP'],
                   '',
                   'PARDVA',
                   Self.Name,
                   'Consulta de Demonstração Valor Adicionado',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DVA_EXERCI') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DVA_EXERCI').AsString + '|' + qryConsulta.FieldByName('DVA_CODEMP').AsString + '|'
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DVA_EXERCI').AsString + '|' + qryConsulta.FieldByName('DVA_CODEMP').AsString + '|';
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 4)
            Else
              edtCodigo.Text := fStrZero('0', 4);
          End;

        End
        else if Length(arrSel) = 1 Then
          arrSel[0].strCodigo := qryConsulta.FieldByName('DVA_EXERCI').AsString + '|' + qryConsulta.FieldByName('DVA_CODEMP').AsString + '|' ;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;


function fPesqDemonstracaoMutacaoPatrimonioLiquido(Self     : TForm;                    {* Formulário                                  *}
                                                   edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                                   edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                                   qryTabela: TUniQuery;                {* Query                                       *}
                                                   Var chrKey: Char;                    {* Key                                         *}
                                                   Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                   blnConSim: Boolean): Boolean;
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  DMP_EXERCI, DMP_CODEMP     ';
      strSQL := strSQL + 'FROM                         ';
      strSQL := strSQL + '  PRDMPL                     ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Exercício', 'Código Empresa'],
                   ['DMP_EXERCI', 'DMP_CODEMP'],
                   '',
                   'PRDMPL',
                   Self.Name,
                   'Consulta de Parâmetros Demonstração das Mutações do Patrimônio Líquido',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DMP_EXERCI') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|'
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|';
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 4)
            Else
              edtCodigo.Text := fStrZero('0', 4);
          End;

        End
        else if Length(arrSel) = 1 Then
          arrSel[0].strCodigo := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|' ;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqDemonstracaoMutacaoPatrimonioLiquidoNtExpl(Self     : TForm;                    {* Formulário                                  *}
                                                         edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                                         edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                                         qryTabela: TUniQuery;                {* Query                                       *}
                                                         Var chrKey: Char;                    {* Key                                         *}
                                                         Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                         blnConSim: Boolean): Boolean;
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  NEDMPL.DMP_EXERCI,         ';
      strSQL := strSQL + '  NEDMPL.DMP_CODEMP,         ';
      strSQL := strSQL + '  NEDMPL.DMP_CODEXP,         ';
      strSQL := strSQL + '  NTEXPL.EXP_NOTEXP          ';
      strSQL := strSQL + 'FROM                         ';
      strSQL := strSQL + '  NEDMPL INNER JOIN NTEXPL ON NEDMPL.DMP_CODEXP = NTEXPL.EXP_CODIGO ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Exercício', 'Código Empresa', 'Código Nota', 'Nota Explicativa'],
                   ['DMP_EXERCI', 'DMP_CODEMP', 'DMP_CODEXP', 'EXP_NOTEXP'],
                   '',
                   'NEDMPL',
                   Self.Name,
                   'Consulta de [Notas Explicativas] Demonstração das Mutações do Patrimônio Líquido',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DMP_EXERCI') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|'
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|' ;
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 4)
            Else
              edtCodigo.Text := fStrZero('0', 4);
          End;

        End
        else if Length(arrSel) = 1 Then
          arrSel[0].strCodigo := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|' ;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqDemonstracaoMutacaoPatrimonioLiquidoMovimentacao(Self     : TForm;                    {* Formulário                                  *}
                                                               edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                                               edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                                               qryTabela: TUniQuery;                {* Query                                       *}
                                                               Var chrKey: Char;                    {* Key                                         *}
                                                               Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                                               blnConSim: Boolean): Boolean;
Var
  strSQL     : String;
  qryConsulta: TUniQuery;
begin

  Result := False;

  If fEntraCons(chrKey) Then
  Begin

    Try

      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT SQL_NO_CACHE ';
      strSQL := strSQL + '  DMP_EXERCI, DMP_CODEMP     ';
      strSQL := strSQL + 'FROM                         ';
      strSQL := strSQL + '  MVDMPL                     ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                   ['Exercício', 'Código Empresa'],
                   ['DMP_EXERCI', 'DMP_CODEMP'],
                   '',
                   'MVDMPL',
                   Self.Name,
                   'Consulta [Movimentação] Demonstração das Mutações do Patrimônio Líquido',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'DMP_EXERCI') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|'
          Else
            edtCodigo.Text := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|';
        End;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 4)
            Else
              edtCodigo.Text := fStrZero('0', 4);
          End;

        End
        else if Length(arrSel) = 1 Then
          arrSel[0].strCodigo := qryConsulta.FieldByName('DMP_EXERCI').AsString + '|' + qryConsulta.FieldByName('DMP_CODEMP').AsString + '|' ;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

  End;

end;

function fPesqHistoricoMovimentacao(Self     : TForm;                    {* Formulário                                  *}
                                    edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                    edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                    qryTabela: TUniQuery;                {* Query                                       *}
                                    Var chrKey: Char;                    {* Key                                         *}
                                    Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                    blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  HST_CODIGO,       ';
      strSQL := strSQL + '  HST_DESCRI,       ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  HISTMV            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'AUTOINCREM'],
                   ['HST_DESCRI','HST_CODIGO'],
                   '',
                   'HISTMV',
                   Self.Name,
                   'Consulta de Histórico Movimentação',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'HST_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('HST_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('HST_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('HST_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

function fPesqNaturezaJuridica(Self     : TForm;                    {* Formulário                                  *}
                               edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                               edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;                {* Query                                       *}
                               Var chrKey: Char;                    {* Key                                         *}
                               Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                               blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE  ';
      strSQL := strSQL + '  NAT_CODIGO,        ';
      strSQL := strSQL + '  NAT_NATNOM,        ';
      strSQL := strSQL + '  NAT_DTAINI,        ';
      strSQL := strSQL + '  NAT_DTAFIN,        ';
      strSQL := strSQL + '  AUTOINCREM        ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  NTJURI            ';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL],
                  ['Código',
                   'Descrição',
                   'Vigência Inicial',
                   'Vigência Final'],
                   ['NAT_CODIGO','NAT_NATNOM','NAT_DTAINI','NAT_DTAFIN'],
                   '',
                   'NTJURI',
                   Self.Name,
                   'Consulta de Natureza Juridica',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'NAT_CODIGO') Then
      Begin

        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('NAT_CODIGO').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('NAT_CODIGO').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('NAT_NATNOM').AsString;

        If (Length(arrSel) > 1) Then
        Begin
          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 6)
            Else
              edtCodigo.Text := fStrZero('0', 6);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';
        End;

        Result := True;
      End;

      If Not Assigned(qryTabela) Then
        FreeAndNil(qryConsulta);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

{************************************}
{* CONSULTA DE CENTRO DE CUSTOS     *}
{*********************************DP*}
function fPesqCentroCustoContabil(Self     : TForm;                     {* Formulário                                         *}
                          edtCodigo: TCustomEdit;               {* Edit do Código                                     *}
                          edtDescri: TEditFocus;                {* Edit da Descrição                                  *}
                          qryTabela: TUniQuery;                   {* Query                                              *}
                          Var chrKey: Char;                     {* Key                                                *}
                          Var arrSel: TConsultasArray;          {* Array de Seleção                                   *}
                          blnConSim: Boolean = True;            {* Consulta Simples ou Múltipla (multi select)        *}
                          blnUsaCtf: Boolean = False;           {* Só mostra os Plano de Contas vinculados do CADFOR *}
                          strCodFor: String  = ''): Boolean;    {* Código da empresa se blnUsaCtf = True              *}
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
    dfmCentroCusto: TDefMascaraCentroCusto;
    arrTitCol  : TColunasArray; {* Títulos das Colunas  *}

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';

      SetLength(arrTitCol, 0);

      strSQL := strSQL + 'SELECT  ';
      strSQL := strSQL + '  C.CTA_CODCTA, '; pAddNomeColuna('Código');
      strSQL := strSQL + '  C.CTA_DESCTA, '; pAddNomeColuna('Descrição');

      strSQL := strSQL + '  C.AUTOINCREM  ';
      strSQL := strSQL + 'FROM            ';
      strSQL := strSQL + '  CADCTA C      ';

      strWhere := '';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      dfmCentroCusto := TDefMascaraCentroCusto.Create;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['CTA_DESCTA','CTA_CODCTA'],
                   '',
                   'CADCTA',
                   Self.Name,
                   'Consulta de Plano de Contas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'CTA_CODCTA',
                   dfmCentroCusto) Then

      Begin
        If Assigned(edtCodigo) then
        Begin
          If edtCodigo.ClassNameIs('TMaskEditFocus') Or
             (edtCodigo.ClassNameIs('TDBEditFocus') And (Not fEmptyStr(TDBEditFocus(edtCodigo).Field.EditMask))) Then
            TMaskEditFocus(edtCodigo).Text := qryConsulta.FieldByName('CTA_CODCTA').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('CTA_CODCTA').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('CTA_DESCTA').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If edtCodigo.ClassNameIs('TMaskEditFocus') Then
              TMaskEditFocus(edtCodigo).Text := '0'
            Else
              edtCodigo.Text := fStrZero('0', 7);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        If Length(arrSel) = 1 Then
          arrSel[0].strDescri := qryConsulta.FieldByName('CTA_DESCTA').AsString;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);

      End;
      FreeAndNil(dfmCentroCusto);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;

end;

function fPesqTipoImobilizado(Self: TForm;                            {* Formulario                                  *}
                              edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                              edtDescri: TEditFocus;                  {* Edit da Descrição                           *}
                              qryTabela: TUniQuery;                   {* Query                                       *}
                              Var chrKey: Char;                       {* Key                                         *}
                              Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;   {* Consulta Simples ou Múltipla (multi select) *}
  Var
    strSQL     : String;
    strWhere   : String;
    arrCampos: array of String;
    qryConsulta: TUniQuery;
    objConsulta : TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try
      chrKey := #0;

      strSQL := '';
      objConsulta := TDefConsulta.Create;

      strSQL := strSQL + 'SELECT TIP_CODTIP, ';
      strSQL := strSQL + '       TIP_DESCRI, ';
      If fCfgSis('DEPIMO') <> '1' Then
        strSQL := strSQL + '       TIP_ALQDEP, ';
      if fTemPlancosTipoImobilizado then
      begin
        strSQL := strSQL + '       TIP_PCATIM, ';
        strSQL := strSQL + '       TIP_VDUTFI, ';
        strSQL := strSQL + '       TIP_PCDAFI, ';
        strSQL := strSQL + '       TIP_PCDDFI, ';
        strSQL := strSQL + '       TIP_VDUTSO, ';
        strSQL := strSQL + '       TIP_PCDASO, ';
        strSQL := strSQL + '       TIP_PCDDSO, ';
        strSQL := strSQL + '       TIP_PCCRMN, ';
        strSQL := strSQL + '       TIP_PCAJPT, ';
      end;
      strSQL := strSQL + '       AUTOINCREM  ';
      strSQL := strSQL + '  FROM TIPIMO      ';

      SetLength(arrCampos, 0);
      SetLength(arrCampos, Length(arrCampos)+1);
      arrCampos[High(arrCampos)] := 'Código';
      SetLength(arrCampos, Length(arrCampos)+1);
      arrCampos[High(arrCampos)] := 'Descrição';
      If fCfgSis('DEPIMO') <> '1' Then
      Begin
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Taxa Depreciação Anual';
      End;
      if fTemPlancosTipoImobilizado then
      begin
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Ativo Imobilizado' ;
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Vida Útil - Depreciação (Anos) - Fiscal';
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Depreciação Acumulada - Fiscal';
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Despesa com Depreciação - Fiscal';
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Vida Útil - Depreciação (Anos) - Societária';
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Depreciação Acumulada - Societária';
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Despesa com Depreciação - Societária';
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Correção Monetária';
        SetLength(arrCampos, Length(arrCampos)+1);
        arrCampos[High(arrCampos)] := 'Ajuste Avaliação Patrimonial';
      end;
      SetLength(arrCampos, Length(arrCampos)+1);
      arrCampos[High(arrCampos)] := 'AUTOINCREM';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;


      If fConsulta([strSQL, strWhere],
                   arrCampos,
                   ['TIP_CODTIP'],
                   '',
                   'TIPIMO',
                   Self.Name,
                   'Consulta de Tipo de Imobilizado/Patrimônio',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'TIP_CODTIP',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('TIP_CODTIP').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('TIP_CODTIP').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('TIP_DESCRI').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := '0'
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
        FreeAndNil(objConsulta);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
End;

function fPesqEmpresaComForTri(Self     : TForm;            {* Formulário                                  *}
                               edtCodigo: TCustomEdit;      {* Edit do Código                              *}
                               edtDescri: TEditFocus;       {* Edit da Descrição                           *}
                               qryTabela: TUniQuery;        {* Query                                       *}
                               Var chrKey: Char;            {* Key                                         *}
                               Var arrSel: TConsultasArray; {* Array de Seleção                            *}
                               blnConSim: Boolean = True;   {* Consulta Simples ou Múltipla (multi select) *}
                               strExerci: String = ''): Boolean; {* Exercio Forma Tributação                    *}
  Var
    qryConsulta: TUniQuery;
    strSQL: String;                             {* SQL da Query                                *}
    strWhere: String;
    arrTitCol: TColunasArray;                   {* Títulos das Colunas                         *}
    objConsulta: TDefConsulta;
begin
  Result := False;
  If fEntraCons(chrKey) Then
  Begin
    Try

      chrKey := #0;

      objConsulta := TDefConsulta.Create;
      objConsulta.pIncluiCamposCNPJ(['EMP_C_G_C_']);

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  EMP_CODEMP,       ';
      strSQL := strSQL + '  EMP_NOMEMP,       ';
      strSQL := strSQL + '  EMP_NOMFAN,       ';
      strSQL := strSQL + '  CADEMP.AUTOINCREM ';
      strSQL := strSQL + 'FROM                ';
      strSQL := strSQL + '  CADEMP            ';
      strSQL := strSQL + 'INNER JOIN EPREGT   ';
      strSQL := strSQL + '  ON TRI_CODEMP = EMP_CODEMP ';
      strSQL := strSQL + '  AND TRI_ANOEXE = ' + QuotedStr(strExerci.Trim);

      strWhere := ' WHERE TRUE ';

      SetLength(arrTitCol, 3);
      arrTitCol[00] := 'Código';
      arrTitCol[01] := 'Razão Social';
      arrTitCol[02] := 'Nome Fantasia';

      If Not Assigned(qryTabela) Then
        qryConsulta := fCriaQuery(Nil)
      Else
        qryConsulta := qryTabela;

      If fConsulta([strSQL, strWhere],
                   arrTitCol,
                   ['EMP_NOMEMP','EMP_NOMFAN','EMP_CODEMP'],
                   '',
                   'CADEMP',
                   Self.Name,
                   'Consulta de Empresas',
                   qryConsulta,
                   Nil,
                   blnConSim,
                   arrSel,
                   'EMP_CODEMP',
                   objConsulta) Then
      Begin
        If Assigned(edtCodigo) then
        Begin
          If (edtCodigo Is TMaskEditFocus) Then
            (edtCodigo As TMaskEditFocus).Text := qryConsulta.FieldByName('EMP_CODEMP').AsString
          Else
            edtCodigo.Text := qryConsulta.FieldByName('EMP_CODEMP').AsString;
        End;

        If Assigned(edtDescri) Then
          edtDescri.Text := qryConsulta.FieldByName('EMP_NOMEMP').AsString;

        If (Length(arrSel) > 1) Then
        Begin

          If Assigned(edtCodigo) then
          Begin
            If (edtCodigo Is TMaskEditFocus) Then
              (edtCodigo As TMaskEditFocus).Text := fStrZero('0', 3)
            Else
              edtCodigo.Text := fStrZero('0', 3);
          End;

          If Assigned(edtDescri) Then
            edtDescri.Text := '+1';

        End;

        Result := True;

        If Not Assigned(qryTabela) Then
          FreeAndNil(qryConsulta);
      End;

      FreeAndNil(objConsulta);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  End;
end;

{ TDefConPlanoContabil }

constructor TDefConPlanoContabil.Create(arrCampos: TStringArray);
  Var
    intCnt : Integer;
begin
  inherited Create;

  strMskCon := fMskCon;

  For intCnt := Low(arrCampos) To High(arrCampos) Do
    pIncluiDefMascara(arrCampos[intCnt], pDisplayPlanoContabil);
end;

destructor TDefConPlanoContabil.Destroy;
begin
  inherited Destroy;
end;

procedure TDefConPlanoContabil.pDisplayPlanoContabil(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText(strMskCon, AText);
end;

{ TDefMascaraCentroCusto }

procedure TDefMascaraCentroCusto.pDisplayCodigo(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := FormatMaskText('99.99.999;0;', AText)
end;

Constructor TDefMascaraCentroCusto.Create;
  Var
    strLinha,
    strGrupo: String;
Begin
  Inherited Create;

  pIncluiDefMascara('CTA_CODCTA', pDisplayCodigo);

  strLinha := '';
  strLinha := strLinha + '  (SELECT SQL_NO_CACHE ';
  strLinha := strLinha + '    CONCAT(LINHAS.CTA_CODCTA, " - ", LINHAS.CTA_DESCTA) ';
  strLinha := strLinha + '  FROM ';
  strLinha := strLinha + '    CADCTA LINHAS ';
  strLinha := strLinha + '  WHERE ';
  strLinha := strLinha + '    LEFT(LINHAS.CTA_CODCTA, 2) = LEFT(C.CTA_CODCTA, 2) AND ';
  strLinha := strLinha + '    RIGHT(LINHAS.CTA_CODCTA, 5) = "00000")';

  strGrupo := '';
  strGrupo := strGrupo + '  (SELECT SQL_NO_CACHE ';
  strGrupo := strGrupo + '    CONCAT(GRUPOS.CTA_CODCTA, " - ", GRUPOS.CTA_DESCTA) ';
  strGrupo := strGrupo + '  FROM ';
  strGrupo := strGrupo + '    CADCTA GRUPOS ';
  strGrupo := strGrupo + '  WHERE ';
  strGrupo := strGrupo + '    LEFT(GRUPOS.CTA_CODCTA, 4) = LEFT(C.CTA_CODCTA, 4) AND ';
  strGrupo := strGrupo + '    RIGHT(GRUPOS.CTA_CODCTA, 3) = "000")';

  pIncluiSubConsulta('CTA_LINHA_', strLinha);
  pIncluiSubConsulta('CTA_GRUPO_', strGrupo);
End;

end.
