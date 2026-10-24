unit untTFatBaixaEntregaFutura;

interface

uses System.SysUtils, System.StrUtils, Uni;

type
  TClienteRetira = (crNAO, crSIM, crTODOS);

  TParamsBaixaEntFut = class
  private
    { private declarations }
    FFaltaProduto: Boolean;
    FPrevisaoEntrega: Boolean;
    FAguardandoCliente: Boolean;
    FClienteVaiRetirar: TClienteRetira;
    FDataInicial: TDate;
    FDataFinal: TDate;
    FNumeroDocumento: String;
    FEspecieDocumento: String;
    FSeparacaoImpressa: Boolean;
    FLinhaGrupo: String;
    FCodigoCliente: String;
    FCodigoCidade: String;
    FMarcaTodos: Boolean;
    FImpressaoSeparacao: Boolean;
    FBaixaCST49: Boolean;
    FModoConsulta: Boolean;
    FAutoincMovs: String;
    FCodigoRegiao: String;
  protected
    { protected declarations }
    constructor Create;
  public
    { public declarations }
    function FaltaProduto(Const AValue: Boolean): TParamsBaixaEntFut;
    function PrevisaoEntrega(Const AValue: Boolean): TParamsBaixaEntFut;
    function AguardandoCliente(Const AValue: Boolean): TParamsBaixaEntFut;
    function ClienteVaiRetirar(Const Avalue: TClienteRetira): TParamsBaixaEntFut;
    function DataInicial(Const AValue: TDate): TParamsBaixaEntFut;
    function DataFinal(Const AValue: TDate): TParamsBaixaEntFut;
    function NumeroDocumento(Const Avalue: String): TParamsBaixaEntFut;
    function EspecieDocumento(Const AValue: String): TParamsBaixaEntFut;
    function SeparacaoImpressa(Const AValue: Boolean): TParamsBaixaEntFut;
    function LinhaGrupo(Const AValue: String): TParamsBaixaEntFut;
    function CodigoCliente(Const AValue: String): TParamsBaixaEntFut;
    function CodigoCidade(Const AValue: String): TParamsBaixaEntFut;
    function MarcaTodos(Const AValue: Boolean): TParamsBaixaEntFut;
    function ImpressaoSeparacao(Const AValue: Boolean): TParamsBaixaEntFut;
    function BaixaCST49(Const AValue: Boolean): TParamsBaixaEntFut;
    function ModoConsulta(Const AValue: Boolean): TParamsBaixaEntFut;
    function AutoincMovs(Const AValue: String): TParamsBaixaEntFut;
    function CodigoRegiao(Const AValue: String): TParamsBaixaEntFut;

    class function New: TParamsBaixaEntFut;
  end;


  TBaixaEntFut = class
  private
    { private declarations }
    FParams: TParamsBaixaEntFut;

    function fGetFiltroClienteVaiRetirar: String;
    function fGetFiltroSeparacaoImpressa: String;
    function fGetFiltroFaltaProduto: String;
    function fGetFiltroAguardandoCliente: String;
    function fGetFiltroPrevisaoEntrega: String;
    function fGetFiltroPeriodo: String;
    function fGetFiltroLinhaGrupo: String;
    function fGetFiltroCidade: String;
    function fGetFiltroCliente: String;
    function fGetFiltroBFUT49: String;
    function fGetFiltroAutoincMovs: String;
    function fGetFiltroRegiao: String;

    function fGetCampoQtdAnterior: String;
    function fGetCampoQtdPendente: String;
    function fGetCampoQtdEntregar: String;
    function fGetCampoQtdFut: String;
    function fGetCampoSaldos: String;
    function fGetCampoCodBar: String;

    function fGetSqlFromWhere: String;
  protected
    { protected declarations }
    constructor Create(AParams: TParamsBaixaEntFut);
  public
    { public declarations }
    function fSQLFiltroMinimo: String;
    function fGetSql: String;
    function fGetSqlSimplificado: String;

    class function New(AParams: TParamsBaixaEntFut): TBaixaEntFut;
  end;

implementation

uses
  untFuncoesSimples, untTFatEntregaFutura;

{ TBaixaEntFut }

constructor TBaixaEntFut.Create(AParams: TParamsBaixaEntFut);
begin
  FParams := AParams;
end;

