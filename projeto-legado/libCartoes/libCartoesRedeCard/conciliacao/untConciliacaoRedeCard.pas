unit untConciliacaoRedeCard;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untRedeCardConciliacaoCartoes, untLibCartoesInterfacesTipos, untTRedeCardFuncoes,
     untTLibCartoesMovCar;

type TConcilRedeCard = class(TConciliacaoCartoes)
  private
    cdsRED_EVDR05    : TUniClientDataSet; //RESUMO DE VENDAS DEBITO
    cdsRED_EFIR34    : TUniClientDataSet; //EXTRATO FINANCEIRO
    cdsRED_EVCR06    : TUniClientDataSet; //RESUMO DE VENDAS CREDITO ROTATIVO
    cdsRED_EVCR08    : TUniClientDataSet; //DETALHAMENTO DE VENDAS CREDITO ROTATIVO
    cdsRED_EVCR10    : TUniClientDataSet; //RESUMO DE VENDAS CREDITO PARCELADO
    cdsRED_EVCR12    : TUniClientDataSet; //DETALHAMENTO DE VENDAS CREDITO PARCELADO
    cdsRED_EVCR14    : TUniClientDataSet; //DETALHAMENTO DE PARCELAS CREDITO SEM JUROS (USAR COM REGISTROS 046)

    FRegistro046: TUniClientDataSet;

    FListaDatasRVs046,
    FListaRegistros034: TStringList; //Parcelas já conciliadas no 034 e não conciliar o 046
    LTolerancia: Double;

    procedure pCriaClientRED_EVDR05;
    procedure pCriaClientRED_EFIR34;
    procedure pCriaClientRED_EVCR06;
    procedure pCriaClientRED_EVCR08;
    procedure pCriaClientRED_EVCR10;
    procedure pCriaClientRED_EVCR12;
    procedure pCriaClientRegistro046;
    procedure pCriaClientRED_EVCR14;

    function fProcessaCreditoRede(pgbStatus: TcxProgressBar): Boolean;
    function fProcessaDebitoRede(pgbStatus: TcxProgressBar): Boolean;
    function ProcessaPagamentosNegociacao(pgbStatus: TcxProgressBar): Boolean;

    procedure GeraListaDatasDeRVsSelecionadosRegistro046;

    procedure pCalculaPeriodoFiltro;

    function RegistroCanceladoNoMesmoDia(ARegistro: TDataset; AValor: Double; AParcela: String): Boolean;

    function RetornaSQLTotalGravameRegistro034: String;

    procedure ValidaCartaoMarcado(Var AInconsistenciaCartao: String;
                                      AValorBruto: Double;
                                  var ARegistroRelatorio: TItensRelatorioCartoes);


    function fConciliaRedeCard(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
    function fRelatPreConciliacao: Boolean;

  protected

  end;

Const
  INICAM = 'RED_';

implementation
Uses untLibCartoesGravando, untLibCartoesFiltroInconsistencias;

function TConcilRedeCard.fProcessaCreditoRede(pgbStatus: TcxProgressBar): Boolean;
  Var
    fltDifere  : Double;
    strNumNsu  : String;
    strCodEmp  : String;
    dtaDtaCad  : TDateTime;
    intLimpMem : Integer;
    fltPerTot  : Double;
    strNumAut  : String;
    blnBusca   : Boolean;
    blnSemReg  : Boolean;
    
    LValorBruto,
    LValorLiquido: Double;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LParcela,
    LChaveConciliacao: String;
begin
  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsRED_EFIR34.RecordCount + 5;
    intLimpMem := 0;

    TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
    pCriaClientRED_EVCR06;
    TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
    pCriaClientRED_EVCR08;
    TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
    pCriaClientRED_EVCR10;
    TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
    pCriaClientRED_EVCR12;
    TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);

    objConcil.strChavePrimaria := 'RED_DTA_RV,RED_NUM_PV,RED_NUM_RV,RED_PARTOT,RED_TIPREG,RED_NUM_OC';

    cdsRED_EFIR34.First;
    While Not cdsRED_EFIR34.Eof Do
    Begin
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      If intLimpMem >= 50 Then
      Begin
        VS_FuncoesExternas.pITrimAppMemorySize;
        intLimpMem := 0;
      End
      Else
        inc(intLimpMem);

      LParcela := TRedeCardFuncoes.fGetLetraAlfa(StrtoInt(LeftStr(cdsRED_EFIR34.FieldByName(INICAM + 'PARTOT').AsString, 2)));

      FListaRegistros034.Add(cdsRED_EFIR34.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                             cdsRED_EFIR34.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                             LeftStr(cdsRED_EFIR34.FieldByName(INICAM + 'PARTOT').AsString, 2) + '-' +
                             cdsRED_EFIR34.FieldByName(INICAM + 'DTA_RV').AsString);

      If cdsRED_EVCR06.Locate(INICAM + 'NUM_PV;RED_NUM_RV;RED_DTA_RV',
                              VarArrayOf([cdsRED_EFIR34.FieldByName(INICAM + 'NUM_PV').AsString,
                                          cdsRED_EFIR34.FieldByName(INICAM + 'NUM_RV').AsString,
                                          cdsRED_EFIR34.FieldByName(INICAM + 'DTA_RV').AsDateTime]),[]) Then
      Begin
        cdsRED_EVCR08.Filter := INICAM + 'NUM_PV=' + QuotedStr(cdsRED_EVCR06.FieldByName(INICAM + 'NUM_PV').AsString) + ' AND ' +
                                INICAM + 'NUM_RV=' + QuotedStr(cdsRED_EVCR06.FieldByName(INICAM + 'NUM_RV').AsString) + ' AND ' +
                                INICAM + 'DTA_CV=' + QuotedStr(cdsRED_EVCR06.FieldByName(INICAM + 'DTA_RV').AsString);
        cdsRED_EVCR08.Filtered := True;

        cdsRED_EVCR08.First;

        blnSemReg := cdsRED_EVCR08.IsEmpty;

        While Not cdsRED_EVCR08.Eof Do
        Begin
          LRegistroRelatorio := TItensRelatorioCartoes.Create;

          FTextoInconsistencia := '';
          strNumNsu := TRedeCardFuncoes.fStrZero(Trim(RightStr(cdsRED_EVCR08.FieldByName(INICAM + 'NUM_CV').AsString, 14)), 14);
          strNumAut := cdsRED_EVCR08.FieldByName(INICAM + 'NUMAUT').AsString;
          dtaDtaCad := cdsRED_EFIR34.FieldByName(INICAM + 'DTA_RV').Value;
          strCodEmp := cdsRED_EFIR34.FieldByName('EMP_CODEMP').AsString;

          LValorBruto := cdsRED_EVCR08.FieldByName('RED_VAL_CV').AsFloat;
          LValorLiquido := cdsRED_EVCR08.FieldByName('RED_VALLIQ').AsFloat;
          If Not cdsRED_EFIR34.FieldByName('RED_TIPREG').AsString.Equals('034') Then
          Begin
            fltPerTot := cdsRED_EVCR08.FieldByName('RED_VALLIQ').Value /
                         cdsRED_EFIR34.FieldByName('RED_VALORI').Value;

            LValorLiquido := LValorLiquido * fltPerTot;
          End;

          {********************}
          {* NOVA CONCILIAÇÃO *}
          {*****************AJ*}
          blnBusca := fBuscaCartao(strNumAut,
                                   strNumNsu,
                                   strCodEmp,
                                   'A',
                                   dtaDtaCad);

          LChaveConciliacao := INICAM + 'CRE_' + cdsRED_EFIR34.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                               cdsRED_EFIR34.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                               FormatDateTime('yyyy-mm-dd', cdsRED_EFIR34.FieldByName('RED_DTA_RV').Value);

          If blnBusca Then
          Begin
            LRegistroRelatorio.CodigoBandeira := cdsBaiCar.FieldByName('CAR_CODBAN').AsString;

            fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsRED_EVCR08.FieldByName(INICAM + 'VAL_CV').AsFloat;
            LTolerancia := RetornaValorTolerancia(cdsRED_EFIR34.FieldByName('EMP_CODEMP').AsString);

            FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
            If fBetween(TRedeCardFuncoes.fFormataFloat(fltDifere, 2), -LTolerancia, LTolerancia) Then
            Begin
              FTextoInconsistencia := EmptyStr;

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                                            Not cdsRED_EFIR34.FieldByName('RED_TIPREG').AsString.Equals('034'),
                                            LRegistroRelatorio,
                                            LChaveConciliacao,
                                            cdsRED_EFIR34);
            End;

            ValidaCartaoMarcado(FTextoInconsistencia, LValorBruto, LRegistroRelatorio);
          End
          Else
          Begin
            //verifica se está cadastrado ou já foi baixado no período
            blnAutomatica := cdsRED_EFIR34.FieldByName('RED_CONCIL').Value = '1';
            FTextoInconsistencia := 'Cartão já foi baixado';

            cdsBaixad.First;
            blnBusca := fBuscaCartaoBaixado(strNumAut,
                                            strNumNsu,
                                            strCodEmp,
                                            'A',
                                            dtaDtaCad);
            If Not blnBusca Then
            Begin
              If Not RegistroCanceladoNoMesmoDia(cdsRED_EVCR08, LValorLiquido, cdsRED_EFIR34.FieldByName('RED_PARTOT').AsString) Then
                FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
            End;
          End;

          {Gerando registro do relatório}
          FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
          If Not FTextoInconsistencia.IsEmpty Then
          Begin
            LRegistroRelatorio.Descricao := FTextoInconsistencia;
            If Not FTextoInconsistencia.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
              LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
          End;
          LRegistroRelatorio.NomeArquivo := cdsRED_EFIR34.FieldByName('RED_NOMARQ').AsString;
          LRegistroRelatorio.CodigoEstabelecimento := cdsRED_EFIR34.FieldByName('RED_NUM_PV').AsString;
          LRegistroRelatorio.CodigoEmpresa := strCodEmp;
          LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumNsu, 14)), 14);
          LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumAut, 6)), 6);
          LRegistroRelatorio.ResumoVenda := cdsRED_EVCR08.FieldByName('RED_NUM_RV').AsString;
          LRegistroRelatorio.NumeroCartao := cdsRED_EVCR08.FieldByName('RED_NUMCAR').AsString;

          If LRegistroRelatorio.TipoCartao.IsEmpty Then
          Begin
            LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';
            If Not cdsRED_EFIR34.FieldByName('RED_TIPREG').AsString.Equals('034') Then
              LRegistroRelatorio.TipoCartao := 'ANTECIPAÇÃO';
          End;

          LRegistroRelatorio.Parcela := LeftStr(cdsRED_EFIR34.FieldByName('RED_PARTOT').AsString, 2);
          LRegistroRelatorio.TotalParcelas := RightStr(cdsRED_EFIR34.FieldByName('RED_PARTOT').AsString, 2);
          LRegistroRelatorio.DataPagamento := cdsRED_EFIR34.FieldByName('RED_DTALAN').AsDateTime;
          LRegistroRelatorio.DataVenda := dtaDtaCad;
          LRegistroRelatorio.DataVencimento := cdsRED_EFIR34.FieldByName('RED_DTALAN').AsDateTime;
          If Not cdsRED_EFIR34.FieldByName('RED_TIPREG').AsString.Equals('034') Then
            LRegistroRelatorio.DataVencimento := cdsRED_EFIR34.FieldByName('RED_DTAVEN').AsDateTime;

          LRegistroRelatorio.ValorBruto := LValorBruto;
          LRegistroRelatorio.ValorLiquido := LValorLiquido;

          LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

          FListaRegistrosRelatorio.Add(LRegistroRelatorio);

          If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
            GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

          cdsRED_EVCR08.Next;

        End;
      End
      Else If cdsRED_EVCR10.Locate(INICAM + 'NUM_PV;RED_NUM_RV;RED_DTA_RV',
                                   VarArrayOf([cdsRED_EFIR34.FieldByName(INICAM + 'NUM_PV').AsString,
                                               cdsRED_EFIR34.FieldByName(INICAM + 'NUM_RV').AsString,
                                               cdsRED_EFIR34.FieldByName(INICAM + 'DTA_RV').AsDateTime]),[]) Then
      Begin
        cdsRED_EVCR12.Filter := INICAM + 'NUM_PV=' + QuotedStr(cdsRED_EVCR10.FieldByName(INICAM + 'NUM_PV').AsString) + ' AND ' +
                                INICAM + 'NUM_RV=' + QuotedStr(cdsRED_EVCR10.FieldByName(INICAM + 'NUM_RV').AsString) + ' AND ' +
                                INICAM + 'DTA_CV=' + QuotedStr(cdsRED_EVCR10.FieldByName(INICAM + 'DTA_RV').AsString) + ' AND ' +
                                INICAM + 'QTDPAR>=' + LeftStr(cdsRED_EFIR34.FieldByName(INICAM + 'PARTOT').AsString, 2);

        cdsRED_EVCR12.Filtered := True;

        blnSemReg := cdsRED_EVCR12.IsEmpty;

        cdsRED_EVCR12.First;
        While Not cdsRED_EVCR12.Eof Do
        Begin
          LRegistroRelatorio := TItensRelatorioCartoes.Create;

          FTextoInconsistencia := '';
          strNumNsu := TRedeCardFuncoes.fStrZero(Trim(RightStr(cdsRED_EVCR12.FieldByName(INICAM + 'NUM_CV').AsString, 14)), 14);
          strNumAut := cdsRED_EVCR12.FieldByName(INICAM + 'NUMAUT').AsString;

          LChaveConciliacao := INICAM + 'CRE_' + cdsRED_EFIR34.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                               cdsRED_EFIR34.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                               FormatDateTime('yyyy-mm-dd', cdsRED_EFIR34.FieldByName('RED_DTA_RV').Value);

          LValorBruto := cdsRED_EVCR12.FieldByName(INICAM + 'VALPAR').Value;
          If cdsRED_EFIR34.FieldByName(INICAM + 'TIPREG').AsString.Equals('034') Then
          Begin
            fltPerTot := 100;
            If (cdsRED_EFIR34.FieldByName(INICAM + 'VALLAN').Value <> 0) Or
               ((Not cdsRED_EFIR34.FieldByName(INICAM + 'VALDEB').IsNull) And (cdsRED_EFIR34.FieldByName(INICAM + 'VALDEB').Value <> 0)) Then
              fltPerTot := (TRedeCardFuncoes.IIF(LParcela.Equals('A'),
                                                 cdsRED_EVCR12.FieldByName(INICAM + 'LIQPRI').Value,
                                                 cdsRED_EVCR12.FieldByName(INICAM + 'LIQDEM').Value)) /
                            (cdsRED_EFIR34.FieldByName(INICAM + 'VALLAN').Value +
                             cdsRED_EFIR34.FieldByName(INICAM + 'TOTGRA').Value +
                             TRedeCardFuncoes.IIF(cdsRED_EFIR34.FieldByName(INICAM + 'VALDEB').ISNULL,
                                                  0,
                                                  cdsRED_EFIR34.FieldByName(INICAM + 'VALDEB').Value));

            LValorLiquido := (cdsRED_EFIR34.FieldByName(INICAM + 'VALLAN').Value + cdsRED_EFIR34.FieldByName(INICAM + 'TOTGRA').Value + cdsRED_EFIR34.FieldByName(INICAM + 'VALDEB').Value) * fltPerTot;
          End
          Else
          Begin
            fltPerTot := (TRedeCardFuncoes.IIF(LParcela.Equals('A'),
                                               cdsRED_EVCR12.FieldByName(INICAM + 'LIQPRI').Value,
                                               cdsRED_EVCR12.FieldByName(INICAM + 'LIQDEM').Value)) /
                          cdsRED_EFIR34.FieldByName(INICAM + 'VALORI').Value;

            LValorLiquido := (cdsRED_EFIR34.FieldByName(INICAM + 'VALLAN').Value + cdsRED_EFIR34.FieldByName(INICAM + 'VALDEB').Value) * fltPerTot;
          End;

          dtaDtaCad := cdsRED_EFIR34.FieldByName(INICAM + 'DTA_RV').Value;
          strCodEmp := cdsRED_EFIR34.FieldByName('EMP_CODEMP').AsString;

          {********************}
          {* NOVA CONCILIAÇÃO *}
          {*****************AJ*}
          blnBusca := fBuscaCartao(strNumAut,
                                   strNumNsu,
                                   strCodEmp,
                                   LParcela,
                                   dtaDtaCad);

          If blnBusca Then
          Begin
            LRegistroRelatorio.CodigoBandeira := cdsBaiCar.FieldByName('CAR_CODBAN').AsString;

            fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsRED_EVCR12.FieldByName(INICAM + 'VALPAR').Value;

            LTolerancia := RetornaValorTolerancia(cdsRED_EFIR34.FieldByName('EMP_CODEMP').AsString);
            FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
            If fBetween(TRedeCardFuncoes.fFormataFloat(fltDifere, 2), -LTolerancia, LTolerancia) Then
            Begin
              FTextoInconsistencia := EmptyStr;

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                                            Not cdsRED_EFIR34.FieldByName('RED_TIPREG').AsString.Equals('034'),
                                            LRegistroRelatorio,
                                            LChaveConciliacao,
                                            cdsRED_EFIR34);
            End;

            ValidaCartaoMarcado(FTextoInconsistencia, LValorBruto, LRegistroRelatorio);
          End
          Else
          Begin
            //verifica se está cadastrado ou já foi baixado no período
            blnAutomatica := cdsRED_EFIR34.FieldByName(INICAM + 'CONCIL').Value = '1';
            FTextoInconsistencia := 'Cartão já foi baixado';
            cdsBaixad.First;
            blnBusca := fBuscaCartaoBaixado(strNumAut,
                                            strNumNsu,
                                            strCodEmp,
                                            LParcela,
                                            dtaDtaCad);
            If Not blnBusca Then
            Begin
              If Not RegistroCanceladoNoMesmoDia(cdsRED_EVCR12, LValorLiquido, cdsRED_EFIR34.FieldByName(INICAM + 'PARTOT').AsString) Then
                FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
            End;
          End;

          {Gerando registro do relatório}
          FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
          If Not FTextoInconsistencia.IsEmpty Then
          Begin
            LRegistroRelatorio.Descricao := FTextoInconsistencia;
            If Not FTextoInconsistencia.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
              LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
          End;
          LRegistroRelatorio.NomeArquivo := cdsRED_EFIR34.FieldByName('RED_NOMARQ').AsString;
          LRegistroRelatorio.CodigoEstabelecimento := cdsRED_EFIR34.FieldByName('RED_NUM_PV').AsString;
          LRegistroRelatorio.CodigoEmpresa := strCodEmp;
          LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumNsu, 14)), 14);
          LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumAut, 6)), 6);
          LRegistroRelatorio.ResumoVenda := cdsRED_EFIR34.FieldByName('RED_NUM_RV').AsString;
          LRegistroRelatorio.NumeroCartao := cdsRED_EVCR12.FieldByName('RED_NUMCCO').AsString;

          If LRegistroRelatorio.TipoCartao.IsEmpty Then
          Begin
            LRegistroRelatorio.TipoCartao := 'CRÉDITO PARCELADO';
            If Not cdsRED_EFIR34.FieldByName('RED_TIPREG').AsString.Equals('034') Then
              LRegistroRelatorio.TipoCartao := 'ANTECIPAÇÃO';
          End;

          LRegistroRelatorio.Parcela := LeftStr(cdsRED_EFIR34.FieldByName('RED_PARTOT').AsString, 2);
          LRegistroRelatorio.TotalParcelas := RightStr(cdsRED_EFIR34.FieldByName('RED_PARTOT').AsString, 2);
          LRegistroRelatorio.DataPagamento := cdsRED_EFIR34.FieldByName('RED_DTALAN').AsDateTime;
          LRegistroRelatorio.DataVenda := dtaDtaCad;
          LRegistroRelatorio.DataVencimento := cdsRED_EFIR34.FieldByName('RED_DTALAN').AsDateTime;
          If Not cdsRED_EFIR34.FieldByName('RED_TIPREG').AsString.Equals('034') Then
            LRegistroRelatorio.DataVencimento := cdsRED_EFIR34.FieldByName('RED_DTAVEN').AsDateTime;

          LRegistroRelatorio.ValorBruto := LValorBruto;
          LRegistroRelatorio.ValorLiquido := LValorLiquido;

          LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

          FListaRegistrosRelatorio.Add(LRegistroRelatorio);

          If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
            GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

          cdsRED_EVCR12.Next;

        End;

      End
      Else
        blnSemReg := True;

      If blnSemReg Then
      Begin
        If Not cdsRED_EFIR34.FieldByName(INICAM + 'TIPREG').AsString.Equals('045') Then
        Begin
          LRegistroRelatorio := TItensRelatorioCartoes.Create;

          LRegistroRelatorio.NomeArquivo := cdsRED_EFIR34.FieldByName('RED_NOMARQ').AsString;
          LRegistroRelatorio.TipoDoRegistro := 'FALTANDO';
          LRegistroRelatorio.Descricao := 'Arquivo faltando registros de venda';
          LRegistroRelatorio.CodigoEstabelecimento := cdsRED_EFIR34.FieldByName('RED_NUM_PV').AsString;
          LRegistroRelatorio.ResumoVenda := cdsRED_EFIR34.FieldByName('RED_NUM_RV').AsString;
          LRegistroRelatorio.DataVenda := cdsRED_EFIR34.FieldByName('RED_DTA_RV').AsDateTime;
          LRegistroRelatorio.DataPagamento := cdsRED_EFIR34.FieldByName('RED_DTALAN').AsDateTime;
          LRegistroRelatorio.ValorLiquido := cdsRED_EFIR34.FieldByName('RED_VALLAN').AsFloat;
          LRegistroRelatorio.ValorBruto := cdsRED_EFIR34.FieldByName('RED_VALLAN').AsFloat;
          LRegistroRelatorio.Parcela := LeftStr(cdsRED_EFIR34.FieldByName('RED_PARTOT').AsString, 2);
          LRegistroRelatorio.TotalParcelas := RightStr(cdsRED_EFIR34.FieldByName('RED_PARTOT').AsString, 2);
          LRegistroRelatorio.RegistroIncompleto := 'S';

          FListaRegistrosRelatorio.Add(LRegistroRelatorio);
        End;
      End;

      cdsRED_EFIR34.Next;
    End;
    
    Result := True;

  Except
    Raise;
  End;

