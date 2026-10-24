unit Contabilidade.Classes.TLanConADT;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls, Contabilidade.SQL;

type
  TLanConADT = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    blnContaNaBandeiraExiste : Boolean;
    blnBanNcoExiste : boolean;
    blnAdvParcelExiste: boolean;
    blnAdvOrigemExiste: boolean;
    FblnADT_DTABAN_Existe: Boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fGetFiltroSQLAdtCli(recParams: TParamsContasReceber): string;
    function fGetSQLAdtCli(recParams: TParamsContasReceber): string;
    function fSQLContaBandeiraADT(strCampoSeqCon: String; blnBanNcoExiste: boolean): string;
    function fSQLCodigoBandeiraADT(strCampoSeqCon: String; blnBanNcoExiste: boolean): string;
    function fTemAdtOriginal(const ANumDoc, ACodEmp:string): boolean;
    function fCampoDtaLan: String ;
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
Contabilidade.Classes.TTrataIncDoc;

{ TLanConADT }

constructor TLanConADT.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  blnContaNaBandeiraExiste := fCampoExiste('CADBAN', 'BAN_PLANCO');
  blnBanNcoExiste := fTabelaExiste('BANNCO');
  blnAdvParcelExiste := fCampoExiste('ADTCLI', 'ADT_PARCEL');
  blnAdvOrigemExiste := fCampoExiste('ADTCLI', 'ADT_ORIGEM');
  FblnADT_DTABAN_Existe := fCampoExiste('ADTCLI', 'ADT_DTABAN');
end;

destructor TLanConADT.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConADT.fCampoDtaLan: String;
begin
  Result := 'ADTCLI.ADT_DTALAN' ;
  if FblnADT_DTABAN_Existe then
    Result := 'IFNULL(ADTCLI.ADT_DTABAN, ADTCLI.ADT_DTALAN)' ;
end;

