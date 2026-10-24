unit untDocPedidoCompra;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untFuncoesSimples, untZClient, untImagemBase64, Uni;

type
  TLeDocumentoPedidoCompra = Class(TLeDocumento)
  Private

    cdsMovGag,
    cdsMovGad: TZClient;
    SQL: TStringLIst;

    Function fSQLMovPcmGer: String;

    Function fSQLMovPcmDet: String;
    Function fGetEmpresaPedido: String;

    Function fInsereClientPcmGer: Boolean;
    Function fInsereClientPcmDet: Boolean;
    function fRequisicoesCompra: String;

  Public

    Function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;
    Procedure pSetaParametrosCadFor; override;

  protected
    procedure pSetaParametrosCadcli; override;
  End;


implementation

{ TLeDocumentoPedidoCompra }


function TLeDocumentoPedidoCompra.fGetEmpresaPedido: String;
var qryConsulta: TUniQuery;
Begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT PCG_EMPDES FROM PCMGER');
    qryConsulta.SQL.Add(' WHERE PCG_CODEMP = "'+recDocume.strCodEmp+'"');
    qryConsulta.SQL.Add('   AND PCG_NUMPED = "'+recDocume.strNumDoc+'"');
    qryConsulta.SQL.Add('   AND PCG_ESPDOC = "'+recDocume.strEspDoc+'"');
    qryConsulta.Open;
    Result := recDocume.strCodEmp; 
    If Not  fEmptyStr(qryConsulta.FieldByName('PCG_EMPDES').AsString) Then
      Result := qryConsulta.FieldByName('PCG_EMPDES').AsString;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

function TLeDocumentoPedidoCompra.fInsereClientPcmDet: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLMovPcmDet);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet := arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name     := 'frxMovdet';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovdet';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NUMPED').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientPcmDet');

end;

function TLeDocumentoPedidoCompra.fInsereClientPcmGer: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLMovPcmGer);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet :=   arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name     := 'frxMovger';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovger';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NUMPED').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientPcmGer');
end;

function TLeDocumentoPedidoCompra.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
begin
  Try
    Result := True;

    Result    := Result And fInsereClientPcmDet;
    cdsMovGad := arrClients[0].cdsDados;

    Result    := Result And fInsereClientPcmGer;
    cdsMovGag := arrClients[1].cdsDados;

    If Not Result Then
      Exit;

    Result := Result And fInsereClientEmpresa;

//    Result := Result And fInsereClientEnderecoEntrega('', '', '');

//    Result := Result And fInsereClientCliente;

    Result := Result And fInsereClientFornecedor;

    Result := Result And fPreparaImpressaoDocumentos;

//    Result := Result And fMarcarSeparacaoComoImpresso;

    If Result Then pSetaOrdenacao;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;


end;

function TLeDocumentoPedidoCompra.fSQLMovPcmDet: String;
Var
  strUniPcg: String;
