unit untTLibContasBancariasAutcom;

interface

Uses
  System.Classes, Vcl.Forms, Vcl.StdCtrls, System.SysUtils, Winapi.Windows,
  Vcl.Menus, Data.DB, Vcl.Graphics,

  Uni, EditFocus, cxEdit, frxClass,

  untInterfacesLibContasBancariasAutcom, untTypesSistema, untLiberacao, untCfgRepositorio,
  untFuncoesRel, untFuncoesSimples

  {$IF Declared(VS_TELAS_ABERTAS_EXISTE)}
  ,untTelasAbertas
  {$ENDIF}
  ;

Type
  TILibContasBancariasAutcom = Class(TInterfacedObject, ILibContasBancarias)
    function fICfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
    function fICurrentDate: String;
    function fIGetVS_Date: TDateTime;
    function fIGetEmpresaLogada: String;
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
                           ASelf    : TForm;                           {* Formulário                                  *}
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

    procedure pIExibirRelatorio(const APrograma, ADescricao: String; AReport: IReport);

    procedure pIMensagensErro(const MensErro, LocalErro: String; const strMensagem: String = '');
    procedure pIGravarErro(const GravarErro:Boolean; const MensagemErro: String; strRelatorio: String= '');

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

    function fIPesqEventos(ASelf    : TForm;                           {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                           edtDescri: TEditFocus;                      {* Edit da Descrição                           *}
                           qryTabela: TUniQuery;                       {* Query                                       *}
                           Var chrKey: Char;                           {* Key                                         *}
                           Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                           blnConSim: Boolean = True;                  {* Consulta Simples ou Múltipla (multi select) *}
                           blnFiltroExiFat: Boolean = False;           {* Consulta pesquisará somente eventos que serão exibidos no faturamento *}
                           strTipo: string = 'T'): Boolean;            {* Consulta pelo tipo = T-odos / P-agar / R-eceber *}

    function fIPesqCentroCusto(ASelf    : TForm;                       {* Formulário                                         *}
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

    function fIPesqCliente(opcTipCli: TTipoConsultaCliente;
                           ASelf    : TForm;                           {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                           edtNomCli: TEditFocus;                      {* Edit do Nome do Cliente                     *}
                           qryTabela: TUniQuery;                       {* Query                                       *}
                           Var chrKey: Char;                           {* Key                                         *}
                           Var arrSel: TConsultasArray;                {* Array de Seleção                            *}
                           blnConSim: Boolean = True): Boolean;        {* Consulta Simples ou Múltipla (multi select) *}

    function fIPesqCartaoBandeira(ASelf    : TForm;                    {* Formulário                                  *}
                                  edtCodigo: TCustomEdit;              {* Edit do Código                              *}
                                  edtDescri: TEditFocus;               {* Edit da Descrição                           *}
                                  qryTabela: TUniQuery;                {* Query                                       *}
                                  Var chrKey: Char;                    {* Key                                         *}
                                  Var arrSel: TConsultasArray;         {* Array de Seleção                            *}
                                  blnConSim: Boolean = True): Boolean; {* Consulta Simples ou Múltipla (multi select) *}

    procedure pIPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);

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

    function fIGetObjetoTelasAbertas: TInterfacedObject;

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
                                   objParametrosRelatorio: TObject = Nil);

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
                                      objRetornoRelatorio: TComponent = Nil;
                                      fecharJanelaDeDadosAoImprimir: Boolean = False): Boolean;
    {END EDITOR RELATORIOS}

    function fITelaGravandoAntiga: Boolean;

    function fIAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;

  End;

Var
  FRepositorio: TfrmCfgRepositorio;

implementation

Uses untFuncoes, untConsultas, untFuncoesGenerica, untPesqAux,
     untFechamentoFinanceiro, untCfgRel, untVersaoProg, untCadMovCartoes;

{ TILibContasBancariasAutcom }

function TILibContasBancariasAutcom.fIGetArrayConfiguracoes: TArrConfiguracoes;
begin
  Result := untCfgRepositorio.arrCamposCfg;
