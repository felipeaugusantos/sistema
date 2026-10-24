unit untTAlterarPrazoGarantia;

interface
uses
  untZClient, Uni, cxProgressBar, Data.DB;

Const
  DOC_SELECIONADO: String = '1';
  DOC_NAO_SELECIONADO: String = '0';

Type
  {$SCOPEDENUMS ON}
  TTabelas = (MovGer, NotGer);
  {$SCOPEDENUMS OFF}
Type
  TAlterarPrazoGarantia = class
  private
    strTabela: String;
    strTabelaPar: String;
    FQryLog: TUniquery;
    FQryUpdate: TUniQuery;
    FQryDocOri: TUniQuery;
    FQryUpdatePar: TUniQuery;
    blnGarintiaTodosDocumento: boolean;
    function fGetSQLDocumentos: String;
    function fGetSqlSubQueryDocumentos(enuTabela: TTabelas): String; overload;
    function fGetSqlSubQueryDocumentos: String;overload;
    function fGetSqlUpdate(const strTabela: String): String;

    function fGetSqlLog: String;
    function fGetSqlDocOri: String;
    function fCarregarDocumentoVenda(strNumDoc, strEspDoc, strCodCli, strCodEmp: String): Boolean;overload;
    procedure pCarregarCFGs;

    function fGravarLog: Boolean; overload;
    function fGravarLog(const strTabela, strIncGer, strIncDet : String;
      const intTmpGarAnt, intTmpGarNov: Integer): Boolean;overload;

    function fGravar: Boolean; overload;
    function fGravar(const strIncGer, strIncDet: String; const intTmpGar: Integer; blnTabPar: Boolean): Boolean;overload;
    function fGravarDocOri: Boolean;
    function fGravarAlteracaoTabelaPar: Boolean;
    function fGetQryLog: TUniQuery;
    function fGetQueryUpdate: TUniQuery;
    function fGetQryDocOri: TUniQuery;
    function fGetQryUpdatePar: TUniQuery;
    procedure pcdsDadosTmpGarValidate(Sender: TField);
    procedure pcdsDadosBeforePost(DataSet: TDataSet);
    function fTemTabelaPar: Boolean;

  public
    cdsDados: TZClient;
    strCodCli: String;
    strCodEmp: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodOpe: String;
    constructor Create;
    Destructor Destroy;Override;
    function fCarregarDocumentoVenda: Boolean;overload;
    function fConfirmar(prgProgresso : TcxProgressbar): Boolean;
    procedure pMensagemTempoMinimo;
    procedure pMensagemTempoMaximo;
    procedure pSelecionarItem;
    procedure pLimpar;
  end;

implementation
uses
  untFuncoesSimples, System.SysUtils;



{ TAlterarPrazoGarantia }

constructor TAlterarPrazoGarantia.Create;
begin
  pCarregarCFGs;
  cdsDados := TZClient.Create(nil);
  cdsDados.BeforePost := pcdsDadosBeforePost;
end;

function TAlterarPrazoGarantia.fCarregarDocumentoVenda: Boolean;
  Var
    objFieldDET_TmpGar: TField;
begin
  strTabela := EmptyStr;
  Result := fCarregarDocumentoVenda(Self.strNumDoc, Self.strEspDoc, Self.strCodCli, Self.strCodEmp);
  if Not Result then
    Exit;
  if cdsDados.Active then
  begin
    if cdsDados.IsEmpty then
    begin
      fMensagem('Atenção',
                'O documento informado não foi localizado.'
                  +sLineBreak+'Verifique se as informações estão digitadas corretamente.'
                ,['&Ok']);
      Result := False;
    end;
  end
  else
    Result := False;

  if Result then
  begin
    cdsDados.First;
    strTabela := cdsDados.FieldByName('TABELA').AsString;
    if strTabela = 'MOVGER' Then
      strTabelaPar := 'NOTGER'
    else
      strTabelaPar := 'MOVGER';
  end;

  objFieldDET_TmpGar := cdsDados.FindField('DET_TMPGAR');
  if Assigned(objFieldDET_TmpGar) then
    objFieldDET_TmpGar.OnValidate := pcdsDadosTmpGarValidate;
