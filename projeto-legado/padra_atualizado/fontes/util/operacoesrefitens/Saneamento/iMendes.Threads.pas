unit iMendes.Threads;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni, UniClientDataSet, madStackTrace,
{$ENDIF}
  DateUtils, untThreadUtils,
  Classes, SysUtils, System.SyncObjs, REST.Json, REST.Types, REST.Authenticator.Basic, REST.Client,
  iMendes.Types,  System.JSON, iMendes.Constantes, System.Math, iMendes.Functions, System.IOUtils, System.StrUtils ;

Type
  TIMENDES_LOGTHREAD = class
  public
    class procedure pGravaLog(strAutInc, strLocal: String; strCodIte:String; strCodEmp: String; strCodAbf: String; strMensagem: String; qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}; VariaveisDeControle: TVariaveisDeControle; callStak: String = '');
  end;

  TIMENDES_GRAVAJSON = class
  public
    class procedure pGravaJSON(var AVariaveisDeControle: TVariaveisDeControle; qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}; AIME_SEQCON, AIME_CODITE, AIME_IDEARQ, AID_CHAVE_, AIME_JSNENV, AIME_JSNRET: String; AIME_HORENV, AIME_HORRET: TDateTime);
  end;

  TIMENDES_REGISTRA_CONTADOR_ENVIO = class
  public
    class procedure pGravaLog(SchemaName, strAutInc, strCodIte, strCompleto, strChave: String; qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}; VariaveisDeControle: TVariaveisDeControle; var idRetorno: integer);
  end;

  TThreadComunicador = class( {$IFDEF LINUX} TThread {$ELSEIF DEFINED(IMENDES_32)}TThread{$ELSE}TSafeThread{$ENDIF})
  Private
    FJsonEnvio: String;
    FRestResponse: TRESTResponse;
    FRESTReq : TRESTRequest;
    FRESTCli : TRESTClient;
    FblnJaAtualizouDadosPadrao: Boolean;
    FScript : String;
    FVariaveisDeControle: TVariaveisDeControle;
    qryEmit: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    qryItem: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    qryLog: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    {$IFNDEF LINUX}
    FConnection: TUniConnection;
    {$ENDIF}
    FCodItem: string;
    FEmpresa: String;
    blnErroAoCriar: Boolean;
    FParamnsComunicador: TParamsComunicador;
    RecLayoutEntidadeEmit: TRecLayoutEntidadeEmit;
    RecLayoutEntidadePerfil: TRecLayoutEntidadePerfil;
    RecLayoutEntidadeProduto: TRecLayoutEntidadeProduto;
    FRecParametrosApiSaneamento: TRecParametrosApiSaneamento;
    FAutincProc: string;
    FCodIteProc: string;
    FCodEmpProc: string;
    blnSemImendes : Boolean;
    blnDadosCapaAtualizado: Boolean;
    blnExiteAoMenosUmCst: Boolean;
    blnRetornoParcial: Boolean;
    FDiretorioParaSalvarJSON:String;
    FIdChave: String;
    FIdChaveEstados: String;
    UFsEnvio: TConjUnidadesFederativas;
    ConUnidadesFederativasParaProcessar: TConjUnidadesFederativas;

    Function fEnviar(AJSON: String; var ARESTRes: TRESTResponse; ARESTReq: TRESTRequest; ARESTCli: TRESTClient; Perfis: TConjPerfis): Boolean;
    Function fAtualizarRetorno(ARESTRes: TRESTResponse; Perfis: TConjPerfis; EstadosProcessados: TConjUnidadesFederativas; blnPerfilConjuntoEntrada: Boolean): Boolean;
    function  fGeraScript(recRet: TRecDadosRetorno; EstadosProcessados: TConjUnidadesFederativas; var AScript: String): Boolean;
    function fConvertIVA(AValorIVA: string; APerfil: String; ACST: STring): String;
    function fRegraZera(AEstado: String; AValor: string; APerfil: TPerfil; ACST: STring): String;

    procedure pRestExecute(dtaHorEnv: TDateTime; AJSON: String; var ARESTReq: TRESTRequest; strComplemento: string);
    procedure pGravaJsonRetorno(jsnResposta: TJSONObject; dtaHorEnv, dtaHorRet: TDateTime; AJSON: String; var ARESTReq: TRESTRequest; strComplemento: string);
    function fEnviadoComSucesso(AMensagem: String): Boolean;


    function fMontaJSONEnvio: String;
    function fGerarRecRetorno(ARESTRes: TRESTResponse; Perfis: TConjPerfis;blnPerfilConjuntoEntrada: Boolean): TRecDadosRetorno;
    procedure pSetaHeaders(ARESTReq: TRESTRequest);

    function fAbreQry: Boolean;
    procedure inicializaDadosEmitente;
    procedure pRemovePefisComMesmoFinalidade(strFinalidade: integer; var PefilParaProcessar: TConjPerfis; var PerfisUsados: TConjPerfis);
    function fRetValueFieldCFOP(Perfil: TPerfil): String;
    function fRetOrigemFinalidade(Perfil: TPerfil): integer;
    procedure pProcessa(perfisUsados: TConjPerfis; blnConjPerfilEntrada: Boolean);


    procedure pProcessaPerfilEntrada(perfilEntrada: TConjPerfis);
    procedure pProcessaPerfilSaida(perfilSaida: TConjPerfis);

    function fRetCaracTriPerfisUsados(PerfisUsados: TConjPerfis): TArrOfString;
    function fRetCaracTriPerfilUsados(Perfil: TPerfil): String;
    function fProdutoExisteNaImendesAlterado(strCodIte, strCodEmp: String): Boolean;
    procedure pProdutoAtualizaImendesAlterado(strCodIte, strCodEmp: String);
    procedure pIniciarQueries;


  public
     Constructor Create(var AVariaveisDeControle: TVariaveisDeControle;strID: string;  ACodItem, AEmpresa: String;
                        AParamnsComunicador:TParamsComunicador;
                        ARecParametrosApiSaneamento: TRecParametrosApiSaneamento;
                        strDiretorioParaSalvarJSON: String); reintroduce;
     procedure Execute; override;
     destructor Destroy; override;
  End;

implementation

uses
  iMendes.ProcessaAlterados;

{ TThreadComunicador }

constructor TThreadComunicador.Create(var AVariaveisDeControle: TVariaveisDeControle; strID: string; ACodItem,AEmpresa: String;
                                      AParamnsComunicador: TParamsComunicador; ARecParametrosApiSaneamento: TRecParametrosApiSaneamento;
                                      strDiretorioParaSalvarJSON: String);
begin
  inherited Create(True);
  Try
    Self.FreeOnTerminate := True;
    FDiretorioParaSalvarJSON := strDiretorioParaSalvarJSON;

    FAutincProc := strID;
    FCodIteProc := ACodItem;
    FCodEmpProc := AEmpresa;

    blnErroAoCriar := False;
    FRecParametrosApiSaneamento := ARecParametrosApiSaneamento;

    FCodItem  := ACodItem;
    FEmpresa  := AEmpresa;

    FVariaveisDeControle := AVariaveisDeControle;
    FParamnsComunicador := AParamnsComunicador;
    FScript := '';

    Inc(FVariaveisDeControle.intQtdThreadAtivas);
  Except
    on e: Exception do
    Begin
      TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TThreadComunicador.Create]',
        FCodIteProc, FCodEmpProc, '', e. message, qryLog, FVariaveisDeControle
        {$IFNDEF LINUX}, StackTrace{$ENDIF});
      blnErroAoCriar := True;
    End;
  End;
end;

destructor TThreadComunicador.Destroy;
begin
  FVariaveisDeControle.SessaoCritica.Enter;
  Inc(FVariaveisDeControle.intQtdRegistrosProcessados);
  FVariaveisDeControle.SessaoCritica.Leave;


  Dec(FVariaveisDeControle.intQtdThreadAtivas);
{$IFNDEF LINUX}
  If Assigned(FConnection) Then
    FreeAndNil(FConnection);
  If Assigned(qryLog) Then
    FreeAndNil(qryLog);
  If Assigned(qryEmit) Then
    FreeAndNil(qryEmit);
  If Assigned(QryItem) Then
    FreeAndNil(QryItem);
{$ENDIF}
  inherited;
end;

procedure TThreadComunicador.pIniciarQueries;
begin
 {$IFDEF LINUX}
  objConnectionsManager.BeginConnection;
  qryLog := iMendesCriaQuery;
  qryEmit := iMendesCriaQuery;
  qryItem := iMendesCriaQuery;
 {$ELSE}
  FConnection := iMendesCriaConnection;
  FConnection.Open;
  qryLog    := iMendesCriaQuery(FConnection);
  qryEmit   := iMendesCriaQuery(FConnection);
  qryItem   := iMendesCriaQuery(FConnection);
 {$ENDIF}
  inicializaDadosEmitente;
end;

procedure TThreadComunicador.Execute;
var PefilParaProcessar: TConjPerfis;
    perfilEntrada :TConjPerfis;
    perfilSaida   :TConjPerfis;
    FSCriptGer: String;
    i: integer;
begin
  If blnErroAoCriar Then
  Begin
    Self.Terminate;
    Exit;
  End;

  inherited;

  pIniciarQueries;

  Try
    FRestResponse := TRESTResponse.Create(Nil);
    FRESTReq      := TRESTRequest.Create(nil);
    FRESTCli      := TRESTClient.Create(FParamnsComunicador.strURL);
    Try


      FRESTCli.Accept := ACCEPT;
      FRESTCli.AcceptCharset := ACCEPT_CHARSET;
      FRESTCli.HandleRedirects := True;


      FRESTReq.Accept := ACCEPT;
      FRESTReq.AcceptCharset := ACCEPT_CHARSET;
      FRESTReq.Client := FRESTCli;
      FRESTReq.Response := FRestResponse;
      FRESTReq.Timeout := FParamnsComunicador.intTimeout;

      pSetaHeaders(FRESTReq);

      FblnJaAtualizouDadosPadrao := False;
      If Not fAbreQry Then
        Exit;

      RecLayoutEntidadeEmit.amb := IfThen(FVariaveisDeControle.modApi = tmaHomologacao, 1,2);
      RecLayoutEntidadeEmit.cnpj := fGetNumbers(qryEmit.FieldByName('CNPJ').AsString);
      RecLayoutEntidadeEmit.crt := qryEmit.FieldByName('CRT').AsInteger;
      RecLayoutEntidadeEmit.regimeTrib := qryEmit.FieldByName('REGIMETRIB').AsString;
      RecLayoutEntidadeEmit.uf := qryEmit.FieldByName('UF').AsString;
      RecLayoutEntidadeEmit.cnae := qryEmit.FieldByName('CNAE').AsString;
      RecLayoutEntidadeEmit.RegimeEspecial := qryEmit.FieldByName('IMERES').AsString;

      RecLayoutEntidadeEmit.substICMS := 'N';
      If qryEmit.FieldByName('CLASUB').AsString = '2' Then
        RecLayoutEntidadeEmit.substICMS := 'S';


      PefilParaProcessar := FRecParametrosApiSaneamento.Filtros.FilterPerfis;

      perfilEntrada := [cjpPEF,cjpPEJ,cjpPER,cjpPES,cjpPSI,cjpPII];
      perfilSaida   := [cjpNCO,cjpCCO,cjpCNC,cjpSNA,cjpCTA,cjpPRU,cjpIND,cjpTRS];


      qryItem.First;
      blnDadosCapaAtualizado := False;
      FSCriptGer := '';
      blnRetornoParcial := False;
      blnExiteAoMenosUmCst := False;
