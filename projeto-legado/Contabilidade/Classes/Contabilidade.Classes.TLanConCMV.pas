unit Contabilidade.Classes.TLanConCMV;

interface

uses Contabilidade.Interfaces, Uni, Contabilidade.Classes.TGerLanCon,
  cxProgressBar, UniClientDataSet;

type
  TLanConCMV = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
  public
    function fCarregaDados: Boolean;
    function fInEventosNaoExportar: string;
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

uses untFuncoesSimples, SysUtils, StrUtils, Contabilidade.Funcoes, Forms, DB,
     Contabilidade.Classes.TTrataIncDoc;

{ TLanConCMV }

constructor TLanConCMV.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
end;

destructor TLanConCMV.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConCMV.fCarregaDados: Boolean;
  var
    strSQL : String;
    strInEventosNaoExportar : string;
begin
  strInEventosNaoExportar := fInEventosNaoExportar;

  strSQL := '';
  strSQL := strSQL + ' SELECT DET_CLAFIS AS CLAFIS, SUM(DET_TOTMED) AS TOTMED, CAST("" AS CHAR(20)) AS NUMDOC, ';
  strSQL := strSQL + '        DET_CODEMP AS CODEMP, CAST("" AS CHAR(20)) AS CMVINC, MAX(DET_DTAENT) AS DTAENT  ';
  strSQL := strSQL + '   FROM MOVDET ';
  strSQL := strSQL + '   JOIN CADITE ON MOVDET.DET_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '   JOIN CADEMP ON MOVDET.DET_CODEMP = CADEMP.EMP_CODEMP ';
  strSQL := strSQL + '   JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  strSQL := strSQL + '   JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';

  strSQL := strSQL + '  WHERE TRUE ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('MOVDET.DET_SEQGER')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '    AND LEFT(DET_CLAFIS, 1) >= "5" ';
  strSQL := strSQL + '    AND RIGHT(DET_CLAFIS, 3) <> "933" ';
  strSQL := strSQL + '    AND DET_ESPDOC IN ("NF", "NS", "NV", "IF", "IV", "D1", "EL") ';

  if not strInEventosNaoExportar.IsEmpty then
    strSQL := strSQL + '  AND COALESCE(GER_CODEVE, "") NOT IN (' + strInEventosNaoExportar + ') ';

  strSQL := strSQL + '  GROUP BY DET_CLAFIS, DET_CODEMP ';

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  if fEmptyStr(recParCon.strTabela) then
  begin
    qryDados.SQL.Insert(0, 'SELECT CLAFIS, CODEMP, SUM(TOTMED) AS TOTMED, CAST("" AS CHAR(20)) AS NUMDOC, CMVINC, MAX(DTAENT) AS DTAENT FROM ( ');
    qryDados.SQL.Add('UNION ALL');
    qryDados.SQL.Add(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'), 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'AUXMOV', 'AUXNOT'));
    qryDados.SQL.Add(' ) AS TMP ');
    qryDados.SQL.Add(' GROUP BY CLAFIS, CODEMP, CMVINC ');
  end
  else if (recParCon.strTabela = 'NOTGER') then
  begin
    qryDados.SQL.Clear;
    qryDados.SQL.Add(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'), 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'AUXMOV', 'AUXNOT'));
  end;

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConCMV.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConCMV.fEfetuaLancamentos: Boolean;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;

  qryDados.BeforeScroll := nil ;
  try
    While Not qryDados.Eof Do
    Begin
      qryDados.Edit;
      qryDados.FieldByName('CMVINC').AsString := fGerarIncDocLanConManual ;
      qryDados.Post;
      qryDados.Next;
    end ;
    qryDados.First ;
  finally
    qryDados.BeforeScroll := Generico.pBeforeScroll ;
  end;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;
    Generico.pGravaLancto('TOTMED', DES_VALOR_CMV, '', '', '', '', '', '', '');
    qryDados.Next;
  End;

  Result := True;
end;

function TLanConCMV.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCMV.fInEventosNaoExportar: string;
  var
    arrEventos : TArray<String>;
    strEveNec : string;
    strEvento : string;
begin
  strEveNec := fRetornaEventosNaoExportar;
  arrEventos := strEveNec.Split(['_']);
  Result := '';
  for strEvento in arrEventos do
  begin
    if (not strEvento.IsEmpty) then
    begin
      if Result.IsEmpty then
        Result := '"' + strEvento + '"'
      else
        Result := Result + ', ' + '"' + strEvento + '"';
    end;
  end;
end;

function TLanConCMV.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCMV.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCMV.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'CMV Concluído!', ['&OK']);
end;

procedure TLanConCMV.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCMV.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCMV.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon ;
end;

end.
