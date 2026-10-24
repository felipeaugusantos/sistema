unit Promocao.CatalogoPromocao;

interface

uses
  SysUtils, Uni;

Type

  TCatalogoPromocao = Class
  private
    FTabelaTemp: String;
    FstrNumOrc: String;
    FstrEspOrc: String;
    FstrCodCli: String;
    FstrTabPre: String;
    FintPraMedio: Integer;
    FstrCndPag: String;
    FstrCodCnd: String;

    procedure pCriaTabelaTemp;
    procedure pExcluiTabelaTemp;

    function fRetornaNomeTabelaTemp: String;
    function fRetSubQryComRegrasPromocao: String;
    function fRetSQLQtdReservadaPedido: String;
    function fRetSubQryCodCliEmPromoPorQtdLim(strCodIte, strCodEmp: String): String;
    function fRetPraMedio: Integer;
    function fGetSQLCondicaoPromocaoPorDesconto: String;
    function fRetSQLPorcentoDescontoComDescontoAdicionalItem(strSQLPreco, strTabPre: String): String;
  public
     constructor Create;
     destructor Destroy;  override;

     procedure pCarregaDadosTabelaTmp(const strTabPre, strTabPreProm: String; strCodCli: String = '';
       dtaVig: TDateTime = 0; strCndPag: String = ''; strNumOrc: String = ''; strEspOrc: String = '');

     function fRetSQLPrecoVendaPromoItem(strTabPre: String =''): String;

     property strNomTabTemp: String read FTabelaTemp;
  End;

implementation

uses
  untFuncoesSimples, untCadPro, untConstantes;

{ TCatalogoPromocao }

constructor TCatalogoPromocao.Create;
begin
  inherited;

  FintPraMedio := fRetPraMedio;
  FstrCodCnd := '';

  FTabelaTemp := fRetornaNomeTabelaTemp;


end;

destructor TCatalogoPromocao.Destroy;
begin
  pExcluiTabelaTemp;

  inherited;
end;

function TCatalogoPromocao.fRetornaNomeTabelaTemp: String;
var
  strSeqTab: String;
begin
  strSeqTab := fRetSequencial('TMPPRM', VS_strCodEmp, 12);
  Result := 'TMP_PRM'+ strSeqTab;
end;

function TCatalogoPromocao.fRetPraMedio: Integer;
var
  intPraMedio: Integer;
begin
  Result := 0;

  If FstrCndPag <> '' Then
    intPraMedio := fFloatToInt(fCalcMediaPagto(FstrCndPag))
  Else
    intPraMedio := 0;

  If untFuncoesSimples.fCfgSis('PRZPRO', varBoolean) Then
    Result := intPraMedio;
end;

function TCatalogoPromocao.fRetSubQryCodCliEmPromoPorQtdLim(strCodIte, strCodEmp: String): String;
begin
  Result := '';
  Result := Result + '  SELECT C.PRO_CODCLI ';
  Result := Result + '  FROM CADPRO P INNER JOIN PROCLI C ON C.PRO_SEQGER = P.AUTOINCREM  ';
  Result := Result + '                INNER JOIN ITEPRO I ON I.IPR_SEQGER = P.AUTOINCREM  ';
  Result := Result + '                INNER JOIN PROEMP E ON E.PRO_SEQGER = P.AUTOINCREM  ';
  Result := Result + '  WHERE ';
  Result := Result + '   '  + fCurrentDate + ' BETWEEN P.PRO_DTAINI AND P.PRO_DTAFIN ';
  Result := Result + fGetFiltroTabelaPrecoPromocao(FstrTabPre, 'P.');
  Result := Result + fGetFiltroPromocaoRestritaClientesNaoConsumidor(FstrCodCli, 'P.');
  Result := Result + '  AND E.PRO_CODEMP = ' + IIF(Pos('.',strCodEmp) > 0, strCodEmp, QuotedStr(strCodEmp));
  Result := Result + '  AND I.IPR_CODITE = ' + IIF(Pos('.',strCodIte) > 0, strCodIte, QuotedStr(strCodIte));
  Result := Result + '  AND (IFNULL(I.IPR_QTDLIM, 0) > 0) ';
end;

function TCatalogoPromocao.fRetSQLQtdReservadaPedido: String;
begin
  Result := '';
  If (Not fEmptyStr(FstrNumOrc)) And (Not fEmptyStr(FstrEspOrc)) And (FstrEspOrc = 'PD') Then
  Begin
    Result := Result + ' + (SELECT IFNULL(SUM(FDO_QTDITE), 0)            ';
    Result := Result + '      FROM FATDOR                                ';
    Result := Result + '        INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
    Result := Result + '     WHERE FDO_NUMDOC = ' + QuotedStr(FstrNumOrc);
    Result := Result + '       AND FDO_ESPDOC = ' + QuotedStr(FstrEspOrc);
    Result := Result + '       AND FDO_CODEMP = PROEMP.PRO_CODEMP        ';
    Result := Result + '       AND FDO_CODITE = ITEPRO.IPR_CODITE        ';

    If fCfgSis('TABLOI', VarBoolean) Then
      Result := Result + '     AND FDO_CODPRO = PRO_CODPRO               ';

    Result := Result + '       AND FDO_PROMOC = "S"                      )';
  End;