end;

function TConcilRedeCard.fProcessaDebitoRede(pgbStatus: TcxProgressBar): Boolean;
  Var
    fltDifere  : Double;
    strParcel  : String;
    blnBusca   : Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LChaveConciliacao: String;
begin
  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsRED_EVDR05.RecordCount;

    cdsRED_EVDR05.First;

    strParcel := 'A';

    objConcil.strChavePrimaria := EmptyStr;

    While Not cdsRED_EVDR05.Eof Do
    Begin
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      Application.ProcessMessages;

      LChaveConciliacao := INICAM + 'DEB_' + cdsRED_EVDR05.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                           cdsRED_EVDR05.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                           FormatDateTime('yyyy-mm-dd', cdsRED_EVDR05.FieldByName(INICAM + 'DTA_CV').Value);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      {********************}
      {* NOVA CONCILIAÇÃO *}
      {*****************AJ*}
      blnBusca := fBuscaCartao(cdsRED_EVDR05.FieldByName(INICAM + 'CODAUT').AsString,
                               TRedeCardFuncoes.fStrZero(Trim(RightStr(cdsRED_EVDR05.FieldByName(INICAM + 'NUM_CV').Value, 14)), 14),
                               cdsRED_EVDR05.FieldByName('EMP_CODEMP').AsString,
                               strParcel,
                               cdsRED_EVDR05.FieldByName(INICAM + 'DTA_CV').Value);

      If blnBusca Then
      Begin
        LRegistroRelatorio.CodigoBandeira := cdsBaiCar.FieldByName('CAR_CODBAN').AsString;

        fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsRED_EVDR05.FieldByName(INICAM + 'VALBRU').AsFloat;
        LTolerancia := RetornaValorTolerancia(cdsRED_EVDR05.FieldByName('EMP_CODEMP').AsString);

        If fBetween(fltDifere, -LTolerancia, LTolerancia) Then
        Begin
          MarcarCartaoEncontradoArquivo(cdsRED_EVDR05.FieldByName(INICAM + 'VALLIQ').Value,
                                        False,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsRED_EVDR05);
        End
        Else
          FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';

        ValidaCartaoMarcado(FTextoInconsistencia, cdsRED_EVDR05.FieldByName(INICAM + 'VALBRU').AsFloat, LRegistroRelatorio);
      End
      Else
      Begin
        FTextoInconsistencia := 'Cartão já foi baixado';

        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixado(cdsRED_EVDR05.FieldByName(INICAM + 'CODAUT').AsString,
                                        TRedeCardFuncoes.fStrZero(Trim(RightStr(cdsRED_EVDR05.FieldByName(INICAM + 'NUM_CV').Value, 14)), 14),
                                        cdsRED_EVDR05.FieldByName('EMP_CODEMP').AsString,
                                        strParcel,
                                        cdsRED_EVDR05.FieldByName(INICAM + 'DTA_CV').Value);
        If Not blnBusca Then
          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        If Not FTextoInconsistencia.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := cdsRED_EVDR05.FieldByName('RED_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsRED_EVDR05.FieldByName('RED_NUM_PV').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsRED_EVDR05.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(Trim(RightStr(cdsRED_EVDR05.FieldByName('RED_NUM_CV').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := cdsRED_EVDR05.FieldByName('RED_CODAUT').AsString;
      LRegistroRelatorio.ResumoVenda := cdsRED_EVDR05.FieldByName('RED_NUM_RV').AsString;
      LRegistroRelatorio.NumeroCartao := cdsRED_EVDR05.FieldByName('RED_NUMCAR').AsString;

      If LRegistroRelatorio.TipoCartao.IsEmpty Then
        LRegistroRelatorio.TipoCartao := 'DÉBITO';

      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.DataPagamento := cdsRED_EVDR05.FieldByName('RED_DTACRE').AsDateTime;
      LRegistroRelatorio.DataVenda := cdsRED_EVDR05.FieldByName('RED_DTA_CV').AsDateTime;
      LRegistroRelatorio.DataVencimento := cdsRED_EVDR05.FieldByName('RED_DTACRE').AsDateTime;

      LRegistroRelatorio.ValorBruto := cdsRED_EVDR05.FieldByName('RED_VALBRU').AsFloat;
      LRegistroRelatorio.ValorLiquido := cdsRED_EVDR05.FieldByName('RED_VALLIQ').AsFloat;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsRED_EVDR05.Next;
    End;

    Result := True;
  Except
    Raise;
  End;

end;


{****************************************}
{* GERA UM RELATORIO DE INCONSISTÊNCIAS *}
{* DE RVS FALTANDO ARQUIVOS IMPORTADOS  *}
{*************************************AJ*}
function TConcilRedeCard.fRelatPreConciliacao: Boolean;
  Var
    strSQL   : String;
    qryGenCon: TUniQuery;
begin
  //Atualiza importados
  VS_FuncoesExternas.fIStartTransaction;
  Application.ProcessMessages;

  qryGenCon := Nil;
  Try
    Try
      qryGenCon := VS_FuncoesExternas.fICriaQuery;
      qryGenCon.Close;
      qryGenCon.SQL.Text := 'UPDATE RED_EFIR34 A SET RED_IMPTOT=1 WHERE ' +
                            ' A.RED_IMPTOT = 0 AND A.RED_DTALAN BETWEEN :DTAINI AND :DTAFIM AND ' +
                            '(((SELECT COUNT(*) FROM RED_EVCR10 B WHERE ' +
                            ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                            ' B.RED_DTA_RV=A.RED_DTA_RV) > 0) AND ' +
                            '((SELECT COUNT(*) FROM RED_EVCR12 B WHERE ' +
                            ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                            ' B.RED_DTA_CV=A.RED_DTA_RV) > 0)) ';
      qryGenCon.ParamByName('DTAINI').AsString := FormatDatetime('yyyy-mm-dd', dtaDtaIni);
      qryGenCon.ParamByName('DTAFIM').AsString := FormatDatetime('yyyy-mm-dd', dtaDtaFim);
      qryGenCon.ExecSQL;

      qryGenCon.Close;
      qryGenCon.SQL.Text := 'UPDATE RED_EFIR34 A SET RED_IMPTOT=1 WHERE ' +
                            ' A.RED_IMPTOT = 0 AND A.RED_DTALAN BETWEEN :DTAINI AND :DTAFIM AND ' +
                            '(((SELECT COUNT(*) FROM RED_EVCR06 B WHERE ' +
                            ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                            ' B.RED_DTA_RV=A.RED_DTA_RV) > 0) AND ' +
                            '((SELECT COUNT(*) FROM RED_EVCR08 B WHERE ' +
                            ' B.RED_NUM_PV=A.RED_NUM_PV AND B.RED_NUM_RV=A.RED_NUM_RV AND ' +
                            ' B.RED_DTA_CV=A.RED_DTA_RV) > 0)) ';

      qryGenCon.ParamByName('DTAINI').AsString := FormatDatetime('yyyy-mm-dd', dtaDtaIni);
      qryGenCon.ParamByName('DTAFIM').AsString := FormatDatetime('yyyy-mm-dd', dtaDtaFim);
      qryGenCon.ExecSQL;

      Application.ProcessMessages;

      VS_FuncoesExternas.fICommit;
    Except
      VS_FuncoesExternas.fIRollBack;
    End;
    Application.ProcessMessages;

    //Verifica se possuir arquivos não importados
    strSQL := '';
    strSQL := strSQL + 'SELECT RED_NUM_PV AS NUM_PV, RED_NUM_RV AS NUM_RV, ';
    strSQL := strSQL + ' RED_DTA_RV AS DTA_CV, RED_VALLAN AS VALORI, ';
    strSQL := strSQL + ' "ARQUIVOS COM INCONSISTÊNCIA" AS DESCRI, ';
    strSQL := strSQL + ' RED_NOMARQ AS NOMARQ, RED_PARTOT AS PARCEL FROM RED_EFIR34 ';
    strSQL := strSQL + ' LEFT JOIN CFGSIS ON LOCATE(RED_NUM_PV, SIS_VALCFG) > 0    ';
    strSQL := strSQL + ' AND SIS_CODCFG IN ("CFG_REDEST","CFG_REDECO")              ';
    strSQL := strSQL + ' LEFT JOIN CADEMP ON EMP_CODEMP = SIS_CODEMP ';
    strSQL := strSQL + ' WHERE RED_DTALAN BETWEEN :DTAINI AND :DTAFIM ';
    strSQL := strSQL + ' AND RED_IMPTOT=0 AND RED_TIPREG NOT IN ("045", "035", "047") ';
    strSQL := strSQL + fRetPesqPonVen(0);
    strSQL := strSQL + ' UNION ';
    strSQL := strSQL + 'SELECT R34.RED_NUM_PV AS NUM_PV, R34.RED_NUM_RV AS NUM_RV, ';
    strSQL := strSQL + ' R34.RED_DTA_RV AS DTA_CV, R34.RED_VALLAN AS VALORI, ';
    strSQL := strSQL + ' "ARQUIVOS COM INCONSISTÊNCIA" AS DESCRI, ';
    strSQL := strSQL + ' R34.RED_NOMARQ AS NOMARQ, "" AS PARCEL ';
    strSQL := strSQL + ' FROM RED_EFIR34 R34 ';
    strSQL := strSQL + ' JOIN RED_EVCR10 R10 ON R10.RED_NUM_PV=R34.RED_NUM_PV ';
    strSQL := strSQL + '         AND R10.RED_NUM_RV=R34.RED_NUM_RV ';
    strSQL := strSQL + '         AND R10.RED_DTA_RV=R34.RED_DTA_RV ';
    strSQL := strSQL + ' LEFT JOIN CFGSIS ON LOCATE(R34.RED_NUM_PV, SIS_VALCFG) > 0 ';
    strSQL := strSQL + ' AND SIS_CODCFG IN ("CFG_REDEST","CFG_REDECO")               ';
    strSQL := strSQL + ' LEFT JOIN CADEMP ON EMP_CODEMP = SIS_CODEMP ';
    strSQL := strSQL + ' LEFT JOIN RED_EVCR14 R14 ON R14.RED_NUM_PV=R34.RED_NUM_PV ';
    strSQL := strSQL + '         AND R14.RED_NUM_RV=R34.RED_NUM_RV ';
    strSQL := strSQL + '         AND R14.RED_DTA_RV=R34.RED_DTA_RV ';
    strSQL := strSQL + '         AND R14.RED_DTACRE=R34.RED_DTALAN ';
    strSQL := strSQL + ' WHERE R34.RED_DTALAN BETWEEN :DTAINI AND :DTAFIM ';
    strSQL := strSQL + ' AND R34.RED_TIPREG = "046" AND ';
    strSQL := strSQL + '     R14.RED_NUM_PV IS NULL ';
    strSQL := strSQL + ' GROUP BY R34.RED_NUM_PV, R34.RED_DTA_RV, R34.RED_NUM_RV';
    strSQL := strSQL + StringReplace(fRetPesqPonVen(0), 'RED_NUM_PV', 'R34.RED_NUM_PV', [rfReplaceAll]);
    strSQL := strSQL + ' ORDER BY DTA_CV,NUM_PV, NUM_RV';

    qryGenCon.Close;
    qryGenCon.SQL.Text := strSQL;
    qryGenCon.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    qryGenCon.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    qryGenCon.Open;
    Application.ProcessMessages;
    Result := Not qryGenCon.IsEmpty;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryGenCon);
  End;

  If Result Then
  Begin
    TRedeCardFuncoes.fMensagem('ATENÇÃO', 'Existem registros sem importar no período selecionado.', ['&Ok']);

    VS_FuncoesExternas.prcIExecutaRelatorio(468,
                                            33625,
                                            [],
                                            ['DTAINI', 'DTAFIN', 'LISTA_PV'],
                                            [FormatDateTime('dd/mm/yyyy', dtaDtaIni),
                                             FormatDateTime('dd/mm/yyyy', dtaDtaFim),
                                             RetornaListaPVsParaFiltroLocate],
                                            Nil,
                                            Nil,
                                            True);
  End;
