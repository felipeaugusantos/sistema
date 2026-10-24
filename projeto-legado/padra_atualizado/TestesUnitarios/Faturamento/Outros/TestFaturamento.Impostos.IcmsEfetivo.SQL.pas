unit TestFaturamento.Impostos.IcmsEfetivo.SQL;

interface

uses
  TestFramework, Faturamento.Impostos.IcmsEfetivo.SQL, Shared.Functions.Configuracoes;

type
  TestFaturamentoIcmsEfetivoSQL = class(TTestCase)
  strict private
    function fGetSQLDocumentosTest(strClaCom, strCodFis : String) : string;
    function fGetSQLUltimasNotasTest(strCodIte : String; strForFil : String; strCodEmp : String = '') : String;
    function fGetSQLDocumentosSemUltimaNotaTest: String;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSQLDocumentosVazia;
    procedure TestSQLDocumentosPreenchida;
    procedure TestSQLDocumentosVaziaConfiguracao2;
    procedure TestSQLDocumentosPreenchidaConfiguracao2;
    procedure TestSQLDocumentosSemUltimaNotaVazia;
    procedure TestSQLDocumentosSemUltimaNotaPreenchida;

    procedure TestSemULtimaNotaVaziaConfig_1;
    procedure TestSemULtimaNotaVaziaConfig_2;
    procedure TestSemULtimaNotaPreenchidaConfig_1;
    procedure TestSemULtimaNotaPreenchidaConfig_2;

    procedure TestSQLUltimasNotasVazia;
    procedure TestSQLUltimasNotasPreenchida;
  end;

Const
  TIPABF_PARA_TODAS_EMPRESAS = '1';
  TIPABF_UMA_POR_EMPRESA = '2';

implementation

uses SysUtils;

{ TestContabilidadeSQL }

function TestFaturamentoIcmsEfetivoSQL.fGetSQLUltimasNotasTest(strCodIte, strForFil: String; strCodEmp : String = ''): String;
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
            '  WHERE ITE_CODITE IN ('+ strCodIte +') '+
            '    AND LOCATE("NF", ITE_NOTULT) > 0 '+
            '    AND ITE_DTAULT IS NOT NULL ';

  If Not strForFil.IsEmpty Then
    strSQL := strSQL + '  AND (ITE_FORULT NOT IN (' + strForFil + ')) ';

  If Not strCodEmp.IsEmpty then
    strSQL := strSQL + ' AND ITE_CODEMP = '+QuotedStr(strCodEmp)+' ';

  strSQL := strSQL + ' ORDER BY ITE_CODITE, ITE_DTAULT DESC, ITE_NOTULT DESC ';

  Result := strSQL;
end;

procedure TestFaturamentoIcmsEfetivoSQL.SetUp;
begin
  inherited;

end;

procedure TestFaturamentoIcmsEfetivoSQL.TearDown;
begin
  inherited;

