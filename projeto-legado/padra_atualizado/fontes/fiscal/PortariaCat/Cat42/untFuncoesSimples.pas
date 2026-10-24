unit untFuncoesSimples;

interface

Uses Windows,
     Forms,
     Classes,
     SysUtils,
     StrUtils,
     Uni,
     PsAPI,
     IniFiles,
     AnsiStrings,
     untITSQLTrace,
     RegularExpressions,
     untModulo,
     untFuncoes,
     UniSQLMonitor,
     DASQLMonitor,
     DBAccess,
     untLogSQL,
     madStackTrace,
     MemoFocus,
     ShellApi,
     Messages,
     IdMessage,
     Dialogs,
     untTypesSistema,
     Registry,
     untIFuncoesCXGrid,
     untClassPanelCx,
     untConstantes;

const
  STR_SQL_NAO_REPLICAR = '/* SQL_NAO_REPLICAR */';
  SQL_TESTE_LOG_REPLICACAO = 'SET @TESTE_LOG_REPLICACAO := "EXECUTANDO TESTE LOGREP";';
  arrRep1: Array[0..13] Of String = ('INSERT', 'REPLACE', 'DELETE FROM', 'UPDATE', 'SET FOREIGN_KEY_CHECKS', 'CREATE TEMPORARY TABLE ESTANT', 'DROP TABLE IF EXISTS ESTANT',
                                     'CREATE TABLE TMP_NOVOITEEMB', 'CREATE TABLE TMP_NOVOITEGER', 'CREATE TABLE TMP_NOVOACAGER', 'CREATE TABLE TMP_NOVOCFGREL',
                                     'CREATE TABLE TMP_NOVOCNFBOL', 'CREATE TABLE TMP_NOVOLAYETI', 'CREATE TABLE TMP_NOVOCADLOT');
  arrRep2: Array[0..13] Of String = (' INTO ', ' INTO ' , ''           , ' SET ' , ''                      , '',                              '',
                                     '',  '', '', '',
                                     '',  '', '');
  ERROR_USUARIO_SENHA_INV =  1045;
  SEN_CNF = '13347';

var
  VS_Trace: ITSQLTrace;
  VS_intUsaLogSql: Integer;
  VS_MinRowLogSql: Integer;
  VS_strTabelaErro: String;
  VS_MemoLogTrace : TMemoFocus;

  {function}
  function fIniciaLogTrace: Boolean;
  function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True): String;
  function fTiraEnter(strTexto: String): String;
  function fTiraEspacos(strTexto: String): String;
  function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fRetornaNomeTabela(strString: String): String;
  function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
  function fCurrentTime: String;
  function fRetHoraServidor: TTime;
  function fTrimAll(strTexto: String): String;
  function fRetornaStack: String;

  procedure ShowDebugFormTrace(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent;
    SQL: string; Params: TDAParams; Caption: string);
	procedure pAbrirBanco(Database: TUniConnection);
	procedure pFecharBanco(Database: TUniConnection);
  procedure pExecArquivo(strArquivo: String; Handle: THandle);
  procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm:TDataModule);

  {function fGetFuncoesCxGrid: IFuncoesCXGrid; StdCall; External 'libFuncoes.dll' delayed;
  function fConsulta(arrSql,
                     arrCampos,
                     arrOrdenacao: Array Of String;
                     strCampoChave,
                     strTabela,
                     strNomForm,
                     strTitulo: String;
                     qryAux: TUniQuery;
                     objFrmPnl: TPanelCx;
                     blnSimples: Boolean;
                     Var arrSelec: TConsultasArray;
                     strCodBusca: String = 'AUTOINCREM';
                     objConsulta: Pointer = Nil;
                     blnTablet: Boolean = False;
                     blnConIte: Boolean = False;
                     strCampoChave2 : String = '';
                     pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                     blnRefresh: Boolean = True;
                     blnConfirma: boolean = True;
                     blnConCon: Boolean = True;
                     fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                     objPnlBanner: TPanelCx = Nil;
                     objPnlPreFiltro: TPanelCx = Nil;
                     _Application : TApplication = Nil;
                     pBeforeAtualiza: TGenericProcedureWithClientParamAndVar = Nil): Boolean; StdCall; External 'libFuncoes.dll' delayed;
  }
  procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  procedure pFreeAndNil(var frmForm);
  procedure pConfiguraOpcoesRegionais;

implementation


function fIniciaLogTrace: Boolean;
  var
    intCnt : Integer;
