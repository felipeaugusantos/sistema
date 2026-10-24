unit untUtil;

interface

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN SYMBOL_PLATFORM OFF}

uses
  SysUtils, Classes, Math,
{$IF Defined(UNIDAC)}
  Uni, UITypes,
{$ELSE}
  ZConnection, ZDataset, ZDbcIntfs,
{$IFEND}
{$IF Defined(LINUX)}
  Posix.Base,
  Posix.Fcntl,
  Posix.Unistd,
  Posix.Stdlib,
  Posix.SysStat,
  Posix.SysTypes,
  Posix.Signal,
  NFe.Modulo,
  System.Types,
  System.IOUtils,
  System.NetEncoding,
  IdCoderMIME,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Forms,
  FMX.frxDelphiZXingQRCode,
{$ELSE}
  Registry,
  ShellApi,
  WinSock,
  Winspool,
  Windows, untModulo, JPeg,
  Graphics, Printers,
  Dialogs, Forms, Controls,
  frxDelphiZXingQRCode,
{$IFEND}
  untDicSis,
  StrUtils,
  IniFiles,
  MaskUtils,
  DB,
  DBClient,
  DateUtils,
  XMLIntf,
  Faturamento.Classes.CNPJ;

type
  TImageSize = (Bytes, KB, MB);
  TTipoNFS = (nfsXML, nfsTXT, nfsJSON);

