unit iMendes.TProcessamentoExterno;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni, UniClientDataSet, madStackTrace,
{$ENDIF}
  iMendes.Types, iMendes.Functions, SysUtils, Classes, MySQLUniProvider, iMendes.Comunicador, Data.DB;


Type
  TProcessamentoExterno = Class
  private
    FqryPendencias: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    function fDeveProcessar(var blnContinuar: Boolean): Boolean;
    function fVerificaSeAindaEstaProcessando(idConnection: integer): Boolean;
  protected
   {$IFNDEF LINUX}
    MySQLUniProvider: TMySQLUniProvider;
   {$ENDIF}
    qryStatus: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    procedure pRegistraConexao;
    procedure pValidaEstruturaLocCon(AQuery: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF});
  public
    Autoincrem: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    function fLocalizaPendencias: Boolean;
    procedure ProcessaPendencias;
    class var FConnection: {$IFDEF LINUX}IConnection{$ELSE}TUniConnection{$ENDIF};
  End;

implementation

uses
  iMendes.Constantes, iMendes.Threads, iMendes.GerenciaEstado;

{ TProcessamentoExterno }

constructor TProcessamentoExterno.Create(AOwner: TComponent);
begin
  try
    If not Assigned(FConnection) Then
    Begin
     {$IFDEF LINUX}
      FConnection := objConnectionsManager.CurrentConnection;
      qryStatus := fCriaQuery;
      FqryPendencias := fCriaQuery;
      pRegistraConexao;
     {$ELSE}
      FConnection := iMendesCriaConnection;
      FConnection.Connected := True;
      qryStatus := iMendesCriaQuery(FConnection);
      FqryPendencias := iMendesCriaQuery(FConnection);
      pRegistraConexao;
     {$ENDIF}
    End
    Else
    Begin
      qryStatus := iMendesCriaQuery({$IFNDEF LINUX}FConnection{$ENDIF});
      FqryPendencias := iMendesCriaQuery({$IFNDEF LINUX}FConnection{$ENDIF});
    End;

    FqryPendencias.SQL.Clear;
    FqryPendencias.SQL.Add('UPDATE IMENDES_LOGCON SET LOGCON = CONNECTION_ID() WHERE LOG_ID = "'+iMendes.Types.IDUnicoExeImendesIntegra+'"');
    FqryPendencias.ExecSQL;

    //Avalia se tem ordem para fechar o processo se sim fecha
    FqryPendencias.SQL.Clear;
    FqryPendencias.SQL.Text := 'SELECT STOP_PROCESS FROM IMENDES_LOGCON WHERE LOG_ID = "'+iMendes.Types.IDUnicoExeImendesIntegra+'"';
    FqryPendencias.Open;

    If FqryPendencias.FieldByName('STOP_PROCESS').AsString = 'S' Then
      Halt;


    FqryPendencias.SQL.Clear;

   {$IFNDEF LINUX}
    iMendes_Connection := FConnection;
   {$ENDIF}
  Except
    {}
  End;

end;

destructor TProcessamentoExterno.Destroy;
begin
{$IFNDEF LINUX}
  FreeAndNil(FqryPendencias);
{$ENDIF}
  inherited;
end;

function TProcessamentoExterno.fDeveProcessar(var blnContinuar: Boolean): boolean;
begin
  Result := False;
  blnContinuar := False;

  {$IFDEF LINUX}
  If VS_ExitProcessSignal Then
    Exit;
  {$ENDIF}

  If FqryPendencias.FieldByName('STATUS').AsString = cImendesPendente Then
    Exit(True);

  If FqryPendencias.FieldByName('ID_CONNECTION').AsInteger <> 0 Then
    If Not fVerificaSeAindaEstaProcessando(FqryPendencias.FieldByName('ID_CONNECTION').AsInteger) Then
    Begin
      Exit(True);
      blnContinuar := True;
    End;

end;

