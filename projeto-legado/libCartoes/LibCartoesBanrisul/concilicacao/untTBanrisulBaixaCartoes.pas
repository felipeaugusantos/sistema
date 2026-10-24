unit untTBanrisulBaixaCartoes;


interface

Uses System.SysUtils, System.StrUtils, System.Classes, Data.DB, System.Variants,
     System.Generics.Collections,

     Uni, UniClientDataset,

     untTBanMca, untLibCartoesInterfacesTipos, untTBanrisulFuncoes;

Type
  TBaixaCartoes = class

  private
  public
    class function VerificaSeHaCartoesBaixadosAntesDaBaixa(ARegistros: TDataset): Boolean;
    class function VerificaSeHouveAlteracaoNosCartoesAntesDaBaixa(ARegistros: TDataset): Boolean;
    class function ValidaDadosDigitadosBaixaSintetica(ARegistros: TDataset;
                                                      ADataBaixa,
                                                      APortadorBaixa,
                                                      APortadorTaxa,
                                                      APortadorDebito: String): Boolean;

    class function CalculaDataMinimaParaPortador(ARegistros: TDataset): TDate;

    class function MarcarComoConciliadoBanrisul(AConcil: TCamposConcil;
                                                ARegistro: TUniClientDataset): Boolean;

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

  ARegistros.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
  ARegistros.Filtered := True;

  LRegistros := Nil;
  Try
    LRegistros := TBanrisulFuncoes.CriarClientDataSet(ARegistros);
    LRegistros.IndexFieldNames := 'MCA_DTAREC';

    LRegistros.First;
    Result := LRegistros.FieldByName('MCA_DTAREC').Value;

  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LRegistros);

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
    ARegistros.Filter := 'MCA_MARDES = ''M'' AND MCA_DTACAD > ' + ADataBaixa.QuotedString;
    ARegistros.Filtered := True;

    Result := ARegistros.IsEmpty;
    If Not Result Then
    Begin
      TBanrisulFuncoes.fMensagem('ATENÇÃO', 'Não é possível realizar a baixa pois a data de pagamento é menor que a data de cadastro de alguns dos cartões selecionados. Verifique!', ['&OK']);
      Exit;
    End;

    ARegistros.Filtered := False;
    ARegistros.Filter   := 'MCA_MARDES = ''M''';
    ARegistros.Filtered := True;

    LListaEmpresas := TBanrisulFuncoes.fDatasetDistinctField(ARegistros, 'MCA_CODEMP');

    ARegistros.Filtered := False;

    {*REQ*145940**********RP*}
    Result :=  TBanrisulFuncoes.fEmpresasTemAcessoPortador(APortadorBaixa, LListaEmpresas, LEmpresasSemAcesso);
    If Not Result Then
    Begin
      TBanrisulFuncoes.fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Cartão Crédito] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;

    Result := TBanrisulFuncoes.fEmpresasTemAcessoPortador(APortadorTaxa, LListaEmpresas, LEmpresasSemAcesso);
    If Not Result Then
    Begin
      TBanrisulFuncoes.fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Taxa] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;

    Result := TBanrisulFuncoes.fEmpresasTemAcessoPortador(APortadorDebito, LListaEmpresas, LEmpresasSemAcesso);
    If Not Result Then
    Begin
      TBanrisulFuncoes.fMensagem('ATENÇÃO!', 'Empresa(s) sem acesso ao cadastro do [Portador Cartão Débito] informado: '+ LEmpresasSemAcesso +'. Operação abortada!', ['&OK']);
      Exit;
    End;
  Finally
    TBanrisulFuncoes.FreeAndNilStringLists(LListaEmpresas);
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
    TBanrisulFuncoes.FreeAndNilDatasets(LConsulta);

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

        LConsulta.SQL.Text := strSql;
        LConsulta.ParamByName('DTAFIL').AsString := FormatDateTime('yyyy-mm-dd',ARegistros.FieldByName('HRAFILCAR').AsDateTime);
        LConsulta.ParamByName('HROFIL').AsString := FormatDateTime('HH:NN:SS',ARegistros.FieldByName('HRAFILCAR').AsDateTime);
        LConsulta.Open;
        
        Result := Not LConsulta.IsEmpty;

        If Result Then
          Break;

        LContador := 0;
        LValores := '';
      End;
    End;

  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LConsulta);

    ARegistros.Filter   := LFilter;
    ARegistros.Filtered := Not LFilter.IsEmpty;
  End;
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
      LSeqlanDebito := TBanrisulFuncoes.fStrZero(ASequenciais.intSeqLan.ToString, 11);
      Inc64(ASequenciais.intSeqLan);
      LSeqlanTransferencia := TBanrisulFuncoes.fStrZero(ASequenciais.intSeqLan.ToString, 11);
      Inc64(ASequenciais.intSeqLan);

      LPlContasLancDebito := TBanrisulFuncoes.IIF(TBanrisulFuncoes.fEmptyStr(ARegistros.FieldByName('PLANODECONTASTRANSFERENCIALANCDEB').AsString),
                                                  ARegistros.FieldByName('CAR_CTABAI').AsString,
                                                  ARegistros.FieldByName('PLANODECONTASTRANSFERENCIALANCDEB').AsString);

      //Grava a MOVBAN de débito do portador da Baixa
      TLibCartoesMovBan.GravaMovBan(LPlContasLancDebito,
                                    ARegistros.FieldByName('CAR_PORBAI').AsString,
                                    VS_FuncoesExternas.fIRetOperadorLogado,
                                    ARegistros.FieldByName('MCA_DTAREC').AsDateTime,
                                    TBanrisulFuncoes.RetornaHoraServidor,
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
                                    TBanrisulFuncoes.fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
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
                                    TBanrisulFuncoes.RetornaHoraServidor,
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
                                    TBanrisulFuncoes.fFormataAutInc(ASequenciais.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
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

class function TBaixaCartoes.MarcarComoConciliadoBanrisul(
  AConcil: TCamposConcil; ARegistro: TUniClientDataset): Boolean;
var
  LUpdate: TUniQuery;
  LParcelaIn: string;
  LParcela: Integer;
  LFilterAnterior: string;
  LFilteredAnterior: Boolean;
begin
  LUpdate := Nil;

  LFilterAnterior   := ARegistro.Filter;
  LFilteredAnterior := ARegistro.Filtered;

  Try
    ARegistro.Filter   := 'MCA_MARDES=''M'' ';
    ARegistro.Filtered := True;

    If ARegistro.IsEmpty Then
      Exit(False);

    LUpdate := VS_FuncoesExternas.fICriaQuery;
    ARegistro.First;
    While Not ARegistro.Eof Do
    Begin
      // Formata IN-list de parcelas conforme layout Banrisul
      // (mesma parcela vem em formatos heterogêneos no arquivo)
      LParcela := TBanrisulFuncoes.fGetPosLetraAlfa(ARegistro.FieldByName('PARDUP').AsString);
      if LParcela in [0, 1] then
        LParcelaIn := '"0","00","1","01"'
      else if LParcela < 10 then
        LParcelaIn := Format('"%d","0%d"', [LParcela, LParcela])
      else
        LParcelaIn := Format('"%d"', [LParcela]);

      LUpdate.Close;
      LUpdate.SQL.Clear;

      // Ajuste/Cancelamento
      if ARegistro.FieldByName('MCA_AJUSTE').AsString = 'S' then
      begin
        if ARegistro.FieldByName('MCA_NUMNSU').AsString = '00000000000000' then
        begin
          LUpdate.SQL.Text :=
            'UPDATE BAN_BSPGTO '                +
            '   SET BAN_CONCIL = 1 '            +
            ' WHERE BAN_CNPJES = :ESTABE '      +
            '   AND BAN_DTALAN = :DTAREC '      +
            '   AND BAN_TIPMOV = ''D'' '        +
            '   AND BAN_VALLAN = :VALTOT ';

          LUpdate.ParamByName('ESTABE').AsString := ARegistro.FieldByName('MCA_ESTABE').AsString;
          LUpdate.ParamByName('DTAREC').AsDate   := ARegistro.FieldByName('MCA_DTAREC').AsDateTime;
          LUpdate.ParamByName('VALTOT').AsFloat  := ARegistro.FieldByName('MCA_VALTOT').AsFloat * -1;
        end
        else
        begin
          LUpdate.SQL.Text :=
            'UPDATE BAN_BSCRED '                            +
            '   SET BAN_CONCIL = 1 '                        +
            ' WHERE BAN_NUMNSU = :NSU '                     +
            '   AND BAN_NUMPAR IN (' + LParcelaIn + ') '    +
            '   AND BAN_DTALAN = :DTAREC ';

          LUpdate.ParamByName('NSU').AsString    := ARegistro.FieldByName('MCA_NUMNSU').AsString;
          LUpdate.ParamByName('DTAREC').AsDate   := ARegistro.FieldByName('MCA_DTAREC').AsDateTime;
        end;
      end
      // Antecipação
      else if ARegistro.FieldByName('MCA_ANTTAX').AsFloat > 0 then
      begin
        LUpdate.SQL.Text :=
          'UPDATE BAN_BSANTE '                            +
          '   SET BAN_CONCIL = 1 '                        +
          ' WHERE BAN_NUMNSU = :NSU '                     +
          '   AND BAN_NUMPAR IN (' + LParcelaIn + ') '    +
          '   AND BAN_DTAPAG = :DTAREC ';

        LUpdate.ParamByName('NSU').AsString    := ARegistro.FieldByName('MCA_NUMNSU').AsString;
        LUpdate.ParamByName('DTAREC').AsDate   := ARegistro.FieldByName('MCA_DTAREC').AsDateTime;
      end
      // Débito/Crédito normal
      else
      begin
        LUpdate.SQL.Text :=
          'UPDATE BAN_BSCRED '                                          +
          '   SET BAN_CONCIL = 1 '                                      +
          ' WHERE (BAN_NUMCCD = :NUMCCD OR BAN_NUMNSU = :NSU) '         +
          '   AND BAN_NUMPAR IN (' + LParcelaIn + ') '                  +
          '   AND BAN_DTALAN = :DTAREC '                                +
          '   AND BAN_CNPJES = :ESTABE ';

        LUpdate.ParamByName('NUMCCD').AsString := ARegistro.FieldByName('MCA_NUMCCD').AsString;
        LUpdate.ParamByName('NSU').AsString    := ARegistro.FieldByName('MCA_NUMNSU').AsString;
        LUpdate.ParamByName('DTAREC').AsDate   := ARegistro.FieldByName('MCA_DTAREC').AsDateTime;
        LUpdate.ParamByName('ESTABE').AsString :=
          StringReplace(ARegistro.FieldByName('MCA_ESTABE').AsString, 'EST_', '', []);
      end;

      LUpdate.ExecSQL;

      ARegistro.Next;
    End;

    Result := True;
  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LUpdate);

    ARegistro.Filter   := LFilterAnterior;
    ARegistro.Filtered := LFilteredAnterior;
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

  ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');

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
    If (Not TBanrisulFuncoes.fEmptyStr(LRegistro.strPorBad)) Then
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

  Result.intContadorAutIncBanMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('BANMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncBanMca), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(VS_FuncoesExternas.fIRetAutoIncrem('CADPAG', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGCTP', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(VS_FuncoesExternas.fIRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;

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
             TLibCartoesMovBan.GravaMovBan(AAjustesLista[LContador].strCtaBai,  // Centro de Custo
                                           AAjustesLista[LContador].strPorBai,  // Portador
                                           VS_FuncoesExternas.fIRetOperadorLogado,               // Operador
                                           AAjustesLista[LContador].dtaDtaRec,  // Data do Lançamento
                                           TBanrisulFuncoes.fTime(),                              // Hora do Lançamento
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
                                           TBanrisulFuncoes.IIF(ASeqLanInicial > 0, TBanrisulFuncoes.fStrZero(ASeqLanInicial.ToString, 11), EmptyStr),
                                           TBanrisulFuncoes.IIF(AAutoIncremIncial > 0, TBanrisulFuncoes.fFormataAutInc(AAutoIncremIncial, VS_FuncoesExternas.fIRetEmpresaLogada), EmptyStr),
                                           EmptyStr,
                                           EmptyStr,
                                           1,
                                           False);

      LSeqlanAtualizar := '"' + AAjustesLista[LContador].strDocBai + '"';

      If AAjustesLista[LContador].fltValTax > 0 Then
      Begin
        AAjustesLista[LContador].SeqlanTaxaNegociacao :=
             TLibCartoesMovBan.GravaMovBan(AAjustesLista[LContador].PlanoDEContasTaxaNegociacao,  // Centro de Custo
                                           AAjustesLista[LContador].strPorBai,  // Portador
                                           VS_FuncoesExternas.fIRetOperadorLogado,               // Operador
                                           AAjustesLista[LContador].dtaDtaRec,  // Data do Lançamento
                                           TBanrisulFuncoes.fTime(),                              // Hora do Lançamento
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
                                           False);

        LSeqlanAtualizar := LSeqlanAtualizar + ',"' + AAjustesLista[LContador].SeqlanTaxaNegociacao + '"';
      End;

      If ASeqLanInicial > 0 Then
        Inc64(ASeqLanInicial);

      If AAutoIncremIncial > 0 Then
        Inc64(AAutoIncremIncial);

      Result := Not AAjustesLista[LContador].strDocBai.Trim.IsEmpty;

      If Result Then
        TBanrisulFuncoes.ExecutaSQL('UPDATE MOVBAN SET CTB_ORIGEM="MCA" WHERE CTB_SEQLAN IN (' + LSeqlanAtualizar + ')');
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
      If TBanrisulFuncoes.fFormataFloat(LAjuste.fltValTax, 2) > 0 Then
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
        LNumeroDuplicata := 'G' + TBanrisulFuncoes.fStrZero(ASequencialInicial.ToString, 11);
        Inc64(ASequencialInicial);
      End
      Else
        LNumeroDuplicata := VS_FuncoesExternas.fIRetSequencialCadPag;

      LAutoIncrem := EmptyStr;
      If AAutoIncremIncial > 0 Then
      Begin
        LAutoIncrem := TBanrisulFuncoes.fFormataAutInc(AAutoIncremIncial, VS_FuncoesExternas.fIRetEmpresaLogada);
        Inc64(AAutoIncremIncial);
      End;

      If LAjuste.strTipAju.Equals('D') Then
        LValOri := TBanrisulFuncoes.IIF(LAjuste.fltValDoc < 0,(LAjuste.fltValDoc * -1),LAjuste.fltValDoc)
      Else
        LValOri := TBanrisulFuncoes.IIF(LAjuste.fltValDoc > 0,(LAjuste.fltValDoc * -1),LAjuste.fltValDoc);

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
                                              VS_FuncoesExternas.fIRetOperadorLogado);
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
                                  VS_FuncoesExternas.fIRetOperadorLogado);
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
