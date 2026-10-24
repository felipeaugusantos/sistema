unit untImpressaoDiretaCitel;

interface

uses
{$IFDEF LINUX}
  Posix.Unistd, untUtil,
{$ELSE}
  Windows,
{$ENDIF}
{$IF Defined(UNIDAC) Or Defined(LINUX)}
  IOUtils,
{$IFEND}
  SysUtils,
  Classes,
  DateUtils;

const
{$IFDEF LINUX}
 PATH_SEPARATOR = '/';
{$ELSE}
 PATH_SEPARATOR = '\';
{$ENDIF}

//BLOCO DUPLICADO PARA NÃO ADICIONAR untDicSis.pas EM TODAS AS VERSÕES (DEIXAR SEMPRE IGUAL A QUE ESTÁ NA untDicSis.pas)...
type
  TModoInclusaoParam = (mpiIncluirTagSeValorVazio, mpiNaoIncluirTagSeValorVazio);

const
  consTagParamsPid = 'PID'; //PID do programa pai que controla o dicionário

  consTagParamsTrf = 'TRF'; //Tarefa

  consTagParamsDoc = 'DOC'; //Documento
  consTagParamsEsp = 'ESP'; //Espécie
  consTagParamsEmp = 'EMP'; //Empresa
  consTagParamsSer = 'SER'; //Série
  consTagParamsTfc = 'TFC'; //TipFc
  consTagParamsCli = 'CLI'; //Cliente/Fornecedor
  consTagParamsSta = 'STA'; //Status
  consTagParamsMin = 'MIN'; //Minutos para apagar temporários
  consTagParamsChv = 'CHA'; //Chave de Acesso
  consTagParamsMDD = 'MDD'; //Modo de Designer
  consTagParamsImp = 'IMP'; //Nome da Impressora
  consTagParamsRei = 'REI'; //Impressão/Reimpressão
  consTagParamsDir = 'DIR'; //Diretório
  consTagParamsPrv = 'PRV'; //Abrir Preview
  consTagParamsLsi = 'LSI'; //Layout simplificado
  consTagParamsLun = 'LUN'; //Layout Unificado (etiqueta marketplace + DANFE)
//...BLOCO DUPLICADO PARA NÃO ADICIONAR untDicSis.pas EM TODAS AS VERSÕES (DEIXAR SEMPRE IGUAL A QUE ESTÁ NA untDicSis.pas)

type
  TImpressaoDiretaCitel = class
  public
    class function fRetNomeNfeImprimirExeCitel: String;
    class function fImpressoraEhParaImprimir(const AstrImpressora: String): Boolean;
    class procedure pImprimir(strCodigoEmpresa,
                              strImpressora,
                              strAcesso,
                              strTipo        : String;
                              blnReimpressao : Boolean = False;
                              aPidMD5DicSis  : String = '';
                              strOutputLogFile  : string  = '');

    class procedure pImprimirPDF(strCodigoEmpresa,
                                 strImpressora,
                                 strAcesso,
                                 strTipo           : String;
                                 blnReimpressao    : Boolean = False;
                                 strPDF_Diretorio  : String  = '';
                                 blnPDF_Apresentar : Boolean = False;
                                 aPidMD5DicSis     : String  = '';
                                 strLayoutSimplif  : String  = '';
                                 strOutputLogFile  : string  = '';
                                 blnWaitForFinish  : Boolean = False);

    class procedure pGerarBMP(strCodigoEmpresa,
                              strAcesso           : String;
                              strBMP_Diretorio    : String;
                              aPidMD5DicSis       : String  = '';
                              strLayoutUnif       : String  = 'S';
                              strOutputLogFile    : String  = '');
  end;

Var
  VS_strCodPnlDir: string;

implementation

uses
  StrUtils, untLogDanfe;

function fPnlDir(const strNomArq: String): String;
  Var
    strDirEmp: String;
