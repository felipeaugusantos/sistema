unit untDocLA;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni;

Type

  TLeDocumentoLA = Class(TLeDocumento)
  Private
    cdsMovGer: TZClient;

    function fInsereClients: Boolean;

    function fSQLPreNota: String;
    function fSQLMovEntr: String;
    function fSQLReimprLibArm: String;

    function fGeraSql(intSeqPar: Integer; strCliFor: String; blnFiltroPorAutoIncrem: boolean = false): String;
    function fGeraSqlCompra: String;

  Public
    function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;

  protected

  End;

implementation

uses untConstantes, Data.DB;

Function TLeDocumentoLA.fInsereClients: Boolean;
Begin

  result := false;

  // parâmetros individuais
  if (recDocume.oriLibOrigem = oriLibEntradaDadosCaixa) or
     (recDocume.oriLibOrigem = oriLibEntradaDadosFiscaisResumo) or
     (recDocume.oriLibOrigem = oriLibEnderecamentoProduto) or
     (recDocume.oriLibOrigem = oriLibReimpressaoLiberacaoDocUnico) then
  begin

    SetLength(arrClients, Succ(Length(arrClients)));

    With arrClients[High(arrClients)] Do
    Begin
      cdsDados := TZClient.Create(Nil, fSQLMovEntr);
      frxDados := TfrxDBDataset.Create(Nil);
      frxDados.DataSet := cdsDados;
      frxDados.Name     := 'frxMovger';
      frxDados.UserName := 'frxMovger';
    End;

    With arrClients[High(arrClients)], cdsDados, qryQuery Do
    Begin

      ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
      ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
      ParamByName('CODEMP').AsString := recDocume.strCodEmp;
      ParamByName('CODFOR').AsString := recDocume.strCodCli;
      ParamByName('SERIE').AsString := recDocume.strSerie_;
      Result := fAbreClient(True, 'fInsereClients');

    End;

  end;

  if (recDocume.oriLibOrigem = oriLibEntradaMercadoriaSimplificada) then    //Uma lista do movger (Entrada entre lojas)
  begin

    SetLength(arrClients, Succ(Length(arrClients)));

    With arrClients[High(arrClients)] Do
    Begin
      cdsDados := TZClient.Create(Nil, fSQLMovEntr);
      frxDados := TfrxDBDataset.Create(Nil);
      frxDados.DataSet := cdsDados;
      frxDados.Name     := 'frxMovger';
      frxDados.UserName := 'frxMovger';
    End;

    With arrClients[High(arrClients)], cdsDados, qryQuery Do
    Begin

      SQL.Text := AnsiReplaceStr(SQL.Text,':AUTOINCREM', fCommaText(recDocume.stlListaMovGer, True));
      Result := fAbreClient(True, 'fInsereClients');

    End;

  end;

  if (recDocume.oriLibOrigem = oriLibConferenciaEntradaMercadoria) then     //Chave da entrada
  begin

    SetLength(arrClients, Succ(Length(arrClients)));

    With arrClients[High(arrClients)] Do
    Begin
      If recDocume.blnPedidoCompra Then
        cdsDados := TZClient.Create(Nil, fGeraSqlCompra)
      Else
        cdsDados := TZClient.Create(Nil, fSQLPreNota);
      frxDados := TfrxDBDataset.Create(Nil);
      frxDados.DataSet := cdsDados;
      frxDados.Name     := 'frxMovger';
      frxDados.UserName := 'frxMovger';
    End;

    With arrClients[High(arrClients)], cdsDados, qryQuery Do
    Begin
      ParamByName('IDEDIG').AsString := recDocume.strIdeDig;
      ParamByName('CODEMP').AsString := recDocume.strCodEmp;
      Result := fAbreClient(True, 'fInsereClients');

    End;

  end;

  if (recDocume.oriLibOrigem = oriLibReimpressaoLiberacaoDocMultiplo) then  //Listas de todos os parâmetros
  begin

    SetLength(arrClients, Succ(Length(arrClients)));

    With arrClients[High(arrClients)] Do
    Begin
      cdsDados := TZClient.Create(Nil, fSQLReimprLibArm);
      frxDados := TfrxDBDataset.Create(Nil);
      frxDados.DataSet := cdsDados;
      frxDados.Name     := 'frxMovger';
      frxDados.UserName := 'frxMovger';
    End;

    With arrClients[High(arrClients)], cdsDados, qryQuery Do
    Begin
      Result := fAbreClient(True, 'fInsereClientPreNota');
    End;

  end;

End;

Function TLeDocumentoLA.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
Begin
  Try

    Result := True;

    Result := Result And fInsereClients;
    cdsMovGer := arrClients[0].cdsDados;

    If Not Result Then
      Exit;

    Result := Result And fPreparaImpressaoDocumentos;
    If Result Then
    pSetaOrdenacao;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;

End;

Function TLeDocumentoLA.fSQLMovEntr: String;
  Var
    strSQL: String;
