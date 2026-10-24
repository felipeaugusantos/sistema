unit untTControladorReservaItemDevolucaoFornecedor;

interface

uses
  UNI,
  System.SysUtils;

Type
  EControleSaldoDevolucao = Class(Exception)
  private
    FLocal: String;
  public
    constructor Create(const Msg: string; pLocal: String);
    procedure pExibirMensagem;
    property Local: String Read FLocal;
  end;

  TArrIndices = array of Integer;

  TRecGarantiaSel = Record
    strAutInc: String;
    fltQtdDev: Double;
  end;
  TarrRecGarantiaSel = array of TRecGarantiaSel;

  TRecItemDevolucao = Record
  strict private
    FstrAutInc: String;
    FItens: TarrRecGarantiaSel;
    FfltQtdRes: Double; //quantidade reservada para garantias selecionadas
    procedure pRemoverReservarItem(pfltQtdRes: Double);
    procedure pReservarItem(pfltQtdRes: Double);
  public
    strCodFor,
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodIte,
    strSerie_: String;
    fltQtdIte,
    fltQtdDev: Double;
    constructor Create(const pstrAutInc: String);
    procedure pAdicionarGarantia(const pstrIncGad: String; const pfltQtdEnv: Double);
    function fIndiceOfIncGad(const pstrAutInc: String): Integer;
    procedure pInicializar;
    procedure pRemoverGarantia(const pstrIncGad: String);
    function fSaldoDisponivel: Double;
    property fltQtdRes: Double Read FfltQtdRes;
    property strAutInc: String Read FstrAutInc;
  end;
  TArrItemDevolucao = array of TRecItemDevolucao;

  TControladorReservaItemDevolucaoFornecedor = Class
  strict private
    FItens: TArrItemDevolucao;
    function fIndexOfAutoIncrem(const pstrAutInc: String): Integer;
    function fItemDevolucao(const Index: Integer): TRecItemDevolucao;
    function fIndicesItensDevolucaoGarantia(const pstrIncGad: String): TArrIndices;
    procedure pCarregarSaldoItemDocumento(const pstrAutInc,
                                                pstrCodFor,
                                                pstrCodIte: String;
                                          out pRecItemDevolucao: TRecItemDevolucao);
  public
    procedure pAdicionar(pstrAutInc,
                         pstrCodFor,
                         pstrCodIte,
                         pstrIncGad: String;
                         pfltQtdEnv: Double);overload;

    procedure pAdicionar(pstrAutInc,
                         pstrCodFor,
                         pstrCodIte: String);overload;

    procedure pReservarItemGarantia(const pstrAutIncDev, pstrIncGad: String; const pfltQtdEnv: double);
    procedure pRemoverReservaGarantia(const pstrIncGad: String);
    procedure pLimpar;
    property IndexOfAutoIncrem[const strAutInc: String]: Integer Read fIndexOfAutoIncrem;
    property ItemDevolucao[const Index: Integer]: TRecItemDevolucao Read fItemDevolucao;
  end;

implementation

uses
  untFuncoesSimples;

{ TControladorReservaItemDevolucaoFornecedor }

function TControladorReservaItemDevolucaoFornecedor.fIndexOfAutoIncrem(
  const pstrAutInc: String): Integer;
Var
  i: integer;
begin
  Result := -1;
  If Length(FItens) = 0 then
    Exit;
  for i := 0 to  Length(Self.FItens) -1 do
  begin
    if FItens[i].strAutInc = pstrAutInc then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TControladorReservaItemDevolucaoFornecedor.fIndicesItensDevolucaoGarantia(
  const pstrIncGad: String): TArrIndices;
Var
  i: integer;
begin
  Setlength(Result, 0);
  for i := Low(FItens) to High(FItens) do
  begin
    if FItens[i].fIndiceOfIncGad(pstrIncGad) >= 0 then
    begin
      Setlength(Result, Length(Result) +1);
      Result[High(Result)] := i;
    end;
  end;
end;

function TControladorReservaItemDevolucaoFornecedor.fItemDevolucao(
  const Index: Integer): TRecItemDevolucao;
begin
  if (Index < Low(FItens)) or (Index > High(FItens)) then
    raise EControleSaldoDevolucao.Create('Índice inválido.', 'TControleSaldoDevolucao.fItemDevolucao');
  Result := FItens[Index];
end;

procedure TControladorReservaItemDevolucaoFornecedor.pAdicionar(pstrAutInc,
                                                                pstrCodFor,
                                                                pstrCodIte,
                                                                pstrIncGad: String;
                                                                pfltQtdEnv: Double);
begin
  if fEmptystr(pstrAutInc) or fEmptystr(pstrIncGad) then
    Exit;

  pAdicionar(pstrAutInc,
             pstrCodFor,
             pstrCodIte);

  pReservarItemGarantia(pstrAutInc, pstrIncGad, pfltQtdEnv);
