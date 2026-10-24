unit untLinkPagamentoCitelRetorno;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, System.IOUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types,
  {$ELSE }
  untFuncoesSimples, REST.Client, untFuncoes, untMovCar,
  {$ENDIF LINUX}
  untGravaMovCar, Data.DB, MemDS, DBAccess, Uni, System.DateUtils,
  untTypesSistema, untClassesComumLinkPagamentoCitel,
  untInterfaceLinkPagamentoCitel, System.Classes;

Const
  spIdPagtoOnlineCitel = 'LINK_PAGTO_ONLINE_CITEL_%s_%s';
  spAttemptsLockCitel = 10;
type
  TApplicationContext = class
  private
    class var FBuildDate: TDateTime;
    class function getBuildDate: TDateTime; static;
    class function fSqlJoinEmpresasNesteServidor: String;

  public
    class var strVersionNumber: String;
    class var strEmpresaLogada: String;
    class function fStrNomeDoRobo: String;
    class function fObterEmpresasComLinkConfigurado: TArray<string>;
    class function fExisteLockDoRobo: boolean;
    class property BuildDate: TDateTime read getBuildDate;
    class constructor Create;
    class function fGetEmpresasRoboAntigo(): {$IFDEF LINUX} IQuery {$ELSE } TDataset {$ENDIF LINUX};
  end;

  TController_Recebimento = class
    private
      function fConsultarTransacao(strNumNit : String; AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta;
      function fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray;
        recDadAdCar: TDadosAdicCartao; var AintSeqCon: Integer): Boolean;
      function fMovCarJaExiste(strCodCli, strSequen, strCodEmp, strNumDoc,
        strEspDoc: String; intCnt2: Integer; const strTipCar: String): Boolean;
      function fDataPagamento(strDtaPag : String) : TDateTime;
      function fHoraPagamento(strHraPag : String) : TDateTime;

      procedure pGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strTipLan : String; fltValCar: Double; intSeqConRcx: Integer);
      {$IFDEF LINUX}
      function fRealizarBaixaDoContasAReceber(const AstrNumNit, AstrMerCid: String;
                                              AobjApiTransacao : TConsultaLinkPagamentoResposta;
                                              const AintSeqCon: integer;
                                              const AdtaDtaRec: TDateTime): Boolean;
      {$ENDIF LINUX}
      function fRetornaCndPagPeriod(const intQtdPar, intPeriod, intExcDia: Integer;
                                    const intPriVenc: Integer = -1): String;
      function fEscolheCndPag(const AintQtdPar, AintPeriod, AintExcDia: Integer;
                              const AstrCndFatGor: String): String ;

      // --- persistence sub-methods ---
      procedure pAtualizarStatusSitCob(
        const AqryUpdate      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        const AstrNumNit, AstrMerchantId: String);

      procedure pAtualizarDadosPagamento(
        const AqryUpdate      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        const AstrNumNit, AstrMerchantId: String;
        const AdtaDtaPag: TDate; const AhraHraPag: TTime);

      function  fSqlDadosFinanceirosPD : String;
      function  fSqlDadosFinanceirosAGR: String;

      procedure pMontarInfoCartao(
        const AqryESiTef      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        const AstrPorBai, AstrCtaBai: String;
        var   AarrCartoes: TCartoesResumoCaixaArray);

      procedure pMontarRecDadAdCar(
        const AqryESiTef      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        var   ArecDadAdCar: TDadosAdicCartao);

      {$IFDEF LINUX}
      procedure pInserirBanTrf(const AqryUpdate: IQuery;
        const AstrSeqLan, AstrDescri: String; const AfltValor: Double);

      procedure pGravarTransferenciaCaixa(
        const AqryUpdate: IQuery; const AqryESiTef: IQuery;
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        const AstrPorBai, AstrCtaBai: String; const AintSeqCon: Integer);
      {$ENDIF LINUX}

      procedure pProcessarEfetuadaPD(
        const AqryUpdate      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AqryESiTef      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        const AstrPorBai, AstrCtaBai: String; const AintSeqCon: Integer);

      procedure pProcessarTransacaoEfetuada(
        const AqryUpdate      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AqryESiTef      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        const AstrMerchantId, AstrNumNit, AstrOrigem: String);

      procedure pMarcarNitComoELP(
        const AqryUpdate     : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AstrNumNit, AstrMerchantId: String);

      procedure pMarcarNitsComoELP(
        const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AlstNits: TStringList);

      procedure pPersistirTransacao(
        const AobjApiTransacao: TConsultaLinkPagamentoResposta;
        const AqryESiTef      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AqryUpdate      : {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
        const AstrMerchantId, AstrNumNit, AstrOrigem: String;
        const AlstNitsELP: TStringList);

    public
      procedure pProcessarRecebimentos(const AInfoExec: TInfoLinkPagamentoExec);
  end;

implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  untLinkPagamentoCitelStatus, untFactoryLinkPagamentoCitel,
  untArredondaParcelaImpl, untAdiantamentoClienteGenerico, untLinkPagamentoCitelRestApi,
  untRestApi, untLinkPagamentoCitelRepositorio, untDuplicatas{$IFDEF LINUX}, untTContasAReceberLinkPagamento {$ENDIF LINUX}, untMovBan;

function TController_Recebimento.fRetornaCndPagPeriod(const intQtdPar, intPeriod, intExcDia: Integer;
                                                      const intPriVenc: Integer = -1): String;
  Var
    intContador: Integer;
    intPeriodTmp: Integer;
begin

  Result := fStrZero(IntToStr(intQtdPar), 2);
  if intPriVenc = -1 then
    intPeriodTmp := intPeriod + intExcDia
  else
    intPeriodTmp := intPriVenc ;

  For intContador := 1 To intQtdPar Do
  Begin
    Result := Result + fStrZero(IntToStr(intPeriodTmp), 3);
    Inc(intPeriodTmp, intPeriod);
  End;

end;

function TController_Recebimento.fSqlDadosFinanceirosAGR: String;
begin
  Result :=
    ' SELECT DISTINCT S.SIT_VALTRA, S.SIT_DTAPAG,' +
    '   CTR.CTR_NUMDUP AS FGO_NUMDOC, CTR.CTR_ESPDOC AS FGO_ESPDOC,' +
    '   CTR.CTR_CODEMP AS FGO_CODEMP, CTR.CTR_CODCLI AS FGO_CODCLI,' +
    '   CND.CND_CNDPAG AS FGO_CONPAG,' +
    '   CT.CAR_CODCAR, CT.CAR_DESCAR, CT.CAR_TIPTAX,' +
    '   CT.CAR_PERDES, CT.CAR_PERIOD, CT.CAR_EXCDIA,' +
    '   CTR.CTR_CODVEN AS FGO_CODVEN' +
    ' FROM SITCOB S' +
    '   INNER JOIN SITDOC SD ON SD.DOC_NUMNIT = S.SIT_NUMNIT AND SD.DOC_MERCID = S.SIT_MERCID' +
    '   INNER JOIN CADREC CTR ON SD.DOC_NUMDOC = CTR.AUTOINCREM' +
    '   INNER JOIN CADCND CND ON CTR.CTR_CODCND = CND.CND_CODIGO' +
    '   INNER JOIN CADCAR CT' +
    '     ON (SELECT SIS_VALCFG FROM CFGSIS' +
    '         WHERE SIS_CODCFG = "CFG_CARSIT"' +
    '           AND CTR.CTR_CODEMP = SIS_CODEMP) = CT.CAR_CODCAR' +
    ' WHERE S.SIT_NUMNIT = :NUMNIT AND S.SIT_MERCID = :MERCID' +
    ' LIMIT 1 ';
end;

function TController_Recebimento.fSqlDadosFinanceirosPD: String;
begin
  Result :=
    ' SELECT S.SIT_VALTRA, S.SIT_DTAPAG,' +
    '   F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP, F.FGO_CODCLI,' +
    '   F.FGO_CONPAG, CT.CAR_CODCAR, CT.CAR_DESCAR, CT.CAR_TIPTAX,' +
    '   CT.CAR_PERDES, CT.CAR_PERIOD, CT.CAR_EXCDIA, F.FGO_CODVEN' +
    ' FROM SITCOB S' +
    '   INNER JOIN EXTGOR EG' +
    '     ON (S.SIT_NUMNIT = EG.FGO_SITNIT AND S.SIT_MERCID = EG.FGO_SITMID)' +
    '   INNER JOIN FATGOR F ON (F.AUTOINCREM = EG.FGO_SEQFGO)' +
    '   INNER JOIN CADCAR CT' +
    '     ON (SELECT SIS_VALCFG FROM CFGSIS' +
    '         WHERE SIS_CODCFG = "CFG_CARSIT"' +
    '           AND F.FGO_CODEMP = SIS_CODEMP) = CT.CAR_CODCAR' +
    ' WHERE S.SIT_NUMNIT = :NUMNIT AND S.SIT_MERCID = :MERCID' +
    ' LIMIT 1 ';
end;

{ TConsultaTransacao }

function TController_Recebimento.fConsultarTransacao(strNumNit : String;
                                                     AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta;
var
  LObjLink: ILinkPagamentoCitel ;
begin
  LObjLink := fCriarLinkPagamentoCitel ;
  Result := LObjLink.fConsultarTransacao(strNumNit, AdtaExpericao);
end;

procedure TController_Recebimento.pPersistirTransacao(
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const AqryESiTef: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AstrMerchantId, AstrNumNit, AstrOrigem: String;
  const AlstNitsELP: TStringList);
const
  spMaxRetryTimeout = 2;
  spRetryDelaysMs: array[0..1] of Integer = (10000, 20000);
var
  LintTentativas: Integer;
  LstrNumNit    : String;
begin
  LintTentativas := 0;
  LstrNumNit := AstrNumNit;

  repeat
    try
      fStartTransaction;
      try
        pAtualizarStatusSitCob(AqryUpdate, AobjApiTransacao, LstrNumNit, AstrMerchantId);

        if AobjApiTransacao.Status = stTransacaoEfetuada then
        begin
          pProcessarTransacaoEfetuada(AqryUpdate, AqryESiTef, AobjApiTransacao,
                                      AstrMerchantId, AstrNumNit, AstrOrigem);
        end;

        fCommit;
        Break;
      except
        on E: ExceptionLinkPgPersistencia do
        begin
          fRollBack;
          raise;
        end;
        on E: EUniError do
        begin
          fRollBack;
          if (E.ErrorCode = 2003) or  (E.ErrorCode = 2013) or
             (E.ErrorCode = 2006) or (E.ErrorCode = 1040)  then
            raise ExceptionLinkPgPersistencia.Create(E.Message)
          else
            raise;
        end;
        on E: Exception do
        begin
          fRollBack;
          raise;
        end;
      end;
    except
      on E: ExceptionLinkPgPersistencia do
      begin
        if LintTentativas >= spMaxRetryTimeout then
        begin
          pGravarErro(True,
            'ATENCAO SUPORTE: falha persistente ao gravar NIT: ' + LstrNumNit +
            ' apos ' + IntToStr(spMaxRetryTimeout + 1) + ' tentativas.' +
            ' Status alterado para ELP. Verificar LOGERR.' + sLineBreak + E.Message);
          AlstNitsELP.Add(LstrNumNit + '=' + AstrMerchantId);
          Break;
        end;

        pGravarErro(True,
          'Falha ao persistir NIT: ' + LstrNumNit +
          ' | Tentativa ' + IntToStr(LintTentativas + 1) + '/' + IntToStr(spMaxRetryTimeout + 1) +
          ' | Aguardando ' + IntToStr(spRetryDelaysMs[LintTentativas] div 1000) + 's...' +
          sLineBreak + E.Message);

        Sleep(spRetryDelaysMs[LintTentativas]);
        Inc(LintTentativas);
      end;
      on E: Exception do
        raise;
    end;
  until False;
end;

{$HINTS OFF}
procedure TController_Recebimento.pProcessarEfetuadaPD(
  const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AqryESiTef: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const AstrPorBai, AstrCtaBai: String; const AintSeqCon: Integer);
var
  LintSeqConRcx: Integer;
  LstrRcxCon: String;
begin
  LstrRcxCon := fRetRcxCon(AqryESiTef.FieldByName('FGO_CODEMP').AsString);
  if not TryStrToInt(LstrRcxCon, LintSeqConRcx) then
  begin
    raise Exception.Create('Sequencial de conciliacao invalido para empresa ' +
      AqryESiTef.FieldByName('FGO_CODEMP').AsString);
  end;

  pGravarAdtCliCartao(
    AqryESiTef.FieldByName('FGO_NUMDOC').AsString,
    AqryESiTef.FieldByName('FGO_ESPDOC').AsString,
    AqryESiTef.FieldByName('FGO_CODEMP').AsString,
    AqryESiTef.FieldByName('FGO_CODCLI').AsString,
    'C',
    fStrToFloat(AobjApiTransacao.Amount) / 100,
    LintSeqConRcx);

  {$IFDEF LINUX}
  // pGravarTransferenciaCaixa já propaga ExceptionLinkPgPersistencia
  pGravarTransferenciaCaixa(AqryUpdate, AqryESiTef, AobjApiTransacao,
    AstrPorBai, AstrCtaBai, AintSeqCon);
  {$ENDIF LINUX}
end;
{$HINTS ON}

procedure TController_Recebimento.pProcessarRecebimentos(const AInfoExec: TInfoLinkPagamentoExec);
var
  objApiTransacao      : TConsultaLinkPagamentoResposta;
  qrySitCob, qryESiTef, qryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  strMerchantId        : String;
  LblnSitDocExiste     : Boolean;
  LstrSql              : String;
  LEmpresasConfiguradas: TArray<string>;
  LEmpresa             : String;
  LlstNitsELP: TStringList;
  LintQtdELP : Integer;
begin
  objApiTransacao := nil;
  qrySitCob       := nil;
  qryESiTef       := nil;
  qryUpdate       := nil;
  LlstNitsELP     := TStringList.Create;

  try
    qrySitCob := fCriaQuery;
    qryESiTef := fCriaQuery;
    qryUpdate := fCriaQuery;

    TApplicationContext.strEmpresaLogada:= VS_strCodEmp;
    LEmpresasConfiguradas:= TApplicationContext.fObterEmpresasComLinkConfigurado;

    for LEmpresa in LEmpresasConfiguradas do
    begin
      try
        {$IFDEF LINUX}
          pDefinirEmpresa(LEmpresa);
          pIniciarVariaveis;
        {$ENDIF LINUX}

        if TApplicationContext.fExisteLockDoRobo then
          continue;

        strMerchantId := TLinkPagamentoCitelRepositorio.fGetMerchantId;

        LblnSitDocExiste := AInfoExec.TabelaSitDocExist ;

        if LblnSitDocExiste then
          LstrSql :=  ' (SELECT ' +
                      '   SITCOB.*, ' +
                      '   CAST("PD" AS CHAR(3)) AS ORIGEM ' +
                      ' FROM ' +
                      '   SITCOB LEFT JOIN SITDOC ON SITDOC.DOC_NUMNIT = SITCOB.SIT_NUMNIT AND SITDOC.DOC_MERCID = SITCOB.SIT_MERCID ' +
                      ' WHERE SITCOB.SIT_CODEMP = :CODEMP ' +
                      '   AND SITCOB.SIT_STATUS NOT IN("CON", "EST", "EXP", "NEG", "ABA", "CAN", "BLQ", "PPN", "TDD", "ELP") ' +
                      '   AND SITDOC.DOC_TIPLAN IS NULL) ' +
                      'UNION ALL ' +
                      '(SELECT DISTINCT ' +
                      '   SITCOB.*, ' +
                      '   SITDOC.DOC_TIPLAN AS ORIGEM ' +
                      ' FROM ' +
                      '   SITCOB INNER JOIN SITDOC ON SITDOC.DOC_NUMNIT = SITCOB.SIT_NUMNIT AND SITDOC.DOC_MERCID = SITCOB.SIT_MERCID ' +
                      ' WHERE SIT_CODEMP = :CODEMP ' +
                      '   AND SIT_STATUS NOT IN("CON", "EST", "EXP", "NEG", "ABA", "CAN", "BLQ", "TDD", "PPN", "ELP")) ' +
                      'UNION ALL ' +
                      ' (SELECT ' +
                      '   SITCOB.*, ' +
                      '   CAST("PD" AS CHAR(3)) AS ORIGEM ' +
                      ' FROM ' +
                      '   SITCOB LEFT JOIN SITDOC ON SITDOC.DOC_NUMNIT = SITCOB.SIT_NUMNIT AND SITDOC.DOC_MERCID = SITCOB.SIT_MERCID ' +
                      ' WHERE SITCOB.SIT_CODEMP = :CODEMP ' +
                      '   AND SITCOB.SIT_STATUS = "NEG" ' +
                      '   AND SITDOC.DOC_TIPLAN IS NULL AND SIT_DTAEXP IS NOT NULL AND SIT_DTAEXP >= CURRENT_DATE) '
        else
          LstrSql :=  ' SELECT ' +
                      '   SITCOB.*, ' +
                      '   CAST("PD" AS CHAR(3)) AS ORIGEM ' +
                      ' FROM ' +
                      '   SITCOB ' +
                      ' WHERE SITCOB.SIT_CODEMP = :CODEMP ' +
                      '   AND SITCOB.SIT_STATUS NOT IN ("CON", "EST", "EXP", "NEG", "ABA", "CAN", "BLQ", "PPN", "TDD", "ELP") ';


        qrySitCob.Close;
        qrySitCob.SQL.Clear;
        qrySitCob.SQL.Text := LstrSql;
        qrySitCob.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qrySitCob.Open;
        qrySitCob.First;

        while not qrySitCob.Eof do
        begin
          try
            try
              objApiTransacao := fConsultarTransacao(
                qrySitCob.FieldByName('SIT_NUMNIT').AsString,
                qrySitCob.FieldByName('SIT_DTAEXP').AsDateTime);

              if objApiTransacao <> nil then
              begin
                pPersistirTransacao(objApiTransacao, qryESiTef,
                                    qryUpdate, strMerchantId,
                                    qrySitCob.FieldByName('SIT_NUMNIT').AsString,
                                    qrySitCob.FieldByName('ORIGEM').AsString,
                                    LlstNitsELP );
              end;
            except
              on ETrnNotFound: ExceptionLinkPgTransacaoNaoEncontrada do
              begin
                try
                  objApiTransacao        := TConsultaLinkPagamentoResposta.Create;
                  objApiTransacao.status := 'CAN';

                  LintQtdELP := LlstNitsELP.Count;
                  pPersistirTransacao(objApiTransacao, qryESiTef, qryUpdate,
                                      strMerchantId,
                                      qrySitCob.FieldByName('SIT_NUMNIT').AsString,
                                      qrySitCob.FieldByName('ORIGEM').AsString,
                                      LlstNitsELP);

                  if LlstNitsELP.Count = LintQtdELP then
                  begin
                    pGravarErro(True, 'Link de pagamento removido no provedor (HTTP 404). NIT: ' +
                      qrySitCob.FieldByName('SIT_NUMNIT').AsString +
                      ' da empresa: ' + LEmpresa + '. Status alterado para CAN.');
                  end;
                except
                  on E: Exception do
                  begin  pGravarErro(True, 'Erro ao processar o link de pagamento: ' +
                      qrySitCob.FieldByName('SIT_NUMNIT').AsString +
                      ' da empresa: ' + LEmpresa + sLineBreak + E.Message);
                  end;
                end;
              end;

              on E: Exception do
              begin
                pGravarErro(True, 'Erro ao processar o link de pagamento: ' +
                  qrySitCob.FieldByName('SIT_NUMNIT').AsString +
                  ' da empresa: ' + LEmpresa + sLineBreak + e.Message);
                qrySitCob.Next;
                Continue;
              end;
            end;
          finally
            if Assigned(objApiTransacao) then
              FreeAndNil(objApiTransacao);
          end;
          qrySitCob.Next;
        end;
      except
        on E: Exception do
        begin
          pGravarErro(True, 'Erro ao processar a empresa: ' + LEmpresa
            + sLineBreak + E.Message);

          if qrySitCob.Active then
            qrySitCob.Next;

          Continue
        end;
      end;
    end;

    if LlstNitsELP.Count > 0 then
      pMarcarNitsComoELP(qryUpdate, LlstNitsELP);
  finally
    {$IFDEF LINUX}
    TTasklock.pZerarTentativasLock(TApplicationContext.fStrNomeDoRobo);
    {$ENDIF LINUX}

    pSetaEmpresaLogada(TApplicationContext.strEmpresaLogada);
    {$IFDEF LINUX}
      pIniciarVariaveis;
    {$ENDIF LINUX}

    FreeAndNil(objApiTransacao);

    {$IFDEF LINUX}
      qrySitCob:= nil;
      qryESiTef:= nil;
      qryUpdate:= nil;
    {$ELSE }
      FreeAndNil(qrySitCob);
      FreeAndNil(qryESiTef);
      FreeAndNil(qryUpdate);
    {$ENDIF LINUX};

    FreeAndNil(LlstNitsELP);
    Sleep(40000);
  end;
end;

procedure TController_Recebimento.pProcessarTransacaoEfetuada(
  const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AqryESiTef: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const AstrMerchantId, AstrNumNit, AstrOrigem: String);
var
  dtaDtaPag  : TDate;
  hraHraPag  : TTime;
  arrCartoes : TCartoesResumoCaixaArray;
  recDadAdCar: TDadosAdicCartao;
  LstrPorBai, LstrCtaBai, LstrOrigem, LstrNumNit: String;
  LintSeqCon : Integer;
begin
  LstrNumNit := AstrNumNit;
  LstrOrigem := AstrOrigem;

  dtaDtaPag := fDataPagamento(Copy(AobjApiTransacao.Payment_date, 1, 10));
  hraHraPag := fHoraPagamento(Copy(AobjApiTransacao.Payment_date, 12, 5));
  pAtualizarDadosPagamento(AqryUpdate, AobjApiTransacao, LstrNumNit, AstrMerchantId, dtaDtaPag, hraHraPag);

  AqryESiTef.Close;

  if LstrOrigem = 'PD' then
    AqryESiTef.SQL.Text := fSqlDadosFinanceirosPD
  else
    AqryESiTef.SQL.Text := fSqlDadosFinanceirosAGR;

  AqryESiTef.ParamByName('NUMNIT').AsString := LstrNumNit;
  AqryESiTef.ParamByName('MERCID').AsString := AstrMerchantId;
  AqryESiTef.Open;

  LstrPorBai := '';
  if fCfgSisExist('PORBLK', VS_strCodEmp) then
    LstrPorBai := Trim(fCfgSis('PORBLK', varString));
  LstrCtaBai := '';
  if fCfgSisExist('CTABLK', VS_strCodEmp) then
    LstrCtaBai := Trim(fCfgSis('CTABLK', varString));

  pMontarInfoCartao(AqryESiTef, AobjApiTransacao, LstrPorBai, LstrCtaBai, arrCartoes);
  pMontarRecDadAdCar(AqryESiTef, AobjApiTransacao, recDadAdCar);

  if not fGravarCartoes(arrCartoes, recDadAdCar, LintSeqCon) then
    raise ExceptionLinkPgPersistencia.Create('fGravarCartoes retornou False para NIT: ' + AstrNumNit);

  if LstrOrigem = 'PD' then
    pProcessarEfetuadaPD(AqryUpdate, AqryESiTef, AobjApiTransacao, LstrPorBai, LstrCtaBai, LintSeqCon)
  else
  begin
    {$IFDEF LINUX}
      fRealizarBaixaDoContasAReceber(LstrNumNit, AstrMerchantId, AobjApiTransacao, LintSeqCon, dtaDtaPag);
    {$ENDIF LINUX}
  end;
end;

{$IFDEF LINUX}
function TController_Recebimento.fRealizarBaixaDoContasAReceber(
  const AstrNumNit, AstrMerCid: String; AobjApiTransacao : TConsultaLinkPagamentoResposta;
  const AintSeqCon: integer; const AdtaDtaRec: TDateTime): Boolean;
var
  LqryCadRec: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LblnBaixaAnalitica: Boolean ;
  LstrMovBanBaixaSintetica: String ;
  LstrSql: String ;
  LdictSeqLan: TDictionary<String, String> ;
begin
  Result := False ;

  LstrSql := ' SELECT ' +
   '   CTR.*, CAST("" AS CHAR(70)) AS SEQLAN ' +
   ' FROM ' +
   '   SITCOB S ' +
   '   INNER JOIN SITDOC SD ON SD.DOC_NUMNIT = S.SIT_NUMNIT AND SD.DOC_MERCID = S.SIT_MERCID ' +
   '   INNER JOIN CADREC CTR ON SD.DOC_NUMDOC = CTR.AUTOINCREM ' +
   ' WHERE S.SIT_NUMNIT = :NumNit '+
   '   AND S.SIT_MERCID = :MerCid ';

  LqryCadRec := fCriaQuery;
  LdictSeqLan := TDictionary<String, String>.Create();
  try
    LqryCadRec.Close ;
    LqryCadRec.SQL.Clear ;
    LqryCadRec.SQL.Add(LstrSql) ;
    LqryCadRec.ParamByName('NumNit').AsString:= AstrNumNit;
    LqryCadRec.ParamByName('MerCid').AsString:= AstrMerCid;
    LqryCadRec.Open ;
    LqryCadRec.First ;

    If LqryCadRec.IsEmpty Then
        Raise Exception.Create('Duplicatas não foram encontradas para realizar a baixa!');

    LblnBaixaAnalitica := fCfgSis('CTR_AS', varString, LqryCadRec.FieldByName('CTR_CODEMP').AsString) = 'A';

    If Not LblnBaixaAnalitica Then
      TContasAReceberLinkPagamento.fRealizaGravacaoMovimentacaoBancaria(LqryCadRec,
                                                                        AobjApiTransacao,
                                                                        LblnBaixaAnalitica,
                                                                        LstrMovBanBaixaSintetica,
                                                                        LdictSeqLan,
                                                                        AdtaDtaRec);

    LqryCadRec.First;
    While Not LqryCadRec.Eof Do
    Begin
      If LblnBaixaAnalitica Then
        TContasAReceberLinkPagamento.fRealizaGravacaoMovimentacaoBancaria(LqryCadRec,
                                                                          AobjApiTransacao,
                                                                          LblnBaixaAnalitica,
                                                                          LstrMovBanBaixaSintetica,
                                                                          LdictSeqLan,
                                                                          AdtaDtaRec);

      TContasAReceberLinkPagamento.fBaixaTotalReceber(LqryCadRec,
                                                      AobjApiTransacao,
                                                      LstrMovBanBaixaSintetica,
                                                      AintSeqCon,
                                                      LdictSeqLan,
                                                      AdtaDtaRec) ;

      LqryCadRec.Next;
    End;

  finally
    {$IFNDEF LINUX} FreeAndNil(LqryCadRec); {$ENDIF LINUX}
    FreeAndNil(LdictSeqLan) ;
  end;
end;
{$ENDIF LINUX}

function TController_Recebimento.fHoraPagamento(strHraPag: String): TDateTime;
  var
    hraHraPag : TTime;
begin
  hraHraPag := StrToTime(strHraPag);
  Result := EncodeTime(HourOf(hraHraPag), MinuteOf(hraHraPag),SecondOf(hraHraPag),
                       MilliSecondOf(hraHraPag));
end;

function TController_Recebimento.fDataPagamento(strDtaPag: String): TDateTime;
  var
    dtaDtaPag : TDate;
begin
   dtaDtaPag := StrToDate(strDtaPag);
   Result := EncodeDate(YearOf(dtaDtaPag), MonthOf(dtaDtaPag), DayOf(dtaDtaPag));
end;

function TController_Recebimento.fEscolheCndPag(const AintQtdPar, AintPeriod,
  AintExcDia: Integer; const AstrCndFatGor: String): String;
var
  LstrLink: String ;
begin
  Result := AstrCndFatGor ;
  LstrLink := fCfgSis('LINKPG', varString) ;
  if MatchStr(LstrLink, ['3', '7']) then
  begin
    Result := fRetornaCndPagPeriod(AintQtdPar, AintPeriod, AintExcDia) ;
  end;
end;

function TController_Recebimento.fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray;
  recDadAdCar: TDadosAdicCartao; var AintSeqCon: Integer): Boolean;
  Var
    intCnt  : Integer;
    intCnt2 : Integer;
    intCnt3 : Integer;
    strNumDupCartao : String;
    arrDigDup: TArrDigDuplic;
    arrDigFat: TArrDigDuplic;
    arrDuplicata,
    arrDuplicFat : TArrDigDuplicArray;
    fltTotDig : Double;
    fltVlTxGe : Double;
    fltVlTxPc : Double;
    objArredondaParcela: untTypesSistema.IArredondaParcela;
    LTipoParcelamento: String;
    LstrRcxCon: String;
begin
  Result := True;

  Try

    For intCnt := 0 To Length(arrCartoes) -1 Do
    Begin
      If (Not Result) Then
        Break;

      LTipoParcelamento := '';

      {$IFNDEF LINUX}
        LTipoParcelamento := fCampoTabela('CAR_ARRPAR', 'CADCAR', ['CAR_CODCAR'], [arrCartoes[intCnt].strCodCar]);

        If (arrCartoes[intCnt].strTipCar = 'POS') And (LTipoParcelamento <> 'N') Then
          objArredondaParcela := TArredondaParCartaoPos.fArredondamentoParcelas(arrCartoes[intCnt].strCodCar)
        Else
          objArredondaParcela := fArredondamentoParcelas(arrCartoes[intCnt].strCodCar);
      {$ELSE}
        objArredondaParcela := fArredondamentoParcelas(arrCartoes[intCnt].strCodCar);
      {$ENDIF LINUX}
      fDigDuplicVar(arrCartoes[intCnt].strCndPag, 0, arrCartoes[intCnt].fltValDig, False, False, False, recDadAdCar.dtaDtaCar, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);
      SetLength(arrDuplicFat, Length(arrDuplicata));

      For intCnt3 := 0 To Length(arrDuplicata) - 1 Do
        arrDuplicFat[intCnt3] := arrDuplicata[intCnt3];

      {**********************************************************************}
      {* HIERARQUIA: CASO MANDOU TAXA NA FSCARTOES, IGNORA A CALCULADA NA   *}
      {* TELA: frmRcxDigCartoes                                             *}
      {*******************************************************************RN*}
      fltVlTxGe := 0;
      fltVlTxPc := 0;
      If (fFormataFloat(recDadAdCar.fltTxDsGe + recDadAdCar.fltTxDsPa, 2) > 0) Then
      Begin
        fltTotDig := arrCartoes[intCnt].fltValDig;

        If (fFormataFloat(recDadAdCar.fltTxDsGe, 2) > 0) Then
        Begin
          If (recDadAdCar.strTxDsGe = 'V') Then
            fltVlTxGe := recDadAdCar.fltTxDsGe
          Else If (recDadAdCar.strTxDsGe = 'P') Then
            fltVlTxGe := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsGe / 100 ) ), 2);

          fltTotDig := fltTotDig - fltVlTxGe;
          fltVlTxGe := fFormataFloat(fltVlTxGe / recDadAdCar.intQtdPar, 2);
        End;

        If (fFormataFloat(recDadAdCar.fltTxDsPa, 2) > 0) Then
        Begin
          If (recDadAdCar.strTxDsPa = 'V') Then
            fltVlTxPc := (recDadAdCar.fltTxDsPa * recDadAdCar.intQtdPar)
          Else If (recDadAdCar.strTxDsPa = 'P') Then
            fltVlTxPc := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsPa / 100 ) ), 2);

          fltTotDig := fltTotDig - fltVlTxPc;
          fltVlTxPc := fFormataFloat(fltVlTxPc / recDadAdCar.intQtdPar, 2);
        End;

        arrCartoes[intCnt].fltValDes := fltTotDig;
      End;

      fDigDuplicVar(arrCartoes[intCnt].strCndPag, 0, arrCartoes[intCnt].fltValDig, False, False, False, recDadAdCar.dtaDtaCar, False, arrDuplicata, 0, 'N', False, False, 0, objArredondaParcela);

      strNumDupCartao := fRetSequencialMovCar('MOVCAR', VS_strCodEmp);

      intCnt2 := 0;

      While (fEmptyStr(arrCartoes[intCnt].strCodFin) And (intCnt2 < Length(arrDuplicata)) And
             (Not fEmptyStr(arrDuplicata[intCnt2].strSequen))) Do
      Begin
        arrDigDup := arrDuplicata[intCnt2];
        arrDigFat := arrDuplicFat[intCnt2];

        If fMovCarJaExiste(recDadAdCar.strCodCli,
                           arrDigDup.strSequen,
                           recDadAdCar.strCodEmp,
                           recDadAdCar.strNumDoc,
                           recDadAdCar.strEspDoc,
                           intCnt2, arrCartoes[intCnt].strTipCar) Then
          Raise Exception.Create('Documento já foi importado na MOVCAR');

        LstrRcxCon := fRetRcxCon(recDadAdCar.strCodEmp);
        if not TryStrToInt(LstrRcxCon, AintSeqCon) then
          raise Exception.Create('Sequencial de conciliacao invalido para empresa ' + recDadAdCar.strCodEmp);

        Result := Result And fGravaMovCar('',
                                          'INCLUSÃO',
                                          strNumDupCartao,
                                          recDadAdCar.strCodCli,
                                          arrDigDup.strSequen,
                                          recDadAdCar.strCodEmp,
                                          arrCartoes[intCnt].strCodCar,
                                          recDadAdCar.dtaDtaCar,
                                          StrToDate(arrDigDup.dtaDtaVen),
                                          arrDigDup.curValor,
                                          arrDigDup.curValor,
                                          arrCartoes[intCnt].strObsCar,
                                          arrCartoes[intCnt].strObsCar2,
                                          arrCartoes[intCnt].strCndPag,
                                          0,
                                          0.0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          arrCartoes[intCnt].fltPerDes,
                                          arrDigFat.curValor,
                                          arrDigFat.curValor - arrDigDup.curValor,
                                          arrCartoes[intCnt].strNumCcd,
                                          fDocumeCar(recDadAdCar.strNumDoc, recDadAdCar.strEspDoc, recDadAdCar.strCodEmp, intCnt2),
                                          '',
                                          AintSeqCon,
                                          VS_strCodEmp,
                                          strLoginUsuarioLogado,
                                          False,
                                          '',
                                          'F',
                                          arrCartoes[intCnt].strCodFin,
                                          arrCartoes[intCnt].strTipCar,
                                          0,
                                          0,
                                          0,
                                          0,
                                          arrCartoes[intCnt].strNumNsu,
                                          recDadAdCar.strNumPok,
                                          recDadAdCar.dtaDtaCup,
                                          fltVlTxGe,
                                          fltVlTxPc,
                                          recDadAdCar.dtaDtaCup,
                                          '',
                                          False,
                                          '',
                                          '',
                                          arrCartoes[intCnt].strPixS_N,
                                          0,
                                          False,
                                          '',
                                          '',
                                          '',
                                          0,
                                          arrCartoes[intCnt].strPorCar ,
                                          arrCartoes[intCnt].strCtaCar,
                                          recDadAdCar.strCodVen);

        Inc(intCnt2);

        If (Not Result) Then
          Break;
      End;

      If (Not Result) Then
        Break;
    End;


  Except
    On E: Exception Do
    Begin

      raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TController_Recebimento.pAtualizarDadosPagamento(
  const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const AstrNumNit, AstrMerchantId: String;
  const AdtaDtaPag: TDate; const AhraHraPag: TTime);
