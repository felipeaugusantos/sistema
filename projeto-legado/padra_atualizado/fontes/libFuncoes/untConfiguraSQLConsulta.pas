unit untConfiguraSQLConsulta;

interface

Uses
  Classes, SysUtils, Controls, DB,
  untFuncoesSimples, untZClient, Uni,
  untTypesSistema, untConstantes,
  untClassPanelCx;

Type
  TMascara = (masVazio, masCEP, masCNPJ, masCNPJCPF, masCNAE, masLinhaGrupo, masLotePI, masPlacaVeiculo, masPlanoCaontas, masPlanoContabil, masTelefone);

Const
  ArrDesMascara: Array[masCEP..masTelefone] Of String =
                      ('C.E.P.',
                       'C.N.P.J.',
                       'C.N.P.J. ou CPF',
                       'CNAE',
                       'Linha / Grupo',
                       'Lote de Produção Industrial',
                       'Placa de Veículo',
                       'Plano Contábil',
                       'Plano de Contas',
                       'Telefone');

Type

  TEstilos = Class(TZClient)
    Private

      Function fSQLEstilos: String;
      Function fPegaCampo(Var strCampos: String): String;

    Public

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Function fCarregaEstilos(strEstilos: String): Boolean;

      Function fIncluiEstilo(strOperador, strValor: String; intCor: Integer;
                       blnNegrito, blnItalico, blnSublinhado: Boolean): Boolean;

      Function fGetEstilos: String;

      Function fExcluiEstilo: Boolean;

  End;

  TConfiguraSQLConsulta = Class(TZClient)
    Private
       FChave,
       FSQLRun: String;

       qryCampos: TUniQuery;

       stlNomCol,
       stlCampos: TStringList;

       Function fSQLMestre: String;
       Function fSQLCampos: String;

       Function fValidaCampos: Boolean;

       Function fRetornaAliasCampo(strCampo: String; Var strAlias: String): Boolean;

       Function fCadastraSubSelects: Boolean;

       Function fCadastraConflitos: Boolean;

       Function fTiraLinhasComentario(strSQL: String): String;

       Function fChecaTabelasObrigatorias(strSQL: String): Boolean;

       Function fSQLTemTabela(strSQL, strTabela, strAlias: String): Boolean;

       Function fGetPosWherePrincipal(strSQL: String): Integer;

       Function fBuscaFullText(strChave: String): String;

       Function fCarregarCamposExibir(): String;

    Public
      cdsEstilos: TEstilos;
      cdsCampos: TZClient;

      objDefConsulta: TDefConsulta;

      constructor Create(Owner: TComponent); Reintroduce; Overload;
      Destructor Destroy; override;

      Class Function fTrataSQLRun(strSQL: String; blnParaExecutar: Boolean; Var blnErro: Boolean): String;
      Class Function fVerificaComandosProibidos(strSQL: String): Boolean;
      Class Function fTrataTemplates(strSQL: String; Var blnErro: Boolean): String;

      Function fAjudaVariaveis: String;

      Function fCarregaDados(strChave: String): Boolean;

      Function fSalvaDados(strSQL: String): Boolean;

      Function fVerificaSQL(strSQL: String): Boolean;

      Function fAtualizaCampos: Boolean;

      Procedure pPreencheNomeColunasSQLPadrao;

      Class Function fTemComandosProibidos(strSQL: String): Boolean;

      Class Function fGetChaveConsulta(strTitPesq: String): String;

      Class Function fRetDescricaoMascara: String;
      Class Function fDescMascaraToTipo(strMascara: String): TMascara;
  End;

implementation

Uses
  StrUtils,
  CRParser,
  MyParserUni,
  untMsgErroSQL,
  untConfiguraConsultaOperadores;

constructor TConfiguraSQLConsulta.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLMestre);

  qryCampos := fCriaQuery(Self);

  cdsCampos := TZClient.Create(Self, fSQLCampos);
  cdsCampos.IndexFieldNames :=  'CAM_ALIAS_';

  cdsEstilos := TEstilos.Create(Self);

  stlCampos := TStringList.Create;
  stlNomCol := TStringList.Create;

  stlCampos.Sorted := True;

End;

Destructor TConfiguraSQLConsulta.Destroy;
Begin
  Inherited;

  FreeAndNil(stlCampos);
  FreeAndNil(stlNomCol);
End;

Function TConfiguraSQLConsulta.fSQLMestre: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM SELCON WHERE CFG_CHAVE_ = :CHAVE_ ';

  If fCfgSis('CONOPE', VarBoolean) Then
    strSQL := strSQL + ' AND ((:CODOPE IS NULL AND CFG_CODOPE IS NULL) OR (CFG_CODOPE = :CODOPE)) '
  Else
    strSQL := strSQL + ' AND CFG_CODOPE IS NULL ';

  Result := strSQL;
End;

Function TConfiguraSQLConsulta.fSQLCampos: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT S.*, 0 AS POSINI, 0 AS TAMCOD FROM SELCAM S WHERE CAM_SEQGER = :SEQGER ORDER BY CAM_POSSQL';
  Result := strSQL;
End;

Function TConfiguraSQLConsulta.fCarregaDados(strChave: String): Boolean;
  Var
    objConfigOperador: TConfiguraConsultaOperadores;

  function fCarregarConfigPadrao: Boolean;
  begin
    Close;
    Self.qryQuery.Close;
    Self.qryQuery.ParamByName('CHAVE_').AsString := strChave;
    If Self.qryQuery.FindParam('CODOPE') <> Nil Then
      Self.qryQuery.ParamByName('CODOPE').Clear;
    Result := fLeDados('TConfiguraSQLConsulta.fCarregaDados');
  end;

  function fCarregarConfigOperador: Boolean;
  begin
    Close;
    Self.qryQuery.Close;
    Self.qryQuery.ParamByName('CHAVE_').AsString := strChave;
    Self.qryQuery.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    Result := fLeDados('TConfiguraSQLConsulta.fCarregaDados');
  end;

