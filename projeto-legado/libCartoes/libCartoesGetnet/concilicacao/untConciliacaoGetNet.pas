unit untConciliacaoGetNet;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics,

     Uni, UniClientDataSet, cxProgressBar,

     untGetNetConciliacaoCartoes, untTGetNetFuncoes, untLibCartoesInterfacesTipos;

Type
  TDiferencaGrupo5 = record
    Estabelecimento: String;

    DataRecebimento: TDateTime;

    ValorLiquido: Double;
  End;

type TConcilGetNet = class(TConciliacaoCartoes)
  private
    LTolerancia: Double;

    FCondicaoAjustes: String;

    ArrayDiferencas: Array Of TDiferencaGrupo5;

    FCloneDatasetConCar: TUniClientDataset;

    function RetornaSQLRegistrosConciliacao: String;
    function RetornaSQLRegistrosConciliacaoVersao10_1: String;

    function RetornaSQLTiposDeAjustes: String;
    function RetornaSQLWhereRegistrosAjustesVersao10_1: String;

    function NenhumRegistroPagamentos: Boolean;

    function fVerificaTipo(strTipCar: String): String;
    function RetornaTipoCartaoVersao10_1(ATipoProduto: String): String;

    procedure pAntecipacoes(pgbStatus: TcxProgressBar);
    procedure pCalculaPeriodoFiltroAntecipacao;
    function ProcessaDiferencaGrupo5(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure AdicionaDiferencas(AEstabelecimento: String;
                                 ADataRecebimento: TDateTime;
                                 AValorLiquido: Double);

    procedure GerarAjustesDeAntecipacaoAC;

    function RegistroPossuiAMesmaDataELiberacaoVersao10_1(ACodigoAutorizacao, AParcelaLetra: String): Boolean;

    function RetornaBandeiraGetNet(ACodigoProduto: String): String;

    function RegistroPossuiAMesmaAutorizacao(AAutorizacao,
                                             AParcela,
                                             AEmpresa,
                                             ADataCupom: String): Boolean;

    {Métodos principais da rotina}
    function fProcessaGetNetPag(pgbStatus: TcxProgressBar = Nil): Boolean;
    function ProcessaGetNetVersao10_1(pgbStatus: TcxProgressBar = Nil): Boolean;
    function ProcessaNegociacaoRecebiveis(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fConciliaGetNet(prgStatus: TcxProgressBar): Boolean;
  public
    constructor Create; overload;
    destructor Destroy; override;
    function fConciliaCartoes: Boolean; override;

  protected

  end;

implementation

Uses untGetnetFiltroInconsistencias;

function TConcilGetNet.fVerificaTipo(strTipCar: String): String;
begin
  Result := 'CRÉDITO';
  If Pos(strTipCar, 'SR_SE_PV_PM_ED_') > 0 Then
    Result := 'DÉBITO';
end;

procedure TConcilGetNet.GerarAjustesDeAntecipacaoAC;
Var
  LConsulta: TUniQuery;

  LSQL: String;

  LPlanoContasCredito,
  LPlanoCOntasDebito,
  LCodigoEmpresa: String;

  LRegistroRelatorio: TItensRelatorioCartoes;

  LField: TField;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;

    LSQL := '';
    LSQL := LSQL + 'SELECT DISTINCT A.*, ';
    LSQL := LSQL + '       ' + RetornaSQLTiposDeAjustes +  ' AS TIPAJU, ';
    LSQL := LSQL + '       A.GET_VALPAG AS AJUCRE, ';
    LSQL := LSQL + '       "S" AS MARCADO, ';
    LSQL := LSQL + '       C.SIS_CODEMP AS EMPRESA, ';
    LSQL := LSQL + '       D.SIS_VALCFG AS PLANOCONTASDEBITO, ';
    LSQL := LSQL + '       E.SIS_VALCFG AS PLANOCONTASCREDITO, ';
    LSQL := LSQL + '       F.EMP_NOMEMP, ';

    If FPossuiCampoCCA_CCAGRA Then
    Begin
      LSQL := LSQL + '       (SELECT POR.POR_CODPOR ';
      LSQL := LSQL + '        FROM CADCCA CCA ';
      LSQL := LSQL + '        LEFT JOIN CADPOR POR ON POR.POR_CCAAUT = CCA.AUTOINCREM ';
      LSQL := LSQL + '        WHERE CCA.CCA_CODEMP = C.SIS_CODEMP ';
      LSQL := LSQL + '          AND CCA.CCA_CCAGRA=''S'' ';
      LSQL := LSQL + '          AND TRIM(LEADING ''0'' FROM CCA.CCA_CODCTA)=TRIM(LEADING ''0'' FROM A.GET_NUMCCO) ';
      LSQL := LSQL + '          AND TRIM(LEADING ''0'' FROM CCA.CCA_AGENCI)=TRIM(LEADING ''0'' FROM A.GET_CODAGE) ';
      LSQL := LSQL + '          AND TRIM(LEADING ''0'' FROM CCA.CCA_CODBCO)=TRIM(LEADING ''0'' FROM A.GET_CODBCO) ';
      LSQL := LSQL + '        LIMIT 1) AS PORTADOR_GRAVAME ';
    End
    Else
    Begin
      LSQL := LSQL + '       NULL AS PORTADOR_GRAVAME ';
    End;

    LSQL := LSQL + 'FROM GET_GEPGTO A ';
    LSQL := LSQL + 'LEFT JOIN CFGSIS C ON C.SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO") ';
    LSQL := LSQL + '                  AND C.SIS_VALCFG RLIKE A.GET_CODEST ';
    LSQL := LSQL + 'LEFT JOIN CFGSIS D ON D.SIS_CODCFG = "CFG_GETCTD" ';
    LSQL := LSQL + '                  AND D.SIS_CODEMP = C.SIS_CODEMP ';
    LSQL := LSQL + 'LEFT JOIN CFGSIS E ON E.SIS_CODCFG = "CFG_GETCTC" ';
    LSQL := LSQL + '                  AND E.SIS_CODEMP = C.SIS_CODEMP ';
    LSQL := LSQL + 'LEFT JOIN CADEMP F ON F.EMP_CODEMP = C.SIS_CODEMP ';

    LSQL := LSQL + 'WHERE ' + FCondicaoAjustes;
    LSQL := LSQL + '  AND A.GET_TIPREG ="AJ" ';
    LSQL := LSQL + '  AND A.GET_TIPPAG ="AC" ';
    LSQL := LSQL + '  AND A.GET_VALPAG > 0 ';

    LConsulta.SQL.Text := LSQL;

    LConsulta.Open;

    If LConsulta.IsEMpty THen
      Exit;

    If Not Assigned(cdsAjustes) Then
      cdsAjustes := TGetnetFuncoes.CriarClientDataSet(LConsulta, True);

    While Not LConsulta.Eof Do
    Begin
      cdsAjustes.Append;
      For LField In cdsAjustes.Fields Do
      Begin
        If LConsulta.FindField(LField.FieldName) = Nil Then
          Continue;

        cdsAjustes.FieldByName(LField.FieldName).Value := LConsulta.FieldByName(LField.FieldName).Value;
      End;
      cdsAjustes.Post;

      LPlanoContasCredito := LConsulta.FieldByName('PLANOCONTASCREDITO').AsString;
      LPlanoCOntasDebito := LConsulta.FieldByName('PLANOCONTASDEBITO').AsString;
      LCodigoEmpresa := LConsulta.FieldByName('EMPRESA').AsString;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := 'AJUSTE DE CRÉDITO - ANTECIPAÇÃO';

      LRegistroRelatorio.ValorBruto := LConsulta.FieldByName('GET_VALPAG').AsFloat;
      LRegistroRelatorio.ValorLiquido :=  LConsulta.FieldByName('GET_VALPAG').AsFloat;

      LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('GET_CODEST').AsString;
      LRegistroRelatorio.CodigoAutorizacao := LConsulta.FieldByName('GET_CODAUT').AsString;
      LRegistroRelatorio.NumeroNSU := LConsulta.FieldByName('GET_NUMNSU').AsString;
      LRegistroRelatorio.NumeroCartao := LConsulta.FieldByName('GET_NUMCAR').AsString;
      LRegistroRelatorio.Parcela :=TGetnetFuncoes.IIF(LConsulta.FieldByName('GET_NUMPAR').AsInteger = 0, '01', TGetnetFuncoes.fStrZero(LConsulta.FieldByName('GET_NUMPAR').AsString, 2));
      LRegistroRelatorio.TotalParcelas := TGetnetFuncoes.IIF(LConsulta.FieldByName('GET_TOTPAR').AsInteger = 0, '01', TGetnetFuncoes.fStrZero(LConsulta.FieldByName('GET_TOTPAR').AsString, 2));
      LRegistroRelatorio.DataVenda := LConsulta.FieldByName('GET_DTATRA').AsDateTime;
      LRegistroRelatorio.DataVencimento := LConsulta.FieldByName('GET_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataPagamento := LConsulta.FieldByName('GET_DTAPAG').AsDateTime;
      LRegistroRelatorio.DescricaoBandeira := RetornaBandeiraGetNet(LRegistroRelatorio.NumeroCartao);
      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('GET_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LConsulta.FieldByName('GET_NOMARQ').AsString;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If FBaixarAjustes Then
      Begin
        LRegistroRelatorio.RegistroIncompleto :=  RetornaSituacaoCadastroInconsistencias(LCodigoEmpresa);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, LConsulta);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := 'AJUSTE DE DÉBITO - ANTECIPAÇÃO';

      LRegistroRelatorio.ValorBruto := Abs(LConsulta.FieldByName('GET_VALDES').AsFloat) * (-1);
      LRegistroRelatorio.ValorLiquido := Abs(LConsulta.FieldByName('GET_VALDES').AsFloat) * (-1);

      LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('GET_CODEST').AsString;
      LRegistroRelatorio.CodigoAutorizacao := LConsulta.FieldByName('GET_CODAUT').AsString;
      LRegistroRelatorio.NumeroNSU := LConsulta.FieldByName('GET_NUMNSU').AsString;
      LRegistroRelatorio.NumeroCartao := LConsulta.FieldByName('GET_NUMCAR').AsString;
      LRegistroRelatorio.Parcela :=TGetnetFuncoes.IIF(LConsulta.FieldByName('GET_NUMPAR').AsInteger = 0, '01', TGetnetFuncoes.fStrZero(LConsulta.FieldByName('GET_NUMPAR').AsString, 2));
      LRegistroRelatorio.TotalParcelas := TGetnetFuncoes.IIF(LConsulta.FieldByName('GET_TOTPAR').AsInteger = 0, '01', TGetnetFuncoes.fStrZero(LConsulta.FieldByName('GET_TOTPAR').AsString, 2));

      LRegistroRelatorio.DataVenda := LConsulta.FieldByName('GET_DTATRA').AsDateTime;
      LRegistroRelatorio.DataVencimento := LConsulta.FieldByName('GET_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataPagamento := LConsulta.FieldByName('GET_DTAPAG').AsDateTime;

      LRegistroRelatorio.DescricaoBandeira := RetornaBandeiraGetNet(LRegistroRelatorio.NumeroCartao);
      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('GET_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LConsulta.FieldByName('GET_NOMARQ').AsString;

       LRegistroRelatorio.RegistroIncompleto := 'N';
      If FBaixarAjustes Then
      Begin
        LRegistroRelatorio.RegistroIncompleto :=  RetornaSituacaoCadastroInconsistencias(LCodigoEmpresa);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, LConsulta);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LConsulta.Next;
    End;
  Finally
    TGetNetFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilGetNet.NenhumRegistroPagamentos: Boolean;
begin
  Result := cdsConCar.IsEmpty;

  If Result Then
  Begin
    If Assigned(cdsAjustes) Then
      Result := cdsAjustes.IsEmpty;
  End;
end;

procedure TConcilGetNet.pAntecipacoes;
Var
  qryAntec : TUniQuery;
  FTextoInconsistencia: String;
  LValorBruto,
  LValorLiquido,
  fltDifere: Double;
  blnBusca : Boolean;
  LRegistroRelatorio: TItensRelatorioCartoes;

  LPossuiAjustesAC: Boolean;

  LChaveConciliacao: String;
begin
  qryAntec := Nil;
  Try
    qryAntec := VS_FuncoesExternas.fICriaQuery;

    qryAntec.SQL.Text := ' SELECT *, COALESCE(SIS_CODEMP, "") AS CODEMP, ';
    qryAntec.SQL.Add(    ' EMP_NOMEMP FROM GET_GEPGTO                    ');
    qryAntec.SQL.Add(    ' LEFT JOIN CFGSIS ON SIS_VALCFG=GET_CODEST     ');
    qryAntec.SQL.Add(    ' AND SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO") ');
    qryAntec.SQL.Add(    ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP     ');
    qryAntec.SQL.Add(    ' WHERE GET_DTAPAG = :DTAVEN                    ');
    qryAntec.SQL.Add(    ' AND GET_NUM_RV=:NUM_RV AND GET_NUMPAR=:NUMPAR ');
    qryAntec.SQL.Add(    ' AND GET_TIPREG="PF"                           ');
    qryAntec.SQL.Add(    ' GROUP BY GET_TIPREG,GET_CODEST,GET_NUM_RV,GET_DTA_RV,GET_DTAPAG,GET_NUMPAR,GET_CODAUT,GET_NUMNSU,GET_IDEAJU  ');
    qryAntec.SQL.Add(    ' ORDER BY GET_DTAPAG, GET_TIPREG               ');

    While (Not cdsConCar.Eof) And MatchStr(cdsConCar.FieldByName('GET_TIPREG').AsString, ['AC','CS'])  Do
    Begin
      TGetnetFuncoes.pStepStatusGravacao(pgbStatus);
      LPossuiAjustesAC :=  FCloneDatasetConCar.Locate('GET_TIPREG;GET_CODEST;GET_DTAPAG',
                                                      VarArrayOf(['AC',
                                                                  cdsConCar.FieldByName('GET_CODEST').AsString,
                                                                  cdsConCar.FieldByName('GET_DTAPAG').AsDateTime]), []);

      If cdsConCar.FieldByName('GET_TIPREG').AsString.Equals('CS') Then
      Begin
        If LPossuiAjustesAC Then
        Begin
          cdsConCar.Next;
          Continue;
        End;
      End;

      FTextoInconsistencia := '';
      qryAntec.Close;
      qryAntec.ParamByName('DTAVEN').Value := cdsConCar.FieldByName('GET_VENORI').Value;
      qryAntec.ParamByName('NUM_RV').Value := cdsConCar.FieldByName('GET_NUM_RV').Value;
      qryAntec.ParamByName('NUMPAR').Value := cdsConCar.FieldByName('GET_NUMPAR').Value;
      qryAntec.Open;

      If qryAntec.RecordCount = 0 Then
      Begin
        LRegistroRelatorio := TItensRelatorioCartoes.Create;
        LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('GET_CODEST').AsString;
        LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('GET_NUM_RV').AsString;
        LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('GET_DTATRA').Value;
        LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('GET_VALPAG').Value -
                                                      cdsConCar.FieldByName('GET_VALDES').Value;
        LRegistroRelatorio.Parcela := cdsConCar.FieldByName('GET_NUMPAR').AsString + '/' +
                                                      cdsConCar.FieldByName('GET_TOTPAR').AsString;
        LRegistroRelatorio.RegistroIncompleto := 'S';

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);
      End
      Else
      Begin
        qryAntec.First;
        While Not qryAntec.Eof Do
        Begin
          FTextoInconsistencia := '';
          LValorBruto  := qryAntec.FieldByName('GET_VALPAR').Value;
          LValorLiquido := (cdsConCar.FieldByName('GET_VALPAG').Value - cdsConCar.FieldByName('GET_VALDES').Value) *
                      (LValorBruto / qryAntec.FieldByName('GET_RV_BRU').Value);

          LRegistroRelatorio := TItensRelatorioCartoes.Create;

          LChaveConciliacao := 'GET_' + IntToStr(StrtoInt64(qryAntec.FieldByName('GET_NUM_RV').Value)) + '_' +
                          qryAntec.FieldByName('GET_CODAUT').Value + '_' +TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(qryAntec.FieldByName('GET_NUMPAR').AsString = '0', '1', qryAntec.FieldByName('GET_NUMPAR').AsString))) + '_' +
                          cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                          FormatDateTime('yyyy-mm-dd', qryAntec.FieldByName('GET_DTATRA').Value);

          blnBusca := fBuscaCartao(TGetnetFuncoes.fStrZero(RightStr(qryAntec.FieldByName('GET_CODAUT').Value, 6), 6),
                                   TGetnetFuncoes.fStrZero(Trim(RightStr(qryAntec.FieldByName('GET_NUMNSU').Value, 14)), 14),
                                   qryAntec.FieldByName('CODEMP').AsString,
                                   TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(qryAntec.FieldByName('GET_NUMPAR').AsString = '00', '1', qryAntec.FieldByName('GET_NUMPAR').AsString))),
                                   qryAntec.FieldByName('GET_DTATRA').AsDateTime);

          If blnBusca Then
          Begin
            fltDifere := TGetnetFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto,6);
            LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

            If fBetween(fltDifere, -LTolerancia, LTolerancia) Then
            Begin

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                           True,
                           LRegistroRelatorio,
                           LChaveConciliacao,
                           cdsConCar);
            End
            Else
              FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
          End
          Else
          Begin
            blnAutomatica := qryAntec.FieldByName('GET_CONCIL').Value = '1';
            If qryAntec.FieldByName('GET_CONCIL').Value = '0' Then
            Begin
              cdsBaixad.First;
              blnBusca := fBuscaCartaoBaixado(TGetnetFuncoes.fStrZero(Copy(Trim(qryAntec.FieldByName('GET_CODAUT').Value), 5, 6), 6),
                                         TGetnetFuncoes.fStrZero(Trim(RightStr(qryAntec.FieldByName('GET_NUMNSU').Value, 14)), 14),
                                         qryAntec.FieldByName('CODEMP').AsString,
                                         TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(qryAntec.FieldByName('GET_NUMPAR').AsString = '00', '1', qryAntec.FieldByName('GET_NUMPAR').AsString))),
                                         qryAntec.FieldByName('GET_DTATRA').Value);
              If Not blnBusca Then
                FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema'
              Else
                FTextoInconsistencia := 'Cartão já foi baixado';
            End
            Else
              FTextoInconsistencia := 'Cartão já foi baixado';
          End;

          If TGetnetFuncoes.fEmptyStr(FTextoInconsistencia) Then
          Begin
            If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
              FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
          End;

          {Gerando registro do relatório}
          FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
          If Not FTextoInconsistencia.IsEmpty Then
          Begin
            LRegistroRelatorio.Descricao := FTextoInconsistencia;
            LRegistroRelatorio.SomarNoTotal := 'N';

            If Not MatchStr(LRegistroRelatorio.Descricao, [RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa,
                                                           'Cartão conciliado com valor negociado anteriormente']) Then
            Begin
              LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
              LRegistroRelatorio.SomarNoTotal := 'S';
            End;
          End;
          LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('GET_NOMARQ').AsString;

          LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('GET_CODEST').AsString;
          LRegistroRelatorio.CodigoEmpresa := qryAntec.FieldByName('CODEMP').AsString;
          LRegistroRelatorio.NumeroNSU := qryAntec.FieldByName('GET_NUMNSU').Value;
          LRegistroRelatorio.CodigoAutorizacao := qryAntec.FieldByName('GET_CODAUT').Value;
          LRegistroRelatorio.ResumoVenda := qryAntec.FieldByName('GET_NUM_RV').AsString;
          LRegistroRelatorio.NumeroCartao := qryAntec.FieldByName('GET_NUMCAR').Value;

          LRegistroRelatorio.TipoCartao := 'ANTECIPAÇÃO';

          LRegistroRelatorio.Parcela := qryAntec.FieldByName('GET_NUMPAR').Value;
          LRegistroRelatorio.TotalParcelas := qryAntec.FieldByName('GET_TOTPAR').Value;

          LRegistroRelatorio.DataPagamento := qryAntec.FieldByName('GET_DTATRA').Value;
          LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('GET_VENORI').Value;
          LRegistroRelatorio.DataVencimento := qryAntec.FieldByName('GET_DTATRA').Value;

          LRegistroRelatorio.ValorBruto := LValorBruto;
          LRegistroRelatorio.ValorLiquido := LValorLiquido;

          LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

          FListaRegistrosRelatorio.Add(LRegistroRelatorio);

          If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
            GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

          qryAntec.Next;
        End;
      End;

      cdsConCar.Next;
    End;
  Finally
    TGetNetFuncoes.FreeAndNilDatasets(qryAntec);
  End;
