unit untTransferenciaArmazensConferencia;

interface

uses
  untCadLote,
  untGravando,
  CxProgressBar,
  StrUtils,
  SysUtils,
  Classes,
  DB,
  untTypesSistema,
  Variants,
  untFuncoesSimples,
  Uni;

type
  TSituacaoConferencia = (scNaoConferido = 0, scEmConferencia = 1, scConferido = 2, scTodos = 3);

  TTransferenciaArmazensConferenciaConferencia = Class
  Private
    FSelecionados: TStringList;
    FCadLot: TCadLot;
    FTraArm: TUniQuery;
    FTraArmItens: TUniQuery;
    FDtaIni,
    FDtaFin: TDate;
    FCodTip: String;
    FArmzem: String;
    FDtaSrc: TDataSource;
    FDtaSrcItens: TDataSource;
    FQryTmp: TUniQuery;
    procedure pTraArmAfterScroll(objDataSet: TDataSet);
    procedure pAtualizarQuantidade(dobQtdIte: Double);
    function fLocalizarItem(strCodIte: String; strNomCam: String = 'DET_CODITE'): Boolean;
    function fCampoQuantidadeConferida: TField;
    function fCampoSeqDet: TField;
    function fConfirmarConferenciaAux(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pGravarTraCof;
    procedure pMovimentarEstoque;
    function fApagaReserva(AAutIncMovDet: String): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure pFechar;
    function fDataSource: TDataSource;
    function fDataSourceItens: TDataSource;
    function fStatusQuantidadeConferida: TSituacaoConferencia;
    function objTraArm: TUniQuery;
    function fDataFinal(dtaDtaFin: TDate): TTransferenciaArmazensConferenciaConferencia;
    function fDataInicial(dtaDtaIni: TDate): TTransferenciaArmazensConferenciaConferencia;
    function fTipoConferencia(strCodTip: String): TTransferenciaArmazensConferenciaConferencia;
    function fArmazem(strArmzem: String): TTransferenciaArmazensConferenciaConferencia;
    function fAtualizarQuantidadeConferida(strCodIte: String; dobQtdIte: Double): Boolean;
    function fCarregarDocumentosConferencia: TTransferenciaArmazensConferenciaConferencia;
    function fCarregarDocumentosConferenciaItens: TTransferenciaArmazensConferenciaConferencia;
    function fConfirmarConferencia: Boolean;
    function fReiniciarContagem(enuSituacaoConferencia: TSituacaoConferencia = scTodos): TTransferenciaArmazensConferenciaConferencia;
    function fValidarConferencia: TTransferenciaArmazensConferenciaConferencia;

    function fExcluiItemConferencia: Boolean;
    function fAdicionarRemoverLista: TTransferenciaArmazensConferenciaConferencia;
    function fSelecionado: Boolean;
    function fFiltrarItens: TTransferenciaArmazensConferenciaConferencia;
  End;

implementation

function TTransferenciaArmazensConferenciaConferencia.fCarregarDocumentosConferenciaItens: TTransferenciaArmazensConferenciaConferencia;
Begin
  Result := Self;
  FSelecionados.Clear;
  FTraArmItens.Close;
  FTraArmItens.SQL.Clear;
  FTraArmItens.SQL.Add('SELECT');
  FTraArmItens.SQL.Add('  MOVGER.AUTOINCREM,');
  FTraArmItens.SQL.Add('  MOVGER.GER_CODEMP,');
  FTraArmItens.SQL.Add('  MOVGER.GER_DTADOC,');
  FTraArmItens.SQL.Add('  MOVGER.GER_NUMDOC,');
  FTraArmItens.SQL.Add('  MOVGER.GER_ESPDOC,');
  FTraArmItens.SQL.Add('  MOVGER.GER_CODCLI,');
  FTraArmItens.SQL.Add('  MOVSAI.DET_CODITE,');
  FTraArmItens.SQL.Add('  MOVSAI.DET_DESCRI,');
  FTraArmItens.SQL.Add('  MAR_DESMAR DET_DESMAR,  ');
  FTraArmItens.SQL.Add('  @QTDITE := MOVSAI.DET_QTDITE AS DET_QTDITE,');
  FTraArmItens.SQL.Add('  @ARMORI := MOVSAI.DET_NUMLOT AS DET_ARMORI,');
  FTraArmItens.SQL.Add('  @ARMDES := MOVENT.DET_NUMLOT AS DET_ARMDES,');
  FTraArmItens.SQL.Add('  TRAREL.TRA_SEQSAI AS DET_INCORI,');
  FTraArmItens.SQL.Add('  TRAREL.TRA_SEQENT AS DET_INCDES,');
  FTraArmItens.SQL.Add('  @QTDCFS := IFNULL(CONSAI.TCF_QTDITE,0) AS DET_QTDCFS,');
  FTraArmItens.SQL.Add('  @QTDCFE := IFNULL(CONENT.TCF_QTDITE,0) AS DET_QTDCFE,');
  FTraArmItens.SQL.Add('  @STATUS := CASE ');
  FTraArmItens.SQL.Add('	WHEN @QTDITE = @QTDCFS AND @QTDITE = @QTDCFE THEN "Transferência Concluída"');
  FTraArmItens.SQL.Add('	WHEN @QTDITE = @QTDCFS THEN "Aguardando conferência entrada"');
  FTraArmItens.SQL.Add('	ELSE "Aguardando conferência saída"');
  FTraArmItens.SQL.Add('  END DET_STATUS,');
  FTraArmItens.SQL.Add('  @ENTSAI := CASE ');
  FTraArmItens.SQL.Add('	WHEN @QTDITE = @QTDCFS AND @QTDITE = @QTDCFE THEN "F"');
  FTraArmItens.SQL.Add('	WHEN @QTDITE = @QTDCFS THEN "E"');
  FTraArmItens.SQL.Add('	ELSE "S"');
  FTraArmItens.SQL.Add(' END DET_ENTSAI');
  FTraArmItens.SQL.Add(' ,ITEGER.ITE_LOCFIS');
  FTraArmItens.SQL.Add('FROM');
  FTraArmItens.SQL.Add('	MOVGER');
  FTraArmItens.SQL.Add('JOIN TRAREL ON TRAREL.TRA_SEQGER = MOVGER.AUTOINCREM ');
  FTraArmItens.SQL.Add('JOIN MOVDET MOVENT ON TRA_SEQENT = MOVENT.AUTOINCREM');
  FTraArmItens.SQL.Add('JOIN MOVDET MOVSAI ON TRA_SEQSAI = MOVSAI.AUTOINCREM');
  FTraArmItens.SQL.Add('LEFT JOIN CADMAR ON MAR_CODMAR= MOVSAI.DET_CODMAR');
  FTraArmItens.SQL.Add('LEFT JOIN TRACOF CONENT ON CONENT.TCF_SEQDET = TRA_SEQENT');
  FTraArmItens.SQL.Add('LEFT JOIN TRACOF CONSAI ON CONSAI.TCF_SEQDET = TRA_SEQSAI');
  FTraArmItens.SQL.Add('LEFT JOIN ITEGER ON ITEGER.ITE_CODEMP = MOVGER.GER_CODEMP');
  FTraArmItens.SQL.Add('                AND ITEGER.ITE_CODITE = MOVENT.DET_CODITE');
  FTraArmItens.SQL.Add('WHERE GER_CODEMP = :CODEMP');
  FTraArmItens.SQL.Add('  AND GER_ESPDOC = "TA"  ');

  FTraArmItens.SQL.Add('  AND IFNULL(TRAREL.TRA_CONFER, "") <> "N" ');

  FTraArmItens.SQL.Add('  AND CASE ');
  FTraArmItens.SQL.Add('	WHEN MOVSAI.DET_QTDITE = CONSAI.TCF_QTDITE AND MOVSAI.DET_QTDITE = CONENT.TCF_QTDITE THEN "F"');
  FTraArmItens.SQL.Add('	WHEN MOVSAI.DET_QTDITE = CONSAI.TCF_QTDITE THEN "E"');
  FTraArmItens.SQL.Add('	ELSE "S"');
  FTraArmItens.SQL.Add('  END = :TIPCOF');
//  FTraArm.SQL.Add('  AND LOCATE(:ARMZEM,CONCAT(MOVSAI.DET_NUMLOT,MOVENT.DET_NUMLOT))');
  case AnsiIndexStr(FCodTip,['E','S']) Of
     0:  Begin
          FTraArmItens.SQL.Add('AND MOVENT.DET_NUMLOT = :ARMZEM');
          FTraArmItens.SQL.Add('AND MOVENT.DET_FILKAR = TRUE ');
        End;
    1:  Begin
          FTraArmItens.SQL.Add('AND MOVSAI.DET_NUMLOT = :ARMZEM');
          FTraArmItens.SQL.Add('AND MOVSAI.DET_FILKAR = TRUE ');
        End;
  End;

  If (FDtaIni <> 0) And (FDtaFin <> 0) Then
  Begin
    FTraArmItens.SQL.Add('AND GER_DTADOC BETWEEN :DTAINI AND :DATAFIN');
    FTraArmItens.ParamByName('DTAINI').AsDateTime := FDtaIni;
    FTraArmItens.ParamByName('DATAFIN').AsDateTime := FDtaFin;
  End;
  FTraArmItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
  FTraArmItens.ParamByName('TIPCOF').AsString := FCodTip;
  FTraArmItens.ParamByName('ARMZEM').AsString := FArmZem;
  FTraArmItens.Open;

  FTraArmItens.FieldByName('DET_QTDCFS').ReadOnly := False;
  FTraArmItens.FieldByName('DET_QTDCFE').ReadOnly := False;
End;

function TTransferenciaArmazensConferenciaConferencia.fCarregarDocumentosConferencia: TTransferenciaArmazensConferenciaConferencia;
Begin
  Result := Self;
  FTraArm.Close;
  FTraArm.SQL.Clear;
  FTraArm.SQL.Add('SELECT');
  FTraArm.SQL.Add('  MOVGER.GER_CODEMP,');
  FTraArm.SQL.Add('  MOVGER.GER_DTADOC,');
  FTraArm.SQL.Add('  MOVGER.GER_NUMDOC,');
  FTraArm.SQL.Add('  MOVGER.GER_ESPDOC,');
  FTraArm.SQL.Add('  MOVGER.GER_CODCLI,');
  FTraArm.SQL.Add('  @ARMORI := MOVSAI.DET_NUMLOT AS DET_ARMORI,');
  FTraArm.SQL.Add('  @ARMDES := MOVENT.DET_NUMLOT AS DET_ARMDES,');
  FTraArm.SQL.Add('  @STATUS := CASE ');
  FTraArm.SQL.Add('	WHEN @QTDITE = @QTDCFS AND @QTDITE = @QTDCFE THEN "Transferência Concluída"');
  FTraArm.SQL.Add('	WHEN @QTDITE = @QTDCFS THEN "Aguardando conferência entrada"');
  FTraArm.SQL.Add('	ELSE "Aguardando conferência saída"');
  FTraArm.SQL.Add('  END DET_STATUS,');
  FTraArm.SQL.Add('  @ENTSAI := CASE ');
  FTraArm.SQL.Add('	WHEN @QTDITE = @QTDCFS AND @QTDITE = @QTDCFE THEN "F"');
  FTraArm.SQL.Add('	WHEN @QTDITE = @QTDCFS THEN "E"');
  FTraArm.SQL.Add('	ELSE "S"');
  FTraArm.SQL.Add(' END DET_ENTSAI');
  FTraArm.SQL.Add(' ,ITEGER.ITE_LOCFIS');
  FTraArm.SQL.Add('FROM');
  FTraArm.SQL.Add('	MOVGER');
  FTraArm.SQL.Add('JOIN TRAREL ON TRAREL.TRA_SEQGER = MOVGER.AUTOINCREM ');
  FTraArm.SQL.Add('JOIN MOVDET MOVENT ON TRA_SEQENT = MOVENT.AUTOINCREM');
  FTraArm.SQL.Add('JOIN MOVDET MOVSAI ON TRA_SEQSAI = MOVSAI.AUTOINCREM');
  FTraArm.SQL.Add('LEFT JOIN CADMAR ON MAR_CODMAR= MOVSAI.DET_CODMAR');
  FTraArm.SQL.Add('LEFT JOIN TRACOF CONENT ON CONENT.TCF_SEQDET = TRA_SEQENT');
  FTraArm.SQL.Add('LEFT JOIN TRACOF CONSAI ON CONSAI.TCF_SEQDET = TRA_SEQSAI');
  FTraArm.SQL.Add('LEFT JOIN ITEGER ON ITEGER.ITE_CODEMP = MOVGER.GER_CODEMP');
  FTraArm.SQL.Add('                AND ITEGER.ITE_CODITE = MOVENT.DET_CODITE');
  FTraArm.SQL.Add('WHERE GER_CODEMP = :CODEMP');

  FTraArm.SQL.Add('  AND IFNULL(TRAREL.TRA_CONFER, "") <> "N" ');

  FTraArm.SQL.Add('  AND GER_ESPDOC = "TA"  ');
  FTraArm.SQL.Add('  AND CASE ');
  FTraArm.SQL.Add('	WHEN MOVSAI.DET_QTDITE = CONSAI.TCF_QTDITE AND MOVSAI.DET_QTDITE = CONENT.TCF_QTDITE THEN "F"');
  FTraArm.SQL.Add('	WHEN MOVSAI.DET_QTDITE = CONSAI.TCF_QTDITE THEN "E"');
  FTraArm.SQL.Add('	ELSE "S"');
  FTraArm.SQL.Add('  END = :TIPCOF');
  case AnsiIndexStr(FCodTip,['E','S']) Of
    0:  Begin
          FTraArm.SQL.Add('AND MOVENT.DET_NUMLOT = :ARMZEM');
          FTraArm.SQL.Add('AND MOVENT.DET_FILKAR = TRUE ');
        End;
    1:  Begin
          FTraArm.SQL.Add('AND MOVSAI.DET_NUMLOT = :ARMZEM');
          FTraArm.SQL.Add('AND MOVSAI.DET_FILKAR = TRUE ');
        End;
  End;

  If (FDtaIni <> 0) And (FDtaFin <> 0) Then
  Begin
    FTraArm.SQL.Add('AND GER_DTADOC BETWEEN :DTAINI AND :DATAFIN');
    FTraArm.ParamByName('DTAINI').AsDateTime := FDtaIni;
    FTraArm.ParamByName('DATAFIN').AsDateTime := FDtaFin;
  End;
  FTraArm.SQL.Add('GROUP BY MOVGER.GER_CODEMP, MOVGER.GER_NUMDOC');
  FTraArm.ParamByName('CODEMP').AsString := VS_strCodEmp;
  FTraArm.ParamByName('TIPCOF').AsString := FCodTip;
  FTraArm.ParamByName('ARMZEM').AsString := FArmZem;
  FTraArm.Open;

End;


function TTransferenciaArmazensConferenciaConferencia.fAtualizarQuantidadeConferida(strCodIte: String; dobQtdIte: Double): Boolean;
Begin
  Result := fLocalizarItem(strCodIte);
  If Not Result Then
  Begin
    pMensagemOk('Item ' + strCodIte + ' não localizado na conferência');
    Exit;
  End;

  pAtualizarQuantidade(fCampoQuantidadeConferida.AsCurrency + dobQtdIte);
End;

function TTransferenciaArmazensConferenciaConferencia.fReiniciarContagem(enuSituacaoConferencia: TSituacaoConferencia = scTodos): TTransferenciaArmazensConferenciaConferencia;
Begin
  Result := Self;
  FTraArmItens.First;
  While Not FTraArmItens.Eof Do
  Begin
    case enuSituacaoConferencia of
      scTodos: pAtualizarQuantidade(0);
      scEmConferencia:
        If fStatusQuantidadeConferida = scEmConferencia Then
          pAtualizarQuantidade(0);
    End;
    FTraArmItens.Next;
  End;
End;

function TTransferenciaArmazensConferenciaConferencia.fLocalizarItem(strCodIte: String; strNomCam: String = 'DET_CODITE'): Boolean;
var
  LobjCampoBusca: TField;
begin
  Result := FTraArmItens.Locate(strNomCam, strCodIte, []);

  if Result and (fStatusQuantidadeConferida = scConferido) then
  begin
    LobjCampoBusca := FTraArmItens.FieldByName(strNomCam);

    while FTraArmItens.FindNext do
    begin
      if (LobjCampoBusca.AsString = strCodIte) and (fStatusQuantidadeConferida <> scConferido) then
        Exit(True);
    end;

    Result := False;
  end;

  if (not Result) and (strNomCam = 'DET_CODITE') then
    Result := fLocalizarItem(strCodIte, 'ITE_CODBAR');
end;

procedure TTransferenciaArmazensConferenciaConferencia.pAtualizarQuantidade(dobQtdIte: Double);
Begin
  FTraArmItens.Edit;
  fCampoQuantidadeConferida.AsCurrency := dobQtdIte;
  FTraArmItens.Post;
End;


function TTransferenciaArmazensConferenciaConferencia.objTraArm: TUniQuery;
begin
  Result := FTraArmItens
end;

constructor TTransferenciaArmazensConferenciaConferencia.Create;
begin
  FSelecionados := TStringList.Create;
  FCadLot := TCadLot.Create(nil);
  FTraArm := fCriaQuery;
  FTraArmItens := fCriaQuery;
  FTraArmItens.CachedUpdates := True;
  FDtaSrc := TDataSource.Create(nil);
  FDtaSrc.DataSet := FTraArm;
  FDtaSrcItens := TDataSource.Create(nil);
  FDtaSrcItens.DataSet := FTraArmItens;
  FTraArm.AfterScroll := pTraArmAfterScroll;
  FQryTmp := fCriaQuery;
end;

destructor TTransferenciaArmazensConferenciaConferencia.Destroy;
begin
  FreeAndNil(FSelecionados);
  FreeAndNil(FTraArm);
  FreeAndNil(FTraArmItens);
  FreeAndNil(FDtaSrc);
  FreeAndNil(FDtaSrcItens);
  FreeAndNil(FCadLot);
  FreeAndNil(FQryTmp);
  inherited;
end;

function TTransferenciaArmazensConferenciaConferencia.fArmazem(
  strArmzem: String): TTransferenciaArmazensConferenciaConferencia;
begin
  Result := Self;
  FArmZem := strArmZem;
end;

function TTransferenciaArmazensConferenciaConferencia.fDataFinal(
  dtaDtaFin: TDate): TTransferenciaArmazensConferenciaConferencia;
begin
  Result := Self;
  FDtaFin := dtaDtaFin;
end;

function TTransferenciaArmazensConferenciaConferencia.fDataInicial(
  dtaDtaIni: TDate): TTransferenciaArmazensConferenciaConferencia;
begin
  Result := Self;
  FDtaIni := dtaDtaIni;
end;

function TTransferenciaArmazensConferenciaConferencia.fDataSource: TDataSource;
begin
  Result := FDtaSrc;
end;

function TTransferenciaArmazensConferenciaConferencia.fDataSourceItens: TDataSource;
begin
  Result := FDtaSrcItens;
end;

function TTransferenciaArmazensConferenciaConferencia.fCampoQuantidadeConferida: TField;
begin
  Result := nil;
  case AnsiIndexStr(FCodTip,['E','S']) Of
    0: Result := FTraArmItens.FieldByName('DET_QTDCFE');
    1: Result := FTraArmItens.FieldByName('DET_QTDCFS');
  End;
End;

function TTransferenciaArmazensConferenciaConferencia.fCampoSeqDet: TField;
begin
  Result := nil;
  case AnsiIndexStr(FCodTip,['E','S']) Of
    0: Result := FTraArmItens.FieldByName('DET_INCDES');
    1: Result := FTraArmItens.FieldByName('DET_INCORI');
  End;
End;

function TTransferenciaArmazensConferenciaConferencia.fStatusQuantidadeConferida: TSituacaoConferencia;
Var
  objCampo: TField;
begin
  objCampo := fCampoQuantidadeConferida;
  Result := scNaoConferido;
  If objCampo.AsCurrency = 0 Then
    Exit(scNaoConferido);
  If (objCampo.AsCurrency <> FTraArmItens.FieldByName('DET_QTDITE').AsCurrency) Then
    Exit(scEmConferencia);
  If (objCampo.AsCurrency = FTraArmItens.FieldByName('DET_QTDITE').AsCurrency) Then
    Exit(scConferido);
end;

function TTransferenciaArmazensConferenciaConferencia.fTipoConferencia(
  strCodTip: String): TTransferenciaArmazensConferenciaConferencia;
begin
  Result := Self;
  FCodTip := strCodTip;
end;

function TTransferenciaArmazensConferenciaConferencia.fConfirmarConferencia: Boolean;
var
  LfrmGravando: TfrmGravando;
begin
  Result := True;
  pCriarFormularios(TfrmGravando, LfrmGravando);
  Try
    LfrmGravando.lblGravando.Caption := 'Gravando conferência de transferência...';
    LfrmGravando.pgbStatus.Visible := False;
    LfrmGravando.fExecutarAcao := fConfirmarConferenciaAux;
    Try
      LfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TGerenciaPerdaEntrada.fConfirmarConferencia]');
      End;
    End;
  Finally
    pFreeAndNil(LfrmGravando);
  end;
