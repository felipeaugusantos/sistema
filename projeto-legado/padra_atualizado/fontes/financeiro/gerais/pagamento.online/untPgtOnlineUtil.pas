unit untPgtOnlineUtil;

interface

uses
  cxProgressBar, SysUtils, Types, StrUtils, Uni, untPgtOnlineApi;

type
  TArrayDados = array of string ;
  TOpcaoRetorno = (orEmail, orWhatsApp) ;
  TOpcaoValidaEnvioEmail = (ovSimAlerta, ovSimPergunta) ;

  TValidaEnvioEmailLinkPgt = class
  private
    class function fPodeEnviarUsandoConfOperador(var AstrMsgRetorno: String;
                                    const AValidaEmail: TOpcaoValidaEnvioEmail;
                                    const AstrMsgPrefixo: String): Boolean ;
    class function fPodeEnviarUsandoEmaSai(var AstrMsgRetorno: String;
                                    const AValidaEmail: TOpcaoValidaEnvioEmail;
                                    const AstrMsgPrefixo: String): Boolean ;
  public
    class function fPodeEnviarEmail(var AstrMsgRetorno: String;
                                    const AValidaEmail: TOpcaoValidaEnvioEmail;
                                    const AstrMsgPrefixo: String): Boolean ;
  end ;

const
  ArrayOpcaoRetorno : array[TOpcaoRetorno] of String = ('E', 'W');
  tpParcLoja = 4;
  tpParcOperadora = 3;


function fEnviaLinkPagtoOnline(strAutInc : String; const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String) : Boolean;

function fEnviaLinkPagtoOnlineCtrAgr(const AarrAutInc: TArrayAutoIncAgrupado;
                                     const AfltTotCli: Double;
                                     const AstrConPag: String;
                                     const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String) : Boolean;

function fVerificaEnviaLinkPagtoOnline(strEspDoc, strCodFpg,
  strCodCnd : String): Boolean;

function fBuscaEmailCliente(strCodCli: String): String;
function fListaEmailsCliente(const AstrCodCli: String): TArrayDados;
function fListaCelularCliente(const AstrCodCli: String): String;
function fIndexOfOpcaoRetorno(const AstrOpcao: String): integer ;

function fNotificaCliente(AstrURL: String;
                          var AstrMsgRetorno: String;
                          const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli: String;
                          const AstrLinkPgtFormaEnvio: String = '';
                          const AstrLinkPgtDestinatario: String = '';
                          const AstrTipLan: String = 'PD';
                          AarrAutInc : TArrayAutoIncAgrupado = []): Boolean ;
function fEscolheFormaEnvio(var AFormaEnvio: TOpcaoRetorno; var AstrMeioEnvioSelecionado, AstrMsgOperador: String; const AstrCodCli: String ): Boolean ;

implementation

uses
  untFuncoesSimples, untLinkPagamentoCitelRepositorio,
  untFuncoes, untFuncFat, untConstantes, Classes, untPgtOnlineEscolheTipoEnvioLink, untTypesSistema,
  untClassesComumLinkPagamentoCitel, untValidaEmailOperador, untDisparaEmailAut ;


function fEnviarEMailPorTipLan(const AstrTipLan, AstrUrl, AstrDestinatario: String; AobjPgtOnApi : TPagamentoOnline): Boolean ;
begin
  Result := False ;
  if AstrTipLan = 'PD' then
    Result := AobjPgtOnApi.fEnviarEmail(AstrURL, AstrDestinatario)
  else if AstrTipLan = 'AGR' then
    Result := AobjPgtOnApi.fEnviarEmailAgrupamentoAGR(AstrURL, AstrDestinatario) ;
end ;

function fEnviaLinkPagtoOnline(strAutInc : String; const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String) : Boolean;
  var
    objPagamentoOnline : TPagamentoOnline;
    strOperacao : String;
    intQtdParcelas : Integer;
    qryFatGor : TUniQuery;
