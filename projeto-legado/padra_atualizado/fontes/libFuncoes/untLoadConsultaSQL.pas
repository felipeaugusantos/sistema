unit untLoadConsultaSQL;

interface

Uses
  Classes, SysUtils, Controls, DB,
  cxGridDBTableView,
  cxGridCustomTableView,
  cxStyles,
  System.UITypes,
  untFuncoesSimples, untZClient, Uni,
  untTypesSistema, untConstantes,
  untClassPanelCx;

Type
  TArrSytile = Array Of Record
                          strValor,
                          strOperador: String;
                          cxsEstilo: TcxStyle;
                        End;

  TArrCampo = Array Of Record
                         strCampo,
                         strTitulo: String;
                         blnConfiguralPeloUsuario: Boolean;
                       End;

  TLoadConsultaSQL = Class
    Private

      qryCampos: TUniQuery;

      qrySelCon: TUniQuery;

      FDefConsulta: TDefConsulta;

      FGroupByAdicional,
      FWhereAdicional,
      FCampoEstilo: String;

      FCampoObrigatorios: TArrCampo;

      FArrStyle: TArrSytile;

      Function fSQLSelCon(blnVerOperador: Boolean): String;

   //   function fRetornaEstilo(strValor: String): TcxStyle;

      function fRetornaEstilo(varValorCampo: Variant; tipTipo: TFieldType): TcxStyle;

      Procedure pCarregaSQL(strSQL: String);

      Procedure pCarregaNomeColunas(strNomes: String);

      Procedure pConfiguraCampos(objDefConsulta: TDefConsulta);

      Procedure pCarregaCampos(strSeqGer: String);

      Procedure pCarregaEstilos(strCampo, strEstilos: String; objDefConsulta: TDefConsulta);

      function fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
                   AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;

      Procedure pLiberaEstilos;

      Function fGetPosWherePrincipal(strSQL: String): Integer;

      Function fNumeroSubColsultasProgramador: Integer;

    Public

      arrSql,
      arrNomeColunas: TColunasArray;

      stlJoins: TStringList;

      strTabela,
      strTitulo,
      strCampoChave,
      strCampoChave2,
      strCodBusca: String;

      Constructor Create;

      Destructor Destroy; override;

      Function fCampoDefinidoPeloUsuaio(strCampo: String): Boolean;

      Class function fGetChaveConsulta(strTitPesq: String): String;

      Function fCarregaConsulta(strChave: String; objDefConsulta: TDefConsulta; blnCarregarDados: Boolean = True): Boolean;

      Procedure pSetaParametroStr(strNomPar, strValPar: String);
      Procedure pSetaParametroInt(strNomPar: String; intValPar: Integer);
      Procedure pSetaParametroFlt(strNomPar: String; fltValPar: Double);
      Procedure pSetaParametroBln(strNomPar: String; blnValPar: Boolean);

      Procedure pSetaWhereAdicional(strWhere: String);
      Procedure pSetaGroupByAdicional(strGroupBy: String);

      Procedure pCarregaDadosConsulta;

      Function fIncluiCampoObrigatorio(strCampo: String; strTitulo: String = ''): Boolean;

      Function fIncluiSubConsulta(strCampo, strSelect, strTitulo: String): Boolean;

      Function fRetiraClausula(strNomPar, strValor: String): String;

      Procedure pCompletaWhere(strWhere: String);

      Class Function fUsaConsultaConfigurada(strTitulo: String; Var objLoadSql: TLoadConsultaSQL; objDefConsulta: TDefConsulta; blnCarregarDados: Boolean = True): Boolean;

  End;

implementation

Uses
  StrUtils,
  CRParser,
  MyParserUni,
  Vcl.Graphics,
  untConfiguraSQLConsultaEdicao,
  untConfiguraSQLConsulta;

Constructor TLoadConsultaSQL.Create;
Begin
  qrySelCon := fCriaQuery;
  qryCampos := fCriaQuery;

  stlJoins := TStringList.Create;

  FWhereAdicional := '';
  FGroupByAdicional := '';

  SetLength(FCampoObrigatorios, 0);
End;

Destructor TLoadConsultaSQL.Destroy;
Begin
  Inherited;

  SetLength(arrSql, 0);
  SetLength(arrNomeColunas, 0);
  SetLength(FCampoObrigatorios, 0);

  FreeAndNil(qrySelCon);
  FreeAndNil(qryCampos);

  FreeAndNil(stlJoins);

  pLiberaEstilos;
