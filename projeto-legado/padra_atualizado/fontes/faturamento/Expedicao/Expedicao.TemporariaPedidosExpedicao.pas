unit Expedicao.TemporariaPedidosExpedicao;

interface

type
  TTemporariaPedidosExpedicao = class
  private
    function fPegaProximoNomeTemporaria: String;
    function fCriarTemporaria(const strNomTab: String): Boolean;
    function fInserirPedidosPendentesTemporaria(const strNomTab: String): Boolean;
    function fInserirPedidosPendentesFaturadorAutomaticoTemporaria(const strNomTab: String): Boolean;
  public
    function fGerarNovaTemporaria: String;
    procedure pApagarTemporaria(const strNomTab: String);
    function fGetJoinPedidosPendentes(const strNomTab: String; strCampoIncrementoPedido: String): String;
    function fGetCondicaoPedidosPendentes(const strNomTab: String): String;
  End;

implementation

uses SysUtils, untFuncoesSimples, untConstantes;

{ TTemporariaPedidosExpedicao }

function TTemporariaPedidosExpedicao.fGerarNovaTemporaria: String;
  Var
    strNomTab : String;
begin
  Result := EmptyStr;
  strNomTab := fPegaProximoNomeTemporaria;
  If Not fCriarTemporaria(strNomTab) Then
    Exit;
  If Not fInserirPedidosPendentesTemporaria(strNomTab) Then
    Exit;
  If Not fInserirPedidosPendentesFaturadorAutomaticoTemporaria(strNomTab) Then
    Exit;
  Result := strNomTab;
end;

function TTemporariaPedidosExpedicao.fGetCondicaoPedidosPendentes(
  const strNomTab: String): String;
begin
  Result := EmptyStr;

  If (Not fEmptyStr(strNomTab)) Then
    Exit;

  Result := ' AND (PD_PENDENTE.FGO_ESPDOC = "PD") AND (IFNULL(PD_PENDENTE.FGO_LIBERA, 0) > 0) AND (IFNULL(PD_PENDENTE.FGO_LIBCOM, 0) > 0) AND (PD_PENDENTE.FGO_JAFATU = 0) ';
end;

function TTemporariaPedidosExpedicao.fGetJoinPedidosPendentes(const strNomTab: String; strCampoIncrementoPedido: String): String;
begin
  If (fEmptyStr(strNomTab)) Then
    Result := ' JOIN FATGOR AS PD_PENDENTE ON ' + strCampoIncrementoPedido + ' = PD_PENDENTE.AUTOINCREM '
  Else
    Result := ' JOIN ' + strNomTab + ' AS PD_PENDENTE  ON ' + strCampoIncrementoPedido + ' = TMP_AUTINC ';
end;

function TTemporariaPedidosExpedicao.fInserirPedidosPendentesFaturadorAutomaticoTemporaria(
  const strNomTab: String): Boolean;
  Var
    strSQL : String;
begin
  strSQL := EmptyStr;

  If (Not fExibirPedidosFaturamentoAutomatico) Then
    Exit(True);

  strSQL := strSQL + STR_SQL_NAO_REPLICAR;
  strSQL := strSQL + ' SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; ';
  strSQL := strSQL + ' INSERT IGNORE INTO ' + strNomTab + ' (TMP_AUTINC) ';
  strSQL := strSQL + ' SELECT FAT_FDOGER ';
  strSQL := strSQL + '   FROM FATAUT ';
  strSQL := strSQL + '  WHERE FAT_NUMFAT IS NOT NULL ';
  strSQL := strSQL + '    AND FAT_DTLBEX IS NULL; ';
  strSQL := strSQL + DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
  Result := fExecutaSQL(strSQL, True);
end;

function TTemporariaPedidosExpedicao.fInserirPedidosPendentesTemporaria(
  const strNomTab: String): Boolean;
  Var
    strSQL : String;
begin
  strSQL := EmptyStr;
  strSQL := strSQL + STR_SQL_NAO_REPLICAR;
  strSQL := strSQL + ' SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; ';
  strSQL := strSQL + ' INSERT INTO ' + strNomTab + ' (TMP_AUTINC) ';
  strSQL := strSQL + ' SELECT AUTOINCREM ';
  strSQL := strSQL + '   FROM FATGOR ';
  strSQL := strSQL + '  WHERE FGO_ESPDOC = "PD" ';
  strSQL := strSQL + '    AND IFNULL(FGO_LIBERA, 0) > 0 ';
  strSQL := strSQL + '    AND IFNULL(FGO_LIBCOM, 0) > 0 ';
  strSQL := strSQL + '    AND FGO_JAFATU = 0; ';
  strSQL := strSQL + DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
  Result := fExecutaSQL(strSQL, True);
end;

function TTemporariaPedidosExpedicao.fPegaProximoNomeTemporaria: String;
  Var
    strSeqTab: String;
begin
  strSeqTab := fRetSequencial('TPDEXP', VS_strCodEmp, 12);
  Result := 'TMP_TPDEXP_' + VS_strCodEmp + '_' + strSeqTab;
end;

procedure TTemporariaPedidosExpedicao.pApagarTemporaria(const strNomTab: String);
begin
  Try
    If strNomTab.IsEmpty Then
      Exit;
    If Not fTabelaExiste(strNomTab) Then
      Exit;
    fDropTable(strNomTab);
  Except
  End;
end;

function TTemporariaPedidosExpedicao.fCriarTemporaria(const strNomTab: String): Boolean;
  Var
    strSQL : String;
begin
  strSQL := EmptyStr;
  strSQL := strSQL + ' CREATE TABLE ' + strNomTab + ' ( ';
  strSQL := strSQL + '   TMP_AUTINC VARCHAR(20),          ';
  strSQL := strSQL + '   KEY IDX_' + strNomTab + '_01 (TMP_AUTINC), ';
  strSQL := strSQL + '   PRIMARY KEY (TMP_AUTINC) ';
  strSQL := strSQL + ' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1 ';
  Result := fExecutaSQL(strSQL, True);
end;

end.
