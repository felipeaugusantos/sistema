unit untGarantiaColetaClassesRetornoColeta;

interface

uses
  untGarantiaColetalibtypes, Uni, System.Generics.Collections, untCadLote,
  untTLock;

Type
  TRetornoColeta = class;
  TItemRetornoColeta = class;
  TListaRetornosColeta = class;
  TItensRetornoColeta = class;

  TListaRetornosColeta = class(TObjectList<TRetornoColeta>)
  public
    function fPermitirIgnorarTrava(const strChvLck: String): Boolean;
  end;

  TRetornoColeta = class
  private
    Operacoes: TSetTipoGarantia;
    function fExecutarQry(aProc: TProcAnonimoQuery): Boolean;
    function fBaixarPedidoDevolucao: Boolean;
    function fExcluirFatGor: Boolean;
    function fExcluirItensFatDor: Boolean;
    function fSqlTotalItensFatGor: String;
    function fObterTotalCreditoSemAvaria(ItensRetornoColeta: TItensRetornoColeta): Double;
    function fSqlGravarMovGCG: String;
    function fSqlGravarMovGCD: String;
    function fGravarMovGCG(Out strAutInc: String; strIncGag: String): Boolean;
    function fGravarMovGCD(const strIncGcg: String; ItemRetornoColeta: TItemRetornoColeta): Boolean;overload;
    function fGravarMovGCD(ItensRetornoColeta: TItensRetornoColeta): Boolean;overload;
    function fGravarRetornoColeta: Boolean;overload;
    function fGravarRetornoColeta(ItensRetornoColeta: TItensRetornoColeta): Boolean;Overload;
    function fTotalIensFatGor: Double;
    function fRetKeyLck(strNumDoc, strEspDoc, strCodDoc: String): String;

  public
    objLock: TLock;
    ItensSemAvaria: TItensRetornoColeta;
    ItensEnvioFornecedor: TItensRetornoColeta;
    ItensCreditoCliente: TItensRetornoColeta;
    ItensReposicao: TItensRetornoColeta;
    strIncGer: String;
    strIncGor: String;
    strNumDoc: String;
    strEspDoc: String;
    strEmpDoc: String;
    strCodOpe: String;
    strCodCli: String;
    strCodCid: String;
    strNumFgo: String;
    strEspFgo: String;
    strEmpFgo: String;
    dtaDtaEnt: TDateTime;
    Validacao: TSetValidacaoRetorno;
    constructor Create;
    Destructor Destroy;override;
    procedure pExibirMensagemDocumentoTravado;
    function fTotalCreditoSemAvaria: Double;
    function fTotalCreditoAvaria: Double;
    function fObterObsCredito: String;
    procedure pAdicionarItem(aItemRetornoColeta: TItemRetornoColeta);
    function fValidar: TSetValidacaoRetorno;
    function fFGorTemItemSelecionado: Boolean;
    function fPermiteProcessarGarantia: Boolean;
    function fExecutar: Boolean;
    function fGetOperacoes: TSetTipoGarantia;
    function fObterItensColeta(const TipoGarantia: TTipoGarantia): TItensRetornoColeta;
    function fTravarPedido: boolean;
    function fRetLckPedido: String;
    procedure pDestravarPedido;

  end;

  TItemRetornoColeta = class
  private
    FstrCodIte: String;
    FstrGarFil: String;
    procedure pSetstrCodIte(const Value: String);
    procedure pSetstrGarFil(const Value: String);
    procedure pVerificarLote;

    function fSQLRevalidarSaldoPedido: String;
  public
    strAutoincrem: String;
    strDesIte: String;
    strIncDor: String;
    strIncGad: String;
    strIncDet: String;
    strIncOri: String;
    fltQtdColeta: Double;
    fltQtdAvaria: Double;
    fltQtdSemAvaria: Double;
    fltUnitar: Double;
    fltValIte: Double;
    fltPreCus: Double;
    strNumLot: String;
    strCodFor: String;
    strTabPre: String;
    strLotSai: String;
    Garantia: TTipoGarantia;
    fltTotFre: Double;
  public
    function fGerarReposicao: Boolean;
    function fLancarCredito: Boolean;
    function fQtdBaixaItemFatDor: Double;
    function fTotalCreditoAvaria: Double;
    function fTotalCreditoSemAvaria: Double;
    function fSaldoColeta: Double;
    function fExcluirFatDor: boolean;
    function fObterValIteUnitario: Double;
    function fObterValIteAvariado: Double;
    function fObterValIteReposicao: Double;
    function fCustoTotalReposicao: Double;
    function fRetornoParcial: Boolean;
    function fValidar: TValidacaoRetorno;
    function fRevalidarSaldoPedido: boolean;
    property strCodIte: String Read FstrCodIte Write pSetstrCodIte;
    property strGarFil: String Read FstrGarFil Write pSetstrGarFil;
  end;

  TItensRetornoColeta = class(TObjectList<TItemRetornoColeta>)
  public
    strAutoIncrem: String;
    strIncGag: String;
    strNumEnt: String;
    blnTemEnvio: Boolean;
  end;


