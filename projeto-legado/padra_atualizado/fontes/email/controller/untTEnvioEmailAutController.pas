unit untTEnvioEmailAutController;

interface

Uses untFuncoesSimples, untBoleto, System.Classes, untTypesSistema,
     System.Generics.Collections, System.SysUtils, System.Generics.Defaults,
     Uni, untCadRec, Vcl.Forms, StrUtils, DateUtils, untDisparaSMSAut,
     Data.DB, UniCLientDataSet, untTLockMonitorEnvioBoleto, untTMostraDebCtrChq2,
     untTExtratoCobranca, System.IOUtils, untTFuncoesAvisosDeCobranca,
     System.Variants, System.Math;

Type
  TEmailAutController = class
  private
    objLock: TLock;
    LChaLck : String;

    FModelosDeveEnviar: TDeveEnviar;

    FDatasetBlackList: TUniCLientDataSet;

    class var FDatasFiltro: TStringList;
    class var FDatasFiltroUtil: TStringList;

    procedure SetChaveLckaTc(AValor: String);
    function  GetChaveLckaTc: String;

    function ExisteModeloEmailOuSMSOuWhatsappAtivo(ACodigoModelo: String): Boolean;
    function ExisteModeloEmailOuSMSOuWhatsappAtivoAD(ACodigoModelo: String): Boolean;
    function ExisteModeloEmailOuSMSOuWhatsappAtivoET(ACodigoModelo: String): Boolean;

    function EnviouEmaileSMSeWhatsapp(AEnviouEmail, AEnviouSMS, AEnviouWPP: Boolean): Boolean;

    function EnviaEmailsConformeOModo(ADuplicata: TDataset;
                                      ADuplicataObj: TArrDupCtr;
                                      AStatusEmail: TStatusDisparaEmail;
                                      out AEnviouEmail: Boolean;
                                      out AEnviouSMS: Boolean;
                                      out AEnviouWPP: Boolean): Boolean;

    function EnviarEmailAutomaticoDuplicatas(ADuplicataObj: TArrDupCtr;
                                             AStatusEmail: TStatusDisparaEmail;
                                             AEmailsCliente: String;
                                             out AEnviouEmail: Boolean;
                                             out AEnviouSMS: Boolean;
                                             out AEnviouWPP: Boolean): Boolean;

    procedure RetornaDadosAtualizadosDuplicata(out ADtaEma: TDateTime;
                                               out ADtaSMS: TDateTime;
                                               out ADtaWpp: TDateTime;
                                               out ADtaRec: String;
                                               out APorRec: String;
                                               AAutoIncrem: String);

    function RetornaDataDoEnvio(AValorCampo, AVencimento: TDateTime; AEnviou: Boolean; AStatus: TStatusDisparaEmail): Variant;

    Function JaRealizouOEnvio(AValorCampo, AVencimento: TDateTime; AStatus: TStatusDisparaEmail): Boolean;
    function DuplicataEmUsoPorOutraEstacao: Boolean;
    procedure LiberaDuplicata;
    Function fRetornaCdsPortadorAut(intTip : Integer; ACodGru, ACodCfg, ACodEmp : String ): TUniClientDataSet;

    function EmailValido(AEmailsCliente: String): Boolean;

    function RetornaTodasAsEmpresas: String;
    function RetornaCheckBoxModeloAvisoDebito(ACheckBoxModelo: String): TCheckBoxMostraDebCtrChq2;
    function RetornaVariaveisAvisoDebito(ACodigoCliente: String): TVariaveisMostraDebCtrChq2;
    procedure EnviaEmailSMSWppAvisoDebito(var AEnviouEmail,
                                              AEnviouSMS,
                                              AEnviouWpp,
                                              AGerouErro: String;
                                              AMostraDebCtrChq2: TMostraDebCtrChq2);

    procedure EnviaEmailExtratoCobranca(var AEnviouEmail,
                                             AGerouErro: String;
                                             AExtrato: String);

    procedure ValidaSeEnviouAvisoDebito(var AEnviouEmail,
                                            AEnviouSMS,
                                            AEnviouWpp,
                                            AAutoincrem: String;
                                            ACodigoCliente,
                                            ACodigoModelo: String);

    procedure RetornaDadosParaValidacaoDuplicataEmail(out ADtaCad: TDateTime;
                                                      out ADtaVen: TDateTime;
                                                      out AEspDoc: String;
                                                      out ACartei: String;
                                                      out ACodEmp: String;
                                                      out ANosNum: String;
                                                      out ADtaBol: TDateTime;
                                                      out ALinhaDigitavel: String;
                                                          AAutoIncrem: String);

    Function fValidaOpcao01(ANosNum : String; ADtaBol : TDateTime; ALinhaDigitavel: String) : Boolean;
    Function fValidaOpcao02(ADataCad, ADataVen : TDateTime) : Boolean;
    Function fValidaOpcao03(AEspDoc, AStrSelec : String) : Boolean;

    Function fValidaRegrasDuplicatasEnvio( sAutoInc : String;
                                           Var AEnviouEmail,
                                               AEnviouSMS,
                                               AEnviouWPP,
                                               AAtualizaDataEmail,
                                               AAtualizaDataSms,
                                               AAtualizaDataWpp: Boolean): Boolean;

    Function fValidaEnvioDuplicataEmail(sTipo : String; sAutoinc : String) : Boolean;

    Function fCarregaTabDupEmailDuplicatas(ADuplicataObj: TArrDupCtr) : TArrDupTabelaEmail;

    class function ExistemRegistrosASeremEnviados(ACodigoModelo, ATipoModelo: String): Boolean;

    class function ModeloPossuiTodasAsCfgsEmailFixo(ADatasetModelo: TDataset): Boolean;

    procedure IniciaDatasetBlackList;

    class procedure SeparaDatasParaFiltro;
  public
    Destructor Destroy; override;
    procedure pEnviarEmails;

    class function fAtingiuLimiteEnvioEmailsPorHoraProvedor(ADuplicataObj: TArrDupCtr): Boolean;

    class function fExisteModeloEmailConfiguradoOuAtivado: Boolean;
    class function ExisteModeloDeSMSAtivo: Boolean;
    class function ExisteModeloDeWhatsappAtivo: Boolean;
    class function fExistemBoletosASeremEnviados: Boolean;

    class function ExisteOModeloAvisoDebitoAtivo(ACodigoModelo: String): Boolean;

    class function fExistemConbrancasEletronicasASeremEnviadas(
      const ACondicaoVerificar: Boolean): Boolean;

    class procedure CarregarModelosAvisosCobrancaEmailSMSWppAtivos;

    procedure pEnviaEmailSmsLinkPagamento;
    function fGerarBoletoPDF(const strAutInc: String): String;

    function DadosCadastroClienteInvalidos(ADuplicata: TDataset;
                                           Var AEnviouEmail,
                                               AEnviouSMS,
                                               AEnviouWPP,
                                               AAtualizaDataEmail,
                                               AAtualizaDataSms,
                                               AAtualizaDataWpp: Boolean): Boolean;

    procedure EnviaAvisosDeDebitos;
    procedure EnviaExtratosCobrancas;

    procedure AtualizarTabelaMonitoramento(ADadosEmail: TDadosDisparaEmail;
                                           ADadosSMS: TDadosDisparaSMS;
                                           AEnviouEmail,
                                           AEnviouSMS,
                                           AEnviouWpp: String;
                                           AAutoIncremMonitor: String);
    function RetornaCamposMonitoramentoEmail(ADadosEmail: TDadosDisparaEmail;
                                             AEnviouEmail: String;
                                             var AEnviouTudo: Boolean): String;
    function RetornaCamposMonitoramentoSMSWpp(ADadosSMS: TDadosDisparaSMS;
                                              AEnviouSMS,
                                              AEnviouWpp: String;
                                              Var AEnviouTudo: Boolean): String;

    procedure pDisparosCobrancaEletronica;
  protected
    constructor Create;

    //Seguir essa lógica de sequência
    Const
      MODELOS_AVISO: Array[0..20] Of String = ('022', //30 Dias Vencido
                                               '015', //10 Dias Vencido
                                               '014', //9 Dias Vencido
                                               '011', //8 Dias Vencido
                                               '013', //7 Dias Vencido
                                               '012', //6 Dias Vencido
                                               '003', //5 Dias Vencido
                                               '010', //4 Dias Vencido
                                               '002', //3 Dias Vencido
                                               '009', //2 Dias Vencido
                                               '008', //1 Dia Vencido

                                               '004', //1 Dia A Vencer
                                               '001', //2 Dias A Vencer
                                               '005', //3 Dias A Vencer
                                               '006', //4 Dias A Vencer
                                               '007', //5 Dias A Vencer
                                               '016', //6 Dias A Vencer
                                               '018', //7 Dias A Vencer
                                               '019', //8 Dias A Vencer
                                               '020', //9 Dias A Vencer
                                               '021'  //10 Dias A Vencer
                                               );

    procedure EnviaEmailBoletoModelo(ACodigoModelo: String);

    function  fExecutadoPorRobo: Boolean;
  end;



implementation

Uses untDisparaEmailAut, untFuncoes;

{ TEmailAutController }

procedure TEmailAutController.AtualizarTabelaMonitoramento(
  ADadosEmail: TDadosDisparaEmail; ADadosSMS: TDadosDisparaSMS; AEnviouEmail,
  AEnviouSMS, AEnviouWpp: String; AAutoIncremMonitor: String);
  Var
    LAtualiza: TUniQuery;

    LSQL,
    LSQLCampos: String;

    LEnviouTudo: Boolean;
begin
  LSQL := 'UPDATE ENVAVI_DEB SET ';

  LEnviouTudo := True;

  LSQLCampos := RetornaCamposMonitoramentoEmail(ADadosEmail, AEnviouEmail, LEnviouTudo) +
                RetornaCamposMonitoramentoSMSWpp(ADadosSMS, AEnviouSMS, AEnviouWpp, LEnviouTudo);

  If Not LEnviouTudo Then
  Begin
    If LSQLCampos.IsEmpty Then
      Exit;
  End;

  LSQL := LSQL + ' AVI_ENVIAR="' + IIF(LEnviouTudo, 'N', 'S') + '",' +
                 LSQLCampos;

  LSQL := LeftStr(LSQL, LSQL.Length - 1) + ' WHERE AUTOINCREM="' + AAutoIncremMonitor + '"';

  LAtualiza := fCriaQuery;
  Try
    fStartTransaction;
    LAtualiza.SQL.Text := LSQL;
    LAtualiza.ExecSQL;
    fCommit;
  Finally
    FreeAndNil(LAtualiza)
  End;
end;

class procedure TEmailAutController.CarregarModelosAvisosCobrancaEmailSMSWppAtivos;
  Var
    LConsulta: TUniQuery;
begin
  If Assigned(VS_ModelosAvisosEmailAtivado) Then
    Exit;

  VS_ModelosAvisosEmailAtivado := TStringList.Create;
  VS_ModelosAvisosSMSAtivado := TStringList.Create;
  VS_ModelosAvisosWPPAtivado := TStringList.Create;

  If Not fCfgSis('BOLAVI', varBoolean) Then
    Exit;

  LConsulta := fCriaQuery;
  Try
    If fCfgSis('EMASAI', VarString) = 'Ativado' Then
    Begin
      LConsulta.SQL.Text := 'SELECT CONCAT(EMA_CODGRU, EMA_CODIGO) AS MODELO, ' +
                            '       IFNULL(CFG_CODPRV, 0) AS PROVEDOR, ' +
                            '       IFNULL(CFG_EMAIL_, "") AS EMAIL, ' +
                            '       IFNULL(CFG_SENEMA, "") AS SENHA, ' +
                            '       IFNULL(CFG_EMALOG, "") AS LOGIN, ' +
                            '       IFNULL(PRV_USAOA2, "N") AS PROVEDOR_OAUTH2 ' +
                            'FROM EMASAI ' +
                            '  INNER JOIN MODEMA ON MOD_SEQGER = EMASAI.AUTOINCREM ' +
                            '  INNER JOIN CFGEMA ON CFG_SEQGER = EMASAI.AUTOINCREM ' +
                            '  LEFT  JOIN CADPRV ON PRV_CODPRV = CFG_CODPRV ' +
                            'WHERE EMA_CODGRU="009" ' +
                            '  AND EMA_CODEMP="' + VS_strCodEmp + '" ' +
                            '  AND EMA_STATUS="A" ' +
                            '  AND EMA_ENTSAI="S" ';

      LConsulta.Open;
      While Not LConsulta.Eof Do
      Begin
        If ModeloPossuiTodasAsCfgsEmailFixo(LConsulta) Then
          VS_ModelosAvisosEmailAtivado.Add(LConsulta.FieldByName('MODELO').AsString);

        LConsulta.Next;
      End;
    End;

    If (fCfgSis('SMSMKM', varBoolean)) Or
       ((Not fEmptyStr(fCfgSis('USRSMS', varString))) And
        (Not fEmptyStr(fCfgSis('SENSMS', varString)))) Then
    Begin
      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT CONCAT(SMS_CODGRU, SMS_CODIGO) AS MODELO ' +
                            'FROM SMSSAI ' +
                            'WHERE SMS_CODGRU="009" ' +
                            '  AND SMS_CODEMP="' + VS_strCodEmp + '" ' +
                            '  AND SMS_STATUS="A" ';

      LConsulta.Open;
      While Not LConsulta.Eof Do
      Begin
        VS_ModelosAvisosSMSAtivado.Add(LConsulta.FieldByName('MODELO').AsString);

        LConsulta.Next;
      End;
    End;

    If fCfgSis('UTIWPP', varBoolean) Then
    Begin
      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT CONCAT(WPP_CODGRU, WPP_CODIGO) AS MODELO ' +
                            'FROM WPPSAI ' +
                            'WHERE WPP_CODGRU="009" ' +
                            '  AND WPP_CODEMP="' + VS_strCodEmp + '" ' +
                            '  AND WPP_STATUS="A" ';

      LConsulta.Open;
      While Not LConsulta.Eof Do
      Begin
        VS_ModelosAvisosWPPAtivado.Add(LConsulta.FieldByName('MODELO').AsString);

        LConsulta.Next;
      End;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