{$IF Defined(LINUX)}
  TStreamHandle = pointer;
{$IFEND}

  function fEmptyStr(const AString: String) : Boolean;
  function IfEmptyStr(const AString, AStringDefault: String): String;
  function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;

  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True;
                               blnTiraTraEsp : Boolean = False): String;

  procedure pConfiguraOpcoesRegionais;

  function fRetNomeRede: String;

  function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
  function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;

  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fPathOpcoesIni: String;

  procedure pAbrirBanco(Var frmModulo: TfrmModulo);
  procedure pConectarBanco(frmModulo: TfrmModulo);
  procedure pDefinirCharsetConexao;
  procedure pFecharBanco(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});

  function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
  function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
  Function fNextAutoIncrem(strAutInc: String): String;

  Function fRetEmpresaFisica: String;

  function fCriaQuery(AOwner: TComponent = Nil; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

  function fCfgSis(ACodCfg: string; ACodEmp: String = '') : string;

  function fGetMD5(AValue: String): String;

  function fNow: TDateTime;

  function fCurrentTime: String;
  function fCurrentDate: String; Overload;
  function fCurrentDate(Const Value: TDateTime): String; Overload;
  function fCurrentDateTime: String; Overload;
  function fCurrentDateTime(Const Value: TDateTime): String; Overload;
  function fFormataCpfCgc(strValor: String; strEstado: String = ''): String;
  function fFormataCEP(strCEP: String): String;
  function fFormataFone(strFone: String): String;
  function fFormataFonePais(strTelefo: String): String;
  function fTiraCaracEspeciaisPonto(strTexto: String): String;
  function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  function fTestaCgc(xCGC: String):Boolean;
  function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant; overload;
  function IIF(lTest:Boolean; vExpr1,vExpr2:TObject):TObject; overload;
  function fStringRepetida(Const strString: String): Boolean;
  function fValidaCPF(sCPF: string):Boolean;
  function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
  function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  {$IF Defined(LINUX)}
  function StreamToBase64(AStream: TStream): string;
  function fRetornarArquivoBase64(const ACaminhoArquivo: String): String;
  {$IFEND}
  function fStringToStream(strString: String):TStringStream;
  function fStringToStreamDanfe(const strString: string): TStringStream;
  function fBooleanToString(const blnValue: Boolean): String;
  function fFormataCondPag(strCond: String): String;
  function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
  function fStatusCndPag(strCndPag: String): Integer;
  function fStrZero(Zeros:string;Quant:integer):String;
  function fFormataInscricaoEstadual(strInsEst: string): string;
  procedure pLog(strValor: String);
  procedure pLogImp(const strValor: String; blnDeleta: Boolean=False);
  function fGetValorLinha(ALinha, ADelimitador: String; AColuna: Integer; AIgnoraPrimeiro: Boolean=False): String;
  function fRetSomenteNumeros(strTexto: String): String;
  function StringInSet(const S: String; const StringSet: array of String): Boolean;
  function RetornaTexto(Texto, sText1, sText2: String): String;
  function fCampoTabela(strCampo, strNomTab: String; arrCampoChave: array of String; arrValorChave: array of Variant): Variant;
  function fCampoExiste(const strTabela, strCampo: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
  function fTabelaExiste(const strTabela: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
  function fRetiraNumeroStr(const strTexto: String): String;
  function ImageSize(ASender: TBitmap; AImageSize: TImageSize): Integer;
{$IFDEF LINUX}
  procedure ResizeBitmapProportional(var Bitmap: TBitmap; MaxWidth, MaxHeight: Integer);
{$ELSE}
  procedure ResizeImage(bmpOrigem: TBitmap; AMaxSize: Integer; AImageSize: TImageSize; const AOutFile: string); overload;
  procedure ResizeImage(bmpOrigem: TBitmap; const ANewWidth : Integer; const AOutFile: string); overload;
  function ShellExecuteAndWait(Operation, FileName, Parameter, Directory: String; Show: Word; bWait: Boolean): Longint;
{$ENDIF}
  function KillProcess(pid: cardinal): Boolean;
  procedure pCriarDiretorioDanfeEnotasCasoNaoExista;
  function fDiretorioDanfeEnotas: String;
  function fRetNomeArquivoPDFtoPrinter: String;
  function GetCurrentProcessId: Integer;
  function GetComputerNetName: string;
  function GetUserFromWindows: string;
  function GetIPAddress: Integer;
  function GetIPAddressAsString: string;
  function GetMacAddress: string;

{$if not defined(LINUX)}
  function VerImpressoraONLINE(impressora: String): Cardinal;
  function fGerarQRCode(strTexto: String): TBitmap;
{$else}
  function fGerarQRCode(strTexto: String): FMX.Graphics.TBitmap;
{$endif}

  function fRetornaValor( strValor: String ) : Double;
  function fExistePdfNfe(AChaveAcesso: String): Boolean;
  function fAplicaFusoHorarioENotas(strHoraEmissao, strFusoHorario: string; var strDataEmissao: string) : string;
  procedure DefinirTimeZoneEmSessaoMySql(const ACodigoEmpresa : String);
  function CfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String): String;
  function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  procedure pPegaDataHoraSistema(Var dtaDtaSis, dtaHraSis : TDateTime);
  function fRetornaValorTagXml(ATag: IXMLNode) : String;
  function fStrToFloatDef(strValor: String) : Double;
  function fRetDescClassificacaoServico(strCodigo: string): string;
  function fCalculaPorcentagem(fltNumUm, fltNumDois: Double): Double;
  function fExisteConfiguracao(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; strCodEmp: String = ''): Boolean;

{$IFDEF LINUX}
  function Application: TApplication;
  function fGetUniqueTempPath(const AExt: string = '.tmp'): string;
{$ENDIF}
  function fRetDiaVencimentoISS( Const dtaOrigem: TDateTime; qtdDias: Integer ): TDateTime;
  function fRetNumeroRps(strNumDoc: string): string;

{$IFDEF MSWINDOWS}
  function MessageBoxTimeOut(hWnd: hWnd; lpText: PChar; lpCaption: PChar; uType: UINT; wLanguageId: WORD; dwMilliseconds: DWORD): Integer; stdcall; external user32 name 'MessageBoxTimeoutW';
  procedure ShowInfoMsgTimeout(const ATitle, AMsg: string; TimeoutMS: Cardinal);
  procedure ShowErrorMsgTimeout(const ATitle, AMsg: string; TimeoutMS: Cardinal);
{$ENDIF}
  procedure pGravaLogErr(const strDescri, strValRel: WideString; blnVerificarSeJaGravouHoje: Boolean=False);

const
  A_VISTA = 1;
  A_PRAZO = 2;
 {$IFDEF LINUX}
  PATH_SEPARATOR = '/';
 {$ELSE}
  PATH_SEPARATOR = '\';
 {$ENDIF}
  STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#@!';
  STR_CHAR_TROCA = 'ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£#ª°';
  DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION = ' SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; ';

Var
  VS_strTabelaErro: String;
  VS_stlTabNre: TStringList;
  VS_LogRepCodOp  : String;
  VS_strCodEmp    : String;
  VS_PathSat      : String;

implementation

uses
  {$IF Defined(UNIDAC)}
    untModuloReplicacao, untLogDanfe
  {$ELSE}
    untModuloReplicacaoZeos
  {$IFEND};

{$IF Defined(LINUX)}
function popen(const command: MarshaledAString; const _type: MarshaledAString)
  : TStreamHandle; cdecl; external libc name _PU + 'popen';

function pclose(filehandle: TStreamHandle): int32; cdecl;
  external libc name _PU + 'pclose';

function fgets(buffer: pointer; size: int32; Stream: TStreamHandle): pointer;
  cdecl; external libc name _PU + 'fgets';

function BufferToString(buffer: pointer; MaxSize: uint32): string;
var
  cursor: ^uint8;
  EndOfBuffer: nativeuint;
begin
  Result := '';
  if not assigned(buffer) then
  begin
    exit;
  end;
  cursor := buffer;
  EndOfBuffer := nativeuint(cursor) + MaxSize;
  while (nativeuint(cursor) < EndOfBuffer) and (cursor^ <> 0) do
  begin
    Result := Result + chr(cursor^);
    cursor := pointer(succ(nativeuint(cursor)));
  end;
end;

function ShellExecute(AComand: String): String;
Var
  Handle: TStreamHandle;
  Data: array [0 .. 511] of uint8;
  stlRetorno: TStringList;
  M: TMarshaller;
Begin
  Try
    stlRetorno := TStringList.Create;
    Handle := popen(M.AsAnsi(PWideChar(AComand)).ToPointer, 'r');
    Try
      While fgets(@Data[0], Sizeof(Data), Handle) <> Nil Do
      Begin
        stlRetorno.Add(BufferToString(@Data[0], Sizeof(Data)));
      End;
    Finally
      Result := stlRetorno.Text;
      pclose(Handle);
    End;

    If assigned(stlRetorno) Then
      FreeAndNil(stlRetorno);
  Except
    On E: Exception Do
    Begin
      Writeln(E.ClassName + ': ' + E.Message);
      If assigned(stlRetorno) Then
        FreeAndNil(stlRetorno);
    End;
  End;
End;
{$IFEND}

{**********************************************************}
{* LÍ/Grava dados no arquivo de Configuracao (Opcoes.ini) *}
{*******************************************************DV*}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If fEmptyStr(strNomArq) Then
  Begin
    strNomArq := PATH_SEPARATOR + 'opcoes.ini';
    iniArqIni := TIniFile.Create(ExtractFilePath(ParamStr(0) + strNomArq) {$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  End
  else
  begin
    If fEmptyStr(ExtractFilePath(strNomArq)) Then
      strNomArq := ExtractFilePath(ParamStr(0)) +  strNomArq;
    if not FileExists(strNomArq) then
      strNomArq := strNomArq + PATH_SEPARATOR + 'opcoes.ini';
    iniArqIni := TIniFile.Create(strNomArq {$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  end;

  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

{*****************************************}
{* RETIRA CARACTERES ESPECIAIS DE UMA    *}
{* STRING                                *}
{**************************************MV*}
function fTiraCaracEspeciais(strTexto      : String;
                             blnUsaLista   : Boolean = True;
                             blnTiraEspacos: Boolean = False;
                             blnTiraPontos : Boolean = False;
                             blnTiraDoisPts: Boolean = False;
                             blnTiraTab    : Boolean = False;
                             blnTiraVirgula: Boolean = True;
                             blnTiraTraEsp : Boolean = False): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*™∫∞&"''()%$®@!?ß={}[]¥`^~π≤≥£¢ÿ'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos) Then
    strLista := strLista + ' ';

  If (blnTiraPontos) Then
    strLista := strLista + '.';

  If (blnTiraDoisPts) Then
    strLista := strLista + ':';

  If (blnTiraTab) Then
    strLista := strLista + #9;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸Á¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹«';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    //Remove os caracteres de controle (0 - 31)
    If (strTexto[intContador] <  #32) And
       (strTexto[intContador] <> #13) And
       (strTexto[intContador] <> #10) Then
      Continue;

    //Remove caracteres nao pertencentes a tabela ASCII
    If (strTexto[intContador] > #255) Then
      Continue;

    //Remove caracteres "no-break space"
    If (strTexto[intContador] = #160) Then
      Continue;

    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];
  End;

  If blnTiraTraEsp Then
    Result := AnsiReplaceStr(Result,'ñ',''); // isso n„o È um traÁo

  Result := AnsiReplaceStr(Result,'∫','.');
  Result := AnsiReplaceStr(Result,'ß','');
  Result := AnsiReplaceStr(Result,'™','.');
  Result := AnsiReplaceStr(Result,'Ω','1/2');
  Result := AnsiReplaceStr(Result,'º','1/4');
  Result := AnsiReplaceStr(Result,'æ','3/4');
  Result := AnsiReplaceStr(Result,'π','.');
  Result := AnsiReplaceStr(Result,'≥','.');
  Result := AnsiReplaceStr(Result,'≤','.');
end;

function fEmptyStr(const AString: String) : Boolean;
begin
  Result := fEmptyStrDicSis(AString);
end;

function IfEmptyStr(const AString, AStringDefault: String): String;
begin
  Result := IfEmptyStrDicSis(AString, AStringDefault);
end;

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

{*****************************************}
{* FAZ ALINHAMENTO (PAD) ¿ ESQUERDA      *}
{**************************************WI*}
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  {Result := strTexto;
  intTamanho := intTamanho - Length(strTexto);
  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;}

  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto, (Length(strTexto) + 1) - intTamanho, intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;


{*****************************************}
{* FAZ ALINHAMENTO (PAD) CENTRAL         *}
{**************************************MV*}
function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intDir, intEsq: Integer;
    intContador: Integer;
begin
  If Length(strTexto) < intTamanho Then
  begin
    intTamanho := intTamanho - Length(strTexto);
    intDir := (intTamanho Div 2);
    intEsq := (intTamanho Div 2) + intTamanho Mod 2;

    Result := strTexto;
    For intContador := 1 To intDir Do
      Result := Result + strCaracter;
    For intContador := 1 To intEsq Do
      Result := strCaracter + Result;

  end
  else
    Result := Copy(strTexto,1,intTamanho);

end;

function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String;
begin
  If Length(strTexto) < intTamanhoMin Then
    Result := fPadR(strTexto, intTamanhoMin, strCaracter)
  Else Result := Copy(strTexto, 1, intTamanhoMax)
end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) ¿ DIREITA       *}
{**************************************WI*}
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
{  Result := strTexto;
  intTamanho := intTamanho - Length(strTexto);
  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;}

  Result := strTexto;
  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

procedure pConfiguraOpcoesRegionais;
{$IF Defined(LINUX)}
begin
  FormatSettings := TFormatSettings.Create('pt-BR');
  FormatSettings.ThousandSeparator := '.';
  FormatSettings.DecimalSeparator  := ',';
  FormatSettings.CurrencyDecimals  := 2;
  FormatSettings.ShortDateFormat   := 'dd/MM/yyyy';
  FormatSettings.LongDateFormat    := 'dddd, d'' de ''MMMM'' de ''yyyy';
  FormatSettings.ShortTimeFormat   := 'hh:mm';
  FormatSettings.LongDateFormat    := 'hh:mm:ss';
  FormatSettings.CurrencyFormat    := 2; // [ 2 >> Before amount with space ]
  FormatSettings.CurrencyString    := 'R$';
end;
{$ELSE}
  Var
    reg: TRegistry;
Begin
  Try
    reg := TRegistry.Create;
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey('Control Panel\International', True);

    reg.WriteString('sMonThousandSep', '.');
    reg.WriteString('sMonDecimalSep' , ',');
    reg.WriteString('sThousand'      , '.');
    reg.WriteString('sDecimal'       , ',');
    reg.WriteString('sGrouping'      , '3;0');
    reg.WriteString('sMonGrouping'   , '3;0');
    reg.WriteString('iDigits'        , '2');
    reg.WriteString('iCurrDigits'    , '2');
    reg.WriteString('sDate'          , '/');
    reg.WriteString('sShortDate'     , 'dd/MM/yyyy');
    reg.WriteString('sLongDate'      , 'dddd, d'' de ''MMMM'' de ''yyyy');
    reg.WriteString('sTime'          , ':');
    reg.WriteString('sTimeFormat'    , 'HH:mm:ss');

    {$IF Defined(UNIDAC)}
    FormatSettings.ThousandSeparator := '.';
    FormatSettings.DecimalSeparator  := ',';
    FormatSettings.CurrencyDecimals  := 2;
    FormatSettings.ShortDateFormat   := 'dd/MM/yyyy';
    FormatSettings.LongDateFormat    := 'dddd, d'' de ''MMMM'' de ''yyyy';
    FormatSettings.ShortTimeFormat   := 'hh:mm';
    FormatSettings.LongDateFormat    := 'hh:mm:ss';       
    FormatSettings.CurrencyFormat    := 2; // [ 2 >> Before amount with space ]
    FormatSettings.CurrencyString    := 'R$';
    {$ELSE}
    ThousandSeparator := '.';
    DecimalSeparator  := ',';
    CurrencyDecimals  := 2;
    ShortDateFormat   := 'dd/MM/yyyy';
    LongDateFormat    := 'dddd, d'' de ''MMMM'' de ''yyyy';
    ShortTimeFormat   := 'hh:mm';
    LongDateFormat    := 'hh:mm:ss';    
    {$IFEND}
  Finally
    FreeAndNil(reg);
  End;

End;
{$IFEND}

{*******************************************}
{* PEGA O NOME DA M¡QUINA NA REDE          *}
{****************************************MV*}
function fRetNomeRede: String;
{$IFDEF LINUX}
begin
  Result := GetComputerNetName;
end;
{$ELSE}
var
  strNome: array[0..99] of AnsiChar;  // Usando array de 100 caracteres
  strComp: String;
  intContador: Integer;
  wsa: TWSAData;
begin
  // Inicializando o buffer
  FillChar(strNome, SizeOf(strNome), 0);  // Preenchendo com zero (importante)

  // Inicializando a rede
  WSAStartup(2, wsa);

  // Obtendo o nome do host
  gethostname(strNome, 100);

  intContador := 0;
  strComp := '';

  // Processando o nome do host
  while (strNome[intContador] <> ' ') and (strNome[intContador] <> #0) do
  begin
    strComp := strComp + Char(strNome[intContador]);  // Convertendo de AnsiChar para Char
    Inc(intContador);
  end;

  // Resultado
  Result := strComp;

  // Limpando a rede
  WSACleanup;
end;
{$ENDIF}

function GetCurrentProcessId: Integer;
{$IFDEF LINUX}
begin
  Result := getpid;
end;
{$ELSE}
begin
  Result := Windows.GetCurrentProcessId;
end;
{$ENDIF}

procedure pFecharBanco(Database: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND});
begin
  pGeraRegistroParaLogGeneral(Database, 'pFecharBanco > Database.Disconnect');

  Try
    If Database.InTransaction = True Then
      Database.Rollback;

    Database.Disconnect;
  Except
    On E : Exception do
    Begin
      {$IF Defined(LINUX)}
      Writeln('Fechamento do Banco de Dados: ' + E.Message);
      {$ELSE}
      ShowErrorMsgTimeout(E.ClassName, 'Fechamento do Banco de Dados: ' + E.Message, 10000);
      {$IFEND}
      If Not KillProcess(GetCurrentProcessId) Then
        Application.Terminate;
    End;
  End;
end;

Function fNextAutoIncrem(strAutInc: String): String;
Begin
 Result := LeftStr(strAutInc, 3) + fPadL(IntToStr(StrToIntDef(Copy(strAutInc, 4, 14), 0) + 1), 14, '0') + RightStr(strAutInc, 3);
End;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
  Var
    intAutIncAtu: Integer;

    strSQL,
    strProEmp: String;
    qryGenCod: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    blnInTransaction: Boolean;

    function fAutoIncremCadastrado: Boolean;
      Var
        qryGenTmp : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};

    begin
      Try

        qryGenTmp := fCriaQuery;

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM '+
                  '  FROM ' + strNomeTabela +
                  ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
          ParamByName('AUTINC').AsString := fFormataAutInc(intAutIncAtu, strCodEmp, strProEmp);
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

      Finally
        FreeAndNil(qryGenTmp);
      End;

    end;

    function fGetUltAutIncPROCOD: Integer;
      Var
        strTmp: String;
        qryTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    Begin
      strTmp := '';
      strTmp := strTmp + ' SELECT ';
      strTmp := strTmp + '   MAX(MID(AUTOINCREM, 4, 14)) AUTINC ';
      strTmp := strTmp + ' FROM ';
      strTmp := strTmp + '   PROCOD ';
      strTmp := strTmp + ' WHERE ';
      strTmp := strTmp + '   PRO_CODEMP = "' + VS_strCodEmp + '" ';

      Try
        qryTmp := fCriaQuery;

        With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strTmp);
          Open;

          If Not IsEmpty Then
            Result := FieldByName('AUTINC').AsInteger
          Else
            Result := 1;
        End;
      Except
        On E: Exception Do
          Raise;
      End;

      FreeAndNIl(qryTmp);
    End;
begin
  qryGenCod := fCriaQuery;
  blnInTransaction := qryGenCod.Connection.InTransaction;

  Repeat

    If Not blnInTransaction Then
    Begin
      qryGenCod.Connection.StartTransaction;
    End;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  PRO_AUTINC AS AUTINC  ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
      strSQL := strSQL + ' FOR UPDATE ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;

        If IsEmpty Then
        Begin
          If SameText(strNomeTabela, 'PROCOD') Then
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROCOD');
            Open;

            Insert;
            FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
            FieldByName('PRO_CODSEQ').AsString  := '001';
            FieldByName('PRO_TAMCOD').AsInteger := 3;
            FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
            FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
            FieldByName('PRO_CODAUT').AsString  := 'N';
            Post;

            Close;
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROINC');
            Open;

            Insert;
            FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
            FieldByName('PRO_AUTINC').AsInteger := 1;
            FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
            Post;

            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NOMARQ').AsString := strNomeTabela;
            Open;
          End
          Else
          Begin
            Close;
            FreeAndNil(qryGenCod);
            Raise Exception.Create('A tabela ' + strNomeTabela + ' n„o est· cadastrada ' +
                                 'na tabela de PrÛximos Incrementos! Verifique.' + #13#10);
          End;
        End;

        strProEmp := fRetEmpresaFisica;

        If FieldByName('AUTINC').IsNull Then
          intAutIncAtu := 1
        Else
          intAutIncAtu := FieldByName('AUTINC').AsInteger;

        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PROINC ';
      strSQL := strSQL + 'SET ';

      If intIntervalo > 1 Then
      Begin

        If intAutIncAtu = 1 Then
          strSQL := strSQL + '  PRO_AUTINC = ' + IntToStr(intIntervalo + 1)
        Else
          strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + ' + IntToStr(intIntervalo);

      End Else
      Begin

        If intAutIncAtu = 1 Then
          strSQL := strSQL + '  PRO_AUTINC = 2 '
        Else
          strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

      End;

      strSQL := strSQL + '  WHERE ';
      strSQL := strSQL + '    PRO_NOMARQ = :NOMARQ ';

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        ExecSQL;
        Close;
      End;

      Result :=  strProEmp + fPadL(IntToStr(intAutIncAtu) + strCodEmp, 17, '0');

      If Not blnInTransaction Then
        qryGenCod.Connection.Commit;

    Except
      On E: Exception Do
      Begin
        qryGenCod.Connection.Rollback;
        FreeAndNil(qryGenCod);
        Raise Exception.Create(E.message + 'N„o consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

  Until (Not fAutoIncremCadastrado);

  FreeAndNil(qryGenCod);

end;

{**************************************}
{* CRIA UMA QUERYNOVA PARA SER USADA  *}
{* PS. ATE QUE ENFIM ALGUEM FEZ ISSO  *}
{***********************************AF*}
function fCriaQuery(AOwner: TComponent = Nil;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil): {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  {$IF Defined(UNIDAC)}
  Result := TUniQuery.Create(AOwner);
  {$ELSE}
  Result := TZQuery.Create(AOwner);
  {$IFEND}

  {$IF Defined(VER250) Or Defined(UNIDAC)}
  Result.BeforeExecute := TQueryLog.BeforeExecute;
  {$ELSE}
  Result.BeforeOpen := TQueryLog.BeforeOpen;
  {$IFEND}

  If Assigned(Banco) Then
  Begin
    Result.Connection := Banco;
  End
  Else
  Begin
    Result.Connection  := frmModulo.Database;
  End;
End;

Function fRetEmpresaFisica: String;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      SQL.Text := 'SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER"';
      Open;

      If IsEmpty Then
        Result := VS_strCodEmp
      Else
        Result := FieldByName('PRO_CODEMP').AsString;

      Close;

    End;
    FreeAndNil(qryGen);

  Except
    On E: Exception Do
      Raise;
  End;
End;

function fGetMD5(AValue: String): String;
Var
  LQry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  LQry := fCriaQuery(nil);
  Try
    LQry.SQL.Text := 'SELECT MD5("'+AValue+'")';
    LQry.Open;
    Result := LQry.Fields[0].AsString;
  Finally
    FreeAndNil(LQry);
  End;
end;

function fNow: TDateTime;
Var
  LQry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  LQry := fCriaQuery(nil);
  Try
    LQry.SQL.Text := 'SELECT CAST(CONCAT(CURRENT_DATE, " ", CURRENT_TIME) AS DATETIME)';
    LQry.Open;
    Result := LQry.Fields[0].AsDateTime;
  Finally
    FreeAndNil(LQry);
  End;
end;

function fCfgSis(ACodCfg: string; ACodEmp: String = '') : string;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    LCodEmp: String;
begin
  Result := EmptyStr;

  If fEmptyStr(ACodEmp) Then
    ACodEmp := VS_strCodEmp;

  if ACodEmp = EmptyStr then
  Begin
    pRetornaParamSeExistir(consTagParamsEmp, LCodEmp, True);
    LCodEmp := IfEmptyStr(LCodEmp, ParamStr(2));
  End
  else
    LCodEmp := ACodEmp;

  qryGen := fCriaQuery(nil);
  Try
    {$IF Defined(UNIDAC)}
    strKey := fFormataKeyValCfgParaDicSis(ACodCfg, LCodEmp);
    If fAchouDicSisStr(qryGen.Connection, strKey, Result) Then
      Exit;
    {$IFEND}

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT SQL_NO_CACHE SIS_VALCFG FROM CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = :CODCFG');
    qryGen.ParamByName('CODEMP').Value := LCodEmp;
    qryGen.ParamByName('CODCFG').Value := 'CFG_' + ACodCfg;
    qryGen.Open();
    If not qryGen.IsEmpty Then
      Result := qryGen.FieldByName('SIS_VALCFG').AsString;

    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryGen.Connection, strKey, Result);
    {$IFEND}
  Finally
    qryGen.Free();
  End;
end;

function fCurrentTime: String;
begin
  Result := 'CAST("' + FormatDateTime('hh:mm:ss', Time) + '" AS TIME)';
end;

function fCurrentDate: String;
begin
  Result := fCurrentDate(Date);
end;

function fCurrentDate(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd', Value) + '" AS DATE)';
end;

function fCurrentDateTime: String;
begin
  Result := fCurrentDateTime(Date + Time);
end;

function fCurrentDateTime(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Value) + '" AS DATETIME)';
end;

{***********************************}
{* Abrir Banco de Dados do Sistema *}
{********************************DV*}
procedure pAbrirBanco(Var frmModulo: TfrmModulo);
  Const
    ERROR_USUARIO_SENHA_INV =  1045;
  Var
    intCodAut: Integer;
    blnReconectar: Boolean;

    strOpcAtc: String;

  procedure pMsgErro(E: Exception);
  begin
    {$IF Defined(LINUX)}
    Writeln('Abertura do Banco de Dados: ' + E.Message);
    {$ELSE}
    ShowErrorMsgTimeout(E.ClassName, 'Abertura do Banco de Dados: ' + E.Message, 10000);
    {$IFEND}
    If Not KillProcess(GetCurrentProcessId) Then
      Application.Terminate;
  end;
begin

  strOpcAtc := fPathOpcoesIni;

  blnReconectar := False;
{$IF Defined(LINUX)}
  frmModulo := TfrmModulo.Create(nil);
  frmModuloReplicacao := TfrmModuloReplicacao.Create(nil);
{$ELSE}
  Application.CreateForm(TfrmModulo, frmModulo);
  Application.CreateForm(TfrmModuloReplicacao, frmModuloReplicacao);
{$IFEND}
  intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0', strOpcAtc), 0);

  Try
    pConectarBanco(frmModulo);
  Except
    {$IF Defined(UNIDAC)}
      On E: EUniError Do
      Begin

        {*****************************************}
        {* N√O CONECTOU POIS A SENHA ESTAVA      *}
        {* INCORRETA. VAI TENTAR COM OUTRA SENHA *}
        {**************************************MV*}
        If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
        Begin
          blnReconectar := True;
          If intCodAut = 0 Then
            fArqIni(1, 'GERAL', 'CODAUT', '1', strOpcAtc);
        End
        Else
        Begin
          pMsgErro(E);
          Exit;
        End;

      End;
    {$ELSE}
      On E: EZSQLException Do
      Begin

        {*****************************************}
        {* N√O CONECTOU POIS A SENHA ESTAVA      *}
        {* INCORRETA. VAI TENTAR COM OUTRA SENHA *}
        {**************************************MV*}
        If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
        Begin
          blnReconectar := True;
          If intCodAut = 0 Then
            fArqIni(1, 'GERAL', 'CODAUT', '1', strOpcAtc);
        End
        Else
        Begin
          pMsgErro(E);
          Exit;
        End;

      End;
    {$IFEND}

    On E : Exception Do
    Begin
      pMsgErro(E);
      Exit;
    End;
  End;

  {*****************************************}
  {* A SENHA ESTAVA INCORRETA IR¡ TENTAR   *}
  {* COM A OUTRA SENHA.                    *}
  {**************************************MV*}
  If blnReconectar Then
  Begin
    Try
      pConectarBanco(frmModulo);
    Except
      {$IF Defined(UNIDAC)}
        On E: EUniError Do
        Begin
          {*****************************************}
          {* CASO ESTEJA CONECTANDO COM A NOVA     *}
          {* SENHA, E A MESMA ESTEJA INCORRETA, …  *}
          {* PORQUE O IMPLANTADOR COPIOU A PASTA.  *}
          {* NESTE CASO, TEM QUE LIGAR NA CITEL    *}
          {* PARA PEDIR UMA SENHA E LEVAR UMA      *}
          {* ADVERT NCIA, POIS N√O … PARA COPIAR.  *}
          {**************************************MV*}
          If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
          Begin
            If Not KillProcess(GetCurrentProcessId) Then
              Application.Terminate;
            Exit;
          End
          Else
          Begin
            pMsgErro(E);
            Exit;
          End;
        End;
      {$ELSE}
        On E: EZSQLException Do
        Begin
          {*****************************************}
          {* CASO ESTEJA CONECTANDO COM A NOVA     *}
          {* SENHA, E A MESMA ESTEJA INCORRETA, …  *}
          {* PORQUE O IMPLANTADOR COPIOU A PASTA.  *}
          {* NESTE CASO, TEM QUE LIGAR NA CITEL    *}
          {* PARA PEDIR UMA SENHA E LEVAR UMA      *}
          {* ADVERT NCIA, POIS N√O … PARA COPIAR.  *}
          {**************************************MV*}
          If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
          Begin
            If Not KillProcess(GetCurrentProcessId) Then
              Application.Terminate;
            Exit;
          End
          Else
          Begin
            pMsgErro(E);
            Exit;
          End;
        End;
      {$IFEND}

      On E: Exception Do
      Begin
        pMsgErro(E);
        Exit;
      End;
    End;

  End;

end;

procedure pDefinirCharsetConexao;
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGen := fCriaQuery;

  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SET character_set_connection = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_client = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_database = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_results = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_server = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_connection = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_database = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_server = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET sql_mode = ""');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET group_concat_max_len = 3072');
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

{$IFNDEF LINUX}
function fPathOpcoesIni: String;
  Var
    strPath : String;
begin
  Result := '';

  If FileExists(ExtractFilePath(ParamStr(0)) + 'opcoes.ini') Then
    Result := ExtractFilePath(ParamStr(0)) + 'opcoes.ini'
  Else If FileExists(ExtractFilePath(ParamStr(0)) + 'opcoespainel.ini') Then
  Begin
    strPath := Trim(fArqIniLocal(0, 'GERAL', 'PATATC', '', ExtractFilePath(ParamStr(0)) + 'opcoespainel.ini'));

    If (Not fEmptyStr(strPath)) Then
    Begin
      If (RightStr(strPath, 1) <> PATH_SEPARATOR) Then
        strPath := strPath + PATH_SEPARATOR;
    End;

    If (Not fEmptyStr(strPath)) And (DirectoryExists(strPath)) Then
    Begin
      If FileExists(strPath + 'opcoes.ini') Then
        Result := strPath + 'opcoes.ini';
    End;
  End;
end;
{$ELSE}
function fPathOpcoesIni: String;
Var
  strPath: String;
begin
  Result := '';
  If FileExists(ExtractFilePath(ParamStr(0)) + 'opcoespainel.ini') Then
  Begin
    strPath := fArqIni(0, 'GERAL', 'PATATC', '',  ExtractFilePath(ParamStr(0)) + 'opcoespainel.ini');
    If (Not fEmptyStr(strPath)) Then
    Begin
      If (RightStr(strPath, 1) <> PATH_SEPARATOR) Then
        strPath := strPath + PATH_SEPARATOR;
    End;
    If (Not fEmptyStr(strPath)) And (DirectoryExists(strPath)) Then
    Begin
      If FileExists(strPath + 'opcoes.ini') Then
        Result := strPath + 'opcoes.ini';
    End;
  End
  Else
  Begin
    Result := ExtractFilePath(ParamStr(0)) + 'opcoes.ini';
    Result := fArqIni(0, 'GERAL', 'CONF_BD', Result, Result);
  End;
end;
{$ENDIF}

function fCrypt(strSenha: String): String;
var
  LOld, LNew: Char;
  LPos, LIndex: Integer;
begin
  Result := '';
  If fEmptyStr(strSenha) Then
    Result := fstrEspaco(strSenha, Length(strSenha));

  For LIndex := Length(strSenha) Downto 1 Do
  Begin
    LOld := strSenha[LIndex];
    LPos := Pos(LOld, STR_CHAR_SENHA);
    LNew := STR_CHAR_TROCA[LPos];
    Result := Result + LNew;
  End;
end;

function fDecrypt(strSenha: String): String;
var
  LOld, LNew: Char;
  LPos, LIndex: Integer;
begin
  Result := '';
  If fEmptyStr(strSenha) Then
    Result := fstrEspaco(strSenha, Length(strSenha));

  For LIndex := Length(strSenha) Downto 1 Do
  Begin
    LOld := strSenha[LIndex];
    LPos := Pos(LOld, STR_CHAR_TROCA);
    LNew := STR_CHAR_SENHA[LPos];
    Result := Result + LNew;
  End;
end;

  {*****************************************}
  {* EFETUA A CONEX√O COM O BANCO.         *}
  {**************************************MV*}
procedure pConectarBanco(frmModulo: TfrmModulo);
  Var
    intCodAut: Integer;
    libUtil: Cardinal;
    strOpcAtc: String;
    arrStr: Array [0..255] Of AnsiChar;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;
    pSetaArquivoOpcoes: procedure(strArquivo: PAnsiChar); stdcall;

  function fUsarSenhaDLL: Boolean;
  begin
    strOpcAtc := fPathOpcoesIni;
    intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0', strOpcAtc), 0);
    Result := (intCodAut > 0) And (FileExists('libUtil.dll'));
  end;

begin
  frmModulo.Database.Disconnect;
  frmModulo.Database.Database := '';

  {$IF Defined(UNIDAC)}
    frmModulo.Database.Server   := '';
  {$ELSE}
    frmModulo.Database.HostName := '';
  {$IFEND}

  If fUsarSenhaDLL Then
  Begin
    libUtil := LoadLibrary(PChar('libUtil.dll'));

    fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
    fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));
    pSetaArquivoOpcoes := GetProcAddress(libUtil, PChar('pSetaArquivoOpcoesPChar'));

    If Assigned(pSetaArquivoOpcoes) Then
    Begin
      pSetaArquivoOpcoes(StrPCopy(arrStr, AnsiString(strOpcAtc)));
    End;
    {$IF Defined(UNIDAC)}
      frmModulo.Database.Username := String(StrPas(fRetornaUsuario));
    {$ELSE}
      frmModulo.Database.User := String(StrPas(fRetornaUsuario));
    {$IFEND}
    frmModulo.Database.Password := String(StrPas(fRetornaSenha));

    FreeLibrary(libUtil);
  End
  Else
  Begin
  {$IF Defined(LINUX)}
    frmModulo.Database.Username := LowerCase(fDecrypt('ùõ‡ÌÈùÍ¿Îëû'));
    frmModulo.Database.Password := LowerCase(fDecrypt('°Îëû¿ˆÙ¸ª„ùÎ‡õ'));
  {$ELSE}
    {$IF Defined(UNIDAC)}
      frmModulo.Database.Username := 'root';
    {$ELSE}
      frmModulo.Database.User := 'root';
    {$IFEND}
    frmModulo.Database.Password := 'citel13347';
  {$IFEND}
  End;

  {$IF Defined(UNIDAC)}
    frmModulo.Database.Server   := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP','', strOpcAtc), ' ', '');
  {$ELSE}
    frmModulo.Database.Hostname := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP','', strOpcAtc), ' ', '');
  {$IFEND}

  frmModulo.Database.Database := fArqIni(0,'BANCO','NOMBAN','', strOpcAtc);
  frmModulo.Database.Port     := StrToIntDef(fArqIni(0,'BANCO','PORTA','', strOpcAtc), 3306);

  frmModulo.Database.Connect;

  pGeraRegistroParaLogGeneral(frmModulo.Database, 'Inicializacao');

  {$IF not Defined(LINUX)}
  pDefinirCharsetConexao;
  {$IFEND}
End;

function fFormataCpfCgc(strValor: String; strEstado: String = ''): String;
Begin
  If (strEstado = 'EX') Then
  Begin

    Result := strValor;

  End
  Else
  Begin


    strValor := AnsiReplaceStr(strValor,'.','');
    strValor := AnsiReplaceStr(strValor,',','');
    strValor := AnsiReplaceStr(strValor,'-','');
    strValor := AnsiReplaceStr(strValor,'/','');

    Result := Trim(strValor);
    {************************************}
    {* SE FOR MAIOR QUE 11 ENT√O … CNPJ *}
    {*********************************AF*}

    If Not fEmptyStr(Result) Then
    Begin

      If Length(Result) > 11 Then
      Begin
        Insert('.',Result,3);  // XX.XXX.XXX/XXXX-XX
        Insert('.',Result,7);  // XX.XXX.XXX/XXXX-XX
        Insert('/',Result,11); // XX.XXX.XXX/XXXX-XX
        Insert('-',Result,16); // XX.XXX.XXX/XXXX-XX
      End
      Else
      Begin
        Insert('.',Result,4);  // XXX.XXX.XXX-XX
        Insert('.',Result,8);  // XXX.XXX.XXX-XX
        Insert('-',Result,12); // XXX.XXX.XXX-XX
      End;

    End;

  End;

End;

function fFormataCEP(strCEP: String): String;
begin
	Result := '';

  If Not fEmptyStr(strCEP) Then
  Begin
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),0,5) + '-';
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),6,3);
  End;

end;

function fFormataFone(strFone: String): String;
Begin
  strFone := fFormataFonePais(Trim(fTiraCaracEspeciaisParenteses(strFone)));
  Result  := strFone;
End;

function fFormataFonePais(strTelefo: String): String;
Begin
  If Not (fEmptyStr(strTelefo)) Then
  Begin
    If Length(strTelefo) < 11 Then
      Result := FormatMaskText('!\(99\)9999-9999;0;_',Copy(strTelefo,1,10))   // Fixo
    Else
      Result := FormatMaskText('!\(99\)99999-9999;0;_',Copy(strTelefo,1,11)); // Celular
  End
  Else
    Result := '';
End;

function fTiraCaracEspeciaisPonto(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():.';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  Begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  End;

  Result := strAux;
end;

function fTestaCgc(xCGC: String):Boolean;
begin
  Result := TCNPJ.fTestaCNPJ(xCGC, fCfgSis('NWCNPJ') = 'S');
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:TObject):TObject;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

function fStringRepetida(Const strString: String): Boolean;
  Var
    intContador: Integer;
    strPrimeiro: String;
begin

  Result := True;
  If Length(strString) <= 0 THen
    Exit;

  strPrimeiro := strString[1];
  For intContador := 2 To Length(strString) Do
  Begin
    If strString[intContador] <> strPrimeiro Then
    Begin
      Result := False;
      Break;
    End;
  End;

end;

function fValidaCPF(sCPF: string):Boolean;
var
   sDigs, sVal  : string;
   iSTot, iSTot2: integer;
   i: integer;
begin
  Result := False;
  sCPF   := Trim(AnsiReplaceText(sCPF, '.', ''));
  sCPF   := Trim(AnsiReplaceText(sCPF, '-', ''));
  iSTot  := 0;
  iSTot2 := 0;
  If Length(sCPF) = 11 Then
  begin
    For i := 9 Downto 1 Do
    Begin
      iSTot  := iSTot  + StrToIntDef(Copy(sCPF,i,1),0) * (11-i);
      iSTot2 := iSTot2 + StrToIntDef(Copy(sCPF,i,1),0) * (12-i);
    End;
    iSTot  := iSTot Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot < 2, 0, 11-iSTot));

    iSTot2 := iSTot2 + 2*StrToIntDef(sDigs,0);
    isTot2 := iSTot2 Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot2 < 2, 0, 11-iSTot2));

    sVal   := Copy(sCPF,10,2);
    Result := sDigs = sVal;
  End;
