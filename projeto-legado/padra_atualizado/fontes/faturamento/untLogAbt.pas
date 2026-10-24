unit untLogAbt;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  untFuncoesGenerica, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils,
  Data.DB,
  MemDS,
  DBAccess,
  Uni,
  Generics.Collections;

type
  TLogAbt = Class
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodIte: String;
    strAutInc: String;
    fltQtdIte: Double;
    blnSelecaoAnt: Boolean;
    blnSelecaoAtu: Boolean;
    fltEstoqueAnt: Double;
    fltEstoqueAtu: Double;
    fltComprarAnt: Double;
    fltComprarAtu: Double;
    fltRequisAnt: Double;
    fltRequisAtu: Double;
    fltTransfAnt: Double;
    fltTransfAtu: Double;
    fltQtdCompraAnt: Double;
    fltQtdCompraAtu: Double;
    fltQtdLojaAnt: Double;
    fltQtdLojaAtu: Double;
    fltQtdFiliaisAnt: Double;
    fltQtdFiliaisAtu: Double;
    public
      constructor Create();
      procedure pClear();
  end;


type
  TListLogAbt = Class(TList<TLogAbt>)
    public
      function fRetornaPeloAutInc(strAutInc:String):TLogAbt;
      procedure pGravarListaLogAbt(strNumDoc, strEspDoc, strEmpDoc: String; blnLimparLista:Boolean = False);
      function fGravacaoPendente():Boolean;
  end;

procedure pGravaLogAbt(objLogAbt: TLogAbt);

implementation

procedure pGravaLogAbt(objLogAbt: TLogAbt);
Var
  qryLogAbt: TUniQuery;
begin
  qryLogAbt := fCriaQuery();

  Try
    qryLogAbt.SQL.Add('  INSERT INTO LOGABT (      ');
    qryLogAbt.SQL.Add('    LOG_DATA,               ');
    qryLogAbt.SQL.Add('    LOG_HORA,               ');
    qryLogAbt.SQL.Add('    LOG_NUMDOC,             ');
    qryLogAbt.SQL.Add('    LOG_ESPDOC,             ');
    qryLogAbt.SQL.Add('    LOG_CODEMP,             ');
    qryLogAbt.SQL.Add('    LOG_CODITE,             ');
    qryLogAbt.SQL.Add('    LOG_QTDITE,             ');
    qryLogAbt.SQL.Add('    LOG_SELECAO_ANT,        ');
    qryLogAbt.SQL.Add('    LOG_SELECAO_ATU,        ');
    qryLogAbt.SQL.Add('    LOG_ESTOQUE_ANT,        ');
    qryLogAbt.SQL.Add('    LOG_ESTOQUE_ATU,        ');
    qryLogAbt.SQL.Add('    LOG_COMPRAR_ANT,        ');
    qryLogAbt.SQL.Add('    LOG_COMPRAR_ATU,        ');
    qryLogAbt.SQL.Add('    LOG_REQUISITADA_ANT,    ');
    qryLogAbt.SQL.Add('    LOG_REQUISITADA_ATU,    ');
    qryLogAbt.SQL.Add('    LOG_TRANSF_ANT,         ');
    qryLogAbt.SQL.Add('    LOG_TRANSF_ATU,         ');
    qryLogAbt.SQL.Add('    LOG_QTDCOMPRAS_ANT,     ');
    qryLogAbt.SQL.Add('    LOG_QTDCOMPRAS_ATU,     ');
    qryLogAbt.SQL.Add('    LOG_QTDLOJA_ANT,        ');
    qryLogAbt.SQL.Add('    LOG_QTDLOJA_ATU,        ');
    qryLogAbt.SQL.Add('    LOG_QTDFILIAIS_ANT,     ');
    qryLogAbt.SQL.Add('    LOG_QTDFILIAIS_ATU      ');
    qryLogAbt.SQL.Add('  ) VALUES (                ');
    qryLogAbt.SQL.Add('    :DATA,               ');
    qryLogAbt.SQL.Add('    :HORA,               ');
    qryLogAbt.SQL.Add('    :NUMDOC,             ');
    qryLogAbt.SQL.Add('    :ESPDOC,             ');
    qryLogAbt.SQL.Add('    :CODEMP,             ');
    qryLogAbt.SQL.Add('    :CODITE,             ');
    qryLogAbt.SQL.Add('    :QTDITE,             ');
    qryLogAbt.SQL.Add('    :SELECAO_ANT,        ');
    qryLogAbt.SQL.Add('    :SELECAO_ATU,        ');
    qryLogAbt.SQL.Add('    :ESTOQUE_ANT,        ');
    qryLogAbt.SQL.Add('    :ESTOQUE_ATU,        ');
    qryLogAbt.SQL.Add('    :COMPRAR_ANT,        ');
    qryLogAbt.SQL.Add('    :COMPRAR_ATU,        ');
    qryLogAbt.SQL.Add('    :REQUISITADA_ANT,    ');
    qryLogAbt.SQL.Add('    :REQUISITADA_ATU,    ');
    qryLogAbt.SQL.Add('    :TRANSF_ANT,         ');
    qryLogAbt.SQL.Add('    :TRANSF_ATU,         ');
    qryLogAbt.SQL.Add('    :QTDCOMPRAS_ANT,     ');
    qryLogAbt.SQL.Add('    :QTDCOMPRAS_ATU,     ');
    qryLogAbt.SQL.Add('    :QTDLOJA_ANT,        ');
    qryLogAbt.SQL.Add('    :QTDLOJA_ATU,        ');
    qryLogAbt.SQL.Add('    :QTDFILIAIS_ANT,     ');
    qryLogAbt.SQL.Add('    :QTDFILIAIS_ATU      ');
    qryLogAbt.SQL.Add('  )                      ');


    qryLogAbt.ParamByName('DATA').AsDateTime           := Date;
    qryLogAbt.ParamByName('HORA').AsDateTime           := fTime();
    qryLogAbt.ParamByName('NUMDOC').AsString           := objLogAbt.strNumDoc;
    qryLogAbt.ParamByName('ESPDOC').AsString           := objLogAbt.strEspDoc;
    qryLogAbt.ParamByName('CODEMP').AsString           := objLogAbt.strCodEmp;
    qryLogAbt.ParamByName('CODITE').AsString           := objLogAbt.strCodIte;
    qryLogAbt.ParamByName('QTDITE').AsFloat            := objLogAbt.fltQtdIte;
    qryLogAbt.ParamByName('SELECAO_ANT').AsBoolean     := objLogAbt.blnSelecaoAnt;
    qryLogAbt.ParamByName('SELECAO_ATU').AsBoolean     := objLogAbt.blnSelecaoAtu;
    qryLogAbt.ParamByName('ESTOQUE_ANT').AsFloat       := objLogAbt.fltEstoqueAnt;
    qryLogAbt.ParamByName('ESTOQUE_ATU').AsFloat       := objLogAbt.fltEstoqueAtu;
    qryLogAbt.ParamByName('COMPRAR_ANT').AsFloat       := objLogAbt.fltComprarAnt;
    qryLogAbt.ParamByName('COMPRAR_ATU').AsFloat       := objLogAbt.fltComprarAtu;
    qryLogAbt.ParamByName('REQUISITADA_ANT').AsFloat   := objLogAbt.fltRequisAnt;
    qryLogAbt.ParamByName('REQUISITADA_ATU').AsFloat   := objLogAbt.fltRequisAtu;
    qryLogAbt.ParamByName('TRANSF_ANT').AsFloat        := objLogAbt.fltTransfAnt;
    qryLogAbt.ParamByName('TRANSF_ATU').AsFloat        := objLogAbt.fltTransfAtu;
    qryLogAbt.ParamByName('QTDCOMPRAS_ANT').AsFloat    := objLogAbt.fltQtdCompraAnt;
    qryLogAbt.ParamByName('QTDCOMPRAS_ATU').AsFloat    := objLogAbt.fltQtdCompraAtu;
    qryLogAbt.ParamByName('QTDLOJA_ANT').AsFloat       := objLogAbt.fltQtdLojaAnt;
    qryLogAbt.ParamByName('QTDLOJA_ATU').AsFloat       := objLogAbt.fltQtdLojaAtu;
    qryLogAbt.ParamByName('QTDFILIAIS_ANT').AsFloat    := objLogAbt.fltQtdFiliaisAnt;
    qryLogAbt.ParamByName('QTDFILIAIS_ATU').AsFloat    := objLogAbt.fltQtdFiliaisAtu;

    qryLogAbt.ExecSQL;
  Finally
    FreeAndNil(qryLogAbt);
  End;
