unit untTIndiceBuscaCartao;

interface

uses
  System.SysUtils, System.Generics.Collections, Data.DB, UniClientDataSet;

type
  {Req: 445076
   Substitui o Locate em datasets grandes da conciliação.

   Para cada chave guarda o PRIMEIRO registro na ordem do índice corrente (o
   mesmo que o Locate devolveria) e encadeia os demais registros da mesma
   chave, também na ordem do índice. Cada registro é guardado como
   "RecNo|AutoIncremento" (AUTOINCREM da MOVCAR).

   Proteções - quem usa NÃO precisa se preocupar com índice ou filtro:
     - ao posicionar pelo RecNo, confere se o AutoIncremento é o mesmo da
       carga. Se não for, as posições mudaram: recarrega e busca de novo;
     - confere a chave campo a campo antes de retornar. Se o registro não
       tem mais a chave (ex.: MCA_MARDES virou 'M'), segue para o próximo
       da mesma chave;
     - se o dataset mudou de IndexFieldNames, Filter, Filtered ou quantidade
       de registros (Append/Delete), o índice se recarrega antes da busca.
   Pior caso: recarregar (fica mais lento). Nunca posiciona no registro errado.

   Limite: um registro que PASSA a ter a chave procurada depois da carga (edição
   de um campo da chave para o valor buscado) só é visto após recarregar.}
  TIndiceBuscaCartao = class
  private
    FDataSet: TUniClientDataSet;
    FNomeCampoAutoIncremento: String;
    FNomesCampos: TArray<String>;
    FCampoAutoIncremento: TField;
    FCampos: TArray<TField>;
    FPrimeiro: TDictionary<String, String>;
    FProximo: TArray<String>;
    FAssinatura: String;

    function RetornaAssinatura: String;
    function MontaChave(const AValores: array of String): String;
    function MontaChaveRegistroAtual: String;
    function MontaValorRegistroAtual: String;
    procedure SeparaValor(const AValor: String; out ARecNo: Integer; out AAutoIncremento: String);
    procedure Carregar;
  public
    constructor Create(ADataSet: TUniClientDataSet; const ACampoAutoIncremento: String;
      const ACampos: array of String);
    destructor Destroy; override;

    function Localizar(const AValores: array of String): Boolean;

    class function FormataData(AData: TDateTime): String;
  end;

implementation

{ TIndiceBuscaCartao }

constructor TIndiceBuscaCartao.Create(ADataSet: TUniClientDataSet;
  const ACampoAutoIncremento: String; const ACampos: array of String);
  Var
    LContador: Integer;
begin
  inherited Create;

  FDataSet := ADataSet;
  FNomeCampoAutoIncremento := ACampoAutoIncremento;

  SetLength(FNomesCampos, Length(ACampos));
  For LContador := 0 To High(ACampos) Do
    FNomesCampos[LContador] := ACampos[LContador];

  FPrimeiro := TDictionary<String, String>.Create;

  //Carga preguiçosa: só carrega na primeira busca
  FAssinatura := EmptyStr;
end;

destructor TIndiceBuscaCartao.Destroy;
begin
  FreeAndNil(FPrimeiro);

  inherited;
end;

class function TIndiceBuscaCartao.FormataData(AData: TDateTime): String;
begin
  Result := FormatDateTime('yyyymmdd', AData);
end;

function TIndiceBuscaCartao.RetornaAssinatura: String;
begin
  Result := FDataSet.IndexFieldNames + '|' +
            FDataSet.Filter + '|' +
            BoolToStr(FDataSet.Filtered, True) + '|' +
            IntToStr(FDataSet.RecordCount);
end;

function TIndiceBuscaCartao.MontaChave(const AValores: array of String): String;
  Var
    LContador: Integer;
begin
  Result := AValores[0];
  For LContador := 1 To High(AValores) Do
    Result := Result + '|' + AValores[LContador];
end;

function TIndiceBuscaCartao.MontaChaveRegistroAtual: String;
  Var
    LContador: Integer;
    LValor: String;
