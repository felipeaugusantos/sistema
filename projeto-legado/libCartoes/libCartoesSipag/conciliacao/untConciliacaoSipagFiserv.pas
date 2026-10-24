unit untConciliacaoSipagFiserv;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untSipagConciliacaoCartoes, untLibCartoesInterfacesTipos, untTSipagFuncoes;

type

  TConciliacaoSipagFiserv = class(TConciliacaoCartoes)
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

    function fConciliaSipagFiserv(pgbStatus: TcxProgressBar): Boolean;

    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
  end;

implementation

Uses untSipagDigPeriodo, untSipagFiltroInconsistencias;

{ TConciliacaoSipagFiserv }

function TConciliacaoSipagFiserv.fConciliaSipagFiserv(pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll    : TprcScroll;
  blnVazio     : Boolean;

  LCondicaoAjustes: String;
begin
  Try
    Try
      TForm(pgbStatus.Owner).Visible := False;

      Result       := False;
      FPossuiInconsistencia := False;
      FFiltrarAutorizacaoNSU := True;

      strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

      Application.ProcessMessages;

      objConcil.TabelaConciliacao           := 'SIP_FVPGTO';
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

      blnVazio := cdsConcar.IsEmpty;

      If blnVazio Then
      Begin
        TSipagFuncoes.fMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&Ok']);
        blnReabre := True;
        Exit;
      End;

      //Data para filtrar o MOVCAR dos baixados
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

      //Filtrandos Ajustes
      LCondicaoAjustes := ' SIP_DTAPAG BETWEEN :DTAINI AND :DTAFIM ' +
                          '  AND (SIP_TIPREG IN("031")               '+
                          '  AND SIP_TIPTRA NOT IN("950")            '+
                          '  OR  (SIP_TIPREG="ARP" AND SIP_VALBRU<0))';
      FiltrarCancelamentosPeriodo(LCondicaoAjustes,
                                  RetornaTipoAjusteSQL,
                                  ' IF(SIP_VALBRU > 0, SIP_VALBRU, 0) ');

      //Selecionando cartões já baixados/cadastrados no período
      FiltraCartoesBaixados;

      If Not cdsConcar.IsEmpty Then
      Begin
        pgbStatus.Visible := False;

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
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaSipagFiserv]');
      End;
    End;
  Finally
    TSipagFuncoes.FreeAndNilDatasets(cdsConcar);
    TSipagFuncoes.FreeAndNilDatasets(cdsAjustes);
    If Assigned(lstDtaCad) Then
      FreeAndNil(lstDtaCad);
  End;
end;

function TConciliacaoSipagFiserv.fConciliaCartoes: Boolean;
begin
  Result := TSipagFuncoes.ExecutaAguarde(fConciliaSipagFiserv, 'Aguarde... Iniciando a conciliação.');
end;

function TConciliacaoSipagFiserv.fGetTipoDeOperacao: String;
  Var
    LModalidade: String;
begin
  Result := '';

   If (cdsConcar.FieldByName('SIP_TAXANT').AsFloat > 0) Then
     Exit('ANTECIPAÇÃO');

  LModalidade := AnsiUpperCase(cdsConcar.FieldByName('SIP_TIPCON').AsString);

  If Pos('DÉBITO',LModalidade) > 0 Then
    Result := 'DÉBITO'

  Else If Pos('CRÉDITO',LModalidade) > 0 Then
  Begin
    Result := TSipagFuncoes.IIF(cdsConcar.FieldByName('SIP_TOTPAR').AsInteger > 1, 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO');
  End;
end;

procedure TConciliacaoSipagFiserv.FiltraCartoesBaixados;
begin
  pFiltraCartoesBaixados(False);
end;

function TConciliacaoSipagFiserv.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
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

      LValorBruto := cdsConCar.FieldByName('SIP_VALBRU').Value;
      LValorLiquido := TSipagFuncoes.fFormataFloat(RetornaValorLiquidoParcela - LTaxaAntecipacao,2);

      {********************}
      {* NOVA CONCILIAÇÃO *}
      {*****************GD*}

      LNumCCD := TSipagFuncoes.IIF((strNumAut = '0'),'', tSipagFuncoes.fStrZero(strNumAut, 6));
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
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('SIP_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('SIP_CODEST').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_CODAUT').Value, 6)), 6);
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('SIP_NUM_RV').AsString;
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

      LRegistroRelatorio.DescricaoBandeira := cdsConCar.FieldByName('SIP_NOMBAN').AsString.ToUpperInvariant;

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

