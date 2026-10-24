unit untConsultarFinanceiro;

interface

uses
  Uni,
  Data.DB,
  untFuncoesSimples,
  System.SysUtils;

type

  TConsultarFinanceiro = class
  private
    FobjDataSource: TDataSource;
    FobjDataSet: TUniQuery;
    FstrAutoIncrem,
    FstrEspecie: String;
    function fCamposBaseContasPagar: String;
  public
    function fConsultarContasPagar: TConsultarFinanceiro;
    function fConsultarContasReceber: TConsultarFinanceiro;
    function fAutoIncrem(strAutoIncrem: String): TConsultarFinanceiro;
    function fEspecie(strEspecie: String): TConsultarFinanceiro;
    function fDataSet: TUniQuery;
    function fDataSource: TDataSource;
    function fFechar: TConsultarFinanceiro;
    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TConsultaContasPagar }

constructor TConsultarFinanceiro.Create;
begin
  FobjDataSet := fCriaQuery;
  FobjDataSource := TDataSource.Create(nil);
  FobjDataSource.DataSet := FObjDataSet;
End;

function TConsultarFinanceiro.fConsultarContasReceber: TConsultarFinanceiro;
Begin
  Result := Self;
  FobjDataSet.SQL.Clear;
  FObjDataSet.SQL.Add('SELECT');
  FObjDataSet.SQL.Add('  CTR_CODEMP,');
  FObjDataSet.SQL.Add('  CLI_NOMCLI,');
  FObjDataSet.SQL.Add('  CTR_CODCLI,');
  FObjDataSet.SQL.Add('  CLI_CGCCPF,');
  FObjDataSet.SQL.Add('  CTR_NUMDUP,');
  FObjDataSet.SQL.Add('  CTR_ESPDOC,');
  FObjDataSet.SQL.Add('  CTR_PARCEL,');
  FObjDataSet.SQL.Add('  CTR_DTAVEN,');
  FObjDataSet.SQL.Add('  CTR_DTACAD,');
  FObjDataSet.SQL.Add('  CTR_VALORI,');
  FObjDataSet.SQL.Add('  CTR_VALDUP,');
  FObjDataSet.SQL.Add('  (IFNULL(CTR_DESCOB, 0.00)) AS CTR_DESCOB,');
  FObjDataSet.SQL.Add('  (IFNULL(CTR_VALREC, 0.00)) AS CTR_VALREC,');
  FObjDataSet.SQL.Add('  (CADPOR.POR_NOMPOR) AS POR_NOMPOR,');
  FObjDataSet.SQL.Add('  (IFNULL(CTR_JURSUJ, 0.00)) AS CTR_JURSUJ,');
  FObjDataSet.SQL.Add('  (IFNULL(CTR_DESSUJ, 0.00)) AS CTR_DESSUJ,');
  FObjDataSet.SQL.Add('  CTR_HIST01,');
  FObjDataSet.SQL.Add('  CONCAT(CTA_CODCTA,'' - '', CTA_DESCTA) AS CTA_DESCTA');
  FObjDataSet.SQL.Add('FROM');
  FObjDataSet.SQL.Add('  CADREC');
  FObjDataSet.SQL.Add('  JOIN CADCLI C');
  FObjDataSet.SQL.Add('    ON CLI_CODCLI = CTR_CODCLI');
  FObjDataSet.SQL.Add('');
  FObjDataSet.SQL.Add('  LEFT JOIN CADPOR ');
  FObjDataSet.SQL.Add('    ON CADPOR.POR_CODPOR = CTR_CODPOR');
  FObjDataSet.SQL.Add('  LEFT JOIN CADCND');
  FObjDataSet.SQL.Add('    ON CADCND.CND_CODIGO = CTR_CODCND');
  FObjDataSet.SQL.Add('  LEFT JOIN CADEVE');
  FObjDataSet.SQL.Add('    ON CADEVE.EVE_CODEVE = CTR_CODEVE');
  FObjDataSet.SQL.Add('  LEFT JOIN CADCTA');
  FObjDataSet.SQL.Add('    ON CTA_CODCTA = CTR_CODCTA');
  FObjDataSet.SQL.Add('  LEFT JOIN CADFIS');
  FObjDataSet.SQL.Add('    ON CADREC.CTR_NUMDUP = CADFIS.FIS_NUMDOC');
  FObjDataSet.SQL.Add('    AND CADREC.CTR_CODEMP = CADFIS.FIS_CODEMP');
  FObjDataSet.SQL.Add('    AND CADREC.CTR_CODCLI = CADFIS.FIS_FORCLI');
  FObjDataSet.SQL.Add('	AND CADREC.CTR_ESPDOC = CADFIS.FIS_ESPDOC');
  FobjDataSet.SQL.Add('  WHERE CADFIS.AUTOINCREM = :AUTOINCREM');
  FObjDataSet.ParamByName('AUTOINCREM').AsString := FstrAutoIncrem;
  FObjDataSet.Open;

  FObjDataSet.FieldByName('CTR_CODEMP').DisplayLabel := 'Empresa';
  FObjDataSet.FieldByName('CLI_NOMCLI').DisplayLabel := 'Cliente';
  FObjDataSet.FieldByName('CTR_CODCLI').DisplayLabel := 'Cód. Cliente';
  FObjDataSet.FieldByName('CLI_CGCCPF').DisplayLabel := 'CPF/CNPJ';
  FObjDataSet.FieldByName('CTR_NUMDUP').DisplayLabel := 'Duplicata';
  FObjDataSet.FieldByName('CTR_ESPDOC').DisplayLabel := 'Espécie';
  FObjDataSet.FieldByName('CTR_PARCEL').DisplayLabel := 'Parcela';
  FObjDataSet.FieldByName('CTR_DTAVEN').DisplayLabel := 'Vencimento';
  FObjDataSet.FieldByName('CTR_DTACAD').DisplayLabel := 'Data de Cadastro';
  FObjDataSet.FieldByName('CTR_VALORI').DisplayLabel := 'Valor Original';
  FObjDataSet.FieldByName('CTR_VALDUP').DisplayLabel := 'Valor Duplicata';
  FObjDataSet.FieldByName('CTR_DESCOB').DisplayLabel := 'Despesa Cobrança';
  FObjDataSet.FieldByName('CTR_VALREC').DisplayLabel := 'Valor Recebido';
  FObjDataSet.FieldByName('POR_NOMPOR').DisplayLabel := 'Portador';
  FObjDataSet.FieldByName('CTR_JURSUJ').DisplayLabel := 'Juros';
  FObjDataSet.FieldByName('CTR_DESSUJ').DisplayLabel := 'Desconto';
  FObjDataSet.FieldByName('CTR_HIST01').DisplayLabel := 'Histórico 1';
  FObjDataSet.FieldByName('CTA_DESCTA').DisplayLabel := 'Plano de Contas';

  TCurrencyField(FObjDataSet.FieldByName('CTR_VALORI')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTR_DESCOB')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTR_VALREC')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTR_JURSUJ')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTR_DESSUJ')).DisplayFormat := '#,##0.00';
