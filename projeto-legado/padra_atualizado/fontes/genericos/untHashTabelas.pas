unit untHashTabelas;

interface

uses Classes, Uni, DB;

type
  THashTabela = class(TObject)
    private
      FTabela: String;
      FCampos: TStringList;
      FDecimais: TStringList;

      procedure pChecarListaCampos;
      procedure pChecarTabelaExiste;

      procedure pCarregaMetaDadosCampos;
      procedure pCarregaMetaDadosDa(qryTabela: TDataSet);
      procedure pCarregaPrecisaoDo(strCampo, strTipo: String);
      function  fExtraiPrecisaoDo(strTipo: String): String;

      function fCamposSQLMD5: String;
      function fRetornaValorCampo(qryTabela: TDataSet;
        strCampo: String): String;
      function fRetornaValorCampoNumerico(qryTabela: TDataSet;
        strCampo: String): String;
    public
      constructor Create(strTabela: String; stlCampos: TStringList);
      function fRetornaSQLMD5: String;
      function fRetornaMd5Query(qryTabela: TDataSet): String;
      destructor Destroy; override;
  End;

  TCacheHashTabela = class(TObject)
    private
      FCache: TStringList;
      function fIndiceObjetoDa(strTabela: String): Integer;
      function fRetornaObjetoDeIndice(intIndice: Integer): THashTabela;
    public
      constructor Create;
      function fCriarOuRetornarHashTabela(strTabela: String;
        stlCampos: TStringList): THashTabela;
  End;

  function fCacheHash: TCacheHashTabela;

Var
  objInternoCacheHash: TCacheHashTabela;

implementation

uses
  untFuncoesSimples, TypInfo, SysUtils, StrUtils, untFuncoes, untFuncoesHash;

function fCacheHash: TCacheHashTabela;
begin
  If Not Assigned(objInternoCacheHash) Then
    objInternoCacheHash := TCacheHashTabela.Create;

  Result := objInternoCacheHash
end;

{ THashTabela }

constructor THashTabela.Create(strTabela: String; stlCampos: TStringList);
begin
  FTabela := strTabela;
  FCampos := stlCampos;
  FDecimais := TStringList.Create;

  pChecarListaCampos;
  pChecarTabelaExiste;
  pCarregaMetaDadosCampos;
end;

procedure THashTabela.pChecarListaCampos;
begin
  If Not Assigned(FCampos) Then
    Raise Exception.Create('Lista de campos não atribuida corretamente.');

  If FCampos.Count <= 0 Then
    Raise Exception.Create('Lista de campos deve conter pelo menos um elemento.');
end;

procedure THashTabela.pChecarTabelaExiste;
begin
  If Not fTabelaExiste(FTabela) Then
    Raise Exception.Create('Tabela ' + FTabela + ' não existe.');
end;

procedure THashTabela.pCarregaMetaDadosCampos;
  Var
    qryDesc: TUniQuery;
begin
  qryDesc := fCriaQuery;
  qryDesc.SQL.Add('DESC ' + FTabela);
  qryDesc.Open;

  pCarregaMetaDadosDa(qryDesc);

  FreeAndNil(qryDesc);
end;

procedure THashTabela.pCarregaMetaDadosDa(qryTabela: TDataSet);
  Var
    strCampo: String;
    strTipo: String;
begin
  qryTabela.First;
  While (Not qryTabela.Eof) Do
  Begin
    strCampo := qryTabela.Fields[0].AsString;
    strTipo  := qryTabela.Fields[1].AsString;

    pCarregaPrecisaoDo(strCampo, strTipo);
    qryTabela.Next;
  End;
end;

procedure THashTabela.pCarregaPrecisaoDo(strCampo, strTipo: String);
begin
  If (AnsiStartsText('DECIMAL', strTipo)) Then
  Begin
    FDecimais.Values[strCampo] := fExtraiPrecisaoDo(strTipo);
  End;
