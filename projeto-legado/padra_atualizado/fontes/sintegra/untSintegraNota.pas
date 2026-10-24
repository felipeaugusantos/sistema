unit untSintegraNota;

interface

uses SysUtils, Uni, Classes, StrUtils, Forms;

Type
  TSintegraNota = class(TObject)
  private
    stlArquivo: TStringList;

    Banco: TUniConnection;
    qryEmp: TUniQuery;
    qryDados: TUniQuery;

    FDtaIni: TDateTime;
    FDtaFin: TDateTime;

    strReg90: String;
    intContaReg: Integer;
    intRegTotal: Integer;
    intContaReg90: Integer;

    procedure pDadosCabecalho;
    procedure pCarregaDadosReg50;
    procedure pCarregaDadosReg51;
    procedure pCarregaDadosReg53;
    procedure pCarregaDadosReg54;
    procedure pCarregaDadosReg75;

    procedure pGeraReg10;
    procedure pGeraReg11;
    procedure pGeraReg50;
    procedure pGeraReg51;
    procedure pGeraReg53;
    procedure pGeraReg54;
    procedure pGeraReg75;
    procedure pGeraReg90(intReg: integer = 0; intContaReg: integer = 0);

  public
    procedure pGerarSintegra;

    constructor Create(dtaDtaIni, dtaDtaFin: TDateTime);
    destructor Destroy; reintroduce;
  End;

implementation

uses untFuncoes,  untFuncoesSimples;

constructor TSintegraNota.Create(dtaDtaIni, dtaDtaFin: TDateTime);
begin
  inherited Create;
  stlArquivo := TStringList.Create;

  qryEmp   := fCriaQuery(Nil);
  qryDados := fCriaQuery(Nil);

  FDtaIni := dtaDtaIni;
  FDtaFin := dtaDtaFin;
end;

destructor TSintegraNota.Destroy;
begin

  FreeAndNil(qryEmp);
  FreeAndNil(Banco);
  FreeAndNil(stlArquivo);
  inherited Destroy;
end;

procedure TSintegraNota.pCarregaDadosReg50;
  Var
    strSql: String;
begin

  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE DISTINCT ';
  strSql := strSql + '  FIS.AUTOINCREM AS "FIS_AUTOINCREM", ';
  strSql := strSql + '  FIS_ENTSAI, ';
  strSql := strSql + '  FIS_ESPDOC, ';
  strSql := strSql + '  FIS_SERIE_, ';
  strSql := strSql + '  FIS_CODEMP, ';
  strSql := strSql + '  IFNULL(REPLACE(REPLACE(FIS_NUMDOC, "-", ""), ",", ""), "0") AS "FIS_NUMDOC", ';
  strSql := strSql + '  FIS_FORCLI, ';
  strSql := strSql + '  IF(FIS_TIP_FC = "F", FOR_C_G_C_, IF(IFNULL(GER_CGCCON, "") = "", CLI_C_G_C_, GER_CGCCON)) AS "FIS_C_G_C_", '; // SE FOR FORNEC OU CLIENTE -> CNPJ/CPF
  strSql := strSql + '  IF(CLI_I_E_S_ = "", "ISENTO", IFNULL(CLI_I_E_S_, "ISENTO")) AS "FIS_I_E_S_", '; // ALFANUM (014)
  strSql := strSql + '  FIS_ESTADO, ';
  strSql := strSql + '  IF(FIS_TIP_FC = "F", FOR_NOMFOR, CLI_NOMCLI) AS FIS_CODCLI, '; //SE FOR FORNEC OU CLIENTE -> NOME
  strSql := strSql + '  FIS_DTADOC, ';
  strSql := strSql + '  FIS_DTAENT, ';
  // VERIFICA TIPO FORN/CLIENTE E RESPECTIVAMENTE TESTA SE PESS.JURIDICA(1)->"J" OU PESS.FISICA(2)->"F"
  strSql := strSql + '  IF(FIS_TIP_FC = "F", IF(FOR_CGCCPF="1","J","F"), IF( CLI_CGCCPF="1","J","F")) AS "FIS_PESSOA", ';
  strSql := strSql + '  (IF (FIS_ENTSAI = "E", "T", "P")) AS "EMITENTE", ';
  strSql := strSql + '  FIS_HISTOR, ';
  strSql := strSql + '  IF (FIS_HISTOR LIKE "%CANCELADO%", "S", "N") AS "SITUACAO", ';
  strSql := strSql + '  GER_TIPFRE, ';
  strSql := strSql + '  REPLACE(GER_HORENT, ":", "") AS "GER_HORENT", ';
  strSql := strSql + '  FIS_VLCON1, FIS_VLCON2, FIS_VLCON3, FIS_VLCON4, FIS_VLCON5, ';
  strSql := strSql + '  IFNULL((FIS_VLCON1 + FIS_VLCON2 + FIS_VLCON3 + FIS_VLCON4 + FIS_VLCON5),"0.00") AS "FIS_VLCONT", ';
  strSql := strSql + '  FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5, ';
  // CONDICAO DE PAGAMENTO "01000" (A VISTA) = "1", OUTRA "2"
  strSql := strSql + '  IF(GER_CONPAG = "01000", "1", "2") AS "GER_CONPAG", ';
  strSql := strSql + '  FIS_BASIC1, FIS_BASIC2, FIS_BASIC3, FIS_BASIC4, FIS_BASIC5,	 ';
  strSql := strSql + '  (FIS_ISENT1 + FIS_ISENT2 + FIS_ISENT3 + FIS_ISENT4 + FIS_ISENT5) AS "ISENTAS", ';
  strSql := strSql + '  (FIS_OUTRA1 + FIS_OUTRA2 + FIS_OUTRA3 + FIS_OUTRA4 + FIS_OUTRA5) AS "OUTRAS", ';
  strSql := strSql + '  FIS_ALQPIS, ';
  strSql := strSql + '  FIS_ALQCOF,		 ';
  // VALOR DA SUBST. TRIBUTÁRIA
  strSql := strSql + '  (FIS_RETID1 + FIS_RETID2 + FIS_RETID3 + FIS_RETID4 + FIS_RETID5) AS "FIS_RETIDS",  ';
  // BASE DE CALCULO PARA SUBST.TRIBUTÁRIA
  strSql := strSql + '  FIS_BCRET1, FIS_BCRET2, FIS_BCRET3, FIS_BCRET4, FIS_BCRET5,  ';
  strSql := strSql + '  FIS_BASIP1, FIS_BASIP2, FIS_BASIP3, FIS_BASIP4, FIS_BASIP5,  ';
  strSql := strSql + '  FIS_VLRIP1, FIS_VLRIP2, FIS_VLRIP3, FIS_VLRIP4, FIS_VLRIP5,  ';
  strSql := strSql + '  FIS_ALQIC1, FIS_ALQIC2, FIS_ALQIC3, FIS_ALQIC4, FIS_ALQIC5,  ';
  strSql := strSql + '  FIS_VLRIC1, FIS_VLRIC2, FIS_VLRIC3, FIS_VLRIC4, FIS_VLRIC5,  ';
  strSql := strSql + '  CONCAT(IFNULL(GER_MEN001, ""), " ", IFNULL(GER_MEN002,"")) AS "OBSERVACAO" ';

  strSql := strSql + '  FROM   ';
  strSql := strSql + '    CADFIS FIS';

  strSql := strSql + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI  ';

  strSql := strSql + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI  ';

  strSql := strSql + '  INNER JOIN MOVGER ON FIS_NUMDOC = GER_NUMDOC  ';
  strSql := strSql + '            AND IFNULL(FIS_SERIE_, "") = IFNULL(GER_SERIE_, "")         ';
  strSql := strSql + '            AND FIS_ESPDOC = GER_ESPDOC         ';
  strSql := strSql + '            AND FIS_CODEMP = GER_CODEMP         ';

  strSql := strSql + '  WHERE ';
  strSql := strSql + '    FIS_CODEMP = :CODEMP ';
  strSql := strSql + '    AND ( (CLI_CODCLI = FIS_FORCLI) OR (FOR_CODFOR = FIS_FORCLI) ) ';
  strSql := strSql + '    AND ( (TRIM(IFNULL(FIS_SERIE_, "")) = "") OR ( (FIS_SERIE_ >= "001") AND (FIS_SERIE_ <= "999") ) ) ';
  strSql := strSql + '    AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL") ';
  strSql := strSql + '    AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

