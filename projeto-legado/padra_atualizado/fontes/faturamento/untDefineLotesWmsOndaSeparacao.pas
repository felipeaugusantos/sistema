unit untDefineLotesWmsOndaSeparacao;

interface

uses System.Classes, System.SysUtils, System.Variants, System.StrUtils, Vcl.Forms,
  Vcl.StdCtrls, Data.DB, Uni, UniDataSetProvider, UniClientDataSet, cxProgressBar,
  untDefineLotesWMS;

type

  {Exemplo insert em batch: INSERT INTO tbl_name (a,b,c) VALUES (1,2,3), (4,5,6), (7,8,9)}
  TInsertsInBatch = class
  private
    FCommand: TUniQuery;
    FRows: TArray<String>;
    FFields: TArray<String>;
    function GetValue(AField: TField): String;
    procedure AddCommand;
  protected
    function HeadInsertInto: String; virtual; abstract;
    procedure ParseFields(ADataSet: TDataSet); virtual; abstract;
  public
    procedure AddValue(AValue: String);
    function ExecSQL: Boolean;
    constructor New;
    destructor Destroy; override;
  end;

  TInsertsInBatchLOTDOR = class(TInsertsInBatch)
  public
    function HeadInsertInto: String; override;
    procedure ParseFields(ADataSet: TDataSet); override;
  end;

  TInsertsInBatchONDSEP = class(TInsertsInBatch)
  public
    function HeadInsertInto: String; override;
    procedure ParseFields(ADataSet: TDataSet); override;
  end;


  TDefineLotesWmsOndaSep = class(TDefineLotesWMS)
  private
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    FDecQtd    : Integer;

    procedure pAtualizaLotesItemOndaDeSeparacao;
    procedure pAtualizaSaldosLoteOndaDeSeparacao;
    procedure pSelecionarLotesSugestaoOndaDeSeparacao;
    procedure pValidaLotesOndaDeSeparacao;
    function fRetSaldoLoteOndaDeSeparacao(strCodIte, strNumLot: String): TDadosEstoqueLote;
    function fQuantidadeLotDorOndaDeSeparacao(strCodIte: String): Double;

    function fAtualizaLotesOndaDeSeparacao: Boolean;
    function fSalvarQuantidadeDigitadaBDOndaDeSeparacao: Boolean;
    function fRegravarOndSep: Boolean;

    function fValidaRemessaDeSeparacao: Boolean;
    function fAbreConsulta: Boolean;
    procedure pSetaProgressbar(pgbProgresso: TcxProgressBar);
  public
    function fDefineLotesRemessaSeparacao(pgbProgresso: TcxProgressBar): Boolean;

    constructor CreateInstance(AOwner: TComponent; AOndaDeSeparacao: String; AMensagens: TStringList = Nil);
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoesSimples, untMovimentacaoProgramada, untIFatReservaSaldo,
  untTFatReservaSaldo, untFuncTinta, untTipoTinta, untTransferenciaArmazens,
  untAuditoriaGravacaoSaldo, untConstantes, untItensNaoAtendidosSeparacaoWMS,
  untAgrupamentoDeOndaDeSeparacao.Funcoes;

{ TDefineLotesWmsOndaSep }

constructor TDefineLotesWmsOndaSep.CreateInstance(AOwner: TComponent; AOndaDeSeparacao: String; AMensagens: TStringList = Nil);
begin
  inherited CreateInstance(AOwner,           //AOwner
                           EmptyStr,         //strNumPed
                           EmptyStr,         //strEmpPed
                           EmptyStr,         //strAutIncTinta
                           False,            //blnUsaWMSRastreavelTinta
                           EmptyStr,         //strCodIte
                           EmptyStr,         //strCodLseItens
                           AOndaDeSeparacao, //strOndaDeSeparacao
                           EmptyStr,         //strCodCli
                           False,            //blnEhDefinicaoDeLotesPickingCheckOut
                           True,             //blnModoSemMensagens
                           AMensagens,       //stlMensagens
                           False);           //blnComTransacao

  qryConsulta := fCriaQuery(AOwner);
  dspConsulta := TUniDataSetProvider.Create(AOwner);
  cdsConsulta := TUniClientDataSet.Create(AOwner);

  qryConsulta.Options.SetFieldsReadOnly := False;
  dspConsulta.DataSet := qryConsulta;
  cdsConsulta.SetProvider(dspConsulta);

  FDecQtd := fCfgSis('DECQTD', varInteger);

  pCriaLotesItens(FLotes);
end;