end;

procedure TControladorReservaItemDevolucaoFornecedor.pAdicionar(pstrAutInc,
                                                                pstrCodFor,
                                                                pstrCodIte: String);
Var
  lrecItemDevolucao: TRecItemDevolucao;
begin
  if fEmptystr(pstrAutInc) then
    Exit;

  if Self.IndexOfAutoIncrem[pstrAutInc] = -1 then
  begin
    pCarregarSaldoItemDocumento(pstrAutInc, pstrCodFor, pstrCodIte, lrecItemDevolucao);
    SetLength(FItens, Length(FItens)+1);
    FItens[High(FItens)] := lrecItemDevolucao;
  end;
end;

procedure TControladorReservaItemDevolucaoFornecedor.pCarregarSaldoItemDocumento(const pstrAutInc,
                                                                                       pstrCodFor,
                                                                                       pstrCodIte: String;
                                                                                       out pRecItemDevolucao: TRecItemDevolucao);
Var
  lQry: TUniQuery;
  lSql: String;
begin
  lSql :=        ' SELECT A.AUTOINCREM, ';
  lSql := lSql + '        A.DET_CODFOR, ';
  lSql := lSql + '        A.DET_CODEMP, ';
  lSql := lSql + '        A.DET_ESPDOC, ';
  lSql := lSql + '        A.DET_NUMDOC, ';
  lSql := lSql + '        A.DET_SERIE_, ';
  lSql := lSql + '        A.DET_CODITE, ';
  lSql := lSql + '        A.DET_QTDITE, ';
  lSql := lSql + '        SUM(IFNULL(B.DET_QTDITE,0)) AS QTDDEV ';
  lSql := lSql + ' FROM MOVDET A ';
  lSql := lSql + ' LEFT JOIN MOVDET B ON B.DET_CODFOR = A.DET_CODFOR ';
  lSql := lSql + '                   AND B.DET_TIP_FC = A.DET_TIP_FC ';
  lSql := lSql + '                   AND A.DET_CODITE = B.DET_CODITE ';
  lSql := lSql + '                   AND B.DET_DOCDEV = A.DET_NUMDOC ';
  lSql := lSql + '                   AND B.DET_ESPDEV = A.DET_ESPDOC ';
  lSql := lSql + '                   AND B.DET_EMPDEV = A.DET_CODEMP ';
  lSql := lSql + ' WHERE A.AUTOINCREM = :AUTINC ';
  lSql := lSql + '   AND A.DET_TIP_FC = "F" ';
  lSql := lSql + '   AND A.DET_CODITE = :CODITE ';
  lSql := lSql + '   AND A.DET_CODFOR = :CODFOR ';
  lSql := lSql + ' GROUP BY A.AUTOINCREM ';

  lQry := fCriaquery;
  Try
    Try
      lQry.Close;
      lQry.SQL.Clear;
      lQry.SQL.Add(lsql);
      lQry.ParamByName('AUTINC').AsString := pstrAutInc;
      lQry.ParamByName('CODFOR').AsString := pstrCodFor;
      lQry.ParamByName('CODITE').AsString := pstrCodIte;
      lQry.Open;
      if lQry.IsEmpty then
        raise EControleSaldoDevolucao.Create('Documento do fornecedor não encontrado.',
                                       'TControladorReservaItemDevolucaoFornecedor.pCarregarSaldoItemDocumento');
      lQry.First;
      pRecItemDevolucao.Create(pstrAutInc);
      pRecItemDevolucao.strCodFor := pstrCodFor;
      pRecItemDevolucao.strCodIte := pstrCodIte;
      pRecItemDevolucao.strNumDoc := lQry.FieldByName('DET_NUMDOC').AsString;
      pRecItemDevolucao.strEspDoc := lQry.FieldByName('DET_ESPDOC').AsString;
      pRecItemDevolucao.strCodEmp := lQry.FieldByName('DET_CODEMP').AsString;
      pRecItemDevolucao.strSerie_ := lQry.FieldByName('DET_SERIE_').AsString;
      pRecItemDevolucao.fltQtdIte := lQry.FieldByName('DET_QTDITE').AsFloat;
      pRecItemDevolucao.fltQtdDev := lQry.FieldByName('QTDDEV').AsFloat;

    Except
      On E: Exception do
        E.RaiseOuterException(EControleSaldoDevolucao.Create(e.Message,'TControladorReservaItemDevolucaoFornecedor.pCarregarSaldoItemDocumento'));
    End;
  Finally
    FreeAndNil(lQry);
  End;
end;

procedure TControladorReservaItemDevolucaoFornecedor.pLimpar;
begin
  SetLength(FItens,0);
