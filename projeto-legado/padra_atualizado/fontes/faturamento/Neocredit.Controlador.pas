unit Neocredit.Controlador;

interface

uses
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'}, 
  {$ELSE }
  untFuncoesSimples, REST.Client, untLiberacao, untFuncFatTypes,
  {$ENDIF LINUX}
  System.Classes, System.SysUtils, System.StrUtils, Uni, untAtualizaOcorrenciasCRM,
  Neocredit.Service;

type
  TControladorNeocredit = class
  private
    function AutorizaAnaliseLimiteCredito(const AStlPedidos: TStringList): Boolean;
    function AutorizaConsultaComValidadeVigente(const ACodCli: String;
      const AMostrarMensagem: Boolean=True): Boolean;
    function ValidaStatusCliente(const ACodCli: String;
      const AStatus: array of String): Boolean;
    function PermiteNovaConsultaAnaliseLimiteCredito(const ACodCli: String): Boolean;

    procedure ConsultarAPIAnaliseLimiteCredito(const ACodCli: String;
      out AIdConsulta, AStatusConsulta: String);
    procedure ConsultarAPIResultadoAnalise(const ACodCli, AIdConsulta: String;
      out AStatusConsulta: String; out ALimiteCredito: Double);

    procedure AtualizarInformacoesNoCadastroCliente(const ACodCli, AIdConsulta,
      AStatus: String; const ADataUltimaConsulta: TDateTime;
      const ALimiteCredito: Double);
    procedure GravarIdConsultaNosPedidos(const AStlPedidos: TStringList;
      const AIdConsulta: String);
    procedure LiberarPedidos(const AIdConsulta: String; const ALimiteCredito: Double;
      const AData, AHora: TDateTime);
    procedure RegistrarOcorrenciaLimiteCredito(const ANumDoc, AEspDoc, ACodEmp,
      ACodCli: String);
    procedure RemoverIdConsultaNeocreditNoPedido(const AIncPed: String);
  public
    function ExecutarAnaliseLimiteCredito(const AStlPedidos: TStringList): Boolean;
    function AtualizarAnaliseLimiteCredito(const ACodCli: String): Boolean;
    function PermiteLiberarPedidoSemAutorizacaoNeocredit(ACodCli: String): Boolean;
  end;

implementation

uses
  Neocredit.Classe;

{ TControladorNeocredit }

function TControladorNeocredit.AtualizarAnaliseLimiteCredito(
  const ACodCli: String): Boolean;
var
  LDataConsulta,
  LHoraConsulta  : TDateTime;
  LMensagemErro  : String; 
  LStatus,
  LIdConsulta    : String;
  LLimiteCredito : Double;
begin
  If fCfgSis('NEOCHB') <> 'S' Then
    Exit(True);

  Try
    LDataConsulta  := VS_Date;
    LHoraConsulta  := fTime();
    LIdConsulta    := fCampoTabela('CLI_UIDNEO', 'CADCLI', ['CLI_CODCLI'], [ACodCli]);
    LStatus        := EmptyStr;
    LLimiteCredito := 0;

    If fEmptyStr(LIdConsulta) Then
    Begin
      {$IFNDEF LINUX}
      fMensagem('ATENÇÃO', 'Não é possível verificar o processo de '
                         + 'Análise de Crédito na Neocredit.', ['&Ok']);
      {$ENDIF LINUX}

      Exit(False);
    End;

    ConsultarAPIResultadoAnalise(ACodCli, LIdConsulta, LStatus, LLimiteCredito);

    fStartTransaction;

    AtualizarInformacoesNoCadastroCliente(ACodCli,
                                          LIdConsulta,
                                          TLibNeocredit.RetornaCodigoStatus(LStatus),
                                          LDataConsulta,
                                          LLimiteCredito);

    LiberarPedidos(LIdConsulta, LLimiteCredito, LDataConsulta, LHoraConsulta);

    Result := True;

    fCommit;
  Except
    on E:Exception Do
    Begin
      Result := False;

      LMensagemErro := 'Ocorreu um erro durante a análise de limite '
                     + 'de crédito do cliente '+fRetNomCliente(ACodCli)+'. '
                     + #13#10 + E.Message;      

      If fInTransaction Then
        fRollback;

      {$IFDEF LINUX}
      raise Exception.Create(LMensagemErro);
      {$ELSE}
      fMensagem('ATENÇÃO', LMensagemErro, ['&Ok']);
      {$ENDIF LINUX}
    End;
  End;
end;

procedure TControladorNeocredit.AtualizarInformacoesNoCadastroCliente(
  const ACodCli, AIdConsulta, AStatus: String;
  const ADataUltimaConsulta: TDateTime; const ALimiteCredito: Double);
var
  LqryUpdate: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LqryUpdate := nil;
  Try
    LqryUpdate := fCriaQuery;
    LqryUpdate.SQL.Text := 'UPDATE CADCLI '
                         + '   SET CLI_STANEO = :STANEO '
                         + '     , CLI_UIDNEO = :UIDNEO '
                         + '     , CLI_UDTNEO = :UDTNEO '
                         + IIF(AStatus = TLibNeocredit.COD_STATUS_APROVADO, '     , CLI_LIMCRE = :LIMCRE ', EmptyStr)
                         + ' WHERE CLI_CODCLI = :CODCLI ';

    LqryUpdate.ParamByName('CODCLI').AsString   := ACodCli;
    LqryUpdate.ParamByName('STANEO').AsString   := AStatus;
    LqryUpdate.ParamByName('UIDNEO').AsString   := AIdConsulta;
    LqryUpdate.ParamByName('UDTNEO').AsDateTime := ADataUltimaConsulta;

    If AStatus = TLibNeocredit.COD_STATUS_APROVADO Then
      LqryUpdate.ParamByName('LIMCRE').AsFloat := ALimiteCredito;

    If AStatus = TLibNeocredit.COD_STATUS_SEM_CONSULTA Then
    Begin
      LqryUpdate.ParamByName('UIDNEO').Clear;
      LqryUpdate.ParamByName('UDTNEO').Clear;
    End;

    LqryUpdate.ExecSQL;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryUpdate);
    {$ENDIF LINUX}
  End;
