unit untTAPISaneamento;

interface

uses
  untFuncoesSimples, Uni, System.Classes, System.SysUtils, Data.DB, IPPeerClient, System.TypInfo, System.IOUtils,
  REST.Client, REST.Json, REST.Types, REST.Authenticator.Basic,UniClientDataSet, StrUtils, System.JSON, untLogSaneamento,
  untGravando, cxProgressBar, Vcl.Forms, untConstantes, System.Math, untFuncoesAuxiliares, untTypesSistema,
  untFuncoesConsulta, System.SyncObjs, Vcl.ExtCtrls, Variants, untModulo, CRAccess, iMendes.Types, iMendes.Constantes;


type
  TAfterScroll = procedure (DataSet: TDataSet) of Object;

  TAPISaneamento = class
    private
      qryEstados,
      qryAux,
      qryItensPerfil,
      qryUpd,
      qryErros: TUniQuery;
      strAbfPis,
      strAbfIpi,
      strCodFor,
      strCodGru,
      strCodIte,
      strCodNCM,
      strCodAbf,
      strCodEmp,
      strAbfCof,
      strPrcCodIte,
      strPrcDesIte,
      strPrcCodBar,
      strPrcClaIpi,
      strScript: String;
      conConexao: TUniConnection;
      qryPRFSAN,
      qryTmp: TUniQuery;
      class var qryEmit: TUniQuery;
      RESTReq: TRESTRequest;
      RESTCli: TRESTClient;
      RESTRes: TRESTResponse;
      HTTPAuth: THTTPBasicAuthenticator;
      intTimeout: Integer;
      class var modApi: TModoApi;
      strURL,
      strUsuario,
      strSenha: String;
      intReqs: Integer;
      Procedure pSetaHeaders(ARESTReq: TRESTRequest);
      Procedure pInicializarQueryEmitente;
      function fGetCaracTrib(APrefil: TPerfil): String;
      Function fValidarConfigs:Boolean;
      class Function fGetNumbers(strTexto: String): String;
      class Function fConvertStringToPerfil(APerfil: String):TPerfil;
      class Function fConvertConfPerfilToString(AConjPerfi:TPerfil): String;
      procedure pInicializarConexao;
      Function fGetSQL: String;
      Function fGetSQLWhere: String;
      Function fInicializarQuery: Boolean;
      Function fGetLastLine(ACodIte: String): Integer;
      Function fGerarQryItensPerfilAux(pgbProgresso: TcxProgressBar): Boolean;
      procedure pExecutaGravacao;
      Procedure pProcessaPerfilEntrada(AConjPerfil:TPerfil; AstrCodAbf: string);
      Procedure pProcessaPerfilSaida(AConjPerfil:TPerfil; AstrCodAbf: String);
      Procedure pProcessaPerfil(AConjPerfil:TPerfil; AstrCodAbf: String);
      Procedure pAlimentaCds(AStrCodAbf: String);
      Procedure pAlimentaCdsPerfil(APerfil, ACodSit, AOrigem, AField, ADescricao: String; AEstadoOri: String = ''; AEstadoDES:String = ''; AstrCodAbf: String = '');
      function fPerfilEntrada(APerfil: String): Boolean;
      function fRetValorTratado(AField: String; ADescricao: String): String;
      Procedure pInsereDadosPadrao(AstrCodAbf: String);
      Procedure pCriarTabelaTemporaria;
      Procedure pLimparTabelaTemporaria;
      function fAutenticar: Boolean;

      Function fAutenticarAux(pgbProgresso: TcxProgressBar): Boolean;
      Function fEnviarItens(out numErros:Integer):Boolean;
      const strInsert = 'INSERT INTO TMP_ITESAN (TMP_DESITE, TMP_PERFIL, TMP_CODSIT, TMP_ORIGEM, TMP_CODITE, TMP_CODBAR, TMP_CLAIPI, TMP_DESCRI, TMP_DESCUI, TMP_UFORI_, TMP_UFDES_, TMP_VLRAUT, TMP_UFEMPE , TMP_CFOP, TMP_PERENT, TMP_CODABF) VALUES  ';

    public
      dtsItens: TDataSource;
      qryItens: TUniQuery;
      blnUtiAbi,
      blnDarRor,
      blnUtiAbr,
      blnConfigsValidadas,
      blnAutenticado: Boolean;
      recParametros: TRecParametrosApiSaneamento;
      OnAfterScroll : TAfterScroll;
      blnConsultaRealizada: Boolean;

      class var stlErros: TStringList;

      Constructor Create;
      Destructor Destroy; override;
      Function fAbrirQueryAux(pgbProgresso: TcxProgressBar): Boolean;
      Function fAbrirQuery:Boolean;
      Procedure pMostrarLog;
      Procedure pPesquisar(out intErros: Integer);
      procedure pAbrirConsulta(RecParam: TRecParametrosApiSaneamento);
      class function fGetConjPerfis(strPerfil: string): TConjPerfis;
      class Function fGetPerfilItem(APerfil: String): TPerfil;
      function blnTemErro(strCodIte: String; APerfil: string = ''): Boolean;

  end;

  const VersaoAutcomApi = 74;

  function fRemoveVirgula(Value: String): String;


  var intQtdThreadAtivas: integer;
  var FSessaoCritica : TCriticalSection;
  var lstScriptGeral: TStringList;



implementation

{ TAPISaneamento }

function TAPISaneamento.blnTemErro(strCodIte: String; APerfil: string = ''): Boolean;
begin
  Result := false;
  If qryErros.Active Then
  begin
    qryErros.First;
    If APerfil <> '' Then
      result := qryErros.Locate('TMP_CODITE;TMP_PERFIL', varArrayOf([strCodIte,APerfil]), [])
    Else
      result := qryErros.Locate('TMP_CODITE', strCodIte, []);
  End;
end;

procedure TAPISaneamento.pInicializarConexao;
begin
  conConexao := TUniConnection.Create(frmModulo);
  conConexao.ProviderName := frmModulo.Database.ProviderName;
  conConexao.Username := frmModulo.Database.Username;
  conConexao.Password := frmModulo.Database.Password;
  conConexao.Server := frmModulo.Database.Server;
  conConexao.Database := frmModulo.Database.Database;
  conConexao.Port := frmModulo.Database.Port;
  conConexao.DefaultTransaction.IsolationLevel := DEFAULT_ISOLATION_LEVEL_UNIDAC;

  Try
    conConexao.Connect;
  Except
    On E: Exception Do
    Begin
      Sleep(1000);
      conConexao.Connect;
    End;
  End;
end;

