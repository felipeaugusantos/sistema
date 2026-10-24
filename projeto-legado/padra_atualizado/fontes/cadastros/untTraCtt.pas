unit untTraCtt;

interface

uses SysUtils, Uni, Contnrs;

{*******************************************}
{* CONTATOS DO FORNECEDOR                  *}
{****************************************MV*}
Type

    TTraCtt = class(TObject)
      private
        FCodTra: String;
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

        qryTraCtt: TUniQuery;

        procedure pZeraValores;

      protected
        function getBaiCtt: String;
        function getCidCtt: String;
        function getCodTra: String;
        function getEmaCtt: String;
        function getEndCtt: String;
        function getNomCtt: String;
        function getTelCtt: String;
        function getCelCtt: String;
        function getFaxCtt: String;
        function getDepCtt: String;

        procedure setBaiCtt(const Value: String);
        procedure setCidCtt(const Value: String);
        procedure setCodTra(const Value: String);
        procedure setEmaCtt(const Value: String);
        procedure setEndCtt(const Value: String);
        procedure setNomCtt(const Value: String);
        procedure setTelCtt(const Value: String);
        procedure setCelCtt(const Value: String);
        procedure setDepCtt(const Value: String);
        procedure setFaxCtt(const Value: String);

      public

        Constructor Create; reintroduce; overload;
        Constructor Create(Const strCodTra, strAutInc: String); overload;
        Destructor Destroy; override;

        procedure pInsereTraCtt;
        class procedure pApagarCadCtt(const strCodTra: String);
        class function fRetContatos(const strCodTra: String): TObjectList;

        property strCodTra: String Read getCodTra Write setCodTra;
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

  End;

implementation

uses untfuncoesSimples, untConstantes, Data.DB, System.Classes,
  untTypesSistema;

{ TTraCtt }

constructor TTraCtt.Create;
begin
  qryTraCtt := fCriaQuery(Nil);
  pZeraValores;
end;

constructor TTraCtt.Create(const strCodTra, strAutInc: String);
  Var
    qryAux: TUniQuery;
begin
  qryTraCtt := fCriaQuery(Nil);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                                   ');
  qryAux.SQL.Add('  *                                      ');
  qryAux.SQL.Add('FROM                                     ');
  qryAux.SQL.Add('  TRACTT                                 ');
  qryAux.SQL.Add('  JOIN CADCID ON CID_CODCID = TRA_CIDCTT ');
  qryAux.SQL.Add('WHERE                                    ');
  qryAux.SQL.Add('  TRA_CODTRA = :CODTRA AND               ');
  qryAux.SQL.Add('  TRACTT.AUTOINCREM = :AUTINC            ');

  qryAux.ParamByName('CODTra').AsString := strCodTra;
  qryAux.ParamByName('AUTINC').AsString := strAutInc;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    pZeraValores;
  End
  Else
  Begin
    FCodTra := qryAux.FieldByName('TRA_CODTra').AsString;
    FNomCtt := qryAux.FieldByName('TRA_NOMCTT').AsString;
    FEndCtt := qryAux.FieldByName('TRA_ENDCTT').AsString;
    FBaiCtt := qryAux.FieldByName('TRA_BAICTT').AsString;
    FCidCtt := qryAux.FieldByName('TRA_CIDCTT').AsString;
    FNomCid := qryAux.FieldByName('CID_NOMCID').AsString;
    FEstado := qryAux.FieldByName('CID_ESTADO').AsString;
    FTelCtt := qryAux.FieldByName('TRA_TELCTT').AsString;
    FCelCtt := qryAux.FieldByName('TRA_CELCTT').AsString;
    FFaxCtt := qryAux.FieldByName('TRA_FAXCTT').AsString;
    FDepCtt := qryAux.FieldByName('TRA_DEPCTT').AsString;
    FEmaCtt := qryAux.FieldByName('TRA_EMACTT').AsString;
  End;

  FreeAndNil(qryAux);
