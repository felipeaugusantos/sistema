unit untDocOrdProTintasImobiliaria;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni;

Type
  TLeOrdProTintasImobiliaria = Class(TLeDocumento)
  Private
    cdsFormula:TZClient;
    cdsFormulacao: TZClient;
    FTemFormula: Boolean;

    function fGetSQLTintas(): String;
    function fInsereClientTintas(Var regClient: TRegClient): Boolean;
    function fInsereClientFormulacao(): Boolean;
    function fColoranteTemEmbalagem(strIdePro: String): Boolean;
    function fCasasDecimais(strIdePro: String): Integer;
    function fRetornaProdutoBase(strCodBas, strCodUni, strDescri: String): String;
    function fRetornaEmbalagemColorante(strIdePro, strCodCol: String): Double;
    function fRetornaDescricaoItemBase(strIdePro, strIteTin:String):String;
    function fRetDescBase(strNumDoc, strEspDoc, strIteTin: String; strCodEmp: String): String;
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

{ TLeOrdemProducaoPreliminarOrcamento }

function TLeOrdProTintasImobiliaria.fCasasDecimais(
  strIdePro: String): Integer;
begin
  If Pos(strIdePro, 'IQU_AJA_SHE_REN_ANN_INK_SUV_') > 0 Then
    Result := 3
  Else If strIdePro = 'REC' Then
    Result := 4
  Else
    Result := 2;
end;

function TLeOrdProTintasImobiliaria.fColoranteTemEmbalagem(
  strIdePro: String): Boolean;
begin
  Result := False;

  //Imobiliarias por enquanto
  If fTintaBaixaProduto(strIdePro) Then
  Begin
    Result := fCampoExiste(fRetornaTabelaColoranteTinta(strIdePro), 'COL_EMBALA');
  End;
end;

