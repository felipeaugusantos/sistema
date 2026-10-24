unit untFuncoesSimples;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, untTypesSistema,
{$ELSE}
  UniClientDataset, Controls, Forms, WinAPI.Windows, WinAPI.Messages, Vcl.StdCtrls,
  AppEvnts, frxPreview, madStackTrace, frxClass, untWorkStationInfo,
{$ENDIF}
  httpsend, untIDataset, untInterfacesIntegracaoPixCitel, System.SysUtils, System.StrUtils,
  Data.DB, IdHashMessageDigest, System.DateUtils, System.Classes, PinPad.Interfaces,
  System.Variants;

Var
  VS_FuncoesExternas: IIntegracaoPixCitel;
  VS_TimeZone: Integer;
  VS_LastConnID: String;

Const
  STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#@!';
  STR_CHAR_TROCA = 'ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£#ª°';

{$IFNDEF LINUX}
type
  TFastPreviewReport = class sealed
  private
    FNomPro: String;
    FDesPro: String;
    FReport: TFrxReport;
    FAppEvents: TApplicationEvents;
    FOldPrintBClick: procedure(Sender: TObject) of Object;
  protected
    procedure OnMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure OnPreview(Sender: TObject);
    procedure PrintBClick(Sender: TObject);
  private
    constructor Create;
  public
    destructor Destroy; override;
  public
    class procedure PreviewReport(const APrograma, ADescricao: String; AReport: TfrxReport);
  end;
{$ENDIF}

function fCfgSis(ANomeConfiguracao,
                 ACodigoEmpresa: String): String;
function fRetHoraServidor: TTime;
function fRetDataServidor: TDate;
function fNow: TDateTime;
function fStrToFloat(strValorUnico: String; fltDefault: real = 0): Double;
function fTiraCaracEspeciais(strTexto      : String;
                             blnUsaLista   : Boolean = True;
                             blnTiraEspacos: Boolean = False;
                             blnTiraPontos : Boolean = False;
                             blnTiraDoisPts: Boolean = False;
                             blnTiraTab    : Boolean = False;
                             blnTiraVirgula: Boolean = True;
                             blnTiraAbreviacaoNumero: Boolean = False): String;

function fTiraEnter(strTexto: String): String;
function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;

function GetParamValue(AParamID: String): String;
function HasParam(AParamID: String): Boolean;

{$IFDEF LINUX}
procedure FormatSettings_ptBR;
{$ENDIF}


{$IFNDEF LINUX}
procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
{$ENDIF}

function fRetornaStack: String;
function fCriaDatasetQRCode(ATextoQRCode,
                            AValor: String): TUniClientDataset;

function fStrZero(Zeros:string; Quant:integer):String;

function AbrirCfgRel(ANomeFormulario: String): IDataset;

procedure SelecionaFilaOperadorMaquina(var ADatasetFilas: IDataset);

function RetornaCurrentTimeStampServidor: String;

function RetornaCurrentTimeStampServidorDataHora: TDateTime;

function RetornaCNPJEmpresaLogada: String;

function RetornaCNPJEmpresaSelecionada(ACodigoEmpresa: String): String;

function GetMD5(const strTexto: string): string;

function fGetConnectionID: String;

Function fRetEmpresaFisica: String;

function fDecrypt(ASenha: String): String;

{$IFNDEF LINUX}
function KeyIsDown(const Key: Integer): Boolean;
procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport);
procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport);
{$ENDIF}

procedure GravarLogErr_Pix(ADescricao,
                           ARelatorio: String; const ANumTer: String = '');

procedure GravarLogAPI(const AApi, AResource, AMethod, ABody, AResponse: string; HTTPSend: THTTPSend);

function RetornaDadosEmpresaLogada(AEmpresaConfiguracao: String): IDataset;
function RetornaDadosEmpresaPix(AEmpresaConfiguracao, AAutoIncremChavePix, ADadosEmpresa: String): IDataset;

function RetornaNomeDoBanco(ACodigoDoBanco: String): String;

function RetornaTimeStampEmMilisegundos: Int64;

{$IFNDEF LINUX}
function PegaTimeZone: Integer;
{$ENDIF}

procedure AdicionaAlteraConfiguracao(ACodigoCfg,
                                     AValorCfg,
                                     AEmpresaCfg,
                                     ADescricaoCfg,
                                     AGrupoCfg: String);

function IIF(ACondicao: Boolean;
             AResultadoVerdadeiro,
             AResultadoFalso: Variant): Variant;

function GetUserFromWindows: string;
function GetComputerNetName: string;

{$IFNDEF LINUX}
function fInstanciaPinPad(var AstrNumTer: String): IPinPadCitel;
function fObtemFabricantePinPad: TPinPadCitelFabricantes;
function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
function TimeZoneLocal : Integer;
function LocalTimeToUTC(const AValue: TDateTime): TDateTime;
{$ENDIF}

procedure pEnviaQrCodeInterno(const AstrTextoQrCode, AstrTituloInformativo: String; const APinPad: IPinPadCitel) ;
procedure pLimpaQrCodeInterno(const APinPad: IPinPadCitel) ; overload ;
procedure pLimpaQrCodeInterno(const APinPad: IPinPadCitel; const AMsgPinPad: String) ; overload ;
function fNomeArquivoValido(const ATexto: string): string;
procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);
function fMensagemEncerramentoTEF: AnsiString ;
procedure pCarregaConfiguracaoTerminalPinPad(var AstrPorta, AstrFabricante, AstrNumTer: String) ;
function fTrataTefCitTerminal: String ;
function fSqlFiltroTerminalTefCit: String ;
function fCampoExiste(const AstrTabela, AstrCampo: String; const blnUsarCache : Boolean = False): Boolean ;
function PathWithDelim(const APath : AnsiString) : AnsiString ;
function fLimpaCaracteresTelefone(const ATelefone: String): String;
function RetornaDiferencaSegundos(ADataMaquina,
                                  ADataServidor: TDateTime): Int64;

function fTime : TDateTime;

function fTabelaExiste(strNomTab: String): Boolean;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  PinPad.Classes.PinPadFactory, untSpoolImpressao, untSpoolPrintDialog,
{$ENDIF}
  AnsiStrings, System.IniFiles;

function PathWithDelim(const APath : AnsiString) : AnsiString ;
begin
  Result := AnsiString(Trim(String(APath))) ;
  if Result <> '' then
  begin
     {$IfDef FPC}
      Result := IncludeTrailingPathDelimiter(Result);
     {$Else}
      if AnsiStrings.RightStr(Result,1) <> String(PathDelim) then
         Result := Result + PathDelim ;
     {$EndIf}
  end;