constructor TEmailAutController.Create;
begin

end;

procedure TEmailAutController.pEnviarEmails;
  Var
    LModelo: String;
Begin

  inherited;

  Try
    pVerificaProCod;
    IniciaDatasetBlackList;
    SeparaDatasParaFiltro;

    For LModelo In MODELOS_AVISO Do
    Begin
      If ExisteModeloEmailOuSMSOuWhatsappAtivo(LModelo) Then
        EnviaEmailBoletoModelo(LModelo);
    End;

    LiberaDuplicata;
  Except
    On E: Exception Do
    Begin
      LiberaDuplicata;
      pGravarErro(True, E.Message);
    End;
  End;

  Sleep(40000);
end;

function TEmailAutController.RetornaCamposMonitoramentoEmail(
  ADadosEmail: TDadosDisparaEmail; AEnviouEmail: String;
  var AEnviouTudo: Boolean): String;
begin
  Result := EmptyStr;

  If Not FModelosDeveEnviar.Email Then
    Exit;

  If Not fEmailValido(ADadosEmail.strEmailCli, False) Then
    Exit('AVI_ENVEMA="N",AVI_ERRENV="EMAIL INVALIDO",');

  If AEnviouEmail = 'N' Then
  Begin
    AEnviouTudo := False;
    Exit;
  End;

  Result := 'AVI_ENVEMA=IF(AVI_ENVEMA="N", "S", AVI_ENVEMA),' +
            'AVI_DTAEMA=IF(AVI_DTAEMA IS NULL, CURRENT_TIMESTAMP, AVI_DTAEMA),';
end;

function TEmailAutController.RetornaCamposMonitoramentoSMSWpp(
  ADadosSMS: TDadosDisparaSMS; AEnviouSMS, AEnviouWpp: String;
  var AEnviouTudo: Boolean): String;
begin
  Result := EmptyStr;

  If fEmptyStr(ADadosSMS.strCelula) Then
    Exit('AVI_ENVSMS="N", AVI_ENVWPP="N",' +
         IIF(FModelosDeveEnviar.Whatsapp, 'AVI_ERRENV="CELULAR NÃO CADASTRADO",', EmptyStr));

  If FModelosDeveEnviar.SMS Then
  Begin
    If AEnviouSMS = 'S' Then
      Result := Result + 'AVI_ENVSMS=IF(AVI_ENVSMS="N", "S", AVI_ENVSMS),' +
                         'AVI_DTASMS=IF(AVI_DTASMS IS NULL, CURRENT_TIMESTAMP, AVI_DTASMS),'
    Else
      AEnviouTudo := False;
  End;

  If FModelosDeveEnviar.Whatsapp Then
  Begin
    If AEnviouWPP = 'S' Then
      Result := Result + 'AVI_ENVWPP=IF(AVI_ENVWPP="N", "S", AVI_ENVWPP),' +
                         'AVI_DTAWPP=IF(AVI_DTAWPP IS NULL, CURRENT_TIMESTAMP, AVI_DTAWPP),'
    Else
      AEnviouTudo := False;
  End;
end;

function TEmailAutController.RetornaCheckBoxModeloAvisoDebito(ACheckBoxModelo: String): TCheckBoxMostraDebCtrChq2;
begin
  Result.ContaCorrente := ACheckBoxModelo.Substring(0, 1) = 'S';
  Result.Produto := ACheckBoxModelo.Substring(1, 1) = 'S';
  Result.Cheque := ACheckBoxModelo.Substring(2, 1) = 'S';
  Result.Observacao := ACheckBoxModelo.Substring(3, 1) = 'S';
  Result.Juros := ACheckBoxModelo.Substring(4, 1) = 'S';
  Result.DocAg := ACheckBoxModelo.Substring(5, 1) = 'S';
  Result.DtaVen := ACheckBoxModelo.Substring(6, 1) = 'S';
  Result.AjuDta := ACheckBoxModelo.Substring(7, 1) = 'S';
  Result.EndEre := ACheckBoxModelo.Substring(8, 1) = 'S';
  Result.BancoDoBoleto := ACheckBoxModelo.Substring(9, 1) = 'S';
  Result.NumPedFF := ACheckBoxModelo.Substring(10, 1) = 'S';
  Result.Credito := ACheckBoxModelo.Substring(11, 1) = 'S';
end;

procedure TEmailAutController.RetornaDadosAtualizadosDuplicata(out ADtaEma,
  ADtaSMS, ADtaWpp: TDateTime; out ADtaRec, APorRec: String;
  AAutoIncrem: String);
  Var
    LConsulta: TUniQuery;
    LSql: String;
begin
  Try
    ADtaRec := '';
    LConsulta := fCriaQuery;

    LSql := '';
    LSql := LSql +'SELECT                      ';
    LSql := LSql +'  CTR_NUMDUP,               ';
    LSql := LSql +'  CTR_ESPDOC,               ';
    LSql := LSql +'  CTR_CODEMP,               ';
    LSql := LSql +'  CTR_CODCLI,               ';
    LSql := LSql +'  CTR_PARCEL,               ';
    LSql := LSql +'  CTR_DTAEMA,               ';
    LSql := LSql +'  CTR_DTASMS,               ';
    LSql := LSql +'  CTR_DTAREC,               ';
    LSql := LSql +'  CTR_CODPOR,               ';
    LSql := LSql +'  CTR_DTAWPP                ';
    LSql := LSql +'FROM                        ';
    LSql := LSql +'  CADREC                    ';
    LSql := LSql +'WHERE AUTOINCREM = :AUTOINC ';

    Try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Add(LSql);
      LConsulta.ParamByName('AUTOINC').AsString := AAutoIncrem;

      LConsulta.Open;
    Except
      On E : Exception Do
      Begin
        pGravarErro(True, E.Message + '[TEmailAutController.RetornaDadosAtualizadosDuplicata]');
      End;
    End;

    If Not LConsulta.IsEmpty Then
    Begin
      If Not LConsulta.FieldByName('CTR_DTAEMA').AsString.IsEmpty Then
        ADtaEma := LConsulta.FieldByName('CTR_DTAEMA').AsDateTime;

      If Not LConsulta.FieldByName('CTR_DTASMS').AsString.IsEmpty Then
        ADtaSMS := LConsulta.FieldByName('CTR_DTASMS').AsDateTime;

      If Not LConsulta.FieldByName('CTR_DTAREC').AsString.IsEmpty Then
        ADtaRec := LConsulta.FieldByName('CTR_DTAREC').AsString;

      If Not LConsulta.FieldByName('CTR_CODPOR').AsString.IsEmpty Then
        APorRec := LConsulta.FieldByName('CTR_CODPOR').AsString;

      If Not LConsulta.FieldByName('CTR_DTAWPP').AsString.IsEmpty Then
        ADtaWpp := LConsulta.FieldByName('CTR_DTAWPP').AsDateTime;

      SetChaveLckaTc('CADREC' +
                     LConsulta.FieldByName('CTR_NUMDUP').AsString +
                     LConsulta.FieldByName('CTR_ESPDOC').AsString +
                     LConsulta.FieldByName('CTR_CODEMP').AsString +
                     LConsulta.FieldByName('CTR_CODCLI').AsString +
                     LConsulta.FieldByName('CTR_PARCEL').AsString);
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TEmailAutController.RetornaDataDoEnvio(AValorCampo,
  AVencimento: TDateTime; AEnviou: Boolean;
  AStatus: TStatusDisparaEmail): Variant;
  Var
    LAlteraCampo: Boolean;
begin
  Result := Null;
  If AValorCampo > 0 Then
    Result := AValorCampo;

  If Not AEnviou Then
    Exit;

  If AValorCampo = 0 Then
    Exit(VS_Date);

  LAlteraCampo := False;

  Case AStatus Of
    sta1DiaVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -1);
    sta2DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -2);
    sta3DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -3);
    sta4DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -4);
    sta5DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -5);
    sta6DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -6);
    sta7DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -7);
    sta8DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -8);
    sta9DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -9);
    sta10DiasVencer: LAlteraCampo := AValorCampo < IncDay(AVencimento, -10);

    sta1DiaVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 1);
    sta2DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 2);
    sta3DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 3);
    sta4DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 4);
    sta5DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 5);
    sta8DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 8);

    sta6DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 6);
    sta7DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 7);
    sta9DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 9);
    sta10DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 10);
    sta30DiasVencido: LAlteraCampo := AValorCampo < IncDay(AVencimento, 30);
  End;

  If LAlteraCampo Then
    Result := VS_Date;
end;

function TEmailAutController.RetornaTodasAsEmpresas: String;
  Var
    LConsulta: TUniQuery;
begin
  Result := EmptyStr;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + LConsulta.FieldByName('EMP_CODEMP').AsString + '_';

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TEmailAutController.RetornaVariaveisAvisoDebito(
  ACodigoCliente: String): TVariaveisMostraDebCtrChq2;
begin
  Result.RedeLoja := EmptyStr;
  Result.TipoFiltro := 'A';
  Result.CodigoCliente := ACodigoCliente;
  Result.CodigoPortador := EmptyStr;
  Result.MensagemRelatorio := EmptyStr;
  Result.DataInicial := DateToStr(IncDay(fRetDataServidor, (fCfgSis('DIADEB', varInteger) + 1) * -1));
  Result.DataFinal := DateToStr(IncDay(fRetDataServidor, -1));
  Result.ConsideraRepassados := fCfgSis('CHQNVT', varBoolean);
  Result.Vencidos := False;
  Result.GerarDatasetChequesRobo := True;
  Result.ExecutandoPeloRobo := True;

  Result.MensagemRelatorio := 'ATENÇÃO: As duplicatas listadas nesse relatório possuem o vencimento no período de ' +
                              Result.DataInicial + ' até ' + Result.DataFinal + '.' + #13 +
                              'Duplicatas com vencimentos fora desse período não estão sendo listadas.';

  Result.cdsTemporaria2 := TUniClientDataset.Create(Nil);
end;

class procedure TEmailAutController.SeparaDatasParaFiltro;
  Var
    LDataAtual,
    LDataDiaAnterior : TDateTime;
begin
  FDatasFiltro := TStringList.Create;
  LDataAtual := fRetDataServidor;
  FDatasFiltro.Add(FormatDateTime('yyyy-mm-dd', LDataAtual));

  //LDataInicial := LDataAtual;

  If Not fCfgSis('AVIFDS', varBoolean) Then
    Exit;

  LDataAtual := IncDay(LDataAtual, -1);
  While fDiaDeFolga(LDataAtual) Do
  Begin
    FDatasFiltro.Add(FormatDateTime('yyyy-mm-dd', LDataAtual));

    LDataAtual := IncDay(LDataAtual, -1);
  End;

  //Enviar boletos de cobrança Sábado/Domingo/Feriado? E Tolerancia for mior do que 0;
  If (Not fCfgSis('AVIUTI', varBoolean)) And (fCfgSis('AVITOL', varInteger) > 0) Then
  Begin

     FDatasFiltroUtil := TStringList.Create;
     LDataAtual := fRetDataServidor;
     FDatasFiltroUtil.Add(FormatDateTime('yyyy-mm-dd', LDataAtual));

     LDataDiaAnterior := LDataAtual;
     LDataDiaAnterior := IncDay(LDataDiaAnterior, -2);

     LDataAtual := IncDay(LDataAtual, -1);

     //se 1 dia antes da data atual não foi feriado
     If Not fDiaDeFolga(LDataAtual) Then
     Begin

        //Verifica se 2 dias antes da data atual foi feriado
        If fDiaDeFolga(LDataDiaAnterior) Then
        Begin
          FDatasFiltroUtil.Add(FormatDateTime('yyyy-mm-dd', LDataAtual));
          FDatasFiltroUtil.Add(FormatDateTime('yyyy-mm-dd', LDataDiaAnterior));
          LDataAtual := IncDay(LDataAtual, -2);
        End;

     End;

     While fDiaDeFolga(LDataAtual) Do
     Begin
       FDatasFiltroUtil.Add(FormatDateTime('yyyy-mm-dd', LDataAtual));
       LDataAtual := IncDay(LDataAtual, -1);
     End;

     FDatasFiltro := FDatasFiltroUtil;

  End;

end;

procedure TEmailAutController.SetChaveLckaTc(AValor: String);
begin
  LChaLck := AValor;
end;