end;

procedure TConcilGetNet.pCalculaPeriodoFiltroAntecipacao;
Var
  LConsulta: TUniQuery;
begin
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    Try
      LConsulta.SQL.Text := 'SELECT                                '+
                            '  B.GET_DTATRA                        '+
                            'FROM                                  '+
                            '  GET_GEPGTO A                        '+
                            '  JOIN GET_GEPGTO B                   '+
                            '     ON B.GET_DTAPAG = A.GET_VENORI   '+
                            '    AND B.GET_NUM_RV = A.GET_NUM_RV   '+
                            '    AND B.GET_NUMPAR = A.GET_NUMPAR   '+
                            '    AND B.GET_TIPREG = "PF"           '+
                            'WHERE A.GET_DTAPAG BETWEEN :DTAINI    '+
                            '  AND :DTAFIN                         '+
                            '  AND A.GET_TIPREG IN ("AC", "CS")    '+
                            '  AND (A.GET_VERARQ IS NULL           '+
                            '    OR A.GET_VERARQ NOT IN ("10.1", "10.3"))        '+
                            'GROUP BY B.GET_DTATRA                 '+
                            'ORDER BY B.GET_DTATRA                 ';


      LConsulta.ParamByName('DTAINI').AsDateTime := StrToDateTime(strDtaIni);
      LConsulta.ParamByName('DTAFIN').AsDateTime := StrToDateTime(strDtaFim);
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin
        LConsulta.First;

        While Not LConsulta.Eof Do
        Begin

          If lstDtaCad.IndexOf(FormatDateTime('yyyy-mm-dd', LConsulta.FieldByName('GET_DTATRA').Value)) < 0 Then
            lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', LConsulta.FieldByName('GET_DTATRA').Value));

          LConsulta.Next;
          Application.ProcessMessages;
        End;
      End;


    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TConcilGetNet.ProcessaDiferencaGrupo5(
  pgbStatus: TcxProgressBar): Boolean;
