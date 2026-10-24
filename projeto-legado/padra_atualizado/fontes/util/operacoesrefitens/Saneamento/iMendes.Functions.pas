unit iMendes.Functions;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  vcl.Forms,
  Winapi.Windows,
  Winapi.WinSock,
  Uni,
  untFuncoesSimples,
{$ENDIF}
  imendes.Types, Classes, StrUtils, SysUtils, Data.DB, CRAccess, System.AnsiStrings, System.IniFiles, system.IOUtils,
  System.SyncObjs, Dateutils;

  procedure pMontaTextoTConsultasArray(var ALista: TStringList; Consultas: TConsultasArrayIMendes);
  function PerfilToString(AConj: TConjPerfis): String;
  function PerfilPrefixoToString(AConj: TConjPerfis): String;

  function fLocalizaValor(AText: TStringList; strChave: String): String;
  function fLocalizaConsultaArray(AText: TStringList; strChave: String): TConsultasArrayIMendes;
  function fLocalteIndex(AText: TStringList; strChave: String): Integer;
  Function fPerfilInString(Value: string; AstrPerfil: string; APerfil: TPerfil): TPerfil;
  function fLocalizaValorConjPerfil(AText: TStringList; strChave: String): TConjPerfis;
  function fDescriptografar(texto: String): String;
  function fCriptografar(texto: String): String;
  function iMendesCriaQuery({$IFNDEF LINUX}conexao: TUniConnection{$ENDIF}): {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
  function iMendesCriaDataSource(DataSet: TDataSet): TDataSource;
  function fTemCfgDARROR({$IFNDEF LINUX}conexao: TUniConnection{$ENDIF}): Boolean;
  function fCampoExiste({$IFNDEF LINUX}conexao: TUniConnection;{$ENDIF} ASchemaName, ATabela, ACampo: String): Boolean;

 {$IFNDEF LINUX}
  function iMendesCriaConnection: TUniConnection;
  procedure pConectar(var DataBase : TUniConnection);
 {$ENDIF}

  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;

  function AutComfDecriptar(strSenha: String): String;
  function InserirEspaco(AString : String; ATamanho, APosicao: Integer): String;
  function iMendesfCfgSis(strCodCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''{$IFNDEF LINUX}; conexao: TUniConnection = nil{$ENDIF}): variant;

  function fStrLocate(strCodigo: String; arrLinha: TConsultasArrayIMendes; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False): String;

  function fStrLocateLinGru(strCodigo: String; arrLinha: TConsultasArrayIMendes; strNomCampo,
                            strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
                            blnAndFinal: Boolean = False): String;

  procedure pSetaParam(strText: String; arrLinha: TConsultasArrayIMendes; Var strLinha: String; strNomPar: String; qryRelatorio: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF});


  function fEstadoProcessamentoToInteger(TipoFinalizacaoProcessamento: TEstadoProcessamento): integer;
  function IntegerToEstadoProcessamento(AValue: integer): TEstadoProcessamento;

  function fRetDescricaoEstadoMaquina(TipoFinalizacaoProcessamento: TEstadoProcessamento): String;
  function fGetNumbers(strTexto: String): String;

  Function fConvertStringToPerfil(APerfil: String):TPerfil;
  Function fConvertConfPerfilToString(APerfi:TPerfil): String;
  Function fConvertConfPerfilToAliasFieldString(APerfi:TPerfil; ApenasPerfil: Boolean = False): String;
  Function fConvertPerfilToDescricao(APerfi:TPerfil): String;
  Function fConvertPerfilToDescricaoComCaracteristica(blnExibeComplemento: Boolean; APerfi:TPerfil; qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): String;


  function fGetPerfilItem(APerfil: String): TPerfil;
  function fGetConjPerfis(strPerfil: string): TConjPerfis;
  function fPerfilEntrada(APerfil: String): Boolean; overload;
  function fPerfilSaida(APerfil: String): Boolean; overload;
  function fPerfilSaida(APerfil: TPerfil): Boolean; overload;
  function fPerfilEntrada(APerfil: TPerfil): Boolean; overload;


  function fSeperaPefis(ConjPerfis: TConjPerfis; blnEntrada: Boolean): TConjPerfis;
  function fSplit(ALista: String): TArrOfString;

  function fRetConUF(strUF: String): TConjUnidadesFederativas;
  function fRetStringUF(Estado: TUnidadesFederativas): string;
  function fLocalizaRecDadosICMS(strEstado: String; StrCaracTrib: String; ArrRecICMSt: TArrRecICMS): TRecDadosICMS;
  function fRemoveVirgula(Value: String): String;
  function fServicoUP(AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): Boolean;
  function fValidaPrfSanPreenchida(AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): Boolean;
  function fValidaCaracTribPreenchida(AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): Boolean;


  function fImendesNow(): TDateTime;
  function iMendesRetAutoincrem({$IFNDEF LINUX}conexao: TUniConnection; {$ENDIF} strTabela: String; strCodEmp: String): string;
  function GetNewID(Prefix: String): string;
  function fRetMaxThreadAtivas: integer;
  function fRetComplementoDescricao(APerfil: TPerfil; AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): String;
  function fValidaEan13(strGTIN: String) : Boolean;
  function fValidaEanTamanhoEInicio(aGtin: String): Boolean;
  procedure pIniciaNotificacaoTemporizada;
  function fContadorDeRequisicaoAtivado: Boolean;


  procedure pEscreveLog(Value: String; AForceLog: Boolean = False; ASize: Integer = -1);
  procedure pAtualizaTemporizador(var AVariaveisDeControle: TVariaveisDeControle; procSEQCON: String);
  function GetMacAddress: String;
  function GetIPAddressAsString: String;
  function GetIPAddress: Integer;
  function GetUserFromWindows: string;
  function fRetNomeRede: String;
  function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
  function Transform(AConteudo: String; AStep: Shortint; AChar: String): String;

  function IfThenImendes(Value: Boolean; ATrue, AFalse: Double): Double;







implementation

uses
  iMendes.Constantes, untConstantes;

function fLocalteIndex(AText: TStringList; strChave: String): Integer;
var i: integer;
Begin
  Result :=  -1;
  For i := 0 To AText.Count -1 do
  Begin
    If Pos(strChave, AText[i]) > 0 Then
      Exit(i);
  End;
End;

function fLocalizaValor(AText: TStringList; strChave: String): String;
var index: integer;
Begin
  Result :='';
  index := fLocalteIndex(AText, strChave+'=' );
  If index > -1 Then
    Result := StringReplace(AText[index], strChave+'=', '', []);
End;

function fLocalizaConsultaArray(AText: TStringList; strChave: String): TConsultasArrayIMendes;
var index: integer;
    Size: Integer;
    I: Integer;
Begin
  SetLength(Result, 0);
  index := fLocalteIndex(AText, strChave);
  If index > -1 Then
  Begin
    inc(index);
    Size:= StringReplace(AText[index], 'Tamanho=', '', []).ToInteger;
    SetLength(Result,Size);
    for I := 0 to Length(Result) -1 do
    Begin
      inc(index);
      Result[i].strCodigo := StringReplace(AText[index], '['+i.ToString+']Consulta.strCodigo=', '', []);
      inc(index);
      Result[i].strDescri:= StringReplace(AText[index], '['+i.ToString+']Consulta.strDescri=', '', []);
    End;
  End;
End;

Function fPerfilInString(Value: string; AstrPerfil: string; APerfil: TPerfil): TPerfil;
Begin
  Result := cjpIndef;
  If  Pos(AstrPerfil, Value) > 0  Then
    Result :=  APerfil;
End;


