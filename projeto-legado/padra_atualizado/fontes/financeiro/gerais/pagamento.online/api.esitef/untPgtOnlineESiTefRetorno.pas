unit untPgtOnlineESiTefRetorno;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types,
  {$ELSE }
  untFuncoesSimples, REST.Client, untFuncoes, untMovCar,
  {$ENDIF LINUX}
  untGravaMovCar, Data.DB, MemDS, DBAccess, Uni, System.DateUtils,
  untTypesSistema;

Const
  spIdPagtoOnlineESiTef = 'PAGTO_ONLINE_ESITEF_%s';
  spAttemptsLockEsitef = 10;

type

  TPaymentClass = class
  private
    FAcquirer_id: String;
    FAcquirer_name: String;
    FAmount: String;
    FAuthorization_number: String;
    FAuthorizer_code: String;
    FAuthorizer_date: String;
    FAuthorizer_id: String;
    FAuthorizer_merchant_id: String;
    FAuthorizer_message: String;
    FCustomer_receipt: String;
    FEsitef_usn: String;
    FHost_usn: String;
    FIssuer: String;
    FMerchant_receipt: String;
    FMerchant_usn: String;
    FNit: String;
    FOrder_id: String;
    FPayment_date: String;
    FPayment_type: String;
    FSitef_usn: String;
    FStatus: String;
    FInstallments : String;
  public
    property acquirer_id: String read FAcquirer_id write FAcquirer_id;
    property acquirer_name: String read FAcquirer_name write FAcquirer_name;
    property amount: String read FAmount write FAmount;
    property authorization_number: String read FAuthorization_number write FAuthorization_number;
    property authorizer_code: String read FAuthorizer_code write FAuthorizer_code;
    property authorizer_date: String read FAuthorizer_date write FAuthorizer_date;
    property authorizer_id: String read FAuthorizer_id write FAuthorizer_id;
    property authorizer_merchant_id: String read FAuthorizer_merchant_id write FAuthorizer_merchant_id;
    property authorizer_message: String read FAuthorizer_message write FAuthorizer_message;
    property customer_receipt: String read FCustomer_receipt write FCustomer_receipt;
    property esitef_usn: String read FEsitef_usn write FEsitef_usn;
    property host_usn: String read FHost_usn write FHost_usn;
    property issuer: String read FIssuer write FIssuer;
    property merchant_receipt: String read FMerchant_receipt write FMerchant_receipt;
    property merchant_usn: String read FMerchant_usn write FMerchant_usn;
    property nit: String read FNit write FNit;
    property order_id: String read FOrder_id write FOrder_id;
    property payment_date: String read FPayment_date write FPayment_date;
    property payment_type: String read FPayment_type write FPayment_type;
    property sitef_usn: String read FSitef_usn write FSitef_usn;
    property status: String read FStatus write FStatus;
    property installments: String read FInstallments write FInstallments;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPaymentClass;
  end;

  TRootClass = class
  private
    FCode: String;
    FMessage: String;
    FPayment: TPaymentClass;
  public
    property code: String read FCode write FCode;
    property message: String read FMessage write FMessage;
    property payment: TPaymentClass read FPayment write FPayment;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRootClass;
  end;

  TController_Recebimento = class
    private
      function fConsultarTransacao(strNumNit : String) : TRootClass;
      function fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray;
        recDadAdCar: TDadosAdicCartao; var AintSeqCon: Integer): Boolean;
      function fMovCarJaExiste(strCodCli, strSequen, strCodEmp, strNumDoc,
        strEspDoc: String; intCnt2: Integer): Boolean;
      function fDataPagamento(strDtaPag : String) : TDateTime;
      function fHoraPagamento(strHraPag : String) : TDateTime;

      procedure pGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli,
        strTipLan : String; fltValCar: Double; intSeqConRcx: Integer);

      {$IFDEF LINUX}
      function fRealizarBaixaDoContasAReceber(const AstrNumNit, AstrMerCid: String;
                                              AobjApiTransacao : TRootClass;
                                              const AintSeqCon: integer;
                                              const AdtaDtaRec: TDateTime): Boolean;
      {$ENDIF LINUX}

    public
      procedure pProcessarRecebimentos;
  end;

