unit untTPagSeguroBaixaCartoes;

interface

Uses System.SysUtils, System.StrUtils, System.Classes, Data.DB, System.Variants,
     System.Generics.Collections,

     Uni, UniClientDataset,

     untTBanMca, untLibCartoesInterfacesTipos, untTPagSeguroFuncoes, untTBatchSQL;

Type
  TBaixaCartoes = class

  private
    class var FBatchSQL: TBatchSQL;

    class function ExecutarScript(AUltimoRegistro: Boolean;
                                  AContador: Integer;
                                  AValorMaximo: Integer = 20): Boolean;
  public
    class property BatchSQL: TBatchSQL read FBatchSQL write FBatchSQL;

    class procedure LiberaBatchSQL;

    class function VerificaSeHaCartoesBaixadosAntesDaBaixa(ARegistros: TDataset): Boolean;
    class function VerificaSeHouveAlteracaoNosCartoesAntesDaBaixa(ARegistros: TDataset): Boolean;
    class function ValidaDadosDigitadosBaixaSintetica(ARegistros: TDataset;
                                                      ADataBaixa,
                                                      APortadorBaixa,
                                                      APortadorTaxa,
                                                      APortadorDebito: String): Boolean;

    class function CalculaDataMinimaParaPortador(ARegistros: TDataset): TDate;

    class function MarcarComoConciliado(AConcil: TCamposConcil;
                                        ARegistro: TDataset): Boolean;

    class function RetornaSequenciaisParaBaixaAnalitica(ADataset: TDataset;
                                                        ABaixaManual,
                                                        ABaixaRegistroDebito,
                                                        ATaxasDesmembradas: Boolean;
                                                        AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;

    class function RetornaSequenciaisParaBaixaSintetica(ARegistros: Array Of TArrBaiSinCar;
                                                        ADataset: TDataset;
                                                        ABaixaManual,
                                                        ABaixaRegistroDebito,
                                                        ATaxasDesmembradas: Boolean;
                                                        AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;

    class procedure GravaMovBanDeTransferencias(ARegistros: TUniClientDataset;
                                                AConciliacao: String;
                                                var ASequenciais: TSequenciaisBaixaCartao);

    class function GravaMovBanAjustes(Var AAjustesLista: array of TArrBaiSinCar;
                                      ASeqLanInicial: Int64 = 0;
                                      AAutoIncremIncial: Int64 = 0): Boolean;

    class function GravaCadPagAjustes(AAjustesLista: array of TArrBaiSinCar;
                                      ASequencialInicial: Int64 = 0;
                                      AAutoIncremIncial: Int64 = 0): Boolean;

    class procedure GravaCadPagTaxasNegociacao(AAjuste: TArrBaiSinCar);
  end;

  procedure Inc64(var AValor: Int64; AIntervalo: Int64 = 1);

implementation

Uses untTLibCartoesMovBan, untTLibCartoesCadPag;

{ TBaixaCartoes }

class function TBaixaCartoes.CalculaDataMinimaParaPortador(
  ARegistros: TDataset): TDate;
  Var
    LRegistros: TUniClientDataset;

    LFiltroAnterior: String;
begin
  LFiltroAnterior := ARegistros.Filter;

  ARegistros.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND REGISTROPIXCARTAO<>' + QuotedStr('S');
  ARegistros.Filtered := True;

  LRegistros := Nil;
  Try
    LRegistros := TPagSeguroFuncoes.CriarClientDataSet(ARegistros);
    LRegistros.IndexFieldNames := 'MCA_DTAREC';

    LRegistros.First;
    Result := LRegistros.FieldByName('MCA_DTAREC').Value;

  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LRegistros);

    ARegistros.Filter   := LFiltroAnterior;
    ARegistros.Filtered := Not LFiltroAnterior.IsEmpty;
  End;
end;

class function TBaixaCartoes.ValidaDadosDigitadosBaixaSintetica(
  ARegistros: TDataset; ADataBaixa, APortadorBaixa, APortadorTaxa,
  APortadorDebito: String): Boolean;
  Var
    LListaEmpresas: TStringList;

    LEmpresasSemAcesso: String;
begin
  LListaEmpresas := Nil;
  Try
    ARegistros.Filter := 'MCA_MARDES = ''M'' AND REGISTROPIXCARTAO<>''S'' AND MCA_DTACAD > ' + ADataBaixa.QuotedString;
    ARegistros.Filtered := True;

    Result := ARegistros.IsEmpty;
    If Not Result Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'Não é possível realizar a baixa pois a data de pagamento é menor que a data de cadastro de alguns dos cartões selecionados. Verifique!', ['&OK']);
      Exit;
    End;

    ARegistros.Filtered := False;
    ARegistros.Filter   := 'MCA_MARDES = ''M'' AND REGISTROPIXCARTAO<>''S'' ';
    ARegistros.Filtered := True;

    LListaEmpresas := TPagSeguroFuncoes.fDatasetDistinctField(ARegistros, 'MCA_CODEMP');

    ARegistros.Filtered := False;

    {*REQ*145940**********RP*}
    Result :=  TPagSeguroFuncoes.fEmpresasTemAcessoPortador(APortadorBaixa, LListaEmpresas, LEmpresasSemAcesso);
    If Not Result Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Cartão Crédito] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;

    Result := TPagSeguroFuncoes.fEmpresasTemAcessoPortador(APortadorTaxa, LListaEmpresas, LEmpresasSemAcesso);
    If Not Result Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Taxa] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;

    Result := TPagSeguroFuncoes.fEmpresasTemAcessoPortador(APortadorDebito, LListaEmpresas, LEmpresasSemAcesso);
    If Not Result Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Cartão Débito] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;
  Finally
    If Assigned(LListaEmpresas) Then
      FreeAndNil(LListaEmpresas);
  End;