//  strSql := strSql + '  GROUP BY FIS_NUMDOC, FIS_SERIE_, FIS_ENTSAI, FIS_ESPDOC, FIS_CODEMP, FIS_DTAENT  ';
  strSql := strSql + '  GROUP BY FIS_AUTOINCREM  ';

  strSql := strSql + '  UNION ' + AnsiReplaceStr(AnsiReplaceStr(strSql, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSql := strSql + '  ORDER BY ';
  strSql := strSql + '    FIS_NUMDOC, FIS_DTAENT ';

  qryDados.SQL.Clear;
  qryDados.SQL.Text := strSql;

  qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDados.ParamByName('DTAINI').AsDate   := FDtaIni;
  qryDados.ParamByName('DTAFIN').AsDate   := FDtaFin;

  qryDados.Open;
end;

procedure TSintegraNota.pCarregaDadosReg51;
  Var
    strSql: String;
begin

  qryDados.SQL.Clear;

  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE ';
  strSql := strSql + '  FIS_ENTSAI, ';
  strSql := strSql + '  FIS_ESPDOC, ';
  strSql := strSql + '  FIS_SERIE_, ';
  strSql := strSql + '  FIS_CODEMP, ';
  strSql := strSql + '  IFNULL(REPLACE(REPLACE(FIS_NUMDOC, "-", ""), ",", ""), "0") AS "FIS_NUMDOC", ';
  strSql := strSql + '  FIS_FORCLI, ';
  strSql := strSql + '  IF(FIS_TIP_FC = "F", FOR_C_G_C_, IF(IFNULL(GER_CGCCON, "") = "", CLI_C_G_C_, GER_CGCCON)) AS "FIS_C_G_C_", '; // SE FOR FORNEC OU CLIENTE -> CNPJ/CPF
  strSql := strSql + '  IF(CLI_I_E_S_ = "", "ISENTO", IFNULL(CLI_I_E_S_, "ISENTO")) AS "FIS_I_E_S_", '; // ALFANUM (014)
  strSql := strSql + '  FIS_ESTADO, ';
  strSql := strSql + '  IF(FIS_TIP_FC = "F", FOR_NOMFOR, CLI_NOMCLI) AS "FIS_CODCLI", '; //SE FOR FORNEC OU CLIENTE -> NOME
  strSql := strSql + '  FIS_DTADOC, ';
  strSql := strSql + '  FIS_DTAENT, ';
  // VERIFICA TIPO FORN/CLIENTE E RESPECTIVAMENTE TESTA SE PESS.JURIDICA(1)->"J" OU PESS.FISICA(2)->"F"
  strSql := strSql + '  IF(FIS_TIP_FC = "F", IF(FOR_CGCCPF="1","J","F"), IF( CLI_CGCCPF="1","J","F")) AS "FIS_PESSOA", ';
  strSql := strSql + '  (IF (FIS_ENTSAI = "E", "T", "P")) AS "EMITENTE", ';
  strSql := strSql + '  FIS_HISTOR, ';
  strSql := strSql + '  IF (FIS_HISTOR LIKE "%CANCELADO%", "S", "N") AS "SITUACAO", ';
  strSql := strSql + '  GER_TIPFRE, ';
  strSql := strSql + '  REPLACE(GER_HORENT, ":", "") AS "GER_HORENT", ';
  strSql := strSql + '  FIS_VLCON1, FIS_VLCON2, FIS_VLCON3, FIS_VLCON4, FIS_VLCON5, ';
  strSql := strSql + '  IFNULL((FIS_VLCON1 + FIS_VLCON2 + FIS_VLCON3 + FIS_VLCON4 + FIS_VLCON5),"0.00") AS "FIS_VLCONT", ';
  strSql := strSql + '  FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5, ';
  // CONDICAO DE PAGAMENTO "01000" (A VISTA) = "1", OUTRA "2"
  strSql := strSql + '  IF (GER_CONPAG = "01000", "1", "2") AS "GER_CONPAG", ';
  strSql := strSql + '  FIS_BASIC1, FIS_BASIC2, FIS_BASIC3, FIS_BASIC4, FIS_BASIC5,	 ';
  strSql := strSql + '  (FIS_ISENT1 + FIS_ISENT2 + FIS_ISENT3 + FIS_ISENT4 + FIS_ISENT5) AS "ISENTAS", ';
  strSql := strSql + '  (FIS_OUTRA1 + FIS_OUTRA2 + FIS_OUTRA3 + FIS_OUTRA4 + FIS_OUTRA5) AS "OUTRAS", ';
  strSql := strSql + '  FIS_ALQPIS, ';
  strSql := strSql + '  FIS_ALQCOF,		 ';
  // VALOR DA SUBST. TRIBUTÁRIA
  strSql := strSql + '  (FIS_RETID1 + FIS_RETID2 + FIS_RETID3 + FIS_RETID4 + FIS_RETID5) AS "FIS_RETIDS",  ';
  // BASE DE CALCULO PARA SUBST.TRIBUTÁRIA
  strSql := strSql + '  FIS_BCRET1, FIS_BCRET2, FIS_BCRET3, FIS_BCRET4, FIS_BCRET5,  ';
  strSql := strSql + '  FIS_BASIP1, FIS_BASIP2, FIS_BASIP3, FIS_BASIP4, FIS_BASIP5,  ';
  strSql := strSql + '  FIS_VLRIP1, FIS_VLRIP2, FIS_VLRIP3, FIS_VLRIP4, FIS_VLRIP5,  ';
  strSql := strSql + '  FIS_ALQIC1, FIS_ALQIC2, FIS_ALQIC3, FIS_ALQIC4, FIS_ALQIC5,  ';
  strSql := strSql + '  FIS_VLRIC1, FIS_VLRIC2, FIS_VLRIC3, FIS_VLRIC4, FIS_VLRIC5,  ';
  strSql := strSql + '  CONCAT(IFNULL(GER_MEN001, ""), " ", IFNULL(GER_MEN002,"")) AS "OBSERVACAO" ';

  strSql := strSql + '  FROM   ';
  strSql := strSql + '  CADFIS ';
  strSql := strSql + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  strSql := strSql + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';
  strSql := strSql + '  INNER JOIN MOVGER ON FIS_NUMDOC = GER_NUMDOC ';
  strSql := strSql + '            AND FIS_ESPDOC = GER_ESPDOC ';
  strSql := strSql + '            AND FIS_CODEMP = GER_CODEMP ';

  strSql := strSql + '  WHERE ';
  strSql := strSql + '  FIS_CODEMP = :CODEMP ';
  strSql := strSql + '  AND ( (CLI_CODCLI = FIS_FORCLI) OR (FOR_CODFOR = FIS_FORCLI) ) ';
  strSql := strSql + '  AND ( (TRIM(IFNULL(FIS_SERIE_, "")) = "") OR (FIS_SERIE_ = "") OR ( (FIS_SERIE_ >= "001") AND (FIS_SERIE_ <= "999") ) ) ';
  strSql := strSql + '  AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL") ' ;
  strSql := strSql + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
  // OPCAO PARA SELECIONAR SOMENTE AS NOTAS QUE POSSUIREM ALGUM VALOR DE IPI
  strSql := strSql + '  AND (FIS_VLRIP1 + FIS_VLRIP2 + FIS_VLRIP3 + FIS_VLRIP4 + FIS_VLRIP5) > 0  ';

  strSql := strSql + ' UNION ' + AnsiReplaceStr(AnsiReplaceStr(strSql, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSql := strSql + '  ORDER BY ';
  strSql := strSql + '  FIS_NUMDOC, FIS_DTAENT,FIS_CODEMP, FIS_CODEMP ';

  qryDados.SQL.Clear;
  qryDados.SQL.Text := strSql;

  qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDados.ParamByName('DTAINI').AsDate   := FDtaIni;
  qryDados.ParamByName('DTAFIN').AsDate   := FDtaFin;

  qryDados.Open;

end;

procedure TSintegraNota.pCarregaDadosReg53;
  Var
    strSql: String;
begin

  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE ';
  // CODIGO DA UNIDADE DA EMPRESA (FILIAL) USUARIA DO SISTEMA
  strSql := strSql + '  FIS_CODEMP, ';
  // CNPJ / CPF DA EMPRESA CLIENTE/FORNECEDORA
  strSql := strSql + '  IF(FIS_TIP_FC = "F", FOR_C_G_C_, IF(IFNULL(GER_CGCCON, "") = "", CLI_C_G_C_, GER_CGCCON)) AS "FIS_C_G_C_", '; // SE FOR FORNEC OU CLIENTE -> CNPJ/CPF
  // INSCR.ESTADUAL DA EMPRESA CLIENTE/FORNECEDORA
  strSql := strSql + '  IF(CLI_I_E_S_ = "", "ISENTO", IFNULL(CLI_I_E_S_, "ISENTO")) AS "FIS_I_E_S_", '; // ALFANUM (014)
  // DATA ENTRADA/RECEBIMENTO
  strSql := strSql + '  FIS_DTAENT, ';
  // ESTADO (UF) DA EMPRESA CLIENTE/FORNECEDORA
  strSql := strSql + '  FIS_ESTADO, ';
  // TIPO DE DOC
  strSql := strSql + '  FIS_ESPDOC, ';
  // NO.SERIE DA NOTA
  strSql := strSql + '  FIS_SERIE_, ';
  // NÚMERO DO DOCUMENTO SEM CARACTERES ESPECIAIS
  strSql := strSql + '  IFNULL(REPLACE(REPLACE(FIS_NUMDOC, "-", ""), ",", ""), "0") AS "FIS_NUMDOC", ';
  // CFOP - AS DIVERSAS CLASSIFICACOES FISCAIS DISPONIVEIS EM UMA NOTA
  strSql := strSql + '  FIS_CLFSC1, FIS_CLFSC2, FIS_CLFSC3, FIS_CLFSC4, FIS_CLFSC5, ';
  // ATRIBUI "T" SE EH NF DE ENTRADA E "P" SE EH NF DE SAIDA
  strSql := strSql + '  (IF (FIS_ENTSAI = "E", "T", "P")) AS "EMITENTE", ';
  // VALOR BASE DE CALCULO DE ICMS PARA AS DIVERSAS CLASSIFICACOES FISCAIS (CFOP)
  strSql := strSql + '  FIS_BASIC1, FIS_BASIC2, FIS_BASIC3, FIS_BASIC4, FIS_BASIC5,	 ';
  // BASE DE CALCULO PARA SUBST. TRIBUTÁRIA
  strSql := strSql + '  FIS_BCRET1, FIS_BCRET2, FIS_BCRET3, FIS_BCRET4, FIS_BCRET5,	 ';
  // VALOR RETIDO DE SUBST. TRIBUTARIA PARA CADA CLASSIFICACAO FISCAL (CFOP)
  strSql := strSql + '  FIS_RETID1, FIS_RETID2, FIS_RETID3, FIS_RETID4, FIS_RETID5,  ';
  // VALOR DE ICM RETIDO PARA CADA CLASSIFICACAO FISCAL (CFOP)
  strSql := strSql + '  FIS_VLRIC1, FIS_VLRIC2, FIS_VLRIC3, FIS_VLRIC4, FIS_VLRIC5,  ';
  // VALOR DAS DESPESAS ACESSORIAS
  strSql := strSql + '  FIS_DACES1, FIS_DACES2, FIS_DACES3, FIS_DACES4, FIS_DACES5,  ';
  // VERIFICA SE NF FOI CANCELADA PELO CAMPO HISTORICO E ATRIBUI AO CAMPO VIRTUAL CANCELADO
  strSql := strSql + '  IF (FIS_HISTOR LIKE "%CANCELADO%", "S", "N") AS "SITUACAO", ';
  // ALIQUOTAS POSSIVEIS DE ICMS PARTICIPANTES DA NOTA
  strSql := strSql + '  FIS_ALQIC1, FIS_ALQIC2, FIS_ALQIC3, FIS_ALQIC4, FIS_ALQIC5  ';

  strSql := strSql + '  FROM   ';
  strSql := strSql + '  CADFIS ';

  strSql := strSql + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  strSql := strSql + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  strSql := strSql + '  INNER JOIN MOVGER ON FIS_NUMDOC = GER_NUMDOC  ';
  strSql := strSql + '            AND IFNULL(FIS_SERIE_, "") = IFNULL(GER_SERIE_, "")         ';
  strSql := strSql + '            AND FIS_ESPDOC = GER_ESPDOC         ';
  strSql := strSql + '            AND FIS_CODEMP = GER_CODEMP         ';

  strSql := strSql + '  WHERE ';
  strSql := strSql + '  FIS_CODEMP = :CODEMP   ';
  strSql := strSql + '  AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL") ';
  strSql := strSql + '  AND ( (CLI_CODCLI = FIS_FORCLI) OR (FOR_CODFOR = FIS_FORCLI) ) ';
  strSql := strSql + '  AND ( (TRIM(IFNULL(FIS_SERIE_, "")) = "") OR ( (FIS_SERIE_ >= "001") AND (FIS_SERIE_ <= "999") ) ) ';
  strSql := strSql + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  // OPCAO PARA SELECIONAR SOMENTE AS NOTAS QUE POSSUIREM ALGUM VALOR DE IPI
  strSql := strSql + '  AND (FIS_RETID1 + FIS_RETID2 + FIS_RETID3 + FIS_RETID4 + FIS_RETID5) > 0  ';

  strSql := strSql + '  ORDER BY ';
  strSql := strSql + '  FIS_NUMDOC, FIS_DTAENT,FIS_CODEMP, FIS_CODEMP ';

  qryDados.SQL.Clear;
  qryDados.SQL.Text := strSql;

  qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDados.ParamByName('DTAINI').AsDate   := FDtaIni;
  qryDados.ParamByName('DTAFIN').AsDate   := FDtaFin;

  qryDados.Open;
end;

procedure TSintegraNota.pCarregaDadosReg54;
  Var
    strSql: String;
begin

  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE ';

  strSql := strSql + '  DET_CLAFIS AS "FIS_CLAFIS", ';
  strSql := strSql + '  DET_CODFIS AS "FIS_CODFIS", ';
  strSql := strSql + '  DET_CODITE AS "FIS_CODITE", ';
  strSql := strSql + '  (SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = FIS_CODITE) AS "FIS_DESITE",  ';
  strSql := strSql + '  DET_UNIDAD AS "FIS_UNIDAD", ';
  strSql := strSql + '  DET_QTDITE AS "FIS_QTDITE", ';
  strSql := strSql + '  DET_VLRCON AS "FIS_VLRCON", ';
  strSql := strSql + '  DET_DESCON AS "FIS_DESCON", ';
  strSql := strSql + '  DET_BASICM AS "FIS_BASICM", ';
  strSql := strSql + '  DET_BASRET AS "FIS_BASRET", ';
  strSql := strSql + '  DET_VALIPI AS "FIS_VALIPI", ';
  strSql := strSql + '  DET_ALQICM AS "FIS_ALQICM", ';
  strSql := strSql + '  DET_ALQIPI AS "FIS_ALQIPI", ';
  strSql := strSql + '  DET_PERRED AS "FIS_PERRED", ';
  strSql := strSql + '  (SELECT ITE_CLAIPI FROM CADITE WHERE ITE_CODITE = FIS_CODITE) AS "FIS_CLAIPI",  ';
  strSql := strSql + '  FIS_ESPDOC AS "FIS_ESPDOC", ';
  strSql := strSql + '  FIS_SERIE_ AS "FIS_SERIE_", ';
  strSql := strSql + '  FIS_CODEMP AS "FIS_CODEMP", ';
  strSql := strSql + '  IFNULL(REPLACE(REPLACE(FIS_NUMDOC, "-", ""), ",", ""), "0") AS "FIS_NUMDOC", ';
  strSql := strSql + '  IF(FIS_TIP_FC = "F", FOR_C_G_C_, IF(IFNULL(GER_CGCCON, "") = "", CLI_C_G_C_, GER_CGCCON)) AS "FIS_C_G_C_", '; // SE FOR FORNEC OU CLIENTE -> CNPJ/CPF
  strSql := strSql + '  IF(FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL", "01", "02") AS "FIS_MODELO", ';
  strSql := strSql + '  FIS_DTADOC AS "FIS_DTADOC", ';
  strSql := strSql + '  FIS_DTAENT AS "FIS_DTAENT" ';

  strSql := strSql + '  FROM     ';
  strSql := strSql + '    CADFIS ';

  strSql := strSql + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE  ';

  strSql := strSql + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  strSql := strSql + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  strSql := strSql + '  INNER JOIN MOVDET ON ';
  strSql := strSql + '    FIS_CODEMP = DET_CODEMP ';
  strSql := strSql + '    AND FIS_NUMDOC = DET_NUMDOC ';
  strSql := strSql + '    AND TRIM(IFNULL(FIS_SERIE_, "")) = TRIM(IFNULL(DET_SERIE_, "")) ';
  strSql := strSql + '    AND IF(FIS_TIP_FC = "F", FOR_CODFOR, CLI_CODCLI) = FIS_FORCLI ';
  strSql := strSql + '    AND FIS_ESPDOC = DET_ESPDOC ';

  strSql := strSql + '  INNER JOIN MOVGER ON FIS_NUMDOC = GER_NUMDOC  ';
  strSql := strSql + '            AND IFNULL(FIS_SERIE_, "") = IFNULL(GER_SERIE_, "")         ';
  strSql := strSql + '            AND FIS_ESPDOC = GER_ESPDOC         ';
  strSql := strSql + '            AND FIS_CODEMP = GER_CODEMP         ';

  strSql := strSql + '  WHERE ';
  strSql := strSql + '    FIS_CODEMP = :CODEMP ';
  strSql := strSql + '    AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL") ' ;
  strSql := strSql + '    AND ( (CLI_CODCLI = FIS_FORCLI) OR (FOR_CODFOR = FIS_FORCLI) ) ';
  strSql := strSql + '    AND ( (TRIM(IFNULL(FIS_SERIE_, "")) = "") OR ( (FIS_SERIE_ >= "001") AND (FIS_SERIE_ <= "999") ) ) ';
  strSql := strSql + '    AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + ' UNION ' + AnsiReplaceStr(AnsiReplaceStr(strSql, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSql := strSql + '  ORDER BY ';
  strSql := strSql + '    FIS_NUMDOC, FIS_DTAENT, FIS_CODEMP, FIS_CODEMP ';

  qryDados.SQL.Clear;
  qrydados.SQL.Text := strSql;

  qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDados.ParamByName('DTAINI').AsDate   := FDtaIni;
  qryDados.ParamByName('DTAFIN').AsDate   := FDtaFin;

  qryDados.Open;
end;

procedure TSintegraNota.pCarregaDadosReg75;
  Var
    strSql: String;
begin
  strSql := '';
  strSql := strSql + '  SELECT SQL_NO_CACHE ';
  strSql := strSql + '  DET_CLAFIS AS "FIS_CLAFIS", ';
  strSql := strSql + '  DET_CODFIS AS "FIS_CODFIS", ';
  strSql := strSql + '  DET_CODITE AS "FIS_CODITE", ';
  strSql := strSql + '  (SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = FIS_CODITE) AS "FIS_DESITE",  ';
  strSql := strSql + '  DET_UNIDAD AS "FIS_UNIDAD", ';
  strSql := strSql + '  DET_QTDITE AS "FIS_QTDITE", ';
  strSql := strSql + '  DET_VLRCON AS "FIS_VLRCON", ';
  strSql := strSql + '  DET_DESCON AS "FIS_DESCON", ';
  strSql := strSql + '  DET_BASICM AS "FIS_BASICM", ';
  strSql := strSql + '  DET_BASRET AS "FIS_BASRET", ';
  strSql := strSql + '  DET_VALIPI AS "FIS_VALIPI", ';
  strSql := strSql + '  DET_ALQICM AS "FIS_ALQICM", ';
  strSql := strSql + '  DET_ALQIPI AS "FIS_ALQIPI", ';
  strSql := strSql + '  DET_PERRED AS "FIS_PERRED", ';
  strSql := strSql + '  (SELECT ITE_CLAIPI FROM CADITE WHERE ITE_CODITE = FIS_CODITE) AS "FIS_CLAIPI",  ';
  strSql := strSql + '  FIS_ESPDOC AS "FIS_ESPDOC", ';
  strSql := strSql + '  FIS_SERIE_ AS "FIS_SERIE_", ';
  strSql := strSql + '  FIS_CODEMP AS "FIS_CODEMP", ';
  strSql := strSql + '  IFNULL(REPLACE(REPLACE(FIS_NUMDOC, "-", ""), ",", ""), "0") AS "FIS_NUMDOC", ';
  strSql := strSql + '  IF(FIS_TIP_FC = "F", FOR_C_G_C_, IF(IFNULL(GER_CGCCON, "") = "", CLI_C_G_C_, GER_CGCCON)) AS "FIS_C_G_C_", '; // SE FOR FORNEC OU CLIENTE -> CNPJ/CPF
  strSql := strSql + '  IF(FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL", "01", "02") AS "FIS_MODELO", ';
  strSql := strSql + '  FIS_DTADOC AS "FIS_DTADOC", ';
  strSql := strSql + '  FIS_DTAENT AS "FIS_DTAENT" ';

  strSql := strSql + '  FROM     ';
  strSql := strSql + '    CADFIS ';

  strSql := strSql + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE  ';
  strSql := strSql + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  strSql := strSql + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  strSql := strSql + '  INNER JOIN MOVDET ON ';
  strSql := strSql + '    FIS_CODEMP = DET_CODEMP ';
  strSql := strSql + '    AND FIS_NUMDOC = DET_NUMDOC ';
  strSql := strSql + '    AND TRIM(IFNULL(FIS_SERIE_, "")) = TRIM(IFNULL(DET_SERIE_, "")) ';
  strSql := strSql + '    AND IF(FIS_TIP_FC = "F", FOR_CODFOR, CLI_CODCLI) = FIS_FORCLI ';
  strSql := strSql + '    AND FIS_ESPDOC = DET_ESPDOC ';

  strSql := strSql + '  INNER JOIN MOVGER ON FIS_NUMDOC = GER_NUMDOC  ';
  strSql := strSql + '            AND IFNULL(FIS_SERIE_, "") = IFNULL(GER_SERIE_, "")         ';
  strSql := strSql + '            AND FIS_ESPDOC = GER_ESPDOC         ';
  strSql := strSql + '            AND FIS_CODEMP = GER_CODEMP         ';

  strSql := strSql + '  WHERE ';
  strSql := strSql + '    FIS_CODEMP = :CODEMP ';
  strSql := strSql + '    AND (FIS_ESPDOC = "NF" OR FIS_ESPDOC = "EL")' ;
  strSql := strSql + '    AND ( (CLI_CODCLI = FIS_FORCLI) OR (FOR_CODFOR = FIS_FORCLI) ) ';
  strSql := strSql + '    AND ( (TRIM(IFNULL(FIS_SERIE_, "")) = "") OR ( (FIS_SERIE_ >= "001") AND (FIS_SERIE_ <= "999") ) ) ';
  strSql := strSql + '    AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + ' UNION ' + AnsiReplaceStr(AnsiReplaceStr(strSql, 'MOVDET', 'NOTDET'), 'MOVGER', 'NOTGER');

  strSql := strSql + '  )  '; // fechando o 1o. "SELECT"

  strSql := 'SELECT SQL_NO_CACHE * FROM (' + strSql + ' AS TAB ';

  strSql := strSql + '  GROUP BY FIS_CODITE ';

  strSql := strSql + '  ORDER BY ';
  strSql := strSql + '    FIS_CODITE ';

  qryDados.SQL.Clear;
  qrydados.SQL.Text := strSql;

  qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDados.ParamByName('DTAINI').AsDate   := FDtaIni;
  qryDados.ParamByName('DTAFIN').AsDate   := FDtaFin;

  qryDados.Open;
end;

procedure TSintegraNota.pDadosCabecalho;
  Var
    strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + ' E.*, ';
  strSQL := strSQL + ' CID.CID_NOMCID AS "EMP_NOMCID", ';
  strSQL := strSQL + ' CID.CID_ESTADO AS "EMP_ESTADO"  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADEMP E ';
  strSQL := strSQL + ' LEFT JOIN CADCID CID ON CID.CID_CODCID=EMP_CODCID ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   EMP_CODEMP = :CODEMP ';

  qryEmp.SQL.Text := strSql;

  qryEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryEmp.Open;
end;

procedure TSintegraNota.pGeraReg10;
  Var
    strLinha: String;
begin
  strReg90 := '90' +     fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_C_G_C_').AsString, True, True, True), 014);
  strReg90 := strReg90 + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_I_E_S_').AsString, True, True, True), 014);

  {***********************************************************************}
  {*                        GERA REGISTRO 10                             *}
  {**************************************************************** AM ***}
  intContaReg := 0; // INICIALIZA O CONTADOR GERAL DE REGISTROS
  intRegTotal := 1; // REGISTRO 10 E 11 SÃO CONTABILIZADOS NO TOTALIZADOR GERAL
  intContaReg90 := 1;
  strLinha := '10';
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_C_G_C_').AsString, True, True, True),    014); // CNPJ DA EMPRESA INFORMANTE

  If Trim(qryEmp.FieldByname('EMP_I_E_S_').AsString) <> '' Then
    strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_I_E_S_').AsString, True, True, True),  014) // I.E. DA EMPRESA INFORMANTE
  Else
    fMensagem('ATENÇÃO','Inscrição estadual não definida corretamente para "' +
                         qryEmp.FieldByname('EMP_NOMEMP').AsString + '" !', ['&Ok']);

  strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_NOMEMP').AsString),                035); // NOME DA EMPRESA INFORMANTE
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_NOMCID').AsString),                030); // NOME DA CIDADE DA EMPRESA INFORMANTE
  strLinha := strLinha + fPadR(qryEmp.FieldByname('EMP_ESTADO').AsString,                                     002); // UF DA CIDADE DA EMPRESA INFORMANTE
  strLinha := strLinha + fStrZero(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_F_A_X_').AsString, True, True, True), 010); // FAX DA EMPRESA INFORMANTE
  strLinha := strLinha + fPadR(FormatDateTime('yyyymmdd',FDtaIni),                                            008); // DATA INICIAL DO PERÍODO GERAL
  strLinha := strLinha + fPadR(FormatDateTime('yyyymmdd',FDtaFin),                                            008); // DATA FINAL DO PERÍODO GERAL
  strLinha := strLinha + '3';
  strLinha := strLinha + '3';
  strLinha := strLinha + '1';

  stlArquivo.Add(strLinha);

end;

procedure TSintegraNota.pGeraReg11;
  Var
    strLinha: String;
begin
  intRegTotal := intRegTotal + 1; // INCREMENTA O CONTADOR GERAL DE REGISTROS
  strLinha := '11';
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_ENDERE').AsString),               034); // ENDERECO. DA EMPRESA INFORMANTE
  strLinha := strLinha + fStrZero(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_ENDNUM').AsString, True, True, True),005); // NUMERO DO ENDERECO
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_ENDCMP').AsString),               022); // COMPLEMENTO DO ENDERECO DA EMPRESA INFORMANTE
  strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_BAIRRO').AsString),               015); // BAIRRO DA EMPRESA INFORMANTE
  strLinha := strLinha + fStrZero(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_C_E_P_').AsString, True, True, True),008); // CEP DA EMPRESA INFORMANTE
  If Trim(qryEmp.FieldByname('EMP_CONTAT').AsString) <> '' Then
    strLinha := strLinha + fPadR(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_CONTAT').AsString, True, True, True), 028)  // CONTATO DA EMPRESA INFORMANTE
  Else
    strLinha := strLinha + fPadR('NÃO INFORMADO',                                                            028); // CONTATO DA EMPRESA INFORMANTE

  strLinha := strLinha + fStrZero(fTiraCaracEspeciais(qryEmp.FieldByname('EMP_FONE01').AsString, True, True, True),012); // TELEFONES DO CONTATO DA EMPRESA INFORMANTE

  stlArquivo.add(strLinha);
end;

procedure TSintegraNota.pGeraReg50;
  Var
    strLinha: String;
    i,j,n: integer;

    arrCfop: array [1..5] of string;
    arrValCon: array [1..5] of Double;
    arrVlrIcm: array [1..5] of Double;
    arrBasIcm: array [1..5] of Double;
    arrBasIpi: array [1..5] of Double;
    arrVlrIpi: array [1..5] of Double;
begin
  pCarregaDadosReg50;

  strLinha := '';

  With qryDados Do
  Begin
    While Not Eof Do
    Begin
      n := 1; // contador dos diferentes CFOP(s) + ALIQ da nota
      arrCfop[1] := FieldByName('FIS_CLFSC1').AsString + FieldByName('FIS_ALQIC1').AsString;
      For i:=2 to 5 do // varre e carrega todos os CFOP(s) existentes na nota
      Begin
        If Not fEmptyStr(FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString {+
                             FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString}) Then
        Begin
          If arrCfop[i] <> (FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString +
                             FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString) Then
          Begin
            arrCfop[i] := (FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString  +
                             FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString);
            n := n + 1;
          End;
        End;
      End;

      // soma todos os valores de um mesmo CFOP com possíveis aliquotas diferentes
      For i:=1 to n do
      Begin
        For j:=i to n do
        Begin
          If arrCfop[i] = (FieldByName('FIS_CLFSC'+ IntToStr(j)).AsString  +
                           FieldByName('FIS_ALQIC'+ IntToStr(j)).AsString) Then
          Begin
            arrValCon[i]  := arrValCon[i] + FieldByName('FIS_VLCON'+  IntToStr(j)).AsFloat;
            arrVlrIcm[i]  := arrVlrIcm[i] + FieldByName('FIS_VLRIC'+  IntToStr(j)).ASFloat;
            arrBasIcm[i]  := arrBasIcm[i] + FieldByName('FIS_BASIC'+  IntToStr(j)).ASFloat;
            arrBasIpi[i]  := arrBasIpi[i] + FieldByName('FIS_BASIP'+  IntToStr(j)).ASFloat;
            arrVlrIpi[i]  := arrVlrIpi[i] + FieldByName('FIS_VLRIP'+  IntToStr(j)).ASFloat;
          End;
        End;
      End;

      i := 1;  // esta variável irá fazer o looping de leitura dos CFOP(s) do registro

      // irá rodar conforme a qtde de CFOP(S) encontrados na nota
      While i <= n do  // roda segundo a qtde de CFOP(s) da nota (n)
      Begin

        intContaReg := intContaReg + 1; // INCREMENTA O CONTADOR GERAL DE REGISTROS

        // 01 - IDENTIFICACAO DO REGISTRO
        strLinha := '50';
        // 02 - CNPJ/CPF - NUMERICO (014)
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_C_G_C_').AsString,True,True, True),014);
        // 03 - INSCRICAO ESTADUAL - ALFANUMERICO (014)
        strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('FIS_I_E_S_').AsString,True,True, True),014);
        // 04 - DATA DO DOCUMENTO - ALFANUMERICO (008)
        strLinha := strLinha + fstrZero(FormatDateTime('yyyymmdd', FieldByName('FIS_DTAENT').AsDateTime),008);
        // 05 - UF (ESTADO) - ALFANUMERICO (002)
        strLinha := strLinha + fPadR(FieldByName('FIS_ESTADO').AsString,002);
        {**************************************************************************}
        {* TIPO DE DOCUMENTO FISCAL CONFORME TABELA DE DOCUMENTOS FISCAIS         *}
        {* DO CONVÊNIO 57/95 ITEM 3.3 QUADRO III NOTAS FISCAIS DE ENTRADA E SAÍDA *}
        {********************************************************************* AM *}
        // 06 - MODELO DE DOCUMENTO FISCAL - ALFANUMERICO (002)
        strLinha := strLinha + '01';
        // 07 - SÉRIE DO DOCUMENTO FISCAL - ALFANUMERICO (003)
        strLinha := strLinha + fPadR(FieldByName('FIS_SERIE_').AsString,003);
        // 08 - NUMERO DO DOCUMENTO FISCAL - ALFANUMERICO (006)
        strLinha := strLinha + fStrZero(RightStr(fTiraCaracEspeciais(FieldByName('FIS_NUMDOC').AsString, True, True, True), 006), 006);
        // 09 - CFOP - ALFANUMERICO (004)
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(Copy(arrCfop[i],1,4)),004);
        // 10 - EMITENTE DA NOTA FISCAL (T) OU (P) - ALFANUMERICO (001)
        strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('EMITENTE').AsString,True,True, True),001);

        // 11 - VALOR TOTAL DO CFOP - NUMERICO (013) => CAMPOS FIS_VLCON1,2,3,4,5
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(arrValCon[i],11,2),True,True, True),013);
        // 12 - BASE CALC ICMS DO CFOP - NUMERICO (013) => CAMPOS FIS_BASIC1,2,3,4,5
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FloatToSTr(arrBasIcm[i]),True,True, True),013);
        // 13 - VALOR DO ICMS DO CFOP - NUMERICO (013) => CAMPOS FIS_VLRIC1,2,3,4,5
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FloatToSTr(arrVlrIcm[i]),True,True, True),013);

        // 14 - VALOR ISENTAS ICMS - NUMERICO (013)
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('ISENTAS').AsString,True,True, True),013);
        // 15 - VALOR OUTRAS - NUMERICO (013)
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('OUTRAS').AsString,True,True, True),013);

        // 16 - ALIQUOTA DE ICMS CADA CFOP - NUMERICO (004)
        strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_ALQIC'+ IntToStr(i)).AsFloat, 4, 2), True, True), 004);
        // 17 - SITUAÇÃO DA NOTA FISCAL  - ALFANUMERICO (001) (S)im OU (N)ão
        strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('SITUACAO').AsString,True,True, True),001);

        stlArquivo.Add(strLinha);
        strLinha := '';
        i := i + 1;
      End;
      // LIMPA OS VETORES
      For i:=1 to n do
      Begin
        arrCfop[i]    := '';
        arrValCon[i]  := 0;
        arrVlrIcm[i]  := 0;
        arrBasIcm[i]  := 0;
      End;

      Next;
    End;
    pGeraReg90(50, intContaReg);
  End;
