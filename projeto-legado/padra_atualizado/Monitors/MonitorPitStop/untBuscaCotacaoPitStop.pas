unit untBuscaCotacaoPitStop;

interface

uses  Windows, Classes, PitStop.Comunicacao, Uni, untFuncoesSimples, PitStop.Classes.EndPoint,
      PitStop.Classes.Base, System.SysUtils, Data.DB , Winapi.Messages, Cotacao.ApiPrecos.ConstAndTypes;

Type

  TBuscaCotacaoPitStop = class
  private
    qry: TUniQuery;
    qryComand: TUniQuery;
    RedePitStop: TRedePitStop;
    FStatusConsultaPitStop: TStatusConsultaPitStop;
    FStatusConsultaPitStopInicial: TStatusConsultaPitStop;
    FParam: TParamBuscaCotacao;
    FAutIncCotger: String;
    FCodFor: String;
    procedure pAtualizaStatus;
    procedure NextStatus;
    procedure processa;
    procedure processaPendente;
    function fCancelado(AConId: String): Boolean;
    procedure pNotificaOperador;

    procedure pGravaRETPIT;

  public
    procedure processaRetorno;

    procedure pIniciaProcessosQuePerderamConexao;
    constructor Create;
    destructor Destroy; override;
  End;

implementation

uses
  untTypesSistema, UntMsgInterna, PitStop.classe.log;

{ TBuscaCotacaoPitStop }

constructor TBuscaCotacaoPitStop.Create();
begin
  inherited;
  qry := fCriaQuery;
  qryComand := fCriaQuery;
end;

destructor TBuscaCotacaoPitStop.Destroy;
begin
  FreeAndNil(qryComand) ;
  FreeAndNil(qry) ;
  inherited;
end;



function TBuscaCotacaoPitStop.fCancelado(AConId: String): Boolean;
begin
  qryComand.SQL.Clear;
  qryComand.SQL.Add('SELECT * FROM CONPIT WHERE CON_ID_CON = "'+AConId+'" AND CON_STATUS = -1');
  qryComand.Open;
  Result := Not qryComand.IsEmpty;
end;

procedure TBuscaCotacaoPitStop.NextStatus;
begin
  case FStatusConsultaPitStop of
    scpsPendente: FStatusConsultaPitStop :=  scpsProcessando;
    scpsProcessando: FStatusConsultaPitStop := scpsConcluidoPrimeiraEtapa;
    scpsConcluidoPrimeiraEtapa: FStatusConsultaPitStop := scpsPendenteSegundaEtapa;
    scpsPendenteSegundaEtapa: FStatusConsultaPitStop := scpsProcessandoSegundaEtapa;
    scpsProcessandoSegundaEtapa: FStatusConsultaPitStop := scpsConcluido;
  End;
  pAtualizaStatus;
end;