end;

function TControladorNeocredit.AutorizaAnaliseLimiteCredito(
  const AStlPedidos: TStringList): Boolean;
{$IFDEF LINUX}
begin
  Result := True;
  raise Exception.Create('AutorizaAnaliseLimiteCredito ainda não possui implementação linux');
end;
{$ELSE}
var
  LobjLiberacao : TLiberacao;
  LintContador  : Integer;
  LCodCli       : String;
begin
  LobjLiberacao := TLiberacao.Create;
  Try
    LCodCli := TPedidoVenda(AStlPedidos.Objects[0]).strCodCli;

    LobjLiberacao.strDirAce    := 'LIBERACONSNEOC';
    LobjLiberacao.strCodOpe    := strLoginUsuarioLogado;
    LobjLiberacao.objMsgLibera.pAddTexto('Permitir realizar a Análise de Crédito na Neocredit?');
    LobjLiberacao.objMsgLibera.pAddTexto('Cliente..: '+LCodCli+' - '+fRetNomCliente(LCodCli));
    LobjLiberacao.objMsgLibera.pAddQuebra();
    LobjLiberacao.objMsgLibera.pAddTexto('Pedido(s):');

    For LintContador := 0 to Pred(AStlPedidos.Count) Do
      LobjLiberacao.objMsgLibera.pAddTexto(AStlPedidos.Strings[LintContador]);

    Result := LobjLiberacao.fLibera;
  Finally
    FreeAndNil(LobjLiberacao);
  End;
end;
{$ENDIF LINUX}

function TControladorNeocredit.AutorizaConsultaComValidadeVigente(
  const ACodCli: String; const AMostrarMensagem: Boolean): Boolean;
var
  LqryConsulta : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LqryConsulta := nil;
  Try
    LqryConsulta := fCriaQuery;

    LqryConsulta.Close;
    LqryConsulta.SQL.Text := 'SELECT '
                           + '       AUTOINCREM AS AUTINC '
                           + '     , CLI_UDTNEO AS UDTNEO '
                           + '  FROM CADCLI '
                           + ' WHERE CLI_CODCLI = :CODCLI ';

    LqryConsulta.ParamByName('CODCLI').AsString := ACodCli;
    LqryConsulta.Open;

    If (LqryConsulta.FieldByName('UDTNEO').AsDateTime = 0) Then
      Exit(True);

    Result := (VS_Date < (LqryConsulta.FieldByName('UDTNEO').AsDateTime + StrToIntDef(fCfgSis('NEOCDV'),0)));

    If (Not Result) And AMostrarMensagem Then
    Begin
      {$IFNDEF LINUX}
      Result := (fMensagem('CONFIRMAÇÃO',
                           Format('A última consulta foi realizada no dia [%s]. '+
                                  'Deseja realizar nova consulta?',
                                  [FormatDateTime('dd/mm/yyyy',
                                                  LqryConsulta.FieldByName('UDTNEO').AsDateTime)]),
                          ['&Sim', '&Não']) = 1);
      {$ELSE}
      Result := False;
      {$ENDIF LINUX}
    End;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryConsulta);
    {$ENDIF LINUX}
  End;
end;

procedure TControladorNeocredit.ConsultarAPIAnaliseLimiteCredito(
  const ACodCli: String; out AIdConsulta, AStatusConsulta: String);
var
  LjsonRetorno    : String;
  Lesteira        : TEsteiraNeocredit;
  LretornoEsteira : TRetornoEsteiraNeocredit;
  Lservice        : TServiceNeocredit;
  LqryConsulta    : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};

  function TratarValor(const AValue: Double): Double;
  begin
    Result := AValue;

    If AValue < 0 Then
      Result := 0;
  end;

  function TratarInteiro(const AValue: Integer): Integer;
  begin
    Result := AValue;

    If AValue < 0 Then
      Result := 0;
  end;

  function TratarData(const AValue: String): String;
  begin
    Result := AValue;

    If StrToDateDef(AValue, 0) = 0 Then
      Result := EmptyStr;
  end;
