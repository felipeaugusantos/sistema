unit untLinkPagamentoCitelModel;

interface

Uses
  Uni, System.SysUtils, Classes, untInterfaceLinkPagamentoCitel;

type
  TLinkPagamentoCitelModel = class
    public
      class function fNovaTransacao(strCodEmp, strUrlPgt, strNumNit, strNumNsu,
        strCodOpe : String; dtaDtaCad : TDate; hraHraCad : TTime;
        strMercId : String; fltValTra : Double; strSeqFgo : String; strEnvJso,
        strResJso : String; intQtdParcelas : Integer; strTipLan,
        strAutoIncs: String; dtaExpiracao: TDateTime) : Boolean;

      class function fEstornaTrasacao(const AstrNumNit, AstrEnvCn1, AstrResCn1,
        AstrEnvCn2, AstrResCn2, AstrNitEst, AstrNsuEst, AstrCplEst, AstrCpcEst, AstrOrigem: String): Boolean;

      class function fDesvinculaPedido(const AstrNumDoc, AstrEspDoc, AstrCodEmp, AstrCodCli, AstrOrigem, AstrNumNit: String; const AblnAtualizaStatus: Boolean = True): Boolean ;

      class procedure pRemoveTransacao(strNumNit, strMercId, strCodEmp : String);

      // AstrStatusAtual: so altera se o status ainda for este; vazio = sem condicao
      class procedure pAtualizaStatus(const strNumNit, strMercId, strCodEmp, strStatus : String; const AstrStatusAtual: String = '');

      class procedure pAtualizaFormaEnvio(const AstrNumNit, AstrMercId, AstrFormaEnvio : String);

      class function fStringAutoIncsToList(const AstrIncDocs: String): TStringList ;
  end;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  strUtils, untLinkPagamentoCitelStatus, untFactoryLinkPagamentoCitel;

{ TLinkPagamentoCitelModel }

class function TLinkPagamentoCitelModel.fDesvinculaPedido(const AstrNumDoc, AstrEspDoc,
  AstrCodEmp, AstrCodCli, AstrOrigem, AstrNumNit: String; const AblnAtualizaStatus: Boolean = True): Boolean;
var
  LqryDesvinc : TUniQuery;
  LstrAutoIncs : String;
begin
  Result := True ;
  LqryDesvinc := fCriaQuery;
  try
    try

      if AblnAtualizaStatus then
      begin
        LqryDesvinc.Close ;
        LqryDesvinc.SQL.Clear ;
        LqryDesvinc.SQL.Add(' UPDATE SITCOB SET SIT_STATUS = :STATUS ') ;
        LqryDesvinc.SQL.Add(' WHERE SIT_CODEMP = :CODEMP ') ;
        LqryDesvinc.SQL.Add(' AND SIT_NUMNIT = :NUMNIT ; ') ;
        LqryDesvinc.ParamByName('CODEMP').AsString := AstrCodEmp ;
        LqryDesvinc.ParamByName('NUMNIT').AsString := AstrNumNit ;
        LqryDesvinc.ParamByName('STATUS').AsString := stTransacaoDesvinculadaDocumento ;
        LqryDesvinc.ExecSQL;
      end ;

      if AstrOrigem = 'PD' then
      begin
        LqryDesvinc.Close ;
        LqryDesvinc.SQL.Clear ;
        LqryDesvinc.SQL.Add(' UPDATE EXTGOR INNER JOIN FATGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ') ;
        LqryDesvinc.SQL.Add(' SET FGO_TIPREC = NULL ') ;
        LqryDesvinc.SQL.Add(' WHERE FATGOR.FGO_NUMDOC =  :NUMDOC ') ;
        LqryDesvinc.SQL.Add('    AND FATGOR.FGO_ESPDOC = :ESPDOC ') ;
        LqryDesvinc.SQL.Add('    AND FATGOR.FGO_CODEMP = :CODEMP ') ;
        LqryDesvinc.SQL.Add('    AND FATGOR.FGO_CODCLI = :CODCLI; ') ;
        LqryDesvinc.ParamByName('NUMDOC').AsString := AstrNumDoc ;
        LqryDesvinc.ParamByName('ESPDOC').AsString := AstrEspDoc ;
        LqryDesvinc.ParamByName('CODEMP').AsString := AstrCodEmp ;
        LqryDesvinc.ParamByName('CODCLI').AsString := AstrCodCli ;
        LqryDesvinc.ExecSQL;
      end
      else if AstrOrigem = 'AGR' then
      begin
        //recupera os autoincs para desvincular
        LqryDesvinc.Close ;
        LqryDesvinc.SQL.Clear ;
        LqryDesvinc.SQL.Add(' SELECT AUTOINCREM FROM CADREC ') ;
        LqryDesvinc.SQL.Add('         WHERE CTR_NUMDUP = :NUMDUP ') ;
        LqryDesvinc.SQL.Add('       AND CTR_ESPDOC = :ESPDOC ') ;
        LqryDesvinc.SQL.Add('       AND CTR_CODCLI = :CODCLI ') ;
        LqryDesvinc.SQL.Add('       AND CTR_CODEMP = :CODEMP ') ;
        LqryDesvinc.ParamByName('NUMDUP').AsString := AstrNumDoc ;
        LqryDesvinc.ParamByName('ESPDOC').AsString := AstrEspDoc ;
        LqryDesvinc.ParamByName('CODEMP').AsString := AstrCodEmp ;
        LqryDesvinc.ParamByName('CODCLI').AsString := AstrCodCli ;
        LqryDesvinc.Open ;
        LqryDesvinc.First ;
        LstrAutoIncs := '' ;
        while not LqryDesvinc.Eof do
        begin
          LstrAutoIncs := LstrAutoIncs + ifThen(Trim(LstrAutoIncs) = '', Quotedstr(LqryDesvinc.FieldByName('AUTOINCREM').AsString), ',' + Quotedstr(LqryDesvinc.FieldByName('AUTOINCREM').AsString) ) ;
          LqryDesvinc.Next ;
        end ;

        if Trim(LstrAutoIncs) <> '' then
        begin
          LqryDesvinc.Close ;
          LqryDesvinc.SQL.Clear ;
          LqryDesvinc.SQL.Add('UPDATE SITDOC SET DOC_TIPREC = NULL WHERE DOC_NUMDOC IN (' + LstrAutoIncs + ') ;') ;
          LqryDesvinc.ExecSQL;
        end ;

      end ;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pGravarErro(True, E.Message, 'TLinkPagamentoCitelModel.fDesvinculaPedido') ;
      End;
    End;
  finally
    FreeAndNil(LqryDesvinc);
  end ;
