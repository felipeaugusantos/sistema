unit untDocOrdProTintasAutomotiva;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni;

Type
  TLeOrdProTintasAutomotiva = Class(TLeDocumento)
  Private
    cdsFormula:TZClient;
    cdsFormulacao: TZClient;
    FTemFormula: Boolean;

    function fGetSQLTintas(): String;
    function fInsereClientTintas(Var regClient: TRegClient): Boolean;
    function fInsereClientFormulacao(): Boolean;
    function fRetLinhaColorPro(strCodLin: String): String;
    function fCasasDecimais(strIdePro: String): Integer;
    function fFormataEspecifico(fltQtdIte: Double; strIdePro:String): Double;
    procedure pRetDadosAdicionais(strCodAca, strEmpAca, strEspDoc, strIdePro: String;
      Var fltVolPro: Double; Var strDesEmb: String);
    procedure pCriaFieldFormulacao();
    procedure pProcessaFormulacao(cdsFormula: TZClient);
  Protected

  Public
    function fSQLItems: String; Override;
    function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; Override;
    Procedure pCarregaArrClients(dtsDataSet: TfrxDBDataSet); Override;
  End;

implementation

uses
  Data.DB, Math, untFuncTinta;

{ TLeOrdemProducaoPreliminarPedido }

function TLeOrdProTintasAutomotiva.fCasasDecimais(
  strIdePro: String): Integer;
Var
  intDec: Integer;
begin
  If Pos(strIdePro, 'AJA_DOX_') > 0 Then
    Result := 3
  Else If Pos(strIdePro, 'DUP_ROB_ALA_BLA_') > 0 Then
  Begin
    intDec :=  StrToIntDef(fGetConfTinta(strIdePro).fGet('DECFOR'), 1);
    Result := intDec;
  End
  Else If Pos(strIdePro, 'PPG_NEX_PPX_') > 0 Then
    Result := fGetConfTinta(strIdePro).fGetInteger('DECNFM')
  Else
    Result := 2;
end;

function TLeOrdProTintasAutomotiva.fFormataEspecifico(fltQtdIte: Double;
  strIdePro: String): Double;
begin
  Result := fltQtdIte;

  If strIdePro = 'SKY' Then
    Result := fFormataFloatSky(fltQtdIte);
end;