begin
  strDirEmp := ExtractFilePath(ParamStr(0));

  If (VS_strCodPnlDir <> '') Then
  Begin
    strDirEmp := strDirEmp + 'PNLDIR' + PATH_SEPARATOR + VS_strCodPnlDir + PATH_SEPARATOR;

    If (Not DirectoryExists(strDirEmp)) Then
      ForceDirectories(strDirEmp);
  End;

  Result := strDirEmp + strNomArq;
end;

//BLOCO DUPLICADO PARA NÃO ADICIONAR untDicSis.pas EM TODAS AS VERSÕES (DEIXAR SEMPRE IGUAL A QUE ESTÁ NA untDicSis.pas)...
function fEhParaImprimir(const strImpressora: String): boolean;
begin
  Result := (Pos(AnsiUpperCase(strImpressora), 'NENHUMA_NENHUM_NAO IMPRIMIR_NÃO IMPRIMIR_') <= 0);
end;

procedure pLogImp(const strValor: string; blnGravaLogDanfe: boolean=True);
  Const
    _TAG_HOR : String = 'HORINI.';
  Var
    _LOG_IMP : String;
    stlLog : TStringList;
    dtaFileDateTime: TDateTime;
    strAnt: String;
    strTmp: String;
    intMls: Integer;

    procedure pSetaHorIni;
    begin
      stlLog[0] := _TAG_HOR + FormatDateTime('hh:nn:ss.zzz', nOw())
        +' A COLUNA CENTRAL REPRESENTA A DIFERENÇA EM "CENTÉSIMOS DE SEGUNDOS" OU '
        +'"SEGUNDOS.CENTÉSIMOS DE SEGUNDOS" ENTRE O PONTO INDICADO E O LOG ANTERIOR. '
        +'DIFERENÇAS MENORES QUE 010 CENTÉSIMOS NÃO SÃO INDICADAS E SE A DIFERENÇA FOR '
        +'MAIOR QUE UM MINUTO, A INDICAÇÃO +1MIN. SERÁ APRESENTADA.';
    end;

    function fExtractTime(const strTmp: String): String;
    begin
      Result := '';

      If (stlLog.Count = 0) Then
        Exit;

      If (Pos(_TAG_HOR, stlLog[0]) = 0) Then
        Exit;

      Result := Copy(strTmp, 1, 25);
      If (Pos(_TAG_HOR, Result) > 0) Then
        Result := AnsiReplaceStr(Result, _TAG_HOR, '');
      Result := Copy(Result, 1, 12);

      If (Length(Result) = 12) And
         (Copy(Result, 3, 1) = ':') And
         (Copy(Result, 6, 1) = ':') And
         (Pos(Copy(Result, 9, 1), '.,') > 0) Then
      Begin
        Result := AnsiReplaceStr(Result, '.', ',');
      End
      Else
      Begin
        Result := '';
      End;
    end;

    function fRetHorAnt(out strOut: String): Boolean;
      Var
        intIdx: Integer;
    begin
      Result := False;

      {$IF Defined(UNIDAC)}
      If (stlLog.Count = 0) Then
        Exit;

      If (Pos(_TAG_HOR, stlLog[0]) = 0) Then
        Exit;

      For intIdx := stlLog.Count-1 Downto 0 Do
      Begin
        strOut := fExtractTime(stlLog[intIdx]);

        If (strOut <> '') Then
        Begin
          Result := True;
          Break;
        End;
      End;
      {$IFEND}
    end;

    function fTotaliza(const strLog: String): Boolean;
    begin
      {$IF Defined(UNIDAC)}
      Result := (Pos('pTarefaImprimir <', Copy(strLog, 1, 25)) > 0) And (fExtractTime(stlLog[0]) <> '');
      {$ELSE}
      Result := False;
      {$IFEND}
    end;