implementation

uses
  System.Variants, untFuncoesSimples, System.SysUtils, untGarantiaColetaLibfuncoes, untGarantiaLibDiversos, Math, StrUtils;

{ TItemRetornoColeta }

function TItemRetornoColeta.fCustoTotalReposicao: Double;
begin
  Result := Self.fltQtdAvaria * Self.fltPrecus;
end;

function TItemRetornoColeta.fExcluirFatDor: boolean;
begin
 Result := Self.fSaldoColeta = 0;
end;

function TItemRetornoColeta.fQtdBaixaItemFatDor: Double;
begin
 Result := fltQtdAvaria + fltQtdSemAvaria;
end;

function TItemRetornoColeta.fRetornoParcial: Boolean;
begin
  Result := Self.fltQtdColeta <> (Self.fltQtdAvaria + Self.fltQtdSemAvaria);
end;

function TItemRetornoColeta.fRevalidarSaldoPedido: boolean;
  Var
    Qry: TUniQuery;
begin
  Result := False;
  Qry := Nil;
  Try
    Qry := fCriaQuery();
    Qry.SQL.clear;
    Qry.Sql.Add(fSQLRevalidarSaldoPedido);
    Qry.ParamByName('AUTOINC').AsString := Self.strIncDor;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    Qry.First;
    Result := Qry.FieldByName('FDO_QTDITE').Asfloat = Self.fltQtdColeta;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  End;
end;

function TItemRetornoColeta.fGerarReposicao: Boolean;
begin
  Result := Self.Garantia = TTipoGarantia.ReposicaoProduto;
end;

function TItemRetornoColeta.fLancarCredito: Boolean;
begin
  Result := Self.Garantia = TTipoGarantia.CreditoCliente;
end;

function TItemRetornoColeta.fObterValIteAvariado: Double;
begin
  Result := Self.fObterValIteUnitario * Self.fltQtdAvaria;
end;

function TItemRetornoColeta.fObterValIteReposicao: Double;
begin
  Result := Self.fltQtdAvaria * Self.fObterValIteUnitario;
end;

function TItemRetornoColeta.fObterValIteUnitario: Double;
begin
  if Self.fltQtdColeta > 0 then
    Result := Self.fltValIte/Self.fltQtdColeta
  else
    Result := 0;
end;

function TItemRetornoColeta.fSaldoColeta: Double;
begin
  Result := fltQtdColeta - (fltQtdAvaria + fltQtdSemAvaria);
end;


function TItemRetornoColeta.fSQLRevalidarSaldoPedido: String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT D.FDO_QTDITE ';
  Result := Result + ' FROM FATDOR D ';
  Result := Result + ' JOIN FATGOR G ON D.FDO_SEQGER = G.AUTOINCREM ';
  Result := Result + ' JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM AND E.FGO_COLETA = ''S'' ';
  Result := Result + ' WHERE D.AUTOINCREM = :AUTOINC ';
