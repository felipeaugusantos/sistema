unit untILibCartoesWrapper;

interface

Uses System.Classes, Vcl.Forms, Vcl.StdCtrls, Data.DB,

    Uni, EditFocus, cxEdit, frxClass,

    untLibCartoesInterfacesTipos;

Type
  ILibCartoes = Interface
    ['{D5FB47CE-294B-4D84-8B7C-7E8C5EE7A83D}']
    function fICfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
    function fICurrentDate: String;
    function fIGetVS_Date: TDateTime;
    function fIMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      blnAutoSize: Boolean = False; intSomarTop: Integer = 0): Integer;

    function fIRetAutoIncrem(const ATabela,
                                   AEmpresaLogada: String;
                                   AQuantidade: Integer = -1): String;
    function fIRetSequencial(strNomCam: String; strCodEmp: String = ''; intTamanho: Integer = 6): String;
    function fIRetSequencialCadPag(intQtdCod: Integer = 1; AstrEmpresa: String = ''): String;
    function fISeqContaBanco(intQtdCod: Integer = 1): String;
    function fIRetRcxCon(strCodEmp: String = ''): String;
    function fIRetCtpCon(strCodEmp: String = ''; blnConexaoAutoincrem: Boolean=True): Longint;

    function fIRetOperadorLogado: String;
    function fIRetEmpresaLogada: String;
    function fIRetPortadoresOperador: String;
    function fIRetEmpAcessoOperador: String;
    function fIRetCGCEmpresa(const ACodigoEmpresa: String): String;

    function fIValidarDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean;
    function fIVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;

    function fIAtualizadoMonitoramento: Boolean;

    function fICriaQuery: TUniQuery;
    function fIStartTransaction: Boolean;
    function fICommit: Boolean;
    function fIRollBack: Boolean;

    function fICampoTabela(strCampo : String;
                           strNomTab: String;
                           arrCampoChave: Array Of String;
                           arrValorChave: Array Of Variant;
                           blnSempreLerBanco: Boolean = True;
                           strOrderBy: String = '';
                           Conexao: TUniConnection = Nil;
                           blnUsarMax: Boolean = False): Variant;

    function fIPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
                           ASelf     : TForm;                           {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                           edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                           qryTabela: TUniQuery;                       {* Query                                       *}
                           Var chrKey: Char;                           {* Key                                         *}
                           Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                           blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                           blnResEmp: Boolean = False;                 {* Restringir empresas que usuário tem acesso  *}
                           strEmpresas: String = '';                   {* Empresas                                    *}
                           blnAceCtr: Boolean = False;                 {* Verifica se filtrará as empresas que o usuário tem acesso na Baixa de Contas a Receber *}
                           strAceCtr: String = '';                     {* Empresas que o usuário possui acesso na Baixa de Contas a Receber        *}
                           strConcil: String  = ''): Boolean;          {* Condição da Conciliação de Cartões          *}

    procedure pIPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);

    procedure pIExibirRelatorio(const APrograma, ADescricao: String; AReport: IReport);

    procedure pIMensagensErro(const MensErro, LocalErro: String; const strMensagem: String = '');
    procedure pIGravarErro(const GravarErro:Boolean; const MensagemErro: String);

    function fIExecutandoModoClassico: Boolean;

    function fIPedirLiberacao(ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean;

    function fIPesquisar(ASelf     : TForm;                          {* Formulário         *}
                         edtCodigo: TCustomEdit;                     {* Edit do Código     *}
                         edtDescri: TEditFocus;                      {* Edit Descrição     *}
                         Var chrKey: Char;
                         ACodPesquisa: String): Boolean;

    function fIPesqEstConcil(ASelf     : TForm;
                             edtCodigo: TCustomEdit;
                             edtDescri: TEditFocus;
                             Var chrKey: Char;
                             AObjetoConcil: TCamposConcil;
                             Var ArrayConsultas: TConsultasArray): Boolean;

    function fIPesqEventos(ASelf     : TForm;                           {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                           edtDescri: TEditFocus;                      {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                       {* Query                                       *}
                           Var chrKey: Char;                           {* Key                                         *}
                           Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                           blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                           blnFiltroExiFat: Boolean = False;           {* Consulta pesquisará somente eventos que serão exibidos no faturamento *}
                           strTipo: string = 'T'): Boolean;            {* Consulta pelo tipo = T-odos / P-agar / R-eceber *}

    function fIPesqCentroCusto(ASelf     : TForm;                       {* Formulário                                         *}
                               edtCodigo: TCustomEdit;                 {* Edit do Código                                     *}
                               edtDescri: TEditFocus;                  {* Edit da Descrição                                  *}
                               qryTabela: TUniQuery;                   {* Query                                              *}
                               Var chrKey: Char;                       {* Key                                                *}
                               Var arrSel: TConsultasArray;            {* Array de Seleção                                   *}
                               blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select)        *}
                               blnUsaCtf: Boolean = False;             {* Só mostra os Plano de Contas vinculados do CADFOR *}
                               strCodFor: String  = '';                {* Código da empresa se blnUsaCtf = True              *}
                               blnVemBxCtc : Boolean = False;          {Baixa de cartões}
                               blnVemBxCh : Boolean = False;           {Baixa de cheques}
                               blnVemBxCtr : Boolean = False;          {Baixa de contas a receber}
                               blnVemBxCta : Boolean = False): Boolean;{Baixa de contas a pagar}

    function fIPesqPortador(opcTipPor: TTipoConsultaSimples;
                            ASelf    : TForm;                       {* Formulário                                  *}
                            edtCodigo: TCustomEdit;                 {* Edit do Código                              *}
                            edtDesPor: TEditFocus;                  {* Edit da Descrição do item                   *}
                            qryTabela: TUniQuery;                   {* Query                                       *}
                            Var chrKey: Char;                       {* Key                                         *}
                            Var arrSel: TConsultasArray;            {* Array de Seleção                            *}
                            blnConSim: Boolean = True;              {* Consulta Simples ou Múltipla (multi select) *}
                            strTitulo: String = 'Consulta de Portadores';
                            strBolFat: String = '';                 {* Boleto no Faturamento                       *}
                            blnSalPor: Boolean = False;             {* Entra no Relatório Saldo Portador           *}
                            blnImpBol: Boolean = False;             {* Pesquisa da Impressão de Boletos            *}
                            strCodEmp: String = ''): Boolean;       {* Empresa selecionada                         *}

    function fIPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
                              ASelf    : TForm;                        {* Formulário                                  *}
                              edtCodigo: TCustomEdit;                  {* Edit do Código                              *}
                              edtNomEmp: TCustomEdit;                  {* Edit do Nome da Empresa                     *}
                              qryTabela: TUniQuery;                    {* Query                                       *}
                              Var chrKey: Char;                        {* Key                                         *}
                              Var arrSel: TConsultasArray;             {* Array de Seleção                            *}
                              blnConSim: Boolean = True): Boolean;     {* Consulta Simples ou Múltipla (multi select) *}

    function fIPesqCartao(ASelf    : TForm;                            {* Formulário                                  *}
                          edtCodigo: TCustomEdit;                      {* Edit do Código                              *}
                          edtDescri: TEditFocus;                       {* Edit da Descrição                           *}
                          qryTabela: TUniQuery;                        {* Query                                       *}
                          Var chrKey: Char;                            {* Key                                         *}
                          Var arrSel: TConsultasArray;                 {* Array de Seleção                            *}
                          blnConSim: Boolean = True;                   {* Consulta Simples ou Múltipla (multi select) *}
                          blnSoAtiv: Boolean = False;                  {* Filtra os cartões ativos ou todos           *}
                          blnMostraDesconto: Boolean = False;          {* Mostra a coluna desconto                    *}
                          blnCadCar: Boolean = False;                  {* É cadastro                                  *}
                          blnEmpGer: Boolean = False;                  {* É empresa gerencial                         *}
                          blnVerAce: Boolean = False;                  {* Verifica direito de Acesso as Empresas?     *}
                          strCodEmp: String = ''): Boolean;            {* Seleciona os cartões da empresa Digitada    *}

    function fIPesqCartaoBandeira(ASelf    : TForm;                    {* Formulário                                  *}
                                  edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                  edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                  qryTabela: TUniQuery;                {* Query                                       *}
                                  Var chrKey: Char;                    {* Key                                         *}
                                  Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                  blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

    function fIPesqCliente(opcTipCli: TTipoConsultaCliente;
                           ASelf    : TForm;                           {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                           edtNomCli: TEditFocus;                      {* Edit do Nome do Cliente                     *}
                           qryTabela: TUniQuery;                       {* Query                                       *}
                           Var chrKey: Char;                           {* Key                                         *}
                           Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;        {* Consulta Simples ou Múltipla (multi select) *}

    procedure pIAdicionarConfiguracao(strCodCfg, strDescri, strValCfg, strGruCfg: String;
                                      blnDefEmp: Boolean; intNumHlp: Integer = 0; strLayout : String = 'N';
                                      strPerRep: String = 'S'; strUsoCit: String = 'N');

    function fILock_Unlock(strNomeTabela: String;
                           blnTrava: Boolean;
                           blnLoopTravamento: Boolean = True;
                           blnHourGlass: Boolean = FALSE;
                           strCon_Id: String = '';
                           blnMostraMsgTravamento: Boolean = True;
                           strOrigem: String = '';
                           blnManual: Boolean = False;
                           blnSeForMesmaConexaoNaoTravar: Boolean = False;
                           blnStartTransaction : Boolean = True;
                           blnStartCommit : Boolean = True;
                           blnIgnoraConId: Boolean = False;
                           blnGravarLog: Boolean = True;
                           AUtilizaHoraServidor: Boolean = False): Boolean;

    function fIGetHostLock(strNomeTabela: String;
                           blnSohIP: Boolean = False;
                           blnLike: Boolean = True;
                           blnCon_ID: Boolean = False): String;

    procedure fIRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');

    function fIGetEditRepository: TcxEditRepository;

    function fIGetArrayConfiguracoes: TArrConfiguracoes;

    function fIFechamentoFinanceiroJaRealizado(ACodigoEmpresa: String;
                                               ADataReferenciaFechamento: TDate;
                                               ANomeFormulario: String;
                                               AExibirMensagem: Boolean = True): Boolean;

    function fIGetVersaoProduto: String;
    function fIGetIconApplication: TMemoryStream;

    procedure pICarregaCadMovCartoes(ADatasetMovCar: TDataset;
                                     var AAtualizarBaixa: Boolean);

    function fIGetObjetoTelasAbertas: ITelasAbertas;

    {EDITOR RELATORIOS}
    procedure prcIExecutaRelatorio(intCodigoAtalho,
                                   intChaveDefault: integer;
                                   intChavesPossiveis: Array Of Integer;
                                   arrParametros: Array Of String;
                                   arrValores: Array Of String;
                                   SenderChamada: TObject;
                                   arrParametrosReadOnly: TArrString = Nil;
                                   blnExecutarDireto: Boolean = False;
                                   blnExibirMensagem: Boolean = True;
                                   strDirAce: String = '';
                                   blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                   objParametrosRelatorio: TParametrosRelatorio = Nil);

    function fIExecutaRelatorio(intCodigoAtalho,
                                intChaveDefault: integer;
                                intChavesPossiveis: Array Of Integer;
                                arrParametros: Array Of String;
                                arrValores: Array Of String;
                                SenderChamada: TObject;
                                arrParametrosReadOnly: TArrString = Nil;
                                blnExecutarDireto: Boolean = False;
                                blnExibirMensagem: Boolean = True;
                                strDirAce: String = '';
                                blnDestinoJson: Boolean = False;
                                blnMostrarProgresso: Boolean = True): Boolean;

    function fIExecutaRelatorioCodigo(strCodRel: String;
                                      arrParametros: Array Of String;
                                      arrValores: Array Of String;
                                      arrParametrosReadOnly: TArrString = Nil;
                                      blnExecutarDireto: Boolean = False;
                                      blnExibirMensagem: Boolean = True;
                                      strDirAce: String = '';
                                      blnValidacao: Boolean = False;
                                      objRetornoRelatorio: TRetornoRelatorio = Nil;
                                      fecharJanelaDeDadosAoImprimir: Boolean = False): Boolean;
    {END EDITOR RELATORIOS}

    function fITelaGravandoAntiga: Boolean;

    function fIAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;

    function fIRetornaOperadorasMapeadasLibCartoes: String;

    function fIPesqArquivosYapay(ASelf: TForm;
                                 edtCodigo: TCustomEdit;
                                 edtDescri: TEditFocus;
                                 qryTabela: TUniQuery;
                                 Var chrKey: Char;
                                 Var arrSel: TConsultasArray;
                                 objConcil: TCamposConcil;
                                 blnConSim: Boolean = True): Boolean;

    function fIUtilizaBaixaRecebiveisMercadoLivre: Boolean;

    function fIAlterarCartaoVenda(AAutoincremCartao: String): Boolean;

    function fIIncluirCartaoVenda(AAutoincremCartao: String): Boolean;

    function fIVersaoDoAutcomPossuiDireitoDeAcessoParaImportacao: Boolean;

    procedure pILimparArrayDiretoAcesso;

    procedure pITrimAppMemorySize;

    procedure pIModificaStatusTimerTemMensagemPrincipal(AHabilitado: Boolean);
  End;

  ILibCartoesMarketplace = Interface
    ['{D833374A-D22C-4AF3-8DB2-24301F210F7D}']
    function fIIncluirCartaoVendaMarketplace(const AJsonVenda: String): Boolean;
  End;

implementation

end.