function TLeOrdProTintasAutomotiva.fGetSQLTintas: String;
begin

  If Pos(recDocume.strEspDoc, 'OR_PD_') > 0 Then
  Begin
    Result := '';
    Result := Result + '  SELECT                            ';
    Result := Result + '    " "               AS TIPTIN,    ';
    Result := Result + '    TINDOR.FDO_NUMDOC AS NUMDOC,    ';
    Result := Result + '    TINDOR.FDO_ESPDOC AS ESPDOC,    ';
    Result := Result + '    TINDOR.FDO_CODEMP AS CODEMP,    ';
    Result := Result + '    TINDOR.FDO_QTDEMB AS QTDEMB,    ';
    Result := Result + '    TINDOR.FDO_DESCRI AS DESCRI,    ';
    Result := Result + '    TINDOR.FDO_DTAENT AS DTAENT,    ';
    Result := Result + '    TINDOR.FDO_HORENT AS HORENT,    ';
    Result := Result + '    TINDOR.FDO_IDEPRO AS IDEPRO,    ';
    Result := Result + '    TINDOR.FDO_ITETIN AS ITETIN,    ';
    Result := Result + '    TINDOR.FDO_CODACA AS CODACA,    ';
    Result := Result + '    TINDOR.FDO_EMPACA AS EMPACA,    ';
    Result := Result + '    TINDOR.FDO_A_N_O_ AS ANOCOR,    ';
    Result := Result + '    TINDOR.FDO_TIPPRE AS DILCON,    ';
    Result := Result + '    TINDOR.FDO_QTDITE AS QTDITE,    ';
    Result := Result + '    TINDOR.FDO_UNITAR AS UNITAR,    ';
    Result := Result + '    TINDOR.FDO_TIPEMB AS TIPEMB,    ';
    Result := Result + '    TINDOR.FDO_TOTITE AS TOTITE,    ';
    Result := Result + '    FATDOR.FDO_VOLPRO AS VOLPRO,    ';
    Result := Result + '    CASE EXTDOR.FDO_ENTRET          ';
    Result := Result + '      WHEN "E" THEN                 ';
    Result := Result + '        "ENTREGA"                   ';
    Result := Result + '      ELSE                          ';
    Result := Result + '        "RETIRADA"                  ';
    Result := Result + '    END               AS ENTRET,    ';
    Result := Result + '    TINDOR.FDO_TIPFOR AS TIPFOR,    ';
    Result := Result + '    TINDOR.FDO_OBSCOL AS OBSCOL,    ';
    Result := Result + '    TINDOR.FDO_FORM01 AS FORM01,    ';
    Result := Result + '    TINDOR.FDO_QTDB01 AS QTDB01,    ';
    Result := Result + '    TINDOR.FDO_FORM02 AS FORM02,    ';
    Result := Result + '    TINDOR.FDO_QTDB02 AS QTDB02,    ';
    Result := Result + '    TINDOR.FDO_FORM03 AS FORM03,    ';
    Result := Result + '    TINDOR.FDO_QTDB03 AS QTDB03,    ';
    Result := Result + '    TINDOR.FDO_FORM04 AS FORM04,    ';
    Result := Result + '    TINDOR.FDO_QTDB04 AS QTDB04,    ';
    Result := Result + '    TINDOR.FDO_FORM05 AS FORM05,    ';
    Result := Result + '    TINDOR.FDO_QTDB05 AS QTDB05,    ';
    Result := Result + '    TINDOR.FDO_FORM06 AS FORM06,    ';
    Result := Result + '    TINDOR.FDO_QTDB06 AS QTDB06,    ';
    Result := Result + '    TINDOR.FDO_FORM07 AS FORM07,    ';
    Result := Result + '    TINDOR.FDO_QTDB07 AS QTDB07,    ';
    Result := Result + '    TINDOR.FDO_FORM08 AS FORM08,    ';
    Result := Result + '    TINDOR.FDO_QTDB08 AS QTDB08,    ';
    Result := Result + '    TINDOR.FDO_FORM09 AS FORM09,    ';
    Result := Result + '    TINDOR.FDO_QTDB09 AS QTDB09,    ';
    Result := Result + '    TINDOR.FDO_FORM10 AS FORM10,    ';
    Result := Result + '    TINDOR.FDO_QTDB10 AS QTDB10,    ';
    Result := Result + '    TINDOR.FDO_FORM11 AS FORM11,    ';
    Result := Result + '    TINDOR.FDO_QTDB11 AS QTDB11,    ';
    Result := Result + '    TINDOR.FDO_FORM12 AS FORM12,    ';
    Result := Result + '    TINDOR.FDO_QTDB12 AS QTDB12,    ';
    Result := Result + '    TINDOR.FDO_FORM13 AS FORM13,    ';
    Result := Result + '    TINDOR.FDO_QTDB13 AS QTDB13,    ';
    Result := Result + '    TINDOR.FDO_FORM14 AS FORM14,    ';
    Result := Result + '    TINDOR.FDO_QTDB14 AS QTDB14,    ';
    Result := Result + '    TINDOR.FDO_FORM15 AS FORM15,    ';
    Result := Result + '    TINDOR.FDO_QTDB15 AS QTDB15,    ';
    Result := Result + '    TINDOR.FDO_FORM16 AS FORM16,    ';
    Result := Result + '    TINDOR.FDO_QTDB16 AS QTDB16,    ';
    Result := Result + '    TINDOR.FDO_FORM17 AS FORM17,    ';
    Result := Result + '    TINDOR.FDO_QTDB17 AS QTDB17,    ';
    Result := Result + '    TINDOR.FDO_FORM18 AS FORM18,    ';
    Result := Result + '    TINDOR.FDO_QTDB18 AS QTDB18,    ';
    Result := Result + '    TINDOR.FDO_FORM19 AS FORM19,    ';
    Result := Result + '    TINDOR.FDO_QTDB19 AS QTDB19,    ';
    Result := Result + '    TINDOR.FDO_FORM20 AS FORM20,    ';
    Result := Result + '    TINDOR.FDO_QTDB20 AS QTDB20,    ';
    Result := Result + '    CONCAT(TINDOR.FDO_CODVEN, "-", VEN.OPE_NOMOPE) AS NOMOPE,       ';
    Result := Result + '    CONCAT(TINDOR.FDO_CODDIV, "-", DIG.OPE_NOMOPE) AS NOMDIG,       ';
    Result := Result + '    CONCAT(TINDOR.FDO_CODCLI, "-", IF(GOR.FGO_NOMCON = "" OR GOR.FGO_NOMCON IS NULL, CLI.CLI_NOMCLI, GOR.FGO_NOMCON)) AS NOMCLI,      ';
    Result := Result + '    ITE.ITE_DESITE AS DESITE,       ';
    Result := Result + '    ITE.ITE_REFERE AS REFERE,       ';
    Result := Result + '    ITE.ITE_CODITE AS CODITE,       ';
    Result := Result + '    FATGOR.FGO_MEN001 AS MEN001,    ';
    Result := Result + '    FATGOR.FGO_MEN002 AS MEN002,    ';
    Result := Result + '    AUXGOR.AUX_MEN003 AS MEN003,    ';
    Result := Result + '    AUXGOR.AUX_MEN004 AS MEN004,    ';
    Result := Result + '    AUXGOR.AUX_MEN005 AS MEN005,    ';
    Result := Result + '    ITE.ITE_CODFAB AS CODFAB,       ';
    Result := Result + '    IFNULL(FATDOR.FDO_EMPPRD, FATDOR.FDO_CODEMP) AS EMPPRD,    ';
    Result := Result + '    FATGOR.FGO_MENEXP AS MENEXP,              ';
    Result := Result + '    FATGOR.FGO_MENEX2 AS MENEX2,              ';
    Result := Result + '    FATGOR.FGO_MENEX3 AS MENEX3,              ';
    Result := Result + '    FATGOR.FGO_MENEX4 AS MENEX4,              ';
    Result := Result + '    FATDOR.FDO_CODITE AS CODBAS               ';
    Result := Result + '  FROM                              ';
    Result := Result + '    TINDOR                          ';
    Result := Result + '  INNER JOIN CADITE AS ITE ON               ';
    Result := Result + '    TINDOR.FDO_CODITE = ITE.ITE_CODITE              ';
    Result := Result + '  INNER JOIN TINGOR AS GOR ON               ';
    Result := Result + '    GOR.AUTOINCREM = TINDOR.FDO_SEQGER              ';
    Result := Result + '  INNER JOIN CADOPE AS VEN ON               ';
    Result := Result + '    TINDOR.FDO_CODVEN = VEN.OPE_CODOPE              ';
    Result := Result + '  LEFT JOIN CADOPE AS DIG ON                ';
    Result := Result + '    TINDOR.FDO_CODDIG = DIG.OPE_CODOPE              ';
    Result := Result + '  INNER JOIN CADCLI AS CLI ON               ';
    Result := Result + '    TINDOR.FDO_CODCLI = CLI.CLI_CODCLI              ';
    Result := Result + '  INNER JOIN FATDOR ON              ';
    Result := Result + '    FATDOR.FDO_NUMDOC = TINDOR.FDO_NUMDOC AND       ';
    Result := Result + '    FATDOR.FDO_ESPDOC = TINDOR.FDO_ESPDOC AND       ';
    Result := Result + '    FATDOR.FDO_CODEMP = TINDOR.FDO_CODEMP AND       ';
    Result := Result + '    FATDOR.FDO_CODCLI = TINDOR.FDO_CODCLI AND       ';
    Result := Result + '    FATDOR.FDO_CODACA = TINDOR.FDO_CODACA AND       ';
    Result := Result + '    FATDOR.FDO_EMPACA = TINDOR.FDO_EMPACA           ';
    Result := Result + '  LEFT JOIN EXTDOR ON               ';
    Result := Result + '    EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM           ';
    Result := Result + '  INNER JOIN FATGOR  ON              ';
    Result := Result + '    FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER           ';
    Result := Result + '  LEFT JOIN AUXGOR ON (AUXGOR.AUX_SEQGER = FATGOR.AUTOINCREM) ';
    Result := Result + '  WHERE                             ';
    Result := Result + '    TINDOR.FDO_NUMDOC = :NUMDOC AND           ';
    Result := Result + '    TINDOR.FDO_ESPDOC = :ESPDOC AND           ';
    Result := Result + '    TINDOR.FDO_CODEMP = :CODEMP               ';

    If (Not fEmptyStr(recDocume.strCodAca)) And (Not fEmptyStr(recDocume.strEmpAca)) {And (Not fCfgSis('EMIOPR', varBoolean))} Then
    Begin
      Result := Result + '  AND TINDOR.FDO_CODACA = :CODACA           ';
      Result := Result + '  AND TINDOR.FDO_EMPACA = :EMPACA           ';
    End;
  End
  Else
  Begin
    Result := '';
    Result := Result + '  SELECT                              ';
    Result := Result + '    " "               AS TIPTIN,      ';
    Result := Result + '    TINDET.DET_NUMDOC AS NUMDOC,      ';
    Result := Result + '    TINDET.DET_ESPDOC AS ESPDOC,      ';
    Result := Result + '    TINDET.DET_CODEMP AS CODEMP,      ';
    Result := Result + '    TINDET.DET_QTDEMB AS QTDEMB,      ';
    Result := Result + '    TINDET.DET_DESCRI AS DESCRI,      ';
    Result := Result + '    TINDET.DET_DTAENT AS DTAENT,      ';
    Result := Result + '    TINDET.DET_HORENT AS HORENT,      ';
    Result := Result + '    TINDET.DET_IDEPRO AS IDEPRO,      ';
    Result := Result + '    TINDET.DET_ITETIN AS ITETIN,      ';
    Result := Result + '    TINDET.DET_CODACA AS CODACA,      ';
    Result := Result + '    TINDET.DET_EMPACA AS EMPACA,      ';
    Result := Result + '    TINDET.DET_A_N_O_ AS ANOCOR,      ';
    Result := Result + '    TINDET.DET_TIPPRE AS DILCON,      ';
    Result := Result + '    TINDET.DET_QTDITE AS QTDITE,      ';
    Result := Result + '    TINDET.DET_TIPEMB AS TIPEMB,      ';
    Result := Result + '    DET.DET_TOTITE AS UNITAR,         ';
    Result := Result + '    DET.DET_VOLPRO AS VOLPRO,         ';

    Result := Result + '    CASE MOVGER.GER_ENTFAT            ' +
                       '      WHEN "N" THEN                   ' +
                       '        "RETIRADA"                    ' +
                       '      ELSE                            ' +
                       '        "ENTREGA"                     ' +
                       '    END                               ' +
                       '                      AS ENTRET,      ';
    Result := Result + '    TINDET.DET_TIPFOR AS TIPFOR,      ';
    Result := Result + '    TINDET.DET_OBSCOL AS OBSCOL,      ';
    Result := Result + '    TINDET.DET_FORM01 AS FORM01,      ';
    Result := Result + '    TINDET.DET_QTDB01 AS QTDB01,      ';
    Result := Result + '    TINDET.DET_FORM02 AS FORM02,      ';
    Result := Result + '    TINDET.DET_QTDB02 AS QTDB02,      ';
    Result := Result + '    TINDET.DET_FORM03 AS FORM03,      ';
    Result := Result + '    TINDET.DET_QTDB03 AS QTDB03,      ';
    Result := Result + '    TINDET.DET_FORM04 AS FORM04,      ';
    Result := Result + '    TINDET.DET_QTDB04 AS QTDB04,      ';
    Result := Result + '    TINDET.DET_FORM05 AS FORM05,      ';
    Result := Result + '    TINDET.DET_QTDB05 AS QTDB05,      ';
    Result := Result + '    TINDET.DET_FORM06 AS FORM06,      ';
    Result := Result + '    TINDET.DET_QTDB06 AS QTDB06,      ';
    Result := Result + '    TINDET.DET_FORM07 AS FORM07,      ';
    Result := Result + '    TINDET.DET_QTDB07 AS QTDB07,      ';
    Result := Result + '    TINDET.DET_FORM08 AS FORM08,      ';
    Result := Result + '    TINDET.DET_QTDB08 AS QTDB08,      ';
    Result := Result + '    TINDET.DET_FORM09 AS FORM09,      ';
    Result := Result + '    TINDET.DET_QTDB09 AS QTDB09,      ';
    Result := Result + '    TINDET.DET_FORM10 AS FORM10,      ';
    Result := Result + '    TINDET.DET_QTDB10 AS QTDB10,      ';
    Result := Result + '    TINDET.DET_FORM11 AS FORM11,      ';
    Result := Result + '    TINDET.DET_QTDB11 AS QTDB11,      ';
    Result := Result + '    TINDET.DET_FORM12 AS FORM12,      ';
    Result := Result + '    TINDET.DET_QTDB12 AS QTDB12,      ';
    Result := Result + '    TINDET.DET_FORM13 AS FORM13,      ';
    Result := Result + '    TINDET.DET_QTDB13 AS QTDB13,      ';
    Result := Result + '    TINDET.DET_FORM14 AS FORM14,      ';
    Result := Result + '    TINDET.DET_QTDB14 AS QTDB14,      ';
    Result := Result + '    TINDET.DET_FORM15 AS FORM15,      ';
    Result := Result + '    TINDET.DET_QTDB15 AS QTDB15,      ';
    Result := Result + '    TINDET.DET_FORM16 AS FORM16,      ';
    Result := Result + '    TINDET.DET_QTDB16 AS QTDB16,      ';
    Result := Result + '    TINDET.DET_FORM17 AS FORM17,      ';
    Result := Result + '    TINDET.DET_QTDB17 AS QTDB17,      ';
    Result := Result + '    TINDET.DET_FORM18 AS FORM18,      ';
    Result := Result + '    TINDET.DET_QTDB18 AS QTDB18,      ';
    Result := Result + '    TINDET.DET_QTDB19 AS QTDB19,      ';
    Result := Result + '    TINDET.DET_FORM20 AS FORM20,      ';
    Result := Result + '    TINDET.DET_QTDB20 AS QTDB20,      ';
    Result := Result + '    CONCAT(TINDET.DET_CODVEN, "-", VEN.OPE_NOMOPE) AS NOMOPE,     ';
    Result := Result + '    CONCAT(TINDET.DET_CODDIV, "-", DIG.OPE_NOMOPE) AS NOMDIG,     ';
    Result := Result + '    CONCAT(TINDET.DET_CODCLI, "-", IF(GER.GER_NOMCON = "" OR GER.GER_NOMCON IS NULL, CLI.CLI_NOMCLI, GER.GER_NOMCON)) AS NOMCLI,     ';
    Result := Result + '    MOVGER.GER_MEN001 AS MEN001,      ';
    Result := Result + '    MOVGER.GER_MEN002 AS MEN002,      ';
    Result := Result + '    MOVGER.GER_MEN003 AS MEN003,      ';
    Result := Result + '    MOVGER.GER_MEN004 AS MEN004,      ';
    Result := Result + '    MOVGER.GER_MEN005 AS MEN005,      ';
    Result := Result + '    ITE.ITE_CODFAB AS CODFAB,         ';
    Result := Result + '    TINDET.DET_REFERE AS REFERE,      ';
    Result := Result + '    IFNULL(TINDET.DET_EMPPRD, TINDET.DET_CODEMP) AS EMPPRD,      ';
    Result := Result + '    MOVGER.GER_MENEXP AS MENEXP,              ';
    Result := Result + '    MOVGER.GER_MENEX2 AS MENEX2,              ';
    Result := Result + '    MOVGER.GER_MENEX3 AS MENEX3,              ';
    Result := Result + '    MOVGER.GER_MENEX4 AS MENEX4,              ';
    Result := Result + '    DET.DET_CODITE    AS CODBAS               ';
    Result := Result + '  FROM                                ';
    Result := Result + '    TINDET                            ';
    Result := Result + '  JOIN TINGER AS GER ON                       ';
    Result := Result + '    GER.AUTOINCREM = TINDET.DET_SEQGER              ';
    Result := Result + '  INNER JOIN CADITE AS ITE ON       ';
    Result := Result + '    TINDET.DET_CODITE = ITE.ITE_CODITE        ';
    Result := Result + '  JOIN MOVDET AS DET ON                       ';
    Result := Result + '    DET.DET_NUMDOC = TINDET.DET_NUMDOC AND          ';
    Result := Result + '    DET.DET_ESPDOC = TINDET.DET_ESPDOC AND          ';
    Result := Result + '    DET.DET_CODEMP = TINDET.DET_CODEMP AND          ';
    Result := Result + '    DET.DET_CODCLI = TINDET.DET_CODCLI AND          ';
    Result := Result + '    DET.DET_CODACA = TINDET.DET_CODACA AND          ';
    Result := Result + '    DET.DET_EMPACA = TINDET.DET_EMPACA              ';
    Result := Result + '  JOIN CADOPE AS VEN ON                       ';
    Result := Result + '    TINDET.DET_CODVEN = VEN.OPE_CODOPE              ';
    Result := Result + '  LEFT JOIN CADOPE AS DIG ON                  ';
    Result := Result + '    TINDET.DET_CODDIG = DIG.OPE_CODOPE              ';
    Result := Result + '  JOIN CADCLI AS CLI ON                       ';
    Result := Result + '    TINDET.DET_CODCLI = CLI.CLI_CODCLI              ';
    Result := Result + '  JOIN MOVGER AS MOVGER ON                    ';
    Result := Result + '    MOVGER.AUTOINCREM = DET.DET_SEQGER              ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    DET.DET_CLAFIS >= 5000 AND                      ';
    Result := Result + '    DET.DET_PROEMB <> "S" AND                       ';
    Result := Result + '    TINDET.DET_NUMDOC = :NUMDOC AND                 ';
    Result := Result + '    TINDET.DET_ESPDOC = :ESPDOC AND                 ';
    Result := Result + '    TINDET.DET_CODEMP = :CODEMP                     ';

    If Not fEmptyStr(recDocume.strEmpPrd) Then
      Result := Result + '  AND TINDET.DET_EMPPRD = :EMPPRD                     ';

    If (Not fEmptyStr(recDocume.strCodAca)) And (Not fEmptyStr(recDocume.strEmpAca)) {And (Not (fCfgSis('EMIOPR', varBoolean)))} Then
    Begin
      Result := Result + '  AND TINDET.DET_CODACA = :CODACA                 ';
      Result := Result + '  AND TINDET.DET_EMPACA = :EMPACA                 ';
    End;

    Result := Result + '    GROUP BY TINDET.DET_CODACA, TINDET.DET_EMPACA         ';
  End;

