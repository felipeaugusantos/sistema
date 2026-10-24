unit untConciliacaoSipagV2;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untSipagConciliacaoCartoes, untLibCartoesInterfacesTipos, untTSipagFuncoes;

type

  TConciliacaoSipagV2 = class(TConciliacaoCartoes)
  private
    FFiltroEstabelecimento : String;

    procedure pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
    procedure pCriaDataSets;

    function fGetTipoDeOperacao: String;
    procedure ValidaCartaoEncontrado(Var ABusca : Boolean;
                                     Var ADivergenciaCartao : String;
                                     AClient: TUniClientDataSet);
    procedure ValidaCartaoMarcado(Var ADivergenciaCartao : String;
                                  var ARegistroRelatorio: TItensRelatorioCartoes);
    function RetornaSqlMovimentoFinanceiro:String;
    function RetornaValorLiquidoParcela: Double;
    function RetornaInAutorizacaoFiltrar: String;
    function RetornaInNsuFiltrar: String;
    function RetornaTipoAjusteSQL:String;

    procedure FiltraCartoesBaixados;

    function RetornaBandeira(ACodigoBandeira: String): String;

    function fConciliaSipagV2(pgbStatus: TcxProgressBar): Boolean;

    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
  end;

implementation

Uses untSipagFiltroInconsistencias;

{ TConciliacaoSipagV2 }

function TConciliacaoSipagV2.fConciliaSipagV2(pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll    : TprcScroll;
  blnVazio     : Boolean;

  LCondicaoAjustes: String;
begin
  TForm(pgbStatus.Owner).Visible := False;
  Try
    Try
      Result       := False;
      FFiltrarAutorizacaoNSU := True;
      FPossuiInconsistencia := False;

      strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

      Application.ProcessMessages;

      objConcil.TabelaConciliacao           := 'SIP_SIPGT2';
      objConcil.CampoEstabelecimento        := 'SIP_CODEST';
      objConcil.NomeConciliacao             := 'SIPAG';
      objConcil.CampoValorBruto             := 'SIP_VALBRU';
      objConcil.CampoValorLiquido           := 'SIP_VALLIQ';
      objConcil.CampoCodigoAutorizacao      := 'SIP_CODAUT';
      objConcil.CampoNumeroNSU              := 'SIP_NUMNSU';
      objConcil.CampoDataTransacaoVenda     := 'SIP_DTATRA';
      objConcil.CampoDataRecebimento        := 'SIP_DTAPAG';
      objConcil.CampoNumeroParcela          := 'SIP_NUMPAR';
      objConcil.CampoTotalParcelas          := 'SIP_TOTPAR';
      objConcil.CampoNumeroCartao           := '';
      objConcil.CampoTipoRegistro           := '';
      objConcil.CampoTipoTransacao          := '';
      objConcil.CfgEstabelecimentos         := 'CFG_SIPEST';
      objConcil.CfgPortadorAjustes          := 'SIPPOR';
      objConcil.CfgPlanoDeContasAjustes     := 'SIPCTA';
      objConcil.CfgFornecedorAjustes        := 'SIPFOR';
      objConcil.strEventoCancelamentoAjuste := 'SIPEVE';
    
      objConcil.strChavePrimaria            := 'SIP_TIPREG,SIP_DTAPAG,SIP_NUMPAR,SIP_CODAUT,SIP_NUMNSU';

      If Not fDigPeriodo Then
        Exit;

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;

      TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros para conciliação.', False);
      pCriaDataSets;

      blnVazio :=  cdsConcar.IsEmpty;

       If blnVazio Then
      Begin
        TSipagFuncoes.fMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&Ok']);
        blnReabre := True;
        Exit;
      End;

      // 031 só entra como ajuste quando DataDoAjuste > DataPagamento;
      // 031 sem DTAAJU é ignorado intencionalmente (Req. 439837)
      LCondicaoAjustes := ' SIP_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" ' +
                          '                AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ' +
                          '  AND ( '+
                          '        (SIP_TIPREG = "025" AND SIP_VALBRU < 0) '+
                          '     OR (SIP_DESTRA IN("202","400")) '+
                          '     OR (SIP_TIPREG = "031" AND SIP_VALBRU < 0 AND SIP_DTAAJU > SIP_DTAPAG) '+
                          '      )';

      If Assigned(lstDtaCad) Then
        FreeAndNil(lstDtaCad);
      lstDtaCad := TStringList.Create;

      pCalculaPeriodoFiltro(cdsConcar);

      FInAutorizacaoFiltrar := RetornaInAutorizacaoFiltrar;
      FInNsuFiltrar := RetornaInNsuFiltrar;

      TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões.', False);
      pFiltraCartoes;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'SIPAG',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TSipagFuncoes.RetornaDataHoraServidor,
                                                            TSipagFuncoes.RetornaHoraServidor);

      TSipagFuncoes.pDisableControls(cdsBaiCar, prcScroll);

      If Not TSipagFuncoes.fEmptyStr(fRetPesqPonVen(1)) then
        LCondicaoAjustes := LCondicaoAjustes + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento,
                                                                                'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

      //Filtrandos Ajustes
      FiltrarCancelamentosPeriodo(LCondicaoAjustes,
                                  RetornaTipoAjusteSQL,
                                  ' IF(SIP_VALBRU > 0, SIP_VALBRU, 0) ');

      TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões baixados.', False);
      FiltraCartoesBaixados;

      pgbStatus.Visible := True;
      If Not cdsConcar.IsEmpty Then
      Begin
        TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de débito/crédito (' + objConcil.NomeConciliacao + ').', False);
        fProcessaRegistrosDebitoCredito(pgbStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(pgbStatus);

      If FPossuiInconsistencia Then
        TSipagFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      If FListaRegistrosRelatorio.Count > 0 Then
        Result := GeraRelatorioConciliacao('SIPAG', pgbStatus);

      If Assigned(cdsAjustes) Then
      Begin
        cdsAjustes.Filter   := 'SIP_CONCIL=0';
        cdsAjustes.Filtered := True;
      End;

      blnReabre := Not Result;
      If Result Then
      Begin
        cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        cdsBaiCar.Filtered := True;

        Result := Not cdsBaiCar.IsEmpty;
        If Not Result Then
          TSipagFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
        Else
          TSipagFuncoes.fMensagem('AVISO','Conciliação da SIPAG realizada com sucesso.',['&OK']);
      End;

      TSipagFuncoes.pEnableControls(cdsBaiCar, prcScroll);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaSipagV2]');
      End;
    End;
  Finally
    TSipagFuncoes.FreeAndNilDatasets(cdsConcar);
    TSipagFuncoes.FreeAndNilDatasets(cdsAjustes);

    If Assigned(lstDtaCad) Then
      FreeAndNil(lstDtaCad);
  End;
