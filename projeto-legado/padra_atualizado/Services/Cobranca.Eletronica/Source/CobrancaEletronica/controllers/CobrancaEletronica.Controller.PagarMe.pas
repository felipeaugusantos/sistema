unit CobrancaEletronica.Controller.PagarMe;

interface

uses
  Generics.Collections, Rest.Json, sysUtils,
  System.JSON, strUtils, REST.Types,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  untGravaMovCar,
  Data.DB, MemDS, DBAccess, Uni, PagarMe.Service.LinkPagamento,
  CobrancaEletronica.Lib.Types, PagarMe.Classe.Transacao,
  PagarMe.Service.Recebivel, untTypesSistema, PagarMe.Classe.LinkPagamento;

type
  TControllerPagarMe = class
  private
    function fRetornInformacoesDocumento(const strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strApi: String): String;

    function fMovCarJaExiste(strCodCli, strSequen, strCodEmp, strNumDoc,
    strEspDoc: String; intCnt2: Integer): Boolean;

    procedure pGravarAdtCli(strNumDoc, strEspDoc, strCodEmp, strCodCli,
      strTipLan, strFormaCobranca: String; fltValLan, fltValJur: Double;
      intSeqConRcx: Integer);

    procedure pGravarCartoes(const ANumDoc, AEspDoc, ACodEmp: String;
      const ATransacao: TTransacaoPagarMe);

    function fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray;
        recDadAdCar: TDadosAdicCartao): Boolean;

    procedure pGravarCobrancaEletronica(const AQryDados: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
      const AUrl, AJsonEnvio, AJsonRetorno, ALinkPagamento,
      ACodigoCobranca: String; const ADataEnvio, ADataRetorno: TDateTime);

    procedure pCalcularValoresCartoes(const recDadAdCar: TDadosAdicCartao;
      out fltVlTxGe: Double; out fltVlTxPc: Double; out fltTotDig: Double);

    function fRetornaCndPagPeriod(const intQtdPar, intPeriod, intExcDia: Integer): String;

    procedure pGravarLinkGerado(
      const AQryDados: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
      const AService: TLinkPagamentoServicePagarMe;
      const ALink: TLinkPagamentoPagarMe);

  public
    class function New: TControllerPagarMe;

    function fProcessarPedidosCancelados: TControllerPagarMe;
    function fProcessarLinksCancelados: TControllerPagarMe;
    function fProcessarGerarNovosLinksPagamento: TControllerPagarMe;
    function fProcessarLinksPagamentoExpirados: TControllerPagarMe;
    function fProcessarFormaCobrancaLinks: TControllerPagarMe;
    function fProcessarPagamentoLinks: TControllerPagarMe;

  end;

implementation

uses
  CobrancaEletronica.Classe,
  untAdiantamentoClienteGenerico, untArredondaParcelaImpl, System.DateUtils,
  PagarMe.Lib.Dicionario;

{ TControllerPagarMe }

procedure TControllerPagarMe.pCalcularValoresCartoes(
  const recDadAdCar: TDadosAdicCartao; out fltVlTxGe: Double;
  out fltVlTxPc: Double; out fltTotDig: Double);
begin
  If (fFormataFloat(recDadAdCar.fltTxDsGe, 2) > 0) Then
  Begin
    case AnsiIndexStr(recDadAdCar.strTxDsGe, ['V','P']) of
      0 : fltVlTxGe := recDadAdCar.fltTxDsGe;
      1 : fltVlTxGe := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsGe / 100 ) ), 2);
    end;

    fltTotDig := fltTotDig - fltVlTxGe;
    fltVlTxGe := fFormataFloat(fltVlTxGe / recDadAdCar.intQtdPar, 2);
  End;

  If (fFormataFloat(recDadAdCar.fltTxDsPa, 2) > 0) Then
  Begin
    case AnsiIndexStr(recDadAdCar.strTxDsPa, ['V','P']) of
      0 : fltVlTxPc := (recDadAdCar.fltTxDsPa * recDadAdCar.intQtdPar);
      1 : fltVlTxPc := fFormataFloat(( fltTotDig * ( recDadAdCar.fltTxDsPa / 100 ) ), 2);
    end;

    fltTotDig := fltTotDig - fltVlTxPc;
    fltVlTxPc := fFormataFloat(fltVlTxPc / recDadAdCar.intQtdPar, 2);
  End;
end;

function TControllerPagarMe.fGravarCartoes(arrCartoes: TCartoesResumoCaixaArray;
  recDadAdCar: TDadosAdicCartao): Boolean;
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
  objArredondaParcela: IArredondaParcela;
begin
  Result := True;

  Try

    For intCnt := 0 To Length(arrCartoes) -1 Do
    Begin
      If (Not Result) Then
        Break;

      objArredondaParcela := TArredondaParcelaPagarMe.fNew;

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

        pCalcularValoresCartoes(recDadAdCar, fltVlTxGe, fltVlTxPc, fltTotDig);

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

        strHisCar := 'REF. AO DOC. PAGARME: ' + recDadAdCar.strNumDoc;

        If fMovCarJaExiste(recDadAdCar.strCodCli,
                           arrDigDup.strSequen,
                           recDadAdCar.strCodEmp,
                           recDadAdCar.strNumDoc,
                           recDadAdCar.strEspDoc,
                           intCnt2) Then
          Raise Exception.Create('Documento já foi importado na MOVCAR');

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
                                          StrToInt(fRetRcxCon(recDadAdCar.strCodEmp)),
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

function TControllerPagarMe.fMovCarJaExiste(strCodCli, strSequen, strCodEmp,
  strNumDoc, strEspDoc: String; intCnt2: Integer): Boolean;
var
  qryMovCar: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryMovCar := fCriaQuery;

  Try
    qryMovCar.SQL.Text := 'SELECT AUTOINCREM '
                        + '  FROM MOVCAR '
                        + ' WHERE MCA_CODCLI = :CODCLI '
                        + '   AND MCA_PARCEL = :PARCEL '
                        + '   AND MCA_CODEMP = :CODEMP '
                        + '   AND MCA_DOCUME = :DOCUME '
                        + '   AND MCA_HIST01 = "INTEGRAÇÃO '+API_PAGARME+'" ';

    qryMovCar.ParamByName('CODCLI').AsString := strCodCli;
    qryMovCar.ParamByName('PARCEL').AsString := strSequen;
    qryMovCar.ParamByName('CODEMP').AsString := strCodEmp;
    qryMovCar.ParamByName('DOCUME').AsString := fDocumeCar(strNumDoc, strEspDoc, strCodEmp, intCnt2);
    qryMovCar.Open;

    Result := Not qryMovCar.IsEmpty;
  Finally
    {$IFNDEF LINUX}
    qryMovCar.Free;
    {$ENDIF LINUX}
  End;
end;

function TControllerPagarMe.fProcessarGerarNovosLinksPagamento: TControllerPagarMe;
var
  LQryDados       : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LService        : TLinkPagamentoServicePagarMe;
  LLink           : TLinkPagamentoPagarMe;
  LItem           : TItems;

  LPhoneFormat,
  LDocumentFormat : String;
  LDocument       : TDocuments;
  LTipoAtendimento: String;
