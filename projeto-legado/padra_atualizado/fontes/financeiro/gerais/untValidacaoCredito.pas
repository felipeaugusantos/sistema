unit untValidacaoCredito;

interface

uses
  Classes, DB, Uni, untfuncoesSimples, UniClientDataSet, DateUtils, untILiberacao, untMsgLiberacao,
  untFuncoesGenerica, SysUtils, Variants, StrUtils, untFuncoes, untLiberacaoFactory;

Type
  TDuplicatasCredito = record
    NumDup: string;
    Parcel: string;
    EspDoc: string;
    CodEmp: string;
    CodCli: string;
  end;

  TArrayDuplicatasCredito = array of TDuplicatasCredito;

  function fDuplicataCreditoLiberada(ADuplicatas: TArrayDuplicatasCredito): Boolean;
  function fChequeEstaDepositado(AstrCodigoBanco,
                                 AstrNumeroAgencia,
                                 AstrContaCorrente,
                                 AstrNumeroCheque,
                                 AstrCodigoEmpresa: String) : Boolean ;

  procedure pVerificaCadRec(ADocDev, AEspDev, ACodCli, AEmpDev: String; ADataDoc: TDateTime;
  AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao);

  procedure pCadRecCadChq(ADocDev, AEspDev, ACodCli, AEmpDev: String; ASeqCon, AEmpBai: String; ADataDoc: TDateTime;
  AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao; AQryReceber: TUniQuery);

  procedure pVerificaCadChq(ADocDev, AEspDev, ACodCli, AEmpDev: String; ASeqCon, AEmpBai: String; ADataDoc: TDateTime;
    AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao);

  procedure pIniciaLiberacao(var ACodCli: String; var ALiberacao : ILiberacao);

  procedure pCriaCabecalho(ADocDev, AEspDev, ACodCli, AEmpDev: String; ADataDoc: TDateTime;
    AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao; var ACria: Boolean);

implementation

function fDuplicataCreditoLiberada(ADuplicatas: TArrayDuplicatasCredito): Boolean;
var
  index: Integer;
  strCodCliente: String;
const
  SQL_MOVDET =
    ' SELECT ' +
    '   DET_CODCLI, ' +
    '   DET_DOCDEV, ' +
    '   DET_ESPDEV, ' +
    '   DET_SERIE_, ' +
    '   DET_EMPDEV, ' +
    '   GER_DTADOC, ' +
    '   GER_VLRCON, ' +
    '   DET_NUMDOC, ' +
    '   DET_ESPDOC, ' +
    '   DET_CODEMP  ' +
    ' FROM ' +
    '   MOVDET ' +
    ' JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER  ' +
    ' WHERE ' +
    '   DET_NUMDOC = :NUMDOC AND ' +
    '   DET_ESPDOC = :ESPDOC AND ' +
    '   DET_CODEMP = :CODEMP AND ' +
    '   DET_CODCLI = :CODCLI ';

  Var
    qryMovDet: TUniQuery;
    objLiberacao : ILiberacao;

begin
  Result := True;


  if fCfgSis('VERCRE', varBoolean) =  False then
    Exit;
 
  for index := 0 to Length(ADuplicatas)-1 do
  begin
    qryMovDet := fCriaQuery;
    qryMovDet.SQL.Text := SQL_MOVDET;
    qryMovDet.ParamByName('NUMDOC').AsString := ADuplicatas[index].NumDup;
    qryMovDet.ParamByName('ESPDOC').AsString := ADuplicatas[index].EspDoc;
    qryMovDet.ParamByName('CODEMP').AsString := ADuplicatas[index].CodEmp;
    qryMovDet.ParamByName('CODCLI').AsString := ADuplicatas[index].CodCli;
    qryMovDet.Open;

    While not qryMovDet.Eof do
    Begin
      pVerificaCadRec(
        qryMovDet.FieldByName('DET_DOCDEV').AsString,
        qryMovDet.FieldByName('DET_ESPDEV').AsString,
        qryMovDet.FieldByName('DET_CODCLI').AsString,
        qryMovDet.FieldByName('DET_EMPDEV').AsString,
        qryMovDet.FieldByName('GER_DTADOC').AsDateTime,
        qryMovDet.FieldByName('GER_VLRCON').AsFloat,
        ADuplicatas[index],
        objLiberacao);

      strCodCliente := qryMovDet.FieldByName('DET_CODCLI').AsString;

      qryMovDet.Next;
    End;

    FreeAndNil(qryMovDet);
  end;

  if Assigned(objLiberacao) then
  begin
    objLiberacao.strDirAce  := 'LIBRECCREDABE';
    objLiberacao.strMsgSen  := 'Utilização de Crédito Sem Identificação de Pagamento do Documento de Venda';
    objLiberacao.strCodOpe  := strLoginUsuarioLogado;
    objLiberacao.strCliente := strCodCliente;
    Result := objLiberacao.fLibera;
  end;
