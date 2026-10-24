unit Shared.Functions.SQL;

interface

uses Shared.Functions.Configuracoes;

Type
  TFunctionsSQL = Class
  Private


  Public
    Class function GetSQLUltimasNotas(ACodigoDoItem : String; AFornecedorFilial : String; ACodigoDaEmpresa : String = '') : String;

    Class function GetSQLDocumentos(AClassificacaoCompra, ACodigoFiscal : String) : String;

    Class function GetSQLDocumentosSemUltimaNota(const APrecoVenda : String) : String;
    Class function GetSQLDocumentosSemUltimaNotaDeTinta(const APrecoVenda : String) : String;

    Class function GetSelectConvertePrecos: String;

    Class function fGetSQLDocumentosOperacaoPropria(AstrClaCom, AstrCodFis : String) : String;
    Class function fGetSQLDocumentosOperacaoPropriaSemUltimaNota(AstrIdePro, AstrPrecoCompraLiquido: string): String;
  End;

implementation

uses SysUtils;

Class function TFunctionsSQL.GetSQLUltimasNotas(ACodigoDoItem : String; AFornecedorFilial : String; ACodigoDaEmpresa : String = '') : String;
Var
  strSQL : String;
begin
  strSQL := ' SELECT '+
            '    ITE_CODITE, '+
            '    ITE_CODEMP, '+
            '    ITE_DTAULT, '+
            '    ITE_NOTULT  '+
            '  FROM   '+
            '    ITEGER  '+
            '  WHERE ITE_CODITE IN ('+ ACodigoDoItem +') '+
            '    AND LOCATE("NF", ITE_NOTULT) > 0 '+
            '    AND ITE_DTAULT IS NOT NULL ';

  If Not AFornecedorFilial.IsEmpty Then
    strSQL := strSQL + '  AND (ITE_FORULT NOT IN (' + AFornecedorFilial + ')) ';

  If Not ACodigoDaEmpresa.IsEmpty then
    strSQL := strSQL + ' AND ITE_CODEMP = '+QuotedStr(ACodigoDaEmpresa)+' ';

  strSQL := strSQL + ' ORDER BY ITE_CODITE, ITE_DTAULT DESC, ITE_NOTULT DESC ';

  Result := strSQL;
end;

class function TFunctionsSQL.fGetSQLDocumentosOperacaoPropria(AstrClaCom, AstrCodFis: String): String;
begin
  Result := ' SELECT DE.N15_VBC/DET_QTDITE AS BASE, ' +
            '        DE.N16_PICMS AS ALIQUOTA, ' +
            '        DE.N17_VICMS/DET_QTDITE AS VALOR '+
            ' FROM MOVDET DT ' +
            '   LEFT JOIN GERELE GE ON GE.GER_DOCENT = DT.DET_NUMDOC ' +
            '                      AND GE.GER_ESPENT = DT.DET_ESPDOC ' +
            '                      AND GE.GER_EMPENT = DT.DET_CODEMP ' +
            '                      AND GE.GER_CODFOR = DT.DET_CODFOR ' +
            '                      AND IFNULL(GE.B07_SERIE, "") = IFNULL(DT.DET_SERIE_, "") ' +
            '   LEFT JOIN CADITE CI ON DT.DET_CODITE = CI.ITE_CODITE ' +
            '   LEFT JOIN ITEGER IT ON DT.DET_CODITE = IT.ITE_CODITE ' +
            '                      AND DT.DET_CODEMP = IT.ITE_CODEMP ' +
            '   LEFT JOIN CADFOR FO ON FO.FOR_CODFOR = CI.ITE_CODFOR ' +
            '   LEFT JOIN CADCID CC ON FO.FOR_CODCID = CC.CID_CODCID ' +
            '   LEFT JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM ' +
            '                      AND DE.DET_CODITE = DT.DET_CODITE ' +
            ' WHERE DT.DET_PROEMB <> "S"    '+
            '   AND DT.DET_NUMDOC = :NUMDOC '+
            '   AND DT.DET_ESPDOC = :ESPDOC '+
            '   AND DT.DET_CODEMP = :CODEMP '+
            '   AND DT.DET_SERIE_ = :SERIE_ '+
            '   AND DT.DET_CODFOR = :CODFOR '+
            '   AND DT.DET_CODITE = :CODITE '+
            '   AND (LOCATE(DT.DET_CLAFIS, ' + QuotedStr(AstrClaCom) + ') > 0) '+
            '   AND (LOCATE(DT.DET_CODFIS, ' + QuotedStr(AstrCodFis) + ') > 0) ';