end;

function TAlterarPrazoGarantia.fConfirmar(
  prgProgresso: TcxProgressbar): Boolean;
  Var
    intCont: Integer;
    objcdsDadosTemOri: TField;
begin
  Result := False;
  intCont := 0;
  prgProgresso.Properties.Max := cdsDados.RecordCount;
  prgProgresso.Position := 0;
  objcdsDadosTemOri := cdsDados.FieldbyName('TEMORI');
  Try
    fStartTransaction;
    cdsDados.First;
    While Not cdsDados.Eof do
    begin
      Result := fGravar;
      Result := Result and fGravarLog;

      If Result and fTemTabelaPar then
        Result := fGravarAlteracaoTabelaPar;

      If Result and (objcdsDadosTemOri.AsString = 'S') Then
        Result := fGravarDocOri;

      if Not Result then
        Exit;

      inc(intCont);
      cdsDados.Next;
      prgProgresso.Position := prgProgresso.Position + 1;
    end
  Finally
    if Result and (intCont > 0) then
      fCommit
    else
      fRollBack;

    if Assigned(FQryDocOri) Then
      FreeAndNil(FQryDocOri);

    if Assigned(FQryUpdatePar) then
      FreeAndNil(FQryUpdatePar);

    if Assigned(FQryLog) then
      FreeAndNil(FQryLog);

    if Assigned(FQryUpdate) Then
      FreeAndNil(FQryUpdate);
  End;
end;

function TAlterarPrazoGarantia.fGetQryDocOri: TUniQuery;
begin
  if Not Assigned(FQryDocOri) then
  begin
    FQryDocOri := fCriaQuery;
    FQryDocOri.Close;
    FQryDocOri.SQL.Clear;
    FQryDocOri.SQL.Add(fGetSqlDocOri);
  end;
  if FQryDocOri.Active then
    FQryDocOri.Close;
  Result := FQryDocOri;
end;

function TAlterarPrazoGarantia.fGetQryLog: TUniQuery;
begin
  if Not Assigned(FQryLog) then
  begin
    FQryLog := fCriaQuery;
    FQryLog.Close;
    FQryLog.SQL.Clear;
    FQryLog.SQL.Add(fGetSqlLog);
  end;
  if FQryLog.Active then
    FQryLog.Close;
  Result := FQryLog;
end;

function TAlterarPrazoGarantia.fGetQryUpdatePar: TUniQuery;
begin
  if Not Assigned(FQryUpdatePar) then
  begin
    FQryUpdatePar := fCriaQuery;
    FQryUpdatePar.Close;
    FQryUpdatePar.SQL.Clear;
    FQryUpdatePar.SQL.Add(fGetSqlUpdate(strTabelaPar));
  end;
  IF FQryUpdatePar.Active Then
    FQryUpdatePar.Close;
  Result := FQryUpdatePar;
end;

function TAlterarPrazoGarantia.fGetQueryUpdate: TUniQuery;
begin
  if Not Assigned(FQryUpdate) then
  begin
    FQryUpdate := fCriaQuery;
    FQryUpdate.Close;
    FQryUpdate.SQL.Clear;
    FQryUpdate.SQL.Add(fGetSqlUpdate(strTabela));
  end;
  IF FQryUpdate.Active Then
    FQryUpdate.Close;
  Result := FQryUpdate;
end;

function TAlterarPrazoGarantia.fGetSqlDocOri: String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT ORI.AUTOINCREM, ORI.DET_SEQGER, ORI.DET_TMPGAR  ';
  Result := Result + ' FROM MOVGRC C ';
  Result := Result + ' JOIN MOVDET ORI ON ORI.AUTOINCREM = C.GRC_INCORI  ';
  Result := Result + ' WHERE C.GRC_SEQDET = :INCDET ';
end;