end;

procedure TConcilRedeCard.GeraListaDatasDeRVsSelecionadosRegistro046;
begin
  If Assigned(FListaDatasRVs046) Then
    FreeAndNil(FListaDatasRVs046);
  FListaDatasRVs046 := TStringList.Create;

  FRegistro046.IndexFieldNames := 'RED_DTA_RV';

  FRegistro046.First;
  While Not FRegistro046.Eof Do
  Begin
    If FListaDatasRVs046.IndexOf(FormatDateTime('yyyy/mm/dd', FRegistro046.FieldByName('RED_DTA_RV').AsDateTime)) = -1 Then
      FListaDatasRVs046.Add(FormatDateTime('yyyy/mm/dd', FRegistro046.FieldByName('RED_DTA_RV').AsDateTime));

    FRegistro046.Next;
  End;

  FRegistro046.IndexFieldNames := '';
  FRegistro046.First;
end;

procedure TConcilRedeCard.pCriaClientRED_EFIR34;
  Var
    qryRED_EFIR34: TUniQuery;
    strSQL       : String;
begin
  qryRED_EFIR34 := Nil;
  Try
    qryRED_EFIR34 := VS_FuncoesExternas.fICriaQuery;
    
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE                                    ';
    strSQL := strSQL + '   RED_TIPREG,                                          ';
    strSQL := strSQL + '   RED_NUM_PV,                                          ';
    strSQL := strSQL + '   RED_NUM_RV,                                          ';
    strSQL := strSQL + '   RED_DTA_RV,                                          ';
    strSQL := strSQL + '   RED_VALLAN,                                          ';
    strSQL := strSQL + '   RED_VALDES,                                          ';
    strSQL := strSQL + '   RED_PARTOT,                                          ';
    strSQL := strSQL + '   RED_VALBRU,                                          ';
    strSQL := strSQL + '   RED_DTALAN,                                          ';
    strSQL := strSQL + '   RED_DTAMOV,                                          ';
    strSQL := strSQL + '   RED_STSCRE,                                          ';
    strSQL := strSQL + '   RED_VALORI,                                          ';
    strSQL := strSQL + '   RED_DTAVEN,                                          ';
    strSQL := strSQL + '   RED_NOMARQ,                                          ';
    strSQL := strSQL + '   RED_CARDEB,                                          ';
    strSQL := strSQL + '   RED_VALDEB,                                          ';
    strSQL := strSQL + '   RED_AUTDEB,                                          ';
    strSQL := strSQL + '   RED_REGDEB,                                          ';
    strSQL := strSQL + '   RED_NSUDEB,                                          ';
    strSQL := strSQL + '   RED_PARCEL,                                          ';
    strSQL := strSQL + '   RED_MOTAJU,                                          ';
    strSQL := strSQL + '   EMP_CODEMP,                                          ';
    strSQL := strSQL + '   EMP_NOMEMP,                                          ';
    strSQL := strSQL + '   RED_CONCIL,                                          ';
    strSQL := strSQL + '   RED_NUM_OC,                                          ';
    strSQL := strSQL + '   CAST(IF(COALESCE(RED_VALORI, 0) = 0, 0,              ';
    strSQL := strSQL + '   (RED_VALORI - RED_VALLAN) / RED_VALORI)              ';
    strSQL := strSQL + '   AS DECIMAL(15,2)) AS PERANT,                         ';
    strSQL := strSQL + RetornaSQLTotalGravameRegistro034;
    strSQL := strSQL + ' FROM                                                   ';
    strSQL := strSQL + '    RED_EFIR34                                          ';
    strSQL := strSQL + ' LEFT JOIN CFGSIS ON LOCATE(RED_NUM_PV, SIS_VALCFG) > 0 ';
    strSQL := strSQL + ' AND SIS_CODCFG IN ("CFG_REDEST","CFG_REDECO")          ';
    strSQL := strSQL + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP              ';
    strSQL := strSQL + ' WHERE                                                  ';
    strSQL := strSQL + '   RED_DTALAN BETWEEN :DTAINI AND :DTAFIM AND           ';
    strSQL := strSQL + '   RED_TIPREG NOT IN ("035", "045", "046", "047") AND   ';
    strSQL := strSQL + '   (RED_STSCRE IN ("00","01","02","03","04","05","06","07","08", "") OR ';
    strSQL := strSQL + '    RED_STSCRE IS NULL) AND                             ';
    strSQL := strSQL + '   RED_VALLAN + RED_VALDEB <> 0                         ';
    strSQL := strSQL + fRetPesqPonVen(0);

    qryRED_EFIR34.SQL.Text := strSQL;
    qryRED_EFIR34.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    qryRED_EFIR34.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    qryRED_EFIR34.Open;

    cdsRED_EFIR34 := TRedeCardFuncoes.CriarClientDataSet(qryRED_EFIR34);
    cdsRED_EFIR34.Open;

    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryRED_EFIR34);
  End;
