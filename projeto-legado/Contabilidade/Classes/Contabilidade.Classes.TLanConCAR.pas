unit Contabilidade.Classes.TLanConCAR;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TDataReferenciaCartao = (drcCadastro, drcRecebimento) ;

  TLanConCAR = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    blnContaNaBandeiraExiste : boolean;
    blnBanNcoExiste : boolean;
    FblnDescontoHub: boolean ;
    FblnFreteHub: boolean ;
    FblnAjusteHub: boolean ;
    FblnMCA_DTABAN_Existe: Boolean;
    FblnMCA_HISBAI_Existe: Boolean;
    function fPlanoDeContas(ATaxa: boolean = false): string;
    function fMontaSqlCartao(const AValorBrutoPelaDataCadastro: Boolean = False; const ADataReferencia: TDataReferenciaCartao = drcRecebimento ): string ;
    function fCampoDtaLan: String ;
    function fCampoDtaRecInterno(const ADataReferencia: TDataReferenciaCartao): String ;
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

{ TLanConCAR }

constructor TLanConCAR.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  blnContaNaBandeiraExiste := fCampoExiste('CADBAN', 'BAN_PLANCO');
  blnBanNcoExiste := fTabelaExiste('BANNCO');
  FblnDescontoHub := False ;
  FblnFreteHub := False ;
  FblnAjusteHub := False ;
  FblnMCA_DTABAN_Existe := fCampoExiste('MOVCAR', 'MCA_DTABAN') ;
  FblnMCA_HISBAI_Existe := fCampoExiste('MOVCAR', 'MCA_HISBAI') ;
end;

destructor TLanConCAR.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConCAR.fCampoDtaLan: String;
begin
  Result := 'MCA_DTAREC' ;
  if FblnMCA_DTABAN_Existe then
    Result := 'IFNULL(MCA_DTABAN, MCA_DTAREC)' ;
end;

function TLanConCAR.fCampoDtaRecInterno(const ADataReferencia: TDataReferenciaCartao): String;
begin
  if fCfgTipCar = 'N' then
    Result := fCampoDtaLan
  else
    if ADataReferencia = drcRecebimento then
      Result := 'MCA_DTAREC'
    else /// data de cadastro
      Result := 'MCA_DTACAD' ;
end;

function TLanConCAR.fCarregaDados: Boolean;
  Var
    strSQL : String;
begin
  FblnDescontoHub := fTemColDescontoHub ;
  FblnFreteHub := fTemColFreteHub ;
  FblnAjusteHub := fTemColAjusteHub ;

  strSQL := '';
  if fCfgTipCar = 'N' then
  begin
    strSQL := fMontaSqlCartao();
  end
  else
  begin
    strSQL := ' (' + fMontaSqlCartao(True, drcCadastro) + ') ' ;
    strSQL := strSQL + ' UNION ALL ' ;
    strSQL := strSQL + ' (' + fMontaSqlCartao(True, drcRecebimento) + ') ' ;
  end;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConCAR.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConCAR.fEfetuaLancamentos: Boolean;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    Generico.pGravaLancto('VALTAX', 'Vr.Taxa', fPlanoDeContas(True));
    Generico.pGravaLancto('VALSTA', 'Vr.Bruto', fPlanoDeContas);
    Generico.pGravaLancto('VALREC', 'Vr.Recebido', fPlanoDeContas);

    Generico.pGravaLancto('MCA_FREMKT', DES_VALOR_FRETE_HUB, fPlanoDeContas);
    Generico.pGravaLancto('MCA_CUPMKT', DES_VALOR_DESCONTO_HUB, fPlanoDeContas);
    Generico.pGravaLancto('MCA_VALAJU', DES_VALOR_AJUSTE_HUB, fPlanoDeContas);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConCAR.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCAR.fPlanoDeContas(ATaxa: boolean = false): string;
begin
  if ATaxa then
    Result := qryDados.FieldByName('CONTA_CTABTX').AsString
  else
    Result := qryDados.FieldByName('CONTA_CTABAI').AsString;
end;

function TLanConCAR.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCAR.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCAR.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Movimento de Cartões Concluído!', ['&OK']);
end;

procedure TLanConCAR.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCAR.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCAR.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

function TLanConCAR.fMontaSqlCartao(const AValorBrutoPelaDataCadastro: Boolean;
  const ADataReferencia: TDataReferenciaCartao): string;
var
  strSQL : String;
  strCampoData : string ;
  strCampoValTax, strCampoValSta, strCampoValRec: string ;