constructor TAPISaneamento.Create;
begin
  pInicializarConexao;

  qryEstados := fCriaQuery(Nil, conConexao);
  qryAux := fCriaQuery(Nil, conConexao);
  pCriarTabelaTemporaria;
  qryItensPerfil := fCriaQuery(Nil, conConexao);
  qryItensPerfil.SQL.Add('SELECT * FROM TMP_ITESAN');
  qryItensPerfil.Open;
  qryUpd := fCriaQuery(Nil, conConexao);

  qryErros := fCriaQuery(Nil, conConexao);
  dtsItens := fCriaDataSource(qryItensPerfil);
  blnConsultaRealizada := False;
  fInicializarQuery;

  blnDarRor := False;
  If fCampoTabela('COUNT(SIS_VALCFG)', 'CFGSIS', ['SIS_CODCFG'], ['DARROR']) > 0 Then
    blnDarRor := fCfgSis('DARROR', varBoolean);

  FSessaoCritica := TCriticalSection.Create;
  lstScriptGeral := TStringList.Create;

  RESTCli := TRESTClient.Create(strURL);
  RESTReq := TRESTRequest.Create(Nil);
  RESTRes := TRESTResponse.Create(Nil);

  strURL     := fCfgSis('URLSAN');
  strUsuario := fCfgSis('USRSAN');
  strSenha   := fDecriptar(fCfgSis('SNHSAN'));
  intTimeout := fCfgSis('TMOSAN', varInteger);
  intReqs    := fCfgSis('RQTSAN');
  modApi     := TModoApi(fCfgSis('MODSAN', varInteger));

  Try
    If DirectoryExists(ExtractFilePath(ParamStr(0))+'iMendes') Then
      TDirectory.Delete(ExtractFilePath(ParamStr(0))+'iMendes', True);
    ForceDirectories(ExtractFilePath(ParamStr(0))+'iMendes');
  Except
  End;

  stlErros := TStringList.Create;

  RESTCli.Accept := ACCEPT;
  RESTCli.AcceptCharset := ACCEPT_CHARSET;
  RESTCli.HandleRedirects := True;

  RESTReq.Accept := ACCEPT;
  RESTReq.AcceptCharset := ACCEPT_CHARSET;
  RESTReq.Client := RESTCli;
  RESTReq.Response := RESTRes;
  RESTReq.Timeout := intTimeout;

  pSetaHeaders(RESTReq);

  qryTmp := fCriaQuery(Nil, conConexao);
  qryEmit:= fCriaQuery(Nil, conConexao);
  pInicializarQueryEmitente;
  qryPRFSAN := fCriaQuery(Nil, conConexao);
  qryPRFSAN.SQL.Add('SELECT * FROM PRFSAN');
  qryPRFSAN.Open;

  blnConfigsValidadas := fValidarConfigs;
  blnAutenticado := fAutenticar;
end;

destructor TAPISaneamento.Destroy;
begin
  FreeAndNil(qryItens);
  FreeAndNil(qryEstados);
  FreeAndNil(qryItensPerfil);
  FreeAndNil(qryAux);
  FreeAndNil(dtsItens);
  FreeAndNil(qryErros);
  FreeAndNil(FSessaoCritica);
  FreeAndNil(lstScriptGeral);
  FreeAndNil(qryUpd);

  FreeAndNil(RESTCli);
  FreeAndNil(RESTReq);
  FreeAndNil(RESTRes);
  FreeAndNil(HTTPAuth);
  FreeAndNil(stlErros);
  FreeAndNil(qryTmp);
  FreeAndNil(qryEmit);
  FreeAndNil(qryPRFSAN);
end;

function TAPISaneamento.fAbrirQuery: Boolean;
begin
  pLimparTabelaTemporaria;
  Result := TfrmGravando.fExecuta(fAbrirQueryAux, frmGravando, 'Selecionando itens...');

  If Result Then
    Result := TfrmGravando.fExecuta(fGerarQryItensPerfilAux, frmGravando, 'Ajustando perfis...');

  qryItensPerfil.Close;
  qryItensPerfil.Open;
end;

function TAPISaneamento.fAbrirQueryAux(pgbProgresso: TcxProgressBar): Boolean;
begin
  pgbProgresso.Visible := False;
  Application.ProcessMessages;
  Try
    qryItens.Open;
    qryErros.Close;

    If Assigned(OnAfterScroll) Then
      qryItensPerfil.AfterScroll := OnAfterScroll;

    If qryItens.RecordCount > 1000 Then
    Begin
      pMensagemOk('O limite máximo para consulta de itens é de 1.000 itens');
      Exit(False);
    End;

    If qryItens.IsEmpty Then
    Begin
      pMensagemOk('Nenhum item encontrado com os filtros selecionados');
      Exit(False);
    End;

    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TAPISaneamento.fAbrirQueryAux]');

    End;
  End;
end;

procedure TAPISaneamento.pInsereDadosPadrao(AstrCodAbf: String);
begin
  If recParametros.Comparativos.blnNCMCest Then
  Begin
    pAlimentaCdsPerfil('','','', 'ITE_CLAIPI', 'NCM', '', '', AstrCodAbf);
    pAlimentaCdsPerfil('','','', 'ITE_CDCEST', 'CEST', '', '', AstrCodAbf);
    pAlimentaCdsPerfil('','','', 'ITE_CODLUB', 'ANP', '', '', AstrCodAbf);
  End;

  If blnUtiAbr Then
  Begin
    If recParametros.Comparativos.blnCofins Then
    Begin
      pAlimentaCdsPerfil('','','', 'COF_CSTENT', 'COFINS - ENT - CST', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'COF_CSTSAI', 'COFINS - SAI - CST', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'COF_ALQENT', 'COFINS - ENT - ALÍQUOTA', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'COF_ALQSAI', 'COFINS - SAI - ALÍQUOTA', '', '', AstrCodAbf);
    End;
    If recParametros.Comparativos.blnPis Then
    Begin
      pAlimentaCdsPerfil('','','', 'PIS_CSTENT', 'PIS - ENT - CST', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'PIS_CSTSAI', 'PIS - SAI - CST', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'PIS_ALQENT', 'PIS - ENT - ALÍQUOTA', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'PIS_ALQSAI', 'PIS - SAI - ALÍQUOTA', '', '', AstrCodAbf);
    End;
  End;
  If blnUtiAbi Then
  Begin
    If recParametros.Comparativos.blnIpi Then
    Begin
      pAlimentaCdsPerfil('','','', 'ITE_EXCIPI', 'IPI - CÓDIGO EX', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'IPI_ALQENT', 'IPI - ENT - ALÍQUOTA', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'IPI_ALQSAI', 'IPI - SAI - ALÍQUOTA', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'IPI_ALQENT', 'IPI - ENT - ALÍQUOTA', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'IPI_ALQSAI', 'IPI - SAI - ALÍQUOTA', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'IPI_ENQIPE', 'IPI - ENT - ENQUADRAMENTO', '', '', AstrCodAbf);
      pAlimentaCdsPerfil('','','', 'IPI_ENQIPS', 'IPI - SAI - ENQUADRAMENTO', '', '', AstrCodAbf);
    End;
  End;
