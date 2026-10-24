unit Contabilidade.Classes.TLanConAJE;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConAJE = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
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

{ TLanConAJE }

constructor TLanConAJE.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
end;

destructor TLanConAJE.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConAJE.fCarregaDados: Boolean;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT DET_CLAFIS AS CLAFIS, DET_DTAENT AS DTAENT, DET_NUMDOC AS NUMDOC, DET_ESPDOC AS ESPDOC, DET_CODEMP AS CODEMP, SUM(DET_VLRCON) AS VLRCON, SUM(DET_VALICM) AS VALICM, ';
  strSQL := strSQL + '        SUM(IFNULL(DET_VALIPI,0)+IFNULL(MOVTRI.DET_VAEIPI,0)) AS VALIPI, SUM(DET_TOTFRE) AS TOTFRE, SUM(DET_DESACE) AS DESACE, ';
  strSQL := strSQL + '        SUM(IFNULL(DET_VALRET,0)+IFNULL(MOVTRI.DET_VAERET,0)) AS VALRET, SUM(DET_VALPIS) AS VALPIS, SUM(DET_VALCOF) AS VALCOF, ';
  strSQL := strSQL + '        SUM(DET_TOTMED) AS TOTMED, IFNULL(CLI_NOMCLI, FOR_NOMFOR) AS NOME, IF(CLI_NOMCLI IS NULL, FOR_C_G_C_, CLI_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '        IF(DET_CODCLI IS NULL, "F", "C") AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(DET_CODCLI IS NULL, IFNULL(NCO_CODFOR, FOR_CODFOR), IFNULL(NCO_CODCLI, CLI_CODCLI)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(DET_CODCLI IS NULL, IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO), IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO)) AS PLANCO, ';
  strSQL := strSQL + '        SUM(DET_TOTITE-DET_DESESP) AS TOTITE, "MOVGER" AS TABELA, MOVDET.DET_SEQGER AS SEQGER ';
  strSQL := strSQL + '   FROM MOVDET ';
  strSQL := strSQL + '   JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = DET_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '  WHERE TRUE ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('MOVDET.DET_SEQGER')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + '    AND LEFT(DET_CLAFIS, 1) < "5" ';
  strSQL := strSQL + '    AND DET_ESPDOC = "AJ" ';
  strSQL := strSQL + '    AND DET_DTAFAT IS NULL ';
  strSQL := strSQL + '  GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI, DET_CODFOR, DET_TIP_FC, DET_ORIDOC, DET_CLAFIS ';

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);
  qryDados.SQL.Add('UNION ALL');
  qryDados.SQL.Add(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'MOVGER', 'NOTGER'));

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConAJE.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConAJE.fEfetuaLancamentos: Boolean;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    Generico.pGravaLancto('TOTMED', DES_VALOR_CMV);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConAJE.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConAJE.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConAJE.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConAJE.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Ajuste de Entrada Concluído!', ['&OK']);
end;

procedure TLanConAJE.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConAJE.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConAJE.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon ;
end;

end.