end;

function TCatalogoPromocao.fRetSubQryComRegrasPromocao: String;
Begin
  Result := '';

  If fEmptyStr(FstrCodCli) Then
  Begin
    Result := Result + ' (PROCLI.PRO_SEQGER IS NULL) AND ';
    Result := Result + ' (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE))) AND ';
  End
  Else
  Begin
    Result := Result + ' (((PROCLI.PRO_CODCLI = '+ QuotedStr(Self.FstrCodCli)+') AND (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE)))) ';
    Result := Result + '  OR (((PROCLI.PRO_SEQGER IS NULL) AND ';
    Result := Result + '      ((IPR_QTDLIM <= 0) OR ((IPR_QTDLIM > 0) AND '+QuotedStr(Self.FstrCodCli)+ ' NOT IN ('+Self.fRetSubQryCodCliEmPromoPorQtdLim('ITEPRO.IPR_CODITE', 'PROEMP.PRO_CODEMP')+'))) AND ';
    Result := Result + '      (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE)))) ';
    Result := Result + '     ) ';
    Result := Result + ' ) AND ';
  End;
end;

procedure TCatalogoPromocao.pCarregaDadosTabelaTmp(const strTabPre, strTabPreProm: String; strCodCli: String = '';
  dtaVig: TDateTime = 0; strCndPag: String = ''; strNumOrc: String = ''; strEspOrc: String = '');
var
  strSQL: String;
  strPraMedioLoc: String;
begin
  Try
    FstrNumOrc := strNumOrc;
    FstrEspOrc := strEspOrc;
    FstrCodCli := strCodCli;
    FstrTabPre := strTabPre;
    FstrCndPag := strCndPag;

    pExcluiTabelaTemp;
    pCriaTabelaTemp;

    strSQL := 'INSERT INTO ' + FTabelaTemp;
    strSQL := strSQL + ' SELECT  CADPRO.AUTOINCREM,';
    strSQL := strSQL + '         ITEPRO.AUTOINCREM,';
    strSQL := strSQL + '         CADPRO.PRO_CODPRO,';
    strSQL := strSQL + '         CADPRO.PRO_DTAINI,';
    strSQL := strSQL + '         CADPRO.PRO_DTAFIN,';
    strSQL := strSQL + '         ITEPRO.IPR_CODITE,';
    strSQL := strSQL + '         CADPRO.PRO_CODCLI,';
    strSQL := strSQL + '         PROEMP.PRO_CODEMP,';
    strSQL := strSQL + '         CADPRO.PRO_IDXPRO,';
    strSQL := strSQL + '         CADPRO.PRO_PREDES,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVEN,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE2,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE3,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE4,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE5,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE6,';
    strSQL := strSQL + '         ITEPRO.IPR_PREVE7,';
    strSQL := strSQL + '         CADPRO.PRO_TABPRE,';
    strSQL := strSQL + '         ITEPRO.IPR_PERDES ';
    strSQL := strSQL + '  FROM CADPRO INNER JOIN ITEPRO ON ITEPRO.IPR_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '              INNER JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '               LEFT JOIN PROCLI ON PROCLI.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '               LEFT JOIN IPREMP ON IPREMP.IPR_SEQGER = ITEPRO.AUTOINCREM ';
    strSQL := strSQL + '                               AND PROEMP.PRO_CODEMP = IPREMP.IPR_CODEMP ';
    strSQL := strSQL + '                               AND PROEMP.PRO_CODEMP = ' + QuotedStr(VS_strCodEmp);

    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '  PROEMP.PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) +  ' AND ';
    strSQL := strSQL + fRetSubQryComRegrasPromocao;
    strSQL := strSQL + '    ' + fCurrentDate(dtaVig) + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';
    strSQL := strSQL + fGetFiltroTabelaPrecoPromocao(strTabPre) + ' ';
    strSQL := strSQL + fGetFiltroPromocaoRestritaClientesNaoConsumidor(FstrCodCli) + ' ';
    strSQL := strSQL + fGetFiltroQuantidadeLimite() + ' ';

    If (FintPraMedio <> -999) Then
    Begin
      strPraMedioLoc := IIF(FintPraMedio <> -999, IntToStr(FintPraMedio), '');

      If Not fEmptyStr(strPraMedioLoc) Then
      Begin
        If ((fCfgSis('PRZPRO') = 'S') And (fCfgSis('USACND') = 'S')) Then
        Begin
          strSQL := strSQL + ' AND IF(' + ' (SELECT COUNT(CNDPRO.CPR_SEQGER) FROM CNDPRO WHERE CNDPRO.CPR_SEQGER = CADPRO.AUTOINCREM )'+
                                          ' = 0, ITEPRO.IPR_PRZMED >= '+strPraMedioLoc+', '+
                                          ' TRUE) ';
        End
        Else
        Begin
          strSQL := strSQL + ' AND ITEPRO.IPR_PRZMED >= ' + strPraMedioLoc;
        End;
      End;
    End;

    strSQL := strSQL + ' ORDER BY CADPRO.PRO_TABLOI DESC ';

    fExecutaSQL(strSQL);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCarregaDadosTabelaTmp]');
    End;
  End;

