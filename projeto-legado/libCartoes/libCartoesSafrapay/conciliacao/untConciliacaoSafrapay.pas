unit untConciliacaoSafrapay;

interface

Uses  System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untSafrapayConciliacaoCartoes, untLibCartoesInterfacesTipos, untTSafrapayFuncoes;

type TConcilSafrapay = class(TConciliacaoCartoes)
  private
    FDatasetAntecipacao: TUniClientDataset;
    FNaoHaDadosProcessados: Boolean;

    function RetornaSQLConciliacao: String;
    function RetornaSQLAntecipacoes: String;

    function RetornaTipoDoCartao: String;
    function RetornaValorLiquido: Double;
    function RetornaTaxaAntecipacao(AValorBruto, ATaxaMensal: Double; ADiasAntecipados: Integer): Double;

    function RegistroPossuiAMesmaAutorizacao(AAutorizacao,
                                             AParcela,
                                             AEmpresa,
                                             ADataCupom: String): Boolean;

    function fProcessaSafrapayPag(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaSafrapay(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;

  protected

  end;

Const
  INICAM = 'SAF_';
  NOMTAB = 'SAF_SAPGTO';

implementation
Uses untSafrapayDigPeriodo;

function TConcilSafrapay.fConciliaSafrapay(pgbStatus: TcxProgressBar): Boolean;
Begin
  Result       := False;
  FPossuiInconsistencia := False;
  FNaoHaDadosProcessados := True;

  TForm(pgbStatus.Owner).Visible := False;

  FConciliacaoComPixAtivado := True;

  Try
    Try
      objConcil.TabelaConciliacao := NOMTAB;
      objConcil.CampoEstabelecimento := INICAM + 'CODEST';
      objConcil.NomeConciliacao := 'SAFRAPAY';
      objConcil.CfgEstabelecimentos := 'CFG_SAFEST';
      objConcil.CampoValorBruto := INICAM + 'BRUPAR';
      objConcil.CampoValorLiquido := INICAM + 'LIQPAR';
      objConcil.CampoCodigoAutorizacao := INICAM + 'CODAUT';
      objConcil.CampoNumeroNSU := INICAM + 'NUMNSU';
      objConcil.CampoDataTransacaoVenda := INICAM + 'DTATRA';
      objConcil.CampoNumeroParcela := INICAM + 'NUMPAR';
      objConcil.CampoTotalParcelas := INICAM + 'TOTPAR';
      objConcil.CampoNumeroCartao := INICAM + 'NUMCAR';
      objConcil.CampoDataRecebimento := INICAM + 'DTAPAG';
      objConcil.CampoTipoRegistro := INICAM + 'TIPREG';
      objConcil.CampoTipoTransacao := INICAM + 'TIPLAN';
      objConcil.CfgPortadorAjustes := 'SAFPOR';
      objConcil.CfgPlanoDeContasAjustes := 'SAFCTA';
      objConcil.CfgFornecedorAjustes := 'SAFFOR';
      objConcil.strEventoCancelamentoAjuste := 'SAFEVE';
      objConcil.CfgVlrTolerancia := 'SAFTOL';

      objConcil.strChavePrimaria := 'SAF_TIPREG,SAF_CODEST,SAF_NUMNSU,SAF_DTATRA,SAF_TIPLAN,SAF_DTAPAG,SAF_NUMPAR,SAF_CODAUT';

      {**************************************}
      {* PEGANDO O PERÍODO PARA CONCILIAÇÃO *}
      {***********************************AJ*}
      If Not fDigPeriodo Then
        Exit;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'SAFRAPAY',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TSafrapayFuncoes.RetornaDataHoraServidor,
                                                            TSafrapayFuncoes.RetornaHoraServidor);

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;
      TSafrapayFuncoes.pStepStatusGravacao(pgbStatus,  'Aguarde... Selecionando registros para conciliação (' + objConcil.NomeConciliacao + ').', False);

      fProcessaSafrapayPag(pgbStatus);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message,  '[TfrmBaixaCartoes.fConcilia' + objConcil.NomeConciliacao + ']')
      End;
    End;

    If FNaoHaDadosProcessados Then
      Exit;

    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    FPossuiInconsistencia := False;

    TSafrapayFuncoes.pStepStatusGravacao(pgbStatus,  'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
    GravarRegistrosRelatorio(pgbStatus);

    if FPossuiInconsistencia then
      TSafraPayFuncoes.fMensagem('', 'Foram encontradas inconsistências na conciliação dos arquivos!', ['&OK']);

    If (Assigned(cdsConCar)) And (cdsConCar.Active) And (Not cdsConCar.IsEmpty) Then
    Begin
      GeraRelatorioConciliacao('SAFRAPAY', pgbStatus);

      Result := not cdsBaiCar.IsEmpty;
      if not Result then
        TSafraPayFuncoes.fMensagem('ATENÇÃO', 'Nenhum pagamento foi conciliado no período selecionado!', ['&OK'])
      else
        TSafraPayFuncoes.fMensagem('AVISO', 'Conciliação da Safrapay realizada com sucesso.', ['&OK']);

      blnReabre := (Not Result);
    End;
  Finally
    TSafraPayFuncoes.FreeAndNilDatasets(cdsConCar);
    TSafraPayFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
End;

function TConcilSafrapay.fConciliaCartoes: Boolean;
begin
  Result := TSafraPayFuncoes.ExecutaAguarde(fConciliaSafrapay, 'Aguarde... Iniciando a conciliação.');
end;

function TConcilSafrapay.RegistroPossuiAMesmaAutorizacao(AAutorizacao, AParcela,
  AEmpresa, ADataCupom: String): Boolean;
begin
  Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString = AAutorizacao;

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('PARDUP').AsString = AParcela;

  If Not Result Then
    Exit;

  If Not cdsConCar.FieldByName('CODEMP').AsString.IsEmpty Then
  Begin
    Result := cdsBaiCar.FieldByName('MCA_EMPRCX').AsString = AEmpresa;

    If Not Result Then
      Exit;
  End;

  Result := cdsBaiCar.FieldByName('MCA_DTACUP').AsString = ADataCupom;

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'D';
end;

function TConcilSafrapay.fProcessaSafrapayPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LValorBruto   : Double;
  fltDifere     : Double;
  strSQL        : String;
  LParcela      : String;
  qryConCar     : TUniQuery;
  intRecNo      : Integer;
  LValorLiquido : Double;
  blnBusca      : Boolean;
  LTipoCartao   : String;
  LRegistroRelatorio: TItensRelatorioCartoes;
  LTolerancia   : Double;
  LChaveConciliacao : String;
begin
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  qryConCar := Nil;
  Try
    Try
      qryConCar   := VS_FuncoesExternas.fICriaQuery;
      strSQL := RetornaSQLConciliacao;

      qryConCar.SQL.Text := 'SHOW TABLES LIKE "' + NOMTAB + '"';
      qryConCar.Open;
      If qryConCar.IsEmpty Then
      Begin
        qryConCar.Close;
        TSafraPayFuncoes.fMensagem('','Não existem arquivos importados para a conciliação da ' + objConcil.NomeConciliacao + '!',['&OK']);
        Result := False;
        Exit;
      End;

      qryConCar.Close;
      qryConCar.SQL.Text := strSQL;
      qryConCar.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
      qryConCar.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);
      qryConCar.Open;

      If qryConCar.IsEmpty Then
      Begin
        TSafraPayFuncoes.fMensagem('','Não existem arquivos importados nesse período de recebimento!',['&OK']);
        Result := False;
        blnReabre := True;
        Exit;
      End;

      FNaoHaDadosProcessados := False;

      cdsConCar := TSafrapayFuncoes.CriarClientDataSet(qryConCar);
      cdsConCar.Open;

      qryConCar.Close;
      qryConCar.SQL.Text := RetornaSQLAntecipacoes;
      qryConCar.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
      qryConCar.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);
      qryConCar.Open;

      FDatasetAntecipacao := TSafrapayFuncoes.CriarClientDataSet(qryConCar);
      FDatasetAntecipacao.Open;
    Finally
      TSafrapayFuncoes.FreeAndNIlDatasets(qryConCar);
    End;

    //Para os Ajustes  - Tem que estar antes para não pegar outros ajustes de outras datas
    strCondicao :=  INICAM + 'DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';

    pCalculaPeriodoFiltro(INICAM + 'DTATRA');

    //Filtrando Cartões na MOVCAR
    TSafrapayFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.');
    pFiltraCartoes;

    //Filtrando Cancelamentos/Ajustes
    strCondicao := strCondicao + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
    strCondicao := strCondicao + ' AND ((SAF_TIPREG = "AJ" AND SAF_TIPLAN="1" AND SAF_CODAJU<>"AD08") OR (SAF_TIPLAN = 4)) AND (SAF_LIQPAR <> 0) AND (SAF_CODAJU<>"SLAJ")  ';

    FiltrarCancelamentosPeriodo (strCondicao,
                         ' SAF_DESAJU  ',
                         ' IF(SAF_TIPAJU="1", SAF_LIQPAR, 0) ');

    pFiltraCartoesBaixados;

    pgbStatus.Visible := True;
    TSafrapayFuncoes.pStepStatusGravacao(pgbStatus,  'Aguarde... Selecionando registros para conciliação (' + objConcil.NomeConciliacao + ').', False);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TSafrapayFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

      LParcela := TSafrapayFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString = '00', '1', cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString)));

      If cdsConCar.FieldByName(INICAM + 'TIPLAN').AsInteger In [1, 2] Then
      Begin
        LTipoCartao := RetornaTipoDoCartao;

        LValorBruto  := cdsConCar.FieldByName(INICAM + 'BRUPAR').Value;
        LValorLiquido := RetornaValorLiquido;

        blnBusca := fBuscaCartao(cdsConCar.FieldByName(INICAM + 'CODAUT').Value,
                                 TSafrapayFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName(INICAM + 'NUMNSU').Value, 14)), 14),
                                 cdsConCar.FieldByName('CODEMP').AsString,
                                 LParcela,
                                 cdsConCar.FieldByName(INICAM + 'DTATRA').Value);

        If blnBusca Then
        Begin
          fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
          If (fltDifere <= LTolerancia) And (fltDifere >= -LTolerancia) Then
          Begin

            LChaveConciliacao := INICAM + cdsConCar.FieldByName(INICAM + 'CODAUT').Value + '_' +
                                  TSafrapayFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString = '0', '1', cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString))) + '_' +
                                  cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' + FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName(INICAM + 'DTATRA').Value);


            MarcarCartaoEncontradoArquivo(LValorLiquido,
                                      cdsConCar.FieldByName(INICAM + 'TIPLAN').Value = 2,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar);
          End
          Else
          Begin
            //Verificando outras liberações com a mesma data
            intRecNo := cdsBaiCar.RecNo;
            cdsBaiCar.Next;

            While RegistroPossuiAMesmaAutorizacao(cdsConCar.FieldByName(INICAM + 'CODAUT').Value,
                                                LParcela,
                                                cdsConCar.FieldByName('CODEMP').AsString,
                                                cdsConCar.FieldByName(INICAM + 'DTATRA').AsString) Do
            Begin
              fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
              If (fltDifere <= LTolerancia) And (fltDifere >= -LTolerancia) Then
              Begin
                LChaveConciliacao := INICAM + cdsConCar.FieldByName(INICAM + 'CODAUT').Value + '_' +
                                  TSafrapayFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString = '0', '1', cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString))) + '_' +
                                  cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' + FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName(INICAM + 'DTATRA').Value);


                MarcarCartaoEncontradoArquivo(LValorLiquido,
                                      cdsConCar.FieldByName(INICAM + 'TIPLAN').Value = 2,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar);

                Break;
              End;

              cdsBaiCar.Next;

              If cdsBaiCar.Eof Then
                Break;
            End;

            If Not ((fltDifere <= LTolerancia) And (fltDifere >= -LTolerancia)) Then
            Begin
              cdsBaiCar.RecNo := intRecNo;
              FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';

            End;
          End;
        End
        Else
        Begin
          //verifica se está cadastrado ou já foi baixado no período
          blnAutomatica := cdsConCar.FieldByName(INICAM + 'CONCIL').Value = '1';
          If cdsConCar.FieldByName(INICAM + 'CONCIL').Value = '0' Then
          Begin
            cdsBaixad.First;
            blnBusca := fBuscaCartaoBaixado(cdsConCar.FieldByName(INICAM + 'CODAUT').Value,
                                     TSafrapayFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName(INICAM + 'NUMNSU').Value, 14)), 14),
                                     cdsConCar.FieldByName('CODEMP').AsString,
                                     LParcela,
                                     cdsConCar.FieldByName(INICAM + 'DTATRA').Value);
            If Not blnBusca Then
              FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema'
            Else
              FTextoInconsistencia := 'Cartão já foi baixado';
          End
          Else
            FTextoInconsistencia := 'Cartão já foi baixado';
        End;

        If TSafrapayFuncoes.fEmptyStr(FTextoInconsistencia) Then
        Begin
          If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
            FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
        End;

        FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
        If Not FTextoInconsistencia.IsEmpty Then
        Begin
          LRegistroRelatorio.Descricao := FTextoInconsistencia;
          LRegistroRelatorio.SomarNoTotal := 'N';

          If Not LRegistroRelatorio.Descricao.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
          Begin
            LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
            LRegistroRelatorio.SomarNoTotal := 'S';
          End;
        End;

        LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName(INICAM + 'NOMARQ').AsString; //cdsConCar.FieldByName('YAP_NOMARQ').AsString;
        LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName(INICAM + 'CODEST').Value;
        LRegistroRelatorio.CodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;
        LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName(INICAM + 'NUMNSU').Value;
        LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName(INICAM + 'CODAUT').Value;
        LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName(INICAM + 'NUMANT').AsString;
        LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName(INICAM + 'NUMCAR').Value;
        LRegistroRelatorio.Parcela := TSafrapayFuncoes.IIF(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsInteger = 0, '01', TSafrapayFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString, 2));
        LRegistroRelatorio.TotalParcelas := TSafrapayFuncoes.IIF(cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger = 0, '01', TSafrapayFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'TOTPAR').AsString, 2));
        LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;
        LRegistroRelatorio.DataVenda :=cdsConCar.FieldByName(INICAM + 'DTATRA').Value;
        LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;
        LRegistroRelatorio.ValorBruto := LValorBruto;
        LRegistroRelatorio.ValorLiquido := LValorLiquido;
        LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(cdsConCar.FieldByName(INICAM + 'NUMCAR').Value);
        LRegistroRelatorio.TipoCartao := LTipoCartao;

        If TsafrapayFuncoes.fEmptyStr(LRegistroRelatorio.DescricaoBandeira) Then
           LRegistroRelatorio.DescricaoBandeira := 'OUTROS';

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);

        If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
          GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
      End;

      cdsConCar.Next;
    end;
  Finally
    TSafrapayFuncoes.FreeAndNilDatasets(cdsBaixad);
    TSafrapayFuncoes.FreeAndNilDatasets(FDatasetAntecipacao);
  End;

  Result := True;