class function TBaixaEntFut.New(AParams: TParamsBaixaEntFut): TBaixaEntFut;
begin
  Result := Self.Create(AParams);
end;

function TBaixaEntFut.fGetCampoCodBar: String;
begin
  Result := '';
  If fCfgSis('EXPTIN',varString) = '1' Then
    Result := Result + ' IF(D.DET_CODACA IS NOT NULL AND D.DET_CODACA <> "", ACA_CODBAR, CADITE.ITE_CODBAR) AS CODBAR, '
  Else
  Begin
    Result := Result + ' CADITE.ITE_CODBAR AS CODBAR, ';
    Result := Result + ' ACA_CODBAR AS CODBAT,        ';
  End;
end;

function TBaixaEntFut.fGetCampoQtdAnterior: String;
begin
  If FParams.FImpressaoSeparacao Then
    Result := ' IFNULL(SEP_QTDITE, 0.0000) AS DET_QTDANT, '
  Else If FParams.FMarcaTodos Then
    Result := ' IFNULL(D.DET_QTDITE, 0.0000) AS DET_QTDANT, '
  Else
    Result := ' 0.0000 AS DET_QTDANT, ';
end;

function TBaixaEntFut.fGetCampoQtdEntregar: String;
  Var
    LQtdAen: String;
begin
  Result := '';
  If FParams.FImpressaoSeparacao Then
  Begin
    Result := Result + ' IF(IFNULL(SEP_QTDITE, 0) > 0, "S", "N") AS SEPIMP, ';
    Result := Result + ' 0.0000 AS DET_QTDAEN, ';
  End
  Else If FParams.FModoConsulta Then
    Result := Result + ' (D.DET_QTDITE - ' + fGetSqlQtdEntregueEntFut + ') AS DET_QTDAEN, '
  Else
  Begin
    If FParams.FMarcaTodos Then
    Begin
      LQtdAen := 'ROUND(D.DET_QTDITE - ' + fGetSqlQtdEntregueEntFut + ', 4)';

      If fUsaLiberacaoPreviaPeloCaixa Then
        LQtdAen := 'IF(G.GER_DTLBRC IS NULL, 0.000, ' + LQtdAen + ')';

      Result := Result + LQtdAen + ' AS DET_QTDAEN, ';
    End
    Else
      Result := Result + ' 0.0000 AS DET_QTDAEN, ';
  End;
end;

function TBaixaEntFut.fGetCampoQtdFut: String;
begin
  If fUsaPedidoBaixaEntregaFutura Then
    Result := ' IFNULL(QTDFUT,0) AS QTDFUT, '
  Else
    Result := ' 0.00 AS QTDFUT, ';
end;

function TBaixaEntFut.fGetCampoQtdPendente: String;
begin
  If FParams.FImpressaoSeparacao Then
    Result := ' IF((D.DET_QTDITE - '+ fGetSqlQtdEntregueEntFut + ') - IFNULL(SEP_QTDIMP, 0.0000) > 0, '+
              '    (D.DET_QTDITE - '+ fGetSqlQtdEntregueEntFut + ') - IFNULL(SEP_QTDIMP, 0.0000), '+
              '    0.0000) AS PENSEP, '
  Else
    Result := ' 0.0000 AS PENSEP, ';
end;

function TBaixaEntFut.fGetCampoSaldos: String;
begin
  Result := '';
  If fCfgSis('BEFTRG', varBoolean) Then
  Begin
    Result := Result + ' (I.ITE_SALDOS) AS ITE_SALDOS, ';
    Result := Result + ' (I.ITE_SALDOS) AS ITE_SALDIS, ';
  End
  Else
  Begin
    Result := Result + ' (I.ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('I') + ') AS ITE_SALDOS, ';
    Result := Result + ' (I.ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('I') + ') AS ITE_SALDIS, ';
  End;
end;

function TBaixaEntFut.fGetFiltroAguardandoCliente: String;
begin
  Result := '';
  If Not FParams.FAguardandoCliente Then
    Result := ' AND DET_MOTFUT <> "A" ';
end;

function TBaixaEntFut.fGetFiltroPrevisaoEntrega: String;
begin
  Result := '';
  If Not FParams.FPrevisaoEntrega Then
    Result := ' AND DET_MOTFUT <> "P" ';
end;

