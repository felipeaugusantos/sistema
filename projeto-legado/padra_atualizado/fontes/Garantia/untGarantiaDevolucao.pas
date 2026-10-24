unit untGarantiaDevolucao;

interface

type
  TrecDocumentoDevolucao = Record
    strDocDev: String;
    strEspDev: String;
    strEmpDev: String;
  end;
  TrecDocumentoDevolucaoPedidoGarantia = Record
    strIncDor: String;
    recDocumentoDevolucao: TrecDocumentoDevolucao;
  end;
  TarrRecDocumentoDevolucaoPedidoGarantia = array of TrecDocumentoDevolucaoPedidoGarantia;

procedure pObterDocumentoDevolucaoItemPedido(const strAutIncDor: String; Var precDocumentoDevolucao: TrecDocumentoDevolucao; arrRecDocumentoDevolucaoPedidoGarantia: TarrRecDocumentoDevolucaoPedidoGarantia; const strMen001: String);
function fCarregarDocumentosDevolucaoGarantia(const strNumDoc, strEspDoc, strCodEmp, strMen001: String): TarrRecDocumentoDevolucaoPedidoGarantia;
function fEhPedidoReposicaoClienteGarantia(const strMen001: String): Boolean;

implementation

uses SysUtils, untFuncoesSimples, Uni, Garantia.Constantes;

procedure pObterDocumentoDevolucaoItemPedido(const strAutIncDor: String; Var precDocumentoDevolucao: TrecDocumentoDevolucao; arrRecDocumentoDevolucaoPedidoGarantia: TarrRecDocumentoDevolucaoPedidoGarantia; const strMen001: String);
  Var
    intIdx: Integer;
begin
  FillChar(precDocumentoDevolucao, SizeOf(precDocumentoDevolucao), #0);
  precDocumentoDevolucao.strDocDev := EmptyStr;
  precDocumentoDevolucao.strEspDev := EmptyStr;
  precDocumentoDevolucao.strEmpDev := Emptystr;

  If (Not fEhPedidoReposicaoClienteGarantia(strMen001)) Then
    Exit;

  If fEmptyStr(strAutIncDor) Then
    Exit;

  if length(arrRecDocumentoDevolucaoPedidoGarantia) >= 1 then
  begin
    for intIdx := Low(arrRecDocumentoDevolucaoPedidoGarantia) to High(arrRecDocumentoDevolucaoPedidoGarantia) do
    begin
      if arrRecDocumentoDevolucaoPedidoGarantia[intIdx].strIncDor = strAutIncDor then
      begin
        precDocumentoDevolucao.strDocDev := arrRecDocumentoDevolucaoPedidoGarantia[intIdx].recDocumentoDevolucao.strDocDev;
        precDocumentoDevolucao.strEspDev := arrRecDocumentoDevolucaoPedidoGarantia[intIdx].recDocumentoDevolucao.strEspDev;
        precDocumentoDevolucao.strEmpDev := arrRecDocumentoDevolucaoPedidoGarantia[intIdx].recDocumentoDevolucao.strEmpDev;
        Break;
      end;
    end;
  end;
end;

function fCarregarDocumentosDevolucaoGarantia(const strNumDoc, strEspDoc, strCodEmp, strMen001: String): TarrRecDocumentoDevolucaoPedidoGarantia;
  Var
    Qry: TUniQuery;
    strSql: String;
begin
  SetLength(Result, 0);

  If (Not fEhPedidoReposicaoClienteGarantia(strMen001)) Then
    Exit;

  strSQL := EmptyStr;
  strSQL := strSQL + ' SELECT D.AUTOINCREM, D2.DET_NUMDOC, D2.DET_ESPDOC, D2.DET_CODEMP ';
  strSQL := strSQL + ' FROM FATDOR D ';
  strSQL := strSQL + ' JOIN MOVGPV GPV ON GPV.GPV_SEQFDO = D.AUTOINCREM ';
  strSQL := strSQL + ' JOIN MOVGRC C ON C.GRC_SEQGAD = GPV.GPV_SEQGAD ';
  strSQL := strSQL + ' JOIN MOVDET D2 ON D2.AUTOINCREM = C.GRC_SEQDET ';
  strSQL := strSQL + ' WHERE D.FDO_NUMDOC = :NUMDOC AND D.FDO_ESPDOC = :ESPDOC AND D.FDO_CODEMP = :CODEMP ' ;
  strSQL := strSQL + '   AND D2.DET_ESPDOC = "NF" ';
  Qry := fCriaQuery(nil);
  Try
    Qry.Close;
    Qry.SQL.Clear;
    Qry.SQL.Add(strSQL);
    Qry.ParamByName('NUMDOC').AsString := strNumDoc;
    Qry.ParamByName('ESPDOC').AsString := strEspDoc;
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
      While Not Qry.Eof do
      begin
        SetLength(Result, length(Result)+1);
        Result[High(Result)].strIncDor := Qry.FieldByName('AUTOINCREM').AsString;
        Result[High(Result)].recDocumentoDevolucao.strDocDev := Qry.FieldByName('DET_NUMDOC').AsString;
        Result[High(Result)].recDocumentoDevolucao.strEspDev := Qry.FieldByName('DET_ESPDOC').AsString;
        Result[High(Result)].recDocumentoDevolucao.strEmpDev := Qry.FieldByName('DET_CODEMP').AsString;
        Qry.Next;
      end;
    end;
    Qry.Close;
  Finally
    FreeAndNil(Qry);
  End;
end;

function fEhPedidoReposicaoClienteGarantia(const strMen001: String): boolean;
begin
  Result := Pos(GARANTIA_PEDIDO_REPOSICAO_CLIENTE, strMen001) > 0;
end;

end.