End;

function TConsultarFinanceiro.fCamposBaseContasPagar: String;
begin
  Result := '';
  Result := Result + '   CTP_NUMDUP,';
  Result := Result + '   CTP_PARCEL,';
  Result := Result + '   CTP_CODEMP,';
  Result := Result + '   CTP_SERIE_,';
  Result := Result + '   FOR_NOMFOR,';
  Result := Result + '   CTP_DTACAD,';
  Result := Result + '   FIS_DTADOC,';
  Result := Result + '   CTP_CODFOR,';
  Result := Result + '   CTP_DTAVEN,';
  Result := Result + '   CTP_VALORI,';
  Result := Result + '   (IFNULL(CTP_JURSUJ, 0)) AS CTP_JURSUJ,';
  Result := Result + '   (IFNULL(CTP_DESSUJ, 0)) AS CTP_DESSUJ,';
  Result := Result + '   CTP_CODCTA,';
  Result := Result + '   (';
  Result := Result + '     CAST(';
  Result := Result + '       IFNULL(REPLACE(REPLACE(CTP_HIST01, "';
  Result := Result + ' ", " "),"<<csq>>"," "), " ") AS CHAR(255)';
  Result := Result + '     )';
  Result := Result + '   ) AS CTP_HIST01,';
  Result := Result + '   (';
  Result := Result + '     (';
  Result := Result + '       IFNULL(CTP_VALDUP, 0) + IFNULL(CTP_JURSUJ, 0) + IFNULL(CTP_MULSUJ, 0) - IFNULL(CTP_DESSUJ, 0) + IFNULL(CTP_VENDOR, 0) + IFNULL(CTP_OUTENT, 0)';
  Result := Result + '     )';
  Result := Result + '   ) AS CTP_VALTOT,';
  Result := Result + '   CONCAT(CTA_CODCTA,'' - '', CTA_DESCTA) AS CTA_DESCTA';