function TAlterarPrazoGarantia.fGetSqlLog: String;
begin
  Result := EmptyStr;
  Result := Result + ' INSERT INTO ';
  Result := Result +    ' LOGAPG (AUTOINCREM, LOG_TABELA, LOG_INCGER, LOG_INCDET, LOG_DTACAD, LOG_HRACAD, LOG_CODOPE, LOG_TMPNOV, LOG_TMPATU) ';
  Result := Result + ' VALUES ';
  Result := Result +    ' (:AUTOINCREM, :LOG_TABELA, :LOG_INCGER, :LOG_INCDET, :LOG_DTACAD, :LOG_HRACAD, :LOG_CODOPE, :LOG_TMPNOV, :LOG_TMPATU) ';
end;

function TAlterarPrazoGarantia.fGetSqlUpdate(
  const strTabela: String): String;
begin

  Result := EmptyStr;
  Result := 'UPDATE %0:s SET DET_TMPGAR = :TMPGAR WHERE AUTOINCREM = :INCDET AND DET_SEQGER = :INCGER ';

  if strTabela = 'MOVGER' then
    Result := Format(Result,['MOVDET'])
  else if strTabela = 'NOTGER' then
    Result := Format(Result,['NOTDET'])
  else
    raise Exception.Create('Tabela inválida!');
end;

function TAlterarPrazoGarantia.fGetSQLDocumentos: String;
  Var
    strSqlSub: String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT A.INCGER, ';
  Result := Result + '        A.GER_NUMDOC, ';
  Result := Result + '        A.GER_ESPDOC, ';
  Result := Result + '        A.GER_CODEMP, ';
  Result := Result + '        A.GER_DTAENT, ';
  Result := Result + '        A.GER_VLRCON, ';
  Result := Result + '        A.GER_CODVEN, ';
  Result := Result + '        O.OPE_NOMOPE, ';
  Result := Result + '        A.GER_CODCLI, ';
  Result := Result + '        C.CLI_NOMCLI, ';

  Result := Result + '        A.INCDET, ';
  Result := Result + '        A.DET_CODITE, ';
  Result := Result + '        A.DET_DESCRI, ';
  Result := Result + '        A.DET_UNIDAD, ';
  Result := Result + '        A.DET_UNITAR, ';
  Result := Result + '        A.DET_QTDITE, ';
  Result := Result + '        A.DET_TOTITE, ';
  Result := Result + '        A.DET_TMPGAR, ';
  Result := Result + '        A.TABELA, ';
  Result := Result + '        A.DET_TMPGAR AS "TMPGARORI", ';
  Result := Result + '        "0" AS SELECIONADO, ';

  Result := Result + '        IF(IFNULL(A.QTDORI,0) > 0,"S","N") AS TEMORI, ';

  Result := Result + '        IFNULL(A.PARGER, "") as PARGER,';
  Result := Result + '        IFNULL(A.PARDET, "") as PARDET ';

  Result := Result + ' FROM (%0:s) A '; //from subquery

  Result := Result + ' JOIN CADOPE O  ON O.OPE_CODOPE = A.GER_CODVEN ';
  Result := Result + ' JOIN CADCLI C  ON C.CLI_CODCLI = A.GER_CODCLI ';

  Result := Result + ' ORDER BY A.TABELA, A.INCGER, A.DET_CODITE, A.INCDET ';

  strSqlSub := fGetSqlSubQueryDocumentos;

  Result := Format(Result,[strSqlSub]);
end;

function TAlterarPrazoGarantia.fGetSqlSubQueryDocumentos: String;
  Type
    TTabelasSet = Set of TTabelas;
  Var
    enuTabela: TTabelas;
    enuTabelasSet: TTabelasSet;
begin
  Result := EmptyStr;

  enuTabelasSet := [TTabelas.MovGer, TTabelas.NotGer];

  for enuTabela in enuTabelasSet do
  begin
    if fEmptyStr(Result) then
      Result := fGetSqlSubQueryDocumentos(enuTabela)
    else begin
      Result := Result + ' UNION ';
      Result := Result + fGetSqlSubQueryDocumentos(enuTabela);
    end;
    Exclude(enuTabelasSet, enuTabela);
  end;
