unit untTSQLTrace;

interface

uses Windows, Forms, Classes, SysUtils, StrUtils,
  UniSQLMonitor, DASQLMonitor, DBAccess, CRAccess, CLRClasses, CRParser,
  MyParserUni, MyClassesUni, MyCallUni, Uni,
  StdCtrls, Buttons, Dialogs, Controls, Messages, ExtCtrls, untITSQLTrace, Shlobj,
  Types, untFuncoesSimples;

Type
  TSQLTrace = class(TInterfacedObject, ITSQLTrace)
  {$T+}
  private
    FMonitor: TUniSQLMonitor;
    FPasta: String;
    ListaLabel: TList;
    ListaBotao: TList;

    FStackTrace: Boolean;
    FCabecalho: Boolean;
    FAutenticado: Boolean;
    FCountSQL: Integer;
    FStatus: TStatusTrace;
    FTipo: TTipoTrace;
    FTempFile: String;

    function GetStackTrace: Boolean;
    function GetCabecalho: Boolean;
    function GetCountSQL: Integer;
    function GetStatus: TStatusTrace;
    function GetTipo: TTipoTrace;
    function GetTempFile: String;
    function GetAutenticado: Boolean;

    procedure SetStackTrace(const Value: Boolean);
    procedure SetCabecalho(const Value: Boolean);
    procedure SetCountSQL(const Value: Integer);
    procedure SetStatus(const Value: TStatusTrace);
    procedure SetTipo(const Value: TTipoTrace);
    procedure SetTempFile(const Value: String);
    procedure SetAutenticado(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure pIniciaTrace;
    procedure pPausaTrace;
    procedure pSalvaTrace;
    procedure pIncCountSQL();

    function ParseSQLCitel(const SQL: string; Params: TObject): string;
    function ParseSQL(const SQL: string): String;
    function fIgnoraInstrucao(strSQL: String): Boolean;

    procedure pShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent;
      SQL: string; Params: TDAParams; Caption: string);

    property StackTrace: Boolean read GetStackTrace write SetStackTrace;
    property Cabecalho: Boolean read GetCabecalho write SetCabecalho;
    property CountSQL: Integer read GetCountSQL write SetCountSQL;
    property Status: TStatusTrace read GetStatus write SetStatus;
    property Tipo: TTipoTrace read GetTipo write SetTipo;
    property TempFile: String read GetTempFile write SetTempFile;
    property Autenticado: Boolean read GetAutenticado write SetAutenticado;
  end;

  procedure ShowDebugFormSqlTrace(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent;
    SQL: string; Params: TDAParams; Caption: string);
  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;

implementation

uses
  untFuncoes, untConstantes, untSQLTraceOpcoes, untModulo, untLogSQL, untPai,
  untPaiRelatorio, untModuloReplicacao;

{ TSQLTrace }

constructor TSQLTrace.Create;
begin
  FMonitor   := TUniSQLMonitor.Create(Nil);
  ListaLabel := TList.Create;
  ListaBotao := TList.Create;
  FPasta     := GetSpecialFolderPath(CSIDL_APPDATA, False) + '\Autsi\';
  Self.SetAutenticado(False);
  Self.SetTempFile(FPasta + 'SQLTrace\temp.txt');
  Self.SetCountSQL(0);
  Self.SetStatus(stPausado);

  If (Not DirectoryExists(FPasta)) Then
    MkDir(FPasta);

  FPasta := FPasta + 'SQLTrace';

  If (Not DirectoryExists(FPasta)) Then
    MkDir(FPasta);

  If (FileExists(FTempFile)) Then
    DeleteFile(FTempFile);
end;

destructor TSQLTrace.Destroy;
begin
  FMonitor.Free;
  ListaLabel.Free;
  ListaBotao.Free;

  inherited;
end;

function TSQLTrace.fIgnoraInstrucao(strSQL: String): Boolean;
begin
  Result := Pos('ABRINDO_CONSULTA = FALSE', strSQL) > 0;
end;

procedure TSQLTrace.pIncCountSQL;
begin
  Self.SetCountSQL(Self.GetCountSQL() + 1);
end;