function fLocalizaValorConjPerfil(AText: TStringList; strChave: String): TConjPerfis;
var index: integer;
    strPerfis: String;
    APerfil:TPerfil;
Begin
  Result :=[];
  index := fLocalteIndex(AText, strChave+'=' );
  If index > -1 Then
  Begin
    strPerfis := StringReplace(AText[index], strChave+'=', '', []);
    For APerfil in [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII, cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS, cjpIndef] do
    Begin
      case APerfil of
        cjpPEF: Result   := Result + [fPerfilInString(AText[index], 'cjpPEF', APerfil)];
        cjpPEJ: Result   := Result + [fPerfilInString(AText[index], 'cjpPEJ', APerfil)];
        cjpPER: Result   := Result + [fPerfilInString(AText[index], 'cjpPER', APerfil)];
        cjpPES: Result   := Result + [fPerfilInString(AText[index], 'cjpPES', APerfil)];
        cjpPSI: Result   := Result + [fPerfilInString(AText[index], 'cjpPSI', APerfil)];
        cjpPII: Result   := Result + [fPerfilInString(AText[index], 'cjpPII', APerfil)];
        cjpNCO: Result   := Result + [fPerfilInString(AText[index], 'cjpNCO', APerfil)];
        cjpCCO: Result   := Result + [fPerfilInString(AText[index], 'cjpCCO', APerfil)];
        cjpCNC: Result   := Result + [fPerfilInString(AText[index], 'cjpCNC', APerfil)];
        cjpSNA: Result   := Result + [fPerfilInString(AText[index], 'cjpSNA', APerfil)];
        cjpCTA: Result   := Result + [fPerfilInString(AText[index], 'cjpCTA', APerfil)];
        cjpPRU: Result   := Result + [fPerfilInString(AText[index], 'cjpPRU', APerfil)];
        cjpIND: Result   := Result + [fPerfilInString(AText[index], 'cjpIND', APerfil)];
        cjpTRS: Result   := Result + [fPerfilInString(AText[index], 'cjpTRS', APerfil)];
        cjpIndef: Result := Result + [fPerfilInString(AText[index], 'cjpIndef', APerfil)];
      end;
    End;
    If Result <>  [cjpIndef] Then
      Result := Result - [cjpIndef];
  End;
End;


function PerfilToString(AConj: TConjPerfis): String;
var APerfi:TPerfil;
    strVirgula: String;
Begin
  Result := '[';
  strVirgula := '';
  For APerfi in AConj do
  Begin
    If Result <> '[' then
      strVirgula := ',';
    case APerfi of
      cjpPEF: Result := Result + strVirgula + 'cjpPEF';
      cjpPEJ: Result := Result + strVirgula + 'cjpPEJ';
      cjpPER: Result := Result + strVirgula + 'cjpPER';
      cjpPES: Result := Result + strVirgula + 'cjpPES';
      cjpPSI: Result := Result + strVirgula + 'cjpPSI';
      cjpPII: Result := Result + strVirgula + 'cjpPII';
      cjpNCO: Result := Result + strVirgula + 'cjpNCO';
      cjpCCO: Result := Result + strVirgula + 'cjpCCO';
      cjpCNC: Result := Result + strVirgula + 'cjpCNC';
      cjpSNA: Result := Result + strVirgula + 'cjpSNA';
      cjpCTA: Result := Result + strVirgula + 'cjpCTA';
      cjpPRU: Result := Result + strVirgula + 'cjpPRU';
      cjpIND: Result := Result + strVirgula + 'cjpIND';
      cjpTRS: Result := Result + strVirgula + 'cjpTRS';
    end;
  End;
  Result := Result + ']';
End;


function PerfilPrefixoToString(AConj: TConjPerfis): String;
var APerfi:TPerfil;
    strVirgula: String;
Begin
  Result := '[';
  strVirgula := '';
  For APerfi in AConj do
  Begin
    If Result <> '[' then
      strVirgula := ',';
    case APerfi of
      cjpPEF: Result := Result + strVirgula + 'PEF';
      cjpPEJ: Result := Result + strVirgula + 'PEJ';
      cjpPER: Result := Result + strVirgula + 'PER';
      cjpPES: Result := Result + strVirgula + 'PES';
      cjpPSI: Result := Result + strVirgula + 'PSI';
      cjpPII: Result := Result + strVirgula + 'PII';
      cjpNCO: Result := Result + strVirgula + 'NCO';
      cjpCCO: Result := Result + strVirgula + 'CCO';
      cjpCNC: Result := Result + strVirgula + 'CNC';
      cjpSNA: Result := Result + strVirgula + 'SNA';
      cjpCTA: Result := Result + strVirgula + 'CTA';
      cjpPRU: Result := Result + strVirgula + 'PRU';
      cjpIND: Result := Result + strVirgula + 'IND';
      cjpTRS: Result := Result + strVirgula + 'TRS';
    end;
  End;
  Result := Result + ']';
End;

procedure pMontaTextoTConsultasArray(var ALista: TStringList; Consultas: TConsultasArrayIMendes);
var
    i: integer;
Begin

 ALista.Add('Tamanho='+Length(Consultas).ToString());
 For i := 0 To Length(Consultas) -1 do
 Begin
   ALista.Add('['+i.ToString+']Consulta.strCodigo=' + Consultas[i].strCodigo);
   ALista.Add('['+i.ToString+']Consulta.strDescri=' + Consultas[i].strDescri);
 End;
End;

function fCriptografar(texto: String): String;
var
  I: Integer;
  C: Byte;
  const key = 'iMendes';
begin
  Result := '';
  for I := 1 to Length(texto) do begin
    if Length(Key) > 0 then
      C := Byte(Key[1 + ((I - 1) mod Length(Key))]) xor Byte(texto[I])
    else
      C := Byte(texto[I]);
    Result := Result + AnsiLowerCase(IntToHex(C, 2));
  end;
end;

function fDescriptografar( texto: String): String;
var
  I: Integer;
  C: Char;
  const key = 'iMendes';
begin
  Result := '';
  for I := 0 to Length(texto) div 2 - 1 do begin
    C := Chr(StrToIntDef('$' + Copy(texto, (I * 2) + 1, 2), Ord(' ')));
    if Length(Key) > 0 then
      C := Chr(Byte(Key[1 + (I mod Length(Key))]) xor Byte(C));
    Result := Result + C;
  end;
end;


function iMendesCriaQuery({$IFNDEF LINUX}conexao: TUniConnection{$ENDIF}): {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
Begin
{$IFDEF LINUX}
  Result := fCriaQuery;
{$ELSE}
  Result := TUniQuery.Create(nil);
  Result.Connection := conexao;
{$ENDIF}
End;

function iMendesCriaDataSource(DataSet: TDataSet): TDataSource;
Begin
  Result := TDataSource.Create(nil);
  Result.DataSet := DataSet;
End;

function fTemCfgDARROR({$IFNDEF LINUX}conexao: TUniConnection{$ENDIF}): Boolean;
var qryConsulta: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
begin
  qryConsulta := iMendesCriaQuery({$IFNDEF LINUX}conexao{$ENDIF});
  Try
    qryConsulta.SQL.Text := 'SELECT COUNT(1) QTD FROM CFGSIS WHERE SIS_CODCFG = "CFG_DARROR"';
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryConsulta);
  {$ENDIF}
  End;
End;

