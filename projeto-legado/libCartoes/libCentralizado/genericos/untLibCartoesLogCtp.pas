unit untLibCartoesLogCtp;

interface

uses System.SysUtils, Vcl.Forms, Data.DB, System.StrUtils,

     Uni,

     untTLibCartoesFuncoes, untTBatchSQL, untTBatchSQL.Helper;

Var
  FCamposCadPag,
  FCamposLogCtp,
  FParametrosLogCtp: String;

  FDataExecutavel: TDateTime;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTP_DTALOG', 'CTP_HORLOG', 'CTP_OPELOG', 'CTP_DESCRI',
                                            'CTP_NOMFRM', 'CTP_NOMEXE', 'CTP_VEREXE', 'CTP_DTAEXE', 'CTP_HOREXE','CTP_NOMTAB'];
  FArrayCamposCalculados: Array of String = ['CTP_NUMENT', 'CTP_ESPENT', 'CTP_EMPENT', 'CTP_SERENT',
                                            'CTP_FORENT'];


  procedure GeraListaDeCamposLOGCTP;

  procedure GravaLogCtp(AAutoIncrem,
                        ADescricao,
                        ANomeFormulario: String;
                        AAutoIncremLogCtp: String = '';
                        ABatchSQL: TBatchSQL = Nil);

  function MontaLogCtp(ACadPag: TDataSet;
                       ADescricao,
                       ANomeFormulario: String;
                       AAutoIncremLogCtp: String = ''): TUniQuery;

implementation

uses System.DateUtils, System.Variants, System.Generics.Collections;

Var
  FDefaultsCadPagDivergentes: TDictionary<String, Variant>;

procedure CarregaDefaultsCadPagDivergentes;
  Var
    LConsulta: TUniQuery;
    LDefaults: TDictionary<String, Variant>;
Begin
  If Assigned(FDefaultsCadPagDivergentes) Then
    Exit;

  LConsulta := Nil;
  LDefaults := TDictionary<String, Variant>.Create;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text :=
      'SELECT C.COLUMN_NAME, C.COLUMN_DEFAULT ' +
      'FROM information_schema.COLUMNS C ' +
      'JOIN information_schema.COLUMNS L ON L.TABLE_SCHEMA = C.TABLE_SCHEMA ' +
      '                                 AND L.TABLE_NAME = ''LOGCTP'' ' +
      '                                 AND L.COLUMN_NAME = C.COLUMN_NAME ' +
      'WHERE C.TABLE_SCHEMA = DATABASE() ' +
      '  AND C.TABLE_NAME = ''CADPAG'' ' +
      '  AND NOT (C.COLUMN_DEFAULT <=> L.COLUMN_DEFAULT) ' +
      '  AND IFNULL(C.COLUMN_DEFAULT, '''') NOT LIKE ''CURRENT_TIMESTAMP%''';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      If LConsulta.FieldByName('COLUMN_DEFAULT').IsNull Then
        LDefaults.AddOrSetValue(UpperCase(LConsulta.FieldByName('COLUMN_NAME').AsString), Null)
      Else
        LDefaults.AddOrSetValue(UpperCase(LConsulta.FieldByName('COLUMN_NAME').AsString),
                                LConsulta.FieldByName('COLUMN_DEFAULT').AsString);
      LConsulta.Next;
    End;

    FDefaultsCadPagDivergentes := LDefaults;
    LDefaults := Nil;
  Finally
    LDefaults.Free;
    TLibCartoesFuncoes.FreeAndNilDatasets(LConsulta);
  End;
End;

procedure PreencheCamposDoLogCtp(ALog: TUniQuery;
                                 ADescricao,
                                 ANomeFormulario,
                                 AAutoIncremLogCtp: String);
Begin
  ALog.ParamByName('AUTOINCREM').AsString := AAutoIncremLogCtp;

  If AAutoIncremLogCtp.IsEmpty Then
    ALog.ParamByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('LOGCTP', VS_FuncoesExternas.fIRetEmpresaLogada);

  ALog.ParamByName('CTP_DTALOG').AsDateTime := VS_FuncoesExternas.fIGetVS_Date;
  ALog.ParamByName('CTP_HORLOG').AsTime     := TLibCartoesFuncoes.RetornaHoraServidor;

  ALog.ParamByName('CTP_OPELOG').AsString   := VS_FuncoesExternas.fIRetOperadorLogado;

  ALog.ParamByName('CTP_NOMTAB').AsString   := 'CADPAG';
  ALog.ParamByName('CTP_DESCRI').AsString   := ADescricao;
  ALog.ParamByName('CTP_NOMFRM').AsString   := ANomeFormulario;

  If FDataExecutavel = 0 Then
    FileAge(Application.ExeName, FDataExecutavel);

  ALog.ParamByName('CTP_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
  ALog.ParamByName('CTP_VEREXE').AsString   := VS_FuncoesExternas.fIGetVersaoProduto;
  ALog.ParamByName('CTP_DTAEXE').AsDateTime := FDataExecutavel;
  ALog.ParamByName('CTP_HOREXE').AsTime     := EncodeTime(HourOf(FDataExecutavel),
                                                 MinuteOf(FDataExecutavel),
                                                 SecondOf(FDataExecutavel),
                                                 MilliSecondOf(FDataExecutavel));
End;

procedure GeraListaDeCamposLOGCTP;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogCtp.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM LOGCTP WHERE FALSE';
    LConsulta.Open;

    FCamposLogCtp := '';
    FParametrosLogCtp := '';

    For LCampo In LConsulta.Fields Do
    Begin
        If MatchStr(LCampo.FieldName, FArrayCamposCalculados) Then
          Continue;
      FCamposLogCtp := FCamposLogCtp + LCampo.FieldName + ',';
      FParametrosLogCtp := FParametrosLogCtp + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogCtp := LeftStr(FCamposLogCtp, FCamposLogCtp.Length - 1);
    FParametrosLogCtp := LeftStr(FParametrosLogCtp, FParametrosLogCtp.Length - 1);

    TLibCartoesFuncoes.FreeAndNilDatasets(LConsulta);
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT * FROM CADPAG WHERE FALSE';
    LConsulta.Open;

    FCamposCadPag := EmptyStr;

    For LCampo In LConsulta.Fields Do
    begin
      If MatchStr(LCampo.FieldName, FArrayCamposCalculados) Then
        Continue;
      FCamposCadPag := FCamposCadPag + LCampo.FieldName + ',';
    End;

    FCamposCadPag := LeftStr(FCamposCadPag, FCamposCadPag.Length - 1);
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LConsulta);
  End;