function TBaixaEntFut.fGetFiltroRegiao: String;
begin
  Result := '';
  If Not fEmptyStr(FParams.FCodigoRegiao) Then
    Result := ' AND CR.REG_CODREG = ' + QuotedStr(FParams.FCodigoRegiao) +' ';
end;

function TBaixaEntFut.fGetFiltroFaltaProduto: String;
begin
  Result := '';
  If Not FParams.FFaltaProduto Then
    Result := ' AND DET_MOTFUT <> "F" ';
end;

function TBaixaEntFut.fGetFiltroAutoincMovs: String;
begin
  Result := '';
  If Not fEmptyStr(FParams.FAutoincMovs) Then
    Result := ' AND D.AUTOINCREM IN ('+ FParams.FAutoincMovs +') ';
end;

function TBaixaEntFut.fGetFiltroBFUT49: String;
  Var
    LDFut49: TDate;
begin
  Result := '';
  If Not fCfgSis('BFUT49', varBoolean) Then
    Exit;

  LDFut49 := StrToDateDef(fCfgSis('DFUT49'), 0);

  If (LDFut49 = 0) Then
    Exit;

  If FParams.FBaixaCST49 Then
    Result := ' AND D.DET_DTAENT < '+ QuotedStr(FormatDateTime('yyyy-MM-dd', LDFut49)) +' '
  Else
    Result := ' AND D.DET_DTAENT >= '+ QuotedStr(FormatDateTime('yyyy-MM-dd', LDFut49)) +' ';
end;

function TBaixaEntFut.fGetFiltroCidade: String;
begin
  Result := '';
  If Not fEmptyStr(FParams.FCodigoCidade) Then
    Result := ' AND CLI_CODCID = :CODCID ';
end;

function TBaixaEntFut.fGetFiltroCliente: String;
begin
  Result := '';
  If Not fEmptyStr(FParams.FCodigoCliente) Then
    Result := ' AND GER_CODCLI = ' + QuotedStr(FParams.FCodigoCliente) +' ';
end;

function TBaixaEntFut.fGetFiltroClienteVaiRetirar: String;
begin
  Case FParams.FClienteVaiRetirar Of
    crNAO: Result := ' AND IFNULL(T.DET_CLIBUS, "N") = "N" ';
    crSIM: Result := ' AND IFNULL(T.DET_CLIBUS, "N") = "S" ';
  Else
    Result := '';
  End;
end;

function TBaixaEntFut.fGetFiltroLinhaGrupo: String;
begin
  Result := '';
  If fEmptyStr(fTiraCaracEspeciais(FParams.FLinhaGrupo)) Then
    Exit;

  If RightStr(FParams.FLinhaGrupo, 3) = '000' Then
    Result := ' AND LEFT(ITE_CODGRU, 3) = LEFT(:CODGRU, 3) '
  Else
    Result := ' AND ITE_CODGRU = :CODGRU ';
end;

function TBaixaEntFut.fGetFiltroPeriodo: String;
begin
  Result := '';
  If FParams.FDataInicial = 0 Then
    Exit;

  If FParams.FDataFinal = 0 Then
    Exit;

  Result := ' AND D.DET_DTAFUT BETWEEN :DTAINI AND :DTAFIN ';
end;

function TBaixaEntFut.fGetFiltroSeparacaoImpressa: String;
begin
  Result := '';
  If FParams.FSeparacaoImpressa Then
    Result := ' AND SEP_CODSEP IS NOT NULL ';
end;