end;

function fChequeEstaDepositado(AstrCodigoBanco, AstrNumeroAgencia, AstrContaCorrente,
  AstrNumeroCheque, AstrCodigoEmpresa: String) : Boolean ;
Var
  SQuery : TUniQuery;
begin
  Result := False;
  SQuery := fCriaQuery;

  Try
    Try
      SQuery.SQL.Add(
        ' SELECT Q.CHQ_NUMCHQ '+
        '   FROM CADCHQ Q '+
        '  WHERE Q.CHQ_CODBCO = :CHQ_CODBCO '+
        '    AND Q.CHQ_NUMAGE = :CHQ_NUMAGE '+
        '    AND Q.CHQ_CONCOR = :CHQ_CONCOR '+
        '    AND Q.CHQ_NUMCHQ = :CHQ_NUMCHQ '+
        '    AND Q.CHQ_CODEMP = :CHQ_CODEMP '+
        '    AND Q.CHQ_DTAREP IS NULL '+
        '    AND (Q.CHQ_DTADEV IS NULL OR Q.CHQ_DTADV2 IS NULL) '+
        '    AND (NOT ((Q.CHQ_DTADEP IS NULL) OR ((Q.CHQ_DTADP2 IS NULL) AND (Q.CHQ_DTADEV IS NOT NULL)))) ');

      SQuery.ParamByName('CHQ_CODBCO').AsString := AstrCodigoBanco;
      SQuery.ParamByName('CHQ_NUMAGE').AsString := AstrNumeroAgencia;
      SQuery.ParamByName('CHQ_CONCOR').AsString := AstrContaCorrente;
      SQuery.ParamByName('CHQ_NUMCHQ').AsString := AstrNumeroCheque;
      SQuery.ParamByName('CHQ_CODEMP').AsString := AstrCodigoEmpresa;
      SQuery.Open;
      Result := not SQuery.IsEmpty;
      SQuery.Close;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(SQuery);
  End;

end;

procedure pVerificaCadRec(ADocDev, AEspDev, ACodCli, AEmpDev: String; ADataDoc: TDateTime;
  AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao);
const
    SQL_CADREC =
      ' SELECT ' +
      '   CTR_NUMDUP, ' +
      '   CTR_ESPDOC, ' +
      '   CTR_CODCLI, ' +
      '   CTR_CODEMP, ' +
      '   CTR_PARCEL, ' +
      '   CTR_VALDUP, ' +
      '   CTR_DTAVEN, ' +
      '   CTR_CHQPRE, ' +
      '   CTR_CHQAVI, ' +
      '   CTR_EMPBAI, ' +
      '   CTR_SEQCON  ' +
      ' FROM ' +
      '   CADREC ' +
      ' WHERE ' +
      '   CTR_NUMDUP = :NUMDOC AND  ' +
      '   CTR_ESPDOC = :ESPDOC AND  ' +
      '   CTR_CODCLI = :CODCLI AND  ' +
      '   CTR_CODEMP = :CODEMP AND  ' +
      '   CTR_VALDUP >= 0 ' ;

var
  qryCadRec: TUniquery;
  blnCriaCabecalho: Boolean;
