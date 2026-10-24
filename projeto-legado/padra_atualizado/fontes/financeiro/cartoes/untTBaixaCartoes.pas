unit untTBaixaCartoes;

interface

Uses System.SysUtils, System.StrUtils, System.Classes, Data.DB, Uni,
     UniClientDataset, untTypesSistema, System.Variants,
     System.Generics.Collections, untTBanMca;

Type
  TBaixaCartoes = class

  private
    class function ExecutarScript(AUltimoRegistro: Boolean;
                                  AContador: Integer;
                                  AValorMaximo: Integer = 20): Boolean;
  public
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

    class procedure MarcaRegistrosConciliadoPelaLista(ARegistrosConciliar: TStringList;
                                                      ACamposConcil: TCamposConcil);

    class procedure GeraRegistroCTPDetDeTaxaParaMarketPlace(out ARegistroCTPDetFrete: TArrBaiSinCar;
                                                            out ARegistroCTPDetAjuste: TArrBaiSinCar;
                                                            ARegistro: TUniClientDataset);

    class function ValidaGravacaoCTPDet(out AGravarFrete: Boolean;
                                        out AGravarAjuste: Boolean;
                                        APlanoDeContas: String;
                                        ARegistroCTPDetFrete,
                                        ARegistroCTPDetAjuste: TArrBaiSinCar): Boolean;

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

    class procedure GravaCTPDetDeTaxaParaMarketPlaceAnalitico(ANumeroDuplicata,
                                                              ACodigoFornecedor,
                                                              ACodigoEmpresa,
                                                              ASerie,
                                                              APlanoDeContas,
                                                              AEventoTaxa: String;
                                                              AValorTotalTaxa: Double;
                                                              ARegistroCTPDetFrete,
                                                              ARegistroCTPDetAjuste: TArrBaiSinCar);

    class procedure GravaCTPDetDeTaxaParaMarketPlaceSintetico(ANumeroDuplicata,
                                                              ACodigoFornecedor,
                                                              ACodigoEmpresa,
                                                              ASerie: String;
                                                              ARegistro: TArrBaiSinCar;
                                                              ACTPDetSintetico: Array of TArrBaiSinCar);

    class procedure GravaMovBanDeTransferencias(ARegistros: TUniClientDataset;
                                                AConciliacao: String;
                                                var ASequenciais: TSequenciaisBaixaCartao);

    class procedure GravarMovBanAnalitoFreteTaxasMarketPlace(ADataset: TDataset;
                                                             var ASequenciais: TSequenciaisBaixaCartao;
                                                             out ASeqLanFrete,
                                                                 ASeqLanAjuste,
                                                                 ASeqLanCupom: String);

    class procedure GravarMovBanSinteticoFreteTaxasMarketPlace(AListaBanMca: TListaBanMCA;
                                                               var ASequenciais: TSequenciaisBaixaCartao;
                                                               ACartoesSintetico: TArrBaiSinCar;
                                                               AHistoricoSintetico: String;
                                                               out ASeqLanFrete,
                                                               ASeqLanAjuste,
                                                               ASeqLanCupom: String);

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
Uses untFuncoesSimples, untFuncoes, untMovBan, untCadPag;

{ TBaixaCartoes }

class function TBaixaCartoes.CalculaDataMinimaParaPortador(
  ARegistros: TDataset): TDate;
  Var
    LRegistros: TUniClientDataset;

    LFiltroAnterior: String;
begin
  LFiltroAnterior := ARegistros.Filter;

  ARegistros.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
  ARegistros.Filtered := True;

  LRegistros := fCriaClientDatSet(ARegistros);

  Try
    LRegistros.IndexFieldNames := 'MCA_DTAREC';

    LRegistros.First;
    Result := LRegistros.FieldByName('MCA_DTAREC').Value;

  Finally
    FreeAndNil(LRegistros);

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
  Result := True;

  Try
    Try
      ARegistros.Filter := 'MCA_MARDES = ''M'' AND MCA_DTACAD > ' + ADataBaixa.QuotedString;
      ARegistros.Filtered := True;

      Result := ARegistros.IsEmpty;
      If Not Result Then
      Begin
        fMensagem('ATENÇÃO', 'Não é possível realizar a baixa pois a data de pagamento é menor que a data de cadastro de alguns dos cartões selecionados. Verifique!', ['&OK']);
        Exit;
      End;

      ARegistros.Filtered := False;
      ARegistros.Filter   := 'MCA_MARDES = ''M''';
      ARegistros.Filtered := True;

      LListaEmpresas := fDatasetDistinctField(ARegistros, 'MCA_CODEMP');

      ARegistros.Filtered := False;

      {*REQ*145940**********RP*}
      Result :=  fEmpresasTemAcessoPortador(APortadorBaixa, LListaEmpresas, LEmpresasSemAcesso);
      If Not Result Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Cartão Crédito] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
        Exit;
      End;

      Result := fEmpresasTemAcessoPortador(APortadorTaxa, LListaEmpresas, LEmpresasSemAcesso);
      If Not Result Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Taxa] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
        Exit;
      End;

      Result := fEmpresasTemAcessoPortador(APortadorDebito, LListaEmpresas, LEmpresasSemAcesso);
      If Not Result Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Cartão Débito] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
        Exit;
      End;
      {************************}
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

  Finally
    If Assigned(LListaEmpresas) Then
      FreeAndNil(LListaEmpresas);
  End;
end;

class function TBaixaCartoes.ValidaGravacaoCTPDet(out AGravarFrete,
  AGravarAjuste: Boolean; APlanoDeContas: String; ARegistroCTPDetFrete,
  ARegistroCTPDetAjuste: TArrBaiSinCar): Boolean;