end;

procedure TConcilRedeCard.pCriaClientRED_EVCR06;
  Var
    qryRED_EVCR06: TUniQuery;
    strSQL       : String;
begin
  qryRED_EVCR06 :=Nil;
  Try
    qryRED_EVCR06 := VS_FuncoesExternas.fICriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   RED_NUM_PV,       ';
    strSQL := strSQL + '   RED_NUM_RV,       ';
    strSQL := strSQL + '   RED_DTA_RV,       ';
    strSQL := strSQL + '   RED_VALLIQ,       ';
    strSQL := strSQL + '   RED_VALDES,       ';
    strSQL := strSQL + '   RED_VALBRU,       ';
    strSQL := strSQL + '   RED_DTACRE        ';
    strSQL := strSQL + ' FROM                ';
    strSQL := strSQL + '   RED_EVCR06        ';
    strSQL := strSQL + ' WHERE               ';
    strSQL := strSQL + '   RED_DTA_RV BETWEEN :DTAINI AND :DTAFIM ';

    qryRED_EVCR06.SQL.Text := strSQL;
    qryRED_EVCR06.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryRED_EVCR06.ParamByName('DTAFIM').AsDate := dtaDtaFim;
    qryRED_EVCR06.Open;

    cdsRED_EVCR06 := TRedeCardFuncoes.CriarClientDataSet(qryRED_EVCR06);
    cdsRED_EVCR06.Open;

    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryRED_EVCR06);
  End;
end;

procedure TConcilRedeCard.pCriaClientRED_EVCR08;
  Var
    qryRED_EVCR08: TUniQuery;
    strSQL       : String;
begin
  qryRED_EVCR08 := Nil;
  Try
    qryRED_EVCR08 := VS_FuncoesExternas.fICriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '        RED_NUM_PV,  ';
    strSQL := strSQL + '        RED_NUM_RV,  ';
    strSQL := strSQL + '        RED_DTA_CV,  ';
    strSQL := strSQL + '        RED_VAL_CV,  ';
    strSQL := strSQL + '        RED_VALGER,  ';
    strSQL := strSQL + '        RED_NUMCAR,  ';
    strSQL := strSQL + '        RED_STS_CV,  ';
    strSQL := strSQL + '        RED_NUM_CV,  ';
    strSQL := strSQL + '        RED_VALDES,  ';
    strSQL := strSQL + '        RED_NUMAUT,  ';
    strSQL := strSQL + '        RED_VALLIQ   ';
    strSQL := strSQL + ' FROM                ';
    strSQL := strSQL + '    RED_EVCR08       ';
    strSQL := strSQL + ' WHERE               ';
    strSQL := strSQL + '   RED_DTA_CV BETWEEN :DTAINI AND :DTAFIM ';

    qryRED_EVCR08.SQL.Text := strSQL;
    qryRED_EVCR08.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryRED_EVCR08.ParamByName('DTAFIM').AsDate := dtaDtaFim;
    qryRED_EVCR08.Open;

    cdsRED_EVCR08 := TRedeCardFuncoes.CriarClientDataSet(qryRED_EVCR08);
    cdsRED_EVCR08.Open;

    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryRED_EVCR08);
  End;
end;

procedure TConcilRedeCard.pCriaClientRED_EVCR10;
  Var
    qryRED_EVCR10: TUniQuery;
    strSQL       : String;
begin
  qryRED_EVCR10 := Nil;
  Try
    qryRED_EVCR10 := VS_FuncoesExternas.fICriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE          ';
    strSQL := strSQL + '   RED_NUM_PV,                ';
    strSQL := strSQL + '   RED_NUM_RV,                ';
    strSQL := strSQL + '   RED_DTA_RV,                ';
    strSQL := strSQL + '   RED_VALLIQ,                ';
    strSQL := strSQL + '   RED_VALDES,                ';
    strSQL := strSQL + '   RED_VALBRU,                ';
    strSQL := strSQL + '   RED_DTACRE                 ';
    strSQL := strSQL + ' FROM                         ';
    strSQL := strSQL + '    RED_EVCR10                ';
    strSQL := strSQL + ' WHERE                        ';
    strSQL := strSQL + '   RED_DTA_RV BETWEEN :DTAINI AND :DTAFIM ';

    qryRED_EVCR10.SQL.Text := strSQL;
    qryRED_EVCR10.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryRED_EVCR10.ParamByName('DTAFIM').AsDate := dtaDtaFim;
    qryRED_EVCR10.Open;

    cdsRED_EVCR10 := TRedeCardFuncoes.CriarClientDataSet(qryRED_EVCR10);
    cdsRED_EVCR10.Open;

    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryRED_EVCR10);
  End;
end;

procedure TConcilRedeCard.pCriaClientRED_EVCR12;
  Var
    qryRED_EVCR12: TUniQuery;
    strSQL       : String;
