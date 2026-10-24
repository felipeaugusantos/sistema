unit untFechamentoEstoque;

interface

Uses
  Uni, DB, Classes,
  CxProgressBar,
  untZClient;

Type
  TTipoTravaEstoque = (traFechamento, traMovimentacao);

  TFechamentoEstoque = Class
  Private
    FTravou: Boolean;
    FblnContabilidade: Boolean;

    function fSQLUtimoFechamentoEmpresas: String;

    function fSQLUtimos24: String;

    Procedure pSetaAfterScroll;

    Procedure pIncluiFechamento(strCodEmp: String; intAno, intMes: Integer);
    Procedure pExcluiFechamento(strCodEmp: String; intAno, intMes: Integer);

    function fCarregaUltimoFechamentoTodasEmpresasAux(prgProgresso: TCxProgressBar): Boolean;
    function fCarregaUltimos24Aux(prgProgresso: TCxProgressBar): Boolean;

  Public

    cdsUltFecTodas: TZClient;
    cdsUltimos24: TZClient;

    strUltEmpFechada: String;

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor  Destroy; Override;

    function fCarregaUltimoFechamentoTodasEmpresas: Boolean;

    function fCarregaUltimos24: Boolean;

    Procedure pGetUltimoFechamento(strCodEmp: String; Var intAno, intMes: Integer);

    Function fIncluiFechamento(strCodEmp: String; intAno, intMes: Integer): Boolean;
    Function fExcluiFechamento(strCodEmp: String; intAno, intMes: Integer): Boolean;

    Procedure pAfterScrollEmpresa(dataSet: TdataSet);

    Class Function fDataFechamento(strCodEmp: String = ''): TDateTime;

    Class Function fDataDeEntradaPermitida(dtaDtaEnt: TDate; strNomeData: String = 'de entrada'; blnMsgAviso: Boolean = True; strCodEmp: String = ''): Boolean;

    Function fVeSeTravaFechamentoEstoque(traTipoFechamento: TTipoTravaEstoque; dtaDtaEnt: TDateTime; strCodEmp: String = ''): Boolean;

    Procedure pDestravaFechamentoEstoque(traTipoFechamento: TTipoTravaEstoque; strCodEmp: String = '');

    Class Function fTipoFechamentoToString(traTipoFechamento: TTipoTravaEstoque): String;
    property Contabilidade: Boolean read FblnContabilidade write FblnContabilidade ;
  End;


implementation

Uses
  SysUtils,
  StrUtils,
  DateUtils,
  Forms,
  untFuncoesSimples,
  untGravando,
  Contabilidade.OutrosFechamentos.Funcoes;

Const
  STR_MOVIMENTACAO_ESTOQUE = 'MOVIMENTACAO_ESTOQUE_';

constructor TFechamentoEstoque.Create(Owner: TComponent);
Begin
  Inherited Create;
  FblnContabilidade := False ;


  strUltEmpFechada := '';

  cdsUltFecTodas := Nil;
  cdsUltimos24 := Nil;

  FTravou := False;
End;

Destructor TFechamentoEstoque.Destroy;
Begin
  If Assigned(cdsUltFecTodas) Then
    FreeAndNil(cdsUltFecTodas);

  If Assigned(cdsUltimos24) Then
    FreeAndNil(cdsUltimos24);

  inherited Destroy;
End;

function TFechamentoEstoque.fSQLUtimoFechamentoEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   F.*, ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP ';
  strSQL := strSQL + '  FROM                  ';
  strSQL := strSQL + '    CADFEC F            ';

  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = FEC_CODEMP ';

  strSQL := strSQL + '  INNER JOIN (                                 ';
  strSQL := strSQL + '    SELECT FEC_CODEMP, MAX(FEC_ANOMES) AS FEC_ANOMES  ';
  strSQL := strSQL + '    FROM CADFEC                                       ';
  strSQL := strSQL + '    GROUP BY FEC_CODEMP ) AS M ON M.FEC_CODEMP = F.FEC_CODEMP AND M.FEC_ANOMES = F.FEC_ANOMES ';

  Result := strSQL;
End;

function TFechamentoEstoque.fCarregaUltimoFechamentoTodasEmpresas: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fCarregaUltimoFechamentoTodasEmpresasAux, frmGravando, 'Carregando último fechamento de cada empresa, aguarde...');
End;