Begin
  FChave := strChave;

  If fCfgSis('CONOPE', VarBoolean) Then
    Result := fCarregarConfigOperador
  Else
    Result := fCarregarConfigPadrao;

  If Result And fCfgSis('CONOPE', VarBoolean) And IsEmpty And objDefConsulta.blnEditandoSQLConsultaConfigurado Then
  Begin
    Result := fCarregarConfigPadrao;

    If Result And Not IsEmpty Then
    Begin
      Try
        objConfigOperador := TConfiguraConsultaOperadores.Create;
        Result := objConfigOperador.fReplicarConfigConsultaParaOperador(
                    'SELCON', FieldByName('AUTOINCREM').AsString,
                    strLoginUsuarioLogado) And fCarregarConfigOperador;
      Finally
        FreeAndNil(objConfigOperador);
      End;
    End;
  End;

  If Result Then
  Begin
    If IsEmpty Then
    Begin
      Insert;
      FieldByName('CFG_CHAVE_').AsString := strChave;

      If fCfgSis('CONOPE', VarBoolean) Then
        FieldByName('CFG_CODOPE').AsString := strLoginUsuarioLogado;

      FieldByName('SEL_ATISEL').AsString := 'N';
      Post;
    End;

    cdsCampos.qryQuery.ParamByName('SEQGER').AsString := FieldByName('AUTOINCREM').AsString;
    Result := cdsCampos.fLeDados('TConfiguraSQLConsulta.fCarregaDados');

    If Result Then
    Begin
      cdsCampos.pAlinhaCampoCentro('CAM_POSSQL');
      cdsCampos.pAlinhaCampoCentro('CAM_NRODEC');
      cdsCampos.pAlinhaCampoCentro('CAM_MASCAR');
    End;
  End;

End;

function TConfiguraSQLConsulta.fCarregarCamposExibir: String;
begin
  Result := FieldByName('CFG_EXIBIR').AsString;
  Try
    cdsCampos.DisableControls;
    cdsCampos.First;
    While Not cdsCampos.Eof Do
    Begin
      If SameText(cdsCampos.FieldByName('CAM_EXIBIR').AsString, 'S') And
        (Pos(cdsCampos.FieldByName('CAM_ALIAS_').AsString, Result) <= 0) Then
      Begin
        If Result <> '' Then
          Result := Result + ',';
        Result := Result + cdsCampos.FieldByName('CAM_ALIAS_').AsString;
      End;
      cdsCampos.Next;
    End;
  Finally
    cdsCampos.EnableControls;
  End;
end;

Function TConfiguraSQLConsulta.fValidaCampos: Boolean;
Begin
  Result := False;

  If cdsCampos.IsEmpty Then
  Begin
    pMensagemOk('Nenhum campo definido para a consulta!');
    Exit;
  End;

  Try
    cdsCampos.DisableControls;

    cdsCampos.First;
    While Not cdsCampos.Eof Do
    Begin
      If fEmptyStr(cdsCampos.FieldByName('CAM_TITULO').AsString) {And
         SameText(cdsCampos.FieldByName('CAM_EXIBIR').AsString, 'S')} Then
      Begin
        pMensagemOk('Informe o título para o campo ' + cdsCampos.FieldByName('CAM_ALIAS_').AsString   + ' !');
        Exit;
      End;

      cdsCampos.Next;
    End;

    Result := True;

  Finally
    cdsCampos.EnableControls;
  End;

End;

Class Function TConfiguraSQLConsulta.fTemComandosProibidos(strSQL: String): Boolean;
Begin
  Result := False;

  strSQL := UpperCase(strSQL);

  If (Pos('DELETE', strSQL) > 0)   Or
     (Pos('DROP', strSQL) > 0)     Or
     (Pos('REPLACE INTO', strSQL) > 0)  Or
     (Pos('TRUNCATE TABLE', strSQL) > 0) Or
     (Pos('UPDATE', strSQL) > 0) Then
  Begin
    pMensagemOk('Os comandos DELETE, DROP, REPLACE INTO, TRUNCATE TABLE e UPDATE não são permitidos!');
    Result := True;
    Exit;
  End;

End;

