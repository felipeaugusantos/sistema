unit untEnviaEmailBoleto;

interface

uses
  Winapi.Windows, Forms, System.Classes, System.SysUtils, Dialogs, System.UITypes, System.strUtils,
  untTExtratoCobranca,untTProcessaBoletosMonitor,untTMonitorGeraBoletos;

  procedure pEnviaEmailBoleto;
  procedure pFinaliza(const strDescri: String);
  procedure pReimpressaoBoletoPDF(const strAutInc: String);
  procedure pIniciarAplicao;
  function  fExecutarAplicacaoParaReimpressaoPDF: Boolean;

  function ExecutandoAvisoDeDebito: Boolean;
  function ExecutandoExtratoCobranca: Boolean;
  procedure EnviaEmailAvisoDebito;
  procedure EnviaEmailExtratoCobranca;

  function ExecutandoGeraBoletos: Boolean;
  function ExecutandoCobrancaEletronica: Boolean;
  procedure GerarBoletos;
  procedure GerarCobrancasEletronicas;

implementation

uses
  untFuncoesSimples, untLogAut, untTEnvioEmailAutController;

function fExecutarAplicacaoParaReimpressaoPDF: Boolean;
var
  blnHabilitaReimpPDF: Boolean;
  blnParamReimpPDF: Boolean;
Begin
  blnParamReimpPDF := (Not fEmptyStr(ParamStr(2))) And (ParamStr(2) = 'PDF');

  blnParamReimpPDF := blnParamReimpPDF And (Not fEmptyStr(ParamStr(3)));

  If Not blnParamReimpPDF Then
    Exit(False);

  Try
    blnHabilitaReimpPDF := fCfgSis('REIMPB', varBoolean);
  Except
    blnHabilitaReimpPDF := False;
  End;
  Result := blnParamReimpPDF And blnHabilitaReimpPDF;
End;

function ExecutandoAvisoDeDebito: Boolean;
Begin
  If ParamStr(2) <> 'ROBO_AVISO_DEBITO' Then
    Exit(False);

  If Not fCfgSis('AVIDEB', varBoolean) Then
    Exit(False);

  Result := True;
End;

function ExecutandoExtratoCobranca: Boolean;
Begin
  If ParamStr(3) <> 'ROBO_ENVIO_EXTRATO_COBRANCA' Then
    Exit(False);

  Result := True;
End;

procedure pIniciarAplicao;
Begin
  Try
    pDefinirEmpresa;
    pConectarModulos;
    pDefinirUsuario;
    pIniciarVariaveis;
    fAjustaDataSistema;

    VS_strUrlSms := fCfgSis('URLSMS', varString);
    VS_strUsrSms := fCfgSis('USRSMS', varString);
    VS_strSenSms := fCfgSis('SENSMS', varString);
    VS_strRemSms := fCfgSis('REMSMS', varString);
    VS_VersaoTLSSSL      := fCfgSis('TLSSSL');
    VS_ModeSSL           := fCfgSis('MODSSL');
    VS_strRazSoc := fCadEmp('NOMEMP');
    VS_strTxjCni    := fArqIni(0, 'GERAL', 'TXJCNI', '');
    VS_PathAutCom := ExtractFilePath(Application.ExeName);

    Try
      TLogAut.New().pLogin();
      If fExecutarAplicacaoParaReimpressaoPDF Then
         pReimpressaoBoletoPDF(ParamStr(3))
      Else If ExecutandoAvisoDeDebito Then
        EnviaEmailAvisoDebito
      Else If ExecutandoExtratoCobranca Then
        EnviaEmailExtratoCobranca
      Else If ExecutandoGeraBoletos Then
        GerarBoletos
      Else If ExecutandoCobrancaEletronica Then
        GerarCobrancasEletronicas
      Else
        pEnviaEmailBoleto;
    Finally
      If ExecutandoCobrancaEletronica Then
        pFinaliza('DISPARO_COBRANCA_ELETRONICA_AUTOMATICO')
      Else
        pFinaliza('ENVIO_EMAIL_BOLETO_AUTOMATICO');
    End;

  Except
    On E: Exception Do
    Begin
      If Not fConexaoAtiva Then
        MessageDlg(E.Message, mtError, [mbOK], 0);

      If ExecutandoCobrancaEletronica Then
        pFinaliza('DISPARO_COBRANCA_ELETRONICA_AUTOMATICO')
      Else
        pFinaliza('ENVIO_EMAIL_BOLETO_AUTOMATICO');
    End;
  End;
End;

procedure pEnviaEmailBoleto;
var
  objEnvioEmailAutomatico: TEmailAutController;
begin
  If Not VS_PermitidoEnviarEmail Then
    Exit;

  Try
    Try
      objEnvioEmailAutomatico := TEmailAutController.Create;
      Try
        objEnvioEmailAutomatico.pEnviarEmails;
      Finally
        FreeAndNil(objEnvioEmailAutomatico);
      End;
    Except
      On E: Exception Do
      Begin
        If Not fConexaoAtiva Then
          MessageDlg(E.Message, mtError, [mbOK], 0);
        pFinaliza('ENVIO_EMAIL_BOLETO_AUTOMATICO');
      End;
    End;
  Finally

  End;

