unit untTFatReservaSaldoAnalitico;

interface

uses
{$I '..\..\..\core\services.core.uses.inc'}, System.DateUtils, System.Classes,
  System.SysUtils, System.Generics.Collections, System.StrUtils, Data.DB;

const
  spIdMonitorReservaSaldoAnalitico = 'MONITOR_RESERVA_SALDO_ANALITICO_%s';

  strTabPedidoVenda = 'RESERVA_SALDO_PEDIDO_VENDA';
  strTabEnderecamento = 'RESERVA_SALDO_ENDERECAMENTO';
  strTabOrdemProducao = 'RESERVA_SALDO_ORDEM_PRODUCAO';
  strTabTransferencias = 'RESERVA_SALDO_TRANSFERENCIA';
  strTabGarantias = 'RESERVA_SALDO_GARANTIA';
  strTabEstoqueExterno = 'RESERVA_SALDO_EXTERNO';
  strTabBaixaEntFutSaldoFisico = 'RESERVA_SALDO_PEDIDO_BAIXA_ENTFUT_SOMA_SALDO';
  strTabBaixaEntFutSaldoReserv = 'RESERVA_SALDO_PEDIDO_BAIXA_ENTFUT_RESE_SALDO';

  sqlRemoverProdutoTabelaAnalitica =
    '  DELETE                                                 ' +
    '  FROM                                                   ' +
    '    %s                                                   ' +
    '  WHERE CODITE = "%s"                                    ' +
    '    AND CODEMP = "%s"                                    ';

  sqlRemoverProdutoTabelaAtualizar =
    '  DELETE                                                 ' +
    '  FROM                                                   ' +
    '    RESERVA_SALDO_ATUALIZAR                              ' +
    '  WHERE CODITE = "%s"                                    ' +
    '    AND CODEMP = "%s"                                    ' +
    '    AND CAMRES = "%s"                                    ';

  sqlProdutosParaAtualizarSaldoAnalitico =
    '  SELECT SQL_NO_CACHE DISTINCT                           ' +
    '    DTAINC,                                              ' +
    '    CODITE,                                              ' +
    '    CODEMP,                                              ' +
    '    IF(                                                  ' +
    '      CAMRES IN ("QTPD_F", "QTPD_V"),                    ' +
    '      "SALPED",                                          ' +
    '      CAMRES                                             ' +
    '    ) AS CAMRES                                          ' +
    '  FROM                                                   ' +
    '    RESERVA_SALDO_ATUALIZAR                              ' +
    '  WHERE CODEMP = :CODEMP                                 ' +
    '  ORDER BY DTAINC,                                       ' +
    '    CODITE,                                              ' +
    '    CAMRES                                               ' +
    '  LIMIT 50;                                              ';

  sqlProdutosComDivergenciaAuditoria =
    '  SELECT                                                 ' +
    '    ITE_CODITE AS CODITE,                                ' +
    '    ITE_CODEMP AS CODEMP,                                ' +
    '    ITE_QTPD_V,                                          ' +
    '    ITE_QTPD_F,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_PEDIDO_VENDA                       ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS QTPD_V_F,                                       ' +
    '    ITE_QTPD_E,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_ENDERECAMENTO                      ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS QTPD_E,                                         ' +
    '    ITE_QTPD_P,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_ORDEM_PRODUCAO                     ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS QTPD_P,                                         ' +
    '    ITE_SALTRA,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_TRANSFERENCIA                      ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS SALTRA,                                         ' +
    '    ITE_SALREG,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_GARANTIA                           ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS SALREG,                                         ' +
    '    ITE_SALEXT,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_EXTERNO                            ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS SALEXT,                                         ' +
    '    ITE_QTPDBF,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_PEDIDO_BAIXA_ENTFUT_SOMA_SALDO     ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS QTPDBF,                                         ' +
    '    ITE_SDPDBF,                                          ' +
    '    IFNULL(                                              ' +
    '      (SELECT                                            ' +
    '        SUM(SALRES)                                      ' +
    '      FROM                                               ' +
    '        RESERVA_SALDO_PEDIDO_BAIXA_ENTFUT_RESE_SALDO     ' +
    '      WHERE CODITE = ITE_CODITE                          ' +
    '        AND CODEMP = ITE_CODEMP),                        ' +
    '      0                                                  ' +
    '    ) AS SDPDBF                                          ' +
    '  FROM                                                   ' +
    '    ITEGER                                               ' +
    '  WHERE (                                                ' +
    '     ITE_QTPD_V + ITE_QTPD_F + ITE_QTPD_E + ITE_QTPD_P + ' +
    '     ITE_SALTRA + ITE_SALREG + ITE_SALEXT + ITE_QTPDBF + ' +
    '     ITE_SDPDBF                                          ' +
    '    ) <> 0                                               ' +
    '    AND ITE_CODEMP = "%s"                                ' +
    '  HAVING (                                               ' +
    '      (ITE_QTPD_V + ITE_QTPD_F) <> QTPD_V_F              ' +
    '    )                                                    ' +
    '    OR (ITE_QTPD_E <> QTPD_E)                            ' +
    '    OR (ITE_QTPD_P <> QTPD_P)                            ' +
    '    OR (ITE_SALTRA <> SALTRA)                            ' +
    '    OR (ITE_SALREG <> SALREG)                            ' +
    '    OR (ITE_SALEXT <> SALEXT)                            ' +
    '    OR (ITE_QTPDBF <> QTPDBF)                            ' +
    '    OR (ITE_SDPDBF <> SDPDBF);                           ' ;

  sqlUpdateRepAudAuditoria =
    '  UPDATE ITEGER SET ITE_REPAUD = "S"                     ' +
    '  WHERE ITE_CODITE = "%s" AND ITE_CODEMP = "%S"          ' ;

  sqlReplaceIntoAtualizarAuditoria =
    '  REPLACE INTO RESERVA_SALDO_ATUALIZAR (CODITE, CODEMP, CAMRES, DTAINC) ' +
    '  VALUES ("%s", "%s", "%s", CAST((CURRENT_TIME) AS DATETIME));  ';