procedure TEmailAutController.ValidaSeEnviouAvisoDebito(var AEnviouEmail,
  AEnviouSMS, AEnviouWpp, AAutoincrem: String; ACodigoCliente, ACodigoModelo: String);
  Var
    LConsulta: TUniQuery;

    LAnoMes: String;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM, AVI_ENVEMA, AVI_ENVSMS, AVI_ENVWPP ' +
                          'FROM ENVAVI_DEB ' +
                          'WHERE AVI_DTAMOD BETWEEN :DTAIN AND :DTAFIN';

    LConsulta.SQL.Add(' AND AVI_CODCLI="' + ACodigoCliente + '"');

    LAnoMes := FormatDateTime('yyyy/mm', fRetDataServidor);

    LConsulta.ParamByName('DTAIN').AsString := LAnoMes + '/01';
    LConsulta.ParamByName('DTAFIN').AsString := LAnoMes + '/15';
    If ACodigoModelo = '002' Then
    Begin
      LConsulta.ParamByName('DTAIN').AsString := LAnoMes + '/16';
      LConsulta.ParamByName('DTAFIN').AsString := LAnoMes + '/' + DaysInAMonth(StrToInt(LeftStr(LAnoMes, 4)),
                                                                               StrToInt(RightStr(LAnoMes, 2))).ToString;
    End;

    LConsulta.Open;

    AEnviouEmail := LConsulta.FieldByName('AVI_ENVEMA').AsString;
    AEnviouSMS := LConsulta.FieldByName('AVI_ENVSMS').AsString;
    AEnviouWPP := LConsulta.FieldByName('AVI_ENVWPP').AsString;
    AAutoIncrem := LConsulta.FieldByName('AUTOINCREM').AsString;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TEmailAutController.EmailValido(AEmailsCliente: String): Boolean;
  Var
    LEmail: String;

    LContador: Integer;

    LListaEmails: TStringList;

    LExisteEmailInvalido: Boolean;
begin
  Result := True;

  LExisteEmailInvalido := False;

  Try
    LListaEmails := TStringList.Create();
    LListaEmails.Delimiter := ';';
    LListaEmails.StrictDelimiter := True;

    While RightStr(AEmailsCliente, 1) = ';' Do
      AEmailsCliente := LeftStr(AEmailsCliente, AEmailsCliente.Length - 1);

    LListaEmails.DelimitedText := AEmailsCliente;

    LContador := 0;
    While LContador < LListaEmails.Count Do
    Begin
      If LListaEmails[LContador].Trim.IsEmpty Then
        LListaEmails.Delete(LContador)
      Else
        Inc(LContador);
    End;

    For LEmail In LListaEmails Do
    Begin
      If Not fEnderecoEmailValido(LEmail.Trim) Then
        LExisteEmailInvalido := True;
    End;

    If LListaEmails.Count = 0 Then
      Exit(False);

    If LExisteEmailInvalido Then
      Exit(False);
  Finally
    FreeAndNil(LListaEmails);
  End;
end;

function TEmailAutController.DadosCadastroClienteInvalidos(
  ADuplicata: TDataset; var AEnviouEmail, AEnviouSMS, AEnviouWPP,
  AAtualizaDataEmail, AAtualizaDataSms, AAtualizaDataWpp: Boolean): Boolean;
  Var
    LConsulta: TUniQuery;

    LNumeroCelular: String;
begin
  LConsulta := fCriaQuery;

  Result := False;

  Try
    LConsulta.SQL.Text := 'SELECT C.CLI_CELULA, ' + RetornaSQLEmailCliente + ' ' +
                          'FROM CADCLI C ' +
                          'WHERE C.CLI_CODCLI="' + ADuplicata.FieldByName('CTR_CODCLI').AsString + '"';
    LConsulta.Open;

    If FModelosDeveEnviar.Email Then
    Begin
      If Not EmailValido(LConsulta.FieldByName('CTR_EMACLI').AsString) Then
      Begin
        AEnviouEmail := True;
        AAtualizaDataEmail := False;

        fStartTransaction;
        untCadRec.pGravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                               'ENVIO DE EMAIL ABORTADO - EMAIL INVÁLIDO',
                               'untTEnvioEmailAutController');
        fCommit;
      End
      Else If Not FDatasetBlackList.IsEmpty Then
      Begin
        FDatasetBlackList.Filter := 'BLK_CODCLI=' + ADuplicata.FieldByName('CTR_CODCLI').AsString.QuotedString;
        FDatasetBlackList.Filtered := True;

        FDatasetBlackList.First;
        While Not FDatasetBlackList.Eof Do
        Begin
          If LConsulta.FieldByName('CTR_EMACLI').AsString.Contains(FDatasetBlackList.FieldByName('BLK_EMAIL_').AsString) Then
          Begin
            AEnviouEmail := True;
            AAtualizaDataEmail := False;

            fStartTransaction;
            untCadRec.pGravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                                   'ENVIO DE EMAIL ABORTADO - EMAIL NA BLACKLIST',
                                   'untTEnvioEmailAutController');
            fCommit;

            Break;
          End;

          FDatasetBlackList.Next;
        End;

        FDatasetBlackList.Filtered := False;
      End;
    End;

    If FModelosDeveEnviar.SMS Or FModelosDeveEnviar.WhatsApp Then
    Begin
      LNumeroCelular := LConsulta.FieldByName('CLI_CELULA').AsString.Replace(' ', EmptyStr);

      If LNumeroCelular.Length <= 11 Then
        LNumeroCelular := '55' + LNumeroCelular;

      If LNumeroCelular.Length <= 11 Then
      Begin
        AEnviouSMS := True;
        AAtualizaDataSMS := False;

        AEnviouWPP := True;
        AAtualizaDataWpp := False;

        fStartTransaction;
        untCadRec.pGravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                               'ENVIO DE SMS/WHATSAPP ABORTADO - CELULAR INVÁLIDO',
                               'untTEnvioEmailAutController');
        fCommit;
      End;

      If (Not AEnviouWPP) And
       (Not fEnviaWhatsappParaCliente(ADuplicata.FieldByName('CTR_CODCLI').AsString)) Then
      Begin
        AEnviouWPP := True;
        AAtualizaDataWpp := (Not fEnviaWhatsappParaCliente(ADuplicata.FieldByName('CTR_CODCLI').AsString));

        fStartTransaction;
        untCadRec.pGravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                               'ENVIO DE SMS/WHATSAPP ABORTADO - CLIENTE CONFIGURADO PARA NÃO RECEBER WHATSAPP',
                               'untTEnvioEmailAutController');
        fCommit;
      End;

    End;

    If AEnviouEmail Then
    Begin
      If AEnviouSMS Then
        Exit(AEnviouWPP);
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

destructor TEmailAutController.Destroy;
begin
  inherited;
  LiberaDuplicata;
  If Assigned(objLock) Then
  Begin
    FreeAndNil(objLock);
  End;

  FreeAndNil(FDatasetBlackList);
end;

function TEmailAutController.DuplicataEmUsoPorOutraEstacao: Boolean;
begin
  Result := False;

  If Not Assigned(objLock) Then
  Begin
    objLock := TLock.Create;
  End;

  If Not objLock.fLock_Unlock(GetChaveLckaTc, True, False) Then
  Begin
    Result := True;
  End;
end;

procedure TEmailAutController.EnviaAvisosDeDebitos;
  Var
    LListaClientes: TStringList;

    LModelo,
    LSeqGerModeloEmail,
    LCheckBoxesEmail,
    LSeqGerModeloWpp,
    LCheckBoxesWpp,
    LCliente,

    LEnviouEmail,
    LEnviouSMS,
    LEnviouWpp,
    LErroEnvio: String;

    LTipo: Integer; //0-Email. 1-SMS. 2-WhatsApp.

    LMostraDebCtrChq2: TMostraDebCtrChq2;