end ;

function fLimpaCaracteresTelefone(const ATelefone: String): String;
var
  LContador: Char;
begin
  Result := '';
  for LContador in ATelefone do
    if CharInSet(LContador, ['0'..'9']) then
      Result := Result + LContador;
end;

function fMensagemEncerramentoTEF: AnsiString ;
const
  NOME_ARQUIVO = 'CliSiTef.ini' ;
var
  LstrMsg: String ;
  LstrPathDll: String ;
  LstrPorta, LstrFabricante, LstrNumTer: String ;
  LstrNomeArquivo: String ;
  LfileIni: TIniFile;
begin
  Result := '' ;
  if fCfgSis('TEFCIT', VS_FuncoesExternas.fGetEmpresaLogada) = 'S' then
  begin
    LstrPathDll := fCfgSis('PTTFCT', VS_FuncoesExternas.fGetEmpresaLogada) ;
    if Trim(LstrPathDll) <> '' then
    begin
      pCarregaConfiguracaoTerminalPinPad(LstrPorta, LstrFabricante, LstrNumTer) ;
      LstrPathDll := String(PathWithDelim(AnsiString(LstrPathDll)))+LstrNumTer ;
    end
    else
    begin
      LstrPathDll := String(ExtractFileDir(Application.ExeName)) ;
    end ;
    LstrNomeArquivo := String(PathWithDelim(AnsiString(LstrPathDll)))+NOME_ARQUIVO ;
    if FileExists(LstrNomeArquivo) then
    begin
     {$IFDEF LINUX}
      LfileIni := TIniFile.Create(LstrNomeArquivo, TEncoding.ANSI);
     {$ELSE}
      LfileIni := TIniFile.Create(LstrNomeArquivo);
     {$ENDIF}
      try
        Result := AnsiString(LfileIni.ReadString( 'PinPad', 'MensagemPadrao', '' )) ;
      finally
        FreeAndNil(LfileIni);
      end;
    end ;
  end
  else if fCfgSis('TEFCIT', VS_FuncoesExternas.fGetEmpresaLogada) = 'T' then
  begin
    LstrMsg := fCfgSis('PP_MSG', VS_FuncoesExternas.fGetEmpresaLogada) ;
    LstrMsg := Trim(copy(StringReplace(LstrMsg, '|', '', []), 1,32)) ;
    Result := AnsiString(LstrMsg) ;
  end ;
end ;

procedure pCarregaConfiguracaoTerminalPinPad(var AstrPorta, AstrFabricante, AstrNumTer: String) ;
var
  LConsulta: IDataset;
  LUserFromWindows : String ;
  LComputerNetName : String ;
  LWorkStationIP   : String ;
  LWorkstationID   : String ;
  LstrTipoTerminal: String ;
  LstrTefCit: String ;
begin
  AstrPorta := '' ;
  AstrFabricante := '' ;
  AstrNumTer := '' ;
  if not fCampoExiste('TEFCFG', 'TFC_PINPOR') then
    Exit ;

  if not fCampoExiste('TEFCFG', 'TFC_PINFAB') then
    Exit ;

  LUserFromWindows := GetUserFromWindows ;
  LComputerNetName := GetComputerNetName ;
  LWorkStationIP   := {$IFDEF LINUX}GetIPAddressAsString{$ELSE}TWorkStationInfo.fGetWorkStationIP{$ENDIF};
  LWorkstationID   := {$IFDEF LINUX}GetComputerNetName{$ELSE}TWorkStationInfo.fGetWorkStationID{$ENDIF};
  LstrTipoTerminal   := fCfgSis('TIPTER', VS_FuncoesExternas.fGetEmpresaLogada) ;
  LstrTefCit         := fCfgSis('TEFCIT', VS_FuncoesExternas.fGetEmpresaLogada) ;
  if LstrTipoTerminal = '1' then
  begin
    LConsulta := VS_FuncoesExternas.fGetDataset;
    LConsulta.Close ;
    LConsulta.SQL := 'SELECT TFC_PINPOR, TFC_PINFAB, TFC_NUMTER FROM TEFCFG WHERE TFC_NOMUSU = "'+LUserFromWindows+'" AND TFC_NOMMAQ = "'+LComputerNetName+'" AND  TFC_CODEMP = "'+VS_FuncoesExternas.fGetEmpresaLogada+'" ' + fSqlFiltroTerminalTefCit ;
    LConsulta.Open ;
    AstrPorta := LConsulta.FieldByName('TFC_PINPOR').AsString ;
    AstrFabricante := LConsulta.FieldByName('TFC_PINFAB').AsString ;
    AstrNumTer := LConsulta.FieldByName('TFC_NUMTER').AsString ;
  end
  else if LstrTipoTerminal = '2' then
  begin
    LConsulta := VS_FuncoesExternas.fGetDataset;
    LConsulta.Close ;
    LConsulta.SQL := 'SELECT TFC_PINPOR, TFC_PINFAB, TFC_NUMTER FROM TEFCFG WHERE TFC_LOC_IP = "'+LWorkStationIP+'" AND TFC_NOMMAQ = "'+LWorkstationID+'" ' + fSqlFiltroTerminalTefCit ;
    LConsulta.Open ;
    AstrPorta := LConsulta.FieldByName('TFC_PINPOR').AsString ;
    AstrFabricante := LConsulta.FieldByName('TFC_PINFAB').AsString ;
    AstrNumTer := LConsulta.FieldByName('TFC_NUMTER').AsString ;
  end
  else // Tipter = 3
  begin
    LConsulta := VS_FuncoesExternas.fGetDataset;
    LConsulta.Close ;
    LConsulta.SQL := 'SELECT TFC_PINPOR, TFC_PINFAB, TFC_NUMTER FROM TEFCFG WHERE TFC_EMPTIP = "'+VS_FuncoesExternas.fGetEmpresaLogada+'" AND TFC_NOMMAQ = "'+LWorkstationID+'" ' + fSqlFiltroTerminalTefCit ;
    if LstrTefCit = 'T' then
      LConsulta.SQL := LConsulta.SQL + ' AND LENGTH(TRIM(TFC_NUMTER)) = 3 '
    else if (LstrTefCit = 'S') or (LstrTefCit = 'N') then
      LConsulta.SQL := LConsulta.SQL + ' AND LENGTH(TRIM(TFC_NUMTER)) > 3 ' ;
    LConsulta.Open ;
    AstrPorta := LConsulta.FieldByName('TFC_PINPOR').AsString ;
    AstrFabricante := LConsulta.FieldByName('TFC_PINFAB').AsString ;
    AstrNumTer := LConsulta.FieldByName('TFC_NUMTER').AsString ;
  end ;