begin
  AqryUpdate.Close;
  AqryUpdate.SQL.Text :=
    ' UPDATE SITCOB SET SIT_DTAPAG = :DTAPAG, SIT_HRAPAG = :HRAPAG,' +
    '   SIT_QTDPAR = :QTDPAR' +
    ' WHERE SIT_NUMNIT = :NUMNIT AND SIT_MERCID = :MERCID ';
  AqryUpdate.ParamByName('DTAPAG').AsDate   := AdtaDtaPag;
  AqryUpdate.ParamByName('HRAPAG').AsTime   := AhraHraPag;
  AqryUpdate.ParamByName('QTDPAR').AsString := AobjApiTransacao.Installments;
  AqryUpdate.ParamByName('NUMNIT').AsString := AstrNumNit;
  AqryUpdate.ParamByName('MERCID').AsString := AstrMerchantId;
  AqryUpdate.ExecSQL;
end;

procedure TController_Recebimento.pAtualizarStatusSitCob(
  const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const AstrNumNit, AstrMerchantId: String);
begin
  AqryUpdate.Close;
  AqryUpdate.SQL.Text :=
    ' UPDATE SITCOB SET SIT_STATUS = :STATUS, SIT_VIALOJ = :VIALOJ,' +
    '   SIT_VIACLI = :VIACLI, SIT_NUMCCD = :NUMCCD,' +
    '   SIT_TIPTRA = :TIPTRA, SIT_NUMNSU = :NUMNSU' +
    ' WHERE SIT_NUMNIT = :NUMNIT AND SIT_MERCID = :MERCID ';
  AqryUpdate.ParamByName('STATUS').AsString := AobjApiTransacao.Status;
  AqryUpdate.ParamByName('VIALOJ').AsString := AobjApiTransacao.Customer_receipt;
  AqryUpdate.ParamByName('VIACLI').AsString := AobjApiTransacao.Merchant_receipt;
  AqryUpdate.ParamByName('NUMCCD').AsString := AobjApiTransacao.Authorization_number;
  AqryUpdate.ParamByName('NUMNSU').AsString := AobjApiTransacao.Esitef_usn;
  AqryUpdate.ParamByName('TIPTRA').AsString := AobjApiTransacao.Payment_type;
  AqryUpdate.ParamByName('NUMNIT').AsString := AstrNumNit;
  AqryUpdate.ParamByName('MERCID').AsString := AstrMerchantId;
  AqryUpdate.ExecSQL;