End;


function TTransferenciaArmazensConferenciaConferencia.fConfirmarConferenciaAux(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;
  fStartTransaction;
  Try
    FTraArmItens.Filtered := False;
    FTraArmItens.First;
    While Not FTraArmItens.Eof Do
    Begin
      If fStatusQuantidadeConferida = TSituacaoConferencia.scConferido Then
      Begin
        pGravarTraCof;
        If FCodTip = 'E' Then
          pMovimentarEstoque;
      End;
      pProgresso(FTraArmItens.RecNo, FTraArmItens.RecordCount, pgbStatus);
      FTraArmItens.Next;
    End;
    fCommit;
    Result := True;
    FTraArm.Close;
    FTraArmItens.Close;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TGerenciaPerdaEntrada.fGeraAjusteEstoqueAux]');
    End;
  End;
end;

procedure TTransferenciaArmazensConferenciaConferencia.pGravarTraCof;
Var
  qryTraCof: TUniQuery;

Begin
  qryTraCof := fCriaQuery;
  Try
    Try
      qryTraCof.SQL.Add('INSERT INTO TRACOF (AUTOINCREM, TCF_SEQDET, TCF_QTDITE, TCF_CODOPE,');
      qryTraCof.SQL.Add('TCF_DTACOF, TCF_HRACOF)');
      qryTraCof.SQL.Add('VALUES (:AUTOINCREM, :TCF_SEQDET, :TCF_QTDITE, :TCF_CODOPE,');
      qryTraCof.SQL.Add(':TCF_DTACOF, :TCF_HRACOF)');
      qryTraCof.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('TRACOF', VS_strCodEmp);
      qryTraCof.ParamByName('TCF_SEQDET').AsString := fCampoSeqDet.AsString;
      qryTraCof.ParamByName('TCF_QTDITE').AsFloat := fCampoQuantidadeConferida.AsFloat;
      qryTraCof.ParamByName('TCF_CODOPE').AsString := strLoginUsuarioLogado;
      qryTraCof.ParamByName('TCF_DTACOF').AsDateTime := fNow();
      qryTraCof.ParamByName('TCF_HRACOF').AsTime := fTime();
      qryTraCof.ExecSQL;
    Except
      raise Exception.Create('Erro ao gravar [TTransferenciaArmazensConferenciaConferencia.pGravarTraCof]');
    End;
  Finally
    qryTraCof.Free;
  End;
