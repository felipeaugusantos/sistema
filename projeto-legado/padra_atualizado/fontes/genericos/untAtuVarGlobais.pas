unit untAtuVarGlobais;

interface

uses Windows, Uni;

  function pAtuVarGlobais(blnRcxConfCupom: Boolean = False): Boolean;

implementation

uses SysUtils, untFuncoesSimples, untFiscal, untFunTef, untPrincipal, untConstantes,
    Data.DB, untLogTef, untTypesSistema;

{*****************************************}
{* ATUALIZA VARIAVEIS GLOBAIS DO SISTEMA *}
{**************************************AF*}
function pAtuVarGlobais(blnRcxConfCupom: Boolean = False): Boolean;
  Var
    strCodEcf: String;
    strModEcf: String;
    strPorta : String;
    qryGenCfg: TUniQuery;
  function fPermiteCriarImpressoraFiscal: Boolean;
    Var
      blnTef_TS: Boolean;
  begin
    Result := False;

    If (frmPrincipal.blnGerImpPdv) Then
      Exit;

    blnTef_TS := fCfgSis('TEF_TS', varBoolean);
    Result := (Not blnTef_TS)                         Or
              (DirectoryExists('\\tsclient\c\TEF_DIAL\'));
  end;
begin
  Result := True;

  Try
    {***********************************************}
    {* VERIFICA SE EXISTE CONFIGURAÇÃO PRA EMPRESA *}
    {********************************************JB*}
    Try
      qryGenCfg := fCriaQuery;

      With qryGenCfg Do
      Begin
        SQL.Add('SELECT ');
        SQL.Add('  SIS_CODEMP');
        SQL.Add('FROM');
        SQL.Add('  CFGSIS');
        SQL.Add('WHERE');
        SQL.Add('  SIS_CODEMP = :CODEMP');

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        If IsEmpty Then
        Begin
          fMensagem('AVISO', 'Não existe configuração para esta empresa! O Sistema será encerrado.', ['&O k']);
          Result := False;
          Exit;
        End;

      End;

    Finally
      FreeAndNil(qryGenCfg);
    End;

    pAtuVarGlobaisSimples;

    TLogTef.strNumSer := '';
    TLogTef.intNumCoo := 0;

    If Not fTabelaExiste('LOGTEF', True) Then
      TLogTef.pCriarTabelaLOGTEF;

    TLogTef.blnLogarTEF := True;

//    pAtualizaDecUni;

    {**************************************}
    {* HABILITA OU NÃO A MENSAGEM DO TEF  *}
    {***********************************AF*}
    If (Not Assigned(VS_objFiscal)) And ((Not fAutComEmModoImportacao) Or VS_AutoatendimentoPagueFacil) Then
    Begin

      If (VS_strUsaTef <> 'S') Or (Not fCfgSis('USARCX', varBoolean)) Then
      Begin
        frmPrincipal.pnlMenTef.Visible := VS_blnTefCitel;

        If VS_blnTelNov Then
        Begin
          strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
          strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

          FreeAndNil(VS_objFiscal);

          strPorta := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

          If fPermiteCriarImpressoraFiscal Then
          Begin
            If Not fEmptyStr(strModEcf) Then
              VS_objFiscal := TFiscalBrd.Create(frmPrincipal, strModEcf);
          End;

        End;

      End
      Else If (VS_strUsaTef = 'S') And (Not frmPrincipal.blnGerImpPdv) Then
      Begin


        frmPrincipal.pnlMenTef.Visible := True;

        strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
        strModEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

        FreeAndNil(VS_objFiscal);
        FreeAndNil(VS_objTef);

        strPorta := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'PORTA'        , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

        If (Not fCfgSis('USNFCE', varBoolean)) And (Not fUsaSat) Then
        Begin
          if (fParametroAutcomUsaTEF) then
          begin
           if not VS_blnTefCitel then
             VS_objTef := TTef.fCriarTEF(frmPrincipal, strModEcf, frmPrincipal, strCodEcf, Nil, False);
          end
          else If fPermiteCriarImpressoraFiscal Then
          Begin
            If Not fEmptyStr(strModEcf) Then
              VS_objFiscal := TFiscalBrd.Create(frmPrincipal, strModEcf);

            if not VS_blnTefCitel then
              VS_objTef := TTef.fCriarTEF(frmPrincipal, strModEcf, frmPrincipal, strCodEcf, VS_objFiscal, Not fCfgSis('USNFCE', varBoolean));
          End;
        End
        Else
        Begin
          if not VS_blnTefCitel then
            VS_objTef := TTef.fCriarTEF(frmPrincipal, strModEcf, frmPrincipal, strCodEcf, Nil, False);
        End;

      End;
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemSonora('>>> Erro <<< ' + #13 + 'Não foi possível carregar variáveis globais!' + #13 + E.Message);

      If blnRcxConfCupom Then
        Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro('Erro ao carregar variaveis globais!' + #13 + E.Message,'[ATUVARGLOBAIS]');

      If blnRcxConfCupom Then
        Result := False;
    End;

  End;

end;

end.