end;

function TConciliacaoSipagV2.fConciliaCartoes: Boolean;
begin
  Result := TSipagFuncoes.ExecutaAguarde(fConciliaSipagV2, 'Aguarde... Iniciando a conciliação.');
end;

function TConciliacaoSipagV2.fGetTipoDeOperacao: String;
  Var
    LModalidade: String;
begin
  Result := '';

   If (cdsConcar.FieldByName('SIP_TAXANT').AsFloat > 0) Then
     Exit('ANTECIPAÇÃO');

  LModalidade := AnsiUpperCase(cdsConcar.FieldByName('SIP_TIPCON').AsString);

  If Pos('D',LModalidade) > 0 Then
    Result := 'DÉBITO'

  Else If Pos('C',LModalidade) > 0 Then
  Begin
    Result := 'CRÉDITO ROTATIVO';

    If cdsConcar.FieldByName('SIP_TOTPAR').AsInteger > 1 Then
      Result := 'CRÉDITO PARCELADO';
  End;
end;

procedure TConciliacaoSipagV2.FiltraCartoesBaixados;
begin
  pFiltraCartoesBaixados(False);
end;

function TConciliacaoSipagV2.RetornaBandeira(ACodigoBandeira: String): String;
begin
  Result := '';

  If ACodigoBandeira.IsEmpty Then
    Exit;

  Try
    Case StrToInt(ACodigoBandeira) Of
      1: Result := 'VISA';
      2: Result := 'MASTERCARD';
      3: Result := 'CABAL';
      4: Result := 'HIPERCARD';
      5: Result := 'ELO';
      6: Result := 'AMEX';
      Else Result := 'OUTROS';
    End;
  Except
    Result := 'OUTROS';
  End;

end;