begin
  If (blnGravaLogDanfe) Then
  Begin
    Try
      objLogDanfe.AddLog(strValor);
    Except
      //
    End;
  End;

  _LOG_IMP := fPnlDir('log_imp.txt');

  If Not FileExists(_LOG_IMP) Then
    Exit;

  Try
    FileAge(_LOG_IMP,dtaFileDateTime);

    If (dtaFileDateTime < Date) Then
    Begin
      SysUtils.DeleteFile(_LOG_IMP);
      Exit;
    End;
  Except
    //
  End;

  //EXEMPLO DE CONTEÚDO PARA CRIAR ARQUIVO DE LOTE PARA MEDIR DESEMPENHO:
  //
  //ECHO HORINI. > log_imp.txt
  //NFeStatus.exe TRF:NFE_PROCESSAR_STATUS DOC:000000000000 ESP:NF EMP:000 SER:0 CLI:00000000 TFC:C STA:AE PID:5AA46541D672FA292E99AB9A16FB48XX
  //
  //NO SQLYOG EXECUTAR OS COMANDOS ABAIXO ANTES DE EXECUTAR O ARQUIVO DE LOTE:
  //
  //DELETE FROM LOGPRT WHERE PRT_NUMDOC = '000000000000' AND PRT_ESPDOC = 'NF' AND PRT_CODEMP = '000';
  //DELETE FROM XMLNFE WHERE NFE_ACESSO = '35240552688892000169550010007059861796138099';
  //DELETE FROM PDFNFE WHERE NFE_ACESSO = '35240552688892000169550010007059861796138099';

  stlLog := TStringList.Create;
  Try
    Try
      stlLog.LoadFromFile(_LOG_IMP);

      If (stlLog.Count > 0) Then
      Begin
        If (_TAG_HOR = Trim(stlLog[0])) Then
          pSetaHorIni;
      End;

      If fRetHorAnt(strAnt) Then
      Begin
        {$IF Defined(UNIDAC)}
        intMls := MilliSecondsBetween(StrToTime(FormatDateTime('hh:nn:ss,zzz', nOw())), StrToTime(strAnt));
        strTmp := FormatFloat('#,##0', intMls);
        If (intMls > 59999) Then
          strTmp := ' +1MIN. '
        Else If (intMls >= 10) Then
          strTmp := ' ' + strTmp.PadLeft(3,'0').PadLeft(6,' ') + ' '
        Else
          strTmp := '        ';
        stlLog.Add(FormatDateTime('hh:nn:ss.zzz', nOw()) + strTmp + strValor);
        {$IFEND}
      End
      Else
      Begin
        stlLog.Add(FormatDateTime('hh:nn:ss.zzz', nOw()) + ' - ' + strValor);
      End;

      If (stlLog.Count > 1) Then
      Begin
        If (fTotaliza(strValor)) Then
        Begin
          stlLog.Add('Tempo Total: '+FormatDateTime('hh:nn:ss.zzz', StrToTime(FormatDateTime('hh:nn:ss,zzz', nOw()))-StrToTime(fExtractTime(stlLog[0]))));
          pSetaHorIni;
        End;
      End;

      While stlLog.Count > 10000 Do
        stlLog.Delete(0);
      stlLog.SaveToFile(_LOG_IMP);
    Except
      //
    End;
  Finally
    FreeAndNil(stlLog);
  End;
end;

function fTagComValorToParam(const strValor: string; const strTagPar: string; tModoInclusaoParam: TModoInclusaoParam=mpiIncluirTagSeValorVazio): string;
begin
  Result := '';
  If (Trim(strValor) <> '') Or (tModoInclusaoParam = mpiIncluirTagSeValorVazio) Then
    Result := ' ' + '"'+strTagPar+':'+strValor+'"';
end;
//...BLOCO DUPLICADO PARA NÃO ADICIONAR untDicSis.pas EM TODAS AS VERSÕES (DEIXAR SEMPRE IGUAL A QUE ESTÁ NA untDicSis.pas)

{$IFNDEF LINUX}
function StartProcess(Exename, CmdLineArgs: String; ShowWindow, WaitForFinish: boolean): Cardinal;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: boolean;
  LCurrDir: Pointer;
begin
  pLogImp('>> StartProcess -> ' + Exename + ' ' + CmdLineArgs);

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

  pLogImp('<< StartProcess [PID ' + FloatToStr(Result) + '] -> ' + Exename + ' ' + CmdLineArgs);
end;
{$ENDIF}

{ TImpressaoDiretaCitel }

