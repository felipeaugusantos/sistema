unit untSIGEPWebFuncoes;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Vcl.Forms,
  System.IOUtils,
  Data.DB,
  Uni;

  function fTransportadoraCorreio(strCodTra: String): Boolean;
  function fPLPDocumentoJaEnviada(strNumDoc, strEspDoc, strCodEmp : String) : boolean;
  function fRetornaAutoincremPLPDOC(strNumDoc, strEspDoc, strCodEmp : String) : String;
  procedure pVinculaDocumentosPLPRomaneio(strNumRom, strSeqPLP: String);
  procedure pRemoveVinculoDocumentosPLPEmAbertoRomaneio(strNumRom : String);
  procedure pDeletaPLPEmAbertoSemObjetoRomaneio(strNumRom : String);
  function fUsaPLPPorRomaneio : boolean;
  procedure pNormalizaDadosParaAlteracaoROMPLP(blnNovaROMPLP : Boolean);
  function fRomaneioTemPLPEmAberto(strNumRom: String): Boolean;
  function fRomaneioTemPLPEnviada(strNumRom: String): Boolean;
  function fRetSeqPreListaPostagem(strCodTra: String; strNumRom: String = ''): String; overload;
  function fRetSeqPreListaPostagem(strCodTra: String; strNumRom: String; out strCodPlp: String): String; overload;
  function fDivergenciasEndereco(strNumDoc, strEspDoc: String; strEmpDoc: String = ''): String;
  function fDocumentoEmPLP(strNumDoc, strEspDoc, strCodEmp: String; var blnEnviado: Boolean; var intQtdVol: Integer): Boolean;
  procedure pRemoveDocumentoAndLiberaObjetos(strNumDoc, strEspDoc, strCodEmp: String);
  function fIncluiDocPLP(strNumDoc, strEspDoc, strCodEmp, strSerCorCodTra, strXmlEnv,
                         strXmlRet, strIdPost, strNumObjComDig: String; intOrdemRegistro: Integer = 1;
                         blnControlaTransacao: Boolean = True): Boolean;
  procedure pEnviaEmailPLP_WMS;
  function fCfgCor(strNomCam: String): String;
  function fNomTab(strEspDoc: String): String;
  function fGetNumObjetoTransportadora(strCodTra: String): String;
  function fGeraData2D(strNumDoc, strEspDoc, strNumObj: String): String;
  procedure pAtualizaDadosPrePostagem(const strCodPLP, strXmlEnv, strXmlRet: String; const intSeqCor: Integer);
  function fGravaCorObj(strCodSer, strNumObjSemDig, strNumObjComDig: String): Boolean;
  function fObjComDigitoCorreios(const strObjSemDig: String): String;
  function fObjSemDigitoCorreios(const strObjComDig: String): String;
  function fSerCorToCodCorreio(strSerCor: String): String;
  function fObjetoToSerCor(strNumObj: String): String;
  function fRetDescricaoServicoCorreio(strCodSer: String): String;

implementation

uses
  {$IFNDEF INTEGRACAO_ARMAZENS}
  untTEnvioEmail,
  {$ENDIF}
  untFuncoesSimples, untSIGEPWebClasses, untDespacho, untCorreiosMain;

function fTransportadoraCorreio(strCodTra: String): Boolean;
begin
  Result := fCampoTabela('COUNT(*)', 'CORTRA', ['TRA_CODTRA', 'TRA_CODEMP'], [strCodTra, VS_strCodEmp]) > 0;
end;

function fPLPDocumentoJaEnviada(strNumDoc, strEspDoc, strCodEmp : String) : boolean;
var
  qryQuery : TUniQuery;
begin
  qryQuery := fCriaQuery(nil);
  try
    qryQuery.SQL.Add('SELECT                                                ');
    qryQuery.SQL.Add('  PLP_DTAENV                                          ');
    qryQuery.SQL.Add('FROM                                                  ');
    qryQuery.SQL.Add('  CORPLP                                              ');
    qryQuery.SQL.Add('  INNER JOIN PLPDOC ON PLD_SEQPLP = CORPLP.AUTOINCREM ');
    qryQuery.SQL.Add('WHERE PLD_NUMDOC = :NUMDOC                            ');
    qryQuery.SQL.Add('  AND PLD_ESPDOC = :ESPDOC                            ');
    qryQuery.SQL.Add('  AND PLD_EMPDOC = :CODEMP                            ');

    qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
    qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
    qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
    qryQuery.Open;

    Result := not qryQuery.FieldByName('PLP_DTAENV').IsNull;

    qryQuery.Close;
  finally
    FreeAndNil(qryQuery);
  end;
end;

function fRetornaAutoincremPLPDOC(strNumDoc, strEspDoc, strCodEmp : String) : String;
var
  qryQuery : TUniQuery;
begin
  qryQuery := fCriaQuery(nil);
  try
    qryQuery.SQL.Add('SELECT                      ');
    qryQuery.SQL.Add('  AUTOINCREM                ');
    qryQuery.SQL.Add('FROM                        ');
    qryQuery.SQL.Add('   PLPDOC                   ');
    qryQuery.SQL.Add('WHERE PLD_NUMDOC = :NUMDOC  ');
    qryQuery.SQL.Add('  AND PLD_ESPDOC = :ESPDOC  ');
    qryQuery.SQL.Add('  AND PLD_EMPDOC = :CODEMP  ');

    qryQuery.ParamByName('NUMDOC').AsString := strNumDoc;
    qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
    qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
    qryQuery.Open;

    Result := qryQuery.FieldByName('AUTOINCREM').AsString;

    qryQuery.Close;
  finally
    FreeAndNil(qryQuery);
  end;
end;

procedure pVinculaDocumentosPLPRomaneio(strNumRom, strSeqPLP: String);
var
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('UPDATE                                               ');
    qryAux.SQL.Add('  ROMGERX                                            ');
    qryAux.SQL.Add('  INNER JOIN PLPDOC ON PLD_NUMDOC = GER_NUMDOC       ');
    qryAux.SQL.Add('                   AND PLD_EMPDOC = GER_CODEMP       ');
    qryAux.SQL.Add('                   AND PLD_ESPDOC = GER_ESPDOC       ');
    qryAux.SQL.Add('SET                                                  ');
    qryAux.SQL.Add('  PLD_SEQPLP = :SEQPLP                               ');
    qryAux.SQL.Add('WHERE GER_NUMROM = :NUMROM                           ');
    qryAux.SQL.Add('  AND GER_EMPROM = :CODEMP                           ');
    qryAux.SQL.Add('  AND PLD_SEQPLP IS NULL                             ');

    qryAux.ParamByName('SEQPLP').AsString := strSeqPLP;
    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure pRemoveVinculoDocumentosPLPEmAbertoRomaneio(strNumRom : String);
