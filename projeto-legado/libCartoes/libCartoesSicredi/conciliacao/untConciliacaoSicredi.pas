unit untConciliacaoSicredi;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math, System.Generics.Collections, System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar, DIALOGS,

     untSicrediConciliacaoCartoes, untLibCartoesInterfacesTipos, untTSicrediFuncoes,
     untSicrediTipos;

type

  TConciliacaoSicredi = class(TConciliacaoCartoes)
  private
    FGravouAjustes: Boolean;
    FTolerancia: Double;
    FFiltroEstabelecimento : String;

    procedure pCriaDataSets;

    function fGetTipoDeOperacao: String;
    function FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
    function TemRegistrosImportados : Boolean;
    function Reabrir(AConfirma: Boolean): Boolean;
    function ConciliouRegistros: Boolean;
    procedure ValidaCartaoEncontrado(Var ABusca : Boolean;
                                     Var ADivergenciaCartao : String;
                                     AClient: TUniClientDataSet);
    function TotalizaComoInconsistenciaQueNaoBaixa(AValor:String):Boolean;
    function RetornaSqlMovimentoFinanceiro:String;
    function RetornaSqlAjustesFinanceiro:String;
    function RetornaValorLiquidoParcela: Double;
    function RetornaDescricaoAjustes: String;

    function SituacaoConfiguracoesAjuste(ACodEmp: String) : String;

    procedure FiltraCartoesBaixados;

    procedure FiltraAjustesSicredi;

    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaSicredi(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
  end;

Const
  INICAM = 'SIC_';
  NOMTAB = 'SIC_SIPGTO';

implementation

uses untTLibCartoesMovCar;

{ TConciliacaoSicredi }

function TConciliacaoSicredi.fConciliaSicredi(pgbStatus: TcxProgressBar): Boolean;
begin
  TForm(pgbStatus.Owner).Visible := False;
  pgbStatus.Visible := False;
  Try
    Try
      Result       := False;
      FPossuiInconsistencia := False;
      FFiltrarAutorizacaoNSU := True;

      Application.ProcessMessages;

      objConcil.TabelaConciliacao           := 'SIC_SIPGTO';
      objConcil.CampoEstabelecimento        := 'SIC_CODEST';
      objConcil.NomeConciliacao             := 'SICREDI';
      objConcil.CampoValorBruto             := 'SIC_VALBRU';
      objConcil.CampoValorLiquido           := 'SIC_VALLIQ';
      objConcil.CampoCodigoAutorizacao      := 'SIC_CODAUT';
      objConcil.CampoNumeroNSU              := 'SIC_NUMNSU';
      objConcil.CampoDataTransacaoVenda     := 'SIC_DTATRA';
      objConcil.CampoDataRecebimento        := 'SIC_DTAPAG';
      objConcil.CampoNumeroParcela          := 'SIC_NUMPAR';
      objConcil.CampoTotalParcelas          := 'SIC_TOTPAR';
      objConcil.CampoNumeroCartao           := '';
      objConcil.CampoTipoRegistro           := '';
      objConcil.CampoTipoTransacao          := '';
      objConcil.CfgEstabelecimentos         := 'CFG_SICEST';
      objConcil.CfgPortadorAjustes          := 'SICPOR';   //strConfPr
      objConcil.CfgPlanoDeContasAjustes     := 'SICCTA';   //strConfCt
      objConcil.CfgFornecedorAjustes        := 'SICFOR';   //strConfFo
      objConcil.strEventoCancelamentoAjuste := 'SICEVE';
      objConcil.CfgVlrTolerancia            := 'SICTOL';

      objConcil.strChavePrimaria            := 'SIC_TIPREG,SIC_DTAPAG,SIC_NUMPAR,SIC_CODAUT,SIC_NUMNSU';

      If Not fDigPeriodo Then
        Exit;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'SICREDI',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TSicrediFuncoes.RetornaDataHoraServidor,
                                                            TSicrediFuncoes.RetornaHoraServidor);

      TForm(pgbStatus.Owner).Visible := True;
      TSicrediFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros para conciliação.', False);
      pCriaDataSets;

      pCalculaPeriodoFiltro('SIC_DTATRA');

      TSicrediFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões.', False);
      pFiltraCartoes;

      FiltraAjustesSicredi;

      TSicrediFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões baixados.', False);
      FiltraCartoesBaixados;

      If Not cdsConcar.IsEmpty Then
      Begin
        pgbStatus.Visible := True;
        TSicrediFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de débito\crédito (' + objConcil.NomeConciliacao + ').', False);
        fProcessaRegistrosDebitoCredito(pgbStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TSicrediFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(pgbStatus);

      if FPossuiInconsistencia then
       TSicrediFuncoes.fMensagem('', 'Foram encontradas inconsistências na importação dos arquivos!', ['&OK']);

      Result := FinalizandoConciliacao(pgbStatus);

      blnReabre := not Result;
      if Result then
      begin
        cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        cdsBaiCar.Filtered := True;
      end;

    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaSicredi]');
      End;
    End;
  Finally
    TSicrediFuncoes.FreeAndNilDatasets(cdsConcar);
    TSicrediFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