end;

class function TLinkPagamentoCitelModel.fEstornaTrasacao(const AstrNumNit, AstrEnvCn1,
  AstrResCn1, AstrEnvCn2, AstrResCn2, AstrNitEst, AstrNsuEst, AstrCplEst,
  AstrCpcEst, AstrOrigem: String): Boolean;
var
  LqrySitCob : TUniQuery;
begin
  Result := True ;
  LqrySitCob := fCriaQuery;
  try
    try
      LqrySitCob.Close ;
      LqrySitCob.SQL.Clear ;
      LqrySitCob.SQL.Add('UPDATE SITCOB SET ') ;

      if not fEmptyStr(AstrNitEst) then
      begin
        LqrySitCob.SQL.Add('  SIT_ENVCN1 = :ENVCN1, ') ;
        LqrySitCob.SQL.Add('  SIT_RESCN1 = :RESCN1, ') ;
        LqrySitCob.SQL.Add('  SIT_ENVCN2 = :ENVCN2, ') ;
        LqrySitCob.SQL.Add('  SIT_RESCN2 = :RESCN2, ') ;
        LqrySitCob.SQL.Add('  SIT_DTAEST = :DTAEST, ') ;
        LqrySitCob.SQL.Add('  SIT_HRAEST = :HRAEST, ') ;
        LqrySitCob.SQL.Add('  SIT_NITEST = :NITEST, ') ;
        LqrySitCob.SQL.Add('  SIT_NSUEST = :NSUEST, ') ;
        LqrySitCob.SQL.Add('  SIT_OPEEST = :OPEEST, ') ;
        LqrySitCob.SQL.Add('  SIT_CPLEST = :CPLEST, ') ;
        LqrySitCob.SQL.Add('  SIT_CPCEST = :CPCEST, ') ;
        LqrySitCob.SQL.Add('  SIT_STATUS = :STATUS ') ;

        LqrySitCob.ParamByName('ENVCN1').AsString := AstrEnvCn1 ;
        LqrySitCob.ParamByName('RESCN1').AsString := AstrResCn1 ;
        LqrySitCob.ParamByName('ENVCN2').AsString := AstrEnvCn2 ;
        LqrySitCob.ParamByName('RESCN2').AsString := AstrResCn2 ;
        LqrySitCob.ParamByName('DTAEST').AsDate := VS_Date ;
        LqrySitCob.ParamByName('HRAEST').AsDateTime := fTime() ;
        LqrySitCob.ParamByName('NITEST').AsString := AstrNitEst ;
        LqrySitCob.ParamByName('NSUEST').AsString := AstrNsuEst ;
        LqrySitCob.ParamByName('OPEEST').AsString := strLoginUsuarioLogado ;
        LqrySitCob.ParamByName('CPLEST').AsString := AstrCplEst ;
        LqrySitCob.ParamByName('CPCEST').AsString := AstrCpcEst ;
        LqrySitCob.ParamByName('STATUS').AsString := 'EST' ;
      end
      else
      begin
        LqrySitCob.SQL.Add('  SIT_ENVCN1 = :ENVCN1, ') ;
        LqrySitCob.SQL.Add('  SIT_RESCN1 = :RESCN1, ') ;
        LqrySitCob.SQL.Add('  SIT_ENVCN2 = :ENVCN2, ') ;
        LqrySitCob.SQL.Add('  SIT_RESCN2 = :RESCN2 ') ;
        LqrySitCob.ParamByName('ENVCN1').AsString := AstrEnvCn1 ;
        LqrySitCob.ParamByName('RESCN1').AsString := AstrResCn1 ;
        LqrySitCob.ParamByName('ENVCN2').AsString := AstrEnvCn2 ;
        LqrySitCob.ParamByName('RESCN2').AsString := AstrResCn2 ;
      end ;
      LqrySitCob.SQL.Add('WHERE SIT_NUMNIT = :NUMNIT ; ') ;
      LqrySitCob.ParamByName('NUMNIT').AsString := AstrNumNit ;
      LqrySitCob.ExecSQL;

      if (not fEmptyStr(AstrNitEst)) and (AstrOrigem = 'AGR') then
      begin
        LqrySitCob.Close ;
        LqrySitCob.SQL.Clear ;
        LqrySitCob.SQL.Add('UPDATE SITDOC SET DOC_TIPREC = NULL WHERE DOC_NUMNIT = :NUMNIT ;') ;
        LqrySitCob.ParamByName('NUMNIT').AsString := AstrNumNit ;
        LqrySitCob.ExecSQL;
      end ;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pGravarErro(True, E.Message, 'TLinkPagamentoCitelModel.fEstornaTrasacao') ;
      End;
    End;
  finally
    FreeAndNil(LqrySitCob);
  end ;