//      FVariaveisDeControle.SessaoCritica.Enter;
      Try
        qryLog.SQL.Clear;
        qryLog.sql.Add('UPDATE IMENDES_ITENS SET IME_HORINI = current_timestamp() ');
        qryLog.sql.Add('WHERE IME_SEQCON = "'+ qryItem.FieldByName('IME_SEQCON').ASString+'"');
        qryLog.sql.Add('AND IME_CODITE = "'+ qryItem.FieldByName('IME_CODITE').ASString+'"');
        qryLog.sql.Add('AND IME_CODEMP = "'+ qryItem.FieldByName('IME_CODEMP').ASString+'";');
        qryLog.ExecSQL;
      Finally
//        FVariaveisDeControle.SessaoCritica.Leave;
      End;

      FIdChave := GetNewID('CHAVETHREAD');
      FIdChaveEstados := '';
      while not qryItem.Eof do
      Begin
        FIdChaveEstados := qryItem.RecNo.ToString;
        If FVariaveisDeControle.blnFinalizacaoExterna Then
          Exit;
        RecLayoutEntidadeProduto.codigo     := qryItem.FieldByName('IME_CODBAR').AsString;
        RecLayoutEntidadeProduto.codInterno := 'N';
        RecLayoutEntidadeProduto.descricao  := AnsiReplaceStr(AnsiReplaceStr(qryItem.FieldByName('ITE_DESITE').AsString, '"', ''), '\', '');
        RecLayoutEntidadeProduto.ncm        := qryItem.FieldByName('IME_CODNCM').AsString;
        RecLayoutEntidadeProduto.imeItensSeqen := qryItem.FieldByName('IME_SEQUEN').AsInteger;
        RecLayoutEntidadePerfil.origem      := qryItem.FieldByName('ORICST').AsString;
        If RecLayoutEntidadePerfil.origem = '' then
          RecLayoutEntidadePerfil.origem := '0';

        RecLayoutEntidadePerfil.Uf := fSplit(qryItem.FieldByName('ESTADOS').AsString);
        UFsEnvio := [];
        For i := 0 To High(RecLayoutEntidadePerfil.Uf) do
          UFsEnvio := UFsEnvio + fRetConUF(RecLayoutEntidadePerfil.Uf[i]);  ;

        pProcessaPerfilEntrada(perfilEntrada);
        If FVariaveisDeControle.blnFinalizacaoExterna Then
          Exit;
        If blnSemImendes Then
          Break;

        pProcessaPerfilSaida(perfilSaida);
        If FVariaveisDeControle.blnFinalizacaoExterna Then
          Exit;
        If blnSemImendes Then
          Break;


        FSCriptGer := FSCriptGer + FScript;
        FScript := '';
        qryItem.Next;

      End;

      FVariaveisDeControle.blnFinalizaComoItemNaoEncontradoImendes := ((blnSemImendes) and (FRecParametrosApiSaneamento.Filtros.blnIncluindo));


      qryItem.First;
      FSCriptGer := FSCriptGer + 'UPDATE IMENDES_PARAM SET PROCESSADOS = PROCESSADOS + 1 WHERE AUTOINCREM = "'+ qryItem.FieldByName('IME_SEQCON').ASString+'";';
      FSCriptGer := FSCriptGer + 'UPDATE IMENDES_ITENS SET IME_PROCES = 1, IME_HORFIM =  current_timestamp() ';
      If blnSemImendes  Then
        FSCriptGer := FSCriptGer + '   , IME_SEMIME = 1 ';

      If blnRetornoParcial Then
        If blnExiteAoMenosUmCst Then
          FSCriptGer := FSCriptGer + '   , IME_RETPAR = 1 ';
      FSCriptGer := FSCriptGer + ' WHERE IME_SEQCON = "'+ qryItem.FieldByName('IME_SEQCON').ASString+'"';
      FSCriptGer := FSCriptGer + '   AND IME_CODITE = "'+ qryItem.FieldByName('IME_CODITE').ASString+'"';
      FSCriptGer := FSCriptGer + '   AND IME_CODABF = "'+ qryItem.FieldByName('IME_CODABF').ASString+'"';
      FSCriptGer := FSCriptGer + '   AND IME_CODEMP = "'+ qryItem.FieldByName('IME_CODEMP').ASString+'";';

      qryLog.SQL.Clear;
      qryLog.SQL.Text  := FSCriptGer;
      Try
        qryLog.ExecSQL;

        If Not blnSemImendes Then
        Begin
          If Not fProdutoExisteNaImendesAlterado(qryItem.FieldByName('IME_CODITE').ASString,
                                                   qryItem.FieldByName('IME_CODEMP').ASString) then
          Begin
            qryLog.SQL.Text := TProcessaAlterados.fRetSQLReplaceInto(qryItem.FieldByName('IME_CODITE').ASString,
                                                                     qryItem.FieldByName('IME_CODEMP').ASString,
                                                                     0,
                                                                     0);
            If qryLog.SQL.Text <> '' Then
              qryLog.ExecSQL;
          End;

          If FRecParametrosApiSaneamento.ProdutosAlterados Then
             pProdutoAtualizaImendesAlterado(qryItem.FieldByName('IME_CODITE').ASString,
                                             qryItem.FieldByName('IME_CODEMP').ASString);
        End;


      Except
        on e: Exception do
          TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TThreadExecutaScript.Execute]',FCodIteProc, FCodEmpProc, '', 'Falha ao Executar SQL:' + e. message, qryLog, FVariaveisDeControle
            {$IFNDEF LINUX}, StackTrace{$ENDIF});
      End;

    Except
      on e: Exception do
        TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[ TThreadComunicador.Execute]',FCodIteProc, FCodEmpProc, '', e. message, qryLog, FVariaveisDeControle
          {$IFNDEF LINUX}, StackTrace{$ENDIF});

    End;


  Finally
   {$IFDEF LINUX}
    objConnectionsManager.EndConnection;
   {$ENDIF}
    FreeAndNil(FRestResponse);
    FreeAndNil(FRESTReq);
    FreeAndNil(FRESTCli);
    Self.Terminate;
  End;
end;

function TThreadComunicador.fAtualizarRetorno(ARESTRes: TRESTResponse; Perfis: TConjPerfis; EstadosProcessados: TConjUnidadesFederativas; blnPerfilConjuntoEntrada: Boolean): Boolean;
var
  recRet: TRecDadosRetorno;
  ScriptUpdateCapa: String;
  ScriptLocal: String;

begin
  Result := True;
  recRet :=  fGerarRecRetorno(ARESTRes, Perfis, blnPerfilConjuntoEntrada);
  ScriptUpdateCapa := '';
  if not recRet.blnErro then
  Begin
    If Not blnDadosCapaAtualizado Then
    Begin
      blnDadosCapaAtualizado := True;
      ScriptUpdateCapa := 'UPDATE IMENDES_ITENS SET ' +
                           '  IME_CDCEST = "' + AnsiReplaceStr(recRet.strCEST ,'.', '') + '",' +
                           '  IME_CODNCM = "' + recRet.strNCM + '",' +
                           '  IME_CODLUB = "' + recRet.strANP + '",' +
                           '  IME_EXCIPI = "' + recRet.recIPI.strCEX + '"' +
                           ' WHERE IME_SEQCON = "' + FAutincProc + '"' +
                           ' AND IME_SEQUEN = "' + RecLayoutEntidadeProduto.imeItensSeqen.ToString  + '";';
    End;


    FScript := ScriptUpdateCapa + FScript;
    If fGeraScript(recRet, EstadosProcessados, ScriptLocal) Then
    Begin
      FScript := FScript +  ScriptLocal

    End;
  End;
end;

function TThreadComunicador.fConvertIVA(AValorIVA: string; APerfil,
  ACST: STring): String;
begin
  Result := AValorIVA;
  If APerfil = 'CCO' Then
   If Pos('0' + ACST, IME_CST_SUBSTITUICAO) > 0 Then
     Result := '1.00';
end;

procedure TThreadComunicador.pRestExecute(dtaHorEnv: TDateTime; AJSON: String; var ARESTReq: TRESTRequest; strComplemento: string);
var  dtaHorRet: TDateTime;
begin
    Try
       ARESTReq.Execute;
    Except
      on e: Exception do
      Begin
        dtaHorRet := fImendesNow();

        TIMENDES_GRAVAJSON.pGravaJSON(FVariaveisDeControle,
                                      qryLog,
                                      FAutincProc,
                                      FCodIteProc,
                                      strComplemento,
                                      FIdChaveEstados + FIdChave,
                                      AJSON,
                                      e.Message,
                                      dtaHorEnv,
                                      dtaHorRet);
        raise Exception.Create('[TThreadComunicador.pRestExecute] - Falha ao enviar json: ' + e.message);
      End;
    End;
End;

procedure TThreadComunicador.pGravaJsonRetorno(jsnResposta: TJSONObject; dtaHorEnv, dtaHorRet: TDateTime; AJSON: String; var ARESTReq: TRESTRequest; strComplemento: string);
begin
  Try
      TIMENDES_GRAVAJSON.pGravaJSON(FVariaveisDeControle,
                                    qryLog,
                                    FAutincProc,
                                    FCodIteProc,
                                    strComplemento,
                                    FIdChaveEstados + FIdChave,
                                    AJSON,
                                    jsnResposta.ToString,
                                    dtaHorEnv,
                                    dtaHorRet);
  Except
    on e: Exception do
      raise Exception.Create('[TThreadComunicador.pGravaJsonRetorno] - Falha ao gravar o json de retorno: ' + e.message);
  End
end;


function TThreadComunicador.fEnviadoComSucesso(AMensagem: String): Boolean;
begin
  Result := True;
  If AMensagem = cMensagemOk Then
    Exit;
  If AMensagem =  cMensagemProdutoNaoEncontrado Then
    Exit;

  Result := False;

End;

function TThreadComunicador.fEnviar(AJSON: String; var ARESTRes: TRESTResponse; ARESTReq: TRESTRequest; ARESTCli: TRESTClient; Perfis: TConjPerfis): Boolean;
var
  jsnResposta,
  jsnCabecalho: TJSONObject;
  strComplemento: String;
  dtaHorEnv: TDateTime;
  dtaHorRet: TDateTime;
  strMensagemRet: String;
  intSequencial: integer;