end;

function TCatalogoPromocao.fGetSQLCondicaoPromocaoPorDesconto: String;
begin
  Result := ' ((TMP_PREDES = "D" AND TMP_IDXPRO <> '+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional])+')'+
            '  OR (TMP_IDXPRO IN ('+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpDescon])+','+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoQuantidadeColetiva])+'))) '
end;

function TCatalogoPromocao.fRetSQLPrecoVendaPromoItem(strTabPre: String =''): String;
Begin
  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + ' ((1 - (TMP_PERDES / 100)) * ' + strTabPre +') ';
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 1, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE1) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 2, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE2) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 3, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE3) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 4, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE4) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 5, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE5) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 6, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE6) ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 7, 1) = "S" THEN ((1 - (TMP_PERDES / 100)) * ITE_PREVE7) ';
    Result := Result + '   ELSE ((1 - (TMP_PERDES / 100)) * ITE_PREVE1) ';
    Result := Result + ' END ';
  End;

  Result := ' IF('+fGetSQLCondicaoPromocaoPorDesconto+', ' + Result + ', TMP_PREVEN) ';

  Result := fRetSQLPorcentoDescontoComDescontoAdicionalItem(Result, strTabPre);
End;

function TCatalogoPromocao.fRetSQLPorcentoDescontoComDescontoAdicionalItem(strSQLPreco, strTabPre: String): String;
  Var
    strIdxPro : String;
begin
  strIdxPro := IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional]);

  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + IIF( Pos('1', strTabPre) > 0, 'TMP_PREVEN', strTabPre);
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 1, 1) = "S" THEN TMP_PREVEN';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 2, 1) = "S" THEN TMP_PREVE2';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 3, 1) = "S" THEN TMP_PREVE3';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 4, 1) = "S" THEN TMP_PREVE4';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 5, 1) = "S" THEN TMP_PREVE5';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 6, 1) = "S" THEN TMP_PREVE6';
    Result := Result + '   WHEN SUBSTRING(TMP_TABPRE, 7, 1) = "S" THEN TMP_PREVE7';
    Result := Result + '   ELSE TMP_PREVEN ';
    Result := Result + ' END ';
  End;

  Result := ' IF(TMP_IDXPRO = ' + strIdxPro + ', ' + Result + ', ' + strSQLPreco + ') ';
end;


procedure TCatalogoPromocao.pCriaTabelaTemp;
var
  strSQL: String;
begin

  Try
    strSQL := '';
    strSQL := strSQL + ' CREATE TABLE ' + FTabelaTemp + ' ( ';
    strSQL := strSQL + '   TMP_SEQPRO VARCHAR(20),          ';
    strSQL := strSQL + '   TMP_SEQITE VARCHAR(20),          ';
    strSQL := strSQL + '   TMP_CODPRO VARCHAR(08),          ';
    strSQL := strSQL + '   TMP_VALINI DATE,                 ';
    strSQL := strSQL + '   TMP_VALFIN DATE,                 ';
    strSQL := strSQL + '   TMP_CODITE VARCHAR(' + IntToStr(VS_intTamCadIte) + '),  ';
    strSQL := strSQL + '   TMP_CODCLI VARCHAR(08),          ';
    strSQL := strSQL + '   TMP_CODEMP CHAR(03),             ';
    strSQL := strSQL + '   TMP_IDXPRO INT(11),              ';
    strSQL := strSQL + '   TMP_PREDES CHAR(1),              ';
    strSQL := strSQL + '   TMP_PREVEN DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE2 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE3 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE4 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE5 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE6 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_PREVE7 DECIMAL(12,4),        ';
    strSQL := strSQL + '   TMP_TABPRE VARCHAR(7),           ';
    strSQL := strSQL + '   TMP_PERDES DECIMAL(12,4),        ';
    strSQL := strSQL + '   KEY IDX_' + FTabelaTemp + '_01 (TMP_CODEMP, TMP_CODPRO, TMP_CODITE, TMP_SEQPRO) ';
    strSQL := strSQL + ' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1 ';

    fExecutaSQL(strSQL);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaTabelaTemp]');
    End;
  End;

end;

procedure TCatalogoPromocao.pExcluiTabelaTemp;
begin
  If fTabelaExiste(FTabelaTemp) Then
    fDropTable(FTabelaTemp);
end;

end.