end;

function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'opcoes_local.ini';

  iniArqIni := TIniFile.Create(strNomArq {$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fFormataFloatInterna(fltNumero, intDecimais);
end;

function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  Var
    intDig: Integer;
    strVal: String;
begin
  strVal := FloatToStr(fltNumero);

  If Pos({$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300) OR Defined(VER330)} FormatSettings.DecimalSeparator {$ELSE} DecimalSeparator {$IFEND}, strVal) > 0 Then
  Begin
    intDig := Length(strVal) - Pos({$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300) OR Defined(VER330)} FormatSettings.DecimalSeparator {$ELSE} DecimalSeparator {$IFEND}, strVal);

    If (intDig > 0) And (intDig > intDecimais) And (strVal[Length(strVal)] = '5') Then
    Begin
      strVal[Length(strVal)] := '6';
    End;
  End;

  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDecimais));
end;

function fStringToStream(strString: String):TStringStream;
begin
  result := TStringStream.Create( strString );
end;

{$IF Defined(LINUX)}
function StreamToBase64(AStream: TStream): string;
var
  PDFBytes: TBytes;
begin
  // Garante que o stream esteja na posiÁ„o correta
  AStream.Position := 0;

  // LÍ o conte˙do do stream para um array de bytes
  SetLength(PDFBytes, AStream.Size);
  AStream.ReadBuffer(PDFBytes[0], AStream.Size);

  // Converte os bytes para uma string Base64
  Result := TNetEncoding.Base64.EncodeBytesToString(PDFBytes);