Var
  LConsulta: TUniQuery;

  LSQL: String;

  LRegistroRelatorio: TItensRelatorioCartoes;

  LDiferenca: TDiferencaGrupo5;
begin
  Result := True;

  cdsConCar.Filter := '(' + cdsConCar.Filter + ')' +
                      ' AND GET_TIPREG =''PG'' ';
  cdsConCar.Filtered := True;

  If cdsConCar.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;

    LSQL := '';
    LSQL := LSQL + ' SELECT A.*,                                             ';
    LSQL := LSQL + ' COALESCE(SIS_CODEMP, "") AS CODEMP,                     ';
    LSQL := LSQL + ' COALESCE(EMP_NOMEMP, "") AS EMP_NOMEMP                  ';
    LSQL := LSQL + ' FROM GET_GEPGTO A                                       ';
    LSQL := LSQL + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO") AND ';
    LSQL := LSQL + '                     LOCATE(A.GET_CODEST, SIS_VALCFG) > 0 ';
    LSQL := LSQL + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP               ';

    LSQL := LSQL + ' WHERE A.GET_DTAPAG BETWEEN :DTAIN AND :DTAFIM           ';

    LSQL := LSQL + StringReplace(fRetPesqPonVen(0), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

    LSQL := LSQL + ' AND A.GET_TIPREG="NR" ';
    LSQL := LSQL + ' AND A.GET_STATUS="L" ';
    LSQL := LSQL + ' AND (A.GET_VERARQ IS NULL OR A.GET_VERARQ NOT IN ("10.1", "10.3")) ';
    
    LSQL := LSQL + ' ORDER BY A.GET_DTAPAG, A.GET_CODEST                     ';

    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('DTAIN').AsDateTime  := StrToDateTime(strDtaIni);
    LConsulta.ParamByName('DTAFIM').AsDateTime := StrToDateTime(strDtaFim);

    LConsulta.Open;

    If LConsulta.IsEmpty THen
      Exit;

    If Assigned(cdsAjustes) Then
    Begin
      cdsAjustes.First;
      While Not cdsAjustes.Eof Do
      Begin
        If cdsAjustes.FieldByName('GET_TIPPAG').AsString.Equals('AC') Then
        Begin
          cdsAjustes.Next;
          Continue;
        End;

        AdicionaDiferencas(cdsAjustes.FieldByName('GET_CODEST').AsString,
                           cdsAjustes.FieldByName('GET_DTAPAG').AsDateTime,
                           cdsAjustes.FieldByName(objConcil.CampoValorLiquido).AsFloat);

        cdsAjustes.Next;
      End;
    End;

    While Not LConsulta.Eof Do
    Begin
      AdicionaDiferencas(LConsulta.FieldByName('GET_CODEST').AsString,
                         LConsulta.FieldByName('GET_DTAPAG').AsDateTime,
                         LConsulta.FieldByName('GET_VALPAG').AsFloat * (-1));

      LConsulta.Next;
    End;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := Length(ArrayDiferencas);

    For LDiferenca In ArrayDiferencas Do
    Begin
      If Not LConsulta.Locate('GET_CODEST;GET_DTAPAG',
                              VarArrayOf([LDiferenca.Estabelecimento, LDiferenca.DataRecebimento]), []) Then
        Continue;

      If TGetnetFuncoes.fFormataFloat(LDiferenca.ValorLiquido, 2) = 0.00 Then
        Continue;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('GET_NOMARQ').AsString;
      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';//'ANTECIPAÇÃO';
      LRegistroRelatorio.DescricaoAjuste := 'PAGAMENTOS NÃO NEGOCIADOS';

      LRegistroRelatorio.ValorLiquido :=  LDiferenca.ValorLiquido * (-1);
      LRegistroRelatorio.NumeroNSU := TGetnetFuncoes.fStrZero(Trim(RightStr(LConsulta.FieldByName('GET_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoEstabelecimento := LDiferenca.Estabelecimento;
      LRegistroRelatorio.ResumoVenda := LConsulta.FieldByName('GET_NUM_RV').AsString;
      LRegistroRelatorio.NumeroCartao := LConsulta.FieldByName('GET_NUMCAR').AsString;

      LRegistroRelatorio.DataVenda :=  LDiferenca.DataRecebimento;
      LRegistroRelatorio.DataVencimento :=  LDiferenca.DataRecebimento;
      LRegistroRelatorio.DataPagamento :=  LDiferenca.DataRecebimento;

      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.CodigoAutorizacao := TGetnetFuncoes.fStrZero(RightStr(Trim(LConsulta.FieldByName('GET_CODAUT').AsString), 6), 6);
      LRegistroRelatorio.ValorLiquido :=  LDiferenca.ValorLiquido * (-1);
      LRegistroRelatorio.ValorBruto :=  LDiferenca.ValorLiquido * (-1);

      LRegistroRelatorio.CodigoEmpresa := LConsulta.FieldByName('CODEMP').AsString;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('GET_CONCIL').AsInteger;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      LRegistroRelatorio.RegistroIncompleto :=  RetornaSituacaoCadastroInconsistencias(LConsulta.FieldByName('CODEMP').AsString);

      If LConsulta.FieldByName('GET_CONCIL').AsInteger <> 1 Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      TGetnetFuncoes.pStepStatusGravacao(pgbStatus, '');
    End;
  Finally
    TGetnetFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilGetNet.ProcessaGetNetVersao10_1(
  pgbStatus: TcxProgressBar): Boolean;
Var
  LValorBruto,
  LDifererenca,
  LValorLiquido: Double;

  LIndiceAnterior,
  LSQLCondicaoAjustes,
  LCodigoAutorizacao,
  LParcelaLetra,
  LParcelaNumero,
  LTotalParcelas,
  LTipoCartao,
  LChaveConciliacao: String;

  LRegistroAtual: Integer;

  LEncontrado: Boolean;

  LRegistroRelatorio: TItensRelatorioCartoes;
  LValorMDR: Double;
  LValorBrutoParcela: Double;
begin
  FTextoInconsistencia := EmptyStr;

  Application.ProcessMessages;

  LSQLCondicaoAjustes := FCondicaoAjustes;
  LSQLCondicaoAjustes := LSQLCondicaoAjustes + RetornaSQLWhereRegistrosAjustesVersao10_1;

  FiltrarCancelamentosPeriodo(LSQLCondicaoAjustes,
                       RetornaSQLTiposDeAjustes,
                       ' IF(GET_VALPAG>0, GET_VALPAG, 0) ');

  cdsConCar.Filter := 'GET_VERARQ=''10.1'' OR  GET_VERARQ=''10.3'' ';
  cdsConCar.Filtered := True;

  If NenhumRegistroPagamentos Then
    Exit(False);

  If Not Assigned(FRelatorioConciliacao) Then
    FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                          'GETNET',
                                                          'CONCILIACAO',
                                                          RetornaFiltrosdigitados,
                                                          TGetnetFuncoes.RetornaDataHoraServidor,
                                                          TGetnetFuncoes.RetornaHoraServidor);

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := cdsConCar.RecordCount;

  cdsConCar.First;

  While Not cdsConCar.EOF do
  Begin
    TGetnetFuncoes.pStepStatusGravacao(pgbStatus);
    FTextoInconsistencia := EmptyStr;

    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    LTipoCartao := RetornaTipoCartaoVersao10_1(cdsConCar.FieldByName('GET_CODPRO').AsString);

    LValorMDR := cdsConCar.FieldByName('GET_VALMDR').AsFloat;
    LValorBrutoParcela := cdsConCar.FieldByName('GET_VALPAR').AsFloat;


    LCodigoAutorizacao := cdsConCar.FieldByName('GET_CODAUT').AsString;
    If Not LTipoCartao.Equals('PIX') Then
      LCodigoAutorizacao := TGetnetFuncoes.fStrZero(RightStr(Trim(cdsConCar.FieldByName('GET_CODAUT').AsString), 6), 6);

    LParcelaLetra := TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('GET_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('GET_NUMPAR').AsString)));
    LParcelaNumero := TGetnetFuncoes.fStrZero(StrtoInt(IfThen(cdsConCar.FieldByName('GET_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('GET_NUMPAR').AsString)).Tostring, 2);
    LTotalParcelas := TGetnetFuncoes.fStrZero(StrtoInt(IfThen(cdsConCar.FieldByName('GET_TOTPAR').AsString = '00', '1', cdsConCar.FieldByName('GET_TOTPAR').AsString)).Tostring, 2);

    If Not LTotalParcelas.Equals('01') Then
      LTipoCartao := 'CRÉDITO PARCELADO';

    LChaveConciliacao := 'GET_' +
                         IntToStr(StrtoInt64(cdsConCar.FieldByName('GET_NUM_RV').AsString)) + '_' +
                         cdsConCar.FieldByName('GET_CODAUT').AsString + '_' +
                         LParcelaLetra + '_' +
                         cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                         FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('GET_DTATRA').AsDateTime);

    LValorBruto  := TGetnetFuncoes.fFormataFloat(cdsConCar.FieldByName('GET_VALPAR').AsFloat, 2);
    LValorLiquido := TGetnetFuncoes.fFormataFloat((LValorBrutoParcela - LValorMDR) , 2);

    LEncontrado := fBuscaCartao(LCodigoAutorizacao,
                                TGetnetFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('GET_NUMNSU').AsString, 14)), 14),
                                cdsConCar.FieldByName('CODEMP').AsString,
                                LParcelaLetra,
                                cdsConCar.FieldByName('GET_DTATRA').AsDateTime,
                                cdsConCar.FieldByName('GET_CONCIL').AsInteger,
                                cdsConCar.FieldByName('GET_CONCIL').AsInteger <> 0);

    If LEncontrado Then
    Begin
      LDifererenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
      LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

      If fBetween(LDifererenca, -LTolerancia, LTolerancia) Then
      Begin

        MarcarCartaoEncontradoArquivo(LValorLiquido,
                                      False,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar);

        If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
        Begin
          If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
            FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
        End;
      End
      Else
      Begin
        //Verificando outras liberações com a mesma data
        LRegistroAtual := cdsBaiCar.RecNo;
        cdsBaiCar.Next;
        While RegistroPossuiAMesmaDataELiberacaoVersao10_1(LCodigoAutorizacao, LParcelaLetra) Do
        Begin
          LDifererenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
          LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

          If fBetween(LDifererenca, -LTolerancia, LTolerancia) Then
          Begin

            MarcarCartaoEncontradoArquivo(LValorLiquido,
                                      False,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar);

            If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
            Begin
              If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
                FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
            End;

            Break;
          End;

          cdsBaiCar.Next;

          If cdsBaiCar.Eof Then
            Break;
        End;

        LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
        If Not fBetween(LDifererenca, -LTolerancia, LTolerancia) Then
        Begin
          cdsBaiCar.RecNo := LRegistroAtual;
          FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
        End;

        //verifica se está cadastrado ou já foi baixado no período
        blnAutomatica := cdsConCar.FieldByName('GET_CONCIL').AsString.Equals('1');

        cdsBaixad.First;
        LEncontrado := fBuscaCartaoBaixado(LCodigoAutorizacao,
                                           TGetnetFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('GET_NUMNSU').AsString, 14)), 14),
                                           cdsConCar.FieldByName('CODEMP').AsString,
                                           LParcelaLetra,
                                           cdsConCar.FieldByName('GET_DTATRA').AsDateTime,
                                           True);

        If LEncontrado Then
          FTextoInconsistencia := 'Cartão já foi baixado';
      End;

    End
    Else If FTextoInconsistencia.IsEmpty Then
    Begin
      //verifica se está cadastrado ou já foi baixado no período
      blnAutomatica := cdsConCar.FieldByName('GET_CONCIL').AsString.Equals('1');

      cdsBaixad.First;
      LEncontrado := fBuscaCartaoBaixado(LCodigoAutorizacao,
                                         TGetnetFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('GET_NUMNSU').AsString, 14)), 14),
                                         cdsConCar.FieldByName('CODEMP').AsString,
                                         LParcelaLetra,
                                         cdsConCar.FieldByName('GET_DTATRA').AsDateTime,
                                         True);

      FTextoInconsistencia := 'Cartão já foi baixado';
      If Not LEncontrado Then
        FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
    End;

    {Gerando registro do relatório}
    FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
    If Not FTextoInconsistencia.IsEmpty Then
    Begin
      LRegistroRelatorio.Descricao := FTextoInconsistencia;
      LRegistroRelatorio.SomarNoTotal := 'N';

      If Not MatchStr(LRegistroRelatorio.Descricao, [RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa,
                                                     'Cartão conciliado com valor negociado anteriormente']) Then
      Begin
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
        LRegistroRelatorio.SomarNoTotal := 'S';
      End;
    End;

    LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('GET_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('GET_CODEST').AsString;
    LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
    LRegistroRelatorio.NumeroNSU := TGetnetFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('GET_NUMNSU').AsString, 14)), 14);
    LRegistroRelatorio.CodigoAutorizacao := TGetnetFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('GET_CODAUT').AsString, 6)), 6);
    LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('GET_NUM_RV').AsString;
    LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('GET_NUMCAR').AsString;

    If LRegistroRelatorio.TipoCartao.IsEmpty Then
      LRegistroRelatorio.TipoCartao := LTipoCartao;

    LRegistroRelatorio.Parcela := LParcelaNumero;
    LRegistroRelatorio.TotalParcelas := LTotalParcelas;

    LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('GET_DTAPAG').AsDateTime;
    LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('GET_DTATRA').AsDateTime;
    LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('GET_DTAPAG').AsDateTime;

    LRegistroRelatorio.ValorBruto := LValorBruto;
    LRegistroRelatorio.ValorLiquido := LValorLiquido;

    LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

    cdsConCar.Next;
  End;

  cdsBaiCar.IndexFieldNames := LIndiceAnterior;
  Result := True;
