unit Fulfillment.Classes.MovimentacaoEstoque;

interface

uses
  Uni;

Type

  TMovimentacaoEstoque = class
  private

    FMovimentacoes  : TUniQuery;

    FEhCancelamento,
    FEhAjusteDeEstoque,
    FAtualizouEstoque : Boolean;

    FNumeroDoDocumento  : String;
    FEspecieDoDocumento : String;
    FEmpresaDoDocumento : String;
    FClienteDoDocumento : String;
    FSerieDoDocumento   : String;
    FTipoClienteDocumento : String;

  strict private

    function SQL_Movimentacoes(ASomenteExterno : Boolean = False)  : String;
    function SQL_EstoqueExterno : String;
    function SQL_EstoqueExterno_Insert(AEntSai : String) : String;
    function SQL_EstoqueExterno_Update(AEntSai : String) : String;
    function SQL_EstoqueExterno_Update_Ite_SalExt(AEntSai : String) : String;
    function SQL_EstoqueExterno_Update_Lot_Saldos(AEntSai : String; AEhLoteFulfillment : Boolean = False) : String;
    function SQL_EstoqueExterno_Update_Ite_Saldos(AEntSai : String) : String;

    function CarregouMovimentacoes(ASomenteExterno : Boolean = False) : Boolean;
    function ExisteMovimentacaoExterna : Boolean;
    function FiltrouMovimentacoes(ACriterio : String) : Boolean;
    function RetornaOperadorAritmetico(AEntSai : String) : String;
    function GerarGuardar : Boolean;
    function RetornaChaveDeAcesso : String;

    procedure ExecutarMovimentacoesExternas;
    procedure ExecutarMovimentacoesExternas_Interna;

    procedure ExecutarMovimentacoesFisicas;
    procedure ExecutarMovimentacoesFisicas_Interna;

    procedure Guardar;

  public

    constructor New; Reintroduce;
    destructor Destroy; Override;

    function ExecutarMovimentacoes : Boolean;

    procedure EhCancelamento(AValue : Boolean);
    procedure EhAjusteDeEstoque(AValue : Boolean);
    procedure NumeroDoDocumento(AValue : String);
    procedure EspecieDoDocumento(AValue : String);
    procedure EmpresaDoDocumento(AValue : String);
    procedure ClienteDoDocumento(AValue : String);
    procedure SerieDoDocumento(AValue : String);
    procedure TipoClienteDocumento(AValue : String);

  end;

implementation

uses
  System.SysUtils, UniClientDataSet, untFuncoesSimples, untCadLote, untTransferenciaArmazens,

  Fulfillment.RegrasMovimentacaoEstoque,
  Fulfillment.Funcoes;

{ TMovimentacaoEstoque }

function TMovimentacaoEstoque.ExecutarMovimentacoes : Boolean;
begin

  If Not ExisteMovimentacaoExterna Then
    Exit(False);

  If Not CarregouMovimentacoes Then
    Exit(False);

  Try
    ExecutarMovimentacoesExternas;
    ExecutarMovimentacoesFisicas;
  Finally
    Result := FAtualizouEstoque;
  End;

end;

procedure TMovimentacaoEstoque.ExecutarMovimentacoesExternas;
  const
    CRITERIO = 'DET_FILFUL = "0"';
begin

  If Not FiltrouMovimentacoes(CRITERIO) Then
    Exit;

  FMovimentacoes.First;
  While Not FMovimentacoes.Eof Do
  Begin
    ExecutarMovimentacoesExternas_Interna;
    FMovimentacoes.Next;
  End;

end;

procedure TMovimentacaoEstoque.ExecutarMovimentacoesExternas_Interna;
  var
    LCodEmp,
    LCodIte,
    LCodExt,
    LEntSai,
    LClaFis : String;
    LQtdIte : Double;

    LEstoqueExterno : TUniQuery;

