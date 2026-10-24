unit iMendes.ProcessaAlterados;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni, UniClientDataSet, madStackTrace,
{$ENDIF}
  DateUtils, StrUtils, SysUtils,  REST.Client, System.JSON,
  REST.Authenticator.Basic,
  REST.Types, iMendes.Threads, iMendes.Types, System.IOUtils, REST.Json,
  Classes,iMendes.GerenciaEstado, Data.db;

Type
  TProcessaAlterados = Class
  private
    blnFimDeExecucao: Boolean;
    FRestCli: TRESTClient;
    FRESTReq: TRESTRequest;
    FRESTRes: TRESTResponse;
    QryCadEmp: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    qryConsulta: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    FAutInc: String;
    FParamnsComunicador: TParamsComunicador;
    GerenciaEstado: TGerenciaEstado;
    procedure pProcessaPacote;
    procedure pProcessaRetorno(Estado: TUnidadesFederativas);
    procedure pProcessaItens(ArrProdutos: TJsonArray;
      Estado: TUnidadesFederativas; var AScript: String);
    function fRetCodIte(AEan: String): String;

    function fMontaJsonEnvio(Estado: TUnidadesFederativas): string;
    procedure pSetaHeaders();
    function fTemItensParaReprocessar: Boolean;

  public
    class function fRetSQLReplaceInto(ACodIte, ACodEmp: String; ADataAlt: TDate;
      ADtaUltCon: TDate; Estado: TConjUnidadesFederativas = [];
      blnValidaAltera: Boolean = False;
      blnForcaAlteradoSim: Boolean = False): string;
    procedure pProcessa(AGerenciaEstado: TGerenciaEstado);
    procedure pGeraNovaConsultaParaItensAlterados;
    destructor Destroy; override;
    constructor Create(AAutInc: string;{$IFNDEF LINUX}Connection : TUniConnection; {$ENDIF} AParamnsComunicador: TParamsComunicador);
  End;


implementation

uses
  iMendes.Functions, iMendes.Constantes;

{ TProcessaAlterados }

constructor TProcessaAlterados.Create(AAutInc: string;{$IFNDEF LINUX}Connection : TUniConnection; {$ENDIF} AParamnsComunicador: TParamsComunicador);
begin
  FParamnsComunicador:= AParamnsComunicador;
  qryCademp := iMendesCriaQuery({$IFNDEF LINUX}Connection{$ENDIF});
  qryConsulta:= iMendesCriaQuery({$IFNDEF LINUX}Connection{$ENDIF});
  FAutInc:=AAutInc;

  FRESTRes := TRESTResponse.Create(Nil);
  FRESTReq := TRESTRequest.Create(nil);
  FRESTCli := TRESTClient.Create(FParamnsComunicador.strUrlAlterados);


  FRESTCli.Accept := ACCEPT;
  FRESTCli.AcceptCharset := ACCEPT_CHARSET;
  FRESTCli.HandleRedirects := True;


  FRESTReq.Accept := ACCEPT;
  FRESTReq.AcceptCharset := ACCEPT_CHARSET;
  FRESTReq.Client := FRESTCli;
  FRESTReq.Response := FRESTRes;
  FRESTReq.Timeout := FParamnsComunicador.intTimeout;

  pSetaHeaders;
end;

procedure TProcessaAlterados.pGeraNovaConsultaParaItensAlterados;
var strDescricao, strAgrup: String;
begin
  qryConsulta.SQL.Clear;
  QryCadEmp.First;
  strAgrup := '';
  If fTemItensParaReprocessar Then
  Begin
    while not QryCadEmp.Eof Do
    Begin
      qryConsulta.SQL.Text := 'INSERT INTO IMENDES_PARAM (AUTOINCREM, PARAMETROS, DATA, STATUS, EMPRESA, MAQUINA_ESTADO,IME_AGRUPADOR, DESCRICAO) VALUES(:AUTOINCREM, :PARAMETROS, CURRENT_TIMESTAMP, :STATUS, :EMPRESA, :MAQUINA_ESTADO,:IME_AGRUPADOR,:DESCRICAO);';
      If strAgrup = '' Then
      Begin
        strDescricao := 'Consulta Automática - Produtos Alterados - ' + DateToStr(fImendesNow());
        strAgrup := iMendesRetAutoincrem({$IFNDEF LINUX}qryConsulta.Connection, {$ENDIF} 'IMENDES_PARAM', qryCadEmp.FieldByName('EMP_CODEMP').AsString);
        qryConsulta.ParamByName('AUTOINCREM').AsString := strAgrup;
      End
      Else
        qryConsulta.ParamByName('AUTOINCREM').AsString := iMendesRetAutoincrem({$IFNDEF LINUX}qryConsulta.Connection, {$ENDIF} 'IMENDES_PARAM', qryCadEmp.FieldByName('EMP_CODEMP').AsString);

      qryConsulta.ParamByName('PARAMETROS').AsString := cItensAlterados;
      qryConsulta.ParamByName('STATUS').AsString := cImendesPendente;
      qryConsulta.ParamByName('EMPRESA').AsString := QryCadEmp.FieldByName('EMP_CODEMP').AsString;
      qryConsulta.ParamByName('MAQUINA_ESTADO').AsInteger := 0;
      qryConsulta.ParamByName('IME_AGRUPADOR').AsString := strAgrup;
      qryConsulta.ParamByName('DESCRICAO').AsString := strDescricao;
      qryConsulta.ExecSQL;
      QryCadEmp.Next;
    End;
  End;