end;

function TLeOrdProTintasAutomotiva.fInsereClientFormulacao(): Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)], recDocume Do
  Begin
    cdsDados := cdsFormulacao;
    frxDados := TfrxDBDataSEt.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name := 'frxTinAut';
    frxDados.UserName := 'frxTinAut';
  End;

  Result := (Not ArrClients[High(arrClients)].cdsDados.IsEmpty);
end;

function TLeOrdProTintasAutomotiva.fInsereClientTintas(Var regClient: TRegClient): Boolean;
begin

  With regClient Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLTintas);

    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet  := cdsDados;
    frxDados.Name     := 'frxTinDor';
    frxDados.UserName := 'frxTinDor';
  End;

  With regClient, cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    If Assigned(Params.FindParam('EMPPRD')) Then
      ParamByName('EMPPRD').AsString := strEmpPrd;

    If (Not fEmptyStr(strCodAca)) And (Not fEmptyStr(strEmpAca)) {And (Not fCfgSis('EMIOPR', varBoolean))} Then
    Begin
      ParamByName('CODACA').AsString := strCodAca;
      ParamByName('EMPACA').AsString := strEmpAca;
    End;
    Result := fAbreClient(True, 'fInsereClientTintas');
  End;
end;

function TLeOrdProTintasAutomotiva.fMontaClients(cdsDadosExternosMovGer,
  cdsDadosExternosMovDet: TZClient): Boolean;
