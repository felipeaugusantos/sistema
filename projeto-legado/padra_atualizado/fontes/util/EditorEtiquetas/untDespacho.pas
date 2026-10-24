(*

  Unit criada pois a etiqueta de despacho tem que conter as mesmas informaçoes
  no arquivo XML do correio quando utiliza o Sigep Web ( Pré-Postagem ) .

  AO ALTERAR O SQL DESTE UNIT VERIFICAR SE NAO VAI CAUSAR ALGUM EFEITO COLATERAL
  NA "untSIGEPWebImpl.pas"

*)
unit untDespacho;

interface

Uses System.SysUtils, System.DateUtils, StrUtils, untFuncoesSimples;


  Function fSQLDespacho(blnTesteL     : Boolean;
                        strNomTab,
                        strTipoFC,
                        strNumDoc,
                        strEspDoc     : String;
                        blnAbrirVazio : Boolean = False;
                        blnSigep      : Boolean = False;
                        blnB2W        : Boolean = False;
                        strCodCli     : String = '';
                        strCodEti     : String = '';
                        strMultPed   : String = ''): String;

  Function fSQLDespachoProduto(blnTesteL: Boolean;
                               strNomTab,
                               strTipoFC: String): String;

implementation

const cCliEndereco = 'CONCAT(C.CLI_ENDERE, IF(IFNULL(CLI_ENDNUM, "") <> "", CONCAT(", ",  CLI_ENDNUM), ""), IF(IFNULL(CLI_ENDCOM, "") <> "", CONCAT(" - ", CLI_ENDCOM), ""))';

function fValorSeguroSigep : String;
Begin
  Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
  Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_VRMSEG, CE.CID_VRMSEG), ';
  Result := Result + '    CC.CID_VRMSEG) '; // VALOR SEGURO
End;

function fPercentualSeguroSigep : String;
Begin
  Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
  Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_PERSEG, CE.CID_PERSEG), ';
  Result := Result + '    CC.CID_PERSEG) '; // PERCENTUAL SEGURO
End;


Function fRetEndereco(strFC: String; strTab: String; blnSigep: Boolean = False): String;
Begin
  Result := '';
  If strFC = 'F' Then
  Begin
    Result := Result + '  CONCAT(FOR_ENDERE, IF(IFNULL(FOR_ENDNUM, "") = "", "", CONCAT(", ", FOR_ENDNUM)), IF(IFNULL(FOR_ENDCOM, "") = "", "", CONCAT(", ", FOR_ENDCOM))) AS ENDCLI, ';
    Result := Result + '  C.FOR_BAIRRO  AS BAICLI, ';
    Result := Result + '  C.FOR_C_E_P_  AS CEPCLI, ';
    Result := Result + '  CF.CID_NOMCID AS NOMCID, ';
    Result := Result + '  CF.CID_ESTADO AS ESTADO, ';
    Result := Result + '  CONCAT(CF.CID_NOMCID,"-",CF.CID_ESTADO) AS CIDCLI, ';
    Result := Result + ' "" AS ENDCOM, '; //COMPLEMENTO (SERA IMPLEMENTADO NA 379.48.2.40) APENAS), A QUANTIDADE DE COLUNAS COM blnSigep / not blnSigep deve ser o mesmo.
    Result := Result + ' "" AS REFETR, ';
    Result := Result + ' 0  AS VALSEG, ';
    Result := Result + ' "" AS CLICOM, ';
  End
  Else
  Begin
    If strTab = 'FATGOR' Then
    Begin

      Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
      Result := Result + '        CONCAT(C.CLI_ENDERE,';
      Result := Result + '        IF(IFNULL(C.CLI_ENDNUM, "") = "", "", CONCAT(", ", C.CLI_ENDNUM)),';
      Result := Result + '        IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT(", ", C.CLI_ENDCOM))), G.FGO_ENDCON) AS ENCDSP, ';

      Result := Result + 'C.CLI_BAIRRO  AS BACDSP, ';
      Result := Result + 'C.CLI_C_E_P_  AS CECDSP, ';
      Result := Result + 'CF.CID_NOMCID AS CICDSP, ';

      If not blnSigep Then
      Begin
        Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
        Result := Result + '        IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "",';
        Result := Result + '        CONCAT(C.CLI_ENDERE,';
        Result := Result + '        IF(IFNULL(C.CLI_ENDNUM, "") = "", "", CONCAT(", ", C.CLI_ENDNUM)),';
        Result := Result + '        IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT(", ", C.CLI_ENDCOM))), ETC_ENDENT),  G.FGO_ENDCON) AS ENDCLI, ';

        Result := Result + ' "" AS ENDCOM, '; //COMPLEMENTO (SERA IMPLEMENTADO NA 379.48.2.40) APENAS), A QUANTIDADE DE COLUNAS COM blnSigep / not blnSigep deve ser o mesmo.
        Result := Result + ' 0  AS VALSEG, ';
      End
      Else
      Begin
        //Endereço sem o Complemento
        Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
        Result := Result + '        IF((ETC_ENDENT IS NULL OR ETC_ENDENT = "") OR (ETC_ENDFAT = "S"),';
        Result := Result + '        CONCAT(C.CLI_ENDERE,';
        Result := Result + '        IF(IFNULL(C.CLI_ENDNUM, "") = "", "", CONCAT(", ", C.CLI_ENDNUM))), ETC_ENDENT),  G.FGO_ENDCON) AS ENDCLI, ';

        //Somente o complemento ( se concactenar nao cabe no campo do XML, o Max é 50 caracteres)
        Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
        Result := Result + '        IF((ETC_ENDENT IS NULL OR ETC_ENDENT = "")  OR (ETC_ENDFAT = "S"),';
        Result := Result + '        CLI_ENDCOM, ""), "") AS ENDCOM, ';

        //Valor do seguro dos correios;
        Result := Result + 'IF((FGO_TOTPRO >= ' + fValorSeguroSigep + ') AND (' + fPercentualSeguroSigep + ' > 0), ';
        Result := Result + 'FGO_TOTPRO * ' + fPercentualSeguroSigep + ' / 100, 0 ) / (SELECT COUNT(0) FROM PLPDOC WHERE PLD_NUMDOC = FGO_NUMDOC AND PLD_ESPDOC = FGO_ESPDOC) AS VALSEG, ';

      End;

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_BAIRRO, ETC_BAIENT), ';
      Result := Result + '    G.FGO_BAICON) AS BAICLI, '; // BAIRRO

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_C_E_P_, ETC_CEPENT), ';
      Result := Result + '    G.FGO_CEPCON) AS CEPCLI, '; // CEP

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), ';
      Result := Result + '    CC.CID_NOMCID) AS NOMCID, '; // CIDADE

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), ';
      Result := Result + '    CC.CID_ESTADO) AS ESTADO, '; // ESTADO

      Result := Result + ' CLI_CAIPOS AS CAIPOS, ';

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_REFENT IS NULL OR ETC_REFENT = "", "", ETC_REFENT), ';
      Result := Result + '    "") AS REFETR, '; // REFERÊNCIA DO ENDEREÇO

      Result := Result + ' IF(' + cCliEndereco + ' = ETC_ENDENT, C.CLI_ENDCOM, "") AS CLICOM, ';

      Result := Result + '  CONCAT( ';

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), ';
      Result := Result + '    CC.CID_NOMCID),  ';

      Result := Result + '  "-", ';

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), ';
      Result := Result + '    CC.CID_ESTADO)) AS CIDCLI, '; // CIDADE - ESTADO
    End
    Else
    Begin

      Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
      Result := Result + '        CONCAT(C.CLI_ENDERE,';
      Result := Result + '        IF(IFNULL(C.CLI_ENDNUM, "") = "", "", CONCAT(", ", C.CLI_ENDNUM)),';
      Result := Result + '        IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT(", ", C.CLI_ENDCOM))), GER_ENDCON) AS ENCDSP, ';

      Result := Result + 'C.CLI_BAIRRO  AS BACDSP, ';
      Result := Result + 'C.CLI_C_E_P_  AS CECDSP, ';
      Result := Result + 'CF.CID_NOMCID AS CICDSP, ';

      If not blnSigep Then
      Begin
        Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
        Result := Result + '        IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "",';
        Result := Result + '        CONCAT(C.CLI_ENDERE,';
        Result := Result + '        IF(IFNULL(C.CLI_ENDNUM, "") = "", "", CONCAT(", ", C.CLI_ENDNUM)),';
        Result := Result + '        IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT(", ", C.CLI_ENDCOM))), ETC_ENDENT),  GER_ENDCON) AS ENDCLI, ';
        Result := Result + ' 0  AS VALSEG, ';
      End
      Else
      Begin
        //Endereço sem o Complemento
        Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
        Result := Result + '        IF((ETC_ENDENT IS NULL OR ETC_ENDENT = "")  OR (ETC_ENDFAT = "S"),';
        Result := Result + '        CONCAT(C.CLI_ENDERE,';
        Result := Result + '        IF(IFNULL(C.CLI_ENDNUM, "") = "", "", CONCAT(", ", C.CLI_ENDNUM))), ETC_ENDENT),  GER_ENDCON) AS ENDCLI, ';

        //Valor do seguro dos correios;
        Result := Result + 'IF((GER_TOTPRO >= ' + fValorSeguroSigep + ') AND (' + fPercentualSeguroSigep + ' > 0), ';
        Result := Result + 'GER_TOTPRO * ' + fPercentualSeguroSigep + ' / 100, 0 ) / ( SELECT COUNT(0) FROM PLPDOC WHERE PLD_NUMDOC = GER_NUMDOC AND PLD_ESPDOC = GER_ESPDOC AND PLD_SERIE_ = GER_SERIE_) AS VALSEG, ';
      End;

      Result := Result + 'IF( C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", IF( ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_ENDCOM, ETC_REFENT ), "" ) AS COENCL, ';

      Result := Result + 'IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%",';
      Result := Result + '        IF(ETC_ENDENT IS NULL OR ETC_ENDENT = ""  OR (ETC_ENDFAT = "S"),';
      Result := Result + '        C.CLI_ENDCOM, ETC_REFENT), "") AS ENDCOM, ';

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_BAIRRO, ETC_BAIENT), ';
      Result := Result + '    G.GER_BAICON) AS BAICLI, '; // BAIRRO

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", C.CLI_C_E_P_, ETC_CEPENT), ';
      Result := Result + '    G.GER_CEPCON) AS CEPCLI, '; // CEP

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), ';
      Result := Result + '    CC.CID_NOMCID) AS NOMCID, '; // CIDADE

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), ';
      Result := Result + '    CC.CID_ESTADO) AS ESTADO, '; // ESTADO

      Result := Result + ' CLI_CAIPOS AS CAIPOS, ';

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_REFENT IS NULL OR ETC_REFENT = "", "", ETC_REFENT), ';
      Result := Result + '    "") AS REFETR, '; // REFERÊNCIA DO ENDEREÇO

      Result := Result + ' IF(' + cCliEndereco + ' = ETC_ENDENT, C.CLI_ENDCOM, "") AS CLICOM, ';

      Result := Result + '  CONCAT( ';

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_NOMCID, CE.CID_NOMCID), ';
      Result := Result + '    CC.CID_NOMCID),  ';

      Result := Result + '  "-", ';

      Result := Result + '  IF(C.CLI_NOMCLI NOT LIKE "%CONSUMIDOR%", ';
      Result := Result + '    IF(ETC_ENDENT IS NULL OR ETC_ENDENT = "", CF.CID_ESTADO, CE.CID_ESTADO), ';
      Result := Result + '    CC.CID_ESTADO)) AS CIDCLI, '; // CIDADE - ESTADO
    End;
  End;
