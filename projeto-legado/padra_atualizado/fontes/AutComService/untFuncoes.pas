unit untFuncoes;

interface

Uses Winapi.Windows, Uni, System.Classes, System.SysUtils, Vcl.Forms, StrUtils,
Dialogs, IniFiles, System.UITypes, WinSock, Data.DB, System.IOUtils;

  Const STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*';

  procedure pLog(const AText: string); overload;
  procedure pLog(const AFile, AText: string); overload;

  function fCrypt(strSenha: String): String;
  function fDecrypt(strSenha: String): String;
  function fAbrirBanco(Database: TUniConnection; strArqIni : String = '') : Boolean;
  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
  function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True): String;
  function fRetEmpresaFisica(): String;
  function fCriarProcesso(strArquivo, strDir: string; blnTrava: Boolean; blnMaximizado: Boolean=True; blnHide: Boolean=False): boolean;
  function fGetConnectionID: String;
  function GetIPAddressAsString: String;
  function GetMacAddress: String;
  function GetComputerNetName: string;
  function GetUserFromWindows: string;
  function fRetOrigemLock(strNomeTabela: String): String;
  function GetIPAddress: Integer;
  function GetProcessId: String;
  function fRetAutoIncrem(ATabela, AEmpresa: string): string;
  procedure pZerarTentativasLock(strNomeTabela: String; blnLike: boolean = true);
  function fGetIdConnectionLock(strNomeTabela: String; blnLike: boolean = True): String;
  function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;
  function fLock_Unlock(strNomeTabela: String;
                        blnTrava: Boolean;
                        blnLoopTravamento: Boolean = True;
                        blnHourGlass: Boolean = FALSE;
                        strCon_Id: String = '';
                        blnMostraMsgTravamento: Boolean = True;
                        strOrigem: String = '';
                        blnManual: Boolean = False): Boolean;
  function GetParamValue(AParamID: String): String;
  function HasParam(AParamID: String): Boolean;

implementation

{***********************************}

uses untPrincipal;
{* Abrir Banco de Dados do Sistema *}
{********************************DV*}
function fAbrirBanco(Database: TUniConnection; strArqIni : String) : Boolean;
  Var
    qryGen: TUniQuery;
    intCodAut: Integer;
    blnReconectar: Boolean;

    libUtil: Cardinal;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;
    pSetaArquivoOpcoesPChar: procedure (PAnsiChar: String); stdcall;

  {******************************************************************************}
  {* QUANDO O AUTCOM … EXECUTADO ATRAV…S DO AGENDADOR DE TAREFAS, A FUN«√O:     *}
  {* FileExists('libUtil.dll') N√O FUNCIONA, RETORNA QUE N√O ENCONTRA O ARQUIVO,*}
  {* POR ISSO SE FAZ NECESS¡RIO PASSAR O CAMINHO COMPLETO! REQ: 21251           *}
  {***************************************************************************RN*}
  function fPathExe: String;
  begin
    Result := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  end;

  {*****************************************}
  {* VERIFICA SE IR¡ UTILIZAR A SENHA DA   *}
  {* DLL.                                  *}
  {**************************************MV*}
  function fUsarSenhaDLL: Boolean;
  begin
    Result := (intCodAut > 0) And (FileExists(fPathExe + 'libUtil.dll'));
  end;

  {*****************************************}
  {* EFETUA A CONEX√O COM O BANCO.         *}
  {**************************************MV*}
  procedure pConectar;
  begin
    Database.Disconnect;
    Database.Database := '';
    Database.Server   := '';

    If fUsarSenhaDLL Then
    Begin
      libUtil := LoadLibrary(PChar(fPathExe + 'libUtil.dll'));
      Try
        pSetaArquivoOpcoesPChar := GetProcAddress(libUtil, PChar('pSetaArquivoOpcoesPChar'));
        pSetaArquivoOpcoesPChar(PChar( ReplaceStr(strArqIni, '\', '\\') ));

        fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
        fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));

        Database.Username := String(fRetornaUsuario);
        Database.Password := String(fRetornaSenha);
      Except
        On E : Exception Do
          Raise e;
      End;
      FreeLibrary(libUtil);
    End
    Else
    Begin
      Database.Username := 'root';
      Database.Password := 'citel13347';
    End;

    Database.Server   := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP','', strArqIni), ' ', '');
    Database.Database := fArqIni(0,'BANCO','NOMBAN','', strArqIni);

    If Not fEmptyStr(fArqIni(0,'BANCO','PORTA','', strArqIni)) Then
      Database.Port := StrToInt(AnsiReplaceStr(fArqIni(0,'BANCO','PORTA','3306', strArqIni), ' ', ''));

    Database.Connect;
  End;

  {*****************************************}
  {* MOSTRA MSG DE ERRO.                   *}
  {**************************************MV*}
  procedure pMsgErro(E: Exception);
  begin
    ShowMessage('Abertura do Banco de Dados: ' + E.Message + #13#10#13#10 + 'Verifique o opcoes.ini!');
    Result := False;
  end;

begin
  Result := True;
  blnReconectar := False;
  intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0', strArqIni), 0);

  Try
    pConectar;
  Except
    On E: EUniError Do
    Begin
      pMsgErro(E);
      Exit;
    End;
    On E : Exception Do
    Begin
      pMsgErro(E);
      Exit;
    End;
  End;

  {*****************************************}
  {* A SENHA ESTAVA INCORRETA IR¡ TENTAR   *}
  {* COM A OUTRA SENHA.                    *}
  {**************************************MV*}
  If blnReconectar Then
  Begin
    Try
      pConectar;
    Except
      On E: Exception Do
      Begin
        pMsgErro(E);
        Exit;
      End;
    End;
  End;

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

      SQL.Clear;
      SQL.Add('SET sql_mode = ""');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET group_concat_max_len = 3072');
      ExecSQL;
    End;

  Except
    On E : Exception Do
    Begin
      ShowMessage(E.Message);
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
end;


{*****************************}
{* DESCRIPTA UMA STRING      *}
{**************************DV*}
function fDecrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
  Result := '';
  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1),'ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£');
    Result := Result + MidStr(STR_CHAR_SENHA, intCl1,1);
  End;
