unit untConciliacaoBanrisul;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math, System.Generics.Collections, System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untBanrisulConciliacaoCartoes, untLibCartoesInterfacesTipos, untTBanrisulFuncoes,
     untBanrisulTipos;

type

  TConciliacaoBanrisul = class(TConciliacaoCartoes)
  private
    FCdsRegistrosMovimento : TUniClientDataSet; //Registros Movimentação cartão
    FCdsRegistrosPagamento : TUniClientDataSet; //Registros Conciliação Financeira
    FCdsRegistrosAjuste    : TUniClientDataSet; //Registros Ajustes
    FCdsRegistrosAntecipacao : TUniClientDataSet; //Registros Antecipação Financeira
    FTolerancia: Double;

    procedure pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
    procedure pCriaDataSets;
    procedure pFiltraAjustesBanrisul;
    procedure FiltraCartoesBaixados;

    function fGetCodigoLancamento(ACodigoModalidade : String) : String;
    function fGetTipoDeOperacao(ACodigoModalidade : String; ATotalParcelas : Integer) : String;
    function fRelatorioPreConciliacao: Boolean;
    function TotalizaComoInconsistenciaQueNaoBaixa(AValor:String):Boolean;
    procedure ValidaCartaoEncontrado(Var ABusca : Boolean;
                                     Var ADivergenciaCartao : String;
                                     AClient: TUniClientDataSet);

    function fProcessaRegistrosAntecipacao(pgbStatus: TcxProgressBar): Boolean;
    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaBanrisul(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
  end;

implementation


{ TConciliacaoBanrisul }

function TConciliacaoBanrisul.fConciliaBanrisul(pgbStatus: TcxProgressBar): Boolean;
Var
  blnVazio     : Boolean;
begin
  TForm(pgbStatus.Owner).Visible := False;
  Try
    Try
      Result       := False;
      FPossuiInconsistencia := False;

      Application.ProcessMessages;

      objConcil.TabelaConciliacao           := 'BAN_BSCRED';
      objConcil.CampoEstabelecimento        := 'BAN_CNPJES';
      objConcil.NomeConciliacao             := 'BANRISUL';
      objConcil.CampoValorBruto             := 'BAN_VALPAR';
      objConcil.CampoValorLiquido           := 'BAN_VALLIQ';
      objConcil.CampoCodigoAutorizacao      := 'BAN_NUMCCD';
      objConcil.CampoNumeroNSU              := 'BAN_NUMNSU';
      objConcil.CampoDataTransacaoVenda     := 'BAN_DTALAN';
      objConcil.CampoDataRecebimento        := 'BAN_DTALAN';
      objConcil.CampoNumeroParcela          := 'BAN_NUMPAR';
      objConcil.CampoTotalParcelas          := 'BAN_TOTPAR';
      objConcil.CampoNumeroCartao           := '';
      objConcil.CampoTipoRegistro           := '';
      objConcil.CampoTipoTransacao          := '';
      objConcil.CfgEstabelecimentos         := 'CFG_BANEST';
      objConcil.CfgPortadorAjustes          := 'BANPOR';
      objConcil.CfgPlanoDeContasAjustes     := 'BANCTA';
      objConcil.CfgFornecedorAjustes        := 'BANFOR';
      objConcil.strEventoCancelamentoAjuste := 'BANEVE';

      If Not fDigPeriodo Then
        Exit;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'BANRISUL',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TBanrisulFuncoes.RetornaDataHoraServidor,
                                                            TBanrisulFuncoes.RetornaHoraServidor);

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;

      TBanrisulFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros para conciliação.', False);
      pCriaDataSets;

      blnVazio := ((FCdsRegistrosPagamento.IsEmpty) or (FCdsRegistrosMovimento.IsEmpty)) and
                  FCdsRegistrosAntecipacao.IsEmpty;

      If blnVazio Then
      Begin
        TBanrisulFuncoes.fMensagem('','Nenhum registro foi importado para o período selecionado.',['&OK']);
        blnReabre := True;
        Exit;
      End;

      {**************************************}
      {* VERIFICA SE FALTAM ARQUIVOS E ABRE *}
      {* O DIREITO DE ACESSO PARA CONTINUAR *}
      {***********************************GD*}
      If fRelatorioPreConciliacao Then
      Begin
        If Not VS_FuncoesExternas.fIPedirLiberacao('CARCONARQIMP',
                                                   'Conciliação de cartões de crédito com inconsistência nos arquivos importados',
                                                   'Permitir realizar conciliação de cartões de crédito com inconsistência nos arquivos importados.') Then
          Exit;
      End;


      //Data para filtrar o MOVCAR dos baixados
      If Assigned(lstDtaCad) Then
        FreeAndNil(lstDtaCad);

      lstDtaCad := TStringList.Create;

      pCalculaPeriodoFiltro(FCdsRegistrosMovimento);
      pCalculaPeriodoFiltro(FCdsRegistrosAntecipacao);

      TBanrisulFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões.', False);
      pFiltraCartoes;

      strCondicao := ' BAN_DTALAN BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" '+
                     ' AND BAN_VALCAN > 0 '+
                     fRetPesqPonVen(1);

      FiltrarCancelamentosPeriodo(strCondicao,
                           'BAN_DESCRI',
                           '0');

      pFiltraAjustesBanrisul;

      TBanrisulFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões baixados.', False);
      FiltraCartoesBaixados;

      cdsBaiCar.Filter   := 'MCA_MARDES <> ' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      pgbStatus.Visible := True;
      TBanrisulFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de antecipação (' + objConcil.NomeConciliacao + ').', False);
      fProcessaRegistrosAntecipacao(pgbStatus);

      If Not FCdsRegistrosPagamento.IsEmpty Then
      Begin
        TBanrisulFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de débito\crédito (' + objConcil.NomeConciliacao + ').', False);
        fProcessaRegistrosDebitoCredito(pgbStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TBanrisulFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(pgbStatus);

      if FPossuiInconsistencia then
       TBanrisulFuncoes.fMensagem('', 'Foram encontradas inconsistências na importação dos arquivos!', ['&OK']);

      If (Not FCdsRegistrosPagamento.IsEmpty) Or
         (Not FCdsRegistrosAntecipacao.IsEmpty) Or
         (Assigned(cdsAjustes) And (Not cdsAjustes.IsEmpty)) Then
      Begin
         Result := GeraRelatorioConciliacao('BANRISUL', pgbStatus);
      End;

      If Assigned(cdsAjustes) Then
      Begin
        cdsAjustes.Filter   := 'BAN_CONCIL = 0';
        cdsAjustes.Filtered := True;
      End;

      blnReabre := Not Result;
      If Result Then
      Begin
        Result := Not cdsBaiCar.IsEmpty;
        If Not Result Then
          TBanrisulFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
        Else
          TBanrisulFuncoes.fMensagem('AVISO','Conciliação da ' + objConcil.NomeConciliacao + ' realizada com sucesso.',['&OK']);
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaBanrisul]');
      End;
    End;
  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(FCdsRegistrosPagamento);
    TBanrisulFuncoes.FreeAndNilDatasets(FCdsRegistrosMovimento);
    TBanrisulFuncoes.FreeAndNilDatasets(FCdsRegistrosAjuste);
    TBanrisulFuncoes.FreeAndNilDatasets(FCdsRegistrosAntecipacao);
    TBanrisulFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