End;

Function fSQLDespacho(blnTesteL     : Boolean;
                      strNomTab,
                      strTipoFC,
                      strNumDoc,
                      strEspDoc     : String;
                      blnAbrirVazio : Boolean;
                      blnSigep      : Boolean;
                      blnB2W        : Boolean;
                      strCodCli     : String;
                      strCodEti     : String;
                      strMultPed   : String): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  If blnTesteL Then
    strSQL := strSQL + '(';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' "00000000000/00000000000" AS QTDVOL, ';
  strSQL := strSQL + ' 12345678 AS SEQVOL, ';
  strSQL := strSQL + ' "DDDDDDDDDDDDTTEEEVVVTTT" AS CODBAR, ';
  strSQL := strSQL + ' "001/001" AS QTDVO2, ';

  If blnSigep Then
  Begin
    strSQL := strSQL + ' COB_NUMOBJ AS NUMOBJ, ';
    strSQL := strSQL + ' COB_OBJDIG AS OBJDIG, ';
    strSQL := strSQL + ' PLD_DATA2D AS DATA2D, ';
    strSQL := strSQL + ' (SELECT CFG_NUMCON FROM CORCFG WHERE CFG_STATUS = "A" AND CFG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' LIMIT 1) AS NUMCON, ';
  End
  Else
  Begin
    strSQL := strSQL + ' "               " AS NUMOBJ, ';
    strSQL := strSQL + ' "               " AS OBJDIG, ';
    strSQL := strSQL + ' CAST("06823110000001409657000000951QD861687032BR2500000000000071527788046690000000                    00000000000000000-00.000000-00.000000|" AS CHAR(200))  AS DATA2D, ';
    strSQL := strSQL + ' "                     " AS NUMCON, ';
  End;

  If blnB2W Then
  Begin
    strSQL := strSQL + ' PLPB2W.PLP_CODIGO AS CODPLP, ';
    strSQL := strSQL + ' PLPB2W.PLP_DTAPRO AS DTAPRO, ';
    strSQL := strSQL + ' PLPB2W.PLP_CODAWB AS CODAWB, ';
    strSQL := strSQL + ' PLPB2W.PLP_BASROT AS BASROT, ';
    strSQL := strSQL + ' PLPB2W.PLP_MEGROT AS MEGROT, ';
  End
  Else
  Begin
    strSQL := strSQL + ' "                    " AS CODPLP, ';
    strSQL := strSQL + ' "                    " AS DTAPRO, ';
    strSQL := strSQL + ' "                    " AS CODAWB, ';
    strSQL := strSQL + ' "                    " AS BASROT, ';
    strSQL := strSQL + ' "                    " AS MEGROT, ';
  End;

  If strNomTab = 'FATGOR' Then
  Begin
    If fEmptyStr(strMultPed) Then
    Begin
      strSQL := strSQL + ' FGO_TOTPRO AS TOTPRO, ';
      strSQL := strSQL + ' FGO_VLRCON AS VLRCON, ';
    End
    Else
    Begin
      strSQL := strSQL + ' SUM(FGO_TOTPRO) AS TOTPRO, ';
      strSQL := strSQL + ' SUM(FGO_VLRCON) AS VLRCON, ';
    End;

    If (blnB2W) Then
      strSQL := strSQL + ' CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT) AS NUMDOC, '
    Else
    Begin
      If fEmptyStr(strMultPed) Then
      begin
        strSQL := strSQL + ' CAST(CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_SERIE_) AS CHAR(255)) AS NUMDOC, ';
        strSQL := strSQL + ' CAST(CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC) AS CHAR(255)) AS CODDOC, ';
      end
      Else
      begin
        strSQL := strSQL + ' CAST(CONCAT((SELECT GROUP_CONCAT(FGO_NUMDOC)),"-",FGO_ESPDOC, "-", FGO_SERIE_) AS CHAR(255)) AS NUMDOC, ';
        strSQL := strSQL + ' CAST(CONCAT((SELECT GROUP_CONCAT(FGO_NUMDOC)),"-",FGO_ESPDOC) AS CHAR(255)) AS CODDOC, ';
      end;
    End;

    If ((strCodEti = 'tpeEtiquetaDespachoVolumeGeralArgox') Or (strCodEti = 'tpeEtiquetaDespachoVolumeGeralLaser')) Then
      strSQL := strSQL + ' FGO_NUMDOC AS NUMDOCXML, '
    Else
      strSQL := strSQL + ' "       " AS NUMDOCXML, ';

    strSQL := strSQL + ' "  " AS SERDOC, ';

    strSQL := strSQL + ' FGO_DTAFAT AS DTAFAT, ';
    strSQL := strSQL + ' FGO_DTAENT AS DTAENT, ';
    strSQL := strSQL + ' FGO_HORENT AS HORENT, ';
    strSQL := strSQL + ' FGO_DTENTR AS DTENTR, ';
    strSQL := strSQL + fSQLTipoFrete('FGO_TIPFRE') + ' AS DESFRE, ';
    strSQL := strSQL + ' FGO_TOTFRE AS TOTFRE, ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS CHAACE, ';

    strSQL := strSQL + ' FGO_DTAENT AS DTAPED, ';
    strSQL := strSQL + ' FGO_HORENT AS HORPED, ';
    strSQL := strSQL + ' FGO_ESPECI AS ESPECI, ';
  End
  Else
  Begin
    strSQL := strSQL + ' G.GER_TOTPRO AS TOTPRO, ';
    strSQL := strSQL + ' G.GER_VLRCON AS VLRCON, ';
    strSQL := strSQL + ' CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_SERIE_) AS NUMDOC, ';
    strSQL := strSQL + ' CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC) AS CODDOC, ';
    strSQL := strSQL + ' G.GER_NUMDOC AS NUMDOCXML, ';
    strSQL := strSQL + ' G.GER_DTAENT AS DTAENT, ';
    strSQL := strSQL + ' G.GER_HORENT AS HORENT, ';
    strSQL := strSQL + fSQLTipoFrete('G.GER_TIPFRE') + ' AS DESFRE, ';
    strSQL := strSQL + ' G.GER_TOTFRE AS TOTFRE, ';
    strSQL := strSQL + '   FIS_ACESSO AS CHAACE, ';

    If blnSigep Then
      strSQL := strSQL + ' G.GER_NUMDOC AS NUMDOC, '
    Else
      strSQL := strSQL + ' CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_SERIE_) AS NUMDOC, ';

    strSQL := strSQL + ' CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC) AS CODDOC, ';
    strSQL := strSQL + ' IFNULL(G.GER_SERIE_,"") AS SERDOC, ';
    strSQL := strSQL + ' GER_DTAENT AS DTAFAT, ';
    strSQL := strSQL + ' GER_DTENTR AS DTENTR, ';

    strSQL := strSQL + ' IFNULL((SELECT FGO_DTAENT ';
    strSQL := strSQL + '    FROM MOVDET MD          ';
    strSQL := strSQL + '    JOIN FATDOR FD ON FD.FDO_NUMDOC = MD.DET_NUM_PD ';
    strSQL := strSQL + '                  AND FD.FDO_ESPDOC = MD.DET_ESP_PD ';
    strSQL := strSQL + '                  AND FD.FDO_CODEMP = MD.DET_EMP_PD ';
    strSQL := strSQL + '    JOIN FATGOR FG ON FG.AUTOINCREM = FD.FDO_SEQGER ';
    strSQL := strSQL + '    WHERE MD.DET_NUMDOC = G.GER_NUMDOC              ';
    strSQL := strSQL + '      AND MD.DET_ESPDOC = G.GER_ESPDOC              ';
    strSQL := strSQL + '      AND MD.DET_CODEMP = G.GER_CODEMP              ';
    strSQL := strSQL + '    LIMIT 1), "") AS DTAPED,                        ';

    strSQL := strSQL + ' IFNULL((SELECT FGO_HORENT                          ';
    strSQL := strSQL + '    FROM MOVDET MD                                  ';
    strSQL := strSQL + '    JOIN FATDOR FD ON FD.FDO_NUMDOC = MD.DET_NUM_PD ';
    strSQL := strSQL + '                  AND FD.FDO_ESPDOC = MD.DET_ESP_PD ';
    strSQL := strSQL + '                  AND FD.FDO_CODEMP = MD.DET_EMP_PD ';
    strSQL := strSQL + '    JOIN FATGOR FG ON FG.AUTOINCREM = FD.FDO_SEQGER ';
    strSQL := strSQL + '   WHERE MD.DET_NUMDOC = G.GER_NUMDOC               ';
    strSQL := strSQL + '     AND MD.DET_ESPDOC = G.GER_ESPDOC               ';
    strSQL := strSQL + '     AND MD.DET_CODEMP = G.GER_CODEMP               ';
    strSQL := strSQL + '   LIMIT 1), "") AS HORPED,                         ';
    strSQL := strSQL + ' GER_ESPECI AS ESPECI, ';
  End;

  strSQL := strSQL + '  E.EMP_CODEMP  AS CODEMP, ';
  strSQL := strSQL + '  E.EMP_NOMEMP  AS NOMEMP, ';
  strSQL := strSQL + '  CONCAT(E.EMP_ENDERE, ", ", E.EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS ENDEMP, ';
  strSQL := strSQL + '  CONCAT(E.EMP_ENDERE, ", ", E.EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))," - ",E.EMP_BAIRRO," - ",C1.CID_NOMCID,"-",C1.CID_ESTADO) AS ENEMP2, ';
  strSQL := strSQL + '  E.EMP_C_E_P_  AS CEPEMP, ';
  strSQL := strSQL + '  CONCAT(C1.CID_NOMCID,"-",C1.CID_ESTADO) AS CIDEMP, ';
  strSQL := strSQL + '  E.EMP_FONE01  AS FONEMP, ';

  If strTipoFC = 'C' Then
  Begin
    strSQL := strSQL + '  C.CLI_CODCLI  AS CODCLI, ';
    strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_NOMCLI) > 0 ) AND (G.GER_NOMCON IS NOT NULL)), G.GER_NOMCON, C.CLI_NOMCLI) AS NOMCLI, ';
    strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_NOMCLI) > 0 ) AND (G.GER_NOMCON IS NOT NULL)), G.GER_TELCON, C.CLI_FONE01) AS FONCLI, ';
    strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_FANSOB) > 0 ) AND (G.GER_NOMCON IS NOT NULL)), G.GER_NOMCON, C.CLI_FANSOB) AS FANSOB, ';
  End
  Else
  Begin
    strSQL := strSQL + '  C.FOR_CODFOR  AS CODCLI, ';
    strSQL := strSQL + '  C.FOR_NOMFOR  AS NOMCLI, ';
    strSQL := strSQL + '  C.FOR_FONE01  AS FONCLI, ';
    strSQL := strSQL + '  C.FOR_NOMFAN  AS FANSOB, ';
  End;

  strSQL := strSQL + fRetEndereco(strTipoFC, strNomTab, blnSigep);

  If fEmptyStr(strMultPed) Then
    strSQL := strSQL + '  G.GER_PESBRU  AS PESBRU, '
  Else
    strSQL := strSQL + '  SUM(G.GER_PESBRU)  AS PESBRU, ';

  strSQL := strSQL + '  G.GER_TIP_FC  AS TIP_FC, ';
  strSQL := strSQL + '  T.TRA_NOMTRA  AS NOMTRA, ';
  strSQL := strSQL + '  T.TRA_NOMFAN  AS FANTRA, ';
  strSQL := strSQL + '  T.TRA_ENDERE  AS ENDTRA, ';
  strSQL := strSQL + '  TC.CID_NOMCID AS CIDTRA, ';
  strSQL := strSQL + '  TC.CID_ESTADO AS UF_TRA, ';
  strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('T.TRA_CGCCPF', 'T.TRA_C_G_C_') +'  AS CGCTRA, ';
  strSQL := strSQL + '  T.TRA_I_E_S_  AS IESTRA, ';
  strSQL := strSQL + '  T.TRA_FONE01  AS F01TRA, ';
  strSQL := strSQL + '  T.TRA_FONE02  AS F02TRA, ';
  strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('1', 'E.EMP_C_G_C_') +'  AS CGCEMP, ';
  strSQL := strSQL + '  E.EMP_I_E_S_  AS IESEMP, ';

 If strTipoFC = 'C' Then
  Begin
    strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('C.CLI_CGCCPF', 'C.CLI_C_G_C_') +' AS CGCCLI, ';
    strSQL := strSQL + '  C.CLI_I_E_S_ AS IESCLI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('C.FOR_CGCCPF', 'C.FOR_C_G_C_') + ' AS CGCCLI, ';
    strSQL := strSQL + '  C.FOR_I_E_S_ AS IESCLI, ';
  End;

  If strNomTab = 'FATGOR' Then
  Begin

    if fCfgSis('B2WIMP', varBoolean) then
    begin
      strSQL := strSQL + '  IF(                                    ';
      strSQL := strSQL + '    TRIM(COALESCE(FGO_NUMPOK, "")) = "", ';
      strSQL := strSQL + '    FGO_NUMDOC,                          ';
      strSQL := strSQL + '    SUBSTR(                              ';
      strSQL := strSQL + '      FGO_NUMPOK,                        ';
      strSQL := strSQL + '      POSITION("-" IN FGO_NUMPOK) + 1,   ';
      strSQL := strSQL + '      LENGTH(FGO_NUMPOK)                 ';
      strSQL := strSQL + '    )                                    ';
      strSQL := strSQL + '  ) AS PEDVEN,                           ';
    end
    else
    begin
      If fEmptyStr(strMultPed) Then
        strSQL := strSQL + ' CAST(FGO_NUMDOC AS CHAR(255)) AS PEDVEN, '
      Else
        strSQL := strSQL + ' CAST((SELECT GROUP_CONCAT(FGO_NUMDOC)) AS CHAR(255)) AS PEDVEN, ';
    end;

    strSQL := strSQL + '  (SELECT GROUP_CONCAT(CMP_NUMCMP) FROM NUMCMP WHERE ';
    strSQL := strSQL + '   CMP_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + '  ) PEDCOM, ';
  End
  Else
  Begin

    (********************************************************)
    (* PEGA DO DET_NUM_PD POIS 'FGO_NUMFAT' SÓ É PREENCHIDO *)
    (* QUANDO O PEDIDO É BAIXADO TOTALMENTE, DEIXANDO EM    *)
    (* BRANCO QUANDO PARCIAL                                *)
    (*****************************************************RN*)
    if fCfgSis('B2WIMP', varBoolean) then
    begin

      strSQL := strSQL + '(SELECT                                    ';
      strSQL := strSQL + '  IF (                                     ';
      strSQL := strSQL + '    TRIM(COALESCE(F.FGO_NUMPOK, "")) = "", ';
      strSQL := strSQL + '    D.DET_NUM_PD,                          ';
      strSQL := strSQL + '    SUBSTR(                                ';
      strSQL := strSQL + '      F.FGO_NUMPOK,                        ';
      strSQL := strSQL + '      POSITION("-" IN F.FGO_NUMPOK) + 1,   ';
      strSQL := strSQL + '      LENGTH(F.FGO_NUMPOK)                 ';
      strSQL := strSQL + '    )                                      ';
      strSQL := strSQL + '  ) AS PEDVEN                              ';
      strSQL := strSQL + 'FROM                                       ';
      strSQL := strSQL + '  MOVDET D                                 ';
      strSQL := strSQL + '  LEFT JOIN FATGOR F                       ';
      strSQL := strSQL + '    ON F.FGO_NUMDOC = D.DET_NUM_PD         ';
      strSQL := strSQL + '    AND F.FGO_ESPDOC = D.DET_ESP_PD        ';
      strSQL := strSQL + '    AND F.FGO_CODEMP = D.DET_EMP_PD        ';

      if not fEmptyStr(strCodCli) then
        strSQL := strSQL + ' AND F.FGO_CODCLI = D.DET_CODCLI         ';

      strSQL := strSQL + 'WHERE D.DET_NUMDOC = G.GER_NUMDOC          ';
      strSQL := strSQL + '  AND D.DET_ESPDOC = G.GER_ESPDOC          ';
      strSQL := strSQL + '  AND D.DET_CODEMP = G.GER_CODEMP          ';

      if not fEmptyStr(strCodCli) then
        strSQL := strSQL + ' AND D.DET_CODCLI = G.GER_CODCLI         ';

      strSQL := strSQL + 'LIMIT 1) PEDVEN,                           ';
    end
    else
    begin
      strSQL := strSQL + '  (SELECT                                  ';
      strSQL := strSQL + '    DET_NUM_PD                             ';
      strSQL := strSQL + '  FROM                                     ';
      strSQL := strSQL + '    MOVDET                                 ';
      strSQL := strSQL + '  WHERE DET_NUMDOC = G.GER_NUMDOC          ';
      strSQL := strSQL + '    AND DET_ESPDOC = G.GER_ESPDOC          ';
      strSQL := strSQL + '    AND DET_CODEMP = G.GER_CODEMP          ';

      if not fEmptyStr(strCodCli) then
        strSQL := strSQL + '  AND DET_CODCLI = G.GER_CODCLI          ';

      strSQL := strSQL + 'LIMIT 1) PEDVEN,                           ';
    end;

    strSQL := strSQL + '  (SELECT GROUP_CONCAT(CMP_NUMCMP)                      ';
    strSQL := strSQL + '     FROM NUMCMP                                        ';
    strSQL := strSQL + '    WHERE CMP_NUMDOC = (SELECT DET_NUM_PD FROM MOVDET WHERE DET_NUMDOC = G.GER_NUMDOC AND DET_ESPDOC = G.GER_ESPDOC AND DET_CODEMP = G.GER_CODEMP LIMIT 1) ';
    strSQL := strSQL + '      AND CMP_ESPDOC = (SELECT DET_ESP_PD FROM MOVDET WHERE DET_NUMDOC = G.GER_NUMDOC AND DET_ESPDOC = G.GER_ESPDOC AND DET_CODEMP = G.GER_CODEMP LIMIT 1) ';
    strSQL := strSQL + '      AND CMP_CODEMP = (SELECT DET_EMP_PD FROM MOVDET WHERE DET_NUMDOC = G.GER_NUMDOC AND DET_ESPDOC = G.GER_ESPDOC AND DET_CODEMP = G.GER_CODEMP LIMIT 1) ';
    strSQL := strSQL + '   ) PEDCOM, ';

  End;

  strSQL := strSQL + ' (SELECT CF.OPE_NOMOPE FROM CADOPE CF WHERE CF.OPE_CODOPE = GER_OPEEXP) AS CONFER, ';

  if (strNomTab = 'FATGOR') then
  begin
    if (fCfgSis('BAISEP', varBoolean)) then
      strSQL := strSQL + ' (SELECT BX.OPE_NOMOPE FROM CADOPE BX WHERE BX.OPE_CODOPE = EX.FGO_OPBXSE) AS SEPARA, '
    else
      strSQL := strSQL + ' (SELECT BX.OPE_NOMOPE FROM CADOPE BX WHERE BX.OPE_CODOPE = IFNULL(EX.FGO_SEPEXP, EX.FGO_SEPRET)) AS SEPARA, ';
  end
  else if (strNomTab = 'NOTGER') then
    strSQL := strSQL + ' (SELECT SP.OPE_NOMOPE FROM CADOPE SP WHERE SP.OPE_CODOPE = GER_OPEEXP) AS SEPARA, '
  else
    strSQL := strSQL + ' (SELECT SP.OPE_NOMOPE FROM CADOPE SP WHERE SP.OPE_CODOPE = GER_SEPEXP) AS SEPARA, ';

  strSQL := strSQL + ' (SELECT VE.OPE_NOMOPE FROM CADOPE VE WHERE VE.OPE_CODOPE = GER_CODVEN) AS NOMVEN, ';

  If strNomTab = 'NOTGER' Then
    strSQL := strSQL + ' (SELECT LB.OPE_NOMOPE FROM CADOPE LB WHERE LB.OPE_CODOPE = GER_OPEEXP) AS OPELIB, '
  else
    strSQL := strSQL + ' (SELECT LB.OPE_NOMOPE FROM CADOPE LB WHERE LB.OPE_CODOPE = GER_OPLBEX) AS OPELIB, ';

  If strNomTab = 'FATGOR' Then
  Begin
    If fEmptyStr(strMultPed) Then
      strSQL := strSQL + ' (SELECT SUM(FDO_QTDITE) FROM FATDOR D WHERE G.AUTOINCREM = D.FDO_SEQGER) AS QTDITE, '
    Else
      strSQL := strSQL + ' SUM((SELECT SUM(FDO_QTDITE) FROM FATDOR D WHERE G.AUTOINCREM = D.FDO_SEQGER)) AS QTDITE, ';

    strSQL := strSQL + ' IF(G.FGO_ENTFAT = "S", "ENT", "RET") AS ENTFAT, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", FDO_SEQINV, CHAR(13)) SEPARATOR "") FROM (SELECT FDO_SEQINV, COUNT(DISTINCT FDO_SEQINV) CONTADOR FROM EXTDOR ';

    If fEmptyStr(strMultPed) Then
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO WHERE FDO_NUMDOC IN ('+strMultPed+') AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP ';

    strSQL := strSQL + ' GROUP BY FDO_SEQINV) SEQ) AS ITESEQ, ';


    If fEmptyStr(strMultPed) Then
    Begin
      strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", FDO_QTDITE, CHAR(13)) SEPARATOR "") FROM (SELECT FDO_QTDITE, COUNT(DISTINCT FDO_QTDITE) CONTADOR FROM EXTDOR ';
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP ';
    End
    Else
    Begin
      strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", FDO_QTDITE, CHAR(13)) SEPARATOR "") FROM (SELECT SUM(FDO_QTDITE) AS FDO_QTDITE, COUNT(DISTINCT FDO_QTDITE) CONTADOR FROM EXTDOR ';
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO WHERE FDO_NUMDOC IN ('+strMultPed+') AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP ';
    End;


    strSQL := strSQL + ' GROUP BY FDO_SEQINV) SEQ) AS ITEQTD, ';

    strSQL := strSQL + '  (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_CODFAB, CHAR(13)) SEPARATOR "") FROM (SELECT ITE_CODFAB, COUNT(DISTINCT ITE_CODFAB) CONTADOR FROM EXTDOR ';

    If fEmptyStr(strMultPed) Then
      strSQL := strSQL + '  LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC IN ('+strMultPed+') AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP ';

    strSQL := strSQL + '  GROUP BY FDO_SEQINV) SEQ) AS CODFAB, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_DESSIM, CHAR(13)) SEPARATOR "") FROM (SELECT ITE_DESSIM, COUNT(DISTINCT ITE_DESSIM) CONTADOR FROM EXTDOR ';

    If fEmptyStr(strMultPed) Then
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC IN ('+strMultPed+') AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP ';

    strSQL := strSQL + ' GROUP BY FDO_SEQINV) SEQ) AS DESITE, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_CODITE, CHAR(130)) SEPARATOR "") FROM (SELECT ITE_CODITE, COUNT(DISTINCT ITE_CODITE) CONTADOR FROM EXTDOR ';

    If fEmptyStr(strMultPed) Then
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC IN ('+strMultPed+') AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP ';

    strSQL := strSQL + ' GROUP BY FDO_SEQINV) SEQ) AS CODITE, ';


    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_DESITE, CHAR(13)) SEPARATOR "") FROM (SELECT ITE_DESITE, COUNT(DISTINCT ITE_DESITE) CONTADOR FROM EXTDOR ';

    If fEmptyStr(strMultPed) Then
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + ' LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO LEFT JOIN CADITE I ON I.ITE_CODITE = FDO_CODITE WHERE FDO_NUMDOC IN ('+strMultPed+') AND FDO_ESPDOC = :ESPDOC AND FDO_CODEMP = :CODEMP ';

    strSQL := strSQL + ' GROUP BY FDO_SEQINV) SEQ) AS DESCIT, ';

  End
  Else
  Begin
    strSQL := strSQL + ' (SELECT SUM(DET_QTDITE) FROM MOVDET D WHERE G.AUTOINCREM = D.DET_SEQGER) AS QTDITE, ';
    strSQL := strSQL + ' IF(G.GER_ENTFAT = "S", "ENT", "RET") AS ENTFAT, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", FDO_SEQINV, CHAR(13)) SEPARATOR "") FROM MOVDET ';
    strSQL := strSQL + ' LEFT JOIN FATDOR AS FD ON DET_NUM_PD  = FDO_NUMDOC AND DET_ESP_PD = FDO_ESPDOC AND DET_EMP_PD = FDO_CODEMP AND DET_CODITE = FDO_CODITE ';
    strSQL := strSQL + ' LEFT JOIN EXTDOR AS ED ON ED.FDO_SEQFDO = FD.AUTOINCREM  WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP ';
    strSQL := strSQL + ' GROUP BY DET_NUMDOC) AS ITESEQ, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", DET_QTDITE, CHAR(13)) SEPARATOR "") FROM MOVDET WHERE DET_NUMDOC = :NUMDOC  ';
    strSQL := strSQL + '   AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP GROUP BY DET_NUMDOC) AS ITEQTD, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_CODFAB, CHAR(13)) SEPARATOR "") FROM MOVDET LEFT JOIN CADITE I ON I.ITE_CODITE = DET_CODITE  ';
    strSQL := strSQL + '  WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP GROUP BY DET_NUMDOC) AS CODFAB, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_DESSIM, CHAR(13)) SEPARATOR "") FROM MOVDET LEFT JOIN CADITE I ON I.ITE_CODITE = DET_CODITE  ';
    strSQL := strSQL + '  WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP GROUP BY DET_NUMDOC) AS DESITE, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_CODITE, CHAR(13)) SEPARATOR "") FROM MOVDET LEFT JOIN CADITE I ON I.ITE_CODITE = DET_CODITE  ';
    strSQL := strSQL + '  WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP GROUP BY DET_NUMDOC) AS CODITE, ';

    strSQL := strSQL + ' (SELECT GROUP_CONCAT(CONCAT_WS("", ITE_DESITE, CHAR(13)) SEPARATOR "") FROM MOVDET LEFT JOIN CADITE I ON I.ITE_CODITE = DET_CODITE  ';
    strSQL := strSQL + '  WHERE DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_CODEMP = :CODEMP GROUP BY DET_NUMDOC) AS DESCIT, ';

  End;

  If strTipoFC = 'C' Then
  Begin
    strSQL := strSQL + ' RG.REG_DESREG AS DESREG, ';
    strSQL := strSQL + ' RG.REG_CODREG AS CODREG, ';
    strSQL := strSQL + '    ENT_DTAENT AS DATENT  ';
  End
  Else
  Begin
    strSQL := strSQL + ' "" AS DESREG, ';
    strSQL := strSQL + ' "" AS CODREG, ';
    strSQL := strSQL + ' "" AS DATENT  ';
  End;

  strSQL := strSQL + ' ,MANDOC.MAN_CODRAS AS TRACID ';
  strSQL := strSQL + ' ,PEDJAD.JAD_SHIPME AS SHIPME ';
  strSQL := strSQL + ' ,ETIJAD.JAD_ROTENT AS ROTENT ';
  strSQL := strSQL + ' ,ETIJAD.JAD_POSICA AS POSICA ';
  strSQL := strSQL + ' ,ETIJAD.JAD_PRIORI AS PRIORI ';
  strSQL := strSQL + ' ,ETIJAD.JAD_R_U_A_ AS JADRUA ';
  strSQL := strSQL + ' ,ETIJAD.JAD_UNIDES AS UNIDES ';
  strSQL := strSQL + ' ,ETIJAD.JAD_CODBAR AS BARJAD ';
  strSQL := strSQL + ' ,CONCAT(PEDJAD.JAD_SHIPME, "$001") AS BARSHI ';
  strSQL := strSQL + ' ,ETIJAD.JAD_LASTMI AS LASTMI ';

  If fEmptyStr(strMultPed) Then
    strSQL := strSQL + ' ,G.GER_PESLIQ AS PESLIQ, '
  Else
    strSQL := strSQL + ' ,SUM(G.GER_PESLIQ) AS PESLIQ, ';

  If strNomTab = 'FATGOR' Then
     strSQL := strSQL + fSQLBarDoc('FGO') + ' AS BARDOC, '
  else
     strSQL := strSQL + fSQLBarDoc('GER') + ' AS BARDOC, ';

  If (strNomTab = 'FATGOR') Then
    strSQL := strSQL + '  CAST("" AS CHAR(50)) AS CHAVNF, '
  Else
    strSQL := strSQL + '  FIS_ACESSO AS CHAVNF, ';

  if strTipoFC = 'C' Then
  begin
    strSQL := strSQL + '    ETC_CODREG AS REGCOD, ';
    strSQL := strSQL + ' CR.REG_DESREG AS REGDES,  ';
    strSQL := strSQL + 'CDR.REG_DESREG AS REGENT,  ';
    strSQL := strSQL + 'CD.RED_DESRED AS DESRED,  ';
    strSQL := strSQL + 'C.CLI_CODRED AS CODRED  ';
  end
  else
  begin
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS REGCOD, ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS REGDES, ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS REGENT,  ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS DESRED,  ';
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS CODRED  ';
  end;

  If ((strCodEti = 'tpeEtiquetaDespachoVolumeIndividualArgox') Or (strCodEti = 'tpeEtiquetaDespachoVolumeIndividualLaser')) Then
  Begin
    strSQL := strSQL + ' ,ETIEVC.EVC_DESCRI AS EVCDES ';
    strSQL := strSQL + ' ,ETIEVC.EVC_SIGLA_ AS EVCSIG ';
    strSQL := strSQL + ' ,ETIEVC.EVC_VOLUME AS EVCVOL ';
  End
  Else
  Begin
    strSQL := strSQL + ' ,CAST("" AS CHAR(20)) AS EVCDES ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(10)) AS EVCSIG ';
    strSQL := strSQL + ' ,0 AS EVCVOL ';
  End;

  strSQL := strSQL + ' ,CAST("" AS CHAR(2000)) AS ETIVOL  ';
  strSQL := strSQL + ' ,CAST("" AS CHAR(2000)) AS ETIITE ';
  strSQL := strSQL + ' ,CAST("000" AS CHAR(3)) AS TOTVOL ';

  If strNomTab = 'FATGOR' Then
     strSQL := strSQL + ' , CONCAT(G.FGO_MEN001, " ", G.FGO_MEN002) AS MENPED '
  else
     strSQL := strSQL + ' , CONCAT(G.GER_MEN001, " ", G.GER_MEN002, " ", G.GER_MEN003, " ", G.GER_MEN004, " ", G.GER_MEN005) AS MENPED ';

  If strNomTab = 'FATGOR' Then
  begin
    strSQL := strSQL + ' ,(SELECT GROUP_CONCAT(DISTINCT E.FDO_NUMCMP) ';
    strSQL := strSQL + '     FROM FATDOR F ';
    strSQL := strSQL + '     LEFT JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ';
    strSQL := strSQL + '    WHERE F.FDO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '      AND F.FDO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '      AND F.FDO_CODEMP = :CODEMP) AS NUMCMP ';
  end
  else
  begin
    strSQL := strSQL + ' ,(SELECT GROUP_CONCAT(DISTINCT T.DET_NUMCMP) ';
    strSQL := strSQL + '     FROM MOVDET D ';
    strSQL := strSQL + '     LEFT JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ';
    strSQL := strSQL + '    WHERE D.DET_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '      AND D.DET_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '      AND D.DET_CODEMP = :CODEMP) AS NUMCMP ';
  end;

  If strNomTab = 'FATGOR' Then
  begin
   	strSQL := strSQL + ' ,CAST("" AS CHAR(10)) AS NUMROM ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS CNF_FF  ';
    strSQL := strSQL + ' ,CAST("" AS CHAR(1)) AS CNFMNO  ';
  end
  else
  begin
    strSQL := strSQL + ' ,(SELECT GROUP_CONCAT(GX.GER_NUMROM SEPARATOR ", ") ';
    strSQL := strSQL + '  FROM ROMGERX GX                                    ';
  	strSQL := strSQL + '	WHERE GX.GER_NUMDOC = G.GER_NUMDOC                 ';
  	strSQL := strSQL + '	     AND GX.GER_ESPDOC = G.GER_ESPDOC              ';
  	strSQL := strSQL + '		   AND GX.GER_CODEMP = G.GER_CODEMP) AS NUMROM   ';

    strSQL := strSQL + ' , (SELECT GROUP_CONCAT(GG.GER_NUMDOC, "-", GG.GER_ESPDOC,         ';
    strSQL := strSQL + '                        " - ", GG.GER_OPEEXP, " - ", CO.OPE_NOMOPE        ';
    strSQL := strSQL + '                        SEPARATOR '+QuotedStr(sLineBreak)+') AS CONFE     ';
    strSQL := strSQL + '    FROM MOVGER GG                                   ';
    strSQL := strSQL + '    JOIN CADOPE CO ON CO.OPE_CODOPE = GG.GER_OPEEXP  ';
    strSQL := strSQL + '    WHERE GG.GER_NUMFAT = G.GER_NUMDOC               ';
    strSQL := strSQL + '      AND GG.GER_TIPFAT = G.GER_ESPDOC               ';
    strSQL := strSQL + '      AND GG.GER_EMPFAT = G.GER_CODEMP               ';
    strSQL := strSQL + '      AND GG.GER_ESPDOC = "FF"                       ';
    strSQL := strSQL + '      AND GG.GER_TIP_FC = G.GER_TIP_FC               ';
    strSQL := strSQL + '      AND GG.GER_CODCLI = G.GER_CODCLI) AS CNF_FF    ';

    strSQL := strSQL + ' , (SELECT GROUP_CONCAT(GG.GER_NUMDOC, "-", GG.GER_ESPDOC,         ';
    strSQL := strSQL + '                        " - ", GG.GER_OPEEXP, " - ", CO.OPE_NOMOPE ';
    strSQL := strSQL + '                        SEPARATOR '+QuotedStr(sLineBreak)+') AS CONFE     ';
    strSQL := strSQL + '    FROM MOVGER GG                                   ';
    strSQL := strSQL + '    JOIN CNFMNO ON MNO_NUMFAT = GG.GER_NUMDOC         ';
    strSQL := strSQL + '               AND MNO_ESPFAT = GG.GER_ESPDOC         ';
    strSQL := strSQL + '               AND MNO_EMPFAT = GG.GER_CODEMP         ';
    strSQL := strSQL + '    JOIN CADOPE CO ON CO.OPE_CODOPE = GG.GER_OPEEXP  ';
    strSQL := strSQL + '    WHERE MNO_SEQGER = G.AUTOINCREM) AS CNFMNO ';
  end;

  If strNomTab = 'FATGOR' Then
  begin
    strSQL := strSQL + ' , (SELECT                                  ';
    strSQL := strSQL + '      GROUP_CONCAT( DISTINCT                ';
    strSQL := strSQL + '        S.SEP_OPECON,                       ';
    strSQL := strSQL + '        "-",                                ';
    strSQL := strSQL + '        C.OPE_NOMOPE                        ';
    strSQL := strSQL + '      )                                     ';
    strSQL := strSQL + '    FROM                                    ';
    strSQL := strSQL + '      FATDOR F                              ';
    strSQL := strSQL + '      LEFT JOIN SEPDOR S                    ';
    strSQL := strSQL + '        ON S.SEP_SEQFDO = F.AUTOINCREM      ';
    strSQL := strSQL + '      LEFT JOIN CADOPE C                    ';
    strSQL := strSQL + '        ON C.OPE_CODOPE = S.SEP_OPECON      ';
    strSQL := strSQL + '    WHERE F.FDO_NUMDOC = :NUMDOC            ';
    strSQL := strSQL + '      AND F.FDO_ESPDOC = :ESPDOC            ';
    strSQL := strSQL + '      AND F.FDO_CODEMP = :CODEMP) AS LSTSEP ';
  end
  else
  begin
    strSQL := strSQL + ' , (SELECT                                       ';
    strSQL := strSQL + '      GROUP_CONCAT( DISTINCT                     ';
    strSQL := strSQL + '        S.SEP_OPECON,                            ';
    strSQL := strSQL + '        "-",                                     ';
    strSQL := strSQL + '        C.OPE_NOMOPE                             ';
    strSQL := strSQL + '      )                                          ';
    strSQL := strSQL + '    FROM                                         ';
    strSQL := strSQL + '      MOVDET M                                   ';
    strSQL := strSQL + '      LEFT JOIN FATDOR F                         ';
    strSQL := strSQL + '             ON M.DET_NUM_PD = F.FDO_NUMDOC      ';
    strSQL := strSQL + '            AND M.DET_ESP_PD = F.FDO_ESPDOC      ';
    strSQL := strSQL + '            AND M.DET_EMP_PD = F.FDO_CODEMP      ';
    strSQL := strSQL + '            AND M.DET_CODCLI = F.FDO_CODCLI      ';
    strSQL := strSQL + '            AND M.DET_CODITE = F.FDO_CODITE      ';
    strSQL := strSQL + '            AND M.DET_IND_PD = F.FDO_SEQIND      ';
    strSQL := strSQL + '      LEFT JOIN SEPDOR S                         ';
    strSQL := strSQL + '             ON S.SEP_SEQFDO = F.AUTOINCREM      ';
    strSQL := strSQL + '      LEFT JOIN CADOPE C                         ';
    strSQL := strSQL + '             ON C.OPE_CODOPE = S.SEP_OPECON      ';
    strSQL := strSQL + '    WHERE M.DET_NUMDOC = G.GER_NUMDOC            ';
    strSQL := strSQL + '      AND M.DET_ESPDOC = G.GER_ESPDOC            ';
    strSQL := strSQL + '      AND M.DET_CODEMP = G.GER_CODEMP) AS LSTSEP ';
  end;

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + strNomTab + ' G ';
  strSQL := strSQL + '       JOIN CADEMP E  ON (G.GER_CODEMP  = E.EMP_CODEMP) ';
  strSQL := strSQL + '  LEFT JOIN CADCID C1 ON (C1.CID_CODCID = E.EMP_CODCID) ';

  If strNomTab = 'FATGOR' Then
  Begin
    strSQL := strSQL + ' LEFT JOIN EXTGOR EX ON G.AUTOINCREM = EX.FGO_SEQFGO    ';
    strSQL := strSQL + ' LEFT JOIN AUXGOR ON G.AUTOINCREM = AUX_SEQGER          ';
    strSQL := strSQL + ' LEFT JOIN ENTCLI ON ETC_CODCLI = G.FGO_CODCLI AND      ';
    strSQL := strSQL + '         IF(IFNULL(AUX_ENTGER,"") <> "", ENTCLI.AUTOINCREM = AUX_ENTGER, ';
    If blnSigep Then
      strSQL := strSQL + '  FALSE) '
    Else
      strSQL := strSQL + '         ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = G.FGO_CODCLI)) ';

    strSQL := strSQL + ' LEFT JOIN CADCID CC ON CC.CID_CODCID = G.FGO_CIDCON    ';

    If blnSigep Then
    Begin
      strSQL := strSQL + ' LEFT JOIN PLPDOC ON PLD_NUMDOC = FGO_NUMDOC AND PLD_ESPDOC = FGO_ESPDOC AND PLD_EMPDOC = FGO_CODEMP ';
      strSQL := strSQL + ' LEFT JOIN COROBJ ON COB_NUMOBJ = PLD_NUMOBJ ';
    End;

    If blnB2W Then
      strSQL := strSQL + ' LEFT JOIN PLPB2W ON PLP_NUMDOC = FGO_NUMDOC AND PLP_ESPDOC = FGO_ESPDOC AND PLP_EMPDOC = FGO_CODEMP ';

    strSQL := strSQL + ' LEFT JOIN MANDOC ON MAN_NUMDOC = FGO_NUMDOC AND MAN_ESPDOC = FGO_ESPDOC AND MAN_CODEMP = FGO_CODEMP ';
    strSQL := strSQL + ' LEFT JOIN PEDJAD ON JAD_NUMDOC = FGO_NUMDOC AND JAD_ESPDOC = FGO_ESPDOC AND JAD_CODEMP = FGO_CODEMP  ';
    strSQL := strSQL + ' LEFT JOIN ETIJAD ON JAD_SEQPED = PEDJAD.AUTOINCREM  ';
  End
  Else
  Begin
    If strNomTab = 'NOTGER' Then
      strSQL := strSQL + ' LEFT JOIN AUXNOT ON G.AUTOINCREM = AUX_SEQGER  '
    else
      strSQL := strSQL + ' LEFT JOIN AUXMOV ON G.AUTOINCREM = AUX_SEQGER  ';

    strSQL := strSQL + ' LEFT JOIN ENTCLI ON ETC_CODCLI = G.GER_CODCLI AND         ';

    strSQL := strSQL + '  IF(IFNULL(AUX_ENTGER,"") <> "", ENTCLI.AUTOINCREM = AUX_ENTGER,   ';
    If blnSigep Then
      strSQL := strSQL + '  FALSE) '
    Else
      strSQL := strSQL + '  ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = G.GER_CODCLI)) ';

    strSQL := strSQL + ' LEFT JOIN CADCID CC ON CC.CID_CODCID = G.GER_CIDCON    ';

    If blnSigep Then
    Begin
      strSQL := strSQL + ' LEFT JOIN PLPDOC ON PLD_NUMDOC = GER_NUMDOC AND PLD_ESPDOC = GER_ESPDOC AND PLD_SERIE_ = GER_SERIE_ AND PLD_EMPDOC = GER_CODEMP  ';
      strSQL := strSQL + ' LEFT JOIN COROBJ ON COB_NUMOBJ = PLD_NUMOBJ ';
    End;

    If blnB2W Then
    Begin
      strSQL := strSQL + ' LEFT JOIN FATGOR ON FGO_NUMFAT = GER_NUMDOC AND FGO_TIPFAT = GER_ESPDOC AND FGO_EMPFAT = GER_CODEMP ';
      strSQL := strSQL + ' LEFT JOIN PLPB2W ON PLP_NUMDOC = FGO_NUMDOC AND PLP_ESPDOC = FGO_ESPDOC AND PLP_EMPDOC = FGO_CODEMP ';
    End;

    strSQL := strSQL + '  LEFT JOIN CADFIS ON FIS_NUMDOC = G.GER_NUMDOC ';
    strSQL := strSQL + '                  AND FIS_ESPDOC = G.GER_ESPDOC ';
    strSQL := strSQL + '                  AND FIS_CODEMP = G.GER_CODEMP ';
    strSQL := strSQL + '                  AND FIS_SERIE_ = G.GER_SERIE_ ';
    strSQL := strSQL + '                  AND FIS_ORIDOC = G.GER_ORIDOC ';
    If strTipoFC = 'C' Then
      strSQL := strSQL + '                  AND FIS_FORCLI = G.GER_CODCLI '
    Else
      strSQL := strSQL + '                  AND FIS_FORCLI = G.GER_CODFOR ';
    strSQL := strSQL + '                  AND FIS_TIP_FC = G.GER_TIP_FC ';

    strSQL := strSQL + ' LEFT JOIN MANDOC ON MAN_NUMDOC = GER_NUMDOC AND MAN_ESPDOC = GER_ESPDOC AND MAN_CODEMP = GER_CODEMP  ';
    strSQL := strSQL + ' LEFT JOIN PEDJAD ON JAD_NUMDOC = GER_NUMDOC AND JAD_ESPDOC = GER_ESPDOC AND JAD_CODEMP = GER_CODEMP  ';
    strSQL := strSQL + ' LEFT JOIN ETIJAD ON JAD_SEQPED = PEDJAD.AUTOINCREM  ';
  End;

  If strTipoFC = 'C' Then
  Begin
    strSQL := strSQL + '  LEFT JOIN CADCLI C  ON (G.GER_CODCLI = C.CLI_CODCLI) ';
    strSQL := strSQL + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = C.CLI_CODCID   ';
    strSQL := strSQL + '  LEFT JOIN CADREG CR ON CR.REG_CODREG = C.CLI_CODREG   ';
    strSQL := strSQL + '  LEFT JOIN CADRED CD ON CD.RED_CODRED = C.CLI_CODRED ';

    If strNomTab = 'FATGOR' Then
    begin
      strSQL := strSQL + '  LEFT JOIN ENTREG ER ON ER.ENT_CODIGO = EX.FGO_CODROT ';
      if fCfgSis('ROTEMP', varBoolean) then
      begin
        strSQL := strSQL + ' AND ER.ENT_CODEMP = G.FGO_CODEMP ';
      end;
    end
    else
    begin
      strSQL := strSQL + '  LEFT JOIN ENTREG ER ON ER.ENT_CODIGO = ( SELECT DISTINCT ';
      strSQL := strSQL + '                                             EX.FGO_CODROT ';
      strSQL := strSQL + '                                           FROM ';
      strSQL := strSQL + '                                             FATGOR FG';
      strSQL := strSQL + '                                           INNER JOIN EXTGOR EX ON EX.FGO_SEQFGO = FG.AUTOINCREM ';
      strSQL := strSQL + '                                           INNER JOIN MOVDET DT ON DT.DET_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '                                                               AND DT.DET_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '                                                               AND DT.DET_CODEMP = :CODEMP ';
      strSQL := strSQL + '                                           WHERE ';
      strSQL := strSQL + '                                             FG.FGO_NUMDOC = DT.DET_NUM_PD AND ';
      strSQL := strSQL + '                                             FG.FGO_ESPDOC = DT.DET_ESP_PD AND ';
      strSQL := strSQL + '                                             FG.FGO_CODEMP = DT.DET_EMP_PD ) ';
      if fCfgSis('ROTEMP', varBoolean) then
      begin
        strSQL := strSQL + ' AND ER.ENT_CODEMP = G.GER_CODEMP ';
      end;
    end;
    strSQL := strSQL + ' LEFT JOIN CADREG RG ON RG.REG_CODREG = IFNULL(ER.ENT_CODREG, C.CLI_CODREG) ';
  End
  Else
  Begin
    strSQL := strSQL + '  LEFT JOIN CADFOR C  ON (G.GER_CODFOR  = C.FOR_CODFOR) ';
    strSQL := strSQL + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = C.FOR_CODCID   ';
  End;

  strSQL := strSQL + '  LEFT JOIN CADREG CDR ON CDR.REG_CODREG = ETC_CODREG ';
  strSQL := strSQL + '  LEFT JOIN CADCID  CE ON  CE.CID_CODCID = ETC_CIDENT ';

  strSQL := strSQL + '  LEFT JOIN CADTRA T  ON (T.TRA_CODTRA  = G.GER_CODTRA) ';
  strSQL := strSQL + '  LEFT JOIN CADCID TC ON (TC.CID_CODCID = T.TRA_CODCID) ';

  If ((strCodEti = 'tpeEtiquetaDespachoVolumeIndividualArgox') Or (strCodEti = 'tpeEtiquetaDespachoVolumeIndividualLaser')) Then
  Begin
    If (strNomTab = 'FATGOR') Then
    Begin
      strSQL := strSQL + ' INNER JOIN FATDOR ';
      strSQL := strSQL + ' ON(G.AUTOINCREM = FATDOR.FDO_SEQGER) ';
      strSQL := strSQL + ' LEFT JOIN ETIVOL ';
      strSQL := strSQL + ' ON(FATDOR.FDO_NUMDOC = ETIVOL.VOL_NUMPED AND FATDOR.FDO_ESPDOC = ETIVOL.VOL_ESPPED AND FATDOR.FDO_CODEMP = ETIVOL.VOL_EMPPED) ';
      strSQL := strSQL + ' LEFT JOIN ETIEVC ';
      strSQL := strSQL + ' ON(ETIVOL.VOL_CODIGO = ETIEVC.EVC_CODIGO) ';
    End
    Else
    Begin
      strSQL := strSQL + ' INNER JOIN MOVDET ';
      strSQL := strSQL + ' ON(G.AUTOINCREM = MOVDET.DET_SEQGER) ';
      strSQL := strSQL + ' LEFT JOIN ETIVOL ';
      strSQL := strSQL + ' ON(MOVDET.DET_NUM_PD = ETIVOL.VOL_NUMPED AND MOVDET.DET_ESP_PD = ETIVOL.VOL_ESPPED AND MOVDET.DET_EMP_PD = ETIVOL.VOL_EMPPED) ';
      strSQL := strSQL + ' LEFT JOIN ETIEVC ';
      strSQL := strSQL + ' ON(ETIVOL.VOL_CODIGO = ETIEVC.EVC_CODIGO) ';
    End;
  End;

  strSQL := strSQL + ' WHERE ';

  If blnAbrirVazio Then
    strSQL := strSQL + ' FALSE '
  Else
  Begin

    If Not blnTesteL Then
    Begin
      If fEmptyStr(strMultPed) Then
        strSQL := strSQL + '  G.GER_NUMDOC = :NUMDOC AND '
      Else
        strSQL := strSQL + '  G.GER_NUMDOC IN ('+strMultPed+') AND ';

      strSQL := strSQL + '  G.GER_ESPDOC = :ESPDOC AND ';
    End;

    strSQL := strSQL + '  G.GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  G.GER_TIP_FC = "' + strTipoFC + '" AND ';
    strSQL := strSQL + '  G.GER_ORIDOC = "V" ';

    if not fEmptyStr(strCodCli) then
      strSQL := strSQL + ' AND G.GER_CODCLI = :CODCLI';

    If ((strCodEti = 'tpeEtiquetaDespachoVolumeIndividualArgox') Or (strCodEti = 'tpeEtiquetaDespachoVolumeIndividualLaser')) Then
    Begin
      strSQL := strSQL + ' GROUP BY ETIEVC.EVC_DESCRI, ETIEVC.EVC_SIGLA_, ETIEVC.EVC_VOLUME ';
    End;

  End;

  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 30 )';

  If strNomTab = 'FATGOR' Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'G.GER_TIP_FC', '"C"');
    strSQL := AnsiReplaceStr(strSQL, 'G.GER_ORIDOC', '"V"');
    strSQL := AnsiReplaceStr(strSQL, 'GER_', 'FGO_');
    strSQL := AnsiReplaceStr(strSQL, 'OPLBEX', 'OPEEXP');
  End Else
  Begin
    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(
                                       AnsiReplaceStr(
                                       AnsiReplaceStr(AnsiReplaceStr(strSQL, 'SEPEXP', 'OPEEXP'), 'OPLBEX', 'OPEEXP'),
                                       strNomTab, AnsiReplaceStr(strNomTab, 'MOV', 'NOT')),'AUXMOV','AUXNOT');

    strSQL := AnsiReplaceStr(strSQL, 'NOTGER GG', 'MOVGER GG');
  End;
  If blnTesteL Then
    strSQL := strSQL + ' LIMIT 30 ';

  Result := strSQL;