destructor TDefineLotesWmsOndaSep.Destroy;
begin
  FreeAndNil(qryConsulta);
  FreeAndNil(dspConsulta);
  FreeAndNil(cdsConsulta);
  inherited;
end;

function TDefineLotesWmsOndaSep.fAbreConsulta: Boolean;
begin
  Try
    cdsConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(fGetSqlItensOndaDeSeparacao(True));
    cdsConsulta.Open;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pArmazenaMensagem(E.Message);
    End;
  End;
end;

function TDefineLotesWmsOndaSep.fDefineLotesRemessaSeparacao(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;

  Try
    pSetaProgressbar(pgbProgresso);

    If Not fValidaRemessaDeSeparacao Then
      Exit;

    If Not fAbreConsulta Then
      Exit;

    If Not fAtualizaLotesOndaDeSeparacao Then
      Exit;

    If Not fSalvarQuantidadeDigitadaBDOndaDeSeparacao Then
      Exit;

    Result := True;
  Finally
    Self.pgbProgresso  := Nil;
    Self.lblInformacao := Nil;
  End;
end;

function TDefineLotesWmsOndaSep.fQuantidadeLotDorOndaDeSeparacao(strCodIte: String): Double;
  Var
    cdsCloneLote: TUniClientDataSet;
Begin
  cdsCloneLote := TUniClientDataSet.Create(Nil);

  Try
    Result := 0;

    cdsCloneLote.Data := FLotes.Data;

    cdsCloneLote.Filter   := 'CODITE = ' + QuotedStr(strCodIte);
    cdsCloneLote.Filtered := True;

    If cdsCloneLote.IsEmpty Then
      Exit;

    cdsCloneLote.First;
    While Not cdsCloneLote.Eof Do
    Begin
      Result := Result + cdsCloneLote.FieldByName('QTDITE').AsFloat;

      cdsCloneLote.Next;
    End;

  Finally
    FreeAndNil(cdsCloneLote);
  End;
end;

function TDefineLotesWmsOndaSep.fRegravarOndSep: Boolean;
  Var
    qryOndSep: TUniQuery;
    objInsertsInBatch: TInsertsInBatch;
    strAutIncBatch: String;
begin
  qryOndSep := fCriaQuery;
  objInsertsInBatch := TInsertsInBatchONDSEP.New;

  Try
    Try

      qryOndSep.SQL.Add('DELETE FROM ONDSEP WHERE OND_SEQOND = :SEQOND');
      qryOndSep.ParamByName('SEQOND').AsString := FOndaDeSeparacao;
      qryOndSep.ExecSQL;

      qryOndSep.Close;
      qryOndSep.SQL.Clear;
      qryOndSep.SQL.Add('SELECT E.FGO_SEQOND      AS SEQOND, ');
      qryOndSep.SQL.Add('       D.FDO_CODITE      AS CODITE, ');
      qryOndSep.SQL.Add('       SUM(L.LDO_QTDITE) AS QTDITE, ');
      qryOndSep.SQL.Add('       C.LOT_LOCFIS      AS LOCFIS, ');
      qryOndSep.SQL.Add('       "A"               AS STATUS  ');
      qryOndSep.SQL.Add('FROM FATGOR F ');
      qryOndSep.SQL.Add('INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM) ');
      qryOndSep.SQL.Add('INNER JOIN FATDOR D ON (D.FDO_SEQGER = F.AUTOINCREM) ');
      qryOndSep.SQL.Add('INNER JOIN LOTDOR L ON (L.LDO_SEQFDO = D.AUTOINCREM) ');
      qryOndSep.SQL.Add('INNER JOIN CADLOT C ON (C.LOT_NUMLOT = L.LDO_NUMLOT AND ');
      qryOndSep.SQL.Add('                        C.LOT_CODEMP = E.FGO_EMPEXP AND ');
      qryOndSep.SQL.Add('                        C.LOT_CODITE = D.FDO_CODITE)    ');
      qryOndSep.SQL.Add('WHERE E.FGO_SEQOND = :SEQOND ');
      qryOndSep.SQL.Add('GROUP BY D.FDO_CODITE, C.LOT_LOCFIS ');
      qryOndSep.SQL.Add('ORDER BY D.FDO_CODITE, L.LDO_QTDITE, C.LOT_LOCFIS');
      qryOndSep.ParamByName('SEQOND').AsString := FOndaDeSeparacao;
      qryOndSep.Open;

      strAutIncBatch := fRetAutoIncrem('ONDSEP', VS_strCodEmp, qryOndSep.RecordCount);

      qryOndSep.First;
      While Not qryOndSep.Eof Do
      Begin
        strAutIncBatch := fNextAutoIncrem(strAutIncBatch);

        objInsertsInBatch.AddValue(QuotedStr(strAutIncBatch));
        objInsertsInBatch.ParseFields(qryOndSep);

        qryOndSep.Next;
      End;

      Result := objInsertsInBatch.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pArmazenaMensagem(E.Message);
      End;
    End;

  Finally
    FreeAndNil(qryOndSep);
    FreeAndNil(objInsertsInBatch);
  End;
end;

function TDefineLotesWmsOndaSep.fRetSaldoLoteOndaDeSeparacao(strCodIte, strNumLot: String): TDadosEstoqueLote;
  Var
    qryCadLot: TUniQuery;
Begin
  FillChar(Result, SizeOf(Result), #0);

  qryCadLot := fCriaQuery;

  Try

    qryCadLot.SQL.Add('SELECT LOT_SALDOS FROM CADLOT');
    qryCadLot.SQL.Add('WHERE LOT_NUMLOT = :NUMLOT');
    qryCadLot.SQL.Add('  AND LOT_CODEMP = :CODEMP');
    qryCadLot.SQL.Add('  AND LOT_CODITE = :CODITE');

    qryCadLot.ParamByName('CODITE').AsString := strCodIte;
    qryCadLot.ParamByName('NUMLOT').AsString := strNumLot;
    qryCadLot.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadLot.Open;

    If qryCadLot.IsEmpty Then
      Exit;

    Result.fltSaldo := qryCadLot.FieldByName('LOT_SALDOS').AsFloat;
    Result.fltMovimentacaoEntrada := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmEntrada);

    //Quando nao tem saldo nao faz o select do saldo reservado para ficar mais rápido
    If ((Result.fltSaldo <> 0) Or (Result.fltMovimentacaoEntrada > 0)) Then
    Begin
      Result.fltSaldoReservado := TSaldoReservado.New(
                                    TReservaParametros.New()
                                      .EmpresaItem(VS_strCodEmp)
                                      .CodigoItem(strCodIte)
                                      .CodEmpresa(VS_strCodEmp)
                                      .NumeroLote(strNumLot)
                                      .OndaDeSeparacao(FOndaDeSeparacao)
                                      .TipoFiltroDocumento(tfdIgnorarDocumentosOnda)
                                  ).fGetQuantidade();
      Result.fltMovimentacaoSaida := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmSaida);
    End;

  Finally
    FreeAndNil(qryCadLot);
  End;
