unit untModuloReplicacaoLibFuncoes;

interface

uses
  System.SysUtils, System.Classes, DASQLMonitor, UniSQLMonitor,
  Uni, StrUtils, DBAccess, CRAccess, DBMonitorClient, RegularExpressions,
  CLRClasses, MyCallUni, CRParser, MyClassesUni,
  MyParserUni, Data.DB;

type
  TfrmModuloReplicacaoLibFuncoes = class(TDataModule)
    sqlMonitor: TUniSQLMonitor;
    procedure sqlMonitorSQL(Sender: TObject; Text: string; Flag: TDATraceFlag);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ParseSQLCitel(const SQL: string; Params: TObject): string;
  function ParseSQL(const SQL: string): String;
  procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent; SQL: string; Params: TDAParams; Caption: string);

var
  frmModuloReplicacaoLibFuncoes: TfrmModuloReplicacaoLibFuncoes;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses
  untFuncoesGen, untConstantes, System.Generics.Collections, Forms, UniClientDataSet;

Const
   {**************************************}
   {* MATRIZ PARA COMANDOS A SEREM GRAV. *}
   {***********************************AF*}
   arrRep1: Array[0..4] Of String = ('INSERT', 'REPLACE', 'DELETE FROM', 'UPDATE', 'SET FOREIGN_KEY_CHECKS');
   arrRep2: Array[0..4] Of String = (' INTO ', ' INTO ' , ''           , ' SET ' , ''                      );

Var
  VS_strTabelaErro: String;
  cdsTabNRE: TUniClientDataSet;
  FDicTabelaReplica: TDictionary<String, Boolean>;
  FMREWSTabelaReplica: TMultiReadExclusiveWriteSynchronizer;

function fRetornaNomeTabela(strString: String): String;
  Var
    strTmp     : String;
    intPosicao : Integer;
    intContador: Integer;