end;

function TConcilGetNet.ProcessaNegociacaoRecebiveis(
  pgbStatus: TcxProgressBar): Boolean;
Var
  LConsulta: TUniQuery;

  LSQL: String;

  LRegistroRelatorio : TItensRelatorioCartoes;

  LDescontoProporcional: Double;
begin
  Result := True;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;

    LSQL := '';
    LSQL := LSQL + ' SELECT A.*, IFNULL(B.GET_VALDES, 0) AS DESCONTO,        ';
    LSQL := LSQL + ' IFNULL(B.GET_VALPAR, 0) AS LIQUIDO,                     ';
    LSQL := LSQL + ' COALESCE(SIS_CODEMP, "") AS CODEMP,                     ';

    If FPossuiCampoCCA_CCAGRA Then
    Begin
      LSQL := LSQL + ' (SELECT POR.POR_CODPOR ';
      LSQL := LSQL + '  FROM CADCCA CCA ';
      LSQL := LSQL + '  LEFT JOIN CADPOR POR ON POR.POR_CCAAUT = CCA.AUTOINCREM ';
      LSQL := LSQL + '  WHERE CCA.CCA_CODEMP = EMP_CODEMP ';
      LSQL := LSQL + '    AND CCA.CCA_CCAGRA=''S'' ';
      LSQL := LSQL + '    AND TRIM(LEADING ''0'' FROM CCA.CCA_CODCTA)=TRIM(LEADING ''0'' FROM B.GET_NUMCCO) ';
      LSQL := LSQL + '    AND TRIM(LEADING ''0'' FROM CCA.CCA_AGENCI)=TRIM(LEADING ''0'' FROM B.GET_CODAGE) ';
      LSQL := LSQL + '    AND TRIM(LEADING ''0'' FROM CCA.CCA_CODBCO)=TRIM(LEADING ''0'' FROM B.GET_CODBCO) ';
      LSQL := LSQL + '  LIMIT 1) AS PORTADOR_GRAVAME, ';
    End
    Else
    Begin
      LSQL := LSQL + ' NULL AS PORTADOR_GRAVAME, ';
    End;

    LSQL := LSQL + ' COALESCE(EMP_NOMEMP, "") AS EMP_NOMEMP                  ';
    LSQL := LSQL + ' FROM GET_GEPGTO A                                       ';
    LSQL := LSQL + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO") AND ';
    LSQL := LSQL + '                     LOCATE(A.GET_CODEST, SIS_VALCFG) > 0 ';
    LSQL := LSQL + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP               ';
    LSQL := LSQL + ' LEFT JOIN GET_GEPGTO B ON B.GET_CODEST=A.GET_CODEST     ';
    LSQL := LSQL + '                       AND B.GET_DTAPAG=A.GET_DTAPAG     ';
    LSQL := LSQL + '                       AND B.GET_TIPPAG=A.GET_TIPPAG     ';
    LSQL := LSQL + '                       AND B.GET_NUMOPE=A.GET_NUMOPE     ';
    LSQL := LSQL + '                       AND B.GET_TIPREG="5"              ';
    LSQL := LSQL + '                       AND B.GET_STATUS IN ("I", "L")    ';

    LSQL := LSQL + ' WHERE A.GET_DTAPAG BETWEEN :DTAIN AND :DTAFIM           ';

    LSQL := LSQL + StringReplace(fRetPesqPonVen(0), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

    LSQL := LSQL + ' AND A.GET_TIPREG="6" ';

    If VS_FuncoesExternas.fICfgSis('GETAGL', varBoolean) then
      LSQL := LSQL + ' AND A.GET_TIPPAG IN ("CS", "AC", "GV", "GL", "AL") '
    else
      LSQL := LSQL + ' AND A.GET_TIPPAG IN ("CS", "AC", "GV") ';
    
    LSQL := LSQL + ' AND A.GET_STATUS IN ("I", "L") ';
    LSQL := LSQL + ' AND A.GET_VALPAR > 0 ';
    LSQL := LSQL + ' AND B.GET_TIPPAG IS NOT NULL ';

    LSQL := LSQL + ' GROUP BY A.GET_TIPREG,A.GET_CODEST,A.GET_NUM_RV,A.GET_DTA_RV,A.GET_DTAPAG,A.GET_NUMPAR,A.GET_CODAUT,A.GET_NUMNSU,A.GET_IDEAJU  ';

    LSQL := LSQL + ' ORDER BY A.GET_CODEST, A.GET_DTAPAG, A.GET_NUMOPE ';

    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('DTAIN').AsDateTime  := StrToDateTime(strDtaIni);
    LConsulta.ParamByName('DTAFIM').AsDateTime := StrToDateTime(strDtaFim);

    LConsulta.Open;

    If LConsulta.IsEmpty THen
    Begin
      If NenhumRegistroPagamentos Then
      Begin
        TGetnetFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados nesse período de recebimento!',['&OK']);
        cdsConCar.Close;
        Result := False;
        blnReabre := True;
      End;

      Exit;
    End;

    If Not Assigned(FRelatorioConciliacao) Then
      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'GETNET',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TGetnetFuncoes.RetornaDataHoraServidor,
                                                            TGetnetFuncoes.RetornaHoraServidor);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := LConsulta.RecordCount;

    While Not LConsulta.Eof Do
    Begin
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.NomeArquivo :=LConsulta.FieldByName('GET_NOMARQ').AsString;

      LRegistroRelatorio.Descricao := 'NEGOCIAÇÃO DE RECEBÍVEIS';
      LRegistroRelatorio.TipoDoRegistro := 'NEGOCIAÇÃO';
      LRegistroRelatorio.TipoCartao := 'ANTECIPAÇÃO';
      LRegistroRelatorio.DescricaoAjuste := 'NEGOCIAÇÃO DE RECEBÍVEIS';


      LRegistroRelatorio.CodigoEmpresa := LConsulta.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('GET_CODEST').AsString;
      LRegistroRelatorio.NumeroNSU := TGetnetFuncoes.fStrZero(Trim(RightStr(LConsulta.FieldByName('GET_NUMOPE').AsString, 14)), 14);
      LRegistroRelatorio.NumeroCartao := EmptyStr;
      LRegistroRelatorio.Parcela := LConsulta.FieldByName('GET_NUMPAR').AsString;
      LRegistroRelatorio.TotalParcelas := LConsulta.FieldByName('GET_NUMPAR').AsString;
      LRegistroRelatorio.CodigoAutorizacao := TGetnetFuncoes.fStrZero(Trim(RightStr(LConsulta.FieldByName('GET_NUMOPE').AsString, 14)), 14);

      LRegistroRelatorio.ResumoVenda := LConsulta.FieldByName('GET_NUMOPE').AsString;

      LRegistroRelatorio.DataVenda := LConsulta.FieldByName('GET_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVencimento := LConsulta.FieldByName('GET_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataPagamento :=  LConsulta.FieldByName('GET_DTAPAG').AsDateTime;

      LRegistroRelatorio.DescricaoBandeira := RetornaBandeiraGetNet(LConsulta.FieldByName('GET_CODPRO').AsString);
      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('GET_CONCIL').AsInteger;

      LRegistroRelatorio.NumeroNegociacao :=LConsulta.FieldByName('GET_NUMOPE').AsString;
      LRegistroRelatorio.RegistroNegociacao := 'S';

      LRegistroRelatorio.ValorBruto :=  LConsulta.FieldByName('GET_VALPAR').AsFloat;

      LDescontoProporcional := TGetnetFuncoes.fFormataFloat(Abs(LConsulta.FieldByName('DESCONTO').AsFloat), 2);
      If LDescontoProporcional <> 0 Then
        LDescontoProporcional := TGetnetFuncoes.fFormataFloat(LDescontoProporcional *
                                               (LConsulta.FieldByName('GET_VALPAR').AsFloat /
                                                LConsulta.FieldByName('LIQUIDO').AsFloat), 2);

      LRegistroRelatorio.ValorLiquido := LConsulta.FieldByName('GET_VALPAR').AsFloat -
                                                           LDescontoProporcional;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      LRegistroRelatorio.RegistroIncompleto :=  RetornaSituacaoCadastroInconsistencias(LConsulta.FieldByName('CODEMP').AsString);

      //LRegistroRelatorio.RegistroIncompleto := 'N';
      If FBaixarAjustes Then
      Begin
        //LRegistroRelatorio.RegistroIncompleto := ConfiguracoesNegociacaoEstaoIncompletas(LConsulta.FieldByName('CODEMP').AsString);

        if MatchStr(LConsulta.FieldByName('GET_TIPPAG').AsString, ['GL', 'AL']) then
        begin
          if LRegistroRelatorio.ValorLiquido <> 0 then
            GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, LConsulta);
        end
        else
          GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, LConsulta);
      End;

      //If LConsulta.FieldByName('GET_CONCIL').AsInteger <> 1 Then
      //  GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, LConsulta);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LConsulta.Next;

      TGetnetFuncoes.pStepStatusGravacao(pgbStatus, '');
    End;
  Finally
    TGetnetFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilGetNet.RegistroPossuiAMesmaDataELiberacaoVersao10_1(ACodigoAutorizacao, AParcelaLetra: String): Boolean;