var
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('UPDATE                                                 ');
    qryAux.SQL.Add('  CORPLP                                               ');
    qryAux.SQL.Add('  INNER JOIN PLPDOC ON PLD_SEQPLP = CORPLP.AUTOINCREM  ');
    qryAux.SQL.Add('SET                                                    ');
    qryAux.SQL.Add('  PLD_SEQPLP = NULL                                    ');
    qryAux.SQL.Add('WHERE PLP_NUMROM = :NUMROM                             ');
    qryAux.SQL.Add('  AND PLP_CODEMP = :CODEMP                             ');
    qryAux.SQL.Add('  AND PLP_DTAENV IS NULL                               ');

    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure pDeletaPLPEmAbertoSemObjetoRomaneio(strNumRom : String);
var
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('DELETE FROM                                                         ');
    qryAux.SQL.Add('  CORPLP                                                            ');
    qryAux.SQL.Add('WHERE PLP_DTAENV IS NULL                                            ');
    qryAux.SQL.Add('  AND PLP_NUMROM = :NUMROM                                          ');
    qryAux.SQL.Add('  AND PLP_CODEMP = :CODEMP                                          ');
    qryAux.SQL.Add('  AND AUTOINCREM NOT IN (SELECT IFNULL(PLD_SEQPLP, "") FROM PLPDOC) ');

    qryAux.ParamByName('NUMROM').AsString := strNumRom;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

function fUsaPLPPorRomaneio : boolean;
begin
  result := fCfgSis('ROMPLP', varBoolean) and (fCfgSis('USIGEP', varString) <> 'N');
end;

procedure pNormalizaDadosParaAlteracaoROMPLP(blnNovaROMPLP : Boolean);
var
  strAutoIncremPLP : String;
begin
  if blnNovaROMPLP then
  begin
    //Exclui a PLP em aberto e deixa os objetos não enviados livres para assumirem uma nova PLP, quando forem incluídos em um Romaneio
    fExecutaSQL(  ' UPDATE                                                '
                + '   CORPLP                                              '
                + '   INNER JOIN PLPDOC ON PLD_SEQPLP = CORPLP.AUTOINCREM '
                + ' SET                                                   '
                + '   PLD_SEQPLP = NULL                                   '
                + ' WHERE PLP_CODEMP = '+QuotedStr(VS_strCodEmp)
                + '   AND PLP_DTAENV IS NULL                              '
                + '   AND PLP_NUMROM IS NULL                              ');

    fExecutaSQL(  ' DELETE FROM CORPLP                                    '
                + ' WHERE PLP_CODEMP = '+QuotedStr(VS_strCodEmp)
                + '   AND PLP_DTAENV IS NULL                              '
                + '   AND PLP_NUMROM IS NULL                              ');
  end
  else
  begin
    //exclui as PLPs de romaneio em aberto e vincula objetos a uma nova PLP padrão
    strAutoIncremPLP := fRetSeqPreListaPostagem('');

    fExecutaSQL(  ' UPDATE                                               '
                + '   PLPDOC                                             '
                + '   LEFT JOIN CORPLP ON CORPLP.AUTOINCREM = PLD_SEQPLP '
                + ' SET                                                  '
                + '   PLD_SEQPLP = '+ QuotedStr(strAutoIncremPLP)
                + ' WHERE PLD_CODEMP = '+QuotedStr(VS_strCodEmp)
                + '   AND (   (PLD_SEQPLP IS NULL)                       '
                + '        OR (    PLP_DTAENV IS NULL                    '
                + '            AND PLP_NUMROM IS NOT NULL)               '
                + '       )                                              ');

    fExecutaSQL(  ' DELETE FROM CORPLP                                    '
                + ' WHERE PLP_CODEMP = '+QuotedStr(VS_strCodEmp)
                + '   AND PLP_DTAENV IS NULL                              '
                + '   AND PLP_NUMROM IS NOT NULL                          ');
  end;
end;

function fRomaneioTemPLPEmAberto(strNumRom: String): Boolean;
  Var
    qryRomPLP : TUniQuery;
begin
  qryRomPLP := fCriaQuery(nil);
  Try
    qryRomPLP.Close;
    qryRomPLP.SQL.Clear;
    qryRomPLP.SQL.Add(' SELECT COUNT(*) QTD         ');
    qryRomPLP.SQL.Add('   FROM CORPLP               ');
    qryRomPLP.SQL.Add('  WHERE PLP_NUMROM = :NUMROM ');
    qryRomPLP.SQL.Add('    AND PLP_CODEMP = :CODEMP ');
    qryRomPLP.SQL.Add('    AND PLP_DTAENV IS NULL   ');

    qryRomPLP.ParamByName('NUMROM').AsString := strNumRom;
    qryRomPLP.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryRomPLP.Open;

    Result := (qryRomPLP.FieldByName('QTD').AsInteger > 0);

    qryRomPLP.Close;

  Finally
    FreeAndNil(qryRomPLP);
  End;
end;

function fRomaneioTemPLPEnviada(strNumRom: String): Boolean;
  Var
    qryRomPLP : TUniQuery;
begin
  qryRomPLP := fCriaQuery(nil);
  Try
    qryRomPLP.Close;
    qryRomPLP.SQL.Clear;
    qryRomPLP.SQL.Add(' SELECT COUNT(*) QTD            ');
    qryRomPLP.SQL.Add('   FROM CORPLP                  ');
    qryRomPLP.SQL.Add('  WHERE PLP_NUMROM = :NUMROM    ');
    qryRomPLP.SQL.Add('    AND PLP_CODEMP = :CODEMP    ');
    qryRomPLP.SQL.Add('    AND PLP_DTAENV IS NOT  NULL ');

    qryRomPLP.ParamByName('NUMROM').AsString := strNumRom;
    qryRomPLP.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryRomPLP.Open;

    Result := (qryRomPLP.FieldByName('QTD').AsInteger > 0);

    qryRomPLP.Close;
  Finally
    FreeAndNil(qryRomPLP);
  End;
end;

function fRetSeqPreListaPostagem(strCodTra: String; strNumRom: String = ''): String;
  Var
    strCodPlp: String;
begin
  Result := fRetSeqPreListaPostagem(strCodTra, strNumRom, strCodPlp);
end;