function fCampoExiste({$IFNDEF LINUX}conexao: TUniConnection;{$ENDIF} ASchemaName, ATabela, ACampo: String): Boolean;
var qryConsulta: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
begin
  qryConsulta := iMendesCriaQuery({$IFNDEF LINUX}conexao{$ENDIF});
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD');
    qryConsulta.SQL.Add('FROM information_schema.COLUMNS');
    qryConsulta.SQL.Add('WHERE TABLE_SCHEMA = ' + QuotedStr(ASchemaName));
    qryConsulta.SQL.Add('  AND TABLE_NAME = ' + QuotedStr(ATabela));
    qryConsulta.SQL.Add('  AND COLUMN_NAME = ' + QuotedStr(ACampo));
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    {$IFNDEF LINUX}
      FreeAndNil(qryConsulta);
    {$ENDIF}
  End;
end;

{$IFNDEF LINUX}
function iMendesCriaConnection: {$IFDEF LINUX}IConnection{$ELSE}TUniConnection{$ENDIF};
Begin
  EnableUniSQL := False;
  Result := TUniConnection.Create(nil);
  Result.ProviderName := 'MySQL';
  Result.DefaultTransaction.IsolationLevel := DEFAULT_ISOLATION_LEVEL_UNIDAC;
  pConectar(Result);
  Result.Connect;
{ Result.Username := 'autcom_citel';
  Result.Password := 'belamupe_citel';
  Result.Server := '10.0.0.205';
  Result.Database := 'AUTCOM_SAO_LUIZ';
  Result.Port := 49658};
End;
{$ENDIF}

function HasParam(AParamID: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID) then
      exit(True);
end;

function GetParamValue(AParamID: String): String;
Var
  I: Integer;
begin
  Result := '';
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID) then
      exit(ReplaceStr(ParamStr(I), AParamID, ''));
end;

{$IFNDEF LINUX}
procedure pConectar(var DataBase : TUniConnection);
var
  libUtil: Cardinal;
  fRetornaUsuario: function: PAnsiChar; stdcall;
  fRetornaSenha: function: PAnsiChar; stdcall;
begin
  If IMendes_Usuario = '' Then
  Begin
    libUtil := LoadLibrary(PChar(ExtractFilePath(Application.ExeName) + '\libUtil.dll'));

    fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
    fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));
    IMendes_Usuario := String(fRetornaUsuario);
    IMendes_Senha   := String(fRetornaSenha);

    FreeLibrary(libUtil);
  end;
  If HasParam('NUMIP=') Then
    Database.Server := GetParamValue('NUMIP=')
  Else
  Database.Server   := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP',''), ' ', '');

  If HasParam('NOMBAN=') Then
    Database.Database := GetParamValue('NOMBAN=')
  Else
  Database.Database := fArqIni(0,'BANCO','NOMBAN','');

  If HasParam('PORTA=') Then
    Database.Port := StrToIntDef(GetParamValue('PORTA='), 3306)
  Else
  If Not (fArqIni(0,'BANCO','PORTA','') = '') Then
    Database.Port := StrToInt(AnsiReplaceStr(fArqIni(0,'BANCO','PORTA','3306'), ' ', ''));

  Database.Username := IMendes_Usuario;
  Database.Password := IMendes_Senha;
End;
{$ENDIF}

function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (strNomArq = '') Then
    strNomArq := 'opcoes.ini';

  iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + strNomArq);
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function AutComfDecriptar(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
  Result := '';
  If strSenha = '' Then
  	Result := InserirEspaco(strSenha,Length(strSenha), 1);

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1),'ªº«ÁÂÃÄ©ÆÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙ‘’›œž¨­àáâãäåæçèéêëìíîïðñþò÷üôøýöùúûÝß¶®Å~£¤§À²³¢');
    Result := Result + MidStr(STR_CHAR_CRYPT_IMENDES, intCl1,1);
  End;
end;


function InserirEspaco(AString : String; ATamanho, APosicao: Integer): String;
Var
	LContador : integer;
Begin
  Case APosicao Of
  	1 : For LContador := Length(AString) To ATamanho -1 Do
		  	  AString := AString + ' ';

    2 : For LContador := Length(AString) To ATamanho -1 Do
    		  AString := ' ' + AString;
  End;

  InserirEspaco := AString;

end;

function iMendesfCfgSis(strCodCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''{$IFNDEF LINUX}; conexao: TUniConnection = nil{$ENDIF}): variant;
var qryConsulta: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    strValCfg: String;
begin
{$IFDEF LINUX}
  If strCodEmp = '' Then
    strCodemp := VS_strCodEmp;
{$ELSE}
  If Not Assigned(Conexao) Then
    Conexao := iMendes_Connection;
  If strCodEmp = '' Then
    strCodemp := iMendes_strCodEmp;
{$ENDIF}
  qryConsulta := iMendesCriaQuery({$IFNDEF LINUX}conexao{$ENDIF});
  Try
    qryConsulta.SQL.Text := 'SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = "CFG_' + strCodCfg + '" AND SIS_CODEMP = "'+strCodEmp+'"';
    qryConsulta.Open;

    strValCfg :=  qryConsulta.FieldByname('SIS_VALCFG').AsString;

    Case varTipVar Of
        varString : Result := strValCfg;

        varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                    Begin
                      Try
                        If strValCfg ='' Then
                          Result := 0
                        Else
                          Result := strToInt(strValCfg);
                      Except
                        Result := 0;
                      End;
                    End;

        varDouble, varCurrency:
                    Begin
                      Try
                        If strValCfg = '' Then
                          Result := 0.00
                        Else
                          Result := StrToFloat(AnsiReplaceStr(strValCfg, '.', ','));
                      Except
                        Result := 0.00;
                      End;
                    End;

        varDate:
                    Begin
                      Try
                        If strValCfg = '' Then
                          Result := 0
                        Else
                          Result := strToDate(strValCfg);
                      Except
                        Result := 0;
                      End;
                    End;

        varBoolean:
                   Begin
                     Try
                       If strValCfg = '' Then
                         Result := False
                       Else If Pos(strValCfg, 'S_N_') > 0 Then
                         result :=  strValCfg = 'S'

                       Else If Pos(strValCfg, '0_1_') > 0  Then
                         result :=  strValCfg = '1'
                       Else
                         Result := (Length(strValCfg) > 0) And CharInSet(strValCfg[1], ['T', 't', 'Y', 'y']);

                     Except
                       Result := False;
                     End;

                   End;

        Else
          Result := strValCfg;

      End;

  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryConsulta);
  {$ENDIF}
  End;


End;



function fStrLocate(strCodigo: String; arrLinha: TConsultasArrayIMendes; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False): String; Overload;
Begin
  If Not (strCodigo = '') Then
  Begin
    If blnNegar Then
    Begin
      If Length(arrLinha) > 1 Then
        Result := '(NOT LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0) AND COALESCE(' + strNomCampo + ', "") <> "" '
      Else
        Result := strNomCampo + ' <> :' + strNomPar + ' ';
    End
    Else
    Begin
      If Length(arrLinha) > 1 Then
        Result := 'LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0  AND COALESCE(' + strNomCampo + ', "") <> "" '
      Else
        Result := strNomCampo + ' = :' + strNomPar + ' ';
    End;

    If Not blnSemAND Then
      Result := '  AND ' + Result;
  End
  Else
    Result := '';
End;


function fStrLocateLinGru(strCodigo: String; arrLinha: TConsultasArrayIMendes; strNomCampo,
                          strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
                          blnAndFinal: Boolean = False): String;
  Var
    intContador: Integer;