end;

function TAlterarPrazoGarantia.fGetSqlSubQueryDocumentos(
  enuTabela: TTabelas): String;
  Type
    TNomesTabelas = Array[0..1] OF String;

  CONST
    NOMES_TABELAS_MAT: Array[0..1] of TNomesTabelas = (('MOVGER','MOVDET'),  //0
                                                       ('NOTGER','NOTDET')); //1

    DADOS: Integer = 0;
    ITENS: Integer = 1;

  Var
    intIdx: Integer;
    strEspecies: String;
begin
  strEspecies := ' "NF", "IF"';

  if blnGarintiaTodosDocumento then
    strEspecies := strEspecies + ', "NV", "IV", "FF" ';

  Result := EmptyStr;
  Result := Result + ' SELECT G.AUTOINCREM AS "INCGER", ';
  Result := Result + '        G.GER_NUMDOC, ';
  Result := Result + '        G.GER_ESPDOC, ';
  Result := Result + '        G.GER_CODEMP, ';
  Result := Result + '        G.GER_DTAENT, ';
  Result := Result + '        G.GER_VLRCON, ';
  Result := Result + '        G.GER_CODVEN, ';
  Result := Result + '        G.GER_CODCLI, ';
  Result := Result + '        D.AUTOINCREM AS "INCDET", ';
  Result := Result + '        D.DET_CODITE, ';
  Result := Result + '        D.DET_DESCRI, ';
  Result := Result + '        D.DET_UNIDAD, ';
  Result := Result + '        ROUND(D.DET_UNITAR,2) AS "DET_UNITAR", ';
  Result := Result + '        D.DET_QTDITE, ';
  Result := Result + '        ROUND(D.DET_TOTITE,2) AS "DET_TOTITE", ';

  if enuTabela = TTabelas.MovGer then
  begin
    Result := Result + '      (SELECT SUM(IF(IFNULL(ORI.AUTOINCREM, "") = "", 0, 1)) ';
    Result := Result + '       FROM  MOVDET ORI ';
    Result := Result + '       JOIN MOVGRC C ';
    Result := Result + '       ON  ORI.AUTOINCREM = C.GRC_INCORI ';
    Result := Result + '       WHERE ORI.AUTOINCREM = G.AUTOINCREM ';
    Result := Result + '       GROUP BY C.GRC_SEQDET) AS QTDORI, ';
  end
  else begin
    Result := Result + '     0 AS QTDORI, ';
  end;

  Result := Result + '       N.AUTOINCREM AS PARDET, ';
  Result := Result + '       N.DET_SEQGER AS PARGER, ';

  Result := Result + '       D.DET_TMPGAR, %2:s as "TABELA" ';   //2

  Result := Result + ' FROM %0:s G '; //0
  Result := Result + ' JOIN %1:s D ';
  Result := Result + ' ON      D.DET_SEQGER = G.AUTOINCREM ';
  Result := Result + '     AND D.DET_PROEMB <> "S" ';
  Result := Result + '     AND D.DET_FILKAR <> 1 ';
  Result := Result + '     AND D.DET_PROACA <> "S" '; //1

  if enuTabela = TTabelas.MovGer then
    Result := Result + ' LEFT JOIN NOTDET N '
  else
    Result := Result + ' LEFT JOIN MOVDET N ';

  Result := Result + ' ON      D.DET_EMPFAT = N.DET_CODEMP ';
  Result := Result + '     AND D.DET_CLIFAT = N.DET_CODCLI ';
  Result := Result + '     AND D.DET_TIPFAT = N.DET_ESPDOC ';
  Result := Result + '     AND D.DET_NUMFAT = N.DET_NUMDOC ';
  Result := Result + '     AND D.DET_CODITE = N.DET_CODITE ';
  Result := Result + '     AND D.DET_TIP_FC = N.DET_TIP_FC ';
  Result := Result + '     AND D.DET_ORIDOC = N.DET_ORIDOC ';
  Result := Result + '     AND N.DET_TIP_FC = "C" ';
  Result := Result + '     AND N.DET_ORIDOC = "V" ';

  Result := Result + ' WHERE      G.GER_NUMDOC = :NUMDOC ';
  Result := Result + '        AND G.GER_CODEMP = :CODEMP ';
  Result := Result + '        AND G.GER_CODCLI = :CODCLI ';
  Result := Result + '        AND G.GER_TIP_FC  = "C" ';
  Result := Result + '        AND G.GER_ORIDOC = "V" ';
  Result := Result + '        AND G.GER_ESPDOC IN (%3:s) ';    //3

  intIdx := ord(enuTabela);

  Result := Format(Result,[NOMES_TABELAS_MAT[intIdx,DADOS],            //0
                           NOMES_TABELAS_MAT[intIdx,ITENS],            //1
                           QuotedStr(NOMES_TABELAS_MAT[intIdx,DADOS]), //2
                           strEspecies]);                              //3
