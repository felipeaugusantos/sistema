unit Contabilidade.Classes.TLanConANT;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls;

type
  TLanConANT = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fgetSQLAnt: string;
    function fTemFormaDePagamento: Boolean ;
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

uses
  untFuncoesSimples, SysUtils, Contabilidade.Funcoes, Forms,
  Contabilidade.Classes.TTrataIncDoc;

{ TLanConANT }

constructor TLanConANT.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
end;

destructor TLanConANT.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConANT.fCarregaDados: Boolean;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fgetSQLAnt );
  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;
  Result := (Not qryDados.IsEmpty);
end;

function TLanConANT.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConANT.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPlaCta : String;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "ANT": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;

    if not fTemFormaDePagamento then
      Generico.pGravaLancto('CTP_VALDUP', DES_VALOR_PAGO, strPlaCta, '', '', 'Pagamentos Avulsos');

    Generico.pGravaLancto('CTP_DINHEI_CRE', DES_VALOR_PAGO, strPlaCta, FPG_DINHEIRO, '', 'Pagamentos Avulsos');
    Generico.pGravaLancto('CTP_CHQAVI_CRE', DES_VALOR_PAGO, strPlaCta, FPG_CHEQUE_VISTA, '', 'Pagamentos Avulsos');
    Generico.pGravaLancto('CTP_ORDPAG_CRE', DES_VALOR_PAGO, strPlaCta, FPG_ORDPAG, '', 'Pagamentos Avulsos');

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConANT.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConANT.fgetSQLAnt: string;
  var
    strSQL : String;
begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTP_EMPBAI_CRE AS CODEMP, ';
  strSQL := strSQL + '   CTP_DTAPAG_CRE AS DTAENT, ';
  strSQL := strSQL + '   CTP_DTACAD_CRE AS DTACAD, ';
  strSQL := strSQL + '   CTP_NUMDUP_CRE AS NUMDOC, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS ESPDOC, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '   FOR_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '   "F" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '   FOR_CODFOR AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '   IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO) AS PLANCO, ';
  strSQL := strSQL + '   IFNULL(PORNCO.NCO_CODCON, POR_PLANCO )AS PLAPOR, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '   IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, ';
  strSQL := strSQL + '   CTP_PARCEL_CRE AS PARCEL, ';
  strSQL := strSQL + '   PAGANT.AUTOINCREM AS ANTINC, ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '   "PAGANT" AS TABELA, ';
  strSQL := strSQL + '   POR_CODPOR AS CODIGO_PORTADOR, ';
  strSQL := strSQL + '   CTP_VALDUP, ';
  strSQL := strSQL + '   CTP_DINHEI_CRE, ';
  strSQL := strSQL + '   CTP_CHQAVI_CRE, ';
  strSQL := strSQL + '   CTP_ORDPAG_CRE ';
  strSQL := strSQL + ' FROM PAGANT ';
  strSQL := strSQL + ' INNER JOIN CADEMP ON EMP_CODEMP = CTP_EMPBAI_CRE ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON CTP_CODFOR_CRE = FOR_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR AND FORNCO.NCO_CODEMP = CTP_EMPBAI_CRE ';
  strSQL := strSQL + ' LEFT JOIN CADCTA ON CTA_CODCTA = CTP_CTABAI_CRE ';
  strSQL := strSQL + ' LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = CTA_CODCTA AND CTANCO.NCO_CODEMP = CTP_EMPBAI_CRE ';
  strSQL := strSQL + ' LEFT JOIN CADPOR ON POR_CODPOR = CTP_PORBAI_CRE ';
  strSQL := strSQL + ' LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = POR_CODPOR AND PORNCO.NCO_CODEMP = CTP_EMPBAI_CRE ';
  strSQL := strSQL + ' WHERE TRUE ';
  strSQL := strSQL + '   AND CTP_CREDEB = "C" ';
  strSQL := strSQL + '   AND IFNULL(CTP_CODFOR_DEB, "") = "" ';
  strSQL := strSQL + '   AND IFNULL(CTP_ESTORN, "") <> "S" ';
  strSQL := strSQL + '   AND IFNULL(CTP_INCCRE, "") = "" ';

  If (Not recParCon.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND CTP_EMPBAI_CRE = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND CTP_DTAPAG_CRE BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('PAGANT.AUTOINCREM')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + ' ORDER BY PAGANT.AUTOINCREM ';

  Result := strSQL;
end;

function TLanConANT.fTemFormaDePagamento: Boolean;
begin
  Result := True ;

  if qryDados.FieldByName('CTP_DINHEI_CRE').AsFloat <> 0.00 then
    Exit ;

  if qryDados.FieldByName('CTP_CHQAVI_CRE').AsFloat <> 0.00 then
    Exit ;

  if qryDados.FieldByName('CTP_ORDPAG_CRE').AsFloat <> 0.00 then
    Exit ;

  Result := False ;
end;

function TLanConANT.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConANT.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConANT.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Pagamento Antecipado Fornecedores (ANT) Concluído!', ['&OK']);
end;

procedure TLanConANT.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConANT.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConANT.pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
  strTexto: String);
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

procedure TLanConANT.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