begin
  intSequencial := -1;
  blnSemImendes := False;
  Try
    If ARESTReq.Params.Count < 0 Then
      pSetaHeaders(ARESTReq);

    strComplemento := ' Produto : ' + FCodIteProc + ' Pefil: ' +  PerfilPrefixoToString(Perfis) + ' Enviado ';


    ARESTReq.Method := rmPOST;
    ARESTCli.BaseURL := FParamnsComunicador.strURL;
    ARESTReq.ClearBody;
    ARESTReq.AddBody(AJSON, ctAPPLICATION_JSON);

    pEscreveLog(strComplemento);
    dtaHorEnv := fImendesNow;
    If ContadorDeRequisicaoAtivado then
      TIMENDES_REGISTRA_CONTADOR_ENVIO.pGravaLog({$IFNDEF LINUX}
                                                 FConnection.DataBase
                                                 {$ELSE}
                                                 objConnectionsManager.CurrentConnection.Database{$ENDIF},
                           FAutincProc,FCodIteProc,  strComplemento, FIdChave, qryLog, FVariaveisDeControle, intSequencial);

    pRestExecute(dtaHorEnv, AJSON, ARESTReq, strComplemento);
    If ContadorDeRequisicaoAtivado then
      TIMENDES_REGISTRA_CONTADOR_ENVIO.pGravaLog({$IFNDEF LINUX}
                                                 FConnection.DataBase
                                                 {$ELSE}
                                                 objConnectionsManager.CurrentConnection.Database{$ENDIF},'','',  '', '', qryLog, FVariaveisDeControle, intSequencial);

  Except
    On E:Exception Do
    Begin
      If ContadorDeRequisicaoAtivado then
        TIMENDES_REGISTRA_CONTADOR_ENVIO.pGravaLog({$IFNDEF LINUX}
                                                 FConnection.DataBase
                                                 {$ELSE}
                                                 objConnectionsManager.CurrentConnection.Database{$ENDIF},'','',  '', '', qryLog, FVariaveisDeControle, intSequencial);
      Result := False;
      pEscreveLog(strComplemento + ' ' + e. message, True);
      TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TApiSaneamento.fEnviar]', FCodIteProc, FCodEmpProc, '', e. message, qryLog, FVariaveisDeControle
        {$IFNDEF LINUX}, StackTrace{$ENDIF});
      Exit;
    End;
  End;

  strComplemento := ' Produto : ' + FCodIteProc + ' Pefil: ' +  PerfilPrefixoToString(Perfis) + ' Recebido ';
  pEscreveLog(strComplemento);

  Try
    jsnResposta := TJSONObject.ParseJSONValue(ARESTRes.JSONText) As TJSONObject;
    dtaHorRet := fImendesNow();

    Try
      pGravaJsonRetorno(jsnResposta, dtaHorEnv, dtaHorRet, AJSON, ARESTReq, strComplemento);
      If Not Assigned(jsnResposta.GetValue('Cabecalho')) Then
      Begin

        TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TThreadComunicador.fEnviar]',FCodIteProc, FCodEmpProc, '',
                                   FormatDateTime('dd/mm/yyyy hh:mm:ss', fImendesNow()) +
                                   ' | Perfil: '+ PerfilToString(Perfis) +
                                   'Falha ao ler Tag Cabeçalho do retorno:  ( ' + jsnResposta.ToString+ ')', qryLog, FVariaveisDeControle
                                   {$IFNDEF LINUX}, StackTrace{$ENDIF});
        Exit(False);
      End;

      jsnCabecalho := TJSONObject.ParseJSONValue(jsnResposta.GetValue('Cabecalho').ToJSON) As TJSONObject;
      Try
        Try
        strMensagemRet := jsnCabecalho.GetValue('mensagem').Value
        Except
          strMensagemRet := '';
        End;
        Result := fEnviadoComSucesso(strMensagemRet);

        If strMensagemRet = cMensagemProdutoNaoEncontrado then
          blnSemImendes := True;

        If Not Result Then
          raise Exception.Create('[TThreadComunicador.fEnviar] -  Erro ao ler retorno do produto ( ' + strMensagemRet + ')');

      finally
        FreeAndNil(jsnCabecalho);
      End;
    finally
      FreeAndNil(jsnResposta);
    End;
  Except
    on e: Exception do
    Begin
      TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TThreadComunicador.fEnviar]',FCodIteProc, FCodEmpProc, '',
                                   FormatDateTime('dd/mm/yyyy hh:mm:ss', fImendesNow()) +
                                   ' | Perfil: '+ PerfilToString(Perfis) +
                                   'Erro ao ler retorno do produto ( ' + e.message + ')', qryLog, FVariaveisDeControle
                                   {$IFNDEF LINUX}, StackTrace{$ENDIF});

      Result := False;
    End;
  End;
end;

function TThreadComunicador.fGerarRecRetorno(ARESTRes: TRESTResponse; Perfis: TConjPerfis;blnPerfilConjuntoEntrada: Boolean): TRecDadosRetorno;
var
  jsnResposta: TJSONObject;
  jsnCFOP:  TJSONObject;
  jsnCaracTrib:  TJSONObject;
  jsnPISCOF:  TJSONObject;
  jsnIPI:  TJSONObject;
  jsnConvenio:  TJSONObject;
  jsnProtocolo:  TJSONObject;

  jsnArrGrupos,
  jsnArrRegras,
  jsnUFs,
  jsnArrCaracTrib: TJSONArray;

  posGrupos: integer;
  posRegras: integer;
  posUFs: integer;
  posCaracTrib: integer;
  CountCaracTrib: integer;

  fltAliqIcmsInterna : Double;
  fltfCP : Double;


begin
  Try
    Result.pfPerfil := Perfis;
    Result.blnErro := False;
    SetLength(Result.ArrRecICMS, 0);
    CountCaracTrib := 0;
    Try
      jsnResposta := TJSONObject.ParseJSONValue(ARESTRes.JSONText) As TJSONObject;
      jsnArrGrupos := jsnResposta.GetValue<TJSONArray>('Grupos');
      For posGrupos := 0 To Pred(jsnArrGrupos.Count) do
      begin
        Result.strNCM   := jsnArrGrupos.Items[posGrupos].GetValue<string>('nCM');
        Result.strCEST  := jsnArrGrupos.Items[posGrupos].GetValue<string>('cEST');
        Result.strANP   := jsnArrGrupos.Items[posGrupos].GetValue<string>('codAnp');

        jsnArrRegras := jsnArrGrupos.Items[posGrupos].GetValue<TJSONArray>('Regras');
        If jsnArrRegras.Count = 0 Then
          raise Exception.Create('Erro ao ler a chave Pis/Cofins  do arquivo de retorno');

        jsnPISCOF := jsnArrGrupos.Items[posGrupos].GetValue<TJSONObject>('pisCofins');
        If not Assigned(jsnPISCOF) Then
          raise Exception.Create('Sem regras fiscais no retorno');

        Result.recPIS.strCSTEnt := jsnPISCOF.GetValue('cstEnt').Value;
        Result.recPIS.strCSTSai := jsnPISCOF.GetValue('cstSai').Value;
        Result.recPIS.strAlq    := FormatFloat('###,##0.00', StrToFloatDef(jsnPISCOF.GetValue('aliqPis').Value, 0));

        Result.recCOF.strCSTEnt := jsnPISCOF.GetValue('cstEnt').Value;
        Result.recCOF.strCSTSai := jsnPISCOF.GetValue('cstSai').Value;
        Result.recCOF.strAlq    := FormatFloat('###,##0.00', StrToFloatDef(jsnPISCOF.GetValue('aliqCofins').Value, 0));


        jsnIPI := jsnArrGrupos.Items[posGrupos].GetValue<TJSONObject>('iPI');
        If not Assigned(jsnIPI) Then
          raise Exception.Create('Erro ao ler a chave IPI  do arquivo de retorno');

        Result.recIPI.strCSTEnt := jsnIPI.GetValue('cstEnt').Value;
        Result.recIPI.strCSTSai := jsnIPI.GetValue('cstSai').Value;
        Result.recIPI.strCENQ   := jsnIPI.GetValue('codenq').Value;
        Result.recIPI.strAlq    := FormatFloat('###,##0.00', StrToFloatDef(jsnIPI.GetValue('aliqipi').Value, 0));
        Result.recIPI.strCEX    := jsnIPI.GetValue('ex').Value;

        For posRegras := 0 To Pred(jsnArrRegras.Count) do
        Begin
          jsnUFs := jsnArrRegras.Items[posRegras].GetValue<TJSONArray>('uFs');
          For  posUFs := 0 To pred(jsnUFs.Count) do
          Begin
             jsnCFOP := jsnUFs.Items[posUFs].GetValue<TJSONObject>('CFOP');
             jsnArrCaracTrib := jsnCFOP.GetValue<TJSONArray>('CaracTrib');

             For posCaracTrib := 0 To Pred(jsnArrCaracTrib.Count) do
             Begin
               jsnCaracTrib :=  jsnArrCaracTrib.Items[posCaracTrib].GetValue<TJSONObject>;
               CountCaracTrib := CountCaracTrib + 1;
               SetLength(Result.ArrRecICMS, CountCaracTrib);
               Result.ArrRecICMS[CountCaracTrib-1].strUF := jsnUFs.Items[posUFs].GetValue<string>('uF');
               ConUnidadesFederativasParaProcessar := ConUnidadesFederativasParaProcessar - fRetConUF(Result.ArrRecICMS[CountCaracTrib-1].strUF);
               Result.ArrRecICMS[CountCaracTrib-1].Codigo := jsnCaracTrib.GetValue('codigo').Value;
               Result.ArrRecICMS[CountCaracTrib-1].CST := jsnCaracTrib.GetValue('cST').Value;
              // 1. NA ENTRADA, SE VIER 10, MUDAR PRA 60
               If Result.ArrRecICMS[CountCaracTrib-1].CST = '10' Then
                 If blnPerfilConjuntoEntrada Then
                   Result.ArrRecICMS[CountCaracTrib-1].CST := '60';

               fltAliqIcmsInterna := StrToFloatDef(jsnCaracTrib.GetValue('aliqIcmsInterna').Value,0);
               Result.ArrRecICMS[CountCaracTrib-1].reducaoBcIcms := FormatFloat('###,##0.00', 100 - StrToFloatDef(jsnCaracTrib.GetValue('reducaoBcIcms').Value, 0));
               Result.ArrRecICMS[CountCaracTrib-1].reducaoBcIcms_original := FormatFloat('###,##0.00', StrToFloatDef(jsnCaracTrib.GetValue('reducaoBcIcms').Value, 0));

               Result.ArrRecICMS[CountCaracTrib-1].reducaoBcIcmsSt := FormatFloat('###,##0.00', 100 - StrToFloatDef(jsnCaracTrib.GetValue('reducaoBcIcmsSt').Value, 0));
               Result.ArrRecICMS[CountCaracTrib-1].redBcICMsInterestadual := FormatFloat('###,##0.00', 100 - StrToFloatDef(jsnCaracTrib.GetValue('redBcICMsInterestadual').Value, 0));

               Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsSt := FormatFloat('###,##0.00', StrToFloatDef(jsnCaracTrib.GetValue('aliqIcmsSt').Value,0));
