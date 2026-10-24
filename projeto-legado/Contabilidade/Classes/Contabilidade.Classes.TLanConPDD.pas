unit Contabilidade.Classes.TLanConPDD;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls, Contabilidade.SQL;

type
  TLanConPDD = Class(TInterfacedObject, ITipLanCon)
  private
    fltValOri: Double;
    fltDifOri: Double;
    fltRatOri: Double;
    fltValRev: Double;
    fltDifRev: Double;
    fltRatRev: Double;
    strCTRInc: string;
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    cdsCtrAgg: TUniClientDataSet;
    FstrCentroCustoDefault: String ;
    FblnParametrizouReversaoPDD: Boolean ;
    FcdsPddOco: TUniClientDataSet;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fEmpresaDoCadastroDiferenteDaBaixa(const AEmpresaCadastro, AEmpresaDaBaixa: string): boolean;
    function fDeletaLacamentosGeradosParaOutraEmpresa: boolean;
    function fValidaEve(strEveNec:string): boolean;
    function fProgressoAtivo: boolean;
    procedure pSomarValores;
    procedure pZerarValores;
    procedure pAlterarValores;
    function fEhAgrupado(const blnPreValidar:boolean; const strEspDoc:string):boolean;
    function fEhFimAgrupamento(const blnCtrInc, blnEof:boolean):boolean;
    procedure pAcertaValorAgrupamento(var strCTRInc: string);
    function fCarregaDadosCadRecValorAgrupado(recParams: TParamsContasReceber):boolean;
    function fGetCadRecValorAgrupado(const strAutoInc:string):double ;
    function fTrataValorProporcional(const fltValorProporcional:double):double ;
    procedure pCarregaPDDComVariasOcorrencias(const ArecParams: TParamsContasReceber) ;
    function fVaiContabilizarPDD: Boolean ;
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

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes,
  untConstantes, Contabilidade.Classes.TEventoContabil,
  Contabilidade.Classes.TTrataIncDoc;

function fGetSQLPDD(recParams: TParamsContasReceber): string;
Var
  strSQL : String;
