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
    qryDirOpe: TUniQuery;
    dtsCadGpo: TDataSource;
    dtsOpeGpo: TDataSource;
    dtsDirGpo: TDataSource;
    dtsDirOpe: TDataSource;
    dtsGruOpe: TDataSource;
    qryCadGpoGPO_CODGPO: TIntegerField;
    qryCadGpoGPO_DESCRI: TStringField;
    qryCadGpoGPO_DTACAD: TDateField;
    qryOpeGpoOPE_CODOPE: TStringField;
    qryOpeGpoGPO_CODGPO: TIntegerField;
    qryDirGpoDIR_NOMFRM: TStringField;
    qryDirGpoGPO_CODGPO: TIntegerField;
    qryDirOpeDIR_NOMFRM: TStringField;
    qryDirOpeOPE_CODOPE: TStringField;
    qryDirGpoDIR_ACAOUS: TStringField;
    qryDirOpeDIR_ACAOUS: TStringField;
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
    qryLogDir: TUniQuery;
    DataDBF: TUniConnection;

    procedure DataModuleCreate(Sender: TObject);
    procedure tblGruOpeCalcFields(DataSet: TDataSet);
    procedure MadExceptionException(const exceptIntf: IMEException;
      var handled: Boolean);
    procedure qryDirGpoAfterPost(DataSet: TDataSet);
    procedure qryDirGpoBeforeDelete(DataSet: TDataSet);
    procedure qryDirOpeAfterPost(DataSet: TDataSet);
    procedure qryDirOpeBeforeDelete(DataSet: TDataSet);
    procedure qryDirTinAfterPost(DataSet: TDataSet);
    procedure qryDirTinBeforeDelete(DataSet: TDataSet);
    procedure qryDirBanAfterPost(DataSet: TDataSet);
    procedure qryDirBanBeforeDelete(DataSet: TDataSet);
    procedure DatabaseError(Sender: TObject; E: EDAError; var Fail: Boolean);
  private
    { Private declarations }
    blnTemMad: Boolean;
    procedure pAddLogDir(strTabela, strNomFrm, strOpeDir, strACAOUS: String;
      intCodGpo: Integer);

  public
    MadExceptionDll : TMadExceptionHandler;

    procedure pCriaEAtribuiMadException;
    procedure pLiberaMadException;
    function fGravarRelErro(strMensagemErro, strRelatorio: String): Integer;

    constructor Create(Owner: TComponent); Override;
    constructor CreateInstance(Owner: TComponent; blnConectar: Boolean);

  end;

var
  frmModulo: TfrmModulo;
  ProcReconectarModulo : TProcReconectarModulo;

Const
  SEM_MAD = 'youdonthavemadexcept';

implementation

uses untListaLogErros, untfuncoesSimples;

{$R *.dfm}

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

    blnTemMad := False;
    Try
      Raise Exception.Create(SEM_MAD);
    Except
      HandleException;

      If Not blnTemMad Then
      Begin
        pMensagemOk('Não foi encontrado o módulo MadExcept no sistema!' + #13 +
                    'Ligue imediatamente para a Citel.');
        Application.Terminate;
      End;
    End;
  End;

end;

procedure TfrmModulo.DatabaseError(Sender: TObject; E: EDAError;
  var Fail: Boolean);
begin
//  showmessage(e.Message);
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
  qryDirOpe.Connection := Database;
  qryDirTin.Connection := Database;
  qryDirBan.Connection := Database;
  qryLogDir.Connection := Database;

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

{*************************************************}
{*   GRAVA MENSAGENS DE ERRO NO ARQUIVO DE LOG   *}
{**********************************************AF*}
function TfrmModulo.fGravarRelErro(strMensagemErro, strRelatorio: String): Integer;
  Var
    qryLogErr: TUniQuery;
    intLogErr: Integer;
begin

  intLogErr := 0;

  Try
    qryLogErr := fCriaQuery;
    qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

    With qryLogErr Do
    Begin
      Open;
      Insert;
      FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
      FieldByName('LOG_HORERR').AsDateTime := Time;
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

procedure TfrmModulo.MadExceptionException(const exceptIntf: IMEException; var handled: Boolean);
  Var
    intCodErro: Integer;
    blnDuplici: Boolean;
    blnForeignKey: Boolean;
    strInfoForeignKeyError: String;
    strNomeTabForeignKey: String;
    strRetInnoDB: String;