end;

procedure TControladorReservaItemDevolucaoFornecedor.pRemoverReservaGarantia(const pstrIncGad: String);
Var
  lIndices: TArrIndices;
  i: Integer;
begin
  lIndices := fIndicesItensDevolucaoGarantia(pstrIncGad);
  for i := Low(lIndices) to High(lIndices) do
  begin
    FItens[lIndices[i]].pRemoverGarantia(pstrIncGad);
  end;
end;

procedure TControladorReservaItemDevolucaoFornecedor.pReservarItemGarantia(const pstrAutIncDev,
  pstrIncGad: String; const pfltQtdEnv: double);
begin
  if fEmptyStr(pstrAutIncDev) then
    Exit;
  FItens[IndexOfAutoIncrem[pstrAutIncDev]].pAdicionarGarantia(pstrIncGad, pfltQtdEnv);
end;

{ TRecItemDevolucao }

constructor TRecItemDevolucao.Create(const pstrAutInc: String);
begin
  pInicializar;
  FstrAutInc := pstrAutInc;
end;

function TRecItemDevolucao.fIndiceOfIncGad(const pstrAutInc: String): Integer;
Var
  i: Integer;
begin
  Result := -1;
  if Length(FItens) = 0 then
    Exit;

  for i := Low(FItens) to High(FItens) do
  begin
    if FItens[i].strAutInc = pstrAutInc then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TRecItemDevolucao.fSaldoDisponivel: Double;
begin
  Result := fltQtdIte - (fltQtdDev + FfltQtdRes);
end;

procedure TRecItemDevolucao.pAdicionarGarantia(const pstrIncGad: String;
  const pfltQtdEnv: Double);
Var
  i, n: Integer;
begin
  if fEmptystr(pstrIncGad) then
    Exit;

  i := fIndiceOfIncGad(pstrIncGad);
  if i>= 0 then
    pRemoverReservarItem(pfltQtdEnv);

  pReservarItem(pfltQtdEnv);

  if i = -1 then
  begin
    if i = -1 then
    begin
      for n := 0 to Length(FItens) -1 do
      begin
        if fEmptyStr(FItens[n].strAutInc) then
        begin
          i := n;
          Break;
        end;
      end;
    end;

    if i >= 0 then
      FItens[i].strAutInc := pstrIncGad
    else
    begin
      SetLength(FItens, Length(FItens) +1);
      i := Length(FItens) -1;
      FItens[i].strAutInc := pstrIncGad;
    end;
  end;
  FItens[i].fltQtdDev := pfltQtdEnv;
end;

procedure TRecItemDevolucao.pInicializar;
begin
  FstrAutInc := EmptyStr;
  strCodFor := EmptyStr;
  strNumDoc := EmptyStr;
  strEspDoc := EmptyStr;
  strCodEmp := EmptyStr;
  strCodIte := EmptyStr;
  strSerie_ := EmptyStr;
  fltQtdIte := 0;
  fltQtdDev := 0;
  FfltQtdRes := 0;
  SetLength(FItens,0)
end;

procedure TRecItemDevolucao.pRemoverGarantia(const pstrIncGad: String);
Var
  i: Integer;
begin
  i := fIndiceOfIncGad(pstrIncGad);
  if i = -1 then
    raise EControleSaldoDevolucao.Create('Garantia não encontrada.', 'TRecItemDevolucao.pRemoverGarantia')
  else
  begin
    pRemoverReservarItem(FItens[i].fltQtdDev);
    FItens[i].strAutInc := '';
    FItens[i].fltQtdDev := 0;
  end;
end;

procedure TRecItemDevolucao.pRemoverReservarItem(pfltQtdRes: Double);
begin
  if (FfltQtdRes - pfltQtdRes) >= 0 then
    FfltQtdRes := FfltQtdRes - pfltQtdRes
  else
    raise EControleSaldoDevolucao.Create('Erro remover reserva do item.','TRecDocumento.pRemoverReservarItem' );
end;

procedure TRecItemDevolucao.pReservarItem(pfltQtdRes: Double);
begin
  if (fSaldoDisponivel - pfltQtdRes) >= 0 then
    FfltQtdRes := FfltQtdRes + pfltQtdRes
  else
    raise EControleSaldoDevolucao.Create('Quantidade a ser devolvida é maior que a quantidade da Nota Fiscal de Entrada selecionada.',
                                         'TRecDocumento.pReservarItem');
end;

{ EControleSaldoDevolucao }

constructor EControleSaldoDevolucao.Create(const Msg: string; pLocal: String);
begin
  inherited Create(Msg);
  FLocal := pLocal;
end;

procedure EControleSaldoDevolucao.pExibirMensagem;
begin
  pMensagemOk(Self.Message);
end;

end.
