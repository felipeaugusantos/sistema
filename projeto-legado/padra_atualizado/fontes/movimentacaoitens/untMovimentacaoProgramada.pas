unit untMovimentacaoProgramada;

interface

Uses SysUtils, StrUtils, Uni, Data.DB, UniClientDataSet, Variants, untZClient, Math,
  System.Classes;

Type
  TTipoMovimento = (tmEntrada, tmSaida);
  TSelecaoLocalizacao = (tssNull, tssMaior, tssMenor);
  TModeloCalculoAbastecimento = (mcaCapacidadeMaxPicking = 1, mcaCapacidadeMaxPickingEQtdPedido = 2);

  TInformacoesMovimentacao = Record
    fltQtdRep : Double;
    fltQtdMax : Double;
    fltSalDis : Double;
    fltSaldos : Double;
    fltMovEnt : Double;
    fltMovSai : Double;
  End;

  TMovimentacaoProgramada = Class(TInterfacedObject)
  private
    FdtaDatVen   : TDate;
    FstrCodOpe   : String;
    FstrSeqGor   : String;
    FstrNumRom   : String;
    FblnPickin   : Boolean;
    FblnControlaValidade : boolean;
    FstlTemMovimentoProgramadoEmAberto: TStringList;
    FEhCaixa : Boolean;
    FModeloCalculoAbastecimento : TModeloCalculoAbastecimento;
    FImpressaoDaSeparacao : Boolean;

    FQuantidadeDisponivel : Double;

    procedure pIniciaQryItens(var cdsItens : TUniQuery); virtual; abstract;
    function fSaldoDisponivelLocalizacaoFisica(strCodIte, strCodLoc : String; var recInformacoes : TInformacoesMovimentacao): real;
    function fVerificaNecessidaDeAbastecimento(strCodIte: String; var recInformacoes : TInformacoesMovimentacao): Boolean;
    function fGeraMovimentacaoProgramada(strCodIte, strCodLoc: String; fltQuantidadeSolicitada : real; blnAtivarAposConfirmacao : boolean; recInformacoesPicking : TInformacoesMovimentacao; fltQtdIte : double = 0; strOpeDes: String = ''; strLotOri: String = ''; blnConfirmacaoPainel: Boolean = False; blnManual: Boolean = False): boolean;
    function fAbastecePickins(strCodIte, strIdePro: String; blnAtivarAposConfirmacao : Boolean; fltQtdIte : double = 0 ) : boolean;
    function fSaldoFuturoLote(strCodIte, strNumLot : String; var recInformacoes : TInformacoesMovimentacao): real;
    function fItemTemLocalizacaoMapeada(strCodIte : String) : Boolean;
    function fGetSQLLotesPulmao(enuOrdenacao: TSelecaoLocalizacao; strLotOri: String = ''): String;
    function fGetWherePulmoesDisponiveis(strLotOri: String = ''): String;
    procedure pZeraInformacoesMovimentacao(
      var recInformacoes: TInformacoesMovimentacao);
    procedure pGetInformarcoesPulmao(strCodIte, strNumLotMovimentacao: String;
      var recInformacoesLote, recInformacoesPulmoes: TInformacoesMovimentacao; strLotOri: String = '');
    procedure pCalculaSaldoDisponivelPulmoes(DataSet: TDataSet);
    procedure pCriaeIncluiNovoLoteAbastPrev(var AStrNewLot: String;AStrCodLoc, AStrCodIte, AStrLocOri: String; ADtaDtaVal: TDateTime);
    function fEhProdutoAcabado(const strCodIte: String): Boolean;
    function fGetProdutoAcabado(const strCodIte: String): String;
    function fGetIdentificacaoProduto(const strCodIte: String): String;
    function fValidaQtdDisponivelLotesMovAbertas(AFltQtdAMovimentar: Double; AStrLotOri, AStrCodIte: String): Boolean;
  Public
    function fCriaQueryInsertMovLot: TUniQuery;
    procedure pGravarMovLotAbastPicking(AQryInsert: TUniQuery; AStrCodIte, AStrLotOri, AStrLocOri, AStrLocDes, AStrCodOpeDest: String; AFltQtdTransf: Double; ADtaDtaVal: TDateTime);
    function fTemMovimentoProgramadoEmAberto(strCodIte: String): Boolean;
    function fTemMovimentoProgramadoEmAbertoParaPickingCheckout(strCodIte: String): Boolean;
    function fOperador(strCodOpe: String) : TMovimentacaoProgramada;
    function fDataVencimento(dtaDatVen: TDate) : TMovimentacaoProgramada;
    function fPickin(blnPickin: Boolean) : TMovimentacaoProgramada;
    function fRealizaMovimentos : Boolean; overload;
    function fRealizaMovimentos(strCodIte : String; fltQtdIte : double) : Boolean; overload;
    function fRealizaMovimentos(strCodIte, strLocDes: String; fltQtdIte: double; strOpeDes: String; blnManual: Boolean = False; strLotOri: String = ''; blnConfirmacaoPainel: Boolean = False): Boolean; overload;
    class function fQuantidadeMovimentacaoLote(strCodIte, strNumLot : String; enuTipoMovimento : TTipoMovimento) : real;
    procedure pAtivaMovimentacoes;
    procedure pDeletaMovimentacoes;
    constructor Create(AKey: string; AImpressaoDaSeparacao: Boolean = False); virtual;
    Destructor Destroy; override;
    procedure pLimpar;
    procedure pSetImpressaoDaSeparacao(AValue : Boolean);
    function fGetQtdLotdorItem(strCodIte, strNumLot: String): real;

    procedure pSetQuantidadeDisponivel(AQuantidadeDisponivel : Double);

    function fEhTintaAutomotiva(strIdePro : String = '') : Boolean;

  Public
    property QuantidadeDisponivel : Double Read FQuantidadeDisponivel;
  End;

  TMovimentacaoProgramadaCaixa = Class(TMovimentacaoProgramada)
  private
    FItensCaixa : TUniClientDataSet;
    procedure pIniciaQryItens(var qryItens : TUniQuery); override;
  public
    procedure pSetItensCaixa(const AItensCaixa : TUniClientDataSet);
    constructor Create(AKey: string; AImpressaoDaSeparacao: Boolean = False); override;
    destructor  Destroy; override;
  end;

  TMovimentacaoProgramadaPedido = Class(TMovimentacaoProgramada)
  private
    procedure pIniciaQryItens(var qryItens : TUniQuery); override;
  public
    constructor Create(AKey: String; AImpressaoDaSeparacao: Boolean = False); override;
  end;

  TMovimentacaoProgramadaRomaneio = Class(TMovimentacaoProgramada)
  private
    procedure pIniciaQryItens(var qryItens : TUniQuery); override;
  public
    constructor Create(AKey: string; AImpressaoDaSeparacao: Boolean = False); override;
  end;

  TMovimentacaoProgramadaManual = Class(TMovimentacaoProgramada)
  private
    procedure pIniciaQryItens(var qryItens : TUniQuery); override;
  public
    constructor Create(AKey: string; AImpressaoDaSeparacao: Boolean = False); override;
  end;

  procedure RealizarMovimentacaoProgramadaPedido(AAutoincrem: String;
                                                 ADefiniuLotes: Boolean;
                                                 AEhExpedicao : Boolean = False);

implementation

uses
  untFuncoesSimples, untCadLoteItens, untConstantes, untFuncTinta, untTipoTinta,
  untFuncoesWMS, untTypesSistema;

{ TMovimentacaoProgramada }

function TMovimentacaoProgramada.fRealizaMovimentos: Boolean;
  Var
    qryFatDor : TUniQuery;
    recInformacoesPicking : TInformacoesMovimentacao;
    strIdentificacaoDoProduto : String;

  function fRetQtdPedido : Double;
  begin

    Result := 0;

    If Not FImpressaoDaSeparacao Then
      Exit;

    If Not Assigned(qryFatDor) Then
      Exit;

    If Not Assigned(qryFatDor.FindField('QTDPED')) Then
      Exit;

    Result := qryFatDor.FieldByName('QTDPED').AsFloat;

  end;

begin
  Result := False;
  qryFatDor := fCriaQuery;

  Try
    pIniciaQryItens(qryFatDor);

    qryFatDor.Open;

    While Not qryFatDor.Eof Do
    Begin
      try
        strIdentificacaoDoProduto := '';

        If (qryFatDor.FindField('IDEPRO') <> Nil) Then
          strIdentificacaoDoProduto := qryFatDor.FindField('IDEPRO').AsString;

        If fEhTintaAutomotiva(strIdentificacaoDoProduto) Then
        Begin
          qryFatDor.Next;
          Continue;
        End;

        If (qryFatDor.FindField('QTDPED') <> Nil) And (qryFatDor.FindField('PROACA') <> Nil) Then
          If fSugereBufferQuantSepMaiorIgualCapacidadeMaxPicking(qryFatDor.FieldByName('ITE_CODITE').AsString,
                                                                 qryFatDor.FieldByName('QTDPED').AsFloat,
                                                                 strIdentificacaoDoProduto,
                                                                 qryFatDor.FieldByName('PROACA').AsString) Then
          Begin
            qryFatDor.Next;
            Continue;
          End;

        if fItemTemLocalizacaoMapeada(qryFatDor.FieldByName('ITE_CODITE').AsString) then
          Result := fAbastecePickins(qryFatDor.FieldByName('ITE_CODITE').AsString, strIdentificacaoDoProduto, False, fRetQtdPedido) or Result
        else
        begin
          If (not fTemMovimentoProgramadoEmAberto(qryFatDor.FieldByName('ITE_CODITE').AsString)) and fVerificaNecessidaDeAbastecimento(qryFatDor.FieldByName('ITE_CODITE').AsString, recInformacoesPicking) Then
            Result := (fGeraMovimentacaoProgramada(qryFatDor.FieldByName('ITE_CODITE').AsString,'', 0, false, recInformacoesPicking,0)) or Result;
        end;

        qryFatDor.Next;
      except
        on E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente do
          begin
            fMensagem('', E.Message, ['&Ok']);
            qryFatDor.Next;
            Continue;
          end;

        on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
          begin
            fMensagem('Aviso', E.Message, ['&OK']);
            qryFatDor.Next;
            Continue;
          end;

        on E: ExceptionAutComErroAoIncluirMovimentacaoProgramada do
          begin
            fMensagem('Aviso', E.Message, ['&OK']);
            qryFatDor.Next;
            Continue;
          end;

        on e: Exception do
          raise;
      end;
    End;
  Finally
    FreeAndNil(qryFatDor);
  End;
end;

function TMovimentacaoProgramada.fRealizaMovimentos(strCodIte: String; fltQtdIte : double): Boolean;
var
  recInformacoes : TInformacoesMovimentacao;