begin
  qryRED_EVCR12 := Nil;
  Try
    qryRED_EVCR12 := VS_FuncoesExternas.fICriaQuery;
    
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '        RED_NUM_PV,  ';
    strSQL := strSQL + '        RED_NUM_RV,  ';
    strSQL := strSQL + '        RED_DTA_CV,  ';
    strSQL := strSQL + '        RED_VAL_CV,  ';
    strSQL := strSQL + '  RED_VAL_CV / (RED_QTDPAR * 1) AS RED_VALPAR,  ';
    strSQL := strSQL + '  (RED_QTDPAR * 1) AS RED_QTDPAR,  ';
    strSQL := strSQL + '  RED_QTDPAR AS RED_TOTPAR, ';
    strSQL := strSQL + '        RED_VALGOR,  ';
    strSQL := strSQL + '        RED_STS_CV,  ';
    strSQL := strSQL + '        RED_NUM_CV,  ';
    strSQL := strSQL + '        RED_NUMCCO,  ';
    strSQL := strSQL + '        RED_VALDES,  ';
    strSQL := strSQL + '        RED_NUMAUT,  ';
    strSQL := strSQL + '        RED_VALLIQ,  ';
    strSQL := strSQL + '        RED_LIQPRI,  ';
    strSQL := strSQL + '        RED_LIQDEM   ';
    strSQL := strSQL + ' FROM                ';
    strSQL := strSQL + '    RED_EVCR12       ';
    strSQL := strSQL + ' WHERE               ';
    strSQL := strSQL + '   RED_DTA_CV BETWEEN :DTAINI AND :DTAFIM ';

    qryRED_EVCR12.SQL.Text := strSQL;
    qryRED_EVCR12.ParamByName('DTAINI').AsDate := dtaDtaIni;
    qryRED_EVCR12.ParamByName('DTAFIM').AsDate := dtaDtaFim;
    qryRED_EVCR12.Open;

    cdsRED_EVCR12 := TRedeCardFuncoes.CriarClientDataSet(qryRED_EVCR12);
    cdsRED_EVCR12.Open;

    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryRED_EVCR12);
  End;
end;

procedure TConcilRedeCard.pCriaClientRED_EVCR14;
  Var
    LRED_EVCR14: TUniQuery;

    LSQL,
    LData,
    LDatasIn: String;
begin
  LRED_EVCR14 := Nil;
  Try
    LRED_EVCR14 := VS_FuncoesExternas.fICriaQuery;

    LDatasIn := '';
    For LData in FListaDatasRVs046 Do
      LDatasIn := LDatasIn + '"' + LData + '",';

    If FListaDatasRVs046.Count > 0 Then
      LDatasIn := LeftStr(LDatasIn, LDatasIn.Length - 1)
    Else
      LDatasIn := '""';

    LSQL := '';
    LSQL := LSQL + ' SELECT SQL_NO_CACHE ';
    LSQL := LSQL + '        RED_NUM_PV,  ';
    LSQL := LSQL + '        RED_NUM_RV,  ';
    LSQL := LSQL + '        RED_DTA_RV,  ';
    LSQL := LSQL + '        RED_QTDPAR,  ';
    LSQL := LSQL + '        RED_VALBRU,  ';
    LSQL := LSQL + '        RED_VALDES,  ';
    LSQL := LSQL + '        RED_VALLIQ,  ';
    LSQL := LSQL + '        RED_DTACRE   ';
    LSQL := LSQL + ' FROM                ';
    LSQL := LSQL + '    RED_EVCR14       ';
    LSQL := LSQL + ' WHERE               ';
    LSQL := LSQL + '   RED_DTA_RV IN (' + LDatasIn + ')';
    LSQL := LSQL + ' ORDER BY            ';
    LSQL := LSQL + '   RED_NUM_PV,       ';
    LSQL := LSQL + '   RED_NUM_RV,       ';
    LSQL := LSQL + '   RED_DTA_RV,       ';
    LSQL := LSQL + '   RED_QTDPAR        ';

    LRED_EVCR14.SQL.Text := LSQL;
    LRED_EVCR14.Open;

    cdsRED_EVCR14 := TRedeCardFuncoes.CriarClientDataSet(LRED_EVCR14);
    cdsRED_EVCR14.Open;

    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LRED_EVCR14);
  End;
end;

procedure TConcilRedeCard.pCriaClientRED_EVDR05;
  Var
    qryRED_EVDR05: TUniQuery;
    strSQL       : String;
begin
  qryRED_EVDR05 := Nil;
  Try
    qryRED_EVDR05 := VS_FuncoesExternas.fICriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   RED_TIPREG,       ';
    strSQL := strSQL + '   RED_NUM_PV,       ';
    strSQL := strSQL + '   RED_NUM_RV,       ';
    strSQL := strSQL + '   RED_DTA_CV,       ';
    strSQL := strSQL + '   RED_VALBRU,       ';
    strSQL := strSQL + '   RED_VALDES,       ';
    strSQL := strSQL + '   RED_VALLIQ,       ';
    strSQL := strSQL + '   RED_NUMCAR,       ';
    strSQL := strSQL + '   RED_TIPTRA,       ';
    strSQL := strSQL + '   RED_NUM_CV,       ';
    strSQL := strSQL + '   RED_DTACRE,       ';
    strSQL := strSQL + '   RED_STSTRA,       ';
    strSQL := strSQL + '   RED_HRATRA,       ';
    strSQL := strSQL + '   RED_NUMTER,       ';
    strSQL := strSQL + '   RED_TIPCAP,       ';
    strSQL := strSQL + '   RED_NUMRES,       ';
    strSQL := strSQL + '   RED_VALCOM,       ';
    strSQL := strSQL + '   RED_VALSAQ,       ';
    strSQL := strSQL + '   RED_CODBAN,       ';
    strSQL := strSQL + '   RED_CODAUT,       ';
    strSQL := strSQL + '   RED_NOMARQ,       ';
    strSQL := strSQL + '   EMP_CODEMP,       ';
    strSQL := strSQL + '   EMP_NOMEMP,       ';
    strSQL := strSQL + '   RED_CONCIL        ';
    strSQL := strSQL + ' FROM                ';
    strSQL := strSQL + '    RED_EVDR05       ';
    strSQL := strSQL + ' LEFT JOIN CFGSIS ON LOCATE(RED_NUM_PV, SIS_VALCFG) > 0 ';
    strSQL := strSQL + ' AND SIS_CODCFG IN ("CFG_REDEST","CFG_REDECO")  ';
    strSQL := strSQL + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP   ';
    strSQL := strSQL + ' WHERE               ';
    strSQL := strSQL + '   RED_DTACRE BETWEEN :DTAINI AND :DTAFIM ';
    strSQL := strSQL + fRetPesqPonVen(0);

    qryRED_EVDR05.SQL.Text := strSQL;
    qryRED_EVDR05.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    qryRED_EVDR05.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    qryRED_EVDR05.Open;

    cdsRED_EVDR05 := TRedeCardFuncoes.CriarClientDataSet(qryRED_EVDR05);
    cdsRED_EVDR05.Open;
    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryRED_EVDR05);
  End;
end;

procedure TConcilRedeCard.pCriaClientRegistro046;
  Var
    LRegistro046: TUniQuery;

    LSQL: String;
begin
  LRegistro046 := Nil;
  Try
    LRegistro046 := VS_FuncoesExternas.fICriaQuery;

    LSQL := '';
    LSQL := LSQL + ' SELECT                                                 ';
    LSQL := LSQL + '   R.RED_TIPREG,                                          ';
    LSQL := LSQL + '   R.RED_NUM_PV,                                          ';
    LSQL := LSQL + '   R.RED_NUM_RV,                                          ';
    LSQL := LSQL + '   R.RED_DTA_RV,                                          ';
    LSQL := LSQL + '   SUM(R.RED_VALLAN) AS RED_VALLAN,                       ';
    LSQL := LSQL + '   R.RED_VALDES,                                          ';
    LSQL := LSQL + '   R.RED_VALBRU,                                          ';
    LSQL := LSQL + '   R.RED_DTALAN,                                          ';
    LSQL := LSQL + '   R.RED_DTAMOV,                                          ';
    LSQL := LSQL + '   R.RED_STSCRE,                                          ';
    LSQL := LSQL + '   R.RED_VALORI,                                          ';
    LSQL := LSQL + '   R.RED_DTAVEN,                                          ';
    LSQL := LSQL + '   R.RED_NOMARQ,                                          ';
    LSQL := LSQL + '   R.RED_CARDEB,                                          ';
    LSQL := LSQL + '   R.RED_VALDEB,                                          ';
    LSQL := LSQL + '   R.RED_AUTDEB,                                          ';
    LSQL := LSQL + '   R.RED_REGDEB,                                          ';
    LSQL := LSQL + '   R.RED_NSUDEB,                                          ';
    LSQL := LSQL + '   R.RED_PARCEL,                                          ';
    LSQL := LSQL + '   R.RED_MOTAJU,                                          ';
    LSQL := LSQL + '   R.RED_PARTOT,                                          ';
    LSQL := LSQL + '   R.RED_NUM_OC,                                          ';
    LSQL := LSQL + '   EMP_CODEMP,                                          ';
    LSQL := LSQL + '   EMP_NOMEMP,                                          ';
    LSQL := LSQL + '   R.RED_CONCIL,                                          ';
    LSQL := LSQL + '   CAST(IF(COALESCE(R.RED_VALORI, 0) = 0, 0,              ';
    LSQL := LSQL + '   (R.RED_VALORI - R.RED_VALLAN) / R.RED_VALORI)              ';
    LSQL := LSQL + '   AS DECIMAL(15,2)) AS PERANT                          ';
    LSQL := LSQL + ' FROM                                                   ';
    LSQL := LSQL + '    RED_EFIR34 R                                         ';
    LSQL := LSQL + ' LEFT JOIN CFGSIS ON LOCATE(R.RED_NUM_PV, SIS_VALCFG) > 0 ';
    LSQL := LSQL + ' AND SIS_CODCFG IN ("CFG_REDEST","CFG_REDECO")          ';
    LSQL := LSQL + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP              ';
    LSQL := LSQL + ' WHERE                                                  ';
    LSQL := LSQL + '   R.RED_DTALAN BETWEEN :DTAINI AND :DTAFIM AND           ';
    LSQL := LSQL + '   R.RED_TIPREG = "046"  AND                              ';
    LSQL := LSQL + '   (R.RED_STSCRE IN ("00","01","02","03","04","05","06","07","08", "") OR ';
    LSQL := LSQL + '    R.RED_STSCRE IS NULL)                                 ';
    LSQL := LSQL + fRetPesqPonVen(0);
    LSQL := LSQL + ' GROUP BY  R.RED_NUM_PV, R.RED_NUM_RV, R.RED_DTA_RV, R.RED_DTALAN ';

    LRegistro046.SQL.Text := LSQL;

    LRegistro046.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LRegistro046.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    LRegistro046.Open;

    FRegistro046 := TRedeCardFuncoes.CriarClientDataSet(LRegistro046);

    GeraListaDatasDeRVsSelecionadosRegistro046;

    Application.ProcessMessages;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(LRegistro046);
  End;
end;