procedure TConciliacaoSipagFiserv.pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
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

procedure TConciliacaoSipagFiserv.pCriaDataSets;
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

function TConciliacaoSipagFiserv.RetornaInAutorizacaoFiltrar: String;
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

function TConciliacaoSipagFiserv.RetornaInNsuFiltrar: String;
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

function TConciliacaoSipagFiserv.RetornaSqlMovimentoFinanceiro: String;
begin

  Result := 'SELECT                                    '+
            '  *                                       '+
            'FROM                                      '+
            '  SIP_FVPGTO                              '+
            '  LEFT JOIN CFGSIS                        '+
            '    ON LOCATE(SIP_CODEST, SIS_VALCFG) > 0 '+
            '    AND SIS_CODCFG IN ("CFG_SIPEST")      '+
            '  LEFT JOIN CADEMP                        '+
            '    ON SIS_CODEMP = EMP_CODEMP            '+
            'WHERE SIP_DTAPAG BETWEEN :DTAINI          '+
            '  AND :DTAFIM                             '+
            '  AND SIP_TIPREG NOT IN("031")            '+
            '  AND SIP_VALBRU > "0"                    ';


  If Not TSipagFuncoes.fEmptyStr(FFiltroEstabelecimento) then
    Result := Result + StringReplace(FFiltroEstabelecimento,objConcil.CampoEstabelecimento,objConcil.CampoEstabelecimento,[rfReplaceAll]);

end;