begin
  AGravarFrete := Not ARegistroCTPDetFrete.strCodEmp.IsEmpty;
  If AGravarFrete Then
    AGravarFrete := ARegistroCTPDetFrete.strCtaTax <> APlanoDeContas;

  AGravarAjuste := Not ARegistroCTPDetAjuste.strCodEmp.IsEmpty;
  If AGravarAjuste Then
    AGravarAjuste := ARegistroCTPDetAjuste.strCtaTax <> APlanoDeContas;

  Result := AGravarFrete;
  If Not Result Then
    Result := AGravarAjuste;
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
  LConsulta := fCriaQuery;
  Result := False;

  Try
    LFilter := ARegistros.Filter;

    ARegistros.Filter   := 'MCA_MARDES=''M'' AND MCA_AJUSTE= ''N'' ';
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
    FreeAndNil(LConsulta);

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
  LConsulta := fCriaQuery;

  Try
    LFilter := ARegistros.Filter;

    ARegistros.Filter   := 'MCA_MARDES= ' + QuotedStr('M') + ' AND MCA_AJUSTE= ' + QuotedStr('N');
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
    FreeAndNil(LConsulta);

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

class procedure TBaixaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(out ARegistroCTPDetFrete: TArrBaiSinCar;
  out ARegistroCTPDetAjuste: TArrBaiSinCar; ARegistro: TUniClientDataset);
begin
  ARegistroCTPDetFrete.strCodEmp := '';
  ARegistroCTPDetFrete.dtaDtaRec := 0;
  ARegistroCTPDetFrete.strPorTax := '';
  ARegistroCTPDetFrete.strCtaTax := '';
  ARegistroCTPDetFrete.strEventoTaxa := '';
  ARegistroCTPDetFrete.fltValTax := 0;

  ARegistroCTPDetAjuste.strCodEmp := '';
  ARegistroCTPDetAjuste.dtaDtaRec := 0;
  ARegistroCTPDetAjuste.strPorTax := '';
  ARegistroCTPDetAjuste.strCtaTax := '';
  ARegistroCTPDetAjuste.strEventoTaxa := '';
  ARegistroCTPDetAjuste.fltValTax := 0;

  If ARegistro.FieldByName('CAR_MKTPLA').AsString = 'N' Then
    Exit;

  If Not ARegistro.FieldByName('CAR_CTAFRE').AsString.IsEmpty Then
  Begin
    If ARegistro.FieldByName('FRETE_MARKETPLACE').AsFloat <> 0 Then
    Begin
      ARegistroCTPDetFrete.strCodEmp := ARegistro.FieldByName('MCA_EMPRCX').AsString;
      ARegistroCTPDetFrete.dtaDtaRec := ARegistro.FieldByName('MCA_DTAREC').AsDateTime;
      ARegistroCTPDetFrete.strPorTax := ARegistro.FieldByName('CAR_PORTAX').AsString;
      ARegistroCTPDetFrete.strCtaTax := ARegistro.FieldByName('CAR_CTAFRE').AsString;
      ARegistroCTPDetFrete.strEventoTaxa := ARegistro.FieldByName('CAR_EVETAX').AsString;
      ARegistroCTPDetFrete.fltValTax := ARegistro.FieldByName('FRETE_MARKETPLACE').AsFloat;
    End;
  End;

  If Not ARegistro.FieldByName('CAR_CTAAJU').AsString.IsEmpty Then
  Begin
    If ARegistro.FieldByName('AJUSTE_MARKETPLACE').AsFloat <> 0 Then
    Begin
      ARegistroCTPDetAjuste.strCodEmp := ARegistro.FieldByName('MCA_EMPRCX').AsString;
      ARegistroCTPDetAjuste.dtaDtaRec := ARegistro.FieldByName('MCA_DTAREC').AsDateTime;
      ARegistroCTPDetAjuste.strPorTax := ARegistro.FieldByName('CAR_PORTAX').AsString;
      ARegistroCTPDetAjuste.strCtaTax := ARegistro.FieldByName('CAR_CTAAJU').AsString;
      ARegistroCTPDetAjuste.strEventoTaxa := ARegistro.FieldByName('CAR_EVETAX').AsString;
      ARegistroCTPDetAjuste.fltValTax := ARegistro.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
    End;
  End;
end;

class procedure TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceAnalitico(
  ANumeroDuplicata, ACodigoFornecedor, ACodigoEmpresa, ASerie,
  APlanoDeContas, AEventoTaxa: String; AValorTotalTaxa: Double;
  ARegistroCTPDetFrete, ARegistroCTPDetAjuste: TArrBaiSinCar);
  Var
    LValorResidual: Double;

    LInsert: TUniQuery;

    LGravarFrete,
    LGravarAjuste: Boolean;
begin

  If (AValorTotalTaxa = 0) Then
    Exit;

  If Not ValidaGravacaoCTPDet(LGravarFrete, LGravarAjuste, APlanoDeContas, ARegistroCTPDetFrete, ARegistroCTPDetAjuste) Then
    Exit;

  LValorResidual := AValorTotalTaxa;

  LInsert := fCriarQuery('SELECT * FROM CTPDET WHERE FALSE');
  LInsert.Open;

  Try
    If LGravarFrete Then
    Begin
      LInsert.Insert;
      LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
      LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
      LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
      LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
      LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_CODCTA').AsString := ARegistroCTPDetFrete.strCtaTax;

      LInsert.FieldByName('CTP_CODEVE').Value := Null;
      If Not ARegistroCTPDetFrete.strEventoTaxa.IsEmpty Then
        LInsert.FieldByName('CTP_CODEVE').AsString := ARegistroCTPDetFrete.strEventoTaxa;

      LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(ARegistroCTPDetFrete.fltValTax) / AValorTotalTaxa;
      LInsert.Post;

      LValorResidual := fFormataFloat(LValorResidual - Abs(ARegistroCTPDetFrete.fltValTax), 2);
    End;

    If LGravarAjuste Then
    Begin
      LInsert.Insert;
      LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
      LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
      LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
      LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
      LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_CODCTA').AsString := ARegistroCTPDetAjuste.strCtaTax;

      LInsert.FieldByName('CTP_CODEVE').Value := Null;
      If Not ARegistroCTPDetAjuste.strEventoTaxa.IsEmpty Then
        LInsert.FieldByName('CTP_CODEVE').AsString := ARegistroCTPDetAjuste.strEventoTaxa;

      LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(ARegistroCTPDetAjuste.fltValTax) / AValorTotalTaxa;
      LInsert.Post;

      LValorResidual := fFormataFloat(LValorResidual - Abs(ARegistroCTPDetAjuste.fltValTax), 2);
    End;

    LInsert.Insert;
    LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
    LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
    LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
    LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
    LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
    LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
    LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
    LInsert.FieldByName('CTP_CODCTA').AsString := APlanoDeContas;

    LInsert.FieldByName('CTP_CODEVE').Value := Null;
    If Not AEventoTaxa.IsEmpty Then
      LInsert.FieldByName('CTP_CODEVE').AsString := AEventoTaxa;

    LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(LValorResidual) / AValorTotalTaxa;

    LInsert.Post;
  Finally
    FreeAndNil(LInsert);
  End;
