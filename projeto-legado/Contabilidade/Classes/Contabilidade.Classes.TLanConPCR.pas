unit Contabilidade.Classes.TLanConPCR;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConPCR = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    blnCampoCTR_CHQTRA_Existe : Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fFatorDupAgr: String;
    function fCampoBuscaPeriodo: string;
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

uses Forms, SysUtils, StrUtils, Vcl.StdCtrls, untFuncoesSimples, Contabilidade.Funcoes,
Contabilidade.Classes.TTrataIncDoc;

{ TLanConPCR }

constructor TLanConPCR.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  blnCampoCTR_CHQTRA_Existe := fCampoExiste('CADREC', 'CTR_CHQTRA');
end;

destructor TLanConPCR.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConPCR.fCampoBuscaPeriodo: string;
begin
  if (blnCampoCTR_CHQTRA_Existe) then
    Result := 'IFNULL(DATE(CTR.CTR_CHQTRA), CTR.CTR_DTACAD)'
  else
    Result := 'CTR.CTR_DTACAD';
end;

function TLanConPCR.fCarregaDados: Boolean;
  Var
    strSQL : String;
begin
  strSQL := '' ;

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + ' CTR_VALJUR, ';
  strSQL := strSQL + ' CTR_VALDES, ';
  strSQL := strSQL + ' CTR_VALORI, ';
  strSQL := strSQL + ' CODEMP, ';
  strSQL := strSQL + ' DTAENT, ';
  strSQL := strSQL + ' NUMDOC, ';
  strSQL := strSQL + ' CTR_CODEMP, ';
  strSQL := strSQL + ' ESPDOC, ';
  strSQL := strSQL + ' NOME, ';
  strSQL := strSQL + ' CNPJ, ';
  strSQL := strSQL + ' TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + ' CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + ' PLANCO, ';
  strSQL := strSQL + ' PLAPOR, ';
  strSQL := strSQL + ' CODIGO_PORTADOR, ';
  strSQL := strSQL + ' CLAFIS, ';
  strSQL := strSQL + ' POR_EXPAUT, ';
  strSQL := strSQL + ' CODCTA, ';
  strSQL := strSQL + ' CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + ' TIPO_PAGAMENTO, ';
  strSQL := strSQL + ' PARCEL, ';
  strSQL := strSQL + ' CTA_PROCON, ';
  strSQL := strSQL + ' CTRINC, ';
  strSQL := strSQL + ' DOCORI, ';
  strSQL := strSQL + ' ESPORI, ';
  strSQL := strSQL + ' CASE WHEN COALESCE(CHQ_NUMCHQ_DEV,"") <> "" THEN CHQ_NUMCHQ_DEV ELSE CASE WHEN COALESCE(CHQ_NUMCHQ_DEP,"") <> "" THEN CHQ_NUMCHQ_DEP ELSE CHQ_NUMCHQ END END AS CHQ_NUMCHQ, ';
  strSQL := strSQL + ' CODEVE, ';
  strSQL := strSQL + ' TABELA ';
  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL + ' SELECT IFNULL(CTR.CTR_VALJUR, 0) AS CTR_VALJUR, ';
  strSQL := strSQL + '        IFNULL(CTR.CTR_VALDES, 0) AS CTR_VALDES, ';
  strSQL := strSQL + '        CTR.CTR_VALORI * ' + fFatorDupAgr + ' AS CTR_VALORI, ';
  strSQL := strSQL + '        CTR.CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        ' + fCampoBuscaPeriodo + ' AS DTAENT, ';
  strSQL := strSQL + '        CTR.CTR_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '        CTR.CTR_CODEMP, ';
  strSQL := strSQL + '        CTR.CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '        CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '        CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '        "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '        "" AS CLAFIS, ';
  strSQL := strSQL + '        IFNULL(POR_EXPAUT, "S") AS POR_EXPAUT, ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CODCTA, ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + '        IF(CADFIS.AUTOINCREM IS NULL, "Pagamentos Avulsos", "Pagamentos Fatura") AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + '        CTR.CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + '        CTA_PROCON, ';
  strSQL := strSQL + '        CTR.AUTOINCREM AS CTRINC, ';
  strSQL := strSQL + ' IFNULL(AGR.CTR_NUMDUP,"") AS DOCORI, ';
  strSQL := strSQL + ' IFNULL(AGR.CTR_ESPDOC,"") AS ESPORI, ';
  strSQL := strSQL + '        ( SELECT GROUP_CONCAT(CADCHQ.CHQ_NUMCHQ) ';
  strSQL := strSQL + '            FROM CADCHQ ';
  strSQL := strSQL + '           WHERE CADCHQ.CHQ_SEQCON = CTR.CTR_SEQCON ) AS CHQ_NUMCHQ, ';

  strSQL := strSQL + '    ( ';
  strSQL := strSQL + '    SELECT GROUP_CONCAT(C.CHQ_NUMCHQ) ';
  strSQL := strSQL + '    FROM CADCHQ C ';
  strSQL := strSQL + '    WHERE CTR.CTR_ESPDOC = "CH" AND ';
  strSQL := strSQL + '          C.CHQ_DEVDEF = 1 AND ';
  strSQL := strSQL + '          C.CHQ_DTADV2 IS NOT NULL AND ';
  strSQL := strSQL + '          C.CHQ_INCCTR = "S" AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEV, "-", 1), "-", -1) = CTR.CTR_NUMDUP AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEV, "-", 2), "-", -1) = CTR.CTR_ESPDOC AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEV, "-", 3), "-", -1) = CTR.CTR_PARCEL AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEV, "-", 5), "-", -1) = CTR.CTR_CODCLI ';
  strSQL := strSQL + '  ) AS CHQ_NUMCHQ_DEV, ';

  strSQL := strSQL + '  ( ';
  strSQL := strSQL + '    SELECT GROUP_CONCAT(C.CHQ_NUMCHQ) ';
  strSQL := strSQL + '    FROM CADCHQ C ';
  strSQL := strSQL + '    WHERE CTR.CTR_ESPDOC = "CH" AND ';
  strSQL := strSQL + '          C.CHQ_INCCTR = "S" AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEP, "-", 1), "-", -1) = CTR.CTR_NUMDUP AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEP, "-", 2), "-", -1) = CTR.CTR_PARCEL AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEP, "-", 4), "-", -1) = CTR.CTR_ESPDOC AND ';
  strSQL := strSQL + '          SUBSTRING_INDEX(SUBSTRING_INDEX(C.CHQ_DUPDEP, "-", 6), "-", -1) = CTR.CTR_CODCLI ';
  strSQL := strSQL + '  ) AS CHQ_NUMCHQ_DEP, ';

  strSQL := strSQL + ' IF(AGR.CTR_NUMAGR IS NULL, CTR.CTR_CODEVE, AGR.CTR_CODEVE) AS CODEVE, ';
  strSQL := strSQL + ' "CADREC" AS TABELA ';
  strSQL := strSQL + '   FROM CADREC CTR ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '   LEFT JOIN CADPOR ON CTR.CTR_CODPOR = POR_CODPOR ';

  strSQL := strSQL + '   LEFT JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ';
  strSQL := strSQL + '                       AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ';
  strSQL := strSQL + '                       AND AGR.CTR_CODCLI = CTR.CTR_CODCLI ';

  strSQL := strSQL + '   LEFT JOIN CADFIS ON FIS_NUMDOC = IF(CTR.CTR_ESPDOC = "AG", AGR.CTR_NUMDUP, CTR.CTR_NUMDUP) ';
  strSQL := strSQL + '                   AND FIS_ESPDOC = IF(CTR.CTR_ESPDOC = "AG", AGR.CTR_ESPDOC, CTR.CTR_ESPDOC) ';
  strSQL := strSQL + '                   AND FIS_CODEMP = IF(CTR.CTR_ESPDOC = "AG", AGR.CTR_CODEMP, CTR.CTR_CODEMP) ';
  strSQL := strSQL + '                   AND FIS_FORCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '                   AND FIS_TIP_FC = "C" ';

  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                  AND CLINCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = CTR.CTR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '  WHERE CTA_PROCON = 1 ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('CTR.AUTOINCREM')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND CTR.CTR_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND ' + fCampoBuscaPeriodo + ' BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' AND CADFIS.AUTOINCREM IS NULL ';

  strSQL := strSQL + '   ) AS SEL ';

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConPCR.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConPCR.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPagame : String;
    strPlaCta : String;
    strEveNec: string;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  strEveNec := fRetornaEventosNaoExportar;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "PCR": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));
    Application.ProcessMessages;

    if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
       and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    strPagame := qryDados.FieldByName('TIPO_PAGAMENTO').AsString;

    strPlaCta := qryDados.FieldByName('CODCTA').AsString;
    Generico.pGravaLancto('CTR_VALORI', DES_VALOR_ORIGINAL, strPlaCta, 'Todas', '', strPagame);
    Generico.pGravaLancto('CTR_VALDES', DES_VALOR_DESCONTO, strPlaCta, 'Todas', '', strPagame);
    Generico.pGravaLancto('CTR_VALJUR', DES_VALOR_JUROS,    strPlaCta, 'Todas', '', strPagame);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConPCR.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConPCR.fFatorDupAgr: String;
begin
  Result := '';
  Result := Result + '  (IF(AGR.CTR_NUMAGR IS NULL, 1, ';
  Result := Result + '    IFNULL( AGR.CTR_VALORI / (  ';
  Result := Result + '      IFNULL((SELECT SUM(SUBAGR.CTR_VALORI) ';
  Result := Result + '                FROM DUPAGR SUBAGR ';
  Result := Result + '               WHERE SUBAGR.CTR_NUMAGR = CTR.CTR_NUMDUP ';
  Result := Result + '                 AND SUBAGR.CTR_EMPAGR = CTR.CTR_CODEMP ';
  Result := Result + '                 AND SUBAGR.CTR_CODCLI = CTR.CTR_CODCLI) , 0)), 0))) ';
end;

function TLanConPCR.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConPCR.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConPCR.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Provisão de Contas a Receber Concluído!', ['&OK']);
end;

procedure TLanConPCR.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConPCR.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConPCR.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  If Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TLanConPCR.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
