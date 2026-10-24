unit untTLockLibCartoes;

interface

uses
  System.Classes, System.StrUtils, System.SysUtils, Data.DB,
  System.Generics.Collections,

  Uni,

  untILibCartoesFactory, untTLibCartoesFuncoes;

type
  TLock = class(TComponent)
    private
      FTravas: TStringList;
      FPrefixosPublicados : TDictionary<String, String>;
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
                            blnStartCommit : Boolean = True;
                            blnManual: Boolean = False;
                            blnIgnoraConId: Boolean = False;
                            blnGravarLog: Boolean = True;
                            blnSeForMesmaConexaoNaoTravar: Boolean = False): Boolean;
      function fDocumentoTravado(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String; stlCadRecLck: TStringList=Nil): Boolean;
      procedure pDestravarTodos;
      procedure pAdicionaTrava(strChave: String);
      function fLocalizaTrava(strChave: String): Boolean;

      procedure DestravarListaDuplicatas(AChaves: TStringList);

      function fRetornaTravas():TStringList;

      function fParseMensagemTrava(const strChave,
        strMensagem: String): String;
      procedure pPublicarTravas(const strTrava: String);
      procedure pRemoverPublicacaoTravas(const strPrefixoTrava : String);
      procedure pPublicarPrefixo(const strPrefixo: String; const strConexao : String);
      procedure pRemoverPublicacaoPrefixo(const strConexao : String);
      procedure pDestravaChave(const strChave : String);

      procedure pDestravaLCKATC(const strPrefixo : String; const strConexao : String);

      class function fVerificaLCKATCNomeParcial(const AstrNomeTrava: String): Boolean;
      class function fVerificaLCKATCNomeParcialRetornaChave(const AstrNomeTrava: String; Var ATravaCompleta: String): Boolean;
  End;

implementation

{ TLock }

constructor TLock.Create;
begin
  FTravas := TStringList.Create;
  FPrefixosPublicados := TDictionary<String, String>.Create;
end;

procedure TLock.DestravarListaDuplicatas(AChaves: TStringList);
  Var
    LDuplicata: String;
begin
  If AChaves.Count = 0 Then
    Exit;

  For LDuplicata In AChaves Do
  Begin
    TLibCartoesFactory.Get.fILock_Unlock(LDuplicata, False, False);

    If FTravas.IndexOf(LDuplicata) >= 0 Then
      FTravas.Delete(FTravas.IndexOf(LDuplicata));
  End;
end;

destructor TLock.Destroy;
begin
  pDestravarTodos;
  FreeAndNil(FPrefixosPublicados);
  FreeAndNil(FTravas);
end;

procedure TLock.pAdicionaTrava(strChave: String);
begin
  FTravas.Add(strChave);
end;

procedure TLock.pDestravaChave(const strChave: String);
  Var
    intIndex : Integer;
begin
  If (Not fLocalizaTrava(strChave)) Then
    Exit;
  intIndex := FTravas.IndexOf(strChave);
  TLibCartoesFactory.Get.fILock_Unlock(FTravas[intIndex], False, False);
  If FTravas.IndexOf(FTravas[intIndex]) >= 0 Then
    FTravas.Delete(intIndex);
end;

procedure TLock.pDestravaLCKATC(const strPrefixo, strConexao: String);
  Var
    qryLckAtc : TUniQuery;
begin
  If TLibCartoesFuncoes.fEmptyStr(strPrefixo) Then
    Exit;

  If Length(strPrefixo) <= 3 Then
    Exit;

  qryLckAtc := TLibCartoesFactory.Get.fICriaQuery;
  Try
    qryLckAtc.SQL.Add('DELETE FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE AND LCK_CON_ID = :CON_ID');
    qryLckAtc.ParamByName('CON_ID').AsString := strConexao;

    qryLckAtc.ParamByName('CHAACE').AsString := qryLckAtc.Connection.Database + '.' + strPrefixo + '%';

    qryLckAtc.ExecSQL;
  Finally
    FreeAndNil(qryLckAtc);
  End;
end;

procedure TLock.pDestravarTodos;
  Var
    intInd: Integer;
    strKey : String;
begin
  If FTravas.Count = 0 Then
    Exit;

  If (FPrefixosPublicados.Count > 0) Then
  Begin
    For strKey in FPrefixosPublicados.Keys Do
    Begin
      pDestravaLCKATC(FPrefixosPublicados.Items[strKey], strKey);
      pRemoverPublicacaoTravas(FPrefixosPublicados.Items[strKey]);
    End;
  End;

  For intInd := 0 To Pred(FTravas.Count) Do
    TLibCartoesFactory.Get.fILock_Unlock(FTravas[intInd], False, False);

  FTravas.Clear;
end;

procedure TLock.pPublicarPrefixo(const strPrefixo: String;
  const strConexao: String);
begin
  FPrefixosPublicados.AddOrSetValue(strConexao, strPrefixo);
end;

procedure TLock.pPublicarTravas(const strTrava: String);
begin
  FTravas.Add(strTrava);
end;

