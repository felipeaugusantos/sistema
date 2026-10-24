unit AgrupamentoDeOndaDeSeparacao.Classes.DefinicaoDeLotes;

interface

uses System.Classes, System.SysUtils, System.Variants, System.StrUtils, Vcl.Forms,
  Vcl.StdCtrls, Data.DB, Uni, UniDataSetProvider, UniClientDataSet, cxProgressBar,
  untDefineLotesWMS, Faturamento.Connections.Functions, Shared.Functions.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Option,
  AgrupamentoDeOndaDeSeparacao.Funcoes,
  AgrupamentoDeOndaDeSeparacao.Types,
  AgrupamentoDeOndaDeSeparacao.Classes.InsertsInBatch;

type

  TDefineLotesWMSRemessaDeSeparacao = class
  private
    FRemessaDeSeparacao: String;
    FDecQtd    : Integer;
    FLotes     : TFDMemTable;
    FMensagens : TStringList;

    FConsulta  : TUniClientDataSet;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;

    FItensAgrupadosRemessaSeparacao : TItensAgrupadosRemessaSeparacao;

    FItensDiverg  : TItensDiverg;
    FItensRemessa : TItensRemessa;

    function GetSqlItensRemessaDeSeparacao(AAgrupar : Boolean; ACodIte : String = ''): String;
    function PossuiMensagemDeErro: Boolean;
    function RetSaldoLoteRemessaDeSeparacao(ACodIte, ANumLot: String; ASaldoLote : Double): TDadosEstoqueLote;
    function RegravarOndSep: Boolean;

    function Valida: Boolean;
    function Consulta: Boolean;

    procedure ArmazenaMensagem(AMensagem: String);
    procedure InsereLote(ALotIte : TUniQuery);
    procedure CriaLotesItens;
    procedure MontaMensagemItensQtdeDivergente;

    function DefineLotesInterna : Boolean;

    function CarregaLotesInterna(pgbStatus: TcxProgressBar) : Boolean;
    function DefinirLotesInterna(pgbStatus: TcxProgressBar) : Boolean;
    function Salvar(pgbStatus: TcxProgressBar): Boolean;

    procedure DefinirSugestao;

  public

    constructor CreateInstance(AOwner: TComponent; ARemessaDeSeparacao: String; AMensagens: TStringList = Nil);
    destructor Destroy; override;

    function DefineLotes(pgbProgresso: TcxProgressBar): Boolean;
    procedure setItensAgrupadosRemessa(AItensAgrupadosRemessaSeparacao : TItensAgrupadosRemessaSeparacao);

    property ItensRemessa : TItensRemessa Read FItensRemessa;

  end;

implementation

uses
  untFuncoesSimples, untMovimentacaoProgramada, untIFatReservaSaldo,
  untTFatReservaSaldo, untFuncTinta, untTipoTinta, untTransferenciaArmazens,
  untAuditoriaGravacaoSaldo, untConstantes, untItensNaoAtendidosSeparacaoWMS,
  untGravando;

{ TDefineLotesWMSRemessaDeSeparacao }

constructor TDefineLotesWMSRemessaDeSeparacao.CreateInstance(AOwner: TComponent; ARemessaDeSeparacao: String; AMensagens: TStringList = Nil);
begin

  FRemessaDeSeparacao := ARemessaDeSeparacao;

  qryConsulta := fCriaQuery(AOwner);
  dspConsulta := TUniDataSetProvider.Create(AOwner);
  FConsulta := TUniClientDataSet.Create(AOwner);

  qryConsulta.Options.SetFieldsReadOnly := False;
  dspConsulta.DataSet := qryConsulta;
  FConsulta.SetProvider(dspConsulta);

  FDecQtd := fCfgSis('DECQTD', varInteger);

  CriaLotesItens;

  SetLength(FItensDiverg, 0);
  SetLength(FItensRemessa, 0);

end;

destructor TDefineLotesWMSRemessaDeSeparacao.Destroy;
begin
  FreeAndNil(qryConsulta);
  FreeAndNil(dspConsulta);
  FreeAndNil(FConsulta);
  inherited;
end;

function TDefineLotesWMSRemessaDeSeparacao.Consulta: Boolean;
begin
  Try
    FConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(GetSqlItensRemessaDeSeparacao(True));
    FConsulta.Open;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      ArmazenaMensagem(E.Message);
    End;
  End;