begin
  qryCadRec := fCriaQuery;
  qryCadRec.SQL.Text := SQL_CADREC;

  qryCadRec.ParamByName('NUMDOC').AsString :=  ADocDev;
  qryCadRec.ParamByName('ESPDOC').AsString :=  AEspDev;
  qryCadRec.ParamByName('CODCLI').AsString :=  ACodCli;
  qryCadRec.ParamByName('CODEMP').AsString :=  AEmpDev;
  qryCadRec.Open;

  blnCriaCabecalho := True;
  While not qryCadRec.Eof do
  begin
    if qryCadRec.FieldByName('CTR_VALDUP').AsFloat > 0 then
    begin
      pIniciaLiberacao(ACodCli, ALiberacao);

      pCriaCabecalho(
        ADocDev,
        AEspDev,
        ACodCli,
        AEmpDev,
        ADataDoc,
        AValorDoc,
        ADuplicata,
        ALiberacao,
        blnCriaCabecalho);

       ALiberacao.objMsgLibera.pAddTexto(
          '     '+
          qryCadRec.FieldByName('CTR_NUMDUP').AsString+'-'+
          qryCadRec.FieldByName('CTR_PARCEL').AsString+'-'+
          qryCadRec.FieldByName('CTR_ESPDOC').AsString+'-'+
          qryCadRec.FieldByName('CTR_CODEMP').AsString+'   '+
          'Dt.Vencimento: '+
          FormatDateTime('dd/MM/yyyy', qryCadRec.FieldByName('CTR_DTAVEN').AsDateTime)+ '   '+
          FormatFloat('R$ #,###,##0.00', qryCadRec.FieldByName('CTR_VALDUP').AsFloat), alEsquerda, teAutcom, '', 110);
    end;

    qryCadRec.Next;
  end;

  qryCadRec.First;
  pCadRecCadChq(
        ADocDev,
        AEspDev,
        ACodCli,
        AEmpDev,
        qryCadRec.FieldByName('CTR_SEQCON').AsString,
        qryCadRec.FieldByName('CTR_EMPBAI').AsString,
        ADataDoc,
        AValorDoc,
        ADuplicata,
        ALiberacao,
        qryCadRec);

  FreeAndNil(qryCadRec);

  if Assigned(ALiberacao) then
  begin
    ALiberacao.objMsgLibera.pAddQuebra();
    ALiberacao.objMsgLibera.pAddSeparador(110);
  end;
end;

procedure pIniciaLiberacao(var ACodCli: String; var ALiberacao : ILiberacao);
begin
  if not Assigned(ALiberacao) then
  begin
    ALiberacao := TLiberacaoFactory.fGetLiberacao;
    ALiberacao.Clear;
    ALiberacao.objMsgLibera.pAddSeparador(110);
    ALiberacao.objMsgLibera.pAddTexto('UTILIZAÇÃO DE CRÉDITO SEM IDENTIFICAÇÃO DE PAGAMENTO DO DOCUMENTO DE VENDA', alCentro, teAutcom, '', 110);
    ALiberacao.objMsgLibera.pAddSeparador(110);
    ALiberacao.objMsgLibera.pAddTextoCaption('Cliente.: ', fRetNomCliente(ACodCli));
    ALiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ: ', fFormataCpfCgc(fRetCgcCpf(ACodCli), TPais.opcBrasil));
    ALiberacao.objMsgLibera.pAddSeparador(110);
    ALiberacao.objMsgLibera.pAddQuebra();
    ALiberacao.objMsgLibera.pAddTexto('Créditos que estão sendo utilizados:', alEsquerda, teAutcom, '', 110);
  end;
end;

procedure pVerificaCadChq(ADocDev, AEspDev, ACodCli, AEmpDev: String; ASeqCon, AEmpBai: String; ADataDoc: TDateTime;
    AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao);
const
  SQL_CADCHQ =
    ' SELECT ' +
    '   CHQ_CODBCO, ' +
    '   CHQ_NUMAGE, ' +
    '   CHQ_CONCOR, ' +
    '   CHQ_NOMEMI, ' +
    '   CHQ_DTAVEN, ' +
    '   CHQ_VALCHQ, ' +
    '   CHQ_NUMCHQ, ' +
    '   CHQ_CODEMP  ' +
    ' FROM          ' +
    '  CADCHQ       ' +
    ' WHERE  ' +
    '   CHQ_SEQCON = :CHQCON AND ' +
    '   CHQ_CODEMP = :CODEMP ';

var
  qryCadChq: TUniQuery;
  blnCriaCabecalho: Boolean;
