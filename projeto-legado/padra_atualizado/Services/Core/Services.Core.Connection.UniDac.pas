unit Services.Core.Connection.UniDac;

interface

uses
  Services.Core.Connection.Interfaces, System.SysUtils, Data.DB, CRParser,
  CLRClasses, System.StrUtils, System.Classes, System.Rtti, Uni,
  MySQLUniProvider, DBAccess, CRAccess, DASQLMonitor, UniSQLMonitor,
  DBMonitorClient, MyCallUni, MyClassesUni, MyParserUni,
  DAScript, UniScript, Services.Core.Utils, Services.Core.Settings,
  System.RegularExpressions, System.Generics.Collections,
  Services.Core.Connection.Manager;

type
  TUniDacField = Class(TInterfacedObject, IField)
  strict private
    FField: TField;
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
    function GetAsFloat: Double;
    procedure SetAsFloat(const AValue: Double);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const AValue: Integer);
    function GetAsLargeInt: Int64;
    procedure SetAsLargeInt(const AValue: Int64);
    function GetAsDate: TDate;
    procedure SetAsDate(const AValue: TDate);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const AValue: TDateTime);
    function GetAsValue: Variant;
    procedure SetAsValue(const AValue: Variant);
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(const Value: Boolean);
  public
    function DataType: TFieldType;
    function FieldKind: TFieldKind;
    function FieldName: String;
    function IsNull: Boolean;
    function Required: Boolean;
    procedure Clear;
    property AsString: String read GetAsString write SetAsString;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsLargeInt: Int64 read GetAsLargeInt write SetAsLargeInt;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property Value: Variant read GetAsValue write SetAsValue;
    constructor Create(const AField: TField);
  end;

type
  TUniDacParam = Class(TInterfacedObject, IParam)
  strict private
    FQuery: TUniQuery;
    FParam: String;
    function GetAsBoolean: Boolean;
    procedure SetAsBoolean(const AValue: Boolean);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const AValue: Integer);
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
    function GetAsDate: TDate;
    procedure SetAsDate(const AValue: TDate);
    function GetAsTime: TTime;
    procedure SetAsTime(const AValue: TTime);
    function GetAsFloat: Double;
    procedure SetAsFloat(const AValue: Double);
    function GetAsDateTime: TDateTime;
    procedure SetAsDateTime(const AValue: TDateTime);
    function getValue: Variant;
    procedure setValue(const AValue: Variant);
  public
    function Name: String;
    procedure Clear;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsString: String read GetAsString write SetAsString;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property AsTime: TTime read GetAsTime write SetAsTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property Value: Variant read getValue write setValue;
    constructor Create(const AParam: String; const AQuery: TUniQuery);
  End;

  TUniDacScript = class sealed(TInterfacedObject, IScript)
  private
    FScript: TUniScript;
  public
    constructor Create(AConexao: TUniConnection);
    destructor Destroy; override;
    function SQL(): TStrings;
    procedure Execute;
  end;

  TUniDacQuery = class sealed(TInterfacedObject, IQuery)
  private
    FQuery: TUniQuery;
  public
    constructor Create(AConexao: TUniConnection);
    destructor Destroy; override;
    function Active: Boolean;
    function GetRecNo: Integer;
    procedure SetRecNo(AValue: Integer);
    procedure Refresh;
    procedure Append;
    procedure Edit;
    procedure Post;
    procedure Cancel;
    procedure Delete;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    function RecordCount: Integer;
    function Eof(): Boolean;
    function SQL(): TStrings;
    procedure Open;
    procedure Close;
    function IsEmpty(): Boolean;
    procedure ExecSQL;
    function Params(AIndex: Integer): IParam;
    function ParamCount(): Integer;
    function ParamByName(AName: String): IParam;
    function FindParam(AName: String): IParam;
    function FieldByName(AName: String): IField;
    function FindField(AName: String): IField;
    function Fields(AIndex: Integer): IField;
    function FieldCount: Integer;
    function Locate(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean;
    function GetObject: TObject;
    property RecNo: Integer read GetRecNo write SetRecNo;
  end;

  TUniDacConnection = class sealed(TInterfacedObject, IConnection)
  private
    FConnection: TUniConnection;
  public
    constructor Create(ATag: NativeUInt);
    destructor Destroy; override;
    function GetObject: TObject;
    function GetTag: NativeUInt;
    function CreateQuery(ASQL: String = ''): IQuery;
    function CreateQueryObject(AOwner: TComponent): TObject;
    function CreateScript(): IScript;
    function SetServer(AValue: String): IConnection;
    function SetDatabase(AValue: String): IConnection;
    function SetUser(AValue: String): IConnection;
    function SetPassword(AValue: String): IConnection;
    function SetPort(AValue: Integer): IConnection;
    procedure Connect();
    function Connected(): Boolean;
    procedure Disconnect();
    procedure StartTransaction();
    procedure Commit();
    procedure Rollback();
    function ConnectionID(): String;
    function Database(): String;
    function InTransaction(): Boolean;
  end;

  TUniDacMonitor = class sealed
  private
    class var FMonitor: TUniSQLMonitor;
    class procedure SqlMonitorSQL(Sender: TObject; Text: string;
      Flag: TDATraceFlag);
  public
    class procedure Start;
    class procedure Finish;
  end;

function ParseSQL(const SQL: String): String;

function ParseSQLCitel(conConexao: IConnection; const SQL: string; Params: TObject): string;

procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass;
  Component: TComponent; SQL: string; Params: TDAParams; Caption: string);

