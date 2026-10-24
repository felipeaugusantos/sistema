unit untCacheTablesRomaneio;

interface

uses System.Generics.Collections, untZClient;

type
  TDocument = record
    Autoincrem : String;
    TableName : String;
  End;

  TCacheTablesRomaneio = class
  private
    FDocuments : TList<TDocument>;
    FMovGer : TZClient;
    FNotGer : TZClient;
    FFatGor : TZClient;
    procedure AddInAutoincrem(const ADocument : TDocument; var ASQLIn : String);
    procedure OpenCacheTable(const ATableName : String; const ASQLIn : String; const AClient : TZClient);
    function SQLDocBaiEntFut(const AVazio : Boolean; const ATableName : String) : String;
    procedure SetIndexFieldsNames(const ATableName : String; const AClient : TZClient);
    procedure CloseClients;
  public
    procedure AddDocument(const AAutoincrem : String; const ATableName : String);
    procedure ClearDocuments;
    procedure LoadCache;
    constructor Create;
    destructor Destroy; override;
    function FindDocument(const ANumDoc, AEspDoc, ACodEmp, ATableName : String; out AClient : TZClient) : Boolean;
    property MovGer : TZClient read FMovGer;
    property NotGer : TZClient read FNotGer;
    property FatGor : TZClient read FFatGor;
  End;

implementation

uses System.SysUtils, untFuncoesSimples;

{ TCacheTablesRomaneio }

procedure TCacheTablesRomaneio.AddDocument(const AAutoincrem, ATableName: String);
  Var
    LDocument : TDocument;
begin
  FillChar(LDocument, SizeOf(LDocument), #0);
  LDocument.Autoincrem := AAutoincrem;
  LDocument.TableName := ATableName;
  FDocuments.Add(LDocument);
end;

procedure TCacheTablesRomaneio.ClearDocuments;
begin
  FDocuments.Clear;
  CloseClients;
end;

procedure TCacheTablesRomaneio.CloseClients;
begin
  OpenCacheTable('MOVGER', '', FMovGer);
  OpenCacheTable('NOTGER', '', FNotGer);
  OpenCacheTable('FATGOR', '', FFatGor);
end;

constructor TCacheTablesRomaneio.Create;
begin
  FDocuments := TList<TDocument>.Create;
  FMovGer := TZClient.Create(nil);
  FNotGer := TZClient.Create(nil);
  FFatGor := TZClient.Create(nil);
  CloseClients;
end;

destructor TCacheTablesRomaneio.Destroy;
begin
  FreeAndNil(FDocuments);
  FreeAndNil(FMovGer);
  FreeAndNil(FNotGer);
  FreeAndNil(FFatGor);
  inherited;
end;

function TCacheTablesRomaneio.FindDocument(const ANumDoc, AEspDoc, ACodEmp, ATableName : String; out AClient : TZClient) : Boolean;
begin
  AClient := Nil;
  If (ATableName = 'MOVGER') Then
    AClient := FMovGer
  Else If (ATableName = 'NOTGER') Then
    AClient := FNotGer
  Else If (ATableName = 'FATGOR') Then
    AClient := FFatGor;
  Result := (Assigned(AClient)) And (AClient.Active) And (Not AClient.IsEmpty) And (AClient.FindKey([ANumDoc, AEspDoc, ACodEmp]));
end;

procedure TCacheTablesRomaneio.LoadCache;
  Var
    LDocument : TDocument;
    LInMovGer : String;
    LInNotGer : String;
    LInFatGor : String;
begin
  LInMovGer := '';
  LInNotGer := '';
  LInFatGor := '';

  For LDocument In FDocuments Do
  Begin
    If (LDocument.TableName = 'MOVGER') Then
      AddInAutoincrem(LDocument, LInMovGer)
    Else If (LDocument.TableName = 'NOTGER') Then
      AddInAutoincrem(LDocument, LInNotGer)
    Else If (LDocument.TableName = 'FATGOR') Then
      AddInAutoincrem(LDocument, LInFatGor);
  End;

  OpenCacheTable('MOVGER', LInMovGer, FMovGer);
  OpenCacheTable('NOTGER', LInNotGer, FNotGer);
  OpenCacheTable('FATGOR', LInFatGor, FFatGor);
  SetIndexFieldsNames('MOVGER', FMovGer);
  SetIndexFieldsNames('NOTGER', FNotGer);
  SetIndexFieldsNames('FATGOR', FFatGor);
end;

procedure TCacheTablesRomaneio.OpenCacheTable(const ATableName : String; const ASQLIn : String; const AClient : TZClient);
begin
  AClient.Close;
  If (ASQLIn.IsEmpty) Then
  Begin
    AClient.qryQuery.SQL.Text := ' SELECT ' + SQLDocBaiEntFut(True, ATableName) + ' AS DOCBAIENTFUT, ' +
                                            ATableName + '.*' +
                                 '  FROM ' + ATableName +
                                 ' WHERE FALSE';
  End
  Else
  Begin
    AClient.qryQuery.SQL.Text := ' SELECT ' + SQLDocBaiEntFut(False, ATableName) + ' AS DOCBAIENTFUT, ' +
                                             ATableName + '.*' +
                                '   FROM ' + ATableName +
                                '  WHERE AUTOINCREM IN (' + ASQLIn + ')';
  End;
  AClient.fAbreClient(True);
end;

procedure TCacheTablesRomaneio.AddInAutoincrem(const ADocument : TDocument; var ASQLIn : String);
begin
  If ASQLIn.IsEmpty Then
    ASQLIn := QuotedStr(ADocument.Autoincrem)
  Else
    ASQLIn := ASQLIn + ', ' + QuotedStr(ADocument.Autoincrem);
end;

procedure TCacheTablesRomaneio.SetIndexFieldsNames(const ATableName: String; const AClient : TZClient);
begin
  If (ATableName = 'FATGOR') Then
    AClient.pSetIndexFieldNames('FGO_NUMDOC;FGO_ESPDOC;FGO_CODEMP')
  Else If (ATableName = 'MOVGER') Or (ATableName = 'NOTGER') Then
    AClient.pSetIndexFieldNames('GER_NUMDOC;GER_ESPDOC;GER_CODEMP');
end;

function TCacheTablesRomaneio.SQLDocBaiEntFut(const AVazio : Boolean; const ATableName : String) : String;
begin
  If AVazio Then
    Result := '0'
  Else
  Begin
    If (ATableName = 'MOVGER') Then
      Result := '(SELECT COUNT(*) FROM MOVDET WHERE DET_SEQGER = MOVGER.AUTOINCREM AND IFNULL(DET_DOCFUT, "") <> "")'
    Else If (ATableName = 'NOTGER') Then
      Result := '(SELECT COUNT(*) FROM NOTDET WHERE DET_SEQGER = NOTGER.AUTOINCREM AND IFNULL(DET_DOCFUT, "") <> "")'
    Else
      Result := '0';
  End;
end;

end.