Var
  regClient: TRegClient;
begin
  Result := True;
  Try
    Result := Result And fInsereClientTintas(regClient);
    cdsFormula := regClient.cdsDados;
    FTemFormula := (Not cdsFormula.IsEmpty);
    pCriaFieldFormulacao;
    pProcessaFormulacao(cdsFormula);
    Result := Result And fInsereClientFormulacao();
    Result := Result And fPreparaImpressaoDocumentos();
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;


function TLeOrdProTintasAutomotiva.fRetLinhaColorPro(
  strCodLin: String): String;
begin
  Result := '';

  If strCodLin = '1' Then
    Result := 'Autobase Plus 100:50'
  Else If strCodLin = '4' Then
    Result := 'Wandabase HS'
  Else If strCodLin = '6' Then
    Result := 'Wandalac'
  Else If strCodLin = '8' Then
    Result := 'Wanda PU HS'
  Else If strCodLin = '9' Then
    Result := 'Wandacar'
  Else If strCodLin = '11' Then
    Result := 'Single Stage Converter'
  Else If strCodLin = '59' Then
    Result := 'Autocoat BT90'
  Else If strCodLin = '13' Then
    Result := 'Autocoat BT100'
  Else If strCodLin = '15' Then
    Result := 'Autocoat BT110'
  Else If strCodLin = '16' Then
    Result := 'Autocoat BT120'
  Else If strCodLin = '17' Then
    Result := 'Autocoat BT130'
  Else If strCodLin = '18' Then
    Result := 'Autobase Plus 100:80'
  Else If strCodLin = '58' Then
    Result := 'Wanda PU MS'
  Else If strCodLin = '27' Then
    Result := 'Autowave MM'
  Else If strCodLin = '67' Then
    Result := 'Autowave MM 2.0'
  Else If strCodLin = '72' Then
    Result := 'Tech Fleet PU'
  Else If strCodLin = '74' Then
    Result := 'Tech Fleet Epoxy'
  Else If strCodLin = '75' Then
    Result := 'Tech Fleet Sintetico'
  Else If strCodLin = '76' Then
    Result := 'Tech Fleet Laca';