procedure TLock.pRemoverPublicacaoPrefixo(const strConexao: String);
begin
  If Not FPrefixosPublicados.ContainsKey(strConexao) Then
    Exit;
  FPrefixosPublicados.Remove(strConexao);
end;

procedure TLock.pRemoverPublicacaoTravas(const strPrefixoTrava : String);
  Var
    stlNovasTravas : TStringList;
    strPrefixoTravaAtual : String;
    intCnt : Integer;
begin
  stlNovasTravas := TStringList.Create;
  Try
    For intCnt := 0 To Pred(FTravas.Count) Do
    Begin
      strPrefixoTravaAtual := Copy(FTravas.Strings[intCnt], 1, Length(strPrefixoTrava));
      If (strPrefixoTravaAtual <> strPrefixoTrava) Then
        stlNovasTravas.Add(FTravas.Strings[intCnt]);
    End;
    FTravas.CommaText := stlNovasTravas.CommaText;
  Finally
    FreeAndNil(stlNovasTravas);
  End;
end;

function TLock.fLocalizaTrava(strChave: String): Boolean;
begin
  Result := FTravas.IndexOf(strChave) <> -1;
end;

function TLock.fLock_Unlock(strChave: String; blnTravar: Boolean;
                            blnLoopTravamento: Boolean = True;
                            blnHourGlass: Boolean = False;
                            strCon_Id: String = '';
                            blnMostraMsgTravamento: Boolean = True;
                            strOrigem: String = '';
                            blnStartTransaction : Boolean = True;
                            blnStartCommit : Boolean = True;
                            blnManual: Boolean = False;
                            blnIgnoraConId: Boolean = False;
                            blnGravarLog: Boolean = True;
                            blnSeForMesmaConexaoNaoTravar: Boolean = False): Boolean;
var
  intInd: Integer;
begin
  If Not Assigned(Self) Then
    Self := TLock.Create;

  Result := TLibCartoesFactory.Get.fILock_Unlock(strChave, blnTravar, blnLoopTravamento, blnHourGlass,
                                                 strCon_Id, blnMostraMsgTravamento, strOrigem, blnManual, blnSeForMesmaConexaoNaoTravar,
                                                 blnStartTransaction,blnStartCommit, blnIgnoraConId, blnGravarLog);

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

function TLock.fParseMensagemTrava(const strChave, strMensagem: String): String;
var
  intContador          : Integer;
  qryDados             : TUniQuery;
  strNomeCompletoTrava : String;
  arrCamposParse       : Array of String;
  arrValoresParse      : Array of String;
begin
  Result := strMensagem;

  If TLibCartoesFuncoes.fEmptyStr(strChave) Then
    Exit;

  qryDados := TLibCartoesFactory.Get.fICriaQuery;
  Try
    strNomeCompletoTrava := qryDados.Connection.Database + '.' + strChave;

    qryDados.SQL.Text := 'SELECT '
                       + '       LCKATC.* '
                       + '     , EMP_CODEMP '
                       + '     , EMP_NOMEMP '
                       + '     , OPE_NOMOPE '
                       + '  FROM LCKATC '
                       + ' INNER JOIN CADOPE ON CADOPE.OPE_CODOPE = LCKATC.LCK_CODOPE '
                       + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = :CODEMP '
                       + ' WHERE LCK_CHAACE = :CHAACE ';

    qryDados.ParamByName('CODEMP').AsString := TLibCartoesFactory.Get.fIRetEmpresaLogada;
    qryDados.ParamByName('CHAACE').AsString := strNomeCompletoTrava;
    qryDados.Open;

    If qryDados.IsEmpty Then
      Exit;

    arrCamposParse := ['#LCK_NUM_IP',
                       '#LCK_CON_ID',
                       '#LCK_CHAACE',
                       '#LCK_CODOPE',
                       '#LCK_DTALCK',
                       '#LCK_HRALCK',
                       '#LCK_TENTAT',
                       '#LCK_ORIGEM',
                       '#LCK_QTDTRA',
                       '#LCK_MACADD',
                       '#LCK_NOMMAQ',
                       '#LCK_NOMUSU',
                       '#OPE_NOMOPE',
                       '#EMP_CODEMP',
                       '#EMP_NOMEMP'];

    arrValoresParse := [qryDados.FieldByName('LCK_NUM_IP').AsString,
                        qryDados.FieldByName('LCK_CON_ID').AsString,
                        qryDados.FieldByName('LCK_CHAACE').AsString,
                        qryDados.FieldByName('LCK_CODOPE').AsString,
                        DateToStr(qryDados.FieldByName('LCK_DTALCK').AsDateTime),
                        TimeToStr(qryDados.FieldByName('LCK_HRALCK').AsDatetime),
                        IntToStr(qryDados.FieldByName('LCK_TENTAT').AsInteger),
                        qryDados.FieldByName('LCK_ORIGEM').AsString,
                        IntToStr(qryDados.FieldByName('LCK_QTDTRA').AsInteger),
                        qryDados.FieldByName('LCK_MACADD').AsString,
                        qryDados.FieldByName('LCK_NOMMAQ').AsString,
                        qryDados.FieldByName('LCK_NOMUSU').AsString,
                        qryDados.FieldByName('OPE_NOMOPE').AsString,
                        qryDados.FieldByName('EMP_CODEMP').AsString,
                        qryDados.FieldByName('EMP_NOMEMP').AsString];

    For intContador := 0 To Pred(Length(arrCamposParse)) Do
      Result := StringReplace(Result, arrCamposParse[intContador], arrValoresParse[intContador], [rfReplaceAll]);
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TLock.fRetornaTravas: TStringList;
begin
  Result := FTravas;