begin
  qryFatGor := fCriaQuery;
  objPagamentoOnline := TPagamentoOnline.Create;

  try
    qryFatGor.Close;
    qryFatGor.SQL.Text :=
    'SELECT '+
    '  FGO_CODEMP, '+
    '  FGO_NUMDOC, '+
    '  FGO_ESPDOC, '+
    '  FGO_CODCLI, '+
    '  FGO_CODDIG, '+
    '  FGO_VLRCON, '+
    '  FGO_CONPAG '+
    'FROM '+
    '  FATGOR '+
    'WHERE AUTOINCREM = :AUTINC';
    qryFatGor.ParamByName('AUTINC').AsString := strAutInc;
    qryFatGor.Open;

    objPagamentoOnline.strNumDoc := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
    objPagamentoOnline.strEspDoc := qryFatGor.FieldByName('FGO_ESPDOC').AsString;
    objPagamentoOnline.strCodCli := qryFatGor.FieldByName('FGO_CODCLI').AsString;
    objPagamentoOnline.strCodOpe := qryFatGor.FieldByName('FGO_CODDIG').AsString;
    objPagamentoOnline.strCodEmp := qryFatGor.FieldByName('FGO_CODEMP').AsString;
    objPagamentoOnline.strSeqFgo := strAutInc;

    intQtdParcelas := StrToInt(LeftStr(qryFatGor.FieldByName('FGO_CONPAG').AsString, 2));

    strOperacao := 'D';
    If (StrToInt(LeftStr(qryFatGor.FieldByName('FGO_CONPAG').AsString, 2)) > 1) Then
      strOperacao := 'C';

    objPagamentoOnline.pGerarLinkPagamento(strOperacao, intQtdParcelas,
      tpParcLoja, qryFatGor.FieldByName('FGO_VLRCON').AsFloat,
      strLinkPgtFormaEnvio, strLinkPgtDestinatario);

    Result := True;
  finally
    FreeAndNil(objPagamentoOnline);
    FreeAndNil(qryFatGor);
  end;
end;

function fEnviaLinkPagtoOnlineCtrAgr(const AarrAutInc: TArrayAutoIncAgrupado;
                                     const AfltTotCli: Double;
                                     const AstrConPag: String;
                                     const strLinkPgtFormaEnvio, strLinkPgtDestinatario: String) : Boolean;
var
  objPagamentoOnline : TPagamentoOnline;
  strOperacao : String;
  intQtdParcelas : Integer;
begin
  objPagamentoOnline := TPagamentoOnline.Create;
  try
    objPagamentoOnline.arrAutInc := AarrAutInc ;
    objPagamentoOnline.strTipLan := 'AGR' ;
    objPagamentoOnline.strCodOpe := strLoginUsuarioLogado ;
    objPagamentoOnline.strCodEmp := VS_strCodEmp ;

    intQtdParcelas := StrToInt(LeftStr(AstrConPag, 2));
    strOperacao := 'C';

    objPagamentoOnline.pGerarLinkPagamento(strOperacao, intQtdParcelas,
      tpParcLoja, AfltTotCli,
      strLinkPgtFormaEnvio, strLinkPgtDestinatario);

    Result := True;
  finally
    FreeAndNil(objPagamentoOnline);
  end;
end ;

function fVerificaEnviaLinkPagtoOnline(strEspDoc, strCodFpg,
  strCodCnd : String): Boolean;
begin
  Result := True;

  if (Pos(strEspDoc, 'PD_AG_') <= 0) then
    Exit(False);

  if (strCodFpg <> '007') then
    Exit(False);

  if not TLinkPagamentoCitelCfg.fLinkPagamentoCitelLigado then
    Exit(False);

  if not TLinkPagamentoCitelRepositorio.fCondicaoPagamentoComLinkPagamento(strCodCnd) then
    Exit(False);
end;

function fBuscaEmailCliente(strCodCli: String): String;
var
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery;;
  try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  CLI_EMAIL_, ');
    qryAux.SQL.Add('  CLI_EMAIL2, ');
    qryAux.SQL.Add('  CLI_EMAIL3 ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADCLI ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CLI_CODCLI = :CODCLI ');
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.Open;

    If Not fEmptyStr(qryAux.FieldByName('CLI_EMAIL3').AsString) Then
      Result := qryAux.FieldByName('CLI_EMAIL3').AsString
    Else
    If Not fEmptyStr(qryAux.FieldByName('CLI_EMAIL_').AsString) Then
      Result := qryAux.FieldByName('CLI_EMAIL_').AsString
    Else
    If Not fEmptyStr(qryAux.FieldByName('CLI_EMAIL2').AsString) Then
      Result := qryAux.FieldByName('CLI_EMAIL2').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

{ TValidaEnvioEmailLinkPgt }

class function TValidaEnvioEmailLinkPgt.fPodeEnviarEmail(
  var   AstrMsgRetorno: String;
  const AValidaEmail: TOpcaoValidaEnvioEmail;
  const AstrMsgPrefixo: String): Boolean;
begin
  if fUsaLinkPagamentoEmaSaiCielo then
    Result := Self.fPodeEnviarUsandoEmaSai(AstrMsgRetorno, AValidaEmail, AstrMsgPrefixo)
  else
    Result := Self.fPodeEnviarUsandoConfOperador(AstrMsgRetorno, AValidaEmail, AstrMsgPrefixo) ;
