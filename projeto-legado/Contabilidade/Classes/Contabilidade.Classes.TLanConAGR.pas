unit Contabilidade.Classes.TLanConAGR;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConAGR = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
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

{ TLanConAGR }

constructor TLanConAGR.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
end;

destructor TLanConAGR.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConAGR.fCarregaDados: Boolean;
Var
  strSQL : String;
begin
  strSQL := '' ;
  strSQL := strSQL + ' SELECT SEL.* FROM ( ';
  strSQL := strSQL + '  SELECT CAST(CASE WHEN CTR.CTR_GRVORI < 0 THEN "CRE" ELSE "AGR" END AS CHAR(3)) AS ORIGEM, ';
  strSQL := strSQL + '         ABS(CTR.CTR_GRVORI) AS CTR_VALORI, ';
  strSQL := strSQL + '         CTR.CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '         CTR.CTR_DTACAD AS DTAENT, ';
  strSQL := strSQL + '         CTR.CTR_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '         CTR.CTR_CODEMP, ';
  strSQL := strSQL + '         CTR.CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '         CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '         CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '         "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '         IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '         IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '         IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '         IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '         CAST("" AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '         IFNULL(POR_EXPAUT, "S") AS POR_EXPAUT, ';
  strSQL := strSQL + '         IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CODCTA, ';
  strSQL := strSQL + '         IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + '         CAST("" AS CHAR(1)) AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + '         CTR.CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + '         CTA_PROCON, ';
  strSQL := strSQL + '         CTR.AUTOINCREM AS CTRINC, ';
  strSQL := strSQL + '         CTR.AUTOINCREM AS AG_INC, ';
  strSQL := strSQL + '         CAST("" AS CHAR(1)) AS DOCORI, ';
  strSQL := strSQL + '         CAST("" AS CHAR(1)) AS ESPORI, ';
  strSQL := strSQL + '         CTR.CTR_CODEVE AS CODEVE, ';
  strSQL := strSQL + '         "CADREC" AS TABELA, ';
  strSQL := strSQL + '         CAST(0.00 AS DECIMAL(12,2)) AS CTR_VALDES, ';
  strSQL := strSQL + '         CAST(0.00 AS DECIMAL(12,2)) AS CTR_VALJUR, ';
  strSQL := strSQL + '         CAST(NULL AS CHAR(3)) AS CDE_CODEMP, ';
  strSQL := strSQL + '         CAST(NULL AS CHAR(45)) AS CDE_NOMEMP, ';
  strSQL := strSQL + '         CAST(NULL AS CHAR(20)) AS CDE_C_G_C_ ';
  strSQL := strSQL + '    FROM CADREC CTR ';
  strSQL := strSQL + '    LEFT JOIN CADCLI ON CLI_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '    LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '    LEFT JOIN CADCTA ON CTA_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '    LEFT JOIN CADPOR ON CTR.CTR_CODPOR = POR_CODPOR ';

  strSQL := strSQL + '    LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '    LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = CTR.CTR_CODPOR ';
  strSQL := strSQL + '                    AND PORNCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '    LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '                    AND CTANCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '   WHERE CTR.CTR_ESPDOC = "AG" AND CTR.CTR_SEQBAI = 0 ';

  // Req. 470760: os dois ramos tem chaves de tabelas diferentes (CADREC e DUPAGR) e os contadores
  // se repetem entre elas; no reprocesso a lista vem com 'chave|tabela'.
  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros, 'CONCAT(CTR.AUTOINCREM, ''|CADREC'')', 'CTR.AUTOINCREM'))
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND CTR.CTR_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND CTR.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' UNION ALL ';

  strSQL := strSQL + '  SELECT CAST(CASE WHEN AGR.CTR_VALDUP < 0 THEN "DEV" ELSE "TIT" END AS CHAR(3)) AS ORIGEM, ';
  strSQL := strSQL + '         ABS(AGR.CTR_VALORI) AS CTR_VALORI, ';
  strSQL := strSQL + '         CTR.CTR_CODEMP AS CODEMP, ';
  strSQL := strSQL + '         CTR.CTR_DTACAD AS DTAENT, ';
  strSQL := strSQL + '         CTR.CTR_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '         CTR.CTR_CODEMP, ';
  strSQL := strSQL + '         CTR.CTR_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '         CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '         CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '         "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '         IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '         IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '         IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '         IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '         CAST("" AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '         IFNULL(POR_EXPAUT, "S") AS POR_EXPAUT, ';
  strSQL := strSQL + '         IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CODCTA, ';
  strSQL := strSQL + '         IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + '         CAST("" AS CHAR(1)) AS TIPO_PAGAMENTO, ';
  strSQL := strSQL + '         CTR.CTR_PARCEL AS PARCEL, ';
  strSQL := strSQL + '         CTA_PROCON, ';
  strSQL := strSQL + '         AGR.AUTOINCREM AS CTRINC, ';
  strSQL := strSQL + '         CTR.AUTOINCREM AS AG_INC, ';
  strSQL := strSQL + '         AGR.CTR_NUMDUP AS DOCORI, ';
  strSQL := strSQL + '         AGR.CTR_ESPDOC AS ESPORI, ';
  strSQL := strSQL + '         CTR.CTR_CODEVE AS CODEVE, ';
  strSQL := strSQL + '         "DUPAGR" AS TABELA, ';
  strSQL := strSQL + '         AGR.CTR_VALDES, ';
  strSQL := strSQL + '         AGR.CTR_VALJUR, ';
  strSQL := strSQL + '         AGR.CTR_CODEMP AS CDE_CODEMP, ';
  strSQL := strSQL + '         EAG.EMP_NOMEMP AS CDE_NOMEMP, ';
  strSQL := strSQL + '         EAG.EMP_C_G_C_ AS CDE_C_G_C_ ';
  strSQL := strSQL + '    FROM CADREC CTR ';
  strSQL := strSQL + '    LEFT JOIN CADCLI ON CLI_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '    LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  strSQL := strSQL + '    LEFT JOIN CADCTA ON CTA_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '    LEFT JOIN CADPOR ON CTR.CTR_CODPOR = POR_CODPOR ';

  strSQL := strSQL + '    LEFT JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ';
  strSQL := strSQL + '                       AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ';
  strSQL := strSQL + '                       AND AGR.CTR_CODCLI = CTR.CTR_CODCLI ';
  strSQL := strSQL + '                       AND CTR.CTR_ESPDOC = "AG" ';

  strSQL := strSQL + '    LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '    LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = CTR.CTR_CODPOR ';
  strSQL := strSQL + '                    AND PORNCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '    LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTR.CTR_CODCTA ';
  strSQL := strSQL + '                    AND CTANCO.NCO_CODEMP = CTR.CTR_CODEMP ';

  strSQL := strSQL + '    LEFT JOIN CADEMP EAG ';
  strSQL := strSQL + '      ON AGR.CTR_CODEMP = EAG.EMP_CODEMP ';

  strSQL := strSQL + '   WHERE CTR.CTR_ESPDOC = "AG" AND CTR.CTR_PARCEL = "A" AND CTR.CTR_SEQBAI = 0 ';

  strSQL := strSQL + '   AND IFNULL(AGR.CTR_ESPDOC, "") NOT IN ("FF", "TR", "DV", "MI") ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros, 'CONCAT(AGR.AUTOINCREM, ''|DUPAGR'')', 'CTR.AUTOINCREM'))
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND CTR.CTR_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND CTR.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' ) AS SEL ';
  strSQL := strSQL + ' ORDER BY NUMDOC, CODIGO_CLIENTE_FORNECEDOR, CODEMP, ORIGEM ';

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConAGR.fDeletaLanCon: Boolean;
var
  LqryDel: TUniQuery ;