end;

function TAlterarPrazoGarantia.fGravar: Boolean;
begin
  Try
    Result := fGravar(cdsDados.FieldByName('INCGER').AsString,
                      cdsDados.FieldByName('INCDET').AsString,
                      cdsDados.FieldByName('DET_TMPGAR').AsInteger,
                      False);
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(e.Message,'TAlterarPrazoGarantiaItemVenda.fGravar');
    end;
  End;
end;

function TAlterarPrazoGarantia.fGravar(const strIncGer, strIncDet: String;
  const intTmpGar: Integer; blnTabPar: Boolean): Boolean;
  Var
    QryUpdate: TUniQuery;
begin
  Try
    Result := true;
    if blnTabPar then
      QryUpdate := fGetQryUpdatePar
    else
      QryUpdate := fGetQueryUpdate;

    QryUpdate.ParamByName('TMPGAR').AsSmallInt := intTmpGar;
    QryUpdate.ParamByName('INCDET').AsString := strIncDet;
    QryUpdate.ParamByName('INCGER').AsString := strIncGer;
    QryUpdate.Execute;

  Except
    On E: Exception do
    begin
      Raise;
    end
  end;
end;

function TAlterarPrazoGarantia.fGravarAlteracaoTabelaPar: Boolean;
  Var
    objQryAutoincrem, objQrySeqGer, objQryTmpGarAnt: TField;
    intTmpGarNovo: Integer;
begin
  Try
    intTmpGarNovo := cdsDados.FieldByName('DET_TMPGAR').AsInteger;
    objQryAutoincrem := cdsDados.FieldByName('PARDET');
    objQrySeqGer := cdsDados.FieldByName('PARGER');
    objQryTmpGarAnt := cdsDados.FieldByName('DET_TMPGAR');

    Result := fGravar(objQrySeqGer.AsString,
                      objQryAutoincrem.AsString,
                      intTmpGarNovo,
                      True);

    Result := Result
              and fGravarLog(strTabelaPar,
                             objQrySeqGer.AsString,
                             objQryAutoincrem.AsString,
                             objQryTmpGarAnt.AsInteger,
                             intTmpGarNovo);
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(e.Message, 'TAlterarPrazoGarantiaItemVenda.fGravarAlteracaoTabelaPar');
    end;
  end;
end;

function TAlterarPrazoGarantia.fGravarDocOri: Boolean;
  Var
    QryDocOri: TUniQuery;
    objQryAutoincrem, objQrySeqGer, objQryTmpGarAnt: TField;
    intTmpGarNovo: Integer;