begin
  Try
    IniciaDatasetBlackList;

    LModelo := TMostraDebCtrChq2.RetornaModeloEmail;

    If Not ExisteModeloEmailOuSMSOuWhatsappAtivoAD(LModelo) Then
      Exit;

    If Not TMostraDebCtrChq2.ExistemClientesComValoresEmAberto(fCfgSis('DIADEB', varInteger), LListaClientes) Then
      Exit;

    strEmpAcessoUsuarioLogado := RetornaTodasAsEmpresas;

    LMostraDebCtrChq2 := TMostraDebCtrChq2.Create;

    For LCliente In LListaClientes Do
    Begin
      If LMostraDebCtrChq2.EnviouTodosAvisosDebitosClientes(LModelo, LCliente) Then
        Continue;

      LMostraDebCtrChq2.CarregaOutrasVariaveis(RetornaVariaveisAvisoDebito(LCliente));

      LMostraDebCtrChq2.GerouRelEnvioEmail := False;
      LMostraDebCtrChq2.GerouRelEnvioWhats := False;

      LSeqGerModeloEmail := fCampoTabela('AUTOINCREM', 'EMASAI', ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_STATUS'], ['025', LModelo, 'A']);
      If Not LSeqGerModeloEmail.IsEmpty Then
      Begin
        LTipo := 0;
        LCheckBoxesEmail := fCampoTabela('MOD_REGREL', 'MODEMA', ['MOD_SEQGER'], [LSeqGerModeloEmail]);

        If Not LCheckBoxesEmail.IsEmpty Then
        Begin
          LMostraDebCtrChq2.SetCheckBoxSelecionados(RetornaCheckBoxModeloAvisoDebito(LCheckBoxesEmail));
          LMostraDebCtrChq2.GerarRelatorio(False,
                                           TMostraDebCtrChq2.RetornaAutoIncremDuplicatasEmAbertoCliente(fCfgSis('DIADEB', varInteger), LCliente, LTipo, LModelo),
                                           '',
                                           '');
        End;
      End;

      LSeqGerModeloWpp := fCampoTabela('AUTOINCREM', 'WPPSAI', ['WPP_CODGRU', 'WPP_CODIGO', 'WPP_STATUS'], ['025', LModelo, 'A']);
      If Not LSeqGerModeloWpp.IsEmpty Then
      Begin
        LTipo := 2;
        LCheckBoxesWpp := fCampoTabela('MOD_REGREL', 'MODWPP', ['MOD_SEQGER'], [LSeqGerModeloWpp]);

        If Not LCheckBoxesWpp.IsEmpty Then
        Begin
          LMostraDebCtrChq2.SetCheckBoxSelecionados(RetornaCheckBoxModeloAvisoDebito(LCheckBoxesWpp));
          LMostraDebCtrChq2.GerarRelatorio(False,
                                           TMostraDebCtrChq2.RetornaAutoIncremDuplicatasEmAbertoCliente(fCfgSis('DIADEB', varInteger), LCliente, LTipo, LModelo),
                                           '',
                                           '',
                                           True);
        End;
      End;

      If LMostraDebCtrChq2.GerouRelEnvioWhats or LMostraDebCtrChq2.GerouRelEnvioEmail Then
         EnviaEmailSMSWppAvisoDebito(LEnviouEmail,
                                     LEnviouSMS,
                                     LEnviouWpp,
                                     LErroEnvio,
                                     LMostraDebCtrChq2);
    End;
  Finally
    FreeAndNil(LListaClientes);
  End;
end;

procedure TEmailAutController.EnviaEmailExtratoCobranca(var AEnviouEmail,
  AGerouErro: String; AExtrato: String);
  Var
    LDadosEmail: TDadosDisparaEmail;
    LEnviaEmail: TEmaAut;
    LStatusModelo: TStatusDisparaEmail;
begin

  LStatusModelo := staNenhumaAcao;

  If FModelosDeveEnviar.Email Then
  Begin
    LEnviaEmail := TEmaAut.Create(Nil);
    Try
      LEnviaEmail.FOpcDoc := 'ET';
      LEnviaEmail.FCodGru := '027';
      LEnviaEmail.FCodigo := '001';

      LEnviaEmail.FStatus := LStatusModelo;

      LDadosEmail := untTExtratoCobranca.CarregaVariaveisEmail(AExtrato);

      LEnviaEmail.FNomCli   := fRetNomCliente(LDadosEmail.strCodCli);
      LEnviaEmail.FCodCli   := LDadosEmail.strCodCli;
      LEnviaEmail.FPriCli   := fRetPrimeiraPalavra(LEnviaEmail.FNomCli);
      LEnviaEmail.FCidCli   := fRetNomCidade(fRetCodCidByCliente(LDadosEmail.strCodCli));
      LEnviaEmail.FCodOpe   := strLoginUsuarioLogado;
      LEnviaEmail.FEmaCli   := LDadosEmail.strEmailCli;
      LEnviaEmail.FArquiv   := LDadosEmail.RecArquivos;
      LEnviaEmail.FArrDup   := LDadosEmail.arrDupTabela;
      LEnviaEmail.FCopiaOcultaRemetente := True;

      LEnviaEmail.FEnvAutCob := True;

      If LEnviaEmail.fEnviaEmailAutomatico(AEnviouEmail = 'N') Then
        AEnviouEmail := 'S';
    Finally
      FreeAndNil(LEnviaEmail);
    End;
  End;
end;

function TEmailAutController.EnviaEmailsConformeOModo(ADuplicata: TDataset;
  ADuplicataObj: TArrDupCtr; AStatusEmail: TStatusDisparaEmail;
  out AEnviouEmail, AEnviouSMS, AEnviouWPP: Boolean): Boolean;
  Var
    LAtingiuLimite : Boolean;
begin
  LAtingiuLimite := fAtingiuLimiteEnvioEmailsPorHoraProvedor(ADuplicataObj);

  If LAtingiuLimite Then
    AEnviouEmail := True;

  If EnviouEmaileSMSeWhatsapp(AEnviouEmail, AEnviouSMS, AEnviouWPP) Then
    Exit(False);

  If (Not ADuplicata.FieldByName('CTR_DTABOL').IsNull) And (Not ADuplicata.FieldByName('CTR_LINDIG').IsNull) Then
    Result := TBoleto.fEnviarEmailBoletoAutomatico(ADuplicataObj, AStatusEmail, AEnviouEmail, AEnviouSMS, AEnviouWPP)
  Else
    Result := EnviarEmailAutomaticoDuplicatas(ADuplicataObj, AStatusEmail, ADuplicata.FieldByName('CTR_EMACLI').AsString, AEnviouEmail, AEnviouSMS, AEnviouWPP);

  If LAtingiuLimite Then
    AEnviouEmail := False;
end;

procedure TEmailAutController.EnviaEmailSMSWppAvisoDebito(var AEnviouEmail,
  AEnviouSMS, AEnviouWpp, AGerouErro: String; AMostraDebCtrChq2: TMostraDebCtrChq2);
  Var
    LDadosEmail: TDadosDisparaEmail;
    LEnviaEmail: TEmaAut;

    LDadosSMS: TDadosDisparaSMS;
    LEnviaSMS: TSMSAut;

    LModelo,
    LAutoIncremMonitoramento: String;

    LStatusModelo: TStatusDisparaEmail;
    LCodigoCliente: String;
begin
  //Codigo do SMS está aqui, mas apenas para futura implementação;
  //Não possui campos nem forma de enviar o relatório por SMS até o momento

  LModelo := TMostraDebCtrChq2.RetornaModeloEmail;

  LCodigoCliente := AMostraDebCtrChq2.VariaveisEmail.strCodCli;
  If LCodigoCliente.IsEmpty Then
    LCodigoCliente := AMostraDebCtrChq2.VariaveisSMS.strCodCli;

  ValidaSeEnviouAvisoDebito(AEnviouEmail,
                            AEnviouSMS,
                            AEnviouWpp,
                            LAutoIncremMonitoramento,
                            LCodigoCliente,
                            LModelo);

  LStatusModelo := staNenhumaAcao;
  If LModelo = '002' Then
    LStatusModelo := staAvisoDebitoDia16;

  If AMostraDebCtrChq2.GerouRelEnvioEmail Then
  Begin

    If FModelosDeveEnviar.Email Then
    Begin
      LEnviaEmail := TEmaAut.Create(Nil);
      Try
        LEnviaEmail.FOpcDoc := 'AD';
        LEnviaEmail.FCodGru := '025';
        LEnviaEmail.FCodigo := LModelo;

        LEnviaEmail.FStatus := LStatusModelo;

        LDadosEmail := AMostraDebCtrChq2.VariaveisEmail;

        LEnviaEmail.FNomCli   := fRetNomCliente(LDadosEmail.strCodCli);
        LEnviaEmail.FCodCli   := LDadosEmail.strCodCli;
        LEnviaEmail.FPriCli   := fRetPrimeiraPalavra(LEnviaEmail.FNomCli);
        LEnviaEmail.FCidCli   := fRetNomCidade(fRetCodCidByCliente(LDadosEmail.strCodCli));
        LEnviaEmail.FCodOpe   := strLoginUsuarioLogado;
        LEnviaEmail.FEmaCli   := LDadosEmail.strEmailCli;
        LEnviaEmail.FArquiv   := LDadosEmail.RecArquivos;
        LEnviaEmail.FArrDup   := LDadosEmail.arrDupTabela;

        LEnviaEmail.FEnvAutCob := True;

        If LEnviaEmail.fEnviaEmailAutomatico(AEnviouEmail = 'N') Then
          AEnviouEmail := 'S';
      Finally
        FreeAndNil(LEnviaEmail);
      End;
    End;

  End;

  If AMostraDebCtrChq2.GerouRelEnvioWhats Then
  Begin

    LDadosSMS := AMostraDebCtrChq2.VariaveisSMS;
    LEnviaSMS := TSMSAut.Create(Nil);

    Try
      LEnviaSMS.FOpcDoc := 'AD';
      LEnviaSMS.FCodGru := '025';
      LEnviaSMS.FCodigo := LModelo;

      LEnviaSMS.FStatus := LStatusModelo;

      LEnviaSMS.FNomCli   := fRetNomCliente(LDadosSMS.strCodCli);
      LEnviaSMS.FCodCli   := LDadosSMS.strCodCli;
      LEnviaSMS.FPriCli   := fRetPrimeiraPalavra(LEnviaSMS.FNomCli);
      LEnviaSMS.FCidCli   := fRetNomCidade(fRetCodCidByCliente(LDadosSMS.strCodCli));
      LEnviaSMS.FTo       := LDadosSMS.strCelula;
      LEnviaSMS.FArquiv   := LDadosSMS.RecArquivos;

      If FModelosDeveEnviar.SMS Then
      Begin
        LEnviaSMS.blnWhatsApp := False;

        If LEnviaSMS.fEnviaSMSAutomatico(AEnviouSMS = 'N') Then
          AEnviouSMS := 'S';
      End;

      If FModelosDeveEnviar.WhatsApp Then
      Begin
        LEnviaSMS.blnWhatsApp := True;

        If LEnviaSMS.fEnviaSMSAutomatico(AEnviouWpp = 'N') Then
          AEnviouWpp := 'S';
      End;
    Finally
      FreeAndNil(LEnviaSMS);
    End;

  End;

  AtualizarTabelaMonitoramento(LDadosEmail,
                               LDadosSMS,
                               AEnviouEmail,
                               AEnviouSMS,
                               AEnviouWpp,
                               LAutoIncremMonitoramento);
end;

procedure TEmailAutController.EnviaExtratosCobrancas;
  Var
    LListaExtratos: TStringList;

    LModelo,
    LExtrato,

    LEnviouEmail,
    LErroEnvio: String;
begin
  Try
    IniciaDatasetBlackList;

    If Not Assigned(objLock) Then
      objLock := TLock.Create;

    LModelo := '001';

    If Not ExisteModeloEmailOuSMSOuWhatsappAtivoET(LModelo) Then
      Exit;

    If Not ExiteExtratoParaSeremEnviados(LListaExtratos) Then
      Exit;

    strEmpAcessoUsuarioLogado := RetornaTodasAsEmpresas;


    For LExtrato In LListaExtratos Do
    Begin

      If LeftStr(LExtrato, 3) <> VS_strCodEmp Then
      Begin
        Continue;
      End;

      If Not objLock.fLock_Unlock('ENVIO_EXTRATO_COBRANCA_MONITOR_' + LExtrato , True, False) Then
      Begin
        Continue;
      End;

      If Not System.IOUtils.TFile.Exists(RetornaDiretorioAEnviar + LExtrato) Then
      Begin
        objLock.pDestravarTodos;
        Continue;
      End;

      LEnviouEmail := 'N';
      EnviaEmailExtratoCobranca(LEnviouEmail,
                                LErroEnvio,
                                LExtrato);

      MoverArquivoPasta(LExtrato,LEnviouEmail);
      objLock.fLock_Unlock('ENVIO_EXTRATO_COBRANCA_MONITOR_' + LExtrato , False, False);
    End;
  Finally
    FreeAndNil(LListaExtratos);
    objLock.pDestravarTodos;
  End;
end;

function TEmailAutController.EnviarEmailAutomaticoDuplicatas(ADuplicataObj: TArrDupCtr;
                                                             AStatusEmail: TStatusDisparaEmail;
                                                             AEmailsCliente: String;
                                                             out AEnviouEmail,
                                                                 AEnviouSMS,
                                                                 AEnviouWPP: Boolean): Boolean;
  Var
    LDuplicata: TUniQuery;

    LNumeroPedido,
    LEmpresaPedido: String;

    LDadosEmail: TDadosDisparaEmail;

    LDadosSMS: TDadosDisparaSMS;
begin
  Result := False;

  LDuplicata := fCriarQuery('SELECT * FROM CADREC WHERE AUTOINCREM="' + ADuplicataObj[0].strAutoIn + '"');

  Try
    LDuplicata.Open;

    If LDuplicata.IsEmpty Then
      Exit;

    If ((Not AEnviouSMS) Or (Not AEnviouWPP)) Then
    Begin
      pRetNumeroPedidoVenda(LDuplicata.FieldByName('CTR_NUMDUP').AsString,
                            LDuplicata.FieldByName('CTR_ESPDOC').AsString,
                            LDuplicata.FieldByName('CTR_CODEMP').AsString,
                            LDuplicata.FieldByName('CTR_CODCLI').AsString,
                            LNumeroPedido,
                            LEmpresaPedido);

      LDadosSMS.strNumDoc         := LDuplicata.FieldByName('CTR_NUMDUP').AsString;
      LDadosSMS.strCodCli         := LDuplicata.FieldByName('CTR_CODCLI').AsString;
      LDadosSMS.strEspDoc         := LDuplicata.FieldByName('CTR_ESPDOC').AsString;
      LDadosSMS.strCodEmp         := LDuplicata.FieldByName('CTR_CODEMP').AsString;
      LDadosSMS.strNumOrc         := LNumeroPedido;
      LDadosSMS.strEspOrc         := IfThen(fEmptyStr(LNumeroPedido), '', 'PD');
      LDadosSMS.strEmpOri         := LEmpresaPedido;
      LDadosSMS.strCelula         := fCampoTabela('CLI_CELULA', 'CADCLI', ['CLI_CODCLI'], [LDuplicata.FieldByName('CTR_CODCLI').AsString]);
      LDadosSMS.strLinhaDigitavel := '';
      LDadosSMS.strDtaEmi         := FormatDateTime('dd/mm/yy', LDuplicata.FieldByName('CTR_DTACAD').AsDateTime);
      LDadosSMS.strValDup         := FormatFloat('#,##0.00', LDuplicata.FieldByName('CTR_VALDUP').AsFloat);
      LDadosSMS.strParcel         := LDuplicata.FieldByName('CTR_PARCEL').AsString;
      LDadosSMS.strDtaVen         := FormatDateTime('dd/mm/yy', LDuplicata.FieldByName('CTR_DTAVEN').AsDateTime);

      LDadosSMS.DiasVencimento := Abs(DaysBetween(LDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, VS_Date)).ToString;

      If Not AEnviouSMS Then
      Begin
         AEnviouSMS := fDisparaSMSBoletoAutomatico(LDadosSMS,
                                                   'AC',
                                                   AStatusEmail);

        If Not Result Then
          Result := AEnviouSMS;
      End;

      If Not AEnviouWPP Then
      Begin
        AEnviouWPP := fDisparaWhatsappBoletoAutomatico(LDadosSMS,
                                                       'AC',
                                                       AStatusEmail);

        If Not Result Then
          Result := AEnviouWPP;
      End;

    End;

    //Pedido para ser retirado temporariamente, até fazer o modelo separado
    If Not AEnviouEmail Then
    Begin
      pRetNumeroPedidoVenda(LDuplicata.FieldByName('CTR_NUMDUP').AsString,
                            LDuplicata.FieldByName('CTR_ESPDOC').AsString,
                            LDuplicata.FieldByName('CTR_CODEMP').AsString,
                            LDuplicata.FieldByName('CTR_CODCLI').AsString,
                            LNumeroPedido,
                            LEmpresaPedido);

      LDadosEmail.strNumDoc         := LDuplicata.FieldByName('CTR_NUMDUP').AsString;
      LDadosEmail.strCodCli         := LDuplicata.FieldByName('CTR_CODCLI').AsString;
      LDadosEmail.strEspDoc         := LDuplicata.FieldByName('CTR_ESPDOC').AsString;
      LDadosEmail.strCodEmp         := LDuplicata.FieldByName('CTR_CODEMP').AsString;
      LDadosEmail.strNumOrc         := LNumeroPedido;
      LDadosEmail.strEspOrc         := IfThen(fEmptyStr(LNumeroPedido), '', 'PD');
      LDadosEmail.strEmpOri         := LEmpresaPedido;

      LDadosEmail.RecArquivos := nil;

      LDadosEmail.strEmailCli       := AEmailsCliente;
      LDadosEmail.strLinhaDigitavel := '';
      LDadosEmail.strDtaEmi         := DateToStr(LDuplicata.FieldByName('CTR_DTACAD').AsDateTime);
      LDadosEmail.strValDup         := FormatFloat( 'R$ #,##0.00', LDuplicata.FieldByName('CTR_VALDUP').AsFloat);
      LDadosEmail.strParcel         := LDuplicata.FieldByName('CTR_PARCEL').AsString;
      LDadosEmail.strDtaVen         := DateToStr(LDuplicata.FieldByName('CTR_DTAVEN').AsDateTime);
      LDadosEmail.arrDupTabela      := fCarregaTabDupEmailDuplicatas(ADuplicataObj);

      LDadosEmail.DiasVencimento := Abs(DaysBetween(LDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, VS_Date)).ToString;

      AEnviouEmail := untFuncoes.fDisparaEmailBoletoAutomatico(LDadosEmail,
                                                               'AC',
                                                               AStatusEmail);

      Result := AEnviouEmail;
    End;
  Finally
    LDuplicata.Close;

    FreeAndNil(LDuplicata);
  End;
end;

Function TEmailAutController.fCarregaTabDupEmailDuplicatas(ADuplicataObj: TArrDupCtr) : TArrDupTabelaEmail;
  Var
    LDuplicatasArr: TArrDupTabelaEmail;

    LContador: Integer;

    LDuplicata: TUniQuery;
begin

  LDuplicata := fCriarQuery('SELECT * FROM CADREC WHERE AUTOINCREM="' + ADuplicataObj[0].strAutoIn + '"');

  Try
    LDuplicata.Open;

    If LDuplicata.IsEmpty Then
      Exit;

    LContador := 0;

    SetLength(LDuplicatasArr, LContador + 1);

    LDuplicatasArr[LContador].strNumDoc := LDuplicata.FieldByName('CTR_NUMDUP').AsString;
    LDuplicatasArr[LContador].strParcel := LDuplicata.FieldByName('CTR_PARCEL').AsString;
    LDuplicatasArr[LContador].strEspDoc := LDuplicata.FieldByName('CTR_ESPDOC').AsString;
    LDuplicatasArr[LContador].strCodEmp := LDuplicata.FieldByName('CTR_CODEMP').AsString;
    LDuplicatasArr[LContador].dtaDtaCad := LDuplicata.FieldByName('CTR_DTACAD').AsDateTime;
    LDuplicatasArr[LContador].dtaDtaVen := LDuplicata.FieldByName('CTR_DTAVEN').AsDateTime;
    LDuplicatasArr[LContador].fltVlrDup := LDuplicata.FieldByName('CTR_VALDUP').AsFloat;
    LDuplicatasArr[LContador].strCodCli := LDuplicata.FieldByName('CTR_CODCLI').AsString;

    Result := LDuplicatasArr;
  Finally
    LDuplicata.Close;

    FreeAndNil(LDuplicata);
  End;
end;

function TEmailAutController.EnviouEmaileSMSeWhatsapp(AEnviouEmail,
  AEnviouSMS, AEnviouWPP: Boolean): Boolean;
begin
  Result := AEnviouEmail;

  If Result Then
    Result := AEnviouSMS;

  If Result Then
    Result := AEnviouWPP;

  If Not Result Then
  Begin
    If FModelosDeveEnviar.Email Then
    Begin
      Result := AEnviouEmail;

      If Not Result Then
        Exit;
    End;

    If FModelosDeveEnviar.WhatsApp Then
    Begin
      Result := AEnviouWPP;

      If Not Result Then
        Exit;
    End;

    If FModelosDeveEnviar.SMS Then
    Begin
      Result := AEnviouSMS;

      If Not Result Then
        Exit;
    End;
  End;
end;

class function TEmailAutController.ExisteModeloDeSMSAtivo: Boolean;
  Var
    FSmsSai: TUniQuery;
    FSql: String;
begin
  Try
    FSmsSai := fCriaQuery;

    FSql := '';
    FSql := FSql + '';
    FSql := FSql + 'SELECT                      ';
    FSql := FSql + '  SMS_STATUS                ';
    FSql := FSql + 'FROM                        ';
    FSql := FSql + '  SMSSAI                    ';
    FSql := FSql + 'WHERE SMS_CODGRU = "009"    ';
    FSql := FSql + '  AND SMS_CODEMP = :CODEMP  ';
    FSql := FSql + '  AND SMS_STATUS = "A"      ';
    FSql := FSql + 'LIMIT 1                     ';

    Try
      FSmsSai.Close;
      FSmsSai.SQL.Clear;
      FSmsSai.SQL.Add(FSql);
      FSmsSai.ParamByName('CODEMP').AsString := VS_strCodEmp;
      FSmsSai.Open;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;

    Result := (FSmsSai.RecordCount > 0);
  Finally

    If Assigned(FSmsSai) Then
      FreeAndNil(FSmsSai);
  End;

end;

class function TEmailAutController.ExisteModeloDeWhatsappAtivo: Boolean;
  Var
    FWppSai: TUniQuery;
    FSql: String;
begin
  Try
    FWppSai := fCriaQuery;

    FSql := '';
    FSql := FSql + '';
    FSql := FSql + 'SELECT                      ';
    FSql := FSql + '  WPP_STATUS                ';
    FSql := FSql + 'FROM                        ';
    FSql := FSql + '  WPPSAI                    ';
    FSql := FSql + 'WHERE WPP_CODGRU = "009"    ';
    FSql := FSql + '  AND WPP_CODEMP = :CODEMP  ';
    FSql := FSql + '  AND WPP_STATUS = "A"      ';
    FSql := FSql + 'LIMIT 1                     ';

    Try
      FWppSai.Close;
      FWppSai.SQL.Clear;
      FWppSai.SQL.Add(FSql);
      FWppSai.ParamByName('CODEMP').AsString := VS_strCodEmp;
      FWppSai.Open;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;

    Result := (FWppSai.RecordCount > 0);
  Finally

    If Assigned(FWppSai) Then
      FreeAndNil(FWppSai);
  End;

end;

function TEmailAutController.ExisteModeloEmailOuSMSOuWhatsappAtivo(
  ACodigoModelo: String): Boolean;
  Var
    LEmailAutomatico: TEmaAut;

    LSMSAutomatico: TSMSAut;
begin
  inherited;
  Result := False;

  LEmailAutomatico := TEmaAut.Create(Nil);

  Try
    if ACodigoModelo = '039' then
    begin
      LEmailAutomatico.FCodigo := '001';
      LEmailAutomatico.FCodGru := '039';
      LEmailAutomatico.FOpcDoc := 'CB';
    end
    else
    begin
      LEmailAutomatico.FOpcDoc := 'AC';
      LEmailAutomatico.FCodigo := ACodigoModelo;
    end;

    FModelosDeveEnviar.Email := LEmailAutomatico.fTemEmailAtivo;

    LSMSAutomatico := TSMSAut.Create(Nil);

    if ACodigoModelo = '039' then
    begin
      LSMSAutomatico.FCodigo := '001';
      LSMSAutomatico.FCodGru := '039';
      LSMSAutomatico.FOpcDoc := 'CB';
    end
    else
    begin
      LSMSAutomatico.FOpcDoc := 'AC';
      LSMSAutomatico.FCodigo := ACodigoModelo;
    end;

    FModelosDeveEnviar.SMS := LSMSAutomatico.fTemModeloAtivo;

    LSMSAutomatico.FWhatsApp := True;
    FModelosDeveEnviar.WhatsApp := LSMSAutomatico.fTemModeloAtivo;

    FreeAndNil(LSMSAutomatico);

    If FModelosDeveEnviar.Email Then
      Exit(True);

    If FModelosDeveEnviar.WhatsApp Then
      Exit(True);

    If FModelosDeveEnviar.SMS Then
      Exit(True);
  Finally
    FreeAndNil(LEmailAutomatico);
  End;
end;

function TEmailAutController.ExisteModeloEmailOuSMSOuWhatsappAtivoAD(
  ACodigoModelo: String): Boolean;
  Var
    LEmailAutomatico: TEmaAut;

    LSMSAutomatico: TSMSAut;
begin
  inherited;
  Result := False;

  LEmailAutomatico := TEmaAut.Create(Nil);
  LSMSAutomatico := TSMSAut.Create(Nil);

  Try
    LEmailAutomatico.FOpcDoc := 'AD';
    LEmailAutomatico.FCodigo := ACodigoModelo;
    LEmailAutomatico.FStatus := IIF(ACodigoModelo = '001', staNenhumaAcao, staAvisoDebitoDia16);
    FModelosDeveEnviar.Email := LEmailAutomatico.fTemEmailAtivo;

    LSMSAutomatico.FOpcDoc := 'AD';
    LSMSAutomatico.FCodigo := ACodigoModelo;
    LSMSAutomatico.FStatus := IIF(ACodigoModelo = '001', staNenhumaAcao, staAvisoDebitoDia16);
    FModelosDeveEnviar.SMS :=False;

    LSMSAutomatico.FWhatsApp := True;
    FModelosDeveEnviar.WhatsApp := LSMSAutomatico.fTemModeloAtivo;

    If FModelosDeveEnviar.Email Then
      Exit(True);

    If FModelosDeveEnviar.WhatsApp Then
      Exit(True);

    If FModelosDeveEnviar.SMS Then
      Exit(True);
  Finally
    FreeAndNil(LEmailAutomatico);
    FreeAndNil(LSMSAutomatico);
  End;
end;

function TEmailAutController.ExisteModeloEmailOuSMSOuWhatsappAtivoET(
  ACodigoModelo: String): Boolean;
  Var
    LEmailAutomatico: TEmaAut;
begin
  inherited;
  Result := False;

  LEmailAutomatico := TEmaAut.Create(Nil);

  Try
    LEmailAutomatico.FOpcDoc := 'ET';
    LEmailAutomatico.FCodigo := ACodigoModelo;
    LEmailAutomatico.FStatus := staNenhumaAcao;
    FModelosDeveEnviar.Email := LEmailAutomatico.fTemEmailAtivo;

    If FModelosDeveEnviar.Email Then
      Exit(True);

  Finally
    FreeAndNil(LEmailAutomatico);
  End;
end;

class function TEmailAutController.ExistemRegistrosASeremEnviados(ACodigoModelo,
  ATipoModelo: String): Boolean;
  Var
    LCodigoModelo: String;

    LConsulta: TUniQuery;

    LDeveEnviar: TDeveEnviar;
begin
  If MatchStr(ACodigoModelo, ['009023', '009024']) Then
    Exit(False);

  LConsulta := Nil;

  LCodigoModelo := RightStr(ACodigoModelo, 3);

  LDeveEnviar.Email := ATipoModelo.Equals('EMAIL');
  LDeveEnviar.SMS := ATipoModelo.Equals('SMS');
  LDeveEnviar.WhatsApp := ATipoModelo.Equals('WPP');

  Try
    SeparaDatasParaFiltro;

    LConsulta := TFuncoesAvisosDeCobranca.RetornaDatasetAvisoCobranca(LCodigoModelo,
                                                                      FDatasFiltro,
                                                                      LDeveEnviar,
                                                                      True);
    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

class function TEmailAutController.ExisteOModeloAvisoDebitoAtivo(
  ACodigoModelo: String): Boolean;
  Var
    LEmailAutomatico: TEmaAut;

    LSMSAutomatico: TSMSAut;
begin
  inherited;
  LEmailAutomatico := TEmaAut.Create(Nil);
  LSMSAutomatico := TSMSAut.Create(Nil);

  Try
    LEmailAutomatico.FOpcDoc := 'AD';
    LEmailAutomatico.FStatus := IIF(ACodigoModelo = '001', staNenhumaAcao, staAvisoDebitoDia16);
    LEmailAutomatico.FCodigo := ACodigoModelo;
    Result := LEmailAutomatico.fTemEmailAtivo;

    If Result Then
      Exit;

    LSMSAutomatico.FOpcDoc := 'AD';
    LSMSAutomatico.FStatus := LEmailAutomatico.FStatus;
    LSMSAutomatico.FCodigo := ACodigoModelo;

    Result := LSMSAutomatico.fTemModeloAtivo;

    If Result Then
      Exit;

    LSMSAutomatico.FWhatsApp := True;
    Result := LSMSAutomatico.fTemModeloAtivo;
  Finally
    FreeAndNil(LEmailAutomatico);
    FreeAndNil(LSMSAutomatico);
  End;
end;

class function TEmailAutController.fAtingiuLimiteEnvioEmailsPorHoraProvedor(ADuplicataObj: TArrDupCtr): Boolean;
Var
  LQuery: TUniQuery;
  LCodPrv: String;
begin
  If VS_Error_you_are_sending_too_many_mails_slow_down Then
    Exit(True);

  If Length(ADuplicataObj) = 0 Then
    Exit(False);

  LCodPrv := TBoleto.fGetProvedorEnvioEmailAutomatico(ADuplicataObj[0]);

  Result := False;
  LQuery := fCriaQuery;
  Try
    LQuery.SQL.Add(' SELECT PRV_CODPRV, ');
    LQuery.SQL.Add('   PRV_LIMPHR, ');
    LQuery.SQL.Add('   COUNT(0) AS QTDENV ');
    LQuery.SQL.Add(' FROM ');
    LQuery.SQL.Add('   EMAENV ');
    LQuery.SQL.Add('   INNER JOIN CADPRV            ');
    LQuery.SQL.Add('     ON ENV_CODPRV = PRV_CODPRV ');
    LQuery.SQL.Add(' WHERE ENV_EMADTA >= CURRENT_DATE ');
    LQuery.SQL.Add('   AND ENV_EMAHOR >= DATE_SUB(CURRENT_TIME, INTERVAL 1 HOUR) ');
    LQuery.SQL.Add('   AND ENV_CODPRV = "' + LCodPrv + '" ');
    LQuery.SQL.Add(' GROUP BY PRV_CODPRV; ');
    LQuery.Open;

    If LQuery.IsEmpty Then
      Exit;

    If LQuery.FieldByName('PRV_LIMPHR').AsInteger <= 0 Then
      Exit;

    If LQuery.FieldByName('QTDENV').AsInteger < LQuery.FieldByName('PRV_LIMPHR').AsInteger Then
      Exit;

    Result := True;
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TEmailAutController.fExecutadoPorRobo: Boolean;
begin
  Result := Pos('EnviaEmailBoletoMonitor', Application.ExeName) > 0;
end;

class function TEmailAutController.fExistemBoletosASeremEnviados: Boolean;
  Var
    LModelo: String;
begin
  Result := False;

  For LModelo In VS_ModelosAvisosEmailAtivado Do
  Begin
    Result := ExistemRegistrosASeremEnviados(LModelo, 'EMAIL');

    Application.ProcessMessages;

    If Result Then
      Exit;
  End;

  For LModelo In VS_ModelosAvisosSMSAtivado Do
  Begin
    Result := ExistemRegistrosASeremEnviados(LModelo, 'SMS');

    Application.ProcessMessages;

    If Result Then
      Exit;
  End;

  For LModelo In VS_ModelosAvisosWPPAtivado Do
  Begin
    Result := ExistemRegistrosASeremEnviados(LModelo, 'WPP');

    Application.ProcessMessages;

    If Result Then
      Exit;
  End;

  If Not Result Then
    Result := fExistemConbrancasEletronicasASeremEnviadas(fCfgSis('PMEHAB', varBoolean));
end;

class function TEmailAutController.fExistemConbrancasEletronicasASeremEnviadas(
  const ACondicaoVerificar: Boolean): Boolean;
var
  LQryDados : TUniQuery;
begin
  if not ACondicaoVerificar then
    Exit(False);

  LQryDados  := fCriaQuery();
  try
    LQryDados.SQL.Text := 'SELECT '
                        + '       FATGOR.AUTOINCREM '
                        + '  FROM FATGOR '
                        + ' INNER JOIN COBELT ON COBELT.CBE_NUMDOC = FATGOR.FGO_NUMDOC '
                        + '                  AND COBELT.CBE_ESPDOC = FATGOR.FGO_ESPDOC '
                        + '                  AND COBELT.CBE_CODEMP = FATGOR.FGO_CODEMP '
                        + ' WHERE COBELT.CBE_EMLENV = "N" '
                        + '   AND COBELT.CBE_CODEMP = :CODEMP '
                        + '   AND COBELT.CBE_APICOB NOT IN ("PMEC") '
                        + ' LIMIT 1 ';

    LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryDados.Open;

    Result := not LQryDados.IsEmpty;
  finally
    FreeAndNil(LQryDados);
  end;
end;

class function TEmailAutController.fExisteModeloEmailConfiguradoOuAtivado: Boolean;
  Var
    objEmaAut: TEmaAut;
Begin
  objEmaAut := TEmaAut.Create(Nil);
  objEmaAut.FOpcDoc := 'AC';

  objEmaAut.FStatus := sta1DiaVencer;
  Result := objEmaAut.fTemEmailAtivo;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta2DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta3DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta4DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta5DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta6DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta7DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

    If Not Result THen
  Begin
    objEmaAut.FStatus := sta8DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta9DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta10DiasVencer;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta1DiaVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta2DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta3DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta4DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta5DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta8DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta6DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta7DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta9DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta10DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If Not Result THen
  Begin
    objEmaAut.FStatus := sta30DiasVencido;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  If (Not Result) And
     (fCfgSis('PMEHAB', varBoolean)) Then
  Begin
    objEmaAut.FStatus := staCobrancaEletronica;
    Result := objEmaAut.fTemEmailAtivo;
  End;

  FreeAndNil(objEmaAut);
End;

function TEmailAutController.fGerarBoletoPDF(const strAutInc: String): String;
Var
  objDuplic        : TArrDupCtr;
  
  LGravarLog,
  LDuplicataBaixada: Boolean;

  LDtaEma,
  LDtaSMS,
  LDtaWpp: TDateTime;

  LDtaRec: String;
  LPorRec: String;

  LCodGru: String;
  LCodCfg: String;

  LDuplicata: TUniQuery;
begin
  LDuplicata := fCriaQuery;
  Try
    Try
      IniciaDatasetBlackList;

      If fEmptyStr(strAutInc) Then
        Exit;

      LCodGru := '009';
      LCodCfg := '004';

      SetChaveLckaTc('');
      RetornaDadosAtualizadosDuplicata(LDtaEma, LDtaSMS, LDtaWpp, LDtaRec, LPorRec, strAutInc);

      LDuplicataBaixada := Not LDtaRec.IsEmpty;

      If LDuplicataBaixada Then
      Begin
        fStartTransaction;
        untCadRec.pGravaLogCtr(strAutInc,
                               'TENTATIVA GERAR PDF DUP BAIXADA',
                               'untTEnvioEmailAutController');
        fCommit;
        Exit;
      End;

      fStartTransaction;
      Try
        LDuplicata.SQL.Text := 'SELECT * FROM CADREC WHERE AUTOINCREM="' + strAutInc + '"';
        LDuplicata.Open;

        SetLength(objDuplic, 1);
        objDuplic[Length(objDuplic) - 1].strNumDup := LDuplicata.FieldByName('CTR_NUMDUP').AsString;
        objDuplic[Length(objDuplic) - 1].strParcel := LDuplicata.FieldByName('CTR_PARCEL').AsString;
        objDuplic[Length(objDuplic) - 1].strCodEmp := LDuplicata.FieldByName('CTR_CODEMP').AsString;
        objDuplic[Length(objDuplic) - 1].strEspDoc := LDuplicata.FieldByName('CTR_ESPDOC').AsString;
        objDuplic[Length(objDuplic) - 1].strCodCli := LDuplicata.FieldByName('CTR_CODCLI').AsString;
        objDuplic[Length(objDuplic) - 1].strAutoIn := LDuplicata.FieldByName('AUTOINCREM').AsString;
        objDuplic[Length(objDuplic) - 1].blnAvisoAutomaticoEmail := False;
        objDuplic[Length(objDuplic) - 1].strCodigoGrupo          := '009';
        objDuplic[Length(objDuplic) - 1].strCodigoEmail          := '004';

        If DuplicataEmUsoPorOutraEstacao Then
        Begin
          fRollBack;
          Exit;
        End;

        fCommit;
      Except
        fRollBack;
        LiberaDuplicata;
      End;

      LGravarLog := TBoleto.fReimpressaoPDFBoleto(objDuplic);

      fStartTransaction;
      If LGravarLog Then
        untCadRec.pGravaLogCtr(strAutInc,
                               'GERAR REIMPRESSAO PDF ',
                               'untTEnvioEmailAutController');
      fCommit;

      LiberaDuplicata;
      SetLength(objDuplic, 0);

    Except
      On E: Exception Do
      Begin
        fRollBack;
        LiberaDuplicata;
        If Not fExecutadoPorRobo Then
          Raise Exception.Create('Ocorreu um erro ao gerar o pdf de boleto.' + #13 +
                                 'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    LDuplicata.Close;

    FreeAndNil(LDuplicata);
  End;
end;

function TEmailAutController.GetChaveLckaTc: String;
begin
  Result := LChaLck;
end;

procedure TEmailAutController.IniciaDatasetBlackList;
  Var
    LConsulta: TUniQuery;
Begin
  If Assigned(FDatasetBlackList) Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * FROM EMABLK ORDER BY BLK_EMAIL_';
    LConsulta.Open;

    FDatasetBlackList := fCriaClientDatSet(LConsulta);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TEmailAutController.JaRealizouOEnvio(AValorCampo, AVencimento: TDateTime;
  AStatus: TStatusDisparaEmail): Boolean;
begin
  Result := AValorCampo > 0;

  If Result Then
  Begin
    Case AStatus Of
      sta1DiaVencer: Result := AValorCampo >= IncDay(AVencimento, -1);
      sta2DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -2);
      sta3DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -3);
      sta4DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -4);
      sta5DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -5);
      sta6DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -6);
      sta7DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -7);
      sta8DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -8);
      sta9DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -9);
      sta10DiasVencer: Result := AValorCampo >= IncDay(AVencimento, -10);

      sta1DiaVencido: Result := AValorCampo >= IncDay(AVencimento, 1);
      sta2DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 2);
      sta3DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 3);
      sta4DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 4);
      sta5DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 5);
      sta8DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 8);
      sta6DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 6);
      sta7DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 7);
      sta9DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 9);
      sta10DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 10);
      sta30DiasVencido: Result := AValorCampo >= IncDay(AVencimento, 30);
    End;
  End;