function TConciliacaoSipagV2.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
Var strParcel                : String;
    strNumNsu                : String;
    strCodEmp                : String;
    dtaDtaCad                : TDateTime;
    strNumAut                : String;
    blnBusca                 : Boolean;
    LTipoCartao              : String;
    LDivergenciaCartao       : String;
    LNumCCD                  : String;
    LTaxaAntecipacao         : Double;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LChaveConciliacao: String;

    LValorBruto,
    LValorLiquido: Double;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConcar.RecordCount;

    cdsConcar.First;
    While Not cdsConcar.Eof Do
    Begin
      TSipagFuncoes.pStepStatusGravacao(pgbStatus);
      LDivergenciaCartao := '';

      LRegistroRelatorio := TItensRelatorioCartoes.Create;
      FTextoInconsistencia := EmptyStr;

      LTaxaAntecipacao := cdsConcar.FieldByName('SIP_TAXANT').AsFloat;

      LTipoCartao := fGetTipoDeOperacao;

      strParcel := TSipagFuncoes.fGetLetraAlfa(StrtoInt(RightStr(cdsConcar.FieldByName('SIP_NUMPAR').AsString , 2)));
      strNumNsu := TSipagFuncoes.fStrZero(Trim(RightStr(cdsConcar.FieldByName('SIP_NUMNSU').AsString, 14)), 14);
      strNumAut := cdsConcar.FieldByName('SIP_CODAUT').AsString;
      dtaDtaCad := cdsConcar.FieldByName('SIP_DTATRA').Value;
      strCodEmp := cdsConcar.FieldByName('EMP_CODEMP').AsString;

      {********************}
      {* NOVA CONCILIAÇÃO *}
      {*****************GD*}

      LValorBruto := cdsConCar.FieldByName('SIP_VALBRU').Value;
      LValorLiquido := TSipagFuncoes.fFormataFloat(RetornaValorLiquidoParcela - LTaxaAntecipacao,2);

      LNumCCD := TSipagFuncoes.IIF((strNumAut = '0'),'',TSipagFuncoes.fStrZero(strNumAut, 6));
      blnBusca := fBuscaCartao(LNumCCD,
                               strNumNsu,
                               strCodEmp,
                               strParcel,
                               dtaDtaCad);

      LDivergenciaCartao := '';
      ValidaCartaoEncontrado(blnBusca,LDivergenciaCartao,cdsConcar);

      If (blnBusca) Then
      Begin
        LChaveConciliacao := 'SIP_' + cdsConcar.FieldByName('SIP_CODEST').AsString + '_' +
                             cdsConcar.FieldByName('SIP_CODAUT').Value + '_' +
                             strParcel + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', cdsConcar.FieldByName('SIP_DTAPAG').Value);

        MarcarCartaoEncontradoArquivo(LValorLiquido,
                                      LTaxaAntecipacao > 0,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar);

        ValidaCartaoMarcado(LDivergenciaCartao, LRegistroRelatorio);
      End
      Else
      Begin
        //verifica se está cadastrado ou já foi baixado no período
        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixado(LNumCCD,
                                        strNumNsu,
                                        strCodEmp,
                                        strParcel,
                                        dtaDtaCad,
                                        True,
                                        cdsConcar.FieldByName('SIP_VALBRU').AsFloat);

        FTextoInconsistencia := 'Cartão já foi baixado';
        If Not blnBusca Then
          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
      End;

       {Gerando registro do relatório}
      FTextoInconsistencia := TSipagFuncoes.IIF(TSipagFuncoes.fEmptyStr(LDivergenciaCartao),FTextoInconsistencia,LDivergenciaCartao);
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;

        If Not LRegistroRelatorio.Descricao.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('SIP_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('SIP_CODEST').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_CODAUT').Value, 6)), 6);
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('SIP_REFVEN').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('SIP_NUMCAR').AsString;

      If LRegistroRelatorio.TipoCartao.IsEmpty Then
        LRegistroRelatorio.TipoCartao := LTipoCartao;

      LRegistroRelatorio.Parcela := TSipagFuncoes.fStrZero(cdsConCar.FieldByName('SIP_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TSipagFuncoes.fStrZero(cdsConCar.FieldByName('SIP_TOTPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('SIP_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('SIP_DTATRA').AsDateTime;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('SIP_DTAPAG').AsDateTime;

      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;

      LRegistroRelatorio.DescricaoBandeira := RetornaBandeira(cdsConCar.FieldByName('SIP_NOMBAN').AsString);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConcar.Next;
    End;

    Result := True;

  Except
    Raise;
  End;

end;

procedure TConciliacaoSipagV2.pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
begin
  If (Assigned(ACdsBase)) And (Not ACdsBase.IsEmpty) Then
  Begin
    ACdsBase.IndexFieldNames := 'SIP_DTATRA';
    ACdsBase.First;

    If dtaDtaIni > ACdsBase.FieldByName('SIP_DTATRA').Value Then
      dtaDtaIni := ACdsBase.FieldByName('SIP_DTATRA').Value;

    While Not ACdsBase.Eof Do
    Begin
      If lstDtaCad.IndexOf(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('SIP_DTATRA').Value)) < 0 Then
        lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('SIP_DTATRA').Value));

      ACdsBase.Next;
      Application.ProcessMessages;
    End;
    ACdsBase.Last;

    If dtaDtaFim < ACdsBase.FieldByName('SIP_DTATRA').Value Then
      dtaDtaFim := ACdsBase.FieldByName('SIP_DTATRA').Value;
  End;