function TFechamentoEstoque.fCarregaUltimoFechamentoTodasEmpresasAux(prgProgresso: TCxProgressBar): Boolean;
Begin
  If Not Assigned(cdsUltFecTodas) Then
    cdsUltFecTodas := TZClient.Create(Nil, fSQLUtimoFechamentoEmpresas);

  cdsUltFecTodas.AfterScroll := Nil;

  Result := cdsUltFecTodas.fLeDados('TFechamentoEstoque.fCarregaUltimoFechamentoTodasEmpresas');

  If Result Then
  Begin
    cdsUltFecTodas.pAlinhaCampoCentro('FEC_CODEMP');
    cdsUltFecTodas.pAlinhaCampoCentro('FEC_ANOMES');
  End;
End;

function TFechamentoEstoque.fSQLUtimos24: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   F.*,  ';
  strSQL := strSQL + '   OPE_NOMOPE AS NOMOPE, CAST("N" AS CHAR(1)) AS FECCNT ';
  strSQL := strSQL + ' FROM         ';
  strSQL := strSQL + '   CADFEC F   ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = FEC_CODOPE ';

  strSQL := strSQL + ' WHERE        ';
  strSQL := strSQL + '   FEC_CODEMP = :CODEMP ';
  strSQL := strSQL + ' ORDER BY  ';
  strSQL := strSQL + '   FEC_ANOMES DESC LIMIT 24 ';

  Result := strSQL;
End;

function TFechamentoEstoque.fCarregaUltimos24: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fCarregaUltimos24Aux, frmGravando, 'Carregando últimos 24 fechamentos de cada empresa, aguarde...');
End;

function TFechamentoEstoque.fCarregaUltimos24Aux(prgProgresso: TCxProgressBar): Boolean;
  Var
    qryCadEmp,
    qryCadFec: TUniQuery;
    intContador: Integer;
Begin
  qryCadFec := fCriaQuery;
  qryCadFec.SQL.Text := fSQLUtimos24;

  If Not Assigned(cdsUltimos24) Then
    cdsUltimos24 := TZClient.Create(Nil, fSQLUtimos24);

  Result := cdsUltimos24.fLeDados('TFechamentoEstoque.fCarregaUltimos24');

  qryCadEmp := fCriaQuery;
  qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP';
  qryCadEmp.Open;

  prgProgresso.Properties.Max := qryCadEmp.RecordCount;

  While Not qryCadEmp.Eof Do
  Begin
    qryCadFec.Close;
    qryCadFec.ParamByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
    qryCadFec.Open;

    While Not qryCadFec.Eof Do
    Begin
      cdsUltimos24.Append;

      For intContador := 0 To qryCadFec.FieldCount - 1 Do
        cdsUltimos24.Fields[intContador].Value := qryCadFec.Fields[intContador].Value;

      cdsUltimos24.FieldByName('FECCNT').AsString := IfThen(TOutrosFechamentos.fTemFecMes(cdsUltimos24.FieldByName('FEC_CODEMP').AsString, cdsUltimos24.FieldByName('FEC_MESREF').AsInteger, cdsUltimos24.FieldByName('FEC_ANOREF').AsInteger), 'S', 'N') ;
      cdsUltimos24.Post;

      qryCadFec.Next;
    End;

    prgProgresso.Position := prgProgresso.Position + 1;
    Application.ProcessMessages;

    qryCadEmp.Next;
  End;

  FreeAndNil(qryCadFec);

  If Result Then
  Begin
    cdsUltimos24.pAlinhaCampoCentro('FEC_CODEMP');
    cdsUltimos24.pAlinhaCampoCentro('FEC_ANOMES');
    cdsUltimos24.pAlinhaCampoCentro('FEC_CODOPE');
    cdsUltimos24.pAlinhaCampoCentro('FEC_DTAFEC');
    cdsUltimos24.pAlinhaCampoCentro('FEC_HORFEC');
  End;

  pSetaAfterScroll;
End;

Procedure TFechamentoEstoque.pAfterScrollEmpresa(dataSet: TdataSet);
Begin
  If Assigned(cdsUltimos24) And cdsUltimos24.Active Then
  Begin
    If dataSet.IsEmpty Then
      cdsUltimos24.Filter   := 'FEC_CODEMP = ' + QuotedStr('')
    Else
      cdsUltimos24.Filter   := 'FEC_CODEMP = ' + QuotedStr(dataSet.FieldByName('FEC_CODEMP').AsString);

    cdsUltimos24.Filtered := True;
  End;
End;