End;

function fRetCamposIBPT: string;
  var
    i: integer;
Begin
  For i := 1 To 7 Do
  Begin
    If fCfgSis('IMPPAG', varInteger) = 1 Then
    Begin
      //Internacional
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,';
      //Federal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,';
      //Estadual
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,';
      //Municipal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,';
    End
    Else
    Begin
      //Internacional
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ';
      //Federal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ';
      //Estadual
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ';
      //Municipal
      Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ';
    End;
  End;
End;

function fJoinIBPT: string;
Begin
  Result := Result + ' LEFT JOIN CADCID EMPEST ON EMPEST.CID_CODCID = E.EMP_CODCID ';
  If fCfgSis('IMPPAG', varInteger) = 1 Then
    Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = ITEGER.ITE_CODABF '
  Else
  begin
    Result := Result + 'LEFT JOIN CADIBP UTI ON UTI.AUTOINCREM = IFNULL((SELECT AUTOINCREM FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(ITEGER.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = CADITE.ITE_CLAIPI), ';

    Result := Result + '                                                IFNULL((SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(ITEGER.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(CADITE.ITE_CLAIPI, 4)) , ';
    Result := Result + '                                                    (SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
    Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
    Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(ITEGER.ITE_EXCIPI, "") ';
    Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(CADITE.ITE_CLAIPI, 2)))) ';
  End;