Begin

  strSQL := '';

  strSQL := strSQL + 'SELECT  SQL_NO_CACHE /*DADOS EMPRESA*/  ';
  strSQL := strSQL + '				EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '        CONCAT(EMP_ENDERE, CONCAT(", ", EMP_ENDNUM)) AS ENDEMP, ';
  strSQL := strSQL + '			  EMP_BAIRRO AS BAIEMP, ';
  strSQL := strSQL + '			  EMP_C_E_P_ AS CEPEMP, ';
  strSQL := strSQL + '			  EMP_FONE01 AS F01EMP, ';
  strSQL := strSQL + '        C1.CID_NOMCID AS CIDEMP, ';

  If recDocume.strTipFc = 'F' Then
  Begin
    strSQL := strSQL + '			  /*DADOS FORNECEDOR*/ ';
    strSQL := strSQL + '				FOR_CODFOR AS CODFOR, ';
    strSQL := strSQL + '				FOR_NOMFOR AS NOMFOR, ';
    strSQL := strSQL + '				FOR_ENDERE AS ENDFOR, ';
    strSQL := strSQL + '				FOR_BAIRRO AS BAIFOR, ';
    strSQL := strSQL + '				FOR_C_E_P_ AS CEPFOR, ';
    strSQL := strSQL + '				FOR_CGCCPF AS DC1FOR, ';
    strSQL := strSQL + '				FOR_C_G_C_ AS DC2FOR, ';
    strSQL := strSQL + '				FOR_I_E_S_ AS DC3FOR, ';
    strSQL := strSQL + '				FOR_FONE01 AS F01FOR, ';
    strSQL := strSQL + '				C2.CID_NOMCID AS CIDFOR, ';
  End
  Else
  Begin
    strSQL := strSQL + '			  /*DADOS CLIENTE*/ ';
    strSQL := strSQL + '				CL.CLI_CODCLI AS CODFOR, ';
    strSQL := strSQL + '				CL.CLI_NOMCLI AS NOMFOR, ';
    strSQL := strSQL + '				CL.CLI_ENDERE AS ENDFOR, ';
    strSQL := strSQL + '				CL.CLI_BAIRRO AS BAIFOR, ';
    strSQL := strSQL + '				CL.CLI_C_E_P_ AS CEPFOR, ';
    strSQL := strSQL + '				CL.CLI_CGCCPF AS DC1FOR, ';
    strSQL := strSQL + '				CL.CLI_C_G_C_ AS DC2FOR, ';
    strSQL := strSQL + '				CL.CLI_I_E_S_ AS DC3FOR, ';
    strSQL := strSQL + '				CL.CLI_FONE01 AS F01FOR, ';
    strSQL := strSQL + '				C2.CID_NOMCID AS CIDFOR,  ';
  End;

  strSQL := strSQL + '			  /*DADOS ENTRADA*/ ';
  strSQL := strSQL + '				CONCAT(GER_NUMDOC, " - ", GER_ESPDOC, " - ", IFNULL(GER_SERIE_, ""), " EMP: ", EMP_CODEMP) AS DOCES1, ';
  strSQL := strSQL + '				CONCAT(GER_NUMDOC, GER_ESPDOC) AS DOCES2, ';
  strSQL := strSQL + '				CONCAT(GER_NUMDOC, " - ", IFNULL(GER_SERIE_,"")) AS DOCES3, ';

  strSQL := strSQL + '				GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '				GER_ESPDOC AS ESPDOG, ';
  strSQL := strSQL + '			  GER_CONPAG AS CONPAG, ';
  strSQL := strSQL + '			  GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '			  VEN.OPE_NOMOPE AS NOMOPE, ';
  strSQL := strSQL + '				GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '				GER_HORENT AS HORENT, ';
  strSQL := strSQL + '				DIG.OPE_NOMOPE AS NOMDIG, ';
  strSQL := strSQL + '				GER_DTADOC AS DOCDTA, ';

  strSQL := strSQL + '				/*ITENS DA ENTRADA*/ ';
  strSQL := strSQL + '				UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '				DET_CODITE AS CODITE, ';
  strSQL := strSQL + '				IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), DET_DESCRI, ITE_DESITE) AS DESITE, ';
  strSQL := strSQL + '				DET_DESCRI AS DESCRI, ';
  strSQL := strSQL + '				MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '              ITE_MLTVEN AS MLTVEN, ';

  If recDocume.strModeloImpressao = '6' Then
    strSQL := strSQL + '				SUM(DET_QTDITE) AS QTDITE, '
  Else
  Begin
    If not fEmptyStr(recDocume.SeqFatEnd) Then
      strSQL := strSQL + ' IFNULL(FTE_QTDITE, DET_QTDITE) AS QTDITE, '
    Else
      strSQL := strSQL + ' DET_QTDITE AS QTDITE, ';
  End;

  strSQL := strSQL + '				IF(DET_CLAFIS < "5000", "ENT", "SAI") AS ENTSAI, ';

  strSQL := strSQL + '        DET_ESPDOC AS ESPDOD, ';
  strSQL := strSQL + ' IF(IFNULL(LOT_NUMLOT, "") = "", IFNULL(ITE_SALDOS, 0) + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0), ';
  strSQL := strSQL + '                                 IFNULL(LOT_SALDOS, 0) + IFNULL(LOT_QTEF_A, 0) + IFNULL(LOT_QTEF_F, 0) + IFNULL(LOT_QTEF_P, 0)) AS SALDOS, ';

  {************************************************************************************************}
  {   Se for TA ja pega o a localização Fisica do Lote                                             }
  {   Se exitir vinculo entre o documento e alguma TA, pega A localização fisica que estiver na TA, }
  {   Senão pega ITE_LOCFIS                                                                        }
  {**********************************************************************************************WG}

  strSQL := strSQL + '  IF(DET_ESPDOC = "TA",  IFNULL((SELECT (SELECT CONCAT(GER_CODFOR, " - ", FOR_NOMFOR) FROM CADFOR WHERE FOR_CODFOR =  GER_CODFOR)';
  strSQL := strSQL + '                                   FROM MOVGER  WHERE  MOVGER.AUTOINCREM=A.AUX_SEQDOR), ';
  strSQL := strSQL + '                         (SELECT (SELECT CONCAT(GER_CODFOR, " - ", FOR_NOMFOR) FROM CADFOR WHERE FOR_CODFOR =  GER_CODFOR) ';
  strSQL := strSQL + '                            FROM MOVGER WHERE MOVGER.AUTOINCREM=A.AUX_SEQDOR)), "") AS FORORI, ';


  strSQL := strSQL + '  IF(DET_ESPDOC = "TA",  IFNULL((SELECT CONCAT(GER_NUMDOC," - ", GER_ESPDOC," - ",GER_CODEMP)  ';
  strSQL := strSQL + '                                   FROM MOVGER  WHERE  MOVGER.AUTOINCREM=A.AUX_SEQDOR), ';
  strSQL := strSQL + '                         (SELECT CONCAT(GER_NUMDOC," - ", GER_ESPDOC," - ",GER_CODEMP) ';
  strSQL := strSQL + '                            FROM MOVGER WHERE MOVGER.AUTOINCREM=A.AUX_SEQDOR)), "") AS DOCORI, ';

  strSQL := strSQL + '  CAST(IF(DET_ESPDOC = "TA" AND DET_NUMLOT <> "", ';
  strSQL := strSQL + '     IF(DET_NUMLOT = "A DEFINIR", "A DEFINIR", LOT_LOCFIS), ';
  strSQL := strSQL + '     IF((SELECT COUNT(1) ';
  strSQL := strSQL + '           FROM AUXMOV ';
  strSQL := strSQL + '          WHERE AUX_SEQDOR = GER.AUTOINCREM ) = 0,';
  strSQL := strSQL + '        ITE_LOCFIS, ';
  strSQL := strSQL + '        (SELECT GROUP_CONCAT(DISTINCT L2.LOT_LOCFIS) ';
  strSQL := strSQL + '           FROM AUXMOV, ';
  strSQL := strSQL + '                MOVDET D2, ';
  strSQL := strSQL + '                CADLOT L2 ';
  strSQL := strSQL + '          WHERE AUX_SEQDOR = GER.AUTOINCREM ';
  strSQL := strSQL + '            AND D2.DET_SEQGER = AUXMOV.AUX_SEQGER ';
  strSQL := strSQL + '            AND D2.DET_CODITE = DET.DET_CODITE ';
  strSQL := strSQL + '            AND D2.DET_ESPDOC = "TA" ';
  strSQL := strSQL + '            AND LEFT(D2.DET_CLAFIS, 1) < 5 ';
  strSQL := strSQL + '            AND D2.DET_QTDITE > 0 ';
  strSQL := strSQL + '            AND L2.LOT_NUMLOT = D2.DET_NUMLOT ';
  strSQL := strSQL + '            AND L2.LOT_CODEMP = D2.DET_CODEMP ';
  strSQL := strSQL + '            AND L2.LOT_CODITE = D2.DET_CODITE))) AS CHAR(255)) AS LOCFIS, ';

  strSQL := strSQL + '				ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '				ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '        ITE_CODBAR AS CODBAR, ';

  strSQL := strSQL + '        CR.CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '        MR.RCD_CODIGO AS RCDCOD, ';

  strSQL := strSQL + '        ITE_LOCSUP AS LOCSUP,   ';

  strSQL := strSQL + '        DET_NUMLOT AS NUMLOT   ';

  If (recDocume.blnExiApl) Then
    strSQL := strSQL + '      , REPLACE( SUBSTRING(ITE_APLICA, 1, 255), ''<<csq>>'',''  '') AS APLICA '
  Else
    strSQL := strSQL + ' , CAST("" AS CHAR(1)) AS APLICA ';

  if (recDocume.strModeloImpressao = '3') OR (recDocume.strModeloImpressao = '4') OR (recDocume.strModeloImpressao = '8') Then
  Begin
    strSQL := strSQL + '      , ';
    strSQL := strSQL + '      ( SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) ';
    strSQL := strSQL + '        FROM ITEFOR    ';
    strSQL := strSQL + '        WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE ) AS CDFABS, ';

    strSQL := strSQL + '      (                                        ';
    strSQL := strSQL + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
    strSQL := strSQL + '      FROM ITEBAR                              ';
    strSQL := strSQL + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
    strSQL := strSQL + '      ) AS ITE_CDBARS,                         ';
    strSQL := strSQL + '      CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP) AS NOTAS ';

  End;

  strSQL := strSQL + ' ,(SELECT SUM( IF(DET_MOTFUT = "A", DET_QTDITE - IFNULL(DET_QTDENT,0), 0 )) AS DET_QTDAGU ';
  strSQL := strSQL + '     FROM MOVDET A1 ';
  strSQL := strSQL + '    INNER JOIN MOVTRI T1 ON A1.AUTOINCREM = T1.DET_SEQGER ';
  strSQL := strSQL + '    WHERE A1.DET_ENTFUT = "S" ';
  strSQL := strSQL + '      AND A1.DET_CODEMP = DET.DET_CODEMP ';
  strSQL := strSQL + '      AND A1.DET_CODITE = DET.DET_CODITE ';
  strSQL := strSQL + '      AND A1.DET_TIP_FC = "C" ';
  strSQL := strSQL + '      AND A1.DET_ESPDOC NOT IN ("ML", "PR", "TM") ';
  strSQL := strSQL + '      AND A1.DET_EFBAIX = "N" ';

  If fCfgSis('EFTEST') = '2' Then
  Begin
    strSQL := strSQL + '    AND (A1.DET_PROEMB <> "S" OR T1.DET_BXSBIT = "S") ';//Para exibir os sub-itens (proemb = 's' e bxsbit = 's')
    strSQL := strSQL + '    AND (A1.DET_FILKAR = 0) ';//Para nao exibir o item principal (que vai estar com filkar = 1)
  End
  Else
    strSQL := strSQL + '    AND A1.DET_PROEMB <> "S" ';

  strSQL := strSQL + '    GROUP BY A1.DET_CODITE ';
  strSQL := strSQL + '   HAVING (DET_QTDAGU > 0)) AS QTDAGU ';

  strSQL := strSQL + ' ,(SELECT SUM( IF(DET_MOTFUT = "F", DET_QTDITE - IFNULL(DET_QTDENT,0), 0 )) AS DET_QTDFAL ';
  strSQL := strSQL + '     FROM MOVDET A2 ';
  strSQL := strSQL + '    INNER JOIN MOVTRI T2 ON A2.AUTOINCREM = T2.DET_SEQGER ';
  strSQL := strSQL + '    WHERE A2.DET_ENTFUT = "S" ';
  strSQL := strSQL + '      AND A2.DET_CODEMP = DET.DET_CODEMP ';
  strSQL := strSQL + '      AND A2.DET_CODITE = DET.DET_CODITE ';
  strSQL := strSQL + '      AND A2.DET_TIP_FC = "C" ';
  strSQL := strSQL + '      AND A2.DET_ESPDOC NOT IN ("ML", "PR", "TM") ';
  strSQL := strSQL + '      AND A2.DET_EFBAIX = "N"                     ';

  If fCfgSis('EFTEST') = '2' Then
  Begin
    strSQL := strSQL + '    AND (A2.DET_PROEMB <> "S" OR T2.DET_BXSBIT = "S") ';//Para exibir os sub-itens (proemb = 's' e bxsbit = 's')
    strSQL := strSQL + '    AND (A2.DET_FILKAR = 0) ';//Para nao exibir o item principal (que vai estar com filkar = 1)
  End
  Else
    strSQL := strSQL + '    AND A2.DET_PROEMB <> "S" ';

  strSQL := strSQL + '    GROUP BY A2.DET_CODITE ';
  strSQL := strSQL + '    HAVING (DET_QTDFAL > 0)) AS QTDFAL ';
  strSQL := strSQL + ' ,G.ITE_PONEXP AS PONEXP ';
  strSQL := strSQL + ' ,I.ITE_VALOBR AS VALOBR   ';

  strSQL := strSQL + ' ,I.ITE_MLTVEN AS MLTVEN ';

  strSQL := strSQL + ' ,(SELECT GROUP_CONCAT(SER_NUMSER SEPARATOR ", ")';
  strSQL := strSQL + '  FROM PROSER PR                                ';
  strSQL := strSQL + '  WHERE PR.SER_CODITE = G.ITE_CODITE            ';
  strSQL := strSQL + '    AND PR.SER_CODEMP = G.ITE_CODEMP) AS NUMSER ';

  strSQL := strSQL + 'FROM MOVDET DET ';

  strSQL := strSQL + '  INNER JOIN MOVGER GER ON ';
  strSQL := strSQL + '    GER.AUTOINCREM = DET_SEQGER AND GER_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN AUXMOV A ON GER.AUTOINCREM = A.AUX_SEQGER ';

  If recDocume.strTipFc = 'F' Then
  Begin
    strSQL := strSQL + '  INNER JOIN CADFOR ON ';
    strSQL := strSQL + '    FOR_CODFOR = GER_CODFOR ';
  End
  Else
  Begin
    strSQL := strSQL + '  INNER JOIN CADCLI CL ON ';
    strSQL := strSQL + '    CL.CLI_CODCLI = GER_CODCLI ';
  End;

  strSQL := strSQL + '  INNER JOIN CADEMP ON ';
  strSQL := strSQL + '    EMP_CODEMP = DET_CODEMP ';

  strSQL := strSQL + '  INNER JOIN CADITE I ON ';
  strSQL := strSQL + '    I.ITE_CODITE = DET_CODITE ';

  strSQL := strSQL + '  LEFT JOIN CADMAR ON ';
  strSQL := strSQL + '    MAR_CODMAR = ITE_CODMAR ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ON ';
  strSQL := strSQL + '    UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + '  LEFT JOIN CADOPE VEN ON ';
  strSQL := strSQL + '    VEN.OPE_CODOPE = GER_CODVEN ';

  strSQL := strSQL + '  LEFT JOIN CADCID C1 ON ';
  strSQL := strSQL + '    C1.CID_CODCID = EMP_CODCID ';

  If recDocume.strTipFc = 'F' Then
  Begin
    strSQL := strSQL + '  LEFT JOIN CADCID C2 ON ';
    strSQL := strSQL + '    C2.CID_CODCID = FOR_CODCID ';
  End
  Else
  Begin
    strSQL := strSQL + '  LEFT JOIN CADCID C2 ON ';
    strSQL := strSQL + '    C2.CID_CODCID = CLI_CODCID ';
  End;

  strSQL := strSQL + '  INNER JOIN ITEGER G ON ';
  strSQL := strSQL + '    G.ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '    AND G.ITE_CODEMP = DET_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CADOPE DIG ON ';
  strSQL := strSQL + '    DIG.OPE_CODOPE = GER_CODDIG ';

  strSQL := strSQL + '  LEFT JOIN CADLOT LOT ON ';
  strSQL := strSQL + '    LOT.LOT_NUMLOT = DET_NUMLOT AND LOT.LOT_CODITE = DET_CODITE AND LOT.LOT_CODEMP = DET.DET_CODEMP';

  strSQL := strSQL + '  LEFT JOIN BAIREQ BR ON BAI_AUTDET = DET.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN MOVRCD MR ON BAI_AUTREQ = MR.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN FATGOR FG ON FG.FGO_NUMDOC = MR.RCD_DOCPDV ';
  strSQL := strSQL + '                     AND FG.FGO_CODEMP = MR.RCD_EMPPDV ';
  strSQL := strSQL + '                     AND FG.FGO_ESPDOC = MR.RCD_ESPPDV ';
  strSQL := strSQL + '  LEFT JOIN CADCLI CR ON FGO_CODCLI = CR.CLI_CODCLI ';
  If not fEmptyStr(recDocume.SeqFatEnd) Then
  Begin
    strSQL := strSQL + '  LEFT JOIN (SELECT  SUM(FTE_QTDITE) AS FTE_QTDITE, FTE_CODITE, FTE_SEQGER ';
    strSQL := strSQL + '               FROM FATEND ';
    strSQL := strSQL + '              WHERE FTE_SEQUEN = "'+recDocume.SeqFatEnd+'" ';
    strSQL := strSQL + '              GROUP BY FTE_CODITE) ENDE ON ENDE.FTE_SEQGER = DET.AUTOINCREM ';
    strSQL := strSQL + '                                       AND ENDE.FTE_CODITE = DET.DET_CODITE ';
  End;


  If recDocume.blnFiltroPorAutoIncrem Then
    strSQL := strSQL + ' WHERE GER.AUTOINCREM IN (:AUTOINCREM)'
  Else
  Begin
    If recDocume.intSeqPar = 0 Then
    Begin
      strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '  AND GER_ESPDOC  = :ESPDOC ';
      strSQL := strSQL + '  AND IFNULL(GER_SERIE_, "") = :SERIE  ';
      If recDocume.strTipFc = 'F' Then
        strSQL := strSQL + '  AND GER_CODFOR  = :CODFOR '
      Else
        strSQL := strSQL + '  AND GER_CODCLI  = :CODFOR ';
      strSQL := strSQL + '  AND GER_CODEMP  = :CODEMP ';
      strSQL := strSQL + '  AND DET_QTDITE > 0 ';
    End
    Else
    Begin
      strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC'+IntToStr(recDocume.intSeqPar);
      strSQL := strSQL + '  AND GER_ESPDOC  = :ESPDOC'+IntToStr(recDocume.intSeqPar);
      strSQL := strSQL + '  AND IFNULL(GER_SERIE_, "") = :SERIE'+IntToStr(recDocume.intSeqPar);
      If recDocume.strTipFc = 'F' Then
        strSQL := strSQL + '  AND GER_CODFOR  = :CODFOR'+IntToStr(recDocume.intSeqPar)
      Else
        strSQL := strSQL + '  AND GER_CODCLI  = :CODFOR'+IntToStr(recDocume.intSeqPar);
      strSQL := strSQL + '  AND GER_CODEMP  = :CODEMP'+IntToStr(recDocume.intSeqPar);
      strSQL := strSQL + '  AND DET_QTDITE > 0 ';
    End;
  End;

  strSQL := strSQL + ' AND (DET_ESPDOC <> "TA" OR ( DET_ESPDOC = "TA" AND LEFT(DET_CLAFIS,1) < 5 )) ';
  If not fEmptyStr(recDocume.SeqFatEnd) Then
    strSQL := strSQL + '  AND ENDE.FTE_SEQGER IS NOT NULL ';

  If recDocume.strModeloImpressao = '6' Then
  Begin
    strSQL := strSQL + ' GROUP BY DET_CODITE ';
    strSQL := strSQL + ' ORDER BY IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), DET_DESCRI, ITE_DESITE) ';
  End;
  if (recDocume.strModeloImpressao = '3') or  (recDocume.strModeloImpressao = '4') OR (recDocume.strModeloImpressao = '8') Then
    strSQL := strSQL + ' ORDER BY ITE_LOCFIS ';

  Result := strSQL;