end;

procedure TController_Recebimento.pGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strTipLan : String; fltValCar: Double; intSeqConRcx: Integer);
  Var
    documento: TDocAdiantamento;
    dadosAdiantamento: TDadosAdiantamento;
    totModalidades: TTotaisAdiantamento;
    LstrPorBai: String ;
    LstrCtaBai: String ;
begin
  FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);
  FillChar(totModalidades, SizeOf(totModalidades), #0);

  documento.strNumDoc := strNumDoc;
  documento.strEspDoc := strEspDoc;
  documento.strCodEmp := strCodEmp;
  documento.strCodCli := strCodCli;
  documento.fltValLan := fltValCar;

  dadosAdiantamento.AddDocumento(documento);

  dadosAdiantamento.strTipLan := strTipLan;
  dadosAdiantamento.dtaDtaLan := VS_Date;
  dadosAdiantamento.horHorLan := fTime();
  dadosAdiantamento.strOpeLan := '999';
  dadosAdiantamento.strEmpLan := strCodEmp;
  dadosAdiantamento.intSeqCon := intSeqConRcx;
  dadosAdiantamento.strDescri := 'RECEBIMENTO VIA LINK DE PAGAMENTO ' + UpperCase(TLinkPagamentoCitelFornecedores.fDescricao) + ' ADIANTAMENTO PEDIDO: ' + strNumDoc + '-' + strEspDoc;
  dadosAdiantamento.fltValDin := 0.00;
  dadosAdiantamento.fltValChV := 0.00;
  dadosAdiantamento.fltValChP := 0.00;
  dadosAdiantamento.fltValOrd := 0.00;
  dadosAdiantamento.fltValFin := 0.00;
  dadosAdiantamento.fltValCre := 0.00;
  dadosAdiantamento.fltValCar := fltValCar;
  dadosAdiantamento.fltValLan := fltValCar;

  LstrPorBai := '' ;
  if fCfgSisExist('PORBLK', VS_strCodEmp) then
    LstrPorBai := trim(fCfgSis('PORBLK', varString)) ;

  if not fEmptyStr(LstrPorBai) then
    dadosAdiantamento.strCodPor := LstrPorBai ;

  LstrCtaBai := '' ;
  if fCfgSisExist('CTABLK', VS_strCodEmp) then
    LstrCtaBai := trim(fCfgSis('CTABLK', varString)) ;

  if not fEmptyStr(LstrCtaBai) then
    dadosAdiantamento.strCodCta := LstrCtaBai ;

  TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);