end;

destructor TTraCtt.Destroy;
begin
  //qryTraCtt.Close;
  FreeAndNil(qryTraCtt);
  inherited;
end;

class function TTraCtt.fRetContatos(const strCodTra: String): TObjectList;
  Var
    qryAux: TUniQuery;
begin

  Result := TObjectList.Create(True);

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT AUTOINCREM FROM TRACTT WHERE TRA_CODTRA = :CODTRA');
  qryAux.ParamByName('CODTRA').AsString := strCodTra;
  qryAux.Open;
  While (Not qryAux.Eof) Do
  Begin
    Result.Add(TTraCtt.Create(strCodTra, qryAux.FieldByName('AUTOINCREM').AsString));
    qryAux.Next;
  End;
  qryAux.Close;

  FreeAndNil(qryAux);

end;

function TTraCtt.getBaiCtt: String;
begin
  Result := FBaiCtt;
end;

function TTraCtt.getCelCtt: String;
begin
  Result := FCelCtt;
end;

function TTraCtt.getCidCtt: String;
begin
  Result := FCidCtt;
end;

function TTraCtt.getCodTra: String;
begin
  Result := FCodTra;
end;

function TTraCtt.getDepCtt: String;
begin
  Result := FDepCtt;
end;

function TTraCtt.getEmaCtt: String;
begin
  Result := FEmaCtt;
end;

function TTraCtt.getEndCtt: String;
begin
  Result := FEndCtt;
end;

function TTraCtt.getFaxCtt: String;
begin
  Result := FFaxCtt;
end;

function TTraCtt.getNomCtt: String;
begin
  Result := FNomCtt;
end;

function TTraCtt.getTelCtt: String;
begin
  Result := FTelCtt;
end;