end;

function TLeOrdProTintasAutomotiva.fSQLItems: String;
begin
  Result := '';
end;

procedure TLeOrdProTintasAutomotiva.pCarregaArrClients(
  dtsDataSet: TfrxDBDataSet);
Var
  intIndice: Integer;
begin
  If Assigned(arrClients) And (Length(arrClients)> 0) Then
  Begin
    If Assigned(arrClients[0].cdsDados) Then
      dtsDataSet.DataSet := arrClients[0].cdsDados;

    For intIndice := 0 To High(arrClients) Do
      frxReport.DataSets.Add(arrClients[intIndice].frxDados);
  End;
end;

procedure TLeOrdProTintasAutomotiva.pCriaFieldFormulacao;
begin
  cdsFormulacao := TZClient.Create(Nil);

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DOCUME';
    DataType := ftString;   // Numero do Documento
    Size := 12;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESPECI';
    DataType := ftString;        // Especie
    Size := 2;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;    // Empresa
    Size := 3;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLIENT';
    DataType := ftString;  // Cliente
    Size := 80;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESFOR';
    DataType := ftString;  // Descrição da Fórmula
    Size := 200;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDFOR';
    DataType := ftString; // Qtd da formula
    Size := 15;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'OBSCOL';
    DataType := ftString;// Obs Colorista
    Size := 100;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPFOR';
    DataType := ftString; //Tipo da Formula
    Size := 30;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODVEN';
    DataType := ftString; //Vendedor
    Size := 30;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODDIG';
    DataType := ftString; //Digitador
    Size := 30;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DATA__';
    DataType := ftString;  //Data Entrada
    Size := 12;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'HORA__';
    DataType := ftString; //Hora Entrada
    Size := 10;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNITAR';
    DataType := ftFloat; //Valor Unitario;
    Precision := 15;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DILCON';
    DataType := ftString; // Diluido/Concentrado
    Size := 20;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ANOCOR';
    DataType := ftString; //Ano da cor
    Size := 20;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPEMB';
    DataType := ftString;  //Tipo da Embalagem
    Size := 10;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FORMUL';
    DataType := ftString;   //Formulas
    Size := 70;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QUANTI';
    DataType := ftString; //Quantidades das FOrmulas
    Size := 15;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMTIN';
    DataType := ftString;
    Size := 40;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MONTAD';
    DataType := ftString;
    Size := 40;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODTIN';
    DataType := ftString;
    Size := 40;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MARTIN';
    DataType := ftString;
    Size := 40;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VOLPRO';
    DataType := ftString;
    Size := 15;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESEMB';
    DataType := ftString;
    Size := 50;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VARIAC';
    DataType := ftString;
    Size := 35;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESTIN';
    DataType := ftString;
    Size := 25;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPTIN';
    DataType := ftString;
    Size := 30;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MEN001';
    DataType := ftString;
    Size := 80;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MEN002';
    DataType := ftString;
    Size := 80;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MEN003';
    DataType := ftString;
    Size := 80;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MEN004';
    DataType := ftString;
    Size := 80;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MEN005';
    DataType := ftString;
    Size := 80;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFAB';
    DataType := ftString;
    Size := 25;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EMPPRD';
    DataType := ftString;
    Size := 3;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCHA';
    DataType := ftString;
    Size := 50;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MENEXP';
    DataType := ftString;
    Size := 70;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MENEX2';
    DataType := ftString;
    Size := 70;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MENEX3';
    DataType := ftString;
    Size := 70;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MENEX4';
    DataType := ftString;
    Size := 70;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODBAS';
    DataType := ftString;
    Size := 5;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'REFERE';
    DataType := ftString;
    Size := 16;
  End;

  cdsFormulacao.CreateDataSet;
