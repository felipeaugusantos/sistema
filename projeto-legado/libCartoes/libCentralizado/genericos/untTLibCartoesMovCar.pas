unit untTLibCartoesMovCar;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, Data.DB, System.Variants,

     Uni,

     untTLibCartoesFuncoes, untLibCartoesInterfacesTipos, untTBatchSQL,
     untTBatchSQL.Helper;

Type
  TLibCartoesMovCar = class
  private
    class var FCFG_USAAUT: String;

    class function TransferenciaLiberada(AUsaLiberacaoTransferencia,
                                         AVeioResumoCaixa: Boolean;
                                         ACartaoLiberado: String): Boolean;

    class function PercentualTaxaLog(AValorTaxa, AValorBruto: Double;
                                     ABrutoNulo: Boolean): Variant;
  public
    class function CartaoBloqueado(ADataset: TDataset;
                                   AValorRcxTcc: String): Boolean;

    class function fGetSQLCartoes(objConcil: TCamposConcil): String;

    class procedure AtualizarConciliacaoConfirmacaoCartao(ANumNsu,ANumCcd,AParcel,AOperadora: String; ADtaCup : TDateTime);
    class procedure LimparConciliacaoConfirmacaoCartao(ANumNsu,ANumCcd,AParcel,AOperadora: String; ADtaCup : TDateTime);

    class function BaixaCartao(ANomeFormularioLogMca,
                               ADescricaoLogMca,
                               AAutoIncrem,
                               ANumeroDuplicata,
                               AParcela,
                               ACodigoCliente,
                               ACodigoEmpresa: String;
                               ADataRecebimento: TDateTime;
                               AValorRecebido: Double;
                               AOperadorBaixa,
                               AHistoricoBaixa,
                               APortadorBaixa,
                               APlanoDeContasBaixa,
                               ASeqLanCredito,
                               APortadorTaxa,
                               APlanoDeContasTaxa,
                               ASeqLanTaxa,
                               AFornecedorTaxa,
                               APlanoDeContasDebito,
                               APortadorDebito: String;
                               ASeqlanDebito: String;
                               AChaveConciliacao: String = '';
                               ACentroCustosDebito: String = '';
                               APlanoContasAntecipacao: String = '';
                               ASeqLanAntecipacao: String = '';
                               ATaxaAntecipacao: Double = 0;
                               AAutoIncremLogMca: String = '';
                               ACentroCustoCredito : string = '';
                               ACentroCustoTaxa : string = '';
                               AFreteMarketPlace: Double = 0.00;
                               AAjusteMarketPlace: Double = 0.00;
                               AValorTaxaMarketPlace: Double = 0.00;
                               ACupomMarketPlace: Double = 0.00;
                               ADeveAtualizarValorBruto: Boolean = False;
                               ANovoValorBruto: Double = 0.00;
                               ASeqLanFrete: String = '';
                               ASeqLanAjuste: String = '';
                               ASeqLanCupom: String = '';
                               ABatchSQL: TBatchSQL = Nil;
                               ADataMovimentoBancario: TDateTime = 0): Boolean;
  end;

implementation
Uses System.Math, untLibCartoesLogMca;
{ TLibCartoesMovCar }

class procedure TLibCartoesMovCar.AtualizarConciliacaoConfirmacaoCartao(ANumNsu,
  ANumCcd, AParcel, AOperadora: String; ADtaCup: TDateTime);
  Var
    LExtMca: TUniQuery;
Begin
  LExtMca := Nil;
  Try
    LExtMca := VS_FuncoesExternas.fICriaQuery;

    LExtMca.SQl.Text := 'UPDATE EXTMCA SET EXT_DTACLO = CURRENT_DATE,          '+
                        '                  EXT_HORCLO = CURRENT_TIME,           '+
                        '                  EXT_OPECLO = :OPECLO                '+
                        'WHERE ((EXT_CODAUT = :CODAUT AND EXT_CODAUT <> "")    '+
                        '    OR (EXT_NUMNSU = :NUMNSU AND EXT_NUMNSU <> ""))   '+
                        '    AND EXT_PARCEL = :PARCEL                          '+
                        '    AND EXT_DTACUP = :DTACUP                          '+
                        '    AND EXT_NOMCON = :NOMCON                          ';

    LExtMca.ParamByName('OPECLO').AsString := VS_FuncoesExternas.fIRetOperadorLogado;

    LExtMca.ParamByName('CODAUT').AsString   := ANumCcd;
    LExtMca.ParamByName('NUMNSU').AsString   := ANumNsu;
    LExtMca.ParamByName('PARCEL').AsString   := AParcel;
    LExtMca.ParamByName('DTACUP').AsDateTime := ADtaCup;
    LExtMca.ParamByName('NOMCON').AsString   := AOperadora;
    LExtMca.ExecSQL;
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LExtMca);
  End;