procedure TBuscaCotacaoPitStop.pAtualizaStatus;
var strNumCot: String;
begin
  qryComand.SQL.Clear;
  qryComand.SQL.Add('UPDATE CONPIT SET CON_STATUS = ' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(FStatusConsultaPitStop).ToString);
  If FStatusConsultaPitStop = scpsCancelado Then
    qryComand.SQL.Add('   ,CON_MESSAG = "CANCELADO" ');
  qryComand.SQL.Add(' WHERE CON_ID_CON = "' +FParam.idConsulta + '"');
  qryComand.SQL.Add('   AND CON_COTGER = "' + FAutIncCotger + '"');
  qryComand.ExecSQL;


  If FStatusConsultaPitStop = scpsCancelado Then
  begin
    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE COTCFO SET COT_PITSTO = ' + TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscComApi).ToString);
    qryComand.SQL.Add(' WHERE COT_SEQGER = "' + FAutIncCotger + '"');
    qryComand.SQL.Add('   AND COT_CODFOR = "' + FCodFor + '"');
    qryComand.ExecSQL;
  End;


  If (FStatusConsultaPitStop = scpsProcessando) or
     (FStatusConsultaPitStop = scpsProcessandoSegundaEtapa) Then
  begin
    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE CONPIT SET CON_CONNEC = CONNECTION_ID(), CON_HORINI = IFNULL(CON_HORINI, CURRENT_TIMESTAMP)');
    qryComand.SQL.Add(' WHERE CON_ID_CON = "' +FParam.idConsulta + '"');
    qryComand.SQL.Add('   AND CON_COTGER = "' + FAutIncCotger + '"');
    qryComand.ExecSQL;
  End;

  If (FStatusConsultaPitStop = scpsConcluidoPrimeiraEtapa) or
     (FStatusConsultaPitStop = scpsConcluido) Then
   begin
     qryComand.SQL.Clear;
     If FStatusConsultaPitStop = scpsConcluidoPrimeiraEtapa Then
       qryComand.SQL.Add('UPDATE COTCFO SET COT_PITSTO = ' + TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarConsultaPreco).ToString)
     Else
       qryComand.SQL.Add('UPDATE COTCFO SET COT_PITSTO = ' + TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarRecotarPreco).ToString);
     qryComand.SQL.Add(' WHERE COT_SEQGER = "' + FAutIncCotger + '"');
     qryComand.SQL.Add('   AND COT_CODFOR = "' + FCodFor + '"');
     qryComand.ExecSQL;

     strNumCot := fCampoTabela('COT_NUMCOT', 'COTGER', ['AUTOINCREM'], [FAutIncCotger]);

     qryComand.SQL.Clear;
     If FStatusConsultaPitStop = scpsConcluidoPrimeiraEtapa Then
       qryComand.SQL.Add('UPDATE COTCFO_RES SET COT_PITSTO = ' + TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarConsultaPreco).ToString)
     Else
       qryComand.SQL.Add('UPDATE COTCFO_RES SET COT_PITSTO = ' + TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarRecotarPreco).ToString);
     qryComand.SQL.Add(' WHERE COT_SEQGER IN (SELECT  AUTOINCREM FROM COTGER_RES');
     qryComand.SQL.Add('                       WHERE COT_NUMCOT = "'+strNumCot+'")');
     qryComand.SQL.Add('   AND COT_CODFOR = "' + FCodFor + '"');
     qryComand.ExecSQL;
   End;
end;