end;

class function TLinkPagamentoCitelModel.fNovaTransacao(strCodEmp, strUrlPgt, strNumNit,
  strNumNsu, strCodOpe : String; dtaDtaCad : TDate; hraHraCad : TTime;
  strMercId : String; fltValTra : Double; strSeqFgo : String; strEnvJso,
  strResJso : String; intQtdParcelas : Integer; strTipLan, strAutoIncs: String;
  dtaExpiracao: TDateTime) : Boolean;
var
  qrySitCob, qryFatGor, qrySitDoc : TUniQuery;
  blnControleTransacaoLocal : Boolean;
  LlstAutoIncs: TStringList ;
  LintCnt: Integer ;
begin
  blnControleTransacaoLocal := False;
  Result := True;
  qrySitCob := fCriaQuery;
  qryFatGor := fCriaQuery;
  qrySitDoc := fCriaQuery;
  try

    if not fInTransaction then
    begin
      fStartTransaction;
      blnControleTransacaoLocal := True;
    end;

    try
      qrySitCob.Close;
      qrySitCob.SQL.Clear;
      qrySitCob.SQL.Add('INSERT INTO SITCOB (SIT_CODEMP, ');
      qrySitCob.SQL.Add('                    SIT_URLPGT, ');
      qrySitCob.SQL.Add('                    SIT_NUMNIT, ');
      qrySitCob.SQL.Add('                    SIT_NUMNSU, ');
      qrySitCob.SQL.Add('                    SIT_CODOPE, ');
      qrySitCob.SQL.Add('                    SIT_DTACAD, ');
      qrySitCob.SQL.Add('                    SIT_HRACAD, ');
      qrySitCob.SQL.Add('                    SIT_VALTRA, ');
      qrySitCob.SQL.Add('                    SIT_STATUS, ');
      qrySitCob.SQL.Add('                    SIT_MERCID, ');
      qrySitCob.SQL.Add('                    SIT_ENVJSO, ');
      qrySitCob.SQL.Add('                    SIT_RESJSO, ');
      qrySitCob.SQL.Add('                    SIT_QTDPAR, ');
      qrySitCob.SQL.Add('                    SIT_DTAEXP) ');
      qrySitCob.SQL.Add('            VALUES (:CODEMP,    ');
      qrySitCob.SQL.Add('                    :URLPGT,    ');
      qrySitCob.SQL.Add('                    :NUMNIT,    ');
      qrySitCob.SQL.Add('                    :NUMNSU,    ');
      qrySitCob.SQL.Add('                    :CODOPE,    ');
      qrySitCob.SQL.Add('                    :DTACAD,    ');
      qrySitCob.SQL.Add('                    :HRACAD,    ');
      qrySitCob.SQL.Add('                    :VALTRA,    ');
      qrySitCob.SQL.Add('                    :STATUS,    ');
      qrySitCob.SQL.Add('                    :MERCID,    ');
      qrySitCob.SQL.Add('                    :ENVJSO,    ');
      qrySitCob.SQL.Add('                    :RESJSO,    ');
      qrySitCob.SQL.Add('                    :QTDPAR,    ');
      qrySitCob.SQL.Add('                    :DTAEXP)    ');
      qrySitCob.ParamByName('CODEMP').Value := strCodEmp;
      qrySitCob.ParamByName('URLPGT').Value := strUrlPgt;
      qrySitCob.ParamByName('NUMNIT').Value := strNumNit;
      qrySitCob.ParamByName('NUMNSU').Value := strNumNsu;
      qrySitCob.ParamByName('CODOPE').Value := strCodOpe;
      qrySitCob.ParamByName('DTACAD').AsDate := dtaDtaCad;
      qrySitCob.ParamByName('HRACAD').AsDateTime := hraHraCad;
      qrySitCob.ParamByName('VALTRA').Value := fltValTra;
      qrySitCob.ParamByName('STATUS').Value := stTransacaoRecente;
      qrySitCob.ParamByName('MERCID').Value := strMercId;
      qrySitCob.ParamByName('ENVJSO').Value := strEnvJso;
      qrySitCob.ParamByName('RESJSO').Value := strResJso;
      qrySitCob.ParamByName('QTDPAR').Value := intQtdParcelas;
      qrySitCob.ParamByName('DTAEXP').Value := dtaExpiracao;
      qrySitCob.ExecSQL;

      LlstAutoIncs := fStringAutoIncsToList(strAutoIncs) ;
      try
        for LintCnt := 0 to LlstAutoIncs.Count-1 do
        begin
          qrySitDoc.Close ;
          qrySitDoc.SQL.Clear ;
          qrySitDoc.SQL.Add(' INSERT INTO SITDOC ( ');
          qrySitDoc.SQL.Add('   DOC_NUMNIT, ');
          qrySitDoc.SQL.Add('   DOC_MERCID, ');
          qrySitDoc.SQL.Add('   DOC_NUMDOC, ');
          qrySitDoc.SQL.Add('   DOC_TIPLAN, ');
          qrySitDoc.SQL.Add('   DOC_TIPREC) ');
          qrySitDoc.SQL.Add(' VALUES ( ');
          qrySitDoc.SQL.Add('   :NUMNIT, ');
          qrySitDoc.SQL.Add('   :MERCID, ');
          qrySitDoc.SQL.Add('   :NUMDOC, ');
          qrySitDoc.SQL.Add('   :TIPLAN, ');
          qrySitDoc.SQL.Add('   :TIPREC ');
          qrySitDoc.SQL.Add(' ) ; ');
          qrySitDoc.ParamByName('NUMNIT').AsString := strNumNit;
          qrySitDoc.ParamByName('MERCID').AsString := strMercId;
          qrySitDoc.ParamByName('NUMDOC').AsString := LlstAutoIncs.Strings[LintCnt];
          qrySitDoc.ParamByName('TIPLAN').AsString := strTipLan;
          qrySitDoc.ParamByName('TIPREC').AsString := fGetLinkPagamentoCitelFornecedor.fGetTipRec;
          qrySitDoc.ExecSQL;
        end ;
      finally
        FreeAndNil(LlstAutoIncs) ;
      end ;

      if trim(strSeqFgo) <> '' then
      begin
        qryFatGor.Close;
        qryFatGor.SQL.Clear;
        qryFatGor.SQL.Add('UPDATE ');
        qryFatGor.SQL.Add('  EXTGOR ');
        qryFatGor.SQL.Add('SET ');
        qryFatGor.SQL.Add('  FGO_SITNIT = :SITNIT, ');
        qryFatGor.SQL.Add('  FGO_SITMID = :SITMID, ');
        qryFatGor.SQL.Add('  FGO_TIPREC = "' + fGetLinkPagamentoCitelFornecedor.fGetTipRec + '" ');
        qryFatGor.SQL.Add('WHERE FGO_SEQFGO IN(:SEQFGO) ');
        qryFatGor.ParamByName('SITNIT').Value := strNumNit;
        qryFatGor.ParamByName('SITMID').Value := strMercId;
        qryFatGor.ParamByName('SEQFGO').Value := strSeqFgo;
        qryFatGor.ExecSQL;
      end ;

      if blnControleTransacaoLocal then
        fCommit;
    Except
      On E: Exception Do
      Begin
        Result := False;
        If fInTransaction Then
          fRollBack;
        pGravarErro(True, E.Message, 'TLinkPagamentoCitelModel.fNovaTransacao') ;
      End;
    End;
  finally
    FreeAndNil(qrySitCob);
    FreeAndNil(qryFatGor);
    FreeAndNil(qrySitDoc);
  end;