End;

function TTransferenciaArmazensConferenciaConferencia.fValidarConferencia: TTransferenciaArmazensConferenciaConferencia;
Begin
  Result := Self;
  FTraArmItens.DisableControls;
  FTraArmItens.Filtered := False;
  Try
    If FTraArmItens.IsEmpty Then
      raise Exception.Create('Nenhum item foi encontrado na conferência!');

    FTraArmItens.First;
    While Not FTraArmItens.Eof Do
    Begin
      If fStatusQuantidadeConferida = TSituacaoConferencia.scEmConferencia Then
        raise Exception.Create('Quantidade conferida divergente da quantidade disponivel para transferencia. Favor reiniciar a conferencia.');
      FTraArmItens.Next;
    End;
  Finally
    FTraArmItens.Filtered := True;
    FTraArmItens.EnableControls;
  End;
End;

procedure TTransferenciaArmazensConferenciaConferencia.pMovimentarEstoque;
Begin
  FQryTmp.SQL.Clear;
  FQryTmp.SQL.Add('UPDATE MOVDET');
  FQryTmp.SQL.Add('   SET DET_DTAENT = ' + fCurrentDate + ',');
  FQryTmp.SQL.Add('       DET_FILKAR = 0');
  FQryTmp.SQL.Add(' WHERE AUTOINCREM IN (:AUTORI, :AUTDES)');
  FQryTmp.ParamByName('AUTORI').AsString := FTraArmItens.FieldByName('DET_INCORI').AsString;
  FQryTmp.ParamByName('AUTDES').AsString := FTraArmItens.FieldByName('DET_INCDES').AsString;
  FQryTmp.ExecSQL;

  //Movimentar o SALDO SAIDA
  FCadLot.fAtualizaEstoqueLote(FTraArmItens.FieldByName('DET_CODITE').AsString,
      'S',
      FTraArmItens.FieldByName('DET_ARMORI').AsString,
      FTraArmItens.FieldByName('DET_QTDITE').AsFloat);

 // Movimentar o SALDO ENTRDA
  FCadLot.fAtualizaEstoqueLote(FTraArmItens.FieldByName('DET_CODITE').AsString,
      'E',
      FTraArmItens.FieldByName('DET_ARMDES').AsString,
      FTraArmItens.FieldByName('DET_QTDITE').AsFloat);


  fApagaReserva(FTraArmItens.FieldByName('DET_INCORI').AsString);

  FQryTmp.SQL.Clear;
  FQryTmp.SQL.Add('UPDATE MOVGER');
  FQryTmp.SQL.Add('   SET GER_DTAENT = ' + fCurrentDate);
  FQryTmp.SQL.Add(' WHERE AUTOINCREM  = ' + FTraArmItens.FieldByName('AUTOINCREM').AsString.QuotedString);
  FQryTmp.SQL.Add(' AND NOT EXISTS(SELECT 1 FROM MOVDET WHERE DET_SEQGER = MOVGER.AUTOINCREM AND DET_FILKAR = 1 LIMIT 1)');
  FQryTmp.ExecSQL;