end;

class function TBaixaCartoes.VerificaSeHaCartoesBaixadosAntesDaBaixa(
  ARegistros: TDataset): Boolean;
  Var
    LContador: Integer;

    LValores,
    LFilter: String;

    LConsulta: TUniQuery;

    LExecutar: Boolean;
begin
  Result := False;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LFilter := ARegistros.Filter;

    ARegistros.Filter   := 'MCA_MARDES=''M'' AND MCA_AJUSTE= ''N'' AND REGISTROPIXCARTAO<>''S'' ';
    ARegistros.Filtered := True;

    LValores := '';
    LContador := 0;
    While Not ARegistros.Eof Do
    Begin
      LValores := LValores + '"' + ARegistros.FieldByName('AUTOINC').AsString + '",';
      Inc(LContador);

      ARegistros.Next;

      LExecutar := ARegistros.Eof;
      If Not LExecutar Then
        LExecutar := LContador >= 200;

      If LExecutar Then
      Begin
        LConsulta.Close;
        LConsulta.SQL.Text := 'SELECT MCA_DTAREC FROM MOVCAR WHERE AUTOINCREM IN (' + LeftStr(LValores, LValores.Length - 1) + ') ' +
                              '       AND MCA_DTAREC IS NOT NULL';
        LConsulta.Open;

        Result := Not LConsulta.IsEmpty;

        If Result Then
          Break;

        LContador := 0;
        LValores := '';
      End;
    End;

  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);

    ARegistros.Filter   := LFilter;
    ARegistros.Filtered := Not LFilter.IsEmpty;
  End;
end;

class function TBaixaCartoes.VerificaSeHouveAlteracaoNosCartoesAntesDaBaixa(ARegistros: TDataset): Boolean;
  Var
    LContador: Integer;

    LValores,
    LFilter: String;

    LConsulta: TUniQuery;

    LExecutar: Boolean;
    strSql : String;
begin
  Result := False;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LFilter := ARegistros.Filter;

    ARegistros.Filter   := 'MCA_MARDES= ' + QuotedStr('M') + ' AND MCA_AJUSTE= ' + QuotedStr('N')+ ' AND REGISTROPIXCARTAO<>' + QuotedStr('S');
    ARegistros.Filtered := True;

    LValores := '';
    LContador := 0;
    While Not ARegistros.Eof Do
    Begin
      LValores := LValores + '"' + ARegistros.FieldByName('AUTOINC').AsString + '",';
      Inc(LContador);

      ARegistros.Next;

      LExecutar := ARegistros.Eof;
      If Not LExecutar Then
        LExecutar := LContador >= 200;

      If LExecutar Then
      Begin

        strSql := '';
        strSql := strSql + 'SELECT                                             ';
        strSql := strSql + '  *                                                ';
        strSql := strSql + 'FROM                                               ';
        strSql := strSql + '  LOGMCA                                           ';
        strSql := strSql + '  INNER JOIN MOVCAR                                ';
        strSql := strSql + '    ON LOGMCA.MCA_NUMDUP = MOVCAR.MCA_NUMDUP       ';
        strSql := strSql + '    AND LOGMCA.MCA_CODCLI = MOVCAR.MCA_CODCLI      ';
        strSql := strSql + '    AND LOGMCA.MCA_PARCEL = MOVCAR.MCA_PARCEL      ';
        strSql := strSql + '    AND LOGMCA.MCA_CODEMP = MOVCAR.MCA_CODEMP      ';
        strSql := strSql + 'WHERE MOVCAR.AUTOINCREM IN ('+LeftStr(LValores, LValores.Length - 1)+')  ';
        strSql := strSql + '  AND  LOGMCA.MCA_DTALOG >= :DTAFIL                ';
        strSql := strSql + '  AND  LOGMCA.MCA_HORLOG > :HROFIL                 ';
        strSql := strSql + 'LIMIT 1                                            ';

        Try
          LConsulta.Close;
          LConsulta.SQL.Clear;
          LConsulta.SQL.Text := strSql;
          LConsulta.ParamByName('DTAFIL').AsString := FormatDateTime('yyyy-mm-dd',ARegistros.FieldByName('HRAFILCAR').AsDateTime);
          LConsulta.ParamByName('HROFIL').AsString := FormatDateTime('HH:NN:SS',ARegistros.FieldByName('HRAFILCAR').AsDateTime);
          LConsulta.Open;
        Except
          On E: Exception Do
          Raise Exception.Create(E.Message);
        End;

        Result := Not LConsulta.IsEmpty;

        If Result Then
          Break;

        LContador := 0;
        LValores := '';
      End;
    End;

  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);

    ARegistros.Filter   := LFilter;
    ARegistros.Filtered := Not LFilter.IsEmpty;
  End;