implementation

Var
  VS_LastSQL: String;

procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass;
  Component: TComponent; SQL: string; Params: TDAParams; Caption: string);
Var
  strString: String;
  strTabela: String;
  blnGerar: Boolean;
  conConexao: IConnection;

  { ************************************************************** }
  { *Regex para substituição das funções de data do mysql********* }
  { *Para evitar divegência entre as datas em cada banco de dados* }
  { ***********************************************************LO* }
  {
    (                         : início
    current_date(\([ ]*\))? : current_date com ou sem (), sendo que os parenteses podem ou não conter espaços entre eles
    |                        : condição ou
    curdate\([ ]*\)         : curdate(), sendo que os parenteses podem ou não conter espaços entre eles
    |                        : condição ou
    utc_date(\([ ]*\))?     : utc_date com ou sem (), sendo que os parenteses podem ou não conter espaços entre eles
    )                         : fim
    manual utilizado: https://pt.slideshare.net/jmarioguedes/delphi-conference-2011-palestra-sobre-expresses-regulares
  }

  function fCurrentDate(Const Value: TDateTime): String;
  begin
    Result := 'CAST("' + FormatDateTime('yyyy-mm-dd', Value) + '" AS DATE)';
  end;

  function fCurrentTime: String;
  begin
    Result := 'CAST("' + FormatDateTime('hh:mm:ss', Time) + '" AS TIME)';
  end;

  function fCurrentDateTime(Const Value: TDateTime): String;
  begin
    Result := 'CAST("' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Value) +
      '" AS DATETIME)';
  end;

  function fSubstituiData(strTexto: String): String;
  begin
    Result := strTexto;

    If (Pos('CURRENT_DATE', Result) > 0) Or (Pos('CURDATE', Result) > 0) Or
      (Pos('UTC_DATE', Result) > 0) Then
      Result := TRegEx.Replace(Result,
        '(CURRENT_DATE(\([ ]*\))?|CURDATE\([ ]*\)|UTC_DATE(\([ ]*\))?)',
        fCurrentDate(VS_Date(False)), [roIgnoreCase]);

    If (Pos('CURRENT_TIMESTAMP', Result) > 0) Or (Pos('NOW', Result) > 0) Or
      (Pos('UTC_TIMESTAMP', Result) > 0) Then
      Result := TRegEx.Replace(Result,
        '(CURRENT_TIMESTAMP(\([ ]*\))?|NOW\([ ]*\)|UTC_TIMESTAMP(\([ ]*\))?)',
        fCurrentDateTime(VS_Date(False) + Time), [roIgnoreCase]);

    If (Pos('CURRENT_TIME', Result) > 0) Or (Pos('CURTIME', Result) > 0) Or
      (Pos('UTC_TIME', Result) > 0) Then
      Result := TRegEx.Replace(Result,
        '(CURRENT_TIME(\([ ]*\))?|CURTIME\([ ]*\)|UTC_TIME(\([ ]*\))?)',
        fCurrentTime, [roIgnoreCase]);
  end;

  function fPreparaSQL(strSQL: String): String;
  Var
    prmParams: TParamDescs;
    prmParam: TParamDesc;
    cmdComand: TCRCommand;
    cmpCompon: TComponent;
    blnAutGer: Boolean;
    objParam: TObject;
    intCont: Integer;
  Begin
    Result := strSQL;
    blnAutGer := False;

    cmpCompon := TDBAccessUtils.GetUpdateQuery(TCustomDADataSet(Component));
    If Not Assigned(cmpCompon) Then
      cmpCompon := Component
    Else
      blnAutGer := True;

    prmParams := TParamDescs.Create;

    If Not blnAutGer Then
    Begin
      cmdComand := TDBAccessUtils.GetICommand(cmpCompon);

      For intCont := 0 To cmdComand.Params.Count - 1 Do
      Begin
        prmParam := TParamDesc.Create;
        prmParam.SetName(cmdComand.Params[intCont].GetName);
        prmParam.SetDataType(cmdComand.Params[intCont].GetDataType);
        prmParam.SetSubDataType(cmdComand.Params[intCont].GetSubDataType);
        prmParam.SetParamType(cmdComand.Params[intCont].GetParamType);
        prmParam.SetSize(cmdComand.Params[intCont].GetSize);
        prmParam.Value := cmdComand.Params[intCont].Value;

        prmParams.Add(prmParam);
      End;

    End;

    objParam := prmParams;
    If blnAutGer Then
      objParam := Params;

    Try
      Result := ParseSQL(Result);
      Result := ParseSQLCitel(conConexao, Result, objParam);
    Except
      On E: Exception Do
        raise Exception.Create('Error on parse sql - ' + E.Message);
    End;

    FreeAndNil(prmParams);
  End;

  function fGeraLogRep(strSel: String): Boolean;
  Var
    intContador: Integer;
  Begin
    If Pos(STR_SQL_NAO_REPLICAR, LeftStr(strSel, 1000)) > 0 Then
      Exit(False);

    strSel := AnsiUpperCase(fTiraEnter(strSel));
    strSel := fTrimAll(strSel);

    Result := False;

    For intContador := 0 To (Length(arrRep1) - 1) Do
    Begin

      If (Pos(arrRep1[intContador], strSel) > 0) Then
      Begin

        If (Not fEmptyStr(arrRep2[intContador])) And
          (Pos(arrRep2[intContador], strSel) > 0) Then
        Begin
          Result := True;
        End
        Else
        Begin

          If fEmptyStr(arrRep2[intContador]) Then
            Result := True;

        End;

      End;
    End;

  End;