begin
  LqryConsulta    := nil;
  Lesteira        := nil;
  LretornoEsteira := nil;
  Lservice        := nil;

  Try
    LqryConsulta    := fCriaQuery;
    Lesteira        := TEsteiraNeocredit.Create;
    LretornoEsteira := TRetornoEsteiraNeocredit.Create;
    Lservice        := TServiceNeocredit.Create;

    AIdConsulta     := EmptyStr;
    AStatusConsulta := EmptyStr;

    LqryConsulta.Close;
    LqryConsulta.SQL.Text := 'SELECT '
                           + '       CLI_C_G_C_ AS DOCUMENTO '
                           + '     , CLI_NOMCLI AS RAZAO '
                           + '     , ""         AS RISCO '
                           + '     , "SUCESSO NA CONSULTA"         AS MENSAGEM '
                           + '     , CLI_CODCLI AS ID_CLIENTE '
                           + '     , ROUND((SELECT MAX(DATEDIFF(CURRENT_DATE, CADREC.CTR_DTAVEN)) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND IFNULL(CADREC.CTR_DTAREC,"") = ""),0) AS MAIOR_ATRASO '
                           + '     , ROUND((SELECT AVG(DATEDIFF(CURRENT_DATE, CADREC.CTR_DTAVEN)) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND IFNULL(CADREC.CTR_DTAREC,"") = ""),0) AS MEDIA_ATRASO '
                           + '     , CLI_DTACAD AS DATA_CADASTRO '
                           + '     , ROUND((SELECT SUM(CADREC.CTR_VALREC) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND IFNULL(CADREC.CTR_DTAREC,"") <> ""),2) AS VALOR_TOTAL_PAGO '
                           + '     , ROUND(CLI_LIMCRE,2) AS LIMITE_CREDITO '
                           + '     , ROUND((IFNULL(CLI_LIMCRE,0) '
                           + '           -  IFNULL((SELECT SUM(CADREC.CTR_VALORI) '
                           + '                        FROM CADREC '
                           + '                       WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                         AND CADREC.CTR_VALORI > 0),0) '
                           + '           +  IFNULL((SELECT SUM(CADREC.CTR_VALREC) '
                           + '                        FROM CADREC '
                           + '                       WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                         AND CADREC.CTR_VALORI > 0),0)), 2) AS LIMITE_DISPONIVEL '
                           + '     , ROUND((SELECT MAX(DATEDIFF(CADREC.CTR_DTAREC,CADREC.CTR_DTAVEN)) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTAREC > CADREC.CTR_DTAVEN),0) AS MAIOR_ATRASO_PAGO '
                           + '     , (SELECT MAX(CTR_DTACAD) '
                           + '          FROM CADREC '
                           + '         WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '           AND CADREC.CTR_VALORI > 0) AS DATA_ULTIMA_COMPRA '
                           + '     , ROUND((SELECT IFNULL(COUNT(DISTINCT CONCAT(CTR_NUMDUP,CTR_ESPDOC,CTR_CODEMP)),0) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0),0) AS QUANTIDADE_COMPRAS '
                           + '     , ROUND((SELECT SUM(CTR_VALORI) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND IFNULL(CADREC.CTR_DTAREC,"") = ""),2) AS VALOR_TOTAL_ABERTO '
                           + '     , ROUND((SELECT SUM(CTR_VALORI) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0),2) AS VALOR_TOTAL_COMPRAS '
                           + '     , (SELECT MIN(CTR_DTACAD) '
                           + '          FROM CADREC '
                           + '         WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '           AND CADREC.CTR_VALORI > 0) AS DATA_PRIMEIRA_COMPRA '
                           + '     , (CLI_UDTNEO + INTERVAL IFNULL((SELECT CAST(SIS_VALCFG AS SIGNED) FROM CFGSIS '
                           + '                                       WHERE SIS_CODEMP = :CODEMP '
                           + '                                         AND SIS_CODCFG = "CFG_NEOCDV"), 0) DAY) AS DATA_VALIDADE_LIMITE '
                           + '     , CLI_UDTNEO AS DATA_ATUALIZACAO_LIMITE '
                           + '     , (CASE '
                           + '          WHEN (SELECT COUNT(CADREC.AUTOINCREM) FROM CADREC '
                           + '                 WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                   AND CADREC.CTR_VALORI > 0 '
                           + '                   AND IFNULL(CADREC.CTR_DTAREC,"") = "" '
                           + '                   AND CURRENT_DATE > CADREC.CTR_DTAVEN '
                           + '                 LIMIT 1) > 0 THEN '
                           + '            "SIM" '
                           + '        ELSE '
                           + '          "NÃO" '
                           + '        END) AS POSSUI_ATRASO_ABERTO '
                           + '     , ROUND((SELECT IFNULL(COUNT(DISTINCT CONCAT(CTR_NUMDUP,CTR_ESPDOC,CTR_CODEMP)),0) '
                           + '                FROM (SELECT (IFNULL(SUM(CTR_VALORI),0)- '
                           + '                              IFNULL(SUM(CTR_VALREC),0)) AS SALDO_BAIXAR '
                           + '                           , CADREC.CTR_NUMDUP '
                           + '                           , CADREC.CTR_ESPDOC '
                           + '                           , CADREC.CTR_CODEMP '
                           + '                           , CTR_CODCLI '
                           + '                        FROM CADREC '
                           + '                       WHERE IFNULL(CADREC.CTR_DTAREC, "") <> "" '
                           + '                         AND CADREC.CTR_VALORI > 0 '
                           + '                       GROUP BY '
                           + '                             CADREC.CTR_NUMDUP '
                           + '                           , CADREC.CTR_ESPDOC '
                           + '                           , CADREC.CTR_CODEMP '
                           + '                           , CADREC.CTR_CODCLI) AS CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.SALDO_BAIXAR=0),0) AS QUANTIDADE_COMPRAS_PAGAS '
                           + '     , ROUND((SELECT IFNULL(COUNT(DISTINCT CONCAT(CTR_NUMDUP,CTR_ESPDOC,CTR_CODEMP)),0) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0),0) AS QUANTIDADE_COMPRAS_PRAZO '
                           + '     , ROUND((SELECT IFNULL(COUNT(DISTINCT CONCAT(CTR_NUMDUP,CTR_ESPDOC,CTR_CODEMP)),0) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND IFNULL(CADREC.CTR_DTAREC, "") = "" ),0) AS QUANTIDADE_COMPRAS_ABERTO '
                           + '     , ROUND((SELECT SUM(CTR_VALREC) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTAREC BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) AND CURRENT_DATE),2) AS VALOR_TOTAL_PAGO_6_MESES '
                           + '     , ROUND((SELECT SUM(CTR_VALREC) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTAREC BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH) AND CURRENT_DATE),2) AS VALOR_TOTAL_PAGO_12_MESES '
                           + '     , ROUND((SELECT SUM(CTR_VALREC) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTAREC BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 24 MONTH) AND CURRENT_DATE),2) AS VALOR_TOTAL_PAGO_24_MESES '
                           + '     , ROUND((SELECT SUM(CTR_VALORI) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTACAD BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) AND CURRENT_DATE),2) AS VALOR_TOTAL_COMPRAS_6_MESES '
                           + '     , ROUND((SELECT SUM(CTR_VALORI) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTACAD BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH) AND CURRENT_DATE),2) AS VALOR_TOTAL_COMPRAS_12_MESES '
                           + '     , ROUND((SELECT SUM(CTR_VALORI) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTACAD BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 24 MONTH) AND CURRENT_DATE),2) AS VALOR_TOTAL_COMPRAS_24_MESES '
                           + '     , ROUND((SELECT MAX(DATEDIFF(CADREC.CTR_DTAREC,CADREC.CTR_DTAVEN)) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTAREC > CADREC.CTR_DTAVEN '
                           + '                 AND CADREC.CTR_DTAREC BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH) AND CURRENT_DATE),2) AS MAIOR_ATRASO_PAGO_12_MESES '
                           + '     , ROUND((SELECT MAX(DATEDIFF(CADREC.CTR_DTAREC,CADREC.CTR_DTAVEN)) '
                           + '                FROM CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                 AND CADREC.CTR_VALORI > 0 '
                           + '                 AND CADREC.CTR_DTAREC > CADREC.CTR_DTAVEN '
                           + '                 AND CADREC.CTR_DTAREC BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 24 MONTH) AND CURRENT_DATE),2) AS MAIOR_ATRASO_PAGO_24_MESES '
                           + '     , ROUND((SELECT AVG(TOTAL_MES) '
                           + '                FROM (SELECT SUM(CTR_VALORI) AS TOTAL_MES '
                           + '                           , DATE_FORMAT(CTR_DTACAD, "%Y-%m") AS MES_ANO '
                           + '                           , CADREC.CTR_CODCLI '
                           + '                        FROM CADREC '
                           + '                       WHERE CADREC.CTR_VALORI > 0 '
                           + '                       GROUP BY '
                           + '                             DATE_FORMAT(CTR_DTACAD, "%Y-%m") '
                           + '                           , CADREC.CTR_CODCLI) AS CADREC '
                           + '               WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI),2) AS VALOR_COMPRA_MEDIA_MENSAL '
                           + '     , ROUND(((SELECT IFNULL(SUM(CADREC.CTR_VALREC),0) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAREC <= CADREC.CTR_DTAVEN) '
                           + '           /  (SELECT SUM(CADREC.CTR_VALORI) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0) * 100),2) AS PERCENTUAL_PAGAMENTOS_PONTUAIS '
                           + '     , ROUND(((SELECT IFNULL(SUM(CADREC.CTR_VALREC),0) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAREC > CADREC.CTR_DTAVEN '
                           + '                  AND CADREC.CTR_DTAREC <= CADREC.CTR_DTAVEN + INTERVAL 5 DAY) '
                           + '           /  (SELECT SUM(CADREC.CTR_VALORI) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAREC > CADREC.CTR_DTAVEN) * 100),2) AS PERCENTUAL_PAGAMENTOS_PAGOS_ATE_5_DIAS '
                           + '     , ROUND(((SELECT IFNULL(SUM(CADREC.CTR_VALREC),0) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAREC <= CADREC.CTR_DTAVEN '
                           + '                  AND CADREC.CTR_DTAVEN BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) AND CURRENT_DATE) '
                           + '           /  (SELECT SUM(CADREC.CTR_VALORI) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAVEN BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) AND CURRENT_DATE) * 100),2) AS PERCENTUAL_PAGAMENTOS_PONTUAIS_6_MESES '
                           + '     , ROUND(((SELECT IFNULL(SUM(CADREC.CTR_VALREC),0) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAREC <= CADREC.CTR_DTAVEN '
                           + '                  AND CADREC.CTR_DTAVEN BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH) AND CURRENT_DATE) '
                           + '           /  (SELECT SUM(CADREC.CTR_VALORI) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAVEN BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH) AND CURRENT_DATE) * 100),2) AS PERCENTUAL_PAGAMENTOS_PONTUAIS_12_MESES '
                           + '     , ROUND(((SELECT IFNULL(SUM(CADREC.CTR_VALREC),0) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAREC <= CADREC.CTR_DTAVEN '
                           + '                  AND CADREC.CTR_DTAVEN BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 24 MONTH) AND CURRENT_DATE) '
                           + '           /  (SELECT SUM(CADREC.CTR_VALORI) '
                           + '                 FROM CADREC '
                           + '                WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                  AND CADREC.CTR_VALORI > 0 '
                           + '                  AND CADREC.CTR_DTAVEN BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 24 MONTH) AND CURRENT_DATE) * 100),2) AS PERCENTUAL_PAGAMENTOS_PONTUAIS_24_MESES '
                           + '     , ROUND(IFNULL((IFNULL(CLI_LIMCRE,0) '
                           + '                  -  IFNULL((SELECT SUM(CADREC.CTR_VALORI) '
                           + '                               FROM CADREC '
                           + '                              WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                                AND CADREC.CTR_VALORI > 0),0) '
                           + '                  +  IFNULL((SELECT SUM(CADREC.CTR_VALREC) '
                           + '                               FROM CADREC '
                           + '                              WHERE CADREC.CTR_CODCLI = CADCLI.CLI_CODCLI '
                           + '                                AND CADREC.CTR_VALORI > 0),0)) '
                           + '                  / IFNULL(CLI_LIMCRE,0),0),2) AS PERCENTUAL_LIMITE_DISPONIVEL '
                           + '  FROM CADCLI '
                           + ' WHERE CLI_CODCLI = :CODCLI ';

    LqryConsulta.ParamByName('CODCLI').AsString := ACodCli;
    LqryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LqryConsulta.Open;

    If LqryConsulta.IsEmpty Then
    Begin
      raise Exception.Create('Houve um problema durante o processo de envio das informações '
                            +'do histórico financeiro do cliente para análise de crédito.');
    End;

    LqryConsulta.First;

    Lesteira.Documento                           := LqryConsulta.FieldByName('DOCUMENTO').AsString;
    Lesteira.Cnpj                                := LqryConsulta.FieldByName('DOCUMENTO').AsString;
    Lesteira.Razao                               := LqryConsulta.FieldByName('RAZAO').AsString;
    Lesteira.Risco                               := LqryConsulta.FieldByName('RISCO').AsString;
    Lesteira.Mensagem                            := LqryConsulta.FieldByName('MENSAGEM').AsString;
    Lesteira.IdCliente                           := LqryConsulta.FieldByName('ID_CLIENTE').AsString;
    Lesteira.MaiorAtraso                         := TratarInteiro(LqryConsulta.FieldByName('MAIOR_ATRASO').AsInteger);
    Lesteira.MediaAtraso                         := TratarInteiro(LqryConsulta.FieldByName('MEDIA_ATRASO').AsInteger);
    Lesteira.DataCadastro                        := TratarData(FormatDateTime('dd/mm/yyyy', LqryConsulta.FieldByName('DATA_CADASTRO').AsDateTime));
    Lesteira.ValorTotalPago                      := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_PAGO').AsFloat);
    Lesteira.LimiteDeCredito                     := TratarValor(LqryConsulta.FieldByName('LIMITE_CREDITO').AsFloat);
    Lesteira.LimiteDisponivel                    := TratarValor(LqryConsulta.FieldByName('LIMITE_DISPONIVEL').AsFloat);
    Lesteira.MaiorAtrasoPago                     := TratarInteiro(LqryConsulta.FieldByName('MAIOR_ATRASO_PAGO').AsInteger);
    Lesteira.DataUltimaCompra                    := TratarData(FormatDateTime('dd/mm/yyyy', LqryConsulta.FieldByName('DATA_ULTIMA_COMPRA').AsDateTime));
    Lesteira.QuantidadeCompras                   := TratarInteiro(LqryConsulta.FieldByName('QUANTIDADE_COMPRAS').AsInteger);
    Lesteira.ValorTotalAberto                    := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_ABERTO').AsFloat);
    Lesteira.ValorTotalCompras                   := TratarValor(TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_COMPRAS').AsFloat));
    Lesteira.DataPrimeiraCompra                  := TratarData(FormatDateTime('dd/mm/yyyy', LqryConsulta.FieldByName('DATA_PRIMEIRA_COMPRA').AsDateTime));
    Lesteira.DataValidadeLimite                  := TratarData(FormatDateTime('dd/mm/yyyy', LqryConsulta.FieldByName('DATA_VALIDADE_LIMITE').AsDateTime));
    Lesteira.PossuiAtrasoAberto                  := LqryConsulta.FieldByName('POSSUI_ATRASO_ABERTO').AsString;
    Lesteira.DataAtualizacaoLimite               := TratarData(FormatDateTime('dd/mm/yyyy', LqryConsulta.FieldByName('DATA_ATUALIZACAO_LIMITE').AsDateTime));
    Lesteira.QuantidadeComprasPagas              := TratarInteiro(LqryConsulta.FieldByName('QUANTIDADE_COMPRAS_PAGAS').AsInteger);
    Lesteira.QuantidadeComprasPrazo              := TratarInteiro(LqryConsulta.FieldByName('QUANTIDADE_COMPRAS_PRAZO').AsInteger);
    Lesteira.QuantidadeComprasAberto             := TratarInteiro(LqryConsulta.FieldByName('QUANTIDADE_COMPRAS_ABERTO').AsInteger);
    Lesteira.ValorCompraMediaMensal              := TratarValor(LqryConsulta.FieldByName('VALOR_COMPRA_MEDIA_MENSAL').AsFloat);
    Lesteira.ValorTotalPago6Meses                := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_PAGO_6_MESES').AsFloat);
    Lesteira.ValorTotalPago12Meses               := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_PAGO_12_MESES').AsFloat);
    Lesteira.ValorTotalPago24Meses               := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_PAGO_24_MESES').AsFloat);
    Lesteira.MaiorAtrasoPago12Meses              := TratarInteiro(LqryConsulta.FieldByName('MAIOR_ATRASO_PAGO_12_MESES').AsInteger);
    Lesteira.MaiorAtrasoPago24Meses              := TratarInteiro(LqryConsulta.FieldByName('MAIOR_ATRASO_PAGO_24_MESES').AsInteger);
    Lesteira.ValorTotalCompras6Meses             := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_COMPRAS_6_MESES').AsFloat);
    Lesteira.ValorTotalCompras12Meses            := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_COMPRAS_12_MESES').AsFloat);
    Lesteira.ValorTotalCompras24Meses            := TratarValor(LqryConsulta.FieldByName('VALOR_TOTAL_COMPRAS_24_MESES').AsFloat);
    Lesteira.PercentualLimiteDisponivel          := TratarValor(LqryConsulta.FieldByName('PERCENTUAL_LIMITE_DISPONIVEL').AsFloat);
    Lesteira.PercentualPagamentosPagosAte5Dias   := TratarValor(LqryConsulta.FieldByName('PERCENTUAL_PAGAMENTOS_PAGOS_ATE_5_DIAS').AsFloat);
    Lesteira.PercentualPagamentosPontuais        := TratarValor(LqryConsulta.FieldByName('PERCENTUAL_PAGAMENTOS_PONTUAIS').AsFloat);
    Lesteira.PercentualPagamentosPontuais6Meses  := TratarValor(LqryConsulta.FieldByName('PERCENTUAL_PAGAMENTOS_PONTUAIS_6_MESES').AsFloat);
    Lesteira.PercentualPagamentosPontuais12Meses := TratarValor(LqryConsulta.FieldByName('PERCENTUAL_PAGAMENTOS_PONTUAIS_12_MESES').AsFloat);
    Lesteira.PercentualPagamentosPontuais24Meses := TratarValor(LqryConsulta.FieldByName('PERCENTUAL_PAGAMENTOS_PONTUAIS_24_MESES').AsFloat);

    If Lservice.AnalisarCredito(Lesteira.AsJson, LjsonRetorno) Then
    Begin
      LretornoEsteira.AsJson := LjsonRetorno;

      AIdConsulta     := LretornoEsteira.Id.ToString;
      AStatusConsulta := LretornoEsteira.Status;
    End
    Else
      raise Exception.Create('Houve um problema durante a tentativa de '
                            +'comunicação com a API da Neocredit.'+#13#10
                            +'HTTP '+ IntToStr(Lservice.StatusCode) + ' - ' + LjsonRetorno);
  Finally
    FreeAndNil(Lesteira);
    FreeAndNil(LretornoEsteira);
    FreeAndNil(Lservice);
    FreeAndNil(LqryConsulta);
  End;
end;

procedure TControladorNeocredit.ConsultarAPIResultadoAnalise(const ACodCli,
  AIdConsulta: String; out AStatusConsulta: String; out ALimiteCredito: Double);
var
  LjsonRetorno   : String;
  LstatusEsteira : TStatusEsteiraNeocredit;
  Lservice       : TServiceNeocredit;
  LFmt           : TFormatSettings;
begin
  LstatusEsteira := nil;
  Lservice       := nil;

  Try
    LstatusEsteira := TStatusEsteiraNeocredit.Create;
    Lservice       := TServiceNeocredit.Create;
    LFmt           := TFormatSettings.Create;
    LFmt.DecimalSeparator := '.';

    If Lservice.ConsultarProcessoAnalisarCredito(AIdConsulta, LjsonRetorno) Then
    Begin
      LstatusEsteira.AsJson := LjsonRetorno;

      if MatchStr(Uppercase(LstatusEsteira.Status), ['PROCESSANDO','AGUARDANDO_PARECER']) then
        AStatusConsulta := LstatusEsteira.Status
      else
        AStatusConsulta := LstatusEsteira.Campos.Status;

      If Not TryStrToFloat(LstatusEsteira.Campos.LimiteSugerido, ALimiteCredito, LFmt) Then
        ALimiteCredito := 0;
    End
    Else
      raise Exception.Create('Houve um problema durante a tentativa de '
                            +'comunicação com a API da Neocredit.'+#13#10
                            +'HTTP '+ IntToStr(Lservice.StatusCode) + ' - ' + LjsonRetorno);
  Finally
    FreeAndNil(LstatusEsteira);
    FreeAndNil(Lservice);
  End;
end;

function TControladorNeocredit.ExecutarAnaliseLimiteCredito(
  const AStlPedidos: TStringList): Boolean;
{$IFDEF LINUX}
begin
  Result := True;
  raise Exception.Create('ExecutarAnaliseLimiteCredito ainda não possui implementação linux');
end;
{$ELSE}
var
  LDataConsulta : TDateTime;
  LCodCli,
  LStatus,
  LIdConsulta   : String;
begin
  If fCfgSis('NEOCHB') <> 'S' Then
    Exit(True);

  If AStlPedidos.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum pedido de cliente foi enviado para a '
                       + 'Análise de Crédito na Neocredit.', ['&Ok']);

    Exit(False);
  End;

  If Not AutorizaAnaliseLimiteCredito(AStlPedidos) Then
    Exit(False);

  Try
    LCodCli := TPedidoVenda(AStlPedidos.Objects[0]).strCodCli;

    If Not PermiteNovaConsultaAnaliseLimiteCredito(LCodCli) Then
      Exit(False);

    If Not AutorizaConsultaComValidadeVigente(LCodCli) Then
      Exit(False);

    LDataConsulta  := VS_Date;
    LIdConsulta    := EmptyStr;
    LStatus        := EmptyStr;

    ConsultarAPIAnaliseLimiteCredito(LCodCli, LIdConsulta, LStatus);

    fStartTransaction;

    AtualizarInformacoesNoCadastroCliente(LCodCli,
                                          LIdConsulta,
                                          TLibNeocredit.RetornaCodigoStatus(LStatus),
                                          LDataConsulta,
                                          0);

    GravarIdConsultaNosPedidos(AStlPedidos, LIdConsulta);

    Result := True;
    fCommit;
  Except
    on E:Exception Do
    Begin
      Result := False;

      If fInTransaction Then
        fRollback;

      fMensagem('ATENÇÃO', 'Ocorreu um erro durante a análise de limite '
                         + 'de crédito do cliente '+fRetNomCliente(LCodCli)+'. '
                         + #13#10 + E.Message, ['&Ok']);
    End;
  End;
end;
{$ENDIF LINUX}

procedure TControladorNeocredit.GravarIdConsultaNosPedidos(
  const AStlPedidos: TStringList; const AIdConsulta: String);
{$IFDEF LINUX}
begin
  raise Exception.Create('GravarIdConsultaNosPedidos ainda não possui implementação linux');
end;
{$ELSE}
var
  LqryUpdate   : TUniQuery;
  LintContador : Integer;
  LobjPedido   : TPedidoVenda;
begin
  LqryUpdate   := nil;
  Try
    LqryUpdate := fCriaQuery;

    LQryUpdate.Close;
    LQryUpdate.SQL.Text := 'UPDATE EXTGOR '
                         + '   SET FGO_UIDNEO = :UIDNEO '
                         + ' WHERE EXISTS (SELECT AUTOINCREM FROM FATGOR '
                         + '                WHERE FGO_SEQFGO = AUTOINCREM '
                         + '                  AND FGO_NUMDOC = :NUMDOC '
                         + '                  AND FGO_ESPDOC = :ESPDOC '
                         + '                  AND FGO_CODEMP = :CODEMP) ';

    For LintContador := 0 To Pred(AStlPedidos.Count) Do
    Begin
      LobjPedido := TPedidoVenda(AStlPedidos.Objects[LintContador]);

      LQryUpdate.Close;
      LQryUpdate.ParamByName('NUMDOC').AsString := LobjPedido.strNumDoc;
      LQryUpdate.ParamByName('ESPDOC').AsString := LobjPedido.strEspDoc;
      LQryUpdate.ParamByName('CODEMP').AsString := LobjPedido.strCodEmp;
      LQryUpdate.ParamByName('UIDNEO').AsString := AIdConsulta;
      LQryUpdate.ExecSQL;
    End;
  Finally
    FreeAndNil(LqryUpdate);
  End;
end;
{$ENDIF LINUX}

procedure TControladorNeocredit.LiberarPedidos(const AIdConsulta: String;
  const ALimiteCredito: Double; const AData, AHora: TDateTime);
var
  LqryConsulta,
  LqryUpdate   : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LSaldoLimite : Double;
begin
  If fCfgSis('NEOCLA') <> 'S' Then
    Exit;

  LqryUpdate   := nil;
  LqryConsulta := nil;
  Try
    LqryUpdate   := fCriaQuery;
    LqryConsulta := fCriaQuery;
    LSaldoLimite := ALimiteCredito;

    LQryUpdate.Close;
    LQryUpdate.SQL.Text := 'UPDATE FATGOR '
                         + '   SET FGO_LIBERA = 1 '
                         + '     , FGO_LIBCOM = 1 '
                         + '     , FGO_OPELIB = "999" '
                         + '     , FGO_DIGLIB = "999" '
                         + '     , FGO_DTALIB = :DTALIB '
                         + '     , FGO_HORLIB = :HORLIB '
                         + '     , FGO_OBSL01 = :OBSL01 '
                         + ' WHERE AUTOINCREM = :AUTINC '
                         + '   AND FGO_NTRAVA = "SNNNNNNNNNNNNNNNNNNN" '
                         + '   AND FGO_LIBERA = 0 '
                         + '   AND FGO_LIBCOM <> 0 ';

    LqryConsulta.Close;
    LqryConsulta.SQL.Text := 'SELECT '
                           + '       FATGOR.AUTOINCREM AS AUTINC '
                           + '     , FATGOR.FGO_NUMDOC AS NUMDOC '
                           + '     , FATGOR.FGO_ESPDOC AS ESPDOC '
                           + '     , FATGOR.FGO_CODEMP AS CODEMP '
                           + '     , FATGOR.FGO_CODCLI AS CODCLI '
                           + '     , FATGOR.FGO_VLRCON AS VLRCON '
                           + '     , CADCLI.CLI_STANEO AS STANEO '
                           + '     , FATGOR.FGO_MOTBAI AS MOTBAI '
                           + '  FROM FATGOR '
                           + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                           + ' INNER JOIN CADCLI ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI '
                           + ' WHERE EXTGOR.FGO_UIDNEO = :UIDNEO '
                           + '   AND FATGOR.FGO_NTRAVA = "SNNNNNNNNNNNNNNNNNNN" '
                           + '   AND FATGOR.FGO_LIBERA = 0 '
                           + '   AND FATGOR.FGO_LIBCOM <> 0 ';

    LQryConsulta.Close;
    LQryConsulta.ParamByName('UIDNEO').AsString := AIdConsulta;
    LQryConsulta.Open;

    If LQryConsulta.IsEmpty Then
      Exit;

    LQryConsulta.First;
    While Not LQryConsulta.Eof Do
    Begin
      If (LQryConsulta.FieldByName('STANEO').AsString = TLibNeocredit.COD_STATUS_REPROVADO) Or
        (Not fEmptyStr(LQryConsulta.FieldByName('MOTBAI').AsString)) Then
        RemoverIdConsultaNeocreditNoPedido(LQryConsulta.FieldByName('AUTINC').AsString)

      Else If LQryConsulta.FieldByName('STANEO').AsString = TLibNeocredit.COD_STATUS_APROVADO Then
      Begin
        If (LQryConsulta.FieldByName('VLRCON').AsFloat > LSaldoLimite) Then
          RemoverIdConsultaNeocreditNoPedido(LQryConsulta.FieldByName('AUTINC').AsString)
        Else
        Begin
          LQryUpdate.Close;
          LQryUpdate.ParamByName('AUTINC').AsString := LQryConsulta.FieldByName('AUTINC').AsString;
          LQryUpdate.ParamByName('DTALIB').AsDate   := AData;
          LQryUpdate.ParamByName('HORLIB').AsTime   := AHora;
          LQryUpdate.ParamByName('OBSL01').AsString := 'LIBERAÇÃO AUTOMÁTICA PELA CONSULTA NEOCREDIT';
          LQryUpdate.ExecSQL;

          LSaldoLimite := LSaldoLimite
                        - LQryConsulta.FieldByName('VLRCON').AsFloat;

          If fCfgSis('UTICRM') = 'S' Then
          Begin
            RegistrarOcorrenciaLimiteCredito(
              LQryConsulta.FieldByName('NUMDOC').AsString,
              LQryConsulta.FieldByName('ESPDOC').AsString,
              LQryConsulta.FieldByName('CODEMP').AsString,
              LQryConsulta.FieldByName('CODCLI').AsString);
          End;
        End;
      End;

      LQryConsulta.Next;
    End;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryUpdate);
    FreeAndNil(LqryConsulta);
    {$ENDIF LINUX}
  End;