end;

procedure TLeOrdProTintasAutomotiva.pProcessaFormulacao(
  cdsFormula: TZClient);
Var
  intContador: Integer;
  strCodCol: String;
  fltTotAcu: Double;
  dicRetorno: TDicionario;
  fltVolPro: Double;
  strDesEmb: String;
  strDesCha: String;
  fltQtdFormul: Double;
  recInfTin: TRecInfoImpressaoOPTinta;
  fltValUni: Double;
  intBase: Integer;

  intDecimaisFormul: Integer;
  strCodIte: string;
  strDescriCol: string;
  strCodColRet: string;
  fltQuantidadeExibida: Double;
  blnUsaChapinha: Boolean;
  strCodChapinha: String;
begin
  If Not FTemFormula Then
    Exit;

  cdsFormula.First;
  dicRetorno := TDicionario.Create;


  While Not cdsFormula.Eof Do
  Begin
    cdsFormulacao.EmptyDataSet;

    //Carrega Dados da tinta
    dicRetorno.Limpar;

    pRetornaDadosTinta(cdsFormula.FieldByName('IDEPRO').AsString,
                       cdsFormula.FieldByName('ITETIN').AsString,
                       dicRetorno);

    pRetDadosAdicionais(cdsFormula.FieldByName('CODACA').AsString,
                        cdsFormula.FieldByName('EMPACA').AsString,
                        cdsFormula.FieldByName('ESPDOC').AsString,
                        cdsFormula.FieldByName('IDEPRO').AsString,
                        fltVolPro,
                        strDesEmb);

    blnUsaChapinha := fUsaChapinhaTinta(cdsFormula.FieldByName('IDEPRO').AsString,
                                        cdsFormula.FieldByName('ITETIN').AsString);

    If blnUsaChapinha Then
    Begin
      strCodChapinha := fRetornaCodigoChapinha(cdsFormula.FieldByName('IDEPRO').AsString);

      If Not fEmptyStr(strCodChapinha) Then
        strDesCha := fRetNomProduto(strCodChapinha)
      Else
        strDesCha := '';
    End
    Else
      strDesCha := '';


    recInfTin.strMontad := dicRetorno['montad'];
    recInfTin.strMarTin :=  AnsiUpperCase(fRetLinhaColorPro(dicRetorno['martin']));
    recInfTin.strDesemb := strDesEmb;
    recInfTin.strDesCha := strDesCha;
    recInfTin.strVariac := IfNull(dicRetorno['variac'], '');
    recInfTin.fltVolPro := fltVolPro;



    {*******************************************}
    {* PROCESSA OS COLORANTES DA FÓRMULA       *}
    {****************************************RG*}
    fltTotAcu := 0.0;
    For intContador := 1 To 20 Do
    Begin

      If Not Assigned(cdsFormula.FindField('FORM' + fStrZero(intContador, 2))) Then
        Break;

        intBase := Pos('_', cdsFormula.FieldByName('FORM' + fStrZero(intContador, 2)).AsString);

        If intBase = 0 Then
          strCodCol := cdsFormula.FieldByName('FORM' + fStrZero(intContador, 2)).AsString
        Else
          strCodCol := Copy(cdsFormula.FieldByName('FORM' + fStrZero(intContador, 2)).AsString, intBase + 1, Length(cdsFormula.FieldByName('FORM' + fStrZero(intContador, 2)).AsString));


      If (fEmptyStr(strCodCol)) Or (strCodCol = '_') Then
        Continue;

      strDescriCol := '';
      strCodIte := '';
      strCodColRet := '';

      pRetItemEDescricaoColorante(cdsFormula.FieldByName('IDEPRO').AsString,
        strCodCol,
        strCodIte,
        strCodColRet,
        strDescriCol,
        VS_strCodEmp);

      If Not fEmptyStr(strDescriCol) Then
        strCodCol := strCodColRet + '-' + strDescriCol;

      intDecimaisFormul := -fCasasDecimais(cdsFormula.FieldByName('IDEPRO').AsString);

      If fGetConfTinta(cdsFormula.FieldByName('IDEPRO').AsString).fGet('ACUABS') = '2' Then
        fltTotAcu := 0.0;

      fltTotAcu := fltTotAcu + RoundTo(cdsFormula.FieldByName('QTDB' + fStrZero(intContador, 2)).AsFloat / fGetFatorML(cdsFormula.FieldByName('IDEPRO').AsString), intDecimaisFormul);

      If cdsFormula.FieldByName('QTDEMB').AsFloat > cdsFormula.FieldByName('QTDITE').AsFloat Then
        fltQtdFormul := cdsFormula.FieldByName('QTDITE').AsFloat
      Else If cdsFormula.FieldByName('QTDEMB').AsFloat > 0 Then
        fltQtdFormul := cdsFormula.FieldByName('QTDEMB').AsFloat
      Else
        fltQtdFormul := cdsFormula.FieldByName('QTDITE').AsFloat;



      cdsFormulacao.Append;
      cdsFormulacao.FieldByName('DOCUME').AsString := cdsFormula.FieldByName('NUMDOC').AsString;
      cdsFormulacao.FieldByName('ESPECI').AsString := cdsFormula.FieldByName('ESPDOC').AsString;
      cdsFormulacao.FieldByName('CODEMP').AsString := cdsFormula.FieldByName('CODEMP').AsString;

      If fCfgSis('IMPDOP') = '2' Then
        cdsFormulacao.FieldByName('FORMUL').AsString := strCodColRet + '-' + fRetNomProduto(strCodIte)
      Else
        cdsFormulacao.FieldByName('FORMUL').AsString := strCodCol;

      fltQuantidadeExibida := fltTotAcu / fltQtdFormul;

      If fCfgSis('TOTPRD', varBoolean) Then
        fltQuantidadeExibida := fltQuantidadeExibida * fltQtdFormul;

      cdsFormulacao.FieldByName('QUANTI').AsString := FloatToStrF(fFormataEspecifico(fltQuantidadeExibida, cdsFormula.FieldByName('IDEPRO').AsString), ffNumber, 12, fCasasDecimais(cdsFormula.FieldByName('IDEPRO').AsString));

      cdsFormulacao.FieldByName('QTDFOR').AsString := FloatToStrF(fltQtdFormul, ffNumber, 12, 2);

      cdsFormulacao.FieldByName('CLIENT').AsString := cdsFormula.FieldByName('NOMCLI').AsString;

      cdsFormulacao.FieldByName('DESFOR').AsString := cdsFormula.FieldByName('IDEPRO').AsString + ' - ' + cdsFormula.FieldByName('DESCRI').AsString;

      If recDocume.strTipImp = 'M' Then
      Begin
        cdsFormulacao.FieldByName('CODVEN').AsString := fTiraCaracNota(cdsFormula.FieldByName('NOMOPE').AsString);
        cdsFormulacao.FieldByName('CODDIG').AsString := fTiraCaracNota(cdsFormula.FieldByName('NOMDIG').AsString);
      End
      Else
      Begin
        cdsFormulacao.FieldByName('CODVEN').AsString := cdsFormula.FieldByName('NOMOPE').AsString;
        cdsFOrmulacao.FieldByName('CODDIG').AsString := cdsFormula.FieldByName('NOMDIG').AsString;
      End;

      cdsFormulacao.FieldByName('DATA__').AsString := DateToStr(cdsFormula.FieldByName('DTAENT').AsDateTime);
      cdsFormulacao.FieldByName('HORA__').AsString := TimeToStr(cdsFormula.FieldByName('HORENT').AsDateTime);
      cdsFormulacao.FieldByName('OBSCOL').AsString := cdsFormula.FieldByName('OBSCOL').AsString;
      cdsFormulacao.FieldByName('TIPFOR').AsString := IIF(cdsFormula.FieldByName('TIPFOR').AsInteger = 0, 'FÓRMULA ORIGINAL', 'FÓRMULA AJUSTADA');


      If recDocume.strEspDoc <> 'OR' Then
        fltValUni := StrToFloat(cdsFormula.FieldByName('UNITAR').AsString)
      Else
        fltValUni := StrToFloat(cdsFormula.FieldByName('TOTITE').AsString);

      cdsFormulacao.FieldByName('UNITAR').AsString := FormatFloat('#0.00', fltValUni);

      cdsFormulacao.FieldByName('TIPEMB').AsString := cdsFormula.FieldByName('VOLPRO').AsString + ' ' + cdsFormula.FieldByName('TIPEMB').AsString;

      If fEmptyStr(cdsFormula.FieldByName('DILCON').AsString) Then
        cdsFormulacao.FieldByName('DILCON').AsString := ''
      Else
        cdsFormulacao.FieldByName('DILCON').AsString := IIF(cdsFormula.FieldByName('DILCON').AsString = 'C', 'CONCENTRADO', 'DILUIDO');

      cdsFormulacao.FieldByName('ANOCOR').AsString := cdsFormula.FieldByName('ANOCOR').AsString;
      cdsFormulacao.FieldByName('DESTIN').AsString := cdsFormula.FieldByName('ENTRET').AsString;
      cdsFormulacao.FieldByName('NOMTIN').AsString := AnsiUpperCase(fRetornaNomeTinta(cdsFormula.FieldByName('IDEPRO').AsString));
      cdsFormulacao.FieldByName('CODTIN').AsString := dicRetorno['codtin'];
      cdsFormulacao.FieldByName('MONTAD').AsString := recInfTin.strMontad;
      cdsFormulacao.FieldByName('MARTIN').AsString := recInfTin.strMarTin;
      cdsFormulacao.FieldByName('VOLPRO').AsFloat := recInfTin.fltVolPro;
      cdsFormulacao.FieldByName('DESEMB').AsString := recInfTin.strDesemb;
      cdsFormulacao.FieldByName('DESCHA').AsString := recInfTin.strDesCha;
      cdsFormulacao.FieldByName('VARIAC').AsString := recInfTIn.strVariac;
      cdsFormulacao.FieldByName('TIPTIN').AsString := IIF(fTintaBaixaProduto(cdsFormula.FieldByName('IDEPRO').AsString),  'I', 'A');
      cdsFormulacao.FieldByName('MEN001').AsString := cdsFormula.FieldByName('MEN001').AsString;
      cdsFormulacao.FieldByName('MEN002').AsString := cdsFormula.FieldByName('MEN002').AsString;
      cdsFormulacao.FieldByName('MEN003').AsString := cdsFormula.FieldByName('MEN003').AsString;
      cdsFormulacao.FieldByName('MEN004').AsString := cdsFormula.FieldByName('MEN004').AsString;
      cdsFormulacao.FieldByName('MEN005').AsString := cdsFormula.FieldByName('MEN005').AsString;
      cdsFormulacao.FieldByName('CODFAB').AsString := cdsFormula.FieldByName('CODFAB').AsString;
      cdsFormulacao.FieldByName('EMPPRD').AsString := cdsFormula.FieldByName('EMPPRD').AsString;
      cdsFormulacao.FieldByName('MENEXP').AsString := cdsFormula.FieldByName('MENEXP').AsString;
      cdsFormulacao.FieldByName('MENEX2').AsString := cdsFormula.FieldByName('MENEX2').AsString;
      cdsFormulacao.FieldByName('MENEX3').AsString := cdsFormula.FieldByName('MENEX3').AsString;
      cdsFormulacao.FieldByName('MENEX4').AsString := cdsFormula.FieldByName('MENEX4').AsString;
      cdsFormulacao.FieldByName('CODBAS').AsString := cdsFormula.FieldByName('CODBAS').AsString;
      cdsFormulacao.FieldByName('REFERE').AsString := cdsFormula.FieldByName('REFERE').AsString;
      cdsFormulacao.Post;
    End;
    cdsFormula.Next;
  End;

  If Assigned(dicRetorno) Then
    FreeAndNil(dicRetorno);