function TProcessamentoExterno.fLocalizaPendencias: Boolean;
begin
  If Not fValidaPrfSanPreenchida(FqryPendencias) Then
  Begin
    pEscreveLog('Tabela PRFSAN não foi preenchida, impossivel processar', True);
    Exit(False);
  End;

  If Not fValidaCaracTribPreenchida(FqryPendencias) Then
  Begin
    pEscreveLog('Tabela IMENDES_CARACTRIB não foi preenchida, impossivel processar', True);
    Exit(False);
  End;


  Result := False;
  try
    FqryPendencias.SQL.Clear;
    FqryPendencias.SQL.Text := 'UPDATE IMENDES_PARAM  ' +
                               '   SET MAQUINA_ESTADO = MAQUINA_ESTADO_ANT, ' +
                               '       STATUS = "A" ' +
                               ' WHERE MAQUINA_ESTADO = 6 ' +
                               '   AND STATUS = "C" ' +
                               '   AND RESULTADO LIKE("%Lost connection to MySQL server during query%")';
    FqryPendencias.ExecSQL;
    FqryPendencias.SQL.Clear;
    FqryPendencias.SQL.Text := 'UPDATE IMENDES_PARAM  ' +
                               '   SET MAQUINA_ESTADO = MAQUINA_ESTADO_ANT, ' +
                               '       STATUS = "A" ' +
                               ' WHERE MAQUINA_ESTADO = 6 ' +
                               '   AND STATUS = "C" ' +
                               '   AND RESULTADO LIKE("%wait timeout exceeded; try restarting transaction%")';
    FqryPendencias.ExecSQL;



    FqryPendencias.SQL.Clear;
    FqryPendencias.SQL.Text := 'SELECT * FROM IMENDES_PARAM WHERE STATUS <> "' + cImendesConcluido + '" ORDER BY DATA LIMIT 1';
    FqryPendencias.Open;
    Result := FqryPendencias.RecordCount > 0;
    Autoincrem := FqryPendencias.FieldByName('AUTOINCREM').AsString;
  Except
    {}
  End;
end;



function TProcessamentoExterno.fVerificaSeAindaEstaProcessando(idConnection: integer): Boolean;
begin
  qryStatus.SQL.Clear;
  qryStatus.SQL.Add('SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST');
  qryStatus.SQL.Add('WHERE ID = ' + idConnection.ToString);
  Result := Not qryStatus.IsEmpty;
end;

procedure TProcessamentoExterno.pRegistraConexao;
begin
  If fServicoUP(FqryPendencias)  Then
  Begin
    pEscreveLog('Finalizado! Exite outro serviço aberto.', True);
    Sleep(5000);
    Halt(0);
  End;
  pValidaEstruturaLocCon(FqryPendencias);


  // Registra a conexão , caso ja exista apenas atualiza a connecion ID
  FqryPendencias.SQL.Clear;
  FqryPendencias.SQL.Add('SELECT COUNT(1) QTD FROM IMENDES_LOGCON WHERE LOG_ID = "'+iMendes.Types.IDUnicoExeImendesIntegra+'" AND STOP_PROCESS = "N"');
  FqryPendencias.Open;
  If FqryPendencias.FieldByName('QTD').AsInteger > 0 Then
  Begin
    FqryPendencias.SQL.Clear;
    FqryPendencias.SQL.Add('REPLACE INTO IMENDES_LOGCON (LOGCON, LOG_DTAENT, LOG_ID,STOP_PROCESS) VALUES (CONNECTION_ID(), CURRENT_TIMESTAMP, "'+iMendes.Types.IDUnicoExeImendesIntegra+'", "N");');
    FqryPendencias.ExecSQL;
    Exit;
  End
  Else
  Begin
    FqryPendencias.SQL.Clear;
    FqryPendencias.SQL.Add('REPLACE INTO IMENDES_LOGCON (LOGCON, LOG_DTAENT, LOG_ID,STOP_PROCESS) VALUES (CONNECTION_ID(), CURRENT_TIMESTAMP, "'+iMendes.Types.IDUnicoExeImendesIntegra+'", "A");');
    FqryPendencias.ExecSQL;
  End;

  FqryPendencias.SQL.Clear;
  FqryPendencias.SQL.Add('UPDATE IMENDES_LOGCON SET STOP_PROCESS = "S"');
  FqryPendencias.SQL.Add(' WHERE (SELECT COUNT(1) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE ID = LOGCON) = 0 AND LOG_ID <> "'+iMendes.Types.IDUnicoExeImendesIntegra+'"');
  FqryPendencias.ExecSQL;

  FqryPendencias.SQL.Clear;
  FqryPendencias.SQL.Add('REPLACE INTO IMENDES_LOGCON (LOGCON, LOG_DTAENT, LOG_ID,');
  FqryPendencias.SQL.Add('  STOP_PROCESS,');
  FqryPendencias.SQL.Add('  LOG_VERSAO,');
  FqryPendencias.SQL.Add('  LOG_NUM_IP,');
  FqryPendencias.SQL.Add('  LOG_MACADD,');
  FqryPendencias.SQL.Add('  LOG_NOMMAQ,');
  FqryPendencias.SQL.Add('  LOG_NOMUSU) VALUES (CONNECTION_ID(), CURRENT_TIMESTAMP, "'+iMendes.Types.IDUnicoExeImendesIntegra+'", "N",');

  FqryPendencias.SQL.Add('"' + VersaoApi + '",');
  FqryPendencias.SQL.Add('"' + VS_IPAddressAsString + '",');
  FqryPendencias.SQL.Add('"' + VS_MacAddress + '",');
  FqryPendencias.SQL.Add('"' + VS_ComputerNetName + '",');
  FqryPendencias.SQL.Add('"' + VS_UserFromWindows + '");');


  FqryPendencias.ExecSQL;


  qryStatus.SQL.Clear;