begin
  Result := True;
  QryDocOri := fGetQryDocOri;

  Try
    QryDocOri.ParamByName('INCDET').AsString := cdsDados.FieldByName('INCDET').AsString;
    QryDocOri.Open;

    if QryDocOri.IsEmpty then
      Exit;

    intTmpGarNovo := cdsDados.FieldByName('DET_TMPGAR').AsInteger;
    objQryAutoincrem := QryDocOri.FieldByName('AUTOINCREM');
    objQrySeqGer := QryDocOri.FieldByName('DET_SEQGER');
    objQryTmpGarAnt := QryDocOri.FieldByName('DET_TMPGAR');

    QryDocOri.First;
    While Not QryDocOri.Eof do
    begin
      Result := fGravar(objQrySeqGer.AsString, objQryAutoincrem.AsString, intTmpGarNovo, False);
      Result := Result
                and fGravarLog('MOVGER',
                               objQrySeqGer.AsString,
                               objQryAutoincrem.AsString,
                               objQryTmpGarAnt.AsInteger,
                               intTmpGarNovo);
      QryDocOri.Next;
    end;
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(e.Message, 'TAlterarPrazoGarantiaItemVenda.fGravarDocOri');
    end;
  end;

end;

function TAlterarPrazoGarantia.fGravarLog(const strTabela, strIncGer,
  strIncDet: String; const intTmpGarAnt, intTmpGarNov: Integer): Boolean;
  Var
    qryLog: TUniQuery;
    dtaDataHora: TDateTime;
    lTime: TTime;
begin
  Result := True;
  dtaDataHora := fNow;
  lTime := StrToTime(FormatDateTime('hh:mm:ss',dtaDataHora));
  qryLog := fGetQryLog;
  Try
    QryLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGAPG', strCodEmp);
    QryLog.ParamByName('LOG_TABELA').AsString   := strTabela;
    QryLog.ParamByName('LOG_INCGER').AsString   := strIncGer;
    QryLog.ParamByName('LOG_INCDET').AsString   := strIncDet;
    QryLog.ParamByName('LOG_DTACAD').AsDate     := dtaDataHora;
    QryLog.ParamByName('LOG_HRACAD').AsTime     := lTime;
    QryLog.ParamByName('LOG_CODOPE').AsString   := strCodOpe;
    QryLog.ParamByName('LOG_TMPNOV').AsSmallInt := intTmpGarNov;
    QryLog.ParamByName('LOG_TMPATU').AsSmallInt := intTmpGarAnt;
    qryLog.Execute;
  Except
    On E: Exception do
    begin
      Raise;
    end;
  end;
end;

function TAlterarPrazoGarantia.fTemTabelaPar: Boolean;
begin
  Result := Not fEmptyStr(cdsDados.FieldByName('PARDET').AsString);
end;

function TAlterarPrazoGarantia.fGravarLog: Boolean;
begin
  Try
    Result := fGravarLog(cdsDados.FieldByName('TABELA').AsString,
                         cdsDados.FieldByName('INCGER').AsString,
                         cdsDados.FieldByName('INCDET').AsString,
                         cdsDados.FieldByName('TMPGARORI').AsInteger,
                         cdsDados.FieldByName('DET_TMPGAR').AsInteger);
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(e.Message, 'TAlterarPrazoGarantiaItemVenda.fGravarLog');
    end;
  end;
end;

procedure TAlterarPrazoGarantia.pCarregarCFGs;
begin
  blnGarintiaTodosDocumento := fCfgSis('GANFIF',varString) = '2';
end;

procedure TAlterarPrazoGarantia.pcdsDadosBeforePost(DataSet: TDataSet);
  Var
    blnSelecionar: Boolean;
    objFieldTmpGar, objFieldTmpGarOri: TField;
begin
  objFieldTmpGar := cdsDados.FindField('DET_TMPGAR');
  objFieldTmpGarOri := cdsDados.FindField('TMPGARORI');

  If Not (Assigned(objFieldTmpGar) AND Assigned(objFieldTmpGarOri)) then
    Exit;

  blnSelecionar := (cdsDados.FieldByName('SELECIONADO').AsString = DOC_NAO_SELECIONADO);
  blnSelecionar := blnSelecionar and (objFieldTmpGar.OldValue <> objFieldTmpGar.NewValue);
  blnSelecionar := blnSelecionar and (objFieldTmpGar.NewValue <> objFieldTmpGarOri.Value);
  IF blnSelecionar THEN
    pSelecionarItem;
