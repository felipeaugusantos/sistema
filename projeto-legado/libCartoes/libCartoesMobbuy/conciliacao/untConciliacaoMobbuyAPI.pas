unit untConciliacaoMobbuyAPI;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math,  dialogs,

     Uni, UniClientDataSet, cxProgressBar, frxClass, frxDBSet,

     untMobbuyConciliacaoCartoes, untLibCartoesInterfacesTipos,
     untTMobbuyFuncoes, untTLibCartoesMovCar;

type

  TConciliacaoMobbuyAPI = class(TConciliacaoCartoes)
  private
    FCdsRegistrosMovimento : TUniClientDataSet; //Registros Movimentação cartão
    FCdsRegistrosPagamento : TUniClientDataSet; //Registros Conciliação Financeira
    FTolerancia: Double;
    FFiltroEstabelecimento : String;

    procedure pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
    procedure pCriaDataSets;
    procedure pFiltraAjustesMobbuyAPI;

    function fGetTipoDeOperacao(ACodigoModalidade : String; ATotalParcelas : Integer; ANFCessao: String) : String;
    function FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
    function TemRegistrosImportados : Boolean;
    function Reabrir(AConfirma: Boolean): Boolean;
    function ConciliouRegistros: Boolean;
    procedure ValidaCartaoEncontrado(Var ABusca : Boolean;
                                     Var ADivergenciaCartao : String;
                                     AClient: TUniClientDataSet);
    procedure ValidaCartaoMarcado(Var ADivergenciaCartao : String);
    function RetornaSqlVendas:String;
    function RetornaFiltroSqlVendas(APrefixo: String = ''):String;
    function RetornaTipoRegistro:String;
    function RetornaValorLiquidoParcela: Double;
    function LocalizaCartaoPorNsuOuAutorizacao(ADataset: TDataSet; const ACampoParcela, AAutorizacao,
                                               ANsu, ACodigoEmpresa, AParcela: String;
                                               ADataVenda: TDateTime; AApenasEmAberto: Boolean): Boolean;
    
    procedure AjustaTipoRegistroParaCartoesZerados(var ARegistroRelatorio: TItensRelatorioCartoes);

    procedure FiltraCartoesBaixados;

    function fConciliaMobbuyAPI(pgbStatus: TcxProgressBar): Boolean;
    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
  end;

implementation

Uses untLibCartoesGravando, untLibCartoesFiltroInconsistencias,
     untTImportaVendasMobbuyOnline;

{ TConciliacaoMobbuyAPI }

procedure TConciliacaoMobbuyAPI.AjustaTipoRegistroParaCartoesZerados(
  var ARegistroRelatorio: TItensRelatorioCartoes);
begin
  If TMobbuyFuncoes.fFormataFloat(ARegistroRelatorio.ValorLiquido, 2) <> 0 Then
    Exit;

  If Not ARegistroRelatorio.TipoDoRegistro.Equals('INCONSISTENCIA') Then
    Exit;

  ARegistroRelatorio.TipoDoRegistro := 'AJUSTES';
  ARegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
  ARegistroRelatorio.DescricaoAjuste := 'Cartão com valor zerado';
  ARegistroRelatorio.SomarNoTotal := 'N';
end;

function TConciliacaoMobbuyAPI.ConciliouRegistros: Boolean;
  Var
    LFilterAnt: String;
begin
  LFilterAnt := cdsBaiCar.Filter;

  Try
    cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
    cdsBaiCar.Filtered := True;

    Result := Not cdsBaiCar.IsEmpty;
  Finally
    cdsBaiCar.Filter := LFilterAnt;
    cdsBaiCar.Filtered := True;
  End;
end;

function TConciliacaoMobbuyAPI.fConciliaCartoes: Boolean;
begin
  Result := TMobbuyFuncoes.ExecutaAguarde(fConciliaMobbuyAPI, 'Aguarde... Iniciando a conciliação.');
end;

function TConciliacaoMobbuyAPI.fGetTipoDeOperacao(ACodigoModalidade : String; ATotalParcelas : Integer;
  ANFCessao: String): String;
