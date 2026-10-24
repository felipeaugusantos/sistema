unit iMendes.Comunicador;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni, UniClientDataSet, madStackTrace,
{$ENDIF}
  System.Classes, System.SysUtils, Data.DB, IPPeerClient, System.TypInfo, System.IOUtils,
  REST.Client, StrUtils, System.JSON, REST.Authenticator.Basic,
  REST.Types, System.SyncObjs, Variants, CRAccess, iMendes.Types, iMendes.Threads, iMendes.GerenciaEstado,
  iMendes.ProcessaAlterados;

type
  TAfterScroll = procedure (DataSet: TDataSet) of Object;

  TAPISaneamento = class
    private
      strAbfPis,
      strAbfIpi,
      strCodFor,
      strCodGru,
      strCodIte,
      strCodNCM,
      strCodAbf,
      strCodEmp,
      strAbfCof: String;
      {$IFNDEF LINUX}
      conConexao: TUniConnection;
      {$ENDIF}
      RESTReq: TRESTRequest;
      RESTCli: TRESTClient;
      RESTRes: TRESTResponse;
      HTTPAuth: THTTPBasicAuthenticator;
      intTimeout: Integer;
      strURL,
      strUrlAtu,
      strUsuario,
      strSenha: String;
      intReqs: Integer;
      FParamnsComunicador: TParamsComunicador;
      FDiretorioJSON : String;
      VariaveisDeControle : TVariaveisDeControle;
      FProcessoAtual : String;
      Procedure pSetaHeaders(ARESTReq: TRESTRequest);
      Function fValidarConfigs:Boolean;
      procedure pInicializarConexao;
      Function fGetSQL: String;
      Function fGetSQLWhere: String;
      Function fInicializarQuery: Boolean;
      Function fConsultarItens():Boolean;
      procedure pEnviaNotificacaoImendesAlterados;
      function fGetParamsComunicador: TParamsComunicador;
      //Threads
      procedure pIniciaThread;
      Function fEnviarItens(out numErros:Integer):Boolean;

      function fAutenticar(var strMensagem: String): Boolean;
      Function fAutenticarAux(var strMensagem: String): Boolean;
      //Nova estrutura
      procedure pSelecionaItens;
      procedure pCriaEstruturaBanco;
      procedure pExecutaComunicacaoIMendes;
      function fInsereIMENDES_RESULTADO(blnParcial: Boolean; ADados, AQryItens: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}; strAutoincrem:String): Boolean;

      procedure pAtualizaStatus;
      procedure pAlimentaTabelas_IMENDES_ITENS;
      procedure pCriaEstruturaImendes_Resultado;
      procedure pCriaEstruturaCampoTempoEstimado;
      procedure pAlimentaTABNRE;
      procedure pCriaEstruturaContadorRequisicao;
      procedure pCriaEstruturaCamposCODBEN;

      procedure pCriaEstruturaImendes_Json;

      procedure pCarregaItensParaProcessar(blnFiltraIME_REPROS: Boolean = False);

    public
      dtsItens: TDataSource;
      qryLog: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
      qryItens: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
      qryComand: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
      qryItensResultado: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
      qryTemporizador: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
      blnUtiAbi,
      blnDarRor,
      blnUtiAbr,
      blnConfigsValidadas,
      blnAutenticado: Boolean;
      recParametros: TRecParametrosApiSaneamento;
      OnAfterScroll : TAfterScroll;
      blnConsultaRealizada: Boolean;
      GerenciaEstado :TGerenciaEstado;
      constructor Create(var strMensagem: String;AstrCodEmp: String; blnAutcom: Boolean = False; {$IFNDEF LINUX}AConnection: TUniConnection = nil; {$ENDIF}AAutInc: string = ''; AAgrup: String = '');
      Destructor Destroy; override;
      procedure pAbrirQuery;
      Procedure pPesquisar(out intErros: Integer);
      procedure pAbrirConsulta();
      procedure pProcessa(RecParam: TRecParametrosApiSaneamento);
      procedure pPreparaReprocessamentoParcial;
      procedure pProcessaAlterados;
      class function fValidaConexao(var Retorno: String; ACodEmp: String;  blnAutcom: Boolean{$IFNDEF LINUX}; AConnection: TUniConnection{$ENDIF}): Boolean;
      procedure ApenasReprocessaResultado(blnparcial: Boolean = False);


  end;

  function fRemoveVirgula(Value: String): String;


implementation

uses
  iMendes.Functions, iMendes.Constantes, untConstantes;

{ TAPISaneamento }

procedure TAPISaneamento.pInicializarConexao;
begin

{$IFDEF LINUX}
  objConnectionsManager.BeginConnection();
{$ELSE}
  conConexao := TUniConnection.Create(nil);
{  conConexao.ProviderName := 'MySQL';
  conConexao.Username := 'autcom_citel';
  conConexao.Password := 'belamupe_citel';
  conConexao.Server := '10.0.0.205';
  conConexao.Database := 'AUTCOM_SAO_LUIZ';
  conConexao.Port := 49658;
  conConexao.DefaultTransaction.IsolationLevel := DEFAULT_ISOLATION_LEVEL_UNIDAC;}

  conConexao := {$IFDEF LINUX}IConnection{$ELSE}TUniConnection{$ENDIF}.Create(nil);
  conConexao.ProviderName := 'MySQL';
  conConexao.DefaultTransaction.IsolationLevel := DEFAULT_ISOLATION_LEVEL_UNIDAC;
  pConectar(conConexao);

  Try
    conConexao.Connect;
  Except
    On E: Exception Do
    Begin
      Sleep(1000);
      conConexao.Connect;
    End;
  End;
{$ENDIF}
end;

procedure TAPISaneamento.ApenasReprocessaResultado(blnParcial: Boolean = False);
var Terminou: Boolean;
    qtd: integer;
begin

  qryComand.SQL.Clear;
  If blnparcial then
  Begin
    qryItensResultado.SQL.Clear;
    qryItensResultado.SQL.Add('SELECT IME_CODITE FROM  IMENDES_ITENS');
    qryItensResultado.SQL.Add(' WHERE IMENDES_ITENS.IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'"');
    qryItensResultado.SQL.Add('   AND IME_REPROS = 1');

    qryItensResultado.Open;

    while not qryItensResultado.Eof do
    Begin
      qryComand.SQL.Clear;
      qryComand.SQL.Add('DELETE FROM IMENDES_RESULTADO');
      qryComand.SQL.Add('WHERE IME_CODITE = "'+qryItensResultado.FieldByName('IME_CODITE').AsString+'"');
      qryComand.SQL.Add('  AND IMENDES_RESULTADO.IME_SEQCON ="'+GerenciaEstado.AutIncRegAtual+'"');
      qryComand.ExecSQL;
      qryItensResultado.Next;
    End;
  End
  Else
  Begin
    qryItensResultado.SQL.Clear;
    qryItensResultado.SQL.Add('SELECT COUNT(1) AS QTD FROM IMENDES_RESULTADO WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" LIMIT 1');
    qryItensResultado.Open;
    qtd :=  qryItensResultado.FieldByName('QTD').AsInteger;
    qryItensResultado.Close;
    qryComand.SQL.Add('DELETE FROM IMENDES_RESULTADO WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" LIMIT 25000');
    Terminou := false;

    while not Terminou do
    Begin
      If qtd > 25000 then
        pEscreveLog('Deletando Resultados.... 25000 /  ' + qtd.ToString(), True)
      Else
        pEscreveLog('Deletando Resultados.... ' +qtd.ToString()+ ' /  ' + qtd.ToString(), True);
      qryComand.ExecSQL;
      qryItensResultado.Open;
      Terminou := qryItensResultado.FieldByName('QTD').AsInteger = 0;
      qtd :=  qryItensResultado.FieldByName('QTD').AsInteger;
      qryItensResultado.Close;
    End
  End;

  fInsereIMENDES_RESULTADO(blnParcial, qryComand, qryItensResultado, GerenciaEstado.AutIncRegAtual);

end;

constructor TAPISaneamento.Create(var strMensagem: String;AstrCodEmp: String; blnAutcom: Boolean = False; {$IFNDEF LINUX}AConnection: TUniConnection = nil; {$ENDIF}AAutInc: string = ''; AAgrup: String = '');
var
  lPrefixosValidosCodigoBarra: String;
begin
  FProcessoAtual := '';
  PrefixosValidosCodigoBarra :=  '';
  Try
    PrefixosValidosCodigoBarra := iMendesfCfgSis('PRECIM', varString, strCodEmp);
  Except
    PrefixosValidosCodigoBarra := '';
  End;
  PrefixosValidosCodigoBarra := Transform('789790779' + PrefixosValidosCodigoBarra, 3, '-');
  If Not blnAutcom Then
  Begin
    pInicializarConexao;
    VariaveisDeControle := TVariaveisDeControle.Create(strCodEmp);
    GerenciaEstado := TGerenciaEstado.Create;
    GerenciaEstado.SetaRegistroAtual(AAutInc);
    GerenciaEstado.SetaRegistroAgrupador(AAgrup);

    blnConsultaRealizada := False;
    fInicializarQuery;
//    VariaveisDeControle.SessaoCritica := TCriticalSection.Create;
  End
  Else
  Begin
   {$IFNDEF LINUX}
    conConexao := AConnection;
    iMendes_Connection := AConnection;
   {$ENDIF}

  End;
  iF AstrCodEmp = '' Then
    strCodEmp := {$IFNDEF LINUX}iMendes_strCodEmp{$ELSE}VS_strCodEmp{$ENDIF}
  Else
    strCodEmp := AstrCodEmp;
  blnDarRor := False;
  If fTemCfgDARROR({$IFNDEF LINUX}conConexao{$ENDIF}) Then
    blnDarRor := iMendesfCfgSis('DARROR', varBoolean, strCodEmp);

  qryComand := iMendesCriaQuery({$IFNDEF LINUX}conConexao{$ENDIF});
  qryItensResultado := iMendesCriaQuery({$IFNDEF LINUX}conConexao{$ENDIF});
  qryTemporizador := iMendesCriaQuery({$IFNDEF LINUX}conConexao{$ENDIF});
  qryLog := iMendesCriaQuery({$IFNDEF LINUX}conConexao{$ENDIF});
  RESTCli := TRESTClient.Create(strURL);
  RESTReq := TRESTRequest.Create(Nil);
  RESTRes := TRESTResponse.Create(Nil);


  strURL     := iMendesfCfgSis('URLSAN', varString, strCodEmp);
  strURLATU  := iMendesfCfgSis('URLATU', varString, strCodEmp);

  strUsuario := iMendesfCfgSis('USRSAN', varString, strCodEmp);
  strSenha   := AutComfDecriptar(iMendesfCfgSis('SNHSAN', varString, strCodEmp));
  {$IFNDEF LINUX}
  intTimeout := iMendesfCfgSis('TMOSAN', varInteger, strCodEmp);
  {$ELSE}
  intTimeout := iMendesfCfgSis('TMOSAN', varInteger, strCodEmp) * 1000;
   {$ENDIF}
  intReqs    := iMendesfCfgSis('RQTSAN', varInteger, strCodEmp);
  FDiretorioJSON := iMendesfCfgSis('IMJDIR', varString, strCodEmp);



  RESTCli.Accept := ACCEPT;
  RESTCli.AcceptCharset := ACCEPT_CHARSET;
  RESTCli.HandleRedirects := True;

  RESTReq.Accept := ACCEPT;
  RESTReq.AcceptCharset := ACCEPT_CHARSET;
  RESTReq.Client := RESTCli;
  RESTReq.Response := RESTRes;
  RESTReq.Timeout := intTimeout;

  pSetaHeaders(RESTReq);

  blnConfigsValidadas := fValidarConfigs;
  try
    blnAutenticado := fAutenticar(strMensagem);
  Except
    on e: Exception do
    Begin
      If Not blnAutcom Then
      begin
        GerenciaEstado.pAtualizaMaquinaEstado(epFalhaAutenticacao);
        TIMENDES_LOGTHREAD.pGravaLog(GerenciaEstado.AutIncRegAtual, '[TAPISaneamento.Create]', '', '', '', e.message, nil, VariaveisDeControle
          {$IFNDEF LINUX}, StackTrace{$ENDIF});
        pEscreveLog('Falha ao autenticar usuario! Erro do servidor iMendes: ' + e.message, True);
      End
      Else
       raise Exception.Create(e.Message);

    End;
  End;

end;

destructor TAPISaneamento.Destroy;
begin

{$IFDEF LINUX}
{$ELSE}
  FreeAndNil(qryLog);
  FreeAndNil(qryItens);
  FreeAndNil(qryComand);
  FreeAndNil(qryItensResultado);
  FreeAndNil(qryTemporizador);

{$ENDIF}
  FreeAndNil(dtsItens);
  FreeAndNil(RESTCli);
  FreeAndNil(RESTReq);
  FreeAndNil(RESTRes);
  FreeAndNil(HTTPAuth);
  FreeAndNil(VariaveisDeControle);
end;

procedure TAPISaneamento.pAbrirQuery;
begin

  qryItens.Open;
end;

procedure TAPISaneamento.pPesquisar(out intErros: Integer);
begin

  blnConsultaRealizada := False;
  If fEnviarItens(intErros) Then
  Begin
    intErros := intErros;
    blnConsultaRealizada := true;
  End
end;

function TAPISaneamento.fGetSQL: String;
var
  strAliasTpaBpc: String;
begin

  blnUtiAbi := iMendesfCfgSis('UTIABI', varBoolean, recParametros.Filtros.FilterCodEmpresa);
  blnUtiAbr := iMendesfCfgSis('UTIABR', varBoolean, recParametros.Filtros.FilterCodEmpresa);
  strAliasTpaBpc := IfThen(iMendesfCfgSis('TPABPC', varString, recParametros.Filtros.FilterCodEmpresa) = '1' , 'C','I');

  Result := '';
  Result := Result + 'SELECT * FROM (';
  Result := Result + 'SELECT                           ';
  Result := Result + ' CAST(CONCAT(C.ITE_DESITE, "<TAG_AUTCOM>", C.ITE_CODITE," - ",      ';
  Result := Result + '        C.ITE_DESITE," - ",      ';
  Result := Result + '        U.UNI_SIGUNI," - ",      ';
  Result := Result + '        C.ITE_CODBAR) AS CHAR(255)) AS DESCRI, ';
  Result := Result + '        C.ITE_CODITE, ';
  Result := Result + '        IF(SIS_VALCFG = 1, C.ITE_CODABF, I.ITE_CODABF) AS  ABF_CODABF, ';
  Result := Result + '        C.ITE_CODBAR AS IME_CODBAR, ';
  Result := Result + '        C.ITE_CDCEST, ';
  Result := Result + '        C.ITE_CLAIPI, ';
  Result := Result + '        C.ITE_DESITE, ';
  Result := Result + '        I.ITE_IPISAI, ';
  Result := Result + '        C.ITE_CSTORI, ';
  Result := Result + '        I.ITE_CODEMP, ';
  Result := Result + '        ITE_CODLUB ';

  Result := Result + ' FROM                            ';
  Result := Result + '  CADITE C                       ';

  Result := Result + '  INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE  ';
  Result := Result + '   LEFT JOIN CADFOR CF ON CF.FOR_CODFOR = C.ITE_CODFOR  ';
  Result := Result + '   LEFT JOIN CADUNI U ON U.UNI_CODUNI = C.ITE_CODUNI  ';
  Result := Result + '  INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPABF" AND SIS_CODEMP = I.ITE_CODEMP  ';
  Result := Result + '  LEFT JOIN ABFICM ON ABF_CODABF = IF(SIS_VALCFG = "1", C.ITE_CODABF, I.ITE_CODABF)  ';
  If recParametros.ProdutosAlterados Then
    Result := Result + '  INNER JOIN IMENDES_ALTERADOS ON IMENDES_ALTERADOS.IME_CODITE = I.ITE_CODITE AND IMENDES_ALTERADOS.IME_CODEMP = I.ITE_CODEMP AND IMENDES_ALTERADOS.IME_ALTERA = "S" ';

end;

function TAPISaneamento.fGetSQLWhere: String;
var
  blnTipAbfGeral,
  blnTipAbpcGeral: Boolean;
begin

  blnTipAbfGeral  := iMendesfCfgSis('TIPABF', varString, recParametros.Filtros.FilterCodEmpresa) = '1';
  blnTipAbpcGeral := iMendesfCfgSis('TPABPC', varString, recParametros.Filtros.FilterCodEmpresa) = '1';

  Result := '';
  Result := 'WHERE TRUE ';

  if fCampoExiste({$IFNDEF LINUX}conConexao,{$ENDIF}
                  {$IFNDEF LINUX}conConexao.DataBase {$ELSE} objConnectionsManager.CurrentConnection.Database{$ENDIF}, 'CADITE', 'ITE_USAIME') then
    Result := Result + ' AND C.ITE_USAIME = "S" ';

  If Not (recParametros.Filtros.FilterDescricaoDoItem = '') Then
  Begin
    Result := Result + 'AND C.ITE_DESITE LIKE '+ QuotedStr('%'+ recParametros.Filtros.FilterDescricaoDoItem +'%');
  End;

  If strCodEmp <> '' Then
    Result := Result + ' AND I.ITE_CODEMP = "' + strCodEmp + '"'
  Else
    Result := Result + fStrLocate(recParametros.Filtros.FilterCodEmpresa , recParametros.Filtros.FilterArrEmpresa  , 'I.ITE_CODEMP', 'CODEMP');
  Result := Result + fStrLocate(recParametros.Filtros.FilterCodFornecedor , recParametros.Filtros.FilterArrFornecedor  , 'C.ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocateLinGru(recParametros.Filtros.FilterCodLinhaGrupo, recParametros.Filtros.FilterArrLinhaGrupo, 'C.ITE_CODGRU', 'CODGRU');
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

  Result := Result + ' AND C.ITE_ITEATI = "S" ';

end;

function TAPISaneamento.fInicializarQuery: Boolean;
begin

  Try
    qryItens := iMendesCriaQuery({$IFNDEF LINUX}conConexao{$ENDIF});
    Result := True;
  Except On
    E:Exception Do
    Begin
      Result := False;
    End;
  End;
end;


procedure TAPISaneamento.pPreparaReprocessamentoParcial;
var strCodIte: String;
begin

  pCarregaItensParaProcessar(True);
  strCodIte := '';
  while not qryItens.Eof Do
  Begin
    strCodIte :=  strCodIte + IfThen(strCodIte = '', '', ',') +' "' + qryItens.FieldByName('IME_CODITE').AsString + '"';
    qryItens.Next;
    pEscreveLog('Deletando estrutura ' + intTostr(qryItens.RecordCount) + '/' + IntToStr(qryItens.RecNo), True);
    If qryItens.Eof then
    Begin
      qryComand.SQL.Clear;
      qryComand.SQL.Add('DELETE FROM IMENDES_JSON WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_CODITE IN ('+strCodIte+');');
      qryComand.SQL.Add('DELETE FROM IMENDES_ABFICM WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_CODITE IN ('+strCodIte+');');
      qryComand.SQL.Add('DELETE FROM IMENDES_RESULTADO WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_CODITE IN ('+strCodIte+');');
      qryComand.ExecSQL;
      strCodIte := '';
    End
    Else If (qryItens.RecNo Mod 30) = 0 then
    Begin
      qryComand.SQL.Clear;
      qryComand.SQL.Add('DELETE FROM IMENDES_JSON WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_CODITE IN ('+strCodIte+');');
      qryComand.SQL.Add('DELETE FROM IMENDES_ABFICM WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_CODITE IN ('+strCodIte+');');
      qryComand.SQL.Add('DELETE FROM IMENDES_RESULTADO WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_CODITE IN ('+strCodIte+');');
      qryComand.ExecSQL;
      strCodIte := '';
    End

  End;

end;

procedure TAPISaneamento.pProcessa(RecParam: TRecParametrosApiSaneamento);
begin
  Try

    recParametros := RecParam;
    If GerenciaEstado.EstadoAtual = epRecriaTabelaResultado Then
    Begin
       ApenasReprocessaResultado;
       GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoOk);
       Exit;
    End;


    If GerenciaEstado.EstadoAtual = epRecriaTabelaResultadoParcial Then
    Begin
       ApenasReprocessaResultado(True);
       GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoOk);
       Exit;
    End;

    If GerenciaEstado.EstadoAtual = epReprocessaItensParcialmente Then
     pPreparaReprocessamentoParcial
    Else If GerenciaEstado.EstadoAtual = epCriandoEstruturaBanco Then
      GerenciaEstado.pVoltaEstado(epIniciaprocesso)
    Else If GerenciaEstado.EstadoAtual = epProcessando Then
      pCarregaItensParaProcessar;


    FParamnsComunicador := fGetParamsComunicador;

    pCriaEstruturaCampoTempoEstimado;
    pCriaEstruturaContadorRequisicao;
    pCriaEstruturaCamposCODBEN;

    pAlimentaTABNRE;

    While Not (GerenciaEstado.EstadoAtual in [ epFinalizadoOk, epFinalizadoSemItem, epFinalizadoComErro, epFinalizadoPeloAutcom, epFalhaAutenticacao, epFinalizadoItemNaoEncontradoNaImendes]) do
    begin
      case GerenciaEstado.EstadoAtual of
        epAlterados: pProcessaAlterados;
        epPendente : pAtualizaStatus;
        epIniciaprocesso: pSelecionaItens;
        epCriandoEstruturaBanco : pCriaEstruturaBanco;
        epReprocessaItensParcialmente,
        epProcessando : pExecutaComunicacaoIMendes;
        epIndefinido  : GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoOk);
      end;
    End;
    If GerenciaEstado.EstadoAtual = epFinalizadoPeloAutcom Then
      GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoPeloAutcom)
  Except
    on e: Exception do
    Begin
      blnNotificaExecucao := False;
      raise Exception.Create(FProcessoAtual + e.Message);
    End;

  End;