procedure TSQLTrace.pIniciaTrace;
begin
  if (Self.GetStatus() = stPausado) and (not Self.GetAutenticado()) then
    TfrmSQLTraceOpcoes.pSQLTraceOpcoes(FTipo, FCabecalho, FStackTrace);

  ShowDebugFormProc := ShowDebugFormSqlTrace;
  FMonitor.Active   := True;
  Self.SetStatus(stIniciado);
  Self.SetAutenticado(True);
end;

procedure TSQLTrace.pPausaTrace;
begin
  ShowDebugFormProc := untModuloReplicacao.ShowDebugForm;
  FMonitor.Active := False;
  FStatus := stPausado;
end;

procedure TSQLTrace.SetAutenticado(const Value: Boolean);
begin
  Self.FAutenticado := Value;
end;

procedure TSQLTrace.SetCabecalho(const Value: Boolean);
begin
  Self.FCabecalho := Value;
end;

procedure TSQLTrace.SetCountSQL(const Value: Integer);
begin
  Self.FCountSQL := Value;
end;

procedure TSQLTrace.SetStackTrace(const Value: Boolean);
begin
  Self.FStackTrace := Value;
end;

procedure TSQLTrace.SetStatus(const Value: TStatusTrace);
begin
  Self.FStatus := Value;
end;

procedure TSQLTrace.SetTempFile(const Value: String);
begin
  Self.FTempFile := Value;
end;

procedure TSQLTrace.SetTipo(const Value: TTipoTrace);
begin
  Self.FTipo := Value;
end;

procedure TSQLTrace.pShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass;
  Component: TComponent; SQL: string; Params: TDAParams; Caption: string);
begin
  ShowDebugFormTrace(DASQLMonitorClass, Component, SQL, Params, Caption);
end;

function TSQLTrace.GetStackTrace: Boolean;
begin
  Result := Self.FStackTrace;
end;

function TSQLTrace.GetAutenticado: Boolean;
begin
  Result := Self.FAutenticado;
end;

function TSQLTrace.GetCabecalho: Boolean;
begin
  Result := Self.FCabecalho;
end;

function TSQLTrace.GetCountSQL: Integer;
begin
  Result := Self.FCountSQL;
end;

function TSQLTrace.GetStatus: TStatusTrace;
begin
  Result := Self.FStatus;
end;

function TSQLTrace.GetTempFile: String;
begin
  Result := Self.FTempFile;
end;

function TSQLTrace.GetTipo: TTipoTrace;
begin
  Result := Self.FTipo;
end;

function TSQLTrace.ParseSQL(const SQL: string): String;
  Var
    ParsedSQL: StringBuilder;
    Parser   : TSQLParser;
    StartPos : Integer;
    intCode  : Integer;
    strAux   : String;
begin
  If fIgnoraInstrucao(SQL) Then
    Exit;

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
        ParsedSQL.Append(Copy(SQL, StartPos + 1, Parser.CurrPos - StartPos - 1));
        intCode := Parser.GetNext(strAux);

        If ((intCode = lcIdent) or (intCode = lcNumber) or (Parser.KeywordLexems.IndexOf(strAux) <> -1)) Then
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