begin
  Result := EmptyStr;

  For LContador := 0 To High(FCampos) Do
  Begin
    If FCampos[LContador].DataType In [ftDate, ftDateTime, ftTimeStamp] Then
      LValor := FormataData(FCampos[LContador].AsDateTime)
    Else
      LValor := FCampos[LContador].AsString;

    If LContador = 0 Then
      Result := LValor
    Else
      Result := Result + '|' + LValor;
  End;
end;

function TIndiceBuscaCartao.MontaValorRegistroAtual: String;
begin
  Result := IntToStr(FDataSet.RecNo) + '|' + FCampoAutoIncremento.AsString;
end;

procedure TIndiceBuscaCartao.SeparaValor(const AValor: String; out ARecNo: Integer;
  out AAutoIncremento: String);
  Var
    LPosicao: Integer;
begin
  LPosicao := Pos('|', AValor);

  ARecNo := StrToInt(Copy(AValor, 1, LPosicao - 1));
  AAutoIncremento := Copy(AValor, LPosicao + 1, Length(AValor));
end;

procedure TIndiceBuscaCartao.Carregar;
  Var
    LUltimo: TDictionary<String, Integer>;
    LChave,
    LValor: String;
    LContador,
    LRecNo,
    LRecNoOriginal: Integer;
begin
  FCampoAutoIncremento := FDataSet.FieldByName(FNomeCampoAutoIncremento);

  SetLength(FCampos, Length(FNomesCampos));
  For LContador := 0 To High(FNomesCampos) Do
    FCampos[LContador] := FDataSet.FieldByName(FNomesCampos[LContador]);

  FPrimeiro.Clear;
  SetLength(FProximo, 0);
  SetLength(FProximo, FDataSet.RecordCount + 1);

  LRecNoOriginal := FDataSet.RecNo;

  //LUltimo: chave -> RecNo do último registro da chave, para encadear o próximo
  LUltimo := TDictionary<String, Integer>.Create;
  Try
    FDataSet.First;
    While Not FDataSet.Eof Do
    Begin
      LChave := MontaChaveRegistroAtual;
      LValor := MontaValorRegistroAtual;
      LRecNo := FDataSet.RecNo;

      If LUltimo.ContainsKey(LChave) Then
        FProximo[LUltimo[LChave]] := LValor
      Else
        FPrimeiro.Add(LChave, LValor);

      LUltimo.AddOrSetValue(LChave, LRecNo);

      FDataSet.Next;
    End;
  Finally
    FreeAndNil(LUltimo);
  End;

  If LRecNoOriginal > 0 Then
    FDataSet.RecNo := LRecNoOriginal;

  FAssinatura := RetornaAssinatura;
end;

function TIndiceBuscaCartao.Localizar(const AValores: array of String): Boolean;
  Var
    LChave,
    LValor,
    LAutoIncremento: String;
    LRecNo,
    LRecNoOriginal: Integer;
    LRecarregou: Boolean;
begin
  Result := False;

  If FDataSet.IsEmpty Then
    Exit;

  LRecarregou := False;
  If Not RetornaAssinatura.Equals(FAssinatura) Then
  Begin
    Carregar;
    LRecarregou := True;
  End;

  LChave := MontaChave(AValores);

  If Not FPrimeiro.TryGetValue(LChave, LValor) Then
    Exit;

  LRecNoOriginal := FDataSet.RecNo;

  While Not LValor.IsEmpty Do
  Begin
    SeparaValor(LValor, LRecNo, LAutoIncremento);

    FDataSet.RecNo := LRecNo;

    //RecNo caiu em outro registro: as posições mudaram sem mudar a assinatura
    If Not FCampoAutoIncremento.AsString.Equals(LAutoIncremento) Then
    Begin
      //Logo após carregar não pode acontecer; não arrisca devolver registro errado
      If LRecarregou Then
        Break;

      FDataSet.RecNo := LRecNoOriginal;
      Carregar;
      LRecarregou := True;

      If Not FPrimeiro.TryGetValue(LChave, LValor) Then
        Break;

      Continue;
    End;

    If MontaChaveRegistroAtual.Equals(LChave) Then
      Exit(True);

    LValor := FProximo[LRecNo];
  End;

  //Igual ao Locate: sem achar, o cursor volta para onde estava
  FDataSet.RecNo := LRecNoOriginal;
end;

end.