end;

function TILibContasBancariasAutcom.fIGetEditRepository: TcxEditRepository;
begin
  If Assigned(frmCfgRepositorio) Then
  Begin
    FRepositorio := frmCfgRepositorio;
    Exit(FRepositorio.cxRepositorio);
  End;

  pCriarModulo(TfrmCfgRepositorio, TDataModule(FRepositorio));
  Result := FRepositorio.cxRepositorio;
end;

function TILibContasBancariasAutcom.fIGetEmpresaLogada: String;
begin
  Result := untFuncoesSimples.VS_strCodEmp;
end;

function TILibContasBancariasAutcom.fIGetHostLock(strNomeTabela: String; blnSohIP,
  blnLike, blnCon_ID: Boolean): String;
begin
  Result := untFuncoesSimples.fGetHostLock(strNomeTabela,
                                           blnSohIP,
                                           blnLike,
                                           blnCon_ID);
end;

function TILibContasBancariasAutcom.fIGetIconApplication: TMemoryStream;
  var
    LIcon: TIcon;
begin
  LIcon := TIcon.Create;
  Result := TMemoryStream.Create;
  try
    LIcon.Handle := LoadIcon(HInstance, 'MAINICON');
    LIcon.SaveToStream(Result);

    Result.Position := 0;
  finally
    LIcon.Free;
  end;
end;

function TILibContasBancariasAutcom.fIGetObjetoTelasAbertas: TInterfacedObject;
begin
  {$IF Declared(ITelasAbertas)}
  Result := objTelasAbertas As TTelasAbertas;
  {$ELSE}
  Result := Nil;
  {$ENDIF}
end;

function TILibContasBancariasAutcom.fIGetVersaoProduto: String;
begin
  Result := TVersaoExecutavel.GetVersaoProduto;
end;

function TILibContasBancariasAutcom.fIGetVS_Date: TDateTime;
begin
  Result := untFuncoesSimples.VS_Date;
end;