function TLeOrdProTintasImobiliaria.fGetSQLTintas(): String;
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
    Result := Result + '    CONCAT(TINDOR.FDO_CODVEN, "-", VEN.OPE_NOMOPE) AS NOMOPE,   ';
    Result := Result + '    CONCAT(TINDOR.FDO_CODDIV, "-", DIG.OPE_NOMOPE) AS NOMDIG,   ';
    Result := Result + '    CONCAT(TINDOR.FDO_CODCLI, "-", IF(GOR.FGO_NOMCON = "" OR GOR.FGO_NOMCON IS NULL, CLI.CLI_NOMCLI, GOR.FGO_NOMCON)) AS NOMCLI,     ';
    Result := Result + '    ITE.ITE_DESITE AS DESITE,                 ';
    Result := Result + '    ITE.ITE_REFERE AS REFERE,                 ';
    Result := Result + '    ITE.ITE_CODITE AS CODITE,                 ';
    Result := Result + '    FATGOR.FGO_MEN001 AS MEN001,              ';
    Result := Result + '    FATGOR.FGO_MEN002 AS MEN002,              ';
    Result := Result + '    AUXGOR.AUX_MEN003 AS MEN003,              ';
    Result := Result + '    AUXGOR.AUX_MEN004 AS MEN004,              ';
    Result := Result + '    AUXGOR.AUX_MEN005 AS MEN005,              ';
    Result := Result + '    ITE.ITE_CODFAB AS CODFAB,                 ';
    Result := Result + '    IFNULL(FATDOR.FDO_EMPPRD, FATDOR.FDO_CODEMP) AS EMPPRD,    ';
    Result := Result + '    ITE.ITE_CODBAR AS CODBAR,                 ';
    Result := Result + '    FATGOR.FGO_MENEXP AS MENEXP,              ';
    Result := Result + '    FATGOR.FGO_MENEX2 AS MENEX2,              ';
    Result := Result + '    FATGOR.FGO_MENEX3 AS MENEX3,              ';
    Result := Result + '    FATGOR.FGO_MENEX4 AS MENEX4,              ';
    Result := Result + '    FATDOR.FDO_CODITE AS CODBAS               ';
    Result := Result + '  FROM                              ';
    Result := Result + '    TINDOR                          ';
    Result := Result + '  INNER JOIN CADITE AS ITE ON       ';
    Result := Result + '    TINDOR.FDO_CODITE = ITE.ITE_CODITE        ';
    Result := Result + '  INNER JOIN TINGOR AS GOR ON       ';
    Result := Result + '    GOR.AUTOINCREM = TINDOR.FDO_SEQGER        ';
    Result := Result + '  INNER JOIN CADOPE AS VEN ON       ';
    Result := Result + '    TINDOR.FDO_CODVEN = VEN.OPE_CODOPE        ';
    Result := Result + '  LEFT JOIN CADOPE AS DIG ON        ';
    Result := Result + '    TINDOR.FDO_CODDIG = DIG.OPE_CODOPE        ';
    Result := Result + '  INNER JOIN CADCLI AS CLI ON       ';
    Result := Result + '    TINDOR.FDO_CODCLI = CLI.CLI_CODCLI        ';
    Result := Result + '  INNER JOIN FATDOR ON              ';
    Result := Result + '    FATDOR.FDO_NUMDOC = TINDOR.FDO_NUMDOC AND         ';
    Result := Result + '    FATDOR.FDO_ESPDOC = TINDOR.FDO_ESPDOC AND         ';
    Result := Result + '    FATDOR.FDO_CODEMP = TINDOR.FDO_CODEMP AND         ';
    Result := Result + '    FATDOR.FDO_CODCLI = TINDOR.FDO_CODCLI AND         ';
    Result := Result + '    FATDOR.FDO_CODACA = TINDOR.FDO_CODACA AND         ';
    Result := Result + '    FATDOR.FDO_EMPACA = TINDOR.FDO_EMPACA             ';
    Result := Result + '  LEFT JOIN EXTDOR ON               ';
    Result := Result + '    EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM             ';
    Result := Result + '  INNER JOIN FATGOR ON              ';
    Result := Result + '    FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER             ';
    Result := Result + '  LEFT JOIN AUXGOR ON (AUXGOR.AUX_SEQGER = FATGOR.AUTOINCREM) ';
    Result := Result + '  WHERE                             ';
    Result := Result + '    TINDOR.FDO_NUMDOC = :NUMDOC AND           ';
    Result := Result + '    TINDOR.FDO_ESPDOC = :ESPDOC AND           ';
    Result := Result + '    TINDOR.FDO_CODEMP = :CODEMP               ';

    If (Not fEmptyStr(recDocume.strCodAca)) And (Not fEmptyStr(recDocume.strEmpAca)) {And (Not fCfgSis('EMIOPR', varBoolean))} Then
    Begin
      Result := Result + '  AND TINDOR.FDO_CODACA = :CODACA                ';
      Result := Result + '  AND TINDOR.FDO_EMPACA = :EMPACA                ';
    End;

    Result := Result + '    GROUP BY TINDOR.FDO_CODACA, TINDOR.FDO_EMPACA       ';
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
    Result := Result + '    IFNULL(TINDET.DET_EMPPRD, TINDET.DET_CODEMP) AS EMPPRD,      ';
    Result := Result + '    ITE.ITE_CODBAR AS CODBAR,                 ';
    Result := Result + '    MOVGER.GER_MENEXP AS MENEXP,              ';
    Result := Result + '    MOVGER.GER_MENEX2 AS MENEX2,              ';
    Result := Result + '    MOVGER.GER_MENEX3 AS MENEX3,              ';
    Result := Result + '    MOVGER.GER_MENEX4 AS MENEX4,              ';
    Result := Result + '    DET.DET_CODITE AS CODBAS                  ';
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
      Result := Result + '  AND TINDET.DET_EMPPRD = :EMPPRD                 ';

    If (Not fEmptyStr(recDocume.strCodAca)) And (Not fEmptyStr(recDocume.strEmpAca)) {And (Not (fCfgSis('EMIOPR', varBoolean)))} Then
    Begin
      Result := Result + '  AND TINDET.DET_CODACA = :CODACA                 ';
      Result := Result + '  AND TINDET.DET_EMPACA = :EMPACA                 ';
    End;

    Result := Result + '    GROUP BY TINDET.DET_CODACA, TINDET.DET_EMPACA         ';
  End;
end;