begin
  Result := Self;

  LLink := nil;
  try
    LQryDados  := fCriaQuery;
    LService   := TLinkPagamentoServicePagarMe.Create;
    try
      LTipoAtendimento := fCfgSis('PMETPA');

      LQryDados.Close;
      LQryDados.SQL.Clear;
      LQryDados.SQL.Text := 'SELECT '
                          + '       FATGOR.AUTOINCREM '
                          + '     , FATGOR.FGO_NUMDOC '
                          + '     , FATGOR.FGO_ESPDOC '
                          + '     , FATGOR.FGO_CODCLI '
                          + '     , FATGOR.FGO_CODEMP '
                          + '     , FATGOR.FGO_VLRCON '
                          + '     , FATGOR.FGO_CODCND '
                          + '     , CADEMP.EMP_NOMEMP '
                          + '     , CADCLI.CLI_NOMCLI '
                          + '     , CADCLI.CLI_C_G_C_ '
                          + '     , CADCLI.CLI_ENDERE '
                          + '     , CADCLI.CLI_ENDNUM '
                          + '     , CADCID.CID_NOMCID '
                          + '     , CADCID.CID_ESTADO '
                          + '     , CADCLI.CLI_BAIRRO '
                          + '     , CADCLI.CLI_C_E_P_ '
                          + '     , CADCLI.CLI_CELULA '
                          + '     , CADCLI.CLI_FONE01 '
                          + '     , CADCLI.CLI_NASCIM '
                          + '     , CADCLI.CLI_EMAIL_ '
                          + '     , CADCND.CND_PMEDVC '
                          + '     , CADCND.CND_PMEQPA '
                          + '     , CADCND.CND_PMEQPJ '
                          + '     , CADCND.CND_PMEJCT '
                          + '  FROM FATGOR '
                          + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = FATGOR.FGO_CODEMP '
                          + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                          + ' INNER JOIN CADCLI ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI '
                          + ' INNER JOIN CADCID ON CADCID.CID_CODCID = CADCLI.CLI_CODCID '
                          + ' INNER JOIN CADCND ON CADCND.CND_CODIGO = FATGOR.FGO_CODCND '
                          + ' WHERE FATGOR.FGO_CODEMP = :CODEMP '
                          + '   AND FATGOR.FGO_ESPDOC = "PD" '
                          + '   AND IFNULL(FATGOR.FGO_VLRCON,0) > 0 '
                          + '   AND FATGOR.FGO_LIBERA = 0 '
                          + '   AND EXTGOR.FGO_TIPREC = "'+API_PAGARME+'" '
                          + '   AND FATGOR.FGO_MOTBAI IS NULL ';

      if (Not fEmptyStr(LTipoAtendimento)) then
      begin
        LQryDados.SQL.Text := LQryDados.SQL.Text
                            + '   AND IFNULL(EXTGOR.FGO_CODTPA,"") <> :CODTPA ';

        LQryDados.ParamByName('CODTPA').AsString := LTipoAtendimento;
      end;

      LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryDados.Open;

      LQryDados.First;
      while not LQryDados.Eof do
      begin
        if Assigned(LLink) then
          FreeAndNil(LLink);

        LLink := TLinkPagamentoPagarMe.Create;
        LLink.amount := Trunc(LQryDados.FieldByName('FGO_VLRCON').AsFloat*100);

        LItem           := TItems.Create;
        LItem.id        := LQryDados.FieldByName('AUTOINCREM').AsString;
        LItem.title     := 'PEDIDO REALIZADO NA EMPRESA '+LQryDados.FieldByName('EMP_NOMEMP').AsString;
        LItem.UnitPrice := LLink.amount;
        LItem.Quantity  := 1;
        LItem.Tangible  := False;
        LLink.items.Add(LItem);

        LLink.PaymentConfig.Boleto.Enabled     := StrToIntDef(LQryDados.FieldByName('CND_PMEDVC').AsString,0) > 0;
        LLink.PaymentConfig.CreditCard.enabled := not (LQryDados.FieldByName('CND_PMEQPA').AsString.IsEmpty);

        LLink.PaymentConfig.Boleto.ExpiresIn        := 1;
        LLink.PaymentConfig.CreditCard.InterestRate := 0.01;

        if (LLink.PaymentConfig.Boleto.Enabled) then
        begin
          LLink.PaymentConfig.DefaultPaymentMethod := FC_BOLETO;
          LLink.PaymentConfig.Boleto.ExpiresIn     := StrToIntDef(LQryDados.FieldByName('CND_PMEDVC').AsString,0);
        end;

        if (LLink.PaymentConfig.CreditCard.enabled) then
        begin
          LLink.PaymentConfig.DefaultPaymentMethod        := FC_CARTAO_CREDITO;
          LLink.PaymentConfig.CreditCard.MaxInstallments  := StrToIntDef(TDicionarioPagarMe.GetInstance.ParcelasCartao.fValor(LQryDados.FieldByName('CND_PMEQPA').AsString),0);
          LLink.PaymentConfig.CreditCard.FreeInstallments := StrToIntDef(TDicionarioPagarMe.GetInstance.ParcelasSemJurosCartao.fValor(LQryDados.FieldByName('CND_PMEQPJ').AsString),0);

          if LQryDados.FieldByName('CND_PMEJCT').AsFloat > 0 then
            LLink.PaymentConfig.CreditCard.InterestRate     := LQryDados.FieldByName('CND_PMEJCT').AsFloat;
        end;

        LLink.CustomerConfig.Customer.Name       := LQryDados.FieldByName('CLI_NOMCLI').AsString;
        LLink.CustomerConfig.Customer.ExternalId := LQryDados.FieldByName('FGO_CODCLI').AsString;
        LLink.CustomerConfig.Customer.Email      := LQryDados.FieldByName('CLI_EMAIL_').AsString.Replace(';','',[rfReplaceAll]);
        LLink.CustomerConfig.Customer.Country    := 'br';

        LLink.CustomerConfig.Customer.Birthday   := DateToISO8601(LQryDados.FieldByName('CLI_NASCIM').AsDate);

        LDocumentFormat := LQryDados.FieldByName('CLI_C_G_C_').AsString;
        LDocumentFormat := LDocumentFormat
                             .Replace('.','',[rfReplaceAll])
                             .Replace('/','',[rfReplaceAll])
                             .Replace('-','',[rfReplaceAll]);

        LLink.CustomerConfig.Customer.Documents.Add(TDocuments.Create);
        LDocument        := LLink.CustomerConfig.Customer.Documents.Items[0];
        LDocument.Number := LDocumentFormat;

        LDocument.&Type                     := 'CNPJ';
        LLink.CustomerConfig.Customer.&Type := 'corporation';

        if LDocumentFormat.Trim.Length = 11 then
        begin
          LDocument.&Type                     := 'CPF';
          LLink.CustomerConfig.Customer.&Type := 'individual';
        end;

        LPhoneFormat := LQryDados.FieldByName('CLI_CELULA').AsString;
        LPhoneFormat := LPhoneFormat
                          .Replace('(','',[rfReplaceAll])
                          .Replace(')','',[rfReplaceAll])
                          .Replace('-','',[rfReplaceAll])
                          .Replace(' ','',[rfReplaceAll])
                          .Replace('.','',[rfReplaceAll]);

        if LPhoneFormat.Trim.Length > 0 then
          LLink.CustomerConfig.Customer.PhoneNumbers.Add(LPhoneFormat);

        LPhoneFormat := LQryDados.FieldByName('CLI_FONE01').AsString;
        LPhoneFormat := LPhoneFormat
                          .Replace('(','',[rfReplaceAll])
                          .Replace(')','',[rfReplaceAll])
                          .Replace('-','',[rfReplaceAll])
                          .Replace(' ','',[rfReplaceAll])
                          .Replace('.','',[rfReplaceAll]);

        if LPhoneFormat.Trim.Length > 0 then
          LLink.CustomerConfig.Customer.PhoneNumbers.Add(LPhoneFormat);

        LLink.CustomerConfig.Billing.Name                 := LQryDados.FieldByName('CLI_NOMCLI').AsString;
        LLink.CustomerConfig.Billing.Address.City         := LQryDados.FieldByName('CID_NOMCID').AsString;
        LLink.CustomerConfig.Billing.Address.Country      := 'br';
        LLink.CustomerConfig.Billing.Address.Neighborhood := LQryDados.FieldByName('CLI_BAIRRO').AsString;
        LLink.CustomerConfig.Billing.Address.State        := LQryDados.FieldByName('CID_ESTADO').AsString;
        LLink.CustomerConfig.Billing.Address.Street       := LQryDados.FieldByName('CLI_ENDERE').AsString;
        LLink.CustomerConfig.Billing.Address.StreetNumber := LQryDados.FieldByName('CLI_ENDNUM').AsString;
        LLink.CustomerConfig.Billing.Address.Zipcode      := LQryDados.FieldByName('CLI_C_E_P_').AsString;

        LLink.MaxOrders := 1;
        LLink.ExpiresIn := StrToIntDef(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_PMEEXL']),1)*60;

        LService.SeqFgo := LQryDados.FieldByName('AUTOINCREM').AsString;

        pGravarLinkGerado(LQryDados, LService, LLink);

        LQryDados.Next;

        {$IFDEF LINUX}
        TTasklock.pZerarTentativasLock(Format(SP_COBRANCA_ELETRONICA, [VS_strCodEmp]));
        {$ENDIF LINUX}

        Sleep(1000);
      end;
    finally
      if Assigned(LLink) then
        FreeAndNil(LLink);

      if Assigned(LService) then
        FreeAndNil(LService);

      {$IFNDEF LINUX}
      LQryDados.Free;
      {$ENDIF LINUX}
    end;
  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message, API_PAGARME);
    end;
  end;