end;

Function TLeDocumentoLA.fSQLPreNota: String;
  Var
    strSQL: String;
Begin

  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE             ';
  strSQL := strSQL + '			  /*DADOS EMPRESA*/        ';
  strSQL := strSQL + '				EMP_NOMEMP AS NOMEMP,              ';
  strSQL := strSQL + '        CONCAT(EMP_ENDERE, CONCAT(", ", EMP_ENDNUM)) AS ENDEMP, ';
  strSQL := strSQL + '			  EMP_BAIRRO AS BAIEMP,              ';
  strSQL := strSQL + '			  EMP_C_E_P_ AS CEPEMP,              ';
  strSQL := strSQL + '			  EMP_FONE01 AS F01EMP,              ';
  strSQL := strSQL + '        C1.CID_NOMCID AS CIDEMP, ';

  strSQL := strSQL + '			  /*DADOS FORNECEDOR*/     ';
  strSQL := strSQL + '				FOR_CODFOR AS CODFOR,              ';
  strSQL := strSQL + '				FOR_NOMFOR AS NOMFOR,              ';
  strSQL := strSQL + '				FOR_ENDERE AS ENDFOR,              ';
  strSQL := strSQL + '				FOR_BAIRRO AS BAIFOR,              ';
  strSQL := strSQL + '				FOR_C_E_P_ AS CEPFOR,              ';
  strSQL := strSQL + '				FOR_CGCCPF AS DC1FOR,              ';
  strSQL := strSQL + '				FOR_C_G_C_ AS DC2FOR,              ';
  strSQL := strSQL + '				FOR_I_E_S_ AS DC3FOR,              ';
  strSQL := strSQL + '				FOR_FONE01 AS F01FOR,              ';
  strSQL := strSQL + '				C2.CID_NOMCID AS CIDFOR, ';

  strSQL := strSQL + '				/*DADOS ENTRADA*/             ';

  strSQL := strSQL + '			IF(GER_DOCNUM IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(GER_DOCNUM, " EMP: ", EMP_CODEMP)) AS DOCES1, ';
  strSQL := strSQL + '			IF(GER_DOCNUM IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(GER_DOCNUM, "NF")) AS DOCES2, ';

  strSQL := strSQL + '				GER_DOCNUM AS NUMDOC,        ';
  strSQL := strSQL + '				"NF" AS ESPDOC,           ';
  strSQL := strSQL + '        ""   AS CONPAG, ';
  strSQL := strSQL + '        ""   AS QTDAGU, ';
  strSQL := strSQL + '        ""   AS QTDFAL, ';
  strSQL := strSQL + '			  GER_OPECON AS CODVEN,     ';
  strSQL := strSQL + '			  VEN.OPE_NOMOPE AS NOMOPE, ';
  strSQL := strSQL + '				GER_DTACON AS DTAENT,     ';
  strSQL := strSQL + '				GER_HORCON AS HORENT,     ';
  strSQL := strSQL + '				VEN.OPE_NOMOPE AS NOMDIG,     ';

  strSQL := strSQL + '				/*ITENS DA ENTRADA*/         ';
  strSQL := strSQL + '				UNI_SIGUNI AS SIGUNI,                  ';
  strSQL := strSQL + '				D.DIG_CODITE AS CODITE,  ';
  strSQL := strSQL + '				ITE_DESITE AS DESITE,                  ';
  strSQL := strSQL + '				MAR_DESMAR AS DESMAR,                  ';
  If (recDocume.strModeloImpressao = '6') Then
    strSQL := strSQL + '				SUM(D.DIG_QTDITE) AS QTDITE, '
  Else
    strSQL := strSQL + '				D.DIG_QTDITE AS QTDITE,  ';
  strSQL := strSQL + '				ITE_LOCFIS AS LOCFIS,                  ';
  strSQL := strSQL + '				ITE_REFERE AS REFERE,                  ';
  strSQL := strSQL + '				ITE_CODFAB AS CODFAB,                  ';
  strSQL := strSQL + '        ITE_CODBAR AS CODBAR,                  ';
  strSQL := strSQL + '        ITE_SALDOS AS SALDOS,                  ';
  If (recDocume.blnExiApl) Then
    strSQL := strSQL + ' REPLACE( SUBSTRING(ITE_APLICA, 1, 255), ''<<csq>>'',''  '') AS APLICA, ';
  strSQL := strSQL + '				" " AS ENTSAI ';

  if (recDocume.strModeloImpressao = '3') OR (recDocume.strModeloImpressao = '4')  OR (recDocume.strModeloImpressao = '5') OR (recDocume.strModeloImpressao = '8') Then
  Begin
    strSQL := strSQL + '      , ';
    strSQL := strSQL + '      ( SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) ';
    strSQL := strSQL + '        FROM ITEFOR    ';
    strSQL := strSQL + '        WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE ) AS CDFABS, ';

    strSQL := strSQL + '      (                                        ';
    strSQL := strSQL + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
    strSQL := strSQL + '      FROM ITEBAR                              ';
    strSQL := strSQL + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
    strSQL := strSQL + '      ) AS CDBARS,                         ';
    strSQL := strSQL + '      ITE_LOCSUP AS LOCSUP, ';

    strSQL := strSQL + '      (SELECT GROUP_CONCAT(DISTINCT CONCAT(GEX.B08_NNF,"-NF") SEPARATOR " / ") ';
    strSQL := strSQL + '       FROM GERELE GEX                                                         ';
    strSQL := strSQL + '       WHERE GEX.GER_IDEDIG = :IDEDIG                                          ';
    strSQL := strSQL + '         AND GEX.GER_CODEMP = :CODEMP) AS NOTAS                                ';
  End;

  strSQL := strSQL + ' ,I.ITE_MLTVEN AS MLTVEN ';

  strSQL := strSQL + ' ,(SELECT GROUP_CONCAT(SER_NUMSER SEPARATOR ", ")';
  strSQL := strSQL + '   FROM PROSER PR                                ';
  strSQL := strSQL + '   WHERE PR.SER_CODITE = G.ITE_CODITE            ';
  strSQL := strSQL + '    AND PR.SER_CODEMP = G.ITE_CODEMP) AS NUMSER  ';

  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   DIGELE D    ';

  strSQL := strSQL + 'LEFT JOIN (SELECT ';
  If recDocume.strModeloImpressao = '6' Then
    strSQL := strSQL + '				GROUP_CONCAT(B08_NNF, " - NF - ", B07_SERIE) AS GER_DOCNUM, '
  Else
    strSQL := strSQL + '    GROUP_CONCAT(GE.B08_NNF) AS GER_DOCNUM,';
  strSQL := strSQL + '                   DE.DET_CODITE,';
  strSQL := strSQL + '                   GE.GER_CODFOR,';
  strSQL := strSQL + '                   GER_OPECON,';
  strSQL := strSQL + '                   GER_DTACON,';
  strSQL := strSQL + '                   GER_HORCON';
  strSQL := strSQL + '              FROM GERELE GE';
  strSQL := strSQL + '             INNER JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM';
  strSQL := strSQL + '             WHERE GE.GER_IDEDIG  = :IDEDIG';
  strSQL := strSQL + '             GROUP BY DE.DET_CODITE) A ON A.DET_CODITE = D.DIG_CODITE ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.DIG_CODITE ';
  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = :CODEMP';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = DIG_CODITE AND G.ITE_CODEMP = :CODEMP';
  strSQL := strSQL + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  strSQL := strSQL + '   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + '   LEFT JOIN CADCID C1 ON C1.CID_CODCID = EMP_CODCID';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADCID C2 ON C2.CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = GER_OPECON ';
  strSQL := strSQL + ' WHERE      ';
  strSQL := strSQL + '   D.DIG_IDEDIG = :IDEDIG';
  strSQL := strSQL + '   AND DIG_CODEMP = :CODEMP';
  strSQL := strSQL + ' GROUP BY       ';
  If recDocume.strModeloImpressao = '6' Then
  Begin
    strSQL := strSQL + '   D.DIG_CODITE ';
    strSQL := strSQL + ' ORDER BY ITE_DESITE ';
  End
  Else
    strSQL := strSQL + '   D.AUTOINCREM ';

  if (recDocume.strModeloImpressao = '3') or  (recDocume.strModeloImpressao = '4') OR (recDocume.strModeloImpressao = '5') OR (recDocume.strModeloImpressao = '8') Then
    strSQL := strSQL + ' ORDER BY ITE_LOCFIS ';

  result := strSQL;

