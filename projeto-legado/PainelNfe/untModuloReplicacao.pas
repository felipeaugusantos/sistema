unit untModuloReplicacao;

interface

uses
 {$IFDEF LINUX}
 {$ELSE}
  Dialogs, Forms,
 {$ENDIF}
  SysUtils, Classes, StrUtils, Uni, DASQLMonitor, UniSQLMonitor, DBAccess,
  CRAccess, CLRClasses, CRParser, MyParserUni, MyCallUni, MyClassesUni, SyncObjs, RegularExpressions;

type
  TfrmModuloReplicacao = class(TDataModule)
    sqlMonitor: TUniSQLMonitor;
    procedure DataModuleCreate(Sender: TObject);
    procedure sqlMonitorSQL(Sender: TObject; Text: string; Flag: TDATraceFlag);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function fPegaDataSistema: TDateTime;
  procedure pCarregaNre;
  function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
  function fGravaLogRep(strComand, strTabela, strCarreg: String): Boolean;
  function fTabelaReplica(strNomTabela: String): Boolean;
  function fRetornaNomeTabela(strString: String): String;
  function ParseSQLCitel(const SQL: string; Params: TObject): string;
  function ParseSQL(const SQL: string): String;
  procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent; SQL: string; Params: TDAParams; Caption: string);
  function fGravaInfUsuarioReplicacao(intSeqReplicacao: Int64): Boolean;

var
  frmModuloReplicacao: TfrmModuloReplicacao;

Const
  {**************************************}
  {* MATRIZ PARA COMANDOS A SEREM GRAV. *}
  {***********************************AF*}
  arrRep1: Array[0..4] Of String = ('INSERT', 'REPLACE', 'DELETE FROM', 'UPDATE', 'SET FOREIGN_KEY_CHECKS');
  arrRep2: Array[0..4] Of String = (' INTO ', ' INTO ' , ''           , ' SET ' , ''                      );

implementation

uses
{$IFDEF LINUX}
  NFe.Utils,
  NFe.Modulo
{$ELSE}
  untUtil,
  untModulo
{$ENDIF}
{$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)},
  System.UITypes, Data.DB{$ELSE},DB{$IFEND};

{$R *.dfm}

function ParseSQL(const SQL: string): String;
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

function ParseSQLCitel(const SQL: string;
  Params: TObject): string;
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
        Result := TDBAccessUtils.GetFieldTypeMapClass(frmModulo.Database).GetDataType(TDAParams(Param)[idx].DataType)
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
  try
    objConnection := TMySQLConnection.Create;
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
        objConnection.AppendValueToSQL(stbSQLFinal, wrdDataType, varValue, blnIsNull, False, False{, True, intPriVer, strCharSet});

        Inc(intParIdx);
        intPosIni := sqlParser.CurrPos;
      End;

      stbSQLFinal.Append(Copy(SQL, intPosIni + 1, sqlParser.CurrPos - intPosIni));
    Finally
      sqlParser.Free;
      objConnection.Free;
    End;

    Result := stbSQLFinal.ToString;
  Finally
    stbSQLFinal.Free;
  End;
end;

{**************************************}
{* GERA O LOG DE REPLICAÇÃO           *}
{***********************************AF*}
procedure TfrmModuloReplicacao.DataModuleCreate(Sender: TObject);
begin
  ShowDebugFormProc := ShowDebugForm;
end;