function TConciliacaoSipagFiserv.RetornaTipoAjusteSQL: String;
begin
  Result :=
  'CASE SIP_TIPTRA '+
  '  WHEN "002" THEN "Pgto comissão intermediação"'+
  '  WHEN "005" THEN "Compra"'+
  '  WHEN "006" THEN "Reembolso (Crédito)"'+
  '  WHEN "007" THEN "Retirada em espécie no caixa"'+
  '  WHEN "008" THEN "Transação Única"'+
  '  WHEN "009" THEN "Retirada em espécie no ATM"'+
  '  WHEN "014" THEN "Transf fundos pelo portador"'+
  '  WHEN "016" THEN "Consulta de saldo"'+
  '  WHEN "017" THEN "Compra com cashback"'+
  '  WHEN "025" THEN "Renda de compras"'+
  '  WHEN "026" THEN "Despesas de reembolso (créd)"'+
  '  WHEN "027" THEN "Renda de retirada em espécie"'+
  '  WHEN "028" THEN "Renda de transação Única"'+
  '  WHEN "029" THEN "Renda de saque no ATM"'+
  '  WHEN "030" THEN "Depósito pelo EC"'+
  '  WHEN "031" THEN "Merch Cash Adv/ATM With Dep"'+
  '  WHEN "035" THEN "Pure Cashback"'+
  '  WHEN "040" THEN "Taxa por pgto em atraso"'+
  '  WHEN "060" THEN "Débito do estabelecimento"'+
  '  WHEN "065" THEN "Parcelamento da compra"'+
  '  WHEN "076" THEN "Reclassificação GL débito"'+
  '  WHEN "077" THEN "Reclassificação GL crédito"'+
  '  WHEN "100" THEN "Bônus de bandeira crédito"'+
  '  WHEN "106" THEN "Compra com 2 a 3 parcelas"'+
  '  WHEN "107" THEN "Compra com 4 a 6 parcelas"'+
  '  WHEN "108" THEN "Compra com 7 a 12 parcelas"'+
  '  WHEN "109" THEN "Parcelado pelo emissor"'+
  '  WHEN "110" THEN "Reemb í conta do portador"'+
  '  WHEN "111" THEN "Transação de fraude - Seguro"'+
  '  WHEN "112" THEN "Transação de fraude - Baixa"'+
  '  WHEN "113" THEN "Compra com 13 a 18 parcelas"'+
  '  WHEN "114" THEN "Compra com 19 a 24 parcelas"'+
  '  WHEN "115" THEN "Pagamento de Fatura"'+
  '  WHEN "162" THEN "Equipamento Nao Devolvido CR"'+
  '  WHEN "163" THEN "Credit Link Pagto"'+
  '  WHEN "164" THEN "Debit Link Pagto"'+
  '  WHEN "165" THEN "CR Link de Pagto Anti Fraude"'+
  '  WHEN "166" THEN "DR Link de Pagto Anti Fraude"'+
  '  WHEN "167" THEN "Pagamento de Cashback"'+
  '  WHEN "168" THEN "Ajuste Debito Cashback"'+
  '  WHEN "169" THEN "3DS Credito"'+
  '  WHEN "170" THEN "3DS Debito"'+
  '  WHEN "171" THEN "Conciliador Credito"'+
  '  WHEN "172" THEN "Conciliador Debito"'+
  '  WHEN "173" THEN "CR Credito Recebido Ant"'+
  '  WHEN "174" THEN "DR Debito Pagto Maior Ant"'+
  '  WHEN "175" THEN "Split Cobr. Taxa Credito"'+
  '  WHEN "176" THEN "Split Cobr. Taxa Debito"'+
  '  WHEN "177" THEN "Split Ajuste Credito"'+
  '  WHEN "178" THEN "Split Ajuste Debito"'+
  '  WHEN "179" THEN "CR Contrato Nao Liquidado"'+
  '  WHEN "180" THEN "DR Contrato Nao Liquidado"'+
  '  WHEN "181" THEN "CR Credito Antecipacao"'+
  '  WHEN "182" THEN "DR Debito Antecipacao"'+
  '  WHEN "183" THEN "CR Comp. Desp. Bandeira Visa"'+
  '  WHEN "184" THEN "DR Comp. Desp. Bandeira Visa"'+
  '  WHEN "185" THEN "CR Comp. Desp. Bandeira MC"'+
  '  WHEN "186" THEN "DR Comp. Desp. Bandeira MC"'+
  '  WHEN "187" THEN "CR REC CONTA CORRENTE IF"'+
  '  WHEN "188" THEN "DR REC CONTA CORRENTE IF"'+
  '  WHEN "189" THEN "CR Duplicidade Pagto"'+
  '  WHEN "192" THEN "DR Por Debito Conta Aluguel"'+
  '  WHEN "193" THEN "Equipamento Nao Devolvido DR"'+
  '  WHEN "194" THEN "CR Acordo Cobranca Aluguel"'+
  '  WHEN "195" THEN "DR Acordo Cobranca Aluguel"'+
  '  WHEN "196" THEN "CR Cancelamento de Vendas"'+
  '  WHEN "197" THEN "DR Cancelamento de Vendas"'+
  '  WHEN "198" THEN "CR Bloqueio Antecipacao CC"'+
  '  WHEN "199" THEN "DR Bloqueio Antecipacao CC"'+
  '  WHEN "200" THEN "Pagamento pelo portador"'+
  '  WHEN "201" THEN "Pgto por débito automático"'+
  '  WHEN "202" THEN "Requisição de pagamento"'+
  '  WHEN "203" THEN "Pgto por transf registrada"'+
  '  WHEN "204" THEN "Baixa dn"'+
  '  WHEN "205" THEN "Pagamento pelo portador"'+
  '  WHEN "206" THEN "Requisição pg por déb direto"'+
  '  WHEN "207" THEN "Requisição pgto em papel"'+
  '  WHEN "208" THEN "Req pgto de pedido de proc"'+
  '  WHEN "209" THEN "Req pgto de pedido bancário"'+
  '  WHEN "220" THEN "Storno kr. zost."'+
  '  WHEN "221" THEN "Baixa 80"'+
  '  WHEN "250" THEN "Pagamentos pelo EC"'+
  '  WHEN "251" THEN "Antecipações manuais 52"'+
  '  WHEN "252" THEN "Antecipações automáticas"'+
  '  WHEN "254" THEN "Taxa de crédito do EC"'+
  '  WHEN "255" THEN "Gratificação do EC"'+
  '  WHEN "270" THEN "Cobrança do Estabelecimento"'+
  '  WHEN "271" THEN "Cobrança de Pagamento do EC"'+
  '  WHEN "279" THEN "Pagamento entre as contas"'+
  '  WHEN "280" THEN "Pagamento em espera"'+
  '  WHEN "281" THEN "Pagamento regularizado esper"'+
  '  WHEN "303" THEN "Juros de Débito"'+
  '  WHEN "304" THEN "Juros por atraso"'+
  '  WHEN "305" THEN "Juros sobre juros"'+
  '  WHEN "311" THEN "Juros de excesso de limite"'+
  '  WHEN "312" THEN "POS-TEF Browser"'+
  '  WHEN "335" THEN "APOS Sitef"'+
  '  WHEN "336" THEN "Loterica TEF"'+
  '  WHEN "350" THEN "CR por Debito conta Aluguel"'+
  '  WHEN "352" THEN "Taxa Mobile"'+
  '  WHEN "353" THEN "Taxa Clover Mobile"'+
  '  WHEN "354" THEN "Taxa Clover Mini"'+
  '  WHEN "355" THEN "eCommerce SE Conecta"'+
  '  WHEN "356" THEN "E-Comm IPG Fee"'+
  '  WHEN "360" THEN "Juros débito não realizado"'+
  '  WHEN "361" THEN "Juros devido não realizado"'+
  '  WHEN "362" THEN "Juro sobre juro não realiza"'+
  '  WHEN "367" THEN "Taxa Auto Credenciamento POS"'+
  '  WHEN "374" THEN "QRCode Virtual"'+
  '  WHEN "378" THEN "POS TEF Terc_Fee"'+
  '  WHEN "383" THEN "POS Link2500 3G"'+
  '  WHEN "384" THEN "Rental POS 2G Fee"'+
  '  WHEN "385" THEN "Rental POS 3G Fee"'+
  '  WHEN "386" THEN "Taxa POS do Futuro"'+
  '  WHEN "387" THEN "POS Conveniencia"'+
  '  WHEN "388" THEN "POS Decreto RS"'+
  '  WHEN "389" THEN "Feiras/Eventos_Move"'+
  '  WHEN "390" THEN "Feiras/Eventos_Link"'+
  '  WHEN "391" THEN "POS no celular"'+
  '  WHEN "394" THEN "POS MOBY6500 Aluguel"'+
  '  WHEN "395" THEN "POS MOBY6500 Tarifa Venda"'+
  '  WHEN "397" THEN "Move 5000 Mega Pop Credicard"'+
  '  WHEN "398" THEN "Link 2500 2G Pop Comodato"'+
  '  WHEN "399" THEN "Link de Pagamento"'+
  '  WHEN "400" THEN "Taxa de parcelamento (4 a 6)"'+
  '  WHEN "401" THEN "Parcelamento pelo est"'+
  '  WHEN "402" THEN "Taxa fidelidade"'+
  '  WHEN "403" THEN "Taxa parcelamento (7 a 12)"'+
  '  WHEN "404" THEN "Taxa parcelamento (13 a 18)"'+
  '  WHEN "405" THEN "Taxa parcelamento (19 a 24)"'+
  '  WHEN "406" THEN "Taxa de parcelamento (2 a 3)"'+
  '  WHEN "407" THEN "Parcelado pelo emissor"'+
  '  WHEN "408" THEN "Perda Operacional"'+
  '  WHEN "409" THEN "Debit ReStatement"'+
  '  WHEN "410" THEN "Loss System Issue"'+
  '  WHEN "411" THEN "DR Duplicidade Pagto"'+
  '  WHEN "412" THEN "Credit MDR"'+
  '  WHEN "413" THEN "Debit MDR"'+
  '  WHEN "414" THEN "CR Trans. nao Processada"'+
  '  WHEN "415" THEN "DR Trans. nao Processada"'+
  '  WHEN "416" THEN "CR Boleto"'+
  '  WHEN "417" THEN "DR Boleto"'+
  '  WHEN "418" THEN "Correcao Monetaria"'+
  '  WHEN "419" THEN "DR Cancelamento Maestro"'+
  '  WHEN "420" THEN "Estorno de Aluguel"'+
  '  WHEN "421" THEN "Cobranca de Aluguel"'+
  '  WHEN "424" THEN "Cancelamento Indevido"'+
  '  WHEN "425" THEN "Debit Registration Rate"'+
  '  WHEN "426" THEN "Estorno Taxa Antecipacao"'+
  '  WHEN "427" THEN "DR Retencao Judicial"'+
  '  WHEN "428" THEN "CR Retencao Judicial"'+
  '  WHEN "429" THEN "Debit Merchant Incentive"'+
  '  WHEN "430" THEN "Ajuste CFL"'+
  '  WHEN "431" THEN "Debit Reversal Rental"'+
  '  WHEN "432" THEN "Trx Cancellation Review"'+
  '  WHEN "433" THEN "CR PF/PJ"'+
  '  WHEN "434" THEN "DR PF/PJ"'+
  '  WHEN "435" THEN "CR Instal. Indevida POS"'+
  '  WHEN "436" THEN "DR Instal. Indevida POS"'+
  '  WHEN "437" THEN "CR Pagto Rejeitado Proc. OK"'+
  '  WHEN "438" THEN "DR Pgto OK Proc Rejeitado"'+
  '  WHEN "439" THEN "CR Ouvidoria"'+
  '  WHEN "440" THEN "DR Ouvidoria"'+
  '  WHEN "441" THEN "CR Liquid. entre Estab."'+
  '  WHEN "442" THEN "DR Liquid. entre Estab."'+
  '  WHEN "443" THEN "CR Rejeicao Captura"'+
  '  WHEN "444" THEN "DR Rejeicao Captura"'+
  '  WHEN "445" THEN "CR Royalties/Taxas"'+
  '  WHEN "446" THEN "DR Royalties/Taxas"'+
  '  WHEN "447" THEN "CR Devol. Antecipacao"'+
  '  WHEN "448" THEN "CR Chargeback 53"'+
  '  WHEN "449" THEN "DR Chargeback"'+
  '  WHEN "450" THEN "Ajuste CFL Exceção"'+
  '  WHEN "451" THEN "WhatsApp Pay"'+
  '  WHEN "452" THEN "MP 15- Gertec"'+
  '  WHEN "453" THEN "MP 35- Gertec"'+
  '  WHEN "454" THEN "POS Link2500 4G"'+
  '  WHEN "455" THEN "CR Negociacao Comercial"'+
  '  WHEN "456" THEN "DR Negociacao Comercial"'+
  '  WHEN "457" THEN "CR Provisao Baixa Debito"'+
  '  WHEN "458" THEN "DR Provisao Baixa Debito"'+
  '  WHEN "460" THEN "Excl pg por port não realiza"'+
  '  WHEN "461" THEN "Compra com 02 parcelas"'+
  '  WHEN "462" THEN "Compra com 03 parcelas"'+
  '  WHEN "463" THEN "Compra com 04 parcelas"'+
  '  WHEN "464" THEN "Compra com 05 parcelas"'+
  '  WHEN "465" THEN "Compra com 06 parcelas"'+
  '  WHEN "466" THEN "Compra com 07 parcelas"'+
  '  WHEN "467" THEN "Compra com 08 parcelas"'+
  '  WHEN "468" THEN "Compra com 09 parcelas"'+
  '  WHEN "469" THEN "Compra com 10 parcelas"'+
  '  WHEN "470" THEN "Compra com 11 parcelas"'+
  '  WHEN "471" THEN "Compra com 12 parcelas"'+
  '  WHEN "472" THEN "Compra com > 12 parcelas"'+
  '  WHEN "473" THEN "Parcelado Emissor-02 parc"'+
  '  WHEN "474" THEN "Parcelado Emissor-03 parc"'+
  '  WHEN "475" THEN "Parcelado Emissor-04 parc"'+
  '  WHEN "476" THEN "Parcelado Emissor-05 parc"'+
  '  WHEN "477" THEN "Parcelado Emissor-06 parc"'+
  '  WHEN "478" THEN "Parcelado Emissor-07 parc"'+
  '  WHEN "479" THEN "Parcelado Emissor-08 parc"'+
  '  WHEN "480" THEN "Parcelado Emissor-09 parc"'+
  '  WHEN "481" THEN "Parcelado Emissor-10 parc"'+
  '  WHEN "482" THEN "Parcelado Emissor-11 parc"'+
  '  WHEN "483" THEN "Parcelado Emissor-12 parc"'+
  '  WHEN "484" THEN "Parcelado Emissor >12 parc"'+
  '  WHEN "485" THEN "Crediario 02 parcelas"'+
  '  WHEN "486" THEN "Crediario 03 parcelas"'+
  '  WHEN "487" THEN "Crediario 04 parcelas"'+
  '  WHEN "488" THEN "Crediario 05 parcelas"'+
  '  WHEN "489" THEN "Crediario 06 parcelas"'+
  '  WHEN "490" THEN "Crediario 07 parcelas"'+
  '  WHEN "491" THEN "Crediario 08 parcelas"'+
  '  WHEN "492" THEN "Crediario 09 parcelas"'+
  '  WHEN "493" THEN "Crediario 10 parcelas"'+
  '  WHEN "494" THEN "Crediario 11 parcelas"'+
  '  WHEN "495" THEN "Crediario 12 parcelas"'+
  '  WHEN "496" THEN "Crediario > 12 parcelas"'+
  '  WHEN "500" THEN "Transaction Process fee Dr"'+
  '  WHEN "501" THEN "Operational Standards fee Dr"'+
  '  WHEN "502" THEN "Cash Disbrsmnt Royalties Dr"'+
  '  WHEN "503" THEN "Transaction process fee Cr"'+
  '  WHEN "504" THEN "Operational Standards fee Cr"'+
  '  WHEN "505" THEN "Cash Disbrsmnt Royalties Cr"'+
  '  WHEN "506" THEN "POS-TEF Whitelabel"'+
  '  WHEN "507" THEN "POS Movel Teclado Vi"'+
  '  WHEN "508" THEN "CR_Comissao_Saque"'+
  '  WHEN "509" THEN "Taxa do pacote de serviços"'+
  '  WHEN "510" THEN "Taxa Ethernet POS"'+
  '  WHEN "511" THEN "Taxa móvel GPRS POS"'+
  '  WHEN "512" THEN "Taxa desktop POS"'+
  '  WHEN "513" THEN "Taxa eth/desktop POS"'+
  '  WHEN "514" THEN "Tx dktop/discada/ethGPRS POS"'+
  '  WHEN "515" THEN "Taxa PINPAD"'+
  '  WHEN "516" THEN "Taxa TEF discada"'+
  '  WHEN "517" THEN "Taxa de arquivo em lote"'+
  '  WHEN "518" THEN "Taxa manutenção POS 2 horas"'+
  '  WHEN "519" THEN "Taxa manutenção POS 4 horas"'+
  '  WHEN "520" THEN "Cobrança de taxas Débito"'+
  '  WHEN "521" THEN "Taxa manutenção POS 24 horas"'+
  '  WHEN "522" THEN "Taxa manutenção POS 48 horas"'+
  '  WHEN "523" THEN "Taxa manutenção POS 72 horas"'+
  '  WHEN "524" THEN "Tx atenção especial Nível 1"'+
  '  WHEN "525" THEN "Tx atenção especial Nível 2"'+
  '  WHEN "526" THEN "Tx atenção especial Nível 3"'+
  '  WHEN "527" THEN "Printed Statement Daily Fee"'+
  '  WHEN "528" THEN "Email Statement Daily Fee"'+
  '  WHEN "529" THEN "EDI Statement Daily Fee"'+
  '  WHEN "530" THEN "EDI Recon. State. Daily Fee"'+
  '  WHEN "531" THEN "Taxa cadeia forn Nível 1"'+
  '  WHEN "532" THEN "Taxa cadeia forn Nível 2"'+
  '  WHEN "533" THEN "Taxa cadeia forn Nível 3"'+
  '  WHEN "534" THEN "Taxa Desktop GPRS POS"'+
  '  WHEN "535" THEN "Taxa de E-Commerce Gateway 1"'+
  '  WHEN "536" THEN "DR Recarga Celular"'+
  '  WHEN "537" THEN "Taxa de associação"'+
  '  WHEN "538" THEN "CR Recarga Celular"'+
  '  WHEN "539" THEN "CR Recuperacao de Perdas"'+
  '  WHEN "540" THEN "Abat por vol vendas nível 154"'+
  '  WHEN "541" THEN "Abat por vol vendas nível 2"'+
  '  WHEN "542" THEN "Abat por vol vendas nível 3"'+
  '  WHEN "543" THEN "Abatimento de POS nível 1"'+
  '  WHEN "544" THEN "Abatimento de POS nível 2"'+
  '  WHEN "545" THEN "Abatimento de POS nível 3"'+
  '  WHEN "546" THEN "Taxa manutenção POS 8 horas"'+
  '  WHEN "548" THEN "DR_Provisao_Dev_Terminal"'+
  '  WHEN "549" THEN "DR_Provisao_Aluguel_Out 23"'+
  '  WHEN "550" THEN "DR_Provisao_Aluguel_Nov 23"'+
  '  WHEN "551" THEN "DR_Provisao_Aluguel_Dez 23"'+
  '  WHEN "552" THEN "DR_Provisao_Aluguel_Jan 24"'+
  '  WHEN "553" THEN "DR_Provisao_Aluguel_Fev 24"'+
  '  WHEN "554" THEN "CR_Provisao_Dev_Terminal"'+
  '  WHEN "555" THEN "DR_Comissao_Saque"'+
  '  WHEN "556" THEN "CR_Provisao_Aluguel_Nov 23"'+
  '  WHEN "557" THEN "CR_Provisao_Aluguel_Dez 23"'+
  '  WHEN "558" THEN "Taxa dedicada TEF"'+
  '  WHEN "559" THEN "Taxa de IP TEF"'+
  '  WHEN "560" THEN "Taxa de E-Commerce Gateway 2"'+
  '  WHEN "561" THEN "Taxa de E-Commerce Gateway 3"'+
  '  WHEN "562" THEN "Taxa de E-Commerce Gateway 4"'+
  '  WHEN "563" THEN "Taxa de E-Commerce Gateway 5"'+
  '  WHEN "564" THEN "Taxa e-com de subadquirente"'+
  '  WHEN "565" THEN "Taxa e-comm solução própria"'+
  '  WHEN "566" THEN "Taxa POS Wifi"'+
  '  WHEN "567" THEN "Taxa POS Wifi GPRS"'+
  '  WHEN "568" THEN "Taxa POS Virtual"'+
  '  WHEN "569" THEN "Taxa POS Auto Credenc"'+
  '  WHEN "570" THEN "CR_Provisao_Aluguel_Jan 24"'+
  '  WHEN "585" THEN "POS MP5 Taxa"'+
  '  WHEN "586" THEN "CR_Provisao_Aluguel_Fev 24"'+
  '  WHEN "588" THEN "POS Link2500 2G Fee"'+
  '  WHEN "589" THEN "POS Link2500 3G Fee"'+
  '  WHEN "598" THEN "POS Link2500 2G PR_ENTR"'+
  '  WHEN "599" THEN "POS Link2500 3G PR_ENTR"'+
  '  WHEN "601" THEN "Cobrança de taxa crédito"'+
  '  WHEN "614" THEN "Moby6500 entrega bau"'+
  '  WHEN "700" THEN "Compra In/Out - Todas"'+
  '  WHEN "701" THEN "Comissão do estabelecimento"'+
  '  WHEN "702" THEN "Comissão do adquirente"'+
  '  WHEN "703" THEN "Estorno da comissão do EC"'+
  '  WHEN "704" THEN "Estorno da comissão do adq"'+
  '  WHEN "705" THEN "Nova comissão do EC"'+
  '  WHEN "706" THEN "Reserva do estabelecimento"'+
  '  WHEN "707" THEN "Todas Compras In/Out - Dom"'+
  '  WHEN "708" THEN "Todas Compras In/Out - Int"'+
  '  WHEN "709" THEN "Liquidação de reserva do EC"'+
  '  WHEN "710" THEN "Crédito de comissão do EC"'+
  '  WHEN "711" THEN "Crédito de comissão do adq"'+
  '  WHEN "712" THEN "Reembolso taxa do EC"'+
  '  WHEN "713" THEN "Liquidação recup tx do EC"'+
  '  WHEN "714" THEN "Taxa reembolso est - Todas"'+
  '  WHEN "720" THEN "Ant espécie In/Out - Todas"'+
  '  WHEN "727" THEN "Ant espéc In/Out-Todas-Dom"'+
  '  WHEN "728" THEN "Ant espéc In/Out-Todas-Int"'+
  '  WHEN "730" THEN "Reembolso In/Out - Todos"'+
  '  WHEN "731" THEN "Cashback In/Out"'+
  '  WHEN "737" THEN "Reemb In/Out - Todos - Dom"'+
  '  WHEN "738" THEN "Reemb In/Out - Todos - Int"'+
  '  WHEN "740" THEN "Taxa compensação In/Out"'+
  '  WHEN "741" THEN "Taxa In/Out por fax"'+
  '  WHEN "742" THEN "Tx compensação In/Out - Dom"'+
  '  WHEN "743" THEN "Tx compensação In/Out - Int"'+
  '  WHEN "750" THEN "Tx compensação In/Out - CFT"'+
  '  WHEN "757" THEN "II Compras - Todas - Dom"'+
  '  WHEN "758" THEN "II Compras - Todas - Int"'+
  '  WHEN "768" THEN "II Crédito"'+
  '  WHEN "777" THEN "II Ant espécie - Todas - Dom"'+
  '  WHEN "778" THEN "II Ant espécie - Todas - Int"'+
  '  WHEN "784" THEN "Acq. Service Fee DR."'+
  '  WHEN "785" THEN "Acq. Service Fee CR."'+
  '  WHEN "797" THEN "Tx dom em espécie liq adq"'+
  '  WHEN "798" THEN "Tx dom em espécie liq adq"'+
  '  WHEN "800" THEN "Comissão de compra do EC"'+
  '  WHEN "801" THEN "Comissão de reembolso do EC"'+
  '  WHEN "802" THEN "Taxa POS Web"'+
  '  WHEN "805" THEN "WhiteLabel_Fee"'+
  '  WHEN "808" THEN "Campanhas"'+
  '  WHEN "812" THEN "Credit MDR_SOCIAL"'+
  '  WHEN "813" THEN "Debit MDR_SOCIAL"'+
  '  WHEN "844" THEN "Interchange Fee Debit"'+
  '  WHEN "850" THEN "MC PWCB Fee CR"'+
  '  WHEN "851" THEN "MC PCB Fee CR"'+
  '  WHEN "852" THEN "MC PWCB Fee DR"'+
  '  WHEN "853" THEN "MC PCB Fee DR"'+
  '  WHEN "900" THEN "Trans déb da conta contábil"'+
  '  WHEN "901" THEN "CRÉD DIVERSOS CONTA CONTÁBIL"'+
  '  WHEN "950" THEN "Transações débito diversas"'+
  '  WHEN "951" THEN "Transações crédito diversas"'+
  '  WHEN "952" THEN "Misc DR - Prep REV Fee"'+
  '  WHEN "953" THEN "Debit compensaction by UR"'+
  '  WHEN "954" THEN "Credit compensaction by UR"'+
  '  WHEN "956" THEN "Ajuste Contr Adic Debito"'+
  '  WHEN "957" THEN "Ajuste Contr Adic Credito"'+
  '  ELSE "Outros" END ';
end;

procedure TConciliacaoSipagFiserv.ValidaCartaoEncontrado(Var ABusca : Boolean;
                                                         Var ADivergenciaCartao : String;
                                                         AClient: TUniClientDataSet);
  Var
    LDiferenca : Double;
begin
  If Not ABusca Then
    Exit;

  // Valor Bruto
  LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('SIP_VALBRU').AsFloat;

  If Not fBetWeen(TSipagFuncoes.fFormataFloat(LDiferenca, 2), -0.29999999, 0.29999999) Then
  Begin
    ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
    ABusca := False;
    Exit;
  End;
end;

procedure TConciliacaoSipagFiserv.ValidaCartaoMarcado(var ADivergenciaCartao: String;
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

function TConciliacaoSipagFiserv.RetornaValorLiquidoParcela: Double;
begin
  Result := cdsConcar.FieldByName('SIP_VALLIQ').AsFloat;
end;

end.