end;


{*****************************}
{* CRIPTA UMA STRING         *}
{**************************DV*}
function fCrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
	Result := '';
  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1), STR_CHAR_SENHA);
    Result := Result + MidStr('ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£',intCl1,1);
  End;
end;

{**********************************************************}
{* LÍ/Grava dados no arquivo de Configuracao (Opcoes.ini) *}
{*******************************************************DV*}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := ExtractFilePath(Application.ExeName) + 'opcoes.ini';
  iniArqIni := TIniFile.Create(strNomArq);
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

{**************************************}
{*  VERIFICA SE UMA STRING ESTA VAZIA *}
{***********************************MV*}
function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
begin
  If blnTiraCaracEspecial Then
    strString := fTiraCaracEspeciais(strString, True, True, True, True, True);
  Result := False;
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');
  If AnsiReplaceText(strString, ' ', '') = '' Then
    Result := True;
end;

{**************************************}
{* CRIA UMA QUERYNOVA PARA SER USADA  *}
{* PS. ATE QUE ENFIM ALGUEM FEZ ISSO  *}
{***********************************AF*}
function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
Begin

  Result := TUniQuery.Create(AOwner);

  If Assigned(Conexao) Then
    Result.Connection := Conexao
  Else
    Result.Connection := frmAutcomSvc.Database;

  Result.Options.RequiredFields := False;

End;

function fTiraCaracEspeciais(strTexto      : String;
                             blnUsaLista   : Boolean = True;
                             blnTiraEspacos: Boolean = False;
                             blnTiraPontos : Boolean = False;
                             blnTiraDoisPts: Boolean = False;
                             blnTiraTab    : Boolean = False;
                             blnTiraVirgula: Boolean = True): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*™∫∞&"''()%$®@!?ß={}[]¥`^~π≤≥£¢ÿ'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos) Then
    strLista := strLista + ' ';

  If (blnTiraPontos) Then
    strLista := strLista + '.';

  If (blnTiraDoisPts) Then
    strLista := strLista + ':';

  If (blnTiraTab) Then
    strLista := strLista + #9;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸Á¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹«';

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

function fCriarProcesso(strArquivo, strDir: string; blnTrava: Boolean; blnMaximizado: Boolean=True; blnHide: Boolean=False): boolean;
  Var
    StartInfo: TStartupInfo;
    ProceInfo: TProcessInformation;
    intWait  : Integer;