Function TConfiguraSQLConsulta.fChecaTabelasObrigatorias(strSQL: String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  If Not Assigned(objDefConsulta) Then
    Exit;

  If Not Assigned(objDefConsulta.arrTabelas) Then
    Exit;

  For intContador := Low(objDefConsulta.arrTabelas) To High(objDefConsulta.arrTabelas) Do
  Begin
    If (Pos(Concat(objDefConsulta.arrTabelas[intContador].strTabela, ' ', objDefConsulta.arrTabelas[intContador].strAlias), strSQL) = 0) And
       (Not fSQLTemTabela(strSQL, objDefConsulta.arrTabelas[intContador].strTabela, objDefConsulta.arrTabelas[intContador].strAlias)) Then
    Begin
      pMensagemOk('O SQL deve conter a tabela ' + objDefConsulta.arrTabelas[intContador].strTabela +
                  IIF(objDefConsulta.arrTabelas[intContador].strAlias.IsEmpty, '',
                      ' com alias ' + objDefConsulta.arrTabelas[intContador].strAlias) + ' !');
      Result := False;
      Exit;
    End;
  End;
End;

Function TConfiguraSQLConsulta.fSQLTemTabela(strSQL, strTabela, strAlias: String): Boolean;
  Var
    sqlParser: TSQLParser;

    intToken: Integer;

    strPriorToken,
    strLastToken,
    strToken: String;

    blnAchouTabela: Boolean;

    Procedure pGetToken;
    Begin
      intToken := sqlParser.GetNextToken;

      If intToken <> 0 Then
      Begin
        strToken := sqlParser.Lexem;

        If Not Trim(strToken).IsEmpty Then
        Begin
          strPriorToken := strLastToken;
          strLastToken  := strToken;
        End;

      End;
    End;

    Procedure pProximoToken;
    Begin
      Repeat

        pGetToken;

      Until (intToken = 0) Or
            ((Not Trim(strToken).IsEmpty) And
             (Not SameStr(Trim(strToken), 'DISTINCT')));
    End;


Begin
  Result := False;

  Try
    strSQL := fTiraLinhasComentario(strSQL);

    sqlParser := TMyParser.Create(strSQL);
    sqlParser.OmitBlank := False;
    sqlParser.OmitComment := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    blnAchouTabela := False;

    pGetToken;

    While intToken <> 0 Do
    Begin

      If SameText(strToken, strTabela) Then
      Begin
        blnAchouTabela := True;

        If strAlias.IsEmpty Then
        Begin
          Result := True;
          Exit;
        End;

      End

      Else If blnAchouTabela Then
      Begin

        If SameText(strToken, strAlias) Then
        Begin
          Result := True;
          Exit;
        End

        Else If Not SameText(strToken, 'AS') Then
        Begin
          Result := False;
          Exit;
        End;

      End;

      pProximoToken;
    End;

  Finally

    FreeAndNil(sqlParser);
  End;

End;

Function TConfiguraSQLConsulta.fBuscaFullText(strChave: String): String;
  Var
    qryCfg: TUniQuery;
Begin
  qryCfg := fCriaQuery;
  qryCfg.SQL.Text := 'SELECT CFG_FULLTE FROM CFGCON WHERE CFG_CHAVE_ = :CHAVE_ AND IFNULL(CFG_FULLTE, "") <> ""';

  If fCfgSis('CONOPE', VarBoolean) Then
    qryCfg.SQL.Text :=  qryCfg.SQL.Text + ' AND CFG_CODOPE = :CODOPE ';

  qryCfg.ParamByName('CHAVE_').AsString := strChave;

  If fCfgSis('CONOPE', VarBoolean) Then
    qryCfg.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

  qryCfg.Open;

  If qryCfg.IsEmpty Then
    Result := ''
  Else
    Result :=  qryCfg.FieldByName('CFG_FULLTE').AsString;

  FreeAndNil(qryCfg);
End;

Function TConfiguraSQLConsulta.fSalvaDados(strSQL: String): Boolean;
  Var
    strAutInc: String;
Begin
  Result := False;

  If Not fVerificaSQL(strSQL) Then
    Exit;

  If Not fChecaTabelasObrigatorias(strSQL) Then
    Exit;

  If cdsCampos.State = dsEdit Then
    cdsCampos.Post;

  If Not fAtualizaCampos Then
    Exit;

  If Not fValidaCampos Then
    Exit;

  fStartTransaction;

  If State = dsEdit Then
    Post;

  Edit;

  If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SELCON', VS_strCodEmp);

  FieldByName('SEL_SQLCON').AsString := AnsiReplaceStr(strSQL, #13#10, '<<csq>>');

  FieldByName('SEL_NOMCOL').AsString := stlNomCol.CommaText;

  If FieldByName('CFG_FULLTE').AsString.IsEmpty Then
  Begin
    FieldByName('CFG_FULLTE').AsString := fBuscaFullText(FieldByName('CFG_CHAVE_').AsString);

    If FieldByName('CFG_FULLTE').AsString.IsEmpty Then
      FieldByName('CFG_FULLTE').Clear;
  End;

  FieldByName('CFG_EXIBIR').AsString := fCarregarCamposExibir;

  Post;

  Result := fSalva;

  If Result Then
  Begin
    cdsCampos.DisableControls;

    cdsCampos.Filter   := 'AUTOINCREM = ' + QuotedStr('');
    cdsCampos.Filtered := True;

    strAutInc := fRetAutoIncrem('SELCAM', VS_strCodEmp, cdsCampos.RecordCount);

    cdsCampos.Filtered := False;
    cdsCampos.Filter   := '';

    cdsCampos.First;

    While Not cdsCampos.Eof Do
    Begin
      cdsCampos.Edit;

      If fEmptyStr(cdsCampos.FieldByName('AUTOINCREM').AsString) Then
      Begin
        cdsCampos.FieldByName('AUTOINCREM').AsString := strAutInc;

        strAutInc := fNextAutoIncrem(strAutInc);
      End;

      If fEmptyStr(cdsCampos.FieldByName('CAM_SEQGER').AsString) Then
        cdsCampos.FieldByName('CAM_SEQGER').AsString := Self.FieldByName('AUTOINCREM').AsString;

      cdsCampos.Post;

      cdsCampos.Next;
    End;

    Result := cdsCampos.fSalva;

  End;

  If Result Then
    fCommit
  Else
    fRollBack;

  cdsCampos.EnableControls;
End;

Class Function TConfiguraSQLConsulta.fTrataTemplates(strSQL: String; Var blnErro: Boolean): String;
  Var
    sqlParser: TSQLParser;

    intPosIni,
    intPosFin,
    intToken: Integer;

    strAliasIteger,
    strAliasCadIte,
    strPriorToken,
    strLastToken,
    strToken: String;

    Procedure pGetToken;
    Begin
      intToken := sqlParser.GetNextToken;

      If intToken <> 0 Then
      Begin
        strToken := sqlParser.Lexem;

        If Not Trim(strToken).IsEmpty Then
        Begin
          strPriorToken := strLastToken;
          strLastToken  := strToken;
        End;

      End;

    End;

    Procedure pProximoToken;
    Begin
      Repeat

        pGetToken;

      Until (intToken = 0) Or (Not Trim(strToken).IsEmpty);
    End;

    Function fSubstitui(strSQL, strTemplate, strValor: String; intTamanho: Integer): String;
      Var
        intPosicao: Integer;
    Begin
      Result := strSQL;

      intPosicao := Pos('VS_SALDO_FISICO', Result);

      If intPosicao > 0 Then
      Begin
        System.Delete(Result, intPosicao, intTamanho);
        System.Insert(strValor, Result, intPosicao);
      End;
    End;

    Function fSaldoFisico(strAliasIteger, strAliasCadIte: String): String;
    Begin
      Result := Concat(' (IFNULL(ITEGER.ITE_SALDOS, 0) + ',
                       '  IF(IFNULL(CADITE.ITE_CNV_ML, 0) > 0, IFNULL(ITEGER.ITE_SAL_ML, 0) / CADITE.ITE_CNV_ML, 0) + ',
                       '  IFNULL(ITEGER.ITE_QTPDBF, 0) + ',
                       '  IFNULL(ITEGER.ITE_QTEF_A, 0) + ',
                       '  IFNULL(ITEGER.ITE_QTEF_F, 0) + ',
                       '  IFNULL(ITEGER.ITE_QTEF_P, 0)) ');

      Result := AnsiReplaceStr(Result, 'ITEGER', strAliasIteger);
      Result := AnsiReplaceStr(Result, 'CADITE', strAliasCadIte);
    End;

Begin
  Result := strSQL;

  blnErro := False;

  Try
    sqlParser := TMyParser.Create(strSQL);
    sqlParser.OmitBlank := False;
    sqlParser.OmitComment := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    pGetToken;

    While intToken <> 0 Do
    Begin

      If SameText(strToken, 'VS_SALDO_FISICO') Then
      Begin
        intPosIni := sqlParser.CurrPos - Length('VS_SALDO_FISICO');
        strAliasIteger := 'G';
        strAliasCadIte := 'I';
        intPosFin := sqlParser.CurrPos;

        pProximoToken;

        If SameText(strToken, '(') Then
        Begin

          pProximoToken;  // ALIAS ITEGER
          strAliasIteger := strToken;

          pProximoToken;  // ,

          If Not SameText(strToken, ',') Then
          Begin
            blnErro := True;
            pMensagemOk('Chamada inconsistente para VS_SALDO_FISICO, "," esperada!');
            Exit;
          End;

          pProximoToken;  // ALIAS CADITE

          strAliasCadIte := strToken;

          pProximoToken;  // )

          If Not SameText(strToken, ')') Then
          Begin
            blnErro := True;
            pMensagemOk('Chamada inconsistente para VS_SALDO_FISICO, ")" esperado!');
            Exit;
          End;

          intPosFin := sqlParser.CurrPos;
        End;

        strSQL := fSubstitui(strSQL, 'VS_SALDO_FISICO', fSaldoFisico(strAliasIteger, strAliasCadIte), intPosFin - intPosIni + 1)
      End; {If SameText(strToken, 'VS_SALDO_FISICO') Then}

      pProximoToken;
    End;

  Finally

    FreeAndNil(sqlParser);
  End;

  Result := strSQL;
End;

Function TConfiguraSQLConsulta.fAjudaVariaveis: String;
  Var
    stlAjuda: TStringList;
Begin
  stlAjuda := TStringList.Create;

  stlAjuda.Add('');
  stlAjuda.Add('VS_STRCODEMP: Código da Empresa Logada');
  stlAjuda.Add('');
  stlAjuda.Add('VS_INTCALSAL: Opção de Cálculo de Saldo (CFG_CALSAL)');
  stlAjuda.Add('');

  If SameText(FChave, 'ConsultadeItens-Faturamento.') Then
  Begin
    stlAjuda.Add('VS_STRCODCLI: Código do Cliente da Venda');
    stlAjuda.Add('');
    stlAjuda.Add('VS_STRCODCND: Código da Condição de Pagamento selcionada na Venda');
    stlAjuda.Add('');
    stlAjuda.Add('VS_INTTABPRE_VEN: Tabela de Preço Selecionada na Venda');
    stlAjuda.Add('');
  End;

  Result := stlAjuda.Text;

  FreeAndNil(stlAjuda);
End;

Class Function TConfiguraSQLConsulta.fTrataSQLRun(strSQL: String; blnParaExecutar: Boolean; Var blnErro: Boolean): String;
Begin
  strSQL := AnsiReplaceStr(strSQL, #9, #13#10);

  strSQL := AnsiReplaceStr(strSQL, '{', ' ');
  strSQL := AnsiReplaceStr(strSQL, '}', ' ');

  strSQL := AnsiReplaceStr(strSQL, 'VS_STRCODEMP',     ':VSSTRCODEMP');

  strSQL := AnsiReplaceStr(strSQL, 'VS_INTCALSAL',     ':VSINTCALSAL');

  strSQL := AnsiReplaceStr(strSQL, 'VS_STRCODCLI',     ':VSSTRCODCLI');
  strSQL := AnsiReplaceStr(strSQL, 'VS_INTTABPRE_VEN', ':VSINTTABPRE_VEN');
  strSQL := AnsiReplaceStr(strSQL, 'VS_STRCODCND',     ':VSSTRCODCND');

  strSQL := fTrataTemplates(strSQL, blnErro);

  If blnParaExecutar Then
    strSQL := AnsiReplaceStr(strSQL, '[WHERE]', ' WHERE ');

  Result := strSQL;
End;

Function TConfiguraSQLConsulta.fGetPosWherePrincipal(strSQL: String): Integer;
  Var
    sqlParser: TSQLParser;

    intToken: Integer;

    strPriorToken,
    strLastToken,
    strToken: String;

    intSelect: Integer;

    Procedure pGetToken;
    Begin
      intToken := sqlParser.GetNextToken;

      If intToken <> 0 Then
      Begin
        strToken := sqlParser.Lexem;

        If Not Trim(strToken).IsEmpty Then
        Begin
          strPriorToken := strLastToken;
          strLastToken  := strToken;
        End;

      End;

    End;

    Procedure pProximoToken;
    Begin
      Repeat

        pGetToken;

      Until (intToken = 0) Or (Not Trim(strToken).IsEmpty);
    End;


Begin
  Result := Pos('[WHERE]', strSQL);

  If Result > 0 Then
    Exit;

  Result := 0;

  intSelect    := 0;


  Try
    sqlParser := TMyParser.Create(strSQL);
    sqlParser.OmitBlank := False;
    sqlParser.OmitComment := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    pGetToken;

    While intToken <> 0 Do
    Begin

      If SameText(strToken, 'SELECT') Then
      Begin
        Inc(intSelect);
      End

      Else If SameText(strToken, 'WHERE') Then
      Begin
        Dec(intSelect);

        If intSelect = 0 Then
        Begin
          Result := sqlParser.CurrPos - Length('WHERE');

          Exit;
        End;

      End;

      pProximoToken;
    End;

  Finally

    FreeAndNil(sqlParser);
  End;

End;

Class Function TConfiguraSQLConsulta.fVerificaComandosProibidos(strSQL: String): Boolean;
  Var
    sqlParser: TSQLParser;

    intToken: Integer;

    strPriorToken,
    strLastToken,
    strToken: String;

    Procedure pGetToken;
    Begin
      intToken := sqlParser.GetNextToken;

      If intToken <> 0 Then
      Begin
        strToken := sqlParser.Lexem;

        If Not Trim(strToken).IsEmpty Then
        Begin
          strPriorToken := strLastToken;
          strLastToken  := strToken;
        End;

      End;

    End;

    Procedure pProximoToken;
    Begin
      Repeat

        pGetToken;

      Until (intToken = 0) Or (Not Trim(strToken).IsEmpty);
    End;


Begin

  Result := True;


  Try
    sqlParser := TMyParser.Create(strSQL);
    sqlParser.OmitBlank := False;
    sqlParser.OmitComment := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    pGetToken;

    While intToken <> 0 Do
    Begin

      If SameText(strToken, 'DROP') Or
         SameText(strToken, 'DELETE') Or
         SameText(strToken, 'ALTER') Then
      Begin
        Result := False;
        Exit;
      End;

      pProximoToken;
    End;

  Finally

    FreeAndNil(sqlParser);
  End;

End;

Function TConfiguraSQLConsulta.fVerificaSQL(strSQL: String): Boolean;
  Var
    intPosWhere: Integer;
    strMsgErr: String;
    blnErro: Boolean;
Begin
  Result := True;

  If ((Pos('UNION', strSQL) > 0) Or (Pos('HAVING', strSQL) > 0) Or (Pos('GROUP', strSQL) > 0)) And (Pos('[WHERE]', strSQL) = 0) Then
  Begin
    pMensagemOk('Quando é usado UNION, HAVING ou GROUP no SQL, é necessário colocar o WHERE principal ente colchetes: [WHERE] !');
    Result := False;
    Exit;
  End;

  If Not fVerificaComandosProibidos(strSQL) Then
  Begin
    pMensagemOk('Quando é permitido o uso de comandos DROP, DELETE ou ALTER no SQL!');
    Result := False;
    Exit;
  End;

  FSQLRun := fTrataSQLRun(strSQL, False, blnErro);

  If blnErro Then
  Begin
    Result := False;
    Exit;
  End;

  strSQL := FSQLRun;

  If fEmptyStr(strSQL) Then
    Exit;

  If fTemComandosProibidos(strSQL) Then
    Exit;

  Try
    intPosWhere := fGetPosWherePrincipal(strSQL);

    If intPosWhere > 0 Then
    Begin

      If Pos('[WHERE]', strSQL) > 0 Then
        strSQL.Insert(intPosWhere + Length('[WHERE]') , ' FALSE AND ')
      Else
        strSQL.Insert(intPosWhere + Length('WHERE') , ' FALSE AND ');

    End Else
    Begin

      strSQL := strSQL + ' WHERE FALSE ';

    End;

    strSQL := AnsiReplaceStr(strSQL, '[WHERE]', ' WHERE ');

    strSQL := AnsiReplaceStr(strSQL, '[', ' ');
    strSQL := AnsiReplaceStr(strSQL, ']', ' ');

    strSQL := AnsiReplaceStr(strSQL, '{', ' ');
    strSQL := AnsiReplaceStr(strSQL, '}', ' ');

    qryCampos.Close;
    qryCampos.SQL.Text := strSQL;
    qryCampos.Open;

  Except
    On E: Exception Do
    Begin
      Result := False;

      strMsgErr :=  E.Message;

      pCriarFormularios(TfrmMsgErroSQL, frmMsgErroSQL);
      frmMsgErroSQL.mmoErrSQL.Lines.text := strMsgErr;
      frmMsgErroSQL.ShowModal;
      pFreeAndNil(frmMsgErroSQL);
    End;
  End;

End;

Function TConfiguraSQLConsulta.fAtualizaCampos: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  If Not qryCampos.Active Then
    Exit;

  cdsCampos.DisableControls;

  cdsCampos.Filtered := False;

  cdsCampos.First;

  While Not cdsCampos.Eof Do
  Begin

    If Assigned(qryCampos.FindField(cdsCampos.FieldByName('CAM_ALIAS_').AsString)) Then
      cdsCampos.Next
    Else
      cdsCampos.Delete;

  End;

  For intContador := 0 To qryCampos.Fields.Count - 1 Do
    If Not cdsCampos.FindKey([qryCampos.Fields[intContador].FieldName]) Then
    Begin
      cdsCampos.Append;
      cdsCampos.FieldByName('CAM_ALIAS_').AsString := qryCampos.Fields[intContador].FieldName;
      cdsCampos.FieldByName('CAM_EXIBIR').AsString := IIF(SameText(cdsCampos.FieldByName('CAM_ALIAS_').AsString, 'AUTOINCREM') , 'N', 'S');
      cdsCampos.Post;
    End;

  stlCampos.Clear;
  stlNomCol.Clear;

  For intContador := 0 To qryCampos.Fields.Count - 1 Do
    If cdsCampos.FindKey([qryCampos.Fields[intContador].FieldName]) Then
    Begin
      cdsCampos.Edit;
      cdsCampos.FieldByName('CAM_POSSQL').AsInteger := Succ(intContador);
      cdsCampos.FieldByName('CAM_TIPCAM').AsInteger := 0;
      cdsCampos.FieldByName('CAM_SUBSEL').Clear;
      cdsCampos.FieldByName('CAM_ALICON').Clear;

      cdsCampos.Post;

      stlCampos.Add(cdsCampos.FieldByName('CAM_ALIAS_').AsString);

      If Not fEmptyStr(cdsCampos.FieldByName('CAM_TITULO').AsString) Then
        stlNomCol.Add(cdsCampos.FieldByName('CAM_TITULO').AsString);
    End;

  If fEmptyStr(Self.FieldByName('SEL_CAMKEY').AsString) And
     cdsCampos.FindKey(['AUTOINCREM']) Then
  Begin
    If Self.State <> dsEdit Then
      Self.Edit;

    Self.FieldByName('SEL_CAMKEY').AsString := 'AUTOINCREM';

    Self.Post;
    Self.Edit;
  End;

  Result := fCadastraSubSelects And fCadastraConflitos;

  cdsCampos.EnableControls;
End;

Procedure TConfiguraSQLConsulta.pPreencheNomeColunasSQLPadrao;
  Var
    strIndex: String;
Begin
  cdsCampos.DisableControls;

  strIndex := cdsCampos.IndexFieldNames;
  cdsCampos.IndexFieldNames := 'CAM_POSSQL';
  cdsCampos.First;

  While Not cdsCampos.Eof Do
  Begin
    cdsCampos.Edit;

    If cdsCampos.RecNo <= objDefConsulta.stlNomeColunas.Count Then
      cdsCampos.FieldByName('CAM_TITULO').AsString := objDefConsulta.stlNomeColunas[Pred(cdsCampos.RecNo)]
    Else
      cdsCampos.FieldByName('CAM_TITULO').AsString := cdsCampos.FieldByName('CAM_ALIAS_').AsString;

    cdsCampos.Post;

    cdsCampos.Next;
  End;

  cdsCampos.IndexFieldNames := strIndex;

  cdsCampos.First;
  cdsCampos.EnableControls;
End;

Function TConfiguraSQLConsulta.fRetornaAliasCampo(strCampo: String; Var strAlias: String): Boolean;
  Var
    sqlParser: TSQLParser;
    intToken: Integer;
    strTokenAnt,
    strToken: String;
Begin
  strAlias := '';
  Result := False;

  Try
    sqlParser := TMyParser.Create(FSQLRun);
    sqlParser.OmitBlank := False;
    sqlParser.OmitComment := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    strTokenAnt := '';

    intToken := sqlParser.GetNextToken;

    While intToken <> 0 Do
    Begin
      strToken := sqlParser.Lexem;

      If SameText(strToken, strCampo) Then
        Exit;

      If (strToken = '.') And (Not strTokenAnt.IsEmpty) Then
      Begin

        Repeat
          intToken := sqlParser.GetNextToken;

          If intToken <> 0 Then
            strToken := sqlParser.Lexem;
        Until (intToken = 0) Or (Not strToken.IsEmpty);

        If SameText(strToken, strCampo) Then
        Begin
          strAlias := strTokenAnt;
          Result   := True;
          Exit;
        End;

      End; {If (strToken = '.') And (Not strTokenAnt.IsEmpty) Then}

      If (strToken <> '.') And (Not fEmptyStr(strToken)) Then
        strTokenAnt := strToken;

      intToken := sqlParser.GetNextToken;
    End;

  Finally
    FreeAndNil(sqlParser);
  End;

End;

Function TConfiguraSQLConsulta.fCadastraConflitos: Boolean;
  Var
    strAlias: String;
Begin
  Result := False;

  If Not qryCampos.Active Then
    Exit;

  cdsCampos.First;

  While Not cdsCampos.Eof Do
  Begin

    If (cdsCampos.FieldByName('CAM_TIPCAM').AsInteger = 0) And
       fRetornaAliasCampo(cdsCampos.FieldByName('CAM_ALIAS_').AsString, strAlias) Then
    Begin
      cdsCampos.Edit;
      cdsCampos.FieldByName('CAM_ALICON').AsString := strAlias;
      cdsCampos.Post;
    End;

    cdsCampos.Next
  End;

  Result := True;
End;

Function TConfiguraSQLConsulta.fTiraLinhasComentario(strSQL: String): String;
  Var
    stlSQL: TStringList;
    intLinhas: Integer;
Begin
  stlSQL := TStringList.Create;
  stlSQL.Text := strSQL;

  intLinhas := 0;

  While (intLinhas < stlSQL.Count) And (stlSQL.Count > 0) Do
  Begin

    If AnsiStartsStr('-- ', Trim(stlSQL[intLinhas])) Then
      stlSQL.Delete(intLinhas)
    Else
      Inc(intLinhas);

  End;

  Result := stlSQL.Text;
  FreeAndNil(stlSQL);
End;

Function TConfiguraSQLConsulta.fCadastraSubSelects: Boolean;
  Var
    sqlParser: TSQLParser;

    intTamExcluido,
    intToken,
    intPosIni,
    intTamCod,
    intPilha: Integer;

    strPriorToken,
    strLastToken,
    strSubSel,
    strSQL,
    strToken: String;

    blnAchouSelect,
    blnIniciouSubSelect: Boolean;

    Procedure pGetToken;
    Begin
      intToken := sqlParser.GetNextToken;

      If intToken <> 0 Then
      Begin
        strToken := sqlParser.Lexem;

        If Not Trim(strToken).IsEmpty Then
        Begin
          strPriorToken := strLastToken;
          strLastToken  := strToken;
        End;

      End;
    End;

    Procedure pProximoToken;
    Begin
      Repeat

        pGetToken;

      Until (intToken = 0) Or
            ((Not Trim(strToken).IsEmpty) And
             (Not SameStr(Trim(strToken), 'DISTINCT')));
    End;

    Function fGetErroSQL: String;
      Var
        intPos: Integer;
    Begin
       intPos := sqlParser.CurrPos;
       Dec(intPos, 15);
       If intPos < 1 Then
         intPos := 1;

      Result := ' ... ' + Trim(Copy(strSQL, intPos, 30)) + ' ...';
    End;

Begin
  Result := True;

  Try
    intPosIni := 0;

    blnAchouSelect := False;
    blnIniciouSubSelect := False;

    strSQL := fTiraLinhasComentario(FSQLRun);

    sqlParser := TMyParser.Create(strSQL);
    sqlParser.OmitBlank := False;
    sqlParser.OmitComment := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    pGetToken;

    intPilha := 0;
    strSubSel := '';
    strLastToken := '';
    strPriorToken := '';

    While intToken <> 0 Do
    Begin

      If SameText('SELECT', strToken) And (Not blnAchouSelect) Then  // É O SELECT INICIAL
      Begin
        blnAchouSelect := True;
      End

      Else If SameText('(', strToken) Then  // É UMA EXPRESSÃO
      Begin
        Inc(intPilha);

        If Not blnIniciouSubSelect Then
        Begin
          intPosIni := Pred(sqlParser.CurrPos);
          blnIniciouSubSelect := True;
        End;
      End

      Else If SameText(')', strToken) Then  // É UMA EXPRESSÃO
      Begin
        Dec(intPilha);

        If intPilha < 0 Then
        Begin
          Result := False;
          pMensagemOk('Erro de parentização do SQL: ' + fGetErroSQL);
          Exit;
        End;

        If blnIniciouSubSelect And (intPilha = 0) Then
        Begin
          strSubSel := Copy(strSQL, intPosIni, sqlParser.CurrPos - intPosIni + 1);

          pProximoToken;

          If SameText(strToken, 'AS') Then
          Begin
            intTamCod := sqlParser.CurrPos - intPosIni + 1;

            If Not SameText(strPriorToken, ')') Then
            Begin
              Result := False;
              pMensagemOk('Toda expressão deve ser parentizada e sucedida por "AS": ' + fGetErroSQL);
              Exit;
            End;

            pProximoToken;

            If (intToken <> 0) Then
            Begin

              If Not Assigned(qryCampos.FindField(strToken)) Then
              Begin
                Result := False;
                pMensagemOk('Coluna ' + strToken + ' não encontrada!');
                Exit;
              End;

              If strSubSel.IsEmpty Then
              Begin
                Result := False;
                pMensagemOk('Expressão para a coluna ' + strToken + ' não encontrada!');
                Exit;
              End;

              If cdsCampos.FindKey([strToken]) Then
              Begin
                cdsCampos.Edit;
                cdsCampos.FieldByName('CAM_SUBSEL').AsString  := Trim(strSubSel);
                cdsCampos.FieldByName('CAM_TIPCAM').AsInteger := 1;
                cdsCampos.FieldByName('POSINI').AsInteger     := intPosIni;
                cdsCampos.FieldByName('TAMCOD').AsInteger     := intTamCod;

                cdsCampos.Post;

                strSubSel := '';

                pProximoToken;

                If SameText(strToken, ',') Then
                Begin
                  // TERMINOU
                End

                Else If SameText(strToken, 'FROM') Then
                Begin
                  // TERMINOU
                  Break;
                End Else
                Begin
                  Result := False;
                  pMensagemOk('Expressão para a coluna ' + strToken + ' não encontrada!');
                  Exit;
                End;

              End Else

              Begin
                Result := False;
                pMensagemOk('Toda expressão deve ser parentizada e sucedida por "AS": ' + fGetErroSQL);
                Exit;
              End;

              blnIniciouSubSelect := False;
            End;

          End Else
          Begin
            Result := False;
            pMensagemOk('Toda expressão deve ser parentizada e sucedida por "AS": ' + fGetErroSQL);
            Exit;
          End;

        End;

      End Else
      Begin

        If (Not Trim(strToken).IsEmpty) Then
        Begin

          If blnIniciouSubSelect Then
          Begin
            // ESTÁ NO MEIO DE UMA EXPRESSAO
          End

          // NÃO ESTÁ NUMA EXPRESSAO
          // PODE SER
          //   - UM ALIAS DE TABELA SEGUIDO DE UM CAMPO
          //   - UM CAMPO

          Else If Assigned(qryCampos.FindField(strToken)) Then
          Begin
            // PRECISA ENCONTRAR UM VÍGULA A SEGUIR OU O FROM SE FOR ÚLTIMO CAMPO

            pProximoToken;

            If SameText(strToken, ',') Then
            Begin
              // CAMPO SOLITÁRIO
            End

            Else If SameText(strToken, 'FROM') Then
            Begin

              Break;

            End Else
            Begin
              Result := False;
              pMensagemOk('Toda expressão deve ser parentizada e sucedida por "AS"! - ' + strPriorToken);
              Exit;
            End;

          End Else // TEM QUE SER UM ALIAS DE TABELA SEGUIDO DE .CAMPO
          Begin

            pProximoToken;

            If Not SameText(strToken, '.') Then
            Begin
              Result := False;
              pMensagemOk('Toda expressão deve ser parentizada e sucedida por "AS": ' + fGetErroSQL);
              Exit;
            End;

            pProximoToken; // DEVE SER UM CAMPO

            If Not Assigned(qryCampos.FindField(strToken)) Then
            Begin
              Result := False;
              pMensagemOk('Toda expressão deve ser parentizada e sucedida por "AS": ' + fGetErroSQL);
              Exit;
            End;

            pProximoToken;

            If SameText(strToken, ',') Then
            Begin
              // CAMPO SOLITÁRIO
            End

            Else If SameText(strToken, 'FROM') Then
            Begin

              Break;

            End Else
            Begin
              Result := False;
              pMensagemOk('Toda expressão deve ser parentizada e sucedida por "AS": ' + fGetErroSQL);
              Exit;
            End;

          End

        End;

      End;

      pProximoToken;
    End;

    cdsCampos.Filter   := 'CAM_TIPCAM = 1';
    cdsCampos.Filtered := True;
    cdsCampos.IndexFieldNames := 'CAM_POSSQL';
    cdsCampos.First;

    intTamExcluido := 0;

    While Not cdsCampos.Eof Do
    Begin
      System.Delete(strSQL, cdsCampos.FieldByName('POSINI').AsInteger - intTamExcluido, cdsCampos.FieldByName('TAMCOD').AsInteger);

      intTamExcluido := intTamExcluido + cdsCampos.FieldByName('TAMCOD').AsInteger;

      cdsCampos.Next;
    End;

    If Self.State <> dsEdit Then
      Self.Edit;

    Self.FieldByName('SEL_SQLRUN').AsString := strSQL;

    Self.Post;
    Self.Edit;

  Finally

    cdsCampos.Filtered := False;
    cdsCampos.Filter   := '';
    cdsCampos.IndexFieldNames := 'CAM_ALIAS_';

    FreeAndNil(sqlParser);
  End;

End;

Class Function TConfiguraSQLConsulta.fRetDescricaoMascara: String;
  Var
    stlLista: TStringList;
    masContador: TMascara;
Begin
  stlLista := TStringList.Create;

  For masContador := Low(ArrDesMascara) To High(ArrDesMascara) Do
    stlLista.Add(String(ArrDesMascara[masContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Class Function TConfiguraSQLConsulta.fDescMascaraToTipo(strMascara: String): TMascara;
  Var
    masIndide: TMascara;
Begin
  Result := masVazio;

  For masIndide := Low(ArrDesMascara) To High(ArrDesMascara) Do
    If SameText(ArrDesMascara[masIndide], strMascara) Then
    Begin
      Result := masIndide;
      Exit;
    End;
End;

Class Function TConfiguraSQLConsulta.fGetChaveConsulta(strTitPesq: String): String;
  Var
    intPonto: Integer;
begin
  intPonto := Pos('.', strTitPesq);

  If intPonto > 0 Then
    strTitPesq := LeftStr(strTitPesq, intPonto);

  Result := StringReplace(strTitPesq, ' ', '', [rfReplaceAll]);
end;


Function TEstilos.fSQLEstilos: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST("" AS CHAR(10))  AS OPERADOR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(100)) AS VALOR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(20))  AS COR, ';
  strSQL := strSQL + '   CAST("" AS CHAR(3))   AS FONTE ';

  Result := strSQL;
End;

constructor TEstilos.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLEstilos);

End;

Destructor TEstilos.Destroy;
Begin
  Inherited;

End;

Function TEstilos.fPegaCampo(Var strCampos: String): String;
  Var
    intLimite: Integer;
Begin
  intLimite := Pos(';', strCampos);

  If intLimite > 0 Then
  Begin
    Result := LeftStr(strCampos, Pred(intLimite));
    System.Delete(strCampos, 1, intLimite);
  End Else
  Begin
    Result := strCampos;
    strCampos := '';
  End;
End;

Function TEstilos.fCarregaEstilos(strEstilos: String): Boolean;
  Var
    stlLista: TStringList;
    strCampos: String;
    intContador: Integer;
Begin
  Result := fLeDados('TEstilos.fCarregaEstilos');

  If Not Result Then
    Exit;


  pAlinhaCampoCentro('OPERADOR');
  IndexFieldNames := 'OPERADOR;VALOR';

  EmptyDataSet;

  stlLista := TStringList.Create;
  stlLista.CommaText := strEstilos;

  For intContador := 0 To stlLista.Count - 1 Do
  Begin
    strCampos := stlLista[intContador];

    Append;
    FieldByName('OPERADOR').AsString := fPegaCampo(strCampos);
    FieldByName('VALOR').AsString    := fPegaCampo(strCampos);
    FieldByName('COR').AsString      := fPegaCampo(strCampos);
    FieldByName('FONTE').AsString    := fPegaCampo(strCampos);
    Post;
  End;

  FreeAndNil(stlLista);
End;

Function TEstilos.fGetEstilos: String;
Begin
  Result := '';

  If State In dsEditModes Then
    Post;

  First;
  While Not Eof Do
  Begin

    If Not Result.IsEmpty Then
      Result := Concat(Result, ',');

    Result := Concat(Result,
                     FieldByName('OPERADOR').AsString, ';',
                     FieldByName('VALOR').AsString, ';',
                     FieldByName('COR').AsString, ';',
                     FieldByName('FONTE').AsString);

    Next;
  End;
End;

Function TEstilos.fExcluiEstilo: Boolean;
Begin
  Result := False;

  If IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão do estilo "' + FieldByName('OPERADOR').AsString + '" ?') Then
    Delete;
End;

Function TEstilos.fIncluiEstilo(strOperador, strValor: String; intCor: Integer;
                       blnNegrito, blnItalico, blnSublinhado: Boolean): Boolean;
Begin
  If FindKey([strOperador, strValor]) Then
    Edit
  Else
    Append;

  FieldByName('OPERADOR').AsString := strOperador;
  FieldByName('VALOR').AsString    := strValor;
  FieldByName('COR').AsString      := IntToStr(intCor);
  FieldByName('FONTE').AsString    := Concat(IIF(blnNegrito, 'N', ''),
                                             IIF(blnItalico, 'I', ''),
                                             IIF(blnSublinhado, 'S', ''));
  Post;

  Result := True;
End;

end.