Begin
  Result := '';
 If strCodigo = '' Then
   Exit;

  If Not (strCodigo = '') Then
  Begin

    If Length(arrLinha) > 1 Then
    Begin
      Result := '(';

      For intContador := Low(arrLinha) To High(arrLinha) Do
      Begin
        If RightStr(arrLinha[intContador].strCodigo, 3) = '000' Then
          Result := Result + ' (LEFT(' + strNomCampo + ', 3) = ' +  QuotedStr(LeftStr(arrLinha[intContador].strCodigo, 3)) + ') '
        Else
          Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrLinha[intContador].strCodigo) + ') ';

        If intContador <> High(arrLinha) Then
          Result := Result + ' OR ';
      End;

      Result := Result + ' ) ';

    End Else
    Begin

      If RightStr(strCodigo, 3) = '000' Then
        Result := Result + ' (LEFT(' + strNomCampo + ', 3) = LEFT(:' + strNomPar + ', 3)) '
      Else
        Result := Result + strNomCampo + ' = :' + strNomPar + ' ';

    End;

    If blnNegar Then
      Result := ' (NOT ( ' + Result + ' )) ';

    If (Not blnSemAND) And (Not (Result = '')) Then
    Begin
      If blnAndFinal Then
        Result :=  Result + '  AND '
      Else
        Result := '  AND ' + Result;
    End;
  End;

End;


procedure pSetaParam(strText: String; arrLinha: TConsultasArrayIMendes; Var strLinha: String; strNomPar: String; qryRelatorio: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF});
  Var
    intContador : integer;
Begin

  strLinha := '';
  For intContador := 0 To Length(arrLinha)-1 Do
  Begin
    strLinha := strLinha + arrLinha[intContador].strCodigo + '_';
  End;

  With qryRelatorio Do
  If (Not (strText = '')) And (FindParam(strNomPar) <> Nil) Then
  Begin

    If Length(arrLinha) > 1 Then
    Begin
      ParamByName(strNomPar).AsString := strLinha;
    End
    Else
      ParamByName(strNomPar).AsString := strText;
  End;
End;

function fEstadoProcessamentoToInteger(TipoFinalizacaoProcessamento: TEstadoProcessamento): integer;
Begin
  Result := -1;
  case TipoFinalizacaoProcessamento Of
    epPendente              : Result := 0;
    epIniciaprocesso        : Result := 1;
    epCriandoEstruturaBanco : Result := 2;
    epProcessando           : Result := 3;
    epFinalizadoOk          : Result := 4;
    epFinalizadoSemItem     : Result := 5;
    epFinalizadoComErro     : Result := 6;
    epFinalizadoPeloAutcom  : Result := 7;
    epFalhaAutenticacao      : Result := 8;
    epRecriaTabelaResultado : Result := 9;
    epFinalizadoItemNaoEncontradoNaImendes: Result := 10;
    epAlterados             : Result := 11;
    epRecriaTabelaResultadoParcial : Result := 12;
    epReprocessaItensParcialmente : Result := 13;
  end;
End;


function fRetDescricaoEstadoMaquina(TipoFinalizacaoProcessamento: TEstadoProcessamento): String;
Begin
  Result := 'epIndefinido';
  case TipoFinalizacaoProcessamento Of
    epPendente              : Result := 'epPendente ';
    epIniciaprocesso        : Result := 'epIniciaprocesso';
    epCriandoEstruturaBanco : Result := 'epCriandoEstruturaBanco';
    epProcessando           : Result := 'epProcessando';
    epFinalizadoOk          : Result := 'epFinalizadoOk';
    epFinalizadoSemItem     : Result := 'epFinaliadoSemItem';
    epFinalizadoComErro     : Result := 'epFinalizadoComErro';
    epFinalizadoPeloAutcom  : Result := 'epFinalizadoPeloAutcom';
    epFalhaAutenticacao    : Result := 'epFalhaAutenticacao';
    epRecriaTabelaResultado : Result := 'epRecriaTabelaResultado';
    epFinalizadoItemNaoEncontradoNaImendes: Result := 'epFinalizadoItemNaoEncontradoNaImendes';
    epAlterados: Result := 'epAlterados';
    epRecriaTabelaResultadoParcial: Result := 'epRecriaTabelaResultadoParcial';
    epReprocessaItensParcialmente: Result := 'epReprocessaItensParcialmente';
  end;
End;

function IntegerToEstadoProcessamento(AValue: integer): TEstadoProcessamento;
Begin
  Result := epIndefinido;
  case AValue Of
    0: Result := epPendente;
    1: Result := epIniciaprocesso;
    2: Result := epCriandoEstruturaBanco;
    3: Result := epProcessando;
    4: Result := epFinalizadoOk;
    5: Result := epFinalizadoSemItem;
    6: Result := epFinalizadoComErro;
    7: Result := epFinalizadoPeloAutcom;
    8: Result := epFalhaAutenticacao;
    9: Result := epRecriaTabelaResultado;
   10: Result := epFinalizadoItemNaoEncontradoNaImendes;
   11: Result := epAlterados;
   12: Result := epRecriaTabelaResultadoParcial;
   13: Result := epReprocessaItensParcialmente;
  end;
End;

function fGetNumbers(strTexto: String): String;
  Var
    intPos: Integer;
begin
  Result := '';
  For intPos := 1 To Length(strTexto) Do
    If CharInSet(strTexto[intPos], ['0'..'9']) Then
      Result := Result + strTexto[intPos];
end;

Function fConvertStringToPerfil(APerfil: String):TPerfil;
begin
  Result := cjpPEF;
  If VersaoAutcomApi = 72 then
  Begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS_72) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       5 : Result := cjpNCO;
       6 : Result := cjpCCO;
       7 : Result := cjpCNC;
       8 : Result := cjpSNA;
       9 : Result := cjpCTA;
      10 : Result := cjpPRU;
      11 : Result := cjpIND;
      12 : Result := cjpTRS;
    end;
  End
  Else
  Begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       5 : Result := cjpPII;
       6 : Result := cjpNCO;
       7 : Result := cjpCCO;
       8 : Result := cjpCNC;
       9 : Result := cjpSNA;
      10 : Result := cjpCTA;
      11 : Result := cjpPRU;
      12 : Result := cjpIND;
      13 : Result := cjpTRS;
    end;
  End;
End;

Function fConvertConfPerfilToString(APerfi:TPerfil): String;
Begin
  case APerfi of
    cjpPEF: Result := 'PEF';
    cjpPEJ: Result := 'PEJ';
    cjpPER: Result := 'PER';
    cjpPES: Result := 'PES';
    cjpPSI: Result := 'PSI';
    cjpPII: Result := 'PII';
    cjpNCO: Result := 'NCO';
    cjpCCO: Result := 'CCO';
    cjpCNC: Result := 'CNC';
    cjpSNA: Result := 'SNA';
    cjpCTA: Result := 'CTA';
    cjpPRU: Result := 'PRU';
    cjpIND: Result := 'IND';
    cjpTRS: Result := 'TRS';
  end;
End;



Function fConvertPerfilToDescricao(APerfi:TPerfil): String;
Begin
  case APerfi of
    cjpPEF: Result := ('PEF-Entradas PF(PF ou PJ Sem Insc. Estadual)');
    cjpPEJ: Result := ('PEJ-Entradas PJ(Indústria)');
    cjpPER: Result := ('PER-Entradas PJ(Distribuição/Revenda/Comercialização)');
    cjpPES: Result := ('PES-Entradas PJ(Simples Nacional-Distrib./ Rev./Comerc.)');
    cjpPSI: Result := ('PSI-Entradas PJ(Simples Nacional - Indústria)');
    cjpPII: Result := ('PII-Entradas PJ(Indústria Incentivada)');
    cjpNCO: Result := ('NCO-Saídas Não Contribuinte(PF ou PJ Sem Insc. Estadual)');
    cjpCCO: Result := ('CCO-Saídas Contribuinte Consumidor');
    cjpCNC: Result := ('CNC-Saídas Contribuinte Não Consumidor');
    cjpSNA: Result := ('SNA-Saídas Simples Nacional');
    cjpCTA: Result := ('CTA-Saídas Construtura/Não Contribuinte com Insc.Estadual');
    cjpPRU: Result := ('PRU-Saídas Produtor Rural');
    cjpIND: Result := ('IND-Saídas Indústria');
    cjpTRS: Result := ('TRS-Saídas Transferências Entre Lojas');
  End;