end ;

{$IFNDEF LINUX}
function fInstanciaPinPad(var AstrNumTer: String): IPinPadCitel ;
var
  LstrPorta, LstrFabricante, LstrNumTer: String ;
  LppcfFabricante: TPinPadCitelFabricantes ;
  LstrPathDll: String ;
begin
  Result := Nil ;
  try
    pCarregaConfiguracaoTerminalPinPad(LstrPorta, LstrFabricante, LstrNumTer) ;
    AstrNumTer := LstrNumTer ;
    if trim(LstrPorta) = '' then
      LstrPorta := 'COM6' ;
    if trim(LstrFabricante) = '' then
      exit ;

    LstrPathDll := fCfgSis('PTTFCT', VS_FuncoesExternas.fGetEmpresaLogada) ;
    if Trim(LstrPathDll) <> '' then
    begin
      LstrPathDll := String(PathWithDelim(AnsiString(LstrPathDll)))+LstrNumTer ;
    end ;

    LppcfFabricante := fObtemFabricantePinPad ;
    Result := TPinPadFactory.New.fAcessa(LstrPorta, LppcfFabricante, LstrPathDll) ;
  except
    on E: Exception do
    begin
      GravarLogErr_Pix('Acesso PinPad', E.message, LstrNumTer) ;
      Result := Nil ;
    end ;
  end ;
end ;
{$ENDIF}

{$IFNDEF LINUX}
function fObtemFabricantePinPad: TPinPadCitelFabricantes ;
var
  LstrFabricante, LstrPorta, LstrNumTer: String ;
begin
  pCarregaConfiguracaoTerminalPinPad(LstrPorta, LstrFabricante, LstrNumTer) ;
  result := ppcfGertec ;
  if LstrFabricante = 'Gertec' then
    result := ppcfGertec
  else if LstrFabricante = 'Scope' then
    result := ppcfScope ;
end ;
{$ENDIF}

procedure pEnviaQrCodeInterno(const AstrTextoQrCode, AstrTituloInformativo: String; const APinPad: IPinPadCitel) ;
begin
  if trim(AstrTextoQrCode) = '' then
    Exit ;

  if not Assigned(APinPad) then
    Exit ;

  try
    APinPad.pEnviarQrCode(AstrTextoQrCode, AstrTituloInformativo);
  except
    on E: Exception do
    begin
      // tenta fechar a porta em caso erro
      try
        APinPad.pFecharPorta('');
      except
        ///
      end ;
    end ;
  end ;
end ;

function fNomeArquivoValido(const ATexto: string): string;
const
  cnsNomesReser: array[0..21] of string = (
    'CON','PRN','AUX','NUL',
    'COM1','COM2','COM3','COM4','COM5','COM6','COM7','COM8','COM9',
    'LPT1','LPT2','LPT3','LPT4','LPT5','LPT6','LPT7','LPT8','LPT9'
  );
var
  intIdx: Integer;
begin
  Result := Trim(ATexto);

  for intIdx := Length(Result) downto 1 do
  begin
    if (Ord(Result[intIdx]) < 32) or
       CharInSet(Result[intIdx], ['\', '/', ':', '*', '?', '"', '<', '>', '|']) then
      Delete(Result, intIdx, 1);
  end;

  while (Result <> '') and CharInSet(Result[Length(Result)], [' ', '.']) do
    Delete(Result, Length(Result), 1);

  for intIdx := Low(cnsNomesReser) to High(cnsNomesReser) do
  begin
    if SameText(Result, cnsNomesReser[intIdx]) then
    begin
      Result := Result + '_';
      Break;
    end;
  end;

  if Result = '' then
    Result := 'ARQ';
end;

procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);
  Var
    LstrPatArq,
    LstrCodOpe,
    LstrCodEmp,
    LstrConId_,
    LstrNomDir,
    LstrNomArq: String;
    LdtaTimLog: TDateTime;
    LstlLog: TStringList;
begin
  Try
    LstrNomDir := ExtractFilePath(Application.ExeName) + 'temp\log\';

    If (Not DirectoryExists(LstrNomDir)) Then
      ForceDirectories(LstrNomDir);

    If (Not DirectoryExists(LstrNomDir)) Then
      Exit;

    LdtaTimLog := Date+Time; //USO DE Date+Time EM DETRIMENTO DE fNow() PARA EVITAR ACESSO AO BANCO
    LstrNomArq := fNomeArquivoValido(strLocal);

    Try
      If VS_LastConnID.IsEmpty Then
        VS_LastConnID := fGetConnectionID;
      If VS_LastConnID.IsEmpty Then
        VS_LastConnID := '0';
    Except
      VS_LastConnID := '0';
    End;

    Try
      LstrCodEmp := VS_FuncoesExternas.fGetEmpresaLogada;
      If LstrCodEmp.IsEmpty Then
        LstrCodEmp := '000';
    Except
      LstrCodEmp := '000';
    End;

    Try
      LstrCodOpe := VS_FuncoesExternas.fIRetOperadorLogado;
      If LstrCodOpe.IsEmpty Then
        LstrCodOpe := '000';
    Except
      LstrCodOpe := '000';
    End;

    LstrConId_ := VS_LastConnID;

    LstrPatArq := LstrNomDir + FormatDateTime('yyyymmddhhnnsszzz', LdtaTimLog) + '_' + LstrCodEmp + '_' + LstrCodOpe + '_' + LstrNomArq + '.txt';

    LstlLog := TStringList.Create;
    Try
      LstlLog.Add(strErro);
      LstlLog.Add('');
      LstlLog.Add('Data/Hora....: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LdtaTimLog));
      LstlLog.Add('Empresa......: ' + LstrCodEmp);
      LstlLog.Add('Operador.....: ' + LstrCodOpe);
      LstlLog.Add('Connection ID: ' + LstrConId_);
      LstlLog.Add('');
      LstlLog.Add(strStack);
      LstlLog.SaveToFile(LstrPatArq);
    Finally
      FreeAndNil(LstlLog);
    End;
  Except
    //
  End;
end;

procedure pLimpaQrCodeInterno(const APinPad: IPinPadCitel) ;
begin
  if not Assigned(APinPad) then
    exit ;

  try
    APinPad.pLimpaQrCode(fMensagemEncerramentoTEF) ;
  except
    on E: Exception do
    begin
      //
    end ;
  end ;
end ;

procedure pLimpaQrCodeInterno(const APinPad: IPinPadCitel; const AMsgPinPad: String);
begin
  if not Assigned(APinPad) then
    exit ;

  try
    APinPad.pLimpaQrCode(AMsgPinPad) ;
  except
    on E: Exception do
    begin
      //
    end ;
  end ;
end ;

{$IFNDEF LINUX}
function KeyIsDown(const Key: Integer): Boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;
{$ENDIF}

function fCfgSis(ANomeConfiguracao,
  ACodigoEmpresa: String): String;
  Var
    LConsulta: IDataset;
begin
  LConsulta := VS_FuncoesExternas.fGetDataset;

  LConsulta.SQL := 'SELECT SIS_VALCFG ' +
                   'FROM CFGSIS ' +
                   'WHERE SIS_CODCFG="CFG_' + ANomeConfiguracao + '" ' +
                   '  AND SIS_CODEMP="' + ACodigoEmpresa + '"';

  LConsulta.Open;

  Result := LConsulta.FieldByName('SIS_VALCFG').AsString;
end;

function fNow: TDateTime;
begin
  Result := nOw();
end;

function fRetDataServidor: TDate;
  Var
    LConsulta: IDataset;
begin
  Result := 0;

  LConsulta := VS_FuncoesExternas.fGetDataSet;
  Try
    LConsulta.SQL := 'SELECT CURRENT_DATE';
    LConsulta.Open;

    Result := LConsulta.FieldByName('CURRENT_DATE').AsDateTime;
  Finally
    If Result = 0 Then
      Result := Date;
  End;
end;

function fRetHoraServidor: TTime;
  Var
    LConsulta: IDataset;
begin
  Result := 0;

  LConsulta := VS_FuncoesExternas.fGetDataSet;
  Try
    LConsulta.SQL := 'SELECT CURRENT_TIME';
    LConsulta.Open;

    Result := LConsulta.FieldByName('CURRENT_TIME').AsDateTime;
  Finally
    If Result = 0 Then
      Result := fTime();
  End;
end;

function RetornaCurrentTimeStampServidor: String;
  Var
    LConsulta: IDataset;
begin
  Try
    LConsulta := VS_FuncoesExternas.fGetDataSet;
    LConsulta.SQL := 'SELECT CURRENT_TIMESTAMP';
    LConsulta.Open;

    Result := LConsulta.FieldByName('CURRENT_TIMESTAMP').AsString;
  Except
    Result := DateTimeToStr(fNow);
  End;
end;

function RetornaCurrentTimeStampServidorDataHora: TDateTime;
  Var
    LConsulta: IDataset;
begin
  Try
    LConsulta := VS_FuncoesExternas.fGetDataSet;
    LConsulta.SQL := 'SELECT CURRENT_TIMESTAMP';
    LConsulta.Open;

    Result := LConsulta.FieldByName('CURRENT_TIMESTAMP').AsFloat;
  Except
    Result := fNow;
  End;
end;

function fStrToFloat(strValorUnico: String;
  fltDefault: real): Double;
begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),fltDefault);
end;