begin
  //Quando chama pelo monitor de serviÃ§os do autcom,
  // nÃ£o estoura erro na tela, mas volta para o serivÃ§o o erro
  //atraves do fMensagem e grava o logerr normalmente;
  If VS_NotShowMessage And (FindWindow('TfrmAutcomSvc', Nil) > 0) Then
  Begin
    exceptIntf.ShowPleaseWaitBox := False;
    handled := True;
    fMensagem('', exceptIntf.ExceptMessage, ['&Ok']);
  End;

  If Pos(SEM_MAD, exceptIntf.ExceptMessage) > 0 Then
  Begin
    blnTemMad := True;
    handled := True;
    Exit;
  End;

  If (Pos(LowerCase('Lost connection'), LowerCase(exceptIntf.ExceptMessage)) > 0) And Assigned(ProcReconectarModulo) Then
  Begin
    handled := True;
    ProcReconectarModulo(exceptIntf.ExceptMessage);
    Exit;
  End;

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

  blnDuplici := False;

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

  If Pos('ASSERTION FAILURE', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    exceptIntf.ExceptMsg := 'Não é possível estabelecer conexão com o banco de dados no IP:' + Database.Server + '.' + #13#10 +
                            'O servidor parou de responder corretamente.' + #13#10 +
                            'Feche o Sistema AUTCOM e tente conectar novamente.' + #13#10 +
                            'Caso o problema persista, entre em contato com o responsável pelo servidor.';
  End;

  If (Pos('duplicada', LowerCase(exceptIntf.ExceptMessage)) > 0) Or
     (Pos('duplicate', LowerCase(exceptIntf.ExceptMessage)) > 0) Then
    exceptIntf.ExceptMsg := 'Chave Duplicada na Tabela: ' + VS_strTabelaErro + ' - Mensagem de Erro: ' + exceptIntf.ExceptMessage;

  strNomeTabForeignKey   := '';
  strInfoForeignKeyError := '';
  strRetInnoDB := '';
  If (Pos('foreign key', LowerCase(exceptIntf.ExceptMessage)) > 0) or (Pos('chave estrangeira', LowerCase(exceptIntf.ExceptMessage)) > 0)Then
    strInfoForeignKeyError := fRetornaInformacaoUltimoErroForeignKey(strRetInnoDB);

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
    strNomeTabForeignKey := Trim(Copy(strInfoForeignKeyError, Pos('Tabela de Gravação:', strInfoForeignKeyError),Pos('Foreign Key:', strInfoForeignKeyError) - Pos('Tabela de Gravação:', strInfoForeignKeyError)));
  End;

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
    intCodErro := fGravarRelErro('Erro de Foreign Key - ' + strNomeTabForeignKey, strInfoForeignKeyError + #13#10 + exceptIntf.GetBugReport);
  End
  Else If Pos('deadlock', LowerCase(exceptIntf.ExceptMessage)) > 0 Then
  Begin
    intCodErro := fGravarRelErro(exceptIntf.ExceptMessage, fRetornaInformacaoUltimoDeadlock + #13#10 + fReplicatorStr('=',50) + #13#10 + exceptIntf.GetBugReport);
  End
  Else
    intCodErro := fGravarRelErro(exceptIntf.ExceptMessage, exceptIntf.GetBugReport);

  {*********************************}
  {* CRIA CAMPO NO BUGREPORT       *}
  {******************************JB*}
  exceptIntf.BugReportHeader['Empresa']   := Concat(VS_strCodEmp, ' - ', fRetNomeEmpresa(VS_strCodEmp));
  exceptIntf.BugReportHeader['Usuario']   := Concat(strLoginUsuarioLogado, ' - ', strDescriUsuarioLogado);
  exceptIntf.BugReportHeader['Conexao']   := Concat(frmModulo.Database.Server, '/', frmModulo.Database.Database);

  If blnDuplici Then
    exceptIntf.BugReportHeader['Tipo Erro'] := 'Chave Duplicada na Tabela: ' + VS_strTabelaErro
  Else If blnForeignKey Then
    exceptIntf.BugReportHeader['Tipo Erro'] := 'Erro de Foreign Key - ' + strNomeTabForeignKey
  Else
    exceptIntf.BugReportHeader['Tipo Erro'] := ExtractFileName(Application.ExeName);

  {*******************************************}
  {* GRAVA IMAGEM DE ERRO                    *}
  {****************************************AF*}
  If Not DirectoryExists(ExtractFilePath(Application.ExeName) + '\LogErros') Then
    CreateDir(ExtractFilePath(Application.ExeName) + '\LogErros');

  If Assigned(exceptIntf.ScreenShot) Then
    exceptIntf.ScreenShot.SavePng(ExtractFilePath(Application.ExeName) + '\LogErros\' + IntToStr(intCodErro) + '.PNG');

  {*******************************************}
  {* SE FOR VIOLAÇÃO DE ACESSO O PROCESSO EH *}
  {* DIFERENTE                               *}
  {****************************************AF*}
  {Req.: 99135}
  exceptIntf.SendBtnVisible := False;

  If (exceptIntf.ExceptClass = 'EAccessViolation') Or
     (Pos('ACCESS VIOLATION', AnsiUpperCase(exceptIntf.ExceptMessage)) > 0) Then
  Begin
    pDestravarTodosLocksConexaoAtual;

    exceptIntf.ContinueBtnVisible := False;
    exceptIntf.RestartBtnVisible  := False;
    exceptIntf.CloseBtnVisible    := True;

    If Assigned(Screen.ActiveForm) Then
      Screen.ActiveForm.Enabled := False;

    exceptIntf.Show;

    pFecharBanco(Database);
  End;

  If (exceptIntf.ExceptClass = 'EOSError') Then
  Begin
    pDestravarTodosLocksConexaoAtual;

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
    pDestravarTodosLocksConexaoAtual;

    exceptIntf.ContinueBtnVisible := False;
    exceptIntf.RestartBtnVisible  := False;
    exceptIntf.CloseBtnVisible    := True;

    If Assigned(Screen.ActiveForm) Then
      Screen.ActiveForm.Enabled := False;

    exceptIntf.Show;

    pFecharBanco(Database);
  End;

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
             0);

end;

procedure TfrmModulo.qryDirBanBeforeDelete(DataSet: TDataSet);
begin
  pAddLogDir('DIRBAN',
             DataSet.FieldByName('BAN_NOMFRM').AsString,
             DataSet.FieldByName('BAN_CODOPE').AsString,
             'DEL',
             0);
end;

procedure TfrmModulo.qryDirGpoAfterPost(DataSet: TDataSet);
begin
  pAddLogDir('DIRGPO',
             DataSet.FieldByName('DIR_NOMFRM').AsString,
             '',
             DataSet.FieldByName('DIR_ACAOUS').AsString,
             DataSet.FieldByName('GPO_CODGPO').AsInteger);

end;

procedure TfrmModulo.qryDirGpoBeforeDelete(DataSet: TDataSet);
begin
  pAddLogDir('DIRGPO',
             DataSet.FieldByName('DIR_NOMFRM').AsString,
             '',
             'DEL',
             DataSet.FieldByName('GPO_CODGPO').AsInteger);
end;

procedure TfrmModulo.qryDirOpeAfterPost(DataSet: TDataSet);
begin
  pAddLogDir('DIROPE',
             DataSet.FieldByName('DIR_NOMFRM').AsString,
             DataSet.FieldByName('OPE_CODOPE').AsString,
             DataSet.FieldByName('DIR_ACAOUS').AsString,
             0);
end;

procedure TfrmModulo.qryDirOpeBeforeDelete(DataSet: TDataSet);
begin
  pAddLogDir('DIROPE',
             DataSet.FieldByName('DIR_NOMFRM').AsString,
             DataSet.FieldByName('OPE_CODOPE').AsString,
             'DEL',
             0);
end;

procedure TfrmModulo.qryDirTinAfterPost(DataSet: TDataSet);
begin
  pAddLogDir('DIRTIN',
             DataSet.FieldByName('TIN_NOMFRM').AsString,
             DataSet.FieldByName('TIN_CODOPE').AsString,
             'IAE',
             0);
end;

procedure TfrmModulo.qryDirTinBeforeDelete(DataSet: TDataSet);
begin
  pAddLogDir('DIRTIN',
             DataSet.FieldByName('TIN_NOMFRM').AsString,
             DataSet.FieldByName('TIN_CODOPE').AsString,
             'DEL',
             0);
end;

procedure TfrmModulo.tblGruOpeCalcFields(DataSet: TDataSet);
begin
  With DataSet Do
    FieldByName('OPE_DESCRI').AsString := fRetNomeOperador(FieldByName('OPE_CODOPE').AsString);
end;

procedure TfrmModulo.pAddLogDir(strTabela, strNomFrm, strOpeDir, strACAOUS : String; intCodGpo : Integer);
Begin
  With qryLogDir Do
  Begin

    Insert;

    FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGDIR', VS_strCodEmp);
    FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
    FieldByName('LOG_HORALT').AsDateTime := Time;
    FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    FieldByName('LOG_TABELA').AsString   := strTabela;
    FieldByName('LOG_NOMFRM').AsString   := strNomFrm;
    FieldByName('LOG_OPEDIR').AsString   := strOpeDir;
    FieldByName('LOG_CODGPO').AsInteger  := intCodGpo;
    FieldByName('LOG_ACAOUS').AsString   := strACAOUS;

    If fEmptyStr(FieldByName('LOG_OPEDIR').AsString) then
      FieldByName('LOG_OPEDIR').Clear;

    If FieldByName('LOG_CODGPO').AsInteger <= 0 Then
      FieldByName('LOG_CODGPO').Clear;

    Post;

  End;


End;

end.