begin

  LCodEmp := FEmpresaDoDocumento;
  LCodIte := FMovimentacoes.FieldByName('DET_CODITE').AsString;
  LCodExt := FMovimentacoes.FieldByName('DET_CODEXT').AsString;
  LQtdIte := FMovimentacoes.FieldByName('DET_QTDITE').AsFloat;
  LClaFis := FMovimentacoes.FieldByName('DET_CLAFIS').AsString;
  LEntSai := IIF(FEhAjusteDeEstoque, IIF(LClaFis.Equals('1999'), 'E', 'S'), FMovimentacoes.FieldByName('DET_FULE_S').AsString);

  LEstoqueExterno := fCriaQuery;

  Try

    LEstoqueExterno.Close;
    LEstoqueExterno.SQL.Clear;
    LEstoqueExterno.SQL.Add(SQL_EstoqueExterno);
    LEstoqueExterno.ParamByName('CODITE').AsString := LCodIte;
    LEstoqueExterno.ParamByName('CODEMP').AsString := LCodEmp;
    LEstoqueExterno.ParamByName('CODEEE').AsString := LCodExt;
    LEstoqueExterno.Open;

    {ESTEXT.EXT_SALDO_}
    If LEstoqueExterno.IsEmpty Then
    Begin
      LEstoqueExterno.Close;
      LEstoqueExterno.SQL.Clear;
      LEstoqueExterno.SQL.Add(SQL_EstoqueExterno_Insert(LEntSai));
      LEstoqueExterno.ParamByName('AUTINC').AsString := fRetAutoIncrem('ESTEXT', LCodEmp);
      LEstoqueExterno.ParamByName('CODITE').AsString := LCodIte;
      LEstoqueExterno.ParamByName('CODEMP').AsString := LCodEmp;
      LEstoqueExterno.ParamByName('CODEEE').AsString := LCodExt;
      LEstoqueExterno.ParamByName('QTDITE').AsFloat  := LQtdIte;
      LEstoqueExterno.ExecSQL;
    End Else
    Begin
      LEstoqueExterno.Close;
      LEstoqueExterno.SQL.Clear;
      LEstoqueExterno.SQL.Add(SQL_EstoqueExterno_Update(LEntSai));
      LEstoqueExterno.ParamByName('CODITE').AsString := LCodIte;
      LEstoqueExterno.ParamByName('CODEMP').AsString := LCodEmp;
      LEstoqueExterno.ParamByName('CODEEE').AsString := LCodExt;
      LEstoqueExterno.ParamByName('QTDITE').AsFloat  := LQtdIte;
      LEstoqueExterno.ExecSQL;
    End;

    {ITEGER.ITE_SALEXT}
    LEstoqueExterno.Close;
    LEstoqueExterno.SQL.Clear;
    LEstoqueExterno.SQL.Add(SQL_EstoqueExterno_Update_Ite_SalExt(LEntSai));
    LEstoqueExterno.ParamByName('CODITE').AsString := LCodIte;
    LEstoqueExterno.ParamByName('CODEMP').AsString := LCodEmp;
    LEstoqueExterno.ParamByName('QTDITE').AsFloat  := LQtdIte;
    LEstoqueExterno.ExecSQL;

    {CADLOT.LOT_SALDOS}
    If TCadLot.ProdutoTemLote(LCodIte) Then
    Begin

      If (GerarGuardar) Then
      Begin
        Guardar;
      End Else
      Begin
        LEstoqueExterno.Close;
        LEstoqueExterno.SQL.Clear;
        LEstoqueExterno.SQL.Add(SQL_EstoqueExterno_Update_Lot_Saldos(LEntSai, True));
        LEstoqueExterno.ParamByName('CODITE').AsString := LCodIte;
        LEstoqueExterno.ParamByName('CODEMP').AsString := LCodEmp;
        LEstoqueExterno.ParamByName('CODEXT').AsString := LCodExt;
        LEstoqueExterno.ParamByName('QTDITE').AsFloat  := LQtdIte;
        LEstoqueExterno.ExecSQL;
      End;

    End;

    FAtualizouEstoque := True;

    If fTabelaExiste('RESERVA_SALDO_ATUALIZAR') Then
    Begin
      untFuncoesSimples.fExecutaSQL('REPLACE INTO RESERVA_SALDO_ATUALIZAR (CODITE, CODEMP, CAMRES, DTAINC) VALUES ' +
                                    '("' + LCodIte + '", "' + LCodEmp + '", "SALEXT", ' + fCurrentDateTime(VS_Date + Time()) + ')', True);
    End;

  Finally
    FreeAndNil(LEstoqueExterno);
  End;