End;

Function fConvertPerfilToDescricaoComCaracteristica(blnExibeComplemento: Boolean; APerfi:TPerfil; qry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): String;
Begin
  case APerfi of
    cjpPEF: Result := ('PEF-Entradas PF(PF ou PJ S/IES)                         ');
    cjpPEJ: Result := ('PEJ-Entradas PJ(Indústria)                              ');
    cjpPER: Result := ('PER-Entradas PJ(Distrib./Rev./Comerc.)                  ');
    cjpPES: Result := ('PES-Entradas PJ(Simples Nacional-Distrib./Rev./Comerc.) ');
    cjpPSI: Result := ('PSI-Entradas PJ(Simples Nacional - Indústria)           ');
    cjpPII: Result := ('PII-Entradas PJ(Indústria Incentivada)                  ');
    cjpNCO: Result := ('NCO-Saídas Não Contribuinte(PF ou PJ S/IES)             ');
    cjpCCO: Result := ('CCO-Saídas Contribuinte Consumidor            ');
    cjpCNC: Result := ('CNC-Saídas Contribuinte Não Consumidor        ');
    cjpSNA: Result := ('SNA-Saídas Simples Nacional                   ');
    cjpCTA: Result := ('CTA-Saídas Construtora/Não Contribuinte c/IES ');
    cjpPRU: Result := ('PRU-Saídas Produtor Rural                     ');
    cjpIND: Result := ('IND-Saídas Indústria                          ');
    cjpTRS: Result := ('TRS-Saídas Transferências Entre Lojas         ');
  End;
  If blnExibeComplemento Then
    Result := Result + ' ' + fRetComplementoDescricao(APerfi, qry);
End;



Function fConvertConfPerfilToAliasFieldString(APerfi:TPerfil; ApenasPerfil: Boolean = False): String;
Begin
  case APerfi of
    cjpPEF: Result := '_ENT_PEF';
    cjpPEJ: Result := '_ENT_PEJ';
    cjpPER: Result := '_ENT_PER';
    cjpPES: Result := '_ENT_PES';
    cjpPSI: Result := '_ENT_PSI';
    cjpPII: Result := '_ENT_PII';
    cjpNCO: Result := '_SAI_NCO';
    cjpCCO: Result := '_SAI_CCO';
    cjpCNC: Result := '_SAI_CNC';
    cjpSNA: Result := '_SAI_SNA';
    cjpCTA: Result := '_SAI_CTA';
    cjpPRU: Result := '_SAI_PRU';
    cjpIND: Result := '_SAI_IND';
    cjpTRS: Result := '_SAI_TRS';
  end;
End;


function fGetPerfilItem(APerfil: String): TPerfil;
begin
  Result := cjpIndef;
  If VersaoAutcomApi = 72 Then
  Begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS_72) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       6 : Result := cjpNCO;
       7 : Result := cjpCCO;
       8 : Result := cjpCNC;
       9 : Result := cjpSNA;
      10 : Result := cjpCTA;
      11 : Result := cjpPRU;
      12 : Result := cjpPRU;
      13 : Result := cjpTRS;
    end;
  End
  Else
  begin
    case AnsiIndexStr(UpperCase(APerfil), PERFIS_ICMS) of
       0 : Result := cjpPEF;
       1 : Result := cjpPEJ;
       2 : Result := cjpPER;
       3 : Result := cjpPES;
       4 : Result := cjpPSI;
       5 : Result := cjpPII;
       6 : Result := cjpNCO;
       7 : Result := cjpCCO;
       8 : Result := cjpCNC;
       9 : Result := cjpSNA;
      10 : Result := cjpCTA;
      11 : Result := cjpPRU;
      12 : Result := cjpPRU;
      13 : Result := cjpTRS;
    end;
  End;
End;


function fGetConjPerfis(strPerfil: string): TConjPerfis;
begin
 If VersaoAutcomApi = 72 Then
  Begin
    case AnsiIndexStr(UpperCase(strPerfil), PERFIS_ICMS_72) of
       0 : Result := [cjpPEF];
       1 : Result := [cjpPEJ];
       2 : Result := [cjpPER];
       3 : Result := [cjpPES];
       4 : Result := [cjpPSI];
       5 : Result := [cjpNCO];
       6 : Result := [cjpCCO];
       7 : Result := [cjpCNC];
       8 : Result := [cjpSNA];
       9 : Result := [cjpCTA];
      10 : Result := [cjpPRU];
      11 : Result := [cjpIND];
      12 : Result := [cjpTRS];
    end;
  End
  Else
  Begin
    case AnsiIndexStr(UpperCase(strPerfil), PERFIS_ICMS) of
       0 : Result := [cjpPEF];
       1 : Result := [cjpPEJ];
       2 : Result := [cjpPER];
       3 : Result := [cjpPES];
       4 : Result := [cjpPSI];
       5 : Result := [cjpPII];
       6 : Result := [cjpNCO];
       7 : Result := [cjpCCO];
       8 : Result := [cjpCNC];
       9 : Result := [cjpSNA];
      10 : Result := [cjpCTA];
      11 : Result := [cjpPRU];
      12 : Result := [cjpIND];
      13 : Result := [cjpTRS];
    end;

  End;
end;

function fPerfilEntrada(APerfil: String): Boolean;
var ConjPerfil: TPerfil;
begin
  ConjPerfil := fGetPerfilItem(APerfil);
  Result :=  (ConjPerfil in [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII]);
End;


function fPerfilSaida(APerfil: String): Boolean;
var ConjPerfil: TPerfil;
begin
  ConjPerfil := fGetPerfilItem(APerfil);
  Result :=  (ConjPerfil in [cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS]);
End;

function fPerfilEntrada(APerfil: TPerfil): Boolean;
begin
  Result := (APerfil in [cjpPEF, cjpPEJ, cjpPER, cjpPES, cjpPSI, cjpPII]);
End;


function fPerfilSaida(APerfil: TPerfil): Boolean;
begin
  Result := (APerfil in [cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS]);
End;


function fSeperaPefis(ConjPerfis: TConjPerfis; blnEntrada: Boolean): TConjPerfis;
var  PefisEntrada: TConjPerfis;
     PefisSaida: TConjPerfis;
     Perfil: TPerfil;
Begin
  PefisEntrada := [];
  PefisSaida   := [];

  For Perfil in ConjPerfis do
  Begin
    If Perfil in [cjpNCO, cjpCCO, cjpCNC, cjpSNA, cjpCTA, cjpPRU ,cjpIND, cjpTRS] Then
       PefisSaida := PefisSaida +  [Perfil]
    Else
       PefisEntrada := PefisEntrada +  [Perfil];

  End;

  If blnEntrada Then
    Result :=  PefisEntrada
  Else
    Result :=  PefisSaida
End;

function fSplit(ALista: String): TArrOfString;
var objLista: TStringList;
    i: integer;
begin
  objLista := TStringList.Create;
  Try
    objLista.Delimiter := ',';
    objLista.CommaText := ALista;
    SetLength(Result, objLista.Count);
    For i := 0 To Pred(objLista.Count) do
     Result[i] := objLista[i];
  finally
    FreeAndNil(objLista);
  End;