end;

class function TLock.fVerificaLCKATCNomeParcial(
  const AstrNomeTrava: String): Boolean;
  var
    LqryVerifica: TUniQuery;
begin
  LqryVerifica := TLibCartoesFactory.Get.fICriaQuery;
  try
    LqryVerifica.Close ;
    LqryVerifica.SQL.Clear;
    LqryVerifica.SQL.Add('SELECT LCK_CON_ID FROM LCKATC WHERE LCK_CHAACE LIKE :LCK_CHAACE');
    LqryVerifica.ParamByName('LCK_CHAACE').AsString := '%' + AstrNomeTrava + '%';
    LqryVerifica.Open;

    Result := not LqryVerifica.IsEmpty;
  finally
    LqryVerifica.Close;
    FreeAndNil(LqryVerifica);
  end;
end;

class function TLock.fVerificaLCKATCNomeParcialRetornaChave(
  const AstrNomeTrava: String; var ATravaCompleta: String): Boolean;
  var
    LqryVerifica: TUniQuery;
begin
  LqryVerifica := TLibCartoesFactory.Get.fICriaQuery;
  try
    LqryVerifica.Close;
    LqryVerifica.SQL.Clear;
    LqryVerifica.SQL.Add('SELECT LCK_CHAACE,LCK_CON_ID FROM LCKATC WHERE LCK_CHAACE LIKE :LCK_CHAACE');
    LqryVerifica.ParamByName('LCK_CHAACE').AsString := '%' + AstrNomeTrava + '%';
    LqryVerifica.Open;

    Result := not LqryVerifica.IsEmpty;

    ATravaCompleta := LqryVerifica.FieldByName('LCK_CHAACE').AsString;
    ATravaCompleta := AnsiReplaceStr(ATravaCompleta, LqryVerifica.Connection.Database + '.','');
  finally
    LqryVerifica.Close;
    FreeAndNil(LqryVerifica);
  end ;
end;

function TLock.fDocumentoTravado(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String; stlCadRecLck: TStringList=Nil): Boolean;
  Var
    qryCadRec : TUniQuery;

  function fChaLck(strTab: String; strCli: String): String;
  begin
    Result := strTab + strNumDoc + strEspDoc + strCodEmp + strCli;
  end;

  procedure pProcuraParcelas;
  begin
    With qryCadRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('   CTR_PARCEL ');
      SQL.Add('  FROM CADREC  ');
      SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
      SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
      SQL.Add('    AND CTR_CODEMP = :CODEMP ');
      SQL.Add('    AND CTR_CODCLI = :CODCLI ');
      SQL.Add('  GROUP BY CTR_PARCEL ');
      ParamByName('NUMDUP').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspdoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
    End;
  end;

  function fTemParcelaTravada: Boolean;
    Var
      strChaLck: String;
  begin
    Result := False;
    qryCadRec.First;
    While Not qryCadRec.Eof Do
    Begin

      strChaLck := fChaLck('CADREC', strCodCli) + qryCadRec.FieldByName('CTR_PARCEL').AsString;

      If Not Self.fLock_Unlock(strChaLck, True, False) Then
      Begin
        Result := True;
        If Assigned(stlCadRecLck) Then
          stlCadRecLck.Clear;
        Break;
      End;

      If Assigned(stlCadRecLck) Then
        stlCadRecLck.Add(strChaLck);

      qryCadRec.Next;
    End;
  end;

begin
  Result := False;

  qryCadRec := Nil;

  If Not TLibCartoesFuncoes.fEmptyStr(TLibCartoesFactory.Get.fIGetHostLock(fChaLck(strTabela, ''))) Then
  Begin
    Result := True;
    TLibCartoesFuncoes.fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + TLibCartoesFactory.Get.fIGetHostLock(fChaLck(strTabela, '')), ['&OK']);
  End;

  If (Not Result) Then
  Begin
    qryCadRec := TLibCartoesFactory.Get.fICriaQuery;

    pProcuraParcelas;

    If fTemParcelaTravada Then
    Begin
      Result := True;
      TLibCartoesFuncoes.fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + TLibCartoesFactory.Get.fIGetHostLock(fChaLck('CADREC', strCodCli) + qryCadRec.FieldByName('CTR_PARCEL').AsString), ['&OK']);
    End;

    qryCadRec.Close;
  End;

  If Assigned(qryCadRec) Then
    FreeAndNil(qryCadRec);
end;

end.