end;

class function TBaixaCartoes.ExecutarScript(AUltimoRegistro: Boolean; AContador,
  AValorMaximo: Integer): Boolean;
begin
  Result := AUltimoRegistro;

  If Not Result Then
    Result := AContador >= AValorMaximo;
end;

class procedure TBaixaCartoes.GravaMovBanDeTransferencias(
  ARegistros: TUniClientDataset; AConciliacao: String; var ASequenciais: TSequenciaisBaixaCartao);
  Var
    LFiltroAnterior,
    LSeqlanDebito,
    LSeqlanTransferencia,
    LSequencialContraPartida,
    LPlContasLancDebito: String;
begin
  LFiltroAnterior := ARegistros.Filter;

  Try
    ARegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''S'' ';

    While Not ARegistros.Eof Do
    Begin
      LSequencialContraPartida := VS_FuncoesExternas.fIRetSequencial('SCTPAR');
      LSeqlanDebito := TPagSeguroFuncoes.fStrZero(ASequenciais.intSeqLan.ToString, 11);
      Inc64(ASequenciais.intSeqLan);
      LSeqlanTransferencia := TPagSeguroFuncoes.fStrZero(ASequenciais.intSeqLan.ToString, 11);
      Inc64(ASequenciais.intSeqLan);

      LPlContasLancDebito := TPagSeguroFuncoes.IIF(TPagSeguroFuncoes.fEmptyStr(ARegistros.FieldByName('PLANODECONTASTRANSFERENCIALANCDEB').AsString),
                                                  ARegistros.FieldByName('CAR_CTABAI').AsString,
                                                  ARegistros.FieldByName('PLANODECONTASTRANSFERENCIALANCDEB').AsString);

      //Grava a MOVBAN de débito do portador da Baixa
      TLibCartoesMovBan.GravaMovBan(LPlContasLancDebito,
                                    ARegistros.FieldByName('CAR_PORBAI').AsString,
                                    VS_FuncoesExternas.fIRetOperadorLogado,
                                    ARegistros.FieldByName('MCA_DTAREC').AsDateTime,
                                    TPagSeguroFuncoes.RetornaHoraServidor,
                                    '',
                                    'D',
                                    ARegistros.FieldByName('MCA_CODEMP').AsString,
                                    Abs(ARegistros.FieldByName('MCA_VALREC').AsFloat),
                                    'Transferência Conciliação: ' + AConciliacao,
                                    '',
                                    '',
                                    '',
                                    '',
                                    0,
                                    '',
                                    ARegistros.FieldByName('MCA_CODEMP').AsString,
                                    '',
                                    ARegistros.FieldByName('MCA_EVECAN').AsString,
                                    '',
                                    0,
                                    0,
                                    FormatDateTime('MM/yyyy', ARegistros.FieldByName('MCA_DTAREC').AsDateTime),
                                    LSequencialContraPartida,
                                    LSeqlanDebito,
                                    TPagSeguroFuncoes.fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                    '',
                                    '',
                                    1,
                                    True,
                                    Nil,
                                    ARegistros.FieldByName('MCA_CODEMP').AsString);

      Inc64(ASequenciais.intContadorAutIncMovBan);

      //Grava a MOVBAN do crédito para o portador da transferência
      TLibCartoesMovBan.GravaMovBan(ARegistros.FieldByName('PLANODECONTASTRANSFERENCIA').AsString,
                                    ARegistros.FieldByName('PORTADORTRANSFERENCIA').AsString,
                                    VS_FuncoesExternas.fIRetOperadorLogado,
                                    ARegistros.FieldByName('MCA_DTAREC').AsDateTime,
                                    TPagSeguroFuncoes.RetornaHoraServidor,
                                    '',
                                    'C',
                                    ARegistros.FieldByName('MCA_CODEMP').AsString,
                                    Abs(ARegistros.FieldByName('MCA_VALREC').AsFloat),
                                    'Transferência Conciliação: ' + AConciliacao,
                                    '',
                                    '',
                                    '',
                                    '',
                                    0,
                                    '',
                                    ARegistros.FieldByName('MCA_CODEMP').AsString,
                                    '',
                                    ARegistros.FieldByName('CENTRODECUSTOSTRANSFERENCIA').AsString,
                                    '',
                                    0,
                                    0,
                                    FormatDateTime('MM/yyyy', ARegistros.FieldByName('MCA_DTAREC').AsDateTime),
                                    LSequencialContraPartida,
                                    LSeqlanTransferencia,
                                    TPagSeguroFuncoes.fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                    '',
                                    '',
                                    1,
                                    True,
                                    Nil,
                                    ARegistros.FieldByName('MCA_CODEMP').AsString);

      Inc64(ASequenciais.intContadorAutIncMovBan);

      ARegistros.Next;
    End;

  Finally
    ARegistros.Filter := LFiltroAnterior;
    ARegistros.Filtered := Not LFiltroAnterior.IsEmpty;
  End;