begin
  Result := False;

  If Not cdsBaiCar.FieldByName('MCA_NUMCCD').AsString.Equals(ACodigoAutorizacao) Then
    Exit;

  If Not cdsBaiCar.FieldByName('PARDUP').AsString.Equals(AParcelaLetra) Then
    Exit;

  If Not cdsConCar.FieldByName('CODEMP').AsString.IsEmpty Then
  Begin
    If Not cdsBaiCar.FieldByName('MCA_EMPRCX').AsString.Equals(cdsConCar.FieldByName('CODEMP').AsString) Then
      Exit;
  End;

  If Not cdsBaiCar.FieldByName('MCA_DTACUP').AsString.Equals(cdsConCar.FieldByName('GET_DTATRA').AsString) Then
    Exit;

  Result := cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('D');
end;

function TConcilGetNet.RetornaBandeiraGetNet(ACodigoProduto: String): String;
begin
  Result := 'OUTROS';

  If ACodigoProduto.IsEmpty Then
    Exit;

  If MatchStr(ACodigoProduto, ['SM', 'BM', 'CM', 'PC', 'SR', 'PM', 'PT']) Then
    Result := 'MASTERCARD'
  Else If MatchStr(ACodigoProduto, ['SV', 'BV', 'CV', 'PS', 'SE', 'PV', 'PN']) Then
    Result := 'VISA'
  Else If MatchStr(ACodigoProduto, ['AC', 'CA', 'PX']) Then
    Result := 'AMEX'
  Else If MatchStr(ACodigoProduto, ['PE', 'EC', 'ED', 'CL', 'PL', 'PO']) Then
    Result := 'ELO'
  Else If MatchStr(ACodigoProduto, ['HC', 'CH', 'PH']) Then
    Result := 'HIPERCARD';
