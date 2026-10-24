unit untUtil;

interface

uses
{$IFDEF LINUX}
  Posix.Base,
  Posix.Fcntl,
  Posix.Unistd,
  Posix.Stdlib,
  Posix.SysStat,
  Posix.SysTypes,
  Posix.Signal,
  Posix.Stdio,
{$ELSE}
  Windows,
  Forms,
  StdCtrls,
  Dialogs,
  Registry,
  WinSock,
  Printers,
  Winspool,
  Controls,
  SHELLAPI,
{$ENDIF}
  LbString,
  SysUtils, StrUtils, Classes, DateUtils, untConfigNFE, Variants,
  untInterfaces, untInterfacesManifestoEletronico,
  XMLDoc,
  XMLIntf,
{$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300) Or Defined(VER330)}
  Uni,
{$ELSE}
  ZDataset, ZConnection,
{$IFEND}
{$IF RTLVersion >= 28}
  NetEncoding, Hash,
{$IFEND}
  IniFiles,
  DB,
  Contnrs,
  untConstantesNFe,
  Faturamento.Classes.CNPJ;

{$IFDEF LINUX}
type
  TApplication = class sealed(TComponent)
  private
    FExeName: String;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ProcessMessages;
    property ExeName: string read FExeName;
  end;
  TStreamHandle = pointer;
{$ENDIF}

type
  TArrString = Array Of String;

procedure pDeleteFile(strNomArq: String);

function fStrZero(Zeros:string;Quant:integer):String; overload;
function fStrZero(Zeros:Integer;Quant:integer):String; overload;
function fReplicatorStr(strRepl: String; intTamanho: Integer):String;
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fEmptyStr(const AString: string): Boolean;
function IfEmptyStr(const AString, AStringDefault: String): String;
function fQuebraStringLinhas(strMensagem: String; intTamanho: Integer): String;
function fTiraCaracEspeciais(strTexto: String; blnUsaLista: Boolean = True;
  blnTiraEspacos: Boolean = False; blnTiraPontos: Boolean = False; blnRemoverSomenteEscapesHtml: Boolean = False): String;
function fLimpaCaracteres(strTexto: String): String;
function fCountChar(strTexto: String; strChar: String): Integer;
function fLimpaCaracteresTelefone(strTexto: String): String;
function fRenomearArquivo( strArqOrigem, strArqDestino : String ):Boolean;
function fArquivoPronto(strArquivo: String): Boolean;
function fTamanhoArquivo(strArquivo: String): Cardinal;
function fRetornaVersao(strNomArq: String = ''): String;
function fGanhouNetpoints(fonteDados: IFonteDados; var intQtdNps: Integer): Boolean;
function fGetValorLinha(strLinha, strDelimitador: String; intColuna: Integer; blnIgnoraPrimeiro: Boolean=False): String;
function fValidaCnpjCpf(strValor: String; fonteDados: IFonteDados): Boolean;
function fTestaCgc(xCGC: String; fonteDados: IFonteDados):Boolean;
function fValidaCPF(sCPF: string):Boolean;
function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
function fValidaIES(strIES, strEstado: String): Boolean;
function fGetCSTSimplesSub(dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente; dadosItem: TDadosItem): String;
function fGetCSOSNSubstituicao(dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente): String;
function fSimplesPaulista(dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente;
  blnConsiderarFornecedor: Boolean=True): Boolean;
function fStrToFloat(strValor: String): Double;
function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
function fFormataValor(fltValor: Double; intTamanho, intDecimais: Integer): String;

procedure pConfiguraOpcoesRegionais;

function fRetOrigemMercadoria(strCodsit: String): String;

function fNotaFiscalServicosEletronicaDef(fonteDados: IFonteDados): Boolean;

function fRetNomeRede: String;
function fTratarNomeImpressora(const strImpressora: string): string;

function fNumerosRepetidos(const strString: String): Boolean;
function fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
function fStringRepetida(Const strString: String): Boolean;
function fApenasUmEmail(strEmail: String): String;
function fMessageDlg(strTitulo, strMensagem, strOpcao1, strOpcao2: String): String;
function fDecrypt(strSenha: String): String;
function fCrypt(strSenha: String): String;

function fEncriptar(strSenha: String): String;
function fDecriptar(strSenha: String): String;
function fConteudoEncriptado(ATexto: String): Boolean;

function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
function fEhNumero(Chr: Char): Boolean;
function fRetSomenteNumeros(strTexto: String): String;
function fExisteNumeros(strTexto: String): Boolean;
function fTiraCaracEspeciaisPonto(strTexto: String): String;

function fSuportaOperacaoBanco(fonteDados: IFonteDados): Boolean;
function fSuportaOperacaoBancoManifesto(fonteDados: IFonteDadosManifesto): Boolean;
function fCfgSisFonte(fonteDados: IFonteDados; strCodCfg: String): String; overload;
function fCfgSisFonte(fonteDados: IFonteDados; strCodCfg, strCodigoEmpresa: String): String; overload;
function fCfgSisFonteManifesto(fonteDados: IFonteDadosManifesto; strCodCfg, strCodigoEmpresa: String): String;

procedure pCarregaVerificadorVersaoNFe(strCnpj: String; blnOffLine: Boolean=False; strModeEnvSoap: String = '');
function fVersao310(fonteDados: IFonteDados; strModelo: String; strIntegradorCitel: String = 'N'): Boolean;
function fRetornaCSTSimplesUtil(dadosEmitente: TDadosEmitente;
  dadosGerais: TDadosGerais; dadosItem: TDadosItem; blnIteSer: Boolean): String;
function fItemServico(item: TDadosItem): Boolean;
function fDecodeBase64(strBase64: String): String;
function fEncodeBase64(strTexto: String): String;

function fNumDocEnvio(strNumDoc: String): String;

function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
function fBarraNoFinal(strPath: String): String;
procedure pFindFiles(const strFileMask: String ; stlStringList: TStrings; blnIncludePath : Boolean = True);
function fFloatToStrVirgula(valor: double; inte,deci: integer): string;
function fAjustaComando(strComando: String): String;
function fChangeLineBreak(const strText: String; strNewLineBreak: String = ';'): String;
function fXmlEhUTF8(const strXML: String): Boolean;
function fConverteXMLtoUTF8(const strXML: String): String;
function fNativeStringToUTF8( strString : String ) : AnsiString;
function fRemoveAcento(Str:String): String;
function fPrefixoValido(fonteDados: IFonteDados; strPrefixo: String): Boolean;
function fValidaGTIN(strGTIN: string): Boolean;
function fPathOpcoesIni: String;
procedure pLogEnotas(const strValor: String);
procedure pLogImp(const strValor: String);
procedure pLog(const strValor: String);
function ShellExecuteAndWait(Operation, FileName, Parameter, Directory: String; Show: Word; bWait: Boolean): Longint;
{$IFDEF LINUX}
function ShellExecute(AComand: String): String;
{$ENDIF}
function KillProcess(pid: cardinal): Boolean;
function fRegimeTributarioEmitente(strSimPau, strSimBru: string): string;
function fGetTipoAbreviacao(dadosGerais: TDadosGerais): String;
function fRegimeSubstituicaoTributaria(fonteDados: IFonteDados; const strOpcDoc : String) : String;
function fCfgRegimeSubstituicaoTributaria(fonteDados: IFonteDados; const strOpcDoc : String) : String;
function fCalcBeneficioReducaoBase(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente): Boolean;
function fCalculaFCPComReducaoBaseIcmsST(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente): Boolean;
function fAliquotaIcmsUF(fonteDados: IFonteDados; strUF: String): Double;
function fBuscaRegraModalidadeDeterminacaoBCST(fonteDados: IFonteDados; strCodSit: string; blnTemIva: boolean): string;
function fCodigoBeneficioFiscal(fonteDados: IFonteDados; const strCodSit, strCodAbf, strPerfilAbreviacao, strClaFis: String): String;
function fBuscaBeneficioFiscalDaAbreviacao(fonteDados: IFonteDados; const strEstado, strCodAbf, strPerfilAbreviacao, strCodSit: String): String;
function fBuscaBeneficioFiscalDaTabelaDefault(fonteDados: IFonteDados; strCodSit, strUFEmit: string): string;
function fCodigoAbreviacaoProduto(fonteDados: IFonteDados; const strCodIte: String): String;
function VerImpressoraONLINE(impressora: String): Cardinal;
function fIdentificarNomeDaImpressora(fonteDados: IFonteDados; AImpressora: String): String;
function fBuscaAliquotaDeIcmsDaOperacaoPropria(fonteDados: IFonteDados; strCodIte, strCodAbf, strEstado, strPerfil, strCodEmp: string): double;
function fRetornaEstadosQueCalculamFcpStDentro_e_ForaDoEstado(fonteDados: IFonteDados): String;
function fProdutoIndustrializadoDentroDoEstado(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente; dadosItem: TDadosItem): Boolean;
function fProdutoRevendaDentroDoEstado(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente; dadosItem: TDadosItem): Boolean;
function fRetornaFilaImpressaoNFCe(fonteDados: IFonteDados): String;
function GetComputerNetName: string;
function GetUserFromWindows: string;
function GetIPAddress: Integer;
function GetIPAddressAsString: string;
function GetMacAddress: string;
function HasParam(AParamID: String): Boolean;
function GetParamValue(AParamID: String): String;
function fConfiguracaoExisteFonte(fonteDados: IFonteDados; strCodCfg: String): Boolean;
function fRetNomePais(fonteDados: IFonteDados; strCodPai: String): String;
function fUsaUniTri(strClaFis: String): Boolean;
function fUsaNotaServicoEletronicaEnotas(fonteDados: IFonteDados): Boolean;
function fDocumentoEntregaFuturaClienteVaiRetirar(fonteDados: IFonteDados): Boolean;
function fUtilizaPDFtoPrinter(fonteDados: IFonteDados): Boolean;
function fUtilizaPDFtoPrinterNoEnotas(fonteDados: IFonteDados): Boolean;
function fSubstituirEnterPorEspaco(const strValor: String): String;
procedure pCriarDiretorioDanfeEnotasCasoNaoExista;
function fDiretorioDanfeEnotas: String;
function fRetNomeArquivoPDFtoPrinter: String;
function fArquivoEmUso(Const strNomeArqui: String): Boolean;
function fBooleanToString(const blnValue: Boolean): String;
procedure pSalvarTXTSemErro(const strTexto: String; const strNomeArquivo: String);
function fEssaCidadeObrigaCodigoFormatado(fonteDados: IFonteDados; const strCodigoIBGE: String): Boolean;
function fPDFToPrinterQuantidadeDeCopias(fonteDados: IFonteDados): String;
function fImpressoraLogSat(fonteDados: IFonteDados): String;
function fImpressoraArqIni(fonteDados: IFonteDados; const AstrDiretorio: String): String;
function fAcharImpressoraPeloPonto(const APonto, AEmpresa: String; fonteDados: IFonteDados): String;
function fRetornaMensagemBaseDesonerado(fonteDados: IFonteDados; fltTotalBaseIcmsDesonerado: Double): String;
function fExisteElementoMatriz(const strElemento : String; const arrElementos : TArrString) : Boolean;
procedure pAcrescentaElementoMatriz(const strElemento : String; var arrElementos : TArrString);
function fDataValida(dtaData: TDateTime): Boolean;
function fGetParteEndereco(const strEndereco: String): TRecCliEnd;
function fAmbienteDeHomologacao(fonteDados: IFonteDados; strCodEmp: String): Boolean;
function fUsaSchemaReformaTributaria(fonteDados: IFonteDados; strCodEmp: String): Boolean;
function fSomarNovosImpostosDaReformaAoValorContabil(fonteDados: IFonteDados; const strCodEmp: String): Boolean;
function fSomarNovosImpostosDaReformaAoVNF(fonteDados: IFonteDados; const strCodEmp: String): Boolean;
function fGeraSchemaReformaTributaria(fonteDados: IFonteDados; strCodEmp: String): Boolean;
function fNfeInfAdicQtdeSelos(fonteDados: IFonteDados; var intQtdeSelos: Integer): Boolean;
function fExigeInsucesso(const AXML: string): Boolean;
function fImagemParaBase64(const ACaminhoImagem: string): string;
function fGerarHashEntrega(const AChaveNFe: string; const ACaminhoImagem: string): string;

{$IFNDEF LINUX}
function StartProcess(Exename, CmdLineArgs: String; ShowWindow, WaitForFinish: boolean): Cardinal;
{$ENDIF}

Const
  STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#';
  STR_CHAR_TROCA = 'ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£#';
  STR_CHAR_CRYPT = 'ABCDEFGHIJKLMNOPQRSTUVWYXZabcdefghijklmnopqrstuvwyxz 1234567890/:_*#';

  CLASS_FISCAL_TRANSFER = '152_409_916_';//5152,6152...6409

  CFOP_COMBUSTIVEL = '1651_1652_1653_1658_1659_1660_1661_' +
                     '1662_1663_1664_2651_2652_2653_2658_2659_' +
                     '2660_2661_2662_2663_2664_3651_3652_3653_' +
                     '5651_5652_5653_5654_5655_5656_5657_5658_' +
                     '5659_5660_5661_5662_5663_5664_5665_5666_' +
                     '5667_6651_6652_6653_6654_6655_6656_6657_' +
                     '6658_6659_6660_6661_6662_6663_6664_6665_' +
                     '6666_6667_7651_7654_7667';

  CST_REFORMA_TRIBUTARIA_SEM_ALIQUOTA = '400_410_510_800_810_811_820_830_' ;
  DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION = ' SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; ';

Var
  objVirtualUIPrintPDF: IVirtualUIPrintPDF = nil;
  objConfig: TConfiguracoesNFE = Nil;
  objConfigProxy: TConfiguracaoProxy;
  objConfigInterna: TConfiguracoesInternas;
  arrFormasPagamentoInterna: Array Of TFormaPagamentoInterna;
  VS_PDFtoPrinter: Boolean;
  VS_PDFtoPrinterEnotas: Boolean;
  VS_PDFtoPrinterQtdeCopias: String;
  VS_PathSat: string;
{$IF Defined(VER180)}
{$ELSE}
  OnNotificarProgresso: TOnNotificarProgresso;
{$IFEND}
{$IFDEF LINUX}
  Application: TApplication;
{$ENDIF}

implementation

uses untVerificaIntegradorNFe, untUtilBD, untLogDanfe, untDicSis;

{ Application }

{$IFDEF LINUX}
constructor TApplication.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FExeName := System.SysUtils.GetModuleName(HInstance);
end;

procedure TApplication.ProcessMessages;
begin
  //do nothing
end;
{$ENDIF}

{$IFDEF LINUX}
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
{$ENDIF}

function VerImpressoraONLINE(impressora: String): Cardinal;
{$IFDEF LINUX}
begin
  raise Exception.Create('VerImpressoraONLINE n„o possui implementaÁ„o linux');
end;
{$ELSE}
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
{$ENDIF}

function fIdentificarNomeDaImpressora(fonteDados: IFonteDados; AImpressora: String): String;
{$IFDEF LINUX}
begin
  pLogImp('Impressora n„o identificada. Ir· permanecer "'+AImpressora+'"');
  Result := AImpressora;