Begin
  If Not objConnectionsManager.FindConnection(Component.Tag, conConexao) Then
    Raise Exception.Create('Não foi possível localizar a conexão para o Trace!');

  strString := fPreparaSQL(SQL);

  VS_LastSQL := strString;

  if HasParam('--logssql') then
    WriteLog(VS_LastSQL, True);

  // Para nao gerar erro por conta das conexoes
  If fTabelaExportacaoTerceirosTinta(fExtrairNomeTabelaSQLExportacao(strString)) Then
    Exit;

  strString := fTiraEnter(strString);

  strString := fSubstituiData(strString);

  blnGerar := fGeraLogRep(strString);

  If blnGerar Then
  Begin
    strTabela := fExtrairNomeTabelaSQL(strString);

    If SameText(strTabela, 'CADBCO') Then
      fGravaLogBco(conConexao, strString);

    if (fEhTabelaDeContabilidade(strTabela)) then
      pGravaLogContabil(conConexao, strString, strTabela);

    { ******************************************************* }
    { * TROCANDO INSERT PELO REPLACE PORQUE ESTAVA TRAVANDO * }
    { * NA REPLICAÇÃO QUANDO JÁ EXISTIA O REGISTRO          * }
    { ****************************************************NC* }
    If Pos(strTabela,
      'CFGCOL_DIROPE_DIRBAN_DIRGPO_DIRTIN_ENTCLI_CADFIC_ITEBAR_') > 0 Then
      strString := AnsiReplaceStr(strString, 'INSERT', 'REPLACE');

    If fTabelaReplica(strTabela) Then
      fGravaLogRep(conConexao, strString, strTabela, 'N');
  End;