end;

function TConcilSafrapay.RetornaSQLConciliacao: String;
begin
  Result := 'SELECT A.*, ' +
            '       COALESCE(SIS_CODEMP, "") AS CODEMP, ' +
            '       EMP_NOMEMP, ' +
            '       0.00 AS TAXA_ANTECIPACAO ' +
            'FROM SAF_SAPGTO A ' +
            'LEFT JOIN CFGSIS ON SIS_VALCFG=A.SAF_CODEST ' +
            '                AND SIS_CODCFG="CFG_SAFEST" ' +
            'LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP   ' +

            'WHERE SAF_DTAPAG BETWEEN :DTAIN AND :DTAFIM     ' +
            '  AND SAF_TIPREG <> "AJ" AND SAF_TIPLAN IN ("1", "2") ' +
            fRetPesqPonVen(0) +
            ' ORDER BY SAF_TIPREG, SAF_DTAPAG ';
end;

function TConcilSafrapay.RetornaSQLAntecipacoes: String;
begin
   Result := 'SELECT                                  '+
             ' SAF_TAXANT,                            '+
             ' SAF_CODEST,                            '+
             ' SAF_DTATRA,                            '+
             ' SAF_NUMANT,                            '+
             ' SAF_CODBAN,                            '+
             ' SAF_DIAANT                             '+
             'FROM                                    '+
             ' SAF_SAPGTO                             '+
             ' LEFT JOIN CFGSIS                       '+
             '   ON SIS_VALCFG = SAF_CODEST           '+
             '   AND SIS_CODCFG = "CFG_SAFEST"        '+
             ' LEFT JOIN CADEMP                       '+
             '   ON SIS_CODEMP = EMP_CODEMP           '+
             'WHERE SAF_DTAPAG BETWEEN :DTAIN         '+
             ' AND :DTAFIM                            '+
             ' AND SAF_TIPREG = "AJ"                  '+
             ' AND SAF_TIPLAN = "1"                   '+
             ' AND SAF_CODAJU = "AD08"                '+
             fRetPesqPonVen(0)                         +
             'GROUP BY SAF_CODEST,                    '+
             ' SAF_DTATRA,                            '+
             ' SAF_NUMANT,                            '+
             ' SAF_CODBAN                             '+
             ' ORDER BY SAF_DTAPAG, SAF_NUMANT ';
