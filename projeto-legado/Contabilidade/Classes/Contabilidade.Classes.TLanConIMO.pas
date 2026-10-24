unit Contabilidade.Classes.TLanConIMO;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls;

type
  TLanConIMO = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fgetSQLImobilizado: string;
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

{ TLanConIMO }

constructor TLanConIMO.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
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

destructor TLanConIMO.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConIMO.fCarregaDados: Boolean;
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( fgetSQLImobilizado );
  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;
  Result := (Not qryDados.IsEmpty);
end;

function TLanConIMO.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConIMO.fEfetuaLancamentos: Boolean;
  Var
    intRecCount : Integer;
    strPagame : String;
    strPlaCta : String;
    strCodEve: string;
    strFormaPagto : string;
    recParGrava : TParametrosGravaLanCon;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "IMO": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    FillChar(recParGrava, SizeOf(recParGrava), #0);
    recParGrava.strCodigoImobilizado := qryDados.FieldByName('AMO_CODIMO').AsString;
    recParGrava.strCodigoTipoImobilizado := qryDados.FieldByName('IMO_TIPIMO').AsString;
    Generico.pSetaParametrosGravacao(recParGrava);

    strPagame := '';
    strCodEve := '';
    strPlaCta := '';
    strFormaPagto := '';

    Generico.pGravaLancto('VLRDEP', DES_DEPRECIAR, strPlaCta, strFormaPagto, strCodEve, strPagame, qryDados.FieldByName('IMO_TIPIMO').AsString);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConIMO.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConIMO.fgetSQLImobilizado: string;
  var
    strSQL : String;
begin
  strSQL := strSQL + ' SELECT CADIMO.IMO_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        IMOAMO.AMO_DTABAS AS DTAENT, ';
  strSQL := strSQL + '        IMOAMO.AMO_DTABAS AS DTACAD, ';
  strSQL := strSQL + '        CADIMO.IMO_DOCAQU AS NUMDOC, ';
  strSQL := strSQL + '        CADIMO.IMO_ESPAQU AS ESPDOC, ';
  strSQL := strSQL + '        FOR_NOMFOR AS NOME, ';
  strSQL := strSQL + '        FOR_C_G_C_ AS CNPJ, ';
  strSQL := strSQL + '        "F" AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        FOR_CODFOR AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        "" AS PLANCO, ';
  strSQL := strSQL + '        "" AS PLAPOR, ';
  strSQL := strSQL + '        "" AS CLAFIS, ';
  strSQL := strSQL + '        "" AS CTA_PLANCO, ';
  strSQL := strSQL + '        "" AS PARCEL, ';
  strSQL := strSQL + '        IMOAMO.AUTOINCREM AS IMOINC, ';
  strSQL := strSQL + '        EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '        AMO_VLRDEP AS VLRDEP, ';
  strSQL := strSQL + '        IMOAMO.AMO_CODIMO, ';
  strSQL := strSQL + '        CADIMO.IMO_CODIMO AS CODBEM, ';
  strSQL := strSQL + '        CADIMO.IMO_NUMPAT AS NUMPAT, ';
  strSQL := strSQL + '        CADIMO.IMO_TIPIMO, "IMOAMO" AS TABELA ';
  strSQL := strSQL + '   FROM IMOAMO ';
  strSQL := strSQL + '   JOIN CADIMO ON CADIMO.IMO_CODIMO = IMOAMO.AMO_CODIMO ';
  strSQL := strSQL + '   JOIN CADEMP ON CADIMO.IMO_CODEMP = EMP_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = CADIMO.IMO_FORAQU ';
  strSQL := strSQL + '  WHERE TRUE ';

  If (Not recParCon.strCodEmp.IsEmpty) Then
    strSQL := strSQL + '  AND CADIMO.IMO_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND IMOAMO.AMO_DTABAS BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('IMOAMO.AUTOINCREM')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '  ORDER BY IMOAMO.AUTOINCREM ';

  Result := strSQL;
end;

function TLanConIMO.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConIMO.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConIMO.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Imobilizado Concluído!', ['&OK']);
end;

procedure TLanConIMO.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConIMO.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConIMO.pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
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

procedure TLanConIMO.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