end;
{$IFEND}

{$IF Defined(LINUX)}
function fRetornarArquivoBase64(const ACaminhoArquivo: String): String;
  Var
    LArquivo: TFileStream;
Begin
  Result := EmptyStr;
  if fEmptyStr(ACaminhoArquivo) then
    Exit;
  LArquivo := TFileStream.Create(ACaminhoArquivo, fmOpenRead or fmShareDenyNone);
  Try
    Result := TIdEncoderMIME.EncodeStream(LArquivo);
  Finally
    FreeAndNil(LArquivo);
  End;
End;
{$IFEND}


function fStringToStreamDanfe(const strString: string): TStringStream;
{$IF Defined(LINUX)}
var
  LFr3: string;
begin
  LFr3 := strString;
  LFr3 := LFr3.Replace('clWhite', 'claWhite');
  LFr3 := LFr3.Replace('courier new', 'Courier New');
  Result := TStringStream.Create(LFr3, TEncoding.UTF8, True);
end;
{$ELSE}
begin
 {$IF Defined(UNIDAC)}
  Result := TStringStream.Create(strString, TEncoding.UTF8, True);
 {$ELSE}
  Result := TStringStream.Create(UTF8Encode(strString));
 {$IFEND}
end;
{$IFEND}

function fBooleanToString(const blnValue: Boolean): String;
begin
  Result := 'S';

  If (blnValue) Then
    Exit;

  Result := 'N';