end;

procedure TMovimentacaoEstoque.ExecutarMovimentacoesFisicas;
  const
    CRITERIO = 'DET_FILKAR = "0"';
begin

  If Not FiltrouMovimentacoes(CRITERIO) Then
    Exit;

  FMovimentacoes.First;
  While Not FMovimentacoes.Eof Do
  Begin
    ExecutarMovimentacoesFisicas_Interna;
    FMovimentacoes.Next;
  End;

end;

procedure TMovimentacaoEstoque.ExecutarMovimentacoesFisicas_Interna;
  var
    LCodEmp,
    LCodIte,
    LNumLot,
    LEntSai,
    LClaFis : String;
    LQtdIte : Double;

    LEstoqueFisico : TUniQuery;

begin

  LCodEmp := FEmpresaDoDocumento;
  LCodIte := FMovimentacoes.FieldByName('DET_CODITE').AsString;
  LNumLot := FMovimentacoes.FieldByName('DET_NUMLOT').AsString;
  LQtdIte := FMovimentacoes.FieldByName('DET_QTDITE').AsFloat;
  LClaFis := FMovimentacoes.FieldByName('DET_CLAFIS').AsString;
  LEntSai := IIF(LClaFis.Equals('1999'), 'E', 'S');

  LEstoqueFisico := fCriaQuery;

  Try

    {ITEGER.ITE_SALDOS}
    LEstoqueFisico.Close;
    LEstoqueFisico.SQL.Clear;
    LEstoqueFisico.SQL.Add(SQL_EstoqueExterno_Update_Ite_Saldos(LEntSai));
    LEstoqueFisico.ParamByName('CODITE').AsString := LCodIte;
    LEstoqueFisico.ParamByName('CODEMP').AsString := LCodEmp;
    LEstoqueFisico.ParamByName('QTDITE').AsFloat  := LQtdIte;
    LEstoqueFisico.ExecSQL;

    {CADLOT.LOT_SALDOS}
    If (TCadLot.ProdutoTemLote(LCodIte)) And
       (Not LoteEhFulfillment(LNumLot, LCodEmp, LCodIte)) And
       (Not FulfillmentGuardar) Then
    Begin
      LEstoqueFisico.Close;
      LEstoqueFisico.SQL.Clear;
      LEstoqueFisico.SQL.Add(SQL_EstoqueExterno_Update_Lot_Saldos(LEntSai));
      LEstoqueFisico.ParamByName('NUMLOT').AsString := LNumLot;
      LEstoqueFisico.ParamByName('CODITE').AsString := LCodIte;
      LEstoqueFisico.ParamByName('CODEMP').AsString := LCodEmp;
      LEstoqueFisico.ParamByName('QTDITE').AsFloat  := LQtdIte;
      LEstoqueFisico.ExecSQL;
    End;

    FAtualizouEstoque := True;

  Finally
    FreeAndNil(LEstoqueFisico);
  End;

end;

function TMovimentacaoEstoque.ExisteMovimentacaoExterna: Boolean;
begin
  Result := CarregouMovimentacoes(True);
end;

function TMovimentacaoEstoque.FiltrouMovimentacoes(ACriterio: String): Boolean;
begin
  FMovimentacoes.Filtered := False;
  FMovimentacoes.Filter   := ACriterio;
  FMovimentacoes.Filtered := True;
  Result := Not FMovimentacoes.IsEmpty;
end;

function TMovimentacaoEstoque.GerarGuardar: Boolean;
var
  LChaveDeAcesso : String;
begin

  Result := False;

  If FEhAjusteDeEstoque Then
    Exit;

  If Not FEhCancelamento Then
    Exit;

  If Not FulfillmentGuardar Then
    Exit;

  LChaveDeAcesso := RetornaChaveDeAcesso;

  If Not LChaveDeAcesso.IsEmpty Then
    If Not FulfillmentMovimentacaoEstoque(EmptyStr, LChaveDeAcesso, EmptyStr).Operacao.Equals(opRemessa) Then
      Exit;

  Result := True;