End;

Function TLoadConsultaSQL.fSQLSelCon(blnVerOperador: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   AUTOINCREM,  ';
  strSQL := strSQL + '   SEL_TITULO,  ';
  strSQL := strSQL + '   SEL_TABELA,  ';
  strSQL := strSQL + '   SEL_SQLRUN,  ';
  strSQL := strSQL + '   SEL_NOMCOL,  ';
  strSQL := strSQL + '   SEL_CODBUS,  ';
  strSQL := strSQL + '   SEL_CAMKEY   ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   SELCON ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '   CFG_CHAVE_ = :CHAVE_ ';

  If blnVerOperador Then
    strSQL := strSQL + ' AND CFG_CODOPE = :CODOPE  '
  Else
    strSQL := strSQL + ' AND CFG_CODOPE IS NULL    ';

  strSQL := strSQL + '   AND SEL_ATISEL = "S"   ';

  Result := strSQL;
End;

Class function TLoadConsultaSQL.fGetChaveConsulta(strTitPesq: String): String;
  Var
    intPonto: Integer;
begin
  intPonto := Pos('.', strTitPesq);

  If intPonto > 0 Then
    strTitPesq := LeftStr(strTitPesq, intPonto);

  Result := StringReplace(strTitPesq, ' ', '', [rfReplaceAll]);
end;

Procedure TLoadConsultaSQL.pCarregaCampos(strSeqGer: String);
Begin
  With qryCampos Do
  Begin
    SQL.Text := ' SELECT * FROM SELCAM WHERE CAM_SEQGER = :SEQGER ORDER BY CAM_POSSQL';
    ParamByName('SEQGER').AsString := strSeqGer;
    Open;

    If Assigned(FDefConsulta) Then
    Begin
      FDefConsulta.dtsColunasUsuario := qryCampos;
      FDefConsulta.strAutIncSelCon   := strSeqGer;
    End;
  End;
End;

Procedure TLoadConsultaSQL.pConfiguraCampos(objDefConsulta: TDefConsulta);
  Var
    arrLisVal: TarrCampos;
    arrCamposCep,
    arrCamposFone,
    arrCamposCNPJ: TarrCampos;

    Procedure pAdicionaCampo(strNomCampo: String; Var arrCampos: TarrCampos);
    Begin
      SetLength(arrCampos, Succ(Length(arrCampos)));
      arrCampos[High(arrCampos)] := strNomCampo;
    End;

    Procedure pTextToArrCampos(strInfo: String; Var arrCampos: TarrCampos);
      Var
        stlLista: TStringList;
        intContador: Integer;
    Begin
      stlLista := TStringList.Create;
      stlLista.Text :=  AnsiReplaceStr(strInfo, '<<csq>>', #13#10);;

       SetLength(arrCampos, stlLista.Count);

      For intContador := 0 To stlLista.Count - 1 Do
        arrCampos[intContador] := stlLista[intContador];

      FreeAndNil(stlLista);
    End;

Begin
  SetLength(arrCamposCep, 0);
  SetLength(arrCamposFone, 0);
  SetLength(arrCamposCNPJ, 0);

  With qryCampos Do
  Begin
    First;

    While Not Eof Do
    Begin

      If FieldByName('CAM_TIPCAM').AsInteger = 1 Then
        objDefConsulta.pIncluiSubConsulta(FieldByName('CAM_ALIAS_').AsString, FieldByName('CAM_SUBSEL').AsString);

      If Not FieldByName('CAM_NRODEC').IsNull Then
        objDefConsulta.pFormataDecimal(FieldByName('CAM_ALIAS_').AsString, FieldByName('CAM_NRODEC').AsInteger);

      If Not fEmptyStr(FieldByName('CAM_LISVAL').AsString) Then
      Begin
        pTextToArrCampos(FieldByName('CAM_LISVAL').AsString, arrLisVal);
        objDefConsulta.pIncluiCampoSimNao(FieldByName('CAM_ALIAS_').AsString, arrLisVal);
        SetLength(arrLisVal, 0);
      End;

      If Not fEmptyStr(FieldByName('CAM_ALICON').AsString) Then
        objDefConsulta.pIncluiConflito(FieldByName('CAM_ALIAS_').AsString,
                   Concat(FieldByName('CAM_ALICON').AsString, '.', FieldByName('CAM_ALIAS_').AsString));

      If Not FieldByName('CAM_MASCAR').IsNull Then
        Case TConfiguraSQLConsulta.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
          masCEP:      Begin
                         pAdicionaCampo(FieldByName('CAM_ALIAS_').AsString, arrCamposCep);
                         objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '-');
                       End;

          masCNPJ:     Begin
                         pAdicionaCampo(FieldByName('CAM_ALIAS_').AsString, arrCamposCNPJ);
                         objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '-./');
                       End;

          masCNPJCPF:  Begin
                         objDefConsulta.pIncluiDefMascaraDup(FieldByName('CAM_ALIAS_').AsString, FieldByName('CAM_CALMSK').AsString, objDefConsulta.pDisplayCNPJ_CPF);
                         objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '-./');
                       End;

          masCNAE:     Begin
                         objDefConsulta.pIncluiDefMascara(FieldByName('CAM_ALIAS_').AsString, objDefConsulta.pDisplayCNAE);
                         objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '-/');
                       End;

          masLotePI:   Begin
                         objDefConsulta.pIncluiDefMascara(FieldByName('CAM_ALIAS_').AsString, objDefConsulta.pDisplayNumLot);
                         objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '-');
                       End;

          masLinhaGrupo: Begin
                           objDefConsulta.pIncluiDefMascara(FieldByName('CAM_ALIAS_').AsString, objDefConsulta.pDisplayLinhaGrupo);
                           objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '.');
                         End;

          masPlacaVeiculo: Begin
                             objDefConsulta.pIncluiDefMascara(FieldByName('CAM_ALIAS_').AsString, objDefConsulta.pDisplayPlacaVeiculo);
                             objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '-');
                           End;

          masPlanoCaontas: Begin
                             objDefConsulta.pIncluiDefMascara(FieldByName('CAM_ALIAS_').AsString, objDefConsulta.pDisplayPlanoContabil);
                             objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '.');
                           End;

          masPlanoContabil: Begin
                              objDefConsulta.pIncluiDefMascara(FieldByName('CAM_ALIAS_').AsString, objDefConsulta.pDisplayPlanoContas);
                              objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '.-/()');
                            End;

          masTelefone: Begin
                         pAdicionaCampo(FieldByName('CAM_ALIAS_').AsString, arrCamposFone);
                         objDefConsulta.pSetaCarecteresIgnorados(FieldByName('CAM_ALIAS_').AsString, '()-');
                       End;
        End;

      If Not fEmptyStr(FieldByName('CAM_ESTILO').AsString) Then
        pCarregaEstilos(FieldByName('CAM_ALIAS_').AsString, FieldByName('CAM_ESTILO').AsString, objDefConsulta);

      If Assigned(prcCarregaIcones) Then
        prcCarregaIcones(qryCampos, objDefConsulta);

      Next;
    End;

    If Length(arrCamposCep) > 0 Then
      objDefConsulta.pIncluiCamposCep(arrCamposCep);

    If Length(arrCamposFone) > 0 Then
      objDefConsulta.pIncluiCamposFone(arrCamposFone);

    If Length(arrCamposCNPJ) > 0 Then
      objDefConsulta.pIncluiCamposCNPJ(arrCamposFone);
  End;

  SetLength(arrCamposCep, 0);
  SetLength(arrCamposFone, 0);
  SetLength(arrCamposCNPJ, 0);