end;

function TControllerPagarMe.fProcessarLinksCancelados: TControllerPagarMe;
var
  LQryDados,
  LQryDelete      : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LService        : TLinkPagamentoServicePagarMe;
  LCodigoCobranca : String;
begin
  Result := Self;

  try
    LQryDados  := fCriaQuery;
    LQryDelete := fCriaQuery;
    LService   := TLinkPagamentoServicePagarMe.Create;
    try
      LQryDados.Close;
      LQryDados.SQL.Clear;
      LQryDados.SQL.Text := 'SELECT '
                          + '       FATGOR.AUTOINCREM '
                          + '     , FATGOR.FGO_NUMDOC '
                          + '     , FATGOR.FGO_ESPDOC '
                          + '     , FATGOR.FGO_CODCLI '
                          + '     , FATGOR.FGO_CODEMP '
                          + '     , FATGOR.FGO_VLRCON '
                          + '     , FATGOR.FGO_CODCND '
                          + '     , CADEMP.EMP_NOMEMP '
                          + '     , COBELT.CBE_CODCOB '
                          + '  FROM FATGOR '
                          + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = FATGOR.FGO_CODEMP '
                          + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                          + ' INNER JOIN COBELT ON COBELT.CBE_NUMDOC = FATGOR.FGO_NUMDOC '
                          + '                  AND COBELT.CBE_ESPDOC = FATGOR.FGO_ESPDOC '
                          + '                  AND COBELT.CBE_CODEMP = FATGOR.FGO_CODEMP '
                          + ' WHERE FATGOR.FGO_CODEMP = :CODEMP '
                          + '   AND COBELT.CBE_APICOB = "'+API_PAGARME_CANCELADA+'" ';

      LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryDados.Open;

      if LQryDados.RecordCount > 0 then
      begin
        LQryDados.First;
        while not LQryDados.Eof do
        begin
          fStartTransaction();
          try
            LCodigoCobranca := LQryDados.FieldByName('CBE_CODCOB').AsString;

            LQryDelete.Close;
            LQryDelete.SQL.Text := 'DELETE FROM COBELT '
                                 + ' WHERE CBE_NUMDOC = :NUMDOC '
                                 + '   AND CBE_ESPDOC = :ESPDOC '
                                 + '   AND CBE_CODEMP = :CODEMP '
                                 + '   AND CBE_APICOB = "'+API_PAGARME_CANCELADA+'" ';

            LQryDelete.ParamByName('NUMDOC').AsString := LQryDados.FieldByName('FGO_NUMDOC').AsString;
            LQryDelete.ParamByName('ESPDOC').AsString := LQryDados.FieldByName('FGO_ESPDOC').AsString;
            LQryDelete.ParamByName('CODEMP').AsString := LQryDados.FieldByName('FGO_CODEMP').AsString;
            LQryDelete.ExecSQL;

            LService.SeqFgo := LQryDados.FieldByName('AUTOINCREM').AsString;
            LService.fCancelarLink(LCodigoCobranca);

            fCommit();
          except
            on E: Exception do
            begin
              fRollback();

              pGravarErro(True, E.Message,
                fRetornInformacoesDocumento(LQryDados.FieldByName('FGO_NUMDOC').AsString,
                                            LQryDados.FieldByName('FGO_ESPDOC').AsString,
                                            LQryDados.FieldByName('FGO_CODEMP').AsString,
                                            LQryDados.FieldByName('FGO_CODCLI').AsString,
                                            API_PAGARME));
            end;
          end;

          LQryDados.Next;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(SP_COBRANCA_ELETRONICA, [VS_strCodEmp]));
          {$ENDIF LINUX}

          Sleep(1000);
        end;
      end;
    finally
      if Assigned(LService) then
        FreeAndNil(LService);

      {$IFNDEF LINUX}
      LQryDados.Free;
      LQryDelete.Free;
      {$ENDIF LINUX}
    end;
  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message, API_PAGARME);
    end;
  end;
end;

function TControllerPagarMe.fProcessarLinksPagamentoExpirados: TControllerPagarMe;
var
  LQryDados,
  LQryUpdate            : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LServiceLinkPagamento : TLinkPagamentoServicePagarMe;
  LTransacao            : TTransacaoPagarMe;