implementation

uses
  {$IFNDEF LINUX}
    untArredondaParcelasCartoes,
  {$ENDIF LINUX}
  untLinkPagamentoCitelStatus, untArredondaParcelaImpl, untAdiantamentoClienteGenerico, untPgtOnlineESiTefRestApi,
  untRestApi, untPgtOnlineESiTefRepositorio, untDuplicatas;

{TPaymentClass}


function TPaymentClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPaymentClass.FromJsonString(AJsonString: string): TPaymentClass;
begin
  result := TJson.JsonToObject<TPaymentClass>(AJsonString)
end;

{TRootClass}

constructor TRootClass.Create;
begin
  inherited;
  FPayment := TPaymentClass.Create();
end;

destructor TRootClass.Destroy;
begin
  FPayment.free;
  inherited;
end;

function TRootClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRootClass.FromJsonString(AJsonString: string): TRootClass;
begin
  result := TJson.JsonToObject<TRootClass>(AJsonString);
end;

{ TConsultaTransacao }

function TController_Recebimento.fConsultarTransacao(strNumNit : String) : TRootClass;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ESITEF', TControllerESiTef.fConfigurarESiTef);
  TControllerESiTef.strNumNit := strNumNit;
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'api/v1/transactions/'+strNumNit;
    RestRequest.Method   := rmGET;

    RestRequest.Params.AddItem('merchant_id', TPgtOnlineESiTefRepositorio.fGetMerchantId, pkHTTPHEADER);
    RestRequest.Params.AddItem('merchant_key', TPgtOnlineESiTefRepositorio.fGetMerchantKey, pkHTTPHEADER);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TRootClass.FromJsonString(JSONRetorno);

  finally
    {$IFNDEF LINUX}
    RestRequest.Free;
    ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

procedure TController_Recebimento.pProcessarRecebimentos;
  var
    objApiTransacao : TRootClass;
    qrySitCob, qryESiTef, qryUpdate: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    strHora, strData : String;
    dtaDtaPag: TDate; hraHraPag: TTime;
    arrCartoes: TCartoesResumoCaixaArray;
    recDadAdCar: TDadosAdicCartao;
    intPosCar : Integer;
    strMerchantId : string;
    LblnSitDocExiste: Boolean;
    LstrSql: String;
    LintSeqCon: Integer ;