end;

function TDefineLotesWMSRemessaDeSeparacao.DefineLotes(pgbProgresso: TcxProgressBar): Boolean;
begin

  Result := False;

  If Not Valida Then
    Exit;

  If Not Consulta Then
    Exit;

  If Not DefineLotesInterna Then
    Exit;

  If Not fExecutarModal(Salvar, 'Aguarde, salvando definições de lotes...', '') Then
    Exit;

  Result := True;

end;

function TDefineLotesWMSRemessaDeSeparacao.GetSqlItensRemessaDeSeparacao(AAgrupar: Boolean; ACodIte: String): String;
begin
  Result := AgrupamentoDeOndaDeSeparacao.Funcoes.GetSqlItensOndaDeSeparacao(FRemessaDeSeparacao, AAgrupar, ACodIte);
end;

function TDefineLotesWMSRemessaDeSeparacao.PossuiMensagemDeErro: Boolean;
begin

  Result := False;

  If Not Assigned(FMensagens) Then
    Exit;

  Result := (FMensagens.Count > 0);

end;

function TDefineLotesWMSRemessaDeSeparacao.RegravarOndSep: Boolean;
  Var
    LOndSep        : TUniQuery;
    LInsertsInBatch: TInsertsInBatch;
    LAutIncBatch   : String;
begin
  LOndSep := fCriaQuery;
  LInsertsInBatch := TInsertsInBatchONDSEP.New;

  Try
    Try

      LOndSep.SQL.Add('DELETE FROM ONDSEP WHERE OND_SEQOND = :SEQOND');
      LOndSep.ParamByName('SEQOND').AsString := FRemessaDeSeparacao;
      LOndSep.ExecSQL;

      LOndSep.Close;
      LOndSep.SQL.Clear;
      LOndSep.SQL.Add('SELECT E.FGO_SEQOND      AS SEQOND, ');
      LOndSep.SQL.Add('       D.FDO_CODITE      AS CODITE, ');
      LOndSep.SQL.Add('       SUM(L.LDO_QTDITE) AS QTDITE, ');
      LOndSep.SQL.Add('       C.LOT_LOCFIS      AS LOCFIS, ');
      LOndSep.SQL.Add('       "A"               AS STATUS  ');
      LOndSep.SQL.Add('FROM FATGOR F ');
      LOndSep.SQL.Add('INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM) ');
      LOndSep.SQL.Add('INNER JOIN FATDOR D ON (D.FDO_SEQGER = F.AUTOINCREM) ');
      LOndSep.SQL.Add('INNER JOIN LOTDOR L ON (L.LDO_SEQFDO = D.AUTOINCREM) ');
      LOndSep.SQL.Add('INNER JOIN CADLOT C ON (C.LOT_NUMLOT = L.LDO_NUMLOT AND ');
      LOndSep.SQL.Add('                        C.LOT_CODEMP = E.FGO_EMPEXP AND ');
      LOndSep.SQL.Add('                        C.LOT_CODITE = D.FDO_CODITE)    ');
      LOndSep.SQL.Add('WHERE E.FGO_SEQOND = :SEQOND ');
      LOndSep.SQL.Add('GROUP BY D.FDO_CODITE, C.LOT_LOCFIS ');
      LOndSep.SQL.Add('ORDER BY D.FDO_CODITE, L.LDO_QTDITE, C.LOT_LOCFIS');
      LOndSep.ParamByName('SEQOND').AsString := FRemessaDeSeparacao;
      LOndSep.Open;

      LAutIncBatch := fRetAutoIncrem('ONDSEP', VS_strCodEmp, LOndSep.RecordCount);

      LOndSep.First;
      While Not LOndSep.Eof Do
      Begin
        LAutIncBatch := fNextAutoIncrem(LAutIncBatch);

        LInsertsInBatch.AddValue(QuotedStr(LAutIncBatch));
        LInsertsInBatch.ParseFields(LOndSep);

        LOndSep.Next;
      End;

      Result := LInsertsInBatch.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Result := False;
        ArmazenaMensagem(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LOndSep);
    FreeAndNil(LInsertsInBatch);
  End;
end;