begin
  strUniPcg := fCfgSis('UNIPCG', VarString);

  If not assigned(SQL) then
    SQL := TStringList.Create;

  SQL.Add('SET @TABPRF := fCfgSis("CFG_TABPRF", :CODEMP);');
  SQL.Add('SET @DARROR := fCfgSis("CFG_DARROR", :CODEMP);');
  SQL.Add('SET @CODFIT := fCfgSis("CFG_CODFIT", :CODEMP);');
  SQL.Add('SET @TABPRF := fCfgSis("CFG_TABPRF", :CODEMP);');
  SQL.Add('SET @SEQDET := 0; ');
  SQL.Add('SET SESSION group_concat_max_len = 65535;  ');


  SQL.Add('');

  SQL.Add('SELECT * FROM (');
  SQL.Add('SELECT');
  SQL.Add('  PCD_CODITE AS CODITE,');
  SQL.Add('  PCD_DESITE AS DESITE,');
  SQL.Add('  PCD_ALQICM AS ALQICM,');
  SQL.Add('  C.ITE_REFERE AS REFERE,');
  SQL.Add('  C.ITE_CODBAR AS CODBAR,');
  SQL.Add('  ITE_LOCFIS AS LOCFIS,');
  SQL.Add('  ITE_LOCSUP AS LOCSUP,');
  SQL.Add('  PCD_DTAENT AS DTAENT,');
  SQL.Add('  MAR_DESMAR AS DESMAR,');
  SQL.Add('  UC.UNI_SIGUNI AS SIGUNI,');
  SQL.Add('  UT.UNI_SIGUNI AS SIGEMB,');
  SQL.Add('  IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = PCD_CODITE AND BAR_CODFOR = PCD_CODFOR AND BAR_EMBALA = PCD_EMBALA ORDER BY BAR_COMPRA DESC LIMIT 1), C.ITE_EMBALA) AS EMBALA, ');

  SQL.Add('  C.ITE_CODGRU AS CODGRU,');
  SQL.Add('  GRU_DESGRU AS DESGRU,');
  SQL.Add('  GRU_DRELIN AS DRELIN,');
  SQL.Add('  PCMGER.PCG_CODEVE AS CODEVE,');
  SQL.Add('  CADEVE.EVE_DESEVE AS DESEVE,');


  SQL.Add('  PCD_DESUNI AS DESUNI,');
  SQL.Add('  PCD_DESUN2 AS DESUN2,');
  SQL.Add('  PCD_DESUN3 AS DESUN3,');
  SQL.Add('  PCD_DESUN4 AS DESUN4,');
  SQL.Add('  PCD_DESUN5 AS DESUN5,');
  SQL.Add('  PCD_DESUN6 AS DESUN6,');

  SQL.Add('  IFNULL((SELECT SUM(CTP_VALDUP * -1) CTP_VALDUP ');
  SQL.Add('           FROM CADPAG ');
  SQL.Add('          WHERE CTP_VALDUP < 0 ');
  SQL.Add('            AND CTP_DTAPAG IS NULL ');
  SQL.Add('            AND CTP_CODFOR = PCG_CODFOR), 0) AS CREFOR,');

  SQL.Add('  @QTDORI := (PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ') AS QTDORI,');
  SQL.Add('  @QTDITE := CAST((@QTDORI' +
    IfThen(recDocume.blnMltCom,'/ IF(IFNULL(C.ITE_MLTCOM, 0) > 0, C.ITE_MLTCOM, 1)','') + ') AS DECIMAL(18,4)) AS QTDITE,');
  SQL.Add('  @UNITAR := (PCMDET.PCD_UNITAR' +
    IfThen(recDocume.blnMltCom,'* IF(IFNULL(C.ITE_MLTCOM, 0) > 0, C.ITE_MLTCOM, 1)','') + ') AS UNITAR,');
  SQL.Add('  @DESCON := (');
  SQL.Add('    1 - ' + fSQLFatorDesUni +
          ' * (1 - PCD_DESUN2 / 100) * (1 - PCD_DESUN3 / 100) * (1 - PCD_DESUN4 / 100)' +
          ' * (1 - PCD_DESUN5 / 100) * (1 - PCD_DESUN6 / 100) * ' + fSQLFatorDesAdi(strUniPcg));
  SQL.Add('  ) * 100 AS DESCON,');
  SQL.Add('  PCD_ALQCBS AS DALCBS,');
  SQL.Add('  PCD_ALQIBS AS DALQIB,');
  SQL.Add('  PCD_ALQ_IS AS DALQIS,');
  SQL.Add('  IFNULL(ROUND(((PCD_VALCBS * 100 / NULLIF(PCD_ALQCBS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * @QTDORI AS BASCBS, ');
  SQL.Add('  IFNULL(ROUND(((PCD_VALIBS * 100 / NULLIF(PCD_ALQIBS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * @QTDORI AS BASIBS, ');
  SQL.Add('  IFNULL(ROUND(((PCD_VAL_IS * 100 / NULLIF(PCD_ALQ_IS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * @QTDORI AS BAS_IS, ');
  SQL.Add('  ROUND(IFNULL(PCD_VALCBS,0) / PCMDET.PCD_QTDITE, 4) *   @QTDORI  AS DVLCBS, ');
  SQL.Add('  ROUND(IFNULL(PCD_VALIBS,0) / PCMDET.PCD_QTDITE, 4) *   @QTDORI  AS DVLIBS, ');
  SQL.Add('  ROUND(IFNULL(PCD_VAL_IS,0) / PCMDET.PCD_QTDITE, 4) *   @QTDORI  AS DVL_IS, ');

  SQL.Add('  @UNILIQ := PCD_TOTITE / @QTDITE AS UNILIQ,');
  SQL.Add('  PCMDET.PCD_TOTITE ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_TOTBAI','') + ' AS TOTITE,');
  SQL.Add('  PCD_PERIPI AS PERIPI,');
  SQL.Add('  PCMDET.PCD_TOTIPI ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_IPIBAI','') + ' AS TOTIPI,');
  SQL.Add('  PCD_PERSUB AS PERSUB,');
  SQL.Add('  PCMDET.PCD_TOTSUB ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_SUBBAI','') + ' AS TOTSUB,');
  SQL.Add(IfThen(recDocume.blnQtdPen,'PCMDET.PCD_TOTDAR - IFNULL(PCMDET.PCD_DARBAI,0)','0') + ' AS TOTDAR,');
  SQL.Add('  PCMDET.PCD_SUBFCP ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_FCPBAI','') + ' AS SUBFCP,');
  SQL.Add(IfThen(recDocume.blnZonaFranca,' (PCMDET.PCD_VALICM / PCMDET.PCD_QTDITE) * @QTDORI','0') + ' AS ICMDES,');
  SQL.Add(IfThen(recDocume.blnZonaFranca,' (PCMDET.PCD_DESPIS / PCMDET.PCD_QTDITE) * @QTDORI','0') + ' AS DESPIS,');
  SQL.Add('  (@QTDORI   * C.ITE_PESOIT) AS PESBRU, ');
  SQL.Add('  PCG_TIPFAB AS TIPFAB,');

  SQL.Add('  CASE');
  SQL.Add('    WHEN PCG_TIPFAB = "P" THEN C.ITE_CODFAB');
  SQL.Add('    WHEN @CODFIT = "S" THEN C.ITE_CODFAB');
  SQL.Add('    WHEN @TABPRF = "S" THEN IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB)');
  SQL.Add('  ELSE IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF)');
  SQL.Add('  END AS CODFAB,');

  SQL.Add('  CASE');
  SQL.Add('    WHEN PCG_TIPFAB = "P" THEN CAST(CONCAT(C.ITE_APLICA," / ", C.ITE_CODFAB)AS CHAR(255))');
  SQL.Add('    WHEN @CODFIT = "S" THEN CAST(CONCAT(C.ITE_APLICA," / ", C.ITE_CODFAB)AS CHAR(255))');
  SQL.Add('    WHEN @TABPRF = "S" THEN CAST(CONCAT(C.ITE_APLICA," / ", IF(IFNULL(F.ITE_CODFAB,"") = "", C.ITE_CODFAB, F.ITE_CODFAB) )AS CHAR(255))');
  SQL.Add('  ELSE CAST(CONCAT(C.ITE_APLICA," / ", IF(IFNULL(F.ITE_CODITF,"") = "", C.ITE_CODFAB, F.ITE_CODITF) )AS CHAR(255))');
  SQL.Add('  END AS APLFAB,');

  SQL.Add('  @SEQDET :=  IFNULL(@SEQDET,0) + 1 AS SEQDET,');
  SQL.Add('  C.ITE_CLAIPI AS CLAIPI,');
  SQL.Add('  IF(IFNULL(C.ITE_MLTCOM, 0) > 0, C.ITE_MLTCOM, 1) AS MLTCOM,');
  SQL.Add('(SELECT REP_RAZSOC FROM REPFOR WHERE REP_CODFOR = PCG_CODFOR LIMIT 1) REPRAZ, ');
  SQL.Add('(SELECT REP_FONE01 FROM REPFOR WHERE REP_CODFOR = PCG_CODFOR LIMIT 1) REPFON, ');
  SQL.Add('(SELECT REP_NUMCEL FROM REPFOR WHERE REP_CODFOR = PCG_CODFOR LIMIT 1) REPCEL, ');
  SQL.Add('(SELECT REP_EMAIL_ FROM REPFOR WHERE REP_CODFOR = PCG_CODFOR LIMIT 1) REPMAI, ');

  SQL.Add('ITE_EXPALT AS EXPALT,');
  SQL.Add('ITE_EXPLAR AS EXPLAR,');
  SQL.Add('ITE_EXPPRO AS EXPPRO,');
  SQL.Add(' @QTDORI * (ITE_EXPALT * ITE_EXPLAR * ITE_EXPPRO) AS ICUBAG,');


  SQL.Add('@TIPFOR:=IF((IFNULL(FOR_I_E_S_, "") = "") OR (FOR_CGCCPF <> 1),');
  SQL.Add('               "PEF", /* PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)*/');
  SQL.Add('IF(FOR_MATREV = "I",');
  SQL.Add('                 IF(FOR_SIMPAU = "S", "PSI", "PES"), /* PEJ - PESSOA JURIDICA (INDUSTRIA) */');
  SQL.Add('                 IF(FOR_MATREV = "I", "PEJ", "PER"))) AS TIPFOR,  /*PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO)*/');

  SQL.Add('@CST := CASE @TIPFOR');
  SQL.Add('    WHEN "PEF" THEN ABF_CODSIT_ENT_PEF');
  SQL.Add('    WHEN "PEJ" THEN ABF_CODSIT_ENT_PEJ');
  SQL.Add('    WHEN "PER" THEN ABF_CODSIT_ENT_PER');
  SQL.Add('    WHEN "PES" THEN ABF_CODSIT_ENT_PES');
  SQL.Add('    WHEN "PSI" THEN ABF_CODSIT_ENT_PSI');
  SQL.Add('  END AS CSTICM,');

  SQL.Add('@IMPOSTO := (PCD_TOTIPI / @QTDITE) + ');
  SQL.Add('            (PCD_TOTSUB / @QTDITE) + ');
  SQL.Add('            (PCD_SUBFCP / @QTDITE) AS IMPOSTO, ');
  SQL.Add('@UNIIMP := ROUND(@IMPOSTO + @UNILIQ,2) AS UNIIMP, ');
  SQL.Add('G.ITE_SUBSTI AS SUBSTI ');

  SQL.Add('FROM');
  SQL.Add('  PCMDET');
  SQL.Add('  JOIN PCMGER');
  SQL.Add('    ON (');
  SQL.Add('      PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED');
  SQL.Add('      AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC');
  SQL.Add('      AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP');
  SQL.Add('      AND PCMDET.PCD_NUMCTN = PCMGER.PCG_NUMCTN');
  SQL.Add('    )');
  SQL.Add('  INNER JOIN CADITE C');
  SQL.Add('    ON C.ITE_CODITE = PCD_CODITE');
  SQL.Add('  LEFT JOIN DESSIT DS');
  SQL.Add('    ON DS.ITE_CODITE = PCD_CODITE');
  SQL.Add('  INNER JOIN ITEGER G');
  SQL.Add('    ON G.ITE_CODITE = C.ITE_CODITE');
  SQL.Add('    AND G.ITE_CODEMP = PCD_CODEMP');
  SQL.Add('  INNER JOIN CADMAR M');
  SQL.Add('    ON C.ITE_CODMAR = M.MAR_CODMAR');
  SQL.Add('  LEFT JOIN CADUNI UC');
  SQL.Add('    ON PCMDET.PCD_CODUNI = UC.UNI_CODUNI');
  SQL.Add('  LEFT JOIN ITEFOR F');
  SQL.Add('    ON F.ITE_CODITE = PCMDET.PCD_CODITE');
  SQL.Add('    AND F.ITE_CODFOR = PCMDET.PCD_CODFOR');
  SQL.Add('    AND IF(');
  SQL.Add('      @TABPRF = "S",');
  SQL.Add('      (SELECT');
  SQL.Add('        COUNT(*)');
  SQL.Add('      FROM');
  SQL.Add('        TABPRE');
  SQL.Add('      WHERE F.ITE_CODTAB = TAB_CODTAB');
  SQL.Add('        AND TAB_ATICMP = "S") > 0,');
  SQL.Add('      F.AUTOINCREM =');
  SQL.Add('      (SELECT');
  SQL.Add('        MAX(FF.AUTOINCREM)');
  SQL.Add('      FROM');
  SQL.Add('        ITEFOR FF');
  SQL.Add('      WHERE FF.ITE_CODITE = PCMDET.PCD_CODITE');
  SQL.Add('        AND FF.ITE_CODFOR = PCMDET.PCD_CODFOR)');
  SQL.Add('    )    ');
  SQL.Add('    ');


  SQL.Add('LEFT JOIN CADFOR ON CADFOR.FOR_CODFOR = PCMGER.PCG_CODFOR');
  SQL.Add('LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID');
  SQL.Add('LEFT JOIN ABFICM ON ABF_ESTADO = CID_ESTADO');
  SQL.Add('AND ABF_CODABF = IF((fCfgSis("CFG_TIPABF",PCMGER.PCG_CODEMP) = 1),C.ITE_CODABF,G.ITE_CODABF)');
  SQL.Add('LEFT JOIN CADUNI UT ON UT.UNI_CODUNI = C.ITE_UNICOM');
  SQL.Add('LEFT JOIN CADGRU ON GRU_CODGRU = C.ITE_CODGRU');
  SQL.Add('LEFT JOIN CADEVE ON CADEVE.EVE_CODEVE = PCMGER.PCG_CODEVE');

  SQL.Add(' WHERE PCD_NUMPED = :NUMPED ');
  SQL.Add(' AND PCD_CODEMP = :CODEMP');
  SQL.Add(' AND PCD_ESPDOC = :ESPDOC');
  SQL.Add(') TMP ');
  If recDocume.blnQtdPen tHEN
    SQL.Add(' WHERE QTDITE > 0');

  Result := SQL.Text;