End;

{ ****************************************************** }
{ * COLOCA O VALOR NOS PARAMETROS DO SQL A SER GRAVADO * }
{ ***************************************************AF* }
function ParseSQLCitel(conConexao: IConnection; const SQL: string; Params: TObject): string;
var
  stbSQLFinal: StringBuilder;
  sqlParser: TSQLParser;
  intPosIni: Integer;
  intParIdx: Integer;
  wrdDataType: Word;
  varValue: Variant;
  blnIsNull: Boolean;
  strCharSet: String;
  intPriVer, intMedVer, intRelVer: Integer;
  objConnection: TMySQLConnection;
  IsMariaDB: Boolean;

  function GetDataType(idx: Integer; Param: TObject): Word;
  Begin

    If Param is TDAParams Then
      Result := TDBAccessUtils.GetFieldTypeMapClass
        (TUniConnection(conConexao.GetObject))
        .GetDataType(TDAParams(Param)[idx].DataType)
    Else If Param is TParamDescs Then
      Result := TParamDescs(Param)[idx].GetDataType
    else
      Result := TParamDescs(Param)[idx].GetDataType;
  End;

  function getValue(idx: Integer; Param: TObject): Variant;
  Begin
    If Param is TDAParams Then
      Result := TDAParams(Param)[idx].Value
    Else If Param is TParamDescs Then
      Result := TParamDescs(Param)[idx].Value;
  End;

  function getIsNull(idx: Integer; Param: TObject): Boolean;
  Begin
    If Param is TDAParams Then
      Result := TDAParams(Param)[idx].IsNull
    Else If Param is TParamDescs Then
      Result := TParamDescs(Param)[idx].GetNull
    else
      Result := TParamDescs(Param)[idx].GetNull;
  End;

begin

  stbSQLFinal := StringBuilder.Create(Length(SQL) + Length(SQL) div 2);
  objConnection := TMySQLConnection.Create;
  try
    sqlParser := TMyParser.Create(SQL);
    try
      sqlParser.OmitBlank := False;
      sqlParser.OmitComment := True;
      sqlParser.QuotedString := True;
      sqlParser.DecSeparator := '.';
      sqlParser.ToBegin;
      intPosIni := sqlParser.CurrPos;

      intParIdx := 0;

      DecodeVersion(TUniConnection(conConexao.GetObject).ServerVersion,
        intPriVer, intMedVer, intRelVer, IsMariaDB);

      strCharSet := TUniConnection(conConexao.GetObject)
        .SpecificOptions.Values['Charset'];

      While sqlParser.ToLexem('?') Do
      Begin
        stbSQLFinal.Append(Copy(SQL, intPosIni + 1,
          sqlParser.CurrPos - intPosIni - 1));

        wrdDataType := GetDataType(intParIdx, Params);
        varValue := getValue(intParIdx, Params);
        blnIsNull := getIsNull(intParIdx, Params);
        objConnection.AppendValueToSQL(stbSQLFinal, wrdDataType, varValue,
          blnIsNull, False, False);

        Inc(intParIdx);
        intPosIni := sqlParser.CurrPos;
      End;

      stbSQLFinal.Append(Copy(SQL, intPosIni + 1,
        sqlParser.CurrPos - intPosIni));
    Finally
      sqlParser.Free;
    End;

    Result := stbSQLFinal.ToString;
  Finally
    stbSQLFinal.Free;
    objConnection.Free;
  End;