function TBaixaEntFut.fGetSql: String;
begin
  Result := '';
  Result := Result + ' SELECT                               ';
  Result := Result + '   IFNULL(AUX_ENTGER, "") AS ENTGER,  ';
  Result := Result + '   "MOVDET" AS TABELA,                ';
  Result := Result + '   IFNULL(SEP_QTDIMP, 0.0000) AS SEP_QTDIMP, ';

  Result := Result + fGetCampoQtdAnterior;

  Result := Result + fGetCampoQtdPendente;

  Result := Result + '  (SELECT GROUP_CONCAT(CONCAT("-", BAR_CODBAR, "-")) FROM ';
  Result := Result + '   ITEBAR WHERE CADITE.ITE_CODITE = BAR_CODITE) AS BAREMB,';

  Result := Result + fGetCampoCodBar;

  Result := Result + '   CADITE.ITE_EMBALA AS EMBALA, ';

  Result := Result + '   D.DET_CODITE AS CODITE,';
  Result := Result + '   ITE_CODFAB,';

  Result := Result + '   IF(D.DET_IDEPRO <> "NOR", CONCAT(D.DET_CODITE, ACA_CODACA, ACA_CODEMP), "") AS CODTIN, ';

  Result := Result + '   D.DET_IDEPRO AS IDEPRO, ';

  Result := Result + fGetCampoSaldos;

  Result := Result + '   GER_DTAENT,         ';
  Result := Result + '   D.DET_DTAFUT,       ';
  Result := Result + '   D.DET_DTAFUT AS DTAFUT, ';
  Result := Result + '   GER_NUMDOC,         ';
  Result := Result + '   GER_ESPDOC,         ';
  Result := Result + '   GER_CODEMP,         ';
  Result := Result + '   GER_CODCLI,         ';
  Result := Result + '   GER_SERIE_,         ';
  Result := Result + '   GER_CONENT,         ';
  Result := Result + '   GER_MEN001,         ';
  Result := Result + '   GER_MEN002,         ';
  Result := Result + '   GER_VLRCON,         ';
  Result := Result + '   GER_ENTFAT,         ';
  Result := Result + '   AUX_ABADEP,         ';

  {*******************************}
  {* INICIO DADOS DO CONSUMIDOR  *}
  {****************************JC*}
  Result := Result + '   GER_NOMCON, ';
  Result := Result + '   GER_ENDCON, ';
  Result := Result + '   GER_BAICON, ';
  Result := Result + '   GER_CEPCON, ';
  Result := Result + '   GER_CIDCON, ';
  Result := Result + '   GER_ESTCON, ';
  Result := Result + '   GER_TELCON, ';
  Result := Result + '   AUX_NASCON, ';
  Result := Result + '   GER_CGCCPF, ';
  Result := Result + '   GER_CGCCON, ';
  Result := Result + '   GER_IESCON, ';
  Result := Result + '   GER_R_GCON, ';
  Result := Result + '   GER_EMLCON, ';
  {****************************}
  {* FIM DADOS DO CONSUMIDOR  *}
  {*************************JC*}

  {**********************}
  {* MENSAGEM EXPEDIÇÃO *}
  {********************FC}
  Result := Result + '   GER_MENEXP, ';
  Result := Result + '   GER_MENEX2, ';
  Result := Result + '   GER_MENEX3, ';
  Result := Result + '   GER_MENEX4, ';

  Result := Result + '   CADITE.ITE_CODGRU,  ';
  Result := Result + '   CADITE.ITE_DIAFOR,  ';
  Result := Result + '   D.DET_SEQGER,       ';
  Result := Result + '   G.GER_DTLBRC,       ';
  Result := Result + '   G.GER_OPRFLJ,       ';

  Result := Result + '   D.AUTOINCREM AS DET_INCREM,   ';

  Result := Result + fListarCamposTabela('MOVDET', 'D.', ['DET_DESACE']) + ', ';

  Result := Result + '   DET_UNIVIS,         ';
  Result := Result + '   DET_TAXJUR,         ';
  Result := Result + '   DET_VAL_RT,         ';

  If fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
  Begin
    Result := Result + '   DET_APAREL,         ';
    Result := Result + '   DET_PERAPA,         ';
    Result := Result + '   DET_BENEFI,         ';
    Result := Result + '   DET_PERBEN,         ';

    Result := Result + '   DET_QTDPEC,         ';
    Result := Result + '   DET_COMPEC,         ';
    Result := Result + '   DET_LARPEC,         ';
    Result := Result + '   DET_ESPPEC,         ';
  End;

  Result := Result + ' ' + fGetSqlQtdEntregueEntFut + ' AS QTDENT, ';
  Result := Result + ' (D.DET_QTDITE - ' + fGetSqlQtdEntregueEntFut + ') AS DET_QTDPEN, ';

  Result := Result + '   "                    " AS DET_NOVLOT, ';
  Result := Result + '  SEP_CODSEP AS CODSEP, ';

  Result := Result + fGetCampoQtdEntregar;

  Result := Result + '   IF(IFNULL(DET_NUMLOT, "") = "", ITE_LOCFIS, LOT_LOCFIS) AS ITE_LOCFIS, ';
  Result := Result + '   MAR_DESMAR, ';
  Result := Result + '   FOR_TIPCOR, ';
  Result := Result + '   FOR_TEXBAS, ';
  Result := Result + '   FOR_MODDIL, ';
  Result := Result + '   FOR_ITECOB, ';
  Result := Result + '   DET_EMPPRD, ';
  Result := Result + '   DET_TOTMED / D.DET_QTDITE AS DET_PREMED, ';
  Result := Result + '   DET_TOTULT / D.DET_QTDITE AS DET_PREULT, ';
  Result := Result + '   DET_IMPULT / D.DET_QTDITE AS DET_IMPULT, ';

  Result := Result + '   (DET_OUTVAL/D.DET_QTDITE)                    AS DET_OUTVAL, ';
  Result := Result + '   (DET_ICMSAI/(DET_TOTITE - DET_DESESP) * 100) AS DET_ICMSAI, ';
  Result := Result + '   (DET_IMPFED/(DET_TOTITE - DET_DESESP) * 100) AS DET_IMPFED, ';
  Result := Result + '   (DET_DESOPE/(DET_TOTITE - DET_DESESP) * 100) AS DET_DESOPE, ';

  Result := Result + '   IFNULL(T.DET_CLIBUS,"N") AS DET_CLIBUS, ';

  Result := Result + '   DET_CODVE2, ';
  Result := Result + '   DET_PERCOM, ';
  Result := Result + '   IFNULL(DET_FRERAT, 0) AS DET_FRERAT, ';
  Result := Result + '   IFNULL(DET_FRESUG, 0) AS DET_FRESUG, ';

  Result := Result + '   AUX_VENPRE, ';
  Result := Result + '   UNI_SIGUNI, ';
  Result := Result + '   D.DET_CODACA, ';

  Result := Result + fGetCampoQtdFut;

  Result := Result + ' CAST(IFNULL((SELECT CONCAT(IFNULL(EXTGOR.FGO_EMP_CD,""),"-",IFNULL(FATGOR.FGO_ENT_CD,"")) ';
  Result := Result + '                FROM FATGOR INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM     ';
  Result := Result + '                            INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM     ';
  Result := Result + '               WHERE FATDOR.AUTOINCREM = MOVAUX.DET_INC_PD LIMIT 1), "") AS CHAR(5)) AS EMP_CD_ENT_CD, ';

  Result := Result + '   T.DET_EMPORI, ';

  Result := Result + '   D.DET_EMPACA, ';
  Result := Result + '   T.DET_INCFUT, ';
  Result := Result + '   T.DET_BXSBIT, ';
  Result := Result + '   T.DET_ITEABF, ';
  Result := Result + '   T.DET_TURENT, ';
  Result := Result + '   "" AS LOTANT, ';
  Result := Result + '   0.0000 AS QTDDEV, ';
  Result := Result + '   0.0000 AS QTDJDV, ';

  If fCfgSis('UTIDEF', varBoolean) Then
    Result := Result + ' IFNULL(T.DET_COMPLE, "(Sem ambiente definido)") DET_COMPLE, '
  Else
    Result := Result + ' T.DET_COMPLE, ';

  Result := Result + '   G.GER_CODVEN, ';
  Result := Result + '   CONCAT(G.GER_CODVEN, "-", O.OPE_NOMOPE) AS VENDEDOR, ';
  Result := Result + '   D.DET_UNITAR, ';
  Result := Result + '   G.GER_TIPFRE, ';
  Result := Result + '   IFNULL(A.AUX_ENFUOP, "1") AS AUX_ENFUOP, ';
  Result := Result + '   IF(AUX_ENFUOP = "2", (DET_DESACE - IFNULL(DET_VIPIBF,0) - IFNULL(DET_VRETBF,0) - IFNULL(DET_VFSTBF,0)), DET_DESACE) AS DET_DESACE, ';
  Result := Result + '   DET_EMPCAR, ';
  Result := Result + '   AUX_CODFAZ, ';
  Result := Result + '   FIS_ACESSO, ';
  Result := Result + '   T.DET_LOCFIS, ';
  Result := Result + '   IF(DET_NUM_PD IS NULL, "", CONCAT(DET_NUM_PD, "-", DET_ESP_PD, "-", DET_EMP_PD)) AS PEDVEN  ';

  Result := Result + fGetSqlFromWhere;