Procedure TFechamentoEstoque.pSetaAfterScroll;
Begin
  if FblnContabilidade then
    Exit ;

  cdsUltFecTodas.AfterScroll := pAfterScrollEmpresa;

  If Not cdsUltFecTodas.IsEmpty Then
    pAfterScrollEmpresa(cdsUltFecTodas);
End;

Procedure TFechamentoEstoque.pGetUltimoFechamento(strCodEmp: String; Var intAno, intMes: Integer);
  Var
    qryCadFec: TUniQuery;
begin
  intAno := 0;
  intMes := 0;

  qryCadFec := fCriaQuery;
  qryCadFec.SQL.Text := 'SELECT F.FEC_ANOREF, F.FEC_MESREF FROM CADFEC F WHERE F.FEC_CODEMP = :CODEMP AND F.FEC_ANOMES = ' +
                        '(SELECT MAX(M.FEC_ANOMES) FROM CADFEC M WHERE M.FEC_CODEMP = F.FEC_CODEMP)';
  qryCadFec.ParamByName('CODEMP').AsString := strCodEmp;
  qryCadFec.Open;

  If Not qryCadFec.IsEmpty Then
  Begin
    intAno := qryCadFec.FieldByName('FEC_ANOREF').AsInteger;
    intMes := qryCadFec.FieldByName('FEC_MESREF').AsInteger;
  End;

  FreeAndNil(qryCadFec);
End;

Procedure TFechamentoEstoque.pIncluiFechamento(strCodEmp: String; intAno, intMes: Integer);
  Var
    qryCadFec: TUniQuery;
    strAnoMes,
    strSQL: String;
    dtaDtaRef: TDateTime;
Begin
  dtaDtaRef := EncodeDate(intAno, intMes, 1);
  strAnoMes := FormatDateTime('YYYY/MM', dtaDtaRef);

  qryCadFec := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO CADFEC ';
  strSQL := strSQL + ' (AUTOINCREM, FEC_CODEMP, FEC_CODOPE, FEC_DTAFEC, FEC_HORFEC, FEC_MESREF, FEC_ANOREF, FEC_ANOMES, FEC_ARQGER) VALUES ';
  strSQL := strSQL + ' (:AUTINC, :CODEMP, :CODOPE, :DTAFEC, :HORFEC, :MESREF, :ANOREF, :ANOMES, "N")';

  qryCadFec.SQL.Text := strSQL;

  qryCadFec.ParamByName('AUTINC').AsString    := fRetAutoIncrem('CADFEC', VS_strCodEmp);
  qryCadFec.ParamByName('CODOPE').AsString    := strLoginUsuarioLogado;
  qryCadFec.ParamByName('HORFEC').AsTime      := fTime();
  qryCadFec.ParamByName('DTAFEC').AsDateTime  := VS_Date;

  qryCadFec.ParamByName('CODEMP').AsString  := strCodEmp;
  qryCadFec.ParamByName('ANOREF').AsInteger := intAno;
  qryCadFec.ParamByName('MESREF').AsInteger := intMes;
  qryCadFec.ParamByName('ANOMES').AsString  := strAnoMes;

  qryCadFec.ExecSQL;

  FreeAndNil(qryCadFec);
End;

Function TFechamentoEstoque.fIncluiFechamento(strCodEmp: String; intAno, intMes: Integer): Boolean;
  Var
    intAnoAnt, intMesAnt: Integer;
    dtaTeste, dtaFecha: TDate;
Begin
  Try
    Result := False;

    If fVeSeTravaFechamentoEstoque(traFechamento, 0, strCodEmp) Then
    Begin

      Try
        if not FblnContabilidade then
        begin
          pGetUltimoFechamento(strCodEmp, intAnoAnt, intMesAnt);

          If intAnoAnt > 0 Then
          Begin
            dtaTeste := EncodeDate(intAnoAnt, intMesAnt, 1);
            dtaTeste := IncMonth(dtaTeste, 1);

            dtaFecha := EncodeDate(intAno, intMes, 1);

            If dtaFecha <> dtaTeste Then
            Begin
              pMensagemOk('O fechamento sugerido não é o mês correto que deve ser fechado!');
              Exit;
            End;

          End;
        end ;

        fStartTransaction;

        pIncluiFechamento(strCodEmp, intAno, intMes);

        fCommit;

        Result := True;

        strUltEmpFechada := strCodEmp;

      Except

        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TFechamentoEstoque.fIncluiFechamento');
        End;

      End;

    End Else
    Begin
      Result := False;
    End;

  Finally
    pDestravaFechamentoEstoque(traFechamento, strCodEmp);
  End;