end;

procedure TConciliacaoSipagV2.pCriaDataSets;
  Var
    LQueryMovimento: TUniQuery;
begin
  LQueryMovimento := Nil;
  cdsConcar := Nil;

  Try
    FFiltroEstabelecimento := fRetPesqPonVen(0);

    LQueryMovimento := VS_FuncoesExternas.fICriaQuery;
    //DEBITOS E CREDITOS
    LQueryMovimento.SQL.Clear;
    LQueryMovimento.SQL.Text := RetornaSqlMovimentoFinanceiro;
    LQueryMovimento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryMovimento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryMovimento.Open;
    cdsConcar := TSipagFuncoes.CriarClientDataSet(LQueryMovimento);
    Application.ProcessMessages;
  Finally
    TSipagFuncoes.FreeAndNilDatasets(LQueryMovimento);
  End;
end;

function TConciliacaoSipagV2.RetornaInAutorizacaoFiltrar: String;
  Var
    LValor: String;
begin
  Result := '""';

  cdsConcar.First;
  While Not cdsConcar.Eof Do
  Begin
    LValor := '"' + TSipagFuncoes.fStrZero(cdsConcar.FieldByName('SIP_CODAUT').AsString, 6) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConcar.Next;
      Continue;
    End;

    Result := Result + ',' + LValor;

    If cdsConcar.FieldByName('SIP_CODAUT').AsString.Length < 6 Then
    Begin
      LValor := '"' + cdsConcar.FieldByName('SIP_CODAUT').AsString + '"';

      If Result.Contains(LValor) Then
      Begin
        cdsConcar.Next;
        Continue;
      End;

      Result := Result + ',' + LValor;
    End;

    cdsConcar.Next;
  End;

  cdsConcar.First;
end;

function TConciliacaoSipagV2.RetornaInNsuFiltrar: String;
   Var
    LValor: String;
begin
  Result := '""';

  cdsConcar.First;
  While Not cdsConcar.Eof Do
  Begin
    LValor := '"' + TSipagFuncoes.fStrZero(cdsConcar.FieldByName('SIP_NUMNSU').AsString, 14) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConcar.Next;
      Continue;
    End;

    Result := Result + ',' + LValor;

    cdsConcar.Next;
  End;

  cdsConcar.First;
end;

function TConciliacaoSipagV2.RetornaSqlMovimentoFinanceiro: String;
begin

  Result := 'SELECT                                    '+
            '  *                                       '+
            'FROM                                      '+
            '  SIP_SIPGT2                              '+
            '  LEFT JOIN CFGSIS                        '+
            '    ON LOCATE(SIP_CODEST, SIS_VALCFG) > 0 '+
            '    AND SIS_CODCFG IN ("CFG_SIPEST")      '+
            '  LEFT JOIN CADEMP                        '+
            '    ON SIS_CODEMP = EMP_CODEMP            '+
            'WHERE SIP_DTAPAG BETWEEN :DTAINI          '+
            '  AND :DTAFIM                             '+
            '  AND SIP_TIPREG NOT IN("031")            '+
            '  AND SIP_DESTRA NOT IN("202","400")      '+
            '  AND SIP_VALBRU > "0"                    ';


  If Not TSipagFuncoes.fEmptyStr(FFiltroEstabelecimento) then
    Result := Result + StringReplace(FFiltroEstabelecimento,objConcil.CampoEstabelecimento,objConcil.CampoEstabelecimento,[rfReplaceAll]);

end;