function TLeOrdProTintasImobiliaria.fInsereClientFormulacao: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)], recDocume Do
  Begin
    cdsDados := cdsFormulacao;
    frxDados := TfrxDBDataSEt.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name := 'frxTinImo';
    frxDados.UserName := 'frxTinImo';
  End;

  Result := (Not ArrClients[High(arrClients)].cdsDados.IsEmpty);
end;

function TLeOrdProTintasImobiliaria.fInsereClientTintas(Var regClient: TRegClient): Boolean;
begin

  With RegClient Do
  Begin
    cdsDados := TZClient.Create(Nil, fGetSQLTintas);

    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet  := cdsDados;
    frxDados.Name     := 'frxTinDor';
    frxDados.UserName := 'frxTinDor';
  End;

  With RegClient, cdsDados, qryQuery, recDocume Do
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

function TLeOrdProTintasImobiliaria.fMontaClients(
  cdsDadosExternosMovGer, cdsDadosExternosMovDet: TZClient): Boolean;
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

function TLeOrdProTintasImobiliaria.fRetDescBase(strNumDoc, strEspDoc,
  strIteTin, strCodEmp: String): String;
Var
  qryAux: TUniQuery;
  strSQL: String;
begin
  Try
    If Pos(strEspDoc, 'OR_PD_') > 0 Then
    Begin
      strSQL := '';
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    ITE_DESITE            ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    TINDOR                ';
      strSQL := strSQL + '  INNER JOIN CADITE ON              ';
      strSQL := strSQL + '    ITE_CODITE = FDO_CODITE               ';
      strSQL := strSQL + '  WHERE                   ';
      strSQL := strSQL + '    FDO_NUMDOC = :NUMDOC AND        ';
      strSQL := strSQL + '    FDO_ESPDOC = :ESPDOC AND        ';
      strSQL := strSQL + '    FDO_CODEMP = :CODEMP AND        ';
      strSQL := strSQL + '    FDO_ITETIN = :ITETIN            ';
    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + '  SELECT                  ';
      strSQL := strSQL + '    ITE_DESITE            ';
      strSQL := strSQL + '  FROM                    ';
      strSQL := strSQL + '    TINDET                ';
      strSQL := strSQL + '  INNER JOIN CADITE ON              ';
      strSQL := strSQL + '    ITE_CODITE = DET_CODITE               ';
      strSQL := strSQL + '  WHERE                   ';
      strSQL := strSQL + '    DET_NUMDOC = :NUMDOC AND        ';
      strSQL := strSQL + '    DET_ESPDOC = :ESPDOC AND        ';
      strSQL := strSQL + '    DET_CODEMP = :CODEMP AND        ';
      strSQL := strSQL + '    DET_ITETIN = :ITETIN            ';
    End;

    qryAux := fCriaQuery();
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('ITETIN').AsString := strIteTin;
    qryAux.Open;

    Result := qryAux.FieldByName('ITE_DESITE').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TLeOrdProTintasImobiliaria.fRetornaDescricaoItemBase(
  strIdePro, strIteTin: String): String;
Var
  qryIteBas: TUniQuery;
  strSQL: String;
begin
  Result := '';

  If strIdePro = 'CIM' Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT COR_CODBAS,COR_CODUNI,COR_DESPRO ';
    strSQL := strSQL + '   FROM CORIMO_CADCOR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CONCAT(IFNULL(COR_DESCRI, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_CODIGO, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_UNIDAD, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_COLID1, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_COLID2, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_DESPRO, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_CODBAS, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_CODEMB, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_CODUNI, ""),  ';
    strSQL := strSQL + '          IFNULL(COR_UNIVER, "")) = :ITETIN; ';

    qryIteBas := fCriaQuery();
    qryIteBas.Close;
    qryIteBas.SQL.Clear;
    qryIteBas.SQL.Add(strSQL);
    qryIteBas.ParamByName('ITETIN').AsString := strIteTin;
    qryIteBas.Open;

    If Not qryIteBas.IsEmpty Then
      Result :=  fRetornaProdutoBase(qryIteBas.FieldByName('COR_CODBAS').AsString,
                                     qryIteBas.FieldByName('COR_CODUNI').AsString,
                                     qryIteBas.FieldByName('COR_DESPRO').AsString);

    qryIteBas.Close;
    FreeAndNil(qryIteBas);
  End;
