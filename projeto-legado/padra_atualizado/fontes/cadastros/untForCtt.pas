unit untForCtt;

interface

uses SysUtils, Uni, Contnrs, UniClientDataSet;

{*******************************************}
{* CONTATOS DO FORNECEDOR                  *}
{****************************************MV*}
Type

    TForCtt = class(TObject)
      private
        FCodFor: String;
        FNomCtt: String;
        FEndCtt: String;
        FBaiCtt: String;
        FCidCtt: String;
        FNomCid: String;
        FEstado: String;
        FTelCtt: String;
        FCelCtt: String;
        FFaxCtt: String;
        FDepCtt: String;
        FEmaCtt: String;
        FCmpCtt: String;

        qryForCtt: TUniQuery;

        procedure pZeraValores;
        procedure pGeraErro(strMensagem: String);

      protected
        function getBaiCtt: String;
        function getCidCtt: String;
        function getCodFor: String;
        function getEmaCtt: String;
        function getEndCtt: String;
        function getNomCtt: String;
        function getTelCtt: String;
        function getCelCtt: String;
        function getFaxCtt: String;
        function getDepCtt: String;

        procedure setBaiCtt(const Value: String);
        procedure setCidCtt(const Value: String);
        procedure setCodFor(const Value: String);
        procedure setEmaCtt(const Value: String);
        procedure setEndCtt(const Value: String);
        procedure setNomCtt(const Value: String);
        procedure setTelCtt(const Value: String);
        procedure setCelCtt(const Value: String);
        procedure setFaxCtt(const Value: String);
        procedure setDepCtt(const Value: String);

      public

        Constructor Create; reintroduce; overload;
        Constructor Create(Const strCodFor, strAutInc: String); overload;
        Destructor Destroy; override;

        procedure pAjustaCmpCtt(cdsForCtt: TUniClientDataSet);
        procedure pInsereForCtt;
        class procedure pApagarCadCtt(const strCodFor: String);
        class function fRetContatos(const strCodFor: String): TObjectList;

        property strCodFor: String Read getCodFor Write setCodFor;
        property strNomCtt: String Read getNomCtt Write setNomCtt;
        property strEndCtt: String Read getEndCtt Write setEndCtt;
        property strBaiCtt: String Read getBaiCtt Write setBaiCtt;
        property strCidCtt: String Read getCidCtt Write setCidCtt;
        property strNomCid: String Read FNomCid;
        property strEstado: String Read FEstado;
        property strTelCtt: String Read getTelCtt Write setTelCtt;
        property strCelCtt: String Read getCelCtt Write setCelCtt;
        property strFaxCtt: String Read getFaxCtt Write setFaxCtt;
        property strDepCtt: String Read getDepCtt Write setDepCtt;
        property strEmaCtt: String Read getEmaCtt Write setEmaCtt;
        property strCmpCtt: String Read FCmpCtt   Write FCmpCtt;

  End;

implementation

uses untfuncoesSimples, untConstantes, Data.DB, System.Classes,
  untTypesSistema;

{ TForCtt }

constructor TForCtt.Create;
begin
  qryForCtt := fCriaQuery(Nil);
  pZeraValores;
end;

constructor TForCtt.Create(const strCodFor, strAutInc: String);
  Var
    qryAux: TUniQuery;
begin
  qryForCtt := fCriaQuery(Nil);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                                   ');
  qryAux.SQL.Add('  *                                      ');
  qryAux.SQL.Add('FROM                                     ');
  qryAux.SQL.Add('  FORCTT                                 ');
  qryAux.SQL.Add('  JOIN CADCID ON CID_CODCID = FOR_CIDCTT ');
  qryAux.SQL.Add('WHERE                                    ');
  qryAux.SQL.Add('  FOR_CODFOR = :CODFOR AND               ');
  qryAux.SQL.Add('  FORCTT.AUTOINCREM = :AUTINC            ');

  qryAux.ParamByName('CODFOR').AsString := strCodFor;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    pZeraValores;
  End
  Else
  Begin
    FCodFor := qryAux.FieldByName('FOR_CODFOR').AsString;
    FNomCtt := qryAux.FieldByName('FOR_NOMCTT').AsString;
    FEndCtt := qryAux.FieldByName('FOR_ENDCTT').AsString;
    FBaiCtt := qryAux.FieldByName('FOR_BAICTT').AsString;
    FCidCtt := qryAux.FieldByName('FOR_CIDCTT').AsString;
    FNomCid := qryAux.FieldByName('CID_NOMCID').AsString;
    FEstado := qryAux.FieldByName('CID_ESTADO').AsString;
    FTelCtt := qryAux.FieldByName('FOR_TELCTT').AsString;
    FCelCtt := qryAux.FieldByName('FOR_CELCTT').AsString;
    FFaxCtt := qryAux.FieldByName('FOR_FAXCTT').AsString;
    FDepCtt := qryAux.FieldByName('FOR_DEPCTT').AsString;
    FEmaCtt := qryAux.FieldByName('FOR_EMACTT').AsString;
    FCmpCtt := qryAux.FieldByName('FOR_CMPCTT').AsString;
  End;

  FreeAndNil(qryAux);