function TConcilRedeCard.ProcessaPagamentosNegociacao(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    strNumNsu  : String;
    strCodEmp  : String;
    dtaDtaCad  : TDateTime;
    intLimpMem : Integer;
    fltPerTot  : Double;
    strNumAut  : String;
    blnBusca   : Boolean;
    blnSemReg  : Boolean;
    
    LDiferenca,
    LValorBruto,
    LValorLiquido: Double;

    LParcela,
    LChaveConciliacao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FRegistro046.RecordCount + 5;
    intLimpMem := 0;

    If Not Assigned(cdsRED_EVCR06) Then
    Begin
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      pCriaClientRED_EVCR06;
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      pCriaClientRED_EVCR08;
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      pCriaClientRED_EVCR10;
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      pCriaClientRED_EVCR12;
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
    End;

    objConcil.strChavePrimaria := 'RED_DTA_RV,RED_NUM_PV,RED_NUM_RV,RED_PARTOT,RED_TIPREG,RED_NUM_OC';

    pCriaClientRED_EVCR14;

    FRegistro046.First;

    While Not FRegistro046.Eof Do
    Begin
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      If intLimpMem >= 50 Then
      Begin
        VS_FuncoesExternas.pITrimAppMemorySize;
        intLimpMem := 0;
      End
      Else
        inc(intLimpMem);

      cdsRED_EVCR14.Filter := INICAM + 'NUM_PV=' + QuotedStr(FRegistro046.FieldByName(INICAM + 'NUM_PV').AsString) + ' AND ' +
                              INICAM + 'NUM_RV=' + QuotedStr(FRegistro046.FieldByName(INICAM + 'NUM_RV').AsString) + ' AND ' +
                              INICAM + 'DTA_RV=' + QuotedStr(FRegistro046.FieldByName(INICAM + 'DTA_RV').AsString) + ' AND ' +
                              INICAM + 'DTACRE=' + QuotedStr(FRegistro046.FieldByName(INICAM + 'DTALAN').AsString);
      cdsRED_EVCR14.Filtered := True;

      LParcela := cdsRED_EVCR14.FieldByName(INICAM + 'QTDPAR').AsString;

      blnSemReg := cdsRED_EVCR14.IsEmpty;

      If blnSemReg Then
      Begin
        If FListaRegistros034.IndexOf(FRegistro046.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                                      FRegistro046.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                                      '01-' +
                                      FRegistro046.FieldByName(INICAM + 'DTA_RV').AsString) >= 0 Then
        Begin
          FRegistro046.Next;
          Continue;
        End;

        FTextoInconsistencia := '';

        blnSemReg := Not cdsRED_EVCR06.Locate(INICAM + 'NUM_PV;RED_NUM_RV;RED_DTA_RV',
                                              VarArrayOf([FRegistro046.FieldByName(INICAM + 'NUM_PV').AsString,
                                                          FRegistro046.FieldByName(INICAM + 'NUM_RV').AsString,
                                                          FRegistro046.FieldByName(INICAM + 'DTA_RV').AsDateTime]),[]);
        If Not blnSemReg Then
        Begin
          cdsRED_EVCR08.Filter := INICAM + 'NUM_PV=' + QuotedStr(cdsRED_EVCR06.FieldByName(INICAM + 'NUM_PV').AsString) + ' AND ' +
                                  INICAM + 'NUM_RV=' + QuotedStr(cdsRED_EVCR06.FieldByName(INICAM + 'NUM_RV').AsString) + ' AND ' +
                                  INICAM + 'DTA_CV=' + QuotedStr(cdsRED_EVCR06.FieldByName(INICAM + 'DTA_RV').AsString);
          cdsRED_EVCR08.Filtered := True;

          cdsRED_EVCR08.First;

          blnSemReg := cdsRED_EVCR08.IsEmpty;

          While Not cdsRED_EVCR08.Eof Do
          Begin
            LRegistroRelatorio := TItensRelatorioCartoes.Create;
            LRegistroRelatorio.RegistroNegociacao := 'S';

            FTextoInconsistencia := '';

            strNumNsu := TRedeCardFuncoes.fStrZero(Trim(RightStr(cdsRED_EVCR08.FieldByName(INICAM + 'NUM_CV').AsString, 14)), 14);
            strNumAut := cdsRED_EVCR08.FieldByName(INICAM + 'NUMAUT').AsString;
            dtaDtaCad := FRegistro046.FieldByName(INICAM + 'DTA_RV').AsDateTime;
            strCodEmp := FRegistro046.FieldByName('EMP_CODEMP').AsString;

            LValorBruto := cdsRED_EVCR08.FieldByName('RED_VAL_CV').AsFloat;
            LValorLiquido := cdsRED_EVCR08.FieldByName('RED_VALLIQ').AsFloat;

            {********************}
            {* NOVA CONCILIAÇÃO *}
            {*****************AJ*}
            blnBusca := fBuscaCartao(strNumAut,
                                     strNumNsu,
                                     strCodEmp,
                                     'A',
                                     dtaDtaCad);

            LChaveConciliacao := INICAM + 'CRE_' + FRegistro046.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                                 FRegistro046.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                                 FormatDateTime('yyyy-mm-dd', FRegistro046.FieldByName('RED_DTA_RV').Value);

            If blnBusca Then
            Begin
              LRegistroRelatorio.CodigoBandeira := cdsBaiCar.FieldByName('CAR_CODBAN').AsString;

              LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsRED_EVCR08.FieldByName(INICAM + 'VAL_CV').AsFloat;
              LTolerancia := RetornaValorTolerancia(FRegistro046.FieldByName('EMP_CODEMP').AsString);

              If fBetween(LDiferenca, -LTolerancia, LTolerancia) Then
              Begin
                FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
                If fBetween(TRedeCardFuncoes.fFormataFloat(LDiferenca, 2), -LTolerancia, LTolerancia) Then
                Begin
                  FTextoInconsistencia := EmptyStr;

                  MarcarCartaoEncontradoArquivo(LValorLiquido,
                                                False,
                                                LRegistroRelatorio,
                                                LChaveConciliacao,
                                                FRegistro046);
                End;

                ValidaCartaoMarcado(FTextoInconsistencia, LValorBruto, LRegistroRelatorio);
              End
              Else
              Begin
                //verifica se está cadastrado ou já foi baixado no período
                blnAutomatica := FRegistro046.FieldByName(INICAM + 'CONCIL').Value = '1';

                cdsBaixad.First;
                blnBusca := fBuscaCartaoBaixado(strNumAut,
                                                strNumNsu,
                                                strCodEmp,
                                                'A',
                                                dtaDtaCad);

                FTextoInconsistencia := 'Cartão já foi baixado';
                If Not blnBusca Then
                  FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
              End;
            End
            Else
            Begin
              //verifica se está cadastrado ou já foi baixado no período
              blnAutomatica := FRegistro046.FieldByName(INICAM + 'CONCIL').Value = '1';

              cdsBaixad.First;
              blnBusca := fBuscaCartaoBaixado(strNumAut,
                                              strNumNsu,
                                              strCodEmp,
                                              'A',
                                              dtaDtaCad);

              FTextoInconsistencia := 'Cartão já foi baixado';
              If Not blnBusca Then
              Begin
                If Not RegistroCanceladoNoMesmoDia(cdsRED_EVCR08, LValorLiquido, '01/01') Then
                  FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
              End;
            End;

            {Gerando registro do relatório}
            FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
            If Not FTextoInconsistencia.IsEmpty Then
            Begin
              LRegistroRelatorio.Descricao := FTextoInconsistencia;
              If Not FTextoInconsistencia.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
                LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
            End;
            LRegistroRelatorio.NomeArquivo := FRegistro046.FieldByName('RED_NOMARQ').AsString;
            LRegistroRelatorio.CodigoEstabelecimento := FRegistro046.FieldByName('RED_NUM_PV').AsString;
            LRegistroRelatorio.CodigoEmpresa := strCodEmp;
            LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumNsu, 14)), 14);
            LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumAut, 6)), 6);
            LRegistroRelatorio.ResumoVenda := cdsRED_EVCR08.FieldByName('RED_NUM_RV').AsString;
            LRegistroRelatorio.NumeroCartao := cdsRED_EVCR08.FieldByName('RED_NUMCAR').AsString;
            LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';

            LRegistroRelatorio.Parcela := '01';
            LRegistroRelatorio.TotalParcelas := '01';
            LRegistroRelatorio.DataPagamento := FRegistro046.FieldByName('RED_DTALAN').AsDateTime;
            LRegistroRelatorio.DataVenda := dtaDtaCad;
            LRegistroRelatorio.DataVencimento := FRegistro046.FieldByName('RED_DTALAN').AsDateTime;

            LRegistroRelatorio.ValorBruto := LValorBruto;
            LRegistroRelatorio.ValorLiquido := LValorLiquido;

            LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

            FListaRegistrosRelatorio.Add(LRegistroRelatorio);

            If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
              GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

            cdsRED_EVCR08.Next;

          End;

        End;
      End
      Else If cdsRED_EVCR10.Locate(INICAM + 'NUM_PV;RED_NUM_RV;RED_DTA_RV',
                                VarArrayOf([FRegistro046.FieldByName(INICAM + 'NUM_PV').AsString,
                                            FRegistro046.FieldByName(INICAM + 'NUM_RV').AsString,
                                            FRegistro046.FieldByName(INICAM + 'DTA_RV').AsDateTime]),[]) Then
      Begin
        cdsRED_EVCR12.Filter := INICAM + 'NUM_PV=' + QuotedStr(cdsRED_EVCR10.FieldByName(INICAM + 'NUM_PV').AsString) + ' AND ' +
                                INICAM + 'NUM_RV=' + QuotedStr(cdsRED_EVCR10.FieldByName(INICAM + 'NUM_RV').AsString) + ' AND ' +
                                INICAM + 'DTA_CV=' + QuotedStr(cdsRED_EVCR10.FieldByName(INICAM + 'DTA_RV').AsString) + ' AND ' +
                                INICAM + 'QTDPAR>=' + LParcela;

        cdsRED_EVCR12.Filtered := True;

        blnSemReg := cdsRED_EVCR12.IsEmpty;

        cdsRED_EVCR12.First;

        While Not cdsRED_EVCR12.Eof Do
        Begin
          cdsRED_EVCR14.First;

          While Not cdsRED_EVCR14.Eof Do
          Begin
            LRegistroRelatorio := TItensRelatorioCartoes.Create;
            LRegistroRelatorio.RegistroNegociacao := 'S';

            FTextoInconsistencia := '';

            LParcela := cdsRED_EVCR14.FieldByName(INICAM + 'QTDPAR').AsString;

            If cdsRED_EVCR12.FieldByName('RED_QTDPAR').AsInteger < StrToInt(LParcela) Then
            Begin
              cdsRED_EVCR14.Next;
              Continue;
            End;

            If FListaRegistros034.IndexOf(FRegistro046.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                                          FRegistro046.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                                          LParcela + '-' +
                                          FRegistro046.FieldByName(INICAM + 'DTA_RV').AsString) >= 0 Then
            Begin
              cdsRED_EVCR14.Next;
              Continue;
            End;

            If Not LParcela.IsEmpty Then
              LParcela := TRedeCardFuncoes.fGetLetraAlfa(StrToInt(LParcela));

            strNumNsu := TRedeCardFuncoes.fStrZero(Trim(RightStr(cdsRED_EVCR12.FieldByName(INICAM + 'NUM_CV').AsString, 14)), 14);
            strNumAut := cdsRED_EVCR12.FieldByName(INICAM + 'NUMAUT').AsString;

            fltPerTot := cdsRED_EVCR12.FieldByName(INICAM + 'LIQPRI').AsFloat / FRegistro046.FieldByName(INICAM + 'VALLAN').AsFloat;
            If Not LParcela.Equals('A') Then
              fltPerTot := cdsRED_EVCR12.FieldByName(INICAM + 'LIQDEM').AsFloat / FRegistro046.FieldByName(INICAM + 'VALLAN').AsFloat;


            dtaDtaCad := FRegistro046.FieldByName(INICAM + 'DTA_RV').Value;
            strCodEmp := FRegistro046.FieldByName('EMP_CODEMP').AsString;

            LValorBruto := cdsRED_EVCR12.FieldByName(INICAM + 'VALPAR').AsFloat;
            LValorLiquido := TRedeCardFuncoes.fFormataFloat(FRegistro046.FieldByName(INICAM + 'VALLAN').AsFloat * fltPerTot, 2);

            LChaveConciliacao := INICAM + 'CRE_' + FRegistro046.FieldByName(INICAM + 'NUM_PV').AsString + '-' +
                                 FRegistro046.FieldByName(INICAM + 'NUM_RV').AsString + '-' +
                                 FormatDateTime('yyyy-mm-dd', FRegistro046.FieldByName('RED_DTA_RV').Value);

            {********************}
            {* NOVA CONCILIAÇÃO *}
            {*****************AJ*}
            blnBusca := fBuscaCartao(strNumAut,
                                     strNumNsu,
                                     strCodEmp,
                                     LParcela,
                                     dtaDtaCad);

            If blnBusca Then
            Begin
              LRegistroRelatorio.CodigoBandeira := cdsBaiCar.FieldByName('CAR_CODBAN').AsString;

              LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsRED_EVCR12.FieldByName(INICAM + 'VALPAR').AsFloat;
              LTolerancia := RetornaValorTolerancia(FRegistro046.FieldByName('EMP_CODEMP').AsString);

              If fBetween(TRedeCardFuncoes.fFormataFloat(LDiferenca, 2), -LTolerancia, LTolerancia) Then
              Begin
                FTextoInconsistencia := EmptyStr;

                MarcarCartaoEncontradoArquivo(LValorLiquido,
                                              False,
                                              LRegistroRelatorio,
                                              LChaveConciliacao,
                                              FRegistro046);

                ValidaCartaoMarcado(FTextoInconsistencia, LValorBruto, LRegistroRelatorio);
              End
              Else
              Begin
                //verifica se está cadastrado ou já foi baixado no período
                blnAutomatica := FRegistro046.FieldByName(INICAM + 'CONCIL').Value = '1';

                cdsBaixad.First;
                blnBusca := fBuscaCartaoBaixado(strNumAut,
                                                strNumNsu,
                                                strCodEmp,
                                                Lparcela,
                                                dtaDtaCad);

                FTextoInconsistencia := 'Cartão já foi baixado';
                If Not blnBusca Then
                  FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização/NSU duplicado';
              End;
            End
            Else
            Begin
              //verifica se está cadastrado ou já foi baixado no período
              blnAutomatica := FRegistro046.FieldByName(INICAM + 'CONCIL').Value = '1';

              cdsBaixad.First;
              blnBusca := fBuscaCartaoBaixado(strNumAut,
                                              strNumNsu,
                                              strCodEmp,
                                              LParcela,
                                              dtaDtaCad);

              FTextoInconsistencia := 'Cartão já foi baixado';
              If Not blnBusca Then
              Begin
                If Not RegistroCanceladoNoMesmoDia(cdsRED_EVCR12, LValorLiquido, LeftStr(cdsRED_EVCR14.FieldByName(INICAM + 'QTDPAR').AsString, 2) + '/' +
                                                                                     TRedeCardFuncoes.fPadL(cdsRED_EVCR12.FieldByName(INICAM + 'QTDPAR').AsString, 2, '0')) Then
                  FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
              End;

            End;

            {Gerando registro do relatório}
            FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
            If Not FTextoInconsistencia.IsEmpty Then
            Begin
              LRegistroRelatorio.Descricao := FTextoInconsistencia;
              If Not FTextoInconsistencia.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
                LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
            End;
            LRegistroRelatorio.NomeArquivo := FRegistro046.FieldByName('RED_NOMARQ').AsString;
            LRegistroRelatorio.CodigoEstabelecimento := FRegistro046.FieldByName('RED_NUM_PV').AsString;
            LRegistroRelatorio.CodigoEmpresa := strCodEmp;
            LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumNsu, 14)), 14);
            LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero(Trim(RightStr(strNumAut, 6)), 6);
            LRegistroRelatorio.ResumoVenda := FRegistro046.FieldByName('RED_NUM_RV').AsString;
            LRegistroRelatorio.NumeroCartao := cdsRED_EVCR12.FieldByName('RED_NUMCCO').AsString;
            LRegistroRelatorio.TipoCartao := 'CRÉDITO PARCELADO';

            LRegistroRelatorio.Parcela := TRedeCardFuncoes.fPadL(cdsRED_EVCR14.FieldByName('RED_QTDPAR').AsString, 2, '0');
            LRegistroRelatorio.TotalParcelas := TRedeCardFuncoes.fPadL(cdsRED_EVCR12.FieldByName('RED_QTDPAR').AsString, 2, '0');
            LRegistroRelatorio.DataPagamento := FRegistro046.FieldByName('RED_DTALAN').AsDateTime;
            LRegistroRelatorio.DataVenda := dtaDtaCad;
            LRegistroRelatorio.DataVencimento := FRegistro046.FieldByName('RED_DTALAN').AsDateTime;

            LRegistroRelatorio.ValorBruto := LValorBruto;
            LRegistroRelatorio.ValorLiquido := LValorLiquido;

            LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

            FListaRegistrosRelatorio.Add(LRegistroRelatorio);

            If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
              GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

            cdsRED_EVCR14.Next;
          End;

          cdsRED_EVCR12.Next;

        End;

      End
      Else
        blnSemReg := True;
      
      If blnSemReg Then
      Begin
        LRegistroRelatorio := TItensRelatorioCartoes.Create;
        LRegistroRelatorio.RegistroNegociacao := 'S';

        LRegistroRelatorio.NomeArquivo := FRegistro046.FieldByName('RED_NOMARQ').AsString;
        LRegistroRelatorio.TipoDoRegistro := 'FALTANDO';
        LRegistroRelatorio.Descricao := 'Arquivo faltando registros de venda';
        LRegistroRelatorio.CodigoEstabelecimento := FRegistro046.FieldByName('RED_NUM_PV').AsString;
        LRegistroRelatorio.ResumoVenda := FRegistro046.FieldByName('RED_NUM_RV').AsString;
        LRegistroRelatorio.DataVenda := FRegistro046.FieldByName('RED_DTA_RV').AsDateTime;
        LRegistroRelatorio.DataPagamento := FRegistro046.FieldByName('RED_DTALAN').AsDateTime;
        LRegistroRelatorio.ValorLiquido := FRegistro046.FieldByName('RED_VALLAN').AsFloat;
        LRegistroRelatorio.ValorBruto := FRegistro046.FieldByName('RED_VALLAN').AsFloat;
        LRegistroRelatorio.Parcela := LeftStr(FRegistro046.FieldByName('RED_PARTOT').AsString, 2);
        LRegistroRelatorio.TotalParcelas := RightStr(FRegistro046.FieldByName('RED_PARTOT').AsString, 2);
        LRegistroRelatorio.RegistroIncompleto := 'S';

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);
      End;

      FRegistro046.Next;
    End;

    Result := True;

  Except
    Raise;
  End;