begin
  Result := False;
  for intCnt := 1 To ParamCount Do
  begin
    Result := SameText(ParamStr(intCnt), 'logtrace');
    if Result then
      Break;
  end;
end;

function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
begin
  If blnTiraCaracEspecial Then
    strString := fTiraCaracEspeciais(strString, True, True, True, True, True);

  Result := False;
  strString := fTiraEnter(strString);

  If fTiraEspacos(strString) = '' Then
    Result := True;
end;

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
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢Ø'
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

end;

function fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

function fTiraEspacos(strTexto: String): String;
begin
  Result := fTrocaCaracter(strTexto, ' ', #0);
end;

function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
  Var
    c: Char;
begin
  Result := '';
  for c in strTexto do
    if (c <> chrFrom) then
      Result := Result + c
    Else If chrTo <> #0 Then
      Result := Result + chrTo;
end;

function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'opcoes.ini';

  iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + strNomArq);
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function fRetornaNomeTabela(strString: String): String;
  Var
    strTmp     : String;
    intPosicao : Integer;
    intContador: Integer;
Begin
  strString := AnsiUpperCase(Trim(strString));

  If Length(strString) > 1000 Then
  Begin
    Result := fRetornaNomeTabela(LeftStr(strString, 1000));
    If Result <> '' Then
      Exit;
  End;

  Result     := '';
  intPosicao := 0;

  If LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End;

  If (intPosicao > 0) Then
  Begin
    strTmp := fTrocaCaracter(strTmp,'(', ' ');
    strTmp := fTrocaCaracter(strTmp,')', ' ');
    strTmp := fTrocaCaracter(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;
End;

function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
begin
  Result := True;

  {***************************************************}
  {* NÃO REPLICA A TABNRE!!!!                        *}
  {** 09/06/2008 - 09:54 **************************MV*}
  {** 09/06/2009 - 17:47 **************************JB*}
  {** 13/02/2013 - ********************************JU*}
  If (strNomTabela = 'TABNRE')         Or
     (strNomTabela = 'LOGREP')         Or
     (strNomTabela = 'USUREP')         Or
     (strNomTabela = 'LOGERR')         Or
     (strNomTabela = 'LCKATC')         Or
     (strNomTabela = 'AUXCFG')         Or
     (strNomTabela = 'TAGDIR')         Or
     (strNomTabela = 'LOGSQL')         Or
     (strNomTabela = 'CADBCO')         Or
     (strNomTabela = 'INFSIS')         Or
     (strNomTabela = 'PROINC')         Or
     (strNomTabela = 'PROCOD')         Or
     (strNomTabela = 'DICSIS')         Or
     (strNomTabela = 'NFE_NFEPRINTER') Or
     (strNomTabela = 'NFE_TEMPO')      Or
     (strNomTabela = 'NFE_LOCAL')      Or
     (strNomTabela = 'LOGACE')         Or
     (strNomTabela = 'LOGFRM')         Or
     (strNomTabela = 'LOGTMR')         Or
     (strNomTabela = 'LOGTHR')         Or
     (strNomTabela = 'MNUACE')         Or
     (strNomTabela = 'CONDET')         Or
     (strNomTabela = 'PCMGER_RES')     Or
     (strNomTabela = 'PCMDET_RES')     Or
     (strNomTabela = 'PCDDET_RES')     Or
     (strNomTabela = 'PCMIRQ_RES')     Or
     (strNomTabela = 'TRANSACOES')     Then
  Begin
    Result := False;
  End;
end;

function fRetHoraServidor: TTime;
var
  qryCons: TUniQuery;
begin
  Result := 0;
  qryCons := fCriaQuery(Nil);
  Try
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURRENT_TIME');
      Open;

      Result := FieldByName('CURRENT_TIME').AsDateTime;
    End;
  Finally
    If Result = 0 Then
      Result := fTime();
    FreeAndNil(qryCons);
  End;
end;

function fTrimAll(strTexto: String): String;
  Var
    c: Char;
    l: Char;
begin
  l := #0;
  Result := '';

  for c in strTexto do
  begin
    if (c = ' ') and (l = ' ') then
      continue;
    l := c;
    Result := Result + c;
  end;

  Result := Trim(Result);
end;

function fRetornaStack: String;
{$IFDEF LINUX}
begin
  Result := EmptyStr;
end;
{$ELSE}
var
  stlTrack: TStringList;
begin
  stlTrack := Nil;
  Try
    Try
      stlTrack := TStringList.Create;
      stlTrack.Text := madStackTrace.StackTrace();
      Result := stlTrack.Text;
    Except
      On E: Exception Do
        Result := '<stack indisponível>';
    End;
  Finally
    If Assigned(stlTrack) Then
      FreeAndNil(stlTrack);
  End;
end;
{$ENDIF}

procedure ShowDebugFormTrace(DASQLMonitorClass: TDASQLMonitorClass;
  Component: TComponent; SQL: string; Params: TDAParams; Caption: string);

  Var
    strString: String;

  procedure pAdd(strVal: String);
  begin
    strString := strString + IfThen(fEmptyStr(strString), '', #13#10) + strVal;
  end;

  function fArrPos(arrSearch: Array Of String; strString: String): Boolean;
  Var
    strPart: String;
  begin
    Result := False;

    For strPart In arrSearch Do
    Begin
      If Pos(strPart, strString) > 0 Then
        Result := True;
    End;
  end;

  function fFormataStack(strStack: String): String;
  Var
    stlStack, stlOrigem, stlUnit, stlLinha, stlRotina : TStringList;
    i, intOrigem, intUnit, intLinha, intRotina : Integer;
  begin
    stlStack  := TStringList.Create;
    stlOrigem := TStringList.Create;
    stlUnit   := TStringList.Create;
    stlLinha  := TStringList.Create;
    stlRotina := TStringList.Create;

    intOrigem := 0;
    intUnit   := 0;
    intLinha  := 0;
    intRotina := 0;

    Try
      stlStack.Text := strStack;

      // Apaga a primeira e segunda linha pois são do trace
      stlStack.Delete(stlStack.Count - 1);
      stlStack.Delete(stlStack.Count - 1);

      For i := stlStack.Count - 1 DownTo 0 Do
      Begin
        if (Pos(' unt', stlStack[i]) > 0) then
        begin
          stlStack[i] := Trim(Copy(stlStack[i], Pos(' ', stlStack[i]), Length(stlStack[i])));

          stlOrigem.Add(Copy(stlStack[i], 1, Pos(' ', stlStack[i]) - 1));

          stlStack[i] := Trim(Copy(stlStack[i],
            Pos(' ', stlStack[i]), Length(stlStack[i])));

          stlUnit.Add(Copy(stlStack[i], 1, Pos(' ', stlStack[i]) - 1));

          stlStack[i] := Trim(Copy(stlStack[i],
            Pos(' ', stlStack[i]), Length(stlStack[i])));

          stlLinha.Add(Copy(stlStack[i], 1, Pos(' ', stlStack[i]) - 1));

          stlStack[i] := Trim(Copy(stlStack[i],
            Pos(' ', stlStack[i]), Length(stlStack[i])));

          stlRotina.Add(Copy(stlStack[i], 1, Length(stlStack[i])));

          if (intOrigem < Length(stlOrigem[stlOrigem.Count - 1])) then
            intOrigem := Length(stlOrigem[stlOrigem.Count - 1]);

          if (intUnit < Length(stlUnit[stlUnit.Count - 1])) then
            intUnit := Length(stlUnit[stlUnit.Count - 1]);

          if (intLinha < Length(stlLinha[stlLinha.Count - 1])) then
            intLinha := Length(stlLinha[stlLinha.Count - 1]);

          if (intRotina < Length(stlRotina[stlRotina.Count - 1])) then
            intRotina := Length(stlRotina[stlRotina.Count - 1]);
        end;
      End;

      // Inverte a ordem
      stlStack.Clear;

      if (intOrigem < Length('Executável/DLL')) then
        intOrigem := Length('Executável/DLL');

      if (intUnit < Length('Unit')) then
        intUnit := Length('Unit');

      if (intLinha < Length('Linha')) then
        intLinha := Length('Linha');

      if (intRotina < Length('Rotina')) then
        intRotina := Length('Rotina');

      stlStack.Add(fPadR('Executável/DLL', intOrigem) + ' ' +
                   fPadR('Unit', intUnit) + ' ' +
                   fPadR('Linha', intLinha) + ' ' +
                   fPadR('Rotina', intRotina));

      For i := 0 To stlOrigem.Count - 1 Do
      Begin
        stlStack.Add(fPadR(stlOrigem[i], intOrigem) + ' ' +
                     fPadR(stlUnit[i], intUnit) + ' ' +
                     fPadR(stlLinha[i], intLinha) + ' ' +
                     fPadR(stlRotina[i], intRotina));
      End;

      Result := stlStack.Text;
    Finally
      stlStack.Free;
    End;
  End;

  procedure pWrite(strTexto, strTempFile: String);
  Var
    f: TextFile;
  begin
    AssignFile(f, strTempFile);
    If FileExists(strTempFile) Then
    Begin
      Reset(f);
      Append(f)
    End
    Else
      Rewrite(f);
    WriteLn(f, strTexto);
    CloseFile(f);
  end;

  Var
    strSQL : String;
Begin
  if (VS_Trace.GetStatus <> stIniciado) then
    Exit;

  strSQL := Trim(SQL);

  While (Pos('  ', strSQL) > 0) Do
    strSQL := StringReplace(strSQL, '  ', ' ', []);

  // Se passar o Explain, ficará recursivo.
  If Pos('EXPLAIN ', strSQL) > 0 Then
    Exit;

  If (VS_Trace.GetTipo() = ttSimples) And
    (fArrPos(['FROM CFGSIS', 'FROM DIROPE', 'FROM CADMSG', 'INTO LOGSQL',
    'SELECT CURRENT_DATE, CURRENT_TIME', 'SHOW COLUMNS', 'SHOW TABLES',
    'FROM CFGTIN'], strSQL)) Then
    Exit;

  If VS_Trace.GetCabecalho() Then
  Begin
    pAdd('#######################');
    pAdd('# ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', fNow()) + ' #');
    pAdd('#######################');
  End;

  If VS_Trace.GetTipo() = ttPerformance Then
  Begin
    If Not TLogSQL.fGravaLogPerformance(strSQL, frmModulo.Database) Then
      Exit;
  End;

  pAdd(strSQL);

  If VS_Trace.GetStackTrace() Then
  Begin
    pAdd('');
    pAdd('##### STACK TRACE #####');
    pAdd(fFormataStack(fRetornaStack));
    pAdd('');
  End;

  pAdd(StringOfChar('-', 100));

  pWrite(strString, VS_Trace.GetTempFile());

  If Assigned(VS_MemoLogTrace) Then
    VS_MemoLogTrace.Lines.Add(strString);

  VS_Trace.pIncCountSQL();
End;

procedure pAbrirBanco(Database: TUniConnection);
  Var
    qryGen: TUniQuery;
    intCodAut: Integer;
    blnReconectar: Boolean;

    libUtil: Cardinal;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;

  {******************************************************************************}
  {* QUANDO O AUTCOM É EXECUTADO ATRAVÉS DO AGENDADOR DE TAREFAS, A FUNÇÃO:     *}
  {* FileExists('libUtil.dll') NÃO FUNCIONA, RETORNA QUE NÃO ENCONTRA O ARQUIVO,*}
  {* POR ISSO SE FAZ NECESSÁRIO PASSAR O CAMINHO COMPLETO! REQ: 21251           *}
  {***************************************************************************RN*}
  function fPathExe: String;
  begin
    Result := ExtractFilePath(Application.ExeName);
  end;

  {*****************************************}
  {* VERIFICA SE IRÁ UTILIZAR A SENHA DA   *}
  {* DLL.                                  *}
  {**************************************MV*}
  function fUsarSenhaDLL: Boolean;
  begin
    Result := (intCodAut > 0) And (FileExists(fPathExe + 'libUtil.dll'));
  end;

  {*****************************************}
  {* EFETUA A CONEXÃO COM O BANCO.         *}
  {**************************************MV*}
  procedure pConectar;
  begin
    Database.Disconnect;
    Database.Database := '';
    Database.Server   := '';

    If fUsarSenhaDLL Then
    Begin
      libUtil := LoadLibrary(PChar(fPathExe + 'libUtil.dll'));

      fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
      fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));

      Database.Username := String(AnsiStrings.StrPas(fRetornaUsuario));
      Database.Password := String(AnsiStrings.StrPas(fRetornaSenha));

      FreeLibrary(libUtil);
    End
    Else
    Begin
      Database.Username := 'root';
      Database.Password := 'citel13347';
    End;

    Database.Server   := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP',''), ' ', '');
    Database.Database := fArqIni(0,'BANCO','NOMBAN','');

    If Not fEmptyStr(fArqIni(0,'BANCO','PORTA','')) Then
      Database.Port := StrToInt(AnsiReplaceStr(fArqIni(0,'BANCO','PORTA','3306'), ' ', ''));

    Database.Connect;
  End;

  {*****************************************}
  {* MOSTRA MSG DE ERRO.                   *}
  {**************************************MV*}
  procedure pMsgErro(E: Exception);
  begin
    fMensagem('Aviso', 'Abertura do Banco de Dados: ' + E.Message + #13#10#13#10 + 'Verifique o opcoes.ini!', ['&Ok']);
    fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&Ok']);
    Application.Terminate;
  end;
begin
  blnReconectar := False;
  intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0'), 0);

  Try
    pConectar;
  Except
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
        Begin
          intCodAut := 1;
        End;

      End
      Else
      Begin
        pMsgErro(E);
        Exit;
      End;

    End;

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
      pMensagensErro(E.Message, '[pAbrirBanco]');
      fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&O k']);
      Application.Terminate;
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure pFecharBanco(Database: TUniConnection);
begin
  Try
    If Database.InTransaction = True Then
      Database.Rollback;

    Database.Disconnect;
  Except
    On E : Exception do
    Begin
      pMensagensErro(E.Message, '[pFecharBanco]');
	    //pErro(E.Message);
    End;
  End;
end;

procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm:TDataModule);
begin

  If (Assigned(NomeForm)) Then
    Exit;

	Try
    pCriarFormularios(ClasseModulo,NomeForm);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
	End;