end;

class procedure TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceSintetico(ANumeroDuplicata,
                                                                        ACodigoFornecedor,
                                                                        ACodigoEmpresa,
                                                                        ASerie: String;
                                                                        ARegistro: TArrBaiSinCar;
                                                                        ACTPDetSintetico: Array of TArrBaiSinCar);
  Var
    LValorTotalTaxa,
    LValorResidual: Double;

    LInsert: TUniQuery;

    LGravarCTPDet: Boolean;

    LContador: Integer;

    LChaveRegistro,
    LChaveComparacao: String;
begin
  LGravarCTPDet := Length(ACTPDetSintetico) > 0;

  If Not LGravarCTPDet Then
    Exit;

  LChaveRegistro := Concat(ARegistro.strCodEmp,
                           DateTimeToStr(ARegistro.dtaDtaRec),
                           ARegistro.strPorBai,
                           ARegistro.strCtaBai,
                           ARegistro.strPorBad,
                           ARegistro.strCtaBad,
                           ARegistro.strPorTax,
                           ARegistro.strCtaTax,
                           ARegistro.strForTax,
                           ARegistro.strEventoCredito,
                           ARegistro.strEventoTaxa,
                           ARegistro.strEveDeb,
                           ARegistro.strCtaAnt);

  LValorResidual := ARegistro.fltValTax +
                    ARegistro.FreteMarketPlace +
                    ARegistro.AjusteMarketPlace;

  LValorTotalTaxa := ARegistro.fltValTax +
                     ARegistro.FreteMarketPlace +
                     ARegistro.AjusteMarketPlace;

  LInsert := fCriarQuery('SELECT * FROM CTPDET WHERE FALSE');
  LInsert.Open;

  Try
    LGravarCTPDet := False;

    For LContador := 0 To Length(ACTPDetSintetico) - 1 Do
    Begin
      LChaveComparacao := Concat(ACTPDetSintetico[LContador].strCodEmp,
                                 DateTimeToStr(ACTPDetSintetico[LContador].dtaDtaRec),
                                 ACTPDetSintetico[LContador].strPorBai,
                                 ACTPDetSintetico[LContador].strCtaBai,
                                 ACTPDetSintetico[LContador].strPorBad,
                                 ACTPDetSintetico[LContador].strCtaBad,
                                 ACTPDetSintetico[LContador].strPorTax,
                                 ACTPDetSintetico[LContador].strCtaTax,
                                 ACTPDetSintetico[LContador].strForTax,
                                 ACTPDetSintetico[LContador].strEventoCredito,
                                 ACTPDetSintetico[LContador].strEventoTaxa,
                                 ACTPDetSintetico[LContador].strEveDeb,
                                 ACTPDetSintetico[LContador].strCtaAnt);

      If LChaveComparacao <> LChaveRegistro Then
        Continue;

      If ACTPDetSintetico[LContador].PlanoDeContasParaCTPDet = ARegistro.strCtaTax Then
        Continue;

      LInsert.Insert;
      LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
      LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
      LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
      LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
      LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_CODCTA').AsString := ACTPDetSintetico[LContador].PlanoDeContasParaCTPDet;

      LInsert.FieldByName('CTP_CODEVE').Value := Null;
      If Not ACTPDetSintetico[LContador].strEventoTaxa.IsEmpty Then
        LInsert.FieldByName('CTP_CODEVE').AsString := ACTPDetSintetico[LContador].strEventoTaxa;

      LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(ACTPDetSintetico[LContador].fltValTax) / LValorTotalTaxa;
      LInsert.Post;

      LValorResidual := fFormataFloat(LValorResidual - Abs(ACTPDetSintetico[LContador].fltValTax), 2);

      LGravarCTPDet := True;
    End;

    If LGravarCTPDet Then
    Begin
      LInsert.Insert;
      LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);
      LInsert.FieldByName('CTP_CODFOR').AsString := ACodigoFornecedor;
      LInsert.FieldByName('CTP_NUMDUP').AsString := ANumeroDuplicata;
      LInsert.FieldByName('CTP_PARCEL').AsString := 'A';
      LInsert.FieldByName('CTP_CODEMP').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_SERIE_').AsString := ASerie;
      LInsert.FieldByName('CTP_EMPORI').AsString := ACodigoEmpresa;
      LInsert.FieldByName('CTP_CODCTA').AsString := ARegistro.strCtaTax;

      LInsert.FieldByName('CTP_CODEVE').Value := Null;
      If Not ARegistro.strEventoTaxa.IsEmpty Then
        LInsert.FieldByName('CTP_CODEVE').AsString := ARegistro.strEventoTaxa;

      LInsert.FieldByName('CTP_FATCAL').AsFloat  := Abs(LValorResidual) / LValorTotalTaxa;

      LInsert.Post;
    End;
  Finally
    FreeAndNil(LInsert);
  End;
end;