function fTiraCaracEspeciais(strTexto: String; blnUsaLista,
  blnTiraEspacos, blnTiraPontos, blnTiraDoisPts, blnTiraTab, blnTiraVirgula,
  blnTiraAbreviacaoNumero: Boolean): String;
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
    strLista := strLista + '∫';

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸Á¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹«';

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

function fCriaDatasetQRCode(ATextoQRCode, AValor: String): TUniClientDataset;
Begin
  Result := TUniClientDataset.Create(Nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TEXTOQRCODE';
    DataType := ftString;
    Size := 1000;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALOR';
    DataType := ftString;
    Size := 50;
  End;

  Result.CreateDataSet;

  Result.Open;

  Result.Append;
  Result.FieldByName('TEXTOQRCODE').AsString := ATextoQRCode;
  Result.FieldByName('VALOR').AsString := AValor;
  Result.Post;
End;

{$IFNDEF LINUX}
procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
Begin
  If Not Assigned(SenderUnico) Then
    Exit;

  If ((GetKeyState(VK_SHIFT) And 128) = 128) And
     ((GetKeyState(VK_TAB) And 128) = 128) Then
    Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;

        if (SenderUnico is TCustomCheckBox) or (SenderUnico is TCustomCombo) then
          SenderUnico.Perform(WM_UPDATEUISTATE, MakeWParam(UIS_CLEAR, UISF_HIDEFOCUS), 0);

      Except

      End;
    End;
  Except

  End;
End;
{$ENDIF}

function AbrirCfgRel(ANomeFormulario: String): IDataset;
  Var
    LSQL: String;
begin
  LSQL := '';
  LSQL := LSQL + 'SELECT SQL_NO_CACHE ';
  LSQL := LSQL + '  * ';
  LSQL := LSQL + 'FROM ';
  LSQL := LSQL + '  CFGREL ';
  LSQL := LSQL + 'WHERE ';
  LSQL := LSQL + '  REL_NOMPRO = :NOMPRO AND ';
  LSQL := LSQL + '  REL_CODEMP = :CODEMP ';

  if fCfgSis('SPOIMP', VS_FuncoesExternas.fGetEmpresaLogada).Equals('S') then
    LSQL := LSQL + '  AND REL_SPOIMP = "S" ';

  Result := VS_FuncoesExternas.fGetDataSet;

  Result.SQL := LSQL;
  Result.ParamByName('NOMPRO').AsString := ANomeFormulario;
  Result.ParamByName('CODEMP').AsString := VS_FuncoesExternas.fGetEmpresaLogada;

  Result.Open;

  If Result.IsEmpty Then
    Exit;

  SelecionaFilaOperadorMaquina(Result);
end;

procedure SelecionaFilaOperadorMaquina(var ADatasetFilas: IDataset);
  Var
    LCamposLocate: String;

    LValoresLocate: Array Of Variant;
Begin
  LCamposLocate := 'REL_CODOPE';
  SetLength(LValoresLocate, 1);
  LValoresLocate[0] := EmptyStr;

  If ADatasetFilas.Locate('REL_CODOPE', VS_FuncoesExternas.fIRetOperadorLogado, []) Then
    Exit;

  If ADatasetFilas.FindField('REL_NOMMAQ') <> Nil Then
  Begin
    If ADatasetFilas.Locate('REL_NOMMAQ', {$IFDEF LINUX}GetComputerNetName{$ELSE}TWorkStationInfo.fGetWorkStationID{$ENDIF}, []) Then
      Exit;

    LCamposLocate := LCamposLocate + ';REL_NOMMAQ';
    SetLength(LValoresLocate, 2);
    LValoresLocate[1] := EmptyStr;
  End;

  If Not ADatasetFilas.Locate(LCamposLocate,
                              VarArrayOf(LValoresLocate), []) Then
  Begin
    ADatasetFilas.Filtrar('REL_CODOPE=''' + VS_FuncoesExternas.fIRetOperadorLogado + ''' ');
    Exit;
  End;
End;

function RetornaCNPJEmpresaLogada: String;
  Var
    LConsulta: IDataset;
begin
  LConsulta := VS_FuncoesExternas.fGetDataSet;
  LConsulta.SQL := 'SELECT EMP_C_G_C_ ' +
                   'FROM CADEMP ' +
                   'WHERE EMP_CODEMP=:CODEMP';

  LConsulta.ParamByName('CODEMP').AsString := VS_FuncoesExternas.fGetEmpresaLogada;

  LConsulta.Open;

  Result := LConsulta.FieldByName('EMP_C_G_C_').AsString;
End;

function RetornaCNPJEmpresaSelecionada(ACodigoEmpresa: String): String;
  Var
    LConsulta: IDataset;
begin
  LConsulta := VS_FuncoesExternas.fGetDataSet;
  LConsulta.SQL := 'SELECT EMP_C_G_C_ ' +
                   'FROM CADEMP ' +
                   'WHERE EMP_CODEMP=:CODEMP';

  LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;

  LConsulta.Open;

  Result := LConsulta.FieldByName('EMP_C_G_C_').AsString;
End;

function GetMD5(const strTexto: string): string;
  var
    idHash128: TIdHashMessageDigest5;
begin
  Try
    idHash128 := TIdHashMessageDigest5.Create;

    Result := idHash128.HashStringAsHex(strTexto);
  Finally
    FreeAndNil(idHash128);
  End;
end;

function fGetConnectionID: String;
  Var
    LConsulta: IDataset;
begin
  Try
    LConsulta := VS_FuncoesExternas.fGetDataSet;
    LConsulta.SQL := 'SELECT CONNECTION_ID() AS CONEXAO';
    LConsulta.Open;
    Result := LConsulta.FieldByName('CONEXAO').AsString;
  Except
    Result := '';
  End;
end;

{$IFNDEF LINUX}
procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport);
begin
  If strNomImp.IsEmpty Then
    strNomImp := AReport.PrintOptions.Printer;

  If fCfgSis('SPOIMP', VS_FuncoesExternas.fGetEmpresaLogada).Equals('S') And TSpoolImpressaoCitel.fGetPontoImpressao(strNomImp).Existe Then
    TSpoolImpressaoCitel.fEnviarParaImpressao(strNomPro, strDesPro, strNomImp, AReport)
  Else
    AReport.Print;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport);
begin
  TFastPreviewReport.PreviewReport(strNomPro, strDesPro, AReport);
end;
{$ENDIF}

Function fNextAutoIncrem(strAutInc: String): String;
Begin
 Result := LeftStr(strAutInc, 3) + IntToStr(StrToIntDef(Copy(strAutInc, 4, 14), 0) + 1).PadLeft(14,'0') + RightStr(strAutInc, 3);
End;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
begin
  If strProEmp.IsEmpty Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + (IntToStr(intAutInc) + strCodEmp).PadLeft(17,'0');
end;

Function fRetEmpresaFisica: String;
  Var
    qryGen: IDataSet;
Begin
  Try
    qryGen := VS_FuncoesExternas.fGetDataSet;
    With qryGen Do
    Begin
      SQL := 'SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER"';
      Open;

      If IsEmpty Then
        Result := VS_FuncoesExternas.fGetEmpresaLogada
      Else
        Result := FieldByName('PRO_CODEMP').AsString;

      Close;

    End;

  Except
    On E: Exception Do
      Raise;
  End;
End;

{ TFastPreviewReport }

{$IFNDEF LINUX}
class procedure TFastPreviewReport.PreviewReport(const APrograma, ADescricao: String; AReport: TfrxReport);
Var
  LPreview: TFastPreviewReport;
begin
  LPreview := TFastPreviewReport.Create;
  Try
    LPreview.FNomPro := APrograma;
    LPreview.FDesPro := ADescricao;
    LPreview.FReport := AReport;
    AReport.OnPreview := LPreview.OnPreview;
    AReport.ShowPreparedReport;
  Finally
    FreeAndNil(LPreview);
  End;
end;

constructor TFastPreviewReport.Create;
begin
  FAppEvents := TApplicationEvents.Create(nil);
  FAppEvents.OnMessage := Self.OnMessage;
end;

destructor TFastPreviewReport.Destroy;
begin
  FreeAndNil(FAppEvents);
  inherited;
end;

procedure TFastPreviewReport.OnMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if Assigned(FReport) and Assigned(FReport.Preview) then
    if Msg.hwnd = FReport.Preview.Handle then
    begin
      if (Msg.message = WM_KEYFIRST) and
        ((Msg.wParam = Ord('p')) or (Msg.wParam = Ord('P'))) then
      begin
        if KeyIsDown(VK_CONTROL) then
        begin
          Msg.message := 0;
          PrintBClick(nil);
        end;
      end;
    end;
end;

procedure TFastPreviewReport.OnPreview(Sender: TObject);
begin
  TfrxPreviewForm(FReport.PreviewForm).Caption := FDesPro;
  FOldPrintBClick := TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick;
  TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick := Self.PrintBClick;
end;

procedure TFastPreviewReport.PrintBClick(Sender: TObject);
Var
  LNomImp: String;
  LFrmDlg: TSpoolPrintDialog;
begin
  If  fCfgSis('SPOIMP', VS_FuncoesExternas.fGetEmpresaLogada).Equals('S') Then
  Begin
    LNomImp := FReport.PrintOptions.Printer;

    If Not TSpoolImpressaoCitel.fGetPontoImpressao(LNomImp).Existe Then
    begin
      LFrmDlg := TSpoolPrintDialog.Create(nil);
      Try
        LFrmDlg.Caption := FDesPro;
        LFrmDlg.FReport := FReport;
        If LFrmDlg.ShowModal = mrOk Then
          LNomImp := LFrmDlg.PrintersCB.Text;
      Finally
        FreeAndNil(LFrmDlg);
      End;
    end;

    If Not TSpoolImpressaoCitel.fGetPontoImpressao(LNomImp).Existe Then
      Exit;

    pPrintReport(FNomPro, FDesPro, LNomImp, FReport);
  End
  Else
    FOldPrintBClick(Sender);
end;
{$ENDIF}

procedure GravarLogAPI(const AApi, AResource, AMethod, ABody, AResponse: string; HTTPSend: THTTPSend);
{$IFNDEF LINUX}
begin
end;
{$ELSE}
var
  qryLogAPI   : IDataset;
  strParamE   : String;
  intContador : Integer;
begin
  qryLogAPI := VS_FuncoesExternas.fGetDataSet;
  Try
    qryLogAPI.Close;
    qryLogAPI.SQL := STR_SQL_NAO_REPLICAR
                   + ' INSERT INTO LOGAPI( '
                   + '        AUTOINCREM '
                   + '      , LOG_DTAENT '
                   + '      , LOG_HORENT '
                   + '      , LOG_RECURS '
                   + '      , LOG_PARAME '
                   + '      , LOG_RESULT '
                   + '      , LOG_STATUS '
                   + '      , LOG_LOGAPI '
                   + '      , LOG_NOMMAQ '
                   + '      , LOG_CODEMP '
                   + ') VALUES ( '
                   + '        :AUTINC '
                   + '      , :DTAENT '
                   + '      , :HORENT '
                   + '      , :RECURS '
                   + '      , :PARAME '
                   + '      , :RESULT '
                   + '      , :STATUS '
                   + '      , :LOGAPI '
                   + '      , :NOMMAQ '
                   + '      , :CODEMP '
                   + ') ';

    qryLogAPI.ParamByName('AUTINC').AsString  := VS_FuncoesExternas.fIRetAutoIncrem('LOGAPI', VS_strCodEmp);

    qryLogAPI.ParamByName('DTAENT').AsDateTime := Date;
    qryLogAPI.ParamByName('HORENT').AsDateTime := fTime();
    qryLogAPI.ParamByName('RECURS').AsString   := AResource;

    strParamE := '';
    strParamE := strParamE + AApi + sLineBreak;
    strParamE := strParamE + AMethod + sLineBreak;
    strParamE := strParamE + AResource + sLineBreak;

    For intContador := 0 To HTTPSend.Headers.Count-1 Do
      strParamE := strParamE + HTTPSend.Headers[intContador]+'; ' + sLineBreak;

    strParamE := strParamE + ABody + sLineBreak;

    qryLogAPI.ParamByName('PARAME').AsString  := strParamE;
    qryLogAPI.ParamByName('RESULT').AsString  := AResponse;
    qryLogAPI.ParamByName('STATUS').AsInteger := HTTPSend.ResultCode;
    qryLogAPI.ParamByName('LOGAPI').AsString  := AApi;
    qryLogAPI.ParamByName('NOMMAQ').AsString  := VS_ComputerNetName;
    qryLogAPI.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryLogAPI.ExecSQL;
  Except
    //Para n„o afetar o funcionamento caso ocorra algum erro na gravaÁ„o do log
  End;
end;
{$ENDIF}

procedure GravarLogErr_Pix(ADescricao,
  ARelatorio: String; const ANumTer: String = '');
  Var
    LLogErr_Pix: IDataset;
begin
 {$IFDEF LINUX}
  WriteError('GravarLogErr_Pix  ' + sLineBreak + ADescricao + sLineBreak + ARelatorio + sLineBreak + ' [ ' + ANumTer + ' ]');
 {$ENDIF}

  Try
    LLogErr_Pix := VS_FuncoesExternas.fGetDataSet;
    LLogErr_Pix.SQL := 'SELECT * FROM LOGERR_PIX WHERE FALSE';

    LLogErr_Pix.Open;
    LLogErr_Pix.Insert;
    LLogErr_Pix.FieldByName('LOG_CODEMP').AsString := VS_FuncoesExternas.fGetEmpresaLogada;
    LLogErr_Pix.FieldByName('LOG_CODOPE').AsString := VS_FuncoesExternas.fIRetOperadorLogado;
    LLogErr_Pix.FieldByName('LOG_DTAERR').AsFloat := fRetDataServidor;
    LLogErr_Pix.FieldByName('LOG_HORERR').AsFloat := fRetHoraServidor;
    LLogErr_Pix.FieldByName('LOG_DESCRI').AsString := ADescricao;

    if Assigned(LLogErr_Pix.FindField('LOG_NUMTER')) then
       LLogErr_Pix.FieldByName('LOG_NUMTER').AsString := ANumTer;

    If Not ARelatorio.IsEmpty Then
      LLogErr_Pix.FieldByName('LOG_RELERR').AsString := ARelatorio;

    LLogErr_Pix.Post;
    LLogErr_Pix.Close;
  Except
    //Para n„o afetar o funcionamento caso ocorra algum erro na gravaÁ„o do log
  End;
end;

function RetornaDadosEmpresaLogada(AEmpresaConfiguracao: String): IDataset;
begin
  Result := VS_FuncoesExternas.fGetDataset;

  Result.SQL := 'SELECT EMP_CODEMP, EMP_NOMEMP, EMP_NOMFAN, EMP_C_G_C_, EMP_FONE01 ' +
                'FROM CADEMP ' +
                'WHERE EMP_CODEMP="' + AEmpresaConfiguracao + '"';

  Result.Open;
End;

function RetornaDadosEmpresaPix(AEmpresaConfiguracao, AAutoIncremChavePix, ADadosEmpresa: String): IDataset;
begin
  If Not ADadosEmpresa.Equals('P') Then
    Exit(RetornaDadosEmpresaLogada(AEmpresaConfiguracao));

  Result := VS_FuncoesExternas.fGetDataset;

  Result.SQL := 'SELECT E.EMP_CODEMP, ' +
                '       E.EMP_NOMEMP, ' +
                '       E.EMP_NOMFAN, ' +
                '       E.EMP_C_G_C_, '  +
                '       E.EMP_FONE01 '  +
                'FROM CCAPIX P ' +
                'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                'JOIN CADEMP E ON E.EMP_CODEMP=C.CCA_CODEMP ' +
                'WHERE P.AUTOINCREM="' + AAutoIncremChavePix + '"';

  Result.Open;
End;

function RetornaNomeDoBanco(ACodigoDoBanco: String): String;
  Var
    LConsulta: IDataset;
Begin
  LConsulta := VS_FuncoesExternas.fGetDataset;

  LConsulta.SQL := 'SELECT BCO_NOMBCO ' +
                   'FROM CADBCO ' +
                   'WHERE BCO_CODBCO="' + ACodigoDoBanco + '"';

  LConsulta.Open;

  Result := LConsulta.FieldByName('BCO_NOMBCO').AsString;
End;

{$IFNDEF LINUX}
function PegaTimeZone: Integer;
  Var
    TimeZone: TTimeZoneInformation;

    LTimeZoneServer: IDataset;

    LValorMaquinaLocal: Integer;

    LPossuiTimeZoneAlterado: Boolean;
begin
  If VS_TimeZone <> 0 Then
    Exit(VS_TimeZone);

  Result := 3;
  Try
    Try
      GetTimeZoneInformation(TimeZone);

      LValorMaquinaLocal := TimeZone.Bias div 60;
    Except
      LValorMaquinaLocal := 3;
    End;

    Try
      LTimeZoneServer := VS_FuncoesExternas.fGetDataset;
      LTimeZoneServer.SQL := 'SHOW VARIABLES LIKE "%time_zone%"';
      LTimeZoneServer.Open;

      If Not LTimeZoneServer.IsEmpty Then
      Begin
        LPossuiTimeZoneAlterado := LTimeZoneServer.Locate('Variable_name', 'time_zone', []);
        If LPossuiTimeZoneAlterado Then
        Begin
          LPossuiTimeZoneAlterado := Not LTimeZoneServer.FieldByName('Value').AsString.ToUpperInvariant.Equals('SYSTEM');

          If LPossuiTimeZoneAlterado Then
          Begin
            If TryStrToInt(LeftStr(LTimeZoneServer.FieldByName('Value').AsString, 3).Replace(':', EmptyStr), Result) Then
            Begin
              Result := Result * -1;
              Exit;
            End;
          End;
        End;

        If LTimeZoneServer.Locate('Variable_name', 'system_time_zone', []) Then
        Begin
          Result := LTimeZoneServer.FieldByName('value').AsInteger * -1;
          Exit;
        End;
      End;

      Result := LValorMaquinaLocal;
    Except
      Result := LValorMaquinaLocal;
    End;
  Finally
    VS_TimeZone := Result;
  End;
end;
{$ENDIF}

function RetornaTimeStampEmMilisegundos: Int64;
{$IFDEF LINUX}
begin
  Result := DateTimeToUnix(Now, False) * 1000 + MilliSecondOf(Now);
end;
{$ELSE}
  var
    LDateTime: TDateTime;

    LDataServidor,
    LHoraServidor: TDateTime;

    LConsulta: IDataset;

    SystemTime: TSystemTime;
begin
  //Modificada a rotina anterior do Roni, para poder enviar a Data/Hora do servidor
  Try
    LConsulta := VS_FuncoesExternas.fGetDataset;

    LConsulta.SQL := 'SELECT CURRENT_DATE AS DATA, ' +
                     '       CURTIME(3) AS HORA ' +
                     'FROM DUAL';
    LConsulta.Open;

    LDataServidor := FloatToDateTime(LConsulta.FieldByName('DATA').AsFloat);
    LHoraServidor := IncHour(FloatToDateTime(LConsulta.FieldByName('HORA').AsFloat), PegaTimeZone);

    LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                 EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));

    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
  Except
    GetSystemTime(SystemTime);
    LDateTime := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay) +
                 EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
  End;
End;
{$ENDIF}

procedure AdicionaAlteraConfiguracao(ACodigoCfg,
                                     AValorCfg,
                                     AEmpresaCfg,
                                     ADescricaoCfg,
                                     AGrupoCfg: String);
  Var
    LRegistro: IDataset;
Begin
  If ACodigoCfg.IsEmpty Then
    Exit;

  If AEmpresaCfg.IsEmpty Then
    Exit;

  LRegistro := VS_FuncoesExternas.fGetDataset;
  LRegistro.SQL := 'SELECT * FROM CFGSIS ' +
                   'WHERE SIS_CODCFG="' + ACodigoCfg + '" ' +
                   '  AND SIS_CODEMP="' + AEmpresaCfg + '" ';
  LRegistro.Open;

  If LRegistro.IsEmpty Then
  Begin
    LRegistro.Insert;
    LRegistro.FieldByName('SIS_CODCFG').AsString := ACodigoCfg;
    LRegistro.FieldByName('SIS_CODEMP').AsString := AEmpresaCfg;
    LRegistro.FieldByName('SIS_DESCRI').AsString := ADescricaoCfg;
    LRegistro.FieldByName('SIS_GRUCFG').AsString := AGrupoCfg;

    If LRegistro.FindField('SIS_NUMHLP') <> Nil Then
      LRegistro.FieldByName('SIS_NUMHLP').AsString := '0';

    If LRegistro.FindField('SIS_LAYOUT') <> Nil Then
      LRegistro.FieldByName('SIS_LAYOUT').AsString := 'N';
  End
  Else
    LRegistro.Edit;

  LRegistro.FieldByName('SIS_VALCFG').AsString := AValorCfg;
  LRegistro.FieldByName('SIS_ULTALT').AsFloat := fRetDataServidor;

  LRegistro.Post;
End;

function fRetornaStack: String;
{$IFDEF LINUX}
begin
  Result := EmptyStr;
end;
{$ELSE}
var
  stlTrack: TStringList;
begin
  stlTrack := Nil;
  Try
    Try
      stlTrack := TStringList.Create;
      stlTrack.Text := madStackTrace.StackTrace();
      Result := stlTrack.Text;
    Except
      On E: Exception Do
        Result := '<stack indisponÌvel>';
    End;
  Finally
    If Assigned(stlTrack) Then
      FreeAndNil(stlTrack);
  End;
end;
{$ENDIF}

function IIF(ACondicao: Boolean;
             AResultadoVerdadeiro,
             AResultadoFalso: Variant): Variant;
Begin
  If ACondicao Then
    Result := AResultadoVerdadeiro
  Else
    Result := AResultadoFalso;
End;

function fTrataTefCitTerminal: String ;
var
  LstrTefCit: String ;
begin
  Result := 'S' ;
  LstrTefCit := fCfgSis('TEFCIT', VS_FuncoesExternas.fGetEmpresaLogada) ;
  if LstrTefCit = 'T' then
    Result := LstrTefCit
  else if LstrTefCit = 'S' then
    Result := LstrTefCit ;
end;

function fSqlFiltroTerminalTefCit: String ;
begin
  Result := '' ;
  if not fCampoExiste('TEFCFG', 'TFC_TIPTEF') then
    Exit ;

  Result := ' AND TFC_TIPTEF = "' + fTrataTefCitTerminal + '" ' ;

end ;

function GetUserFromWindows: string;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.GetComputerUser;
end;
{$ELSE}
Var
  UserName : string;
  UserNameLen : Dword;
Begin
  UserNameLen := 255;
  SetLength(userName, UserNameLen) ;
  If GetUserName(PChar(UserName), UserNameLen) Then
    Result := Copy(UserName,1,UserNameLen - 1)
  Else
    Result := 'Unknown';
End;
{$ENDIF}

function GetComputerNetName: string;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.GetComputerNetName;
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
{$ENDIF}

function fCampoExiste(const AstrTabela, AstrCampo: String; const blnUsarCache : Boolean = False): Boolean ;
var
  LConsulta: IDataset;
begin
  Result := False;
  LConsulta := VS_FuncoesExternas.fGetDataset;
  LConsulta.Close ;
  LConsulta.SQL := 'DESC ' + AstrTabela ;
  LConsulta.Open ;

  While Not LConsulta.Eof Do
  Begin
    If LConsulta.FieldByName('Field').AsString = AstrCampo Then
    Begin
      Result := True;
      Break;
    End;
    LConsulta.Next;
  End;

end ;

function RetornaDiferencaSegundos(ADataMaquina,
                                  ADataServidor: TDateTime): Int64;
Begin
  Try
    Result := SecondsBetween(ADataMaquina,
                             ADataServidor);
  Except
    Result := 0;
  End;
End;

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

{$IFNDEF LINUX}
function GetTime(const ACodigoEmpresa : String): TDateTime;
  Var
    LTimeZoneLocal : Integer;
    LUsaTimeZone : String;
    LTimeZoneConfigurado : Integer;
begin
  If (ACodigoEmpresa.IsEmpty) Then
    Exit(Time());

  LUsaTimeZone := fCfgSis('USATMZ', ACodigoEmpresa);

  If (LUsaTimeZone.IsEmpty) Then
    Exit(Time());

  If (LUsaTimeZone = 'N') Then
    Exit(Time());

  LTimeZoneLocal := TimeZoneLocal();
  LTimeZoneConfigurado := TimeZoneConfigurado(ACodigoEmpresa);
  If (LTimeZoneConfigurado <> 0) And (LTimeZoneLocal <> LTimeZoneConfigurado) Then
    Result := IncHour(LocalTimeToUTC(Time()), LTimeZoneConfigurado)
  Else
    Exit(Time());
end;
{$ENDIF}

function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  Var
    LTimeZone : String;
begin
  Result := 0;

  LTimeZone := fCfgSis('TMZONE', ACodigoEmpresa);

  If (LTimeZone.IsEmpty) Then
    Exit;

  Result := StrToIntDef(LTimeZone, 0);
end;

function fDecrypt(ASenha: String): String;
  Var
  	intCol,
    intCl1 : Integer;
begin
  Result := EmptyStr;

  For intCol := Length(ASenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(ASenha,intCol,1),STR_CHAR_TROCA);
    Result := Result + MidStr(STR_CHAR_SENHA, intCl1,1);
  End;
End;

{$IFNDEF LINUX}
function TimeZoneLocal : Integer;
  Var
    LTimeZoneInfo : TTimeZoneInformation;
begin
  GetTimeZoneInformation(LTimeZoneInfo);
  Result := LTimeZoneInfo.Bias div -60;
end;
{$ENDIF}

{$IFNDEF LINUX}
function LocalTimeToUTC(const AValue: TDateTime): TDateTime;
  Var
    LSysTime1, LSysTime2: TSystemTime;
    LTimeZoneInfo: TTimeZoneInformation;
begin
  GetTimeZoneInformation(LTimeZoneInfo);
  LTimeZoneInfo.Bias := -LTimeZoneInfo.Bias;
  LTimeZoneInfo.StandardBias := -LTimeZoneInfo.StandardBias;
  LTimeZoneInfo.DaylightBias := -LTimeZoneInfo.DaylightBias;
  DateTimeToSystemTime(AValue, LSysTime1);
  SystemTimeToTzSpecificLocalTime(@LTimeZoneInfo, LSysTime1, LSysTime2);
  Result := SystemTimeToDateTime(LSysTime2);
end;
{$ENDIF}

function fTime : TDateTime;
begin
{$IFDEF LINUX}
  Result := Services.Core.Utils.fTime;
{$ELSE}
  If (Not Assigned(VS_FuncoesExternas)) Then
    Exit(Time())
  Else
    Result := GetTime(VS_FuncoesExternas.fGetEmpresaLogada);
{$ENDIF}
end;

function fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

function fTrocaCaracter(strTexto: String; chrFrom,
  chrTo: Char): String;
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

function fTabelaExiste(strNomTab: String): Boolean;
  Var
    LConsulta: IDataSet;
Begin
  Try
    LConsulta := VS_FuncoesExternas.fGetDataSet;
    LConsulta.SQL := 'SHOW TABLES LIKE ' + QuotedStr(strNomTab);
    LConsulta.Open;
    Result := Not LConsulta.IsEmpty;
  Finally
    LConsulta.Close;
  End;
end;

function GetParamValue(AParamID: String): String;
Var
  I: Integer;
begin
  Result := '';
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID, True) then
      exit(Copy(ParamStr(I), Length(AParamID) + 1, MaxInt));
end;

function HasParam(AParamID: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID, True) then
      exit(True);
end;

{$IFDEF LINUX}
procedure FormatSettings_ptBR;
begin
  FormatSettings.DecimalSeparator    := ',';
  FormatSettings.ThousandSeparator   := '.';
  FormatSettings.CurrencyDecimals    := 2;
  FormatSettings.DateSeparator       := '/';
  FormatSettings.ShortDateFormat     := 'dd/mm/yyyy';
  FormatSettings.LongDateFormat      := 'dd/mm/yyyy';
  FormatSettings.TimeSeparator       := ':';
  FormatSettings.TimeAMString        := 'AM';
  FormatSettings.TimePMString        := 'PM';
  FormatSettings.ShortTimeFormat     := 'hh:nn';
  FormatSettings.LongTimeFormat      := 'hh:nn:ss';
  FormatSettings.CurrencyString      := 'R$'
end;
{$ENDIF}

end.