end;

procedure TLeOrdProTintasAutomotiva.pRetDadosAdicionais(strCodAca,
  strEmpAca, strEspDoc, strIdePro: String; var fltVolPro: Double;
  var strDesEmb: String);
Var
  qryAux: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';

    If Pos(strEspDoc, 'OR_PD_') > 0 Then
    Begin
      strSQL := strSQL + '  SELECT            ';
      strSQL := strSQL + '    FDO_IDEPRO,     ';
      strSQL := strSQL + '    FDO_VOLPRO,     ';
      strSQL := strSQL + '    FDO_QTDEMB,     ';
      strSQL := strSQL + '    FDO_QTDITE,     ';
      strSQL := strSQL + '    ITE_DESITE      ';
      strSQL := strSQL + '  FROM              ';
      strSQL := strSQL + '    FATDOR          ';

      If fTintaBaixaProduto(strIdePro) Then
        strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = FDO_CODITE      '
      Else
        strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = FDO_ITEEMB      ';

      strSQL := strSQL + '  WHERE             ';
      strSQL := strSQL + '    FDO_CODACA = :CODACA   AND      ';
      strSQL := strSQL + '    FDO_EMPACA = :EMPACA            ';

      qryAux := fCriaQuery();
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('CODACA').AsString := strCodAca;
      qryAux.ParamByName('EMPACA').AsString := strEmpAca;
      qryAux.Open;

      fltVolPro := qryAux.FieldByName('FDO_VOLPRO').AsFloat;
      strDesEmb := qryAux.FieldByName('ITE_DESITE').AsString;
    End
    Else
    Begin
      strSQL := strSQL + '  SELECT                ';
      strSQL := strSQL + '    DET_IDEPRO,         ';
      strSQL := strSQL + '    DET_VOLPRO,         ';
      strSQL := strSQL + '    DET_QTDEMB,         ';
      strSQL := strSQL + '    DET_QTDITE,         ';
      strSQL := strSQL + '    ITE_DESITE          ';
      strSQL := strSQL + '  FROM                  ';
      strSQL := strSQL + '    MOVDET              ';

      If fTintaBaixaProduto(strIdePro) Then
        strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = DET_CODITE        '
      Else
        strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = DET_ITEEMB        ';

      strSQL := strSQL + '  WHERE                 ';
      strSQL := strSQL + '    DET_CODACA = :CODACA AND       ';
      strSQL := strSQL + '    DET_EMPACA = :EMPACA           ';

      If fTintaBaixaProduto(strIdePro) Then
        strSQL := strSQL + '  AND DET_ESPDOC NOT IN ("ML","PR","RO")    ';

      qryAux := fCriaQuery();
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('CODACA').AsString := strCodAca;
      qryAux.ParamByName('EMPACA').AsString := strEmpAca;
      qryAux.Open;

      fltVolPro := qryAux.FieldByName('DET_VOLPRO').AsFloat;
      strDesEmb := qryAux.FieldByName('ITE_DESITE').AsString;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

end.