class procedure TBaixaCartoes.GravaMovBanDeTransferencias(
  ARegistros: TUniClientDataset; AConciliacao: String; var ASequenciais: TSequenciaisBaixaCartao);
  Var
    LFiltroAnterior,
    LSeqlanDebito,
    LSeqlanTransferencia,
    LSequencialContraPartida: String;
begin
  LFiltroAnterior := ARegistros.Filter;

  Try
    ARegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''S'' ';

    While Not ARegistros.Eof Do
    Begin
      LSequencialContraPartida := fRetSequencial('SCTPAR');
      LSeqlanDebito := fStrZero(ASequenciais.intSeqLan.ToString, 11);
      Inc64(ASequenciais.intSeqLan);
      LSeqlanTransferencia := fStrZero(ASequenciais.intSeqLan.ToString, 11);
      Inc64(ASequenciais.intSeqLan);

      //Grava a MOVBAN de débito do portador da Baixa
      untMovBan.fGravaMovBan(ARegistros.FieldByName('CAR_CTABAI').AsString,
                             ARegistros.FieldByName('CAR_PORBAI').AsString,
                             strLoginUsuarioLogado,
                             ARegistros.FieldByName('MCA_DTAREC').AsDateTime,
                             fRetHoraServidor,
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
                             Nil,
                             0,
                             0,
                             FormatDateTime('MM/yyyy', ARegistros.FieldByName('MCA_DTAREC').AsDateTime),
                             LSequencialContraPartida,
                             LSeqlanDebito,
                             fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                             '',
                             '',
                             1,
                             True,
                             Nil,
                             ARegistros.FieldByName('MCA_CODEMP').AsString);

      Inc64(ASequenciais.intContadorAutIncMovBan);

      //Grava a MOVBAN do crédito para o portador da transferência
      untMovBan.fGravaMovBan(ARegistros.FieldByName('PLANODECONTASTRANSFERENCIA').AsString,
                             ARegistros.FieldByName('PORTADORTRANSFERENCIA').AsString,
                             strLoginUsuarioLogado,
                             ARegistros.FieldByName('MCA_DTAREC').AsDateTime,
                             fRetHoraServidor,
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
                             Nil,
                             0,
                             0,
                             FormatDateTime('MM/yyyy', ARegistros.FieldByName('MCA_DTAREC').AsDateTime),
                             LSequencialContraPartida,
                             LSeqlanTransferencia,
                             fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
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

class procedure TBaixaCartoes.GravarMovBanAnalitoFreteTaxasMarketPlace(ADataset: TDataset;
  var ASequenciais: TSequenciaisBaixaCartao;
  out ASeqLanFrete, ASeqLanAjuste, ASeqLanCupom: String);
  Var
    LSequencialFrete,
    LSequencialAjuste,
    LSequencialCupom: String;

    LListaBanMca: TListaBanMCA;

    LBanMcaDS: TBanMcaDS;
begin
  LSequencialFrete := EmptyStr;
  LSequencialAjuste := EmptyStr;
  LSequencialCupom := EmptyStr;

  LBanMcaDS := TBanMcaDS.Create;
  LBanMcaDS.strNumDup := ADataset.FieldByName('NRODUP').AsString;
  LBanMcaDS.strParcel := ADataset.FieldByName('PARDUP').AsString;
  LBanMcaDS.strCodEmp := ADataset.FieldByName('MCA_CODEMP').AsString;
  LBanMcaDS.strCodCli := ADataset.FieldByName('MCA_CODCLI').AsString;
  LBanMcaDS.strCodCar := ADataset.FieldByName('MCA_CODCAR').AsString;
  LBanMcaDS.strHist01 := ADataset.FieldByName('MCA_HIST01').AsString;
  LBanMcaDS.strHist02 := ADataset.FieldByName('MCA_HIST02').AsString;
  LBanMcaDS.strNumCCD := ADataset.FieldByName('MCA_NUMCCD').AsString;
  LBanMcaDS.strNumNsu := ADataset.FieldByName('MCA_NUMNSU').AsString;
  LBanMcaDS.fltValSta := ADataset.FieldByName('MCA_VALSTA').AsFloat;
  LBanMcaDS.fltValTax := ADataset.FieldByName('MCA_VALTAX').AsFloat;
  LBanMcaDS.fltValRec := ADataset.FieldByName('MCA_VALREC').AsFloat;
  LBanMcaDS.fltFreMkt := ADataset.FieldByName('FRETE_MARKETPLACE').AsFloat;
  LBanMcaDS.fltValAju := ADataset.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
  LBanMcaDS.fltCupMkt := ADataset.FieldByName('CUPOM_MARKETPLACE').AsFloat;

  If fFormataFloat(ADataset.FieldByName('FRETE_MARKETPLACE').AsFloat, 2) > 0.00 Then
  Begin
    LBanMcaDS.strIdenti := 'FREMKT';
    LBanMcaDS.strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

    LListaBanMca := TListaBanMCA.Create;
    LListaBanMca.Add(LBanMcaDS);

    LSequencialFrete := fGravaMovBan(ADataset.FieldByName('CAR_CTAFRE').AsString,  // Centro de Custo
                                     ADataset.FieldByName('CAR_PORTAX').AsString,  // Portador
                                     strLoginUsuarioLogado,                         // Operador
                                     ADataset.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                     fTime(),                                       // Hora do Lançamento
                                     ASequenciais.NumeroDocumentoBaixa,             // Documento
                                     'D',                                           // Credito / Debito
                                     VS_strCodEmp,                                  // Empresa
                                     Abs(ADataset.FieldByName('FRETE_MARKETPLACE').AsFloat),  // Valor Documento
                                     'Frete Market Place - Ref.Emp. ' + ADataset.FieldByName('MCA_CODEMP').AsString,// Historico 1
                                     '',                                            // Historico 2
                                     ADataset.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                     ADataset.FieldByName('CAR_FORTAX').AsString,   // Fornecedor
                                     '',                                            // Numero da Duplicata
                                     0,                                             // Sequencial Duplicata
                                     '',                                            // Parcela da Duplicata
                                     ADataset.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                     '',                                            // Série
                                     ADataset.FieldByName('CAR_EVETAX').AsString,   // Código do Evento
                                     '',                                            // Documento da Baixa
                                     Nil,                                          // Log Bancário
                                     0,
                                     ASequenciais.SequencialControleBaixaPagar,
                                     '',
                                     '',
                                     ASequenciais.intSeqLan.ToString,
                                     fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                                     '',
                                     '',
                                     1,
                                     True,
                                     LListaBanMca);

    Inc64(ASequenciais.intSeqLan);
    Inc64(ASequenciais.intContadorAutIncMovBan);
    Inc64(ASequenciais.intContadorAutIncBanMca);
  End;

  If fFormataFloat(ADataset.FieldByName('AJUSTE_MARKETPLACE').AsFloat, 2) > 0.00 Then
  Begin
    LBanMcaDS.strIdenti := 'VALAJU';
    LBanMcaDS.strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

    LListaBanMca := TListaBanMCA.Create;
    LListaBanMca.Add(LBanMcaDS);

    LSequencialAjuste := fGravaMovBan(ADataset.FieldByName('CAR_CTAAJU').AsString,  // Centro de Custo
                                      ADataset.FieldByName('CAR_PORTAX').AsString,  // Portador
                                      strLoginUsuarioLogado,                         // Operador
                                      ADataset.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                      fTime(),                                       // Hora do Lançamento
                                      ASequenciais.NumeroDocumentoBaixa,             // Documento
                                      'D',                                           // Credito / Debito
                                      VS_strCodEmp,                                  // Empresa
                                      Abs(ADataset.FieldByName('AJUSTE_MARKETPLACE').AsFloat),  // Valor Documento
                                      'Cancelamento Market Place - Ref.Emp. ' + ADataset.FieldByName('MCA_CODEMP').AsString,// Historico 1
                                      '',                                            // Historico 2
                                      ADataset.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                      ADataset.FieldByName('CAR_FORTAX').AsString,   // Fornecedor
                                      '',                                            // Numero da Duplicata
                                      0,                                             // Sequencial Duplicata
                                      '',                                            // Parcela da Duplicata
                                      ADataset.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                      '',                                            // Série
                                      ADataset.FieldByName('CAR_EVETAX').AsString,   // Código do Evento
                                      '',                                            // Documento da Baixa
                                      Nil,                                           // Log Bancário
                                      0,
                                      ASequenciais.SequencialControleBaixaPagar,
                                      '',
                                      '',
                                      ASequenciais.intSeqLan.ToString,
                                      fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                                      '',
                                      '',
                                      1,
                                      True,
                                      LListaBanMca);

    Inc64(ASequenciais.intSeqLan);
    Inc64(ASequenciais.intContadorAutIncMovBan);
    Inc64(ASequenciais.intContadorAutIncBanMca);
  End;

  If fFormataFloat(ADataset.FieldByName('CUPOM_MARKETPLACE').AsFloat, 2) > 0.00 Then
  Begin
    LBanMcaDS.strIdenti := 'CUPMKT';
    LBanMcaDS.strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

    LListaBanMca := TListaBanMCA.Create;
    LListaBanMca.Add(LBanMcaDS);

    LSequencialCupom := fGravaMovBan(ADataset.FieldByName('CAR_CTACUP').AsString,  // Centro de Custo
                                     ADataset.FieldByName('CAR_PORBAI').AsString,  // Portador
                                     strLoginUsuarioLogado,                         // Operador
                                     ADataset.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                     fTime(),                                       // Hora do Lançamento
                                     ASequenciais.NumeroDocumentoBaixa,             // Documento
                                     'C',                                           // Credito / Debito
                                     VS_strCodEmp,                                  // Empresa
                                     Abs(ADataset.FieldByName('CUPOM_MARKETPLACE').AsFloat),  // Valor Documento
                                     'Cupom Market Place - Ref.Emp. ' + ADataset.FieldByName('MCA_CODEMP').AsString,// Historico 1
                                     '',                                            // Historico 2
                                     ADataset.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                     '',                                            // Fornecedor
                                     '',                                            // Numero da Duplicata
                                     0,                                             // Sequencial Duplicata
                                     '',                                            // Parcela da Duplicata
                                     ADataset.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                     '',                                            // Série
                                     ADataset.FieldByName('CAR_EVECRE').AsString,   // Código do Evento
                                     '',                                            // Documento da Baixa
                                     Nil,                                           // Log Bancário
                                     0,
                                     ASequenciais.SequencialControleBaixaPagar,
                                     '',
                                     '',
                                     ASequenciais.intSeqLan.ToString,
                                     fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                                     '',
                                     '',
                                     1,
                                     True,
                                     LListaBanMca);

    Inc64(ASequenciais.intSeqLan);
    Inc64(ASequenciais.intContadorAutIncMovBan);
    Inc64(ASequenciais.intContadorAutIncBanMca);
  End;

  ASeqLanFrete := LSequencialFrete;
  ASeqLanAjuste := LSequencialAjuste;
  ASeqLanCupom := LSequencialCupom;

  If Assigned(LListaBanMca) Then
    FreeAndNil(LListaBanMca);
end;

class procedure TBaixaCartoes.GravarMovBanSinteticoFreteTaxasMarketPlace(
  AListaBanMca: TListaBanMCA; var ASequenciais: TSequenciaisBaixaCartao;
  ACartoesSintetico: TArrBaiSinCar; AHistoricoSintetico: String;
  out ASeqLanFrete, ASeqLanAjuste, ASeqLanCupom: String);
  Var
    LSequencialFrete,
    LSequencialAjuste,
    LSequencialCupom: String;

    LContadorBanMCA: Integer;
begin
  LSequencialFrete := EmptyStr;
  LSequencialAjuste := EmptyStr;
  LSequencialCupom := EmptyStr;

  If fFormataFloat(ACartoesSintetico.FreteMarketPlace, 2) > 0.00 Then
  Begin
    For LContadorBanMCA := 0 To AListaBanMca.Count - 1 Do
    Begin
      (AListaBanMca[LContadorBanMCA] as TBanMcaDS).strIdenti := 'FREMKT';
      (AListaBanMca[LContadorBanMCA] as TBanMcaDS).strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

      Inc64(ASequenciais.intContadorAutIncBanMca);
    End;


    LSequencialFrete := fGravaMovBan(ACartoesSintetico.PlanoDeContasFreteMkt,                       // Centro de Custo
                                     ACartoesSintetico.strPorTax,                                   // Portador
                                     strLoginUsuarioLogado,                                         // Operador
                                     ACartoesSintetico.dtaDtarec,                                   // Data do Lançamento
                                     fTime(),                                                       // Hora do Lançamento
                                     ASequenciais.NumeroDocumentoBaixa,                             // Documento
                                     'D',                                                           // Credito / Debito
                                     VS_strCodEmp,                                                  // Empresa
                                     Abs(ACartoesSintetico.FreteMarketPlace),                       // Valor Documento
                                     'Frete Market Place - ' + AHistoricoSintetico + ' Ref.Emp. ' + ACartoesSintetico.strCodEmp,// Historico 1
                                     '',                                                            // Historico 2
                                     '',                                                            // Cliente
                                     ACartoesSintetico.strForTax,                                   // Fornecedor
                                     '',                                                            // Numero da Duplicata
                                     0,                                                             // Sequencial Duplicata
                                     '',                                                            // Parcela da Duplicata
                                     ACartoesSintetico.strCodEmp,                                   // Empresa da Duplicata
                                     '',                                                            // Série
                                     ACartoesSintetico.strEventoTaxa,                               // Código do Evento
                                     '',                                                            // Documento da Baixa
                                     Nil,                                                           // Log Bancário
                                     0,
                                     ASequenciais.SequencialControleBaixaPagar,
                                     '',
                                     '',
                                     ASequenciais.intSeqLan.ToString,
                                     fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                                     '',
                                     '',
                                     1,
                                     True,
                                     AListaBanMca);

    Inc64(ASequenciais.intSeqLan);
    Inc64(ASequenciais.intContadorAutIncMovBan);
  End;

  If fFormataFloat(ACartoesSintetico.AjusteMarketPlace, 2) > 0.00 Then
  Begin
    For LContadorBanMCA := 0 To AListaBanMca.Count - 1 Do
    Begin
      (AListaBanMca[LContadorBanMCA] as TBanMcaDS).strIdenti := 'VALAJU';
      (AListaBanMca[LContadorBanMCA] as TBanMcaDS).strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

      Inc64(ASequenciais.intContadorAutIncBanMca);
    End;
    
    LSequencialAjuste := fGravaMovBan(ACartoesSintetico.PlanoDeContasAjusteMkt,                      // Centro de Custo
                                      ACartoesSintetico.strPorTax,                                   // Portador
                                      strLoginUsuarioLogado,                                         // Operador
                                      ACartoesSintetico.dtaDtaRec,                                   // Data do Lançamento
                                      fTime(),                                                       // Hora do Lançamento
                                      ASequenciais.NumeroDocumentoBaixa,                             // Documento
                                      'D',                                                           // Credito / Debito
                                      VS_strCodEmp,                                                  // Empresa
                                      Abs(ACartoesSintetico.AjusteMarketPlace),                      // Valor Documento
                                      'Cancelamento Market Place - ' + AHistoricoSintetico + ' Ref.Emp. ' + ACartoesSintetico.strCodEmp,// Historico 1
                                      '',                                                            // Historico 2
                                      '',                                                            // Cliente
                                      ACartoesSintetico.strForTax,                                   // Fornecedor
                                      '',                                                            // Numero da Duplicata
                                      0,                                                             // Sequencial Duplicata
                                      '',                                                            // Parcela da Duplicata
                                      ACartoesSintetico.strCodEmp,                                   // Empresa da Duplicata
                                      '',                                                            // Série
                                      ACartoesSintetico.strEventoTaxa,                               // Código do Evento
                                      '',                                                            // Documento da Baixa
                                      Nil,                                                           // Log Bancário
                                      0,
                                      ASequenciais.SequencialControleBaixaPagar,
                                      '',
                                      '',
                                      ASequenciais.intSeqLan.ToString,
                                      fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                                      '',
                                      '',
                                      1,
                                      True,
                                      AListaBanMca);

    Inc64(ASequenciais.intSeqLan);
    Inc64(ASequenciais.intContadorAutIncMovBan);
  End;

  If fFormataFloat(ACartoesSintetico.CupomMarketPlace, 2) > 0.00 Then
  Begin
    For LContadorBanMCA := 0 To AListaBanMca.Count - 1 Do
    Begin
      (AListaBanMca[LContadorBanMCA] as TBanMcaDS).strIdenti := 'CUPMKT';
      (AListaBanMca[LContadorBanMCA] as TBanMcaDS).strAutInc := fFormataAutInc(ASequenciais.intContadorAutIncBanMca, VS_strCodEmp);

      Inc64(ASequenciais.intContadorAutIncBanMca);
    End;

    LSequencialCupom := fGravaMovBan(ACartoesSintetico.PlanoDeContasCupomMkt,                      // Centro de Custo
                                     ACartoesSintetico.strPorBai,                                  // Portador
                                     strLoginUsuarioLogado,                                        // Operador
                                     ACartoesSintetico.dtaDtaRec,                                  // Data do Lançamento
                                     fTime(),                                                      // Hora do Lançamento
                                     ASequenciais.NumeroDocumentoBaixa,                            // Documento
                                     'C',                                                          // Credito / Debito
                                     VS_strCodEmp,                                                 // Empresa
                                     Abs(ACartoesSintetico.CupomMarketPlace),                      // Valor Documento
                                     'Cupom Market Place - ' + AHistoricoSintetico + ' Ref.Emp. ' + ACartoesSintetico.strCodEmp,// Historico 1
                                     '',                                                           // Historico 2
                                     '',                                                           // Cliente
                                     '',                                                           // Fornecedor
                                     '',                                                           // Numero da Duplicata
                                     0,                                                            // Sequencial Duplicata
                                     '',                                                           // Parcela da Duplicata
                                     ACartoesSintetico.strCodEmp,                                  // Empresa da Duplicata
                                     '',                                                           // Série
                                     ACartoesSintetico.strEventoCredito,                           // Código do Evento
                                     '',                                                           // Documento da Baixa
                                     Nil,                                                          // Log Bancário
                                     0,
                                     ASequenciais.SequencialControleBaixaPagar,
                                     '',
                                     '',
                                     ASequenciais.intSeqLan.ToString,
                                     fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_strCodEmp),
                                     '',
                                     '',
                                     1,
                                     True,
                                     AListaBanMca);

    Inc64(ASequenciais.intSeqLan);
    Inc64(ASequenciais.intContadorAutIncMovBan);
  End;

  ASeqLanFrete := LSequencialFrete;
  ASeqLanAjuste := LSequencialAjuste;
  ASeqLanCupom := LSequencialCupom;

  If Assigned(AListaBanMca) Then
    FreeAndNil(AListaBanMca);
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

  ARegistro.Filter   := 'MCA_MARDES=''M'' ';
  ARegistro.Filtered := True;

  If Result Then
    Result := (Not ARegistro.FieldByName('CHAVECONCILIACAO').AsString.IsEmpty);

  If Not Result Then
    Exit;

  If MatchStr(AConcil.strTabCon, ['MER_MLPGTO', 'STO_STPGTO', 'MLZ_MZPGTO']) Then
    Exit;

  LCampos := TStringList.Create;
  LCampos.Delimiter      := ',';
  LCampos.StrictDelimiter := True;
  LCampos.DelimitedText   := AConcil.strChavePrimaria;

  LValores := TStringList.Create;
  LValores.Delimiter       := '|';
  LValores.StrictDelimiter := True;

  LInicioCampo := LeftStr(AConcil.strChavePrimaria, 4);

  LSQL := 'UPDATE ' + AConcil.strTabCon + ' SET ' + LInicioCampo + 'CONCIL=1 WHERE ';

  Try
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
        Result := fExecutaSQL(LSQL + LeftStr(LWhere, LWhere.Length - 4));
        LWhere := '';

        LContador := 1;
      End;

    End;

    FreeAndNil(LValores);
    FreeAndNil(LCampos);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar registros conciliados.' + #13 +
                             'Erro gerado: '+ E.Message);
  End;