begin
  Result := 'DÉBITO';

  If (ACodigoModalidade = 'PIX') Then
    Exit('PIX')
  Else If (ACodigoModalidade = 'CRE')Then
  Begin
    If ANFCessao.IsEmpty Then
      Exit(TMobbuyFuncoes.IIF(ATotalParcelas > 1, 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO'))
    Else
      Exit('ANTECIPAÇÃO');
  End
  Else If (ACodigoModalidade = 'ANT')  Then
    Exit('ANTECIPAÇÃO');
end;

procedure TConciliacaoMobbuyAPI.FiltraCartoesBaixados;
begin
  pFiltraCartoesBaixados(False);
end;

function TConciliacaoMobbuyAPI.FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  Try
    If TemRegistrosImportados Then
      Result := GeraRelatorioConciliacao(objConcil.NomeConciliacao, pgbStatus);

    If Assigned(cdsAjustes) Then
    Begin
      cdsAjustes.Filter   := 'MOB_CONCIL = 0';
      cdsAjustes.Filtered := True;
    End;

    blnReabre := Reabrir(Result);

    If Result Then
    Begin

      Result := ConciliouRegistros;

      If Not Result Then
        TMobbuyFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
      Else
        TMobbuyFuncoes.fMensagem('AVISO','Conciliação da ' + objConcil.NomeConciliacao + ' realizada com sucesso.',['&OK']);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.FinalizandoConciliacao]');
    End;
  End;
end;


function TConciliacaoMobbuyAPI.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
  Var
    LParcela,
    LNumeroNSU,
    LCodigoEmpresa,
    LAutorizacao: String;

    LDataVenda                : TDateTime;

    blnBusca                 : Boolean;

    LTipoOperacao            : String;
    LDivergenciaCartao       : String;

    LTaxaAntecipacao,
    LLiquidoConciliado: Double;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LNomeArquivo,
    LChaveConciliacao: String;

    LDataVencimento: TDateTime;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosPagamento.RecordCount;

    FCdsRegistrosPagamento.First;
    While Not FCdsRegistrosPagamento.Eof Do
    Begin
      TMobbuyFuncoes.pStepStatusGravacao(pgbStatus);

      FTextoInconsistencia := '';
      LDivergenciaCartao := '';

      FCdsRegistrosMovimento.Filter := 'MOB_NUM_PV = ' + QuotedStr(FCdsRegistrosPagamento.FieldByName('MOB_NUM_PV').AsString)+' AND '+
                                       'MOB_NUMNSU = ' + QuotedStr(FCdsRegistrosPagamento.FieldByName('MOB_NUMNSU').AsString)+' AND '+
                                       'MOB_CODAUT LIKE ' + QuotedStr('%' + FCdsRegistrosPagamento.FieldByName('MOB_CODAUT').AsString)+' AND '+
                                       'MOB_DTVEND = ' + QuotedStr(FCdsRegistrosPagamento.FieldByName('MOB_DTVEND').AsString)+' AND '+
                                       'MOB_NUMPAR = ' + QuotedStr(FCdsRegistrosPagamento.FieldByName('MOB_PARCEL').AsString);
      FCdsRegistrosMovimento.Filtered := True;

      LNomeArquivo := '[Sempre Pronto API] - Data de Importação: ' +
                      FormatDateTime('dd/mm/yyyy',FCdsRegistrosPagamento.FieldByName('MOB_DTAIMP').AsDateTime);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LTipoOperacao := fGetTipoDeOperacao(RetornaTipoRegistro,
                                          FCdsRegistrosPagamento.FieldByName('TOTAL_PARCELAS').AsInteger,
                                          FCdsRegistrosPagamento.FieldByName('MOB_CES_NF').AsString);

      LTaxaAntecipacao := 0;
      If LTipoOperacao.Equals('ANTECIPAÇÃO') Then
      Begin
        If Not FCdsRegistrosMovimento.IsEmpty Then
          LTaxaAntecipacao := TMobbuyFuncoes.fFormataFloat((FCdsRegistrosPagamento.FieldByName('MOB_VALBRU').AsFloat - RetornaValorLiquidoParcela) -
                                                            FCdsRegistrosPagamento.FieldByName('MOB_VALDES').AsFloat,2);
      End;

      LLiquidoConciliado := FCdsRegistrosPagamento.FieldByName('MOB_VALLIQ').AsFloat;

      LParcela := TMobbuyFuncoes.fGetLetraAlfa(StrtoInt(LeftStr(FCdsRegistrosPagamento.FieldByName('PARCELA').AsString , 2)));
      FTextoInconsistencia := '';
      LAutorizacao := TMobbuyFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosPagamento.FieldByName('MOB_CODAUT').AsString, 6)), 6);
      LNumeroNSU := TMobbuyFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosPagamento.FieldByName('MOB_NUMNSU').AsString, 14)), 14);
      LDataVenda := FCdsRegistrosPagamento.FieldByName('MOB_DTVEND').Value;
      LCodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;

      LAutorizacao := TMobbuyFuncoes.IIF((LAutorizacao = '0'),'',TmobbuyFuncoes.fStrZero(LAutorizacao, 6));
      If LAutorizacao = '000000' Then
        LAutorizacao := '';

      LDataVencimento := FCdsRegistrosMovimento.FieldByName('MOB_DTAVCT').AsDateTime;
      If LTipoOperacao.Equals('PIX') Then
      Begin
        LNumeroNSU := FCdsRegistrosPagamento.FieldByName('MOB_CHAVES').AsString;
        LAutorizacao := FCdsRegistrosPagamento.FieldByName('MOB_CHAVES').AsString;
        LDataVencimento := FCdsRegistrosPagamento.FieldByName('MOB_DTAPAG').AsDateTime;
      End;

      blnBusca := fBuscaCartao(LAutorizacao,
                               LNumeroNSU,
                               LCodigoEmpresa,
                               LParcela,
                               LDataVenda);

      If (Not blnBusca) And (Not LTipoOperacao.Equals('PIX')) Then
        blnBusca := LocalizaCartaoPorNsuOuAutorizacao(cdsBaiCar, 'PARDUP',
                                                      FCdsRegistrosPagamento.FieldByName('MOB_CODAUT').AsString,
                                                      FCdsRegistrosPagamento.FieldByName('MOB_NUMNSU').AsString,
                                                      LCodigoEmpresa, LParcela, LDataVenda, True);

      LDivergenciaCartao := '';

      ValidaCartaoEncontrado(blnBusca,LDivergenciaCartao,FCdsRegistrosPagamento);

      If (blnBusca) Then
      Begin
        LChaveConciliacao := 'MOB_' + FCdsRegistrosPagamento.FieldByName('MOB_NUM_PV').AsString + '_' +
                             FCdsRegistrosPagamento.FieldByName('MOB_NUMNSU').Value + '_' +
                             LParcela + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', FCdsRegistrosPagamento.FieldByName('MOB_DTAPAG').Value);

        MarcarCartaoEncontradoAPI(LLiquidoConciliado,
                                  LTipoOperacao.Equals('ANTECIPAÇÃO'),
                                  LRegistroRelatorio,
                                  LChaveConciliacao,
                                  FCdsRegistrosPagamento.FieldByName('MOB_DTAPAG').AsDateTime,
                                  FCdsRegistrosPagamento,
                                  Abs(LTaxaAntecipacao));

        If Not FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString.IsEmpty Then
        Begin
          cdsBaiCar.Edit;
          cdsBaiCar.FieldByName('PORTADOR_GRAVAME').AsString := FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString;
          cdsBaiCar.FieldByName('CAR_PORBAI').AsString       := FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString;
          cdsBaiCar.FieldByName('CAR_PORTAX').AsString       := FCdsRegistrosPagamento.FieldByName('PORTADOR_GRAVAME').AsString;
          cdsBaiCar.Post;
        End;

        ValidaCartaoMarcado(LDivergenciaCartao);
      End
      Else
      Begin
        blnBusca := fBuscaCartaoBaixado(LAutorizacao,
                                        LNumeroNSU,
                                        LCodigoEmpresa,
                                        LParcela,
                                        LDataVenda,
                                        True,
                                        FCdsRegistrosPagamento.FieldByName('MOB_VALBRU').AsFloat);

        If (Not blnBusca) And (Not LTipoOperacao.Equals('PIX')) Then
          blnBusca := LocalizaCartaoPorNsuOuAutorizacao(cdsBaixad, 'MCA_PARCEL',
                                                        FCdsRegistrosPagamento.FieldByName('MOB_CODAUT').AsString,
                                                        FCdsRegistrosPagamento.FieldByName('MOB_NUMNSU').AsString,
                                                        LCodigoEmpresa, LParcela, LDataVenda, False) And
                      TMobbuyFuncoes.fBetween(cdsBaixad.FieldByName('MCA_VALSTA').AsFloat -
                                              FCdsRegistrosPagamento.FieldByName('MOB_VALBRU').AsFloat,
                                              -RetornaValorTolerancia(LCodigoEmpresa),
                                              RetornaValorTolerancia(LCodigoEmpresa));

        FTextoInconsistencia := TMobbuyFuncoes.IIF(blnBusca,
                                                     'Cartão já foi baixado',
                                                     'Registro do arquivo não encontrado nos lançamentos do sistema');
      End;

      FTextoInconsistencia := TMobbuyFuncoes.IIF(TMobbuyFuncoes.fEmptyStr(LDivergenciaCartao),FTextoInconsistencia,LDivergenciaCartao);

      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        LRegistroRelatorio.SomarNoTotal := 'N';
        If Not FTextoInconsistencia.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
        Begin
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
          LRegistroRelatorio.SomarNoTotal := 'S';
        End;
      End;
      LRegistroRelatorio.NomeArquivo := LNomeArquivo;
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('MOB_NUM_PV').AsString;
      LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
      LRegistroRelatorio.NumeroNSU := LNumeroNSU;
      LRegistroRelatorio.CodigoAutorizacao := LAutorizacao;
      LRegistroRelatorio.ResumoVenda := FCdsRegistrosMovimento.FieldByName('MOB_MOV_ID').AsString;
      LRegistroRelatorio.NumeroCartao := '***';

      LRegistroRelatorio.TipoCartao := LTipoOperacao;

      LRegistroRelatorio.Parcela := TMobbuyFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PARCELA').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TMobbuyFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('TOTAL_PARCELAS').AsString, 2);
      LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('MOB_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVenda := LDataVenda;
      LRegistroRelatorio.DataVencimento := LDataVencimento;

      LRegistroRelatorio.ValorBruto := FCdsRegistrosPagamento.FieldByName('MOB_VALBRU').AsFloat;
      LRegistroRelatorio.ValorLiquido := LLiquidoConciliado;

      AjustaTipoRegistroParaCartoesZerados(LRegistroRelatorio);

      LRegistroRelatorio.DescricaoBandeira := FCdsRegistrosPagamento.FieldByName('MOB_DESBAN').AsString;
      If LRegistroRelatorio.DescricaoBandeira.ToUpperInvariant.Equals('TODOS') THen
        LRegistroRelatorio.DescricaoBandeira := 'Pix';

      LRegistroRelatorio.CodigoBandeira := cdsBaicar.FieldByName('CAR_CODBAN').AsString;
      LRegistroRelatorio.PercentualTaxa := TMobbuyFuncoes.fFormataFloat(cdsBaicar.FieldByName('CAR_PERDES').AsFloat, 2);
      If FConfiguracaoTaxaAdministrativa.Equals('2') Then
        LRegistroRelatorio.PercentualTaxa := TMobbuyFuncoes.fFormataFloat(cdsBaicar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat, 2);

      If LTipoOperacao.Equals('PIX') Then
      Begin
        LRegistroRelatorio.NumeroNSU := EmptyStr;
        LRegistroRelatorio.ResumoVenda := FCdsRegistrosPagamento.FieldByName('MOB_CODAUT').AsString;
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      FCdsRegistrosPagamento.Next;
    End;

    Result := True;

  Except
   Raise;
  End;

end;

function TConciliacaoMobbuyAPI.LocalizaCartaoPorNsuOuAutorizacao(ADataset: TDataSet;
  const ACampoParcela, AAutorizacao, ANsu, ACodigoEmpresa, AParcela: String;
  ADataVenda: TDateTime; AApenasEmAberto: Boolean): Boolean;
  Var
    LNsuFinal,
    LAutorizacao,
    LCampos: String;

    LValores: Variant;

    LEmpresa,
    LTentativa: Integer;

    LCampoBusca,
    LValorBusca: Array[0..3] Of String;
begin
  Result := False;

  LNsuFinal := RightStr(TMobbuyFuncoes.fRetSomenteNumeros(ANsu), 6);
  If StrToInt64Def(LNsuFinal, 0) = 0 Then
    LNsuFinal := EmptyStr;

  LAutorizacao := UpperCase(Trim(AAutorizacao));
  While (LAutorizacao <> EmptyStr) And (LAutorizacao[1] = '0') Do
    Delete(LAutorizacao, 1, 1);

  LCampoBusca[0] := 'NSU_FINAL';    LValorBusca[0] := LNsuFinal;
  LCampoBusca[1] := 'AUT_FINAL';    LValorBusca[1] := LNsuFinal;
  LCampoBusca[2] := 'AUT_SEM_ZERO'; LValorBusca[2] := LAutorizacao;
  LCampoBusca[3] := 'NSU_SEM_ZERO'; LValorBusca[3] := LAutorizacao;

  For LEmpresa := 0 To 1 Do
  Begin
    If (LEmpresa = 0) And ACodigoEmpresa.IsEmpty Then
      Continue;

    For LTentativa := 0 To 3 Do
    Begin
      If LValorBusca[LTentativa].IsEmpty Then
        Continue;

      LCampos := LCampoBusca[LTentativa] + ';' + ACampoParcela + ';MCA_DTACUP';

      If (LEmpresa = 0) And AApenasEmAberto Then
        LValores := VarArrayOf([LValorBusca[LTentativa], AParcela, ADataVenda, ACodigoEmpresa, 'D'])
      Else If LEmpresa = 0 Then
        LValores := VarArrayOf([LValorBusca[LTentativa], AParcela, ADataVenda, ACodigoEmpresa])
      Else If AApenasEmAberto Then
        LValores := VarArrayOf([LValorBusca[LTentativa], AParcela, ADataVenda, 'D'])
      Else
        LValores := VarArrayOf([LValorBusca[LTentativa], AParcela, ADataVenda]);

      If LEmpresa = 0 Then
        LCampos := LCampos + ';MCA_EMPRCX';

      If AApenasEmAberto Then
        LCampos := LCampos + ';MCA_MARDES';

      If ADataset.Locate(LCampos, LValores, []) Then
        Exit(True);
    End;
  End;
end;

procedure TConciliacaoMobbuyAPI.pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
begin
  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);

  lstDtaCad := TStringList.Create;
  lstDtaCad.Duplicates := dupIgnore;
  lstDtaCad.Sorted := True;

  If (Assigned(ACdsBase)) And (Not ACdsBase.IsEmpty) Then
  Begin
    ACdsBase.IndexFieldNames := 'MOB_DTVEND';
    ACdsBase.First;

    If dtaDtaIni > ACdsBase.FieldByName('MOB_DTVEND').Value Then
      dtaDtaIni := ACdsBase.FieldByName('MOB_DTVEND').Value;

    While Not ACdsBase.Eof Do
    Begin
      lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('MOB_DTVEND').Value));

      ACdsBase.Next;
    End;
    ACdsBase.Last;

    If dtaDtaFim < ACdsBase.FieldByName('MOB_DTVEND').Value Then
      dtaDtaFim := ACdsBase.FieldByName('MOB_DTVEND').Value;
  End;

