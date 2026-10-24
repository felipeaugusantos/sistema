unit untModuloReplicacao;

interface

uses
  SysUtils, Classes, Uni, StrUtils, DBAccess, CRAccess, DBMonitorClient,
  CLRClasses, MyCallUni, CRParser, DASQLMonitor, UniSQLMonitor, MyClassesUni,
  MyParserUni, frxClass, RegularExpressions, Windows;

type
  TfrmModuloReplicacao = class(TDataModule)
    sqlMonitor: TUniSQLMonitor;
    procedure DataModuleCreate(Sender: TObject);
    procedure sqlMonitorSQL(Sender: TObject; Text: string; Flag: TDATraceFlag);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pLigaSQLTrace;
    procedure pDesligaSQLTrace;
    procedure pShowSQLTrace;
  end;

  function ParseSQLCitel(const SQL: string; Params: TObject; conConexao: TUniConnection): string;
  function ParseSQL(const SQL: string): String;
  procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent; SQL: string; Params: TDAParams; Caption: string);

var
  frmModuloReplicacao: TfrmModuloReplicacao;

implementation

uses  untFuncoesSimples, untModulo, untConstantes;

Var
  FSQLTraceLigado: Boolean;
  FSQLTraceList: TStringList;

{$R *.dfm}

procedure TfrmModuloReplicacao.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  FSQLTraceList := TStringList.Create;
  pDesligaSQLTrace;
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;

  blnTransferindoCodigo := False;
  ShowDebugFormProc := ShowDebugForm;
end;

procedure TfrmModuloReplicacao.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FSQLTraceList);
end;

procedure TfrmModuloReplicacao.pDesligaSQLTrace;
begin
  FSQLTraceLigado := False;
end;

procedure TfrmModuloReplicacao.pLigaSQLTrace;
begin
  FSQLTraceLigado := True;
  FSQLTraceList.Clear;
end;

procedure TfrmModuloReplicacao.pShowSQLTrace;
Var
  LFileName: String;
begin
  LFileName := ExtractFilePath(ParamStr(0)) + '\tmp\';

  If Not DirectoryExists(LFileName) Then
    CreateDir(LFileName);

  LFileName := LFileName + 'SQL_TRACE_' + ParamStr(5).Replace(' ', '_') + '_' +
    VS_strCodEmp + '_' + VS_SQL_TRACE_PRODUTO + VS_SQL_TRACE_DOC_NUMERO + '.txt';

  FSQLTraceList.SaveToFile(LFileName);

  WinExec(PAnsiChar(AnsiString('Notepad.exe "' + LFileName + '"')), SW_SHOWNORMAL);
end;

procedure TfrmModuloReplicacao.sqlMonitorSQL(Sender: TObject; Text: string;
  Flag: TDATraceFlag);
  Var
    strNomTab: String;