//               Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsSt := FormatFloat('###,##0.00', 0.0);

               If Result.ArrRecICMS[CountCaracTrib-1].strUF =  RecLayoutEntidadeEmit.uf  Then
               begin
                 if RecLayoutEntidadeEmit.RegimeEspecial <> '' then
                 Begin
                   If StrToFloatDef(jsnCaracTrib.GetValue('iVAAjust').Value,0) = 0 Then
                     Result.ArrRecICMS[CountCaracTrib-1].iVAAjust := '0.0000'
                   Else
                     Result.ArrRecICMS[CountCaracTrib-1].iVAAjust := FormatFloat('###,##0.0000', 1 + (StrToFloatDef(jsnCaracTrib.GetValue('iVAAjust').Value,0) / 100.00));

                 End
                 Else
                 Begin

                   If StrToFloatDef(jsnCaracTrib.GetValue('iVA').Value,0) = 0 Then
                     Result.ArrRecICMS[CountCaracTrib-1].iVAAjust := '0.0000'
                   Else
                     Result.ArrRecICMS[CountCaracTrib-1].iVAAjust := FormatFloat('###,##0.0000', 1 + (StrToFloatDef(jsnCaracTrib.GetValue('iVA').Value,0) / 100.00));
                 End;
               end
               Else
               Begin

                 If StrToFloatDef(jsnCaracTrib.GetValue('iVAAjust').Value,0) = 0 Then
                   Result.ArrRecICMS[CountCaracTrib-1].iVAAjust := '0.0000'
                 Else
                   Result.ArrRecICMS[CountCaracTrib-1].iVAAjust := FormatFloat('###,##0.0000', 1 + (StrToFloatDef(jsnCaracTrib.GetValue('iVAAjust').Value,0) / 100.00));
               End;

               fltFCP := StrToFloatDef(jsnCaracTrib.GetValue('fCP').Value,0);
               Result.ArrRecICMS[CountCaracTrib-1].codBenef := jsnCaracTrib.GetValue('codBenef').Value;
               Result.ArrRecICMS[CountCaracTrib-1].fCP := FormatFloat('#0.00', fltFCP);
               If fltFCP > 0 Then
                 fltAliqIcmsInterna := fltAliqIcmsInterna - fltFCP;
               Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterna := FormatFloat('#0.00', fltAliqIcmsInterna);
               Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterna_original := Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterna;

               Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterestadual := FormatFloat('###,##0.00', StrToFloatDef(jsnCaracTrib.GetValue('aliqIcmsInterestadual').Value,0));
               Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterestadual_original := Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterestadual;
               Result.ArrRecICMS[CountCaracTrib-1].tpCalcDifal := jsnCaracTrib.GetValue('tpCalcDifal').Value;

               Result.ArrRecICMS[CountCaracTrib-1].difalAlqIntEtadoDestino :=  Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterna;


               Result.ArrRecICMS[CountCaracTrib-1].ampLegal := jsnCaracTrib.GetValue('ampLegal').Value;

               jsnConvenio :=   jsnCaracTrib.GetValue<TJSONObject>('Convenio');
               If Assigned(jsnConvenio) Then
               Begin
                 If jsnConvenio.Count > 0 Then
                 Begin
                   Result.ArrRecICMS[CountCaracTrib-1].RecDadosConvenio.convNome :=  jsnConvenio.GetValue('convNome').Value;
                   Result.ArrRecICMS[CountCaracTrib-1].RecDadosConvenio.descricao :=  jsnConvenio.GetValue('descricao').Value;
                 End;
               End;

               jsnProtocolo :=   jsnCaracTrib.GetValue<TJSONObject>('Protocolo');
               If Assigned(jsnProtocolo) Then
               Begin
                 If jsnProtocolo.Count > 0 Then
                 Begin
                   Result.ArrRecICMS[CountCaracTrib-1].RecDadosProtocolo.protNome := jsnProtocolo.GetValue('protNome').Value;
                   Result.ArrRecICMS[CountCaracTrib-1].RecDadosProtocolo.descricao := jsnProtocolo.GetValue('descricao').Value;
                 End;
               End;

               If Result.ArrRecICMS[CountCaracTrib-1].strUF <> RecLayoutEntidadeEmit.uf Then
               Begin
                 Result.ArrRecICMS[CountCaracTrib-1].reducaoBcIcms   := Result.ArrRecICMS[CountCaracTrib-1].redBcICMsInterestadual;
                 Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterna := Result.ArrRecICMS[CountCaracTrib-1].aliqIcmsInterestadual;
               End;

               If Trim(Result.ArrRecICMS[CountCaracTrib-1].CST) <> '' Then
                  blnExiteAoMenosUmCst := True;
             End;
          End;
        End;

      End;

    Except
      On E:Exception Do
      Begin
        TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TThreadComunicador.fGerarRecRetorno]',FCodIteProc, FCodEmpProc, '',
                                          FormatDateTime('dd/mm/yyyy hh:mm:ss', fImendesNow()) +
                                          ' | Perfil: '+ PerfilToString(Perfis) +
                                          ' | Erro ao ler do arquivo de retorno: ' + e.message, qryLog, FVariaveisDeControle
                                          {$IFNDEF LINUX}, StackTrace{$ENDIF});

        Result.blnErro := False;
      End;
    End;
  Finally
    FreeAndNil(jsnResposta);
  End;
end;

function TThreadComunicador.fMontaJSONEnvio(): String;
var
  jsnJSON,
  jsnEmitente,
  jsnPerfil: TJSONObject;
  jsnArrProdutos: TJSONArray;
begin
  Try
    Result := '';
    jsnJSON := TJSONObject.Create;

    jsnEmitente := RecLayoutEntidadeEmit.fRetJson;
    jsnPerfil := RecLayoutEntidadePerfil.fRetJson;
    jsnArrProdutos := RecLayoutEntidadeProduto.fRetJson;
    If Not Assigned(jsnEmitente) Then
       Exit('');

    jsnJSON.AddPair('emit', jsnEmitente);
    jsnJSON.AddPair('perfil', jsnPerfil);
    jsnJSON.AddPair('produtos', jsnArrProdutos);

    Result := TJSON.Format(jsnJSON);


  Finally
    jsnJSON.RemovePair('emit');
    jsnJSON.RemovePair('perfil');
    jsnJSON.RemovePair('produtos');
    FreeAndNil(jsnEmitente);
    FreeAndNil(jsnPerfil);
    FreeandNil(jsnJSON);
  End;


end;

function TThreadComunicador.fProdutoExisteNaImendesAlterado(strCodIte,
  strCodEmp: String): Boolean;
begin
  qryLog.SQL.Clear;
  qryLog.SQL.Add('SELECT COUNT(1) QTD FROM IMENDES_ALTERADOS WHERE IME_CODITE = "'+strCodIte+'" AND IME_CODEMP =  "'+strCodEmp+'"');
  qryLog.Open;
  Result := qryLog.FieldByName('QTD').AsInteger > 0;
end;

procedure TThreadComunicador.pProdutoAtualizaImendesAlterado(strCodIte, strCodEmp: String);
begin
  qryLog.SQL.Clear;
  qryLog.SQL.Add('UPDATE IMENDES_ALTERADOS SET IME_ALTERA = "N" WHERE IME_CODITE = "'+strCodIte+'" AND IME_CODEMP =  "'+strCodEmp+'"');
  qryLog.ExecSQL;
end;

function TThreadComunicador.fRetValueFieldCFOP(Perfil: TPerfil): String;
begin
  case Perfil of
    cjpPEF: Result := qryItem.FieldByName('CFOP_PEF').AsString;
    cjpPEJ: Result := qryItem.FieldByName('CFOP_PEJ').AsString;
    cjpPER: Result := qryItem.FieldByName('CFOP_PER').AsString;
    cjpPES: Result := qryItem.FieldByName('CFOP_PES').AsString;
    cjpPSI: Result := qryItem.FieldByName('CFOP_PSI').AsString;
    cjpPII: Result := qryItem.FieldByName('CFOP_PII').AsString;
    cjpNCO: Result := qryItem.FieldByName('CFOP_NCO').AsString;
    cjpCCO: Result := qryItem.FieldByName('CFOP_CCO').AsString;
    cjpCNC: Result := qryItem.FieldByName('CFOP_CNC').AsString;
    cjpSNA: Result := qryItem.FieldByName('CFOP_SNA').AsString;
    cjpCTA: Result := qryItem.FieldByName('CFOP_CTA').AsString;
    cjpPRU: Result := qryItem.FieldByName('CFOP_PRU').AsString;
    cjpIND: Result := qryItem.FieldByName('CFOP_IND').AsString;
    cjpTRS: Result := qryItem.FieldByName('CFOP_TRS').AsString;
  end;
end;

function TThreadComunicador.fRetOrigemFinalidade(Perfil: TPerfil): Integer;
begin
  Result := -1;
  case Perfil of
    cjpPEF: Result := qryItem.FieldByName('FINALI_PEF').AsInteger;
    cjpPEJ: Result := qryItem.FieldByName('FINALI_PEJ').AsInteger;
    cjpPER: Result := qryItem.FieldByName('FINALI_PER').AsInteger;
    cjpPES: Result := qryItem.FieldByName('FINALI_PES').AsInteger;
    cjpPSI: Result := qryItem.FieldByName('FINALI_PSI').AsInteger;
    cjpPII: Result := qryItem.FieldByName('FINALI_PII').AsInteger;
    cjpNCO: Result := qryItem.FieldByName('FINALI_NCO').AsInteger;
    cjpCCO: Result := qryItem.FieldByName('FINALI_CCO').AsInteger;
    cjpCNC: Result := qryItem.FieldByName('FINALI_CNC').AsInteger;
    cjpSNA: Result := qryItem.FieldByName('FINALI_SNA').AsInteger;
    cjpCTA: Result := qryItem.FieldByName('FINALI_CTA').AsInteger;
    cjpPRU: Result := qryItem.FieldByName('FINALI_PRU').AsInteger;
    cjpIND: Result := qryItem.FieldByName('FINALI_IND').AsInteger;
    cjpTRS: Result := qryItem.FieldByName('FINALI_TRS').AsInteger;
  end;
end;

procedure TThreadComunicador.pProcessa(perfisUsados: TConjPerfis; blnConjPerfilEntrada: Boolean);
  var
    blnConcluiProcesso : Boolean;
begin
  If perfisUsados <> [] Then
  begin
    If FJsonEnvio <> '' Then
    begin
      ConUnidadesFederativasParaProcessar := UFsEnvio;

      blnConcluiProcesso := False;
      while not blnConcluiProcesso do
      Begin
        If FVariaveisDeControle.blnFinalizacaoExterna Then
          Exit;


         blnConcluiProcesso := fEnviar(FJsonEnvio, FRestResponse, FRESTReq, FRESTCli, perfisUsados);
         If blnConcluiProcesso Then
           If Not fAtualizarRetorno(FRestResponse, perfisUsados, RecLayoutEntidadePerfil.ConjUF, blnConjPerfilEntrada) Then
           Begin
             blnConcluiProcesso := False;
             ConUnidadesFederativasParaProcessar := UFsEnvio;
           End;
      End;
      IF ConUnidadesFederativasParaProcessar <> [] Then
        blnRetornoParcial := True;

    End;
  End;