End;

class procedure TBaixaCartoes.MarcaRegistrosConciliadoPelaLista(ARegistrosConciliar: TStringList;
  ACamposConcil: TCamposConcil);
  Var
    LSQL,
    LWhere,
    LRegistro: String;

    LContador,
    LContadorRegistros: Integer;

    LCamposChave,
    LValoresChave: TStringList;
begin
  LCamposChave := TStringList.Create;
  LCamposChave.Delimiter := ',';
  LCamposChave.StrictDelimiter := True;
  LCamposChave.DelimitedText := ACamposConcil.strChavePrimaria;

  LValoresChave := TStringList.Create;
  LValoresChave.Delimiter := '|';
  LValoresChave.StrictDelimiter := True;

  Try
    LSQL := 'UPDATE ' + ACamposConcil.strTabCon + ' SET ' + LeftStr(ACamposConcil.strValLiq, 4)  + 'CONCIL=1 WHERE ';
    LWhere := '';

    LContadorRegistros := 0;
    For LRegistro In ARegistrosConciliar Do
    Begin
      LValoresChave.DelimitedText := LRegistro;

      LWhere := LWhere + '(';
      For LContador := 0 To LCamposChave.Count - 1 Do
      Begin
        LWhere := LWhere + LCamposChave[LContador] + '=' + LValoresChave[LContador];

        If LContador < LCamposChave.Count - 1 Then
          LWhere := LWhere + ' AND ';
      End;
      LWhere := LWhere + ') OR ';

      Inc(LContadorRegistros);

      If LContadorRegistros >= 80 Then
      Begin
        fExecutaSQL(LSQL + LeftStr(LWhere, LWhere.Length - 4));

        LWhere := '';
        LContadorRegistros := 0;
      End;
    End;

    If Not LWhere.IsEmpty Then
      fExecutaSQL(LSQL + LeftStr(LWhere, LWhere.Length - 4));
  Finally
    FreeAndNil(LValoresChave);
    FreeAndNil(LCamposChave);
  End;