class function TImpressaoDiretaCitel.fRetNomeNfeImprimirExeCitel: String;
begin
{$IF Defined(LINUX)}
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'NFeImpressao';
{$ELSE}
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'NFeImpressao.exe';
{$IFEND}
end;

class function TImpressaoDiretaCitel.fImpressoraEhParaImprimir(const AstrImpressora: String): Boolean;
begin
  // Expoe a regra de "nao imprimir" para quem decide antes de chamar o pImprimir,
  // sem uma terceira copia da lista (a outra vive na untDicSis).
  Result := fEhParaImprimir(AstrImpressora);
end;

class procedure TImpressaoDiretaCitel.pImprimir(strCodigoEmpresa,
                                                strImpressora,
                                                strAcesso,
                                                strTipo        : String;
                                                blnReimpressao : Boolean = False;
                                                aPidMD5DicSis  : String = '';
                                                strOutputLogFile  : string  = '');
var
  strNfeImprimirExe: string;
  strReimpressaoNFE : string;
  strTarefa_,
  strComando,
  strParam01,
  strParam02,
  strParam03,
  strParam04,
  strParam05: String;
begin
  VS_strCodPnlDir := strCodigoEmpresa;

  pLogImp('TImpressaoDiretaCitel.pImprimir');

  strTarefa_ := strTipo + '_IMPRIMIR';

  if (Not fEhParaImprimir(strImpressora)) then
  begin
    strTarefa_ := strTipo + '_GERAR_PDF';
  end;

  strReimpressaoNFE := '';
  if Pos(strTipo, 'NFE_NFS_NFCE_') > 0 then
  begin
    if (blnReimpressao) then
      strReimpressaoNFE := 'REIMPRESSAO'
    else
      strReimpressaoNFE := 'IMPRESSAO';
  end;

  strNfeImprimirExe := fRetNomeNfeImprimirExeCitel;

  strParam01 := strTarefa_;
  strParam02 := strCodigoEmpresa;
  strParam03 := strAcesso;
  strParam04 := strImpressora;
  strParam05 := strReimpressaoNFE;

  strComando := fTagComValorToParam(strParam01, consTagParamsTrf) +
                fTagComValorToParam(strParam02, consTagParamsEmp) +
                fTagComValorToParam(strParam03, consTagParamsChv) +
                fTagComValorToParam(strParam04, consTagParamsImp) +
                fTagComValorToParam(strParam05, consTagParamsRei) +
                fTagComValorToParam(aPidMD5DicSis, consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

  if FileExists(strNfeImprimirExe) then
  begin
   {$IFDEF LINUX}
    if strOutputLogFile.IsEmpty then
      strOutputLogFile := '/dev/null';
    strComando := strNfeImprimirExe + strComando + ' > "' + strOutputLogFile + '" & ';
    Writeln('ShellExecute > ' + strComando);
    ShellExecute(strComando);
   {$ELSE}
    StartProcess(strNfeImprimirExe, strComando, False, False);
   {$ENDIF}
  end
  else
  begin
    pLogImp('ATENÇÃO: '+strNfeImprimirExe+' NÃO ENCONTRADO!');
  end;
end;

class procedure TImpressaoDiretaCitel.pImprimirPDF(strCodigoEmpresa,
                                                   strImpressora,
                                                   strAcesso,
                                                   strTipo           : String;
                                                   blnReimpressao    : Boolean = False;
                                                   strPDF_Diretorio  : String  = '';
                                                   blnPDF_Apresentar : Boolean = False;
                                                   aPidMD5DicSis     : String  = '';
                                                   strLayoutSimplif  : String  = '';
                                                   strOutputLogFile  : string  = '';
                                                   blnWaitForFinish  : Boolean = False);

var
  strNfeImprimirExe,
  strReimpressaoNFE,
  strDiretorio,
  strApresentar : String;
  strTarefa_,
  strComando,
  strParam01,
  strParam02,
  strParam03,
  strParam04,
  strParam05,
  strParam06,
  strParam07,
  strParam08: String;
begin
  VS_strCodPnlDir := strCodigoEmpresa;

  pLogImp('TImpressaoDiretaCitel.pImprimirPDF');

  strTarefa_ := strTipo + '_IMPRIMIR_PDF';

  if (Not fEhParaImprimir(strImpressora)) then
  begin
    Exit;
  end;

  strReimpressaoNFE := '';
  if (strTipo = 'NFE') then
  begin
    if (blnReimpressao) then
      strReimpressaoNFE := 'REIMPRESSAO'
    else
      strReimpressaoNFE := 'IMPRESSAO';
  end;

  strDiretorio := strPDF_Diretorio;
  strApresentar := 'N';
  If blnPDF_Apresentar Then
    strApresentar := 'S';

  strNfeImprimirExe := fRetNomeNfeImprimirExeCitel;

  strParam01 := strTarefa_;
  strParam02 := strCodigoEmpresa;
  strParam03 := strAcesso;
  strParam04 := strImpressora;
  strParam05 := strReimpressaoNFE;
  strParam06 := strDiretorio;
  strParam07 := strApresentar;
  strParam08 := strLayoutSimplif;

  strComando := fTagComValorToParam(strParam01, consTagParamsTrf) +
                fTagComValorToParam(strParam02, consTagParamsEmp) +
                fTagComValorToParam(strParam03, consTagParamsChv) +
                fTagComValorToParam(strParam04, consTagParamsImp) +
                fTagComValorToParam(strParam05, consTagParamsRei) +
                fTagComValorToParam(strParam06, consTagParamsDir) +
                fTagComValorToParam(strParam07, consTagParamsPrv) +
                fTagComValorToParam(strParam08, consTagParamsLsi, mpiNaoIncluirTagSeValorVazio) +
                fTagComValorToParam(aPidMD5DicSis, consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

  if FileExists(strNfeImprimirExe) then
  begin
   {$IFDEF LINUX}
    if strOutputLogFile.IsEmpty then
      strOutputLogFile := '/dev/null';
    strComando := strNfeImprimirExe + strComando + ' > "' + strOutputLogFile + '" & ';
    Writeln('ShellExecute > ' + strComando);
    ShellExecute(strComando);
   {$ELSE}
    StartProcess(strNfeImprimirExe, strComando, False, blnWaitForFinish);
   {$ENDIF}
  end
  else
  begin
    pLogImp('ATENÇÃO: '+strNfeImprimirExe+' NÃO ENCONTRADO!');
  end;
End;

class procedure TImpressaoDiretaCitel.pGerarBMP(strCodigoEmpresa,
                                                strAcesso           : String;
                                                strBMP_Diretorio    : String;
                                                aPidMD5DicSis       : String  = '';
                                                strLayoutUnif       : String  = 'S';
                                                strOutputLogFile    : String  = '');
var
  strNfeImprimirExe,
  strComando        : String;
begin
  VS_strCodPnlDir := strCodigoEmpresa;

  pLogImp('TImpressaoDiretaCitel.pGerarBMP');

  strNfeImprimirExe := fRetNomeNfeImprimirExeCitel;

  strComando := fTagComValorToParam('NFE_GERAR_BMP',       consTagParamsTrf) +
                fTagComValorToParam(strCodigoEmpresa,      consTagParamsEmp) +
                fTagComValorToParam(strAcesso,             consTagParamsChv) +
                fTagComValorToParam(strBMP_Diretorio,      consTagParamsDir) +
                fTagComValorToParam(strLayoutUnif,         consTagParamsLun, mpiNaoIncluirTagSeValorVazio) +
                fTagComValorToParam(aPidMD5DicSis,         consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

  if FileExists(strNfeImprimirExe) then
  begin
   {$IFDEF LINUX}
    // Linux fora do escopo v1 desta feature.
    Exit;
   {$ELSE}
    // WaitForFinish=True — autcom precisa do BMP antes de continuar.
    StartProcess(strNfeImprimirExe, strComando, False, True);
   {$ENDIF}
  end
  else
  begin
    pLogImp('ATENÇÃO: '+strNfeImprimirExe+' NÃO ENCONTRADO!');
  end;
end;

initialization
  VS_strCodPnlDir := '';

end.