End;

procedure TThreadComunicador.pProcessaPerfilEntrada(perfilEntrada: TConjPerfis);
var PefilRestante: TConjPerfis;
   Perfil: TPerfil;
   perfisUsados: TConjPerfis;

Begin

  If Not (perfilEntrada = []) Then
  Begin
    PefilRestante :=  perfilEntrada;

    If cjpPES in PefilRestante Then
    Begin
      PefilRestante := PefilRestante - [cjpPES];
      RecLayoutEntidadePerfil.simplesN := 'S';
      RecLayoutEntidadePerfil.cfop := fRetValueFieldCFOP(cjpPES);
      RecLayoutEntidadePerfil.caracTrib := fRetCaracTriPerfisUsados([cjpPES]);
      RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(cjpPES);
      FJsonEnvio := fMontaJSONEnvio;
      perfisUsados := [cjpPES];
      perfilEntrada := perfilEntrada - perfisUsados;
      pProcessa(perfisUsados, True);
      If FVariaveisDeControle.blnFinalizacaoExterna Then
        Exit;

      If blnSemImendes Then
        Exit;
    End;

    If cjpPSI in PefilRestante Then
    Begin
      PefilRestante := PefilRestante - [cjpPSI];
      RecLayoutEntidadePerfil.simplesN := 'S';
      RecLayoutEntidadePerfil.cfop := fRetValueFieldCFOP(cjpPSI);
      RecLayoutEntidadePerfil.caracTrib := fRetCaracTriPerfisUsados([cjpPSI]);
      RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(cjpPSI);
      FJsonEnvio := fMontaJSONEnvio;
      perfisUsados := [cjpPSI];
      perfilEntrada := perfilEntrada - perfisUsados;

      pProcessa(perfisUsados, True);
      If FVariaveisDeControle.blnFinalizacaoExterna Then
        Exit;

      If blnSemImendes Then
        Exit;
    End;

    for Perfil in perfilEntrada do
    begin
      RecLayoutEntidadePerfil.simplesN := qryEmit.FieldByName('SIMPAU').AsString;
      perfisUsados := [];
      If Perfil in PefilRestante then
      Begin
        RecLayoutEntidadePerfil.cfop := fRetValueFieldCFOP(Perfil);
        RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(Perfil);
        pRemovePefisComMesmoFinalidade(RecLayoutEntidadePerfil.finalidade, PefilRestante, perfisUsados);
        RecLayoutEntidadePerfil.caracTrib := fRetCaracTriPerfisUsados(perfisUsados);
        FJsonEnvio := fMontaJSONEnvio;

        pProcessa(perfisUsados, True);
        If FVariaveisDeControle.blnFinalizacaoExterna Then
          Exit;

        If blnSemImendes Then
          Exit;

        If PefilRestante = [] Then
          break;

      End;
    end;
  End;
End;

procedure TThreadComunicador.pProcessaPerfilSaida(perfilSaida: TConjPerfis);
var PefilRestante: TConjPerfis;
   Perfil: TPerfil;
   perfisUsados: TConjPerfis;
begin
  If Not (perfilSaida = []) Then
  Begin
    PefilRestante :=  perfilSaida;
//    RecLayoutEntidadePerfil.origem := '0';

    If cjpSNA in PefilRestante Then
    Begin
      PefilRestante := PefilRestante - [cjpSNA];
      RecLayoutEntidadePerfil.simplesN := 'S';
      RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(cjpSNA);
      RecLayoutEntidadePerfil.cfop := fRetValueFieldCFOP(cjpSNA);
      RecLayoutEntidadePerfil.caracTrib := fRetCaracTriPerfisUsados([cjpSNA]);
      FJsonEnvio := fMontaJSONEnvio;
      perfisUsados := [cjpSNA];
      perfilSaida := perfilSaida - perfisUsados;

      pProcessa(perfisUsados, False);
      If FVariaveisDeControle.blnFinalizacaoExterna Then
        Exit;


      If blnSemImendes Then
        Exit;
    End;

    If cjpNCO in PefilRestante Then
    Begin
      PefilRestante := PefilRestante - [cjpNCO];
      RecLayoutEntidadePerfil.finalidade := 2;
      RecLayoutEntidadePerfil.simplesN := 'S';
      RecLayoutEntidadePerfil.cfop := fRetValueFieldCFOP(cjpNCO);
      RecLayoutEntidadePerfil.caracTrib := fRetCaracTriPerfisUsados([cjpNCO]);
      RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(cjpNCO);
      FJsonEnvio := fMontaJSONEnvio;
      perfisUsados := [cjpNCO];
      perfilSaida := perfilSaida - perfisUsados;

      pProcessa(perfisUsados, False);
      If FVariaveisDeControle.blnFinalizacaoExterna Then
        Exit;

      If blnSemImendes Then
        Exit;

    End;


    If cjpIND in PefilRestante Then
    Begin
      PefilRestante := PefilRestante - [cjpIND];
      RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(cjpIND);
      RecLayoutEntidadePerfil.simplesN := 'N';
      RecLayoutEntidadePerfil.cfop := fRetValueFieldCFOP(cjpIND);
      RecLayoutEntidadePerfil.caracTrib := fRetCaracTriPerfisUsados([cjpIND]);
      RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(cjpIND);
      RecLayoutEntidadePerfil.substICMS := 'S';
      FJsonEnvio := fMontaJSONEnvio;
      perfisUsados := [cjpIND];
      perfilSaida := perfilSaida - perfisUsados;

      pProcessa(perfisUsados, False);
      If FVariaveisDeControle.blnFinalizacaoExterna Then
        Exit;

      If blnSemImendes Then
        Exit;

    End;


    for Perfil in perfilSaida do
    begin

      If Perfil in PefilRestante then
      Begin
        perfisUsados := [];
        RecLayoutEntidadePerfil.simplesN := 'N';
        RecLayoutEntidadePerfil.substICMS := '';
        RecLayoutEntidadePerfil.cfop := fRetValueFieldCFOP(Perfil);
        RecLayoutEntidadePerfil.finalidade := fRetOrigemFinalidade(Perfil);
        pRemovePefisComMesmoFinalidade(RecLayoutEntidadePerfil.finalidade, PefilRestante, perfisUsados);
        RecLayoutEntidadePerfil.caracTrib := fRetCaracTriPerfisUsados(perfisUsados);
        FJsonEnvio := fMontaJSONEnvio;

        pProcessa(perfisUsados, False);
        If FVariaveisDeControle.blnFinalizacaoExterna Then
          Exit;


        If PefilRestante = [] Then
          break;
        If blnSemImendes Then
          Exit;
      End;
    end;
  End;
End;



function TThreadComunicador.fRetCaracTriPerfilUsados(Perfil: TPerfil): String;
Begin
  case Perfil of
    cjpPEF: Result := qryItem.FieldByName('PRFSAN_PEF').AsString;
    cjpPEJ: Result := qryItem.FieldByName('PRFSAN_PEJ').AsString;
    cjpPER: Result := qryItem.FieldByName('PRFSAN_PER').AsString;
    cjpPES: Result := qryItem.FieldByName('PRFSAN_PES').AsString;
    cjpPSI: Result := qryItem.FieldByName('PRFSAN_PSI').AsString;
    cjpPII: Result := qryItem.FieldByName('PRFSAN_PII').AsString;
    cjpNCO: Result := qryItem.FieldByName('PRFSAN_NCO').AsString;
    cjpCCO: Result := qryItem.FieldByName('PRFSAN_CCO').AsString;
    cjpCNC: Result := qryItem.FieldByName('PRFSAN_CNC').AsString;
    cjpSNA: Result := qryItem.FieldByName('PRFSAN_SNA').AsString;
    cjpCTA: Result := qryItem.FieldByName('PRFSAN_CTA').AsString;
    cjpPRU: Result := qryItem.FieldByName('PRFSAN_PRU').AsString;
    cjpIND: Result := qryItem.FieldByName('PRFSAN_IND').AsString;
    cjpTRS: Result := qryItem.FieldByName('PRFSAN_TRS').AsString;
  End;
End;

function TThreadComunicador.fRetCaracTriPerfisUsados(PerfisUsados: TConjPerfis): TArrOfString;
var i: TPerfil;
    intPos: integer;
    strCaracTrib: String;
    blnEncontrou: Boolean;
begin
  blnEncontrou := False;
  SetLength(Result, 0);
  For i in PerfisUsados do
  begin
    case i of
      cjpPEF: strCaracTrib := qryItem.FieldByName('PRFSAN_PEF').AsString;
      cjpPEJ: strCaracTrib := qryItem.FieldByName('PRFSAN_PEJ').AsString;
      cjpPER: strCaracTrib := qryItem.FieldByName('PRFSAN_PER').AsString;
      cjpPES: strCaracTrib := qryItem.FieldByName('PRFSAN_PES').AsString;
      cjpPSI: strCaracTrib := qryItem.FieldByName('PRFSAN_PSI').AsString;
      cjpPII: strCaracTrib := qryItem.FieldByName('PRFSAN_PII').AsString;
      cjpNCO: strCaracTrib := qryItem.FieldByName('PRFSAN_NCO').AsString;
      cjpCCO: strCaracTrib := qryItem.FieldByName('PRFSAN_CCO').AsString;
      cjpCNC: strCaracTrib := qryItem.FieldByName('PRFSAN_CNC').AsString;
      cjpSNA: strCaracTrib := qryItem.FieldByName('PRFSAN_SNA').AsString;
      cjpCTA: strCaracTrib := qryItem.FieldByName('PRFSAN_CTA').AsString;
      cjpPRU: strCaracTrib := qryItem.FieldByName('PRFSAN_PRU').AsString;
      cjpIND: strCaracTrib := qryItem.FieldByName('PRFSAN_IND').AsString;
      cjpTRS: strCaracTrib := qryItem.FieldByName('PRFSAN_TRS').AsString;
    end;
    For intPos := 0 To High(Result) do
    Begin
      blnEncontrou := False;
      If Result[intPos] =  strCaracTrib Then
      Begin
        blnEncontrou := True;
        Break
      End;
    End;

    If Not blnEncontrou Then
    Begin
      SetLength(Result, Length(Result) + 1);
      Result[Length(Result)-1] := strCaracTrib;
    End;
  end;
end;