end;

{ TLogAbt }

constructor TLogAbt.Create;
begin
  Self.pClear;
end;

procedure TLogAbt.pClear;
begin
  strNumDoc := '';
  strEspDoc := '';
  strCodEmp := '';
  strCodIte := '';
  strAutInc := '';
  fltQtdIte := 0;
  blnSelecaoAnt := False;
  blnSelecaoAtu := False;
  fltEstoqueAnt := 0;
  fltEstoqueAtu := 0;
  fltComprarAnt := 0;
  fltComprarAtu := 0;
  fltRequisAnt := 0;
  fltRequisAtu := 0;
  fltTransfAnt := 0;
  fltTransfAtu := 0;
  fltQtdCompraAnt := 0;
  fltQtdCompraAtu := 0;
  fltQtdLojaAnt := 0;
  fltQtdLojaAtu := 0;
  fltQtdFiliaisAnt := 0;
  fltQtdFiliaisAtu := 0;
end;

{ TListLogAbt }

function TListLogAbt.fGravacaoPendente: Boolean;
begin
  Result := (Self.Count > 0);
end;

function TListLogAbt.fRetornaPeloAutInc(strAutInc: String): TLogAbt;
Var
  intIndex: Integer;
begin
  Result := Nil;

  For intIndex := 0 To PRed(Self.Count) Do
  Begin
    If (strAutInc = Self[intIndex].strAutInc) Then
    Begin
      Result := Self[intIndex];
      Break;
    End;
  End;
end;

procedure TListLogAbt.pGravarListaLogAbt(strNumDoc, strEspDoc, strEmpDoc: String; blnLimparLista:Boolean = False);
Var
  intIndex: Integer;
begin
  For intIndex := 0 To PRed(Self.Count) Do
  Begin
    Self[intIndex].strNumDoc := strNumDoc;
    Self[intIndex].strEspDoc := strEspDoc;
    Self[intIndex].strCodEmp := strEmpDoc;

    pGravaLogAbt(Self[intIndex]);
  End;

  If blnLimparLista Then
    Self.Clear;
end;

end.