end;

{ *********************************************** }
{ * CASO OS PARAMETRO DO SELECT ESTIVEREM SEM ? * }
{ * TROCA PARA SER TRATADO SEMPRE ?             * }
{ ********************************************AF* }
function ParseSQL(const SQL: String): String;
Var
  ParsedSQL: StringBuilder;
  Parser: TSQLParser;
  StartPos: Integer;
  intCode: Integer;
  strAux: String;
begin
  ParsedSQL := StringBuilder.Create(Length(SQL) + Length(SQL) div 2);
  Try
    Parser := TMyParser.Create(SQL);
    Try
      Parser.OmitBlank := False;
      Parser.OmitComment := True;
      Parser.QuotedString := True;
      Parser.DecSeparator := '.';
      Parser.ToBegin;
      StartPos := Parser.CurrPos;
      While Parser.ToLexem(':') Do
      Begin
        ParsedSQL.Append(Copy(SQL, StartPos + 1,
          Parser.CurrPos - StartPos - 1));
        intCode := Parser.GetNext(strAux);

        If ((intCode = lcIdent) or (intCode = lcNumber) or
          (Parser.KeywordLexems.IndexOf(strAux) <> -1)) Then
          ParsedSQL.Append('?')
        Else
        Begin
          ParsedSQL.Append(':');
          ParsedSQL.Append(strAux);
        End;

        StartPos := Parser.CurrPos;
      End;
      ParsedSQL.Append(Copy(SQL, StartPos + 1, Parser.CurrPos - StartPos));
    Finally
      Parser.Free;
    End;

    Result := ParsedSQL.ToString;
  Finally
    ParsedSQL.Free;
  End;
end;

{ TUniDacConnection }

procedure TUniDacConnection.Commit;
begin
  if FConnection.InTransaction then
    FConnection.Commit;
end;

procedure TUniDacConnection.Connect;
begin
  FConnection.Connected := True;
end;

function TUniDacConnection.Connected: Boolean;
begin
  Result := FConnection.Connected;
end;

function TUniDacConnection.ConnectionID: String;
Var
  LQry: IQuery;
begin
  LQry := Self.CreateQuery('SELECT CONNECTION_ID()');
  LQry.Open;
  Result := LQry.Fields(0).AsString;
end;

constructor TUniDacConnection.Create(ATag: NativeUInt);
begin
  FConnection := TUniConnection.Create(Nil);
  FConnection.LoginPrompt := False;
  FConnection.ProviderName := 'MySQL';
  FConnection.Tag := ATag;
end;

function TUniDacConnection.CreateQuery(ASQL: String): IQuery;
begin
  Result := TUniDacQuery.Create(FConnection);
  If Not ASQL.IsEmpty Then
    Result.SQL.Add(ASQL);
end;

function TUniDacConnection.CreateQueryObject(AOwner: TComponent): TObject;
var
  LQuery: TUniQuery;
begin
  LQuery := TUniQuery.Create(AOwner);
  LQuery.Connection := FConnection;
  LQuery.Options.RequiredFields := False;
  LQuery.Tag := FConnection.Tag;
  Result := LQuery;
end;

function TUniDacConnection.CreateScript: IScript;
begin
  Result := TUniDacScript.Create(FConnection);
end;

function TUniDacConnection.Database: String;
begin
  Result := FConnection.Database;
end;

destructor TUniDacConnection.Destroy;
begin
  FreeAndNil(FConnection);
  inherited;
end;

procedure TUniDacConnection.Disconnect;
begin
  FConnection.Connected := False;
end;

function TUniDacConnection.InTransaction: Boolean;
begin
  Result := FConnection.InTransaction;
end;

procedure TUniDacConnection.Rollback;
begin
  if FConnection.InTransaction then
    FConnection.Rollback;
end;

function TUniDacConnection.SetDatabase(AValue: String): IConnection;
begin
  Result := Self;
  FConnection.Database := AValue;
end;