end;

function TLeOrdProTintasImobiliaria.fRetornaEmbalagemColorante(
  strIdePro, strCodCol: String): Double;
Var
  qryEmb: TUniQuery;
  strSQL: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT              ';
    strSQL := strSQL + '    COL_EMBALA        ';
    strSQL := strSQL + '  FROM                ';
    strSQL := strSQL + ' ' + fRetornaTabelaColoranteTinta(strIdePro) + '     ';
    strSQL := strSQL + '  WHERE               ';
    strSQL := strSQL + '    COL_CODCOL = :COLORANTE               ';

    qryEmb := fCriaQuery();
    qryEmb.Close;
    qryEmb.SQL.Clear;
    qryEmb.SQL.Add(strSQL);
    qryEmb.ParamByName('COLORANTE').AsString := strCodCol;
    qryEmb.Open;

    Result := qryEmb.FieldByName('COL_EMBALA').AsFloat;
  Finally
    FreeAndNil(qryEmb);
  End;
end;

function TLeOrdProTintasImobiliaria.fRetornaProdutoBase(strCodBas,
  strCodUni, strDescri: String): String;
Var
  qryProdut: TUniQuery;
  strSQL: String;
begin
  Result := '';

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                ';
    strSQL := strSQL + '    BAS_CODITE,         ';
    strSQL := strSQL + '    ITE_DESITE,         ';
    strSQL := strSQL + '  FROM                  ';
    strSQL := strSQL + '    CORIMO_CADBAS       ';
    strSQL := strSQL + '  INNER JOIN CADITE ON          ';
    strSQL := strSQL + '    ITE_CODITE = BAS_CODITE             ';
    strSQL := strSQL + '  WHERE                 ';
    strSQL := strSQL + '    BAS_BASE__ = :CODBAS AND            ';
    strSQL := strSQL + '    BAS_DESCRI = :DESCRI AND            ';
    strSQL := strSQL + '    BAS_UNIDAD = :UNIDAD                ';

    qryProdut := fCriaQuery();
    qryProdut.Close;
    qryProdut.SQL.Clear;
    qryProdut.SQL.Add(strSQL);
    qryProdut.ParamByName('CODBAS').AsString := strCodBas;
    qryProdut.ParamByName('DESCRI').AsString := strDescri;
    qryProdut.ParamByName('UNIDAD').AsString := strCodUni;
    qryProdut.Open;

    If Not qryProdut.IsEmpty Then
      Result := ' - ' + qryProdut.FieldByName('BAS_CODITE').AsString + ' Ref.' + qryProdut.FieldByName('ITE_DESITE').AsString;
  Finally
    FreeAndNil(qryProdut);
  End;
end;

function TLeOrdProTintasImobiliaria.fSQLItems: String;
begin
  Result := '';
end;