end;

procedure TSintegraNota.pGeraReg51;
  Var
    i,n: integer;
    arrCfop: Array [1..5] Of String;
    strLinha: String;
begin
  pCarregaDadosReg51;

  strLinha := '';
  intContaReg := 0;

  with qryDados do
  Begin
    While Not Eof Do
    Begin
      n := 1; // contador da qtde de CFOP(s) + ALIQ da nota
      arrCfop[1] := FieldByName('FIS_CLFSC1').AsString + FieldByName('FIS_ALQIC1').AsString;
      For i:=2 to 5 do // varre e carrega todos os CFOP(s) existentes na nota
      Begin
        If Not fEmptyStr(FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString{ +
                             FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString}) Then
        Begin
          If arrCfop[i] <> (FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString +
                             FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString) Then
          Begin
            arrCfop[i] := (FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString  +
                             FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString);
            n := n + 1;
          End;
        End;
      End;

      i := 1;  // esta variável irá fazer o looping de leitura dos CFOP(s) do registro

      // irá rodar conforme a qtde de CFOP(S) encontrados na nota
      While i <= n do  // roda segundo a qtde de CFOP(s) da nota (n)
      Begin
        If FieldByName('FIS_VLRIP'+  IntToStr(i)).ASFloat > 0 Then
        Begin

          intContaReg := intContaReg + 1; // INCREMENTA O CONTADOR GERAL DE REGISTROS

          // 01 - IDENTIFICACAO DO REGISTRO
          strLinha := '51';
          // 02 - CNPJ/CPF - NUMERICO (014)
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_C_G_C_').AsString,True,True, True),014);
          // 03 - INSCRICAO ESTADUAL - ALFANUMERICO (014)
          strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('FIS_I_E_S_').AsString,True,True, True),014);
          // 04 - DATA DO DOCUMENTO - ALFANUMERICO (008)
          strLinha := strLinha + fstrZero(FormatDateTime('yyyymmdd', FieldByName('FIS_DTAENT').AsDateTime),008);
          // 05 - UF (ESTADO) - ALFANUMERICO (002)
          strLinha := strLinha + fPadR(FieldByName('FIS_ESTADO').AsString,002);
          // 06 - SÉRIE DO DOCUMENTO FISCAL - ALFANUMERICO (003)
          strLinha := strLinha + fPadR(FieldByName('FIS_SERIE_').AsString,003);
          // 07 - NUMERO DO DOCUMENTO FISCAL - ALFANUMERICO (006)
          strLinha := strLinha + fStrZero(RightStr(fTiraCaracEspeciais(Trim(FieldByName('FIS_NUMDOC').AsString),True,True, True), 006), 006);
          // 08 - CFOP - ALFANUMERICO (004)
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(Copy(arrCfop[i],1,4)),004);
          // 09 - VALOR TOTAL DO CFOP - NUMERICO (013) => CAMPOS FIS_VLCON1,2,3,4,5
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_VLCON'+  IntToStr(i)).ASFloat,11,2),True,True, True),013);
          // 10 - VALOR IPI DO CFOP - NUMERICO (013) => CAMPOS FIS_VLRIP1,2,3,4,5
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_VLRIP'+  IntToStr(i)).ASFloat,11,2),True,True, True),013);
          // 11 - VALOR ISENTAS IPI - NUMERICO (013)
          strLinha := strLinha + fStrZero('',013); // NÃO HÁ MAIS ISENTAS DE IPI SEGUNDO MARIO
          // 12 - VALOR OUTRAS IPI - NUMERICO (013)// 24/08/2009
          strLinha := strLinha + fStrZero('',013); // NÃO HÁ MAIS OUTRAS DE IPI SEGUNDO MARIO
          // 13 - BRANCOS - ALFANUMERICO (020)
          strLinha := strLinha + fPadR('',020,' ');
          // 14 - SITUAÇÃO DA NOTA FISCAL  - ALFANUMERICO (001) (S)im OU (N)ão
          strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('SITUACAO').AsString,True,True),001);

          stlArquivo.Add(strLinha);
          strLinha := '';
        End;
        i := i + 1;
      End;
      // LIMPA OS VETORES
      For i:=1 to n do
      Begin
        arrCfop[i] := '';
      End;
      Next;
    End;
    pGeraReg90(51, intContaReg);
  End;
