unit untTLock;

interface

uses Forms, DB, Classes, strUtils, System.SysUtils, untModulo, untUtil,
     {$IF Defined(UNIDAC)}
       Uni, UniSQLMonitor, MemDS, DBAccess
     {$ELSE}
       ZConnection, ZDataset
     {$IFEND}
     ;

Type

  TLock = class(TComponent)
    private
      Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};

      FTravas: TStringList;

      function Lock_Unlock(strNomeTabela: String;
                            blnTrava: Boolean;
                            blnLoopTravamento: Boolean = True;
                            blnHourGlass: Boolean = FALSE;
                            strCon_Id: String = '';
                            blnMostraMsgTravamento: Boolean = True;
                            strOrigem: String = '';
                            blnManual: Boolean = False;
                            blnSeForMesmaConexaoNaoTravar: Boolean = False;
                            blnStartTransaction : Boolean = True;
                            blnStartCommit : Boolean = True;
                            blnIgnoraCntTrava: Boolean = False): Boolean; OverLoad;

      function Lock_Unlock(strNomeTabela: String;
                            blnTrava: Boolean;
                            Var blnTravadoPelaMesmaConexao: Boolean;
                            blnLoopTravamento: Boolean = True;
                            blnHourGlass: Boolean = FALSE;
                            strCon_Id: String = '';
                            blnMostraMsgTravamento: Boolean = True;
                            strOrigem: String = '';
                            blnManual: Boolean = False;
                            blnSeForMesmaConexaoNaoTravar: Boolean = False;
                            blnStartTransaction : Boolean = True;
                            blnStartCommit : Boolean = True;
                            blnIgnoraCntTrava: Boolean = False): Boolean; OverLoad;

      function fGetConnectionID: String;
      function fRetOrigemLock(strNomeTabela: String): String;
      function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False;
                            blnLike: Boolean = True; blnCon_ID: Boolean = False): String;
      procedure pLogarErro(E: Exception);
    public

      Constructor Create; reintroduce;
      Destructor Destroy; override;

      function fLock_Unlock(strChave: String; blnTravar: Boolean;
                            blnLoopTravamento: Boolean = True;
                            blnHourGlass: Boolean = False;
                            strCon_Id: String = '';
                            blnMostraMsgTravamento: Boolean = True;
                            strOrigem: String = '';
                            blnStartTransaction : Boolean = True;
                            blnStartCommit : Boolean = True): Boolean;

      procedure pDestravarTodos(const AblnUsaOrigem: Boolean = False);
      procedure pAdicionaTrava(strChave: String);
  End;

implementation

{ TLock }

constructor TLock.Create;
begin
  Banco := frmModulo.Database;

  FTravas := TStringList.Create;
end;

destructor TLock.Destroy;
begin
  pDestravarTodos;
  FreeAndNil(FTravas);
end;

procedure TLock.pAdicionaTrava(strChave: String);
begin
  FTravas.Add(strChave);
end;

procedure TLock.pDestravarTodos(const AblnUsaOrigem: Boolean = False);
var
  intInd: Integer;
begin
  If FTravas.Count  > 0 Then
  Begin
    For intInd := 0 To FTravas.Count   -1 Do
    Begin
      if AblnUsaOrigem then
        Lock_Unlock(FTravas[intInd], False, False, False, '', True, FTravas[intInd], False, False, True, True, True)
      else
        Lock_Unlock(FTravas[intInd], False, False) ;
    End;
    FTravas.Clear;
  End;
end;