end;

destructor TForCtt.Destroy;
begin
  qryForCtt.Close;
  FreeAndNil(qryForCtt);
  inherited;
end;

class function TForCtt.fRetContatos(const strCodFor: String): TObjectList;
  Var
    qryAux: TUniQuery;
begin

  Result := TObjectList.Create(True);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT AUTOINCREM FROM FORCTT WHERE FOR_CODFOR = :CODFOR');
  qryAux.ParamByName('CODFOR').AsString := strCodFor;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TForCtt.Create(strCodFor, qryAux.FieldByName('AUTOINCREM').AsString));
    qryAux.Next;
  End;
  qryAux.Close;

  FreeAndNil(qryAux);

end;

function TForCtt.getBaiCtt: String;
begin
  Result := FBaiCtt;
end;

function TForCtt.getCidCtt: String;
begin
  Result := FCidCtt;
end;

function TForCtt.getCodFor: String;
begin
  Result := FCodFor;
end;

function TForCtt.getTelCtt: String;
begin
  Result := FTelCtt;
end;

function TForCtt.getCelCtt: String;
begin
  Result := FCelCtt;
end;

function TForCtt.getFaxCtt: String;
begin
  Result := FFaxCtt;
end;

function TForCtt.getDepCtt: String;
begin
  Result := FDepCtt;
end;

function TForCtt.getEmaCtt: String;
begin
  Result := FEmaCtt;
end;

function TForCtt.getEndCtt: String;
begin
  Result := FEndCtt;
end;


function TForCtt.getNomCtt: String;
begin
  Result := FNomCtt;
end;