end;

function TControladorNeocredit.PermiteLiberarPedidoSemAutorizacaoNeocredit(
  ACodCli: String): Boolean;
{$IFDEF LINUX}
begin
  Result := True;
  raise Exception.Create('PermiteLiberarPedidoSemAutorizacaoNeocredit ainda não possui implementação linux');
end;
{$ELSE}
var
  LobjLiberacao : TLiberacao;
begin
  Result := True;

  If fCfgSis('NEOCHB') <> 'S' Then
    Exit;

  If (Not ValidaStatusCliente(ACodCli, [TLibNeocredit.COD_STATUS_APROVADO])) Or
     (Not AutorizaConsultaComValidadeVigente(ACodCli, False)) Then
  Begin
    LobjLiberacao := TLiberacao.Create;
    Try
      LobjLiberacao.strDirAce    := 'LIBERAPEDSEMAPROVACAONEOC';
      LobjLiberacao.strCodOpe    := strLoginUsuarioLogado;
      LobjLiberacao.objMsgLibera.pAddTexto('Permitir liberação direta de pedido sem aprovação de Análise de Crédito na Neocredit?');
      LobjLiberacao.objMsgLibera.pAddTexto('Cliente..: '+ACodCli+' - '+fRetNomCliente(ACodCli));

      Result := LobjLiberacao.fLibera;
    Finally
      FreeAndNil(LobjLiberacao);
    End;
  End;