begin
  Result := False;

  If fEhProdutoAcabado(strCodIte) Then
    Exit;

  If fSugereBufferQuantSepMaiorIgualCapacidadeMaxPicking(strCodIte, fltQtdIte,
                                                         fGetIdentificacaoProduto(strCodIte),
                                                         fGetProdutoAcabado(strCodIte)) Then
    Exit;

  try
    If fItemTemLocalizacaoMapeada(strCodIte) then
      Result := fAbastecePickins(strCodIte, fGetIdentificacaoProduto(strCodIte), true, fltQtdIte)
    else
    begin
      If not fTemMovimentoProgramadoEmAberto(strCodIte) Then
      begin
        fVerificaNecessidaDeAbastecimento(strCodIte, recInformacoes); //pega informações do picking
        Result := fGeraMovimentacaoProgramada(strCodIte, '', 0, true, recInformacoes, fltQtdIte);
      end;
    end;
  except
    on E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente do
      raise;

    on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
     raise;

    on E: ExceptionAutComErroAoIncluirMovimentacaoProgramada do
      raise;

    on E: Exception do
      raise;
  end;
end;

function TMovimentacaoProgramada.fRealizaMovimentos(strCodIte,
  strLocDes: String; fltQtdIte: double; strOpeDes: String; blnManual: Boolean = False; strLotOri: String = ''; blnConfirmacaoPainel: Boolean = False): Boolean;
var
  recInformacoes : TInformacoesMovimentacao;
begin
  Result := False;

  If fEhProdutoAcabado(strCodIte) Then
    Exit;

  If fSugereBufferQuantSepMaiorIgualCapacidadeMaxPicking(strCodIte, fltQtdIte,
                                                         fGetIdentificacaoProduto(strCodIte),
                                                         fGetProdutoAcabado(strCodIte)) Then
    Exit;

  try
    If (not blnManual) And fItemTemLocalizacaoMapeada(strCodIte) then
      Result := fAbastecePickins(strCodIte, fGetIdentificacaoProduto(strCodIte), true, fltQtdIte)
    else If blnConfirmacaoPainel Then
      Result := fGeraMovimentacaoProgramada(strCodIte, strLocDes, fltQtdIte, false, recInformacoes, 0, strOpeDes, strLotOri, blnConfirmacaoPainel)
    else
    begin
      If (not fTemMovimentoProgramadoEmAberto(strCodIte)) Or (blnManual) Then
      begin
        fVerificaNecessidaDeAbastecimento(strCodIte, recInformacoes); //pega informações do picking
        Result := fGeraMovimentacaoProgramada(strCodIte, strLocDes, fltQtdIte, false, recInformacoes, 0, strOpeDes, strLotOri, false, blnManual);
      end;
    end;
  except
    on E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente do
      raise;

    on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
     raise;

    on E: ExceptionAutComErroAoIncluirMovimentacaoProgramada do
      raise;

    on E: Exception do
      raise;
  end;
end;

function TMovimentacaoProgramada.fTemMovimentoProgramadoEmAberto(strCodIte : String) : Boolean;
  Var
    qryFatDor : TUniQuery;
begin

  if FstlTemMovimentoProgramadoEmAberto.IndexOf(strCodIte) >= 0 then
    Exit(False);

  if FEhCaixa then
  begin
    Result := fTemMovimentoProgramadoEmAbertoParaPickingCheckout(strCodIte);
    if Result then
      FstlTemMovimentoProgramadoEmAberto.Add(strCodIte);
    Exit;
  end;

  qryFatDor := fCriaQuery;
  Try
    With qryFatDor, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT COUNT(*) AS QTD FROM MOVLOT        ');
      Add(' WHERE MLT_CODEMP = :EMPEST  ');
      Add('   AND MLT_CODITE = :CODITE  ');
      Add('   AND MLT_DTAREA IS NULL    ');

      ParamByName('EMPEST').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;

      Open;

      Result := FieldByName('QTD').AsInteger > 0;

      FstlTemMovimentoProgramadoEmAberto.Add(strCodIte);

      Close;
    End;
  Finally
    FreeAndNil(qryFatDor);
  End;
End;

function TMovimentacaoProgramada.fTemMovimentoProgramadoEmAbertoParaPickingCheckout(strCodIte: String): Boolean;
  Var
    qryPicOut : TUniQuery;
begin

  qryPicOut := fCriaQuery;

  Try

    qryPicOut.Close;

    qryPicOut.SQL.Clear;
    qryPicOut.SQL.Add('SELECT            ');
    qryPicOut.SQL.Add('  COUNT(*) AS QTD ');
    qryPicOut.SQL.Add('FROM              ');
    qryPicOut.SQL.Add('  MOVLOT ML       ');
    qryPicOut.SQL.Add('  INNER JOIN CADLOT LT ON (LT.LOT_NUMLOT = ML.MLT_LOTDES AND ');
    qryPicOut.SQL.Add('                           LT.LOT_CODEMP = ML.MLT_CODEMP AND ');
    qryPicOut.SQL.Add('                           LT.LOT_CODITE = ML.MLT_CODITE)    ');
    qryPicOut.SQL.Add('  INNER JOIN CADLOC LC ON (LC.LOC_CODLOC = LT.LOT_LOCFIS AND ');
    qryPicOut.SQL.Add('                           LC.LOC_CODEMP = LT.LOT_CODEMP)    ');
    qryPicOut.SQL.Add('WHERE ML.MLT_CODEMP = :EMPEST ');
    qryPicOut.SQL.Add('  AND ML.MLT_CODITE = :CODITE ');
    qryPicOut.SQL.Add('  AND ML.MLT_DTAREA IS NULL   ');
    qryPicOut.SQL.Add('  AND LC.LOC_PICKIN = "C"     ');

    qryPicOut.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryPicOut.ParamByName('CODITE').AsString := strCodIte;
    qryPicOut.Open;

    Result := qryPicOut.FieldByName('QTD').AsInteger > 0;

  Finally
    FreeAndNil(qryPicOut);
  End;

End;

function TMovimentacaoProgramada.fItemTemLocalizacaoMapeada(strCodIte : String) : Boolean;
  Var
    qryFatDor : TUniQuery;
begin
  qryFatDor := fCriaQuery;
  Try
    qryFatDor.Close;
    qryFatDor.SQL.Clear;

    qryFatDor.SQL.Add(' SELECT COUNT(*) AS QTD FROM LOCITE        ');
    qryFatDor.SQL.Add(' WHERE LCI_CODEMP = :EMPEST  ');
    qryFatDor.SQL.Add('   AND LCI_CODITE = :CODITE  ');

    qryFatDor.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryFatDor.ParamByName('CODITE').AsString := strCodIte;

    qryFatDor.Open;

    Result := qryFatDor.FieldByName('QTD').AsInteger > 0;

    qryFatDor.Close;
  Finally
    FreeAndNil(qryFatDor);
  End;
End;

procedure TMovimentacaoProgramada.pZeraInformacoesMovimentacao( var recInformacoes : TInformacoesMovimentacao );
begin
  recInformacoes.fltQtdRep := 0;
  recInformacoes.fltQtdMax := 0;
  recInformacoes.fltSalDis := 0;
  recInformacoes.fltSaldos := 0;
  recInformacoes.fltMovEnt := 0;
  recInformacoes.fltMovSai := 0;
end;

function TMovimentacaoProgramada.fVerificaNecessidaDeAbastecimento(strCodIte : String; var recInformacoes : TInformacoesMovimentacao) : Boolean;
  Var
    qryPickin : TUniQuery;
Begin
  pZeraInformacoesMovimentacao(recInformacoes);

  qryPickin := fCriaQuery;
  Try
    With qryPickin, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT LOT_CODITE,                             ');
      Add('        LOT_CODEMP,                             ');
      Add('        LOT_NUMLOT,                             ');
      Add('        LOT_SALDOS                              ');
      Add(' FROM CADLOT                                    ');
      Add('   INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ');
      Add('                    AND LOC_CODEMP = LOT_CODEMP ');
      Add(' WHERE LOT_CODITE = :CODITE                     ');
      Add('   AND LOT_CODEMP = :EMPEST                     ');
      Add('   AND LOC_PICKIN = "S"                         ');
      Add('   AND LOT_NUMLOT <> "A DEFINIR"                ');

      If fUsaPickingLaboratorioWms Then
      Begin
        If fEhTintaImobiliaria(fGetIdentificacaoProduto(strCodIte)) Then
          Add(' AND IFNULL(LOC_PRILAB,"N") = "S" ')
        Else
          Add(' AND IFNULL(LOC_PRILAB,"N") = "N" ');
      End;

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('EMPEST').AsString := VS_strCodEmp;

      Open;

      While Not Eof Do
      Begin
        recInformacoes.fltSaldos := recInformacoes.fltSaldos + FieldByName('LOT_SALDOS').AsFloat;
        recInformacoes.fltSalDis := recInformacoes.fltSalDis + fRetornaSaldoDisponivel(FieldByName('LOT_CODITE').AsString,
                                                                                       False,
                                                                                       True,
                                                                                       FieldByName('LOT_NUMLOT').AsString,
                                                                                       True,
                                                                                       FieldByName('LOT_CODEMP').AsString,
                                                                                       '', False, True, True, False, False, False, '', '', True);

        Next;
      End;

      Close;

      Result := (recInformacoes.fltSalDis <= 0);
    End;

  Finally
    FreeAndNil(qryPickin);
  End;


End;

procedure TMovimentacaoProgramada.pAtivaMovimentacoes;
  Var
    qryUpdate : TUniQuery;
Begin
  qryUpdate := fCriaQuery;
  Try
    qryUpdate.SQL.Add(' UPDATE MOVLOT SET MLT_ATIVO_ = "S" WHERE MLT_SEQFGO = :SEQFGO');
    qryUpdate.ParamByName('SEQFGO').AsString := FstrSeqGor;
    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
End;

procedure TMovimentacaoProgramada.pDeletaMovimentacoes;
  Var
    qryDelete : TUniQuery;
Begin
  qryDelete := fCriaQuery;
  Try
    qryDelete.SQL.Add(' DELETE FROM MOVLOT WHERE MLT_SEQFGO = :SEQFGO AND MLT_ATIVO_ = "N"');
    qryDelete.ParamByName('SEQFGO').AsString := FstrSeqGor;
    qryDelete.ExecSQL;
  Finally
    FreeAndNil(qryDelete);
  End;
End;

class function TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot : String; enuTipoMovimento : TTipoMovimento): real;
var
  qryQuery : TUniQuery;
