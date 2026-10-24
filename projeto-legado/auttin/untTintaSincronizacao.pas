{*******************************************}
{* UNIT PARA SINCRONIZACAO DE TINTAS       *}
{****************************************PH*}
unit untTintaSincronizacao;

interface

uses
  SysUtils, Classes, Uni,  Forms, DB, UniClientDataSet, Variants, ADODB, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdFTP, IdFTPList, IdFTPCommon, ShellAPI,
  Windows, ZipMstr, UniDataSetProvider, DAScript, UniScript;

Type
  {*********************************************}
  {* EVENTOS DISPARADOS AO LONGO DOS CADASTROS *}
  {******************************************PH*}
  TEventoProgresso  = procedure(intMinimo, intAtual, intMaximo: Integer) of object;
  TEventoStrAcao = procedure(strAcao: String) of object;
  TEventoProgressoDownload = procedure(intMinimo, intAtual, intMaximo: Int64) of object;

  {*******************************************}
  {* FUNCOES DE ENTRADA                      *}
  {****************************************PH*}
  TExportarArquivos = function(): Boolean;
  TProcessarArquivos = TExportarArquivos;

  TTintaSincronizacao = class(TComponent)
  private
    Username: String;
    Password: String;
    Host: String;
  protected
    strPat : String;
    intOpcao: Integer;
    strArqTinta: String;
    stlArquivos: TStringList;
    strSiglaTinta: String;


    {*******************************************}
    {* EVENTOS DISPARADOS DURANTE O PROCESSO   *}
    {****************************************PH*}
    FRegistraAcao     : TEventoStrAcao;
    FRegistraProgresso : TEventoProgresso;
    FRegistraProgressoDownload: TEventoProgressoDownload;

    {**********************************************}
    {* COMPONENTE E VARIAVEIS PARA USAR COM O FTP *}
    {*******************************************PH*}
    ftpConexao: TIdFTP;
    intMaximoTransferencia: Integer;
    intMinimoTransferencia: Integer;
    {*******************************************}
    {* VARIAVEIS PARA ARQUIVOS ZIP             *}
    {****************************************PH*}
    intProgressoExtracao: Integer;
    intProgressoExtraxaoTamanho: Integer;

    {*******************************************}
    {* FUNCOES PARA CONEXAO FTP                *}
    {****************************************PH*}
    function fConectarFTP(): Boolean;
    procedure pRegistraStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure pRegistraInicio(Sender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure pRegistraProgresso(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure pRegistraFimDownload(Sender: TObject; AWorkMode: TWorkMode);
    function fDownloadArquivo(): Boolean;

    {***********************************************}
    {* FUNCOES PARA VERIFICAR O TAMANHO DO ARQUIVO *}
    {********************************************PH*}
    function fVerificaTamanhoArquivo(strNomArq: String): Int64;

    {***********************************************************}
    {* FUNCAO PARA CONTAR QUANTAS LINHAS TEM UM ARQUIVO TEXTO, *}
    {* SOMENTE ARQUIVO TEXTO! O ARQUIVO NAO PODE ESTAR ABERTO! *}
    {********************************************************PH*}
    function fContaLihas(strArquivo: String): Integer;

    {************************************************************}
    {* FUNCOES PARA EXTRAIR / COMPACTAR OS ARQUIVOS DO DOWNLOAD *}
    {*********************************************************PH*}
    function fExtrairArquivos(strArquivoZip: String; strDirExtra: String): Boolean;
    procedure pProgressoExtracao(Sender: TObject; ProgrType: ProgressType; Filename: string; FileSize: Integer);

    {************************************************************}
    {* EVENTO DISPARADO QUANDO SE PERCORRE UM DATASET, PODE     *}
    {* SER USADO PARA MONITORAR QUANDO SE LIGA UM CLIENTDATASET *}
    {* EM UM DATASET                                            *}
    {*********************************************************PH*}
    procedure pOnScrollDatSet(DataSet: TDataSet);

    {*****************************************************}
    {* BACKUP DAS TABELAS, FAZER ANTES DE IMPORTAR DADOS *}
    {**************************************************PH*}
    function fCriarBackup(strTabela: String; strNomArq: String): Boolean;

    {*******************************************************}
    {* CRIA ARQUIVO PARA MARCAR DATA E HORA DA ATUALIZACAO *}
    {****************************************************PH*}
    function fMarcaDataHora: Boolean;

    {*******************************************}
    {* FUNCOES PARA SEREM IMPLEMENTADAS        *}
    {****************************************PH*}
    function fImportaArquivos: Boolean; virtual; abstract;
    function fExportaArquivos: Boolean; virtual; abstract;

    {*******************************************}
    {* DESABILITA / HABILITA CHAVE ESTRANGEIRA *}
    {****************************************PH*}
    { procedures foram removidas pois dava erro na replicação }
    //procedure pDesabilitaChaveEstrangeira;
    //procedure pHabilitaChaveEstrangeira;
  public
  
    {*******************************************}
    {* FUNCAO PARA ACHAR O PROXIMO AUTOINCREM  *}
    {****************************************PH*}
    class function fAjustaAutoIncrem(strTabela, strCodEmp: String; intInicio: Integer): Boolean;

    constructor Create(AOWner: TComponent; intOpcao: Integer); reintroduce;
    function fProcessaArquivos(): Boolean;
    {*******************************************}
    {* PEGAR A DATA DA ULTIMA ATUALIZACAO      *}
    {****************************************PH*}
    function fDataUltimaAtualizacao(var dtaUltAtu: TDateTime; strArqTinta: String; strPat: String): Boolean;
  published
    {*******************************************}
    {* EVENTOS DISPARADOS DURANTE O PROCESSO   *}
    {****************************************PH*}
    property  RegistraAcao  : TEventoStrAcao  Read  FRegistraAcao Write FRegistraAcao;
    property  RegistraProgresso : TEventoProgresso  Read  FRegistraProgresso  Write FRegistraProgresso;
    property  RegistraProgressoDownload : TEventoProgressoDownload  Read  FRegistraProgressoDownload  Write FRegistraProgressoDownload;
  End;




implementation

uses untFuncoesSimples, StrUtils, untModulo, Math;

{ TTintaSincronizacao }

constructor TTintaSincronizacao.Create(AOWner: TComponent;
  intOpcao: Integer);
begin
  Self.intOpcao := intOpcao;
  strPat := ExtractFileDir(Application.ExeName) + '\SINCRONIZACAO';

  {*******************************************}
  {* CRIA O COMPONENTE PARA CONECTAR NO FTP  *}
  {****************************************PH*}
  ftpConexao := TIdFTP.Create(Self);
  ftpConexao.TransferType := ftBinary;
  ftpConexao.Passive := False;
  ftpConexao.OnStatus := pRegistraStatus;
  ftpConexao.OnWorkBegin := pRegistraInicio;
  ftpConexao.OnWork := pRegistraProgresso;
  ftpConexao.OnWorkEnd := pRegistraFimDownload;

  {*******************************************}
  {* VARIAVEIS PARA ARQUIVOS ZIP             *}
  {****************************************PH*}
  intProgressoExtracao := 0;

  stlArquivos := TStringList.Create;
  stlArquivos.Clear;

  Username := 'citelsoftware';
  Password := '60004009';
  Host := 'ftpcitel.no-ip.info';
end;

class function TTintaSincronizacao.fAjustaAutoIncrem(strTabela,
  strCodEmp: String; intInicio: Integer): Boolean;
//  Var
//    qryGen: TUniQuery;
//    intProx: Integer;
begin
//  qryGen := fCriaQuery(nil);
//  qryGen.ParamCheck := False;
//
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('SET @CONT = ' + IntToStr(intInicio - 1) + ';');
//  qryGen.ExecSQL;
//
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('UPDATE IGNORE');
//  qryGen.SQL.Add('  ' + strTabela);
//  qryGen.SQL.Add('SET ');
//  qryGen.SQL.Add('	AUTOINCREM = CONCAT(RIGHT(CONCAT("0000000000000000000000", @CONT := @CONT+1 ), 17 ), "' + strCodEmp + '" );');
//  qryGen.ExecSQL;
//
//  // ATUALIZA PROCOD
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('SELECT');
//  qryGen.SQL.Add('	(CAST(LEFT(AUTOINCREM, 17) AS SIGNED) + 1) AS "PROX"');
//  qryGen.SQL.Add('FROM');
//  qryGen.SQL.Add('	' + strTabela);
//  qryGen.SQL.Add('ORDER BY');
//  qryGen.SQL.Add('	AUTOINCREM DESC');
//  qryGen.SQL.Add('LIMIT 1;');
//  qryGen.Open;
//
//  intProx := qryGen.FieldByName('PROX').AsInteger;
//
//  qryGen.Close;
//  qryGen.SQL.Clear;
//  qryGen.SQL.Add('UPDATE');
//  qryGen.SQL.Add('	PROCOD');
//  qryGen.SQL.Add('SET');
//  qryGen.SQL.Add('	PRO_AUTINC = ' + IntToStr(intProx));
//  qryGen.SQL.Add('WHERE');
//  qryGen.SQL.Add('	PRO_NOMARQ = "' + strTabela + '"');
//  qryGen.ExecSQL;
//
//  FreeAndNil(qryGen);
//
//  Result := True;
  Result := False;
end;

function TTintaSincronizacao.fConectarFTP(): Boolean;
begin
  ftpConexao.Username := Username;
  ftpConexao.Password := Password;
  ftpConexao.Host := Host;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Conectando no servidor...');
  End;

  {*******************************************}
  {* TENTA CONECTAR NO SERVIDOR FTP          *}
  {****************************************PH*}
  Try
    ftpConexao.ConnectTimeout := 1000;
    ftpConexao.Connect;
  Except
    Result := False;
    fMensagem('ATENÇÃO', 'Não foi possivel conectar no servidor FTP!', ['OK']);
    Exit;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Conexão realizada com sucesso!');
    FRegistraAcao(ftpConexao.Greeting.Text.Text);
  End;

  Result := True;
end;

function TTintaSincronizacao.fContaLihas(strArquivo: String): Integer;
  Var
    arqGen: TextFile;
begin
  Result := 0;
  Try
    AssignFile(arqGen, strArquivo);
    Reset(arqGen);

    While Not Eof(arqGen) Do
    Begin
      Readln(arqGen);
      Result := Result + 1;
    End;

    CloseFile(arqGen);
  Except
    Result := 0;
  End;
end;

function TTintaSincronizacao.fCriarBackup(strTabela,
  strNomArq: String): Boolean;
  Var
    qryGen: TUniQuery;
    txtArqSaida: TextFile;
    strAux: String;
    intCont: Integer;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT DATABASE()';
  qryGen.Open;

  If Not ForceDirectories(ExtractFileDir(strNomArq)) Then
  Begin
    Result := False;
    Exit;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Criando backup da tabela ' + strTabela);
  End;

  AssignFile(txtArqSaida, strNomArq);
  Rewrite(txtArqSaida);

  Writeln(txtArqSaida, '-- Host: ' + qryGen.Connection.Server + '    Database: ' + qryGen.FieldByName('DATABASE()').AsString);
  Writeln(txtArqSaida, '-- ------------------------------------------------------');
  Writeln(txtArqSaida, '');
  Writeln(txtArqSaida, '/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;');
  Writeln(txtArqSaida, '/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;');
  Writeln(txtArqSaida, '/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;');
  Writeln(txtArqSaida, '/*!40101 SET NAMES utf8 */;');
  Writeln(txtArqSaida, '/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;');
  Writeln(txtArqSaida, '/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;');
  Writeln(txtArqSaida, '/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;');
  Writeln(txtArqSaida, '/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;');
  Writeln(txtArqSaida, '');
  Writeln(txtArqSaida, '--');
  Writeln(txtArqSaida, '-- Table structure for table ' + strTabela);
  Writeln(txtArqSaida, '--');
  Writeln(txtArqSaida, '');

  Writeln(txtArqSaida, 'USE ' + qryGen.FieldByName('DATABASE()').AsString + ';');

  Writeln(txtArqSaida, '/* Dados para a tabela ' + strTabela + '*/');

  qryGen.Close;
  qryGen.SQL.Text := 'SHOW CREATE TABLE ' + strTabela;
  qryGen.Open;

  Writeln(txtArqSaida, 'DROP TABLE IF EXISTS ' + strTabela + ';');
  Writeln(txtArqSaida, AnsiReplaceStr(AnsiReplaceStr(qryGen.FieldByName('Create Table').AsString, '`', ''), #39, '"') + ';');

  Writeln(txtArqSaida, '');
  Writeln(txtArqSaida, '--');
  Writeln(txtArqSaida, '-- Dumping data for table ' + strTabela);
  Writeln(txtArqSaida, '--');
  Writeln(txtArqSaida, '');
  Writeln(txtArqSaida, '');
  Writeln(txtArqSaida, '/*!40000 ALTER TABLE ' + strTabela + ' DISABLE KEYS */;');
  Writeln(txtArqSaida, 'LOCK TABLES ' + strTabela + ' WRITE;');
  Writeln(txtArqSaida, 'INSERT INTO ' + strTabela + ' VALUES ');

  qryGen.Close;
  qryGen.SQL.Text := 'SELECT * FROM ' + strTabela;
  qryGen.Open;
  qryGen.First;

  While Not qryGen.Eof Do
  Begin

    If ((qryGen.RecNo mod 500) = 0) Then
    Begin
      strAux := 'INSERT INTO ' + strTabela + ' VALUES ' + #13#10 + '   (';
    End
    Else
      strAux := '   (';

    For intCont := 0 To qryGen.Fields.Count - 1 Do
    Begin
      If (qryGen.Fields.Fields[intCont] is TFloatField) Then
        strAux := strAux + '"' + AnsiReplaceStr(qryGen.Fields.Fields[intCont].AsString, ',', '.') + '",'
      Else
        strAux := strAux + '"' + qryGen.Fields.Fields[intCont].AsString + '",'
    End;

    strAux[Length(strAux)] := ')';
    strAux := strAux + ',';

    qryGen.Next;

    If (qryGen.Eof) or ((qryGen.RecNo mod 500) = 0) Then
    Begin
      strAux[Length(strAux)] := ';';
    End;

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    Writeln(txtArqSaida, strAux);

  End;

  Writeln(txtArqSaida, 'UNLOCK TABLES;');
  Writeln(txtArqSaida, '/*!40000 ALTER TABLE ' + strTabela + ' ENABLE KEYS */;');
  Writeln(txtArqSaida, '');
  Writeln(txtArqSaida, '/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;');
  Writeln(txtArqSaida, '/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;');
  Writeln(txtArqSaida, '/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;');
  Writeln(txtArqSaida, '/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;');
  Writeln(txtArqSaida, '/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;');
  Writeln(txtArqSaida, '/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;');
  Writeln(txtArqSaida, '/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;');

  CloseFile(txtArqSaida);

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Backup da tabela ' + strTabela + ' gerado com sucesso!');
  End;


  Result := FileExists(strNomArq);
end;

function TTintaSincronizacao.fDownloadArquivo(): Boolean;
  Var
    blnResumir: Boolean;
    strNomArq: String;
    intCont: Integer;
begin
  strNomArq := strPat + '\' + strArqTinta + '.ZIP';

  If Not ForceDirectories(strPat) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('Não foi possivel criar a pasta %s', [strPat]), ['OK']);
    Exit;
  End;

  {*******************************************}
  {* CASO ARQUIVO JA EXISTA                  *}
  {****************************************PH*}
  If FileExists(strNomArq) And (ftpConexao.CanResume) Then
  Begin
    blnResumir := fMensagem('', Format('O arquivo %s já existe', [strNomArq]), ['Resumir', 'Sobrescrever']) = 1;
  End
  Else
    blnResumir := False;

  {*******************************************}
  {* OBTENDO O TAMANHO DO ARQUIVO            *}
  {****************************************PH*}
  Try
    intMaximoTransferencia := ftpConexao.Size(Format('/Tintas/%s/%s.ZIP', [strSiglaTinta, strArqTinta]));
  Except
    intMaximoTransferencia := 0;
  End;

  If intMaximoTransferencia = -1 Then
    intMaximoTransferencia := 0;

  If blnResumir Then
    intMinimoTransferencia := fVerificaTamanhoArquivo(strNomArq)
  Else
    intMinimoTransferencia := 0;

  If intMaximoTransferencia = 0 Then
  Begin
    If fMensagem('ATENÇÃO', 'Não foi possivel obter o tamanho do arquivo, deseja continuar?', ['SIM', 'NÃO']) = 2 Then
    Begin
      Result := False;
      Exit;
    End;
  End;


  {*******************************************}
  {* FAZENDO DOWNLOAD DO ARQUIVO CADSUV      *}
  {****************************************PH*}
  {********************************************************}
  {* EXEMPLO                                              *}
  {*  ftp://ftpcitel.no-ip.info/Tintas/Suv/SUV_CADBAS.ZIP *}
  {*****************************************************PH*}
  Try
    ftpConexao.Get(Format('/Tintas/%s/%s.ZIP', [strSiglaTinta, strArqTinta]), strNomArq, Not blnResumir, blnResumir);
  Except
    Result := False;
    fMensagem('ATENÇÃO', 'Não foi possivel fazer o download do arquivo!', ['OK']);
    Exit;
  End;

  {*******************************************}
  {* VERIFICANDO TAMANHO DO ARQUIVO          *}
  {****************************************PH*}
  If Not (fVerificaTamanhoArquivo(strNomArq) = intMaximoTransferencia)
    And (intMaximoTransferencia > 0) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', 'O tamanho do arquivo não está correto!', ['OK']);
    Exit;
  End;

  {**************************************************}
  {* EXTRAINDO OS ARQUIVOS PARA A PASTA CONFIGURADA *}
  {***********************************************PH*}
  If Not fExtrairArquivos(strNomArq, strPat) Then
  Begin
    Result := False;
    fMensagem('', 'Não foi possivel descompactar o arquivo', ['OK']);
    Exit;
  End;

  {************************************************************************************}
  {* CRIA OS BACKUPS ANTES DE FAZER AS IMPORTACOES, NAO DEIXAR CONTINUAR SEM O BACKUP *}
  {*********************************************************************************PH*}
  For intCont := 0 To stlArquivos.Count - 1 Do
  Begin
    If Not fCriarBackup(stlArquivos.Strings[intCont], strPat + '\BACKUP\BACKUP-' + stlArquivos.Strings[intCont] + FormatDateTime('YYYYMMDDHHNN', fNow()) + '.SQL') Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO', Format('Não foi possivel realizar o backup da tabela %s', [stlArquivos.Strings[intCont]]), ['OK']);
      Exit;
    End;
  End;

  Result := True;
end;

function TTintaSincronizacao.fExtrairArquivos(strArquivoZip,
  strDirExtra: String): Boolean;
  Var
    arqZip: TZipMaster;
begin
  arqZip := TZipMaster.Create(Self);                            // CRIA UM ZIPMASTER
  arqZip.Unattended := True;                                    // DESABILITA MENSAGENS
  arqZip.OnProgress := pProgressoExtracao;                      // LIGA O EVENTO
  arqZip.DLLDirectory := ExtractFileDir(Application.ExeName);   // DIRETORIO DA DLL

  If Not FileExists(ExtractFileDir(Application.ExeName) + '\UNZDLL.DLL') Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', 'Não foi possivel encontrar o arquivo UNZDLL.DLL', ['OK']);
    Exit;
  End;

  arqZip.ZipFileName := strArquivoZip;                    // ARQUIVO .ZIP
  intProgressoExtraxaoTamanho := fVerificaTamanhoArquivo(strArquivoZip) div 1024;
  arqZip.Load_Unz_Dll;                                    // CARREGA A DLL

  if arqZip.Count = 0 then                                // CASO NAO TENHA ARQUIVO
  begin
    Result := False;
    Exit;
  end;

  arqZip.FSpecArgs.Add('*.*');                            // ESPECIFICA OS ARQUIVOS PARA SEREM EXTRAIDOS (TODOS)
  arqZip.ExtrBaseDir := strDirExtra;                      // DIRETORIO PARA EXTRAIR
  arqZip.ExtrOptions := [ExtrOverWrite];                  // SOBRESCREVER ARQUIVOS

  arqZip.Extract;
  arqZip.Unload_Unz_Dll;                                  // DESCARREGA A DLL

  FreeAndNil(arqZip);
  Result := True;
end;

function TTintaSincronizacao.fMarcaDataHora: Boolean;
  Var
    txtArquivo: TextFile;
begin
  Result := True;
  If Not ForceDirectories(strPat) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('Não foi possivel criar a pasta %s', [strPat]), ['OK']);
    Exit;
  End;

  AssignFile(txtArquivo, strPat + '\' + strArqTinta + '_ATU');
  Rewrite(txtArquivo);
  Writeln(txtArquivo, Format('Ultima atualização realizada em %s', [DateTimeToStr(fNow())]));
  CloseFile(txtArquivo);
end;

function TTintaSincronizacao.fProcessaArquivos(): Boolean;
begin
  Result := True;
  case intOpcao of
    1:
      {*******************************************}
      {* EXPORTACAO DE ARQUIVOS                  *}
      {****************************************PH*}
      Begin
        {*******************************************}
        {* EXOPRTACAO DO CADASTRO DE TINTAS        *}
        {****************************************PH*}

        If Not fExportaArquivos Then
        Begin
          Result := False;
          Exit;
        End;

      End;
    2:
      Begin

        {*******************************************}
        {* CONECTANDO NO SERVIDOR FTP              *}
        {****************************************PH*}
        If Not fConectarFTP Then
        Begin
          Result := False;
          Exit;
        End;
        {*******************************************}
        {* FAZENDO O DOWNLOAD DO ARQUIVO           *}
        {****************************************PH*}
        If Not fDownloadArquivo Then
        Begin
          Result := False;
          Exit;
        End;

        {*******************************************}
        {* PROCESSANDO CADASTRO DE BASES           *}
        {****************************************PH*}
        If Not fImportaArquivos Then
        Begin
          Result := False;
          Exit;
        End;

        {*****************************************************}
        {* GERA UM ARQUIVO SOMENTE PARA MARCAR A DATA E HORA *}
        {**************************************************PH*}
        fMarcaDataHora;
      End;
  End;
end;

function TTintaSincronizacao.fVerificaTamanhoArquivo(
  strNomArq: String): Int64;
  Var
    arqGen: Integer;
begin
  arqGen := FileOpen(strNomArq, fmOpenRead);
  Result := FileSeek(arqGen, 0, 2);
  FileClose(arqGen);
end;

procedure TTintaSincronizacao.pOnScrollDatSet(DataSet: TDataSet);
begin
  If Assigned(FRegistraProgresso) And (DataSet.RecordCount > 1) Then
  Begin
    FRegistraProgresso(1, DataSet.RecNo, DataSet.RecordCount);

  End;
end;

procedure TTintaSincronizacao.pProgressoExtracao(Sender: TObject;
  ProgrType: ProgressType; Filename: string; FileSize: Integer);
begin
  {*******************************************}
  {* EXTRACAO DE UM ARQUIVO NOVO             *}
  {****************************************PH*}
  If ProgrType = NewFile Then
  Begin
    If Assigned(FRegistraAcao) Then
    Begin
      FRegistraAcao(Format('Extraindo arquivo %s', [Filename]));
    End;
  End;

  {*******************************************}
  {* ESTA NO MEIO DA EXTRACAO                *}
  {****************************************PH*}
  If ProgrType = ProgressUpdate Then
  Begin
    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, intProgressoExtracao, intProgressoExtraxaoTamanho);
      intProgressoExtracao := intProgressoExtracao + 1;
    End;
  End;

  {*******************************************}
  {* ESTA NO FIM DE UMA EXTRACAO             *}
  {****************************************PH*}
  If ProgrType = EndOfBatch Then
  Begin
    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, FileSize, FileSize);
      intProgressoExtracao := 0;
    End;
  End;
end;

procedure TTintaSincronizacao.pRegistraFimDownload(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  If Assigned(FRegistraProgressoDownload) then
  Begin
    FRegistraProgressoDownload(1, intMaximoTransferencia, intMaximoTransferencia);
  End;
end;

procedure TTintaSincronizacao.pRegistraInicio(Sender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
//  If Assigned(FRegistraAcao) Then
//  Begin
//    FRegistraAcao(ftpConexao.Greeting.Text.Text);
//  End;
end;

procedure TTintaSincronizacao.pRegistraProgresso(Sender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  If Assigned(FRegistraProgressoDownload) then
  Begin
    FRegistraProgressoDownload(1, intMinimoTransferencia + AWorkCount, intMaximoTransferencia);
  End;
end;

procedure TTintaSincronizacao.pRegistraStatus(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: String);
begin
  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao(AStatusText);
  End;
end;

function TTintaSincronizacao.fDataUltimaAtualizacao(
  var dtaUltAtu: TDateTime; strArqTinta: String; strPat: String): Boolean;
begin
  Result := FileExists(strPat + '\' + strArqTinta + '_ATU');

  If Result Then
  Begin
    dtaUltAtu := FileDateToDateTime(FileAge(strPat + '\' + strArqTinta + '_ATU'));
  End;
end;

end.