begin
  pLog('Executando ' + strArquivo + ' em ' + strDir);

  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb          := 2048;//SizeOf(StartInfo);
  StartInfo.dwFlags     := STARTF_USESHOWWINDOW;

  If Not blnHide Then
  Begin
    If blnMaximizado Then
      StartInfo.wShowWindow := SW_SHOWMAXIMIZED
    Else
      StartInfo.wShowWindow := SW_SHOWNORMAL;
  End
  Else
    StartInfo.wShowWindow := SW_HIDE;

  Result := CreateProcess(Nil,
                          PChar(strArquivo),
                          Nil,
                          Nil,
                          False,
                          NORMAL_PRIORITY_CLASS,
                          Nil,
                          PChar(strDir),
                          StartInfo,
                          ProceInfo);

  If (Result) Then
  Begin
    If blnTrava Then //Espera finalizaÁ„o para continuar
    Begin
      Repeat
        if Application.Terminated then
          Break;

        intWait:= WaitForSingleObject(ProceInfo.hProcess, 0);

        Application.ProcessMessages;
        Sleep(500);

      Until intWait <> WAIT_TIMEOUT;

    End;

    CloseHandle(ProceInfo.hProcess);
    CloseHandle(ProceInfo.hThread);
  End;
end;

function GetProcessId : String;
var
  intProcessId : Integer;
begin
  Result := '';

  intProcessId := GetCurrentProcessId;

  if intProcessId > 0 then
    Result := IntToStr(intProcessId);
end;