begin
  Result := 0;
  qryQuery := fCriaQuery;
  try
    qryQuery.SQL.Add('SELECT                                                   ');
    qryQuery.SQL.Add('  SUM(IF(MLT_QTDMOV=0,LOT_SALDOS, MLT_QTDMOV)) AS QTDMOV ');
    qryQuery.SQL.Add('FROM                                                     ');
    qryQuery.SQL.Add('  MOVLOT                                                 ');
    qryQuery.SQL.Add('  INNER JOIN CADLOT ON     LOT_CODEMP = MLT_CODEMP       ');
    qryQuery.SQL.Add('                       AND LOT_CODITE = MLT_CODITE       ');
    qryQuery.SQL.Add('                       AND LOT_NUMLOT = MLT_LOTORI       ');
    qryQuery.SQL.Add('WHERE                                                    ');
    qryQuery.SQL.Add('      MLT_DTAREA IS NULL                                 ');
    qryQuery.SQL.Add('  AND MLT_CODEMP = :EMPEST                               ');
    qryQuery.SQL.Add('  AND MLT_CODITE = :CODITE                               ');

    case enuTipoMovimento of
      tmEntrada : qryQuery.SQL.Add('  AND MLT_LOTDES = :NUMLOT                 ');
      tmSaida   : qryQuery.SQL.Add('  AND MLT_LOTORI = :NUMLOT                 ');
    end;

    qryQuery.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryQuery.ParamByName('CODITE').AsString := strCodIte;
    qryQuery.ParamByName('NUMLOT').AsString := strNumLot;

    qryQuery.Open;

    if not qryQuery.isEmpty then
      Result := qryQuery.FieldByName('QTDMOV').ASFloat;

  finally
    FreeAndNil(qryQuery);
  end;

end;

function TMovimentacaoProgramada.fGetQtdLotdorItem(strCodIte, strNumLot: String): real;
var
  qryLotDor : TUniQuery;
begin
  qryLotDor := fCriaQuery;
  try
    qryLotDor.SQL.Add('SELECT SUM(LDO_QTDITE) AS QTDITE');
    qryLotDor.SQL.Add('FROM LOTDOR');
    qryLotDor.SQL.Add('INNER JOIN FATDOR ON FATDOR.AUTOINCREM = LDO_SEQFDO');
    qryLotDor.SQL.Add('WHERE FDO_SEQGER = :SEQGER');
    qryLotDor.SQL.Add('  AND FDO_CODITE = :CODITE');
    qryLotDor.SQL.Add('  AND LDO_NUMLOT = :NUMLOT');

    qryLotDor.ParamByName('SEQGER').AsString := FstrSeqGor;
    qryLotDor.ParamByName('CODITE').AsString := strCodIte;
    qryLotDor.ParamByName('NUMLOT').AsString := strNumLot;
    qryLotDor.Open;

    Result := qryLotDor.FieldByName('QTDITE').AsFloat;
  finally
    FreeAndNil(qryLotDor);
  end;
end;

function TMovimentacaoProgramada.fSaldoDisponivelLocalizacaoFisica(strCodIte, strCodLoc : String; var recInformacoes : TInformacoesMovimentacao): real;
var
  qryCadLot : TUniQuery;
  recInformacoesLote : TInformacoesMovimentacao;
begin
  result := 0;
  recInformacoes.fltSalDis := 0;
  recInformacoes.fltSaldos := 0;
  recInformacoes.fltMovEnt := 0;
  recInformacoes.fltMovSai := 0;

  qryCadLot := fCriaQuery;
  try
    qryCadLot.SQL.Add(' SELECT DISTINCT                                    ');
    qryCadLot.SQL.Add('   LOT_NUMLOT,                                      ');
    qryCadLot.SQL.Add('   LOT_SALDOS                                       ');
    qryCadLot.SQL.Add(' FROM                                               ');
    qryCadLot.SQL.Add('   CADLOT                                           ');
    qryCadLot.SQL.Add(' WHERE                                              ');
    qryCadLot.SQL.Add('       LOT_CODITE = :CODITE                         ');
    qryCadLot.SQL.Add('   AND LOT_LOCFIS = :CODLOC                         ');
    qryCadLot.SQL.Add('   AND LOT_CODEMP = :EMPEST                         ');
    qryCadLot.SQL.Add('   AND LOT_STATUS = "S"                             ');
    qryCadLot.SQL.Add('   AND IFNULL(LOT_TRANSI, "N") = "N"                ');

    qryCadLot.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryCadLot.ParamByName('CODITE').AsString := strCodIte;
    qryCadLot.ParamByName('CODLOC').AsString := strCodLoc;

    qryCadLot.Open;
    qryCadLot.First;

    while not qryCadLot.Eof do
    begin
      Result := Result + fSaldoFuturoLote(strCodIte, qryCadLot.FieldByName('LOT_NUMLOT').AsString, recInformacoesLote);

      recInformacoes.fltSaldos := recInformacoes.fltSaldos + qryCadLot.FieldByName('LOT_SALDOS').AsFloat;
      recInformacoes.fltSalDis := recInformacoes.fltSalDis + recInformacoesLote.fltSalDis;
      recInformacoes.fltMovEnt := recInformacoes.fltMovEnt + recInformacoesLote.fltMovEnt;
      recInformacoes.fltMovSai := recInformacoes.fltMovSai + recInformacoesLote.fltMovSai;

      qryCadLot.Next;
    end;

    qryCadLot.Close;

  finally
    FreeAndNil(qryCadLot);
  end;
end;


function TMovimentacaoProgramada.fSaldoFuturoLote(strCodIte, strNumLot : String; var recInformacoes : TInformacoesMovimentacao): real;
const
  FORCA_SALDO_RESERVADO_VIA_SELECT = True;
var
  curCnvML: Currency;
  LNumDoc : String;
begin
  curCnvML := fCampoTabela('ITE_CNV_ML', 'CADITE', ['ITE_CODITE'], [strCodIte]);
  LNumDoc := fCampoTabela('FGO_NUMDOC', 'FATGOR', ['AUTOINCREM'], [FstrSeqGor]);

  recInformacoes.fltSalDis := fRetornaSaldoDisponivel(strCodIte,
                                                      IIF(curCnvML > 0, True, False),
                                                      True,
                                                      strNumLot,
                                                      True,
                                                      VS_strCodEmp,
                                                      LNumDoc,
                                                      False,
                                                      True,
                                                      True,
                                                      False,
                                                      False,
                                                      False,
                                                      '',
                                                      '',
                                                      True,
                                                      FORCA_SALDO_RESERVADO_VIA_SELECT);
  If curCnvML > 0.00 Then
    recInformacoes.fltSalDis := roundTo((recInformacoes.fltSalDis / curCnvML),-4);

  recInformacoes.fltMovEnt := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmEntrada);
  recInformacoes.fltMovSai := TMovimentacaoProgramada.fQuantidadeMovimentacaoLote(strCodIte, strNumLot, tmSaida);

  Result := recInformacoes.fltSalDis + recInformacoes.fltMovEnt;
end;

constructor TMovimentacaoProgramada.Create(AKey: string; AImpressaoDaSeparacao: Boolean = False);
begin
  FdtaDatVen := 0;
  FblnPickin := True;
  FstrCodOpe := strLoginUsuarioLogado;
  FstrSeqGor := '';
  FstrNumRom := '';
  FblnControlaValidade := fCfgSis('COLVAL', varBoolean);
  FstlTemMovimentoProgramadoEmAberto := TStringList.Create;
  FEhCaixa := False;
  FModeloCalculoAbastecimento := IIF(fCfgSis('TIPMOV', varString) = '1', mcaCapacidadeMaxPicking, mcaCapacidadeMaxPickingEQtdPedido);
  FImpressaoDaSeparacao := AImpressaoDaSeparacao;

  FQuantidadeDisponivel := 0;

end;

destructor TMovimentacaoProgramada.Destroy;
begin
  FreeAndNil(FstlTemMovimentoProgramadoEmAberto);
  inherited;
end;

function TMovimentacaoProgramada.fAbastecePickins(strCodIte, strIdePro: String; blnAtivarAposConfirmacao : Boolean; fltQtdIte : double = 0): boolean;
var
  qryPickin : TUniQuery;
  fltSaldoPickin     : real;
  fltQuantidadeNecessaria  : real;
  recInformacoesLocalizacao : TInformacoesMovimentacao;

  function fGetSaldoPicking: Double;
  begin
    If (FImpressaoDaSeparacao) And (FModeloCalculoAbastecimento = mcaCapacidadeMaxPickingEQtdPedido) Then
      Result := (fltSaldoPickin - fltQtdIte)
    Else
      Result := fltSaldoPickin;
  end;