end;

function TBaixaEntFut.fGetSqlSimplificado: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   D.DET_DTAFUT, ';
  Result := Result + '   D.DET_CODCLI, ';
  Result := Result + '   CONCAT(CLI_CODCLI, " - ", CLI_NOMCLI) AS CLI_NOMCLI, ';
  Result := Result + '   CONCAT(CID_CODCID, " - ", CID_NOMCID) AS CID_NOMCID, ';
  Result := Result + '   COUNT(DISTINCT D.DET_CODITE) AS QTD_ITENS, ';
  Result := Result + '   GROUP_CONCAT(QUOTE(D.AUTOINCREM)) AS AUTOINCREM, ';
  Result := Result + '   SUM(D.DET_QTDITE) AS TOTITEDOC, ';
  Result := Result + '   SUM(IF(IFNULL(SEP_QTDITE, 0.0000) > 0, IFNULL(SEP_QTDITE, 0.0000), IFNULL(SEP_QTDIMP, 0.0000))) AS SEP_QTDITE, ';
  Result := Result + '   CR.REG_CODREG, ';
  Result := Result + '   CR.REG_DESREG, ';
  Result := Result + '   EC.ETC_CIDENT, ';
  Result := Result + '   EC.ETC_ENDENT, ';
  Result := Result + '   EC.ETC_BAIENT ';

  Result := Result + fGetSqlFromWhere;