function fLock_Unlock(strNomeTabela: String;
                      blnTrava: Boolean;
                      blnLoopTravamento: Boolean = True;
                      blnHourGlass: Boolean = FALSE;
                      strCon_Id: String = '';
                      blnMostraMsgTravamento: Boolean = True;
                      strOrigem: String = '';
                      blnManual: Boolean = False): Boolean;
  Var
    strLock: String;
    qryLock_Unlock: TUniQuery;
  Const
    TEMPO_ESPERA = 3000;

    procedure pAtualizaContador;
    begin
      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_TENTAT = LCK_TENTAT + 1 WHERE LCK_CHAACE = :CHAACE');
      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;
      qryLock_Unlock.ExecSQL;
    end;

    procedure pIncrementaTrava(blnIncrementa: Boolean);
    begin
      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      If blnIncrementa Then
        qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA + 1 WHERE LCK_CHAACE = :CHAACE')
      Else
        qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA - 1 WHERE LCK_CHAACE = :CHAACE');

      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;
      qryLock_Unlock.ExecSQL;
    end;

    function fExecutaLock: Boolean;
    begin

      Result := False;

      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      qryLock_Unlock.SQL.Add(strLock);
      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;

      qryLock_Unlock.ParamByName('DTALCK').AsDate   := Now;
      qryLock_Unlock.ParamByName('HRALCK').AsTime   := Time;
      qryLock_Unlock.ParamByName('CON_ID').AsString := IfThen(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);
      qryLock_Unlock.ParamByName('NUM_IP').AsString := GetIPAddressAsString;
      qryLock_Unlock.ParamByName('MACADD').AsString := GetMacAddress;
      qryLock_Unlock.ParamByName('NOMMAQ').AsString := GetComputerNetName;
      qryLock_Unlock.ParamByName('NOMUSU').AsString := GetUserFromWindows;
      qryLock_Unlock.ParamByName('CODOPE').AsString := '999';
      qryLock_Unlock.ParamByName('ORIGEM').AsString := strOrigem;
      qryLock_Unlock.ParamByName('QTDTRA').AsInteger:= 1;

      Try
        qryLock_Unlock.ExecSQL;
        Result := True;
      Except
        On E: Exception Do
        Begin
          If (Pos('DUPLICADA', UpperCase(E.Message)) > 0) Or
             (Pos('DUPLICATE', UpperCase(E.Message)) > 0) Then
          Begin
            pAtualizaContador;

            If (Not fEmptyStr(strOrigem)) And
               SameText(fRetOrigemLock(strNomeTabela), strOrigem) Then
            Begin
              pIncrementaTrava(True);
              Result := True;
            End;

          End
          Else
            Raise Exception.Create(E.Message);
        End;
      End;

    end;

    procedure pGravaLogLock;
    begin
      With qryLock_Unlock Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO LCKATC_LOG (LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_TENTAT, ');
        SQL.Add('  LCK_ORIGEM, LCK_DTALOG, LCK_HRALOG, LCK_TIPLCK, LCK_MACADD, LCK_NOMMAQ, LCK_NOMUSU) ');
        SQL.Add('VALUES (:NUM_IP, :CON_ID, :CHAACE, :CODOPE, :QTDTRA, :ORIGEM, ');
        SQL.Add('        :DTALOG, :HRALOG, :SIGLA, :MACADD, :NOMMAQ, :NOMUSU) ');
        ParamByName('CHAACE').AsString := strNomeTabela;
        ParamByName('DTALOG').AsDate   := Now;
        ParamByName('HRALOG').AsTime   := Time;
        ParamByName('CON_ID').AsString := IfThen(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);
        ParamByName('NUM_IP').AsString := GetIPAddressAsString;
        ParamByName('CODOPE').AsString := '999';
        ParamByName('ORIGEM').AsString := strOrigem;
        ParamByName('SIGLA').AsString  := IfThen(blnTrava, 'LCK', IfThen(blnManual,'LBM','LBA'));
        ParamByName('MACADD').AsString := GetMacAddress;
        ParamByName('NOMMAQ').AsString := GetComputerNetName;
        ParamByName('NOMUSU').AsString := GetUserFromWindows;
        ParamByName('QTDTRA').AsInteger:= 1;
        ExecSQL;
      End;

    end;

    function fGravaLog: Boolean;
    begin
      Result := (Pos('EXECUTE_', strNomeTabela) <= 0) And
                (Pos('IMPORTACAO-', strNomeTabela) <= 0) And
                (Pos('TESTE_', strNomeTabela) <= 0) And
                (Pos('TEST_', strNomeTabela) <= 0) And
                (Pos('MONITOR_', strNomeTabela) <= 0) And
                (Pos('UPDATE_', strNomeTabela) <= 0) And
                (Pos('UPDATE_', strNomeTabela) <= 0);
    end;

Begin


  Try

    If blnHourGlass Then
      Screen.Cursor := crHourGlass;

    strNomeTabela := frmAutcomSvc.Database.Database + '.' + strNomeTabela;
    qryLock_Unlock := fCriaQuery(Nil);


    Result := True;
    If blnTrava Then
    Begin

      strLock := 'INSERT INTO LCKATC (LCK_DTALCK, LCK_HRALCK, LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_ORIGEM, LCK_QTDTRA,LCK_MACADD,LCK_NOMMAQ,LCK_NOMUSU) ' +
                 'VALUES (:DTALCK, :HRALCK, :NUM_IP, :CON_ID, :CHAACE, :CODOPE, :ORIGEM, :QTDTRA,:MACADD,:NOMMAQ,:NOMUSU)';

      With qryLock_Unlock Do
      Begin

        While Not fExecutaLock Do
        Begin

          If (Not blnLoopTravamento) Then
          Begin
            Result := False;
            Break;
          End;

          If blnMostraMsgTravamento Then
          Begin
            ShowMessage('O arquivo ' + strNomeTabela + ' est· sendo ' +
                        'utilizado no momento.' + #13#10 +
                        'Aguarde LiberaÁ„o!' );
          End;

          Sleep(TEMPO_ESPERA);
          Application.ProcessMessages;
        End;

        If Result And fGravaLog Then
          pGravaLogLock;

        Close;
      End;
    End
    Else
    Begin

      If fEmptyStr(strOrigem) Then
        strLock := 'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_CON_ID = :CON_ID'
      Else
      Begin
        pIncrementaTrava(False);
        strLock := 'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_QTDTRA <= 0';
      End;

      With qryLock_Unlock Do
      Begin
        If fGravaLog Then
          pGravaLogLock;

        Close;
        SQL.Clear;
        SQL.Add(strLock);
        ParamByName('CHAACE').AsString := strNomeTabela;

        If fEmptyStr(strOrigem) Then
          ParamByName('CON_ID').AsString := IfThen(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);

        ExecSQL;
        Close;
      End;
    End;

    FreeAndNil(qryLock_Unlock);

    If blnHourGlass Then
      Screen.Cursor := crDefault;
  Finally
  End;

End;

function fGetConnectionID: String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);

  Try

    qryAux.SQL.Add('SELECT CONNECTION_ID()');
    qryAux.Open;

    Result := qryAux.Fields[0].AsString;

  Finally
    FreeAndNil(qryAux);
  End;

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