end;

function TItemRetornoColeta.fTotalCreditoAvaria: Double;
begin
  if Self.fLancarCredito then
    Result := fltUnitar *  fltQtdAvaria
  else
    Result := 0;
end;

function TItemRetornoColeta.fTotalCreditoSemAvaria: Double;
begin
  Result := fltUnitar * fltQtdSemAvaria;
end;

function TItemRetornoColeta.fValidar: TValidacaoRetorno;
Var
  fltSaldo: Double;
begin
  fltSaldo := Self.fSaldoColeta;
  if fltSaldo = 0 then
    Result := TValidacaoRetorno.Valido
  else  if Self.fSaldoColeta = Self.fltQtdColeta then
    Result := TValidacaoRetorno.NaoInformado
  else if Self.fRetornoParcial then
    Result := TValidacaoRetorno.RetornoParcial
  else
    Result := TValidacaoRetorno.NaoInformado;
end;

procedure TItemRetornoColeta.pSetstrCodIte(const Value: String);

begin
  FstrCodIte := Value;
  pVerificarLote;
end;

procedure TItemRetornoColeta.pSetstrGarFil(const Value: String);
begin
  IF fEmptyStr(Value) or (indexStr(Value,['N','S']) = -1) then
    FstrGarFil := 'N'
  else
    FstrGarFil := Value;
end;

procedure TItemRetornoColeta.pVerificarLote;
Var
  objCadLot : TCadLot;
begin
  objCadLot := Nil;
  Try
    objCadLot := TCadLot.Create(NIl);
    if objCadLot.fExisteLote(Self.strCodIte, vs_strCodEmp, '', False, False) then
    begin
      Self.strLotSai := objCadLot.fRetArmazemPrincipalGarantia(Self.strCodIte);
      if fEmptyStr(Self.strlotSai) then
        Self.strLotSai := 'A DEFINIR';
    end;

  Finally
    if Assigned(objCadLot) then
      FreeAndNil(objCadLot);
  End;
end;

{ TRetornoColeta }

procedure TRetornoColeta.pAdicionarItem(aItemRetornoColeta: TItemRetornoColeta);
begin
  include(Operacoes, aiTemRetornoColeta.Garantia);
  case aiTemRetornoColeta.Garantia of
    TTipoGarantia.Nenhum: ItensSemAvaria.Add(aItemRetornoColeta);
    TTipoGarantia.AguardarRetornoFornecedor: ItensEnvioFornecedor.Add(aItemRetornoColeta) ;
    TTipoGarantia.CreditoCliente: ItensCreditoCliente.Add(aItemRetornoColeta);
    TTipoGarantia.ReposicaoProduto: ItensReposicao.Add(aItemRetornoColeta);
  end;
  if aItemRetornoColeta.fltQtdSemAvaria > 0 then
    include(Operacoes, TTipoGarantia.Nenhum);

end;

procedure TRetornoColeta.pDestravarPedido;
begin
  objLock.pDestravarTodos;
end;

procedure TRetornoColeta.pExibirMensagemDocumentoTravado;
begin
  fMensagem('ATENÇÃO!', 'Essa pedido de coleta está sendo utilizada em outra estação: ' + fGetHostLock(fRetLckPedido + '%'), ['&Ok']);
end;

constructor TRetornoColeta.Create;
begin
  objLock := TLock.Create;
  Validacao := [];
  Self.Operacoes := [];
  ItensSemAvaria        :=  TItensRetornoColeta.Create;
  ItensEnvioFornecedor  :=  TItensRetornoColeta.Create;
  ItensCreditoCliente   :=  TItensRetornoColeta.Create;
  ItensReposicao        :=  TItensRetornoColeta.Create;
end;