end;

function TBaixaEntFut.fGetSqlFromWhere: String;
begin
  Result := Result + ' FROM MOVDET D ';
  Result := Result + ' INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + ' INNER JOIN CADOPE O ON O.OPE_CODOPE = G.GER_CODVEN ';
  Result := Result + '  LEFT JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM ';
  Result := Result + '  LEFT JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ';
  Result := Result + '  LEFT JOIN MOVAUX ON MOVAUX.DET_SEQGER = D.AUTOINCREM ';
  Result := Result + '  LEFT JOIN CADFIS ON CADFIS.FIS_NUMDOC = D.DET_NUMDOC AND ';
  Result := Result + '                      CADFIS.FIS_ESPDOC = D.DET_ESPDOC AND ';
  Result := Result + '                      CADFIS.FIS_SERIE_ = D.DET_SERIE_ AND ';
  Result := Result + '                      CADFIS.FIS_CODEMP = D.DET_CODEMP AND ';
  Result := Result + '                      CADFIS.FIS_FORCLI = D.DET_CODCLI AND ';
  Result := Result + '                      CADFIS.FIS_TIP_FC = D.DET_TIP_FC ';
  Result := Result + ' INNER JOIN CADITE ON CADITE.ITE_CODITE = D.DET_CODITE ';

  Result := Result + ' INNER JOIN ITEGER I ON ';
  Result := Result + '    I.ITE_CODITE = D.DET_CODITE AND ';
  Result := Result + '    I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  If fUtilizaVendaMadeiraOuVidroOuMetroLinear Then
    Result := Result + ' LEFT JOIN MOVMAD M ON M.DET_SEQGER = D.AUTOINCREM  ';

  Result := Result + ' LEFT JOIN CADACA ON ACA_CODACA = D.DET_CODACA AND ';
  Result := Result + '                     ACA_CODEMP = D.DET_EMPACA     ';

  Result := Result + ' LEFT JOIN SEPFUT S ON S.SEP_SEQGER = D.AUTOINCREM  ';

  Result := Result + ' LEFT JOIN CADCLI ON CLI_CODCLI = D.DET_CODCLI ';
  Result := Result + ' LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  Result := Result + ' LEFT JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR ';
  Result := Result + ' LEFT JOIN CADUNI ON D.DET_UNIDAD = UNI_CODUNI ';
  Result := Result + ' LEFT JOIN CADLOT ON LOT_NUMLOT = D.DET_NUMLOT AND LOT_CODITE = D.DET_CODITE AND LOT_CODEMP = D.DET_CODEMP ';
  Result := Result + ' LEFT JOIN FORTIN FT ON D.DET_CODACA = FT.FOR_CODACA AND D.DET_EMPACA = FT.FOR_EMPACA ';
  Result := Result + ' LEFT JOIN TINDET TD ON D.DET_NUMDOC = TD.DET_NUMDOC AND D.DET_CODEMP = TD.DET_CODEMP AND ' +
                                            ' D.DET_ESPDOC = TD.DET_ESPDOC AND D.DET_CODACA = TD.DET_CODACA AND ' +
                                            ' D.DET_EMPACA = TD.DET_EMPACA ';
  Result := Result + ' LEFT JOIN ENTCLI EC ON EC.AUTOINCREM = A.AUX_ENTGER ';
  Result := Result + ' LEFT JOIN CADREG CR ON CR.REG_CODREG = EC.ETC_CODREG ';

  If fUsaPedidoBaixaEntregaFutura Then
    Result := Result + ' ' + TSqlEF.SQLJoinEFPedido('D', True {Está na baixa de entrega Futura}) + ' ';

  Result := Result + ' WHERE D.DET_ESPDOC NOT IN ("ML", "PR", "TM", "TR", "BR", "PI", "EP") ';

  Result := Result + fGetFiltroCliente;

  Result := Result + ' AND ' + fSQLFiltroMinimo;

  If (fCfgSis('EFTEST') = '2') Then
  Begin
    Result := Result + ' AND (D.DET_PROEMB <> "S" OR T.DET_BXSBIT = "S") '; //Para exibir os sub-itens (proemb = 'S' e bxsbit = 'S')
    Result := Result + ' AND ((D.DET_FILKAR = 0) OR (D.DET_CODACA IS NOT NULL)) '; //Para não exibir o item principal (que vai estar com filkar = 1)
  End
  Else
    Result := Result + ' AND D.DET_PROEMB <> "S" ';

  Result := Result + ' AND ROUND(D.DET_QTDITE - ' + fGetSqlQtdEntregueEntFut + ',4) > 0 ';

  {************************************************************************}
  {* ESTE FILTRO É OBRIGATÓRIO, POIS O USUÁRIO NÃO PODE EFETUAR UMA BAIXA *}
  {* DE ENTREGA FUTURA COM ITENS CLIBUS = "S" E "N" NO MESMO DOCUMENTO.   *}
  {* PORTANTO, NÃO SE DEVE COLOCAR UMA OPÇÃO "TODOS" NO cmbCliBus         *}
  {*********************************************************************MM*}
  Result := Result + fGetFiltroClienteVaiRetirar;

  Result := Result + fGetFiltroSeparacaoImpressa;

  Result := Result + fGetFiltroFaltaProduto;

  Result := Result + fGetFiltroAguardandoCliente;

  Result := Result + fGetFiltroPrevisaoEntrega;

  Result := Result + fGetFiltroPeriodo;

  Result := Result + fGetFiltroLinhaGrupo;

  Result := Result + fGetFiltroCidade;

  Result := Result + fGetFiltroBFUT49;

  Result := Result + fGetFiltroAutoincMovs;

  Result := Result + fGetFiltroRegiao;

