unit untTProcessaBoletosMonitor;

interface

uses System.Classes,System.SysUtils,Forms,untTypesSistema,untFuncoesSimples,
     System.StrUtils,System.IOUtils,Winapi.Windows,Uni,untCadRec,
     untTLockMonitorEnvioBoleto,Data.DB,untBoleto,UniClientDataSet;
Type
  TProcessaBoletosMonitor = class
  private
    objLock: TLock;

    function PermissaoParaImprimirBoleto(ADuplicata: TDataSet): Boolean;
    function ImprimirBoleto(ADuplicata: TDataSet): Boolean;
    procedure ApagarBOLAUT(ADuplicata: String);
    function fRetUltimaAlteracaoCadRec(strNumDup, strParcel, strEspDoc, strCodCli,
                                       strCodEmp: String; intSeqBai: Integer = 0): TDateTime;
  public
    procedure GerarBoletosPendentes;
  end;

implementation

{ TProcessaBoletosMonitor }

procedure TProcessaBoletosMonitor.ApagarBOLAUT(ADuplicata: String);
  Var
    LBolAut: TUniQuery;
begin
  Try
    LBolAut := fCriaQuery(Nil);

    Try
      LBolAut.Close;
      LBolAut.SQL.Clear;
      LBolAut.SQL.Text := 'DELETE FROM BOLAUT WHERE BOL_SEQCTR = :SEQCTR';
      LBolAut.ParamByName('SEQCTR').AsString := ADuplicata;
      LBolAut.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LBolAut);
  End;
end;

function TProcessaBoletosMonitor.fRetUltimaAlteracaoCadRec(strNumDup, strParcel,
  strEspDoc, strCodCli, strCodEmp: String; intSeqBai: Integer): TDateTime;
  Var
    qryLogCtr: TUniQuery;
    strSQL   : String;
Begin
  Result := 0;

  Try
    qryLogCtr := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                          ';
    strSQL := strSQL + '      CTR_DTALOG,               ';
    strSQL := strSQL + '      CTR_HORLOG                ';
    strSQL := strSQL + 'FROM LOGCTR                     ';
    strSQL := strSQL + 'WHERE CTR_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '      CTR_PARCEL = :PARCEL AND  ';
    strSQL := strSQL + '      CTR_ESPDOC = :ESPDOC AND  ';
    strSQL := strSQL + '      CTR_CODCLI = :CODCLI AND  ';
    strSQL := strSQL + '      CTR_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '      CTR_SEQBAI = :SEQBAI      ';
    strSQL := strSQL + 'ORDER BY CTR_DTALOG DESC,       ';
    strSQL := strSQL + '         CTR_HORLOG DESC        ';

    Try
      qryLogCtr.SQL.Text := strSQL;
      qryLogCtr.ParamByName('NUMDUP').AsString  := strNumDup;
      qryLogCtr.ParamByName('PARCEL').AsString  := strParcel;
      qryLogCtr.ParamByName('ESPDOC').AsString  := strEspDoc;
      qryLogCtr.ParamByName('CODCLI').AsString  := strCodCli;
      qryLogCtr.ParamByName('CODEMP').AsString  := strCodEmp;
      qryLogCtr.ParamByName('SEQBAI').AsInteger := intSeqBai;
      qryLogCtr.Open;

      If Not qryLogCtr.IsEmpty Then
        Result := StrtoDateTime(qryLogCtr.FieldByName('CTR_DTALOG').AsString + ' ' +
                                qryLogCtr.FieldByName('CTR_HORLOG').AsString);
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryLogCtr);
  End;
End;

procedure TProcessaBoletosMonitor.GerarBoletosPendentes;
  Var
    LBolAut: TUniQuery;
begin
  Try
    LBolAut := fCriaQuery(Nil);
    objLock := TLock.Create;

    Try
      LBolAut.Close;
      LBolAut.SQL.Clear;
      LBolAut.SQL.Text := 'SELECT                         '+
                          '  BOLAUT.*,                    '+
                          '  CADREC.*,                    '+
                          '  CURRENT_TIMESTAMP AS HRAFIL  '+
                          'FROM                           '+
                          '  BOLAUT                       '+
                          '  JOIN CADREC                  '+
                          '    ON AUTOINCREM = BOL_SEQCTR '+
                          'WHERE BOL_CODEMP = :CODEMP     '+
                          '  AND CTR_DTABAI IS NULL       ';

      LBolAut.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LBolAut.Open;

      If LBolAut.IsEmpty Then
        Exit;

      LBolAut.First;
      While Not LBolAut.Eof Do
      Begin

        If PermissaoParaImprimirBoleto(LBolAut) Then
        Begin
          If ImprimirBoleto(LBolAut) Then
            ApagarBOLAUT(LBolAut.FieldByName('AUTOINCREM').AsString);
        End;

        Application.ProcessMessages;
        objLock.pDestravarTodos;
        LBolAut.Next;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LBolAut);
    objLock.pDestravarTodos;
    FreeAndNil(objLock);
  End;