End;

function fDiaSemanaAlfabeto: String;
begin
  Case DayOfTheWeek(VS_Date) Of
    1 : Result := 'A'; //Domingo
    2 : Result := 'B'; //Segunda
    3 : Result := 'C'; //Terça
    4 : Result := 'D'; //Quarta
    5 : Result := 'E'; //Quinta
    6 : Result := 'F'; //Sexta
    7 : Result := 'G'; //Sabado
  End;
end;

function fLoteCriptografado: String;
begin
  Result := RightStr(IntToStr(YearOf(VS_Date)),2);
  Result := Result + IntToStr(WeekOfTheYear(YearOf(VS_Date)));
  Result := Result + fDiaSemanaAlfabeto;
end;

Function fSQLDespachoProduto(blnTesteL: Boolean;
                             strNomTab,
                             strTipoFC: String): String;
var
  strSQL: String;
  intIndex: Integer;
  strTabPre: String;
  strValDes: String;
begin
  strTabPre := IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'));
  strValDes := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If strTipoFC = 'C' Then
  Begin
    strSQL := strSQL + '  C.CLI_CODCLI  AS CODCLI, ';
    strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_NOMCLI) > 0 ) AND (G.GER_NOMCON IS NOT NULL)), G.GER_NOMCON, C.CLI_NOMCLI) AS NOMCLI, ';
    strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_NOMCLI) > 0 ) AND (G.GER_NOMCON IS NOT NULL)), G.GER_TELCON, C.CLI_FONE01) AS FONCLI, ';
    strSQL := strSQL + '  IF(((LOCATE("CONSUMIDOR", C.CLI_FANSOB) > 0 ) AND (G.GER_NOMCON IS NOT NULL)), G.GER_NOMCON, C.CLI_FANSOB) AS FANSOB, ';
    strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('C.CLI_CGCCPF', 'C.CLI_C_G_C_') +' AS CGCCLI, ';
    strSQL := strSQL + '  C.CLI_I_E_S_ AS IESCLI, ';
  End
  Else
  Begin
    strSQL := strSQL + '  C.FOR_CODFOR  AS CODCLI, ';
    strSQL := strSQL + '  C.FOR_NOMFOR  AS NOMCLI, ';
    strSQL := strSQL + '  C.FOR_FONE01  AS FONCLI, ';
    strSQL := strSQL + '  C.FOR_NOMFAN  AS FANSOB, ';
    strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('C.FOR_CGCCPF', 'C.FOR_C_G_C_') + ' AS CGCCLI, ';
    strSQL := strSQL + '  C.FOR_I_E_S_ AS IESCLI, ';
  End;

  strSQL := strSQL + fRetEndereco(strTipoFC, strNomTab);

  strSQL := strSQL + '  E.EMP_CODEMP  AS CODEMP, ';
  strSQL := strSQL + '  E.EMP_NOMEMP  AS NOMEMP, ';
  strSQL := strSQL + '  CONCAT(E.EMP_ENDERE, ", ", E.EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))) AS ENDEMP, ';
  strSQL := strSQL + '  CONCAT(E.EMP_ENDERE, ", ", E.EMP_ENDNUM,IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))," - ",E.EMP_BAIRRO," - ",C1.CID_NOMCID,"-",C1.CID_ESTADO) AS ENEMP2, ';
  strSQL := strSQL + '  E.EMP_C_E_P_  AS CEPEMP, ';
  strSQL := strSQL + '  CONCAT(C1.CID_NOMCID,"-",C1.CID_ESTADO) AS CIDEMP, ';
  strSQL := strSQL + '  E.EMP_FONE01  AS FONEMP, ';
  strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('1', 'E.EMP_C_G_C_') +'  AS CGCEMP, ';
  strSQL := strSQL + '  E.EMP_I_E_S_  AS IESEMP, ';
  strSQL := strSQL + '  E.EMP_FONDA1 AS FONDA1,  ';
  strSQL := strSQL + '  E.EMP_FONDA2 AS FONDA2,  ';

  strSQL := strSQL + '  G.GER_PESBRU  AS PESBRU, ';
  strSQL := strSQL + '  G.GER_PESLIQ  AS PESLIQ, ';
  strSQL := strSQL + '  G.GER_TIP_FC  AS TIP_FC, ';

  strSQL := strSQL + '  T.TRA_NOMTRA  AS NOMTRA, ';
  strSQL := strSQL + '  T.TRA_ENDERE  AS ENDTRA, ';
  strSQL := strSQL + '  TC.CID_NOMCID AS CIDTRA, ';
  strSQL := strSQL + '  TC.CID_ESTADO AS UF_TRA, ';
  strSQL := strSQL + '  '+ fRetSQLCGCCPFFormatado('T.TRA_CGCCPF', 'T.TRA_C_G_C_') +'  AS CGCTRA, ';
  strSQL := strSQL + '  T.TRA_I_E_S_  AS IESTRA, ';
  strSQL := strSQL + '  T.TRA_FONE01  AS F01TRA, ';
  strSQL := strSQL + '  T.TRA_FONE02  AS F02TRA, ';

  If strTipoFC = 'C' Then
  Begin
    strSQL := strSQL + ' REG_DESREG AS DESREG, ';
    strSQL := strSQL + ' REG_CODREG AS CODREG, ';
  End
  Else
  Begin
    strSQL := strSQL + ' "" AS DESREG, ';
    strSQL := strSQL + ' "" AS CODREG, ';
  End;

  strSQL := strSQL + '  CADITE.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  DET_QTDITE AS QTDITE, ';

  strSQL := strSQL + '  CADITE.ITE_APLICA AS APLICA, ';
  strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  CADITE.ITE_DESSIM AS DESSIM, ';
  strSQL := strSQL + '  CADITE.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  CADITE.ITE_MSGLV1 AS MSGLV1, ';
  strSQL := strSQL + '  CADITE.ITE_MSGLV2 AS MSGLV2, ';

  strSQL := strSQL + '  CADUNI.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  CADITE.ITE_QRCODE AS QRCODE, ';

  strSQL := strSQL + '  CONCAT(CADITE.ITE_CODFAB, " ", CADMAR.MAR_DESMAR) AS FABMAR,  ';
  strSQL := strSQL + '"' + fLoteCriptografado + '"' + ' AS LOTECR, ';
  strSQL := strSQL + '  ITEGER.ITE_SALDOS AS SALDOS,  ';
  strSQL := strSQL + '  IF(IFNULL(ITEBAR.BAR_CODBAR,"") = "", CADITE.ITE_CODBAR, ITEBAR.BAR_CODBAR) AS CODBAR, ';
  strSQL := strSQL + '  IF(IFNULL(ITEBAR.BAR_EMBALA, 0) =  0, CADITE.ITE_EMBALA, ITEBAR.BAR_EMBALA) AS EMBALA, ';
  strSQL := strSQL + '  IF(IFNULL(ITEBAR.BAR_PREVEN, 0) =  0,              0.00, ITEBAR.BAR_PREVEN) AS EMBPRE,  ';
  strSQL := strSQL + '  COALESCE(ITEBAR.BAR_DESCRI, "") AS DESEMB, ';
  strSQL := strSQL + '  ITEGER.ITE_TABEMF AS TABEMF, ';
  strSQL := strSQL + '  ITEGER.ITE_DESFEC AS DESFEC, ';
  strSQL := strSQL + '  ITEGER.ITE_EMBFEC AS EMBFEC, ';
  strSQL := strSQL + '  ITEETI.ETI_OBSERV AS OBSIMP, ';

  strSQL := strSQL + '  D.AUTOINCREM AS AUTINCDET, ';

  if (strNomTab = 'FATGOR') then
    strSQL := strSQL + ' CAST("" AS CHAR(01)) AS DESNES, '
  else
    strSQL := strSQL + ' D.DET_DESNES AS DESNES, ';

  strSQL := strSQL + '  CADITE.ITE_PRDGRU AS PRDGRU, ';
  strSQL := strSQL + '  GRPPRD.PRD_DESGRU AS DESGRU, ';
  strSQL := strSQL + '  FOR_C_G_C_ AS CGCFOR, ';
  strSQL := strSQL + '  ITE_CODFOR AS CODFOR, ';
  strSQL := strSQL + '  FOR_NOMFOR AS NOMFOR, ';

  strSQL := strSQL + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  strSQL := strSQL + '     FROM CADSEM ';
  strSQL := strSQL + '    WHERE CADSEM.SEM_CODITE = CADITE.ITE_CODITE) AS CODSEM, ';

  strSQL := strSQL + '(SELECT ';
  strSQL := strSQL + '  CAT_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FXACAT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '(SELECT LEAST(IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 1, 1) = "S", IFNULL(ITE_MARBR1,0), 1000), ';
  strSQL := strSQL + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 2, 1) = "S", IFNULL(ITE_MARBR2,0), 1000), ';
  strSQL := strSQL + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 3, 1) = "S", IFNULL(ITE_MARBR3,0), 1000), ';
  strSQL := strSQL + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 4, 1) = "S", IFNULL(ITE_MARBR4,0), 1000), ';
  strSQL := strSQL + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 5, 1) = "S", IFNULL(ITE_MARBR5,0), 1000), ';
  strSQL := strSQL + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 6, 1) = "S", IFNULL(ITE_MARBR6,0), 1000), ';
  strSQL := strSQL + '              IF(SUBSTR('+ QuotedStr(VS_strTabPrc) +', 7, 1) = "S", IFNULL(ITE_MARBR7,0), 1000)) ';
  strSQL := strSQL + '    FROM ';
  strSQL := strSQL + '      ITEGER ';
  strSQL := strSQL + '    WHERE ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '      AND ITE_CODEMP = :CODEMP) BETWEEN CAT_INICIO AND CAT_FINAL) ';
  strSQL := strSQL + ' AS CATPRO, ';

  strSQL := strSQL + '  ITE_VALIDA AS VALIDA,';
  strSQL := strSQL + '  ITE_ITESAC AS ITESAC, ';
  strSQL := strSQL + '  ITE_COMPOS AS COMPOS, ';
  strSQL := strSQL + '  ITE_PAISOR AS PAISOR, ';
  strSQL := strSQL + '  ITE_ESTMIN AS ESTMIN, ';
  strSQL := strSQL + '  ITE_ESTMAX AS ESTMAX, ';
  strSQL := strSQL + '  CADITE.ITE_MLTVEN AS MLTVEN, ';
  strSQL := strSQL + '  ITE_IPISAI AS IPISAI,  ';

  strSQL := strSQL + '  (SELECT MOE_DOLCOM FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLCOM, ';
  strSQL := strSQL + '  (SELECT MOE_DOLVEN FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DOLVEN, ';
  strSQL := strSQL + '  (SELECT MOE_CODEMP FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS MOEEMP, ';
  strSQL := strSQL + '  (SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1) AS DTAMOE, ';
  strSQL := strSQL + '  ITEGER.ITE_PRECUS AS CUSPRE,  ';
  strSQL := strSQL + '  (SELECT URL_ENDERE FROM ITEURL WHERE URL_CODITE = CADITE.ITE_CODITE AND URL_PRINCI = 1) AS URLIMG, ';
  strSQL := strSQL + '  CADPRO.PRO_DESPRO AS DESPRO, ';
  strSQL := strSQL + '  CADPRO.PRO_DTAINI AS PROINI, ';
  strSQL := strSQL + '  CADPRO.PRO_DTAFIN AS PROFIN, ';
  strSQL := strSQL + '  ITEGER.ITE_PONEXP AS PONEXP, ';

  //Internamente ja faz as validações referente a qual tabela pegar;
  strSQL := strSQL + fRetCamposIBPT;

  For intIndex := 0 To 9 Do
  Begin
    strSQL := strSQL + ' ( SELECT ITB_QTDEMB                         ';
    strSQL := strSQL + '   FROM ITEEMB                               ';
    strSQL := strSQL + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    strSQL := strSQL + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    strSQL := strSQL + '   ORDER BY ITB_QTDEMB DESC                  ';
    strSQL := strSQL + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    strSQL := strSQL + ' ( SELECT ITB_DESCON                         ';
    strSQL := strSQL + '   FROM ITEEMB                               ';
    strSQL := strSQL + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    strSQL := strSQL + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    strSQL := strSQL + '   ORDER BY ITB_QTDEMB DESC                  ';
    strSQL := strSQL + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    strSQL := strSQL + ' ( SELECT IFNULL(ITB_TABPRE, "TODAS")        ';
    strSQL := strSQL + '   FROM ITEEMB                               ';
    strSQL := strSQL + '   WHERE ITB_CODITE = ITEGER.ITE_CODITE      ';
    strSQL := strSQL + '     AND ITB_CODEMP = ITEGER.ITE_CODEMP      ';
    strSQL := strSQL + '   ORDER BY ITB_QTDEMB DESC                  ';
    strSQL := strSQL + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';

    strSQL := strSQL + ' ( SELECT ';
    strSQL := strSQL + '     CASE ';
    strSQL := strSQL + '       IF( IFNULL(IB'+ IntToStr(intIndex)+'.ITB_TABPRE, "") = "", '+strTabPre+', ITB_TABPRE ) ';
    strSQL := strSQL + '       WHEN "0" ';
    strSQL := strSQL + '       THEN NULL ';
    strSQL := strSQL + '       WHEN "1" ';
    strSQL := strSQL + '       THEN (IFNULL(ITEGER.ITE_PREVE1,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    strSQL := strSQL + '       WHEN "2" ';
    strSQL := strSQL + '       THEN (IFNULL(ITEGER.ITE_PREVE2,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    strSQL := strSQL + '       WHEN "3" ';
    strSQL := strSQL + '       THEN (IFNULL(ITEGER.ITE_PREVE3,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    strSQL := strSQL + '       WHEN "4" ';
    strSQL := strSQL + '       THEN (IFNULL(ITEGER.ITE_PREVE4,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    strSQL := strSQL + '       WHEN "5" ';
    strSQL := strSQL + '       THEN (IFNULL(ITEGER.ITE_PREVE5,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    strSQL := strSQL + '       WHEN "6" ';
    strSQL := strSQL + '       THEN (IFNULL(ITEGER.ITE_PREVE6,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    strSQL := strSQL + '       WHEN "7" ';
    strSQL := strSQL + '       THEN (IFNULL(ITEGER.ITE_PREVE7,0) * ((100- IB'+ IntToStr(intIndex)+'.ITB_DESCON) / 100)) ';
    strSQL := strSQL + '     END ';
    strSQL := strSQL + '   FROM ITEEMB IB'+ IntToStr(intIndex);
    strSQL := strSQL + '  WHERE ITB_CODITE = ITEGER.ITE_CODITE ';
    strSQL := strSQL + '    AND ITB_CODEMP = ITEGER.ITE_CODEMP ';
    strSQL := strSQL + '  ORDER BY ITB_QTDEMB DESC ';
    strSQL := strSQL + '  LIMIT '+ IntToStr(intIndex) +',1) AS UNITA'+ IntToStr(intIndex)+ ', ';

  End;

  If fCfgSis('CTLEST') = '2' Then
    strSQL := strSQL + '  CADLOT.LOT_LOCFIS AS LOCFIS, '
  Else
    strSQL := strSQL + '  ITEGER.ITE_LOCFIS AS LOCFIS, ';

  strSQL := strSQL + '  ITEGER.ITE_LOCSUP AS LOCSUP, ';
  strSQL := strSQL + '  CADITE.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVEN, ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', strTabPre) + ') AS PROMOC,';
  strSQL := strSQL + '  IFNULL(IPR_PERDES, 0) AS PERDES, ';
  strSQL := strSQL + '  IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '1') + ' AS PREVE1, ';
  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '2') + ' AS PREVE2, ';
  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '3') + ' AS PREVE3, ';
  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '4') + ' AS PREVE4, ';
  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '5') + ' AS PREVE5, ';
  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '6') + ' AS PREVE6, ';
  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , '7') + ' AS PREVE7, ';

  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , strTabPre) +  ' * ' + IfThen(strValDes = '', '1', strValDes) + ' AS PREVIS, ';
  strSQL := strSQL + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = CADITE.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';
  strSQL := strSQL + '  ITEGER.ITE_TAMLCF AS TAMLCF, ';
  strSQL := strSQL + '  ITEGER.ITE_TAMLCS AS TAMLCS, ';

  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , strTabPre) + ' AS VALVIS, ';
  strSQL := strSQL + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER' , strTabPre) + ' AS VALITE, ';

  strSQL := strSQL + '  OC.OPE_NOMOPE AS CONFER, ';
  strSQL := strSQL + '  OS.OPE_NOMOPE AS SEPARA, ';
  strSQL := strSQL + '  OL.OPE_NOMOPE AS OPELIB, ';

  strSQL := strSQL + fSQLTipoFrete('G.GER_TIPFRE') + ' AS DESFRE, ';
  strSQL := strSQL + ' CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_SERIE_) AS NUMDOC, ';
  strSQL := strSQL + ' CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC) AS CODDOC, ';
  strSQL := strSQL + ' G.GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + ' GER_DTAENT AS DTAFAT, ';
  strSQL := strSQL + ' GER_DTENTR AS DTENTR, ';
  strSQL := strSQL + ' G.GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + ' G.GER_HORENT AS HORENT, ';
  strSQL := strSQL + ' G.GER_TOTFRE AS TOTFRE, ';
  strSQL := strSQL + ' G.GER_TOTPRO AS TOTPRO, ';
  strSQL := strSQL + ' G.GER_VLRCON AS VLRCON ';

  strSQL := strSQL + ' FROM MOVGER G';
  strSQL := strSQL + ' LEFT  JOIN CADCID CC ON CC.CID_CODCID = G.GER_CIDCON ';

  If strNomTab = 'FATGOR' Then
  Begin
    strSQL := strSQL + ' LEFT JOIN EXTGOR EX ON G.AUTOINCREM = EX.FGO_SEQFGO ';
    strSQL := strSQL + ' LEFT JOIN AUXGOR ON G.AUTOINCREM = AUX_SEQGER ';
  End
  Else
  Begin
    strSQL := strSQL + ' LEFT JOIN AUXMOV ON G.AUTOINCREM = AUX_SEQGER ';
  End;

  If strTipoFC = 'C' Then
  Begin
    strSQL := strSQL + ' LEFT  JOIN CADCLI C  ON G.GER_CODCLI = C.CLI_CODCLI ';
    strSQL := strSQL + ' LEFT  JOIN CADCID CF ON CF.CID_CODCID = C.CLI_CODCID ';
    strSQL := strSQL + ' LEFT  JOIN CADREG RG ON RG.REG_CODREG = C.CLI_CODREG ';
  End
  Else
  Begin
    strSQL := strSQL + '  LEFT JOIN CADFOR C  ON (G.GER_CODFOR  = C.FOR_CODFOR) ';
    strSQL := strSQL + '  LEFT JOIN CADCID CF ON CF.CID_CODCID = C.FOR_CODCID   ';
  End;

  strSQL := strSQL + ' INNER JOIN MOVDET D  ON D.DET_SEQGER = G.AUTOINCREM ';

  strSQL := strSQL + ' LEFT  JOIN CADITE    ON CADITE.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN ITEGER    ON ITEGER.ITE_CODITE = D.DET_CODITE AND ';
  strSQL := strSQL + '                         ITEGER.ITE_CODEMP = D.DET_CODEMP ';
  strSQL := strSQL + ' LEFT  JOIN ITEBAR ON CADITE.ITE_CODITE = ITEBAR.BAR_CODITE AND ';
  strSQL := strSQL + '                      CADITE.ITE_CODBAR = ITEBAR.BAR_CODBAR     ';
  strSQL := strSQL + ' LEFT  JOIN CADUNI ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI ';
  strSQL := strSQL + ' LEFT  JOIN CADFOR ON CADFOR.FOR_CODFOR = CADITE.ITE_CODFOR ';
  strSQL := strSQL + ' LEFT  JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';
  strSQL := strSQL + ' LEFT  JOIN DESSIT ON DESSIT.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN GRPPRD ON CADITE.ITE_PRDGRU = GRPPRD.PRD_CODGRU ';
  strSQL := strSQL + ' LEFT  JOIN ITEETI ON ETI_CODITE = CADITE.ITE_CODITE AND ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado) + ' ';

  strSQL := strSQL + ' INNER JOIN CADEMP E  ON G.GER_CODEMP = E.EMP_CODEMP ';
  strSQL := strSQL + ' LEFT  JOIN CADCID C1 ON C1.CID_CODCID = E.EMP_CODCID ';

  strSQL := strSQL + ' LEFT JOIN ENTCLI ON ETC_CODCLI = G.GER_CODCLI AND ';
  strSQL := strSQL + '  IF(IFNULL(AUX_ENTGER,"") <> "", ENTCLI.AUTOINCREM = AUX_ENTGER, ';
  strSQL := strSQL + '  ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = G.GER_CODCLI)) ';
  strSQL := strSQL + ' LEFT  JOIN CADCID CE ON CE.CID_CODCID = ETC_CIDENT ';

  strSQL := strSQL + ' LEFT  JOIN CADTRA T  ON (T.TRA_CODTRA  = G.GER_CODTRA) ';
  strSQL := strSQL + ' LEFT  JOIN CADCID TC ON (TC.CID_CODCID = T.TRA_CODCID) ';

  strSQL := strSQL + ' LEFT  JOIN CADOPE OC ON OC.OPE_CODOPE = GER_OPEEXP ';

  if ((strNomTab = 'FATGOR') and
      (fCfgSis('TIPEXP', varString)='4') and
      (Not fCfgSis('UTIWMS', varBoolean)) and
      (fCfgSis('BAISEP', varBoolean))) then
  begin
    strSQL := strSQL + ' LEFT  JOIN CADOPE OS ON OS.OPE_CODOPE = EX.FGO_OPBXSE ';
  end
  else
  begin
    strSQL := strSQL + ' LEFT  JOIN CADOPE OS ON OS.OPE_CODOPE = GER_SEPEXP ';
  end;

  strSQL := strSQL + ' LEFT  JOIN CADOPE OL ON OL.OPE_CODOPE = GER_OPLBEX ';

  If StrToInt(strTabPre) > 1 Then
    strSQL := strSQL + '  LEFT JOIN (SELECT IF(IPR_PERDES = 0, IPR_PREVE' + strTabPre + ', ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', strTabPre)  +  ' - (' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', strTabPre) + ' * IPR_PERDES / 100) ) AS IPR_PREVEN ,'
  Else
    strSQL := strSQL + '  LEFT JOIN (SELECT IF(IPR_PERDES = 0, IPR_PREVEN, ' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', strTabPre)  +  ' - (' + fGetSQLConsultaItensPrecoValidandoEstrutura('ITEGER', strTabPre) + ' * IPR_PERDES / 100) ) AS IPR_PREVEN ,';
  strSQL := strSQL + '    IPR_CODITE, IPR_PERDES, IPR_QTDMIN, IPR_SEQGER, PRO_DESPRO FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  strSQL := strSQL + '                                   JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  strSQL := strSQL + '                                   LEFT JOIN PROCLI ON PROCLI.PRO_SEQGER = CADPRO.AUTOINCREM '; // Só pode considerar a promoção se ela não for especifica para um cliete.
  strSQL := strSQL + '                                   JOIN ITEGER ON ITEGER.ITE_CODITE = ITEPRO.IPR_CODITE ';
  strSQL := strSQL + '                                              AND ITEGER.ITE_CODEMP = PROEMP.PRO_CODEMP ';
  strSQL := strSQL + '   WHERE PROCLI.PRO_CODCLI IS NULL AND ';
  strSQL := strSQL + '     PROEMP.PRO_CODEMP = :CODEMP AND CURRENT_DATE BETWEEN PRO_DTAINI AND PRO_DTAFIN) AS TMP ON IPR_CODITE = ITEGER.ITE_CODITE ';

  strSQL := strSQL + ' LEFT  JOIN CADPRO ON CADPRO.AUTOINCREM = IPR_SEQGER ';

  If fCfgSis('CTLEST') = '2' Then
  Begin
    strSQL := strSQL + '  LEFT JOIN CADLOT ON CADLOT.LOT_NUMLOT = ITEETI.ETI_AMZETI ';
    strSQL := strSQL + '                  AND CADLOT.LOT_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '                  AND CADLOT.LOT_CODEMP = ITEGER.ITE_CODEMP ';
  End;

  //Internamente ja faz as validações referente a qual tabela pegar;
  strSQL := strSQL + fJoinIBPT;

  strSQL := strSQL + 'WHERE TRUE ';
  strSQL := strSQL + '  AND G.GER_CODEMP = :CODEMP ';

  if blnTesteL then
    strSQL := strSQL + 'LIMIT 10 '
  else
  begin
    strSQL := strSQL + '  AND G.GER_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND G.GER_ESPDOC = :ESPDOC ';

    if (strNomTab <> 'FATGOR') then
      strSQL := strSQL + '  AND G.GER_TIP_FC = ' + QuotedStr(strTipoFC);
  end;

  if strNomTab = 'FATGOR' then
  begin
    strSQL := AnsiReplaceStr(strSQL, 'G.GER_TIP_FC', '"C"');
    strSQL := AnsiReplaceStr(strSQL, 'OPLBEX', 'OPEEXP');

    strSQL := AnsiReplaceStr(strSQL, 'MOVGER', 'FATGOR');
    strSQL := AnsiReplaceStr(strSQL, 'MOVDET', 'FATDOR');
    strSQL := AnsiReplaceStr(strSQL, 'GER_', 'FGO_');
    strSQL := AnsiReplaceStr(strSQL, 'DET_', 'FDO_');
  end;

  Result := strSQL;
end;



end.