End;

function fRetConUF(strUF: String): TConjUnidadesFederativas;
begin
  Result := [];
  case AnsiIndexStr(UpperCase(strUF), UNIDESFEDERATIVA) of
     0 : Result := [ufAC];
     1 : Result := [ufAL];
     2 : Result := [ufAM];
     3 : Result := [ufAP];
     4 : Result := [ufBA];
     5 : Result := [ufCE];
     6 : Result := [ufDF];
     7 : Result := [ufES];
     8 : Result := [ufGO];
     9 : Result := [ufMA];
    10 : Result := [ufMG];
    11 : Result := [ufMS];
    12 : Result := [ufMT];
    13 : Result := [ufPA];
    14 : Result := [ufPB];
    15 : Result := [ufPE];
    16 : Result := [ufPI];
    17 : Result := [ufPR];
    18 : Result := [ufRJ];
    19 : Result := [ufRN];
    20 : Result := [ufRO];
    21 : Result := [ufRR];
    22 : Result := [ufRS];
    23 : Result := [ufSC];
    24 : Result := [ufSE];
    25 : Result := [ufSP];
    26 : Result := [ufTO];
  End;
End;


function fRetStringUF(Estado: TUnidadesFederativas): string;
Begin
  Result := '';
  case Estado of
    ufAC: Result := 'AC';
    ufAL: Result := 'AL';
    ufAP: Result := 'AP';
    ufAM: Result := 'AM';
    ufBA: Result := 'BA';
    ufCE: Result := 'CE';
    ufES: Result := 'ES';
    ufGO: Result := 'GO';
    ufMA: Result := 'MA';
    ufMT: Result := 'MT';
    ufMS: Result := 'MS';
    ufMG: Result := 'MG';
    ufPA: Result := 'PA';
    ufPB: Result := 'PB';
    ufPR: Result := 'PR';
    ufPE: Result := 'PE';
    ufPI: Result := 'PI';
    ufRJ: Result := 'RJ';
    ufRN: Result := 'RN';
    ufRS: Result := 'RS';
    ufRO: Result := 'RO';
    ufRR: Result := 'RR';
    ufSC: Result := 'SC';
    ufSP: Result := 'SP';
    ufSE: Result := 'SE';
    ufTO: Result := 'TO';
    ufDF: Result := 'DF';
  end;

End;


function fLocalizaRecDadosICMS(strEstado: String; StrCaracTrib: String; ArrRecICMSt: TArrRecICMS): TRecDadosICMS;
var   RecDadosICMS: TRecDadosICMS;
Begin
  for RecDadosICMS in ArrRecICMSt do
   If RecDadosICMS.strUF =  strEstado Then
     if RecDadosICMS.Codigo = StrCaracTrib then
     begin
       Result := RecDadosICMS;
       Result.blnEncontrou := True;
       Exit(Result);
     End;
   Result.blnEncontrou := False;

End;

function fRemoveVirgula(Value: String): String;
begin
  Result := AnsiReplaceStr(Value, ',', '.');
End;


function fValidaPrfSanPreenchida(AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): Boolean;
begin
  AQry.SQL.Clear;
  AQry.SQL.Add('SELECT * FROM PRFSAN');
  AQry.Open;
  Result := Not AQry.IsEmpty;

End;


function fValidaCaracTribPreenchida(AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): Boolean;
begin
  AQry.SQL.Clear;
  AQry.SQL.Add('SELECT * FROM IMENDES_CARACTRIB');
  AQry.Open;
  Result := Not AQry.IsEmpty;

End;

function fServicoUP(AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): Boolean;
begin
  AQry.SQL.Clear;
  AQry.SQL.Add('SELECT LOG_ID,');
  AQry.SQL.Add('       LOGCON ');
  AQry.SQL.Add('  FROM IMENDES_LOGCON ');
  AQry.SQL.Add('   WHERE STOP_PROCESS = "N"');
  AQry.SQL.Add('   AND (SELECT COUNT(1) FROM INFORMATION_SCHEMA.PROCESSLIST WHERE ID = IMENDES_LOGCON.LOGCON) > 0');
  AQry.Open;
  Result := Not AQry.IsEmpty;
End;

function fImendesNow(): TDateTime;
begin
  {$IFDEF IMENDES_32}
  Result := fNow
  {$ELSE}
  Result := VS_Date + fTime;
  {$ENDIF}
end;

function iMendesRetAutoincrem({$IFNDEF LINUX}conexao: TUniConnection; {$ENDIF} strTabela: String; strCodEmp: String): string;
var qryAutoincrem: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
begin
  qryAutoincrem:= iMendesCriaQuery({$IFNDEF LINUX}conexao{$ENDIF});
  Try
    qryAutoincrem.SQL.Add('SELECT CONCAT("'+strCodEmp+'",LPAD(PRO_AUTINC, 14, "0"),"'+strCodEmp+'") AS INCFOR, PRO_AUTINC  FROM PROINC WHERE PRO_NOMARQ = "' + strTabela + '"');
    qryAutoincrem.Open;
    Result := qryAutoincrem.FieldByName('INCFOR').ASString;
    qryAutoincrem.SQL.Text := 'UPDATE PROINC SET  PRO_AUTINC = PRO_AUTINC + 1 WHERE PRO_NOMARQ = "' + strTabela + '"';
    qryAutoincrem.ExecSQL;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryAutoincrem);
  {$ENDIF}
  End;
End;

function GetNewID(Prefix: String): string;
var
  reg: array [1 .. 7] of word;
  i: integer;
begin
  { EDIT: Vou por mais estas linhas abaixo, para que o prefixo nunca
  tenha mais de 2 caracteres, e assim fique fixo o tamanho 16 bytes  }
  if length(Prefix) > 2 then
    Prefix := Copy(Prefix, 1, 2)
  else
    while length(Prefix) < 2 do
      Prefix := ' ' + Prefix;

  Result := '';
  DecodeDate(Date, reg[1], reg[2], reg[3]);
  reg[1] := StrToInt(Copy(IntToStr(reg[1]), 3, 2));

  { Esta corrige o ano para apenas dois digitos, por forma a ser inferior a
  255. em vez de reg[1] estava a variavel ano. }
  DecodeTime(Time, reg[4], reg[5], reg[6], reg[7]);
  reg[7] := reg[7] div 4; // esta corrige os milisegundos
  randomize;
  for i := 1 to 7 do
  begin
    if (i >= 2) and (i <= 6) then
      reg[i] := reg[i] + random(100);

    { O random é uma segurança adicional, pois como o ano e os milisegundos não
    são usados na totalidade, havia uma pequena possibilidade de sair
    duplicado... Assim é quase impossivel }
    Result := Result + IntToHex(reg[i], 2);
  end;
  Result := Prefix + Result;
end;

function fRetMaxThreadAtivas: integer;
var res: string;
  LFile: TIniFile;