begin
  Result := False;
  pZeraInformacoesMovimentacao(recInformacoesLocalizacao);

  qryPickin := fCriaQuery;
  try
    qryPickin.SQL.Add(' SELECT DISTINCT                                        ');
    qryPickin.SQL.Add('   L.LOC_CODLOC,                                        ');
    qryPickin.SQL.Add('   IFNULL(I.LCI_QTDREP,0)       AS QTDREP,              ');
    qryPickin.SQL.Add('   IFNULL(I.LCI_QTDMAX,0)       AS QTDMAX               ');
    qryPickin.SQL.Add(' FROM                                                   ');
    qryPickin.SQL.Add('   CADLOT C                                             ');
    qryPickin.SQL.Add('   INNER JOIN CADLOC L ON     LOC_CODLOC = LOT_LOCFIS   ');
    qryPickin.SQL.Add('                          AND LOC_CODEMP = LOT_CODEMP   ');
    qryPickin.SQL.Add('   INNER JOIN LOCITE I ON     LCI_LOCFIS = L.AUTOINCREM ');
    qryPickin.SQL.Add('                          AND LCI_CODITE = C.LOT_CODITE ');
    qryPickin.SQL.Add(' WHERE                                                  ');
    qryPickin.SQL.Add('       LOT_CODEMP = :EMPEST                             ');
    qryPickin.SQL.Add('   AND LOT_CODITE = :CODITE                             ');
    qryPickin.SQL.Add('   AND LOT_NUMLOT <> "A DEFINIR"                        ');
    qryPickin.SQL.Add('   AND LOT_NUMLOT <> "GARANTIA"                         ');

    If FEhCaixa Then
      qryPickin.SQL.Add('   AND LOC_PICKIN = "C"                               ')
    Else
      qryPickin.SQL.Add('   AND LOC_PICKIN = "S"                               ');

    If fUsaPickingLaboratorioWms Then
    Begin
      If fEhTintaImobiliaria(strIdePro) Then
        qryPickin.SQL.Add(' AND IFNULL(LOC_PRILAB,"N") = "S" ')
      Else
        qryPickin.SQL.Add(' AND IFNULL(LOC_PRILAB,"N") = "N" ');
    End;

    qryPickin.SQL.Add('   AND IFNULL(LOC_CRITIC,"N") = "N"                     ');
    qryPickin.SQL.Add('   AND IFNULL(LOC_TRANSI,"N") = "N"                     ');
    qryPickin.SQL.Add('   AND IFNULL(LOC_BALCAO,"N") = "N"                     ');
    qryPickin.SQL.Add('   AND LOT_STATUS = "S"                                 ');
    qryPickin.SQL.Add('   AND LOT_LOTAPR = "S"                                 ');
    qryPickin.SQL.Add('   AND IFNULL(LOT_TRANSI, "N") = "N"                    ');
    qryPickin.SQL.Add(' ORDER BY                                               ');
    qryPickin.SQL.Add('   LOT_DTAVAL, LOC_CODLOC                               ');

    qryPickin.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryPickin.ParamByName('CODITE').AsString := strCodIte;

    qryPickin.Open;

    qryPickin.First;

    while not qryPickin.eof do
    begin
      pZeraInformacoesMovimentacao(recInformacoesLocalizacao);
      recInformacoesLocalizacao.fltQtdRep := qryPickin.fieldByName('QTDREP').AsFloat;
      recInformacoesLocalizacao.fltQtdMax := qryPickin.fieldByName('QTDMAX').AsFloat;

      fltSaldoPickin := fSaldoDisponivelLocalizacaoFisica(strCodIte, qryPickin.fieldByName('LOC_CODLOC').AsString, recInformacoesLocalizacao);

      if fGetSaldoPicking < qryPickin.fieldByName('QTDREP').AsFloat then
      begin
        fltQuantidadeNecessaria := qryPickin.fieldByName('QTDMAX').AsFloat - fGetSaldoPicking;

        while (fltQuantidadeNecessaria > 0) do
        begin

          Try

            if fGeraMovimentacaoProgramada(strCodIte,
                                           qryPickin.fieldByName('LOC_CODLOC').AsString,
                                           fltQuantidadeNecessaria,
                                           blnAtivarAposConfirmacao,
                                           recInformacoesLocalizacao,
                                           fltQuantidadeNecessaria) then
            begin
              fltSaldoPickin := fSaldoDisponivelLocalizacaoFisica(strCodIte, qryPickin.fieldByName('LOC_CODLOC').AsString, recInformacoesLocalizacao);
              fltQuantidadeNecessaria := qryPickin.fieldByName('QTDMAX').AsFloat - fGetSaldoPicking;
              Result := True;
            end
            else //se não realizou movimentação é pq não existe mais pulmão disponível, então deve sair do loop
              break
          Except
            On E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente Do
              Raise;

            on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
              raise;

            on E: ExceptionAutComErroAoIncluirMovimentacaoProgramada do
              raise;

            on E: Exception do
              raise;
          End;
        end;
      end;

      qryPickin.Next; 
    end;
  finally
    FreeAndNil(qryPickin);
  end;
end;

function TMovimentacaoProgramada.fDataVencimento(
  dtaDatVen: TDate): TMovimentacaoProgramada;
begin
  Result := Self;
  FdtaDatVen := dtaDatVen;
end;

function TMovimentacaoProgramada.fEhTintaAutomotiva(strIdePro: String): Boolean;
begin

  Result := False;

  If strIdePro.IsEmpty Then
    Exit;

  If strIdePro.Equals('NOR') Then
    Exit;

  If Not Assigned(fTipoTinta) Then
    Exit;

  If (fTipoTinta(strIdePro) <> ttAutomotiva) Then
    Exit;

  Result := True;

end;

function TMovimentacaoProgramada.fEhProdutoAcabado(
  const strCodIte: String): Boolean;
var
  qryDados: TUniQuery;
begin
  Result := False;

  If (fEmptyStr(strCodIte)) Then
    Exit;

  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := 'SELECT '
                       + '       FDO_CODITE '
                       + '     , FDO_CODACA '
                       + '     , FDO_PROACA '
                       + ' FROM FATDOR '
                       + ' WHERE FDO_SEQGER = :SEQFGO '
                       + '   AND FDO_CODITE = :CODITE ';

    qryDados.ParamByName('SEQFGO').AsString := FstrSeqGor;
    qryDados.ParamByName('CODITE').AsString := strCodIte;
    qryDados.Open;

    Result := (Not fEmptyStr(qryDados.FieldByName('FDO_CODACA').AsString)) And
              (qryDados.FieldByName('FDO_PROACA').AsString = 'S');
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TMovimentacaoProgramada.fGetProdutoAcabado(const strCodIte: String): String;
begin
  If (fEmptyStr(strCodIte)) Then
    Exit;

  Result := fCampoTabela('FDO_PROACA', 'FATDOR', ['FDO_SEQGER', 'FDO_CODITE'], [FstrSeqGor, strCodIte]);
end;

function TMovimentacaoProgramada.fGetIdentificacaoProduto(const strCodIte: String): String;
begin
  If (fEmptyStr(strCodIte)) Then
    Exit;

  Result := fCampoTabela('FDO_IDEPRO', 'FATDOR', ['FDO_SEQGER', 'FDO_CODITE'], [FstrSeqGor, strCodIte]);
end;

function TMovimentacaoProgramada.fGetWherePulmoesDisponiveis(strLotOri: String = '') : String;
begin
  Result := Result + ' WHERE                                                                  ';
  Result := Result + '       LOT_CODEMP = :EMPEST                                             ';
  Result := Result + '   AND LOT_CODITE = :CODITE                                             ';

  If strLotOri <> '' Then
  Begin
    Result := Result + '   AND LOT_NUMLOT = :NUMLOT                                        ';
  End
  Else
  begin
    Result := Result + '   AND LOT_NUMLOT <> "A DEFINIR"                                        ';
    Result := Result + '   AND LOT_NUMLOT <> "GARANTIA"                                         ';

    if FblnPickin then
      Result := Result + '   AND LOC_PICKIN = "N"                                              ';

    Result := Result + '   AND IFNULL(LOC_CRITIC,"N") = "N"                                     ';
    Result := Result + '   AND IFNULL(LOC_TRANSI,"N") = "N"                                     ';
    Result := Result + '   AND IFNULL(LOC_BALCAO,"N") = "N"                                     ';
    Result := Result + '   AND LOT_STATUS = "S"                                                 ';
    Result := Result + '   AND LOT_LOTAPR = "S"                                                 ';
    Result := Result + '   AND LOT_PRITIN <> "S"                                                ';
    Result := Result + '   AND LOT_SALDOS > 0                                                   ';
    Result := Result + '   AND IFNULL(LOT_TRANSI, "N") = "N"                                    ';
  End;

end;

procedure TMovimentacaoProgramada.pCalculaSaldoDisponivelPulmoes(DataSet : TDataSet);
  Var
    fltQtdBuffer: Double;
Begin
  Try
    DataSet.Filtered := False;
    DataSet.Filter   := '';

    DataSet.DisableControls;
    DataSet.First;
    While Not DataSet.Eof Do
    Begin
      DataSet.Edit;

      fltQtdBuffer := 0;

      If (Not fCfgSis('WMSPIC', varBoolean)) And
         (Not fEhLocalizacaoFisicaPicking(DataSet.FieldByName('LOT_LOCFIS').AsString)) Then
        fltQtdBuffer := fGetQtdLotdorItem(DataSet.FieldByName('LOT_CODITE').AsString, DataSet.FieldByName('LOT_NUMLOT').AsString);

      DataSet.FieldByName('QTDDIS').AsFloat :=
        fFormataFloat(fRetornaSaldoDisponivel(DataSet.FieldByName('LOT_CODITE').AsString, False, True, DataSet.FieldByName('LOT_NUMLOT').AsString, True, '', '', False, True, True, False, False, False, '', '', True) -
                      fQuantidadeMovimentacaoLote(DataSet.FieldByName('LOT_CODITE').AsString, DataSet.FieldByName('LOT_NUMLOT').AsString, tmSaida) -
                      fltQtdBuffer, 4);
      DataSet.Post;

      DataSet.Next;
    End;

    DataSet.Filtered := False;
    DataSet.Filter   := 'QTDDIS > 0';
    DataSet.Filtered := True;

  Finally
    DataSet.First;
    DataSet.EnableControls;
  End;

End;

function TMovimentacaoProgramada.fGetSQLLotesPulmao(enuOrdenacao : TSelecaoLocalizacao; strLotOri: String = '') : String;
Begin
  Result := '';
  Result := Result + ' SELECT C.*, 0.0000 AS QTDDIS                       ';
  Result := Result + ' FROM                                               ';
  Result := Result + '   CADLOT C                                         ';
  Result := Result + '   INNER JOIN CADLOC ON     LOC_CODLOC = LOT_LOCFIS ';
  Result := Result + '                        AND LOC_CODEMP = LOT_CODEMP ';
  Result := Result + fGetWherePulmoesDisponiveis(strLotOri);

  If not FblnControlaValidade Then
  begin
    case enuOrdenacao of
      tssMaior : Result := Result + '   AND LOC_CODLOC > :LOCFIS ';
      tssMenor : Result := Result + '   AND LOC_CODLOC < :LOCFIS ';
    end;
  end;

  If FblnControlaValidade Then
    Result := Result + ' ORDER BY LOT_DTAVAL, LOC_CODLOC '
  else
    Result := Result + ' ORDER BY LOC_CODLOC, LOT_DTAVAL ';

End;

procedure TMovimentacaoProgramada.pGetInformarcoesPulmao(strCodIte, strNumLotMovimentacao : String; var recInformacoesLote, recInformacoesPulmoes : TInformacoesMovimentacao; strLotOri: String = '');
var
  qryPulmoes : TUniQuery;
  recInformacoes : TInformacoesMovimentacao;