procedure ShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass; Component: TComponent; SQL: string; Params: TDAParams; Caption: string);
  Var
    strString     : String;
    strTabela     : String;
    intPosEsp     : Integer;
    blnGerar      : Boolean;

    function fTiraEnter(strTexto: String): String;
    begin
      Result := strTexto;
      Result := AnsiReplaceText(Result, #13#10, ' ');
      Result := AnsiReplaceText(Result, #10, ' ');
      Result := Trim(Result);
    end;

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
      Result := TRegEx.Replace(strTexto, '(CURRENT_DATE(\([ ]*\))?|CURDATE\([ ]*\)|UTC_DATE(\([ ]*\))?)', fCurrentDate, [roIgnoreCase]);
      Result := TRegEx.Replace(Result  , '(CURRENT_TIMESTAMP(\([ ]*\))?|NOW\([ ]*\)|UTC_TIMESTAMP(\([ ]*\))?)', fCurrentDateTime, [roIgnoreCase]);
      Result := TRegEx.Replace(Result  , '(CURRENT_TIME(\([ ]*\))?|CURTIME\([ ]*\)|UTC_TIME(\([ ]*\))?)', fCurrentTime, [roIgnoreCase]);
    end;

    function fTrimAll(strTexto: String): String;
    begin
      Result := strTexto;
      While Pos('  ', Result) > 0 Do
      Begin
        intPosEsp := Pos('  ', Result);
        Delete(Result, intPosEsp, 1);
      End;
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
      Result := ParseSQLCitel(Result, objParam);

      FreeAndNil(prmParams);
    End;

    function fGeraLogRep(strSel: String): Boolean;
      Var
        intContador: Integer;
    Begin
      strSel := fTiraEnter(strSel);
      strSel := fTrimAll(strSel);

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
begin
  If Not fGeraLogRep(AnsiUpperCase(SQL)) Then
    Exit;

  strString := fPreparaSQL(AnsiUpperCase(SQL));

  strString := fTiraEnter(strString);
  strString := fSubstituiData(strString);
  blnGerar  := fGeraLogRep(strString);

  If blnGerar Then
  Begin
    strTabela := fRetornaNomeTabela(strString);

    If fTabelaReplica(strTabela) Then
      fGravaLogRep(strString, strTabela, 'N');
  End;
end;

//**************************************//
// RETORNA NOME DE TABELA               //
//***********************************WI*//
function fRetornaNomeTabela(strString: String): String;
  Var
    strTmp     : String;
    intPosicao : Integer;
    intContador: Integer;
Begin
  Result     := '';
  intPosicao := 0;

  strString := Trim(strString);

  If      LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := AnsiReplaceStr(strTmp, 'INTO ', '');
  End;


  If (intPosicao > 0) Then
  Begin
    strTmp := AnsiReplaceStr(strTmp,'(', ' ');
    strTmp := AnsiReplaceStr(strTmp,')', ' ');
    strTmp := AnsiReplaceStr(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;
End;

{**************************************}
{* VERIFICA SE TABELA REPLICA OU NÃO  *}
{***********************************AF*}
function fTabelaReplica(strNomTabela: String): Boolean;
  Var
    intContador: Integer;
Begin

  Try
    Result := fTabelaPermiteReplicarSempre(strNomTabela);
    If Not Result Then
      Exit;

    If (Not Assigned(VS_stlTabNre)) Then
    Begin
      pCarregaNre;
    End;

    For intContador := 0 To VS_stlTabNre.Count -1 Do
    Begin

      {**************************************}
      {* SE FOI COLOCADO NO FIM O %         *}
      {***********************************AF*}
      If Pos('%', Trim(VS_stlTabNre[intContador])) > 0 Then
      Begin

        If LeftStr(Trim(AnsiUpperCase(strNomTabela)), Length(Trim(AnsiUpperCase(VS_stlTabNre[intContador]))) - 1) = LeftStr(Trim(AnsiUpperCase(VS_stlTabNre[intContador])), Length(Trim(AnsiUpperCase(VS_stlTabNre[intContador]))) - 1) Then
        Begin
          Result := False;
          Exit;
        End;

      End
      {**************************************}
      {* SE NÃO FOI COLOCADO O %            *}
      {***********************************AF*}
      Else
      Begin

        {**************************************}
        {* SE O NOME DA TABELA FOR O MESMO DA *}
        {* CONFIGURAÇÃO ENTÃO NÃO REPLICA     *}
        {***********************************AF*}
        If Trim(AnsiUpperCase(strNomTabela)) = Trim(AnsiUpperCase(VS_stlTabNre[intContador])) Then
        Begin
          Result := False;
          Exit;
        End;

      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
     {$IFDEF LINUX}
      WriteLn('[TABELAREPLICA] - ' + E.Message);
     {$ELSE}
      MessageDlg('[TABELAREPLICA] - ' + E.Message, mtError, [mbOK], 0);
     {$ENDIF}
    End;
  End;
End;

function fGravaInfUsuarioReplicacao(intSeqReplicacao: Int64): Boolean;
var
  qryUsuRep: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := True;

  qryUsuRep := fCriaQuery(Nil);
  Try
    qryUsuRep.SQL.Add('INSERT INTO USUREP (');
    qryUsuRep.SQL.Add('  LOG_SEQREP, ');
    qryUsuRep.SQL.Add('  LOG_NOMMAQ, ');
    qryUsuRep.SQL.Add('  LOG_NOMUSU, ');
    qryUsuRep.SQL.Add('  LOG_NUM_IP, ');
    qryUsuRep.SQL.Add('  LOG_CON_ID, ');
    qryUsuRep.SQL.Add('  LOG_MACADD) ');
    qryUsuRep.SQL.Add('VALUES (      ');
    qryUsuRep.SQL.Add('  :SEQREP,    ');
    qryUsuRep.SQL.Add('  :NOMMAQ,    ');
    qryUsuRep.SQL.Add('  :NOMUSU,    ');
    qryUsuRep.SQL.Add('  :NUM_IP,    ');
    qryUsuRep.SQL.Add('  :CON_ID,    ');
    qryUsuRep.SQL.Add('  :MACADD)    ');

    qryUsuRep.ParamByName('SEQREP').Value := intSeqReplicacao;
    qryUsuRep.ParamByName('NOMMAQ').Value := VS_ComputerNetName;
    qryUsuRep.ParamByName('NOMUSU').Value := VS_UserFromWindows;
    qryUsuRep.ParamByName('NUM_IP').Value := VS_IPAddressAsString;
    qryUsuRep.ParamByName('MACADD').Value := VS_MacAddress;
    qryUsuRep.ParamByName('CON_ID').Value := VS_ConnectionID;

    qryUsuRep.ExecSQL;
  Finally
    FreeAndNil(qryUsuRep);
  End;
end;

{**************************************}
{* GERA O LOG DE REPLICAÇÃO           *}
{***********************************AF*}
function fGravaLogRep(strComand, strTabela, strCarreg: String): Boolean;
Var
  qryLogRep: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  dtaDtaSis : TDateTime;
  dtaHraSis : TDateTime;

  function fGravaLogRepConId: Boolean;
  begin
    Result := (VS_LogRepConId = 'S') And (VS_ConnectionID <> '');
  end;

  function fGravaTabelasFilhasLogRep: Boolean;
  begin
    Result := (VS_GravaUsuRep = 'S') And (VS_ConnectionID <> '');
  end;

  procedure pCarregaVariaveisControle;
  begin
    If (VS_ConnectionID = '') Then
      VS_ConnectionID := fConnectionID;

    If (VS_LogRepConId = '') Then
    Begin
      If fCampoExiste('LOGREP', 'LOG_CON_ID') Then
        VS_LogRepConId := 'S'
      Else
        VS_LogRepConId := 'N'
    End;

    If (VS_LogRepCodOp = '') Then
    Begin
      If fCampoExiste('LOGREP', 'LOG_CODOPE') Then
        VS_LogRepCodOp := 'S'
      Else
        VS_LogRepCodOp := 'N'
    End;

    If (VS_GravaUsuRep = '') Then
    Begin
      VS_GravaUsuRep := 'N';

      If (VS_LogRepConId = 'N') Then
      Begin
        If (fCampoExiste('USUREP', 'LOG_SEQREP')) And
           (fCampoExiste('USUREP', 'LOG_NOMMAQ')) And
           (fCampoExiste('USUREP', 'LOG_NOMUSU')) And
           (fCampoExiste('USUREP', 'LOG_NUM_IP')) And
           (fCampoExiste('USUREP', 'LOG_MACADD')) And
           (fCampoExiste('USUREP', 'LOG_CON_ID')) Then
        Begin
          VS_GravaUsuRep := 'S'
        End;
      End;
    End;
  end;

Begin
  Result := True;
  Try
    pCarregaVariaveisControle;

    qryLogRep := fCriaQuery(Nil);
    Try
      pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);

      If fGravaTabelasFilhasLogRep Then
      Begin
        qryLogRep.SQL.Text := 'SELECT * FROM LOGREP WHERE FALSE';
        qryLogRep.Open;

        qryLogRep.Insert;

        If (fGravaLogRepConId) Then
          qryLogRep.FieldByName('LOG_CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.FieldByName('LOG_CODOPE').AsString := '999';

        qryLogRep.FieldByName('LOG_DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.FieldByName('LOG_HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.FieldByName('LOG_COMAND').AsString   := strComand;
        qryLogRep.FieldByName('LOG_TABELA').AsString   := strTabela;
        qryLogRep.FieldByName('LOG_CARREG').AsString   := strCarreg;

        qryLogRep.Post;

        If (VS_GravaUsuRep = 'S') Then
          Result := Result And fGravaInfUsuarioReplicacao(qryLogRep.FieldByName('LOG_CODIGO').Value);
      End
      Else
      Begin
        qryLogRep.SQL.Clear;
        qryLogRep.SQL.Add('INSERT INTO LOGREP ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' LOG_CON_ID,     ');

        If (VS_LogRepCodOp = 'S') Then
         qryLogRep.SQL.Add('  LOG_CODOPE,     ');

        qryLogRep.SQL.Add('   LOG_DTACAD,     ');
        qryLogRep.SQL.Add('   LOG_HRACAD,     ');
        qryLogRep.SQL.Add('   LOG_COMAND,     ');
        qryLogRep.SQL.Add('   LOG_TABELA,     ');
        qryLogRep.SQL.Add('   LOG_CARREG      ');
        qryLogRep.SQL.Add('  )                ');
        qryLogRep.SQL.Add('VALUES             ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' :CON_ID,         ');

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.SQL.Add(' :CODOPE,        ');

        qryLogRep.SQL.Add('   :DTACAD,        ');
        qryLogRep.SQL.Add('   :HRACAD,        ');
        qryLogRep.SQL.Add('   :COMAND,        ');
        qryLogRep.SQL.Add('   :TABELA,        ');
        qryLogRep.SQL.Add('   :CARREG         ');

        qryLogRep.SQL.Add('  )                ');

        If (fGravaLogRepConId) Then
          qryLogRep.ParamByName('CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.ParamByName('CODOPE').AsString := '999';

        qryLogRep.ParamByName('DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.ParamByName('HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.ParamByName('COMAND').AsString   := strComand;
        qryLogRep.ParamByName('TABELA').AsString   := strTabela;
        qryLogRep.ParamByName('CARREG').AsString   := strCarreg;

        qryLogRep.ExecSQL;
      End;

      qryLogRep.Close;
    Finally
      FreeAndNil(qryLogRep);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
     {$IFDEF LINUX}
      WriteLn('Erro ao tentar gravar LogRep - ' + E.Message);
     {$ELSE}
      MessageDlg('Erro ao tentar gravar LogRep - ' + E.Message, mtError, [mbOK], 0);
     {$ENDIF}
    End;
  End;
End;

function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
begin
  Result := True;

  {***************************************************}
  {* NÃO REPLICA A TABNRE!!!!                        *}
  {** 09/06/2008 - 09:54 **************************MV*}
  {** 09/06/2009 - 17:47 **************************JB*}
  {** 13/02/2013 - ********************************JU*}
  If (strNomTabela = 'NFE_TAREFAS')    Or
     (strNomTabela = 'LOG_DANFE')      Or
     (strNomTabela = 'DICSIS')         Or
     (strNomTabela = 'TABNRE')         Or
     (strNomTabela = 'LOGREP')         Or
     (strNomTabela = 'USUREP')         Or
     (strNomTabela = 'PDFNFE')         Or
     (strNomTabela = 'PROINC')         Or
     (strNomTabela = 'PROCOD')         Or
     (strNomTabela = 'LOGERR')         Or
     (strNomTabela = 'LOGACE')         Or
     (strNomTabela = 'LCKATC')         Or
     (strNomTabela = 'LOGSQL')         Or
     (strNomTabela = 'CADBCO')         Or
     (strNomTabela = 'INFSIS')         Or
     (strNomTabela = 'NFE_NFEPRINTER') Or
     (strNomTabela = 'NFE_TEMPO')      Or
     (strNomTabela = 'NFE_LOCAL')      Or
     (strNomTabela = 'TRANSACOES')     Then
  Begin
    Result := False;
  End;
end;

procedure pCarregaNre;
  Var
   qryTabNRE: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  VS_stlTabNre := TStringList.Create;

  qryTabNRE := fCriaQuery(Nil);
  qryTabNRE.SQL.Add('SELECT * FROM TABNRE');
  qryTabNRE.Open;

  If (qryTabNRE.IsEmpty) Or (Not qryTabNRE.Active) Then
  Begin
    qryTabNRE.Close;
    FreeAndNil(qryTabNRE);
   {$IFDEF LINUX}
    WriteLn('Tabela TABNRE vazia! Verifique!');
   {$ELSE}
    MessageDlg('Tabela TABNRE vazia! Verifique!', mtInformation, [mbOK], 0);
   {$ENDIF}
    Application.Terminate;
  End;

  While Not qryTabNRE.Eof Do
  Begin
    VS_stlTabNre.Add(qryTabNRE.Fields[0].AsString);
    qryTabNRE.Next;
  End;

  qryTabNRE.Close;
  FreeAndNil(qryTabNRE);
end;

{********************************************}
{* AJUSTA O RELOGIO DO WINDOWS TOMANDO COMO *}
{* BASE A DATA DO SERVIDOR                  *}
{*****************************************MV*}
function fPegaDataSistema: TDateTime;
  Var
    qryGenTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin

  qryGenTmp := fCriaQuery(Nil);

  Try
    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
      Open;
      Result := FieldByName('CURRENT_DATE').AsDateTime;
      Close;
    End;

    qryGenTmp.Close;
    FreeAndNil(qryGenTmp);

  Except
    Result := Date;
  End;

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

end.