end;

function TConciliacaoSicredi.ConciliouRegistros: Boolean;
  Var
    LFilterAnt: String;
begin
  LFilterAnt := cdsBaiCar.Filter;

  Try
    cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
    cdsBaiCar.Filtered := True;

    Result := (Not cdsBaiCar.IsEmpty or ((Assigned(cdsAjustes)) And (Not cdsAjustes.IsEmpty)));
  Finally
    cdsBaiCar.Filter := LFilterAnt;
    cdsBaiCar.Filtered := True;
  End;
end;

function TConciliacaoSicredi.fConciliaCartoes: Boolean;
begin
  Result := TSicrediFuncoes.ExecutaAguarde(fConciliaSicredi, 'Aguarde... Iniciando a conciliação.');
end;

function TConciliacaoSicredi.fGetTipoDeOperacao: String;
  Var
    LModalidade: String;
begin
  Result := '';

   If (cdsConcar.FieldByName('SIC_TAXANT').AsFloat > 0) Then
     Exit('ANTECIPAÇÃO');

  LModalidade := AnsiUpperCase(cdsConcar.FieldByName('SIC_TIPCON').AsString);

  If Pos('DÉBITO',LModalidade) > 0 Then
    Result := 'DÉBITO'

  Else If Pos('CRÉDITO',LModalidade) > 0 Then
  Begin
    Result := TSicrediFuncoes.IIF(cdsConcar.FieldByName('SIC_TOTPAR').AsInteger > 1, 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO');
  End;

  If Not Result.isEmpty Then
    Exit;

  LModalidade := cdsConcar.FieldByName('SIC_DESTRA').AsString.ToUpperInvariant;
  Result := 'DÉBITO';
  If LModalidade.Contains('PARCELADO') Then
    Exit('CRÉDITO PARCELADO')
  Else If LModalidade.Contains('CRÉDITO') Then
    Exit('CRÉDITO ROTATIVO');
end;

procedure TConciliacaoSicredi.FiltraAjustesSicredi; //seguindo rede api
Var
  strConfEm,
  strCodEmpresa : String;

  LInconsistencia: TItensRelatorioCartoes;
begin
  Try
    cdsAjustes.First;
    While Not cdsAjustes.Eof Do
    Begin
      strCodEmpresa := '';
      strConfEm     :=TSicrediFuncoes.IIF(TSicrediFuncoes.fEmptyStr(cdsAjustes.FieldByName('EMP_CODEMP').AsString),
                           VS_FuncoesExternas.fIRetEmpresaLogada,
                           cdsAjustes.FieldByName('EMP_CODEMP').AsString);

      LInconsistencia := TItensRelatorioCartoes.Create;

      LInconsistencia.Descricao := 'Cancelamentos/Ajustes';
      LInconsistencia.NomeCliente := RetornaDescricaoAjustes;
      LInconsistencia.DescricaoAjuste :=   RetornaDescricaoAjustes;

      LInconsistencia.Parcela := TSicrediFuncoes.fStrZero(RightStr(cdsAjustes.FieldByName('SIC_NUMPAR').AsString , 2), 2);
      LInconsistencia.TotalParcelas := TSicrediFuncoes.fStrZero(RightStr(cdsAjustes.FieldByName('SIC_TOTPAR').AsString , 2), 2);
      If LInconsistencia.TotalParcelas.Equals('00') Then
        LInconsistencia.TotalParcelas := LInconsistencia.Parcela;

      LInconsistencia.CodigoAutorizacao := TSicrediFuncoes.fStrZero(Trim(RightStr(cdsAjustes.FieldByName('SIC_CODAUT').AsString, 06)), 06);
      LInconsistencia.NumeroNSU := TSicrediFuncoes.fStrZero(Trim(RightStr(cdsAjustes.FieldByName('SIC_NUMNSU').AsString, 14)), 14);
      LInconsistencia.NumeroCartao := cdsAjustes.FieldByName('SIC_NUMCAR').AsString;
      LInconsistencia.DataVenda := cdsAjustes.FieldByName('SIC_DTATRA').AsDateTime;

      LInconsistencia.TipoDoRegistro := 'AJUSTES';
      LInconsistencia.TipoCartao := 'CANCELAMENTOS/AJUSTES';


      LInconsistencia.DataPagamento := cdsAjustes.FieldByName('SIC_DTAPAG').Value;
      LInconsistencia.DataVencimento := cdsAjustes.FieldByName('SIC_DTAPAG').Value;


      LInconsistencia.ValorBruto := cdsAjustes.FieldByName('SIC_VALBRU').Value;
      LInconsistencia.ValorLiquido :=cdsAjustes.FieldByName('SIC_VALLIQ').Value;

      LInconsistencia.DataVencimento := cdsAjustes.FieldByName('SIC_DTAPAG').Value;
      LInconsistencia.CodigoEmpresa         := VS_FuncoesExternas.fIRetEmpresaLogada;
      LInconsistencia.CodigoEstabelecimento  := cdsConcar.FieldByName('SIC_CODEST').AsString;
      LInconsistencia.PortadorCredito                 := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, strConfEm);
      LInconsistencia.PlanoContasTransferenciaCredito := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, strConfEm);
      LInconsistencia.PlanoContasTaxaNegociacao       := VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, strConfEm);

      LInconsistencia.Conciliado := cdsAjustes.FieldByName('SIC_CONCIL').AsInteger;

      If (VS_FuncoesExternas.fICfgSis('BAIDEB') = 'S') Then
      Begin
        strCodEmpresa := '';

        If Not TSicrediFuncoes.fEmptyStr(cdsAjustes.FieldByName('EMP_CODEMP').AsString) then
          strCodEmpresa := cdsAjustes.FieldByName('EMP_CODEMP').AsString
        Else
        If Not TSicrediFuncoes.fEmptyStr(strConfEm) Then
          strCodEmpresa := strConfEm;

        LInconsistencia.SituacaoCadastro :=  SituacaoConfiguracoesAjuste(strCodEmpresa);
      End;

      If FBaixarAjustes Then
      Begin
        LInconsistencia.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(VS_FuncoesExternas.fIRetEmpresaLogada);

        GravarRegistroDeAjusteParaConciliacao(LInconsistencia);
      End;

      FListaRegistrosRelatorio.Add(LInconsistencia);

      cdsAjustes.Next;

      FGravouAjustes := True;
    End;

  Except
    Raise;
  End;