begin
  pZeraInformacoesMovimentacao(recInformacoesLote);
  pZeraInformacoesMovimentacao(recInformacoesPulmoes);

  qryPulmoes := fCriaQuery(nil);
  try
    qryPulmoes.SQL.Add('SELECT                                             ');
    qryPulmoes.SQL.Add('  LOT_NUMLOT,                                      ');
    qryPulmoes.SQL.Add('  LOT_SALDOS                                       ');
    qryPulmoes.SQL.Add('FROM                                               ');
    qryPulmoes.SQL.Add('  CADLOT                                           ');
    qryPulmoes.SQL.Add('  INNER JOIN CADLOC ON     LOC_CODLOC = LOT_LOCFIS ');
    qryPulmoes.SQL.Add('                       AND LOC_CODEMP = LOT_CODEMP ');
    qryPulmoes.SQL.Add(fGetWherePulmoesDisponiveis(strLotOri)                          );
    If strLotOri <> '' Then
      qryPulmoes.ParamByName('NUMLOT').AsString := strLotOri;

    qryPulmoes.ParamByName('EMPEST').AsString := VS_strCodEmp;
    qryPulmoes.ParamByName('CODITE').AsString := strCodIte;
    qryPulmoes.Open;
    qryPulmoes.first;

    while not qryPulmoes.eof do
    begin
      fSaldoFuturoLote(strCodIte, qryPulmoes.fieldByName('LOT_NUMLOT').AsString, recInformacoes);
      if qryPulmoes.fieldByName('LOT_NUMLOT').AsString = strNumLotMovimentacao then
      begin
        recInformacoesLote.fltSaldos := qryPulmoes.fieldByName('LOT_SALDOS').AsFloat;
        recInformacoesLote.fltSalDis := recInformacoes.fltSalDis;
        recInformacoesLote.fltMovEnt := recInformacoes.fltMovEnt;
        recInformacoesLote.fltMovSai := recInformacoes.fltMovSai;
      end;

      recInformacoesPulmoes.fltSaldos := recInformacoesPulmoes.fltSaldos + qryPulmoes.fieldByName('LOT_SALDOS').AsFloat;
      recInformacoesPulmoes.fltSalDis := recInformacoesPulmoes.fltSalDis + recInformacoes.fltSalDis;
      recInformacoesPulmoes.fltMovEnt := recInformacoesPulmoes.fltMovEnt + recInformacoes.fltMovEnt;
      recInformacoesPulmoes.fltMovSai := recInformacoesPulmoes.fltMovSai + recInformacoes.fltMovSai;

      qryPulmoes.Next;
    end;

  finally
    FreeAndNil(qryPulmoes);
  end;
end;

procedure TMovimentacaoProgramada.pLimpar;
begin
  FstlTemMovimentoProgramadoEmAberto.Clear;
end;

procedure TMovimentacaoProgramada.pSetImpressaoDaSeparacao(AValue: Boolean);
begin
  FImpressaoDaSeparacao := AValue;
end;

procedure TMovimentacaoProgramada.pSetQuantidadeDisponivel(AQuantidadeDisponivel: Double);
begin
  FQuantidadeDisponivel := (FQuantidadeDisponivel + AQuantidadeDisponivel);
end;

function TMovimentacaoProgramada.fGeraMovimentacaoProgramada(strCodIte,
                                                             strCodLoc : String;
                                                             fltQuantidadeSolicitada  : real;
                                                             blnAtivarAposConfirmacao : boolean;
                                                             recInformacoesPicking    : TInformacoesMovimentacao;
                                                             fltQtdIte : double = 0;
                                                             strOpeDes : String = '';
                                                             strLotOri : String = '';
                                                             blnConfirmacaoPainel : Boolean = False;
                                                             blnManual : Boolean = False): boolean;

  const
    MSG_ATENDEU_PARCIAL = 'Atenção!' + #13 + 'Não foi possível atender a capacidade máxima do picking do produto ([CODITE]). Portanto, o picking não ficará cheio.';

  var
    qryInsert : TUniQuery;
    cdsPulmao : TZClient;
    strNewLot : String;

  procedure pCriaeIncluiNovoLote;
    Var
      qryCadLot : TUniQuery;
      strAutInc : String;
      strLocFis : String;
  Begin
    Try
      qryCadLot := fCriaQuery;
      With qryCadLot, SQL Do
      Begin
        strLocFis := strCodLoc;

        If (not fEmptyStr(strCodIte)) and fEmptyStr(strLocFis) Then
        Begin
          //Pega a localizaçao do ultimo lote pickin cadastrado.
          Close;
          Clear;
          Add(' SELECT LOT_LOCFIS                              ');
          Add(' FROM CADLOT                                    ');
          Add('   INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ');
          Add('                    AND LOC_CODEMP = LOT_CODEMP ');
          Add(' WHERE LOT_CODEMP = :EMPEST                     ');
          Add('   AND LOT_CODITE = :CODITE                     ');
          Add('   AND LOC_PICKIN = "S"                         ');
          Add('   AND IFNULL(LOC_CRITIC,"N") = "N"             ');
          Add('   AND IFNULL(LOC_TRANSI,"N") = "N"             ');
          Add('   AND IFNULL(LOC_BALCAO,"N") = "N"             ');
          Add('   AND IFNULL(LOT_TRANSI,"N") = "N"             ');
          Add(' ORDER BY CADLOT.AUTOINCREM DESC                ');
          Add(' LIMIT 1                                        ');

          ParamByName('EMPEST').AsString := VS_strCodemp;
          ParamByName('CODITE').AsString := strCodIte;

          Open;

          strLocFis := FieldByName('LOT_LOCFIS').AsString;

          If fEmptyStr(strLocFis) Then
          Begin
            Raise ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada.Create('Não foi possível incluir um novo lote picking para o produto(' + strCodIte + '). '+
                                   'Cadastre o picking para criar uma movimentação programada!');
          End;
        End;

        Close;
        Clear;

        Add(' SELECT LOT_STATUS,         ');
        Add('        LOT_DIGCON,         ');
        Add('        LOT_NUMLOT,         ');
        Add('        AUTOINCREM          ');
        Add(' FROM CADLOT                ');
        Add(' WHERE LOT_CODEMP = :EMPEST ');
        Add('   AND LOT_CODITE = :CODITE ');
      Add('   AND LOT_LOCFIS = :LOCFIS ');

      If FblnControlaValidade and (not fCfgSis('LOTPIC', varBoolean)) Then
        Add(' AND LOT_DTAVAL = :DTAVAL ');

      Add(' ORDER BY LOT_STATUS DESC   ');

      ParamByName('EMPEST').AsString   := VS_strCodEmp;
        ParamByName('CODITE').AsString   := cdsPulmao.FieldByName('LOT_CODITE').AsString;
        ParamByName('LOCFIS').AsString   := strLocFis;

        If FblnControlaValidade and (not fCfgSis('LOTPIC', varBoolean))Then
          ParamByName('DTAVAL').AsDateTime := cdsPulmao.FieldByName('LOT_DTAVAL').AsDateTime;

        Open;

        If not IsEmpty Then
        Begin
          If (FieldByName('LOT_DIGCON').AsString = 'S') Then
            Raise ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada.Create('Os Lotes do Picking (' + strLocFis + ') estão em contagem, não foi possível incluir a movimentação programada!');

          If (FieldByName('LOT_STATUS').AsString = 'B') Then
            Raise ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada.Create('Os Lotes do Picking ('+ strLocFis + ') estão bloqueados, não foi possível incluir a movimentação programada!')
          Else If (FieldByName('LOT_STATUS').AsString = 'N') Then
          Begin
            strAutInc := FieldByName('AUTOINCREM').AsString;
            strNewLot := FieldByName('LOT_NUMLOT').AsString;

            Close;
            Clear;
            Add(' UPDATE CADLOT SET LOT_STATUS = "S" WHERE AUTOINCREM = :AUTINC ');
            ParamByName('AUTINC').AsString := strAutInc;
            ExecSQL;
          End
          Else
          Begin
            strAutInc := FieldByName('AUTOINCREM').AsString;
            strNewLot := FieldByName('LOT_NUMLOT').AsString;
          End;
        End
        Else
        Begin
          Close;
          Clear;
          Add(' INSERT INTO CADLOT(AUTOINCREM, ');
          Add('                    LOT_NUMLOT, ');
          Add('                    LOT_CODEMP, ');
          Add('                    LOT_CODITE, ');
          Add('                    LOT_DTAFAB, ');
          Add('                    LOT_DTAVAL, ');
          Add('                    LOT_DTABAL, ');
          Add('                    LOT_SALBAL, ');
          Add('                    LOT_SALDOS, ');
          Add('                    LOT_LOCFIS, ');
          Add('                    LOT_STATUS) ');
          Add('            VALUES (:AUTINC,    ');
          Add('                    :NUMLOT,    ');
          Add('                    :CODEMP,    ');
          Add('                    :CODITE,    ');
          Add('                    :DTAFAB,    ');
          Add('                    :DTAVAL,    ');
          Add('                    :DTABAL,    ');
          Add('                    :SALBAL,    ');
          Add('                    :SALDOS,    ');
          Add('                    :LOCFIS,    ');
          Add('                    :STATUS)    ');

          strAutInc := fRetAutoIncrem('CADLOT', VS_strCodEmp);
          if FdtaDatVen <> 0 then
            strNewLot := TfrmCadLoteItens.fGetNumeroLoteInclusaoRapidaWMS(DateToStr(FdtaDatVen), cdsPulmao.FieldByName('LOT_CODITE').AsString)
          else
            strNewLot := TfrmCadLoteItens.fGetNumeroLoteInclusaoRapidaWMS( cdsPulmao.FieldByName('LOT_DTAVAL').AsString, cdsPulmao.FieldByName('LOT_CODITE').AsString);
          ParamByName('AUTINC').AsString   := strAutInc;
          ParamByName('NUMLOT').AsString   := strNewLot;
          ParamByName('CODEMP').AsString   := cdsPulmao.FieldByName('LOT_CODEMP').AsString;
          ParamByName('CODITE').AsString   := cdsPulmao.FieldByName('LOT_CODITE').AsString;
          ParamByName('DTAFAB').AsDateTime := cdsPulmao.FieldByName('LOT_DTAFAB').AsDateTime;
          ParamByName('DTAVAL').AsDateTime := cdsPulmao.FieldByName('LOT_DTAVAL').AsDateTime;
          ParamByName('DTABAL').AsDateTime := fNow - 1;
          ParamByName('SALBAL').AsFloat    := 0.00;
          ParamByName('SALDOS').AsFloat    := 0.00;
          ParamByName('LOCFIS').AsString   := strLocFis;
          ParamByName('STATUS').AsString   := 'S';

          ExecSQL;
        End;

        Close;
        Clear;
        Add(' SELECT *, 0 AS SALDIS FROM CADLOT WHERE AUTOINCREM = :AUTINC ');
        ParamByName('AUTINC').AsString := strAutInc;
        Open;

        Close;

      End;

    Finally
      FreeAndNil(qryCadLot);
    End;

  End;

  procedure pInserirMovLot;
  var
    recInformacoesLoteOrigem, recInformacoesPulmoes : TInformacoesMovimentacao;
  Begin
    try
      pCriaeIncluiNovoLote;

      pGetInformarcoesPulmao(strCodIte, cdsPulmao.FieldByName('LOT_NUMLOT').AsString, recInformacoesLoteOrigem, recInformacoesPulmoes, strLotOri);

      qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVLOT', VS_strCodEmp);
      qryInsert.ParamByName('CODITE').AsString := strCodIte;
      qryInsert.ParamByName('LOTDES').AsString := strNewLot;
      qryInsert.ParamByName('LOTORI').AsString := strLotOri;
      If strLotOri = '' Then
        qryInsert.ParamByName('LOTORI').AsString := cdsPulmao.FieldByName('LOT_NUMLOT').AsString;
      qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryInsert.ParamByName('SEQFGO').AsString := FstrSeqGor;
      qryInsert.ParamByName('CODOPE').AsString := FstrCodOpe;

      if fEmptyStr(strOpeDes) then
        qryInsert.ParamByName('OPEDES').Clear
      else
        qryInsert.ParamByName('OPEDES').AsString := strOpeDes;

      qryInsert.ParamByName('DTACAD').AsDateTime := fNow;
      qryInsert.ParamByName('ATIVO_').AsString := IIF(blnAtivarAposConfirmacao, 'N', 'S');
      qryInsert.ParamByName('DTAREA').Clear;
      qryInsert.ParamByName('HRAREA').Clear;
      qryInsert.ParamByName('OPEREA').Clear;
      //Veio da tela e ja definiu por la se tinha saldo
      If strLotOri <> '' Then
      Begin
        qryInsert.ParamByName('QTDMOV').AsFloat := fltQuantidadeSolicitada;
      End
      Else
      begin
        if fltQuantidadeSolicitada = 0 then
          qryInsert.ParamByName('QTDMOV').AsFloat := 0
        else
        begin
          if cdsPulmao.fieldByName('QTDDIS').AsFloat <= fltQuantidadeSolicitada then
            qryInsert.ParamByName('QTDMOV').AsFloat := cdsPulmao.fieldByName('QTDDIS').AsFloat
          else
            qryInsert.ParamByName('QTDMOV').AsFloat := fltQuantidadeSolicitada;
        end;
      End;

      If Not fValidaQtdDisponivelLotesMovAbertas(qryInsert.ParamByName('QTDMOV').AsFloat, qryInsert.ParamByName('LOTORI').AsString, strCodIte) Then
        Exit;

      pSetQuantidadeDisponivel(qryInsert.ParamByName('QTDMOV').AsFloat);

      qryInsert.ParamByName('PONREP').AsFloat  := recInformacoesPicking.fltQtdRep;
      qryInsert.ParamByName('QTDMAX').AsFloat  := recInformacoesPicking.fltQtdMax;
      qryInsert.ParamByName('SALDES').AsFloat  := recInformacoesPicking.fltSaldos;
      qryInsert.ParamByName('DISDES').AsFloat  := recInformacoesPicking.fltSalDis;
      qryInsert.ParamByName('SALORI').AsFloat  := recInformacoesLoteOrigem.fltSaldos;
      qryInsert.ParamByName('DISORI').AsFloat  := recInformacoesLoteOrigem.fltSalDis;
      qryInsert.ParamByName('SALPUL').AsFloat  := recInformacoesPulmoes.fltSaldos;
      qryInsert.ParamByName('DISPUL').AsFloat  := recInformacoesPulmoes.fltSalDis;
      qryInsert.ParamByName('MOVDES').AsFloat  := recInformacoesPicking.fltMovEnt;
      qryInsert.ParamByName('MOVORI').AsFloat  := recInformacoesLoteOrigem.fltMovSai;
      qryInsert.ParamByName('MOVPUL').AsFloat  := recInformacoesPulmoes.fltMovSai;
      qryInsert.ParamByName('QTDPEN').AsFloat  := fltQtdIte;

      qryInsert.ExecSQL;
    except
      on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
        raise;

      on E: Exception do
        raise ExceptionAutComErroAoIncluirMovimentacaoProgramada.Create(E.Message);
    end;
  End;