end;

procedure TSintegraNota.pGeraReg53;
  Var
    i,n: integer;
    arrCfop: array [1..5] of string;
    strLinha: String;
begin
  pCarregaDadosReg53;

  strLinha := '';
  intContaReg := 0;

  With qryDados Do
  Begin
    While Not Eof Do
    Begin
      n := 1; // contador da qtde de CFOP(s) + ALIQ da nota
      arrCfop[1] := FieldByName('FIS_CLFSC1').AsString + FieldByName('FIS_ALQIC1').AsString;
      For i:=2 to 5 do // varre e carrega todos os CFOP(s) existentes na nota
      Begin
        If Not fEmptyStr(FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString) Then
        Begin
          If arrCfop[i] <> (FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString +
                            FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString) Then
          Begin
            arrCfop[i] := (FieldByName('FIS_CLFSC'+ IntToStr(i)).AsString  +
                           FieldByName('FIS_ALQIC'+ IntToStr(i)).AsString);
            n := n + 1;
          End;
        End;
      End;

      i := 1;

      // irá rodar conforme a qtde de CFOP(S) encontrados na nota
      While i <= n Do  // roda segundo a qtde de CFOP(s) da nota (n)
      Begin
        If (FieldByName('FIS_RETID' +  IntToStr(i)).ASFloat > 0) And
           (FieldByName('FIS_BCRET' +  IntToStr(i)).ASFloat > 0) Then
        Begin

          intContaReg := intContaReg + 1; // INCREMENTA O CONTADOR GERAL DE REGISTROS

          // 01 - IDENTIFICACAO DO REGISTRO
          strLinha := '53';
          // 02 - CNPJ/CPF - NUMERICO (014)
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_C_G_C_').AsString,True,True, True),014);
          // 03 - INSCRICAO ESTADUAL - ALFANUMERICO (014)
          strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('FIS_I_E_S_').AsString,True,True, True),014);
          // 04 - DATA DO DOCUMENTO - ALFANUMERICO (008)
          strLinha := strLinha + fstrZero(FormatDateTime('yyyymmdd', FieldByName('FIS_DTAENT').AsDateTime),008);
          // 05 - UF (ESTADO) - ALFANUMERICO (002)
          strLinha := strLinha + fPadR(FieldByName('FIS_ESTADO').AsString,002);
          {**************************************************************************}
          {* TIPO DE DOCUMENTO FISCAL CONFORME TABELA DE DOCUMENTOS FISCAIS         *}
          {* DO CONVÊNIO 57/95 ITEM 3.3 QUADRO III NOTAS FISCAIS DE ENTRADA E SAÍDA *}
          {********************************************************************* AM *}
          // 06 - MODELO DE DOCUMENTO FISCAL - ALFANUMERICO (002)
          strLinha := strLinha + '01';
          // 07 - SÉRIE DO DOCUMENTO FISCAL - ALFANUMERICO (003)
          strLinha := strLinha + fPadR(FieldByName('FIS_SERIE_').AsString,003);
          // 08 - NUMERO DO DOCUMENTO FISCAL - ALFANUMERICO (006)
          strLinha := strLinha + fStrZero(RightStr(fTiraCaracEspeciais(FieldByName('FIS_NUMDOC').AsString,True,True, True), 006), 006);
          // 09 - CFOP - ALFANUMERICO (004)
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(Copy(arrCfop[i],1,4)),004);
          // 10 - EMITENTE DA NOTA FISCAL (T) OU (P) - ALFANUMERICO (001)
          strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('EMITENTE').AsString,True,True, True),001);
          // 11 - BASE CALC ICMS DO CFOP - NUMERICO (013) => CAMPOS FIS_BCRET1,2,3,4,5
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_BCRET'+  IntToStr(i)).ASFloat,11,2),True,True, True),013);
          // 12 - VALOR DO ICMS RETIDO DO CFOP - NUMERICO (013) => CAMPOS FIS_FIS_RETID1,2,3,4,5
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_RETID'+  IntToStr(i)).ASFloat,11,2),True,True, True),013);
          // 13 - DESP. ACESSORIAS DO CFOP - NUMERICO (013) => CAMPOS FIS_DACES1,2,3,4,5
          strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_DACES'+  IntToStr(i)).ASFloat,11,2),True,True, True),013);
          // 14 - SITUAÇÃO DA NOTA FISCAL  - ALFANUMERICO (001) (S)im OU (N)ão
          strLinha := strLinha + fPadR(fTiraCaracEspeciais(FieldByName('SITUACAO').AsString,True,True, True),001);
          // 15 - CÓDIGO DE ANTECIPACAO TRIBUTARIA - BRANCO - ALFANUMERICO (001)
          strLinha := strLinha + fPadR('',001,' ');
          // 16 - BRANCOS - ALFANUMERICO (029)
          strLinha := strLinha + fPadR('',029,' ');

          stlArquivo.Add(strLinha);
        End;
        
        strLinha := '';
        i := i + 1;
      End;
      // LIMPA OS VETORES
      For i:=1 To n Do
      Begin
        arrCfop[i] := '';
      End;
      Next;
    End;
    pGeraReg90(53, intContaReg);
  End;