end;

procedure TConciliacaoSicredi.FiltraCartoesBaixados;
begin
  pFiltraCartoesBaixados(False);
end;

function TConciliacaoSicredi.FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  Try
    If TemRegistrosImportados Then
    Begin
      Result := GeraRelatorioConciliacao('SICREDI', pgbStatus);
    End;

    If Assigned(cdsAjustes) Then
    Begin
      cdsAjustes.Filter   := 'SIC_CONCIL = 0';
      cdsAjustes.Filtered := True;
    End;

    blnReabre := Reabrir(Result);

    If Result Then
    Begin

      Result := ConciliouRegistros;

      If Not Result Then
        TSicrediFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
      Else
        TSicrediFuncoes.fMensagem('AVISO','Conciliação da ' + objConcil.NomeConciliacao + ' realizada com sucesso.',['&OK']);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.FinalizandoConciliacao]');
    End;
  End;
end;

function TConciliacaoSicredi.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
Var strParcel                : String;
    strNumNsu                : String;
    strCodEmp                : String;
    dtaDtaCad                : TDateTime;
    strNumAut                : String;
    blnBusca                 : Boolean;
    LRegistroRelatorio       : TItensRelatorioCartoes;
    STipoOperacao            : String;
    LDivergenciaCartao       : String;
    LNumCCD                  : String;
    LTaxaAntecipacao         : Double;
    LValorLiquido : Double;
    LChaveConciliacao : String;

    LParcelaInteger: Integer;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConcar.RecordCount;

    cdsConcar.First;
    While Not cdsConcar.Eof Do
    Begin
      TSicrediFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';
      LDivergenciaCartao := '';

      LTaxaAntecipacao := cdsConcar.FieldByName('SIC_TAXANT').AsFloat;

      STipoOperacao := fGetTipoDeOperacao;

      If Not TryStrToInt(RightStr(cdsConcar.FieldByName('SIC_NUMPAR').AsString , 2), LParcelaInteger) Then
      Begin
        cdsConcar.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      strParcel := TSicrediFuncoes.fGetLetraAlfa(LParcelaInteger);
      FTextoInconsistencia := '';
      strNumNsu := TSicrediFuncoes.fStrZero(Trim(RightStr(cdsConcar.FieldByName('SIC_NUMNSU').AsString, 14)), 14);
      strNumAut := cdsConcar.FieldByName('SIC_CODAUT').AsString;
      dtaDtaCad := cdsConcar.FieldByName('SIC_DTATRA').Value;
      strCodEmp := cdsConcar.FieldByName('EMP_CODEMP').AsString;

      LNumCCD := TSicrediFuncoes.IIF((strNumAut = '0'),'',TSicrediFuncoes.fStrZero(strNumAut, 6));
      blnBusca := fBuscaCartao(LNumCCD,
                               strNumNsu,
                               strCodEmp,
                               strParcel,
                               dtaDtaCad);

      LDivergenciaCartao := '';
      ValidaCartaoEncontrado(blnBusca,LDivergenciaCartao,cdsConcar);

      LValorLiquido := TSicrediFuncoes.fFormataFloat(RetornaValorLiquidoParcela - LTaxaAntecipacao, 2);

      If (blnBusca) Then
      Begin
        dtaDtaPag := cdsConcar.FieldByName('SIC_DTAPAG').Value;

        LChaveConciliacao := 'SIC_' +
                      cdsConcar.FieldByName('SIC_CODEST').AsString + '_' +
                      cdsConcar.FieldByName('SIC_CODAUT').Value + '_' +
                      strParcel + '_' +
                      cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                      FormatDateTime('yyyy-mm-dd', cdsConcar.FieldByName('SIC_DTAPAG').Value);


        MarcarCartaoEncontradoArquivo(LValorLiquido,
                                     (LTaxaAntecipacao > 0),
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar);
      End
      Else
      Begin
        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixado(LNumCCD,
                                        strNumNsu,
                                        strCodEmp,
                                        strParcel,
                                        dtaDtaCad,
                                        True,
                                        cdsConcar.FieldByName('SIC_VALBRU').AsFloat);

        FTextoInconsistencia := TSicrediFuncoes.IIF(blnBusca,'Cartão já foi baixado',
                                  'Registro do arquivo não encontrado nos lançamentos do sistema');
      End;

      FTextoInconsistencia := TSicrediFuncoes.IIF(TSicrediFuncoes.fEmptyStr(LDivergenciaCartao),FTextoInconsistencia,LDivergenciaCartao);
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      if not FTextoInconsistencia.IsEmpty then
      begin
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';   // <- SEMPRE MARCA
        LRegistroRelatorio.Descricao      := FTextoInconsistencia;

        if TotalizaComoInconsistenciaQueNaoBaixa(FTextoInconsistencia) then
          LRegistroRelatorio.SomarNoTotal := 'S';
      end;

      if cdsConcar.FindField('SIC_NOMARQ') <> nil then
        LRegistroRelatorio.NomeArquivo := cdsConcar.FieldByName('SIC_NOMARQ').AsString;

      LRegistroRelatorio.Descricao := FTextoInconsistencia;
      LRegistroRelatorio.ValorBruto := cdsConcar.FieldByName('SIC_VALBRU').AsFloat;
      LRegistroRelatorio.NumeroNSU := TSicrediFuncoes.fStrZero(Trim(RightStr(strNumNsu, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := TSicrediFuncoes.fStrZero(Trim(RightStr(cdsConcar.FieldByName('SIC_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoEmpresa         := cdsConcar.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.CodigoEstabelecimento  := cdsConcar.FieldByName('SIC_CODEST').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConcar.FieldByName('SIC_NUM_RV').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConcar.FieldByName('SIC_NUMCAR').AsString;
      LRegistroRelatorio.TipoCartao  := STipoOperacao;
      LRegistroRelatorio.DataVenda := cdsConcar.FieldByName('SIC_DTATRA').AsDateTime;
      LRegistroRelatorio.DataVencimento  := cdsConcar.FieldByName('SIC_DTAPAG').AsDateTime;
      LRegistroRelatorio.Parcela :=TSicrediFuncoes.fStrZero(RightStr(cdsConcar.FieldByName('SIC_NUMPAR').AsString , 2), 2);

      LRegistroRelatorio.TotalParcelas := TSicrediFuncoes.fStrZero(RightStr(cdsConcar.FieldByName('SIC_TOTPAR').AsString , 2), 2);
      If LRegistroRelatorio.TotalParcelas.Equals('00') THen
        LRegistroRelatorio.TotalParcelas := LRegistroRelatorio.Parcela;

      LRegistroRelatorio.CodigoAutorizacao  := LNumCCD;
      LRegistroRelatorio.ValorLiquido :=LValorLiquido;
      LRegistroRelatorio.DescricaoBandeira := AnsiUpperCase(cdsConcar.FieldByName('SIC_NOMBAN').AsString);

      If TSicrediFuncoes.fEmptyStr(LRegistroRelatorio.DescricaoBandeira) Then
        LRegistroRelatorio.DescricaoBandeira := 'OUTROS';

      If LRegistroRelatorio.SomarNoTotal = 'S' Then
      Begin
        LRegistroRelatorio.CodigoBandeira := cdsBaicar.FieldByName('CAR_CODBAN').AsString;
        LRegistroRelatorio.PercentualTaxa := cdsBaicar.FieldByName('CAR_PERDES').AsFloat;

        If String(VS_FuncoesExternas.fICfgSis('VLDTAX',varString)).Equals('2') Then
          LRegistroRelatorio.PercentualTaxa := TSicrediFuncoes.fFormataFloat(cdsBaicar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat, 2);
      End;

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

procedure TConciliacaoSicredi.pCriaDataSets;
  Var
    LQueryMovimento,
    LQueryAjustes : TUniQuery;
begin
  LQueryMovimento := Nil;
  LQueryAjustes := Nil;
  Try
    LQueryMovimento := VS_FuncoesExternas.fICriaQuery;
    LQueryAjustes := VS_FuncoesExternas.fICriaQuery;

    FFiltroEstabelecimento := fRetPesqPonVen(0);

    //DEBITOS E CREDITOS
    LQueryMovimento.SQL.Text := RetornaSqlMovimentoFinanceiro;
    LQueryMovimento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryMovimento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryMovimento.Open;
    cdsConcar := TSicrediFuncoes.CriarClientDataSet(LQueryMovimento);
    Application.ProcessMessages;

    //AJUSTES
    LQueryAjustes.SQL.Text := RetornaSqlAjustesFinanceiro;
    LQueryAjustes.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryAjustes.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryAjustes.Open;
    cdsAjustes := TSicrediFuncoes.CriarClientDataSet(LQueryAjustes);
    Application.ProcessMessages;

    If (cdsConCar.IsEmpty) And
    ((Not Assigned(cdsAjustes)) Or (cdsAjustes.IsEmpty)) Then
    Begin
      TSicrediFuncoes.fMensagem('','Não existem arquivos importados nesse período de recebimento!',['&OK']);
      LQueryMovimento.Close;
      blnReabre := True;
      Exit;
    End;
  Finally
    TSicrediFuncoes.FreeAndNilDatasets(LQueryMovimento);
    TSicrediFuncoes.FreeAndNilDatasets(LQueryAjustes);
  End;
end;

function TConciliacaoSicredi.Reabrir(AConfirma: Boolean): Boolean;
begin
  Result := False;

  If (Not AConfirma) Then
    Exit(True)
  Else If cdsAjustes.IsEmpty Then
      Exit(True);
end;

function TConciliacaoSicredi.RetornaDescricaoAjustes: String;
begin
 Result := cdsAjustes.FieldByName('SIC_DESTRA').AsString.ToUpperInvariant;
 If Result.IsEmpty Then
   Result := cdsAjustes.FieldByName('SIC_TIPPAG').AsString.ToUpperInvariant
end;

function TConciliacaoSicredi.RetornaSqlAjustesFinanceiro: String;
begin
  Result := 'SELECT                                    '+
            '  *                                       '+
            'FROM                                      '+
            '  SIC_SIPGTO                              '+
            '  LEFT JOIN CFGSIS                        '+
            '    ON LOCATE(SIC_CODEST, SIS_VALCFG) > 0 '+
            '    AND SIS_CODCFG IN ("CFG_SICEST")      '+
            '  LEFT JOIN CADEMP                        '+
            '    ON SIS_CODEMP = EMP_CODEMP            '+
            'WHERE SIC_DTAPAG BETWEEN :DTAINI          '+
            '  AND :DTAFIM                             '+
            '  AND (                                                  '+
            '    SIC_TIPREG IN ("021")                                '+
            '    OR (                                                 '+
            '      SIC_TIPREG = "ARP"                                 '+
            '      AND SIC_VALBRU < 0                                 '+
            '      AND SIC_TIPPAG NOT IN ("Antecipação Manual")       '+
            '    )                                                    '+
            '    OR (                                                 '+
            '      SIC_TIPREG = "ARP"                                 '+
            '      AND SIC_VALBRU > 0                                 '+
            '      AND SIC_TIPPAG IN ("Antecipação Manual")           '+
            '      AND SIC_DESTRA IS NULL                             '+
            '      AND SIC_NUMCAR = ""                                '+
            '    )                                                    '+
            '  )                                                      ';


  If Not TSicrediFuncoes.fEmptyStr(FFiltroEstabelecimento) then
    Result := Result + StringReplace(FFiltroEstabelecimento,objConcil.CampoEstabelecimento,objConcil.CampoEstabelecimento,[rfReplaceAll]);
end;

function TConciliacaoSicredi.RetornaSqlMovimentoFinanceiro: String;
begin

  Result := 'SELECT                                    '+
            '  *                                       '+
            'FROM                                      '+
            '  SIC_SIPGTO                              '+
            '  LEFT JOIN CFGSIS                        '+
            '    ON LOCATE(SIC_CODEST, SIS_VALCFG) > 0 '+
            '    AND SIS_CODCFG IN ("CFG_SICEST")      '+
            '  LEFT JOIN CADEMP                        '+
            '    ON SIS_CODEMP = EMP_CODEMP            '+
            'WHERE SIC_DTAPAG BETWEEN :DTAINI          '+
            '  AND :DTAFIM                             '+
            '  AND SIC_TIPREG NOT IN("021")            '+
            '  AND (                                              '+
            '    SIC_VALBRU > 0                                   '+
            '    AND SIC_TIPPAG NOT IN ("Antecipação Manual")     '+
            '    OR (                                             '+
            '      SIC_VALBRU > 0                                 '+
            '      AND SIC_TIPPAG IN ("Antecipação Manual")       '+
            '      AND SIC_DESTRA IS NOT NULL                     '+
            '      AND SIC_NUMCAR <> ""                           '+
            '    )                                                '+
            '  )                                                  ';


  If Not TSicrediFuncoes.fEmptyStr(FFiltroEstabelecimento) then
    Result := Result + StringReplace(FFiltroEstabelecimento,objConcil.CampoEstabelecimento,objConcil.CampoEstabelecimento,[rfReplaceAll]);

end;

function TConciliacaoSicredi.TemRegistrosImportados: Boolean;
begin
  Result := False;
  If (Not cdsConcar.IsEmpty) Then
    Exit(True)
  Else If (Not cdsAjustes.IsEmpty) Then
    Exit(True);
end;

function TConciliacaoSicredi.TotalizaComoInconsistenciaQueNaoBaixa(AValor: String): Boolean;
begin
  Result := True;

  If AValor.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
    Result := False;
end;

procedure TConciliacaoSicredi.ValidaCartaoEncontrado(Var ABusca : Boolean;
                                                         Var ADivergenciaCartao : String;
                                                         AClient: TUniClientDataSet);
  Var
    LDiferenca : Double;
begin
  If Not ABusca Then
    Exit;

  // Valor Bruto
  LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('SIC_VALBRU').AsFloat;

  FTolerancia := RetornaValorTolerancia(AClient.FieldByName('EMP_CODEMP').AsString);
  If Not ((TSicrediFuncoes.fFormataFloat(LDiferenca, 2) <= FTolerancia) And (TSicrediFuncoes.fFormataFloat(LDiferenca, 2) >= -FTolerancia)) Then
  Begin
    ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
    ABusca := False;
    Exit;
  End;
end;

function TConciliacaoSicredi.RetornaValorLiquidoParcela: Double;
begin
  Result := cdsConcar.FieldByName('SIC_VALLIQ').AsFloat;
end;

function TConciliacaoSicredi.SituacaoConfiguracoesAjuste(
  ACodEmp: String): String;
begin
  Result := 'COMPLETO';

  If TSicrediFuncoes.fEmptyStr(ACodEmp) Then
    Exit('INCOMPLETO')
  Else If (TSicrediFuncoes.fEmptyStr(VS_FuncoesExternas.fiCfgSis(objConcil.CfgPortadorAjustes, varString, ACodEmp))) Then
    Exit('INCOMPLETO')
  Else If (TSicrediFuncoes.fEmptyStr(VS_FuncoesExternas.fiCfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodEmp))) Then
    Exit('INCOMPLETO')
  Else If (TSicrediFuncoes.fEmptyStr(VS_FuncoesExternas.fiCfgSis(objConcil.CfgFornecedorAjustes, varString, ACodEmp))) Then
    Exit('INCOMPLETO');
end;

end.