begin
  res := TPath.Combine(GetCurrentDir, 'opcoes.ini');
  LFile := TIniFile.Create(res{$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  Try
    res := LFile.ReadString('IMENDES', 'QTD_THREAD_ATIVAS', '' );
  Finally
    LFile.Free;
  End;
  If res = '' Then
    Result := 30
  Else
    Result := StrToInt(res);

end;

function fContadorDeRequisicaoAtivado: Boolean;
var res: string;
  LFile: TIniFile;
begin
  res := TPath.Combine(GetCurrentDir, 'opcoes.ini');
  LFile := TIniFile.Create(res{$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  Try
    Result := LFile.ReadString('IMENDES', 'CONTADOR_REQUISICAO', '') = 'S';
  Finally
    LFile.Free;
  End;
end;



function fValidaEan13(strGTIN : String) : Boolean;
  Var
    intCnt, intSoma, intResultado, intBase10: Integer;
begin
  //Verifica se todos os caracteres de strGTIN são números
  for intCnt:= 1 to Length(strGTIN) do
  begin
    if not {$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)}(CharInSet(strGTIN[intCnt], ['0'..'9'])){$ELSE}(strGTIN[intCnt] in ['0'..'9']){$IFEND} Then
    begin
      Result:= False;
      Exit;
    end;
  end;
  //Verifica se strGTIN tem o tamanho necessário
  if Length(strGTIN) in [8,12,13,14] then
  begin
    intSoma:= 0;
    for intCnt:= 1 to (Length(strGTIN) -1) do
    begin
      if Length(strGTIN) = 13 then
      begin
        if Odd(intCnt) then
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 1)
        else
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 3);
      end
      else
      begin
        if Odd(intCnt) then
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 3)
        else
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 1);
      end;
    end;
    intBase10:= intSoma;
    //Verifica se intBase10 é múltiplo de 10
    if not (intBase10 mod 10 = 0) then
    begin
      while not (intBase10 mod 10 = 0) do
      begin
        intBase10:= intBase10 + 1;
      end;
    end;
    intResultado:= intBase10 - intSoma;
    //Verifica se o intResultado encontrado é igual ao caractere de controle
    if intResultado = strtoint(strGTIN[Length(strGTIN)]) then
      Result:= True
    else
      Result:= False;
  end
  else
    Result:= False;

  if Result then
    Result := fValidaEanTamanhoEInicio(strGTIN);
End;

function fValidaEanTamanhoEInicio(aGtin: String): Boolean;
var Inicio3: String;
    Inicio4: String;
begin
  Result := True;

  if  (Length(aGtin) = 13) or (Length(aGtin) = 14)  then
  Begin
    Result := False;
    Inicio3 := Copy(aGtin, 1, 3);
    Inicio4 := Copy(aGtin, 2, 3);
    if Length(aGtin) = 13 then
    begin
      Result := Pos(Inicio3 , PrefixosValidosCodigoBarra ) > 0;
      Exit;
    End
    Else
    if Length(aGtin) = 14 then
    begin
      Result := (Pos(Inicio3 , PrefixosValidosCodigoBarra) > 0) or (Pos(Inicio4 , PrefixosValidosCodigoBarra) > 0);
      Exit;
    End;
  End;
End;

procedure pIniciaNotificacaoTemporizada;
var MinutosParado: integer;
begin
    TThread.CreateAnonymousThread(
    procedure
    begin
      while blnNotificaExecucao do
      begin
        If blnControlaTempoExecucao Then
        Begin
          MinutosParado:= MinutesBetween(fImendesNow, TempoUltimaExecucao);
          if MinutosParado >= 1 then
          Begin
            pEscreveLog('Serviço parado a mais de ' + MinutosParado.ToString+ '  minutos', True) ;
            if MinutesBetween(fImendesNow, TempoUltimaExecucao) >= 2 then
              Halt(0);
          End;
        End;

        pEscreveLog(' Executando: Versão do Serviço ' + VersaoApi, True) ;
        TThread.Sleep(30000);
      End;
    end).Start;
end;


procedure pEscreveLog(Value: String; AForceLog: Boolean = False; ASize: Integer = -1);
begin

  If HasParam('--logsactive') or AForceLog Then
  Begin
    {$IFDEF LINUX}
    WriteLog(Value, AForceLog, ASize);
    {$ELSE}
    Writeln(Value);
    {$ENDIF}
  End;
End;

function fRetComplementoDescricao(APerfil: TPerfil; AQry: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF}): String;
begin
  AQry.SQL.Clear;
  AQry.SQL.Add(' SELECT RPAD(CONCAT("(", PRF_CODIGO, ")", IMENDES_CARACTRIB.DESCRICAO),  26, " ") AS CARACTRIB, ');
  AQry.SQL.Add('        RPAD(CONCAT("(", PRF_FINALI, ")", IMENDES_FINALIDADE.DESCRICAO), 20, " " ) AS FINALIDADE ');
  AQry.SQL.Add('   FROM PRFSAN ');
  AQry.SQL.Add('  INNER JOIN IMENDES_FINALIDADE ON IMENDES_FINALIDADE.ID = PRF_FINALI ');
  AQry.SQL.Add('  INNER JOIN IMENDES_CARACTRIB ON IMENDES_CARACTRIB.ID = PRF_CODIGO ');
  AQry.SQL.Add('WHERE PRF_PERFIL = "'+  fConvertConfPerfilToString(APerfil)+'"');
  AQry.Open;

  Result := AQry.FieldByName('CARACTRIB').AsString + ' ' + AQry.FieldByName('FINALIDADE').AsString;
End;

procedure pAtualizaTemporizador(var AVariaveisDeControle: TVariaveisDeControle; procSEQCON: String);
var iExt, qtdSegundos: integer;
    ValidacoesPorSegundo: Double;
    arrValidacoesPorSegundoMedia: array[1..10] of Double;
    ValidacoesPorSegundoMedia: Double;
    TempoExtimado: String;
    locVariaveisDeControle:  TVariaveisDeControle;
    blnArrayMediaCompleto: Boolean;
    qryInterna: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF};
    conInterna: {$IFDEF LINUX}IConnection{$ELSE}TUniConnection{$ENDIF};
   {$IFDEF LINUX}
    LConnID: NativeUInt;
   {$ENDIF}
begin
  AVariaveisDeControle.FinalizaTemporizador := False;
  locVariaveisDeControle := AVariaveisDeControle;
  ValidacoesPorSegundo := 0;
  For iExt := 1 To 10 do
    arrValidacoesPorSegundoMedia[iExt] := 0;
  TThread.CreateAnonymousThread(
  procedure
  var i: integer;
  begin
    Try
     {$IFDEF LINUX}
      LConnID := Random(999999);
      conInterna := objConnectionsManager.BeginConnection(LConnID);
      qryInterna := conInterna.CreateQuery();
     {$ELSE}
      conInterna := iMendesCriaConnection;
      conInterna.Open;
      qryInterna := iMendesCriaQuery(conInterna);
     {$ENDIF}


      while Not locVariaveisDeControle.FinalizaTemporizador do
      Begin
        if ValidacoesPorSegundo = 0 then
          Sleep(1000)
        Else
          Sleep(5000);

        locVariaveisDeControle.SessaoCritica.Enter;
        Try
          Try
            qtdSegundos := SecondsBetween(fImendesNow, locVariaveisDeControle.DataHoraIncio);
            ValidacoesPorSegundo := locVariaveisDeControle.intQtdRegistrosProcessados/qtdSegundos;
            For i := 1 To  10 do
            begin
              If arrValidacoesPorSegundoMedia[i] = 0 Then
                arrValidacoesPorSegundoMedia[i] := ValidacoesPorSegundo;
            End;

            For i := 1 To 10 do
            begin
              blnArrayMediaCompleto := arrValidacoesPorSegundoMedia[i] > 0;
              If Not blnArrayMediaCompleto Then
                break;
            End;


            ValidacoesPorSegundoMedia := 0;
            If blnArrayMediaCompleto Then
            Begin
              For i := 1 To 9 Do
               arrValidacoesPorSegundoMedia[i] := arrValidacoesPorSegundoMedia[i + 1];

              arrValidacoesPorSegundoMedia[10] :=  ValidacoesPorSegundo;
              For i := 1 To 10 do
                ValidacoesPorSegundoMedia := ValidacoesPorSegundoMedia + arrValidacoesPorSegundoMedia[i];

              ValidacoesPorSegundoMedia := ValidacoesPorSegundoMedia /10;
              ValidacoesPorSegundo := ValidacoesPorSegundoMedia;
            End;

            If ValidacoesPorSegundo > 0 Then
            Begin
              TempoExtimado := locVariaveisDeControle.fTrataTextoTempo(Trunc((locVariaveisDeControle.intQtdRegistros -
                                                                            locVariaveisDeControle.intQtdRegistrosProcessados)/ValidacoesPorSegundo));
              TempoExtimado := 'Qtd. Por Segundo: ' + FormatFloat('#0.00', ValidacoesPorSegundo) + ' Tempo Estimado: '  + TempoExtimado;

              locVariaveisDeControle.DataHoraUltimaAtualizacao := fImendesNow;

            End
            Else
              TempoExtimado := 'Calculando tempo extimado';

            pEscreveLog(TempoExtimado, HasParam('--logsactive'));
            qryInterna.SQL.Clear;
            qryInterna.SQL.Add('UPDATE IMENDES_PARAM SET TEMPO_ESTIMADO = "'+TempoExtimado+'" WHERE AUTOINCREM = "'+procSEQCON+'"');
            qryInterna.ExecSQL;

          Except
            on e: Exception do
              pEscreveLog('pAtualizaTemporizador ' +  e.message);
          End;
        Finally
          locVariaveisDeControle.SessaoCritica.Leave;

        End;
      End;
    Finally
      {$IFDEF LINUX}
      objConnectionsManager.EndConnection(LConnID);
     {$ELSE}
      FreeAndNil(qryInterna);
      FreeAndNil(conInterna);
     {$ENDIF}
    End;
  end).Start;