end;

function TDefineLotesWmsOndaSep.fSalvarQuantidadeDigitadaBDOndaDeSeparacao: Boolean;
  Var
    qryOndaPD : TUniQuery;
    strCodLse : String;
    fltQtdPed : Double;
    strCodItens: String;
    strCodErrosAuditoria: String;
    strAutIncBatch: String;
    cdsIncLotDor: TUniClientDataSet;
    objInsertsInBatch: TInsertsInBatch;
    objAuditSaldo: IAuditoriaGravacaoSaldo;

  procedure pAtualizaSaldoDefinidoNoLote(fltQtdBaixa: Double);
  begin
    FLotes.Edit;
    FLotes.FieldByName('QTDITE').AsFloat := (FLotes.FieldByName('QTDITE').AsFloat - fltQtdBaixa);
    FLotes.Post;
  end;

Begin

  {*** INFORMAÇÃO: Aqui nessa função, é preciso EXPLODIR a onda de forma analítica,
   para que seja possível gravar a tabela LOTDOR! Pois toda a separação
   de onda é realizada de forma consolidada por item!  ***}

  qryOndaPD := fCriaQuery;

  cdsIncLotDor := fCriaCdsLotDor;

  objAuditSaldo := TAuditoriaGravacaoSaldo.New;

  Try
    Try

      objAuditSaldo.Limpar;

      {Apaga os registros já digitados}
      fApagaLotDor(FOndaDeSeparacao);

      {Desagrupa registros da onda}
      qryOndaPD.SQL.Add(fGetSqlItensOndaDeSeparacao(False));
      qryOndaPD.Open;

      strCodItens := EmptyStr;

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin

        pRegistraProgresso('Aguarde, Salvando digitação dos Lotes...', cdsConsulta.RecNo, cdsConsulta.RecordCount);

        pIncrementaListaStr(cdsConsulta.FieldByName('ITE_CODITE').AsString, strCodItens, True);

        FLotes.Filtered := False;
        FLotes.Filter   := 'CODITE = '+ QuotedStr(cdsConsulta.FieldByName('ITE_CODITE').AsString);
        FLotes.Filtered := True;

        {Ordena por data de validade}
        FLotes.IndexFieldNames := 'DTAVAL;NUMLOT;LOCFIS';
        FLotes.First;

        {Filtra o item desagrupado}
        qryOndaPD.Filtered := False;
        qryOndaPD.Filter   := 'FDO_CODITE = '+ QuotedStr(cdsConsulta.FieldByName('ITE_CODITE').AsString);
        qryOndaPD.Filtered := True;

        qryOndaPD.First;
        While Not qryOndaPD.Eof Do
        Begin

          {*** Vai capturando o saldo do lote definido até
               zerar e passar para o próximo lote com saldo caso tenha! ***}

          fltQtdPed := qryOndaPD.FieldByName('FDO_QTDITE').AsFloat;

          While (Not FLotes.Eof) And (fltQtdPed > 0) Do
          Begin

            If fFormataFloat(FLotes.FieldByName('QTDITE').AsFloat, 4) <= 0 Then
            Begin
              FLotes.Next;
              Continue;
            End;

            cdsIncLotDor.Append;
            cdsIncLotDor.FieldByName('LDO_SEQFDO').AsString := qryOndaPD.FieldByName('AUTOINCREM').AsString;
            cdsIncLotDor.FieldByName('LDO_NUMLOT').AsString := FLotes.FieldByName('NUMLOT').AsString;

            {Verifica se o saldo do lote definido atende a necessidade}
            If (FLotes.FieldByName('QTDITE').AsFloat >= fltQtdPed) Then
            Begin
              cdsIncLotDor.FieldByName('LDO_QTDITE').AsFloat := fltQtdPed;
              pAtualizaSaldoDefinidoNoLote(fltQtdPed);
              fltQtdPed := 0; {Atendeu completamente...}
            End
            Else
            Begin
              cdsIncLotDor.FieldByName('LDO_QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat;
              fltQtdPed := (fltQtdPed - FLotes.FieldByName('QTDITE').AsFloat); {Atendeu parcialmente...}
              pAtualizaSaldoDefinidoNoLote(FLotes.FieldByName('QTDITE').AsFloat);
            End;

            cdsIncLotDor.FieldByName('LDO_SALCAL').AsFloat  := FLotes.FieldByName('SALDIS').AsFloat;
            cdsIncLotDor.FieldByName('LDO_MOVENT').AsFloat  := FLotes.FieldByName('MOVENT').AsFloat;
            cdsIncLotDor.FieldByName('LDO_MOVSAI').AsFloat  := FLotes.FieldByName('MOVSAI').AsFloat;

            If fCfgSis('LSEWMS', varBoolean) Then
            Begin
              strCodLse := fGetLocalSeparacaoLocFis(FLotes.FieldByName('LOCFIS').AsString);

              If arrLseWms.ContainsKey(strCodLse) Then
                cdsIncLotDor.FieldByName('LDO_CODSEP').AsString := arrLseWms.Items[strCodLse].strCodSep;
            End;

            cdsIncLotDor.Post;

            {próximo lote definido...}
            If (fltQtdPed > 0) Then
              FLotes.Next;

          End;

          {próximo item analítico...}
          qryOndaPD.Next;

        End;

        {próximo item consolidado...}
        cdsConsulta.Next;

      End;

      {Marca itens para reprocessamento de saldo}
      pReprocessaItens(strCodItens, VS_strCodEmp);

      objInsertsInBatch := TInsertsInBatchLOTDOR.New;
      strAutIncBatch := fRetAutoIncrem('LOTDOR', VS_strCodEmp, cdsIncLotDor.RecordCount);

      cdsIncLotDor.First;
      While Not cdsIncLotDor.Eof Do
      Begin
        strAutIncBatch := fNextAutoIncrem(strAutIncBatch);

        objAuditSaldo.Adicionar(strAutIncBatch, 'LOTDOR');

        objInsertsInBatch.AddValue(QuotedStr(strAutIncBatch));
        objInsertsInBatch.ParseFields(cdsIncLotDor);

        cdsIncLotDor.Next;
      End;

      {Efetiva a gravação na LOTDOR em lote}
      Result := objInsertsInBatch.ExecSQL;

      {Efetiva a gravação na ONDSEP em lote}
      If Result Then
        Result := fRegravarONDSEP;

      If (Result) And (Not objAuditSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        pArmazenaMensagem(Format(AUDITORIA_GRAVACAO_FATURAMENTO_MSG_ERRO, [strCodErrosAuditoria]));
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pArmazenaMensagem(E.Message);
      End;
    End;

  Finally
    FLotes.Filtered := False;
    FLotes.Filter   := '';

    If Assigned(qryOndaPD) Then
      FreeAndNil(qryOndaPD);

    If Assigned(cdsIncLotDor) Then
      FreeAndNil(cdsIncLotDor);

    If Assigned(objInsertsInBatch) Then
      FreeAndNil(objInsertsInBatch);
  End;
end;

function TDefineLotesWmsOndaSep.fValidaRemessaDeSeparacao: Boolean;
  Var
    LStatus: String;
begin
  Result := True;

  If fEmptyStr(FOndaDeSeparacao) Then
    Exit;

  LStatus := fRetornaStatusRemessaDeSeparacao(FOndaDeSeparacao);

  If LStatus <> 'A' Then
  Begin
    pArmazenaMensagem('Não é possível alterar a loc. de separação pois a remessa de separação está com status ' +
                      IIF(LStatus.Equals('S'), '"Separando"', '"Finalizado"') + '!');
    Exit(False);
  End;

  If fPossuiQuantidadeSeparada(FOndaDeSeparacao) then
  Begin
    pArmazenaMensagem('Não é possível alterar a loc. de separação pois a remessa de separação já possui quantidade separada!');
    Exit(False);
  End;
end;

procedure TDefineLotesWmsOndaSep.pValidaLotesOndaDeSeparacao;
  Var
    strLotes: String;
begin
  Try

    FLotes.Filtered := False;
    FLotes.Filter   := 'CODITE = ' + QuotedStr(cdsConsulta.FieldByName('FDO_CODITE').AsString);
    FLotes.Filtered := True;

    If (fFormataFloat(cdsConsulta.FieldByName('FDO_QTDITE').AsFloat, FDecQtd) < fFormataFloat(fQuantidadeDigitadaLotes, FDecQtd)) Then
      pArmazenaMensagem('A quantidade digitada excede a quantidade total do item!');

    If (cdsConsulta.FieldByName('FDO_IDEPRO').AsString = 'NOR') And (cdsConsulta.FieldByName('FDO_PROACA').AsString <> 'S') And
       (Not fValidaSaldoDisponivelLotes(strLotes)) Then
      pArmazenaMensagem('A quantidade digitada é maior que o saldo disponível do(s) lote(s) (' + strLotes + ')!');

    If (fFormataFloat(cdsConsulta.FieldByName('FDO_QTDITE').AsFloat, FDecQtd) <> fFormataFloat(fQuantidadeDigitadaLotes, FDecQtd)) Then
    Begin
      SetLength(FItensDiverg, Length(FItensDiverg) +1);
      FItensDiverg[High(FItensDiverg)].strCodIte := cdsConsulta.FieldByName('FDO_CODITE').AsString;
      FItensDiverg[High(FItensDiverg)].fltQtdIte := cdsConsulta.FieldByName('FDO_QTDITE').AsFloat;
      FItensDiverg[High(FItensDiverg)].fltSalDis := fQuantidadeDigitadaLotes;
    End;

  Finally
    FLotes.Filter   := '';
    FLotes.Filtered := False;
  End;
end;

procedure TDefineLotesWmsOndaSep.pAtualizaLotesItemOndaDeSeparacao;
  Var
    qryLotIte : TUniQuery;
    qryCadLoc : TUniQuery;
    strOrigem : String;
    strLotOri : String;
    blnUsaPedidoBroker: Boolean;
    strIndexName: String;
Begin
  qryLotIte := fCriaQuery;
  qryCadLoc := fCriaQuery;

  blnUsaPedidoBroker := fUsaRotinaWMS And (Not fEmptyStr(fCfgSis('AKZCLI', varString)));

  strIndexName := FLotes.IndexFieldNames;
  FLotes.IndexFieldNames := 'CODITE;NUMLOT';

  Try

    qryCadLoc.SQL.Text := TDefineLotesWMS.fGetSqlLocFis;

    strOrigem := IIF(blnUsaPedidoBroker, cdsConsulta.FieldByName('FGO_ORIGEM').AsString, '');
    strLotOri := cdsConsulta.FieldByName('FDO_NUMLOT').AsString;

    qryLotIte.SQL.Clear;
    qryLotIte.SQL.Add(TDefineLotesWMS.fGetSqlLotes(False, False, False, cdsConsulta.FieldByName('FDO_IDEPRO').AsString));
    qryLotIte.SQL.Add('  AND IFNULL(LOT_STATUS,"S") = "S"  ');
    qryLotIte.SQL.Add('  AND IFNULL(LOT_DIGCON,"N") = "N"  ');
    qryLotIte.SQL.Add('  AND IFNULL(LOT_GARPRI,"N") = "N"  ');

    qryLotIte.ParamByName('CODITE').AsString := cdsConsulta.FieldByName('FDO_CODITE').AsString;
    qryLotIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryLotIte.ParamByName('BROKER').AsString := IIF(strOrigem = 'AKZO NOBEL', 'S', 'N');
    qryLotIte.Open;

    qryLotIte.First;

    While Not qryLotIte.Eof Do
    Begin

      If Not FLotes.FindKey([cdsConsulta.FieldByName('FDO_CODITE').AsString, qryLotIte.FieldByName('LOT_NUMLOT').AsString]) Then
      Begin
        pInsereLote(qryLotIte, qryCadLoc, '', strLotOri, strOrigem, cdsConsulta.FieldByName('FDO_QTDITE').AsFloat, True);

        pAtualizaSaldosLoteOndaDeSeparacao;
      End
      Else
      Begin
        pInsereLote(qryLotIte, qryCadLoc, '', strLotOri, strOrigem, cdsConsulta.FieldByName('FDO_QTDITE').AsFloat, False);
      End;

      qryLotIte.Next;
    End;

  Finally
    FLotes.IndexFieldNames := strIndexName;

    If Assigned(qryLotIte) Then
      FreeAndNil(qryLotIte);

    If Assigned(qryCadLoc) Then
      FreeAndNil(qryCadLoc);
  End;
end;

function TDefineLotesWmsOndaSep.fAtualizaLotesOndaDeSeparacao: Boolean;
Begin

  FLotes.EmptyDataSet;

  cdsConsulta.First;

  While Not cdsConsulta.Eof Do
  Begin
    pRegistraProgresso('Aguarde, Carregando lotes dos produtos...', cdsConsulta.RecNo, cdsConsulta.RecordCount);

    pAtualizaLotesItemOndaDeSeparacao;

    pSelecionarLotesSugestaoOndaDeSeparacao;

    pValidaLotesOndaDeSeparacao;

    cdsConsulta.Next;
  End;

  pMontaMensagemItensQtdeDivergente;

  Result := (Not fPossuiMensagemDeErro);

end;

procedure TDefineLotesWmsOndaSep.pAtualizaSaldosLoteOndaDeSeparacao;
  Var
    dadosEstoqueLote: TDadosEstoqueLote;
Begin

  dadosEstoqueLote := fRetSaldoLoteOndaDeSeparacao(FLotes.FieldByName('CODITE').AsString,
                                                   FLotes.FieldByName('NUMLOT').AsString);

  FLotes.Edit;
  FLotes.FieldByName('SALDOS').AsFloat := dadosEstoqueLote.fltSaldo + dadosEstoqueLote.fltMovimentacaoEntrada;
  FLotes.FieldByName('SALRES').AsFloat := dadosEstoqueLote.fltSaldoReservado + dadosEstoqueLote.fltMovimentacaoSaida;

  FLotes.FieldByName('MOVENT').AsFloat := dadosEstoqueLote.fltMovimentacaoEntrada;
  FLotes.FieldByName('MOVSAI').AsFloat := dadosEstoqueLote.fltMovimentacaoSaida;

  FLotes.FieldByName('SALDIS').AsFloat := FLotes.FieldByName('SALDOS').AsFloat - //Saldo de estoque
                                          FLotes.FieldByName('SALRES').AsFloat - //Saldo reservado
                                          FLotes.FieldByName('TOTDIG').AsFloat;  //Qtde ja digitada

  If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
  Begin
    FLotes.FieldByName('SALDIS').AsFloat := FLotes.FieldByName('SALDIS').AsFloat + FLotes.FieldByName('SALRES').AsFloat;
  End;

  FLotes.Post;

end;

procedure TDefineLotesWmsOndaSep.pSelecionarLotesSugestaoOndaDeSeparacao;
  Var
    strIndexName: String;
    fltQtdItePed: Double;
    fltQtdItePendente: Double;

  function fQtdDisponivel: Double;
  begin
    Result := FLotes.FieldByName('SALDIS').AsFloat - FLotes.FieldByName('QTDITE').AsFloat;
  end;

Begin

  strIndexName := FLotes.IndexFieldNames;

  Try

    fltQtdItePendente := cdsConsulta.FieldByName('FDO_QTDITE').AsFloat - fQuantidadeLotDorOndaDeSeparacao(cdsConsulta.FieldByName('FDO_CODITE').AsString);
    fltQtdItePed      := fltQtdItePendente;

    If fltQtdItePed = 0 Then
      Exit;

    FLotes.Filtered := False;
    FLotes.Filter   := 'CODITE = ' + QuotedStr(cdsConsulta.FieldByName('FDO_CODITE').AsString);
    FLotes.Filtered := True;

    FLotes.IndexFieldNames := fRetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao;

    //Caso o produto possua Picking e a quantidade seja
    //suficiente para atender a venda, utiliza o mesmo
    FLotes.First;
    While Not FLotes.Eof Do
    Begin
      If (fltQtdItePed > 0) And
         (FLotes.FieldByName('PICKIN').AsString = 'SIM') And
         (fQtdDisponivel > 0) Then
      Begin
        FLotes.Edit;

        If fQtdDisponivel >= fltQtdItePed Then
        Begin
          FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
          fltQtdItePed := 0.00;
        End
        Else
        Begin
          fltQtdItePed := fltQtdItePed - fQtdDisponivel;
          FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
        End;

        FLotes.Post;
      End;

      If fltQtdItePed = 0 then
        FLotes.Last;

      FLotes.Next;
    End;

    //Caso nao conseguiu utilizar a quantidade do picking para
    //atender a venda, vai utilizar os lotes por data de validade
    If fltQtdItePed > 0 Then
    Begin
      FLotes.First;
      While Not FLotes.Eof Do
      Begin
        //Caso nao seja o Picking e possua saldo disponivel
        If (FLotes.FieldByName('PICKIN').AsString <> 'SIM') And
           (fQtdDisponivel > 0) Then
        Begin
          FLotes.Edit;

          If fQtdDisponivel >= fltQtdItePed Then
          Begin
            FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
            fltQtdItePed := 0.00;
          End
          Else
          Begin
            fltQtdItePed := fltQtdItePed - fQtdDisponivel;
            FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
          End;

          FLotes.Post;
        End;

        FLotes.Next;
      End;
    End;

    //Caso nao conseguiu utilizar a quantidade do picking para
    //atender a venda e utilizou os lotes por data de validade
    //porem ainda possui quantidade pendente, entao também
    //utiliza a quantidade do picking para atender a venda
    If fltQtdItePed > 0 Then
    Begin
      FLotes.First;
      While Not FLotes.Eof Do
      Begin
        //Caso nao seja o Picking e possua saldo disponivel
        If (FLotes.FieldByName('PICKIN').AsString = 'SIM') And
           (FLotes.FieldByName('SALDIS').AsFloat > 0) And
           (FLotes.FieldByName('QTDITE').AsFloat = 0) Then
        Begin
          FLotes.Edit;

          If fQtdDisponivel >= fltQtdItePed Then
          Begin
            FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat + fltQtdItePed;
            fltQtdItePed := 0.00;
          End
          Else
          Begin
            fltQtdItePed := fltQtdItePed - fQtdDisponivel;
            FLotes.FieldByName('QTDITE').AsFloat := FLotes.FieldByName('SALDIS').AsFloat;
          End;

          FLotes.Post;
        End;

        FLotes.Next;
      End;
    End;

    //remove os lotes com quantidade zerada
    FLotes.Filtered := False;
    FLotes.Filter   := 'QTDITE <= 0';
    FLotes.Filtered := True;

    FLotes.First;
    While Not FLotes.Eof Do
      FLotes.Delete;

  Finally
    FLotes.IndexFieldNames := strIndexName;
    FLotes.Filtered := False;
    FLotes.Filter   := '';
  End;
end;

procedure TDefineLotesWmsOndaSep.pSetaProgressbar(pgbProgresso: TcxProgressBar);
begin
  Self.pgbProgresso  := Nil;
  Self.lblInformacao := Nil;

  If Not Assigned(pgbProgresso) Then
    Exit;

  Self.pgbProgresso := pgbProgresso;

  If Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) Then
    Self.lblInformacao := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
end;

{ TInsertsInBatch }

procedure TInsertsInBatch.AddValue(AValue: String);
begin
  SetLength(FFields, Length(FFields) +1);
  FFields[High(FFields)] := AValue;
end;

procedure TInsertsInBatch.AddCommand;
  Var
    LCommand: String;
begin
  LCommand := String.Join(',', FFields);

  SetLength(FRows, Length(FRows) +1);
  FRows[High(FRows)] := '('+ LCommand +')';

  SetLength(FFields, 0);
end;

function TInsertsInBatch.ExecSQL: Boolean;
  var
    LCommand: String;
begin
  try
    LCommand := String.Join(',', FRows);

    FCommand.SQL.Add(LCommand);
    FCommand.ExecSQL;

    Result := True;
  except
    Raise;
  end;
end;

function TInsertsInBatch.GetValue(AField: TField): String;
  Const
    STR_NULL = 'NULL';
begin
  if AField.IsNull then
    Exit(STR_NULL);

  case AField.DataType of
    ftDate:
    begin
      if (FormatDateTime('YYYY-MM-DD', AField.Value) = '1899-12-30') or
         (FormatDateTime('YYYY-MM-DD', AField.Value) = '0000-00-00') then
        Result := STR_NULL
      else
        Result := QuotedStr(FormatDateTime('YYYY-MM-DD', AField.Value));
    end;

    ftTime:
    begin
      if (FormatDateTime('hh:nn:ss', AField.Value) = '00:00:00') then
        Result := STR_NULL
      else
        Result := QuotedStr(FormatDateTime('hh:nn:ss', AField.Value));
    end;

    ftDateTime:
    begin
      if (FormatDateTime('YYYY-MM-DD hh:nn:ss', AField.Value) = '1899-12-30 00:00:00') or
         (FormatDateTime('YYYY-MM-DD hh:nn:ss', AField.Value) = '0000-00-00 00:00:00') then
        Result := STR_NULL
      else
        Result := QuotedStr(FormatDateTime('YYYY-MM-DD hh:nn:ss', AField.Value));
    end;

    ftFloat,
    ftCurrency: Result := ReplaceStr(AField.Value, ',', '.');

    ftInteger,
    ftSmallInt,
    ftLargeInt: Result := AField.Value;
  else
    Result := IIF(fEmptyStr(AField.Value), STR_NULL, QuotedStr(AField.Value));
  end;
end;

constructor TInsertsInBatch.New;
begin
  SetLength(FRows, 0);
  SetLength(FFields, 0);
  FCommand := fCriaQuery;
  FCommand.SQL.Add(HeadInsertInto);
end;

destructor TInsertsInBatch.Destroy;
begin
  FreeAndNil(FCommand);
  inherited;
end;

{ TInsertsInBatchLOTDOR }

function TInsertsInBatchLOTDOR.HeadInsertInto: String;
begin
  inherited;
  Result := 'INSERT INTO LOTDOR( ';
  Result := Result + 'AUTOINCREM, ';
  Result := Result + 'LDO_SEQFDO, ';
  Result := Result + 'LDO_NUMLOT, ';
  Result := Result + 'LDO_QTDITE, ';
  Result := Result + 'LDO_SALCAL, ';
  Result := Result + 'LDO_MOVENT, ';
  Result := Result + 'LDO_MOVSAI, ';
  Result := Result + 'LDO_CODSEP) ';
  Result := Result + ' VALUES ';
end;

procedure TInsertsInBatchLOTDOR.ParseFields(ADataSet: TDataSet);
begin
  inherited;
  AddValue(GetValue(ADataSet.FieldByName('LDO_SEQFDO')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_NUMLOT')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_QTDITE')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_SALCAL')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_MOVENT')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_MOVSAI')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_CODSEP')));

  AddCommand;
end;

{ TInsertsInBatchONDSEP }

function TInsertsInBatchONDSEP.HeadInsertInto: String;
begin
  inherited;
  Result := 'INSERT INTO ONDSEP( ';
  Result := Result + 'AUTOINCREM, ';
  Result := Result + 'OND_SEQOND, ';
  Result := Result + 'OND_CODITE, ';
  Result := Result + 'OND_QTDITE, ';
  Result := Result + 'OND_LOCFIS, ';
  Result := Result + 'OND_STATUS) ';
  Result := Result + ' VALUES ';
end;

procedure TInsertsInBatchONDSEP.ParseFields(ADataSet: TDataSet);
begin
  inherited;
  AddValue(GetValue(ADataSet.FieldByName('SEQOND')));
  AddValue(GetValue(ADataSet.FieldByName('CODITE')));
  AddValue(GetValue(ADataSet.FieldByName('QTDITE')));
  AddValue(GetValue(ADataSet.FieldByName('LOCFIS')));
  AddValue(GetValue(ADataSet.FieldByName('STATUS')));

  AddCommand;
end;

end.