end;

function TConciliacaoBanrisul.fConciliaCartoes: Boolean;
begin
  Result := TBanrisulFuncoes.ExecutaAguarde(fConciliaBanrisul, 'Aguarde... Iniciando a conciliação.');
end;

function TConciliacaoBanrisul.fGetCodigoLancamento(ACodigoModalidade: String): String;
begin
 Result := '';
 if ACodigoModalidade = '00001' then  //BANRICOMPRAS A VISTA
   Result := QuotedStr('0001')       //A VISTA
 else
 if ACodigoModalidade = '00002' then  //BANRICOMPRAS A PRAZO
   Result := QuotedStr('0003')+','+   //PARCELADO SEM ENTRADA
             QuotedStr('0004')        //PRE-DATADO
 else
 if ACodigoModalidade = '00003' then  //CARTAO DEBITO
   Result := QuotedStr('0201')        //DEBITO A VISTA
 else
 if ACodigoModalidade = '00004' then  //CARTAO CREDITO
   Result := QuotedStr('0202')+','+  //CREDITO A VISTA,
             QuotedStr('0203')+','+  //CREDITO PARCELADO LOGISTA
             QuotedStr('0206')       //PARCELA A VISTA CREDITO PARCELADO LOJISTA
 else
 if ACodigoModalidade = '00031' then  //BANRICOMPRAS PARCELADO COM ENTRADA
   Result := QuotedStr('0002')        //PARCELADO COM ENTRADA
 else
 if ACodigoModalidade = '00040' then  //BANRICARD OUTROS
   Result := QuotedStr('0023');       //VOUCHERS EMPRESARIAIS
end;