end;

function GetMacAddress: String;
var
{$IFDEF LINUX}
  I: Integer;
  LParse: TArray<string>;
{$ELSE }
  Librpcrt4: Cardinal;
  GUID1, GUID2: TGUID;
  Func: Function(GUID: PGUID): Longint; stdcall;
{$ENDIF LINUX}
Begin
	{$IFDEF LINUX}
  Result := '';
  LParse := ShellExecute('ifconfig').Split([' ']);
  For I := Low(LParse) To High(LParse) Do
    If LParse[I].Equals('HW') Or LParse[I].Equals('HWaddr') Then
      Exit(LParse[succ(I)]);
	{$ELSE }
  Result := '';
  Librpcrt4 := LoadLibrary('rpcrt4.dll');
  If not (Librpcrt4 = 0) Then
  Try
     @Func := GetProcAddress(Librpcrt4, 'UuidCreateSequential');
     If Assigned(Func) Then
     Begin
       If (Func(@GUID1) = 0) and
          (Func(@GUID2) = 0) and
          (GUID1.D4[2] = GUID2.D4[2]) and
          (GUID1.D4[3] = GUID2.D4[3]) and
          (GUID1.D4[4] = GUID2.D4[4]) and
          (GUID1.D4[5] = GUID2.D4[5]) and
          (GUID1.D4[6] = GUID2.D4[6]) and
          (GUID1.D4[7] = GUID2.D4[7]) Then
       Begin
         Result :=
           IntToHex(GUID1.D4[2], 2) + '-' +
           IntToHex(GUID1.D4[3], 2) + '-' +
           IntToHex(GUID1.D4[4], 2) + '-' +
           IntToHex(GUID1.D4[5], 2) + '-' +
           IntToHex(GUID1.D4[6], 2) + '-' +
           IntToHex(GUID1.D4[7], 2);
       end;
     end;
  Finally
    FreeLibrary(Librpcrt4);
  end;
	{$ENDIF LINUX}
end;


function GetIPAddressAsString: String;
{$IFNDEF LINUX}
var
  tempAddress: Integer;
  Buffer: array[0..3] of Byte absolute tempAddress;
  data: Winapi.WinSock.WSAData;
{$ENDIF LINUX}
begin
{$IFDEF LINUX}
  Result := ShellExecute('hostname -I | cut -f1 -d" "');
{$ELSE }
  WSAStartup(2, data);
  tempAddress := GetIPAddress;
  Result := Format('%d.%d.%d.%d', [Buffer[3], Buffer[2], Buffer[1], Buffer[0]]);
  WSACleanup;
{$ENDIF LINUX}
end;

function GetIPAddress: Integer;
{$IFNDEF LINUX}
var
  Buffer: array[0..255] of AnsiChar;
  RemoteHost: PHostEnt;
{$ENDIF LINUX}
begin
{$IFDEF LINUX}
  Result := strToIntDef(ShellExecute('hostname -I | cut -f1 -d" "'), 0);
{$ELSE }
  Winapi.WinSock.GetHostName(@Buffer, 255);
  RemoteHost := Winapi.WinSock.GetHostByName(Buffer);
  if RemoteHost = nil then
    Result := Winapi.WinSock.htonl($07000001) { 127.0.0.1 }
  else
    Result := longint(pointer(RemoteHost^.h_addr_list^)^);
  Result := Winapi.WinSock.ntohl(Result);
{$ENDIF LINUX}
end;

function GetUserFromWindows: string;
{$IFNDEF LINUX}
Var
   UserName : string;
   UserNameLen : Dword;
{$ENDIF LINUX}
Begin
{$IFDEF LINUX}
  Result := ShellExecute('whoami');
{$ELSE }
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   If GetUserName(PChar(UserName), UserNameLen) Then
     Result := Copy(UserName,1,UserNameLen - 1)
   Else
     Result := 'Unknown';
{$ENDIF LINUX}
End;

function fRetNomeRede: String;
{$IFNDEF LINUX}
Var
  strNome: PAnsiChar;
  strComp: String;
  intContador: Integer;
  wsa: TWSAData;
{$ENDIF LINUX}
begin
{$IFDEF LINUX}
  Result := ShellExecute('hostname');
{$ELSE }
  strNome := PAnsiChar(AnsiString(String(fstrEspaco('', 100))));

  //SetLength(strNome, 100);

  WSAStartup(2, wsa);
  gethostname(strNome, 100);
  intContador := 0;
  while (strNome[intContador] <> ' ') And
        (strNome[intContador] <> #0)  Do
  Begin
    strComp := strComp + String(strNome[intContador]);
    Inc(intContador);
  end;
  Result := strComp;
  WSACleanup;
{$ENDIF LINUX}
end;

function IfThenImendes(Value: Boolean; ATrue, AFalse: Double): Double;
begin
  If Value Then
    Result := ATrue
  Else
    Result := AFalse;
End;


function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
Var
	I:integer;
Begin
  Case intPos Of
  	1:For I := Length(Str) To Tamanho -1 Do
		  	Str:= Str + ' ';
    2:For I := Length(Str) To Tamanho -1 Do
    		Str := ' ' + Str;
  End;
  fStrEspaco := Str;
End;

function Transform(AConteudo: String; AStep: Shortint; AChar: String): String;
  Var
    LAux       : String;
    LPosicao   : Integer;
    LTamanho   : Integer;
begin
  LAux := '';

  LPosicao := 1;
  LTamanho := Length(AConteudo);

  If (AStep = 1) Then
    LTamanho := LTamanho + 1;

  While LPosicao < LTamanho Do
  Begin
    LAux := LAux + Copy(AConteudo, LPosicao, AStep) + AChar;
    Inc(LPosicao, AStep);
  End;

  Result := LAux;

end;



initialization
  VS_MacAddress        := GetMacAddress;
  VS_IPAddressAsString := GetIPAddressAsString;
  VS_UserFromWindows   := GetUserFromWindows;
  VS_ComputerNetName   := fRetNomeRede;


End.
