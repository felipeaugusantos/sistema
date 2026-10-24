unit Services.Core.Utils;

interface

uses
  System.SysUtils,
  System.Classes,
  System.strUtils,
  System.DateUtils,
  Data.DB,
  Posix.Base,
  Posix.Fcntl,
  Posix.Unistd,
  Posix.Stdlib,
  Posix.SysStat,
  Posix.SysTypes,
  Posix.Signal,
  System.Math,
  System.JSON,
  Services.Core.Settings,
  Services.Core.Types,
  Services.Core.Connection.Interfaces,
  System.Variants,
  UntTypesSistema;

type
  TStreamHandle = pointer;
  TStringArray = TArray<string>;
  TRoundFiveMode = (RoundFiveUp, RoundFiveDown);

type
  IStrings = interface
  ['{48DF333A-AACF-462C-8508-F626577B4BD3}']
    function GetObj: TStrings;
    function GetCount: Integer;
    function GetString(Index: Integer): string;
    function GetAsInt(Index: Integer): Integer;
    procedure SetString(Index: Integer; const Value: string);
    procedure SetAsInt(Index: Integer; const Value: Integer);

    property Obj: TStrings read GetObj;
    property Count: Integer read GetCount;
    property Strings[Index: Integer]: string read GetString write SetString; default;
    property AsInt[Index: Integer]: Integer read GetAsInt write SetAsInt;
  end;

function SplitEx(const Text, Separator: string): IStrings;

procedure WriteLog(AText: string; AForceLog: Boolean = False; ASize: Integer = -1);
procedure WriteError(AText: string);

function ShellExecute(AComand: String): String;
function ExecuteCurl(AComand, ADataFile, AGetPost: String; ANewAttemptOnFail: Boolean; var AHeader: TStrings): String;

function GetStackTrace: String;

function GetMemoryUsage: String;

procedure SET_OOM_SCORE_ADJ(AValue: Integer = -1000);

function FormatJson(AJson: String): String;

function fRetStrToSQLIn(strValores: String; strDelimitador: String = '_'): String;
function fRetStrToSQLArr(strValores: String; strDelimitador: String = '_'): TArray<Variant>;
function fRetArrToSQLIn(arrValores: TConsultasArray; strCodigo: String): String;

function HasParam(AParamID: String): Boolean;
function GetParamValue(AParamID: String): String;

function GetIPAddress(): String;
function GetMacAddress(): String;
function GetComputerNetName(): String;
function GetComputerUser(): String;

function fDecrypt(strSenha: String): String;
function fCrypt(strSenha: String): String;

function GetMD5(pw: string): string;

procedure SaveTextToFile(AText, AFileName: String);
procedure SalvaComoUTF8(AText, AFileName: String);

function IIF(lTest: Boolean; vExpr1, vExpr2: Variant): Variant;

function fStrZero(Zeros: String; Quant: Integer): String; overload;
function fStrZero(Zeros: Integer; Quant: Integer): String; overload;

function fTransform(AConteudo: String; AStep: Shortint; AChar: String = '_'): String;

function fExecutandoPeloPortal(): Boolean;

function fEmptyDate(strDate: String): Boolean;
function fEmptyTime(strTime: String): Boolean;
function fEmptyStr(strString: String; blnTiraCaracEspecial: Boolean = False): Boolean;
function IfEmptyStr(strValor, strDefault: String): String;

function fRemoveAcento(Str:String): String;

function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;

function IfFloatZero(fltValor, fltDefault: Double): Double;
function fFloatToInt(fltNumero: Double): Integer;

function IfNull(varValor, varDefault: Variant): Variant;

function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;

function VarToString(Const AValue: Variant): String;

function fQuotedStr(strString: String): String;
function fCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator : String = ', '): String;
function fReplaceStr(strTexto, strFrom, strTo: String): String; overload;
function fReplaceStr(strTexto: String; arrFrom, arrTo: Array Of String): String; overload;

function fTrimAll(strTexto: String): String;
function fTiraEnter(strTexto: String): String;
function fTiraEspacos(strTexto: String): String;
function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
function fTiraCaracEspeciaisPonto(strTexto: String): String;
function fTiraCaracEspeciaisParenteses(strTexto: String): String;
function fTiraCaracEspeciais(strTexto: String; blnUsaLista: Boolean = True;
  blnTiraEspacos: Boolean = False; blnTiraPontos: Boolean = False;
  blnTiraDoisPts: Boolean = False; blnTiraTab: Boolean = False;
  blnTiraVirgula: Boolean = True;
  blnTiraAbreviacaoNumero: Boolean = False;
  strCaracterePersonalizado: String = ''): String;

function fMskDigitos(intDigitos: Integer): String;

procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
procedure pAddDados(Var arrAdd, arrHin : TStringArray; strTexto: String; strHint : String = ''; blnConsiderarEnter: Boolean = False); overload;

function fFrac(const fltValor: Double): Double;

function fIsNumber(Const strNumber: String): Boolean;
function fStrToFloat(strValorUnico: String; fltDefault: real = 0): Double;
function fFormataFloat(fltNumero: Double; intDecimais: Integer; RoundFiveMode: TRoundFiveMode = RoundFiveUp): Double;
function fTruncaFloat(fltNumero: Double; intDecimais: Integer): Double;
function fFloatToSQL(fltValor: Double): String;

function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;

function fExt1(strS : String; strIdioma: String = 'P'): String;
function fExt2(strS : string; strIdioma: String = 'P'): String;
function fExt3(strS : string; strIdioma: String = 'P'): String;

function fExtUnidade(strS : String; strIdioma: String = 'P'): String;
function fExtDezena(strS : String; strIdioma: String = 'P'): String;

procedure pAtribuirDesconsiderandoVazio(const fldField: IField; const strValue: String);
procedure pAtribuirSetandoNullEmVazio(const fldField: IField; const strValue: String);
procedure pAtribuirSetandoClearEmVazio(const fldField: IField; const strValue: String);
procedure pAtribuirSetandoNullEmZero(const fldField: IField; const dtaValue: TDateTime);

//function FormatFloat(const Format: string; Value: Double): string;

function fFormataCondPag(strCond: String): String;
function fConPagComEntrada(strConPag: String): Boolean;

function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
function fFormataCpfCgc(strValor: String; strEstado: String = ''): String;

function fCalculaValDocCartao(fltValTot, fltTaxAdm: Double): Double;
procedure pArredondaParcelaDefault(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
procedure pArredondaParcelaRedonda(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);

function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;
function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True;
                     strCodCid: String = ''; blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                     blnConsideraDomingo: Boolean = False): Boolean;
function fEhFeriado(dtaDta: TDateTime; strCodCid: String = ''): Boolean;

function fDocumeCar(strNumDoc, strEspDoc, strCodEmp: String; intContador: Integer; blnComCnt: Boolean = True): String;

function fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String;

function fGeraCodBarraEAN13(strCodigo: String): String;
function fGeraCodBarraEAN39(strCodigo: String): String;

function fTemTagMsgOculta(Const strTexto: String): Boolean;
function fLimpaTagMsgOculta(Const strTexto: String): String;

function fNow: TDateTime;
function VS_Date(AServerDate: Boolean = True): TDateTime;

function fDateTimeToUnix(dtahor: TDateTime): Int64;

function fRetCoordenada(strCoordenada: String; LatLon: TLatLon): Extended;
function fTime(const AForceTime: Boolean = False) : TDateTime;

function AdicionarMascaraCpfCnpj(const Documento: string): string;
function fSeqContaBanco(intQtdCod: Integer = 1): String;

function fRetNumeroEndereco(strEndereco: String): Integer;

function fRemoverAtributoDoJson(const AstrJson, AstrAtributoRemover: String): String;
function fRetiraZerosEsquerda(strDado: String): String;

Var
  VS_ComputerNetName: String;
  VS_ComputerUser: String;
  VS_UserFromWindows: String;
  VS_IPAddressAsString: String;
  VS_MacAddress: String;
  VS_ProcessId: String;
  VS_ExitProcessSignal: Boolean;

implementation

uses IdHashMessageDigest, idHash, IdGlobal, Services.Core.Connection.Manager,
  untHorarioSistema;

const
  STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#@!';
  STR_CHAR_TROCA = 'ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£#ª°';
  STRING_MENSAGEM_OCULTA_INI = '<:';
  STRING_MENSAGEM_OCULTA_FIM = ':>';

var
  FUltimaConsultaVS_Date: TDateTime;
  FVS_Date: TDate;

type
  TStringsImpl = class(TInterfacedObject, IStrings)
  private
    FStrings: TStringList;
  protected
    function GetObj: TStrings;
    function GetCount: Integer;
    function GetString(Index: Integer): string;
    function GetAsInt(Index: Integer): Integer;
    procedure SetString(Index: Integer; const Value: string);
    procedure SetAsInt(Index: Integer; const Value: Integer);
  public
    constructor Create(const Text: string; const SplitDelimiter: string = '');
    destructor Destroy; override;
  end;

{ TStringsImpl }

constructor TStringsImpl.Create(const Text: string; const SplitDelimiter: string);
begin
  FStrings := TStringList.Create;
  if SplitDelimiter <> '' then
    FStrings.Text := StringReplace(Text, SplitDelimiter, #13#10, [rfReplaceAll])
  else
    FStrings.Text := Text;
end;

destructor TStringsImpl.Destroy;
begin
  FStrings.Free;
  inherited;
end;

function TStringsImpl.GetAsInt(Index: Integer): Integer;
begin
  Result := StrToIntDef(FStrings[Index], 0);
end;

function TStringsImpl.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TStringsImpl.GetObj: TStrings;
begin
  Result := FStrings;
end;

function TStringsImpl.GetString(Index: Integer): string;
begin
  Result := FStrings[Index];
end;

procedure TStringsImpl.SetAsInt(Index: Integer; const Value: Integer);
begin
  FStrings[Index] := IntToStr(Value);
end;

procedure TStringsImpl.SetString(Index: Integer; const Value: string);
begin
  FStrings[Index] := Value;
end;

{ Helper }
function SplitEx(const Text, Separator: string): IStrings;
begin
  Result := TStringsImpl.Create(Text, Separator) as IStrings;
end;

function GetMD5(pw: string): string;
begin
  with TIdHashMessageDigest5.Create do
    try
      Result := HashStringAsHex(pw, IndyTextEncoding_UTF8);
    finally
      Free;
    end;
end;

function fCrypt(strSenha: String): String;
var
  LOld, LNew: Char;
  LPos, LIndex: Integer;
begin
	Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

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
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For LIndex := Length(strSenha) Downto 1 Do
  Begin
    LOld := strSenha[LIndex];
    LPos := Pos(LOld, STR_CHAR_TROCA);
    LNew := STR_CHAR_SENHA[LPos];
  	Result := Result + LNew;
  End;
end;

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

function fNow: TDateTime;
begin
  Result := fRetDtaHraServidor;
end;

function VS_Date(AServerDate: Boolean = True): TDateTime;
begin
  if AServerDate And (MinutesBetween(now(), FUltimaConsultaVS_Date) > 1) then
  begin
    FVS_Date := fRetDataServidor;
    FUltimaConsultaVS_Date := Now();
  end;
  Result := FVS_Date;
end;

procedure WriteLog(AText: string; AForceLog: Boolean = False; ASize: Integer = -1);
begin
  if AText.Length < ASize then AText := fPadR(AText, ASize);
  if HasParam('--logsactive') Or AForceLog then
    Writeln(Format('[%s] [%d] [%s]', [FormatDateTime('yyyy-MM-dd hh:mm:ss', Now()),
      TThread.CurrentThread.ThreadID, AText]));
end;

procedure WriteError(AText: string);
begin
  VS_strUltimaMensagem := AText;
  Writeln(Format('[%s] [%d] [%s]', [FormatDateTime('yyyy-MM-dd hh:mm:ss', Now()),
    TThread.CurrentThread.ThreadID, AText]));
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
      WriteError(E.ClassName + ': ' + E.Message);
      If assigned(stlRetorno) Then
        FreeAndNil(stlRetorno);
    End;
  End;

End;

function GetParamValue(AParamID: String): String;
Var
  I: Integer;
begin
  Result := '';
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID) then
    begin
      Result := ParamStr(I);
      Result := Result.Replace(AParamID, '');
      Break;
    end;
end;

function HasParam(AParamID: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID) then
      exit(True);
end;

procedure SaveTextToFile(AText, AFileName: String);
var
  LArq: TextFile;
begin
  AssignFile(LArq, AFileName);
  try
    Rewrite(LArq);
    Writeln(LArq, AText);
  finally
    CloseFile(LArq);
  end;
end;

Procedure SalvaComoUTF8(AText, AFileName: String);
const
  cUTF8 = $BFBBEF;
var
  W_TXT: UTF8String;
  fs: TFileStream;
  wBOM: Integer;