class procedure TTraCtt.pApagarCadCtt(const strCodTra: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM TRACTT WHERE TRA_CODTRA = :CODTRA');
  qryAux.ParamByName('CODTra').AsString := strCodTra;
  qryAux.ExecSQL;
  qryAux.Close;

  FreeAndNil(qryAux);
end;

procedure TTraCtt.pInsereTraCtt;
begin
  setCodTra(FCodTra);
  setNomCtt(FNomCtt);
  setEndCtt(FEndCtt);
  setBaiCtt(FBaiCtt);
  setCidCtt(FCidCtt);
  setTelCtt(FTelCtt);
  setCelCtt(FCelCtt);
  setFaxCtt(FFaxCtt);
  setDepCtt(FDepCtt);
  setEmaCtt(FEmaCtt);

  qryTraCtt.Close;
  qryTraCtt.SQL.Clear;
  qryTraCtt.SQL.Add('INSERT INTO TRACTT  ');
  qryTraCtt.SQL.Add('(                   ');
  qryTraCtt.SQL.Add('  TRA_CODTRA,       ');
  qryTraCtt.SQL.Add('  TRA_NOMCTT,       ');
  qryTraCtt.SQL.Add('  TRA_ENDCTT,       ');
  qryTraCtt.SQL.Add('  TRA_BAICTT,       ');
  qryTraCtt.SQL.Add('  TRA_CIDCTT,       ');
  qryTraCtt.SQL.Add('  TRA_TELCTT,       ');
  qryTraCtt.SQL.Add('  TRA_CELCTT,       ');
  qryTraCtt.SQL.Add('  TRA_FAXCTT,       ');
  qryTraCtt.SQL.Add('  TRA_DEPCTT,       ');
  qryTraCtt.SQL.Add('  TRA_EMACTT,       ');
  qryTraCtt.SQL.Add('  TRA_CODEMP,       ');
  qryTraCtt.SQL.Add('  AUTOINCREM        ');
  qryTraCtt.SQL.Add(') VALUES (          ');
  qryTraCtt.SQL.Add('  :CODTra,          ');
  qryTraCtt.SQL.Add('  :NOMCTT,          ');
  qryTraCtt.SQL.Add('  :ENDCTT,          ');
  qryTraCtt.SQL.Add('  :BAICTT,          ');
  qryTraCtt.SQL.Add('  :CIDCTT,          ');
  qryTraCtt.SQL.Add('  :TELCTT,          ');
  qryTraCtt.SQL.Add('  :CELCTT,          ');
  qryTraCtt.SQL.Add('  :FAXCTT,          ');
  qryTraCtt.SQL.Add('  :DEPCTT,          ');
  qryTraCtt.SQL.Add('  :EMACTT,          ');
  qryTraCtt.SQL.Add('  :CODEMP,          ');
  qryTraCtt.SQL.Add('  :AUTINC)          ');

  qryTraCtt.ParamByName('CODTRA').AsString := FCodTra;
  qryTraCtt.ParamByName('NOMCTT').AsString := FNomCtt;
  qryTraCtt.ParamByName('ENDCTT').AsString := FEndCtt;
  qryTraCtt.ParamByName('BAICTT').AsString := FBaiCtt;
  qryTraCtt.ParamByName('CIDCTT').AsString := FCidCtt;
  qryTraCtt.ParamByName('TELCTT').AsString := FTelCtt;
  qryTraCtt.ParamByName('CELCTT').AsString := FCelCtt;
  qryTraCtt.ParamByName('FAXCTT').AsString := FFaxCtt;
  qryTraCtt.ParamByName('DEPCTT').AsString := FDepCtt;
  qryTraCtt.ParamByName('EMACTT').AsString := FEmaCtt;
  qryTraCtt.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTraCtt.ParamByName('AUTINC').AsString := fRetAutoIncrem('TRACTT', VS_strCodEmp);
  qryTraCtt.ExecSQL;
  qryTraCtt.Close;

end;

procedure TTraCtt.pZeraValores;
begin
  FCodTra := '';
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
end;

procedure TTraCtt.setBaiCtt(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Bairro deve ser preenchido!');

  If (FBaiCtt <> Value) Then
    FBaiCtt := Value;

end;

procedure TTraCtt.setCelCtt(const Value: String);
begin
  If (FCelCtt <> Value) Then
    FCelCtt := Value;
end;

procedure TTraCtt.setCidCtt(const Value: String);
begin

  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('A cidade deve ser preenchida!');

  FNomCid := fRetNomCidade(Value);
  If (fEmptyStr(FNomCid)) Then
    Raise ExceptionAutCom.Create('Essa cidade não está cadastrada!');

  FEstado := fRetNomCidade(Value, 1);

  If (FCidCtt <> Value) Then
    FCidCtt := Value;

end;

procedure TTraCtt.setCodTra(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Tranecedor deve ser preenchido!');

  If (FCodTra <> Value) Then
    FCodTra := Value;
end;

procedure TTraCtt.setDepCtt(const Value: String);
begin
  If (FDepCtt <> Value) Then
    FDepCtt := Value;
end;

procedure TTraCtt.setEmaCtt(const Value: String);
begin
  If (FEmaCtt <> Value) Then
    FEmaCtt := Value;
end;

procedure TTraCtt.setEndCtt(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Endereço deve ser preenchido!');

  If (FEndCtt <> Value) Then
    FEndCtt := Value;
end;

procedure TTraCtt.setFaxCtt(const Value: String);
begin
  If (FFaxCtt <> Value) Then
    FFaxCtt := Value;

end;

procedure TTraCtt.setNomCtt(const Value: String);
begin
  If (fEmptyStr(Value)) Then
    Raise ExceptionAutCom.Create('O Nome deve ser preenchido!');

  If (FNomCtt <> Value) Then
    FNomCtt := Value;
end;

procedure TTraCtt.setTelCtt(const Value: String);
begin
  If (FTelCtt <> Value) Then
    FTelCtt := Value;
end;

end.