End;

Function TLoadConsultaSQL.fCampoDefinidoPeloUsuaio(strCampo: String): Boolean;
  Var
    intPos: Integer;
    strSoCampo: String;
Begin
  intPos := Pos('.', strCampo);

  If intPos > 0 Then
    strSoCampo := RightStr(strCampo, Length(strCampo) - intPos)
  Else
    strSoCampo := strCampo;

  Result := qryCampos.Locate('CAM_ALIAS_', Trim(strSoCampo), []);
End;

Function TLoadConsultaSQL.fIncluiSubConsulta(strCampo, strSelect, strTitulo: String): Boolean;
Begin
  Result := False;

  If Assigned(FDefConsulta) Then
  Begin
    // VERIFICA SE JA FOI DEFINIDO PELO USUÁRIO
    If Not fCampoDefinidoPeloUsuaio(strCampo) Then
    Begin
      FDefConsulta.pIncluiSubConsulta(strCampo, strSelect, '', strTitulo);
      Result := True;
    End;

  End
End;

Function TLoadConsultaSQL.fIncluiCampoObrigatorio(strCampo: String; strTitulo: String = ''): Boolean;
Begin
  If Not fCampoDefinidoPeloUsuaio(strCampo) Then
  Begin
    SetLength(FCampoObrigatorios, Succ(Length(FCampoObrigatorios)));
    FCampoObrigatorios[High(FCampoObrigatorios)].strCampo  := strCampo;
    FCampoObrigatorios[High(FCampoObrigatorios)].strTitulo := strTitulo;
    Result := True;
  End

  Else Result := False;