end;

function TProcessaAlterados.fTemItensParaReprocessar: Boolean;
Begin
  qryConsulta.SQL.Text :=  'SELECT COUNT(1) AS QTD FROM IMENDES_ALTERADOS WHERE IME_ALTERA = "S"';
  qryConsulta.Open;

  Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
End;

procedure TProcessaAlterados.pProcessa(AGerenciaEstado: TGerenciaEstado);
begin
  GerenciaEstado:= AGerenciaEstado;
  blnFimDeExecucao := False;
  qryCademp.SQL.Clear;
  qryCademp.SQL.Add('SELECT EMP_CODEMP, EMP_C_G_C_ FROM CADEMP');
  qryCademp.SQL.Add(' INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPABF" AND SIS_CODEMP =  EMP_CODEMP');
  qryCademp.SQL.Add('  AND SIS_VALCFG = "1"');
  qryCademp.SQL.Add('  GROUP BY SIS_VALCFG');
  qryCademp.SQL.Add('UNION ALL');
  qryCademp.SQL.Add('SELECT EMP_CODEMP,EMP_C_G_C_ FROM CADEMP');
  qryCademp.SQL.Add(' INNER JOIN CFGSIS ON SIS_CODCFG = "CFG_TIPABF" AND SIS_CODEMP =  EMP_CODEMP');
  qryCademp.SQL.Add(' WHERE TRUE');
  qryCademp.SQL.Add('  AND SIS_VALCFG = "2"');
  qryCademp.Open;
  While not qryCademp.Eof Do
  Begin
    blnFimDeExecucao := False;
    while not blnFimDeExecucao do
    begin
      pProcessaPacote;
    end;
    qryCademp.Next;
  End;

  GerenciaEstado.pAtualizaMaquinaEstado(epFinalizadoOk);
  pGeraNovaConsultaParaItensAlterados;

end;


procedure TProcessaAlterados.pSetaHeaders();
begin
  FRESTReq.Params.AddHeader('login', FParamnsComunicador.strUsuario);
  FRESTReq.Params.AddHeader('senha', FParamnsComunicador.strSenha);
//  FRESTReq.Params.AddHeader('Content-Type', CONTENT_TYPE);
  FRESTReq.Params.ParameterByName('senha').Options := [poDoNotEncode];
  FRESTReq.Params.ParameterByName('login').Options := [poDoNotEncode];
//  FRESTReq.Params.ParameterByName('Content-Type').Options := [poDoNotEncode];
end;

procedure TProcessaAlterados.pProcessaPacote;
var Estado: TUnidadesFederativas;
    ConjUnidadesFederativas: TConjUnidadesFederativas;
    EstadosProcessados : TConjUnidadesFederativas;