end;

procedure TAPISaneamento.pLimparTabelaTemporaria;
begin
  Try
    qryTmp.SQL.Clear;
    qryTmp.SQl.Add('DELETE FROM TMP_ITESAN');
    qryTmp.ExecSQL;
  Except
  End;
end;

procedure TAPISaneamento.pMostrarLog;
begin
  If StlErros.Count = 0 Then
    Exit;
  Try
    pCriarFormularios(TfrmLogSaneamento, frmLogSaneamento);
    frmLogSaneamento.stlErros := StlErros;
    frmLogSaneamento.lblTitulo.Caption := stlErros.Count.toString + ' erro(s) na comunicação';
    frmLogSaneamento.ShowModal;
  Finally
    FreeAndNil(frmLogSaneamento);
  End;
end;

procedure TAPISaneamento.pPesquisar(out intErros: Integer);
begin

end;

function TAPISaneamento.fGerarQryItensPerfilAux(pgbProgresso: TcxProgressBar): Boolean;
var
  strCodIteAtu: String;
  recIni,
  recFim: Integer;
  blnTerminated,
  blnContinue: Boolean;
begin
  Try
    If qryItens.IsEmpty Then
      Exit(True);

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := qryItens.RecordCount;

    qryEstados.SQL.Clear;
    qryEstados.SQL.Add(' SELECT DISTINCT             ');
    qryEstados.SQL.Add('  CID_ESTADO AS ESTADO       ');
    qryEstados.SQL.Add(' FROM                        ');
    qryEstados.SQL.Add(' CADEMP                      ');
    qryEstados.SQL.Add(' INNER JOIN CADCID           ');
    qryEstados.SQL.Add('  ON CID_CODCID = EMP_CODCID ');
    qryEstados.SQL.Add(' WHERE TRUE                  ');
    qryEstados.SQL.Add(fStrLocate(recParametros.Filtros.FilterCodEmpresa , recParametros.Filtros.FilterArrEmpresa , 'EMP_CODEMP', 'CODEMP'));

    qryEstados.SQL.Add(' ORDER BY CID_ESTADO         ');
    pSetaParam(recParametros.Filtros.FilterCodEmpresa     , recParametros.Filtros.FilterArrEmpresa    , strCodEmp, 'CODEMP' , qryEstados);
    qryEstados.Open;

    qryItens.AfterScroll := Nil;

    qryItens.First;
    strCodIteAtu := '';
    blnTerminated := False;

    pLimparTabelaTemporaria;

    qryEstados.First;
    qryAux.SQl.Clear;

    strPrcCodIte := '';
    strPrcCodBar := '';
    strPrcClaIpi := '';
    strScript  := '';
    blnContinue := True;
    recIni := 0;
    recFim := 0;
    While Not blnTerminated Do
    Begin
      While not qryEstados.Eof do
      Begin
        // TROCA DO ITEM
        If strCodIteAtu <> qryItens.FieldByName('ITE_CODITE').AsString Then
        Begin
          strPrcCodIte := qryItens.FieldByName('ITE_CODITE').AsString;
          strPrcDesIte := qryItens.FieldByName('DESCRI').AsString;
          strPrcCodBar := qryItens.FieldByName('ITE_CODBAR').AsString;
          strPrcClaIpi := qryItens.FieldByName('ITE_CLAIPI').AsString;
          pInsereDadosPadrao(qryItens.FieldByName('ABF_CODABF').AsString);
          strCodIteAtu := qryItens.FieldByName('ITE_CODITE').AsString;
          recIni := qryItens.RecNo;
          recFim := fGetLastLine(strCodIteAtu);
          qryItens.Recno := recIni;
          blnContinue := True;
          pExecutaGravacao;

        End;

        If Not blnContinue Then
          Break;

        pAlimentacds(qryItens.FieldByName('ABF_CODABF').AsString);

        qryItens.Next;
        If (qryItens.RecNo mod 10) = 0 then
        Begin
          pgbProgresso.Position := qryItens.RecNo;
          Application.ProcessMessages;
        End;

        If qryItens.Eof Then
          blnContinue := False
        Else If qryItens.RecNo > recFim Then
          blnContinue := False;

        If Not blnContinue Then
        Begin
          strCodIteAtu := '';
          qryEstados.Next;
          If Not qryEstados.Eof then
            qryItens.RecNo := recIni;
        End;
      End;
      qryEstados.First;
      qryItens.RecNo := recFim;
      qryItens.Next;

      pgbProgresso.Position := qryItens.RecNo;
      Application.ProcessMessages;

      blnTerminated := qryItens.Eof;
    End;
    pExecutaGravacao;

    qryItensPerfil.First;
    Result := True;
  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, '[TAPISaneamento.fCriarDataSetAux]');
      Exit(False)
    End;
  End;
end;

procedure TAPISaneamento.pExecutaGravacao;
begin
  If Not fEmptyStr(strScript) Then
  Begin
    qryAux.SQL.Add(strScript);
    qryAux.ExecSQL;
    qryAux.SQL.Clear;
    strScript := '';
  End;
End;

function TAPISaneamento.fGetLastLine(ACodIte: String): Integer;
begin
  while not qryItens.Eof do
  begin
    If qryItens.FieldByname('ITE_CODITE').AsString <> ACodIte Then
      Exit(qryItens.RecNo -1);

    qryItens.Next;
  End;

  Result := qryItens.RecNo;
End;

function TAPISaneamento.fGetSQL: String;
var
  blnTipAbfGeral,
  blnTipAbpcGeral: Boolean;
  strAliasTpaBpc: String;