procedure TBuscaCotacaoPitStop.pGravaRETPIT;
var i: integer;
begin


  qryComand.SQL.Clear;
  qryComand.SQL.Add('INSERT INTO RETPIT (PIT_ID_CON,');
  qryComand.SQL.Add(' PIT_ID_PED,');
  qryComand.SQL.Add(' PIT_CODBAR,');
  qryComand.SQL.Add(' PIT_CODINT,');
  qryComand.SQL.Add(' PIT_VPRECO,');
  qryComand.SQL.Add(' PIT_VFRETE,');
  qryComand.SQL.Add(' PIT_VDESPE,');
  qryComand.SQL.Add(' PIT_VAL_ST,');
  qryComand.SQL.Add(' PIT_VALIPI,');
  qryComand.SQL.Add(' PIT_LOCALI,');
  qryComand.SQL.Add(' PIT_ETAPAC,');
  qryComand.SQL.Add(' PIT_DESCRI)VALUES(');
  qryComand.SQL.Add(' :PIT_ID_CON,');
  qryComand.SQL.Add(' :PIT_ID_PED,');
  qryComand.SQL.Add(' :PIT_CODBAR,');
  qryComand.SQL.Add(' :PIT_CODINT,');
  qryComand.SQL.Add(' :PIT_VPRECO,');
  qryComand.SQL.Add(' :PIT_VFRETE,');
  qryComand.SQL.Add(' :PIT_VDESPE,');
  qryComand.SQL.Add(' :PIT_VAL_ST,');
  qryComand.SQL.Add(' :PIT_VALIPI,');
  qryComand.SQL.Add(' :PIT_LOCALI,');
  qryComand.SQL.Add(' :PIT_ETAPAC,');
  qryComand.SQL.Add(' :PIT_DESCRI)');

  For i := 0 to High(FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoNaoLocalizado) do
  begin
    qryComand.ParamByName('PIT_ID_CON').AsString := FParam.idConsulta;
    qryComand.ParamByName('PIT_ID_PED').AsInteger := 0;
    qryComand.ParamByName('PIT_CODBAR').AsString := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoNaoLocalizado[i].ean;
    qryComand.ParamByName('PIT_CODINT').AsString := '';
    qryComand.ParamByName('PIT_VPRECO').AsFloat  := 0;
    qryComand.ParamByName('PIT_VFRETE').AsFloat  := 0;
    qryComand.ParamByName('PIT_VDESPE').AsFloat  := 0;
    qryComand.ParamByName('PIT_VAL_ST').AsFloat  := 0;
    qryComand.ParamByName('PIT_VALIPI').AsFloat  := 0;
    qryComand.ParamByName('PIT_LOCALI').AsInteger := 0;
    If FStatusConsultaPitStop = scpsProcessando Then
      qryComand.ParamByName('PIT_ETAPAC').AsInteger   := 1
    Else
      qryComand.ParamByName('PIT_ETAPAC').AsInteger   := 2;
    qryComand.ParamByName('PIT_DESCRI').AsString := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoNaoLocalizado[i].desc;
    qryComand.ExecSQL;
  end;

  For i := 0 to High(FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto) do
  begin
    qryComand.ParamByName('PIT_ID_CON').AsString  := FParam.idConsulta;
    qryComand.ParamByName('PIT_ID_PED').AsString := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].id_ped;
    qryComand.ParamByName('PIT_CODBAR').AsString  := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].ean;
    qryComand.ParamByName('PIT_CODINT').AsInteger := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].cod_interno;
    qryComand.ParamByName('PIT_VPRECO').AsFloat   := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].preco;
    qryComand.ParamByName('PIT_VFRETE').AsFloat   := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].frete;
    qryComand.ParamByName('PIT_VDESPE').AsFloat   := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].despesa;
    qryComand.ParamByName('PIT_VAL_ST').AsFloat   := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].imposto_st;
    qryComand.ParamByName('PIT_VALIPI').AsFloat   := FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto[i].imposto_ipi;
    If FStatusConsultaPitStop = scpsProcessando Then
      qryComand.ParamByName('PIT_ETAPAC').AsInteger   := 1
    Else
      qryComand.ParamByName('PIT_ETAPAC').AsInteger   := 2;
    qryComand.ParamByName('PIT_LOCALI').AsInteger := 1;
    qryComand.ParamByName('PIT_DESCRI').AsString  := '';
    qryComand.ExecSQL;
  end;

  {}
end;

procedure TBuscaCotacaoPitStop.pIniciaProcessosQuePerderamConexao;
var strParam: String;
begin
  qry.SQL.Clear;
  qry.SQL.Add('SELECT CONPIT.*, COT_CODEMP FROM CONPIT');
  qry.SQL.Add(' INNER JOIN COTGER ON AUTOINCREM = CON_COTGER ');
  qry.SQL.Add(' WHERE CON_STATUS IN (' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsPendente).ToString + ',');
  qry.SQL.Add('                      ' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsProcessando).ToString + ',');
  qry.SQL.Add('                      ' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsPendenteSegundaEtapa).ToString + ',');
  qry.SQL.Add('                      ' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsProcessandoSegundaEtapa).ToString + ')');
  qry.SQL.Add('                      AND CON_ID_CON <> "' + ParamStr(2) + '"');
  qry.SQL.Add('   AND IFNULL(CON_CONNEC, "") <> ""');
  qry.SQL.Add('   AND (SELECT COUNT(1) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE ID = CON_CONNEC) = 0');

  qry.Open;
  while not qry.Eof do
  begin
    qryComand.SQL.Clear;
    qryComand.SQL.Add('UPDATE CONPIT SET CON_CONNEC = NULL');
    qryComand.SQL.Add(' WHERE CON_ID_CON = "' + qry.FieldByName('CON_ID_CON').AsString + '"');
    qryComand.SQL.Add('   AND CON_COTGER = "' + qry.FieldByName('CON_COTGER').AsString + '"');
    qryComand.SQL.Add('   AND CON_STATUS <> -1');
    qryComand.ExecSQL;
    strParam:= qry.FieldByName('COT_CODEMP').AsString + ' ' + qry.FieldByName('CON_ID_CON').AsString;
    StartProcess(ParamStr(0),   strParam);
    qry.Next;
  End;