end;

function TConcilGetNet.RetornaSQLRegistrosConciliacao: String;
begin
  Result := 'SELECT * FROM (';
  Result := Result + ' SELECT G.*, COALESCE(SIS_CODEMP, "") AS CODEMP, ';
  Result := Result + ' EMP_NOMEMP FROM GET_GEPGTO G                    ';
  Result := Result + ' LEFT JOIN CFGSIS ON SIS_VALCFG=G.GET_CODEST     ';
  Result := Result + ' AND SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO")  ';
  Result := Result + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP       ';
  Result := Result + ' WHERE G.GET_DTAPAG BETWEEN :DTAIN AND :DTAFIM   ';
  Result := Result + '   AND G.GET_TIPREG NOT IN ("NR", "AC")          ';
  Result := Result + '   AND (G.GET_VERARQ IS NULL OR G.GET_VERARQ NOT IN ("10.1", "10.3")) ';
  Result := Result + '   AND (SELECT COUNT(*) FROM GET_GEPGTO E        ';
  Result := Result + '        WHERE E.GET_TIPREG = "AJ"                ';
  Result := Result + '          AND E.GET_DTAPAG < G.GET_DTAPAG        ';
  Result := Result + '          AND E.GET_NUMNSU = G.GET_NUMNSU        ';
  Result := Result + '          AND E.GET_DTATRA = G.GET_DTATRA        ';
  Result := Result + '          AND E.GET_NUM_RV = G.GET_NUM_RV        ';
  Result := Result + '          AND E.GET_CODEST = G.GET_CODEST        ';
  Result := Result + '          AND E.GET_NUMPAR = G.GET_NUMPAR) = 0   ';

  Result := Result + '   AND (SELECT COUNT(*) FROM GET_GEPGTO E        ';
  Result := Result + '        WHERE E.GET_TIPREG = "AC"                ';
  Result := Result + '          AND E.GET_NUM_RV = G.GET_NUM_RV        ';
  Result := Result + '          AND E.GET_CODEST = G.GET_CODEST        ';
  Result := Result + '          AND E.GET_VENORI = G.GET_DTAPAG        ';
  Result := Result + '          AND E.GET_NUMPAR = G.GET_NUMPAR) = 0   ';

  Result := Result + '   AND (SELECT COUNT(*) FROM GET_GEPGTO E        ';
  Result := Result + '        WHERE E.GET_TIPREG = "CS"                ';
  Result := Result + '          AND E.GET_NUM_RV = G.GET_NUM_RV        ';
  Result := Result + '          AND E.GET_CODEST = G.GET_CODEST        ';
  Result := Result + '          AND E.GET_VENORI = G.GET_DTAPAG        ';
  Result := Result + '          AND E.GET_NUMPAR = G.GET_NUMPAR) = 0   ';
  Result := Result + fRetPesqPonVen(0);
  Result := Result + ' GROUP BY GET_TIPREG,GET_CODEST,GET_NUM_RV,GET_DTA_RV,GET_DTAPAG,GET_NUMPAR,GET_CODAUT,GET_NUMNSU,GET_IDEAJU  ';

  Result := Result + ' UNION ';

  Result := Result + ' SELECT G.*, COALESCE(SIS_CODEMP, "") AS CODEMP, ';
  Result := Result + ' EMP_NOMEMP FROM GET_GEPGTO G                    ';
  Result := Result + ' LEFT JOIN CFGSIS ON SIS_VALCFG=G.GET_CODEST     ';
  Result := Result + ' AND SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO")  ';
  Result := Result + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP       ';
  Result := Result + ' WHERE G.GET_DTAPAG BETWEEN :DTAIN AND :DTAFIM   ';
  Result := Result + '   AND G.GET_TIPREG IN ("AC")                    ';
  Result := Result + '   AND G.GET_VENORI > G.GET_DTAPAG               ';
  Result := Result + '   AND G.GET_VALPAG > 0                          ';
  Result := Result + '   AND (G.GET_VERARQ IS NULL OR G.GET_VERARQ NOT IN ("10.1", "10.3")) ';
  Result := Result + fRetPesqPonVen(0);
  Result := Result + ' GROUP BY GET_TIPREG,GET_CODEST,GET_NUM_RV,GET_DTA_RV,GET_DTAPAG,GET_NUMPAR,GET_CODAUT,GET_NUMNSU,GET_IDEAJU  ';

  Result := Result + ') VERSOESANTERIORES ';
end;

function TConcilGetNet.RetornaSQLRegistrosConciliacaoVersao10_1: String;
begin
  Result := 'SELECT * FROM ( ';
  Result := Result + 'SELECT G.*, COALESCE(SIS_CODEMP, "") AS CODEMP, ';
  Result := Result + '       EMP_NOMEMP ';
  Result := Result + 'FROM GET_GEPGTO G                    ';
  Result := Result + 'LEFT JOIN CFGSIS ON SIS_VALCFG=G.GET_CODEST     ';
  Result := Result + '                AND SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO")  ';
  Result := Result + 'LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP       ';
  Result := Result + 'WHERE G.GET_DTAPAG BETWEEN :DTAIN AND :DTAFIM   ';
  Result := Result + '  AND G.GET_TIPREG = "2" ';
  Result := Result + '  AND G.GET_STATUS = "C" ';
  Result := Result + '  AND G.GET_TIPPAG = "LQ" ';
  Result := Result + '  AND G.GET_VERARQ IN ("10.1", "10.3") ';
  Result := Result + fRetPesqPonVen(0);
  Result := Result + ' GROUP BY GET_TIPREG,GET_CODEST,GET_NUM_RV,GET_DTA_RV,GET_DTAPAG,GET_NUMPAR,GET_CODAUT,GET_NUMNSU,GET_IDEAJU  ';

  Result := Result + ') VERSAO101 ';
end;

function TConcilGetNet.RetornaSQLWhereRegistrosAjustesVersao10_1: String;
begin
  Result := ' AND A.GET_VERARQ IN ("10.1", "10.3") ';
  Result := Result + ' AND ((A.GET_TIPREG = "3" AND ';
  Result := Result + '       A.GET_TIPPAG = "LQ") ) ';
  Result := Result + ' AND A.GET_MOTAJU <> "17" ';

end;

function TConcilGetNet.RetornaTipoCartaoVersao10_1(
  ATipoProduto: String): String;
  Const
    CARTAO_CREDITO: Array Of String = ['SM', 'SV', 'BM', 'BV', 'EC','AC',
                                       'HC', 'CM', 'CV', 'CL', 'CA','CH',
                                       'PC', 'PS', 'PL', 'PH', 'PX'];
begin
  Result := 'DÉBITO';
  If MatchStr(ATipoProduto, CARTAO_CREDITO) Then
    Result := 'CRÉDITO ROTATIVO';
end;

procedure TConcilGetNet.AdicionaDiferencas(AEstabelecimento: String;
  ADataRecebimento: TDateTime; AValorLiquido: Double);
  Var
    LEncontrou: Boolean;

    LContador: Integer;
begin
  LEncontrou := False;

  For LContador := 0 To Length(ArrayDiferencas) - 1 Do
  Begin
    LEncontrou := Concat(ArrayDiferencas[LContador].Estabelecimento,
                         FormatDateTime('ddmmyyyy', ArrayDiferencas[LContador].DataRecebimento))
                    .Equals(Concat(AEstabelecimento,
                            FormatDateTime('ddmmyyyy', ADataRecebimento)));

    If LEncontrou Then
    Begin
      ArrayDiferencas[LContador].ValorLiquido := ArrayDiferencas[LContador].ValorLiquido +
                                                 AValorLiquido;
      Break;
    End;
  End;

  If Not LEncontrou Then
  Begin
    LContador := Length(ArrayDiferencas) + 1;
    SetLength(ArrayDiferencas, LContador);

    ArrayDiferencas[LContador - 1].Estabelecimento := AEstabelecimento;
    ArrayDiferencas[LContador - 1].DataRecebimento := ADataRecebimento;
    ArrayDiferencas[LContador - 1].ValorLiquido := AValorLiquido;
  End;
end;

constructor TConcilGetNet.Create;
begin
  inherited;

end;