begin
  Result := Self;

  try
    LQryDados             := fCriaQuery;
    LQryUpdate            := fCriaQuery;
    LServiceLinkPagamento := TLinkPagamentoServicePagarMe.Create;
    try
      LQryDados.Close;
      LQryDados.SQL.Clear;
      LQryDados.SQL.Text := 'SELECT '
                          + '       FATGOR.AUTOINCREM '
                          + '     , FATGOR.FGO_NUMDOC '
                          + '     , FATGOR.FGO_ESPDOC '
                          + '     , FATGOR.FGO_CODEMP '
                          + '     , FATGOR.FGO_CODCLI '
                          + '     , COBELT.CBE_CODCOB '
                          + '  FROM FATGOR '
                          + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                          + ' INNER JOIN COBELT ON COBELT.CBE_NUMDOC = FATGOR.FGO_NUMDOC '
                          + '                  AND COBELT.CBE_ESPDOC = FATGOR.FGO_ESPDOC '
                          + '                  AND COBELT.CBE_CODEMP = FATGOR.FGO_CODEMP '
                          + ' WHERE FATGOR.FGO_CODEMP = :CODEMP '
                          + '   AND FATGOR.FGO_ESPDOC = "PD" '
                          + '   AND FATGOR.FGO_LIBERA = 0 '
                          + '   AND EXTGOR.FGO_TIPREC = "'+API_PAGARME_ENVIADA+'" '
                          + '   AND IFNULL(COBELT.CBE_LNKPAG,"") <> "" '
                          + '   AND IFNULL(COBELT.CBE_TIPCOB,"") = "" '
                          + '   AND FATGOR.FGO_MOTBAI IS NULL ';

      LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryDados.Open;

      if LQryDados.RecordCount > 0 then
      begin
        LQryDados.First;
        while not LQryDados.Eof do
        begin
          LTransacao := nil;
          try
            if LServiceLinkPagamento.fCobrancaExpirada(LQryDados.FieldByName('CBE_CODCOB').AsString) then
            begin
              if LServiceLinkPagamento.Response.StatusCode <> 200 then
                raise Exception.Create(LServiceLinkPagamento.Response.Content);

              fStartTransaction();
              try
                LQryUpdate.Close;
                LQryUpdate.SQL.Text := 'UPDATE EXTGOR '
                                     + '   SET FGO_TIPREC = "'+API_PAGARME_EXPIRADO+'"'
                                     + ' WHERE FGO_SEQFGO = :SEQFGO ';

                LQryUpdate.ParamByName('SEQFGO').AsString := LQryDados.FieldByName('AUTOINCREM').AsString;
                LQryUpdate.ExecSQL;

                LQryUpdate.Close;
                LQryUpdate.SQL.Text := 'UPDATE COBELT '
                                     + '   SET CBE_STATRA = :STATRA '
                                     + ' WHERE CBE_NUMDOC = :NUMDOC '
                                     + '   AND CBE_ESPDOC = :ESPDOC '
                                     + '   AND CBE_CODEMP = :CODEMP ';

                LQryUpdate.ParamByName('NUMDOC').AsString   := LQryDados.FieldByName('FGO_NUMDOC').AsString;
                LQryUpdate.ParamByName('ESPDOC').AsString   := LQryDados.FieldByName('FGO_ESPDOC').AsString;
                LQryUpdate.ParamByName('CODEMP').AsString   := LQryDados.FieldByName('FGO_CODEMP').AsString;

                LQryUpdate.ParamByName('STATRA').AsString   := 'expired_link';
                LQryUpdate.ExecSQL;

                fCommit();
              except
                on E: Exception do
                begin
                  fRollback();

                  pGravarErro(True, E.Message,
                    fRetornInformacoesDocumento(LQryDados.FieldByName('FGO_NUMDOC').AsString,
                                                LQryDados.FieldByName('FGO_ESPDOC').AsString,
                                                LQryDados.FieldByName('FGO_CODEMP').AsString,
                                                LQryDados.FieldByName('FGO_CODCLI').AsString,
                                                API_PAGARME));
                end;
              end;
            end;
          finally
            if Assigned(LTransacao) then
              FreeAndNil(LTransacao);
          end;

          LQryDados.Next;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(SP_COBRANCA_ELETRONICA, [VS_strCodEmp]));
          {$ENDIF LINUX}

          Sleep(1000);
        end;
      end;
    finally
      if Assigned(LServiceLinkPagamento) then
        FreeAndNil(LServiceLinkPagamento);

      {$IFNDEF LINUX}
      LQryDados.Free;
      LQryUpdate.Free;
      {$ENDIF LINUX}
    end;
  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message, API_PAGARME);
    end;
  end;
end;

function TControllerPagarMe.fProcessarFormaCobrancaLinks: TControllerPagarMe;
var
  LQryDados,
  LQryUpdate     : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LServiceOrder  : TRecebivelServicePagarMe;
  LTransacao     : TTransacaoPagarMe;