end;

{$IFDEF LINUX}
procedure TController_Recebimento.pGravarTransferenciaCaixa(
  const AqryUpdate: IQuery; const AqryESiTef: IQuery;
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const AstrPorBai, AstrCtaBai: String; const AintSeqCon: Integer);
var
  LstrDescri              : String;
  LstrTransferenciaLiberada: String;
  LstrSeqLan              : String;
  AfltValor               : Double;
begin
  if fEmptyStr(AstrPorBai) then
    Exit;

  AfltValor := fStrToFloat(AobjApiTransacao.Amount) / 100;
  LstrDescri := 'TF CAIXA (CAR) LNK - ' + AstrPorBai + '-' +
    fCampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [AstrPorBai]);
  LstrTransferenciaLiberada := 'S';

  LstrSeqLan := fGravaMovBan(AstrCtaBai, AstrPorBai, strLoginUsuarioLogado,
                          AqryESiTef.FieldByName('SIT_DTAPAG').AsDateTime,
                          fTime(), '', 'C', VS_strCodEmp, AfltValor,
                          LstrDescri, '', '', '', '', 0, 'A', VS_strCodEmp,
                         '', '', '', Nil, AintSeqCon, 0, '', '', '', '', '',
                         '', 1, True, {$IFDEF LINUX}'TRF'{$ELSE}Nil{$ENDIF},
                         '', LstrTransferenciaLiberada);

  pInserirBanTrf(AqryUpdate, LstrSeqLan, LstrDescri, AfltValor);