type
  TUpdateReservaSaldoAnalitico = class sealed(TInterfacedObject,
    ITaskMonitorProcedure)
  private
    FQryItem: IQuery;
  private
    function FiltrarTipoReserva(ATipo: String): Boolean;
    function fGetSQLRemoverItemTabelaReserva(ATable: String): String;
    function fPodeExecutarAuditoria(): Boolean;
  private
    procedure pRemoverItensTabelaReserva(ATable: String);
    procedure pAuditoriaReservaAnalitico;
  protected
    constructor Create(AQryItem: IQuery);
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;
    destructor Destroy; Override;
    class function New(AQryItem: IQuery = nil): ITaskMonitorProcedure;
  end;

procedure pCriarTabelasAnalitico;

implementation

uses
  untFatGerarTabelasParaRelatorio, untTFatReservaSaldo;

procedure pCriarTabelaReservaSaldo(ATable: String);
begin
  If Not fTabelaExiste(ATable) Then
    If Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva,
      [ATable, EngineMyISAM])) Then
      Raise Exception.Create('Ocorreu um erro ao criar a tabela ' + ATable);
end;

procedure pCriarTabelasAnalitico;
begin
  untTFatReservaSaldo.pCriarReservaAnalitico;
  pCriarTabelaReservaSaldo(strTabPedidoVenda);
  pCriarTabelaReservaSaldo(strTabEnderecamento);
  pCriarTabelaReservaSaldo(strTabOrdemProducao);
  pCriarTabelaReservaSaldo(strTabTransferencias);
  pCriarTabelaReservaSaldo(strTabGarantias);
  pCriarTabelaReservaSaldo(strTabEstoqueExterno);
  pCriarTabelaReservaSaldo(strTabBaixaEntFutSaldoFisico);
  pCriarTabelaReservaSaldo(strTabBaixaEntFutSaldoReserv);