end;

procedure TMovimentacaoEstoque.Guardar;
var
  LNumLotGuardar, LLocFisGuardar: String;

  LCodEmp,
  LCodIte,
  LNumLot,
  LCodExt : String;
  LQtdIte : Double;

  LItensTL : TUniClientDataSet;
  LCadLot  : TCadLot;
  LTransf  : TTransferenciaArmazens;

begin

  LCodEmp := FEmpresaDoDocumento;
  LCodIte := FMovimentacoes.FieldByName('DET_CODITE').AsString;
  LQtdIte := FMovimentacoes.FieldByName('DET_QTDITE').AsFloat;
  LNumLot := FMovimentacoes.FieldByName('DET_NUMLOT').AsString;
  LCodExt := FMovimentacoes.FieldByName('DET_CODEXT').AsString;

  LCadLot := TCadLot.Create(Nil);

  Try

    LNumLotGuardar := fCfgSis('LTTAPC', varString);
    LLocFisGuardar := fCfgSis('LCTAPC', varString);

    pCriaDataSetItensTL(LItensTL);

    LTransf := TTransferenciaArmazens.Create(Nil, LItensTL, Nil, nil);

    if (not LCadLot.fExisteLote(LCodIte, LCodEmp, LNumLotGuardar, False, False)) then
      LCadLot.GeraLoteTAPedidoCancelado(LCodIte, LNumLotGuardar, LLocFisGuardar, LCodEmp);

    LItensTL.Append;
    LItensTL.FieldByName('CODITE').AsString := LCodIte;
    LItensTL.FieldByName('ARMDES').AsString := LNumLotGuardar;
    LItensTL.FieldByName('ARMORI').AsString := LNumLot;
    LItensTL.FieldByName('QTDITE').AsFloat  := LQtdIte;
    LItensTL.Post;

    LTransf.strDocFat := FNumeroDoDocumento;
    LTransf.strEspFat := FEspecieDoDocumento;
    LTransf.strEmpFat := FEmpresaDoDocumento;
    LTransf.strCliFat := FClienteDoDocumento;

    LTransf.Fulfillment.EhOperacaoFulfillment  := True;
    LTransf.Fulfillment.EhEstoqueExterno       := True;
    LTransf.Fulfillment.CodigoDoEstoqueExterno := LCodExt;

    if not LItensTL.IsEmpty then
      LTransf.fGeraTransferencia(True, False);

  Finally
    FreeAndNil(LCadLot);
    FreeAndNil(LItensTL);
    FreeAndNil(LTransf);
  End;

end;

constructor TMovimentacaoEstoque.New;
begin

  FMovimentacoes  := fCriaQuery;

  FEhCancelamento    := False;
  FEhAjusteDeEstoque := False;
  FAtualizouEstoque  := False;

  FNumeroDoDocumento  := EmptyStr;
  FEspecieDoDocumento := EmptyStr;
  FEmpresaDoDocumento := EmptyStr;
  FClienteDoDocumento := EmptyStr;
  FSerieDoDocumento   := EmptyStr;
  FTipoClienteDocumento := 'C';

end;

function TMovimentacaoEstoque.CarregouMovimentacoes(ASomenteExterno : Boolean = False) : Boolean;
begin

  FMovimentacoes.Close;
  FMovimentacoes.SQL.Clear;
  FMovimentacoes.SQL.Add(SQL_Movimentacoes(ASomenteExterno));

  FMovimentacoes.ParamByName('NUMDOC').AsString := FNumeroDoDocumento;
  FMovimentacoes.ParamByName('ESPDOC').AsString := FEspecieDoDocumento;
  FMovimentacoes.ParamByName('CODEMP').AsString := FEmpresaDoDocumento;
  FMovimentacoes.ParamByName('CODCLI').AsString := FClienteDoDocumento;
  FMovimentacoes.ParamByName('TIP_FC').AsString := FTipoClienteDocumento;

  If Not FSerieDoDocumento.IsEmpty Then
    FMovimentacoes.ParamByName('SERIE_').AsString := FSerieDoDocumento;

  FMovimentacoes.Open;

  Result := Not FMovimentacoes.IsEmpty;