end;

function fFormataCondPag(strCond: String): String;
  Var
    strValor   : String;
    intContador: Integer;
Begin
  intContador := 3;
  strValor := '(';
  strValor := strValor + LeftStr(strCond,2);
  strValor := strValor + ')';

  While intContador < Length(strCond) Do
  Begin
    If intContador > 3 Then
      strValor := strValor + '.';

    strValor := strValor + Copy(strCond,intContador,3);
    inc(intContador,3)
  End;

  {*******************************************}
  {* CASO RETORNE CONDI«√O VAZIA, RETORNA    *}
  {* STRING VAZIA                            *}
  {****************************************AF*}
  If (strValor = '()') Then
    strValor := '';

  Result := strValor;
End;

function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
Begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),fltDefault);
End;

function fStatusCndPag(strCndPag: String): Integer;
begin

  Result := A_PRAZO;

  strCndPag := Trim(fTiraCaracEspeciais(strCndPag));

  Try
    If fStrToFloat(strCndPag) = 1000.0 Then
      Result := A_VISTA;
  Except
    {*****************************************}
    {* APENAS PARA N√O DAR ERRO PARA O USUA- *}
    {* RIO.                                  *}
    {**************************************MV*}
  End;

end;

function fStrZero(Zeros:string;Quant:integer):String;
Var
	I,Tamanho:integer;
	Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

function fFormataInscricaoEstadual(strInsEst: string): string;
begin
  Result := Trim(strInsEst);

  if (not fEmptyStr(Result)) and (UpperCase(Result) <> 'ISENTO') then
  begin
    Insert('.', Result, 4);  //XXX.XXX.XXX.XXX
    Insert('.', Result, 8);  //XXX.XXX.XXX.XXX
    Insert('.', Result, 12); //XXX.XXX.XXX.XXX
  end;
end;

procedure pLog(strValor: String);
begin
  untDicSis.pLog(strValor);
end;

function fGetValorLinha(ALinha, ADelimitador: String; AColuna: Integer; AIgnoraPrimeiro: Boolean=False): String;
  Var
    LContador: Integer;
    LContDel: Integer;
    LTamStr: Integer;
    LEstado: Integer;
begin

  Result := '';

  If fEmptyStr(ALinha) Then
  Begin
    Exit;
  End;

  If AIgnoraPrimeiro Then
  Begin
    If AnsiStartsText('|', ALinha) Then
    Begin
      ALinha := Copy(ALinha, 2, Length(ALinha));
    End;
  End;

  LTamStr := Length(ALinha);
  LContador := 1;
  LContDel  := 1;

  LEstado := 0;

  While (LContDel < AColuna) Do
  Begin

    If (ALinha[LContador] = ADelimitador) And (LEstado = 0) Then
    Begin
      Inc(LContDel);
    End
    Else If ALinha[LContador] = '"' Then
    Begin
      If LEstado = 0 Then
        LEstado := 1
      Else
      Begin
        LEstado := 0;
        Inc(LContador);
        Continue;
      End;
    End;
    Inc(LContador);

    If (LContador = LTamStr) Then
    Begin
      Break;
    End;

  End;

  LEstado := 0;

  While ((ALinha[LContador] <> ADelimitador) Or (LEstado = 1)) And
        (LContador <= LTamStr)                                     Do
  Begin

    If ALinha[LContador] = '"' Then
    Begin
      Inc(LContador);
      If LEstado = 0 Then
        LEstado := 1
      Else
      Begin
        LEstado := 0;
        Continue;
      End;
    End;


    Result := Result + ALinha[LContador];
    Inc(LContador);
  End;

end;

function RetornaTexto(Texto, sText1, sText2: String): String;
var
  iPos1,iPos2 : Integer;
begin
  Result:='';
  if (sText1 = '') or (sText2 = '') then
    Exit;
  if (sText1 = sText2) then
    Exit;
  iPos1  := PosEx(sText1,Texto);
  iPos2  := PosEx(sText2,Texto);
  Result := Copy(Texto, iPos1 + Length(sText1), iPos2 - (iPos1 + Length(sText1)));