begin
  EstadosProcessados := [ufAC, ufAL, ufAM, ufAP, ufBA, ufCE, ufDF, ufES, ufGO, ufMA, ufMG, ufMS, ufMT, ufPA, ufPB, ufPE, ufPI, ufPR, ufRJ, ufRN, ufRO, ufRR, ufRS, ufSC, ufSE, ufSP, ufTO];
  ConjUnidadesFederativas := EstadosProcessados;
  while Not (EstadosProcessados =  []) do
  Begin
    Try
      for Estado in ConjUnidadesFederativas do
      begin

        FRESTReq.Method := rmPOST;
        FRESTCli.BaseURL := FParamnsComunicador.strUrlAlterados;
        FRESTReq.ClearBody;
        FRESTReq.AddBody(fMontaJsonEnvio(Estado), ctAPPLICATION_JSON);

        If FRESTReq.Params.Count < 0 Then
          pSetaHeaders();

       {$IFDEF LINUX}
        WriteLog(Format('%s - %s', ['rmPOST', FRESTCli.BaseURL]));
       {$ENDIF}

        FRESTReq.Execute;

       {$IFDEF LINUX}
        WriteLog(Format('%s - %s', ['jsnResposta', FRESTRes.JSONText]));
       {$ENDIF}

        pProcessaRetorno(Estado);
        EstadosProcessados := EstadosProcessados - [Estado]
      End;
    Except
      on e: Exception do
        TIMENDES_LOGTHREAD.pGravaLog(FAutInc , 'TProcessaAlterados.pProcessaPacote', '', '','',  e.Message, nil, nil);
    End;
  End;
  blnFimDeExecucao := True;
End;

procedure TProcessaAlterados.pProcessaRetorno(Estado: TUnidadesFederativas );
var jsnResposta: TJSONObject;
    strMensagem:String;
    qtdProd: integer;
    Script: String;
begin
  jsnResposta := TJSONObject.ParseJSONValue(FRESTRes.JSONText) As TJSONObject;

(*  If FParamnsComunicador.strDiretorioJson <> '' Then
  Begin
    Try
      TFile.WriteAllBytes(FParamnsComunicador.strDiretorioJson + '\Retorno_ALTERADOS_'+QryCadEmp.FieldByName('EMP_CODEMP').AsString + FormatDateTime('DDMMYYYY', fImendesNow({$IFNDEF LINUX}qryCadEmp.Connection{$ENDIF})) + fRetStringUF(Estado) + '.txt',TEncoding.UTF8.GetBytes(jsnResposta.ToString));
    Except
    End;
  End;
*)
  strMensagem := jsnResposta.GetValue<TJSONObject>('cabecalho').GetValue<string>('mensagem');
  If strMensagem = 'OK' Then
  Begin
    qtdProd :=  jsnResposta.GetValue<TJSONObject>('cabecalho').GetValue<integer>('produtosRetornados');
    If qtdProd > 0 Then
    Begin
      Try
        Script := '';
        pProcessaItens(jsnResposta.GetValue<TJSONArray>('produto'), Estado, Script);
        If Script <> '' Then
        {$IFDEF LINUX}
          objConnectionsManager.CurrentConnection.CreateQuery(Script).ExecSQL;
        {$ELSE}
          QryCadEmp.Connection.ExecSQL(Script);
        {$ENDIF}
      Except
        on e: Exception do
         TIMENDES_LOGTHREAD.pGravaLog(FAutInc , 'TProcessaAlterados.pProcessaRetorno', '', '','',  e.Message, nil, nil);
      End;
    End;
  End
  Else
   TIMENDES_LOGTHREAD.pGravaLog(FAutInc , 'TProcessaAlterados.pProcessaRetorno', '', '','',  strMensagem, nil, nil);

end;

procedure TProcessaAlterados.pProcessaItens(ArrProdutos: TJsonArray;Estado: TUnidadesFederativas; var AScript: String);

var
  I: Integer;
  CodIte: string;
  DataCon: TDate;
  DataAlt: TDate;
  codigoInterno: String;
Begin
  for I := 0 to ArrProdutos.Count -1 do
  Begin
    codigoInterno := ArrProdutos.Items[i].GetValue<string>('codigoInterno');
    CodIte  := ArrProdutos.Items[i].GetValue<string>('codigo');
    If codigoInterno = 'N' Then
      CodIte := fRetCodIte(CodIte);
    DataCon := ArrProdutos.Items[i].GetValue<TDate>('dtultcons');
    DataAlt := ArrProdutos.Items[i].GetValue<TDate>('dtrev');
    AScript := AScript + fRetSQLReplaceInto(CodIte, QryCadEmp.FieldByName('EMP_CODEMP').AsString, DataAlt, DataCon, [Estado], True, True);
  End;
  {}
End;


function TProcessaAlterados.fMontaJsonEnvio(Estado: TUnidadesFederativas): string;
var
  jsnJSON: TJSONObject;
begin
  Result := '';
  jsnJSON := TJSONObject.Create;
  Try
    jsnJSON.AddPair('nomeServico', 'ALTERADOS');
    jsnJSON.AddPair('dados', qryCadEmp.FieldByName('EMP_C_G_C_').AsString+ '|' + fRetStringUF(Estado));
    Result := TJSON.Format(jsnJSON);

    If FParamnsComunicador.strDiretorioJson <> '' Then
    Begin
      Try