End;

Procedure TFechamentoEstoque.pExcluiFechamento(strCodEmp: String; intAno, intMes: Integer);
  Var
    qryCadFec: TUniQuery;
    strSQL: String;
Begin
  qryCadFec := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO DELFEC ';
  strSQL := strSQL + '  (AUTOINCREM, FEC_CODEMP, FEC_CODOPE, FEC_DTAFEC, FEC_HORFEC, FEC_MESREF, FEC_ANOREF, FEC_ANOMES, FEC_OPEDEL, FEC_HORDEL, FEC_DTADEL, FEC_ARQGER) ';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   :AUTINC, FEC_CODEMP, FEC_CODOPE, FEC_DTAFEC, FEC_HORFEC, FEC_MESREF, FEC_ANOREF, FEC_ANOMES, :OPEDEL, :HORDEL, :DTADEL, FEC_ARQGER ';
  strSQL := strSQL + ' FROM CADFEC ';
  strSQL := strSQL + ' WHERE FEC_CODEMP = :CODEMP AND FEC_MESREF = :MESREF AND FEC_ANOREF = :ANOREF ';

  qryCadFec.SQL.Text := strSQL;

  qryCadFec.ParamByName('CODEMP').AsString  := strCodEmp;
  qryCadFec.ParamByName('ANOREF').AsInteger := intAno;
  qryCadFec.ParamByName('MESREF').AsInteger := intMes;

  qryCadFec.ParamByName('AUTINC').AsString  := fRetAutoIncrem('DELFEC', VS_strCodEmp);
  qryCadFec.ParamByName('OPEDEL').AsString  := strLoginUsuarioLogado;
  qryCadFec.ParamByName('HORDEL').AsTime    := fTime();
  qryCadFec.ParamByName('DTADEL').AsDate    := VS_Date;

  qryCadFec.ExecSQL;

  qryCadFec.Close;

  strSQL := '';
  strSQL := strSQL + ' DELETE FROM CADFEC ';
  strSQL := strSQL + ' WHERE FEC_CODEMP = :CODEMP AND FEC_MESREF = :MESREF AND FEC_ANOREF = :ANOREF ';

  qryCadFec.SQL.Text := strSQL;

  qryCadFec.ParamByName('CODEMP').AsString  := strCodEmp;
  qryCadFec.ParamByName('ANOREF').AsInteger := intAno;
  qryCadFec.ParamByName('MESREF').AsInteger := intMes;

  qryCadFec.ExecSQL;

  FreeAndNil(qryCadFec);
End;

Class Function TFechamentoEstoque.fTipoFechamentoToString(traTipoFechamento: TTipoTravaEstoque): String;
Begin
  Case traTipoFechamento Of
    traFechamento: Result := 'FECHAMENTO';
    else           Result := 'MOVIMENTACAO';
  End;
End;

Function TFechamentoEstoque.fVeSeTravaFechamentoEstoque(traTipoFechamento: TTipoTravaEstoque; dtaDtaEnt: TDateTime; strCodEmp: String = ''): Boolean;
Begin
  FTravou := False;
  Result  := True;
                                                                                 // SE É ANTERIOR AO MES ATUAL
  If (fCfgSis('UTIFEC', varBoolean)) and (traTipoFechamento = traFechamento) Or (dtaDtaEnt = 0) Or (StartOfTheMonth(dtaDtaEnt) < StartOfTheMonth(VS_Date)) Then
  Begin

    If strCodEmp.IsEmpty Then
      strCodEmp := VS_strCodEmp;

    Result := fLock_Unlock(STR_MOVIMENTACAO_ESTOQUE + strCodEmp,
                           True,
                           False,
                           False, {blnHourGlass: Boolean = FALSE;}
                           '',    {strCon_Id: String = '';}
                           True,  {blnMostraMsgTravamento: Boolean = True;}
                           fTipoFechamentoToString(traTipoFechamento));

    If Result Then
    Begin
      FTravou := True;

      If (traTipoFechamento = traMovimentacao) And (dtaDtaEnt <> 0) And (Not fDataDeEntradaPermitida(dtaDtaEnt)) Then
      Begin
        Result := False;
        pDestravaFechamentoEstoque(traTipoFechamento, strCodEmp);
      End;


    End Else
      pMensagemOk('O fechamento dessa empresa ou uma movimentação de estoque já está sendo feito em outra estação: ' + fGetHostLock(STR_MOVIMENTACAO_ESTOQUE + strCodEmp));

  End;
