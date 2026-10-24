unit untTTefMultiplus;

interface

uses untInterfacesMultiplus, System.Classes, System.Generics.Collections,
     IdTCPClient, IdStack, WinApi.ShellAPI;

type
  TTefMultiplus = class(TInterfacedObject, ITefMultiplus, ISubjectTEF)
  private
    FAguarda: Boolean;
    FObservers: TList<IObserverTEF>;

    FCnpjCliente : String;
    FCnpParceiro : String;
    FPathConector : String;
    TCPClient : TIdTCPClient;

    FRetorno : IRetornoTEF;
    FProcessaRetorno: IProcessaRetornoTEF;

    FUsaRetornoCon : Boolean;

    FExecutarLog : Boolean;

    FTeste : Boolean;

    FCaptura : string;

    const RETORNO : String = 'RetornoCon.txt';
    const CONECTOR : String = 'ConectorTEF.exe';
    const PASTA_RETORNOCON : string = 'RetornoCon';
    procedure EnviaComandoInterna(intComando: Integer; AParcelas: String; ACupom: String; AValor: String;
                                  AControle: String=''; ACampoConfig: String=''; ACaptura: string='1');
    procedure AguardarExecucaoComandoTCP();
    procedure AguardarExecucaoComandoTXT();
    procedure pSalvaArquivoTeste;
  public
    constructor Create(ACnpjCliente, ACnpParceiro, APathConector, AHost: String;
      APort: Integer; blnUsaRetornoCon: Boolean; blnTeste: Boolean; strNsuHost: string='');
    destructor Destroy; override;

    { ITefMultiplus }
    procedure CreditoAvista(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure CreditoParceladoLoja(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure CreditoParceladoADM(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure Debito(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure CancelamentoEstorno(AParcelas: String; ACupom: String; AValor: String; AControle: String; ACaptura: string='1');
    procedure Reimpressao(AParcelas: String; ACupom: String; AValor: String; AControle: String='');
    procedure PagamentoContas(AParcelas: String; ACupom: String; AValor: String);
    procedure ConsultaCDC(AParcelas: String; ACupom: String; AValor: String);
    procedure ConsultaSaldoDebito(AParcelas: String; ACupom: String; AValor: String);
    procedure ConsultaSaldoCredito(AParcelas: String; ACupom: String; AValor: String);
    procedure ConfirmacaoUltimaVendaPendente(AParcelas, ACupom, AValor: String; AControle: String='');
    procedure DesfazerUltimaVendaPendente(AParcelas: String; ACupom: String; AValor: String; AControle: String='');
    procedure AdmFuncoesAdministrativas(AParcelas, ACupom, AValor: String);
    procedure Relatorios(AParcelas, ACupom, AValor: String);
    procedure AdmValorConfig(ACampoConfig: String);

    { ISubjectTEF }
    procedure AdicionaObserver(Observer: IObserverTEF);
    procedure RemoveObserver(Observer: IObserverTEF);
    procedure NotificaObservers();
  End;

implementation

uses Winapi.Windows, SysUtils, IdGlobal, IdException, untTRetornoTEF,
     untTProcessaRetornoTEF, untTProcessaRetornoTefTxt, DateUtils, untFuncoes;

{ TTefMultiplus }

constructor TTefMultiplus.Create(ACnpjCliente, ACnpParceiro, APathConector, AHost: String;
  APort: Integer; blnUsaRetornoCon: Boolean; blnTeste: Boolean; strNsuHost: string);
begin
  FObservers := TList<IObserverTEF>.Create;
  TCPClient := TIdTCPClient.Create;

  FCnpjCliente := ACnpjCliente;
  FCnpParceiro := ACnpParceiro;
  FPathConector := IncludeTrailingPathDelimiter(APathConector);
  FAguarda := False;
  FUsaRetornoCon := blnUsaRetornoCon;

  FRetorno := TRetornoTEF.Create;

  FExecutarLog := True;
  FTeste := blnTeste;
  FCaptura := '';

  if (FUsaRetornoCon) then
    FProcessaRetorno := TProcessaRetornoTefTxt.Create(FRetorno, strNsuHost)
  else
    FProcessaRetorno := TProcessaRetornoTefTcp.Create(FRetorno, strNsuHost);

  TcpClient.Host := AHost;
  TcpClient.Port := APort;
end;

procedure TTefMultiplus.EnviaComandoInterna(intComando: Integer; AParcelas,
  ACupom, AValor: String; AControle: String; ACampoConfig: String; ACaptura: string);
  Var
    Texto : String;
    threadAguarda : TThread;
begin
  If (FAguarda) Then
    Raise ExceptionLibTefMultiplus.Create('Já existe um comando em execução [TefMultiplus]');

  if (Not FTeste) then
  begin
    Texto := IntToStr(intComando) + SEPARADOR_PARAMETRO +
             FCnpjCliente         + SEPARADOR_PARAMETRO +
             FCnpParceiro         + SEPARADOR_PARAMETRO +
             AParcelas            + SEPARADOR_PARAMETRO +
             ACupom               + SEPARADOR_PARAMETRO +
             AValor               + SEPARADOR_PARAMETRO +
             ACaptura             + SEPARADOR_PARAMETRO +
             AControle            + SEPARADOR_PARAMETRO +
             ACampoConfig;

    If (Assigned(TCPClient.IOHandler)) And (Not TCPClient.IOHandler.InputBufferIsEmpty) Then
    Begin
      loG('Vai limpar Buffer e Desconectar.');
      TCPClient.IOHandler.InputBuffer.Clear();
      TCPClient.Disconnect();
    End;

    Try
      log('TCPClient.Connected: '+IIF(TCPClient.Connected, 'True', 'False'));
      log(Texto);
      TCPClient.Connect;
      log('vai enviar comando');
      TCPClient.Socket.WriteLn(Texto, IndyTextEncoding_OSDefault);
      log('enviou comando: ' + Texto);
    Except
      On E: EIdSocketError Do
      Begin
        log('Entrou no Except');
//        TCPClient.IOHandler.InputBuffer.Clear();
//        TCPClient.Disconnect();
        If fProcessExists(CONECTOR) Then
        Begin
          KillTask(CONECTOR);
          log('Matou o Conector');
        End;
//        WinExec(PAnsiChar(FPathConector+CONECTOR), SW_SHOWDEFAULT);
        ShellExecute(0, nil, PChar(FPathConector+CONECTOR), nil, nil, SW_SHOWDEFAULT);
        log('Executou o Conector');
        Sleep(1000);
        If fProcessExists(CONECTOR) Then
        Begin
          log('Vai tentar conectar novamente e reenviar.');
          TCPClient.Connect;
          log('vai enviar comando');
          TCPClient.Socket.WriteLn(Texto, IndyTextEncoding_OSDefault);
          log('enviou comando: ' + Texto);
        End;
      End;
    End;
  end;

//  If (intComando = OPERACAO_CONFIRMACAO_ULTIMA_VENDA_PENDENTE) Or
//     (intComando = OPERACAO_DESFAZER_ULTIMA_VENDA_PENDENTE) Then
//  Begin
//    log('FRetorno.StatusTEF.strStatus = 1, intComando = '+IntToStr(intComando));
//    FRetorno.StatusTEF.strStatus := '1';
//    Self.NotificaObservers;
//    Exit;
//  End;

  log('Vai Executar a Thread');

  if (FUsaRetornoCon) Or (FTeste) then
    threadAguarda := TThread.CreateAnonymousThread(AguardarExecucaoComandoTXT)
  else
    threadAguarda := TThread.CreateAnonymousThread(AguardarExecucaoComandoTCP);

  threadAguarda.Start();

  log('Executou a Thread');

end;

procedure TTefMultiplus.CancelamentoEstorno(AParcelas: String; ACupom: String; AValor: String; AControle: String;
     ACaptura: string);
begin
  FCaptura := ACaptura;
  EnviaComandoInterna(OPERACAO_CANCELAMENTO_ESTORNO, AParcelas, ACupom, AValor, AControle, '', ACaptura);
end;

procedure TTefMultiplus.DesfazerUltimaVendaPendente(AParcelas, ACupom,
  AValor: String; AControle: String);
begin
  EnviaComandoInterna(OPERACAO_DESFAZER_ULTIMA_VENDA_PENDENTE, AParcelas, ACupom, AValor, AControle);
end;

procedure TTefMultiplus.ConfirmacaoUltimaVendaPendente(AParcelas, ACupom, AValor: String; AControle: String);
begin
  EnviaComandoInterna(OPERACAO_CONFIRMACAO_ULTIMA_VENDA_PENDENTE, AParcelas, ACupom, AValor, AControle);
end;

procedure TTefMultiplus.ConsultaCDC(AParcelas, ACupom,
  AValor: String);
begin
  EnviaComandoInterna(OPERACAO_CONSULTA_CDC, AParcelas, ACupom, AValor);
end;

procedure TTefMultiplus.ConsultaSaldoCredito(AParcelas, ACupom,
  AValor: String);
begin
  EnviaComandoInterna(OPERACAO_CONSULTA_SALDO_CREDITO, AParcelas, ACupom, AValor);
end;

procedure TTefMultiplus.ConsultaSaldoDebito(AParcelas, ACupom,
  AValor: String);
begin
  EnviaComandoInterna(OPERACAO_CONSULTA_SALDO_DEBITO, AParcelas, ACupom, AValor);
end;

procedure TTefMultiplus.CreditoAvista(AParcelas: String; ACupom: String;
  AValor: String; ACaptura: String);
begin
  FCaptura := ACaptura;
  EnviaComandoInterna(OPERACAO_CREDITO_A_VISTA, AParcelas, ACupom, AValor, '', '', ACaptura);
end;

procedure TTefMultiplus.Debito(AParcelas: String; ACupom: String;
  AValor: String; ACaptura: String);
begin
  FCaptura := ACaptura;
  EnviaComandoInterna(OPERACAO_DEBITO, AParcelas, ACupom, AValor, '', '', ACaptura);
end;

procedure TTefMultiplus.PagamentoContas(AParcelas, ACupom,
  AValor: String);
begin
  EnviaComandoInterna(OPERACAO_PAGAMENTO_CONTAS, AParcelas, ACupom, AValor);
end;

procedure TTefMultiplus.pSalvaArquivoTeste;
  var
    stlTeste : TStringList;
begin
  stlTeste := TStringList.Create;
  try
    stlTeste.Add('S;1;TRANSAÇÃO ACEITA.');
    stlTeste.Add('C;1234;002;VISA;REDE;625945;12345;10;01');
    stlTeste.Add('I;                CIELO                     ');
    stlTeste.Add('I;         VISA CREDITO                     ');
    stlTeste.Add('I;      111111-9999-22/00                   ');
    stlTeste.Add('I;1a VIA - CLIENTE      AUT=999999          ');
    stlTeste.Add('I;DOC=000000    03/12/2018 17:55:37    ONL-D');
    stlTeste.Add('I;VENDA A CREDITO                           ');
    stlTeste.Add('I;VALOR:                    97,00           ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I; ******* SIMULADOR *******                ');
    stlTeste.Add('I; 06001901015                              ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I; ******* SIMULADOR *******                ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I;                CIELO                     ');
    stlTeste.Add('I;             VISA CREDITO                 ');
    stlTeste.Add('I;          111111-9999-22/00               ');
    stlTeste.Add('I;2a VIA - ESTABELECIMENTO  AUT=999999      ');
    stlTeste.Add('I;1111111111111111/POS=99999999             ');
    stlTeste.Add('I;DOC=000000    03/12/2018 17:55:37    ONL-D');
    stlTeste.Add('I;VENDA A CREDITO                           ');
    stlTeste.Add('I;VALOR:                    97,00           ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I;--------------------------------------    ');
    stlTeste.Add('I;           xxxxxxxxxxxxxxxxx              ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I; 06001901015                              ');
    stlTeste.Add('I;                                          ');
    stlTeste.Add('I; ******* SIMULADOR *******                ');
    stlTeste.Add('I;                                          ');
    stlTeste.SaveToFile(FPathConector + RETORNO);
  finally
    FreeAndNil(stlTeste);
  end;
end;

procedure TTefMultiplus.CreditoParceladoADM(AParcelas: String; ACupom: String;
  AValor: String; ACaptura: String);
begin
  FCaptura := ACaptura;
  EnviaComandoInterna(OPERACAO_CREDITO_PARCELADO_ADM, AParcelas, ACupom, AValor, '', '', ACaptura);
end;

procedure TTefMultiplus.CreditoParceladoLoja(AParcelas: String; ACupom: String;
  AValor: String; ACaptura: String);
begin
  FCaptura := ACaptura;
  EnviaComandoInterna(OPERACAO_CREDITO_PARCELADO_LOJA, AParcelas, ACupom, AValor, '', '', ACaptura);
end;

procedure TTefMultiplus.Reimpressao(AParcelas, ACupom,
  AValor: String; AControle: String);
begin
  EnviaComandoInterna(OPERACAO_REIMPRESSAO, AParcelas, ACupom, AValor, AControle);
end;

destructor TTefMultiplus.Destroy;
begin
  FreeAndNil(TCPClient);
  inherited;
end;

procedure TTefMultiplus.AdmFuncoesAdministrativas(AParcelas, ACupom,
  AValor: String);
begin
  EnviaComandoInterna(OPERACAO_ADM_FUNCOES_ADMINISTRATIVAS, AParcelas, ACupom, AValor);
end;

procedure TTefMultiplus.AdmValorConfig(ACampoConfig: String);
begin
  EnviaComandoInterna(OPERACAO_RETORNAR_VALOR_CONFIG, '0', '0', '0', '0', ACampoConfig);
end;

procedure TTefMultiplus.Relatorios(AParcelas, ACupom,
  AValor: String);
begin
  EnviaComandoInterna(OPERACAO_RELATORIOS, AParcelas, ACupom, AValor);
end;

procedure TTefMultiplus.AguardarExecucaoComandoTCP();
  Var
    strCmd : String;
begin
  FAguarda := True;
  Try
    Log('inicio...');

    While (TCPClient.Connected) Do
    Begin
      Try
        Log('before readln()...');
        strCmd := TcpClient.Socket.ReadLn(IndyTextEncoding_OSDefault);
        Log('after readln()...');

        Log('before Processar(): ' + strCmd);
        FProcessaRetorno.Processar(strCmd);
        Log('after Processar(): ' + strCmd);
      Except
        On E: EIdConnClosedGracefully Do
        Begin
          Log('fechando graciosamente');
          TCPClient.IOHandler.InputBuffer.Clear();
          TCPClient.Disconnect();
        End;
        On E: Exception Do
        Begin
          Log('exceção não tratada: [' + E.ClassName + '] Msg: [ ' + E.Message + ' ] ');
          If (Not TCPClient.IOHandler.InputBufferIsEmpty) Then
          Begin
            TCPClient.IOHandler.InputBuffer.Clear();
            TCPClient.Disconnect();
          End;
        End;
      End;

      Log('itera...');
    End;

    Log('fim da thread.');
  Finally
    FAguarda := False;
    Self.NotificaObservers();
  End;
end;

procedure TTefMultiplus.AguardarExecucaoComandoTXT;
  var
    intCnt : Integer;
    stlRetorno : TStringList;
    hraDtaIni : TDateTime;
    intMinutos: Integer;
begin
  log('inicio leitura con');
  if FCaptura = CAPTURA_CIELO_LIO then
    intMinutos := 4
  else
    intMinutos := 2;

  FAguarda := True;
  Try
    if FTeste then
      pSalvaArquivoTeste;

    hraDtaIni := nOw();
    Sleep(200);
    while (not FileExists(FPathConector + RETORNO)) do
    begin
      if (MinutesBetween(nOw, hraDtaIni) >= intMinutos) then
        raise ExceptionLibTefMultiplus.Create('Tempo de espera excedido.');

      Sleep(200);
    end;

    if FileExists(FPathConector + RETORNO) then
    begin
      stlRetorno := TStringList.Create;
      try
        try
          sleep(500);
          stlRetorno.LoadFromFile(FPathConector + RETORNO);

          Log('Conteudo do Arquivo de retorno:'+#13+stlRetorno.Text);

          for intCnt := 0 to Pred(stlRetorno.Count) do
          begin
            FProcessaRetorno.Processar(stlRetorno[intCnt]);
          end;
          try
            if (FRetorno.StatusTEF.strStatus = IntToStr(STATUS_MULTIPLUS_APROVADA)) and
               (FRetorno.DadosCartao.strTipoTransacao <> '99') and
               (not fEmptyStr(FRetorno.DadosCartao.strNumeroControle)) then
            begin
              if (Not DirectoryExists(FPathConector+PASTA_RETORNOCON)) Then
                CreateDir(FPathConector+PASTA_RETORNOCON);

              CopyFile(PChar(FPathConector + RETORNO),
                       PChar(FPathConector + PASTA_RETORNOCON + '\RetornoCon_' + FRetorno.DadosCartao.strNumeroControle), False);
            end;

            DeleteFile(PChar(FPathConector + RETORNO));
          except
          end;
        finally
          FreeAndNil(stlRetorno);
        end;
      except
        On E: Exception Do
        Begin
          raise ExceptionLibTefMultiplus.Create(Format('Erro ao processar retorno %s', [RETORNO]));
        End;
      end;
    end;
  finally
    FAguarda := False;
    Self.NotificaObservers();
    log('fim leitura con');
  end;
end;

procedure TTefMultiplus.AdicionaObserver(Observer: IObserverTEF);
begin
  FObservers.Add(Observer);
end;

procedure TTefMultiplus.NotificaObservers();
  Var
    Observer : IObserverTEF;
begin
  For Observer In FObservers Do
    Observer.Atualizar(FRetorno);
end;

procedure TTefMultiplus.RemoveObserver(Observer: IObserverTEF);
begin
  FObservers.Delete(FObservers.IndexOf(Observer));
end;

end.