Begin
  Result     := '';
  intPosicao := 0;

  strString := AnsiUpperCase(Trim(strString));

  If      LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'INTO ', '');
  End;

  If (intPosicao > 0) Then
  Begin
    strTmp := AnsiReplaceStr(strTmp,'(', ' ');
    strTmp := AnsiReplaceStr(strTmp,')', ' ');
    strTmp := AnsiReplaceStr(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;
End;

function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
begin
  Result := True;

  {***************************************************}
  {* NÃO REPLICA A TABNRE!!!!                        *}
  {** 09/06/2008 - 09:54 **************************MV*}
  {** 09/06/2009 - 17:47 **************************JB*}
  {** 13/02/2013 - ********************************JU*}
  If (strNomTabela = 'TABNRE')         Or
     (strNomTabela = 'LOGREP')         Or
     (strNomTabela = 'USUREP')         Or
     (strNomTabela = 'LOGERR')         Or
     (strNomTabela = 'LCKATC')         Or
     (strNomTabela = 'TAGDIR')         Or
     (strNomTabela = 'LOGSQL')         Or
     (strNomTabela = 'CADBCO')         Or
     (strNomTabela = 'INFSIS')         Or
     (strNomTabela = 'PROINC')         Or
     (strNomTabela = 'PROCOD')         Or
     (strNomTabela = 'DICSIS')         Or
     (strNomTabela = 'NFE_NFEPRINTER') Or
     (strNomTabela = 'NFE_TEMPO')      Or
     (strNomTabela = 'NFE_LOCAL')      Or
     (strNomTabela = 'CONDET')         Or
     (strNomTabela = 'TRANSACOES')     Then
  Begin
    Result := False;
  End;
end;

procedure TfrmModuloReplicacaoLibFuncoes.DataModuleCreate(Sender: TObject);
begin
  ShowDebugFormProc := ShowDebugForm;
end;

procedure TfrmModuloReplicacaoLibFuncoes.sqlMonitorSQL(Sender: TObject; Text: string;
  Flag: TDATraceFlag);
  Var
    strNomTab: String;
begin

  Text := AnsiReplaceText(Text, #13#10, ' ');
  Text := AnsiReplaceText(Text, #10, ' ');

  If (Flag <> tfError) Then
  Begin
    strNomTab := fRetornaNomeTabela(Text);

    If Not fEmptyStr(strNomTab) And
           fTabelaPermiteReplicarSempre(strNomTab) Then
    Begin
      VS_strTabelaErro := strNomTab;
    End;
  End;
end;

function fGravaLogBco(strComand: String): Boolean;
  Var
    qryLogBco: TUniQuery;
Begin

  Try
    Result := True;

    qryLogBco := fCriaQuery(Nil);

    qryLogBco.Close;
    qryLogBco.SQL.Clear;
    qryLogBco.SQL.Add('SELECT * FROM LOGBCO LIMIT 0');
    qryLogBco.Open;

    With qryLogBco Do
    Begin
      Insert;
      FieldByName('LOG_DTACAD').AsDateTime := VS_Date;
      FieldByName('LOG_HRACAD').AsDateTime := fTime();
      FieldByName('LOG_COMAND').AsString   := strComand;

      If FindField('LOG_CODOPE') <> Nil Then
        FieldByName('LOG_CODOPE').AsString := strUsuarioLogado;

      Post;
    End;

    qryLogBco.Close;
    FreeAndNil(qryLogBco);

  Except
    On E: Exception Do
    Begin
      Result := False;
    //  pGravarErro(True,'[GRAVALOGBCO] - ' + E.message);
    //  fMensagem('','Erro ao tentar gravar LogBco!!!',['&OK']);
      FreeAndNil(qryLogBco);
    End;
  End;
End;

function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;
  Var
    intCont  : Integer;
    intSize  : Integer;
    intRecno : Integer;
begin

  Result := TUniClientDataSet.Create(AOwner);

  For intCont := 0 To qryOrigem.Fields.Count -1 Do
  Begin
    intSize := qryOrigem.Fields[intCont].Size;
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryOrigem.Fields[intCont].FieldName;
      DataType := qryOrigem.Fields[intCont].DataType;
      Size     := intSize;
      Required := False;
    End;
  End;

  Result.CreateDataSet;
  Result.Open;

  Result.LogChanges := False;

  If blnVazio Then
    Exit;

  With qryOrigem Do
  Begin
    intRecno := RecNo;
    DisableControls;

    If Not blnRegistroAtual Then
      First;

    While (Not Eof) Or blnRegistroAtual Do
    Begin
      Result.Append;

      For intCont := 0 To Fields.Count -1 Do
        Result.Fields[intCont].Value := Fields[intCont].Value;

      Result.Post;

      If blnRegistroAtual Then
        Break;

      Next;
    End;
    RecNo := intRecno;
    EnableControls;
  End;

end;

procedure pCarregaNre(ARefresh: Boolean = False);
  Var
   qryTabNRE: TUniQuery;
begin
  If ARefresh And Assigned(cdsTabNRE) Then
    FreeAndNil(cdsTabNRE);

  If (Not Assigned(cdsTabNRE)) Then
  Begin
    qryTabNRE := fCriaQuery(Nil);
    Try
      qryTabNRE.SQL.Add('SELECT * FROM TABNRE');
      qryTabNRE.Open;

      If (qryTabNRE.IsEmpty) Or (Not qryTabNRE.Active) Then
      Begin
        TFinalizarAutcomMonitor.Monitorar;
        qryTabNRE.Close;
        FreeAndNil(qryTabNRE);
        fMensagem('','Tabela TABNRE vazia! Verifique!',['&OK']);
        Application.Terminate;
        Exit;
      End;

      cdsTabNRE := fCriaClientDatset(qryTabNRE);

      qryTabNRE.Close;
    Finally
      FreeAndNil(qryTabNRE);
    End;
  End;
end;

{**************************************}
{* VERIFICA SE TABELA REPLICA OU NÃO  *}
{***********************************AF*}
function fTabelaReplica(strNomTabela: String): Boolean;
Begin
  FMREWSTabelaReplica.BeginWrite;
  Try
    Try
      If FDicTabelaReplica.ContainsKey(strNomTabela) Then
        Exit(FDicTabelaReplica[strNomTabela]);

      Result := fTabelaPermiteReplicarSempre(strNomTabela);
      FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);

      If Not Result Then
      Begin
        FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);
        Exit;
      End;

      pCarregaNre;

//      If Not blnTransferindoCodigo Then
      Begin
        cdsTabNRE.First;
        while not cdsTabNRE.Eof do
        Begin

          {**************************************}
          {* SE FOI COLOCADO NO FIM O %         *}
          {***********************************AF*}
          If Pos('%', Trim(cdsTabNRE.Fields[0].AsString)) > 0 Then
          Begin

            If LeftStr(Trim(AnsiUpperCase(strNomTabela)), Length(Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString))) - 1) = LeftStr(Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString)), Length(Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString))) - 1) Then
            Begin
              Result := False;
              FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);
              Exit;
            End;

          End
          {**************************************}
          {* SE NÃO FOI COLOCADO O %            *}
          {***********************************AF*}
          Else
          Begin

            {**************************************}
            {* SE O NOME DA TABELA FOR O MESMO DA *}
            {* CONFIGURAÇÃO ENTÃO NÃO REPLICA     *}
            {***********************************AF*}
            If Trim(AnsiUpperCase(strNomTabela)) = Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString)) Then
            Begin
              Result := False;
              FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);
              Exit;
            End;

          End;

          cdsTabNRE.Next;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise;
      End;
    End;
  Finally
    FMREWSTabelaReplica.EndWrite;
  End;