end;

procedure TEmailAutController.LiberaDuplicata;
begin
  If Assigned(objLock) Then
  Begin
    objLock.pDestravarTodos;
  End;
end;

class function TEmailAutController.ModeloPossuiTodasAsCfgsEmailFixo(
  ADatasetModelo: TDataset): Boolean;
begin
  Result := True;

  If ADatasetModelo.FieldByName('PROVEDOR').AsInteger = 0 Then
    Exit(False);

  If ADatasetModelo.FieldByName('EMAIL').AsString.IsEmpty Then
    Exit(False);

  If ADatasetModelo.FieldByName('LOGIN').AsString.IsEmpty Then
    Exit(False);

  If Not ADatasetModelo.FieldByName('PROVEDOR_OAUTH2').AsString.Equals('S') Then
  Begin
    If ADatasetModelo.FieldByName('SENHA').AsString.IsEmpty Then
      Exit(False);
  End;
end;

function TEmailAutController.fRetornaCdsPortadorAut(intTip : Integer; ACodGru, ACodCfg, ACodEmp : String ): TUniClientDataSet;
Var
    LQryPor  : TUniQuery;
    strSqlEmail,
    strSqlSMS,
    strSqlWhatsapp : String;
Begin

  Try

    // EMAIL
    strSqlEmail := '';
    strSqlEmail := strSqlEmail + ' SELECT PORAEN.AEN_CODPOR FROM EMASAI ';
    strSqlEmail := strSqlEmail + '  INNER JOIN PORAEN  ON EMASAI.EMA_CODGRU = PORAEN.AEN_CODGRU ';
    strSqlEmail := strSqlEmail + '                    AND EMASAI.EMA_CODIGO = PORAEN.AEN_CODCFG ';
    strSqlEmail := strSqlEmail + '                    AND EMASAI.EMA_CODEMP = PORAEN.AEN_CODEMP ';
    strSqlEmail := strSqlEmail + '  WHERE PORAEN.AEN_CODGRU = :CODGRU ';
    strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODCFG = :CODCFG ';
    strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODEMP = :CODEMP ';
    strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODTIP = 0       ';
    strSqlEmail := strSqlEmail + '    AND EMASAI.EMA_STATUS = ''A''   ';

    // SMS
    strSqlSMS := '';
    strSqlSMS := strSqlSMS + ' SELECT PORAEN.AEN_CODPOR FROM SMSSAI ';
    strSqlSMS := strSqlSMS + '  INNER JOIN PORAEN  ON SMSSAI.SMS_CODGRU = PORAEN.AEN_CODGRU ';
    strSqlSMS := strSqlSMS + '                    AND SMSSAI.SMS_CODIGO = PORAEN.AEN_CODCFG ';
    strSqlSMS := strSqlSMS + '                    AND SMSSAI.SMS_CODEMP = PORAEN.AEN_CODEMP ';
    strSqlSMS := strSqlSMS + ' WHERE PORAEN.AEN_CODGRU    = :CODGRU ';
    strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODCFG = :CODCFG ';
    strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODEMP = :CODEMP ';
    strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODTIP = 1       ';
    strSqlSMS := strSqlSMS + '    AND   SMSSAI.SMS_STATUS = ''A''   ';

    // Whatsapp
    strSqlWhatsapp := '';
    strSqlWhatsapp := strSqlWhatsapp + ' SELECT PORAEN.AEN_CODPOR FROM WPPSAI ';
    strSqlWhatsapp := strSqlWhatsapp + '  INNER JOIN PORAEN  ON WPPSAI.WPP_CODGRU = PORAEN.AEN_CODGRU ';
    strSqlWhatsapp := strSqlWhatsapp + '                    AND WPPSAI.WPP_CODIGO = PORAEN.AEN_CODCFG ';
    strSqlWhatsapp := strSqlWhatsapp + '                    AND WPPSAI.WPP_CODEMP = PORAEN.AEN_CODEMP ';
    strSqlWhatsapp := strSqlWhatsapp + ' WHERE PORAEN.AEN_CODGRU    = :CODGRU ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODCFG = :CODCFG ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODEMP = :CODEMP ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODTIP = 2       ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   WPPSAI.WPP_STATUS = ''A''   ';

    LQryPor   := fCriaQuery;

    If intTip = 0 Then //email
       LQryPor.SQL.Text := strSqlEmail
    Else If intTip = 1 Then //sms
       LQryPor.SQL.Text := strSqlSMS
    Else If intTip = 2 Then //whatsapp
       LQryPor.SQL.Text := strSqlWhatsapp;

    LQryPor.Parambyname('CODGRU').value := ACodGru;
    LQryPor.Parambyname('CODCFG').value := ACodCfg;
    LQryPor.Parambyname('CODEMP').value := ACodEmp;
    LQryPor.Open;

    Result := fCriaClientDatSet(LQryPor);

  Finally
    FreeAndNil(LQryPor);
  End;