end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSemULtimaNotaPreenchidaConfig_1;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_PARA_TODAS_EMPRESAS);
  CheckTrue(fGetSQLDocumentosSemUltimaNotaTest = fGetSQLDocumentosSemUltimaNota);
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSemULtimaNotaPreenchidaConfig_2;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_UMA_POR_EMPRESA);
  CheckTrue(fGetSQLDocumentosSemUltimaNotaTest = fGetSQLDocumentosSemUltimaNota);
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSemULtimaNotaVaziaConfig_1;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_PARA_TODAS_EMPRESAS);
  CheckTrue(fGetSQLDocumentosSemUltimaNotaTest = fGetSQLDocumentosSemUltimaNota);
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSemULtimaNotaVaziaConfig_2;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_UMA_POR_EMPRESA);
  CheckTrue(fGetSQLDocumentosSemUltimaNotaTest = fGetSQLDocumentosSemUltimaNota);
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLDocumentosPreenchida;
  const
    strClaCom : String = '1101_2101_1403_2403_1102_2102_1411_2411_2103_2911_2353_1353_5909_1909_1932_1911_2401_1117_1921_2921_';
    strCodFis : String = '010_110_210_310_410_510_610_710_810_060_160_260_360_460_560_660_760_860_070_170_270_370_470_570_670_770_870_030_130_230_330_430_530_630_730_';
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_PARA_TODAS_EMPRESAS);
  CheckTrue( fGetSQLDocumentosTest( strClaCom, strCodFis) = fGetSQLDocumentos( strClaCom, strCodFis) );
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLDocumentosPreenchidaConfiguracao2;
  const
    strClaCom : String = '1101_2101_1403_2403_1102_2102_1411_2411_2103_2911_2353_1353_5909_1909_1932_1911_2401_1117_1921_2921_';
    strCodFis : String = '010_110_210_310_410_510_610_710_810_060_160_260_360_460_560_660_760_860_070_170_270_370_470_570_670_770_870_030_130_230_330_430_530_630_730_';
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_UMA_POR_EMPRESA);
  CheckTrue( fGetSQLDocumentosTest( strClaCom, strCodFis ) = fGetSQLDocumentos( strClaCom, strCodFis) );
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLDocumentosSemUltimaNotaPreenchida;
begin
  CheckTrue(fGetSQLDocumentosSemUltimaNotaTest = fGetSQLDocumentosSemUltimaNota);
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLDocumentosSemUltimaNotaVazia;
begin
  CheckTrue(fGetSQLDocumentosSemUltimaNotaTest = fGetSQLDocumentosSemUltimaNota);
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLDocumentosVazia;
  const
    strClaCom : String = '';
    strCodFis : String = '';
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_PARA_TODAS_EMPRESAS);
  CheckTrue(fGetSQLDocumentosTest(strClaCom, strCodFis ) = fGetSQLDocumentos( strClaCom, strCodFis) );
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLDocumentosVaziaConfiguracao2;
  const
    strClaCom : String = '';
    strCodFis : String = '';
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_FISCAL, TIPABF_UMA_POR_EMPRESA);
  CheckTrue(fGetSQLDocumentosTest(strClaCom, strCodFis ) = fGetSQLDocumentos( strClaCom, strCodFis) );
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLUltimasNotasPreenchida;
  const
    strCodEmp : String = '001';
    strCodIte : String = '40304';
    strForFil : String = '"00000001", "00000009", "00000011", "00000014", '+
                         '"00000015", "00000020", "00000030", "00000035", '+
                         '"00000036", "00000040", "00000045", "00000137", '+
                         '"00000141", "00000153", "00000221", "00000239", '+
                         '"00000310", "00000454", "00000455", "00000486", '+
                         '"00000520", "00000524", "00000529", "00000551", '+
                         '"00000588", "00000781", "00000844", "00001016", '+
                         '"00007963", "00008171", "00008174", "00008228", '+
                         '"00008231", "00008236", "00008504", "00008505", '+
                         '"00009817", "00009819", "00009841", "00009852", '+
                         '"90690600"';
begin
  CheckTrue(fGetSQLUltimasNotasTest(strCodIte, strForFil, strCodEmp) = fGetSQLUltimasNotas(strCodIte, strForFil, strCodEmp));
end;

procedure TestFaturamentoIcmsEfetivoSQL.TestSQLUltimasNotasVazia;
  const
    strCodIte : String = '';
    strForFil : String = '';
    strCodEmp : String = '';
begin
  CheckTrue(fGetSQLUltimasNotasTest(strCodIte, strForFil, strCodEmp) = fGetSQLUltimasNotas(strCodIte, strForFil, strCodEmp));
end;

function TestFaturamentoIcmsEfetivoSQL.fGetSQLDocumentosSemUltimaNotaTest: String;
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

function TestFaturamentoIcmsEfetivoSQL.fGetSQLDocumentosTest(strClaCom, strCodFis : String) : string;

  var
    strSQL : string;
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
                      '        ROUND(IFNULL( DE.N17_VICMS,0),2) AS DET_VALICM, ';

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
    strSQL := strSQL +          '   LEFT JOIN ABFICM AB ON CI.ITE_CODABF = AB.ABF_CODABF ' +
                                '                      AND CC.CID_ESTADO = AB.ABF_ESTADO ' ;
  End
  Else
  Begin
    strSQL := strSQL +          '   LEFT JOIN ABFICM AB ON IT.ITE_CODABF = AB.ABF_CODABF ' +
                                '                      AND CC.CID_ESTADO = AB.ABF_ESTADO ' ;
  End;

  strSQL := strSQL +            '   LEFT JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM ' +
                                '                      AND DE.DET_CODITE = DT.DET_CODITE ' +
                                ' WHERE DT.DET_PROEMB <> "S"    '+
                                '   AND DT.DET_NUMDOC = :NUMDOC '+
                                '   AND DT.DET_ESPDOC = :ESPDOC '+
                                '   AND DT.DET_CODEMP = :CODEMP '+
                                '   AND DT.DET_SERIE_ = :SERIE_ '+
                                '   AND DT.DET_CODFOR = :CODFOR '+
                                '   AND DT.DET_CODITE = :CODITE '+
                                '   AND (LOCATE(DT.DET_CLAFIS, ' + QuotedStr(strClaCom) + ') > 0) '+
                                '   AND (LOCATE(DT.DET_CODFIS, ' + QuotedStr(strCodFis) + ') > 0) ';


  Result := strSQL;
end;

initialization
  RegisterTest(TestFaturamentoIcmsEfetivoSQL.Suite);

end.