function fRetOrigemLock(strNomeTabela: String): String;
  Var
    qryLock: TUniQuery;
Begin
  qryLock := fCriaQuery(Nil);
  With qryLock, SQL Do
  Begin
    Add('SELECT LCK_ORIGEM FROM LCKATC WHERE LCK_CHAACE = :CHAACE');
    ParamByName('CHAACE').AsString := strNomeTabela;
    Open;
    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('LCK_ORIGEM').AsString;
  End;
  FreeAndNil(qryLock);
End;

function fRetEmpresaFisica(): String;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Nil);
  With qryGen, SQL Do
  Begin
    Add('SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER"');
    Open;
    Result := FieldByName('PRO_CODEMP').AsString;
  End;
  FreeAndNil(qryGen);
end;

function fRetAutoIncrem(ATabela, AEmpresa: string): string;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery(Nil);
  With qryGen, SQL Do
  Begin
    Add('SELECT fRetAutoIncrem("' + ATabela + '", "' + AEmpresa + '") AS AUTINC');
    Open;
    Result := FieldByName('AUTINC').AsString;
  End;
  FreeAndNil(qryGen);
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

function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  Result := '';

  strNomeTabela := frmAutcomSvc.Database.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  If blnSohIP Then
    strSQL := strSQL + '  LCK_NUM_IP '
  Else
    strSQL := strSQL + '  CONCAT(LCK_NUM_IP, " - ", " Operador: ", LCK_CODOPE, "-", OPE_NOMOPE) AS LCK_NUM_IP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = LCK_CODOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE LIKE :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_NUM_IP').AsString;

  FreeAndNil(qryGen);
End;

function fGetIdConnectionLock(strNomeTabela: String; blnLike: boolean = True): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
    strOperador : string;
Begin
  Result := '';
  strNomeTabela := frmAutcomSvc.Database.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;
  try
    strOperador := IfThen(blnLike And strNomeTabela.Contains('%'), 'LIKE', '=');
    strSQL := strSQL + '';
    strSQL := strSQL + ' SELECT LCK_CON_ID ';
    strSQL := strSQL + '   FROM LCKATC ';
    strSQL := strSQL + '  WHERE LCK_CHAACE ' + strOperador + ' :CHAACE ';
    qryGen.SQL.Text := strSQL;
    qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
    qryGen.Open;
    Result := qryGen.FieldByName('LCK_CON_ID').AsString;
    qryGen.Close;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure pZerarTentativasLock(strNomeTabela: String; blnLike: boolean = true);
  Var
    qryGen: TUniQuery;
    strSQL: String;
    strOperador : string;
Begin
  strNomeTabela := frmAutcomSvc.Database.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;
  try
    strOperador := IfThen(blnLike And strNomeTabela.Contains('%'), 'LIKE', '=');
    strSQL := strSQL + '';
    strSQL := strSQL + 'UPDATE LCKATC SET  ';
    strSQL := strSQL + '  LCK_TENTAT = 0 ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LCK_CHAACE ' + strOperador + ' :CHAACE ';
    qryGen.SQL.Text := strSQL;
    qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
    qryGen.ExecSQL;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure pLog(const AText: string);
const
  LOG_FILE = '.\AutcomSvc.log';
begin
  pLog(LOG_FILE, AText);
end;

procedure pLog(const AFile, AText: string);
begin
  if not FileExists(AFile) then
    Exit;
  TFile.AppendAllText(AFile, DateTimeToStr(Now()) + ' - ' +
    IntToStr(GetCurrentProcessId) + ' - ' + AText + sLineBreak,
    TEncoding.UTF8);
end;

function GetParamValue(AParamID: String): String;
Var
  I: Integer;
begin
  Result := '';
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID) then
      exit(ReplaceStr(ParamStr(I), AParamID, ''));
end;

function HasParam(AParamID: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID) then
      exit(True);
end;

initialization
  EnableUniSQL := False;

end.
