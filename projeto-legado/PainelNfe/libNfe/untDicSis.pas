{*********************************************************************************}
{* UNIT BÁSICA SEM DEPENDÊNCIAS QUE PODE SER ADICIONADA EM QUALQUER PROJETO PARA *}
{* INTEROPERABILIDADE ENTRE OS PROGRAMAS IDENTIFICANDO, FORMATANDO OU EXTRAINDO  *}
{* PARÂMETROS DE CHAMADA DE EXE POR TAG'S IDENTIFICADORAS. HOJE ELA É USADA ENTRE*}
{* PanielNfe.exe, NfeStatus.exe, libNfe.dll, NfeImpressao.exe, AutCom.Exe,       *}
{* IntegradorSAT.exe                                                             *}
{******************************************************************************VA*}
unit untDicSis;

interface

uses
 {$IF Defined(UNIDAC) Or Defined(LINUX)}
  System.Generics.Collections, System.Classes, Uni,
 {$ELSE}
  ZDataset, ZConnection, Classes,
 {$IFEND}
  DB, SysUtils, StrUtils, IdHashMessageDigest, DateUtils;

type
  TQueryLog = class sealed
  public
    class procedure BeforeOpen(DataSet: TDataSet);
    class procedure BeforeExecute(Sender: TObject);
end;

type
  TModoInclusaoParam = (mpiIncluirTagSeValorVazio, mpiNaoIncluirTagSeValorVazio);
  TAcaoParaAtualizar = (apaUpdate, apaDelete);

const
{$IFDEF LINUX}
 PATH_SEPARATOR = '/';
{$ELSE}
 PATH_SEPARATOR = '\';
{$ENDIF}

{$IF Defined(UNIDAC) Or Defined(LINUX)}
  //ARRAY DE CAMPOS OU TABELAS QUE CAIRAM NO LIMBO E/OU NUNCA VÃO EXISTIR
  arrOld: Array[0..34] Of String  = ('TAB|ICMUFD',
                                     'TAB|DETANT',
                                     'TAB|MOVICD_ESPEC',
                                     'TAB|NOTICD_ESPEC',
                                     'CMP|ABFICM|ABF_CSTORI',
                                     'CMP|AUXMOV|AUX_CPFCNP',
                                     'CMP|AUXMOV|AUX_ESTADO',
                                     'CMP|AUXMOV|AUX_MESANO',
                                     'CMP|AUXMOV|AUX_MODELO',
                                     'CMP|AUXMOV|AUX_NUMERO',
                                     'CMP|AUXMOV|AUX_SERIE_',
                                     'CMP|AUXNOT|AUX_CPFCNP',
                                     'CMP|AUXNOT|AUX_EMP_TE',
                                     'CMP|AUXNOT|AUX_ESTADO',
                                     'CMP|AUXNOT|AUX_EST_DV',
                                     'CMP|AUXNOT|AUX_MESANO',
                                     'CMP|AUXNOT|AUX_MODELO',
                                     'CMP|AUXNOT|AUX_NUMERO',
                                     'CMP|AUXNOT|AUX_SERIE_',
                                     'CMP|AUXNOT|AUX_TRARDP',
                                     'CMP|CADFIS|FIS_DEVNES',
                                     'CMP|CADREC|CTR_SERIE_',
                                     'CMP|MOVDET|DET_SERDEV',
                                     'CMP|NOTDET|DET_DESNES',
                                     'CMP|MOVDET|DET_SERFAT',
                                     'CMP|NOTDET|DET_SERFAT',
                                     'CMP|FATDOR|FDO_SERFAT',
                                     'CMP|CADABF|ABF_BASDOR',
                                     'CMP|CADABF|ABF_BASDDS',
                                     'CMP|MOVTRI|DET_COICMP',
                                     'CMP|NOTTRI|DET_COICMP',
                                     'CMP|MOVMOD|MCA_TIPCAR',
                                     'CMP|ABFICM|ABF_CODBEN_SAI_ORG',
                                     'CMP|ABFICM|ABF_MENS01_SAI_ORG',
                                     'CMP|ABFICM|ABF_MENS02_SAI_ORG');

{$IFEND}

  //TAG'S DE DICIONÁRIO
  consTagTabExiste = 'TAB'; //Tabela.......: (Existe: S/N)
  consTagCmpExiste = 'CMP'; //Campo........: (Existe: S/N)
  consTagCfgExiste = 'CEX'; //Configuração.: (Existe: S/N)
  consTagValCfgSis = 'CFG'; //Configuração.: (Valor da Configuração)
  consTagIgnCodCfg = 'IGN'; //Configuração.: (Ignoradas: Não podem ser cacheadas na VS_DicSis)
  consTagLogCodCfg = 'LOG'; //Configuração.: (Configurações usadas no Login)

  //TAG'S DE PARÂMETROS
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
  consTagParamsMpa = 'MPA'; //Pergunta se deseja abrir um painel com outro já aberto (SIM/NÃO)

  consIntervalorMinimoParaVerificaoDicSis = 5;    //Intevalo para ver a VS_DicSis precisa ser atualizada
  consIntervalorMinimoCfgSisForaAlteradas = 5;    //Intevalo para ver se as cfg's precisam ser alteradas
  consIntervalorMinimoTabCmpPassouExistir = 5;    //Intevalo para ver se uma tabela/campo foi criada
  consIntervalorMinimoTabCmpDeixouExistir = 1440; //Intevalo para ver se uma tabela/campo foi apagada (isso é a exceção da exceção por isso esse tempo igual à um dia)

function fSepDir(const strDirNan: String): String;
function fPnlDir(const strNomArq: String): String;
procedure pLog(strValor: String);
procedure pLogSQL(AQuery: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND});
procedure pLogImp(const strValor: string; blnGravaLogDanfe: boolean=True);
procedure pLogEnotas(const strValor: String);
function fEhParaImprimir(const strImpressora: String): boolean;
function IIF(lTest:Boolean; vExpr1, vExpr2: Variant): Variant;
function fEmptyStrDicSis(const AString: string): Boolean;
function IfEmptyStrDicSis(const AString, AStringDefault: String): String;
function fGetValorPipeDisSis(strLinha, strDelimitador: string; intColuna: Integer; blnIgnoraPrimeiro: Boolean=False): string;
function fMatchText(const AText: string; const AValues: array of string): boolean;
function fStringListToCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator: string = ','): string;
function fExtraiSomenteKey(const strKey, strMd5: String): String;
function fExtraiHostDaUrl(const AUrl: string): string;

procedure pRetornaParamSeExistir(const strTagPar: string; Var strValor: string; blnTrimResult: Boolean=False);
procedure pExtraiValorParam(const strParam: string; const strTagPar: string; Var strValor: string);
function fExtraiValorParam(const strParam: string): string;
function fTagComValorToParam(const strValor: string; const strTagPar: string; tModoInclusaoParam: TModoInclusaoParam=mpiIncluirTagSeValorVazio): string;
function fEhUmParamIdentificado(const strParam: string): Boolean;
function fTodosParametosPorTag: Boolean;
function fTodosParametosPorPos: Boolean;
function fParametrosMisturados(out strMsgAux: string): Boolean;
procedure pClassificaParametros(Var strParamIdentificadoSim: string; var strParamIdentificadoNao: string);
function fPidMacToPidMD5(intPidExe: Integer; strMacAdd: string): string;
function fBooleanToStringDisSis(const blnVal: Boolean): string;
function fStringToBooleanDicSis(const strVal: string): Boolean;

function fFormataKeyValCfgParaDicSis(const strCodCfg: string; const strCodEmp: string): string;
function fFormataKeyCfgExiParaDicSis(const strCodCfg: string; const strCodEmp: string): string;
function fFormataKeyTabExiParaDicSis(const strNomTab: string): string;
function fFormataKeyCmpExiParaDicSis(const strNomTab: string; const strNomCmp: string): string;
function fFormataKeyLogCfgParaDicSis(const strCodCfg: string): string;

function fEhDicSisPorPidGen(const strTipDic: string): Boolean;
function fEhDicSisPorPidMd5(const strTipDic: string): Boolean;

function fCriaQueryDicSis(objConexao: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniConnection {$ELSE} TZConnection {$IFEND}): {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND};
function fTabelaCampoExiste(objConexao: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniConnection {$ELSE} TZConnection {$IFEND}; strTabela: string; strCampo_: string=''): Boolean;

procedure pGeraRegistroParaLogGeneral(objConexao: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniConnection {$ELSE} TZConnection {$IFEND}; strTexto: string=''; blnLibNfe: Boolean=False);

procedure pLogarErro(const ATarefa: String; E: String); overload;
procedure pLogarErro(const ATarefa: String; E: Exception); overload;
procedure pGrvArqTxt(const ANomArq, ATexto: String);
function fRetOrderByNota(const strCFG_USA_RS, strCFG_ORDALF: String; const strTieBreaker: String = ''): String;

