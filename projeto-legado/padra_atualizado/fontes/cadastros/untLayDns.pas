unit untLayDns;

interface


Uses
  Classes,
  SysUtils,
  Controls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untFuncoesSimples,
  untZClient;

Type

  TLayDNS = Class(TZClient)
    Private
      FobjLayout: TStrings;
      FstrSeqLay: String;
      FstrCampo: String;
      FstrCampoXML: String;
      FstrFormato: String;
      FstrSchema: String;
      Function fSQL: String;
    Public
      constructor Create(Owner: TComponent); Reintroduce;
      function fSchema(strSchema: String): TLayDNS;
      function fExcluirTodos: TLayDNS;
      function fFormato(strFormato: String): TLayDNS; overload;
      function fCampoXML(strCampoXML: String): TLayDNS; overload;
      function fCampo(strCampo: String): TLayDNS; overload;
      function fConsultar: TLayDNS;
      function fConsultarSimilar: TLayDNS;
      function fOpen: TLayDNS;
      function fSalvar: TLayDNS;
      function fLayout: String; overload;
      function fLayoutXML: String; overload;
      function fLayout(objLayout: TStrings): TLayDNS; overload;
      function fSeqLay(strSeqLay: String): TLayDNS;
      function fInserir: TLayDNS;
      class function fNovo: TLayDNS;
      destructor Destroy; override;
  End;

implementation

{ TLayCFS }

function TLayDNS.fCampo(strCampo: String): TLayDNS;
begin
  Result := Self;
  FstrCampo := strCampo;
end;

function TLayDNS.fCampoXML(strCampoXML: String): TLayDNS;
begin
  Result := Self;
  FstrCampoXML := strCampoXML;
end;

function TLayDNS.fConsultar: TLayDNS;
begin
  Result := Self;
  Close;
  qryQuery.SQL.Text := 'SELECT SQL_NO_CACHE LAYDNS.*, LAYCFS.LAY_CODLAY, LAY_DESCFS,LAY_DESCAM, CONCAT(LAY_DESCAM," (", LAY_DESCFS, ")") LAY_DESCOM ' +
    ' FROM LAYDNS ' +
    ' JOIN LAYCFS ON LAYCFS.AUTOINCREM = LAYDNS.LAY_SEQCFS ' +
    ' WHERE ';
  If Not fEmptyStr(FstrSeqLay) Then
    qryQuery.SQL.Add('LAY_SEQLAY = ' + FstrSeqLay.QuotedString + ' AND ');
  qryQuery.SQL.Add(' LAY_DESXML = ' + FstrCampoXML.QuotedString);
  If fEmptyStr(FstrSeqLay) Then
    qryQuery.SQL.Add(' LIMIT 1');
  fAbreClient(True,'TLayDNS');
end;

function TLayDNS.fSchema(strSchema: String): TLayDNS;
begin
  Result := Self;
  FstrSchema := strSchema;
end;

function TLayDNS.fConsultarSimilar: TLayDNS;
Var
  LstrCampos: String;
  LstrSeqLay: String;
begin
  Result := Self;
  LstrSeqLay := FstrSeqLay;
  For LstrCampos In FstrSchema.Split([#13]) do
  Begin
    FstrSeqLay := '';
    FstrCampoXML := LstrCampos.Split(['|'])[0];
    fConsultar;
    If Not IsEmpty Then
    Begin
      FstrSeqLay := LstrSeqLay;
      FstrCampoXML := FieldByName('LAY_DESXML').AsString;
      FstrCampo := FieldByName('LAY_SEQCFS').AsString;
      FstrFormato := FieldByName('LAY_FORMAT').AsString;
      fConsultar;
      If IsEmpty Then
        fSalvar;
    End;
  End;
  FstrSeqLay := LstrSeqLay;
end;

function TLayDNS.fFormato(strFormato: String): TLayDNS;
begin
  Result := Self;
  FstrFormato := strFormato;
end;

function TLayDNS.fInserir: TLayDNS;
begin
  Result := Self;
  fOpen;
  If IsEmpty Then
  Begin
    fConsultarSimilar;
    fOpen;
  End;
end;

constructor TLayDNS.Create(Owner: TComponent);
begin
  Inherited Create(Owner, fSQL);
  FobjLayout := TStringList.Create;
end;

destructor TLayDNS.Destroy;
begin
  FreeAndNil(FobjLayout);
  inherited;
end;

function TLayDNS.fLayout(objLayout: TStrings): TLayDNS;
begin
  Result := Self;
  FobjLayout := objLayout;
end;

function TLayDNS.fLayoutXML: String;
Var
  LObjLayoutXML: TStrings;
begin
  LObjLayoutXML := TStringList.Create;
  Try
    First;
    while Not Eof do
    Begin
      LObjLayoutXML.Values[FieldByName('LAY_DESXML').AsString] := FieldByName('LAY_DESCAM').AsString;
      Next;
    End;
    Result := LobjLayoutXML.Text;
  Finally
    LObjLayoutXML.Free;
  End;
end;

function TLayDNS.fLayout: String;
Var
  LObjStrings: TStringList;
begin
  LObjStrings := TStringList.Create;
  Try
    First;
    while Not Eof do
    Begin
      LObjStrings.Values[FieldByName('LAY_DESCFS').AsString] := FieldByName('LAY_DESXML').AsString +
        '|' + FieldByName('LAY_FORMAT').AsString;
      Next;
    End;
    Result := LObjStrings.Text;
  Finally
    LObjStrings.Free;
  End;
end;

class function TLayDNS.fNovo: TLayDNS;
begin
  Result := TLayDNS.Create(Application);
end;

function TLayDNS.fOpen: TLayDNS;
begin
  Result := Self;
  Close;
  qryQuery.SQL.Text := 'SELECT SQL_NO_CACHE LAYDNS.*, LAYCFS.LAY_CODLAY, LAY_DESCFS, LAY_DESCAM, CONCAT(LAY_DESCAM," (", LAY_DESCFS, ")") LAY_DESCOM  ' +
    ' FROM LAYDNS ' +
    ' JOIN LAYCFS ON LAYCFS.AUTOINCREM = LAYDNS.LAY_SEQCFS ' +
    ' WHERE LAY_SEQLAY = ' +
    FstrSeqLay.QuotedString;
  fAbreClient(True, 'TLayDNS.fOpen');
end;

function TLayDNS.fExcluirTodos: TLayDNS;
Begin
  Result := Self;
  qryQuery.SQL.Text := 'DELETE FROM LAYDNS WHERE LAY_SEQLAY = ' + FstrSeqLay.QuotedString;
  qryQuery.Execute;
End;

function TLayDNS.fSalvar: TLayDNS;
begin
  Result := Self;
  If IsEmpty Then
    Append
  Else
    Edit;
  If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LAYDNS', VS_strCodEmp);;
  FieldByName('LAY_SEQLAY').AsString := FstrSeqLay;
  FieldByName('LAY_DESXML').AsString := FstrCampoXML;
  FieldByName('LAY_SEQCFS').AsString := FstrCampo;
  FieldByName('LAY_FORMAT').AsString := FstrFormato;
  fSalva;
end;

function TLayDNS.fSeqLay(strSeqLay: String): TLayDNS;
begin
  Result := Self;
  FstrSeqLay := strSeqLay;
end;

function TLayDNS.fSQL: String;
begin
  Result := Result + ' SELECT SQL_NO_CACHE ';
  Result := Result + '   *  ';
  Result := Result + ' FROM ';
  Result := Result + '   LAYDNS WHERE FALSE';
end;


end.