function TConciliacaoBanrisul.fGetTipoDeOperacao(ACodigoModalidade : String; ATotalParcelas : Integer): String;
begin
  Result := '';
  if (ACodigoModalidade = '00001') or   //BANRICOMPRAS A VISTA
     (ACodigoModalidade = '00003') or   //CARTAO DEBITO
     (ACodigoModalidade = '00040') then //BANRICARD OUTROS
    Result := 'DÉBITO'
  else
  if (ACodigoModalidade = '00002') or   //BANRICOMPRAS A PRAZO
     (ACodigoModalidade = '00004') or   //CARTAO CREDITO
     (ACodigoModalidade = '00031') then //BANRICOMPRAS PARCELADO COM ENTRADA
    Result := TBanrisulFuncoes.IIF(ATotalParcelas > 1, 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO');
end;

procedure TConciliacaoBanrisul.FiltraCartoesBaixados;
begin
  pFiltraCartoesBaixados(False);
end;

function TConciliacaoBanrisul.fProcessaRegistrosAntecipacao(pgbStatus: TcxProgressBar): Boolean;
Var strParcel  : String;
    strNumNsu  : String;
    strCodEmp  : String;
    dtaDtaCad  : TDateTime;
    intLimpMem : Integer;
    strNumAut  : String;
    blnBusca   : Boolean;
    LChaveConciliacao : String;
    LRegistroRelatorio       : TItensRelatorioCartoes;
begin
  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosAntecipacao.RecordCount;
    intLimpMem := 0;

    FCdsRegistrosAntecipacao.First;
    While Not FCdsRegistrosAntecipacao.Eof Do
    Begin
      TBanrisulFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      If intLimpMem >= 50 Then
      Begin
        VS_FuncoesExternas.pITrimAppMemorySize;
        intLimpMem := 0;
      End
      Else
        inc(intLimpMem);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      strParcel := TBanrisulFuncoes.fGetLetraAlfa(StrtoInt(LeftStr(FCdsRegistrosAntecipacao.FieldByName('BAN_NUMPAR').AsString , 2)));
      FTextoInconsistencia := '';
      strNumNsu := TBanrisulFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosAntecipacao.FieldByName('BAN_NUMNSU').AsString, 14)), 14);
      strNumAut := TBanrisulFuncoes.fStrZero(Trim(RightStr('0', 14)), 14);
      dtaDtaCad := FCdsRegistrosAntecipacao.FieldByName('BAN_DTAORI').Value;
      strCodEmp := FCdsRegistrosAntecipacao.FieldByName('EMP_CODEMP').AsString;

      blnBusca := fBuscaCartao(strNumAut,
                               strNumNsu,
                               strCodEmp,
                               strParcel,
                               dtaDtaCad);

      If (blnBusca) Then
      Begin
        LChaveConciliacao := 'BAN_' +FCdsRegistrosAntecipacao.FieldByName('BAN_CNPJES').AsString + '_' +
                             FCdsRegistrosAntecipacao.FieldByName('BAN_NUMNSU').Value + '_' +
                             strParcel + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', FCdsRegistrosAntecipacao.FieldByName('BAN_DTATRA').Value);


        MarcarCartaoEncontradoArquivo(FCdsRegistrosAntecipacao.FieldByName('BAN_VALTRA').Value,
                                      True,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      FCdsRegistrosAntecipacao);
      End
      Else
      Begin
        blnAutomatica := FCdsRegistrosAntecipacao.FieldByName('BAN_CONCIL').Value = '1';

        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixado(strNumAut,
                                        strNumNsu,
                                        strCodEmp,
                                        strParcel,
                                        dtaDtaCad);

        FTextoInconsistencia := 'Cartão já foi baixado';
        If Not blnBusca Then
          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
      End;

      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);

      If Not TBanrisulFuncoes.fEmptyStr(FTextoInconsistencia) Then
      Begin
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
        LRegistroRelatorio.Descricao      := FTextoInconsistencia;

        if TotalizaComoInconsistenciaQueNaoBaixa(FTextoInconsistencia) then
          LRegistroRelatorio.SomarNoTotal := 'S';
      end;

      LRegistroRelatorio.NomeArquivo :=FCdsRegistrosAntecipacao.FieldByName('BAN_NOMARQ').AsString;
      LRegistroRelatorio.Conciliado :=FCdsRegistrosAntecipacao.FieldByName('BAN_CONCIL').Value;

      LRegistroRelatorio.ValorBruto := FCdsRegistrosAntecipacao.FieldByName('BAN_VALPAR').AsFloat;
      LRegistroRelatorio.NumeroNSU := TBanrisulFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosAntecipacao.FieldByName('BAN_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosAntecipacao.FieldByName('BAN_CNPJES').AsString;
      LRegistroRelatorio.ResumoVenda := '';
      LRegistroRelatorio.NumeroCartao := FCdsRegistrosAntecipacao.FieldByName('BAN_NUMCAR').AsString;
      LRegistroRelatorio.TipoCartao := 'ANTECIPACAO';
      LRegistroRelatorio.DataVenda := FCdsRegistrosAntecipacao.FieldByName('BAN_DTAVEN').AsDateTime;
      LRegistroRelatorio.DataVencimento  := FCdsRegistrosAntecipacao.FieldByName('BAN_VENPAR').AsDateTime;
      LRegistroRelatorio.Parcela:= FCdsRegistrosAntecipacao.FieldByName('BAN_NUMPAR').AsString;
      LRegistroRelatorio.TotalParcelas := FCdsRegistrosAntecipacao.FieldByName('BAN_TOTPAR').AsString;
      LRegistroRelatorio.CodigoAutorizacao := TBanrisulFuncoes.fStrZero(Trim(RightStr('0', 6)), 6);
      LRegistroRelatorio.ValorLiquido := FCdsRegistrosAntecipacao.FieldByName('BAN_VALTRA').Value;

      If Not TbanrisulFuncoes.fEmptyStr(FCdsRegistrosAntecipacao.FieldByName('EMP_CODEMP').AsString) Then
        LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosAntecipacao.FieldByName('EMP_CODEMP').AsString;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosAntecipacao.Next;
    End;

    Result := True;

  Except
    Raise;
  End;
end;

function TConciliacaoBanrisul.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
Var strParcel                : String;
    strNumNsu                : String;
    strCodEmp                : String;
    dtaDtaCad                : TDateTime;
    intLimpMem               : Integer;
    strNumAut                : String;
    blnBusca                 : Boolean;
    LRegistroRelatorio       : TItensRelatorioCartoes;
    SFiltroCodigoLancamento  : String;
    STipoOperacao            : String;
    LDivergenciaCartao       : String;
    LChaveConciliacao        : string;
    blnSemReg                : Boolean;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosPagamento.RecordCount;
    intLimpMem := 0;
    

    FCdsRegistrosPagamento.First;
    While Not FCdsRegistrosPagamento.Eof Do
    Begin

      TbanrisulFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      If intLimpMem >= 50 Then
      Begin
        VS_FuncoesExternas.pITrimAppMemorySize;
        intLimpMem := 0;
      End
      Else
        inc(intLimpMem);

      SFiltroCodigoLancamento := fGetCodigoLancamento(FCdsRegistrosPagamento.FieldByName('BAN_CODMOD').AsString);

      {********************************************************************
       SE NÃO CONSEGUIU FILTRAR O CODIGO DO LANÇAMENTO EM VIRTUDE DO CODIGO
       DA MODALIDADE É PORQUE A MODALIDADE AINDA NÃO FOI MAPEADA. TEMOS COMO
       CASO A ANTECIPAÇÃO, MAS COMO NÃO TEMOS OS ARQUIVOS DE ANTECIPAÇÃO PARA
       VALIDAR O MAPEAMENTO,NESTE MOMENTO, O REGISTRO SERÁ DESCONSIDERADO.
      {******************************************************************GD*}
      if TbanrisulFuncoes.fEmptyStr(SFiltroCodigoLancamento) then
      Begin
        FCdsRegistrosPagamento.Next;
        continue;
      End;

      FCdsRegistrosMovimento.Filter := ' BAN_CODLAN IN ('+SFiltroCodigoLancamento+') AND '+
                                       ' BAN_CNPJES = '+QuotedStr(FCdsRegistrosPagamento.FieldByName('BAN_CNPJES').AsString)+' AND '+
                                       ' BAN_BANDEI = '+QuotedStr(FCdsRegistrosPagamento.FieldByName('BAN_BANDEI').AsString)+' AND '+
                                       ' BAN_DTALAN = '+QuotedStr(FCdsRegistrosPagamento.FieldByName('BAN_DTALAN').AsString);
      FCdsRegistrosMovimento.Filtered := True;

      FCdsRegistrosMovimento.First;

      blnSemReg := (FCdsRegistrosMovimento.RecordCOunt = 0);


      While Not FCdsRegistrosMovimento.Eof Do
      Begin
        LRegistroRelatorio := TItensRelatorioCartoes.Create;

        LRegistroRelatorio.NomeArquivo :=FCdsRegistrosPagamento.FieldByName('BAN_NOMARQ').AsString;


        STipoOperacao := fGetTipoDeOperacao(FCdsRegistrosPagamento.FieldByName('BAN_CODMOD').AsString,
                                            FCdsRegistrosMovimento.FieldByName('BAN_TOTPAR').Value);

        strParcel := TBanrisulFuncoes.fGetLetraAlfa(StrtoInt(LeftStr(FCdsRegistrosMovimento.FieldByName('BAN_NUMPAR').AsString , 2)));
        FTextoInconsistencia := '';
        strNumNsu := TBanrisulFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosMovimento.FieldByName('BAN_NUMNSU').AsString, 14)), 14);
        strNumAut := TBanrisulFuncoes.fStrZero(Trim(RightStr('0', 14)), 14);
        dtaDtaCad := FCdsRegistrosMovimento.FieldByName('BAN_DTAORI').Value;
        strCodEmp := FCdsRegistrosMovimento.FieldByName('EMP_CODEMP').AsString;

        {********************}
        {* NOVA CONCILIAÇÃO *}
        {*****************GD*}
        blnBusca := fBuscaCartao(strNumAut,
                                 strNumNsu,
                                 strCodEmp,
                                 strParcel,
                                 dtaDtaCad);

        LDivergenciaCartao := '';
        ValidaCartaoEncontrado(blnBusca, LDivergenciaCartao, FCdsRegistrosMovimento);

        If (blnBusca) Then
        Begin
           LChaveConciliacao := 'BAN_' +FCdsRegistrosMovimento.FieldByName('BAN_CNPJES').AsString + '_' +
                               FCdsRegistrosMovimento.FieldByName('BAN_NUMNSU').Value + '_' +
                               strParcel + '_' +
                               cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', FCdsRegistrosMovimento.FieldByName('BAN_DTALAN').Value);


          MarcarCartaoEncontradoArquivo(FCdsRegistrosMovimento.FieldByName('BAN_VALLIQ').Value,
                                      False,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      FCdsRegistrosMovimento);

        End
        Else
        Begin
          blnAutomatica := FCdsRegistrosMovimento.FieldByName('BAN_CONCIL').Value = '1';

          cdsBaixad.First;
          blnBusca := fBuscaCartaoBaixado(strNumAut,
                                          strNumNsu,
                                          strCodEmp,
                                          strParcel,
                                          dtaDtaCad);

          FTextoInconsistencia := 'Cartão já foi baixado';
          If Not blnBusca Then
            FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
        End;

        FTextoInconsistencia := TbanrisulFuncoes.IIF(TbanrisulFuncoes.fEmptyStr(LDivergenciaCartao), FTextoInconsistencia, LDivergenciaCartao);
        FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);

        If Not TBanrisulFuncoes.fEmptyStr(FTextoInconsistencia) Then
        Begin
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
          LRegistroRelatorio.Descricao      := FTextoInconsistencia;

          if TotalizaComoInconsistenciaQueNaoBaixa(FTextoInconsistencia) then
            LRegistroRelatorio.SomarNoTotal := 'S';
        end;

        LRegistroRelatorio.NomeArquivo :=FCdsRegistrosMovimento.FieldByName('BAN_NOMARQ').AsString;
        LRegistroRelatorio.Conciliado := FCdsRegistrosMovimento.FieldByName('BAN_CONCIL').Asinteger;

        LRegistroRelatorio.ValorBruto :=FCdsRegistrosMovimento.FieldByName('BAN_VALPAR').AsFloat;
        LRegistroRelatorio.NumeroNSU := TbanrisulFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosMovimento.FieldByName('BAN_NUMNSU').AsString, 14)), 14);
        LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosMovimento.FieldByName('BAN_CNPJES').AsString;
        LRegistroRelatorio.ResumoVenda := '';
        LRegistroRelatorio.NumeroCartao := FCdsRegistrosMovimento.FieldByName('BAN_NUMCAR').AsString;
        LRegistroRelatorio.TipoCartao := STipoOperacao;
        LRegistroRelatorio.DataVenda  := FCdsRegistrosMovimento.FieldByName('BAN_DTAVEN').AsDateTime;
        LRegistroRelatorio.DataVencimento := FCdsRegistrosMovimento.FieldByName('BAN_DTACRE').AsDateTime;
        LRegistroRelatorio.Parcela := FCdsRegistrosMovimento.FieldByName('BAN_NUMPAR').AsString;
        LRegistroRelatorio.TotalParcelas := FCdsRegistrosMovimento.FieldByName('BAN_TOTPAR').AsString;
        LRegistroRelatorio.CodigoAutorizacao := TbanrisulFuncoes.fStrZero(Trim(RightStr('0', 6)), 6);
        LRegistroRelatorio.ValorLiquido := FCdsRegistrosMovimento.FieldByName('BAN_VALLIQ').Value;

        If Not TbanrisulFuncoes.fEmptyStr(FCdsRegistrosMovimento.FieldByName('EMP_CODEMP').AsString) Then
          LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosMovimento.FieldByName('EMP_CODEMP').AsString;

        LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao );

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);



        FCdsRegistrosMovimento.Next;

      End;


      If blnSemReg Then
      Begin
        LRegistroRelatorio := TItensRelatorioCartoes.Create;
        LRegistroRelatorio.NomeArquivo := FCdsRegistrosPagamento.FieldByName('BAN_NOMARQ').AsString;
        LRegistroRelatorio.TipoDoRegistro := 'FALTANDO';
        LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('BAN_CNPJES').AsString;
        LRegistroRelatorio.ResumoVenda := '';
        LRegistroRelatorio.DataVenda := FCdsRegistrosPagamento.FieldByName('BAN_DTALAN').AsDateTime;
        LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('BAN_DTALAN').AsDateTime;
        LRegistroRelatorio.ValorLiquido := FCdsRegistrosPagamento.FieldByName('BAN_VALLAN').AsFloat;
        LRegistroRelatorio.ValorBruto := FCdsRegistrosPagamento.FieldByName('BAN_VALLAN').AsFloat;
        LRegistroRelatorio.Parcela := EmptyStr;
        LRegistroRelatorio.TotalParcelas := EmptyStr;
        LRegistroRelatorio.RegistroIncompleto := 'S';

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);
      End;

      FCdsRegistrosPagamento.Next;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
      Result := False;
    End;
  End;