end;

class function TFunctionsSQL.fGetSQLDocumentosOperacaoPropriaSemUltimaNota(AstrIdePro, AstrPrecoCompraLiquido: string): String;
  var
    LstrPrecoLiquido : String;
Begin
  Result := ' SELECT ';

  If AstrIdePro = 'NOR' Then
  Begin
    LstrPrecoLiquido := 'IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) '+
                        '              * ((100-IT.ITE_DESF02)/100) '+
                        '              * ((100-IT.ITE_DESF03)/100) '+
                        '              * ((100-IT.ITE_DESF04)/100) '+
                        '              * ((100-IT.ITE_DESF05)/100) '+
                        '              * ((100-IT.ITE_DESF06)/100) ';
  End
  Else
  Begin
    LstrPrecoLiquido := AstrPrecoCompraLiquido;
  End;

  Result := Result + '('+LstrPrecoLiquido+') * (AB.ABF_BASICM_ENT_PEJ / 100) AS BASE, '+
                     ' AB.ABF_ALQICM_ENT_PEJ AS ALIQUOTA, '+
                     '(('+LstrPrecoLiquido+') * (AB.ABF_BASICM_ENT_PEJ / 100)) * (AB.ABF_ALQICM_ENT_PEJ / 100 ) AS VALOR '+
                     ' FROM ITEGER IT '+
                     ' LEFT JOIN CADITE CT ON IT.ITE_CODITE = CT.ITE_CODITE '+
                     ' LEFT JOIN CADFOR FO ON FO.FOR_CODFOR = CT.ITE_CODFOR '+
                     ' LEFT JOIN CADCID CI ON CI.CID_CODCID = FO.FOR_CODCID ';

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, varString) = '1' Then
  Begin
    Result := Result + ' LEFT JOIN ABFICM AB ON CT.ITE_CODABF = AB.ABF_CODABF AND CI.CID_ESTADO = AB.ABF_ESTADO ';
  End
  Else
  Begin
    Result := Result + ' LEFT JOIN ABFICM AB ON IT.ITE_CODABF = AB.ABF_CODABF AND CI.CID_ESTADO = AB.ABF_ESTADO ';
  End;

  Result := Result + ' WHERE IT.ITE_CODEMP = :CODEMP '+
                     '   AND IT.ITE_CODITE = :CODITE ';

end;

class function TFunctionsSQL.GetSelectConvertePrecos: String;
begin
  Result := 'SELECT * FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1';
end;

Class function TFunctionsSQL.GetSQLDocumentos(AClassificacaoCompra, ACodigoFiscal : String) : String;
Var
  strSQL : String;