end;

{ TUpdateReservaSaldoAnalitico }

constructor TUpdateReservaSaldoAnalitico.Create(AQryItem: IQuery);
begin
  FQryItem := AQryItem;
end;

destructor TUpdateReservaSaldoAnalitico.Destroy;
begin
  inherited;
end;

function TUpdateReservaSaldoAnalitico.FiltrarTipoReserva(ATipo: String)
  : Boolean;
begin
  TDataSet(FQryItem.GetObject).Filtered := False;
  TDataSet(FQryItem.GetObject).Filter := 'CAMRES = ' + ATipo.QuotedString;
  TDataSet(FQryItem.GetObject).Filtered := True;
  Result := Not FQryItem.IsEmpty;
end;

function TUpdateReservaSaldoAnalitico.fPodeExecutarAuditoria: Boolean;
Var
  LFile: String;
  LSL: TStringList;
begin
  Result := False;
  LSL := TStringList.Create;
  Try
    LFile := GetCurrentDir + PathDelim + 'temp';

    If Not DirectoryExists(LFile) Then
      ForceDirectories(LFile);

    LFile := LFile + PathDelim + 'ultima_auditoria_' + VS_strCodEmp;

    If FileExists(LFile) Then
    Begin
      LSL.LoadFromFile(LFile, TEncoding.UTF8);
      If HoursBetween(fNow(), StrToDateTimeDef(LSL.Text, fNow())) < 6 Then
        Exit;
      Result := True;
    End;

    LSL.Text := DateTimeToStr(fNow());
    LSL.SaveToFile(LFile, TEncoding.UTF8);
  Finally
    FreeAndNil(LSL);
  End;
end;

class function TUpdateReservaSaldoAnalitico.New(AQryItem: IQuery = nil)
  : ITaskMonitorProcedure;
begin
  Result := TUpdateReservaSaldoAnalitico.Create(AQryItem);
end;

procedure TUpdateReservaSaldoAnalitico.pAuditoriaReservaAnalitico;
const
  CAMPOS_RESERVA: Array[0..8] Of String = ('QTPD_V', 'QTPD_F', 'QTPD_E',
    'QTPD_P', 'SALTRA', 'SALREG', 'SALEXT', 'QTPDBF', 'SDPDBF');
Var
  LQuery: IQuery;
  LCamRes: String;
begin
  LQuery := fCriaQuery();
  LQuery.SQL.Add(Format(sqlProdutosComDivergenciaAuditoria, [VS_strCodEmp]));
  LQuery.Open();

  While Not LQuery.Eof Do
  Begin
    fExecutaSQL(Format(sqlUpdateRepAudAuditoria,
      [LQuery.FieldByName('CODITE').AsString, VS_strCodEmp]));

    For LCamRes In CAMPOS_RESERVA Do
      fExecutaSQL(Format(sqlReplaceIntoAtualizarAuditoria,
        [LQuery.FieldByName('CODITE').AsString, VS_strCodEmp, LCamRes]));

    LQuery.Next;
  End;
end;

procedure TUpdateReservaSaldoAnalitico.pExecute;
var
  LGerar: TFatGerarTabelasParaRelatorio;