end;

procedure TSintegraNota.pGeraReg54;
  Var
    i: integer;
    strLinha,
    strNumDoc,
    strSerie_,
    strC_G_C_: String;
begin
  pCarregaDadosReg54;

  strLinha := '';
  i := 1;
  intContaReg := 0;

  with qryDados do
  Begin

    strNumDoc := FieldByName('FIS_NUMDOC').AsString;
    strSerie_ := FieldByName('FIS_SERIE_').AsString;
    strC_G_C_ := FieldByName('FIS_C_G_C_').AsString;

    While Not Eof Do
    Begin

      intContaReg := intContaReg + 1; // INCREMENTA O CONTADOR GERAL DE REGISTROS

      // 01 - IDENTIFICACAO DO REGISTRO
      strLinha := '54';
      // 02 - CNPJ/CPF - NUMERICO (014)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_C_G_C_').AsString,True,True, True),   014);
      {**************************************************************************}
      {* TIPO DE DOCUMENTO FISCAL CONFORME TABELA DE DOCUMENTOS FISCAIS         *}
      {* DO CONVÊNIO 57/95 ITEM 3.3 QUADRO III NOTAS FISCAIS DE ENTRADA E SAÍDA *}
      {********************************************************************* AM *}
      // 03 - MODELO DE DOCUMENTO FISCAL - ALFANUMERICO (002)
      strLinha := strLinha + fPadR(FieldByName('FIS_MODELO').AsString,                                                                   002);
      // 04 - SÉRIE DO DOCUMENTO FISCAL - ALFANUMERICO (003)
      strLinha := strLinha + fPadR(FieldByName('FIS_SERIE_').AsString,                                                               003);
      // 05 - NUMERO DO DOCUMENTO FISCAL - ALFANUMERICO (006)
      strLinha := strLinha + fStrZero(RightStr(fTiraCaracEspeciais(FieldByName('FIS_NUMDOC').AsString, True, True, True), 006), 006);
      // 06 - CFOP - ALFANUMERICO (004)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_CLAFIS').AsString, True, True, True),                           004);
      // 07 - CST DO PRODUTO - ALFANUMERICO (003)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_CODFIS').AsString, True, True, True),                           003);
      // 08 - NÚMERO DO ITEM NA NOTA (ORDEM) - NUMERICO (003)
      strLinha := strLinha + fStrZero(IntToStr(i),                                                                                   003);
      // 09 - CODIGO DO ITEM - ALFANUMERICO (014)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_CODITE').AsString, True, True, True),                            014);
      // 10 - QUANTIDADE - NUMERICO (011)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_QTDITE').ASFloat,11,3), True, True, True),     011);
      // 11 - VALOR DO PRODUTO - NUMERICO (012)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_VLRCON').ASFloat,12,2), True, True, True),     012);
      // 12 - VALOR DO DESCONTO/DESP.ACESSORIA - NUMERICO (012)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_DESCON').ASFloat,12,2), True, True, True),     012);
      // 13 - BASE CALC. ICMS - NUMERICO (012)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_BASICM').ASFloat,12,2), True, True, True),     012);
      // 14 - BASE CALC. ICMS SUBST.TRIBUT - NUMERICO (012)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_BASRET').ASFloat,12,2), True, True, True),     012);
      // 15 - VALOR IPI - NUMERICO (012)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_VALIPI').ASFloat,12,2), True, True, True),     012);
      // 16 - ALIQUOTA ICMS - NUMERICO (004)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_ALQICM').ASFloat,04,2), True, True, True),     004);

      stlArquivo.Add(strLinha);
      strLinha := '';

      Next;

      If (FieldByName('FIS_NUMDOC').AsString = strNumDoc) And
         (FieldByName('FIS_SERIE_').AsString = strSerie_) And
         (FieldByName('FIS_C_G_C_').AsString = strC_G_C_) And
         (i <= 990)                                      Then
      Begin
        i := i + 1  // conta os itens de cada nota
      End
      Else
      Begin
        strNumDoc := FieldByName('FIS_NUMDOC').AsString;
        strSerie_ := FieldByName('FIS_SERIE_').AsString;
        strC_G_C_ := FieldByName('FIS_C_G_C_').AsString;
        i := 1;
      End;
    End;
    pGeraReg90(54, intContaReg);
    qryDados.Close;
  End;