begin
  blnUtiAbi := fCfgSis('UTIABI', varBoolean, recParametros.Filtros.FilterCodEmpresa);
  blnUtiAbr := fCfgSis('UTIABR', varBoolean, recParametros.Filtros.FilterCodEmpresa);
  blnTipAbfGeral := fCfgSis('TIPABF', varString, recParametros.Filtros.FilterCodEmpresa) = '1';
  strAliasTpaBpc := IIF(fCfgSis('TPABPC', varString, recParametros.Filtros.FilterCodEmpresa) = '1' , 'C','I');

  Result := '';
  Result := Result + 'SELECT                           ';
  Result := Result + ' CAST(CONCAT(' + recParametros.StrCampoOrdenacao + ', "<TAG_AUTCOM>", C.ITE_CODITE," - ",      ';
  Result := Result + '        C.ITE_DESITE," - ",      ';
  Result := Result + '        U.UNI_SIGUNI," - ",      ';
  Result := Result + '        C.ITE_CODBAR) AS CHAR(255)) AS DESCRI, ';
  Result := Result + ' C.ITE_CODITE,                   ';
  Result := Result + ' C.ITE_DESITE,                   ';
  Result := Result + ' I.ITE_CODEMP,                   ';
  Result := Result + ' C.ITE_CLAIPI,                   ';
  Result := Result + ' C.ITE_CODFOR,                   ';
  Result := Result + ' C.ITE_CDCEST,                   ';
  Result := Result + ' C.ITE_CODLUB,                   ';
  Result := Result + ' C.ITE_CODBAR,                   ';
  Result := Result + ' ABFICM.*                        ';

  //IPI
  If blnUtiAbi Then
  Begin
    Result := Result + ', '+strAliasTpaBpc+'.ITE_EXCIPI,                  ';
    Result := Result + ' (SELECT APC_CSTENT FROM IPIENT WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_CSTENT,';
    Result := Result + ' (SELECT CAST(CONCAT(APC_CODAPC, " - ",APC_DESCRI) AS CHAR(255)) FROM IPIENT WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_APCENT,';
    Result := Result + ' (SELECT APC_ALQENT FROM IPIENT WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_ALQENT,';
    Result := Result + ' (SELECT APC_ENQIPI FROM IPIENT WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_ENQIPE,';
    Result := Result + ' (SELECT APC_CSTSAI FROM IPISAI WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_CSTSAI,';
    Result := Result + ' (SELECT CAST(CONCAT(APC_CODAPC, " - ",APC_DESCRI) AS CHAR(255)) FROM IPISAI WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_APCSAI,';
    Result := Result + ' (SELECT APC_ALQSAI FROM IPISAI WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_ALQSAI,';
    Result := Result + ' (SELECT APC_ENQIPI FROM IPISAI WHERE '+strAliasTpaBpc+'.ITE_ABFIPI = APC_CODAPC LIMIT 1) AS IPI_ENQIPS';
  End;

  //PIS COFINS
  If blnUtiAbr Then
  Begin
    Result := Result + ' ,(SELECT APC_CSTSAI FROM PISSAI WHERE '+strAliasTpaBpc+'.ITE_ABFPIS = APC_CODAPC LIMIT 1) AS PIS_CSTSAI,';
    Result := Result + ' (SELECT CAST(CONCAT(APC_CODAPC, " - ",APC_DESCRI) AS CHAR(255)) FROM PISSAI WHERE '+strAliasTpaBpc+'.ITE_ABFPIS = APC_CODAPC LIMIT 1) AS PIS_APCSAI,';
    Result := Result + ' (SELECT APC_ALQSAI FROM PISSAI WHERE '+strAliasTpaBpc+'.ITE_ABFPIS = APC_CODAPC LIMIT 1) AS PIS_ALQSAI,';
    Result := Result + ' (SELECT APC_ALQENT FROM PISENT WHERE '+strAliasTpaBpc+'.ITE_ABFPIS = APC_CODAPC LIMIT 1) AS PIS_ALQENT,';
    Result := Result + ' (SELECT APC_CSTENT FROM PISENT WHERE '+strAliasTpaBpc+'.ITE_ABFPIS = APC_CODAPC LIMIT 1) AS PIS_CSTENT,';
    Result := Result + ' (SELECT CAST(CONCAT(APC_CODAPC, " - ",APC_DESCRI) AS CHAR(255)) FROM PISENT WHERE '+strAliasTpaBpc+'.ITE_ABFPIS = APC_CODAPC LIMIT 1) AS PIS_APCENT,';

    Result := Result + ' (SELECT APC_CSTSAI FROM COFSAI WHERE '+strAliasTpaBpc+'.ITE_ABFCOF = APC_CODAPC LIMIT 1) AS COF_CSTSAI,';
    Result := Result + ' (SELECT CAST(CONCAT(APC_CODAPC, " - ",APC_DESCRI) AS CHAR(255)) FROM COFSAI WHERE '+strAliasTpaBpc+'.ITE_ABFCOF = APC_CODAPC LIMIT 1) AS COF_APCSAI,';
    Result := Result + ' (SELECT APC_ALQSAI FROM COFSAI WHERE '+strAliasTpaBpc+'.ITE_ABFCOF = APC_CODAPC LIMIT 1) AS COF_ALQSAI,';
    Result := Result + ' (SELECT APC_ALQENT FROM COFENT WHERE '+strAliasTpaBpc+'.ITE_ABFCOF = APC_CODAPC LIMIT 1) AS COF_ALQENT,';
    Result := Result + ' (SELECT APC_CSTENT FROM COFENT WHERE '+strAliasTpaBpc+'.ITE_ABFCOF = APC_CODAPC LIMIT 1) AS COF_CSTENT, ';
    Result := Result + ' (SELECT CAST(CONCAT(APC_CODAPC, " - ",APC_DESCRI) AS CHAR(255)) FROM COFENT WHERE '+strAliasTpaBpc+'.ITE_ABFCOF = APC_CODAPC LIMIT 1) AS COF_APCENT ';
  End;

  Result := Result + ' FROM                            ';
  Result := Result + '  ABFICM                         ';

  If blnTipAbfGeral Then
  Begin
    Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODABF = ABFICM.ABF_CODABF';
    Result := Result + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ';
    Result := Result +      fStrLocate(recParametros.Filtros.FilterCodEmpresa , recParametros.Filtros.FilterArrEmpresa , 'I.ITE_CODEMP', 'CODEMP') ;

  End
  Else
  Begin
    Result := Result + ' INNER JOIN ITEGER I ON I.ITE_CODABF = ABFICM.ABF_CODABF ';
    Result := Result +      fStrLocate(recParametros.Filtros.FilterCodEmpresa , recParametros.Filtros.FilterArrEmpresa , 'I.ITE_CODEMP', 'CODEMP');
    Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';
  End;

  Result := Result + '  LEFT JOIN CADFOR CF                        ';
  Result := Result + '    ON CF.FOR_CODFOR = C.ITE_CODFOR          ';
  Result := Result + '  LEFT JOIN CADUNI U                         ';
  Result := Result + '    ON U.UNI_CODUNI = C.ITE_CODUNI           ';