procedure TThreadComunicador.inicializaDadosEmitente;
begin
  Try
    qryEmit.SQL.Clear;
    qryEmit.SQL.Add('SELECT');
    qryEmit.SQL.Add('  EMP_CODEMP,');
    qryEmit.SQL.Add('  CLASUB.SIS_VALCFG AS CLASUB,');
    qryEmit.SQL.Add('  SIMPAU.SIS_VALCFG AS SIMPAU,');
    qryEmit.SQL.Add('  IMERES.SIS_VALCFG AS IMERES,');
    qryEmit.SQL.Add('  EMP_C_G_C_ AS CNPJ,');
    qryEmit.SQL.Add('  CID_ESTADO AS UF,');
    qryEmit.SQL.Add('  EMP_CNAEFI AS CNAE,');
    qryEmit.SQL.Add('  IF(EMP_REGTRI = "S", "1", "3") AS CRT,');
    qryEmit.SQL.Add('  IF(EMP_REGTRI = "P","LP","LR") AS REGIMETRIB');
    qryEmit.SQL.Add('FROM');
    qryEmit.SQL.Add('  CADEMP');
    qryEmit.SQL.Add('  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID');
    qryEmit.SQL.Add('  INNER JOIN CFGSIS CLASUB ON CLASUB.SIS_CODCFG = "CFG_CLASUB"  AND CLASUB.SIS_CODEMP = EMP_CODEMP');
    qryEmit.SQL.Add('  INNER JOIN CFGSIS SIMPAU ON SIMPAU.SIS_CODCFG = "CFG_SIMPAU"  AND SIMPAU.SIS_CODEMP = EMP_CODEMP');
    qryEmit.SQL.Add('  LEFT  JOIN CFGSIS IMERES ON IMERES.SIS_CODCFG = "CFG_IMERES"  AND IMERES.SIS_CODEMP = EMP_CODEMP');
    If FEmpresa = '' Then
      qryEmit.SQL.Add('WHERE EMP_CODEMP = "' + {$IFDEF LINUX}VS_strCodEmp{$ELSE}iMendes_strCodEmp{$ENDIF}+  '"')
    Else
      qryEmit.SQL.Add('WHERE EMP_CODEMP = "' + FEmpresa + '"');
    qryEmit.Open;
  Except
    on e:Exception do
    Begin
      TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TThreadComunicador.inicializaDadosEmitente]',FCodIteProc, FCodEmpProc, '',  e.Message, qryLog, FVariaveisDeControle
        {$IFNDEF LINUX}, StackTrace{$ENDIF});
    End;
  End;
end;


function TThreadComunicador.fAbreQry: Boolean;
begin
  Result := True;
  qryItem.SQL.Clear;
  qryItem.SQL.Add('SET @CST_SUBSTITUICAO :=  "'+IME_CST_SUBSTITUICAO+'";');
  qryItem.SQL.Add('SET @PRFSAN_PEF := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "PEF"), "");');
  qryItem.SQL.Add('SET @PRFSAN_PEJ := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "PEJ"), "");');
  qryItem.SQL.Add('SET @PRFSAN_PER := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "PER"), "");');
  qryItem.SQL.Add('SET @PRFSAN_NCO := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "NCO"), "");');
  qryItem.SQL.Add('SET @PRFSAN_CCO := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "CCO"), "");');
  qryItem.SQL.Add('SET @PRFSAN_CNC := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "CNC"), "");');
  qryItem.SQL.Add('SET @PRFSAN_CTA := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "CTA"), "");');
  qryItem.SQL.Add('SET @PRFSAN_PRU := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "PRU"), "");');
  qryItem.SQL.Add('SET @PRFSAN_SNA := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "SNA"), "");');
  qryItem.SQL.Add('SET @PRFSAN_IND := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "IND"), "");');
  qryItem.SQL.Add('SET @PRFSAN_TRS := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "TRS"), "");');
  qryItem.SQL.Add('SET @PRFSAN_PES := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "PES"), "");');
  qryItem.SQL.Add('SET @PRFSAN_PSI := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "PSI"), "");');
  qryItem.SQL.Add('SET @PRFSAN_PII := IFNULL((SELECT PRF_CODIGO FROM PRFSAN WHERE  PRF_PERFIL = "PII"), "");');


  qryItem.SQL.Add('SET @FINALI_PEF := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "PEF"), "");');
  qryItem.SQL.Add('SET @FINALI_PEJ := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "PEJ"), "");');
  qryItem.SQL.Add('SET @FINALI_PER := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "PER"), "");');
  qryItem.SQL.Add('SET @FINALI_NCO := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "NCO"), "");');
  qryItem.SQL.Add('SET @FINALI_CCO := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "CCO"), "");');
  qryItem.SQL.Add('SET @FINALI_CNC := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "CNC"), "");');
  qryItem.SQL.Add('SET @FINALI_CTA := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "CTA"), "");');
  qryItem.SQL.Add('SET @FINALI_PRU := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "PRU"), "");');
  qryItem.SQL.Add('SET @FINALI_SNA := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "SNA"), "");');
  qryItem.SQL.Add('SET @FINALI_IND := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "IND"), "");');
  qryItem.SQL.Add('SET @FINALI_TRS := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "TRS"), "");');
  qryItem.SQL.Add('SET @FINALI_PES := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "PES"), "");');
  qryItem.SQL.Add('SET @FINALI_PSI := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "PSI"), "");');
  qryItem.SQL.Add('SET @FINALI_PII := IFNULL((SELECT PRF_FINALI FROM PRFSAN WHERE  PRF_PERFIL = "PII"), "");');


  qryItem.SQL.Add('SELECT GROUP_CONCAT(IME_UNIFED) AS ESTADOS, TMP.* ');
  qryItem.SQL.Add('  FROM (SELECT IMENDES_ITENS.IME_SEQCON,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_CODITE,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_SEQUEN,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_CODABF,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_CODEMP,');
  qryItem.SQL.Add('               CADITE.ITE_DESITE,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_CODBAR,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_CDCEST,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_CODNCM,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_IPISAI,');
  qryItem.SQL.Add('               IMENDES_ITENS.IME_CODLUB,');

  qryItem.SQL.Add('               @FINALI_PEF  AS FINALI_PEF,');
  qryItem.SQL.Add('               @FINALI_PEJ  AS FINALI_PEJ,');
  qryItem.SQL.Add('               @FINALI_PER  AS FINALI_PER,');
  qryItem.SQL.Add('               @FINALI_NCO  AS FINALI_NCO,');
  qryItem.SQL.Add('               @FINALI_CCO  AS FINALI_CCO,');
  qryItem.SQL.Add('               @FINALI_CNC  AS FINALI_CNC,');
  qryItem.SQL.Add('               @FINALI_CTA  AS FINALI_CTA,');
  qryItem.SQL.Add('               @FINALI_PRU  AS FINALI_PRU,');
  qryItem.SQL.Add('               @FINALI_SNA  AS FINALI_SNA,');
  qryItem.SQL.Add('               @FINALI_IND  AS FINALI_IND,');
  qryItem.SQL.Add('               @FINALI_TRS  AS FINALI_TRS,');
  qryItem.SQL.Add('               @FINALI_PES  AS FINALI_PES,');
  qryItem.SQL.Add('               @FINALI_PSI  AS FINALI_PSI,');
  qryItem.SQL.Add('               @FINALI_PII  AS FINALI_PII,');
  qryItem.SQL.Add('               ABF_CODABF,');
  qryItem.SQL.Add('               IME_UNIFED,');
  qryItem.SQL.Add('               @cfop_entrada :=  IF(IME_UNIFED = CID_ESTADO , "1", "1") AS CFOP_ORI,');
  qryItem.SQL.Add('               @cfop_saida   :=  IF(IME_UNIFED = CID_ESTADO , "5", "5") AS CFOP_DES,');
  If FRecParametrosApiSaneamento.Filtros.strCstOrigem <> '' Then
    qryItem.SQL.Add('               '+FRecParametrosApiSaneamento.Filtros.strCstOrigem +' AS ORICST,')
  Else
    qryItem.SQL.Add('             CADITE.ITE_CSTORI AS ORICST,');


  qryItem.SQL.Add('               CONCAT(@cfop_entrada, "102") CFOP_PEF,');
  qryItem.SQL.Add('               @PRFSAN_PEF AS PRFSAN_PEF,');
  qryItem.SQL.Add('               CONCAT(@cfop_entrada,  "102") CFOP_PEJ,');
  qryItem.SQL.Add('               @PRFSAN_PEJ AS PRFSAN_PEJ,');
  qryItem.SQL.Add('               CONCAT(@cfop_entrada, "102") CFOP_PER,');
  qryItem.SQL.Add('               @PRFSAN_PER AS PRFSAN_PER,');
  qryItem.SQL.Add('               CONCAT(@cfop_entrada, "102") CFOP_PES,');
  qryItem.SQL.Add('               @PRFSAN_PES AS PRFSAN_PES,');
  qryItem.SQL.Add('               CONCAT(@cfop_entrada, "102") CFOP_PSI,');
  qryItem.SQL.Add('               @PRFSAN_PSI AS PRFSAN_PSI,');
  qryItem.SQL.Add('               CONCAT(@cfop_entrada, "102") CFOP_PII,');
  qryItem.SQL.Add('               @PRFSAN_PII AS PRFSAN_PII,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida,  "102") CFOP_NCO,');
  qryItem.SQL.Add('               @PRFSAN_NCO AS PRFSAN_NCO,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida, "102") CFOP_CCO,');
  qryItem.SQL.Add('               @PRFSAN_CCO AS PRFSAN_CCO,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida,  "102") CFOP_CNC,');
  qryItem.SQL.Add('               @PRFSAN_CNC AS PRFSAN_CNC,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida, "102") CFOP_CTA,');
  qryItem.SQL.Add('               @PRFSAN_CTA AS PRFSAN_CTA,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida, "102") CFOP_PRU,');
  qryItem.SQL.Add('               @PRFSAN_PRU AS PRFSAN_PRU,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida, "102") CFOP_SNA,');
  qryItem.SQL.Add('               @PRFSAN_SNA AS PRFSAN_SNA,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida, "102") CFOP_IND,');
  qryItem.SQL.Add('               @PRFSAN_IND AS PRFSAN_IND,');
  qryItem.SQL.Add('               CONCAT(@cfop_saida, "102") CFOP_TRS,');
  qryItem.SQL.Add('               @PRFSAN_TRS AS PRFSAN_TRS');

  qryItem.SQL.Add('         FROM  IMENDES_ITENS');
  qryItem.SQL.Add('         LEFT JOIN IMENDES_ESTADOS ON TRUE ');
  qryItem.SQL.Add('         LEFT JOIN CADITE ON CADITE.ITE_CODITE = IME_CODITE');
  qryItem.SQL.Add('         LEFT JOIN CADEMP ON EMP_CODEMP = "' + qryEmit.FieldByName('EMP_CODEMP').AsString + '"');
  qryItem.SQL.Add('         LEFT JOIN ITEGER G ON G.ITE_CODITE = IME_CODITE AND G.ITE_CODEMP = EMP_CODEMP');
  qryItem.SQL.Add('         LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID');
  qryItem.SQL.Add('         LEFT JOIN CFGSIS DARROR ON DARROR.SIS_CODCFG = "CFG_DARROR" AND DARROR.SIS_CODEMP = EMP_CODEMP');
  qryItem.SQL.Add('         LEFT JOIN CFGSIS TIPABF ON TIPABF.SIS_CODCFG = "CFG_TIPABF" AND TIPABF.SIS_CODEMP = EMP_CODEMP');
  qryItem.SQL.Add('        LEFT JOIN ABFICM ON ABF_CODABF = IF(TIPABF.SIS_VALCFG = "1", CADITE.ITE_CODABF, G.ITE_CODABF)  AND ABF_ESTADO = IMENDES_ESTADOS.IME_UNIFED');

  qryItem.SQL.Add('        WHERE TRUE ');
  qryItem.SQL.Add('          AND IME_PROCES = 0 ');
  qryItem.SQL.Add('          AND IME_SEQCON = "'+FAutincProc+'" ');
  If FEmpresa <> '' Then
    qryItem.SQL.Add('                 AND IME_CODEMP = "' + FEmpresa + '"');
  qryItem.SQL.Add('                 AND IME_CODITE = "' + FCodItem + '") TMP');

