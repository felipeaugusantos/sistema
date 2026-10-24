unit Contabilidade.Classes.TLanConAGP;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConAGP = Class(TInterfacedObject, ITipLanCon)
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

{ TLanConAGP }

constructor TLanConAGP.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
end;

destructor TLanConAGP.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConAGP.fCarregaDados: Boolean;
Var
  strSQL : String;
begin
  strSQL := '' ;
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  ORIGEM, ';
  strSQL := strSQL + '  CODEMP, ';
  strSQL := strSQL + '  NUMDOC, ';
  strSQL := strSQL + '  CTP_PARCEL, ';
  strSQL := strSQL + '  DTAENT, ';
  strSQL := strSQL + '  CASE WHEN CTP_VALOR2 IS NOT NULL and ORIGEM = "AGR" THEN CTP_VALOR2 ELSE CTP_VALORI END AS CTP_VALORI, ';
  strSQL := strSQL + '  CODEVE, ';
  strSQL := strSQL + '  SERIE_, ';
  strSQL := strSQL + '  CODIGO_PORTADOR, ';
  strSQL := strSQL + '  CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '  NOME, ';
  strSQL := strSQL + '  CNPJ, ';
  strSQL := strSQL + '  PLANCO, ';
  strSQL := strSQL + '  CODCTA, ';
  strSQL := strSQL + '  CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + '  PLAPOR, ';
  strSQL := strSQL + '  CTPINC, ';
  strSQL := strSQL + '  AG_INC, ';
  strSQL := strSQL + '  DOCORI, ';
  strSQL := strSQL + '  ESPORI, ';
  strSQL := strSQL + '  HIST01, ';
  strSQL := strSQL + '  CAD_EXPAUT, ';
  strSQL := strSQL + '  TABELA, ';
  strSQL := strSQL + '  CLAFIS, ';
  strSQL := strSQL + '  CDE_CODEMP, ' ;
  strSQL := strSQL + '  CDE_NOMEMP, ' ;
  strSQL := strSQL + '  CDE_C_G_C_ ' ;
  strSQL := strSQL + '   FROM ( ';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  CAST(CASE WHEN P.CTP_VALORI < 0 THEN "CRE" ELSE "AGR" END AS CHAR(3)) AS ORIGEM, ';
  strSQL := strSQL + '  P.CTP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  P.CTP_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '  P.CTP_PARCEL, ';
  strSQL := strSQL + '  P.CTP_DTACAD AS DTAENT, ';
  strSQL := strSQL + '  ABS(P.CTP_VALORI) AS CTP_VALORI, ';
  strSQL := strSQL + '  P.CTP_CODEVE AS CODEVE, ';
  strSQL := strSQL + '  P.CTP_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  P.CTP_CODPOR  AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '  FOR_CODFOR AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '  FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '  FOR_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '  IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '  IFNULL(CTANCO_CAD.NCO_CODCON, CTACAD.CTA_PLANCO) AS CODCTA, ';
  strSQL := strSQL + '  IFNULL(CTANCO_CAD.NCO_CODCTA, CTACAD.CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + '  IFNULL(PORNCO.NCO_CODPOR, PORCAD.POR_CODPOR) AS PLAPOR, ';
  strSQL := strSQL + '  P.AUTOINCREM AS CTPINC, ';
  strSQL := strSQL + '  P.AUTOINCREM AS AG_INC, ';
  strSQL := strSQL + '  "" AS DOCORI, ';
  strSQL := strSQL + '  "" AS ESPORI, ';
  strSQL := strSQL + '  P.CTP_HIST01 AS HIST01, ';
  strSQL := strSQL + '  PORCAD.POR_EXPAUT AS CAD_EXPAUT, ';
  strSQL := strSQL + '  "CADPAG" AS TABELA,  ';
  strSQL := strSQL + '  CAST("" AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '  (SELECT CTP_VALANT FROM CADPAG SUB WHERE SUB.CTP_CODFOR = P.CTP_CODFOR AND SUB.CTP_NUMDUP = P.CTP_NUMDUP AND SUB.CTP_PARCEL = P.CTP_PARCEL AND SUB.CTP_CODEMP = P.CTP_CODEMP AND SUB.CTP_SEQBAI = 1) AS CTP_VALOR2, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(3)) AS CDE_CODEMP, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(45)) AS CDE_NOMEMP, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(20)) AS CDE_C_G_C_  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '  CADPAG P ';
  strSQL := strSQL + '   JOIN CADEMP ON P.CTP_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = P.CTP_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADPOR PORCAD ON PORCAD.POR_CODPOR = P.CTP_CODPOR ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CTACAD ON CTACAD.CTA_CODCTA = P.CTP_CODCTA ';
  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = PORCAD.POR_CODPOR ';
  strSQL := strSQL + '                       AND PORNCO.NCO_CODEMP = P.CTP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                       AND FORNCO.NCO_CODEMP = P.CTP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCO_CAD ON CTANCO_CAD.NCO_CODCTA = P.CTP_CODCTA ';
  strSQL := strSQL + '                                  AND CTANCO_CAD.NCO_CODEMP = P.CTP_CODEMP ';
  strSQL := strSQL + ' WHERE LEFT(P.CTP_NUMDUP,2) = "AG"  AND P.CTP_SEQBAI = 0 ';

  // Req. 470760: os dois ramos tem chaves de tabelas diferentes (CADPAG e DUPAGP) e os contadores
  // se repetem entre elas; no reprocesso a lista vem com 'chave|tabela'.
  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros, 'CONCAT(P.AUTOINCREM, ''|CADPAG'')', 'P.AUTOINCREM'))
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND P.CTP_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' UNION ALL ';

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '    CAST(CASE WHEN AGR.CTP_VALDUP < 0 THEN "DEV" ELSE "TIT" END AS CHAR(3)) AS ORIGEM, ';
  strSQL := strSQL + '    P.CTP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '    P.CTP_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '    P.CTP_PARCEL, ';
  strSQL := strSQL + '    P.CTP_DTACAD AS DTAENT, ';
  strSQL := strSQL + '    ABS(AGR.CTP_VALORI) AS CTP_VALORI , ';
  strSQL := strSQL + '    P.CTP_CODEVE AS CODEVE, ';
  strSQL := strSQL + '    P.CTP_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '    P.CTP_CODPOR  AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '    FOR_CODFOR AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '    FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '    FOR_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '    IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '    IFNULL(CTANCO_CAD.NCO_CODCON, CTACAD.CTA_PLANCO) AS CODCTA, ';
  strSQL := strSQL + '    IFNULL(CTANCO_CAD.NCO_CODCTA, CTACAD.CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  strSQL := strSQL + '    IFNULL(PORNCO.NCO_CODPOR, PORCAD.POR_CODPOR) AS PLAPOR, ';
  strSQL := strSQL + '    AGR.AUTOINCREM AS CTPINC, ';
  strSQL := strSQL + '    P.AUTOINCREM AS AG_INC, ';
  strSQL := strSQL + '    AGR.CTP_NUMDUP AS DOCORI, ';
  strSQL := strSQL + '    "" AS ESPORI, ';
  strSQL := strSQL + '    P.CTP_HIST01 AS HIST01, ';
  strSQL := strSQL + '    PORCAD.POR_EXPAUT AS CAD_EXPAUT, ';
  strSQL := strSQL + '    "DUPAGP" AS TABELA, ';
  strSQL := strSQL + '    CAST("" AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '    0.00 AS CTP_VALOR2, ';
  strSQL := strSQL + '    AGR.CTP_CODEMP AS CDE_CODEMP, ';
  strSQL := strSQL + '    EAG.EMP_NOMEMP AS CDE_NOMEMP, ';
  strSQL := strSQL + '    EAG.EMP_C_G_C_ AS CDE_C_G_C_ ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '  CADPAG P ';
  strSQL := strSQL + '  JOIN CADEMP ON P.CTP_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADFOR ON FOR_CODFOR = P.CTP_CODFOR ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADPOR PORCAD ON PORCAD.POR_CODPOR = P.CTP_CODPOR ';
  strSQL := strSQL + '  LEFT JOIN CADCTA CTACAD ON CTACAD.CTA_CODCTA = P.CTP_CODCTA ';
  strSQL := strSQL + '  LEFT JOIN CADCTA CTABAI ON CTABAI.CTA_CODCTA = P.CTP_CTABAI ';
  strSQL := strSQL + '  LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = PORCAD.POR_CODPOR ';
  strSQL := strSQL + '                      AND PORNCO.NCO_CODEMP = P.CTP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                      AND FORNCO.NCO_CODEMP = P.CTP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CTANCO CTANCO_CAD ON CTANCO_CAD.NCO_CODCTA = P.CTP_CODCTA ';
  strSQL := strSQL + '                                 AND CTANCO_CAD.NCO_CODEMP = P.CTP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN DUPAGP AGR ON AGR.CTP_NUMAGR = P.CTP_NUMDUP ';
  strSQL := strSQL + '                          AND AGR.CTP_EMPAGR = P.CTP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADEMP EAG ';
  strSQL := strSQL + '       ON AGR.CTP_CODEMP = EAG.EMP_CODEMP ';
  strSQL := strSQL + '  WHERE LEFT(P.CTP_NUMDUP,2) = "AG" AND P.CTP_PARCEL = "A" AND P.CTP_SEQBAI = 0 ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros, 'CONCAT(AGR.AUTOINCREM, ''|DUPAGP'')', 'P.AUTOINCREM'))
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND P.CTP_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + ' ) AS SEL ';
  strSQL := strSQL + ' ORDER BY NUMDOC, CODIGO_CLIENTE_FORNECEDOR, CODEMP, ORIGEM ';

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConAGP.fDeletaLanCon: Boolean;
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
    /// apaga lançamentos do dupagp
    LqryDel := fCriaQuery(Nil);
    Try
      LqryDel.Close;
      LqryDel.SQL.Clear;
      LqryDel.SQL.Add(' DELETE ');
      LqryDel.SQL.Add('   FROM LANCON ');
      LqryDel.SQL.Add('  WHERE CON_TIPLAN = "AGP" ');
      LqryDel.SQL.Add('    AND CON_AUTOMA = 1 ');

      LqryDel.SQL.Add('  AND CON_INCDOC IN ( SELECT AGR.AUTOINCREM ');
      LqryDel.SQL.Add('  FROM CADPAG P ');
      LqryDel.SQL.Add('    LEFT JOIN DUPAGP AGR ON AGR.CTP_NUMAGR = P.CTP_NUMDUP ');
      LqryDel.SQL.Add('                         AND AGR.CTP_EMPAGR = P.CTP_CODEMP ');
      LqryDel.SQL.Add('  WHERE TRUE ');

      TTrataIncDocContabil
        .New
        .fColunaIncDoc('P.AUTOINCREM')
        .fIncDoc(recParCon.strIncDoc)
        .fArrIncDoc(recParCon.arrIncDoc)
        .fQuerySql(LqryDel)
        .fExecute ;

      LqryDel.SQL.Add('  ) ');

      LqryDel.ExecSQL;
    Finally
      FreeAndNil(LqryDel);
    End;
    /// apaga lançamentos do CTP
    Result := Generico.fDeletaLanCon;
  end
  else
  begin
    Result := Generico.fDeletaLanCon;
  end ;