End;

function fConfiguracaoPermiteReplicar(strCodCfg: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT CFG_PERREP FROM CFGAUX WHERE CFG_CODCFG  = "' + strCodCfg + '"');
    qryGen.Open;
    Result := qryGen.FieldByName('CFG_PERREP').AsString = 'S';
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fExtractBetweenTags(const Value, TagI, TagF: String): String;
var
  regEx: TRegEx;
begin
  regEx := TRegEx.Create(Format('%s.+?%s', [TagI.Replace('/', '\/'),
    TagF.Replace('/', '\/')]));
  Result := regEx.Match(Value).Value.Replace(TagI, '').Replace(TagF, '');
end;

function fExtrairCodigoConfiguracao(ASQL: String): String;
Var
  LVal: String;
begin
  Result := EmptyStr;
  ASQL := UpperCase(ASQL);
  Repeat
    LVal := fExtractBetweenTags(ASQL, '''', '''');
    If LVal.StartsWith('CFG_') Then
      Exit(LVal);
    ASQL := Trim(Copy(ASQL, Pos(LVal, ASQL) + Length(LVal) + 1, Length(ASQL)));
    If ASQL = EmptyStr Then
      Break;
  Until False;
end;

function fPermiteReplicarCfgSis(ASQL: String): Boolean;
begin
  If Not fRetornaNomeTabela(ASQL).Equals('CFGSIS') Then
    Exit(False);
  If fTabelaReplica('CFGSIS') Then
    Exit(True);
  If fConfiguracaoPermiteReplicar(fExtrairCodigoConfiguracao(ASQL)) Then
    Exit(True);
  Result := False;
end;

function fGetConnectionID: String;
  Var
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add('SELECT CONNECTION_ID()');
      qryAux.Open;

      Result := qryAux.Fields[0].AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  Except
    //
  End;
end;

procedure pCarregaVariaveisControleLogRep;

  function fCampoExiste(const strTabela, strCampo: String): Boolean;
    Var
      qryAux: TUniQuery;
  begin
    Result := False;
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.SQL.Add('DESC ' + strTabela);
      qryAux.Open;
      qryAux.First;

      While (Not qryAux.Eof) Do
      Begin
        If qryAux.FieldByName('Field').AsString = strCampo Then
        Begin
          Result := True;
          Break;
        End;

        qryAux.Next;
      End;

      qryAux.Close;
    Finally
      FreeAndNil(qryAux);
    End;
  end;

begin
  If (VS_ConnectionID.IsEmpty) Then
    VS_ConnectionID := fGetConnectionID();

  If (VS_GravaUsuRep.IsEmpty) Then
    VS_GravaUsuRep := 'S'; //PASSIVO DE CONFIGURAÇÃO CASO ALGUM DIA QUISER FORÇAR A GRAVAÇÃO

  If (VS_LogRepConId.IsEmpty) Then
  Begin
    If fCampoExiste('LOGREP', 'LOG_CON_ID') Then
      VS_LogRepConId := 'S'
    Else
      VS_LogRepConId := 'N'
  End;

  If (VS_GravaUsuRep = 'S') And (VS_LogRepConId = 'S') Then
  Begin
    VS_GravaUsuRep := 'N';
  End;

  If (VS_UsuRepConId.IsEmpty) Then
  Begin
    If fCampoExiste('USUREP', 'LOG_CON_ID') Then
      VS_UsuRepConId := 'S'
    Else
      VS_UsuRepConId := 'N'
  End;

  If (VS_LogRepIdTra.IsEmpty) Then
  Begin
    If fCampoExiste('LOGREP', 'LOG_IDTRAN') Then
      VS_LogRepIdTra := 'S'
    Else
      VS_LogRepIdTra := 'N'
  End;

  If (VS_LogRepCodOp.IsEmpty) Then
  Begin
    If fCampoExiste('LOGREP', 'LOG_CODOPE') Then
      VS_LogRepCodOp := 'S'
    Else
      VS_LogRepCodOp := 'N'
  End;
end;

function fGravaUsuRep: Boolean;
begin
  pCarregaVariaveisControleLogRep;

  Result := (VS_GravaUsuRep = 'S');
end;

function fGravaInfUsuarioReplicacao(intSeqReplicacao: LongInt): Boolean;
  Var
    qryUsu: TUniQuery;
    strSql: string;

  function fGravaConID: Boolean;
  begin
    Result := (VS_UsuRepConId = 'S') And (Not fEmptyStr(VS_ConnectionID));
  end;

begin
  Result := True;

  If (Not fGravaUsuRep) Then
    Exit;

  Try
    qryUsu := fCriaQuery(Nil);

    strSql := '';
    strSql := strSql +  'INSERT INTO USUREP (';
    strSql := strSql +  '  LOG_SEQREP, ';
    strSql := strSql +  '  LOG_NOMMAQ, ';
    strSql := strSql +  '  LOG_NOMUSU, ';
    strSql := strSql +  '  LOG_NUM_IP, ';
    If (fGravaConID) Then
     strSql := strSql + '  LOG_CON_ID, ';
    strSql := strSql +  '  LOG_MACADD) ';
    strSql := strSql +  'VALUES (      ';
    strSql := strSql +  '  :SEQREP,    ';
    strSql := strSql +  '  :NOMMAQ,    ';
    strSql := strSql +  '  :NOMUSU,    ';
    strSql := strSql +  '  :NUM_IP,    ';
    If (fGravaConID) Then
     strSql := strSql + '  :CON_ID,    ';
    strSql := strSql +  '  :MACADD)    ';

    With qryUsu, SQL Do
    Begin
      Add(strSql);

      ParamByName('SEQREP').Value := intSeqReplicacao;
      ParamByName('NOMMAQ').Value := VS_ComputerNetName;
      ParamByName('NOMUSU').Value := VS_UserFromWindows;
      ParamByName('NUM_IP').Value := VS_IPAddressAsString;
      ParamByName('MACADD').Value := VS_MacAddress;
      If (fGravaConID) Then
        ParamByName('CON_ID').AsString := VS_ConnectionID;

      ExecSql;
    End;

  Finally
    If Assigned(qryUsu) Then
      FreeAndNil(qryUsu);
  End;

end;

function fGetUsuarioLogado: String;
begin
  Result := strUsuarioLogado;
end;

{**************************************}
{* GERA O LOG DE REPLICAÇÃO           *}
{***********************************AF*}
function fGravaLogRep(strComand, strTabela, strCarreg: String): Boolean;
Var
  qryLogRep: TUniQuery;
  dtaDtaSis : TDateTime;
  dtaHraSis : TDateTime;

  function fGravaLogRepConId: Boolean;
  begin
    Result := (VS_LogRepConId = 'S') And (VS_ConnectionID <> '');
  end;

  function fGravaTabelasFilhasLogRep: Boolean;
  begin
    Result := ((VS_GravaUsuRep = 'S') And (VS_ConnectionID <> ''));
  end;

  procedure pCarregaVariaveisControle;
  begin
    If VS_ConnectionID.IsEmpty Or
       VS_GravaUsuRep.IsEmpty  Or
       VS_LogRepIdTra.IsEmpty  Or
       VS_LogRepConId.IsEmpty  Or
       VS_LogRepCodOp.IsEmpty  Or
       VS_UsuRepConId.IsEmpty Then
     Begin
       pCarregaVariaveisControleLogRep;
     End;
  end;

Begin
  pCarregaVariaveisControle;

  Try
    qryLogRep := fCriaQuery(Nil);
    Try
      dtaDtaSis := VS_Date;
      dtaHraSis := fTime();

      If fGravaTabelasFilhasLogRep Then
      Begin
        qryLogRep.SQL.Text := 'SELECT * FROM LOGREP WHERE FALSE';
        qryLogRep.Open;

        qryLogRep.Insert;

        If (fGravaLogRepConId) Then
          qryLogRep.FieldByName('LOG_CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepCodOp = 'S') And (Not fEmptyStr(fGetUsuarioLogado)) Then
          qryLogRep.FieldByName('LOG_CODOPE').AsString := fGetUsuarioLogado;

        qryLogRep.FieldByName('LOG_DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.FieldByName('LOG_HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.FieldByName('LOG_COMAND').AsString   := strComand;
        qryLogRep.FieldByName('LOG_TABELA').AsString   := strTabela;
        qryLogRep.FieldByName('LOG_CARREG').AsString   := strCarreg;

        qryLogRep.Post;

        Result := True;

        If (VS_GravaUsuRep = 'S') Then
          Result := Result And fGravaInfUsuarioReplicacao(qryLogRep.FieldByName('LOG_CODIGO').AsLargeInt);
      End
      Else
      Begin
        qryLogRep.SQL.Clear;
        qryLogRep.SQL.Add('INSERT INTO LOGREP ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' LOG_CON_ID,     ');

        If (VS_LogRepCodOp = 'S') Then
         qryLogRep.SQL.Add('  LOG_CODOPE,     ');

        qryLogRep.SQL.Add('   LOG_DTACAD,     ');
        qryLogRep.SQL.Add('   LOG_HRACAD,     ');
        qryLogRep.SQL.Add('   LOG_COMAND,     ');
        qryLogRep.SQL.Add('   LOG_TABELA,     ');
        qryLogRep.SQL.Add('   LOG_CARREG      ');
        qryLogRep.SQL.Add('  )                ');
        qryLogRep.SQL.Add('VALUES             ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' :CON_ID,        ');

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.SQL.Add(' :CODOPE,        ');

        qryLogRep.SQL.Add('   :DTACAD,        ');
        qryLogRep.SQL.Add('   :HRACAD,        ');
        qryLogRep.SQL.Add('   :COMAND,        ');
        qryLogRep.SQL.Add('   :TABELA,        ');
        qryLogRep.SQL.Add('   :CARREG         ');

        qryLogRep.SQL.Add('  )                ');

        If (fGravaLogRepConId) Then
          qryLogRep.ParamByName('CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepCodOp = 'S') Then
        Begin
          If (Not fEmptyStr(fGetUsuarioLogado)) Then
            qryLogRep.ParamByName('CODOPE').AsString := fGetUsuarioLogado
          Else
            qryLogRep.ParamByName('CODOPE').Clear;
        End;

        qryLogRep.ParamByName('DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.ParamByName('HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.ParamByName('COMAND').AsString   := strComand;
        qryLogRep.ParamByName('TABELA').AsString   := strTabela;
        qryLogRep.ParamByName('CARREG').AsString   := strCarreg;

        qryLogRep.ExecSQL;

        Result := True;
      End;

      qryLogRep.Close;
    Finally
      FreeAndNil(qryLogRep);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;

      If Database.InTransaction Then
      Begin
      //  blnErroLogRep := True;
      //  strErroLogRep := '[GRAVALOGREP] - ' + E.message;
      End;

    //  pGravarErro(True,'[GRAVALOGREP] - ' + E.message);
    End;
  End;
End;

procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent; SQL: string; Params: TDAParams; Caption: string);
  Var
    strString     : String;
    strTabela     : String;
    blnGerar      : Boolean;
    intPosEsp     : Integer;

    function fTiraEnter(strTexto: String): String;
    begin
      Result := strTexto;
      Result := AnsiReplaceText(Result, #13#10, ' ');
      Result := AnsiReplaceText(Result, #10, ' ');
      Result := Trim(Result);
    end;

    function fTrimAll(strTexto: String): String;
    begin
      Result := strTexto;
      While Pos('  ', Result) > 0 Do
      Begin
        intPosEsp := Pos('  ', Result);
        Delete(Result, intPosEsp, 1);
      End;
    end;

    function fPreparaSQL(strSQL: String): String;
    Var
      prmParams: TParamDescs;
      prmParam : TParamDesc;
      cmdComand: TCRCommand;
      cmpCompon: TComponent;
      blnAutGer: Boolean;
      objParam : TObject;
      intCont  : Integer;
    Begin
      Result := strSQL;
      blnAutGer := False;

      cmpCompon := TDBAccessUtils.GetUpdateQuery(TCustomDADataSet(Component));
      If Not Assigned(cmpCompon) Then
        cmpCompon := Component
      Else
        blnAutGer := True;

      prmParams := TParamDescs.Create;

      If Not blnAutGer Then
      Begin
        cmdComand := TDBAccessUtils.GetICommand(cmpCompon);

        For intCont := 0 To cmdComand.Params.Count-1 Do
        Begin
          prmParam := TParamDesc.Create;
          prmParam.SetName(cmdComand.Params[intCont].GetName);
          prmParam.SetDataType(cmdComand.Params[intCont].GetDataType);
          prmParam.SetSubDataType(cmdComand.Params[intCont].GetSubDataType);
          prmParam.SetParamType(cmdComand.Params[intCont].GetParamType);
          prmParam.SetSize(cmdComand.Params[intCont].GetSize);
          prmParam.Value := cmdComand.Params[intCont].Value;

          prmParams.Add(prmParam);
        End;

      End;

      objParam := prmParams;
      If blnAutGer Then
        objParam := Params;

      Result := ParseSQL(Result);
      Result := ParseSQLCitel(Result, objParam);

      FreeAndNil(prmParams);
    End;

    function fGeraLogRep(strSel: String): Boolean;
      Var
        intContador: Integer;
        strTabela: String;
    Begin
      If Pos(STR_SQL_NAO_REPLICAR, LeftStr(strSel, 1000)) > 0 Then
        Exit(False);

      strSel := AnsiUpperCase(fTiraEnter(strSel));
      strSel := fTrimAll(strSel);

      Result := False;

      strTabela := fRetornaNomeTabela(strSel);

      If Not fEmptyStr(strTabela) Then
        If Not fTabelaReplica(strTabela) Then
          If Not strTabela.Equals('CFGSIS') Then
            Exit;

      For intContador := 0 To ( Length(arrRep1) - 1 ) Do
      Begin

        If (Pos( arrRep1[intContador], strSel ) > 0) Then
        Begin

          If (Not fEmptyStr(arrRep2[intContador]))  And
             (Pos( arrRep2[intContador], strSel ) > 0) Then
          Begin
            Result := True;
          End
          Else
          Begin

            If fEmptyStr(arrRep2[intContador]) Then
              Result := True;

          End;

        End;
      End;

    End;

Begin
  If Assigned(untFuncoesGen.VS_objTraceViewer) Then
    If untFuncoesGen.VS_objTraceViewer.EnabledSQLLog Then
      untFuncoesGen.VS_objTraceViewer.LogSQL(fPreparaSQL(SQL));

  If Not fGeraLogRep(AnsiUpperCase(SQL)) Then
    Exit;

  strString      := fPreparaSQL(SQL);

  strString := fTiraEnter(strString);

  blnGerar := fGeraLogRep(strString);

  If blnGerar Then
  Begin
    strTabela := fRetornaNomeTabela(strString);

    If SameText(strTabela,'CADBCO') Then
      fGravaLogBco(strString);

    {*******************************************************}
    {* TROCANDO INSERT PELO REPLACE PORQUE ESTAVA TRAVANDO *}
    {* NA REPLICAÇÃO QUANDO JÁ EXISTIA O REGISTRO          *}
    {****************************************************NC*}
    If Pos(strTabela, 'CFGCOL_DIROPE_DIRBAN_DIRGPO_DIRTIN_ENTCLI_CADFIC_ITEBAR_') > 0 Then
      strString := AnsiReplaceStr(strString, 'INSERT', 'REPLACE');

    If fTabelaReplica(strTabela) Or fPermiteReplicarCfgSis(strString) Then
      fGravaLogRep(strString, strTabela, 'N');
  End;

End;

{******************************************************}
{* COLOCA O VALOR NOS PARAMETROS DO SQL A SER GRAVADO *}
{***************************************************AF*}
function ParseSQLCitel(const SQL: string; Params: TObject): string;
  var
    stbSQLFinal: StringBuilder;
    sqlParser  : TSQLParser;
    intPosIni  : integer;
    intParIdx  : Integer;
    wrdDataType: Word;
    varValue   : Variant;
    blnIsNull  : Boolean;
    strCharSet : String;
    intPriVer, intMedVer, intRelVer: Integer;
    IsMariaDB : Boolean;
    objConnection : TMySQLConnection;
    function getDataType(idx:Integer; Param: TObject): Word;
    Begin

      If Param is TDAParams Then
        Result := TDBAccessUtils.GetFieldTypeMapClass(Database).GetDataType(TDAParams(Param)[idx].DataType)
      Else
      If Param is TParamDescs Then
          Result := TParamDescs(Param)[idx].GetDataType
      else
        Result := TParamDescs(Param)[idx].GetDataType;
    End;

    function getValue(idx:Integer; Param: TObject): Variant;
    Begin
      If Param is TDAParams Then Result := TDAParams(Param)[idx].Value
      Else If Param is TParamDescs Then Result := TParamDescs(Param)[idx].Value;
    End;

    function getIsNull(idx:Integer; Param: TObject): Boolean;
    Begin
      If Param is TDAParams Then
        Result := TDAParams(Param)[idx].IsNull
      Else
      If Param is TParamDescs Then
        Result := TParamDescs(Param)[idx].GetNull
      else
        Result := TParamDescs(Param)[idx].GetNull;
    End;

begin

  stbSQLFinal := StringBuilder.Create(Length(SQL) + Length(SQL) div 2);
  objConnection := TMySQLConnection.Create;
  try
    sqlParser := TMyParser.Create(SQL);
    try
      sqlParser.OmitBlank := False;
      sqlParser.OmitComment := True;
      sqlParser.QuotedString := True;
      sqlParser.DecSeparator := '.';
      sqlParser.ToBegin;
      intPosIni := sqlParser.CurrPos;

      intParIdx := 0;
      DecodeVersion(Database.ServerVersion, intPriVer, intMedVer, intRelVer, IsMariaDB);

      strCharSet := Database.SpecificOptions.Values['Charset'];

      While sqlParser.ToLexem('?') Do
      Begin
        stbSQLFinal.Append(Copy(SQL, intPosIni + 1, sqlParser.CurrPos - intPosIni - 1));

        wrdDataType := getDataType(intParIdx, Params);
        varValue    := getValue(intParIdx, Params);
        blnIsNull   := getIsNull(intParIdx, Params);
        objConnection.AppendValueToSQL(stbSQLFinal, wrdDataType, varValue, blnIsNull, False, False);

        Inc(intParIdx);
        intPosIni := sqlParser.CurrPos;
      End;

      stbSQLFinal.Append(Copy(SQL, intPosIni + 1, sqlParser.CurrPos - intPosIni));
    Finally
      sqlParser.Free;
    End;

    Result := stbSQLFinal.ToString;
  Finally
    stbSQLFinal.Free;
    objConnection.Free;
  End;

end;

{***********************************************}
{* CASO OS PARAMETRO DO SELECT ESTIVEREM SEM ? *}
{* TROCA PARA SER TRATADO SEMPRE ?             *}
{********************************************AF*}
function ParseSQL(const SQL: String): String;
  Var
    ParsedSQL: StringBuilder;
    Parser   : TSQLParser;
    StartPos : Integer;
    intCode  : Integer;
    strAux   : String;
begin
  ParsedSQL := StringBuilder.Create(Length(SQL) + Length(SQL) div 2);
  Try
    Parser := TMyParser.Create(SQL);
    Try
      Parser.OmitBlank := False;
      Parser.OmitComment := True;
      Parser.QuotedString := True;
      Parser.DecSeparator := '.';
      Parser.ToBegin;
      StartPos := Parser.CurrPos;
      While Parser.ToLexem(':') Do
      Begin
        ParsedSQL.Append(Copy(SQL, StartPos + 1, Parser.CurrPos - StartPos - 1));
        intCode := Parser.GetNext(strAux);

        If ((intCode = lcIdent) or (intCode = lcNumber) or (Parser.KeywordLexems.IndexOf(strAux) <> -1)) Then
          ParsedSQL.Append('?')
        Else
        Begin
          ParsedSQL.Append(':');
          ParsedSQL.Append(strAux);
        End;

        StartPos := Parser.CurrPos;
      End;
      ParsedSQL.Append(Copy(SQL, StartPos + 1, Parser.CurrPos - StartPos));
    Finally
      Parser.Free;
    End;

    Result := ParsedSQL.ToString;
  Finally
    ParsedSQL.Free;
  End;
end;

initialization

  cdsTabNRE := nil;
  FDicTabelaReplica := TDictionary<String, Boolean>.Create;
  FMREWSTabelaReplica := TMultiReadExclusiveWriteSynchronizer.Create;

Finalization

  If Assigned(FDicTabelaReplica) Then
    FreeAndNil(FDicTabelaReplica);

  If Assigned(FMREWSTabelaReplica) Then
    FreeAndNil(FMREWSTabelaReplica);

  If Assigned(cdsTabNRE) Then
    FreeAndNil(cdsTabNRE);

end.
