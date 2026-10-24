unit untConexao;


interface

Uses Uni, System.SysUtils, AnsiStrings,  Vcl.Forms, Winapi.Windows, untFuncoes, Dialogs;

	procedure pAbrirBanco(Database: TUniConnection);
	procedure pFecharBanco(Database: TUniConnection);

Var
  FExecutandoPeloJenkins: boolean;

implementation

Const
  ERROR_USUARIO_SENHA_INV =  1045;


{***********************************}
{* Abrir Banco de Dados do Sistema *}
{********************************DV*}
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
  var
    pDesligaMensagens: procedure; stdcall;
  begin
    Database.Disconnect;
    Database.Database := '';
    Database.Server   := '';

    If fUsarSenhaDLL Then
    Begin
      libUtil := LoadLibrary(PChar(fPathExe + 'libUtil.dll'));

      fRetornaUsuario    := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
      fRetornaSenha      := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));

      if (FExecutandoPeloJenkins) then
      begin
        pDesligaMensagens := GetProcAddress(libUtil, PAnsiChar('pDesligaMensagens'));
        pDesligaMensagens;
      end;

      Database.Username := String(AnsiStrings.StrPas(fRetornaUsuario));
      Database.Password := String(AnsiStrings.StrPas(fRetornaSenha));
    End
    Else
    Begin
      Database.Username := 'root';
      Database.Password := 'citel13347';
    End;

    Database.Server   := String(AnsiReplaceStr(AnsiString(fArqIni(0,'BANCO','NUMIP','')), ' ', ''));
    Database.Database := fArqIni(0,'BANCO','NOMBAN','');

    If Not fEmptyStr(fArqIni(0,'BANCO','PORTA','')) Then
      Database.Port := StrToInt(String(AnsiReplaceStr(AnsiString(fArqIni(0,'BANCO','PORTA','3306')), ' ', '')));

    Database.Connect;
  End;

  {*****************************************}
  {* MOSTRA MSG DE ERRO.                   *}
  {**************************************MV*}
  procedure pMsgErro(E: Exception);
  begin
    if (FExecutandoPeloJenkins) then
    Begin
      ExitCode := 1;
      Application.Terminate;
      Exit;
    End;

    ShowMessage('Abertura do Banco de Dados: ' + E.Message + #13#10#13#10 + 'Verifique o opcoes.ini!');
    ShowMessage('Sua aplicação será fechada agora');

    Application.Terminate;
  end;

  procedure AlterarArquivoOpcoesIniParaUsoJenkins;
  begin
    if (not FExecutandoPeloJenkins) then
      Exit;

    fArqIni(1, 'BANCO', 'NUMIP', ParamStr(2));
    fArqIni(1, 'BANCO', 'NOMBAN', ParamStr(3));
    fArqIni(1, 'BANCO', 'PORTA', ParamStr(4));
  end;
begin
  blnReconectar := False;
  AlterarArquivoOpcoesIniParaUsoJenkins;
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
      ShowMessage(E.Message);
      ShowMessage('Sua aplicação será fechada agora!');
      Application.Terminate;
    End;
  End;

  FreeAndNil(qryGen);
end;

{************************************}
{* Fechar Banco de Dados do Sistema *}
{*********************************DV*}
procedure pFecharBanco(Database: TUniConnection);
begin
  Try
    If Database.InTransaction = True Then
      Database.Rollback;

    Database.Disconnect;
  Except
    On E : Exception do
    Begin
      ShowMessage(E.Message);
	    //pErro(E.Message);
    End;
  End;
end;


end.