end;

procedure TMovimentacaoEstoque.ClienteDoDocumento(AValue: String);
begin
  FClienteDoDocumento := AValue;
end;

destructor TMovimentacaoEstoque.Destroy;
begin

  If Assigned(FMovimentacoes) Then
    FreeAndNil(FMovimentacoes);

  inherited;

end;

procedure TMovimentacaoEstoque.EhAjusteDeEstoque(AValue: Boolean);
begin
  FEhAjusteDeEstoque := AValue;
end;

procedure TMovimentacaoEstoque.EhCancelamento(AValue: Boolean);
begin
  FEhCancelamento := AValue;
end;

procedure TMovimentacaoEstoque.EmpresaDoDocumento(AValue: String);
begin
  FEmpresaDoDocumento := AValue;
end;

procedure TMovimentacaoEstoque.EspecieDoDocumento(AValue: String);
begin
  FEspecieDoDocumento := AValue;
end;

procedure TMovimentacaoEstoque.NumeroDoDocumento(AValue: String);
begin
  FNumeroDoDocumento := AValue;
end;

procedure TMovimentacaoEstoque.TipoClienteDocumento(AValue: String);
begin
  FTipoClienteDocumento := AValue;
end;

function TMovimentacaoEstoque.RetornaChaveDeAcesso: String;
var
  LCadFis : TUniQuery;
  LSQL    : String;
begin

  LCadFis := fCriaQuery;

  Try

    LSQL := '';
    LSQL := LSQL + 'SELECT FIS_ACESSO FROM MOVGER ';
    LSQL := LSQL + 'INNER JOIN CADFIS ON CADFIS.FIS_NUMDOC = MOVGER.GER_NUMDOC AND ';
    LSQL := LSQL + '                     CADFIS.FIS_ESPDOC = MOVGER.GER_ESPDOC AND ';
    LSQL := LSQL + '                     CADFIS.FIS_CODEMP = MOVGER.GER_CODEMP AND ';
    LSQL := LSQL + '                     CADFIS.FIS_FORCLI = MOVGER.GER_'+ IIF(FTipoClienteDocumento = 'F', 'CODFOR', 'CODCLI') +' AND ';
    LSQL := LSQL + '                     CADFIS.FIS_SERIE_ = MOVGER.GER_SERIE_ AND ';
    LSQL := LSQL + '                     CADFIS.FIS_TIP_FC = MOVGER.GER_TIP_FC AND ';
    LSQL := LSQL + '                     CADFIS.FIS_ORIDOC = MOVGER.GER_ORIDOC     ';
    LSQL := LSQL + 'WHERE GER_TIP_FC = :TIP_FC ';
    LSQL := LSQL + '  AND GER_NUMDOC = :NUMDOC ';
    LSQL := LSQL + '  AND GER_ESPDOC = :ESPDOC ';
    LSQL := LSQL + '  AND GER_CODEMP = :CODEMP ';
    LSQL := LSQL + '  AND GER_'+ IIF(FTipoClienteDocumento = 'F', 'CODFOR', 'CODCLI') +' = :CODCLI ';

    If Not FSerieDoDocumento.IsEmpty Then
      LSQL := LSQL + '  AND GER_SERIE_ = :SERIE_ ';

    LCadFis.SQL.Add(LSQL);
    LCadFis.ParamByName('NUMDOC').AsString := FNumeroDoDocumento;
    LCadFis.ParamByName('ESPDOC').AsString := FEspecieDoDocumento;
    LCadFis.ParamByName('CODEMP').AsString := FEmpresaDoDocumento;
    LCadFis.ParamByName('CODCLI').AsString := FClienteDoDocumento;
    LCadFis.ParamByName('TIP_FC').AsString := FTipoClienteDocumento;

    If Not FSerieDoDocumento.IsEmpty Then
      LCadFis.ParamByName('SERIE_').AsString := FSerieDoDocumento;

    LCadFis.Open;

    Result := LCadFis.FieldByName('FIS_ACESSO').AsString;

  Finally
    FreeAndNil(LCadFis);
  End;