end;
procedure TBuscaCotacaoPitStop.pNotificaOperador;
var msgMensagem: TMsgInterna;
    stlMensagem: TStringList;
    qryConsulta: TUniQuery;

begin
  msgMensagem := TMsgInterna.Create(Nil);
  stlMensagem := TStringList.Create;
  qryConsulta := fCriaQuery;
  Try
     qryConsulta.SQL.Add('SELECT CONCAT(COTGER.COT_NUMCOT, "-", COT_DESCRI) COTACAO, COTGER.COT_CODCMP, CON_COTGER, CON_CODFOR, CON_HANDLE, COT_NUMCOT  FROM CONPIT');
     qryConsulta.SQL.Add('INNER JOIN COTGER ON AUTOINCREM = CON_COTGER');
     qryConsulta.SQL.Add('WHERE CON_ID_CON = "'+ParamStr(2)+'"');
     qryConsulta.SQL.Add('  AND CON_STATUS <> -1');

     qryConsulta.Open;

     stlMensagem.Add('CONSULTA PIT-STOP CONCLUÍDA');
     stlMensagem.Add('A Cotação: ' + qryConsulta.FieldByName('COTACAO').AsString + ' terminou o processamento.');
     msgMensagem.fEnviaMensagem('Consulta Cotação Pit-Stop Finalizada', stlMensagem.Text, 'AUT', qryConsulta.FieldByName('COT_CODCMP').AsString, 'N', '');
     PostMessage(qryConsulta.FieldByName('CON_HANDLE').AsInteger, WM_PIT_STOP_CONCLUIDO, qryConsulta.FieldByName('COT_NUMCOT').AsInteger, qryConsulta.FieldByName('CON_CODFOR').AsInteger);



  finally
    FreeAndNil(msgMensagem);
    FreeAndNil(stlMensagem);
    FreeAndNil(qryConsulta);
  End;
end;

procedure TBuscaCotacaoPitStop.processa;
begin
  If FStatusConsultaPitStop in [scpsPendente, scpsPendenteSegundaEtapa] then
    processaPendente;
end;

procedure TBuscaCotacaoPitStop.processaPendente;
begin

  FParam.pagina := 1;
//  FParam.Teste := True;
  //Muda para processando
  NextStatus;
  while not  (FStatusConsultaPitStop in [scpsConcluidoPrimeiraEtapa, scpsConcluido]) do
  begin
    If Not fCancelado(ParamStr(2)) then
    Begin
      Try
         RedePitStop.fRetBuscaCotacao(FParam);
      Except
        on e: exception do
          RedePitStop.ApiFalha := e.Message;
      End;
      If RedePitStop.ApiFalha <> '' Then
      begin
        TPitStopLog.RegistraLogExt(ParamStr(2), RedePitStop.ApiFalha, '[BuscaCotacaoPitStop.processaPendente]', False);
        Sleep(30000);
      End
      Else If FParam.RetornoApi.Falha  = 'Calculo nao finalizou o processamento' then
      begin
        TPitStopLog.RegistraLogExt(ParamStr(2), RedePitStop.ApiFalha, '[BuscaCotacaoPitStop.processaPendente]', False);
        Sleep(30000);
      End
      Else
      begin
        qry.SQL.Clear;
        qry.sql.Add('DELETE FROM RETPIT');
        qry.sql.Add('WHERE PIT_ID_CON = "'+FParam.idConsulta + '" ');
        If FStatusConsultaPitStop = scpsProcessando Then
          qry.sql.Add('AND PIT_ETAPAC = 1')
        Else
          qry.sql.Add('AND PIT_ETAPAC = 2');
        qry.ExecSQL;

        while FParam.pagina <= FParam.totalPaginas do
        begin
          pGravaRETPIT;

          SetLength(FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoNaoLocalizado, 0);
          SetLength(FParam.RetornoBuscaCotacao.ArrRetornoBuscaCotacaoProduto, 0);
          inc(FParam.pagina);
          If (FParam.pagina <= FParam.totalPaginas) then
            RedePitStop.fRetBuscaCotacao(FParam);
        end;

        qry.SQL.Clear;
        qry.SQL.Add('UPDATE CONPIT SET CON_MESSAG = "'+ DateTimeToStr(fNow) + ' Concluído" WHERE CON_ID_CON = "'+ParamStr(2)+'"');;
        qry.ExecSQL;
        NextStatus;


        pNotificaOperador;
      End;
    End;
  End;