//  qryItem.SQL.Add(' GROUP BY ABF_CODABF, IME_CODITE, CFOP_PEF, CFOP_PEJ, CFOP_PER, CFOP_PES, CFOP_PSI, CFOP_PII, CFOP_NCO, CFOP_CCO, CFOP_CNC, CFOP_CTA,  CFOP_PRU, CFOP_SNA, CFOP_IND, CFOP_TRS ');
  Try
    qryItem.Open;
  Except
    on e: Exception do
    Begin
      Result := False;
      TIMENDES_LOGTHREAD.pGravaLog(FAutincProc, '[TThreadComunicador.pAbreQry]',FCodIteProc, FCodEmpProc, '', e. message, qryLog, FVariaveisDeControle
        {$IFNDEF LINUX}, StackTrace{$ENDIF});
    End;
  End;
end;


function TThreadComunicador.fRegraZera(AEstado: String; AValor: string; APerfil: TPerfil; ACST: STring): String;
begin
{}
  Result := AValor;
  If AEstado <> RecLayoutEntidadeEmit.uf Then
    Exit;
  If  ACST <> '60' Then
    Exit;

  If fPerfilSaida(APerfil) Then
      Result := '0.00'
  Else If APerfil in [cjpPEF, cjpPER, cjpPES] Then
      Result := '0.00'


(*ICMS
SAIDA  : ZERAR ABF_BASICM,
               ABF_ALQICM
               TODOS OS PERFIS DE SAIDA
ENTRADA: ZERAR
         ABF_BASICM,
         ABF_ALQICM SOMENTE DE PEF, PER, PES

ST
SAIDA  : ZERAR ABF_BASRET,
               ABF_ALQRET,
               ABF_IVA_ST
ENTRADA: ZERAR ABF_BASRET,
               ABF_ALQRET,
               ABF_IVA_ST

               SOMENTE DE PEF, PER, PES
*)

End;

function TThreadComunicador.fGeraSCript(recRet: TRecDadosRetorno; EstadosProcessados: TConjUnidadesFederativas;var  AScript: String): Boolean;
var perfilPersistido: TConjPerfis;
    perfil: TPerfil;
    strperfil: String;
    StrCaracTrib: String;
    Estado: TUnidadesFederativas;
    strEstado: String;
    RecDadosICMS: TRecDadosICMS;
    fltBASDDS: Double;