end;

function TLeDocumentoPedidoCompra.fSQLMovPcmGer: String;
Var
  strPatCab: String;
begin
  strPatCab := fCfgSis('PATCAB', varString, fGetEmpresaPedido);

  If not assigned(SQL) then
    SQL := TStringList.Create;

  SQL.Clear;
  SQL.Add('SET @MSGPCM = fCfgSis(''CFG_MSGPCM'',:CODEMP);');
  SQL.Add('SET @MSGPC2 = fCfgSis(''CFG_MSGPC2'',:CODEMP);');
  SQL.Add('SET @LITGAL = IF(fCfgSis(''CFG_LITGAL'',:CODEMP) = "L",1,3.600);');
  SQL.Add('SET @TITENS = 0.00; ');
  SQL.Add('SET @TIPI   = 0.00; ');
  SQL.Add('SET @TSUB   = 0.00; ');
  SQL.Add('SET @TSBFCP = 0.00; ');
  SQL.Add('SET @TDES   = 0.00; ');

  SQL.Add('');

  SQL.Add('SELECT  ');
  SQL.Add('  TABAUX.*, ');
  SQL.Add('  CAST((IFNULL(@TITENS, 0) + IFNULL(@TIPI, 0) + IFNULL(@TSUB, 0) + IFNULL(@TSBFCP, 0) + IFNULL(@TDES, 0) + IFNULL(PCG_VALFRE, 0) + IFNULL(DESACE, 0)) AS DECIMAL(18,4)) AS TOTGER');
  SQL.Add(' FROM ( ');
  SQL.Add('SELECT');
  SQL.Add('  PCG_CODFOR AS CODFOR,');
  SQL.Add('  PCG_PEDMLJ AS PEDMLJ,');
  SQL.Add('  PCG_EMPDES AS EMPDES,');
  SQL.Add('  PCG_NUMPED AS NUMPED,');
  SQL.Add('  PCG_ESPDOC AS ESPDOC,');
  SQL.Add('  FOR_NOMFOR AS NOMFOR,');
  SQL.Add('  FOR_SUFRAM AS SUFRAM,');
  SQL.Add('  FOR_F_A_X_ AS FAXFOR,');
  SQL.Add('  PCG_CONPAG AS CONPAG,');
  SQL.Add('  FOR_CONTAT AS CONTAT,');
  SQL.Add('  PCG_PEDVEN AS PEDVEN,');
  // CBS / IBS / IS do pedido e suas bases, somados dos itens (respeitam a quantidade pendente)
  SQL.Add('  SUM(ROUND(IFNULL(PCMDET.PCD_VALCBS, 0) / PCMDET.PCD_QTDITE, 4) * (PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ')) AS VALCBS,');
  SQL.Add('  SUM(ROUND(IFNULL(PCMDET.PCD_VALIBS, 0) / PCMDET.PCD_QTDITE, 4) * (PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ')) AS VALIBS,');
  SQL.Add('  SUM(ROUND(IFNULL(PCMDET.PCD_VAL_IS, 0) / PCMDET.PCD_QTDITE, 4) * (PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ')) AS VAL_IS,');
  SQL.Add('  SUM(IFNULL(ROUND(((PCMDET.PCD_VALCBS * 100 / NULLIF(PCMDET.PCD_ALQCBS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * (PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ')) AS TBSCBS,');
  SQL.Add('  SUM(IFNULL(ROUND(((PCMDET.PCD_VALIBS * 100 / NULLIF(PCMDET.PCD_ALQIBS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * (PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ')) AS TBSIBS,');
  SQL.Add('  SUM(IFNULL(ROUND(((PCMDET.PCD_VAL_IS * 100 / NULLIF(PCMDET.PCD_ALQ_IS, 0)) / PCMDET.PCD_QTDITE), 4), 0) * (PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ')) AS TBS_IS,');
  // S = soma CBS / IBS / IS ao total (fSomarNovosImpostosDaReformaAoValorContabil); os layouts condicionam a reforma a ele
  SQL.Add('  ' + QuotedStr(IfThen(fSomarNovosImpostosDaReformaAoValorContabil, 'S', 'N')) + ' AS SOMREF,');
  SQL.Add('  PCG_CODCMP AS CODCMP,');
  SQL.Add('  PCG_ORDCON AS ORDCON,');
  SQL.Add('  IFNULL((SELECT SUM(CTP_VALDUP * -1) CTP_VALDUP ');
  SQL.Add('           FROM CADPAG ');
  SQL.Add('          WHERE CTP_VALDUP < 0 ');
  SQL.Add('            AND CTP_DTAPAG IS NULL ');
  SQL.Add('            AND CTP_CODFOR = PCG_CODFOR), 0) AS CREFOR,');
  SQL.Add('  CAST("'+recDocume.strDtaVen+'" AS CHAR(255)) AS VENCIM,');
  SQL.Add('  IF(');
  SQL.Add('    PCG_CODCMP IS NULL,');
  SQL.Add('    PCG_COMPRA,');
  SQL.Add('    OPE_NOMOPE');
  SQL.Add('  ) AS COMPRA,');
  SQL.Add('  PCG_ATENCA AS ATENCA,');
  SQL.Add('  PCG_DTAENT AS DTAENT,');
  SQL.Add('  PCG_DTAFAT AS DTAFAT,');
  SQL.Add('  fCfgSis (''CFG_FATPED'', PCG_CODEMP) AS FATPED,');
  SQL.Add('  PCG_TIPFRE AS TIPFRE,');
  SQL.Add('  IF(PCG_TIPFRE = "1", "CIF", "FOB") AS DETIPF,');

  SQL.Add('IF(PCG_ESPDOC = "PD",');
  SQL.Add('IF((SELECT @MSGAPD := TRIM(SIS_VALCFG) FROM CFGSIS WHERE SIS_CODCFG = "CFG_MSGAPD" AND SIS_CODEMP = IFNULL(PCG_EMPDES, PCG_CODEMP)) = "",');
  SQL.Add('     "FAVOR CONFIRMAR O RECEBIMENTO DO PEDIDO - MENCIONAR O NÚMERO DO PEDIDO NA NOTA FISCAL.", @MSGAPD),');
  SQL.Add('IF((SELECT @MSGAOR := TRIM(SIS_VALCFG) FROM CFGSIS WHERE SIS_CODCFG = "CFG_MSGAOR" AND SIS_CODEMP = IFNULL(PCG_EMPDES, PCG_CODEMP)) = "",');
  SQL.Add('     "FAVOR CONFIRMAR O RECEBIMENTO DO ORÇAMENTO - MENCIONAR O NÚMERO DO ORÇAMENTO NA NOTA FISCAL.", @MSGAOR))AS OBSERV, ');


  SQL.Add('  IF(');
  SQL.Add('    PCG_ESPDOC = "PD",');
  SQL.Add('    CONCAT(');
  SQL.Add('      "Pedido de Compra Nº: ",');
  SQL.Add('      PCG_NUMPED,');
  SQL.Add('      IF(');
  SQL.Add('        PCG_ORCORI <> "",');
  SQL.Add('        CONCAT(');
  SQL.Add('          "Ref. Orçamento de Compra Nº: ",');
  SQL.Add('          SUBSTRING(PCG_ORCORI, 1, 12),');
  SQL.Add('          "-",');
  SQL.Add('          SUBSTRING(PCG_ORCORI, 15, 3)');
  SQL.Add('        ),');
  SQL.Add('        ""');
  SQL.Add('      )');
  SQL.Add('    ),');
  SQL.Add('    CONCAT("Orçamento Nº: ", PCG_NUMPED)');
  SQL.Add('  ) AS PEDORC,');
  SQL.Add('  IF(');
  SQL.Add('    PCG_PEDBON = "S",');
  SQL.Add('    "Bonificação",');
  SQL.Add('    "Pedido de Compra"');
  SQL.Add('  ) as TITPEDORC,');
  SQL.Add('  PCG_VALFRE AS VALFRE,');
  SQL.Add('  PCG_DESACE AS DESACE,');
  SQL.Add('  PCG_NOMENT AS LOCENT,');
  SQL.Add('  PCG_ENDENT AS LOCEND,');
  SQL.Add('  PCG_CIDENT AS LOCCID,');
  SQL.Add('  PCG_CODCTA AS CODCTA,');
  SQL.Add('  CTA_DESCTA AS DESCTA,');
  SQL.Add('  PCG_CODTRA AS CODTRA,');
  SQL.Add('  TRANSPCID.CID_CODCID AS TRCCID, ');
  SQL.Add('  TRANSPCID.CID_ESTADO AS TRASUF, ');
  SQL.Add('  TRANSP.TRA_NOMTRA AS TRANOM,');
  SQL.Add('  TRANSP.TRA_ENDERE AS TRAENDE,');
  SQL.Add('  TRANSP.TRA_BAIRRO AS TRABAI,');
  SQL.Add('  TRANSP.TRA_FONE01 AS TRAFON,');
  SQL.Add('  TRANSP.TRA_F_A_X_ AS TRAFAX,');
  SQL.Add('  TRANSP.TRA_C_E_P_ AS TRACEP,');
  SQL.Add('  TRANSP.TRA_C_G_C_ TRACGC,');
  SQL.Add('  TRANSP.TRA_I_E_S_ TRAIES,');
  SQL.Add('   TRANSPCID.CID_NOMCID AS TRACID,');
  SQL.Add('  CONCAT(');
  SQL.Add('    TRANSPCID.CID_NOMCID,');
  SQL.Add('    " - ",');
  SQL.Add('    TRANSPCID.CID_ESTADO');
  SQL.Add('  ) AS TRACUF,');

  SQL.Add('  PCG_CODTRR AS CODTRE,');
  SQL.Add('  TRANSPRCID.CID_CODCID AS TRRCID, ');
  SQL.Add('  TRANSPRCID.CID_ESTADO AS TRRSUF, ');

  SQL.Add('  TRANSPR.TRA_NOMTRA AS TRRNOM,');
  SQL.Add('  TRANSPR.TRA_ENDERE AS TRRENDE,');
  SQL.Add('  TRANSPR.TRA_BAIRRO AS TRRBAI,');
  SQL.Add('  TRANSPR.TRA_FONE01 AS TRRFON,');
  SQL.Add('  TRANSPR.TRA_F_A_X_ AS TRRFAX,');
  SQL.Add('  TRANSPR.TRA_C_E_P_ AS TRRCEP,');
  SQL.Add('  TRANSPR.TRA_C_G_C_ TRRCGC,');
  SQL.Add('  TRANSPR.TRA_I_E_S_ TRRIES,');
  SQL.Add('  TRANSPRCID.CID_NOMCID AS TRRNCI, ');
  SQL.Add('  CONCAT(');
  SQL.Add('    TRANSPRCID.CID_NOMCID,');
  SQL.Add('    " - ",');
  SQL.Add('    TRANSPRCID.CID_ESTADO');
  SQL.Add('  ) AS TRRCUF,');
  SQL.Add('  CADOPE.OPE_E_MAIL AS OPEMAI,');
  SQL.Add('  CADOPE.OPE_FONE01 AS OPEFON,');
  SQL.Add('  CADOPE.OPE_RAMAL1 AS OPERAM,');
  SQL.Add('  CADOPE.OPE_NEXTEL AS OPENEX,');
  SQL.Add('  @MSGPCM AS MSGPCM,');
  SQL.Add('  @MSGPC2 AS MSGPC2,');
  SQL.Add('  CURRENT_DATE AS DTAATU,');
  SQL.Add('  CURRENT_TIME AS HRAATU,');
  SQL.Add('  PCG_OBS001 AS OBS001,');
  SQL.Add('  PCG_OBS002 AS OBS002,');
  SQL.Add('  PCG_OBS003 AS OBS003,');
  SQL.Add('  PCG_OBS004 AS OBS004,');
  SQL.Add('  PCG_OBS005 AS OBS005,');
  SQL.Add('  PCG_OBSPD1 AS OBSPD1,');
  SQL.Add('  PCG_OBSPD2 AS OBSPD2,');
  SQL.Add('  PCG_OBSPD3 AS OBSPD3,');
  SQL.Add('  PCG_DTAPED AS DTAPED,');
  SQL.Add('  COUNT(PCMDET.AUTOINCREM) AS CONITE,');
  SQL.Add('  @TITENS := SUM(');
  SQL.Add('  PCMDET.PCD_TOTITE ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_TOTBAI',''));
  SQL.Add('  ) AS TITENS,');
  SQL.Add('  @TIPI := SUM(');
  SQL.Add('  PCMDET.PCD_TOTIPI ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_IPIBAI',''));
  SQL.Add('  ) AS TIPI,');
  SQL.Add('  @TSUB := SUM(');
  SQL.Add('  PCMDET.PCD_TOTSUB ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_SUBBAI',''));
  SQL.Add('  ) AS TSUB,');
  SQL.Add('  @TSBFCP := SUM(');
  SQL.Add('  PCMDET.PCD_SUBFCP ' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_FCPBAI',''));
  SQL.Add('  ) AS TSBFCP,');
  SQL.Add('  @TDES := SUM(');
  SQL.Add('    (');
  SQL.Add('      PCMDET.PCD_VALICM / PCMDET.PCD_QTDITE');
  SQL.Add('    ) * (');
  SQL.Add('  PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI',''));
  SQL.Add('    )');
  SQL.Add('  ) AS TDES,');
  SQL.Add('  PCMGER.PCG_VALFRE AS PCG_VALFRE,' );
  {SQL.Add('  CAST((IFNULL(@TITENS, 0) + IFNULL(@TIPI, 0) + IFNULL(@TSUB, 0) + IFNULL(@TSBFCP, 0) + IFNULL(@TDES, 0) + IFNULL(PCG_VALFRE, 0)) AS DECIMAL(18,4)) AS TOTGER,'); }
  SQL.Add('  (SELECT');
  SQL.Add('    SUM(');
  SQL.Add('      IFNULL(');
  SQL.Add('        (');
  SQL.Add('          (');
  SQL.Add('  PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI',''));
  SQL.Add('          ) * CADUNI.UNI_PESLIT / @LITGAL');
  SQL.Add('        ),');
  SQL.Add('        0');
  SQL.Add('      )');
  SQL.Add('    )');
  SQL.Add('  FROM');
  SQL.Add('    PCMDET');
  SQL.Add('    JOIN CADITE');
  SQL.Add('      ON (');
  SQL.Add('        PCMDET.PCD_CODITE = CADITE.ITE_CODITE');
  SQL.Add('      )');
  SQL.Add('    JOIN CADUNI');
  SQL.Add('      ON (');
  SQL.Add('        PCMDET.PCD_CODUNI = CADUNI.UNI_CODUNI');
  SQL.Add('      )');
  SQL.Add('  WHERE IFNULL(CADUNI.UNI_KILLIT, "L") = "L"');
  SQL.Add('    AND PCMDET.PCD_NUMCTN = 0');
  SQL.Add('    AND PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED');
  SQL.Add('    AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC');
  SQL.Add('    AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP) AS TOTLIT,');
  SQL.Add('  (SELECT');
  SQL.Add('    SUM(');
  SQL.Add('      IFNULL(');
  SQL.Add('        (');
  SQL.Add('          (');
  SQL.Add('  PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') );
  SQL.Add('          ) * CADUNI.UNI_PESLIT / @LITGAL');
  SQL.Add('        ),');
  SQL.Add('        0');
  SQL.Add('      )');
  SQL.Add('    )');
  SQL.Add('  FROM');
  SQL.Add('    PCMDET');
  SQL.Add('    JOIN CADITE');
  SQL.Add('      ON (');
  SQL.Add('        PCMDET.PCD_CODITE = CADITE.ITE_CODITE');
  SQL.Add('      )');
  SQL.Add('    JOIN CADUNI');
  SQL.Add('      ON (');
  SQL.Add('        PCMDET.PCD_CODUNI = CADUNI.UNI_CODUNI');
  SQL.Add('      )');
  SQL.Add('  WHERE IFNULL(CADUNI.UNI_KILLIT, "L") = "K"');
  SQL.Add('    AND PCMDET.PCD_NUMCTN = 0');
  SQL.Add('    AND PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED');
  SQL.Add('    AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC');
  SQL.Add('    AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP) AS TOTKIL,');

  SQL.Add('SUM(IFNULL((PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI','') + ' * (ITE_EXPALT * ITE_EXPLAR * ITE_EXPPRO)),0)) AS TCUBAG,');

  SQL.Add('  SUM(');
  SQL.Add('    (');
  SQL.Add('      (');
  SQL.Add('  PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI',''));
  SQL.Add('      )');
  SQL.Add('    ) * C.ITE_PESOIT');
  SQL.Add('  ) AS TPESOI,');

  SQL.Add('   @FISJUR := CASE');
  SQL.Add('     WHEN FOR_CGCCPF = 1 THEN "J"');
  SQL.Add('     ELSE "F"');
  SQL.Add('   END AS FISJUR,');
  SQL.Add('  PCG_BASPIS BASPIS,');
  SQL.Add('  IF(PCG_BASPIS <> 0, (PCG_VALPIS / PCG_BASPIS) * 100, 0)  ALIPIS,');
  SQL.Add('  PCG_VALPIS VALPIS,');
  SQL.Add('  PCG_BASCOF BASCOF,');
  SQL.Add('  IF(PCG_BASCOF <> 0, (PCG_VALCOF / PCG_BASCOF) * 100, 0) ALICOF,');
  SQL.Add('  PCG_VALCOF VALCOF,');
  SQL.Add('  PCG_BASICM BASICM,');
  SQL.Add('  PCG_VALICM VALICM,');
  SQL.Add('  PCG_BASSUB BASSUB,');
  SQL.Add('  PCG_BASIPI BASIPI,');
  SQL.Add('  PCG_TOTDAR TOTDAR,');
  SQL.Add('  FOR_EMAIL_ AS FOREM1,');
  SQL.Add('  FOR_EMAIL2 AS FOREM2,');
  SQL.Add('  FOR_EMAIL3 AS FOREM3,');
  SQL.Add('  FOR_EMAPED AS FOREMP,');
  SQL.Add('  FOR_OBSERV AS FOROBS,');

  SQL.Add('  SUM(');
  SQL.Add('    (');
  SQL.Add('      (');
  SQL.Add('  PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI',''));
  SQL.Add('      )');
  SQL.Add('    ) * C.ITE_PESLIQ');
  SQL.Add('  ) AS TOPELQ,');
  SQL.Add('  PCMGER.PCG_MOEDA_ AS MOEDA,');


  SQL.Add('  SUM(');
  SQL.Add('  PCMDET.PCD_QTDITE' + IfThen(recDocume.blnQtdPen,'- PCMDET.PCD_QTDBAI',''));
  SQL.Add('  ) AS TQTDIT,');

  SQL.Add('REQCOD,');
  SQL.Add('REQVEN,');
  SQL.Add('REQCLI,');
  SQL.Add('REQITE,');
  SQL.Add('REQQTD, ');
  SQL.Add('REQCMP, ');

  SQL.Add(' CE.EMP_NOMEMP AS EMPNOM,  ');
  SQL.Add(' CE.EMP_NOMFAN AS EMPFAN,  ');
  SQL.Add(' CE.EMP_CODCID AS EMPCID,  ');
  SQL.Add(' CI.CID_NOMCID AS EMPCDD,  ');
  SQL.Add(' CI.CID_ESTADO AS EMPEST,  ');
  SQL.Add(' CONCAT(CE.EMP_ENDERE, ", ", CE.EMP_ENDNUM,IF(IFNULL(CE.EMP_ENDCMP, "") = "", "", CONCAT("  ", CE.EMP_ENDCMP))) AS EMPEDC, ');
  SQL.Add(' CE.EMP_ENDERE AS EMPEND,  ');
  SQL.Add(' CE.EMP_ENDNUM AS EMPNUM,  ');
  SQL.Add(' CE.EMP_BAIRRO AS EMPBAI,  ');
  SQL.Add(' CE.EMP_C_E_P_ AS EMPCED,  ');
  SQL.Add(' CE.EMP_FONE01 AS EMPF01,  ');
  SQL.Add(' CE.EMP_FONE02 AS EMPF02,  ');
  SQL.Add(' CE.EMP_ENDCMP AS EMPCOM,  ');
  SQL.Add(' CE.EMP_F_A_X_ AS EMPFAX,  ');
  SQL.Add(' CE.EMP_EMAIL_ AS EMPMAI,  ');
  SQL.Add(' CE.EMP_C_G_C_ AS EMPCGC,  ');
  SQL.Add(' CE.EMP_I_E_S_ AS EMPIES,  ');
  SQL.Add(' CE.EMP_EMAILV AS EMPILV,  ');
  SQL.Add(' IFNULL(FROM_BASE64(EI.EMP_IMGB64), "") AS EMPIMA, ');
  SQL.Add(' PCMGER.PCG_DESADI AS DESADI ');

  If FileExists(strPatCab) Then
    SQL.Add(', FROM_BASE64(' + fBase64FromFile(strPatCab).QuotedString('"') + ') AS PATCAB')
  else
    SQL.Add(', "" PATCAB');
  SQL.Add(', PCMGER.PCG_PEDBON AS PEDBON ');

  SQL.Add('FROM');
  SQL.Add('  PCMGER');
  SQL.Add(fRequisicoesCompra);
  SQL.Add('  INNER JOIN CADFOR');
  SQL.Add('    ON FOR_CODFOR = PCMGER.PCG_CODFOR');
  SQL.Add('  LEFT JOIN CADOPE');
  SQL.Add('    ON OPE_CODOPE = IF(');
  SQL.Add('      PCG_CODCMP IS NULL,');
  SQL.Add('      PCG_COMPRA,');
  SQL.Add('      PCG_CODCMP');
  SQL.Add('    )');
  //Transportadora
  SQL.Add('  LEFT JOIN CADTRA TRANSP ON TRANSP.TRA_CODTRA = PCG_CODTRA');
  SQL.Add('  LEFT JOIN CADCID TRANSPCID ON TRANSPCID.CID_CODCID = TRANSP.TRA_CODCID');
  SQL.Add('  LEFT JOIN CADTRA TRANSPR');
  SQL.Add('    ON TRANSPR.TRA_CODTRA = PCG_CODTRR');
  SQL.Add('  LEFT JOIN CADCID TRANSPRCID');
  SQL.Add('    ON TRANSPRCID.CID_CODCID = TRANSPR.TRA_CODCID');
  SQL.Add('  INNER JOIN PCMDET');
  SQL.Add('    ON PCMDET.PCD_NUMPED = PCMGER.PCG_NUMPED');
  SQL.Add('    AND PCMDET.PCD_ESPDOC = PCMGER.PCG_ESPDOC');
  SQL.Add('    AND PCMDET.PCD_CODEMP = PCMGER.PCG_CODEMP');
  SQL.Add('    AND PCMDET.PCD_NUMCTN = PCMGER.PCG_NUMCTN');
  SQL.Add('  INNER JOIN CADITE C');
  SQL.Add('    ON C.ITE_CODITE = PCD_CODITE');
  SQL.Add('  LEFT JOIN DESSIT DS ON DS.ITE_CODITE = PCD_CODITE');
  SQL.Add('  INNER JOIN ITEGER G');
  SQL.Add('    ON G.ITE_CODITE = PCD_CODITE');
  SQL.Add('    AND G.ITE_CODEMP = PCD_CODEMP');
  SQL.Add('  LEFT JOIN CADUNI');
  SQL.Add('    ON PCMDET.PCD_CODUNI = UNI_CODUNI');

  SQL.Add('  INNER JOIN CADCID ON CADCID.CID_CODCID = FOR_CODCID ');
  SQL.Add(' LEFT JOIN CADCTA ON CTA_CODCTA = PCG_CODCTA');

  SQL.Add(' LEFT JOIN CADEMP CE ON CE.EMP_CODEMP = PCMGER.PCG_EMPDES ');
  SQL.Add(' LEFT JOIN CADCID CI ON CI.CID_CODCID = CE.EMP_CODCID ');
  SQL.Add(' LEFT  JOIN EMPIMG EI ON EI.EMP_CODEMP = CE.EMP_CODEMP ');
  SQL.Add('                     AND EI.EMP_PRINCI = "S" ');


  SQL.Add('WHERE PCG_NUMPED = :NUMPED');
  SQL.Add('  AND PCG_CODEMP = :CODEMP');
  SQL.Add('  AND PCG_ESPDOC = :ESPDOC');
  SQL.Add('GROUP BY PCG_NUMPED,');
  SQL.Add('  PCMGER.PCG_ESPDOC,');
  SQL.Add('  PCMGER.PCG_CODEMP,');
  SQL.Add('  PCMGER.PCG_NUMCTN');
  SQL.Add('  ) AS TABAUX; ');
  SQL.Add('');

  Result := SQL.Text;