destructor TRetornoColeta.Destroy;
begin
  if Assigned(ItensSemAvaria) then
    FreeAndNil(ItensSemAvaria);
  if Assigned(ItensEnvioFornecedor) then
    FreeAndNil(ItensEnvioFornecedor);
  if Assigned(ItensCreditoCliente) then
    FreeAndNil(ItensCreditoCliente);
  if Assigned(ItensReposicao) then
    FreeAndNil(ItensReposicao);

  if Assigned(objLock) then
    FreeAndNil(objLock);
  inherited;
end;

function TRetornoColeta.fBaixarPedidoDevolucao: Boolean;
begin
  Result := Self.fExcluirItensFatDor;

  if Result then
    Result := Self.fTotalIensFatGor = 0;

  if Result then
    Result := Self.fExcluirFatGor
end;

function TRetornoColeta.fSqlTotalItensFatGor: String;
begin
  Result := ' SELECT SUM(IFNULL(FDO_QTDITE,0)) AS TOTAL ';
  Result := Result + ' FROM FATDOR D ';
  Result := Result + ' WHERE D.FDO_SEQGER = :AUTINC ';
end;

function TRetornoColeta.fExcluirFatGor: Boolean;
const
  SQLFatGor: String = 'SELECT * FROM FATGOR WHERE AUTOINCREM = :AUTINC ';
  SQLExtGor: String = 'SELECT * FROM EXTGOR WHERE FGO_SEQFGO = :AUTINC ';
  SQLAuxGor: String = 'SELECT * FROM AUXGOR WHERE AUX_SEQGER = :AUTINC ';

Var
  StrSql: String;
  Proc: TProcAnonimoQuery;
  strTabela: String;
begin
  Try
    Proc := procedure(var Qry: TUniQuery)
                     begin
                      Qry.Sql.Add(strSQL);
                      Qry.ParamByName('AUTINC').AsString := Self.strIncGor;
                      Qry.Open;
                      if Not Qry.IsEmpty then
                      begin
                        fVerificaIntegridade('frmGarantiaRetornoColeta', strTabela, qry, True);
                        qry.Delete;
                      end;
                     end;

    strTabela := 'EXTGOR';
    strSql := SQLExtGor;
    fExecutarQry(Proc);

    strTabela := 'AUXGOR';
    strSql := SQLAuxGor;
    fExecutarQry(Proc);

    strTabela := 'FATGOR';
    strSql := SQLFatGor;
    fExecutarQry(Proc);
    Result := True;
  Except
    on e:Exception do
    begin
       raise Exception.Create(e.message);
    end;
  End;


end;

function TRetornoColeta.fExcluirItensFatDor: Boolean;
const
  SQLFatDor: String = 'SELECT * FROM FATDOR WHERE FDO_SEQGER = :AUTINC ';
  SQLExtDor: String = 'SELECT E.* FROM FATDOR D ' +
                      ' INNER JOIN EXTDOR E ON E.FDO_SEQFDO = D.AUTOINCREM ' +
                      ' WHERE D.FDO_SEQGER = :AUTINC ';
var
  Proc: TProcAnonimoQuery;
  strTabela: String;
  strSQL: String;
begin
  Try
    Proc := procedure(var Qry: TUniQuery)
                     begin
                       Qry.Sql.Add(strSQL);
                       Qry.ParamByName('AUTINC').AsString := Self.strIncGor;
                       Qry.Open;
                       if Not Qry.IsEmpty then
                       begin
                         Qry.First;
                         if strTabela = 'FATDOR' then
                           while Not Qry.Eof do
                           begin
                             fVerificaIntegridade('frmGarantiaRetornoColeta', strTabela, qry, True);
                             Qry.Delete;
                           end;
                       end;
                     end;

    strTabela := 'EXTDOR';
    strSQL:= SQLExtDor;
    fExecutarQry(Proc);

    strTabela := 'FATDOR';
    strSQL := SQLFatDor;
    fExecutarQry(Proc);
    Result := True;
  Except
    on e:Exception do
    begin
       raise Exception.Create(e.message);
    end;
  End;