(*        If Not DirectoryExists(FParamnsComunicador.strDiretorioJson) Then
          ForceDirectories(FParamnsComunicador.strDiretorioJson);
        TFile.WriteAllBytes(FParamnsComunicador.strDiretorioJson + '\Envio_ALTERADOS_'+
          QryCadEmp.FieldByName('EMP_CODEMP').AsString +
          FormatDateTime('DDMMYYYY', fImendesNow({$IFNDEF LINUX}qryCadEmp.Connection{$ENDIF})) +
          fRetStringUF(Estado) + '.txt',TEncoding.UTF8.GetBytes(Result));
*)
      Except
      End;
    End;

  Finally
    FreeandNil(jsnJSON);
  End;



End;

destructor TProcessaAlterados.Destroy;
begin
  FreeAndNil(FRESTCli);
  FreeAndNil(FRESTRes);
  FreeAndNil(FRESTReq);
{$IFNDEF LINUX}
  FreeAndNil(qryCademp);
{$ENDIF}
  inherited;
end;

function TProcessaAlterados.fRetCodIte(AEan: String): String;
begin
  Result := '';
  qryConsulta.SQL.Text := 'SELECT ITE_CODITE FROM CADITE WHERE ITE_CODBAR = "'+AEan+'"';
  qryConsulta.Open;
  If Not qryConsulta.IsEmpty Then
    Result := qryConsulta.FieldByName('ITE_CODITE').AsString;
end;

class function TProcessaAlterados.fRetSQLReplaceInto(ACodIte, ACodEmp: String;
  ADataAlt, ADtaUltCon: TDate; Estado: TConjUnidadesFederativas = []; blnValidaAltera: Boolean = False; blnForcaAlteradoSim: Boolean= False): string;
  var strDtaAlt,
      strDtaUltCon: String;
      ConjUnidadesFederativas: TConjUnidadesFederativas;
      i:TUnidadesFederativas;
      strIME_ALTERA: String;
begin
  If ACodIte = '' Then
    Exit('');

  Result := '';
  ConjUnidadesFederativas := [ufAC, ufAL, ufAM, ufAP, ufBA, ufCE, ufDF, ufES, ufGO, ufMA, ufMG, ufMS, ufMT, ufPA, ufPB, ufPE, ufPI, ufPR, ufRJ, ufRN, ufRO, ufRR, ufRS, ufSC, ufSE, ufSP, ufTO];

  If ADataAlt = 0 Then
    strDtaAlt := 'CURDATE()'
  Else
    strDtaAlt := '"' + FormatDateTime('YYYY-MM-DD', ADataAlt) + '"';
  If ADtaUltCon = 0 Then
    strDtaUltCon := 'CURDATE()'
  Else
    strDtaUltCon := '"' + FormatDateTime('YYYY-MM-DD', ADtaUltCon) + '"';
  If blnValidaAltera then
    strIME_ALTERA := 'IF(IME_ULTALT <  '+strDtaAlt+', "S", "N")'
  Else
    strIME_ALTERA := '"N"';


  For i in ConjUnidadesFederativas do
  Begin
    If Estado <> [] Then
    Begin
      If i in Estado then
      Begin
        If blnForcaAlteradoSim Then
          strIME_ALTERA := '"S"';
        Result := Result + 'REPLACE INTO IMENDES_ALTERADOS(IME_CODEMP, IME_CODITE, IME_ULTCON, IME_ULTALT, IME_ESTADO, IME_ALTERA) VALUES ("' +
                            ACodEmp+'", "'+
                            ACodIte+'", ' +
                            strDtaUltCon +', ' +
                            strDtaAlt + ', "'+
                            fRetStringUF(i)+'", ' +
                            strIME_ALTERA + ');'
      End;
    End
    Else
    Begin
        Result := Result + 'REPLACE INTO IMENDES_ALTERADOS(IME_CODEMP, IME_CODITE, IME_ULTCON, IME_ULTALT, IME_ESTADO, IME_ALTERA) VALUES ("' +
                            ACodEmp+'", "'+
                            ACodIte+'", ' +
                            strDtaUltCon +', ' +
                            strDtaAlt + ', "'+
                            fRetStringUF(i)+'", ' +
                            strIME_ALTERA + ');'
    End;
  End;

end;



end.