end;

function TConcilRedeCard.RegistroCanceladoNoMesmoDia(ARegistro: TDataset; AValor: Double; AParcela: String): Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LEmpresaConfiguracao: String;
begin
  Result := False;

  If Not cdsAjustes.Locate('RED_NUM_PV;RED_NSUDEB;RED_PARTOT',
                           VarArrayOf([ARegistro.FieldByName('RED_NUM_PV').AsString,
                                       ARegistro.FieldByName('RED_NUM_CV').AsString,
                                       AParcela]),
                           []) Then
    Exit;


  LEmpresaConfiguracao := LeftStr(TRedeCardFuncoes.fCfgSisEmp('REDEST', cdsAjustes.FieldByName('RED_NUM_PV').AsString, True), 3);

  If LEmpresaConfiguracao.Trim.IsEmpty Then
    LEmpresaConfiguracao := LeftStr(TRedeCardFuncoes.fCfgSisEmp('REDECO', cdsAjustes.FieldByName('RED_NUM_PV').AsString), 3);

  LTolerancia := RetornaValorTolerancia(LEmpresaConfiguracao);

  Result := fBetween(TRedeCardFuncoes.fFormataFloat(TRedeCardFuncoes.fStrToFloat(cdsAjustes.FieldByName('RED_VALDEB').AsString), 2) + TRedeCardFuncoes.fFormataFloat(AValor, 2),
                     -LTolerancia, LTolerancia);

  If Result Then
  Begin
    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    LRegistroRelatorio.ValorBruto := cdsAjustes.FieldByName('RED_VALDEB').AsFloat * (-1);
    LRegistroRelatorio.ValorLiquido := cdsAjustes.FieldByName('RED_VALDEB').AsFloat * (-1);

    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
    LRegistroRelatorio.DescricaoAjuste := 'VENDA CANCELADA';

    LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
    LRegistroRelatorio.CodigoEstabelecimento := cdsAjustes.FieldByName('RED_NUM_PV').AsString;
    LRegistroRelatorio.NumeroNSU := TRedeCardFuncoes.fStrZero(cdsAjustes.FieldByName('RED_NSUDEB').AsString, 14);
    LRegistroRelatorio.NumeroCartao := cdsAjustes.FieldByName('RED_CARDEB').AsString;
    LRegistroRelatorio.Parcela := LeftStr(cdsAjustes.FieldByName('RED_PARTOT').AsString, 2);
    LRegistroRelatorio.TotalParcelas := RightStr(cdsAjustes.FieldByName('RED_PARTOT').AsString, 2);
    LRegistroRelatorio.CodigoAutorizacao := TRedeCardFuncoes.fStrZero(Trim(cdsAjustes.FieldByName('RED_AUTDEB').AsString), 6);

    LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName('RED_DTALAN').AsDateTime;

    LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName('RED_DTALAN').AsDateTime;

    LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('RED_CONCIL').AsInteger;
    LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('RED_NOMARQ').AsString;

    LRegistroRelatorio.RegistroIncompleto := 'N';
    If FBaixarAjustes Then
    Begin
      LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
    End;

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);
  End;
end;

function TConcilRedeCard.RetornaSQLTotalGravameRegistro034: String;
begin
  Result := 'IFNULL((SELECT SUM(R46.RED_VALLAN)     ' +
            ' FROM RED_EFIR34 R46                   ' +
            ' WHERE R46.RED_NUM_PV=RED_NUM_PV       ' +
            '   AND R46.RED_NUM_RV=RED_NUM_RV       ' +
            '   AND R46.RED_DTA_RV=RED_DTA_RV       ' +
            '   AND R46.RED_DTALAN=RED_DTALAN       ' +
            '   AND R46.RED_TIPREG="046"), 0)       ' +
            ' AS RED_TOTGRA                         ';
end;

procedure TConcilRedeCard.ValidaCartaoMarcado(var AInconsistenciaCartao: String;
  AValorBruto: Double; var ARegistroRelatorio: TItensRelatorioCartoes);
begin
  If cdsBaicar.FieldByName('MCA_MARDES').AsString <> 'M' Then
    Exit;

  If Not AInconsistenciaCartao.IsEmpty Then
    Exit;

  If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto, cdsBaiCar) Then
  Begin
    AInconsistenciaCartao := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
    ARegistroRelatorio.SomarNoTotal := 'N';
  End;
end;