begin
  W_TXT:= Utf8Encode(AText.Replace(#12,#0));
  fs:= Tfilestream.create( AFileName, fmCreate );
  try
    wBOM := cUTF8;
    //aqui est· o "segredo"...
    //inserir o B.O.M. no inÌcio do arquivo, antes do texto.
    fs.WriteBUffer( wBOM, sizeof(wBOM)-1);
    //aqui, grava o texto que nos interessa...
    fs.WriteBuffer( W_TXT[1], Length(W_TXT)*Sizeof( W_TXT[1] ));
  finally
    fs.free
  end;
end;

function ExecuteCurlRequest(AComand: String; ASilent: Boolean; var AHeader: TStrings): String;
Var
  LDirectory: String;
  LStdout: String;
  LStderr: String;
  LStdHeader: String;
  LFile: TStringList;
begin
{$IFDEF DEBUG}
  WriteLog(AComand);
{$ENDIF DEBUG}
  LDirectory := GetCurrentDir + '/temp';

  If Not DirectoryExists(LDirectory) Then
    CreateDir(LDirectory);

  If ASilent Then
    AComand := AComand + ' --fail --silent --show-error';

  LStdout := LDirectory + '/' + GetMD5(AComand + 'OUT' + DateTimeToStr(fNow));
  LStderr := LDirectory + '/' + GetMD5(AComand + 'ERR' + DateTimeToStr(fNow));
  LStdHeader := LDirectory + '/' + GetMD5(AComand + 'HEAD' + DateTimeToStr(Now()));

  LFile := TStringList.Create;
  Try
    ShellExecute(AComand + ' -D  '+ LStdHeader + ' 1> ' + LStdout + ' 2> ' + LStderr);//stdout e stderr
    LFile.LoadFromFile(LStdout, TEncoding.UTF8);
    Result := LFile.Text;
    If Result.IsEmpty Then
    Begin
      LFile.LoadFromFile(LStderr, TEncoding.UTF8);
      Result := LFile.Text;
    End;

    if not Assigned(AHeader) then
      AHeader := TStringList.Create;
    AHeader.LoadFromFile(LStdHeader, TEncoding.UTF8);
  Finally
    FreeAndNil(LFile);
    If FileExists(LStdout) Then
      DeleteFile(LStdout);
    If FileExists(LStderr) Then
      DeleteFile(LStderr);
  End;
 {$IFDEF DEBUG}
  WriteLog(Result);
 {$ENDIF DEBUG}
end;

function FormatJson(AJson: String): String;
var
  LObj: TJSONValue;
begin
  Try
    LObj := TJSONObject.ParseJSONValue(AJson);
    Result := LObj.Format;
    FreeAndNil(LObj);
  Except
    Result := AJson;
  End;
end;

procedure SET_OOM_SCORE_ADJ(AValue: Integer = -1000);
begin
//  ShellExecute(Format('sudo echo %d > /proc/%d/oom_score_adj', [AValue, getpid]));
end;

function GetMemoryUsage: String;
var
  LMem: string;
begin
  LMem := Trim(ShellExecute(Format('pmap %d | tail -n 1 | awk ''{print $2}''', [getpid])));
  if LMem.EndsWith('K') then
    LMem := Floor(StrToFloatDef(LMem.Replace('K', ''), 0) / 1000).ToString + ' MB';
  Result := LMem;
end;

function GetStackTrace: String;
begin
  Result := Trim(ShellExecute('pstack ' + getpid.ToString));
end;

function ExecuteCurl(AComand, ADataFile, AGetPost: String; ANewAttemptOnFail: Boolean; var AHeader: TStrings): String;
Var
  LTentativas: Integer;
  LFileName: String;
  LDirectory: String;
begin
  LTentativas := 1;

  Try
    LDirectory := GetCurrentDir + '/temp';

    If Not DirectoryExists(LDirectory) Then
      CreateDir(LDirectory);

    LFileName := LDirectory + '/' + GetMD5(AComand + 'DATAFILE' + DateTimeToStr(fNow));

    If Not fEmptyStr(ADataFile) Then
    Begin
      SaveTextToFile(ADataFile, LFileName);
      AComand := AComand + ' --data @' + LFileName;
    End;

    Repeat
      Try
        Result := ExecuteCurlRequest(AComand, True, AHeader);

        If (Pos('the requested url returned error:', Result.ToLower) > 0) Then
          Result := Result + #13#10 + FormatJson(ExecuteCurlRequest(AComand, False, AHeader));//Para mais detalhes (json com erros);

        If (Pos('the requested url returned error: 401', Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('couldn''t connect to host', Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('couldn''t resolve host', Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('timed out', Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('time-out', Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('timeout', Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('failed connect', Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('504 GATEWAY_TIMEOUT'.ToLower, Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('Bad Gateway'.ToLower, Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('SSL connect error'.ToLower, Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('SSL read'.ToLower, Result.ToLower) > 0) Then
          Raise Exception.Create(Result);

        If (Pos('the requested url returned error: 422', Result.ToLower) > 0) Then
          Exit;

        If (Pos('"error":', Result.ToLower) > 0) Or (Pos('returned error', Result.ToLower) > 0) Then
          Result := '*' + FormatJson(Result);

        Exit;
      Except
        On E: Exception Do
        Begin
          If (AGetPost <> 'GET') And (Not ANewAttemptOnFail) then
          Begin
            Result := '*' + FormatJson(Result);
            Exit;
          End;

          Sleep(2000);
          Inc(LTentativas);
          If (LTentativas >= 10) Then
            Raise;
          WriteLog('Tentativa ' + LTentativas.ToString + '.');
        End;
      End;
    Until False;
  Finally
    If (Pos('error', Result.ToLower) > 0) Then
      WriteLog('ExecuteCurl -> ' + Result);

    If FileExists(LFileName) Then
      DeleteFile(LFileName);
  End;
end;

function GetIPAddress(): String;
begin
  Result := ShellExecute('hostname -I | cut -f1 -d" "').Trim;
end;

function GetMacAddress(): String;
Var
  I: Integer;
  LParse: TArray<string>;
begin
  Result := ShellExecute('ifconfig | grep ether | awk ''{print $2}''').Trim;

  if not Result.IsEmpty then
    Exit;

  LParse := ShellExecute('ifconfig').Split([' ']);
  For I := Low(LParse) To High(LParse) Do
    If LParse[I].Equals('HW') Or LParse[I].Equals('HWaddr') Then
      exit(LParse[succ(I)]);
end;

function GetComputerNetName(): String;
begin
  Result := ShellExecute('hostname').Trim;
end;

function GetComputerUser(): String;
begin
  Result := ShellExecute('whoami').Trim;
end;

function fMskDigitos(intDigitos: Integer): String;
  Var
    intContador: Integer;
    strMsk1, strMsk2: String;
begin
  strMsk1 := '#,##';
  strMsk2 := '0.';

  If (intDigitos = 0) Then
    intDigitos := 2;

  For intContador := 1 To intDigitos Do
  Begin
    strMsk2 := strMsk2 + '0';
  End;

  Result := strMsk1 + strMsk2;

end;

{ ************************************ }
{ * TRANSFORMA STRING PARA DOUBLE    * }
{ * QUANDO USAVA (S)TRTOFLOAT EM UM     * }
{ * VALOR DE MILHAR EX 1.005,23      * }
{ * OCORRIA ERRO POR CAUSA DO .      * }
{ *********************************AF* }
function fStrToFloat(strValorUnico: String; fltDefault: real = 0): Double;
Begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico, '.', ''), fltDefault);
End;

function fFrac(const fltValor: Double): Double;
begin
  Result := fFormataFloat(fltvalor, 6) - Trunc(fFormataFloat(fltvalor, 6));
end;

function fIsNumber(Const strNumber: String): Boolean;
  Var
    Code: Integer;
    E: Double;
begin
  Result := False;

  If (fEmptyStr(strNumber)) Then
  Begin
    Exit;
  End;

  Val(strNumber, E, Code);
  If (Code = 0) Then //Usado para eliminar o Hint...
  Begin
    E := 0;
    Result := True;
  End;

  If (E = 0) Then
  Begin
  End;
end;

function fFloatToSQL(fltValor: Double): String;
begin
  Result := FormatFloat(fMskDigitos(4),fltValor);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
  Result := StringReplace(Result,',','.',[rfReplaceAll]);
end;

procedure pAtribuirDesconsiderandoVazio(const fldField: IField; const strValue: String);
begin
  If (Not fEmptyStr(strValue)) Then
    fldField.AsString := strValue;
end;

procedure pAtribuirSetandoNullEmVazio(const fldField: IField; const strValue: String);
begin
  If (fEmptyStr(strValue)) Then
    fldField.Value := Null
  Else
    fldField.AsString := strValue;
end;

procedure pAtribuirSetandoClearEmVazio(const fldField: IField; const strValue: String);
begin
  fldField.AsString := strValue;
  If fEmptyStr(strValue) Then
    fldField.Clear;
end;

procedure pAtribuirSetandoNullEmZero(const fldField: IField; const dtaValue: TDateTime);
begin
  If (dtaValue = 0) Then
    fldField.Value := Null
  Else
    fldField.AsDateTime := dtaValue;
end;

(*function FormatFloat(const Format: string; Value: Double): string;
{$IFDEF LINUX}
const
  FormatDecimalSeparator = '.';
Var
  Digits: Integer;
  NewValue: Double;
  Diference: Double;
{$ENDIF}
begin
  //Delphi build windows - autcom.exe - FormatFloat('#,##0.00', 82.075) = '82.07' -> Trunca
  //Delphi build linux   - services   - FormatFloat('#,##0.00', 82.075) = '82.08' -> Arredonda
{$IFDEF LINUX}
  If Format.Contains(FormatDecimalSeparator) Then
  Begin
    Digits := Length(Format) - Pos(FormatDecimalSeparator, Format);
    NewValue := fFormataFloat(Value, Digits, RoundFiveDown);
    Diference := Abs(Value - NewValue);
    if (Diference <> 0) And (Diference <= Power(10, -Digits)) then
      Value := NewValue;
  End;
{$ENDIF}
  Result := System.SysUtils.FormatFloat(Format, Value);
end;*)

function fFormataFloat(fltNumero: Double; intDecimais: Integer; RoundFiveMode: TRoundFiveMode = RoundFiveUp): Double;
Var
  intDig: Integer;
  strVal: String;
begin
  strVal := FloatToStr(fltNumero);

  { ******************************* }
  { * SE O VALOR POSSUIR DECIMAIS * }
  { ****************************JC* }
  If Pos(FormatSettings.DecimalSeparator, strVal) > 0 Then
  Begin
    intDig := Length(strVal) - Pos(FormatSettings.DecimalSeparator, strVal);
    {************************************************************************************}
    {* SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA OU *}
    {* SUBSTITUI O ULTIMO DIGITO DE "5" PARA "4" FORCANDO O ARREDONDAMENTO PARA BAIXO   *}
    {*********************************************************************************JC*}
    If (intDig > 0) And (intDig > intDecimais) And (strVal[Length(strVal)] = '5') Then
    Begin
      case RoundFiveMode of
        RoundFiveUp  : strVal[Length(strVal)] := '6';
        RoundFiveDown: strVal[Length(strVal)] := '4';
      end;
    End;
  End;

  { ************************************************************ }
  { * CONTINUA FORMATANDO IGUAL ERA COM A FUNCAO fFormataFloat * }
  { *********************************************************JC* }
  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12,
    intDecimais));
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
  strCaracEsp := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹';

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
end;

function fConPagComEntrada(strConPag: String): Boolean;
Var
  strTmpConPag: String;
Begin
  strTmpConPag := fTiraCaracEspeciaisParenteses(strConPag);
  strTmpConPag := ReplaceStr(strTmpConPag, '.', '');
  Result := (Pos('000', fFormataCondPag(strTmpConPag)) > 0);
end;

function IIF(lTest: Boolean; vExpr1, vExpr2: Variant): Variant;
begin
  if lTest then
    Result := vExpr1
  else
    Result := vExpr2
end;

function fEmptyStr(strString: String;
  blnTiraCaracEspecial: Boolean = False): Boolean;
begin
  If blnTiraCaracEspecial Then
    strString := fTiraCaracEspeciais(strString, True, True, True, True, True);

  Result := False;
  strString := fTiraEnter(strString);

  If fTiraEspacos(strString) = '' Then
    Result := True;
end;

function IfEmptyStr(strValor, strDefault: String): String;
begin
  Result := strValor;
  If fEmptyStr(Result) Then
    Result := strDefault;
end;

function fRemoveAcento(Str:String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹—Ò"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCUNn  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
Var
	LContador : integer;
Begin
  Case intPos Of
  	1 : For LContador := Length(Str) To Tamanho -1 Do
		  	  Str := Str + ' ';
    2 : For LContador := Length(Str) To Tamanho -1 Do
    		  Str := ' ' + Str;
  End;
  Result := Str;
End;

function fEmptyDate(strDate: String): Boolean;
Begin
  Result := fEmptyStr(fTiraCaracEspeciais(strDate));
End;

function fEmptyTime(strTime: String): Boolean;
Begin
  Result := fEmptyStr(Trim(AnsiReplaceStr(strTime, ':', '')));
End;

function IfFloatZero(fltValor, fltDefault: Double): Double;
begin
  Result := fltValor;
  If (fFormataFloat(Result, 4) = 0) Then
    Result := fltDefault;
end;

function fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;

function IfNull(varValor, varDefault: Variant): Variant;
begin
	Result := varValor;
	If (Result = Null) Then
		Result := varDefault;
end;

function fExecutandoPeloPortal(): Boolean;
begin
  Result := False;
end;

function fTiraCaracEspeciais(strTexto: String; blnUsaLista: Boolean = True;
  blnTiraEspacos: Boolean = False; blnTiraPontos: Boolean = False;
  blnTiraDoisPts: Boolean = False; blnTiraTab: Boolean = False;
  blnTiraVirgula: Boolean = True;
  blnTiraAbreviacaoNumero: Boolean = False;
  strCaracterePersonalizado: String = ''): String;
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

  If (blnTiraAbreviacaoNumero) Then
    strLista := strLista + '∫∞';

  If (Not fEmptyStr(strCaracterePersonalizado)) Then
    strLista := strLista + strCaracterePersonalizado;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸Á¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹«';

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

function fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

function fQuotedStr(strString: String): String;
  Var
    strQuote : String;
begin
  strQuote := '''';
  Result := QuotedStr(AnsiDequotedStr(strString, strQuote[1]));
end;

function fReplaceStr(strTexto, strFrom, strTo: String): String;
begin
  Result := AnsiReplaceStr(strTexto, strFrom, strTo);
end;

function fReplaceStr(strTexto: String; arrFrom, arrTo: Array Of String): String;
  Var
    intInd: Integer;
begin
  Result := strTexto;

  For intInd := 0 To Length(arrFrom) -1 Do
    Result := fReplaceStr(Result, arrFrom[intInd], arrTo[intInd]);
end;

function fCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator : String = ', '): String;
  Var
    intContador: Integer;
    strDado: String;
Begin
  Result := '';

  For intContador := 0 To stlListSelecao.Count - 1 Do
  Begin
    If blnQuoted Then
      strDado := QuotedStr(stlListSelecao[intContador])
    Else
      strDado := stlListSelecao[intContador];

    If intContador = 0 Then
      Result := strDado
    Else
      Result := Result + strSeparator +  strDado;
  End;
end;

function fTrimAll(strTexto: String): String;
Var
  c: Char;
  l: Char;
begin
  l := #0;
  Result := '';

  for c in strTexto do
  begin
    if (c = ' ') and (l = ' ') then
      continue;
    l := c;
    Result := Result + c;
  end;

  Result := Trim(Result);
end;

function fTiraEspacos(strTexto: String): String;
begin
  Result := fTrocaCaracter(strTexto, ' ', #0);
end;

function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
Var
  c: Char;
begin
  Result := '';
  for c in strTexto do
    if (c <> chrFrom) then
      Result := Result + c
    Else If chrTo <> #0 Then
      Result := Result + chrTo;
end;

function fStrZero(Zeros: String; Quant: Integer): String; overload;
Var
  I, Tamanho: Integer;
  Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros := '';
  For I := 1 To Tamanho Do
    If Aux[I] <> ',' Then
      Zeros := Zeros + Aux[I];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros := '';
  for I := 1 to Quant - Tamanho do
    Zeros := Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

{*****************************************}
{* RETORNA SE … CLIENTE CONSUMIDOR OU    *}
{* CLIENTE BALCAO                        *}
{***********************************MV*AF*}
function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
begin

  Result := False;

  If Pos('CONSUMIDOR', strNomCli) > 0 Then
    Result := True;

  If blnCliBal Then
  Begin

    If Pos('BALCAO', strNomCli) > 0 Then
      Result := True

    Else If Pos('BALC√O', strNomCli) > 0 Then
      Result := True;

  End;

  If blnSeguradora And (Pos('SEGURADORA', strNomCli) > 0) Then
    Result := True;

end;

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

function fStrZero(Zeros: Integer; Quant: Integer): String;
begin
  fStrZero := fStrZero(IntToStr(Zeros), Quant);
end;

function fTransform(AConteudo: String; AStep: Shortint; AChar: String): String;
  Var
    LAux       : String;
    LPosicao   : Integer;
begin
  LAux := '';

  LPosicao := 1;

  While LPosicao < Length(AConteudo) Do
  Begin
    LAux := LAux + Copy(AConteudo, LPosicao, AStep) + AChar;
    Inc(LPosicao, AStep);
  End;

  Result := LAux;

end;

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

{*****************************************}
{* CALCULA O VALOR DO DOCUMENTO (CART√O) *}
{**************************************MV*}
function fCalculaValDocCartao(fltValTot, fltTaxAdm: Double): Double;
  Var
    LValorTaxaAdministrativa: Double;
begin
  LValorTaxaAdministrativa := fFormataFloat(fltValTot * (fltTaxAdm / 100), 2);
  Result := fFormataFloat(fltValTot - LValorTaxaAdministrativa, 2);
end;

procedure pArredondaParcelaDefault(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
  Var
    fltValPar : Double;
    intIndice : Integer;
begin
  fltValPar := fFormataFloat(fltValTot / intQtdPar, 2);

  arrDigDuplicArray[0].curValor := fltValPar;

  If (fltValPar * intQtdPar < fltValTot) Then
    arrDigDuplicArray[0].curValor := fltValPar + (fltValTot - (fltValPar * intQtdPar));

  For intIndice := 1 To intQtdPar -1 Do
  Begin
    arrDigDuplicArray[intIndice].curValor := fltValPar;

    If (intIndice = intQtdPar -1) Then
    Begin
      If (fltValPar * intQtdPar > fltValTot) Then
        arrDigDuplicArray[intIndice].curValor := fltValPar + (fltValTot - (fltValPar * intQtdPar));
    End;
  End;
end;

procedure pArredondaParcelaRedonda(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray);
  Var
    intIndice : Integer;
begin
  arrDigDuplicArray[0].curValor := Int(fltValTot / intQtdPar);
  arrDigDuplicArray[0].curValor := (arrDigDuplicArray[0].curValor + ( fltValTot - arrDigDuplicArray[0].curValor * intQtdPar ));

  For intIndice := 1 To intQtdPar - 1 Do
    arrDigDuplicArray[intIndice].curValor := Int(fltValTot / intQtdPar);
end;

function fTruncaFloat(fltNumero: Double; intDecimais: Integer): Double;
  Var
    strValor: String;
    intPos: Integer;
begin
  strValor := FloatToStrF(fltNumero, ffNumber, 15, intDecimais+2);

  intPos := Pos(',', strValor);
  If intPos > 0 Then
  Begin
    strValor := Copy(strValor, 1, intPos+intDecimais);
  End;
  Result := fStrToFloat(strValor);
end;

function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;
begin
  Result := dtaOrigem;
  While (fDiaDeFolga(Result, True, IIF(fCfgSis('FEMUCP', varBoolean), strCodCid, ''))) Do
  Begin
    Result := Result + 1;
  End;
end;

function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True;
                     strCodCid: String = ''; blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                     blnConsideraDomingo: Boolean = False): Boolean;
  Const
    SABADO = 7;
    DOMINGO = 1;
begin
  If blnConsideraSabadoAndDomingoComoDiaUtil Then
    Result := fEhFeriado(dtaDta, strCodCid)
  Else
  Begin
    If blnConsideraSabado Then
      Result := (DayOfWeek(dtaDta) In [DOMINGO, SABADO]) Or (fEhFeriado(dtaDta, strCodCid))
    Else If (blnConsideraDomingo) And (DayOfWeek(dtaDta) = DOMINGO) then
      Result := fEhFeriado(dtaDta, strCodCid)
    Else
      Result := (DayOfWeek(dtaDta) = DOMINGO) Or (fEhFeriado(dtaDta, strCodCid));
  End;
end;

function fEhFeriado(dtaDta: TDateTime; strCodCid: String = ''): Boolean;
  Var
    intCont: Integer;
    strDTa: String;
begin
  intCont := 0;
  strDta := FormatDateTime('yyyy-mm-dd', dtaDta);

  intCont := intCont + fCampoTabela('COUNT(*) AS QTD', 'CADFER', ['FER_DTAFER'], [strDta], False);
  If Not fEmptyStr(strCodCid) Then
  Begin
    intCont := intCont + fCampoTabela('COUNT(*) AS QTD', 'FERCID', ['FCI_DTAFER', 'FCI_CODCID'], [strDta, strCodCid], False);
  End;

  Result := intCont > 0;
end;

function fDocumeCar(strNumDoc, strEspDoc, strCodEmp: String; intContador: Integer; blnComCnt: Boolean = True): String;
begin
  Result := strNumDoc + '-A-' + strEspDoc + '-' + strCodEmp + '-000-';
  If (blnComCnt) Then
    Result := Result + fStrZero(intContador, 2);
end;

{**************************************}
{* ADICIONA DADOS EM UMA MATRIZ       *}
{***********************************WI*}
procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False);
Begin
  If (Pos(#13#10, strTexto) > 0) And blnConsiderarEnter Then
  Begin
    While Pos(#13#10, strTexto) > 0 Do
    Begin
      SetLength(arrAdd, Length(arrAdd) + 1);

      arrAdd[High(arrAdd)] := LeftStr(strTexto, Pos(#13#10, strTexto) -1);
      strTexto := Copy(strTexto, Pos(#13#10, strTexto) + 2, Length(strTexto));

      If Pos(#13#10, strTexto) <= 0 Then
      Begin
        SetLength(arrAdd, Length(arrAdd) + 1);
        arrAdd[High(arrAdd)] := strTexto;
      End;
    End;
  End
  Else
  Begin
    SetLength(arrAdd, Length(arrAdd) + 1);
    arrAdd[High(arrAdd)] := strTexto;
  End;
End;

procedure pAddDados(Var arrAdd, arrHin : TStringArray; strTexto: String; strHint : String = ''; blnConsiderarEnter: Boolean = False);
Begin
  If (Pos(#13#10, strTexto) > 0) And blnConsiderarEnter Then
  Begin
    While Pos(#13#10, strTexto) > 0 Do
    Begin
      SetLength(arrAdd, Length(arrAdd) + 1);

      arrAdd[High(arrAdd)] := LeftStr(strTexto, Pos(#13#10, strTexto) -1);
      strTexto := Copy(strTexto, Pos(#13#10, strTexto) + 2, Length(strTexto));

      If Pos(#13#10, strTexto) <= 0 Then
      Begin
        SetLength(arrAdd, Length(arrAdd) + 1);
        arrAdd[High(arrAdd)] := strTexto;
      End;
    End;
  End
  Else
  Begin
    SetLength(arrAdd, Length(arrAdd) + 1);
    arrAdd[High(arrAdd)] := strTexto;
  End;

  SetLength(arrHin, Length(arrHin) + 1);
  arrHin[High(arrHin)] := strHint;
End;

function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;
Var
  intMes : Integer;
Const
  arrMes : Array[0..12] Of String[10] = ('','ENERO',
                                            'FEBRERO',
                                            'MARZO',
                                            'ABRIL',
                                            'MAYO',
                                            'JUNIO',
                                            'JULIO',
                                            'AGOSTO',
                                            'SEPTIEMBRE',
                                            'OCTUBRE',
                                            'NOVIEMBRE',
                                            'DICIEMBRE');
Begin
  intMes := MonthOf(dtaData);

  Result := String(arrMes[intMes]);

  If intTam = 1 Then
    Result := copy(Result,1,3);
End;

function fExt1(strS : String; strIdioma: String = 'P') : String;
Begin

  Case Length(strS) Of
    1 : Result := fExtUnidade(strS[1], strIdioma);
    2 : Result := fExtDezena(strS[1] + strS[2], strIdioma);
    3 : If strS[2] + strS[3] = '00'  Then
        Begin
          If strIdioma = 'P' Then
      			Result := String(CentenaPor[StrToInt(strS[1])]);
          If strIdioma = 'E' Then
      			Result := String(CentenaEsp[StrToInt(strS[1])]);
          If strIdioma = 'I' Then
      			Result := String(CentenaIng[StrToInt(strS[1])]);
        End
  			Else
        Begin
          If strIdioma = 'P' Then
          Begin
            If strS[1] = '1' Then
              Result := 'CENTO E ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaPor[StrToInt(strS[1])]) + 'E ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
          If strIdioma = 'E' Then
          Begin
            If strS[1] = '1' Then
              Result := 'CIENTO Y ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaEsp[StrToInt(strS[1])]) + 'Y ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
          If strIdioma = 'I' Then
          Begin
            If strS[1] = '1' Then
              Result := 'ONE HUNDRED AND ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaIng[StrToInt(strS[1])]) + 'AND ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
        End;
  End;

End;

function fExt2(strS : string; strIdioma: String = 'P') : string;
begin

  If (strIdioma = 'P') Or ((strIdioma = 'E')) Then
  Begin
    Case Length(strS) of
      4 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MIL ' + fExt1(Copy(strS,2,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      5 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MIL ' + fExt1(Copy(strS,3,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      6 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MIL ' + fExt1(Copy(strS,4,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If strIdioma = 'I' Then
  Begin
    Case Length(strS) of
      4 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,2,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      5 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,3,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      6 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,4,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

end;

function fExt3(strS : string; strIdioma: String = 'P') : string;
begin

  If (strIdioma = 'P') Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILH√O '
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILH’ES '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILH’ES '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If (strIdioma = 'E') Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILLON '
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILLONES '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILLONES '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If strIdioma = 'I' Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILLION '
          Else
            Result := fExt2(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILLIONS '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILLIONS '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

end;

function fExtUnidade(strS : String; strIdioma: String = 'P') : String;
begin
  If strIdioma = 'P' Then
  	Result := String(UnidadePor[StrToInt(strS[1])]);
  If strIdioma = 'E' Then
  	Result := String(UnidadeEsp[StrToInt(strS[1])]);
  If strIdioma = 'I' Then
  	Result := String(UnidadeIng[StrToInt(strS[1])]);
end;

function fExtDezena(strS : String; strIdioma: String = 'P') : String;
begin
  If strS[1] <> '1' Then
  	If strS[2] <> '0' Then
			If strS[1] <> '0' Then
      Begin
        If strIdioma = 'P' Then
       		Result := String(DezenaPor[StrToInt(strS[1])] + 'E ' + UnidadePor[StrToInt(strS[2])]);
        If strIdioma = 'E' Then
       		Result := String(DezenaEsp[StrToInt(strS[1])] + 'Y ' + UnidadeEsp[StrToInt(strS[2])]);
        If strIdioma = 'I' Then
       		Result := String(DezenaIng[StrToInt(strS[1])] + 'AND ' + UnidadeIng[StrToInt(strS[2])]);
      End
     	Else
      Begin
        If strIdioma = 'P' Then
        	Result := String(UnidadePor[StrToInt(strS[2])]);
        If strIdioma = 'E' Then
        	Result := String(UnidadeEsp[StrToInt(strS[2])]);
        If strIdioma = 'I' Then
        	Result := String(UnidadeIng[StrToInt(strS[2])]);
      End
  	Else
    Begin
      If strIdioma = 'P' Then
        Result := String(DezenaPor[StrToInt(strS[1])]);
      If strIdioma = 'E' Then
        Result := String(DezenaEsp[StrToInt(strS[1])]);
      If strIdioma = 'I' Then
        Result := String(DezenaIng[StrToInt(strS[1])]);
    End
  Else
  {Dezena = 1}
  Begin
    If strIdioma = 'P' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'DEZ ';
        '1' : Result := 'ONZE ';
        '2' : Result := 'DOZE ';
        '3' : Result := 'TREZE ';
        '4' : Result := 'QUATORZE ';
        '5' : Result := 'QUINZE ';
        '6' : Result := 'DEZESSEIS ';
        '7' : Result := 'DEZESSETE ';
        '8' : Result := 'DEZOITO ';
        '9' : Result := 'DEZENOVE ';
      End;
    End;
    If strIdioma = 'E' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'DEIZ ';
        '1' : Result := 'ONCE ';
        '2' : Result := 'DOCE ';
        '3' : Result := 'TRECE ';
        '4' : Result := 'CATORCE ';
        '5' : Result := 'QUINCE ';
        '6' : Result := 'DIECISEIS ';
        '7' : Result := 'DIECISIETE ';
        '8' : Result := 'DIECIOCHO ';
        '9' : Result := 'DIECINUEVE ';
      End;
    End;
    If strIdioma = 'I' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'TEN ';
        '1' : Result := 'ELEVEN ';
        '2' : Result := 'TWELVE ';
        '3' : Result := 'THIRTEEN ';
        '4' : Result := 'FOURTEEN ';
        '5' : Result := 'FIFTEEN ';
        '6' : Result := 'SIXTEEN ';
        '7' : Result := 'SEVENTEEN ';
        '8' : Result := 'EIGHTEEN ';
        '9' : Result := 'NINETEEN ';
      End;
    End;
  End;
end;

function VarToString(Const AValue: Variant): String;
begin
  Case TVarData(AValue).VType Of
    varSmallInt,
    varInteger   : Result := IntToStr(AValue);
    varSingle,
    varDouble,
    varCurrency  : Result := FloatToStr(AValue);
    varDate      : Result := FormatDateTime('dd/mm/yyyy', AValue);
    varBoolean   : Result := BoolToStr(AValue, True);
    varString,
    varUString   : Result := AValue;
    Else           Result := '';
  End;
end;

function fArrCodigosToLista(strCodigo: String; arrCodigos: TConsultasArray; blnQuoted: Boolean = True): String;
  Var
    intContador: Integer;
Begin
  Result := '';

  For intContador := Low(arrCodigos) To High(arrCodigos) Do
    With arrCodigos[intContador] Do
    Begin
      If blnQuoted Then
        Result := Result + QuotedStr(strCodigo)
      Else
        Result := Result + strCodigo;

      If intContador <> High(arrCodigos) Then
        Result := Result + ',';
    End;

  If fEmptyStr(Result) And (Not fEmptyStr(strCodigo)) Then
  Begin
    If blnQuoted Then
      Result := QuotedStr(strCodigo)
    Else
      Result := strCodigo;
  End;
End;

{**********************************************************}
{*Cod. de Barras -> 7  8  9  1  2  3  4  5  0  0  0  1  ? *}
{*Enumere  Pos.  ->13 12 11 10 09 08 07 06 05 04 03 02 01 *}
{*                                                        *}
{*Some as Colunas Pares   -> 8 + 1 + 3 + 5 + 0 + 1 = 18   *}
{*                          12  10  08  06  04  05        *}
{*                                                        *}
{*Multiplique o Result. P/ 3 -> 18 * 3 = 54               *}
{*                                                        *}
{*                                                        *}
{*Some as colunas Impares -> 7 + 9 + 2 + 4 + 0 + 0 = 22   *}
{*                          13  11  09  07  05  03        *}
{*                                                        *}
{*Some os Resultados -> 54 + 22 == 76                     *}
{*                                                        *}
{*Subtraia o Multiplo de Dez Maior Que Ele(80) do         *}
{*Resultado Encontrado( 76 ) ---> 80-76 = 4               *}
{*                                                        *}
{*                                                        *}
{*O Digito Verificador È --> 4                            *}
{**********************************************************}
function fGeraCodBarraEAN13(strCodigo: String): String;
  Var
    intContador: Integer;
    intSomaPar: Integer;
    intSomaImp: Integer;
    intTotal: Integer;
    intMultiplo: Integer;
    intResto: Integer;
begin

  Result := '';
  If (Length(strCodigo) <> 12) Then
  Begin
    Exit;
  End;

  intSomaPar := 0;
  intSomaImp := 0;

  For intContador := 1 To Length(strCodigo) Do
  Begin
    If intContador Mod 2 = 0 Then
      intSomaPar := intSomaPar + StrToIntDef(strCodigo[intContador], 0)
    Else
      intSomaImp := intSomaImp + StrToIntDef(strCodigo[intContador], 0);
  End;
  intSomaPar := intSomaPar * 3;
  intTotal   := intSomaPar + intSomaImp;
  intResto   := intTotal Mod 10;

  If intResto =  0 Then
    intMultiplo := intTotal
  Else
    intMultiplo := intTotal + (10 - (intResto));

  Result := strCodigo + IntToStr(intMultiplo - intTotal);

end;

function fRetStrToSQLIn(strValores: String; strDelimitador: String): String;
var
  arrValores : TArray<String>;
  intContador: Integer;
  strResultado: String;
Begin
  arrValores := strValores.Split(strDelimitador);

  For intContador := 0 To Length(arrValores)-1 Do
  Begin
    if strResultado = '""' then
      strResultado := '';

    if not fEmptyStr(strResultado) then
      strResultado := strResultado + ', "' + arrValores[intContador] + '"'
    else
      strResultado := '"' + arrValores[intContador] + '"';
  end;

  Result := strResultado;
End;

function fRetStrToSQLArr(strValores: String; strDelimitador: String = '_'): TArray<Variant>;
Var
  stlListEmp: TStringList;
  intCont_: Integer;
Begin
  stlListEmp := TStringList.Create;

  stlListEmp.Delimiter := '_';
  stlListEmp.DelimitedText := strValores;
  SetLength(Result, stlListEmp.Count);

  For intCont_ := 0 To stlListEmp.Count -1 Do
  Begin
    If  stlListEmp.Strings[intCont_] <> '' Then
      Result[intCont_] := stlListEmp.Strings[intCont_];
  End;

  FreeAndNil(stlListEmp);
End;

function fTemTagMsgOculta(Const strTexto: String): Boolean;
begin
  Result := (Pos(STRING_MENSAGEM_OCULTA_INI, strTexto) > 0) And
            (Pos(STRING_MENSAGEM_OCULTA_FIM, strTexto) > 0);
end;

function fLimpaTagMsgOculta(Const strTexto: String): String;
begin
  Result := strTexto;
  If fTemTagMsgOculta(strTexto) Then
  Begin
    Result := AnsiReplaceStr(Result, STRING_MENSAGEM_OCULTA_INI, '');
    Result := AnsiReplaceStr(Result, STRING_MENSAGEM_OCULTA_FIM, '');
  End;
end;

function fRetArrToSQLIn(arrValores: TConsultasArray; strCodigo: String): String;
  Var
    strForAux: TConsultas;
Begin
  Result := '';
  If Length(arrValores) > 0 Then
  Begin
    For strForAux In arrValores Do
      Result := Result + '"' + strForAux.strCodigo + '",';
    Result := LeftStr(Result, Length(Result) - 1);
  End
  Else
    Result := '"' + strCodigo + '"';
End;

function fGeraCodBarraEAN39(strCodigo: String): String;
Begin
  Result := fStrZero(strCodigo, 8);
End;

function fDateTimeToUnix(dtahor: TDateTime): Int64;
begin
  Result := MilliSecondsBetween(dtaHor, UnixDateDelta);
end;

function fRetCoordenada(strCoordenada: String; LatLon: TLatLon): Extended;
begin
  Result := StrToFloatDef(AnsiReplaceStr(IIF(LatLon = coorLat,
                                             Copy(strCoordenada, 0, Pos(',', strCoordenada)-1),
                                             Copy(strCoordenada, Pos(',', strCoordenada)+1)), '.', ','), 0);
end;

function fTime(const AForceTime: Boolean = False) : TDateTime;
var
  LConn: IConnection;
begin
  if (AForceTime) then
    Exit(untHorarioSistema.GetTime());

  if objConnectionsManager = nil then
    Exit(untHorarioSistema.GetTime());

  if not objConnectionsManager.FindConnection(TThread.CurrentThread.ThreadID, LConn) then
    Exit(untHorarioSistema.GetTime());

  Result := untHorarioSistema.GetTime(VS_strCodEmp, LConn);
end;

function AdicionarMascaraCpfCnpj(const Documento: string): string;
var
  LimpaDoc: string;
begin
  // Remove todos os caracteres n„o numÈricos
  LimpaDoc := StringReplace(Documento, '[^0-9]', '', [rfReplaceAll, rfIgnoreCase]);

  case Length(LimpaDoc) of
    11:
      // Formata CPF
      Result := Format('%s.%s.%s-%s',
                       [Copy(LimpaDoc, 1, 3),
                        Copy(LimpaDoc, 4, 3),
                        Copy(LimpaDoc, 7, 3),
                        Copy(LimpaDoc, 10, 2)]);
    14:
      // Formata CNPJ
      Result := Format('%s.%s.%s/%s-%s',
                       [Copy(LimpaDoc, 1, 2),
                        Copy(LimpaDoc, 3, 3),
                        Copy(LimpaDoc, 6, 3),
                        Copy(LimpaDoc, 9, 4),
                        Copy(LimpaDoc, 13, 2)]);
  end;
end;

function fSeqContaBanco(intQtdCod: Integer = 1): String;
  Var
    strSequen: String;
    LTransacao: IConnection;

    function fSequenCadastrado: Boolean;
      Var
        qryGenTmp : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    begin
      qryGenTmp := LTransacao.CreateQuery();
      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SQL_NO_CACHE CTB_SEQLAN FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN LIMIT 1');
        ParamByName('SEQLAN').AsString := strSequen;
        Open;
        Result := (Not IsEmpty);
        Close;
      End;
    end;

begin
  LTransacao := objConnectionsManager.CurrentConnection;
  Repeat
    LTransacao.StartTransaction;
    strSequen := VS_strCodEmp + fAtualizaProCod('MOVBAN', LTransacao, intQtdCod);
    LTransacao.Commit;
  Until (Not fSequenCadastrado);
  Result := strSequen;
end;

function fRetNumeroEndereco(strEndereco: String): Integer;
var
  strNumero: String;
  intIndice: Integer;
begin
  Result := 0;
  strNumero := EmptyStr;

  strEndereco := Trim(strEndereco);
  if not fEmptyStr(strEndereco) then
  begin
    for intIndice := Length(strEndereco) downto 1 do
    begin
      if (not fEmptyStr(strNumero)) and (Trim(strEndereco[intIndice]) = EmptyStr) then
        Break;

      if CharInSet(strEndereco[intIndice], ['0'..'9']) then
        strNumero := strEndereco[intIndice] + strNumero;
    end;

    if fIsNumber(strNumero) then
      Result := StrToInt(strNumero);
  end;
end;

function fRemoverAtributoDoJson(const AstrJson, AstrAtributoRemover: String): String;
var
  JsonObject: TJSONObject;
  RemovedPair: TJSONPair;
begin
  Result := EmptyStr;

  JsonObject := TJSONObject.ParseJSONValue(AstrJson) as TJSONObject;
  try
    if Assigned(JsonObject) then
    begin
      RemovedPair := JsonObject.RemovePair(AstrAtributoRemover);
      try
        Result := JsonObject.ToJSON;

        if Assigned(RemovedPair) then
          FreeAndNil(RemovedPair)
      except
        if Assigned(RemovedPair) then
          FreeAndNil(RemovedPair);
      end;
    end;
  finally
    FreeAndNil(JsonObject);
  end;
end;

function fRetiraZerosEsquerda(strDado: String): String;
Begin
  While (Length(strDado) > 0) And (strDado[1] = '0') Do
    Delete(strDado, 1, 1);

  Result := strDado;
End;

initialization

FVS_Date := Date;
VS_ComputerNetName := GetComputerNetName;
VS_ComputerUser := GetComputerUser;
VS_UserFromWindows := GetComputerUser;
VS_IPAddressAsString := GetIPAddress;
VS_MacAddress := GetMacAddress;
VS_ProcessId := getpid.ToString;

end.