end;

class function TLibCartoesMovCar.BaixaCartao(ANomeFormularioLogMca,
  ADescricaoLogMca, AAutoIncrem, ANumeroDuplicata, AParcela, ACodigoCliente,
  ACodigoEmpresa: String; ADataRecebimento: TDateTime; AValorRecebido: Double;
  AOperadorBaixa, AHistoricoBaixa, APortadorBaixa, APlanoDeContasBaixa,
  ASeqLanCredito, APortadorTaxa, APlanoDeContasTaxa, ASeqLanTaxa,
  AFornecedorTaxa, APlanoDeContasDebito, APortadorDebito, ASeqlanDebito,
  AChaveConciliacao, ACentroCustosDebito, APlanoContasAntecipacao,
  ASeqLanAntecipacao: String; ATaxaAntecipacao: Double; AAutoIncremLogMca,
  ACentroCustoCredito, ACentroCustoTaxa: string; AFreteMarketPlace,
  AAjusteMarketPlace, AValorTaxaMarketPlace, ACupomMarketPlace: Double;
  ADeveAtualizarValorBruto: Boolean; ANovoValorBruto: Double; ASeqLanFrete,
  ASeqLanAjuste, ASeqLanCupom: String; ABatchSQL: TBatchSQL;
  ADataMovimentoBancario: TDateTime): Boolean;
  Var
    LAtualizar: TUniQuery;

    LAjustarLog: TAjusteLogMca;

    LRecalculaTaxa: Boolean;

    LSQL,
    LPercentualTaxa: String;