end;

function TConciliacaoBanrisul.fRelatorioPreConciliacao: Boolean;
Var
  qryGenCon: TUniQuery;
  SFiltroEstabelecimento : String;
begin
  //Atualiza importados
  SFiltroEstabelecimento := fRetPesqPonVen(0);

  VS_FuncoesExternas.fIStartTransaction;

  qryGenCon := Nil;
  Try
    Try
      qryGenCon := VS_FuncoesExternas.fICriaQuery;
      qryGenCon.SQL.Text := ' UPDATE BAN_BSCRED C '+
                            ' INNER JOIN BAN_BSVEND V ON C.BAN_NUMNSU = V.BAN_NUMNSU '+
                            '                        AND C.BAN_DTAVEN = V.BAN_DTAVEN '+
                            '                        AND C.BAN_NUMPAR = V.BAN_NUMPAR '+
                            ' LEFT JOIN CFGSIS ON SIS_VALCFG = C.BAN_CNPJES '+
                            '                 AND SIS_CODCFG = "CFG_BANEST" '+
                            ' LEFT JOIN CADEMP ON EMP_CODEMP = SIS_CODEMP   '+
                            '   SET C.BAN_IMPTOT = 1 '+
                            ' WHERE C.BAN_DTALAN BETWEEN :DTAINI AND :DTAFIM '+
                            '   AND C.BAN_IMPTOT = 0 ';

      if not TBanrisulFuncoes.fEmptyStr(SFiltroEstabelecimento) then
        qryGenCon.SQL.Text := qryGenCon.SQL.Text +
                              StringReplace(SFiltroEstabelecimento,
                                            objConcil.CampoEstabelecimento,
                                            'C.'+objConcil.CampoEstabelecimento,
                                            [rfReplaceAll]);

      qryGenCon.ParamByName('DTAINI').AsString := FormatDatetime('yyyy-mm-dd', dtaDtaIni);
      qryGenCon.ParamByName('DTAFIM').AsString := FormatDatetime('yyyy-mm-dd', dtaDtaFim);
      qryGenCon.ExecSQL;

      VS_FuncoesExternas.fICommit;
    Except
      VS_FuncoesExternas.fIRollBack;
    End;
    Application.ProcessMessages;

    //Verifica se possuir arquivos não importados
    qryGenCon.Close;
    qryGenCon.SQL.Clear;
    qryGenCon.SQL.Text := ' SELECT C.BAN_CNPJES AS NUM_PV, '+
                          '         '''' AS NUM_RV, '+
                          '        C.BAN_DTAVEN AS DTA_CV, '+
                          '        C.BAN_VALLIQ AS VALORI, '+
                          '        "ARQUIVOS COM INCONSISTÊNCIA" AS DESCRI, '+
                          '        C.BAN_NOMARQ AS NOMARQ, '+
                          '        C.BAN_NUMPAR AS PARCEL '+
                          ' FROM BAN_BSCRED C '+
                          ' LEFT JOIN CFGSIS ON SIS_VALCFG = C.BAN_CNPJES '+
                          '                  AND SIS_CODCFG = "CFG_BANEST" '+
                          ' LEFT JOIN CADEMP ON EMP_CODEMP = SIS_CODEMP '+
                          ' WHERE C.BAN_DTALAN BETWEEN :DTAINI AND :DTAFIM '+
                          '   AND C.BAN_IMPTOT = 0 ';

    if not TBanrisulFuncoes.fEmptyStr(SFiltroEstabelecimento) then
      qryGenCon.SQL.Text := qryGenCon.SQL.Text +
                            StringReplace(SFiltroEstabelecimento,
                                          objConcil.CampoEstabelecimento,
                                          'C.'+objConcil.CampoEstabelecimento,
                                          [rfReplaceAll]);

    qryGenCon.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    qryGenCon.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    qryGenCon.Open;
    Application.ProcessMessages;

    Result := qryGenCon.RecordCount > 0;

    If Result Then
    Begin
      TBanrisulFuncoes.fMensagem('ATENÇÃO', 'Existem registros sem importar no período selecionado.', ['&Ok']);

      VS_FuncoesExternas.prcIExecutaRelatorio( 572,
                                               40391,
                                               [],
                                               ['DTAINI', 'DTAFIN'],
                                               [FormatDateTime('dd/mm/yyyy', dtaDtaIni),
                                               FormatDateTime('dd/mm/yyyy', dtaDtaFim)
                                               ],
                                               nil,
                                               nil,
                                               True);
    End;
  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(qryGenCon);
  End;
end;

procedure TConciliacaoBanrisul.pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
begin
  If (Assigned(ACdsBase)) And (Not ACdsBase.IsEmpty) Then
  Begin
    ACdsBase.IndexFieldNames := 'BAN_DTAORI';
    ACdsBase.First;

    If dtaDtaIni > ACdsBase.FieldByName('BAN_DTAORI').Value Then
      dtaDtaIni := ACdsBase.FieldByName('BAN_DTAORI').Value;

    While Not ACdsBase.Eof Do
    Begin
      If lstDtaCad.IndexOf(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('BAN_DTAORI').Value)) < 0 Then
        lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('BAN_DTAORI').Value));

      ACdsBase.Next;
    End;
    ACdsBase.Last;

    If dtaDtaFim < ACdsBase.FieldByName('BAN_DTAORI').Value Then
      dtaDtaFim := ACdsBase.FieldByName('BAN_DTAORI').Value;
  End;

end;

procedure TConciliacaoBanrisul.pCriaDataSets;
Var LQueryPagamento,
    LQueryMovimento,
    LQueryAjustes,
    LQueryAntecipacao  : TUniQuery;

    LFiltroEstabelecimento : String;
begin
  LQueryPagamento := Nil;
  LQueryMovimento := Nil;
  LQueryAjustes := Nil;
  LQueryAntecipacao := Nil;

  Try
    LQueryPagamento := VS_FuncoesExternas.fICriaQuery;
    LQueryMovimento := VS_FuncoesExternas.fICriaQuery;
    LQueryAjustes := VS_FuncoesExternas.fICriaQuery;
    LQueryAntecipacao := VS_FuncoesExternas.fICriaQuery;

    LFiltroEstabelecimento := fRetPesqPonVen(0);

    //CONCILIAÇÃO FINANCEIRA
    LQueryPagamento.Close;
    LQueryPagamento.SQL.Text := ' SELECT SQL_NO_CACHE  '+
                                '        P.BAN_CNPJES, '+
                                '        P.BAN_BANDEI, '+
                                '        P.BAN_CODMOD, '+
                                '        P.BAN_TIPMOV, '+
                                '        P.BAN_DTALAN, '+
                                '        P.BAN_DTAREF, '+
                                '        P.BAN_VALLAN, '+
                                '        P.BAN_NOMARQ  '+
                                ' FROM BAN_BSPGTO P  '+
                                ' LEFT JOIN CFGSIS C ON C.SIS_CODCFG = ''CFG_BANEST'' AND LOCATE(P.BAN_CNPJES, C.SIS_VALCFG) > 0 '+
                                ' LEFT JOIN CADEMP E ON E.EMP_CODEMP = C.SIS_CODEMP '+
                                ' WHERE P.BAN_DTALAN BETWEEN :DTAINI AND :DTAFIM '+
                                '   AND P.BAN_TIPMOV = ''C'' ';

    if not TBanrisulFuncoes.fEmptyStr(LFiltroEstabelecimento) then
      LQueryPagamento.SQL.Text := LQueryPagamento.SQL.Text +
                                  StringReplace(LFiltroEstabelecimento,
                                                objConcil.CampoEstabelecimento,
                                                'P.'+objConcil.CampoEstabelecimento,
                                                [rfReplaceAll]);

    LQueryPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryPagamento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryPagamento.Open;
    FCdsRegistrosPagamento   := TBanrisulFuncoes.CriarClientDataSet(LQueryPagamento);
    Application.ProcessMessages;

    //DEBITOS E CREDITOS
    LQueryMovimento.SQL.Clear;
    LQueryMovimento.SQL.Text := ' SELECT SQL_NO_CACHE  '+
                                '        EMP_CODEMP,   '+
                                '        EMP_NOMEMP,   '+
                                '        C.BAN_CNPJES, '+
                                '        C.BAN_DTALAN, '+
                                '        C.BAN_CODLAN, '+
                                '        C.BAN_DTAVEN, '+
                                '        C.BAN_NUMNSU, '+
                                '        '''' BAN_NUMCCD, '+
                                '        C.BAN_NUMPAR, '+
                                '        V.BAN_DTACRE, '+
                                '        V.BAN_DTAORI, '+
                                '        V.BAN_TOTPAR, '+
                                '        V.BAN_VALVEN, '+
                                '        C.BAN_VALPAR, '+
                                '        C.BAN_VALLIQ, '+
                                '        C.BAN_TARFIX, '+
                                '        C.BAN_TARADM, '+
                                '        C.BAN_TARCOM, '+
                                '        C.BAN_VALCAN, '+
                                '        V.BAN_BANDEI, '+
                                '        CONCAT(CONCAT(V.BAN_INICAR, ''******''), V.BAN_FINCAR) BAN_NUMCAR, '+
                                '        C.BAN_NOMARQ, '+
                                '        C.BAN_CONCIL  '+
                                '   FROM BAN_BSCRED C  '+
                                '  INNER JOIN BAN_BSVEND V ON C.BAN_NUMNSU = V.BAN_NUMNSU '+
                                '                         AND C.BAN_DTAVEN = V.BAN_DTAVEN '+
                                '                         AND C.BAN_NUMPAR = V.BAN_NUMPAR '+
                                '   LEFT JOIN CFGSIS ON SIS_VALCFG = C.BAN_CNPJES '+
                                '                   AND SIS_CODCFG = "CFG_BANEST" '+
                                '   LEFT JOIN CADEMP ON SIS_CODEMP = EMP_CODEMP   '+
                                ' WHERE C.BAN_DTALAN BETWEEN :DTAINI AND :DTAFIM  '+
                                '   AND C.BAN_VALCAN = 0 ';

    if not TBanrisulFuncoes.fEmptyStr(LFiltroEstabelecimento) then
      LQueryMovimento.SQL.Text := LQueryMovimento.SQL.Text +
                                  StringReplace(LFiltroEstabelecimento,
                                                objConcil.CampoEstabelecimento,
                                                'C.'+objConcil.CampoEstabelecimento,
                                                [rfReplaceAll]);

    LQueryMovimento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryMovimento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryMovimento.Open;
    FCdsRegistrosMovimento   := TBanrisulFuncoes.CriarClientDataSet(LQueryMovimento);
    Application.ProcessMessages;

    //AJUSTES
    LQueryAjustes.SQL.Text := ' SELECT SQL_NO_CACHE P.BAN_VALLAN AS AJUCRE, E.EMP_CODEMP, '+
                              '        E.EMP_NOMEMP,P.BAN_DTALAN, P.BAN_CONCIL '+
                              '   FROM BAN_BSPGTO P '+
                              '   LEFT JOIN CFGSIS C ON C.SIS_VALCFG = P.BAN_CNPJES '+
                              '                     AND C.SIS_CODCFG = "CFG_BANEST" '+
                              '   LEFT JOIN CADEMP E ON C.SIS_CODEMP = E.EMP_CODEMP '+
                              ' WHERE P.BAN_DTALAN BETWEEN :DTAINI AND :DTAFIM '+
                              '   AND P.BAN_TIPMOV = ''D'' ';

    if not TBanrisulFuncoes.fEmptyStr(LFiltroEstabelecimento) then
      LQueryAjustes.SQL.Text := LQueryAjustes.SQL.Text +
                                StringReplace(LFiltroEstabelecimento,
                                              objConcil.CampoEstabelecimento,
                                              'P.'+objConcil.CampoEstabelecimento,
                                              [rfReplaceAll]);

    LQueryAjustes.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryAjustes.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryAjustes.Open;
    FCdsRegistrosAjuste := TBanrisulFuncoes.CriarClientDataSet(LQueryAjustes);

    //ANTECIPAÇÕES
    LQueryAntecipacao.SQL.Text := ' SELECT E.EMP_CODEMP, '+
                                  '        E.EMP_NOMEMP, '+
                                  '        A.BAN_CNPJES, '+
                                  '        A.BAN_DTATRA, '+
                                  '        V.BAN_DTAVEN, '+
                                  '        V.BAN_DTACRE, '+
                                  '        V.BAN_DTAORI, '+
                                  '        A.BAN_VENPAR, '+
                                  '        A.BAN_NUMNSU, '+
                                  '        A.BAN_NUMPAR, '+
                                  '        A.BAN_TOTPAR, '+
                                  '        A.BAN_VALTRA, '+
                                  '        A.BAN_VALPAR, '+
                                  '        A.BAN_BANDEI, '+
                                  '        A.BAN_DTAPAG, '+
                                  '        A.BAN_CONCIL, '+
                                  '        CONCAT(CONCAT(V.BAN_INICAR, ''******''), V.BAN_FINCAR) BAN_NUMCAR, '+
                                  '        A.BAN_NOMARQ  '+
                                  '    FROM BAN_BSANTE A '+
                                  '  INNER JOIN BAN_BSVEND V ON A.BAN_NUMNSU = V.BAN_NUMNSU '+
                                  '                         AND A.BAN_NUMPAR = V.BAN_NUMPAR '+
                                  '                         AND A.BAN_BANDEI = V.BAN_BANDEI '+
                                  '       LEFT JOIN CFGSIS C ON C.SIS_VALCFG = A.BAN_CNPJES '+
                                  '                         AND C.SIS_CODCFG = "CFG_BANEST" '+
                                  '       LEFT JOIN CADEMP E ON C.SIS_CODEMP = E.EMP_CODEMP '+
                                  '  WHERE A.BAN_DTATRA BETWEEN :DTAINI AND :DTAFIM         ';

    if not TBanrisulFuncoes.fEmptyStr(LFiltroEstabelecimento) then
      LQueryAntecipacao.SQL.Text := LQueryAntecipacao.SQL.Text +
                                    StringReplace(LFiltroEstabelecimento,
                                                  objConcil.CampoEstabelecimento,
                                                  'A.'+objConcil.CampoEstabelecimento,
                                                  [rfReplaceAll]);

    LQueryAntecipacao.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryAntecipacao.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryAntecipacao.Open;
    FCdsRegistrosAntecipacao := TBanrisulFuncoes.CriarClientDataSet(LQueryAntecipacao);
    Application.ProcessMessages;

  Finally
    TBanrisulFuncoes.FreeAndNilDatasets(LQueryPagamento);
    TBanrisulFuncoes.FreeAndNilDatasets(LQueryMovimento);
    TBanrisulFuncoes.FreeAndNilDatasets(LQueryAjustes);
    TBanrisulFuncoes.FreeAndNilDatasets(LQueryAntecipacao);
  End;