end;

function TRetornoColeta.fExecutar: Boolean;
begin
  Result := Self.fBaixarPedidoDevolucao;
  if Result then
      Result := Self.fGravarRetornoColeta
end;

function TRetornoColeta.fExecutarQry(aProc: TProcAnonimoQuery): Boolean;
Var Qry: TUniQuery;
begin
  Result := True;
  Try
    Try
      Qry := fCriaQuery();
      Qry.Sql.Clear;
      aProc(Qry); //chamada do método anônimo.
    Finally
      if Assigned(Qry) then
        FreeAndNil(Qry);
    End;
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(e.Message,'[TRetornoColeta.fExecutarQry]');
    end
  End;
end;

function TRetornoColeta.fFGorTemItemSelecionado: Boolean;
Var
  aValidacao: TValidacaoRetorno;
begin
  if Validacao = [] then
    Validacao := Self.fValidar;

  for aValidacao in TEMITEMSELECIONADO do
  begin
    Result := aValidacao in Validacao;
    if Result then
      Break;
  end;
end;

function TRetornoColeta.fGravarRetornoColeta: Boolean;
Var
  Operacao: TTipoGarantia;
begin
  Result := True;
  for Operacao in Self.fGetOperacoes do
  begin
    case Operacao of
      TTipoGarantia.Nenhum: Result := fGravarRetornoColeta(ItensSemAvaria) ;
      TTipoGarantia.AguardarRetornoFornecedor: Result := fGravarRetornoColeta(ItensEnvioFornecedor) ;
      TTipoGarantia.CreditoCliente: Result := fGravarRetornoColeta(ItensCreditoCliente);
      TTipoGarantia.ReposicaoProduto: Result := fGravarRetornoColeta(ItensReposicao);
    end;
    if Not Result then
      Break;
  end;
end;

function TRetornoColeta.fGravarRetornoColeta(ItensRetornoColeta: TItensRetornoColeta): Boolean;
begin
  Result := Self.fGravarMovGCG(ItensRetornoColeta.strAutoIncrem, ItensRetornoColeta.strIncGag);
  if Result then
  begin
    Result := Self.fGravarMovGCD(ItensRetornoColeta);
  end;
end;



function TRetornoColeta.fSqlGravarMovGCG: String;
begin
  Result := Result + 'INSERT INTO MOVGCG (AUTOINCREM, GCG_SEQGAG, GCG_SEQGER, GCG_SEQGOR, GCG_DTAENT) ';
  Result := Result + 'VALUES (:AUTOINCREM, :GCG_SEQGAG, :GCG_SEQGER, :GCG_SEQGOR, :GCG_DTAENT) ';
end;



function TRetornoColeta.fGravarMovGCG(Out strAutInc: String; strIncGag: String): Boolean;
Var
  lstrAutInc: String;
begin
  lstrAutInc := fRetAutoIncrem('MOVGCG', VS_strCodEmp);
  Result := fExecutarQry(procedure(var Qry: TUniQuery)
                         begin
                          Qry.Sql.Add(fSqlGravarMovGCG);
                          Qry.ParamByName('AUTOINCREM').AsString    := lstrAutInc;
                          if fEmptyStr(strIncGag) then
                            Qry.ParamByName('GCG_SEQGAG').Value     := Null
                          else
                            Qry.ParamByName('GCG_SEQGAG').AsString  := strIncGag;
                          Qry.ParamByName('GCG_SEQGER').AsString    := Self.strIncGer;
                          Qry.ParamByName('GCG_SEQGOR').AsString    := Self.strIncGor;
                          Qry.ParamByName('GCG_DTAENT').AsDateTime  := Self.dtaDtaEnt;
                          Qry.ExecSql;
                         end);

  if Result then
      strAutInc := lstrAutInc;

end;