begin
  LAtualizar := Nil;
  Try
    LRecalculaTaxa := AFreteMarketPlace = 0;
    If LRecalculaTaxa Then
    Begin
      LRecalculaTaxa := AAjusteMarketPlace = 0;

      If LRecalculaTaxa Then
        LRecalculaTaxa := ACupomMarketPlace = 0;
    End;

    LPercentualTaxa := '  MCA_PERCAR = (MCA_VALSTA - MCA_VALREC) / MCA_VALSTA * 100, ';
    If AChaveConciliacao.IsEmpty Then
    Begin
      If LRecalculaTaxa Then
        LPercentualTaxa := '  MCA_PERCAR = IF(MCA_VALTAX<>(MCA_VALSTA - MCA_VALREC), (MCA_VALSTA - MCA_VALREC) / MCA_VALSTA * 100, MCA_PERCAR), ';
    End;

    Try
      LAtualizar := VS_FuncoesExternas.fICriaQuery;

      LSQL := '';
      LSQL := LSQL + 'UPDATE ';
      LSQL := LSQL + '  MOVCAR ';
      LSQL := LSQL + 'SET ';
      LSQL := LSQL + '  MCA_VALANT = MCA_VALORI, ';
      LSQL := LSQL + '  MCA_TAXANT = MCA_VALTAX, ';
      LSQL := LSQL + '  MCA_FREANT = MCA_FREMKT, ';
      LSQL := LSQL + '  MCA_CUPANT = MCA_CUPMKT, ';
      LSQL := LSQL + '  MCA_BRUANT = MCA_VALSTA, ';

      If ADeveAtualizarValorBruto Then
      Begin
        If ANovoValorBruto > 0 Then
          LSQL := LSQL + ' MCA_VALSTA = :VALSTA, ';
      End;

      LSQL := LSQL + '  MCA_VALDUP = 0, ';
      LSQL := LSQL + '  MCA_DTAREC = :DTAREC, ';
      LSQL := LSQL + '  MCA_VALREC = :VALREC, ';
      LSQL := LSQL + '  MCA_VALORI = :VALREC, '; //ATUALIZANDO O VALORI PARA O VALREC (REQ 60844)

      If LRecalculaTaxa Then
      Begin
        LSQL := LSQL + LPercentualTaxa; // RECALCULA O VALOR DA TAXA
        LSQL := LSQL + '  MCA_VALTAX = (MCA_VALSTA - MCA_VALREC), '; // RECALCULA VALOR DA TAXA
      End
      Else
        LSQL := LSQL + '  MCA_VALTAX = :VALTAX, ' +
                       '  MCA_PERCAR = (:VALTAX / MCA_VALSTA) * 100, ';

      LSQL := LSQL + '  MCA_OPEBAI = :OPEBAI, ';
      LSQL := LSQL + '  MCA_HISBAI = :HISBAI, ';
      LSQL := LSQL + '  MCA_PORBAI = :PORBAI, ';
      LSQL := LSQL + '  MCA_CTABAI = :CTABAI, ';
      LSQL := LSQL + '  MCA_PORBTX = :PORBTX, ';
      LSQL := LSQL + '  MCA_CTABTX = :CTABTX, ';
      LSQL := LSQL + '  MCA_DOCBTX = :DOCBTX, ';
      LSQL := LSQL + '  MCA_DOCBAN = :DOCBAN, ';
      LSQL := LSQL + '  MCA_FORBTX = :FORBTX, ';
      LSQL := LSQL + '  MCA_CTADEB = :CTADEB, ';
      LSQL := LSQL + '  MCA_PORDEB = :PORDEB, ';
      LSQL := LSQL + '  MCA_CHACON = :CHACON, ';
      LSQL := LSQL + '  MCA_DOCDEB = :DOCDEB, ';
      LSQL := LSQL + '  MCA_DTABAI = ' + VS_FuncoesExternas.fICurrentDate + ', ';
      LSQL := LSQL + '  MCA_EVEDEB = :EVEDEB, ';
      LSQL := LSQL + '  MCA_CTAANT = :CTAANT, ';
      LSQL := LSQL + '  MCA_DOCANT = :DOCANT, ';
      LSQL := LSQL + '  MCA_ANTTAX = :ANTTAX, ';
      LSQL := LSQL + '  MCA_EVECRE = :EVECRE, ';
      LSQL := LSQL + '  MCA_EVETAX = :EVETAX, ';
      LSQL := LSQL + '  MCA_FREMKT = :FREMKT, ';
      LSQL := LSQL + '  MCA_VALAJU = :VALAJU, ';
      LSQL := LSQL + '  MCA_CUPMKT = :CUPMKT, ';
      LSQL := LSQL + '  MCA_DOCFRE = :DOCFRE, ';
      LSQL := LSQL + '  MCA_DOCAJU = :DOCAJU, ';
      LSQL := LSQL + '  MCA_DOCCUP = :DOCCUP  ';
      LSQL := LSQL + 'WHERE ';
      LSQL := LSQL + '  AUTOINCREM = :AUTOIN ';

      LAtualizar.SQL.Text := LSQL;

      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DTAREC', ADataRecebimento);
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'VALREC', AValorRecebido);
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'ANTTAX', ATaxaAntecipacao);
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'OPEBAI', AOperadorBaixa);
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'HISBAI', AHistoricoBaixa);
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'PORBAI', APortadorBaixa);
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'CTABAI', APlanoDeContasBaixa);
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'FREMKT', Abs(AFreteMarketPlace));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'VALAJU', Abs(AAjusteMarketPlace));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'CUPMKT', Abs(ACupomMarketPlace));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DOCBAN', ASeqLanCredito);

      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'PORBTX', TLibCartoesFuncoes.IIF(APortadorTaxa.IsEmpty, Null, APortadorTaxa));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'CTABTX', TLibCartoesFuncoes.IIF(APlanoDeContasTaxa.IsEmpty, Null, APlanoDeContasTaxa));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'CHACON', TLibCartoesFuncoes.IIF(AChaveConciliacao.IsEmpty, Null, AChaveConciliacao));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DOCBTX', TLibCartoesFuncoes.IIF(ASeqLanTaxa.IsEmpty, Null, ASeqLanTaxa));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'CTADEB', TLibCartoesFuncoes.IIF(APlanoDeContasDebito.IsEmpty, Null, APlanoDeContasDebito));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'PORDEB', TLibCartoesFuncoes.IIF(APortadorDebito.IsEmpty, Null, APortadorDebito));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DOCDEB', TLibCartoesFuncoes.IIF(ASeqLanDebito.IsEmpty, Null, ASeqLanDebito));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'FORBTX', TLibCartoesFuncoes.IIF(AFornecedorTaxa.IsEmpty, Null, AFornecedorTaxa));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'EVEDEB', TLibCartoesFuncoes.IIF(ACentroCustosDebito.IsEmpty, Null, ACentroCustosDebito));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DOCANT', TLibCartoesFuncoes.IIF(ASeqLanAntecipacao.IsEmpty, Null, ASeqLanAntecipacao));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'CTAANT', TLibCartoesFuncoes.IIF(APlanoContasAntecipacao.IsEmpty, Null, APlanoContasAntecipacao));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'EVECRE', TLibCartoesFuncoes.IIF(ACentroCustoCredito.IsEmpty, Null, ACentroCustoCredito));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'EVETAX', TLibCartoesFuncoes.IIF(ACentroCustoTaxa.IsEmpty, Null, ACentroCustoTaxa));

      If Not LRecalculaTaxa Then
       TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'VALTAX', AValorTaxaMarketPlace);

      If ADeveAtualizarValorBruto Then
      Begin
        If ANovoValorBruto > 0 Then
          TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'VALSTA', ANovoValorBruto);
      End;

      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DOCFRE', TLibCartoesFuncoes.IIF(ASeqLanFrete.IsEmpty, Null, ASeqLanFrete));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DOCAJU', TLibCartoesFuncoes.IIF(ASeqLanAjuste.IsEmpty, Null, ASeqLanAjuste));
      TLibCartoesFuncoes.CarregaParametroDataset(LAtualizar, 'DOCCUP', TLibCartoesFuncoes.IIF(ASeqLanCupom.IsEmpty, Null, ASeqLanCupom));

      LAtualizar.ParamByName('AUTOIN').AsString := AAutoIncrem;

      If Assigned(ABatchSQL) Then
        TBatchHelper.AddQueryToBatch(ABatchSQL, LAtualizar)
      Else
        LAtualizar.ExecSQL;

     {$IFDEF LINUX}
      raise Exception.Create('untLogMca.GravaLogMca ainda não possui implementação na compilação linux');
     {$ELSE}
      LAjustarLog := Nil;
      If Assigned(ABatchSQL) Then
        LAjustarLog :=
          procedure(AMovCar: TDataSet; ALogMca: TUniQuery)
            Var
              LIndice: Integer;

              LBrutoNulo,
              LRecalculaPercentual: Boolean;

              LValorBruto,
              LValorRecebido,
              LValorTaxa: Double;
          Begin
            For LIndice := 0 To LAtualizar.Params.Count - 1 Do
              If Not SameText(LAtualizar.Params[LIndice].Name, 'AUTOIN') Then
                DefinirCampoLogMca(ALogMca, 'MCA_' + LAtualizar.Params[LIndice].Name,
                                   LAtualizar.Params[LIndice].Value);

            DefinirCampoLogMca(ALogMca, 'MCA_VALANT', AMovCar.FieldByName('MCA_VALORI').Value);
            DefinirCampoLogMca(ALogMca, 'MCA_TAXANT', AMovCar.FieldByName('MCA_VALTAX').Value);
            DefinirCampoLogMca(ALogMca, 'MCA_FREANT', AMovCar.FieldByName('MCA_FREMKT').Value);
            DefinirCampoLogMca(ALogMca, 'MCA_CUPANT', AMovCar.FieldByName('MCA_CUPMKT').Value);
            DefinirCampoLogMca(ALogMca, 'MCA_BRUANT', AMovCar.FieldByName('MCA_VALSTA').Value);
            DefinirCampoLogMca(ALogMca, 'MCA_VALDUP', 0);
            DefinirCampoLogMca(ALogMca, 'MCA_VALORI', AValorRecebido);
            DefinirCampoLogMca(ALogMca, 'MCA_DTABAI', VS_FuncoesExternas.fIGetVS_Date);

            If ADataMovimentoBancario > 0 Then
              DefinirCampoLogMca(ALogMca, 'MCA_DTABAN', ADataMovimentoBancario);

            LBrutoNulo  := AMovCar.FieldByName('MCA_VALSTA').IsNull;
            LValorBruto := AMovCar.FieldByName('MCA_VALSTA').AsFloat;
            If ADeveAtualizarValorBruto And (ANovoValorBruto > 0) Then
            Begin
              LBrutoNulo  := False;
              LValorBruto := SimpleRoundTo(ANovoValorBruto, -2);
            End;

            LValorRecebido := SimpleRoundTo(AValorRecebido, -2);

            If LRecalculaTaxa Then
            Begin
              LValorTaxa := LValorBruto - LValorRecebido;
              DefinirCampoLogMca(ALogMca, 'MCA_VALTAX', TLibCartoesFuncoes.IIF(LBrutoNulo, Null, LValorTaxa));

              LRecalculaPercentual := Not AChaveConciliacao.IsEmpty;
              If Not LRecalculaPercentual Then
                LRecalculaPercentual := (Not LBrutoNulo) And
                                        (Not AMovCar.FieldByName('MCA_VALTAX').IsNull) And
                                        (Not SameValue(AMovCar.FieldByName('MCA_VALTAX').AsFloat, LValorTaxa, 0.001));

              If LRecalculaPercentual Then
                DefinirCampoLogMca(ALogMca, 'MCA_PERCAR', PercentualTaxaLog(LValorTaxa, LValorBruto, LBrutoNulo));
            End
            Else
              DefinirCampoLogMca(ALogMca, 'MCA_PERCAR', PercentualTaxaLog(AValorTaxaMarketPlace, LValorBruto, LBrutoNulo));
          End;

      untLibCartoesLogMca.GravaLogMca(AAutoIncrem,
                                      ADescricaoLogMca,
                                      ANomeFormularioLogMca,
                                      AAutoIncremLogMca,
                                      ABatchSQL,
                                      LAjustarLog);
     {$ENDIF}

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('Erro ao baixar Movimento de Cartão de Crédito: ' + E.Message);
      End;
    End;

  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LAtualizar);
  End;