begin

  Text := AnsiReplaceText(Text, #13#10, ' ');
  Text := AnsiReplaceText(Text, #10, ' ');

  If (Flag <> tfError) Then
  Begin
    strNomTab := fRetornaNomeTabela(Text);

    If Not fEmptyStr(strNomTab) And
           fTabelaPermiteReplicarSempre(strNomTab) Then
    Begin
      VS_strTabelaErro := strNomTab;
    End;
  End;

end;

procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent; SQL: string; Params: TDAParams; Caption: string);
  Var
    strString     : String;
    strTabela     : String;
    blnGerar      : Boolean;
    conConexao    : TUniConnection;

    {**************************************************************}
    {*Regex para substituição das funções de data do mysql*********}
    {*Para evitar divegência entre as datas em cada banco de dados*}
    {***********************************************************LO*}
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

    function fSubstituiData(strTexto: String): String;
    begin
      Result := strTexto;

      If (Pos('CURRENT_DATE', Result) > 0) Or (Pos('CURDATE', Result) > 0) Or (Pos('UTC_DATE', Result) > 0) Then
        Result := TRegEx.Replace(Result, '(CURRENT_DATE(\([ ]*\))?|CURDATE\([ ]*\)|UTC_DATE(\([ ]*\))?)', fCurrentDate, [roIgnoreCase]);

      If (Pos('CURRENT_TIMESTAMP', Result) > 0) Or (Pos('NOW', Result) > 0) Or (Pos('UTC_TIMESTAMP', Result) > 0) Then
        Result := TRegEx.Replace(Result, '(CURRENT_TIMESTAMP(\([ ]*\))?|NOW\([ ]*\)|UTC_TIMESTAMP(\([ ]*\))?)', fCurrentDateTime, [roIgnoreCase]);

      If (Pos('CURRENT_TIME', Result) > 0) Or (Pos('CURTIME', Result) > 0) Or (Pos('UTC_TIME', Result) > 0) Then
        Result := TRegEx.Replace(Result, '(CURRENT_TIME(\([ ]*\))?|CURTIME\([ ]*\)|UTC_TIME(\([ ]*\))?)', fCurrentTime, [roIgnoreCase]);
    end;

    function fPreparaSQL(strSQL: String): String;
    Var
      prmParams: TParamDescs;
      prmParam : TParamDesc;
      cmdComand: TCRCommand;
      cmpCompon: TComponent;
      blnAutGer: Boolean;
      objParam : TObject;
      intCont  : Integer;
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

        For intCont := 0 To cmdComand.Params.Count-1 Do
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

      Result := ParseSQL(Result);
      Result := ParseSQLCitel(Result, objParam, conConexao);

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

      If strSel = SQL_TESTE_LOG_REPLICACAO Then
        Exit(True);

      Result := False;

      For intContador := 0 To ( Length(arrRep1) - 1 ) Do
      Begin

        If (Pos( arrRep1[intContador], strSel ) > 0) Then
        Begin

          If (Not fEmptyStr(arrRep2[intContador]))  And
             (Pos( arrRep2[intContador], strSel ) > 0) Then
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
  conConexao := frmModulo.GetCurrentConnection(Component.Tag);

  If FSQLTraceLigado And Assigned(FSQLTraceList) And SQL.Trim.StartsWith('/*') Then
  Begin
    If FSQLTraceList.Count = 0 Then
      FSQLTraceList.Add('#----------------------------------------------------------------------------');
    FSQLTraceList.Add(fTrimAll(fPreparaSQL(SQL)) + ';');
    FSQLTraceList.Add('#----------------------------------------------------------------------------');
  End;

  If Not fGeraLogRep(AnsiUpperCase(SQL)) Then
    Exit;

  strString      := fPreparaSQL(SQL);

  //Para nao gerar erro por conta das conexoes
  If fTabelaExportacaoTerceirosTinta(fRetornaNomeTabela(strString)) Then
    Exit;

  strString := fTiraEnter(strString);

  strString := fSubstituiData(strString);

  blnGerar := fGeraLogRep(strString);

  If blnGerar Then
  Begin
    strTabela := fRetornaNomeTabela(strString);

    If SameText(strTabela,'CADBCO') Then
      fGravaLogBco(strString);

    if (fEhTabelaDeContabilidade(strTabela)) then
      pGravaLogContabil(strString, strTabela);

    {*******************************************************}
    {* TROCANDO INSERT PELO REPLACE PORQUE ESTAVA TRAVANDO *}
    {* NA REPLICAÇÃO QUANDO JÁ EXISTIA O REGISTRO          *}
    {****************************************************NC*}
    If Pos(strTabela, 'CFGCOL_DIROPE_DIRBAN_DIRGPO_DIRTIN_ENTCLI_CADFIC_ITEBAR_') > 0 Then
      strString := AnsiReplaceStr(strString, 'INSERT', 'REPLACE');

    If fTabelaReplica(strTabela) Or (strString = SQL_TESTE_LOG_REPLICACAO) Or fPermiteReplicarCfgSis(strString) Then
      fGravaLogRep(strString, strTabela, 'N', conConexao);
  End;

End;

{******************************************************}
{* COLOCA O VALOR NOS PARAMETROS DO SQL A SER GRAVADO *}
{***************************************************AF*}
function ParseSQLCitel(const SQL: string; Params: TObject; conConexao: TUniConnection): string;
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

      If Param is TDAParams Then
        Result := TDBAccessUtils.GetFieldTypeMapClass(conConexao).GetDataType(TDAParams(Param)[idx].DataType)
      Else
      If Param is TParamDescs Then
          Result := TParamDescs(Param)[idx].GetDataType
      else
        Result := TParamDescs(Param)[idx].GetDataType;
    End;

    function getValue(idx:Integer; Param: TObject): Variant;
    Begin
      If Param is TDAParams Then Result := TDAParams(Param)[idx].Value
      Else If Param is TParamDescs Then Result := TParamDescs(Param)[idx].Value;
    End;

    function getIsNull(idx:Integer; Param: TObject): Boolean;
    Begin
      If Param is TDAParams Then
        Result := TDAParams(Param)[idx].IsNull
      Else
      If Param is TParamDescs Then
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
      DecodeVersion(conConexao.ServerVersion, intPriVer, intMedVer, intRelVer, IsMariaDB);
      strCharSet := conConexao.SpecificOptions.Values['Charset'];

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
    stbSQLFinal.Free;
    objConnection.Free;
  End;

end;

{***********************************************}
{* CASO OS PARAMETRO DO SELECT ESTIVEREM SEM ? *}
{* TROCA PARA SER TRATADO SEMPRE ?             *}
{********************************************AF*}
function ParseSQL(const SQL: String): String;
  Var
    ParsedSQL: StringBuilder;
    Parser   : TSQLParser;
    StartPos : Integer;
    intCode  : Integer;
    strAux   : String;
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

end.