end;

function TLeDocumentoLA.fSQLReimprLibArm: String;
  Var
    strSQL,
    strUnion: String;
    intCont: integer;
Begin

  strSQL := '';
  strUnion := '';

  strSQL := strSQL + '	SELECT  ';

  strSQL := strSQL + '		MOVGER.EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '    MOVGER.EMP_ENDERE AS ENDEMP, ';
  strSQL := strSQL + '		MOVGER.EMP_BAIRRO AS BAIEMP, ';
  strSQL := strSQL + '		MOVGER.EMP_C_E_P_ AS CEPEMP, ';
  strSQL := strSQL + '		MOVGER.EMP_FONE01 AS F01EMP, ';
  strSQL := strSQL + '    MOVGER.CIDEMP AS CIDEMP, ';

  strSQL := strSQL + '		MOVGER.FOR_CODFOR AS CODFOR, ';
  strSQL := strSQL + '		MOVGER.FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '		MOVGER.FOR_ENDERE AS ENDFOR, ';
  strSQL := strSQL + '		MOVGER.FOR_BAIRRO AS BAIFOR, ';
  strSQL := strSQL + '		MOVGER.FOR_C_E_P_ AS CEPFOR, ';
  strSQL := strSQL + '		MOVGER.FOR_CGCCPF AS DC1FOR, ';
  strSQL := strSQL + '		MOVGER.FOR_C_G_C_ AS DC2FOR, ';
  strSQL := strSQL + '		MOVGER.FOR_I_E_S_ AS DC3FOR, ';
  strSQL := strSQL + '		MOVGER.FOR_FONE01 AS F01FOR, ';
  strSQL := strSQL + '		MOVGER.CIDFOR AS CIDFOR, ';

  strSQL := strSQL + '		MOVGER.GER_DTADOC AS DOCDTA, ';
  strSQL := strSQL + '		GROUP_CONCAT(MOVGER.GER_DOCNUM) AS DOCNUM, ';
  strSQL := strSQL + '		GROUP_CONCAT(MOVGER.GER_NUMDOC) AS NUMDOC, ';
  strSQL := strSQL + '		MOVGER.GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '		GROUP_CONCAT(MOVGER.GER_CONPAG) AS CONPAG, ';
  strSQL := strSQL + '		MOVGER.GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '		GROUP_CONCAT(MOVGER.OPE_NOMOPE) AS NOMOPE, ';
  strSQL := strSQL + '		MOVGER.GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '		MOVGER.GER_HORENT AS HORENT, ';
  strSQL := strSQL + '		GROUP_CONCAT(MOVGER.NOMDIG) AS NOMDIG, ';
  strSQL := strSQL + '		MOVGER.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '		MOVGER.DET_CODITE AS CODITE, ';
  strSQL := strSQL + '		MOVGER.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '		MOVGER.MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '		SUM(MOVGER.DET_QTDITE) AS QTDITE, ';
  strSQL := strSQL + '		GROUP_CONCAT(MOVGER.LOCFIS) AS LOCFIS, ';
  strSQL := strSQL + '		MOVGER.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '		MOVGER.ITE_CODFAB AS CODFAB, ';

  If (recDocume.blnExiApl) Then
    strSQL := strSQL + '   MOVGER.ITE_APLICA AS APLICA, ';
  If recDocume.strModeloImpressao = '6' Then
    strSQL := strSQL + '		COUNT(MOVGER.GER_DOCNUM) AS QTDDOC  '
  else
    strSQL := strSQL + '		COUNT(MOVGER.GER_NUMDOC) AS QTDDOC  ';
  strSQL := strSQL + ' FROM (';

  For  intCont := 0 to recDocume.stlDocumentos.Count -1 do
  Begin
   

    strUnion := fGeraSql(intCont, recDocume.stlTipFC[intCont]);
    strUnion := AnsiReplaceStr(strUnion,':NUMDOC', QuotedStr(recDocume.stlDocumentos[intCont]));
    strUnion := AnsiReplaceStr(strUnion,':ESPDOC', QuotedStr(recDocume.stlEspecies[intCont]));
    strUnion := AnsiReplaceStr(strUnion,':SERIE', QuotedStr(recDocume.stlSeries[intCont]));
    strUnion := AnsiReplaceStr(strUnion,':CODEMP', QuotedStr(recDocume.stlEmpresas[intCont]));
    strUnion := AnsiReplaceStr(strUnion,':CODFOR', QuotedStr(recDocume.stlFornecedores[intCont]));

    If (intCont < recDocume.stlDocumentos.Count -1) Then
      strUnion := strUnion + ' UNION ALL ';

  End;

  strUnion := strUnion + ' ) AS MOVGER ';

  result := strSQL + strUnion;