end;
{$ENDIF LINUX}

{$IFDEF LINUX}
procedure TController_Recebimento.pInserirBanTrf(
  const AqryUpdate: IQuery;
  const AstrSeqLan, AstrDescri: String;
  const AfltValor: Double);
begin
  AqryUpdate.Close;
  AqryUpdate.SQL.Text :=
    'INSERT INTO BANTRF (AUTOINCREM, CTB_SEQLAN, RCX_CARREC, RCX_CHQAVI,' +
    '  RCX_CHQPRE, RCX_CODEMP, RCX_CODOPE, RCX_DESCRI,' +
    '  RCX_DINREC, RCX_ORDREC, RCX_VALDOC, RCX_VALFIN)' +
    ' VALUES (:AUTOINCREM, :SEQLAN, :CARREC, :CHQAVI,' +
    '  :CHQPRE, :CODEMP, :CODOPE, :DESCRI,' +
    '  :DINREC, :ORDREC, :VALDOC, :VALFIN) ';
  AqryUpdate.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('BANTRF', VS_strCodEmp);
  AqryUpdate.ParamByName('SEQLAN').AsString     := AstrSeqLan;
  AqryUpdate.ParamByName('CARREC').AsFloat      := AfltValor;
  AqryUpdate.ParamByName('CHQAVI').AsFloat      := 0.00;
  AqryUpdate.ParamByName('CHQPRE').AsFloat      := 0.00;
  AqryUpdate.ParamByName('CODEMP').AsString     := VS_strCodEmp;
  AqryUpdate.ParamByName('CODOPE').AsString     := strLoginUsuarioLogado;
  AqryUpdate.ParamByName('DESCRI').AsString     := AstrDescri;
  AqryUpdate.ParamByName('DINREC').AsFloat      := 0.00;
  AqryUpdate.ParamByName('ORDREC').AsFloat      := 0.00;
  AqryUpdate.ParamByName('VALDOC').AsFloat      := AfltValor;
  AqryUpdate.ParamByName('VALFIN').AsFloat      := 0.00;
  AqryUpdate.ExecSQL;
