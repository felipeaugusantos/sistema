unit untNotificacoes;

interface

uses
  System.SysUtils, Uni, UniClientDataSet, Controls, untTypesSistema, Math, Vcl.Forms,
  Data.DB, System.Classes, Winapi.Windows, System.DateUtils, untUtilMonitor;

type
  TNotificacao = class
  private
    FAutInc: String;
    FGrupoGatilho: String;
    FGatilho: String;
    FCodCli: String;
    FCliNom: String;
    FCliOri: String;
    FCliCel: String;
    FEspDoc: String;
    FAgeDta: TDate;
    FAgeHor: TTime;
  public
    property strAutInc: String read FAutInc write FAutInc ;
    property strGrupoGatilho: String read FGrupoGatilho write FGrupoGatilho;
    property strGatilh: String read FGatilho write FGatilho;
    property strCodCli: String read FCodCli write FCodCli ;
    property strCliNom: String read FCliNom write FCliNom ;
    property strCliOri: String read FCliOri write FCliOri ;
    property strCliCel: String read FCliCel write FCliCel ;
    property strEspDoc: String read FEspDoc write FEspDoc ;
    property dtaAgeDta: TDate read FAgeDta write FAgeDta;
    property timAgeHor: TTime read FAgeHor write FAgeHor;

    constructor Create;
  end;

  TNotificacoesMonitor = class sealed(TInterfacedObject, IMonitorProcedure)
  private
    cdsNotFicEmail,
    cdsNotFicSms,
    cdsNotFicWhatsapp,
    cdsNotFicOpiniOne: TUniClientDataSet;

    blnNotificaEmail: Boolean;

    function fRetIntervalo: Integer;

    procedure pConsultaNotificacoesPendentesSms;
    procedure pConsultaNotificacoesPendentesWpp;
    procedure pConsultaNotificacoesPendentesEmail;
    procedure pConsultaNotificacoesPendentesOpiniOne;

    procedure pFiltraAhEnviar(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    function fDisparouTudo(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho): Boolean;
    procedure pDisparaNotificacao(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    function fNotificacaoJaFoiEnviada(strAutInc, strCampo: String; strValor: String = 'N'): Boolean;

    procedure pMarcaEnviado(strAutInc, strCampo: String; strValor: String = 'N');
    procedure pMarcaEmailEnviadoNoCDS(cdsNotFic: TUniClientDataSet);
    procedure pMarcaSMSEnviadoNoCDS(cdsNotFic: TUniClientDataSet);
    procedure pMarcaWhatsappEnviadoNoCDS(cdsNotFic: TUniClientDataSet);
    procedure pMarcaNotificacaoEnviada;

    procedure pDisparaNotFicTaEntregue(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
    function fGetDisparoTaEntregue(cdsNotFic: TUniClientDataSet): String;

    procedure pDisparaNotFicAutorizacaoDocsFiscais(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
    procedure pDisparaNotFicPedidoVenda(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
    procedure pDisparaNotFicFaturamentoFuturo(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
    procedure pDisparaNotFicReenvioCobranca(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    procedure pDisparaNotFicEnvioAgendado(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
    procedure pDisparaNotFicAvisoOrcamentoAberto(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    procedure pDisparaEmailNFeAutComBoletoAutomatico(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    function fGetNomeGatilho(tipNot: TTipoGatilho): String;

    procedure pDisparaPesquisaOpiniOne(cdsNotFic: TUniClientDataSet);

    procedure pDisparaPesquisaSatisfacao(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    procedure pDisparaNotficAvisosIntelipost(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    procedure pRetornaDadosPixPedido(const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli: String; out strQrCodePix, strLinkCitelPix: String);

    procedure pDisparaNotificEnvioFelizAniversario(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);

    procedure pMarcaNotaNaoSeraEnviada(strAutInc, strHistor: String);
    function fMarcaNotaNaoSeraEnviada(strHistor: String): Boolean;

    procedure pConsultaNotificacoesPendentes(var intIntervalo: Integer);
    procedure pDisparaNotficAvisoCashback(cdsNotFic: TUniClientDataSet;
      tipNot: TTipoGatilho);
  protected
    procedure pExecuteAll;
    procedure pExecute;
    function fExecute: TResultExecute;
  public
    class procedure ExecutarRobo;
    constructor Create;
    destructor Destroy; Override;
  end;

  TCriarNotificacoes = class
  private
    FNotificacoes: TArray<TNotificacao>;
  private
    function fAbreTelaFilaEContatoEnvio(blnJaEscolheuContatoEFila, blnEnvioCancelado, blnExecutandoFaturamentoAutomatico: Boolean): Boolean;
    function fNotificaWhatsapp(blnJaEscolheuContatoEFila, blnEnvioCancelado, blnExecutandoFaturamentoAutomatico: Boolean): Boolean;
    procedure pDestroyObjetosNotificacao;
  public
    constructor Create;
    destructor Destroy; Override;

    procedure pAddNotificacao(objNotificacao: TNotificacao);
    procedure pGravaNotificacoes(blnExecutandoFaturamentoAutomatico: Boolean; blnAbrirTelaParaEscolherContatoParaCadaNotificacao: Boolean = False);
  end;

  const
    IdMonitorEnviarNotificacoes = 'ENVIAR_NOTIFICACOES_%s';
    IdInactivityMonitorEnviarNotificacoes = 'TESTE_INATIVIDADE_%s';
    NotificacoesMonitorMonitorExeName = 'autcom.exe';
    NotificacoesMonitorMonitorExeParam = 'ENVIAR_NOTIFICACOES';
    TimeLimitMonitorEnviarNotificacoes = 30;
    AttemptsLockMonitorEnviarNotificacoes = 30;
    MinutosNovaTentativaNotificacoesMonitor = 10;
    NOTIFICACAO_GATILHOS_AUTCOM = 0;
    NOTIFICACAO_NPS_OPINI_ONE = 1;

  Var
    VS_strLockMonitorEnviarNotificacoes: String;
    VS_dtaUltimaExecucaoMonitorEnviarNotificacoes: TDateTime;
    VS_objProcessoMonitorEnviarNotificacoes: TProcessInformation;

implementation

uses untFuncoesSimples, untFuncoes, untFuncFatTypes, untModulo, untConstantes,
  untDisparaEmailAut, untDisparaSMSAut, untDigDataHora,
  untOpiniOneCadastroDestinatario, untFuncFat;

class procedure TNotificacoesMonitor.ExecutarRobo;
Var
  LId: String;
begin
  If OperadorCitelLogado Then
    Exit;

  LId := Format(IdMonitorEnviarNotificacoes, [VS_strCodEmp]);

  TUtilMonitor.pTestInactivity(IdInactivityMonitorEnviarNotificacoes,
    TimeLimitMonitorEnviarNotificacoes, VS_objProcessoMonitorEnviarNotificacoes,
    VS_dtaUltimaExecucaoMonitorEnviarNotificacoes);

  TUtilMonitor.pRunMonitor(LId, VS_objProcessoMonitorEnviarNotificacoes,
    VS_dtaUltimaExecucaoMonitorEnviarNotificacoes, ExtractFileName(ParamStr(0)),
      Concat(NotificacoesMonitorMonitorExeParam, ' ', VS_strCodEmp));

  TUtilMonitor.pClearAttemptsLock(LId, AttemptsLockMonitorEnviarNotificacoes);
end;

constructor TNotificacoesMonitor.Create;
begin
  inherited Create;
  blnNotificaEmail := VS_PermitidoEnviarEmail;
end;

destructor TNotificacoesMonitor.Destroy;
begin
  If (Assigned(cdsNotFicEmail)) Then
    FreeAndNil(cdsNotFicEmail);

  If (Assigned(cdsNotFicSms)) Then
    FreeAndNil(cdsNotFicSms);

  If (Assigned(cdsNotFicWhatsapp)) Then
    FreeAndNil(cdsNotFicWhatsapp);

  If (Assigned(cdsNotFicOpiniOne)) Then
    FreeAndNil(cdsNotFicOpiniOne);
end;

procedure TNotificacoesMonitor.pExecute;
begin
  //do nothing
end;

function TNotificacoesMonitor.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);

  If OperadorCitelLogado Then
    Exit;

  pExecute;
end;

procedure TNotificacoesMonitor.pExecuteAll;
var
  LInterval: Integer;
begin
  inherited;
  pConsultaNotificacoesPendentes(LInterval);
  Sleep(LInterval);
end;

{ TCriarNotificacoes }

constructor TCriarNotificacoes.Create;
begin

end;

destructor TCriarNotificacoes.Destroy;
var
  objNotificacao: TNotificacao;
begin
  for objNotificacao in FNotificacoes do
    objNotificacao.Free;

  SetLength(FNotificacoes, 0);
  inherited;
end;

procedure TCriarNotificacoes.pAddNotificacao(objNotificacao: TNotificacao);
begin
  SetLength(FNotificacoes, Length(FNotificacoes)+1);
  FNotificacoes[Length(FNotificacoes)-1] := objNotificacao;
end;

procedure TCriarNotificacoes.pDestroyObjetosNotificacao;
var
  objNotificacao: TNotificacao;
begin
  for objNotificacao in FNotificacoes do
    objNotificacao.Free;

  SetLength(FNotificacoes, 0);
end;

procedure TCriarNotificacoes.pGravaNotificacoes(blnExecutandoFaturamentoAutomatico: Boolean; blnAbrirTelaParaEscolherContatoParaCadaNotificacao: Boolean = False);
var
  objNotificacao: TNotificacao;

  GatilhoEmail: TEmaAut;
  GatilhoSmsWpp: TSMSAut;

  strNotEma,
  strNotSms,
  strNotWpp: String;

  strCelular,
  strAutIncCtt: String;

  strAutIncNotFic: String;

  strFilaEnv: String;

  blnJaEscolheuContatoEFila,
  blnEnvioCancelado: Boolean;

  frmDigDataHora: TfrmDigDataHora;
  dtaAgeDta: TDate;
  timAgeHor: TTime;

  qryNotFic: TUniQuery;

  dtaEnt: TDateTime;

  intCount: Integer;
  arrCelular: TArray<String>;
  arrAutIncCtt: TArray<String>;
  arrFila: TArray<String>;
begin
  blnJaEscolheuContatoEFila := False;
  blnEnvioCancelado := False;

  try
    for objNotificacao in FNotificacoes do
    begin
      dtaAgeDta := objNotificacao.dtaAgeDta;
      timAgeHor := objNotificacao.timAgeHor;

      GatilhoEmail := TEmaAut.Create(nil);
      GatilhoSmsWpp := TSMSAut.Create(nil);
      try
        try
          GatilhoEmail.FOpcDoc := objNotificacao.strGrupoGatilho;
          GatilhoEmail.FEspDoc := objNotificacao.strEspDoc;
          GatilhoEmail.FEspOrc := objNotificacao.strGatilh;
          GatilhoEmail.FCodCli := objNotificacao.strCodCli;
          strNotEma := IIF(GatilhoEmail.fTemEmailAtivo(True), 'S', 'N');

          GatilhoSmsWpp.FOpcDoc := objNotificacao.strGrupoGatilho;
          GatilhoSmsWpp.FEspDoc := objNotificacao.strEspDoc;
          GatilhoSmsWpp.FEspOrc := objNotificacao.strGatilh;
          GatilhoSmsWpp.FWhatsApp := False;
          strNotSms := IIF(GatilhoSmsWpp.fTemModeloAtivo, 'S', 'N');

          GatilhoSmsWpp.FOpcDoc := objNotificacao.strGrupoGatilho;
          GatilhoSmsWpp.FEspDoc := objNotificacao.strEspDoc;
          GatilhoSmsWpp.FEspOrc := objNotificacao.strGatilh;
          GatilhoSmsWpp.FCodCli := objNotificacao.strCodCli;
          GatilhoSmsWpp.FWhatsApp := True;
          strNotWpp := 'N';

          if (fCfgSis('UTIWPP', varBoolean)) and
             (fEnviaWhatsappParaCliente(objNotificacao.strCodCli)) and
             (GatilhoSmsWpp.fTemModeloAtivo(True)) then
          begin
            if blnAbrirTelaParaEscolherContatoParaCadaNotificacao then
            begin
              blnEnvioCancelado := False;
              blnJaEscolheuContatoEFila := False;
            end;

            if fAbreTelaFilaEContatoEnvio(blnJaEscolheuContatoEFila, blnEnvioCancelado, blnExecutandoFaturamentoAutomatico) then
            begin
              strAutIncCtt := EmptyStr;
              strFilaEnv := EmptyStr;
              strCelular := IIF(fClienteConsumidor(objNotificacao.strCliOri, True, False), objNotificacao.strCliCel, '');

              blnJaEscolheuContatoEFila := fRetFilaEContatoEnvio(strAutIncCtt,
                                                                 strCelular,
                                                                 strFilaEnv,
                                                                 objNotificacao.strCodCli,
                                                                 objNotificacao.strCliNom,
                                                                 GatilhoSmsWpp.FCodigo,
                                                                 GatilhoSmsWpp.FCodGru,
                                                                 True);

              blnEnvioCancelado := not blnJaEscolheuContatoEFila;

              if (not blnEnvioCancelado) and (objNotificacao.strGatilh = 'EA') then
              begin
                pCriarFormularios(TfrmDigDataHora, frmDigDataHora);
                try
                  repeat
                    frmDigDataHora.Caption := 'Data e Hora Agendamento';
                    frmDigDataHora.ShowModal;

                    if frmDigDataHora.ModalResult = mrOK then
                    begin
                      dtaAgeDta := StrToDateDef(frmDigDataHora.mskData__.Text, 0);
                      timAgeHor := StrToTimeDef(frmDigDataHora.mskHora__.Text, 0);
                      break;
                    end
                    else if fPergunta('Deseja cancelar o agendamento de disparo do gatilho "'+objNotificacao.strEspDoc+' - Envio de mensagem agendada"?') then
                      blnEnvioCancelado := True;

                  until blnEnvioCancelado;
                finally
                  pFreeAndNil(frmDigDataHora);
                end;
              end;
            end;

            strNotWpp := IIF(fNotificaWhatsapp(blnJaEscolheuContatoEFila, blnEnvioCancelado, blnExecutandoFaturamentoAutomatico), 'S', 'N');
          end;

          if fEmptyStr(strCelular) then
            strCelular := Chr(32);

          if fEmptyStr(strAutIncCtt) then
            strAutIncCtt := Chr(32);

          if fEmptyStr(strFilaEnv) then
            strFilaEnv := Chr(32);

          arrCelular := strCelular.Split(['_']);
          arrAutIncCtt := strAutIncCtt.Split(['_']);
          arrFila := strFilaEnv.Split(['_']);
          for intCount := 0 to High(arrCelular) do
          begin
            if (strNotEma = 'S') or
               (strNotSms = 'S') or
               (strNotWpp = 'S') then
            begin
              qryNotFic := fCriaQuery;
              try
                qryNotFic.Close;
                qryNotFic.SQL.Text :=
                ' INSERT INTO '+
                ' NOTFIC '+
                '  (AUTOINCREM, '+
                '   NOT_SEQGER, '+
                '   NOT_NOTFIC, '+
                '   NOT_NOTENV, '+
                '   NOT_DTAHOR, '+
                '   NOT_GATILH, '+
                '   NOT_ENVEMA, '+
                '   NOT_ENVSMS, '+
                '   NOT_ENVWPP, '+
                '   NOT_CODEMP, '+
                '   NOT_CELULA, '+
                '   NOT_IDFILA, '+
                '   NOT_SEQCTT, '+
                '   NOT_OPEEMA,  '+
                '   NOT_TIPO__,  '+
                '   NOT_AGEDTA, '+
                '   NOT_AGEHOR) '+
                ' VALUES '+
                '  (:AUTINC, '+
                '   :SEQGER, '+
                '   :NOTFIC, '+
                '   :NOTENV, '+
                '   :DTAHOR, '+
                '   :GATILH, '+
                '   :ENVEMA, '+
                '   :ENVSMS, '+
                '   :ENVWPP, '+
                '   :CODEMP, '+
                '   :CELULA, '+
                '   :IDFILA, '+
                '   :SEQCTT, '+
                '   :OPEEMA,  '+
                '   :TIPO__,  '+
                IIF(dtaAgeDta = 0, 'NULL, ', ':AGEDTA, ')+
                IIF(timAgeHor = 0, 'NULL); ', ':AGEHOR); ');

                strAutIncNotFic := fRetAutoIncrem('NOTFIC', VS_StrCodEmp);
                dtaEnt := fNow;

                qryNotFic.ParamByName('AUTINC').AsString   := strAutIncNotFic;
                qryNotFic.ParamByName('SEQGER').AsString   := objNotificacao.strAutInc;
                qryNotFic.ParamByName('NOTFIC').AsString   := objNotificacao.strGatilh;
                qryNotFic.ParamByName('NOTENV').AsString   := 'N';
                qryNotFic.ParamByName('DTAHOR').AsDateTime := dtaEnt;
                qryNotFic.ParamByName('GATILH').AsString   := objNotificacao.strGrupoGatilho;
                qryNotFic.ParamByName('ENVEMA').AsString   := strNotEma;
                qryNotFic.ParamByName('ENVSMS').AsString   := strNotSms;
                qryNotFic.ParamByName('ENVWPP').AsString   := strNotWpp;
                qryNotFic.ParamByName('CODEMP').AsString   := VS_strCodEmp;
                qryNotFic.ParamByName('CELULA').AsString   := arrCelular[intCount].Trim;
                qryNotFic.ParamByName('IDFILA').AsString   := arrFila[intCount].Trim;
                qryNotFic.ParamByName('SEQCTT').AsString   := IIF(arrAutIncCtt[intCount] = 'CLIENTE', EmptyStr, arrAutIncCtt[intCount]);
                qryNotFic.ParamByName('OPEEMA').AsString   := strLoginUsuarioLogado;
                qryNotFic.ParamByName('TIPO__').AsInteger  := NOTIFICACAO_GATILHOS_AUTCOM;

                if dtaAgeDta > 0 then
                   qryNotFic.ParamByName('AGEDTA').AsDate := dtaAgeDta;

                if timAgeHor > 0 then
                   qryNotFic.ParamByName('AGEHOR').AsTime := timAgeHor;

                qryNotFic.ExecSQl;
              finally
                FreeandNil(qryNotFic);
              end;
            end
            else
              Break;

            strNotEma := 'N';
            strNotSms := 'N';
          end;
        except
          on E: Exception do
          begin
            pMensagensErro(E.Message, '[fGravaGatilhoAutorizacaoDocFiscal]');
          end;
        end;
      finally
        FreeAndNil(GatilhoEmail);
        FreeAndNil(GatilhoSmsWpp);
      end;
    end;
  finally
    pDestroyObjetosNotificacao;
  end;
end;

function TCriarNotificacoes.fAbreTelaFilaEContatoEnvio(blnJaEscolheuContatoEFila, blnEnvioCancelado, blnExecutandoFaturamentoAutomatico: Boolean): Boolean;
begin
  Result := True;

  if blnJaEscolheuContatoEFila then
    Exit(False);

  if blnEnvioCancelado then
    Exit(False);

  if blnExecutandoFaturamentoAutomatico then
    Exit(False);
end;

function TCriarNotificacoes.fNotificaWhatsapp(blnJaEscolheuContatoEFila, blnEnvioCancelado, blnExecutandoFaturamentoAutomatico: Boolean): Boolean;
begin
  Result := True;

  if blnExecutandoFaturamentoAutomatico then
    Exit;

  if not blnJaEscolheuContatoEFila then
    Exit(False);

  if blnEnvioCancelado then
    Exit(False);
end;

procedure TNotificacoesMonitor.pConsultaNotificacoesPendentes(var intIntervalo: Integer);
begin
  If OperadorCitelLogado Then
    Exit;

  if fCfgSis('UTIWPP', varBoolean) then
    pConsultaNotificacoesPendentesWpp;

  if (fCfgSis('SMSMKM', varBoolean)) or
     ((not fEmptyStr(fCfgSis('USRSMS', varString))) and
      (not fEmptyStr(fCfgSis('SENSMS', varString)))) then
    pConsultaNotificacoesPendentesSms;

  if (fCfgSis('EMASAI', VarString) = 'Ativado') and (blnNotificaEmail) then
    pConsultaNotificacoesPendentesEmail;

  if fCfgSis('UTIOPI', varBoolean) then
    pConsultaNotificacoesPendentesOpiniOne;

  intIntervalo := fRetIntervalo;
end;

function TNotificacoesMonitor.fRetIntervalo: Integer;
begin
  Result := 10000;

  if Assigned(cdsNotFicEmail) and (not cdsNotFicEmail.IsEmpty) then
    Result := 500;

  if Assigned(cdsNotFicSms) and (not cdsNotFicSms.IsEmpty) then
    Result := 500;

  if Assigned(cdsNotFicWhatsapp) and (not cdsNotFicWhatsapp.IsEmpty) then
    Result := 500;

  if Assigned(cdsNotFicOpiniOne) and (not cdsNotFicOpiniOne.IsEmpty) then
    Result := 500;
end;

procedure TNotificacoesMonitor.pConsultaNotificacoesPendentesEmail;
var
  qryNotFic: TUniQuery;
  strGatilho: String;
begin
  strGatilho := fGetNomeGatilho(notEmail);

  if Assigned(cdsNotFicEmail) and (cdsNotFicEmail.IsEmpty) then
  begin
    pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, -1);
    FreeAndNil(cdsNotFicEmail);
    Exit;
  end;

  if (fDisparouTudo(cdsNotFicEmail, notEmail)) then
  begin
    if fLock_Unlock('NOTFIC_NOTIFICA_'+strGatilho, True, False) then
    begin

      if not Assigned(cdsNotFicEmail) then
      begin
        qryNotFic := fCriaQuery(nil);
        try
          qryNotFic.Close;
          qryNotFic.SQL.Text :=
          ' SELECT '+
          '   N.AUTOINCREM, '+
          '   N.NOT_NOTFIC, '+
          '   N.NOT_SEQGER, '+
          '   N.NOT_ENVEMA, '+
          '   N.NOT_GATILH, '+
          '   N.NOT_NOTENV, '+
          '   N.NOT_OPEEMA, '+
          '   N.NOT_DTAHOR, '+
          '   N.NOT_INFADI  '+
          ' FROM '+
          '   NOTFIC N '+
          ' WHERE '+
          '   N.NOT_CODEMP = :CODEMP AND '+
          '   N.NOT_NOTENV = "N" AND '+
          '   N.NOT_ENVEMA = "S" AND '+
          '   N.NOT_TIPO__ = :TIPO__ AND '+
          '   TIMESTAMP(IFNULL(N.NOT_AGEDTA, CURRENT_DATE), IFNULL(N.NOT_AGEHOR, CURRENT_TIME)) <= CURRENT_TIMESTAMP '+
          ' ORDER BY '+
          '   N.NOT_DTAHOR ';

          qryNotFic.ParamByName('CODEMP').AsString  := VS_strCodEmp;
          qryNotFic.ParamByName('TIPO__').AsInteger := NOTIFICACAO_GATILHOS_AUTCOM;
          qryNotFic.Open;

          cdsNotFicEmail := fCriaClientDatset(qryNotFic);
          pFiltraAhEnviar(cdsNotFicEmail, notEmail);
        finally
          FreeAndNil(qryNotFic);
        end;
      end;

    end
    else
    if fGetTentativasLock('NOTFIC_NOTIFICA_'+strGatilho) > 25 then
      pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, 25);

  end;

end;

procedure TNotificacoesMonitor.pConsultaNotificacoesPendentesSms;
var
  qryNotFic: TUniQuery;
  strGatilho: String;
begin
  strGatilho := fGetNomeGatilho(notSMS);

  if Assigned(cdsNotFicSms) and (cdsNotFicSms.IsEmpty) then
  begin
    pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, -1);
    FreeAndNil(cdsNotFicSms);
    Exit;
  end;

  if (fDisparouTudo(cdsNotFicSms, notSMS)) then
  begin
    if fLock_Unlock('NOTFIC_NOTIFICA_'+strGatilho, True, False) then
    begin

      if not Assigned(cdsNotFicSms) then
      begin
        qryNotFic := fCriaQuery(nil);
        try
          qryNotFic.Close;
          qryNotFic.SQL.Text :=
          ' SELECT '+
          '   N.AUTOINCREM, '+
          '   N.NOT_NOTFIC, '+
          '   N.NOT_SEQGER, '+
          '   N.NOT_ENVSMS, '+
          '   N.NOT_GATILH, '+
          '   N.NOT_NOTENV, '+
          '   N.NOT_CELULA, '+
          '   N.NOT_DTAHOR, '+
          '   N.NOT_INFADI  '+
          ' FROM '+
          '   NOTFIC N '+
          ' WHERE '+
          '   N.NOT_CODEMP = :CODEMP AND '+
          '   N.NOT_NOTENV = "N" AND '+
          '   N.NOT_ENVSMS = "S" AND '+
          '   N.NOT_TIPO__ = :TIPO__ AND '+
          '   TIMESTAMP(IFNULL(N.NOT_AGEDTA, CURRENT_DATE), IFNULL(N.NOT_AGEHOR, CURRENT_TIME)) <= CURRENT_TIMESTAMP '+
          ' ORDER BY '+
          '   N.NOT_DTAHOR ';

          qryNotFic.ParamByName('CODEMP').AsString  := VS_strCodEmp;
          qryNotFic.ParamByName('TIPO__').AsInteger := NOTIFICACAO_GATILHOS_AUTCOM;
          qryNotFic.Open;

          cdsNotFicSms := fCriaClientDatset(qryNotFic);
          pFiltraAhEnviar(cdsNotFicSms, notSMS);
        finally
          FreeAndNil(qryNotFic);
        end;
      end;

    end
    else
    if fGetTentativasLock('NOTFIC_NOTIFICA_'+strGatilho) > 25 then
      pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, 25);

  end;
end;

procedure TNotificacoesMonitor.pConsultaNotificacoesPendentesWpp;
var
  qryNotFic: TUniQuery;
  strGatilho: String;
begin
  strGatilho := fGetNomeGatilho(notWhatsapp);

  if Assigned(cdsNotFicWhatsapp) and (cdsNotFicWhatsapp.IsEmpty) then
  begin
    pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, -1);
    FreeAndNil(cdsNotFicWhatsapp);
    Exit;
  end;

  if (fDisparouTudo(cdsNotFicWhatsapp, notWhatsapp)) then
  begin
    if fLock_Unlock('NOTFIC_NOTIFICA_'+strGatilho, True, False) then
    begin

      if not Assigned(cdsNotFicWhatsapp) then
      begin
        qryNotFic := fCriaQuery(nil);
        try
          qryNotFic.Close;
          qryNotFic.SQL.Text :=
          ' SELECT '+
          '   N.AUTOINCREM, '+
          '   N.NOT_NOTFIC, '+
          '   N.NOT_SEQGER, '+
          '   N.NOT_ENVWPP, '+
          '   N.NOT_GATILH, '+
          '   N.NOT_NOTENV, '+
          '   N.NOT_CELULA, '+
          '   IF(IFNULL(N.NOT_IDFILA, "") = "", "0", N.NOT_IDFILA) AS NOT_IDFILA, '+
          '   N.NOT_SEQCTT, '+
          '   N.NOT_DTAHOR, '+
          '   N.NOT_INFADI  '+
          ' FROM '+
          '   NOTFIC N '+
          ' WHERE '+
          '   N.NOT_CODEMP = :CODEMP AND '+
          '   N.NOT_NOTENV = "N" AND '+
          '   N.NOT_ENVWPP = "S" AND '+
          '   N.NOT_TIPO__ = :TIPO__ AND '+
          '   TIMESTAMP(IFNULL(N.NOT_AGEDTA, CURRENT_DATE), IFNULL(N.NOT_AGEHOR, CURRENT_TIME)) <= CURRENT_TIMESTAMP '+
          ' ORDER BY '+
          '   N.NOT_DTAHOR ';

          qryNotFic.ParamByName('CODEMP').AsString  := VS_strCodEmp;
          qryNotFic.ParamByName('TIPO__').AsInteger := NOTIFICACAO_GATILHOS_AUTCOM;
          qryNotFic.Open;

          cdsNotFicWhatsapp := fCriaClientDatset(qryNotFic);
          pFiltraAhEnviar(cdsNotFicWhatsapp, notWhatsapp);
        finally
          FreeAndNil(qryNotFic);
        end;
      end;

    end
    else
    if fGetTentativasLock('NOTFIC_NOTIFICA_'+strGatilho) > 25 then
      pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, 25);

  end;

end;

procedure TNotificacoesMonitor.pConsultaNotificacoesPendentesOpiniOne;
var
  qryNotFic: TUniQuery;
  strGatilho: String;
begin
  strGatilho := fGetNomeGatilho(notOpiniOne);

  if Assigned(cdsNotFicOpiniOne) and (cdsNotFicOpiniOne.IsEmpty) then
  begin
    pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, -1);
    FreeAndNil(cdsNotFicOpiniOne);
    Exit;
  end;

  if (fDisparouTudo(cdsNotFicOpiniOne, notOpiniOne)) then
  begin
    if fLock_Unlock('NOTFIC_NOTIFICA_'+strGatilho, True, False) then
    begin

      if not Assigned(cdsNotFicOpiniOne) then
      begin
        qryNotFic := fCriaQuery(nil);
        try
          qryNotFic.Close;
          qryNotFic.SQL.Text :=
          ' SELECT '+
          '   N.AUTOINCREM, '+
          '   N.NOT_NOTFIC, '+
          '   N.NOT_SEQGER, '+
          '   N.NOT_GATILH, '+
          '   N.NOT_NOTENV, '+
          '   N.NOT_DTAHOR  '+
          ' FROM '+
          '   NOTFIC N '+
          ' WHERE '+
          '   N.NOT_CODEMP = :CODEMP AND '+
          '   N.NOT_NOTENV = "N" AND '+
          '   N.NOT_TIPO__ = :TIPO__ '+
          ' ORDER BY '+
          '   N.NOT_DTAHOR ';

          qryNotFic.ParamByName('CODEMP').AsString  := VS_strCodEmp;
          qryNotFic.ParamByName('TIPO__').AsInteger := NOTIFICACAO_NPS_OPINI_ONE;
          qryNotFic.Open;

          cdsNotFicOpiniOne := fCriaClientDatset(qryNotFic);
          pFiltraAhEnviar(cdsNotFicOpiniOne, notOpiniOne);
        finally
          FreeAndNil(qryNotFic);
        end;
      end;

    end
    else
    if fGetTentativasLock('NOTFIC_NOTIFICA_'+strGatilho) > 25 then
      pDestravaLockForcado('NOTFIC_NOTIFICA_'+strGatilho, 25);

  end;

end;

function TNotificacoesMonitor.fDisparouTudo(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho): Boolean;
var
  strGatilho: String;
begin
  Result := True;

  if Assigned(cdsNotFic) then
  begin
    strGatilho := fGetNomeGatilho(tipNot);

    if not fLckAtcEhDoMesmoPID('NOTFIC_NOTIFICA_'+fGetNomeGatilho(tipNot)) then
    begin
      while not cdsNotFic.IsEmpty do
        cdsNotFic.Delete;
    end;

    if (not cdsNotFic.IsEmpty) then
    begin
      pZerarTentativasLock('NOTFIC_NOTIFICA_'+strGatilho);

      pDisparaNotificacao(cdsNotFic, tipNot);
      pMarcaNotificacaoEnviada;

      Exit(False);
    end
    else
      fLock_Unlock('NOTFIC_NOTIFICA_'+strGatilho, False, False);
  end;
end;

function TNotificacoesMonitor.fMarcaNotaNaoSeraEnviada(
  strHistor: String): Boolean;
begin
  Result := False;

  if Pos('CANCEL', strHistor) > 0 then
    Exit(True);

  if Pos('DENEGAD', strHistor) > 0 then
    Exit(True);

  if Pos('INUTIL', strHistor) > 0 then
    Exit(True);
end;

function TNotificacoesMonitor.fGetNomeGatilho(tipNot: TTipoGatilho): String;
begin
  case tipNot of
    notEmail   : Result := 'EMAIL_'+VS_strCodEmp;
    notSms     : Result := 'SMS_'+VS_strCodEmp;
    notWhatsapp: Result := 'WHATSAPP_'+VS_strCodEmp;
    notOpiniOne: Result := 'OPINIONE_'+VS_strCodEmp;
  end;
end;

procedure TNotificacoesMonitor.pDisparaNotificacao(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
begin
  if (tipNot = notOpiniOne) then
  begin
    if Pos(cdsNotFic.FieldByName('NOT_GATILH').AsString, 'ET_RT_') > 0 then
      pDisparaPesquisaOpiniOne(cdsNotFic);
  end
  else
  begin
    if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'TE' then
      pDisparaNotFicTaEntregue(cdsNotFic, tipNot)
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'AN' then
      pDisparaNotFicAutorizacaoDocsFiscais(cdsNotFic, tipNot)
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'FF' then
      pDisparaNotFicFaturamentoFuturo(cdsNotFic, tipNot)
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'PD' then
      pDisparaNotFicPedidoVenda(cdsNotFic, tipNot)
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'RC' then
      pDisparaNotFicReenvioCobranca(cdsNotFic, tipNot)
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'OR' then
    begin
      if cdsNotFic.FieldByName('NOT_NOTFIC').AsString = 'EA' then
        pDisparaNotFicEnvioAgendado(cdsNotFic, tipNot)
      else if Pos(cdsNotFic.FieldByName('NOT_NOTFIC').AsString, 'A1_A2_A3_') > 0 then
        pDisparaNotFicAvisoOrcamentoAberto(cdsNotFic, tipNot);
    end
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'BN' then
      pDisparaEmailNFeAutComBoletoAutomatico(cdsNotFic, tipNot)
    else if (cdsNotFic.FieldByName('NOT_GATILH').AsString = 'CL') then
    begin
      if (cdsNotFic.FieldByName('NOT_NOTFIC').AsString = 'PS') then
        pDisparaPesquisaSatisfacao(cdsNotFic, tipNot);
    end
    else if (cdsNotFic.FieldByName('NOT_GATILH').AsString = 'MENSAGEM_ANIVERSARIO') then
        pDisparaNotificEnvioFelizAniversario(cdsNotFic, tipNot)
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'AI' then
      pDisparaNotficAvisosIntelipost(cdsNotFic, tipNot)
    else if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'CH' then
      pDisparaNotficAvisoCashback(cdsNotFic, tipNot)
    else
    begin
      if tipNot = notWhatsapp then
        pMarcaWhatsappEnviadoNoCDS(cdsNotFic)
      else if tipNot = notSMS then
        pMarcaSMSEnviadoNoCDS(cdsNotFic)
      else if tipNot = notEmail then
        pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end;
  end;
end;

procedure TNotificacoesMonitor.pDisparaNotificEnvioFelizAniversario(
  cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryCadCli: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryCadCli := fCriaQuery;
  try
    qryCadCli.Close;
    qryCadCli.SQL.Text :=
    ' SELECT '+
    '   CLI_CODCLI '+
    ' FROM '+
    '   CADCLI '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER ';
    qryCadCli.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryCadCli.Open;

    if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(EmptyStr,
                                     'CL',
                                     EmptyStr,
                                     '',
                                     'CA',
                                     VS_strCodEmp,
                                     qryCadCli.FieldByName('CLI_CODCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     nil,
                                     '',
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     False,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      FreeAndNil(DestinatarioWhatsapp);
    end;
  finally
    FreeAndNil(qryCadCli);
  end;
end;

procedure TNotificacoesMonitor.pDisparaNotFicTaEntregue(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryRomGer: TUniQuery;
begin
  qryRomGer := fCriaQuery(nil);
  try
    qryRomGer.Close;
    qryRomGer.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM, '+
    '   GER_NUMDOC, '+
    '   GER_ESPDOC, '+
    '   GER_CODEMP, '+
    '   GER_CODCLI  '+
    ' FROM '+
    '   ROMGERX '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER ';

    qryRomGer.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryRomGer.Open;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryRomGer.FieldByName('GER_NUMDOC').AsString,
                                  'TE',
                                  qryRomGer.FieldByName('GER_ESPDOC').AsString,
                                  '',
                                  fGetDisparoTaEntregue(cdsNotFic),
                                  qryRomGer.FieldByName('GER_CODEMP').AsString,
                                  qryRomGer.FieldByName('GER_CODCLI').AsString,
                                  '',
                                  '',
                                  nil,
                                  '',
                                  qryRomGer.FieldByName('AUTOINCREM').AsString,
                                  '',
                                  '',
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notSMS then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS')) and
         (fDisparaSMSAutomatico(qryRomGer.FieldByName('GER_NUMDOC').AsString,
                                'TE',
                                qryRomGer.FieldByName('GER_ESPDOC').AsString,
                                '',
                                fGetDisparoTaEntregue(cdsNotFic),
                                qryRomGer.FieldByName('GER_CODEMP').AsString,
                                qryRomGer.FieldByName('GER_CODCLI').AsString,
                                '',
                                False,
                                '',
                                nil,
                                False,
                                qryRomGer.FieldByName('AUTOINCREM').AsString,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                '',
                                '',
                                True,
                                True)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS');

      pMarcaSMSEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notWhatsapp then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryRomGer.FieldByName('GER_NUMDOC').AsString,
                                     'TE',
                                     qryRomGer.FieldByName('GER_ESPDOC').AsString,
                                     '',
                                     fGetDisparoTaEntregue(cdsNotFic),
                                     qryRomGer.FieldByName('GER_CODEMP').AsString,
                                     qryRomGer.FieldByName('GER_CODCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     nil,
                                     qryRomGer.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     '',
                                     '',
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
    end;
  finally
    FreeAndNil(qryRomGer);
  end;
end;

function TNotificacoesMonitor.fGetDisparoTaEntregue(cdsNotFic: TUniClientDataSet): String;
begin
  Result := 'OE';
  if cdsNotFic.FieldByName('NOT_NOTFIC').AsString = 'ROTA_INICIADA' then
    Result := 'RI'
  else
  if cdsNotFic.FieldByName('NOT_NOTFIC').AsString = 'ENTREGA_FINALIZADA' then
    Result := 'EC';
end;

procedure TNotificacoesMonitor.pDisparaNotFicAutorizacaoDocsFiscais(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryAutNot: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryAutNot := fCriaQuery(nil);
  try
    qryAutNot.Close;
    qryAutNot.SQL.Text :=
     ' SELECT '+
    '   FIS_NUMDOC, '+
    '   FIS_ESPDOC, '+
    '   FIS_CODEMP, '+
    '   FIS_FORCLI, '+
    '   FIS_ACESSO, '+
    '   FIS_SERIE_, '+
    '   FIS_HISTOR  '+
    ' FROM '+
    '   CADFIS '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   FIS_TIP_FC = "C" ';

    qryAutNot.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryAutNot.Open;

    if qryAutNot.IsEmpty then
    begin
      qryAutNot.Close;
      qryAutNot.SQL.Text :=
      ' DELETE FROM NOTFIC WHERE AUTOINCREM = :AUTINC ';
      qryAutNot.ParamByName('AUTINC').AsString := cdsNotFic.FieldByName('AUTOINCREM').AsString;
      qryAutNot.ExecSQL;

      cdsNotFic.Delete;
      Exit;
    end;

    if fMarcaNotaNaoSeraEnviada(qryAutNot.FieldByName('FIS_HISTOR').AsString) then
    begin
      pMarcaNotaNaoSeraEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString,
                               qryAutNot.FieldByName('FIS_HISTOR').AsString);
      cdsNotFic.Delete;
      Exit;
    end;

    if fEmptyStr(qryAutNot.FieldByName('FIS_ACESSO').AsString) then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                  'AN',
                                  qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                  '',
                                  cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                  qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                  qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                  '',
                                  '',
                                  TGeraArquivoAnexoEmailAutomatico.New(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                                                       qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                                                       qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                                                       qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                                                       False,
                                                                       cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                                                       qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                                                       qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                                                       arqBase64),
                                  '',
                                  '',
                                  qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                  qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notSMS then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS')) and
         (fDisparaSMSAutomatico(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                'AN',
                                qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                '',
                                cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                '',
                                False,
                                '',
                                nil,
                                False,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                '',
                                '',
                                True,
                                True)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS');

      pMarcaSMSEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                     'AN',
                                     qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                     '',
                                     cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                     qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                     qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                                                          qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                                                          qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                                                          qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                                                          False,
                                                                          cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                                                          qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                                                          qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                                                          arqBase64),
                                     '',
                                     qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                     qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      FreeAndNil(DestinatarioWhatsapp);
    end;
  finally
    FreeAndNil(qryAutNot);
  end;

end;

procedure TNotificacoesMonitor.pDisparaNotFicAvisoOrcamentoAberto(
  cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryEnvOrc: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryEnvOrc := fCriaQuery(nil);
  try
    qryEnvOrc.Close;
    qryEnvOrc.SQL.Text :=
    ' SELECT '+
    '   FGO_NUMDOC, '+
    '   FGO_ESPDOC, '+
    '   FGO_CODEMP, '+
    '   FGO_CODCLI, '+
    '   FGO_JAFATU, '+
    '   TIMESTAMP(FGO_DTAENT, FGO_HORENT) AS FGO_DTAENT '+
    ' FROM '+
    '   FATGOR '+
    ' INNER JOIN NOTFIC ON '+
    '   NOTFIC.AUTOINCREM = :AUTINC '+
    ' WHERE '+
    '   FATGOR.AUTOINCREM = :SEQGER ';

    qryEnvOrc.ParamByName('AUTINC').AsString := cdsNotFic.FieldByName('AUTOINCREM').AsString;
    qryEnvOrc.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryEnvOrc.Open;

    if qryEnvOrc.IsEmpty then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if ( qryEnvOrc.FieldByName('FGO_JAFATU').AsInteger = 1 ) or
       ( HoursBetween(qryEnvOrc.FieldByName('FGO_DTAENT').AsDateTime, fNow) >= ((24 * StrToInt(cdsNotFic.FieldByName('NOT_NOTFIC').AsString.Replace('A', '')))+24) ) then
    begin
      if tipNot = notEmail then
      begin
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');
        pMarcaEmailEnviadoNoCDS(cdsNotFic);
      end
      else if tipNot = notWhatsapp then
      begin
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');
        pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      end;

      Exit;
    end;

    if ( HoursBetween(qryEnvOrc.FieldByName('FGO_DTAENT').AsDateTime, fNow ) < (24 * StrToInt(cdsNotFic.FieldByName('NOT_NOTFIC').AsString.Replace('A', ''))) ) then
    begin
      if tipNot = notEmail then
        pMarcaEmailEnviadoNoCDS(cdsNotFic)
      else if tipNot = notWhatsapp then
        pMarcaWhatsappEnviadoNoCDS(cdsNotFic);

      Exit;
    end;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryEnvOrc.FieldByName('FGO_NUMDOC').AsString,
                                  cdsNotFic.FieldByName('NOT_GATILH').AsString,
                                  qryEnvOrc.FieldByName('FGO_ESPDOC').AsString,
                                  '',
                                  cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                  qryEnvOrc.FieldByName('FGO_CODEMP').AsString,
                                  qryEnvOrc.FieldByName('FGO_CODCLI').AsString,
                                  '',
                                  '',
                                  TGeraArquivoAnexoEmailAutomatico.New(qryEnvOrc.FieldByName('FGO_NUMDOC').AsString,
                                                                       qryEnvOrc.FieldByName('FGO_ESPDOC').AsString,
                                                                       qryEnvOrc.FieldByName('FGO_CODEMP').AsString,
                                                                       qryEnvOrc.FieldByName('FGO_CODCLI').AsString,
                                                                       False),
                                  '',
                                  '',
                                  '',
                                  '',
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryEnvOrc.FieldByName('FGO_NUMDOC').AsString,
                                     cdsNotFic.FieldByName('NOT_GATILH').AsString,
                                     qryEnvOrc.FieldByName('FGO_ESPDOC').AsString,
                                     '',
                                     cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                     qryEnvOrc.FieldByName('FGO_CODEMP').AsString,
                                     qryEnvOrc.FieldByName('FGO_CODCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(qryEnvOrc.FieldByName('FGO_NUMDOC').AsString,
                                                                          qryEnvOrc.FieldByName('FGO_ESPDOC').AsString,
                                                                          qryEnvOrc.FieldByName('FGO_CODEMP').AsString,
                                                                          qryEnvOrc.FieldByName('FGO_CODCLI').AsString,
                                                                          False),
                                     '',
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      FreeAndNil(DestinatarioWhatsapp);
    end;
  finally
    FreeAndNil(qryEnvOrc);
  end;
end;

procedure TNotificacoesMonitor.pDisparaNotFicPedidoVenda(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryPedVen: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;

  strQrCodePix,
  strLinkCitelPix: String;
begin
  qryPedVen := fCriaQuery(nil);
  try
    qryPedVen.Close;
    qryPedVen.SQL.Text :=
    ' SELECT '+
    '   FGO_NUMDOC, '+
    '   FGO_ESPDOC, '+
    '   FGO_CODEMP, '+
    '   FGO_CODCLI  '+
    ' FROM '+
    '   FATGOR '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   FGO_DTAENT = :DTAENT ';

    qryPedVen.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryPedVen.ParamByName('DTAENT').AsDate := cdsNotFic.FieldByName('NOT_DTAHOR').AsDateTime;
    qryPedVen.Open;

    if qryPedVen.IsEmpty then
    begin
      qryPedVen.Close;
      qryPedVen.SQL.Text := ' DELETE FROM NOTFIC WHERE AUTOINCREM = :AUTINC ';
      qryPedVen.ParamByName('AUTINC').AsString := cdsNotFic.FieldByName('AUTOINCREM').AsString;
      qryPedVen.ExecSQL;

      cdsNotFic.Delete;
      Exit;
    end;

    pRetornaDadosPixPedido(qryPedVen.FieldByName('FGO_NUMDOC').AsString,
                           qryPedVen.FieldByName('FGO_ESPDOC').AsString,
                           qryPedVen.FieldByName('FGO_CODEMP').AsString,
                           qryPedVen.FieldByName('FGO_CODCLI').AsString,
                           strQrCodePix,
                           strLinkCitelPix);

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryPedVen.FieldByName('FGO_NUMDOC').AsString,
                                  'PD',
                                  qryPedVen.FieldByName('FGO_ESPDOC').AsString,
                                  '',
                                  '',
                                  qryPedVen.FieldByName('FGO_CODEMP').AsString,
                                  qryPedVen.FieldByName('FGO_CODCLI').AsString,
                                  strQrCodePix,
                                  strLinkCitelPix,
                                  TGeraArquivoAnexoEmailAutomatico.New(qryPedVen.FieldByName('FGO_NUMDOC').AsString,
                                                                       qryPedVen.FieldByName('FGO_ESPDOC').AsString,
                                                                       qryPedVen.FieldByName('FGO_CODEMP').AsString,
                                                                       qryPedVen.FieldByName('FGO_CODCLI').AsString,
                                                                       False,
                                                                       'PD'),
                                  '',
                                  '',
                                  '',
                                  '',
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notSMS then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS')) and
         (fDisparaSMSAutomatico(qryPedVen.FieldByName('FGO_NUMDOC').AsString,
                                'PD',
                                qryPedVen.FieldByName('FGO_ESPDOC').AsString,
                                '',
                                '',
                                qryPedVen.FieldByName('FGO_CODEMP').AsString,
                                qryPedVen.FieldByName('FGO_CODCLI').AsString,
                                RetonaQRCodePixPedido(strQrCodePix,
                                                      strLinkCitelPix,
                                                      False),
                                False,
                                '',
                                nil,
                                False,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                '',
                                '',
                                True,
                                True)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS');

      pMarcaSMSEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryPedVen.FieldByName('FGO_NUMDOC').AsString,
                                     'PD',
                                     qryPedVen.FieldByName('FGO_ESPDOC').AsString,
                                     '',
                                     '',
                                     qryPedVen.FieldByName('FGO_CODEMP').AsString,
                                     qryPedVen.FieldByName('FGO_CODCLI').AsString,
                                     RetonaQRCodePixPedido(strQrCodePix,
                                                           strLinkCitelPix,
                                                           False),
                                     False,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(qryPedVen.FieldByName('FGO_NUMDOC').AsString,
                                                                          qryPedVen.FieldByName('FGO_ESPDOC').AsString,
                                                                          qryPedVen.FieldByName('FGO_CODEMP').AsString,
                                                                          qryPedVen.FieldByName('FGO_CODCLI').AsString,
                                                                          False,
                                                                          'PD'),
                                     '',
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      FreeAndNil(DestinatarioWhatsapp);
    end;
  finally
    FreeAndNil(qryPedVen);
  end;

end;

procedure TNotificacoesMonitor.pDisparaNotFicFaturamentoFuturo(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryFatFut: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryFatFut := fCriaQuery(nil);
  try
    qryFatFut.Close;
    qryFatFut.SQL.Text :=
    ' SELECT '+
    '   GER_NUMDOC, '+
    '   GER_ESPDOC, '+
    '   GER_CODEMP, '+
    '   GER_CODCLI  '+
    ' FROM '+
    '   MOVGER '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   GER_DTAENT = :DTAENT '+

    ' UNION '+

    ' SELECT '+
    '   GER_NUMDOC, '+
    '   GER_ESPDOC, '+
    '   GER_CODEMP, '+
    '   GER_CODCLI  '+
    ' FROM '+
    '   NOTGER '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   GER_DTAENT = :DTAENT ';

    qryFatFut.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryFatFut.ParamByName('DTAENT').AsDate := cdsNotFic.FieldByName('NOT_DTAHOR').AsDateTime;
    qryFatFut.Open;

    if qryFatFut.IsEmpty then
    begin
      qryFatFut.Close;
      qryFatFut.SQL.Text := ' DELETE FROM NOTFIC WHERE AUTOINCREM = :AUTINC ';
      qryFatFut.ParamByName('AUTINC').AsString := cdsNotFic.FieldByName('AUTOINCREM').AsString;
      qryFatFut.ExecSQL;

      cdsNotFic.Delete;
      Exit;
    end;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryFatFut.FieldByName('GER_NUMDOC').AsString,
                                  'FF',
                                  qryFatFut.FieldByName('GER_ESPDOC').AsString,
                                  '',
                                  'IN',
                                  qryFatFut.FieldByName('GER_CODEMP').AsString,
                                  qryFatFut.FieldByName('GER_CODCLI').AsString,
                                  '',
                                  '',
                                  TGeraArquivoAnexoEmailAutomatico.New(qryFatFut.FieldByName('GER_NUMDOC').AsString,
                                                                       qryFatFut.FieldByName('GER_ESPDOC').AsString,
                                                                       qryFatFut.FieldByName('GER_CODEMP').AsString,
                                                                       qryFatFut.FieldByName('GER_CODCLI').AsString,
                                                                       False,
                                                                       'FF'),
                                  '',
                                  '',
                                  '',
                                  '',
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notSMS then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS')) and
         (fDisparaSMSAutomatico(qryFatFut.FieldByName('GER_NUMDOC').AsString,
                                'FF',
                                qryFatFut.FieldByName('GER_ESPDOC').AsString,
                                '',
                                'IN',
                                qryFatFut.FieldByName('GER_CODEMP').AsString,
                                qryFatFut.FieldByName('GER_CODCLI').AsString,
                                '',
                                False,
                                '',
                                nil,
                                False,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                '',
                                '',
                                True,
                                True)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVSMS');

      pMarcaSMSEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryFatFut.FieldByName('GER_NUMDOC').AsString,
                                     'FF',
                                     qryFatFut.FieldByName('GER_ESPDOC').AsString,
                                     '',
                                     'IN',
                                     qryFatFut.FieldByName('GER_CODEMP').AsString,
                                     qryFatFut.FieldByName('GER_CODCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(qryFatFut.FieldByName('GER_NUMDOC').AsString,
                                                                          qryFatFut.FieldByName('GER_ESPDOC').AsString,
                                                                          qryFatFut.FieldByName('GER_CODEMP').AsString,
                                                                          qryFatFut.FieldByName('GER_CODCLI').AsString,
                                                                          False,
                                                                          'FF'),
                                     '',
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      FreeAndNil(DestinatarioWhatsapp);
    end;
  finally
    FreeAndNil(qryFatFut);
  end;

end;

procedure TNotificacoesMonitor.pDisparaNotFicReenvioCobranca(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryAutNot: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryAutNot := fCriaQuery;
  try
    qryAutNot.Close;
    qryAutNot.SQL.Text :=
    ' SELECT '+
    '   FIS_NUMDOC, '+
    '   FIS_ESPDOC, '+
    '   FIS_CODEMP, '+
    '   FIS_FORCLI, '+
    '   FIS_ACESSO, '+
    '   FIS_SERIE_, '+
    '   FIS_HISTOR '+
    ' FROM '+
    '   CADFIS '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   FIS_TIP_FC = "C" ';

    qryAutNot.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryAutNot.Open;

    if qryAutNot.IsEmpty then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if fMarcaNotaNaoSeraEnviada(qryAutNot.FieldByName('FIS_HISTOR').AsString) then
    begin
      pMarcaNotaNaoSeraEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString,
                               qryAutNot.FieldByName('FIS_HISTOR').AsString);
      cdsNotFic.Delete;
      Exit;
    end;

    if fEmptyStr(qryAutNot.FieldByName('FIS_ACESSO').AsString) then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                  'RC',
                                  qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                  '',
                                  '',
                                  qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                  qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                  '',
                                  '',
                                  TGeraArquivoAnexoEmailAutomatico.New(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                                                       qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                                                       qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                                                       qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                                                       False,
                                                                       'RC',
                                                                       qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                                                       qryAutNot.FieldByName('FIS_SERIE_').AsString),
                                  '',
                                  '',
                                  qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                  qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                     'RC',
                                     qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                     '',
                                     '',
                                     qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                     qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                                                          qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                                                          qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                                                          qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                                                          False,
                                                                          'RC'),
                                     '',
                                     qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                     qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      FreeAndNil(DestinatarioWhatsapp);
    end;
  finally
    FreeAndNil(qryAutNot);
  end;

end;

procedure TNotificacoesMonitor.pDisparaNotFicEnvioAgendado(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryEnvAge: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryEnvAge := fCriaQuery(nil);
  try
    qryEnvAge.Close;
    qryEnvAge.SQL.Text :=
    ' SELECT '+
    '   FGO_NUMDOC, '+
    '   FGO_ESPDOC, '+
    '   FGO_CODEMP, '+
    '   FGO_CODCLI, '+
    '   FGO_JAFATU  '+
    ' FROM '+
    '   FATGOR '+
    ' INNER JOIN NOTFIC ON '+
    '   NOTFIC.AUTOINCREM = :AUTINC '+
    ' WHERE '+
    '   FATGOR.AUTOINCREM = :SEQGER AND '+
    '   CURDATE() >= NOT_AGEDTA AND '+
    '   CURTIME() >= NOT_AGEHOR ';

    qryEnvAge.ParamByName('AUTINC').AsString := cdsNotFic.FieldByName('AUTOINCREM').AsString;
    qryEnvAge.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryEnvAge.Open;

    if qryEnvAge.IsEmpty then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if qryEnvAge.FieldByName('FGO_JAFATU').AsInteger = 1 then
    begin
      pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');
      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);

      Exit;
    end;

    if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryEnvAge.FieldByName('FGO_NUMDOC').AsString,
                                     cdsNotFic.FieldByName('NOT_GATILH').AsString,
                                     qryEnvAge.FieldByName('FGO_ESPDOC').AsString,
                                     '',
                                     'EA',
                                     qryEnvAge.FieldByName('FGO_CODEMP').AsString,
                                     qryEnvAge.FieldByName('FGO_CODCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(qryEnvAge.FieldByName('FGO_NUMDOC').AsString,
                                                                          qryEnvAge.FieldByName('FGO_ESPDOC').AsString,
                                                                          qryEnvAge.FieldByName('FGO_CODEMP').AsString,
                                                                          qryEnvAge.FieldByName('FGO_CODCLI').AsString,
                                                                          False),
                                     '',
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      FreeAndNil(DestinatarioWhatsapp);
    end;
  finally
    FreeAndNil(qryEnvAge);
  end;
end;

procedure TNotificacoesMonitor.pDisparaEmailNFeAutComBoletoAutomatico(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryAutNot,
  qryCadRec: TUniQuery;

  blnBoletoViaUnica: Boolean;
  strPath: String;
  strPathBoleto: String;
begin
  If Not VS_PermitidoEnviarEmail Then
    Exit;

  qryAutNot := fCriaQuery;
  qryCadRec := fCriaQuery;
  Try
    qryAutNot.Close;
    qryAutNot.SQL.Text :=
    ' SELECT '+
    '   FIS_NUMDOC, '+
    '   FIS_ESPDOC, '+
    '   FIS_CODEMP, '+
    '   FIS_FORCLI, '+
    '   FIS_ACESSO, '+
    '   FIS_SERIE_, '+
    '   FIS_HISTOR '+
    ' FROM '+
    '   CADFIS '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   FIS_TIP_FC = "C" ';

    qryAutNot.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryAutNot.Open;

    if qryAutNot.IsEmpty then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if fMarcaNotaNaoSeraEnviada(qryAutNot.FieldByName('FIS_HISTOR').AsString) then
    begin
      pMarcaNotaNaoSeraEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString,
                               qryAutNot.FieldByName('FIS_HISTOR').AsString);
      cdsNotFic.Delete;
      Exit;
    end;

    if fEmptyStr(qryAutNot.FieldByName('FIS_ACESSO').AsString) then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    qryCadRec.Close;
    qryCadRec.SQL.Text :=
    ' SELECT '+
    '   AUTOINCREM, '+
    '   CTR_NOSNUM, '+
    '   CTR_NUMDUP, '+
    '   CTR_PARCEL  '+
    ' FROM '+
    '   CADREC'+
    ' WHERE '+
    '   CTR_DTAREC IS NULL   AND '+
    '   CTR_VALDUP > 0       AND '+
    '   CTR_NUMDUP = :NUMDOC AND '+
    '   CTR_CODCLI = :CODCLI AND '+
    '   CTR_CODEMP = :CODEMP AND '+
    '   CTR_ESPDOC = :ESPDOC ';

    qryCadRec.ParamByName('NUMDOC').AsString := qryAutNot.FieldByName('FIS_NUMDOC').AsString;
    qryCadRec.ParamByName('CODCLI').AsString := qryAutNot.FieldByName('FIS_FORCLI').AsString;;
    qryCadRec.ParamByName('CODEMP').AsString := qryAutNot.FieldByName('FIS_CODEMP').AsString;;
    qryCadRec.ParamByName('ESPDOC').AsString := qryAutNot.FieldByName('FIS_ESPDOC').AsString;;
    qryCadRec.Open;

    If (qryCadRec.IsEmpty) Then
    Begin
      pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');
      pMarcaEmailEnviadoNoCDS(cdsNotFic);

      Exit;
    End
    Else
    Begin
      if fEmptyStr(qryCadRec.FieldByName('CTR_NOSNUM').AsString) then
      begin
        pMarcaEmailEnviadoNoCDS(cdsNotFic);
        Exit;
      end;

      blnBoletoViaUnica := ((fCfgSis('NOVLAY') = 'C') or (fCfgSis('NOVLAY') = 'U'));
      strPath := ExtractFilePath(Application.ExeName) + IIF(fCfgSis('GRVBOL') = '1', 'Boletos\', 'Boletos_'+ qryAutNot.FieldByName('FIS_CODEMP').AsString +'\');
      While not qryCadRec.Eof do
      Begin
        strPathBoleto := strPath +
                           qryCadRec.FieldByName('CTR_NUMDUP').AsString +
                             IIF(not blnBoletoViaUnica, qryCadRec.FieldByName('CTR_PARCEL').AsString, '')+'.pdf';

        if not FileExists(strPathBoleto) then
        begin
          pMarcaEmailEnviadoNoCDS(cdsNotFic);
          Exit;
        end;

        if blnBoletoViaUnica then
          Break;

        qryCadRec.Next;
      End;
    End;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                  'BN',
                                  qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                  '',
                                  '',
                                  qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                  qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                  '',
                                  '',
                                  TGeraArquivoAnexoEmailAutomatico.New(qryAutNot.FieldByName('FIS_NUMDOC').AsString,
                                                                       qryAutNot.FieldByName('FIS_ESPDOC').AsString,
                                                                       qryAutNot.FieldByName('FIS_CODEMP').AsString,
                                                                       qryAutNot.FieldByName('FIS_FORCLI').AsString,
                                                                       False,
                                                                       'BN',
                                                                       qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                                                       qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                                                       arqBase64),
                                  '',
                                  '',
                                  qryAutNot.FieldByName('FIS_ACESSO').AsString,
                                  qryAutNot.FieldByName('FIS_SERIE_').AsString,
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end;

  Finally
    FreeAndNil(qryAutNot);
    FreeAndNil(qryCadRec);
  End;
end;

procedure TNotificacoesMonitor.pFiltraAhEnviar(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
begin
  cdsNotFic.Filtered := False;

  if tipNot = notEmail then
    cdsNotFic.Filter := 'NOT_ENVEMA = '+QuotedStr('S');

  if tipNot = notSMS then
    cdsNotFic.Filter := 'NOT_ENVSMS = '+QuotedStr('S');

  if tipNot = notWhatsapp then
    cdsNotFic.Filter := 'NOT_ENVWPP = '+QuotedStr('S');

  if tipNot = notOpiniOne then
    cdsNotFic.Filter := 'NOT_NOTENV = '+QuotedStr('N');

  cdsNotFic.Filtered := True;
end;

function TNotificacoesMonitor.fNotificacaoJaFoiEnviada(strAutInc, strCampo: String; strValor: String = 'N'): Boolean;
begin
  Result := fCampoTabela(strCampo, 'NOTFIC', ['AUTOINCREM'], [strAutInc]) = strValor;
end;

procedure TNotificacoesMonitor.pMarcaEmailEnviadoNoCDS(cdsNotFic: TUniClientDataSet);
begin
  cdsNotFic.Edit;
  cdsNotFic.FieldByName('NOT_ENVEMA').AsString := 'N';
  cdsNotFic.Post;
end;

procedure TNotificacoesMonitor.pMarcaEnviado(strAutInc, strCampo: String; strValor: String = 'N');
var
  qryMarEnv: TUniQuery;
begin
  qryMarEnv := fCriaQuery(nil);
  try
    qryMarEnv.Close;
    qryMarEnv.SQL.Text :=
    ' UPDATE '+
    '   NOTFIC '+
    ' SET '+
      strCampo+' = :VALOR '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryMarEnv.ParamByName('AUTINC').AsString := strAutInc;
    qryMarEnv.ParamByName('VALOR').AsString  := strValor;
    qryMarEnv.ExecSQL;
  finally
    FreeAndNil(qryMarEnv);
  end;
end;

procedure TNotificacoesMonitor.pMarcaNotaNaoSeraEnviada(strAutInc,
  strHistor: String);
var
  qryNotFic: TUniQuery;
begin
  qryNotFic := fCriaQuery(nil);
  try
    qryNotFic.Close;
    qryNotFic.SQL.Text :=
    ' UPDATE '+
    '   NOTFIC '+
    ' SET '+
    '   NOT_NOTENV = "X" '+
    '  ,NOT_INFADI = :INFADI '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryNotFic.ParamByName('INFADI').AsString := strHistor;
    qryNotFic.ParamByName('AUTINC').AsString := strAutInc;
    qryNotFic.ExecSQL;
  finally
    FreeAndNil(qryNotFic);
  end;
end;

procedure TNotificacoesMonitor.pMarcaNotificacaoEnviada;
var
  qryNotEnv: TUniQuery;
begin
  qryNotEnv := fCriaQuery(nil);
  try
    qryNotEnv.Close;
    qryNotEnv.SQL.Text :=
    ' UPDATE NOTFIC '+
    '    SET NOT_NOTENV = "S" '+
    '  WHERE NOT_ENVEMA = "N" '+
    '    AND NOT_ENVSMS = "N" '+
    '    AND NOT_ENVWPP = "N" '+
    '    AND NOT_TIPO__ = 0 '+
    '    AND NOT_NOTENV = "N" ';
    qryNotEnv.ExecSQL;
  finally
    FreeAndNil(qryNotEnv);
  end;
end;

procedure TNotificacoesMonitor.pMarcaSMSEnviadoNoCDS(cdsNotFic: TUniClientDataSet);
begin
  cdsNotFic.Edit;
  cdsNotFic.FieldByName('NOT_ENVSMS').AsString := 'N';
  cdsNotFic.Post;
end;

procedure TNotificacoesMonitor.pMarcaWhatsappEnviadoNoCDS(cdsNotFic: TUniClientDataSet);
begin
  cdsNotFic.Edit;
  cdsNotFic.FieldByName('NOT_ENVWPP').AsString := 'N';
  cdsNotFic.Post;
end;

procedure TNotificacoesMonitor.pRetornaDadosPixPedido(const AstrNumDoc,
  AstrEspDoc, AstrCodEmp, AstrCodCli: String; out strQrCodePix,
  strLinkCitelPix: String);
Var
  LConsulta: TUniQuery;
begin
  strQrCodePix := EmptyStr;
  strLinkCitelPix := EmptyStr;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT M.MPX_QRCODE, ' +
                          '       M.MPX_LNKCIT  ' +
                          'FROM FATGOR F ' +
                          'JOIN EXTGOR E ON E.FGO_SEQFGO=F.AUTOINCREM ' +
                          'JOIN MOVPIX M ON M.MPX_CODEMP=E.FGO_EMPPIX ' +
                          '             AND M.MPX_TX_ID_=E.FGO_TX_PIX ' +
                          'WHERE F.FGO_NUMDOC=:NUMDOC ' +
                          '  AND F.FGO_ESPDOC=:ESPDOC ' +
                          '  AND F.FGO_CODEMP=:CODEMP ' +
                          '  AND F.FGO_CODCLI=:CODCLI ';

    LConsulta.ParamByName('NUMDOC').AsString := AstrNumDoc;
    LConsulta.ParamByName('ESPDOC').AsString := AstrEspDoc;
    LConsulta.ParamByName('CODEMP').AsString := AstrCodEmp;
    LConsulta.ParamByName('CODCLI').AsString := AstrCodCli;

    LConsulta.Open;

    if not LConsulta.IsEmpty then
    begin
      strQrCodePix := LConsulta.FieldByName('MPX_QRCODE').AsString;
      strLinkCitelPix := LConsulta.FieldByName('MPX_LNKCIT').AsString;
    end;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TNotificacoesMonitor.pDisparaPesquisaOpiniOne(cdsNotFic: TUniClientDataSet);
var
  qryOpiniOne: TUniQuery;
begin
  qryOpiniOne := fCriaQuery;
  try
    qryOpiniOne.Close;
    qryOpiniOne.SQL.Text :=
        ' SELECT '+
        '   GER_NUMDOC, '+
        '   GER_ESPDOC, '+
        '   GER_CODEMP, '+
        '   GER_CODCLI,  '+
        '   CONCAT(GER_CODVEN, "-", OPE_NOMOPE) AS VENDEDOR, '+
    IIF(cdsNotFic.FieldByName('NOT_GATILH').AsString = 'RT',
        '   "" AS MOTORISTA '+
        ' FROM '+
        '   MOVGER '+
        ' INNER JOIN CADOPE '+
        '   ON GER_CODVEN = OPE_CODOPE '+
        ' WHERE '+
        '   MOVGER.AUTOINCREM = :AUTINC '
        ,
        '   CONCAT(GER_CODMOT, "-", MOT_NOMMOT) AS MOTORISTA '+
        ' FROM '+
        '   ROMGERX '+
        ' INNER JOIN CADOPE '+
        '   ON GER_CODVEN = OPE_CODOPE '+
        ' INNER JOIN CADMOT '+
        '   ON GER_CODMOT = MOT_CODMOT '+
        ' WHERE '+
        '   GER_NOMTAB = "MOVGER" AND '+
        '   GER_DTABAI IS NOT NULL AND '+
        '   GER_AUTINC = :AUTINC ');

    qryOpiniOne.ParamByName('AUTINC').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryOpiniOne.Open;

    if qryOpiniOne.IsEmpty then
    begin
      if cdsNotFic.FieldByName('NOT_GATILH').AsString = 'ET' then
      begin
        qryOpiniOne.Close;
        qryOpiniOne.SQL.Text :=
        ' SELECT '+
        '   GER_NUMDOC, '+
        '   GER_ESPDOC, '+
        '   GER_CODEMP, '+
        '   GER_CODCLI, '+
        '   CONCAT(GER_CODVEN, "-", OPE_NOMOPE) AS VENDEDOR, '+
        '   CONCAT(GER_CODMOT, "-", MOT_NOMMOT) AS MOTORISTA '+
        ' FROM '+
        '   ROMGERX '+
        ' INNER JOIN CADOPE '+
        '   ON GER_CODVEN = OPE_CODOPE '+
        ' INNER JOIN CADMOT '+
        '   ON GER_CODMOT = MOT_CODMOT '+
        ' WHERE '+
        '   GER_NOMTAB = "FATGOR" AND '+
        '   GER_DTABAI IS NOT NULL AND '+
        '   GER_AUTINC = ( SELECT '+
        '                    FATDOR.FDO_SEQGER '+
        '                  FROM '+
        '                    FATDOR '+
        '                  WHERE '+
        '                    FDO_NUMFAT = :NUMFAT AND '+
        '                    FDO_TIPFAT = :TIPFAT AND '+
        '                    FDO_EMPFAT = :EMPFAT AND '+
        '                    FDO_CODCLI = :CODCLI LIMIT 1 ) ';

        qryOpiniOne.ParamByName('NUMFAT').AsString := fCampoTabela('GER_NUMDOC', 'MOVGER', ['AUTOINCREM'], [cdsNotFic.FieldByName('NOT_SEQGER').AsString]);
        qryOpiniOne.ParamByName('TIPFAT').AsString := fCampoTabela('GER_ESPDOC', 'MOVGER', ['AUTOINCREM'], [cdsNotFic.FieldByName('NOT_SEQGER').AsString]);
        qryOpiniOne.ParamByName('EMPFAT').AsString := fCampoTabela('GER_CODEMP', 'MOVGER', ['AUTOINCREM'], [cdsNotFic.FieldByName('NOT_SEQGER').AsString]);
        qryOpiniOne.ParamByName('CODCLI').AsString := fCampoTabela('GER_CODCLI', 'MOVGER', ['AUTOINCREM'], [cdsNotFic.FieldByName('NOT_SEQGER').AsString]);
        qryOpiniOne.Open;
      end;

      if qryOpiniOne.IsEmpty then
      begin
        cdsNotFic.Delete;
        Exit;
      end;
    end;

    if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_NOTENV', 'S')) and
       (TControllerOpiniOneCadastroDestinatario.fEnviaPesquisaOpiniOne(qryOpiniOne.FieldByName('GER_CODCLI').AsString,
                                                                       qryOpiniOne.FieldByName('GER_NUMDOC').AsString,
                                                                       qryOpiniOne.FieldByName('GER_ESPDOC').AsString,
                                                                       qryOpiniOne.FieldByName('GER_CODEMP').AsString,
                                                                       qryOpiniOne.FieldByName('VENDEDOR').AsString,
                                                                       qryOpiniOne.FieldByName('MOTORISTA').AsString,
                                                                       IIF(cdsNotFic.FieldByName('NOT_GATILH').AsString = 'RT',
                                                                           OpiniFaturamentoRetira,
                                                                           OpiniBaixaRomaneio))) then
      begin
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_NOTENV', 'S');

        cdsNotFic.Edit;
        cdsNotFic.FieldByName('NOT_NOTENV').AsString := 'S';
        cdsNotFic.Post;
      end;
  finally
    FreeAndNil(qryOpiniOne);
  end;
end;

procedure TNotificacoesMonitor.pDisparaPesquisaSatisfacao(cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryPesquisa: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryPesquisa := fCriaQuery(nil);
  try
    qryPesquisa.Close;
    qryPesquisa.SQL.Text :=
    ' SELECT '+
    '   GER_NUMDOC, '+
    '   GER_ESPDOC, '+
    '   GER_CODEMP, '+
    '   GER_CODCLI  '+
    ' FROM '+
    '   MOVGER '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   GER_DTAENT = :DTAENT '+

    ' UNION '+

    ' SELECT '+
    '   GER_NUMDOC, '+
    '   GER_ESPDOC, '+
    '   GER_CODEMP, '+
    '   GER_CODCLI  '+
    ' FROM '+
    '   NOTGER '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER AND '+
    '   GER_DTAENT = :DTAENT ';

    qryPesquisa.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryPesquisa.ParamByName('DTAENT').AsDate := cdsNotFic.FieldByName('NOT_DTAHOR').AsDateTime;
    qryPesquisa.Open;

    if qryPesquisa.IsEmpty then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryPesquisa.FieldByName('GER_NUMDOC').AsString,
                                  cdsNotFic.FieldByName('NOT_GATILH').AsString,
                                  qryPesquisa.FieldByName('GER_ESPDOC').AsString,
                                  '',
                                  cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                  qryPesquisa.FieldByName('GER_CODEMP').AsString,
                                  qryPesquisa.FieldByName('GER_CODCLI').AsString,
                                  '',
                                  '',
                                  nil,
                                  '',
                                  '',
                                  '',
                                  '',
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end

    else if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
      DestinatarioWhatsapp.FTo := cdsNotFic.FieldByName('NOT_CELULA').AsString;
      DestinatarioWhatsapp.FIDFila := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryPesquisa.FieldByName('GER_NUMDOC').AsString,
                                     cdsNotFic.FieldByName('NOT_GATILH').AsString,
                                     qryPesquisa.FieldByName('GER_ESPDOC').AsString,
                                     '',
                                     cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                     qryPesquisa.FieldByName('GER_CODEMP').AsString,
                                     qryPesquisa.FieldByName('GER_CODCLI').AsString,
                                     '',
                                     False,
                                     '',
                                     nil,
                                     '',
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     DestinatarioWhatsapp)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
    end;
  finally
    FreeAndNil(qryPesquisa);
  end;

end;

procedure TNotificacoesMonitor.pDisparaNotficAvisosIntelipost(
  cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryIntelipost: TUniQuery;
begin
  qryIntelipost := fCriaQuery(nil);
  try
    qryIntelipost.Close;
    qryIntelipost.SQL.Text :=
    ' SELECT '+
    '   FGO_NUMDOC, '+
    '   FGO_ESPDOC, '+
    '   FGO_CODEMP, '+
    '   FGO_CODCLI  '+
    ' FROM '+
    '   FATGOR '+
    ' WHERE '+
    '   AUTOINCREM = :SEQGER ';

    qryIntelipost.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryIntelipost.Open;

    if qryIntelipost.IsEmpty then
    begin
      cdsNotFic.Delete;
      Exit;
    end;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryIntelipost.FieldByName('FGO_NUMDOC').AsString,
                                  'AI',
                                  qryIntelipost.FieldByName('FGO_ESPDOC').AsString,
                                  '',
                                  cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                  qryIntelipost.FieldByName('FGO_CODEMP').AsString,
                                  qryIntelipost.FieldByName('FGO_CODCLI').AsString,
                                  '',
                                  '',
                                  TGeraArquivoAnexoEmailAutomatico.New(qryIntelipost.FieldByName('FGO_NUMDOC').AsString,
                                                                       qryIntelipost.FieldByName('FGO_ESPDOC').AsString,
                                                                       qryIntelipost.FieldByName('FGO_CODEMP').AsString,
                                                                       qryIntelipost.FieldByName('FGO_CODCLI').AsString,
                                                                       False,
                                                                       cdsNotFic.FieldByName('NOT_NOTFIC').AsString),
                                  '',
                                  '',
                                  '',
                                  '',
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False,
                                  cdsNotFic.FieldByName('NOT_INFADI').AsString)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      cdsNotFic.Edit;
      cdsNotFic.FieldByName('NOT_ENVEMA').AsString := 'N';
      cdsNotFic.Post;
    end

    else if tipNot = notWhatsapp then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
         (fDisparaWhatsappAutomatico(qryIntelipost.FieldByName('FGO_NUMDOC').AsString,
                                     'AI',
                                     qryIntelipost.FieldByName('FGO_ESPDOC').AsString,
                                     '',
                                     cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                     qryIntelipost.FieldByName('FGO_CODEMP').AsString,
                                     qryIntelipost.FieldByName('FGO_CODCLI').AsString,
                                     '',
                                     True,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(qryIntelipost.FieldByName('FGO_NUMDOC').AsString,
                                                                          qryIntelipost.FieldByName('FGO_ESPDOC').AsString,
                                                                          qryIntelipost.FieldByName('FGO_CODEMP').AsString,
                                                                          qryIntelipost.FieldByName('FGO_CODCLI').AsString,
                                                                          False,
                                                                          cdsNotFic.FieldByName('NOT_NOTFIC').AsString),
                                     '',
                                     '',
                                     '',
                                     Self.UnitName,
                                     cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                     cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                     cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                     cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                     '',
                                     '',
                                     True,
                                     True,
                                     nil,
                                     cdsNotFic.FieldByName('NOT_INFADI').AsString)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

      cdsNotFic.Edit;
      cdsNotFic.FieldByName('NOT_ENVWPP').AsString := 'N';
      cdsNotFic.Post;
    end;
  finally
    FreeAndNil(qryIntelipost);
  end;
end;

procedure TNotificacoesMonitor.pDisparaNotficAvisoCashback(
  cdsNotFic: TUniClientDataSet; tipNot: TTipoGatilho);
var
  qryCashback: TUniQuery;
  DestinatarioWhatsapp: TDestinatarioWhatsapp;
begin
  qryCashback := fCriaQuery;
  try
    qryCashback.Close;
    qryCashback.SQL.Add(' SELECT * ');
    qryCashback.SQL.Add(' FROM VENCSH ');
    qryCashback.SQL.Add(' WHERE ');
    qryCashback.SQL.Add('   AUTOINCREM = :SEQGER; ');
    qryCashback.ParamByName('SEQGER').AsString := cdsNotFic.FieldByName('NOT_SEQGER').AsString;
    qryCashback.Open;

    if cdsNotFic.FieldByName('NOT_NOTFIC').AsString = '7A' then
    begin
      If (qryCashback.FieldByName('VCB_VLRDSP').AsFloat <= 0) Or
         (qryCashback.FieldByName('VCB_STATUS').AsString <> 'A') Or
         (qryCashback.FieldByName('VCB_DTAVAL').AsDateTime < fNow) Then
      begin
        pMarcaNotaNaoSeraEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'CASHBACK NÃO ESTÁ MAIS DISPONÍVEL');
        cdsNotFic.Delete;
        Exit;
      end;
    end;

    if tipNot = notEmail then
    begin
      if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA')) and
         (fDisparaEmailAutomatico(qryCashback.FieldByName('VCB_NUMDOC').AsString,
                                  cdsNotFic.FieldByName('NOT_GATILH').AsString,
                                  qryCashback.FieldByName('VCB_ESPDOC').AsString,
                                  '',
                                  cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                  qryCashback.FieldByName('VCB_CODEMP').AsString,
                                  qryCashback.FieldByName('VCB_CODCLI').AsString,
                                  '',
                                  '',
                                  nil,
                                  '',
                                  '',
                                  '',
                                  '',
                                  cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                  IIF(cdsNotFic.FieldByName('NOT_OPEEMA').AsString='AUT', EmptyStr, cdsNotFic.FieldByName('NOT_OPEEMA').AsString),
                                  True,
                                  True,
                                  False)) then
        pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVEMA');

      pMarcaEmailEnviadoNoCDS(cdsNotFic);
    end
    else if tipNot = notWhatsapp then
    begin
      DestinatarioWhatsapp := TDestinatarioWhatsapp.Create;
      try
        DestinatarioWhatsapp.FAutIncCtt := cdsNotFic.FieldByName('NOT_SEQCTT').AsString;
        DestinatarioWhatsapp.FTo        := cdsNotFic.FieldByName('NOT_CELULA').AsString;
        DestinatarioWhatsapp.FIDFila    := cdsNotFic.FieldByName('NOT_IDFILA').AsString;

        if (not fNotificacaoJaFoiEnviada(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP')) and
           (fDisparaWhatsappAutomatico(qryCashback.FieldByName('VCB_NUMDOC').AsString,
                                       cdsNotFic.FieldByName('NOT_GATILH').AsString,
                                       qryCashback.FieldByName('VCB_ESPDOC').AsString,
                                       '',
                                       cdsNotFic.FieldByName('NOT_NOTFIC').AsString,
                                       qryCashback.FieldByName('VCB_CODEMP').AsString,
                                       qryCashback.FieldByName('VCB_CODCLI').AsString,
                                       '',
                                       False,
                                       '',
                                       nil,
                                       '',
                                       '',
                                       '',
                                       Self.UnitName,
                                       cdsNotFic.FieldByName('NOT_SEQCTT').AsString,
                                       cdsNotFic.FieldByName('NOT_CELULA').AsString,
                                       cdsNotFic.FieldByName('NOT_IDFILA').AsString,
                                       cdsNotFic.FieldByName('AUTOINCREM').AsString,
                                       '',
                                       '',
                                       True,
                                       False,
                                       DestinatarioWhatsapp)) then
          pMarcaEnviado(cdsNotFic.FieldByName('AUTOINCREM').AsString, 'NOT_ENVWPP');

        pMarcaWhatsappEnviadoNoCDS(cdsNotFic);
      finally
        FreeAndNil(DestinatarioWhatsapp);
      end;
    end;
  finally
    FreeAndNil(qryCashback);
  end;
end;

{ TNotificacao }

constructor TNotificacao.Create;
begin
  inherited Create;

  Self.FAgeDta := 0;
  Self.FAgeHor := 0;
end;

end.