end;


procedure TAPISaneamento.pProcessaAlterados;
var ProcessaAlterados: TProcessaAlterados;
begin

  ProcessaAlterados := TProcessaAlterados.Create(GerenciaEstado.AutIncRegAtual,{$IFNDEF LINUX}conConexao, {$ENDIF} FParamnsComunicador);
  Try
    ProcessaAlterados.pProcessa(GerenciaEstado);
  Finally
    FreeAndNil(ProcessaAlterados);
  End;
  {}
end;

procedure TAPISaneamento.pAbrirConsulta();
begin

  qryItens.SQL.Clear;
  If recParametros.Filtros.blnIncluindo Then
  Begin
    qryItens.SQL.Add('SELECT 0 AS SEQUEN, CAST("" AS CHAR(1)) AS DESCRI,');
    qryItens.SQL.Add('       CAST("" AS CHAR(1)) AS ITE_CODITE,');
    qryItens.SQL.Add('       CAST("" AS CHAR(1)) AS ABF_CODABF,');
    qryItens.SQL.Add('       "'+recParametros.Filtros.strCodEan+'" AS IME_CODBAR,');
    qryItens.SQL.Add('       CAST("" AS CHAR(1)) AS ITE_CDCEST,');
    qryItens.SQL.Add('       CAST("" AS CHAR(1)) AS ITE_CLAIPI,');
    qryItens.SQL.Add('       CAST("" AS CHAR(1)) AS ITE_DESITE,');
    qryItens.SQL.Add('       CAST("" AS CHAR(1)) AS ITE_IPISAI,');
    qryItens.SQL.Add('       "' + recParametros.Filtros.strCstOrigem + '" AS ITE_CSTORI, ');

    qryItens.SQL.Add('       CAST("'+ recParametros.Filtros.FilterCodEmpresa + '" AS CHAR(3)) AS ITE_CODEMP,');
    qryItens.SQL.Add('       CAST("" AS CHAR(1)) AS ITE_CODLUB');
    qryItens.Open;
    pAtualizaStatus;
    Exit;
  End;


  qryItens.SQL.Add('  SET @SEQUEN := -1;');
  qryItens.SQL.Add('SELECT  @SEQUEN := @SEQUEN + 1 AS SEQUEN, TMP2.* FROM(');



  qryItens.SQL.Add(fGetSQL);
  qryItens.SQL.Add(fGetSQLWhere);

  pSetaParam(recParametros.Filtros.FilterCodItem        , recParametros.Filtros.FilterArrItem       , strCodIte, 'CODITE' , qryItens);
  pSetaParam(recParametros.Filtros.FilterCodFornecedor  , recParametros.Filtros.FilterArrFornecedor , strCodFor, 'CODFOR' , qryItens);
  pSetaParam(recParametros.Filtros.FilterCodLinhaGrupo  , recParametros.Filtros.FilterArrLinhaGrupo , strCodGru, 'CODGRU' , qryItens);
  pSetaParam(recParametros.Filtros.FilterAbvPis         , recParametros.Filtros.FilterArrAbvPis     , strAbfPis, 'ABFPIS' , qryItens);
  pSetaParam(recParametros.Filtros.FilterAbvCofins      , recParametros.Filtros.FilterArrAbvCofins  , strAbfCof, 'ABFCOF' , qryItens);
  pSetaParam(recParametros.Filtros.FilterAbvIpi         , recParametros.Filtros.FilterArrAbvIpi     , strAbfIpi, 'ABFIPI' , qryItens);
  If strCodEmp = '' Then
    pSetaParam(recParametros.Filtros.FilterCodEmpresa     , recParametros.Filtros.FilterArrEmpresa    , strCodEmp, 'CODEMP' , qryItens);
  pSetaParam(recParametros.Filtros.FilterNCM            , recParametros.Filtros.FilterArrNCM        , strCodNcm, 'CLAIPI' , qryItens);
  pSetaParam(recParametros.Filtros.FilterAbvICMS        , recParametros.Filtros.FilterArrAbvICMS    , strCodAbf, 'CODABF' , qryItens);


  qryItens.SQL.Add('ORDER BY C.ITE_DESITE');
  qryItens.SQL.Add(') TMP ');
  qryItens.SQL.Add('  GROUP BY ITE_CODITE, ABF_CODABF');
  qryItens.SQL.Add('  ORDER BY DESCRI) TMP2');
  pAbrirQuery;



  pAtualizaStatus;

end;

procedure TAPISaneamento.pAlimentaTabelas_IMENDES_ITENS;
var strPonto: String;
    intQtdReg: integer;
    const cInsert = 'INSERT INTO IMENDES_ITENS(IME_SEQCON, IME_SEQORI, IME_SEQUEN, IME_CODITE, IME_CODABF, IME_CODBAR, IME_PROCES, IME_CDCEST, IME_CODNCM, IME_IPISAI, IME_CSTORI, IME_CODEMP, IME_CODLUB) VALUES';