end;

function TLeDocumentoLA.fGeraSql(intSeqPar: Integer; strCliFor : String; blnFiltroPorAutoIncrem: boolean = False): String;
begin
  Result := '';

  Result := Result + '( ';
  Result := Result + 'SELECT  SQL_NO_CACHE /*DADOS EMPRESA*/  ';
  Result := Result + '				EMP_NOMEMP AS EMP_NOMEMP, ';
  Result := Result + '        CONCAT(EMP_ENDERE, CONCAT(", ", EMP_ENDNUM)) AS EMP_ENDERE, ';
  Result := Result + '			  EMP_BAIRRO AS EMP_BAIRRO, ';
  Result := Result + '			  EMP_C_E_P_ AS EMP_C_E_P_, ';
  Result := Result + '			  EMP_FONE01 AS EMP_FONE01, ';
  Result := Result + '        C1.CID_NOMCID AS CIDEMP, ';

  If strCliFor = 'F' Then
  Begin
    Result := Result + '			  /*DADOS FORNECEDOR*/ ';
    Result := Result + '				FOR_CODFOR AS FOR_CODFOR, ';
    Result := Result + '				FOR_NOMFOR AS FOR_NOMFOR, ';
    Result := Result + '				FOR_ENDERE AS FOR_ENDERE, ';
    Result := Result + '				FOR_BAIRRO AS FOR_BAIRRO, ';
    Result := Result + '				FOR_C_E_P_ AS FOR_C_E_P_, ';
    Result := Result + '				FOR_CGCCPF AS FOR_CGCCPF, ';
    Result := Result + '				FOR_C_G_C_ AS FOR_C_G_C_, ';
    Result := Result + '				FOR_I_E_S_ AS FOR_I_E_S_, ';
    Result := Result + '				FOR_FONE01 AS FOR_FONE01, ';
    Result := Result + '				C2.CID_NOMCID AS CIDFOR, ';
  End
  Else
  Begin
    Result := Result + '			  /*DADOS CLIENTE*/ ';
    Result := Result + '				CL.CLI_CODCLI AS FOR_CODFOR, ';
    Result := Result + '				CL.CLI_NOMCLI AS FOR_NOMFOR, ';
    Result := Result + '				CL.CLI_ENDERE AS FOR_ENDERE, ';
    Result := Result + '				CL.CLI_BAIRRO AS FOR_BAIRRO, ';
    Result := Result + '				CL.CLI_C_E_P_ AS FOR_C_E_P_, ';
    Result := Result + '				CL.CLI_CGCCPF AS FOR_CGCCPF, ';
    Result := Result + '				CL.CLI_C_G_C_ AS FOR_C_G_C_, ';
    Result := Result + '				CL.CLI_I_E_S_ AS FOR_I_E_S_, ';
    Result := Result + '				CL.CLI_FONE01 AS FOR_FONE01, ';
    Result := Result + '				C2.CID_NOMCID AS CIDFOR,  ';
  End;

  Result := Result + '				/*DADOS ENTRADA*/ ';
  Result := Result + '				CONCAT(GER_NUMDOC, " - ", GER_ESPDOC, " - ", IFNULL(GER_SERIE_, ""), " EMP: ", EMP_CODEMP) AS GER_NUMDOC, ';
  Result := Result + '				CONCAT(GER_NUMDOC, GER_ESPDOC) AS GER_DOCNUM, ';
  Result := Result + '				GER_ESPDOC AS GER_ESPDOC, ';
  Result := Result + '			  GER_CONPAG AS GER_CONPAG, ';
  Result := Result + '			  GER_CODVEN AS GER_CODVEN, ';
  Result := Result + '			  VEN.OPE_NOMOPE AS OPE_NOMOPE, ';
  Result := Result + '				GER_DTAENT AS GER_DTAENT, ';
  Result := Result + '				GER_HORENT AS GER_HORENT, ';
  Result := Result + '				DIG.OPE_NOMOPE AS NOMDIG, ';
  Result := Result + '				GER_DTADOC AS GER_DTADOC, ';

  Result := Result + '				/*ITENS DA ENTRADA*/ ';

  Result := Result + '				UNI_SIGUNI AS UNI_SIGUNI, ';
  Result := Result + '				DET_CODITE AS DET_CODITE, ';
  Result := Result + '				IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), DET_DESCRI, ITE_DESITE) AS ITE_DESITE, ';
  Result := Result + '				MAR_DESMAR AS MAR_DESMAR, ';
  If recDocume.strModeloImpressao = '6' Then
    Result := Result + '				SUM(DET_QTDITE) AS QTDITE, '
  Else
  Begin
    If not fEmptyStr(recDocume.SeqFatEnd) Then
      Result := Result + ' IFNULL(FTE_QTDITE, DET_QTDITE) AS QTDITE, '
    Else
      Result := Result + ' DET_QTDITE AS QTDITE, ';
  End;


  Result := Result + '  IF(DET_ESPDOC = "TA" AND DET_NUMLOT <> "", ';
  Result := Result + '     IF(DET_NUMLOT = "A DEFINIR", "A DEFINIR", LOT_LOCFIS), ';
  Result := Result + '     IF((SELECT COUNT(1) ';
  Result := Result + '           FROM AUXMOV ';
  Result := Result + '          WHERE AUX_SEQDOR = GER.AUTOINCREM ) = 0,';
  Result := Result + '        ITE_LOCFIS, ';
  Result := Result + '        (SELECT GROUP_CONCAT(DISTINCT L2.LOT_LOCFIS) ';
  Result := Result + '           FROM AUXMOV, ';
  Result := Result + '                MOVDET D2, ';
  Result := Result + '                CADLOT L2 ';
  Result := Result + '          WHERE AUX_SEQDOR = GER.AUTOINCREM ';
  Result := Result + '            AND D2.DET_SEQGER = AUXMOV.AUX_SEQGER ';
  Result := Result + '            AND D2.DET_CODITE = DET.DET_CODITE ';
  Result := Result + '            AND D2.DET_ESPDOC = "TA" ';
  Result := Result + '            AND LEFT(D2.DET_CLAFIS, 1) < 5 ';
  Result := Result + '            AND D2.DET_QTDITE > 0 ';
  Result := Result + '            AND L2.LOT_NUMLOT = D2.DET_NUMLOT ';
  Result := Result + '            AND L2.LOT_CODEMP = D2.DET_CODEMP ';
  Result := Result + '            AND L2.LOT_CODITE = D2.DET_CODITE))) AS LOCFIS, ';

  Result := Result + '				ITE_REFERE AS ITE_REFERE, ';
  Result := Result + '				ITE_CODFAB AS ITE_CODFAB ';

  If recDocume.blnExiApl Then
    Result := Result + ', REPLACE( SUBSTRING(ITE_APLICA, 1, 255), ''<<csq>>'',''  '') AS ITE_APLICA ';


  Result := Result + ' ,I.ITE_MLTVEN AS MLTVEN ';

  Result := Result + ' ,(SELECT GROUP_CONCAT(SER_NUMSER SEPARATOR ", ")';
  Result := Result + '  FROM PROSER PR                                ';
  Result := Result + '  WHERE PR.SER_CODITE = G.ITE_CODITE            ';
  Result := Result + '    AND PR.SER_CODEMP = G.ITE_CODEMP) AS NUMSER ';

  Result := Result + 'FROM MOVDET DET ';

  Result := Result + '  INNER JOIN MOVGER GER ON ';
  Result := Result + '    GER.AUTOINCREM = DET_SEQGER AND GER_CODEMP = DET_CODEMP ';
  Result := Result + '  LEFT JOIN AUXMOV A ON GER.AUTOINCREM = A.AUX_SEQGER ';

  If strCliFor = 'F' Then
  Begin
    Result := Result + '  INNER JOIN CADFOR ON ';
    Result := Result + '    FOR_CODFOR = GER_CODFOR ';
  End
  Else
  Begin
    Result := Result + '  INNER JOIN CADCLI CL ON ';
    Result := Result + '    CL.CLI_CODCLI = GER_CODCLI ';
  End;

  Result := Result + '  INNER JOIN CADEMP ON ';
  Result := Result + '    EMP_CODEMP = DET_CODEMP ';

  Result := Result + '  INNER JOIN CADITE I ON ';
  Result := Result + '    I.ITE_CODITE = DET_CODITE ';

  Result := Result + '  LEFT JOIN CADMAR ON ';
  Result := Result + '    MAR_CODMAR = ITE_CODMAR ';

  Result := Result + '  LEFT JOIN CADUNI ON ';
  Result := Result + '    UNI_CODUNI = ITE_CODUNI ';

  Result := Result + '  LEFT JOIN CADOPE VEN ON ';
  Result := Result + '    VEN.OPE_CODOPE = GER_CODVEN ';

  Result := Result + '  LEFT JOIN CADCID C1 ON ';
  Result := Result + '    C1.CID_CODCID = EMP_CODCID ';

  If strCliFor = 'F' Then
  Begin
    Result := Result + '  LEFT JOIN CADCID C2 ON ';
    Result := Result + '    C2.CID_CODCID = FOR_CODCID ';
  End
  Else
  Begin
    Result := Result + '  LEFT JOIN CADCID C2 ON ';
    Result := Result + '    C2.CID_CODCID = CLI_CODCID ';
  End;

  Result := Result + '  INNER JOIN ITEGER G ON ';
  Result := Result + '    G.ITE_CODITE = DET_CODITE ';
  Result := Result + '    AND G.ITE_CODEMP = DET_CODEMP ';

  Result := Result + '  LEFT JOIN CADOPE DIG ON ';
  Result := Result + '    DIG.OPE_CODOPE = GER_CODDIG ';

  Result := Result + '  LEFT JOIN CADLOT LOT ON ';
  Result := Result + '    LOT.LOT_NUMLOT = DET_NUMLOT AND LOT.LOT_CODITE = DET_CODITE AND LOT.LOT_CODEMP = DET.DET_CODEMP';

  Result := Result + '  LEFT JOIN BAIREQ BR ON BAI_AUTDET = DET.AUTOINCREM ';
  Result := Result + '  LEFT JOIN MOVRCD MR ON BAI_AUTREQ = MR.AUTOINCREM ';
  Result := Result + '  LEFT JOIN FATGOR FG ON FG.FGO_NUMDOC = MR.RCD_DOCPDV ';
  Result := Result + '                     AND FG.FGO_CODEMP = MR.RCD_EMPPDV ';
  Result := Result + '                     AND FG.FGO_ESPDOC = MR.RCD_ESPPDV ';
  Result := Result + '  LEFT JOIN CADCLI CR ON FGO_CODCLI = CR.CLI_CODCLI ';
  If not fEmptyStr(recDocume.SeqFatEnd) Then
  Begin
    Result := Result + '  LEFT JOIN (SELECT  SUM(FTE_QTDITE) AS FTE_QTDITE, FTE_CODITE, FTE_SEQGER ';
    Result := Result + '               FROM FATEND ';
    Result := Result + '              WHERE FTE_SEQUEN = "'+recDocume.SeqFatEnd+'" ';
    Result := Result + '              GROUP BY FTE_CODITE) ENDE ON ENDE.FTE_SEQGER = DET.AUTOINCREM ';
    Result := Result + '                                       AND ENDE.FTE_CODITE = DET.DET_CODITE ';
  End;

  If recDocume.blnFiltroPorAutoIncrem Then
    Result := Result + ' WHERE GER.AUTOINCREM IN (:AUTOINCREM)'
  Else
  Begin
    Result := Result + ' WHERE GER_NUMDOC = :NUMDOC ';
    Result := Result + '  AND GER_ESPDOC  = :ESPDOC ';
    Result := Result + '  AND IFNULL(GER_SERIE_, "") = :SERIE  ';
    If strCliFor = 'F' Then
      Result := Result + '  AND GER_CODFOR  = :CODFOR '
    Else
      Result := Result + '  AND GER_CODCLI  = :CODFOR ';
    Result := Result + '  AND GER_CODEMP  = :CODEMP ';
    Result := Result + '  AND DET_QTDITE > 0 ';
  End;

  Result := Result + ' AND (DET_ESPDOC <> "TA" OR ( DET_ESPDOC = "TA" AND LEFT(DET_CLAFIS,1) < 5 )) ';
  If not fEmptyStr(recDocume.SeqFatEnd) Then
    Result := Result + '  AND ENDE.FTE_SEQGER IS NOT NULL ';

  If recDocume.strModeloImpressao = '6' Then
  Begin
    Result := Result + ' GROUP BY DET_CODITE ';
    Result := Result + ' ORDER BY IF(LOCATE("ITEM ESPECIAL", ITE_DESITE), DET_DESCRI, ITE_DESITE) ';
  End;

  Result := Result + ' ) ';