End;

procedure TEmailAutController.pEnviaEmailSmsLinkPagamento;
Var
  LQryDados       : TUniQuery;
  LQryUpdate      : TUniQuery;
  LFiltroMensagem : String;

  objDadosEmail   : TDadosDisparaEmail;
  objDadosSMS     : TDadosDisparaSMS;

  LEnviouSMS      : Boolean;
  LEnviouEmail    : Boolean;
  LEnviouWPP      : Boolean;

  LstrEmailEnv    : String;

  procedure pAdicionaVerificacao(const blnAdicionar: Boolean;
    const strCampo: String);
  begin
    if blnAdicionar then
    begin
      if not fEmptyStr(LFiltroMensagem) then
        LFiltroMensagem := LFiltroMensagem
                         + '    OR ';

      LFiltroMensagem := LFiltroMensagem
                       + ' COBELT.'+strCampo+' = "N" ';
    end;
  end;
begin
  LQryDados  := fCriaQuery();
  LQryUpdate := fCriaQuery();

  try
    IniciaDatasetBlackList;

    LFiltroMensagem := EmptyStr;
    pAdicionaVerificacao(FModelosDeveEnviar.Email    , 'CBE_EMLENV');
    pAdicionaVerificacao(FModelosDeveEnviar.SMS      , 'CBE_SMSENV');
    pAdicionaVerificacao(FModelosDeveEnviar.WhatsApp , 'CBE_WPPENV');

    if not fEmptyStr(LFiltroMensagem) then
      LFiltroMensagem := '   AND ('+LFiltroMensagem+') ';

    LQryUpdate.SQL.Text := 'UPDATE COBELT '
                         + '   SET CBE_EMLENV = :EMLENV '
                         + '     , CBE_SMSENV = :SMSENV '
                         + '     , CBE_WPPENV = :WPPENV '
                         + ' WHERE AUTOINCREM = :AUTINC ';

    LQryDados.SQL.Text := 'SELECT '
                        + '       FATGOR.AUTOINCREM '
                        + '     , COBELT.CBE_NUMDOC '
                        + '     , COBELT.CBE_ESPDOC '
                        + '     , COBELT.CBE_CODEMP '
                        + '     , FATGOR.FGO_CODCLI '
                        + '     , COBELT.CBE_LNKPAG '
                        + '     , CADCLI.CLI_EMAIL_ '
                        + '     , CADCLI.CLI_EMAIL2 '
                        + '     , CADCLI.CLI_EMAIL3 '
                        + '     , FATGOR.FGO_DTAENT '
                        + '     , CADCLI.CLI_CELULA '
                        + '     , COBELT.AUTOINCREM AS CBE_AUTINC '
                        + '     , COBELT.CBE_EMLENV '
                        + '     , COBELT.CBE_SMSENV '
                        + '     , COBELT.CBE_WPPENV '
                        + '     , EXTGOR.FGO_TIPREC '
                        + '  FROM FATGOR '
                        + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                        + ' INNER JOIN CADCLI ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI '
                        + ' INNER JOIN COBELT ON COBELT.CBE_NUMDOC = FATGOR.FGO_NUMDOC '
                        + '                  AND COBELT.CBE_ESPDOC = FATGOR.FGO_ESPDOC '
                        + '                  AND COBELT.CBE_CODEMP = FATGOR.FGO_CODEMP '
                        + ' WHERE TRUE '
                        + LFiltroMensagem
                        + '   AND COBELT.CBE_CODEMP = :CODEMP '
                        + '   AND EXTGOR.FGO_TIPREC = "PMEE" '
                        + '   AND COBELT.CBE_APICOB NOT IN ("PMEC") ';

    LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQryDados.Open;

    if not LQryDados.IsEmpty then
    begin
      LQryDados.First;
      while not LQryDados.Eof do
      begin
        LEnviouEmail := (LQryDados.FieldByName('CBE_EMLENV').AsString = 'S');
        LEnviouSMS   := (LQryDados.FieldByName('CBE_SMSENV').AsString = 'S');
        LEnviouWPP   := (LQryDados.FieldByName('CBE_WPPENV').AsString = 'S');

        LstrEmailEnv := LQryDados.FieldByName('CLI_EMAIL_').AsString;

        if fEmptyStr(LstrEmailEnv) then
          LstrEmailEnv := LQryDados.FieldByName('CLI_EMAIL3').AsString;

        if fEmptyStr(LstrEmailEnv) then
          LstrEmailEnv := LQryDados.FieldByName('CLI_EMAIL2').AsString;

        objDadosEmail.strNumDoc   := LQryDados.FieldByName('CBE_NUMDOC').AsString;
        objDadosEmail.strEspDoc   := LQryDados.FieldByName('CBE_ESPDOC').AsString;
        objDadosEmail.strCodEmp   := LQryDados.FieldByName('CBE_CODEMP').AsString;
        objDadosEmail.strCodCli   := LQryDados.FieldByName('FGO_CODCLI').AsString;
        objDadosEmail.strLnkPag   := LQryDados.FieldByName('CBE_LNKPAG').AsString;
        objDadosEmail.strEmailCli := LstrEmailEnv;
        objDadosEmail.strDtaVen   := LQryDados.FieldByName('FGO_DTAENT').AsString;

        if (FModelosDeveEnviar.Email) and
           (Not LEnviouEmail) then
          LEnviouEmail := fDisparaEmailBoletoAutomatico(objDadosEmail, 'CB');

        objDadosSMS.strNumDoc   := objDadosEmail.strNumDoc;
        objDadosSMS.strEspDoc   := objDadosEmail.strEspDoc;
        objDadosSMS.strCodEmp   := objDadosEmail.strCodEmp;
        objDadosSMS.strCodCli   := objDadosEmail.strCodCli;
        objDadosSMS.strLnkPag   := objDadosEmail.strLnkPag;
        objDadosSMS.strDtaVen   := objDadosEmail.strDtaVen;
        objDadosSMS.strCelula   := LQryDados.FieldByName('CLI_CELULA').AsString;

        if (FModelosDeveEnviar.SMS) and
           (Not LEnviouSMS) then
          LEnviouSMS := fDisparaSMSBoletoAutomatico(objDadosSMS, 'CB', staNenhumaAcao, False);

        if FModelosDeveEnviar.WhatsApp and
           (Not LEnviouWPP) then
          LEnviouWPP := fDisparaSMSBoletoAutomatico(objDadosSMS, 'CB', staNenhumaAcao, True);

        LQryUpdate.Close;
        LQryUpdate.ParamByName('AUTINC').AsString := LQryDados.FieldByName('CBE_AUTINC').AsString;
        LQryUpdate.ParamByName('EMLENV').AsString := IfThen(LEnviouEmail,'S','N');
        LQryUpdate.ParamByName('SMSENV').AsString := IfThen(LEnviouSMS,'S','N');
        LQryUpdate.ParamByName('WPPENV').AsString := IfThen(LEnviouWPP,'S','N');
        LQryUpdate.ExecSQL;

        LQryDados.Next;
      end;
    end;
  finally
    FreeAndNil(LQryDados);
    FreeAndNil(LQryUpdate);
  end;
