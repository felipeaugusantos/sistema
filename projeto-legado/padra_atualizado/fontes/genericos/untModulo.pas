unit untModulo;

interface

uses
  SysUtils, Classes, DB, Uni, StrUtils, Forms, madExceptVcl, madExcept, MemDS,
  DBAccess, MySQLUniProvider, UniProvider, Dialogs, ODBCUniProvider,
  DBFUniProvider, frxClass, Winapi.Windows, untTypesSistema;

type
  TfrmModulo = class(TDataModule)
    Database: TUniConnection;
    qryCnfBol: TUniQuery;
    dtsCnfBol: TDataSource;
    qryCnfBolCNF_CODBCO: TStringField;
    qryCnfBolCNF_IDENTI: TStringField;
    qryCnfBolCNF_LINIMP: TIntegerField;
    qryCnfBolCNF_COLIMP: TIntegerField;
    qryCnfBolCNF_MARGEM: TIntegerField;
    qryCnfBolCNF_CHRANT: TStringField;
    qryCnfBolCNF_DESCAM: TStringField;
    qryCnfBolCNF_CHRDEP: TStringField;
    qryCnfEti: TUniQuery;
    dtsCnfEti: TDataSource;
    qryCnfEtiCNF_TIPETI: TStringField;
    qryCnfEtiCNF_IDENTI: TStringField;
    qryCnfEtiCNF_LINIMP: TIntegerField;
    qryCnfEtiCNF_COL001: TIntegerField;
    qryCnfEtiCNF_COL002: TIntegerField;
    qryCnfEtiCNF_COL003: TIntegerField;
    qryCnfEtiCNF_COL004: TIntegerField;
    qryCnfEtiCNF_COL005: TIntegerField;
    qryCnfEtiCNF_MARGEM: TIntegerField;
    qryCnfEtiCNF_QTDCOL: TIntegerField;
    qryCnfEtiCNF_CHRANT: TStringField;
    qryCnfEtiCNF_CHRDEP: TStringField;
    qryCadGpo: TUniQuery;
    qryOpeGpo: TUniQuery;
    tblGruOpe: TUniTable;
    qryDirGpo: TUniQuery;
    dtsCadGpo: TDataSource;
    dtsOpeGpo: TDataSource;
    dtsGruOpe: TDataSource;
    qryCadGpoGPO_CODGPO: TIntegerField;
    qryCadGpoGPO_DESCRI: TStringField;
    qryCadGpoGPO_DTACAD: TDateField;
    qryOpeGpoOPE_CODOPE: TStringField;
    qryOpeGpoGPO_CODGPO: TIntegerField;
    qryDirGpoDIR_NOMFRM: TStringField;
    qryDirGpoGPO_CODGPO: TIntegerField;
    qryDirGpoDIR_ACAOUS: TStringField;
    qryDirBan: TUniQuery;
    dtsDirBan: TDataSource;
    qryCnf_Nf: TUniQuery;
    dtsCnf_Nf: TDataSource;
    qryCnf_NfCNF_CODSEQ: TIntegerField;
    qryCnf_NfCNF_LINTOP: TIntegerField;
    qryCnf_NfCNF_MARGEM: TIntegerField;
    qryCnf_NfCNF_TIPNOT: TStringField;
    qryCnf_NfCNF_IDENTI: TStringField;
    qryCnf_NfCNF_LINTIP: TStringField;
    qryCnf_NfCNF_DESDOB: TStringField;
    qryCnf_NfCNF_LINIMP: TIntegerField;
    qryCnf_NfCNF_COLIMP: TIntegerField;
    qryCnf_NfCNF_CHRANT: TStringField;
    qryCnf_NfCNF_CHRDEP: TStringField;
    tblGruOpeOPE_CODOPE: TStringField;
    tblGruOpeGPO_CODGPO: TIntegerField;
    qryDirTin: TUniQuery;
    dtsDirTin: TDataSource;
    qryLogErr: TUniQuery;
    dtsLogErr: TDataSource;
    qryProCod: TUniQuery;
    qryProCodPRO_NOMARQ: TStringField;
    qryProCodPRO_CODSEQ: TStringField;
    qryProCodPRO_TAMCOD: TIntegerField;
    qryProCodPRO_CODAUT: TStringField;
    dtsProCod: TDataSource;
    qryProCodPRO_CODEMP: TStringField;
    qryCadGpoGPO_CODEMP: TStringField;
    qryProCodAUTOINCREM: TStringField;
    qryCnfBolAUTOINCREM: TIntegerField;
    qryCnfEtiAUTOINCREM: TIntegerField;
    qryCadGpoAUTOINCREM: TStringField;
    qryCnfEtiCNF_DESCAM: TStringField;
    qryCnfEtiCNF_LINTOP: TIntegerField;
    qryCnf_NfCNF_LITOPO: TIntegerField;
    qryCnf_NfCNF_CODEMP: TStringField;
    qryCnfBolCNF_CODEMP: TStringField;
    qryCnfEtiCNF_CODEMP: TStringField;
    qryCnf_NfCNF_DESCAM: TStringField;
    cdsGruOpeOPE_DESCRI: TStringField;
    MadException: TMadExceptionHandler;
    DataDBF: TUniConnection;
    qryProCodPRO_SEQEMP: TStringField;

    procedure DataModuleCreate(Sender: TObject);
    procedure tblGruOpeCalcFields(DataSet: TDataSet);
    procedure MadExceptionException(const exceptIntf: IMEException;
      var handled: Boolean);
    procedure qryDirTinAfterPost(DataSet: TDataSet);
    procedure qryDirTinBeforeDelete(DataSet: TDataSet);
    procedure qryDirBanAfterPost(DataSet: TDataSet);
    procedure qryDirBanBeforeDelete(DataSet: TDataSet);
    procedure DatabaseError(Sender: TObject; E: EDAError; var Fail: Boolean);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DatabaseAfterConnect(Sender: TObject);
  private
    { Private declarations }
    function fErroDeConexaoRede(const AstrMensagemErro: String): Boolean;
    function fErroDeConexaoComBancoDeDados(const AstrMensagemErro: String): Boolean;
    function fErroDeConexaoComBancoSocketError(const AstrMensagemErro: String): Boolean;
    function fErroDeConexaoComBancoDeDadosPagueFacil(const AstrMensagemErro: String): Boolean;
    function fColetarErroSQL(const AErrorCode : Integer) : Boolean;
    procedure pGravarErroSQL(const AMessage, ASQL : String);
    function fParseSQLQuery(const ADataSet : TCustomDADataSet): String;
    function fDeveGravarErroSQL(const ASQL : String): Boolean;
  public
    MadExceptionDll : TMadExceptionHandler;
    VersionTitle: String;
  public
    constructor Create(Owner: TComponent); Override;
    constructor CreateInstance(Owner: TComponent; blnConectar: Boolean);
  public
    procedure pAddLogDir(strTabela, strNomFrm, strOpeDir, strACAOUS, strOpeSenLib: String;
      intCodGpo: Integer; strOpeLib: String = '');
    procedure pCriaEAtribuiMadException;
    procedure pLiberaMadException;
  public
    function GetCurrentConnection: TUniConnection; overload;
    function GetCurrentConnection(AThreadId: Cardinal): TUniConnection; overload;
    class function GetMySqlStatementsHistory: string; overload;
    class function GetMySqlStatementsHistory(AConn: TUniConnection): string; overload;
    class function fGravarRelErro(strMensagemErro, strRelatorio, strUltSQL: String; conexao: TUniConnection = nil): Integer;
  end;

  TCriarConexao = class
  Private
    FConexao: TUniConnection;
  public
    constructor Create(AInfo: string = ''; blnConexaoIndependente: Boolean = True);
    destructor Destroy; override;
    property objConexao: TUniConnection Read FConexao;
  end;

  TModuloEvents = class
    class procedure AfterConnect(Sender: TObject);
  End;

  TDiretivasDaConexao = class
    class procedure DefineSqlMode(const ADatabase: TUniConnection);
    class procedure DefineIsolationLevel(const ADatabase: TUniConnection);
  End;