End;

Function TLoadConsultaSQL.fCarregaConsulta(strChave: String; objDefConsulta: TDefConsulta; blnCarregarDados: Boolean = True): Boolean;
Begin
  Result := False;

  Try

    FDefConsulta := objDefConsulta;

    With qrySelCon Do
    Begin
      If Not fCfgSis('CONOPE', VarBoolean) Then
      Begin
        SQL.Text := fSQLSelCon(False);
        ParamByName('CHAVE_').AsString := strChave;
        Open;
      End
      Else
      Begin
        Close;
        SQL.Text := fSQLSelCon(True);
        ParamByName('CHAVE_').AsString := strChave;
        ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        Open;
      End;

      If Not IsEmpty Then
      Begin
        strTitulo     := FieldByName('SEL_TITULO').AsString;
        strTabela     := FieldByName('SEL_TABELA').AsString;
        strCampoChave := FieldByName('SEL_CAMKEY').AsString;
        strCodBusca   := FieldByName('SEL_CODBUS').AsString;

        pCarregaCampos(FieldByName('AUTOINCREM').AsString);

        If blnCarregarDados Then
          pCarregaDadosConsulta;

        Result := True;

        If Assigned(FDefConsulta) Then
          FDefConsulta.blnSQLConsultaConfigurado := True;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TLoadConsultaSQL.fCarregaConsulta]');
      Result := False;
    End;
  End;

End;

Procedure TLoadConsultaSQL.pCarregaDadosConsulta;
Begin
  With qrySelCon Do
  Begin
    pCarregaNomeColunas(FieldByName('SEL_NOMCOL').AsString);

    pCarregaSQL(FieldByName('SEL_SQLRUN').AsString);

    pConfiguraCampos(FDefConsulta);
  End;
End;

Function TLoadConsultaSQL.fNumeroSubColsultasProgramador: Integer;
  Var
    intContador: Integer;
Begin
  Result := 0;

  If Assigned(FDefConsulta) Then
    For intContador := High(FDefConsulta.arrSubCon) Downto Low(FDefConsulta.arrSubCon) Do
      If Not fCampoDefinidoPeloUsuaio(FDefConsulta.arrSubCon[intContador].strAlias_) Then
        Inc(Result);

End;

Procedure TLoadConsultaSQL.pCarregaNomeColunas(strNomes: String);
  Var
    sltTitulos: TStringList;
    intPosConsulta,
    intContador,
    intTamDefConsulta,
    intTamCamposObrigatorios: Integer;
Begin
  sltTitulos := TStringList.Create;
  sltTitulos.CommaText := strNomes;

  intTamDefConsulta := fNumeroSubColsultasProgramador;

  intTamCamposObrigatorios := 0;
  For intContador := Low(FCampoObrigatorios) To High(FCampoObrigatorios) Do
    If (Not FCampoObrigatorios[intContador].strTitulo.IsEmpty) Then
      Inc(intTamCamposObrigatorios);

  SetLength(arrNomeColunas, sltTitulos.Count + intTamDefConsulta + intTamCamposObrigatorios);

  intPosConsulta := 0;

  If Assigned(FDefConsulta) Then
    For intContador := Low(FDefConsulta.arrSubCon) To High(FDefConsulta.arrSubCon) Do
      If Not fCampoDefinidoPeloUsuaio(FDefConsulta.arrSubCon[intContador].strAlias_) Then
      Begin
        arrNomeColunas[intPosConsulta] := AnsiReplaceStr(FDefConsulta.arrSubCon[intContador].strTitulo, '"', '');
        Inc(intPosConsulta);
      End;

  For intContador := 0 To sltTitulos.Count - 1 Do
    arrNomeColunas[intContador + intTamDefConsulta] := AnsiReplaceStr(sltTitulos[intContador], '"', '');

  For intContador := Low(FCampoObrigatorios) To High(FCampoObrigatorios) Do
    If (Not FCampoObrigatorios[intContador].strTitulo.IsEmpty) Then
      arrNomeColunas[intContador + intTamDefConsulta + sltTitulos.Count] := AnsiReplaceStr(FCampoObrigatorios[intContador].strTitulo, '"', '');

  FreeAndNil(sltTitulos);