Begin
  Result := False;
  qryInsert := fCriaQuery;
  Try
    try
      With qryInsert, SQL Do
      Begin
        Close;
        Clear;
        Add(' INSERT INTO MOVLOT (                                               ');
        Add('             AUTOINCREM,                                            ');
        Add('             MLT_CODITE,                                            ');
        Add('             MLT_LOTORI,                                            ');
        Add('             MLT_LOTDES,                                            ');
        Add('             MLT_DTAREA,                                            ');
        Add('             MLT_HRAREA,                                            ');
        Add('             MLT_OPEREA,                                            ');
        Add('             MLT_CODEMP,                                            ');
        Add('             MLT_QTDMOV,                                            ');
        Add('             MLT_SEQFGO,                                            ');
        Add('             MLT_CODOPE,                                            ');
        Add('             MLT_DTACAD,                                            ');
        Add('             MLT_ATIVO_,                                            ');
        Add('             MLT_PONREP,                                            ');
        Add('             MLT_QTDMAX,                                            ');
        Add('             MLT_SALDES,                                            ');
        Add('             MLT_DISDES,                                            ');
        Add('             MLT_SALORI,                                            ');
        Add('             MLT_DISORI,                                            ');
        Add('             MLT_SALPUL,                                            ');
        Add('             MLT_DISPUL,                                            ');
        Add('             MLT_MOVDES,                                            ');
        Add('             MLT_MOVORI,                                            ');
        Add('             MLT_MOVPUL,                                            ');
        Add('             MLT_QTDPEN,                                            ');
        Add('             MLT_OPEDES,                                            ');
        Add('             MLT_LOTDOR)                                            ');
        Add(' VALUES (    :AUTINC,                                               ');
        Add('             :CODITE,                                               ');
        Add('             :LOTORI,                                               ');
        Add('             :LOTDES,                                               ');
        Add('             :DTAREA,                                               ');
        Add('             :HRAREA,                                               ');
        Add('             :OPEREA,                                               ');
        Add('             :CODEMP,                                               ');
        Add('             :QTDMOV,                                               ');
        Add('             :SEQFGO,                                               ');
        Add('             :CODOPE,                                               ');
        Add('             :DTACAD,                                               ');
        Add('             :ATIVO_,                                               ');
        Add('             :PONREP,                                               ');
        Add('             :QTDMAX,                                               ');
        Add('             :SALDES,                                               ');
        Add('             :DISDES,                                               ');
        Add('             :SALORI,                                               ');
        Add('             :DISORI,                                               ');
        Add('             :SALPUL,                                               ');
        Add('             :DISPUL,                                               ');
        Add('             :MOVDES,                                               ');
        Add('             :MOVORI,                                               ');
        Add('             :MOVPUL,                                               ');
        Add('             :QTDPEN,                                               ');
        Add('             :OPEDES,                                               ');
        Add('             (SELECT                                                ');
        Add('                GROUP_CONCAT(LDO_NUMLOT)                            ');
        Add('              FROM                                                  ');
        Add('                LOTDOR                                              ');
        Add('                INNER JOIN FATDOR F ON  F.AUTOINCREM = LDO_SEQFDO   ');
        Add('                INNER JOIN CADLOT   ON  LOT_NUMLOT   = LDO_NUMLOT   ');
        Add('                                    AND LOT_CODEMP   = :CODEMP      ');
        Add('                                    AND LOT_CODITE   = FDO_CODITE   ');
        Add('                INNER JOIN CADLOC   ON  LOC_CODLOC   = LOT_LOCFIS   ');
        Add('              										   AND LOC_CODEMP   = LOT_CODEMP   ');
        Add('              WHERE FDO_CODEMP = :CODEMP                            ');
        Add('                AND FDO_CODITE = :CODITE                            ');
        Add('                AND LOC_PICKIN = "N"))                              ');
      End;


      strNewLot := '';
      cdsPulmao := TZClient.Create(Nil);
      With cdsPulmao.qryQuery, SQL Do
      Begin
        Close;
        Clear;

        if FblnControlaValidade then
          Add(fGetSQLLotesPulmao(tssNull , IIf(blnConfirmacaoPainel or blnManual, strLotOri, '')))
        else
          Add(fGetSQLLotesPulmao(tssMaior, IIf(blnConfirmacaoPainel or blnManual, strLotOri, '')));

        ParamByName('EMPEST').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        If (blnConfirmacaoPainel or blnManual) and (strLotOri <> '')  Then
          ParamByName('NUMLOT').AsString := strLotOri;


        If (not FblnControlaValidade) and (Params.FindParam('LOCFIS') <> Nil) Then
          ParamByName('LOCFIS').AsString := strCodLoc;

        cdsPulmao.fAbreClient(True, 'TMovimentacaoProgramada.fGeraMovimentacaoProgramada');

        pCalculaSaldoDisponivelPulmoes(cdsPulmao);

        If Not cdsPulmao.IsEmpty Then
        Begin
          pInserirMovLot;
          Result := true;
        End
        Else If not FblnControlaValidade Then
        Begin
          Close;
          Clear;
          Add(fGetSQLLotesPulmao(tssMenor, ''));

          ParamByName('EMPEST').AsString := VS_strCodEmp;
          ParamByName('CODITE').AsString := strCodIte;

          If (Params.FindParam('LOCFIS') <> Nil) Then
            ParamByName('LOCFIS').AsString := strCodLoc;

          cdsPulmao.fAbreClient(True, 'TMovimentacaoProgramada.fGeraMovimentacaoProgramada');

          pCalculaSaldoDisponivelPulmoes(cdsPulmao);

          If Not cdsPulmao.IsEmpty Then
          Begin
            pInserirMovLot;
            Result := True;
          End;
        End
        Else
        Begin
          If (FQuantidadeDisponivel > 0) And (FImpressaoDaSeparacao) Then
            raise ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente.Create(MSG_ATENDEU_PARCIAL.Replace('[CODITE]', strCodIte));
        End;
      End;
    except
      on E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente Do
        Raise;

      on E: ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada do
        raise;

      on E: ExceptionAutComErroAoIncluirMovimentacaoProgramada do
        raise;

      on E: Exception do
        raise;
    end;
  Finally
    FreeAndNil(qryInsert);
    if Assigned(cdsPulmao) Then
      FreeAndNil(cdsPulmao);
  End;
End;

{ TMovimentacaoProgramadaPedido }

constructor TMovimentacaoProgramadaPedido.Create(AKey: String; AImpressaoDaSeparacao: Boolean = False);
begin
  inherited;
  FstrSeqGor := AKey;
end;

procedure TMovimentacaoProgramadaPedido.pIniciaQryItens(var qryItens : TUniQuery);
var
  LSubtrairLotDor: Boolean;