begin
  strSQL :=           ' SELECT DET_NUMDOC, ' +
                      '        DET_ESPDOC, ' +
                      '        DET_CODEMP, ' +
                      '        DET_SERIE_, ' +
                      '        DET_CODFOR, ' +
                      '        DET_QTDITE, ' +
                      '        DET_DTAENT, ' +
                      '        IFNULL(DET_BAERET,     0.00) AS DET_BAERET, ' +
                      '        IFNULL(DET_VAERET,     0.00) AS DET_VAERET, ' +
                      '        IFNULL(DET_VFCPST,     0.00) AS DET_VFCPST, ' +
                      '        IFNULL(N20_PREBCST,    0.00) AS DET_PERRED, ' +
                      '        IFNULL(N26_VBCSTRET,   0.00) AS N26_VBCSTRET, '+
                      '        IFNULL(N27_VICMSSTRET, 0.00) AS N27_VICMSSTRET, '+
                      '        IFNULL(N23D_FCPST,     0.00) AS N23D_FCPST, '+
                      '        ROUND(IFNULL( DE.N17_VICMS,0),2) AS DET_VALICM, '+

                      '        IF(IFNULL(DE.N17_VICMS, 0) > 0, ROUND((DE.N17_VICMS / DET_QTDITE), 2), ((IT.ITE_PRECOM) * (AB.ABF_BASICM_ENT_PEJ / 100)) * (AB.ABF_ALQICM_ENT_PEJ / 100 )) AS VALOR_OP_PROPRIA_SAIDA, ';

  strSQL := strSQL +  '        ( IF( DT.DET_IDEPRO = "NOR", IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) * ((100-IT.ITE_DESF02)/100) * ((100-IT.ITE_DESF03)/100) * '+
                      '                                                     ((100-IT.ITE_DESF04)/100) * ((100-IT.ITE_DESF05)/100) * ((100-IT.ITE_DESF06)/100), IFNULL(TR.DET_COMLIQ, 0.00)) * '+
                      '                                                     ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * '+
                      '                                                     AB.ABF_IVA_ST_ENT_PEJ) * (AB.ABF_ALQRET_ENT_PEJ / 100)   AS COMLIQ_IPI_FRETE_IVA_ABF, ';

  strSQL := strSQL +  '        IF( DT.DET_IDEPRO = "NOR", IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) * ((100-IT.ITE_DESF02)/100) * ((100-IT.ITE_DESF03)/100) * '+
                      '                                                   ((100-IT.ITE_DESF04)/100) * ((100-IT.ITE_DESF05)/100) * ((100-IT.ITE_DESF06)/100), IFNULL(TR.DET_COMLIQ, 0.00)) * '+
                      '                                                   ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * '+
                      '                                                   AB.ABF_IVA_ST_ENT_PEJ   AS COMLIQ_IPI_FRETE_IVA '+
                      ' FROM MOVDET DT ' +
                      '   LEFT JOIN MOVTRI TR ON TR.DET_SEQGER = DT.AUTOINCREM ' +
                      '   LEFT JOIN GERELE GE ON GE.GER_DOCENT = DT.DET_NUMDOC ' +
                      '                      AND GE.GER_ESPENT = DT.DET_ESPDOC ' +
                      '                      AND GE.GER_EMPENT = DT.DET_CODEMP ' +
                      '                      AND GE.GER_CODFOR = DT.DET_CODFOR ' +
                      '                      AND IFNULL(GE.B07_SERIE, "") = IFNULL(DT.DET_SERIE_, "") ' +
                      '   LEFT JOIN CADEMP CE ON DT.DET_CODEMP = CE.EMP_CODEMP ' +
                      '   LEFT JOIN CADCID CC ON CE.EMP_CODCID = CC.CID_CODCID ' +
                      '   LEFT JOIN CADITE CI ON DT.DET_CODITE = CI.ITE_CODITE ' +
                      '   LEFT JOIN ITEGER IT ON DT.DET_CODITE = IT.ITE_CODITE ' +
                      '                      AND DT.DET_CODEMP = IT.ITE_CODEMP ' ;

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, varString) = '1' Then
  Begin
    strSQL := strSQL +  '   LEFT JOIN ABFICM AB ON CI.ITE_CODABF = AB.ABF_CODABF ' +
                        '                      AND CC.CID_ESTADO = AB.ABF_ESTADO ' ;
  End
  Else
  Begin
    strSQL := strSQL +  '   LEFT JOIN ABFICM AB ON IT.ITE_CODABF = AB.ABF_CODABF ' +
                        '                      AND CC.CID_ESTADO = AB.ABF_ESTADO ' ;
  End;

  strSQL := strSQL +    '   LEFT JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM ' +
                        '                      AND DE.DET_CODITE = DT.DET_CODITE ' +
                        ' WHERE DT.DET_PROEMB <> "S"    '+
                        '   AND DT.DET_NUMDOC = :NUMDOC '+
                        '   AND DT.DET_ESPDOC = :ESPDOC '+
                        '   AND DT.DET_CODEMP = :CODEMP '+
                        '   AND DT.DET_SERIE_ = :SERIE_ '+
                        '   AND DT.DET_CODFOR = :CODFOR '+
                        '   AND DT.DET_CODITE = :CODITE '+
                        '   AND (LOCATE(DT.DET_CLAFIS, ' + QuotedStr(AClassificacaoCompra) + ') > 0) '+
                        '   AND (LOCATE(DT.DET_CODFIS, ' + QuotedStr(ACodigoFiscal) + ') > 0) ';


  Result := strSQL;
end;

Class function TFunctionsSQL.GetSQLDocumentosSemUltimaNota(const APrecoVenda : String) : String;
Var
  strSQL : String;