{$IF Defined(UNIDAC) Or Defined(LINUX)}
function fStartTransactionDicSis(objConexao: TUniConnection = Nil): Boolean;
function fRollBackDicSis(objConexao: TUniConnection = Nil): Boolean;
function fCommitDicSis(objConexao: TUniConnection = Nil): Boolean;
procedure pAtualizarDicSisSeNecessario(objConexao: TUniConnection);
function fExisteTabelaDicSis(objConexao: TUniConnection): Boolean;
procedure pSetaPidMD5DicSis(objConexao: TUniConnection; const intPidExe: Integer; const strMacAdd: string);
procedure pDeletaDicSisPorPidMd5(objConexao: TUniConnection);
procedure pAtrasaDataHoraDicSis(objConexao: TUniConnection);
procedure pDeletaDicSisComMaisQueUmDia(objConexao: TUniConnection);
procedure pDeletaDicSisComTempoVida(objConexao: TUniConnection; intMin: Integer=120);
procedure pDesativaDicSis(objConexao: TUniConnection);
procedure pRefazDicionarioConfiguracoesIgnoradas(objConexao: TUniConnection);
procedure pCarregaArrIgn(objConexao: TUniConnection);
procedure pProcessaListaDisSis(objConexao: TUniConnection; SLKeyDicSis: TStringList; apaAcaoParaAtualizar: TAcaoParaAtualizar);
procedure pCarregaDicSis(objConexao: TUniConnection; const strTipDic: string=''; strKeyDic: string='');
procedure pInsereDicSis(objConexao: TUniConnection; const strKeyDic: string; const strValDic: string);
function fAchouDicSisBln(objConexao: TUniConnection; const strKeyDic: string; out outBln: Boolean): Boolean;
function fAchouDicSisStr(objConexao: TUniConnection; const strKeyDic: string; out outStr: string): Boolean;
function fRetListaArrOld: String;
function fPodeLerOuGrvDicSis(objConexao: TUniConnection; const strKeyDic: string): Boolean;
procedure pGravaConfiguraoesInicializacao(objConexao: TUniConnection; const dicConfigInicial: TDictionary<string,boolean>);
{$IFEND}

Var
  VS_strCodPnlDir: string;
  VS_PidGenerico_: string;
  VS_PidMD5DicSis: string;
{$IF Defined(UNIDAC) Or Defined(LINUX)}
  VS_dicDicSis : TDictionary<string, string>;
  VS_hraDicSis : TTime;
  arrIgn       : array of string;
{$IFEND}

implementation

uses untLogDanfe;

function fSepDir(const strDirNan: String): String;
begin
  Result := Trim(strDirNan);
  If (Result <> '') Then
  Begin
    If (RightStr(Result, 1) <> PATH_SEPARATOR) Then
      Result := Result + PATH_SEPARATOR;
  End;
end;

function fPnlDir(const strNomArq: String): String;
  Var
    strDirEmp: String;
begin
  strDirEmp := fSepDir(ExtractFilePath(ParamStr(0)));

  If (VS_strCodPnlDir <> '') Then
  Begin
    strDirEmp := strDirEmp + 'PNLDIR' + PATH_SEPARATOR + VS_strCodPnlDir + PATH_SEPARATOR;

    If (Not DirectoryExists(strDirEmp)) Then
      ForceDirectories(strDirEmp);
  End;

  Result := strDirEmp + Trim(strNomArq);
end;

procedure pLog(strValor: String);
  Var
    _LOG_NFE: String;
    stlLog : TStringList;
    dtaFileDateTime: TDateTime;
begin
 {$IF Defined(UNIDAC) Or Defined(LINUX)}
  objLogDanfe.AddLog(strValor);
 {$IFEND};

  _LOG_NFE := fPnlDir('log_nfe.txt');

  If Not FileExists(_LOG_NFE) Then
    Exit;

  Try
    FileAge(_LOG_NFE,dtaFileDateTime);

    If (dtaFileDateTime < Date) Then
    Begin
      SysUtils.DeleteFile(_LOG_NFE);
      Exit;
    End;
  Except
    //
  End;

  stlLog := TStringList.Create;
  Try
    try
      stlLog.LoadFromFile(_LOG_NFE);
      stlLog.Add(FormatDateTime('hh:nn:ss.zzz', nOw()) + ' - ' + strValor);
      stlLog.SaveToFile(_LOG_NFE);
    Except
      //
    End;
  Finally
    FreeAndNil(stlLog);
  End;
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

procedure pLogEnotas(const strValor: String);
  Var
    _LOG_ENO: String;
    stlLog : TStringList;
    dtaFileDateTime: TDateTime;
begin
  Try
    objLogDanfe.AddLog(strValor);
  Except
    //
  End;

  pLogImp(strValor, False);

  _LOG_ENO := fPnlDir('log_eNotas.txt');

  If Not FileExists(_LOG_ENO) Then
    Exit;

  Try
    FileAge(_LOG_ENO,dtaFileDateTime);

    If (dtaFileDateTime < Date) Then
    Begin
      SysUtils.DeleteFile(_LOG_ENO);
      Exit;
    End;
  Except
    //
  End;

  stlLog := TStringList.Create;
  Try
    Try
      stlLog.LoadFromFile(_LOG_ENO);
      stlLog.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss.zzz', nOw()) + ' - ' + strValor);
      While stlLog.Count > 10000 Do
        stlLog.Delete(0);
      stlLog.SaveToFile(_LOG_ENO);
    Except
      //
    End;
  Finally
    FreeAndNil(stlLog);
  End;
end;

procedure pLogSQL(AQuery: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND});
  var
    _LOG_SQL : string;
    stlLog : TStringList;
    dtaFileDateTime: TDateTime;
    strSQL : string;
    strPar : string;
    strVal : string;
    intIdx : Integer;
    blnSav : Boolean;

  function fConteudoParametro(const aStrPar: string; const aStrVal: string): string;
  begin
    If (aStrPar = 'PDF') And (Length(aStrVal) >= 1000) Then
      Result := 'STRING MUITO GRANDE NAO LOGADA: '+IntToStr(Length(aStrVal))+' CARACTERES'
    Else
      Result := aStrVal;
  end;
