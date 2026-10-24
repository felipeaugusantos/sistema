unit untProvPortalNacional;

interface

uses
{$IF Defined(LINUX)}
  untUniClientDataSet, Uni,
{$ELSE}
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  Windows, Messages, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, DBCtrls, MemDS, Dialogs,
  frxClass, frxBarcode, frxDBSet, frxDelphiZXingQRCode,
  frxDesgn, untUniClientDataSet,
{$IFEND}
  SysUtils, Variants, Classes, StrUtils, untConexaoBD,
  untUtil, XMLIntf, XMLDoc, DB, DBClient;

type
  TProvPortalNacional = class
    private
    public

      class procedure pRetDadosVeiculo(var cdsNFS: TUniClientDataSet; strNumDoc, strCodEmp, strEspDoc: string);
      class procedure pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML, strNumDoc, strCodEmp, strEspDoc: string);

  end;

implementation

{ TProvPortalNacional }

class procedure TProvPortalNacional.pRetDadosVeiculo(var cdsNFS: TUniClientDataSet; strNumDoc, strCodEmp, strEspDoc: string);
var
  qryVeiculo: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryVeiculo := fCriaQuery;

  try
    qryVeiculo.Close;
    qryVeiculo.SQL.Clear;
    qryVeiculo.SQL.Add('SELECT                                                      ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_PLAVEI AS PLAVEI,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_DESVEI AS DESVEI,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_KMATUA AS KM_VEI,                              ');
    qryVeiculo.SQL.Add('  MARVEI.MAR_DESMAR AS DESMAR,                              ');
    qryVeiculo.SQL.Add('  MODVEI.MOD_DESMOD AS DESMOD,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_ANOVEI AS ANOVEI,                              ');
    qryVeiculo.SQL.Add('  CORVEI.COR_DESCOR AS DESCOR,                              ');
    qryVeiculo.SQL.Add('  CADVEI.VEI_NUMVEI AS NUMVEI                               ');
    qryVeiculo.SQL.Add('FROM MOVDET                                                 ');
    qryVeiculo.SQL.Add('  LEFT JOIN FATDOR ON DET_NUM_PD = FDO_NUMDOC               ');
    qryVeiculo.SQL.Add('                  AND DET_ESP_PD = FDO_ESPDOC               ');
    qryVeiculo.SQL.Add('                  AND DET_EMP_PD = FDO_CODEMP               ');
    qryVeiculo.SQL.Add('                  AND DET_CODITE = FDO_CODITE               ');
    qryVeiculo.SQL.Add('                  AND DET_IND_PD = FDO_SEQIND               ');
    qryVeiculo.SQL.Add('  LEFT JOIN FATGOR ON FDO_SEQGER = FATGOR.AUTOINCREM        ');
    qryVeiculo.SQL.Add('  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
    qryVeiculo.SQL.Add('  LEFT JOIN CADVEI ON EXTGOR.FGO_PLAVEI = CADVEI.VEI_PLAVEI ');
    qryVeiculo.SQL.Add('  LEFT JOIN MODVEI ON CADVEI.VEI_CODMOD = MODVEI.MOD_CODMOD ');
    qryVeiculo.SQL.Add('  LEFT JOIN CORVEI ON CADVEI.VEI_CODCOR = CORVEI.COR_CODCOR ');
    qryVeiculo.SQL.Add('  LEFT JOIN MARVEI ON CADVEI.VEI_CODMAR = MARVEI.MAR_CODMAR ');
    qryVeiculo.SQL.Add('WHERE TRUE                                                  ');
    qryVeiculo.SQL.Add('  AND DET_NUMDOC = :NUMDOC                                  ');
    qryVeiculo.SQL.Add('  AND DET_ESPDOC = :ESPDOC                                  ');
    qryVeiculo.SQL.Add('  AND DET_CODEMP = :CODEMP                                  ');
    qryVeiculo.SQL.Add('  LIMIT 1;                                                  ');

    qryVeiculo.ParamByName('CODEMP').AsString := strCodEmp;
    qryVeiculo.ParamByName('ESPDOC').AsString := strEspDoc;
    qryVeiculo.ParamByName('NUMDOC').AsString := Format('%.12d', [StrToIntDef(strNumDoc, 0)]);

    qryVeiculo.Open;

    if (not qryVeiculo.IsEmpty) then
    begin
      cdsNFS.FieldByName('PLAVEI').AsString  := qryVeiculo.FieldByName('PLAVEI').AsString;
      cdsNFS.FieldByName('DESVEI').AsString  := qryVeiculo.FieldByName('DESVEI').AsString;
      cdsNFS.FieldByName('KM_VEI').AsInteger := qryVeiculo.FieldByName('KM_VEI').AsInteger;
      cdsNFS.FieldByName('DESMAR').AsString  := qryVeiculo.FieldByName('DESMAR').AsString;
      cdsNFS.FieldByName('DESMOD').AsString  := qryVeiculo.FieldByName('DESMOD').AsString;
      cdsNFS.FieldByName('ANOVEI').AsString  := qryVeiculo.FieldByName('ANOVEI').AsString;
      cdsNFS.FieldByName('DESCOR').AsString  := qryVeiculo.FieldByName('DESCOR').AsString;
      cdsNFS.FieldByName('NUMVEI').AsString  := qryVeiculo.FieldByName('NUMVEI').AsString;
    end;
  finally
    FreeAndNil(qryVeiculo);
  end;
end;

class procedure TProvPortalNacional.pRetornaCDSPreenchido(var cdsNFS: TUniClientDataSet; strXML, strNumDoc, strCodEmp, strEspDoc: string);
var
  XmlDoc : IXMLDocument;

  XmlNodePrincipal,
  XmlNodeInfDPS,
  XmlNodePrest,
  XmlNodeToma,
  XmlNodeServ,
  XmlNodeValores : IXMLNode;

  LUF: Variant;
begin
  xmlDoc := TXMLDocument.Create(Application);
  xmlDoc.LoadFromXML(strXML);
  xmlDoc.Active := True;

  XmlNodePrincipal := XmlDoc.ChildNodes['NFSe']
                            .ChildNodes['infNFSe'];
  XmlNodeInfDPS    := XmlNodePrincipal.ChildNodes['DPS']
                                      .ChildNodes['infDPS'];
  XmlNodePrest     := XmlNodeInfDPS.ChildNodes['prest'];
  XmlNodeToma      := XmlNodeInfDPS.ChildNodes['toma'];
  XmlNodeServ      := XmlNodeInfDPS.ChildNodes['serv'];
  XmlNodeValores   := XmlNodeInfDPS.ChildNodes['valores'];

  cdsNFS.Append;
  try
    //Cabeçalho
    cdsNFS.FieldByName('NFSEID').AsString := Copy(XmlNodePrincipal.XML, 61, 50);
    cdsNFS.FieldByName('NUMNFS').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('nNFSe'));
    cdsNFS.FieldByName('COMPET').AsString := Copy(fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('dCompet')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('dCompet')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('dCompet')),1,4);
    cdsNFS.FieldByName('DTANFS').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')),1,4);
    cdsNFS.FieldByName('DTAEMI').AsString := cdsNFS.FieldByName('DTANFS').AsString;
    cdsNFS.FieldByName('HRANFS').AsString := Copy(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('dhProc')),12,8);
    cdsNFS.FieldByName('NUMDPS').AsString := fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('nDPS'));
    cdsNFS.FieldByName('SERDPS').AsString := fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('serie'));
    cdsNFS.FieldByName('DTADPS').AsString := Copy(fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('dhEmi')),9,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('dhEmi')),6,2)+'/'+
                                             Copy(fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('dhEmi')),1,4);
    cdsNFS.FieldByName('HRADPS').AsString := Copy(fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes.FindNode('dhEmi')),12,8);

    //Emitente
    cdsNFS.FieldByName('PSVCNPJ').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes.FindNode('CNPJ'));
    cdsNFS.FieldByName('PSVIM').AsString    := ''; // Não tem no XML modelo
    cdsNFS.FieldByName('PSVFONE').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes.FindNode('fone'));
    cdsNFS.FieldByName('PSVRAZAO').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes.FindNode('xNome'));
    cdsNFS.FieldByName('PSVFANT').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes.FindNode('xFant'));
    cdsNFS.FieldByName('PSVEMAIL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes.FindNode('email'));
    cdsNFS.FieldByName('PSVEND').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes.FindNode('xLgr'));
    cdsNFS.FieldByName('PSVNUM').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes.FindNode('nro'));
    cdsNFS.FieldByName('PSVCOMPL').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes.FindNode('xCpl'));
    cdsNFS.FieldByName('PSVBAIR').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes.FindNode('xBairro'));
    cdsNFS.FieldByName('PSVMUN').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes.FindNode('cMun'));
    cdsNFS.FieldByName('PSVUF').AsString    := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes.FindNode('UF'));
    cdsNFS.FieldByName('PSVCEP').AsString   := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['emit'].ChildNodes['enderNac'].ChildNodes.FindNode('CEP'));
    cdsNFS.FieldByName('PSVOSN').AsString   := fRetornaValorTagXml(XmlNodePrest.ChildNodes['regTrib'].ChildNodes.FindNode('opSimpNac'));
    cdsNFS.FieldByName('PSVREG').AsString   := fRetornaValorTagXml(XmlNodePrest.ChildNodes['regTrib'].ChildNodes.FindNode('regApTribSN'));
    cdsNFS.FieldByName('PSVESP').AsString   := fRetornaValorTagXml(XmlNodePrest.ChildNodes['regTrib'].ChildNodes.FindNode('regEspTrib'));

    //Tomador
    cdsNFS.FieldByName('TMSCNPJ').AsString  := iif(fRetornaValorTagXml(XmlNodeToma.ChildNodes.FindNode('CNPJ'))='',
                                                   fRetornaValorTagXml(XmlNodeToma.ChildNodes.FindNode('CPF')),
                                                   fRetornaValorTagXml(XmlNodeToma.ChildNodes.FindNode('CNPJ')));
    cdsNFS.FieldByName('TMSIM').AsString    := ''; // Não tem no XML modelo
    cdsNFS.FieldByName('TMSFONE').AsString  := fRetornaValorTagXml(XmlNodeToma.ChildNodes.FindNode('fone'));
    cdsNFS.FieldByName('TMSRAZAO').AsString := fRetornaValorTagXml(XmlNodeToma.ChildNodes.FindNode('xNome'));
    cdsNFS.FieldByName('TMSEMAIL').AsString := fRetornaValorTagXml(XmlNodeToma.ChildNodes.FindNode('email'));
    cdsNFS.FieldByName('TMSEND').AsString   := fRetornaValorTagXml(XmlNodeToma.ChildNodes['end'].ChildNodes.FindNode('xLgr'));
    cdsNFS.FieldByName('TMSNUM').AsString   := fRetornaValorTagXml(XmlNodeToma.ChildNodes['end'].ChildNodes.FindNode('nro'));
    cdsNFS.FieldByName('TMSCOMPL').AsString := ''; // Não tem no XML modelo
    cdsNFS.FieldByName('TMSBAIR').AsString  := fRetornaValorTagXml(XmlNodeToma.ChildNodes['end'].ChildNodes.FindNode('xBairro'));
    cdsNFS.FieldByName('TMSMUN').AsString   := '';
    cdsNFS.FieldByName('TMSUF').AsString    := ''; // Não tem no XML modelo
    cdsNFS.FieldByName('TMSCEP').AsString   := fRetornaValorTagXml(XmlNodeToma.ChildNodes['end'].ChildNodes['endNac'].ChildNodes.FindNode('CEP'));

    //Serviço Prestado
    cdsNFS.FieldByName('CDTRNAC').AsString := fRetornaValorTagXml(XmlNodeServ.ChildNodes['cServ'].ChildNodes.FindNode('cTribNac'));
    cdsNFS.FieldByName('CDTRMUN').AsString := fRetornaValorTagXml(XmlNodeServ.ChildNodes['cServ'].ChildNodes.FindNode('cTribMun'));
    cdsNFS.FieldByName('DSTRNAC').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xTribNac'));
    cdsNFS.FieldByName('DSTRMUN').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xTribMun'));

    cdsNFS.FieldByName('CODSER').AsString  := cdsNFS.FieldByName('CDTRMUN').AsString;
    cdsNFS.FieldByName('DESSER').AsString  := fRetornaValorTagXml(XmlNodeServ.ChildNodes['cServ'].ChildNodes.FindNode('xDescServ'));
    cdsNFS.FieldByName('CODNBS').AsString  := fRetornaValorTagXml(XmlNodeServ.ChildNodes['cServ'].ChildNodes.FindNode('cNBS'));
    cdsNFS.FieldByName('PAIPRE').AsString  := ''; // Não tem no XML modelo
    cdsNFS.FieldByName('DISCRI').AsString  := fRetornaValorTagXml(XmlNodeServ.ChildNodes['locPrest'].ChildNodes.FindNode('cLocPrestacao'));

    //Tributação Municipal
    cdsNFS.FieldByName('CDISSQN').AsString := fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribMun'].ChildNodes.FindNode('tribISSQN'));
    cdsNFS.FieldByName('PAISRES').AsString := ''; //novo
    if Assigned(XmlNodePrincipal.ChildNodes.FindNode('cLocIncid'))
       and Assigned(XmlNodePrincipal.ChildNodes.FindNode('xLocIncid')) then
      LUF := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_NOMCID', 'CID_COIBGE'], [fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocIncid')), fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('cLocIncid'))])
    else
      LUF := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_NOMCID'], [fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocIncid'))]);
    cdsNFS.FieldByName('MUNINC').AsString  := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocIncid'))+
                                              IfThen(not VarIsNull(LUF) and (VarToStr(LUF) <> ''), '-' + VarToStr(LUF), '');

    cdsNFS.FieldByName('REGESP').AsString  := fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes['prest'].ChildNodes['regTrib'].ChildNodes.FindNode('regEspTrib'));
    cdsNFS.FieldByName('TIPIMU').AsString  := ''; //novo
    cdsNFS.FieldByName('SUSEXI').AsString  := ''; //novo
    cdsNFS.FieldByName('NUMPRO').AsString  := ''; //novo
    cdsNFS.FieldByName('BENMUN').AsString  := ''; //novo
    cdsNFS.FieldByName('VLRSER').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['vServPrest'].ChildNodes.FindNode('vServ')),'.',','), 0);
    cdsNFS.FieldByName('DESCONI').AsFloat  := 0;
    cdsNFS.FieldByName('DESCONC').AsFloat  := 0;
    cdsNFS.FieldByName('VLRDED').AsFloat   := 0;
    cdsNFS.FieldByName('CALCBM').AsFloat   := 0;
    cdsNFS.FieldByName('BSCISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('vBC')),'.',','), 0);
    cdsNFS.FieldByName('ALIISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('pAliqAplic')),'.',','), 0);
    cdsNFS.FieldByName('ISSRET').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('vTotalRet')),'.',','), 0);
    cdsNFS.FieldByName('VLRISS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('vISSQN')),'.',','), 0);
    cdsNFS.FieldByName('ISSRETIDO').AsString := fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribMun'].ChildNodes.FindNode('tpRetISSQN'));
    //Tributação Federal
    cdsNFS.FieldByName('VALIRR').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes.FindNode('vRetIRRF')),'.',','), 0);
    cdsNFS.FieldByName('VAL_CP').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes.FindNode('vRetCP')),'.',','), 0);
    cdsNFS.FieldByName('VALCSL').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes.FindNode('vRetCSLL')),'.',','), 0);
    cdsNFS.FieldByName('VALPIS').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes['piscofins'].ChildNodes.FindNode('vPis')),'.',','), 0);
    cdsNFS.FieldByName('VALCOF').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes['piscofins'].ChildNodes.FindNode('vCofins')),'.',','), 0);

    cdsNFS.FieldByName('BCPISCOFINS').AsFloat   := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes['piscofins'].ChildNodes.FindNode('vBCPisCofins')),'.',','), 0);
    cdsNFS.FieldByName('ALIQPIS').AsFloat       := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes['piscofins'].ChildNodes.FindNode('pAliqPis')),'.',','), 0);
    cdsNFS.FieldByName('ALIQCOFINS').AsFloat    := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes['piscofins'].ChildNodes.FindNode('pAliqCofins')),'.',','), 0);
    cdsNFS.FieldByName('RETPISCOFINS').AsString := fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['tribFed'].ChildNodes['piscofins'].ChildNodes.FindNode('tpRetPisCofins'));

    //Valor Total da NFS-e
    cdsNFS.FieldByName('VALLIQ').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('vLiq')),'.',','), 0);

    //Totais Aproximados dos Tributos
    cdsNFS.FieldByName('TRIFED').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['totTrib'].ChildNodes['pTotTrib'].ChildNodes.FindNode('pTotTribFed')),'.',','), 0);
    cdsNFS.FieldByName('TRIEST').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['totTrib'].ChildNodes['pTotTrib'].ChildNodes.FindNode('pTotTribEst')),'.',','), 0);
    cdsNFS.FieldByName('TRIMUN').AsFloat  := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodeValores.ChildNodes['trib'].ChildNodes['totTrib'].ChildNodes['pTotTrib'].ChildNodes.FindNode('pTotTribMun')),'.',','), 0);

    //Informações Complementares
    cdsNFS.FieldByName('OUTINF').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['valores'].ChildNodes.FindNode('xOutInf'));
    cdsNFS.FieldByName('INFCPL').AsString := fRetornaValorTagXml(XmlNodeServ.ChildNodes['infoCompl'].ChildNodes.FindNode('xInfComp'));

    if Assigned(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao'))
       and Assigned(XmlNodeServ.ChildNodes.FindNode('locPrest'))
       and Assigned(XmlNodeServ.ChildNodes['locPrest'].ChildNodes.FindNode('cLocPrestacao')) then
      LUF := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_NOMCID', 'CID_COIBGE'], [fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao')), fRetornaValorTagXml(XmlNodeServ.ChildNodes['locPrest'].ChildNodes.FindNode('cLocPrestacao'))])
    else
      LUF := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_NOMCID'], [fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao'))]);
    cdsNFS.FieldByName('LOCPRE').AsString := fRetornaValorTagXml(XmlNodePrincipal.ChildNodes.FindNode('xLocPrestacao'))+
                                             IfThen(not VarIsNull(LUF) and (VarToStr(LUF) <> ''), '-' + VarToStr(LUF), '');

    if Assigned(XmlNodeInfDPS.ChildNodes.FindNode('IBSCBS')) then
    begin
      cdsNFS.FieldByName('gIBSCBS_CST').asString        := fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes['IBSCBS'].ChildNodes['valores'].ChildNodes['trib'].ChildNodes['gIBSCBS'].ChildNodes.FindNode('CST'));
      cdsNFS.FieldByName('gIBSCBS_cClassTrib').asString := fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes['IBSCBS'].ChildNodes['valores'].ChildNodes['trib'].ChildNodes['gIBSCBS'].ChildNodes.FindNode('cClassTrib'));
      cdsNFS.FieldByName('IBSCBS_cIndOp').asString      := fRetornaValorTagXml(XmlNodeInfDPS.ChildNodes['IBSCBS'].ChildNodes.FindNode('cIndOp'));
    end;

    if Assigned(XmlNodePrincipal.ChildNodes.FindNode('IBSCBS')) then
    begin
      cdsNFS.FieldByName('pIBSUF').asFloat              := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IBSCBS'].ChildNodes['valores'].ChildNodes['uf'].ChildNodes.FindNode('pIBSUF')),'.',','), 0);
      cdsNFS.FieldByName('pIBSMun').asFloat             := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IBSCBS'].ChildNodes['valores'].ChildNodes['mun'].ChildNodes.FindNode('pIBSMun')),'.',','), 0);
      cdsNFS.FieldByName('pCBS').asFloat                := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IBSCBS'].ChildNodes['valores'].ChildNodes['fed'].ChildNodes.FindNode('pCBS')),'.',','), 0);
      cdsNFS.FieldByName('vIBSTot').asFloat             := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IBSCBS'].ChildNodes['totCIBS'].ChildNodes['gIBS'].ChildNodes.FindNode('vIBSTot')),'.',','), 0);
      cdsNFS.FieldByName('gCBS_vCBS').asFloat           := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IBSCBS'].ChildNodes['totCIBS'].ChildNodes['gCBS'].ChildNodes.FindNode('vCBS')),'.',','), 0);
      cdsNFS.FieldByName('IBSCBS_vBC').asFloat          := StrToFloatDef(AnsiReplaceStr(fRetornaValorTagXml(XmlNodePrincipal.ChildNodes['IBSCBS'].ChildNodes['valores'].ChildNodes.FindNode('vBC')),'.',','), 0);
    end;

    pRetDadosVeiculo(cdsNFS, strNumDoc, strCodEmp, strEspDoc);

    cdsNFS.Post;
  except
    cdsNFS.Cancel;
    raise;
  end;

end;

end.