end;

class function TLinkPagamentoCitelModel.fStringAutoIncsToList(
  const AstrIncDocs: String): TStringList;
begin
  Result := TStringList.Create ;
  Result.Delimiter := ';' ;
  Result.DelimitedText := AstrIncDocs ;
end;

class procedure TLinkPagamentoCitelModel.pRemoveTransacao(strNumNit, strMercId, strCodEmp: String);
  var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' DELETE ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   SITCOB ');
    qryAux.SQL.Add(' WHERE SIT_NUMNIT = :NUMNIT ');
    qryAux.SQL.Add('   AND SIT_MERCID = :MERCID ');
    qryAux.SQL.Add('   AND SIT_CODEMP = :CODEMP ');
    qryAux.ParamByName('NUMNIT').AsString := strNumNit;
    qryAux.ParamByName('MERCID').AsString := strMercId;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

class procedure TLinkPagamentoCitelModel.pAtualizaFormaEnvio(const AstrNumNit,
  AstrMercId, AstrFormaEnvio: String);
Var
  LqrySitCob : TUniQuery;
begin
  LqrySitCob := fCriaQuery;
  try
    LqrySitCob.Close;
    LqrySitCob.SQL.Clear;
    LqrySitCob.SQL.Add(' UPDATE SITCOB ');
    LqrySitCob.SQL.Add('    SET SIT_ENVIAD = :ENVIAD ');
    LqrySitCob.SQL.Add('  WHERE SIT_NUMNIT = :NUMNIT ');
    LqrySitCob.SQL.Add('    AND SIT_MERCID = :MERCID ');
    LqrySitCob.ParamByName('NUMNIT').AsString := AstrNumNit;
    LqrySitCob.ParamByName('MERCID').AsString := AstrMercId;
    LqrySitCob.ParamByName('ENVIAD').AsString := AstrFormaEnvio;
    LqrySitCob.ExecSQL;
  finally
    FreeAndNil(LqrySitCob);
  end;