function TDefineLotesWMSRemessaDeSeparacao.RetSaldoLoteRemessaDeSeparacao(ACodIte, ANumLot: String; ASaldoLote : Double): TDadosEstoqueLote;
Begin

  FillChar(Result, SizeOf(Result), #0);

  Result.fltSaldo := ASaldoLote;

  If fCfgSis('WMSMOV', varBoolean) Then
    Result.fltMovimentacaoEntrada := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(ACodIte, ANumLot, tmEntrada);

  //Quando nao tem saldo nao faz o select do saldo reservado para ficar mais rápido
  If ((Result.fltSaldo <> 0) Or (Result.fltMovimentacaoEntrada > 0)) Then
  Begin

    Result.fltSaldoReservado := TSaldoReservado.New(
                                  TReservaParametros.New()
                                    .EmpresaItem(VS_strCodEmp)
                                    .CodigoItem(ACodIte)
                                    .CodEmpresa(VS_strCodEmp)
                                    .NumeroLote(ANumLot)
                                    .OndaDeSeparacao(FRemessaDeSeparacao)
                                    .TipoFiltroDocumento(tfdIgnorarDocumentosOnda)
                                ).fGetQuantidade();

    If fCfgSis('WMSMOV', varBoolean) Then
      Result.fltMovimentacaoSaida := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(ACodIte, ANumLot, tmSaida);

  End;

end;

function TDefineLotesWMSRemessaDeSeparacao.Salvar(pgbStatus: TcxProgressBar): Boolean;
  Var
    LRemessaPD         : TUniQuery;
    LQtdPed            : Double;
    LCodItens          : String;
    LCodErrosAuditoria : String;
    LAutIncBatch       : String;
    LIncLotDor         : TUniClientDataSet;
    LInsertsInBatch    : TInsertsInBatch;
    LAuditSaldo        : IAuditoriaGravacaoSaldo;

  procedure pAtualizaSaldoDefinidoNoLote(fltQtdBaixa: Double);
  begin
    FLotes.Edit;
    FLotes.FieldByName('QTDITE').AsFloat := (FLotes.FieldByName('QTDITE').AsFloat - fltQtdBaixa);
    FLotes.Post;
  end;

Begin

  {*** INFORMAÇÃO: Aqui nessa função, é preciso EXPLODIR a remessa de forma analítica,
   para que seja possível gravar a tabela LOTDOR! Pois toda a separação
   de remessa é realizada de forma consolidada por item!  ***}

  LRemessaPD := fCriaQuery;

  LIncLotDor := CriaCdsLotDor;

  LAuditSaldo := TAuditoriaGravacaoSaldo.New;

  Try
    Try

      LAuditSaldo.Limpar;

      {Apaga os registros já digitados}
      ApagaLotDor(FRemessaDeSeparacao);

      {Desagrupa registros da remessa}
      LRemessaPD.SQL.Add(GetSqlItensRemessaDeSeparacao(False));
      LRemessaPD.Open;

      LCodItens := EmptyStr;

      FConsulta.First;
      While Not FConsulta.Eof Do
      Begin

        pProgresso(FConsulta.RecNo, FConsulta.RecordCount, pgbStatus);

        pIncrementaListaStr(FConsulta.FieldByName('ITE_CODITE').AsString, LCodItens, True);

        FLotes.Filtered := False;
        FLotes.Filter   := 'CODITE = '+ QuotedStr(FConsulta.FieldByName('ITE_CODITE').AsString);
        FLotes.Filtered := True;

        {Ordena por data de validade}
        FLotes.IndexFieldNames := 'DTAVAL;NUMLOT;LOCFIS';
        FLotes.First;

        {Filtra o item desagrupado}
        LRemessaPD.Filtered := False;
        LRemessaPD.Filter   := 'FDO_CODITE = '+ QuotedStr(FConsulta.FieldByName('ITE_CODITE').AsString);
        LRemessaPD.Filtered := True;

        LRemessaPD.First;
        While Not LRemessaPD.Eof Do
        Begin

          {*** Vai capturando o saldo do lote definido até
               zerar e passar para o próximo lote com saldo caso tenha! ***}

          LQtdPed := LRemessaPD.FieldByName('FDO_QTDITE').AsFloat;

          While (Not FLotes.Eof) And (LQtdPed > 0) Do
          Begin

            If fFormataFloat(FLotes.FieldByName('QTDITE').AsFloat, 4) <= 0 Then
            Begin
              FLotes.Next;
              Continue;
            End;

            LIncLotDor.Append;
            LIncLotDor.FieldByName('LDO_SEQFDO').AsString := LRemessaPD.FieldByName('AUTOINCREM').AsString;
            LIncLotDor.FieldByName('LDO_NUMLOT').AsString := FLotes.FieldByName('NUMLOT').AsString;

            {Verifica se o saldo do lote definido atende a necessidade}
            If (FLotes.FieldByName('QTDITE').AsFloat >= LQtdPed) Then
            Begin
              LIncLotDor.FieldByName('LDO_QTDITE').AsFloat := LQtdPed;
              pAtualizaSaldoDefinidoNoLote(LQtdPed);
              LQtdPed := 0; {Atendeu completamente...}
            End
            Else
            Begin
              LIncLotDor.FieldByName('LDO_QTDITE').AsFloat := FLotes.FieldByName('QTDITE').AsFloat;
              LQtdPed := (LQtdPed - FLotes.FieldByName('QTDITE').AsFloat); {Atendeu parcialmente...}
              pAtualizaSaldoDefinidoNoLote(FLotes.FieldByName('QTDITE').AsFloat);
            End;

            LIncLotDor.FieldByName('LDO_SALCAL').AsFloat  := FLotes.FieldByName('SALDIS').AsFloat;
            LIncLotDor.FieldByName('LDO_MOVENT').AsFloat  := FLotes.FieldByName('MOVENT').AsFloat;
            LIncLotDor.FieldByName('LDO_MOVSAI').AsFloat  := FLotes.FieldByName('MOVSAI').AsFloat;

            LIncLotDor.Post;

            {próximo lote definido...}
            If (LQtdPed > 0) Then
              FLotes.Next;

          End;

          {próximo item analítico...}
          LRemessaPD.Next;

        End;

        {próximo item consolidado...}
        FConsulta.Next;

      End;

      {Marca itens para reprocessamento de saldo}
      ReprocessaItens(LCodItens, VS_strCodEmp);

      LInsertsInBatch := TInsertsInBatchLOTDOR.New;
      LAutIncBatch := fRetAutoIncrem('LOTDOR', VS_strCodEmp, LIncLotDor.RecordCount);

      LIncLotDor.First;
      While Not LIncLotDor.Eof Do
      Begin
        LAutIncBatch := fNextAutoIncrem(LAutIncBatch);

        LAuditSaldo.Adicionar(LAutIncBatch, 'LOTDOR');

        LInsertsInBatch.AddValue(QuotedStr(LAutIncBatch));
        LInsertsInBatch.ParseFields(LIncLotDor);

        LIncLotDor.Next;
      End;

      {Efetiva a gravação na LOTDOR em lote}
      Result := LInsertsInBatch.ExecSQL;

      {Efetiva a gravação na ONDSEP em lote}
      If Result Then
        Result := RegravarOndSep;

      If (Result) And (Not LAuditSaldo.fValidouTodas(LCodErrosAuditoria)) Then
      Begin
        Result := False;
        ArmazenaMensagem(Format(AUDITORIA_GRAVACAO_FATURAMENTO_MSG_ERRO, [LCodErrosAuditoria]));
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        ArmazenaMensagem(E.Message);
      End;
    End;

  Finally
    FLotes.Filtered := False;
    FLotes.Filter   := '';

    If Assigned(LRemessaPD) Then
      FreeAndNil(LRemessaPD);

    If Assigned(LIncLotDor) Then
      FreeAndNil(LIncLotDor);

    If Assigned(LInsertsInBatch) Then
      FreeAndNil(LInsertsInBatch);
  End;
end;

function TDefineLotesWMSRemessaDeSeparacao.DefinirLotesInterna(pgbStatus: TcxProgressBar): Boolean;
begin

  FConsulta.First;
  While Not FConsulta.Eof Do
  Begin
    pProgresso(FConsulta.RecNo, FConsulta.RecordCount, pgbStatus);
    DefinirSugestao;
    FConsulta.Next;
  End;

  Result := True;

end;

function TDefineLotesWMSRemessaDeSeparacao.Valida: Boolean;
  Var
    LStatus: String;
begin
  Result := True;

  If fEmptyStr(FRemessaDeSeparacao) Then
    Exit;

  LStatus := fRetornaStatusRemessaDeSeparacao(FRemessaDeSeparacao);

  If LStatus <> 'A' Then
  Begin
    ArmazenaMensagem('Não é possível alterar a loc. de separação pois a remessa de separação está com status ' +
                      IIF(LStatus.Equals('S'), '"Separando"', IIF(LStatus.Equals('P'), '"Parcialmente Finalizado"', '"Finalizado"')) + '!');
    Exit(False);
  End;

  If fPossuiQuantidadeSeparada(FRemessaDeSeparacao) then
  Begin
    ArmazenaMensagem('Não é possível alterar a loc. de separação pois a remessa de separação já possui quantidade separada!');
    Exit(False);
  End;
end;

procedure TDefineLotesWMSRemessaDeSeparacao.ArmazenaMensagem(AMensagem: String);
begin

  if (not Assigned(FMensagens)) then
    Exit;

  FMensagens.Add(AMensagem);

end;

function TDefineLotesWMSRemessaDeSeparacao.CarregaLotesInterna(pgbStatus: TcxProgressBar) : Boolean;
  Var
    LLotIte      : TUniQuery;
    LItemRemessa : TItemRemessaSeparacao;
    LCodItens    : String;
Begin

  for LItemRemessa in FItensAgrupadosRemessaSeparacao do
    pIncrementaListaStr(LItemRemessa.strCodIte, LCodItens, True);

  LLotIte := fCriaQuery;

  Try

    LLotIte.SQL.Clear;
    LLotIte.SQL.Add(TDefineLotesWMS.fGetSqlLotes(False, False, False, '', False));
    LLotIte.SQL.Add('  AND IFNULL(LOT_STATUS,"S") = "S"  ');
    LLotIte.SQL.Add('  AND IFNULL(LOT_DIGCON,"N") = "N"  ');
    LLotIte.SQL.Add('  AND IFNULL(LOT_GARPRI,"N") = "N"  ');

    LLotIte.SQL.Add('  AND LOT_CODITE IN (' + LCodItens + ')');

    LLotIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LLotIte.ParamByName('BROKER').AsString := 'N';
    LLotIte.Open;

    LLotIte.First;

    FLotes.BeginBatch;
    Try

      While Not LLotIte.Eof Do
      Begin
        pProgresso(LLotIte.RecNo, LLotIte.RecordCount, pgbStatus);
        InsereLote(LLotIte);
        LLotIte.Next;
      End;

    Finally
      FLotes.EndBatch;
    End;

    Result := True;

  Finally

    If Assigned(LLotIte) Then
      FreeAndNil(LLotIte);

  End;

end;

function TDefineLotesWMSRemessaDeSeparacao.DefineLotesInterna: Boolean;
Begin

  FLotes.EmptyDataSet;

  Result := fExecutarModal(CarregaLotesInterna, 'Aguarde, carregando lotes (1/2)...', '');

  If Result Then
    Result := fExecutarModal(DefinirLotesInterna, 'Aguarde, definindo lotes para separação (2/2)...', '');

  MontaMensagemItensQtdeDivergente;

  If Result Then
    Result := (Not PossuiMensagemDeErro);

end;

procedure TDefineLotesWMSRemessaDeSeparacao.CriaLotesItens;
begin

  FLotes := TFDMemTable.Create(Nil);

  FLotes.LogChanges                 := False;
  FLotes.ResourceOptions.SilentMode := True;
  FLotes.UpdateOptions.LockMode     := lmNone;
  FLotes.UpdateOptions.LockPoint    := lpDeferred;
  FLotes.UpdateOptions.FetchGeneratorsPoint := gpImmediate;

  FLotes.FieldDefs.Add('AUTINC', ftString, 20);
  FLotes.FieldDefs.Add('CODITE', ftString, 7);
  FLotes.FieldDefs.Add('NUMLOT', ftString, 30);
  FLotes.FieldDefs.Add('LOTORI', ftString, 30);
  FLotes.FieldDefs.Add('LOTDES', ftString, 30);
  FLotes.FieldDefs.Add('DESLOC', ftString, 100);
  FLotes.FieldDefs.Add('PRIORI', ftString, 4);

  FLotes.FieldDefs.Add('LOCFIS', ftString, 20);
  FLotes.FieldDefs.Add('PICKIN', ftString, 100);
  FLotes.FieldDefs.Add('TRANSI', ftString, 100);
  FLotes.FieldDefs.Add('BALCAO', ftString, 100);
  FLotes.FieldDefs.Add('PRILAB', ftString, 100);
  FLotes.FieldDefs.Add('PRITIN', ftString, 100);

  FLotes.FieldDefs.Add('DTAVAL', ftDate);
  FLotes.FieldDefs.Add('SALDOS', ftFloat);
  FLotes.FieldDefs.Add('SALRES', ftFloat);
  FLotes.FieldDefs.Add('SALDIS', ftFloat);
  FLotes.FieldDefs.Add('QTDITE', ftFloat);
  FLotes.FieldDefs.Add('TOTDIG', ftFloat);

  FLotes.FieldDefs.Add('ORIGEM', ftString, 20);
  FLotes.FieldDefs.Add('BROKER', ftString, 100);
  FLotes.FieldDefs.Add('CODSEP', ftString, 100); //utilizado qndo CFG_LSEWMS = S
  FLotes.FieldDefs.Add('CODLSE', ftString, 100); //utilizado qndo CFG_LSEWMS = S
  FLotes.FieldDefs.Add('RASTRE', ftString, 100);

  FLotes.FieldDefs.Add('QTDREP', ftFloat);
  FLotes.FieldDefs.Add('MOVENT', ftFloat);
  FLotes.FieldDefs.Add('MOVSAI', ftFloat);

  FLotes.FieldDefs.Add('CODACA', ftString, 100);

  FLotes.CreateDataSet;

  TFloatField(FLotes.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(3);
  TFloatField(FLotes.FieldByName('SALDOS')).DisplayFormat := fMskDigitos(3);
  TFloatField(FLotes.FieldByName('SALRES')).DisplayFormat := fMskDigitos(3);
  TFloatField(FLotes.FieldByName('SALDIS')).DisplayFormat := fMskDigitos(3);
  TFloatField(FLotes.FieldByName('TOTDIG')).DisplayFormat := fMskDigitos(3);

  If fCfgSis('BFSGIS', varBoolean) Then
    FLotes.IndexFieldNames := 'AUTINC;CODITE;PICKIN;NUMLOT'
  Else
    FLotes.IndexFieldNames := 'AUTINC;CODITE;NUMLOT';

end;

procedure TDefineLotesWMSRemessaDeSeparacao.InsereLote(ALotIte : TUniQuery);
  Var
    LDadosEstoqueLote : TDadosEstoqueLote;
Begin

  FLotes.Append;
  FLotes.FieldByName('PRIORI').AsString := '9999';
  FLotes.FieldByName('QTDITE').AsFloat  := 0;
  FLotes.FieldByName('TOTDIG').AsFloat  := 0;
  FLotes.FieldByName('LOTORI').AsString := 'A DEFINIR';
  FLotes.FieldByName('AUTINC').AsString := '';
  FLotes.FieldByName('CODITE').AsString := ALotIte.FieldByName('LOT_CODITE').AsString;
  FLotes.FieldByName('NUMLOT').AsString := ALotIte.FieldByName('LOT_NUMLOT').AsString;
  FLotes.FieldByName('LOTDES').AsString := ALotIte.FieldByName('LOT_NUMLOT').AsString;
  FLotes.FieldByName('LOCFIS').AsString := ALotIte.FieldByName('LOT_LOCFIS').AsString;
  FLotes.FieldByName('DESLOC').AsString := IIF(fCfgSis('CADLOC', varBoolean), ALotIte.FieldByName('LOC_DESCRI').AsString, '');
  FLotes.FieldByName('PICKIN').AsString := IIF(ALotIte.FieldByName('LOC_PICKIN').AsString = 'S', 'SIM', '');
  FLotes.FieldByName('TRANSI').AsString := IIF(ALotIte.FieldByName('LOC_TRANSI').AsString = 'S', 'SIM', '');
  FLotes.FieldByName('BALCAO').AsString := IIF(ALotIte.FieldByName('LOC_BALCAO').AsString = 'S', 'SIM', '');
  FLotes.FieldByName('PRITIN').AsString := ALotIte.FieldByName('LOT_PRITIN').AsString;
  FLotes.FieldByName('DTAVAL').Value    := IIF(ALotIte.FieldByName('LOT_DTAVAL').IsNull, Null, ALotIte.FieldByName('LOT_DTAVAL').AsDateTime);
  FLotes.FieldByName('ORIGEM').AsString := '';
  FLotes.FieldByName('BROKER').AsString := 'N';
  FLotes.FieldByName('RASTRE').AsString := ALotIte.FieldByName('ITE_RASTRE').AsString;
  FLotes.FieldByName('QTDREP').AsFloat  := ALotIte.FieldByName('LCI_QTDREP').AsFloat;

  LDadosEstoqueLote := RetSaldoLoteRemessaDeSeparacao(FLotes.FieldByName('CODITE').AsString,
                                                      FLotes.FieldByName('NUMLOT').AsString,
                                                      ALotIte.FieldByName('LOT_SALDOS').AsFloat);

  FLotes.FieldByName('SALDOS').AsFloat := LDadosEstoqueLote.fltSaldo          + LDadosEstoqueLote.fltMovimentacaoEntrada;
  FLotes.FieldByName('SALRES').AsFloat := LDadosEstoqueLote.fltSaldoReservado + LDadosEstoqueLote.fltMovimentacaoSaida;
  FLotes.FieldByName('MOVENT').AsFloat := LDadosEstoqueLote.fltMovimentacaoEntrada;
  FLotes.FieldByName('MOVSAI').AsFloat := LDadosEstoqueLote.fltMovimentacaoSaida;
  FLotes.FieldByName('SALDIS').AsFloat := FLotes.FieldByName('SALDOS').AsFloat -
                                          FLotes.FieldByName('SALRES').AsFloat -
                                          FLotes.FieldByName('TOTDIG').AsFloat;

  If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
  Begin
    FLotes.FieldByName('SALDIS').AsFloat := FLotes.FieldByName('SALDIS').AsFloat + FLotes.FieldByName('SALRES').AsFloat;
  End;

  FLotes.Post;

End;

procedure TDefineLotesWMSRemessaDeSeparacao.MontaMensagemItensQtdeDivergente;
  const
    SQL = 'SELECT ' +
          '  GROUP_CONCAT(DISTINCT CONCAT(''"'',FGO_SEQSEP,''"'')) SEQSEP ' +
          'FROM       ' +
          '  EXTGOR E ' +
          '  INNER JOIN FATDOR F ON E.FGO_SEQFGO = F.FDO_SEQGER ' +
          'WHERE                      ' +
          '  FGO_SEQOND = :SEQOND AND ' +
          '  FDO_CODITE = :CODITE     ' +
          'GROUP BY     ' +
          '  FDO_CODITE ' +
          'ORDER BY     ' +
          '  FGO_SEQSEP ';
  var
    LItem  : TItemDiverg;
    LDesIte: String;
    LQry   : TUniQuery;

    ItemRemessa : TItemRemessa;

begin

  If Not fTravaSaldoDisponivelGeracaoRemessaPedido Then
    Exit;

  if (Length(FItensDiverg) <= 0) then
    Exit;

  ArmazenaMensagem('Não foi possível gerar LOTDOR - Não existe saldo disponível ' +
                   'suficiente nas localizações físicas para os produtos abaixo:');

  ArmazenaMensagem('');

  LQry := fCriaQuery;

  try
    LQry.SQL.Text := SQL;

    for LItem in FItensDiverg do
    begin
      LDesIte := fRetNomProduto(LItem.strCodIte);

      ArmazenaMensagem('   ' + LItem.strCodIte + ' - ' + LDesIte +
       ' - Qtd. Necessária: '+ FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), LItem.fltQtdIte) +
       ' - Qtd. Disponível: '+ FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), LItem.fltSalDis));

      LQry.Close;
      LQry.ParamByName('SEQOND').AsString := FRemessaDeSeparacao;
      LQry.ParamByName('CODITE').AsString := LItem.strCodIte;
      LQry.Open;

      while not LQry.Eof do
      begin
        ArmazenaMensagem('           Remessa(s) de Pedido: ' + LQry.FieldByName('SEQSEP').AsString);

        FillChar(ItemRemessa, SizeOf(ItemRemessa), #0);

        ItemRemessa.CodigoDoItem    := LItem.strCodIte;
        ItemRemessa.CodigoDaRemessa := LQry.FieldByName('SEQSEP').AsString;

        If Not fEmptyStr(ItemRemessa.CodigoDoItem) And
           Not fEmptyStr(ItemRemessa.CodigoDaRemessa) Then
        Begin
          SetLength(FItensRemessa, Length(FItensRemessa)+1);
          FItensRemessa[High(FItensRemessa)] := ItemRemessa;
        End;

        LQry.Next;

      end;

      ArmazenaMensagem('');
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TDefineLotesWMSRemessaDeSeparacao.DefinirSugestao;
  Var
    LIndexName : String;
    LQtdNecessaria : Double;
    LTot_Consumida : Double;

    LCodIteSelecionado : String;
    LQtdIteSelecionado : Double;

  procedure Filtrar(AFiltroAdicional : String = '');
    var
      LFiltroItem : String;
  begin

    LFiltroItem := '(SALDIS > 0) AND (CODITE = ' + QuotedStr(LCodIteSelecionado) + ')';

    FLotes.Filtered := False;
    FLotes.Filter   := LFiltroItem + IIF(fEmptyStr(AFiltroAdicional), '', ' AND ' + AFiltroAdicional);
    FLotes.Filtered := True;

    FLotes.IndexFieldNames := RetornaIndexFieldNamesPrioridadesSugestaoOndaDeSeparacao(FLotes);

  end;

  procedure ConsomeSaldo(AFiltroAdicional : String = '');

    procedure ConsomeSaldoInterna(AQuantidadeConsumida : Double);
    begin

      LQtdNecessaria := (LQtdNecessaria - AQuantidadeConsumida);
      LTot_Consumida := (FLotes.FieldByName('QTDITE').AsFloat + AQuantidadeConsumida);

      FLotes.Edit;
      FLotes.FieldByName('QTDITE').AsFloat := LTot_Consumida;
      FLotes.Post;

    end;

  begin

    Filtrar(AFiltroAdicional);

    FLotes.First;
    While Not FLotes.Eof Do
    Begin

      ConsomeSaldoInterna(IIF(FLotes.FieldByName('SALDIS').AsFloat >= LQtdNecessaria, LQtdNecessaria, FLotes.FieldByName('SALDIS').AsFloat));

      If (LQtdNecessaria <= 0) then
        Break;

      FLotes.Next;

    End;

  end;

  procedure AddItemNaoAtendido(ASalDis : Double);
  begin
    SetLength(FItensDiverg, Length(FItensDiverg) +1);
    FItensDiverg[High(FItensDiverg)].strCodIte := LCodIteSelecionado;
    FItensDiverg[High(FItensDiverg)].fltQtdIte := LQtdIteSelecionado;
    FItensDiverg[High(FItensDiverg)].fltSalDis := ASalDis;
  end;

  procedure RemoveLotesNaoUtilizados;
  begin
    Filtrar('(QTDITE <= 0)');
    While Not FLotes.Eof Do
      FLotes.Delete;
  end;

Begin

  LCodIteSelecionado := FConsulta.FieldByName('FDO_CODITE').AsString;
  LQtdIteSelecionado := FConsulta.FieldByName('FDO_QTDITE').AsFloat;

  LIndexName := FLotes.IndexFieldNames;

  Try

    LQtdNecessaria := LQtdIteSelecionado;
    LTot_Consumida := 0;

    If (LQtdNecessaria <= 0) Then
      Exit;

    If (LQtdNecessaria > 0) Then
      ConsomeSaldo('(PICKIN = ' + QuotedStr('SIM') + ')');

    If (LQtdNecessaria > 0) Then
      ConsomeSaldo('(PICKIN <> ' + QuotedStr('SIM') + ')');

    If (LQtdNecessaria > 0) Then
      AddItemNaoAtendido(LTot_Consumida);

    RemoveLotesNaoUtilizados;

  Finally
    FLotes.IndexFieldNames := LIndexName;
    FLotes.Filtered := False;
    FLotes.Filter   := '';
  End;
end;

procedure TDefineLotesWMSRemessaDeSeparacao.setItensAgrupadosRemessa(AItensAgrupadosRemessaSeparacao: TItensAgrupadosRemessaSeparacao);
begin
  FItensAgrupadosRemessaSeparacao := AItensAgrupadosRemessaSeparacao;
end;

end.