end;

procedure TConciliacaoMobbuyAPI.pCriaDataSets;
  Var
    LQueryPagamento,
    LQueryMovimento,
    LQueryAjustes : TUniQuery;

    LDataInicialDigitada,
    LDataFinalDigitada: TDateTime;
begin
  LDataInicialDigitada := dtaDtaIni;
  LDataFinalDigitada := dtaDtaFim;

  LQueryPagamento := Nil;
  LQueryMovimento := Nil;
  LQueryAjustes := Nil;

  Try
    LQueryPagamento := VS_FuncoesExternas.fICriaQuery;
    LQueryMovimento := VS_FuncoesExternas.fICriaQuery;
    LQueryAjustes := VS_FuncoesExternas.fICriaQuery;

    //CONCILIAÇÃO FINANCEIRA
    LQueryPagamento.SQL.Text := ' SELECT                                '+
                                '      P.*,                             '+
                                '      IF(P.MOB_PARCEL IN ("00", ""), "01", P.MOB_PARCEL) AS PARCELA, '+
                                '      IF(IFNULL(P.MOB_TOTPAR, "") IN ("00", ""), "01", P.MOB_TOTPAR) AS TOTAL_PARCELAS, '+
                                '      EMP_CODEMP,      '+
                                '      POR_CODPOR AS PORTADOR_GRAVAME   '+
                                'FROM MOB_APPGTO P                      '+
                                'LEFT JOIN CFGSIS                       '+
                                '      ON LOCATE(TRIM(LEADING 0 FROM P.MOB_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0  '+
                                '      AND SIS_CODCFG IN ("CFG_MOBEST")                   '+
                                'LEFT JOIN CADEMP                                         '+
                                '        ON SIS_CODEMP = EMP_CODEMP                       '+
                                'LEFT JOIN CADCCA                                         '+
                                '       ON CCA_CODCTA = P.MOB_NUMCON                      '+
                                '       AND CCA_DIGCTA =  P.MOB_DIGCON                    '+
                                '       AND TRIM(LEADING 0 FROM CCA_AGENCI) = TRIM(LEADING 0 FROM  P.MOB_CODAGE)   '+
                                '       AND TRIM(LEADING 0 FROM CCA_CODBCO) = TRIM(LEADING 0 FROM P. MOB_CODBCO)   '+
                                '       AND CCA_CCAGRA = "S"                                                       '+
                                'LEFT JOIN CADPOR                                                                  '+
                                '       ON POR_CCAAUT = CADCCA.AUTOINCREM                                          '+
                                'WHERE P.MOB_DTAPAG BETWEEN :DTAINI AND :DTAFIM                                    '+
                                '   AND (P.MOB_TIPREG<>"AJU"                                                       '+
                                '   AND (NOT (P.MOB_TIPREG="ANT" AND P.MOB_PARCEL="00")))                           ';

    if not TmOBBUYFuncoes.fEmptyStr(FFiltroEstabelecimento) then
      LQueryPagamento.SQL.Add(StringReplace(FFiltroEstabelecimento,objConcil.CampoEstabelecimento,'P.'+objConcil.CampoEstabelecimento,[rfReplaceAll]));

    LQueryPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryPagamento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryPagamento.Open;
    FCdsRegistrosPagamento := TMobbuyFuncoes.CriarClientDataSet(LQueryPagamento);
    FCdsRegistrosPagamento.Open;

    Application.ProcessMessages;

    //DEBITOS E CREDITOS
    LQueryMovimento.SQL.Clear;
    LQueryMovimento.SQL.Text := RetornaSqlVendas;
    LQueryMovimento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryMovimento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryMovimento.Open;
    FCdsRegistrosMovimento := TMobbuyFuncoes.CriarClientDataSet(LQueryMovimento);

    Application.ProcessMessages;

    //AJUSTES
    LQueryAjustes.SQL.Text := ' SELECT                                                              '+
                              '    *                                                                '+
                              '   FROM MOB_APPGTO                                                   '+
                              '   LEFT JOIN CFGSIS C ON LOCATE(TRIM(LEADING 0 FROM MOB_NUM_PV), TRIM(LEADING 0 FROM SIS_VALCFG)) > 0 '+
                              '                     AND C.SIS_CODCFG IN ("CFG_MOBEST")              '+
                              '   LEFT JOIN CADEMP E ON C.SIS_CODEMP = E.EMP_CODEMP                 '+
                              ' WHERE MOB_DTAPAG BETWEEN :DTAINI AND :DTAFIM                        '+
                              '   AND (MOB_TIPREG="AJU" OR (MOB_TIPREG="ANT" AND MOB_PARCEL="00")) '+
                              '   AND MOB_VALLIQ <> 0';

    if not TMObbuyFuncoes.fEmptyStr(FFiltroEstabelecimento) then
      LQueryAjustes.SQL.Add(StringReplace(FFiltroEstabelecimento,
                                          objConcil.CampoEstabelecimento,
                                          objConcil.CampoEstabelecimento,
                                          [rfReplaceAll]));

    LQueryAjustes.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', LDataInicialDigitada);
    LQueryAjustes.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', LDataFinalDigitada);
    LQueryAjustes.Open;
    cdsAjustes := TMobbuyFuncoes.CriarClientDataSet(LQueryAjustes);

    Application.ProcessMessages;
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(LQueryAjustes);
    TMobbuyFuncoes.FreeAndNilDatasets(LQueryMovimento);
    TMobbuyFuncoes.FreeAndNilDatasets(LQueryPagamento);

    VS_FuncoesExternas.pITrimAppMemorySize;
  End;