end;

function TAPISaneamento.fGetSQLWhere: String;
var
  blnTipAbfGeral,
  blnTipAbpcGeral: Boolean;
begin
  blnTipAbfGeral  := fCfgSis('TIPABF', varString, recParametros.Filtros.FilterCodEmpresa) = '1';
  blnTipAbpcGeral := fCfgSis('TPABPC', varString, recParametros.Filtros.FilterCodEmpresa) = '1';

  Result := '';
  Result := 'WHERE TRUE ';

  If Not fEmptyStr(recParametros.Filtros.FilterDescricaoDoItem) Then
  Begin
    Result := Result + 'AND C.ITE_DESITE LIKE '+ QuotedStr('%'+ recParametros.Filtros.FilterDescricaoDoItem +'%');
  End;

  Result := Result + fStrLocate(recParametros.Filtros.FilterCodEmpresa , recParametros.Filtros.FilterArrEmpresa  , 'I.ITE_CODEMP', 'CODEMP');
  Result := Result + fStrLocate(recParametros.Filtros.FilterCodFornecedor , recParametros.Filtros.FilterArrFornecedor  , 'C.ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(recParametros.Filtros.FilterCodLinhaGrupo , recParametros.Filtros.FilterArrLinhaGrupo  , 'C.ITE_CODGRU', 'CODGRU');
  Result := Result + fStrLocate(recParametros.Filtros.FilterCodItem , recParametros.Filtros.FilterArrItem  , 'C.ITE_CODITE', 'CODITE');

  If blnTipAbfGeral Then
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvICMS , recParametros.Filtros.FilterArrAbvICMS , 'C.ITE_CODABF', 'CODABF')
  Else
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvICMS , recParametros.Filtros.FilterArrAbvICMS , 'I.ITE_CODABF', 'CODABF');

  If blnTipAbfGeral Then
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvPIS , recParametros.Filtros.FilterArrAbvPIS, 'C.ITE_ABFPIS', 'ABFPIS')
  Else
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvPIS , recParametros.Filtros.FilterArrAbvPIS, 'I.ITE_ABFPIS', 'ABFPIS');

  If blnTipAbpcGeral Then
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvCOFINS , recParametros.Filtros.FilterArrAbvCOFINS, 'C.ITE_ABFCOF', 'ABFCOF')
  Else
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvCOFINS , recParametros.Filtros.FilterArrAbvCOFINS, 'I.ITE_ABFCOF', 'ABFCOF');

  If blnTipAbpcGeral Then
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvIPI , recParametros.Filtros.FilterArrAbvIPI, 'C.ITE_ABFIPI', 'ABFIPI')
  Else
    Result := Result + fStrLocate(recParametros.Filtros.FilterAbvIPI , recParametros.Filtros.FilterArrAbvIPI, 'I.ITE_ABFIPI', 'ABFIPI');

  Result := Result + fStrLocate(recParametros.Filtros.FilterNCM , recParametros.Filtros.FilterArrNCM, 'C.ITE_CLAIPI', 'CLAIPI');
end;

function TAPISaneamento.fInicializarQuery: Boolean;
begin
  Try
    qryItens := fCriaQuery(Nil, conConexao);
    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAPISaneamento.fInicializarQuery]');
    End;
  End;
end;

class function TAPISaneamento.fConvertConfPerfilToString(AConjPerfi:TPerfil): String;
begin
  case AConjPerfi of
    cjpPEF: Result := 'PEF';
    cjpPEJ: Result := 'PEJ';
    cjpPER: Result := 'PER';
    cjpPES: Result := 'PES';
    cjpPSI: Result := 'PSI';
    cjpPII: Result := 'PII';
    cjpNCO: Result := 'NCO';
    cjpCCO: Result := 'CCO';
    cjpCNC: Result := 'CNC';
    cjpSNA: Result := 'SNA';
    cjpCTA: Result := 'CTA';
    cjpPRU: Result := 'PRU';
    cjpIND: Result := 'IND';
    cjpTRS: Result := 'TRS';
  end;
End;

procedure TAPISaneamento.pProcessaPerfilEntrada(AConjPerfil:TPerfil; AstrCodAbf: string);
var
  APerfil: string;
  strPrefixo,
  strCodSit,
  strOrigem,
  strEstadoOri,
  strEstadoDes: String;
begin
  strPrefixo := 'ENT';
  strEstadoOri := qryItens.FieldByName('ABF_ESTADO').AsString;
  strEstadoDes := qryEstados.FieldByName('ESTADO').AsString;
  APerfil :=  fConvertConfPerfilToString(AConjPerfil);
  strCodSit := qryItens.FieldByName( 'ABF_CODSIT_' + strPrefixo + '_' + APerfil).AsString;
  If blnDarRor Then
   strOrigem := AnsiLeftStr(qryItens.FieldByName( 'ABF_CODSIT_' + strPrefixo + '_' + APerfil +  '_O').AsString, 1)
  Else
    strOrigem := AnsiLeftStr(qryItens.FieldByName( 'ABF_CODSIT_' + strPrefixo + '_' + APerfil).AsString, 1);

  If strEstadoOri.IsEmpty Then
    Exit;

  If Not fEmptyStr(recParametros.Filtros.FilterUFOrigem) Then
  Begin
    If qryItens.FieldByName('ABF_ESTADO').AsString <> recParametros.Filtros.FilterUFOrigem Then
      Exit;
  End;

  If Not fEmptyStr(recParametros.Filtros.FilterUFDestino) Then
  Begin
    If strEstadoDes <> recParametros.Filtros.FilterUFDestino Then
      Exit;
  End;


  pAlimentaCdsPerfil(APerfil,strCodSit,strOrigem, 'ABF_CODSIT_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - ENT - ' + APerfil + ' - ' + ' CST', strEstadoOri, strEstadoDes, AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'',strOrigem, 'ABF_ALQICM_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - ENT - ' + APerfil + ' - ' + ' ALÍQUOTA INTERNA', strEstadoOri, strEstadoDes, AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'',strOrigem, 'ABF_BASICM_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - ENT - ' + APerfil + ' - ' + ' REDUÇÃO BASE CALCULO ICMS', strEstadoOri, strEstadoDes, AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'',strOrigem, 'ABF_BASRET_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - ENT - ' + APerfil + ' - ' + ' REDUÇÃO BASE CALCULO ST', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'',strOrigem, 'ABF_ALQRET_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - ENT - ' + APerfil + ' - ' + ' ALÍQUOTA ICMS ST', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'',strOrigem, 'ABF_IVA_ST_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - ENT - ' + APerfil + ' - ' + ' IVA AJUSTADO', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'',strOrigem, 'ABF_ALQFCP_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - ENT - ' + APerfil + ' - ' + ' ALÍQUOTA FCP', strEstadoOri, strEstadoDes,AstrCodAbf);