function fRetSeqPreListaPostagem(strCodTra: String; strNumRom: String; out strCodPlp: String): String;
  Var
    qryCorPlp: TUniQuery;
    strTipEtq: String;
Begin
  qryCorPlp := fCriaQuery;

  Try
    strTipEtq := '';

    If fEmptyStr(strCodTra) Then
      qryCorPlp.SQL.Add(' SELECT * FROM CORPLP WHERE PLP_CODEMP = :CODEMP AND PLP_DTAENV IS NULL ')
    Else
    Begin
      {**************************************************************************************}
      {* CASO FOR TRANSPORTADORA DO LAYOUT CORREIO ENTÃO AGRUPA EM UMA MESMA PLP            *}
      {* ONDE O TIPETQ FOR CORREIO E A PLP ESTEJA ABERTA (SE NAO TIVER INSERI O REGISTRO.   *}
      {* SE FOR DO TIPO TRANSPORTADORA ENTÃO AGRUPA EM UMA PLP DO CODIGO DA TRANSPORTADORA, *}
      {* TAMBEM QUE ESTEJA ABERTA (SE NAO TIVER INSERI O REGISTRO                           *}
      {**********************************************************************************GB**}
      strTipEtq := fCampoTabela('TRA_TIPETQ', 'CADTRA', ['TRA_CODTRA'], [strCodTra]);
      If strTipEtq = 'C' Then
      Begin
        qryCorPlp.SQL.Add(' SELECT * FROM CORPLP WHERE PLP_CODEMP = :CODEMP AND PLP_DTAENV IS NULL AND PLP_TIPETQ = "C" ');
      End
      Else
      Begin
        qryCorPlp.SQL.Add(' SELECT * FROM CORPLP WHERE PLP_CODEMP = :CODEMP AND PLP_DTAENV IS NULL AND PLP_CODTRA = :CODTRA ');
        qryCorPlp.ParamByName('CODTRA').AsString := strCodTra;
      End;
    End;

    if fEmptyStr(strNumRom) then
      qryCorPlp.SQL.Add(' AND PLP_NUMROM IS NULL')
    else
    begin
      qryCorPlp.SQL.Add(' AND PLP_NUMROM = :NUMROM');
      qryCorPlp.ParamByName('NUMROM').AsString := strNumRom;
    end;

    qryCorPlp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCorPlp.Open;

    If not qryCorPlp.IsEmpty Then
    Begin
      Result    := qryCorPlp.FieldByName('AUTOINCREM').AsString;
      strCodPlp := qryCorPlp.FieldByName('PLP_CODIGO').AsString;
    End
    Else
    Begin
      qryCorPlp.Close;
      qryCorPlp.SQL.Clear;
      qryCorPlp.SQL.Add(' INSERT INTO CORPLP(AUTOINCREM, PLP_CODIGO, PLP_CODEMP, PLP_SEQCFG, PLP_CODTRA, PLP_TIPETQ, PLP_NUMROM) ');
      qryCorPlp.SQL.Add('             VALUES(:AUTINC, :CODIGO, :CODEMP, :SEQCFG, :CODTRA, :TIPETQ, :NUMROM)                      ');

      Result    := fRetAutoIncrem('CORPLP', VS_strCodEmp);
      strCodPlp := fAtualizaProCod('CORPLP', 'PLP_CODIGO');

      qryCorPlp.ParamByName('AUTINC').AsString := Result;
      qryCorPlp.ParamByName('CODIGO').AsString := strCodPlp;
      qryCorPlp.ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(strCodTra) Then
      Begin
        qryCorPlp.ParamByName('CODTRA').AsString := strCodTra;
        qryCorPlp.ParamByName('TIPETQ').AsString := strTipEtq;
        qryCorPlp.ParamByName('SEQCFG').Clear;
      End
      Else
      Begin
        qryCorPlp.ParamByName('CODTRA').Clear;
        qryCorPlp.ParamByName('TIPETQ').Clear;
        qryCorPlp.ParamByName('SEQCFG').AsString := fCfgCor('AUTOINCREM');
      End;

      if fEmptyStr(strNumRom) then
        qryCorPlp.ParamByName('NUMROM').Clear
      else
        qryCorPlp.ParamByName('NUMROM').AsString := strNumRom;

      qryCorPlp.ExecSQL;
    End;

  Finally
    FreeAndNil(qryCorPlp);
  End;
End;

function fDivergenciasEndereco(strNumDoc, strEspDoc: String; strEmpDoc: String = ''): String;
  Var
    qryPlpDoc: TUniQuery;
Begin
  qryPlpDoc := fCriaQuery;

  Try
    qryPlpDoc.Close;
    qryPlpDoc.SQL.Clear;
    qryPlpDoc.SQL.Add( fSQLDespacho(False, fNomTab(strEspDoc), 'C', strNumDoc, strEspDoc, False, True));

    qryPlpDoc.ParamByName('NUMDOC').AsString := strNumDoc;
    qryPlpDoc.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPlpDoc.ParamByName('CODEMP').AsString := IIF(fEmptyStr(strEmpDoc), VS_strCodEmp, strEmpDoc);

    qryPlpDoc.Open;

    Result := '';
    If not (Length(qryPlpDoc.FieldByName('ENDCLI').AsString) <= 50) Then
      Result := Result + 'ENDCLI_';

    If not (Length(qryPlpDoc.FieldByName('ENDCOM').AsString) <= 30) Then
      Result := Result + 'ENDCOM_';

    If not (Length(qryPlpDoc.FieldByName('BAICLI').AsString) <= 30) Then
      Result := Result + 'BAICLI_';

    If not (Length(fRetSomenteNumeros(qryPlpDoc.FieldByName('FONCLI').AsString)) <= 11) Then
      Result := Result + 'FONCLI_';

    qryPlpDoc.Close;
  Finally
    FreeAndNil(qryPlpDoc);
  End;
End;

function fDocumentoEmPLP(strNumDoc, strEspDoc, strCodEmp: String; var blnEnviado: Boolean; var intQtdVol: Integer): Boolean;
  Var
    qryPlpDoc: TUniQuery;
Begin
  qryPlpDoc := fCriaQuery;

  Try
    qryPlpDoc.Close;
    qryPlpDoc.SQL.Clear;
    qryPlpDoc.SQL.Add(' SELECT PLP_DTAENV                                ');
    qryPlpDoc.SQL.Add(' FROM PLPDOC                                      ');
    qryPlpDoc.SQL.Add(' LEFT JOIN CORPLP B ON B.AUTOINCREM = PLD_SEQPLP  ');
    qryPlpDoc.SQL.Add(' WHERE PLD_NUMDOC = :NUMDOC                       ');
    qryPlpDoc.SQL.Add('   AND PLD_ESPDOC = :ESPDOC                       ');
    qryPlpDoc.SQL.Add('   AND PLD_SERIE_ = :SERIE_                       ');
    qryPlpDoc.SQL.Add('   AND PLD_EMPDOC = :CODEMP                       ');

    qryPlpDoc.ParamByName('NUMDOC').AsString := strNumDoc;
    qryPlpDoc.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPlpDoc.ParamByName('SERIE_').AsString := IfThen(Pos(strEspDoc, 'NF_IF_MI_FF_') > 0, fCfgSis('SERFSC'), '');
    qryPlpDoc.ParamByName('CODEMP').AsString := strCodEmp;

    qryPlpDoc.Open;

    Result := (Not qryPlpDoc.IsEmpty);

    blnEnviado := qryPlpDoc.FieldByName('PLP_DTAENV').AsDateTime > 0;
    intQtdVol  := qryPlpDoc.RecordCount;

    qryPlpDoc.Close;
  Finally
    FreeAndNil(qryPlpDoc);
  End;
End;

procedure pRemoveDocumentoAndLiberaObjetos(strNumDoc, strEspDoc, strCodEmp: String);
  Var
    qryPlpDoc, qryUpdObj, qryFatRtm: TUniQuery;
Begin
  qryUpdObj := fCriaQuery;
  qryPlpDoc := fCriaQuery;
  qryFatRtm := Nil;

  Try
    If (strEspDoc = 'PD') Then
    Begin
      qryFatRtm := fCriaQuery;
      qryFatRtm.SQL.Add(' DELETE FROM FATRTM ');
      qryFatRtm.SQL.Add(' WHERE RTM_NUMDOC = :NUMDOC ');
      qryFatRtm.SQL.Add('   AND RTM_CODEMP = :CODEMP ');
      qryFatRtm.SQL.Add('   AND RTM_NUMREG IN (:NUMOBJ, :OBJDIG) ');
    End;

    qryUpdObj.Close;
    qryUpdObj.SQL.Clear;
    qryUpdObj.SQL.Add(' UPDATE COROBJ SET COB_STATUS = "D" WHERE COB_NUMOBJ = :NUMOBJ ');

    qryPlpDoc.Close;
    qryPlpDoc.SQL.Clear;
    qryPlpDoc.SQL.Add(' SELECT *                   ');
    qryPlpDoc.SQL.Add(' FROM PLPDOC                ');
    qryPlpDoc.SQL.Add(' WHERE PLD_NUMDOC = :NUMDOC ');
    qryPlpDoc.SQL.Add('   AND PLD_ESPDOC = :ESPDOC ');
    qryPlpDoc.SQL.Add('   AND PLD_SERIE_ = :SERIE_ ');
    qryPlpDoc.SQL.Add('   AND PLD_EMPDOC = :CODEMP ');

    qryPlpDoc.ParamByName('NUMDOC').AsString := strNumDoc;
    qryPlpDoc.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPlpDoc.ParamByName('SERIE_').AsString := IfThen(Pos(strEspDoc, 'NF_IF_MI_FF_') > 0, fCfgSis('SERFSC'), '');
    qryPlpDoc.ParamByName('CODEMP').AsString := strCodEmp;

    qryPlpDoc.Open;

    qryPlpDoc.First;
    While Not qryPlpDoc.Eof Do
    Begin
      qryUpdObj.ParamByName('NUMOBJ').AsString := qryPlpDoc.FieldByName('PLD_NUMOBJ').AsString;
      qryUpdObj.ExecSQL;

      If (strEspDoc = 'PD') Then
      Begin
        qryFatRtm.ParamByName('NUMDOC').AsString := strNumDoc;
        qryFatRtm.ParamByName('CODEMP').AsString := strCodEmp;
        qryFatRtm.ParamByName('NUMOBJ').AsString := qryPlpDoc.FieldByName('PLD_NUMOBJ').AsString;
        qryFatRtm.ParamByName('OBJDIG').AsString := qryPlpDoc.FieldByName('PLD_OBJDIG').AsString;
        qryFatRtm.ExecSQL;
      End;

      qryPlpDoc.Next;
    End;

    qryPlpDoc.First;
    While Not qryPlpDoc.Eof Do
      qryPlpDoc.Delete;

    qryPlpDoc.Close;
  Finally
    FreeAndNil(qryFatRtm);
    FreeAndNil(qryPlpDoc);
    FreeAndNil(qryUpdObj)
  End;
End;

function fAlteraFatRtm(intOrdemRegistro: Integer; strNumDoc: String; strCodEmp: String): Boolean;
  Var
    qryFatRtm: TUniQuery;
Begin
  If (intOrdemRegistro > 1) Then
    Exit(False);

  qryFatRtm := fCriaQuery;
  Try
    qryFatRtm.Close;
    qryFatRtm.SQL.Clear;
    qryFatRtm.SQL.Add(' SELECT * ');
    qryFatRtm.SQL.Add(' FROM FATRTM ');
    qryFatRtm.SQL.Add(' WHERE RTM_NUMDOC = :NUMDOC ');
    qryFatRtm.SQL.Add('   AND RTM_CODEMP = :CODEMP ');
    qryFatRtm.SQL.Add('   AND (RTM_NUMREG IS NULL OR RTM_NUMREG = "")');
    qryFatRtm.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFatRtm.ParamByName('CODEMP').AsString := strCodEmp;
    qryFatRtm.Open;

    Result := Not qryFatRtm.IsEmpty;
  Finally
    FreeAndNil(qryFatRtm);
  End;
End;

function fIncluiDocPLP(strNumDoc, strEspDoc, strCodEmp, strSerCorCodTra, strXmlEnv, strXmlRet, strIdPost, strNumObjComDig: String;
  intOrdemRegistro: Integer = 1; blnControlaTransacao: Boolean = True): Boolean;
  Var
    qryPlpDoc: TUniQuery;
    qryFatRtm: TUniQuery;
    strNumRom, strNumObj, strCodPlp: String;
Begin
  Result := True;

  qryFatRtm := Nil;
  qryPlpDoc := fCriaQuery;
  Try
    qryFatRtm := fCriaQuery;
    fLock_Unlock('ENVIO PLP', True, True, True);

    qryPlpDoc.Close;
    qryPlpDoc.SQL.Clear;
    qryPlpDoc.SQL.Add(' INSERT INTO PLPDOC (AUTOINCREM, ');
    qryPlpDoc.SQL.Add('                     PLD_NUMDOC, ');
    qryPlpDoc.SQL.Add('                     PLD_ESPDOC, ');
    qryPlpDoc.SQL.Add('                     PLD_SERIE_, ');
    qryPlpDoc.SQL.Add('                     PLD_CODEMP, ');
    qryPlpDoc.SQL.Add('                     PLD_EMPDOC, ');
    qryPlpDoc.SQL.Add('                     PLD_NUMOBJ, ');
    qryPlpDoc.SQL.Add('                     PLD_OBJDIG, ');
    qryPlpDoc.SQL.Add('                     PLD_SEQPLP, ');
    qryPlpDoc.SQL.Add('                     PLD_DATA2D, ');
    qryPlpDoc.SQL.Add('                     PLD_IDPOST) ');
    qryPlpDoc.SQL.Add('              VALUES(:AUTINC,    ');
    qryPlpDoc.SQL.Add('                     :NUMDOC,    ');
    qryPlpDoc.SQL.Add('                     :ESPDOC,    ');
    qryPlpDoc.SQL.Add('                     :SERIE_,    ');
    qryPlpDoc.SQL.Add('                     :CODEMP,    ');
    qryPlpDoc.SQL.Add('                     :EMPDOC,    ');
    qryPlpDoc.SQL.Add('                     :NUMOBJ,    ');
    qryPlpDoc.SQL.Add('                     :OBJDIG,    ');
    qryPlpDoc.SQL.Add('                     :SEQPLP,    ');
    qryPlpDoc.SQL.Add('                     :DATA2D,    ');
    qryPlpDoc.SQL.Add('                     :IDPOST)    ');

    If fCfgSis('USIGEP') = 'A' Then
      strNumObj := fObjSemDigitoCorreios(strNumObjComDig)
    Else If fCfgSis('USIGEP') = 'O' Then
      strNumObj := fGetNumObjetoTransportadora(strSerCorCodTra);

    If fEmptyStr(strNumObj) Then
      Exit(False);

    Try
      If blnControlaTransacao Then
        fStartTransaction;

      If fCfgSis('USIGEP') = 'A' Then
        fGravaCorObj(strSerCorCodTra, strNumObj, strNumObjComDig);

      qryPlpDoc.ParamByName('AUTINC').AsString := fRetAutoIncrem('PLPDOC', VS_strCodEmp);
      qryPlpDoc.ParamByName('NUMDOC').AsString := strNumDoc;
      qryPlpDoc.ParamByName('ESPDOC').AsString := strEspDoc;
      qryPlpDoc.ParamByName('SERIE_').AsString := IfThen(Pos(strEspDoc, 'NF_IF_MI_FF_') > 0, fCfgSis('SERFSC'), '');
      qryPlpDoc.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryPlpDoc.ParamByName('EMPDOC').AsString := strCodEmp;
      qryPlpDoc.ParamByName('NUMOBJ').AsString := strNumObj;
      qryPlpDoc.ParamByName('OBJDIG').AsString := strNumObjComDig;
      qryPlpDoc.ParamByName('DATA2D').AsString := fGeraData2D(strNumDoc, strEspDoc, strNumObj);

      If Not fEmptyStr(strIdPost) Then
        qryPlpDoc.ParamByName('IDPOST').AsString := strIdPost;

      strCodPlp := '';

      //Quando utiliza o envio da PLP por romaneio, ao confirmar o romaneio será gerada uma plp vinculada a ele e só então os documentos do romaneio serão vinculados a ela
      if fCfgSis('ROMPLP', varBoolean) then
      begin
        strNumRom := fCampoTabela('GER_NUMROM','ROMGERX', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [strNumDoc, strEspDoc, strCodemp]);
        if (not fEmptyStr(strNumRom)) then
          qryPlpDoc.ParamByName('SEQPLP').AsString := fRetSeqPreListaPostagem(IfThen((fCfgSis('USIGEP', varString) = 'O'), strSerCorCodTra), strNumRom, strCodPlp);
      end
      else
        qryPlpDoc.ParamByName('SEQPLP').AsString := fRetSeqPreListaPostagem(IfThen((fCfgSis('USIGEP', varString) = 'O'), strSerCorCodTra), '', strCodPlp);

      If fCfgSis('USIGEP') = 'A' Then
      Begin
        If Not fEmptyStr(strCodPlp) Then
          pAtualizaDadosPrePostagem(strCodPlp, strXmlEnv, strXmlRet, 0);
      End;

      qryPlpDoc.ExecSQL;

      If (strEspDoc = 'PD') Then
      Begin
        If fTabelaExiste('FATRTM', True) Then
        Begin
          If (fAlteraFatRtm(intOrdemRegistro, strNumDoc, strCodEmp)) Then
          Begin
            qryFatRtm.Close;
            qryFatRtm.SQL.Clear;
            qryFatRtm.SQL.Add('UPDATE FATRTM SET ');
            qryFatRtm.SQL.Add('   RTM_NUMREG = :NUMREG ');
            qryFatRtm.SQL.Add('WHERE RTM_NUMDOC = :NUMDOC ');
            qryFatRtm.SQL.Add('  AND RTM_CODEMP = :CODEMP ');
            qryFatRtm.SQL.Add('  AND (RTM_NUMREG IS NULL OR RTM_NUMREG = "")');
            qryFatRtm.ParamByName('NUMREG').AsString := IfThen(fEmptyStr(strNumObjComDig), strNumObj, strNumObjComDig);
            qryFatRtm.ParamByName('NUMDOC').AsString := strNumDoc;
            qryFatRtm.ParamByName('CODEMP').AsString := strCodEmp;
            qryFatRtm.ExecSQL;
          End
          Else
          Begin
            qryFatRtm.Close;
            qryFatRtm.SQL.Clear;
            qryFatRtm.SQL.Add(' INSERT INTO FATRTM ');
            qryFatRtm.SQL.Add(' (AUTOINCREM, ');
            qryFatRtm.SQL.Add('  RTM_CODEMP, ');
            qryFatRtm.SQL.Add('  RTM_NUMDOC, ');
            qryFatRtm.SQL.Add('  RTM_NUMREG) ');
            qryFatRtm.SQL.Add(' VALUES ');
            qryFatRtm.SQL.Add(' (:AUTOIN, ');
            qryFatRtm.SQL.Add('  :CODEMP, ');
            qryFatRtm.SQL.Add('  :NUMDOC, ');
            qryFatRtm.SQL.Add('  :NUMREG) ');
            qryFatRtm.ParamByName('AUTOIN').AsString := fRetAutoIncrem('FATRTM', strCodEmp);
            qryFatRtm.ParamByName('CODEMP').AsString := strCodEmp;
            qryFatRtm.ParamByName('NUMDOC').AsString := strNumDoc;
            qryFatRtm.ParamByName('NUMREG').AsString := IfThen(fEmptyStr(strNumObjComDig), strNumObj, strNumObjComDig);
            qryFatRtm.ExecSQL;
          End;
        End;
      End;

      If blnControlaTransacao Then
        fCommit;
    Except
      On E: Exception Do
      Begin
        If blnControlaTransacao Then
          fRollback;
        pMensagensErro(E.Message, '[fIncluiDocPLP]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryFatRtm);
    FreeAndNil(qryPlpDoc);
    fLock_Unlock('ENVIO PLP', False);
  End;
End;

procedure pEnviaEmailPLP_WMS;
  Var
    qryGaiola, qryExcSQL: TUniQuery;
    strPLPOri, strNewPLP, strDir, strArq: String;
    objXML: TXmlCorreiosLog;
Begin
  qryGaiola := fCriaQuery;
  qryExcSQL := fCriaQuery;

  Try
    qryGaiola.Close;
    qryGaiola.SQL.Clear;
    qryGaiola.SQL.Add('SELECT * FROM ROMGAI WHERE GAI_STATUS = "F" ');
    qryGaiola.Open;

    While Not qryGaiola.Eof Do
    Begin
      strPLPOri := fRetSeqPreListaPostagem( qryGaiola.FieldByName('GAI_CODTRA').AsString );

      Try
        fStartTransaction;

        qryExcSQL.Close;
        qryExcSQL.SQL.Clear;
        qryExcSQL.SQL.Add(' INSERT INTO CORPLP(AUTOINCREM, PLP_CODIGO, PLP_CODEMP, PLP_SEQCFG, PLP_CODTRA, PLP_TIPETQ, PLP_DTAENV, PLP_HRAENV) ');
        qryExcSQL.SQL.Add('             VALUES(:AUTINC, :CODIGO, :CODEMP, :SEQCFG, :CODTRA, :TIPETQ, :DTAENV, :HRAENV)                         ');

        strNewPLP := fRetAutoIncrem('CORPLP', VS_strCodEmp);

        qryExcSQL.ParamByName('AUTINC').AsString := strNewPLP;
        qryExcSQL.ParamByName('CODIGO').AsString := fAtualizaProCod('CORPLP', 'PLP_CODIGO');
        qryExcSQL.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryExcSQL.ParamByName('DTAENV').AsDateTime := VS_Date;
        qryExcSQL.ParamByName('HRAENV').AsDateTime := fNow();
        qryExcSQL.ParamByName('CODTRA').AsString := qryGaiola.FieldByName('GAI_CODTRA').AsString;
        qryExcSQL.ParamByName('TIPETQ').AsString := fCampoTabela('TRA_TIPETQ', 'CADTRA', ['TRA_CODTRA'], [qryGaiola.FieldByName('GAI_CODTRA').AsString]);
        qryExcSQL.ParamByName('SEQCFG').Clear;

        qryExcSQL.ExecSQL;

        qryExcSQL.Close;
        qryExcSQL.SQL.Clear;
        qryExcSQL.SQL.Add(' UPDATE PLPDOC                                   ');
        qryExcSQL.SQL.Add('   INNER JOIN ROMGERX ON PLD_NUMDOC = GER_NUMDOC ');
        qryExcSQL.SQL.Add('                     AND PLD_ESPDOC = GER_ESPDOC ');
        qryExcSQL.SQL.Add('                     AND PLD_SERIE_ = GER_SERIE_ ');
        qryExcSQL.SQL.Add('                     AND PLD_EMPDOC = GER_CODEMP ');
        qryExcSQL.SQL.Add(' SET PLD_SEQPLP = :SEQPLP                        ');
        qryExcSQL.SQL.Add('  WHERE GER_NUMROM = :NUMROM                     ');
        qryExcSQL.SQL.Add('    AND GER_EMPROM = :EMPROM                     ');

        qryExcSQL.ParamByName('SEQPLP').AsString := strNewPLP;
        qryExcSQL.ParamByName('NUMROM').AsString := qryGaiola.FieldByName('GAI_NUMROM').AsString;
        qryExcSQL.ParamByName('EMPROM').AsString := qryGaiola.FieldByName('GAI_EMPROM').AsString;
        qryExcSQL.ExecSQL;

        strDir := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'PLP');
        If not DirectoryExists(strDir) Then
          TDirectory.CreateDirectory(strDir);

        If not DirectoryExists(strDir) Then
        Begin
          fMensagem('','Não foi possível criar o diretório: ' + #13 + strDir + #13 + 'Crie o diretório com total direito de acesso para continuar!', ['OK']);
          fRollBack;
          Break;
        End;

        strArq := strDir + qryGaiola.FieldByName('GAI_SEQGAI').AsString + '.xml';

        objXML := TXmlCorreiosLog.Create(strNewPLP);

        qryExcSQL.Close;
        qryExcSQL.SQL.Clear;
        qryExcSQL.SQL.Add(' UPDATE CORPLP SET PLP_XMLENV = :XMLENV WHERE AUTOINCREM = :AUTINC ');
        qryExcSQL.ParamByName('XMLENV').AsString := objXML.fGetXML(strArq);
        qryExcSQL.ParamByName('AUTINC').AsString := strNewPLP;
        qryExcSQL.ExecSQL;

        FreeAndNil(objXML);

        //Enviar Email e Atualiza Status.
        {$IFNDEF INTEGRACAO_ARMAZENS}
        If TEnvioEmail.EnviarEmail(Application.GetParentComponent(),
                                   strLoginUsuarioLogado,
                                   'Fechamento de Despacho: '+ qryGaiola.FieldByName('GAI_SEQGAI').AsString,
                                   [fCampoTabela('TRA_EMAIL_', 'CADTRA', ['TRA_CODTRA'], [qryGaiola.FieldByName('GAI_CODTRA').AsString])],
                                   [],
                                   [],
                                   TEnvioEmail.ContruirArrayMensagem('Segue em anexo arquivo de despacho sequencia: ' + qryGaiola.FieldByName('GAI_SEQGAI').AsString),
                                   [strArq], //Arquiv
                                   False) Then
        Begin
          qryExcSQL.Close;
          qryExcSQL.SQL.Clear;
          qryExcSQL.SQL.Add(' UPDATE ROMGAI SET GAI_STATUS = "E",     ');
          qryExcSQL.SQL.Add('                   GAI_DTAENV = :DTAENV, ');
          qryExcSQL.SQL.Add('                   GAI_HRAENV = :HRAENV  ');
          qryExcSQL.SQL.Add(' WHERE AUTOINCREM = :AUTINC              ');
          qryExcSQL.ParamByName('AUTINC').AsString := qryGaiola.FieldByName('AUTOINCREM').AsString;
          qryExcSQL.ParamByName('DTAENV').AsDateTime := VS_Date;
          qryExcSQL.ParamByName('HRAENV').AsDateTime := fNow;
          qryExcSQL.ExecSQL;
          fCommit;
        End
        Else
          fRollback;
        {$ENDIF}

      Except
        fRollback;
      End;

      qryGaiola.Next;
    End;

  Finally
    If fInTransaction Then
      fRollBack;
    FreeAndNil(qryGaiola);
    FreeAndNil(qryExcSQL);
  End;
End;

function fCfgCor(strNomCam: String): String;
  Var
    qryCorCfg: TUniQuery;
Begin
  qryCorCfg := fCriaQuery(Nil);

  Try
    qryCorCfg.Close;
    qryCorCfg.SQL.Clear;
    qryCorCfg.SQL.Add(' SELECT * FROM CORCFG WHERE CFG_CODEMP = :CODEMP AND CFG_STATUS = "A"');
    qryCorCfg.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCorCfg.Open;

    If qryCorCfg.IsEmpty Then
      Result := ''
    Else
      Result := qryCorCfg.FieldByName(strNomCam).AsString;
  Finally
    FreeAndNil(qryCorCfg);
  End;
End;

function fNomTab(strEspDoc: String): String;
Begin
  If (strEspDoc = 'PD') Or (strEspDoc = 'OR') Then
    Result := 'FATGOR'
  Else
    Result := 'MOVGER';
End;

function fGetNumObjetoTransportadora(strCodTra: String): String;
  Var
    qryCodTra: TUniQuery;
    strObjDig: String;
Begin
  qryCodTra := fCriaQuery;

  Try
    qryCodTra.Close;
    qryCodTra.SQL.Clear;
    qryCodTra.SQL.Add(' SELECT AUTOINCREM,         ');
    qryCodTra.SQL.Add('        TRA_CODTRA,         ');
    qryCodTra.SQL.Add('        TRA_SEQINI,         ');
    qryCodTra.SQL.Add('        TRA_SEQFIN,         ');
    qryCodTra.SQL.Add('        TRA_SEQATU,         ');
    qryCodTra.SQL.Add('        TRA_SIGLAS,         ');
    qryCodTra.SQL.Add('        TRA_SIGLAP          ');
    qryCodTra.SQL.Add(' FROM CADTRA                ');
    qryCodTra.SQL.Add(' WHERE TRA_CODTRA = :CODTRA ');
    qryCodTra.SQL.Add(' FOR UPDATE                 ');

    qryCodTra.ParamByName('CODTRA').AsString := strCodTra;
    qryCodTra.Open;

    //Se o ultimo uso foi o numero final, vai somar mais 1 e ficar maior que o ultimo, ou seja acabou a faixa.
    If qryCodTra.FieldByName('TRA_SEQATU').AsString > qryCodTra.FieldByName('TRA_SEQFIN').AsString Then
    Begin
      Result := '';
      Raise Exception.Create('Não Existe númeração disponível para gerar o número do objeto!');
    End;

    Result := qryCodTra.FieldByName('TRA_SIGLAS').AsString +
              qryCodTra.FieldByName('TRA_SEQATU').AsString + ' ' +
              qryCodTra.FieldByName('TRA_SIGLAP').AsString;

    strObjDig := fObjComDigitoCorreios(Result);
    Result := ReplaceStr(Result, ' ', '');

    qryCodTra.Close;
    qryCodTra.SQL.Clear;
    qryCodTra.SQL.Add(' UPDATE CADTRA SET TRA_SEQATU = RIGHT(CONCAT("00000000", TRA_SEQATU + 1), 8) ');
    qryCodTra.SQL.Add(' WHERE TRA_CODTRA = :CODTRA ');
    qryCodTra.ParamByName('CODTRA').AsString := strCodTra;
    qryCodTra.ExecSQL;

    qryCodTra.Close;
    qryCodTra.SQL.Clear;
    qryCodTra.SQL.Add(' INSERT INTO COROBJ(AUTOINCREM, COB_NUMOBJ, COB_OBJDIG, COB_STATUS, COB_CODTRA) ');
    qryCodTra.SQL.Add('             VALUES(:AUTINC, :NUMOBJ, :OBJDIG, :STATUS, :CODTRA) ');

    qryCodTra.ParamByName('AUTINC').AsString := fRetAutoIncrem('COROBJ', VS_strCodEmp);
    qryCodTra.ParamByName('NUMOBJ').AsString := Result;
    qryCodTra.ParamByName('OBJDIG').AsString := strObjDig;
    qryCodTra.ParamByName('STATUS').AsString := 'U';
    qryCodTra.ParamByName('CODTRA').AsString := strCodTra;
    qryCodTra.ExecSQL;

  Finally
    FreeAndNil(qryCodTra);
  End;
End;

function fGeraData2D(strNumDoc, strEspDoc, strNumObj: String): String;
  Var
    qryDados: TUniQuery;
    strCepDes: String;

  function fValidadorCepDes: String;
    Var
      intSoma : Integer;
      intIndx : Integer;
  Begin
    intSoma := 0;
    For intIndx := 1 To Length(strCepDes) Do
      intSoma := intSoma + StrToIntDef(strCepDes[intIndx],0);

    intIndx := 0;
    While ((intSoma + intIndx) Mod 10 <> 0 ) Do
      Inc(intIndx);

    Result := IntToStr((intSoma + intIndx) - intSoma);
  End;

Begin
  qryDados := fCriaQuery;

  Try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add( fSQLDespacho(False, fNomTab(strEspDoc), 'C', strNumDoc, strEspDoc, False, True) );

    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.Open;

    strCepDes := fPadL(ReplaceStr(qryDados.FieldByName('CEPCLI').AsString, '-', '') , 8, '0');

    Result := strCepDes;
    Result := Result + '00000';
    Result := Result + fPadL(ReplaceStr(qryDados.FieldByName('CEPEMP').AsString, '-', '') , 8, '0');
    Result := Result + '00000';
    Result := Result + fValidadorCepDes;
    Result := Result + '51';
    Result := Result + fCampoTabela('COB_OBJDIG', 'COROBJ', ['COB_NUMOBJ'], [strNumObj]);
    Result := Result + fCfgSis('SERADI', varString);
    Result := Result + fPadL(fCampoTabela('CFG_NUMCAR', 'CORCFG', ['CFG_CODEMP', 'CFG_STATUS'], [VS_strCodEmp, 'A']), 10, '0');
    Result := Result + fObjetoToSerCor(strNumObj);
    Result := Result + '00';
    Result := Result + '00000';
    Result := Result + fPadL('', 20);
    Result := Result + '00000';
    Result := Result + '000000000000';
    Result := Result + '-00.000000';
    Result := Result + '-00.000000|';
  Finally
    FreeAndNil(qryDados);
  End;
End;

procedure pAtualizaDadosPrePostagem(const strCodPLP, strXmlEnv, strXmlRet: String; const intSeqCor: Integer);
  var
    qryCorPlp: TUniQuery;
begin
  qryCorPlp := fCriaQuery;
  Try
    qryCorPlp.SQL.Add('UPDATE CORPLP ');
    qryCorPlp.SQL.Add('  SET PLP_DTAENV = :DTAENV, ');
    qryCorPlp.SQL.Add('      PLP_HRAENV = :HRAENV, ');
    qryCorPlp.SQL.Add('      PLP_XMLENV = :XMLENV, ');
    If Not fEmptyStr(strXmlRet) Then
      qryCorPlp.SQL.Add('      PLP_XMLRET = :XMLRET, ');
    qryCorPlp.SQL.Add('      PLP_SEQCOR = :SEQCOR  ');
    qryCorPlp.SQL.Add('WHERE PLP_CODIGO = :CODIGO  ');
    qryCorPlp.SQL.Add('  AND PLP_CODEMP = :CODEMP  ');

    qryCorPlp.ParamByName('DTAENV').AsDateTime := fNow;
    qryCorPlp.ParamByName('HRAENV').AsDateTime := fNow;
    qryCorPlp.ParamByName('XMLENV').AsString   := strXmlEnv;
    If Not fEmptyStr(strXmlRet) Then
      qryCorPlp.ParamByName('XMLRET').AsString   := strXmlRet;
    qryCorPlp.ParamByName('SEQCOR').AsInteger  := intSeqCor;
    qryCorPlp.ParamByName('CODIGO').AsString   := strCodPLP;
    qryCorPlp.ParamByName('CODEMP').AsString   := VS_strCodEmp;

    qryCorPlp.ExecSQL;
  Finally
    FreeAndNil(qryCorPlp);
  End;
end;

function fGravaCorObj(strCodSer, strNumObjSemDig, strNumObjComDig: String): Boolean;
  var
    qryCorObj: TUniQuery;
begin
  Result := False;
  qryCorObj := fCriaQuery;
  try
    try
      qryCorObj.SQL.Add('INSERT INTO COROBJ( ');
      qryCorObj.SQL.Add('  AUTOINCREM, ');
      qryCorObj.SQL.Add('  COB_CODSER, ');
      qryCorObj.SQL.Add('  COB_NUMOBJ, ');
      qryCorObj.SQL.Add('  COB_OBJDIG, ');
      qryCorObj.SQL.Add('  COB_STATUS) ');
      qryCorObj.SQL.Add('VALUES( ');
      qryCorObj.SQL.Add('  :AUTINC, ');
      qryCorObj.SQL.Add('  :CODSER, ');
      qryCorObj.SQL.Add('  :NUMOBJ, ');
      qryCorObj.SQL.Add('  :OBJDIG, ');
      qryCorObj.SQL.Add('  :STATUS) ');

      qryCorObj.ParamByName('AUTINC').AsString := fRetAutoIncrem('COROBJ', VS_strCodEmp);
      qryCorObj.ParamByName('CODSER').AsString := strCodSer;
      qryCorObj.ParamByName('NUMOBJ').AsString := strNumObjSemDig;
      qryCorObj.ParamByName('OBJDIG').AsString := strNumObjComDig;
      qryCorObj.ParamByName('STATUS').AsString := 'D'; //Disponível / Utilizada
      qryCorObj.ExecSQL;

      Result := True;
    except
      raise;
    end;
  finally
    FreeAndNil(qryCorObj);
  end;
end;

//adiciona o dígito verificador no objeto, ex: AB03422813BR > AB034228137BR
function fObjComDigitoCorreios(const strObjSemDig: String): String;
  const
    intMultpli: Array[0..7] Of Integer = (8, 6, 4, 2, 3, 5, 9, 7);
  var
    strPrefixo, strSufixo, strNumero, strDigito: String;
    intSoma, intResto, intIndex: Integer;
Begin
  strPrefixo := Trim(Copy(strObjSemDig, 1, 2));
  strNumero  := fPadL(Trim(Copy(strObjSemDig, 3, 8)), 8, '0');
  strSufixo  := Trim(Copy(strObjSemDig, 11, Length(strObjSemDig)));
  intSoma    := 0;

  for intIndex := 0 to 7 do
    intSoma := intSoma + (StrToInt(strNumero[intIndex +1]) * intMultpli[intIndex]);

  intResto := intSoma mod 11;

  if intResto = 0 then
    strDigito := '5'
  else If intResto = 1 then
    strDigito := '0'
  else
    strDigito := IntToStr(11 - intResto);

  Result := strPrefixo + strNumero + strDigito + strSufixo;
end;

//remove o dígito verificador do objeto, ex: AB034228137BR > AB03422813BR
function fObjSemDigitoCorreios(const strObjComDig: String): String;
begin
  If fEmptyStr(strObjComDig) Then
    Exit;

  Result := Copy(strObjComDig, 1, Length(strObjComDig) -3) + RightStr(strObjComDig, 2);
end;

//traduz do código de serviço do correio interno para o código do serviço no correio
function fSerCorToCodCorreio(strSerCor: String): String;
begin
  Result := fCampoTabela('CSE_CODSER', 'CORSER', ['CSE_CODIGO'], [strSerCor]);
end;

//retorna o codigo do serviço do correio através do núumero do objeto
function fObjetoToSerCor(strNumObj: String): String;
Begin
  Result := fCampoTabela('CSE_CODSER', 'COROBJ INNER JOIN CORSER ON CSE_CODIGO = COB_CODSER', ['COB_NUMOBJ'], [strNumObj]);
End;

function fRetDescricaoServicoCorreio(strCodSer: String): String;
begin
  Result := fCampoTabela('CSE_DESCRI', 'CORSER', ['CSE_CODSER'], [strCodSer]);
end;

end.