end;

procedure TLeDocumentoPedidoCompra.pSetaParametrosCadcli;
begin
  inherited;
{}

end;

procedure TLeDocumentoPedidoCompra.pSetaParametrosCadFor;
begin
  inherited;
{}

end;


function TLeDocumentoPedidoCompra.fRequisicoesCompra: String;
Var
  objSQL: TStringBuilder;
Begin
  objSQL := TStringBuilder.Create;
  Try
    objSQL
      .Append('JOIN (SELECT ')
      .Append(' GROUP_CONCAT(CODREQ SEPARATOR "\n") AS REQCOD,')
      .Append(' GROUP_CONCAT(CODVEN SEPARATOR "\n") AS REQVEN,')
      .Append(' GROUP_CONCAT(RPAD(NOMCLI,50," ") SEPARATOR "\n") AS REQCLI,')
      .Append(' GROUP_CONCAT(RPAD(PRODUT,50," ") SEPARATOR "\n") AS REQITE,')
      .Append(' GROUP_CONCAT(QTDITE SEPARATOR "\n") AS REQQTD, ')
      .Append('	GROUP_CONCAT(CONCAT(')
      .Append('		RPAD(CODREQ,10," "),')
      .Append('		RPAD(CODVEN,10," "),')
      .Append('		RPAD(NOMCLI,50," "),')
      .Append('		RPAD(PRODUT,50," "),')
      .Append('		LPAD(TRUNCATE(QTDITE,0),10," ")')
      .Append('		) SEPARATOR "\n") AS REQCMP')
      .Append(' FROM ')
      .Append('(')
      .Append(' SELECT')
      .Append('  RCG_CODIGO AS CODREQ,')
      .Append('  RCD_DOCPDV AS CODVEN,')
      .Append('  CONCAT(RCG_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,')
      .Append('  CONCAT(RCD_CODITE, "-", ITE_DESITE) AS PRODUT,')
      .Append('   SUM(  ROUND(')
      .Append('    RCD_QTDITE - IFNULL(')
      .Append('      (SELECT')
      .Append('        SUM(BAI_QTDREQ)')
      .Append('      FROM')
      .Append('        BAIREQ')
      .Append('      WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM),')
      .Append('      0')
      .Append('    ),')
      .Append('    4')
      .Append('  )) AS QTDITE ')
      .Append(' FROM')
      .Append('  MOVRCG')
      .Append('  JOIN MOVRCD')
      .Append('    ON RCD_CODIGO = RCG_CODIGO')
      .Append('    AND RCD_CODEMP = RCG_CODEMP')
      .Append('  LEFT JOIN PCMDET')
      .Append('    ON PCMDET.AUTOINCREM = MOVRCD.RCD_SEQPCD')
      .Append('  LEFT JOIN PREPRQ')
      .Append('    ON PRQ_SEQRCD = MOVRCD.AUTOINCREM')
      .Append('  LEFT JOIN FDOABS')
      .Append('    ON ABS_SEQPRQ = PREPRQ.AUTOINCREM')
      .Append('  LEFT JOIN FATDOR FD1')
      .Append('    ON FD1.AUTOINCREM = ABS_SEQFDO')
      .Append('  LEFT JOIN FATDOR FD2')
      .Append('    ON FD2.FDO_NUMDOC = RCD_DOCPDV')
      .Append('    AND FD2.FDO_CODEMP = RCD_EMPPDV')
      .Append('    AND FD2.FDO_ESPDOC = RCD_ESPPDV')
      .Append('    AND FD2.FDO_CODITE = RCD_CODITE')
      .Append('  LEFT JOIN CADOPE VEN')
      .Append('    ON VEN.OPE_CODOPE = RCG_CODVEN')
      .Append('  JOIN CADCLI')
      .Append('    ON CLI_CODCLI = RCG_CODCLI')
      .Append('  JOIN CADITE C')
      .Append('    ON ITE_CODITE = RCD_CODITE')
      .Append('  LEFT JOIN CADMAR')
      .Append('    ON MAR_CODMAR = ITE_CODMAR')
      .Append('  LEFT JOIN CADFOR')
      .Append('    ON FOR_CODFOR = ITE_CODFOR')
      .Append('  LEFT JOIN CADUNI')
      .Append('    ON UNI_CODUNI = ITE_CODUNI')
      .Append('  LEFT JOIN CADDEP')
      .Append('    ON DEP_CODIGO = ITE_CODDEP')
      .Append('  LEFT JOIN GRU_COMPRA GC')
      .Append('    ON GC.GRU_CODIGO = C.ITE_GRUCMP')
      .Append('  LEFT JOIN CADOPE RES')
      .Append('    ON RES.OPE_CODOPE = GC.GRU_OPERES')
      .Append('  LEFT JOIN CADGRU LIN')
      .Append('    ON LIN.GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU, 3), "000")')
      .Append('  LEFT JOIN CADGRU GRU')
      .Append('    ON GRU.GRU_CODGRU = ITE_CODGRU')
      .Append(' WHERE   PCD_NUMPED = :NUMPED')
      .Append('    AND PCD_CODEMP = :CODEMP')
      .Append('    AND PCD_ESPDOC = :ESPDOC')
      .Append(' GROUP BY 1,2,3,4')
      .Append(' ) AS REQ) AS REQCMP ON TRUE');
    Result := objSQL.ToString;
  Finally
    FreeAndNil(objSQL);
  End;
End;



end.