end;

function TConcilSafrapay.RetornaTipoDoCartao: String;
begin
  If cdsConCar.FieldByName(INICAM + 'CODBAN').AsString = 'PIX' Then
  Begin
    Result := 'PIX';
    Exit;
  End;

  Result := 'DÉBITO';
  If (cdsConCar.FieldByName(INICAM + 'TIPLAN').Value = 2) Then
    Result := 'ANTECIPAÇÃO'
  Else If cdsConCar.FieldByName(INICAM + 'TIPPRO').AsString <> 'D' Then
  Begin
    Result := 'CRÉDITO ROTATIVO';

    If cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger > 1 Then
      Result := 'CRÉDITO PARCELADO';
  End;
end;

function TConcilSafrapay.RetornaValorLiquido: Double;
Var
    LTaxaAntecipacao: Double;
begin
  Result := cdsConCar.FieldByName('SAF_LIQPAR').AsFloat;

  If cdsConCar.FieldByName('SAF_TIPLAN').AsString.Equals('1') Then
    Exit;

  If cdsConCar.FieldByName('SAF_NUMANT').AsString.Equals('000000000') Then
    Exit;

  If cdsConCar.FieldByName('SAF_DTAPRV').IsNull Then
    Exit;

  If FDatasetAntecipacao.IsEmpty Then
    Exit;

  If FDatasetAntecipacao.Locate('SAF_CODEST;SAF_DTATRA;SAF_NUMANT;SAF_CODBAN',
                                VarArrayOf([cdsConCar.FieldByName('SAF_CODEST').AsString,
                                            cdsConCar.FieldByName('SAF_DTAPRV').AsDateTime,
                                            cdsConCar.FieldByName('SAF_NUMANT').AsString,
                                            cdsConCar.FieldByName('SAF_CODBAN').AsString]), []) Then
  Begin
    LTaxaAntecipacao := RetornaTaxaAntecipacao(cdsConCar.FieldByName('SAF_LIQPAR').AsFloat,
                                               FDatasetAntecipacao.FieldByName('SAF_TAXANT').AsFloat,
                                               FDatasetAntecipacao.FieldByName('SAF_DIAANT').AsInteger);

    Result := TSafrapayFuncoes.fFormataFloat(cdsConCar.FieldByName('SAF_LIQPAR').AsFloat - LTaxaAntecipacao,2);

    cdsConCar.Edit;
    cdsConCar.FieldByName('TAXA_ANTECIPACAO').AsFloat := TSafrapayFuncoes.fFormataFloat(LTaxaAntecipacao,2);
    cdsConCar.Post;
  End;
end;

function TConcilSafrapay.RetornaTaxaAntecipacao(AValorBruto,
  ATaxaMensal: Double; ADiasAntecipados: Integer): Double;
var
  LTaxaDiaria: Double;
begin
  // Converte a taxa mensal para diária
  LTaxaDiaria := (ATaxaMensal / 30);

  // Calcula a taxa proporcional aos dias
  Result :=  TSafrapayFuncoes.fFormataFloat(AValorBruto * (LTaxaDiaria / 100) * ADiasAntecipados,2);
end;

end.