end;

procedure TConciliacaoBanrisul.pFiltraAjustesBanrisul;
Var strConfEm,
    strCodEmpresa : String;
    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Try
    FCdsRegistrosAjuste.First;
    While Not FCdsRegistrosAjuste.Eof Do
    Begin
      strCodEmpresa := '';
      strConfEm     := TBanrisulFuncoes.IIF(TBanrisulFuncoes.fEmptyStr(FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString),
                           VS_FuncoesExternas.fIRetEmpresaLogada,
                           FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';

      LRegistroRelatorio.NomeCliente := 'AJUSTES';
      LRegistroRelatorio.Parcela := '';
      LRegistroRelatorio.CodigoAutorizacao := '';
      LRegistroRelatorio.NumeroNSU := '';
      LRegistroRelatorio.NumeroCartao := '';

      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

      LRegistroRelatorio.DataPagamento := FCdsRegistrosAjuste.FieldByName('BAN_DTALAN').Value;
      LRegistroRelatorio.DataVencimento  := FCdsRegistrosAjuste.FieldByName('BAN_DTALAN').Value;
      LRegistroRelatorio.DataVenda := FCdsRegistrosAjuste.FieldByName('BAN_DTALAN').Value;

      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.CodigoAutorizacao := TBanrisulFuncoes.fStrZero('0', 6);


      LRegistroRelatorio.ValorBruto := FCdsRegistrosAjuste.FieldByName('AJUCRE').Value * -1;
      LRegistroRelatorio.ValorLiquido := FCdsRegistrosAjuste.FieldByName('AJUCRE').Value * -1;

      LRegistroRelatorio.CodigoEmpresa := strConfEm;

      If Not TBanrisulFuncoes.fEmptyStr(FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString) Then
        LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString;

      LRegistroRelatorio.CodigoEstabelecimento           := VS_FuncoesExternas.fICfgSis(StringReplace(objConcil.CfgEstabelecimentos, 'CFG_', EmptyStr, []), varString, strConfEm);
      LRegistroRelatorio.PortadorCredito                 := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, strConfEm);
      LRegistroRelatorio.PlanoContasTransferenciaCredito := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, strConfEm);
      LRegistroRelatorio.PlanoContasTaxaNegociacao       := VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, strConfEm);

      LRegistroRelatorio.Conciliado := 0;

      If (VS_FuncoesExternas.fICfgSis('BAIDEB') = 'S') Then
      Begin
        If Not TBanrisulFuncoes.fEmptyStr(FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString) then
          strCodEmpresa := FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString
        Else
        If Not TBanrisulFuncoes.fEmptyStr(strConfEm) Then
          strCodEmpresa := strConfEm
        Else
          strCodEmpresa := '';

        If TBanrisulFuncoes.fEmptyStr(strCodEmpresa) Then
          LRegistroRelatorio.SituacaoCadastro :=  'INCOMPLETO'
        Else
        Begin
          If (TBanrisulFuncoes.fEmptyStr( VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, strCodEmpresa))) Or
             (TBanrisulFuncoes.fEmptyStr( VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, strCodEmpresa))) Or
             (TBanrisulFuncoes.fEmptyStr( VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, strCodEmpresa))) Then
            LRegistroRelatorio.SituacaoCadastro :=  'INCOMPLETO'
            Else
              LRegistroRelatorio.SituacaoCadastro :=  'COMPLETO';
        End;
      End;

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
          GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      FCdsRegistrosAjuste.Next;
    End;

  Except
    Raise;
  End;
end;

function TConciliacaoBanrisul.TotalizaComoInconsistenciaQueNaoBaixa(
  AValor: String): Boolean;
begin
  Result := True;

  If AValor.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
    Result := False;
end;

procedure TConciliacaoBanrisul.ValidaCartaoEncontrado(var ABusca: Boolean;
                                                      var ADivergenciaCartao: String;
                                                      AClient: TUniClientDataSet);
Var
  LDiferenca : Double;
begin
  If Not ABusca Then
    Exit;

  // Valor Bruto
  LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('BAN_VALPAR').AsFloat;

  FTolerancia := 0.02999999;
  If Not ((TBanrisulFuncoes.fFormataFloat(LDiferenca, 2) <= FTolerancia) And (TBanrisulFuncoes.fFormataFloat(LDiferenca, 2) >= -FTolerancia)) Then
  Begin
    ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
    ABusca := False;
    Exit;
  End;
end;

end.