end;


Function TLeDocumentoLA.fGeraSqlCompra: String;
  Var
    strSQL: String;
Begin

  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE             ';
  strSQL := strSQL + '			  /*DADOS EMPRESA*/        ';
  strSQL := strSQL + '				EMP_NOMEMP AS NOMEMP,              ';
  strSQL := strSQL + '        CONCAT(EMP_ENDERE, CONCAT(", ", EMP_ENDNUM)) AS ENDEMP, ';
  strSQL := strSQL + '			  EMP_BAIRRO AS BAIEMP,              ';
  strSQL := strSQL + '			  EMP_C_E_P_ AS CEPEMP,              ';
  strSQL := strSQL + '			  EMP_FONE01 AS F01EMP,              ';
  strSQL := strSQL + '        C1.CID_NOMCID AS CIDEMP, ';

  strSQL := strSQL + '			  /*DADOS FORNECEDOR*/     ';
  strSQL := strSQL + '				FOR_CODFOR AS CODFOR,              ';
  strSQL := strSQL + '				FOR_NOMFOR AS NOMFOR,              ';
  strSQL := strSQL + '				FOR_ENDERE AS ENDFOR,              ';
  strSQL := strSQL + '				FOR_BAIRRO AS BAIFOR,              ';
  strSQL := strSQL + '				FOR_C_E_P_ AS CEPFOR,              ';
  strSQL := strSQL + '				FOR_CGCCPF AS DC1FOR,              ';
  strSQL := strSQL + '				FOR_C_G_C_ AS DC2FOR,              ';
  strSQL := strSQL + '				FOR_I_E_S_ AS DC3FOR,              ';
  strSQL := strSQL + '				FOR_FONE01 AS F01FOR,              ';
  strSQL := strSQL + '				C2.CID_NOMCID AS CIDFOR, ';

  strSQL := strSQL + '				/*DADOS ENTRADA*/             ';
  strSQL := strSQL + '				IF(PCG_NUMPED IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(PCG_NUMPED, " EMP: ", EMP_CODEMP)) AS DOCES1, ';
  strSQL := strSQL + '				IF(PCG_NUMPED IS NULL, "ITEM CONFERIDO SEM LASTRO COM NF", CONCAT(PCG_NUMPED, "NF")) AS DOCES2, ';

  strSQL := strSQL + '				PCG_NUMPED AS NUMDOC,        ';
  strSQL := strSQL + '				"PD" AS ESPDOC,           ';
  //strSQL := strSQL + QuotedStr(strCondicao) + ' AS CONPAG,';
  strSQL := strSQL + '			  VEN.OPE_CODOPE AS CODVEN,     ';
  strSQL := strSQL + '			  VEN.OPE_NOMOPE AS NOMOPE, ';
  strSQL := strSQL + '				PCG_DTAENT AS DTAENT,     ';
  strSQL := strSQL + '				PCG_HORENT AS HORENT,     ';
  strSQL := strSQL + '				VEN.OPE_NOMOPE AS NOMDIG,     ';

  strSQL := strSQL + '				/*ITENS DA ENTRADA*/         ';
  strSQL := strSQL + '				UNI_SIGUNI AS SIGUNI,                  ';
  strSQL := strSQL + '				PCD_CODITE AS CODITE,  ';
  strSQL := strSQL + '				ITE_DESITE AS DESITE,                  ';
  strSQL := strSQL + '				MAR_DESMAR AS DESMAR,                  ';
  If (recDocume.strModeloImpressao = '6') Then
    strSQL := strSQL + '			  SUM(PCD_QTDITE) AS QTDITE, '
  Else
    strSQL := strSQL + '				PCD_QTDITE AS QTDITE,  ';
  strSQL := strSQL + '				ITE_LOCFIS AS LOCFIS,                  ';
  strSQL := strSQL + '				ITE_REFERE AS REFERE,                  ';
  strSQL := strSQL + '				ITE_CODFAB AS CODFAB,                  ';
  strSQL := strSQL + '        ITE_CODBAR AS CODBAR,                  ';
  strSQL := strSQL + '        ITE_SALDOS AS SALDOS,                  ';
  strSQL := strSQL + '        0.00 AS QTDAGU,                  ';
  strSQL := strSQL + '        0.00 AS QTDFAL,                  ';
  If (recDocume.blnExiApl) Then
    strSQL := strSQL + ' REPLACE( SUBSTRING(ITE_APLICA, 1, 255), ''<<csq>>'',''  '') AS APLICA, ';
  strSQL := strSQL + '				" " AS ENTSAI ';

  if (recDocume.strModeloImpressao = '3') OR (recDocume.strModeloImpressao = '4')  OR (recDocume.strModeloImpressao = '5') OR (recDocume.strModeloImpressao = '8') Then
  Begin
    strSQL := strSQL + '      , ';
    strSQL := strSQL + '      ( SELECT CONCAT( IF( IFNULL(I.ITE_CODFAB,"") <> "", CONCAT(I.ITE_CODFAB, ","), ""), GROUP_CONCAT(IFNULL(IFNULL(ITEFOR.ITE_CODFAB, ITE_CODITF),""))) ';
    strSQL := strSQL + '        FROM ITEFOR    ';
    strSQL := strSQL + '        WHERE ITEFOR.ITE_CODITE = I.ITE_CODITE ) AS CDFABS, ';

    strSQL := strSQL + '      (                                        ';
    strSQL := strSQL + '      SELECT GROUP_CONCAT(IFNULL(ITEBAR.BAR_CODBAR,""))   ';
    strSQL := strSQL + '      FROM ITEBAR                              ';
    strSQL := strSQL + '      WHERE ITEBAR.BAR_CODITE = I.ITE_CODITE   ';
    strSQL := strSQL + '      ) AS CDBARS,                         ';
    strSQL := strSQL + '      ITE_LOCSUP AS LOCSUP, ';

    strSQL := strSQL + '       NULL AS NOTAS                           ';
  End;

  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   PCMDET D';

  strSQL := strSQL + '  JOIN PCMGER';
  strSQL := strSQL + '    ON PCG_NUMPED = PCD_NUMPED';
  strSQL := strSQL + '    AND PCG_ESPDOC = PCD_ESPDOC';
  strSQL := strSQL + '    AND PCG_CODEMP = PCD_CODEMP';

  strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.PCD_CODITE ';
  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = PCMGER.PCG_CODEMP';
  strSQL := strSQL + '  INNER JOIN ITEGER G ON G.ITE_CODITE = PCD_CODITE AND G.ITE_CODEMP = PCMGER.PCG_CODEMP';
  strSQL := strSQL + '   LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  strSQL := strSQL + '   LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + '   LEFT JOIN CADCID C1 ON C1.CID_CODCID = EMP_CODCID';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADCID C2 ON C2.CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = ' + strLoginUsuarioLogado.QuotedString;
  strSQL := strSQL + ' WHERE      ';
  strSQL := strSQL + '   LOCATE(PCG_NUMPED,:IDEDIG)';
  strSQL := strSQL + '   AND PCG_CODEMP = :CODEMP';
  strSQL := strSQL + '   AND PCG_ESPDOC = "PD"';

  strSQL := strSQL + ' GROUP BY       ';
  If recDocume.strModeloImpressao = '6' Then
  Begin
    strSQL := strSQL + '   D.PCD_CODITE ';
    strSQL := strSQL + ' ORDER BY ITE_DESITE ';
  End
  Else
    strSQL := strSQL + '   D.AUTOINCREM ';

  if (recDocume.strModeloImpressao = '3') or  (recDocume.strModeloImpressao = '4') OR (recDocume.strModeloImpressao = '5') OR (recDocume.strModeloImpressao = '8') Then
    strSQL := strSQL + ' ORDER BY ITE_LOCFIS ';

  result := strSQL;

end;

end.