procedure TConcilRedeCard.pCalculaPeriodoFiltro;
begin
  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);
  lstDtaCad := TStringList.Create;

  If (Assigned(cdsRED_EVDR05)) And (Not cdsRED_EVDR05.IsEmpty) Then
  Begin
    With cdsRED_EVDR05 do
    Begin
      IndexFieldNames := INICAM + 'DTA_CV';
      First;
      If dtaDtaIni > FieldByName(INICAM + 'DTA_CV').Value Then
        dtaDtaIni := FieldByName(INICAM + 'DTA_CV').Value;

      While Not Eof Do
      Begin
        If lstDtaCad.IndexOf(FormatDateTime('yyyyyy-mm-dd', FieldByName(INICAM + 'DTA_CV').Value)) < 0 Then
          lstDtaCad.Add(FormatDateTime('yyyyyy-mm-dd', FieldByName(INICAM + 'DTA_CV').Value));
        Next;
      End;
      Last;
      If dtaDtaFim < FieldByName(INICAM + 'DTA_CV').Value Then
        dtaDtaFim := FieldByName(INICAM + 'DTA_CV').Value;

      IndexFieldNames := INICAM + 'NUM_PV;RED_NUM_RV;RED_NUM_CV';
    End;
  End;

  If (Assigned(cdsRED_EFIR34)) And (Not cdsRED_EFIR34.IsEmpty) Then
  Begin
    With cdsRED_EFIR34 do
    Begin
      IndexFieldNames := INICAM + 'DTA_RV';
      First;
      If dtaDtaIni > FieldByName(INICAM + 'DTA_RV').Value Then
        dtaDtaIni := FieldByName(INICAM + 'DTA_RV').Value;

      While Not Eof Do
      Begin
        If lstDtaCad.IndexOf(FormatDateTime('yyyyyy-mm-dd', FieldByName(INICAM + 'DTA_RV').Value)) < 0 Then
          lstDtaCad.Add(FormatDateTime('yyyyyy-mm-dd', FieldByName(INICAM + 'DTA_RV').Value));
        Next;
      End;
      Last;
      If dtaDtaFim < FieldByName(INICAM + 'DTA_RV').Value Then
        dtaDtaFim := FieldByName(INICAM + 'DTA_RV').Value;

      IndexFieldNames := INICAM + 'NUM_PV;RED_NUM_RV;RED_DTA_RV';
    End;
  End;

  If Not FRegistro046.IsEmpty Then
  Begin
    FRegistro046.IndexFieldNames := INICAM + 'DTA_RV';
    FRegistro046.First;

    If dtaDtaIni > FRegistro046.FieldByName(INICAM + 'DTA_RV').Value Then
      dtaDtaIni := FRegistro046.FieldByName(INICAM + 'DTA_RV').Value;

    While Not FRegistro046.Eof Do
    Begin
      If lstDtaCad.IndexOf(FormatDateTime('yyyyyy-mm-dd', FRegistro046.FieldByName(INICAM + 'DTA_RV').Value)) < 0 Then
        lstDtaCad.Add(FormatDateTime('yyyyyy-mm-dd', FRegistro046.FieldByName(INICAM + 'DTA_RV').Value));
      FRegistro046.Next;
    End;

    FRegistro046.Last;
    If dtaDtaFim < FRegistro046.FieldByName(INICAM + 'DTA_RV').Value Then
      dtaDtaFim := FRegistro046.FieldByName(INICAM + 'DTA_RV').Value;

    FRegistro046.IndexFieldNames := INICAM + 'NUM_PV;RED_NUM_RV;RED_DTA_RV';
  End;
end;

function TConcilRedeCard.fConciliaCartoes: Boolean;
begin
  Result := TRedeCardFuncoes.ExecutaAguarde(fConciliaRedeCard, 'Aguarde... Iniciando conciliação RedeCard.');
end;

function TConcilRedeCard.fConciliaRedeCard(pgbStatus: TcxProgressBar): Boolean;
Var
    strStatus  : String;
    prcScroll  : TprcScroll;
    blnVazio   : Boolean;
begin
  inherited;
  Try
    Try
      Result       := False;
      blnInconsist := False;

      strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

      TForm(pgbStatus.Owner).Visible := False;

      strStatus   := '';

      //Para conciliação por Ponto de Venda
      objConcil.TabelaConciliacao := INICAM + 'EFIR34';
      objConcil.CampoEstabelecimento := INICAM + 'NUM_PV';
      objConcil.NomeConciliacao := 'REDECARD';
      objConcil.CfgEstabelecimentos := 'CFG_REDEST';
      objConcil.CampoValorBruto := INICAM + 'VALDEB';
      objConcil.CampoValorLiquido := INICAM + 'VALDEB';
      objConcil.CampoCodigoAutorizacao := INICAM + 'AUTDEB';
      objConcil.CampoNumeroNSU := INICAM + 'NSUDEB';
      objConcil.CampoDataTransacaoVenda := INICAM + 'DTALAN';
      objConcil.CampoNumeroParcela := INICAM + 'PARTOT';
      objConcil.CampoTotalParcelas := INICAM + 'PARTOT';
      objConcil.CampoNumeroCartao := INICAM + 'CARDEB';
      objConcil.CampoDataRecebimento := INICAM + 'DTALAN';
      objConcil.CampoTipoRegistro := INICAM + 'TIPREG';
      objConcil.CampoTipoTransacao := INICAM + 'MOTAJU';
      objConcil.CfgPortadorAjustes := 'REDPOR';
      objConcil.CfgPlanoDeContasAjustes := 'REDCTA';
      objConcil.CfgFornecedorAjustes := 'REDFOR';
      objConcil.strEventoCancelamentoAjuste := 'REDEVE';
      objConcil.CfgVlrTolerancia := 'REDTOL';
      objConcil.strChavePrimaria := 'RED_DTA_RV,RED_NUM_PV,RED_NUM_RV,RED_PARTOT,RED_TIPREG,RED_NUM_OC';

      {**************************************}
      {* PEGANDO O PERÍODO PARA CONCILIAÇÃO *}
      {***********************************AJ*}
      If Not fDigPeriodo Then
        Exit;

      TForm(pgbStatus.Owner).Visible := True;

      pgbStatus.Visible := False;
      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
      pCriaClientRED_EVDR05;
      pCriaClientRED_EFIR34;
      pCriaClientRegistro046;
      blnVazio := (cdsRED_EVDR05.RecordCount + cdsRED_EFIR34.RecordCount + FRegistro046.RecordCount) = 0;

      //Se no filtro não vier nem crédito, nem débito
      If blnVazio Then
      Begin
        TRedeCardFuncoes.fMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&Ok']);
        blnReabre := True;
        Exit;
      End;

      {**************************************}
      {* VERIFICA SE FALTAM ARQUIVOS E ABRE *}
      {* O DIREITO DE ACESSO PARA CONTINUAR *}
      {***********************************AJ*}
      If fRelatPreConciliacao Then
      Begin
        If Not VS_FuncoesExternas.fIPedirLiberacao('CARCONARQIMP',
                                                   'Conciliação de cartões de crédito com inconsistência nos arquivos importados',
                                                   'Permitir realizar conciliação de cartões de crédito com inconsistência nos arquivos importados.') Then
          Exit;
      End;

      //Para os Ajustes  - Tem que estar antes para não pegar outros ajustes de outras datas
      strCondicao :=  'RED_DTALAN BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';

      //Data para filtrar o MOVCAR dos baixados
      pCalculaPeriodoFiltro;

      pFiltraCartoes;

      TRedeCardFuncoes.pDisableControls(cdsBaiCar, prcScroll);

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'REDECARD',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TRedeCardFuncoes.RetornaDataHoraServidor,
                                                            TRedeCardFuncoes.RetornaHoraServidor);

      //Filtrando Cancelamentos/Ajustes
      objConcil.CampoValorBruto := INICAM + 'VALLAN';
      objConcil.CampoValorLiquido := INICAM + 'VALLAN';

      strCondicao := strCondicao + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
      strCondicao := strCondicao + ' AND (RED_REGDEB IN ("035", "045")) AND (RED_VALDEB <> 0) ';
      FiltrarCancelamentosPeriodo(strCondicao,
                                  'RED_MOTAJU',
                                  ' IF(RED_VALDEB > 0, RED_VALDEB, 0) ');

      objConcil.CampoValorBruto := INICAM + 'VALDEB';
      objConcil.CampoValorLiquido := INICAM + 'VALDEB';

      //Selecionando cartões já baixados/cadastrados no período
      pFiltraCartoesBaixados;

      CarregaIndicesBusca;

      pgbStatus.Visible := True;
      If Not cdsRED_EVDR05.IsEmpty Then
      Begin
        TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de débito (' + objConcil.NomeConciliacao + ').', False);
        fProcessaDebitoRede(pgbStatus);
      End;

      FListaRegistros034 := TStringList.Create;

      {*************************************}
      {* VENDAS CRÉDITO ROTATIVO/PARCELADO *}
      {**********************************AJ*}
      If Not cdsRED_EFIR34.IsEmpty Then
      Begin
        TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de crédito (' + objConcil.NomeConciliacao + ').', False);
        fProcessaCreditoRede(pgbStatus);
      End;

      {*************************************}
      {* NEGOCIAÇÃO DE RECEBÍVEIS          *}
      {**********************************AJ*}
      If Not FRegistro046.IsEmpty Then
      Begin
        TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros de negociação (' + objConcil.NomeConciliacao + ').', False);
        ProcessaPagamentosNegociacao(pgbStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      blnInconsist := False;

      TRedeCardFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(pgbStatus);

      TForm(pgbStatus.Owner).Visible := False;

      If blnInconsist Then
        TRedeCardFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      If FListaRegistrosRelatorio.Count > 0 Then
        Result := GeraRelatorioConciliacao('REDECARD', pgbStatus);

      If Assigned(cdsAjustes) Then
      Begin
        cdsAjustes.Filter   := 'RED_CONCIL=0';
        cdsAjustes.Filtered := True;
      End;

      blnReabre := Not Result;
      If Result Then
      Begin
        cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        cdsBaiCar.Filtered := True;

        Result := Not cdsBaiCar.IsEmpty;
        If Not Result Then
          TRedeCardFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
        Else
          TRedeCardFuncoes.fMensagem('AVISO','Conciliação da REDECARD realizada com sucesso.',['&OK']);
      End;

      TRedeCardFuncoes.pEnableControls(cdsBaiCar, prcScroll);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaRedeCard]');
      End;
    End;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(cdsRED_EVDR05);
    TRedeCardFuncoes.FreeAndNilDatasets(cdsRED_EVCR06);
    TRedeCardFuncoes.FreeAndNilDatasets(cdsRED_EVCR08);
    TRedeCardFuncoes.FreeAndNilDatasets(cdsRED_EVCR10);
    TRedeCardFuncoes.FreeAndNilDatasets(cdsRED_EVCR12);
    TRedeCardFuncoes.FreeAndNilDatasets(cdsRED_EFIR34);
    TRedeCardFuncoes.FreeAndNilDatasets(FRegistro046);

    If Assigned(FListaDatasRVs046) Then
      FreeAndNil(FListaDatasRVs046);

    If Assigned(FListaRegistros034) Then
      FreeAndNIl(FListaRegistros034);
  End;
end;

end.