function TUniDacConnection.SetServer(AValue: String): IConnection;
begin
  Result := Self;
  FConnection.Server := AValue;
end;

function TUniDacConnection.SetPassword(AValue: String): IConnection;
begin
  Result := Self;
  FConnection.Password := AValue;
end;

function TUniDacConnection.SetPort(AValue: Integer): IConnection;
begin
  Result := Self;
  FConnection.Port := AValue;
end;

function TUniDacConnection.SetUser(AValue: String): IConnection;
begin
  Result := Self;
  FConnection.Username := AValue;
end;

procedure TUniDacConnection.StartTransaction;
begin
  if not FConnection.InTransaction then
    FConnection.StartTransaction;
end;

function TUniDacConnection.GetObject: TObject;
begin
  Result := FConnection;
end;

function TUniDacConnection.GetTag: NativeUInt;
begin
  Result := FConnection.Tag;
end;

{ TUniDacQuery }

function TUniDacQuery.Active: Boolean;
begin
  Result := FQuery.Active;
end;

procedure TUniDacQuery.Append;
begin
  FQuery.Append;
end;

procedure TUniDacQuery.Cancel;
begin
  FQuery.Cancel;
end;

procedure TUniDacQuery.Close;
begin
  FQuery.Close;
end;

constructor TUniDacQuery.Create(AConexao: TUniConnection);
begin
  FQuery := TUniQuery.Create(nil);
  FQuery.Connection := AConexao;
  FQuery.Options.RequiredFields := False;
  FQuery.Tag := AConexao.Tag;
end;

procedure TUniDacQuery.Delete;
begin
  FQuery.Delete;
end;

destructor TUniDacQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TUniDacQuery.Edit;
begin
  FQuery.Edit;
end;

function TUniDacQuery.Eof: Boolean;
begin
  Result := FQuery.Eof;
end;

procedure TUniDacQuery.ExecSQL;
begin
  FQuery.ExecSQL;
end;

function TUniDacQuery.FieldByName(AName: String): IField;
begin
  Result := TUniDacField.Create(FQuery.FieldByName(AName));
end;

function TUniDacQuery.FieldCount: Integer;
begin
  Result := FQuery.FieldCount;
end;

function TUniDacQuery.Fields(AIndex: Integer): IField;
begin
  Result := TUniDacField.Create(FQuery.Fields[AIndex]);
end;

function TUniDacQuery.FindField(AName: String): IField;
begin
  Result := nil;
  If FQuery.FindField(AName) <> nil Then
    Result := TUniDacField.Create(FQuery.FindField(AName));
end;

function TUniDacQuery.FindParam(AName: String): IParam;
begin
  Result := nil;
  If FQuery.FindParam(AName) <> nil Then
    Result := TUniDacParam.Create(AName, FQuery);
end;

procedure TUniDacQuery.First;
begin
  FQuery.First;
end;

function TUniDacQuery.IsEmpty: Boolean;
begin
  Result := FQuery.IsEmpty;
end;

procedure TUniDacQuery.Last;
begin
  FQuery.Last;
end;

function TUniDacQuery.Locate(const KeyFields: string; const KeyValues: Variant;
  Options: TLocateOptions): Boolean;
begin
  Result := FQuery.Locate(KeyFields, KeyValues, Options);
end;

procedure TUniDacQuery.Next;
begin
  FQuery.Next;
end;

procedure TUniDacQuery.Open;
begin
  FQuery.Open;
  FQuery.First;
end;

function TUniDacQuery.ParamByName(AName: String): IParam;
begin
  Result := TUniDacParam.Create(AName, FQuery);
end;

function TUniDacQuery.ParamCount: Integer;
begin
  Result := FQuery.ParamCount;
end;

function TUniDacQuery.Params(AIndex: Integer): IParam;
begin
  Result := TUniDacParam.Create(FQuery.Params[AIndex].Name, FQuery);
end;

procedure TUniDacQuery.Post;
begin
  FQuery.Post;
end;

procedure TUniDacQuery.Prior;
begin
  FQuery.Prior;
end;