End;

procedure TTransferenciaArmazensConferenciaConferencia.pTraArmAfterScroll(
  objDataSet: TDataSet);
begin
  fFiltrarItens;
end;

procedure TTransferenciaArmazensConferenciaConferencia.pFechar;
begin
  FTraArm.Close;
  FTraArmItens.Close;
end;

function TTransferenciaArmazensConferenciaConferencia.fApagaReserva(AAutIncMovDet: String): boolean;
var
  strNumdoc,
  strEspdoc,
  strSerie,
  strTipFc,
  strCliFor,
  strCodEmp,
  strChave,
  strAutIncReserva,
  strAutIncDetReserva,
  strDocIte,
  strNumLot: string;
begin
  Result := True;
  Try
    FQryTmp.SQL.Clear;
    FQryTmp.SQL.Add('SELECT * FROM MOVDET');
    FQryTmp.SQL.Add('WHERE AUTOINCREM = "'+AAutIncMovDet+'"');
    FQryTmp.Open;

    strNumdoc := FQryTmp.FieldByName('DET_NUMDOC').AsString;
    strEspdoc := FQryTmp.FieldByName('DET_ESPDOC').AsString;
    strSerie := FQryTmp.FieldByName('DET_SERIE_').AsString;
    strTipFc := FQryTmp.FieldByName('DET_TIP_FC').AsString;
    Case AnsiIndexStr(FQryTmp.FieldByName('DET_TIP_FC').AsString, ['C','F']) Of
      0: strCliFor := FQryTmp.FieldByName('DET_CODCLI').AsString;
      1: strCliFor := FQryTmp.FieldByName('DET_CODFOR').AsString;
    End;

    strCodEmp := FQryTmp.FieldByName('DET_CODEMP').AsString;
    strDocIte := FQryTmp.FieldByName('DET_CODITE').AsString;
    strNumLot := FQryTmp.FieldByName('DET_NUMLOT').AsString;

    strChave := '';
    strChave := strChave + fPadL(strNumDoc , fTamNumDoc);
    strChave := strChave + fPadR(strEspDoc , 02);
    strChave := strChave + fPadR(strSerie , 03);
    strChave := strChave + fPadR(strCodEmp , 03);
    strChave := strChave + fPadR(strCliFor , 08);
    strChave := strChave + fPadR(strTipFc , 01);


    FQryTmp.SQL.Clear;
    If fCfgSis('SPCDEN', varBoolean) Then
    Begin
      FQryTmp.SQL.Add('SELECT FATDOR.AUTOINCREM, FATDOR.FDO_SEQGER FROM EXTGOR');
      FQryTmp.SQL.Add(' INNER JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
      FQryTmp.SQL.Add(' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
      FQryTmp.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
      FQryTmp.SQL.Add(' WHERE FGO_DCENUM = "'+strNumdoc+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCEESP = "'+strEspdoc+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCESER = "'+strSerie+'"  ');
      FQryTmp.SQL.Add('   AND FGO_DCEEMP = "'+strCodEmp+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCEFOR = "'+strCliFor+'" ');
      FQryTmp.SQL.Add('   AND FGO_DCETFC = "'+strTipFc+'"  ');
      FQryTmp.SQL.Add('   AND FDO_CODITE = "'+strDocIte+'" ');
      FQryTmp.SQL.Add('   AND FDO_NUMLOT = "'+strNumLot+'" ');
      FQryTmp.SQL.Add('   AND FDO_AUTDET = "'+AAutIncMovDet+'" ');
    End
    Else
    begin
      FQryTmp.SQL.Add('SELECT FATDOR.AUTOINCREM, FATDOR.FDO_SEQGER FROM EXTGOR ');
      FQryTmp.SQL.Add(' INNER JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
      FQryTmp.SQL.Add(' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
      FQryTmp.SQL.Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');

      FQryTmp.SQL.Add(' WHERE FGO_DOCEND = "'+strChave+'"');
      FQryTmp.SQL.Add('   AND FDO_CODITE = "'+strDocIte+'" ');
      FQryTmp.SQL.Add('   AND FDO_NUMLOT = "'+strNumLot+'" ');
      FQryTmp.SQL.Add('   AND FDO_AUTDET = "'+AAutIncMovDet+'" ');

    End;
    FQryTmp.Open;

    strAutIncDetReserva := FQryTmp.FieldByName('AUTOINCREM').AsString;
    strAutIncReserva := FQryTmp.FieldByName('FDO_SEQGER').AsString;

    FQryTmp.sql.Clear;
    FQryTmp.sql.Add('DELETE FROM FATDOR');
    FQryTmp.sql.Add(' WHERE AUTOINCREM = "'+strAutIncDetReserva+'";');
    FQryTmp.ExecSQL;

    FQryTmp.sql.Clear;
    FQryTmp.sql.Add('DELETE FROM FATGOR');
    FQryTmp.sql.Add(' WHERE  AUTOINCREM  = "'+strAutIncReserva+'"');
    FQryTmp.sql.Add('   AND (SELECT COUNT(1) FROM FATDOR');
    FQryTmp.sql.Add('         WHERE FDO_SEQGER = "'+strAutIncReserva+'") = 0;');
    FQryTmp.ExecSQL;

    FQryTmp.SQL.Clear;
    FQryTmp.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S" WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
    FqryTmp.ParamByName('CODITE').AsString := strDocIte;
    FqryTmp.ParamByName('CODEMP').AsString := strCodEmp;
    FQryTmp.ExecSQL;

  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmLiberacaoTransferenciaArmazem.fApagaReserva]');
    End;
  End;
end;




function TTransferenciaArmazensConferenciaConferencia.fExcluiItemConferencia: Boolean;
  Var
    qryUpdate: TUniQuery;
Begin
  Try
    fStartTransaction;

    qryUpdate := fCriaQuery();
    Try
      qryUpdate.SQL.Text := 'UPDATE TRAREL SET TRA_CONFER = "N" WHERE TRA_SEQSAI = :INCORI';
      qryUpdate.ParamByName('INCORI').AsString := FTraArmItens.FieldByName('DET_INCORI').AsString;
      qryUpdate.Execute;
    Finally
      FreeAndNil(qryUpdate);
    End;

    Result := fApagaReserva(FTraArmItens.FieldByName('DET_INCORI').AsString);

    If Result Then
    Begin
      fCommit();
      FTraArmItens.Delete;
    End

    Else fRollBack();

  Except
    On E:Exception Do
    Begin
      fRollBack();
      Result := False;
      pMensagensErro(E.Message, '[TfrmLiberacaoTransferenciaArmazem.fExcluiItemConferencia]');
    End;
  End;
End;

function TTransferenciaArmazensConferenciaConferencia.fAdicionarRemoverLista: TTransferenciaArmazensConferenciaConferencia;
Var
  intIndice: Integer;
  strNumDoc: String;
begin
  Result := Self;
  strNumDoc := FTraArm.FieldByName('GER_NUMDOC').AsString.QuotedString;
  intIndice := FSelecionados.IndexOf(strNumDoc);
  If intIndice <> -1 Then
    FSelecionados.Delete(intIndice)
  Else
    FSelecionados.Add(strNumDoc);
end;

function TTransferenciaArmazensConferenciaConferencia.fSelecionado: Boolean;
begin
  Result := FSelecionados.IndexOf(FTraArm.FieldByName('GER_NUMDOC').AsString.QuotedString) <> -1;
end;

function TTransferenciaArmazensConferenciaConferencia.fFiltrarItens: TTransferenciaArmazensConferenciaConferencia;
begin
  Result := Self;
  If FSelecionados.Count > 0 Then
    FTraArmItens.Filter := 'GER_NUMDOC IN (' + FSelecionados.CommaText + ')'
  Else
    FTraArmItens.Filter := 'GER_NUMDOC = ' + FTraArm.FieldByName('GER_NUMDOC').AsString.QuotedString;
  FTraArmItens.Filtered := True;
end;


end.