begin
  _LOG_SQL := fPnlDir('log_sql.txt');

  If Not FileExists(_LOG_SQL) Then
    Exit;

  If Not Assigned(AQuery) Then
    Exit;

  Try
    FileAge(_LOG_SQL,dtaFileDateTime);

    If (dtaFileDateTime < Date) Then
    Begin
      SysUtils.DeleteFile(_LOG_SQL);
      Exit;
    End;
  Except
    //
  End;

  strSQL := AQuery.SQL.Text;
  strSQL := AnsiReplaceStr(strSQL, #13, ' ');
  strSQL := AnsiReplaceStr(strSQL, #10, ' ');
  While Pos('  ', strSQL) > 0 Do
    strSQL := AnsiReplaceStr(strSQL, '  ', ' ');
  For intIdx := 0 To AQuery.Params.Count -1 Do
  Begin
    If intIdx > 0 Then
      strPar := strPar + ', ';

    strVal := QuotedStr(fConteudoParametro(AQuery.Params[intIdx].Name, AQuery.Params[intIdx].AsString));
    strPar := strPar + AQuery.Params[intIdx].Name + ' = ' + strVal;
    strSQL := AnsiReplaceStr(strSQL, ':'+AQuery.Params[intIdx].Name, strVal);
  End;

  If (strPar <> '') Then
    strPar := sLineBreak + '/*Params: ' + strPar + '*/';

  If    (Pos('SELECT LENGTH(NFE_NUMDOC) FROM LOGNFE', strSQL) > 0)
     Or (Pos('SELECT SUM(IF((NFE_STATUS <> "EE")', strSQL) > 0)
     Or (Pos('SELECT GET_LOCK(', strSQL) > 0)
     Or (Pos('SELECT * FROM ((SELECT 1 AS ORDEM', strSQL) > 0)
     Or (Pos('SELECT COUNT(0) AS QTD FROM LOGNFE', strSQL) > 0)
     Or (Pos('SELECT COUNT(0) AS PENDEN',  strSQL) > 0)
     Or ((Pos(' NFE_TAREFAS ',  strSQL) > 0) And (Pos('DELETE', strSQL) = 0) And (Pos('NFE_DESCRI = ''<', strSQL) = 0))
     Or (Pos('SET group_con', strSQL) > 0)
     Or (Pos('SET character', strSQL) > 0)
     Or (Pos('SET collation', strSQL) > 0)
     Or (Pos('SET sql_mode',  strSQL) > 0)
//     Or (Pos(' DICSIS ',      strSQL) > 0)
  Then
  Begin
    Exit;
  End;

  strSQL := Trim(strSQL);
  If (RightStr(strSQL, 1) <> ';') Then
    strSQL := strSQL + ';';

  stlLog := TStringList.Create;
  Try
    Repeat
      Try
        stlLog.LoadFromFile(_LOG_SQL);
        stlLog.Add('/*' + FormatDateTime('hh:nn:ss.zzz', nOw()) + '*/ ' + strSQL + strPar + ' -- [' + ExtractFileName(ParamStr(0)) + ']');
        stlLog.Add('/*--------------------------------------------------------------------------------------------------------------*/');
        While stlLog.Count > 10000 Do
          stlLog.Delete(0);
        stlLog.SaveToFile(_LOG_SQL);

        blnSav := True;
      Except
        blnSav := True; //SETAR FALSE PARA GRAVAR TODOS OS LOG'S (CUIDADO PODE TRAVAR O PAINEL USE SOMENTE EM TEMPO DE PROJETO)
      End;
    Until blnSav;
  Finally
    FreeAndNil(stlLog);
  End;
end;

function fEhParaImprimir(const strImpressora: String): boolean;
begin
  Result := (Pos(AnsiUpperCase(strImpressora), 'NENHUMA_NENHUM_NAO IMPRIMIR_NÃO IMPRIMIR_') <= 0);
end;

function IIF(lTest:Boolean; vExpr1, vExpr2: Variant):Variant;
begin
  If lTest Then
    Result := vExpr1
  Else
    Result := vExpr2
end;

function fEmptyStrDicSis(const AString: string): Boolean;
var
  intIdx: Integer;
begin
  for intIdx := 1 to Length(AString) do
  begin
    if (AString[intIdx] <> ' ') and
       (AString[intIdx] <> #9)  and
       (AString[intIdx] <> #10) and
       (AString[intIdx] <> #13) then
    begin
      Result := False;
      Exit;
    end;
  end;

  Result := True;
end;

function IfEmptyStrDicSis(const AString, AStringDefault: String): String;
begin
  Result := AString;
  If fEmptyStrDicSis(Result) Then
    Result := AStringDefault;
end;

function fGetValorPipeDisSis(strLinha, strDelimitador: string; intColuna: Integer; blnIgnoraPrimeiro: Boolean=False): string;
  Var
    intContador: Integer;
    intContDel: Integer;
    intTamStr: Integer;
    intEstado: Integer; // 0=normal 1=entre aspas
begin
  Result := '';

  If fEmptyStrDicSis(strLinha) Then
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

function fMatchText(const AText: string; const AValues: array of string): boolean;
 Var
   intIdx: Integer;
begin
  Result := False;
  For intIdx := Low(AValues) To High(AValues) Do
  Begin
    If (AText = AValues[intIdx]) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function fStringListToCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator: string = ','): string;
  Var
    intIdx: Integer;
    strDado: String;
Begin
  Result := '';

  For intIdx := 0 To stlListSelecao.Count - 1 Do
  Begin
    If blnQuoted Then
      strDado := QuotedStr(stlListSelecao[intIdx])
    Else
      strDado := stlListSelecao[intIdx];

    If intIdx = 0 Then
      Result := strDado
    Else
      Result := Result + strSeparator +  strDado;
  End;
end;

function fExtraiSomenteKey(const strKey, strMd5: String): String;
begin
  Result := AnsiReplaceStr(strKey, strMd5+'|', '');
end;

function fExtraiHostDaUrl(const AUrl: string): string;
var
  intPosIni,
  intPosFim: Integer;
begin
  Result := Trim(AUrl);

  // Cortes que removem o INÍCIO (tudo antes do separador, inclusive ele)
  intPosIni := Pos('://', Result);
  if intPosIni > 0 then
    Delete(Result, 1, intPosIni + 2);

  intPosIni := Pos('@', Result);
  if intPosIni > 0 then
    Delete(Result, 1, intPosIni);

  // Cortes que removem o FIM (tudo a partir do separador)
  intPosFim := Pos('/', Result);
  if intPosFim > 0 then
    Result := Copy(Result, 1, intPosFim - 1);

  intPosFim := Pos(':', Result);
  if intPosFim > 0 then
    Result := Copy(Result, 1, intPosFim - 1);
end;

procedure pRetornaParamSeExistir(const strTagPar: string; Var strValor: string; blnTrimResult: Boolean=False);
  Var
   intParam: Integer;
begin
  strValor := '';
  For intParam := 1 To ParamCount Do
  Begin
    pExtraiValorParam(ParamStr(intParam), strTagPar, strValor);
    If (strValor<>'') Then
      Break;
  End;
  If blnTrimResult Then
    strValor := Trim(strValor);
end;

procedure pExtraiValorParam(const strParam: string; const strTagPar: string; Var strValor: string);
begin
  If fEhUmParamIdentificado(strParam) Then
    If (Copy(strParam, 1, 4) = (strTagPar+':')) Then
      If Length(strParam) > 4 then
        strValor := Copy(strParam, 5, Length(strParam));
end;

function fExtraiValorParam(const strParam: string): string;
begin
  Result := '';
  If fEhUmParamIdentificado(strParam) Then
    If Length(strParam) > 4 then
      Result := Copy(strParam, 5, Length(strParam));
end;

function fTagComValorToParam(const strValor: string; const strTagPar: string; tModoInclusaoParam: TModoInclusaoParam=mpiIncluirTagSeValorVazio): string;
begin
  Result := '';
  If (Trim(strValor) <> '') Or (tModoInclusaoParam = mpiIncluirTagSeValorVazio) Then
    Result := ' ' + '"'+strTagPar+':'+strValor+'"';
end;

function fEhUmParamIdentificado(const strParam: string): Boolean;
  Var
    strAux: string;
begin
  Result := False;

  strAux := Copy(strParam, 1, 4);
  If (Length(strAux) = 4) Then
    If (strAux[4] = ':') Then
      Result := True;
end;

function fTodosParametosPorTag: Boolean;
  Var
    strParamIdentificadoSim: string;
    strParamIdentificadoNao: string;
begin
  pClassificaParametros(strParamIdentificadoSim, strParamIdentificadoNao);
  Result := (Not fEmptyStrDicSis(strParamIdentificadoSim)) And (fEmptyStrDicSis(strParamIdentificadoNao));
end;

function fTodosParametosPorPos: Boolean;
  Var
    strParamIdentificadoSim: string;
    strParamIdentificadoNao: string;
begin
  pClassificaParametros(strParamIdentificadoSim, strParamIdentificadoNao);
  Result := (fEmptyStrDicSis(strParamIdentificadoSim)) And (Not fEmptyStrDicSis(strParamIdentificadoNao));
end;

function fParametrosMisturados(out strMsgAux: string): Boolean;
  Var
    strParamIdentificadoSim: string;
    strParamIdentificadoNao: string;
begin
  pClassificaParametros(strParamIdentificadoSim, strParamIdentificadoNao);
  Result := (Not fEmptyStrDicSis(strParamIdentificadoSim)) And (Not fEmptyStrDicSis(strParamIdentificadoNao));

  If (Result) Then
  Begin
    strMsgAux := strMsgAux + 'Não é possivel processar a chamada deste programa: '+ ParamStr(0) + sLineBreak;
    strMsgAux := strMsgAux + 'Há mistura de parâmetros identificados com parâmetros não identificados!' + sLineBreak;
    strMsgAux := strMsgAux + 'Parâmetros identificados (SIM): ' + strParamIdentificadoSim + sLineBreak;
    strMsgAux := strMsgAux + 'Parâmetros identificados (Não): ' + strParamIdentificadoNao;
  End;
end;

procedure pClassificaParametros(Var strParamIdentificadoSim: string; var strParamIdentificadoNao: string);
  Var
    intParam: Integer;
begin
  For intParam := 1 To ParamCount Do
  Begin
    {*****************************************************************************************}
    {* PID É O ÚNICO PARÂMETROS QUE PODE SER PASSADO SÓ ELE COM TAG E OUTROS SEM, ISSO PARA  *}
    {* MANTER COMPATIBILIDADE DE VERSÕES ANTERIORES À ESSA ALTERAÇÃO. DEMAIS PARAMÂMETROS OU *}
    {* SÃO TODOS COM TAG (MODO NOVO) TODOS SEM TAG (MODO ANTIGO)                             *}
    {**************************************************************************************VA*}
    If (Pos(consTagParamsPid, ParamStr(intParam)) = 0) Then
    Begin
      If (fEhUmParamIdentificado(ParamStr(intParam))) Then
        strParamIdentificadoSim := strParamIdentificadoSim + IIF(fEmptyStrDicSis(strParamIdentificadoSim), '', ' ') + ParamStr(intParam)
      Else
        strParamIdentificadoNao := strParamIdentificadoNao + IIF(fEmptyStrDicSis(strParamIdentificadoNao), '', ' ') + ParamStr(intParam);
    End;
  End;
end;

function fBooleanToStringDisSis(const blnVal: Boolean): string;
begin
  Result := IIF(blnVal, 'S', 'N');
end;

function fStringToBooleanDicSis(const strVal: string): Boolean;
begin
  Result := IIF(strVal = 'S', True, False);
end;

function fFormataKeyValCfgParaDicSis(const strCodCfg: string; const strCodEmp: string): string;
begin
  Result := AnsiUpperCase(consTagValCfgSis + '|' + 'CFG_' + IIF(LeftStr(strCodCfg,4)='CFG_',Copy(strCodCfg,5,Length(strCodCfg)), strCodCfg) + '|' + strCodEmp);
end;

function fFormataKeyCfgExiParaDicSis(const strCodCfg: string; const strCodEmp: string): string;
begin
  Result := AnsiUpperCase(consTagCfgExiste + '|' + 'CFG_' + IIF(LeftStr(strCodCfg,4)='CFG_',Copy(strCodCfg,5,Length(strCodCfg)), strCodCfg) + '|' + strCodEmp);
end;

function fFormataKeyTabExiParaDicSis(const strNomTab: string): string;
begin
  Result := AnsiUpperCase(consTagTabExiste + '|' + strNomTab);
end;

function fFormataKeyCmpExiParaDicSis(const strNomTab: string; const strNomCmp: string): string;
begin
  Result := AnsiUpperCase(consTagCmpExiste + '|' + strNomTab + '|' + strNomCmp);
end;

function fFormataKeyLogCfgParaDicSis(const strCodCfg: string): string;
begin
  Result := AnsiUpperCase(consTagLogCodCfg + '|' + strCodCfg);
end;

function fPidMacToPidMD5(intPidExe: Integer; strMacAdd: string): string;
  Var
    idMD5 : TIdHashMessageDigest5;
begin
  idMD5 := TIdHashMessageDigest5.Create;
  Try
   {$IF RTLVersion >= 27}
    Result := idMD5.HashStringAsHex(IntToStr(intPidExe)+''+strMacAdd);
   {$ELSE}
    Result := idMD5.AsHex(idMD5.HashValue(IntToStr(intPidExe)+''+strMacAdd));
   {$IFEND};
  Finally
    idMD5.Free;
  End;
end;

function fEhDicSisPorPidGen(const strTipDic: string): Boolean;
begin
  //DICIONÁRIO POR PID GENÉRICO SÃO DICIONÁRIOS CUJO IDENTIFICADOR PRINCIPAL (DIC_PIDMD5)
  //É REPRESENTADO  PELO CONTEÚDO  DE VS_PidGenerico_, NÃO  PRECISAM  SER  ATUALIZADOS A
  //TODO MOMENTO  E  VALE PARA  TODAS  INSTÂNCIAS  DE  PROGRAMAS,  NO CASO, POR EXEMPLO,
  //DICIONÁRIOS DE TABELA/CAMPOS EXISTENTES;
  Result := (Pos(strTipDic, consTagTabExiste+'_'+consTagCmpExiste+'_') > 0);
end;

function fEhDicSisPorPidMd5(const strTipDic: string): Boolean;
begin
  //DICIONÁRIO POR PID POR MD5 SÃO DICIONÁRIOS  CUJO IDENTIFICADOR PRINCIPAL (DIC_PIDMD5)
  //É REPRESENTADO  PELO CONTEUDO  DE  VS_PidMD5DicSis,  PRECISAM   SER  ATUALIZADOS OU
  //VERIFICADOS COM CERTA FREQUÊNCIA E SÃO EXCLUSÍVOS DE CADA INSTÂNCIA (Autcom, PanielNfe)
  //QUE FAZ USO DO DICIONÁRIO, POR EXEMPLO, DICIONÁRIO DE VALOR DA CFGSIS;
  Result := (Not fEhDicSisPorPidGen(strTipDic));
end;

function fCriaQueryDicSis(objConexao: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniConnection {$ELSE} TZConnection {$IFEND}): {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND};
Begin
  Result := {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery.Create(Nil); {$ELSE} TZQuery.Create(Nil); {$IFEND}
  Result.Connection := objConexao;
  Result.Tag := objConexao.Tag;
  {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)}
  Result.BeforeExecute := TQueryLog.BeforeExecute;
  {$ELSE}
  Result.BeforeOpen := TQueryLog.BeforeOpen;
  {$IFEND}
End;

function fTabelaCampoExiste(objConexao: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniConnection {$ELSE} TZConnection {$IFEND}; strTabela: string; strCampo_: string=''): Boolean;

  function fTabelaOuCampoNaoExisteNoBanco(const intCodigo: Integer; const strMensagemErro: String): Boolean;
  var
    LMsg: String;
  begin
    // Fallback por código
    Result := (intCodigo = 1146) Or //MySQL 1146 - tabela não existe
              (intCodigo = 1054);   //MySQL 1054 - coluna não existe

    // Fallback por mensagem caso o código não venha preenchido (ex: exception genérica)
    If Not Result Then
    Begin
      LMsg := LowerCase(strMensagemErro);
      Result := (Pos('doesn''t exist', LMsg) > 0) Or
                (Pos('unknown column', LMsg) > 0);
    End;
  end;

  Var
    qryGen: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := False;

  qryGen := fCriaQueryDicSis(objConexao);
  Try
    Try
      qryGen.SQL.Text := 'SELECT '+IIF(strCampo_='', '"TAB" AS TABELA_EXISTE', strCampo_+' AS CAMPO_EXISTE')+' FROM '+strTabela+' WHERE FALSE;';
      qryGen.Open;
      Result := True;
      qryGen.Close;
    Except
      {$IF Defined(UNIDAC) Or Defined(VER250) Or Defined(LINUX)}
      On E: EUniError Do
      Begin
        If fTabelaOuCampoNaoExisteNoBanco(E.ErrorCode, E.Message) Then
          Result := False
        Else
          Raise;
      End;
      {$ELSE}
      On E: EDatabaseError Do
      Begin
        If fTabelaOuCampoNaoExisteNoBanco(0, E.Message) Then
          Result := False
        Else
          Raise;
      End;
      {$IFEND}
      On E: Exception Do // fallback para exceções genéricas (ex: "Provider is not defined")
      Begin
        If fTabelaOuCampoNaoExisteNoBanco(0, E.Message) Then
          Result := False
        Else
          Raise;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pGeraRegistroParaLogGeneral(objConexao: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniConnection {$ELSE} TZConnection {$IFEND}; strTexto: string=''; blnLibNfe: Boolean=False);
  Var
    qryGen: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND};

  function fRetornaListaParams: String;
    Var
      intIdx: Integer;
  begin
    For intIdx := 0 To ParamCount Do
      Result := Result + ' ' + ParamStr(intIdx);

    Result := Trim(Result);
  end;

begin
  If (Not Assigned(objConexao)) Then
    Exit;

  qryGen := fCriaQueryDicSis(objConexao);
  Try
    Try
      qryGen.Close;
      qryGen.SQL.Add('/*');

      qryGen.SQL.Add('<GENERAL>');

      If (blnLibNfe) Then
      Begin
        qryGen.SQL.Add('libNfe.dll EVOCADA POR: ' + ExtractFileName(ParamStr(0)));
      End;

      {$IF Defined(VER250) Or Defined(UNIDAC)}
      qryGen.SQL.Add('POOLING...............: ' + fBooleanToStringDisSis(objConexao.Pooling));
      {$IFEND}

      qryGen.SQL.Add('MODULO................: ' + fRetornaListaParams);

      If (strTexto<>'') Then
        qryGen.SQL.Add('OBSERVACAO............: ' + strTexto);

      qryGen.SQL.Add('*/');
      qryGen.ExecSQL;
    Except
      //
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pLogarErro(const ATarefa: String; E: String);
  Var
    SL: TStringList;
    intParam: Integer;
    strParam: String;
    strArqui: String;
begin
  strParam := '';
  For intParam := 0 To ParamCount Do
  Begin
    pExtraiValorParam(ParamStr(intParam), consTagParamsTrf, strArqui);
    strParam := strParam + ' ' + ParamStr(intParam);
  End;

  If (Trim(strArqui) = '') Then
    strArqui := ATarefa;

  strArqui := AnsiReplaceStr(strArqui,'\','');
  strArqui := AnsiReplaceStr(strArqui,'/','');
  strArqui := AnsiReplaceStr(strArqui,':','');
  strArqui := AnsiReplaceStr(strArqui,'*','');
  strArqui := AnsiReplaceStr(strArqui,'?','');
  strArqui := AnsiReplaceStr(strArqui,'"','');
  strArqui := AnsiReplaceStr(strArqui,'<','');
  strArqui := AnsiReplaceStr(strArqui,'>','');
  strArqui := AnsiReplaceStr(strArqui,'|','');

  SL := TStringList.Create;
  Try
    SL.Add('ERRO AO EXECUTAR: ' + strParam);
    SL.Add('EXCEÇÃO.........: ' + E);
    SL.SaveToFile('ERRO_'+strArqui+'.TXT');
  Finally
    FreeAndNil(SL);
  End;
end;

procedure pLogarErro(const ATarefa: String; E: Exception);
begin
  pLogarErro(ATarefa, E.Message)
end;

procedure pGrvArqTxt(const ANomArq, ATexto: String);
  Var
    SL: TStringList;
begin
  SL := TStringList.Create;
  Try
    SL.Add(ATexto);
    Try
      SL.SaveToFile(fPnlDir(ANomArq + '.TXT'));
    Except

    End;
  Finally
    FreeAndNil(SL);
  End;
end;

function fRetOrderByNota(const strCFG_USA_RS, strCFG_ORDALF: String; const strTieBreaker: String = ''): String;
  Var
    strOrdIte: String; //Na Nota Fiscal Eletrônica, imprimir produtos em ordem de?
    strUsaReS: String; //Utilizar rotina de industrialização efetuada em outra empresa, para emitir os produtos de venda e os produtos de retorno simbólico na mesma nota fiscal?
    strSufixo: String;
begin
  strOrdIte := strCFG_ORDALF;
  strUsaReS := IfEmptyStrDicSis(strCFG_USA_RS, 'N');
  strSufixo := IfThen(strTieBreaker <> '', ', ' + strTieBreaker, '');

  If (strUsaReS = 'S') Then
  Begin
    Result := ' ORDER BY DET_NITEM_ ';
  End
  Else
  Begin
    Result := '';

    If (strOrdIte = 'A') Then      // ORDEM (A)LFABÉTICA
      Result := ' ORDER BY DET_DESCRI '
    Else If (strOrdIte = 'C') Then // ORDEM (C)ÓDIGO DO ITEM
      Result := ' ORDER BY DET_CODITE '
    Else If (strOrdIte = 'U') Then // ORDEM (U)NIDADE + DESCRIÇÃO
      Result := ' ORDER BY ITE_SIGUNV, DET_DESCRI '
    Else If (strOrdIte = 'F') Then // ORDEM (F)ORNECEDOR DO ITEM
      Result := ' ORDER BY DET_FORITE '
    Else If (strOrdIte = 'L') Then // ORDEM (L)OCALIZAÇÃO FÍSICA
      Result := ' ORDER BY DET_LOCFIS '
    Else If (strOrdIte = 'P') Then // ORDEM (P)ESO UNIDADE + UNIDADE + DESCRIÇÃO DO PRODUTO
      Result := ' ORDER BY UNI_PESLTV, ITE_SIGUNV, DET_DESCRI '
    Else If (strOrdIte = 'S') Then // ORDEM LOCAL DE (S)EPARAÇÃO
      Result := ' ORDER BY DET_CODLSE, DET_DESCRI ';

    If (Not fEmptyStrDicSis(Result)) And (Not fEmptyStrDicSis(strSufixo)) Then
      Result := Result + strSufixo; // Deixar o sufixo sempre por último (Desempate em dados iguais) !
  End;
end;

{$IF Defined(UNIDAC) Or Defined(LINUX)}
function fStartTransactionDicSis(objConexao: TUniConnection = Nil): Boolean;
begin
  Result := True;
  Try
    If Assigned(objConexao) Then
    Begin
      If (Not objConexao.InTransaction) Then
      Begin
        objConexao.Options.LocalFailover := False;
        objConexao.StartTransaction;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pLogImp(E.Message + ' [fStartTransactionDicSis]');
    End;
  End;
end;

function fRollBackDicSis(objConexao: TUniConnection = Nil):Boolean;
begin
  Result := True;
  Try
    If Assigned(objConexao) Then
    Begin
      If (objConexao.InTransaction) Then
      Begin
        objConexao.Rollback;
        objConexao.Options.LocalFailover := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pLogImp(E.Message + ' [fRollBackDicSis]');
    End;
  End;
end;

function fCommitDicSis(objConexao: TUniConnection = Nil):Boolean;
begin
  Result := True;
  Try
    If Assigned(objConexao) Then
    Begin
      If (objConexao.InTransaction = True) Then
      Begin
        objConexao.Commit;
        objConexao.Options.LocalFailover := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pLogImp(E.Message + ' [fCommitDicSis]');
    End;
  End;
end;

procedure pAtualizarDicSisSeNecessario(objConexao: TUniConnection);
begin
  If ((Not fEmptyStrDicSis(VS_PidMD5DicSis))) And
     ((VS_dicDicSis.Count = 0) Or (MinutesBetween(Time, VS_hraDicSis) >= consIntervalorMinimoParaVerificaoDicSis)) Then
    pCarregaDicSis(objConexao);
end;

function fExisteTabelaDicSis(objConexao: TUniConnection): Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := False;

  qryGen := fCriaQueryDicSis(objConexao);
  Try
    Try
      qryGen.SQL.Text := 'SELECT * FROM DICSIS WHERE FALSE;';
      qryGen.Open;
      Result := True;
      qryGen.Close;
    Except
      //
    End;
  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen)
  End;
end;

procedure pSetaPidMD5DicSis(objConexao: TUniConnection; const intPidExe: Integer; const strMacAdd: string);
begin
  If (fExisteTabelaDicSis(objConexao)) Then
  Begin
    If (fEmptyStrDicSis(VS_PidMD5DicSis)) Then
      VS_PidMD5DicSis := fPidMacToPidMD5(intPidExe, strMacAdd);
  End;
end;

procedure pDeletaDicSisPorPidMd5(objConexao: TUniConnection);
  Var
    qryGen: TUniQuery;
    blnComTransacao: Boolean;
begin
  If (Not fEmptyStrDicSis(VS_PidMD5DicSis)) Then
  Begin
    If (fExisteTabelaDicSis(objConexao)) Then
    Begin
      qryGen := fCriaQueryDicSis(objConexao);
      Try
        qryGen.SQL.Text := 'DELETE FROM DICSIS WHERE DIC_PIDMD5 = "'+VS_PidMD5DicSis+'";';

        blnComTransacao := (Not objConexao.InTransaction);
        Try
          If blnComTransacao Then
            fStartTransactionDicSis(objConexao);

          qryGen.ExecSQL;

          If blnComTransacao Then
            fCommitDicSis(objConexao)
        Except
          On E: Exception Do
          Begin
            If blnComTransacao Then
              fRollBackDicSis(objConexao);

            pLogImp(E.Message + ' [pDeletaDicSisPorPidMd5]');
          End;
        End;
      Finally
        FreeAndNil(qryGen);
      End;
    End;
  End;
end;

procedure pAtrasaDataHoraDicSis(objConexao: TUniConnection);
  Var
    qryGen: TUniQuery;
    blnComTransacao: Boolean;
begin
  If (Not fEmptyStrDicSis(VS_PidMD5DicSis)) Then
  Begin
    If (fExisteTabelaDicSis(objConexao)) Then
    Begin
      qryGen := fCriaQueryDicSis(objConexao);
      Try
        qryGen.SQL.Clear;
        qryGen.SQL.Add('UPDATE DICSIS SET DIC_DTAHRA = CONCAT(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), " ", "00:00:00") WHERE DIC_TIPDIC IN ("TAB", "CMP", "IGN") AND DIC_PIDMD5 = "'+VS_PidGenerico_+'";');
        qryGen.SQL.Add('UPDATE DICSIS SET DIC_DTAHRA = CONCAT(DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY), " ", "00:00:00") WHERE DIC_PIDMD5 <> "'+VS_PidGenerico_+'";');

        blnComTransacao := (Not objConexao.InTransaction);
        Try
          If blnComTransacao Then
            fStartTransactionDicSis(objConexao);

          qryGen.ExecSQL;

          If blnComTransacao Then
            fCommitDicSis(objConexao)
        Except
          On E: Exception Do
          Begin
            If blnComTransacao Then
              fRollBackDicSis(objConexao);

            pLogImp(E.Message + ' [pAtrasaDataHoraDicSis]');
          End;
        End;
      Finally
        FreeAndNil(qryGen);
      End;
    End;
  End;
end;

procedure pDeletaDicSisComMaisQueUmDia(objConexao: TUniConnection);
  Var
    qryGen: TUniQuery;
    blnComTransacao: Boolean;
begin
  If (fExisteTabelaDicSis(objConexao)) Then
  Begin
    qryGen := fCriaQueryDicSis(objConexao);
    Try
      qryGen.SQL.Clear;
      qryGen.SQL.Add('DELETE FROM DICSIS WHERE DIC_PIDMD5 <> "'+VS_PidGenerico_+'" AND TIMESTAMPDIFF(MINUTE, DIC_DTAHRA, CURRENT_TIMESTAMP) >= 480;');
      qryGen.SQL.Add('DELETE FROM DICSIS WHERE DIC_PIDMD5 = "'+VS_PidGenerico_+'" AND DIC_TIPDIC IN ("TAB", "CMP") AND DIC_KEYDIC NOT IN ('+fRetListaArrOld+') AND DIC_VALDIC = "N" AND TIMESTAMPDIFF(MINUTE, DIC_DTAHRA, CURRENT_TIMESTAMP) >= 480;');
      qryGen.SQL.Add('DELETE FROM DICSIS WHERE DIC_PIDMD5 = "'+VS_PidGenerico_+'" AND DIC_TIPDIC IN ("LOG") AND TIMESTAMPDIFF(MINUTE, DIC_DTAHRA, CURRENT_TIMESTAMP) >= 480;');

      blnComTransacao := (Not objConexao.InTransaction);
      Try
        If blnComTransacao Then
          fStartTransactionDicSis(objConexao);

        qryGen.ExecSQL;

        If blnComTransacao Then
          fCommitDicSis(objConexao)
      Except
        On E: Exception Do
        Begin
          If blnComTransacao Then
            fRollBackDicSis(objConexao);

          pLogImp(E.Message + ' [pDeletaDicSisComMaisQueUmDia]');
        End;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure pDeletaDicSisComTempoVida(objConexao: TUniConnection; intMin: Integer=120);
  Var
    qryGen: TUniQuery;
    blnComTransacao: Boolean;
begin
  If (fExisteTabelaDicSis(objConexao)) Then
  Begin
    qryGen := fCriaQueryDicSis(objConexao);
    Try
      qryGen.SQL.Text := 'DELETE FROM DICSIS WHERE DIC_PIDMD5 <> "'+VS_PidGenerico_+'" AND TIMESTAMPDIFF(MINUTE, DIC_DTAHRA, CURRENT_TIMESTAMP) >= '+IntToStr(intMin)+';';

      blnComTransacao := (Not objConexao.InTransaction);
      Try
        If blnComTransacao Then
          fStartTransactionDicSis(objConexao);

        qryGen.ExecSQL;

        If blnComTransacao Then
          fCommitDicSis(objConexao)
      Except
        On E: Exception Do
        Begin
          If blnComTransacao Then
            fRollBackDicSis(objConexao);

          pLogImp(E.Message + ' [pDeletaDicSisComTempoVida]');
        End;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure pDesativaDicSis(objConexao: TUniConnection);
begin
  VS_dicDicSis.Clear;
  VS_dicDicSis.TrimExcess;

  Try
    If (Not fExisteTabelaDicSis(objConexao)) Then
    Begin
      VS_PidMD5DicSis := '';
    End;
  Except
    //
  End;
end;

procedure pRefazDicionarioConfiguracoesIgnoradas(objConexao: TUniConnection);
  Var
    qryGen: TUniQuery;
    blnComTransacao: Boolean;
begin
  qryGen := fCriaQueryDicSis(objConexao);
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DELETE FROM DICSIS WHERE DIC_PIDMD5 = "'+VS_PidGenerico_+'" AND DIC_TIPDIC = "'+consTagIgnCodCfg+'"; ');
    qryGen.SQL.Add('REPLACE INTO DICSIS (DIC_PIDMD5, DIC_TIPDIC, DIC_KEYDIC, DIC_VALDIC) ');
    qryGen.SQL.Add('SELECT DISTINCT "'+VS_PidGenerico_+'", "'+consTagIgnCodCfg+'", CONCAT("'+consTagIgnCodCfg+'|",SIS_CODCFG), "CONFIGURAÇÕES QUE NÃO PODEM ENTRAR EM CACHE" ');
    qryGen.SQL.Add('  FROM CFGSIS ');
    qryGen.SQL.Add(' WHERE ((SIS_GRUCFG LIKE "PR%XIMOS C%DIGOS") OR (SIS_DESCRI LIKE "%SEQU%NCIAL%") OR (SIS_CODCFG LIKE "CFG_PRO\_%")) ');
    qryGen.SQL.Add('   AND (SIS_CODCFG NOT IN ("CFG_CDLTAU","CFG_CHKGRV","CFG_CKCGRV","CFG_COMTSE","CFG_CSQCAI","CFG_DTASQC","CFG_FDEUIS","CFG_MCVEXS","CFG_NUMPGSEQ", ');
    qryGen.SQL.Add('                           "CFG_PGSEQ_","CFG_PIMPSQ","CFG_REMSPC","CFG_SEQSEP","CFG_TAMLOT","CFG_UTSNFI","CFG_UTSPDI","CFG_UTICNS","CFG_CSNSEZ",   ');
    qryGen.SQL.Add('                           "CFG_PROPWS","CFG_VLPRXC","CFG_PROTEL","CFG_TIPCFM","CFG_SISACA","CFG_SEQCFS","CFG_SEQCFS","CFG_ONDWMS")); ');

    blnComTransacao := (Not objConexao.InTransaction);
    Try
      If blnComTransacao Then
        fStartTransactionDicSis(objConexao);

      qryGen.ExecSQL;

      If blnComTransacao Then
        fCommitDicSis(objConexao)
    Except
      On E: Exception Do
      Begin
        If blnComTransacao Then
          fRollBackDicSis(objConexao);

        pLogImp(E.Message + ' [pRefazDicionarioConfiguracoesIgnoradas]');
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pCarregaArrIgn(objConexao: TUniConnection);
  Var
    qryGen: TUniQuery;
begin
  If (Length(arrIgn) = 0) Then
  Begin
    qryGen := fCriaQueryDicSis(objConexao);
    Try
      Try
        qryGen.SQL.Text := 'SELECT DIC_KEYDIC, (SELECT TIMESTAMPDIFF(MINUTE, MIN(DIC_DTAHRA), CURRENT_TIMESTAMP) FROM DICSIS WHERE DIC_PIDMD5 = :DIC_PIDMD5 AND DIC_TIPDIC = :DIC_TIPDIC LIMIT 1) AS DIC_TEMPO_ '+
                           '  FROM DICSIS '+
                           ' WHERE DIC_PIDMD5 = :DIC_PIDMD5 '+
                           '   AND DIC_TIPDIC = :DIC_TIPDIC;';

        qryGen.ParamByName('DIC_PIDMD5').Value := VS_PidGenerico_;
        qryGen.ParamByName('DIC_TIPDIC').Value := consTagIgnCodCfg;
        qryGen.Open;

        If (qryGen.IsEmpty) Then
        Begin
          qryGen.Close;
          pRefazDicionarioConfiguracoesIgnoradas(objConexao);
          qryGen.Open;
        End
        Else If (qryGen.FieldByName('DIC_TEMPO_').AsInteger >= consIntervalorMinimoTabCmpDeixouExistir) Then
        Begin
          qryGen.Close;
          pRefazDicionarioConfiguracoesIgnoradas(objConexao);
          qryGen.Open;
        End;

        qryGen.First;
        While Not qryGen.Eof Do
        Begin
          SetLength(arrIgn, Length(arrIgn) + 1);
          arrIgn[Length(arrIgn)-1] := AnsiReplaceStr(qryGen.FieldByName('DIC_KEYDIC').AsString, consTagIgnCodCfg+'|', '');

          qryGen.Next;
        End;
        qryGen.Close;
      Except
        //
      End;
    Finally
      FreeAndNil(qryGen)
    End;
  End;
end;

procedure pProcessaListaDisSis(objConexao: TUniConnection; SLKeyDicSis: TStringList; apaAcaoParaAtualizar: TAcaoParaAtualizar);
   Var
     qryAux: TUniQuery;
     intIdx: Integer;
     strTip: String;
     strKey: String;
     strMd5: String;
     blnComTransacao: Boolean;
begin
   qryAux := fCriaQueryDicSis(objConexao);
   Try
     For intIdx := 0 To SLKeyDicSis.Count-1 Do
     Begin
       //EX: SLKeyDicSis[intIdx] = 5AA46541D672FA292E99AB9A16FB48FE|CMP|ABFICM|ABF_CODBEN_ENT_PEF
       strMd5 := fGetValorPipeDisSis(SLKeyDicSis[intIdx],'|',1);
       strTip := fGetValorPipeDisSis(SLKeyDicSis[intIdx],'|',2);
       strKey := fExtraiSomenteKey(SLKeyDicSis[intIdx], strMd5);

       If (apaAcaoParaAtualizar = apaDelete) Then
         qryAux.SQL.Add('DELETE FROM DICSIS WHERE DIC_PIDMD5 = "'+strMd5+'" AND DIC_TIPDIC = "'+strTip+'" AND DIC_KEYDIC = "'+strKey+'";')
       Else If (apaAcaoParaAtualizar = apaUpdate) Then
         qryAux.SQL.Add('UPDATE DICSIS SET DIC_DTAHRA = CURRENT_TIMESTAMP WHERE DIC_PIDMD5 = "'+strMd5+'" AND DIC_TIPDIC = "'+strTip+'" AND DIC_KEYDIC = "'+strKey+'";');
     End;

     If (qryAux.SQL.Count > 0) Then
     Begin
       blnComTransacao := (Not objConexao.InTransaction);
       Try
         If blnComTransacao Then
           fStartTransactionDicSis(objConexao);

         qryAux.ExecSQL;

         If blnComTransacao Then
           fCommitDicSis(objConexao)
       Except
         On E: Exception Do
         Begin
           If blnComTransacao Then
             fRollBackDicSis(objConexao);

           pDesativaDicSis(objConexao);

           pLogImp(E.Message + ' [pProcessaListaDisSis]');
         End;
       End;
     End;
   Finally
     FreeAndNil(qryAux);
   End;
end;

procedure pCarregaDicSis(objConexao: TUniConnection; const strTipDic: string=''; strKeyDic: string='');
  Var
    dicCfgSisAtual: TDictionary<string, string>;
    qryAux,
    qryDic: TUniQuery;
    blnCargaFull: Boolean;
    strMd5,
    strVal,
    strTab,
    strCmp,
    strTip,
    strKey,
    strKeyAux: String;
    SLKeyDicSisUpd,
    SLKeyDicSisDel: TStringList;
    intTmp: Integer;
    intIdx: Integer;
    blnLocalizou: Boolean;
    strSisValCfg: String;

    procedure pAddListDel;
    begin
      SLKeyDicSisDel.Add(qryDic.FieldByName('DIC_PIDMD5').AsString + '|'+ qryDic.FieldByName('DIC_KEYDIC').AsString);
    end;

    procedure pAddListUpd;
    begin
      SLKeyDicSisUpd.Add(qryDic.FieldByName('DIC_PIDMD5').AsString + '|'+ qryDic.FieldByName('DIC_KEYDIC').AsString);
    end;
begin
  If (Not fEmptyStrDicSis(VS_PidMD5DicSis)) Then
  Begin
    blnCargaFull := False;

    qryDic := fCriaQueryDicSis(objConexao);
    SLKeyDicSisUpd := TStringList.Create;
    SLKeyDicSisDel := TStringList.Create;
    dicCfgSisAtual := TDictionary<string, string>.Create;
    Try
      Try
        //BUSCA DICIONÁRIO GRAVADO NA DICSIS
        qryDic.Close;
        qryDic.SQL.Clear;
        qryDic.SQL.Add(' SELECT DIC_PIDMD5, DIC_TIPDIC, DIC_KEYDIC, DIC_VALDIC, TIMESTAMPDIFF(MINUTE, DIC_DTAHRA, CURRENT_TIMESTAMP) AS DIC_TEMPO_ ');
        qryDic.SQL.Add('   FROM DICSIS ');
        qryDic.SQL.Add('  WHERE DIC_PIDMD5 IN ('+ QuotedStr(VS_PidMD5DicSis) + ', ' + QuotedStr(VS_PidGenerico_) +') ');
        qryDic.SQL.Add('    AND DIC_TIPDIC NOT IN ('+ QuotedStr(consTagIgnCodCfg) + ', ' + QuotedStr(consTagLogCodCfg) +'); ');

        If (VS_dicDicSis.Count = 0) Or (fEmptyStrDicSis(strTipDic+strKeyDic)) Then
        Begin
          blnCargaFull := True;
          VS_dicDicSis.Clear;
          VS_dicDicSis.TrimExcess;
        End
        Else
        Begin
          If (Not fEmptyStrDicSis(strTipDic)) Then
            qryDic.SQL.Add('AND DIC_TIPDIC = :DIC_TIPDIC ');

          If (Not fEmptyStrDicSis(strKeyDic)) Then
            qryDic.SQL.Add('AND DIC_KEYDIC = :DIC_KEYDIC ');

          If (Not fEmptyStrDicSis(strTipDic)) Then
            qryDic.ParamByName('DIC_TIPDIC').Value := strTipDic;

          If (Not fEmptyStrDicSis(strKeyDic)) Then
            qryDic.ParamByName('DIC_KEYDIC').Value := strKeyDic;
        End;
        qryDic.Open;

        If (qryDic.IsEmpty) Then
        Begin
          If (Not blnCargaFull) Then
          Begin
            If (VS_dicDicSis.Count > 0) And (fEmptyStrDicSis(strTipDic+strKeyDic)) Then
            Begin
              VS_dicDicSis.Clear;
              VS_dicDicSis.TrimExcess;
            End
            Else If (VS_dicDicSis.ContainsKey(strKeyDic)) Then
            Begin
              VS_dicDicSis.Remove(strKeyDic)
            End;
          End;

          Exit;
        End;

        If (blnCargaFull) Then
        Begin
          qryDic.First;
          If (qryDic.Locate('DIC_PIDMD5', VS_PidMD5DicSis, [])) Then
          Begin
            qryAux := fCriaQueryDicSis(objConexao);
            Try
              //BUSCA VALORES/SITUAÇÃO DAS CFG'S ATUAL A PARTIR DO DICIONÁRIO PARA VER SE ESSE PRECISA SER ATUALIZADO
              qryAux.Close;
              qryAux.SQL.Clear;
              qryAux.SQL.Add(' SELECT "'+consTagValCfgSis+'" AS DIC_TIPDIC, SIS_CODEMP, SIS_CODCFG,        SIS_VALCFG FROM CFGSIS ');
              qryAux.SQL.Add('  WHERE SIS_CODCFG IN (SELECT DISTINCT SUBSTR(SUBSTR(DIC_KEYDIC, 5, LENGTH(DIC_KEYDIC)), 1 , POSITION("|" IN SUBSTR(DIC_KEYDIC, 5, LENGTH(DIC_KEYDIC)))-1) FROM DICSIS WHERE DIC_TIPDIC = "'+consTagValCfgSis+'" AND DIC_PIDMD5 = "'+VS_PidMD5DicSis+'") ');
              qryAux.SQL.Add('    AND SIS_CODEMP IN (SELECT DISTINCT RIGHT(DIC_KEYDIC, 3) FROM DICSIS WHERE DIC_TIPDIC = "'+consTagValCfgSis+'" AND DIC_PIDMD5 = "'+VS_PidMD5DicSis+'") ');
              qryAux.SQL.Add(' UNION ALL ');
              qryAux.SQL.Add(' SELECT "'+consTagCfgExiste+'" AS DIC_TIPDIC, SIS_CODEMP, SIS_CODCFG, "S" AS SIS_VALCFG FROM CFGSIS ');
              qryAux.SQL.Add('  WHERE SIS_CODCFG IN (SELECT DISTINCT SUBSTR(SUBSTR(DIC_KEYDIC, 5, LENGTH(DIC_KEYDIC)), 1 , POSITION("|" IN SUBSTR(DIC_KEYDIC, 5, LENGTH(DIC_KEYDIC)))-1) FROM DICSIS WHERE DIC_TIPDIC = "'+consTagCfgExiste+'" AND DIC_PIDMD5 = "'+VS_PidMD5DicSis+'") ');
              qryAux.SQL.Add('    AND SIS_CODEMP IN (SELECT DISTINCT RIGHT(DIC_KEYDIC, 3) FROM DICSIS WHERE DIC_TIPDIC = "'+consTagCfgExiste+'" AND DIC_PIDMD5 = "'+VS_PidMD5DicSis+'"); ');

              qryAux.Open;
              qryAux.First;
              While Not qryAux.Eof Do
              Begin
                If (qryAux.FieldByName('DIC_TIPDIC').AsString = consTagValCfgSis) Then
                Begin
                  dicCfgSisAtual.AddOrSetValue(fFormataKeyValCfgParaDicSis(qryAux.FieldByName('SIS_CODCFG').AsString, qryAux.FieldByName('SIS_CODEMP').AsString), qryAux.FieldByName('SIS_VALCFG').AsString);
                End
                Else If (qryAux.FieldByName('DIC_TIPDIC').AsString = consTagCfgExiste) Then
                Begin
                  dicCfgSisAtual.AddOrSetValue(fFormataKeyCfgExiParaDicSis(qryAux.FieldByName('SIS_CODCFG').AsString, qryAux.FieldByName('SIS_CODEMP').AsString), qryAux.FieldByName('SIS_VALCFG').AsString);
                End;

                qryAux.Next;
              End;
            Finally
              qryAux.Close;
              FreeAndNil(qryAux);
            End;
          End;
        End;

        qryDic.First;
        While Not qryDic.Eof Do
        Begin
          If (blnCargaFull) Then
          Begin
            If (qryDic.FieldByName('DIC_TEMPO_').AsInteger >= consIntervalorMinimoParaVerificaoDicSis) Then
            Begin
              If (fEhDicSisPorPidMd5(qryDic.FieldByName('DIC_TIPDIC').AsString)) Then
              Begin
                intTmp := consIntervalorMinimoCfgSisForaAlteradas;

                If (qryDic.FieldByName('DIC_TEMPO_').AsInteger >= intTmp) Then
                Begin
                  If (qryDic.FieldByName('DIC_TIPDIC').AsString = consTagValCfgSis) Then
                  Begin
                    //EX: DIC_KEYDIC = CFG|CFG_AGRDUP|007
                    blnLocalizou := dicCfgSisAtual.TryGetValue(qryDic.FieldByName('DIC_KEYDIC').AsString, strSisValCfg);
                    If ((blnLocalizou) And (qryDic.FieldByName('DIC_VALDIC').AsString = strSisValCfg)) Or
                       (Not blnLocalizou) {SE NÃO LOCALIZOU É PORQUE A CFG NÃO EXISTE NA EMPRESA, ENTÃO, DEVE PERMANECER O QUE ESTÁ NO DICSIS} Then
                    Begin
                      pAddListUpd;
                    End
                    Else
                    Begin
                      pAddListDel;
                      qryDic.Next;
                      Continue;
                    End;
                  End
                  Else If (qryDic.FieldByName('DIC_TIPDIC').AsString = consTagCfgExiste) Then
                  Begin
                    //EX: DIC_KEYDIC = CEX|CFG_AGRDUP|007
                    blnLocalizou := dicCfgSisAtual.TryGetValue(qryDic.FieldByName('DIC_KEYDIC').AsString, strSisValCfg);
                    If ((blnLocalizou) And (qryDic.FieldByName('DIC_VALDIC').AsString = 'S')) Or
                       ((Not blnLocalizou) And (qryDic.FieldByName('DIC_VALDIC').AsString = 'N')) Then
                    Begin
                      pAddListUpd;
                    End
                    Else
                    Begin
                      pAddListDel;
                      qryDic.Next;
                      Continue;
                    End;
                  End;
                End;
              End
              Else If (fEhDicSisPorPidGen(qryDic.FieldByName('DIC_TIPDIC').AsString)) Then
              Begin
                If (qryDic.FieldByName('DIC_VALDIC').AsString = 'S') Or (MatchStr(qryDic.FieldByName('DIC_KEYDIC').AsString, arrOld)) Then
                  intTmp := consIntervalorMinimoTabCmpDeixouExistir
                Else
                  intTmp := consIntervalorMinimoTabCmpPassouExistir;

                If (qryDic.FieldByName('DIC_TEMPO_').AsInteger >= intTmp) Then
                Begin
                  If (qryDic.FieldByName('DIC_TIPDIC').AsString = consTagTabExiste) Then
                  Begin
                    //EX: DIC_KEYDIC = TAB|XMLSAT
                    strTab := fGetValorPipeDisSis(qryDic.FieldByName('DIC_KEYDIC').AsString,'|',2);
                    strVal := fBooleanToStringDisSis(fTabelaCampoExiste(objConexao, strTab));

                    If (qryDic.FieldByName('DIC_VALDIC').AsString = strVal) Then
                    Begin
                      pAddListUpd;
                    End
                    Else
                    Begin
                      pAddListDel;
                      qryDic.Next;
                      Continue;
                    End;
                  End
                  Else If (qryDic.FieldByName('DIC_TIPDIC').AsString = consTagCmpExiste) Then
                  Begin
                    //EX: DIC_KEYDIC = CMP|XMLSAT|XML_MSGRET
                    strTab := fGetValorPipeDisSis(qryDic.FieldByName('DIC_KEYDIC').AsString,'|',2);
                    strCmp := fGetValorPipeDisSis(qryDic.FieldByName('DIC_KEYDIC').AsString,'|',3);
                    strVal := fBooleanToStringDisSis(fTabelaCampoExiste(objConexao, strTab, strCmp));

                    If (qryDic.FieldByName('DIC_VALDIC').AsString = strVal) Then
                    Begin
                      pAddListUpd;
                    End
                    Else
                    Begin
                      pAddListDel;
                      qryDic.Next;
                      Continue;
                    End;
                  End;
                End;
              End;
            End;
          End;

          If IIF(blnCargaFull, True, (qryDic.FieldByName('DIC_TEMPO_').AsInteger < consIntervalorMinimoParaVerificaoDicSis)) Then
          Begin
            VS_dicDicSis.AddOrSetValue(qryDic.FieldByName('DIC_KEYDIC').AsString,
                                       qryDic.FieldByName('DIC_VALDIC').AsString);
          End;

          qryDic.Next;
        End;

        If (blnCargaFull) Then
        Begin
          If (SLKeyDicSisUpd.Count > 0) Then
          Begin
            //SOMENTE ATUALIZA A DATA
            pProcessaListaDisSis(objConexao, SLKeyDicSisUpd, apaUpdate);
          End;

          If (SLKeyDicSisDel.Count > 0) Then
          Begin
            //BUSCA OS NOVOS VALORES
            pProcessaListaDisSis(objConexao, SLKeyDicSisDel, apaDelete);

            For intIdx := 0 To SLKeyDicSisDel.Count-1 Do
            Begin
              //EX: SLKeyDicSisDel[intIdx] = 5AA46541D672FA292E99AB9A16FB48FE|CMP|XMLSAT|XML_MSGRET
              strMd5    := fGetValorPipeDisSis(SLKeyDicSisDel[intIdx],'|',1);
              strTip    := fGetValorPipeDisSis(SLKeyDicSisDel[intIdx],'|',2);
              strKeyAux := fExtraiSomenteKey(SLKeyDicSisDel[intIdx], strMd5);
              strVal := '';
              strKey := '';

              If fEhDicSisPorPidMd5(strTip) Then
              Begin
                If (strTip = consTagValCfgSis) Then
                Begin
                  //EX: strKeyAux = CFG|CFG_AGRDUP|007
                  If (dicCfgSisAtual.TryGetValue(strKeyAux, strSisValCfg)) Then
                  Begin
                    strKey := strKeyAux;
                    strVal := strSisValCfg
                  End;
                End
                Else If (strTip = consTagCfgExiste) Then
                Begin
                  //EX: strKeyAux = CEX|CFG_AGRDUP|007
                  strKey := strKeyAux;
                  If (dicCfgSisAtual.TryGetValue(strKeyAux, strSisValCfg)) Then
                    strVal := 'S'
                  Else
                    strVal := 'N';
                End;
              End
              Else If fEhDicSisPorPidGen(strTip) Then
              Begin
                If (strTip = consTagTabExiste) Then
                Begin
                  //EX: strKeyAux = TAB|XMLSAT
                  strTab := fGetValorPipeDisSis(strKeyAux,'|',2);
                  strVal := fBooleanToStringDisSis(fTabelaCampoExiste(objConexao, strTab));

                  strKey := fFormataKeyTabExiParaDicSis(strTab);
                End
                Else If (strTip = consTagCmpExiste) Then
                Begin
                  //EX: strKeyAux = CMP|XMLSAT|XML_MSGRET
                  strTab := fGetValorPipeDisSis(strKeyAux,'|',2);
                  strCmp := fGetValorPipeDisSis(strKeyAux,'|',3);
                  strVal := fBooleanToStringDisSis(fTabelaCampoExiste(objConexao, strTab, strCmp));

                  strKey := fFormataKeyCmpExiParaDicSis(strTab, strCmp);
                End;
              End;

              If ((strVal <> '') And (strKey <> '')) Then
                pInsereDicSis(objConexao, strKey, strVal);
            End;
          End;
        End;
      Except
        On E: Exception Do
        Begin
          pDesativaDicSis(objConexao);

          pLogImp(E.Message + ' [pCarregaDicSis]');
        End;
      End;
    Finally
      If (blnCargaFull) Then
      Begin
        VS_hraDicSis := Time;
      End;

      FreeAndNil(qryDic);
      FreeAndNil(SLKeyDicSisUpd);
      FreeAndNil(SLKeyDicSisDel);
      FreeAndNil(dicCfgSisAtual);
    End;
  End;
end;

procedure pInsereDicSis(objConexao: TUniConnection; const strKeyDic: string; const strValDic: string);
  Var
    qryGen: TUniQuery;
    strTipDic: string;
    strPidMd5: string;
    blnComTransacao: Boolean;
begin
  If (fPodeLerOuGrvDicSis(objConexao, strKeyDic)) Then
  Begin
    VS_dicDicSis.AddOrSetValue(strKeyDic, strValDic);

    If (Not fEmptyStrDicSis(VS_PidMD5DicSis)) Then
    Begin
      strTipDic := fGetValorPipeDisSis(strKeyDic,'|',1);
      strPidMd5 := IIF(fEhDicSisPorPidGen(strTipDic), VS_PidGenerico_, VS_PidMD5DicSis);

      qryGen := fCriaQueryDicSis(objConexao);
      Try
        qryGen.SQL.Text := 'REPLACE INTO DICSIS (DIC_PIDMD5, DIC_TIPDIC, DIC_KEYDIC, DIC_VALDIC) VALUES(:DIC_PIDMD5, :DIC_TIPDIC, :DIC_KEYDIC, :DIC_VALDIC);';
        qryGen.ParamByName('DIC_PIDMD5').Value := strPidMd5;
        qryGen.ParamByName('DIC_TIPDIC').Value := strTipDic;
        qryGen.ParamByName('DIC_KEYDIC').Value := strKeyDic;
        qryGen.ParamByName('DIC_VALDIC').Value := strValDic;

        blnComTransacao := (Not objConexao.InTransaction);
        Try
          If blnComTransacao Then
            fStartTransactionDicSis(objConexao);

          qryGen.ExecSQL;

          If blnComTransacao Then
            fCommitDicSis(objConexao)
        Except
          On E: Exception Do
          Begin
            If blnComTransacao Then
              fRollBackDicSis(objConexao);

            pDesativaDicSis(objConexao);

            pLogImp(E.Message + ' [pInsereDicSis]');
          End;
        End;
      Finally
        FreeAndNil(qryGen)
      End;
    End;
  End;
end;

function fAchouDicSisBln(objConexao: TUniConnection; const strKeyDic: string; out outBln: Boolean): Boolean;
begin
  Result := False;

  If (fPodeLerOuGrvDicSis(objConexao, strKeyDic)) Then
  Begin
    pAtualizarDicSisSeNecessario(objConexao);

    If VS_dicDicSis.ContainsKey(strKeyDic) Then
    Begin
      Result := True;
      outBln := fStringToBooleanDicSis(VS_dicDicSis[strKeyDic]);
    End;
  End;
end;

function fAchouDicSisStr(objConexao: TUniConnection; const strKeyDic: string; out outStr: string): Boolean;
begin
  Result := False;

  If (fPodeLerOuGrvDicSis(objConexao, strKeyDic)) Then
  Begin
    pAtualizarDicSisSeNecessario(objConexao);

    If VS_dicDicSis.ContainsKey(strKeyDic) Then
    Begin
      Result := True;
      outStr := VS_dicDicSis[strKeyDic];
    End;
  End;
end;

function fRetListaArrOld: String;
  Var
    strKey: String;
begin
  Result := '';
  For strKey In arrOld Do
    Result := Result + IIF(Result='','',',') + '"' + strKey + '"';
end;

function fPodeLerOuGrvDicSis(objConexao: TUniConnection; const strKeyDic: string): Boolean;
  Var
    strTipDic: string;
    strCodCfg: string;
begin
  Result := True;

  //EX: strKeyDic = CEX|CFG_UFSFCP|007
  //EX: strKeyDic = CFG|CFG_ZEIBPT|007
  strTipDic := fGetValorPipeDisSis(strKeyDic,'|',1);
  strCodCfg := fGetValorPipeDisSis(strKeyDic,'|',2);

  If (fEhDicSisPorPidMd5(strTipDic)) Then
  Begin
    If (fEmptyStrDicSis(VS_PidMD5DicSis)) Then
    Begin
      Result := False;
    End
    Else
    Begin
      pCarregaArrIgn(objConexao); //CARREGA AS CONFIGURAÇÕES QUE NÃO PODEM ENTRAR EM CACHE

      If MatchStr(strCodCfg, arrIgn) Then
        Result := False;
    End;
  End;
end;

procedure pGravaConfiguraoesInicializacao(objConexao: TUniConnection; const dicConfigInicial: TDictionary<string,boolean>);
  Var
    intIdx: Integer;
    qryGen: TUniQuery;
    blnComTransacao: Boolean;
begin
  If Assigned(dicConfigInicial) Then
  Begin
    qryGen := fCriaQueryDicSis(objConexao);
    Try
      qryGen.SQL.Clear;
      For intIdx := 0 To dicConfigInicial.Count-1 Do
      Begin
        If dicConfigInicial.ToArray[intIdx].Value Then
        Begin
          If (qryGen.SQL.Count = 0) Then
            qryGen.SQL.Add('REPLACE INTO DICSIS (DIC_PIDMD5, DIC_TIPDIC, DIC_KEYDIC, DIC_VALDIC) VALUES ');

          qryGen.SQL.Add(IIF(qryGen.SQL.Count = 1, '', ',')+'('+VS_PidGenerico_.QuotedString+','+consTagLogCodCfg.QuotedString+','+fFormataKeyLogCfgParaDicSis(dicConfigInicial.ToArray[intIdx].Key).QuotedString+',"CONFIGURAÇÕES DE INICIALIZAÇÃO")');
        End;
      End;
    Finally
      If (qryGen.SQL.Text <> '') Then
      Begin
        blnComTransacao := (Not objConexao.InTransaction);
        Try
          If blnComTransacao Then
            fStartTransactionDicSis(objConexao);

          qryGen.ExecSQL;

          If blnComTransacao Then
            fCommitDicSis(objConexao)
        Except
          //
        End;
      End;
      FreeAndNil(qryGen);
    End;
  End;
end;
{$IFEND}

{ TQueryLog }
class procedure TQueryLog.BeforeOpen(DataSet: TDataSet);
begin
  pLogSQL({$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND}(DataSet));
end;

class procedure TQueryLog.BeforeExecute(Sender: TObject);
begin
  pLogSQL({$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(LINUX)} TUniQuery {$ELSE} TZQuery {$IFEND}(Sender));
end;

initialization
  VS_strCodPnlDir := '';
  VS_PidGenerico_ := '';
  VS_PidMD5DicSis := '';
  {$IF Defined(UNIDAC) Or Defined(LINUX)}
  VS_PidGenerico_ := StringOfChar('0', 32);
  VS_dicDicSis := TDictionary<string, string>.Create;
  VS_hraDicSis := Time;
  {$IFEND}
  {$IF RTLVersion >= 28}
  arrIgn := [];
  {$IFEND}

finalization
  {$IF Defined(UNIDAC) Or Defined(LINUX)}
  FreeAndNil(VS_dicDicSis);
  {$IFEND}
end.