End;

Procedure TLoadConsultaSQL.pSetaWhereAdicional(strWhere: String);
Begin
  If SameText(Trim(AnsiReplaceStr(strWhere, '  ', ' ')), 'AND TRUE') Then
    strWhere := '';

  FWhereAdicional := fSafeSQLValue(strWhere);
End;

Procedure TLoadConsultaSQL.pSetaGroupByAdicional(strGroupBy: String);
Begin
  FGroupByAdicional := strGroupBy;
End;

Function TLoadConsultaSQL.fGetPosWherePrincipal(strSQL: String): Integer;
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

Procedure TLoadConsultaSQL.pCarregaSQL(strSQL: String);

  Procedure pIncluiSubSelectsConfiguraveis;
    Var
      intContador,
      intPosSelect: Integer;
  Begin
    intPosSelect := Pos('SELECT', arrSql[0]);

    If intPosSelect > 0 Then
    Begin
      Inc(intPosSelect, Succ(Length('SELECT')));

      If Assigned(FDefConsulta) Then
        For intContador := High(FDefConsulta.arrSubCon) Downto Low(FDefConsulta.arrSubCon) Do
          If Not fCampoDefinidoPeloUsuaio(FDefConsulta.arrSubCon[intContador].strAlias_) Then
            System.Insert(FDefConsulta.arrSubCon[intContador].strAlias_ + ', ', arrSql[0], intPosSelect);
    End;
  End;

  Procedure pIncluiCamposOrigatorios(blnConfiguraveis: Boolean);
    Var
      intContador,
      intPosFrom: Integer;
  Begin
    intPosFrom := Pred(Pos('FROM', arrSql[0]));

    If intPosFrom > 0 Then
    Begin

      For intContador := Low(FCampoObrigatorios) To High(FCampoObrigatorios) Do
        If ((blnConfiguraveis And (Not FCampoObrigatorios[intContador].strTitulo.IsEmpty)) Or
            ((Not blnConfiguraveis) And FCampoObrigatorios[intContador].strTitulo.IsEmpty)) And
           (Not fCampoDefinidoPeloUsuaio(FCampoObrigatorios[intContador].strCampo)) Then
        Begin
          System.Insert(', ' + FCampoObrigatorios[intContador].strCampo + ' ', arrSql[0], intPosFrom);

          intPosFrom := Pred(Pos('FROM', arrSql[0]));
        End;

    End;

  End;

  Procedure pIncluiJoins;
    Var
      blnIncluiJoin: Boolean;
      stlJoinAdicional: TStringList;
      strInicio: String;
      intContador,
      intPosHaving,
      intPos: Integer;
  Begin
    If Assigned(stlJoins) And (stlJoins.Count > 0) Then
    Begin
      stlJoinAdicional := TStringList.Create;

      For intContador := 0 To stlJoins.Count -1 Do
      Begin
        blnIncluiJoin := True;

        intPos := Pos(' ON ', stlJoins[intContador]);

        If intPos > 0 Then
        Begin
          strInicio := Trim(LeftStr(stlJoins[intContador], intPos));

          blnIncluiJoin := Pos(strInicio, arrSql[0]) = 0;
        End;

        If blnIncluiJoin Then
          stlJoinAdicional.Add(stlJoins[intContador]);
      End;

      intPosHaving := Pred(Pos('HAVING', arrSql[0]));

      If intPosHaving > 0 Then
        System.Insert(stlJoinAdicional.Text + ' ', arrSql[0], intPosHaving)
      Else
        arrSql[0] := arrSql[0] + stlJoinAdicional.Text;

      FreeAndNil(stlJoinAdicional);
    End;

  End;

  Procedure pIncluiWhere;
    Var
      strSelect,
      strWhere,
      strGroupBy,
      strHaving: String;
      intPosGroupBy,
      intPosWhere,
      intPosHaving: Integer;
  Begin
    strHaving := '';

    intPosWhere := fGetPosWherePrincipal(strSQL);

    If intPosWhere > 0 Then // SEPARA O WHERE DO SQL
    Begin
      strSelect := LeftStr(strSQL, Pred(intPosWhere));
      strWhere  := RightStr(strSQL, Length(strSQL) - Pred(intPosWhere));

      intPosGroupBy := Pos('GROUP', strWhere);

      If intPosGroupBy > 0 Then
      Begin
        strGroupBy  := RightStr(strWhere, Length(strWhere) - Pred(intPosGroupBy));
        strWhere    := LeftStr(strWhere, Pred(intPosGroupBy));

        intPosHaving := Pos('HAVING', strGroupBy);

        If intPosHaving > 0 Then
        Begin
          strHaving  := RightStr(strGroupBy, Length(strGroupBy) - Pred(intPosHaving));
          strGroupBy := LeftStr(strGroupBy, Pred(intPosHaving));
        End;

      End Else
      Begin

        intPosHaving := Pos('HAVING', strWhere);

        If intPosHaving > 0 Then
        Begin
          strHaving := RightStr(strWhere, Length(strWhere) - Pred(intPosHaving));
          strWhere  := LeftStr(strWhere, Pred(intPosHaving));
        End;

      End;


      strWhere := strWhere + FWhereAdicional;

      If intPosGroupBy > 0 Then
        SetLength(arrSql, 3)
      Else
        SetLength(arrSql, 2);

      arrSql[0] := strSelect;
      arrSql[1] := strWhere;

      If intPosGroupBy > 0 Then
        arrSql[2] := strGroupBy;

      If intPosHaving > 0 Then
      Begin
        SetLength(arrSql, Succ(Length(arrSql)));
        arrSql[High(arrSql)] := strHaving;
      End;

    End Else // SELECT SEM O WHERE - ENTÃO NÃO TEM HAVING NEM GROUP BY
    Begin

      strSelect := strSQL;

      If FWhereAdicional.IsEmpty Then
      Begin
        SetLength(arrSql, 1);
      End Else
      Begin
        SetLength(arrSql, 2);

        FWhereAdicional := Trim(FWhereAdicional);

        If AnsiStartsStr('AND', FWhereAdicional) Then
          arrSql[1] := ' WHERE TRUE ' + FWhereAdicional
        Else
          arrSql[1] := ' WHERE TRUE AND ' + FWhereAdicional;
      End;

      arrSql[0] := strSelect;

    End;

    If (Not FGroupByAdicional.IsEmpty) And strHaving.IsEmpty Then
    Begin
      SetLength(arrSql, 3);
      arrSql[2] := FGroupByAdicional;
    End;

  End;

  Procedure pAjustaSQL;
    Var
      intContador: Integer;
      blnErro: Boolean;
  Begin
    For intContador := Low(arrSql) To High(arrSql) Do
      arrSql[intContador] := TConfiguraSQLConsulta.fTrataSQLRun(arrSql[intContador], True, blnErro);
  End;