end;
{$ENDIF LINUX}

function TControladorNeocredit.PermiteNovaConsultaAnaliseLimiteCredito(
  const ACodCli: String): Boolean;
begin
  If ValidaStatusCliente(ACodCli, [TLibNeocredit.COD_STATUS_PROCESSANDO,
                                   TLibNeocredit.COD_STATUS_AGUARDANDO_PARECER]) Then
  Begin
    {$IFNDEF LINUX}
    fMensagem('ATENÇÃO', 'Existe uma análise em processamento ou aguardando parecer. ' +
                         'É necessário que ela tenha um resultado final para que ' +
                         'uma nova análise de limite de crédito possa ser realizada ' +
                         'para o cliente '+fRetNomCliente(ACodCli)+'.', ['&Ok']);
    {$ENDIF LINUX}

    Exit(False);
  End;

  Result := True;
end;

procedure TControladorNeocredit.RegistrarOcorrenciaLimiteCredito(const ANumDoc,
  AEspDoc, ACodEmp, ACodCli: String);
var
  LobjOcoCrm : TAtuOcoCrm;
begin
  LobjOcoCrm := nil;

  Try
    LobjOcoCrm := TAtuOcoCrm.Create(nil);
    LobjOcoCrm.pCarregaOcorrenciaCliente(ANumDoc,
                                         AEspDoc,
                                         ACodEmp,
                                         ACodCli);

    LobjOcoCrm.strNumDoc := ANumDoc;
    LobjOcoCrm.strEspDoc := AEspDoc;
    LobjOcoCrm.strCodEmp := ACodEmp;
    LobjOcoCrm.strCodCli := ACodCli;
    LobjOcoCrm.strDtaInc := VS_Date;
    LobjOcoCrm.strHorInc := fRetHoraServidor();
    LobjOcoCrm.strDtaAge := LobjOcoCrm.strDtaInc;
    LobjOcoCrm.strHorAge := LobjOcoCrm.strHorInc;
    LobjOcoCrm.strDtaCon := LobjOcoCrm.strDtaInc;
    LobjOcoCrm.strHorCon := LobjOcoCrm.strHorInc;
    LobjOcoCrm.strOpeHis := strLoginUsuarioLogado;
    LobjOcoCrm.strCodOpe := strLoginUsuarioLogado;
    LobjOcoCrm.strNomFrm := '[Neocredit.Controlador.RegistrarOcorrenciaLimiteCredito]';
    LobjOcoCrm.strDescri := 'LIBERAÇÃO AUTOMÁTICA PELA CONSULTA NEOCREDIT';
    LobjOcoCrm.strCodEmp := VS_strCodEmp;
    LobjOcoCrm.pInsereHistoricoOcorrencia;
  Finally
    FreeAndNil(LobjOcoCrm);
  End;