end;

function TMovimentacaoEstoque.RetornaOperadorAritmetico(AEntSai: String): String;
begin

  If Not FEhCancelamento Then
    Exit(AEntSai);

  Result := IIF(AEntSai.Equals('E'), '-', '+');

end;

procedure TMovimentacaoEstoque.SerieDoDocumento(AValue: String);
begin
  FSerieDoDocumento := AValue;
end;

function TMovimentacaoEstoque.SQL_EstoqueExterno: String;
begin
  Result := '';
  Result := Result + 'SELECT   ';
  Result := Result + '  *      ';
  Result := Result + 'FROM     ';
  Result := Result + '  ESTEXT ';
  Result := Result + 'WHERE    ';
  Result := Result + '  EXT_CODITE = :CODITE AND ';
  Result := Result + '  EXT_CODEMP = :CODEMP AND ';
  Result := Result + '  EXT_CODEEE = :CODEEE     ';
end;

function TMovimentacaoEstoque.SQL_EstoqueExterno_Insert(AEntSai : String) : String;
begin
  Result := '';
  Result := Result + 'INSERT INTO ESTEXT(';
  Result := Result + '  AUTOINCREM, ';
  Result := Result + '  EXT_CODITE, ';
  Result := Result + '  EXT_CODEMP, ';
  Result := Result + '  EXT_CODEEE, ';
  Result := Result + '  EXT_SALDO_) ';
  Result := Result + 'VALUES(       ';
  Result := Result + '  :AUTINC,    ';
  Result := Result + '  :CODITE,    ';
  Result := Result + '  :CODEMP,    ';
  Result := Result + '  :CODEEE,    ';
  Result := Result + RetornaOperadorAritmetico(AEntSai) + ':QTDITE)';
end;

function TMovimentacaoEstoque.SQL_EstoqueExterno_Update(AEntSai : String): String;
begin
  Result := '';
  Result := Result + 'UPDATE   ';
  Result := Result + '  ESTEXT ';
  Result := Result + 'SET      ';
  Result := Result + '  EXT_SALDO_ = IFNULL(EXT_SALDO_, 0) '+RetornaOperadorAritmetico(AEntSai)+' :QTDITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  EXT_CODITE = :CODITE AND ';
  Result := Result + '  EXT_CODEMP = :CODEMP AND ';
  Result := Result + '  EXT_CODEEE = :CODEEE     ';
end;

function TMovimentacaoEstoque.SQL_EstoqueExterno_Update_Ite_Saldos(AEntSai: String): String;
begin
  Result := '';
  Result := Result + 'UPDATE   ';
  Result := Result + '  ITEGER ';
  Result := Result + 'SET      ';
  Result := Result + '  ITE_SALDOS = IFNULL(ITE_SALDOS, 0) '+RetornaOperadorAritmetico(AEntSai)+' :QTDITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  ITE_CODITE = :CODITE AND ';
  Result := Result + '  ITE_CODEMP = :CODEMP     ';
end;

function TMovimentacaoEstoque.SQL_EstoqueExterno_Update_Ite_SalExt(AEntSai: String): String;
begin
  Result := '';
  Result := Result + 'UPDATE   ';
  Result := Result + '  ITEGER ';
  Result := Result + 'SET      ';
  Result := Result + '  ITE_SALEXT = IFNULL(ITE_SALEXT, 0) '+RetornaOperadorAritmetico(AEntSai)+' :QTDITE ';
  Result := Result + 'WHERE ';
  Result := Result + '  ITE_CODITE = :CODITE AND ';
  Result := Result + '  ITE_CODEMP = :CODEMP     ';
end;