end;

procedure TSintegraNota.pGeraReg75;
  Var
    i: Integer;
    strLinha,
    strNumDoc: String;
begin
  pCarregaDadosReg75;

  strLinha := '';
  i := 1;
  intContaReg := 0;

  qryDados.Open;

  with qryDados do
  Begin

    strNumDoc := FieldByName('FIS_NUMDOC').AsString;

    While Not Eof Do
    Begin

      intContaReg := intContaReg + 1; // INCREMENTA O CONTADOR GERAL DE REGISTROS

      // 01 - IDENTIFICACAO DO REGISTRO
      strLinha := '75';
      // 02 - DATA INICIAL - NUMERICO (008)
      strLinha := strLinha + fPadR(FormatDateTime('yyyymmdd',FDtaIni),                                                               008); // DATA INICIAL DO PERÍODO GERAL
      // 03 - DATA FINAL - NUMERICO (008)
      strLinha := strLinha + fPadR(FormatDateTime('yyyymmdd',FDtaIni),                                                               008); // DATA FINAL DO PERÍODO GERAL
      // 04 - CODIGO PRODUTO/SERVICO - ALFA (014)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(FieldByName('FIS_CODITE').AsString,True,True, True),                             014);
      // 05- CODIGO NCM/CLASSIFICACAO IPI - ALFANUMERICO (008)
      strLinha := strLinha + fPadR(fStrZero(FieldByName('FIS_CLAIPI').AsString, 008),                                                008);
      // 06 - DESCRICAO DO PRODUTO - ALFANUMERICO (053)
      strLinha := strLinha + fPadR(Copy(FieldByName('FIS_DESITE').AsString,01,53),                                                   053);
      // 07 - UNIDADE DE MEDIDA DE COMERCIALIZACAO - ALFANUMERICO (006)
      strLinha := strLinha + fPadR(FieldByName('FIS_UNIDAD').AsString,                                                               006);
      // 08 - ALIQUOTA DE IPI - NUMERICO (005)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_ALQIPI').AsFloat,05,2), True, True, True),     005);
      // 09 - ALIQUOTA DE ICMS - NUMERICO (004)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_ALQICM').AsFloat,04,2), True, True, True),     004);
      // 10 - REDUCAO DA BASE DE CALC ICMS - NUMERICO (005)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_PERRED').AsFloat,05,2), True, True, True),     005);
      // 11 - BASE DE CALC ICMS SUBST TRIB - NUMERICO (013)
      strLinha := strLinha + fStrZero(fTiraCaracEspeciais(fFloatToStrPonto(FieldByName('FIS_BASRET').AsFloat,13,2), True, True, True),     013);

      stlArquivo.Add(strLinha);
      strLinha := '';

      Next;

      If (FieldByName('FIS_NUMDOC').AsString = strNumDoc) And (i <= 990) Then
      Begin
        i := i + 1  // conta os itens de cada nota
      End
      Else
      Begin
        strNumDoc := FieldByName('FIS_NUMDOC').AsString;
        i := 1;
      End;
    End;

    pGeraReg90(75, intContaReg);

  End;

  qryDados.Close;
