unit untCadForPre;

interface

uses Classes, UniClientDataSet;

type
  TForPre = class(TComponent)
    private
      FCodIte: string;
      FCodFor: string;
      FValIte: Double;
      FCdsIte: TUniClientDataSet;
      procedure pSetCodIte(Value: String);
      procedure pSetValIte(Value: Double);
      procedure pGeraErro(strMsg: string);
      procedure pCriaCdsItens;
    public
      constructor Create(AOwner: TComponent);override;
      procedure pCarregarItens;
      procedure pAdicionaItem;
      procedure pApagaItem;
      procedure pGravarItens;
    published
      property strCodFor: string read FCodFor write FCodFor;
      property strCodIte: string read FCodIte write pSetCodIte;
      property fltValIte: Double read FValIte write pSetValIte;
      property cdsItens: TUniClientDataSet read FCdsIte write FCdsIte;
  end;

implementation

uses
  SysUtils, DB, untFuncoesSimples, Uni, untConstantes, untTypesSistema;

{ TForPre }

constructor TForPre.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  pCriaCdsItens;
end;

procedure TForPre.pAdicionaItem;
begin
  pSetCodite(FCodIte);
  pSetValIte(FValIte);

  If FCdsIte.Locate('CODITE', FCodIte, []) Then
    FCdsIte.Delete;

  FCdsIte.AppendRecord([FCodIte, fRetNomProduto(FCodIte), fRetReferenciaProd(FCodIte), FValIte]);
end;

procedure TForPre.pApagaItem;
begin
  With FCdsIte Do
    If (Active) And (RecordCount > 0) And
       (fMensagem('','Excluir Produto?',['','']) = 1) Then FCdsIte.Delete;
end;

procedure TForPre.pCarregarItens;
  var
    qryGen: TUniQuery;
begin
  FCdsIte.EmptyDataSet;

  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Clear;
    Add('SELECT SQL_NO_CACHE FPR_CODITE, FPR_VALITE FROM FORPRE ');
    Add('WHERE FPR_CODFOR = ' + QuotedStr(FCodFor));
    Open;

    While Not Eof Do
    Begin
      FCodIte := FieldByName('FPR_CODITE').AsString;
      FValIte := FieldByName('FPR_VALITE').AsFloat;
      pAdicionaItem;
      Next;
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TForPre.pCriaCdsItens;
begin
  FCdsIte := TUniClientDataSet.Create(Self);
  With FCdsIte Do
  Begin
    FieldDefs.Add('CODITE', ftString, fTamCodIte);
    FieldDefs.Add('DESITE', ftString, 70);
    FieldDefs.Add('REFERE', ftString, 16);
    FieldDefs.Add('VALITE', ftFloat,  00);
    CreateDataSet;
    Open;
    TFloatField(FieldByName('VALITE')).DisplayFormat :=
      fMskDigitos(fCfgSis('DECUNI', varInteger));
  End;
end;

procedure TForPre.pGeraErro(strMsg: string);
begin
  raise ExceptionAutCom.Create(strMsg);
end;

procedure TForPre.pGravarItens;
  var
    qryGen: TUniQuery;
begin

  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Clear;
    Add('DELETE FROM FORPRE WHERE FPR_CODFOR = ' + QuotedStr(FCodFor));
    ExecSQL;

    Clear;
    Add('SELECT * FROM FORPRE WHERE FALSE');
    Open;
  End;

  With FCdsIte Do
  Begin
    First;

    While Not Eof Do
    Begin
      qryGen.Append;
      qryGen.FieldByName('FPR_CODFOR').AsString := FCodFor;
      qryGen.FieldByName('FPR_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('FPR_CODITE').AsString := FieldByName('CODITE').AsString;
      qryGen.FieldByName('FPR_VALITE').AsFloat  := FieldByName('VALITE').AsFloat;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FORPRE', VS_strCodEmp);
      qryGen.Post;
      Next;
    End;

    First;
  End;

  FreeAndNil(qryGen);
end;

procedure TForPre.pSetCodIte(Value: String);
begin
  If fEmptyStr(Value) Then
    pGeraErro('Informe o código do produto!')
  Else If fEmptyStr(fRetNomProduto(Value)) Then
    pGeraErro('Nenhum produto cadastrado com este código!')
  Else
    FCodIte := Value;
end;

procedure TForPre.pSetValIte(Value: Double);
begin
  If Value <= 0 Then
    pGeraErro('Informe um valor maior que zero!')
  Else
    FValIte := Value;
end;

end.