end;

function StringInSet(const S: String;
  const StringSet: array of String): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := Low(StringSet) to High(StringSet) do
    if S = StringSet[I] then
    begin
      Result := True;
      Break;
    end;
end;

function fRetSomenteNumeros(strTexto: String): String;
  Var
    strTmp: String;
    intIndice: Integer;
begin
  strTmp := '';

  If Not fEmptyStr(strTexto) Then
  Begin
    For intIndice := 1 To Length(strTexto) Do
      If StringInSet(strTexto[intIndice], ['0','1','2','3','4','5','6','7','8','9']) Then
        strTmp := strTmp + strTexto[intIndice];
  End;

  Result := strTmp;
end;

function fCampoExiste(const strTabela, strCampo: String;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
  Var
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    lBanco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
begin
  If Assigned(Banco) Then
    lBanco := Banco
  Else
    lBanco := frmModulo.Database;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyCmpExiParaDicSis(strTabela, strCampo);
  If fAchouDicSisBln(lBanco, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(lBanco, strTabela, strCampo);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(lBanco, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

function fTabelaExiste(const strTabela: String;
  Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND} = Nil): Boolean;
  Var
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
    lBanco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND};
Begin
  If (fEmptyStr(strTabela)) Then
  Begin
    Result := False;
    Exit;
  End;

  If Assigned(Banco) Then
    lBanco := Banco
  Else
    lBanco := frmModulo.Database;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyTabExiParaDicSis(strTabela);
  If fAchouDicSisBln(lBanco, strKey, Result) Then
    Exit;
  {$IFEND}

  Result := fTabelaCampoExiste(lBanco, strTabela);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(lBanco, strKey, fBooleanToStringDisSis(Result));
  {$IFEND}
end;

function fRetiraNumeroStr(const strTexto: String): String;
var
  intContador: Integer;
  strRazao: String;
begin
  Result := '';
  If fEmptyStr(strTexto) Then
    Exit;

  strRazao :=  strTexto;

  for intContador := Length(strTexto) downto 0 do
  begin
    if {$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)} CharInSet(strTexto[intContador], ['0'..'9']) {$ELSE} (strTexto[intContador] in ['0'..'9']) {$IFEND} then
      strRazao := AnsiReplaceStr(strRazao, strTexto[intContador], '');
    if (strTexto[intContador] = ' ') then
      Break;
  end;

  Result := strRazao;
end;