Begin
  pIncluiWhere;
  pIncluiJoins;
  pIncluiSubSelectsConfiguraveis;
  pIncluiCamposOrigatorios(True);
  pIncluiCamposOrigatorios(False);
  pAjustaSQL;
End;

Procedure TLoadConsultaSQL.pSetaParametroStr(strNomPar, strValPar: String);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrSql) To High(arrSql) Do
    arrSql[intContador] := AnsiReplaceStr(arrSql[intContador], strNomPar, QuotedStr(strValPar));
End;

Procedure TLoadConsultaSQL.pSetaParametroInt(strNomPar: String; intValPar: Integer);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrSql) To High(arrSql) Do
    arrSql[intContador] := AnsiReplaceStr(arrSql[intContador], strNomPar, IntToStr(intValPar));
End;

Procedure TLoadConsultaSQL.pSetaParametroFlt(strNomPar: String; fltValPar: Double);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrSql) To High(arrSql) Do
    arrSql[intContador] := AnsiReplaceStr(arrSql[intContador], strNomPar, AnsiReplaceStr(FormatFloat('#0.0', fltValPar), ',', '.'));
End;

Procedure TLoadConsultaSQL.pSetaParametroBln(strNomPar: String; blnValPar: Boolean);
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrSql) To High(arrSql) Do
    arrSql[intContador] := AnsiReplaceStr(arrSql[intContador], strNomPar, IIF(blnValPar, 'TRUE', 'FALSE'));
