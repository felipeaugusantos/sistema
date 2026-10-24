unit untConciliacaoGranito;


interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math, System.Generics.Collections, System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untGranitoConciliacaoCartoes, untLibCartoesInterfacesTipos, untTGranitoFuncoes,
     untGranitoTipos;

type

  TConciliacaoGranito = class(TConciliacaoCartoes)
  private
    FTolerancia: Double;
    FFiltroEstabelecimento : String;
    FGravouAjustes: Boolean;

    procedure pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
    procedure pCriaDataSets;

    function fGetTipoDeOperacao: String;

    function FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
    procedure ValidaCartaoEncontrado(Var ABusca : Boolean;
                                     Var ADivergenciaCartao : String;
                                     AClient: TUniClientDataSet);
    procedure ValidaCartaoMarcado(Var ADivergenciaCartao : String);
    function TotalizaComoInconsistenciaQueNaoBaixa(AValor:String):Boolean;
    function RetornaSqlTransacoes:String;
    function RetornaSqlAjustesFinanceiro:String;
    function RetornaValorLiquidoParcela: Double;
    function RetornaInAutorizacaoFiltrar: String;
    function RetornaInNsuFiltrar: String;
    function RetornaTipoAjusteSQL:String;

     function SituacaoConfiguracoesAjuste(ACodEmp: String) : String;

    procedure FiltraCartoesBaixados;

    procedure FiltraAjustesGranito;

    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaGranito(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;

  end;

Const
  INICAM = 'GRA_';
  NOMTAB = 'GRA_FVPGTO';

implementation

{ TConciliacaoGranito }

function TConciliacaoGranito.fConciliaGranito(pgbStatus: TcxProgressBar): Boolean;
Var
  blnVazio     : Boolean;
begin
  TForm(pgbStatus.Owner).Visible := False;
  Try
    Try
      Result := False;
      FPossuiInconsistencia := False;
      FFiltrarAutorizacaoNSU := True;

      objConcil.TabelaConciliacao           := 'GRA_GTPGTO';
      objConcil.CampoEstabelecimento        := 'GRA_CODEST';
      objConcil.NomeConciliacao             := 'Granito';
      objConcil.CampoValorBruto             := 'GRA_VALBRU';
      objConcil.CampoValorLiquido           := 'GRA_VALLIQ';
      objConcil.CampoCodigoAutorizacao      := 'GRA_CODAUT';
      objConcil.CampoNumeroNSU              := 'GRA_NUMNSU';
      objConcil.CampoDataTransacaoVenda     := 'GRA_DTATRA';
      objConcil.CampoDataRecebimento        := 'GRA_DTAPAG';
      objConcil.CampoNumeroParcela          := 'GRA_NUMPAR';
      objConcil.CampoTotalParcelas          := 'GRA_TOTPAR';
      objConcil.CampoNumeroCartao           := '';
      objConcil.CampoTipoRegistro           := '';
      objConcil.CampoTipoTransacao          := '';
      objConcil.CfgEstabelecimentos         := 'CFG_GRAEST';
      objConcil.CfgPortadorAjustes          := 'GRAPOR';
      objConcil.CfgPlanoDeContasAjustes     := 'GRACTA';
      objConcil.CfgFornecedorAjustes        := 'GRAFOR';
      objConcil.strEventoCancelamentoAjuste := 'GRAEVE';

      objConcil.strChavePrimaria            := 'GRA_TIPREG,GRA_NUM_RV,GRA_DTAPAG,GRA_NUMPAR,GRA_CODAUT,GRA_NUMNSU';

      If Not fDigPeriodo Then
        Exit;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'Granito',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TGranitoFuncoes.RetornaDataHoraServidor,
                                                            TGranitoFuncoes.RetornaHoraServidor);

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;

      TGranitoFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (GRANITO).', False);
      pCriaDataSets;

      blnVazio :=  cdsConcar.IsEmpty And cdsAjustes.IsEmpty;

      If blnVazio Then
      Begin
        TGranitoFuncoes.fMensagem('','Nenhum registro foi importado para o período selecionado.',['&OK']);
        blnReabre := True;
        Exit;
      End;

      TGranitoFuncoes.FreeAndNilStringLists(lstDtaCad);
      lstDtaCad := TStringList.Create;
      pCalculaPeriodoFiltro(cdsConcar);

      FInAutorizacaoFiltrar := RetornaInAutorizacaoFiltrar;
      FInNsuFiltrar := RetornaInNsuFiltrar;

      TGranitoFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões.', False);
      pFiltraCartoes;

      FiltraAjustesGranito;

      TGranitoFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando cartões baixados.', False);
      FiltraCartoesBaixados;

      pgbStatus.Visible := True;
      If Not cdsConcar.IsEmpty Then
      Begin
        TGranitoFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de débito\crédito (' + objConcil.NomeConciliacao + ').', False);
        fProcessaRegistrosDebitoCredito(pgbStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TGranitoFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(pgbStatus);

      if FPossuiInconsistencia then
       TGranitoFuncoes.fMensagem('', 'Foram encontradas inconsistências na importação dos arquivos!', ['&OK']);

      Result := FinalizandoConciliacao(pgbStatus);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaGranito]');
      End;
    End;
  Finally
    TGranitoFuncoes.FreeAndNilDatasets(cdsConcar);
    TGranitoFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