end;
{$ELSE}
Var
  intCnt: Integer;
  dtsExpressoes: TDataSet;
  strExpressao: String;
  blnIdentificou: Boolean;
  blnPreVerifica: Boolean;
  strNomeImpressoraNoWindows: String;

  function fIdentificouImpressora(APrinter: String): Boolean;
  Var
    dtsExpressaoResult: TDataSet;
  begin
    Result := False;
    dtsExpressoes.First;
    While Not dtsExpressoes.Eof Do
    Begin
      strExpressao := 'SELECT ' +
        QuotedStr(APrinter) + ' LIKE ' +
        QuotedStr(AnsiReplaceStr(AnsiReplaceStr(
                  dtsExpressoes.FieldByName('IDE_EXPRES').AsString,
                  'NOME_IMPRESSORA', AImpressora),
                  '\', '\\'));

      dtsExpressaoResult := fonteDados.fExecutaQuery(strExpressao, [], []);

      pLogImp('Testando como: '+strExpressao);
      Try
        If dtsExpressaoResult.Fields[0].AsInteger > 0 Then
        Begin
          pLogImp('Identificou como: '+strExpressao);

          Result := True;
          Break;
        End;
      Finally
        FreeAndNil(dtsExpressaoResult);
      End;

      dtsExpressoes.Next;
    End;
  end;

begin
  Result := AImpressora;

  If fEmptyStr(Result) Then
    Exit;

  If Not Assigned(fonteDados) Then
    Exit;

  If fArqIniLocal(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S', fPathOpcoesIni) <> 'N' Then
    If fCfgSisFonte(fonteDados, 'SPOIMP') = 'S' Then
      Exit;

  If fCfgSisFonte(fonteDados, 'CADIMP') <> 'S' Then
    Exit;

  pLogImp('Identificando nome da impressora "'+AImpressora+'" pelo "Cadastro de Impressoras" [CFG_CADIMP]');

  blnIdentificou := False;
  dtsExpressoes := fonteDados.fExecutaQuery('SELECT IDE_EXPRES FROM IDEIMP',[],[]);
  Try
    Printer.Refresh;

    blnPreVerifica := True;
    If (fCfgSisFonte(fonteDados, 'CIVRDR') = 'S') Then
      blnPreVerifica := False;

    For intCnt := 0 To Printer.Printers.Count -1 Do
    Begin
      strNomeImpressoraNoWindows := Printer.Printers[intCnt];

      If (blnPreVerifica) Then
      Begin
        If (Pos(AnsiUpperCase(AImpressora), AnsiUpperCase(strNomeImpressoraNoWindows)) = 0) Then
        Begin
          If (Printer.Printers.Count <= 100) Then
            pLogImp('Impressora [IGNORADA]: ' + strNomeImpressoraNoWindows);

          Continue;
        End;
      End;

      pLogImp('Impressora [TESTAR]: ' + strNomeImpressoraNoWindows);
      If fIdentificouImpressora(strNomeImpressoraNoWindows) Then
      Begin
        If VerImpressoraONLINE(strNomeImpressoraNoWindows) = 0 Then
        Begin
          blnIdentificou := True;
          pLogImp('Identificado. Impressora: '+AImpressora+' È '+strNomeImpressoraNoWindows+' no Windows');

          Result := strNomeImpressoraNoWindows;
          Break;
        End
        Else
        Begin
          pLogImp('Identificado. Impressora: '+AImpressora+' È '+strNomeImpressoraNoWindows+' no Windows, porÈm, ela est· OFF-LINE e n„o ser· considerada');
        End;
      End;
    End;
  Finally
    If (Not blnIdentificou) Then
      pLogImp('Impressora n„o identificada. Ir· permanecer "'+AImpressora+'"');

    FreeAndNil(dtsExpressoes);
  End;
end;
{$ENDIF}

{***************************************}
{* Insere Zeros ‡ frente de uma string *}
{************************************DV*}
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

{***************************************}
{* Insere Zeros ‡ frente de uma string *}
{************************************MA*}
function fStrZero(Zeros:Integer;Quant:integer):String;
begin
  fStrZero := untUtil.fStrZero(IntToStr(Zeros), Quant);
end;

function fReplicatorStr(strRepl: String; intTamanho: Integer):String;
	Var
  	intContador : Integer;
begin
	Result:= '';
  For intContador := 1 To intTamanho Do
  Begin
  	Result := Result + strRepl;
  End;
end;

{*****************************************}
{* FAZ ALINHAMENTO (PAD) ¿ ESQUERDA      *}
{**************************************WI*}
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
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
  intTamanho := intTamanho - Length(strTexto);
  intDir := (intTamanho Div 2);
  intEsq := (intTamanho Div 2) + intTamanho Mod 2;

  Result := strTexto;
  For intContador := 1 To intDir Do
    Result := Result + strCaracter;
  For intContador := 1 To intEsq Do
    Result := strCaracter + Result;
end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) ¿ DIREITA       *}
{**************************************WI*}
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
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

function fEmptyStr(const AString: string): Boolean;
begin
  Result := fEmptyStrDicSis(AString);
end;

function IfEmptyStr(const AString, AStringDefault: String): String;
begin
  Result := IfEmptyStrDicSis(AString, AStringDefault);
end;

function fQuebraStringLinhas(strMensagem: String; intTamanho: Integer): String;
  Var
    stlMsg : TStringList;
    intCont: Integer;
begin

  Result := '';

  stlMsg := TStringList.Create;
  stlMsg.Text := WrapText(strMensagem, #13#10, [' '], intTamanho);

  For IntCont := 0 To stlMsg.Count -1 Do
    Result := Result + fPadR(AnsiReplaceStr(stlMsg[IntCont], #13#10, ''), intTamanho);

  FreeAndNil(stlMsg);
end;

function fTiraCaracEspeciais(strTexto: String; blnUsaLista: Boolean = True;
  blnTiraEspacos: Boolean = False; blnTiraPontos: Boolean = False; blnRemoverSomenteEscapesHtml: Boolean = False): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If (Not blnRemoverSomenteEscapesHtml) Then
  Begin
    If blnUsaLista Then
      strLista := '/\-_+#,;<>'
    Else
      strLista := EmptyStr;

    If (blnTiraEspacos = True) Then
      strLista := strLista + ' ';

    If (blnTiraPontos = True) Then
      strLista := strLista + '.';

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
  End
  Else
  Begin
    Result := strTexto;
  End;

  //converte caracteres controle XML para seus respectivos escapes...
  Result := AnsiReplaceStr(Result,'&','&amp;');
  Result := AnsiReplaceStr(Result,'<','&lt;');
  Result := AnsiReplaceStr(Result,'>','&gt;');
  Result := AnsiReplaceStr(Result,'''','&apos;');
  Result := AnsiReplaceStr(Result,'"','&quot;');
  //....converte caracteres controle XML para seus respectivos escapes

  If (Not blnRemoverSomenteEscapesHtml) Then
  Begin
    Result := AnsiReplaceStr(Result,'∫','.');
    Result := AnsiReplaceStr(Result,'™','.');
    Result := AnsiReplaceStr(Result,'Ω','1/2');
    Result := AnsiReplaceStr(Result,'º','1/4');
    Result := AnsiReplaceStr(Result,'æ','3/4');
    Result := AnsiReplaceStr(Result,'π','.');
    Result := AnsiReplaceStr(Result,'≥','.');
    Result := AnsiReplaceStr(Result,'≤','.');
  End;
end;

function fLimpaCaracteres(strTexto: String): String;
begin
  Result := fTiraCaracEspeciais(strTexto);

  While Pos('.', Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, '.', '');
  End;

  Result := AnsiReplaceStr(AnsiReplaceStr(Result, '(', ''), ')', '');
end;

function fCountChar(strTexto: String; strChar: String): Integer;
  Var
    intCnt : Integer;
begin
  Result := 0;

  If fEmptyStr(strTexto) Or fEmptyStr(strChar) Then
    Exit;

  For intCnt := 1 To Length(strTexto) Do
  Begin
    If ((strTexto[intCnt]) = strChar) Then
      Result := Result + 1;
  End;
end;

function fLimpaCaracteresTelefone(strTexto: String): String;
begin
  Result := fRetSomenteNumeros(strTexto);

  If (Length(Result) < 6) Then
    Result := '';
end;

{**********************************************************}
{* -> RENOMEIRA ARQUIVOS                                  *}
{*******************************************************WI*}
Function fRenomearArquivo( strArqOrigem, strArqDestino : String ):Boolean;
  Var
    intQtdSegundos  : Integer;
    timHoraAnterior : TDateTime;
Begin
  Result := False;

  timHoraAnterior := SysUtils.Time;
  While True Do
  Begin
    If RenameFile( strArqOrigem, strArqDestino ) Then
    Begin
      Result := True;
      Break;
    End;
    intQtdSegundos := SecondOfTheDay( SysUtils.Time ) - SecondOfTheDay( timHoraAnterior );
    If ( intQtdSegundos > 5 ) Then
      Break;
  End;
End;

procedure pDeleteFile(strNomArq: String);
begin
  DeleteFile(strNomArq);
end;

{*****************************************}
{* VERIFICA SE O ARQUIVO EST¡ PRONTO.    *}
{* PARA TAL, VERIFICA SE O ARQUIVO PODE  *}
{* SER ABERTO. CASO POSITIVO, VERIFICA,  *}
{* ATRAV…S DO SEU TAMANHO, SE O MESMO J¡ *}
{* TERMINOU DE SER ESCRITO.              *}
{**************************************MV*}
function fArquivoPronto(strArquivo: String): Boolean;
  Var
    sfsArquivo: TFileStream;
    intTamanho: Cardinal;
    blnDiferente: Boolean;
    intCont: Integer;
begin

  Result := False;
  Try
    Sleep(250);
    sfsArquivo := TFileStream.Create(strArquivo, fmOpenRead Or fmShareExclusive);
    FreeAndNil(sfsArquivo);

    intTamanho := fTamanhoArquivo(strArquivo);
    blnDiferente := False;

    For intCont := 1 To 6 Do
    Begin

      Sleep(250);
      If intTamanho <> fTamanhoArquivo(strArquivo) Then
      Begin
        blnDiferente := True;
      End;

    End;

    Result := (Not blnDiferente);
  Except
    //
  End;

end;

function fTamanhoArquivo(strArquivo: String): Cardinal;
{$IFDEF LINUX}
begin
  raise Exception.Create('fTamanhoArquivo n„o possui implementaÁ„o linux');
end;
{$ELSE}
  Var
    FHandle: Cardinal;

begin
  FHandle := CreateFile(PChar(strArquivo), GENERIC_READ,
    FILE_SHARE_READ Or FILE_SHARE_WRITE Or FILE_SHARE_DELETE, Nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  If FHandle <> 0 Then
    Result := GetFileSize(FHandle, Nil)
  Else
    Result := 0;

  FileClose(FHandle);
end;
{$ENDIF}

{********************************************}
{* RETORNA O VALOR DA 'intColuna' LINHA DE  *}
{* UMA STRING SEPARADA POR 'strDelimitador' *}
{*****************************************MV*}
function fGetValorLinha(strLinha, strDelimitador: String; intColuna: Integer; blnIgnoraPrimeiro: Boolean=False): String;
  Var
    intContador: Integer;
    intContDel: Integer;
    intTamStr: Integer;
    intEstado: Integer; // 0=normal 1=entre aspas
begin
  Result := '';

  If fEmptyStr(strLinha) Then
  Begin
    Exit;
  End;

  If blnIgnoraPrimeiro Then
  Begin
    If AnsiStartsText('|', strLinha) Then
    Begin
      strLinha := Copy(strLinha, 2, Length(strLinha));
    End;
  End;

  intTamStr := Length(strLinha);
  intContador := 1;
  intContDel  := 1;

  intEstado := 0;

  While (intContDel < intColuna) Do
  Begin

    If (strLinha[intContador] = strDelimitador) And (intEstado = 0) Then
    Begin
      Inc(intContDel);
    End
    Else If strLinha[intContador] = '"' Then
    Begin
      If intEstado = 0 Then
        intEstado := 1
      Else
      Begin
        intEstado := 0;
        Inc(intContador);
        Continue;
      End;
    End;
    Inc(intContador);

    If (intContador = intTamStr) Then
    Begin
      Break;
    End;

  End;

  intEstado := 0;

  While (intContador <= intTamStr) And ((strLinha[intContador] <> strDelimitador) Or (intEstado = 1)) Do
  Begin

    If strLinha[intContador] = '"' Then
    Begin
      Inc(intContador);
      If intEstado = 0 Then
        intEstado := 1
      Else
      Begin
        intEstado := 0;
        Continue;
      End;
    End;


    Result := Result + strLinha[intContador];
    Inc(intContador);
  End;
end;

function fValidaCnpjCpf(strValor: String; fonteDados: IFonteDados): Boolean;
  Var
    strOpcao: String;
begin
  Result := False;
  If Length(strValor) <= 11 Then
    strOpcao := '2'
  Else
    strOpcao := '1';

  If strOpcao = '1' Then
  Begin
    Result := fTestaCgc(strValor, fonteDados);
  End
  Else If strOpcao = '2' Then
  Begin
    Result := fValidaCPF(strValor);
  End;
end;

{*********************************}
{* VALIDA CGC                    *}
{*********************************}
function fTestaCgc(xCGC: String; fonteDados: IFonteDados):Boolean;
begin
  Result := TCNPJ.fTestaCNPJ(xCGC, fCfgSisFonte(fonteDados, 'NWCNPJ') = 'S');
end;

{*********************************}
{* VALIDA CPF                    *}
{*********************************}
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

{*****************************************}
{* EXECUTA UM IIF, IGUAL O CLIPPER :^)   *}
{**************************************MV*}
function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

{*****************************************}
{* VALIDA A INSCRI«√O ESTADUAL           *}
{**************************************MV*}
function fValidaIES(strIES, strEstado: String): Boolean;
  Var
    intContador : Integer;
    intValG     : Integer;
    intVSom     : Integer;
    intVRes     : Integer;
    intVPro     : Integer;
    intP        : Integer;
    intD        : Integer;
    intN        : Integer;
    intMod      : Integer;
    strVDig1    : String;
    strVDig2    : String;
    strVBase    : String;
    strVBase2   : String;
    strBase     : String;
    strOrigem   : String;
    strMascara  : String;
    strVSom     : String;
    arrVMul     : Array Of Integer;
begin
  strVBase   := '';
  strBase    := '';
  strOrigem  := '';
  strMascara := '99999999999999';

  intP := 0;
  intD := 0;
  Result := False;
  If fEmptyStr(strIES) Then
  Begin
    Result := True;
    Exit;
  End;

  For intContador := 1 To Length(Trim(strIES)) Do
  Begin
    If Pos(strIES[intContador], '0123456789P') > 0 Then
      strOrigem := strOrigem + strIES[intContador];
  End;

  If (strEstado <> 'SP') And (LeftStr(strOrigem, 1) = 'P') Then
  Begin
    Result := TRUE;
    Exit;
  End;

  If strEstado = 'AC' Then
  Begin
    strMascara := '999,99999,999-99';
    strBase    := fPadR(strOrigem, 13, '0');

    intVSom := 0;
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([4,3,2,9,8,7,6,5,4,3,2]);
    For intContador := 0 To 10 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1],0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes   := intVSom Mod 11;
    strVDig1  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
    strVBase2 := LeftStr(strBase, 11) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 0);
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([5,4,3,2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 11 Do
    Begin
      intValG := StrToIntDef(strVBase2[intContador+1],0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes   := intVSom Mod 11;
    strVDig2  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
    strVBase2 := strVBase2 + strVDig2;
    Result := (strVDig1 = Copy(strBase, 12, 1)) And (strVDig2 = Copy(strBase, 13, 1));
  End
  Else If strEstado = 'AL' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '24' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador],0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVPro  := intVSom * 10;
      intVRes  := intVPro Mod 11;
      strVDig1 := IntToStr(IIF(intVRes = 10, 0, intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'AM' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');                                   
    intVSom    := 0;                                                          

    For intContador := 1 To 8 Do                                              
    Begin
      intValG := StrToIntDef(strBase[intContador],0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    If intVSom < 11 Then
      strVDig1 := IntToStr(11 - intVSom)
    Else
    Begin
      intVRes := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11-intVRes));
    End;                                                                      

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);



  End
  Else If strEstado = 'AP' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '03' Then
    Begin
      intN := StrToIntDef(LeftStr(strBase, 8),0);
      If (intN >= 3000001) And (intN <= 3017000) Then
      Begin
        intP := 5;
        intD := 0;
      End
      Else If (intN >= 3017001) And (intN <= 3019022) Then
      Begin
        intP := 9;
        intD := 1;
      End
      Else If intN >= 3019023 Then
      Begin
        intP := 0;
        intD := 0;
      End;

      intVSom := intP;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador],0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(11 - intVRes);

      If StrToIntDef(strVDig1,0) = 10 Then
        strVDig1 := '0'
      Else If StrToIntDef(strVDig1,0) = 11 Then
        strVDig1 := IntToStr(intD);

      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result := (strVBase = strOrigem);
    End;

  End

  Else If strEstado = 'BA' Then
  Begin
    If Length(strOrigem) = 8 Then // 8 Digitos
    Begin
      strMascara := '999999-99';
      strBase    := fPadR(strOrigem, 9, '0');

      intVSom := 0;
      If Pos(strBase[1], '0123458') > 0 Then
      Begin
        For intContador := 1 To 6 Do
        Begin
          intValG := StrTointDef(strBase[intContador],0);
          intValG := intValG * (8 - intContador);
          intVSom := intVSom + intValG;
        End;

        intVRes   := intVSom Mod 10;
        strVDig2  := IntToStr(IIF(intVRes = 0, 0, 10 - intVRes));
        strVBase2 := LeftStr(strBase, 6) + strVDig2;

        intVSom := 0;

        For intContador := 1 To 7 Do
        Begin
          intValG := StrToIntDef(strVBase2[intContador],0);
          intValG := intValG * (9 - intContador);
          intVSom := intVsom + intValG;
        End;

        intVRes  := intVSom Mod 10;
        strVDig1 := IntToStr(IIF(intVRes = 0, 0, 10 - intVRes));
      End
      Else
      Begin
        For intContador := 1 To 6 Do
        Begin
          intValG := StrToIntDef(strBase[intContador], 0);
          intValG := intValG * (8 - intContador);
          intVSom := intVSom + intValG;
        End;

        intVRes   := intVSom Mod 11;
        strVDig2  := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
        strVBase2 := LeftStr(strBase, 6) + strVDig2;

        intVSom := 0;

        For intContador := 1 To 7 Do
        Begin
          intValG := StrToIntDef(strVBase2[intContador], 0);
          intValG := intValG * (9 - intContador);
          intVSom := intVSom + intValG;
        End;

        intVRes  := intVSom Mod 11;
        strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      End;

      strVBase2 := LeftStr(strBase, 6) + strVDig1 + strVDig2;
      Result    := (strVBase2 = strOrigem);
    End

    Else If Length(strOrigem) = 9 Then // 9 Digitos
    Begin
      strMascara := '999999-99';
      strBase    := fPadR(strOrigem, 9, '0');

      intVSom := 0;

      intMod := IIF({$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)}CharInSet(strBase[2], ['6','7','9']){$ELSE}strBase[2] in ['6','7','9']{$IFEND}, 11, 10);

      For intContador := 1 To 7 Do
      Begin
        intValG := StrTointDef(strBase[intContador],0);
        intValG := intValG * (8 - (intContador - 1));
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod intMod;

      // mÛdulo 10: quando o resto for igual a 0 (zero) o digito È igual a 0 (zero).
      If (intMod = 10) Then
        strVDig2 := IntToStr(IIF(intVRes = 0, 0, intMod - intVRes))
      Else
      // mÛdulo 11: quando o resto for igual a 0 (zero) ou 1 (um) o digito È igual a 0 (zero)
        strVDig2 := IntToStr(IIF(intVRes < 2, 0, intMod - intVRes));

      strVBase2 := LeftStr(strBase, 7) + strVDig2;

      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strVBase2[intContador],0);
        intValG := intValG * (9 - (intContador - 1));
        intVSom := intVsom + intValG;
      End;

      intVRes  := intVSom Mod intMod;

      // mÛdulo 10: quando o resto for igual a 0 (zero) o digito È igual a 0 (zero).
      If (intMod = 10) Then
        strVDig1 := IntToStr(IIF(intVRes = 0, 0, intMod - intVRes))
      Else
      // mÛdulo 11: quando o resto for igual a 0 (zero) ou 1 (um) o digito È igual a 0 (zero)
        strVDig1 := IntToStr(IIF(intVRes < 2, 0, intMod - intVRes));

      strVBase2 := LeftStr(strBase, 7) + strVDig1 + strVDig2;

      Result    := (strVBase2 = strOrigem);
    End;

  End

  Else If strEstado = 'CE' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);
    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'DF' Then
  Begin

    strMascara := '999,99999,999-99';
    strBase    := fPadR(strOrigem, 13, '0');

    If pos(LeftStr(strBase, 2), '07_08_') > 0 Then
    Begin
      intVSom := 0;
      SetLength(arrVMul, 12);
      arrVMul := VarArrayOf([4,3,2,9,8,7,6,5,4,3,2]);
      For intContador := 0 To 10 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig1  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
      strVBase2 := LeftStr(strBase, 11) + strVDig1;

      intVSom := 0;
      SetLength(arrVMul, 0);
      SetLength(arrVMul, 12);
      arrVMul := VarArrayOf([5,4,3,2,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 11 Do
      Begin
        intValG := StrToIntDef(strVBase2[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig2  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
      strVBase2 := strVBase2 + strVDig2;
      Result := (strVDig1 = Copy(strBase, 12, 1)) And (strVDig2 = Copy(strBase, 13, 1));
    End;
  End
  Else If strEstado = 'ES' Then
  Begin
    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVsom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);
  End
  Else If strEstado = 'GO' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If Pos(LeftStr(strBase, 2), '10.11.15.20') > 0 Then
    Begin
      intVSom := 0;
      arrVMul := VarArrayOf([9,8,7,6,5,4,3,2]);

      For intContador := Low(arrVMul) To High(arrVMul) Do
      Begin
        intVSom := intVSom + (StrToIntDef(strBase[intContador+1], 0) * arrVMul[intContador]);
      End;

      intVRes := intVSom Mod 11;

      //Quando a inscriÁ„o for 11094402 o dÌgito verificador pode ser zero (0) e pode ser um (1);
      If (LeftStr(strBase, 8) = '11094402') Then
      Begin
        If (Pos(RightStr(strBase, 1), '01') > 0) Then
          Result := True
        Else
          Result := False;

        Exit;
      End
      Else If (intVRes = 0) Then
      BEgin
        strVDig1 := '0'
      End
      Else If (intVRes = 1) Then
      Begin

        intN := StrToIntDef(LeftStr(strBase, 8), 0);
        strVDig1 := IIF((intN >= 10103105) And (intN <= 10119997), 1, 0);

      End
      Else
      Begin
        strVDig1 := IntToStr(11 - intVRes);
      End;

      strVBase := LeftStr(strBase, 8) + strVDIg1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MA' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '12' Then
    Begin
      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig1  := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase  := LeftStr(strBase, 8) + strVDig1;
      Result    := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MT' Then
  Begin

    strMascara := '999999999';
    strBase := fPadR(strOrigem, 9, '0');
    intVSom := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRES < 2, 0, 11 - intVRes));
    strVBase2 := LeftStr(strBase, 8) + strVDig1;

    Result := (strVBase2 = strOrigem);

  End
  Else If strEstado = 'MS' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If (LeftStr(strBase, 2) = '28') Or (LeftStr(strBase, 2) = '50') Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG; 
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MG' Then
  Begin
    strOrigem  := fPadL(strOrigem, 13, '0');
    strMascara := '999,999,999/9999';
    strBase    := strOrigem;
    strVBase2  := LeftStr(strBase, 3) + '0' + Copy(strBase, 4, 8);
    intN       := 2;
    strVSom    := '';

    For intContador := 1 To 12 Do
    Begin
      intValG := StrToIntDef(strVBase2[intContador], 0);
      intN    := IIF(intN = 2, 1, 2);
      intValG := intValG * intN;
      strVSom := strVSom + IntToStr(intValG);
    End;

    intN := 0;
    For intContador := 1 To Length(strVSom) Do
      intN := intN + StrToIntDef(strVSom[intContador],0);

    intVSom := intN;
    While RightStr(IntToStr(intN), 1) <> '0' Do
    Begin
      Inc(intN);
    End;

    strVDig1 := IntToStr(intN - intVSom);
    strVBase := leftStr(strBase, 11) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([3,2,11,10,9,8,7,6,5,4,3,2]);
    For intContador := 0 To 11 Do
    Begin
      intValG := StrToIntDef(strVBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig2 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := strVBase + strVDig2;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PA' Then
  Begin

    strMascara := '99-999999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If pos(LeftStr(strBase, 2), '15_75_') > 0 Then
    Begin
      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'PB' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PE' Then
  Begin

    // VALIDA«√O DA INSCRICAO ESTADUAL ANTIGA - 14 dÌgitos
    If length(strIES) > 9 Then
    Begin
      strMascara := '99,9,999,9999999-9';
      strBase    := fPadR(strOrigem, 14, '0');
      intVSom    := 0;
      Setlength(arrVMul, 13);
      arrVMul := VarArrayOf([5,4,3,2,1,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 12 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(11 - intVRes);

      If StrToIntDef(strVDig1, 0) > 9 Then
        strVDig1 := IntToStr(StrToIntDef(strVDig1, 0) - 10);

      strVBase := LeftStr(strBase, 13) + strVdig1;
      Result := (strVBase = strOrigem);
    End
    Else
    // VALIDA«√O DA INSCRICAO ESTADUAL NOVA - 9 dÌgitos
    Begin
      strMascara := '9999999-99';
      strBase    := fPadR(strOrigem, 9, '0');
      intVSom    := 0;
      Setlength(arrVMul, 7);
      arrVMul := VarArrayOf([8,7,6,5,4,3,2]);

      For intContador := 0 To 6 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;

      If (intVRes = 1) Or (intVRes = 0) Then
        strVDig1 := '0'
      Else
        strVDig1 := IntToStr(11 - intVRes);

      strBase    := fPadR(strOrigem, 9, '0');
      intVSom    := 0;
      Setlength(arrVMul, 8);
      arrVMul := VarArrayOf([9,8,7,6,5,4,3,2]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;

      If (intVRes = 1) Or (intVRes = 0) Then
        strVDig2 := '0'
      Else
        strVDig2 := IntToStr(11 - intVRes);

      strVBase := LeftStr(strBase, 7) + strVDig1 + strVDig2;
      Result := (strVBase = strOrigem);
    End;
  End
  Else If strEstado = 'PI' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PR' Then
  Begin

    strMascara := '999,99999-99';
    strBase    := fPadR(strOrigem, 10, '0');
    intVSom    := 0;
    SetLength(arrVMul, 8);
    arrVMul := VarArrayOf([3,2,7,6,5,4,3,2]);

    For intContador := 0 To 7 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 0);
    SetLength(arrVMul, 9);
    arrVMul := VarArrayOf([4,3,2,7,6,5,4,3,2]);

    For intContador := 0 To 8 Do
    Begin
      intValG := StrToIntDef(strVBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig2 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := strVBase + strVdig2;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'RJ' Then
  Begin

    strMascara := '99,999,99-9';
    strBase    := fPadR(strOrigem, 8, '0');
    intVSom    := 0;
    SetLength(arrVMul, 7);
    arrVMul := VarArrayOf([2,7,6,5,4,3,2]);

    For intContador := 0 To 6 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom  := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 7) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'RN' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '20' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;
      intVPro  := intVSom * 10;
      intVRes  := intVPro Mod 11;
      strVDig1 := IntToStr(IIF(intVRes > 9, 0, intVres));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;
  End
  Else If strEstado = 'RO' Then
  Begin

    strMascara := '9999999999999-9';
    strBase    := fPadR(strOrigem, 14, '0');
    intVSom    := 0;
    arrVMul := VarArrayOf([6,5,4,3,2,9,8,7,6,5,4,3,2]);

    For intContador := Low(arrVMul) To High(arrVMul) Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := IntToStr(StrToIntDef(strVDig1, 0) - 10);

    strVBase := LeftStr(strBase, 13) + strVDig1;
    Result   := (strVbase = strOrigem);

  End
  Else If strEstado = 'RR' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '24' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * intContador;
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 9;
      strVDig1 := IntToStr(intVRes);
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);

    End;

  End
  Else If strEstado = 'RS' Then
  Begin

    strMascara := '999/999999-9';
    strBase    := fPadL(strOrigem, 10, '0');

    intVSom := 0;
    SetLength(arrVMul, 9);
    arrVMul := VarArrayOf([2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 9) + strVDig1;
    Result   := (strVBase = fPadL(strOrigem, 10, '0'));

  End
  Else If strEstado = 'SC' Then
  Begin

    strMascara := '999,999,999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'SE' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);
    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'SP' Then
  Begin

    intVSom := 0;
    If LeftStr(strOrigem, 1) = 'P' Then
    Begin
      strMascara := 'P-99999999,9/999';
      strBase    := fPadR(strOrigem, 13, '0');
      strVBase   := Copy(strBase, 2, 8);
      SetLength(arrVMul, 8);
      arrVMul := VarArrayOf([1,3,4,5,6,7,8,10]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strVBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := RightStr(IntToStr(intVRes), 1);
      strVBase := LeftStr(strBase, 9) + strVDig1 + Copy(strBase, 11, 3);
    End
    Else
    Begin
      strMascara := '999,999,999,999';
      strBase    := fPadR(strOrigem, 12, '0');
      SetLength(arrVMul, 8);
      arrVMul := VarArrayOf([1,3,4,5,6,7,8,10]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := RightStr(IntToStr(intVRes), 1);
      strVBase := LeftStr(strBase, 8) + strVDig1 + Copy(strBase, 10,2);
      intVSom  := 0;
      SetLength(arrVMul, 11);
      arrVMul  := VarArrayOf([3,2,10,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 10 Do
      Begin
        intValG := StrToIntDef(strVBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig2 := RightStr(IntToStr(intVRes), 1);
      strVBase := strVBase + strVDig2;

    End;
    Result := (strVBase = strOrigem);

  End
  Else If strEstado = 'TO' Then
  Begin

    strMascara := '99 999999 9';
    strBase    := fPadR(strOrigem, 09, '0');

    intVSom := 0;
    For intContador := 9 DownTo 2 Do
    Begin
      intVSom := intVSom + (StrToIntDef(strBase[10-intContador], 0) * intContador);
    End;
    intVRes := intVSom Mod 11;

    If intVRes < 2 Then
      strVDig1 := '0'
    Else
      strVDig1 := IntToStr(11 - intVRes);

    Result := (RightStr(strBase, 1) = strVDig1)

  End
  Else
  Begin
    Result := False;
  End;

end;

function fGetCSTSimplesSub(dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente; dadosItem: TDadosItem): String;
begin
  If dadosEmitente.strEstado = dadosGerais.strEstado Then
    Result := objConfig.strCstSimSubs
  Else
  Begin
    Result := objConfig.strCstSimSubsForaEstado;

    If (dadosItem.fltValRet > 0) and (dadosGerais.strCliCon = 'S') Then
      Result := '202'; //Tributada pelo Simples Nacional sem permiss„o de crÈdito e com cobranÁa do ICMS por SubstituiÁ„o Tribut·ria (202)
  End;

  If (dadosItem.strImpDir = 'S') And (dadosItem.fltValRet > 0) And (objConfig.blnConIpi) Then
  Begin
    If dadosEmitente.strEstado = dadosGerais.strEstado Then
      Result := objConfig.strCstSimSubs
    Else
    Begin
      Result := objConfig.strCstSimSubsForaEstado;

      If (dadosItem.fltValRet > 0) and (dadosGerais.strCliCon = 'S') Then
        Result := '202'; //Tributada pelo Simples Nacional sem permiss„o de crÈdito e com cobranÁa do ICMS por SubstituiÁ„o Tribut·ria (202)
    End;
  End
  Else If (dadosItem.strImpDir = 'S') And (dadosItem.fltValRet > 0) and (dadosGerais.strCliCon = 'S') Then
  Begin
    Result := '202'; //Tributada pelo Simples Nacional sem permiss„o de crÈdito e com cobranÁa do ICMS por SubstituiÁ„o Tribut·ria (202)
  End;

  If dadosGerais.strEspDoc = 'IF' Then
    Result := '500'; //ICMS cobrado anteriormente por substituiÁ„o tribut·ria (substituÌdo) ou por antecipaÁ„o
end;

function fGetCSOSNSubstituicao(dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente): String;
begin
  if (dadosGerais.strEspDoc = 'IF') then
  begin
    Result := '500'; //ICMS cobrado anteriormente por substituiÁ„o tribut·ria (substituÌdo) ou por antecipaÁ„o
    Exit;
  end;

  If (dadosEmitente.strEstado = dadosGerais.strEstado) or
     (dadosGerais.blnVenPre) Then
    Result := objConfig.strCstSimSubs
  Else
    Result := objConfig.strCstSimSubsForaEstado;
end;

function fSimplesPaulista(dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente;
  blnConsiderarFornecedor: Boolean=True): Boolean;
begin
  Result := objConfig.blnSimPau;

  {************************************************************************}
  {* CASO O FORNECEDOR/CLIENTE NAO SEJA SIMPLES E A CFOP FOR DE DEVOLUCAO *}
  {* A NOTA DEVE SER EMITIDA COMO NAO SIMPLES (EMITENTE)                  *}
  {*********************************************************************JC*}
  If blnConsiderarFornecedor Then
  Begin
    If Result And (dadosGerais.strRegimeTributacao <> 'S') Then
      Result := Pos(dadosGerais.strClaFis, CFOP_DEVOLUCAO_FORNECEDOR_NFE) <= 0;
  End;

  {*************************************************************************************}
  {*[  ] AUTCOM - WIC - RONALDO                                                        *}
  {*   - MOVIMENTACAO DE ITENS                                                         *}
  {*   - NOTA DE IMPORTACAO                                                            *}
  {*     - DEVIDO A TRIBUTACAO DE ICMS, TODA NOTA DE IMPORTACAO DEVE SER               *}
  {*       ENVIADA COMO SE A CONFIGURACAO CFG_SIMPAU ESTIVESSE CONFIGURACAO COMO 'NAO'.*}
  {*     - OCORRE QUE NAS EMPRESAS 'SIMPLES NACIONAL', ESTE TIPO DE NOTA NAO ESTA¥     *}
  {*       AUTORIZANDO, FAZENDO COM QUE O OPERADOR TENHA QUE CONFIGURACAO PARA         *}
  {*       SIMPLES = NAO, REENVIAR A NOTA NO PAINEL PARA AUTORIZA-LA.                  *}
  {*************************************************************************************}
  If blnConsiderarFornecedor Then
  Begin
    If (LeftStr(dadosGerais.strClaFis, 1) = '3') Then
      Result := False;
  End;
end;

function fNotaFiscalServicosEletronicaDef(fonteDados: IFonteDados): Boolean;
begin
  Try
    Result := fonteDados.fNotaServicoEletronica;
  Except
    Result := False;
  End;
end;

function fUsaNotaServicoEletronicaEnotas(fonteDados: IFonteDados): Boolean;
begin
  Try
    Result := fonteDados.fUsaNotaServicoEletronicaEnotas;
  Except
    Result := False;
  End;
end;

function fStrToFloat(strValor: String): Double;
Begin
  Result := strToFloatDef(AnsiReplaceStr(strValor,'.',''),0);
End;

function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fStrToFloat(FloatToStrF(fltNumero, ffFixed, 12, intDecimais));
end;

function fFormataValor(fltValor: Double; intTamanho,
  intDecimais: Integer): String;
begin
  Result := Trim(AnsiReplaceStr(Format('%' + IntToStr(intTamanho + 1) + '.' + IntToStr(intDecimais) + 'f', [fltValor]), ',', ''));
end;

function fRetOrigemMercadoria(strCodsit: String): String;
begin
  Result := LeftStr(strCodsit, 1);
  If Pos(Result, '012345678') <= 0 Then
  Begin
    Result := '0';
  End;
end;

function fTratarNomeImpressora(const strImpressora: string): string;
begin
  Result := AnsiReplaceStr(strImpressora,'\\' + fRetNomeRede + '\','');
end;

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

function fNumerosRepetidos(const strString: String): Boolean;
  Var
    intIndice: Integer;
begin
  Result := True;
  For intIndice := 1 To (Length(strString)-1) Do
  Begin
    If strString[intIndice] <> strString[intIndice+1] Then
    Begin
      Result := False;
      Break;
    End;
  End;
end;

{************************************************************************}
{* COMO TIVEMOS VARIOS PROBLEMAS COM ARREDONDAMENTO QUANDO A            *}
{* PARTE FRACIONARIA TERMINA EM 5 COMO EXEMPLO 4,815 ARREDONDANDO       *}
{* COM DOIS DECIMAIS AO INVES DE 4,82 ESTAVA FICANDO 4,81, TENTAMOS     *}
{* UTILIZAR SetPrecisionMode POREM EM CADA MAQUINA O RESULTADO SAI      *}
{* DIFERENTE, EM UMA O pmSimple FUNCIONA EM OUTRAS SOMENTE pmExtended.  *}
{* FIZEMOS ESTE "AJUSTE TECNICO" PARA FORCAR O ARREDONDAMENTO PARA CIMA *}
{********************************************************************JC**}
function fRoundFiveUp(fltValue: Double; intDigits: Integer): Double;
  Var
    intDig: Integer;
    strVal: String;
begin
  strVal := FloatToStr(fltValue);
  intDig := Pos({$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300) OR Defined(VER330)} FormatSettings.DecimalSeparator {$ELSE} DecimalSeparator {$IFEND}, strVal);

  If intDig > 0 Then
    intDig := Length(MidStr(strVal, intDig + 1, Length(strVal) - intDig));

  If (intDig > 0) And (intDig > intDigits) And (strVal[Length(strVal)] = '5') Then
  Begin
    strVal[Length(strVal)] := '6';
  End;

  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDigits));
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

function fApenasUmEmail(strEmail: String): String;
  Var
    stlEmails : TStringList;
begin
  stlEmails := TStringList.Create;
  stlEmails.Clear;

  Try
    ExtractStrings([';'], [' '], PChar(strEmail), stlEmails);

    If (stlEmails.Count > 0) Then
      Result := Trim(stlEmails.Strings[0])
    Else
      Result := strEmail;
  Except
    Result := strEmail;
  End;

  If Assigned(stlEmails) Then
    FreeAndNil(stlEmails);
end;

function fMessageDlg(strTitulo, strMensagem, strOpcao1, strOpcao2: String): String;
{$IFDEF LINUX}
begin
  raise Exception.Create('fMessageDlg ainda n„o possui implementaÁ„o linux');
end;
{$ELSE}
  Var
    intAux: integer;
    frmDialog: Tform;
begin
  frmDialog := CreateMessageDialog(strMensagem, mtConfirmation, [mbYes, mbNo]);
  Try
    For intAux:=0 to frmDialog.ComponentCount -1 Do
    Begin
      If frmDialog.Components[intAux] Is TButton Then
        With TButton(frmDialog.Components[intAux]) Do
        Begin
          Case modalresult of
             mrYes: Begin Caption := strOpcao1; Width := Width + 50; Left := Left - 25; end;
             mrNo : Begin Caption := strOpcao2; Width := Width + 50; Left := Left + 25; end;
          End;
        End;
    End;

    frmDialog.Caption := strTitulo;

    frmDialog.Showmodal;

    Case frmDialog.ModalResult Of
      mrYes: Result := strOpcao1;
      mrNo : Result := strOpcao2;
    End;

  Finally
    frmDialog.free;
  End;
end;
{$ENDIF}

function fSuportaOperacaoBanco(fonteDados: IFonteDados): Boolean;
begin
  Try
    Result := fonteDados.fSuportaOperacaoBanco;
  Except
    Result := False;
  End;
end;

function fSuportaOperacaoBancoManifesto(fonteDados: IFonteDadosManifesto): Boolean;
begin
  Try
    Result := fonteDados.fSuportaOperacaoBanco;
  Except
    Result := False;
  End;
end;

function fCfgSisFonte(fonteDados: IFonteDados; strCodCfg: String): String;
  Var
    dataSet: TDataSet;
    strCodEmp: String;
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  Result := '';

  If Not fSuportaOperacaoBanco(fonteDados) Then
  Begin
    Exit;
  End;

  strCodEmp := fonteDados.fDadosGerais.strCodEmp;
  If fEmptyStr(strCodEmp) Then
    strCodEmp := objConfig.strCodEmp;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyValCfgParaDicSis(strCodCfg, strCodEmp);
  If fAchouDicSisStr(fonteDados.fRetDataBase, strKey, Result) Then
    Exit;
  {$IFEND}

  dataSet := fonteDados.fExecutaQuery('SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP',
    ['CODCFG', 'CODEMP'], ['CFG_' + strCodCfg, strCodEmp]);
  Result := dataSet.FieldByName('SIS_VALCFG').AsString;
  FreeAndNil(dataSet);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(fonteDados.fRetDataBase, strKey, Result);
  {$IFEND}
end;

function fCfgSisFonte(fonteDados: IFonteDados; strCodCfg, strCodigoEmpresa: String): String;
  Var
    dataSet: TDataSet;
    strCodEmp: String;
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  Result := '';

  If Not fSuportaOperacaoBanco(fonteDados) Then
  Begin
    Exit;
  End;

  strCodEmp := strCodigoEmpresa;
  If fEmptyStr(strCodEmp) Then
    strCodEmp := objConfig.strCodEmp;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyValCfgParaDicSis(strCodCfg, strCodEmp);
  If fAchouDicSisStr(fonteDados.fRetDataBase, strKey, Result) Then
    Exit;
  {$IFEND}

  dataSet := fonteDados.fExecutaQuery('SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP',
    ['CODCFG', 'CODEMP'], ['CFG_' + strCodCfg, strCodEmp]);
  Result := dataSet.FieldByName('SIS_VALCFG').AsString;
  FreeAndNil(dataSet);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(fonteDados.fRetDataBase, strKey, Result);
  {$IFEND}
end;

function fCfgSisFonteManifesto(fonteDados: IFonteDadosManifesto; strCodCfg, strCodigoEmpresa: String): String;
  Var
    dataSet: TDataSet;
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  Result := '';

  If Not fSuportaOperacaoBancoManifesto(fonteDados) Then
  Begin
    Exit;
  End;

  {$IF Defined(UNIDAC)}
  strKey := fFormataKeyValCfgParaDicSis(strCodCfg, strCodigoEmpresa);
  If fAchouDicSisStr(fonteDados.fRetDataBase, strKey, Result) Then
    Exit;
  {$IFEND}

  dataSet := fonteDados.fExecutaQuery('SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP',
    ['CODCFG', 'CODEMP'], ['CFG_' + strCodCfg, strCodigoEmpresa]);
  Result := dataSet.FieldByName('SIS_VALCFG').AsString;
  FreeAndNil(dataSet);

  {$IF Defined(UNIDAC)}
  pInsereDicSis(fonteDados.fRetDataBase, strKey, Result);
  {$IFEND}
end;

function fDecrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
  Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1),STR_CHAR_TROCA);
    Result := Result + MidStr(STR_CHAR_SENHA, intCl1,1);
  End;
end;

function fCrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
	Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1), STR_CHAR_SENHA);
    Result := Result + MidStr(STR_CHAR_TROCA,intCl1,1);
  End;
end;

function fEncriptar(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
	Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1), STR_CHAR_CRYPT );
    Result := Result + MidStr('™∫´¡¬√ƒ©∆«»… ÀÃÕŒœ—“”‘’÷ÿŸëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å›ﬂ∂Æ≈~£§ß¿≤≥¢',intCl1,1);
  End;
end;

function fDecriptar(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
  Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1),'™∫´¡¬√ƒ©∆«»… ÀÃÕŒœ—“”‘’÷ÿŸëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å›ﬂ∂Æ≈~£§ß¿≤≥¢');
    Result := Result + MidStr(STR_CHAR_CRYPT, intCl1,1);
  End;
end;

function fConteudoEncriptado(ATexto: String): Boolean;
begin
  Result := (fEncriptar(fDecriptar(ATexto)) = ATexto);
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

function fEhNumero(Chr: Char): Boolean;
begin
  {$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)}
    Result := CharInSet(Chr, ['0'..'9']);
  {$ELSE}
    Result := Chr In ['0'..'9'];
  {$IFEND}
end;

{*****************************************}
{* RETORNA SOMENTE NUMEROS EM UMA STRING *}
{***************************************FC}
function fRetSomenteNumeros(strTexto: String): String;
  Var
    strTmp: String;
    intIndice: Integer;
begin
  strTmp := '';

  If Not fEmptyStr(strTexto) Then
  Begin
    For intIndice := 1 To Length(strTexto) Do
    Begin
      If fEhNumero(strTexto[intIndice]) Then
        strTmp := strTmp + strTexto[intIndice];
    End;
  End;

  Result := strTmp;
end;

function fExisteNumeros(strTexto: String): Boolean;
Var
  intIndice: Integer;
begin
  Result := False;

  If fEmptyStr(strTexto) Then
    Exit;

  For intIndice := 1 To Length(strTexto) Do
  Begin
    If fEhNumero(strTexto[intIndice]) Then
    Begin
      Result := True;
      Break;
    End;
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

procedure pCarregaVerificadorVersaoNFe(strCnpj: String; blnOffLine: Boolean=False; strModeEnvSoap: String = '');
begin
  If (Not fEmptyStr(objConfig.strFitLicenca)) And
     (AnsiEndsText('_CITEL', objConfig.strFitLicenca)) Then
  Begin
    If Not Assigned(VS_objVerificaIntegrador) Then
      VS_objVerificaIntegrador := TVerificaIntradorNFe.Create(strCnpj, blnOffLine, strModeEnvSoap);
  End;
end;

function fVersao310(fonteDados: IFonteDados; strModelo: String; strIntegradorCitel: String = 'N'): Boolean;
  Const
    cnstFunc = 'fVersao310 ';
  Var
    strCodCfgVERNFE: String;
    strValCfgVERNFE: String;

  function fBuscaNaFit: String;
  begin
    Result := VS_objVerificaIntegrador.fVersao(strModelo);
  end;

begin
  Result := True;

  If (strIntegradorCitel = 'S') Then
    Exit;

  If Assigned(VS_objVerificaIntegrador) Then
  Begin
    Try
      Try
        strCodCfgVERNFE := IIF(strModelo = '55', 'VERNFE', 'VERNFC');

        If (VS_objVerificaIntegrador.fModeEnvSoapIsOpenSSL) Then
        Begin
          //Se modo de envio È via OpenSSL SEMPRE dever ir via fBuscaNaFit para que uma inst‚ncia da libeay32.dll E ssleay32.dll fique presa na memÛria :(
          strValCfgVERNFE := fBuscaNaFit;
          pLogImp(cnstFunc + '> fBuscaNaFit = '+strValCfgVERNFE);
        End
        Else
        Begin
          strValCfgVERNFE := fCfgSisFonte(fonteDados, strCodCfgVERNFE);

          If fEmptyStr(strValCfgVERNFE) Then
          Begin
            pLogImp(cnstFunc + '> NAO EXISTE A CFG_'+strCodCfgVERNFE+'. COGITE CRI¡-LA MESMO QUE SE FOR S” NO BANCO. PARA N√O PRECISAR BUSCAR NA FIT!');

            strValCfgVERNFE := fBuscaNaFit;
            pLogImp(cnstFunc + '> fBuscaNaFit = '+strValCfgVERNFE);
          End
          Else
          Begin
            pLogImp(cnstFunc + '> CFG_'+strCodCfgVERNFE+' = '+strValCfgVERNFE);
          End;
        End;
      Except
        strValCfgVERNFE := fBuscaNaFit;
        pLogImp(cnstFunc + '(Except) > fBuscaNaFit = '+strValCfgVERNFE);
      End;
    Finally
      Result := (Pos(strValCfgVERNFE, '3.10_4.00_') > 0);
      pLogImp(cnstFunc + '< Result = '+fBooleanToString(Result));
    End;
  End;
end;

function fRetornaCSTSimplesUtil(dadosEmitente: TDadosEmitente;
  dadosGerais: TDadosGerais; dadosItem: TDadosItem; blnIteSer: Boolean): String;
  Var
    strCodSitTmp: String;
    strCstSimSubs: String;
    strCSOSNSubs: String;
begin
  If blnIteSer Then
  Begin
    Result := '';
    Exit;
  End;

  If Not fSimplesPaulista(dadosGerais, dadosEmitente, False) Then
  Begin
    Result := '';
    Exit;
  End;

  strCstSimSubs := fGetCSTSimplesSub(dadosGerais,dadosEmitente, dadosItem);
  strCSOSNSubs  := fGetCSOSNSubstituicao(dadosGerais, dadosEmitente);

  strCodSitTmp := RightStr(dadosItem.strCodSit, 2);

  Result := '900';

  If (LeftStr(dadosGerais.strClaFis, 1) = '7') Then
  Begin
    Result := '300';
  End
  Else If (LeftStr(dadosGerais.strClaFis, 1) = '3') Then
  Begin
    Result := '900';
  End

  Else If (Pos(RightStr(dadosGerais.strClaFis, 3), CLASS_FISCAL_TRANSFER) > 0) And (LeftStr(dadosGerais.strClafis, 1) <= '5') Then
  Begin
    Result := '400';
  End

  Else If strCodSitTmp = '00' Then
  Begin
    If (objConfig.strCstSimTrib = '103') Then
    Begin
      Result := '103'
    End
    Else
    Begin
      If (dadosGerais.strEspDoc = 'IF') Or
         (fEmptyStr(objConfig.strCstSimTrib)) Or
         (StrToIntDef(objConfig.strCstSimTrib, 102) = 102) Then
      Begin
        Result := '102'
      End
      Else
        Result := '101';
    End;
  End

  Else If (dadosItem.fltValRet > 0) And (dadosGerais.strZonFra = 'S') Then
    Result := '203'

  Else If Pos(strCodSitTmp, '40_50') > 0 Then
    Result := '103'

  Else If Pos(strCodSitTmp, '10_30_60_70') > 0 Then
  Begin
    If (Not fEmptyStr(strCSOSNSubs)) And (objConfig.strAPCSOS = 'S') Then
      Result := strCSOSNSubs
    Else If (strCodSitTmp = '30') Then
      Result := '103'
    Else If Not fEmptyStr(strCstSimSubs) Then
    Begin
      If StrToIntDef(strCstSimSubs, 202) = 201 Then
        Result := '201'
      Else If StrToIntDef(strCstSimSubs, 202) = 202 Then
        Result := '202'
      Else
        Result := '500';
    End
    Else
      Result := '202';
  End

  Else If Pos(strCodSitTmp, '41_51') > 0 Then
  Begin
    If (objConfig.strCstSimTrib = '103') Then
      Result := '103'
    Else
      Result := '400'
  End

  Else If strCodSitTmp = '90' Then
  Begin
    Result := '900';

    If (RightStr(dadosItem.strClaFis, 3) = '929') And // Confirmacao de Cupom
       ((objConfig.strCstSimTribCI) = '101')      Then
    Begin
      Result := '101';
    End;

  End;

end;

function fItemServico(item: TDadosItem): Boolean;
begin
  Result := Pos(item.strClaFis, '5933_6933_1933_2933_') > 0;
end;

function fDecodeBase64(strBase64: String): String;
var
  streamEntrada: TStringStream;
  streamSaida: TStringStream;
begin
  Result := '';

  strBase64 := AnsiReplaceStr(AnsiReplaceStr(strBase64, #13, ''), #10, '');

  streamEntrada := TStringStream.Create(strBase64);
  try
    streamSaida := TStringStream.Create('');
    try
      streamEntrada.Position := 0;

      LbDecodeBase64(streamEntrada, streamSaida);

      Result := streamSaida.DataString;
    finally
      streamSaida.Free;
    end;
  finally
    streamEntrada.Free;
  end;
end;

function fEncodeBase64(strTexto: String): String;
var
  streamEntrada: TStringStream;
  streamSaida: TStringStream;
begin
  Result := '';

  strTexto := AnsiReplaceStr(AnsiReplaceStr(strTexto, #13, ''), #10, '');

  streamEntrada := TStringStream.Create(strTexto);
  try
    streamSaida := TStringStream.Create('');
    try
      streamEntrada.Position := 0;

      LbEncodeBase64(streamEntrada, streamSaida);

      Result := streamSaida.DataString;
    finally
      streamSaida.Free;
    end;
  finally
    streamEntrada.Free;
  end;
end;

function fNumDocEnvio(strNumDoc: String): String;
begin
  Result := RightStr(strNumDoc, 9);
end;

function fRetornaVersao(strNomArq: String = ''): String;
{$IFDEF LINUX}
begin
  raise Exception.Create('fRetornaVersao ainda n„o possui implementaÁ„o linux');
end;
{$ELSE}
  Var
    BufferSize, Len: Integer;
    Buffer : PChar;
    Translate, Return: Pointer;
    LoCharSet, HiCharSet : Word;
    Dummy: Cardinal;
    StrFileInfo: String;
begin
  Result := '';

  If (fEmptyStr(strNomArq)) Then
  Begin
    strNomArq := Application.ExeName;
  End;

  If (Not FileExists(strNomArq)) Then
    Exit;

  BufferSize := GetFileVersionInfoSize({$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280)}PWideChar{$ELSE}PChar{$IFEND}(strNomArq), Dummy);

  If BufferSize <> 0 Then
  Begin
    GetMem(Buffer, Succ(BufferSize));
    Try
      If GetFileVersionInfo(PChar(strNomArq), 0, BufferSize,Buffer) Then
      Begin
        If VerQueryValue(Buffer, PATH_SEPARATOR + 'VarFileInfo'+ PATH_SEPARATOR + 'Translation', Translate, UINT(Len)) Then
        Begin
          LoCharSet := LoWord(Longint(Translate^));
          HiCharSet := HiWord(Longint(Translate^));
          StrFileInfo := Format(PATH_SEPARATOR + 'StringFileInfo'+ PATH_SEPARATOR + '0%x0%x' + PATH_SEPARATOR + '%s',[LoCharSet, HiCharSet, 'FileVersion']);
          If VerQueryValue(Buffer,PChar(StrFileInfo), Return, UINT(Len)) Then
          Begin
            Result := PChar(Return);
          End;
        End;
      End;
    Finally
      FreeMem(Buffer, Succ(BufferSize));
    End;
  End;
end;
{$ENDIF}

function fGanhouNetpoints(fonteDados: IFonteDados; var intQtdNps: Integer): Boolean;
  Var
    dtaDataSet : TDataSet;
begin
  intQtdNps := 0;

  If (fSuportaOperacaoBanco(fonteDados)) And
     (fonteDados.fTabelaExiste('CADNPS')) And
     (fCfgSisFonte(fonteDados, 'UTINPS') = 'S') Then
  Begin
    Try
      Try
        dtaDataSet := fonteDados.fExecutaQuery(' SELECT NPS_NPSCAL, NPS_QTDNPS ' +
                                               '   FROM CADNPS ' +
                                               '  WHERE NPS_NUMDOC = :NUMDOC ' +
                                               '    AND NPS_ESPDOC = :ESPDOC ' +
                                               '    AND NPS_CODEMP = :CODEMP ' +
                                               '    AND NPS_CODCLI = :CODCLI ' +
                                               '    AND NPS_SERIE_ = :SERIE_ ',
           ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI', 'SERIE_'],
           [fonteDados.fDadosGerais.strNumDoc,
            fonteDados.fDadosGerais.strEspDoc,
            fonteDados.fDadosGerais.strCodEmp,
            fonteDados.fDadosGerais.strCodCli,
            fonteDados.fDadosGerais.strSerie]);

        With dtaDataSet Do
        Begin
          If (Not IsEmpty) Then
          Begin
            intQtdNps := FieldByName('NPS_QTDNPS').AsInteger;
            If (intQtdNps <= 0) Then
              intQtdNps := FieldByName('NPS_NPSCAL').AsInteger;
          End;
        End;
      Except
        On E: Exception Do
        Begin
          intQtdNps := 0;
        End;
      End;
    Finally
      If Assigned(dtaDataSet) Then
        FreeAndNil(dtaDataSet);
    End;
  End;

  Result := (intQtdNps > 0);
end;

function fNfeInfAdicQtdeSelos(fonteDados: IFonteDados; var intQtdeSelos: Integer): Boolean;
  Var
    dtaDataSet : TDataSet;
    dtaPDFaturado : TDataSet;
begin

  dtaDataSet    := nil;
  dtaPDFaturado := nil;
  intQtdeSelos := 0;

  If (fSuportaOperacaoBanco(fonteDados)) And
     (fonteDados.fTabelaExiste('CPPGER')) And
     (fCfgSisFonte(fonteDados, 'UTICPP') = 'S') Then
  Begin
    Try
      Try

        dtaDataSet := fonteDados.fExecutaQuery(' SELECT                      '+
                                               '   COUNT(*) AS QTDESELOS     '+
                                               ' FROM                        '+
                                               '   CPPGER                    '+
                                               ' WHERE CPG_NUMDOC = :NUMDOC  '+
                                               '   AND CPG_ESPDOC = :ESPDOC  '+
                                               '   AND CPG_CODEMP = :CODEMP  '+
                                               '   AND CPG_CODCLI = :CODCLI  ',
          ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
          [fonteDados.fDadosGerais.strNumDoc,
           fonteDados.fDadosGerais.strEspDoc,
           fonteDados.fDadosGerais.strCodEmp,
           fonteDados.fDadosGerais.strCodCli]);

        If (dtaDataSet.FieldByName('QTDESELOS').AsInteger > 0) Then
          intQtdeSelos := dtaDataSet.FieldByName('QTDESELOS').AsInteger
        Else
        begin
          If (dtaDataSet.FieldByName('QTDESELOS').AsInteger = 0) Then
          begin

            If Assigned(dtaDataSet) Then
              FreeAndNil(dtaDataSet);

            dtaPDFaturado := fonteDados.fExecutaQuery(' SELECT DISTINCT                                  '+
                                                      '   DET_NUM_PD, DET_EMP_PD, DET_ESP_PD, DET_CODCLI '+
                                                      ' FROM                                             '+
                                                      '   MOVDET                                         '+
                                                      ' WHERE DET_NUMDOC = :NUMDOC                       '+
                                                      '   AND DET_ESPDOC = :ESPDOC                       '+
                                                      '   AND DET_CODEMP = :CODEMP                       '+
                                                      '   AND DET_CODCLI = :CODCLI                       ',
              ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
              [fonteDados.fDadosGerais.strNumDoc,
               fonteDados.fDadosGerais.strEspDoc,
               fonteDados.fDadosGerais.strCodEmp,
               fonteDados.fDadosGerais.strCodCli]);

            While Not dtaPDFaturado.Eof do
            begin
              dtaDataSet := fonteDados.fExecutaQuery(' SELECT                      '+
                                                     '   COUNT(*) AS QTDESELOS     '+
                                                     ' FROM                        '+
                                                     '   CPPGER                    '+
                                                     ' WHERE CPG_NUMDOC = :NUMDOC  '+
                                                     '   AND CPG_ESPDOC = :ESPDOC  '+
                                                     '   AND CPG_CODEMP = :CODEMP  '+
                                                     '   AND CPG_CODCLI = :CODCLI  ',
              ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI'],
              [dtaPDFaturado.FieldByName('DET_NUM_PD').asString,
               dtaPDFaturado.FieldByName('DET_ESP_PD').asString,
               dtaPDFaturado.FieldByName('DET_EMP_PD').asString,
               dtaPDFaturado.FieldByName('DET_CODCLI').asString]);
              try
                If (dtaDataSet.FieldByName('QTDESELOS').AsInteger > 0) Then
                  intQtdeSelos := intQtdeSelos + dtaDataSet.FieldByName('QTDESELOS').AsInteger;
              finally 
                FreeAndNil(dtaDataSet);
              end;
              dtaPDFaturado.Next;
            end;
          end;
        end;
      Except
        On E: Exception Do
        Begin
          intQtdeSelos := 0;
          raise;
        End;
      End;
    Finally
      If Assigned(dtaDataSet) Then
        FreeAndNil(dtaDataSet);
      If Assigned(dtaPDFaturado) Then
        FreeAndNil(dtaPDFaturado);
    End;
  End;

  Result := (intQtdeSelos > 0);
end;


procedure pConfiguraOpcoesRegionais;
{$IFDEF LINUX}
begin
  raise Exception.Create('pConfiguraOpcoesRegionais ainda n„o possui implementaÁ„o linux');
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
{$ENDIF}

{******************************************}
{* FORMATA UM NUMERO COM X CASAS DECIMAIS *}
{***************************************MV*}
function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  Var
    intDig: Integer;
    strVal: String;
begin
  strVal := FloatToStr(fltNumero);

  {*******************************}
  {* SE O VALOR POSSUIR DECIMAIS *}
  {****************************JC*}
  If Pos({$IF Defined(VER250) Or Defined(UNIDAC))} FormatSettings.DecimalSeparator{$ELSE}
  DecimalSeparator{$IFEND}, strVal) > 0 Then
  Begin
    intDig := Length(strVal) - Pos({$IF Defined(VER250) Or Defined(UNIDAC)}FormatSettings.DecimalSeparator{$ELSE}
  DecimalSeparator{$IFEND}, strVal);

    {*********************************************************************************}
    {* SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA *}
    {******************************************************************************JC*}
    If (intDig > 0) And (intDig > intDecimais) And (strVal[Length(strVal)] = '5') Then
    Begin
      strVal[Length(strVal)] := '6';
    End;
  End;

  {************************************************************}
  {* CONTINUA FORMATANDO IGUAL ERA COM A FUNCAO fFormataFloat *}
  {*********************************************************JC*}
  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDecimais));
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

function fBarraNoFinal(strPath: String) : String;
  Var
    strTmp : String;
Begin
  strTmp := strPath;
  If Not (strTmp[Length(strTmp)] = PATH_SEPARATOR) Then
    Result := strTmp + PATH_SEPARATOR
  Else
    Result := strTmp;
End;

procedure pFindFiles(const strFileMask: String ; stlStringList: TStrings; blnIncludePath : Boolean = True);
  Var
    SearchRec : TSearchRec;
    intRetFind : Integer;
    strLastFile : String;
    strPath : String ;
begin
  strLastFile := '';
  strPath := ExtractFilePath(strFileMask);
  intRetFind := SysUtils.FindFirst(strFileMask, faAnyFile, SearchRec);
  stlStringList.Clear;
  Try
    While (intRetFind = 0) and (strLastFile <> SearchRec.Name) do
    Begin
      strLastFile := SearchRec.Name;
      If Pos(strLastFile, '..') = 0 Then
      Begin
        If (blnIncludePath) Then
          stlStringList.Add( strPath + strLastFile )
        Else
          stlStringList.Add(strLastFile);
      End;
      SysUtils.FindNext(SearchRec);
    End;
  Finally
    SysUtils.FindClose(SearchRec);
  End;
end;

function fFloatToStrVirgula(valor: double; inte,deci: integer): string;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte,deci),'.',',');
end;

function fAjustaComando(strComando: String): String;
begin
  strComando := fChangeLineBreak(strComando,'');

  while pos('  ', strComando) > 0 do
    strComando := StringReplace(strComando, '  ', ' ', [rfReplaceAll]);

  strComando := StringReplace(strComando, '> <', '><', [rfReplaceAll]);
  Result := strComando;
end;

function fChangeLineBreak(const strText: String; strNewLineBreak: String = ';'): String;
  Const
    LF  = #10 ;
    CR  = #13 ;
begin
  Result := strText;
  if Trim(Result) <> '' then
  begin
    if sLineBreak <> LF then
      Result := StringReplace(Result, sLineBreak, LF, [rfReplaceAll]);

    if strNewLineBreak <> LF then
      Result := StringReplace(Result, LF, strNewLineBreak, [rfReplaceAll]);

    if strNewLineBreak <> CR then
      Result := StringReplace(Result, CR, strNewLineBreak, [rfReplaceAll]);
  end
end;

function fXmlEhUTF8(const strXML: String): Boolean;
begin
  Result := (pos('encoding="utf-8"', LowerCase(LeftStr(strXML, 50))) > 0);
end;

function fConverteXMLtoUTF8(const strXML: String): String;
  Var
    UTF8Str: AnsiString;
begin
  If Not fXmlEhUTF8(strXML) Then
  Begin
    UTF8Str := fNativeStringToUTF8(strXML);
    Result := '<?xml version="1.0" encoding="UTF-8"?>' + String(UTF8Str);
  End
  Else
    Result := strXML;
end;

function fNativeStringToUTF8( strString : String ) : AnsiString;
{$IF Defined(VER250) Or Defined(UNIDAC)}
  Var
    RBS: RawByteString;
{$IFEND}
begin
  {$IF Defined(VER250) Or Defined(UNIDAC)}
  RBS := UTF8Encode(strString);
  SetCodePage(RBS, 0, False);
  Result := AnsiString(RBS);
  {$ELSE}
  Result := UTF8Encode(strString);
  {$IFEND}
end;

{***************************************}
{* REMOVE ACENTOS DE UMA STRING        *}
{************************************DV*}
function fRemoveAcento(Str:String): String;
	Const
		ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

function fPrefixoValido(fonteDados: IFonteDados; strPrefixo: String): Boolean;
  Var
    dataSet: TDataSet;
begin
  Result := False;
  If (fSuportaOperacaoBanco(fonteDados)) And
     (fonteDados.fTabelaExiste('PREGS1')) Then
  Begin
    dataSet := fonteDados.fExecutaQuery('SELECT COUNT(*) CNT FROM PREGS1 WHERE :PREFIX BETWEEN GS1_PREINI AND GS1_PREFIN',
      ['PREFIX'], [strPrefixo]);
    Result := (dataSet.FieldByName('CNT').AsInteger > 0);
    FreeAndNil(dataSet);
  End;
end;

function fValidaGTIN(strGTIN: string): Boolean;
  Var
    intCnt, intSoma, intResultado, intBase10: Integer;
begin
  //Verifica se todos os caracteres de strGTIN s„o n˙meros
  for intCnt:= 1 to Length(strGTIN) do
  begin
    if not {$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)}(CharInSet(strGTIN[intCnt], ['0'..'9'])){$ELSE}(strGTIN[intCnt] in ['0'..'9']){$IFEND} Then
    begin
      Result:= False;
      Exit;
    end;
  end;
  //Verifica se strGTIN tem o tamanho necess·rio
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
    //Verifica se intBase10 È m˙ltiplo de 10
    if not (intBase10 mod 10 = 0) then
    begin
      while not (intBase10 mod 10 = 0) do
      begin
        intBase10:= intBase10 + 1;
      end;
    end;
    intResultado:= intBase10 - intSoma;
    //Verifica se o intResultado encontrado È igual ao caractere de controle
    if intResultado = strtoint(strGTIN[Length(strGTIN)]) then
      Result:= True
    else
      Result:= False;
  end
  else
    Result:= False;
end;

function fPathOpcoesIni: String;
  Var
    strPath : String;
begin
  Result := '';

  If FileExists(ExtractFilePath(Application.ExeName) + 'opcoes.ini') Then
    Result := ExtractFilePath(Application.ExeName) + 'opcoes.ini'
  Else If FileExists(ExtractFilePath(Application.ExeName) + 'opcoespainel.ini') Then
  Begin
    strPath := Trim(fArqIniLocal(0, 'GERAL', 'PATATC', '', ExtractFilePath(Application.ExeName) + 'opcoespainel.ini'));

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

procedure pLog(const strValor: String);
begin
  untDicSis.pLog(strValor);
end;

procedure pLogEnotas(const strValor: String);
begin
  untDicSis.pLogEnotas(strValor);
end;

procedure pLogImp(const strValor: String);
begin
  untDicSis.pLogImp(strValor);
end;

function KillProcess(pid: cardinal): Boolean;
{$IFDEF LINUX}
begin
  raise Exception.Create('KillProcess ainda n„o possui implementaÁ„o linux');
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
{$ENDIF}

function ShellExecuteAndWait(Operation, FileName, Parameter, Directory: String; Show: Word; bWait: Boolean): Longint;
{$IFDEF LINUX}
begin
  raise Exception.Create('ShellExecuteAndWait ainda n„o possui implementaÁ„o linux');
end;
{$ELSE}
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
{$ENDIF}

function fRegimeTributarioEmitente(strSimPau, strSimBru: string): string;
  const
    _SIMPLES_NACIONAL : String = '1';
    _SIMPLES_NACIONAL_EXCESSO_SUBLIMITE_RECEITA_BRUTA : String = '2';
    _REGIME_NORMAL : String = '3';
begin
  if (strSimBru = 'S') then
    Result := _SIMPLES_NACIONAL_EXCESSO_SUBLIMITE_RECEITA_BRUTA
  else if (strSimPau = 'S') then
    Result := _SIMPLES_NACIONAL
  else
    Result := _REGIME_NORMAL;
end;

function fGetTipoAbreviacao(dadosGerais: TDadosGerais): String;
Begin
  Result := AnsiReplaceStr(AnsiReplaceStr(DadosGerais.strPerfil,'_ENT_',''),'_SAI_','');
End;

function fCfgRegimeSubstituicaoTributaria(fonteDados: IFonteDados; const strOpcDoc : String) : String;
begin
  If (Pos(strOpcDoc, '_NG_OF_GF_') > 0) And (fConfiguracaoExisteFonte(fonteDados, 'CLASUF')) Then
    Result := 'CLASUF'
  Else
    Result := 'CLASUB';
end;

function fRegimeSubstituicaoTributaria(fonteDados: IFonteDados; const strOpcDoc : String) : String;
begin
  Result := fCfgSisFonte(fonteDados, fCfgRegimeSubstituicaoTributaria(fonteDados, strOpcDoc));
end;

function fCalcBeneficioReducaoBase(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente): Boolean;
Begin
  If (fCfgSisFonte(fonteDados, 'BEN_ST') = 'S') And (fRegimeSubstituicaoTributaria(fonteDados, dadosGerais.strOpcDoc) = '2') And (dadosGerais.strEstado = dadosEmitente.strEstado) Then
    Result := True
  Else
    Result := False ;
end;

function fCalculaFCPComReducaoBaseIcmsST(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente): Boolean;
Begin
  If (fCfgSisFonte(fonteDados, 'BBSFCP') = '2') And (fRegimeSubstituicaoTributaria(fonteDados, dadosGerais.strOpcDoc) = '2') And (dadosGerais.strEstado = dadosEmitente.strEstado) Then
    Result := True
  Else
    Result := False ;
end;

function fAliquotaIcmsUF(fonteDados: IFonteDados; strUF: String): Double;
  Var
    dataSet: TDataSet;
begin
  Result := 0;
  If (fSuportaOperacaoBanco(fonteDados)) And
     (fonteDados.fTabelaExiste('CADUFS')) Then
  Begin
    dataSet := fonteDados.fExecutaQuery('SELECT UFS_ALQICM FROM CADUFS WHERE UFS_ESTADO = :ESTADO', ['ESTADO'], [strUF]);
    Result := dataSet.FieldByName('UFS_ALQICM').AsFloat;
    FreeAndNil(dataSet);
  End;
end;

function fBuscaAliquotaDeIcmsDaOperacaoPropria(fonteDados: IFonteDados; strCodIte, strCodAbf, strEstado, strPerfil, strCodEmp: string): double;
  Var
    dataSet: TDataSet;
    dataSetItem : TDataSet;
    strSQL : string;
    strCampoAbreviacao : string;
    strCstOri : string;
begin
  Result := 0;

  if fEmptyStr(strCodAbf) then
    exit;

  if fEmptyStr(strEstado) then
    exit;

  if fEmptyStr(strPerfil) then
    exit;

  strCampoAbreviacao := 'ABF_ALQICM' + strPerfil;

  if not fonteDados.fCampoExiste('ABFICM', strCampoAbreviacao) then
    exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT ' + strCampoAbreviacao;
  strSQL := strSQL + '   FROM ABFICM ';
  strSQL := strSQL + '  WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO ';

  if (fonteDados.fCampoExiste('ABFICM', 'ABF_CSTORI')) and (not fEmptyStr(strCodIte)) Then
  begin
    if (fCfgSisFonte(fonteDados, 'TIPABF') = '1') then
      dataSetItem := fonteDados.fExecutaQuery('SELECT ITE_CSTORI FROM CADITE WHERE ITE_CODITE = :CODITE', ['CODITE'], [strCodIte])
    else
      dataSetItem := fonteDados.fExecutaQuery('SELECT ITE_CSTORI FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP', ['CODITE', 'CODEMP'], [strCodIte, strCodEmp]);

    strCstOri := dataSetItem.FieldByName('ITE_CSTORI').AsString;

    if not fEmptyStr(strCstOri) then
      strSQL := strSQL + '  AND ABF_CSTORI = "' + strCstOri + '" ';

    FreeAndNil(dataSetItem);
  end;

  dataSet := fonteDados.fExecutaQuery(strSQL, ['CODABF', 'ESTADO'], [strCodAbf, strEstado]);

  Result := dataSet.FieldByName(strCampoAbreviacao).AsFloat;

  FreeAndNil(dataSet);
end;

function fRetornaEstadosQueCalculamFcpStDentro_e_ForaDoEstado(fonteDados: IFonteDados): String;
Begin
  If fConfiguracaoExisteFonte(fonteDados, 'UFSFCP') Then
  Begin
    Result := fTransform(fCfgSisFonte(fonteDados, 'UFSFCP'), 2);
  End
  Else
  Begin
    Result := 'RJ_';
  End;
End;

function fProdutoIndustrializadoDentroDoEstado(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente; dadosItem: TDadosItem): Boolean;
var
  blnEmpRJ:  Boolean;
  blnProInd: Boolean;
  blnConIPI: Boolean;
  blnDentroDoEstado: Boolean;

begin
  blnEmpRJ          := (Pos(dadosEmitente.strEstado, fRetornaEstadosQueCalculamFcpStDentro_e_ForaDoEstado(fonteDados)) > 0);
  blnConIPI         := (fCfgSisFonte(fonteDados, 'CONIPI') = 'S');
  blnProInd         := (dadosItem.strIndRev = 'I');
  blnDentroDoEstado := (dadosGerais.strEstado = dadosEmitente.strEstado);

  Result := (blnEmpRJ And blnConIPI And blnProInd And blnDentroDoEstado);
end;

function fProdutoRevendaDentroDoEstado(fonteDados: IFonteDados; dadosGerais: TDadosGerais; dadosEmitente: TDadosEmitente; dadosItem: TDadosItem): Boolean;
var
  blnEmpRJ:  Boolean;
  blnImpDir: Boolean;
  blnProRev: Boolean;
  blnCfopPermitido: Boolean;
  blnDentroDoEstado: Boolean;

begin
  blnEmpRJ          := (Pos(dadosEmitente.strEstado, fRetornaEstadosQueCalculamFcpStDentro_e_ForaDoEstado(fonteDados)) > 0);
  blnImpDir         := IIF(fCfgSisFonte(fonteDados, 'IMPDIR') = 'S', IIF((dadosItem.strImpDir = 'S'), True, False), False);
  blnProRev         := IIF(fCfgSisFonte(fonteDados, 'CONIPI') = 'S', IIF((dadosItem.strIndRev = 'R'), True, False), True);
  blnCfopPermitido  := (Pos(dadosItem.strClaFis, '1411_5403_5409_5910_5949_') > 0);
  blnDentroDoEstado := (dadosGerais.strEstado = dadosEmitente.strEstado);

  Result := (blnEmpRJ And blnImpDir And blnProRev And blnCfopPermitido And blnDentroDoEstado);
end;

function fBuscaRegraModalidadeDeterminacaoBCST(fonteDados: IFonteDados; strCodSit: string; blnTemIva: boolean): string;
  var
    dataSet: TDataSet;
begin
  Result := '';

  if fEmptyStr(strCodSit) then
    exit;

  if not (fSuportaOperacaoBanco(fonteDados)) then
    exit;

  if not fonteDados.fTabelaExiste('MDBCST') then
    exit;

  dataSet := fonteDados.fExecutaQuery('SELECT CST_MDBCST FROM MDBCST WHERE CST_CODCST = :CODCST AND CST_TEMIVA = :TEMIVA', ['CODCST', 'TEMIVA'], [RightStr(strCodSit, 2), IIF(blnTemIva, 'S', 'N')]);
  Result := dataSet.FieldByName('CST_MDBCST').AsString;
  FreeAndNil(dataSet);
end;

function fCodigoBeneficioFiscal(fonteDados: IFonteDados; const strCodSit, strCodAbf, strPerfilAbreviacao, strClaFis: String): String;
var
  strUFBeneficio: String;
begin
  Result := '';

  If (Not fSuportaOperacaoBanco(fonteDados)) Then
    Exit;

  If (RightStr(strClaFis, 3) = '927') And (RightStr(strCodSit, 2) = '90') Then
    Exit;

  If (fonteDados.fDadosGerais.blnVenPre) Then
    strUFBeneficio := fonteDados.fDadosEmitente.strEstado
  Else
    strUFBeneficio := fonteDados.fDadosGerais.strEstado;

  Result := fBuscaBeneficioFiscalDaAbreviacao(fonteDados, strUFBeneficio, strCodAbf, strPerfilAbreviacao, strCodSit);
end;

function fBuscaBeneficioFiscalDaAbreviacao(fonteDados: IFonteDados; const strEstado, strCodAbf, strPerfilAbreviacao, strCodSit: String): String;
  Var
    strSQL: string;
    strCampoBeneficio : String;
    strCampoCodSit : String;
    dataSet: TDataSet;
begin
  Result := '';

  If (Not fSuportaOperacaoBanco(fonteDados)) then
    Exit;

  If (Not fonteDados.fTabelaExiste('ABFICM')) Then
    Exit;

  If (fEmptyStr(strPerfilAbreviacao)) Then
    Exit;

  strCampoCodSit := 'ABF_CODSIT' + strPerfilAbreviacao;
  strCampoBeneficio := 'ABF_CODBEN' + strPerfilAbreviacao;

  If (Not fonteDados.fCampoExiste('ABFICM', strCampoCodSit)) Then
    Exit;

  If (Not fonteDados.fCampoExiste('ABFICM', strCampoBeneficio)) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT ' + strCampoCodSit+','+strCampoBeneficio;
  strSQL := strSQL + '   FROM ABFICM ' ;
  strSQL := strSQL + '  WHERE ABF_CODABF = :CODABF ';
  strSQL := strSQL + '    AND ABF_ESTADO = :ESTADO ';
  strSQL := strSQL + '    AND '+strCampoCodSit+' = :CODSIT ';

  dataSet := fonteDados.fExecutaQuery(strSQL, ['CODABF', 'ESTADO', 'CODSIT'], [strCodAbf, strEstado, strCodSit]);
  Try
    If (Not dataSet.IsEmpty) Then
      Result := dataSet.FieldByName(strCampoBeneficio).AsString;
  Finally
    FreeAndNil(dataSet);
  End;
end;

function fBuscaBeneficioFiscalDaTabelaDefault(fonteDados: IFonteDados; strCodSit, strUFEmit: string): string;
  var
    dataSet: TDataSet;
begin
  Result := '';

  if not (fSuportaOperacaoBanco(fonteDados)) then
    exit;

  if not fonteDados.fTabelaExiste('BEFCST') then
    exit;

  if fonteDados.fCampoExiste('BEFCST', 'CST_UFEMIT') then
    dataSet := fonteDados.fExecutaQuery('SELECT CST_CODBEN FROM BEFCST WHERE CST_CODCST = :CODCST AND CST_UFEMIT = :UFEMIT', ['CODCST', 'UFEMIT'], [RightStr(strCodSit, 2), strUFEmit])
  else
    dataSet := fonteDados.fExecutaQuery('SELECT CST_CODBEN FROM BEFCST WHERE CST_CODCST = :CODCST', ['CODCST'], [RightStr(strCodSit, 2)]);

  Result := dataSet.FieldByName('CST_CODBEN').AsString;
  FreeAndNil(dataSet);
end;

function fCodigoAbreviacaoProduto(fonteDados: IFonteDados; const strCodIte: String): String;
  Var
    dataSet: TDataSet;
begin
  Result := '';
  If fCfgSisFonte(fonteDados, 'TIPABF') = '1' Then
  Begin
    dataSet := fonteDados.fExecutaQuery('SELECT ITE_CODABF FROM CADITE WHERE ITE_CODITE = :CODITE', ['CODITE'], [strCodIte]);
    Try
      If (Not dataSet.IsEmpty) Then
        Result := dataSet.FieldByName('ITE_CODABF').AsString;
    Finally
      FreeAndNil(dataSet);
    End;
  End
  Else
  Begin
    dataSet := fonteDados.fExecutaQuery('SELECT ITE_CODABF FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP', ['CODITE', 'CODEMP'], [strCodIte, fonteDados.fDadosGerais.strCodEmp]);
    Try
      If (Not dataSet.IsEmpty) Then
        Result := dataSet.FieldByName('ITE_CODABF').AsString;
    Finally
      FreeAndNil(dataSet);
    End;
  End;
end;

function fRetornaFilaImpressaoNFCe(fonteDados: IFonteDados): String;
  Var
    dataSet: TDataSet;
begin
  Result := '';
  If (not fSuportaOperacaoBanco(fonteDados)) Or  (not fonteDados.fTabelaExiste('FILNFC')) Then
  Begin
    Exit;
  End;

  Try
    dataSet := fonteDados.fExecutaQuery('SELECT FIL_NOMIMP FROM FILNFC WHERE NOT TRIM(FIL_NOMIMP) AND FIL_CODEMP = :CODEMP',
                                        ['CODEMP'], [fonteDados.fDadosGerais.strCodEmp]);
    Result := dataSet.FieldByName('FIL_NOMIMP').AsString;
  Finally
    FreeAndNil(dataSet);
  End;

End;

function GetComputerNetName: string;
{$IFDEF LINUX}
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
{$ENDIF}

function GetUserFromWindows: string;
{$IFDEF LINUX}
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
{$ENDIF}

function GetIPAddress: Integer;
{$IFDEF LINUX}
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
{$ENDIF}

function GetIPAddressAsString: string;
{$IFDEF LINUX}
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
{$ENDIF}

function GetMacAddress: string;
{$IFDEF LINUX}
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
{$ENDIF}

function GetParamValue(AParamID: String): String;
Var
  I: Integer;
begin
  Result := '';
  for I := 1 to ParamCount do
    if StartsText(AParamID, ParamStr(I)) then
    begin
      Result := ParamStr(I);
      Result := ReplaceText(Result, AParamID, '');
      Break;
    end;
end;

function HasParam(AParamID: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if StartsText(AParamID, ParamStr(I)) then
    begin
      Result := True;    
      Exit;
    end;
end;

function fConfiguracaoExisteFonte(fonteDados: IFonteDados; strCodCfg: String): Boolean;
begin
  Result := False;

  If Not fSuportaOperacaoBanco(fonteDados) Then
  Begin
    Exit;
  End;

  Result :=  fonteDados.fConfiguracaoExiste(strCodCfg);
end;

function fRetNomePais(fonteDados: IFonteDados; strCodPai: String): String;
var
  dataSet: TDataSet;
begin
  Result := '';

  If (consCodIbgeBrasil = strCodPai) Then
  Begin
    Result := 'BRASIL';
    Exit;
  End;

  If Not fSuportaOperacaoBanco(fonteDados) Then
  Begin
    Exit;
  End;

  If Not fonteDados.fTabelaExiste('IBG_CADPAI') Then
  Begin
    Exit;
  End;

  dataSet := fonteDados.fExecutaQuery('SELECT IBG_NOMPAI FROM IBG_CADPAI WHERE IBG_CODPAI = :CODPAI', ['CODPAI'], [strCodPai]);

  Result := dataSet.FieldByName('IBG_NOMPAI').AsString;
  FreeAndNil(dataSet);
end;

function fUsaUniTri(strClaFis: String): Boolean;
begin
  Result := objConfigInterna.blnUniTri;
  if Result and (not fEmptyStr(objConfigInterna.strUTCFOP)) then
    Result := Pos(strClaFis, objConfigInterna.strUTCFOP) > 0;
end;

function fDocumentoEntregaFuturaClienteVaiRetirar(fonteDados: IFonteDados): Boolean;
  Var
    dataSet: TDataSet;
    strSQL : String;
begin
  Result := False;

  If (Not fSuportaOperacaoBanco(fonteDados)) Then
    Exit;

  If (fEmptyStr(fonteDados.fDadosGerais.strNumDoc)) Then
    Exit;

  If (Not fonteDados.fCampoExiste('MOVTRI', 'DET_CLIBUS')) then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS CNT ';
  strSQL := strSQL + '   FROM MOVDET D ';
  strSQL := strSQL + '   JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  strSQL := strSQL + '  WHERE DET_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '    AND DET_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '    AND DET_CODEMP = :CODEMP ';
  strSQL := strSQL + '    AND DET_CODCLI = :CODCLI ';
  strSQL := strSQL + '    AND DET_SERIE_ = :SERIE_ ';
  strSQL := strSQL + '    AND DET_TIP_FC = "C" ';
  strSQL := strSQL + '    AND DET_ORIDOC = "V" ';
  strSQL := strSQL + '    AND DET_ENTFUT = "S" ';
  strSQL := strSQL + '    AND DET_CLIBUS = "S" ';

  dataSet := fonteDados.fExecutaQuery(strSQL, ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI', 'SERIE_'],
    [fonteDados.fDadosGerais.strNumDoc, fonteDados.fDadosGerais.strEspDoc, fonteDados.fDadosGerais.strCodEmp,
    fonteDados.fDadosGerais.strCodCli, fonteDados.fDadosGerais.strSerie]);
  Try
    Result := (dataSet.FieldByName('CNT').AsInteger > 0);
  Finally
    FreeAndNil(dataSet);
  End;
End;

function fUtilizaPDFtoPrinter(fonteDados: IFonteDados): Boolean;
begin
  Result := (fCfgSisFonte(fonteDados, 'PDFPRT') = 'S');
end;

function fUtilizaPDFtoPrinterNoEnotas(fonteDados: IFonteDados): Boolean;
begin
  Result := (fCfgSisFonte(fonteDados, 'PDFENO') = 'S');
end;

function fSubstituirEnterPorEspaco(const strValor: String): String;
begin
  Result := AnsiReplaceStr(strValor, #13, ' ');
  Result := AnsiReplaceStr(Result, #10, ' ');
  Result := AnsiReplaceStr(Result, #13#10, ' ');
end;

procedure pCriarDiretorioDanfeEnotasCasoNaoExista;
begin
  If DirectoryExists(fDiretorioDanfeEnotas) Then
    Exit;

  ForceDirectories(fDiretorioDanfeEnotas);
end;

function fDiretorioDanfeEnotas: String;
begin
  Result := ExtractFileDir(fRetNomeArquivoPDFtoPrinter);

  If fEmptyStr(Result) Then
    Result := ExtractFilePath(Application.ExeName);

  Result := fSepDir(Trim(Result));
  Result := fSepDir(Result + 'DANFE');
end;

function fRetNomeArquivoPDFtoPrinter: String;
begin
  Result := 'c:' + PATH_SEPARATOR + 'NFEPRINTER' + PATH_SEPARATOR + 'PDFtoPrinter.exe';
  If Not FileExists(Result) Then
    Result := ExtractFilePath(Application.ExeName) + PATH_SEPARATOR + 'PDFtoPrinter.exe';
end;

function fArquivoEmUso(Const strNomeArqui: String): Boolean;
  Var
    StreamArquivo: TFileStream;
begin
  Result := False;
  If FileExists(strNomeArqui) Then
  Begin
    Try
      StreamArquivo := TFileStream.Create(strNomeArqui, fmShareExclusive And fmOpenRead);
      StreamArquivo.Free;
      Result := False;
    Except
      Result := True;
    End;
  End;
end;

function fBooleanToString(const blnValue: Boolean): String;
begin
  Result := 'S';

  If (blnValue) Then
    Exit;

  Result := 'N';
end;

procedure pSalvarTXTSemErro(const strTexto: String; const strNomeArquivo: String);
  var
    stlArquivo : TStringList;
begin
  stlArquivo := TStringList.Create;
  Try
    stlArquivo.Add(strTexto);
    Try
      stlArquivo.SaveToFile(fPnlDir('') + strNomeArquivo);
    Except

    End;
  Finally
    FreeAndNil(stlArquivo);
  End;
end;

function fEssaCidadeObrigaCodigoFormatado(fonteDados: IFonteDados; const strCodigoIBGE: String): Boolean;
Var
  dataSet: TDataSet;
begin
  Result := False;

  If (fSuportaOperacaoBanco(fonteDados)) And
     (fonteDados.fTabelaExiste('NSIBGE')) Then
  Begin
    dataSet := fonteDados.fExecutaQuery('SELECT COUNT(*) AS QTD FROM NSIBGE WHERE NSI_COIBGE = :COIBGE', ['COIBGE'], [strCodigoIBGE]);

    Try
      Result := (dataSet.FieldByName('QTD').AsInteger > 0);
    finally
      FreeAndNil(dataSet);
    End;

  End;
end;

function fPDFToPrinterQuantidadeDeCopias(fonteDados: IFonteDados): String;
var
  strCopias: String;
begin
  Result := ' copies=1';

  If not (fonteDados.fDadosGerais.strEspDoc = 'NS') Then
    Exit;

  strCopias := fCfgSisFonte(fonteDados, 'QTDNFS');

  Result := ' copies=' + IIF(fEmptyStr(strCopias), '1', strCopias);
end;

function fImpressoraLogSat(fonteDados: IFonteDados): String;
var
  LdtsImpressora : TDataSet;
begin
  Result := '' ;

  pLogImp('fImpressoraLogSat > ');

  if not fonteDados.fCampoExiste('LOGSAT', 'NFE_IMPRES') then
  begin
    pLogImp('fImpressoraLogSat < LOGSAT-NFE_IMPRES (N√O EXISTE)');

    exit;
  end;

  LdtsImpressora := fonteDados.fExecutaQuery('SELECT NFE_IMPRES FROM LOGSAT WHERE NFE_NUMDOC = :NUMDOC AND NFE_ESPDOC = :ESPDOC AND NFE_CODEMP = :CODEMP AND NFE_CODCLI = :CODCLI AND NFE_SERIE_ = :SERIE_ AND  NFE_TIP_FC = :TIP_FC',
                                             ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI', 'SERIE_', 'TIP_FC'],
                                             [fonteDados.fDadosGerais.strNumDoc, fonteDados.fDadosGerais.strEspDoc, fonteDados.fDadosGerais.strCodEmp, fonteDados.fDadosGerais.strCodCli, fonteDados.fDadosGerais.strSerie, fonteDados.fDadosGerais.strTip_FC]);
  try
    if not LdtsImpressora.IsEmpty then
      Result := LdtsImpressora.FieldByName('NFE_IMPRES').AsString ;
  finally
    FreeAndNil(LdtsImpressora);
  end;

  pLogImp('fImpressoraLogSat < ' + Result);
end;

function fImpressoraArqIni(fonteDados: IFonteDados; const AstrDiretorio: String): String;
begin
  pLogImp('fImpressoraArqIni(fonteDados, '+AstrDiretorio+') > ');

  Result := fArqIniLocal(0, 'SATCFE', 'IMPRESSORA', '', AstrDiretorio + PATH_SEPARATOR + 'opcoes_sat.ini');

  pLogImp('fImpressoraArqIni < ' + Result);
end ;

function fAcharImpressoraPeloPonto(const APonto, AEmpresa: String; fonteDados: IFonteDados): String;
  Var
    LQryGen : TDataSet;
    strSQL : String;
begin
  pLogImp('fAcharImpressoraPeloPonto - Ponto: ' + APonto + ' - Empresa: ' + AEmpresa);

  Result := APonto;

  if (not fonteDados.fCampoExiste('PONIMP', 'PON_NOMIMP')) then
  begin
    pLogImp('Tabela PONIMP ou campo PON_NOMIMP n„o existe > vai permanecer > ' + Result);
    Exit;
  end;

  strSQL := '';
  strSQL := strSQL + ' SELECT PON_NOMIMP ';
  strSQL := strSQL + '   FROM PONIMP ';
  strSQL := strSQL + '  WHERE PON_CODEMP = :CODEMP ';
  strSQL := strSQL + '    AND PON_NOMPON = :NOMPON ';

  LQryGen := fonteDados.fExecutaQuery(strSQL, ['CODEMP', 'NOMPON'], [AEmpresa, APonto]);
  Try
    Try
      If (LQryGen.IsEmpty) Or (fEmptyStr(LQryGen.FieldByName('PON_NOMIMP').AsString)) Then
      Begin
        pLogImp('fAcharImpressoraPeloPonto > N„o achou > Nome da impressora vai permanecer: ' + Result);
        Exit;
      End;

      Result := LQryGen.FieldByName('PON_NOMIMP').AsString;
      pLogImp('fAcharImpressoraPeloPonto > Achou > Nome da impressora: ' + Result);
    Except
      On E: Exception Do
      Begin
        pLogImp(E.Message);
        Result := APonto;
      End;
    End;
  Finally
    FreeAndNil(LQryGen);
  End;
end;

function fRetornaMensagemBaseDesonerado(fonteDados: IFonteDados; fltTotalBaseIcmsDesonerado: Double): String;
var
  LMensagem: String;
begin
  Result := 'BASE DO ICMS DESONERADO: R$ ' + FloatToStrF(fltTotalBaseIcmsDesonerado, ffNumber, 12, 2) ;

  LMensagem := UpperCase(fCfgSisFonte(fonteDados, 'MSGDES'));

  If not (Pos('[BASE_DESONERADO]', LMensagem) > 0) Then
    Exit;

  Result := AnsiReplaceStr(LMensagem, '[BASE_DESONERADO]', FloatToStrF(fltTotalBaseIcmsDesonerado, ffNumber, 12, 2));
end;

function fExisteElementoMatriz(const strElemento : String; const arrElementos : TArrString) : Boolean;
  Var
    intCnt : Integer;
begin
  Result := False;
  For intCnt := Low(arrElementos) To High(arrElementos) Do
  Begin
    If (strElemento = arrElementos[intCnt]) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

procedure pAcrescentaElementoMatriz(const strElemento : String; var arrElementos : TArrString);
begin
  SetLength(arrElementos, Length(arrElementos) + 1);
  arrElementos[Length(arrElementos) - 1] := strElemento;
end;

function fDataValida(dtaData: TDateTime): Boolean;
  Var
    wrdAno : Word;
    wrdMes : Word;
    wrdDia : Word;
begin
  wrdAno := StrToIntDef(FormatDateTime('yyyy', dtaData), 0);
  wrdMes := StrToIntDef(FormatDateTime('mm', dtaData), 0);
  wrdDia := StrToIntDef(FormatDateTime('dd', dtaData), 0);

  If (wrdAno = 1899) Then
    Result := False
  Else
    Result := IsValidDate(wrdAno, wrdMes, wrdDia);
end;

function fGetParteEndereco(const strEndereco: String): TRecCliEnd;
var
  L, N, C, O: string;
  strEnderecoNormalizado: string;
  strTextoPosVirgula: string;
  intSNLen,
  intPosVirgula: Integer;

  function fIsDigitChar(const aCHR: Char): Boolean;
  begin
    {$IF CompilerVersion >= 20.0} // Delphi 2009+
    Result := CharInSet(aCHR, ['0'..'9']);
    {$ELSE}
    Result := aCHR in ['0'..'9'];
    {$IFEND}
  end;

  function fIsSpaceChar(const aCHR: Char): Boolean;
  begin
    {$IF CompilerVersion >= 20.0} // Delphi 2009+
    Result := CharInSet(aCHR, [#9, #10, #13, ' ']);
    {$ELSE}
    Result := aCHR in [#9, #10, #13, ' '];
    {$IFEND}
  end;

  procedure pCollapseSpaces(var S: string);
  var
    intIdx: Integer;
    aCHR: Char;
    strOut: string;
  begin
    strOut := '';
    for intIdx := 1 to Length(S) do
    begin
      aCHR := S[intIdx];
      if fIsSpaceChar(aCHR) then
      begin
        if (strOut = '') or (strOut[Length(strOut)] <> ' ') then
          strOut := strOut + ' ';
      end
      else
        strOut := strOut + aCHR;
    end;
    S := Trim(strOut);
  end;

  function fUpperTrim(const S: string): string;
  begin
    Result := UpperCase(Trim(S));
  end;

  function fIsSNLike(const S: string; out intSNLen: Integer): Boolean;
  var U: string;
  begin
    U := fUpperTrim(S);
    if Copy(U,1,3) = 'S/N' then begin intSNLen := 3; Result := True; Exit; end;
    if Copy(U,1,3) = 'S-N' then begin intSNLen := 3; Result := True; Exit; end;
    if Copy(U,1,3) = 'SN.' then begin intSNLen := 3; Result := True; Exit; end;
    if Copy(U,1,2) = 'SN'  then begin intSNLen := 2; Result := True; Exit; end;
    Result := False;
  end;

  procedure pRemoveNumeroPrefix(var S: string);

    function fIsMark(const aCHR: Char): Boolean;
    begin
      Result := (aCHR = '.') or (aCHR = '∫') or (aCHR = '∞');
    end;

    procedure pSkipSep;
    begin
      while (S <> '') and (fIsSpaceChar(S[1]) or (S[1] = ':') or (S[1] = '-') ) do
        Delete(S, 1, 1);
    end;

  begin
    // trim-left manual pra n„o depender de TrimLeft
    while (S <> '') and fIsSpaceChar(S[1]) do
      Delete(S, 1, 1);

    if S = '' then
      Exit;

    S := UpperCase(S);

    // 1) NRO...
    if Copy(S, 1, 3) = 'NRO' then
    begin
      Delete(S, 1, 3);
      if (S <> '') and fIsMark(S[1]) then Delete(S, 1, 1);
      pSkipSep;
      Exit;
    end;

    // 2) NR...
    if Copy(S, 1, 2) = 'NR' then
    begin
      Delete(S, 1, 2);
      if (S <> '') and fIsMark(S[1]) then Delete(S, 1, 1);
      pSkipSep;
      Exit;
    end;

    // 3) N...
    if (S <> '') and (S[1] = 'N') then
    begin
      Delete(S, 1, 1);
      if (S <> '') and fIsMark(S[1]) then Delete(S, 1, 1);
      pSkipSep;
      Exit;
    end;
  end;

  procedure pParseNumeroAndComplemento(const S: string; out strNumero, strCompl: string);
  // S = trecho apÛs a vÌrgula (j· com espaÁos colapsados)
  var
    strWork: string;
    intIdxNumEnd: Integer;
    intSNLen: Integer;
  begin
    strNumero := '';
    strCompl := '';

    strWork := Trim(S);
    if strWork = '' then
      Exit;

    // remove prefixos "n/nro/nr/n∫..."
    pRemoveNumeroPrefix(strWork);

    if strWork = '' then
      Exit;

    // SN / S-N / S/N / SN.
    if fIsSNLike(strWork, intSNLen) then
    begin
      strNumero := Copy(strWork, 1, intSNLen);
      strCompl  := Trim(Copy(strWork, intSNLen + 1, MaxInt));
    end
    else
    begin
      // dÌgitos iniciais
      intIdxNumEnd := 1;
      while (intIdxNumEnd <= Length(strWork)) and fIsDigitChar(strWork[intIdxNumEnd]) do
        Inc(intIdxNumEnd);

      if intIdxNumEnd > 1 then
      begin
        strNumero := Copy(strWork, 1, intIdxNumEnd - 1);
        strCompl  := Trim(Copy(strWork, intIdxNumEnd, MaxInt));
      end
      else
      begin
        // n„o achou n˙mero reconhecÌvel -> tudo vira complemento (vocÍ pode preferir vazio)
        strNumero := '';
        strCompl  := Trim(strWork);
      end;
    end;

    // complemento pode comeÁar com '-'
    if (strCompl <> '') and (strCompl[1] = '-') then
      strCompl := Trim(Copy(strCompl, 2, MaxInt));
  end;

begin
  FillChar(Result, SizeOf(Result), #0);

  strEnderecoNormalizado := strEndereco;
  pCollapseSpaces(strEnderecoNormalizado);

  O := strEnderecoNormalizado;
  L := '';
  N := '';
  C := '';

  // precisa ter vÌrgula, sen„o n„o d· pra aplicar sua regra simples
  intPosVirgula := Pos(',', strEnderecoNormalizado);
  if intPosVirgula > 0 then
  begin
    L := Trim(Copy(strEnderecoNormalizado, 1, intPosVirgula - 1));
    strTextoPosVirgula := Trim(Copy(strEnderecoNormalizado, intPosVirgula + 1, MaxInt));

    // tambÈm colapsa espaÁos do lado direito
    pCollapseSpaces(strTextoPosVirgula);

    pParseNumeroAndComplemento(strTextoPosVirgula, N, C);
  end
  else
  begin
    // sem vÌrgula: devolve tudo como logradouro (regra simples)
    L := strEnderecoNormalizado;
    N := '';
    C := '';
  end;

  if (fIsSNLike(N, intSNLen)) then
  begin
    N:= 'SN';
  end;

  Result.strOriEnd := O;
  Result.strLograd := L;
  Result.strNumero := N;
  Result.strComple := C;
end;

function fAmbienteDeHomologacao(fonteDados: IFonteDados; strCodEmp: String): Boolean;
begin
  Result := (pos('hom',fCfgSisFonte(fonteDados, 'CITURL', strCodEmp)) > 0);
end;

function fUsaSchemaReformaTributaria(fonteDados: IFonteDados; strCodEmp: String): Boolean;
begin
  Result := (fCfgSisFonte(fonteDados, 'USAREF', strCodEmp) = 'S');
end;

function fSomarNovosImpostosDaReformaAoValorContabil(fonteDados: IFonteDados; const strCodEmp: String): Boolean;
begin
  Result := False;
  If not Assigned(fonteDados) Then
    Exit;
  If (fCfgSisFonte(fonteDados, 'REFCIS', strCodEmp) <> 'S') Then
    Exit;
  If (fCfgSisFonte(fonteDados, 'SIMPAU', strCodEmp) = 'S') And (fCfgSisFonte(fonteDados, 'SIMHIB', strCodEmp) = 'N') Then
    Exit;
  Result := True;
end;

function fSomarNovosImpostosDaReformaAoVNF(fonteDados: IFonteDados; const strCodEmp: String): Boolean;
begin
  Result := False;
  If not Assigned(fonteDados) Then
    Exit;
  Result := (fCfgSisFonte(fonteDados, 'REFVNF', strCodEmp) = 'S');
end;

function fGeraSchemaReformaTributaria(fonteDados: IFonteDados; strCodEmp: String): Boolean;
begin
  Result := False;

  If not Assigned(fonteDados) Then
    Exit;

  If fAmbienteDeHomologacao(fonteDados, strCodEmp) Then
  Begin
    Result := True;
    Exit;
  End;

  If fUsaSchemaReformaTributaria(fonteDados, strCodEmp) Then
  Begin
    Result := True;
    Exit;
  End;
end;

function fExigeInsucesso(const AXML: string): Boolean;
var
  LXMLDoc: IXMLDocument;
  LNodeIde, LNodeTransp: IXMLNode;
  LIndPres: String;
  LmodFrete: String;
begin
  Result := False;

  If fEmptyStr(AXML) Then
    Exit;

  LIndPres := '';
  LModFrete := '';

  LXMLDoc := TXMLDocument.Create(nil);

  try
    try
      LXMLDoc.LoadFromXML(AXML);
      LXMLDoc.Active := True;

      LNodeIde := LXMLDoc.DocumentElement.ChildNodes.FindNode('NFe');
      if LNodeIde <> nil then
        LNodeIde := LNodeIde.ChildNodes.FindNode('infNFe');

      if LNodeIde <> nil then
      begin
        LNodeTransp := LNodeIde.ChildNodes.FindNode('transp');

        LNodeIde := LNodeIde.ChildNodes.FindNode('ide');
        if (LNodeIde <> nil) and (LNodeIde.ChildNodes.FindNode('indPres') <> nil) then
          LIndPres := LNodeIde.ChildNodes.FindNode('indPres').Text;
      end;

      if (LNodeTransp <> nil) and (LNodeTransp.ChildNodes.FindNode('modFrete') <> nil) then
        LModFrete := LNodeTransp.ChildNodes.FindNode('modFrete').Text;

      Result := not ((LIndPres = '1') or (LModFrete = '9'));
    except
      On E: Exception Do
      Begin
        pLogImp(Format('fExigeInsucesso: falha ao processar XML da NF-e referenciada (%s: %s). ' +
                       'Assumindo que n„o exige evento Insucesso.',
                       [E.ClassName, E.Message]));
        Result := False;
      End;
    end;
  finally
    LXMLDoc.Active := False;
    LXMLDoc := nil;
  end;
end;

function fImagemParaBase64(const ACaminhoImagem: string): string;
var
  LStreamArquivo: TFileStream;
  LStreamString: TStringStream;
begin
  Result := '';
  {$IF RTLVersion >= 28}
    if not FileExists(ACaminhoImagem) then
      Exit;

    LStreamArquivo := nil;
    LStreamString := nil;
    try
      LStreamArquivo := TFileStream.Create(ACaminhoImagem, fmOpenRead or fmShareDenyWrite);
      LStreamString := TStringStream.Create;

      TNetEncoding.Base64.Encode(LStreamArquivo, LStreamString);
      Result := LStreamString.DataString;
      Result := Result.Replace(#13, '').Replace(#10, '');
    finally
      if Assigned(LStreamString) then
        FreeAndNil(LStreamString);
      if Assigned(LStreamArquivo) then
        FreeAndNil(LStreamArquivo);
    end;
  {$ELSE}
    Result := '';
  {$IFEND}
end;

function fGerarHashEntrega(const AChaveNFe: string; const ACaminhoImagem: string): string;
var
  LChaveLimpa: string;
  LImagemBase64: string;
  LTextoConcatenado: string;
  LBytesSha1: TBytes;
begin
  Result := '';
  {$IF RTLVersion >= 28}
    LChaveLimpa := StringReplace(aChaveNFe, ' ', '', [rfReplaceAll]);

    if LChaveLimpa.Length <> 44 then
      Exit;

    LImagemBase64 := fImagemParaBase64(aCaminhoImagem);

    LTextoConcatenado := LChaveLimpa + LImagemBase64;

    LBytesSha1 := THashSHA1.GetHashBytes(LTextoConcatenado);

    Result := TNetEncoding.Base64.EncodeBytesToString(LBytesSha1);

    Result := Result.Replace(#13, '').Replace(#10, '');
  {$ELSE}
    Result := '';
  {$IFEND}    
end;

{$IFNDEF LINUX}
function StartProcess(Exename, CmdLineArgs: String; ShowWindow, WaitForFinish: boolean): Cardinal;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: boolean;
  LCurrDir: Pointer;
begin
  pLog('>> StartProcess -> ' + Exename + ' ' + CmdLineArgs);

  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);

  If Not ShowWindow Then
  begin
    StartInfo.dwFlags := STARTF_USESHOWWINDOW Or STARTF_FORCEOFFFEEDBACK;
    StartInfo.wShowWindow := SW_HIDE;
  end;

  LCurrDir := Nil;
  if ExtractFilePath(Exename) <> EmptyStr then
    LCurrDir := PChar(ExtractFilePath(Exename));

  CreateOK := CreateProcess(nil, PChar(Exename + ' ' + CmdLineArgs), nil, nil,
    False, CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, LCurrDir,
    StartInfo, ProcInfo);

  Result := ProcInfo.dwProcessId;

  if CreateOK then
  begin
    if WaitForFinish then
      WaitForSingleObject(ProcInfo.hProcess, Infinite);
  end
  else
  begin
    SysErrorMessage(GetLastError());
  end;

  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);

  pLog('<< StartProcess [PID ' + FloatToStr(Result) + '] -> ' + Exename + ' ' + CmdLineArgs);
end;
{$ENDIF}

initialization
{$IFDEF LINUX}
  Application := TApplication.Create(nil);
{$ENDIF}
 {$IF Defined(VER180)}
 {$ELSE}
  OnNotificarProgresso := nil;
 {$IFEND}
  objConfigInterna.blnMonitoramentoTempo := False;
{$IF Defined(VER250) Or Defined(UNIDAC)}
  EnableUniSQL := False;
{$IFEND}
finalization
{$IFDEF LINUX}
  FreeAndNil(Application);
{$ENDIF}

end.