end;

function TConsultarFinanceiro.fConsultarContasPagar: TConsultarFinanceiro;
Begin
  Result := Self;
  FobjDataSet.SQL.Clear;
  FobjDataSet.SQL.Add('SELECT');
  FobjDataSet.SQL.Add(fCamposBaseContasPagar);
  FobjDataSet.SQL.Add('FROM');
  FobjDataSet.SQL.Add('  CADPAG');
  FobjDataSet.SQL.Add('  JOIN CADFOR');
  FobjDataSet.SQL.Add('    ON CTP_CODFOR = FOR_CODFOR');
  FobjDataSet.SQL.Add('  LEFT JOIN CADCTA');
  FobjDataSet.SQL.Add('    ON CTA_CODCTA = CTP_CODCTA');
  FobjDataSet.SQL.Add('  LEFT JOIN CADFIS');
  FobjDataSet.SQL.Add('    ON CADPAG.CTP_NUMDUP = CADFIS.FIS_NUMDOC');
  FobjDataSet.SQL.Add('    AND CADPAG.CTP_CODEMP = CADFIS.FIS_CODEMP');
  FobjDataSet.SQL.Add('    AND CADPAG.CTP_DTACAD = CADFIS.FIS_DTAENT');
  FobjDataSet.SQL.Add('    AND CADPAG.CTP_CODFOR = CADFIS.FIS_FORCLI');
  FobjDataSet.SQL.Add('    AND CADFIS.FIS_ESPDOC = ' + QuotedStr(FstrEspecie));
  FobjDataSet.SQL.Add('    AND CADFIS.FIS_ENTSAI = ''E''');
  FobjDataSet.SQL.Add('  WHERE CADFIS.AUTOINCREM = :AUTOINCREM');
  FobjDataSet.SQL.Add('    AND CTP_USOFIS = "N" ');
  FobjDataSet.SQL.Add('    AND CTP_PAGANT = "N" ');
  FobjDataSet.SQL.Add('GROUP BY CADPAG.AUTOINCREM');

  {Pagamento Antecipado quando utilizado via livro fiscal}
  FobjDataSet.SQL.Add(' UNION ALL ');
  FobjDataSet.SQL.Add('SELECT');
  FobjDataSet.SQL.Add(fCamposBaseContasPagar);
  FobjDataSet.SQL.Add('FROM');
  FobjDataSet.SQL.Add('  CADPAG');
  FobjDataSet.SQL.Add('  JOIN CADFOR');
  FobjDataSet.SQL.Add('    ON CTP_CODFOR = FOR_CODFOR');
  FobjDataSet.SQL.Add('  LEFT JOIN CADCTA');
  FobjDataSet.SQL.Add('    ON CTA_CODCTA = CTP_CODCTA');
  FobjDataSet.SQL.Add('  INNER JOIN PGOFIS');
  FobjDataSet.SQL.Add('    ON PGF_SEQPAG = CADPAG.AUTOINCREM');
  FobjDataSet.SQL.Add('  INNER JOIN CADFIS');
  FobjDataSet.SQL.Add('     ON CADFIS.AUTOINCREM = PGOFIS.PGF_SEQFIS');
  FobjDataSet.SQL.Add('    AND CADFIS.FIS_ESPDOC = ' + QuotedStr(FstrEspecie));
  FobjDataSet.SQL.Add('    AND CADFIS.FIS_ENTSAI = ''E''');
  FobjDataSet.SQL.Add('  WHERE CADFIS.AUTOINCREM = :AUTOINCREM');
  FobjDataSet.SQL.Add('GROUP BY CADPAG.AUTOINCREM');

  {Pagamento Antecipado quando utilizado via entrada mercadoria}
  FobjDataSet.SQL.Add(' UNION ALL ');
  FobjDataSet.SQL.Add('SELECT');
  FobjDataSet.SQL.Add(fCamposBaseContasPagar);
  FobjDataSet.SQL.Add(' FROM  ');
  FobjDataSet.SQL.Add(' CADFIS  ');
  FobjDataSet.SQL.Add(' INNER JOIN MOVGER ON MOVGER.GER_NUMDOC = FIS_NUMDOC  ');
  FobjDataSet.SQL.Add('                  AND MOVGER.GER_CODEMP = FIS_CODEMP  ');
  FobjDataSet.SQL.Add('                  AND MOVGER.GER_SERIE_ = FIS_SERIE_  ');
  FobjDataSet.SQL.Add('                  AND MOVGER.GER_CODFOR = FIS_FORCLI  ');
  FobjDataSet.SQL.Add('                  AND MOVGER.GER_TIP_FC = FIS_TIP_FC  ');
  FobjDataSet.SQL.Add(' INNER JOIN PGOGER ON PGO_SEQGER = MOVGER.AUTOINCREM  ');
  FobjDataSet.SQL.Add(' INNER JOIN CADPAG ON PGO_SEQPAG = CADPAG.AUTOINCREM  ');
  FobjDataSet.SQL.Add(' INNER JOIN CADFOR ON CTP_CODFOR = FOR_CODFOR  ');
  FobjDataSet.SQL.Add('  LEFT JOIN CADCTA ON CTA_CODCTA = CTP_CODCTA  ');
  FobjDataSet.SQL.Add('  WHERE CADFIS.AUTOINCREM = :AUTOINCREM');
  FobjDataSet.SQL.Add('GROUP BY CADPAG.AUTOINCREM');

  {Retenções}
  FobjDataSet.SQL.Add(' UNION ALL ');
  FobjDataSet.SQL.Add('SELECT ');
  FobjDataSet.SQL.Add(fCamposBaseContasPagar);
  FobjDataSet.SQL.Add(' FROM ');
  FobjDataSet.SQL.Add('   CADPAG ');
  FobjDataSet.SQL.Add('   JOIN CADFOR ');
  FobjDataSet.SQL.Add('     ON CTP_CODFOR = FOR_CODFOR ');
  FobjDataSet.SQL.Add('   LEFT JOIN CADCTA ');
  FobjDataSet.SQL.Add('     ON CTA_CODCTA = CTP_CODCTA ');
  FobjDataSet.SQL.Add('   LEFT JOIN CADFIS ');
  FobjDataSet.SQL.Add('     ON CADPAG.CTP_NUMDOC = CADFIS.FIS_NUMDOC ');
  FobjDataSet.SQL.Add('     AND CADPAG.CTP_CODEMP = CADFIS.FIS_CODEMP ');
  FobjDataSet.SQL.Add('     AND CADPAG.CTP_DTACAD = CADFIS.FIS_DTAENT ');
  FobjDataSet.SQL.Add('     AND (CADPAG.CTP_INCFIS = CADFIS.AUTOINCREM OR IFNULL(CADPAG.CTP_INCFIS, '''') = '''') ');
  FobjDataSet.SQL.Add('     AND CADFIS.FIS_ESPDOC = ' + QuotedStr(FstrEspecie));
  FobjDataSet.SQL.Add('     AND CADFIS.FIS_ENTSAI = ' + QuotedStr('E'));
  FobjDataSet.SQL.Add('   WHERE CADFIS.AUTOINCREM = :AUTOINCREM');
  FobjDataSet.SQL.Add('     AND CTP_HIST01 REGEXP ' + QuotedStr('^(RETENÇÃO DE (PIS|COFINS|CSSL|IRRF|INSS|ISS)|INSS PATRONAL)'));
  FobjDataSet.SQL.Add(' GROUP BY CADPAG.AUTOINCREM ');

  FObjDataSet.ParamByName('AUTOINCREM').AsString := FstrAutoIncrem;
  FObjDataSet.Open;

  FObjDataSet.FieldByName('CTP_NUMDUP').DisplayLabel := 'Duplicata';
  FObjDataSet.FieldByName('CTP_PARCEL').DisplayLabel := 'Parcela';
  FObjDataSet.FieldByName('CTP_CODEMP').DisplayLabel := 'Empresa';
  FObjDataSet.FieldByName('CTP_SERIE_').DisplayLabel := 'Serie';
  FObjDataSet.FieldByName('FOR_NOMFOR').DisplayLabel := 'Fornecedor';
  FObjDataSet.FieldByName('CTP_DTACAD').DisplayLabel := 'Data de Cadastro';
  FObjDataSet.FieldByName('FIS_DTADOC').DisplayLabel := 'Data do Documento';
  FObjDataSet.FieldByName('CTP_CODFOR').DisplayLabel := 'Cód. do Fornecedor';
  FObjDataSet.FieldByName('CTP_DTAVEN').DisplayLabel := 'Vencimento';
  FObjDataSet.FieldByName('CTP_VALORI').DisplayLabel := 'Valor Original';
  FObjDataSet.FieldByName('CTP_JURSUJ').DisplayLabel := 'Juros';
  FObjDataSet.FieldByName('CTP_DESSUJ').DisplayLabel := 'Desconto';
  FObjDataSet.FieldByName('CTP_CODCTA').DisplayLabel := 'Pl. Contas';
  FObjDataSet.FieldByName('CTP_HIST01').DisplayLabel := 'Histórico 1';
  FObjDataSet.FieldByName('CTP_VALTOT').DisplayLabel := 'Valor Total';
  FObjDataSet.FieldByName('CTA_DESCTA').DisplayLabel := 'Plano de Contas';

  TCurrencyField(FObjDataSet.FieldByName('CTP_VALTOT')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTP_JURSUJ')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTP_DESSUJ')).DisplayFormat := '#,##0.00';
  TCurrencyField(FObjDataSet.FieldByName('CTP_VALORI')).DisplayFormat := '#,##0.00';
end;

destructor TConsultarFinanceiro.Destroy;
begin
  FobjDataSet.Free;
  FobjDataSource.Free;

  inherited;
end;

function TConsultarFinanceiro.fAutoIncrem(
  strAutoIncrem: String): TConsultarFinanceiro;
begin
  Result := Self;
  FstrAutoIncrem := strAutoIncrem;
end;

function TConsultarFinanceiro.fDataSet: TUniQuery;
begin
  Result := FobjDataSet;
end;

function TConsultarFinanceiro.fDataSource: TDataSource;
begin
  Result := FObjDataSource;
end;

function TConsultarFinanceiro.fEspecie(
  strEspecie: String): TConsultarFinanceiro;
begin
  Result := Self;
  FstrEspecie := strEspecie;
end;

function TConsultarFinanceiro.fFechar: TConsultarFinanceiro;
begin
  Result := Self;
  FobjDataSet.Close;
end;

end.