function TILibContasBancariasAutcom.fILock_Unlock(strNomeTabela: String;
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
begin
  {$IF Declared(untFuncoesGenerica.Lock_Unlock)}
    Result := untFuncoesGenerica.Lock_Unlock(strNomeTabela,
                                             blnTrava,
                                             blnLoopTravamento,
                                             blnHourGlass,
                                             strCon_Id,
                                             blnMostraMsgTravamento,
                                             strOrigem,
                                             blnManual,
                                             blnSeForMesmaConexaoNaoTravar,
                                             blnStartTransaction,
                                             blnStartCommit,
                                             blnIgnoraConId,
                                             blnGravarLog,
                                             AUtilizaHoraServidor);
  {$ELSE}
    Result := untFuncoesSimples.fLock_Unlock(strNomeTabela,
                                             blnTrava,
                                             blnLoopTravamento,
                                             blnHourGlass,
                                             strCon_Id,
                                             blnMostraMsgTravamento,
                                             strOrigem,
                                             blnManual,
                                             blnSeForMesmaConexaoNaoTravar,
                                             blnStartTransaction,
                                             blnStartCommit,
                                             blnIgnoraConId,
                                             blnGravarLog,
                                             AUtilizaHoraServidor);
  {$ENDIF}
end;

function TILibContasBancariasAutcom.fICampoTabela(strCampo, strNomTab: String;
  arrCampoChave: array of String; arrValorChave: array of Variant;
  blnSempreLerBanco: Boolean; strOrderBy: String; Conexao: TUniConnection;
  blnUsarMax: Boolean): Variant;
begin
  Result := untFuncoesSimples.fCampoTabela(strCampo,
                                           strNomTab,
                                           arrCampoChave,
                                           arrValorChave,
                                           blnSempreLerBanco,
                                           strOrderBy,
                                           Conexao,
                                           blnUsarMax);
end;

function TILibContasBancariasAutcom.fICfgSis(strCamCfg: String; varTipVar: TVarType;
  strCodEmp: String): Variant;
begin
  Result := untFuncoesSimples.fCfgSis(strCamCfg, varTipVar, strCodEmp);
end;

function TILibContasBancariasAutcom.fIAcertaDataParaDiaUtil(const dtaOrigem: TDateTime;
  strCodCid: String): TDateTime;
begin
  Result := untFuncoesSimples.fAcertaDataParaDiaUtil(dtaOrigem,
                                                     strCodCid);
end;

function TILibContasBancariasAutcom.fIAtualizadoMonitoramento: Boolean;
begin
  Result := True;
end;

function TILibContasBancariasAutcom.fICommit: Boolean;
begin
  Result := untFuncoesSimples.fCommit;
end;

function TILibContasBancariasAutcom.fICriaQuery: TUniQuery;
begin
  Result := untFuncoesSimples.fCriaQuery;
end;

function TILibContasBancariasAutcom.fICurrentDate: String;
begin
  Result := untFuncoesSimples.fCurrentDate;
end;

function TILibContasBancariasAutcom.fIExecutandoModoClassico: Boolean;
begin
  {$IF Declared(VS_VERSAO_72)}
  Result := True;
  {$ELSE}
  Result := blnUsuarioLogadoUtilizaModoClassico;
  {$ENDIF}
end;

function TILibContasBancariasAutcom.fIExecutaRelatorio(intCodigoAtalho,
  intChaveDefault: integer; intChavesPossiveis: array of Integer; arrParametros,
  arrValores: array of String; SenderChamada: TObject;
  arrParametrosReadOnly: TArrString; blnExecutarDireto,
  blnExibirMensagem: Boolean; strDirAce: String; blnDestinoJson,
  blnMostrarProgresso: Boolean): Boolean;
begin
  Result := False;

  If Assigned(untFuncoesRel.fncExecutaRelatorio) Then
    Result := untFuncoesRel.fncExecutaRelatorio(intCodigoAtalho,
                                                intChaveDefault,
                                                intChavesPossiveis,
                                                arrParametros,
                                                arrValores,
                                                SenderChamada,
                                                arrParametrosReadOnly,
                                                blnExecutarDireto,
                                                blnExibirMensagem,
                                                strDirAce,
                                                blnDestinoJson,
                                                blnMostrarProgresso);
end;

function TILibContasBancariasAutcom.fIExecutaRelatorioCodigo(strCodRel: String;
  arrParametros, arrValores: array of String; arrParametrosReadOnly: TArrString;
  blnExecutarDireto, blnExibirMensagem: Boolean; strDirAce: String;
  blnValidacao: Boolean; objRetornoRelatorio: TComponent;
  fecharJanelaDeDadosAoImprimir: Boolean): Boolean;
begin
  Result := False;

  If Assigned(untFuncoesRel.fncExecutaRelatorioCodigo) Then
    Result := untFuncoesRel.fncExecutaRelatorioCodigo(strCodRel,
                                                      arrParametros,
                                                      arrValores,
                                                      arrParametrosReadOnly,
                                                      blnExecutarDireto,
                                                      blnExibirMensagem,
                                                      strDirAce,
                                                      blnValidacao
                                                      {$IF Declared(TRetornoRelatorio)},objRetornoRelatorio As TRetornoRelatorio,
                                                      fecharJanelaDeDadosAoImprimir{$ENDIF});
end;

function TILibContasBancariasAutcom.fIFechamentoFinanceiroJaRealizado(
  ACodigoEmpresa: String; ADataReferenciaFechamento: TDate;
  ANomeFormulario: String; AExibirMensagem: Boolean): Boolean;
  Var
    LFechamento: TFechamentoFinanceiro;
begin
  LFechamento := TFechamentoFinanceiro.Create(Nil, ANomeFormulario);
  Try
    Result := LFechamento.FechamentoFinanceiroJaRealizado(ACodigoEmpresa,
                                                          ADataReferenciaFechamento,
                                                          AExibirMensagem);
  Finally
    FreeAndNil(LFechamento);
  End;
end;

function TILibContasBancariasAutcom.fIMensagem(const strTitulo, strTexto: String;
  arrOpcoes: array of String; intFocoBotao: Integer; blnSaiComEsc: Boolean;
  intEstFon, intWidBut: Integer; blnAutoSize: Boolean;
  intSomarTop: Integer): Integer;
begin
  Result := untFuncoesSimples.fMensagem(strTitulo,
                                        strTexto,
                                        arrOpcoes,
                                        intFocoBotao,
                                        blnSaiComEsc,
                                        intEstFon,
                                        intWidBut,
                                        blnAutoSize,
                                        intSomarTop);
end;

function TILibContasBancariasAutcom.fIPedirLiberacao(ADirAcesso, AMsgSenha,
  ATexto: String): Boolean;
  Var
    LLiberacao : TLiberacao;
Begin
  Try
    LLiberacao := TLiberacao.create;


    LLiberacao.Clear;
    LLiberacao.strDirAce    := ADirAcesso;
    LLiberacao.strMsgSen    := AMsgSenha;
    LLiberacao.strCodOpe    := strLoginUsuarioLogado;
    LLiberacao.objMsgLibera.pAddTexto(ATexto);

    Result := LLiberacao.fLibera;

    If Result Then
      pGeraLogLiberacao('', '', VS_strCodEmp);

  Finally
    FreeAndNil(LLiberacao);
  End;
end;

function TILibContasBancariasAutcom.fIPesqCartao(ASelf: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim, blnSoAtiv, blnMostraDesconto,
  blnCadCar, blnEmpGer, blnVerAce: Boolean; strCodEmp: String): Boolean;
begin
  Result := untConsultas.fPesqCartao(ASelf,
                                     edtCodigo,
                                     edtDescri,
                                     qryTabela,
                                     chrKey,
                                     arrSel,
                                     blnConSim,
                                     blnSoAtiv,
                                     blnMostraDesconto,
                                     blnCadCar,
                                     blnEmpGer,
                                     blnVerAce,
                                     strCodEmp);
end;

function TILibContasBancariasAutcom.fIPesqCartaoBandeira(ASelf: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqCartaoBandeira(ASelf,
                                             edtCodigo,
                                             edtDescri,
                                             qryTabela,
                                             chrKey,
                                             arrSel,
                                             blnConSim);
end;

function TILibContasBancariasAutcom.fIPesqCentroCusto(ASelf: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim, blnUsaCtf: Boolean;
  strCodFor: String; blnVemBxCtc, blnVemBxCh, blnVemBxCtr,
  blnVemBxCta: Boolean): Boolean;
begin
  Result := untConsultas.fPesqCentroCusto(ASelf,
                                          edtCodigo,
                                          edtDescri,
                                          qryTabela,
                                          chrKey,
                                          arrSel,
                                          blnConSim,
                                          blnUsaCtf,
                                          strCodFor
                                          {$IF Declared(VS_VERSAO_72)}
                                          {$ELSE}
                                          ,blnVemBxCtc,
                                          blnVemBxCh,
                                          blnVemBxCtr,
                                          blnVemBxCta
                                          {$ENDIF}
                                          );
end;

function TILibContasBancariasAutcom.fIPesqCliente(opcTipCli: TTipoConsultaCliente;
  ASelf: TForm; edtCodigo: TCustomEdit; edtNomCli: TEditFocus;
  qryTabela: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqCliente(opcTipCli,
                                      ASelf,
                                      edtCodigo,
                                      edtNomCli,
                                      qryTabela,
                                      chrKey,
                                      arrSel,
                                      blnConSim);
end;

function TILibContasBancariasAutcom.fIPesqEmpresa(opcTipCon: TTipoConsultaEmpresa;
  ASelf: TForm; edtCodigo: TCustomEdit; edtNomEmp: TEditFocus;
  qryTabela: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  blnConSim, blnResEmp: Boolean; strEmpresas: String; blnAceCtr: Boolean;
  strAceCtr, strConcil: String): Boolean;
  Var
    arrEmp : TConsultasArray;
begin
  Result := untConsultas.fPesqEmpresa(conEmpSimples,
                                      ASelf,
                                      edtCodigo,
                                      edtNomEmp,
                                      qryTabela,
                                      chrKey,
                                      arrEmp,
                                      blnConSim,
                                      blnResEmp,
                                      strEmpresas,
                                      blnAceCtr,
                                      strAceCtr,
                                      strConcil);
end;

function TILibContasBancariasAutcom.fIPesqEstConcil(ASelf: TForm;
  edtCodigo: TCustomEdit; edtDescri: TEditFocus; var chrKey: Char;
  AObjetoConcil: TCamposConcil; var ArrayConsultas: TConsultasArray): Boolean;
begin
   Result := untConsultas.fPesqEstConcil(ASelf,
                                         edtCodigo,
                                         edtDescri,
                                         Nil,
                                         chrKey,
                                         ArrayConsultas,
                                         AObjetoConcil,
                                         False);
end;

function TILibContasBancariasAutcom.fIPesqEventos(ASelf: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; qryTabela: TUniQuery; var chrKey: Char;
  var arrSel: TConsultasArray; blnConSim, blnFiltroExiFat: Boolean;
  strTipo: string): Boolean;
begin
  Result := untConsultas.fPesqEventos(ASelf,
                                      edtCodigo,
                                      edtDescri,
                                      qryTabela,
                                      chrKey,
                                      arrSel,
                                      blnConSim,
                                      blnFiltroExiFat,
                                      strTipo);
end;

function TILibContasBancariasAutcom.fIPesqFornecedor(opcConFor: TTipoConsultaFornecedor;
  ASelf: TForm; edtCodigo, edtNomEmp: TCustomEdit; qryTabela: TUniQuery;
  var chrKey: Char; var arrSel: TConsultasArray; blnConSim: Boolean): Boolean;
begin
  Result := untConsultas.fPesqFornecedor(opcConFor,
                                         ASelf,
                                         edtCodigo,
                                         edtNomEmp,
                                         qryTabela,
                                         chrKey,
                                         arrSel,
                                         blnConSim);
end;

function TILibContasBancariasAutcom.fIPesqPortador(opcTipPor: TTipoConsultaSimples;
  ASelf: TForm; edtCodigo: TCustomEdit; edtDesPor: TEditFocus;
  qryTabela: TUniQuery; var chrKey: Char; var arrSel: TConsultasArray;
  blnConSim: Boolean; strTitulo, strBolFat: String; blnSalPor,
  blnImpBol: Boolean; strCodEmp: String): Boolean;
begin
  Result := untConsultas.fPesqPortador(opcTipPor,
                                       ASelf,
                                       edtCodigo,
                                       edtDesPor,
                                       qryTabela,
                                       chrKey,
                                       arrSel,
                                       blnConSim,
                                       strTitulo,
                                       strBolFat,
                                       blnSalPor,
                                       blnImpBol,
                                       strCodEmp);
end;

function TILibContasBancariasAutcom.fIPesquisar(ASelf: TForm; edtCodigo: TCustomEdit;
  edtDescri: TEditFocus; var chrKey: Char; ACodPesquisa: String): Boolean;
  Var
    arrConsultas : TConsultasArray;
begin
  Result := False;

  If UpperCase(ACodPesquisa).Equals('ESTANTREDECARD') Then
    Result := untConsultas.fPesqEstAntecipacaoRedeCard(ASelf, edtCodigo, edtDescri, Nil, chrKey,arrConsultas,True);
end;

procedure TILibContasBancariasAutcom.fIRegistraCallStackSeEstiverEmTransacao(
  objConexao: TUniConnection; strTextoComplementarAoCallStack: String);
begin
  untFuncoesSimples.fRegistraCallStackSeEstiverEmTransacao(objConexao,
                                                           strTextoComplementarAoCallStack);
end;

function TILibContasBancariasAutcom.fIRetAutoIncrem(const ATabela,
  AEmpresaLogada: String; AQuantidade: Integer = -1): String;
begin
  Result := untFuncoesSimples.fRetAutoIncrem(ATabela, AEmpresaLogada, AQuantidade);
end;

function TILibContasBancariasAutcom.fIRetCGCEmpresa(
  const ACodigoEmpresa: String): String;
begin
  Result := untFuncoesSimples.fRetCGCEmpresa(ACodigoEmpresa);
end;

function TILibContasBancariasAutcom.fIRetCtpCon(strCodEmp: String;
  blnConexaoAutoincrem: Boolean): Longint;
begin
  Result := fRetCtpCon(strCodEmp, blnConexaoAutoincrem);
end;

function TILibContasBancariasAutcom.fIRetEmpAcessoOperador: String;
begin
  Result := untFuncoesSimples.strEmpAcessoUsuarioLogado;
end;

function TILibContasBancariasAutcom.fIRetEmpresaLogada: String;
begin
  Result := untFuncoesSimples.VS_strCodEmp;
end;

function TILibContasBancariasAutcom.fIRetOperadorLogado: String;
begin
  Result := untFuncoesSimples.strLoginUsuarioLogado;
end;

function TILibContasBancariasAutcom.fIRetPortadoresOperador: String;
begin
  Result := untFuncoesSimples.strPortadoresOperador;
end;

function TILibContasBancariasAutcom.fIRetRcxCon(strCodEmp: String): String;
begin
  Result := fRetRcxCon(strCodEmp);
end;

function TILibContasBancariasAutcom.fIRetSequencial(strNomCam, strCodEmp: String;
  intTamanho: Integer): String;
begin
  Result := untFuncoesSimples.fRetSequencial(strNomCam,
                                             strCodEmp,
                                             intTamanho);
end;

function TILibContasBancariasAutcom.fIRetSequencialCadPag(intQtdCod: Integer;
  AstrEmpresa: String): String;
begin
  Result := untFuncoesSimples.fRetSequencialCadPag(intQtdCod,
                                                   AstrEmpresa);
end;

function TILibContasBancariasAutcom.fIRollBack: Boolean;
begin
  Result := untFuncoesSimples.fRollBack;
end;

function TILibContasBancariasAutcom.fISeqContaBanco(intQtdCod: Integer): String;
begin
  Result := fSeqContaBanco(intQtdCod);
end;

function TILibContasBancariasAutcom.fIStartTransaction: Boolean;
begin
  Result := False;

  If Not fInTransaction Then
    Result := fStartTransaction;
end;

function TILibContasBancariasAutcom.fITelaGravandoAntiga: Boolean;
begin
  Result := {$IF Declared(VS_VERSAO_72)}True{$ELSE}False{$ENDIF};
end;

function TILibContasBancariasAutcom.fIValidarDirEspecificos(var strDireitos: String;
  strLogin, strNomeForm: String): Boolean;
begin
  Result := untFuncoesSimples.fValidarDirEspecificos(strDireitos,
                                                     strLogin,
                                                     strNomeForm);
end;

function TILibContasBancariasAutcom.fIVerificaAcessoSistema(strNomeForm,
  strCodOpe: String): Boolean;
begin
  Result := untFuncoesSimples.fVerificaAcessoSistema(strNomeForm, strCodOpe);
end;

procedure TILibContasBancariasAutcom.pIAdicionarConfiguracao(strCodCfg, strDescri,
  strValCfg, strGruCfg: String; blnDefEmp: Boolean; intNumHlp: Integer;
  strLayout, strPerRep, strUsoCit: String);
begin
  TfrmCfgRepositorio.pAdicionarConfiguracao(strCodCfg,
                                            strDescri,
                                            strValCfg,
                                            strGruCfg,
                                            blnDefEmp,
                                            intNumHlp,
                                            strLayout,
                                            strPerRep,
                                            strUsoCit);
end;

procedure TILibContasBancariasAutcom.pICarregaCadMovCartoes(ADatasetMovCar: TDataset;
  var AAtualizarBaixa: Boolean);
  Var
    LCadMovCartoes: TfrmCadMovCartoes;
begin
  Try
    pCriarFormularios(TfrmCadMovCartoes, LCadMovCartoes);
    LCadMovCartoes.blnChamadoDoManutencao := False;
    LCadMovCartoes.strNumDup := ADatasetMovCar.FieldByName('NRODUP').AsString;
    LCadMovCartoes.strParcel := ADatasetMovCar.FieldByName('PARDUP').AsString;
    LCadMovCartoes.strCodEmp := ADatasetMovCar.FieldByName('MCA_CODEMP').AsString;
    LCadMovCartoes.strCodCli := ADatasetMovCar.FieldByName('MCA_CODCLI').AsString;
    LCadMovCartoes.strDocume := ADatasetMovCar.FieldByName('MCA_DOCUME').AsString;
    LCadMovCartoes.strNumCcd := ADatasetMovCar.FieldByName('MCA_NUMCCD').AsString;

    LCadMovCartoes.ShowModal;

    {$IF Declared(TfrmCadMovCartoes.AtualizarBaixa)}
    AAtualizarBaixa := LCadMovCartoes.AtualizarBaixa;
    {$ELSE}
    AAtualizarBaixa := True;
    {$ENDIF}
  Finally
    FreeAndNil(LCadMovCartoes);
  End;
end;

procedure TILibContasBancariasAutcom.pIExibirRelatorio(const APrograma,
  ADescricao: String; AReport: IReport);
begin
  untFuncoesSimples.pPreviewReport(APrograma, ADescricao, AReport);
end;

procedure TILibContasBancariasAutcom.pIGravarErro(const GravarErro: Boolean;
  const MensagemErro: String; strRelatorio: String = '');
begin
  pGravarErro(GravarErro, MensagemErro, strRelatorio);
end;

procedure TILibContasBancariasAutcom.pIMensagensErro(const MensErro, LocalErro,
  strMensagem: String);
begin
  pMensagensErro(MensErro, LocalErro, strMensagem);
end;

procedure TILibContasBancariasAutcom.pIPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery;
  strCodEmp: String);
begin
  untPesqAux.pPesquisaCadEmp(qryTabOri, qryTabela, strCodEmp);
end;

procedure TILibContasBancariasAutcom.prcIExecutaRelatorio(intCodigoAtalho,
  intChaveDefault: integer; intChavesPossiveis: array of Integer; arrParametros,
  arrValores: array of String; SenderChamada: TObject;
  arrParametrosReadOnly: TArrString; blnExecutarDireto,
  blnExibirMensagem: Boolean; strDirAce: String;
  blnUsuarioLogadoDefaultVerdeVermelho: Boolean;
  objParametrosRelatorio: TObject);
begin
  If Assigned(untFuncoesRel.prcExecutaRelatorio) Then
  {$IF Declared(VS_VERSAO_72)}
    untFuncoesRel.prcExecutaRelatorio(intCodigoAtalho,
                                      intChaveDefault,
                                      intChavesPossiveis,
                                      arrParametros,
                                      arrValores,
                                      SenderChamada,
                                      arrParametrosReadOnly,
                                      blnExecutarDireto,
                                      strDirAce,
                                      blnExibirMensagem);
  {$ELSE}
    untFuncoesRel.prcExecutaRelatorio(intCodigoAtalho,
                                      intChaveDefault,
                                      intChavesPossiveis,
                                      arrParametros,
                                      arrValores,
                                      SenderChamada,
                                      arrParametrosReadOnly,
                                      blnExecutarDireto,
                                      blnExibirMensagem,
                                      strDirAce,
                                      blnUsuarioLogadoDefaultVerdeVermelho,
                                      objParametrosRelatorio As TParametrosRelatorio);
  {$ENDIF}
end;

end.