begin
  // Req. 470760: no reprocesso o generico apaga por chave+tabela, o que ja cobre titulo e agrupadora.
  if recParCon.blnReprocessaErros then
    Exit(Generico.fDeletaLanCon);

  If (Not fEmptyStr(recParCon.strIncDoc)) or (Length(recParCon.arrIncDoc) > 0) Then
  begin
    if not generico.fEfetuaDelecaoLanCon then
    begin
      Exit(True);
    end ;
    /// apaga lançamentos do dupagr
    LqryDel := fCriaQuery(Nil);
    Try
      LqryDel.Close;
      LqryDel.SQL.Clear;
      LqryDel.SQL.Add(' DELETE ');
      LqryDel.SQL.Add('   FROM LANCON ');
      LqryDel.SQL.Add('  WHERE CON_TIPLAN = "AGR" ');
      LqryDel.SQL.Add('    AND CON_AUTOMA = 1 ');

      LqryDel.SQL.Add('  AND CON_INCDOC IN ( SELECT AGR.AUTOINCREM ');
      LqryDel.SQL.Add('                        FROM CADREC CTR ');
      LqryDel.SQL.Add('                             LEFT JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = CTR.CTR_NUMDUP ');
      LqryDel.SQL.Add('		                               AND AGR.CTR_EMPAGR = CTR.CTR_CODEMP ');
      LqryDel.SQL.Add('		                               AND AGR.CTR_CODCLI = CTR.CTR_CODCLI ');
      LqryDel.SQL.Add('		                               AND CTR.CTR_ESPDOC = "AG" ');
      LqryDel.SQL.Add('  WHERE TRUE ');

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('CTR.AUTOINCREM')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(LqryDel)
        .fExecute ;

      LqryDel.SQL.Add('  ) ');

      LqryDel.ExecSQL;
    Finally
      FreeAndNil(LqryDel);
    End;
    /// apaga lançamentos do ctr
    Result := Generico.fDeletaLanCon;
  end
  else
  begin
    Result := Generico.fDeletaLanCon;
  end ;
end;

function TLanConAGR.fEfetuaLancamentos: Boolean;
Var
  intRecCount : Integer;
  strPlaCta : String;
  strEveNec: string;
  strOrigem: string;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  strEveNec := fRetornaEventosNaoExportar;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "AGR": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));
    Application.ProcessMessages;

    if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
       and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    strPlaCta := qryDados.FieldByName('CODCTA').AsString;
    strOrigem := qryDados.FieldByName('ORIGEM').AsString;
    Generico.pGravaLancto('CTR_VALORI', DES_VALOR_ORIGINAL, strPlaCta, '', '', '', strOrigem);
    Generico.pGravaLancto('CTR_VALDES', DES_VALOR_DESCONTO, strPlaCta, '', '', '', strOrigem);
    Generico.pGravaLancto('CTR_VALJUR', DES_VALOR_JUROS, strPlaCta, '', '', '', strOrigem);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConAGR.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConAGR.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConAGR.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConAGR.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Agrupamento de Contas a Receber Concluído!', ['&OK']);
end;

procedure TLanConAGR.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConAGR.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConAGR.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  If Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TLanConAGR.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