begin
  Result := Self;

  try
    LQryDados     := fCriaQuery;
    LQryUpdate    := fCriaQuery;
    LServiceOrder := TRecebivelServicePagarMe.Create;
    try
      LQryDados.Close;
      LQryDados.SQL.Clear;
      LQryDados.SQL.Text := 'SELECT '
                          + '       FATGOR.AUTOINCREM '
                          + '     , FATGOR.FGO_NUMDOC '
                          + '     , FATGOR.FGO_ESPDOC '
                          + '     , FATGOR.FGO_CODEMP '
                          + '     , FATGOR.FGO_CODCLI '
                          + '     , FATGOR.FGO_VLRCON '
                          + '     , FATGOR.FGO_CODCND '
                          + '     , COBELT.CBE_CODCOB '
                          + '     , CADEMP.EMP_NOMEMP '
                          + '  FROM FATGOR '
                          + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = FATGOR.FGO_CODEMP '
                          + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                          + ' INNER JOIN COBELT ON COBELT.CBE_NUMDOC = FATGOR.FGO_NUMDOC '
                          + '                  AND COBELT.CBE_ESPDOC = FATGOR.FGO_ESPDOC '
                          + '                  AND COBELT.CBE_CODEMP = FATGOR.FGO_CODEMP '
                          + ' WHERE FATGOR.FGO_CODEMP = :CODEMP '
                          + '   AND FATGOR.FGO_ESPDOC = "PD" '
                          + '   AND FATGOR.FGO_LIBERA = 0 '
                          + '   AND EXTGOR.FGO_TIPREC = "'+API_PAGARME_ENVIADA+'" '
                          + '   AND FATGOR.FGO_MOTBAI IS NULL ';

      LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryDados.Open;

      if LQryDados.RecordCount > 0 then
      begin
        LQryDados.First;
        while not LQryDados.Eof do
        begin
          LTransacao := nil;
          try
            if LServiceOrder.fCobrancaSemFormaDePagamento(LQryDados.FieldByName('CBE_CODCOB').AsString, LTransacao) then
            begin
              if LServiceOrder.Response.StatusCode <> 200 then
                raise Exception.Create(LServiceOrder.Response.Content);

              fStartTransaction();
              try
                LQryUpdate.Close;
                LQryUpdate.SQL.Text := 'UPDATE EXTGOR '
                                     + '   SET FGO_TIPREC = "'+API_PAGARME_COM_TRANSACAO+'"'
                                     + ' WHERE FGO_SEQFGO = :SEQFGO ';

                LQryUpdate.ParamByName('SEQFGO').AsString := LQryDados.FieldByName('AUTOINCREM').AsString;
                LQryUpdate.ExecSQL;

                LQryUpdate.Close;
                LQryUpdate.SQL.Text := 'UPDATE COBELT '
                                     + '   SET CBE_STATRA = :STATRA '
                                     + '     , CBE_CODTRA = :CODTRA '
                                     + '     , CBE_DTATRA = :DTATRA '
                                     + '     , CBE_VLRTRA = :VLRTRA '
                                     + '     , CBE_TIPCOB = :TIPCOB '
                                     + ' WHERE CBE_NUMDOC = :NUMDOC '
                                     + '   AND CBE_ESPDOC = :ESPDOC '
                                     + '   AND CBE_CODEMP = :CODEMP ';

                LQryUpdate.ParamByName('NUMDOC').AsString   := LQryDados.FieldByName('FGO_NUMDOC').AsString;
                LQryUpdate.ParamByName('ESPDOC').AsString   := LQryDados.FieldByName('FGO_ESPDOC').AsString;
                LQryUpdate.ParamByName('CODEMP').AsString   := LQryDados.FieldByName('FGO_CODEMP').AsString;

                LQryUpdate.ParamByName('STATRA').AsString   := LTransacao.Status;
                LQryUpdate.ParamByName('CODTRA').AsString   := LTransacao.Id;
                LQryUpdate.ParamByName('DTATRA').AsDateTime := ISO8601ToDate(LTransacao.DateCreated);
                LQryUpdate.ParamByName('VLRTRA').AsFloat    := LTransacao.AuthorizedAmount/100;
                LQryUpdate.ParamByName('TIPCOB').AsString   := LTransacao.PaymentMethod;
                LQryUpdate.ExecSQL;

                fCommit();
              except
                on E: Exception do
                begin
                  fRollback();

                  pGravarErro(True, E.Message,
                    fRetornInformacoesDocumento(LQryDados.FieldByName('FGO_NUMDOC').AsString,
                                                LQryDados.FieldByName('FGO_ESPDOC').AsString,
                                                LQryDados.FieldByName('FGO_CODEMP').AsString,
                                                LQryDados.FieldByName('FGO_CODCLI').AsString,
                                                API_PAGARME));
                end;
              end;
            end;
          finally
            if Assigned(LTransacao) then
              FreeAndNil(LTransacao);
          end;

          LQryDados.Next;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(SP_COBRANCA_ELETRONICA, [VS_strCodEmp]));
          {$ENDIF LINUX}

          Sleep(1000);
        end;
      end;
    finally
      if Assigned(LServiceOrder) then
        FreeAndNil(LServiceOrder);

      {$IFNDEF LINUX}
      LQryDados.Free;
      LQryUpdate.Free;
      {$ENDIF LINUX}
    end;
  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message, API_PAGARME);
    end;
  end;
end;

function TControllerPagarMe.fProcessarPagamentoLinks: TControllerPagarMe;
var
  LQryDados,
  LQryUpdate     : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LServiceOrder  : TRecebivelServicePagarMe;
  LTransacao     : TTransacaoPagarMe;
  LValorJuros    : Double;
  LRejeitaBaixa  : Boolean;
