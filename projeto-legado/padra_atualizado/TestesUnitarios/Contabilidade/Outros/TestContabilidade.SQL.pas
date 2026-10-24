unit TestContabilidade.SQL;

interface

uses
  TestFramework, Contabilidade.SQL, Contabilidade.Interfaces,
  Contabilidade.Classes.TTrataIncDoc;

type
  TestContabilidadeSQL = class(TTestCase)
  strict private
    function fGetSQLMovimentoBancarioTest(strCodEmp: string; blnAplicarFiltroContraPartida: boolean; strIncDoc: string; arrIncDoc: TArrIncDoc; blnFiltrarPeriodo: boolean = false): string;
    function fGetSQLMovimentoContasReceberTest(recParams: TParamsContasReceber): string;
    function fEmpresaGeracao(strAliasComPonto: String; recParams: TParamsContasReceber): string;
    function fSQLContaBandeiraCTR(strCampoSeqCon, strCampoCodEmp: String; blnBanNcoExiste: boolean): string;
    function fSQLCodigoBandeiraCTR(strCampoSeqCon, strCampoCodEmp: String; blnBanNcoExiste: boolean): string;
    function fGetSQLMovimentoCreditoClienteTest(recParams: TParamsContasReceber; const AstrNomeTabela: String): string;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSQLMovimentoBancarioEmpresaVazia;
    procedure TestSQLMovimentoBancarioEmpresaPreenchida;
    procedure TestSQLMovimentoBancarioEmpresaPreenchidaDataPreenchidaIncDocPreenchido;

    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe_CTR_DTABAN_Existe_POR_TITPDD_ExistePeriodo;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe_CTR_DTABAN_Existe_POR_TITPDD_ExistePeriodo_ComAg;

    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe_CTR_CREDIT_existe;

    procedure TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPNaoExiste_CFG_EXCREPNao;
    procedure TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPNaoExiste_CFG_EXCREPSim;
    procedure TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPExiste_CFG_EXCREPNao;
    procedure TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPExiste_CFG_EXCREPSim;
    procedure TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPNaoExiste_CFG_EXCREPNao;
    procedure TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPNaoExiste_CFG_EXCREPSim;
    procedure TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPExiste_CFG_EXCREPNao;
    procedure TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPExiste_CFG_EXCREPSim;
    procedure TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_CTRAGRSim;

    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe_CTR_DTABAN_Existe_Periodo;
    procedure TestSQLMovimentoContasReceber_EmpresaPreenchida_PeriodoPreenchido_IncDocPreenchido;
  end;

implementation

uses SysUtils, strUtils;

{ TestContabilidadeSQL }

function TestContabilidadeSQL.fGetSQLMovimentoContasReceberTest(recParams: TParamsContasReceber): string;

  function fModJur(strMod: String): String;
  begin
    Result := ' ROUND(((' + strMod + ' / IFNULL(CTR.CTR_VALREC, 0)) * IFNULL(CTR.CTR_VALJUR, 0)), 2)'; // AS CTR_DINJUR
  end;

  function fModOri(strMod: String): String;
  begin
    Result := ' ROUND((' + strMod + ' - ((' + strMod + ' / IFNULL(CTR.CTR_VALREC, 0)) * IFNULL(CTR.CTR_VALJUR, 0)) + ((' + strMod + ' / IFNULL(CTR.CTR_VALREC, 0)) * IFNULL(CTR.CTR_VALDES, 0))), 2)'; // AS CTR_DINORI
  end;

  function fModDes(strMod: String): String;
  begin
    Result := ' ROUND(((' + strMod + ' / IFNULL(CTR.CTR_VALREC, 0)) * IFNULL(CTR.CTR_VALDES, 0)), 2)'; // AS CTR_DINDES
  end;

  Var
    strSQL : String;
    strDesabilitaAGR : string;