begin
  strSQL := strSQL + 'SELECT DISTINCT ';
  strSQL := strSQL + ' ROUND(IFNULL(CASE WHEN CADPOR.POR_TITPDD = "S" THEN CTR.CTR_VALORI ELSE 0 END, 0), 2) AS CTR_VALORI, ';
  strSQL := strSQL + ' ROUND(IFNULL(CASE WHEN CADPOR.POR_TITPDD = "S" THEN CTR.CTR_VALORI ELSE 0 END, 0), 2) AS VALORI , ';
  strSQL := strSQL + ' ROUND(IFNULL(CASE WHEN CADPOR.POR_TITPDD = "N" THEN CTR.CTR_VALORI ELSE 0 END, 0), 2) AS CTR_REVERS, ';
  strSQL := strSQL + ' ROUND(IFNULL(CASE WHEN CADPOR.POR_TITPDD = "N" THEN CTR.CTR_VALORI ELSE 0 END, 0), 2) AS REVERS , ';
  strSQL := strSQL + ' AUXREC.AUX_CODEMP AS CODEMP, ';
  strSQL := strSQL + ' CTR.CTR_EMPBAI AS EMPBAI, ';
  strSQL := strSQL + ' AUXREC.AUX_CODEMP AS EMPCAD, ';
  strSQL := strSQL + ' AUXREC.AUX_DTATRO AS DTAENT, ';
  strSQL := strSQL + ' CTR.CTR_DTACAD AS DTACAD, ';
  strSQL := strSQL + ' AUXREC.AUX_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + ' AUXREC.AUX_CODEMP AS CTR_CODEMP, ';
  strSQL := strSQL + ' AUXREC.AUX_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + ' AUXREC.AUX_CODCLI, ';
  strSQL := strSQL + ' AUXREC.AUX_SEQBAI, ';
  strSQL := strSQL + ' CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + ' CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + ' "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + ' IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + ' IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + ' IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + ' IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + ' "" AS CLAFIS, ';
  strSQL := strSQL + ' IFNULL(POR_EXPAUT, "S") AS POR_EXPAUT, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCON, CTABAI.CTA_PLANCO) AS CTA_PLANCO, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCTA, CTABAI.CTA_CODCTA) AS CODIGO_PLANO_CONTA_BAIXA, ';
  strSQL := strSQL + ' AUXREC.AUX_PARCEL AS PARCEL, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCON, CADCTA2.CTA_PLANCO ) AS CODCTA, ';
  strSQL := strSQL + ' IFNULL(CTANCO2.NCO_CODCTA, CADCTA2.CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + ' AUXREC.AUTOINCREM AS CTRINC, ';
  strSQL := strSQL + ' IFNULL(AGR.CTR_NUMDUP,"") AS DOCORI, ';
  strSQL := strSQL + ' IFNULL(AGR.CTR_ESPDOC,"") AS ESPORI, ';
  strSQL := strSQL + ' IF(AGR2.CTR_NUMAGR IS NULL, IF(AGR.CTR_NUMAGR IS NULL, CTR.CTR_CODEVE, AGR.CTR_CODEVE), AGR2.CTR_CODEVE) AS CODEVE, ';
  strSQL := strSQL + ' EMP_NOMEMP AS NOMEMP, CTR.CTR_HIST01 AS HIST01, CTR.CTR_ADTCLI, ';
  strSQL := strSQL + ' "AUXREC" AS TABELA, ';
  strSQL := strSQL + ' IF(CADFIS.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura") AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + ' IF(AGR2.CTR_NUMAGR IS NULL, AGR.AUTOINCREM, AGR2.AUTOINCREM) AS AGR_AUTOINCREM, ';
  strSQL := strSQL + '   (IF(AGR2.CTR_NUMDUP IS NOT NULL, ';
  strSQL := strSQL + '   ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR '+'= AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                    +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ';
  strSQL := strSQL + '   ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ';
  strSQL := strSQL + '   )) AS VALOR_PROPORCIONAL ';
  strSQL := strSQL + 'FROM CADREC CTR ';
  strSQL := strSQL + '   INNER JOIN AUXREC ON CTR.CTR_NUMDUP = AUXREC.AUX_NUMDUP ';
  strSQL := strSQL + ' 	       AND CTR.CTR_PARCEL = AUXREC.AUX_PARCEL ';
  strSQL := strSQL + ' 	       AND CTR.CTR_ESPDOC = AUXREC.AUX_ESPDOC ';
  strSQL := strSQL + ' 	       AND CTR.CTR_CODEMP = AUXREC.AUX_CODEMP ';
  strSQL := strSQL + ' 	       AND CTR.CTR_CODCLI = AUXREC.AUX_CODCLI ';
  strSQL := strSQL + ' 	       AND CTR.CTR_SEQBAI = AUXREC.AUX_SEQBAI ';
  strSQL := strSQL + '   INNER JOIN CADEMP ON CTR.CTR_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CTABAI ON CTABAI.CTA_CODCTA = CTR.CTR_CTABAI ';

  strSQL := strSQL + '   LEFT JOIN CADPOR ON AUXREC.AUX_ATUPOR = POR_CODPOR ';

  strSQL := strSQL + '   LEFT JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ';
  strSQL := strSQL + ' 	       AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ';
  strSQL := strSQL + ' 	       AND AGR.CTR_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '         AND IF(CTR.CTR_ESPDOC = "AG", AGR.CTR_ESPDOC = "AG", TRUE) ';
  strSQL := strSQL + '   LEFT JOIN DUPAGR AGR2 ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ';
  strSQL := strSQL + ' 	       AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ';
  strSQL := strSQL + ' 	       AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ';

  strSQL := strSQL + '   LEFT JOIN CADFIS ON FIS_NUMDOC = IF(CTR.CTR_ESPDOC = "AG", IF(AGR.CTR_ESPDOC = "AG", AGR2.CTR_NUMDUP, AGR.CTR_NUMDUP), CTR.CTR_NUMDUP) ';
  strSQL := strSQL + ' 	       AND FIS_ESPDOC = IF(CTR.CTR_ESPDOC = "AG", IF(AGR.CTR_ESPDOC = "AG", AGR2.CTR_ESPDOC, AGR.CTR_ESPDOC), CTR.CTR_ESPDOC) ';
  strSQL := strSQL + ' 	       AND FIS_CODEMP = IF(CTR.CTR_ESPDOC = "AG", IF(AGR.CTR_ESPDOC = "AG", AGR2.CTR_CODEMP, AGR.CTR_CODEMP), CTR.CTR_CODEMP) ';
  strSQL := strSQL + ' 	       AND FIS_DTAENT = IF(CTR.CTR_ESPDOC = "AG", IF(AGR.CTR_ESPDOC = "AG", AGR2.CTR_DTACAD, AGR.CTR_DTACAD), CTR.CTR_DTACAD) ';
  strSQL := strSQL + ' 	       AND FIS_FORCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + ' 	       AND FIS_TIP_FC = "C" ';

  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + ' 	       AND CLINCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = AUXREC.AUX_ATUPOR ';
  strSQL := strSQL + ' 	       AND PORNCO.NCO_CODEMP = AUXREC.AUX_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTABAI.CTA_CODCTA ';
  strSQL := strSQL + ' 	       AND CTANCO.NCO_CODEMP = CTR.CTR_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO2 ON CTANCO2.NCO_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + ' 	       AND CTANCO2.NCO_CODEMP = CTR.CTR_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CADCTA2 ON CADCTA2.CTA_CODCTA = CTR.CTR_CODCTA ';

  strSQL := strSQL + '  WHERE TRUE ';

  If (Not recParams.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND AUXREC.AUX_CODEMP = :CODEMP ';

  if (recParams.dtaDtaIni > 0) then
  begin
    strSQL := strSQL + '    AND AUXREC.AUX_DTATRO BETWEEN :DTAINI AND :DTAFIN '
  end;

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('AUXREC.AUTOINCREM')
                      .fIncDoc(recParams.strIncDoc)
                      .fArrIncDoc(recParams.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '  ORDER BY AUXREC.AUTOINCREM ';

  Result := strSQL;
end;

{ TLanConPDD }

constructor TLanConPDD.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
  FblnParametrizouReversaoPDD := fCampoTabelaParcon('COUNT(*)', ['CON_DESVAL'], [DES_VALOR_REVERSAO_PDD], True) > 0;
  FcdsPddOco := Nil ;
end;

destructor TLanConPDD.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  if Assigned(FcdsPddOco) then
    FreeAndNil(FcdsPddOco) ;
  inherited;
end;

function TLanConPDD.fEhAgrupado(const blnPreValidar: boolean;
  const strEspDoc: string): boolean;
begin
  result := false ;
  if blnPreValidar then
    exit ;

  if qryDados.FieldByName('ESPDOC').AsString <> 'AG' then
    exit ;

  result := true ;
end;

function TLanConPDD.fEhFimAgrupamento(const blnCtrInc, blnEof: boolean): boolean;
begin
  result := true ;
  if blnCtrInc then
    exit ;

  if blnEof then
    exit ;

  result := False ;
end;

function TLanConPDD.fCarregaDados: Boolean;
Var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := recParCon.strCodEmp;
  recParams.dtaDtaIni := recParCon.dtaDtaIni;
  recParams.dtaDtaFin := recParCon.dtaDtaFin;
  recParams.strIncDoc := recParCon.strIncDoc;
  recParams.arrIncDoc := recParCon.arrIncDoc;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fGetSQLPDD(recParams) );

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  fCarregaDadosCadRecValorAgrupado(recParams) ;
  pCarregaPDDComVariasOcorrencias(recParams) ;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConPDD.fCarregaDadosCadRecValorAgrupado(
  recParams: TParamsContasReceber): boolean;
Var
  qryAgg : TUniQuery;
begin

  If Assigned(cdsCtrAgg) Then
    FreeAndNil(cdsCtrAgg);

  qryAgg := fCriaQuery(nil);
  Try
    qryAgg.Close;
    qryAgg.SQL.Clear;
    qryAgg.SQL.Add(' SELECT AUXREC.AUTOINCREM, ');
    qryAgg.SQL.Add('        COALESCE(SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, ');
    qryAgg.SQL.Add(' 	       ((COALESCE(AGR2.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(IF(AGR2.CTR_NUMDUP IS NOT NULL, COALESCE(CTR_VALDUP, 0.00), NULL)) '+'FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMDUP AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100)'
                                +'*((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100), ');
    qryAgg.SQL.Add(' 	       ((COALESCE(AGR.CTR_VALDUP,0.00)*100/(COALESCE((SELECT SUM(COALESCE(CTR_VALDUP, 0.00)) FROM DUPAGR WHERE CTR_NUMAGR = AGR.CTR_NUMAGR AND CTR_EMPAGR = AGR.CTR_EMPAGR AND CTR_CODCLI = AGR.CTR_CODCLI),1)))/100) ');
    qryAgg.SQL.Add(' 	      )),1)    AS VAL_PROPORCIONAL ');
    qryAgg.SQL.Add(' FROM CADREC ');
    qryAgg.SQL.Add('     INNER JOIN AUXREC ');
    qryAgg.SQL.Add('     ON CADREC.CTR_NUMDUP = AUXREC.AUX_NUMDUP ');
    qryAgg.SQL.Add('     AND CADREC.CTR_PARCEL = AUXREC.AUX_PARCEL ');
    qryAgg.SQL.Add('     AND CADREC.CTR_ESPDOC = AUXREC.AUX_ESPDOC ');
    qryAgg.SQL.Add('     AND CADREC.CTR_CODEMP = AUXREC.AUX_CODEMP ');
    qryAgg.SQL.Add('     AND CADREC.CTR_CODCLI = AUXREC.AUX_CODCLI ');
    qryAgg.SQL.Add('     AND CADREC.CTR_SEQBAI = AUXREC.AUX_SEQBAI ');
    qryAgg.SQL.Add('   INNER JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CADREC.CTR_NUMDUP ');
    qryAgg.SQL.Add(' 		      AND AGR.CTR_EMPAGR = CADREC.CTR_CODEMP ');
    qryAgg.SQL.Add(' 		      AND AGR.CTR_CODCLI = CADREC.CTR_CODCLI AND CADREC.CTR_ESPDOC = "AG" ');
    qryAgg.SQL.Add('             LEFT JOIN DUPAGR AGR2 ON AGR2.CTR_NUMAGR = AGR.CTR_NUMDUP ');
    qryAgg.SQL.Add(' 		       AND AGR2.CTR_EMPAGR = AGR.CTR_CODEMP ');
    qryAgg.SQL.Add(' 		       AND AGR2.CTR_CODCLI = AGR.CTR_CODCLI ');
    qryAgg.SQL.Add(' WHERE TRUE ');

    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      qryAgg.SQL.Add('  AND AUXREC.AUX_CODEMP = :CODEMP ');
      qryAgg.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      qryAgg.SQL.Add('    AND AUXREC.AUX_DTATRO BETWEEN :DTAINI AND :DTAFIN ');
      qryAgg.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      qryAgg.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('AUXREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryAgg)
      .fExecute ;

    qryAgg.SQL.Add(' GROUP BY AUXREC.AUTOINCREM');
    qryAgg.Open ;

    cdsCtrAgg := fCriaClientDatset(qryAgg, false);
    cdsCtrAgg.IndexFieldNames := 'AUTOINCREM' ;
    cdsCtrAgg.Open;

    Result := True;
  Finally
    FreeAndNil(qryAgg);
  End;
end;

function TLanConPDD.fDeletaLacamentosGeradosParaOutraEmpresa: boolean;
  Var
    qryDel : TUniQuery;
begin
  if not Generico.fEfetuaDelecaoLanCon then
    Exit(True);

  if Generico.strContaCtrLanctoDuplo.IsEmpty then
    Exit(True);

  if not fEmptyStr(recParCon.strIncDoc) then
    Exit(True);

  if Length(recParCon.arrIncDoc) > 0 then
    Exit(True);

  qryDel := fCriaQuery(nil);
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(' DELETE ');
    qryDel.SQL.Add('   FROM LANCON ');
    qryDel.SQL.Add('  WHERE CON_TIPLAN = :TIPLAN ');
    qryDel.SQL.Add('    AND CON_AUTOMA = 1 ');

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CON_INCDOC')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(qryDel)
      .fExecute ;

    pSetaTextoProgresso(pgbProgresso, 'Deletando lançamentos: "PDD" (Empresa do Cadastro <> Empresa da Baixa)');

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      if (not fEmpresaDoCadastroDiferenteDaBaixa(qryDados.FieldByName('EMPCAD').AsString, qryDados.FieldByName('EMPBAI').AsString)) then
      begin
        qryDados.Next;
        Continue;
      end;

      qryDel.ParamByName('TIPLAN').AsString := 'PDD';
      qryDel.ExecSQL;

      qryDados.Next;
    end;

    pSetaTextoProgresso(pgbProgresso, '');

    Result := True;
  Finally
    FreeAndNil(qryDel);
  End;
end;

function TLanConPDD.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
  if (Result) then
    Result := fDeletaLacamentosGeradosParaOutraEmpresa;
end;

function TLanConPDD.fVaiContabilizarPDD: Boolean;
begin
  Result := True ;
  if FblnParametrizouReversaoPDD then
    Exit ;

  if FcdsPddOco.FindKey([qryDados.FieldByName('NUMDOC').AsString,
                         qryDados.FieldByName('PARCEL').AsString,
                         qryDados.FieldByName('ESPDOC').AsString,
                         qryDados.FieldByName('CODEMP').AsString,
                         qryDados.FieldByName('AUX_CODCLI').AsString,
                         qryDados.FieldByName('AUX_SEQBAI').AsString]) then
    if FcdsPddOco.FieldByName('AUTOINCREM').AsString <> qryDados.FieldByName('CTRINC').AsString then
      Exit(False)
end;

function TLanConPDD.fValidaEve(strEveNec:string): boolean;
begin
  Result := True;

  if fEmptyStr(strEveNec) Then
    Exit;

  if qryDados.FieldByName('CODEVE').IsNull then
    Exit;

  if Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) = 0 then
    Exit;

  Result := False;
end;

function TLanConPDD.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPlaCta : String;
    strEveNec: string;
    strCodEve: string;
    strPagame : String;
    fltValorProporcionalAgrupado : double ;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  strEveNec := fRetornaEventosNaoExportar;
  strCTRInc := '';

  /////ajusta as duplicatas originadas de agrupamento
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    fltValorProporcionalAgrupado := fGetCadRecValorAgrupado(qryDados.FieldByName('CTRINC').AsString) ;
    qryDados.Edit ;
    qryDados.FieldByName('CTR_VALORI').AsFloat := qryDados.FieldByName('CTR_VALORI').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
    qryDados.FieldByName('CTR_REVERS').AsFloat := qryDados.FieldByName('CTR_REVERS').AsFloat * (fTrataValorProporcional(qryDados.FieldByName('VALOR_PROPORCIONAL').AsFloat)/fltValorProporcionalAgrupado) ;
    qryDados.post ;
    qryDados.Next;
  End;


  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "PDD": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));
    //if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
    //   and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    if not fValidaEve(strEveNec) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    if not fVaiContabilizarPDD then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'PDD ignorado por ter mais de uma ocorrência, sem a parametrização da "Vr.Reversão PDD"!'), qryDados);
      qryDados.Next;
      Continue;
    end ;

    fltValOri   := qryDados.FieldByName('VALORI').AsFloat;
    fltValRev   := qryDados.FieldByName('REVERS').AsFloat;

    pAcertaValorAgrupamento(strCTRInc) ;

    strPagame := qryDados.FieldByName('TIPO_PAGAMENTO').AsString;
    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;
    strCodEve   := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('CODEVE').AsString).fConsultaEvento(FstrCentroCustoDefault);

    Generico.pGravaLancto('CTR_VALORI', DES_VALOR_ORIGINAL, strPlaCta, '', strCodEve, strPagame) ;
    Generico.pGravaLancto('CTR_REVERS', DES_VALOR_REVERSAO_PDD, strPlaCta, '', strCodEve, strPagame) ;

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConPDD.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConPDD.fEmpresaDoCadastroDiferenteDaBaixa(const AEmpresaCadastro,
  AEmpresaDaBaixa: string): boolean;