begin
  Result := Self;

  try
    LQryDados     := fCriaQuery;
    LQryUpdate    := fCriaQuery;
    LServiceOrder := TRecebivelServicePagarMe.Create;
    try
      LQryDados.Close;
      LQryDados.SQL.Clear;
      LQryDados.SQL.Text := 'SELECT '
                          + '       FATGOR.AUTOINCREM '
                          + '     , FATGOR.FGO_NUMDOC '
                          + '     , FATGOR.FGO_ESPDOC '
                          + '     , FATGOR.FGO_CODEMP '
                          + '     , FATGOR.FGO_CODCLI '
                          + '     , FATGOR.FGO_VLRCON '
                          + '     , FATGOR.FGO_CODCND '
                          + '     , COBELT.CBE_CODCOB '
                          + '     , COBELT.CBE_CODTRA '
                          + '     , COBELT.CBE_VLRTRA '
                          + '     , CADEMP.EMP_NOMEMP '
                          + '  FROM FATGOR '
                          + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = FATGOR.FGO_CODEMP '
                          + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                          + ' INNER JOIN COBELT ON COBELT.CBE_NUMDOC = FATGOR.FGO_NUMDOC '
                          + '                  AND COBELT.CBE_ESPDOC = FATGOR.FGO_ESPDOC '
                          + '                  AND COBELT.CBE_CODEMP = FATGOR.FGO_CODEMP '
                          + ' WHERE FATGOR.FGO_CODEMP = :CODEMP '
                          + '   AND FATGOR.FGO_ESPDOC = "PD" '
                          + '   AND FATGOR.FGO_LIBERA = 0 '
                          + '   AND EXTGOR.FGO_TIPREC = "'+API_PAGARME_COM_TRANSACAO+'" '
                          + '   AND FATGOR.FGO_MOTBAI IS NULL ';

      LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryDados.Open;

      if LQryDados.RecordCount > 0 then
      begin
        LQryDados.First;
        while not LQryDados.Eof do
        begin
          LRejeitaBaixa := False;
          LTransacao := nil;
          try
            if LServiceOrder.fRetornaTransacao(LQryDados.FieldByName('CBE_CODTRA').AsString, LTransacao) then
            begin
              if (fCfgSis('PMEAMB') = '1') and
                 (not MatchStr(LTransacao.Status.ToUpper, [PME_STATUS_BAIXADO,
                                                           PME_STATUS_AUTORIZADA])) then
              begin
                LRejeitaBaixa := True
              end
              else if (fCfgSis('PMEAMB') = '0') and
                      (not MatchStr(LTransacao.Status.ToUpper, [PME_STATUS_BAIXADO,
                                                                PME_STATUS_AUTORIZADA,
                                                                PME_STATUS_RECUSADO,
                                                                PME_STATUS_ESTORNADO])) then
              begin
                LRejeitaBaixa := True;
              end;

              if LRejeitaBaixa then
              begin
                LQryDados.Next;
                Continue;
              end;

              if LServiceOrder.Response.StatusCode <> 200 then
                raise Exception.Create(LServiceOrder.Response.Content);

              fStartTransaction();
              try
                LQryUpdate.Close;
                LQryUpdate.SQL.Text := 'UPDATE EXTGOR '
                                     + '   SET FGO_TIPREC = "'+API_PAGARME_COM_PAGAMENTO+'"'
                                     + ' WHERE FGO_SEQFGO = :SEQFGO ';

                LQryUpdate.ParamByName('SEQFGO').AsString := LQryDados.FieldByName('AUTOINCREM').AsString;
                LQryUpdate.ExecSQL;

                LQryUpdate.Close;
                LQryUpdate.SQL.Text := 'UPDATE FATGOR '
                                     + '   SET FGO_LIBERA = 1 '
                                     + '     , FGO_LIBCOM = 1 '
                                     + '     , FGO_OPELIB = "999" '
                                     + '     , FGO_DIGLIB = "999" '
                                     + '     , FGO_DTALIB = :DTALIB '
                                     + '     , FGO_HORLIB = :HORLIB '
                                     + '     , FGO_OBSL01 = :OBSL01 '
                                     + '     , FGO_NUMPOK = :NUMPOK '
                                     + ' WHERE AUTOINCREM = :AUTOIN ';

                LQryUpdate.ParamByName('AUTOIN').AsString := LQryDados.FieldByName('AUTOINCREM').AsString;

                LQryUpdate.ParamByName('DTALIB').AsDate   := Date;
                LQryUpdate.ParamByName('HORLIB').AsTime   := Time;
                LQryUpdate.ParamByName('OBSL01').AsString := 'LIBERAÇÃO AUTOMÁTICA PAGAR.ME';
                LQryUpdate.ParamByName('NUMPOK').AsString := API_PAGARME+'-'+LTransacao.AuthorizationCode;
                LQryUpdate.ExecSQL;

                LQryUpdate.Close;
                LQryUpdate.SQL.Text := 'UPDATE COBELT '
                                     + '   SET CBE_STATRA = :STATRA '
                                     + ' WHERE CBE_NUMDOC = :NUMDOC '
                                     + '   AND CBE_ESPDOC = :ESPDOC '
                                     + '   AND CBE_CODEMP = :CODEMP ';

                LQryUpdate.ParamByName('NUMDOC').AsString   := LQryDados.FieldByName('FGO_NUMDOC').AsString;
                LQryUpdate.ParamByName('ESPDOC').AsString   := LQryDados.FieldByName('FGO_ESPDOC').AsString;
                LQryUpdate.ParamByName('CODEMP').AsString   := LQryDados.FieldByName('FGO_CODEMP').AsString;

                LQryUpdate.ParamByName('STATRA').AsString   := LTransacao.Status;
                LQryUpdate.ExecSQL;

                if LTransacao.PaymentMethod = FC_CARTAO_CREDITO then
                begin
                  pGravarCartoes(LQryDados.FieldByName('FGO_NUMDOC').AsString,
                                                       'PD',
                                                        LQryDados.FieldByName('FGO_CODEMP').AsString,
                                                        LTransacao);
                end;

                LValorJuros := LQryDados.FieldByName('CBE_VLRTRA').AsFloat
                             - LQryDados.FieldByName('FGO_VLRCON').AsFloat;

                pGravarAdtCli(LQryDados.FieldByName('FGO_NUMDOC').AsString,
                              LQryDados.FieldByName('FGO_ESPDOC').AsString,
                              LQryDados.FieldByName('FGO_CODEMP').AsString,
                              LQryDados.FieldByName('FGO_CODCLI').AsString,
                              'C',
                              LTransacao.PaymentMethod,
                              LQryDados.FieldByName('FGO_VLRCON').AsFloat,
                              LValorJuros,
                              StrToInt(fRetRcxCon(LQryDados.FieldByName('FGO_CODEMP').AsString)));

                fCommit();
              except
                on E: Exception do
                begin
                  fRollback();

                  pGravarErro(True, E.Message,
                    fRetornInformacoesDocumento(LQryDados.FieldByName('FGO_NUMDOC').AsString,
                                                LQryDados.FieldByName('FGO_ESPDOC').AsString,
                                                LQryDados.FieldByName('FGO_CODEMP').AsString,
                                                LQryDados.FieldByName('FGO_CODCLI').AsString,
                                                API_PAGARME));
                end;
              end;
            end;

            LQryDados.Next;

            {$IFDEF LINUX}
            TTasklock.pZerarTentativasLock(Format(SP_COBRANCA_ELETRONICA, [VS_strCodEmp]));
            {$ENDIF LINUX}
          finally
            if Assigned(LTransacao) then
              FreeAndNil(LTransacao);
          end;

          Sleep(1000);
        end;
      end;
    finally
      if Assigned(LServiceOrder) then
        FreeAndNil(LServiceOrder);

      {$IFNDEF LINUX}
      LQryDados.Free;
      LQryUpdate.Free;
      {$ENDIF LINUX}
    end;
  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message, API_PAGARME);
    end;
  end;
end;

function TControllerPagarMe.fProcessarPedidosCancelados: TControllerPagarMe;
var
  LQryDados,
  LQryUpdate : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LService   : TLinkPagamentoServicePagarMe;
begin
  Result := Self;

  try
    LQryDados  := fCriaQuery;
    LQryUpdate := fCriaQuery;
    LService   := TLinkPagamentoServicePagarMe.Create;
    try
      LQryDados.Close;
      LQryDados.SQL.Clear;
      LQryDados.SQL.Text := 'SELECT '
                          + '       DEL_FATGOR.AUTOINCREM '
                          + '     , DEL_FATGOR.FGO_NUMDOC '
                          + '     , DEL_FATGOR.FGO_ESPDOC '
                          + '     , DEL_FATGOR.FGO_CODCLI '
                          + '     , DEL_FATGOR.FGO_CODEMP '
                          + '     , DEL_FATGOR.FGO_VLRCON '
                          + '     , DEL_FATGOR.FGO_CODCND '
                          + '     , CADEMP.EMP_NOMEMP '
                          + '     , COBELT.CBE_CODCOB '
                          + '  FROM DEL_FATGOR '
                          + ' INNER JOIN CADEMP     ON CADEMP.EMP_CODEMP     = DEL_FATGOR.FGO_CODEMP '
                          + ' INNER JOIN DEL_EXTGOR ON DEL_EXTGOR.FGO_SEQFGO = DEL_FATGOR.AUTOINCREM '
                          + ' INNER JOIN COBELT     ON COBELT.CBE_NUMDOC     = DEL_FATGOR.FGO_NUMDOC '
                          + '                      AND COBELT.CBE_ESPDOC     = DEL_FATGOR.FGO_ESPDOC '
                          + '                      AND COBELT.CBE_CODEMP     = DEL_FATGOR.FGO_CODEMP '
                          + ' WHERE DEL_FATGOR.FGO_CODEMP = :CODEMP '
                          + '   AND DEL_EXTGOR.FGO_TIPREC = "'+API_PAGARME_ENVIADA+'" ';

      LQryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQryDados.Open;

      if LQryDados.RecordCount > 0 then
      begin
        LQryDados.First;
        while not LQryDados.Eof do
        begin
          fStartTransaction();
          try
            LQryUpdate.Close;
            LQryUpdate.SQL.Text := 'UPDATE DEL_EXTGOR '
                                 + '   SET FGO_TIPREC = "'+API_PAGARME_CANCELADA+'"'
                                 + ' WHERE FGO_SEQFGO = :SEQFGO ';

            LQryUpdate.ParamByName('SEQFGO').AsString := LQryDados.FieldByName('AUTOINCREM').AsString;
            LQryUpdate.ExecSQL;

            LService.SeqFgo := LQryDados.FieldByName('AUTOINCREM').AsString;
            LService.fCancelarLink(LQryDados.FieldByName('CBE_CODCOB').AsString);

            fCommit();
          except
            on E: Exception do
            begin
              fRollback();

              pGravarErro(True, E.Message,
                fRetornInformacoesDocumento(LQryDados.FieldByName('FGO_NUMDOC').AsString,
                                            LQryDados.FieldByName('FGO_ESPDOC').AsString,
                                            LQryDados.FieldByName('FGO_CODEMP').AsString,
                                            LQryDados.FieldByName('FGO_CODCLI').AsString,
                                            API_PAGARME));
            end;
          end;

          LQryDados.Next;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(SP_COBRANCA_ELETRONICA, [VS_strCodEmp]));
          {$ENDIF LINUX}

          Sleep(1000);
        end;
      end;
    finally
      if Assigned(LService) then
        FreeAndNil(LService);

      {$IFNDEF LINUX}
      LQryDados.Free;
      LQryUpdate.Free;
      {$ENDIF LINUX}
    end;
  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message, API_PAGARME);
    end;
  end;