End;

Procedure TFechamentoEstoque.pDestravaFechamentoEstoque(traTipoFechamento: TTipoTravaEstoque; strCodEmp: String = '');
Begin
  If FTravou Then
  Begin

    If strCodEmp.IsEmpty Then
      strCodEmp := VS_strCodEmp;

    If fLock_Unlock(STR_MOVIMENTACAO_ESTOQUE + strCodEmp,
                 False,
                 False,
                 False, {blnHourGlass: Boolean = FALSE;}
                 '',    {strCon_Id: String = '';}
                 True,  {blnMostraMsgTravamento: Boolean = True;}
                 fTipoFechamentoToString(traTipoFechamento)) Then
     FTravou := False;

  End;
End;

Function TFechamentoEstoque.fExcluiFechamento(strCodEmp: String; intAno, intMes: Integer): Boolean;
  Var
    intAnoAnt, intMesAnt: Integer;
    dtaTeste, dtaFecha: TDate;
Begin
  Try
    Result := False;

    If fVeSeTravaFechamentoEstoque(traFechamento, 0, strCodEmp) Then
    Begin

      Try
        if not FblnContabilidade then
        begin
          pGetUltimoFechamento(strCodEmp, intAnoAnt, intMesAnt);

          If intAnoAnt > 0 Then
          Begin
            dtaTeste := EncodeDate(intAnoAnt, intMesAnt, 1);

            dtaFecha := EncodeDate(intAno, intMes, 1);

            If dtaFecha <> dtaTeste Then
            Begin
              pMensagemOk('O fechamento sugerido não é o último fechamento da empresa!');
              Exit;
            End;

          End;

        End;

        fStartTransaction;

        pExcluiFechamento(strCodEmp, intAno, intMes);

        fCommit;

        Result := True;

        strUltEmpFechada := strCodEmp;

      Except

        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TFechamentoEstoque.fExcluiFechamento');
        End;

      End;

    End Else
    Begin
      Result := False;
    End;

  Finally
    pDestravaFechamentoEstoque(traFechamento, strCodEmp);
  End;

End;

Class Function TFechamentoEstoque.fDataDeEntradaPermitida(dtaDtaEnt: TDate; strNomeData: String = 'de entrada'; blnMsgAviso: Boolean = True; strCodEmp: String = ''): Boolean;
  Var
    dtaDtaRef: TDate;
Begin
  Try
    if not fCfgSis('UTIFEC', varBoolean) then
      Exit(True);

    dtaDtaRef := fDataFechamento(strCodEmp);

    Result := dtaDtaEnt > dtaDtaRef;

    If (Not Result) And blnMsgAviso Then
       pMensagemOk('A data ' + strNomeData + ' deve ser maior que a do último fechamento de estoque (' + FormatDateTime('DD/MM/YYYY', dtaDtaRef) + ')!');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFechamentoEstoque.fDataDeEntradaPermitida]');
    End;
  End;
End;

Class Function TFechamentoEstoque.fDataFechamento(strCodEmp: String = ''): TDateTime;
  Var
    qryCadFec: TUniQuery;
    intAno, intMes: Integer;
    dtaDtaRef: TDate;
Begin
  Try
    If strCodEmp.IsEmpty Then
      strCodEmp := VS_strCodEmp;

    qryCadFec := fCriaQuery;
    qryCadFec.SQL.Text := 'SELECT IFNULL(MAX(FEC_ANOMES), "") AS ANOMES FROM CADFEC WHERE FEC_CODEMP = :CODEMP';
    qryCadFec.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadFec.Open;

    If qryCadFec.IsEmpty Or fEmptyStr(qryCadFec.FieldByName('ANOMES').AsString) Then
    Begin
      Result := 0
    End Else
    Begin
      intAno := StrToIntDef(LeftStr(qryCadFec.FieldByName('ANOMES').AsString, 4), 0);
      intMes := StrToIntDef(RightStr(qryCadFec.FieldByName('ANOMES').AsString, 2), 0);

      dtaDtaRef := EncodeDate(intAno, intMes, 1);
      dtaDtaRef := EndOfTheMonth(dtaDtaRef);

      Result := dtaDtaRef;

    End;

    FreeAndNil(qryCadFec);

  Except
    On E: Exception Do
    Begin
      Result := VS_Date;
      pMensagensErro(E.Message, '[TFechamentoEstoque.fDataFechamento]');
    End;
  End;
End;


end.