begin
  LSubtrairLotDor := FImpressaoDaSeparacao and (not fCfgSis('WMSPIC', varBoolean));

  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add(' SELECT                                        ');
  qryItens.SQL.Add('   ITE_CODITE,                                 ');
  qryItens.SQL.Add('   SUM(FDO_QTDITE) - ' + IIF(LSubtrairLotDor, 'SUM(IFNULL(LDO_QTDITE, 0))', '0') + ' AS QTDPED,                    ');
  qryItens.SQL.Add('   FDO_IDEPRO      AS IDEPRO,                  ');
  qryItens.SQL.Add('   FDO_PROACA      AS PROACA                   ');
  qryItens.SQL.Add(' FROM FATDOR                                   ');
  qryItens.SQL.Add(' INNER JOIN ITEGER ON ITE_CODEMP = :EMPEST     ');
  qryItens.SQL.Add('                  AND ITE_CODITE = FDO_CODITE  ');

  if LSubtrairLotDor then
    qryItens.SQL.Add(' LEFT JOIN LOTDOR ON FATDOR.AUTOINCREM = LDO_SEQFDO ');

  qryItens.SQL.Add(' WHERE FDO_SEQGER = :SEQGOR                    ');
  qryItens.SQL.Add(' GROUP BY ITE_CODITE                           ');
  qryItens.SQL.Add(' HAVING QTDPED > 0                             ');

  qryItens.ParamByName('SEQGOR').AsString := FstrSeqGor;
  qryItens.ParamByName('EMPEST').AsString := VS_strCodEmp;
end;

{ TMovimentacaoProgramadaRomaneio }

constructor TMovimentacaoProgramadaRomaneio.Create(AKey: string; AImpressaoDaSeparacao: Boolean = False);
begin
  inherited;
  FstrNumRom := AKey;
end;

procedure TMovimentacaoProgramadaRomaneio.pIniciaQryItens(
  var qryItens: TUniQuery);
begin
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add(' SELECT DISTINCT                                 ');
  qryItens.SQL.Add('   ITE_CODITE                                    ');
  qryItens.SQL.Add(' FROM                                            ');
  qryItens.SQL.Add('   ROMGERX                                       ');
  qryItens.SQL.Add('   INNER JOIN FATDOR ON FDO_NUMDOC = GER_NUMDOC  ');
  qryItens.SQL.Add('                    AND FDO_ESPDOC = GER_ESPDOC  ');
  qryItens.SQL.Add('                    AND FDO_CODEMP = GER_CODEMP  ');
  qryItens.SQL.Add('                    AND FDO_CODCLI = GER_CODCLI  ');
  qryItens.SQL.Add('   INNER JOIN ITEGER ON ITE_CODEMP = :EMPEST     ');
  qryItens.SQL.Add('                    AND ITE_CODITE = FDO_CODITE  ');
  qryItens.SQL.Add(' WHERE                                           ');
  qryItens.SQL.Add('       GER_NUMROM = :NUMROM                      ');
  qryItens.SQL.Add('   AND GER_EMPROM = :EMPEST                      ');

  qryItens.ParamByName('NUMROM').AsString := FstrNumRom;
  qryItens.ParamByName('EMPEST').AsString := VS_strCodEmp;

end;

function TMovimentacaoProgramada.fOperador(
  strCodOpe: String): TMovimentacaoProgramada;
begin
  Result := self;
  FstrCodOpe := strCodOpe;
end;

function TMovimentacaoProgramada.fPickin(
  blnPickin: Boolean): TMovimentacaoProgramada;
begin
  Result := Self;
  FblnPickin := blnPickin;
end;


{ TMovimentacaoProgramadaManual }

constructor TMovimentacaoProgramadaManual.Create(AKey: string; AImpressaoDaSeparacao: Boolean = False);
begin
  inherited;
  FstrNumRom := AKey;
end;

procedure TMovimentacaoProgramadaManual.pIniciaQryItens(
  var qryItens: TUniQuery);
begin

end;

{ TMovimentacaoProgramadaCaixa }

constructor TMovimentacaoProgramadaCaixa.Create(AKey: string; AImpressaoDaSeparacao: Boolean = False);
begin
  inherited;
  FstrSeqGor := AKey;
  FEhCaixa   := True;
end;

destructor TMovimentacaoProgramadaCaixa.Destroy;
begin
  inherited;
  If Assigned(FItensCaixa) Then
    FreeAndNil(FItensCaixa);
end;

procedure TMovimentacaoProgramadaCaixa.pIniciaQryItens(var qryItens: TUniQuery);
  var
    LItens : TStringList;
begin

  LItens := TStringList.Create;

  Try

    FItensCaixa.First;
    While Not FItensCaixa.Eof Do
    Begin
      LItens.Add(QuotedStr(FItensCaixa.FieldByName('ITE_CODITE').AsString));
      FItensCaixa.Next;
    End;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.SQL.Add(' SELECT DISTINCT  ');
    qryItens.SQL.Add('   ITE_CODITE     ');
    qryItens.SQL.Add(' FROM             ');
    qryItens.SQL.Add('   CADITE         ');
    qryItens.SQL.Add(' WHERE            ');
    qryItens.SQL.Add('  ITE_CODITE IN ( ' + LItens.CommaText + ')');

  Finally
    FreeAndNil(LItens);
  End;

end;

procedure TMovimentacaoProgramadaCaixa.pSetItensCaixa(const AItensCaixa: TUniClientDataSet);
begin

  If Not Assigned(FItensCaixa) Then
    FItensCaixa := TUniClientDataSet.Create(Nil);

  pCloneDataSet(FItensCaixa, AItensCaixa);

end;


Procedure TMovimentacaoProgramada.pGravarMovLotAbastPicking(AQryInsert: TUniQuery; AStrCodIte, AStrLotOri, AStrLocOri, AStrLocDes, AStrCodOpeDest: String; AFltQtdTransf: Double; ADtaDtaVal: TDateTime);
var
  StrLotDes: String;
  recInformacoesLoteOrigem,
  recInformacoesPicking,
  recInformacoesPulmoes : TInformacoesMovimentacao;
Begin
  pCriaeIncluiNovoLoteAbastPrev(StrLotDes, AstrLocDes, AStrCodIte, AStrLocOri, ADtaDtaVal);

  pGetInformarcoesPulmao(AstrCodIte, AStrLotOri, recInformacoesLoteOrigem, recInformacoesPulmoes);

  fVerificaNecessidaDeAbastecimento(AStrCodIte, recInformacoesPicking);

  If Not fValidaQtdDisponivelLotesMovAbertas(AFltQtdTransf, AStrLotOri, AStrCodIte) Then
    Exit;

  AQryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVLOT', VS_strCodEmp);
  AQryInsert.ParamByName('CODITE').AsString := AStrCodIte;
  AQryInsert.ParamByName('LOTDES').AsString := StrLotDes;
  AQryInsert.ParamByName('LOTORI').AsString := AStrLotOri;
  AQryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
  AQryInsert.ParamByName('SEQFGO').Clear;
  AQryInsert.ParamByName('CODOPE').AsString := FstrCodOpe;

  if (not fEmptyStr(AStrCodOpeDest)) then
    AQryInsert.ParamByName('OPEDES').AsString := AStrCodOpeDest;

  AQryInsert.ParamByName('DTACAD').AsDateTime := fNow;
  AQryInsert.ParamByName('ATIVO_').AsString := 'S';
  AQryInsert.ParamByName('DTAREA').Clear;
  AQryInsert.ParamByName('HRAREA').Clear;
  AQryInsert.ParamByName('OPEREA').Clear;
  AQryInsert.ParamByName('QTDMOV').AsFloat := AFltQtdTransf;
  AQryInsert.ParamByName('PONREP').AsFloat  := recInformacoesPicking.fltQtdRep;
  AQryInsert.ParamByName('QTDMAX').AsFloat  := recInformacoesPicking.fltQtdMax;
  AQryInsert.ParamByName('SALDES').AsFloat  := recInformacoesPicking.fltSaldos;
  AQryInsert.ParamByName('DISDES').AsFloat  := recInformacoesPicking.fltSalDis;
  AQryInsert.ParamByName('SALORI').AsFloat  := recInformacoesLoteOrigem.fltSaldos;
  AQryInsert.ParamByName('DISORI').AsFloat  := recInformacoesLoteOrigem.fltSalDis;
  AQryInsert.ParamByName('SALPUL').AsFloat  := recInformacoesPulmoes.fltSaldos;
  AQryInsert.ParamByName('DISPUL').AsFloat  := recInformacoesPulmoes.fltSalDis;
  AQryInsert.ParamByName('MOVDES').AsFloat  := recInformacoesPicking.fltMovEnt;
  AQryInsert.ParamByName('MOVORI').AsFloat  := recInformacoesLoteOrigem.fltMovSai;
  AQryInsert.ParamByName('MOVPUL').AsFloat  := recInformacoesPulmoes.fltMovSai;
  AQryInsert.ParamByName('QTDPEN').Clear;

  AqryInsert.ExecSQL;
End;

Function TMovimentacaoProgramada.fCriaQueryInsertMovLot: TUniQuery;
Begin
  Result := fCriaQuery;
  Result.SQL.Clear;
  Result.SQL. Add(' INSERT INTO MOVLOT (        ');
  Result.SQL. Add('             AUTOINCREM,     ');
  Result.SQL. Add('             MLT_CODITE,     ');
  Result.SQL. Add('             MLT_LOTORI,     ');
  Result.SQL. Add('             MLT_LOTDES,     ');
  Result.SQL. Add('             MLT_DTAREA,     ');
  Result.SQL. Add('             MLT_HRAREA,     ');
  Result.SQL. Add('             MLT_OPEREA,     ');
  Result.SQL. Add('             MLT_CODEMP,     ');
  Result.SQL. Add('             MLT_QTDMOV,     ');
  Result.SQL. Add('             MLT_SEQFGO,     ');
  Result.SQL. Add('             MLT_CODOPE,     ');
  Result.SQL. Add('             MLT_DTACAD,     ');
  Result.SQL. Add('             MLT_ATIVO_,     ');
  Result.SQL. Add('             MLT_PONREP,     ');
  Result.SQL. Add('             MLT_QTDMAX,     ');
  Result.SQL. Add('             MLT_SALDES,     ');
  Result.SQL. Add('             MLT_DISDES,     ');
  Result.SQL. Add('             MLT_SALORI,     ');
  Result.SQL. Add('             MLT_DISORI,     ');
  Result.SQL. Add('             MLT_SALPUL,     ');
  Result.SQL. Add('             MLT_DISPUL,     ');
  Result.SQL. Add('             MLT_MOVDES,     ');
  Result.SQL. Add('             MLT_MOVORI,     ');
  Result.SQL. Add('             MLT_MOVPUL,     ');
  Result.SQL. Add('             MLT_QTDPEN,     ');
  Result.SQL. Add('             MLT_OPEDES,     ');
  Result.SQL. Add('             MLT_LOTDOR)     ');
  Result.SQL. Add(' VALUES (    :AUTINC,        ');
  Result.SQL. Add('             :CODITE,        ');
  Result.SQL. Add('             :LOTORI,        ');
  Result.SQL. Add('             :LOTDES,        ');
  Result.SQL. Add('             :DTAREA,        ');
  Result.SQL. Add('             :HRAREA,        ');
  Result.SQL. Add('             :OPEREA,        ');
  Result.SQL. Add('             :CODEMP,        ');
  Result.SQL. Add('             :QTDMOV,        ');
  Result.SQL. Add('             :SEQFGO,        ');
  Result.SQL. Add('             :CODOPE,        ');
  Result.SQL. Add('             :DTACAD,        ');
  Result.SQL. Add('             :ATIVO_,        ');
  Result.SQL. Add('             :PONREP,        ');
  Result.SQL. Add('             :QTDMAX,        ');
  Result.SQL. Add('             :SALDES,        ');
  Result.SQL. Add('             :DISDES,        ');
  Result.SQL. Add('             :SALORI,        ');
  Result.SQL. Add('             :DISORI,        ');
  Result.SQL. Add('             :SALPUL,        ');
  Result.SQL. Add('             :DISPUL,        ');
  Result.SQL. Add('             :MOVDES,        ');
  Result.SQL. Add('             :MOVORI,        ');
  Result.SQL. Add('             :MOVPUL,        ');
  Result.SQL. Add('             :QTDPEN,        ');
  Result.SQL. Add('             :OPEDES,        ');
  Result.SQL. Add('             :LOTDOR)        ');