end;

class procedure TLinkPagamentoCitelModel.pAtualizaStatus(const strNumNit, strMercId,
  strCodEmp, strStatus: String; const AstrStatusAtual: String);
  Var
    qrySitCob : TUniQuery;
begin
  qrySitCob := fCriaQuery;
  try
    qrySitCob.Close;
    qrySitCob.SQL.Clear;
    qrySitCob.SQL.Add(' UPDATE SITCOB ');
    qrySitCob.SQL.Add('    SET SIT_STATUS = :STATUS ');
    qrySitCob.SQL.Add('  WHERE SIT_NUMNIT = :NUMNIT ');
    qrySitCob.SQL.Add('    AND SIT_MERCID = :MERCID ');
    qrySitCob.SQL.Add('    AND SIT_CODEMP = :CODEMP ');
    if not fEmptyStr(AstrStatusAtual) then
      qrySitCob.SQL.Add('    AND SIT_STATUS = :STATUS_ATUAL ');
    qrySitCob.ParamByName('NUMNIT').AsString := strNumNit;
    qrySitCob.ParamByName('MERCID').AsString := strMercId;
    qrySitCob.ParamByName('CODEMP').AsString := strCodEmp;
    qrySitCob.ParamByName('STATUS').AsString := strStatus;
    if not fEmptyStr(AstrStatusAtual) then
      qrySitCob.ParamByName('STATUS_ATUAL').AsString := AstrStatusAtual;
    qrySitCob.ExecSQL;
  finally
    FreeAndNil(qrySitCob);
  end;
end;

end.