End;


procedure TAPISaneamento.pProcessaPerfilSaida(AConjPerfil:TPerfil; AstrCodAbf: String);
var
  APerfil: string;
  strPrefixo,
  strEstadoOri,
  strCodSit,
  strEstadoDes: String;
begin
  strPrefixo := 'SAI';
  strEstadoOri := qryEstados.FieldByName('ESTADO').AsString;
  strEstadoDes := qryItens.FieldByName('ABF_ESTADO').AsString;
  APerfil :=  fConvertConfPerfilToString(AConjPerfil);
  strCodSit := qryItens.FieldByName( 'ABF_CODSIT_' + strPrefixo + '_' + APerfil).AsString;

  If strEstadoDes.IsEmpty Then
    Exit;

  If Not fEmptyStr(recParametros.Filtros.FilterUFDestino) Then
  Begin
    If qryItens.FieldByName('ABF_ESTADO').AsString <> recParametros.Filtros.FilterUFDestino Then
      Exit;
  End;

  If Not fEmptyStr(recParametros.Filtros.FilterUFOrigem) Then
  Begin
    If strEstadoOri <> recParametros.Filtros.FilterUFOrigem Then
      Exit;
  End;

  pAlimentaCdsPerfil(APerfil, strCodSit,'', 'ABF_CODSIT_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - SAI - '+ APerfil + ' - ' + ' CST', strEstadoOri, strEstadoDes, AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'','', 'ABF_ALQICM_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - SAI - '+ APerfil + ' - ' + ' ALÍQUOTA INTERNA', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'','', 'ABF_BASICM_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - SAI - '+ APerfil + ' - ' + ' REDUÇÃO BASE CALCULO ICMS', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'','', 'ABF_BASRET_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - SAI - '+ APerfil + ' - ' + ' REDUÇÃO BASE CALCULO ST', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'','', 'ABF_ALQRET_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - SAI - '+ APerfil + ' - ' + ' ALÍQUOTA ICMS ST', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'','', 'ABF_IVA_ST_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - SAI - '+ APerfil + ' - ' + ' IVA AJUSTADO', strEstadoOri, strEstadoDes,AstrCodAbf);
  pAlimentaCdsPerfil(APerfil,'','', 'ABF_ALQFCP_' + strPrefixo + '_' + APerfil, 'ICMS - ' + strEstadoOri + ' > ' + strEstadoDes + ' - SAI - '+ APerfil + ' - ' + ' ALÍQUOTA FCP', strEstadoOri, strEstadoDes,AstrCodAbf);

End;

procedure TAPISaneamento.pProcessaPerfil(AConjPerfil:TPerfil; AstrCodAbf: String);
Begin
  If AConjPerfil in [cjpPII] then
    If VersaoAutcomApi = 72 then
      Exit;
  If AConjPerfil in [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII] Then
    pProcessaPerfilEntrada(AConjPerfil, AstrCodAbf)
  Else
    pProcessaPerfilSaida(AConjPerfil, AstrCodAbf);
End;

procedure TAPISaneamento.pAbrirConsulta(RecParam: TRecParametrosApiSaneamento);
begin
  Try
    blnConsultaRealizada := False;
    recParametros := RecParam;

    qryItens.SQL.Clear;
    qryItens.SQL.Add(fGetSQL);
    qryItens.SQL.Add(fGetSQLWhere);

    pSetaParam(recParametros.Filtros.FilterCodItem        , recParametros.Filtros.FilterArrItem       , strCodIte, 'CODITE' , qryItens);
    pSetaParam(recParametros.Filtros.FilterCodFornecedor  , recParametros.Filtros.FilterArrFornecedor , strCodFor, 'CODFOR' , qryItens);
    pSetaParam(recParametros.Filtros.FilterCodLinhaGrupo  , recParametros.Filtros.FilterArrLinhaGrupo , strCodGru, 'CODGRU' , qryItens);
    pSetaParam(recParametros.Filtros.FilterAbvPis         , recParametros.Filtros.FilterArrAbvPis     , strAbfPis, 'ABFPIS' , qryItens);
    pSetaParam(recParametros.Filtros.FilterAbvCofins      , recParametros.Filtros.FilterArrAbvCofins  , strAbfCof, 'ABFCOF' , qryItens);
    pSetaParam(recParametros.Filtros.FilterAbvIpi         , recParametros.Filtros.FilterArrAbvIpi     , strAbfIpi, 'ABFIPI' , qryItens);
    pSetaParam(recParametros.Filtros.FilterCodEmpresa     , recParametros.Filtros.FilterArrEmpresa    , strCodEmp, 'CODEMP' , qryItens);
    pSetaParam(recParametros.Filtros.FilterNCM            , recParametros.Filtros.FilterArrNCM        , strCodNcm, 'CLAIPI' , qryItens);
    pSetaParam(recParametros.Filtros.FilterAbvICMS        , recParametros.Filtros.FilterArrAbvICMS    , strCodAbf, 'CODABF' , qryItens);


    qryItens.SQL.Add('ORDER BY ' + RecParam.strCampoOrdenacao);

    fAbrirQuery;
  Except
    on e: Exception do
     pMensagensErro(E.Message, '[TAPISaneamento.pAbrirConsulta]');

  End;
end;

procedure TAPISaneamento.pAlimentaCds(AStrCodAbf: String);
var
  Perfil: TPerfil;
Begin
 { If Not recParametros.Comparativos.blnIcms Then
    Exit;

  If recParametros.Filtros.FilterPerfis = [] Then
  begin
    If VersaoAutcomApi = 72 then
      recParametros.Filtros.FilterPerfis := [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS]
    Else
      recParametros.Filtros.FilterPerfis := [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS];
  End;
  }
  For Perfil in recParametros.Filtros.FilterPerfis do
     pProcessaPerfil(Perfil, AStrCodAbf);
End;

function TAPISaneamento.fPerfilEntrada(APerfil: String): Boolean;
var ConjPerfil: TPerfil;
begin
  ConjPerfil := fGetPerfilItem(APerfil);
  Result :=  (ConjPerfil in [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII]);
End;