end;
{$ENDIF LINUX}

procedure TController_Recebimento.pMarcarNitComoELP(
  const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AstrNumNit, AstrMerchantId: String);
var
  LintTent: Integer;
begin
  for LintTent := 0 to 2 do
  try
    fStartTransaction;
    try
      AqryUpdate.Close;
      AqryUpdate.SQL.Text :=
        ' UPDATE SITCOB SET SIT_STATUS = :STATUS' +
        ' WHERE SIT_NUMNIT = :NUMNIT AND SIT_MERCID = :MERCID ';
      AqryUpdate.ParamByName('STATUS').AsString := stTransacaoErroPersistente;
      AqryUpdate.ParamByName('NUMNIT').AsString := AstrNumNit;
      AqryUpdate.ParamByName('MERCID').AsString := AstrMerchantId;
      AqryUpdate.ExecSQL;
      fCommit;
      Exit;
    except
      on E: Exception do
      begin
        try fRollBack; except end;
        raise;
      end;
    end;
  except
    on E: Exception do
    begin
      if LintTent = 2 then
        pGravarErro(True, 'Falha ao marcar NIT ' + AstrNumNit + ' como ELP apos 3 tentativas: ' + E.Message)
      else
        Sleep(3000);
    end;
  end;
end;

procedure TController_Recebimento.pMarcarNitsComoELP(
  const AqryUpdate: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AlstNits: TStringList);
