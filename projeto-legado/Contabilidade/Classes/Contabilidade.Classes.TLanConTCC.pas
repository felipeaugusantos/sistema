unit Contabilidade.Classes.TLanConTCC;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConTCC = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FblnAtivaProporcionalidade : boolean;
    FblnDesabilitaAgrupamento : boolean ;
    cdsCtrAgg: TUniClientDataSet;
    fltValLan: Double;
    fltDifLan: Double;
    fltRatLan: Double;
    strRECInc: string;
    function fCarregaDadosCadRecValorAgrupado(
      recParams: TParametrosConsulta): boolean;
    function fGetCadRecValorAgrupado(const strAutoInc: string):double ;
    function fTrataValorProporcional(const fltValorProporcional:double):double ;
    procedure pSomarValores;
    procedure pZerarValores;
    procedure pAlterarValores;
    function fDesabilitaAGR:string ;
    procedure pAplicaFiltro(const ArecParam: TParametrosConsulta; const AstrOpcao: string) ;
  public
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); overload ;
    procedure pSetaPreValidacao(const Value: Boolean); overload ;
    constructor Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
    destructor Destroy; override;
    procedure pVerificaSeLancouLanCon;
    function fEfetuaLancamentosPreValidacao: Boolean;
  End;

implementation

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes, Contabilidade.SQL,
  Contabilidade.Classes.TTrataIncDoc;

{ TLanConTCC }

constructor TLanConTCC.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FblnAtivaProporcionalidade := fCampoTabelaParcon('COUNT(*)', ['CON_TIPLAN', 'CON_PAGAME'], [strTipLan, 'Todos']) = 0;
  FblnDesabilitaAgrupamento := (fCfgCAgrDp = 'S')
end;