end;

class procedure TBaixaCartoes.LiberaBatchSQL;
begin
  If Assigned(FBatchSQL) Then
    FreeAndnil(FBatchSQL);
end;

class function TBaixaCartoes.MarcarComoConciliado(AConcil: TCamposConcil; ARegistro: TDataset): Boolean;
  Var
    LCampos,
    LValores: TStringList;

    LSQL,
    LWhere,
    LInicioCampo: String;

    LContador,
    LContadorCampo: Integer;
Begin
  Result := (Not AConcil.strChavePrimaria.IsEmpty);

  If Not Result Then
    Exit;

  ARegistro.Filter   := 'MCA_MARDES=''M'' AND CHAVECONCILIACAO<>'''' ';
  ARegistro.Filtered := True;

  If ARegistro.IsEmpty Then
    Exit(False);

  LCampos := Nil;
  LValores := Nil;

  Try
    LCampos := TStringList.Create;
    LCampos.Delimiter      := ',';
    LCampos.StrictDelimiter := True;
    LCampos.DelimitedText   := AConcil.strChavePrimaria;

    LValores := TStringList.Create;
    LValores.Delimiter       := '|';
    LValores.StrictDelimiter := True;

    LInicioCampo := LeftStr(AConcil.strChavePrimaria, 4);

    LSQL := 'UPDATE ' + AConcil.TabelaConciliacao + ' SET ' + LInicioCampo + 'CONCIL=1 WHERE ';

    ARegistro.First;
    LWhere    := '';
    LContador := 1;

    While Not ARegistro.Eof Do
    Begin
      LValores.DelimitedText := ARegistro.FieldByName('CHAVECONCILIACAO').AsString;

      LWhere := LWhere + '(';
      For LContadorCampo := 0 To LCampos.Count - 1 Do
        LWhere := LWhere + LCampos[LContadorCampo] + '=' + LValores[LContadorCampo] + ' AND ';

      LWhere := Concat(LeftStr(LWhere, LWhere.Length - 5), ')', ' OR '); //SONAR

      ARegistro.Next;
      Inc(LContador);

      If ExecutarScript(ARegistro.Eof, LContador) Then
      Begin
        Result := TPagSeguroFuncoes.ExecutaSQL(LSQL + LeftStr(LWhere, LWhere.Length - 4));
        LWhere := '';

        LContador := 1;
      End;

    End;
  Finally
    If Assigned(LValores) Then
      FreeAndNil(LValores);

    If Assigned(LCampos) Then
      FreeAndNil(LCampos);
  End;
End;

class function TBaixaCartoes.RetornaSequenciaisParaBaixaAnalitica(
  ADataset: TDataset; ABaixaManual, ABaixaRegistroDebito,
  ATaxasDesmembradas: Boolean; AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;
begin
  {********************************************}
  {* PEGANDO OS SEQLANs NECESSÁRIOS PARA O    *}
  {* BAIXA DE TODOS OS CARTÕES SELECIONADOS   *}
  {*****************************************AJ*}

  Result := TSequenciaisBaixaCartao.Create;

  //Crédito
  Result.intSeqLan               := ADataset.RecordCount;
  Result.intSequencialCadPag     := 0;
  Result.intContadorAutIncBanMca := 0;

  //Para baixa manual
  If ABaixaManual Then
  Begin
    If ABaixaRegistroDebito Then
      Inc64(Result.intSeqLan, ADataset.RecordCount);

    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_VALTAX > 0';
    Inc64(Result.intSeqLan, ADataset.RecordCount);
    Inc64(Result.intSequencialCadPag, ADataset.RecordCount);

    Inc64(Result.intContadorAutIncBanMca, Result.intSeqLan);
  End
  //Para baixa via conciliação automática
  Else
  Begin
    //Débito
    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND CAR_PORBAD IS NOT NULL';
    Inc64(Result.intSeqLan, ADataset.RecordCount);

    //Taxa
    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_VALTAX > 0';
    Inc64(Result.intSeqLan, ADataset.RecordCount);
    Inc64(Result.intSequencialCadPag, ADataset.RecordCount);

    If ATaxasDesmembradas Then
    Begin
      //Fretes
      ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND FRETE_MARKETPLACE > 0';
      Inc64(Result.intSeqLan, ADataset.RecordCount);

      //Ajustes Mkt
      ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND AJUSTE_MARKETPLACE > 0';
      Inc64(Result.intSeqLan, ADataset.RecordCount);

      //Cupons
      ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND CUPOM_MARKETPLACE > 0';
      Inc64(Result.intSeqLan, ADataset.RecordCount);
    End;

    //Antecipação
    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_ANTTAX > 0';
    Inc64(Result.intSeqLan, ADataset.RecordCount);
    Inc64(Result.intSequencialCadPag, ADataset.RecordCount);

    Inc64(Result.intContadorAutIncBanMca, Result.intSeqLan);

    //Ajustes
    Inc64(Result.intSeqLan, AQuantidadeAjustes);
    Inc64(Result.intSequencialCadPag, AQuantidadeAjustes);

    //Transferências
    ADataset.Filter  := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA = ''S'' ';
    Inc64(Result.intSeqLan, ADataset.RecordCount * 2);
  End;

  ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N') + ' AND REGISTROPIXCARTAO = ' + QuotedStr('N');

  Result.intContadorAutIncLogMca := ADataset.RecordCount;

  Result.intContadorAutIncBanMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('BANMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncBanMca), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(VS_FuncoesExternas.fIRetAutoIncrem('CADPAG', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGCTP', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(VS_FuncoesExternas.fIRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;
end;

class function TBaixaCartoes.RetornaSequenciaisParaBaixaSintetica(
  ARegistros: array of TArrBaiSinCar; ADataset: TDataset;
  ABaixaManual, ABaixaRegistroDebito, ATaxasDesmembradas: Boolean;
  AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;
  Var
    LRegistro: TArrBaiSinCar;
begin
  {********************************************}
  {* PEGANDO OS SEQLANs NECESSÁRIOS PARA O    *}
  {* BAIXA DE TODOS OS CARTÕES SELECIONADOS   *}
  {*****************************************AJ*}

  Result := TSequenciaisBaixaCartao.Create;

  //Crédito
  Result.intSeqLan := Length(ARegistros);
  Result.intSequencialCadPag     := 0;
  Result.intContadorAutIncBanMca := 0;

  For LRegistro In ARegistros Do
  Begin
    Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);

    //Debito
    If (Not TPagSeguroFuncoes.fEmptyStr(LRegistro.strPorBad)) Then
    Begin
      Inc64(Result.intSeqLan);
      Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
    End;

    //Taxa
    If LRegistro.fltValTax > 0 Then
    Begin
      Inc64(Result.intSeqLan);
      Inc64(Result.intSequencialCadPag);
      Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
    End;

    If ATaxasDesmembradas Then
    Begin
      //Fretes
      If LRegistro.FreteMarketPlace > 0 Then
      Begin
        Inc64(Result.intSeqLan);
        Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
      End;

      //Ajustes Mkt
      If LRegistro.AjusteMarketPlace > 0 Then
      Begin
        Inc64(Result.intSeqLan);
        Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
      End;

      //Cupons
      If LRegistro.CupomMarketPlace > 0 Then
      Begin
        Inc64(Result.intSeqLan);
        Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
      End;
    End;

    //Antecipação
    If LRegistro.fltValAnt > 0 Then
    Begin
      Inc64(Result.intSeqLan);
      Inc64(Result.intSequencialCadPag);
      Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
    End;
  End;

  //Ajustes
  Inc64(Result.intSeqLan, AQuantidadeAjustes);
  Inc64(Result.intSequencialCadPag, AQuantidadeAjustes);

  //Transferências
  ADataset.Filter := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA = ''S'' ';
  Inc64(Result.intSeqLan, ADataset.RecordCount * 2);

  ADataset.Filter := 'MCA_MARDES = ''M'' AND MCA_AJUSTE = ''N'' AND REGISTROPIXCARTAO = ''N'' ';
  Result.intContadorAutIncLogMca := ADataset.RecordCount;

  Result.intContadorAutIncBanMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('BANMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncBanMca), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(VS_FuncoesExternas.fIRetAutoIncrem('CADPAG', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGCTP', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(VS_FuncoesExternas.fIRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;

  ADataset.Filter   := 'MCA_MARDES = ''M'' AND MCA_AJUSTE = ''N'' AND REGISTROPIXCARTAO = ''N'' ';
end;

class function TBaixaCartoes.GravaMovBanAjustes(Var AAjustesLista: array of TArrBaiSinCar;
  ASeqLanInicial: Int64 = 0; AAutoIncremIncial: Int64 = 0): Boolean;
  Var
    LContador: Integer;

    LSeqlanAtualizar: String;
Begin
  Result := False;

  Try
    For LContador := 0 To Length(AAjustesLista) - 1 Do
    Begin
      AAjustesLista[LContador].strDocBai :=
             TLibCartoesMovBan.GravaMovBan(AAjustesLista[LContador].strCtaBai,  // Centro de Custo
                                           AAjustesLista[LContador].strPorBai,  // Portador
                                           VS_FuncoesExternas.fIRetOperadorLogado,               // Operador
                                           AAjustesLista[LContador].dtaDtaRec,  // Data do Lançamento
                                           TPagSeguroFuncoes.fTime(),                              // Hora do Lançamento
                                           AAjustesLista[LContador].strNumDoc,  // Documento
                                           AAjustesLista[LContador].strTipAju,  // Credito / Debito
                                           AAjustesLista[LContador].strCodEmp,  // Empresa
                                           Abs(AAjustesLista[LContador].fltValDoc), // Valor Documento
                                           AAjustesLista[LContador].strHisDoc,  // Historico 1
                                           EmptyStr,                            // Historico 2
                                           EmptyStr,                            // Cliente
                                           AAjustesLista[LContador].strForTax,  // Fornecedor
                                           EmptyStr,                            // Numero da Duplicata
                                           0,                                   // Sequencial Duplicata
                                           EmptyStr,                            // Parcela da Duplicata
                                           EmptyStr,                            // Empresa da Duplicata
                                           EmptyStr,                             // Série
                                           AAjustesLista[LContador].strEventoCancelamentoAjuste,// Código do Evento
                                           EmptyStr,                            // Documento da Baixa
                                           0,
                                           AAjustesLista[LContador].intPagCon,
                                           FormatDateTime('mm/yyyy', AAjustesLista[LContador].dtaDtaRec),
                                           EmptyStr,
                                           TPagSeguroFuncoes.IIF(ASeqLanInicial > 0, TPagSeguroFuncoes.fStrZero(ASeqLanInicial.ToString, 11), EmptyStr),
                                           TPagSeguroFuncoes.IIF(AAutoIncremIncial > 0, TPagSeguroFuncoes.fFormataAutInc(AAutoIncremIncial, VS_FuncoesExternas.fIRetEmpresaLogada), EmptyStr),
                                           EmptyStr,
                                           EmptyStr,
                                           1,
                                           False,
                                           Nil,
                                           EmptyStr,
                                           'S',
                                           EmptyStr,
                                           EmptyStr,
                                           TBaixaCartoes.BatchSQL);

      LSeqlanAtualizar := '"' + AAjustesLista[LContador].strDocBai + '"';

      If AAjustesLista[LContador].fltValTax > 0 Then
      Begin
        AAjustesLista[LContador].SeqlanTaxaNegociacao :=
             TLibCartoesMovBan.GravaMovBan(AAjustesLista[LContador].PlanoDEContasTaxaNegociacao,  // Centro de Custo
                                           AAjustesLista[LContador].strPorBai,  // Portador
                                           VS_FuncoesExternas.fIRetOperadorLogado,               // Operador
                                           AAjustesLista[LContador].dtaDtaRec,  // Data do Lançamento
                                           TPagSeguroFuncoes.fTime(),                              // Hora do Lançamento
                                           AAjustesLista[LContador].strNumDoc,  // Documento
                                           'D',                                 // Credito / Debito
                                           AAjustesLista[LContador].strCodEmp,  // Empresa
                                           Abs(AAjustesLista[LContador].fltValTax), // Valor Documento
                                           'TX. ' + AAjustesLista[LContador].strHisDoc,  // Historico 1
                                           EmptyStr,                            // Historico 2
                                           EmptyStr,                            // Cliente
                                           AAjustesLista[LContador].strForTax,  // Fornecedor
                                           EmptyStr,                            // Numero da Duplicata
                                           0,                                   // Sequencial Duplicata
                                           EmptyStr,                            // Parcela da Duplicata
                                           EmptyStr,                            // Empresa da Duplicata
                                           EmptyStr,                             // Série
                                           AAjustesLista[LContador].strEventoCancelamentoAjuste,// Código do Evento
                                           EmptyStr,                            // Documento da Baixa
                                           0,
                                           AAjustesLista[LContador].intPagCon,
                                           FormatDateTime('mm/yyyy', AAjustesLista[LContador].dtaDtaRec),
                                           EmptyStr,
                                           EmptyStr,
                                           EmptyStr,
                                           EmptyStr,
                                           EmptyStr,
                                           1,
                                           False,
                                           Nil,
                                           EmptyStr,
                                           'S',
                                           EmptyStr,
                                           EmptyStr,
                                           TBaixaCartoes.BatchSQL);

        LSeqlanAtualizar := LSeqlanAtualizar + ',"' + AAjustesLista[LContador].SeqlanTaxaNegociacao + '"';
      End;

      If ASeqLanInicial > 0 Then
        Inc64(ASeqLanInicial);

      If AAutoIncremIncial > 0 Then
        Inc64(AAutoIncremIncial);

      Result := Not AAjustesLista[LContador].strDocBai.Trim.IsEmpty;

      If Result Then
        TPagSeguroFuncoes.ExecutaSQL('UPDATE MOVBAN SET CTB_ORIGEM="MCA" WHERE CTB_SEQLAN IN (' + LSeqlanAtualizar + ')');
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a movimentação bancária dos ajustes. ' + #13 +
                             'Erro: ' + E.Message);
  End;
End;

class function TBaixaCartoes.GravaCadPagAjustes(AAjustesLista: array of TArrBaiSinCar;
  ASequencialInicial: Int64 = 0; AAutoIncremIncial: Int64 = 0): Boolean;
  Var
    LAjuste: TArrBaiSinCar;

    LGravaAjusteCredito: Boolean;

    LValOri: Double;

    LNumeroDuplicata,
    LAutoIncrem: String;
Begin
  Result := False;

  LGravaAjusteCredito := VS_FuncoesExternas.fICfgSis('AJUCRE', varBoolean);

  Try
    For LAjuste In AAjustesLista Do
    Begin
      If TPagSeguroFuncoes.fFormataFloat(LAjuste.fltValTax, 2) > 0 Then
      Begin
        GravaCadPagTaxasNegociacao(LAjuste);
        Continue;
      End;

      If Not LAjuste.strTipAju.Equals('D') Then
      Begin
        If Not LGravaAjusteCredito Then
          Continue;
      End;

      If ASequencialInicial > 0 Then
      Begin
        LNumeroDuplicata := 'G' + TPagSeguroFuncoes.fStrZero(ASequencialInicial.ToString, 11);
        Inc64(ASequencialInicial);
      End
      Else
        LNumeroDuplicata := VS_FuncoesExternas.fIRetSequencialCadPag;

      LAutoIncrem := EmptyStr;
      If AAutoIncremIncial > 0 Then
      Begin
        LAutoIncrem := TPagSeguroFuncoes.fFormataAutInc(AAutoIncremIncial, VS_FuncoesExternas.fIRetEmpresaLogada);
        Inc64(AAutoIncremIncial);
      End;

      If LAjuste.strTipAju.Equals('D') Then
        LValOri := TPagSeguroFuncoes.IIF(LAjuste.fltValDoc < 0,(LAjuste.fltValDoc * -1),LAjuste.fltValDoc)
      Else
        LValOri := TPagSeguroFuncoes.IIF(LAjuste.fltValDoc > 0,(LAjuste.fltValDoc * -1),LAjuste.fltValDoc);

      Result := TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                              'AJUSTE DE CARTÃO DE CRÉDITO',
                                              LAjuste.strForTax,
                                              LNumeroDuplicata,
                                              'A',
                                              LAjuste.strCodEmp,
                                              LAjuste.strCtaBai,
                                              'CRT',
                                              0,
                                              LAjuste.dtaDtaRec,
                                              LAjuste.dtaDtaRec,
                                              0,
                                              LValOri,
                                              'N',
                                              'N',
                                              'N',
                                              LAjuste.strHisDoc,
                                              EmptyStr,
                                              LAjuste.strHisDoc,
                                              LAjuste.strPorBai,
                                              LAjuste.strCtaBai,
                                              LAjuste.strDocBai,
                                              VS_FuncoesExternas.fIRetOperadorLogado,
                                              LAjuste.dtaDtaRec,
                                              LValOri,
                                              0,
                                              0,
                                              VS_FuncoesExternas.fIRetEmpresaLogada,
                                              LAjuste.strEventoCancelamentoAjuste,
                                              'N',
                                              LAjuste.strPorBai,
                                              LAjuste.strNumDoc,
                                              0.0,
                                              0.0,
                                              LAjuste.intPagCon,
                                              False,
                                              0,
                                              EmptyStr,
                                              0,
                                              'N',
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              LAutoIncrem,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              'N',
                                              FormatDateTime('mm/yyyy', LAjuste.dtaDtaRec),
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              LValOri,
                                              0,
                                              0,
                                              0,
                                              VS_FuncoesExternas.fIRetOperadorLogado,
                                              0,
                                              0,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              '0',
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              'N',
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              EmptyStr,
                                              0,
                                              EmptyStr,
                                              0,
                                              EmptyStr,
                                              0,
                                              0,
                                              0,
                                              0,
                                              EmptyStr,
                                              EmptyStr,
                                              'N',
                                              EmptyStr,
                                              EmptyStr,
                                              FBatchSQL);
    End;
  Except
    Raise;
  End;
End;

class procedure TBaixaCartoes.GravaCadPagTaxasNegociacao(
  AAjuste: TArrBaiSinCar);
  Var
    LNumeroDuplicata: String;
Begin
  Try
    LNumeroDuplicata := VS_FuncoesExternas.fIRetSequencialCadPag;

    TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                  'AJUSTE DE CARTÃO DE CRÉDITO',
                                  AAjuste.strForTax,
                                  LNumeroDuplicata,
                                  'A',
                                  AAjuste.strCodEmp,
                                  AAjuste.PlanoDEContasTaxaNegociacao,
                                  'CRT',
                                  0,
                                  AAjuste.dtaDtaRec,
                                  AAjuste.dtaDtaRec,
                                  0,
                                  AAjuste.fltValTax,
                                  'N',
                                  'N',
                                  'N',
                                  AAjuste.strHisDoc,
                                  EmptyStr,
                                  'TX. ' + AAjuste.strHisDoc,
                                  AAjuste.strPorBai,
                                  AAjuste.PlanoDeContasTaxaNegociacao,
                                  AAjuste.SeqlanTaxaNegociacao,
                                  VS_FuncoesExternas.fIRetOperadorLogado,
                                  AAjuste.dtaDtaRec,
                                  AAjuste.fltValTax,
                                  0,
                                  0,
                                  VS_FuncoesExternas.fIRetEmpresaLogada,
                                  AAjuste.strEventoCancelamentoAjuste,
                                  'N',
                                  AAjuste.strPorBai,
                                  AAjuste.strNumDoc,
                                  0.0,
                                  0.0,
                                  AAjuste.intPagCon,
                                  False,
                                  0,
                                  EmptyStr,
                                  0,
                                  'N',
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  'N',
                                  FormatDateTime('mm/yyyy', AAjuste.dtaDtaRec),
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  AAjuste.fltValTax,
                                  0,
                                  0,
                                  0,
                                  VS_FuncoesExternas.fIRetOperadorLogado,
                                  0,
                                  0,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  '0',
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  'N',
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  EmptyStr,
                                  0,
                                  EmptyStr,
                                  0,
                                  EmptyStr,
                                  0,
                                  0,
                                  0,
                                  0,
                                  EmptyStr,
                                  EmptyStr,
                                  'N',
                                  EmptyStr,
                                  EmptyStr,
                                  FBatchSQL);
  Except
    Raise;
  End;
end;

procedure Inc64(var AValor: Int64; AIntervalo: Int64 = 1);
Begin
  AValor := AValor + AIntervalo;
End;

Initialization
  TBaixaCartoes.FBatchSQL := Nil;

Finalization
  If Assigned(TBaixaCartoes.FBatchSQL) Then
    FreeAndNil(TBaixaCartoes.FBatchSQL);

end.