begin
  LGerar := TFatGerarTabelasParaRelatorio.Create(FQryItem);

  Try
    If FiltrarTipoReserva('QTPD_E') Then
    Begin
      pRemoverItensTabelaReserva(strTabEnderecamento);
      LGerar.fTabelaReservadoEnderecamento(strTabEnderecamento);
    End;

    If FiltrarTipoReserva('QTPD_P') Then
    Begin
      pRemoverItensTabelaReserva(strTabOrdemProducao);
      LGerar.fTabelaReservadoOrdemProducao(strTabOrdemProducao);
    End;

    If FiltrarTipoReserva('SALTRA') Then
    Begin
      pRemoverItensTabelaReserva(strTabTransferencias);
      LGerar.fTabelaTransferenciasEmAndamento(strTabTransferencias);
    End;

    If FiltrarTipoReserva('SALPED') Then
    Begin
      pRemoverItensTabelaReserva(strTabPedidoVenda);
      LGerar.fTabelaReservadoPedidoVenda(strTabPedidoVenda);
    End;

    If FiltrarTipoReserva('SALREG') Then
    Begin
      pRemoverItensTabelaReserva(strTabGarantias);
      LGerar.fTabelaReservadoGarantia(strTabGarantias);
    End;

    If FiltrarTipoReserva('SALEXT') Then
    Begin
      pRemoverItensTabelaReserva(strTabEstoqueExterno);
      LGerar.fTabelaReservadoExterno(strTabEstoqueExterno);
    End;

    If FiltrarTipoReserva('QTPDBF') Then
    Begin
      pRemoverItensTabelaReserva(strTabBaixaEntFutSaldoFisico);
      LGerar.fTabelaReservadoPedidoBaixaEntregaFuturaSaldoFisico
        (strTabBaixaEntFutSaldoFisico);
    End;

    If FiltrarTipoReserva('SDPDBF') Then
    Begin
      pRemoverItensTabelaReserva(strTabBaixaEntFutSaldoReserv);
      LGerar.fTabelaReservadoPedidoBaixaEntregaFuturaReservSaldo
        (strTabBaixaEntFutSaldoReserv);
    End;

  Finally
    FreeAndNil(LGerar);
  End;
end;

procedure TUpdateReservaSaldoAnalitico.pExecuteAll;
var
  LQry: IQuery;
  LSQL: String;
  LCodIte: String;
  LCodEmp: String;
  LCamRes: String;
begin
  LQry := fCriaQuery();
  LQry.SQL.Add(sqlProdutosParaAtualizarSaldoAnalitico);
  LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
  LQry.Open();
  LQry.First;

  TUpdateReservaSaldoAnalitico.New(LQry).pExecute();

  TDataSet(LQry.GetObject).Filtered := False;

  LSQL := '';

  LQry.First;
  While (Not LQry.Eof) Do
  Begin
    LCodIte := LQry.FieldByName('CODITE').AsString;
    LCodEmp := LQry.FieldByName('CODEMP').AsString;
    LCamRes := LQry.FieldByName('CAMRES').AsString;

    If LCamRes.Equals('SALPED') Then
    Begin
      LSQL := LSQL + Format(sqlRemoverProdutoTabelaAtualizar,
        [LCodIte, LCodEmp, 'QTPD_V']) + '; ';

      LSQL := LSQL + Format(sqlRemoverProdutoTabelaAtualizar,
        [LCodIte, LCodEmp, 'QTPD_F']) + '; ';
    End
    Else
    Begin
      LSQL := LSQL + Format(sqlRemoverProdutoTabelaAtualizar,
        [LCodIte, LCodEmp, LCamRes]) + '; ';
    End;

    LQry.Next;
  End;

  If LSQL <> '' Then
    fExecutaSQL(LSQL);

  If fPodeExecutarAuditoria Then
    pAuditoriaReservaAnalitico;
end;

function TUpdateReservaSaldoAnalitico.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TUpdateReservaSaldoAnalitico.fGetSQLRemoverItemTabelaReserva
  (ATable: String): String;
begin
  Result := Format(sqlRemoverProdutoTabelaAnalitica,
    [ATable, FQryItem.FieldByName('CODITE').AsString,
    FQryItem.FieldByName('CODEMP').AsString]);
end;

procedure TUpdateReservaSaldoAnalitico.pRemoverItensTabelaReserva
  (ATable: String);
Var
  LSQL: String;
begin
  LSQL := '';
  FQryItem.First;
  while Not FQryItem.Eof do
  begin
    LSQL := LSQL + fGetSQLRemoverItemTabelaReserva(ATable) + ';';
    FQryItem.Next;
  end;
  FQryItem.First;
  If LSQL <> '' Then
    fExecutaSQL(LSQL);
end;

end.