End;

procedure TMovimentacaoProgramada.pCriaeIncluiNovoLoteAbastPrev(var AStrNewLot: String;AStrCodLoc, AStrCodIte, AStrLocOri: String; ADtaDtaVal: TDateTime);
Var
  qryCadLot : TUniQuery;
  qryPulmao: TUniQuery;
  strAutInc : String;
  strLocFis : String;
Begin
  Try
    qryCadLot := fCriaQuery;
    qryPulmao := fCriaQuery;
    With qryCadLot, SQL Do
    Begin
      strLocFis := AstrCodLoc;

      If (not fEmptyStr(AstrCodIte)) and fEmptyStr(strLocFis) Then
      Begin
        //Pega a localizaçao do ultimo lote pickin cadastrado.
        Close;
        Clear;
        Add(' SELECT LOT_LOCFIS                              ');
        Add(' FROM CADLOT                                    ');
        Add('   INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ');
        Add('                    AND LOC_CODEMP = LOT_CODEMP ');
        Add(' WHERE LOT_CODEMP = :EMPEST                     ');
        Add('   AND LOT_CODITE = :CODITE                     ');
        Add('   AND LOC_PICKIN = "S"                         ');
        Add('   AND IFNULL(LOC_CRITIC,"N") = "N"             ');
        Add('   AND IFNULL(LOC_TRANSI,"N") = "N"             ');
        Add('   AND IFNULL(LOC_BALCAO,"N") = "N"             ');
        Add('   AND IFNULL(LOT_TRANSI,"N") = "N"             ');
        Add(' ORDER BY CADLOT.AUTOINCREM DESC                ');
        Add(' LIMIT 1                                        ');

        ParamByName('EMPEST').AsString := VS_strCodemp;
        ParamByName('CODITE').AsString := AstrCodIte;

        Open;

        strLocFis := FieldByName('LOT_LOCFIS').AsString;

        If fEmptyStr(strLocFis) Then
        Begin
          Raise ExceptionAutComNaoFoiPossivelIncluirMovimentacaoProgramada.Create('Não foi possível incluir um novo lote picking para o produto(' + AstrCodIte + '). '+
                                 'Cadastre o picking para criar uma movimentação programada!');
        End;
      End;

      Close;
      Clear;

      Add(' SELECT LOT_STATUS,         ');
      Add('        LOT_DIGCON,         ');
      Add('        LOT_NUMLOT,         ');
      Add('        AUTOINCREM          ');
      Add(' FROM CADLOT                ');
      Add(' WHERE LOT_CODEMP = :EMPEST ');
      Add('   AND LOT_CODITE = :CODITE ');
      Add('   AND LOT_LOCFIS = :LOCFIS ');

      If FblnControlaValidade and (not fCfgSis('LOTPIC', varBoolean)) Then
        Add(' AND LOT_DTAVAL = :DTAVAL ');

      Add(' ORDER BY LOT_STATUS DESC   ');

      ParamByName('EMPEST').AsString   := VS_strCodEmp;
      ParamByName('CODITE').AsString   := AStrCodIte;
      ParamByName('LOCFIS').AsString   := strLocFis;

      If FblnControlaValidade and (not fCfgSis('LOTPIC', varBoolean))Then
        ParamByName('DTAVAL').AsDateTime := ADtaDtaVal;

      Open;

      If not IsEmpty Then
      Begin
        strAutInc := FieldByName('AUTOINCREM').AsString;
        AstrNewLot := FieldByName('LOT_NUMLOT').AsString;
      End
      Else
      Begin

        qryPulmao.SQL.Clear;
        qryPulmao.SQL.Add(' SELECT LOT_DTAFAB, LOT_DTAVAL, LOT_CODEMP, LOT_CODITE ');
        qryPulmao.SQL.Add(' FROM CADLOT ');
        qryPulmao.SQL.Add(' WHERE LOT_LOCFIS = :LOCFIS AND ');
        qryPulmao.SQL.Add('       LOT_CODEMP = :CODEMP AND ');
        qryPulmao.SQL.Add('       LOT_CODITE = :CODITE');
        qryPulmao.ParamByname('LOCFIS').AsString := AStrLocOri;
        qryPulmao.ParamByname('CODEMP').AsString := VS_strCodEmp;
        qryPulmao.ParamByname('CODITE').AsString := AStrCodIte;

        qryPulmao.Open;

        Close;
        Clear;
        Add(' INSERT INTO CADLOT(AUTOINCREM, ');
        Add('                    LOT_NUMLOT, ');
        Add('                    LOT_CODEMP, ');
        Add('                    LOT_CODITE, ');
        Add('                    LOT_DTAFAB, ');
        Add('                    LOT_DTAVAL, ');
        Add('                    LOT_DTABAL, ');
        Add('                    LOT_SALBAL, ');
        Add('                    LOT_SALDOS, ');
        Add('                    LOT_LOCFIS, ');
        Add('                    LOT_STATUS) ');
        Add('            VALUES (:AUTINC,    ');
        Add('                    :NUMLOT,    ');
        Add('                    :CODEMP,    ');
        Add('                    :CODITE,    ');
        Add('                    :DTAFAB,    ');
        Add('                    :DTAVAL,    ');
        Add('                    :DTABAL,    ');
        Add('                    :SALBAL,    ');
        Add('                    :SALDOS,    ');
        Add('                    :LOCFIS,    ');
        Add('                    :STATUS)    ');

        strAutInc := fRetAutoIncrem('CADLOT', VS_strCodEmp);
        if FdtaDatVen <> 0 then
          AstrNewLot := TfrmCadLoteItens.fGetNumeroLoteInclusaoRapidaWMS(DateToStr(FdtaDatVen), qryPulmao.FieldByName('LOT_CODITE').AsString)
        else
          AstrNewLot := TfrmCadLoteItens.fGetNumeroLoteInclusaoRapidaWMS( DateToStr(qryPulmao.FieldByName('LOT_DTAVAL').AsDateTime), qryPulmao.FieldByName('LOT_CODITE').AsString);
        ParamByName('AUTINC').AsString   := strAutInc;
        ParamByName('NUMLOT').AsString   := AstrNewLot;
        ParamByName('CODEMP').AsString   := qryPulmao.FieldByName('LOT_CODEMP').AsString;
        ParamByName('CODITE').AsString   := qryPulmao.FieldByName('LOT_CODITE').AsString;
        ParamByName('DTAFAB').AsDateTime := qryPulmao.FieldByName('LOT_DTAFAB').AsDateTime;
        ParamByName('DTAVAL').AsDateTime := qryPulmao.FieldByName('LOT_DTAVAL').AsDateTime;
        ParamByName('DTABAL').AsDateTime := fNow - 1;
        ParamByName('SALBAL').AsFloat    := 0.00;
        ParamByName('SALDOS').AsFloat    := 0.00;
        ParamByName('LOCFIS').AsString   := strLocFis;
        ParamByName('STATUS').AsString   := 'S';

        ExecSQL;
      End;

      Close;
      Clear;
      Add(' SELECT *, 0 AS SALDIS FROM CADLOT WHERE AUTOINCREM = :AUTINC ');
      ParamByName('AUTINC').AsString := strAutInc;
      Open;

      Close;

    End;

  Finally
    FreeAndNil(qryCadLot);
    FreeAndNil(qryPulmao);
  End;

End;


function TMovimentacaoProgramada.fValidaQtdDisponivelLotesMovAbertas(AFltQtdAMovimentar: Double; AStrLotOri, AStrCodIte: String): Boolean;
var
  qryAux: TUniQuery;
  fltSalDis: Double;
begin
  qryAux := fCriaQuery;

  Try
    fltSalDis := fRetornaSaldoDisponivel(AStrCodIte, False, False, AStrLotOri, True, VS_StrCodemp);

    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT IFNULL(SUM(MLT_QTDMOV),0) AS QTD FROM MOVLOT ');
    qryAux.SQL.Add(' WHERE MLT_LOTORI = :LOTE_ORI ');
    qryAux.SQL.Add('   AND MLT_CODEMP = :CODEMP ');
    qryAux.SQL.Add('   AND MLT_CODITE = :CODITE ');
    qryAux.SQL.Add('   AND MLT_DTAREA IS NULL  ');
    qryAux.ParamByName('LOTE_ORI').AsString := AStrLotOri;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ParamByName('CODITE').AsString := AStrCodIte;
    qryAux.Open;

    Result := AFltQtdAMovimentar <= (fltSalDis - qryAux.FieldByName('QTD').AsFloat);
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure RealizarMovimentacaoProgramadaPedido(AAutoincrem: String;
                                               ADefiniuLotes: Boolean;
                                               AEhExpedicao : Boolean = False);
var
  LMovimentacao : TMovimentacaoProgramadaPedido;
Begin
  if (not fCfgSis('WMSMOV', varBoolean)) then
    Exit;

  LMovimentacao := TMovimentacaoProgramadaPedido.Create(AAutoincrem, AEhExpedicao);

  try
    try
      if (not ADefiniuLotes) Then
      begin
        LMovimentacao.pDeletaMovimentacoes;
        Exit;
      end;

      LMovimentacao.fRealizaMovimentos;
      LMovimentacao.pAtivaMovimentacoes;
    except
      on E : ExceptionAutComMovimentacaoProgramadaQuantidadeAtendidaParcialmente Do
      begin
        if ADefiniuLotes then
          LMovimentacao.pAtivaMovimentacoes;
        raise;
      end;

      on E : Exception Do
        raise;
    end;
  finally
    FreeAndNil(LMovimentacao);
  end;
end;

end.