Begin
  strSQL := ' SELECT ';

  strSQL := strSQL + ' (IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) * ((100-IT.ITE_DESF02)/100) * ((100-IT.ITE_DESF03)/100) * ';
  strSQL := strSQL + ' ((100-IT.ITE_DESF04)/100) * ((100-IT.ITE_DESF05)/100) * ((100-IT.ITE_DESF06)/100) * ';
  strSQL := strSQL + ' ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * ';
  strSQL := strSQL + ' AB.ABF_IVA_ST_ENT_PEJ) * (AB.ABF_ALQRET_ENT_PEJ / 100)   AS COMLIQ_IPI_FRETE_IVA_ABF, ';

  strSQL := strSQL + ' IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) * ((100-IT.ITE_DESF02)/100) * ((100-IT.ITE_DESF03)/100) * ';
  strSQL := strSQL + ' ((100-IT.ITE_DESF04)/100) * ((100-IT.ITE_DESF05)/100) * ((100-IT.ITE_DESF06)/100) * ';
  strSQL := strSQL + ' ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * ';
  strSQL := strSQL + ' AB.ABF_IVA_ST_ENT_PEJ   AS COMLIQ_IPI_FRETE_IVA ';

  If (Not APrecoVenda.IsEmpty) Then
    strSQL := strSQL + ', ((' + APrecoVenda + ') * (AB.ABF_BASICM_ENT_PEJ / 100)) * (AB.ABF_ALQICM_ENT_PEJ / 100 ) AS VALOR_OP_PROPRIA_SAIDA ';

  strSQL := strSQL + ' FROM ITEGER IT ';
  strSQL := strSQL + ' LEFT JOIN CADITE CT ON IT.ITE_CODITE = CT.ITE_CODITE ';
  strSQL := strSQL + ' LEFT JOIN CADFOR FO ON FO.FOR_CODFOR = CT.ITE_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN CADCID CI ON CI.CID_CODCID = FO.FOR_CODCID ';

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, varString) = '1' Then
  Begin
    strSQL := strSQL + ' LEFT JOIN ABFICM AB ON CT.ITE_CODABF = AB.ABF_CODABF AND CI.CID_ESTADO = AB.ABF_ESTADO ';
  End
  Else
  Begin
    strSQL := strSQL + ' LEFT JOIN ABFICM AB ON IT.ITE_CODABF = AB.ABF_CODABF AND CI.CID_ESTADO = AB.ABF_ESTADO ';
  End;

  strSQL := strSQL + ' WHERE IT.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + ' AND IT.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

Class function TFunctionsSQL.GetSQLDocumentosSemUltimaNotaDeTinta(const APrecoVenda : String) : String;
Var
  strSQL : String;
Begin
  strSQL := ' SELECT ';

  strSQL := strSQL + ' ( :COMLIQ * ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * AB.ABF_IVA_ST_ENT_PEJ) * (AB.ABF_ALQRET_ENT_PEJ / 100) AS COMLIQ_IPI_FRETE_IVA_ABF,';
  strSQL := strSQL + '   :COMLIQ * ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * AB.ABF_IVA_ST_ENT_PEJ AS COMLIQ_IPI_FRETE_IVA';

  If (Not APrecoVenda.IsEmpty) Then
    strSQL := strSQL + ', ((' + APrecoVenda + ') * (AB.ABF_BASICM_ENT_PEJ / 100)) * (AB.ABF_ALQICM_ENT_PEJ / 100 ) AS VALOR_OP_PROPRIA_SAIDA ';

  strSQL := strSQL + ' FROM ITEGER IT ';
  strSQL := strSQL + ' LEFT JOIN CADITE CT ON IT.ITE_CODITE = CT.ITE_CODITE ';
  strSQL := strSQL + ' LEFT JOIN CADFOR FO ON FO.FOR_CODFOR = CT.ITE_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN CADCID CI ON CI.CID_CODCID = FO.FOR_CODCID ';

  If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, varString) = '1' Then
  Begin
    strSQL := strSQL + ' LEFT JOIN ABFICM AB ON CT.ITE_CODABF = AB.ABF_CODABF AND CI.CID_ESTADO = AB.ABF_ESTADO ';
  End
  Else
  Begin
    strSQL := strSQL + ' LEFT JOIN ABFICM AB ON IT.ITE_CODABF = AB.ABF_CODABF AND CI.CID_ESTADO = AB.ABF_ESTADO ';
  End;

  strSQL := strSQL + ' WHERE IT.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + ' AND IT.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

end.