begin

  qryItens.First;

  qryComand.SQL.Clear;
  qryComand.sql.add('DELETE FROM IMENDES_ITENS WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'"');
  qryComand.ExecSQL;

  qryComand.SQL.Clear;
  qryComand.SQL.Add(cInsert);
  intQtdReg := 0;
  while not qryItens.Eof Do
  Begin
    Inc(intQtdReg);
    If (qryItens.RecNo = qryItens.RecordCount) Or (intQtdReg = 100)then
      strPonto := ';'
    Else
      strPonto := ',';
    qryComand.SQL.Add('("' + GerenciaEstado.AutIncRegAtual + '",');         //IME_SEQCON
    qryComand.SQL.Add(' ' + qryItens.FieldByName('SEQUEN').AsString+ ',');  // IME_SEQORI
    qryComand.SQL.Add(' ' + qryItens.FieldByName('SEQUEN').AsString+ ',');  // IME_SEQUEN
    qryComand.SQL.Add(' "' + qryItens.FieldByName('ITE_CODITE').AsString+ '",'); // IME_CODITE
    qryComand.SQL.Add(' "' + qryItens.FieldByName('ABF_CODABF').AsString+ '",'); // IME_CODABF
    qryComand.SQL.Add(' "' + qryItens.FieldByName('IME_CODBAR').AsString+ '",'); // IME_CODBAR
    qryComand.SQL.Add(' "0",');  //IME_PROCES
    qryComand.SQL.Add(' "",');   //IME_CDCEST
    qryComand.SQL.Add(' "",');   //IME_CODNCM
    qryComand.SQL.Add(' "",');   //IME_IPISAI
    qryComand.SQL.Add(' "'+ qryItens.FieldByName('ITE_CSTORI').AsString+'",');   //    ITE_CSTORI
    qryComand.SQL.Add(' "' + qryItens.FieldByName('ITE_CODEMP').AsString + '",');   //IME_CODEMP
    qryComand.SQL.Add(' "")' + strPonto);  //IME_CODLUB
    If (intQtdReg= 100) then
    Begin
      qryComand.ExecSQL;
      intQtdReg := 0;
      qryComand.SQL.Clear;
      qryComand.SQL.Add(cInsert);
    End;

    qryItens.Next;
  End;
  If intQtdReg  > 0 Then
    qryComand.ExecSQL;

  pCarregaItensParaProcessar;

end;


procedure TAPISaneamento.pCriaEstruturaCamposCODBEN;
begin
  qryComand.SQL.Clear;
  Try
    qryComand.SQL.Add('SELECT IME_CODBEN FROM IMENDES_ABFICM WHERE FALSE');
    qryComand.Open;
  Except
    Try
      qryComand.SQL.Text := 'ALTER TABLE IMENDES_ABFICM ADD IME_CODBEN VARCHAR(8) DEFAULT NULL;';
      qryComand.ExecSQL;
    Except
    End;
  End;

  qryComand.SQL.Clear;
  Try

    qryComand.SQL.Add('SELECT ABF_CODBEN_ENT_PEF FROM IMENDES_RESULTADO WHERE FALSE');
    qryComand.Open;
  Except
    Try
      qryComand.SQL.Clear;
      qryComand.SQL.Add('ALTER TABLE `AUTCOM`.`IMENDES_RESULTADO`');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_ENT_PEF` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_ENT_PEJ` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_ENT_PER` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_ENT_PES` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_ENT_PSI` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_ENT_PII` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_NCO` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_CCO` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_CNC` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_SAN` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_CTA` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_PRU` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_IND` VARCHAR (8) DEFAULT '+ QuotedStr('') + ',');
      qryComand.SQL.Add('  ADD COLUMN `ABF_CODBEN_SAI_TRS` VARCHAR (8) DEFAULT '+ QuotedStr('') + ';');
      qryComand.ExecSQL;
    Except
    End;
  End;


end;

procedure TAPISaneamento.pCriaEstruturaCampoTempoEstimado;
begin
  qryComand.SQL.Clear;
  Try
    qryComand.SQL.Add('SELECT TEMPO_ESTIMADO FROM IMENDES_PARAM WHERE FALSE');
    qryComand.Open;
  Except
    Try
      qryComand.SQL.Text := 'ALTER TABLE IMENDES_PARAM ADD COLUMN TEMPO_ESTIMADO VARCHAR (100) NULL;';
      qryComand.ExecSQL;
    Except
    End;
  End;
End;

procedure TAPISaneamento.pCriaEstruturaContadorRequisicao;

begin
  qryComand.SQL.Clear;
  qryComand.sql.Add('CHECK TABLE IMENDES_REGISTRA_ENVIOS');
  qryComand.Open;
  If qryComand.FieldByName('Msg_text').AsString <> 'OK' Then
  Begin
    qryComand.SQL.Clear;
    qryComand.sql.Add('CREATE TABLE `IMENDES_REGISTRA_ENVIOS` (');
    qryComand.sql.Add('  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT,');
    qryComand.sql.Add('  `IME_SEQCON` VARCHAR(20) DEFAULT NULL,');
    qryComand.sql.Add('  `IME_CODITE` VARCHAR(7) DEFAULT NULL,                                                                                                         ');
    qryComand.sql.Add('  `IME_ARQUIVO` VARCHAR(100) DEFAULT NULL,');
    qryComand.sql.Add('  `IME_CHAVE_` VARCHAR(50) DEFAULT NULL,');
    qryComand.sql.Add('  `IME_DTAENV` DATETIME DEFAULT NULL,');
    qryComand.sql.Add('  `IME_DTARET` DATETIME DEFAULT NULL,');
    qryComand.sql.Add('  PRIMARY KEY (`ID`),');
    qryComand.sql.Add('  KEY `IDX_IMENDES_RE_SEQCON` (`IME_SEQCON`),');
    qryComand.sql.Add('  CONSTRAINT `FK_IMENDES_RE_SEQCON` FOREIGN KEY (`IME_SEQCON`) REFERENCES `IMENDES_PARAM` (`AUTOINCREM`) ON DELETE CASCADE ON UPDATE CASCADE');
    qryComand.sql.Add(') ENGINE=INNODB DEFAULT CHARSET=latin1');
    qryComand.ExecSQL;
  End;
end;

procedure TAPISaneamento.pAlimentaTABNRE;
begin
  Try
    qryComand.SQL.Clear;

    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_ABFICM");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_ALTERADOS");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_ESTADOS");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_ITENS");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_JSON");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_LOGCON");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_LOGTHREAD");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_PARAM");');
    qryComand.SQL.Add('REPLACE TABNRE (NOMTAB) VALUES ("IMENDES_RESULTADO");');
    qryComand.ExecSQL;
  Except
    {}
  End;
end;

procedure TAPISaneamento.pCriaEstruturaImendes_Resultado;
begin

  qryComand.SQL.Clear;
  Try
    qryComand.SQL.Add('SELECT TEMPO_ESTIMADO FROM IMENDES_PARAM WHERE FALSE');
    qryComand.Open;
  Except
    Try
      qryComand.SQL.Text := 'ALTER TABLE IMENDES_PARAM ADD COLUMN TEMPO_ESTIMADO VARCHAR (100) NULL;';
      qryComand.ExecSQL;
    Except
    End;
  End;


  qryComand.SQL.Clear;
  Try
    qryComand.SQL.Text := 'SELECT * FROM IMENDES_RESULTADO WHERE FALSE';
    qryComand.Open;


  Except
    qryComand.SQL.Clear;

    qryComand.SQL.Add('CREATE TABLE IMENDES_RESULTADO');
    {$region 'Cria IMENDES_RESULTADO'}
    qryComand.SQL.Add(' SELECT ');
    qryComand.SQL.Add('((DIF_EXCIPI = 1) OR');
    qryComand.SQL.Add(' (DIF_ITE_CLAIPI) OR');
    qryComand.SQL.Add(' (DIF_ITE_CDCEST) OR');
    qryComand.SQL.Add(' (DIF_ITE_CODLUB)) AS DIF_INF_GERAIS,');
    qryComand.SQL.Add('((DIF_CODSIT_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_ENT_PEF = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_ENT_PEJ = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_ENT_PER = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_ENT_PES = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_ENT_PSI = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_ENT_PII = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_NCO = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_CCO = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_CNC = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_SNA = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_CTA = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_PRU = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_IND = 1) OR');
    qryComand.SQL.Add('(DIF_CODSIT_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_BASICM_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_ALQICM_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_BASRET_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRET_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_IVA_ST_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_ALQFCP_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_ALQEFO_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_ALQIED_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_ALQRED_SAI_TRS = 1) OR');
    qryComand.SQL.Add('(DIF_BASDDS_SAI_TRS = 1)) DIF_ICMS,');
    qryComand.SQL.Add('        TMP.*');
    qryComand.SQL.Add('          FROM ( ');
    qryComand.SQL.Add('SELECT CAST(CONCAT(ITE_DESITE,"<TAG_AUTCOM>", ITENS.IME_CODITE, "-", ITE_DESITE) AS CHAR(120)) AS ITEM,');
    qryComand.SQL.Add('       ITENS.IME_SEQCON,');
    qryComand.SQL.Add('       ITENS.IME_CODITE,');
    qryComand.SQL.Add('       ITEGER.ITE_CODEMP AS IME_CODEMP,');
    qryComand.SQL.Add('       ITENS.IME_SEQUEN,');
    qryComand.SQL.Add('       ITE_CLAIPI,');
    qryComand.SQL.Add('       ITE_DESITE,');
    qryComand.SQL.Add('       IME_GERABF,');
    qryComand.SQL.Add('       ABF_CODABF,');
    qryComand.SQL.Add('       ABF_ESTADO,');
    qryComand.SQL.Add('       IME_SEMIME,');
    qryComand.SQL.Add('       IME_RETPAR,');
    qryComand.SQL.Add('       IME_SEMEAN,');
    qryComand.SQL.Add('       ITENS.EXCLUIDO,');
    qryComand.SQL.Add('       TIPABF.SIS_VALCFG AS TIPABF,');
    qryComand.SQL.Add('       @EXCIPI := IFNULL(IF(TPABPC.SIS_VALCFG = "1", CADITE.ITE_EXCIPI, ITEGER.ITE_EXCIPI), "") AS EXCIPI,');
    qryComand.SQL.Add('       IME_CODNCM <> ITE_CLAIPI AS DIF_CLAIPI,');
    qryComand.SQL.Add('       IME_IPISAI <> ITE_IPISAI AS DIF_IPISAI,');
    qryComand.SQL.Add('       IME_CODLUB <> ITE_CODLUB AS DIF_CODLUB,');
    qryComand.SQL.Add('       IME_CODNCM <> ITE_CLAIPI AS DIF_ITE_CLAIPI,');
    qryComand.SQL.Add('       ITE_CDCEST <> IME_CDCEST AS DIF_ITE_CDCEST,');
    qryComand.SQL.Add('       IME_CODLUB <> ITE_CODLUB AS DIF_ITE_CODLUB,');
    qryComand.SQL.Add('       IME_EXCIPI <> @EXCIPI AS DIF_EXCIPI,');
    qryComand.SQL.Add('       IMEPEF.IME_CODSIT AS ABF_CODSIT_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_CODBEN AS ABF_CODBEN_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_BASICM AS ABF_BASICM_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_ALQICM AS ABF_ALQICM_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_BASRET AS ABF_BASRET_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_ALQRET AS ABF_ALQRET_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_IVA_ST AS ABF_IVA_ST_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_ALQFCP AS ABF_ALQFCP_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_ALQEFO AS ABF_ALQEFO_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_ALQIED AS ABF_ALQIED_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_ALQRED AS ABF_ALQRED_ENT_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_BASDDS AS ABF_BASDDS_ENT_PEF,');

    qryComand.SQL.Add('       IMEPEF.IME_AMPLEG AS ABF_IME_AMPLEG_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_PTCNOM AS ABF_IME_PTCNOM_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_PTCDES AS ABF_IME_PTCDES_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_CONNOM AS ABF_IME_CONNOM_PEF,');
    qryComand.SQL.Add('       IMEPEF.IME_CONDES AS ABF_IME_CONDES_PEF,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_ENT_PEF,2,3) <> IMEPEF.IME_CODSIT AS DIF_CODSIT_ENT_PEF,');
    qryComand.SQL.Add('       ABF_BASICM_ENT_PEF <> IMEPEF.IME_BASICM AS DIF_BASICM_ENT_PEF,');
    qryComand.SQL.Add('       ABF_ALQICM_ENT_PEF <> IMEPEF.IME_ALQICM AS DIF_ALQICM_ENT_PEF,');
    qryComand.SQL.Add('       ABF_BASRET_ENT_PEF <> IMEPEF.IME_BASRET AS DIF_BASRET_ENT_PEF,');
    qryComand.SQL.Add('       ABF_ALQRET_ENT_PEF <> IMEPEF.IME_ALQRET AS DIF_ALQRET_ENT_PEF,');
    qryComand.SQL.Add('       ABF_IVA_ST_ENT_PEF <> IMEPEF.IME_IVA_ST AS DIF_IVA_ST_ENT_PEF,');
    qryComand.SQL.Add('       ABF_ALQFCP_ENT_PEF <> IMEPEF.IME_ALQFCP AS DIF_ALQFCP_ENT_PEF,');
    qryComand.SQL.Add('       ABF_ALQEFO_ENT_PEF <> IMEPEF.IME_ALQEFO AS DIF_ALQEFO_ENT_PEF,');
    qryComand.SQL.Add('       ABF_ALQIED_ENT_PEF <> IMEPEF.IME_ALQIED AS DIF_ALQIED_ENT_PEF,');
    qryComand.SQL.Add('       ABF_ALQRED_ENT_PEF <> IMEPEF.IME_ALQRED AS DIF_ALQRED_ENT_PEF,');
    qryComand.SQL.Add('       ABF_BASDDS_ENT_PEF <> IMEPEF.IME_BASDDS AS DIF_BASDDS_ENT_PEF,');
    qryComand.SQL.Add('       ABF_CODSIT_ENT_PEF AS ORI_ABF_CODSIT_ENT_PEF, ');
    qryComand.SQL.Add('       IMEPEJ.IME_CODSIT AS ABF_CODSIT_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_CODBEN AS ABF_CODBEN_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_BASICM AS ABF_BASICM_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_ALQICM AS ABF_ALQICM_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_BASRET AS ABF_BASRET_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_ALQRET AS ABF_ALQRET_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_IVA_ST AS ABF_IVA_ST_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_ALQFCP AS ABF_ALQFCP_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_ALQEFO AS ABF_ALQEFO_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_ALQIED AS ABF_ALQIED_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_ALQRED AS ABF_ALQRED_ENT_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_BASDDS AS ABF_BASDDS_ENT_PEJ,');

    qryComand.SQL.Add('       IMEPEJ.IME_AMPLEG AS ABF_IME_AMPLEG_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_PTCNOM AS ABF_IME_PTCNOM_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_PTCDES AS ABF_IME_PTCDES_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_CONNOM AS ABF_IME_CONNOM_PEJ,');
    qryComand.SQL.Add('       IMEPEJ.IME_CONDES AS ABF_IME_CONDES_PEJ,');


    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_ENT_PEJ,2,3) <> IMEPEJ.IME_CODSIT AS DIF_CODSIT_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_BASICM_ENT_PEJ <> IMEPEJ.IME_BASICM AS DIF_BASICM_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_ALQICM_ENT_PEJ <> IMEPEJ.IME_ALQICM AS DIF_ALQICM_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_BASRET_ENT_PEJ <> IMEPEJ.IME_BASRET AS DIF_BASRET_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_ALQRET_ENT_PEJ <> IMEPEJ.IME_ALQRET AS DIF_ALQRET_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_IVA_ST_ENT_PEJ <> IMEPEJ.IME_IVA_ST AS DIF_IVA_ST_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_ALQFCP_ENT_PEJ <> IMEPEJ.IME_ALQFCP AS DIF_ALQFCP_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_ALQEFO_ENT_PEJ <> IMEPEJ.IME_ALQEFO AS DIF_ALQEFO_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_ALQIED_ENT_PEJ <> IMEPEJ.IME_ALQIED AS DIF_ALQIED_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_ALQRED_ENT_PEJ <> IMEPEJ.IME_ALQRED AS DIF_ALQRED_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_BASDDS_ENT_PEJ <> IMEPEJ.IME_BASDDS AS DIF_BASDDS_ENT_PEJ,');
    qryComand.SQL.Add('       ABF_CODSIT_ENT_PEJ AS ORI_ABF_CODSIT_ENT_PEJ, ');
    qryComand.SQL.Add('       IMEPER.IME_CODSIT AS ABF_CODSIT_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_CODBEN AS ABF_CODBEN_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_BASICM AS ABF_BASICM_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_ALQICM AS ABF_ALQICM_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_BASRET AS ABF_BASRET_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_ALQRET AS ABF_ALQRET_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_IVA_ST AS ABF_IVA_ST_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_ALQFCP AS ABF_ALQFCP_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_ALQEFO AS ABF_ALQEFO_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_ALQIED AS ABF_ALQIED_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_ALQRED AS ABF_ALQRED_ENT_PER,');
    qryComand.SQL.Add('       IMEPER.IME_BASDDS AS ABF_BASDDS_ENT_PER,');

    qryComand.SQL.Add('       IMEPER.IME_AMPLEG AS ABF_IME_AMPLEG_PER,');
    qryComand.SQL.Add('       IMEPER.IME_PTCNOM AS ABF_IME_PTCNOM_PER,');
    qryComand.SQL.Add('       IMEPER.IME_PTCDES AS ABF_IME_PTCDES_PER,');
    qryComand.SQL.Add('       IMEPER.IME_CONNOM AS ABF_IME_CONNOM_PER,');
    qryComand.SQL.Add('       IMEPER.IME_CONDES AS ABF_IME_CONDES_PER,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_ENT_PER,2,3) <> IMEPER.IME_CODSIT AS DIF_CODSIT_ENT_PER,');
    qryComand.SQL.Add('       ABF_BASICM_ENT_PER <> IMEPER.IME_BASICM AS DIF_BASICM_ENT_PER,');
    qryComand.SQL.Add('       ABF_ALQICM_ENT_PER <> IMEPER.IME_ALQICM AS DIF_ALQICM_ENT_PER,');
    qryComand.SQL.Add('       ABF_BASRET_ENT_PER <> IMEPER.IME_BASRET AS DIF_BASRET_ENT_PER,');
    qryComand.SQL.Add('       ABF_ALQRET_ENT_PER <> IMEPER.IME_ALQRET AS DIF_ALQRET_ENT_PER,');
    qryComand.SQL.Add('       ABF_IVA_ST_ENT_PER <> IMEPER.IME_IVA_ST AS DIF_IVA_ST_ENT_PER,');
    qryComand.SQL.Add('       ABF_ALQFCP_ENT_PER <> IMEPER.IME_ALQFCP AS DIF_ALQFCP_ENT_PER,');
    qryComand.SQL.Add('       ABF_ALQEFO_ENT_PER <> IMEPER.IME_ALQEFO AS DIF_ALQEFO_ENT_PER,');
    qryComand.SQL.Add('       ABF_ALQIED_ENT_PER <> IMEPER.IME_ALQIED AS DIF_ALQIED_ENT_PER,');
    qryComand.SQL.Add('       ABF_ALQRED_ENT_PER <> IMEPER.IME_ALQRED AS DIF_ALQRED_ENT_PER,');
    qryComand.SQL.Add('       ABF_BASDDS_ENT_PER <> IMEPER.IME_BASDDS AS DIF_BASDDS_ENT_PER,');
    qryComand.SQL.Add('       ABF_CODSIT_ENT_PER AS ORI_ABF_CODSIT_ENT_PER, ');
    qryComand.SQL.Add('       IMEPES.IME_CODSIT AS ABF_CODSIT_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_CODBEN AS ABF_CODBEN_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_BASICM AS ABF_BASICM_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_ALQICM AS ABF_ALQICM_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_BASRET AS ABF_BASRET_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_ALQRET AS ABF_ALQRET_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_IVA_ST AS ABF_IVA_ST_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_ALQFCP AS ABF_ALQFCP_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_ALQEFO AS ABF_ALQEFO_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_ALQIED AS ABF_ALQIED_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_ALQRED AS ABF_ALQRED_ENT_PES,');
    qryComand.SQL.Add('       IMEPES.IME_BASDDS AS ABF_BASDDS_ENT_PES,');

    qryComand.SQL.Add('       IMEPES.IME_AMPLEG AS ABF_IME_AMPLEG_PES,');
    qryComand.SQL.Add('       IMEPES.IME_PTCNOM AS ABF_IME_PTCNOM_PES,');
    qryComand.SQL.Add('       IMEPES.IME_PTCDES AS ABF_IME_PTCDES_PES,');
    qryComand.SQL.Add('       IMEPES.IME_CONNOM AS ABF_IME_CONNOM_PES,');
    qryComand.SQL.Add('       IMEPES.IME_CONDES AS ABF_IME_CONDES_PES,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_ENT_PES,2,3) <> IMEPES.IME_CODSIT AS DIF_CODSIT_ENT_PES,');
    qryComand.SQL.Add('       ABF_BASICM_ENT_PES <> IMEPES.IME_BASICM AS DIF_BASICM_ENT_PES,');
    qryComand.SQL.Add('       ABF_ALQICM_ENT_PES <> IMEPES.IME_ALQICM AS DIF_ALQICM_ENT_PES,');
    qryComand.SQL.Add('       ABF_BASRET_ENT_PES <> IMEPES.IME_BASRET AS DIF_BASRET_ENT_PES,');
    qryComand.SQL.Add('       ABF_ALQRET_ENT_PES <> IMEPES.IME_ALQRET AS DIF_ALQRET_ENT_PES,');
    qryComand.SQL.Add('       ABF_IVA_ST_ENT_PES <> IMEPES.IME_IVA_ST AS DIF_IVA_ST_ENT_PES,');
    qryComand.SQL.Add('       ABF_ALQFCP_ENT_PES <> IMEPES.IME_ALQFCP AS DIF_ALQFCP_ENT_PES,');
    qryComand.SQL.Add('       ABF_ALQEFO_ENT_PES <> IMEPES.IME_ALQEFO AS DIF_ALQEFO_ENT_PES,');
    qryComand.SQL.Add('       ABF_ALQIED_ENT_PES <> IMEPES.IME_ALQIED AS DIF_ALQIED_ENT_PES,');
    qryComand.SQL.Add('       ABF_ALQRED_ENT_PES <> IMEPES.IME_ALQRED AS DIF_ALQRED_ENT_PES,');
    qryComand.SQL.Add('       ABF_BASDDS_ENT_PES <> IMEPES.IME_BASDDS AS DIF_BASDDS_ENT_PES,');
    qryComand.SQL.Add('       ABF_CODSIT_ENT_PES AS ORI_ABF_CODSIT_ENT_PES, ');
    qryComand.SQL.Add('       IMEPSI.IME_CODSIT AS ABF_CODSIT_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_CODBEN AS ABF_CODBE_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_BASICM AS ABF_BASICM_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_ALQICM AS ABF_ALQICM_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_BASRET AS ABF_BASRET_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_ALQRET AS ABF_ALQRET_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_IVA_ST AS ABF_IVA_ST_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_ALQFCP AS ABF_ALQFCP_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_ALQEFO AS ABF_ALQEFO_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_ALQIED AS ABF_ALQIED_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_ALQRED AS ABF_ALQRED_ENT_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_BASDDS AS ABF_BASDDS_ENT_PSI,');

    qryComand.SQL.Add('       IMEPSI.IME_AMPLEG AS ABF_IME_AMPLEG_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_PTCNOM AS ABF_IME_PTCNOM_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_PTCDES AS ABF_IME_PTCDES_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_CONNOM AS ABF_IME_CONNOM_PSI,');
    qryComand.SQL.Add('       IMEPSI.IME_CONDES AS ABF_IME_CONDES_PSI,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_ENT_PSI,2,3) <> IMEPSI.IME_CODSIT AS DIF_CODSIT_ENT_PSI,');
    qryComand.SQL.Add('       ABF_BASICM_ENT_PSI <> IMEPSI.IME_BASICM AS DIF_BASICM_ENT_PSI,');
    qryComand.SQL.Add('       ABF_ALQICM_ENT_PSI <> IMEPSI.IME_ALQICM AS DIF_ALQICM_ENT_PSI,');
    qryComand.SQL.Add('       ABF_BASRET_ENT_PSI <> IMEPSI.IME_BASRET AS DIF_BASRET_ENT_PSI,');
    qryComand.SQL.Add('       ABF_ALQRET_ENT_PSI <> IMEPSI.IME_ALQRET AS DIF_ALQRET_ENT_PSI,');
    qryComand.SQL.Add('       ABF_IVA_ST_ENT_PSI <> IMEPSI.IME_IVA_ST AS DIF_IVA_ST_ENT_PSI,');
    qryComand.SQL.Add('       ABF_ALQFCP_ENT_PSI <> IMEPSI.IME_ALQFCP AS DIF_ALQFCP_ENT_PSI,');
    qryComand.SQL.Add('       ABF_ALQEFO_ENT_PSI <> IMEPSI.IME_ALQEFO AS DIF_ALQEFO_ENT_PSI,');
    qryComand.SQL.Add('       ABF_ALQIED_ENT_PSI <> IMEPSI.IME_ALQIED AS DIF_ALQIED_ENT_PSI,');
    qryComand.SQL.Add('       ABF_ALQRED_ENT_PSI <> IMEPSI.IME_ALQRED AS DIF_ALQRED_ENT_PSI,');
    qryComand.SQL.Add('       ABF_BASDDS_ENT_PSI <> IMEPSI.IME_BASDDS AS DIF_BASDDS_ENT_PSI,');
    qryComand.SQL.Add('       ABF_CODSIT_ENT_PSI AS ORI_ABF_CODSIT_ENT_PSI, ');
    qryComand.SQL.Add('       IMEPII.IME_CODSIT AS ABF_CODSIT_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_CODBEN AS ABF_CODBEN_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_BASICM AS ABF_BASICM_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_ALQICM AS ABF_ALQICM_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_BASRET AS ABF_BASRET_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_ALQRET AS ABF_ALQRET_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_IVA_ST AS ABF_IVA_ST_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_ALQFCP AS ABF_ALQFCP_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_ALQEFO AS ABF_ALQEFO_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_ALQIED AS ABF_ALQIED_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_ALQRED AS ABF_ALQRED_ENT_PII,');
    qryComand.SQL.Add('       IMEPII.IME_BASDDS AS ABF_BASDDS_ENT_PII,');

    qryComand.SQL.Add('       IMEPSI.IME_AMPLEG AS ABF_IME_AMPLEG_PII,');
    qryComand.SQL.Add('       IMEPSI.IME_PTCNOM AS ABF_IME_PTCNOM_PII,');
    qryComand.SQL.Add('       IMEPSI.IME_PTCDES AS ABF_IME_PTCDES_PII,');
    qryComand.SQL.Add('       IMEPSI.IME_CONNOM AS ABF_IME_CONNOM_PII,');
    qryComand.SQL.Add('       IMEPSI.IME_CONDES AS ABF_IME_CONDES_PII,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_ENT_PII,2,3) <> IMEPII.IME_CODSIT AS DIF_CODSIT_ENT_PII,');
    qryComand.SQL.Add('       ABF_BASICM_ENT_PII <> IMEPII.IME_BASICM AS DIF_BASICM_ENT_PII,');
    qryComand.SQL.Add('       ABF_ALQICM_ENT_PII <> IMEPII.IME_ALQICM AS DIF_ALQICM_ENT_PII,');
    qryComand.SQL.Add('       ABF_BASRET_ENT_PII <> IMEPII.IME_BASRET AS DIF_BASRET_ENT_PII,');
    qryComand.SQL.Add('       ABF_ALQRET_ENT_PII <> IMEPII.IME_ALQRET AS DIF_ALQRET_ENT_PII,');
    qryComand.SQL.Add('       ABF_IVA_ST_ENT_PII <> IMEPII.IME_IVA_ST AS DIF_IVA_ST_ENT_PII,');
    qryComand.SQL.Add('       ABF_ALQFCP_ENT_PII <> IMEPII.IME_ALQFCP AS DIF_ALQFCP_ENT_PII,');
    qryComand.SQL.Add('       ABF_ALQEFO_ENT_PII <> IMEPII.IME_ALQEFO AS DIF_ALQEFO_ENT_PII,');
    qryComand.SQL.Add('       ABF_ALQIED_ENT_PII <> IMEPII.IME_ALQIED AS DIF_ALQIED_ENT_PII,');
    qryComand.SQL.Add('       ABF_ALQRED_ENT_PII <> IMEPII.IME_ALQRED AS DIF_ALQRED_ENT_PII,');
    qryComand.SQL.Add('       ABF_BASDDS_ENT_PII <> IMEPII.IME_BASDDS AS DIF_BASDDS_ENT_PII,');
    qryComand.SQL.Add('       ABF_CODSIT_ENT_PII AS ORI_ABF_CODSIT_ENT_PII,');
    qryComand.SQL.Add('       IMENCO.IME_CODSIT AS ABF_CODSIT_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_CODBEN AS ABF_CODBEN_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_BASICM AS ABF_BASICM_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_ALQICM AS ABF_ALQICM_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_BASRET AS ABF_BASRET_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_ALQRET AS ABF_ALQRET_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_IVA_ST AS ABF_IVA_ST_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_ALQFCP AS ABF_ALQFCP_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_ALQEFO AS ABF_ALQEFO_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_ALQIED AS ABF_ALQIED_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_ALQRED AS ABF_ALQRED_SAI_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_BASDDS AS ABF_BASDDS_SAI_NCO,');

    qryComand.SQL.Add('       IMENCO.IME_AMPLEG AS ABF_IME_AMPLEG_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_PTCNOM AS ABF_IME_PTCNOM_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_PTCDES AS ABF_IME_PTCDES_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_CONNOM AS ABF_IME_CONNOM_NCO,');
    qryComand.SQL.Add('       IMENCO.IME_CONDES AS ABF_IME_CONDES_NCO,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_NCO,2,3) <> IMENCO.IME_CODSIT AS DIF_CODSIT_SAI_NCO,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_NCO <> IMENCO.IME_BASICM AS DIF_BASICM_SAI_NCO,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_NCO <> IMENCO.IME_ALQICM AS DIF_ALQICM_SAI_NCO,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_NCO <> IMENCO.IME_BASRET AS DIF_BASRET_SAI_NCO,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_NCO <> IMENCO.IME_ALQRET AS DIF_ALQRET_SAI_NCO,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_NCO <> IMENCO.IME_IVA_ST AS DIF_IVA_ST_SAI_NCO,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_NCO <> IMENCO.IME_ALQFCP AS DIF_ALQFCP_SAI_NCO,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_NCO <> IMENCO.IME_ALQEFO AS DIF_ALQEFO_SAI_NCO,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_NCO <> IMENCO.IME_ALQIED AS DIF_ALQIED_SAI_NCO,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_NCO <> IMENCO.IME_ALQRED AS DIF_ALQRED_SAI_NCO,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_NCO <> IMENCO.IME_BASDDS AS DIF_BASDDS_SAI_NCO,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_NCO AS ORI_ABF_CODSIT_SAI_NCO, ');
    qryComand.SQL.Add('       IMECCO.IME_CODSIT AS ABF_CODSIT_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_CODBEN AS ABF_CODBEN_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_BASICM AS ABF_BASICM_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_ALQICM AS ABF_ALQICM_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_BASRET AS ABF_BASRET_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_ALQRET AS ABF_ALQRET_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_IVA_ST AS ABF_IVA_ST_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_ALQFCP AS ABF_ALQFCP_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_ALQEFO AS ABF_ALQEFO_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_ALQIED AS ABF_ALQIED_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_ALQRED AS ABF_ALQRED_SAI_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_BASDDS AS ABF_BASDDS_SAI_CCO,');

    qryComand.SQL.Add('       IMECCO.IME_AMPLEG AS ABF_IME_AMPLEG_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_PTCNOM AS ABF_IME_PTCNOM_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_PTCDES AS ABF_IME_PTCDES_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_CONNOM AS ABF_IME_CONNOM_CCO,');
    qryComand.SQL.Add('       IMECCO.IME_CONDES AS ABF_IME_CONDES_CCO,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_CCO,2,3) <> IMECCO.IME_CODSIT AS DIF_CODSIT_SAI_CCO,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_CCO <> IMECCO.IME_BASICM AS DIF_BASICM_SAI_CCO,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_CCO <> IMECCO.IME_ALQICM AS DIF_ALQICM_SAI_CCO,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_CCO <> IMECCO.IME_BASRET AS DIF_BASRET_SAI_CCO,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_CCO <> IMECCO.IME_ALQRET AS DIF_ALQRET_SAI_CCO,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_CCO <> IMECCO.IME_IVA_ST AS DIF_IVA_ST_SAI_CCO,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_CCO <> IMECCO.IME_ALQFCP AS DIF_ALQFCP_SAI_CCO,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_CCO <> IMECCO.IME_ALQEFO AS DIF_ALQEFO_SAI_CCO,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_CCO <> IMECCO.IME_ALQIED AS DIF_ALQIED_SAI_CCO,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_CCO <> IMECCO.IME_ALQRED AS DIF_ALQRED_SAI_CCO,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_CCO <> IMECCO.IME_BASDDS AS DIF_BASDDS_SAI_CCO,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_CCO AS ORI_ABF_CODSIT_SAI_CCO, ');
    qryComand.SQL.Add('       IMECNC.IME_CODSIT AS ABF_CODSIT_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_CODBEN AS ABF_CODBEN_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_BASICM AS ABF_BASICM_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_ALQICM AS ABF_ALQICM_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_BASRET AS ABF_BASRET_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_ALQRET AS ABF_ALQRET_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_IVA_ST AS ABF_IVA_ST_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_ALQFCP AS ABF_ALQFCP_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_ALQEFO AS ABF_ALQEFO_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_ALQIED AS ABF_ALQIED_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_ALQRED AS ABF_ALQRED_SAI_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_BASDDS AS ABF_BASDDS_SAI_CNC,');

    qryComand.SQL.Add('       IMECNC.IME_AMPLEG AS ABF_IME_AMPLEG_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_PTCNOM AS ABF_IME_PTCNOM_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_PTCDES AS ABF_IME_PTCDES_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_CONNOM AS ABF_IME_CONNOM_CNC,');
    qryComand.SQL.Add('       IMECNC.IME_CONDES AS ABF_IME_CONDES_CNC,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_CNC,2,3) <> IMECNC.IME_CODSIT AS DIF_CODSIT_SAI_CNC,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_CNC <> IMECNC.IME_BASICM AS DIF_BASICM_SAI_CNC,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_CNC <> IMECNC.IME_ALQICM AS DIF_ALQICM_SAI_CNC,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_CNC <> IMECNC.IME_BASRET AS DIF_BASRET_SAI_CNC,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_CNC <> IMECNC.IME_ALQRET AS DIF_ALQRET_SAI_CNC,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_CNC <> IMECNC.IME_IVA_ST AS DIF_IVA_ST_SAI_CNC,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_CNC <> IMECNC.IME_ALQFCP AS DIF_ALQFCP_SAI_CNC,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_CNC <> IMECNC.IME_ALQEFO AS DIF_ALQEFO_SAI_CNC,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_CNC <> IMECNC.IME_ALQIED AS DIF_ALQIED_SAI_CNC,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_CNC <> IMECNC.IME_ALQRED AS DIF_ALQRED_SAI_CNC,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_CNC <> IMECNC.IME_BASDDS AS DIF_BASDDS_SAI_CNC,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_CNC AS ORI_ABF_CODSIT_SAI_CNC, ');
    qryComand.SQL.Add('       IMESNA.IME_CODSIT AS ABF_CODSIT_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_CODBEN AS ABF_CODBEN_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_BASICM AS ABF_BASICM_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_ALQICM AS ABF_ALQICM_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_BASRET AS ABF_BASRET_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_ALQRET AS ABF_ALQRET_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_IVA_ST AS ABF_IVA_ST_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_ALQFCP AS ABF_ALQFCP_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_ALQEFO AS ABF_ALQEFO_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_ALQIED AS ABF_ALQIED_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_ALQRED AS ABF_ALQRED_SAI_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_BASDDS AS ABF_BASDDS_SAI_SNA,');

    qryComand.SQL.Add('       IMESNA.IME_AMPLEG AS ABF_IME_AMPLEG_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_PTCNOM AS ABF_IME_PTCNOM_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_PTCDES AS ABF_IME_PTCDES_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_CONNOM AS ABF_IME_CONNOM_SNA,');
    qryComand.SQL.Add('       IMESNA.IME_CONDES AS ABF_IME_CONDES_SNA,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_SNA,2,3) <> IMESNA.IME_CODSIT AS DIF_CODSIT_SAI_SNA,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_SNA <> IMESNA.IME_BASICM AS DIF_BASICM_SAI_SNA,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_SNA <> IMESNA.IME_ALQICM AS DIF_ALQICM_SAI_SNA,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_SNA <> IMESNA.IME_BASRET AS DIF_BASRET_SAI_SNA,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_SNA <> IMESNA.IME_ALQRET AS DIF_ALQRET_SAI_SNA,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_SNA <> IMESNA.IME_IVA_ST AS DIF_IVA_ST_SAI_SNA,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_SNA <> IMESNA.IME_ALQFCP AS DIF_ALQFCP_SAI_SNA,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_SNA <> IMESNA.IME_ALQEFO AS DIF_ALQEFO_SAI_SNA,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_SNA <> IMESNA.IME_ALQIED AS DIF_ALQIED_SAI_SNA,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_SNA <> IMESNA.IME_ALQRED AS DIF_ALQRED_SAI_SNA,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_SNA <> IMESNA.IME_BASDDS AS DIF_BASDDS_SAI_SNA,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_SNA AS ORI_ABF_CODSIT_SAI_SNA, ');
    qryComand.SQL.Add('       IMECTA.IME_CODSIT AS ABF_CODSIT_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_CODBEN AS ABF_CODBEN_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_BASICM AS ABF_BASICM_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_ALQICM AS ABF_ALQICM_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_BASRET AS ABF_BASRET_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_ALQRET AS ABF_ALQRET_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_IVA_ST AS ABF_IVA_ST_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_ALQFCP AS ABF_ALQFCP_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_ALQEFO AS ABF_ALQEFO_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_ALQIED AS ABF_ALQIED_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_ALQRED AS ABF_ALQRED_SAI_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_BASDDS AS ABF_BASDDS_SAI_CTA,');

    qryComand.SQL.Add('       IMECTA.IME_AMPLEG AS ABF_IME_AMPLEG_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_PTCNOM AS ABF_IME_PTCNOM_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_PTCDES AS ABF_IME_PTCDES_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_CONNOM AS ABF_IME_CONNOM_CTA,');
    qryComand.SQL.Add('       IMECTA.IME_CONDES AS ABF_IME_CONDES_CTA,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_CTA,2,3) <> IMECTA.IME_CODSIT AS DIF_CODSIT_SAI_CTA,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_CTA <> IMECTA.IME_BASICM AS DIF_BASICM_SAI_CTA,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_CTA <> IMECTA.IME_ALQICM AS DIF_ALQICM_SAI_CTA,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_CTA <> IMECTA.IME_BASRET AS DIF_BASRET_SAI_CTA,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_CTA <> IMECTA.IME_ALQRET AS DIF_ALQRET_SAI_CTA,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_CTA <> IMECTA.IME_IVA_ST AS DIF_IVA_ST_SAI_CTA,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_CTA <> IMECTA.IME_ALQFCP AS DIF_ALQFCP_SAI_CTA,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_CTA <> IMECTA.IME_ALQEFO AS DIF_ALQEFO_SAI_CTA,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_CTA <> IMECTA.IME_ALQIED AS DIF_ALQIED_SAI_CTA,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_CTA <> IMECTA.IME_ALQRED AS DIF_ALQRED_SAI_CTA,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_CTA <> IMECTA.IME_BASDDS AS DIF_BASDDS_SAI_CTA,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_CTA AS ORI_ABF_CODSIT_SAI_CTA, ');
    qryComand.SQL.Add('       IMEPRU.IME_CODSIT AS ABF_CODSIT_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_CODBEN AS ABF_CODBEN_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_BASICM AS ABF_BASICM_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_ALQICM AS ABF_ALQICM_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_BASRET AS ABF_BASRET_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_ALQRET AS ABF_ALQRET_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_IVA_ST AS ABF_IVA_ST_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_ALQFCP AS ABF_ALQFCP_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_ALQEFO AS ABF_ALQEFO_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_ALQIED AS ABF_ALQIED_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_ALQRED AS ABF_ALQRED_SAI_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_BASDDS AS ABF_BASDDS_SAI_PRU,');

    qryComand.SQL.Add('       IMEPRU.IME_AMPLEG AS ABF_IME_AMPLEG_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_PTCNOM AS ABF_IME_PTCNOM_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_PTCDES AS ABF_IME_PTCDES_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_CONNOM AS ABF_IME_CONNOM_PRU,');
    qryComand.SQL.Add('       IMEPRU.IME_CONDES AS ABF_IME_CONDES_PRU,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_PRU,2,3) <> IMEPRU.IME_CODSIT AS DIF_CODSIT_SAI_PRU,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_PRU <> IMEPRU.IME_BASICM AS DIF_BASICM_SAI_PRU,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_PRU <> IMEPRU.IME_ALQICM AS DIF_ALQICM_SAI_PRU,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_PRU <> IMEPRU.IME_BASRET AS DIF_BASRET_SAI_PRU,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_PRU <> IMEPRU.IME_ALQRET AS DIF_ALQRET_SAI_PRU,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_PRU <> IMEPRU.IME_IVA_ST AS DIF_IVA_ST_SAI_PRU,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_PRU <> IMEPRU.IME_ALQFCP AS DIF_ALQFCP_SAI_PRU,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_PRU <> IMEPRU.IME_ALQEFO AS DIF_ALQEFO_SAI_PRU,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_PRU <> IMEPRU.IME_ALQIED AS DIF_ALQIED_SAI_PRU,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_PRU <> IMEPRU.IME_ALQRED AS DIF_ALQRED_SAI_PRU,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_PRU <> IMEPRU.IME_BASDDS AS DIF_BASDDS_SAI_PRU,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_PRU AS ORI_ABF_CODSIT_SAI_PRU, ');
    qryComand.SQL.Add('       IMEIND.IME_CODSIT AS ABF_CODSIT_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_CODBEN AS ABF_CODBEN_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_BASICM AS ABF_BASICM_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_ALQICM AS ABF_ALQICM_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_BASRET AS ABF_BASRET_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_ALQRET AS ABF_ALQRET_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_IVA_ST AS ABF_IVA_ST_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_ALQFCP AS ABF_ALQFCP_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_ALQEFO AS ABF_ALQEFO_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_ALQIED AS ABF_ALQIED_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_ALQRED AS ABF_ALQRED_SAI_IND,');
    qryComand.SQL.Add('       IMEIND.IME_BASDDS AS ABF_BASDDS_SAI_IND,');

    qryComand.SQL.Add('       IMEIND.IME_AMPLEG AS ABF_IME_AMPLEG_IND,');
    qryComand.SQL.Add('       IMEIND.IME_PTCNOM AS ABF_IME_PTCNOM_IND,');
    qryComand.SQL.Add('       IMEIND.IME_PTCDES AS ABF_IME_PTCDES_IND,');
    qryComand.SQL.Add('       IMEIND.IME_CONNOM AS ABF_IME_CONNOM_IND,');
    qryComand.SQL.Add('       IMEIND.IME_CONDES AS ABF_IME_CONDES_IND,');

    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_IND,2,3) <> IMEIND.IME_CODSIT AS DIF_CODSIT_SAI_IND,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_IND <> IMEIND.IME_BASICM AS DIF_BASICM_SAI_IND,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_IND <> IMEIND.IME_ALQICM AS DIF_ALQICM_SAI_IND,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_IND <> IMEIND.IME_BASRET AS DIF_BASRET_SAI_IND,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_IND <> IMEIND.IME_ALQRET AS DIF_ALQRET_SAI_IND,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_IND <> IMEIND.IME_IVA_ST AS DIF_IVA_ST_SAI_IND,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_IND <> IMEIND.IME_ALQFCP AS DIF_ALQFCP_SAI_IND,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_IND <> IMEIND.IME_ALQEFO AS DIF_ALQEFO_SAI_IND,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_IND <> IMEIND.IME_ALQIED AS DIF_ALQIED_SAI_IND,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_IND <> IMEIND.IME_ALQRED AS DIF_ALQRED_SAI_IND,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_IND <> IMEIND.IME_BASDDS AS DIF_BASDDS_SAI_IND,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_IND AS ORI_ABF_CODSIT_SAI_IND, ');
    qryComand.SQL.Add('       IMETRS.IME_CODSIT AS ABF_CODSIT_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_CODBEN AS ABF_CODBEN_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_BASICM AS ABF_BASICM_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_ALQICM AS ABF_ALQICM_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_BASRET AS ABF_BASRET_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_ALQRET AS ABF_ALQRET_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_IVA_ST AS ABF_IVA_ST_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_ALQFCP AS ABF_ALQFCP_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_ALQEFO AS ABF_ALQEFO_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_ALQIED AS ABF_ALQIED_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_ALQRED AS ABF_ALQRED_SAI_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_BASDDS AS ABF_BASDDS_SAI_TRS,');

    qryComand.SQL.Add('       IMETRS.IME_AMPLEG AS ABF_IME_AMPLEG_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_PTCNOM AS ABF_IME_PTCNOM_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_PTCDES AS ABF_IME_PTCDES_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_CONNOM AS ABF_IME_CONNOM_TRS,');
    qryComand.SQL.Add('       IMETRS.IME_CONDES AS ABF_IME_CONDES_TRS,');


    qryComand.SQL.Add('       SUBSTRING(ABF_CODSIT_SAI_TRS,2,3) <> IMETRS.IME_CODSIT AS DIF_CODSIT_SAI_TRS,');
    qryComand.SQL.Add('       ABF_BASICM_SAI_TRS <> IMETRS.IME_BASICM AS DIF_BASICM_SAI_TRS,');
    qryComand.SQL.Add('       ABF_ALQICM_SAI_TRS <> IMETRS.IME_ALQICM AS DIF_ALQICM_SAI_TRS,');
    qryComand.SQL.Add('       ABF_BASRET_SAI_TRS <> IMETRS.IME_BASRET AS DIF_BASRET_SAI_TRS,');
    qryComand.SQL.Add('       ABF_ALQRET_SAI_TRS <> IMETRS.IME_ALQRET AS DIF_ALQRET_SAI_TRS,');
    qryComand.SQL.Add('       ABF_IVA_ST_SAI_TRS <> IMETRS.IME_IVA_ST AS DIF_IVA_ST_SAI_TRS,');
    qryComand.SQL.Add('       ABF_ALQFCP_SAI_TRS <> IMETRS.IME_ALQFCP AS DIF_ALQFCP_SAI_TRS,');
    qryComand.SQL.Add('       ABF_ALQEFO_SAI_TRS <> IMETRS.IME_ALQEFO AS DIF_ALQEFO_SAI_TRS,');
    qryComand.SQL.Add('       ABF_ALQIED_SAI_TRS <> IMETRS.IME_ALQIED AS DIF_ALQIED_SAI_TRS,');
    qryComand.SQL.Add('       ABF_ALQRED_SAI_TRS <> IMETRS.IME_ALQRED AS DIF_ALQRED_SAI_TRS,');
    qryComand.SQL.Add('       ABF_BASDDS_SAI_TRS <> IMETRS.IME_BASDDS AS DIF_BASDDS_SAI_TRS,');
    qryComand.SQL.Add('       ABF_CODSIT_SAI_TRS AS ORI_ABF_CODSIT_SAI_TRS, ');
    qryComand.SQL.Add('       "iMendes" AS LOCAL');
    qryComand.SQL.Add('  FROM IMENDES_ITENS ITENS');
    qryComand.SQL.Add(' INNER JOIN ABFICM ON ABFICM.ABF_CODABF = ITENS.IME_CODABF');
    qryComand.SQL.Add(' INNER JOIN CADITE ON CADITE.ITE_CODITE = ITENS.IME_CODITE');
    qryComand.SQL.Add(' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = ITENS.IME_CODITE AND ITEGER.ITE_CODEMP =  IF(IFNULL(IME_CODEMP, "") = "", "' + {$IFNDEF LINUX}iMendes_strCodEmp{$ELSE}VS_strCodEmp{$ENDIF} + '", IME_CODEMP)');
    qryComand.SQL.Add(' INNER JOIN CFGSIS TIPABF ON TIPABF.SIS_CODCFG = "CFG_TIPABF" AND TIPABF.SIS_CODEMP =ITEGER.ITE_CODEMP');
    qryComand.SQL.Add(' INNER JOIN CFGSIS TPABPC ON TPABPC.SIS_CODCFG = "CFG_TPABPC" AND TPABPC.SIS_CODEMP =ITEGER.ITE_CODEMP');
    qryComand.SQL.Add(' INNER JOIN CFGSIS UTIABI ON UTIABI.SIS_CODCFG = "CFG_UTIABI" AND UTIABI.SIS_CODEMP =ITEGER.ITE_CODEMP');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEPEF ON IMEPEF.IME_SEQCON = ITENS.IME_SEQCON AND IMEPEF.IME_CODITE = ITENS.IME_CODITE AND IMEPEF.IME_CODABF = ITENS.IME_CODABF  AND IMEPEF.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEPEF.IME_PERFIL = "PEF"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEPEJ ON IMEPEJ.IME_SEQCON = ITENS.IME_SEQCON AND IMEPEJ.IME_CODITE = ITENS.IME_CODITE AND IMEPEJ.IME_CODABF = ITENS.IME_CODABF  AND IMEPEJ.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEPEJ.IME_PERFIL = "PEJ"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEPER ON IMEPER.IME_SEQCON = ITENS.IME_SEQCON AND IMEPER.IME_CODITE = ITENS.IME_CODITE AND IMEPER.IME_CODABF = ITENS.IME_CODABF  AND IMEPER.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEPER.IME_PERFIL = "PER"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEPES ON IMEPES.IME_SEQCON = ITENS.IME_SEQCON AND IMEPES.IME_CODITE = ITENS.IME_CODITE AND IMEPES.IME_CODABF = ITENS.IME_CODABF  AND IMEPES.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEPES.IME_PERFIL = "PES"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEPSI ON IMEPSI.IME_SEQCON = ITENS.IME_SEQCON AND IMEPSI.IME_CODITE = ITENS.IME_CODITE AND IMEPSI.IME_CODABF = ITENS.IME_CODABF  AND IMEPSI.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEPSI.IME_PERFIL = "PSI"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEPII ON IMEPII.IME_SEQCON = ITENS.IME_SEQCON AND IMEPII.IME_CODITE = ITENS.IME_CODITE AND IMEPII.IME_CODABF = ITENS.IME_CODABF  AND IMEPII.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEPII.IME_PERFIL = "PII"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMENCO ON IMENCO.IME_SEQCON = ITENS.IME_SEQCON AND IMENCO.IME_CODITE = ITENS.IME_CODITE AND IMENCO.IME_CODABF = ITENS.IME_CODABF  AND IMENCO.IME_ESTADO = ABFICM.ABF_ESTADO AND IMENCO.IME_PERFIL = "NCO"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMECCO ON IMECCO.IME_SEQCON = ITENS.IME_SEQCON AND IMECCO.IME_CODITE = ITENS.IME_CODITE AND IMECCO.IME_CODABF = ITENS.IME_CODABF  AND IMECCO.IME_ESTADO = ABFICM.ABF_ESTADO AND IMECCO.IME_PERFIL = "CCO"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMECNC ON IMECNC.IME_SEQCON = ITENS.IME_SEQCON AND IMECNC.IME_CODITE = ITENS.IME_CODITE AND IMECNC.IME_CODABF = ITENS.IME_CODABF  AND IMECNC.IME_ESTADO = ABFICM.ABF_ESTADO AND IMECNC.IME_PERFIL = "CNC"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMESNA ON IMESNA.IME_SEQCON = ITENS.IME_SEQCON AND IMESNA.IME_CODITE = ITENS.IME_CODITE AND IMESNA.IME_CODABF = ITENS.IME_CODABF  AND IMESNA.IME_ESTADO = ABFICM.ABF_ESTADO AND IMESNA.IME_PERFIL = "SNA"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMECTA ON IMECTA.IME_SEQCON = ITENS.IME_SEQCON AND IMECTA.IME_CODITE = ITENS.IME_CODITE AND IMECTA.IME_CODABF = ITENS.IME_CODABF  AND IMECTA.IME_ESTADO = ABFICM.ABF_ESTADO AND IMECTA.IME_PERFIL = "CTA"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEPRU ON IMEPRU.IME_SEQCON = ITENS.IME_SEQCON AND IMEPRU.IME_CODITE = ITENS.IME_CODITE AND IMEPRU.IME_CODABF = ITENS.IME_CODABF  AND IMEPRU.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEPRU.IME_PERFIL = "PRU"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMEIND ON IMEIND.IME_SEQCON = ITENS.IME_SEQCON AND IMEIND.IME_CODITE = ITENS.IME_CODITE AND IMEIND.IME_CODABF = ITENS.IME_CODABF  AND IMEIND.IME_ESTADO = ABFICM.ABF_ESTADO AND IMEIND.IME_PERFIL = "IND"');
    qryComand.SQL.Add('  LEFT JOIN IMENDES_ABFICM IMETRS ON IMETRS.IME_SEQCON = ITENS.IME_SEQCON AND IMETRS.IME_CODITE = ITENS.IME_CODITE AND IMETRS.IME_CODABF = ITENS.IME_CODABF  AND IMETRS.IME_ESTADO = ABFICM.ABF_ESTADO AND IMETRS.IME_PERFIL = "TRS"');
    qryComand.SQL.Add('');
    qryComand.SQL.Add('  )TMP');
    qryComand.SQL.Add('  WHERE FALSE;');
    {$endregion}


    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_sequenc_imendes` (`IME_SEQCON`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_DIF_INF_GERAIS` (`DIF_INF_GERAIS`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_DIF_ICMS` (`DIF_ICMS`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_IME_SEMIME` (`IME_SEMIME`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_IME_RETPAR` (`IME_RETPAR`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_IME_SEMEAN` (`IME_SEMEAN`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_DIF_EXCIPI` (`DIF_EXCIPI`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_DIF_ITE_CODLUB` (`DIF_ITE_CODLUB`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_sequenc_item` (`IME_CODITE`, `IME_CODEMP`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_Estado` (`ABF_ESTADO`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_IME_SEQUEN` (`IME_SEQUEN`);');
    qryComand.SQL.Add('    ALTER TABLE `IMENDES_RESULTADO` ADD INDEX `idx_order_res` (`IME_SEQUEN` , `IME_CODEMP`, `ABF_ESTADO` , `LOCAL`);');


    qryComand.SQL.Add('ALTER TABLE IMENDES_RESULTADO');
    qryComand.SQL.Add('  ADD CONSTRAINT fk_imendes_param FOREIGN KEY (');
    qryComand.SQL.Add('    IME_SEQCON,');
    qryComand.SQL.Add('    IME_CODITE,');
    qryComand.SQL.Add('    IME_CODEMP,');
    qryComand.SQL.Add('    IME_SEQUEN');
    qryComand.SQL.Add('  ) REFERENCES IMENDES_ITENS (');
    qryComand.SQL.Add('    IME_SEQCON,');
    qryComand.SQL.Add('    IME_CODITE,');
    qryComand.SQL.Add('    IME_CODEMP,');
    qryComand.SQL.Add('    IME_SEQUEN');
    qryComand.SQL.Add('    )');
    qryComand.SQL.Add('    ON DELETE CASCADE;');

    qryComand.ExecSQL;

  End;

End;

procedure TAPISaneamento.pCriaEstruturaImendes_Json;
begin


  qryComand.SQL.Clear;
  Try
    qryComand.SQL.Text := 'SELECT * FROM IMENDES_JSON WHERE FALSE';
    qryComand.Open;


  Except
    qryComand.SQL.Clear;
    qryComand.SQL.Add(' CREATE TABLE `IMENDES_JSON` (');
    qryComand.SQL.Add('                `IME_SEQCON` VARCHAR(20) DEFAULT NULL,                                                                                          ');
    qryComand.SQL.Add('                `IME_CODITE` VARCHAR(7) DEFAULT NULL,                                                                                           ');
    qryComand.SQL.Add('                `IME_IDEARQ` VARCHAR(100) NOT NULL,                                                                                             ');
    qryComand.SQL.Add('                `ID_CHAVE_` VARCHAR(15) NOT NULL,                                                                                               ');
    qryComand.SQL.Add('                `IME_HORENV` DATETIME DEFAULT NULL,');
    qryComand.SQL.Add('                `IME_JSNENV` LONGTEXT,');
    qryComand.SQL.Add('                `IME_HORRET` DATETIME DEFAULT NULL,');
    qryComand.SQL.Add('                `IME_JSNRET` LONGTEXT,');
    qryComand.SQL.Add('                PRIMARY KEY (`IME_IDEARQ`,`ID_CHAVE_`),                                                                                         ');
    qryComand.SQL.Add('                KEY `FK_IMENDES_PARAM_JSON` (`IME_SEQCON`),');
    qryComand.SQL.Add('                CONSTRAINT `FK_IMENDES_PARAM_JSON` FOREIGN KEY (`IME_SEQCON`) REFERENCES `IMENDES_PARAM` (`AUTOINCREM`) ON DELETE CASCADE');
    qryComand.SQL.Add('              ) ENGINE=INNODB DEFAULT CHARSET=latin1');
    qryComand.ExecSQL;
  End;
end;

procedure TAPISaneamento.pAtualizaStatus;
begin

  case GerenciaEstado.EstadoAtual of

    epPendente :  GerenciaEstado.pAtualizaMaquinaEstado(epIniciaprocesso);
    epIniciaprocesso : begin
                         If qryItens.IsEmpty Then
                           GerenciaEstado.pAtualizaMaquinEstadoSemItensParaProcessar
                         Else
                           GerenciaEstado.pAtualizaMaquinaEstado(epCriandoEstruturaBanco);
                       End;

    epCriandoEstruturaBanco : GerenciaEstado.pAtualizaMaquinaEstado(epProcessando);
    epReprocessaItensParcialmente,
    epProcessando: GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoOk);
    epFinalizadoPeloAutcom : GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoPeloAutcom);
  End;
end;

function TApiSaneamento.fAutenticar(var strMensagem: String): Boolean;
begin
  Result := fAutenticarAux(strMensagem);
end;

function TApiSaneamento.fAutenticarAux(var strMensagem: String): Boolean;
var
  jsnResposta: TJSONObject;
  jsnSucesso: TJSONBool;
begin

  Try
    RESTCli.BaseURL := 'http://consultatributos.com.br:8080/api/v1/public/GetStatusCliente/'+strUsuario;
    RESTReq.Method := rmGET;

    {$IFDEF LINUX}
    WriteLog(Format('%s - %s', ['rmGET', RESTCli.BaseURL]));
    {$ENDIF}

    RESTReq.Execute;

    {$IFDEF LINUX}
    WriteLog(Format('%s - %s', ['jsnResposta', RESTRes.JSONText]));
    {$ENDIF}

    jsnResposta := TJSONObject.ParseJSONValue(RESTRes.JSONText) as TJSONObject;
    Try
      jsnSucesso := (jsnResposta.GetValue('sucesso')) As TJSONBool;
    Except
      Exit(False);
    End;

    If Not Assigned(jsnSucesso) Then
    Begin
      Try
        strMensagem := jsnResposta.GetValue<TJsonObject>('ret').GetValue('mensagem').Value;
      Except
        strMensagem := '';
      End;
      Exit(False);
    end;

    Result := (jsnSucesso As TJSONBool).AsBoolean;
    If Not Result Then
    Begin
      Try
        strMensagem := jsnResposta.GetValue<string>('mensagem');
      Except
        strMensagem := '';
      End;
    End
  Except
    On E:Exception Do
    Begin
      strMensagem :=strMensagem + #$A#$D + e.message;
      raise Exception.Create(FormatDateTime('dd/mm/yyyy hh:mm:ss', fImendesNow()) + ' | Erro ao autenticar usuário '+ strUsuario + ' Mensagem: ' + strMensagem);
    End;
  End;
end;

function TApiSaneamento.fEnviarItens(out numErros:Integer): Boolean;
begin

  Result := fConsultarItens;
end;


function TApiSaneamento.fConsultarItens(): Boolean;
var
  strJSONMontado: String;
begin
  Try
    Try
      strJSONMontado := '';
        //frmGravando.Refresh;
      VariaveisDeControle.intQtdThreadAtivas := 0;
      qryItens.First;

      pAtualizaTemporizador(VariaveisDeControle, qryItens.FieldByName('IME_SEQCON').AsString);


      VariaveisDeControle.intQtdRegistros := qryItens.RecordCount;
      VariaveisDeControle.intQtdRegistrosProcessados := 0;
      VariaveisDeControle.DataHoraIncio :=  fImendesNow;
      VariaveisDeControle.DataHoraUltimaAtualizacao := VariaveisDeControle.DataHoraIncio;
      VariaveisDeControle.FinalizaTemporizador := False;
      blnControlaTempoExecucao := True;

      While Not qryItens.Eof Do
      Begin
        TempoUltimaExecucao := fImendesNow;
        VariaveisDeControle.blnFinalizacaoExterna := False;
        If GerenciaEstado.fFinalizadoExterno Then
        Begin
          VariaveisDeControle.blnFinalizacaoExterna := True;
          Break;
        End;

        strJSONMontado := '';

        while VariaveisDeControle.intQtdThreadAtivas >= intMaxThreadAtivas do;

        pIniciaThread;

        qryItens.Next;
      End;


      while not (VariaveisDeControle.intQtdThreadAtivas = 0) do;

      Result := True;
    Finally
      VariaveisDeControle.FinalizaTemporizador := True;
      blnControlaTempoExecucao := False;
    End;

    If VariaveisDeControle.blnFinalizacaoExterna Then
      GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoPeloAutcom)
    Else
    Begin
      If GerenciaEstado.EstadoAtual = epReprocessaItensParcialmente then
        fInsereIMENDES_RESULTADO(True, qryComand, qryItensResultado, GerenciaEstado.AutIncRegAtual)
      Else
        fInsereIMENDES_RESULTADO(False, qryComand, qryItensResultado, GerenciaEstado.AutIncRegAtual);

      If VariaveisDeControle.blnFinalizaComoItemNaoEncontradoImendes Then
        GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoItemNaoEncontradoNaImendes);
    End;
  Except
    on e: Exception do
    Begin
      blnNotificaExecucao := False;
      blnControlaTempoExecucao := False;
      raise Exception.Create(FProcessoAtual + e.Message);
    End;

  End;
end;

class function TAPISaneamento.fValidaConexao(var Retorno: String; ACodEmp: String;  blnAutcom: Boolean{$IFNDEF LINUX}; AConnection: TUniConnection{$ENDIF}): Boolean;
  var apiCon: TAPISaneamento;
    strMensagem: String;
begin

  Retorno := '';
  Try
    apiCon := TAPISaneamento.Create(strMensagem, ACodEmp, blnAutcom {$IFNDEF LINUX}, AConnection{$ENDIF});
    Try
      If Not apiCon.blnConfigsValidadas Then
        Retorno := 'Não foi possível validar as configurações. Mensagem: ' +strMensagem;
      If Not apiCon.blnAutenticado Then
        Retorno := 'Não foi possível autenticar com a iMendes, verifique nas configurações o usuário e a senha. Mensagem: ' +strMensagem;
    Finally
      FreeAndNil(apiCon);
      Result := Retorno = ''
    End;
  Except
    on e: Exception do
    Begin
      Result := False;
      Retorno := 'Falha ao comunicar com a IMendes! ' + e.message;
    End;
  End;


end;

function TApiSaneamento.fValidarConfigs: Boolean;
begin

  Result := True;
  If (strURL = '') Then
    Exit(False);
  If (strUsuario = '') Then
    Exit(False);
  If (strSenha = '') Then
    Exit(False);
  If (intReqs.toString = '') Then
    Exit(False);
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

function fRemoveVirgula(Value: String): String;
begin
  Result := AnsiReplaceStr(Value, ',', '.');
End;


function TAPISaneamento.fGetParamsComunicador: TParamsComunicador;
Begin

  Result.IntTimeOut := intTimeout;
  Result.strUrl := strUrl;
  Result.strUrlAlterados := strUrlAtu;
  Result.strDiretorioJson := FDiretorioJSON;
  Result.strUsuario := strUsuario;
  Result.strSenha := strSenha;
End;


procedure TApiSaneamento.pIniciaThread;
var  Thread: TThreadComunicador;
begin

   {$IFDEF LINUX}

   WriteLog('Processando produto ' + qryItens.FieldByName('IME_CODITE').AsString + ' ...', HasParam('--logsactive'));
   {$ENDIF}


   If Not fValidaEan13(qryItens.FieldByName('IME_CODBAR').AsString) Then
   Begin
     TIMENDES_LOGTHREAD.pGravaLog(qryItens.FieldByName('IME_SEQCON').AsString,
                                 '[TApiSaneamento.pIniciaThread]',
                                 qryItens.FieldByName('IME_CODITE').AsString,
                                 qryItens.FieldByName('IME_CODEMP').AsString,
                                 '',
                                 FormatDateTime('dd/mm/yyyy hh:mm:ss', fImendesNow()) + ' | + Produto sem código EAN', qryLog, VariaveisDeControle);



     //VariaveisDeControle.SessaoCritica.Enter;
     Try
       qryComand.SQl.Clear;
       qryComand.SQL.Add('UPDATE IMENDES_ITENS SET IME_PROCES = 1, IME_SEMEAN =1, IME_SEMIME =1 ');
       qryComand.SQL.Add('WHERE IME_SEQCON = "'+ qryItens.FieldByName('IME_SEQCON').ASString+'"');
       qryComand.SQL.Add('AND IME_CODITE = "'+ qryItens.FieldByName('IME_CODITE').ASString+'"');
       qryComand.SQL.Add('AND IME_CODEMP = "'+ qryItens.FieldByName('IME_CODEMP').ASString+'";');
       qryComand.SQL.Add('UPDATE IMENDES_PARAM SET PROCESSADOS = PROCESSADOS + 1 WHERE AUTOINCREM = "'+ qryItens.FieldByName('IME_SEQCON').ASString+'";');
       qryComand.ExecSQL;
       VariaveisDeControle.SessaoCritica.Enter;
       Inc(VariaveisDeControle.intQtdRegistrosProcessados);
       VariaveisDeControle.SessaoCritica.Leave;



     finally
       //VariaveisDeControle.SessaoCritica.Leave;
     End;
     Exit;
   End;


   If (qryItens.FieldByName('IME_CSTORI').AsString) = '' Then
   Begin
     TIMENDES_LOGTHREAD.pGravaLog(qryItens.FieldByName('IME_SEQCON').AsString,
                                 '[TApiSaneamento.pIniciaThread]',
                                 qryItens.FieldByName('IME_CODITE').AsString,
                                 qryItens.FieldByName('IME_CODEMP').AsString,
                                 '',
                                 FormatDateTime('dd/mm/yyyy hh:mm:ss', fImendesNow()) + ' | + Produto sem código CST de Origem', qryLog, VariaveisDeControle);


     Try
       qryComand.SQl.Clear;
       qryComand.SQL.Add('UPDATE IMENDES_ITENS SET IME_PROCES = 1, IME_SEMEAN = 2, IME_SEMIME =1 ');
       qryComand.SQL.Add('WHERE IME_SEQCON = "'+ qryItens.FieldByName('IME_SEQCON').ASString+'"');
       qryComand.SQL.Add('AND IME_CODITE = "'+ qryItens.FieldByName('IME_CODITE').ASString+'"');
       qryComand.SQL.Add('AND IME_CODEMP = "'+ qryItens.FieldByName('IME_CODEMP').ASString+'";');
       qryComand.SQL.Add('UPDATE IMENDES_PARAM SET PROCESSADOS = PROCESSADOS + 1 WHERE AUTOINCREM = "'+ qryItens.FieldByName('IME_SEQCON').ASString+'";');
       qryComand.ExecSQL;
       VariaveisDeControle.SessaoCritica.Enter;
       Inc(VariaveisDeControle.intQtdRegistrosProcessados);
       VariaveisDeControle.SessaoCritica.Leave;



     finally
       //VariaveisDeControle.SessaoCritica.Leave;
     End;
     Exit;

   End;




  Thread := TThreadComunicador.Create(VariaveisDeControle,
                                      qryItens.FieldByName('IME_SEQCON').AsString,
                                      qryItens.FieldByName('IME_CODITE').AsString,
                                      qryItens.FieldByName('IME_CODEMP').AsString,
                                      FParamnsComunicador,
                                      recParametros,
                                      FDiretorioJSON);

  Thread.Start;
End;



procedure TAPISaneamento.pSelecionaItens;
begin

  pAbrirConsulta;
end;

procedure TAPISaneamento.pCarregaItensParaProcessar(blnFiltraIME_REPROS: Boolean = False);
var QtdTotal: integer;
    QtdTotalProcessados: integer;
begin

    qryItens.Close;
    qryItens.SQL.Text := 'SELECT COUNT(1) AS QTD FROM IMENDES_ITENS WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'"';
    qryItens.Open;
    QtdTotal := qryItens.FieldByName('QTD').AsInteger;

    qryItens.Close;
    qryItens.SQL.Text := 'SELECT COUNT(1) AS QTD FROM IMENDES_ITENS WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_PROCES = 1';
    qryItens.Open;
    QtdTotalProcessados := qryItens.FieldByName('QTD').AsInteger;


    qryItens.Close;
    qryItens.SQL.Text := 'SELECT IMENDES_ITENS.*,  ITE_DESITE, CADITE.ITE_CSTORI ' +
                         '  FROM IMENDES_ITENS ' +
                         '  LEFT JOIN CADITE ON CADITE.ITE_CODITE = IME_CODITE  ' +
                         ' WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" AND IME_PROCES = 0';
    If blnFiltraIME_REPROS Then
      qryItens.SQl.add( ' AND IME_REPROS = 1') ;

    qryItens.Open;


    GerenciaEstado.pAtualizaQtdProcessar(QtdTotal, QtdTotalProcessados);
end;

procedure TAPISaneamento.pCriaEstruturaBanco;
Begin
  pAlimentaTabelas_IMENDES_ITENS;
  pCriaEstruturaImendes_Resultado;
  pCriaEstruturaImendes_Json;
  pAtualizaStatus;
End;

procedure TAPISaneamento.pEnviaNotificacaoImendesAlterados;
begin

  Try
    qryComand.SQL.Clear;

    qryComand.SQL.Add('SELECT * FROM IMENDES_RESULTADO WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'" LIMIT 1');
    qryComand.Open;

    If not qryComand.IsEmpty Then
    Begin
      qryComand.SQL.Clear;
      qryComand.SQL.Add('CALL pGeraNotificaoIMENDES_ALTERADOS("'+GerenciaEstado.AutIncRegAtual+'");');
      qryComand.SQL.Add('UPDATE IMENDES_PARAM SET IME_NOTFIC = "S" WHERE AUTOINCREM = "'+GerenciaEstado.AutIncRegAtual+'";');
      qryComand.ExecSQL;
    End;



  Except
    //Silencia para caso a fução não estiver sido implementada no banco
  End;
end;

procedure TAPISaneamento.pExecutaComunicacaoIMendes;
var intNumErros: integer;
Begin

  pPesquisar(intNumErros);
  pAtualizaStatus;
End;

function TApiSaneamento.fInsereIMENDES_RESULTADO(blnParcial: Boolean;ADados, AQryItens: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}; strAutoincrem:String): Boolean;
var perfil: TPerfil;
    perfilConj: TConjPerfis;
    strPefil: string;
    strPerfRes: String;
    lstSQL: TStringList;
    incQtd: integer;
begin

  lstSQL := TStringList.Create;
  Try
    If not blnParcial Then
    Begin
      ADados.SQL.Clear;
      ADados.SQL.Add('DELETE FROM IMENDES_RESULTADO WHERE IME_SEQCON = "'+strAutoincrem+'"');
      ADados.ExecSQL;
    End;



    AQryItens.SQL.Clear;
    AQryItens.SQL.Add('SELECT IME_CODITE FROM IMENDES_ITENS WHERE IME_SEQCON = "'+strAutoincrem+'"');
    If blnParcial then
      AQryItens.SQL.Add(' AND IME_REPROS = 1');
    AQryItens.Open;


    lstSQL.Clear;
    perfilConj := [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS];

    lstSQL.Add(' INSERT INTO IMENDES_RESULTADO(');
    lstSQL.Add('DIF_INF_GERAIS,');
    lstSQL.Add('DIF_ICMS,');
    lstSQL.Add('ITEM,');

    lstSQL.Add('IME_SEQCON,');
    lstSQL.Add('IME_CODITE,');
    lstSQL.Add('IME_SEQUEN,');
    lstSQL.Add('IME_CODEMP,');

    lstSQL.Add('ITE_CLAIPI,');
    lstSQL.Add('ITE_DESITE,');
    lstSQL.Add('IME_GERABF,');
    lstSQL.Add('ABF_CODABF,');
    lstSQL.Add('ABF_ESTADO,');
    lstSQL.Add('IME_SEMIME,');
    lstSQL.Add('IME_RETPAR,');
    lstSQL.Add('IME_SEMEAN,');
    lstSQL.Add('EXCLUIDO,');
    lstSQL.Add('TIPABF,');
    lstSQL.Add('EXCIPI,');
    lstSQL.Add('DIF_CLAIPI,');
    lstSQL.Add('DIF_CODLUB,');
    lstSQL.Add('DIF_ITE_CLAIPI,');
    lstSQL.Add('DIF_ITE_CDCEST,');
    lstSQL.Add('DIF_ITE_CODLUB,');
    lstSQL.Add('DIF_EXCIPI,');
    lstSQL.Add('ABF_CODSIT_ENT_PEF,');
    lstSQL.Add('ABF_CODBEN_ENT_PEF,');
    lstSQL.Add('ABF_BASICM_ENT_PEF,');
    lstSQL.Add('ABF_ALQICM_ENT_PEF,');
    lstSQL.Add('ABF_BASRET_ENT_PEF,');
    lstSQL.Add('ABF_ALQRET_ENT_PEF,');
    lstSQL.Add('ABF_IVA_ST_ENT_PEF,');
    lstSQL.Add('ABF_ALQFCP_ENT_PEF,');
    lstSQL.Add('ABF_ALQEFO_ENT_PEF,');
    lstSQL.Add('ABF_ALQIED_ENT_PEF,');
    lstSQL.Add('ABF_ALQRED_ENT_PEF,');
    lstSQL.Add('ABF_BASDDS_ENT_PEF,');
    lstSQL.Add('DIF_CODSIT_ENT_PEF,');
    lstSQL.Add('DIF_BASICM_ENT_PEF,');
    lstSQL.Add('DIF_ALQICM_ENT_PEF,');
    lstSQL.Add('DIF_BASRET_ENT_PEF,');
    lstSQL.Add('DIF_ALQRET_ENT_PEF,');
    lstSQL.Add('DIF_IVA_ST_ENT_PEF,');
    lstSQL.Add('DIF_ALQFCP_ENT_PEF,');
    lstSQL.Add('DIF_ALQEFO_ENT_PEF,');
    lstSQL.Add('DIF_ALQIED_ENT_PEF,');
    lstSQL.Add('DIF_ALQRED_ENT_PEF,');
    lstSQL.Add('DIF_BASDDS_ENT_PEF,');
    lstSQL.Add('ORI_ABF_CODSIT_ENT_PEF,');
    lstSQL.Add('ABF_CODSIT_ENT_PEJ,');
    lstSQL.Add('ABF_CODBEN_ENT_PEJ,');
    lstSQL.Add('ABF_BASICM_ENT_PEJ,');
    lstSQL.Add('ABF_ALQICM_ENT_PEJ,');
    lstSQL.Add('ABF_BASRET_ENT_PEJ,');
    lstSQL.Add('ABF_ALQRET_ENT_PEJ,');
    lstSQL.Add('ABF_IVA_ST_ENT_PEJ,');
    lstSQL.Add('ABF_ALQFCP_ENT_PEJ,');
    lstSQL.Add('ABF_ALQEFO_ENT_PEJ,');
    lstSQL.Add('ABF_ALQIED_ENT_PEJ,');
    lstSQL.Add('ABF_ALQRED_ENT_PEJ,');
    lstSQL.Add('ABF_BASDDS_ENT_PEJ,');
    lstSQL.Add('DIF_CODSIT_ENT_PEJ,');
    lstSQL.Add('DIF_BASICM_ENT_PEJ,');
    lstSQL.Add('DIF_ALQICM_ENT_PEJ,');
    lstSQL.Add('DIF_BASRET_ENT_PEJ,');
    lstSQL.Add('DIF_ALQRET_ENT_PEJ,');
    lstSQL.Add('DIF_IVA_ST_ENT_PEJ,');
    lstSQL.Add('DIF_ALQFCP_ENT_PEJ,');
    lstSQL.Add('DIF_ALQEFO_ENT_PEJ,');
    lstSQL.Add('DIF_ALQIED_ENT_PEJ,');
    lstSQL.Add('DIF_ALQRED_ENT_PEJ,');
    lstSQL.Add('DIF_BASDDS_ENT_PEJ,');
    lstSQL.Add('ORI_ABF_CODSIT_ENT_PEJ,');
    lstSQL.Add('ABF_CODSIT_ENT_PER,');
    lstSQL.Add('ABF_CODBEN_ENT_PER,');
    lstSQL.Add('ABF_BASICM_ENT_PER,');
    lstSQL.Add('ABF_ALQICM_ENT_PER,');
    lstSQL.Add('ABF_BASRET_ENT_PER,');
    lstSQL.Add('ABF_ALQRET_ENT_PER,');
    lstSQL.Add('ABF_IVA_ST_ENT_PER,');
    lstSQL.Add('ABF_ALQFCP_ENT_PER,');
    lstSQL.Add('ABF_ALQEFO_ENT_PER,');
    lstSQL.Add('ABF_ALQIED_ENT_PER,');
    lstSQL.Add('ABF_ALQRED_ENT_PER,');
    lstSQL.Add('ABF_BASDDS_ENT_PER,');
    lstSQL.Add('DIF_CODSIT_ENT_PER,');
    lstSQL.Add('DIF_BASICM_ENT_PER,');
    lstSQL.Add('DIF_ALQICM_ENT_PER,');
    lstSQL.Add('DIF_BASRET_ENT_PER,');
    lstSQL.Add('DIF_ALQRET_ENT_PER,');
    lstSQL.Add('DIF_IVA_ST_ENT_PER,');
    lstSQL.Add('DIF_ALQFCP_ENT_PER,');
    lstSQL.Add('DIF_ALQEFO_ENT_PER,');
    lstSQL.Add('DIF_ALQIED_ENT_PER,');
    lstSQL.Add('DIF_ALQRED_ENT_PER,');
    lstSQL.Add('DIF_BASDDS_ENT_PER,');
    lstSQL.Add('ORI_ABF_CODSIT_ENT_PER,');
    lstSQL.Add('ABF_CODSIT_ENT_PES,');
    lstSQL.Add('ABF_CODBEN_ENT_PES,');
    lstSQL.Add('ABF_BASICM_ENT_PES,');
    lstSQL.Add('ABF_ALQICM_ENT_PES,');
    lstSQL.Add('ABF_BASRET_ENT_PES,');
    lstSQL.Add('ABF_ALQRET_ENT_PES,');
    lstSQL.Add('ABF_IVA_ST_ENT_PES,');
    lstSQL.Add('ABF_ALQFCP_ENT_PES,');
    lstSQL.Add('ABF_ALQEFO_ENT_PES,');
    lstSQL.Add('ABF_ALQIED_ENT_PES,');
    lstSQL.Add('ABF_ALQRED_ENT_PES,');
    lstSQL.Add('ABF_BASDDS_ENT_PES,');
    lstSQL.Add('DIF_CODSIT_ENT_PES,');
    lstSQL.Add('DIF_BASICM_ENT_PES,');
    lstSQL.Add('DIF_ALQICM_ENT_PES,');
    lstSQL.Add('DIF_BASRET_ENT_PES,');
    lstSQL.Add('DIF_ALQRET_ENT_PES,');
    lstSQL.Add('DIF_IVA_ST_ENT_PES,');
    lstSQL.Add('DIF_ALQFCP_ENT_PES,');
    lstSQL.Add('DIF_ALQEFO_ENT_PES,');
    lstSQL.Add('DIF_ALQIED_ENT_PES,');
    lstSQL.Add('DIF_ALQRED_ENT_PES,');
    lstSQL.Add('DIF_BASDDS_ENT_PES,');
    lstSQL.Add('ORI_ABF_CODSIT_ENT_PES,');
    lstSQL.Add('ABF_CODSIT_ENT_PSI,');
    lstSQL.Add('ABF_CODBEN_ENT_PSI,');
    lstSQL.Add('ABF_BASICM_ENT_PSI,');
    lstSQL.Add('ABF_ALQICM_ENT_PSI,');
    lstSQL.Add('ABF_BASRET_ENT_PSI,');
    lstSQL.Add('ABF_ALQRET_ENT_PSI,');
    lstSQL.Add('ABF_IVA_ST_ENT_PSI,');
    lstSQL.Add('ABF_ALQFCP_ENT_PSI,');
    lstSQL.Add('ABF_ALQEFO_ENT_PSI,');
    lstSQL.Add('ABF_ALQIED_ENT_PSI,');
    lstSQL.Add('ABF_ALQRED_ENT_PSI,');
    lstSQL.Add('ABF_BASDDS_ENT_PSI,');
    lstSQL.Add('DIF_CODSIT_ENT_PSI,');
    lstSQL.Add('DIF_BASICM_ENT_PSI,');
    lstSQL.Add('DIF_ALQICM_ENT_PSI,');
    lstSQL.Add('DIF_BASRET_ENT_PSI,');
    lstSQL.Add('DIF_ALQRET_ENT_PSI,');
    lstSQL.Add('DIF_IVA_ST_ENT_PSI,');
    lstSQL.Add('DIF_ALQFCP_ENT_PSI,');
    lstSQL.Add('DIF_ALQEFO_ENT_PSI,');
    lstSQL.Add('DIF_ALQIED_ENT_PSI,');
    lstSQL.Add('DIF_ALQRED_ENT_PSI,');
    lstSQL.Add('DIF_BASDDS_ENT_PSI,');
    lstSQL.Add('ORI_ABF_CODSIT_ENT_PSI,');
    lstSQL.Add('ABF_CODSIT_ENT_PII,');
    lstSQL.Add('ABF_CODBEN_ENT_PII,');
    lstSQL.Add('ABF_BASICM_ENT_PII,');
    lstSQL.Add('ABF_ALQICM_ENT_PII,');
    lstSQL.Add('ABF_BASRET_ENT_PII,');
    lstSQL.Add('ABF_ALQRET_ENT_PII,');
    lstSQL.Add('ABF_IVA_ST_ENT_PII,');
    lstSQL.Add('ABF_ALQFCP_ENT_PII,');
    lstSQL.Add('ABF_ALQEFO_ENT_PII,');
    lstSQL.Add('ABF_ALQIED_ENT_PII,');
    lstSQL.Add('ABF_ALQRED_ENT_PII,');
    lstSQL.Add('ABF_BASDDS_ENT_PII,');
    lstSQL.Add('DIF_CODSIT_ENT_PII,');
    lstSQL.Add('DIF_BASICM_ENT_PII,');
    lstSQL.Add('DIF_ALQICM_ENT_PII,');
    lstSQL.Add('DIF_BASRET_ENT_PII,');
    lstSQL.Add('DIF_ALQRET_ENT_PII,');
    lstSQL.Add('DIF_IVA_ST_ENT_PII,');
    lstSQL.Add('DIF_ALQFCP_ENT_PII,');
    lstSQL.Add('DIF_ALQEFO_ENT_PII,');
    lstSQL.Add('DIF_ALQIED_ENT_PII,');
    lstSQL.Add('DIF_ALQRED_ENT_PII,');
    lstSQL.Add('DIF_BASDDS_ENT_PII,');
    lstSQL.Add('ORI_ABF_CODSIT_ENT_PII,');
    lstSQL.Add('ABF_CODSIT_SAI_NCO,');
    lstSQL.Add('ABF_CODBEN_SAI_NCO,');
    lstSQL.Add('ABF_BASICM_SAI_NCO,');
    lstSQL.Add('ABF_ALQICM_SAI_NCO,');
    lstSQL.Add('ABF_BASRET_SAI_NCO,');
    lstSQL.Add('ABF_ALQRET_SAI_NCO,');
    lstSQL.Add('ABF_IVA_ST_SAI_NCO,');
    lstSQL.Add('ABF_ALQFCP_SAI_NCO,');
    lstSQL.Add('ABF_ALQEFO_SAI_NCO,');
    lstSQL.Add('ABF_ALQIED_SAI_NCO,');
    lstSQL.Add('ABF_ALQRED_SAI_NCO,');
    lstSQL.Add('ABF_BASDDS_SAI_NCO,');
    lstSQL.Add('DIF_CODSIT_SAI_NCO,');
    lstSQL.Add('DIF_BASICM_SAI_NCO,');
    lstSQL.Add('DIF_ALQICM_SAI_NCO,');
    lstSQL.Add('DIF_BASRET_SAI_NCO,');
    lstSQL.Add('DIF_ALQRET_SAI_NCO,');
    lstSQL.Add('DIF_IVA_ST_SAI_NCO,');
    lstSQL.Add('DIF_ALQFCP_SAI_NCO,');
    lstSQL.Add('DIF_ALQEFO_SAI_NCO,');
    lstSQL.Add('DIF_ALQIED_SAI_NCO,');
    lstSQL.Add('DIF_ALQRED_SAI_NCO,');
    lstSQL.Add('DIF_BASDDS_SAI_NCO,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_NCO,');
    lstSQL.Add('ABF_CODSIT_SAI_CCO,');
    lstSQL.Add('ABF_CODBEN_SAI_CCO,');
    lstSQL.Add('ABF_BASICM_SAI_CCO,');
    lstSQL.Add('ABF_ALQICM_SAI_CCO,');
    lstSQL.Add('ABF_BASRET_SAI_CCO,');
    lstSQL.Add('ABF_ALQRET_SAI_CCO,');
    lstSQL.Add('ABF_IVA_ST_SAI_CCO,');
    lstSQL.Add('ABF_ALQFCP_SAI_CCO,');
    lstSQL.Add('ABF_ALQEFO_SAI_CCO,');
    lstSQL.Add('ABF_ALQIED_SAI_CCO,');
    lstSQL.Add('ABF_ALQRED_SAI_CCO,');
    lstSQL.Add('ABF_BASDDS_SAI_CCO,');
    lstSQL.Add('DIF_CODSIT_SAI_CCO,');
    lstSQL.Add('DIF_BASICM_SAI_CCO,');
    lstSQL.Add('DIF_ALQICM_SAI_CCO,');
    lstSQL.Add('DIF_BASRET_SAI_CCO,');
    lstSQL.Add('DIF_ALQRET_SAI_CCO,');
    lstSQL.Add('DIF_IVA_ST_SAI_CCO,');
    lstSQL.Add('DIF_ALQFCP_SAI_CCO,');
    lstSQL.Add('DIF_ALQEFO_SAI_CCO,');
    lstSQL.Add('DIF_ALQIED_SAI_CCO,');
    lstSQL.Add('DIF_ALQRED_SAI_CCO,');
    lstSQL.Add('DIF_BASDDS_SAI_CCO,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_CCO,');
    lstSQL.Add('ABF_CODSIT_SAI_CNC,');
    lstSQL.Add('ABF_CODBEN_SAI_CNC,');
    lstSQL.Add('ABF_BASICM_SAI_CNC,');
    lstSQL.Add('ABF_ALQICM_SAI_CNC,');
    lstSQL.Add('ABF_BASRET_SAI_CNC,');
    lstSQL.Add('ABF_ALQRET_SAI_CNC,');
    lstSQL.Add('ABF_IVA_ST_SAI_CNC,');
    lstSQL.Add('ABF_ALQFCP_SAI_CNC,');
    lstSQL.Add('ABF_ALQEFO_SAI_CNC,');
    lstSQL.Add('ABF_ALQIED_SAI_CNC,');
    lstSQL.Add('ABF_ALQRED_SAI_CNC,');
    lstSQL.Add('ABF_BASDDS_SAI_CNC,');
    lstSQL.Add('DIF_CODSIT_SAI_CNC,');
    lstSQL.Add('DIF_BASICM_SAI_CNC,');
    lstSQL.Add('DIF_ALQICM_SAI_CNC,');
    lstSQL.Add('DIF_BASRET_SAI_CNC,');
    lstSQL.Add('DIF_ALQRET_SAI_CNC,');
    lstSQL.Add('DIF_IVA_ST_SAI_CNC,');
    lstSQL.Add('DIF_ALQFCP_SAI_CNC,');
    lstSQL.Add('DIF_ALQEFO_SAI_CNC,');
    lstSQL.Add('DIF_ALQIED_SAI_CNC,');
    lstSQL.Add('DIF_ALQRED_SAI_CNC,');
    lstSQL.Add('DIF_BASDDS_SAI_CNC,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_CNC,');
    lstSQL.Add('ABF_CODSIT_SAI_SNA,');
    lstSQL.Add('ABF_CODBEN_SAI_SNA,');
    lstSQL.Add('ABF_BASICM_SAI_SNA,');
    lstSQL.Add('ABF_ALQICM_SAI_SNA,');
    lstSQL.Add('ABF_BASRET_SAI_SNA,');
    lstSQL.Add('ABF_ALQRET_SAI_SNA,');
    lstSQL.Add('ABF_IVA_ST_SAI_SNA,');
    lstSQL.Add('ABF_ALQFCP_SAI_SNA,');
    lstSQL.Add('ABF_ALQEFO_SAI_SNA,');
    lstSQL.Add('ABF_ALQIED_SAI_SNA,');
    lstSQL.Add('ABF_ALQRED_SAI_SNA,');
    lstSQL.Add('ABF_BASDDS_SAI_SNA,');
    lstSQL.Add('DIF_CODSIT_SAI_SNA,');
    lstSQL.Add('DIF_BASICM_SAI_SNA,');
    lstSQL.Add('DIF_ALQICM_SAI_SNA,');
    lstSQL.Add('DIF_BASRET_SAI_SNA,');
    lstSQL.Add('DIF_ALQRET_SAI_SNA,');
    lstSQL.Add('DIF_IVA_ST_SAI_SNA,');
    lstSQL.Add('DIF_ALQFCP_SAI_SNA,');
    lstSQL.Add('DIF_ALQEFO_SAI_SNA,');
    lstSQL.Add('DIF_ALQIED_SAI_SNA,');
    lstSQL.Add('DIF_ALQRED_SAI_SNA,');
    lstSQL.Add('DIF_BASDDS_SAI_SNA,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_SNA,');
    lstSQL.Add('ABF_CODSIT_SAI_CTA,');
    lstSQL.Add('ABF_CODBEN_SAI_CTA,');
    lstSQL.Add('ABF_BASICM_SAI_CTA,');
    lstSQL.Add('ABF_ALQICM_SAI_CTA,');
    lstSQL.Add('ABF_BASRET_SAI_CTA,');
    lstSQL.Add('ABF_ALQRET_SAI_CTA,');
    lstSQL.Add('ABF_IVA_ST_SAI_CTA,');
    lstSQL.Add('ABF_ALQFCP_SAI_CTA,');
    lstSQL.Add('ABF_ALQEFO_SAI_CTA,');
    lstSQL.Add('ABF_ALQIED_SAI_CTA,');
    lstSQL.Add('ABF_ALQRED_SAI_CTA,');
    lstSQL.Add('ABF_BASDDS_SAI_CTA,');
    lstSQL.Add('DIF_CODSIT_SAI_CTA,');
    lstSQL.Add('DIF_BASICM_SAI_CTA,');
    lstSQL.Add('DIF_ALQICM_SAI_CTA,');
    lstSQL.Add('DIF_BASRET_SAI_CTA,');
    lstSQL.Add('DIF_ALQRET_SAI_CTA,');
    lstSQL.Add('DIF_IVA_ST_SAI_CTA,');
    lstSQL.Add('DIF_ALQFCP_SAI_CTA,');
    lstSQL.Add('DIF_ALQEFO_SAI_CTA,');
    lstSQL.Add('DIF_ALQIED_SAI_CTA,');
    lstSQL.Add('DIF_ALQRED_SAI_CTA,');
    lstSQL.Add('DIF_BASDDS_SAI_CTA,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_CTA,');
    lstSQL.Add('ABF_CODSIT_SAI_PRU,');
    lstSQL.Add('ABF_CODBEN_SAI_PRU,');
    lstSQL.Add('ABF_BASICM_SAI_PRU,');
    lstSQL.Add('ABF_ALQICM_SAI_PRU,');
    lstSQL.Add('ABF_BASRET_SAI_PRU,');
    lstSQL.Add('ABF_ALQRET_SAI_PRU,');
    lstSQL.Add('ABF_IVA_ST_SAI_PRU,');
    lstSQL.Add('ABF_ALQFCP_SAI_PRU,');
    lstSQL.Add('ABF_ALQEFO_SAI_PRU,');
    lstSQL.Add('ABF_ALQIED_SAI_PRU,');
    lstSQL.Add('ABF_ALQRED_SAI_PRU,');
    lstSQL.Add('ABF_BASDDS_SAI_PRU,');
    lstSQL.Add('DIF_CODSIT_SAI_PRU,');
    lstSQL.Add('DIF_BASICM_SAI_PRU,');
    lstSQL.Add('DIF_ALQICM_SAI_PRU,');
    lstSQL.Add('DIF_BASRET_SAI_PRU,');
    lstSQL.Add('DIF_ALQRET_SAI_PRU,');
    lstSQL.Add('DIF_IVA_ST_SAI_PRU,');
    lstSQL.Add('DIF_ALQFCP_SAI_PRU,');
    lstSQL.Add('DIF_ALQEFO_SAI_PRU,');
    lstSQL.Add('DIF_ALQIED_SAI_PRU,');
    lstSQL.Add('DIF_ALQRED_SAI_PRU,');
    lstSQL.Add('DIF_BASDDS_SAI_PRU,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_PRU,');
    lstSQL.Add('ABF_CODSIT_SAI_IND,');
    lstSQL.Add('ABF_CODBEN_SAI_IND,');
    lstSQL.Add('ABF_BASICM_SAI_IND,');
    lstSQL.Add('ABF_ALQICM_SAI_IND,');
    lstSQL.Add('ABF_BASRET_SAI_IND,');
    lstSQL.Add('ABF_ALQRET_SAI_IND,');
    lstSQL.Add('ABF_IVA_ST_SAI_IND,');
    lstSQL.Add('ABF_ALQFCP_SAI_IND,');
    lstSQL.Add('ABF_ALQEFO_SAI_IND,');
    lstSQL.Add('ABF_ALQIED_SAI_IND,');
    lstSQL.Add('ABF_ALQRED_SAI_IND,');
    lstSQL.Add('ABF_BASDDS_SAI_IND,');
    lstSQL.Add('DIF_CODSIT_SAI_IND,');
    lstSQL.Add('DIF_BASICM_SAI_IND,');
    lstSQL.Add('DIF_ALQICM_SAI_IND,');
    lstSQL.Add('DIF_BASRET_SAI_IND,');
    lstSQL.Add('DIF_ALQRET_SAI_IND,');
    lstSQL.Add('DIF_IVA_ST_SAI_IND,');
    lstSQL.Add('DIF_ALQFCP_SAI_IND,');
    lstSQL.Add('DIF_ALQEFO_SAI_IND,');
    lstSQL.Add('DIF_ALQIED_SAI_IND,');
    lstSQL.Add('DIF_ALQRED_SAI_IND,');
    lstSQL.Add('DIF_BASDDS_SAI_IND,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_IND,');
    lstSQL.Add('ABF_CODSIT_SAI_TRS,');
    lstSQL.Add('ABF_CODBEN_SAI_TRS,');
    lstSQL.Add('ABF_BASICM_SAI_TRS,');
    lstSQL.Add('ABF_ALQICM_SAI_TRS,');
    lstSQL.Add('ABF_BASRET_SAI_TRS,');
    lstSQL.Add('ABF_ALQRET_SAI_TRS,');
    lstSQL.Add('ABF_IVA_ST_SAI_TRS,');
    lstSQL.Add('ABF_ALQFCP_SAI_TRS,');
    lstSQL.Add('ABF_ALQEFO_SAI_TRS,');
    lstSQL.Add('ABF_ALQIED_SAI_TRS,');
    lstSQL.Add('ABF_ALQRED_SAI_TRS,');
    lstSQL.Add('ABF_BASDDS_SAI_TRS,');
    lstSQL.Add('DIF_CODSIT_SAI_TRS,');
    lstSQL.Add('DIF_BASICM_SAI_TRS,');
    lstSQL.Add('DIF_ALQICM_SAI_TRS,');
    lstSQL.Add('DIF_BASRET_SAI_TRS,');
    lstSQL.Add('DIF_ALQRET_SAI_TRS,');
    lstSQL.Add('DIF_IVA_ST_SAI_TRS,');
    lstSQL.Add('DIF_ALQFCP_SAI_TRS,');
    lstSQL.Add('DIF_ALQEFO_SAI_TRS,');
    lstSQL.Add('DIF_ALQIED_SAI_TRS,');
    lstSQL.Add('DIF_ALQRED_SAI_TRS,');
    lstSQL.Add('DIF_BASDDS_SAI_TRS,');
    lstSQL.Add('ORI_ABF_CODSIT_SAI_TRS,');

  //
    For perfil in perfilConj do
    Begin
      strPefil := fConvertConfPerfilToAliasFieldString(perfil);
      strPerfRes := Copy(strPefil, 6, 3);
      lstSQL.Add('ABF_IME_AMPLEG_' + strPerfRes +',');
      lstSQL.Add('ABF_IME_PTCNOM_' + strPerfRes +',');
      lstSQL.Add('ABF_IME_PTCDES_' + strPerfRes +',');
      lstSQL.Add('ABF_IME_CONNOM_' + strPerfRes +',');
      lstSQL.Add('ABF_IME_CONDES_' + strPerfRes +',');
    End;

    lstSQL.Add('LOCAL');
    lstSQL.Add(') SELECT ');

    lstSQL.Add('((DIF_EXCIPI = 1) OR');
    lstSQL.Add(' (DIF_ITE_CLAIPI) OR');
    lstSQL.Add(' (DIF_ITE_CDCEST) OR');
    lstSQL.Add(' (DIF_ITE_CODLUB)) AS DIF_INF_GERAIS,');
    lstSQL.Add('');
    lstSQL.Add('');
    lstSQL.Add('((DIF_CODSIT_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_BASICM_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_ALQICM_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_BASRET_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_ALQRET_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_ALQIED_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_ALQRED_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_BASDDS_ENT_PEF = 1) OR');
    lstSQL.Add('(DIF_CODSIT_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_BASICM_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_ALQICM_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_BASRET_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_ALQRET_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_ALQIED_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_ALQRED_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_BASDDS_ENT_PEJ = 1) OR');
    lstSQL.Add('(DIF_CODSIT_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_BASICM_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_ALQICM_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_BASRET_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_ALQRET_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_ALQIED_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_ALQRED_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_BASDDS_ENT_PER = 1) OR');
    lstSQL.Add('(DIF_CODSIT_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_BASICM_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_ALQICM_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_BASRET_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_ALQRET_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_ALQIED_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_ALQRED_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_BASDDS_ENT_PES = 1) OR');
    lstSQL.Add('(DIF_CODSIT_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_BASICM_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_ALQICM_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_BASRET_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_ALQRET_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_ALQIED_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_ALQRED_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_BASDDS_ENT_PSI = 1) OR');
    lstSQL.Add('(DIF_CODSIT_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_BASICM_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_ALQICM_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_BASRET_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_ALQRET_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_ALQIED_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_ALQRED_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_BASDDS_ENT_PII = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_NCO = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_CCO = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_CNC = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_SNA = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_CTA = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_PRU = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_IND = 1) OR');
    lstSQL.Add('(DIF_CODSIT_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_BASICM_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_ALQICM_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_BASRET_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_ALQRET_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_IVA_ST_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_ALQFCP_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_ALQEFO_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_ALQIED_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_ALQRED_SAI_TRS = 1) OR');
    lstSQL.Add('(DIF_BASDDS_SAI_TRS = 1)) DIF_ICMS,');

    lstSQL.Add('        TMP.*');
    lstSQL.Add('          FROM ( ');
    lstSQL.Add('SELECT CAST(CONCAT(ITE_DESITE,"<TAG_AUTCOM>", ITENS.IME_CODITE, "-", ITE_DESITE) AS CHAR(120)) AS ITEM,') ;
    lstSQL.Add('       ITENS.IME_SEQCON,');
    lstSQL.Add('       ITENS.IME_CODITE,');
    lstSQL.Add('       ITENS.IME_SEQUEN,');
    lstSQL.Add('       ITENS.IME_CODEMP,');

    lstSQL.Add('       ITE_CLAIPI,');
    lstSQL.Add('       ITE_DESITE,');
    lstSQL.Add('       IME_GERABF,');
    lstSQL.Add('       ABF_CODABF,');
    lstSQL.Add('       IME_UNIFED,');
    lstSQL.Add('       IME_SEMIME,');
    lstSQL.Add('       IME_RETPAR,');

    lstSQL.Add('       IME_SEMEAN,');
    lstSQL.Add('       ITENS.EXCLUIDO,');

    lstSQL.Add('       TIPABF.SIS_VALCFG AS TIPABF,');

    lstSQL.Add('       @EXCIPI := IFNULL(IF(TPABPC.SIS_VALCFG = "1", CADITE.ITE_EXCIPI, ITEGER.ITE_EXCIPI), "") AS EXCIPI,');
    lstSQL.Add('       IME_CODNCM <> ITE_CLAIPI AS DIF_CLAIPI,');
  
    lstSQL.Add('       IME_CODLUB <> ITE_CODLUB AS DIF_CODLUB,');
    lstSQL.Add('       IFNULL(IME_CODNCM, "") <> IFNULL(ITE_CLAIPI, "") AS DIF_ITE_CLAIPI,');
    lstSQL.Add('       IFNULL(ITE_CDCEST, "") <> IFNULL(IME_CDCEST, "") AS DIF_ITE_CDCEST,');
    lstSQL.Add('       IFNULL(IME_CODLUB, "") <> IFNULL(ITE_CODLUB, "") AS DIF_ITE_CODLUB,');

    lstSQL.Add('       IME_EXCIPI <> @EXCIPI AS DIF_EXCIPI,');


    For perfil in perfilConj do
    Begin
      strPefil := fConvertConfPerfilToAliasFieldString(perfil);
      strPerfRes := Copy(strPefil, 6, 3);

      lstSQL.Add('       IME' + strPerfRes + '.IME_CODSIT AS ABF_CODSIT' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_CODBEN AS ABF_CODBEN' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_BASICM AS ABF_BASICM' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_ALQICM AS ABF_ALQICM' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_BASRET AS ABF_BASRET' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_ALQRET AS ABF_ALQRET' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_IVA_ST AS ABF_IVA_ST' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_ALQFCP AS ABF_ALQFCP' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_ALQEFO AS ABF_ALQEFO' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_ALQIED AS ABF_ALQIED' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_ALQRED AS ABF_ALQRED' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_BASDDS AS ABF_BASDDS' + strPefil + ',');




      lstSQL.Add('       SUBSTRING(IFNULL(ABF_CODSIT' + strPefil + ', ""),2,3) <> IFNULL(IME' + strPerfRes + '.IME_CODSIT, "") AS DIF_CODSIT' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_BASICM' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_BASICM, "") AS DIF_BASICM' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_ALQICM' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQICM, "") AS DIF_ALQICM' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_BASRET' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_BASRET, "") AS DIF_BASRET' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_ALQRET' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQRET, "") AS DIF_ALQRET' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_IVA_ST' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_IVA_ST, "") AS DIF_IVA_ST' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_ALQFCP' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQFCP, "") AS DIF_ALQFCP' + strPefil + ',');

      lstSQL.Add('       IFNULL(ABF_ALQEFO' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQEFO, "") AS DIF_ALQEFO' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_ALQIED' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQIED, "") AS DIF_ALQIED' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_ALQRED' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQRED, "") AS DIF_ALQRED' + strPefil + ',');
      lstSQL.Add('       IFNULL(ABF_BASDDS' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_BASDDS, "") AS DIF_BASDDS' + strPefil + ',');

      lstSQL.Add('       ABF_CODSIT' + strPefil + ' AS ORI_ABF_CODSIT' + strPefil + ', ');




    End;

    For perfil in perfilConj do
    Begin
      strPefil := fConvertConfPerfilToAliasFieldString(perfil);
      strPerfRes := Copy(strPefil, 6, 3);
      lstSQL.Add('       IME' + strPerfRes + '.IME_AMPLEG AS ABF_IME_AMPLEG' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_PTCNOM AS ABF_IME_PTCNOM' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_PTCDES AS ABF_IME_PTCDES' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_CONNOM AS ABF_IME_CONNOM' + strPefil + ',');
      lstSQL.Add('       IME' + strPerfRes + '.IME_CONDES AS ABF_IME_CONDES' + strPefil + ',');
    End;


    lstSQL.Add('       "iMendes" AS LOCAL');
    lstSQL.Add('  FROM IMENDES_ITENS ITENS');
    lstSQL.Add('  LEFT JOIN CADITE ON CADITE.ITE_CODITE = ITENS.IME_CODITE');
    lstSQL.Add('  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = ITENS.IME_CODITE AND ITEGER.ITE_CODEMP =  IF(IFNULL(IME_CODEMP, "") = "", "'+{$IFNDEF LINUX}iMendes_strCodEmp{$ELSE}VS_strCodEmp{$ENDIF}+'", IME_CODEMP)');
    lstSQL.Add('  LEFT JOIN CFGSIS TIPABF ON TIPABF.SIS_CODCFG = "CFG_TIPABF" AND TIPABF.SIS_CODEMP =ITEGER.ITE_CODEMP');
    lstSQL.Add('  LEFT JOIN CFGSIS TPABPC ON TPABPC.SIS_CODCFG = "CFG_TPABPC" AND TPABPC.SIS_CODEMP =ITEGER.ITE_CODEMP');
    lstSQL.Add('  LEFT JOIN CFGSIS UTIABI ON UTIABI.SIS_CODCFG = "CFG_UTIABI" AND UTIABI.SIS_CODEMP =ITEGER.ITE_CODEMP');

    lstSQL.Add('  LEFT JOIN IMENDES_ESTADOS ON TRUE ');
    lstSQL.Add('  LEFT JOIN ABFICM ON ABFICM.ABF_CODABF = IF(TIPABF.SIS_VALCFG = "1", CADITE.ITE_CODABF, ITEGER.ITE_CODABF) AND ABFICM.ABF_ESTADO = IMENDES_ESTADOS.IME_UNIFED ');


    For perfil in perfilConj do
    Begin
      case perfil of
        cjpPEF: strPefil := 'PEF';
        cjpPEJ: strPefil := 'PEJ';
        cjpPER: strPefil := 'PER';
        cjpPES: strPefil := 'PES';
        cjpPSI: strPefil := 'PSI';
        cjpPII: strPefil := 'PII';
        cjpNCO: strPefil := 'NCO';
        cjpCCO: strPefil := 'CCO';
        cjpCNC: strPefil := 'CNC';
        cjpSNA: strPefil := 'SNA';
        cjpCTA: strPefil := 'CTA';
        cjpPRU: strPefil := 'PRU';
        cjpIND: strPefil := 'IND';
        cjpTRS: strPefil := 'TRS';
      end;
      lstSQL.Add('  LEFT JOIN IMENDES_ABFICM IME' + strPefil + ' ON IME' + strPefil + '.IME_SEQCON = ITENS.IME_SEQCON AND IME' + strPefil + '.IME_CODITE = ITENS.IME_CODITE AND IME' + strPefil + '.IME_CODEMP = ITENS.IME_CODEMP  AND IME' + strPefil + '.IME_ESTADO = IMENDES_ESTADOS.IME_UNIFED AND IME' + strPefil + '.IME_PERFIL = "' + strPefil + '"');
    end;
    lstSQL.Add(' WHERE TRUE');

  //  lstSQL.Add('   AND ITENS.IME_SEQUEN BETWEEN :SEQINI AND :SEQFIN ');
    lstSQL.Add('   AND ITENS.IME_SEQCON = "'+strAutoincrem+'" ');
    lstSQL.Add('   AND ITENS.IME_CODITE IN (<FILTRO_ITENS>) ');
    If Not recParametros.Filtros.blnIncluindo Then
    Begin
      lstSQL.Add('UNION ALL');
      lstSQL.Add('SELECT CAST(CONCAT(ITE_DESITE,"<TAG_AUTCOM>", ITENS.IME_CODITE, "-", ITE_DESITE) AS CHAR(120)) AS ITEM,') ;
      lstSQL.Add('       ITENS.IME_SEQCON,');
      lstSQL.Add('       ITENS.IME_CODITE,');
      lstSQL.Add('       ITENS.IME_SEQUEN,');
      lstSQL.Add('       ITENS.IME_CODEMP,');
      lstSQL.Add('       ITE_CLAIPI,');
      lstSQL.Add('       ITE_DESITE,');
      lstSQL.Add('       IME_GERABF,');
      lstSQL.Add('       ABF_CODABF,');
      lstSQL.Add('       IME_UNIFED,');
      lstSQL.Add('       IME_SEMIME,');
      lstSQL.Add('       IME_RETPAR,');
      lstSQL.Add('       IME_SEMEAN,');
      lstSQL.Add('       ITENS.EXCLUIDO,');
      lstSQL.Add('       TIPABF.SIS_VALCFG AS TIPABF,');
      lstSQL.Add('       @EXCIPI := IFNULL(IF(TPABPC.SIS_VALCFG = "1", CADITE.ITE_EXCIPI, ITEGER.ITE_EXCIPI), "") AS EXCIPI,');
      lstSQL.Add('       IME_CODNCM <> ITE_CLAIPI AS DIF_CLAIPI,');

      lstSQL.Add('       IME_CODLUB <> ITE_CODLUB AS DIF_CODLUB,');
      lstSQL.Add('       IFNULL(IME_CODNCM, "") <> IFNULL(ITE_CLAIPI, "") AS DIF_ITE_CLAIPI,');
      lstSQL.Add('       IFNULL(ITE_CDCEST, "") <> IFNULL(IME_CDCEST, "") AS DIF_ITE_CDCEST,');
      lstSQL.Add('       IFNULL(IME_CODLUB, "") <> IFNULL(ITE_CODLUB, "") AS DIF_ITE_CODLUB,');

      lstSQL.Add('       IME_EXCIPI <> @EXCIPI AS DIF_EXCIPI,');


      For perfil in perfilConj do
      Begin
        strPefil := fConvertConfPerfilToAliasFieldString(perfil);
        strPerfRes := Copy(strPefil, 6, 3);
        lstSQL.Add('       SUBSTRING(ABF_CODSIT' + strPefil + ', 2,3) AS ABF_CODSIT' + strPefil + ',');
        lstSQL.Add('       ABF_CODBEN' + strPefil + ',');
        lstSQL.Add('       ABF_BASICM' + strPefil + ',');
        lstSQL.Add('       ABF_ALQICM' + strPefil + ',');
        lstSQL.Add('       ABF_BASRET' + strPefil + ',');
        lstSQL.Add('       ABF_ALQRET' + strPefil + ',');
        lstSQL.Add('       ABF_IVA_ST' + strPefil + ',');
        lstSQL.Add('       ABF_ALQFCP' + strPefil + ',');


        lstSQL.Add('       ABF_ALQEFO' + strPefil + ',');
        lstSQL.Add('       ABF_ALQIED' + strPefil + ',');
        lstSQL.Add('       ABF_ALQRED' + strPefil + ',');
        lstSQL.Add('       ABF_BASDDS' + strPefil + ',');


        lstSQL.Add('       SUBSTRING(IFNULL(ABF_CODSIT' + strPefil + ', ""),2,3) <> IME' + strPerfRes + '.IME_CODSIT AS DIF_CODSIT' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_BASICM' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_BASICM, "") AS DIF_BASICM' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_ALQICM' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQICM, "") AS DIF_ALQICM' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_BASRET' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_BASRET, "") AS DIF_BASRET' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_ALQRET' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQRET, "") AS DIF_ALQRET' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_IVA_ST' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_IVA_ST, "") AS DIF_IVA_ST' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_ALQFCP' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQFCP, "") AS DIF_ALQFCP' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_ALQEFO' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQEFO, "") AS DIF_ALQEFO' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_ALQIED' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQIED, "") AS DIF_ALQIED' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_ALQRED' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_ALQRED, "") AS DIF_ALQRED' + strPefil + ',');
        lstSQL.Add('       IFNULL(ABF_BASDDS' + strPefil + ', "") <> IFNULL(IME' + strPerfRes + '.IME_BASDDS, "") AS DIF_BASDDS' + strPefil + ',');
        lstSQL.Add('       ABF_CODSIT' + strPefil + ' AS ORI_ABF_CODSIT' + strPefil + ', ')
      End;

      For perfil in perfilConj do
      Begin
        strPefil := fConvertConfPerfilToAliasFieldString(perfil);
        strPerfRes := Copy(strPefil, 6, 3);
        lstSQL.Add('       IME' + strPerfRes + '.IME_AMPLEG AS ABF_IME_AMPLEG' + strPefil + ',');
        lstSQL.Add('       IME' + strPerfRes + '.IME_PTCNOM AS ABF_IME_PTCNOM' + strPefil + ',');
        lstSQL.Add('       IME' + strPerfRes + '.IME_PTCDES AS ABF_IME_PTCDES' + strPefil + ',');
        lstSQL.Add('       IME' + strPerfRes + '.IME_CONNOM AS ABF_IME_CONNOM' + strPefil + ',');
        lstSQL.Add('       IME' + strPerfRes + '.IME_CONDES AS ABF_IME_CONDES' + strPefil + ',');
      End;

      lstSQL.Add('        "Autcom" AS LOCAL');
      lstSQL.Add('  FROM IMENDES_ITENS ITENS');
      lstSQL.Add('  LEFT JOIN CADITE ON CADITE.ITE_CODITE = ITENS.IME_CODITE');
      lstSQL.Add('  LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = ITENS.IME_CODITE AND ITEGER.ITE_CODEMP =  IF(IFNULL(IME_CODEMP, "") = "", "'+{$IFNDEF LINUX}iMendes_strCodEmp{$ELSE}VS_strCodEmp{$ENDIF}+'", IME_CODEMP)');
      lstSQL.Add('  LEFT JOIN CFGSIS TIPABF ON TIPABF.SIS_CODCFG = "CFG_TIPABF" AND TIPABF.SIS_CODEMP =ITEGER.ITE_CODEMP');
      lstSQL.Add('  LEFT JOIN CFGSIS TPABPC ON TPABPC.SIS_CODCFG = "CFG_TPABPC" AND TPABPC.SIS_CODEMP =ITEGER.ITE_CODEMP');
      lstSQL.Add('  LEFT JOIN CFGSIS UTIABI ON UTIABI.SIS_CODCFG = "CFG_UTIABI" AND UTIABI.SIS_CODEMP =ITEGER.ITE_CODEMP');
      lstSQL.Add('  LEFT JOIN IMENDES_ESTADOS ON TRUE ');
      lstSQL.Add('  LEFT JOIN ABFICM ON ABFICM.ABF_CODABF = IF(TIPABF.SIS_VALCFG = "1", CADITE.ITE_CODABF, ITEGER.ITE_CODABF) AND ABFICM.ABF_ESTADO = IMENDES_ESTADOS.IME_UNIFED ');


      For perfil in perfilConj do
      Begin
        strPefil := fConvertConfPerfilToString(perfil);
        lstSQL.Add('  LEFT JOIN IMENDES_ABFICM IME' + strPefil + ' ON IME' + strPefil + '.IME_SEQCON = ITENS.IME_SEQCON AND IME' + strPefil + '.IME_CODITE = ITENS.IME_CODITE AND IME' + strPefil + '.IME_CODEMP = ITENS.IME_CODEMP  AND IME' + strPefil + '.IME_ESTADO = IMENDES_ESTADOS.IME_UNIFED AND IME' + strPefil + '.IME_PERFIL = "' + strPefil + '"');


      end;
      lstSQL.Add(' WHERE TRUE');
      lstSQL.Add('   AND ITENS.IME_SEQCON = "'+strAutoincrem+'" ');
      lstSQL.Add('   AND ITENS.IME_CODITE IN (<FILTRO_ITENS>) ');


    End;


    lstSQL.Add('  )TMP');


  {}
    incQtd:= 0;
    strCodIte := '';

    while not AQryItens.Eof Do
    Begin
      strCodIte := strCodIte + IfThen(strCodIte <> '', ',', '')+ '"' + AQryItens.FieldByName('IME_CODITE').AsString + '"';
      Inc(incQtd);
      AQryItens.Next;
      If (incQtd = 250) Or (AQryItens.Eof) Then
      Begin
        qryComand.SQL.Clear;
        qryComand.SQL.Add(lstSQL.Text);
        qryComand.SQL.Text := AnsiReplaceStr(qryComand.SQL.Text, '<FILTRO_ITENS>', strCodIte);
        qryComand.ExecSQL;

        qryComand.SQL.Clear;
        Try
          qryComand.SQL.Add('UPDATE IMENDES_ITENS I SET');
          qryComand.SQL.Add('   I.IME_DIFICM = IF((SELECT COUNT(1)');
          qryComand.SQL.Add('                        FROM IMENDES_RESULTADO R');
          qryComand.SQL.Add('                       WHERE R.IME_SEQCON = I.IME_SEQCON');
          qryComand.SQL.Add('                         AND R.IME_CODITE = I.IME_CODITE');
          qryComand.SQL.Add('                         AND R.IME_CODEMP = I.IME_CODEMP');
          qryComand.SQL.Add('                         AND DIF_ICMS = 1)> 0, 1, 0)');
          qryComand.SQL.Add(' WHERE IME_SEQCON = "'+GerenciaEstado.AutIncRegAtual+'"');
          qryComand.SQL.Add('   AND I.IME_CODITE IN (<FILTRO_ITENS>)');
          qryComand.SQL.Text := AnsiReplaceStr(qryComand.SQL.Text, '<FILTRO_ITENS>', strCodIte);
          qryComand.ExecSQL;
        Except
        End;
        strCodIte := '';
        incQtd := 0;
        {$IFDEF LINUX}
        WriteLog(Format('%s' , ['Gerando Tabela de Resultado ' + IntTostr(AQryItens.RecordCount) + '/' + IntToStr(AQryItens.RecNo -1)]));
        {$ELSE}
         Writeln(Format('%s' , ['Gerando Tabela de Resultado ' + IntTostr(AQryItens.RecordCount) + '/' + IntToStr(AQryItens.RecNo -1)]));
        {$ENDIF}
      End;

    End;




    Result := true;

    If blnParcial then
    Begin
      qryComand.SQL.Clear;
      qryComand.SQL.Add('UPDATE IMENDES_ITENS SET IME_REPROS = 0  WHERE IME_SEQCON = "'+strAutoincrem+'"');
      qryComand.SQL.Add(' AND IME_REPROS = 1');
      qryComand.ExecSQL;
    End;


  Finally
    FreeAndNil(lstSQL)
  End;

  If (recParametros.ProdutosAlterados) Or (GerenciaEstado.EstadoAtual = epRecriaTabelaResultado) Then
    pEnviaNotificacaoImendesAlterados;
End;

initialization
  intMaxThreadAtivas := fRetMaxThreadAtivas;

end.