end;

class function TLibCartoesMovCar.PercentualTaxaLog(AValorTaxa,
  AValorBruto: Double; ABrutoNulo: Boolean): Variant;
begin
  If ABrutoNulo Or IsZero(AValorBruto) Then
    Exit(Null);

  Result := AValorTaxa / AValorBruto * 100;
end;

class function TLibCartoesMovCar.CartaoBloqueado(ADataset: TDataset;
  AValorRcxTcc: String): Boolean;
begin
  Result := False;

  {** Se o cartão foi recebido via financiamento, a baixa não deve ser bloqueada **}
  {** devido à falta de transferência, pois cartões recebidos por financiamento  **}
  {** não possuem vínculo direto com a transferência do resumo de caixa. **********}

  if not ADataset.FieldByName('MCA_CODFIN').AsString.IsEmpty then
    Exit;

  if AValorRcxTcc.IsEmpty then
    AValorRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  If Not AValorRcxTcc.Equals('2') Then
    Exit;

  If ADataset.FieldByName('MCA_RESCAI').AsInteger <> 1 Then
    Exit;

  If ADataset.FieldByName('MCA_DTATRA').IsNull Then
    Exit(True);

  If FCFG_USAAUT.IsEmpty Then
    FCFG_USAAUT := TLibCartoesFuncoes.RetornaValorCfg('CFG_USAAUT', EmptyStr, 'N');

  Result := Not TransferenciaLiberada(FCFG_USAAUT.Equals('S'),
                                      ADataset.FieldByName('MCA_RESCAI').AsInteger = 1,
                                      ADataset.FieldByName('MCA_TRFLIB').AsString);