end;

procedure TAlterarPrazoGarantia.pcdsDadosTmpGarValidate(
  Sender: TField);
begin
  if Sender.AsInteger <=0 then
  begin
    pMensagemTempoMinimo;
    Abort;
  end
  else if Sender.AsInteger > 999 then
  begin
    pMensagemTempoMaximo;
    Abort;
  end;
end;

procedure TAlterarPrazoGarantia.pLimpar;
begin
  cdsDados.Close;
  strNumDoc := EmptyStr;
  strEspDoc := EmptyStr;
  strCodCli := EmptyStr;
end;

procedure TAlterarPrazoGarantia.pMensagemTempoMaximo;
begin
  fMensagem('Atenção!',
            'O tempo máximo de garantia é de 999 mês.'
              +sLineBreak+'Informe um valor igual ou menor que 999!',
            ['&Ok']);
end;

procedure TAlterarPrazoGarantia.pMensagemTempoMinimo;
begin
  fMensagem('Atenção!',
            'O tempo mínimo de garantia é de 1 mês.'
              +sLineBreak+'Informe um valor igual ou maior que 1!',
            ['&Ok']);
end;

procedure TAlterarPrazoGarantia.pSelecionarItem;
  Var
    blnSomenteMarcar: Boolean;
    lBeforePost: TDataSetNotifyEvent ;
begin
  blnSomenteMarcar := cdsDados.State in [dsEdit, dsInsert];
  lBeforePost := Nil;
  Try
    if Not blnSomenteMarcar then
    begin
      lBeforePost := cdsDados.BeforePost;
      cdsDados.BeforePost := Nil;
      cdsDados.Edit;
    end;

    if Not blnSomenteMarcar then
    begin
      if cdsDados.FieldByName('SELECIONADO').AsString  = DOC_SELECIONADO then
      begin
        cdsDados.FieldByName('SELECIONADO').AsString := DOC_NAO_SELECIONADO;
        Exit;
      end;

      if cdsDados.FieldByName('DET_TMPGAR').AsInteger = cdsDados.FieldByName('TMPGARORI').AsInteger Then
      begin
        cdsDados.Cancel;
        pMensagemOk('Prazo de garantia não alterado!');
        Exit;
      end;
    end;

    cdsDados.FieldByName('SELECIONADO').AsString := DOC_SELECIONADO;

  Finally
    if (cdsDados.State = dsEdit) and (blnSomenteMarcar = False) then
      cdsDados.Post;

    if (Not blnSomenteMarcar) then
      cdsDados.BeforePost := lBeforePost;

  end;
end;

destructor TAlterarPrazoGarantia.Destroy;
begin
  if Assigned(FQryLog) Then
    FreeAndNil(FQryLog);

  if Assigned(FQryUpdate) Then
    FreeAndNil(FQryUpdate);

  if Assigned(cdsDados) then
    FreeAndNil(cdsDados);
  inherited;
end;

function TAlterarPrazoGarantia.fCarregarDocumentoVenda(strNumDoc,
  strEspDoc, strCodCli, strCodEmp: String): Boolean;

begin
  Result := True;
  if cdsDados.Active then
    cdsDados.Close;
  Try
    cdsDados.qryQuery.SQL.Clear;
    cdsDados.qryQuery.SQL.Add(fGetSQLDocumentos);
    cdsDados.qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
    cdsDados.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
    cdsDados.qryQuery.ParamByName('CODCLI').AsString := strCodCli;
    cdsDados.fAbreClient(True,'TAlterarPrazoGarantiaItemVenda.fCarregarDocumentoVenda');
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(e.Message,'TAlterarPrazoGarantia.fCarregarDocumentoVenda');
      if cdsDados.Active then
        cdsDados.Close;
    end;
  End;
end;

end.
