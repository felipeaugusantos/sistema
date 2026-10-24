unit Faturamento.Impostos.IcmsEfetivo.SQL;

interface

uses Shared.Functions.Configuracoes;

function fGetSQLUltimasNotas(strCodIte : String; strForFil : String; strCodEmp : String = '') : String;

function fGetSQLDocumentos(strClaCom, strCodFis : String; strTpAbre: String = '') : String;


implementation

uses SysUtils;

function fGetSQLUltimasNotas(strCodIte : String; strForFil : String; strCodEmp : String = '') : String;
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

function fGetSQLDocumentos(strClaCom, strCodFis : String; strTpAbre: String = '') : String;
Var
  strSQL : String;
begin
  strSQL := ' SELECT DET_NUMDOC, ' +
            '        DET_ESPDOC, ' +
            '        DET_CODEMP, ' +
            '        DET_SERIE_, ' +
            '        DET_CODFOR, ' +
            '        DET_QTDITE, ' +
            '        DET_DTAENT, ' +
            '        IFNULL(DET_BAERET,  0.00) AS DET_BAERET, ' +
            '        IFNULL(DET_VAERET,  0.00) AS DET_VAERET, ' +
            '        IFNULL(N20_PREBCST, 0.00) AS DET_PERRED, ' ;

  if not strTpAbre.IsEmpty then
  begin
    strSQL := strSQL +        '        (IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) * ((100-IT.ITE_DESF02)/100) * ((100-IT.ITE_DESF03)/100) * '+
                              '        ((100-IT.ITE_DESF04)/100) * ((100-IT.ITE_DESF05)/100) * ((100-IT.ITE_DESF06)/100) * '+
                              '        ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * '+
                              '        AB.ABF_IVA_ST_ENT_PEJ) * (ABF_ALQIED'+strTpAbre+' / 100)   AS COMLIQ_IPI_FRETE_IVA_ABF, ';
  end;

  strSQL := strSQL +          '        IT.ITE_PRECOM * ((100-IT.ITE_DESF01)/100) * ((100-IT.ITE_DESF02)/100) * ((100-IT.ITE_DESF03)/100) * '+
                              '        ((100-IT.ITE_DESF04)/100) * ((100-IT.ITE_DESF05)/100) * ((100-IT.ITE_DESF06)/100) * '+
                              '        ((100+IT.ITE_IPIENT)/100) * ((100+IT.ITE_FREENT)/100) * '+
                              '        AB.ABF_IVA_ST_ENT_PEJ   AS COMLIQ_IPI_FRETE_IVA '+
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
                                ' WHERE DT.DET_NUMDOC = :NUMDOC '+
                                '   AND DT.DET_ESPDOC = :ESPDOC '+
                                '   AND DT.DET_CODEMP = :CODEMP '+
                                '   AND DT.DET_SERIE_ = :SERIE_ '+
                                '   AND DT.DET_CODFOR = :CODFOR '+
                                '   AND DT.DET_CODITE = :CODITE '+
                                '   AND (LOCATE(DT.DET_CLAFIS, ' + QuotedStr(strClaCom) + ') > 0) '+
                                '   AND (LOCATE(DT.DET_CODFIS, ' + QuotedStr(strCodFis) + ') > 0) ';


  Result := strSQL;
end;



end.