function TRetornoColeta.fSqlGravarMovGCD: String;
begin
  Result := 'INSERT INTO MOVGCD (AUTOINCREM,  GCD_SEQGCG,  GCD_SEQGAD,  GCD_SEQDET,  GCD_SEQDOR,  GCD_QTDCOL,  GCD_QTDAVA,  GCD_QTDSEM, GCD_TIPGAR) ';
  Result := Result + 'VALUES (:AUTOINCREM,  :GCD_SEQGCG,  :GCD_SEQGAD,  :GCD_SEQDET,  :GCD_SEQDOR,  :GCD_QTDCOL,  :GCD_QTDAVA,  :GCD_QTDSEM, :GCD_TIPGAR) ';
end;


function TRetornoColeta.fGravarMovGCD(const strIncGcg: String; ItemRetornoColeta: TItemRetornoColeta): Boolean;
begin
  Result := fExecutarQry(procedure(var Qry: TUniQuery)
                         begin
                          Qry.Sql.Add(fSqlGravarMovGCD);
                          Qry.ParamByName('AUTOINCREM').AsString   := ItemRetornoColeta.strAutoincrem;
                          Qry.ParamByName('GCD_SEQGCG').AsString   := strincGCG;
                          if fEmptystr(ItemRetornoColeta.strIncGad) then
                            Qry.ParamByName('GCD_SEQGAD').Value      := Null
                          else
                            Qry.ParamByName('GCD_SEQGAD').AsString  := ItemRetornoColeta.strIncGad;

                          Qry.ParamByName('GCD_SEQDET').AsString   := ItemRetornoColeta.strIncDet;
                          Qry.ParamByName('GCD_SEQDOR').AsString   := ItemRetornoColeta.strIncDor;
                          Qry.ParamByName('GCD_QTDCOL').AsFloat    := ItemRetornoColeta.fltQtdColeta;
                          Qry.ParamByName('GCD_QTDAVA').AsFloat    := ItemRetornoColeta.fltQtdAvaria;
                          Qry.ParamByName('GCD_QTDSEM').AsFloat    := ItemRetornoColeta.fltQtdSemAvaria;
                          Qry.ParamByName('GCD_TIPGAR').AsString   := ItemRetornoColeta.Garantia.GetIndexAsString;
                          Qry.ExecSql;
                         end);
end;


function TRetornoColeta.fGravarMovGCD(ItensRetornoColeta: TItensRetornoColeta): Boolean;
Var
  Item: TItemRetornoColeta;
begin
  Result := ItensRetornoColeta.Count = 0;
  if Not Result then
  begin
    for Item in ItensRetornoColeta do
    begin
      Item.strAutoincrem := fRetAutoIncrem('MOVGCD',VS_strCodEmp);
      Result := Self.fGravarMovGCD(ItensREtornoColeta.strAutoIncrem, Item);
      if Not Result then
        Break;
    end;
  end;
end;

function TRetornoColeta.fGetOperacoes: TSetTipoGarantia;
begin
  Result := Self.Operacoes;
end;

function TRetornoColeta.fObterItensColeta(const TipoGarantia: TTipoGarantia): TItensRetornoColeta;
begin
  case TipoGarantia of
    TTipoGarantia.Nenhum:                     Result := Self.ItensSemAvaria;
    TTipoGarantia.AguardarRetornoFornecedor:  Result := Self.ItensEnvioFornecedor;
    TTipoGarantia.CreditoCliente:             Result := Self.ItensCreditoCliente;
    TTipoGarantia.ReposicaoProduto:           Result := Self.ItensReposicao;
    Else
      Result := nil;
  end;
end;

function TRetornoColeta.fObterObsCredito: String;
begin
  Result :='Documento: '+ fConcatenar([Self.strNumDoc, Self.strEspDoc, Self.strEmpDoc],'-');
end;

function TRetornoColeta.fTotalCreditoAvaria: Double;
Var
 aItem: TItemRetornoColeta;
Begin
  Result := 0;
  for aItem in Self.ItensCreditoCliente do
  begin
    Result := Result + RoundTo(aItem.fTotalCreditoAvaria,-2);
  end;