var
  frmModulo: TfrmModulo;
  ProcReconectarModulo: TProcReconectarModulo;
  ProcReconectarModuloDiscreta: TProcReconectarModuloDiscreta;
  ProcMensagemErroRede: TProcMensagemErroRede;

implementation

uses untListaLogErros, untfuncoesSimples, untThreadUtils, untHorarioSistema,
  Variants, untConstantes;

var
  FMainThreadID: Cardinal;

{$R *.dfm}

function GetProcessHandleCount(hProcess: THandle; var pdwHandleCount: DWORD): BOOL; stdcall; external 'Kernel32.dll' name 'GetProcessHandleCount';

function GetOpenHandles: DWORD;
begin
 if not GetProcessHandleCount(GetCurrentProcess,Result) then
     RaiseLastOSError;
end;

{ TCriarConexao }

constructor TCriarConexao.Create(AInfo: string; blnConexaoIndependente: Boolean);
begin
  if AInfo.IsEmpty then
    AInfo := 'Undefined';
  if blnConexaoIndependente then
    FConexao := TSafeThread.Connections.GetLocalConnection(AInfo)
  else
    FConexao := frmModulo.Database;
end;

destructor TCriarConexao.Destroy;
begin
  TSafeThread.Connections.RemoveLocalConnection(FConexao);
  inherited Destroy;
end;

constructor TfrmModulo.Create(Owner: TComponent);
begin
  CreateInstance(Owner, True);
end;

constructor TfrmModulo.CreateInstance(Owner: TComponent; blnConectar: Boolean);
begin
  inherited Create(Owner);
  If blnConectar Then
  Begin
    pAbrirBanco(Database);

    Sleep(100);
    Application.ProcessMessages;

    If FindResource(HInstance, 'EXCEPT', 'MAD') <> 0 Then
      Exit;

    TThreadFinalizarAutcomMonitor.Monitorar;
    pMensagemOk('Não foi encontrado o módulo MadExcept no sistema!' + #13 +
                'Ligue imediatamente para a Citel.');
    Application.Terminate;
  End;
end;

procedure TfrmModulo.DatabaseAfterConnect(Sender: TObject);
begin
  TModuloEvents.AfterConnect(Sender);
end;

procedure TfrmModulo.DatabaseError(Sender: TObject; E: EDAError;
  var Fail: Boolean);
  Var
    objDataSet : TCustomDADataSet;
    strSQL : String;
begin
  If (Not fColetarErroSQL(E.ErrorCode)) Then
    Exit;
  If (E.Component Is TCustomDADataSet) Then
  Begin
    objDataSet := TCustomDADataSet(E.Component);
    strSQL := fParseSQLQuery(objDataSet);
    pGravarErroSQL(E.Message, strSQL);
  End;
end;

procedure TfrmModulo.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  qryProCod.Connection := Database;
  qryLogErr.Connection := Database;
  qryCnfBol.Connection := Database;
  qryCnfEti.Connection := Database;
  qryCnf_Nf.Connection := Database;
  qryCadGpo.Connection := Database;
  qryOpeGpo.Connection := Database;
  tblGruOpe.Connection := Database;
  qryDirGpo.Connection := Database;
  qryDirTin.Connection := Database;
  qryDirBan.Connection := Database;

  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;
end;

procedure TfrmModulo.DataModuleDestroy(Sender: TObject);
begin
  If fConexaoAtiva Then
    pDestravarTodosLocksConexaoAtual;
end;

function TfrmModulo.fErroDeConexaoRede(const AstrMensagemErro: String): Boolean;
begin
  Result := (Pos('External exception C0000006'.ToLower, AstrMensagemErro.ToLower) > 0);
end;

function TfrmModulo.fErroDeConexaoComBancoDeDados(const AstrMensagemErro: String): Boolean;
begin
  Result := (Pos('lost connection'  , LowerCase(AstrMensagemErro)) > 0) Or
            (Pos('assertion failure', LowerCase(AstrMensagemErro)) > 0) Or
            (Pos('socket error code', LowerCase(AstrMensagemErro)) > 0);