end;

function TBaixaEntFut.fSQLFiltroMinimo: String;
begin
  Result := ' GER_ENTFUT = "S" ';

  If (fCfgSis('CONENT', varBoolean)) And (fCfgSis('COENFI', varBoolean)) Then
  Begin
    If ((fCfgSis('EMPGER', varBoolean))) Then
      Result := Result + ' AND ((GER_CONENT = "S") OR (GER_CODEMP = ' + QuotedStr(fCfgSis('EMPMAT')) +')) '
    Else
    Begin
      Result := Result + ' AND GER_CONENT = "N" ';

      If fPermiteEmitirPedidoDeBaixaEntregaFuturaParaOutraLoja Then
        Result := Result + ' AND (D.DET_CODEMP = '+ QuotedStr(VS_strCodEmp) +' OR T.DET_EMPORI = '+ QuotedStr(VS_strCodEmp) +' OR ((A.AUX_ABADEP = "S") AND (A.AUX_EMPDEP = '+ QuotedStr(VS_strCodEmp) +')))'
      Else
        Result := Result + ' AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
    End;
  End
  Else
  Begin
    If (fPermiteEmitirPedidoDeBaixaEntregaFuturaParaOutraLoja) Or (fCfgSis('FATSSA', varBoolean)) Then
      Result := Result + ' AND (D.DET_CODEMP = '+ QuotedStr(VS_strCodEmp) +' OR T.DET_EMPORI = '+ QuotedStr(VS_strCodEmp) +' OR ((A.AUX_ABADEP = "S") AND (A.AUX_EMPDEP = '+ QuotedStr(VS_strCodEmp) +')))'
    Else
      Result := Result + ' AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
  End;

  If Not fEmptyStr(FParams.FNumeroDocumento) Then
    Result := Result + ' AND GER_NUMDOC = ' + QuotedStr(FParams.FNumeroDocumento);
  If Not fEmptyStr(FParams.FEspecieDocumento) Then
    Result := Result + ' AND GER_ESPDOC = ' + QuotedStr(FParams.FEspecieDocumento);