end;

procedure TControladorNeocredit.RemoverIdConsultaNeocreditNoPedido(
  const AIncPed: String);
var
  LqryUpdate : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LqryUpdate := nil;
  Try
    LqryUpdate := fCriaQuery;

    LQryUpdate.Close;
    LQryUpdate.SQL.Text := 'UPDATE EXTGOR '
                         + '   SET FGO_UIDNEO = :UIDNEO '
                         + ' WHERE FGO_SEQFGO = :AUTINC ';

    LQryUpdate.Close;
    LQryUpdate.ParamByName('AUTINC').AsString := AIncPed;
    LQryUpdate.ParamByName('UIDNEO').AsString := EmptyStr;
    LQryUpdate.ParamByName('UIDNEO').Clear;
    LQryUpdate.ExecSQL;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryUpdate);
    {$ENDIF LINUX}
  End;
end;

function TControladorNeocredit.ValidaStatusCliente(const ACodCli: String;
  const AStatus: array of String): Boolean;
var
  LqryConsulta : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LqryConsulta := nil;
  Try
    LqryConsulta := fCriaQuery;

    LqryConsulta.Close;
    LqryConsulta.SQL.Text := 'SELECT '
                           + '       AUTOINCREM AS AUTINC '
                           + '     , CLI_STANEO AS STANEO '
                           + '  FROM CADCLI '
                           + ' WHERE CLI_CODCLI = :CODCLI ';

    LqryConsulta.ParamByName('CODCLI').AsString := ACodCli;
    LqryConsulta.Open;

    Result := MatchStr(LqryConsulta.FieldByName('STANEO').AsString, AStatus);
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryConsulta);
    {$ENDIF LINUX}
  End;
end;

end.