procedure TLeOrdProTintasImobiliaria.pCarregaArrClients(
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

procedure TLeOrdProTintasImobiliaria.pCriaFieldFormulacao;
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
    Size  := 12;
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
    Name := 'EMBALA';
    DataType := ftString;  //Quantidade da Embalagem (COL_EMBALA)
    Size := 50;
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
    Name := 'CODTIN';
    DataType := ftString;
    Size := 40;
  End;

  With cdsFormulacao.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESBAS';
    DataType := ftString;
    Size := 100;
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
    Name := 'BASIMO';
    DataType := ftString;
    Size := 70;
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
    Name := 'CODBAR';
    DataType := ftString;
    Size := 25;
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

  cdsFormulacao.CreateDataSet;
end;

procedure TLeOrdProTintasImobiliaria.pProcessaFormulacao(
  cdsFormula: TZClient);
Var
  intContador: Integer;
  strCodCol: String;
  fltTotAcu: Double;
  dicRetorno: TDicionario;
  fltVolPro: Double;
  strDesEmb: String;
  fltQtdFormul: Double;
  recInfTin: TRecInfoImpressaoOPTinta;
  fltValUni: Double;


  intDecimaisFormul: Integer;
  strCodIte: string;
  strDescriCol: string;
  strCodColRet: string;
  fltQuantidadeExibida: Double;
  blnColEmb: Boolean;
  intAcuAbs: Integer;
begin
  If Not FTemFormula Then
    Exit;

  cdsFormula.First;
  dicRetorno := TDicionario.Create;

  While Not cdsFormula.Eof Do
  Begin
    cdsFormulacao.EmptyDataSet;

    //Colorante tem embalagem no cadastro de colorantes
    blnColEmb := fColoranteTemEmbalagem(cdsFormula.FieldByName('IDEPRO').AsString);

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


    recInfTin.strDesemb := strDesEmb;
    recInfTin.strVariac := IfNull(dicRetorno['variac'], '');
    recInfTin.blnImobil := fTintaBaixaProduto(cdsFormula.FieldByName('IDEPRO').AsString);
    recInfTin.blnColEmb := blnColEmb;

    fltTotAcu := 0.0;

    {*******************************************}
    {* PROCESSA OS COLORANTES DA FÓRMULA       *}
    {****************************************RG*}
    For intContador := 1 To 20 Do
    Begin
      If Not Assigned(cdsFormula.FindField('FORM' + fStrZero(intContador, 2))) Then
        Break;

      strCodCol := cdsFormula.FieldByName('FORM' + fStrZero(intContador, 2)).AsString;

      If (fEmptyStr(strCodCol)) Or (strCodCol = '_') Then
        Continue;

      strDescriCol := '';

      pRetItemEDescricaoColorante(cdsFormula.FieldByName('IDEPRO').AsString,
        strCodCol,
        strCodIte,
        strCodColRet,
        strDescriCol,
        VS_strCodEmp);

      If Not fEmptyStr(strDescriCol) Then
        strCodCol := strCodColRet + '-' + strDescriCol;

      intDecimaisFormul := -fCasasDecimais(cdsFormula.FieldByName('IDEPRO').AsString);

      If Not (cdsFormula.FieldByName('IDEPRO').AsString = 'ADT') Then
        fltTotAcu := RoundTo(cdsFormula.FieldByName('QTDB' + fStrZero(intContador, 2)).AsFloat / fGetFatorML(cdsFormula.FieldByName('IDEPRO').AsString), intDecimaisFormul)
      Else
      Begin
        If fEmptyStr(fGetConfTinta('ADT').fGet('ACUABS')) Then
          intAcuAbs := 2
        Else
          intAcuAbs := fGetConfTinta('ADT').fGetInteger('ACUABS');

        If intAcuAbs = 2 Then
          fltTotAcu :=  RoundTo(cdsFormula.FieldByName('QTDB' + fStrZero(intContador, 2)).AsFloat / fGetFatorML(cdsFormula.FieldByName('IDEPRO').AsString), intDecimaisFormul)
        Else
          fltTotAcu :=  fltTotAcu + RoundTo(cdsFormula.FieldByName('QTDB' + fStrZero(intContador, 2)).AsFloat / fGetFatorML(cdsFormula.FieldByName('IDEPRO').AsString), intDecimaisFormul)
      End;

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

      cdsFormulacao.FieldByName('QUANTI').AsString := fGetQuantidadeOncaPulsoMl(fltQuantidadeExibida, cdsFormula.FieldByName('IDEPRO').AsString, strCodColRet);

      If blnColEmb Then
        cdsFormulacao.FieldByName('EMBALA').AsString := FloatToStrF(fRetornaEmbalagemColorante(cdsFormula.FieldByName('IDEPRO').AsString,
          strCodColRet), ffNumber, 12, 4);

      If Pos(cdsFormula.FieldByName('IDEPRO').AsString, 'CIA_SHE_') > 0 Then
        cdsFormulacao.FieldByName('QTDFOR').AsString := FloatToStrF(fltQtdFormul, ffNumber, 12, 3)
      Else
        cdsFormulacao.FieldByName('QTDFOR').AsString := FloatToStrF(fltQtdFormul, ffNumber, 12, 2);

      cdsFormulacao.FieldByName('CLIENT').AsString := cdsFormula.FieldByName('NOMCLI').AsString;

      If cdsFormula.FieldByName('IDEPRO').AsString = 'CIM' Then
        cdsFormulacao.FieldByName('DESFOR').AsString := cdsFormula.FieldByName('IDEPRO').AsString + ' - ' + cdsFormula.FieldByName('DESCRI').AsString +
          fRetornaDescricaoItemBase(cdsFormula.FieldByName('IDEPRO').AsString, cdsFormula.FieldByName('ITETIN').AsString)
      Else If cdsFormula.FieldByName('IDEPRO').AsString = 'MEG' Then
        cdsFormulacao.FieldByName('DESFOR').AsString := cdsFormula.FieldByName('IDEPRO').AsString + ' - ' +
          cdsFormula.FieldByName('DESCRI').AsString + ' - ' + fRetDescBase(cdsFormula.FieldByName('NUMDOC').AsString,
                                                                           cdsFormula.FieldByName('ESPDOC').AsString,
                                                                           cdsFormula.FieldByName('ITETIN').AsString,
                                                                           cdsFormula.FieldByName('CODEMP').AsString)
      Else
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

      If recDocume.strEspDoc <> 'OR' Then
        fltValUni := StrToFloat(cdsFormula.FieldByName('UNITAR').AsString)
      Else
        fltValUni := StrToFloat(cdsFormula.FieldByName('TOTITE').AsString);

      cdsFormulacao.FieldByName('UNITAR').AsString := FormatFloat('#0.00', fltValUni);

      cdsFormulacao.FieldByName('DESTIN').AsString := cdsFormula.FieldByName('ENTRET').AsString;
      cdsFormulacao.FieldByName('NOMTIN').AsString := AnsiUpperCase(fRetornaNomeTinta(cdsFormula.FieldByName('IDEPRO').AsString));
      cdsFormulacao.FieldByName('CODTIN').AsString := dicRetorno['codtin'];
      cdsFormulacao.FieldByName('DESBAS').AsString := recInfTin.strDesemb;
      cdsFormulacao.FieldByName('VARIAC').AsString := recInfTIn.strVariac;
      cdsFormulacao.FieldByName('BASIMO').AsString := recInfTin.strDesemb;
      cdsFormulacao.FieldByName('MEN001').AsString := cdsFormula.FieldByName('MEN001').AsString;
      cdsFormulacao.FieldByName('MEN002').AsString := cdsFormula.FieldByName('MEN002').AsString;
      cdsFormulacao.FieldByName('MEN003').AsString := cdsFormula.FieldByName('MEN003').AsString;
      cdsFormulacao.FieldByName('MEN004').AsString := cdsFormula.FieldByName('MEN004').AsString;
      cdsFormulacao.FieldByName('MEN005').AsString := cdsFormula.FieldByName('MEN005').AsString;
      cdsFormulacao.FieldByName('CODFAB').AsString := cdsFormula.FieldByName('CODFAB').AsString;
      cdsFormulacao.FieldByName('EMPPRD').AsString := cdsFormula.FieldByName('EMPPRD').AsString;
      cdsFormulacao.FieldByName('CODBAR').AsString := cdsFormula.FieldByName('CODBAR').AsString;
      cdsFormulacao.FieldByName('MENEXP').AsString := cdsFormula.FieldByName('MENEXP').AsString;
      cdsFormulacao.FieldByName('MENEX2').AsString := cdsFormula.FieldByName('MENEX2').AsString;
      cdsFormulacao.FieldByName('MENEX3').AsString := cdsFormula.FieldByName('MENEX3').AsString;
      cdsFormulacao.FieldByName('MENEX4').AsString := cdsFormula.FieldByName('MENEX4').AsString;
      cdsFormulacao.FieldByName('CODBAS').AsString := cdsFormula.FieldByName('CODBAS').AsString;
      cdsFormulacao.Post;
    End;

    cdsFormula.Next;
  End;

  If Assigned(dicRetorno) Then
    FreeAndNil(dicRetorno);
end;

procedure TLeOrdProTintasImobiliaria.pRetDadosAdicionais(strCodAca,
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

      qryAux.Close;
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

      qryAux.Close;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;


end.