end;

procedure pExecArquivo(strArquivo: String; Handle: THandle);
Var
  Result: String;
Begin

  Case ShellExecute(Handle, nil, PChar(strArquivo), nil, nil, SW_SHOWNORMAL) Of
    ERROR_FILE_NOT_FOUND: Result := 'The specified file was not found.';
    ERROR_PATH_NOT_FOUND: Result := 'The specified path was not found.';
    ERROR_BAD_FORMAT: Result := 'The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
    SE_ERR_ACCESSDENIED: Result := 'Windows 95 only: The operating system denied access to the specified file.';
    SE_ERR_ASSOCINCOMPLETE: Result := 'The filename association is incomplete or invalid.';
    SE_ERR_DDEBUSY: Result := 'The DDE transaction could not be completed because other DDE transactions were being processed.';
    SE_ERR_DDEFAIL: Result := 'The DDE transaction failed.';
    SE_ERR_DDETIMEOUT: Result := 'The DDE transaction could not be completed because the request timed out.';
    SE_ERR_DLLNOTFOUND: Result := 'Windows 95 only: The specified dynamic-link library was not found.';
    SE_ERR_NOASSOC: Result := 'There is no application associated with the given filename extension.';
    SE_ERR_OOM: Result := 'Windows 95 only: There was not enough memory to complete the operation.';
    SE_ERR_SHARE: Result := 'A sharing violation occurred.';
  Else
    Exit;
  End;

  ShowMessage(Result);