function TSQLTrace.ParseSQLCitel(const SQL: string; Params: TObject): string;
  var
    stbSQLFinal: StringBuilder;
    sqlParser  : TSQLParser;
    intPosIni  : integer;
    intParIdx  : Integer;
    wrdDataType: Word;
    varValue   : Variant;
    blnIsNull  : Boolean;
    strCharSet : String;
    intPriVer, intMedVer, intRelVer: Integer;
    objConnection : TMySQLConnection;
    IsMariaDB : Boolean;

    function getDataType(idx:Integer; Param: TObject): Word;
    Begin
      If Param.ClassNameIs('TUniParams') Then
        Result := TDBAccessUtils.GetFieldTypeMapClass(frmModulo.Database).GetDataType(TUniParams(Param)[idx].DataType)

      Else If Param is TDAParams Then
        Result := TDBAccessUtils.GetFieldTypeMapClass(frmModulo.Database).GetDataType(TDAParams(Param)[idx].DataType)

      Else If Param is TParamDescs Then
          Result := TParamDescs(Param)[idx].GetDataType

      Else
        Result := TParamDescs(Param)[idx].GetDataType;
    End;

    function getValue(idx:Integer; Param: TObject): Variant;
    Begin
      If Param.ClassNameIs('TUniParams') Then
        Result := TUniParams(Param)[idx].Value

      Else If Param is TDAParams Then
        Result := TDAParams(Param)[idx].Value

      Else If Param is TParamDescs Then
        Result := TParamDescs(Param)[idx].Value

      Else
        Result := TParamDescs(Param)[idx].Value;
    End;

    function getIsNull(idx:Integer; Param: TObject): Boolean;
    Begin
      If Param.ClassNameIs('TUniParams') Then
        Result := TUniParams(Param)[idx].IsNull
      Else If Param is TDAParams Then
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
      DecodeVersion(frmModulo.Database.ServerVersion, intPriVer, intMedVer, intRelVer, IsMariaDB);
      strCharSet := frmModulo.Database.SpecificOptions.Values['Charset'];

      While sqlParser.ToLexem('?') Do
      Begin
        stbSQLFinal.Append(Copy(SQL, intPosIni + 1, sqlParser.CurrPos - intPosIni - 1));

        wrdDataType := getDataType(intParIdx, Params);
        varValue    := getValue(intParIdx, Params);
        blnIsNull   := getIsNull(intParIdx, Params);
        objConnection.AppendValueToSQL(stbSQLFinal, wrdDataType, varValue, blnIsNull, False, False);

        Inc(intParIdx);
        intPosIni := sqlParser.CurrPos;
      End;

      stbSQLFinal.Append(Copy(SQL, intPosIni + 1, sqlParser.CurrPos - intPosIni));
    Finally
      sqlParser.Free;
    End;

    Result := stbSQLFinal.ToString;
  Finally
    objConnection.Free;
    stbSQLFinal.Free;
  End;

end;

procedure TSQLTrace.pSalvaTrace;
  Var
    strFileTmp, strFile: String;
    intAct: Integer;
    stl: TStringList;
begin

  strFile := InputBox('Nome do Arquivo', 'Digite o nome do Arquivo de Trace', FormatDateTime('yyyy-mm-dd hh-nn-ss', fNow()));

  If fEmptyStr(strFile) Then
    strFile := FormatDateTime('yyyy-mm-dd hh-nn-ss', fNow());

  strFile := FPasta + strFile + '.txt';

  stl := TStringList.Create;
  Try
    If Not FileExists(FTempFile) Then
    Begin
      pMensagemOk('Falha ao salvar, arquivo temporário não encontrado!');
      Exit;
    End;

    stl.LoadFromFile(FTempFile);
    strFileTmp := stl.GetText;

    stl.Clear;

    If FileExists(strFile) Then
    Begin
      intAct := fMensagem('', 'Arquivo já existe, escolha a ação a tomar!', ['&Cancelar', '&Sobrescrever', '&Incrementar']);

      Case intAct Of
        1: Exit;
        2: DeleteFile(pChar(strFile));
        3: stl.LoadFromFile(strFile);
      End;
    End;

    stl.Text := stl.Text + strFileTmp;
    stl.SaveToFile(strFile);

    DeleteFile(pChar(FTempFile));

    If fMensagem('', 'Arquivo salvo com sucesso, deseja abrir?', ['&Sim', '&Não']) = 1 Then
      pExecArquivo(strFile, 0);

    FCountSQL := 0;
  Finally
    stl.Free;
  End;
end;

procedure ShowDebugFormSqlTrace(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent;
    SQL: string; Params: TDAParams; Caption: string);

  function fTiraEnter(strTexto: String): String;
  begin
    Result := strTexto;
    Result := AnsiReplaceText(Result, #13#10, ' ');
    Result := AnsiReplaceText(Result, #10, ' ');
    Result := Trim(Result);
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
    Try
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

      Result := VS_Trace.ParseSQL(Result);
      Result := VS_Trace.ParseSQLCitel(Result, objParam);

      FreeAndNil(prmParams);
    Except
      Result := '';
    End;
  End;

  Var
    strString: String;
begin
  untModuloReplicacao.ShowDebugForm(DASQLMonitorClass, Component, SQL, Params, Caption);

  strString := fTiraEnter(fPreparaSQL(SQL));
  If (Not strString.IsEmpty) Then
    VS_Trace.pShowDebugForm(DASQLMonitorClass, Component, strString, Params, Caption);
end;

function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
  Var
    FilePath: array [0..255] of Char;
Begin
  SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
  Result := FilePath;
End;

end.