end;


function TConciliacaoGranito.fConciliaCartoes: Boolean;
begin
  Result := TGranitoFuncoes.ExecutaAguarde(fConciliaGranito, 'Aguarde... Iniciando a conciliação.');
end;

function TConciliacaoGranito.fGetTipoDeOperacao: String;
  Var
    LModalidade: String;
begin
  Result := '';

  //no caso da Granito
  if ((cdsConcar.FieldByName('GRA_TIPLAN').asinteger = 3) or // Tipo de lançamento = 3 – Liquidação antecipada
     (cdsConcar.FieldByName('GRA_TIPTRN').asinteger = 3) or//Tipo de Transação  =3 - Transação a crédito antecipada 400 - Cancelamento com o cartão  maquininha
     (cdsConcar.FieldByName('GRA_TAXANT').asfloat >0) or  //Valor taxa antecipação  parcela >0
     (cdsConcar.FieldByName('GRA_VALIOF').asfloat >0)) then  //ou  (IOF)  > 0
        Exit('ANTECIPAÇÃO');

  if cdsConcar.FieldByName('GRA_TIPREG').asinteger = 5 then
    Exit('PIX');

  LModalidade := AnsiUpperCase(cdsConcar.FieldByName('GRA_TIPCON').AsString);

  If Pos('DÉBITO',LModalidade) > 0 Then
    Result := 'DÉBITO'

  Else If Pos('CRÉDITO',LModalidade) > 0 Then
  Begin
    Result := TGranitoFuncoes.IIF(cdsConcar.FieldByName('GRA_TOTPAR').AsInteger > 1, 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO');
  End;
end;

procedure TConciliacaoGranito.FiltraAjustesGranito; //seguindo rede api
Var
    strConfEm,
    strCodEmpresa : String;
    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Try
    cdsAjustes.First;
    While Not cdsAjustes.Eof Do
    Begin
      strCodEmpresa := '';
      strConfEm     := TGranitoFuncoes.IIF(TGranitoFuncoes.fEmptyStr(cdsAjustes.FieldByName('EMP_CODEMP').AsString),
                           VS_FuncoesExternas.fIRetEmpresaLogada,
                           cdsAjustes.FieldByName('EMP_CODEMP').AsString);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';

      LRegistroRelatorio.NomeCliente := AnsiUpperCase(cdsAjustes.FieldByName('TIPO_AJUSTE').AsString);
      LRegistroRelatorio.Parcela := '';
      LRegistroRelatorio.CodigoAutorizacao := '';
      LRegistroRelatorio.NumeroNSU := TGranitoFuncoes.fStrZero(Trim(RightStr(cdsAjustes.FieldByName('GRA_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.NumeroCartao := '';

      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('TIPO_AJUSTE').AsString.ToUpperInvariant;


      LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName('GRA_DTAPAG').Value;
      LRegistroRelatorio.DataVencimento := cdsAjustes.FieldByName('GRA_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName('GRA_DTATRA').Value;

      LRegistroRelatorio.Parcela := TGranitoFuncoes.fStrZero(RightStr(cdsAjustes.FieldByName('GRA_NUMPAR').AsString , 2), 2);
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.CodigoAutorizacao := TGranitoFuncoes.fStrZero(cdsAjustes.FieldByName('GRA_CODAUT').AsString, 6);

      LRegistroRelatorio.ValorBruto := cdsAjustes.FieldByName('GRA_VALBRU').Value ;
      LRegistroRelatorio.ValorLiquido :=  cdsAjustes.FieldByName('GRA_VALLIQ').Value ;

      If Not TGranitoFuncoes.fEmptyStr(cdsAjustes.FieldByName('EMP_CODEMP').AsString) then
          strCodEmpresa := cdsAjustes.FieldByName('EMP_CODEMP').AsString
      Else If Not TGranitoFuncoes.fEmptyStr(strConfEm) Then
          strCodEmpresa := strConfEm;
      LRegistroRelatorio.CodigoEmpresa := strCodEmpresa;

      LRegistroRelatorio.CodigoEstabelecimento  := cdsAjustes.FieldByName('GRA_CODEST').AsString;

      LRegistroRelatorio.PortadorCredito                 := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, strConfEm);
      LRegistroRelatorio.PlanoContasTransferenciaCredito := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, strConfEm);
      LRegistroRelatorio.PlanoContasTaxaNegociacao       := VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, strConfEm);

      LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('GRA_CONCIL').AsInteger;

      if cdsAjustes.FindField('GRA_NOMARQ') <> nil then
        LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('GRA_NOMARQ').AsString;

      If (VS_FuncoesExternas.fICfgSis('BAIDEB') = 'S') Then
      Begin
        LRegistroRelatorio.SituacaoCadastro :=  SituacaoConfiguracoesAjuste(strCodEmpresa);
      End;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If FBaixarAjustes Then
      Begin
        LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LRegistroRelatorio.CodigoEmpresa);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsAjustes.Next;

      FGravouAjustes := True;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TConciliacaoGranito.FiltraCartoesBaixados;
begin
  pFiltraCartoesBaixados(False);
end;

function TConciliacaoGranito.FinalizandoConciliacao(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  If FListaRegistrosRelatorio.Count > 0 Then
    Result := GeraRelatorioConciliacao('Granito', pgbStatus);

  If Assigned(cdsAjustes) Then
  Begin
    cdsAjustes.Filter   := 'GRA_CONCIL=0';
    cdsAjustes.Filtered := True;
  End;

  blnReabre := Not Result;
  If Result Then
  Begin
    cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
    cdsBaiCar.Filtered := True;

    Result := Not cdsBaiCar.IsEmpty;
    If Not Result Then
      TGranitoFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
    Else
      TGranitoFuncoes.fMensagem('AVISO','Conciliação da ' + objConcil.NomeConciliacao + ' realizada com sucesso.',['&OK']);
  End;
end;


function TConciliacaoGranito.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
Var
    LParcela                : String;
    LNumNsu                : String;
    strCodEmp                : String;
    dtaDtaCad                : TDateTime;
    strNumAut                : String;
    LBuscaCartao             : Boolean;
    STipoOperacao            : String;
    LDivergenciaCartao       : String;
    LNumCCD                  : String;
    LTaxaAntecipacao         : Double;
    LChaveConciliacao        : String;
    LTipoReg                 : String;
    LRegistroRelatorio       : TItensRelatorioCartoes;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConcar.RecordCount;

    cdsConcar.First;

    While Not cdsConcar.Eof Do
    Begin
      TGranitoFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';
      LDivergenciaCartao := '';

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LTaxaAntecipacao := cdsConcar.FieldByName('GRA_TAXANT').AsFloat;
      LTipoReg :=cdsConCar.FieldByName('GRA_TIPREG').AsString;

      STipoOperacao := fGetTipoDeOperacao;
      If Not LTipoReg.Equals('5') Then
        LParcela := TGranitoFuncoes.fGetLetraAlfa(StrtoInt(RightStr(cdsConcar.FieldByName('GRA_NUMPAR').AsString , 2)))
      else
        LParcela := '01';

      FTextoInconsistencia := '';
      LNumNsu := TGranitoFuncoes.fStrZero(Trim(RightStr(cdsConcar.FieldByName('GRA_NUMNSU').AsString, 14)), 14);
      strNumAut := cdsConcar.FieldByName('GRA_CODAUT').AsString;
      dtaDtaCad := cdsConcar.FieldByName('GRA_DTATRA').AsDateTime;
      strCodEmp := cdsConcar.FieldByName('EMP_CODEMP').AsString;

      {********************}
      {* NOVA CONCILIAÇÃO *}
      {*****************GD*}

      LNumCCD := TGranitoFuncoes.IIF((strNumAut = '0'),'',TGranitoFuncoes.fStrZero(strNumAut, 6));

      LBuscaCartao := fBuscaCartao(LNumCCD,
                               LNumNsu,
                               strCodEmp,
                               LParcela,
                               dtaDtaCad);

      If Not LBuscaCartao Then
      Begin
        If  LTipoReg= '5' Then
          LBuscaCartao := BuscaCartaoPix(cdsConCar.FieldByName('GRA_REFPIX').AsString,
                                                    cdsConCar.FieldByName('EMP_CODEMP').AsString,
                                                    LParcela,
                                                    cdsConCar.FieldByName('GRA_DTATRA').AsDateTime);


      End;

      LDivergenciaCartao := '';
      ValidaCartaoEncontrado(LBuscaCartao,LDivergenciaCartao,cdsConcar);

      If (LBuscaCartao) Then
      Begin
        LChaveConciliacao := 'GRA_' +    cdsConcar.FieldByName('GRA_CODEST').AsString + '_' +
                                 cdsConcar.FieldByName('GRA_CODAUT').Value + '_' +
                                 LParcela + '_' +
                                 cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                 FormatDateTime('yyyy-mm-dd', cdsConcar.FieldByName('GRA_DTAPAG').Value);


        MarcarCartaoEncontradoArquivo(TGranitoFuncoes.fFormataFloat(cdsConcar.FieldByName('GRA_VALLIQ').Value,2),
                                     (LTaxaAntecipacao > 0),
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar);



        ValidaCartaoMarcado(LDivergenciaCartao);
      End
      Else
      Begin
        //verifica se está cadastrado ou já foi baixado no período
        cdsBaixad.First;
        LBuscaCartao := fBuscaCartaoBaixado(LNumCCD,
                                        LNumNsu,
                                        strCodEmp,
                                        LParcela,
                                        dtaDtaCad,
                                        True,
                                        cdsConcar.FieldByName('GRA_VALBRU').AsFloat);
        If Not LBuscaCartao Then
        Begin
          If LTipoReg= '5' Then
            LBuscaCartao := BuscaCartaoBaixadoPix(cdsConCar.FieldByName('GRA_REFPIX').AsString,
                                                             cdsConCar.FieldByName('EMP_CODEMP').AsString,
                                                             LParcela,
                                                             cdsConCar.FieldByName('GRA_DTATRA').AsDateTime);
        End;

        FTextoInconsistencia := TGranitoFuncoes.IIF(LBuscaCartao,'Cartão já foi baixado',
                                  'Registro do arquivo não encontrado nos lançamentos do sistema');
      End;

      LRegistroRelatorio := LRegistroRelatorio.Create;

      //Grava inconsistência se houver
      FTextoInconsistencia := TGranitoFuncoes.IIF(TGranitoFuncoes.fEmptyStr(LDivergenciaCartao),FTextoInconsistencia,LDivergenciaCartao);
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);

      If Not TGranitoFuncoes.fEmptyStr(FTextoInconsistencia) Then
      Begin
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
        LRegistroRelatorio.Descricao      := FTextoInconsistencia;

        if TotalizaComoInconsistenciaQueNaoBaixa(FTextoInconsistencia) then
          LRegistroRelatorio.SomarNoTotal := 'S';
      end;

      if cdsConcar.FindField('GRA_NOMARQ') <> nil then
        LRegistroRelatorio.NomeArquivo := cdsConcar.FieldByName('GRA_NOMARQ').AsString;


      LRegistroRelatorio.ValorBruto :=  cdsConcar.FieldByName('GRA_VALBRU').AsFloat;
      LRegistroRelatorio.CodigoAutorizacao :=TGranitoFuncoes.fStrZero(Trim(RightStr(cdsConcar.FieldByName('GRA_NUMNSU').AsString, 14)), 14);

      If Not TGranitoFuncoes.fEmptyStr(cdsConcar.FieldByName('EMP_CODEMP').AsString) Then
        LRegistroRelatorio.CodigoEmpresa := cdsConcar.FieldByName('EMP_CODEMP').AsString;

      LRegistroRelatorio.CodigoEstabelecimento := cdsConcar.FieldByName('GRA_CODEST').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConcar.FieldByName('GRA_NUM_RV').AsString;
      LRegistroRelatorio.NumeroCartao := '';
      LRegistroRelatorio.TipoCartao := STipoOperacao;
      LRegistroRelatorio.DataVenda := cdsConcar.FieldByName('GRA_DTATRA').AsDateTime;
      LRegistroRelatorio.DataVencimento := cdsConcar.FieldByName('GRA_DTAPAG').AsDateTime;
      LRegistroRelatorio.Parcela := TGranitoFuncoes.fStrZero(RightStr(cdsConcar.FieldByName('GRA_NUMPAR').AsString , 2), 2);
      LRegistroRelatorio.TotalParcelas := TGranitoFuncoes.fStrZero(RightStr(cdsConcar.FieldByName('GRA_TOTPAR').AsString , 2), 2);
      LRegistroRelatorio.NumeroNSU := TGranitoFuncoes.fStrZero(Trim(RightStr(cdsConcar.FieldByName('GRA_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := LNumCCD;
      LRegistroRelatorio.ValorLiquido :=  RetornaValorLiquidoParcela - LTaxaAntecipacao;


      LRegistroRelatorio.DescricaoBandeira :=  AnsiUpperCase(cdsConcar.FieldByName('GRA_NOMBAN').AsString);

      If LTipoReg= '5' then
          LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('GRA_REFPIX').AsString;

      If LRegistroRelatorio.SomarNoTotal = 'S' Then
      Begin
        LRegistroRelatorio.CodigoBandeira := cdsBaicar.FieldByName('CAR_CODBAN').AsString;
        LRegistroRelatorio.PercentualTaxa := TGranitoFuncoes.fFormataFloat(cdsBaicar.FieldByName('CAR_PERDES').AsFloat, 2);
        If String(VS_FuncoesExternas.fICfgSis('VLDTAX',varString)).Equals('2') Then
          LRegistroRelatorio.PercentualTaxa := TGranitoFuncoes.fFormataFloat(cdsBaicar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat, 2);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConcar.Next;
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

procedure TConciliacaoGranito.pCalculaPeriodoFiltro(ACdsBase : TUniClientDataSet);
begin
  If (Assigned(ACdsBase)) And (Not ACdsBase.IsEmpty) Then
  Begin
    ACdsBase.IndexFieldNames := 'GRA_DTATRA';
    ACdsBase.First;

    If dtaDtaIni > ACdsBase.FieldByName('GRA_DTATRA').Value Then
      dtaDtaIni := ACdsBase.FieldByName('GRA_DTATRA').Value;

    While Not ACdsBase.Eof Do
    Begin
      If lstDtaCad.IndexOf(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('GRA_DTATRA').Value)) < 0 Then
        lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', ACdsBase.FieldByName('GRA_DTATRA').Value));

      ACdsBase.Next;
      Application.ProcessMessages;
    End;
    ACdsBase.Last;

    If dtaDtaFim < ACdsBase.FieldByName('GRA_DTATRA').Value Then
      dtaDtaFim := ACdsBase.FieldByName('GRA_DTATRA').Value;
  End;

end;

procedure TConciliacaoGranito.pCriaDataSets;
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

    //tRANSAÇÕES E PIX
    LQueryMovimento.SQL.Text := RetornaSqlTransacoes;
    LQueryMovimento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryMovimento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryMovimento.Open;
    cdsConcar := TGranitoFuncoes.CriarClientDataSet(LQueryMovimento);
    
    //AJUSTES , CANCELAMENTOS E COBRANÇAS
    LQueryAjustes.SQL.Text := RetornaSqlAjustesFinanceiro;
    LQueryAjustes.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LQueryAjustes.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LQueryAjustes.Open;
    cdsAjustes := TGranitoFuncoes.CriarClientDataSet(LQueryAjustes);
    Application.ProcessMessages;
  Finally
    TGranitoFuncoes.FreeAndNilDatasets(LQueryMovimento);
    TGranitoFuncoes.FreeAndNilDatasets(LQueryAjustes);
  End;
end;

function TConciliacaoGranito.RetornaInAutorizacaoFiltrar: String;
  Var
    LValor: String;
begin
  Result := '""';

  cdsConcar.First;
  While Not cdsConcar.Eof Do
  Begin
    LValor := '"' + TGranitoFuncoes.fStrZero(cdsConcar.FieldByName('GRA_CODAUT').AsString, 6) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConcar.Next;
      Continue;
    End;

    Result := Result + ',' + LValor;

    If cdsConcar.FieldByName('GRA_CODAUT').AsString.Length < 6 Then
    Begin
      LValor := '"' + cdsConcar.FieldByName('GRA_CODAUT').AsString + '"';

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

function TConciliacaoGranito.RetornaInNsuFiltrar: String;
   Var
    LValor: String;
begin
  Result := '""';

  cdsConcar.First;
  While Not cdsConcar.Eof Do
  Begin
    LValor := '"' + TGranitoFuncoes.fStrZero(cdsConcar.FieldByName('GRA_NUMNSU').AsString, 14) + '"';

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

function TConciliacaoGranito.RetornaSqlAjustesFinanceiro: String;
begin
  Result := 'SELECT                                    '+
            RetornaTipoAjusteSQL + ' AS TIPO_AJUSTE,   '+
            '  EMP_CODEMP,                             '+
            '  EMP_NOMEMP,                             '+
            '  GRA_GTPGTO.*                            '+
            'FROM                                      '+
            '  GRA_GTPGTO                              '+
            '  LEFT JOIN CFGSIS                        '+
            '    ON LOCATE(GRA_CODEST, SIS_VALCFG) > 0 '+
            '    AND SIS_CODCFG IN ("CFG_GRAEST")      '+
            '  LEFT JOIN CADEMP                        '+
            '    ON SIS_CODEMP = EMP_CODEMP            '+
            'WHERE GRA_DTAPAG BETWEEN :DTAINI          '+
            '  AND :DTAFIM                             '+
            '  AND GRA_TIPREG IN("2","3","4")          ';

  If Not TGranitoFuncoes.fEmptyStr(FFiltroEstabelecimento) then
    Result := Result + StringReplace(FFiltroEstabelecimento,objConcil.CampoEstabelecimento,objConcil.CampoEstabelecimento,[rfReplaceAll]);
end;

function TConciliacaoGranito.RetornaSqlTransacoes: String;
begin

  Result := 'SELECT                                    '+
            '  *                                       '+
            'FROM                                      '+
            '  GRA_GTPGTO                              '+
            '  LEFT JOIN CFGSIS                        '+
            '    ON LOCATE(GRA_CODEST, SIS_VALCFG) > 0 '+
            '    AND SIS_CODCFG IN ("CFG_GRAEST")     '+
            '  LEFT JOIN CADEMP                        '+
            '    ON SIS_CODEMP = EMP_CODEMP            '+
            'WHERE GRA_DTAPAG BETWEEN :DTAINI          '+
            '  AND :DTAFIM                             '+
            '  AND GRA_TIPREG IN("1","5")              '+
            '  AND GRA_VALBRU > "0"                    ';


  If Not TGranitoFuncoes.fEmptyStr(FFiltroEstabelecimento) then
    Result := Result + StringReplace(FFiltroEstabelecimento,objConcil.CampoEstabelecimento,objConcil.CampoEstabelecimento,[rfReplaceAll]);

end;

function TConciliacaoGranito.RetornaTipoAjusteSQL: String;
begin
  Result :=
  'CASE GRA_TIPTRN '+
  '  WHEN "0" THEN "Não se aplica"'+
  '  WHEN "1" THEN "Transação a crédito"'+
  '  WHEN "3" THEN "Transação a crédito antecipada"'+
  '  WHEN "400" THEN "Cancelamento com o cartão  maquininha"'+
  '  WHEN "420" THEN "Desfazimento automático na  maquininha ou servidor devido a problemas na comunicação"'+
  '  WHEN "450" THEN "Cancelamento por solicitação estabelecimento"'+
  '  WHEN "460" THEN "Desfazimento vindo da bandeira  por solicitação do cliente final ou alguma inconsistência"'+
  '  WHEN "490" THEN "Cancelamento parcial de transação"'+
  '  WHEN "500" THEN "Débito por pagamento duplicado"'+
  '  WHEN "502" THEN "Débito por pagamento indevido"'+
  '  WHEN "520" THEN "Débito acordado com o financeiro  da GRANITO"'+
  '  WHEN "521" THEN "Débito referente à reposição de equipamentos"'+
  '  WHEN "522" THEN "Cobrança referente utilização do  chip telefonia"'+
  '  WHEN "530" THEN "Tarifa referente a emissão de  cartão pré pago"'+
  '  WHEN "600" THEN "Crédito transação cancelada  indevidamente"'+
  '  WHEN "620" THEN "Crédito valor cobrado indevidamente pedido"'+
  '  WHEN "700" THEN "Crédito por taxa de antecipação  indevida"'+
  '  WHEN "701" THEN "Crédito por taxa de administração  indevida"'+
  '  WHEN "702" THEN "Pagamentos de transações de  outro cadastro"'+
  '  WHEN "703" THEN "Crédito por diferença entre valores  a pagar e valores pagos"'+
  '  WHEN "800" THEN "Serviço de cobrança utilizado por  parceiros"'+
  '  WHEN "801" THEN "Crédito por cobrança não efetivada"'+
  '  WHEN "810" THEN "Débito referente a transferência de  recebível solicitada por cliente parceiro"'+
  '  WHEN "811" THEN "Crédito referente a transferência  de recebível de cliente parceiro"'+
  '  WHEN "812" THEN "Débito referente a compra de  recebíveis"'+
  '  WHEN "813" THEN "Crédito referente a compra de  recebíveis"'+
  '  WHEN "814" THEN "Recebíveis cedidos à empresa de  fomento atráves de pagamento antecipado"'+
  '  WHEN "815" THEN "Transferência para validar os dados  bancários informados no cadastro"'+
  '  WHEN "816" THEN "Crédito em cartão pré-pago de filial GRANITO"'+
  '  WHEN "817" THEN "Débito referente à pagamento de  máquinas "'+
  '  WHEN "818" THEN "Recebíveis de parcelas de recorrente cedidos"'+
  '  WHEN "819" THEN "Recebíveis de parcelas de recorrente captados"'+
  '  WHEN "820" THEN "Chargeback Débito "'+
  '  WHEN "821" THEN "Crédito referente a bonificação do  plano de incentivo."'+
  '  WHEN "822" THEN "Crédito referente a chargeback  regularizado por parceiro"'+
  '  ELSE "Outros" END ';
end;

function TConciliacaoGranito.TotalizaComoInconsistenciaQueNaoBaixa(AValor: String): Boolean;
begin
  Result := True;

  If AValor.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
    Result := False;
end;

procedure TConciliacaoGranito.ValidaCartaoEncontrado(Var ABusca : Boolean;
                                                         Var ADivergenciaCartao : String;
                                                         AClient: TUniClientDataSet);
  Var
    LDiferenca : Double;
begin
  If Not ABusca Then
    Exit;

  // Valor Bruto
  LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - AClient.FieldByName('GRA_VALBRU').AsFloat;

  FTolerancia := RetornaValorTolerancia(AClient.FieldByName('EMP_CODEMP').AsString, 0.022222);
  If Not ((TGranitoFuncoes.fFormataFloat(LDiferenca, 2) <= FTolerancia) And (TGranitoFuncoes.fFormataFloat(LDiferenca, 2) >= -FTolerancia)) Then
  Begin
    ADivergenciaCartao := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
    ABusca := False;
    Exit;
  End;
end;

procedure TConciliacaoGranito.ValidaCartaoMarcado(var ADivergenciaCartao: String);
begin
  If Not cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
    Exit;

  // Taxa Administrativa
  If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(cdsConcar.FieldByName('GRA_VALBRU').AsFloat,cdsBaiCar) Then
  Begin
    ADivergenciaCartao := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
    Exit;
  end;

end;

function TConciliacaoGranito.RetornaValorLiquidoParcela: Double;
begin
  Result := cdsConcar.FieldByName('GRA_VALLIQ').AsFloat;
end;

function TConciliacaoGranito.SituacaoConfiguracoesAjuste(
  ACodEmp: String): String;
begin
  Result := 'COMPLETO';

  If TGranitoFuncoes.fEmptyStr(ACodEmp) Then
    Exit('INCOMPLETO')
  Else If (TGranitoFuncoes.fEmptyStr(VS_FuncoesExternas.fiCfgSis(objConcil.CfgPortadorAjustes, varString, ACodEmp))) Then
    Exit('INCOMPLETO')
  Else If (TGranitoFuncoes.fEmptyStr(VS_FuncoesExternas.fiCfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodEmp))) Then
    Exit('INCOMPLETO')
  Else If (TGranitoFuncoes.fEmptyStr(VS_FuncoesExternas.fiCfgSis(objConcil.CfgFornecedorAjustes, varString, ACodEmp))) Then
    Exit('INCOMPLETO');
end;

end.
