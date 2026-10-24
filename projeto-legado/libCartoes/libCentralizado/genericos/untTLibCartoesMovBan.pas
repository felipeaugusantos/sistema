unit untTLibCartoesMovBan;

interface

Uses System.SysUtils, System.Classes, System.Generics.Collections,
     System.StrUtils, System.Variants, Data.DB,

     Uni, UniClientDataset,

     untTLibCartoesFuncoes, untLogBan, untTBatchSQL, untTBatchSQL.Helper;

Type
  TLibCartoesMovBan = class
  private
    class var FDatasetPortadores: TUniClientDataset;

    class function PortadorPossuiDataValida(ACodigoPortador: String;
                                            ADataLancamento: TDateTime): Boolean;

    class function RetornaOrigemMovBan(AListaLogBan: TList<TLogBanDS>;
                                       AOrigem: String;
                                       AGravarOrigem: Boolean): Variant;
  public
    class procedure CarregaDatasetPortadores;
    class procedure DestroiDatasetPortadores;

    class function GravaMovBan(APlanoDeContas,
                               APortador,
                               AOperador: String;
                               ADataLancamento,
                               AHoraLancamento: TDateTime;
                               ANumeroDocumento,
                               ACreditoDebito,
                               ACodigoEmpresa: String;
                               AValorLancamento: Double;
                               AHistorico01,
                               AHistorico02: String;
                               ACodigoCliente,
                               ACodigoFornecedor,
                               ANumeroDuplicata: String;
                               ASequencialBaixa: Integer;
                               AParcelaDuplicata,
                               AEmpresaDuplicata,
                               ASerieCadPag,
                               ACentroDeCustos,
                               ADocumentoBaixa: String;
                               ASequencialTransferenciaRcx: Integer = 0;
                               ASequencialControle: Integer = 0;
                               ACompetencia: String = '';
                               ASequencialContraPartida: String = '';
                               ASeqLanMovBan: String = '';
                               AAutoIncremMovBan: String = '';
                               ACodigoCheque: String = '';
                               ACodigoCartao: String = '';
                               AGeraContabilidade: integer = 1;
                               AGravarOrigem: Boolean = True;
                               AListaLogBan: TList<TLogBanDS> = Nil;
                               AEmpresaTransferenciaValores: String = '';
                               ATransferenciaLiberada: String = 'S';
                               ASequencialDepositoCheque: String = '';
                               AOrigemLancamento: String = '';
                               ABatchSQL: TBatchSQL = Nil): String;
  End;

implementation

{ TLibCartoesMovBan }

class procedure TLibCartoesMovBan.CarregaDatasetPortadores;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT POR_CODPOR, ' +
                          '       POR_DTAINI ' +
                          'FROM CADPOR ' +
                          'ORDER BY POR_CODPOR';

    LConsulta.Open;

    FDatasetPortadores := TLibCartoesFuncoes.CriarClientDataSet(LConsulta);
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

class procedure TLibCartoesMovBan.DestroiDatasetPortadores;
begin
  TLibCartoesFuncoes.FreeAndNilDatasets(FDatasetPortadores);
end;

class function TLibCartoesMovBan.GravaMovBan(APlanoDeContas,
                                             APortador,
                                             AOperador: String;
                                             ADataLancamento,
                                             AHoraLancamento: TDateTime;
                                             ANumeroDocumento,
                                             ACreditoDebito,
                                             ACodigoEmpresa: String;
                                             AValorLancamento: Double;
                                             AHistorico01,
                                             AHistorico02: String;
                                             ACodigoCliente,
                                             ACodigoFornecedor,
                                             ANumeroDuplicata: String;
                                             ASequencialBaixa: Integer;
                                             AParcelaDuplicata,
                                             AEmpresaDuplicata,
                                             ASerieCadPag,
                                             ACentroDeCustos,
                                             ADocumentoBaixa: String;
                                             ASequencialTransferenciaRcx: Integer = 0;
                                             ASequencialControle: Integer = 0;
                                             ACompetencia: String = '';
                                             ASequencialContraPartida: String = '';
                                             ASeqLanMovBan: String = '';
                                             AAutoIncremMovBan: String = '';
                                             ACodigoCheque: String = '';
                                             ACodigoCartao: String = '';
                                             AGeraContabilidade: integer = 1;
                                             AGravarOrigem: Boolean = True;
                                             AListaLogBan: TList<TLogBanDS> = Nil;
                                             AEmpresaTransferenciaValores: String = '';
                                             ATransferenciaLiberada: String = 'S';
                                             ASequencialDepositoCheque: String = '';
                                             AOrigemLancamento: String = '';
                                             ABatchSQL: TBatchSQL = Nil): String;
  Var
    LGravacao: TUniQuery;

    LBaixaAnaliticaPagar: Boolean;

    LLogBanDS: TLogBanDS;