class procedure TForCtt.pApagarCadCtt(const strCodFor: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM FORCTT WHERE FOR_CODFOR = :CODFOR');
  qryAux.ParamByName('CODFOR').AsString := strCodFor;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TForCtt.pGeraErro(strMensagem: String);
begin
  Raise ExceptionAutCom.Create(strMensagem);
end;

procedure TForCtt.pInsereForCtt;
begin
  setCodFor(FCodFor);
  setNomCtt(FNomCtt);
  setEndCtt(FEndCtt);
  setBaiCtt(FBaiCtt);
  setCidCtt(FCidCtt);
  setTelCtt(FTelCtt);
  setCelCtt(FCelCtt);
  setFaxCtt(FFaxCtt);
  setDepCtt(FDepCtt);
  setEmaCtt(FEmaCtt);

  qryForCtt.Close;
  qryForCtt.SQL.Clear;
  qryForCtt.SQL.Add('INSERT INTO FORCTT  ');
  qryForCtt.SQL.Add('(                   ');
  qryForCtt.SQL.Add('  FOR_CODFOR,       ');
  qryForCtt.SQL.Add('  FOR_NOMCTT,       ');
  qryForCtt.SQL.Add('  FOR_ENDCTT,       ');
  qryForCtt.SQL.Add('  FOR_BAICTT,       ');
  qryForCtt.SQL.Add('  FOR_CIDCTT,       ');
  qryForCtt.SQL.Add('  FOR_TELCTT,       ');
  qryForCtt.SQL.Add('  FOR_CELCTT,       ');
  qryForCtt.SQL.Add('  FOR_FAXCTT,       ');
  qryForCtt.SQL.Add('  FOR_DEPCTT,       ');
  qryForCtt.SQL.Add('  FOR_CMPCTT,       ');
  qryForCtt.SQL.Add('  FOR_EMACTT,       ');
  qryForCtt.SQL.Add('  FOR_CODEMP,       ');
  qryForCtt.SQL.Add('  AUTOINCREM        ');
  qryForCtt.SQL.Add(') VALUES (          ');
  qryForCtt.SQL.Add('  :CODFOR,          ');
  qryForCtt.SQL.Add('  :NOMCTT,          ');
  qryForCtt.SQL.Add('  :ENDCTT,          ');
  qryForCtt.SQL.Add('  :BAICTT,          ');
  qryForCtt.SQL.Add('  :CIDCTT,          ');
  qryForCtt.SQL.Add('  :TELCTT,          ');
  qryForCtt.SQL.Add('  :CELCTT,          ');
  qryForCtt.SQL.Add('  :FAXCTT,          ');
  qryForCtt.SQL.Add('  :DEPCTT,          ');
  qryForCtt.SQL.Add('  :CMPCTT,          ');
  qryForCtt.SQL.Add('  :EMACTT,          ');
  qryForCtt.SQL.Add('  :CODEMP,          ');
  qryForCtt.SQL.Add('  :AUTINC)          ');

  qryForCtt.ParamByName('CODFOR').AsString := FCodFor;
  qryForCtt.ParamByName('NOMCTT').AsString := FNomCtt;
  qryForCtt.ParamByName('ENDCTT').AsString := FEndCtt;
  qryForCtt.ParamByName('BAICTT').AsString := FBaiCtt;
  qryForCtt.ParamByName('CIDCTT').AsString := FCidCtt;
  qryForCtt.ParamByName('TELCTT').AsString := FTelCtt;
  qryForCtt.ParamByName('CELCTT').AsString := FCelCtt;
  qryForCtt.ParamByName('FAXCTT').AsString := FFaxCtt;
  qryForCtt.ParamByName('DEPCTT').AsString := FDepCtt;
  qryForCtt.ParamByName('CMPCTT').AsString := FCmpCtt;
  qryForCtt.ParamByName('EMACTT').AsString := FEmaCtt;
  qryForCtt.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryForCtt.ParamByName('AUTINC').AsString := fRetAutoIncrem('FORCTT', VS_strCodEmp);
  qryForCtt.ExecSQL;
  qryForCtt.Close;

end;

procedure TForCtt.pZeraValores;
begin
  FCodFor := '';
  FNomCtt := '';
  FEndCtt := '';
  FBaiCtt := '';
  FCidCtt := '';
  FNomCid := '';
  FEstado := '';
  FTelCtt := '';
  FCelCtt := '';
  FFaxCtt := '';
  FDepCtt := '';
  FEmaCtt := '';
  FCmpCtt := 'N';
end;

procedure TForCtt.setBaiCtt(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    pGeraErro('O Bairro deve ser preenchido!');

  If (FBaiCtt <> Value) Then
    FBaiCtt := Value;

end;

procedure TForCtt.setTelCtt(const Value: String);
begin
  If (FTelCtt <> Value) Then
    FTelCtt := Value;
end;

procedure TForCtt.setCelCtt(const Value: String);
begin
  If (FCelCtt <> Value) Then
    FCelCtt := Value;
end;

procedure TForCtt.setFaxCtt(const Value: String);
begin
  If (FFaxCtt <> Value) Then
    FFaxCtt := Value;
end;

procedure TForCtt.setDepCtt(const Value: String);
begin
  If (FDepCtt <> Value) Then
    FDepCtt := Value;
end;

procedure TForCtt.setCidCtt(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    pGeraErro('A cidade deve ser preenchida!');

  FNomCid := fRetNomCidade(Value);
  If (fEmptyStr(FNomCid)) Then
    pGeraErro('Essa cidade não está cadastrada!');

  FEstado := fRetNomCidade(Value, 1);

  If (FCidCtt <> Value) Then
    FCidCtt := Value;

end;

procedure TForCtt.setCodFor(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pGeraErro('O Fornecedor deve ser preenchido!');

  If (FCodFor <> Value) Then
    FCodFor := Value;
end;


procedure TForCtt.setEmaCtt(const Value: String);
begin
  If (FEmaCtt <> Value) Then
    FEmaCtt := Value;
end;

procedure TForCtt.setEndCtt(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pGeraErro('O Endereço do contato deve ser preenchido!');

  If (FEndCtt <> Value) Then
    FEndCtt := Value;
end;


procedure TForCtt.setNomCtt(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    pGeraErro('O Nome do contato deve ser preenchido!');

  If (FNomCtt <> Value) Then
    FNomCtt := Value;
end;

procedure TForCtt.pAjustaCmpCtt(cdsForCtt: TUniClientDataSet);
  Var
    intRecNo: Integer;
Begin
  With cdsForCtt Do
  If FieldByName('CMPCTT').AsString = 'S' Then
  Begin
    DisableControls;
    intRecNo := RecNo;

    Edit;
    FieldByName('CMPCTT').AsString := 'N';
    Post;

    If Locate('CMPCTT', 'S', []) Then
    Begin
      Edit;
      FieldByName('CMPCTT').AsString := 'N';
      Post;
    End;
    RecNo := intRecNo;

    Edit;
    FieldByName('CMPCTT').AsString := 'S';
    Post;

    EnableControls;
  End;
End;

end.