begin
  try
    fStartTransaction;

    qrySitCob := fCriaQuery;
    qryESiTef := fCriaQuery;
    qryUpdate := fCriaQuery;
    objApiTransacao := nil;

    try
      strMerchantId := TPgtOnlineESiTefRepositorio.fGetMerchantId;

      LblnSitDocExiste := fTabelaExiste('SITDOC') ;
      if LblnSitDocExiste then
        LstrSql :=  ' (SELECT ' +
                    '   SITCOB.*, ' +
                    '   CAST("PD" AS CHAR(3)) AS ORIGEM ' +
                    ' FROM ' +
                    '   SITCOB LEFT JOIN SITDOC ON SITDOC.DOC_NUMNIT = SITCOB.SIT_NUMNIT AND SITDOC.DOC_MERCID = SITCOB.SIT_MERCID ' +
                    ' WHERE SITCOB.SIT_CODEMP = :CODEMP ' +
                    '   AND SITCOB.SIT_STATUS NOT IN("CON", "EST", "EXP", "NEG", "ABA", "CAN") ' +
                    '   AND SITDOC.DOC_TIPLAN IS NULL) ' +
                    'UNION ALL ' +
                    '(SELECT DISTINCT ' +
                    '   SITCOB.*, ' +
                    '   SITDOC.DOC_TIPLAN AS ORIGEM ' +
                    ' FROM ' +
                    '   SITCOB INNER JOIN SITDOC ON SITDOC.DOC_NUMNIT = SITCOB.SIT_NUMNIT AND SITDOC.DOC_MERCID = SITCOB.SIT_MERCID ' +
                    ' WHERE SIT_CODEMP = :CODEMP ' +
                    '   AND SIT_STATUS NOT IN("CON", "EST", "EXP", "NEG", "ABA", "CAN")) '
      else
        LstrSql :=  ' SELECT ' +
                    '   SITCOB.*, ' +
                    '   CAST("PD" AS CHAR(3)) AS ORIGEM ' +
                    ' FROM ' +
                    '   SITCOB ' +
                    ' WHERE SITCOB.SIT_CODEMP = :CODEMP ' +
                    '   AND SITCOB.SIT_STATUS NOT IN ("CON", "EST", "EXP", "NEG", "ABA", "CAN") ' +
                    '   AND SITDOC.DOC_TIPLAN IS NULL ' ;


      qrySitCob.Close;
      qrySitCob.SQL.Clear;
      qrySitCob.SQL.Text := LstrSql;
      qrySitCob.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qrySitCob.Open;

      if qrySitCob.RecordCount > 0 then
      begin

        qrySitCob.First;
        while not qrySitCob.Eof do
        begin
          objApiTransacao := nil;

          try
            objApiTransacao := fConsultarTransacao(qrySitCob.FieldByName('SIT_NUMNIT').AsString);
          except
            on E: Exception do
            begin
              qrySitCob.Next;
            end;
          end;

          if objApiTransacao <> nil then
          begin
            //atualizar transacao
            qryUpdate.Close;
            qryUpdate.SQL.Text :=
            ' UPDATE '+
            '   SITCOB '+
            ' SET '+
            '   SIT_STATUS = :STATUS, '+
            '   SIT_VIALOJ = :VIALOJ, '+
            '   SIT_VIACLI = :VIACLI, '+
            '   SIT_NUMCCD = :NUMCCD, '+
            '   SIT_TIPTRA = :TIPTRA, '+
            '   SIT_NUMNSU = :NUMNSU '+
            ' WHERE SIT_NUMNIT = :NUMNIT '+
            '   AND SIT_MERCID = :MERCID ';
            qryUpdate.ParamByName('STATUS').AsString := objApiTransacao.FPayment.FStatus;
            qryUpdate.ParamByName('VIALOJ').AsString := objApiTransacao.FPayment.FCustomer_receipt;
            qryUpdate.ParamByName('VIACLI').AsString := objApiTransacao.FPayment.FMerchant_receipt;
            qryUpdate.ParamByName('NUMCCD').AsString := objApiTransacao.FPayment.FAuthorization_number;
            qryUpdate.ParamByName('NUMNSU').AsString := objApiTransacao.FPayment.FEsitef_usn;
            qryUpdate.ParamByName('TIPTRA').AsString := objApiTransacao.FPayment.FPayment_type;
            qryUpdate.ParamByName('NUMNIT').AsString := qrySitCob.FieldByName('SIT_NUMNIT').AsString;
            qryUpdate.ParamByName('MERCID').AsString := strMerchantId;
            qryUpdate.ExecSQL;

            if (objApiTransacao.FPayment.FStatus = stTransacaoEfetuada) then
            begin
              strData := Copy(objApiTransacao.FPayment.FPayment_date, 1, 10);
              strHora := Copy(objApiTransacao.FPayment.FPayment_date, 12, 5);

              dtaDtaPag := fDataPagamento(strData);
              hraHraPag := fHoraPagamento(strHora);

              //concluir transacao
              qryUpdate.Close;
              qryUpdate.SQL.Text :=
              ' UPDATE '+
              '   SITCOB '+
              ' SET '+
              '   SIT_DTAPAG = :DTAPAG, '+
              '   SIT_HRAPAG = :HRAPAG, '+
              '   SIT_QTDPAR = :QTDPAR '+
              ' WHERE SIT_NUMNIT = :NUMNIT '+
              '   AND SIT_MERCID = :MERCID ';
              qryUpdate.ParamByName('DTAPAG').AsDate := dtaDtaPag;
              qryUpdate.ParamByName('HRAPAG').AsTime := hraHraPag;
              qryUpdate.ParamByName('QTDPAR').AsString := objApiTransacao.FPayment.FInstallments;
              qryUpdate.ParamByName('NUMNIT').AsString := qrySitCob.FieldByName('SIT_NUMNIT').AsString;
              qryUpdate.ParamByName('MERCID').AsString := strMerchantId;
              qryUpdate.ExecSQL;

              if qrySitCob.FieldByName('ORIGEM').AsString = 'PD' then
              begin
                LstrSql := ' SELECT '+
                           '   S.SIT_VALTRA, '+
                           '   S.SIT_DTAPAG, '+
                           '   F.FGO_NUMDOC, '+
                           '   F.FGO_ESPDOC, '+
                           '   F.FGO_CODEMP, '+
                           '   F.FGO_CODCLI, '+
                           '   F.FGO_CONPAG, '+
                           '   CT.CAR_CODCAR, '+
                           '   CT.CAR_DESCAR, '+
                           '   CT.CAR_TIPTAX, '+
                           '   CT.CAR_PERDES '+
                           ' FROM '+
                           '   SITCOB S '+
                           '   INNER JOIN EXTGOR EG '+
                           '     ON ( '+
                           '       S.SIT_NUMNIT = EG.FGO_SITNIT '+
                           '       AND S.SIT_MERCID = EG.FGO_SITMID '+
                           '     ) '+
                           '   INNER JOIN FATGOR F '+
                           '     ON (F.AUTOINCREM = EG.FGO_SEQFGO) '+
                           '   INNER JOIN CADCAR CT '+
                           '     ON '+
                           '     (SELECT '+
                           '       SIS_VALCFG '+
                           '     FROM '+
                           '       CFGSIS '+
                           '     WHERE SIS_CODCFG = "CFG_CARSIT" '+
                           '       AND F.FGO_CODEMP = SIS_CODEMP) = CT.CAR_CODCAR '+
                           ' WHERE S.SIT_NUMNIT = :NUMNIT '+
                           '   AND S.SIT_MERCID = :MERCID '+
                           ' LIMIT 1 ';
              end
              else // AGR - agrupamento de CTR
              begin
                LstrSql := ' SELECT DISTINCT ' +
                           '    S.SIT_VALTRA, ' +
                           '    S.SIT_DTAPAG, ' +
                           '    CTR.CTR_NUMDUP AS FGO_NUMDOC, ' +
                           '    CTR.CTR_ESPDOC AS FGO_ESPDOC, ' +
                           '    CTR.CTR_CODEMP AS FGO_CODEMP, ' +
                           '    CTR.CTR_CODCLI AS FGO_CODCLI, ' +
                           '    CND.CND_CNDPAG AS FGO_CONPAG, ' +
                           '    CT.CAR_CODCAR, ' +
                           '    CT.CAR_DESCAR, ' +
                           '    CT.CAR_TIPTAX, ' +
                           '    CT.CAR_PERDES ' +
                           '  FROM ' +
                           '    SITCOB S ' +
                           '    INNER JOIN SITDOC SD ON SD.DOC_NUMNIT = S.SIT_NUMNIT AND SD.DOC_MERCID = S.SIT_MERCID ' +
                           '    INNER JOIN CADREC CTR ON SD.DOC_NUMDOC = CTR.AUTOINCREM ' +
                           '    INNER JOIN CADCND CND ON CTR.CTR_CODCND = CND.CND_CODIGO ' +
                           '    INNER JOIN CADCAR CT ' +
                           '      ON ' +
                           '      (SELECT ' +
                           '        SIS_VALCFG ' +
                           '      FROM ' +
                           '        CFGSIS ' +
                           '      WHERE SIS_CODCFG = "CFG_CARSIT" ' +
                           '        AND CTR.CTR_CODEMP = SIS_CODEMP) = CT.CAR_CODCAR ' +
                           '  WHERE S.SIT_NUMNIT = :NUMNIT ' +
                           '    AND S.SIT_MERCID = :MERCID ' +
                           ' LIMIT 1 ' ;
              end;

              qryESiTef.Close;
              qryESiTef.SQL.Text := LstrSql ;
              qryESiTef.ParamByName('NUMNIT').AsString := qrySitCob.FieldByName('SIT_NUMNIT').AsString;
              qryESiTef.ParamByName('MERCID').AsString := strMerchantId;
              qryESiTef.Open;

              SetLength(arrCartoes, 1);
              intPosCar := 0;

              FillChar(arrCartoes[intPosCar], SizeOf(arrCartoes[intPosCar]), #0);

              arrCartoes[intPosCar].intCodSeq := intPosCar;
              arrCartoes[intPosCar].strCodCar := qryESiTef.FieldByName('CAR_CODCAR').AsString;
              arrCartoes[intPosCar].strDesCar := qryESiTef.FieldByName('CAR_DESCAR').AsString;
              arrCartoes[intPosCar].fltValDig := StrToFloat(objApiTransacao.FPayment.FAmount) / 100;
              arrCartoes[intPosCar].strCndPag := qryESiTef.FieldByName('FGO_CONPAG').AsString;
              arrCartoes[intPosCar].strObsCar := 'INTEGRAÇÃO ESITEF';
              arrCartoes[intPosCar].strNumCcd := objApiTransacao.FPayment.FAuthorization_number;

              arrCartoes[intPosCar].fltPerDes := IIF(qryESiTef.FieldByName('CAR_TIPTAX').AsString.ToUpper = 'P',
                                                       qryESiTef.FieldByName('CAR_PERDES').AsFloat,
                                                       (qryESiTef.FieldByName('CAR_PERDES').AsFloat /
                                                       (arrCartoes[intPosCar].fltValDig/StrToIntDef(Copy(qryESiTef.FieldByName('FGO_CONPAG').AsString,0,2),1)) * 100)
                                                     );

              arrCartoes[intPosCar].fltValDes := fCalculaValDocCartao(arrCartoes[intPosCar].fltValDig,
                                                                      arrCartoes[intPosCar].fltPerDes);

              arrCartoes[intPosCar].strCodFin := '';
              arrCartoes[intPosCar].strTipCar := 'SIT';
              arrCartoes[intPosCar].strNumNsu := objApiTransacao.FPayment.FEsitef_usn;
              arrCartoes[intPosCar].strConteudoArquivo := '';

              FillChar(recDadAdCar, SizeOf(recDadAdCar), #0);

              recDadAdCar.strNumDoc := qryESiTef.FieldByName('FGO_NUMDOC').AsString;
              recDadAdCar.strEspDoc := qryESiTef.FieldByName('FGO_ESPDOC').AsString;
              recDadAdCar.strCodEmp := qryESiTef.FieldByName('FGO_CODEMP').AsString;
              recDadAdCar.strCodCli := qryESiTef.FieldByName('FGO_CODCLI').AsString;
              recDadAdCar.dtaDtaCar := Vs_Date;
              recDadAdCar.dtaDtaCup := qryESiTef.FieldByName('SIT_DTAPAG').AsDateTime;
              recDadAdCar.fltTotVen := qryESiTef.FieldByName('SIT_VALTRA').AsFloat;
              recDadAdCar.fltTxDsGe := 0;
              recDadAdCar.fltTxDsPa := 0;
              recDadAdCar.strTxDsGe := '';
              recDadAdCar.strTxDsPa := '';
              recDadAdCar.intQtdPar := StrToInt(objApiTransacao.FPayment.FInstallments);

              fGravarCartoes(arrCartoes, recDadAdCar, LintSeqCon);

              if qrySitCob.FieldByName('ORIGEM').AsString = 'PD' then
              begin

                pGravarAdtCliCartao(qryESiTef.FieldByName('FGO_NUMDOC').AsString,
                                    qryESiTef.FieldByName('FGO_ESPDOC').AsString,
                                    qryESiTef.FieldByName('FGO_CODEMP').AsString,
                                    qryESiTef.FieldByName('FGO_CODCLI').AsString,
                                    objApiTransacao.FPayment.FPayment_type,
                                    StrToFloat(objApiTransacao.FPayment.FAmount) / 100,
                                    StrToInt(fRetRcxCon(qryESiTef.FieldByName('FGO_CODEMP').AsString)));

              end
              else  // AGR - agrupamento de CTR
              begin
                {$IFDEF LINUX}
                fRealizarBaixaDoContasAReceber(qrySitCob.FieldByName('SIT_NUMNIT').AsString,
                                               strMerchantId,
                                               objApiTransacao,
                                               LintSeqCon,
                                               dtaDtaPag) ;
                {$ENDIF LINUX}
              end;

            end;

          end;

          qrySitCob.Next;
        end;

        {$IFDEF LINUX}
        TTasklock.pZerarTentativasLock(Format(spIdPagtoOnlineESiTef, [VS_strCodEmp]));
        {$ENDIF LINUX}

        Sleep(1000);
      end;

    finally
      //FreeAndNil(qryAux);

      if Assigned(objApiTransacao) then
        objApiTransacao.Free;
    end;

    fCommit;
  except
    on E: Exception do
    begin
      fRollBack;
      pGravarErro(True, E.Message);
    end;
  end;
end;

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

function TController_Recebimento.fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray;
  recDadAdCar: TDadosAdicCartao; var AintSeqCon: Integer): Boolean;
  Var
    intCnt  : Integer;
    intCnt2 : Integer;
    intCnt3 : Integer;
    strNumDupCartao : String;
    strHisCar : String;
    arrDigDup: TArrDigDuplic;
    arrDigFat: TArrDigDuplic;
    arrDuplicata,
    arrDuplicFat : TArrDigDuplicArray;
    fltTotDig : Double;
    fltVlTxGe : Double;
    fltVlTxPc : Double;
    objArredondaParcela: untTypesSistema.IArredondaParcela;
    LTipoParcelamento: String;
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

        //strHisCar := 'REF. AO DOC. ESITEF: ' + recDadAdCar.strNumDoc;

        If fMovCarJaExiste(recDadAdCar.strCodCli,
                           arrDigDup.strSequen,
                           recDadAdCar.strCodEmp,
                           recDadAdCar.strNumDoc,
                           recDadAdCar.strEspDoc,
                           intCnt2) Then
          Raise Exception.Create('Documento já foi importado na MOVCAR');

        AintSeqCon := StrToInt(fRetRcxCon(recDadAdCar.strCodEmp)) ;
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
                                          strHisCar,
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
                                          recDadAdCar.dtaDtaCup);

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