end;

function TRetornoColeta.fTotalCreditoSemAvaria: Double;
begin
  Result := 0;
  Result := Result + fFormataFloat(fObterTotalCreditoSemAvaria(ItensSemAvaria)
                     + fObterTotalCreditoSemAvaria(ItensEnvioFornecedor)
                     + fObterTotalCreditoSemAvaria(ItensCreditoCliente)
                     + fObterTotalCreditoSemAvaria(ItensReposicao),02);

end;

function TRetornoColeta.fTotalIensFatGor: Double;
Var
  fltResult: Double;
begin
  fltResult := 0;
  fExecutarQry(procedure(Var Qry: TUniQuery)
               begin
                Qry.SQL.Add(Self.fSqlTotalItensFatGor);
                Qry.ParamByName('AUTINC').AsString := Self.strIncGor;
                Qry.Open;
                if Not Qry.IsEmpty then
                begin
                  fltResult := Qry.FieldByName('TOTAL').AsFloat;
                end;
               end);

  Result := fltResult;
end;

function TRetornoColeta.fTravarPedido: boolean;
  Var
    strLck: String;
begin
  Result := True;
  strLck := fRetLckPedido;

  objLock.fLock_Unlock(strLck, False);

  If Not objLock.fLock_Unlock(strLck, True, False) Then
    Result := False;
end;

function TRetornoColeta.fValidar: TSetValidacaoRetorno;
Var
  Item: TITemRetornoColeta;
  ValidacaoItem: TValidacaoRetorno;
begin
  Result := [];
  for Item in Self.ItensSemAvaria do
  begin
    ValidacaoItem := Item.fValidar;
    Result := Result + [ValidacaoItem];
  end;

  for Item in Self.ItensEnvioFornecedor do
  begin
    ValidacaoItem := Item.fValidar;
    Result := Result + [ValidacaoItem];
  end;

  for Item in Self.ItensCreditoCliente do
  begin
    ValidacaoItem := Item.fValidar;
    Result := Result + [ValidacaoItem];
  end;

  for Item in Self.ItensReposicao do
  begin
    ValidacaoItem := Item.fValidar;
    Result := Result + [ValidacaoItem];
  end;

end;

function TRetornoColeta.fObterTotalCreditoSemAvaria(ItensRetornoColeta: TItensRetornoColeta): Double;
Var
  aItem: TItemRetornoColeta;
begin
  Result := 0;
  for aItem in ItensRetornoColeta do
  begin
    Result := Result + aItem.fTotalCreditoSemAvaria;
  end;
end;

function TRetornoColeta.fPermiteProcessarGarantia: Boolean;
Var
  aValidacao: TValidacaoRetorno;
begin
  Result := TValidacaoRetorno.Valido in Self.Validacao;

  if Not Result then
    Exit(Result);

  for aValidacao in NAOPERMITIRGARANTIA do
  begin
    Result := Not  (aValidacao in Self.Validacao);
    if Not Result then
      Break;
  end;
end;


function TRetornoColeta.fRetKeyLck(strNumDoc, strEspDoc,
  strCodDoc: String): String;
begin
  Result := 'RETORNO_COL_'+ fConcatenar([strNumDoc, strEspDoc, strEmpDoc], '-');
end;

function TRetornoColeta.fRetLckPedido: String;
begin
  Result := fRetKeyLck(Self.strNumFgo, Self.strEspFgo, Self.strEmpFgo);
end;


{ TListaRetornosColeta }

function TListaRetornosColeta.fPermitirIgnorarTrava(
  const strChvLck: String): Boolean;
  Var
    i: Integer;
begin
  Result := False;

  if Self.Count = 0 then
    Exit;

  for i := 0 to Self.Count -1 do
  begin
    Result := Self.Items[i].fRetLckPedido = strChvLck;
    if Result then
      Break;
  end;
end;

end.