end;

function TLanConAGP.fEfetuaLancamentos: Boolean;
Var
  intRecCount : Integer;
  strPlaCta : String;
  strEveNec: string;
  strOrigem: string;
  lstControle: TStringList ;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  strEveNec := fRetornaEventosNaoExportar;

  lstControle := TStringList.Create ;
  try
    lstControle.Sorted := True ;
    ///analisa, se não tiver o lançamento TIT ignora o lançamento AGR
    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      if (pos(qryDados.FieldByName('ORIGEM').AsString,'DEV_TIT') <> 0) AND (qryDados.FieldByName('CTP_VALORI').IsNull) then
      begin
        lstControle.Add(qryDados.FieldByName('CTPINC').AsString) ;
      end;
      qryDados.Next;
    End;

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      pgbProgresso.Position := qryDados.RecNo;
      pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "AGP": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));
      Application.ProcessMessages;

      if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
         and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
        qryDados.Next;
        Continue;
      end;

      if lstControle.IndexOf(qryDados.FieldByName('CTPINC').AsString) <> -1 then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Origem AGR/CRE não possui lançamentos de origem TIT/DEV'), qryDados);
        qryDados.Next;
        Continue;
      end;

      strPlaCta := qryDados.FieldByName('CODCTA').AsString;
      strOrigem := qryDados.FieldByName('ORIGEM').AsString;
      Generico.pGravaLancto('CTP_VALORI', DES_VALOR_ORIGINAL, strPlaCta, '', '', '', strOrigem);

      qryDados.Next;
    End;

  finally
    FreeAndNil(lstControle) ;
  end;

  Result := True;
end;

function TLanConAGP.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConAGP.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConAGP.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConAGP.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Agrupamento de Contas a Pagar Concluído!', ['&OK']);
end;

procedure TLanConAGP.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConAGP.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConAGP.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  If Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TLanConAGP.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
