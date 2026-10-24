unit Contabilidade.Classes.TLanConCPC;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls;

type
  TLanConCPC = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fgetSQLCpc: string;
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

{ TLanConCPC }

constructor TLanConCPC.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
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

destructor TLanConCPC.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConCPC.fCarregaDados: Boolean;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fgetSQLCPC );
  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;
  Result := (Not qryDados.IsEmpty);
end;

function TLanConCPC.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConCPC.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPagame : String;
    strPlaCta : String;
    strCodEve: string;
    strFormaPagto : string;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "CPC": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    strPagame := '';
    strCodEve := '';
    strPlaCta := '';
    strFormaPagto := '';

    Generico.pGravaLancto('VLRPIS', DES_VALOR_PIS, strPlaCta, strFormaPagto, strCodEve, strPagame, qryDados.FieldByName('DEF_CBCCRE').AsString);
    Generico.pGravaLancto('VLRCOF', DES_VALOR_COFINS, strPlaCta, strFormaPagto, strCodEve, strPagame, qryDados.FieldByName('DEF_CBCCRE').AsString);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConCPC.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCPC.fgetSQLCPC: string;
  var
    strSQL : String;
begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   DEF_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   DEF_DTAOPE AS DTAENT, ';
  strSQL := strSQL + '   DEF_DTAOPE AS DTACAD, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS NUMDOC, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS ESPDOC, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '   FOR_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '   DEF_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '   DEF_FORDUP AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '   CTA_PLANCO AS PLANCO, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS PLAPOR, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(1)) AS CLAFIS, ';
  strSQL := strSQL + '   CTA_PLANCO, ';
  strSQL := strSQL + '   DEF_PARCEL AS PARCEL, ';
  strSQL := strSQL + '   CADDEF.AUTOINCREM AS CPCINC, ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '   "CADDEF" AS TABELA, ';
  strSQL := strSQL + '   DEF_CBCCRE, ';
  strSQL := strSQL + '   DEF_CODCCA, ';
  strSQL := strSQL + '   DEF_VALPIS AS VLRPIS, ';
  strSQL := strSQL + '   DEF_VALCOF AS VLRCOF ';
  strSQL := strSQL + ' FROM CADDEF ';
  strSQL := strSQL + ' INNER JOIN CADEMP ON DEF_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON DEF_FORDUP = FOR_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN CADCTA ON DEF_CODCTA = CTA_CODCTA ';
  strSQL := strSQL + ' WHERE TRUE ';

  If (Not recParCon.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND CADDEF.DEF_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND CADDEF.DEF_DTAOPE BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('CADDEF.AUTOINCREM')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '  ORDER BY CADDEF.AUTOINCREM ';

  Result := strSQL;
end;

function TLanConCPC.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCPC.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCPC.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Crédito Pis/Cofins EFD Contribuições Concluído!', ['&OK']);
end;

procedure TLanConCPC.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCPC.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCPC.pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
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

procedure TLanConCPC.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