End;

Function TLoadConsultaSQL.fRetiraClausula(strNomPar, strValor: String): String;
  Var
    intIni,
    intFin,
    intPos,
    intPosStr,
    intContador{,
    intPosNomCam}: Integer;
    strSQL,
    strNomCam: String;
    blnParar,
    blnAchouOperador: Boolean;
Begin
//  intPosNomCam := 0;

  If Length(arrSql) < 2 Then
    Exit;

  strSQL := arrSql[1];

  strNomCam    := '';

  blnParar := False;
  blnAchouOperador := False;

  intPosStr := 1;

  While Pos(':' + strNomPar, strSQL, intPosStr) > 0 Do
  Begin
    intPos := Pos(':' + strNomPar, strSQL, intPosStr);
    intIni := -1;
    intFin := -1;

    For intContador := intPos To Length(strSQL) Do
    Begin

      If strSQL[intContador] = '[' Then
        Break;

      If strSQL[intContador] = ']' Then
      Begin
        intFin := intContador;
        Break;
      End;

    End;

    If intFin <> -1 Then
      For intContador := intPos DownTo 1 Do
      Begin
        If strSQL[intContador] = ']' Then
          Break;

        If strSQL[intContador] = '[' Then
        Begin
          intIni := intContador;
          Break;
        End;

        If CharInSet(strSQL[intContador], ['>', '<', '=']) Then
          blnAchouOperador := True;

        If blnAchouOperador And (Not CharInSet(strSQL[intContador], ['>', '<', '='])) Then
        Begin
          If (strSQL[intContador] = ' ') And (Not fEmptyStr(strNomCam)) Then
          Begin
            blnParar := True;
          End;

          If Not blnParar Then
          Begin
            strNomCam    := Trim(strSQL[intContador]) + strNomCam;
           // intPosNomCam := intContador;
          End;
        End;
      End;

    strNomCam := Trim(strNomCam);

    If (intIni > 0) And (intFin > 0) Then
    Begin
      (*
      If fEhParametroEmpresa(strNomPar) Then
      Begin
        strSQL := fPoeMultiSelecao(strSQL, strNomPar, fEmpAcessoToValPar);
      End

      Else If FDacPor And fEhParametroPortador(strNomPar) Then
      Begin
        strSQL := fPoeMultiSelecao(strSQL, strNomPar, fPortadorUsuarioToValPar(strNomCam), strNomCam, intPosNomCam);
        intPosNomCam := 0;
        strNomCam    := '';

        blnParar := False;
        blnAchouOperador := False;
        intPosStr := 1;

      End Else
      *)

      Begin

        Delete(strSQL, intIni, intFin - IntIni + 1);

        strSQL.Insert(intIni, strValor);

      End

    End Else
    Begin
      blnParar := False;
      blnAchouOperador := False;
      intPosStr := intPos + Length(':' + strNomPar);
    End;
  End;

  Result := strSQL;
End;

Procedure TLoadConsultaSQL.pCompletaWhere(strWhere: String);
Begin
  If Length(arrSql) < 2 Then
  Begin
    SetLength(arrSql, 2);

    arrSql[1]:= ' WHERE TRUE ';
  End;

  arrSql[1] := arrSql[1] + strWhere;
End;

Procedure TLoadConsultaSQL.pCarregaEstilos(strCampo, strEstilos: String; objDefConsulta: TDefConsulta);
  Var
    cdsEstilos: TEstilos;
    intIndice: Integer;
Begin
  If strEstilos.IsEmpty Then
    Exit;

  cdsEstilos := TEstilos.Create(Nil);

  If cdsEstilos.fCarregaEstilos(strEstilos) Then
  Begin
    FCampoEstilo := strCampo;

    SetLength(FArrStyle, cdsEstilos.RecordCount);

    cdsEstilos.First;

    intIndice := 0;

    While Not cdsEstilos.Eof Do
    Begin
      FArrStyle[intIndice].cxsEstilo   := TcxStyle.Create(Nil);

      FArrStyle[intIndice].cxsEstilo.TextColor := cdsEstilos.FieldByName('COR').AsInteger;

      If Pos('N', cdsEstilos.FieldByName('FONTE').AsString) > 0 Then
        FArrStyle[intIndice].cxsEstilo.Font.Style := FArrStyle[intIndice].cxsEstilo.Font.Style + [fsBold];

      If Pos('I', cdsEstilos.FieldByName('FONTE').AsString) > 0 Then
        FArrStyle[intIndice].cxsEstilo.Font.Style := FArrStyle[intIndice].cxsEstilo.Font.Style + [fsItalic];

      If Pos('S', cdsEstilos.FieldByName('FONTE').AsString) > 0 Then
        FArrStyle[intIndice].cxsEstilo.Font.Style := FArrStyle[intIndice].cxsEstilo.Font.Style + [fsUnderline];

      FArrStyle[intIndice].strValor    := cdsEstilos.FieldByName('VALOR').AsString;
      FArrStyle[intIndice].strOperador := cdsEstilos.FieldByName('OPERADOR').AsString;

      cdsEstilos.Next;

      Inc(intIndice);
    End;

    objDefConsulta.funcGetCellStyle := fGetCellStyle;

  End;

  FreeAndNil(cdsEstilos);