end;

procedure TProcessamentoExterno.ProcessaPendencias;
  var
    APISaneamento: TAPISaneamento;
    RecParam: TRecParametrosApiSaneamento;
    Params: TStringList;
    blnContinuaProcessamento: Boolean;
    strMensagem: String;
begin
  Try
    FqryPendencias.First;
    If FqryPendencias.RecordCount > 0 Then
    Begin
      If fDeveProcessar(blnContinuaProcessamento) Then
      Begin
        Params := TStringList.Create;
        Try
          Try
           {$IFDEF LINUX}
            pSetaEmpresaLogada(FqryPendencias.FieldByName('EMPRESA').AsString);
           {$ELSE}
            iMendes_strCodEmp  := FqryPendencias.FieldByName('EMPRESA').AsString;
           {$ENDIF}

           If IntegerToEstadoProcessamento(FqryPendencias.FieldByName('MAQUINA_ESTADO').AsInteger) = epAlterados then
             If Not iMendesfCfgSis('ROTALT', varBoolean, {$IFDEF LINUX}VS_strCodEmp{$ELSE}iMendes_strCodEmp{$ENDIF}) Then
             Begin
               TGerenciaEstado.DeletaPendencia(FqryPendencias.FieldByName('AUTOINCREM').AsString);
               Exit;
             End;
            APISaneamento := TAPISaneamento.Create(strMensagem, {$IFDEF LINUX}VS_strCodEmp{$ELSE}iMendes_strCodEmp{$ENDIF}, False,{$IFNDEF LINUX} nil, {$ENDIF} FqryPendencias.FieldByName('AUTOINCREM').AsString, FqryPendencias.FieldByName('IME_AGRUPADOR').AsString);
            Try
              If APISaneamento.blnAutenticado Then
              begin
                Params.Text := FqryPendencias.FieldByName('PARAMETROS').AsString;
                If Pos(cItensAlterados, Params.Text) > 0 Then
                Begin
                  RecParam.ProdutosAlterados := True;
                  RecParam.Filtros.blnIncluindo := False;
                End
                Else
                Begin
                  RecParam.ProdutosAlterados := False;
                  RecParam.pConvertoToRecord(Params);
                End;
                APISaneamento.pProcessa(RecParam);
              End;
            Except
              on e: Exception do
              Begin
                TIMENDES_LOGTHREAD.pGravaLog(FqryPendencias.FieldByName('AUTOINCREM').AsString,'[TProcessamentoExterno.ProcessaPendencias]', '', '', '', e.Message, nil, nil
                  {$IFNDEF LINUX},StackTrace{$ENDIF});
                Sleep(5000);
                blnNotificaExecucao := False;
                raise  Exception.Create(e.message);
              End;
            End
          Finally
            If Assigned(APISaneamento) Then
              FreeAndNil(APISaneamento);
          End;
        Finally
          FreeAndNil(Params)
        End;
      End;
    End;
  Except
    on e: Exception do
    Begin
      pEscreveLog('FALHA: ' + e.message, True);
      blnNotificaExecucao := False;
      raise  Exception.Create(e.message);
    End;
  End;
end;

procedure TProcessamentoExterno.pValidaEstruturaLocCon(AQuery: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF});
begin
  AQuery.SQL.Clear;
  AQuery.sql.Add('SELECT LOG_NUM_IP,');
  AQuery.sql.Add('       LOG_MACADD,');
  AQuery.sql.Add('       LOG_NOMMAQ,');
  AQuery.sql.Add('       LOG_NOMUSU');
  AQuery.sql.Add(' FROM IMENDES_LOGCON');
  AQuery.sql.Add('WHERE FALSE');
  Try
    AQuery.Open;
  Except
    AQuery.SQL.Clear;
    AQuery.SQL.Add('ALTER TABLE IMENDES_LOGCON  ADD COLUMN `LOG_VERSAO` VARCHAR (20) NULL;');
    AQuery.SQL.Add('ALTER TABLE IMENDES_LOGCON  ADD COLUMN `LOG_NUM_IP` VARCHAR (20) NULL;');
    AQuery.SQL.Add('ALTER TABLE IMENDES_LOGCON  ADD COLUMN `LOG_MACADD` VARCHAR (50) NULL;');
    AQuery.SQL.Add('ALTER TABLE IMENDES_LOGCON  ADD COLUMN `LOG_NOMMAQ` VARCHAR (100) NULL;');
    AQuery.SQL.Add('ALTER TABLE IMENDES_LOGCON  ADD COLUMN `LOG_NOMUSU` VARCHAR (100) NULL;');
    AQuery.ExecSQL;
  End;
  AQuery.SQL.Clear;
end;

initialization
  TProcessamentoExterno.FConnection := nil;

end.