end;

class function TValidaEnvioEmailLinkPgt.fPodeEnviarUsandoConfOperador(
  var AstrMsgRetorno: String; const AValidaEmail: TOpcaoValidaEnvioEmail;
  const AstrMsgPrefixo: String): Boolean;
var
  LobjValidaEmailOperador : TValidaEmailOperador;
  LstrMsg: String ;
begin
  Result := True ;

  if AValidaEmail in [ovSimAlerta, ovSimPergunta] then
  begin
    LobjValidaEmailOperador := TValidaEmailOperador.Create(strLoginUsuarioLogado);
    Try
      Result := LobjValidaEmailOperador.Validar;

      If (Not Result) Then
      begin
        LstrMsg := ifthen(fEmptyStr(AstrMsgPrefixo), '', AstrMsgPrefixo + sLineBreak) + 'As configurações para o envio de e-mail do operador "' + strLoginUsuarioLogado + '" parecem não estar funcionando corretamente.' ;
        if AValidaEmail = ovSimPergunta then
        begin
          Result := (fMensagem('', LstrMsg + sLineBreak + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'], 2) = 1) ;
          if (Not Result) then
            Exit ;
        end
        else
        begin
          AstrMsgRetorno := LstrMsg + sLineBreak + 'Notificação do link de pagamento não enviada!' ;
          Result := False ;
          Exit ;
        end ;
      end ;

    Finally
      FreeAndNil(LobjValidaEmailOperador);
    End;
  end ;

end;

class function TValidaEnvioEmailLinkPgt.fPodeEnviarUsandoEmaSai(
  var AstrMsgRetorno: String; const AValidaEmail: TOpcaoValidaEnvioEmail;
  const AstrMsgPrefixo: String): Boolean;
var
  objEmaAut : TEmaAut;
  LstrMsg: String;
begin
  Result := True ;

  if AValidaEmail in [ovSimAlerta, ovSimPergunta] then
  begin
    objEmaAut := TEmaAut.Create(nil);
    Try
      objEmaAut.FOpcDoc := 'CB';
      Result := objEmaAut.fTemEmailAtivo;

      If (Not Result) Then
      begin
        LstrMsg := ifthen(fEmptyStr(AstrMsgPrefixo), '', AstrMsgPrefixo + sLineBreak) +
                   'As configurações para o envio de e-mail parecem não estar funcionando corretamente.' + sLineBreak +
                   'Verifique em CFG_EMASAI --> Grupo: 039-Cobrança Eletrônica --> Mensagem de Link de Pagamento';

        if AValidaEmail = ovSimPergunta then
        begin
          Result := (fMensagem('', LstrMsg + sLineBreak + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'], 2) = 1) ;
          if (Not Result) then
            Exit ;
        end
        else
        begin
          AstrMsgRetorno := LstrMsg ;
          Result := False ;
          Exit ;
        end ;
      end ;

    Finally
      FreeAndNil(objEmaAut);
    End;
  end ;

end;


function fListaEmailsCliente(const AstrCodCli: String): TArrayDados;
var
  LlstLista: TStringList ;
  LqryAux: TUniQuery ;
  LstrEmail: String ;
begin
  SetLength(Result, 0) ;

  LlstLista := TStringList.Create ;
  LqryAux := fCriaQuery;
  try
    LlstLista.Sorted := True ;

    LqryAux.SQL.Clear;
    LqryAux.SQL.Add('SELECT ');
    LqryAux.SQL.Add('  CLI_EMAIL_, ');
    LqryAux.SQL.Add('  CLI_EMAIL2, ');
    LqryAux.SQL.Add('  CLI_EMAIL3 ');
    LqryAux.SQL.Add('FROM ');
    LqryAux.SQL.Add('  CADCLI ');
    LqryAux.SQL.Add('WHERE ');
    LqryAux.SQL.Add('  CLI_CODCLI = :CODCLI ');
    LqryAux.ParamByName('CODCLI').AsString := AstrCodCli;
    LqryAux.Open;

    If Not fEmptyStr(LqryAux.FieldByName('CLI_EMAIL3').AsString) Then
    begin
      LstrEmail := AnsiReplaceStr(LqryAux.FieldByName('CLI_EMAIL3').AsString, ';;', ';') ;
      if LlstLista.IndexOf(LstrEmail) = -1 then
      begin
        LlstLista.Add(LstrEmail) ;
        SetLength(Result, Length(Result)+1) ;
        Result[High(Result)] := LstrEmail ;
      end ;
    end ;

    If Not fEmptyStr(LqryAux.FieldByName('CLI_EMAIL_').AsString) Then
    begin
      LstrEmail := AnsiReplaceStr(LqryAux.FieldByName('CLI_EMAIL_').AsString, ';;', ';') ;
      if LlstLista.IndexOf(LstrEmail) = -1 then
      begin
        LlstLista.Add(LstrEmail) ;
        SetLength(Result, Length(Result)+1) ;
        Result[High(Result)] := LstrEmail ;
      end ;
    end ;

    If Not fEmptyStr(LqryAux.FieldByName('CLI_EMAIL2').AsString) Then
    begin
      LstrEmail := AnsiReplaceStr(LqryAux.FieldByName('CLI_EMAIL2').AsString, ';;', ';') ;
      if LlstLista.IndexOf(LstrEmail) = -1 then
      begin
        LlstLista.Add(LstrEmail) ;
        SetLength(Result, Length(Result)+1) ;
        Result[High(Result)] := LstrEmail ;
      end ;
    end ;

  finally
    FreeAndNil(LlstLista) ;
    FreeAndNil(LqryAux) ;
  end ;

end ;

function fListaCelularCliente(const AstrCodCli: String): String;
var
  LqryAux: TUniQuery ;
begin
  Result := '' ;

  LqryAux := fCriaQuery;
  try
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add('SELECT ');
    LqryAux.SQL.Add('  CLI_CELULA ');
    LqryAux.SQL.Add('FROM ');
    LqryAux.SQL.Add('  CADCLI ');
    LqryAux.SQL.Add('WHERE ');
    LqryAux.SQL.Add('  CLI_CODCLI = :CODCLI ');
    LqryAux.ParamByName('CODCLI').AsString := AstrCodCli;
    LqryAux.Open;

    Result := LqryAux.FieldByName('CLI_CELULA').AsString ;

  finally
    FreeAndNil(LqryAux) ;
  end ;

end ;

function fIndexOfOpcaoRetorno(const AstrOpcao: String): integer ;
var
  LintCnt: Integer ;
begin
  result := -1 ;
  for LintCnt := 0 to Length(ArrayOpcaoRetorno)-1 do
    if ArrayOpcaoRetorno[TOpcaoRetorno(LintCnt)] = AstrOpcao then
    begin
      Result := LintCnt ;
      Break ;
    end ;
end ;

function fEscolheFormaEnvio(var AFormaEnvio: TOpcaoRetorno; var AstrMeioEnvioSelecionado, AstrMsgOperador: String; const AstrCodCli: String): Boolean ;
var
  LFrmPgtOnlineEscolheTipoEnvioLink: TFrmPgtOnlineEscolheTipoEnvioLink ;
  LstrFormaEnvioLinkPagamento: String ;
  LarrEMails: TArrayDados ;
begin
  Result := False ;
  AstrMsgOperador := '' ;
  LstrFormaEnvioLinkPagamento := fCfgSis('SAILNK', varString) ;

  AFormaEnvio := orEmail ; // default
  AstrMeioEnvioSelecionado := '' ;

  if LstrFormaEnvioLinkPagamento = FORMA_ENVIO_LINK_PAGAMENTO_EMAIL then
  begin
    AFormaEnvio := orEmail ;
    LarrEMails := fListaEmailsCliente(AstrCodCli) ;
    if Length(LarrEMails) > 0 then
      AstrMeioEnvioSelecionado := LarrEMails[0] ;

    if fEmptyStr(AstrMeioEnvioSelecionado) then
    begin
      AstrMsgOperador := 'Cliente não possui e-mail cadastrado para envio do link de pagamento!' ;
      Exit ;
    end ;
    Result := True ;
  end
  else if LstrFormaEnvioLinkPagamento = FORMA_ENVIO_LINK_PAGAMENTO_WHATS then
  begin
    AFormaEnvio := orWhatsApp ;
    AstrMeioEnvioSelecionado := fListaCelularCliente(AstrCodCli) ;

    if fEmptyStr(AstrMeioEnvioSelecionado) then
    begin
      AstrMsgOperador := 'Cliente não possui celular cadastrado para envio do link de pagamento!' ;
      Exit ;
    end ;
    Result := True ;

  end
  else if LstrFormaEnvioLinkPagamento = FORMA_ENVIO_LINK_PAGAMENTO_ESCOLHA then
  begin
    pCriarFormularios(TFrmPgtOnlineEscolheTipoEnvioLink, LFrmPgtOnlineEscolheTipoEnvioLink);
    try
      LFrmPgtOnlineEscolheTipoEnvioLink.CodCli := AstrCodCli ;
      LFrmPgtOnlineEscolheTipoEnvioLink.ShowModal;
      Result := LFrmPgtOnlineEscolheTipoEnvioLink.BlnConfirma ;
      if not Result then
        exit ;

      AFormaEnvio := LFrmPgtOnlineEscolheTipoEnvioLink.OpcaoSelecionada ;
      AstrMeioEnvioSelecionado := LFrmPgtOnlineEscolheTipoEnvioLink.MeioEnvioSelecionado ;
    finally
      pFreeAndNil(LFrmPgtOnlineEscolheTipoEnvioLink);
    end;
  end ;

end ;

function fNotificaCliente(AstrURL: String;
                          var AstrMsgRetorno: String;
                          const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli: String;
                          const AstrLinkPgtFormaEnvio: String = '';
                          const AstrLinkPgtDestinatario: String = '';
                          const AstrTipLan: String = 'PD';
                          AarrAutInc : TArrayAutoIncAgrupado = []): Boolean ;
var
  LorOpcaoSelecionada: TOpcaoRetorno ;
  LstrMeioEnvioSelecionado: String ;
  LobjPgtOnApi : TPagamentoOnline;
  LblnEnviouEmail : Boolean ;
  LstrPathArquivosAnexo: String ;
  LarrDestinatarios, LarrArquivos: TStringArray;
begin
  Result := True ;
  if fEmptyStr(AstrLinkPgtFormaEnvio) and fEmptyStr(AstrLinkPgtDestinatario) then
    Result := fEscolheFormaEnvio(LorOpcaoSelecionada, LstrMeioEnvioSelecionado, AstrMsgRetorno, AstrCodCli)
  else
  begin
    LstrMeioEnvioSelecionado := AstrLinkPgtDestinatario ;
    LorOpcaoSelecionada := TOpcaoRetorno(fIndexOfOpcaoRetorno(AstrLinkPgtFormaEnvio)) ;
  end ;

  if not Result then
    Exit ;

  LobjPgtOnApi := TPagamentoOnline.Create;
  try
    LobjPgtOnApi.strNumDoc := AstrNumDoc;
    LobjPgtOnApi.strEspDoc := AstrEspDoc;
    LobjPgtOnApi.strCodEmp := AstrCodEmp;
    LobjPgtOnApi.strCodCli := AstrCodCli;
    LobjPgtOnApi.arrAutInc := AarrAutInc;

    if LorOpcaoSelecionada = orEmail then
    begin
      LblnEnviouEmail := fEnviarEMailPorTipLan(AstrTipLan, AstrURL, LstrMeioEnvioSelecionado, LobjPgtOnApi) ;

      if LblnEnviouEmail then
        AstrMsgRetorno := 'Link de pagamento enviado com sucesso para: ' + sLineBreak + LstrMeioEnvioSelecionado
      else
        AstrMsgRetorno := 'Não foi possível enviar o link de pagamento para: ' + sLineBreak + LstrMeioEnvioSelecionado + '. Verifique!' ;

    end
    else if LorOpcaoSelecionada = orWhatsApp then
    begin
      LstrPathArquivosAnexo := '' ;
      if AstrTipLan = 'AGR' then
        LstrPathArquivosAnexo := LobjPgtOnApi.fGerarArquivosAGR(LarrDestinatarios, LarrArquivos, '') ;

      if fDisparaWhatsappAutomatico(AstrNumDoc,
                                    'LP',
                                    AstrTipLan,
                                    '',
                                    '',
                                    AstrCodEmp,
                                    LobjPgtOnApi.strCodCli,
                                    '',
                                    True,
                                    '',
                                    TGeraArquivoAnexoEmailAutomatico.New(AstrNumDoc,
                                                                         AstrTipLan,
                                                                         AstrCodEmp,
                                                                         LobjPgtOnApi.strCodCli,
                                                                         False,
                                                                         'LP',
                                                                         '',
                                                                         '',
                                                                         arqArquivo,
                                                                         impComPrecoGeral,
                                                                         LstrPathArquivosAnexo),
                                    '',
                                    '',
                                    '',
                                    'untPgtOnlineUtil',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    False,
                                    False,
                                    nil,
                                    '',
                                    AstrURL) then
        AstrMsgRetorno := 'Link de pagamento enviado com sucesso para o WhatsApp! '
      else
        AstrMsgRetorno := 'Não foi possível enviar o link de pagamento para o WhatsApp, verifique!' ;

    end ;

  finally
    FreeAndNil(LobjPgtOnApi);
  end;
  Result := True ;
end ;

end.