end;

function TfrmModulo.fErroDeConexaoComBancoSocketError(const AstrMensagemErro: String): Boolean;
begin
  Result := (Pos('socket error code', LowerCase(AstrMensagemErro)) > 0);
end;

function TfrmModulo.fErroDeConexaoComBancoDeDadosPagueFacil(const AstrMensagemErro: String): Boolean;
begin
  Result := VS_AutoatendimentoPagueFacil And fErroDeConexaoComBancoDeDados(AstrMensagemErro);
end;

{*************************************************}
{*   GRAVA MENSAGENS DE ERRO NO ARQUIVO DE LOG   *}
{**********************************************AF*}
class function TfrmModulo.fGravarRelErro(strMensagemErro, strRelatorio, strUltSQL: String; conexao: TUniConnection = nil): Integer;
  Var
    qryLogErr: TUniQuery;
    intLogErr: Integer;
    strMoreInfo: String;
begin
  If (Pos('Unknown.', strRelatorio) > 0) And (Not VS_strError.IsEmpty) Then
  Begin
    strMoreInfo  := '';

    If Not VS_strMensagemErro.IsEmpty Then
    Begin
      strMoreInfo := strMoreInfo + #13#10;
      strMoreInfo := strMoreInfo + '--------------------------------------------------------------------------' + #13#10;
      strMoreInfo := strMoreInfo + #13#10;
      strMoreInfo := strMoreInfo + VS_strMensagemErro + #13#10;
      strMoreInfo := strMoreInfo + #13#10;
      strMoreInfo := strMoreInfo + '--------------------------------------------------------------------------' + #13#10;
    End;

    strRelatorio := strRelatorio.Replace('Unknown.' + #13#10, VS_strError + #13#10 + strMoreInfo);
    strRelatorio := strRelatorio.Replace('Unknown', 'Exception ' + VS_strLocalErro);
  End;

  intLogErr := 0;

  Try
    qryLogErr := fCriaQuery(nil, conexao);
    qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

    With qryLogErr Do
    Begin
      Open;
      Insert;
      FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
      FieldByName('LOG_HORERR').AsDateTime := fTime(True);
      FieldByName('LOG_DESCRI').AsString   := strMensagemErro;
      FieldByName('LOG_RELERR').AsString   := strRelatorio;
      if FindField('LOG_ULTSQL') <> nil then
        FindField('LOG_ULTSQL').AsString := strUltSQL;
      Post;
      intLogErr := FieldByName('AUTOINCREM').AsInteger;
      Close;
    End;

  Finally
    Result := intLogErr;
    FreeAndNil(qryLogErr);
  End;

end;

function TfrmModulo.GetCurrentConnection: TUniConnection;
begin
  If GetCurrentThreadId = FMainThreadID Then
    Result := Self.Database
  Else If TSafeThread.Connections.HasThreadConnection(GetCurrentThreadId) Then
    Result := TSafeThread.Connections.GetThreadConnection(GetCurrentThreadId, 'TfrmModulo.GetCurrentConnection')
  Else
    Result := Self.Database;
end;

function TfrmModulo.GetCurrentConnection(AThreadId: Cardinal): TUniConnection;
begin
  If AThreadId = 0 Then
    Result := Self.Database
  Else If AThreadId = FMainThreadID Then
    Result := Self.Database
  Else If TSafeThread.Connections.HasThreadConnection(AThreadId) Then
    Result := TSafeThread.Connections.GetThreadConnection(AThreadId, 'TfrmModulo.GetCurrentConnection')
  Else
    Result := Self.GetCurrentConnection;
end;

class function TfrmModulo.GetMySqlStatementsHistory: string;
begin
  Result := TSafeThread.Connections.GetAllMySqlStatementsHistory;
end;

class function TfrmModulo.GetMySqlStatementsHistory(AConn: TUniConnection): string;
const
  sLineSeparator = '--------------------------------------------------------------------------------';
var
  LQuery: TUniQuery;
begin
  If Not Assigned(AConn) Then Exit(EmptyStr);

  LQuery := TUniQuery.Create(nil);
  try
    LQuery.Connection := AConn;
    try
      LQuery.SQL.Add(' SELECT ');
      LQuery.SQL.Add('   GROUP_CONCAT( ');
      LQuery.SQL.Add('     "CONNECTION_ID.....: ", ');
      LQuery.SQL.Add('     IFNULL(t.PROCESSLIST_ID, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "THREAD_ID.........: ", ');
      LQuery.SQL.Add('     IFNULL(t.THREAD_ID, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "EVENT_NAME........: ", ');
      LQuery.SQL.Add('     IFNULL(event_name, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "OBJECT_NAME.......: ", ');
      LQuery.SQL.Add('     IFNULL(object_name, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "NESTING_EVENT_TYPE: ", ');
      LQuery.SQL.Add('     IFNULL(nesting_event_type, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "SQL_TEXT..........:\n\n", ');
      LQuery.SQL.Add('     IFNULL(SQL_TEXT, ""), ');
      LQuery.SQL.Add('     "\n" ');
      LQuery.SQL.Add('     ORDER BY EVENT_ID DESC SEPARATOR "' + sLineSeparator + '\n" ');
      LQuery.SQL.Add('   ) ');
      LQuery.SQL.Add(' FROM ');
      LQuery.SQL.Add('   performance_schema.events_statements_history h ');
      LQuery.SQL.Add('   inner join performance_schema.threads t ');
      LQuery.SQL.Add('     on h.THREAD_ID = t.THREAD_ID ');
      LQuery.SQL.Add(' WHERE CURRENT_SCHEMA = DATABASE() ');
      LQuery.SQL.Add('   AND t.PROCESSLIST_ID = CONNECTION_ID(); ');
      LQuery.Open;
      Result := LQuery.Fields[0].AsString;
    except
      on E: Exception do
      begin
        Result := E.Message;
      end;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TfrmModulo.MadExceptionException(const exceptIntf: IMEException; var handled: Boolean);
  Var
    blnDuplici: Boolean;
    blnForeignKey: Boolean;
    strInfoForeignKeyError: String;
    strNomeTabForeignKey: String;
    strRetInnoDB: String;
    strFormsAtivos: String;
    strBugReport : String;
    Conexao: TCriarConexao;
begin
  If (exceptIntf.ExceptClass = 'ESafeThreadHandledException') Then
  Begin
    Handled := True;
    exceptIntf.ShowPleaseWaitBox := False;
  End;

  If exceptIntf.ExceptMessage.Equals('Unknown.') Then
    If Not VS_strError.IsEmpty Then
      exceptIntf.ExceptMessage := VS_strError;

  If exceptIntf.ExceptMsg.Equals('Unknown.') Then
    If Not VS_strError.IsEmpty Then
      exceptIntf.ExceptMsg := VS_strError;

  //Quando chama pelo monitor de serviÃ§os do autcom,
  // nÃ£o estoura erro na tela, mas volta para o serivÃ§o o erro
  //atraves do fMensagem e grava o logerr normalmente;
  If (Not VS_ExibirMensagemDeErro) And (Assigned(VS_OnMensagemDeErro) Or (FindWindow('TfrmAutcomSvc', Nil) > 0)) Then
  Begin
    if not fErroDeConexaoComBancoDeDadosPagueFacil(exceptIntf.ExceptMessage)  then
    begin
      exceptIntf.ShowPleaseWaitBox := False;
      handled := True;
      VS_OnMensagemDeErro(exceptIntf.ExceptMessage);
    end ;
  End;

  If fErroDeConexaoComBancoDeDados(exceptIntf.ExceptMessage) Then
  Begin
    If exceptIntf.ExceptClass.Equals('ESafeThreadHandledException') then
    Begin
      //do nothing
    End
    Else If Assigned(ProcReconectarModuloDiscreta) And fErroDeConexaoComBancoSocketError(exceptIntf.ExceptMessage) Then
    Begin
      handled := True;
      exceptIntf.ShowPleaseWaitBox := False;
      strBugReport := exceptIntf.GetBugReport;
      pGravaLogErrArquivoLocal(exceptIntf.ExceptMessage, strBugReport, 'Reconexao');
      ProcReconectarModuloDiscreta(exceptIntf.ExceptMessage, strBugReport);
      Exit;
    End
    Else If Assigned(ProcReconectarModulo) Then
    Begin
      handled := True;
      exceptIntf.ShowPleaseWaitBox := False;
      pGravaLogErrArquivoLocal(exceptIntf.ExceptMessage, exceptIntf.GetBugReport, 'Reconexao');
      ProcReconectarModulo(exceptIntf.ExceptMessage);
      Exit;
    End;
  End;

  // Erro ocorre ao desenhar o botao de filtro de uma coluna no cxgrid (TcxGridColumnHeaderFilterButtonPainter.Paint),
  // - totalmente aleatorio
  // - sem condicoes de reproduzir
  // - nao afeta a usabilidade se ignorar
  If (exceptIntf.ExceptClass = 'EdxException') And
     (Pos('unsupported image format', LowerCase(exceptIntf.ExceptMessage)) > 0) Then
  Begin
    handled := True;
    Exit;
  End;

  {*********************************}
  {* CRIA CAMPO NO BUGREPORT       *}
  {******************************JB*}
  exceptIntf.BugReportHeader['VS_ProcessId']         := VS_ProcessId;
  exceptIntf.BugReportHeader['Version title']        := Self.VersionTitle;
  exceptIntf.BugReportHeader['executable path']      := ExtractFilePath(Application.ExeName);
  exceptIntf.BugReportHeader['Company logged']       := Concat(VS_strCodEmp, ' - ', fRetNomeEmpresa(VS_strCodEmp));
  exceptIntf.BugReportHeader['User logged']          := Concat(strLoginUsuarioLogado, ' - ', strDescriUsuarioLogado);
  exceptIntf.BugReportHeader['MySQL Server']         := Concat(frmModulo.GetCurrentConnection.Server, '/', frmModulo.GetCurrentConnection.Database);
  exceptIntf.BugReportHeader['MySQL connection id']  := fGetConnectionID;
  exceptIntf.BugReportHeader['Process handle count'] := GetOpenHandles.ToString;
  exceptIntf.BugReportHeader['GDI objects count']    := GetGuiResources(GetCurrentProcess, GR_GDIOBJECTS).ToString;
  exceptIntf.BugReportHeader['User objects count']   := GetGuiResources(GetCurrentProcess, GR_USEROBJECTS).ToString;

  If TListaErros.Erros.Habilitada Then
  Begin
    handled := True;
    TListaErros.Erros.pAdicionar(exceptIntf.ExceptMessage, exceptIntf.GetBugReport);
    Exit;
  End;

  If Pos('context-sensitive help', exceptIntf.ExceptMessage) > 0 Then
  Begin
    handled := True;
    Exit;
  End;

  If Pos('Operation aborted', exceptIntf.ExceptMessage) > 0 Then
  Begin
    handled := True;
    Exit;
  End;

  If Pos('Invalid input value. Use escape key to abandon changes.', exceptIntf.ExceptMessage) > 0 Then
  Begin
    handled := True;
    Exit;
  End;

  If Pos('is not a valid floating point value for field', exceptIntf.ExceptMessage) > 0 Then
  Begin
    handled := True;
    Exit;
  End;

  If (exceptIntf.ExceptClass = 'TBrush') And
     (Pos('TBrush.', exceptIntf.ExceptMessage) > 0) Then
  Begin
    handled := True;
    Exit;
  End;

  If (exceptIntf.ExceptClass = 'EInvalidOperation') And
     (Pos('Cannot change Visible in OnShow or OnHide.', exceptIntf.ExceptMessage) > 0) Then
  Begin
    handled := True;
    Exit;
  End;

  If Pos('CONNECTION TO MYSQL', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'A conexão estabelecida com o banco de dados foi perdida.' + #13#10 +
                            'O servidor parou de responder corretamente.' + #13#10 +
                            'Feche o Sistema AUTCOM e tente conectar novamente.' + #13#10 +
                            'Caso o problema persista, entre em contato com o responsável pelo servidor.';
  End;

  If Pos('CONNECT TO MYSQL', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Não é possível estabelecer conexão com o banco de dados no IP:' + Database.Server + '.' + #13#10 +
                            'O servidor parou de responder corretamente.' + #13#10 +
                            'Feche o Sistema AUTCOM e tente conectar novamente.' + #13#10 +
                            'Caso o problema persista, entre em contato com o responsável pelo servidor.';
  End;

  If Pos('TIMEOUT EXCEEDED', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'O tempo de transação excedeu o limite máximo permitido.' + #13#10 +
                            'Existe outro processo sendo executado que está bloqueando sua operação.' + #13#10 +
                            'Clique em "Continuar usando o Autcom" e tente novamente.' + #13#10 +
                            'Caso o problema persista, entre em contato com o responsável pelo Sistema AUTCOM.';
  End;

  If Pos('DANFE NÃO ENCONTRADA', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Esta nota fiscal não foi entcontrada para download.' + #13#10 +
                            'Verifique no PainelNFe se ela foi autorizada corretamente e tente reimprimir novamente.' + #13#10 +
                            'Caso o problema persista, entre em contato com o responsável pelo Sistema AUTCOM.';
  End;

  If Pos('I/O ERROR 21.', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Erro de leitura/escrita de arquivo/diretório, verifique se o mesmo existe e você tenha acesso a ele';
  End;

  If (Pos('dhcpcsvc',    exceptIntf.ExceptMessage) > 0) Or
     (Pos('rtutils.dll', exceptIntf.ExceptMessage) > 0) Or
     (Pos('netprofm',    exceptIntf.ExceptMessage) > 0) Or
     (Pos('mswsock' ,    exceptIntf.ExceptMessage) > 0) Or
     (Pos('fwpuclnt',    exceptIntf.ExceptMessage) > 0) Then
  Begin
    If (Pos('fEnviarNotaInterna',        exceptIntf.GetBugReport) > 0) Or
       (Pos('fEnviarCancelamentoLibNfe', exceptIntf.GetBugReport) > 0) Or
       (Pos('fAjustaDataSistema',        exceptIntf.GetBugReport) > 0) Or
       (Pos('fEnviarNFCeLibNfe',         exceptIntf.GetBugReport) > 0) Then
    Begin
      handled := True;
      pMensagemOk('O Windows® não está respondendo.' + #13#10 +
                  'Pressione ENTER para continuar e tente novamente.' + #13#10 +
                  'Caso o problema persista, entre em contato com o responsável pelo Sistema AUTCOM.');
      Exit;
    End
    Else
    Begin
      exceptIntf.ExceptMessage := 'O Windows® não está respondendo.' + #13#10 +
                                  'Clique em "Continuar usando o Autcom" e tente novamente.' + #13#10 +
                                  'Caso o problema persista, entre em contato com o responsável pelo Sistema AUTCOM.';
    End;
  End;

  If (Pos('rtl230.bpl', exceptIntf.ExceptMessage) > 0) Then
  Begin
    If (Pos('TfrxPreviewForm.PrintBClick', exceptIntf.GetBugReport) > 0) Then
    Begin
      handled := True;
      pMensagemOk('Ocorreu um erro ao preparar o documento para impressão.' + #13#10 +
                  'Pressione ENTER para continuar e tente novamente.' + #13#10 +
                  'Caso o problema persista, entre em contato com o responsável pelo Sistema AUTCOM.');
      Exit;
    End;
  End;

  If (Pos('dtsh.dll',     exceptIntf.ExceptMessage) > 0) Or
     (Pos('wbemprox.dll', exceptIntf.ExceptMessage) > 0) Then
  Begin
    If (Pos('TCustomFileDialog',  exceptIntf.GetBugReport) > 0) Then
    Begin
      handled := True;
      pMensagemOk('Não foi possível carregar o diretório informado.' + #13#10 +
                  'Pressione ENTER para continuar e tente novamente.' + #13#10 +
                  'Caso o problema persista, entre em contato com o responsável pelo Sistema AUTCOM.');
      Exit;
    End;
  End;

  If Assigned(untFuncoesSimples.VS_objTraceViewer) Then
    untFuncoesSimples.VS_objTraceViewer.Stop;

  If (Pos('duplicada', LowerCase(exceptIntf.ExceptMessage)) > 0) Or
     (Pos('duplicate', LowerCase(exceptIntf.ExceptMessage)) > 0) Then
    exceptIntf.ExceptMsg := 'Chave Duplicada na Tabela: ' + VS_strTabelaErro + ' - Mensagem de Erro: ' + exceptIntf.ExceptMessage;

  strNomeTabForeignKey   := '';
  strInfoForeignKeyError := '';
  strRetInnoDB := '';
  If (Pos('foreign key', LowerCase(exceptIntf.ExceptMessage)) > 0) or (Pos('chave estrangeira', LowerCase(exceptIntf.ExceptMessage)) > 0)Then
    strInfoForeignKeyError := fRetornaInformacaoUltimoErroForeignKey(strRetInnoDB);

  blnForeignKey := Not fEmptyStr(strInfoForeignKeyError);

  blnDuplici := False;
  If (Pos('duplicada', LowerCase(exceptIntf.ExceptMessage)) > 0) Or
     (Pos('duplicate', LowerCase(exceptIntf.ExceptMessage)) > 0) Then
  Begin
    blnDuplici := True;
  End;

  If blnForeignKey Then
  Begin
    strInfoForeignKeyError := '------------------------------------------------------------------------------------------------------' + #13#10 +
                              'Você tem uma inconsistência em seus dados. '                                                            + #13#10 +
                              'Altere para continuar ou entre em contato com a Citel.'                                                 + #13#10 +
                              '------------------------------------------------------------------------------------------------------' + #13#10 +
                              strInfoForeignKeyError                                                                                   + #13#10 +
                              'Mensagem de Erro: ' + exceptIntf.ExceptMessage                                                          + #13#10 +
                              '------------------------------------------------------------------------------------------------------';

    exceptIntf.ExceptMsg := strInfoForeignKeyError;
    strNomeTabForeignKey := Trim(Copy(strInfoForeignKeyError, Pos('Tabela de Gravação:', strInfoForeignKeyError),Pos('Foreign Key:', strInfoForeignKeyError) - Pos('Tabela de Gravação:', strInfoForeignKeyError)));
  End;

  If blnDuplici Then
    exceptIntf.BugReportHeader['Error type'] := 'Chave Duplicada na Tabela: ' + VS_strTabelaErro
  Else If blnForeignKey Then
    exceptIntf.BugReportHeader['Error type'] := 'Erro de Foreign Key - ' + strNomeTabForeignKey;

  If Pos('Printer selected is not valid.', exceptIntf.ExceptMessage) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Impressora não está na rede ou não foi conectada corretamente.';
  End;

  If Pos('There is no default printer currently selected', exceptIntf.ExceptMessage) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Não existe nenhuma impressora instalada ou não tem ' + #13 +
                            'nenhuma impressora selecionada como padrão.' + #13 +
                            'Favor verificar nas configurações de impressora no Windows.';
  End;

  If Pos('SQL Error: Got error 12 from storage engine.', exceptIntf.ExceptMessage) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Não foi possível alocar memória no servidor de banco de dados no IP:' + Database.Server + '.' + #13#10 +
                            'O servidor parou de responder corretamente.' + #13#10 +
                            'Feche o Sistema AUTCOM e tente conectar novamente.' + #13#10 +
                            'Caso o problema persista, entre em contato com o responsável pelo servidor.';
  End;

  strFormsAtivos := EmptyStr;
  If Pos('cannot change visible in onshow or onhide', LowerCase(exceptIntf.ExceptMessage)) > 0 Then
    strFormsAtivos := 'Forms ativos na operação: ' + fRetFormsAtivos + #13#10;

  {*******************************************}
  {* GRAVA LOG DE ERRO                       *}
  {****************************************AF*}
  Conexao := TCriarConexao.Create('TfrmModulo.MadExceptionException');
  try
    exceptIntf.CreateScreenShot := False;

    If (exceptIntf.ExceptClass = 'ESafeThreadHandledException') Then
    Begin
      fGravarRelErro(exceptIntf.ExceptMessage, exceptIntf.GetBugReport, ESafeThreadHandledException(exceptIntf.ExceptObject).MySqlStatementsHistory, Conexao.objConexao);
      Exit;
    End
    Else If blnDuplici Then
    Begin
      fGravarRelErro('Chave Duplicada na Tabela: ' + VS_strTabelaErro + ' - Mensagem de Erro: ' + exceptIntf.ExceptMessage, exceptIntf.GetBugReport, GetMySqlStatementsHistory, Conexao.objConexao);
    End
    Else If blnForeignKey Then
    Begin
      fGravarRelErro('Erro de Foreign Key - ' + strNomeTabForeignKey, strInfoForeignKeyError + #13#10 + exceptIntf.GetBugReport, GetMySqlStatementsHistory, Conexao.objConexao);
    End
    Else If Pos('deadlock', LowerCase(exceptIntf.ExceptMessage)) > 0 Then
    Begin
      fGravarRelErro(exceptIntf.ExceptMessage, fRetornaInformacaoUltimoDeadlock + #13#10 + fReplicatorStr('=',50) + #13#10 + exceptIntf.GetBugReport, GetMySqlStatementsHistory, Conexao.objConexao);
    End
    Else If (Pos('EOutOfResources'.ToLower, exceptIntf.ExceptMessage.ToLower) > 0) Or
            (Pos('Invalid operation in GDI+'.ToLower, exceptIntf.ExceptMessage.ToLower) > 0) Or
            (Pos('system is out of resources'.ToLower, exceptIntf.ExceptMessage.ToLower) > 0) Or
            (Pos('Espaço insuficiente de armazenamento para processar este comando'.ToLower, exceptIntf.ExceptMessage.ToLower) > 0) Or
            (Pos('Insufficient memory for this operation'.ToLower, exceptIntf.ExceptMessage.ToLower) > 0) Then
    Begin
      exceptIntf.ExceptMessage := exceptIntf.ExceptClass + #13#10 + #13#10 +
        '--------------------------------------------------------------------------------------------------------------------------------' + #13#10 +
        '                                      Insuficiência de Recursos do Sistema Operacional                                          ' + #13#10 +
        '--------------------------------------------------------------------------------------------------------------------------------' + #13#10 +
        'Neste momento, o Windows não está liberando recursos suficientes para utilização do AUTCOM na                                   ' + #13#10 +
        'sua estação de trabalho, comprometendo o funcionamento do Sistema.                                                              ' + #13#10 +
        'Feche o AUTCOM e os programas que estão abertos na sua estação de trabalho, e tente novamente.                                  ' + #13#10 +
        'Se o problema persistir, entre em contato com seu Departamento de TI.                                                           ' + #13#10 +
        '                                                                                                                                ' + #13#10 +
        fRetornaWordWrapText('Erro informado: ' + exceptIntf.ExceptMessage, 100)                                                           + #13#10 +
        '--------------------------------------------------------------------------------------------------------------------------------' + #13#10 ;
      fGravarRelErro(exceptIntf.ExceptClass + ': Insuficiência de Recursos do Sistema Operacional', exceptIntf.ExceptMessage + exceptIntf.GetBugReport, GetMySqlStatementsHistory, Conexao.objConexao);
    End
    Else
      fGravarRelErro(exceptIntf.ExceptMessage, strFormsAtivos + exceptIntf.GetBugReport, GetMySqlStatementsHistory, Conexao.objConexao);

    {*******************************************}
    {* SE FOR VIOLAÇÃO DE ACESSO O PROCESSO EH *}
    {* DIFERENTE                               *}
    {****************************************AF*}
    {Req.: 99135}
    exceptIntf.SendBtnVisible := False;

    If (exceptIntf.ExceptClass = 'EAccessViolation') Or
       (Pos('ACCESS VIOLATION', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0) Then
    Begin
      pDestravarTodosLocksConexaoAtual(False, Conexao.objConexao);

      exceptIntf.ContinueBtnVisible := False;
      exceptIntf.RestartBtnVisible  := False;
      exceptIntf.CloseBtnVisible    := True;

      If Assigned(Screen.ActiveForm) Then
        Screen.ActiveForm.Enabled := False;

      exceptIntf.Show;

      pFecharBanco(Database);
    End;

    If fErroDeConexaoRede(exceptIntf.ExceptMessage) Then
    Begin
      If Assigned(ProcMensagemErroRede) Then
      Begin
        handled := True;
        exceptIntf.ShowPleaseWaitBox := False;
        pGravaLogErrArquivoLocal(exceptIntf.ExceptMessage, exceptIntf.GetBugReport, 'ErroRede');
        ProcMensagemErroRede(exceptIntf.GetBugReport);
        Exit;
      End;
    End;

    If (exceptIntf.ExceptClass = 'EOSError') Then
    Begin
      pDestravarTodosLocksConexaoAtual(False, Conexao.objConexao);

      exceptIntf.ContinueBtnVisible := False;
      exceptIntf.RestartBtnVisible  := False;
      exceptIntf.CloseBtnVisible    := True;

      If Assigned(Screen.ActiveForm) Then
        Screen.ActiveForm.Enabled := False;

      exceptIntf.Show;

      pFecharBanco(Database);
    End;

    If (Pos('EOutOfResources'.ToLower, exceptIntf.ExceptMessage.ToLower) > 0) Then
    Begin
      pDestravarTodosLocksConexaoAtual(False, Conexao.objConexao);

      exceptIntf.ContinueBtnVisible := False;
      exceptIntf.RestartBtnVisible  := False;
      exceptIntf.CloseBtnVisible    := True;

      If Assigned(Screen.ActiveForm) Then
        Screen.ActiveForm.Enabled := False;

      exceptIntf.Show;

      pFecharBanco(Database);
    End;
  finally
    FreeAndNil(Conexao);
  end;

end;

procedure TfrmModulo.pCriaEAtribuiMadException;
begin
  MadExceptionDll := TMadExceptionHandler.Create(Self);
  MadExceptionDll.OnException := MadExceptionException;
end;

procedure TfrmModulo.pLiberaMadException;
begin
  If Assigned(MadExceptionDll) Then
    FreeAndNil(MadExceptionDll);
end;

procedure TfrmModulo.qryDirBanAfterPost(DataSet: TDataSet);
begin
  pAddLogDir('DIRBAN',
             DataSet.FieldByName('BAN_NOMFRM').AsString,
             DataSet.FieldByName('BAN_CODOPE').AsString,
             'IAE',
             'S',
             0);

end;

procedure TfrmModulo.qryDirBanBeforeDelete(DataSet: TDataSet);
begin
  pAddLogDir('DIRBAN',
             DataSet.FieldByName('BAN_NOMFRM').AsString,
             DataSet.FieldByName('BAN_CODOPE').AsString,
             'DEL',
             'S',
             0);
end;

procedure TfrmModulo.qryDirTinAfterPost(DataSet: TDataSet);
begin
  pAddLogDir('DIRTIN',
             DataSet.FieldByName('TIN_NOMFRM').AsString,
             DataSet.FieldByName('TIN_CODOPE').AsString,
             'IAE',
             'S',
             0);
end;

procedure TfrmModulo.qryDirTinBeforeDelete(DataSet: TDataSet);
begin
  pAddLogDir('DIRTIN',
             DataSet.FieldByName('TIN_NOMFRM').AsString,
             DataSet.FieldByName('TIN_CODOPE').AsString,
             'DEL',
             'S',
             0);
end;

procedure TfrmModulo.tblGruOpeCalcFields(DataSet: TDataSet);
begin
  With DataSet Do
    FieldByName('OPE_DESCRI').AsString := fRetNomeOperador(FieldByName('OPE_CODOPE').AsString);
end;

procedure TfrmModulo.pAddLogDir(strTabela, strNomFrm, strOpeDir, strACAOUS, strOpeSenLib: String; intCodGpo : Integer;
  strOpeLib: String = '');
Var
  LQuery: TUniQuery;
Begin
  LQuery := fCriarQuery('SELECT * FROM LOGDIR WHERE FALSE');
  LQuery.Open;

  LQuery.Insert;
  LQuery.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGDIR', VS_strCodEmp);
  LQuery.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
  LQuery.FieldByName('LOG_HORALT').AsDateTime := fRetHoraServidor;
  LQuery.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
  LQuery.FieldByName('LOG_TABELA').AsString   := strTabela;
  LQuery.FieldByName('LOG_NOMFRM').AsString   := strNomFrm;
  LQuery.FieldByName('LOG_OPEDIR').AsString   := strOpeDir;
  LQuery.FieldByName('LOG_CODGPO').AsInteger  := intCodGpo;
  LQuery.FieldByName('LOG_ACAOUS').AsString   := strACAOUS;
  LQuery.FieldByName('LOG_OSNLIB').AsString   := strOpeSenLib;

  If fEmptyStr(LQuery.FieldByName('LOG_OPEDIR').AsString) then
    LQuery.FieldByName('LOG_OPEDIR').Clear;

  If (SameText(strTabela, 'DIROPE')) And (LQuery.FieldByName('LOG_CODGPO').AsInteger <= 0) Then
    LQuery.FieldByName('LOG_CODGPO').Clear;

  If (SameText(strTabela, 'DIRTIN')) And (LQuery.FieldByName('LOG_CODGPO').AsInteger <= 0) Then
    LQuery.FieldByName('LOG_CODGPO').Clear;

  If (SameText(strTabela, 'DIRBAN')) And (LQuery.FieldByName('LOG_CODGPO').AsInteger <= 0) Then
    LQuery.FieldByName('LOG_CODGPO').Clear;

  If (SameText(strTabela, 'DIRBAN')) And (LQuery.FieldByName('LOG_CODGPO').AsInteger = -1) Then
    LQuery.FieldByName('LOG_CODGPO').Clear;

  If Not fEmptyStr(strOpeLib) then
    LQuery.FieldByName('LOG_OPELIB').AsString   := strOpeLib;

  LQuery.Post;

  FreeAndNil(LQuery);
End;

function TfrmModulo.fColetarErroSQL(const AErrorCode : Integer): Boolean;
  Const
    ER_BAD_FIELD_ERROR : Integer = 1054;
    ER_SYNTAX_ERROR : Integer = 1064;
begin
  Result := False;
  If (AErrorCode = ER_BAD_FIELD_ERROR) Then
    Exit(True);
  If (AErrorCode = ER_SYNTAX_ERROR) Then
    Exit(True);
end;

function TfrmModulo.fParseSQLQuery(const ADataSet : TCustomDADataSet): String;
  Var
    intCnt : Integer;
begin
  Try
    Result := ADataSet.FinalSQL;
    If fEmptyStr(Result) Then
      Result := ADataSet.SQL.Text;
  Except
    Result := ADataSet.SQL.Text;
  End;
  For intCnt := 0 To Pred(ADataSet.Params.Count) Do
  Begin
    If (ADataSet.Params[intCnt].IsNull) Then
      Result := ReplaceStr(Result, ':' + ADataSet.Params[intCnt].Name, 'NULL')
    Else
    Begin
      Case ADataSet.Params[intCnt].DataType Of
        ftDateTime:
          Result := ReplaceStr(Result, ':' + ADataSet.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', ADataSet.Params[intCnt].AsDateTime)));
        ftDate:
          Result := ReplaceStr(Result, ':' + ADataSet.Params[intCnt].Name, QuotedStr(FormatDateTime('yyyy-mm-dd', ADataSet.Params[intCnt].AsDate)));
        ftFloat:
          Result := ReplaceStr(Result, ':' + ADataSet.Params[intCnt].Name, QuotedStr(AnsiReplaceStr(FloatToStrF(ADataSet.Params[intCnt].AsFloat, ffFixed, 12, 2),',','.')));
        ftInteger:
          Result := ReplaceStr(Result, ':' + ADataSet.Params[intCnt].Name, ADataSet.Params[intCnt].AsString);
        Else
          Result := ReplaceStr(Result, ':' + ADataSet.Params[intCnt].Name, QuotedStr(ADataSet.Params[intCnt].AsString));
      End;
    End;
  End;
end;

procedure TfrmModulo.pGravarErroSQL(const AMessage, ASQL : String);
  Var
    qrySqlErr : TUniQuery;
begin
  If (ASQL.IsEmpty) Then
    Exit;
  If (Not fDeveGravarErroSQL(ASQL)) Then
    Exit;
  Try
    qrySqlErr := fCriaQuery;
    Try
      qrySqlErr.SQL.Text := 'SELECT * FROM SQLERR WHERE FALSE';
      qrySqlErr.Open;
      qrySqlErr.Insert;
      If (strLoginUsuarioLogado.IsEmpty) Then
        qrySqlErr.FieldByName('ERR_LOGOPE').Value := Null
      Else
        qrySqlErr.FieldByName('ERR_LOGOPE').AsString := strLoginUsuarioLogado;
      qrySqlErr.FieldByName('ERR_DTAERR').AsDateTime := VS_Date;
      qrySqlErr.FieldByName('ERR_HORERR').AsDateTime := fRetHoraServidor;
      If (VS_strCodEmp.IsEmpty) Then
        qrySqlErr.FieldByName('ERR_CODEMP').Value := Null
      Else
        qrySqlErr.FieldByName('ERR_CODEMP').AsString := VS_strCodEmp;
      qrySqlErr.FieldByName('ERR_CON_ID').AsString := fGetConnectionID;
      qrySqlErr.FieldByName('ERR_MESSAG').AsString := AMessage;
      qrySqlErr.FieldByName('ERR_SQLERR').AsString := ASQL;
      qrySqlErr.Post;
    Finally
      FreeAndNil(qrySqlErr);
    End;
  Except
    pGravaLogErrArquivoLocal(AMessage, ASQL, 'ErroSQL');
  End;
end;

function TfrmModulo.fDeveGravarErroSQL(const ASQL: String): Boolean;
  Var
    LSQL : String;
begin
  Result := True;
  LSQL := LeftStr(ASQL, 50);
  If LSQL.Contains('AS CAMPO_EXISTE FROM') Then
    Result := False;
end;

{ TModuloEvents }

class procedure TModuloEvents.AfterConnect(Sender: TObject);
begin
  If (Not Assigned(Sender)) Then
    Exit;
  If (Not (Sender Is TUniConnection)) Then
    Exit;
  DefinirTimeZoneEmSessaoMySql(TUniConnection(Sender), VS_strCodEmp);
  TDiretivasDaConexao.DefineSqlMode(TUniConnection(Sender));
  TDiretivasDaConexao.DefineIsolationLevel(TUniConnection(Sender));
end;

{ TDiretivasDaConexao }

class procedure TDiretivasDaConexao.DefineSqlMode(const ADatabase: TUniConnection);
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery(Nil, ADatabase);
  Try
    LQuery.Close;
    LQuery.SQL.Text := 'SET sql_mode = ""';
    LQuery.ExecSQL;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class procedure TDiretivasDaConexao.DefineIsolationLevel(const ADatabase: TUniConnection);
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery(Nil, ADatabase);
  Try
    LQuery.Close;
    LQuery.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
    LQuery.ExecSQL;
  Finally
    FreeAndNil(LQuery);
  End;
end;

initialization
  FMainThreadID := GetCurrentThreadId;

end.
