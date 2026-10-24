unit untUtil;

interface
{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

uses Windows, SysUtils, Classes,
  {$IF Defined(UNIDAC)}
    Uni, System.Generics.Collections,
  {$ELSE}
    ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  StrUtils, Dialogs, Forms, PSAPI, TLHelp32, DB, DateUtils,
  IniFiles, untModulo, Controls, StdCtrls, Graphics, cxProgressBar,
  Buttons, LbClass, LbCipher, LbUtils, ShellApi, WinSock, Registry,
  Faturamento.Classes.CNPJ;

Const
  consTagSinalParaTerminar = '<TERMINAR>';
  consTagSinalParaBloquear = '<BLOQUEAR>';

Type
  TprcScroll = procedure (DataSet: TDataSet) Of Object;

Type
  TCopia = function(pgbSts: TcxProgressBar; strArqPnl, strArqLoc: AnsiString; blnCopiarJRE6: Boolean; blnRemoveJRE6: Boolean=False): Boolean;
  TLimpaTodasTravas = procedure of object;

Type
  TPais = (opcBrasil, opcParaguai);

type
  TProcessInfo = record
    pid: Cardinal;
    name: string;
    path: string;
  end;

type
  TProcessInfoArray = Array of TProcessInfo;

procedure pAbrirBanco(Var frmModulo: TfrmModulo);
procedure pConectarBanco(frmModulo: TfrmModulo);
procedure pDefinirCharsetConexao;
procedure pFecharBanco(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
procedure pPedeSenhaDestravarCodAut;
function fPCitelCorrigeErros: Boolean;
function fPCitelGravaDocJson: Boolean;
procedure pCarregarConfiguracoes;
function fDadosEmitenteStatusServico(Var strCnpj, strIes, strUF: String; Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
procedure pAtualizaMotivoCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo: String);
procedure pAtualizaDadosConsumidor(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli,
                                   strNomCli, strEndere, strBairro, strNumCep, strCidade,
                                   strTelCon, strCgcCpf, strNumCgc, strInsEst, strRgCli, strEmail: String);

procedure pCriarArquivoAbertura;
procedure pDeletar(strArquivo: String);
procedure GetFiles(strPath: string; stlArquivos: TStrings);

function fRemoveAcento(Str:String): String;
function GetParentFolder(folder: String; const cLevels: Byte = 1) : String;

procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
function fAjustaDataSistema: Boolean;
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
function fPathOpcoesIni: String;
function fCriaQuery(AOwner: TComponent = Nil; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
function fEmptyStr(const AString: String) : Boolean;
function IfEmptyStr(const AString, AStringDefault: String): String;
function fProcessosSemCliFor:String;
function CountFiles(strPath: String; arrExisteOsArquivos: Array Of String; strFilter: String='*.*'; blnDirOnly: Boolean=False): Integer;
function fStringRepetida(Const strString: String): Boolean;
function fTiraCaracEspeciais(strTexto: String; blnUsaLista: Boolean = True; blnTiraEspacos: boolean = False; blnTiraPontos: boolean = False): String;
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
function fRetNomeEmpresa(strCodEmp: String): String;
function fSenhaDestravarCodAut(strSenDig: String): Boolean;
function fStrZero(Zeros:string;Quant:integer):String; overload;
function fStrZero(Zeros:Integer;Quant:integer):String; overload;

function fCfgSis(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; blnUsarCache: Boolean = True): Variant;
function fCfgSisPainel(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; blnUsarCache: Boolean = True; strCodEmp: String = ''): String;
procedure pAtuCfgSisPainel(strCodCfg, strDescri, strValor: String);
function fCfgExiste(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
function fStrToFloat(strValor: String): Double;
function fRetornaMotivoCancelamento(const strNumDoc, strEspDoc, strCodEmp,
  strSerie, strTip_FC: String): String;

function fConnectionID: String;
function fExisteConfiguracao(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; strCodEmp: String = ''): Boolean;
function ffrmSenha(var strSenha: string; strTitulo: String = ''): Boolean;
function fGetLock(strCodEmp: String): Boolean;

procedure pAtualizarVersaoInfSis;
function fRetornaVersao(strNomArq: String = ''; blnProductVersion : Boolean = False): String;
function fTamanhoArquivo(strArquivo: String): Cardinal;
function fCampoExiste(const strTabela, strCampo: String;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
function fTabelaExiste(const strTabela: String;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
function fGetValorLinha(strLinha, strDelimitador: String; intColuna: Integer): String;
procedure pCopiarNFePrinterLocalExe;
procedure pCopiarNFePrinterLocalJar;
procedure pCopiarPDFToPrinter;
function fVerificaDiretorioLocal(strPathLocal: String): Boolean;
function fRealizaCopiaLocal(strArqPnl, strArqLoc: String; blnCopiarJRE6: Boolean=False): Boolean;
procedure pGravaLogNfePrinter(intCodigo: Integer; strMsg: String);
function fRetornaMD5(strNomeArq: String): String;

Procedure pMensagemOk(strMensagem: String);
function fRetornaInformacaoUltimoErroForeignKey: String;

function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean=True): boolean;

function KillProcess(AImage: String): Boolean; overload;
function KillProcess(pid: cardinal): Boolean; overload;
function FindProcess(pid: Cardinal): boolean; overload;
function FindProcess(AExeName: string): TProcessInfoArray; overload;
function StartProcess(Exename, CmdLineArgs: String; ShowWindow, WaitForFinish: boolean): Cardinal;

function GetPathFromPID(const PID: Cardinal): string;

procedure pGravarNFeLocal;

function GetIPAddress: Integer;
function GetIPAddressAsString: String;
procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
function fValidaChaveAcessoNFE(strChaveAcesso : String):Boolean;
function MessageDlgCaptions(const Msg: String; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
  Caption: array of String; dlgcaption: String; DefaultButton:TMsgDlgBtn = mbYes): Integer;
function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
Function fTestaCgc(xCGC: String):Boolean;
function fTiraCaracEspeciaisPonto(strTexto: String): String;
function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String;

function fCriarConexao: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
function fConexaoAtiva(Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
function fRetornaTamanhoCampo(strTabela, strCampo: String): Integer;

function fCampoTabela(strCampo : String;
                      strNomTab: String;
                      arrCampoChave: Array Of String;
                      arrValorChave: Array Of Variant;
                      Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
                      strOrderBy: String = ''): Variant;

function fCurrentTime: String;
function fCurrentDate: String; Overload;
function fCurrentDate(Const Value: TDateTime): String; Overload;
function fCurrentDateTime: String; Overload;
function fCurrentDateTime(Const Value: TDateTime): String; Overload;
procedure pLog(strValor: String);
procedure pLogImp(const strValor: String);
function GetComputerNetName: string;
function GetMacAddress: String;
function GetUserFromWindows: string;
function ShellExecuteAndWait(Operation, FileName, Parameter, Directory: String; Show: Word; bWait: Boolean): Longint;
function fAplicativoInstalado(Aplicativo: string): Boolean;
function fUsuarioWindowsComDireitoDeAcesso: Boolean;
function fMontaDataHora(strDataHora: String): TDateTime;
function fRetEmpresaFisica(conexao: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): String;
function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
function fUsaSat(strCodEmp : String = '') : Boolean;
function fUsaNotaServicoEletronicaEnotas: Boolean;
procedure pAtualizaMensagemLogSAT(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strMensagem: String);
function fNormalizaNomeImpressora(const AstrNomeImpressora: String): String ;

procedure pConfiguraOpcoesRegionais;

procedure pSinalizarAoCoordenadorStatusParaTerminarAposUltimaTarefa;
procedure pSinalizarAoCoordenadorStatusParaSeAutoBloquear;

function fBlinda(const S: string): string;
function fTabulaTexto(const Linhas: TStrings; const Separador: Char = '|'; const UniformWidth: Boolean = True; const IncluirLinhaAposCabecalho: Boolean = True;
                      const StartMarker: string = '<[.'; const EndMarker: string = '.]>'; const RemoveMarkersFromOutput: Boolean = True): string;

function fFindProcessOK: Boolean;
procedure pDeletaTarefa(const strTarefa, strProcId, strCodEmp: String);
procedure pRemoverTarefasInativas(blnLimparTodas: Boolean = False);
function fPainelNFeNoTSPlus: Boolean;
procedure pEncerrarTodosProcessosNFeStatus;
procedure pPegaDataHoraSistema(Var dtaDtaSis, dtaHraSis : TDateTime);
procedure DefinirTimeZoneEmSessaoMySql(const ACodigoEmpresa : String);
function CfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String): String;
function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
function fDataValida(dtaData: TDateTime): Boolean;
procedure pUpdateCfgSis(const strCodCfg, strCodEmp, strValCfg : String);
function fExisteDocumentosEmContingenciaComPendenciaDeAutorizacao(const strEspecie : String): Boolean;
function fPainelEmAmbienteHomologacao(ACodigoEmpresa: String): Boolean;
function fRetornaURLPainelCitel(ACodigoEmpresa: String): String;
function fValidaURLPainelCitel(ACodigoEmpresa: String): Boolean;
function fIntegracaoPainelCitelConfigurada(ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
function fIntegracaoPainelCitelDownloadNotasDeTerceirosConfigurada(ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
function fIntegracaoPainelCitelDownloadConhecimentosDeTerceirosConfigurada(ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
function fExistemRegistrosPendentesIntegracaoPainelCitel(AStatus, ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
function fRetornaCaminhoLimparDiretorioDanfe: String;
function fDirectoryIsEmpty(Directory: String): Boolean;
procedure SetLogDanfe;
function fGetStrIndicadoraLockPainelAberto(const strCodEmp, strDB_: String): String;
function fPermiteMultiplosGetLock(const strCodEmp: String): Boolean;
function fGetConIDAtivo(const strConID_: String): Boolean;
function fGetConIDPainelAberto(const strCodEmp: String): String;
function fRetornaInformacoesLogAce(const strConID_, strCodEmp, strNomExe: String; blnIdent: Boolean = True): String;
function fPainelEstaAberto(const strCodEmp: String): Boolean;
function fEmpresaNesteServidor(const strCodEmp: String; blnMostraMensagem: Boolean=True): Boolean;
function fPodeAbrirPainel(const strCodEmp: String): Boolean;
function fGetPalavrasBusca(edt: TEdit): TStringList;
function fSegundosToInterval(fltSegundos: Double): Integer;
function fMinutosToInterval(fltMinutos: Double): Integer;
function fHoraToInterval(fltHora: Double): Integer;
function fEstaNoPainelNFe: Boolean;
function fGetPastasPainel(const strFiltroPasta: String='PainelNFE'): Integer;
function fEstaNoPainelNFeGeral: Boolean;
function fCfgAtiva(aValCfg: String): Boolean;
procedure pGravaLogErr(const strDescri, strValRel: WideString; blnVerificarSeJaGravouHoje: Boolean=False);

Var
  VS_VersaoMySQLPermiteMultiplosGetLock : String;
  VS_ExecutarApenasTarefasPainelWebCitel: String;
  VS_strCodEmp: String;
  VS_stlTabNre: TStringList;
  VS_strTabelaErro: String;

  VS_MacAddress        : String;
  VS_IPAddressAsString : String;
  VS_UserFromWindows   : string;
  VS_ComputerNetName   : string;
  VS_NumSerSat         : string;
  VS_PathSat           : string;
  VS_ImpressoraSat     : string;
  VS_SomenteImpressao  : Boolean;
  VS_PCitelCorrigeErros: Boolean;
  VS_PCitelGravaDocJson: Boolean;
  VS_horUltimoRemoverTarefasInativas: TDateTime;
  VS_LimpaTodasTravas: TLimpaTodasTravas ;

  VS_GravaUsuRep  : string;
  VS_LogRepConId  : string;
  VS_LogRepCodOp  : string;
  VS_ConnectionID : string;
  VS_FindProcesOK : string;

Const
  ERRO_NFE_PRINTER_NAO_EXISTE = 1;
  ERRO_NFE_PRINTER_DIRETORIO_NAO_CRIADO = 2;
  ERRO_NFE_PRINTER_NAO_COPIOU_ARQUIVO = 3;
  ERRO_NFE_PRINTER_MD5_INCONSISTENTE = 4;
  ERRO_NFE_PRINTER_COPIADO_COM_SUCESSO = 99;

  PATH_NFE_PRINTER_LOCAL: String = 'C:\NFEPRINTER\';
  ARQUIVO_NFE_PRINTER_LOCAL: String = 'C:\NFEPRINTER\nfe-printer.exe';
  ARQUIVO_NFE_PRINTER_JAR_LOCAL: String = 'C:\NFEPRINTER\FIT_PRINTER.jar';
  ARQUIVO_PDF_TO_PRINTER: String = 'C:\NFEPRINTER\PDFtoPrinter.exe';
  DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION = ' SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; ';

{$IFDEF LINUX}
  PATH_SEPARATOR = '/';
{$ELSE}
  PATH_SEPARATOR = '\';
{$ENDIF}

implementation

uses
  {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}
  System.UITypes,
  {$IFEND}
  {$IF Defined(UNIDAC)} untModuloReplicacao {$ELSE} untModuloReplicacaoZeos {$IFEND},
  untConfiguracoes, untGravando, untLogDanfe, untDicSis;

{**************************************}
{* CRIA UMA QUERYNOVA PARA SER USADA  *}
{* PS. ATE QUE ENFIM ALGUEM FEZ ISSO  *}
{***********************************AF*}
function fCriaQuery(AOwner: TComponent = Nil;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  {$IF Defined(UNIDAC)}
  Result := TUniQuery.Create(AOwner);
  {$ELSE}
  Result := TZQuery.Create(AOwner);
  {$IFEND}

  {$IF Defined(VER250) Or Defined(UNIDAC)}
  Result.BeforeExecute := TQueryLog.BeforeExecute;
  {$ELSE}
  Result.BeforeOpen := TQueryLog.BeforeOpen;
  {$IFEND}

  If Assigned(Banco) Then
  Begin
    Result.Connection := Banco;
  End
  Else
  Begin
    Result.Connection  := frmModulo.Database;
  End;
End;

  {*****************************************}
  {* EFETUA A CONEXÃO COM O BANCO.         *}
  {**************************************MV*}
procedure pConectarBanco(frmModulo: TfrmModulo);
  Var
    intCodAut: Integer;
    libUtil: Cardinal;
    arrStr: Array [0..255] Of AnsiChar;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;
    pSetaArquivoOpcoes: procedure(strArquivo: PAnsiChar); stdcall;

  function fUsarSenhaDLL: Boolean;
  begin
    intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0', fPathOpcoesIni), 0);
    Result := (intCodAut > 0) And (FileExists('libUtil.dll'));
  end;

begin
  frmModulo.Database.Disconnect;
  frmModulo.Database.Database := '';

  {$IF Defined(UNIDAC)}
    frmModulo.Database.Server   := '';
  {$ELSE}
    frmModulo.Database.HostName := '';
  {$IFEND}

  If fUsarSenhaDLL Then
  Begin
    libUtil := LoadLibrary(PChar('libUtil.dll'));
    Try
      fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
      fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));
      pSetaArquivoOpcoes := GetProcAddress(libUtil, PChar('pSetaArquivoOpcoesPChar'));

      If Assigned(pSetaArquivoOpcoes) Then
      Begin
        pSetaArquivoOpcoes(StrPCopy(arrStr, AnsiString(fPathOpcoesIni)));
      End;
      {$IF Defined(UNIDAC)}
        frmModulo.Database.Username := String(StrPas(fRetornaUsuario));
      {$ELSE}
        frmModulo.Database.User := String(StrPas(fRetornaUsuario));
      {$IFEND}
      frmModulo.Database.Password := String(StrPas(fRetornaSenha));
    Finally
      FreeLibrary(libUtil);
    End;
  End
  Else
  Begin
    {$IF Defined(UNIDAC)}
      frmModulo.Database.Username := 'root';
    {$ELSE}
      frmModulo.Database.User := 'root';
    {$IFEND}
    frmModulo.Database.Password := 'citel13347';
  End;

  {$IF Defined(UNIDAC)}
    frmModulo.Database.Server   := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP','', fPathOpcoesIni), ' ', '');
  {$ELSE}
    frmModulo.Database.Hostname := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP','', fPathOpcoesIni), ' ', '');
  {$IFEND}
  frmModulo.Database.Database := fArqIni(0,'BANCO','NOMBAN','', fPathOpcoesIni);
  frmModulo.Database.Port     := StrToIntDef(fArqIni(0,'BANCO','PORTA','', fPathOpcoesIni), 3306);

  frmModulo.Database.Connect;

  pGeraRegistroParaLogGeneral(frmModulo.Database, 'Inicializacao');

  pDefinirCharsetConexao;
End;

{***********************************}
{* Abrir Banco de Dados do Sistema *}
{********************************DV*}
procedure pAbrirBanco(Var frmModulo: TfrmModulo);
  Const
    ERROR_USUARIO_SENHA_INV =  1045;
  Var
    intCodAut: Integer;
    blnReconectar: Boolean;

  procedure pMsgErro(E: Exception);
  begin
    MessageDlg('Abertura do Banco de Dados: ' + E.Message, mtError, [mbOk], 0);
    If Not KillProcess(GetCurrentProcessId) Then
      Application.Terminate;
  end;
begin

  blnReconectar := False;
  Application.CreateForm(TfrmModulo, frmModulo);
  Application.CreateForm(TfrmModuloReplicacao, frmModuloReplicacao);
  intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0', fPathOpcoesIni), 0);

  Try
    pConectarBanco(frmModulo);
  Except
    {$IF Defined(UNIDAC)}
      On E: EUniError Do
      Begin

        {*****************************************}
        {* NÃO CONECTOU POIS A SENHA ESTAVA      *}
        {* INCORRETA. VAI TENTAR COM OUTRA SENHA *}
        {**************************************MV*}
        If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
        Begin
          blnReconectar := True;
          If intCodAut = 0 Then
            fArqIni(1, 'GERAL', 'CODAUT', '1', fPathOpcoesIni);
        End
        Else
        Begin
          pMsgErro(E);
          Exit;
        End;

      End;
    {$ELSE}
      On E: EZSQLException Do
      Begin

        {*****************************************}
        {* NÃO CONECTOU POIS A SENHA ESTAVA      *}
        {* INCORRETA. VAI TENTAR COM OUTRA SENHA *}
        {**************************************MV*}
        If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
        Begin
          blnReconectar := True;
          If intCodAut = 0 Then
            fArqIni(1, 'GERAL', 'CODAUT', '1', fPathOpcoesIni);
        End
        Else
        Begin
          pMsgErro(E);
          Exit;
        End;

      End;
    {$IFEND}

    On E : Exception Do
    Begin
      pMsgErro(E);
      Exit;
    End;
  End;

  {*****************************************}
  {* A SENHA ESTAVA INCORRETA IRÁ TENTAR   *}
  {* COM A OUTRA SENHA.                    *}
  {**************************************MV*}
  If blnReconectar Then
  Begin
    Try
      pConectarBanco(frmModulo);
    Except
      {$IF Defined(UNIDAC)}
        On E: EUniError Do
        Begin
          {*****************************************}
          {* CASO ESTEJA CONECTANDO COM A NOVA     *}
          {* SENHA, E A MESMA ESTEJA INCORRETA, É  *}
          {* PORQUE O IMPLANTADOR COPIOU A PASTA.  *}
          {* NESTE CASO, TEM QUE LIGAR NA CITEL    *}
          {* PARA PEDIR UMA SENHA E LEVAR UMA      *}
          {* ADVERTÊNCIA, POIS NÃO É PARA COPIAR.  *}
          {**************************************MV*}
          If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
          Begin
            pPedeSenhaDestravarCodAut;
            If Not KillProcess(GetCurrentProcessId) Then
              Application.Terminate;
            Exit;
          End
          Else
          Begin
            pMsgErro(E);
            Exit;
          End;
        End;
      {$ELSE}
        On E: EZSQLException Do
        Begin
          {*****************************************}
          {* CASO ESTEJA CONECTANDO COM A NOVA     *}
          {* SENHA, E A MESMA ESTEJA INCORRETA, É  *}
          {* PORQUE O IMPLANTADOR COPIOU A PASTA.  *}
          {* NESTE CASO, TEM QUE LIGAR NA CITEL    *}
          {* PARA PEDIR UMA SENHA E LEVAR UMA      *}
          {* ADVERTÊNCIA, POIS NÃO É PARA COPIAR.  *}
          {**************************************MV*}
          If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
          Begin
            pPedeSenhaDestravarCodAut;
            If Not KillProcess(GetCurrentProcessId) Then
              Application.Terminate;
            Exit;
          End
          Else
          Begin
            pMsgErro(E);
            Exit;
          End;
        End;
      {$IFEND}

      On E: Exception Do
      Begin
        pMsgErro(E);
        Exit;
      End;
    End;

  End;

end;

procedure pDefinirCharsetConexao;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery;

  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SET character_set_connection = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_client = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_database = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_results = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_server = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_connection = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_database = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_server = latin1_swedish_ci');
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure pFecharBanco(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
begin
  pGeraRegistroParaLogGeneral(Database, 'pFecharBanco > Database.Disconnect');

  Try
    If Database.InTransaction = True Then
      Database.Rollback;

    Database.Disconnect;
  Except
    On E : Exception do
    Begin
      MessageDlg('Fechamento do Banco de Dados: ' + E.Message, mtError, [mbOk], 0);
      If Not KillProcess(GetCurrentProcessId) Then
        Application.Terminate;
    End;
  End;
end;

function fEmptyStr(const AString: String) : Boolean;
begin
  Result := fEmptyStrDicSis(AString);
end;

function IfEmptyStr(const AString, AStringDefault: String): String;
begin
  Result := IfEmptyStrDicSis(AString, AStringDefault);
end;

function fProcessosSemCliFor:String;
begin
  Result := 'EM_GM_CE_CG_';
end;

{**********************************************************}
{* Lê/Grava dados no arquivo de Configuracao (Opcoes.ini) *}
{*******************************************************DV*}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
  Begin
    strNomArq := 'opcoes.ini';
    iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + strNomArq);
  End
  else
  begin
    If fEmptyStr(ExtractFilePath(strNomArq)) Then
      strNomArq := ExtractFilePath(Application.ExeName) + '\' + strNomArq;
    iniArqIni := TIniFile.Create(strNomArq);
  end;

  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function fPathOpcoesIni: String;
  Var
    strPath : String;
begin
  Result := '';

  If FileExists(ExtractFilePath(Application.ExeName) + 'opcoespainel.ini') Then
  Begin
    strPath := Trim(fArqIni(0, 'GERAL', 'PATATC', '', ExtractFilePath(Application.ExeName) + 'opcoespainel.ini'));

    If (Not fEmptyStr(strPath)) Then
    Begin
      If (RightStr(strPath, 1) <> PATH_SEPARATOR) Then
        strPath := strPath + PATH_SEPARATOR;
    End;

    If (Not fEmptyStr(strPath)) And (DirectoryExists(strPath)) Then
    Begin
      If FileExists(strPath + 'opcoes.ini') Then
        Result := strPath + 'opcoes.ini';
    End;
  End
  Else If FileExists(ExtractFilePath(Application.ExeName) + 'opcoes.ini') Then
    Result := ExtractFilePath(Application.ExeName) + 'opcoes.ini';
end;

procedure pPedeSenhaDestravarCodAut;
  Var
    strSenha: String;
begin
  strSenha := '';
  While (InputQuery('Senha para destravamento', 'Ligue na citel e peça a senha para destavamento', strSenha)) Do
  Begin

    If fSenhaDestravarCodAut(strSenha) Then
    Begin
      fArqIni(1, 'GERAL', 'CODAUT', '0');
      ShowMessage('Destravado!');
      Break;
    End;

  End;
end;

function fSenhaDestravarCodAut(strSenDig: String): Boolean;
  Var
    wrdAno,
    wrdMes,
    wrdDia: Word;
    intSenLib: Integer;
    intContador: Integer;
    strSenDec: String;
  Const
    intFatMul = 6;
begin
  DecodeDate(Date, wrdAno, wrdMes, wrdDia);

  intSenLib := wrdDia + wrdMes;

  For intContador := 1 To Length(IntToStr(wrdAno)) Do
  Begin
    intSenLib := intSenLib + StrToInt(Copy(IntToStr(wrdAno), intContador, 1));
  End;

  intSenLib := intSenLib + StrToInt(RightStr(strSenDig, 3));

  intSenLib := intSenLib * intFatMul;

  strSenDec := fStrZero(intSenLib, (Length(strSenDig)-3));

  strSenDec := strSenDec + RightStr(strSenDig, 3);

  //********************************************************//
  // VERIFICA SE A SENHA CALCULADA E IGUAL A SENHA DIGITADA //
  //*****************************************************ED*//
  Result := (strSenDec = strSenDig);

end;

{***************************************}
{* Insere Zeros à frente de uma string *}
{************************************DV*}
function fStrZero(Zeros:string;Quant:integer):String;
Var
	I,Tamanho:integer;
	Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

{***************************************}
{* Insere Zeros à frente de uma string *}
{************************************MA*}
function fStrZero(Zeros:Integer;Quant:integer):String;
begin
  fStrZero := fStrZero(IntToStr(Zeros),Quant);
end;

function fCfgSis(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; blnUsarCache: Boolean = True): Variant;
  Var
    qryGenCfg: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strValCfg: String;
    strMsgErr: String;
    {$IF Defined(UNIDAC)}
    strKey: String;
    strValAux: String;
    {$IFEND}
begin
  qryGenCfg := fCriaQuery(Nil, Banco);
  Try
    If Not fEmptyStr(strCamCfg) Then
    Begin
      If fEmptyStr(strCodEmp) Then
        strCodEmp := VS_strCodEmp;

      {$IF Defined(UNIDAC)}
      strValAux := '';
      strKey := fFormataKeyValCfgParaDicSis(strCamCfg, strCodEmp);
      If blnUsarCache And Assigned(VS_dicDicSis) And fAchouDicSisStr(qryGenCfg.Connection, strKey, strValAux) Then
        strValCfg := strValAux
      Else
      {$IFEND}
      Begin
        With qryGenCfg Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT  SQL_NO_CACHE       ');
          SQL.Add('  SIS_VALCFG               ');
          SQL.Add('FROM                       ');
          SQL.Add('  CFGSIS                   ');
          SQL.Add('WHERE                      ');
          SQL.Add('  SIS_CODEMP = :CODEMP AND ');
          SQL.Add('  SIS_CODCFG = :CODCFG     ');

          ParamByName('CODEMP').Value := strCodEmp;
          ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;

          Open;

          If IsEmpty Then
          Begin
            strMsgErr := 'A configuração ( ' + 'CFG_' + strCamCfg + ' ) não existe.';
            pLogImp(strMsgErr);
            Raise Exception.Create(strMsgErr);
          End;

          strValCfg := FieldByName('SIS_VALCFG').AsString;
        End;

        {$IF Defined(UNIDAC)}
        If Assigned(VS_dicDicSis) Then
          pInsereDicSis(qryGenCfg.Connection, strKey, strValCfg);
        {$IFEND}
      End;

      Case varTipVar Of
        varString : Result := strValCfg;

        varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0
                        Else
                          Result := StrToIntDef(strValCfg, 0);
                      Except
                        Result := 0;
                      End;
                    End;

        varDouble, varCurrency:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0.00
                        Else
                          Result := fStrToFloat(AnsiReplaceStr(strValCfg,'.',','));
                      Except
                        Result := 0.00;
                      End;
                    End;

        varDate:
                   Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0
                        Else
                          Result := StrToDateTimeDef(strValCfg, 0);
                      Except
                        Result := 0;
                      End;
                   End;

        varBoolean:
                   Begin
                     Try
                       If fEmptyStr(strValCfg) Then
                         Result := False
                       Else If Pos(strValCfg, 'S_N_') > 0 Then
                         Result := StrToBool(IfThen(strValCfg = 'S', 'True', 'False'))

                       Else If Pos(strValCfg, '0_1_') > 0  Then
                         Result := StrToBool(IfThen(strValCfg = '1', 'True', 'False'))
                       Else
                         Result := StrToBoolDef(strValCfg, False);

                     Except
                       Result := False;
                     End;

                   End;
        Else
          Result := strValCfg;
      End;

    End;

  Finally
    If Assigned(qryGenCfg) Then
      FreeAndNil(qryGenCfg);
  End;

end;

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA STRTOFLOAT EM UM    *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function fStrToFloat(strValor: String): Double;
Begin

  Result := StrToFloatDef(AnsiReplaceStr(strValor,'.',''), 0);

End;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  Begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  End;

  Result := strAux;
end;

function fPCitelCorrigeErros: Boolean;
var
  LPCitelCorrigeErros: String;
begin
  Result := True;

  LPCitelCorrigeErros := fArqIni(0, 'GERAL', 'PCITEL_CORRIGE_ERROS', '', 'opcoespainel.ini');

  If fEmptyStr(LPCitelCorrigeErros) Then
    Exit;

  If not (LPCitelCorrigeErros = 'N') Then
    Exit;

  Result := False;
end;

function fPCitelGravaDocJson: Boolean;
var
  LPCitelGravaDocJson: String;
begin
  Result := False;

  LPCitelGravaDocJson := fArqIni(0, 'GERAL', 'PCITEL_GRAVA_JSON', '', 'opcoespainel.ini');

  If fEmptyStr(LPCitelGravaDocJson) Then
    Exit;

  If not (LPCitelGravaDocJson = 'S') Then
    Exit;

  Result := True;
end;

procedure pCarregarConfiguracoes;
  Var
    strMsgAux,
    strTarefa,
    strCodEmp: String;
begin
  If fParametrosMisturados(strMsgAux) Then
  Begin
    If fEstaNoPainelNFe Then
      Application.MessageBox(PChar(strMsgAux), 'Atenção', MB_OK+MB_ICONWARNING);

    pLogImp(strMsgAux);

    If Not KillProcess(GetCurrentProcessId) Then
      Application.Terminate;
  End;

  VS_strCodEmp := fArqIni(0, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini');

  If (fArqIni(0, 'GERAL', 'PNLCIT', '', 'opcoespainel.ini') = 'S') Then
    VS_ExecutarApenasTarefasPainelWebCitel := 'S';

  pRetornaParamSeExistir(consTagParamsTrf, strTarefa, True);
  pRetornaParamSeExistir(consTagParamsEmp, strCodEmp, True);

  //CHAMADAS COM PARÂMATROS SEM TAG (MODO ANTIGO)...
  strTarefa := IfEmptyStr(strTarefa, ParamStr(1));
  strCodEmp := IfEmptyStr(strCodEmp, ParamStr(4)); //TAREFA NFE_PROCESSAR_STATUS POR POS A EMPRESA FICA NO ParamStr(4)
  //...CHAMADAS COM PARÂMATROS SEM TAG (MODO ANTIGO)

  If (Not fEstaNoPainelNFe) Then
    If (Length(strCodEmp) = 3) Then
      VS_strCodEmp := strCodEmp;

  VS_PCitelCorrigeErros := fPCitelCorrigeErros;
  VS_PCitelGravaDocJson := fPCitelGravaDocJson;

  If (fEmptyStr(fPathOpcoesIni)) Or (Not FileExists(fPathOpcoesIni)) Then
  Begin
    Application.MessageBox('Será necessário realizar algumas configurações para o correto funcionamento do PainelNFe.', 'Atenção', MB_OK+MB_ICONWARNING);

    Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
    Try
      If (frmConfiguracoes.ShowModal = mrOk) Then
      Begin
        If (Not frmConfiguracoes.ckbMulti.Checked) Then
          VS_strCodEmp := fArqIni(0, 'GERAL', 'EMPPNL', '', 'opcoespainel.ini');
      End
      Else
      Begin
        If Not KillProcess(GetCurrentProcessId) Then
          Application.Terminate;
      End;
    Finally
      FreeAndNil(frmConfiguracoes);
    End;
  End;

  VS_strCodPnlDir := VS_strCodEmp;
end;

function fDadosEmitenteStatusServico(Var strCnpj, strIes, strUF: String;
  Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
  Var
    qryEmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryEmp := fCriaQuery(Nil, Database);
  Try
    Try
      qryEmp.Close;
      qryEmp.SQL.Clear;
      qryEmp.SQL.Add('SELECT EMP_C_G_C_, ');
      qryEmp.SQL.Add('       EMP_I_E_S_, ');
      qryEmp.SQL.Add('       CID_ESTADO  ');
      qryEmp.SQL.Add('  FROM CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ');
      qryEmp.SQL.Add(' WHERE EMP_CODEMP = :CODEMP');
      qryEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryEmp.Open;

      strCnpj := qryEmp.FieldByName('EMP_C_G_C_').AsString;
      strIes  := qryEmp.FieldByName('EMP_I_E_S_').AsString;
      strUF   := qryEmp.FieldByName('CID_ESTADO').AsString;

      Result := True;

      qryEmp.Close;
    Finally
      FreeAndNil(qryEmp);
    End;
  Except
    Result := False;
  End;
end;

function fRetornaMotivoCancelamento(const strNumDoc, strEspDoc, strCodEmp,
  strSerie, strTip_FC: String): String;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  MOTDEL ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  DEL_MOVGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_TIP_FC = :TIP_FC AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.SQL.Add('UNION ALL ');

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  MOTDEL ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  DEL_NOTGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_TIP_FC = :TIP_FC AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.Open;

  Result := qryAux.FieldByName('MOTDEL').AsString;

  FreeAndNil(qryAux);
end;

procedure pAtualizaMotivoCancelamento(const strNumDoc, strEspDoc, strCodEmp,
  strSerie, strMotivo: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  MOTDEL ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  DEL_MOVGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  DEL_MOVGER ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  MOTDEL = :MOTDEL ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');
  End
  Else
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  DEL_NOTGER ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  MOTDEL = :MOTDEL ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');
  End;

  qryAux.ParamByName('MOTDEL').AsString := strMotivo;

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);

end;

procedure pAtualizaDadosConsumidor(strNumDoc, strEspDoc, strCodEmp, strSerie,  strCodCli,
                                   strNomCli, strEndere, strBairro, strNumCep, strCidade,
                                   strTelCon, strCgcCpf, strNumCgc, strInsEst, strRgCli, strEmail: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GER_NUMDOC ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  MOVGER ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  GER_NOMCON = :NOMCON, ');
    qryAux.SQL.Add('  GER_ENDCON = :ENDCON, ');
    qryAux.SQL.Add('  GER_BAICON = :BAICON, ');
    qryAux.SQL.Add('  GER_CEPCON = :CEPCON, ');
    qryAux.SQL.Add('  GER_CIDCON = :CIDCON, ');
    qryAux.SQL.Add('  GER_TELCON = :TELCON, ');
    qryAux.SQL.Add('  GER_CGCCPF = :CGCCPF, ');
    qryAux.SQL.Add('  GER_CGCCON = :CGCCON, ');
    qryAux.SQL.Add('  GER_IESCON = :IESCON, ');
    {***************************************************}
    {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
    {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
    {************************************************RV*}
    If fCampoExiste('MOVGER', 'GER_EMLCON') Then
      qryAux.SQL.Add('  GER_EMLCON = :EMLCON, ');

    qryAux.SQL.Add('  GER_R_GCON = :R_GCON  ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');
  End
  Else
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ');
    qryAux.SQL.Add('  NOTGER ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  GER_NOMCON = :NOMCON, ');
    qryAux.SQL.Add('  GER_ENDCON = :ENDCON, ');
    qryAux.SQL.Add('  GER_BAICON = :BAICON, ');
    qryAux.SQL.Add('  GER_CEPCON = :CEPCON, ');
    qryAux.SQL.Add('  GER_CIDCON = :CIDCON, ');
    qryAux.SQL.Add('  GER_TELCON = :TELCON, ');
    qryAux.SQL.Add('  GER_CGCCPF = :CGCCPF, ');
    qryAux.SQL.Add('  GER_CGCCON = :CGCCON, ');
    qryAux.SQL.Add('  GER_IESCON = :IESCON, ');
    {***************************************************}
    {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
    {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
    {************************************************RV*}
    If fCampoExiste('MOVGER', 'GER_EMLCON') Then
      qryAux.SQL.Add('  GER_EMLCON = :EMLCON, ');
      
    qryAux.SQL.Add('  GER_R_GCON = :R_GCON  ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');
  End;

  qryAux.ParamByName('NOMCON').AsString := LeftStr(strNomCli, 40);
  qryAux.ParamByName('ENDCON').AsString := strEndere;
  qryAux.ParamByName('BAICON').AsString := strBairro;
  qryAux.ParamByName('CEPCON').AsString := strNumCep;
  qryAux.ParamByName('CIDCON').AsString := strCidade;
  qryAux.ParamByName('TELCON').AsString := strTelCon;
  qryAux.ParamByName('CGCCPF').AsString := strCgcCpf;
  qryAux.ParamByName('CGCCON').AsString := strNumCgc;
  qryAux.ParamByName('IESCON').AsString := strInsEst;
  {***************************************************}
  {* SE O CAMPO GER_EMLCON EXISTIR NA TABELA MOVGER, *}
  {* PEGA O E-MAIL DO CLIENTE "CONSUMIDOR"           *}
  {************************************************RV*}
  If fCampoExiste('MOVGER', 'GER_EMLCON') Then
    qryAux.ParamByName('EMLCON').AsString := strEmail;

  qryAux.ParamByName('R_GCON').AsString := strRgCli;

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('SERIE_').AsString := strSerie;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);

end;

function fConnectionID: String;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Try
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add('SELECT CONNECTION_ID()');
      qryAux.Open;
      Result := qryAux.Fields[0].AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  Except
    //
  End;
end;

procedure pCriarArquivoAbertura;
begin
  pDeletar(fPnlDir('*.CONEXAO'));

  FileClose(CreateFile(PChar(fPnlDir(fConnectionID + '.CONEXAO')), GENERIC_WRITE,
                       FILE_SHARE_READ Or FILE_SHARE_WRITE Or FILE_SHARE_DELETE, Nil,
                       CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0));
end;

procedure pDeletar(strArquivo: String);
var
  stlArquivos: TStringList;
  iCnt: integer;
begin
  stlArquivos := TStringList.Create;
  Try
    GetFiles(strArquivo, stlArquivos);
    For iCnt := 0 To stlArquivos.Count - 1 Do
      DeleteFile(fPnlDir(stlArquivos[iCnt]));
  Finally
    FreeAndNil(stlArquivos);
  End;
end;

procedure GetFiles(strPath: string; stlArquivos: TStrings);
  var
    searchRec: SysUtils.TSearchRec;
begin

  If (FindFirst(strPath, faArchive, searchRec) = 0) Then
  Begin

    Repeat
      If (searchRec.Name <> '.') And (searchRec.Name <> '..') Then
        stlArquivos.Add(searchRec.Name)

    Until FindNext(searchRec) <> 0;

  End;

  SysUtils.FindClose(searchRec);

end;

function CountFiles(strPath: String; arrExisteOsArquivos: Array Of String; strFilter: String='*.*'; blnDirOnly: Boolean=False): Integer;
  var
    searchRec: SysUtils.TSearchRec;

    function fEhDiretorio: Boolean;
    begin
      Result := ((searchRec.Attr And faDirectory) <> 0);
    end;

    function fExisteArquivo: Boolean;
      Var
        intIdx: Integer;
    begin
      Result := True;

      If Length(arrExisteOsArquivos) > 0 Then
      Begin
        For intIdx := Low(arrExisteOsArquivos) To High(arrExisteOsArquivos) Do
        Begin
          Result := Result And FileExists(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(strPath) + searchRec.Name) + arrExisteOsArquivos[intIdx]);
        End;
      End;
    end;

begin
  Result := 0;

  strPath := IncludeTrailingPathDelimiter(strPath);

  If (FindFirst(strPath + strFilter, faAnyFile, searchRec) = 0) Then
  Begin
    Repeat
      If (searchRec.Name <> '.') And (searchRec.Name <> '..') Then
      Begin
        If blnDirOnly Then
          If fEhDiretorio Then
            If fExisteArquivo Then
              Inc(Result)
        Else If fExisteArquivo Then
          Inc(Result);
      End;

    Until FindNext(searchRec) <> 0;
  End;

  SysUtils.FindClose(searchRec);
end;

function fStringRepetida(Const strString: String): Boolean;
  Var
    intContador: Integer;
    strPrimeiro: String;
begin

  Result := True;
  If Length(strString) <= 0 THen
    Exit;

  strPrimeiro := strString[1];
  For intContador := 2 To Length(strString) Do
  Begin
    If strString[intContador] <> strPrimeiro Then
    Begin
      Result := False;
      Break;
    End;
  End;

End;

function fTiraCaracEspeciais(strTexto: String; blnUsaLista: Boolean = True; blnTiraEspacos: boolean = False; blnTiraPontos: boolean = False): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos = True) Then
    strLista := strLista + ' ';

  If (blnTiraPontos = True) Then
    strLista := strLista + '.';

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

  Result := AnsiReplaceStr(Result,'º','.');
  Result := AnsiReplaceStr(Result,'ª','.');
  Result := AnsiReplaceStr(Result,'½','1/2');
  Result := AnsiReplaceStr(Result,'¼','1/4');
  Result := AnsiReplaceStr(Result,'¾','3/4');
  Result := AnsiReplaceStr(Result,'¹','.');
  Result := AnsiReplaceStr(Result,'²','.');
  Result := AnsiReplaceStr(Result,'³','.');
  Result := AnsiReplaceStr(Result,#31,' ');
  Result := AnsiReplaceStr(Result,#9,' ');
  Result := AnsiReplaceStr(Result,'\',' ');
  Result := AnsiReplaceStr(Result,#$D,'');
  Result := AnsiReplaceStr(Result,#$A,'');
end;

function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;
  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

function fRetNomeEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

begin
  qryGenEmp := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_NOMEMP NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := FieldByName('NOMEMP').AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryGenEmp);
  End;
End;

function fExisteConfiguracao(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; strCodEmp: String = ''): Boolean;
Var
  strEmp,
  strSQL: String;
  qryCfg: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  {$IF Defined(UNIDAC)}
  strKey: String;
  {$IFEND}
Begin
  qryCfg := fCriaQuery(Nil, Banco);
  strEmp := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
  Try
    {$IF Defined(UNIDAC)}
    strKey := fFormataKeyCfgExiParaDicSis(strCodCfg, strEmp);
    If fAchouDicSisBln(qryCfg.Connection, strKey, Result) Then
      Exit;
    {$IFEND}

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  SIS_CODCFG AS CONFIG_EXISTE ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;
      ParamByName('CODEMP').AsString := strEmp;
      Open;
      Result := (Not IsEmpty);
    End;

    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryCfg.Connection, strKey, fBooleanToStringDisSis(Result));
    {$IFEND}
  Finally
    FreeAndNil(qryCfg);
  End;
End;

{************************************}
{*   CRIA FORM PARA PEDIR SENHA     *}
{*********************************WI*}
function ffrmSenha(var strSenha: string; strTitulo: String = ''): Boolean;
var
  Form: TForm;
  edt: TEdit;
begin

  Result := False;

  Try
    Form := TForm.Create(Nil);
	  Form.BorderStyle := bsDialog;

    If fEmptyStr(strTitulo) Then
	    Form.Caption := 'Senha'
    Else
      Form.Caption := strTitulo;

	  Form.Position   := poScreenCenter;
	  Form.Width      := 250;
	  Form.Height     := 140;
    Form.Font.Name  := 'Arial';
    Form.Font.Size  := 13;
    Form.Color      := $00FFE4D5;
	  With TLabel.Create(form) do
    Begin
		  Parent     := Form;
		  Caption    := 'Digite a Senha:';
		  Left       := 10;
		  Top        := 10;
      Font.Style := [fsBold];
	  End;
		edt := TEdit.Create(form);
	  With edt Do
    Begin
		  Parent       := form;
		  Left         := 10;
		  Top          := 35;
      Color        := clInfoBk;
		  Width        := form.ClientWidth - 22;
      PasswordChar :='*';
      CharCase     := ecUpperCase;
      MaxLength    := 10;
//      SetFocus;
	  End;
	  With TBitBtn.Create(form) Do
    Begin
	  	Parent  := form;
      Width   := 110;
		  Height  := 27;
		  Left    := form.ClientWidth - (Width * 2) - 14;
		  Top     := 70;
		  Kind    := bkOK;
      Caption := '&Confirma';
	  End;
	  With TBitBtn.Create(form) Do
    Begin
		  Parent  := form;
      Width   := 110;
		  Height  := 27;
		  Left    := form.ClientWidth - Width - 12;
		  Top     := 70;
		  Kind    := bkCancel;
      Caption := 'C&ancela';
	  End;
	  If form.ShowModal = mrOK Then
    Begin
		  strSenha := edt.Text;
		  Result := true;
	  End;

  Finally
    FreeAndNil(Form);
  End;

end;

function fGetLock(strCodEmp: String): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := True;

  If (VS_ExecutarApenasTarefasPainelWebCitel = 'S') Then
    Exit;

  Try
    qryAux := fCriaQuery(Nil);

    If fPermiteMultiplosGetLock(strCodEmp) Then
    Begin
      qryAux.Close;
      qryAux.SQL.Text := 'SELECT GET_LOCK("' + fGetStrIndicadoraLockPainelAberto(strCodEmp, qryAux.Connection.Database) + '", 2)';
      qryAux.Open;
    End;

    //SEMPRE POR ÚLTIMO...
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT GET_LOCK("PAINEL_NFE_' + strCodEmp + '", 2)';
    qryAux.Open;
    //...SEMPRE POR ÚLTIMO

    FreeAndNil(qryAux);

    Result := True;
  Except
    Result := False;
  End;
end;

procedure pAtualizarVersaoInfSis;
  Var
    qryVersao: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    intDate: Integer;
    dtaFile: TDateTime;
    dtaDtaArq: TDateTime;
    horHorArq: TDateTime;
Begin
  If Not fCampoExiste('INFSIS', 'INF_NOMARQ') Then
    Exit;

  qryVersao := fCriaQuery;

  Try
    With qryVersao, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM INFSIS');
      Open;

      If not Locate('INF_NOMARQ', 'PainelNFe.exe', []) Then
      Begin
        qryVersao.Insert;
        FieldByName('INF_NOMARQ').AsString   := 'PainelNFe.exe';
      End
      Else
        qryVersao.Edit;

      intDate   := FileAge(Application.ExeName);
      If intDate > 0 Then
      Begin
        dtaFile   := FileDateToDateTime(intDate);
        dtaDtaArq := Trunc(dtaFile);
        horHorArq := Frac(dtaFile);
      End Else
      Begin
        dtaDtaArq := 0;
        horHorArq := 0;
      End;

      FieldByName('INF_VERARQ').AsString   := fRetornaVersao(Application.ExeName);

      FieldByName('INF_DTAARQ').AsDateTime := dtaDtaArq;
      FieldByName('INF_HORARQ').AsDateTime := horHorArq;

      FieldByName('INF_TAMARQ').AsInteger  := fTamanhoArquivo(Application.ExeName);

      If FieldByName('INF_DTAARQ').AsDateTime = 0 Then
      Begin
        FieldByName('INF_DTAARQ').Clear;
        FieldByName('INF_HORARQ').Clear;
      End;

      Post;
    End;
  Finally
    FreeAndNil(qryVersao);
  End;

end;

function fRetornaVersao(strNomArq: String = ''; blnProductVersion : Boolean = False): String;
  Var
    BufferSize, Len: Integer;
    Buffer : PChar;
    Translate, Return: Pointer;
    LoCharSet, HiCharSet : Word;
    Dummy: Cardinal;
    StrFileInfo: String;
begin
  Result := '';

  If (fEmptyStr(strNomArq)) Then
  Begin
    strNomArq := Application.ExeName;
  End;

  If (Not FileExists(strNomArq)) Then
    Exit;

 	BufferSize := GetFileVersionInfoSize({$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280)}PWideChar{$ELSE}PChar{$IFEND}(strNomArq), Dummy);

  If BufferSize <> 0 Then
  Begin
    GetMem(Buffer, Succ(BufferSize));
    Try
      If GetFileVersionInfo(PChar(strNomArq), 0, BufferSize,Buffer) Then
      Begin
        If VerQueryValue(Buffer, '\VarFileInfo\Translation', Translate, UINT(Len)) Then
        Begin
          LoCharSet := LoWord(Longint(Translate^));
          HiCharSet := HiWord(Longint(Translate^));
          If blnProductVersion Then
            StrFileInfo := Format('\StringFileInfo\0%x0%x\%s',[LoCharSet, HiCharSet, 'ProductVersion'])
          Else
            StrFileInfo := Format('\StringFileInfo\0%x0%x\%s',[LoCharSet, HiCharSet, 'FileVersion']);
          If VerQueryValue(Buffer,PChar(StrFileInfo), Return, UINT(Len)) Then
          Begin
            Result := PChar(Return);
          End;
        End;
      End;
    Finally
      FreeMem(Buffer, Succ(BufferSize));
    End;
  End;
end;

function fTamanhoArquivo(strArquivo: String): Cardinal;
  Var
    FHandle: Cardinal;

begin
  FHandle := CreateFile(PChar(strArquivo), GENERIC_READ,
    FILE_SHARE_READ Or FILE_SHARE_WRITE Or FILE_SHARE_DELETE, Nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  If FHandle <> 0 Then
    Result := GetFileSize(FHandle, Nil)
  Else
    Result := 0;

  FileClose(FHandle);
end;

function fCampoExiste(const strTabela, strCampo: String;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
  Var
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    lBanco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
begin
  If Assigned(Banco) Then
    lBanco := Banco
  Else
    lBanco := frmModulo.Database;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyCmpExiParaDicSis(strTabela, strCampo);
  If fAchouDicSisBln(lBanco, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(lBanco, strTabela, strCampo);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(lBanco, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

function fTabelaExiste(const strTabela: String;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
  Var
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    lBanco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
Begin
  If (fEmptyStr(strTabela)) Then
  Begin
    Result := False;
    Exit;
  End;

  If Assigned(Banco) Then
    lBanco := Banco
  Else
    lBanco := frmModulo.Database;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyTabExiParaDicSis(strTabela);
  If fAchouDicSisBln(lBanco, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(lBanco, strTabela);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(lBanco, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

{********************************************}
{* RETORNA O VALOR DA 'intColuna' LINHA DE  *}
{* UMA STRING SEPARADA POR 'strDelimitador' *}
{*****************************************MV*}
function fGetValorLinha(strLinha, strDelimitador: String; intColuna: Integer): String;
  Var
    intContador: Integer;
    intContDel: Integer;
    intTamStr: Integer;
    intEstado: Integer; // 0=normal 1=entre aspas
begin

  Result := '';

  intTamStr := Length(strLinha);
  intContador := 1;
  intContDel  := 1;

  intEstado := 0;

  While (intContDel < intColuna) Do
  Begin

    If (strLinha[intContador] = strDelimitador) And (intEstado = 0) Then
    Begin
      Inc(intContDel);
    End
    Else If strLinha[intContador] = '"' Then
    Begin
      If intEstado = 0 Then
        intEstado := 1
      Else
      Begin
        intEstado := 0;
        Inc(intContador);
        Continue;
      End;
    End;
    Inc(intContador);

    If (intContador = intTamStr) Then
    Begin
      Break;
    End;

  End;

  intEstado := 0;

  While ((strLinha[intContador] <> strDelimitador) Or (intEstado = 1)) And
        (intContador <= intTamStr)                                     Do
  Begin

    If strLinha[intContador] = '"' Then
    Begin
      Inc(intContador);
      If intEstado = 0 Then
        intEstado := 1
      Else
      Begin
        intEstado := 0;
        Continue;
      End;
    End;


    Result := Result + strLinha[intContador];
    Inc(intContador);
  End;

end;

procedure pCopiarNFePrinterLocalExe;
  Var
    strArqPnl: String;
begin
  strArqPnl := ExtractFilePath(Application.ExeName) + 'nfe-printer.exe';

  If Not fRealizaCopiaLocal(strArqPnl, ARQUIVO_NFE_PRINTER_LOCAL, True) Then
  Begin
    Exit;
  End;
end;

procedure pCopiarNFePrinterLocalJar;
  Var
    strArqPnl: String;
begin
  strArqPnl := ExtractFilePath(Application.ExeName) + 'FIT_PRINTER.jar';

  If Not fRealizaCopiaLocal(strArqPnl, ARQUIVO_NFE_PRINTER_JAR_LOCAL, True) Then
  Begin
    Exit;
  End;
end;

procedure pCopiarPDFToPrinter;
  Var
    strArqPnl: String;
begin
  strArqPnl := ExtractFilePath(Application.ExeName) + 'PDFtoPrinter.exe';

  If Not fRealizaCopiaLocal(strArqPnl, ARQUIVO_PDF_TO_PRINTER) Then
  Begin
    Exit;
  End;
end;

function KillProcess(pid: cardinal): Boolean;
var
  killer: THandle;
begin
  Result := False;

  killer := OpenProcess(PROCESS_TERMINATE, False, pid);
  if killer <> 0 then
  begin
    try
      Result := TerminateProcess(killer, 0);
    finally
      CloseHandle(killer);
    end;
  end;
end;

function KillProcess(AImage: String): Boolean;
var
  LImage: string;
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
      LImage := FProcessEntry32.szExeFile;
      try
        if LowerCase(LImage) <> LowerCase(AImage) then
          if LowerCase(ExtractFileName(LImage)) <> LowerCase(AImage) then
            Continue;
        KillProcess(FProcessEntry32.th32ProcessID);
        Result := True;
      finally
        ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
      end;
    end;
  finally
    CloseHandle(FSnapshotHandle);
  end;
end;

function FindProcess(pid: Cardinal): boolean;
var
  Snapshot: THandle;
  ProcEntry: TProcessEntry32;
begin
  Result := False;
  if pid = 0 then
    Exit;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    if (Snapshot <> INVALID_HANDLE_VALUE) then
    begin
      ProcEntry.dwSize := SizeOf(ProcessEntry32);
      if (Process32First(Snapshot, ProcEntry)) then
      begin
        if ProcEntry.th32ProcessID = pid then
        begin
          Result := True;
          Exit;
        end;
        while Process32Next(Snapshot, ProcEntry) do
          if ProcEntry.th32ProcessID = pid then
          begin
            Result := True;
            Exit;
          end;
      end;
    end;
  finally
    CloseHandle(Snapshot);
  end;
end;

function FindProcess(AExeName: string): TProcessInfoArray;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;

  procedure AddProcess;
  begin
    try
      SetLength(Result, Length(Result) + 1);

      Result[Length(Result) - 1].pid  := FProcessEntry32.th32ProcessID;
      Result[Length(Result) - 1].name := ExtractFileName(FProcessEntry32.szExeFile);

      if ExtractFilePath(FProcessEntry32.szExeFile) = EmptyStr then
        Result[Length(Result) - 1].path := ExtractFilePath(GetPathFromPID(FProcessEntry32.th32ProcessID))
      else
        Result[Length(Result) - 1].path := ExtractFilePath(FProcessEntry32.szExeFile);
    except
      // on E: Exception do
      // raise;
    end;
  end;

begin
  SetLength(Result, 0);
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
      if SameText(ExtractFileName(FProcessEntry32.szExeFile), AExeName) then
        AddProcess;

      if SameText(FProcessEntry32.szExeFile, AExeName) then
        AddProcess;

      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
  finally
    CloseHandle(FSnapshotHandle);
  end;
end;

function GetPathFromPID(const PID: Cardinal): string;
var
  hProcess: THandle;
  path: array [0 .. MAX_PATH - 1] of char;
begin
  hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ,
    False, PID);
  if hProcess <> 0 then
    try
      if GetModuleFileNameEx(hProcess, 0, path, MAX_PATH) = 0 then
        RaiseLastOSError;
      Result := path;
    finally
      CloseHandle(hProcess)
    end
  else
    RaiseLastOSError;
end;

function StartProcess(Exename, CmdLineArgs: String; ShowWindow, WaitForFinish: boolean): Cardinal;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: boolean;
  LCurrDir: Pointer;
begin
  pLog('>> StartProcess -> ' + Exename + ' ' + CmdLineArgs);

  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);

  If Not ShowWindow Then
  begin
    StartInfo.dwFlags := STARTF_USESHOWWINDOW Or STARTF_FORCEOFFFEEDBACK;
    StartInfo.wShowWindow := SW_HIDE;
  end;

  LCurrDir := Nil;
  if ExtractFilePath(Exename) <> EmptyStr then
    LCurrDir := PChar(ExtractFilePath(Exename));

  CreateOK := CreateProcess(nil, PChar(Exename + ' ' + CmdLineArgs), nil, nil,
    False, CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, LCurrDir,
    StartInfo, ProcInfo);

  Result := ProcInfo.dwProcessId;

  if CreateOK then
  begin
    if WaitForFinish then
      WaitForSingleObject(ProcInfo.hProcess, Infinite);
  end
  else
  begin
    SysErrorMessage(GetLastError());
  end;

  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);

  pLog('<< StartProcess [PID ' + FloatToStr(Result) + '] -> ' + Exename + ' ' + CmdLineArgs);
end;

function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean=True): boolean;
  Var
    StartInfo: TStartupInfo;
    ProceInfo: TProcessInformation;
begin
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb          := SizeOf(StartInfo);
  StartInfo.dwFlags     := STARTF_USESHOWWINDOW;

  If blnMaximizado Then
    StartInfo.wShowWindow := SW_SHOWMAXIMIZED
  Else
    StartInfo.wShowWindow := SW_SHOWNORMAL;

  Result := CreateProcess(Nil,
                          PChar(strArquivo),
                          Nil,
                          Nil,
                          False,
                          CREATE_NEW_CONSOLE Or
                          NORMAL_PRIORITY_CLASS,
                          Nil,
                          PChar(ExtractFilePath(strArquivo)),
                          StartInfo,
                          ProceInfo);

  If (Result) Then
    SetForegroundWindow(ProceInfo.hProcess);

  If (Result) And (blnTrava) Then
  Begin
    WaitForSingleObject(ProceInfo.hProcess, INFINITE);

    CloseHandle(ProceInfo.hProcess);
    CloseHandle(ProceInfo.hThread);
  End;
end;

function fVerificaDiretorioLocal(strPathLocal: String): Boolean;
begin
  If Not DirectoryExists(strPathLocal) Then
  Begin
    CreateDir(strPathLocal);
    Sleep(1000);
  End;

  Result := True;
  If Not DirectoryExists(strPathLocal) Then
  Begin
    Result := False;
    pGravaLogNfePrinter(ERRO_NFE_PRINTER_DIRETORIO_NAO_CRIADO, 'Não conseguiu criar ' + strPathLocal + '.');
  End;
end;

function fCopiaJre(pgbSts: TcxProgressBar; strArqPnl, strArqLoc: AnsiString; blnCopiarJRE6: Boolean; blnRemoveJRE6: Boolean=False): Boolean;

  procedure pIncPosition;
  Begin
    pgbSts.Position := pgbSts.Position + 1;
    Application.ProcessMessages;
  End;

  procedure pCopiaArquivo(strPnl, strLoc: AnsiString);
  begin
    CopyFileA(PAnsiChar(strPnl), PAnsiChar(strLoc), False);
  end;

  function DelDir(dir: string): Boolean;
  var
    fos: TSHFileOpStruct;
  begin
    ZeroMemory(@fos, SizeOf(fos));
    with fos do
    begin
      wFunc  := FO_DELETE;
      fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
      pFrom  := PChar(dir + #0);
    end;
    Result := (0 = ShFileOperation(fos));
  end;

  Var
    operacao: _SHFILEOPSTRUCTA;
begin
  pIncPosition;

  If blnCopiarJRE6 Then
  Begin
    If blnRemoveJRE6 Then
    Begin
      If DelDir(ExtractFilePath(String(strArqLoc)) + 'jre6') Then
        pGravaLogNfePrinter(ERRO_NFE_PRINTER_COPIADO_COM_SUCESSO, 'C:\NFEPRINTER\jre6 removida para efeito de atualização.')
      Else
        pGravaLogNfePrinter(ERRO_NFE_PRINTER_NAO_COPIOU_ARQUIVO, 'Não conseguiu remover C:\NFEPRINTER\jre6.');
    End;

    If (Not DirectoryExists(ExtractFilePath(String(strArqLoc)) + 'jre6')) Then
    Begin
      operacao.Wnd    := 0;
      operacao.wFunc  := FO_COPY;
      operacao.pFrom  := PAnsiChar(AnsiString(ExtractFilePath(String(strArqPnl))) + 'jre6' + #0);
      operacao.pTo    := PAnsiChar(AnsiString(ExtractFilePath(String(strArqLoc))) + 'jre6' + #0);
      operacao.fFlags := FOF_SILENT;

      pIncPosition;
      SHFileOperationA(operacao);
    End;
  End;

  pIncPosition;

  Result := Not operacao.fAnyOperationsAborted;
  If Not Result Then
  Begin
    pGravaLogNfePrinter(ERRO_NFE_PRINTER_NAO_COPIOU_ARQUIVO, 'Operação abortada.');
  End
  Else
    pCopiaArquivo(strArqPnl, strArqLoc);

  pIncPosition;
end;

function fRealizaCopiaLocal(strArqPnl, strArqLoc: String; blnCopiarJRE6: Boolean=False): Boolean;
  Var
    strJavaPainelNFeExe,
    strJavaCeDoisPontos,
    strNfePrinterPontoJarPainelNFeExe,
    strNfePrinterPontoJarCeDoisPontos: String;

  procedure pCopia(funcCopia: TCopia; blnRemoveJRE6: Boolean=False);
  Begin

    Try
      Application.CreateForm(TfrmGravando, frmGravando);
      frmGravando.strChave := 'PAINELNFE';
      frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Gerenciador de Impressão.';
      frmGravando.fExecutarAcao := funcCopia;
      frmGravando.strArqPnl     := AnsiString(strArqPnl);
      frmGravando.strArqLoc     := AnsiString(strArqLoc);
      frmGravando.blnRemoveJRE6 := blnRemoveJRE6;
      frmGravando.blnCopiarJRE6 := blnCopiarJRE6;
      frmGravando.ShowModal;
    Finally
      FreeAndNil(frmGravando);
    End;

  End;

begin
  Result := False;

  If Not fVerificaDiretorioLocal(PATH_NFE_PRINTER_LOCAL) Then
  Begin
    Exit;
  End;

  If Not FileExists(strArqPnl) Then
  Begin
    If (Not (fPainelNFeNoTSPlus And (FileExists(strArqLoc)))) Then
      pGravaLogNfePrinter(ERRO_NFE_PRINTER_NAO_EXISTE, strArqPnl + ' não encontrado.');

    Exit;
  End;

  If Not FileExists(strArqLoc) Then
  Begin
    pCopia(fCopiaJre);

    Sleep(1000);

    If Not FileExists(strArqLoc) Then
    Begin
      pGravaLogNfePrinter(ERRO_NFE_PRINTER_NAO_COPIOU_ARQUIVO, 'Não conseguiu copiar '+strArqLoc+'.');
      Exit;
    End;

    Result := True;
    pGravaLogNfePrinter(ERRO_NFE_PRINTER_COPIADO_COM_SUCESSO, 'Arquivos copiados com sucesso.');
  End;

  If fPainelNFeNoTSPlus Then
  Begin
    Result := True;
    Exit;
    {
    DAQUI PARA BAIXO, É SOMENTE ATUALIZAÇÃO CASO A VERSÃO DO ARQUIVO A SER
    COPIADO DA PASTA PainelNFe, SEJA MAIS NOVA QUE DO QUE A QUE ESTA EM
    C:\NFE_PRINTER. EM AMBIENTE TSPLUS ISSO PODE NÃO FUNCIONAR POIS O
    PainelNFe.exe PODE NÃO TER PERMISSÃO PARA COPIAR NA RAIZ DO TS E COM ISSO
    O PainelNFe.exe FICAR TENTANDO COPIAR TODA A ABERTURA. ENTÃO, NESSES CASOS,
    A AUTALIZAÇÃO DA PASTA C:\NFE_PRINTER SE NECESSÁRIA, DEVERÁ SER FEITA
    MANUALMENTE.
    }
  End;

  If (FileAge(strArqPnl) > FileAge(strArqLoc)) And (fRetornaMD5(strArqPnl) <> fRetornaMD5(strArqLoc)) Then
  Begin
    pCopia(fCopiaJre);

    Sleep(1000);

    If fRetornaMD5(strArqPnl) <> fRetornaMD5(strArqLoc) Then
    Begin
      pGravaLogNfePrinter(ERRO_NFE_PRINTER_MD5_INCONSISTENTE, 'MD5 inconsistente e não conseguiu copiar novamente.');
      Exit;
    End;

    pGravaLogNfePrinter(ERRO_NFE_PRINTER_COPIADO_COM_SUCESSO, 'Arquivos copiados com sucesso.');
  End
  Else
  Begin
    strJavaPainelNFeExe := ExtractFilePath(String(strArqPnl)) + 'jre6\bin\java.exe';
    strJavaCeDoisPontos := ExtractFilePath(String(strArqLoc)) + 'jre6\bin\java.exe';
    strNfePrinterPontoJarPainelNFeExe := strArqPnl;
    strNfePrinterPontoJarCeDoisPontos := strArqLoc;
    
    If (strNfePrinterPontoJarCeDoisPontos = ARQUIVO_NFE_PRINTER_JAR_LOCAL) Then
    Begin
      If FileExists(strJavaPainelNFeExe) And
         FileExists(strJavaCeDoisPontos) And
         FileExists(strNfePrinterPontoJarPainelNFeExe) And
         FileExists(strNfePrinterPontoJarCeDoisPontos) Then
      Begin
        If (FileDateToDateTime(FileAge(strNfePrinterPontoJarPainelNFeExe)) >= StrToDate('18/12/2020')) And //FIT_PRINTER MAIS ATUAL
           (FileDateToDateTime(FileAge(strJavaPainelNFeExe)) >= StrToDate('27/08/2020')) Then              //JAVA MAIS ATUAL
        Begin
          If (FileAge(strJavaPainelNFeExe) > FileAge(strJavaCeDoisPontos)) Then
          Begin 
            {****************************************************************************************************}
            {* SE EXISTE JRE6 E FIT_PRINTER.JAR NAS DUAS PONTAS (PASTA DO PAINEL E C:\NFEPRINTER) E O JAVA DA   *}
            {* PASTA JRE6 DE C:\NFEPRINTER ESTÁ DESATUALIZADA COMPARADA À PASTA JRE6 DO PAINEL, A PASTA JRE6 DE *}
            {* C:\NFEPRINTER É REMOVIDA INTEIRAMENTE E COPIADA JUNTO COM O FIT_PRINTER.JAR                      *}
            {*************************************************************************************************VA*}
            pCopia(fCopiaJre, True);

            pGravaLogNfePrinter(ERRO_NFE_PRINTER_COPIADO_COM_SUCESSO, 'Copiado integralmente JRE6 e FIT_PRINTER.JAR de '+strArqPnl+' para ');
          End;
        End;
      End;
    End;
  End;
end;

procedure pGravaLogNfePrinter(intCodigo: Integer; strMsg: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaDtaSis, dtaHraSis : TDateTime;
  function fCampo(strCampo: String): String;
  begin
    Result := '';
    If fCampoExiste('NFE_NFEPRINTER', 'NFE_NUM_IP') Then
    Begin
      Result := ', ' + strCampo;
    End;
  end;
begin
  If Not fTabelaExiste('NFE_NFEPRINTER') Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('INSERT INTO NFE_NFEPRINTER (NFE_CODEMP, NFE_DTALOG, NFE_HORLOG, NFE_CODERR, NFE_DESERR' + fCampo('NFE_NUM_IP') + ') ');
  qryAux.SQL.Add('VALUES(:CODEMP, :DTALOG, :HORLOG, :CODERR, :DESERR' + fCampo(':NUM_IP') + ') ');

  pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);

  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('DTALOG').AsDate := dtaDtaSis;
  qryAux.ParamByName('HORLOG').AsTime := dtaHraSis;
  qryAux.ParamByName('CODERR').AsInteger := intCodigo;
  qryAux.ParamByName('DESERR').AsString := strMsg;

  If Assigned(qryAux.Params.FindParam('NUM_IP')) Then
  Begin
    qryAux.ParamByName('NUM_IP').AsString := GetIPAddressAsString;
  End;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

function fRetornaMD5(strNomeArq: String): String;
  Var
    md5: TLbMD5;
    digest: TMD5Digest;
begin
  md5 := TLbMD5.Create(Nil);
  md5.HashFile(strNomeArq);
  md5.GetDigest(digest);
  Result := BufferToHex(digest, SizeOf(digest));
  FreeAndNil(md5);
end;

function fCfgSisPainel(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; blnUsarCache: Boolean = True; strCodEmp: String = ''): String;
begin
  Try
    Result := fCfgSis(strCodCfg, varString, strCodEmp, Banco, blnUsarCache);
  Except
    Result := '';
  End;
end;

procedure pAtuCfgSisPainel(strCodCfg, strDescri, strValor: String);
  Var
    qryUpd: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryUpd := fCriaQuery(Nil);
  Try
    //NUNCA LER OU IMPLEMENTAR CACHE AQUI
    If Not fCfgExiste(strCodCfg) Then
    Begin
      qryUpd.SQL.Add('INSERT INTO CFGSIS (SIS_CODEMP, SIS_CODCFG, SIS_DESCRI, SIS_VALCFG, SIS_GRUCFG) VALUES ');
      qryUpd.SQL.Add('(:CODEMP, :CODCFG, :DESCRI, :VALCFG, :GRUCFG)');
    End
    Else
    Begin
      qryUpd.SQL.Add('UPDATE CFGSIS SET ');
      qryUpd.SQL.Add('  SIS_VALCFG = :VALCFG, ');
      qryUpd.SQL.Add('  SIS_DESCRI = IF(IFNULL(:DESCRI, "") = "", SIS_DESCRI, :DESCRI) ');
      qryUpd.SQL.Add('WHERE ');
      qryUpd.SQL.Add('  SIS_CODEMP = :CODEMP AND ');
      qryUpd.SQL.Add('  SIS_CODCFG = :CODCFG AND ');
      qryUpd.SQL.Add('  SIS_GRUCFG = :GRUCFG ');
    End;

    qryUpd.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryUpd.ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;
    qryUpd.ParamByName('DESCRI').AsString := strDescri;
    qryUpd.ParamByName('VALCFG').AsString := strValor;
    qryUpd.ParamByName('GRUCFG').AsString := 'PAINEL NFE';
    qryUpd.ExecSQL;

    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryUpd.Connection, fFormataKeyValCfgParaDicSis(strCodCfg, VS_strCodEmp), strValor); //APENAS ATUALIZA A DICSIS
    {$IFEND}
  Finally
    FreeAndNil(qryUpd);
  End;
end;

function fCfgExiste(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
  Var
    qryAux: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  //NUNCA LER OU IMPLEMENTAR CACHE AQUI
  qryAux := fCriaQuery(Nil, Banco);
  Try
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  SIS_CODCFG AS CONFIG_EXISTE_SEMCACHE ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CFGSIS ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  SIS_CODCFG = :CODCFG AND ');
      qryAux.SQL.Add('  SIS_CODEMP = :CODEMP ');

      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;

      qryAux.Open;

      Result := (Not qryAux.IsEmpty);

      qryAux.Close;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fRemoveAcento(Str:String): String;
  Const
    ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ"´';
    SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
  Var
    x : Integer;
Begin
  For x := 1 to Length(Str) Do
    If Pos(Str[x],ComAcento)<>0 Then
      Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

function GetParentFolder(folder: String; const cLevels: Byte = 1) : String;
var
  parent: String;
  level: Byte;
begin
  if (cLevels > 0) then
  begin
    parent := ExcludeTrailingPathDelimiter(folder);
    level := 0;
    while (level < cLevels) do
    begin
      parent := ExcludeTrailingPathDelimiter(ExtractFileDir(ExtractFilePath(parent)));
      Inc(level);
    end;
    Result := IncludeTrailingPathDelimiter(parent);
  end
  else
    Result := folder;
end;

procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
Begin
  With dtsDataSet Do
  Begin
    prcScroll := AfterScroll;
    AfterScroll := Nil;
    DisableControls;
  End;
End;

procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
Begin
  With dtsDataSet Do
  Begin
    EnableControls;
    AfterScroll := prcScroll;
    If blnRefresh then
      AfterScroll(dtsDataSet)
  End;
End;

{********************************************}
{* AJUSTA O RELOGIO DO WINDOWS TOMANDO COMO *}
{* BASE A DATA DO SERVIDOR                  *}
{*****************************************MV*}
function fAjustaDataSistema: Boolean;
  Var
    dtaWindows : _SYSTEMTIME;
    wrdDia     : Word;
    wrdMes     : Word;
    wrdAno     : Word;
    wrdHora    : Word;
    wrdMinuto  : Word;
    wrdSegundo : Word;
    wrdMilSec  : Word;
    qryGenTmp  : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaHora    : TDateTime;
begin
  Try

    qryGenTmp := fCriaQuery;

    Try
      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
        Open;
        dtaHora := FieldByName('CURRENT_TIME').AsDateTime;

        DecodeDate(FieldByName('CURRENT_DATE').AsDateTime, wrdAno, wrdMes, wrdDia);
        DecodeTime(dtaHora, wrdHora, wrdMinuto, wrdSegundo, wrdMilSec);
        Close;
      End;

      Result := True;      

      If fCFGSisPainel('AJUDTA') = 'S' Then
      Begin
        GetLocalTime(dtaWindows);
        dtaWindows.wYear  := wrdAno;
        dtaWindows.wMonth := wrdMes;
        dtaWindows.wDay   := wrdDia;

        dtaWindows.wHour   := wrdHora;
        dtaWindows.wMinute := wrdMinuto;
        dtaWindows.wSecond := wrdSegundo;
        dtaWindows.wMilliseconds := wrdMilSec;
        Result := SetLocalTime(dtaWindows);
      End;

    Except
      Result := False;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

Procedure pMensagemOk(strMensagem: String);
Begin
  MessageDlg(strMensagem, mtInformation, [mbOK], 0);
End;

function fRetornaInformacaoUltimoErroForeignKey: String;
  Var
    qryInnoDB: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    stlInnoDB: TStringList;
    strInnoDBLine: String;
    intInnoDBLine: Integer;
    intIndex: Integer;
    intNumberFields: Integer;
    intLatestForeignKey: Integer;
Begin
  intNumberFields := 0;
  Result := '';

  qryInnoDB := fCriaQuery;
  qryInnoDB.SQL.Add('SHOW INNODB STATUS');
  qryInnoDB.Open;

  stlInnoDB := TStringList.Create;

  If qryInnoDB.FindField('Status') <> nil Then
    stlInnoDB.Text := qryInnoDB.FieldByName('Status').AsString;

  { ------------------------ }
  { LATEST FOREIGN KEY ERROR }
  { ------------------------ }
  intLatestForeignKey := stlInnoDB.IndexOf('LATEST FOREIGN KEY ERROR');

  If intLatestForeignKey <> -1 Then
  Begin
    For intInnoDBLine := (intLatestForeignKey + 2) To stlInnoDB.Count -1 Do
    Begin
      strInnoDBLine := Trim(stlInnoDB[intInnoDBLine]);

      If AnsiStartsStr('Foreign key constraint fails for table', strInnoDBLine) Then
      Begin
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, '`', '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, '/', '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, ':', '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, frmModulo.Database.Database, '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'Foreign key constraint fails for table', 'Tabela de Gravação:');

        Result := Result + ' ' + strInnoDBLine;
      End;

      If AnsiStartsStr('CONSTRAINT ', strInnoDBLine) Then
      Begin
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'FOREIGN KEY', #13#10 + 'Campos de Gravação:');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'CONSTRAINT',  #13#10 + 'Foreign Key:');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'REFERENCES',  #13#10 + 'Tabela de Referência:');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'ON DELETE',   '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'ON UPDATE',   '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'NO ACTION',   '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, 'CASCADE',     '');
        strInnoDBLine := AnsiReplaceStr(strInnoDBLine, '`',           '');

        Result := Result + ' ' + strInnoDBLine;

        strInnoDBLine := Copy(strInnoDBLine, Pos('(', strInnoDBLine), Pos(')', strInnoDBLine) - Pos('(', strInnoDBLine));
        intNumberFields := Length(strInnoDBLine) - Length(AnsiReplaceStr(strInnoDBLine, ',', '')) + 1;
      End;

      If AnsiStartsStr('0: ', strInnoDBLine) Then
      Begin
        Result := Result + #13#10 + 'Valores Gravados: (';

        For intIndex := 0 To intNumberFields -1 Do
        Begin
          Delete(strInnoDBLine, 1, Pos('asc', strInnoDBLine) + 3);

          If Copy(strInnoDBLine, 1, Pos(';', strInnoDBLine)) = ';' Then
            Result := Result + 'EM BRANCO;'
          Else
            Result := Result + Copy(strInnoDBLine, 1, Pos(';', strInnoDBLine));
        End;

        If RightStr(Result, 1) = ';' Then
          Result := LeftStr(Result, Length(Result) - 1);

        Result := Result + ')';

        Break;
      End;

      If Pos('------------', strInnoDBLine) > 0 Then
        Break;
    End;
  End;

  Result := Trim(Result);

  FreeAndNil(stlInnoDB);
  FreeAndNil(qryInnoDB);
End;

procedure pGravarNFeLocal;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strCodEmp: String;
    strPatPnl: String;
    strVerExe: String;
    dtaHorUlt: TDateTime;
    dtaDtaExe: TDateTime;
    blnExisteDtaExe,
    blnExisteVerExe: Boolean;
begin
  If Not fTabelaExiste('NFE_LOCAL') Then
    Exit;

  blnExisteDtaExe := fCampoExiste('NFE_LOCAL', 'NFE_DTAEXE');
  blnExisteVerExe := fCampoExiste('NFE_LOCAL', 'NFE_VEREXE');

  qryAux := fCriaQuery(Nil);
  Try
    Try
      strCodEmp := VS_strCodEmp;
      strPatPnl := ExtractFilePath(Application.ExeName);
      strVerExe := fRetornaVersao(Application.ExeName);
      dtaHorUlt := nOw;
      FileAge(Application.ExeName, dtaDtaExe);

      qryAux.SQL.Clear;
      qryAux.SQL.Add('REPLACE INTO NFE_LOCAL ');
      qryAux.SQL.Add('        (NFE_CODEMP    ');
      qryAux.SQL.Add('        ,NFE_PATPNL    ');
      qryAux.SQL.Add('        ,NFE_HORULT    ');

      If blnExisteDtaExe Then
        qryAux.SQL.Add('      ,NFE_DTAEXE    ');

      If blnExisteVerExe Then
        qryAux.SQL.Add('      ,NFE_VEREXE    ');
      qryAux.SQL.Add('        )');

      qryAux.SQL.Add(' VALUES (:NFE_CODEMP    ');
      qryAux.SQL.Add('        ,:NFE_PATPNL    ');
      qryAux.SQL.Add('        ,:NFE_HORULT    ');

      If blnExisteDtaExe Then
        qryAux.SQL.Add('      ,:NFE_DTAEXE    ');

      If blnExisteVerExe Then
        qryAux.SQL.Add('      ,:NFE_VEREXE    ');
      qryAux.SQL.Add('        )');

      qryAux.ParamByName('NFE_CODEMP').AsString   := strCodEmp;
      qryAux.ParamByName('NFE_PATPNL').AsString   := strPatPnl;
      qryAux.ParamByName('NFE_HORULT').AsDateTime := dtaHorUlt;

      If blnExisteDtaExe Then
        qryAux.ParamByName('NFE_DTAEXE').AsDateTime := dtaDtaExe;

      If blnExisteVerExe Then
        qryAux.ParamByName('NFE_VEREXE').AsString := strVerExe;

      qryAux.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagemOk(E.Message);
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function GetIPAddress: Integer;
var
  Buffer: array[0..255] of AnsiChar;
  RemoteHost: PHostEnt;
begin
  Winsock.GetHostName(@Buffer, 255);
  RemoteHost := Winsock.GetHostByName(Buffer);
  if RemoteHost = nil then
    Result := winsock.htonl($07000001) { 127.0.0.1 }
  else
    Result := longint(pointer(RemoteHost^.h_addr_list^)^);
  Result := Winsock.ntohl(Result);
end;

function GetIPAddressAsString: String;
var
  tempAddress: Integer;
  Buffer: array[0..3] of Byte absolute tempAddress;
  data: WSAData;
begin
  WSAStartup(2, data);
  tempAddress := GetIPAddress;
  Result := Format('%d.%d.%d.%d', [Buffer[3], Buffer[2], Buffer[1], Buffer[0]]);
  WSACleanup;
end;

procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
begin
  If Not Assigned(SenderUnico) Then Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;
      Except

      End;
    End;
  Except

  End;
end;

function fValidaChaveAcessoNFE(strChaveAcesso : String):Boolean;
  Var intSoma    : Integer;
      intPeso    : Integer;
      intCorre   : Integer;
      strDig     : String;
      intDigCalc : Integer;

  const
    ALFABET_MAI = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ';

  function ContemCaracter(ACaracter : String; ALista : String) : Boolean;
  begin
    Result := Pos(ACaracter, ALista) > 0;
  end;

  function CharToIntValue(C: Char): Integer;
  begin
    C := UpCase(C);

    If ContemCaracter(C, ALFABET_MAI) Then
      Result := Ord(C) - Ord('A') + 10
    Else
      Result := Ord(C) - Ord('0');
  end;
Begin
  intPeso  := 2;
  intSoma  := 0;
  Result := True;
  If ( Length(strChaveAcesso) <> 44 ) Then
    Result := False;

  If Not Result Then
    Exit;

  strDig := strChaveAcesso[44];
  strChaveAcesso := Copy(strChaveAcesso,1,43);

  For intCorre := Length(strChaveAcesso) Downto 1 do
  begin
    intSoma := intSoma + ( CharToIntValue(strChaveAcesso[intCorre]) * intPeso);

    Inc(intPeso);
    if (intPeso > 9) Then
      intPeso := 2;
  End;

  intDigCalc := intSoma mod 11 ;

  if (intDigCalc = 0) or (intDigCalc = 1) Then
    intDigCalc := 0
  Else
    intDigCalc := 11 - intDigCalc;

  Result  := (strDig = IntToStr(intDigCalc));

End;

function MessageDlgCaptions(const Msg: String; DlgTypt: TmsgDlgType; button: TMsgDlgButtons;
  Caption: array of String; dlgcaption: String; DefaultButton:TMsgDlgBtn = mbYes): Integer;
var
  aMsgdlg: TForm;
  i: Integer;
  Dlgbutton: Tbutton;
  Captionindex: Integer;
begin
  aMsgdlg := createMessageDialog(Msg, DlgTypt, button, DefaultButton);
  aMsgdlg.Caption := dlgcaption;
  Captionindex := 0;
  for i := 0 to aMsgdlg.componentcount - 1 Do
  begin
    if (aMsgdlg.components[i] is Tbutton) then
    Begin
      Dlgbutton := Tbutton(aMsgdlg.components[i]);
      if Captionindex <= High(Caption) then
        Dlgbutton.Caption := Caption[Captionindex];
      inc(Captionindex);
    end;
  end;
  Result := aMsgdlg.Showmodal;
end;

function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fStrToFloat(FloatToStrF(fltNumero, ffFixed, 12, intDecimais));
end;

{*********************************}
{* VALIDA CGC                    *}
{*********************************}
function fTestaCgc(xCGC: String):Boolean;
begin
  Result := TCNPJ.fTestaCNPJ(xCGC, fCfgSis('NWCNPJ', varBoolean));
end;

function fTiraCaracEspeciaisPonto(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():.';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

{************************************}
{* RETORNA CNPJ/CPF FORMATADO       *}
{*********************************AF*}
function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String;
Begin
  If (strEstado = 'EX') Or (FPais = opcParaguai) Then
  Begin

    Result := strValor;

  End
  Else
  Begin


    strValor := AnsiReplaceStr(strValor,'.','');
    strValor := AnsiReplaceStr(strValor,',','');
    strValor := AnsiReplaceStr(strValor,'-','');
    strValor := AnsiReplaceStr(strValor,'/','');

    Result := Trim(strValor);
    {************************************}
    {* SE FOR MAIOR QUE 11 ENTÃO É CNPJ *}
    {*********************************AF*}

    If Not fEmptyStr(Result) Then
    Begin

      If Length(strValor) > 11 Then
      Begin
        Insert('.',Result,3);  // XX.XXX.XXX/XXXX-XX
        Insert('.',Result,7);  // XX.XXX.XXX/XXXX-XX
        Insert('/',Result,11); // XX.XXX.XXX/XXXX-XX
        Insert('-',Result,16); // XX.XXX.XXX/XXXX-XX
      End
      Else
      Begin
        Insert('.',Result,4);  // XXX.XXX.XXX-XX
        Insert('.',Result,8);  // XXX.XXX.XXX-XX
        Insert('-',Result,12); // XXX.XXX.XXX-XX
      End;

    End;

  End;

End;

function fCriarConexao: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
begin
  {$IF Defined(UNIDAC)}
    Result := TUniConnection.Create(Nil);
    Result.ProviderName := frmModulo.Database.ProviderName;
    Result.Username := frmModulo.Database.Username;
    Result.Password := frmModulo.Database.Password;
    Result.Server := frmModulo.Database.Server;
    Result.Database := frmModulo.Database.Database;
    Result.Port := frmModulo.Database.Port;
    Result.LoginPrompt := False;
  {$ELSE}
    Result := TZConnection.Create(Nil);
    Result.Protocol := 'mysql-4.1';
    Result.User := frmModulo.Database.User;
    Result.Password := frmModulo.Database.Password;
    Result.HostName := frmModulo.Database.HostName;
    Result.Database := frmModulo.Database.Database;
    Result.Port := frmModulo.Database.Port;
    Result.LoginPrompt := False;
    Result.TransactIsolationLevel := frmModulo.Database.TransactIsolationLevel;
  {$IFEND}
end;

function fConexaoAtiva(Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If Not Assigned(Banco) Then
  Begin
    Result := False;
    Exit;
  End;

  qryAux := fCriaQuery(Nil, Banco);
  Try
    Try
      qryAux.SQL.Add('SELECT CURRENT_DATE');
      qryAux.Open;
      Result := True;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fRetornaTamanhoCampo(strTabela, strCampo: String): Integer;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('SELECT '+strCampo+' FROM '+strTabela+' LIMIT 0');
    qryAux.Open;
    Result := qryAux.Fields[0].DisplayWidth;
  Finally
    FreeAndNil(qryAux);
  End;
End;

{***********************************************}
{* RETORNA O VALOR DE UM DETERMINADO CAMPO     *}
{* DE UMA TABELA PASSANDO COMO PARAMETROS      *}
{* OS CAMPOS CHAVES E SEUS VALORES (WHERE)     *}
{* PODE SER UTIL PARA RETORNAR DESDE DESCRICAO *}
{* ATE VALORES, DATAS ENTRE OUTROS             *}
{********************************************JC*}
function fCampoTabela(strCampo : String;
                      strNomTab: String;
                      arrCampoChave: Array Of String;
                      arrValorChave: Array Of Variant;
                      Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
                      strOrderBy: String = ''): Variant;
  Const
    arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

  Var
    intCont  : Integer;
    strSQL   : String;
    qryGenGer: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Try
    qryGenGer := fCriaQuery(Banco);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ' + strCampo + ' ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strNomTab + ' ';
    strSQL := strSQL + 'WHERE ';

    For intCont := 0 To Length(arrCampoChave) -1 Do
    Begin
      If Pos('<>', arrCampoChave[intCont]) > 0 Then
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' :' + String(arrParms[intCont]) + ' AND '
      Else
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' = :' + String(arrParms[intCont]) + ' AND ';
    End;

    strSQL := strSQL + '  TRUE  ';

    If Not fEmptyStr(strOrderBy) Then
      strSQL := strSQL + ' ORDER BY ' + strOrderBy;

    strSQL := strSQL + ' LIMIT 1 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To Length(arrCampoChave) -1 Do
        ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];

      Open;

      Result := Fields[0].Value;

      {*******************************************}
      {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
      {****************************************JC*}
      Case Fields[0].DataType Of
        ftString : Result := Fields[0].AsString;
        ftMemo   : Result := Fields[0].AsString;
        ftFloat  : Result := Fields[0].AsFloat;
        ftInteger: Result := Fields[0].AsInteger;
        ftBoolean: Result := Fields[0].AsBoolean;
        ftDate   : Result := Fields[0].AsDateTime;
        ftTime   : Result := Fields[0].AsDateTime;
      End;

    End;

  Finally
    If Assigned(qryGenGer) Then FreeAndNil(qryGenGer);
  End;

End;

function fCurrentTime: String;
begin
  Result := 'CAST("' + FormatDateTime('hh:mm:ss', Time) + '" AS TIME)';
end;

function fCurrentDate: String;
begin
  Result := fCurrentDate(Date);
end;

function fCurrentDate(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd', Value) + '" AS DATE)';
end;

function fCurrentDateTime: String;
begin
  Result := fCurrentDateTime(Date + Time);
end;

function fCurrentDateTime(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Value) + '" AS DATETIME)';
end;

procedure pLogImp(const strValor: String);
begin
  untDicSis.pLogImp(strValor);
end;

procedure pLog(strValor: String);
begin
  untDicSis.pLog(strValor);
end;

function GetComputerNetName: string;
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;

function GetMacAddress: String;
var
  Librpcrt4: Cardinal;
  GUID1, GUID2: TGUID;
  Func: Function(GUID: PGUID): Longint; stdcall;
Begin
  Result := '';
  Librpcrt4 := LoadLibrary('rpcrt4.dll');
  If not (Librpcrt4 = 0) Then
  Try
     @Func := GetProcAddress(Librpcrt4, 'UuidCreateSequential');
     If Assigned(Func) Then
     Begin
       If (Func(@GUID1) = 0) and
          (Func(@GUID2) = 0) and
          (GUID1.D4[2] = GUID2.D4[2]) and
          (GUID1.D4[3] = GUID2.D4[3]) and
          (GUID1.D4[4] = GUID2.D4[4]) and
          (GUID1.D4[5] = GUID2.D4[5]) and
          (GUID1.D4[6] = GUID2.D4[6]) and
          (GUID1.D4[7] = GUID2.D4[7]) Then
       Begin
         Result :=
           IntToHex(GUID1.D4[2], 2) + '-' +
           IntToHex(GUID1.D4[3], 2) + '-' +
           IntToHex(GUID1.D4[4], 2) + '-' +
           IntToHex(GUID1.D4[5], 2) + '-' +
           IntToHex(GUID1.D4[6], 2) + '-' +
           IntToHex(GUID1.D4[7], 2);
       end;
     end;
  Finally
    FreeLibrary(Librpcrt4);
  end;
end;

function GetUserFromWindows: string;
Var
   UserName : string;
   UserNameLen : Dword;
Begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   If GetUserName(PChar(UserName), UserNameLen) Then
     Result := Copy(UserName,1,UserNameLen - 1)
   Else
     Result := 'Unknown';
End;

function ShellExecuteAndWait(Operation, FileName, Parameter, Directory: String; Show: Word; bWait: Boolean): Longint;
var
  bOK: Boolean;
  Info: TShellExecuteInfo;
begin
  FillChar(Info, SizeOf(Info), Chr(0));
  Info.cbSize := SizeOf(Info);
  Info.fMask := SEE_MASK_NOCLOSEPROCESS;
  Info.lpVerb := PChar(Operation);
  Info.lpFile := PChar(FileName);
  Info.lpParameters := PChar(Parameter);
  Info.lpDirectory := PChar(Directory);
  Info.nShow := Show;
  bOK := Boolean(ShellExecuteEx(@Info));
  if bOK then
  begin
    if bWait then
    begin
      while WaitForSingleObject(Info.hProcess, 100) = WAIT_TIMEOUT do
        Application.ProcessMessages;
      bOK := GetExitCodeProcess(Info.hProcess, DWORD(Result));
    end
    else
      Result := 0;
  end;
  if not bOK then
    Result := -1;
end;

function fUsuarioWindowsComDireitoDeAcesso: Boolean;
var
  Registry: TRegistry;
begin
  Registry := TRegistry.Create;
  try
    with Registry do
    begin
      RootKey := HKEY_LOCAL_MACHINE;

      Result := OpenKey('Software\Microsoft\Windows\CurrentVersion\Uninstall', False);
    End;
  Finally
    Registry.Free;
  end;
end;


function fMontaDataHora(strDataHora: String): TDateTime;
  Var
    strDataHoraFormatada: string;
begin
  strDataHoraFormatada :=
    Copy(strDataHora, 1, 2) + '/' + //dia
    Copy(strDataHora, 3, 2) + '/' + //mes
    Copy(strDataHora, 5, 4) + ' ' + //ano
    Copy(strDataHora, 9, 2) + ':' + //hora
    Copy(strDataHora, 11, 2) + ':' + //minuto
    Copy(strDataHora, 13, 2);

  Result := StrToDateTime(strDataHoraFormatada);
end;

function fRetEmpresaFisica(conexao: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): String;
begin
  Result := fCampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER'], conexao, '');
end;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;

procedure pAtualizaMensagemLogSAT(strNumDoc, strEspDoc, strCodEmp, strSerie,
  strCodCli, strTip_FC, strMensagem: String);
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);

  Try
    qryAux.SQL.Add(' UPDATE LOGSAT ');
    qryAux.SQL.Add('    SET NFE_MENSAG = :MENSAG ');
    qryAux.SQL.Add('  WHERE NFE_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('    AND NFE_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('    AND NFE_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND NFE_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('    AND NFE_CODCLI = :CODCLI ');
    qryAux.SQL.Add('    AND NFE_TIP_FC = :TIP_FC ');
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('TIP_FC').AsString := strTip_FC;
    qryAux.ParamByName('MENSAG').AsString := strMensagem;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
  Var
    intAutIncAtu: Integer;

    strSQL,
    strProEmp: String;
    qryGenCod: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    blnInTransaction: Boolean;

    function fAutoIncremCadastrado: Boolean;
      Var
        qryGenTmp : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    begin
      Try

        qryGenTmp := fCriaQuery;

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM '+
                  '  FROM ' + strNomeTabela +
                  ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
          ParamByName('AUTINC').AsString := fFormataAutInc(intAutIncAtu, strCodEmp, strProEmp);
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

      Finally
        FreeAndNil(qryGenTmp);
      End;

    end;

    function fGetUltAutIncPROCOD: Integer;
      Var
        strTmp: String;
        qryTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    Begin
      strTmp := '';
      strTmp := strTmp + ' SELECT ';
      strTmp := strTmp + '   MAX(MID(AUTOINCREM, 4, 14)) AUTINC ';
      strTmp := strTmp + ' FROM ';
      strTmp := strTmp + '   PROCOD ';
      strTmp := strTmp + ' WHERE ';
      strTmp := strTmp + '   PRO_CODEMP = "' + VS_strCodEmp + '" ';

      Try
        qryTmp := fCriaQuery;

        With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strTmp);
          Open;

          If Not IsEmpty Then
            Result := FieldByName('AUTINC').AsInteger
          Else
            Result := 1;
        End;
      Except
        On E: Exception Do
          Raise;
      End;

      FreeAndNIl(qryTmp);
    End;
begin
  qryGenCod := fCriaQuery;
  blnInTransaction := qryGenCod.Connection.InTransaction;

  Repeat

    If Not blnInTransaction Then
    Begin
      qryGenCod.Connection.StartTransaction;
    End;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  PRO_AUTINC AS AUTINC  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
      strSQL := strSQL + ' FOR UPDATE ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;

        If IsEmpty Then
        Begin
          If SameText(strNomeTabela, 'PROCOD') Then
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROCOD');
            Open;

            Insert;
            FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
            FieldByName('PRO_CODSEQ').AsString  := '001';
            FieldByName('PRO_TAMCOD').AsInteger := 3;
            FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
            FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
            FieldByName('PRO_CODAUT').AsString  := 'N';
            Post;

            Close;
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROINC');
            Open;

            Insert;
            FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
            FieldByName('PRO_AUTINC').AsInteger := 1;
            FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
            Post;

            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NOMARQ').AsString := strNomeTabela;
            Open;
          End
          Else
          If SameText(strNomeTabela, 'MDFFIS') Then
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROCOD');
            Open;

            Insert;
            FieldByName('PRO_NOMARQ').AsString  := 'MDFFIS';
            FieldByName('PRO_CODSEQ').AsString  := '001';
            FieldByName('PRO_TAMCOD').AsInteger := 20;
            FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica + fPadL(IntToStr(1) + VS_strCodEmp, 17, '0');
            FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
            FieldByName('PRO_CODAUT').AsString  := 'S';
            Post;

            Close;
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROINC');
            Open;

            Insert;
            FieldByName('PRO_NOMARQ').AsString  := 'MDFFIS';
            FieldByName('PRO_AUTINC').AsInteger := 1;
            FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica + fPadL(IntToStr(1) + VS_strCodEmp, 17, '0');
            Post;

            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NOMARQ').AsString := strNomeTabela;
            Open;
          End
          Else
          Begin
            Close;
            FreeAndNil(qryGenCod);
            Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Incrementos! Verifique.' + #13#10);
          End;
        End;

        strProEmp := fRetEmpresaFisica;

        If FieldByName('AUTINC').IsNull Then
          intAutIncAtu := 1
        Else
          intAutIncAtu := FieldByName('AUTINC').AsInteger;

        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'SET ';

      If intIntervalo > 1 Then
      Begin

        If intAutIncAtu = 1 Then
          strSQL := strSQL + '  PRO_AUTINC = ' + IntToStr(intIntervalo + 1)
        Else
          strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + ' + IntToStr(intIntervalo);

      End Else
      Begin

        If intAutIncAtu = 1 Then
          strSQL := strSQL + '  PRO_AUTINC = 2 '
        Else
          strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

      End;

      strSQL := strSQL + '  WHERE ';
      strSQL := strSQL + '    PRO_NOMARQ = :NOMARQ ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        ExecSQL;
        Close;
      End;

      Result :=  strProEmp + fPadL(IntToStr(intAutIncAtu) + strCodEmp, 17, '0');

      If Not blnInTransaction Then
        qryGenCod.Connection.Commit;

    Except
      On E: Exception Do
      Begin
        qryGenCod.Connection.Rollback;
        FreeAndNil(qryGenCod);
        pLogImp('Exceção em untUtil.fRetAutoIncrem : '+ E.message);
        Raise Exception.Create(E.message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

  Until (Not fAutoIncremCadastrado);

  FreeAndNil(qryGenCod);

end;

function fAplicativoInstalado(Aplicativo: string): Boolean;
Var
  List: TStringList;
  Registry: TRegistry;
  i: Integer;
  DisplayName: String;
begin
  Result := False;
  Registry := TRegistry.Create;
  List := TStringList.Create;
  try
    with Registry do
    begin
      RootKey := HKEY_LOCAL_MACHINE;

      if OpenKey('Software\Microsoft\Windows\CurrentVersion\Uninstall', False) Then
      Begin
        GetKeyNames(List);
        CloseKey;
      End;

      for i := 0 to List.Count - 1 do
      begin
        RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('Software\Microsoft\Windows\CurrentVersion\Uninstall\' + List[i], False);
        DisplayName := ReadString('DisplayName');
        CloseKey;

        if pos(AnsiUpperCase(Aplicativo), AnsiUpperCase(DisplayName)) > 0 then
        begin
          Result := true;
          exit;
        end;
      End;
    end;
  Finally
    Registry.Free;
    List.Free;
  end;
end;

function fUsaSat(strCodEmp : String) : Boolean;
  Var
    strPathSat : String;
Begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  If (fCfgSisPainel('USASAT', Nil, True, strCodEmp) = 'S') And (fCfgSisPainel('SATECF', Nil, True, strCodEmp) = 'S') Then
  Begin
    If Not fEmptyStr(VS_PathSat) Then
    Begin
      strPathSat := IncludeTrailingPathDelimiter(VS_PathSat) + 'opcoes_sat.ini';
    End
    Else
    Begin
      strPathSat := IncludeTrailingPathDelimiter(fCfgSisPainel('PATSAT')) + 'opcoes_sat.ini';
    End;

    If FileExists(strPathSat) Then
      Result := StrToBool(fArqIni(0, 'SATCFE', 'USASAT', '0', strPathSat ))
    Else
      Result := False;
  End
  Else
    Result := (fCfgSisPainel('USASAT', Nil, True, strCodEmp) = 'S');
End;

function fUsaNotaServicoEletronicaEnotas: Boolean;
begin
  Result := False;

  if fExisteConfiguracao('NFSENO') then
    Result := (fCfgSisPainel('NFSENO') = 'S');
end;

procedure pConfiguraOpcoesRegionais;
  Var
    reg: TRegistry;
Begin
  Try
    reg := TRegistry.Create;
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey('Control Panel\International', True);

    reg.WriteString('sMonThousandSep', '.');
    reg.WriteString('sMonDecimalSep' , ',');
    reg.WriteString('sThousand'      , '.');
    reg.WriteString('sDecimal'       , ',');
    reg.WriteString('sGrouping'      , '3;0');
    reg.WriteString('sMonGrouping'   , '3;0');
    reg.WriteString('iDigits'        , '2');
    reg.WriteString('iCurrDigits'    , '2');
    reg.WriteString('sDate'          , '/');
    reg.WriteString('sShortDate'     , 'dd/MM/yyyy');
    reg.WriteString('sLongDate'      , 'dddd, d'' de ''MMMM'' de ''yyyy');
    reg.WriteString('sTime'          , ':');
    reg.WriteString('sTimeFormat'    , 'HH:mm:ss');

    {$IF Defined(UNIDAC)}
    FormatSettings.ThousandSeparator := '.';
    FormatSettings.DecimalSeparator  := ',';
    FormatSettings.CurrencyDecimals  := 2;
    FormatSettings.ShortDateFormat   := 'dd/MM/yyyy';
    FormatSettings.LongDateFormat    := 'dddd, d'' de ''MMMM'' de ''yyyy';
    FormatSettings.ShortTimeFormat   := 'hh:mm';
    FormatSettings.LongDateFormat    := 'hh:mm:ss';
    FormatSettings.CurrencyFormat    := 2; // [ 2 >> Before amount with space ]
    FormatSettings.CurrencyString    := 'R$';
    {$ELSE}
    ThousandSeparator := '.';
    DecimalSeparator  := ',';
    CurrencyDecimals  := 2;
    ShortDateFormat   := 'dd/MM/yyyy';
    LongDateFormat    := 'dddd, d'' de ''MMMM'' de ''yyyy';
    ShortTimeFormat   := 'hh:mm';
    LongDateFormat    := 'hh:mm:ss';
    {$IFEND}
  Finally
    FreeAndNil(reg);
  End;

End;

procedure pSinalizarAoCoordenadorStatusParaTerminarAposUltimaTarefa;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('UPDATE NFE_TAREFAS          ');
    qryGen.SQL.Add('   SET NFE_DESCRI = :DESCRI ');
    qryGen.SQL.Add(' WHERE NFE_CODEMP = :CODEMP ');
    qryGen.SQL.Add('   AND NFE_TAREFA LIKE "NFE_COORDENADOR_STATUS%" ');
    qryGen.ParamByName('DESCRI').AsString := consTagSinalParaTerminar;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pSinalizarAoCoordenadorStatusParaSeAutoBloquear;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('UPDATE NFE_TAREFAS          ');
    qryGen.SQL.Add('   SET NFE_DESCRI = :DESCRI ');
    qryGen.SQL.Add(' WHERE NFE_CODEMP = :CODEMP ');
    qryGen.SQL.Add('   AND NFE_TAREFA LIKE "NFE_COORDENADOR_STATUS%" ');
    qryGen.ParamByName('DESCRI').AsString := consTagSinalParaBloquear;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fBlinda(const S: string): string;
begin
  Result := '<[.'+S+'.]>';
end;

(*
  >C         Define o início de uma TABELA (linha de cabeçalho).
             - Usa-se "|" como separador de colunas.
             - Suporta alinhamento por coluna:
                 /L esquerda
                 /C centro
                 /R direita
             Ex: >C Documento/L|Chave de Acesso/C|Valor/R

  >B         Inicia um BOX de texto alinhado à ESQUERDA.
  >B/C       Inicia um BOX de texto CENTRALIZADO.
             - Pode ter modificadores de fechamento:
                 [T] fecha apenas TOPO
                 [B] fecha apenas BASE
                 (sem nada) fecha TOPO e BASE (padrão)
             Ex: >B/C  Relatório Cancelamento (Texto Ficará Centralizado)
                 >B[B] Resumodo da Operação (Texto Ficará a esquerda e só terá a divisão na base)

  >L         Linha LIVRE (ignorada na tabulação, sai crua no resultado).
             Ex: >L Observações......

  Marcadores de proteção:
    <[. .]>  Tudo que estiver dentro NÃO será separado por "|". Útil para proteger textos que possuem pipes internos.
             Ex: <[. ||Autorizado uso NFe| .]> é tratado como um único campo.
*)
function fTabulaTexto(const Linhas: TStrings; const Separador: Char = '|'; const UniformWidth: Boolean = True; const IncluirLinhaAposCabecalho: Boolean = True;
                      const StartMarker: string = '<[.'; const EndMarker: string = '.]>'; const RemoveMarkersFromOutput: Boolean = True): string;
var
  OutLines: TStringList;
  GlobalInternalWidth: Integer;

  {===================== SUB-FUNÇÕES =====================}

  function IsNumericLike(const S: string): Boolean;
  var
    V: Double;
  begin
    Result := TryStrToFloat(Trim(S), V);
  end;

  function PadLeft(const S: string; Total: Integer): string;
  begin
    if Total <= Length(S) then
      Result := Copy(S, 1, Total)
    else
      Result := StringOfChar(' ', Total - Length(S)) + S;
  end;

  function PadRight(const S: string; Total: Integer): string;
  begin
    if Total <= Length(S) then
      Result := Copy(S, 1, Total)
    else
      Result := S + StringOfChar(' ', Total - Length(S));
  end;

  function PadCenter(const S: string; Total: Integer): string;
  var
    L, Need, LP, RP: Integer;
  begin
    L := Length(S);
    if L >= Total then
      Result := Copy(S, 1, Total)
    else
    begin
      Need := Total - L;
      LP := Need div 2;
      RP := Need - LP;
      Result := StringOfChar(' ', LP) + S + StringOfChar(' ', RP);
    end;
  end;

  procedure SplitRespectingMarkers(const Line: string; Sep: Char;
    const StartMarker, EndMarker: string; RemoveMarkers: Boolean; Parts: TStrings);
  var
    idxChar, L, SMlen, EMlen: Integer;
    Inside: Boolean;
    Token: string;
  begin
    Parts.Clear;
    Token := '';
    Inside := False;
    L := Length(Line);
    SMlen := Length(StartMarker);
    EMlen := Length(EndMarker);
    idxChar := 1;

    while idxChar <= L do
    begin
      if (SMlen > 0) and (idxChar + SMlen - 1 <= L) and
         (Copy(Line, idxChar, SMlen) = StartMarker) and (not Inside) then
      begin
        Inside := True;
        if not RemoveMarkers then
          Token := Token + StartMarker;
        Inc(idxChar, SMlen);
        Continue;
      end;

      if (EMlen > 0) and (idxChar + EMlen - 1 <= L) and
         (Copy(Line, idxChar, EMlen) = EndMarker) and Inside then
      begin
        Inside := False;
        if not RemoveMarkers then
          Token := Token + EndMarker;
        Inc(idxChar, EMlen);
        Continue;
      end;

      if (Line[idxChar] = Sep) and (not Inside) then
      begin
        Parts.Add(Trim(Token));
        Token := '';
        Inc(idxChar);
        Continue;
      end;

      Token := Token + Line[idxChar];
      Inc(idxChar);
    end;

    Parts.Add(Trim(Token));
  end;

  procedure SplitHeaderWithAlign(const HeaderLine: string; Sep: Char;
    const StartMarker, EndMarker: string; RemoveMarkers: Boolean;
    Parts, Aligns: TStrings);
  var
    Tmp: TStringList;
    k, p: Integer;
    Cell, Code: string;
  begin
    Tmp := TStringList.Create;
    try
      SplitRespectingMarkers(HeaderLine, Sep, StartMarker, EndMarker, RemoveMarkers, Tmp);
      Parts.Clear;
      Aligns.Clear;

      for k := 0 to Tmp.Count - 1 do
      begin
        Cell := Tmp[k];
        Code := '';
        p := LastDelimiter('/', Cell);

        if (p > 0) and (p < Length(Cell)) then
        begin
          Code := UpperCase(Trim(Copy(Cell, p + 1, MaxInt))); // L/C/R
          Cell := Trim(Copy(Cell, 1, p - 1));
        end;

        Parts.Add(Cell);

        if (Code = 'L') or (Code = 'C') or (Code = 'R') then
          Aligns.Add(Code)
        else
          Aligns.Add('');
      end;
    finally
      Tmp.Free;
    end;
  end;

  function MakeDashLineByTextLength(const AnyFormattedLine: string): string;
  var
    k, L: Integer;
  begin
    L := Length(AnyFormattedLine);

    if L < 2 then
    begin
      Result := '||';
      Exit;
    end;

    Result := '|';

    for k := 2 to L - 1 do
      Result := Result + '-';

    Result := Result + '|';
  end;

  function JoinCols(const Cells, ColAligns: TStrings; const ColWidths: array of Integer;
    const SepStr: string; IsHeader: Boolean): string;
  var
    c, ColCount: Integer;
    Cell, Al: string;

    function FormatCell(const S: string; W: Integer; const AlignCode: string; IsHeader: Boolean): string;
    begin
      if AlignCode = 'C' then
        Result := PadCenter(S, W)
      else if (AlignCode = 'R') or ((AlignCode = '') and (not IsHeader) and IsNumericLike(S)) then
        Result := PadLeft(S, W)
      else
        Result := PadRight(S, W);
    end;

  begin
    ColCount := Length(ColWidths);
    Result := '| ';

    for c := 0 to ColCount - 1 do
    begin
      if c < Cells.Count then
        Cell := Trim(Cells[c])
      else
        Cell := '';

      if (ColAligns <> nil) and (c < ColAligns.Count) then
        Al := ColAligns[c]
      else
        Al := '';

      Result := Result + FormatCell(Cell, ColWidths[c], Al, IsHeader);

      if c < ColCount - 1 then
        Result := Result + SepStr;
    end;

    Result := Result + ' |';
  end;

  function PadFormattedLineToInternal(const Formatted: string; TargetInternal: Integer): string;
  var
    CurInternal, BaseLen: Integer;
  begin
    BaseLen := Length(Formatted);      // "| " ... " |"
    CurInternal := BaseLen - 4;        // tira bordas e espaços

    if (TargetInternal > CurInternal) then
      Result := Copy(Formatted, 1, BaseLen - 2) + StringOfChar(' ', TargetInternal - CurInternal) + ' |'
    else
      Result := Formatted;
  end;

  function InternalWidthFromCols(const Widths: array of Integer): Integer;
  var
    sum, c: Integer;
  begin
    sum := 0;

    for c := 0 to High(Widths) do
      Inc(sum, Widths[c]);

    if Length(Widths) > 1 then
      Inc(sum, (Length(Widths) - 1) * 3); // " | "

    Result := sum;
  end;

  function IsDir(const S, Prefix: string): Boolean;
  begin
    Result := Copy(TrimLeft(S), 1, Length(Prefix)) = Prefix;
  end;

  function AfterDir(const S, Prefix: string): string;
  var
    T: string;
  begin
    T := TrimLeft(S);
    Result := Trim(Copy(T, Length(Prefix) + 1, MaxInt));
  end;

  procedure ComputeGlobalInternalWidth;
  var
    idx, cur, colCount, w, locMax: Integer;
    Parts, Aligns, Row: TStringList;
    ColWidths: array of Integer;
    line, hdr: string;
  begin
    GlobalInternalWidth := 0;

    Parts := TStringList.Create;
    Aligns := TStringList.Create;
    Row := TStringList.Create;
    try
      idx := 0;

      while idx < Linhas.Count do
      begin
        line := Linhas[idx];

        // Tabela
        if IsDir(line, '>C') then
        begin
          hdr := AfterDir(line, '>C');
          SplitHeaderWithAlign(hdr, Separador, StartMarker, EndMarker, RemoveMarkersFromOutput, Parts, Aligns);

          colCount := Parts.Count;
          SetLength(ColWidths, colCount);

          for w := 0 to colCount - 1 do
            ColWidths[w] := Length(Parts[w]);

          cur := idx + 1;

          while (cur < Linhas.Count) and
                (not IsDir(Linhas[cur], '>C')) and (not IsDir(Linhas[cur], '>B')) and
                (not IsDir(Linhas[cur], '>B/C')) and (not IsDir(Linhas[cur], '>L')) do
          begin
            Row.Clear;
            SplitRespectingMarkers(Linhas[cur], Separador, StartMarker, EndMarker, RemoveMarkersFromOutput, Row);

            for w := 0 to Row.Count - 1 do
              if (w < colCount) and (Length(Row[w]) > ColWidths[w]) then
                ColWidths[w] := Length(Row[w]);

            Inc(cur);
          end;

          w := InternalWidthFromCols(ColWidths);

          if w > GlobalInternalWidth then
            GlobalInternalWidth := w;

          idx := cur;
          Continue;
        end;

        // Box
        if IsDir(line, '>B/C') or IsDir(line, '>B') then
        begin
          locMax := 0;

          // conteúdo inline
          if Pos(' ', line) > 0 then
          begin
            // pode existir "[T]" ou "[B]" logo após o prefixo; então achamos o primeiro espaço real
            // varremos para achar o primeiro espaço após o prefixo e sufixo opcional
            // (para medir a parte inline corretamente)
            // como estamos só medindo largura global aqui, vamos simplificar:
            // pega o texto depois do primeiro espaço, se existir
            w := Length(Trim(Copy(line, Pos(' ', line) + 1, MaxInt)));

            if w > locMax then
              locMax := w;
          end;

          cur := idx + 1;

          while (cur < Linhas.Count) and
                (not IsDir(Linhas[cur], '>C')) and (not IsDir(Linhas[cur], '>B')) and
                (not IsDir(Linhas[cur], '>B/C')) and (not IsDir(Linhas[cur], '>L')) do
          begin
            if Length(Linhas[cur]) > locMax then
              locMax := Length(Linhas[cur]);

            Inc(cur);
          end;

          if locMax > GlobalInternalWidth then
            GlobalInternalWidth := locMax;

          idx := cur;
          Continue;
        end;

        Inc(idx); // >L ou linha solta
      end;
    finally
      Parts.Free;
      Aligns.Free;
      Row.Free;
    end;
  end;

  procedure EmitTable(var Index: Integer);
  var
    Parts, Aligns, Row: TStringList;
    ColWidths: array of Integer;
    ColCount, cur, startData, k: Integer;
    SepStr, HeaderTxt, DashTxt, LineTxt, hdr: string;
  begin
    Parts := TStringList.Create;
    Aligns := TStringList.Create;
    Row := TStringList.Create;
    try
      hdr := AfterDir(Linhas[Index], '>C');
      SplitHeaderWithAlign(hdr, Separador, StartMarker, EndMarker, RemoveMarkersFromOutput, Parts, Aligns);

      ColCount := Parts.Count;
      SetLength(ColWidths, ColCount);

      for k := 0 to ColCount - 1 do
        ColWidths[k] := Length(Parts[k]);

      // medir dados p/ larguras locais
      startData := Index + 1;
      cur := startData;

      while (cur < Linhas.Count) and
            (not IsDir(Linhas[cur], '>C')) and (not IsDir(Linhas[cur], '>B')) and
            (not IsDir(Linhas[cur], '>B/C')) and (not IsDir(Linhas[cur], '>L')) do
      begin
        Row.Clear;
        SplitRespectingMarkers(Linhas[cur], Separador, StartMarker, EndMarker, RemoveMarkersFromOutput, Row);

        for k := 0 to Row.Count - 1 do
          if (k < ColCount) and (Length(Row[k]) > ColWidths[k]) then
            ColWidths[k] := Length(Row[k]);

        Inc(cur);
      end;

      SepStr := ' | ';
      HeaderTxt := JoinCols(Parts, Aligns, ColWidths, SepStr, True);

      if UniformWidth and (GlobalInternalWidth > 0) then
        HeaderTxt := PadFormattedLineToInternal(HeaderTxt, GlobalInternalWidth);

      DashTxt := MakeDashLineByTextLength(HeaderTxt);

      // topo, header, separador pós-header (opcional)
      OutLines.Add(DashTxt);
      OutLines.Add(HeaderTxt);

      if IncluirLinhaAposCabecalho then
        OutLines.Add(DashTxt);

      // dados
      cur := startData;

      while (cur < Linhas.Count) and
            (not IsDir(Linhas[cur], '>C')) and (not IsDir(Linhas[cur], '>B')) and
            (not IsDir(Linhas[cur], '>B/C')) and (not IsDir(Linhas[cur], '>L')) do
      begin
        Row.Clear;
        SplitRespectingMarkers(Linhas[cur], Separador, StartMarker, EndMarker, RemoveMarkersFromOutput, Row);

        LineTxt := JoinCols(Row, Aligns, ColWidths, SepStr, False);

        if UniformWidth and (GlobalInternalWidth > 0) then
          LineTxt := PadFormattedLineToInternal(LineTxt, GlobalInternalWidth);

        OutLines.Add(LineTxt);
        Inc(cur);
      end;

      // rodapé
      OutLines.Add(DashTxt);

      Index := cur; // devolve onde parou
    finally
      Parts.Free;
      Aligns.Free;
      Row.Free;
    end;
  end;

  procedure ParseBoxDirective(const Line: string; out IsCenter: Boolean;
    out CloseTop, CloseBase: Boolean; out InlineText: string);
  var
    S: string;
    prefix, token: string;
    p, pbeg, pend: Integer;
  begin
    S := TrimLeft(Line);
    IsCenter := False;
    CloseTop := True;
    CloseBase := True;
    InlineText := '';

    if Copy(S, 1, 4) = '>B/C' then
    begin
      IsCenter := True;
      prefix := '>B/C';
    end
    else if Copy(S, 1, 2) = '>B' then
    begin
      IsCenter := False;
      prefix := '>B';
    end
    else
    begin
      Exit;
    end;

    // checa [T] ou [B] logo após o prefixo
    pbeg := Length(prefix) + 1;
    if (pbeg <= Length(S)) and (S[pbeg] = '[') then
    begin
      pend := Pos(']', S);
      if (pend > pbeg) then
      begin
        token := UpperCase(Copy(S, pbeg + 1, pend - pbeg - 1));
        if token = 'T' then
        begin
          CloseBase := False;
        end
        else if token = 'B' then
        begin
          CloseTop := False;
        end;
        // avança prefixo + [X]
        p := pend + 1;
      end
      else
      begin
        p := pbeg; // formato estranho, ignora
      end;
    end
    else
    begin
      p := pbeg; // sem [X]
    end;

    // pula espaço e captura inline
    while (p <= Length(S)) and (S[p] = ' ') do
      Inc(p);

    if p <= Length(S) then
      InlineText := Trim(Copy(S, p, MaxInt))
    else
      InlineText := '';
  end;

  procedure EmitBox(var Index: Integer);
  var
    IsCenter, CloseTop, CloseBase: Boolean;
    InlineText: string;
    Buf: TStringList;
    InternalW, cur, k: Integer;
    Base: string;
  begin
    // interpreta diretiva (centro, fechamento topo/base, texto inline)
    ParseBoxDirective(Linhas[Index], IsCenter, CloseTop, CloseBase, InlineText);

    Buf := TStringList.Create;
    try
      if InlineText <> '' then
        Buf.Add(InlineText);

      cur := Index + 1;

      while (cur < Linhas.Count) and
            (not IsDir(Linhas[cur], '>C')) and (not IsDir(Linhas[cur], '>B')) and
            (not IsDir(Linhas[cur], '>B/C')) and (not IsDir(Linhas[cur], '>L')) do
      begin
        Buf.Add(Linhas[cur]);
        Inc(cur);
      end;

      if UniformWidth and (GlobalInternalWidth > 0) then
        InternalW := GlobalInternalWidth
      else
      begin
        InternalW := 1;

        for k := 0 to Buf.Count - 1 do
          if Length(Buf[k]) > InternalW then
            InternalW := Length(Buf[k]);
      end;

      Base := '| ' + StringOfChar(' ', InternalW) + ' |';

      if CloseTop then
        OutLines.Add(MakeDashLineByTextLength(Base));

      for k := 0 to Buf.Count - 1 do
      begin
        if IsCenter then
          OutLines.Add('| ' + PadCenter(Buf[k], InternalW) + ' |')
        else
          OutLines.Add('| ' + PadRight(Buf[k], InternalW) + ' |');
      end;

      if CloseBase then
        OutLines.Add(MakeDashLineByTextLength(Base));

      Index := cur; // devolve onde parou
    finally
      Buf.Free;
    end;
  end;

  {=================== FIM SUB-FUNÇÕES ===================}
var
  idx: Integer;
begin
  Result := '';

  if (Linhas = nil) or (Linhas.Count = 0) then
    Exit;

  OutLines := TStringList.Create;
  try
    if UniformWidth then
      ComputeGlobalInternalWidth
    else
      GlobalInternalWidth := 0;

    // loop principal
    idx := 0;

    while idx < Linhas.Count do
    begin
      if IsDir(Linhas[idx], '>C') then
      begin
        EmitTable(idx);
        Continue;
      end;

      if IsDir(Linhas[idx], '>B') then
      begin
        EmitBox(idx);
        Continue;
      end;

      if IsDir(Linhas[idx], '>B/C') then
      begin
        EmitBox(idx);
        Continue;
      end;

      if IsDir(Linhas[idx], '>L') then
      begin
        OutLines.Add(AfterDir(Linhas[idx], '>L'));
        Inc(idx);
        Continue;
      end;

      Inc(idx); // ignora linhas soltas
    end;

    Result := OutLines.Text;
  finally
    OutLines.Free;
  end;
end;

function fFindProcessOK: Boolean;
begin
  //CONSEGUE SE ACHAR NO WINDOWS
  If (VS_FindProcesOK = '') Then
  Begin
    Try
      VS_FindProcesOK := 'N';
      If FindProcess(GetCurrentProcessId) Then
        VS_FindProcesOK := 'S';
    Except
      VS_FindProcesOK := 'N';
    End;
  End;

  Result := VS_FindProcesOK = 'S';
end;

function fNormalizaNomeImpressora(const AstrNomeImpressora: String): String ;
var
  LintCnt: Integer ;
  LstrRetorno: String ;
begin
  LstrRetorno := '' ;
  for LintCnt := 1 to Length(AstrNomeImpressora) do
  begin
    if {$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)} CharInSet(AstrNomeImpressora[LintCnt], ['0'..'9', 'a'..'z', 'A'..'Z']) {$ELSE} AstrNomeImpressora[LintCnt] in ['0'..'9', 'a'..'z', 'A'..'Z'] {$IFEND} then
      LstrRetorno := LstrRetorno + AstrNomeImpressora[LintCnt] ;
  end ;
  result := LstrRetorno ;
end;

procedure pDeletaTarefa(const strTarefa, strProcId, strCodEmp: String);
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Text := 'DELETE FROM NFE_TAREFAS     '+
                       ' WHERE NFE_TAREFA = :TAREFA '+
                       '   AND NFE_CODEMP = :CODEMP '+
                       '   AND NFE_PROCID = :PROCID ';

    qryGen.ParamByName('TAREFA').AsString := strTarefa;
    qryGen.ParamByName('CODEMP').AsString := strProcId;
    qryGen.ParamByName('PROCID').AsString := strCodEmp;

    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pRemoverTarefasInativas(blnLimparTodas: Boolean = False);
Var
  qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  intCnt: Integer;
begin
  If Assigned(objLogDanfe) Then
  Begin
    objLogDanfe.objConexao := frmModulo.Database;
    objLogDanfe.strNumDoc := '...';
    objLogDanfe.strEspDoc := '...';
    objLogDanfe.strCodEmp := VS_strCodEmp;
    objLogDanfe.strSerie_ := '...';
    objLogDanfe.strCodCli := '...';
  End;

  qryGen := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM NFE_TAREFAS ');
    qryGen.SQL.Add('WHERE NFE_TAREFA LIKE "NFE_PROCESSAR_STATUS%" ');
    qryGen.SQL.Add('  AND NFE_CODEMP = "' + VS_strCodEmp + '" ');
    qryGen.SQL.Add('  AND TIMEDIFF(nOw(), NFE_ULTSTA) > "00:02:00" ');
    qryGen.Open;

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      Try
        pLogImp('KillProcess('+qryGen.FieldByName('NFE_PROCID').AsString+') '+qryGen.FieldByName('NFE_TAREFA').AsString+' COM MAIS DE "00:02:00"');
      Except
        //
      End;

      KillProcess(StrToInt64Def(qryGen.FieldByName('NFE_PROCID').AsString, 0));

      pDeletaTarefa(qryGen.FieldByName('NFE_TAREFA').AsString,
                    qryGen.FieldByName('NFE_CODEMP').AsString,
                    qryGen.FieldByName('NFE_PROCID').AsString);

      qryGen.Next;
    End;

    If blnLimparTodas Then
    Begin
      If (fCampoTabela('COUNT(*)','NFE_TAREFAS',['NFE_CODEMP'],[VS_strCodEmp],frmModulo.Database) > 0) Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add('UPDATE NFE_TAREFAS          ');
        qryGen.SQL.Add('   SET NFE_DESCRI = :DESCRI ');
        qryGen.SQL.Add(' WHERE NFE_CODEMP = :CODEMP ');
        qryGen.ParamByName('DESCRI').AsString := consTagSinalParaBloquear;
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryGen.ExecSQL;

        intCnt := 0;
        repeat
          Sleep(1000);

          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add('SELECT * FROM NFE_TAREFAS WHERE NFE_CODEMP = "' + VS_strCodEmp + '"');
          qryGen.Open;

          Inc(intCnt);
        until (qryGen.IsEmpty) Or (intCnt > 5) ;

        qryGen.First;
        If (Not qryGen.IsEmpty) Then
        Begin
          While Not qryGen.Eof Do
          Begin
            Try
              pLogImp('KillProcess('+qryGen.FieldByName('NFE_PROCID').AsString+') '+qryGen.FieldByName('NFE_TAREFA').AsString+' NÃO TERMINOU NATURALMENTE');
            Except
              //
            End;

            KillProcess(StrToInt64Def(qryGen.FieldByName('NFE_PROCID').AsString, 0));

            pDeletaTarefa(qryGen.FieldByName('NFE_TAREFA').AsString,
                          qryGen.FieldByName('NFE_CODEMP').AsString,
                          qryGen.FieldByName('NFE_PROCID').AsString);

            qryGen.Next;
          End;

          qryGen.Close;
          qryGen.SQL.Clear;
          qryGen.SQL.Add('DELETE FROM NFE_TAREFAS WHERE NFE_CODEMP = "' + VS_strCodEmp + '"');
          qryGen.ExecSQL;
        End;
      End;
    End
    Else
    Begin
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT * FROM NFE_TAREFAS ');
      qryGen.SQL.Add('WHERE TIMEDIFF(nOw(), NFE_ULTSTA) > "00:05:00" ');
      qryGen.SQL.Add('  AND NFE_CODEMP = "' + VS_strCodEmp + '" ');
      qryGen.Open;

      qryGen.First;
      While Not qryGen.Eof Do
      Begin
        Try
          pLogImp('KillProcess('+qryGen.FieldByName('NFE_PROCID').AsString+') '+qryGen.FieldByName('NFE_TAREFA').AsString+' COM MAIS DE "00:05:00"');
        Except
          //
        End;

        KillProcess(StrToInt64Def(qryGen.FieldByName('NFE_PROCID').AsString, 0));

        pDeletaTarefa(qryGen.FieldByName('NFE_TAREFA').AsString,
                      qryGen.FieldByName('NFE_CODEMP').AsString,
                      qryGen.FieldByName('NFE_PROCID').AsString);

        qryGen.Next;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
  If Assigned(objLogDanfe) Then
    If fEstaNoPainelNFe Then
      objLogDanfe.strNumDoc := '';

  VS_horUltimoRemoverTarefasInativas := Time();
end;

function fPainelNFeNoTSPlus: Boolean;
begin
  Result := False;

  If (Pos('TSPLUS', AnsiUpperCase(VS_ComputerNetName)) > 0) Then
  Begin
    Result := True;
    Exit;
  End;

  If (fArqIni(0, 'GERAL', 'TSPLUS', '', fPathOpcoesIni) = 'S') Then
  Begin
    Result := True;
    Exit;
  End;

  If (FileExists(ExtractFilePath(Application.ExeName) + 'NFE_STATUS_INFO.txt')) then
  Begin
    Result := True;
    Exit;
  End;
end;

procedure pEncerrarTodosProcessosNFeStatus;
begin
  Application.ProcessMessages;
  KillProcess('NFeStatus.exe');
  KillProcess('NFeImpressao.exe');
  Sleep(2000);
end;

procedure pPegaDataHoraSistema(Var dtaDtaSis, dtaHraSis : TDateTime);
  Var
    qryGenTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGenTmp := fCriaQuery(Nil);
  Try
    Try
      qryGenTmp.Close;
      qryGenTmp.SQL.Clear;
      qryGenTmp.SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
      qryGenTmp.Open;
      dtaDtaSis := qryGenTmp.FieldByName('CURRENT_DATE').AsDateTime;
      dtaHraSis := qryGenTmp.FieldByName('CURRENT_TIME').AsDateTime;
      qryGenTmp.Close;
    Except
      dtaDtaSis := Date;
      dtaHraSis := Time();
    End;
  Finally
    FreeAndNil(qryGenTmp);
  End;
end;

procedure DefinirTimeZoneEmSessaoMySql(const ACodigoEmpresa : String);
  Var
    LQryConexao : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LUsaTimeZone : String;
begin
  If (Trim(ACodigoEmpresa)='') Then
    Exit;
  LUsaTimeZone := fCFGSisPainel('USATMZ');
  If (Trim(LUsaTimeZone)='') Or (LUsaTimeZone = 'N') Then
    Exit;
  LQryConexao := fCriaQuery(Nil);
  Try
    LQryConexao.SQL.Text := Format('SET time_zone = %s;', [QuotedStr(CfgTmZoneToMySqlFormatTimeZone(ACodigoEmpresa))]);
    LQryConexao.ExecSQL;
  Finally
    FreeAndNil(LQryConexao);
  End;
end;

function CfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String): String;
  Const
    arrTimeZonesPemrmitidos : Array [1..4] Of Integer = (-2, -3, -4, -5);
  Var
    LTimeZoneConfigurado : Integer;
    LContador : Integer;
begin
  Result := '-3:00';
  If (Trim(ACodigoEmpresa)='') Then
    Exit;
  LTimeZoneConfigurado := TimeZoneConfigurado(ACodigoEmpresa);
  If LTimeZoneConfigurado = 0 Then
    Exit;
  For LContador := Low(arrTimeZonesPemrmitidos) To High(arrTimeZonesPemrmitidos) Do
  Begin
    If (arrTimeZonesPemrmitidos[LContador] = LTimeZoneConfigurado) Then
    Begin
      Result := Format('%d:00', [LTimeZoneConfigurado]);
      Exit;
    End;
  End;
end;

function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  Var
    LTimeZone : String;
begin
  Result := 0;

  LTimeZone := fCFGSisPainel('TMZONE');

  If (Trim(LTimeZone)='') Then
    Exit;

  Result := StrToIntDef(LTimeZone, 0);
end;

function fDataValida(dtaData: TDateTime): Boolean;
  Var
    wrdAno : Word;
    wrdMes : Word;
    wrdDia : Word;
begin
  wrdAno := StrToIntDef(FormatDateTime('yyyy', dtaData), 0);
  wrdMes := StrToIntDef(FormatDateTime('mm', dtaData), 0);
  wrdDia := StrToIntDef(FormatDateTime('dd', dtaData), 0);

  If (wrdAno = 1899) Then
    Result := False
  Else
    Result := IsValidDate(wrdAno, wrdMes, wrdDia);
end;

procedure pUpdateCfgSis(const strCodCfg, strCodEmp, strValCfg : String);
  Var
    qryCfgSis : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryCfgSis := fCriaQuery(Nil);
  Try
    qryCfgSis.Close;
    qryCfgSis.SQL.Clear;
    qryCfgSis.SQL.Add(' UPDATE CFGSIS ');
    qryCfgSis.SQL.Add('    SET SIS_VALCFG = :VALCFG ');
    qryCfgSis.SQL.Add('  WHERE SIS_CODCFG = :CODCFG ');
    qryCfgSis.SQL.Add('    AND SIS_CODEMP = :CODEMP ');
    qryCfgSis.ParamByName('VALCFG').AsString := strValCfg;
    qryCfgSis.ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;
    qryCfgSis.ParamByName('CODEMP').AsString := strCodEmp;
    qryCfgSis.ExecSQL;
  Finally
    FreeAndNil(qryCfgSis);
  End;
end;

function fExisteDocumentosEmContingenciaComPendenciaDeAutorizacao(const strEspecie : String): Boolean;
  Var
    strSQL : String;
    qryDocumentos : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryDocumentos := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT COUNT(*) AS CNT ';
    strSQL := strSQL + '  FROM LOGNFE ';
    strSQL := strSQL + ' WHERE NFE_ESPDOC <> "ME" ';
    strSQL := strSQL + '   AND NFE_STATUS NOT IN ("AT", "CN", "OK", "DC", "IN") ';
    strSQL := strSQL + '   AND NFE_CODEMP = :CODEMP  ';
    strSQL := strSQL + '   AND ((IFNULL(NFE_PNDPEC, 0) + IFNULL(NFE_PDSTDP, 0)) > 0) ';
    If Not fEmptyStr(strEspecie) Then
      strSQL := strSQL + ' AND NFE_ESPDOC = :ESPDOC ';
    qryDocumentos.Close;
    qryDocumentos.SQL.Clear;
    qryDocumentos.SQL.Add(strSQL);
    qryDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;
    If Not fEmptyStr(strEspecie) Then
      qryDocumentos.ParamByName('ESPDOC').AsString := strEspecie;
    qryDocumentos.Open;
    Result := (qryDocumentos.FieldByName('CNT').AsInteger > 0);
  Finally
    FreeAndNil(qryDocumentos);
  End;
end;

function fPainelEmAmbienteHomologacao(ACodigoEmpresa: String): Boolean;
begin
  Result := (Pos('hom', fCfgSis('CITURL', varString, ACodigoEmpresa)) > 0);
end;

function fRetornaURLPainelCitel(ACodigoEmpresa: String): String;
begin
  Result := Trim(fCfgSis('URLPRO', varString, ACodigoEmpresa));

  If fPainelEmAmbienteHomologacao(ACodigoEmpresa) Then
    Result := Trim(fCfgSis('URLHOM', varString, ACodigoEmpresa));
end;

function fValidaURLPainelCitel(ACodigoEmpresa: String): Boolean;
begin
  Result := False;

  If (Pos('homo', LowerCase(fCfgSis('URLPRO', varString, ACodigoEmpresa))) > 0) Then
    Exit;

  If (Pos('homo', LowerCase(fCfgSis('URLHOM', varString, ACodigoEmpresa))) = 0) Then
    Exit;

  Result := True;
end;

function fIntegracaoPainelCitelConfigurada(ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
begin
  Result := False;

  If not fTabelaExiste('PCITEL', Banco) Then
    Exit;

  If not fExisteConfiguracao('PUBKEY', Banco, ACodigoEmpresa) Then
    Exit;

  If fEmptyStr(fCfgSis('PUBKEY', varString, ACodigoEmpresa)) Then
    Exit;

  If fEmptyStr(fRetornaURLPainelCitel(ACodigoEmpresa)) Then
    Exit;

  If not fValidaURLPainelCitel(ACodigoEmpresa) Then
    Exit;

  Result := True;
end;

function fIntegracaoPainelCitelDownloadNotasDeTerceirosConfigurada(ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
var
  LCaminhoXml: String;
begin
  Result := False;

  If fTabelaExiste('DFETER', Banco) Then
  Begin
    If fExisteConfiguracao('DFETER', Banco) Then
      If fCfgAtiva(fCfgSis('DFETER', varString, ACodigoEmpresa)) Then
        Exit;
  End;

  If not fExisteConfiguracao('PWCNFT', Banco) Then
    Exit;

  If not fCfgSis('PWCNFT', varBoolean, ACodigoEmpresa) Then
    Exit;

  If not fExisteConfiguracao('PWCNSU', Banco) Then
    Exit;

  If not fExisteConfiguracao('XMLPAT', Banco) Then
    Exit;

  LCaminhoXml := fCfgSis('XMLPAT', varString, ACodigoEmpresa);

  If fEmptyStr(LCaminhoXml) Then
    Exit;

  If not DirectoryExists(LCaminhoXml) Then
    Exit;

  Result := True;
end;

function fIntegracaoPainelCitelDownloadConhecimentosDeTerceirosConfigurada(ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
var
  LCaminhoXml: String;
begin
  Result := False;

  If fTabelaExiste('DFETER', Banco) Then
  Begin
    If fExisteConfiguracao('CTETER', Banco) Then
      If fCfgAtiva(fCfgSis('CTETER', varString, ACodigoEmpresa)) Then
        Exit;
  End;

  If not fExisteConfiguracao('PWCCTT', Banco) Then
    Exit;

  If not fCfgSis('PWCCTT', varBoolean, ACodigoEmpresa) Then
    Exit;

  If not fExisteConfiguracao('PWCNCT', Banco) Then
    Exit;

  If not fExisteConfiguracao('XMLCTE', Banco) Then
    Exit;

  LCaminhoXml := fCfgSis('XMLCTE', varString, ACodigoEmpresa);

  pLogImp('LCaminhoXml - CFG_XMLCTE - ' + LCaminhoXml);

  If fEmptyStr(LCaminhoXml) Then
    Exit;

  If not DirectoryExists(LCaminhoXml) Then
    Exit;

  Result := True;
end;

function fExistemRegistrosPendentesIntegracaoPainelCitel(AStatus, ACodigoEmpresa: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}): Boolean;
begin
  Result := (fCampoTabela('COUNT(*)',
                          'PCITEL INNER JOIN CADFIS ON AUTOINCREM = NFE_SEQFIS',
                          ['NFE_STATUS', 'NFE_CODEMP'], [IIF(fEmptyStr(AStatus), 'GE', AStatus), ACodigoEmpresa], Banco) > 0);
end;

function fRetornaCaminhoLimparDiretorioDanfe: String;
begin
 {$IFDEF LINUX}
  Result := ExtractFilePath(Application.ExeName);
 {$ELSE}
  If FileExists(ARQUIVO_NFE_PRINTER_LOCAL) Then
    Result := PATH_NFE_PRINTER_LOCAL
  Else
    Result := ExtractFilePath(Application.ExeName);
 {$ENDIF}

  Result := fSepDir(Trim(Result));
  Result := fSepDir(Result + 'DANFE');
end;

function fDirectoryIsEmpty(Directory: String): Boolean;
Var
  SR: TSearchRec;
begin
  Result := True;

  If (Not fEmptyStr(Directory)) Then
  Begin
    Directory := IncludeTrailingPathDelimiter(Directory);

    If (DirectoryExists(Directory)) Then
    Begin
      Try
        Result := (FindFirst(Directory + '*.*', faAnyFile - faDirectory, SR) <> 0);
      Finally
        FindClose(SR);
      End;
    End;
  End;
end;

procedure SetLogDanfe;
begin
  If Assigned(objLogDanfe) Then
  Begin
    objLogDanfe.objConexao := frmModulo.Database;
    objLogDanfe.strNumDoc := '...';
    objLogDanfe.strEspDoc := '...';
    objLogDanfe.strCodEmp := VS_strCodEmp;
    objLogDanfe.strSerie_ := '...';
    objLogDanfe.strCodCli := '...';
  End;
end;

function fGetStrIndicadoraLockPainelAberto(const strCodEmp, strDB_: String): String;
begin
  Result := 'PAINEL_NFE_' + strCodEmp;
  If fPermiteMultiplosGetLock(strCodEmp) Then
    Result := 'PAINEL_NFE_' + strDB_ + '_' + strCodEmp;
end;

function fPermiteMultiplosGetLock(const strCodEmp: String): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    strLck: String;

  procedure pGetLock(const strSQL: String);
  begin
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT GET_LOCK("'+strSQL+'", 2)';
    qryAux.Open;
  end;

  procedure pReleaseLock(const strSQL: String);
  begin
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT RELEASE_LOCK("'+strSQL+'")';
    qryAux.Open;
  end;

begin
  If (VS_VersaoMySQLPermiteMultiplosGetLock <> '') Then
  Begin
    Result := (VS_VersaoMySQLPermiteMultiplosGetLock = 'S');
  End
  Else
  Begin
    VS_VersaoMySQLPermiteMultiplosGetLock := 'S';

    qryAux := fCriaQuery(Nil);
    Try
      Try
        Randomize;
        strLck := FormatDateTime('hhmmsszzz', Time) + strCodEmp;

        pGetLock('A' + strLck);
        pGetLock('B' + strLck);

        qryAux.Close;
        qryAux.SQL.Text := 'SELECT IS_USED_LOCK("' + 'A' + strLck + '")';
        qryAux.Open;

        If (Trim(qryAux.Fields[0].AsString) = '') Then
        Begin
          //SE "A + strLck" NÃO EXISTE MAIS ENTÃO...
          VS_VersaoMySQLPermiteMultiplosGetLock := 'N';
        End;

        pReleaseLock('A' + strLck);
        pReleaseLock('B' + strLck);
      Except
        //
      End;
    Finally
      Result := (VS_VersaoMySQLPermiteMultiplosGetLock = 'S');

      FreeAndNil(qryAux);
    End;
  End;
end;

function fGetConIDAtivo(const strConID_: String): Boolean;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := True;
  qryAux := fCriaQuery(Nil);
  Try
    Try
      qryAux.Close;
      qryAux.SQL.Text := 'SHOW PROCESSLIST';
      qryAux.Open;

      If Assigned(qryAux.FindField('Id')) And Assigned(qryAux.FindField('Time')) Then
      Begin
        qryAux.First;
        If qryAux.Locate('Id', strConID_, []) Then
          Result := qryAux.FieldByName('Time').AsInteger <= 10;
      End;
    Except
      //
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fGetConIDPainelAberto(const strCodEmp: String): String;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Text := 'SELECT IS_USED_LOCK("' + fGetStrIndicadoraLockPainelAberto(strCodEmp, qryAux.Connection.Database) + '")';
    qryAux.Open;
    Result := qryAux.Fields[0].AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fRetornaInformacoesLogAce(const strConID_, strCodEmp, strNomExe: String; blnIdent: Boolean = True): String;
  Var
    qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  If fCampoExiste('LOGACE','LOG_NUM_IP') And
     fCampoExiste('LOGACE','LOG_NOMMAQ') And
     fCampoExiste('LOGACE','LOG_NOMUSU') And
     fCampoExiste('LOGACE','LOG_PATEXE') And
     fCampoExiste('LOGACE','LOG_DTAENT') And
     fCampoExiste('LOGACE','LOG_CON_ID') And
     fCampoExiste('LOGACE','LOG_NOMEXE') And
     fCampoExiste('LOGACE','LOG_NOMEXE') Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Text :=
         ' SELECT LOG_NUM_IP, '+
         '        LOG_NOMMAQ, '+
         '        LOG_NOMUSU, '+
         '        LOG_PATEXE  '+
         '   FROM LOGACE      '+
         '   WHERE LOG_DTAENT = CURRENT_DATE '+
         '     AND LOG_CON_ID = :CON_ID'+
         '     AND LOG_CODEMP = :CODEMP'+
         '     AND LOG_NOMEXE = :NOMEXE';
      qryAux.ParamByName('CON_ID').AsString := strConID_;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('NOMEXE').AsString := strNomExe;
      qryAux.Open;

      If (Not qryAux.IsEmpty) Then
      Begin
        If blnIdent Then
        Begin
          Result := 'CON_ID..: ' + strConID_+#13+
                    'IP......: ' + qryAux.FieldByName('LOG_NUM_IP').AsString+#13+
                    'MAQUINA.: ' + qryAux.FieldByName('LOG_NOMMAQ').AsString+#13+
                    'USUÁRIO.: ' + qryAux.FieldByName('LOG_NOMUSU').AsString+#13+
                    'LOCAL...: ' + qryAux.FieldByName('LOG_PATEXE').AsString;
        End
        Else
        Begin
          Result := 'CON_ID: '  + strConID_+#13+
                    'IP: '      + qryAux.FieldByName('LOG_NUM_IP').AsString+#13+
                    'MAQUINA: ' + qryAux.FieldByName('LOG_NOMMAQ').AsString+#13+
                    'USUÁRIO: ' + qryAux.FieldByName('LOG_NOMUSU').AsString+#13+
                    'LOCAL: '   + qryAux.FieldByName('LOG_PATEXE').AsString;
        End;
      End;
      qryAux.Close
    Finally
      FreeAndNil(qryAux);
    End;
  End
  Else If fCampoExiste('NFE_LOCAL','NFE_CODEMP') And
          fCampoExiste('NFE_LOCAL','NFE_HORULT') And
          fCampoExiste('NFE_LOCAL','NFE_PATPNL') Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Text :=
         ' SELECT NFE_PATPNL '+
         '   FROM NFE_LOCAL      '+
         '   WHERE DATE(NFE_HORULT) = CURRENT_DATE '+
         '     AND NFE_CODEMP = :CODEMP';
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.Open;

      If (Not qryAux.IsEmpty) Then
      Begin
        If blnIdent Then
        Begin
          Result := 'CON_ID..: ' + strConID_+#13+
                    'LOCAL...: ' + qryAux.FieldByName('NFE_PATPNL').AsString;
        End
        Else
        Begin
          Result := 'CON_ID: '  + strConID_+#13+
                    'LOCAL: '   + qryAux.FieldByName('NFE_PATPNL').AsString;
        End;
      End;
      qryAux.Close
    Finally
      FreeAndNil(qryAux);
    End;
  End
  Else
  Begin
    If blnIdent Then
      Result := 'CON_ID..: ' + strConID_
    Else
      Result := 'CON_ID: '   + strConID_;
  End;
end;

function fPainelEstaAberto(const strCodEmp: String): Boolean;
begin
  Result := Not fEmptyStr(fGetConIDPainelAberto(strCodEmp));
end;

function fEmpresaNesteServidor(const strCodEmp: String; blnMostraMensagem: Boolean=True): Boolean;
begin
  Result := True;

  If Assigned(frmModulo) Then
  Begin
    If (frmModulo.Database.Connected) Then
    Begin
      If (fCampoExiste('EMPRESAS_NESTE_SERVIDOR', 'SRV_CODEMP', frmModulo.Database)) Then
      Begin
        If (fCampoTabela('SRV_CODEMP', 'EMPRESAS_NESTE_SERVIDOR', ['SRV_CODEMP'], [strCodEmp], frmModulo.Database) <> strCodEmp) Then
        Begin
          If blnMostraMensagem Then
            Application.MessageBox(PChar('Empresa '+strCodEmp+' não está registrada na tabela EMPRESAS_NESTE_SERVIDOR'+#13+'Entre em contato com a Citel!'), 'Atenção', MB_OK+MB_ICONWARNING);

          Result := False;
        End;
      End;
    End;
  End;
end;

function fPodeAbrirPainel(const strCodEmp: String): Boolean;
  Var
    strConID_,
    strValMpa: String;
begin
  VS_strCodPnlDir := strCodEmp;

  Result := fEmpresaNesteServidor(strCodEmp);

  If (Result) And (VS_ExecutarApenasTarefasPainelWebCitel <> 'S') And fPainelEstaAberto(strCodEmp) Then
  Begin
    strConID_ := fGetConIDPainelAberto(strCodEmp);

    If (Not fGetConIDAtivo(strConID_)) Then
      Exit;

    pRetornaParamSeExistir(consTagParamsMpa, strValMpa);

    If (Not FileExists(fPnlDir(strConID_ + '.CONEXAO'))) Then
    Begin
      If (Application.MessageBox(PChar('O PainelNFe ('+strCodEmp+') já está aberto em outro computador e/ou diretório!'+#13+
                                       'Para abrir um novo PainelNFe ('+strCodEmp+'), a instância abaixo deve ser fechada:'+#13#13+
                                       fRetornaInformacoesLogAce(strConID_, strCodEmp, ExtractFileName(ParamStr(0)), False)+#13#13+
                                       'Deseja abrir mesmo assim? (Isso pode causar instabilidade nas autorizações, como por exemplo, '+
                                       'imprimir duas vezes uma NFe, após sua autorização!)'), 'Atenção', MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=MRNO) Then
      Begin
        Result := False;
      End;
    End
    Else If (Pos(AnsiUpperCase(strValMpa), 'NAO_NÃO_') = 0) And
            (Application.MessageBox(PChar('O PainelNFe ('+strCodEmp+'), já está aberto neste computador!'+#13+
                                           'Deseja abrir um novo PainelNFe ('+strCodEmp+')? (A outra instância será fechada)'), 'Atenção', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)=MRNO) Then
    Begin
      Result := False;
    End;
  End;
end;

function fGetPalavrasBusca(edt: TEdit): TStringList;
  Var
    strPalavras: String;
begin
  Result := TStringList.Create;

  strPalavras := Trim(edt.Text);

  While Pos('  ', strPalavras) > 0 Do
    strPalavras := AnsiReplaceStr(strPalavras, '  ', ' ');

  Result.Text := AnsiReplaceStr(strPalavras, ' ', #13#10);
end;

function fSegundosToInterval(fltSegundos: Double): Integer;
begin
  Result := Trunc(fltSegundos*1000);
end;

function fMinutosToInterval(fltMinutos: Double): Integer;
begin
  Result := Trunc(fSegundosToInterval(fltMinutos*60));
end;

function fHoraToInterval(fltHora: Double): Integer;
begin
  Result := Trunc(fMinutosToInterval(fltHora*60));
end;

function fEstaNoPainelNFe: Boolean;
begin
  Result := (AnsiUpperCase(ExtractFileName(ParamStr(0))) = AnsiUpperCase('PainelNFe.exe'));
end;

function fGetPastasPainel(const strFiltroPasta: String='PainelNFE'): Integer;
begin
  Result := CountFiles(GetParentFolder(Application.ExeName, 2), ['PainelNFe.exe', 'NFeStatus.exe', 'libNfe.dll'], '*'+strFiltroPasta+'*', True);
  If (Result > 1) Then
  Begin
    If CountFiles(GetParentFolder(Application.ExeName, 2), ['apagar.txt'], '*PainelNFE*', True) > 0 Then
      Result := 1;
  End;
end;

function fEstaNoPainelNFeGeral: Boolean;
begin
  Result := (Pos(AnsiUpperCase('PainelNFeGeral'), AnsiUpperCase(ExtractFilePath(Application.ExeName))) > 0);
end;

function fCfgAtiva(aValCfg: String): Boolean;
begin
  Result := False;
  aValCfg := Trim(aValCfg);
  If (Length(aValCfg) >= 1) Then
    Result := aValCfg[1] = 'S';
end;

procedure pGravaLogErr(const strDescri, strValRel: WideString; blnVerificarSeJaGravouHoje: Boolean=False);
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaDtaSis : TDateTime;
    dtaHraSis : TDateTime;
begin
  qryGen := fCriaQuery;
  Try
    pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);

    If (blnVerificarSeJaGravouHoje) Then
    Begin
      qryGen.Close;
      qryGen.SQL.Text := 'SELECT COUNT(*) FROM LOGERR WHERE LOG_DESCRI = "'+strDescri+'" AND LOG_DTAERR = CURRENT_DATE AND LOG_CODEMP = "'+VS_strCodEmp+'"';
      qryGen.Open;
      If (Not qryGen.IsEmpty) Then
        If (qryGen.Fields[0].AsInteger > 0) Then
          Exit;
    End;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO LOGERR           ');
    qryGen.SQL.Add('   SET LOG_CODEMP = :CODEMP, ');
    qryGen.SQL.Add('       LOG_LOGOPE =  NULL,   ');
    qryGen.SQL.Add('       LOG_DTAERR = :DTAERR, ');
    qryGen.SQL.Add('       LOG_HORERR = :HORERR, ');
    qryGen.SQL.Add('       LOG_DESCRI = :DESCRI, ');
    qryGen.SQL.Add('       LOG_RELERR = :RELERR; ');

    qryGen.ParamByName('CODEMP').Value      := VS_strCodEmp;
    qryGen.ParamByName('DTAERR').AsDateTime := dtaDtaSis;
    qryGen.ParamByName('HORERR').AsDateTime := dtaHraSis;
    qryGen.ParamByName('DESCRI').Value      := strDescri;
    qryGen.ParamByName('RELERR').Value      := strValRel;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

initialization
  VS_VersaoMySQLPermiteMultiplosGetLock  := '';
  VS_ExecutarApenasTarefasPainelWebCitel := '';
  VS_MacAddress         := GetMacAddress;
  VS_IPAddressAsString  := GetIPAddressAsString;
  VS_UserFromWindows    := GetUserFromWindows;
  VS_ComputerNetName    := GetComputerNetName;
  VS_SomenteImpressao   := False;
  VS_ImpressoraSat      := '';
  VS_PCitelCorrigeErros := True;
  VS_PCitelGravaDocJson := False;
  VS_LimpaTodasTravas   := Nil;
  VS_stlTabNre          := Nil;

  VS_GravaUsuRep  := '';
  VS_LogRepConId  := '';
  VS_LogRepCodOp  := '';
  VS_ConnectionID := '';
  VS_FindProcesOK := '';

finalization
  If Assigned(VS_stlTabNre) Then
    FreeAndNil(VS_stlTabNre);

end.
