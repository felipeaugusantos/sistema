unit untRomLge;

interface

function fRetLoteSeparacao(strNumDoc, strEspDoc, strCodEmp: String): string;
function fExcluiDocumentoLoteSeparacao(strAutIncLotSep, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
function fLoteSeparacaoSemDocumentos(strAutIncLotSep: String): Boolean;
function fLimparSepLoteSeparacao(strNumLot, strCodEmp: String): Boolean;
function fExcluirLoteSeparacao(strNumLot, strCodEmp: String): Boolean;
function fExisteLoteSeparacaoRomaneioParaPedido(strAutIncPedido: String; strNumLotSep: String = ''): Boolean;
function fRetornaLoteEmpresaSeparacaoRomaneio(strNumDoc, strEspDoc, strCodEmp: String): String;

implementation

uses
  untFuncoesSimples, Uni, System.SysUtils;

function fRetLoteSeparacao(strNumDoc, strEspDoc, strCodEmp: String): string;
var
  qrySelect: TUniQuery;
begin
  Result := '';

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT ROMLGE.AUTOINCREM');
    qrySelect.SQL.Add('FROM ROMLGE');
    qrySelect.SQL.Add('JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM');
    qrySelect.SQL.Add('WHERE RLD_NUMDOC = :NUMDOC');
    qrySelect.SQL.Add('  AND RLD_ESPDOC = :ESPDOC');
    qrySelect.SQL.Add('  AND RLD_CODEMP = :CODEMP');

    qrySelect.ParamByName('NUMDOC').AsString := strNumDoc;
    qrySelect.ParamByName('ESPDOC').AsString := strEspDoc;
    qrySelect.ParamByName('CODEMP').AsString := strCodEmp;
    qrySelect.Open;

    if not qrySelect.IsEmpty then
      Result := qrySelect.Fields[0].AsString;

  finally
    FreeAndNil(qrySelect);
  end;
end;

function fExcluiDocumentoLoteSeparacao(strAutIncLotSep, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
var
  qryExec: TUniQuery;
begin
  qryExec := fCriaQuery;
  try
    qryExec.SQL.Add('DELETE FROM ROMLDE');
    qryExec.SQL.Add('WHERE RLD_NUMDOC = :NUMDOC');
    qryExec.SQL.Add('  AND RLD_ESPDOC = :ESPDOC');
    qryExec.SQL.Add('  AND RLD_CODEMP = :CODEMP');
    qryExec.SQL.Add('  AND RLD_SEQRLG = :SEQRLG');

    qryExec.ParamByName('NUMDOC').AsString := strNumDoc;
    qryExec.ParamByName('ESPDOC').AsString := strEspDoc;
    qryExec.ParamByName('CODEMP').AsString := strCodEmp;
    qryExec.ParamByName('SEQRLG').AsString := strAutIncLotSep;
    qryExec.ExecSQL;

    if fLoteSeparacaoSemDocumentos(strAutIncLotSep) then
    begin
      qryExec.SQL.Clear;
      qryExec.SQL.Add('DELETE FROM ROMLGE');
      qryExec.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      qryExec.ParamByName('AUTINC').AsString := strAutIncLotSep;

      qryExec.ExecSQL;
    end;

    Result := True;

  finally
    FreeAndNil(qryExec);
  end;
end;

function fLoteSeparacaoSemDocumentos(strAutIncLotSep: String): Boolean;
var
  qrySelect: TUniQuery;
begin
  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Add('SELECT AUTOINCREM');
    qrySelect.SQL.Add('FROM ROMLDE');
    qrySelect.SQL.Add('WHERE RLD_SEQRLG = :AUTINC');

    qrySelect.ParamByName('AUTINC').AsString := strAutIncLotSep;
    qrySelect.Open;

    Result := qrySelect.IsEmpty;
  finally
    FreeAndNil(qrySelect);
  end;
end;

function fLimparSepLoteSeparacao(strNumLot, strCodEmp: String): Boolean;
var
  qryExec: TUniQuery;
begin
  qryExec := fCriaQuery;
  try
    qryExec.SQL.Add('DELETE FROM LOTDOR USING LOTDOR, FATDOR, ROMLGE, ROMLDE');
    qryExec.SQL.Add('WHERE RLD_SEQRLG = ROMLGE.AUTOINCREM');
    qryExec.SQL.Add('  AND FDO_NUMDOC = RLD_NUMDOC AND RLD_ESPDOC = FDO_ESPDOC AND RLD_CODEMP = FDO_CODEMP');
    qryExec.SQL.Add('  AND LDO_SEQFDO = FATDOR.AUTOINCREM');
    qryExec.SQL.Add('  AND RLG_NUMLOT = :NUMLOT');
    qryExec.SQL.Add('  AND RLG_CODEMP = :CODEMP');

    qryExec.ParamByName('NUMLOT').AsString := strNumLot;
    qryExec.ParamByName('CODEMP').AsString := strCodEmp;

    qryExec.ExecSql;
    Result := True;
  finally
    FreeAndNil(qryExec);
  end;
end;

function fExcluirLoteSeparacao(strNumLot, strCodEmp: String): Boolean;
var
  qryDados: TUniQuery;
  strAutInc: String;
begin
  qryDados := fCriaQuery;

  try
    strAutInc := fCampoTabela('AUTOINCREM', 'ROMLGE', ['RLG_NUMLOT', 'RLG_CODEMP'], [strNumLot, strCodEmp]);

    qryDados.SQL.Text := 'DELETE FROM ROMLDE WHERE RLD_SEQRLG = :SEQRLG ';
    qryDados.ParamByName('SEQRLG').AsString := strAutInc;
    qryDados.ExecSQL;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('DELETE FROM ROMLGE ');
    qryDados.SQL.Add('WHERE RLG_NUMLOT = :NUMLOT ');
    qryDados.SQL.Add('  AND RLG_CODEMP = :CODEMP ');
    qryDados.ParamByName('NUMLOT').AsString := strNumLot;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryDados);
  end;
end;

function fExisteLoteSeparacaoRomaneioParaPedido(strAutIncPedido: String; strNumLotSep: String = ''): Boolean;
var
  qryPedido: TUniQuery;
begin
  qryPedido := fCriaQuery;

  try
    qryPedido.Close;
    qryPedido.SQL.Clear;
    qryPedido.SQL.Add('SELECT F.AUTOINCREM');
    qryPedido.SQL.Add('FROM FATGOR F');
    qryPedido.SQL.Add('INNER JOIN ROMLDE R');
    qryPedido.SQL.Add('  ON (F.FGO_NUMDOC = R.RLD_NUMDOC');
    qryPedido.SQL.Add('  AND F.FGO_ESPDOC = R.RLD_ESPDOC');
    qryPedido.SQL.Add('  AND F.FGO_CODEMP = R.RLD_CODEMP)');
    qryPedido.SQL.Add('INNER JOIN ROMLGE G ON (G.AUTOINCREM = R.RLD_SEQRLG)');
    qryPedido.SQL.Add('WHERE F.AUTOINCREM = :AUTINC');

    if (not fEmptyStr(strNumLotSep)) then
    begin
      qryPedido.SQL.Add('  AND G.RLG_NUMLOT <> :NUMLOT');
      qryPedido.ParamByName('NUMLOT').AsString := strNumLotSep;
    end;

    qryPedido.ParamByName('AUTINC').AsString := strAutIncPedido;
    qryPedido.Open;

    Result := Not qryPedido.IsEmpty;
  finally
    FreeAndNil(qryPedido);
  end;
end;

function fRetornaLoteEmpresaSeparacaoRomaneio(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  qryLote: TUniQuery;
begin
  qryLote := fCriaQuery;

  try
    Result := EmptyStr;

    qryLote.Close;
    qryLote.SQL.Clear;
    qryLote.SQL.Add('SELECT CONCAT(G.RLG_NUMLOT,"-",G.RLG_CODEMP) AS LOTE');
    qryLote.SQL.Add('FROM ROMLGE G');
    qryLote.SQL.Add('INNER JOIN ROMLDE D');
    qryLote.SQL.Add('ON(G.AUTOINCREM = D.RLD_SEQRLG)');
    qryLote.SQL.Add('WHERE D.RLD_NUMDOC = :NUMDOC');
    qryLote.SQL.Add('AND D.RLD_ESPDOC = :ESPDOC');
    qryLote.SQL.Add('AND D.RLD_CODEMP = :CODEMP');

    qryLote.ParamByName('NUMDOC').AsString := strNumDoc;
    qryLote.ParamByName('ESPDOC').AsString := strEspDoc;
    qryLote.ParamByName('CODEMP').AsString := strCodEmp;

    qryLote.Open;

    if qryLote.IsEmpty then
      Exit;

    Result := qryLote.FieldByName('LOTE').AsString;
  finally
    FreeAndNil(qryLote);
  end;
end;

end.