var
  LintIdx: Integer;
begin
  for LintIdx := 0 to AlstNits.Count - 1 do
    pMarcarNitComoELP(AqryUpdate, AlstNits.Names[LintIdx], AlstNits.ValueFromIndex[LintIdx]);
end;

procedure TController_Recebimento.pMontarInfoCartao(
  const AqryESiTef: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const AstrPorBai, AstrCtaBai: String;
  var AarrCartoes: TCartoesResumoCaixaArray);
var
  LinfoCartao: TInfoCadcar;
  LstrCndPag : String;
  LintInstallments: Integer;
begin
  SetLength(AarrCartoes, 1);
  FillChar(AarrCartoes[0], SizeOf(AarrCartoes[0]), #0);
  AarrCartoes[0].intCodSeq := 0;

  if not TryStrToInt(AobjApiTransacao.Installments, LintInstallments) then
    raise Exception.Create('Installments inválido: ' + AobjApiTransacao.Installments);

  LinfoCartao := TlinkPagamentoCitelAssociaCartao.fRetornaCodigoCartao(
    LintInstallments, AobjApiTransacao.brand,
    AobjApiTransacao.payment_type,
    AqryESiTef.FieldByName('FGO_CODEMP').AsString,
    AqryESiTef.FieldByName('CAR_CODCAR').AsString,
    AqryESiTef.FieldByName('CAR_DESCAR').AsString,
    AqryESiTef.FieldByName('CAR_TIPTAX').AsString,
    AqryESiTef.FieldByName('CAR_PERDES').AsFloat,
    AqryESiTef.FieldByName('CAR_PERIOD').AsInteger,
    AqryESiTef.FieldByName('CAR_EXCDIA').AsInteger);

  LstrCndPag := fEscolheCndPag(LintInstallments, LinfoCartao.Period,
    LinfoCartao.Excdia, AqryESiTef.FieldByName('FGO_CONPAG').AsString);

  AarrCartoes[0].strCodCar := LinfoCartao.CodCar;
  AarrCartoes[0].strDesCar := LinfoCartao.DesCar;
  AarrCartoes[0].fltValDig := fStrToFloat(AobjApiTransacao.Amount) / 100;
  AarrCartoes[0].strCndPag := LstrCndPag;
  AarrCartoes[0].strObsCar  := TLinkPagamentoCitelHistoricoCartao.fHist01(AobjApiTransacao);
  AarrCartoes[0].strObsCar2 := TLinkPagamentoCitelHistoricoCartao.fHist02(AobjApiTransacao);
  AarrCartoes[0].strNumCcd  := AobjApiTransacao.Authorization_number;
  AarrCartoes[0].fltPerDes  := IIF(LinfoCartao.TipTax.ToUpper = 'P', LinfoCartao.PerDes,
    (LinfoCartao.PerDes / (AarrCartoes[0].fltValDig / StrToIntDef(Copy(LstrCndPag, 0, 2), 1)) * 100));
  AarrCartoes[0].fltValDes  := fCalculaValDocCartao(AarrCartoes[0].fltValDig, AarrCartoes[0].fltPerDes);
  AarrCartoes[0].strCodFin  := '';
  AarrCartoes[0].strTipCar  := 'SIT';
  AarrCartoes[0].strNumNsu  := AobjApiTransacao.Esitef_usn;
  AarrCartoes[0].strConteudoArquivo := '';
  AarrCartoes[0].strPorCar  := AstrPorBai;
  AarrCartoes[0].strCtaCar  := AstrCtaBai;
  AarrCartoes[0].strPixS_N  := IfThen(AobjApiTransacao.payment_type = 'PIX', 'S', 'N');
end;

procedure TController_Recebimento.pMontarRecDadAdCar(
  const AqryESiTef: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF LINUX};
  const AobjApiTransacao: TConsultaLinkPagamentoResposta;
  var ArecDadAdCar: TDadosAdicCartao);
var
  LintInstallments: Integer;