End;

function fCurrentTime: String;
begin
  Result := 'CAST("' + FormatDateTime('hh:mm:ss', fRetHoraServidor) + '" AS TIME)';
end;

procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  Var
    intCont: Integer;
    strMsg: String;
Begin

  strMsg := '';

  For intCont := 0 To 4 Do
  Begin

    Try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    Except
      On E: EAccessViolation Do
        Raise;

      On E: Exception Do
        strMsg := E.Message + ' ' + E.ClassName;
    End;

    If fEmptyStr(strMsg) Then
      Break;

    Application.ProcessMessages;
    Sleep(1500);

  End;

  If Not fEmptyStr(strMsg) Then
    Raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);

End;

procedure pFreeAndNil(var frmForm);
Begin
  If Assigned(TForm(frmForm)) Then
  Begin
    Try
      FreeAndNil(frmForm);
    Except
      // Apenas para nao dar erro;
    End;
  End;
  pTrimAppMemorySize;
  Application.ProcessMessages;
End;

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

    FormatSettings.ThousandSeparator := '.';
    FormatSettings.DecimalSeparator  := ',';
    FormatSettings.CurrencyDecimals  := 2;
    FormatSettings.ShortDateFormat   := 'dd/MM/yyyy';
    FormatSettings.LongDateFormat    := 'dddd, d'' de ''MMMM'' de ''yyyy';
    FormatSettings.ShortTimeFormat   := 'hh:mm';
    FormatSettings.LongDateFormat    := 'hh:mm:ss';

  Finally
    FreeAndNil(reg);
  End;

End;

end.