function TLanConADT.fCarregaDados: Boolean;
Var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := recParCon.strCodEmp;
  recParams.blnContaNaBandeiraExiste := blnContaNaBandeiraExiste;
  recParams.blnBanNcoExiste := blnBanNcoExiste;
  recParams.blnCFG_EXCREP := False;
  recParams.dtaDtaIni := recParCon.dtaDtaIni;
  recParams.dtaDtaFin := recParCon.dtaDtaFin;
  recParams.strIncDoc := recParCon.strIncDoc;
  recParams.arrIncDoc := recParCon.arrIncDoc;
  recParams.blnAdvParcelExiste := blnAdvParcelExiste;
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fGetSQLAdtCli(recParams) );

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConADT.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConADT.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPagame : String;
    strPlaCta : String;
    strCodEve: string;
    recParGrava : TParametrosGravaLanCon;
    LstrPortadorRCX : string ;
    LstrPlancoPortadorRCX : string ;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  LstrPortadorRCX := fCfgAdtOrd ;
  LstrPlancoPortadorRCX := fCampoTabela('POR_PLANCO', 'CADPOR', ['POR_CODPOR'], [LstrPortadorRCX]) ;
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "ADT": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    if (qryDados.FieldByName('ADT_ORIGEM').AsString = 'RCX')
       and (qryDados.FieldByName('ADT_VALORD').AsFloat <> 0.00)
       and (not fEmptyStr(LstrPortadorRCX)) then
    begin
      qryDados.Edit ;
      qryDados.FieldByName('CODIGO_PORTADOR').AsString := LstrPortadorRCX ;
      qryDados.FieldByName('PLAPOR').AsString := LstrPlancoPortadorRCX ;
      qryDados.Post ;
    end;


    if (qryDados.FieldByName('FATURADO_DE_PEDIDO_CAPA').AsInteger+qryDados.FieldByName('FATURADO_DE_PEDIDO_ITENS').AsInteger) > 0 then
    begin
      if fTemAdtOriginal(qryDados.FieldByName('NUMDOC').AsString, qryDados.FieldByName('CODEMP').AsString) then
      begin
        Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'ADT proveniente de pedido que foi faturado de outro pedido!'), qryDados);
        qryDados.Next;
        Continue;
      end;
    end;

    FillChar(recParGrava, SizeOf(recParGrava), #0);
    recParGrava.blnEstorno := False ;
    Generico.pSetaParametrosGravacao(recParGrava);

    strPagame := '';
    strCodEve := '';
    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;

    //CRÉDITO
    Generico.pGravaLancto('ADT_VALCRE', DES_VALOR_RECEBIDO, strPlaCta, FPG_CREDITO, strCodEve, strPagame);

    //DINHEIRO
    Generico.pGravaLancto('ADT_VALDIN', DES_VALOR_RECEBIDO, strPlaCta, FPG_DINHEIRO, strCodEve, strPagame);

    //CHEQUE A VISTA
    Generico.pGravaLancto('ADT_VALCHV', DES_VALOR_RECEBIDO, strPlaCta, FPG_CHEQUE_VISTA, strCodEve, strPagame);

    //CHEQUE PRÉ
    Generico.pGravaLancto('ADT_VALCHP', DES_VALOR_RECEBIDO, strPlaCta, FPG_CHEQUE_PRE, strCodEve, strPagame);

    //CARTÃO
    Generico.pGravaLancto('ADT_VALCAR', DES_VALOR_RECEBIDO, strPlaCta, FPG_CARTAO, strCodEve, strPagame);

    //ORDEM DE PAGAMENTO
    Generico.pGravaLancto('ADT_VALORD', DES_VALOR_RECEBIDO, strPlaCta, FPG_ORDPAG, strCodEve, strPagame);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConADT.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConADT.fGetFiltroSQLAdtCli(
  recParams: TParamsContasReceber): string;
var
  strSQL : string ;
begin
  strSQL := '' ;
  If (Not recParams.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND ADTCLI.ADT_CODEMP = :CODEMP ';

  if (recParams.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND ' + fCampoDtaLan + ' BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      // Req. 470760: o LANCON guarda NUMDOC+ESPDOC+CODEMP (TChaveDocInterprete), nao o AUTOINCREM;
                      // o robo segue no AUTOINCREM, que e o que a CONLOG traz.
                      .fColunaIncDoc(IfThen(recParCon.blnReprocessaErros,
                                            'CONCAT(ADTCLI.ADT_NUMDOC, ADTCLI.ADT_ESPDOC, ADTCLI.ADT_CODEMP)',
                                            'ADTCLI.AUTOINCREM'))
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  result := strSQL ;
end;

function TLanConADT.fGetSQLAdtCli(
  recParams: TParamsContasReceber): string;
  Var
    strSQL : String;
begin
  strSQL := strSQL + ' SELECT ADTCLI.ADT_VALDIN, ';
  strSQL := strSQL + '        ADTCLI.ADT_VALCHP, ';
  strSQL := strSQL + '        ADTCLI.ADT_VALCHV, ';
  strSQL := strSQL + '        ADTCLI.ADT_VALCAR, ';
  strSQL := strSQL + '        ADTCLI.ADT_VALORD, ';
  strSQL := strSQL + '        ADTCLI.ADT_VALCRE, ';
  strSQL := strSQL + '        ADTCLI.ADT_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        ' + fCampoDtaLan + ' AS DTAENT, ';
  strSQL := strSQL + '        ' + fCampoDtaLan + ' AS DTACAD, ';
  strSQL := strSQL + '        ADTCLI.ADT_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '        ADTCLI.ADT_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '        CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '        CLI_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '        "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '        "" AS CLAFIS, ';
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, '; // CODCTA
  strSQL := strSQL + ' IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  if recParams.blnAdvParcelExiste then
    strSQL := strSQL + ' ADTCLI.ADT_PARCEL AS PARCEL, '
  else
    strSQL := strSQL + ' CAST(NULL AS CHAR(3)) AS PARCEL, ' ;
  strSQL := strSQL + ' ( SELECT GROUP_CONCAT(CADCHQ.CHQ_NUMCHQ) ';
  strSQL := strSQL + '     FROM CADCHQ ';
  strSQL := strSQL + '    WHERE CADCHQ.CHQ_SEQCON = ADTCLI.ADT_SEQCON ) AS CHQ_NUMCHQ, ';

  if (recParams.blnContaNaBandeiraExiste) then
  begin
    strSQL := strSQL + fSQLContaBandeiraADT('ADTCLI.ADT_SEQCON', recParams.blnBanNcoExiste) + ' AS CONTA_BANDEIRA, ';
    strSQL := strSQL + fSQLCodigoBandeiraADT('ADTCLI.ADT_SEQCON', recParams.blnBanNcoExiste) + ' AS CODIGO_BANDEIRA, ';
  end
  else
  begin
    strSQL := strSQL + ' "" AS CONTA_BANDEIRA, ';
    strSQL := strSQL + ' "" AS CODIGO_BANDEIRA, ';
  end;

  strSQL := strSQL + '    ADTCLI.AUTOINCREM AS ADTINC, ';
  strSQL := strSQL + '    EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '    ADTCLI.ADT_ESTORN, ';
  strSQL := strSQL + '    ADTCLI.ADT_TIPLAN, ';
  strSQL := strSQL + '    IFNULL((SELECT COUNT(*) FROM FATGOR WHERE FGO_NUMFAT = ADTCLI.ADT_NUMDOC AND FGO_TIPFAT = ADTCLI.ADT_ESPDOC AND FGO_EMPFAT = ADTCLI.ADT_CODEMP AND FGO_CODCLI = ADTCLI.ADT_CODCLI AND FGO_ESPDOC = "PD"), 0) FATURADO_DE_PEDIDO_CAPA, ';
  strSQL := strSQL + '    IFNULL((SELECT COUNT(*) FROM FATDOR WHERE FDO_NUMFAT = ADTCLI.ADT_NUMDOC AND FDO_TIPFAT = ADTCLI.ADT_ESPDOC AND FDO_EMPFAT = ADTCLI.ADT_CODEMP AND FDO_CODCLI = ADTCLI.ADT_CODCLI AND FDO_ESPDOC = "PD"), 0) FATURADO_DE_PEDIDO_ITENS, ';
  if blnAdvOrigemExiste then
  begin
    strSQL := strSQL + '    ADTCLI.ADT_ORIGEM ';
  end
  else
  begin
    strSQL := strSQL + '    CAST(NULL AS CHAR(3)) AS ADT_ORIGEM ';
  end;
  strSQL := strSQL + '   FROM ADTCLI ';
  strSQL := strSQL + '   JOIN CADEMP ON ADTCLI.ADT_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '   JOIN CADCLI ON CLI_CODCLI = ADTCLI.ADT_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN ADTCLI ADTCAN ON ADTCAN.ADT_CODCLI = ADTCLI.ADT_CODCLI ';
  strSQL := strSQL + '                        AND ADTCAN.ADT_CODEMP = ADTCLI.ADT_CODEMP ';
  strSQL := strSQL + '                        AND ADTCAN.ADT_ESPDOC = ADTCLI.ADT_ESPDOC ';
  strSQL := strSQL + '                        AND ADTCAN.ADT_NUMDOC = ADTCLI.ADT_NUMDOC ';
  strSQL := strSQL + '                        AND ADTCAN.ADT_TIPLAN = "D" ';
  strSQL := strSQL + '                        AND ADTCAN.ADT_DESCRI LIKE "Cancelamento de pedido%" ';
  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = ADTCLI.ADT_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADPOR ON POR_CODPOR = ADTCLI.ADT_CODPOR ';
  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = ADTCLI.ADT_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = ADTCLI.ADT_CODCTA ';
  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTA_CODCTA ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = ADTCLI.ADT_CODEMP ';
  strSQL := strSQL + '  WHERE ADTCLI.ADT_TIPLAN = "C" AND ADTCLI.ADT_ESTORN = "N" AND ADTCAN.ADT_NUMDOC IS NULL ';

  strSQL := strSQL + fGetFiltroSQLAdtCli(recParams) ;

  strSQL := strSQL + '  ORDER BY ADTCLI.AUTOINCREM ';

  Result := strSQL;
end;

function TLanConADT.fTemAdtOriginal(const ANumDoc, ACodEmp:string): boolean;
var
  qryConsultaPedido: TUniQuery ;
  qryAdtOriginal: TUniQuery ;
  blnTemOriginal: boolean ;
begin
  result := False ;
  qryConsultaPedido := fCriaQuery() ;
  qryAdtOriginal := fCriaQuery() ;
  try
    qryConsultaPedido.Close ;
    qryConsultaPedido.SQL.Clear ;
    qryConsultaPedido.SQL.Add(' SELECT DISTINCT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP FROM ( ') ;
    qryConsultaPedido.SQL.Add('  SELECT DISTINCT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP FROM FATGOR WHERE FGO_NUMFAT = :NUMDOC AND FGO_TIPFAT = "PD" AND FGO_EMPFAT = :CODEMP ') ;
    qryConsultaPedido.SQL.Add('  UNION ALL ') ;
    qryConsultaPedido.SQL.Add('  SELECT DISTINCT FDO_NUMDOC, FDO_ESPDOC, FDO_CODEMP FROM FATDOR WHERE FDO_NUMFAT = :NUMDOC AND FDO_TIPFAT = "PD" AND FDO_EMPFAT = :CODEMP ') ;
    qryConsultaPedido.SQL.Add(' ) AS SEL ') ;
    qryConsultaPedido.ParamByName('NUMDOC').AsString := ANumDoc ;
    qryConsultaPedido.ParamByName('CODEMP').AsString := ACodEmp ;
    qryConsultaPedido.Open ;
    qryConsultaPedido.First ;
    blnTemOriginal := False ;
    while not qryConsultaPedido.Eof do
    begin
      // verifica se tem o adt original
      qryAdtOriginal.Close ;
      qryAdtOriginal.SQL.Clear ;
      qryAdtOriginal.SQL.Add('SELECT AUTOINCREM FROM ADTCLI WHERE ADT_NUMDOC = :NUMDOC AND ADT_CODEMP = :CODEMP AND ADT_TIPLAN = "C" AND ADT_ESTORN = "N" ') ;
      qryAdtOriginal.ParamByName('NUMDOC').AsString := qryConsultaPedido.FieldByName('FGO_NUMDOC').AsString ;
      qryAdtOriginal.ParamByName('CODEMP').AsString := qryConsultaPedido.FieldByName('FGO_CODEMP').AsString ;
      qryAdtOriginal.Open ;
      if not qryAdtOriginal.IsEmpty then
      begin
        blnTemOriginal := true ;
      end;
      qryConsultaPedido.Next ;
    end;
    if blnTemOriginal then
    begin
      result := True ;
      exit ;
    end;
  finally
    FreeAndNil(qryConsultaPedido) ;
    FreeAndNil(qryAdtOriginal) ;
  end;
end;

function TLanConADT.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConADT.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConADT.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Adiantamento Concluído!', ['&OK']);
end;

procedure TLanConADT.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConADT.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConADT.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if assigned(lblGravando) then
    lblGravando.Caption := strTexto
  else if Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    lblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    lblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;

procedure TLanConADT.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

function TLanConADT.fSQLCodigoBandeiraADT(strCampoSeqCon: String; blnBanNcoExiste: boolean): string;
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

  Result := Result + '  WHERE MCA_SEQCON = ' + strCampoSeqCon;

  if (blnBanNcoExiste) then
    Result := Result + '    AND ((BAN_PLANCO IS NOT NULL) OR (BANNCO.NCO_CODCON IS NOT NULL)) '
  else
    Result := Result + '    AND (BAN_PLANCO IS NOT NULL) ';

  Result := Result + '  LIMIT 1) ';
end;

function TLanConADT.fSQLContaBandeiraADT(strCampoSeqCon: String; blnBanNcoExiste: boolean): string;
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

  Result := Result + '  WHERE MCA_SEQCON = ' + strCampoSeqCon;

  if (blnBanNcoExiste) then
    Result := Result + '    AND ((BAN_PLANCO IS NOT NULL) OR (BANNCO.NCO_CODCON IS NOT NULL)) '
  else
    Result := Result + '    AND (BAN_PLANCO IS NOT NULL) ';

  Result := Result + '  LIMIT 1) ';
end;

end.