procedure TAPISaneamento.pAlimentaCdsPerfil(APerfil, ACodSit, AOrigem, AField, ADescricao: String; AEstadoOri: String = ''; AEstadoDes:String = ''; AstrCodAbf: String = '');
var strValorTratado, strValues:String;
    strUfEmp: String;
    strEstadoEmp: String;
    strCfopOri,
    strCfop: String;
    strPerEnt: String;
Begin
  If AEstadoOri = 'EX' Then
    Exit;
  If AEstadoDes = 'EX' Then
    Exit;
  strEstadoEmp := qryEstados.FieldByName('ESTADO').AsString;
  If fPerfilEntrada(APerfil) Then
  Begin
    strUfEmp := IIf(AEstadoOri = strEstadoEmp, 1, 0);
    strCfopOri := IIf(AEstadoDes =  AEstadoOri, '1', '2');
    strPerEnt  := '1';
  End
  Else
  begin
    strUfEmp := IIf(AEstadoDes = strEstadoEmp, 1, 0);
    strCfopOri := IIf(AEstadoDes =  AEstadoOri, '5', '6');
    strPerEnt := '0';
  End;

  strCFOP := strCfopOri + IIF(Pos(ACodSit, CST_SUBSTITUICAO) > 0, '403', '102');

  If Pos('"', strPrcDesIte) > 0 Then
    strPrcDesIte := StringReplace(strPrcDesite, '"', '', [rfReplaceAll]);

  strValorTratado := fRetValorTratado(AField, ADescricao);
  strValues := '"' + strPrcDesIte + '",' +      //  TMP_DESITE,
               '"' + APerfil +'",' +            //  TMP_PERFIL,
               '"' + ACodSit +'",'+             //  TMP_CODSIT,
               '"' + AOrigem + '",' +           //  TMP_ORIGEM,
               '"' + strPrcCodIte +'",'+        //  TMP_CODITE,
               '"' + strPrcCodBar +'",'+        //  TMP_CODBAR,
               '"' + strPrcClaIpi +'",'+        //  TMP_CLAIPI,
               '"' + AField +'",'+              //  TMP_DESCRI,
              '"' + ' ' + ADescricao +'",'+     //  TMP_DESCUI,
              '"' + AEstadoOri +'",'  +         //  TMP_UFORI_,
              '"' + AEstadoDes + '",' +         //  TMP_UFDES_,
              '"' + strValorTratado + '",' +    //  TMP_VLRAUT
              '"' +  strUfEmp + '",' +          //  TMP_UFEMPE
              '"' + strCFOP + '",' +            //  TMP_CFOP
              '"' + strPerEnt + '",' +          //  TMP_PERENT
              '"' + AstrCodAbf + '"';            //  TMP_CODABF
  If strScript= '' Then
    strScript:= strInsert + '(' + strValues + ')'
  Else
    strScript := strScript + ', (' + strValues + ')';

End;

function TAPISaneamento.fRetValorTratado(AField: String; ADescricao: String): String;
begin
  Result := qryItens.FieldByName(AField).AsString;
  If Pos('CODSIT', AField) > 0 Then
    Result  := AnsiRightStr(Result,2)
  Else If Pos('ALQ', AField) > 0 Then
    Result := FormatFloat('##0.00', StrToFloatDef(Result, 0))
  Else If Pos('REDUÇÃO', ADescricao) > 0 Then
    Result := FormatFloat('##0.00', 100 - IIf(StrToFloatDef(Result, 0) = 0, 100, StrToFloatDef(Result, 0)))
  Else If Pos('IVA', AField) > 0 Then
    Result := FormatFloat('#0.0000', StrToFloatDef(Result, 0));
  Result := fRemoveVirgula(Result);
End;

procedure TAPISaneamento.pCriarTabelaTemporaria;
begin
 Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_ITESAN;');
    qryAux.SQL.Add('     CREATE TEMPORARY TABLE TMP_ITESAN(   ');
    qryAux.SQL.Add('            TMP_DESITE VARCHAR(250),      ');
    qryAux.SQL.Add('            TMP_PERFIL CHAR(3),           ');
    qryAux.SQL.Add('            TMP_CODSIT CHAR(3),           ');
    qryAux.SQL.Add('            TMP_CODABF CHAR(3),           ');
    qryAux.SQL.Add('            TMP_ORIGEM CHAR(1),           ');
    qryAux.SQL.Add('            TMP_CODITE VARCHAR(7),        ');
    qryAux.SQL.Add('            TMP_CODBAR VARCHAR(20),       ');
    qryAux.SQL.Add('            TMP_CLAIPI VARCHAR(10),       ');
    qryAux.SQL.Add('            TMP_DESCRI VARCHAR(75),       ');
    qryAux.SQL.Add('            TMP_DESCUI VARCHAR(75),       ');
    qryAux.SQL.Add('            TMP_UFORI_ CHAR(2),           ');
    qryAux.SQL.Add('            TMP_UFDES_ CHAR(2),           ');
    qryAux.SQL.Add('            TMP_VLRAUT VARCHAR(15),       ');
    qryAux.SQL.Add('            TMP_VLRAPI VARCHAR(15),       ');
    qryAux.SQL.Add('            TMP_UFEMPE INT,           ');
    qryAux.SQL.Add('            TMP_PERENT INT,           ');
    qryAux.SQL.Add('            TMP_CFOP CHAR(4),             ');
    qryAux.SQL.Add('            INDEX `IDX1` (`TMP_CODITE`, `TMP_DESCRI`),');
    qryAux.SQL.Add('            INDEX `IDX2` (`TMP_CODITE`, `TMP_PERFIL`, `TMP_DESCRI`, `TMP_UFORI_`),');
    qryAux.SQL.Add('            INDEX `IDX3` (`TMP_CODITE`, `TMP_PERFIL`, `TMP_DESCRI`, `TMP_UFDES_`))');
    qryAux.ExecSQL;
  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, '[TAPISaneamento.pCriarTabelaTemporaria]');
    End;
  End;
end;

class function TAPISaneamento.fGetConjPerfis(strPerfil: string): TConjPerfis;
begin
 If VersaoAutcomApi = 72 Then
  Begin
    case AnsiIndexStr(UpperCase(strPerfil), PERFIS_ICMS_72) of
       0 : Result := [cjpPEF];
       1 : Result := [cjpPEJ];
       2 : Result := [cjpPER];
       3 : Result := [cjpPES];
       4 : Result := [cjpPSI];
       5 : Result := [cjpNCO];
       6 : Result := [cjpCCO];
       7 : Result := [cjpCNC];
       8 : Result := [cjpSNA];
       9 : Result := [cjpCTA];
      10 : Result := [cjpPRU];
      11 : Result := [cjpIND];
      12 : Result := [cjpTRS];
    end;
  End
  Else
  Begin
    case AnsiIndexStr(UpperCase(strPerfil), PERFIS_ICMS) of
       0 : Result := [cjpPEF];
       1 : Result := [cjpPEJ];
       2 : Result := [cjpPER];
       3 : Result := [cjpPES];
       4 : Result := [cjpPSI];
       5 : Result := [cjpPII];
       6 : Result := [cjpNCO];
       7 : Result := [cjpCCO];
       8 : Result := [cjpCNC];
       9 : Result := [cjpSNA];
      10 : Result := [cjpCTA];
      11 : Result := [cjpPRU];
      12 : Result := [cjpIND];
      13 : Result := [cjpTRS];
    end;

  End;