begin
  blnCriaCabecalho := True;

  qryCadChq := fCriaQuery;
  qryCadChq.SQL.Text := SQL_CADCHQ;

  qryCadChq.ParamByName('CHQCON').AsString :=  ASeqCon;
  qryCadChq.ParamByName('CODEMP').AsString :=  AEmpBai;

  qryCadChq.Open;

  while not qryCadChq.Eof do
  begin
    if fChequeEstaDepositado(qryCadChq.FieldByName('CHQ_CODBCO').AsString,
                             qryCadChq.FieldByName('CHQ_NUMAGE').AsString,
                             qryCadChq.FieldByName('CHQ_CONCOR').AsString,
                             qryCadChq.FieldByName('CHQ_NUMCHQ').AsString,
                             qryCadChq.FieldByName('CHQ_CODEMP').AsString) then
    begin
      qryCadChq.Next;

      Continue;
    end;

    pIniciaLiberacao(ACodCli, ALiberacao);

    pCriaCabecalho(
        ADocDev,
        AEspDev,
        ACodCli,
        AEmpDev,
        ADataDoc,
        AValorDoc,
        ADuplicata,
        ALiberacao,
        blnCriaCabecalho);

    ALiberacao.objMsgLibera.pAddTexto(
      '     '+
      'Ch: ' + qryCadChq.FieldByName('CHQ_NUMCHQ').AsString + ' - ' +
      'Agência: ' + qryCadChq.FieldByName('CHQ_NUMAGE').AsString + ' - ' +
      'Emitente: ' + fPadR(qryCadChq.FieldByName('CHQ_NOMEMI').AsString, 27, ' ') + '   ' +
      'Dt.Vencimento: ' + FormatDateTime('dd/MM/yyyy', qryCadChq.FieldByName('CHQ_DTAVEN').AsDateTime)  + '   ' +
      FormatFloat('R$ #,###,##0.00', qryCadChq.FieldByName('CHQ_VALCHQ').AsFloat), alEsquerda, teAutcom, '', 110);

    qryCadChq.Next;
  end;

  FreeAndNil(qryCadChq);
end;

procedure pCriaCabecalho(ADocDev, AEspDev, ACodCli, AEmpDev: String; ADataDoc: TDateTime;
    AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao; var ACria: Boolean);
begin
  if (ACria) then
  begin
    ALiberacao.objMsgLibera.pAddQuebra();
    ALiberacao.objMsgLibera.pAddTexto(
    ADuplicata.NumDup+'-'+
    ADuplicata.Parcel+'-'+
    ADuplicata.EspDoc+'-'+
    ADuplicata.CodEmp+'   '+
    'Doc.Venda: ' +
    ADocDev+'-'+
    AEspDev+'-'+
    AEmpDev+'   '+
    'Dt.Cad.: ' +
    FormatDateTime('dd/MM/yyyy', ADataDoc) +'   ' +
    FormatFloat('R$ #,###,##0.00', AValorDoc), alEsquerda, teAutcom, '', 110);

    ALiberacao.objMsgLibera.pAddTexto('Cheques Em Aberto/Devolvidos ou Documento de Origem do Crédito em Aberto:', alDireita, teAutcom, '', 78);

    ACria := False;
  end;
end;

procedure pCadRecCadChq(ADocDev, AEspDev, ACodCli, AEmpDev: String; ASeqCon, AEmpBai: String; ADataDoc: TDateTime;
  AValorDoc: Currency; ADuplicata: TDuplicatasCredito; var ALiberacao : ILiberacao; AQryReceber: TUniQuery);
begin
  While not AQryReceber.Eof do
  begin
    if AQryReceber.FieldByName('CTR_VALDUP').AsFloat = 0 then
    begin
      if AQryReceber.FieldByName('CTR_CHQPRE').AsFloat = 0  then
      begin
        if AQryReceber.FieldByName('CTR_CHQAVI').AsFloat = 0  then
        begin
          AQryReceber.Next;

          Continue;
        end;
      end;

      pVerificaCadChq(
        ADocDev,
        AEspDev,
        ACodCli,
        AEmpDev,
        AQryReceber.FieldByName('CTR_SEQCON').AsString,
        AQryReceber.FieldByName('CTR_EMPBAI').AsString,
        ADataDoc,
        AValorDoc,
        ADuplicata,
        ALiberacao);

    end;

    AQryReceber.Next;
  end;
end;

end.