end;

procedure TBuscaCotacaoPitStop.processaRetorno;
var login: Boolean;
    ParamCancel: TParamCancelaCotacao;
begin
  login := false;
  while not login do
  begin
    Try
      RedePitStop := TRedePitStop.Create(fCfgSis('PSTCID'), True);
      If RedePitStop.ApiFalha <> '' Then
      Begin
        RedePitStop.PitStopLog.RegistraLog(RedePitStop.ApiFalha, 'TBuscaCotacaoPitStop.processaRetorno');
        sleep(15000);
      End
      Else
      begin
        If Uppercase(ParamStr(4)) = 'CANCEL' then
        begin
          ParamCancel := TParamCancelaCotacao.Create;
          Try
            ParamCancel.idCotacao :=  ParamStr(2);
            RedePitStop.fCancelaCotacao(ParamCancel);
            FParam := TParamBuscaCotacao.Create;

            qry.SQL.Clear;
            qry.SQL.Add('SELECT * FROM CONPIT WHERE CON_ID_CON = "'+ParamStr(2)+'"');
            qry.Open;

            FParam.idConsulta := ParamStr(2);
            FAutIncCotger := qry.FieldByName('CON_COTGER').AsString;
            FCodFor := qry.FieldByName('CON_CODFOR').AsString;

            If ParamCancel.RetornoApi.Sucess then
            begin
              login := True;
              FStatusConsultaPitStop := scpsCancelado;
              pAtualizaStatus;
            End;
          finally
            FreeAndNil(ParamCancel);
            FreeAndNil(FParam);
          End;
        End
        Else
        Begin
          login := True;
          FParam := TParamBuscaCotacao.Create;
          Try
            FParam.idConsulta := ParamStr(2);
            qry.SQL.Clear;
            qry.SQL.Add('SELECT * FROM CONPIT WHERE CON_ID_CON = "'+FParam.idConsulta+'"');
            qry.Open;
            If not qry.IsEmpty Then
            Begin
              FStatusConsultaPitStop := TStatusBuscaCotacaoPitStop.fIntToStatusConsultaPitStop(qry.FieldByName('CON_STATUS').AsInteger);
              If (FStatusConsultaPitStop = scpsProcessando) Then
                FStatusConsultaPitStop :=  scpsPendente;
              If (FStatusConsultaPitStop = scpsProcessandoSegundaEtapa) Then
                FStatusConsultaPitStop :=  scpsPendenteSegundaEtapa;
              FStatusConsultaPitStopInicial := FStatusConsultaPitStop;
              FCodFor := qry.FieldByName('CON_CODFOR').AsString;
              FAutIncCotger := qry.FieldByName('CON_COTGER').AsString;
              processa;
            End;

          Finally
            FreeAndNil(RedePitStop);
            FreeAndNil(FParam);
          End;
        End;
      end;

    Except
      on e: Exception do
        TPitStopLog.RegistraLogExt(ParamStr(2), e.message, '[TBuscaCotacaoPitStop.processaRetorno]', True);
    End;

  End;

end;


end.