end;

class function TBaixaCartoes.RetornaSequenciaisParaBaixaAnalitica(
  ADataset: TDataset; ABaixaManual, ABaixaRegistroDebito,
  ATaxasDesmembradas: Boolean; AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;
begin
  {********************************************}
  {* PEGANDO OS SEQLANs NECESSÁRIOS PARA O    *}
  {* BAIXA DE TODOS OS CARTÕES SELECIONADOS   *}
  {*****************************************AJ*}

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

  ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');

  Result.intContadorAutIncLogMca := ADataset.RecordCount;

  Result.intContadorAutIncBanMca := Copy(fRetAutoIncrem('BANMCA', VS_strCodEmp, Result.intContadorAutIncBanMca), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(fRetAutoIncrem('MOVBAN', VS_strCodEmp, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(fRetAutoIncrem('LOGMCA', VS_strCodEmp, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(fRetAutoIncrem('CADPAG', VS_strCodEmp, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(fRetAutoIncrem('LOGCTP', VS_strCodEmp, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := fSeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(fRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;
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

  //Crédito
  Result.intSeqLan := Length(ARegistros);
  Result.intSequencialCadPag     := 0;
  Result.intContadorAutIncBanMca := 0;

  For LRegistro In ARegistros Do
  Begin
    Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);

    //Debito
    If (Not fEmptyStr(LRegistro.strPorBad)) Then
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

  ADataset.Filter := 'MCA_MARDES = ''M'' AND MCA_AJUSTE = ''N'' ';
  Result.intContadorAutIncLogMca := ADataset.RecordCount;

  Result.intContadorAutIncBanMca := Copy(fRetAutoIncrem('BANMCA', VS_strCodEmp, Result.intContadorAutIncBanMca), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(fRetAutoIncrem('MOVBAN', VS_strCodEmp, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(fRetAutoIncrem('LOGMCA', VS_strCodEmp, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(fRetAutoIncrem('CADPAG', VS_strCodEmp, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(fRetAutoIncrem('LOGCTP', VS_strCodEmp, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := fSeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(fRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;

  ADataset.Filter   := 'MCA_MARDES = ''M'' AND MCA_AJUSTE = ''N'' ';
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
                    untMovBan.fGravaMovBan(AAjustesLista[LContador].strCtaBai,  // Centro de Custo
                                           AAjustesLista[LContador].strPorBai,  // Portador
                                           strLoginUsuarioLogado,               // Operador
                                           AAjustesLista[LContador].dtaDtaRec,  // Data do Lançamento
                                           fTime(),                              // Hora do Lançamento
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
                                           Nil,                                 // Log Bancário
                                           0,
                                           AAjustesLista[LContador].intPagCon,
                                           FormatDateTime('mm/yyyy', AAjustesLista[LContador].dtaDtaRec),
                                           EmptyStr,
                                           IIF(ASeqLanInicial > 0, fStrZero(ASeqLanInicial.ToString, 11), EmptyStr),
                                           IIF(AAutoIncremIncial > 0, fFormataAutInc(AAutoIncremIncial, VS_strCodEmp), EmptyStr),
                                           EmptyStr,
                                           EmptyStr,
                                           1,
                                           False);

      LSeqlanAtualizar := '"' + AAjustesLista[LContador].strDocBai + '"';

      If AAjustesLista[LContador].fltValTax > 0 Then
      Begin
        AAjustesLista[LContador].SeqlanTaxaNegociacao :=
                    untMovBan.fGravaMovBan(AAjustesLista[LContador].PlanoDEContasTaxaNegociacao,  // Centro de Custo
                                           AAjustesLista[LContador].strPorBai,  // Portador
                                           strLoginUsuarioLogado,               // Operador
                                           AAjustesLista[LContador].dtaDtaRec,  // Data do Lançamento
                                           fTime(),                              // Hora do Lançamento
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
                                           Nil,                                 // Log Bancário
                                           0,
                                           AAjustesLista[LContador].intPagCon,
                                           FormatDateTime('mm/yyyy', AAjustesLista[LContador].dtaDtaRec),
                                           EmptyStr,
                                           EmptyStr,
                                           EmptyStr,
                                           EmptyStr,
                                           EmptyStr,
                                           1,
                                           False);

        LSeqlanAtualizar := LSeqlanAtualizar + ',"' + AAjustesLista[LContador].SeqlanTaxaNegociacao + '"';
      End;

      If ASeqLanInicial > 0 Then
        Inc64(ASeqLanInicial);

      If AAutoIncremIncial > 0 Then
        Inc64(AAutoIncremIncial);

      Result := Not AAjustesLista[LContador].strDocBai.Trim.IsEmpty;

      If Result Then
        fExecutaSQL('UPDATE MOVBAN SET CTB_ORIGEM="MCA" WHERE CTB_SEQLAN IN (' + LSeqlanAtualizar + ')', True);
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

  LGravaAjusteCredito := fCfgSis('AJUCRE', varBoolean);

  Try
    For LAjuste In AAjustesLista Do
    Begin
      If fFormataFloat(LAjuste.fltValTax, 2) > 0 Then
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
        LNumeroDuplicata := 'G' + fStrZero(ASequencialInicial.ToString, 11);
        Inc64(ASequencialInicial);
      End
      Else
        LNumeroDuplicata := fRetSequencialCadPag;

      LAutoIncrem := EmptyStr;
      If AAutoIncremIncial > 0 Then
      Begin
        LAutoIncrem := fFormataAutInc(AAutoIncremIncial, VS_strCodEmp);
        Inc64(AAutoIncremIncial);
      End;

      If LAjuste.strTipAju.Equals('D') Then
        LValOri := IIF(LAjuste.fltValDoc < 0,(LAjuste.fltValDoc * -1),LAjuste.fltValDoc)
      Else
        LValOri := IIF(LAjuste.fltValDoc > 0,(LAjuste.fltValDoc * -1),LAjuste.fltValDoc);

      Result := untCadPag.fGravaCadPag('frmBaixaCartoes',
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
                                       strLoginUsuarioLogado,
                                       LAjuste.dtaDtaRec,
                                       LValOri,
                                       0,
                                       0,
                                       VS_strCodEmp,
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
                                       strLoginUsuarioLogado);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar contas a pagar dos ajustes. ' + #13 +
                             'Erro: ' + E.Message);
  End;
End;

class procedure TBaixaCartoes.GravaCadPagTaxasNegociacao(
  AAjuste: TArrBaiSinCar);
  Var
    LNumeroDuplicata: String;
Begin
  Try
    LNumeroDuplicata := fRetSequencialCadPag;

    untCadPag.fGravaCadPag('frmBaixaCartoes',
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
                           strLoginUsuarioLogado,
                           AAjuste.dtaDtaRec,
                           AAjuste.fltValTax,
                           0,
                           0,
                           VS_strCodEmp,
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
                           strLoginUsuarioLogado);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure Inc64(var AValor: Int64; AIntervalo: Int64 = 1);
Begin
  AValor := AValor + AIntervalo;
End;

end.