begin
  Result := False;

  if AEmpresaCadastro.IsEmpty then
    Exit;

  if AEmpresaDaBaixa.IsEmpty then
    Exit;

  Result := (AEmpresaCadastro <> AEmpresaDaBaixa);
end;

function TLanConPDD.fGetCadRecValorAgrupado(const strAutoInc: string): double;
begin
  result := 1 ;
  if cdsCtrAgg.FindKey([strAutoInc]) then
  begin
    result := cdsCtrAgg.FieldByName('VAL_PROPORCIONAL').AsFloat ;
  end;
end;

function TLanConPDD.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConPDD.fTrataValorProporcional(
  const fltValorProporcional: double): double;
begin
  result := 1 ;
  if fltValorProporcional <> 0.00 then
  begin
    result := fltValorProporcional ;
  end;
end;

function TLanConPDD.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConPDD.pAcertaValorAgrupamento(var strCTRInc: string);
begin
  if fEhAgrupado(Generico.blnPreValidar, qryDados.FieldByName('ESPDOC').AsString) then
  begin
    if qryDados.FieldByName('CTRINC').AsString <> strCTRInc then
    begin
      strCTRInc := qryDados.FieldByName('CTRINC').AsString;
      pZerarValores;
    end;
    pSomarValores;

    qryDados.Next;
    //if (qryDados.FieldByName('CTRINC').AsString <> strCTRInc) or (qryDados.Eof) then
    if fEhFimAgrupamento((qryDados.FieldByName('CTRINC').AsString <> strCTRInc), (qryDados.Eof)) then
    begin
      if not qryDados.Eof then
        qryDados.Prior;

      fltDifOri := fltValOri - fltRatOri;
      fltDifRev := fltValRev - fltRatRev;

      if (fltDifOri <> 0) or (fltDifRev <> 0) then
      begin
        pAlterarValores;
      end;
    end
    else
    begin
      qryDados.Prior;
    end;
  end;