function TMovimentacaoEstoque.SQL_EstoqueExterno_Update_Lot_Saldos(AEntSai: String; AEhLoteFulfillment : Boolean = False): String;
begin
  Result := '';
  Result := Result + 'UPDATE   ';
  Result := Result + '  CADLOT ';
  Result := Result + 'SET      ';
  Result := Result + '  LOT_SALDOS = IFNULL(LOT_SALDOS, 0) '+RetornaOperadorAritmetico(AEntSai)+' :QTDITE ';
  Result := Result + 'WHERE    ';

  If Not AEhLoteFulfillment Then
  Begin
    Result := Result + '  LOT_NUMLOT = :NUMLOT AND ';
  End Else
  Begin
    Result := Result + '  LOT_CODEXT = :CODEXT AND ';
    Result := Result + '  LOT_FULFIL = "S"     AND ';
  End;

  Result := Result + '  LOT_CODITE = :CODITE AND ';
  Result := Result + '  LOT_CODEMP = :CODEMP     ';

end;

function TMovimentacaoEstoque.SQL_Movimentacoes(ASomenteExterno : Boolean = False): String;
begin

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  DET_EXTFUL, ';
  Result := Result + '  DET_CODEXT, ';
  Result := Result + '  DET_QTDITE, ';
  Result := Result + '  DET_CLAFIS, ';
  Result := Result + '  DET_CODITE, ';
  Result := Result + '  DET_CHACES, ';
  Result := Result + '  DET_FULE_S, ';
  Result := Result + '  DET_FILFUL, ';
  Result := Result + '  DET_FILKAR, ';
  Result := Result + '  DET_EXTFUL, ';
  Result := Result + '  DET_NUMLOT  ';
  Result := Result + 'FROM     ';
  Result := Result + '  MOVDET ';
  Result := Result + '  INNER JOIN MOVTRI ON (MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM) ';
  Result := Result + '  INNER JOIN MOVAUX ON (MOVAUX.DET_SEQGER = MOVDET.AUTOINCREM) ';
  Result := Result + 'WHERE ';
  Result := Result + '  DET_NUMDOC = :NUMDOC AND ';
  Result := Result + '  DET_ESPDOC = :ESPDOC AND ';
  Result := Result + '  DET_CODEMP = :CODEMP AND ';
  Result := Result + '  DET_'+ IIF(FTipoClienteDocumento = 'F', 'CODFOR', 'CODCLI') +' = :CODCLI AND ';
  Result := Result + '  DET_TIP_FC = :TIP_FC     ';

  If Not FSerieDoDocumento.IsEmpty Then
    Result := Result + '  AND DET_SERIE_ = :SERIE_ ';

  If ASomenteExterno Then
    Result := Result + '  AND DET_EXTFUL = "S" ';

  Result := Result + '  UNION ALL ';

  Result := Result + 'SELECT ';
  Result := Result + '  DET_EXTFUL, ';
  Result := Result + '  DET_CODEXT, ';
  Result := Result + '  DET_QTDITE, ';
  Result := Result + '  DET_CLAFIS, ';
  Result := Result + '  DET_CODITE, ';
  Result := Result + '  DET_CHACES, ';
  Result := Result + '  DET_FULE_S, ';
  Result := Result + '  DET_FILFUL, ';
  Result := Result + '  DET_FILKAR, ';
  Result := Result + '  DET_EXTFUL, ';
  Result := Result + '  DET_NUMLOT  ';
  Result := Result + 'FROM     ';
  Result := Result + '  MOVDET ';
  Result := Result + '  INNER JOIN MOVTRI ON (MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM) ';
  Result := Result + '  INNER JOIN MOVAUX ON (MOVAUX.DET_SEQGER = MOVDET.AUTOINCREM) ';
  Result := Result + 'WHERE ';
  Result := Result + '  DET_NUMFAT = :NUMDOC AND ';
  Result := Result + '  DET_TIPFAT = :ESPDOC AND ';
  Result := Result + '  DET_EMPFAT = :CODEMP AND ';
  Result := Result + '  DET_CLIFAT = :CODCLI AND ';
  Result := Result + '  DET_TIP_FC = :TIP_FC     ';

  If ASomenteExterno Then
    Result := Result + '  AND DET_EXTFUL = "S" ';

end;

end.