end;

procedure TEmailAutController.pDisparosCobrancaEletronica;
begin
  Try
    IniciaDatasetBlackList;

   If ExisteModeloEmailOuSMSOuWhatsappAtivo('039') Then
      pEnviaEmailSmsLinkPagamento;

  Except
    On E: Exception Do
    Begin
      LiberaDuplicata;
      pGravarErro(True, E.Message);
    End;
  End;

  // Cool-down: mantem o EXE vivo (e o lock distribuido) durante PMETML
  // segundos apos o trabalho, impedindo disparos sobrepostos por outras
  // estacoes. O lock so sera liberado em pFinaliza, apos este Sleep.
  // Piso de 60s alinha o cool-down com o Max(cfg, 60) * 1000 do Interval
  // do timer em untPrincipal.pas - garante serializacao em bases legadas
  // que mantiveram PMETML=10 do default antigo.
  Sleep(Max(fCfgSis('PMETML', varInteger), 60) * 1000);
end;

procedure TEmailAutController.EnviaEmailBoletoModelo(ACodigoModelo: String);
  Var
    LListaBoletos,
    LAtualizar: TUniQuery;

    LDuplicataEnvio: TArrDupCtr;

    LEnviouEmail,
    LEnviouSMS,
    LEnviouWPP,
    LGravarLog,
    LDuplicataBaixada: Boolean;

    LDtaEma,
    LDtaSMS,
    LDtaWPP: TDateTime;

    LDtaRec: String;
    LPorRec: String;

    LCodGru: String;
    LCodCfg: String;

    LPortAutEmail,
    LPortAutSms,
    LPortAutWhatsapp: TUniClientDataSet;

    LAtuDataEmail,
    LAtuDatasms,
    LAtuDataWpp: Boolean;

    LTipoModelo: TStatusDisparaEmail;
begin
  LListaBoletos := TFuncoesAvisosDeCobranca.RetornaDatasetAvisoCobranca(ACodigoModelo,
                                                                        FDatasFiltro,
                                                                        FModelosDeveEnviar,
                                                                        False,
                                                                        True);

  Try
    Try
      If LListaBoletos.IsEmpty Then
        Exit;

      LListaBoletos.First;

      LCodGru := '009';
      LCodCfg := ACodigoModelo;

      LPortAutEmail := fRetornaCdsPortadorAut(0, LCodGru, LCodCfg, VS_strCodEmp);
      LPortAutEmail.Open;

      LPortAutSms   := fRetornaCdsPortadorAut(1, LCodGru, LCodCfg, VS_strCodEmp);
      LPortAutSms.Open;

      LPortAutWhatsapp := fRetornaCdsPortadorAut(2, LCodGru, LCodCfg, VS_strCodEmp);
      LPortAutWhatsapp.Open;

      While Not LListaBoletos.Eof Do
      Begin
        LDtaEma := LListaBoletos.FieldByName('CTR_DTAEMA').AsDateTime;
        LDtaSms := LListaBoletos.FieldByName('CTR_DTASMS').AsDateTime;
        LDtaWpp := LListaBoletos.FieldByName('CTR_DTAWPP').AsDateTime;

        SetChaveLckaTc('');

        RetornaDadosAtualizadosDuplicata(LDtaEma,
                                         LDtaSMS,
                                         LDtaWpp,
                                         LDtaRec,
                                         LPorRec,
                                         LListaBoletos.FieldByName('AUTOINCREM').AsString);

        If DuplicataEmUsoPorOutraEstacao Then
        Begin
          fStartTransaction;
          untCadRec.pGravaLogCtr(LListaBoletos.FieldByName('AUTOINCREM').AsString,
                                 'ENVIO ABORTADO - DUPLICATA EM USO POR OUTRA ESTAÇÃO',
                                 'untTEnvioEmailAutController');
          fCommit;
          LiberaDuplicata;

          LListaBoletos.Next;

          Continue;
        End;

        if fExecutadoPorRobo then
        begin
          If not HorarioExecutaRobo(fCfgSis('HORAVI', varString)) Then
          Begin
            fStartTransaction;
            untCadRec.pGravaLogCtr(LListaBoletos.FieldByName('AUTOINCREM').AsString,
                                   'ENVIO ABORTADO - FORA DO HORARIO DE ENVIO CONFIGURADO',
                                   'untTEnvioEmailAutController');
            fCommit;
            LiberaDuplicata;

            LListaBoletos.Next;

            Continue;
          End;
        end;

        LTipoModelo := TFuncoesAvisosDeCobranca.RetornaTipoModelo(ACodigoModelo, 0, False);

        LEnviouEmail := JaRealizouOEnvio(LDtaEma, LListaBoletos.FieldByName('CTR_DTAVEN').AsDateTime, LTipoModelo);
        LEnviouSMS   := JaRealizouOEnvio(LDtaSms, LListaBoletos.FieldByName('CTR_DTAVEN').AsDateTime, LTipoModelo);
        LEnviouWPP   := JaRealizouOEnvio(LDtaWpp, LListaBoletos.FieldByName('CTR_DTAVEN').AsDateTime, LTipoModelo);

        LAtuDataEmail := True;
        LAtuDatasms   := True;
        LAtuDataWpp   := True;

        If fValidaRegrasDuplicatasEnvio(LListaBoletos.FieldByName('AUTOINCREM').AsString,
                                        LEnviouEmail, LEnviouSMS, LEnviouWPP,
                                        LAtuDataEmail, LAtuDatasms, LAtuDataWpp) Then
        Begin
          LiberaDuplicata;
          LListaBoletos.Next;

          Continue;
        End;

        // Verifica portadores autorizados para envio de email;;
        if Not LPortAutEmail.IsEmpty then
        Begin
          If Not LPortAutEmail.Locate('AEN_CODPOR', LPorRec, []) Then
          Begin
            LEnviouEmail := true;
            LAtuDataEmail := False;

            fStartTransaction;
            untCadRec.pGravaLogCtr(LListaBoletos.FieldByName('AUTOINCREM').AsString,
                                   'ENVIO DE EMAIL ABORTADO - PORTADOR NAO AUTORIZADO',
                                   'untTEnvioEmailAutController');
            fCommit;
          End;
        End;

        // Verifica portadores autorizados para envio de sms;
        if Not LPortAutSms.IsEmpty then
        Begin
          If Not LPortAutSms.Locate('AEN_CODPOR', LPorRec, []) Then
          Begin
            LEnviouSMS := true;
            LAtuDatasms := False;

            fStartTransaction;
            untCadRec.pGravaLogCtr(LListaBoletos.FieldByName('AUTOINCREM').AsString,
                                   'ENVIO DE SMS ABORTADO - PORTADOR NAO AUTORIZADO',
                                   'untTEnvioEmailAutController');
            fCommit;
          End;
        End;

        // Verifica portadores autorizados para envio de whatsapp;
        if Not LPortAutWhatsapp.IsEmpty then
        Begin
          If Not LPortAutWhatsapp.Locate('AEN_CODPOR', LPorRec, []) Then
          Begin
            LEnviouWPP := true;
            LAtuDataWpp := False;

            fStartTransaction;
            untCadRec.pGravaLogCtr(LListaBoletos.FieldByName('AUTOINCREM').AsString,
                                   'ENVIO DE WHATSAPP ABORTADO - PORTADOR NAO AUTORIZADO',
                                   'untTEnvioEmailAutController');
            fCommit;
          End;
        End;

        If DadosCadastroClienteInvalidos(LListaBoletos,
                                         LEnviouEmail, LEnviouSMS, LEnviouWPP,
                                         LAtuDataEmail, LAtuDatasms, LAtuDataWpp) Then
        Begin
          LiberaDuplicata;
          LListaBoletos.Next;

          Continue;
        End;

        If EnviouEmaileSMSeWhatsapp(LEnviouEmail, LEnviouSMS, LEnviouWPP) Then
        Begin
          LiberaDuplicata;
          LListaBoletos.Next;

          Continue;
        End;

        LDuplicataBaixada := Not LDtaRec.IsEmpty;

        If LDuplicataBaixada Then
        Begin
          fStartTransaction;
          untCadRec.pGravaLogCtr(LListaBoletos.FieldByName('AUTOINCREM').AsString,
                                 'TENTATIVA ENVIO AUTOMÁTICO DE E-MAIL/SMS/WHATSAPP DUP BAIXADA',
                                 'untTEnvioEmailAutController');
          fCommit;
          LiberaDuplicata;

          LListaBoletos.Next;

          Continue;
        End;

        LTipoModelo := TFuncoesAvisosDeCobranca.RetornaTipoModelo(ACodigoModelo,
                                                                  LListaBoletos.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                  True);

        If ((LTipoModelo = staAVencerProximoDiaUtil) Or (LTipoModelo = staVencidoProximoDiaUtil)) Then
        Begin
           //Enviar boletos de cobrança Sábado/Domingo/Feriado? E Tolerancia for mior do que 0;
           If (Not fCfgSis('AVIUTI', varBoolean)) And (fCfgSis('AVITOL', varInteger) > 0) Then
           Begin
              If (TFuncoesAvisosDeCobranca.RetornaDiaEnvioComTolerancia( LTipoModelo, ACodigoModelo, LListaBoletos.FieldByName('CTR_DTAVEN').AsDateTime ) < VS_Date) Then
              Begin
                LiberaDuplicata;
                LListaBoletos.Next;

                Continue;
              End;
           End;
        End;

        SetLength(LDuplicataEnvio, 1);
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strNumDup := LListaBoletos.FieldByName('CTR_NUMDUP').AsString;
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strParcel := LListaBoletos.FieldByName('CTR_PARCEL').AsString;
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strCodEmp := LListaBoletos.FieldByName('CTR_CODEMP').AsString;
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strEspDoc := LListaBoletos.FieldByName('CTR_ESPDOC').AsString;
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strCodCli := LListaBoletos.FieldByName('CTR_CODCLI').AsString;
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strAutoIn := LListaBoletos.FieldByName('AUTOINCREM').AsString;

        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].blnAvisoAutomaticoEmail := True;
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strCodigoGrupo          := LCodGru;
        LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strCodigoEmail          := LCodCfg;
        If LTipoModelo = staAVencerProximoDiaUtil Then
          LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strCodigoEmail := '023'
        Else If LTipoModelo = staVencidoProximoDiaUtil Then
          LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strCodigoEmail := '024';

        LGravarLog := EnviaEmailsConformeOModo(LListaBoletos, LDuplicataEnvio, LTipoModelo, LEnviouEmail, LEnviouSMS, LEnviouWPP);

        if not LGravarLog then
          LGravarLog := (LEnviouEmail and LAtuDataEmail) or
                        (LEnviouSMS and LAtuDatasms) or
                        (LEnviouWPP and LAtuDataWpp);

        If LGravarLog Then
        Begin
          if Not LAtuDataEmail then
            LEnviouEmail := False;

          if Not LAtuDatasms then
            LEnviouSMS := False;

          if Not LAtuDataWpp then
            LEnviouWPP := False;

          fStartTransaction;

          LAtualizar := TFuncoesAvisosDeCobranca.RetornaDuplicataAtualizar(LDuplicataEnvio[Length(LDuplicataEnvio) - 1].strAutoIn);

          LTipoModelo := TFuncoesAvisosDeCobranca.RetornaTipoModelo(ACodigoModelo,
                                                                    0,
                                                                    False);

          LAtualizar.Edit;
          LAtualizar.FieldByName('CTR_DTAEMA').Value := RetornaDataDoEnvio(LAtualizar.FieldByName('CTR_DTAEMA').AsDateTime,
                                                                           LAtualizar.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                           LEnviouEmail,
                                                                           LTipoModelo);

          LAtualizar.FieldByName('CTR_DTASMS').Value := RetornaDataDoEnvio(LAtualizar.FieldByName('CTR_DTASMS').AsDateTime,
                                                                           LAtualizar.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                           LEnviouSMS,
                                                                           LTipoModelo);

          LAtualizar.FieldByName('CTR_DTAWPP').Value := RetornaDataDoEnvio(LAtualizar.FieldByName('CTR_DTAWPP').AsDateTime,
                                                                           LAtualizar.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                           LEnviouWPP,
                                                                           LTipoModelo);

          LAtualizar.Post;
          fCommit;

          fStartTransaction;
          untCadRec.pGravaLogCtr(LAtualizar.FieldByName('AUTOINCREM').AsString,
                                 'ENVIO AUTOMÁTICO DE '+
                                 IIF(LEnviouEmail, 'E-MAIL '  , '')+
                                 IIF(LEnviouSMS  , 'SMS '     , '')+
                                 IIF(LEnviouWPP  , 'WHATSAPP ', ''),
                                 'untTEnvioEmailAutController');
          fCommit;

          LAtualizar.Close;

          FreeAndNil(LAtualizar);
        End;

        LiberaDuplicata;
        SetLength(LDuplicataEnvio, 0);

        LListaBoletos.Next;
      End;

      LListaBoletos.Close;
      FreeAndNil(LListaBoletos);
      LiberaDuplicata;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        LiberaDuplicata;

        If Not fExecutadoPorRobo Then
          Raise Exception.Create('Ocorreu um erro ao enviar os e-mails das duplicatas do modelo ' + ACodigoModelo + '.' + #13 +
                                 'Erro gerado: ' + E.Message);
      End;
    End;
  Finally
    if Assigned(LPortAutEmail) then
      FreeAndNil(LPortAutEmail);

    if Assigned(LPortAutSms) then
      FreeAndNil(LPortAutSms);

    if Assigned(LPortAutWhatsapp) then
      FreeAndNil(LPortAutWhatsapp);
  End;