begin
  perfilPersistido := recRet.pfPerfil;
  Result := True;
  AScript := '';
  For perfil in recRet.pfPerfil do
  Begin
    If perfilPersistido = [] then
      Exit(True);
    for Estado in EstadosProcessados do
    Begin
      StrCaracTrib := fRetCaracTriPerfilUsados(perfil);
      strEstado := fRetStringUF(Estado);

      RecDadosICMS := fLocalizaRecDadosICMS(strEstado, StrCaracTrib, recRet.ArrRecICMS);
      If RecDadosICMS.blnEncontrou Then
      Begin
        strperfil := fConvertConfPerfilToString(perfil);
        AScript := AScript + '(';
        AScript := AScript + '"' + qryItem.FieldByName('IME_SEQCON').AsString+ '",';           //   IME_SEQCON
        AScript := AScript + '"' + RecDadosICMS.codBenef+ '",';                                //   IME_CODBEN
        AScript := AScript + '"' + qryItem.FieldByName('IME_SEQUEN').AsString+ '",';           //   IME_SEQCON
        AScript := AScript + '"' + qryItem.FieldByName('IME_CODITE').AsString+ '",';           //   IME_CODITE
        AScript := AScript + '"' + qryItem.FieldByName('IME_CODEMP').AsString+ '",';           //   IME_CODEMP
        AScript := AScript + '"' + qryItem.FieldByName('IME_CODABF').AsString+ '",';           //   IME_CODABF
        AScript := AScript + '"' + strEstado + '",';                                           //   IME_ESTADO
        AScript := AScript + '"' + fConvertConfPerfilToString(perfil) + '",';                  //   IME_PERFIL
        AScript := AScript + '"' + RecDadosICMS.cST + '",';                                    //   IME_CODSIT
        AScript := AScript + '"' + fRemoveVirgula(fRegraZera(strEstado, RecDadosICMS.reducaoBcIcms, perfil,RecDadosICMS.cST))  + '",';          //   IME_BASICM
        AScript := AScript + '"' + fRemoveVirgula(fRegraZera(strEstado, RecDadosICMS.aliqIcmsInterna, perfil,RecDadosICMS.cST)) + '",';        //   IME_ALQICM
        AScript := AScript + '"' + fRemoveVirgula(fRegraZera(strEstado, RecDadosICMS.reducaoBcIcmsSt, perfil,RecDadosICMS.cST)) + '",';        //   IME_BASRET  --reducaoBcIcmsSt
        AScript := AScript + '"' + fRemoveVirgula(fRegraZera(strEstado, RecDadosICMS.aliqIcmsSt, perfil, RecDadosICMS.cST)) + '",';             //   IME_ALQRET  --aliqIcmsSt
        AScript := AScript + '"0",';                                                           //   IME_ALQRED  --redBcICMsInterestadual

        AScript := AScript + '"' + fRemoveVirgula(fRegraZera(strEstado, fConvertIVA(RecDadosICMS.iVAAjust, strperfil, RecDadosICMS.cST), perfil, RecDadosICMS.cST)) + '",'; //   IME_IVA_ST
        AScript := AScript + '"' + fRemoveVirgula(RecDadosICMS.fCP) + '",';                    //   IME_ALQFCP
        {NCO e CTA
        preserva o valor original
        (1 – @aliqIcmsInterna)0 - Sem Difal --> 0,00
        SELECT 100.00 * IF(@reducaoBcIcms > 0, @reducaoBcIcms, 1)

        2 - Cálculo Base Dupla  ((((Vlr. Operação / (1 – “%aliqIcmsInterna”))) X (1 - “%reducaoBcIcms”)) X %aliqIcmsInterna) - (Vlr. Operação X "%aliqIcmsInterestadual")
        SELECT 100 / (1-(@aliqIcmsInterna/100)) * IF(@reducaoBcIcms > 0, @reducaoBcIcms, 1);



        -- 3 - Cálculo do DIFAL com aplicação da redução do ICMS Próprio (((Vlr.Operacao - ICMS próprio) – (1 – “%reducaoBcIcms”) / (1 – “aliqIcmsInterna”)))
        SELECT 100  * (1-(@aliqIcmsInterestadual/100)) / (1-(@aliqIcmsInterna/100)) * IF(@reducaoBcIcms > 0, @reducaoBcIcms, 1);



        # 4 - ICMS DIFAL base dupla UF Sergipe: ((Vlr. Operação - “%reducaoBcIcms”) / (1 - (“aliqIcmsInterna” - “aliqIcmsInterestadual”))) x (“aliqIcmsInterna” - “aliqIcmsInterestadual”)
        SELECT 100  * (1 - (@aliqIcmsInterna/100)) - (1- (@aliqIcmsInterestadual/100)) * ((@aliqIcmsInterna/100) - (@aliqIcmsInterestadual/100)) *  IF(@reducaoBcIcms > 0, @reducaoBcIcms, 1);
        }

        fltBASDDS := 0;
        if RecDadosICMS.tpCalcDifal <> '0' then
        Begin
          if perfil in [cjpCTA, cjpNCO] then
          Begin
            case RecDadosICMS.tpCalcDifal.ToInteger of
              1: fltBasDDS := IfThenImendes(RecDadosICMS.reducaoBcIcms_original.ToDouble > 0, 100 - RecDadosICMS.reducaoBcIcms_original.ToDouble, 100);
              2: fltBasDDS := 100 / (1-(RecDadosICMS.aliqIcmsInterna_original.ToDouble/100)) *
                             IfThenImendes(RecDadosICMS.reducaoBcIcms_original.ToDouble > 0, RecDadosICMS.reducaoBcIcms_original.ToDouble, 1);
              3: fltBasDDS := 100  * (1-(RecDadosICMS.aliqIcmsInterestadual_original.ToDouble/100)) / (1-(RecDadosICMS.aliqIcmsInterna_original.ToDouble/100)) *
                              IfThenImendes(RecDadosICMS.reducaoBcIcms_original.ToDouble > 0, RecDadosICMS.reducaoBcIcms_original.ToDouble, 1);
              4: fltBasDDS := 100  * (1 - (RecDadosICMS.aliqIcmsInterna_original.ToDouble/100)) - (1- (RecDadosICMS.aliqIcmsInterestadual_original.ToDouble/100)) *
                             ((RecDadosICMS.aliqIcmsInterna_original.ToDouble/100) - (RecDadosICMS.aliqIcmsInterestadual_original.ToDouble/100)) *
                             IfThenImendes(RecDadosICMS.reducaoBcIcms_original.ToDouble > 0, RecDadosICMS.reducaoBcIcms_original.ToDouble, 1);
              else
                fltBASDDS := 0;

            end;
          End
          Else
            fltBASDDS := RecDadosICMS.reducaoBcIcms.ToDouble();

        End;
        fltBASDDS := RoundTo(fltBASDDS, -2);


        AScript := AScript + '"' + fRemoveVirgula(RecDadosICMS.difalAlqIntEtadoDestino) + '",';       //   IME_ALQIED  ALIQUOTA INTERNA ESTADO DESTINO
        If RecDadosICMS.tpCalcDifal <> '0' then
        Begin
          AScript := AScript + '"0.00",';  //   IME_ALQEFO  ALIQUOTA EFETIVA DE ORIGEM
          AScript := AScript + '' + fRemoveVirgula(fltBASDDS.ToString) + ',';          //   IME_BASDDS  BASE DE DESTINO
        End
        Else
        Begin
          AScript := AScript + '"0.00",'; // IME_ALQEFO  ALIQUOTA EFETIVA DE ORIGEM
          AScript := AScript + '"0.00",'; // IME_BASDDS  BASE DE DESTINO
        End;

        AScript := AScript + '"' + StringReplace(StringReplace(RecDadosICMS.ampLegal, '''', '', [rfReplaceAll]), '"', '', [rfReplaceAll]) + '",';
        AScript := AScript + '"' + StringReplace(StringReplace(RecDadosICMS.RecDadosProtocolo.protNome, '''', '', [rfReplaceAll]), '"', '', [rfReplaceAll]) + '",';
        AScript := AScript + '"' + StringReplace(StringReplace(RecDadosICMS.RecDadosProtocolo.descricao, '''', '', [rfReplaceAll]), '"', '', [rfReplaceAll]) + '",';
        AScript := AScript + '"' + StringReplace(StringReplace(RecDadosICMS.RecDadosConvenio.convNome, '''', '', [rfReplaceAll]), '"', '', [rfReplaceAll]) + '",';
        AScript := AScript + '"' + StringReplace(StringReplace(RecDadosICMS.RecDadosConvenio.descricao, '''', '', [rfReplaceAll]), '"', '', [rfReplaceAll]) + '"),';
      End;
    End;

    perfilPersistido := perfilPersistido -  [perfil];
  End;


  If AScript <> '' Then
  Begin
    AScript := AScript + ';';
    AScript := StringReplace(AScript, ',;', ';', []);

    AScript :=  'INSERT INTO IMENDES_ABFICM (IME_SEQCON,' +
                'IME_SEQUEN,' +
                'IME_CODBEN,' +
                'IME_CODITE,' +
                'IME_CODEMP,' +
                'IME_CODABF,' +
                'IME_ESTADO,' +
                'IME_PERFIL,' +
                'IME_CODSIT,' +
                'IME_BASICM,' +
                'IME_ALQICM,' +
                'IME_BASRET,' +
                'IME_ALQRET,' +
                'IME_ALQRED,' +
                'IME_IVA_ST,' +
                'IME_ALQFCP,' +
                'IME_ALQIED,' +
                'IME_ALQEFO,' +
                'IME_BASDDS,' +
                'IME_AMPLEG,' +
                'IME_PTCNOM,' +
                'IME_PTCDES,' +
                'IME_CONNOM,' +
                'IME_CONDES)VALUES' + AScript;
  End;

end;


procedure TThreadComunicador.pRemovePefisComMesmoFinalidade(strFinalidade: integer; var PefilParaProcessar: TConjPerfis; var PerfisUsados: TConjPerfis);
  var i: TPerfil;
begin
  For i in PefilParaProcessar do
  begin
    If (fRetOrigemFinalidade(i) = strFinalidade) Then
    Begin
      PefilParaProcessar := PefilParaProcessar - [i];
      PerfisUsados := PerfisUsados + [i];
    End;
  End;
end;

procedure TThreadComunicador.pSetaHeaders(ARESTReq: TRESTRequest);
begin
  ARESTReq.Params.AddHeader('login', FParamnsComunicador.strUsuario);
  ARESTReq.Params.AddHeader('senha', FParamnsComunicador.strSenha);
  ARESTReq.Params.AddHeader('Content-Type', CONTENT_TYPE);
  ARESTReq.Params.ParameterByName('senha').Options := [poDoNotEncode];
  ARESTReq.Params.ParameterByName('Content-Type').Options := [poDoNotEncode];
  ARESTReq.Params.ParameterByName('login').Options := [poDoNotEncode];
end;




{ IMENDES_LOGTHREAD }

class procedure TIMENDES_LOGTHREAD.pGravaLog(strAutInc, strLocal: String; strCodIte:String;
                                             strCodEmp: String; strCodAbf: String; strMensagem: String;
                                             qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}; VariaveisDeControle: TVariaveisDeControle;
                                             callStak: String = '');
var
  qryInterna: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
  conInterna: {$IFDEF LINUX}IConnection{$ELSE}TUniConnection{$ENDIF};
 {$IFDEF LINUX}
  LConnID: NativeUInt;
 {$ENDIF}
begin
//  pEscreveLog(Format('%s - %s - %s - %s - %s - %s', [strAutInc, strLocal, strCodIte, strCodEmp, strCodAbf, strMensagem]));


  Try
    If not assigned(qry) then
    Begin
     {$IFDEF LINUX}
      LConnID := Random(999999);
      conInterna := objConnectionsManager.BeginConnection(LConnID);
      qryInterna := conInterna.CreateQuery();
     {$ELSE}
      conInterna := iMendesCriaConnection;
      conInterna.Open;
      qryInterna := iMendesCriaQuery(conInterna);
     {$ENDIF}
    End
    Else
      qryInterna := qry;

    qryInterna.SQL.Clear;
    qryInterna.SQL.Add('INSERT INTO IMENDES_LOGTHREAD (IME_LOCAL, IME_SEQCON,IME_CODITE, IME_CODABF, IME_CODEMP, IME_OCORRE, IME_CALSTACK, IME_DTAOCO) VALUES ');
    qryInterna.SQL.Add('                              (:IME_LOCAL, :IME_SEQCON, :IME_CODITE, :IME_CODABF, :IME_CODEMP, :IME_OCORRE, :IME_CALSTACK, :IME_DTAOCO)');

    qryInterna.ParamByName('IME_LOCAL').AsString := strLocal;
    qryInterna.ParamByName('IME_SEQCON').AsString := strAutInc;
    qryInterna.ParamByName('IME_CODITE').AsString := strCodIte;
    qryInterna.ParamByName('IME_CODABF').AsString := strCodAbf;
    qryInterna.ParamByName('IME_CODEMP').AsString := strCodEmp;
    qryInterna.ParamByName('IME_OCORRE').AsString := strMensagem;
    qryInterna.ParamByName('IME_CALSTACK').AsString := callStak;
    qryInterna.ParamByName('IME_DTAOCO').AsDateTime := fImendesNow();

    Try
      qryInterna.ExecSQL;
    Except
      on e: Exception do
        raise Exception.Create(e.message);
    End;
  Finally
//    If Assigned(VariaveisDeControle) Then
//      VariaveisDeControle.SessaoCritica.Leave;
    If not Assigned(qry) Then
    Begin
     {$IFDEF LINUX}
      objConnectionsManager.EndConnection(LConnID);
     {$ELSE}
      FreeAndNil(qryInterna);
      FreeAndNil(conInterna);
     {$ENDIF}
    End;
  End;

end;


{ TIMENDES_GRAVAJSON }

class procedure TIMENDES_GRAVAJSON.pGravaJSON(var AVariaveisDeControle: TVariaveisDeControle; qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}; AIME_SEQCON, AIME_CODITE, AIME_IDEARQ, AID_CHAVE_, AIME_JSNENV, AIME_JSNRET: String; AIME_HORENV, AIME_HORRET: TDateTime);
var
  qryInterna: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
  conInterna: {$IFDEF LINUX}IConnection{$ELSE}TUniConnection{$ENDIF};
 {$IFDEF LINUX}
  LConnID: NativeUInt;
 {$ENDIF}
begin

//  pEscreveLog('Gravando JSON''''S');

  Try
    If not assigned(qry) then
    Begin
     {$IFDEF LINUX}
      LConnID := Random(999999);
      conInterna := objConnectionsManager.BeginConnection(LConnID);
      qryInterna := conInterna.CreateQuery();
     {$ELSE}
      conInterna := iMendesCriaConnection;
      conInterna.Open;
      qryInterna := iMendesCriaQuery(conInterna);
     {$ENDIF}
    End
    Else
      qryInterna := qry;
    Try
//      AIME_JSNRET :=  StringReplace(AIME_JSNRET, '''', '', [rfReplaceAll])+'''';
//      AIME_JSNENV :=  StringReplace(AIME_JSNENV, '''', '', [rfReplaceAll])+'''';
      qry.SQL.Clear;
      qry.SQL.Add('REPLACE INTO IMENDES_JSON (IME_SEQCON, IME_CODITE, IME_IDEARQ, ID_CHAVE_ , IME_HORENV, IME_JSNENV, IME_HORRET, IME_JSNRET) VALUES(');
      qry.SQL.Add('"'+AIME_SEQCON+'",');
      qry.SQL.Add('"'+AIME_CODITE+'",');
      qry.SQL.Add('"'+AIME_IDEARQ+'",');
      qry.SQL.Add('"'+AID_CHAVE_+'",');
      qry.SQL.Add('"'+FormatDateTime('yyyy/mm/dd hh:mm:ss', AIME_HORENV)+'",');
      qry.SQL.Add(':IME_JSNENV,');
//      qry.SQL.Add(QuotedStr(AIME_JSNENV)+',');
      qry.SQL.Add('"'+FormatDateTime('yyyy/mm/dd hh:mm:ss', AIME_HORRET)+'",');
//      qry.SQL.Add(QuotedStr(AIME_JSNRET)+ ')');
      qry.SQL.Add(':IME_JSNRET)');

      qry.ParamByName('IME_JSNENV').AsString := AIME_JSNENV;
      qry.ParamByName('IME_JSNRET').AsString := AIME_JSNRET;


//      pEscreveLog(Format('%s - %s', ['SQL: ', qry.SQL.Text]));
      qry.ExecSQL;
//      pEscreveLog('JSON''''S Gravado com sucesso!');
    except
      on e: Exception do
      Begin
        pEscreveLog(Format('%s' , [e.Message]));
      End;

    End;
  Finally
    If not Assigned(qry) Then
    Begin
     {$IFDEF LINUX}
      objConnectionsManager.EndConnection(LConnID);
     {$ELSE}
      FreeAndNil(qryInterna);
      FreeAndNil(conInterna);
     {$ENDIF}
    End;
  End;

end;

class procedure TIMENDES_REGISTRA_CONTADOR_ENVIO.pGravaLog(SchemaName, strAutInc, strCodIte,
  strCompleto, strChave: String; qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
  VariaveisDeControle: TVariaveisDeControle; var idRetorno: integer);
begin
  VariaveisDeControle.SessaoCritica.Enter;
  Try
     If idRetorno = -1 Then
     Begin
       qry.sql.Text := 'SELECT auto_increment FROM information_schema.TABLES where TABLE_NAME ="IMENDES_REGISTRA_ENVIOS" and TABLE_SCHEMA="' + SchemaName +'"';
       qry.Open;
       idRetorno := qry.FieldByName('auto_increment').AsInteger;

       qry.SQL.Clear;
       qry.SQL.Add('INSERT INTO IMENDES_REGISTRA_ENVIOS (ID, IME_SEQCON, IME_CODITE, IME_ARQUIVO, IME_CHAVE_, IME_DTAENV) VALUES (');
       qry.SQL.Add('"' + idRetorno.ToString + '",');
       qry.SQL.Add('"' + strAutInc + '",');
       qry.SQL.Add('"' + strCodIte + '",');
       qry.SQL.Add('"' + strCompleto + '",');
       qry.SQL.Add('"' + strChave + '",');
       qry.SQL.Add('CURRENT_TIMESTAMP());');
     End
     Else
     Begin
       qry.SQL.Clear;
       qry.SQL.Text := 'UPDATE IMENDES_REGISTRA_ENVIOS SET IME_DTARET = CURRENT_TIMESTAMP() WHERE ID = '+idRetorno.ToString+'; '
     End;
     qry.ExecSQL;
     qry.SQL.Clear;
  Finally
    VariaveisDeControle.SessaoCritica.leave;

  End;
end;


end.