End;

procedure GravaLogCtp(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AAutoIncremLogCtp: String = '';
                      ABatchSQL: TBatchSQL = Nil);
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LContadorErrosDuplicate: Integer;
Begin
  GeraListaDeCamposLOGCTP;

  LConsulta  := Nil;
  LGravarLog := Nil;
  Try
    LConsulta  := VS_FuncoesExternas.fICriaQuery;
    LGravarLog := VS_FuncoesExternas.fICriaQuery;

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadPag + ' FROM CADPAG WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGCTP (' + FCamposLogCtp + ') ' +
                             ' VALUES (' + FParametrosLogCtp + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;
        If MatchStr(LCampo.FieldName, FArrayCamposCalculados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      PreencheCamposDoLogCtp(LGravarLog, ADescricao, ANomeFormulario, AAutoIncremLogCtp);

      LContadorErrosDuplicate := 0;
      While LContadorErrosDuplicate <= 5 Do
      Begin
        Try
          If Assigned(ABatchSQL) Then
            TBatchHelper.AddQueryToBatch(ABatchSQL, LGravarLog)
          Else
            LGravarLog.ExecSQL;
        Except
          On E: Exception Do
          Begin
            If LContadorErrosDuplicate >= 5 Then
              Raise;

            If E.Message.Contains('Duplicate entry') Then
            Begin
              If E.Message.Contains('PRIMARY') And E.Message.Contains(LGravarLog.ParamByName('AUTOINCREM').AsString) Then
                LGravarLog.ParamByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('LOGCTP', VS_FuncoesExternas.fIRetEmpresaLogada)
              Else
                Raise;

              Inc(LContadorErrosDuplicate);
              Continue;
            End;

            Raise;
          End;
        End;

        Break;
      End;
    End;
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LConsulta);
    TLibCartoesFuncoes.FreeAndNilDatasets(LGravarLog);
  End;
End;

function MontaLogCtp(ACadPag: TDataSet;
                     ADescricao,
                     ANomeFormulario: String;
                     AAutoIncremLogCtp: String = ''): TUniQuery;
  Var
    LCampo: TField;

    LCamposLogCtp: TArray<String>;

    LCampos,
    LParametros: String;

    LDefault: Variant;
Begin
  GeraListaDeCamposLOGCTP;
  CarregaDefaultsCadPagDivergentes;

  LCamposLogCtp := FCamposLogCtp.Split([',']);

  LCampos := 'AUTOINCREM,CTP_DTALOG,CTP_HORLOG,CTP_OPELOG,CTP_NOMTAB,CTP_DESCRI,' +
             'CTP_NOMFRM,CTP_NOMEXE,CTP_VEREXE,CTP_DTAEXE,CTP_HOREXE';
  LParametros := ':' + ReplaceStr(LCampos, ',', ',:');

  For LCampo In ACadPag.Fields Do
  Begin
    If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Or
       MatchStr(LCampo.FieldName, FArrayCamposCalculados) Or
       LCampo.ReadOnly Then
      Continue;

    If LCampo.IsNull And
       (Not (LCampo.DataType In [ftMemo, ftFmtMemo, ftWideMemo, ftBlob, ftGraphic])) And
       (Not FDefaultsCadPagDivergentes.ContainsKey(UpperCase(LCampo.FieldName))) Then
      Continue;

    If Not MatchText(LCampo.FieldName, LCamposLogCtp) Then
      Continue;

    LCampos     := LCampos + ',' + LCampo.FieldName;
    LParametros := LParametros + ',:' + LCampo.FieldName;
  End;

  Result := VS_FuncoesExternas.fICriaQuery;
  Try
    Result.SQL.Text := 'INSERT INTO LOGCTP (' + LCampos + ') ' +
                       ' VALUES (' + LParametros + ') ';

    For LCampo In ACadPag.Fields Do
    Begin
      If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
        Continue;

      If Result.FindParam(LCampo.FieldName) = Nil Then
        Continue;

      If Not LCampo.IsNull Then
        Result.ParamByName(LCampo.FieldName).Value := LCampo.Value
      Else If LCampo.DataType In [ftMemo, ftFmtMemo, ftWideMemo, ftBlob, ftGraphic] Then
        Result.ParamByName(LCampo.FieldName).AsString := ''
      Else If FDefaultsCadPagDivergentes.TryGetValue(UpperCase(LCampo.FieldName), LDefault) Then
        Result.ParamByName(LCampo.FieldName).Value := LDefault;
    End;

    PreencheCamposDoLogCtp(Result, ADescricao, ANomeFormulario, AAutoIncremLogCtp);
  Except
    Result.Free;
    Raise;
  End;
End;

Initialization
  FDefaultsCadPagDivergentes := Nil;

Finalization
  FreeAndNil(FDefaultsCadPagDivergentes);

end.