begin
  LGravacao := Nil;
  Try
    PortadorPossuiDataValida(APortador, ADataLancamento);

    LBaixaAnaliticaPagar := VS_FuncoesExternas.fICfgSis('CTP_AS', varBoolean);

    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := 'SELECT * FROM MOVBAN WHERE FALSE';
    LGravacao.Open;

    If ASeqLanMovBan.IsEmpty Then
      Result := VS_FuncoesExternas.fISeqContaBanco
    Else
      Result := TLibCartoesFuncoes.fStrZero(ASeqLanMovBan, 11);

    If AAutoIncremMovBan.IsEmpty Then
      AAutoIncremMovBan :=  VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', ACodigoEmpresa);

    If ACompetencia.IsEmpty Then
      ACompetencia := FormatDateTime('mm/YYYY', ADataLancamento);

    LGravacao.Append;

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_SEQLAN', Result, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODCTA', APlanoDeContas);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODPOR', APortador);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODOPE', AOperador);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_DTALAN', ADataLancamento);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_HORLAN', AHoraLancamento);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_NUMDOC', RightStr(ANumeroDocumento.Trim, 12));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CREDEB', ACreditoDebito);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_VALLAN', AValorLancamento);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_HIST01', LeftStr(AHistorico01, 60));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_HIST02', LeftStr(AHistorico02, 60));

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODEMP', ACodigoEmpresa);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'AUTOINCREM', AAutoIncremMovBan);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODCLI', ACodigoCliente);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODFOR', ACodigoFornecedor);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_NUMDUP', ANumeroDocumento, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_SEQBAI', TLibCartoesFuncoes.IIF(LBaixaAnaliticaPagar, ASequencialBaixa, Null));
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_PARCEL', AParcelaDuplicata);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_EMPDUP', AEmpresaDuplicata);

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_SERIE_', ASerieCadPag, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODEVE', ACentroDeCustos);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_DOCBAI', ADocumentoBaixa);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_COMPET', ACompetencia);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_SEQTRF', ASequencialTransferenciaRcx, False, '0');
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_SEQCTP', ASequencialContraPartida);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_PAGCON', ASequencialControle, False, '0');
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_ORIGEM', RetornaOrigemMovBan(AListaLogBan, AOrigemLancamento, AGravarOrigem));

    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODCHQ', ACodigoCheque);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_CODCAR', ACodigoCartao);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_GERCON', AGeraContabilidade, True);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_EMPTRA', AEmpresaTransferenciaValores);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_TRFLIB', ATransferenciaLiberada);
    TLibCartoesFuncoes.SetaValorCampoDataset(LGravacao, 'CTB_SEQDEP', ASequencialDepositoCheque);

    TBatchHelper.PostOuAcumula(LGravacao, 'MOVBAN', ABatchSQL);

    if Assigned(AListaLogBan) then
    Begin
      For LLogBanDS In AListaLogBan Do
        TGravaLogBanDS.GravaLogBanDS(LLogBanDS, ACodigoEmpresa, Result, ABatchSQL);
    End;
  Finally
    TLibCartoesFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

class function TLibCartoesMovBan.PortadorPossuiDataValida(
  ACodigoPortador: String; ADataLancamento: TDateTime): Boolean;
begin
  If Not Assigned(FDatasetPortadores) Then
    CarregaDatasetPortadores;

  If Not FDatasetPortadores.FieldByName('POR_CODPOR').AsString.Equals(ACodigoPortador) Then
  Begin
    Result := FDatasetPortadores.Locate('POR_CODPOR', ACodigoPortador, []);

    If Not Result Then
      Raise Exception.Create('Portador código ' + ACodigoPortador + ' não está cadastrado. - [TLibCartoesMovBan.PortadorPossuiDataValida]');
  End;

  Result := FDatasetPortadores.FieldByName('POR_DTAINI').AsDateTime <= ADataLancamento;

  If Result Then
    Exit;

  Raise Exception.Create('Não foi possível gravar a movimentação bancária. A data inicial do portador com código ' +
                         ACodigoPortador + ' tem a data inicial menor que a do lançamento. - [TLibCartoesMovBan.PortadorPossuiDataValida]');
end;

class function TLibCartoesMovBan.RetornaOrigemMovBan(
  AListaLogBan: TList<TLogBanDS>; AOrigem: String;
  AGravarOrigem: Boolean): Variant;
  Var
    LOrigemOriginal: String;
begin
  If Not AGravarOrigem Then
  Begin
    If Not Assigned(AListaLogBan) Then
      Exit(Null);

    If AListaLogBan.Count = 0 Then
      Exit(Null);

    LOrigemOriginal := TGravaLogBanDS.fGetOrigem(AListaLogBan[0]);

    If AOrigem.Equals('MCA') Then Result := 'ECR' // ESTORNO DE CARTÃO
    Else If AOrigem.Equals('CTR') Then  Result := 'ERC' // ESTORNO DE CONTAS A RECEBER
    Else If AOrigem.Equals('CTP') Then  Result := 'EPG' // ESTORNO DE CONTAS A PAGAR
    Else If AOrigem.Equals('ADT') Then  Result := 'ADT'  // ESTORNO DE ADIANTAMENTO
    Else If AOrigem.Equals('CRC') Then  Result := 'CRC'; // ESTORNO DE CREDITO CONTAS A RECEBER

    Exit;
  End;

  If Not Assigned(AListaLogBan) Then
    Exit(AOrigem);

  If AListaLogBan.Count = 0 Then
    Exit(AOrigem);

  Result := TGravaLogBanDS.fGetOrigem(AListaLogBan[0]);
end;

initialization

finalization
  TLibCartoesMovBan.DestroiDatasetPortadores;

end.