destructor TConcilGetNet.Destroy;
begin
  TGetNetFuncoes.FreeAndNilDatasets(FCloneDatasetConCar);

  SetLength(ArrayDiferencas, 0);
  inherited;
end;

function TConcilGetNet.fConciliaCartoes: Boolean;
begin
  Result := false;

  objConcil.TabelaConciliacao := 'GET_GEPGTO';
  objConcil.CampoEstabelecimento := 'GET_CODEST';
  objConcil.NomeConciliacao := 'GETNET';
  objConcil.CfgEstabelecimentos := 'CFG_GETEST';
  objConcil.CampoValorBruto := 'GET_VALPAR';
  objConcil.CampoValorLiquido := 'GET_RV_LIQ';
  objConcil.CampoCodigoAutorizacao := 'GET_CODAUT';
  objConcil.CampoNumeroNSU := 'GET_NUMNSU';
  objConcil.CampoDataTransacaoVenda := 'GET_DTAPAG';
  objConcil.CampoNumeroParcela := 'GET_NUMPAR';
  objConcil.CampoTotalParcelas := 'GET_TOTPAR';
  objConcil.CampoNumeroCartao := 'GET_NUMCAR';
  objConcil.CampoDataRecebimento := 'GET_DTAPAG';
  objConcil.CampoTipoRegistro := 'GET_TIPREG';
  objConcil.CampoTipoTransacao := 'GET_MOTAJU';
  objConcil.CfgPortadorAjustes := 'GETPOR';
  objConcil.CfgPlanoDeContasAjustes := 'GETCTA';
  objConcil.CfgFornecedorAjustes := 'GETFOR';
  objConcil.strConfCp := 'GETCTP';
  objConcil.strEventoCancelamentoAjuste := 'GETEVE';
  objConcil.CfgVlrTolerancia := 'GETTOL';
  objConcil.strChavePrimaria := 'GET_TIPREG,GET_CODEST,GET_NUM_RV,GET_DTA_RV,GET_DTAPAG,GET_NUMPAR,GET_CODAUT,GET_NUMNSU';

  SetLength(ArrayDiferencas, 0);
  If Assigned(FListaRegistrosRelatorio) Then
    FListaRegistrosRelatorio.Clear;

  If Not fDigPeriodo Then
    Exit;

  Result := TGetnetFuncoes.ExecutaAguarde(fConciliaGetNet, 'Aguarde... Filtrando registros do período.');
end;

function TConcilGetNet.fConciliaGetNet(prgStatus: TcxProgressBar): Boolean;
Begin
  Result := False;
  Try
    Try
      TGetnetFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação  (' + objConcil.NomeConciliacao + ').', False);
      fProcessaGetNetPag(prgStatus);

      TGetnetFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Processando diferenças de recebíveis (' + objConcil.NomeConciliacao + ').', False);
      ProcessaDiferencaGrupo5(prgStatus);

      TGetnetFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (' + objConcil.NomeConciliacao + ').', False);
      ProcessaGetNetVersao10_1(prgStatus);

      cdsConCar.Filter := EmptyStr;
      cdsConCar.Filtered := False;

      TGetnetFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Processando negociação de recebíveis (' + objConcil.NomeConciliacao + ').', False);
      ProcessaNegociacaoRecebiveis(prgStatus);

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TGetnetFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros do relatório (GETNET).', False);
      GravarRegistrosRelatorio(prgStatus);

      GetParentForm(prgStatus).Hide;

      If FPossuiInconsistencia Then
        TGetnetFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      If FListaRegistrosRelatorio.Count > 0 Then
        Result := GeraRelatorioConciliacao('GETNET', prgStatus);

      If Assigned(cdsAjustes) Then
      Begin
        cdsAjustes.Filter   := 'GET_CONCIL=0';
        cdsAjustes.Filtered := True;
      End;

      blnReabre := Not Result;
      If Result Then
      Begin
        cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        cdsBaiCar.Filtered := True;

        Result := Not cdsBaiCar.IsEmpty;
        If Not Result Then
          TGetnetFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
        Else
          TGetnetFuncoes.fMensagem('AVISO','Conciliação da GETNET realizada com sucesso.',['&OK']);
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConciliaGetNet]');
      End;
    End;
  Finally
    TGetNetFuncoes.FreeAndNilDatasets(cdsConCar);
    TGetNetFuncoes.FreeAndNilDatasets(cdsAjustes);
    TGetNetFuncoes.FreeAndNilDatasets(cdsBaixad);
    TGetNetFuncoes.FreeAndNilDatasets(FCloneDatasetConCar);

    If Assigned(FListaRegistrosRelatorio) Then
      FreeAndNil(FListaRegistrosRelatorio);

    SetLength(ArrayDiferencas, 0);
  End;
End;

function TConcilGetNet.RegistroPossuiAMesmaAutorizacao(AAutorizacao, AParcela,
  AEmpresa, ADataCupom: String): Boolean;
begin
  Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString.Equals(AAutorizacao);

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('PARDUP').AsString.Equals(AParcela);

  If Not Result Then
    Exit;

  If Not cdsConCar.FieldByName('CODEMP').AsString.IsEmpty Then
  Begin
    Result := cdsBaiCar.FieldByName('MCA_EMPRCX').AsString.Equals(AEmpresa);

    If Not Result Then
      Exit;
  End;

  Result := cdsBaiCar.FieldByName('MCA_DTACUP').AsString.Equals(ADataCupom);

  If Not Result Then
    Exit;
end;

function TConcilGetNet.fProcessaGetNetPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LValorbruto   : Double;
  fltDifere  : Double;
  strIndAnt  : String;
  intRecNo   : Integer;
  LValorLiquido  : Double;
  blnBusca   : Boolean;
  strTipo    : String;
  strCondicao: String;

  LSQL,
  LChaveConciliacao,
  LCodigoAutorizacao,
  LParcela: String;

  prcScroll: TprcScroll;

  LConsulta: TUniQuery;

  LDataFinal014,
  LDataInicialDigitada: TDateTime;

  LRegistroRelatorio: TItensRelatorioCartoes;