begin
  strCampoData := fCampoDtaRecInterno(ADataReferencia) ;

  if not AValorBrutoPelaDataCadastro then
  begin
    strCampoValTax := 'MCA_VALTAX' ;
    strCampoValSta := 'MCA_VALSTA' ;
    strCampoValRec := 'MCA_VALREC' ;
  end
  else
  begin
    if ADataReferencia = drcRecebimento then
    begin
      strCampoValTax := 'MCA_VALTAX' ;
      strCampoValSta := 'CAST(0.00 AS DECIMAL(12,2))' ;
      strCampoValRec := 'MCA_VALREC' ;
    end
    else /// data de cadastro
    begin
      strCampoValTax := 'CAST(0.00 AS DECIMAL(12,2))' ;
      strCampoValSta := 'MCA_VALSTA' ;
      strCampoValRec := 'CAST(0.00 AS DECIMAL(12,2))' ;
    end;
  end;

  strSQL := '';
  strSQL := strSQL + ' SELECT ' + strCampoValTax + ' AS VALTAX, ' + strCampoValSta + ' AS VALSTA, ';
  strSQL := strSQL + '        ' + strCampoValRec + ' AS VALREC, ""         AS CLAFIS, ';
  strSQL := strSQL + '        "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        CLI_CODCLI AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(CARNCO.NCO_CODCON, IFNULL(CAR_PLANCO, IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO))) AS PLANCO, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODCON, POR_PLANCO) AS PLAPOR, ';
  strSQL := strSQL + '        IFNULL(PORNCO.NCO_CODPOR, POR_CODPOR) AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '        MCA_CODEMP AS CODEMP, MCA_NUMDUP AS NUMDOC, ';
  strSQL := strSQL + '        "CAR" AS ESPDOC, CLI_NOMCLI AS NOME, ';
  strSQL := strSQL + '        CLI_C_G_C_ AS CNPJ, ' + strCampoData + ' AS DTAENT, ';

  if FblnMCA_HisBai_Existe then
    strSQL := strSQL + ' MCA_HISBAI AS HISBAI, '
  else
    strSQL := strSQL + ' "" AS HISBAI, ';

  if (blnContaNaBandeiraExiste) then
  begin
    if blnBanNcoExiste then
      strSQL := strSQL + ' IFNULL(BANNCO.NCO_CODCON, BAN_PLANCO) AS CONTA_BANDEIRA, '
    else
      strSQL := strSQL + ' BAN_PLANCO AS CONTA_BANDEIRA, ';
  end
  else
    strSQL := strSQL + ' CAST(NULL AS CHAR(20)) AS BAN_PLANCO, ';

  strSQL := strSQL + '        MOVCAR.AUTOINCREM AS CARINC, ';
  strSQL := strSQL + '        IFNULL(CTANCOBAI.NCO_CODCON, CTABAI.CTA_PLANCO) AS CONTA_CTABAI, ';
  strSQL := strSQL + '        IFNULL(CTANCOBTX.NCO_CODCON, CTABTX.CTA_PLANCO) AS CONTA_CTABTX, ';
  strSQL := strSQL + '        IFNULL(CTANCOBAI.NCO_CODCTA, CTABAI.CTA_CODCTA) AS CODIGO_PLANO_CONTA_BAIXA, ';
  strSQL := strSQL + '        IFNULL(CTANCOBTX.NCO_CODCTA, CTABTX.CTA_CODCTA) AS CODIGO_PLANO_CONTA_TAXA, ';
  strSQL := strSQL + '        ' + ifThen(FblnFreteHub, 'MOVCAR.MCA_FREMKT', 'CAST(NULL AS DECIMAL(14,2))') + ' AS MCA_FREMKT, ';
  strSQL := strSQL + '        ' + ifThen(FblnDescontoHub, 'MOVCAR.MCA_CUPMKT', 'CAST(NULL AS DECIMAL(14,2))') + ' AS MCA_CUPMKT, ';
  strSQL := strSQL + '        ' + ifThen(FblnAjusteHub, 'MOVCAR.MCA_VALAJU', 'CAST(NULL AS DECIMAL(14,2))') + ' AS MCA_VALAJU, ';
  strSQL := strSQL + '        BAN_CODBAN AS CODIGO_BANDEIRA, "MOVCAR" AS TABELA ';
  strSQL := strSQL + '   FROM MOVCAR ';
  strSQL := strSQL + '   JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
  strSQL := strSQL + '   LEFT JOIN CADBAN ON BAN_CODBAN = CAR_CODBAN ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = MCA_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADPOR ON POR_CODPOR = MCA_PORBAI ';
  strSQL := strSQL + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = POR_CODPOR ';
  strSQL := strSQL + '                   AND PORNCO.NCO_CODEMP = MCA_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CARNCO ON CARNCO.NCO_CODCAR = MCA_CODCAR ';
  strSQL := strSQL + '                   AND CARNCO.NCO_CODEMP = MCA_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CTABAI ';
  strSQL := strSQL + '     ON CTABAI.CTA_CODCTA = MCA_CTABAI ';
  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCOBAI ON CTANCOBAI.NCO_CODCTA = MCA_CTABAI ';
  strSQL := strSQL + '                              AND CTANCOBAI.NCO_CODEMP = MCA_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADCTA CTABTX ';
  strSQL := strSQL + '     ON CTABTX.CTA_CODCTA = MCA_CTABTX ';
  strSQL := strSQL + '   LEFT JOIN CTANCO CTANCOBTX ON CTANCOBTX.NCO_CODCTA = MCA_CTABTX ';
  strSQL := strSQL + '                              AND CTANCOBTX.NCO_CODEMP = MCA_CODEMP ';

  if blnBanNcoExiste then
  begin
    strSQL := strSQL + '   LEFT JOIN BANNCO ON BANNCO.NCO_CODBAN = BAN_CODBAN ';
    strSQL := strSQL + '                   AND BANNCO.NCO_CODEMP = MCA_CODEMP ';
  end;

  strSQL := strSQL + '  WHERE TRUE ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('MOVCAR.AUTOINCREM')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND MCA_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND ' + strCampoData + ' BETWEEN :DTAINI AND :DTAFIN ';

  result := strSQL ;
end;


end.