end;

procedure TConciliacaoMobbuyAPI.pFiltraAjustesMobbuyAPI;
  Var
    LEmpresaConfiguracao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Try
    cdsAjustes.First;
    While Not cdsAjustes.Eof Do
    Begin
      LEmpresaConfiguracao := TMobbuyFuncoes.IIF(TMobbuyFuncoes.fEmptyStr(cdsAjustes.FieldByName('EMP_CODEMP').AsString),
                                                   VS_FuncoesExternas.fIRetEmpresaLogada,
                                                   cdsAjustes.FieldByName('EMP_CODEMP').AsString);
      If Not TMobbuyFuncoes.fEmptyStr(objConcil.CodigoEmpresaFixaParaBaixa) Then
        LEmpresaConfiguracao := objConcil.CodigoEmpresaFixaParaBaixa;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto := TMobbuyFuncoes.fFormataFloat(cdsAjustes.FieldByName('MOB_VALLIQ').Value, 2);
      LRegistroRelatorio.ValorLiquido := TMobbuyFuncoes.fFormataFloat(cdsAjustes.FieldByName('MOB_VALLIQ').Value, 2);

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := UpperCase(cdsAjustes.FieldByName('MOB_LANCAM').Value);

      LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
      LRegistroRelatorio.CodigoEstabelecimento := cdsAjustes.FieldByName('MOB_NUM_PV').AsString;
      LRegistroRelatorio.NumeroNSU := EmptyStr;
      LRegistroRelatorio.NumeroCartao := EmptyStr;
      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.CodigoAutorizacao := TMobbuyFuncoes.fStrZero('0', 6);

      LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName('MOB_DTAPAG').Value;
      LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName('MOB_DTAPAG').Value;
      LRegistroRelatorio.DataVencimento := cdsAjustes.FieldByName('MOB_DTAPAG').Value;

      LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('MOB_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := '[Sempre Pronto Online] - Data de Importação: ' +
                                        FormatDateTime('dd/mm/yyyy',cdsAjustes.FieldByName('MOB_DTAIMP').AsDateTime);

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If FBaixarAjustes Then
      Begin
        LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsAjustes.Next;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TConciliacaoMobbuyAPI.Reabrir(AConfirma: Boolean): Boolean;
begin
  Result := Not AConfirma;
end;

function TConciliacaoMobbuyAPI.RetornaFiltroSqlVendas(APrefixo: String): String;
  Var
    LItem,
    LEstabelecimentos: String;

    LLista: TStringList;
begin
  Result := '';

  LLista := TStringList.Create;
  LLista.Duplicates := dupIgnore;
  LLista.Sorted := True;

  Try
    LEstabelecimentos := '';

    While not FCdsRegistrosPagamento.Eof Do
    Begin
      LLista.Add(FCdsRegistrosPagamento.FieldByName('MOB_NUM_PV').AsString);
      FCdsRegistrosPagamento.Next;
    End;

    For LItem In LLista Do
      LEstabelecimentos := LEstabelecimentos + '"' + LItem + '",';

    If LEstabelecimentos.IsEmpty Then
      Exit;

    Result := '  AND MOB_NUM_PV IN (' + LeftStr(LEstabelecimentos, LEstabelecimentos.Length-1) + ') ';
  Finally
    FCdsRegistrosPagamento.First;

    FreeAndNil(LLista);
  End;
end;

function TConciliacaoMobbuyAPI.RetornaSqlVendas: String;
begin
  pCalculaPeriodoFiltro(FCdsRegistrosPagamento);

  Result := 'SELECT * '+
            'FROM MOB_APVPAR                              '+
            'WHERE MOB_DTVEND BETWEEN :DTAINI AND :DTAFIM '+
            RetornaFiltroSqlVendas;
end;

function TConciliacaoMobbuyAPI.RetornaTipoRegistro: String;
begin
  Result := FCdsRegistrosPagamento.FieldByName('MOB_TIPREG').AsString;

 // If (FCdsRegistrosMovimento.FieldByName('TAXA').AsFloat > 0) Then
  //  Result := 'ANT';
end;

function TConciliacaoMobbuyAPI.TemRegistrosImportados: Boolean;
begin
  Result := False;
  If (Not FCdsRegistrosPagamento.IsEmpty) Then
    Exit(True)
  Else If (Not cdsAjustes.IsEmpty) Then
    Exit(True);
end;

procedure TConciliacaoMobbuyAPI.ValidaCartaoEncontrado(Var ABusca : Boolean;
                                                         Var ADivergenciaCartao : String;
                                                         AClient: TUniClientDataSet);
  Var
    LDiferenca : Double;
begin
  If Not ABusca Then
    Exit;

  LDiferenca := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('MOB_VALBRU').AsFloat, 2);

  FTolerancia := RetornaValorTolerancia(AClient.FieldByName('EMP_CODEMP').AsString);
  If Not TMobbuyFuncoes.fBetween(LDiferenca, -FTolerancia, FTolerancia) Then
  Begin
    ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
    ABusca := False;
    Exit;
  End;