end;

function TControllerPagarMe.fRetornaCndPagPeriod(const intQtdPar, intPeriod,
  intExcDia: Integer): String;
Var
  intContador: Integer;
  intPeriodTmp: Integer;
begin

  Result := fStrZero(IntToStr(intQtdPar), 2);
  intPeriodTmp := intPeriod + intExcDia;

  For intContador := 1 To intQtdPar Do
  Begin
    Result := Result + fStrZero(IntToStr(intPeriodTmp), 3);
    Inc(intPeriodTmp, intPeriod);
  End;
end;

function TControllerPagarMe.fRetornInformacoesDocumento(const strNumDoc,
  strEspDoc, strCodEmp, strCodCli, strApi: String): String;
begin
  Result := Format('Número Documento: %s'+#13#10+
                   'Tipo Documento -: %s'+#13#10+
                   'Código Empresa -: %s'+#13#10+
                   'Código Cliente -: %s'+#13#10+
                   'API ------------: %s',
                   [strNumDoc, strEspDoc, strCodEmp, strCodCli, strApi]);
end;

class function TControllerPagarMe.New: TControllerPagarMe;
begin
  Result := Self.Create;
end;

procedure TControllerPagarMe.pGravarAdtCli(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strTipLan, strFormaCobranca: String;
  fltValLan, fltValJur: Double; intSeqConRcx: Integer);
Var
  documento: TDocAdiantamento;
  dadosAdiantamento: TDadosAdiantamento;
  totModalidades: TTotaisAdiantamento;
begin
  FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);
  FillChar(totModalidades, SizeOf(totModalidades), #0);

  If fltValJur < 0 then
    fltValJur := 0;

  documento.strNumDoc := strNumDoc;
  documento.strEspDoc := strEspDoc;
  documento.strCodEmp := strCodEmp;
  documento.strCodCli := strCodCli;
  documento.fltValLan := fltValLan;

  dadosAdiantamento.AddDocumento(documento);

  dadosAdiantamento.strTipLan := strTipLan;
  dadosAdiantamento.dtaDtaLan := VS_Date;
  dadosAdiantamento.horHorLan := Time;
  dadosAdiantamento.strOpeLan := '999';
  dadosAdiantamento.strEmpLan := strCodEmp;
  dadosAdiantamento.intSeqCon := intSeqConRcx;
  dadosAdiantamento.strDescri := 'RECEBIMENTO VIA LINK DE PAGAMENTO PAGAR.ME ADIANTAMENTO PEDIDO: ' + strNumDoc + '-' + strEspDoc;
  dadosAdiantamento.fltValDin := 0.00;
  dadosAdiantamento.fltValChV := 0.00;
  dadosAdiantamento.fltValChP := 0.00;
  dadosAdiantamento.fltValOrd := 0.00;
  dadosAdiantamento.fltValFin := 0.00;
  dadosAdiantamento.fltValCre := 0.00;
  dadosAdiantamento.fltValCar := 0.00;
  dadosAdiantamento.fltValJur := fltValJur;

  if strFormaCobranca = FC_CARTAO_CREDITO then
    dadosAdiantamento.fltValCar := fltValLan
  else
  if strFormaCobranca = FC_BOLETO then
    dadosAdiantamento.fltValDin := fltValLan;

  dadosAdiantamento.fltValLan := fltValLan;

  TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);
end;

procedure TControllerPagarMe.pGravarCartoes(const ANumDoc, AEspDoc,
  ACodEmp: String; const ATransacao: TTransacaoPagarMe);
var
  LQryDados   : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  arrCartoes  : TCartoesResumoCaixaArray;
  intPosCar   : Integer;
  recDadAdCar : TDadosAdicCartao;