begin
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  FTextoInconsistencia := '';
  LDataFinal014 := EncodeDate(2024, 04, 20);

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SHOW TABLES LIKE "GET_GEPGTO"';
    LConsulta.Open;
    If LConsulta.IsEmpty Then
    Begin
      TGetnetFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação da GETNET!',['&OK']);
      Exit(False);
    End;

    //Selecionando a tabela de importação de pagamentos da GETNET
    LSQL := 'SELECT * FROM (' +
            TGetnetFuncoes.IIF(dtaDtaIni <= LDataFinal014, RetornaSQLRegistrosConciliacao + ' UNION ALL ', EmptyStr) +
            RetornaSQLRegistrosConciliacaoVersao10_1 +
            ') TMP ' +
            ' ORDER BY GET_TIPREG, GET_DTAPAG ';

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
    LConsulta.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);

    LConsulta.Open;

    cdsConCar := TGetnetFuncoes.CriarClientDataSet(LConsulta);
    cdsConCar.Open;

    LConsulta.First;
    FCloneDatasetConCar := TGetnetFuncoes.CriarClientDataSet(LConsulta);
    FCloneDatasetConCar.Open;
  Finally
    TGetNetFuncoes.FreeAndNilDatasets(LConsulta);
  End;

  LDataInicialDigitada := dtaDtaIni;

  //Para os Ajustes  - Tem que estar antes para não pegar outros ajustes de outras datas
  FCondicaoAjustes := 'GET_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ' +
                      StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

  pCalculaPeriodoFiltro('GET_DTATRA');
  pCalculaPeriodoFiltroAntecipacao;

  //Filtrando Cartões na MOVCAR
  TGetnetFuncoes.AguardeExecutarModalA(pFiltraCartoes,'Aguarde... Filtrando registros.','');

  //Filtrando Cancelamentos/Ajustes
  strCondicao := FCondicaoAjustes;
  strCondicao := strCondicao + ' AND (GET_MOTAJU IS NOT NULL) AND (GET_TIPREG="AJ") AND (GET_RV_LIQ<>0) ' +
                               ' AND (GET_TIPPAG IS NULL OR GET_TIPPAG ="PG") AND (GET_VERARQ IS NULL OR GET_VERARQ NOT IN ("10.1", "10.3")) AND ' +
                               '  (GET_CODAUT, GET_NUMNSU, GET_CODEST, GET_NUMPAR, GET_DTAPAG) NOT IN     ' +
                               '  (SELECT G.GET_CODAUT, G.GET_NUMNSU, G.GET_CODEST, G.GET_NUMPAR, G.GET_DTAPAG      ' +
                               '   FROM GET_GEPGTO G WHERE G.GET_MOTAJU IS NULL AND G.GET_DTAPAG=GET_DTAPAG)        ';

  If LDataInicialDigitada > LDataFinal014 Then
    strCondicao := ' FALSE ';

  FiltrarCancelamentosPeriodo(strCondicao,
                       RetornaSQLTiposDeAjustes,
                       ' IF(GET_VALPAG > 0, IF(IFNULL(GET_TIPPAG, "PG")<>"AC", GET_VALPAG, GET_VALPAG-GET_VALDES), 0) ');

  GerarAjustesDeAntecipacaoAC;

  //Selecionando cartões já baixados/cadastrados no período
  pFiltraCartoesBaixados(True);

  cdsConCar.Filter := 'GET_VERARQ IS NULL OR (GET_VERARQ<>''10.1'' AND GET_VERARQ<>''10.3'') ';
  cdsConCar.Filtered := True;

  If (cdsConCar.IsEmpty) And
     ((Not Assigned(cdsAjustes)) Or (cdsAjustes.IsEmpty)) Then
  Begin
    Result := False;
    blnReabre := True;
    Exit;
  End;

  If NenhumRegistroPagamentos Then
    Exit(False);

  If Not Assigned(FRelatorioConciliacao) Then
    FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                          'GETNET',
                                                          'CONCILIACAO',
                                                          RetornaFiltrosdigitados,
                                                          TGetnetFuncoes.RetornaDataHoraServidor,
                                                          TGetnetFuncoes.RetornaHoraServidor);

  TGetnetFuncoes.pDisableControls(cdsBaiCar, prcScroll);

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := cdsConCar.RecordCount;

  cdsConCar.First;
  While Not cdsConCar.EOF do
  Begin
    TGetnetFuncoes.pStepStatusGravacao(pgbStatus);
    FTextoInconsistencia := '';

    LCodigoAutorizacao := TGetnetFuncoes.fStrZero(Copy(Trim(cdsConCar.FieldByName('GET_CODAUT').Value), 5, 6), 6);
    LParcela := TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('GET_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('GET_NUMPAR').AsString)));

    If cdsConCar.FieldByName('GET_TIPREG').Value = 'PG' Then
    Begin
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      strTipo := fVerificaTipo(cdsConCar.FieldByName('GET_TIPPAG').AsString);
      If (strTipo = 'CRÉDITO') Then
        strTipo := TGetnetFuncoes.IIF(cdsConCar.FieldByName('GET_TOTPAR').AsInteger > 1,
                       'CRÉDITO PARCELADO',
                       'CRÉDITO ROTATIVO');

      LValorbruto  := cdsConCar.FieldByName('GET_VALPAR').Value;
      LValorLiquido := LValorbruto * (cdsConCar.FieldByName('GET_RV_LIQ').Value / cdsConCar.FieldByName('GET_RV_BRU').Value);

      AdicionaDiferencas(cdsConCar.FieldByName('GET_CODEST').AsString,
                         cdsConCar.FieldByName('GET_DTAPAG').AsDateTime,
                         LValorLiquido);

      blnBusca := fBuscaCartao(TGetnetFuncoes.fStrZero(Copy(Trim(cdsConCar.FieldByName('GET_CODAUT').Value), 5, 6), 6),
                               TGetnetFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('GET_NUMNSU').Value, 14)), 14),
                               cdsConCar.FieldByName('CODEMP').AsString,
                               TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('GET_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('GET_NUMPAR').AsString))),
                               cdsConCar.FieldByName('GET_DTATRA').AsDateTime,
                               0,
                               True);

      If blnBusca Then
      Begin
        fltDifere := TGetnetFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorbruto,6);
        LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
        If fBetween(fltDifere, -LTolerancia, LTolerancia) Then
        Begin
          LChaveConciliacao := 'GET_' + IntToStr(StrtoInt64(cdsConCar.FieldByName('GET_NUM_RV').Value)) + '_' +
                        cdsConCar.FieldByName('GET_CODAUT').Value + '_' + TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('GET_NUMPAR').AsString = '0', '1', cdsConCar.FieldByName('GET_NUMPAR').AsString))) + '_' +
                        cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                        FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('GET_DTATRA').Value);


           MarcarCartaoEncontradoArquivo(LValorLiquido,
                                        False,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar);
        End
        Else
        Begin
          //Verificando outras liberações com a mesma data
          intRecNo := cdsBaiCar.RecNo;
          cdsBaiCar.Next;
          While RegistroPossuiAMesmaAutorizacao(LCodigoAutorizacao,
                                                LParcela,
                                                cdsConCar.FieldByName('CODEMP').AsString,
                                                cdsConCar.FieldByName('GET_DTATRA').AsString)
          Do
          Begin
            fltDifere := TGetnetFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorbruto,6);
            LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

            If fBetween(fltDifere, -LTolerancia, LTolerancia) Then
            Begin
              LChaveConciliacao := 'GET_' + IntToStr(StrtoInt64(cdsConCar.FieldByName('GET_NUM_RV').Value)) + '_' +
                             cdsConCar.FieldByName('GET_CODAUT').Value + '_' + TGetnetFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('GET_NUMPAR').AsString = '0', '1', cdsConCar.FieldByName('GET_NUMPAR').AsString))) + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('GET_DTATRA').Value);

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                                        False,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar);

              Break;
            End;


            cdsBaiCar.Next;

            If cdsBaiCar.Eof Then
              Break;
          End;
          LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
          If Not (fBetween(fltDifere, -LTolerancia, LTolerancia)) Then
          Begin
            cdsBaiCar.RecNo := intRecNo;
            FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
          End;

        End;

      End
      Else If TGetnetFuncoes.fEmptyStr(FTextoInconsistencia) Then
      Begin
        //verifica se está cadastrado ou já foi baixado no período
        blnAutomatica := cdsConCar.FieldByName('GET_CONCIL').Value = '1';
        If cdsConCar.FieldByName('GET_CONCIL').Value = '0' Then
        Begin
          cdsBaixad.First;
          blnBusca := fBuscaCartaoBaixado(LCodigoAutorizacao,
                                          TGetnetFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('GET_NUMNSU').Value, 14)), 14),
                                          cdsConCar.FieldByName('CODEMP').AsString,
                                          LParcela,
                                          cdsConCar.FieldByName('GET_DTATRA').Value);
          If Not blnBusca Then
            FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema'
          Else
            FTextoInconsistencia := 'Cartão já foi baixado';
        End
        Else
          FTextoInconsistencia := 'Cartão já foi baixado';
      End;

      If TGetnetFuncoes.fEmptyStr(FTextoInconsistencia) Then
      Begin
        If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorbruto, cdsBaiCar) Then
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

      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('GET_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('GET_CODEST').Value;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('GET_NUMNSU').AsString;
      LRegistroRelatorio.CodigoAutorizacao := TGetnetFuncoes.fStrZero(Copy(Trim(cdsConCar.FieldByName('GET_CODAUT').Value), 5, 6), 6);
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('GET_NUM_RV').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('GET_NUMCAR').Value;

      If LRegistroRelatorio.TipoCartao.IsEmpty Then
        LRegistroRelatorio.TipoCartao := strTipo;

      LRegistroRelatorio.Parcela := cdsConCar.FieldByName('GET_NUMPAR').Value;
      LRegistroRelatorio.TotalParcelas := cdsConCar.FieldByName('GET_TOTPAR').Value;

      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('GET_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('GET_DTATRA').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('GET_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := LValorbruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

    End
    Else If MatchStr(cdsConCar.FieldByName('GET_TIPREG').AsString, ['AC','CS']) Then
    Begin
      pAntecipacoes(pgbStatus);
      If Not cdsConCar.Eof Then
        cdsConCar.Prior;
    End;

    cdsConCar.Next;
  End;

  cdsBaiCar.IndexFieldNames := strIndAnt;
  Result := True;
end;

function TConcilGetNet.RetornaSQLTiposDeAjustes: String;
begin
  Result := 'CASE A.GET_MOTAJU ' +
            'WHEN "01" THEN IF(A.GET_VALPAG > 0, "AJUSTE À CRÉDITO", "AJUSTE À DÉBITO") ' +
            'WHEN "02" THEN "ALUGUEL DE POS" ' +
            'WHEN "03" THEN "CANCELAMENTO" ' +
            'WHEN "04" THEN "CHARGEBACK" ' +
            'WHEN "05" THEN "RECARGA TELECOM" ' +
            'WHEN "06" THEN "BILHETAGEM" ' +
            'WHEN "07" THEN "CONSULTA SERASA" ' +
            'WHEN "08" THEN "ALUGUEL DE VERTICAIS" ' +
            'WHEN "09" THEN "CARGA E RECARGA CARTÃO PRÉ PAGO" ' +
            'WHEN "10" THEN "MANUTENÇÃO DE CARTÃO" ' +
            'WHEN "11" THEN "VENDA DE CARTÃO" ' +
            'WHEN "12" THEN "CANCELAMENTO COM MOTIVO DE ESTORNO" ' +
            'WHEN "13" THEN "RECARGA COM CARTÃO" ' +
            'WHEN "14" THEN "PLATAFORMA DIGITAL" ' +
            'WHEN "15" THEN "GETDATA" ' +
            'WHEN "16" THEN "REVERSÃO DE CHARGEBACK" ' +
            'WHEN "20" THEN "DÉBITO DE ANTECIPAÇÃO" ' +
            'WHEN "23" THEN "CRÉDITO DE COMPENSAÇÃO" ' +
            'WHEN "24" THEN "DÉBITO DE COMPENSAÇÃO" ' +
            'WHEN "25" THEN "ESTORNO" ' +
            'ELSE ' +
            '  CASE A.GET_TIPPAG ' +
            '  WHEN "CS" THEN "LIQUIDAÇÃO DE CESSÃO" ' +
            '  WHEN "AL" THEN "LIQUIDAÇÃO DE ANTECIPAÇÃO" ' +
            '  WHEN "GL" THEN "LIQUIDAÇÃO DE GRAVAME" ' +
            '  ELSE "OUTROS" END ' +
            'END ';
end;

end.