begin
  if not TryStrToInt(AobjApiTransacao.Installments, LintInstallments) then
    raise Exception.Create('Installments inválido: ' + AobjApiTransacao.Installments);

  FillChar(ArecDadAdCar, SizeOf(ArecDadAdCar), #0);
  ArecDadAdCar.strNumDoc := AqryESiTef.FieldByName('FGO_NUMDOC').AsString;
  ArecDadAdCar.strEspDoc := AqryESiTef.FieldByName('FGO_ESPDOC').AsString;
  ArecDadAdCar.strCodEmp := AqryESiTef.FieldByName('FGO_CODEMP').AsString;
  ArecDadAdCar.strCodCli := AqryESiTef.FieldByName('FGO_CODCLI').AsString;
  ArecDadAdCar.dtaDtaCar := Vs_Date;
  ArecDadAdCar.dtaDtaCup := AqryESiTef.FieldByName('SIT_DTAPAG').AsDateTime;
  ArecDadAdCar.fltTotVen := AqryESiTef.FieldByName('SIT_VALTRA').AsFloat;
  ArecDadAdCar.fltTxDsGe := 0;
  ArecDadAdCar.fltTxDsPa := 0;
  ArecDadAdCar.strTxDsGe := '';
  ArecDadAdCar.strTxDsPa := '';
  ArecDadAdCar.intQtdPar := LintInstallments;
  ArecDadAdCar.strCodVen := LeftStr(AqryESiTef.FieldByName('FGO_CODVEN').AsString, 3);
end;

function TController_Recebimento.fMovCarJaExiste(strCodCli, strSequen, strCodEmp, strNumDoc,
  strEspDoc: String; intCnt2: Integer; const strTipCar: String): Boolean;
var
  qryMovCar: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryMovCar := fCriaQuery;

  Try
    With qryMovCar Do
    Begin
      SQL.Add('SELECT AUTOINCREM ');
      SQL.Add('FROM MOVCAR ');
      SQL.Add('WHERE MCA_CODCLI = :CODCLI AND ');
      SQL.Add('      MCA_PARCEL = :PARCEL AND ');
      SQL.Add('      MCA_CODEMP = :CODEMP AND ');
      SQL.Add('      MCA_DOCUME = :DOCUME AND ');
      SQL.Add('      MCA_TIPCAR = :TIPCAR ');

      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('PARCEL').AsString := strSequen;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('DOCUME').AsString := fDocumeCar(strNumDoc, strEspDoc, strCodEmp, intCnt2);
      ParamByName('TIPCAR').AsString := strTipCar;
      Open;

      Result := Not IsEmpty;
    End;

  Finally
    {$IFNDEF LINUX} FreeAndNil(qryMovCar); {$ENDIF LINUX}
  End;
end;

{ TApplicationContext }

class function TApplicationContext.getBuildDate: TDateTime;
begin
  Result:= fBuildDate;

  try
    if Result > 0 then
      exit;

    try
      fBuildDate:= TFile.GetLastWriteTime(ParamStr(0));
    except
      fBuildDate:= 0;
    end;

  finally
    Result:= fBuildDate;
  end;
end;

class constructor TApplicationContext.Create;
begin
  TApplicationContext.FBuildDate:= 0;
end;

class function TApplicationContext.fExisteLockDoRobo: boolean;
var
  qryLock: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result:= False;
  {$IFNDEF LINUX} qryLock := nil; {$ENDIF}

  try
    qryLock:= fCriaQuery;
    qryLock.SQL.SetText(pChar(
      'SELECT LCK_CHAACE FROM LCKATC ' + sLineBreak +
      'WHERE LCK_CHAACE LIKE :CHAACE'));

    qryLock.ParamByName('CHAACE').AsString :=
      '%LINK_PAGTO_ONLINE_CITEL_' + VS_strCodEmp + '%';

    qryLock.Open;

    if qryLock.Eof = False then
      Result:= True;
  finally
    {$IFDEF LINUX} qryLock:= nil;
    {$ELSE } FreeAndNil(qryLock);
    {$ENDIF LINUX};
  end;
end;

class function TApplicationContext.fSqlJoinEmpresasNesteServidor: String;
begin
  // Copia local da regra de fEmpresaNesteServidor (untFuncoesSimples), mantida
  // dentro do modulo de link de pagamento para nao impactar as demais rotinas.
  // Garante que o robo so processe as empresas hospedadas neste servidor.
  // Fail-open igual ao original: sem a tabela, nao restringe empresa nenhuma -
  // um INNER JOIN incondicional derrubaria o robo onde ela nao existe, e o
  // faria parar em silencio onde existisse vazia.
  Result := '' ;
  if fTabelaExiste('EMPRESAS_NESTE_SERVIDOR') then
    Result := 'INNER JOIN EMPRESAS_NESTE_SERVIDOR ON SIS_CODEMP = SRV_CODEMP ' + sLineBreak ;
end;

class function TApplicationContext.fGetEmpresasRoboAntigo: {$IFDEF LINUX} IQuery {$ELSE } TDataset {$ENDIF LINUX};
var
  qryEmpresas: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryEmpresas := fCriaQuery;
  qryEmpresas.SQL.Clear;
  qryEmpresas.SQL.Add('SELECT SIS_CODEMP FROM CFGSIS ' + sLineBreak +
                      TApplicationContext.fSqlJoinEmpresasNesteServidor +
                      'WHERE SIS_CODCFG = :CODCFG AND SIS_VALCFG <> :VALCFG;');
  qryEmpresas.ParamByName('CODCFG').AsString := 'CFG_LINKPG';
  qryEmpresas.ParamByName('VALCFG').AsString := '1';
  qryEmpresas.Open;
  Result := qryEmpresas;
end;

class function TApplicationContext.fObterEmpresasComLinkConfigurado: TArray<string>;
var
  LListaDeEmpresasConfiguradas: TStringList;
  qryEmpresas: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  SetLength(Result, 0);
  LListaDeEmpresasConfiguradas:= nil;
  {$IFNDEF LINUX} qryEmpresas := nil; {$ENDIF}

  try
    LListaDeEmpresasConfiguradas:= TStringList.Create;
    qryEmpresas:= fCriaQuery;
    qryEmpresas.SQL.SetText(pChar(
      'SELECT SIS_CODEMP FROM CFGSIS ' + sLineBreak +
      TApplicationContext.fSqlJoinEmpresasNesteServidor +
      'WHERE SIS_CODCFG IN ("CFG_LINKPG") '+ sLineBreak +
      '  AND SIS_VALCFG > 1 '+ sLineBreak +
      'ORDER BY SIS_CODEMP;'));

    qryEmpresas.Open;

    while not(qryEmpresas.Eof) do
    begin
      LListaDeEmpresasConfiguradas.Add(qryEmpresas.FieldByName('SIS_CODEMP').AsString);
      qryEmpresas.Next;
    end;

    Result:= LListaDeEmpresasConfiguradas.ToStringArray;
  finally
    FreeAndNil(LListaDeEmpresasConfiguradas);
    {$IFDEF LINUX} qryEmpresas:= nil;
    {$ELSE } FreeAndNil(qryEmpresas);
    {$ENDIF LINUX};
  end;
end;

class function TApplicationContext.fStrNomeDoRobo: String;
begin
  if (TApplicationContext.BuildDate > 0) then
  begin
    Result:= Format(spIdPagtoOnlineCitel, [TApplicationContext.strVersionNumber,
      FormatDateTime('yyyymmdd', TApplicationContext.BuildDate)]);

    Exit;
  end;

  Result:= Format(spIdPagtoOnlineCitel, [TApplicationContext.strVersionNumber, '']);
end;

end.