end;

procedure TConciliacaoMobbuyAPI.ValidaCartaoMarcado(var ADivergenciaCartao: String);
begin
  If Not cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
    Exit;

  // Taxa Administrativa
  If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(FCdsRegistrosPagamento.FieldByName('MOB_VALBRU').AsFloat,cdsBaiCar) Then
  Begin
    ADivergenciaCartao := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
    Exit;
  end;

end;

function TConciliacaoMobbuyAPI.RetornaValorLiquidoParcela: Double;
begin
  Result := FCdsRegistrosPagamento.FieldByName('MOB_VALLIQ').AsFloat;

  If FCdsRegistrosMovimento.FieldByName('MOB_PARBRU').AsFloat <= 0 Then
    Exit;

  If Not FormatFloat('0.00', FCdsRegistrosPagamento.FieldByName('MOB_VALLIQ').AsFloat)
       .Equals(FormatFloat('0.00', FCdsRegistrosMovimento.FieldByName('MOB_PARBRU').AsFloat)) Then
    Exit(FCdsRegistrosMovimento.FieldByName('MOB_PARBRU').AsFloat);
end;

function TConciliacaoMobbuyAPI.fConciliaMobbuyAPI(pgbStatus: TcxProgressBar): Boolean;
Var
  blnVazio     : Boolean;