begin
  strDesabilitaAGR := '' ;
  if recParams.blnDesabilitaAgrupamento then
  begin
    strDesabilitaAGR := ' AND FALSE ';
  end ;

  If recParams.blnCTR_RETBAN_Existe Then
    strSQL := strSQL + ' SELECT ROUND((IFNULL(CTR.CTR_DINHEI, 0) + IFNULL(CTR.CTR_RETBAN, 0)), 2) AS CTR_DINHEI, '
  Else
    strSQL := strSQL + ' SELECT ROUND((IFNULL(CTR.CTR_DINHEI, 0)), 2) AS CTR_DINHEI, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_CHQPRE, 0), 2) AS CTR_CHQPRE, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_CHQAVI, 0), 2) AS CTR_CHQAVI, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_CARTAO, 0), 2) AS CTR_CARTAO, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_ORDPAG, 0), 2) AS CTR_ORDPAG, ';
  strSQL := strSQL + fGetSQLCredito('        ROUND(IFNULL(CTR.CTR_CREDIT, 0), 2) AS CTR_CREDIT, ', recParams.blnCTR_CREDIT_Existe);

  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_VALORI, 0), 2) AS CTR_VALORI, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_VALORI, 0), 2) AS CTR_AGRORI, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_VALJUR, 0), 2) AS CTR_VALJUR, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_VALDES, 0), 2) AS CTR_VALDES, ';

  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_VALJUR, 0), 2) AS CTR_VPISRF, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_VALJUR, 0), 2) AS CTR_VCOFRF, ';

  if recParams.blnCTR_RETBAN_Existe then
    strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_DINHEI, 0) + IFNULL(CTR.CTR_RETBAN, 0), 2) AS CTR_PGTDIN, '
  else
    strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_DINHEI, 0), 2) AS CTR_PGTDIN, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_CHQPRE, 0), 2) AS CTR_PGTCHP, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_CHQAVI, 0), 2) AS CTR_PGTCHA, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_CARTAO, 0), 2) AS CTR_PGTCAR, ';
  strSQL := strSQL + '        ROUND(IFNULL(CTR.CTR_ORDPAG, 0), 2) AS CTR_PGTORP, ';
  strSQL := strSQL + fGetSQLCredito('        ROUND(IFNULL(CTR.CTR_CREDIT, 0), 2) AS CTR_PGTCRE, ', recParams.blnCTR_CREDIT_Existe) ;

  strSQL := strSQL + '        ' + fEmpresaGeracao('CTR.', recParams) + ' AS CODEMP, ';
  strSQL := strSQL + '        CTR.CTR_EMPBAI AS EMPBAI, ';
  strSQL := strSQL + '        CTR.CTR_CODEMP AS EMPCAD, ';

  If (recParams.blnCTR_DTABAN_Existe) Then
    strSQL := strSQL + '        CASE WHEN CTR.CTR_ADTCLI = "S" AND CTR.CTR_ESPDOC = "CC" THEN CTR.CTR_DTACAD ELSE IFNULL(CTR.CTR_DTABAN, CTR.CTR_DTAREC) END AS DTAENT, '
  Else
    strSQL := strSQL + '        CASE WHEN CTR.CTR_ADTCLI = "S" AND CTR.CTR_ESPDOC = "CC" THEN CTR.CTR_DTACAD ELSE CTR.CTR_DTAREC END AS DTAENT, ';


  strSQL := strSQL + '        CTR.CTR_DTACAD AS DTACAD, ';
  strSQL := strSQL + '        CTR.CTR_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '        CTR.CTR_CODEMP, ';
  strSQL := strSQL + '        CTR.CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '        CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '        CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '        "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODCON, PORBAI.POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODPOR, PORBAI.POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '        "" AS CLAFIS, ';

  If recParams.blnCTR_RETBAN_Existe Then
  Begin
    strSQL := strSQL + fModJur('(IFNULL(CTR.CTR_DINHEI, 0)+ IFNULL(CTR.CTR_RETBAN, 0))') + ' AS CTR_DINJUR, ';
    strSQL := strSQL + fModOri('(IFNULL(CTR.CTR_DINHEI, 0)+ IFNULL(CTR.CTR_RETBAN, 0))') + ' AS CTR_DINORI, ';
    strSQL := strSQL + fModDes('(IFNULL(CTR.CTR_DINHEI, 0)+ IFNULL(CTR.CTR_RETBAN, 0))') + ' AS CTR_DINDES, ';
  End
  Else
  Begin
    strSQL := strSQL + fModJur('(IFNULL(CTR.CTR_DINHEI, 0))') + ' AS CTR_DINJUR, ';
    strSQL := strSQL + fModOri('(IFNULL(CTR.CTR_DINHEI, 0))') + ' AS CTR_DINORI, ';
    strSQL := strSQL + fModDes('(IFNULL(CTR.CTR_DINHEI, 0))') + ' AS CTR_DINDES, ';
  End;

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CHQAVI, 0)') + ' AS CTR_CHAJUR, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CHQAVI, 0)') + ' AS CTR_CHAORI, ';
  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CHQAVI, 0)') + ' AS CTR_CHADES, ';

  if recParams.blnCTR_CREDIT_Existe then
  begin
    strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CREDIT, 0)') + ' AS CTR_CREJUR, ';
    strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CREDIT, 0)') + ' AS CTR_CREORI, ';
    strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CREDIT, 0)') + ' AS CTR_CREDES, ';
  end ;

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CHQPRE, 0)') + ' AS CTR_CHPJUR, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CHQPRE, 0)') + ' AS CTR_CHPORI, ';
  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CHQPRE, 0)') + ' AS CTR_CHPDES, ';

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CARTAO, 0)') + ' AS CTR_CARJUR, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CARTAO, 0)') + ' AS CTR_CARORI, ';
  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CARTAO, 0)') + ' AS CTR_CARDES, ';

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_ORDPAG, 0)') + ' AS CTR_ORDJUR, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_ORDPAG, 0)') + ' AS CTR_ORDORI, ';
  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_ORDPAG, 0)') + ' AS CTR_ORDDES, ';

  strSQL := strSQL + ' IFNULL(PORTIT.POR_EXPAUT, "S") AS POR_EXPAUT, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCON, CTABAI.CTA_PLANCO) AS CTA_PLANCO, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCTA, CTABAI.CTA_CODCTA) AS CODIGO_PLANO_CONTA_BAIXA, ';
  strSQL := strSQL + ' IF(CADFIS.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura") AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + ' IF(CADFIS.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura") AS TIPO_PAGAMENTO_CREDITO, ';
  strSQL := strSQL + ' CTR.CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCON, CADCTA2.CTA_PLANCO ) AS CODCTA, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCTA, CADCTA2.CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';

  //Buscar Cheque Recebido
  strSQL := strSQL + ' ( SELECT GROUP_CONCAT(CADCHQ.CHQ_NUMCHQ) ';
  strSQL := strSQL + '     FROM CADCHQ ';
  strSQL := strSQL + '    WHERE CADCHQ.CHQ_SEQCON = CTR.CTR_SEQCON ) AS CHQ_NUMCHQ, ';

  if (recParams.blnContaNaBandeiraExiste) then
  begin
    strSQL := strSQL + fSQLContaBandeiraCTR('CTR.CTR_SEQCON', 'CTR.CTR_EMPBAI', recParams.blnBanNcoExiste) + ' AS CONTA_BANDEIRA, ';
    strSQL := strSQL + fSQLCodigoBandeiraCTR('CTR.CTR_SEQCON', 'CTR.CTR_EMPBAI', recParams.blnBanNcoExiste) + ' AS CODIGO_BANDEIRA, ';
  end
  else
  begin
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS CONTA_BANDEIRA, ';
    strSQL := strSQL + ' CAST("" AS CHAR(1)) AS CODIGO_BANDEIRA, ';
  end;

  strSQL := strSQL + '    CTR.AUTOINCREM AS CTRINC, ';
  strSQL := strSQL + ' IFNULL(AGR.CTR_NUMDUP,"") AS DOCORI, ';
  strSQL := strSQL + ' IFNULL(AGR.CTR_ESPDOC,"") AS ESPORI,  ';
  strSQL := strSQL + ' IF(AGR2.CTR_NUMAGR IS NULL, IF(AGR.CTR_NUMAGR IS NULL, CTR.CTR_CODEVE, AGR.CTR_CODEVE), AGR2.CTR_CODEVE) AS CODEVE, ';
  strSQL := strSQL + '    CADEMP.EMP_NOMEMP AS NOMEMP, CTR.CTR_HIST01 AS HIST01, CTR.CTR_ADTCLI, ';
  strSQL := strSQL + ' IFNULL(MOVGER.GER_CONPAG, NOTGER.GER_CONPAG) AS CONDICAO_PAGTO, ';
  strSQL := strSQL + ' IFNULL(MOVGER.GER_CLAFIS, NOTGER.GER_CLAFIS) AS CLASSIFICACAO_FISCAL, ';
  strSQL := strSQL + ' "CADREC" AS TABELA, ';
  strSQL := strSQL + '    CTR.CTR_VALREC, ';
  if recParams.blnPOR_TITPDD_Existe then
    strSQL := strSQL + '   IFNULL(PORTIT.POR_TITPDD, "N") AS POR_TITPDD,  '
  else
    strSQL := strSQL + '  CAST("N" AS CHAR(1)) AS POR_TITPDD, ' ;

  strSQL := strSQL + '    IF(AGR3.CTR_NUMAGR IS NULL, IF(AGR2.CTR_NUMAGR IS NULL, AGR.AUTOINCREM, AGR2.AUTOINCREM), AGR3.AUTOINCREM) AS AGR_AUTOINCREM, ' ;
  strSQL := strSQL + '    ROUND(IFNULL(CTR.CTR_VALDES, 0), 2) AS CTR_VALDE2, ';
  strSQL := strSQL + '   (SELECT ADTCLI.ADT_CODEMP FROM ADTCLI WHERE ADTCLI.ADT_TIPLAN = "D" AND ADT_SEQCON = CTR.CTR_SEQCON AND ADT_CODCLI = CTR.CTR_CODCLI AND ADT_DTALAN = CTR.CTR_DTACAD AND ADT_EMPLAN = CTR.CTR_EMPBAI AND ADT_ESTORN = "N"  LIMIT 1) as EMPADT, ' ;
  strSQL := strSQL + '   CAST(NULL AS CHAR(20)) AS EMP_CGCADT, ';
  strSQL := strSQL + '   ROUND(IFNULL(CTR.CTR_VALJUR, 0), 2) AS CTR_VALJU2, ';
  strSQL := strSQL + '   PORTIT.POR_CODPOR AS CODIGO_PORTADOR_TIT, ';
  strSQL := strSQL + '   CTR.CTR_SEQCON, ';
  if recParams.blnDesabilitaAgrupamento then
  begin
    strSQL := strSQL + '   100 AS VALOR_PROPORCIONAL, ';
    strSQL := strSQL + '   100 AS VALOR_PROPORCIONAL_DESJUR, ';
  end
  else
  begin
    strSQL := strSQL + '  IF(AGR3.CTR_NUMDUP IS NOT NULL, ';
    strSQL := strSQL + '  ((COALESCE(AGR3.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR3.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) '+'FROM DUPAGR WHERE CTR_NUMAGR = AGR2.CTR_NUMDUP AND CTR_EMPAGR = AGR2.CTR_EMPAGR AND CTR_CODCLI = AGR2.CTR_CODCLI),1)))/100)*COALESCE(AGR.CTR_VALDUP,0.00), ';
    strSQL := strSQL + '  IF(AGR2.CTR_NUMDUP IS NOT NULL, ';
    strSQL := strSQL + '   ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) '+'FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)*COALESCE(AGR.CTR_VALDUP,0.00), ';
    strSQL := strSQL + '   ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, NULL,COALESCE(CTR_VALDUP, 0.00))) '+'FROM DUPAGR WHERE CTR_NUMDUP = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)*COALESCE(AGR.CTR_VALDUP,0.00) ';
    strSQL := strSQL + '   )) AS VALOR_PROPORCIONAL, ';

    strSQL := strSQL + '  IF(AGR3.CTR_NUMDUP IS NOT NULL, ';
    strSQL := strSQL + '  (((CASE WHEN COALESCE(AGR3.CTR_VALDUP,0.00) <= 0 THEN 0.00 ELSE COALESCE(AGR3.CTR_VALDUP,0.00) END)*100/(COALESCE((SELECT SUM(IF(AGR3.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) '+'FROM DUPAGR WHERE CTR_NUMAGR = AGR2.CTR_NUMDUP AND CTR_EMPAGR = AGR2.CTR_EMPAGR AND CTR_CODCLI = AGR2.CTR_CODCLI),1)))/100)*COALESCE(AGR.CTR_VALDUP,0.00), ';
    strSQL := strSQL + '  IF(AGR2.CTR_NUMDUP IS NOT NULL, ';
    strSQL := strSQL + '    (((CASE WHEN COALESCE(AGR2.CTR_VALDUP,0.00) <= 0 THEN 0.00 ELSE COALESCE(AGR2.CTR_VALDUP,0.00) END)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) '+'FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)*COALESCE(AGR.CTR_VALDUP,0.00), ';
    strSQL := strSQL + '    (((CASE WHEN COALESCE(AGR.CTR_VALDUP,0.00) <= 0 THEN 0.00 ELSE COALESCE(AGR.CTR_VALDUP,0.00) END)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, NULL, COALESCE(CTR_VALDUP, 0.00))) '+'FROM DUPAGR WHERE CTR_NUMDUP = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)*COALESCE(AGR.CTR_VALDUP,0.00) ';
    strSQL := strSQL + '   )) AS VALOR_PROPORCIONAL_DESJUR, ';
  end ;

  If recParams.blnCTR_RETBAN_Existe Then
  Begin
    strSQL := strSQL + fModJur('(IFNULL(CTR.CTR_DINHEI, 0)+ IFNULL(CTR.CTR_RETBAN, 0))') + ' AS CTR_DINJUR_CONF, ';
    strSQL := strSQL + fModOri('(IFNULL(CTR.CTR_DINHEI, 0)+ IFNULL(CTR.CTR_RETBAN, 0))') + ' AS CTR_DINORI_CONF, ';
    strSQL := strSQL + fModDes('(IFNULL(CTR.CTR_DINHEI, 0)+ IFNULL(CTR.CTR_RETBAN, 0))') + ' AS CTR_DINDES_CONF, ';
  End
  Else
  Begin
    strSQL := strSQL + fModJur('(IFNULL(CTR.CTR_DINHEI, 0))') + ' AS CTR_DINJUR_CONF, ';
    strSQL := strSQL + fModOri('(IFNULL(CTR.CTR_DINHEI, 0))') + ' AS CTR_DINORI_CONF, ';
    strSQL := strSQL + fModDes('(IFNULL(CTR.CTR_DINHEI, 0))') + ' AS CTR_DINDES_CONF, ';
  End;

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CHQAVI, 0)') + ' AS CTR_CHAJUR_CONF, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CHQAVI, 0)') + ' AS CTR_CHAORI_CONF, ';
  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CHQAVI, 0)') + ' AS CTR_CHADES_CONF, ';

  if recParams.blnCTR_CREDIT_Existe then
  begin
    strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CREDIT, 0)') + ' AS CTR_CREJUR_CONF, ';
    strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CREDIT, 0)') + ' AS CTR_CREORI_CONF, ';
    strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CREDIT, 0)') + ' AS CTR_CREDES_CONF, ';
  end ;

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CHQPRE, 0)') + ' AS CTR_CHPJUR_CONF, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CHQPRE, 0)') + ' AS CTR_CHPORI_CONF, ';
  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CHQPRE, 0)') + ' AS CTR_CHPDES_CONF, ';

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_CARTAO, 0)') + ' AS CTR_CARJUR_CONF, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_CARTAO, 0)') + ' AS CTR_CARORI_CONF, ';
  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_CARTAO, 0)') + ' AS CTR_CARDES_CONF, ';

  strSQL := strSQL + fModJur('IFNULL(CTR.CTR_ORDPAG, 0)') + ' AS CTR_ORDJUR_CONF, ';
  strSQL := strSQL + fModOri('IFNULL(CTR.CTR_ORDPAG, 0)') + ' AS CTR_ORDORI_CONF, ';

  strSQL := strSQL + 'CAST(IFNULL(CADCTA2.CTA_PROCON, "0") AS CHAR(1)) AS CTA_PROCON, ';

  if recParams.blnCfgCtrAgr then
  begin
    strSQL := strSQL + ' IF(AGR2.CTR_NUMAGR IS NULL, IF(AGR.CTR_NUMAGR IS NULL, NULL, AGR.CTR_CODEMP), AGR2.CTR_CODEMP) AS CDE_CODEMP, ';
    strSQL := strSQL + ' ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    strSQL := strSQL + ' ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end ;

  strSQL := strSQL + fModDes('IFNULL(CTR.CTR_ORDPAG, 0)') + ' AS CTR_ORDDES_CONF, ';

  strSQL := strSQL + ' EMPBAI.EMP_C_G_C_ AS EMP_CGCBAI, ';
  strSQL := strSQL + ' EMPCAD.EMP_C_G_C_ AS EMP_CGCCAD, ';
  strSQL := strSQL + ' CAST("N" AS CHAR(1)) AS ADT_CC ';

  strSQL := strSQL + '   FROM CADREC CTR ';
  strSQL := strSQL + '   JOIN CADEMP ON ' + fEmpresaGeracao('CTR.', recParams) + ' = EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADEMP AS EMPCAD ON CTR.CTR_CODEMP = EMPCAD.EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADEMP AS EMPBAI ON CTR.CTR_EMPBAI = EMPBAI.EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADPOR PORBAI ON PORBAI.POR_CODPOR = CTR.CTR_PORBAI ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CTABAI ON CTABAI.CTA_CODCTA = CTR.CTR_CTABAI ';

  strSQL := strSQL + '  LEFT JOIN CADPOR PORTIT ON CTR.CTR_CODPOR = PORTIT.POR_CODPOR ';

  strSQL := strSQL + '  LEFT JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ';
  strSQL := strSQL + '                      AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ';
  strSQL := strSQL + '                      AND AGR.CTR_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '                      AND CTR.CTR_ESPDOC = "AG" ' + strDesabilitaAGR;

  strSQL := strSQL + '  LEFT JOIN DUPAGR AGR2 ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ';
  strSQL := strSQL + '                       AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ';
  strSQL := strSQL + '                       AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ' + strDesabilitaAGR;

  strSQL := strSQL + '  LEFT JOIN DUPAGR AGR3 ON AGR3.CTR_NUMAGR = AGR2.CTR_NUMDUP ';
  strSQL := strSQL + '                       AND AGR3.CTR_EMPAGR = AGR2.CTR_CODEMP ';
  strSQL := strSQL + '                       AND AGR3.CTR_CODCLI = AGR2.CTR_CODCLI ' + strDesabilitaAGR;

  strSQL := strSQL + '  LEFT JOIN CADFIS ON FIS_NUMDOC = IF(CTR.CTR_ESPDOC = "AG" ' + strDesabilitaAGR + ', IF(AGR.CTR_ESPDOC = "AG", IF(AGR2.CTR_ESPDOC = "AG", AGR3.CTR_NUMDUP, AGR2.CTR_NUMDUP), AGR.CTR_NUMDUP), CTR.CTR_NUMDUP) ';
  strSQL := strSQL + '                  AND FIS_ESPDOC = IF(CTR.CTR_ESPDOC = "AG" ' + strDesabilitaAGR + ', IF(AGR.CTR_ESPDOC = "AG", IF(AGR2.CTR_ESPDOC = "AG", AGR3.CTR_ESPDOC, AGR2.CTR_ESPDOC), AGR.CTR_ESPDOC), CTR.CTR_ESPDOC) ';
  strSQL := strSQL + '                  AND FIS_CODEMP = IF(CTR.CTR_ESPDOC = "AG" ' + strDesabilitaAGR + ', IF(AGR.CTR_ESPDOC = "AG", IF(AGR2.CTR_ESPDOC = "AG", AGR3.CTR_CODEMP, AGR2.CTR_CODEMP), AGR.CTR_CODEMP), CTR.CTR_CODEMP) ';
  strSQL := strSQL + IfThen(recParams.blnDesconsiderarFiltroDataFaturaCTR, '', '                  AND FIS_DTAENT = IF(CTR.CTR_ESPDOC = "AG" ' + strDesabilitaAGR + ', IF(AGR.CTR_ESPDOC = "AG", IF(AGR2.CTR_ESPDOC = "AG", AGR3.CTR_DTACAD, AGR2.CTR_DTACAD), AGR.CTR_DTACAD), CTR.CTR_DTACAD) ');
  strSQL := strSQL + '                  AND FIS_FORCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '                  AND FIS_TIP_FC = "C" ';
  //strSQL := strSQL + '                  AND IFNULL(FIS_SERIE_,"") = IFNULL(P.CTP_SERIE_,"") ';

  strSQL := strSQL + '  LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '                  AND MOVGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '                  AND MOVGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                  AND MOVGER.GER_CODCLI = FIS_FORCLI ';
  strSQL := strSQL + '                  AND MOVGER.GER_SERIE_ = FIS_SERIE_ ';
  strSQL := strSQL + '                  AND MOVGER.GER_ORIDOC = FIS_ORIDOC ';

  strSQL := strSQL + '  LEFT JOIN NOTGER ON NOTGER.GER_NUMDOC = FIS_NUMDOC ';
  strSQL := strSQL + '                  AND NOTGER.GER_ESPDOC = FIS_ESPDOC ';
  strSQL := strSQL + '                  AND NOTGER.GER_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                  AND NOTGER.GER_CODCLI = FIS_FORCLI ';
  strSQL := strSQL + '                  AND NOTGER.GER_SERIE_ = FIS_SERIE_ ';
  strSQL := strSQL + '                  AND NOTGER.GER_ORIDOC = FIS_ORIDOC ';

  strSQL := strSQL + '  LEFT JOIN CADEMP ED ';
  strSQL := strSQL + '      ON IF( ';
  strSQL := strSQL + '        AGR3.CTR_NUMAGR IS NULL, ';
  strSQL := strSQL + '        IF( ';
  strSQL := strSQL + '          AGR2.CTR_NUMAGR IS NULL, ';
  strSQL := strSQL + '          IF( ';
  strSQL := strSQL + '            AGR.CTR_NUMAGR IS NULL, ';
  strSQL := strSQL + '            NULL, ';
  strSQL := strSQL + '            AGR.CTR_CODEMP ';
  strSQL := strSQL + '          ), ';
  strSQL := strSQL + '          AGR2.CTR_CODEMP ';
  strSQL := strSQL + '        ), ';
  strSQL := strSQL + '        AGR3.CTR_CODEMP ';
  strSQL := strSQL + '      ) = ED.EMP_CODEMP ';

  strSQL := strSQL + '  LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                  AND CLINCO.NCO_CODEMP = ' + IfThen(recParams.blnCfgCtrAgr, 'IF(AGR3.CTR_NUMAGR IS NULL, IF(AGR2.CTR_NUMAGR IS NULL, IF(AGR.CTR_NUMAGR IS NULL, ' + fEmpresaGeracao('CTR.', recParams) + ', AGR.CTR_CODEMP), AGR2.CTR_CODEMP), AGR3.CTR_CODEMP) ', fEmpresaGeracao('CTR.', recParams)) ;

  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = PORBAI.POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = ' + IfThen(recParams.blnCfgCtrAgr, 'IF(AGR3.CTR_NUMAGR IS NULL, IF(AGR2.CTR_NUMAGR IS NULL, IF(AGR.CTR_NUMAGR IS NULL, ' + fEmpresaGeracao('CTR.', recParams) + ', AGR.CTR_CODEMP), AGR2.CTR_CODEMP), AGR3.CTR_CODEMP) ', fEmpresaGeracao('CTR.', recParams)) ;

  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTABAI.CTA_CODCTA ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = ' + IfThen(recParams.blnCfgCtrAgr, 'IF(AGR3.CTR_NUMAGR IS NULL, IF(AGR2.CTR_NUMAGR IS NULL, IF(AGR.CTR_NUMAGR IS NULL, ' + fEmpresaGeracao('CTR.', recParams) + ', AGR.CTR_CODEMP), AGR2.CTR_CODEMP), AGR3.CTR_CODEMP) ', fEmpresaGeracao('CTR.', recParams)) ;

  //Buscar Contas Contábeis do Título
  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO2 ON CTANCO2.NCO_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '                           AND CTANCO2.NCO_CODEMP = ' + IfThen(recParams.blnCfgCtrAgr, 'IF(AGR3.CTR_NUMAGR IS NULL, IF(AGR2.CTR_NUMAGR IS NULL, IF(AGR.CTR_NUMAGR IS NULL, ' + fEmpresaGeracao('CTR.', recParams) + ', AGR.CTR_CODEMP), AGR2.CTR_CODEMP), AGR3.CTR_CODEMP) ', fEmpresaGeracao('CTR.', recParams)) ;
  strSQL := strSQL + '   LEFT JOIN CADCTA CADCTA2 ON CADCTA2.CTA_CODCTA = CTR.CTR_CODCTA ';

  strSQL := strSQL + '  WHERE TRUE AND CTR.CTR_ESPDOC NOT IN ("FF","TR","DV","MI") ';

  strSQL := strSQL + '  AND IFNULL(AGR.CTR_ESPDOC, "") NOT IN ("FF", "TR", "DV", "MI") ';

  If (Not recParams.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND ' + fEmpresaGeracao('CTR.', recParams) + ' = :CODEMP ';

  if (recParams.dtaDtaIni > 0) then
  begin
    If (recParams.blnCTR_DTABAN_Existe) Then
      strSQL := strSQL + '    AND IFNULL(CTR.CTR_DTABAN, CTR.CTR_DTAREC) BETWEEN :DTAINI AND :DTAFIN '
    Else
      strSQL := strSQL + '    AND CTR.CTR_DTAREC BETWEEN :DTAINI AND :DTAFIN ';
  end;

  strSQL := strSQL + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc('CTR.AUTOINCREM')
                        .fIncDoc(recParams.strIncDoc)
                        .fArrIncDoc(recParams.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  strSQL := strSQL + '  ORDER BY CTR.AUTOINCREM, AGR.CTR_VALDUP ASC ';

  Result := strSQL;
end;

function TestContabilidadeSQL.fGetSQLMovimentoCreditoClienteTest(recParams: TParamsContasReceber; const AstrNomeTabela: String): string;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT (IFNULL(CTR.CTR_GRVORI, 0))*-1 AS CTR_VALDUP, ';

  strSQL := strSQL + '        CTR.CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        CTR.CTR_DTACAD AS DTAENT, CTR.CTR_DTACAD AS DTACAD, ';
  strSQL := strSQL + '        CTR.CTR_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '        CTR.CTR_CODEMP, ';
  strSQL := strSQL + '        CTR.CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '        CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '        CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '        "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODCON, PORTIT.POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODPOR, PORTIT.POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '        "" AS CLAFIS, ';

  strSQL := strSQL + ' IFNULL(PORTIT.POR_EXPAUT, "S") AS POR_EXPAUT, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCON, CTABAI.CTA_PLANCO) AS CTA_PLANCO, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCTA, CTABAI.CTA_CODCTA) AS CODIGO_PLANO_CONTA_BAIXA, ';
  strSQL := strSQL + ' "Pagamentos Avulsos" AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + ' CTR.CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCON, CADCTA2.CTA_PLANCO) AS CODCTA, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCTA, CADCTA2.CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + ' "" AS CHQ_NUMCHQ, ';
  strSQL := strSQL + '    CTR.AUTOINCREM AS CTRINC, ';
  strSQL := strSQL + ' IFNULL(CTR.CTR_NUMDUP,"") AS DOCORI, ';
  strSQL := strSQL + ' IFNULL(CTR.CTR_ESPDOC,"") AS ESPORI,  ';
  strSQL := strSQL + ' CTR.CTR_CODEVE AS CODEVE, ';
  strSQL := strSQL + '    EMP_NOMEMP AS NOMEMP, CTR.CTR_HIST01 AS HIST01, "' + AstrNomeTabela + '" AS TABELA, ';
  strSQL := strSQL + '   PORTIT.POR_CODPOR AS CODIGO_PORTADOR_TIT, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_DINHEI, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_CHQPRE, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_CHQAVI, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_CARTAO, ';
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_ORDPAG, ';
  strSQL := strSQL + ' CAST("" AS CHAR(20)) AS CONTA_BANDEIRA, ' ;
  strSQL := strSQL + ' CAST("" AS CHAR(20)) AS CODIGO_BANDEIRA, ' ;
  strSQL := strSQL + ' CTR.CTR_ADTCLI, ' ;
  strSQL := strSQL + ' CAST(0.00 AS DECIMAL(14,2)) AS CTR_CREDIT, ' ;
  strSQL := strSQL + ' CTR.CTR_SEQBAI AS SEQBAI ' ;
  strSQL := strSQL + '   FROM ' + AstrNomeTabela + ' CTR ';
  strSQL := strSQL + '   JOIN CADEMP ON CTR.CTR_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CTABAI ON CTABAI.CTA_CODCTA = CTR.CTR_CTABAI ';

  strSQL := strSQL + '  LEFT JOIN CADPOR PORTIT ON CTR.CTR_CODPOR = PORTIT.POR_CODPOR ';

  strSQL := strSQL + '  LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                  AND CLINCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = PORTIT.POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTABAI.CTA_CODCTA ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  //Buscar Contas Contábeis do Título
  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO2 ON CTANCO2.NCO_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '                           AND CTANCO2.NCO_CODEMP = CTR.CTR_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CADCTA2 ON CADCTA2.CTA_CODCTA = CTR.CTR_CODCTA ';

  strSQL := strSQL + '  WHERE TRUE ';

  strSQL := strSQL + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc('CTR.AUTOINCREM')
                        .fIncDoc(recParams.strIncDoc)
                        .fArrIncDoc(recParams.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  If (Not recParams.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND CTR.CTR_CODEMP = :CODEMP ';

  strSQL := strSQL + '  AND CTR.CTR_ESPDOC = "CC" ';
  strSQL := strSQL + '  AND CTR.CTR_GRVORI < 0.0 ';
  strSQL := strSQL + '  AND CTR.CTR_SEQBAI = 0 ';

  If (recParams.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND CTR.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  Result := strSQL;
end;

function TestContabilidadeSQL.fSQLContaBandeiraCTR(
  strCampoSeqCon, strCampoCodEmp: String; blnBanNcoExiste: boolean): string;
begin
  Result := '';
  Result := Result + '(SELECT ';

  if (blnBanNcoExiste) then
    Result := Result + ' IFNULL(BANNCO.NCO_CODCON, BAN_PLANCO) AS BAN_PLANCO '
  else
    Result := Result + ' BAN_PLANCO ';

  Result := Result + '   FROM MOVCAR ';
  Result := Result + '   JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
  Result := Result + '   JOIN CADBAN ON BAN_CODBAN = CAR_CODBAN ';

  if (blnBanNcoExiste) then
  begin
    Result := Result + ' LEFT JOIN BANNCO ON BANNCO.NCO_CODBAN = BAN_CODBAN ';
    Result := Result + '                 AND BANNCO.NCO_CODEMP = MCA_CODEMP ';
  end;

  Result := Result + '  WHERE MCA_SEQCON = ' + strCampoSeqCon + ' AND MCA_CODEMP = ' + strCampoCodEmp + ' ';

  if (blnBanNcoExiste) then
    Result := Result + '    AND ((BAN_PLANCO IS NOT NULL) OR (BANNCO.NCO_CODCON IS NOT NULL)) '
  else
    Result := Result + '    AND (BAN_PLANCO IS NOT NULL) ';

  Result := Result + '  LIMIT 1) ';
end;

function TestContabilidadeSQL.fSQLCodigoBandeiraCTR(strCampoSeqCon, strCampoCodEmp: String; blnBanNcoExiste: boolean): string;
begin
  Result := '';
  Result := Result + '(SELECT ';

  if (blnBanNcoExiste) then
    Result := Result + ' IFNULL(BANNCO.NCO_CODBAN, BAN_CODBAN) AS CODIGO_BANDEIRA '
  else
    Result := Result + ' BAN_CODBAN AS CODIGO_BANDEIRA ';

  Result := Result + '   FROM MOVCAR ';
  Result := Result + '   JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
  Result := Result + '   JOIN CADBAN ON BAN_CODBAN = CAR_CODBAN ';

  if (blnBanNcoExiste) then
  begin
    Result := Result + ' LEFT JOIN BANNCO ON BANNCO.NCO_CODBAN = BAN_CODBAN ';
    Result := Result + '                 AND BANNCO.NCO_CODEMP = MCA_CODEMP ';
  end;

  Result := Result + '  WHERE MCA_SEQCON = ' + strCampoSeqCon + ' AND MCA_CODEMP = ' + strCampoCodEmp + ' ';

  if (blnBanNcoExiste) then
    Result := Result + '    AND ((BAN_PLANCO IS NOT NULL) OR (BANNCO.NCO_CODCON IS NOT NULL)) '
  else
    Result := Result + '    AND (BAN_PLANCO IS NOT NULL) ';

  Result := Result + '  LIMIT 1) ';
end;

procedure TestContabilidadeSQL.SetUp;
begin
  inherited;

end;

procedure TestContabilidadeSQL.TearDown;
begin
  inherited;

end;

procedure TestContabilidadeSQL.TestSQLMovimentoBancarioEmpresaPreenchida;
  const
    STR_CODIGO_EMPRESA : String = '001';
    APLICAR_FILTRO_CONTRA_PARTIDA : Boolean = True;
    ARR_INCDOC : TArrIncDoc = [] ;
    STR_INCDOC : string = '' ;
begin
  CheckTrue( fGetSQLMovimentoBancarioTest(STR_CODIGO_EMPRESA, APLICAR_FILTRO_CONTRA_PARTIDA, STR_INCDOC, ARR_INCDOC ) = fGetSQLMovimentoBancario(STR_CODIGO_EMPRESA, APLICAR_FILTRO_CONTRA_PARTIDA, STR_INCDOC, ARR_INCDOC ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoBancarioEmpresaPreenchidaDataPreenchidaIncDocPreenchido;
  const
    STR_CODIGO_EMPRESA : String = '001';
    APLICAR_FILTRO_CONTRA_PARTIDA : Boolean = True;
    ARR_INCDOC : TArrIncDoc = [] ;
    STR_INCDOC : String = '1';
begin
  CheckTrue( fGetSQLMovimentoBancarioTest( STR_CODIGO_EMPRESA, APLICAR_FILTRO_CONTRA_PARTIDA, STR_INCDOC, ARR_INCDOC, True ) = fGetSQLMovimentoBancario( STR_CODIGO_EMPRESA, APLICAR_FILTRO_CONTRA_PARTIDA, STR_INCDOC, ARR_INCDOC, True ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoBancarioEmpresaVazia;
  const
    STR_CODIGO_EMPRESA : String = '';
    NAO_APLICAR_FILTRO_CONTRA_PARTIDA : Boolean = False;
    ARR_INCDOC : TArrIncDoc = [] ;
    STR_INCDOC : string = '' ;
begin
  CheckTrue( fGetSQLMovimentoBancarioTest( STR_CODIGO_EMPRESA, NAO_APLICAR_FILTRO_CONTRA_PARTIDA, STR_INCDOC, ARR_INCDOC ) = fGetSQLMovimentoBancario( STR_CODIGO_EMPRESA, NAO_APLICAR_FILTRO_CONTRA_PARTIDA, STR_INCDOC, ARR_INCDOC ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_PeriodoPreenchido_IncDocPreenchido;
  const
    INC_DOC : string = '000000000001NF029';
    strDataIncial : string = '23/11/2019';
    strDataFinal : string = '23/11/2019';
  var
    recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.strIncDoc := INC_DOC;
  recParams.dtaDtaIni := StrToDate(strDataIncial);
  recParams.dtaDtaFin := StrToDate(strDataFinal);
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe_CTR_CREDIT_existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCTR_CREDIT_Existe := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe_CTR_DTABAN_Existe_Periodo;
  const
    strDataIncial : string = '23/11/2019';
    strDataFinal : string = '23/11/2019';
  var
    recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCTR_DTABAN_Existe := True;
  recParams.dtaDtaIni := StrToDate(strDataIncial);
  recParams.dtaDtaFin := StrToDate(strDataFinal);
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCTR_RETBAN_Existe := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPNao_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_Existe;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnCFG_EXCREP := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaVazia_ContaNaBandeiraNaoExiste_CFG_EXCREPNaoExiste_CFG_EXCREPSim_CTR_RETBAN_NaoExiste;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP := True;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe_CTR_DTABAN_Existe_POR_TITPDD_ExistePeriodo;
  const
    strDataIncial : string = '23/11/2019';
    strDataFinal : string = '23/11/2019';
  var
    recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCTR_DTABAN_Existe := True;
  recParams.dtaDtaIni := StrToDate(strDataIncial);
  recParams.dtaDtaFin := StrToDate(strDataFinal);
  recParams.blnPOR_TITPDD_Existe := True ;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoContasReceber_EmpresaPreenchida_ContaNaBandeiraExiste_CFG_EXCREPExiste_CFG_EXCREPSim_CTR_RETBAN_Existe_CTR_DTABAN_Existe_POR_TITPDD_ExistePeriodo_ComAg;
  const
    strDataIncial : string = '23/11/2019';
    strDataFinal : string = '23/11/2019';
  var
    recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnContaNaBandeiraExiste := True;
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnCTR_RETBAN_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCTR_DTABAN_Existe := True;
  recParams.dtaDtaIni := StrToDate(strDataIncial);
  recParams.dtaDtaFin := StrToDate(strDataFinal);
  recParams.blnPOR_TITPDD_Existe := True ;
  recParams.blnDesabilitaAgrupamento := True ;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoContasReceberTest( recParams ) = fGetSQLMovimentoContasReceber( recParams ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPExiste_CFG_EXCREPSim;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnBanNcoExiste := True;
  recParams.strIncDoc := '1';
  recParams.dtaDtaIni := EncodeDate(2020,06,28);
  recParams.dtaDtaFin := EncodeDate(2020,06,28);
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_CTRAGRSim;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnBanNcoExiste := True;
  recParams.strIncDoc := '1';
  recParams.dtaDtaIni := EncodeDate(2020,06,28);
  recParams.dtaDtaFin := EncodeDate(2020,06,28);
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPExiste_CFG_EXCREPNao;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPNaoExiste_CFG_EXCREPNao;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaPreenchida_CFG_EXCREPNaoExiste_CFG_EXCREPSim;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := '001';
  recParams.blnCFG_EXCREP := True;
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPExiste_CFG_EXCREPSim;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnCFG_EXCREP := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPExiste_CFG_EXCREPNao;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP_Existe := True;
  recParams.blnBanNcoExiste := True;
  recParams.blnCfgCtrAgr := True ;
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPNaoExiste_CFG_EXCREPNao;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

procedure TestContabilidadeSQL.TestSQLMovimentoCreditoCliente_EmpresaVazia_CFG_EXCREPNaoExiste_CFG_EXCREPSim;
var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.blnCFG_EXCREP := True;
  CheckTrue( fGetSQLMovimentoCreditoClienteTest( recParams, 'CADREC' ) = fGetSQLMovimentoCreditoCliente( recParams, 'CADREC' ) );
end;

function TestContabilidadeSQL.fEmpresaGeracao(strAliasComPonto: String;
  recParams: TParamsContasReceber): string;
begin
  if recParams.blnCFG_EXCREP_Existe then
  begin
    if recParams.blnCFG_EXCREP then
      Result := strAliasComPonto + 'CTR_EMPBAI'
    else
      Result := strAliasComPonto + 'CTR_CODEMP';
  end
  else
    Result := strAliasComPonto + 'CTR_EMPBAI';
end;

function TestContabilidadeSQL.fGetSQLMovimentoBancarioTest(strCodEmp: string; blnAplicarFiltroContraPartida: boolean; strIncDoc: string; arrIncDoc: TArrIncDoc; blnFiltrarPeriodo: boolean = false): string;
  var
    strSQL : string;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT "" AS CLAFIS, CTB_DTALAN AS DTAENT, ';
  strSQL := strSQL + '        CTB_NUMDOC AS NUMDOC, "BAN" AS ESPDOC, ';
  strSQL := strSQL + '        CTB_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        CTB_VALLAN AS VALLAN, ';
  strSQL := strSQL + '        IF(CTB_CODFOR IS NULL, CLI_NOMCLI, FOR_NOMFOR) AS NOME, ';
  strSQL := strSQL + '        IF(CTB_CODFOR IS NULL, CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '        IF(CTB_CODFOR IS NULL, "C", "F") AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(CTB_CODFOR IS NULL, IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(CTB_CODFOR IS NULL, IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, ';
  strSQL := strSQL + '        CTB_CREDEB AS CREDEB, IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '        CTB_CODPOR AS CODPOR, CTB_CODCTA AS CODCTA,  ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + '        CTB_ORIGEM, MOVBAN.AUTOINCREM AS BANINC, CTB_HIST01, CTB_HIST02, CTB_CODEVE, "MOVBAN" AS TABELA, ';
  strSQL := strSQL + '        CASE ';
  strSQL := strSQL + '          WHEN MOVBAN.CTB_ORIGEM = "CTR" THEN ';
  strSQL := strSQL + '             IF(FISCTR.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura") ';
  strSQL := strSQL + '          WHEN MOVBAN.CTB_ORIGEM = "CTP" THEN ';
  strSQL := strSQL + '             IF(FISCTP.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura") ';
  strSQL := strSQL + '          ELSE ';
  strSQL := strSQL + '             CAST(NULL AS CHAR(20)) ';
  strSQL := strSQL + '        END AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + '        CASE ';
  strSQL := strSQL + '         WHEN MOVBAN.CTB_ORIGEM = "CTR" THEN ';
  strSQL := strSQL + '            (IF(AGRCTR2.CTR_NUMDUP IS NOT NULL, ';
  strSQL := strSQL + '             ((COALESCE(AGRCTR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGRCTR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM'+' DUPAGR WHERE CTR_NUMAGR = AGRCTR.CTR_NUMDUP AND CTR_EMPAGR = AGRCTR.CTR_EMPAGR AND CTR_CODCLI = AGRCTR.CTR_CODCLI),1)))/100)*COALESCE(AGRCTR.CTR_VALDUP,0.00), ';
  strSQL := strSQL + '             ((COALESCE(AGRCTR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGRCTR2.CTR_NUMDUP IS NOT NULL, NULL,COALESCE(CTR_VALDUP, 0.00))) FROM'+' DUPAGR WHERE CTR_NUMDUP = AGRCTR.CTR_NUMDUP AND CTR_EMPAGR = AGRCTR.CTR_EMPAGR AND CTR_CODCLI = AGRCTR.CTR_CODCLI),1)))/100)*COALESCE(AGRCTR.CTR_VALDUP,0.00) ';
  strSQL := strSQL + '            )) ';
  strSQL := strSQL + '         WHEN MOVBAN.CTB_ORIGEM = "CTP" THEN ';
  strSQL := strSQL + '           ( ';
  strSQL := strSQL + '            ((COALESCE(AGRCTP.CTP_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTP_VALDUP, 0.00)) FROM DUPAGP WHERE CTP_NUMDUP = AGRCTP.CTP_NUMDUP'+' AND CTP_EMPAGR = AGRCTP.CTP_EMPAGR AND CTP_CODFOR = AGRCTP.CTP_CODFOR),1)))/100)*COALESCE(AGRCTP.CTP_VALDUP,0.00) ';
  strSQL := strSQL + '           ) ';
  strSQL := strSQL + '         ELSE ';
  strSQL := strSQL + '           0.00 ';
  strSQL := strSQL + '         END AS VALOR_PROPORCIONAL, ';
  strSQL := strSQL + '        CASE ';
  strSQL := strSQL + '          WHEN MOVBAN.CTB_ORIGEM = "CTR" THEN ';
  strSQL := strSQL + '            CTR.AUTOINCREM ';
  strSQL := strSQL + '          WHEN MOVBAN.CTB_ORIGEM = "CTP" THEN ';
  strSQL := strSQL + '            CTP.AUTOINCREM ';
  strSQL := strSQL + '          ELSE ';
  strSQL := strSQL + '            CAST(NULL AS CHAR(20)) ';
  strSQL := strSQL + '          END AS INCCTRCTP, ';
  strSQL := strSQL + '        CTB_VALLAN AS VLLAN2 ';
  strSQL := strSQL + '   FROM MOVBAN ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = CTB_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = CTB_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADPOR ON POR_CODPOR = CTB_CODPOR ';
  strSQL := strSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = CTB_CODCTA ';
  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = CTB_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = CTB_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = CTB_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTB_CODCTA ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = CTB_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN CADREC AS CTR ON CTR.CTR_CODCLI = MOVBAN.CTB_CODCLI ';
  strSQL := strSQL + '                   AND CTR.CTR_NUMDUP = MOVBAN.CTB_NUMDUP ';
  strSQL := strSQL + '                   AND CTR.CTR_PARCEL = MOVBAN.CTB_PARCEL ';
  strSQL := strSQL + '                   AND CTR.CTR_CODEMP = MOVBAN.CTB_EMPDUP ';
  strSQL := strSQL + '                   AND CTR.CTR_SEQBAI = "0" ';
  strSQL := strSQL + '                   AND MOVBAN.CTB_ORIGEM = "CTR" ';
  strSQL := strSQL + '   LEFT JOIN DUPAGR AGRCTR ON AGRCTR.CTR_NUMAGR = CTR.CTR_NUMDUP ';
  strSQL := strSQL + '                   AND AGRCTR.CTR_EMPAGR = CTR.CTR_CODEMP ';
  strSQL := strSQL + '                   AND AGRCTR.CTR_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '                   AND CTR.CTR_ESPDOC = "AG" ';
  strSQL := strSQL + '   LEFT JOIN DUPAGR AGRCTR2 ON AGRCTR2.CTR_NUMAGR = AGRCTR.CTR_NUMDUP ';
  strSQL := strSQL + '                   AND AGRCTR2.CTR_EMPAGR = AGRCTR.CTR_CODEMP ';
  strSQL := strSQL + '                   AND AGRCTR2.CTR_CODCLI = AGRCTR.CTR_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADFIS FISCTR ON FISCTR.FIS_NUMDOC = IF(CTR.CTR_ESPDOC = "AG", IF(AGRCTR.CTR_ESPDOC = "AG", AGRCTR2.CTR_NUMDUP, AGRCTR.CTR_NUMDUP), CTR.CTR_NUMDUP) ';
  strSQL := strSQL + '                   AND FISCTR.FIS_ESPDOC = IF(CTR.CTR_ESPDOC = "AG", IF(AGRCTR.CTR_ESPDOC = "AG", AGRCTR2.CTR_ESPDOC, AGRCTR.CTR_ESPDOC), CTR.CTR_ESPDOC) ';
  strSQL := strSQL + '                   AND FISCTR.FIS_CODEMP = IF(CTR.CTR_ESPDOC = "AG", IF(AGRCTR.CTR_ESPDOC = "AG", AGRCTR2.CTR_CODEMP, AGRCTR.CTR_CODEMP), CTR.CTR_CODEMP) ';
  strSQL := strSQL + '                   AND FISCTR.FIS_DTAENT = IF(CTR.CTR_ESPDOC = "AG", IF(AGRCTR.CTR_ESPDOC = "AG", AGRCTR2.CTR_DTACAD, AGRCTR.CTR_DTACAD), CTR.CTR_DTACAD) ';
  strSQL := strSQL + '                   AND FISCTR.FIS_FORCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '                   AND FISCTR.FIS_TIP_FC = "C" ';

  strSQL := strSQL + '   LEFT JOIN CADPAG CTP ON CTP.CTP_CODFOR = MOVBAN.CTB_CODFOR ';
  strSQL := strSQL + '                  AND CTP.CTP_NUMDUP = MOVBAN.CTB_NUMDUP ';
  strSQL := strSQL + '                  AND CTP.CTP_PARCEL = MOVBAN.CTB_PARCEL ';
  strSQL := strSQL + '                  AND CTP.CTP_CODEMP = MOVBAN.CTB_EMPDUP ';
  strSQL := strSQL + '                  AND COALESCE(CTP.CTP_SERIE_,"") = COALESCE(MOVBAN.CTB_SERIE_, "") ';
  strSQL := strSQL + '                  AND CTP.CTP_SEQBAI = "0" ';
  strSQL := strSQL + '                  AND MOVBAN.CTB_ORIGEM = "CTP" ';
  strSQL := strSQL + '   LEFT JOIN DUPAGP AGRCTP ON AGRCTP.CTP_NUMAGR = CTP.CTP_NUMDUP ';
  strSQL := strSQL + '                  AND AGRCTP.CTP_EMPAGR = CTP.CTP_CODEMP ';
  strSQL := strSQL + '                  AND AGRCTP.CTP_CODFOR = CTP.CTP_CODFOR ';
  strSQL := strSQL + '                  AND AGRCTP.CTP_PARCEL = CTP.CTP_PARCEL ';
  strSQL := strSQL + '   LEFT JOIN CADFIS FISCTP ON FISCTP.FIS_NUMDOC = IF(SUBSTRING(CTP.CTP_NUMDUP, 1, 2) = "AG", AGRCTP.CTP_NUMDUP, CTP.CTP_NUMDUP) ';
  strSQL := strSQL + '                  AND FISCTP.FIS_CODEMP = IF(SUBSTRING(CTP.CTP_NUMDUP, 1, 2) = "AG", AGRCTP.CTP_CODEMP, CTP.CTP_CODEMP) ';
  strSQL := strSQL + '                  AND FISCTP.FIS_FORCLI = IF(SUBSTRING(CTP.CTP_NUMDUP, 1, 2) = "AG", AGRCTP.CTP_CODFOR, CTP.CTP_CODFOR) ';
  strSQL := strSQL + '                  AND FISCTP.FIS_TIP_FC = "F" ';
  strSQL := strSQL + '                  AND IFNULL(FISCTP.FIS_SERIE_,"") = IF(SUBSTRING(CTP.CTP_NUMDUP, 1, 2) = "AG", IFNULL(AGRCTP.CTP_SERIE_,""), IFNULL(CTP.CTP_SERIE_,"")) ';

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    IFNULL(CADPOR.POR_EXPAUT, "S") = "S" ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('MOVBAN.AUTOINCREM')
                      .fIncDoc(strIncDoc)
                      .fArrIncDoc(arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  if (blnAplicarFiltroContraPartida) then
    strSQL := strSQL + '  AND CTB_GERCON = 1 ';

  If (Not strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND CTB_CODEMP = :CODEMP ';

  if (blnFiltrarPeriodo) then
    strSQL := strSQL + '  AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' ORDER BY MOVBAN.AUTOINCREM ';
  Result := strSQL;
end;

initialization
  RegisterTest(TestContabilidadeSQL.Suite);

end.