end;

function TProcessaBoletosMonitor.ImprimirBoleto(ADuplicata: TDataSet): Boolean;
  Var
    objBoleto    : TBoleto;
    qryGenCtr    : TUniQuery;
    cdsBoleto    : TUniClientDataSet;
    objArrDupCtr : TArrDupCtr;

    LEnviouEmail,
    LEnviouSMS,
    LEnviouWpp : Boolean;
Begin
  Result := False;

  Try
    SetLength(objArrDupCtr, 1);
    objArrDupCtr[Length(objArrDupCtr) - 1].strNumDup := ADuplicata.FieldByName('CTR_NUMDUP').AsString;
    objArrDupCtr[Length(objArrDupCtr) - 1].strParcel := ADuplicata.FieldByName('CTR_PARCEL').AsString;
    objArrDupCtr[Length(objArrDupCtr) - 1].strCodEmp := ADuplicata.FieldByName('CTR_CODEMP').AsString;
    objArrDupCtr[Length(objArrDupCtr) - 1].strEspDoc := ADuplicata.FieldByName('CTR_ESPDOC').AsString;
    objArrDupCtr[Length(objArrDupCtr) - 1].strCodCli := ADuplicata.FieldByName('CTR_CODCLI').AsString;
    objArrDupCtr[Length(objArrDupCtr) - 1].strAutoIn := ADuplicata.FieldByName('AUTOINCREM').AsString;

    qryGenCtr := fCriaQuery;

    Try
      qryGenCtr.Close;
      qryGenCtr.SQL.Clear;
      qryGenCtr.SQL.Text := untBoleto.TBoleto.fGetSQLBoletos(False,True);
      qryGenCtr.SQL.Text := StringReplace(qryGenCtr.SQL.Text, 'AUTINC', ADuplicata.FieldByName('AUTOINCREM').AsString, []);
      qryGenCtr.Open;


      objBoleto := TBoleto.Create(Nil, 'CADREC', False);
      cdsBoleto := fCriaClientDatset(qryGenCtr);

      Application.ProcessMessages;
      Result := objBoleto.fImprimir(cdsBoleto,
                                    objArrDupCtr,
                                    cdsBoleto.FieldByName('CTR_BCOBOL').AsString,
                                    True,
                                    True,
                                    False,
                                    LEnviouEmail,
                                    LEnviouSMS,
                                    LEnviouWpp,
                                    True,
                                    False,
                                    cdsBoleto.FieldByName('CTR_CARTEI').AsString,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    False,
                                    True);


    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    If Assigned(cdsBoleto) Then
      FreeAndNil(cdsBoleto);

    If Assigned(objBoleto) Then
      FreeAndNil(objBoleto);

    If Assigned(qryGenCtr) Then
      FreeAndNil(qryGenCtr);
  End;

end;

function TProcessaBoletosMonitor.PermissaoParaImprimirBoleto(ADuplicata: TDataSet): Boolean;
  Var
    LChaveLock: String;
begin
  Result := True;

  Try

    LChaveLock := 'BOLAUT' + ADuplicata.FieldByName('AUTOINCREM').AsString;

    If Not objLock.fLock_Unlock(LChaveLock, True, False) Then
    Begin
      Exit(False);
    End;

    If (fRetUltimaAlteracaoCadRec(ADuplicata.FieldByName('CTR_NUMDUP').AsString,
                                  ADuplicata.FieldByName('CTR_PARCEL').AsString,
                                  ADuplicata.FieldByName('CTR_ESPDOC').AsString,
                                  ADuplicata.FieldByName('CTR_CODCLI').AsString,
                                  ADuplicata.FieldByName('CTR_CODEMP').AsString) > ADuplicata.FieldByName('HRAFIL').AsDateTime) Then
    Begin
      fStartTransaction;
      untCadRec.pGravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                            'GERAÇÃO DE BOLETO ABORTADA - DUPLICATA ALTERADA EM PARALELO',
                            'untTEnvioEmailAutController');
      fCommit;
      Exit(False);
    End;

    LChaveLock :=  'CADREC' +
                   ADuplicata.FieldByName('CTR_NUMDUP').AsString +
                   ADuplicata.FieldByName('CTR_ESPDOC').AsString +
                   ADuplicata.FieldByName('CTR_CODEMP').AsString +
                   ADuplicata.FieldByName('CTR_CODCLI').AsString +
                   ADuplicata.FieldByName('CTR_PARCEL').AsString;

    If Not objLock.fLock_Unlock(LChaveLock, True, False) Then
    Begin
      fStartTransaction;
      untCadRec.pGravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                             'GERAÇÃO DE BOLETO ABORTADA - DUPLICATA EM USO POR OUTRA ESTAÇÃO',
                             'untTEnvioEmailAutController');
      fCommit;
      Exit(False);
    End;


  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

end.