destructor TLanConTCC.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConTCC.fCarregaDados: Boolean;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(' SELECT * FROM ( ');
  qryDados.SQL.Add(' SELECT ' + iif(FblnAtivaProporcionalidade, '',  'DISTINCT') );
  qryDados.SQL.Add('   CAST("" AS CHAR(1)) AS CLAFIS, ');
  qryDados.SQL.Add('   CHQ_DTACAD AS DTAENT, ');
  qryDados.SQL.Add('   CHQ_NUMCHQ AS NUMDOC, ');
  qryDados.SQL.Add('   CAST("CHQ" AS CHAR(3)) AS ESPDOC, ');
  qryDados.SQL.Add('   CHQ_CODEMP AS CODEMP, ');
  qryDados.SQL.Add('   CHQ_VALCHQ AS VALREC, ');
  qryDados.SQL.Add('   IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ');
  qryDados.SQL.Add('   IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ');
  qryDados.SQL.Add('   CLI_NOMCLI AS NOME, ');
  qryDados.SQL.Add('   CLI_C_G_C_ AS CNPJ, ');
  qryDados.SQL.Add('   CAST("C" AS CHAR(1)) AS TIPO_CLIENTE_FORNECEDOR, ');
  qryDados.SQL.Add('   IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ');
  qryDados.SQL.Add('   IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ');
  qryDados.SQL.Add('   CAST("" AS CHAR(20)) AS CONTA_BANDEIRA, ');
  qryDados.SQL.Add('   CADCHQ.AUTOINCREM AS TCCINC, ');
  qryDados.SQL.Add('   CAST("CADCHQ" AS CHAR(10)) AS TABELA, ');
  qryDados.SQL.Add('   CAST("" AS CHAR(3)) AS CODIGO_BANDEIRA, ');
  qryDados.SQL.Add('   CAST( ');
  qryDados.SQL.Add('     CASE ');
  qryDados.SQL.Add('       WHEN CHQ_DTACAD = CHQ_DTAVEN ');
  qryDados.SQL.Add('       THEN "Cheque à vista" ');
  qryDados.SQL.Add('       ELSE "Cheque pré" ');
  qryDados.SQL.Add('     END AS CHAR(20) ');
  qryDados.SQL.Add('   ) AS FORPGO ');

  if FblnAtivaProporcionalidade then
  begin
    qryDados.SQL.Add('   ,IF( ');
    qryDados.SQL.Add('     CADFIS.AUTOINCREM IS NULL, ');
    qryDados.SQL.Add('     "Pagamentos Avulsos", ');
    qryDados.SQL.Add('     "Pagamentos Fatura" ');
    qryDados.SQL.Add('   ) AS TIPO_PAGAMENTO ');

    qryDados.SQL.Add('   ,CASE ');
    qryDados.SQL.Add('       WHEN CHQ_DTACAD = CHQ_DTAVEN ');
    qryDados.SQL.Add('       THEN CTR.CTR_CHQAVI ');
    qryDados.SQL.Add('       ELSE CTR.CTR_CHQPRE ');
    qryDados.SQL.Add('     END AS VALOR_CTR  ');

    qryDados.SQL.Add('   ,(IF(AGR2.CTR_NUMDUP IS NOT NULL, ');
    qryDados.SQL.Add('     ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR'+' = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                    +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryDados.SQL.Add('     ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ');
    qryDados.SQL.Add('    )) AS VALOR_PROPORCIONAL ');

    qryDados.SQL.Add('   , CTR.AUTOINCREM AS CTR_AUTOINC ');
    qryDados.SQL.Add('   , CHQ_VALCHQ AS VALRE2 ');
  end
  else
  begin
    qryDados.SQL.Add('   ,CAST("" AS CHAR(1)) AS TIPO_PAGAMENTO ');
  end ;
  qryDados.SQL.Add(' FROM ');
  qryDados.SQL.Add('   CADCHQ ');
  qryDados.SQL.Add('   INNER JOIN CADREC AS CTR ON CADCHQ.CHQ_SEQCON = CTR.CTR_SEQCON ');
  qryDados.SQL.Add('                               AND CADCHQ.CHQ_CODEMP = CTR.CTR_EMPBAI ');
  qryDados.SQL.Add('                               AND CTR.CTR_SEQCON > 0 ');
  qryDados.SQL.Add('   LEFT JOIN DUPAGR AGR ');
  qryDados.SQL.Add('     ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ');
  qryDados.SQL.Add('     AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ');
  qryDados.SQL.Add('     AND AGR.CTR_CODCLI = CTR.CTR_CODCLI ');
  qryDados.SQL.Add('     AND CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add(fDesabilitaAGR);
  qryDados.SQL.Add('   LEFT JOIN DUPAGR AGR2 ');
  qryDados.SQL.Add('     ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ');
  qryDados.SQL.Add('     AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ');
  qryDados.SQL.Add('     AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ');
  qryDados.SQL.Add(fDesabilitaAGR);
  qryDados.SQL.Add('   LEFT JOIN CADFIS ');
  qryDados.SQL.Add('     ON FIS_NUMDOC = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_NUMDUP, ');
  qryDados.SQL.Add('         AGR.CTR_NUMDUP ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_NUMDUP ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_ESPDOC = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_ESPDOC, ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_CODEMP = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_CODEMP, ');
  qryDados.SQL.Add('         AGR.CTR_CODEMP ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_CODEMP ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_DTAENT = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_DTACAD, ');
  qryDados.SQL.Add('         AGR.CTR_DTACAD ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_DTACAD ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_FORCLI = CTR.CTR_CODCLI ');
  qryDados.SQL.Add('     AND FIS_TIP_FC = "C" ');
  qryDados.SQL.Add('   LEFT JOIN CADCLI ');
  qryDados.SQL.Add('     ON CLI_CODCLI = CHQ_CODCLI ');
  qryDados.SQL.Add('   LEFT JOIN CADPOR ');
  qryDados.SQL.Add('     ON POR_CODPOR = CHQ_CODPOR ');
  qryDados.SQL.Add('   LEFT JOIN CLINCO ');
  qryDados.SQL.Add('     ON CLINCO.NCO_CODCLI = CLI_CODCLI ');
  qryDados.SQL.Add('     AND CLINCO.NCO_CODEMP = CHQ_CODEMP ');
  qryDados.SQL.Add('   LEFT JOIN PORNCO ');
  qryDados.SQL.Add('     ON PORNCO.NCO_CODPOR = POR_CODPOR ');
  qryDados.SQL.Add('     AND PORNCO.NCO_CODEMP = CHQ_CODEMP ');
  qryDados.SQL.Add(' WHERE TRUE ');

  pAplicaFiltro(recParCon, 'CHQ') ;

  qryDados.SQL.Add(' UNION ALL ');
  qryDados.SQL.Add(' SELECT ' + iif(FblnAtivaProporcionalidade, '',  'DISTINCT'));
  qryDados.SQL.Add('   CAST("" AS CHAR(1)) AS CLAFIS, ');
  qryDados.SQL.Add('   MCA_DTACAD AS DTAENT, ');
  qryDados.SQL.Add('   MCA_NUMDUP AS NUMDOC, ');
  qryDados.SQL.Add('   CAST("CAR" AS CHAR(3)) AS ESPDOC, ');
  qryDados.SQL.Add('   MCA_CODEMP AS CODEMP, ');
  qryDados.SQL.Add('   MCA_VALSTA AS VALREC, ');
  qryDados.SQL.Add('   IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ');
  qryDados.SQL.Add('   IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ');
  qryDados.SQL.Add('   CLI_NOMCLI AS NOME, ');
  qryDados.SQL.Add('   CLI_C_G_C_ AS CNPJ, ');
  qryDados.SQL.Add('   CAST("C" AS CHAR(1)) AS TIPO_CLIENTE_FORNECEDOR, ');
  qryDados.SQL.Add('   CLI_CODCLI AS CODIGO_CLIENTE_FORNECEDOR, ');
  qryDados.SQL.Add('   IFNULL( ');
  qryDados.SQL.Add('     CARNCO.NCO_CODCON, ');
  qryDados.SQL.Add('     IFNULL( ');
  qryDados.SQL.Add('       CAR_PLANCO, ');
  qryDados.SQL.Add('       IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('   ) AS PLANCO, ');
  qryDados.SQL.Add('   IFNULL(BANNCO.NCO_CODCON, BAN_PLANCO) AS CONTA_BANDEIRA, ');
  qryDados.SQL.Add('   MOVCAR.AUTOINCREM AS TCCINC, ');
  qryDados.SQL.Add('   CAST("MOVCAR" AS CHAR(10)) AS TABELA, ');
  qryDados.SQL.Add('   BAN_CODBAN AS CODIGO_BANDEIRA, ');
  qryDados.SQL.Add('   CAST("Cartão" AS CHAR(20)) AS FORPGO ');

  if FblnAtivaProporcionalidade then
  begin
    qryDados.SQL.Add('   ,IF( ');
    qryDados.SQL.Add('     CADFIS.AUTOINCREM IS NULL, ');
    qryDados.SQL.Add('     "Pagamentos Avulsos", ');
    qryDados.SQL.Add('     "Pagamentos Fatura" ');
    qryDados.SQL.Add('   ) AS TIPO_PAGAMENTO ');
    qryDados.SQL.Add('   ,CTR.CTR_CARTAO AS VALOR_CTR ');
    qryDados.SQL.Add('   ,(IF(AGR2.CTR_NUMDUP IS NOT NULL, ');
    qryDados.SQL.Add('     ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR'+' = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                    +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryDados.SQL.Add('     ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ');
    qryDados.SQL.Add('    )) AS VALOR_PROPORCIONAL ');
    qryDados.SQL.Add('   , CTR.AUTOINCREM AS CTR_AUTOINC ');
    qryDados.SQL.Add('   ,MCA_VALSTA AS VALRE2 ');
  end
  else
  begin
    qryDados.SQL.Add('   ,CAST("" AS CHAR(1)) AS TIPO_PAGAMENTO ');
  end ;
  qryDados.SQL.Add(' FROM ');
  qryDados.SQL.Add('   MOVCAR ');
  qryDados.SQL.Add('   INNER JOIN CADREC AS CTR ON MOVCAR.MCA_SEQCON = CTR.CTR_SEQCON ');
  qryDados.SQL.Add('                            AND MOVCAR.MCA_CODEMP = CTR.CTR_EMPBAI ');
  qryDados.SQL.Add('                            AND CTR.CTR_SEQCON > 0 ');
  qryDados.SQL.Add('   LEFT JOIN DUPAGR AGR ');
  qryDados.SQL.Add('     ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ');
  qryDados.SQL.Add('     AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ');
  qryDados.SQL.Add('     AND AGR.CTR_CODCLI = CTR.CTR_CODCLI ');
  qryDados.SQL.Add('     AND CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add(fDesabilitaAGR);
  qryDados.SQL.Add('   LEFT JOIN DUPAGR AGR2 ');
  qryDados.SQL.Add('     ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ');
  qryDados.SQL.Add('     AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ');
  qryDados.SQL.Add('     AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ');
  qryDados.SQL.Add(fDesabilitaAGR);
  qryDados.SQL.Add('   LEFT JOIN CADFIS ');
  qryDados.SQL.Add('     ON FIS_NUMDOC = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_NUMDUP, ');
  qryDados.SQL.Add('         AGR.CTR_NUMDUP ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_NUMDUP ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_ESPDOC = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_ESPDOC, ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_CODEMP = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_CODEMP, ');
  qryDados.SQL.Add('         AGR.CTR_CODEMP ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_CODEMP ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_DTAENT = IF( ');
  qryDados.SQL.Add('       CTR.CTR_ESPDOC = "AG" ');
  qryDados.SQL.Add('       AND FALSE, ');
  qryDados.SQL.Add('       IF( ');
  qryDados.SQL.Add('         AGR.CTR_ESPDOC = "AG", ');
  qryDados.SQL.Add('         AGR2.CTR_DTACAD, ');
  qryDados.SQL.Add('         AGR.CTR_DTACAD ');
  qryDados.SQL.Add('       ), ');
  qryDados.SQL.Add('       CTR.CTR_DTACAD ');
  qryDados.SQL.Add('     ) ');
  qryDados.SQL.Add('     AND FIS_FORCLI = CTR.CTR_CODCLI ');
  qryDados.SQL.Add('     AND FIS_TIP_FC = "C" ');
  qryDados.SQL.Add('   JOIN CADCAR ');
  qryDados.SQL.Add('     ON CAR_CODCAR = MCA_CODCAR ');
  qryDados.SQL.Add('   LEFT JOIN CADBAN ');
  qryDados.SQL.Add('     ON BAN_CODBAN = CAR_CODBAN ');
  qryDados.SQL.Add('   LEFT JOIN CADCLI ');
  qryDados.SQL.Add('     ON CLI_CODCLI = MCA_CODCLI ');
  qryDados.SQL.Add('   LEFT JOIN CLINCO ');
  qryDados.SQL.Add('     ON CLINCO.NCO_CODCLI = CLI_CODCLI ');
  qryDados.SQL.Add('     AND CLINCO.NCO_CODEMP = MCA_CODEMP ');
  qryDados.SQL.Add('   LEFT JOIN CADPOR ');
  qryDados.SQL.Add('     ON POR_CODPOR = MCA_PORBAI ');
  qryDados.SQL.Add('   LEFT JOIN PORNCO ');
  qryDados.SQL.Add('     ON PORNCO.NCO_CODPOR = POR_CODPOR ');
  qryDados.SQL.Add('     AND PORNCO.NCO_CODEMP = MCA_CODEMP ');
  qryDados.SQL.Add('   LEFT JOIN CARNCO ');
  qryDados.SQL.Add('     ON CARNCO.NCO_CODCAR = MCA_CODCAR ');
  qryDados.SQL.Add('     AND CARNCO.NCO_CODEMP = MCA_CODEMP ');
  qryDados.SQL.Add('   LEFT JOIN CADCTA CTABAI ');
  qryDados.SQL.Add('     ON CTABAI.CTA_CODCTA = MCA_CTABAI ');
  qryDados.SQL.Add('   LEFT JOIN BANNCO ');
  qryDados.SQL.Add('     ON BANNCO.NCO_CODBAN = BAN_CODBAN ');
  qryDados.SQL.Add('     AND BANNCO.NCO_CODEMP = MCA_CODEMP ');
  qryDados.SQL.Add(' WHERE TRUE ');

  pAplicaFiltro(recParCon, 'CAR') ;

  qryDados.SQL.Add(' ) AS SEL ');
  qryDados.SQL.Add(' ORDER BY DTAENT '+ iif(FblnAtivaProporcionalidade, ',CTR_AUTOINC',  '') );

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  if FblnAtivaProporcionalidade then
  begin
    fCarregaDadosCadRecValorAgrupado(recParCon) ;
  end ;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConTCC.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConTCC.fDesabilitaAGR: string;
begin
  result := '' ;
  if FblnDesabilitaAgrupamento then
  begin
    result := ' AND FALSE ';
  end ;
end;

function TLanConTCC.fEfetuaLancamentos: Boolean;
var
  fltValorProporcionalAgrupado : double ;
  strFormaPagamento, strPagame : string ;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strRECInc := '';

  qryDados.BeforeScroll := nil ;
  try

    if FblnAtivaProporcionalidade then
    begin
      qryDados.First;
      While Not qryDados.Eof Do
      Begin
        fltValorProporcionalAgrupado := fTrataValorProporcional(fGetCadRecValorAgrupado(qryDados.FieldByName('CTR_AUTOINC').AsString)) ;
        qryDados.Edit ;
        qryDados.FieldByName('VALREC').AsFloat := qryDados.FieldByName('VALREC').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
        qryDados.post ;
        qryDados.Next;
      End;
    end ;

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      pgbProgresso.Position := qryDados.RecNo;
      Application.ProcessMessages;

      if FblnAtivaProporcionalidade then
      begin
        fltValLan   := qryDados.FieldByName('VALRE2').AsFloat;

        if qryDados.FieldByName('CTR_AUTOINC').AsString <> strRECInc then
        begin
          strRECInc := qryDados.FieldByName('CTR_AUTOINC').AsString;
          pZerarValores;
        end;
        pSomarValores;

        qryDados.Next;
        if (qryDados.FieldByName('CTR_AUTOINC').AsString <> strRECInc) or (qryDados.Eof) then
        begin
          if not qryDados.Eof then
            qryDados.Prior;

          fltDifLan := fltValLan - fltRatLan;

          if fltDifLan <> 0 then
          begin
            pAlterarValores;
          end;
        end
        else
        begin
          qryDados.Prior;
        end;
      end ;

      strFormaPagamento := qryDados.FieldByName('FORPGO').AsString ;
      strPagame := qryDados.FieldByName('TIPO_PAGAMENTO').AsString ;

      Generico.pGravaLancto('VALREC', DES_VALOR_RECEBIDO, '', strFormaPagamento, '', strPagame) ;

      qryDados.Next;
    End;
  finally
    qryDados.BeforeScroll := Generico.pBeforeScroll ;
  end;

  //////valida o credito - debito = resultado zero pelo evento pBeforeScroll
  qryDados.First;
  while not qryDados.Eof do
  begin
    qryDados.Next;
  end;

  Result := True;
end;

function TLanConTCC.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConTCC.fGetCadRecValorAgrupado(const strAutoInc: string): double;
begin
  result := 1 ;
  if cdsCtrAgg.FindKey([strAutoInc]) then
  begin
    result := cdsCtrAgg.FieldByName('VAL_PROPORCIONAL').AsFloat ;
  end;
end;

function TLanConTCC.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConTCC.fTrataValorProporcional(
  const fltValorProporcional: double): double;
begin
  result := 1 ;
  if fltValorProporcional <> 0.00 then
  begin
    result := fltValorProporcional ;
  end;
end;

function TLanConTCC.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConTCC.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Movimentação Bancária Concluída!', ['&OK']);
end;

procedure TLanConTCC.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConTCC.pVerificaSeLancouLanCon;
begin
  generico.pVerificaSeLancouLanCon;
end;

function TLanConTCC.fCarregaDadosCadRecValorAgrupado(recParams: TParametrosConsulta): boolean;
Var
  qryAgg : TUniQuery;
begin

  If Assigned(cdsCtrAgg) Then
    FreeAndNil(cdsCtrAgg);

  qryAgg := fCriaQuery(nil);
  Try
    qryAgg.Close;
    qryAgg.SQL.Clear;
    qryAgg.SQL.Add(' SELECT CTR.AUTOINCREM, ');
    qryAgg.SQL.Add('         COALESCE(SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, ');
    qryAgg.SQL.Add('  	       ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL))'+' FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                                 +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryAgg.SQL.Add('  	       ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ');
    qryAgg.SQL.Add('   	      )),1)    AS VAL_PROPORCIONAL ');
    qryAgg.SQL.Add('  FROM MOVBAN ');
    qryAgg.SQL.Add('       INNER JOIN CADREC AS CTR ON CTR.CTR_CODCLI = MOVBAN.CTB_CODCLI ');
    qryAgg.SQL.Add('                    AND CTR.CTR_NUMDUP = MOVBAN.CTB_NUMDUP ');
    qryAgg.SQL.Add('                    AND CTR.CTR_PARCEL = MOVBAN.CTB_PARCEL ');
    qryAgg.SQL.Add('                    AND CTR.CTR_CODEMP = MOVBAN.CTB_EMPDUP ');
    qryAgg.SQL.Add('                    AND CTR.CTR_SEQBAI = "0" ');
    qryAgg.SQL.Add('                    AND MOVBAN.CTB_ORIGEM = "CTR" ');
    qryAgg.SQL.Add('       INNER JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ');
    qryAgg.SQL.Add('  		   AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ');
    qryAgg.SQL.Add('  		   AND AGR.CTR_CODCLI = CTR.CTR_CODCLI AND CTR.CTR_ESPDOC = "AG" ');
    qryAgg.SQL.Add('       LEFT JOIN DUPAGR AGR2 ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ');
    qryAgg.SQL.Add('  		   AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ');
    qryAgg.SQL.Add('  		   AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ');
    qryAgg.SQL.Add(' WHERE TRUE ');

    // Req. 470760: as chaves do reprocesso sao de MOVCAR/CADCHQ; filtrar o rateio por elas zeraria
    // o agrupado e mudaria o VALREC. O rateio continua sendo o do periodo.
    if not recParams.blnReprocessaErros then
      TTrataIncDocContabil
        .New
        .fColunaIncDoc('MOVBAN.AUTOINCREM')
        .fIncDoc(recParams.strIncDoc)
        .fArrIncDoc(recParams.arrIncDoc)
        .fQuerySql(qryAgg)
        .fExecute ;

    If (Not recParams.strCodEmp.IsEmpty) Then
      qryAgg.SQL.Add('  AND CTB_CODEMP = :CODEMP ');

    if (recParams.dtaDtaIni > 0) then
      qryAgg.SQL.Add('  AND CTB_DTALAN BETWEEN :DTAINI AND :DTAFIN ');

    pSetaParametrosGerLanCon(recParams, qryAgg);

    qryAgg.SQL.Add(' GROUP BY CTR.AUTOINCREM');
    qryAgg.Open ;

    cdsCtrAgg := fCriaClientDatset(qryAgg, false);
    cdsCtrAgg.IndexFieldNames := 'AUTOINCREM' ;
    cdsCtrAgg.Open;

    Result := True;
  Finally
    FreeAndNil(qryAgg);
  End;
end;

procedure TLanConTCC.pZerarValores;
begin
  fltRatLan := 0;
  fltDifLan := 0;
end;

procedure TLanConTCC.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConTCC.pSomarValores;
begin
  fltRatLan := fltRatLan + qryDados.FieldByName('VALREC').AsFloat;
end;

procedure TLanConTCC.pAlterarValores;
begin
  qryDados.Edit;
  if (fltDifLan <> 0) then
    qryDados.FieldByName('VALREC').AsFloat := qryDados.FieldByName('VALREC').AsFloat + fltDifLan;
  qryDados.Post;
end;

procedure TLanConTCC.pAplicaFiltro(const ArecParam: TParametrosConsulta;
  const AstrOpcao: string);
begin
  if AstrOpcao = 'CAR' then
  begin
    TTrataIncDocContabil
      .New
      // Req. 470760: a chave gravada troca o 4o caractere por M (TChaveDocInterprete).
      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros,
                            'CONCAT(LEFT(MOVCAR.AUTOINCREM, 3), ''M'', SUBSTRING(MOVCAR.AUTOINCREM, 5, 16))',
                            'MOVCAR.AUTOINCREM'))
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryDados)
      .fExecute ;

    If (Not recParCon.strCodEmp.IsEmpty) Then
      qryDados.SQL.Add('  AND MCA_CODEMP = :CODEMP ');

    if (recParCon.dtaDtaIni > 0) then
      qryDados.SQL.Add('  AND MCA_DTACAD BETWEEN :DTAINI AND :DTAFIN ');
  end
  else /// CHQ
  begin
    TTrataIncDocContabil
      .New
      // Req. 470760: a chave gravada troca o 4o caractere por C (TChaveDocInterprete).
      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros,
                            'CONCAT(LEFT(CADCHQ.AUTOINCREM, 3), ''C'', SUBSTRING(CADCHQ.AUTOINCREM, 5, 16))',
                            'CADCHQ.AUTOINCREM'))
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryDados)
      .fExecute ;

    If (Not recParCon.strCodEmp.IsEmpty) Then
      qryDados.SQL.Add('  AND CHQ_CODEMP = :CODEMP ');

    if (recParCon.dtaDtaIni > 0) then
      qryDados.SQL.Add('  AND CHQ_DTACAD BETWEEN :DTAINI AND :DTAFIN ');
  end ;
end;

end.