end;

function TApiSaneamento.fAutenticar: Boolean;
begin
  Result := TfrmGravando.fExecuta(fAutenticarAux, frmGravando, 'Autenticando...');
end;

function TApiSaneamento.fAutenticarAux(pgbProgresso: TcxProgressBar): Boolean;
var
  jsnResposta: TJSONObject;
  jsnSucesso: TJSONBool;
begin
  pgbProgresso.Visible := False;
  Application.ProcessMessages;
  Try
    RESTCli.BaseURL := 'http://consultatributos.com.br:8080/api/v1/public/GetStatusCliente/'+strUsuario;
    RESTReq.Method := rmGET;
    RESTReq.Execute;

    jsnResposta := TJSONObject.ParseJSONValue(RESTRes.JSONText) as TJSONObject;
    Try
      jsnSucesso := (jsnResposta.GetValue('sucesso')) As TJSONBool;
    Except
      Exit(False);
    End;

    If Not Assigned(jsnSucesso) Then
      Exit(False);

    Result := (jsnSucesso As TJSONBool).AsBoolean;
  Except On
    E:Exception Do
    Begin
      Result := False;
      stlErros.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss', fNow) + ' | Erro ao autenticar usuário '+ strUsuario );
      pMensagensErro(E.Message, '[TApiSaneamento.fAutenticarAux]');
    End;
  End;
end;

class function TApiSaneamento.fConvertStringToPerfil(APerfil: String): TPerfil;
begin
  Result := cjpPEF;
  If VersaoAutcomApi = 72 then
  Begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS_72) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       5 : Result := cjpNCO;
       6 : Result := cjpCCO;
       7 : Result := cjpCNC;
       8 : Result := cjpSNA;
       9 : Result := cjpCTA;
      10 : Result := cjpPRU;
      11 : Result := cjpIND;
      12 : Result := cjpTRS;
    end;
  End
  Else
  Begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       5 : Result := cjpPII;
       6 : Result := cjpNCO;
       7 : Result := cjpCCO;
       8 : Result := cjpCNC;
       9 : Result := cjpSNA;
      10 : Result := cjpCTA;
      11 : Result := cjpPRU;
      12 : Result := cjpIND;
      13 : Result := cjpTRS;
    end;
  End;
end;


class function TApiSaneamento.fGetNumbers(strTexto: String): String;
  Var
    intPos: Integer;
begin
  Result := '';
  For intPos := 1 To Length(strTexto) Do
    If CharInSet(strTexto[intPos], ['0'..'9']) Then
      Result := Result + strTexto[intPos];
end;

class function TApiSaneamento.fGetPerfilItem(APerfil: String): TPerfil;
begin
  Result := cjpIndef;
  If VersaoAutcomApi = 72 Then
  Begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS_72) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       6 : Result := cjpNCO;
       7 : Result := cjpCCO;
       8 : Result := cjpCNC;
       9 : Result := cjpSNA;
      10 : Result := cjpCTA;
      11 : Result := cjpPRU;
      12 : Result := cjpPRU;
      13 : Result := cjpTRS;
    end;
  End
  Else
  begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       5 : Result := cjpPII;
       6 : Result := cjpNCO;
       7 : Result := cjpCCO;
       8 : Result := cjpCNC;
       9 : Result := cjpSNA;
      10 : Result := cjpCTA;
      11 : Result := cjpPRU;
      12 : Result := cjpPRU;
      13 : Result := cjpTRS;
    end;
  End;
end;


function TApiSaneamento.fValidarConfigs: Boolean;
begin
  Result := True;
  If fEmptyStr(strURL) Then
    Exit(False);
  If fEmptyStr(strUsuario) Then
    Exit(False);
  If fEmptyStr(strSenha) Then
    Exit(False);
  If fEmptyStr(intReqs.toString) Then
    Exit(False);
end;

function TApiSaneamento.fGetCaracTrib(APrefil: TPerfil): String;
begin
    Result := '';
    qryPRFSAN.First;
    If qryPRFSAN.Locate('PRF_PERFIL', fConvertConfPerfilToString(APrefil), []) Then
      Result := qryPRFSAN.FieldByName('PRF_CODIGO').AsString;
End;

procedure TApiSaneamento.pInicializarQueryEmitente;
begin
  qryEmit.SQL.Clear;
  qryEmit.SQL.Add('SELECT                                           ');
  qryEmit.SQL.Add('  EMP_C_G_C_ AS CNPJ,                            ');
  qryEmit.SQL.Add('  CID_ESTADO AS UF,                              ');
  qryEmit.SQL.Add('  EMP_CNAEFI AS CNAE,                            ');
  qryEmit.SQL.Add('  IF(EMP_REGTRI = "S", "1", "3") AS CRT,         ');
  qryEmit.SQL.Add('  IF(EMP_REGTRI = "P","LP","LR") AS REGIMETRIB   ');
  qryEmit.SQL.Add('FROM                                             ');
  qryEmit.SQL.Add('  CADEMP                                         ');
  qryEmit.SQL.Add('  INNER JOIN CADCID                              ');
  qryEmit.SQL.Add('    ON CID_CODCID = EMP_CODCID                   ');
  qryEmit.SQL.Add('WHERE EMP_CODEMP = ' +QuotedStr(VS_strCodEmp)     );
  qryEmit.Open;
end;


procedure TApiSaneamento.pSetaHeaders(ARESTReq: TRESTRequest);
begin
  ARESTReq.Params.AddHeader('login', strUsuario);
  ARESTReq.Params.AddHeader('senha', strSenha);
  ARESTReq.Params.AddHeader('Content-Type', CONTENT_TYPE);
  ARESTReq.Params.ParameterByName('senha').Options := [poDoNotEncode];
  ARESTReq.Params.ParameterByName('Content-Type').Options := [poDoNotEncode];
  ARESTReq.Params.ParameterByName('login').Options := [poDoNotEncode];
end;








end.