procedure TController_Recebimento.pGravarAdtCliCartao(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strTipLan : String; fltValCar: Double; intSeqConRcx: Integer);
  Var
    documento: TDocAdiantamento;
    dadosAdiantamento: TDadosAdiantamento;
    totModalidades: TTotaisAdiantamento;
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
  dadosAdiantamento.strDescri := 'RECEBIMENTO VIA LINK DE PAGAMENTO ESITEF ADIANTAMENTO PEDIDO: ' + strNumDoc + '-' + strEspDoc;
  dadosAdiantamento.fltValDin := 0.00;
  dadosAdiantamento.fltValChV := 0.00;
  dadosAdiantamento.fltValChP := 0.00;
  dadosAdiantamento.fltValOrd := 0.00;
  dadosAdiantamento.fltValFin := 0.00;
  dadosAdiantamento.fltValCre := 0.00;
  dadosAdiantamento.fltValCar := fltValCar;
  dadosAdiantamento.fltValLan := fltValCar;

  TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);
end;

function TController_Recebimento.fMovCarJaExiste(strCodCli, strSequen, strCodEmp, strNumDoc,
  strEspDoc: String; intCnt2: Integer): Boolean;
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
      SQL.Add('      MCA_HIST01 = "INTEGRAÇÃO ESITEF" ');

      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('PARCEL').AsString := strSequen;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('DOCUME').AsString := fDocumeCar(strNumDoc, strEspDoc, strCodEmp, intCnt2);
      Open;

      Result := Not IsEmpty;
    End;

  Finally
    {$IFNDEF LINUX} FreeAndNil(qryMovCar); {$ENDIF LINUX}
  End;
end;

{$IFDEF LINUX}
function TController_Recebimento.fRealizarBaixaDoContasAReceber(
  const AstrNumNit, AstrMerCid: String; AobjApiTransacao : TRootClass;
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
   ' WHERE S.SIT_NUMNIT = "'+AstrNumNit+'" ' +
   '   AND S.SIT_MERCID = "'+AstrMerCid+'" ' ;


  LqryCadRec := fCriaQuery;
  LdictSeqLan := TDictionary<String, String>.Create();
  try
    LqryCadRec.Close ;
    LqryCadRec.SQL.Clear ;
    LqryCadRec.SQL.Add(LstrSql) ;
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

end.