end;

procedure TEmailAutController.RetornaDadosParaValidacaoDuplicataEmail(out ADtaCad: TDateTime;
                                                                      out ADtaVen: TDateTime;
                                                                      out AEspDoc: String;
                                                                      out ACartei: String;
                                                                      out ACodEmp: String;
                                                                      out ANosNum: String;
                                                                      out ADtaBol: TDateTime;
                                                                      out ALinhaDigitavel: String;
                                                                          AAutoIncrem: String);
  Var
    LConsulta: TUniQuery;
    LSql: String;
begin
  LConsulta := Nil;
  Try
    LConsulta := fCriaQuery;

    LSql := '';
    LSql := LSql +'SELECT                      ';
    LSql := LSql +'  CTR_NUMDUP,               ';
    LSql := LSql +'  CTR_ESPDOC,               ';
    LSql := LSql +'  CTR_CODEMP,               ';
    LSql := LSql +'  CTR_DTAVEN,               ';
    LSql := LSql +'  CTR_DTACAD,               ';
    LSql := LSql +'  CTR_CARTEI,               ';
    LSql := LSql +'  CTR_NOSNUM,               ';
    LSql := LSql +'  CTR_DTABOL,               ';
    LSql := LSql +'  CTR_LINDIG                ';
    LSql := LSql +'FROM                        ';
    LSql := LSql +'  CADREC                    ';
    LSql := LSql +'WHERE AUTOINCREM = :AUTOINC ';

    LConsulta.SQL.Text := LSql;
    LConsulta.ParamByName('AUTOINC').AsString := AAutoIncrem;
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      If Not LConsulta.FieldByName('CTR_DTACAD').AsString.IsEmpty Then
        ADtaCad := LConsulta.FieldByName('CTR_DTACAD').AsDateTime;

      If Not LConsulta.FieldByName('CTR_DTAVEN').AsString.IsEmpty Then
        ADtaVen := LConsulta.FieldByName('CTR_DTAVEN').AsDateTime;

      If Not LConsulta.FieldByName('CTR_ESPDOC').AsString.IsEmpty Then
        AEspDoc := LConsulta.FieldByName('CTR_ESPDOC').AsString;

      If Not LConsulta.FieldByName('CTR_CARTEI').AsString.IsEmpty Then
        ACartei := LConsulta.FieldByName('CTR_CARTEI').AsString;

      If Not LConsulta.FieldByName('CTR_CODEMP').AsString.IsEmpty Then
        ACodEmp := LConsulta.FieldByName('CTR_CODEMP').AsString;

      If Not LConsulta.FieldByName('CTR_NOSNUM').AsString.IsEmpty Then
        ANosNum := LConsulta.FieldByName('CTR_NOSNUM').AsString;

      If Not LConsulta.FieldByName('CTR_DTABOL').AsString.IsEmpty Then
        ADtaBol := LConsulta.FieldByName('CTR_DTABOL').AsDateTime;

      ALinhaDigitavel := LConsulta.FieldByName('CTR_LINDIG').AsString;
    End;
  Finally
    FreeAndNilDatasets(LConsulta);
  End;
end;

Function TEmailAutController.fValidaEnvioDuplicataEmail(sTipo : String; sAutoinc : String) : Boolean; // sTipo := B-BOLETO; W-WHATSAPP; S-SMS;
  Var
    sCFG_AVIREB,
    sCFG_AVIREW,
    sCFG_AVIRES,
    sCFG_AVIRWS,
    sCFG_AVIRSS : String;

    ADtaCad,
    ADtaVen,
    ADtaBol : TDateTime;
    AEspDoc : String;
    ACartei : String;
    ACodEmp : String;
    ANosNum : String;

    LLinhaDigitavel: String;

    strEmpresa : String;
Begin

  Result := True;

  RetornaDadosParaValidacaoDuplicataEmail( ADtaCad, ADtaVen, AEspDoc, ACartei, ACodEmp, ANosNum, ADtaBol, LLinhaDigitavel, sAutoinc );

  If Not fEmptyStr(ACartei) Then
     strEmpresa := RightStr(ACartei,3)
  Else
     strEmpresa := ACodEmp;

  sCFG_AVIREB := fCfgSis('AVIREB', varString, strEmpresa);
  sCFG_AVIREW := fCfgSis('AVIREW', varString, strEmpresa);
  sCFG_AVIRES := fCfgSis('AVIRES', varString, strEmpresa);
  sCFG_AVIRWS := fCfgSis('AVIRWS', varString, strEmpresa);
  sCFG_AVIRSS := fCfgSis('AVIRSS', varString, strEmpresa);

  If (sTipo = 'B') Then // boleto
  Begin
     If sCFG_AVIREB = '1' Then
        Result := fValidaOpcao01(ANosNum, ADtaBol, LLinhaDigitavel)
     Else
     If sCFG_AVIREB = '2' Then
        Result := fValidaOpcao02(ADtaCad, ADtaVen)
  End
  Else
  If (sTipo = 'W') Then // WhatsApp
  Begin
     If sCFG_AVIREW = '1' Then
        Result := fValidaOpcao01(ANosNum, ADtaBol, LLinhaDigitavel)
     Else
     If sCFG_AVIREW = '2' Then
        Result := fValidaOpcao02(ADtaCad, ADtaVen)
     Else
     If sCFG_AVIREW = '3' Then
        Result := fValidaOpcao03(AEspDoc, sCFG_AVIRWS);
  End
  Else
  If (sTipo = 'S') Then // SMS
  Begin
     If sCFG_AVIRES = '1' Then
        Result := fValidaOpcao01(ANosNum, ADtaBol, LLinhaDigitavel)
     Else
     If sCFG_AVIRES = '2' Then
        Result := fValidaOpcao02(ADtaCad, ADtaVen)
     Else
     If sCFG_AVIRES = '3' Then
        Result := fValidaOpcao03(AEspDoc, sCFG_AVIRSS);
  End;

End;

Function TEmailAutController.fValidaOpcao01(ANosNum : String; ADtaBol : TDateTime;
  ALinhaDigitavel: String) : Boolean;
Begin
  Result := True;

  If (fEmptyStr(ANosNum) or (ADtaBol = 0) Or (ALinhaDigitavel.IsEmpty)) Then
      Result := False;
End;

Function TEmailAutController.fValidaOpcao02(ADataCad, ADataVen : TDateTime) : Boolean;
Begin
  Result := True;

  If (ADataCad = ADataVen) Then
      Result := False;
End;

Function TEmailAutController.fValidaOpcao03(AEspDoc, AStrSelec : String) : Boolean;
Begin
  Result := True;

  if (Pos(AEspDoc, AStrSelec) = 0) then
     Result := False;
End;

Function TEmailAutController.fValidaRegrasDuplicatasEnvio( sAutoInc : String;
                                                           Var AEnviouEmail,
                                                               AEnviouSMS,
                                                               AEnviouWPP,
                                                               AAtualizaDataEmail,
                                                               AAtualizaDataSms,
                                                               AAtualizaDataWpp: Boolean): Boolean;
Begin
    Result := False;

    If Not fValidaEnvioDuplicataEmail('B', sAutoInc) Then // sTipo := B-BOLETO; W-WHATSAPP; S-SMS;
    Begin
       AEnviouEmail    := True;
       AAtualizaDataEmail := False;
    End;

    If Not fValidaEnvioDuplicataEmail('W', sAutoInc) Then
    Begin
       AEnviouWPP    := True;
       AAtualizaDataWpp := False;
    End;

    If Not fValidaEnvioDuplicataEmail('S', sAutoInc) Then
    Begin
       AEnviouSMS    := True;
       AAtualizaDataSms := False;
    End;

    If AEnviouEmail Then
    Begin
      If AEnviouSMS Then
         Exit(AEnviouWPP);
    End;

End;

end.