begin
  LQryDados := fCriaQuery;
  try
    LQryDados.Close;
    LQryDados.SQL.Text := 'SELECT '
                        + '       FATGOR.AUTOINCREM '
                        + '     , FATGOR.FGO_NUMDOC '
                        + '     , FATGOR.FGO_ESPDOC '
                        + '     , FATGOR.FGO_CODEMP '
                        + '     , FATGOR.FGO_CODCLI '
                        + '     , FATGOR.FGO_VLRCON '
                        + '     , FATGOR.FGO_CODCND '
                        + '     , FATGOR.FGO_CONPAG '
                        + '     , EXTGOR.FGO_TIPREC '
                        + '     , COBELT.CBE_CODCOB '
                        + '     , COBELT.CBE_JSOENV '
                        + '     , CADEMP.EMP_NOMEMP '
                        + '     , CADCAR.CAR_CODCAR '
                        + '     , CADCAR.CAR_DESCAR '
                        + '     , CADCAR.CAR_TIPTAX '
                        + '     , CADCAR.CAR_PERDES '
                        + '     , CADCAR.CAR_PERDES '
                        + '  FROM FATGOR '
                        + ' INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = FATGOR.FGO_CODEMP '
                        + ' INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '
                        + ' INNER JOIN COBELT ON COBELT.CBE_NUMDOC = FATGOR.FGO_NUMDOC '
                        + '                  AND COBELT.CBE_ESPDOC = FATGOR.FGO_ESPDOC '
                        + '                  AND COBELT.CBE_CODEMP = FATGOR.FGO_CODEMP '
                        + ' INNER JOIN CADCAR ON CADCAR.CAR_CODCAR = (SELECT '
                        + '                                                  SIS_VALCFG '
                        + '                                             FROM CFGSIS '
                        + '                                            WHERE SIS_CODCFG = "CFG_PMECAR" '
                        + '                                              AND SIS_CODEMP = FATGOR.FGO_CODEMP) '

                        + ' WHERE FATGOR.FGO_CODEMP = :CODEMP '
                        + '   AND FATGOR.FGO_NUMDOC = :NUMDOC '
                        + '   AND FATGOR.FGO_ESPDOC = :ESPDOC ';

    LQryDados.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryDados.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryDados.ParamByName('CODEMP').AsString := ACodEmp;
    LQryDados.Open;

    SetLength(arrCartoes, 1);
    intPosCar := 0;

    FillChar(arrCartoes[intPosCar], SizeOf(arrCartoes[intPosCar]), #0);

    arrCartoes[intPosCar].intCodSeq := intPosCar;
    arrCartoes[intPosCar].strCodCar := LQryDados.FieldByName('CAR_CODCAR').AsString;
    arrCartoes[intPosCar].strDesCar := LQryDados.FieldByName('CAR_DESCAR').AsString;
    arrCartoes[intPosCar].fltValDig := ATransacao.PaidAmount/100;
    arrCartoes[intPosCar].strCndPag := fRetornaCndPagPeriod(ATransacao.Installments,
                                                            fCfgSis('PMEPRC'),
                                                            0);
    arrCartoes[intPosCar].strObsCar := 'INTEGRAÇÃO '+API_PAGARME;
    arrCartoes[intPosCar].strNumCcd := '';

    arrCartoes[intPosCar].fltPerDes := IIF(LQryDados.FieldByName('CAR_TIPTAX').AsString = 'P',
                                             LQryDados.FieldByName('CAR_PERDES').AsFloat,
                                             (LQryDados.FieldByName('CAR_PERDES').AsFloat /
                                             (arrCartoes[intPosCar].fltValDig/StrToIntDef(Copy(LQryDados.FieldByName('FGO_CONPAG').AsString,0,2),1)) * 100)
                                           );

    arrCartoes[intPosCar].fltValDes := fCalculaValDocCartao(arrCartoes[intPosCar].fltValDig,
                                                            arrCartoes[intPosCar].fltPerDes);

    arrCartoes[intPosCar].strCodFin := '';
    arrCartoes[intPosCar].strTipCar := 'PME';
    arrCartoes[intPosCar].strNumNsu := '';
    arrCartoes[intPosCar].strConteudoArquivo := '';

    FillChar(recDadAdCar, SizeOf(recDadAdCar), #0);

    recDadAdCar.strNumDoc := LQryDados.FieldByName('FGO_NUMDOC').AsString;
    recDadAdCar.strEspDoc := 'PD';
    recDadAdCar.strCodEmp := LQryDados.FieldByName('FGO_CODEMP').AsString;
    recDadAdCar.strCodCli := LQryDados.FieldByName('FGO_CODCLI').AsString;
    recDadAdCar.dtaDtaCar := Vs_Date;
    recDadAdCar.dtaDtaCup := ISO8601ToDate(ATransacao.Card.DateCreated);
    recDadAdCar.fltTotVen := ATransacao.PaidAmount/100;
    recDadAdCar.fltTxDsGe := 0;
    recDadAdCar.fltTxDsPa := 0;
    recDadAdCar.strTxDsGe := '';
    recDadAdCar.strTxDsPa := '';
    recDadAdCar.intQtdPar := ATransacao.Installments;

    fGravarCartoes(arrCartoes, recDadAdCar);
  finally
    {$IFNDEF LINUX}
    LQryDados.Free;
    {$ENDIF LINUX}
  end;
end;

procedure TControllerPagarMe.pGravarCobrancaEletronica(
  const AQryDados: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  const AUrl, AJsonEnvio, AJsonRetorno, ALinkPagamento,
      ACodigoCobranca: String; const ADataEnvio, ADataRetorno: TDateTime);
var
  LCobrancaEletronica : TCobrancaEletronica;
begin
  LCobrancaEletronica := TCobrancaEletronica.Create;
  try
    LCobrancaEletronica.strNumDoc := AQryDados.FieldByName('FGO_NUMDOC').AsString;
    LCobrancaEletronica.strEspDoc := AQryDados.FieldByName('FGO_ESPDOC').AsString;
    LCobrancaEletronica.strUrlReq := AUrl;
    LCobrancaEletronica.dtaDtaEnv := ADataEnvio;
    LCobrancaEletronica.strJsoEnv := AJsonEnvio;
    LCobrancaEletronica.strResRet := AJsonRetorno;
    LCobrancaEletronica.dtaDtaRet := ADataRetorno;
    LCobrancaEletronica.strLnkPag := ALinkPagamento;
    LCobrancaEletronica.intStaCod := 200;
    LCobrancaEletronica.strCodCli := AQryDados.FieldByName('FGO_CODCLI').AsString;
    LCobrancaEletronica.fltTotGer := AQryDados.FieldByName('FGO_VLRCON').AsFloat;
    LCobrancaEletronica.strMetEnv := 'POST';
    LCobrancaEletronica.strCodCob := ACodigoCobranca;
    LCobrancaEletronica.strApiCob := API_PAGARME;
    LCobrancaEletronica.pGravar;
  finally
    LCobrancaEletronica.Free;
  end;
end;

procedure TControllerPagarMe.pGravarLinkGerado(const AQryDados: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  const AService: TLinkPagamentoServicePagarMe;
  const ALink: TLinkPagamentoPagarMe);
var
  LQryUpdate      : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LDataEnvio      : TDateTime;
  LDataRetorno    : TDateTime;
  LUrl            : String;
  LCodigoCobranca : String;
  LUrlRequisicao  : String;
  LJsonRetorno    : String;
begin
  LDataEnvio := Now;
  if AService.fCriarLink(ALink.AsJson, LCodigoCobranca, LUrl, LUrlRequisicao, LJsonRetorno) then
  begin
    fStartTransaction();
    LQryUpdate := fCriaQuery;
    try
      try
        LDataRetorno := Now;

        pGravarCobrancaEletronica(
            AQryDados,
            LUrlRequisicao,
            ALink.AsJson,
            LJsonRetorno,
            LUrl,
            LCodigoCobranca,
            LDataEnvio,
            LDataRetorno);

        if AService.Response.StatusCode = 200 then
        begin
          LQryUpdate.Close;
          LQryUpdate.SQL.Text := 'UPDATE EXTGOR '
                               + '   SET FGO_TIPREC = "'+API_PAGARME_ENVIADA+'"'
                               + ' WHERE FGO_SEQFGO = :SEQFGO ';

          LQryUpdate.ParamByName('SEQFGO').AsString := AQryDados.FieldByName('AUTOINCREM').AsString;
          LQryUpdate.ExecSQL;
        end;

        fCommit();
      except
        on E: Exception do
        begin
          fRollback();

          AService.fCancelarLink(LCodigoCobranca);

          pGravarErro(True, E.Message,
            fRetornInformacoesDocumento(AQryDados.FieldByName('FGO_NUMDOC').AsString,
                                        AQryDados.FieldByName('FGO_ESPDOC').AsString,
                                        AQryDados.FieldByName('FGO_CODEMP').AsString,
                                        AQryDados.FieldByName('FGO_CODCLI').AsString,
                                        API_PAGARME));
        end;
      end;
    finally
      {$IFNDEF LINUX}
      LQryUpdate.Free;
      {$ENDIF LINUX}
    end;
  end;
end;

end.