function fCampoTabela(strCampo, strNomTab: String; arrCampoChave: array of String; arrValorChave: array of Variant): Variant;
  Const
    arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

  Var
    intCont  : Integer;
    strSQL   : String;
    qryGenGer: {$IF Defined(VER250) Or Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Try
    qryGenGer := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ' + strCampo + ' ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strNomTab + ' ';
    strSQL := strSQL + 'WHERE ';

    For intCont := 0 To Length(arrCampoChave) -1 Do
    Begin
      If Pos('<>', arrCampoChave[intCont]) > 0 Then
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' :' + String(arrParms[intCont]) + ' AND '
      Else
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' = :' + String(arrParms[intCont]) + ' AND ';
    End;

    strSQL := strSQL + '  TRUE  ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To Length(arrCampoChave) -1 Do
        ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];

      Open;

      Result := Fields[0].Value;

      {*******************************************}
      {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
      {****************************************JC*}
      Case Fields[0].DataType Of
        ftString : Result := Fields[0].AsString;
        ftMemo   : Result := Fields[0].AsString;
        ftFloat  : Result := Fields[0].AsFloat;
        ftInteger: Result := Fields[0].AsInteger;
        ftBoolean: Result := Fields[0].AsBoolean;
        ftDate   : Result := Fields[0].AsDateTime;
        ftTime   : Result := Fields[0].AsDateTime;
      End;

    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

function ImageSize(ASender: TBitmap; AImageSize: TImageSize): Integer;
var
  ms: TStream;
begin
  ms := TMemoryStream.Create;
  try
    ASender.SaveToStream(ms);
    case AImageSize of
      KB: Result := Floor(ms.Size / 1024);
      MB: Result := Floor(ms.Size / 1024 / 1024);
      else Result := ms.Size;
    end;
  finally
    ms.Free;
  end;
end;

{$IFDEF LINUX}
procedure ResizeBitmapProportional(var Bitmap: TBitmap; MaxWidth, MaxHeight: Integer);
var
  Scale: Single;
  NewWidth, NewHeight: Integer;
  Resized: TBitmap;
  SrcRect, DestRect: TRectF;
begin
  if not Assigned(Bitmap) or (Bitmap.Width = 0) or (Bitmap.Height = 0) then
    Exit;

  // Proportional scale to fit within max dimensions
  Scale := Min(MaxWidth / Bitmap.Width, MaxHeight / Bitmap.Height);

  // If already fits, no need to resize
  if Scale >= 1 then
    Exit;

  NewWidth := Round(Bitmap.Width * Scale);
  NewHeight := Round(Bitmap.Height * Scale);

  Resized := TBitmap.Create(NewWidth, NewHeight);
  try
    Resized.Clear(TAlphaColors.Null); // or TAlphaColors.White

    Resized.Canvas.Fill.Kind := TBrushKind.Solid; // optional background fill
    Resized.Canvas.Fill.Color := TAlphaColors.Null;

    Resized.Canvas.Stroke.Kind := TBrushKind.None;

    SrcRect := RectF(0, 0, Bitmap.Width, Bitmap.Height);
    DestRect := RectF(0, 0, NewWidth, NewHeight);

    Resized.Canvas.BeginScene;
    try
      Resized.Canvas.DrawBitmap(Bitmap, SrcRect, DestRect, 1.0);
    finally
      Resized.Canvas.EndScene;
    end;

    // Replace original bitmap content
    Bitmap.Assign(Resized);
  finally
    Resized.Free;
  end;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure ResizeImage(bmpOrigem: TBitmap; AMaxSize: Integer; AImageSize: TImageSize; const AOutFile: string);
var
  LCompression: integer;
  bmpDestino: TBitmap;
begin
  LCompression := 100;
  bmpDestino := TBitmap.Create;
  try
    Repeat
      Dec(LCompression, 5);
      bmpDestino.Width := Floor(bmpOrigem.Width * LCompression / 100);
      bmpDestino.Height := Floor(bmpOrigem.Height * LCompression / 100);
      bmpDestino.Canvas.StretchDraw(bmpDestino.Canvas.ClipRect, bmpOrigem);
    until ImageSize(bmpDestino, AImageSize) <= AMaxSize;
    bmpDestino.SaveToFile(AOutFile);
  finally
    bmpDestino.Free;
  end;
end;

procedure ResizeImage(bmpOrigem: TBitmap; const ANewWidth : Integer; const AOutFile: string);
  Var
    LNewHeight : Integer;
    bmpDestino : TBitmap;
begin
  LNewHeight := Round(bmpOrigem.Height * ( ANewWidth / bmpOrigem.Width));
  bmpDestino := TBitmap.Create;
  Try
    bmpDestino.SetSize(ANewWidth, LNewHeight);
    bmpDestino.PixelFormat := bmpOrigem.PixelFormat;
    bmpDestino.Canvas.StretchDraw(Rect(0, 0, ANewWidth, LNewHeight), bmpOrigem);
    bmpDestino.SaveToFile(AOutFile);
  Finally
    bmpDestino.Free;
  End;
end;

{$ENDIF}

procedure pLogImp(const strValor: String; blnDeleta: Boolean=False);
begin
  untDicSis.pLogImp(strValor);
end;

function KillProcess(pid: cardinal): Boolean;
{$IF Defined(LINUX)}
begin
  Result := ShellExecute('kill -9 ' + pid.ToString).Trim.IsEmpty;
end;
{$ELSE}
var
  killer: THandle;
begin
  Result := False;

  killer := OpenProcess(PROCESS_TERMINATE, False, pid);
  if killer <> 0 then
  begin
    try
      Result := TerminateProcess(killer, 0);
    finally
      CloseHandle(killer);
    end;
  end;
end;
{$IFEND}

{$IF not Defined(LINUX)}
function ShellExecuteAndWait(Operation, FileName, Parameter, Directory: String; Show: Word; bWait: Boolean): Longint;
var
  bOK: Boolean;
  Info: TShellExecuteInfo;
begin
  FillChar(Info, SizeOf(Info), Chr(0));
  Info.cbSize := SizeOf(Info);
  Info.fMask := SEE_MASK_NOCLOSEPROCESS;
  Info.lpVerb := PChar(Operation);
  Info.lpFile := PChar(FileName);
  Info.lpParameters := PChar(Parameter);
  Info.lpDirectory := PChar(Directory);
  Info.nShow := Show;
  bOK := Boolean(ShellExecuteEx(@Info));
  if bOK then
  begin
    if bWait then
    begin
      while WaitForSingleObject(Info.hProcess, 100) = WAIT_TIMEOUT do
        Application.ProcessMessages;
      bOK := GetExitCodeProcess(Info.hProcess, DWORD(Result));
    end
    else
      Result := 0;
  end;
  if not bOK then
    Result := -1;
end;
{$IFEND}

{$IFDEF MSWINDOWS}
procedure ShowInfoMsgTimeout(const ATitle, AMsg: string; TimeoutMS: Cardinal);
var
  iFlags: Integer;
begin
  iFlags := MB_OK or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONINFORMATION;
  MessageBoxTimeOut(Application.Handle, PChar(AMsg), PChar(ATitle), iFlags, 0, TimeoutMS);
end;

procedure ShowErrorMsgTimeout(const ATitle, AMsg: string; TimeoutMS: Cardinal);
var
  iFlags: Integer;
begin
  iFlags := MB_OK or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONERROR;
  MessageBoxTimeOut(Application.Handle, PChar(AMsg), PChar(ATitle), iFlags, 0, TimeoutMS);
end;
{$ENDIF}

procedure pCriarDiretorioDanfeEnotasCasoNaoExista;
begin
  If DirectoryExists(fDiretorioDanfeEnotas) Then
    Exit;

  CreateDir(fDiretorioDanfeEnotas);
end;

function fDiretorioDanfeEnotas: String;
begin
  Result := ExtractFileDir(fRetNomeArquivoPDFtoPrinter);

  If fEmptyStr(Result) Then
  Begin
   {$IFDEF LINUX}
    Result := ExtractFilePath(ParamStr(0));
   {$ELSE}
    Result := ExtractFilePath(Application.ExeName);
   {$ENDIF}
  End;

  Result := fSepDir(Trim(Result));
  Result := fSepDir(Result + 'DANFE');
end;

function fRetNomeArquivoPDFtoPrinter: String;
begin
  Result := 'c:' + PATH_SEPARATOR + 'NFEPRINTER' + PATH_SEPARATOR + 'PDFtoPrinter.exe';
  If Not FileExists(Result) Then
    Result := ExtractFilePath(ParamStr(0)) + PATH_SEPARATOR + 'PDFtoPrinter.exe';
end;

function GetComputerNetName: string;
{$IF Defined(LINUX)}
begin
  Result := ShellExecute('hostname').Trim;
end;
{$ELSE}
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;
{$IFEND}

function GetUserFromWindows: string;
{$IF Defined(LINUX)}
begin
  Result := ShellExecute('whoami').Trim;
end;
{$ELSE}
var
  UserName : string;
  UserNameLen : Dword;
begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   if GetUserName(PChar(UserName), UserNameLen) then
     Result := Copy(UserName,1,UserNameLen - 1)
   else
     Result := 'Unknown';
end;
{$IFEND}

function GetIPAddress: Integer;
{$IF Defined(LINUX)}
begin
  Result := 0;
end;
{$ELSE}
var
  Buffer: array[0..255] of AnsiChar;
  RemoteHost: PHostEnt;
begin
  Winsock.GetHostName(@Buffer, 255);
  RemoteHost := Winsock.GetHostByName(Buffer);
  if RemoteHost = nil then
    Result := winsock.htonl($07000001) { 127.0.0.1 }
  else
    Result := longint(pointer(RemoteHost^.h_addr_list^)^);
  Result := Winsock.ntohl(Result);
end;
{$IFEND}

function GetIPAddressAsString: string;
{$IF Defined(LINUX)}
begin
  Result := ShellExecute('hostname -I | cut -f1 -d" "').Trim;
end;
{$ELSE}
var
  tempAddress: Integer;
  Buffer: array[0..3] of Byte absolute tempAddress;
  data: WSAData;
begin
  WSAStartup(2, data);
  tempAddress := GetIPAddress;
  Result := Format('%d.%d.%d.%d', [Buffer[3], Buffer[2], Buffer[1], Buffer[0]]);
  WSACleanup;
end;
{$IFEND}

function GetMacAddress: string;
{$IF Defined(LINUX)}
Var
  I: Integer;
  LParse: TArray<string>;
begin
  Result := ShellExecute('ifconfig | grep ether | awk ''{print $2}''').Trim;

  if not Result.IsEmpty then
    exit;

  LParse := ShellExecute('ifconfig').Split([' ']);

  For I := Low(LParse) To High(LParse) Do
    If LParse[I].Equals('HW') Or LParse[I].Equals('HWaddr') Then
      exit(LParse[succ(I)]);
end;
{$ELSE}
var
  Librpcrt4: Cardinal;
  GUID1, GUID2: TGUID;
  Func: Function(GUID: PGUID): Longint; stdcall;
begin
  Result := '';
  Librpcrt4 := LoadLibrary('rpcrt4.dll');
  if not (Librpcrt4 = 0) then
  try
     @Func := GetProcAddress(Librpcrt4, 'UuidCreateSequential');
     if Assigned(Func) then
     begin
       if (Func(@GUID1) = 0) and
          (Func(@GUID2) = 0) and
          (GUID1.D4[2] = GUID2.D4[2]) and
          (GUID1.D4[3] = GUID2.D4[3]) and
          (GUID1.D4[4] = GUID2.D4[4]) and
          (GUID1.D4[5] = GUID2.D4[5]) and
          (GUID1.D4[6] = GUID2.D4[6]) and
          (GUID1.D4[7] = GUID2.D4[7]) then
       begin
         Result :=
           IntToHex(GUID1.D4[2], 2) + '-' +
           IntToHex(GUID1.D4[3], 2) + '-' +
           IntToHex(GUID1.D4[4], 2) + '-' +
           IntToHex(GUID1.D4[5], 2) + '-' +
           IntToHex(GUID1.D4[6], 2) + '-' +
           IntToHex(GUID1.D4[7], 2);
       end;
     end;
  finally
    FreeLibrary(Librpcrt4);
  end;
end;
{$IFEND}

{$if not defined(LINUX)}
function VerImpressoraONLINE(impressora: String): Cardinal;
  Var
    pInfo: PPrinterInfo2;
    bytesNeeded: DWORD;
    hPrinter: THandle;

  Function GetCurrentPrinterHandle: Boolean;
    Var
      Device, Driver, Port : array[0..255] of char;
  Begin
    Printer.GetPrinter(Device, Driver, Port, hPrinter);
    Result := (OpenPrinter(@Device, hPrinter, nil))
  End;
begin
  Try
    If (fEmptyStr(Trim(impressora))) Then
    Begin
      Result := 0;
    End
    Else
    Begin
      If (Printer.Printers.IndexOf(impressora) < 0) Then
      Begin
        Result := 1;
      End
      Else
      Begin;
        Printer.PrinterIndex := Printer.Printers.IndexOf(impressora);

        If (Not GetCurrentPrinterHandle()) Then
        Begin
          Result := 1;
        End
        Else
        Begin;
          Try
            GetPrinter(hPrinter, 2, Nil, 0, @bytesNeeded);
            pInfo := AllocMem(bytesNeeded);

            Try
              GetPrinter(hPrinter, 2, pInfo, bytesNeeded, @bytesNeeded);
              Result := pInfo^.Status;
            Finally
              FreeMem(pInfo);
            End;
          Finally
            ClosePrinter(hPrinter);
          End;
        End;
      End;
    End;
  Except
    Result := 1;
  End;
end;
{$ifend}

function fRetornaValor(strValor: String): Double;
var
  strConversao : String;
begin

  Result := 0;

  if fEmptyStr(strValor) then
    Exit;

  strConversao := strValor;
  strConversao := AnsiReplaceStr(strConversao, 'R$', '');
  strConversao := AnsiReplaceStr(strConversao, '.' , '');
  Result := StrToFloatDef(strConversao, 0);
end;

function fExistePdfNfe(AChaveAcesso: String): Boolean;
Var
  qryAux: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Result := False;

  pLogImp('fExistePdfNfe > '+AChaveAcesso);

  If (Not fCampoExiste('PDFNFE', 'NFE_ACESSO')) Then
  Begin
    pLogImp('fExistePdfNfe < N√O EXISTE PDFNFE-NFE_ACESSO');
    Exit;
  End;

  If (Not fCampoExiste('PDFNFE', 'NFE_ARQPDF')) Then
  Begin
    pLogImp('fExistePdfNfe < N√O EXISTE PDFNFE-NFE_ARQPDF');
    Exit;
  End;

  qryAux := fCriaQuery(Nil);
  Try
    Try
      qryAux.SQL.Text := 'SELECT COUNT(*) AS QTD FROM PDFNFE WHERE NFE_ACESSO = :ACESSO ';
      qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
      qryAux.Open;
      Result := (qryAux.FieldByName('QTD').AsInteger > 0);
      qryAux.Close;
    Except
      On E: Exception Do
      Begin
        pLogImp(E.Message + ' [fExistePdfNfe]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;

  pLogImp('fExistePdfNfe < = ' + IIF(Result, 'True', 'False'));
End;

procedure SetPixelColor(Bitmap: TBitmap; X, Y: Integer; Color: TAlphaColor);
{$if defined(LINUX)}
var
  BitmapData: TBitmapData;
begin
  if Bitmap.Map(TMapAccess.Write, BitmapData) then
  try
    if (X >= 0) and (X < Bitmap.Width) and (Y >= 0) and (Y < Bitmap.Height) then
      BitmapData.SetPixel(X, Y, Color);
  finally
    Bitmap.Unmap(BitmapData);
  end;
end;
{$else}
begin
  Bitmap.Canvas.Pixels[x, y] := Color;
end;
{$ifend}

{$if not defined(LINUX)}
function fGerarQRCode(strTexto: String): TBitmap;
{$else}
function fGerarQRCode(strTexto: String): FMX.Graphics.TBitmap;
{$endif}
var
  QRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
  color: TColor;

  PixelRow: Integer;
  PixelColumn: Integer;
Const
  SCALE = 3;
begin
  Result := TBitmap.Create;
  QRCode := TDelphiZXingQRCode.Create;
  try
    QRCode.Data := strTexto;
    QRCode.Encoding := qrAuto;
    QRCode.QuietZone := 0;
    Result.SetSize(QRCode.Rows*SCALE, QRCode.Columns*SCALE);

    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
          color := {$if defined(LINUX)}TAlphaColorRec.Black{$else}clBlack{$ifend}
        Else
          color := {$if defined(LINUX)}TAlphaColorRec.White{$else}clWhite{$ifend};
        For PixelColumn := 0 To SCALE-1 Do
          For PixelRow := 0 To SCALE-1 Do
            SetPixelColor(Result, Column*SCALE+PixelColumn, Row*SCALE+PixelRow, color);
      end;
    end;
  finally
    QRCode.Free;
  end;

end;

function fAplicaFusoHorarioENotas( strHoraEmissao, strFusoHorario: string; var strDataEmissao: string): string;
begin
  if fEmptyStr(strFusoHorario) then
    result := strHoraEmissao
  else
  begin
    result := TimeToStr( IncMinute( StrToTime(strHoraEmissao), StrToInt(strFusoHorario)*60) );
    if ( StrToTime(result) > StrToTime(strHoraEmissao) ) then
      strDataEmissao := DateToStr( IncDay( StrToDate(strDataEmissao), -1) )
  end;
end;

procedure DefinirTimeZoneEmSessaoMySql(const ACodigoEmpresa : String);
  Var
    LQryConexao : {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    LUsaTimeZone : String;
begin
  If fEmptyStr(ACodigoEmpresa) Then
    Exit;
  LUsaTimeZone := fCfgSis('USATMZ');
  If (fEmptyStr(LUsaTimeZone)) Or (LUsaTimeZone = 'N') Then
    Exit;
  LQryConexao := fCriaQuery(Nil);
  Try
    LQryConexao.SQL.Text := Format('SET time_zone = %s;', [QuotedStr(CfgTmZoneToMySqlFormatTimeZone(ACodigoEmpresa))]);
    LQryConexao.ExecSQL;
  Finally
    FreeAndNil(LQryConexao);
  End;
end;

function CfgTmZoneToMySqlFormatTimeZone(const ACodigoEmpresa : String): String;
  Const
    arrTimeZonesPemrmitidos : Array [1..4] Of Integer = (-2, -3, -4, -5);
  Var
    LTimeZoneConfigurado : Integer;
    LContador : Integer;
begin
  Result := '-3:00';
  If fEmptyStr(ACodigoEmpresa) Then
    Exit;
  LTimeZoneConfigurado := TimeZoneConfigurado(ACodigoEmpresa);
  If LTimeZoneConfigurado = 0 Then
    Exit;
  For LContador := Low(arrTimeZonesPemrmitidos) To High(arrTimeZonesPemrmitidos) Do
  Begin
    If (arrTimeZonesPemrmitidos[LContador] = LTimeZoneConfigurado) Then
    Begin
      Result := Format('%d:00', [LTimeZoneConfigurado]);
      Exit;
    End;
  End;
end;

function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  Var
    LTimeZone : String;
begin
  Result := 0;

  LTimeZone := fCfgSis('TMZONE');

  If (fEmptyStr(LTimeZone)) Then
    Exit;

  Result := StrToIntDef(LTimeZone, 0);
end;

procedure pPegaDataHoraSistema(Var dtaDtaSis, dtaHraSis : TDateTime);
  Var
    qryGenTmp: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryGenTmp := fCriaQuery(Nil);
  Try
    Try
      qryGenTmp.Close;
      qryGenTmp.SQL.Clear;
      qryGenTmp.SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
      qryGenTmp.Open;
      dtaDtaSis := qryGenTmp.FieldByName('CURRENT_DATE').AsDateTime;
      dtaHraSis := qryGenTmp.FieldByName('CURRENT_TIME').AsDateTime;
      qryGenTmp.Close;
    Except
      dtaDtaSis := Date;
      dtaHraSis := Time();
    End;
  Finally
    FreeAndNil(qryGenTmp);
  End;
end;

function fRetornaValorTagXml(ATag: IXMLNode) : String;
begin
  Result := '';

  If ATag <> nil Then
  begin
    if (ATag.IsTextElement) or (Atag.Text='') then
      Result := ATag.Text
    else
      Result := ATag.NodeValue;
  end;

end;

function fStrToFloatDef(strValor: String) : Double;
begin
  try
    If Pos('.', strValor) > 0 Then
    {$IF Defined(UNIDAC)}
      FormatSettings.DecimalSeparator := '.';
    {$ELSE}
      DecimalSeparator := '.';
    {$IFEND}

    strValor := FormatFloat('00.00', StrToFloatDef(strValor, 0));
    Result := StrToFloatDef(strValor, 0);
  finally
    {$IF Defined(UNIDAC)}
    If FormatSettings.DecimalSeparator = '.' Then
      FormatSettings.DecimalSeparator := ',';
    {$ELSE}
    If DecimalSeparator = '.' Then
      DecimalSeparator := ',';
    {$IFEND}
  end;
end;

function fRetDescClassificacaoServico(strCodigo: string): string;
var
  qryClassificacao: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := EmptyStr;
  qryClassificacao := fCriaQuery;

  try
    qryClassificacao.Close;
    qryClassificacao.SQL.Clear;
    qryClassificacao.SQL.Add('SELECT CDS_DESCRI');
    qryClassificacao.SQL.Add('FROM CADCDS');
    qryClassificacao.SQL.Add('WHERE CDS_CDSERV = :CODIGO');

    qryClassificacao.ParamByName('CODIGO').AsString := AnsiReplaceStr(strCodigo, '.', '');

    qryClassificacao.Open;

    if (not qryClassificacao.IsEmpty) then
    begin
      Result := qryClassificacao.FieldByName('CDS_DESCRI').AsString;
    end;
  finally
    FreeAndNil(qryClassificacao);
  end;
end;

function fRetDiaVencimentoISS( Const dtaOrigem: TDateTime; qtdDias: Integer ): TDateTime;
var
  dtaVenctoISS: TDateTime;
begin
  dtaVenctoISS := IncMonth(dtaOrigem);
  dtaVenctoISS := IncDay(StartOfTheMonth(dtaVenctoISS), qtdDias);
  if DayOfWeek(dtaVenctoISS) = 7 then
    dtaVenctoISS := IncDay(dtaVenctoISS, 2)
  else if DayOfWeek(dtaVenctoISS) = 1 then
    dtaVenctoISS := IncDay(dtaVenctoISS, 1);
  result := dtaVenctoISS;
end;

function fCalculaPorcentagem(fltNumUm, fltNumDois: Double): Double;
begin
  Result := 00.00;

  If (fltNumUm = 00.00) Or (fltNumDois = 00.00) Then
    Exit;

  Result := (fltNumUm * 100) / fltNumDois;
end;

{$IFDEF LINUX}
function Application: TApplication;
begin
  Result := FMX.Forms.Application;
end;
{$ENDIF}

{$IFDEF LINUX}
function fGetUniqueTempPath(const AExt: string = '.tmp'): string;
begin
  Result := TPath.Combine(
    TPath.GetTempPath,
    TGUID.NewGuid.ToString
      .Replace('{', '').Replace('}', '').Replace('-', '') + AExt
  );
end;
{$ENDIF}

function fRetNumeroRps(strNumDoc: string): string;
var
  strIntRps: String;
  intIntRps: integer;
begin

  strIntRps := fCfgSis('INTRPS');
  If Not fEmptyStr(strIntRps) Then
    intIntRps := StrToIntDef(strIntRps, 0)
  Else
    intIntRps := 0;
  Result := fStrZero(IntToStr(Floor(StrToFloat(strNumDoc)) - intIntRps), 12);

end;

function fExisteConfiguracao(strCodCfg: String; Banco: {$IF Defined(UNIDAC)} TUniConnection {$ELSE} TZConnection {$IFEND}=Nil; strCodEmp: String = ''): Boolean;
Var
  strEmp,
  strSQL: String;
  qryCfg: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  {$IF Defined(UNIDAC)}
  strKey: String;
  {$IFEND}
Begin
  qryCfg := fCriaQuery(Nil, Banco);
  strEmp := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
  Try
    {$IF Defined(UNIDAC)}
    strKey := fFormataKeyCfgExiParaDicSis(strCodCfg, strEmp);
    If fAchouDicSisBln(qryCfg.Connection, strKey, Result) Then
      Exit;
    {$IFEND}

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  SIS_CODCFG AS CONFIG_EXISTE ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCFG').AsString := 'CFG_' + strCodCfg;
      ParamByName('CODEMP').AsString := strEmp;
      Open;
      Result := (Not IsEmpty);
    End;

    {$IF Defined(UNIDAC)}
    pInsereDicSis(qryCfg.Connection, strKey, fBooleanToStringDisSis(Result));
    {$IFEND}
  Finally
    FreeAndNil(qryCfg);
  End;
End;

procedure pGravaLogErr(const strDescri, strValRel: WideString; blnVerificarSeJaGravouHoje: Boolean=False);
  Var
    qryGen: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    dtaDtaSis : TDateTime;
    dtaHraSis : TDateTime;
begin
  qryGen := fCriaQuery;
  Try
    pPegaDataHoraSistema(dtaDtaSis, dtaHraSis);

    If (blnVerificarSeJaGravouHoje) Then
    Begin
      qryGen.Close;
      qryGen.SQL.Text := 'SELECT COUNT(*) FROM LOGERR WHERE LOG_DESCRI = "'+strDescri+'" AND LOG_DTAERR = CURRENT_DATE';
      qryGen.Open;
      If (Not qryGen.IsEmpty) Then
        If (qryGen.Fields[0].AsInteger > 0) Then
          Exit;
    End;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO LOGERR           ');
    qryGen.SQL.Add('   SET LOG_CODEMP = :CODEMP, ');
    qryGen.SQL.Add('       LOG_LOGOPE =  NULL,   ');
    qryGen.SQL.Add('       LOG_DTAERR = :DTAERR, ');
    qryGen.SQL.Add('       LOG_HORERR = :HORERR, ');
    qryGen.SQL.Add('       LOG_DESCRI = :DESCRI, ');
    qryGen.SQL.Add('       LOG_RELERR = :RELERR; ');

    qryGen.ParamByName('CODEMP').Value      := VS_strCodEmp;
    qryGen.ParamByName('DTAERR').AsDateTime := dtaDtaSis;
    qryGen.ParamByName('HORERR').AsDateTime := dtaHraSis;
    qryGen.ParamByName('DESCRI').Value      := strDescri;
    qryGen.ParamByName('RELERR').Value      := strValRel;
    qryGen.ExecSQL;
  Finally
    FreeAndNil(qryGen);
  End;
end;

initialization
  VS_stlTabNre   := Nil;
  VS_LogRepCodOp := '';

finalization
  If Assigned(VS_stlTabNre) Then
    FreeAndNil(VS_stlTabNre);

end.