End;

Procedure TLoadConsultaSQL.pLiberaEstilos;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FArrStyle) To High(FArrStyle) Do
    If Assigned(FArrStyle[intContador].cxsEstilo) Then
      FreeAndNil(FArrStyle[intContador].cxsEstilo);

  SetLength(FArrStyle, 0);
End;

function TLoadConsultaSQL.fRetornaEstilo(varValorCampo: Variant; tipTipo: TFieldType): TcxStyle;
  Var
    varCfgValor: Variant;
    intContador: Integer;
Begin
  Result := Nil;

  For intContador := Low(FArrStyle) To High(FArrStyle) Do
  Begin

    Case tipTipo Of
      ftInteger,
      ftLargeint,
      ftWord     : varCfgValor := StrToIntDef(FArrStyle[intContador].strValor, -1);

      ftFloat,
      ftCurrency: varCfgValor := fStrToFloat(FArrStyle[intContador].strValor);

      Else  varCfgValor := FArrStyle[intContador].strValor;
    End;

    If varValorCampo = varCfgValor Then
    Begin

      If (FArrStyle[intContador].strOperador = '=') Then
        Result := FArrStyle[intContador].cxsEstilo

      Else If (FArrStyle[intContador].strOperador = '<>') And
              (varValorCampo <> varCfgValor) Then
        Result := FArrStyle[intContador].cxsEstilo

      Else If (FArrStyle[intContador].strOperador = '>') And
              (varValorCampo > varCfgValor) Then
        Result := FArrStyle[intContador].cxsEstilo

      Else If (FArrStyle[intContador].strOperador = '<') And
              (varValorCampo < varCfgValor) Then
        Result := FArrStyle[intContador].cxsEstilo

      Else If (FArrStyle[intContador].strOperador = '<=') And
              (varValorCampo <= varCfgValor) Then
        Result := FArrStyle[intContador].cxsEstilo

      Else If (FArrStyle[intContador].strOperador = '>=') And
              (varValorCampo >= varCfgValor) Then
        Result := FArrStyle[intContador].cxsEstilo;

      If Assigned(Result) Then
        Exit;
    End;

  End;

End;

function TLoadConsultaSQL.fGetCellStyle(AView: TcxGridDBTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; ADataSet: TDataSet): TcxStyle;
  Var
    intIndiceCampo: Integer;
begin
  intIndiceCampo := AView.GetColumnByFieldName(FCampoEstilo).Index;

  If intIndiceCampo > -1 Then
    Result := fRetornaEstilo(AView.DataController.Values[ARecord.Index, intIndiceCampo],
                             AView.GetColumnByFieldName(FCampoEstilo).DataBinding.Field.DataType)
  Else
    Result := Nil;
end;

Class Function TLoadConsultaSQL.fUsaConsultaConfigurada(strTitulo: String; Var objLoadSql: TLoadConsultaSQL; objDefConsulta: TDefConsulta; blnCarregarDados: Boolean = True): Boolean;
Begin
  objLoadSql := TLoadConsultaSQL.Create;

  objDefConsulta.funcConfiguraConsulta := TfrmConfiguraSQLConsultaEdicao.fConfiguraConsulta;
  objDefConsulta.strChaveConsulta      := TLoadConsultaSQL.fGetChaveConsulta(strTitulo);

  Result := objLoadSql.fCarregaConsulta(TLoadConsultaSQL.fGetChaveConsulta(strTitulo), objDefConsulta, blnCarregarDados);
End;

end.