function TLock.fGetConnectionID: String;
  Var
    qryAux:  {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryAux := fCriaQuery(Banco);

  Try

    qryAux.SQL.Add('SELECT CONNECTION_ID()');
    qryAux.Open;

    Result := qryAux.Fields[0].AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TLock.fRetOrigemLock(strNomeTabela: String): String;
  Var
    qryLock:  {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  qryLock := fCriaQuery(Banco);
  With qryLock, SQL Do
  Begin
    Add('SELECT LCK_ORIGEM FROM LCKATC WHERE LCK_CHAACE = :CHAACE');
    ParamByName('CHAACE').AsString := strNomeTabela;
    Open;
    If qryLock.IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('LCK_ORIGEM').AsString;
  End;
  FreeAndNil(qryLock);
End;

function TLock.fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False;
  blnLike: Boolean = True; blnCon_ID: Boolean = False): String;
Var
  qryGen:  {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  strSQL: String;
  strOperador: string;
Begin
  Result := '';
  strNomeTabela := frmModulo.Database.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery(Banco);
  try
    strOperador := IIF(blnLike And strNomeTabela.Contains('%'), 'LIKE', '=');
  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';

  If blnCon_ID Then
    strSQL := strSQL + '  LCK_CON_ID, ';

  If blnSohIP Then
    strSQL := strSQL + '  LCK_NUM_IP '
  Else
      strSQL := strSQL + '  CONCAT(LCK_NUM_IP, " - ", " Operador: ", ' +
        'LCK_CODOPE, "-", OPE_NOMOPE) AS LCK_NUM_IP ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = LCK_CODOPE ';
  strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LCK_CHAACE ' + strOperador + ' :CHAACE ';
  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  If blnCon_ID Then
    Result := qryGen.FieldByName('LCK_CON_ID').AsString
  Else
    Result := qryGen.FieldByName('LCK_NUM_IP').AsString;

  qryGen.Close;
  finally
  FreeAndNil(qryGen);
  end;
End;

function TLock.fLock_Unlock(strChave: String; blnTravar: Boolean;
                            blnLoopTravamento: Boolean = True;
                            blnHourGlass: Boolean = False;
                            strCon_Id: String = '';
                            blnMostraMsgTravamento: Boolean = True;
                            strOrigem: String = '';
                            blnStartTransaction : Boolean = True;
                            blnStartCommit : Boolean = True): Boolean;
var
  intInd: Integer;
begin
  If Not Assigned(Self) Then
    Self := TLock.Create;

  Result := Lock_Unlock(strChave, blnTravar, blnLoopTravamento, blnHourGlass,
                                           strCon_Id, blnMostraMsgTravamento, strOrigem,False,False,
                                           blnStartTransaction,blnStartCommit);

  If Result Then
  Begin
    If blnTravar Then
      FTravas.Add(strChave)
    Else
    Begin
      intInd := FTravas.IndexOf(strChave);
      If intInd >= 0 Then
        FTravas.Delete(intInd);
    End;
  End;
end;

function TLock.Lock_Unlock(strNomeTabela: String;
                      blnTrava: Boolean;
                      blnLoopTravamento: Boolean = True;
                      blnHourGlass: Boolean = FALSE;
                      strCon_Id: String = '';
                      blnMostraMsgTravamento: Boolean = True;
                      strOrigem: String = '';
                      blnManual: Boolean = False;
                      blnSeForMesmaConexaoNaoTravar: Boolean = False;
                      blnStartTransaction : Boolean = True;
                      blnStartCommit : Boolean = True;
                      blnIgnoraCntTrava: Boolean = False): Boolean;
  Var
    blnTravadoPelaMesmaConexao: Boolean;
Begin
  Result := Lock_Unlock(strNomeTabela,
                         blnTrava,
                         blnTravadoPelaMesmaConexao,
                         blnLoopTravamento,
                         blnHourGlass,
                         strCon_Id,
                         blnMostraMsgTravamento,
                         strOrigem,
                         blnManual,
                         blnSeForMesmaConexaoNaoTravar,
                         blnStartTransaction,
                         blnStartCommit,
                         blnIgnoraCntTrava);
End;

function TLock.Lock_Unlock(strNomeTabela: String;
                      blnTrava: Boolean;
                      Var blnTravadoPelaMesmaConexao: Boolean;
                      blnLoopTravamento: Boolean = True;
                      blnHourGlass: Boolean = FALSE;
                      strCon_Id: String = '';
                      blnMostraMsgTravamento: Boolean = True;
                      strOrigem: String = '';
                      blnManual: Boolean = False;
                      blnSeForMesmaConexaoNaoTravar: Boolean = False;
                      blnStartTransaction : Boolean = True;
                      blnStartCommit : Boolean = True;
                      blnIgnoraCntTrava: Boolean = False): Boolean;
  Var
    strSoNomeTabela,
    strLock: String;
    qryLock_Unlock:  {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    blnComitar: Boolean;

  Const
    TEMPO_ESPERA = 3000;

    procedure pAtualizaContador;
    begin
      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_TENTAT = LCK_TENTAT + 1 WHERE LCK_CHAACE = :CHAACE');
      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;
      qryLock_Unlock.ExecSQL;
    end;

    procedure pIncrementaTrava(blnIncrementa: Boolean);
    begin
      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      If blnIncrementa Then
        qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA + 1 WHERE LCK_CHAACE = :CHAACE')
      Else
        qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA - 1 WHERE LCK_CHAACE = :CHAACE');

      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;
      qryLock_Unlock.ExecSQL;
    end;

    function fExecutaLock: Boolean;
    begin

      Result := False;
      If (blnComitar) and blnStartTransaction Then
        frmModulo.Database.StartTransaction;

      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      qryLock_Unlock.SQL.Add(strLock);
      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;

      qryLock_Unlock.ParamByName('DTALCK').AsDate   := Date;
      qryLock_Unlock.ParamByName('HRALCK').AsTime   := Time;
      qryLock_Unlock.ParamByName('CON_ID').AsString := IIF(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);
      qryLock_Unlock.ParamByName('NUM_IP').AsString := VS_IPAddressAsString;
      qryLock_Unlock.ParamByName('MACADD').AsString := VS_MacAddress;
      qryLock_Unlock.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
      qryLock_Unlock.ParamByName('NOMUSU').AsString := VS_UserFromWindows;
      qryLock_Unlock.ParamByName('CODOPE').AsString := '999';
      qryLock_Unlock.ParamByName('ORIGEM').AsString := strOrigem;
      qryLock_Unlock.ParamByName('QTDTRA').AsInteger:= 1;

      Try
        qryLock_Unlock.ExecSQL;
        Result := True;
      Except
        On E: Exception Do
        Begin
          If (Pos('DUPLICADA', UpperCase(E.Message)) > 0) Or
             (Pos('DUPLICATE', UpperCase(E.Message)) > 0) Then
          Begin
            pAtualizaContador;

            If (Not fEmptyStr(strOrigem)) And
               SameText(fRetOrigemLock(strNomeTabela), strOrigem) Then
            Begin
              pIncrementaTrava(True);
              Result := True;
            End;

          End
          Else
            pLogarErro(E);
        End;
      End;

      If (blnComitar) And blnStartCommit Then
        frmModulo.Database.Commit;
    end;

    procedure pGravaLogLock;
    begin
      With qryLock_Unlock Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO LCKATC_LOG (LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_TENTAT, ');
        SQL.Add('  LCK_ORIGEM, LCK_DTALOG, LCK_HRALOG, LCK_TIPLCK, LCK_MACADD, LCK_NOMMAQ, LCK_NOMUSU) ');
        SQL.Add('VALUES (:NUM_IP, :CON_ID, :CHAACE, :CODOPE, :QTDTRA, :ORIGEM, ');
        SQL.Add('        :DTALOG, :HRALOG, :SIGLA, :MACADD, :NOMMAQ, :NOMUSU) ');
        ParamByName('CHAACE').AsString := strNomeTabela;
        ParamByName('DTALOG').AsDate   := Date;
        ParamByName('HRALOG').AsTime   := Time;
        ParamByName('CON_ID').AsString := IIF(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);
        ParamByName('NUM_IP').AsString := GetIPAddressAsString;
        ParamByName('CODOPE').AsString := '999';
        ParamByName('ORIGEM').AsString := strOrigem;
        ParamByName('SIGLA').AsString  := IIF(blnTrava, 'LCK', IIF(blnManual,'LBM','LBA'));
        ParamByName('MACADD').AsString := VS_MacAddress;
        ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
        ParamByName('NOMUSU').AsString := VS_UserFromWindows;
        ParamByName('QTDTRA').AsInteger:= 1;
        ExecSQL;
      End;

    end;

    function fGravaLog: Boolean;
    begin
      Result := (Pos('EXECUTE_', strNomeTabela) <= 0) And
                (Pos('PEDIDOS_PREPARACAO_TE-', strNomeTabela) <= 0) And
                (Pos('IMPORTACAO-', strNomeTabela) <= 0) And
                (Pos('IMPORTA-FULFILLMENT', strNomeTabela) <= 0) And
                (Pos('FATAUT_', strNomeTabela) <= 0) And
                (Pos('TEST_', strNomeTabela) <= 0) And
                (Pos('MONITOR_', strNomeTabela) <= 0) And
                (Pos('UPDATE_', strNomeTabela) <= 0) And
                (Pos('UPDATE_', strNomeTabela) <= 0);
    end;

Begin
  blnTravadoPelaMesmaConexao := False;

  Result := True;

  Try
    strSoNomeTabela := strNomeTabela;

    strNomeTabela := frmModulo.Database.Database + '.' + strNomeTabela;
    qryLock_Unlock := fCriaQuery(Banco);

    blnComitar := False;
    If (Not frmModulo.Database.InTransaction) Or
       (frmModulo.Database.InTransaction And blnStartCommit) And (Not blnStartTransaction) Then
    Begin
      blnComitar := True;
    End;

    If blnTrava Then
    Begin

      strLock := 'INSERT INTO LCKATC (LCK_DTALCK, LCK_HRALCK, LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_ORIGEM, LCK_QTDTRA,LCK_MACADD,LCK_NOMMAQ,LCK_NOMUSU) ' +
                 'VALUES (:DTALCK, :HRALCK, :NUM_IP, :CON_ID, :CHAACE, :CODOPE, :ORIGEM, :QTDTRA,:MACADD,:NOMMAQ,:NOMUSU)';

      With qryLock_Unlock Do
      Begin

        While Not fExecutaLock Do
        Begin

          If (Not blnLoopTravamento) Then
          Begin
            Result := False;
            Break;
          End;

          Sleep(TEMPO_ESPERA);
          Application.ProcessMessages;
        End;

        If Result And fGravaLog Then
          pGravaLogLock;

        Close;
      End;
    End
    Else
    Begin

      If fEmptyStr(strOrigem) Then
        strLock := 'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_CON_ID = :CON_ID'
      Else
      Begin
        pIncrementaTrava(False);
        strLock := 'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE ' + ifThen(blnIgnoraCntTrava, '', 'AND LCK_QTDTRA <= 0') ;
      End;

      With qryLock_Unlock Do
      Begin
        If fGravaLog Then
          pGravaLogLock;

        Close;
        SQL.Clear;
        SQL.Add(strLock);
        ParamByName('CHAACE').AsString := strNomeTabela;

        If fEmptyStr(strOrigem) Then
          ParamByName('CON_ID').AsString := IIF(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);

        ExecSQL;
        Close;
      End;
    End;

    FreeAndNil(qryLock_Unlock);

  Finally
    If blnSeForMesmaConexaoNaoTravar And (Not Result) And
       (fGetHostLock(strSoNomeTabela, False {blnSohIP}, True {blnLike}, True {blnCon_ID}) = fGetConnectionID) Then
    Begin
      blnTravadoPelaMesmaConexao := True;

      Result := True;
    End;

  End;

End;

procedure TLock.pLogarErro(E: Exception);
Var
  LErro: TStringList;
begin
  LErro := TStringList.Create;
  Try
    LErro.Add('Erro: ' + E.Message);
    LErro.SaveToFile('ERRO_INTEGRADOR_SAT.TXT');

    raise Exception.Create(e.Message) ;

  Finally
    FreeAndNil(LErro);
  End;
end;

end.