function TUniDacQuery.GetRecNo: Integer;
begin
  Result := FQuery.RecNo;
end;

function TUniDacQuery.RecordCount: Integer;
begin
  Result := FQuery.RecordCount;
end;

procedure TUniDacQuery.Refresh;
begin
  FQuery.Refresh;
end;

procedure TUniDacQuery.SetRecNo(AValue: Integer);
begin
  FQuery.RecNo := AValue;
end;

function TUniDacQuery.SQL: TStrings;
begin
  Result := FQuery.SQL;
end;

function TUniDacQuery.GetObject: TObject;
begin
  Result := Self.FQuery;
end;

{ TUniDacParam }

procedure TUniDacParam.Clear;
begin
  FQuery.Params.ParamByName(FParam).Clear;
end;

constructor TUniDacParam.Create(const AParam: String; const AQuery: TUniQuery);
begin
  FParam := AParam;
  Self.FQuery := AQuery;
end;

function TUniDacParam.GetAsBoolean: Boolean;
begin
  Result := FQuery.Params.ParamByName(FParam).AsBoolean;
end;

function TUniDacParam.GetAsDate: TDate;
begin
  Result := FQuery.Params.ParamByName(FParam).AsDate;
end;

function TUniDacParam.GetAsDateTime: TDateTime;
begin
  Result := FQuery.Params.ParamByName(FParam).AsDateTime;
end;

function TUniDacParam.GetAsFloat: Double;
begin
  Result := FQuery.Params.ParamByName(FParam).AsFloat;
end;

function TUniDacParam.GetAsInteger: Integer;
begin
  Result := FQuery.Params.ParamByName(FParam).AsInteger;
end;

function TUniDacParam.GetAsString: String;
begin
  Result := FQuery.Params.ParamByName(FParam).AsString;
end;

function TUniDacParam.GetAsTime: TTime;
begin
  Result := FQuery.Params.ParamByName(FParam).AsTime;
end;

function TUniDacParam.getValue: Variant;
begin
  Result := FQuery.Params.ParamByName(FParam).Value;
end;

function TUniDacParam.Name: String;
begin
  Result := FParam;
end;

procedure TUniDacParam.SetAsBoolean(const AValue: Boolean);
begin
  FQuery.Params.ParamByName(FParam).AsBoolean := AValue;
end;

procedure TUniDacParam.SetAsDate(const AValue: TDate);
begin
  FQuery.Params.ParamByName(FParam).AsDate := AValue;
end;

procedure TUniDacParam.SetAsDateTime(const AValue: TDateTime);
begin
  FQuery.Params.ParamByName(FParam).AsDateTime := AValue;
end;

procedure TUniDacParam.SetAsFloat(const AValue: Double);
begin
  FQuery.Params.ParamByName(FParam).AsFloat := AValue;
end;

procedure TUniDacParam.SetAsInteger(const AValue: Integer);
begin
  FQuery.Params.ParamByName(FParam).AsInteger := AValue;
end;

procedure TUniDacParam.SetAsString(const AValue: String);
begin
  FQuery.Params.ParamByName(FParam).AsString := AValue;
end;

procedure TUniDacParam.SetAsTime(const AValue: TTime);
begin
  FQuery.Params.ParamByName(FParam).AsTime := AValue;
end;

procedure TUniDacParam.setValue(const AValue: Variant);
begin
  FQuery.Params.ParamByName(FParam).Value := AValue;
end;

procedure TUniDacField.Clear;
begin
  Self.FField.Clear;
end;

constructor TUniDacField.Create(const AField: TField);
begin
  inherited Create();
  Self.FField := AField;
end;

function TUniDacField.DataType: TFieldType;
begin
  Result := FField.DataType;
end;

function TUniDacField.FieldKind: TFieldKind;
begin
  Result := FField.FieldKind;
end;

function TUniDacField.FieldName: String;
begin
  Result := FField.FieldName;
end;

function TUniDacField.GetAsBoolean: Boolean;
begin
  Result := FField.AsBoolean;
end;