end;

class function TLibCartoesMovCar.fGetSQLCartoes(
  objConcil: TCamposConcil): String;
begin
  Result := '';
  Result := Result + 'SELECT * FROM (SELECT                                   ';
  Result := Result + '  MOVCAR.AUTOINCREM AS AUTOINC,                         ';
  Result := Result + '  MCA_NUMDUP AS NRODUP,                                 ';
  Result := Result + '  MCA_PARCEL AS PARDUP,                                 ';
  Result := Result + '  CONCAT(MCA_NUMDUP, MCA_PARCEL) AS MCA_NUMDUP,         ';
  Result := Result + '  IF(COALESCE(MCA_EMPRCX, "") = "", MCA_CODEMP,         ';
  Result := Result + '     MCA_EMPRCX) AS EMPLOC,                             ';
  Result := Result + '  MCA_CODEMP,                                           ';
  Result := Result + '  MCA_EMPRCX,                                           ';
  Result := Result + '  MCA_DTAVEN,                                           ';
  Result := Result + '  MCA_VALDUP AS MCA_VALTOT,                             ';
  Result := Result + '  MCA_VALTAX,                                           ';
  Result := Result + '  MCA_VALSTA,                                           ';
  Result := Result + '  MCA_VALORI,                                           ';
  Result := Result + '  MCA_VALDUP,                                           ';
  Result := Result + '  MCA_PERCAR,                                           ';
  if objConcil.TabelaConciliacao.Equals('PGM_PMRECE') then
    Result := Result + '  MCA_VALTAX AS TAXA_ADM_ORIGINAL,                    '
  else
    Result := Result + '  MCA_PERCAR AS TAXA_ADM_ORIGINAL,                    ';
  Result := Result + '  MCA_TAXANT,                                           ';

  If TLibCartoesFuncoes.FExisteCampoLiberacaoTransferencia Then
    Result := Result + '  MCA_TRFLIB,                                         '
  Else
    Result := Result + '  "S" AS MCA_TRFLIB,                                  ';

  Result := Result + '  IFNULL(MCA_ORDEID, MCA_NUMPOK) AS MCA_ORDEID,         ';
  Result := Result + '  MCA_CODCLI,                                           ';
  Result := Result + '  CE.EMP_EMPATI,                                        ';
  Result := Result + '  CLI_NOMCLI,                                           ';
  Result := Result + '  CLI_C_G_C_,                                           ';
  Result := Result + '  CAR_DESCAR,                                           ';
  Result := Result + '  CAR_CODBAN,                                           ';
  Result := Result + '  BAN_NOMBAN,                                           ';
  Result := Result + '  CONCAT(CAR_CODCAR, " - ", CAR_DESCAR) AS CARTAO,      ';
  Result := Result + '  CAR_CODEMP,                                           ';
  Result := Result + '  CAR_PERDES,                                           ';
  Result := Result + '  MCA_FREMKT,                                           ';
  Result := Result + '  IFNULL(MCA_CUPMKT, 0.00) AS MCA_CUPMKT,               ';
  Result := Result + '  MCA_HIST01,                                           ';
  Result := Result + '  MCA_HIST02,                                           ';
  Result := Result + '  CURRENT_TIMESTAMP AS HRAFILCAR,                       ';
  Result := Result + '  MCA_DTACAD,                                           ';
  If MatchStr(objConcil.TabelaConciliacao, ['RED_APPGTO']) then
    Result := Result + '  IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMNSU, LPAD(UPPER(MCA_NUMCCD), 6, "0")) AS MCA_NUMCCD, '
  else
    Result := Result + '  IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMNSU, UPPER(MCA_NUMCCD)) AS MCA_NUMCCD, ';
  Result := Result + '  MCA_RESCAI,                                           ';
  Result := Result + '  MCA_DTATRA,                                           ';
  Result := Result + '  MCA_CODCAR,                                           ';
  Result := Result + '  MCA_CODFIN,                                           ';
  if objConcil.TabelaConciliacao.Equals('PGM_PMRECE') then
    Result := Result + 'TRIM(LEADING "0" FROM MCA_NUMNSU) AS MCA_NUMNSU, '
  else If Not MatchStr(objConcil.TabelaConciliacao, ['MER_MLPGTO', 'KON_KOPGTO', 'MLZ_MZPGTO']) Then
    Result := Result + '  LPAD(MCA_NUMNSU, 14, "0") AS MCA_NUMNSU,            '
  Else
    Result := Result + '  MCA_NUMNSU,                                         ';

  Result := Result + '  LPAD(RIGHT(MCA_NUMNSU,12),14,"0") AS NSU_B2W,         ';
  Result := Result + '  MCA_DOCUME,                                           ';
  Result := Result + '  MCA_CHACON,                                           ';
  Result := Result + '  CAST(" " AS CHAR(400)) AS  HISTORICO_BAIXA,           ';
  Result := Result + '  IFNULL(MCA_DTACUP, MCA_DTACAD) AS MCA_DTACUP,         ';
  Result := Result + '  MCA_NUMPOK,                                           ';
  if TLibCartoesFuncoes.RetornaValorCfg('CFG_PGMREC').Equals('S') then
    Result := Result + '  LEFT(RIGHT(MCA_NUMPOK,9),6) AS POKPGM,              '
  else
    Result := Result + '  RIGHT(MCA_NUMPOK,9) AS POKPGM,                      ';
  Result := Result + '  IFNULL(MCA_FREPED, 0) AS MCA_FREPED,                  ';
  Result := Result + '  FOR_NOMFOR,                                           ';
  Result := Result + '  E1.EVE_DESEVE DESC_EVE_DEBITO,                        ';
  Result := Result + '  E2.EVE_DESEVE DESC_EVE_CREDITO,                       ';
  Result := Result + '  E3.EVE_DESEVE DESC_EVE_TAXA,                          ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAI, CON.CON_PORCRE), "") AS CAR_PORBAI, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTABAI, CON.CON_CTACRE), "") AS CAR_CTABAI, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORTAX, CON.CON_PORTAX), "") AS CAR_PORTAX, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTATAX, CON.CON_CTATAX), "") AS CAR_CTATAX, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") AS CAR_FORTAX, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAD, CON.CON_PORDEB), "") AS CAR_PORBAD, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTABAD, CON.CON_CTADEB), "") AS CAR_CTABAD, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVEDEB, CON.CON_EVEDEB), "") AS CAR_EVEDEB, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVECRE, CON.CON_EVECRE), "") AS CAR_EVECRE, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVETAX, CON.CON_EVETAX), "") AS CAR_EVETAX, ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS MCA_EVECAN,                   ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTAANT, CON.CON_CTAANT), "") AS CAR_CTAANT, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTAFRE, CON.CON_CTAFRE), "") AS CAR_CTAFRE, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTAAJU, CON.CON_CTAAJU), "") AS CAR_CTAAJU, ';
  Result := Result + '  COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTACUP, CON.CON_CTACUP), "") AS CAR_CTACUP, ';
  Result := Result + '  COALESCE(CAR_MKTPLA, "N") AS CAR_MKTPLA,              ';
  Result := Result + '  MCA_DOCFRE,                                           ';
  Result := Result + '  MCA_DOCAJU,                                           ';
  Result := Result + '  MCA_DOCCUP,                                           ';
  Result := Result + '  SUBSTRING(MCA_DOCUME,1,IF(LOCATE("AG", MCA_DOCUME), LOCATE("AG", MCA_DOCUME) + 5, 21)) AS MCA_NUMNOT, ';
  Result := Result + '  "D"  AS MCA_MARDES,                                   ';
  Result := Result + '  0.00 AS MCA_VALREC,                                   ';
  Result := Result + '  CAST(NULL AS DATE) AS MCA_DTAREC,                     ';
  Result := Result + '  0.00 AS MCA_SELSTA,                                   ';
  Result := Result + '  0.00 AS MCA_TOTTAX,                                   ';
  Result := Result + '  0.00 AS MCA_SELTOT,                                   ';
  Result := Result + '  0.00 AS MCA_AJUTOT,                                   ';
  Result := Result + '  0.00 AS MCA_AJUSEL,                                   ';
  Result := Result + '  IF(IFNULL(MCA_VALTAX,0) > 0, "N", "S") AS MCA_ZERATX, ';
  Result := Result + '  0.00 AS MCA_ANTECI,                                   ';
  Result := Result + '  IFNULL(MCA_ANTTAX, 0.00) AS MCA_ANTTAX,               ';
  Result := Result + '  0.00 AS MCA_SELQTD,                                   ';
  Result := Result + '  "N" AS MCA_AJUSTE,                                    ';
  Result := Result + '  "N" AS MCA_ANT_SN,                                    ';
  Result := Result + '  CAST(" " AS CHAR(50)) AS MCA_ESTABE,                  ';
  Result := Result + '  CAST(" " AS CHAR(50)) AS MARKETPLACE,                 ';
  Result := Result + '  CAST(" " AS CHAR(400)) AS CHAVECONCILIACAO,           ';
  Result := Result + '  CAST(" " AS CHAR(80)) AS NUMEROOPERACAO,              ';
  Result := Result + '  "N" AS NEGOCIACAO,                                    ';
  Result := Result + '  "N" AS VENDACANCELADA,                                ';
  Result := Result + '  "N" AS NEGOCIADO_ANTERIORMENTE,                       ';
  Result := Result + '  0.00 AS VALOR_TAXA_VENDACANCELADA,                    ';
  Result := Result + '  CAST(" " AS CHAR(7)) AS PLANODECONTASDETAXA,  ';
  Result := Result + '  0.00 AS VALOR_TAXA_NEGOCIACAO,                        ';
  Result := Result + '  CAST(" " AS CHAR(7)) AS PLANODECONTASTXNEGOCIACAO,    ';
  Result := Result + '  "N" AS ALTERAR_BRUTO,                                 ';
  Result := Result + '  0.00 AS FRETE_MARKETPLACE,                            ';
  Result := Result + '  0.00 AS AJUSTE_MARKETPLACE,                           ';
  Result := Result + '  0.00 AS CUPOM_MARKETPLACE,                            ';
  Result := Result + '  0.00 AS SUBTRAIR_FRETE,                               ';
  Result := Result + '  "N" AS CADASTRAR_NOVA_PARCELA_MKT,                    ';
  Result := Result + '  CAST(" " AS CHAR(20)) AS AUTOINCREM_BAIXADA_MKT,      ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS PORTADOR_GRAVAME,        ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS PORTADORTRANSFERENCIA,        ';
  Result := Result + '  CAST(" " AS CHAR(7)) AS PLANODECONTASTRANSFERENCIA,   ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS CENTRODECUSTOSTRANSFERENCIA,  ';
  Result := Result + '  CAST(" " AS CHAR(7)) AS PLANODECONTASTRANSFERENCIALANCDEB, ';
  Result := Result + '  "N" AS REGISTROTRANSFERENCIA,                         ';
  Result := Result + '  "N" AS REGISTROPIXCARTAO,                             ';
  Result := Result + '  CAST(" " AS CHAR(40)) AS TABELA_UPDATE,               ';
  Result := Result + '  IF((COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAI, CON.CON_PORCRE), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTABAI, CON.CON_CTACRE), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORTAX, CON.CON_PORTAX), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_CTATAX, CON.CON_CTATAX), "") = "") OR ';
  Result := Result + '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") = "")    ';

  if VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean) then
    Result := Result + ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVECRE, CON.CON_EVECRE), "") = "")       '+
                       ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVETAX, CON.CON_EVETAX), "") = "")       '+
                       ' OR ((COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_PORBAD, CON.CON_PORDEB), "") <> "") AND '+
                       '     (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_EVEDEB, CON.CON_EVEDEB), "") = ""))     ';

  If (Not TLibCartoesFuncoes.fEmptyStr(objConcil.CfgPortadorAjustes)) Then
  Begin
    If ((VS_FuncoesExternas.fICfgSis('BAIDEB') = 'S') And
       ((TLibCartoesFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes))) Or
       (TLibCartoesFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes))) Or
       (TLibCartoesFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes))))) Then
      Result := Result + ', "INCOMPLETO", "COMPLETO") AS SIT_CAD              '
    Else
      Result := Result + ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") = ""), '+
                         ' "INCOMPLETO", "COMPLETO") AS SIT_CAD               ';
  End
  Else
    Result := Result + ' OR (COALESCE(IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX), "") = ""), '+
                       ' "INCOMPLETO", "COMPLETO") AS SIT_CAD                 ';

  Result := Result + 'FROM                                                    ';
  Result := Result + '  MOVCAR                                                ';
  Result := Result + '  JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR                ';
  Result := Result + '  JOIN CADBAN ON BAN_CODBAN = CADCAR.CAR_CODBAN         ';
  Result := Result + '  JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI                ';
  Result := Result + '  LEFT JOIN CONPOR CON ON CON.CON_CODCAR = CADCAR.CAR_CODCAR ';
  Result := Result + '                      AND CON.CON_CODEMP = "' + VS_FuncoesExternas.fIRetEmpresaLogada + '" ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = IF(CON.CON_PORCRE IS NULL, CAR_FORTAX, CON.CON_FORTAX) ';
  Result := Result + '  LEFT JOIN CADEVE E1 ON E1.EVE_CODEVE = IF(CON.CON_PORCRE IS NULL, CAR_EVEDEB, CON.CON_EVEDEB) ';
  Result := Result + '  LEFT JOIN CADEVE E2 ON E2.EVE_CODEVE = IF(CON.CON_PORCRE IS NULL, CAR_EVECRE, CON.CON_EVECRE) ';
  Result := Result + '  LEFT JOIN CADEVE E3 ON E3.EVE_CODEVE = IF(CON.CON_PORCRE IS NULL, CAR_EVETAX, CON.CON_EVETAX) ';
  Result := Result + '  LEFT JOIN CADEMP CE ON CE.EMP_CODEMP = MOVCAR.MCA_CODEMP ';
  Result := Result + 'WHERE                                                   ';
  Result := Result + '  MCA_DTAREC IS NULL                                    ';