function TConciliacaoSipagV2.RetornaTipoAjusteSQL: String;
begin
  Result :=
  'CASE SIP_TIPTRA '+
  '  WHEN "005" THEN "Compra"'+
  '  WHEN "060" THEN "Débito do estabelecimento"'+
  '  WHEN "105" THEN "Compra com 2 a 3 parcelas"'+
  '  WHEN "106" THEN " Compra com 4 a 6 parcelas"'+
  '  WHEN "107" THEN " Compra com 7 a 12 parcelas"'+
  '  WHEN "109" THEN " Parcelado pelo emissor"'+
  '  WHEN "113" THEN " Compra com 13 a 18 parcelas"'+
  '  WHEN "114" THEN " Compra com 19 a 24 parcelas"'+
  '  WHEN "163" THEN " Credit Link Pagto"'+
  '  WHEN "164" THEN " Debit Link Pagto"'+
  '  WHEN "169" THEN " 3DS Credito"'+
  '  WHEN "170" THEN " 3DS Debito"'+
  '  WHEN "430" THEN " Ajuste CFL"'+
  '  WHEN "448" THEN " CR Chargeback"'+
  '  WHEN "461" THEN " Compra com 02 parcelas"'+
  '  WHEN "462" THEN " Compra com 03 parcelas"'+
  '  WHEN "463" THEN " Compra com 04 parcelas"'+
  '  WHEN "464" THEN " Compra com 05 parcelas"'+
  '  WHEN "465" THEN " Compra com 06 parcelas"'+
  '  WHEN "466" THEN " Compra com 07 parcelas"'+
  '  WHEN "467" THEN " Compra com 08 parcelas"'+
  '  WHEN "468" THEN " Compra com 09 parcelas"'+
  '  WHEN "469" THEN " Compra com 10 parcelas"'+
  '  WHEN "470" THEN " Compra com 11 parcelas"'+
  '  WHEN "471" THEN " Compra com 12 parcelas"'+
  '  WHEN "472" THEN " Compra com >12 parcelas"'+
  '  WHEN "473" THEN " Parcelado Emissor-02 parc"'+
  '  WHEN "474" THEN " Parcelado Emissor-03 parc"'+
  '  WHEN "475" THEN " Parcelado Emissor-04 parc"'+
  '  WHEN "476" THEN " Parcelado Emissor-05 parc"'+
  '  WHEN "477" THEN " Parcelado Emissor-06 parc"'+
  '  WHEN "478" THEN " Parcelado Emissor-07 parc"'+
  '  WHEN "479" THEN " Parcelado Emissor-08 parc"'+
  '  WHEN "480" THEN " Parcelado Emissor-09 parc"'+
  '  WHEN "481" THEN " Parcelado Emissor-10 parc"'+
  '  WHEN "482" THEN " Parcelado Emissor-11 parc"'+
  '  WHEN "483" THEN " Parcelado Emissor-12 parc"'+
  '  WHEN "484" THEN " Parcelado Emissor >12 parc"'+
  '  WHEN "485" THEN " Crediario 02 parcelas"'+
  '  WHEN "486" THEN " Crediario 03 parcelas"'+
  '  WHEN "487" THEN " Crediario 04 parcelas"'+
  '  WHEN "488" THEN " Crediario 05 parcelas"'+
  '  WHEN "489" THEN " Crediario 06 parcelas"'+
  '  WHEN "490" THEN " Crediario 07 parcelas"'+
  '  WHEN "491" THEN " Crediario 08 parcelas"'+
  '  WHEN "492" THEN " Crediario 09 parcelas"'+
  '  WHEN "493" THEN " Crediario 10 parcelas"'+
  '  WHEN "494" THEN " Crediario 11 parcelas"'+
  '  WHEN "495" THEN " Crediario 12 parcelas"'+
  '  WHEN "496" THEN " Crediario > 12 parcelas"'+
  '  WHEN "510" THEN " Taxa Ethernet POS"'+
  '  WHEN "583" THEN " Assessment Fee Refund -CABAL"'+
  '  ELSE "Outros" END ';
end;

procedure TConciliacaoSipagV2.ValidaCartaoEncontrado(Var ABusca : Boolean;
                                                         Var ADivergenciaCartao : String;
                                                         AClient: TUniClientDataSet);
  Var
    LDiferenca : Double;
begin
  If Not ABusca Then
    Exit;

  // Valor Bruto
  LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('SIP_VALBRU').AsFloat;

  If Not fBetween(TSipagFuncoes.fFormataFloat(LDiferenca, 2), -0.029999999, 0.029999999) Then
  Begin
    ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
    ABusca := False;
    Exit;
  End;
end;

procedure TConciliacaoSipagV2.ValidaCartaoMarcado(var ADivergenciaCartao: String;
  var ARegistroRelatorio: TItensRelatorioCartoes);
begin
  If Not cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
    Exit;

  // Taxa Administrativa
  If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(cdsConcar.FieldByName('SIP_VALBRU').AsFloat,cdsBaiCar) Then
  Begin
    ADivergenciaCartao := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
    ARegistroRelatorio.SomarNoTotal := 'N';
    Exit;
  end;

end;

function TConciliacaoSipagV2.RetornaValorLiquidoParcela: Double;
begin
  Result := cdsConcar.FieldByName('SIP_VALLIQ').AsFloat;
end;

end.