function TUniDacField.GetAsDate: TDate;
begin
  Result := FField.AsDateTime;
end;

function TUniDacField.GetAsDateTime: TDateTime;
begin
  Result := FField.AsDateTime;
end;

function TUniDacField.GetAsFloat: Double;
begin
  Result := FField.AsFloat;
end;

function TUniDacField.GetAsInteger: Integer;
begin
  Result := FField.AsInteger;
end;

function TUniDacField.GetAsLargeInt: Int64;
begin
  Result := FField.AsLargeInt;
end;

function TUniDacField.GetAsString: String;
begin
  Result := FField.AsString;
end;

function TUniDacField.GetAsValue: Variant;
begin
  Result := FField.AsVariant;
end;

function TUniDacField.IsNull: Boolean;
begin
  Result := FField.IsNull;
end;

function TUniDacField.Required: Boolean;
begin
  Result := FField.Required;
end;

procedure TUniDacField.SetAsBoolean(const Value: Boolean);
begin
  FField.AsBoolean := Value;
end;

procedure TUniDacField.SetAsDate(const AValue: TDate);
begin
  FField.AsDateTime := AValue;
end;

procedure TUniDacField.SetAsDateTime(const AValue: TDateTime);
begin
  FField.AsDateTime := AValue;
end;

procedure TUniDacField.SetAsFloat(const AValue: Double);
begin
  FField.AsFloat := AValue;
end;

procedure TUniDacField.SetAsInteger(const AValue: Integer);
begin
  FField.AsInteger := AValue;
end;

procedure TUniDacField.SetAsLargeInt(const AValue: Int64);
begin
  FField.AsLargeInt := AValue;
end;

procedure TUniDacField.SetAsString(const AValue: String);
begin
  FField.AsString := AValue;
end;

procedure TUniDacField.SetAsValue(const AValue: Variant);
begin
  FField.AsVariant := AValue;
end;

{ TUniDacMonitor }

class procedure TUniDacMonitor.Finish;
begin
  If Assigned(FMonitor) Then
    FreeAndNil(FMonitor);
  ShowDebugFormProc := nil;
end;

class procedure TUniDacMonitor.SqlMonitorSQL(Sender: TObject; Text: string;
  Flag: TDATraceFlag);
Var
  strNomTab: String;
begin
  Text := AnsiReplaceText(Text, #13#10, ' ');
  Text := AnsiReplaceText(Text, #10, ' ');

  If (Flag <> tfError) Then
  Begin
    strNomTab := fExtrairNomeTabelaSQL(Text);

    If Not fEmptyStr(strNomTab) And fTabelaPermiteReplicarSempre(strNomTab) Then
    Begin
      VS_strTabelaErro := strNomTab;
    End;
  End;
end;

class procedure TUniDacMonitor.Start;
begin
  if Assigned(FMonitor) then
    Exit;

  FMonitor := TUniSQLMonitor.Create(nil);
  FMonitor.Options := [moDialog];
  FMonitor.TraceFlags := [tfQExecute, tfError];
  FMonitor.OnSQL := SqlMonitorSQL;

  ShowDebugFormProc := ShowDebugForm;
end;

{ TUniDacScript }

constructor TUniDacScript.Create(AConexao: TUniConnection);
begin
  FScript := TUniScript.Create(nil);
  FScript.Connection := AConexao;
  FScript.Tag := AConexao.Tag;
end;

destructor TUniDacScript.Destroy;
begin
  FreeAndNil(FScript);
  inherited;
end;

procedure TUniDacScript.Execute;
begin
  FScript.Execute;
end;

function TUniDacScript.SQL: TStrings;
begin
  Result := FScript.SQL;
end;

procedure OnEUniErrorLog(AMessage: string);
begin
  If VS_LastSQL <> EmptyStr then
    If Not HasParam('--logssql') then
      WriteError(VS_LastSQL);
  WriteError(Format('EUniError: %s', [AMessage]));
end;

initialization

//OnEUniErrorException := OnEUniErrorLog;

EnableUniSQL := False;

finalization

TUniDacMonitor.Finish;

end.