end;

function THashTabela.fExtraiPrecisaoDo(strTipo: String): String;
  Var
    intPosVirgula: Integer;
    intPosParentesis: Integer;
    strTmp: String;
begin
  intPosVirgula := Pos(',', strTipo);
  If (intPosVirgula > 0) Then
  Begin
    strTmp := Copy(strTipo, intPosVirgula+1, Length(strTipo));

    intPosParentesis := Pos(')', strTmp);
    strTmp := Copy(strTmp, 1, intPosParentesis-1);
    
    Result := strTmp;
  End
  Else
    Result := '0';
end;

function THashTabela.fRetornaSQLMD5: String;
begin
  Result := 'MD5(CONCAT(' + fCamposSQLMD5 + '))';
end;

function THashTabela.fCamposSQLMD5: String;
  Var
    intContador: Integer;
    intMaximo: Integer;
begin
  Result := '';

  intMaximo := FCampos.Count-1;
  For intContador := 0 To intMaximo Do
  Begin
    Result := Result + 'IFNULL(' + FTabela + '.' + FCampos[intContador] + ', "")';

    If (intContador < intMaximo) Then
      Result := Result + ',';
  End;
end;

function THashTabela.fRetornaMd5Query(qryTabela: TDataSet): String;
  Var
    intContador: Integer;
    strValor: String;
begin
  strValor := '';
  For intContador := 0 To FCampos.Count -1 Do
  Begin
    strValor := strValor + fRetornaValorCampo(qryTabela, FCampos[intContador]);
  End;

  Result := AnsiLowerCase(fRetHashString(strValor));
end;

function THashTabela.fRetornaValorCampo(qryTabela: TDataSet; strCampo: String): String;
begin
  If qryTabela.FieldByName(strCampo).IsNull Then
    Result := ''
  Else If (qryTabela.FieldByName(strCampo).DataType = ftDate) Then
  Begin
    Result := FormatDateTime('yyyy-mm-dd', qryTabela.FieldByName(strCampo).AsDateTime)
  End
  Else If (qryTabela.FieldByName(strCampo).DataType = ftFloat) Then
  Begin
    Result := fRetornaValorCampoNumerico(qryTabela, strCampo);
  End
  Else
    Result := qryTabela.FieldByName(strCampo).AsString;
end;

function THashTabela.fRetornaValorCampoNumerico(qryTabela: TDataSet; strCampo: String): String;
  Var
    intPrecisao: Integer;
begin
  intPrecisao := StrToInt(FDecimais.Values[strCampo]);
  Result := FloatToStrF(qryTabela.FieldByName(strCampo).AsFloat, ffNumber, 12, intPrecisao);
  Result := AnsiReplaceStr(Result, '.', '');
  Result := AnsiReplaceStr(Result, ',', '.');
end;

destructor THashTabela.Destroy;
begin
  FreeAndNil(FDecimais);
  inherited;
end;

{ TCacheHashTabela }

constructor TCacheHashTabela.Create;
begin
  FCache := TStringList.Create;
end;

function TCacheHashTabela.fCriarOuRetornarHashTabela(strTabela: String;
  stlCampos: TStringList): THashTabela;
  Var
    intIndiceObjeto: Integer;
begin
  intIndiceObjeto := fIndiceObjetoDa(strTabela);
  If intIndiceObjeto <= -1 Then
    Result := THashTabela.Create(strTabela, stlCampos)
  else
    Result := fRetornaObjetoDeIndice(intIndiceObjeto);
end;

function TCacheHashTabela.fIndiceObjetoDa(strTabela: String): Integer;
begin
  Result := FCache.IndexOfName(strTabela);
end;

function TCacheHashTabela.fRetornaObjetoDeIndice(
  intIndice: Integer): THashTabela;
begin
  Result := THashTabela(FCache.Objects[intIndice]);
end;

end.