begin
  Result       := False;
  FPossuiInconsistencia := False;
  TForm(pgbStatus.Owner).Visible := False;
  Try
    Try
      FFiltrarAutorizacaoNSU := True;

      strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

      Application.ProcessMessages;

      objConcil.TabelaConciliacao := 'MOB_APPGTO';
      objConcil.CampoEstabelecimento := 'MOB_NUM_PV';
      objConcil.NomeConciliacao := 'Sempre Pronto API';
      objConcil.CfgEstabelecimentos := 'CFG_MOBEST';
      objConcil.CampoValorBruto := 'MOB_VLBRU';
      objConcil.CampoValorLiquido := 'MOB_VLLIQ';
      objConcil.CampoCodigoAutorizacao := 'MOB_CODAUT';
      objConcil.CampoNumeroNSU := 'MOB_NUMNSU';
      objConcil.CampoDataRecebimento := 'MOB_DTAPAG';
      objConcil.CampoDataTransacaoVenda := 'MOB_DTAVEN';
      objConcil.CampoTipoRegistro := 'MOB_TIPREG';
      objConcil.CfgPortadorAjustes := 'MOBPOR';
      objConcil.CfgPlanoDeContasAjustes := 'MOBCTA';
      objConcil.CfgFornecedorAjustes := 'MOBFOR';
      objConcil.strEventoCancelamentoAjuste := 'MOBEVE';
      objConcil.CfgVlrTolerancia := 'MOBTOL';

      objConcil.strChavePrimaria := 'MOB_CODAUT,MOB_DTVEND,MOB_NUM_PV,MOB_NUMNSU,MOB_PARCEL,MOB_TIPREG,MOB_CES_ID';

      If Not fDigPeriodo Then
        Exit;

      FFiltroEstabelecimento := fRetPesqPonVen(0);

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := True;

      TMobbuyFuncoes.pStepStatusGravacao(pgbStatus,'Aguarde... Filtrando registros para conciliação.', False);
      pCriaDataSets;
      blnVazio := FCdsRegistrosPagamento.IsEmpty And cdsAjustes.IsEmpty;

      If blnVazio Then
      Begin
        TMobbuyFuncoes.fMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&Ok']);
        blnReabre := True;
        Exit;
      End;

      TMobbuyFuncoes.pStepStatusGravacao(pgbStatus,'Aguarde... Filtrando cartões.', False);
      pFiltraCartoes;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'SEMPRE PRONTO API',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TMobbuyFuncoes.RetornaDataHoraServidor,
                                                            TMobbuyFuncoes.RetornaHoraServidor);

      pFiltraAjustesMobbuyAPI;

      FiltraCartoesBaixados;

      pgbStatus.Visible := True;
      If Not FCdsRegistrosPagamento.IsEmpty Then
      Begin
        TMobbuyFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de débito/crédito (SEMPRE PRONTO).', False);
        fProcessaRegistrosDebitoCredito(pgbStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      TMobbuyFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (SEMPRE PRONTO).', False);
      GravarRegistrosRelatorio(pgbStatus);;

      If FPossuiInconsistencia Then
        TMobbuyFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      Result := FinalizandoConciliacao(pgbStatus);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaMobbuyAPI]');
      End;
    End;
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(FCdsRegistrosPagamento);
    TMobbuyFuncoes.FreeAndNilDatasets(FCdsRegistrosMovimento);
    TMobbuyFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
end;

end.