end;

procedure pReimpressaoBoletoPDF(const strAutInc: String);
var
  objEnvioEmailAutomatico: TEmailAutController;
begin
  Try
    Try
      objEnvioEmailAutomatico := TEmailAutController.Create;
      Try
        objEnvioEmailAutomatico.fGerarBoletoPDF(strAutInc);
      Finally
        FreeAndNil(objEnvioEmailAutomatico);
      End;
    Except
      On E: Exception Do
      Begin
        If Not fConexaoAtiva Then
          MessageDlg(E.Message, mtError, [mbOK], 0);
        pFinaliza('REIMPRESSAO_PDF_BOLETO_MONITOR');
      End;
    End;

  Finally
    pFinaliza('REIMPRESSAO_PDF_BOLETO_MONITOR');
  End;
end;

procedure EnviaEmailAvisoDebito;
  Var
    LEnvioEmailAutomatico: TEmailAutController;
begin
  Try
    If Not VS_PermitidoEnviarEmail Then
      Exit;

    Try
      LEnvioEmailAutomatico := TEmailAutController.Create;

      Try
        LEnvioEmailAutomatico.EnviaAvisosDeDebitos;
      Finally
        FreeAndNil(LEnvioEmailAutomatico);
      End;
    Except
      On E: Exception Do
      Begin
        If Not fConexaoAtiva Then
          pGravarErro(True, E.Message, fRetornaStack);
      End;
    End;

  Finally
    pFinaliza('AVISO_DEBITO_MONITOR');
  End;
End;


procedure EnviaEmailExtratoCobranca;
  Var
    LEnvioEmailAutomatico: TEmailAutController;
    LMonitorExtratoCobranca : TMonitorExtratoCobranca;
    LIDMonitor : String;
begin
  Try
    Try
      LEnvioEmailAutomatico := TEmailAutController.Create;
      LMonitorExtratoCobranca := TMonitorExtratoCobranca.Create;

      Try
        LEnvioEmailAutomatico.EnviaExtratosCobrancas;
      Finally
        FreeAndNil(LEnvioEmailAutomatico);
      End;
    Except
      On E: Exception Do
      Begin
        If Not fConexaoAtiva Then
          pGravarErro(True, E.Message, fRetornaStack);
      End;
    End;

  Finally
    LIDMonitor := untTExtratoCobranca.MonitorExtratoCobranca.ID_MONITOR;
    LIDMonitor := Format(LIDMonitor, [ParamStr(1), ParamStr(2)]);
    FreeAndNil(LMonitorExtratoCobranca);

    pFinaliza(LIDMonitor);
  End;
End;


procedure pFinaliza(const strDescri: String);
begin
  fLock_Unlock(strDescri,
               False,
               False,
               False,
               '',
               False,
               strDescri);

  TLogAut.New().pLogout();
    pFinalizarModulos;

  If Not TerminateProcess(GetCurrentProcess, 0) Then
    Application.Terminate;
end;

procedure GerarBoletos;
  Var
    LProcessaBoletosMonitor : TProcessaBoletosMonitor;
    LIDMonitor : String;
begin
  Try
    Try

      LProcessaBoletosMonitor := TProcessaBoletosMonitor.Create;
      LProcessaBoletosMonitor.GerarBoletosPendentes;

    Except
      On E: Exception Do
      Begin
        If Not fConexaoAtiva Then
          pGravarErro(True, E.Message, fRetornaStack);
      End;
    End;

  Finally
    LIDMonitor := untTMonitorGeraBoletos.TMonitorGeraBoletos.ID_MONITOR;
    LIDMonitor := Format(LIDMonitor, [ParamStr(1), ParamStr(2)]);
    FreeAndNil(LProcessaBoletosMonitor);

    pFinaliza(LIDMonitor);
  End;
End;


function ExecutandoGeraBoletos: Boolean;
Begin
  If ParamStr(3) <> 'MONITOR_GERA_BOLETOS' Then
    Exit(False);

  Result := True;
End;

function ExecutandoCobrancaEletronica: Boolean;
Begin
  Result := (ParamStr(2) = 'COBRANCA_ELETRONICA');
End;

procedure GerarCobrancasEletronicas;
var
  objEnvioEmailAutomatico: TEmailAutController;
begin
  If Not VS_PermitidoEnviarEmail Then
    Exit;

  Try
    Try
      objEnvioEmailAutomatico := TEmailAutController.Create;
      Try
        objEnvioEmailAutomatico.pDisparosCobrancaEletronica;
      Finally
        FreeAndNil(objEnvioEmailAutomatico);
      End;
    Except
      On E: Exception Do
      Begin
        If Not fConexaoAtiva Then
          MessageDlg(E.Message, mtError, [mbOK], 0);

        pFinaliza('DISPARO_COBRANCA_ELETRONICA_AUTOMATICO');
      End;
    End;
  Finally
  End;
end;

end.