end;

procedure TSintegraNota.pGeraReg90(intReg: integer = 0; intContaReg: integer = 0);
begin
  {*******************************************}
  {*                LEGENDA                  *}
  {* intReg = identificador do registro      *}
  {* intContaReg = qtde de registros         *}
  {* intContaReg90 = qtde de Reg tipo 90     *}
  {*                                         *}
  {*************************27/08/09**** AM **}

  If (intReg > 9) And (intContaReg > 0) Then
  Begin
    intRegTotal := intRegTotal + intContaReg;

    {********************************************************************}
    {* AVALIA SE AINDA CABE NA LINHA 90 MAIS UMA TOTALIZACAO COM        *}
    {* TIPO DE REGISTRO (2 DIG.) E A QUANTIDADE DE REGISTROS (8 DIG.)   *}
    {************************************************************** AM **}

    If Length(strReg90) + 10 <  125 * intContaReg90 Then
    Begin
      strReg90 := StrReg90 + fStrZero(IntToStr(intReg),002) + fStrZero(IntToStr(intContaReg),008);
    End
    Else
    Begin
      {****************************************************}
      {* ENCERRA 1 REG TIPO 90 E CRIA UM NOVO REG TIPO 90 *}
      {* COM AS 30 PRIMEIRAS POSICOES DO ANTERIOR         *}
      {*********************************27/08/09****** AM *}
      // GERA QUEBRA NO REGISTRO TIPO 90 PORQUE ULTRAPASSOU MULTIPLOS DE 126
      strReg90 := fPadR(Trim(StrReg90),(intContaReg90 * 126)-1) + '*';

      intContaReg90 := intContaReg90 + 1;

      // APLICANDO A TOTALIZACAO DO TIPO PENDENTE NO NOVO REGISTRO 90
      strReg90 := strReg90 + Copy(strReg90,001,030) +
           fStrZero(IntToStr(intReg),002) + fStrZero(IntToStr(intContaReg),008);

    End;
    {***********************************************************}
    {*  APÓS A INSERCAO CONTADOR DO TIPO 99 ENCERRA O ARQUIVO  *}
    {*  SUBSTITUINDO O VALOR DA POSICAO 126 (QTDE DE REGISTROS *}
    {*  TIPO 90).                                              *}
    {****************************************28/08/09****** AM *}
    If intReg = 99 Then
    Begin
      If intContaReg90 = 1 Then
      Begin
        strReg90 := fPadR(StrReg90,125) + IntToStr(intContaReg90);
        stlArquivo.Add(strReg90);
      End
      Else
      Begin
        strReg90 := fPadR(StrReg90,(126*intContaReg90)-1 ) + '*';

        strReg90 := AnsiReplaceText(strReg90, '*', IntToStr(intContaReg90) + #13 );

        stlArquivo.Add(strReg90);
      End;
    End;
  End;
end;

procedure TSintegraNota.pGerarSintegra;
  Var
    strPath: String;
begin
  stlArquivo.Clear;
  
  pDadosCabecalho;
  pGeraReg10;
  pGeraReg11;
  pGeraReg50;
  pGeraReg51;
  pGeraReg53;
  pGeraReg54;
  pGeraReg75;
  pGeraReg90(99, intRegTotal + intContaReg90);

  strPath := ExtractFilePath(Application.ExeName) + 'PAF\';

  If Not DirectoryExists(strPath) Then
  Begin
    CreateDir(strPath);
  End;

  stlArquivo.SaveToFile(strPath + '\' + 'SINTEGRA_NOTAS.TXT');
end;

end.