end;

procedure TLanConPDD.pAlterarValores;
begin
  qryDados.Edit;
  if (fltDifOri <> 0) or (fltDifRev <> 0) then
  begin
    if qryDados.FieldByName('CTR_VALORI').AsFloat <> 0 then
      qryDados.FieldByName('CTR_VALORI').AsFloat := qryDados.FieldByName('CTR_VALORI').AsFloat + fltDifOri ;
    if qryDados.FieldByName('CTR_REVERS').AsFloat <> 0 then
      qryDados.FieldByName('CTR_REVERS').AsFloat := qryDados.FieldByName('CTR_REVERS').AsFloat + fltDifRev ;
  end;
  qryDados.Post;
end;

procedure TLanConPDD.pCarregaPDDComVariasOcorrencias(const ArecParams: TParamsContasReceber);
Var
  LqryConsulta : TUniQuery;
begin

  If Assigned(FcdsPddOco) Then
    FreeAndNil(FcdsPddOco);

  LqryConsulta := fCriaQuery(nil);
  Try
    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Add(' SELECT ');
    LqryConsulta.SQL.Add('   MIN(AUXREC.AUTOINCREM) AS AUTOINCREM, ');
    LqryConsulta.SQL.Add('   COUNT(AUXREC.AUTOINCREM) AS CNT, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_NUMDUP, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_PARCEL, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_ESPDOC, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_CODEMP, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_CODCLI, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_SEQBAI ');
    LqryConsulta.SQL.Add(' FROM ');
    LqryConsulta.SQL.Add('   CADREC ');
    LqryConsulta.SQL.Add('   INNER JOIN AUXREC ');
    LqryConsulta.SQL.Add('     ON CADREC.CTR_NUMDUP = AUXREC.AUX_NUMDUP ');
    LqryConsulta.SQL.Add('     AND CADREC.CTR_PARCEL = AUXREC.AUX_PARCEL ');
    LqryConsulta.SQL.Add('     AND CADREC.CTR_ESPDOC = AUXREC.AUX_ESPDOC ');
    LqryConsulta.SQL.Add('     AND CADREC.CTR_CODEMP = AUXREC.AUX_CODEMP ');
    LqryConsulta.SQL.Add('     AND CADREC.CTR_CODCLI = AUXREC.AUX_CODCLI ');
    LqryConsulta.SQL.Add('     AND CADREC.CTR_SEQBAI = AUXREC.AUX_SEQBAI ');
    LqryConsulta.SQL.Add('   INNER JOIN CADPOR ON AUXREC.AUX_ATUPOR = POR_CODPOR ');
    LqryConsulta.SQL.Add(' WHERE TRUE AND CADPOR.POR_TITPDD = "S" ');

    If Not fEmptyStr(recParCon.strCodEmp) Then
    begin
      LqryConsulta.SQL.Add('  AND AUXREC.AUX_CODEMP = :CODEMP ');
      LqryConsulta.ParamByName('CODEMP').AsString := recParCon.strCodEmp;
    end ;

    if (recParCon.dtaDtaIni > 0) then
    begin
      LqryConsulta.SQL.Add('    AND AUXREC.AUX_DTATRO BETWEEN :DTAINI AND :DTAFIN ');
      LqryConsulta.ParamByName('DTAINI').AsDate := recParCon.dtaDtaIni;
      LqryConsulta.ParamByName('DTAFIN').AsDate := recParCon.dtaDtaFin;
    end;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('AUXREC.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute ;

    LqryConsulta.SQL.Add(' GROUP BY AUXREC.AUX_NUMDUP, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_PARCEL, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_ESPDOC, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_CODEMP, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_CODCLI, ');
    LqryConsulta.SQL.Add('   AUXREC.AUX_SEQBAI ');
    LqryConsulta.SQL.Add(' HAVING COUNT(AUXREC.AUTOINCREM) > 1 ');
    LqryConsulta.Open ;

    FcdsPddOco := fCriaClientDatset(LqryConsulta, false);
    FcdsPddOco.IndexFieldNames := 'AUX_NUMDUP;AUX_PARCEL;AUX_ESPDOC;AUX_CODEMP;AUX_CODCLI;AUX_SEQBAI' ;
    FcdsPddOco.Open;
  Finally
    FreeAndNil(LqryConsulta);
  End;
end;

procedure TLanConPDD.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Provisão de Devedores Duvidosos Concluído!', ['&OK']);
end;

procedure TLanConPDD.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

function TLanConPDD.fProgressoAtivo: boolean;
begin
  Result := False;

  if (not Assigned(pgbProgresso)) Then
    Exit;

  if (not Assigned(pgbProgresso.Parent)) then
    Exit;

  if (GetParentForm(pgbProgresso).FindComponent('lblGravando') = Nil) then
    Exit;

  Result := True;
end;

procedure TLanConPDD.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConPDD.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if assigned(lblGravando) then
    lblGravando.Caption := strTexto
  //else if Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  else if fProgressoAtivo then
  Begin
    lblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    lblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;


procedure TLanConPDD.pSomarValores;
begin
  fltRatOri := fltRatOri + qryDados.FieldByName('CTR_VALORI').AsFloat;
  fltRatRev := fltRatRev + qryDados.FieldByName('CTR_REVERS').AsFloat;
end;

procedure TLanConPDD.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

procedure TLanConPDD.pZerarValores;
begin
  fltRatOri := 0;
  fltRatRev := 0;
  fltDifOri := 0;
  fltDifRev := 0;
end;

end.
