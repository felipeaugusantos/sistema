unit untModulo;

interface

uses
  SysUtils, Classes, {$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280)}Data.DB{$ELSE}DB{$IFEND},
  {$IF Defined(UNIDAC)}
    DBAccess, Uni, UniProvider, MySQLUniProvider, CRAccess,
  {$ELSE}
    ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  madExceptVcl, madExcept, Forms, Variants, Windows, StrUtils;

type
  TfrmModulo = class(TDataModule)
    MadException: TMadExceptionHandler;
    procedure MadExceptionException(const exceptIntf: IMEException;
      var handled: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    blnTemMad: Boolean;
    blnVerificandoMadExcept: Boolean;
    procedure AfterConnect(Sender : TObject);
  public
    { Public declarations }
    {$IF Defined(UNIDAC)}
      Database: TUniConnection;
      MySQLUniProvider: TMySQLUniProvider;
    {$ELSE}
      Database: TZConnection;
    {$IFEND}
    function fGravarRelErro(strMensagemErro, strRelatorio: String): Integer;
  end;

  TDiretivasDaConexao = class
    class procedure DefineIsolationLevel(const Sender : TObject);
  End;

var
  frmModulo: TfrmModulo;
const
  SEM_MAD = 'youdonthavemadexcept';

implementation

{$R *.dfm}

uses untUtil, untConectando;

procedure TfrmModulo.AfterConnect(Sender: TObject);
begin
  DefinirTimeZoneEmSessaoMySql(VS_strCodEmp);
  TDiretivasDaConexao.DefineIsolationLevel(Sender);
end;

procedure TfrmModulo.DataModuleCreate(Sender: TObject);
begin
  {$IF Defined(UNIDAC)}
    Database := TUniConnection.Create(Self);
    MySQLUniProvider := TMySQLUniProvider.Create(Database);
    Database.ProviderName := 'MySQL';
    Database.DefaultTransaction.IsolationLevel := ilReadCommitted;
  {$ELSE}
    Database := TZConnection.Create(Self);
    Database.Protocol := 'mysql-4.1';
    Database.TransactIsolationLevel := tiReadCommitted;
  {$IFEND}

  DataBase.AfterConnect := Self.AfterConnect;

  If (FindResource(HInstance, 'EXCEPT', 'MAD') <> 0) Then
  Begin
    blnTemMad := True;
  End
  Else
  Begin
    blnTemMad := False;
    Try
      Try
        blnVerificandoMadExcept := True;
        Raise Exception.Create(SEM_MAD);
      Except
        HandleException;

        Sleep(500);
        Application.ProcessMessages;

        {$IFDEF TESTABILIDADE_AUTCOM}
          // ...
        {$ELSE}
          If Not blnTemMad Then
          Begin
            pMensagemOk('Não foi encontrado o módulo MadExcept no sistema!' + #13 +
                        'Ligue imediatamente para a Citel.');
            Application.Terminate;
          End;
        {$ENDIF}
      End;
    Finally
      blnVerificandoMadExcept := False;
    End;
  End;
end;

procedure TfrmModulo.MadExceptionException(const exceptIntf: IMEException;
  var handled: Boolean);
  Var
    intCodErro: Integer;
    blnDuplici: Boolean;
    blnForeignKey: Boolean;
    strInfoForeignKeyError: String;
    strNomeBanco: String;
begin

  If Pos(SEM_MAD, exceptIntf.ExceptMessage) > 0 Then
  Begin
    blnTemMad := True;
    handled := True;
    Exit;
  End;

  If blnVerificandoMadExcept Then
  Begin
    Exit;
  End;

  If (Pos(LowerCase('Lost connection'), LowerCase(exceptIntf.ExceptMessage)) > 0) Or
     (Pos(LowerCase('Assertion failure'), LowerCase(exceptIntf.ExceptMessage)) > 0) Or
     (Pos(LowerCase('t connect to MySQL server'), LowerCase(exceptIntf.ExceptMessage)) > 0) Then
  Begin
    handled := True;
    TfrmConectando.pReconectarModulo(exceptIntf.ExceptMessage);
    Exit;
  End;

  If exceptIntf.ExceptClass = 'EAccessViolation' Then
  Begin
    exceptIntf.ShowPleaseWaitBox := False;

    If (Pos('PainelNFe.exe cxGridTableView'      , exceptIntf.BugReport) > 0) Or
       (Pos('PainelNFe.exe cxGridCustomView'     , exceptIntf.BugReport) > 0) Or
       (Pos('PainelNFe.exe cxGridCustomTableView', exceptIntf.BugReport) > 0) Or
       (Pos('PainelNFe.exe cxGridDetailsSite'    , exceptIntf.BugReport) > 0) Then
    Begin
      handled := True;
      Exit;
    End;
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

  If Pos('Net packets out of order', exceptIntf.ExceptMessage) > 0 Then
  Begin
    handled := True;
    Exit;
  End;

  strNomeBanco := {$IF Defined(UNIDAC)} Database.Server {$ELSE} Database.Hostname {$IFEND};

  If Pos('CONNECTION TO MYSQL', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'A conexão estabelecida com o banco de dados foi perdida.' + #13#10 +
                            'O servidor parou de responder corretamente.' + #13#10 +
                            'Feche o Sistema AUTCOM e tente conectar novamente.' + #13#10 +
                            'Caso o problema persista, entre em contato com o responsável pelo servidor.';
  End;

  If Pos('CONNECT TO MYSQL', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Não é possível estabelecer conexão com o banco de dados no IP:' + strNomeBanco + '.' + #13#10 +
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

  blnDuplici := False;

  If (Pos('dhcpcsvc', exceptIntf.ExceptMessage) > 0) Or
     (Pos('netprofm', exceptIntf.ExceptMessage) > 0) Or
     (Pos('mswsock' , exceptIntf.ExceptMessage) > 0) Or
     (Pos('rtutils' , exceptIntf.ExceptMessage) > 0) Or
     (Pos('fwpuclnt', exceptIntf.ExceptMessage) > 0) Then
  Begin
    handled := True;
    pMensagemOk('O Windows® não está respondendo.' + #13#10 +
                'Pressione ENTER para continuar e tente novamente.' + #13#10 +
                'Caso o problema persista, entre em contato com o responsável pelo Sistema.');
    Exit;
  End;

  If (Pos('<<SUBMAD>>', exceptIntf.ExceptMessage) > 0) Then
  Begin
    Handled := True;
    pMensagemOk(AnsiReplaceStr(exceptIntf.ExceptMessage,'<<SUBMAD>>',''));
    Exit;
  End;

  If (Pos('duplicada', LowerCase(exceptIntf.ExceptMessage)) > 0) Or
     (Pos('duplicate', LowerCase(exceptIntf.ExceptMessage)) > 0) Then
    exceptIntf.ExceptMsg := 'Chave Duplicada na Tabela: ' + VS_strTabelaErro + ' - Mensagem de Erro: ' + exceptIntf.ExceptMessage;

  strInfoForeignKeyError := '';
  If (Pos('foreign key', LowerCase(exceptIntf.ExceptMessage)) > 0) or (Pos('chave estrangeira', LowerCase(exceptIntf.ExceptMessage)) > 0) Then
    strInfoForeignKeyError := fRetornaInformacaoUltimoErroForeignKey;

  blnForeignKey := Not fEmptyStr(strInfoForeignKeyError);

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
  End;

  {*******************************************}
  {* GRAVA LOG DE ERRO                       *}
  {****************************************AF*}
  exceptIntf.CreateScreenShot := True;

  If (Pos('duplicada', LowerCase(exceptIntf.ExceptMessage)) > 0) Or
     (Pos('duplicate', LowerCase(exceptIntf.ExceptMessage)) > 0) Then
  Begin
    intCodErro := fGravarRelErro('Chave Duplicada na Tabela: ' + VS_strTabelaErro + ' - Mensagem de Erro: ' + exceptIntf.ExceptMessage, exceptIntf.GetBugReport);
    blnDuplici := True;
  End
  Else If blnForeignKey Then
  Begin
    intCodErro := fGravarRelErro('Erro de Foreign Key na Tabela: ' + VS_strTabelaErro, strInfoForeignKeyError + #13#10 + exceptIntf.GetBugReport);
  End
  Else
    intCodErro := fGravarRelErro(exceptIntf.ExceptMessage, exceptIntf.GetBugReport);

  {*********************************}
  {* CRIA CAMPO NO BUGREPORT       *}
  {******************************JB*}
  exceptIntf.BugReportHeader['Empresa']   := Concat(VS_strCodEmp, ' - ', fRetNomeEmpresa(VS_strCodEmp));
  exceptIntf.BugReportHeader['Usuario']   := Concat('PainelNFe.exe');
  exceptIntf.BugReportHeader['Conexao']   := Concat(strNomeBanco, '/', frmModulo.Database.Database);

  If blnDuplici Then
    exceptIntf.BugReportHeader['Tipo Erro'] := 'Chave Duplicada na Tabela: ' + VS_strTabelaErro
  Else If blnForeignKey Then
    exceptIntf.BugReportHeader['Tipo Erro'] := 'Erro de Foreign Key na Tabela: ' + VS_strTabelaErro
  Else
    exceptIntf.BugReportHeader['Tipo Erro'] := ExtractFileName(Application.ExeName);

  {*******************************************}
  {* GRAVA IMAGEM DE ERRO                    *}
  {****************************************AF*}
  If Not DirectoryExists(ExtractFilePath(Application.ExeName) + '\LogErros') Then
    CreateDir(ExtractFilePath(Application.ExeName) + '\LogErros');

  exceptIntf.ScreenShot.SavePng(ExtractFilePath(Application.ExeName) + '\LogErros\' + IntToStr(intCodErro) + '.PNG');

  {*******************************************}
  {* SE FOR VIOLAÇÃO DE ACESSO O PROCESSO EH *}
  {* DIFERENTE                               *}
  {****************************************AF*}
  If exceptIntf.ExceptClass = 'EAccessViolation' Then
  Begin
    exceptIntf.ContinueBtnVisible := False;
    exceptIntf.RestartBtnVisible  := False;
    exceptIntf.CloseBtnVisible    := True;

    If Assigned(Screen.ActiveForm) Then
      Screen.ActiveForm.Enabled := False;

    exceptIntf.Show;

    pFecharBanco(Database);
  End;

  If Pos('EOutOfResources', exceptIntf.ExceptMessage) > 0 Then
  Begin
    exceptIntf.ContinueBtnVisible := False;
    exceptIntf.RestartBtnVisible  := False;
    exceptIntf.CloseBtnVisible    := True;

    If Assigned(Screen.ActiveForm) Then
      Screen.ActiveForm.Enabled := False;

    exceptIntf.Show;

    pFecharBanco(Database);
  End;
end;

function TfrmModulo.fGravarRelErro(strMensagemErro, strRelatorio: String): Integer;
  Var
    qryLogErr: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    intLogErr: Integer;
    dtaDtaSis : TDateTime;
    dtaHraSis : TDateTime;
begin

  intLogErr := 0;

  Try
    qryLogErr := fCriaQuery;
    qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

    pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);

    With qryLogErr Do
    Begin
      Open;
      Insert;
      FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_LOGOPE').Value      := Null;
      FieldByName('LOG_DTAERR').AsDateTime := dtaDtaSis;
      FieldByName('LOG_HORERR').AsDateTime := dtaHraSis;
      FieldByName('LOG_DESCRI').AsString   := strMensagemErro;
      FieldByName('LOG_RELERR').AsString   := strRelatorio;
      Post;
      intLogErr := FieldByName('AUTOINCREM').AsInteger;
      Close;
    End;
  Finally
    Result := intLogErr;
    FreeAndNil(qryLogErr);
  End;

end;

{ TDiretivasDaConexao }

class procedure TDiretivasDaConexao.DefineIsolationLevel(const Sender: TObject);
  Var
    qryIsolation: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  {$IF Defined(UNIDAC)}
    If (Sender Is TUniConnection) Then
    Begin
      qryIsolation := fCriaQuery(nil, TUniConnection(Sender));
      try
        qryIsolation.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
        qryIsolation.ExecSQL;
      finally
        FreeAndNil(qryIsolation);
      end;
    End;
  {$ELSE}
    If (Sender Is TZConnection) Then
    Begin
      qryIsolation := fCriaQuery(nil, TZConnection(Sender));
      try
        qryIsolation.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
        qryIsolation.ExecSQL;
      finally
        FreeAndNil(qryIsolation);
      end;
    End;
  {$IFEND}
end;

end.