end;

class procedure TLibCartoesMovCar.LimparConciliacaoConfirmacaoCartao(ANumNsu,
  ANumCcd, AParcel, AOperadora: String; ADtaCup: TDateTime);
  Var
    LExtMca: TUniQuery;
Begin
  LExtMca := Nil;
  Try
    LExtMca := VS_FuncoesExternas.fICriaQuery;

    LExtMca.SQl.Text := 'UPDATE EXTMCA SET EXT_DTACLO = NULL,          '+
                        '                  EXT_HORCLO = NULL,          '+
                        '                  EXT_OPECLO = NULL           '+
                        'WHERE ((EXT_CODAUT = :CODAUT AND EXT_CODAUT <> "")    '+
                        '    OR (EXT_NUMNSU = :NUMNSU AND EXT_NUMNSU <> ""))   '+
                        '    AND EXT_PARCEL = :PARCEL                          '+
                        '    AND EXT_DTACUP = :DTACUP                          '+
                        '    AND EXT_NOMCON = :NOMCON                          ';

    LExtMca.ParamByName('CODAUT').AsString   := ANumCcd;
    LExtMca.ParamByName('NUMNSU').AsString   := ANumNsu;
    LExtMca.ParamByName('PARCEL').AsString   := AParcel;
    LExtMca.ParamByName('DTACUP').AsDateTime := ADtaCup;
    LExtMca.ParamByName('NOMCON').AsString   := AOperadora;
    LExtMca.ExecSQL;
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LExtMca);
  End;
end;

class function TLibCartoesMovCar.TransferenciaLiberada(
  AUsaLiberacaoTransferencia, AVeioResumoCaixa: Boolean;
  ACartaoLiberado: String): Boolean;
Begin
  Result := True;

  If Not AUsaLiberacaoTransferencia Then
    Exit;

  If Not AVeioResumoCaixa Then
    Exit;

  Result := Not ACartaoLiberado.Equals('N');
End;

end.