end;

{ TParamsBaixaEntFut }

constructor TParamsBaixaEntFut.Create;
begin
  FFaltaProduto       := False;
  FPrevisaoEntrega    := False;
  FAguardandoCliente  := False;
  FClienteVaiRetirar  := crTODOS;
  FDataInicial        := 0;
  FDataFinal          := 0;
  FNumeroDocumento    := '';
  FEspecieDocumento   := '';
  FSeparacaoImpressa  := False;
  FLinhaGrupo         := '';
  FCodigoCliente      := '';
  FCodigoCidade       := '';
  FMarcaTodos         := False;
  FImpressaoSeparacao := False;
  FBaixaCST49         := False;
  FModoConsulta       := False;
  FAutoincMovs        := '';
  FCodigoRegiao       := EmptyStr;
end;

class function TParamsBaixaEntFut.New: TParamsBaixaEntFut;
begin
  Result := Self.Create;
end;

function TParamsBaixaEntFut.AguardandoCliente(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FAguardandoCliente := AValue;
end;

function TParamsBaixaEntFut.AutoincMovs(const AValue: String): TParamsBaixaEntFut;
begin
  Result := Self;
  FAutoincMovs := AValue;
end;

function TParamsBaixaEntFut.BaixaCST49(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FBaixaCST49 := AValue;
end;

function TParamsBaixaEntFut.ClienteVaiRetirar(Const Avalue: TClienteRetira): TParamsBaixaEntFut;
begin
  Result := Self;
  FClienteVaiRetirar := AValue;
end;

function TParamsBaixaEntFut.CodigoCidade(Const AValue: String): TParamsBaixaEntFut;
begin
  Result := Self;
  FCodigoCidade := AValue;
end;

function TParamsBaixaEntFut.CodigoCliente(Const AValue: String): TParamsBaixaEntFut;
begin
  Result := Self;
  FCodigoCliente := AValue;
end;

function TParamsBaixaEntFut.CodigoRegiao(
  const AValue: String): TParamsBaixaEntFut;
begin
  Result := Self;
  FCodigoRegiao := AValue;
end;

function TParamsBaixaEntFut.DataFinal(Const AValue: TDate): TParamsBaixaEntFut;
begin
  Result := Self;
  FDataFinal := AValue;
end;

function TParamsBaixaEntFut.DataInicial(Const AValue: TDate): TParamsBaixaEntFut;
begin
  Result := Self;
  FDataInicial := AValue;
end;

function TParamsBaixaEntFut.EspecieDocumento(Const AValue: String): TParamsBaixaEntFut;
begin
  Result := Self;
  FEspecieDocumento := AValue;
end;

function TParamsBaixaEntFut.FaltaProduto(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FFaltaProduto := AValue;
end;

function TParamsBaixaEntFut.ImpressaoSeparacao(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FImpressaoSeparacao := AValue;
end;

function TParamsBaixaEntFut.LinhaGrupo(Const AValue: String): TParamsBaixaEntFut;
begin
  Result := Self;
  FLinhaGrupo := AValue;
end;

function TParamsBaixaEntFut.MarcaTodos(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FMarcaTodos := AValue;
end;

function TParamsBaixaEntFut.ModoConsulta(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FModoConsulta := AValue;
end;

function TParamsBaixaEntFut.NumeroDocumento(Const Avalue: String): TParamsBaixaEntFut;
begin
  Result := Self;
  FNumeroDocumento := AValue;
end;

function TParamsBaixaEntFut.PrevisaoEntrega(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FPrevisaoEntrega := AValue;
end;

function TParamsBaixaEntFut.SeparacaoImpressa(Const AValue: Boolean): TParamsBaixaEntFut;
begin
  Result := Self;
  FSeparacaoImpressa := AValue;
end;

end.
