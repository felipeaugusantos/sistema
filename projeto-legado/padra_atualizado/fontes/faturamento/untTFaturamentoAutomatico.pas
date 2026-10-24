unit untTFaturamentoAutomatico;

interface

uses
  DB,
  Uni,
  Classes,
  SysUtils,
  StrUtils,
  untLegenda,
  untTypesCRM,
  Vcl.ExtCtrls,
  Winapi.Windows,
  untUtilMonitor,
  untFuncFat,
  untFuncFatTypes,
  untTypesSistema,
  UniClientDataSet,
  untFuncoesSimples,
  System.Generics.Collections,
  Faturamento.Classes.TFaturador.Base,
  Faturamento.Classes.TFaturador.EmitirNFe,
  Faturamento.Classes.TFaturador.EmitirNFCe;

Const
  IdMonitorFaturamentoAutomatico = 'MONITOR_FATURAMENTO_AUTOMATICO_%s_%s';
  IdInactivityMonitorFaturamentoAutomatico = 'TESTE_INATIVIDADE_%s';
  FaturamentoAutomaticoMonitorExeName = 'autcom.exe';
  FaturamentoAutomaticoMonitorExeParam = 'FATURAMENTO_AUTOMATICO';
  TimeLimitMonitorFaturamentoAutomatico = 9999;
  AttemptsLockMonitorFaturamentoAutomatico = 30;
  MinutosNovaTentativaFaturamentoAutomatico = 10;

  { Instruções SQL }
  sqlPedidosParaFaturamentoAutomatico =
    '  SELECT DISTINCT ' +
    '    FATAUT.* ' +
    '  FROM ' +
    '    FATGOR ' +
    '    INNER JOIN EXTGOR ' +
    '      ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    '    INNER JOIN FATAUT ' +
    '      ON FGO_NUMDOC = FAT_NUMDOC AND ' +
    '         FGO_ESPDOC = FAT_ESPDOC AND ' +
    '         FGO_CODEMP = FAT_EMPDOC ' +
    '  WHERE FGO_JAFATU = 0 ' +
    '    AND FGO_ESPDOC = "PD" ' +
    '    AND FGO_EMPEXP = :CODEMP ' +
    '    AND FAT_NUMFAT IS NULL ' +
    '    AND FGO_DTLBEX IS NULL ' + //Req: 425204
    '  ORDER BY FAT_LOGDTA, ' +
    '    AUTOINCREM ' +
    '  LIMIT 10; ' ;

  sqlPedidosNaoMarcadosComoFaturado =
    '    SELECT DISTINCT  ' +
    '      FATAUT.* ' +
    '    FROM ' +
    '      FATGOR ' +
    '      INNER JOIN EXTGOR ' +
    '        ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    '      INNER JOIN FATAUT ' +
    '        ON FGO_NUMDOC = FAT_NUMDOC ' +
    '        AND FGO_ESPDOC = FAT_ESPDOC ' +
    '        AND FGO_CODEMP = FAT_EMPDOC ' +
    '    WHERE FGO_JAFATU = 1 ' +
    '      AND FGO_ESPDOC = "PD" ' +
    '      AND FGO_EMPEXP = :CODEMP ' +
    '      AND FAT_NUMFAT IS NULL ' +
    '      AND FAT_DTAINS >= DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) ' +
    '    ORDER BY FAT_LOGDTA, ' +
    '      AUTOINCREM ' +
    '    LIMIT 10; ';

  sqlPedidosPendentesEtiquetaDespacho =
    '    SELECT DISTINCT  ' +
    '      FATAUT.* ' +
    '    FROM ' +
    '      FATGOR ' +
    '      INNER JOIN EXTGOR ' +
    '        ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    '      INNER JOIN FATAUT ' +
    '        ON FGO_NUMDOC = FAT_NUMDOC ' +
    '        AND FGO_ESPDOC = FAT_ESPDOC ' +
    '        AND FGO_CODEMP = FAT_EMPDOC ' +
    '    WHERE FGO_JAFATU = 1 ' +
    '      AND FGO_ESPDOC = "PD" ' +
    '      AND FGO_EMPEXP = :CODEMP ' +
    '      AND FAT_ETIMKP <> "" ' +
    '      AND FAT_ETIDTA IS NULL ' +
    '      AND FAT_DTAINS >= DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) ' +
    '    ORDER BY FAT_LOGDTA, ' +
    '      AUTOINCREM ' +
    '    LIMIT 10; ';

  sqlUpdateEtiquetaMarketplace =
    '    UPDATE ' +
    '      FATAUT A ' +
    '      JOIN FATGOR G ' +
    '        ON A.FAT_NUMDOC = G.FGO_NUMDOC ' +
    '        AND A.FAT_ESPDOC = G.FGO_ESPDOC ' +
    '        AND A.FAT_EMPDOC = G.FGO_CODEMP ' +
    '      JOIN CADTRA T ' +
    '        ON T.TRA_CODTRA = G.FGO_CODTRA ' +
    '    SET A.FAT_ETIMKP = T.TRA_ETIDES ' +
    '    WHERE TRUE ' +
    '      AND A.AUTOINCREM = "%s" ' +
    '      AND A.FAT_ETIMKP IS NULL ' +
    '      AND T.TRA_ETIDES IN ( ' +
    '        "MERCADO LIVRE", ' +
    '        "SHOPEE", ' +
    '        "MAGALU", ' +
    '        "VIA VAREJO", ' +
    '        "OLIST", ' +
    '        "AMAZON" ' +
    '      ); ';

type
  IParamFaturamentoAutomatico = Interface
    ['{05DE5C13-8550-4270-BC08-EE5A11BBF0C4}']
    function NumDoc(const AValue: String): IParamFaturamentoAutomatico; overload;
    function EspDoc(const AValue: String): IParamFaturamentoAutomatico; overload;
    function CodEmp(const AValue: String): IParamFaturamentoAutomatico; overload;
    function SmartPOS(const AValue: Boolean): IParamFaturamentoAutomatico; overload;
    function AutIncFatAut(const AValue: String): IParamFaturamentoAutomatico; overload;

    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function SmartPOS: Boolean; overload;
    function AutIncFatAut: String; overload;

    function fGetDocument: String;
  end;

  TParamFaturamentoAutomatico = class sealed(TInterfacedObject, IParamFaturamentoAutomatico)
  protected
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FSmartPOS: Boolean;
    FAutIncFatAut: String;

    constructor Create;
  public
    function NumDoc(const AValue: String): IParamFaturamentoAutomatico; overload;
    function EspDoc(const AValue: String): IParamFaturamentoAutomatico; overload;
    function CodEmp(const AValue: String): IParamFaturamentoAutomatico; overload;
    function SmartPOS(const AValue: Boolean): IParamFaturamentoAutomatico; overload;
    function AutIncFatAut(const AValue: String): IParamFaturamentoAutomatico; overload;

    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function SmartPOS: Boolean; overload;
    function AutIncFatAut: String; overload;

    function fGetDocument: String;

    class function New: IParamFaturamentoAutomatico;
  end;

  TFaturamentoAutomatico = class sealed(TInterfacedObject, IMonitorProcedure)
  private
    class var Mensagens: TStringList;
    class var FArrNFe: TFatDocInfoArray;
    class var NFe: TFatDocInfo;
    class var FatAutKey: String;
    class var FPathEtiqueta: String;
    class var FMarketplaceEtiqueta: String;
    class var FRetornoEnvioNFeMarketplace: String;
    class function fValidarConfiguracoes: Boolean;
    class procedure pGerarArqXmlPdf;
    class procedure pProcessarEnvioNFe;
    class procedure pProcessarStatusNFe(const AStatus: String = 'GE');
    class procedure pPrepararEtiquetaDespacho(ATimeout: Integer = 0);
    class procedure pProcessarBoletosNotaServico(AObjVenda: TFatVenda);
    class procedure pOnAfterFaturamento(AObjVenda: TFatVenda);
    class function fTravarFatAut(const AstrChave: String): Boolean;
    class procedure pLiberarFatAut(const AstrChave: String);
  private
    procedure ClearLog;
    function FaturarPedido: TFatDocInfoArray;
    function JaFaturado(var ANFe: TFatDocInfo): Boolean;
    function NFCancelada(const ANFe: TFatDocInfo): Boolean;
    function fValidarAutorizacaoNFe: Boolean;
  protected
    FParams: IParamFaturamentoAutomatico;
    constructor Create(AParams: IParamFaturamentoAutomatico);
    procedure pBeforeSetPontoImpressaoNFe(var APontoImpressao: String);
    procedure pAtualizarDadosFaturamento(AAutInc: String);
    procedure pAtualizaEiquetaMarketplace(AAutInc: String);
  public
    procedure pExecuteAll;
    procedure pExecute;
    function fExecute: TResultExecute;
    class procedure ExecutarRobo();
    class procedure AddLog(AText: String);
    class function New(AParams: IParamFaturamentoAutomatico = nil): IMonitorProcedure;
  end;

  TFaturamentoAutomaticoEmitirNFe = class(TEmitirNFe)
  protected
    procedure OnSetParametros; override;
  end;

  TFaturamentoAutomaticoEmitirNFCe = class(TEmitirNFCe)
  protected
    procedure OnSetParametros; override;
  end;

  TFaturamentoAutomaticoEmitirNFCeSmartPOS = class(TFaturamentoAutomaticoEmitirNFCe)
  protected
    procedure OnSetParametros; override;
  end;

Var
  VS_strLockMonitorFaturamentoAutomatico: String;
  VS_dtaUltimaExecucaoMonitorFaturamentoAutomatico: TDateTime;
  VS_objProcessoMonitorFaturamentoAutomatico: TProcessInformation;

implementation

uses
  untLibNFe,
  Vcl.Forms,
  untConstantes,
  System.UITypes,
  System.Variants,
  System.DateUtils,
  System.Generics.Defaults,
  Shared.Functions.DataSet,
  untImpEtiDespacho,
  untConstantesNFe,
  untFuncFatImp,
  untDicSis;

{ TFaturamentoAutomatico }

class procedure TFaturamentoAutomatico.AddLog(AText: String);
begin
  Self.Mensagens.Add(DateTimeToStr(fNow()) + ' - ' + AText);
end;

procedure TFaturamentoAutomatico.ClearLog;
begin
  Self.Mensagens.Clear;
end;

constructor TFaturamentoAutomatico.Create(AParams: IParamFaturamentoAutomatico);
begin
  FParams := AParams;
end;

function TFaturamentoAutomatico.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TFaturamentoAutomatico.fValidarAutorizacaoNFe: Boolean;
const
  TIMEOUT = 30;
var
  LBegin: TDateTime;
  LStatus: String;
  LTentativas: Integer;
begin
  Result := True;

  LBegin := fNow();

  LStatus := fPainelNFeStatusDocumento(Self.NFe.Numero, Self.NFe.Especie,  Self.NFe.Empresa, Self.NFe.Cliente, Self.NFe.Serie);

  Self.AddLog('Status da NFe no Painel: ' + LStatus);

  If LStatus.Equals('GE') Then
    pProcessarStatusNFe;

  If LStatus.Equals('EE') Then
    pProcessarEnvioNFe;

  If LStatus.Equals('AT') Then
  Begin
    For LTentativas := 1 To 5 Do
    Begin
      If (fExisteXMLNFeDocumento(Self.NFe.Numero, Self.NFe.Especie, Self.NFe.Empresa, Self.NFe.Cliente, Self.NFe.Serie)) Then
        Break
      Else
        pGerarArqXmlPdf;

      Sleep(1000);
    End;
  End;

  Repeat

    LStatus := fPainelNFeStatusDocumento(Self.NFe.Numero, Self.NFe.Especie,  Self.NFe.Empresa, Self.NFe.Cliente, Self.NFe.Serie);

    Self.AddLog('Status da NFe no Painel: ' + LStatus);

    If LStatus.Equals('AT') Then
    Begin
      Self.AddLog('NFe autorizada ...');
      Exit(True);
    End;

    If LStatus.Equals(EmptyStr) Then
    Begin
      Self.AddLog('NFe não existe no PainelNFe ...');
      Exit(False);
    End;

    If LStatus.Equals('EE') Then
    Begin
      Self.AddLog('Erro no envio da NFe ...');
      Exit(False);
    End;

    If LStatus.Equals('DN') Then
    Begin
      Self.AddLog('NFe denegada ...');
      Exit(False);
    End;

    If LStatus.Equals('CN') Then
    Begin
      Self.AddLog('NFe cancelada ...');
      Exit(False);
    End;

    If Self.FParams.SmartPOS then
      Break;

    Self.AddLog('Aguardando autorização da NFe ...');

    Sleep(500);

    If SecondsBetween(fNow(), LBegin) >= TIMEOUT then
      Break;

  Until False;

  If Not Result Then
    Self.AddLog('Timeout - Status da NFe: ' + LStatus);
end;

class function TFaturamentoAutomatico.fValidarConfiguracoes: Boolean;
begin
  If Not fCfgSis('FATAUT', varBoolean) Then
    Exit(False);

  If Not fCfgSis('NFEUSA', VarBoolean) Then
    Exit(False);

  If Not fCfgSis('PNLNFE', VarBoolean) Then
    Exit(False);

  If TOSVersion.ToString.ToUpper.Contains('WINDOWS 7') Then
    Exit(False);

  //REQ.: 305545
  If Not fValidarCFG_TXJCNI Then
    Exit(False);

  Result := True;
end;

function TFaturamentoAutomatico.JaFaturado(var ANFe: TFatDocInfo): Boolean;
var
  LFatAut: IMyCampoTabela;
begin
  LFatAut := fCampoTabela(['FAT_NUMFAT', 'FAT_TIPFAT', 'FAT_EMPFAT', 'FAT_CLIFAT', 'FAT_SERFAT'], 'FATAUT',
                          ['FAT_NUMDOC', 'FAT_ESPDOC', 'FAT_EMPDOC'],
                          [FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp()]);

  If Not LFatAut.FieldByName('FAT_NUMFAT').AsString.IsEmpty Then
  Begin
    ANFe.Numero  := LFatAut.FieldByName('FAT_NUMFAT').AsString;
    ANFe.Especie := LFatAut.FieldByName('FAT_TIPFAT').AsString;
    ANFe.Empresa := LFatAut.FieldByName('FAT_EMPFAT').AsString;
    ANFe.Cliente := LFatAut.FieldByName('FAT_CLIFAT').AsString;
    ANFe.Serie   := LFatAut.FieldByName('FAT_SERFAT').AsString;
    Exit(True);
  End;

  If fRetornaInformacaoVenda(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp(), 'FGO_JAFATU').Equals('1') Then
  Begin
    ANFe.Numero  := fRetornaInformacaoVenda(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp(), 'FGO_NUMFAT');
    ANFe.Especie := fRetornaInformacaoVenda(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp(), 'FGO_TIPFAT');
    ANFe.Empresa := fRetornaInformacaoVenda(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp(), 'FGO_EMPFAT');
    ANFe.Cliente := fRetornaInformacaoVenda(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp(), 'FGO_CODCLI');
    ANFe.Serie   := fRetornaInformacaoVenda(NFe.Numero, NFe.Especie, NFe.Empresa, NFe.Cliente   , 'GER_SERIE_');
    Exit(True);
  End;

  Result := False;
end;

class procedure TFaturamentoAutomatico.ExecutarRobo;
Var
  LId: String;
begin
  If Not fValidarConfiguracoes Then
    Exit;

  LId := Format(IdMonitorFaturamentoAutomatico, [VS_strCodEmp, strLoginUsuarioLogado]);

  TUtilMonitor.pTestInactivity(IdInactivityMonitorFaturamentoAutomatico,
    TimeLimitMonitorFaturamentoAutomatico, VS_objProcessoMonitorFaturamentoAutomatico,
    VS_dtaUltimaExecucaoMonitorFaturamentoAutomatico);

  If fQuantidadeRobosDeMonitaramentoExecutando(Format(IdMonitorFaturamentoAutomatico, [VS_strCodEmp, '%'])) < fCfgSisL('MAXFAU', VarInteger) Then
    TUtilMonitor.pRunMonitor(LId, VS_objProcessoMonitorFaturamentoAutomatico,
      VS_dtaUltimaExecucaoMonitorFaturamentoAutomatico, ExtractFileName(ParamStr(0)),
        Concat(FaturamentoAutomaticoMonitorExeParam, ' ', VS_strCodEmp, ' ', strLoginUsuarioLogado));

  TUtilMonitor.pClearAttemptsLock(LId, AttemptsLockMonitorFaturamentoAutomatico);
end;

function TFaturamentoAutomatico.FaturarPedido: TFatDocInfoArray;
var
  objFaturador: TFaturadorBase;
begin
  if FParams.SmartPOS then
    objFaturador := TFaturamentoAutomaticoEmitirNFCeSmartPOS.Create(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp())
  else
    objFaturador := TFaturamentoAutomaticoEmitirNFe.Create(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp());
  try
    objFaturador.strAutIncFaturadorAutomatico := FParams.AutIncFatAut();
    objFaturador.OnAfterFaturamento := pOnAfterFaturamento;
    objFaturador.FaturarDocumento();
    Result := objFaturador.arrDocumentosEmitidos;
  finally
    objFaturador.Free;
  end;
end;

class function TFaturamentoAutomatico.New(AParams: IParamFaturamentoAutomatico = nil)
  : IMonitorProcedure;
begin
  Result := TFaturamentoAutomatico.Create(AParams);
end;

function TFaturamentoAutomatico.NFCancelada(const ANFe: TFatDocInfo): Boolean;
begin
  if fDocumentoCancelado(ANFe.Numero, ANFe.Especie, ANFe.Empresa, ANFe.Cliente, ANFe.Serie) then
    Exit(True);

  if fDocumentoInutilizado(ANFe.Numero, ANFe.Especie, ANFe.Empresa, ANFe.Cliente, ANFe.Serie) then
    Exit(True);

  Result := False;
end;

procedure TFaturamentoAutomatico.pBeforeSetPontoImpressaoNFe(
  var APontoImpressao: String);
begin
  APontoImpressao := PONTO_IMPRESSAO_NAO_IMPRIMIR;
end;

procedure TFaturamentoAutomatico.pExecute;
var
  LLoginUsuarioLogado: string;
  LTentativa: Integer;
begin
  If Not fValidarConfiguracoes Then
    Exit;

  If FParams.EspDoc() <> 'PD' Then
    Exit;

  Self.ClearLog;

  Try
    TLibNFe.OnBeforeSetPontoImpressao := Self.pBeforeSetPontoImpressaoNFe;
    Try
      Self.FPathEtiqueta := EmptyStr;
      Self.FMarketplaceEtiqueta := EmptyStr;
      Self.FRetornoEnvioNFeMarketplace := EmptyStr;

      FillChar(Self.NFe, SizeOf(Self.NFe), #0);

      If Not Self.JaFaturado(Self.NFe) Then
      Begin
        LLoginUsuarioLogado := strLoginUsuarioLogado;//Req: 337752
        Try
          strLoginUsuarioLogado := fCfgSis('OPEAUT');

          If fRetNomeOperador(strLoginUsuarioLogado).IsEmpty Then
            strLoginUsuarioLogado := LOG_ADM;

          pCarregarVariaveisUsuarioLogado;

          For LTentativa := 1 To 5 Do
          Begin
            Self.ClearLog;

            VS_TentativaFaturamentoAutomatico := True;
            Try
              VS_CallStackTentativaFaturamentoAutomatico := 'TFaturamentoAutomaticoMonitor.pExecute';
              Try
                Self.FArrNFe := Self.FaturarPedido;

                If Length(Self.FArrNFe) > 0 Then
                  Self.NFe := Self.FArrNFe[0];

                Break;
              Except
                On E: EAbort Do
                  Raise;
                On E: Exception Do
                Begin
                  Begin
                    If LTentativa = 5 Then
                    Begin
                      pGravarErro(True, E.Message, VS_CallStackTentativaFaturamentoAutomatico);
                      Raise;
                    End;
                  End;
                End;
              End;
            Finally
              VS_TentativaFaturamentoAutomatico := False;
            End;
          End;
        Finally
          strLoginUsuarioLogado := LLoginUsuarioLogado;
          pCarregarVariaveisUsuarioLogado;
        End;
      End;

      If Not Self.NFe.Numero.IsEmpty Then
      Begin
        If Not NFCancelada(Self.NFe) Then
          If Self.fValidarAutorizacaoNFe Then
            Self.pPrepararEtiquetaDespacho();
      End;
    Except
      On E: Exception Do
        Self.AddLog(E.Message);
    End;
  Finally
    TLibNFe.OnBeforeSetPontoImpressao := nil;
  End;
end;

procedure TFaturamentoAutomatico.pExecuteAll;
const
  SQL_PEDIDOS: Array[0..2] of String = (sqlPedidosNaoMarcadosComoFaturado,
    sqlPedidosParaFaturamentoAutomatico,  sqlPedidosPendentesEtiquetaDespacho);
var
  LQuery: TUniQuery;
  LUltimaTentativa: TDateTime;
  LSmartPOS: Boolean;
  LIdMonitor: String;
  LSQLPedidos: String;
begin
  If Not fValidarConfiguracoes Then
    Exit;

  LIdMonitor := Format(IdMonitorFaturamentoAutomatico, [VS_strCodEmp, strLoginUsuarioLogado]);

  For LSQLPedidos In SQL_PEDIDOS Do
  Begin
    if (fCfgSis('EXPFAU') <> 'S') Or (fCfgSis('IEDFAU') <> 'S') Then
      if LSQLPedidos = sqlPedidosPendentesEtiquetaDespacho then
        Continue;

    LQuery := fCriaQuery();
    Try
      LQuery.SQL.Add(LSQLPedidos);
      LQuery.ParamByName('CODEMP').AsString  := VS_strCodEmp;
      LQuery.Open();

      While (Not LQuery.Eof) Do
      Begin
        LUltimaTentativa := VS_Date;

        If Not LQuery.FieldByName('FAT_RETNFE').AsString.Contains('OK - 200') And
           Not LQuery.FieldByName('FAT_RETNFE').AsString.Contains('Nota Fiscal já enviada') And
           Not LQuery.FieldByName('FAT_LOGDTA').IsNull Then
        Begin
          LUltimaTentativa := LQuery.FieldByName('FAT_LOGDTA').AsDateTime;
        End;

        If MinutesBetween(fNow(), LUltimaTentativa) > MinutosNovaTentativaFaturamentoAutomatico Then
        Begin
          TFaturamentoAutomatico.FatAutKey := 'FATAUT_' + LQuery.FieldByName('AUTOINCREM').AsString;

          If TFaturamentoAutomatico.fTravarFatAut(TFaturamentoAutomatico.FatAutKey) Then
          Begin
            Try
              pAtualizaEiquetaMarketplace(LQuery.FieldByName('AUTOINCREM').AsString);

              LSmartPOS := Assigned(LQuery.FindField('FAT_SMART_')) and (LQuery.FieldByName('FAT_SMART_').AsString = 'S');

              TFaturamentoAutomatico.New(TParamFaturamentoAutomatico.New()
                .NumDoc(LQuery.FieldByName('FAT_NUMDOC').AsString)
                .EspDoc(LQuery.FieldByName('FAT_ESPDOC').AsString)
                .CodEmp(LQuery.FieldByName('FAT_EMPDOC').AsString)
                .SmartPOS(LSmartPOS)
                .AutIncFatAut(LQuery.FieldByName('AUTOINCREM').AsString)
              ).pExecute();

              pAtualizarDadosFaturamento(LQuery.FieldByName('AUTOINCREM').AsString);
              pZerarTentativasLock(LIdMonitor);

              Sleep(500);
              pTrimAppMemorySize();
            Finally
              TFaturamentoAutomatico.pLiberarFatAut(TFaturamentoAutomatico.FatAutKey);
            End;
          End;
        End;
        LQuery.Next();
      End;
    Finally
      FreeAndNil(LQuery);
    End;
  End;
end;

class procedure TFaturamentoAutomatico.pOnAfterFaturamento(AObjVenda: TFatVenda);
begin
  pProcessarBoletosNotaServico(AObjVenda);
end;

class function TFaturamentoAutomatico.fTravarFatAut(const AstrChave: String): Boolean;
const
  MAX_LOCK_KEY_LENGTH = 64;
var
  LqryLock: TUniQuery;
begin
  Result := False;

  If Length(AstrChave) > MAX_LOCK_KEY_LENGTH Then
  Begin
    pLog('fTravarFatAut: chave excede ' + IntToStr(MAX_LOCK_KEY_LENGTH) + ' chars: ' + AstrChave);
    Exit;
  End;

  LqryLock := fCriaQuery(Nil);
  Try
    LqryLock.SQL.Text := 'SELECT GET_LOCK(:CHAVE, 0) AS RESLOCK';
    LqryLock.ParamByName('CHAVE').AsString := AstrChave;
    LqryLock.Open;

    If LqryLock.FieldByName('RESLOCK').IsNull Then
    Begin
      pLog('fTravarFatAut: GET_LOCK retornou NULL para ' + AstrChave);
      Exit;
    End;

    Result := LqryLock.FieldByName('RESLOCK').AsInteger = 1;
  Finally
    FreeAndNil(LqryLock);
  End;
end;

class procedure TFaturamentoAutomatico.pLiberarFatAut(const AstrChave: String);
var
  LqryLock: TUniQuery;
  LResultado: Integer;
begin
  Try
    LqryLock := fCriaQuery(Nil);
    Try
      LqryLock.SQL.Text := 'SELECT RELEASE_LOCK(:CHAVE) AS RESLOCK';
      LqryLock.ParamByName('CHAVE').AsString := AstrChave;
      LqryLock.Open;

      If LqryLock.FieldByName('RESLOCK').IsNull Then
        pLog('pLiberarFatAut: RELEASE_LOCK retornou NULL (lock inexistente) para ' + AstrChave)
      Else
      Begin
        LResultado := LqryLock.FieldByName('RESLOCK').AsInteger;
        If LResultado <> 1 Then
          pLog('pLiberarFatAut: RELEASE_LOCK retornou ' + IntToStr(LResultado) + ' para ' + AstrChave);
      End;
    Finally
      FreeAndNil(LqryLock);
    End;
  Except
    On E: Exception Do
      pLog('pLiberarFatAut: excecao ao liberar ' + AstrChave + ': ' + E.Message);
  End;
end;

class procedure TFaturamentoAutomatico.pProcessarBoletosNotaServico(AObjVenda: TFatVenda);
var
  LIndex: Integer;
  LOpeLog: string;
  LImpressao: TFatVendaImp;
  LDocumento: TDadosImpressaoVenda;
begin
  if (Pos(fCfgSis('IMPBOL'), 'A_S_') = 0) then
    Exit;

  if fEmptyStr(fRetNomeOperador(fCfgSis('OPEAUT'))) then
    Exit;

  LImpressao := AObjVenda.objFatVendaImp;

  for LIndex := 0 to LImpressao.ItemsCount -1 do
  begin
    LDocumento := LImpressao[LIndex];

    if LDocumento.strEspDoc <> 'NS' then
      Continue;

    if not LImpressao.fVerificaSeImprimeBoleto(LDocumento) then
      Continue;

    LDocumento.blnEnvMai := LImpressao.fTemLayoutEmailBoletoAtivo(LDocumento);
    LDocumento.blnBolPdf := True;

    LOpeLog := strLoginUsuarioLogado;
    try
      strLoginUsuarioLogado := fCfgSis('OPEAUT');

      LImpressao.pImprimeBoletos(LDocumento);
    finally
      strLoginUsuarioLogado := LOpeLog;
    end;
  end;
end;

class procedure TFaturamentoAutomatico.pPrepararEtiquetaDespacho(ATimeout: Integer);
begin
  If Pos(Self.NFe.Especie, 'NF_EL_IF_IV_D1_MI_FF_TE_TR_BR_UC_PD_OR_') <= 0 Then
    Exit;

  If (fCfgSis('EXPFAU') <> 'S') Then
    Exit;

  If (fCfgSis('IEDFAU') <> 'S') Then
    Exit;

  Self.AddLog('Preparando Etiqueta de Despacho ...');
  Try
    pCriarFormularios(TfrmImpEtiDespacho, frmImpEtiDespacho);
    Try
      frmImpEtiDespacho.blnApenasGerarEtiqueta := True;
      frmImpEtiDespacho.edtNumDoc.Text := Self.NFe.Numero;
      frmImpEtiDespacho.edtEspDoc.Text := Self.NFe.Especie;
      frmImpEtiDespacho.edtCodEmp.Text := Self.NFe.Empresa;
      frmImpEtiDespacho.edtCodCli.Text := Self.NFe.Cliente;
      frmImpEtiDespacho.strCodCli      := Self.NFe.Cliente;
      frmImpEtiDespacho.edtQtdVol.Text := frmImpEtiDespacho.fCarregaVolume;
      frmImpEtiDespacho.intMarketplaceTimeout := ATimeout;
      frmImpEtiDespacho.btnConfirma.Click;
      Self.FPathEtiqueta := frmImpEtiDespacho.strPathEtiqueta;
      Self.FMarketplaceEtiqueta := frmImpEtiDespacho.strMarketplaceEtiqueta;
      Self.FRetornoEnvioNFeMarketplace := frmImpEtiDespacho.strRetornoEnvioNFeMarketplace;
    Finally
      pFreeAndNil(frmImpEtiDespacho);
    End;
  Except
    On E: Exception Do
      Self.AddLog(E.Message);
  End;
end;

procedure TFaturamentoAutomatico.pAtualizaEiquetaMarketplace(AAutInc: String);
begin
  fExecutaSQL(Format(sqlUpdateEtiquetaMarketplace, [AAutInc]), True);
end;

procedure TFaturamentoAutomatico.pAtualizarDadosFaturamento(AAutInc: String);
const
  sLine = '------------------------------------------------';
var
  LSQL: String;
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LSQL := '';
    LSQL := LSQL + ' UPDATE ';
    LSQL := LSQL + '   FATAUT ';
    LSQL := LSQL + ' SET ';
    LSQL := LSQL + '   FAT_LOGDTA = :LOGDTA, ';
    LSQL := LSQL + '   FAT_LOGMSG = CONCAT("...", CHAR(13), SUBSTRING_INDEX(TRIM(CONCAT(IFNULL(FAT_LOGMSG, ""), :LOGMSG)), CHAR(13), -100))  ';

    If Not Self.NFe.Numero.IsEmpty And Not NFCancelada(Self.NFe) Then
    Begin
      LSQL := LSQL + '   ,FAT_NUMFAT = :NUMFAT ';
      LSQL := LSQL + '   ,FAT_TIPFAT = :TIPFAT ';
      LSQL := LSQL + '   ,FAT_EMPFAT = :EMPFAT ';
      LSQL := LSQL + '   ,FAT_CLIFAT = :CLIFAT ';
      LSQL := LSQL + '   ,FAT_SERFAT = :SERFAT ';
      LSQL := LSQL + '   ,FAT_SEQGER = :SEQGER ';
    End;

    If Not Self.FMarketplaceEtiqueta.IsEmpty Then
      LSQL := LSQL + '   ,FAT_ETIMKP = :ETIMKP ';

    If Not Self.FPathEtiqueta.IsEmpty Then
    Begin
      LSQL := LSQL + '   ,FAT_ETIPAT = :ETIPAT ';
      LSQL := LSQL + '   ,FAT_ETIDTA = :ETIDTA ';
    End;

    If Not Self.FRetornoEnvioNFeMarketplace.IsEmpty Then
      LSQL := LSQL + '   ,FAT_RETNFE = :RETNFE ';

    LSQL := LSQL + ' WHERE AUTOINCREM = :AUTINC ';

    LQuery.SQL.Text := LSQL;

    LQuery.ParamByName('LOGDTA').AsDateTime := fNow();

    LQuery.ParamByName('LOGMSG').AsString := sLineBreak +
      StringOfChar('-', 100) + sLineBreak + Self.Mensagens.Text;

    If Not Self.NFe.Numero.IsEmpty And Not NFCancelada(Self.NFe) Then
    Begin
      LQuery.ParamByName('NUMFAT').AsString := Self.NFe.Numero;
      LQuery.ParamByName('TIPFAT').AsString := Self.NFe.Especie;
      LQuery.ParamByName('EMPFAT').AsString := Self.NFe.Empresa;
      LQuery.ParamByName('CLIFAT').AsString := Self.NFe.Cliente;
      LQuery.ParamByName('SERFAT').AsString := Self.NFe.Serie;
      LQuery.ParamByName('SEQGER').AsString := fRetornaInformacaoVenda(
        NFe.Numero, NFe.Especie, NFe.Empresa, NFe.Cliente, 'AUTOINCREM');
      If LQuery.ParamByName('SEQGER').AsString.IsEmpty Then
        LQuery.ParamByName('SEQGER').Clear;
    End;

    If Not Self.FMarketplaceEtiqueta.IsEmpty Then
      LQuery.ParamByName('ETIMKP').AsString := Self.FMarketplaceEtiqueta;

    If Not Self.FPathEtiqueta.IsEmpty Then
    Begin
      LQuery.ParamByName('ETIPAT').AsString := Self.FPathEtiqueta;
      LQuery.ParamByName('ETIDTA').AsDateTime := fNow();
    End;

    If Not Self.FRetornoEnvioNFeMarketplace.IsEmpty Then
      LQuery.ParamByName('RETNFE').AsString := Self.FRetornoEnvioNFeMarketplace;

    LQuery.ParamByName('AUTINC').AsString := AAutInc;

    LQuery.ExecSQL;
  Finally
    FreeAndNil(LQuery);
  End;
end;

class procedure TFaturamentoAutomatico.pProcessarStatusNFe(const AStatus: String);
var
  LPathExe: String;
  LParams: String;
begin
  If (NFe.Especie = 'NS') Then
  Begin
    If (fTemNotaServicoAnteriorPendente(NFe.Numero, NFe.Empresa)) Then
    Begin
      Self.AddLog('Existe(m) nota(s) de serviços anteriores ainda não autorizadas.');
      Exit;
    End;
  End;

  LParams := fTagComValorToParam('NFE_PROCESSAR_STATUS', consTagParamsTrf) +
             fTagComValorToParam(NFe.Numero,             consTagParamsDoc) +
             fTagComValorToParam(NFe.Especie,            consTagParamsEsp) +
             fTagComValorToParam(NFe.Empresa,            consTagParamsEmp) +
             fTagComValorToParam(NFe.Serie,              consTagParamsSer) +
             fTagComValorToParam(NFe.Cliente,            consTagParamsCli) +
             fTagComValorToParam('C',                    consTagParamsTfc) +
             fTagComValorToParam(AStatus,                consTagParamsSta) +
             fTagComValorToParam(VS_PidMD5DicSis,        consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

  Self.AddLog('Processar Status NFe ' + AStatus);
  LPathExe := ExtractFilePath(Application.ExeName) + 'NFeStatus.exe';
  If FileExists(LPathExe) Then
  Begin
    LPathExe := LPathExe + LParams;
    Self.AddLog('WinExec -> ' + LPathExe);
    WinExec(PAnsiChar(AnsiString(LPathExe)), SW_HIDE);
  End
  Else
    Self.AddLog('NFeStatus.exe não encontrado no diretório.');
end;

class procedure TFaturamentoAutomatico.pGerarArqXmlPdf;
var
  LPathExe: String;
  LParams: String;
  LTipo: String;
  LEmpresa: String;
  LImpressora: String;
  LChaveAcesso: String;
  LNumSer: String;
begin
  If (NFe.Especie = 'NS') Then
  Begin
    If (fTemNotaServicoAnteriorPendente(NFe.Numero, NFe.Empresa)) Then
    Begin
      Self.AddLog('Existe(m) nota(s) de serviços anteriores ainda não autorizadas.');
      Exit;
    End;
  End;

  If (NFe.Especie = 'NF') Then
    LTipo := 'NFE'
  Else If (NFe.Especie = 'NS') Then
    LTipo := 'NFS'
  Else
    LTipo := 'NFCE';

  LTipo        := LTipo + '_GERAR_PDF';
  LEmpresa     := NFe.Empresa;
  LImpressora  := 'NENHUMA';

  LChaveAcesso :=  fRetornaChaveAcesso(NFe.Numero, NFe.Especie, NFe.Empresa, NFe.Cliente, NFe.Serie, 'C', LNumSer);

  LParams := fTagComValorToParam(LTipo,           consTagParamsTrf) +
             fTagComValorToParam(LEmpresa,        consTagParamsEmp) +
             fTagComValorToParam(LChaveAcesso,    consTagParamsChv) +
             fTagComValorToParam(LImpressora,     consTagParamsImp) +
             fTagComValorToParam(VS_PidMD5DicSis, consTagParamsPid, mpiNaoIncluirTagSeValorVazio);

  Self.AddLog('Gerar XML/PDF');
  LPathExe := ExtractFilePath(Application.ExeName) + 'NFeImpressao.exe';
  If FileExists(LPathExe) Then
  Begin
    LPathExe := LPathExe + LParams;
    Self.AddLog('WinExec -> ' + LPathExe);
    WinExec(PAnsiChar(AnsiString(LPathExe)), SW_HIDE);
  End
  Else
    Self.AddLog('NFeImpressao.exe não encontrado no diretório.');
end;

class procedure TFaturamentoAutomatico.pProcessarEnvioNFe;
begin
  Self.AddLog('Processar Envio NFe');

  fExecutaSQL(Format(
    ' UPDATE LOGNFE SET NFE_STATUS = "%s", NFE_PONIMP = "%s" ' +
    ' WHERE NFE_NUMDOC = "%s" ' +
    '   AND NFE_ESPDOC = "%s" ' +
    '   AND NFE_CODEMP = "%s" ' +
    '   AND NFE_CODCLI = "%s" ' +
    '   AND NFE_SERIE_ = "%s" ', ['AE', PONTO_IMPRESSAO_NAO_IMPRIMIR, NFe.Numero, NFe.Especie,  NFe.Empresa, NFe.Cliente, NFe.Serie]));

  pProcessarStatusNFe('AE');
end;

{ TParamFaturamentoAutomatico }

function TParamFaturamentoAutomatico.AutIncFatAut(const AValue: String): IParamFaturamentoAutomatico;
begin
  FAutIncFatAut := AValue;
  Result := Self;
end;

function TParamFaturamentoAutomatico.AutIncFatAut: String;
begin
  Result := FAutIncFatAut;
end;

function TParamFaturamentoAutomatico.CodEmp: String;
begin
  Result := FCodEmp;
end;

constructor TParamFaturamentoAutomatico.Create;
begin
  FCodEmp := '';
  FNumDoc := '';
  FEspDoc := '';
end;

function TParamFaturamentoAutomatico.CodEmp(const AValue: String): IParamFaturamentoAutomatico;
begin
  FCodEmp := AValue;
  Result := Self;
end;

function TParamFaturamentoAutomatico.SmartPOS: Boolean;
begin
  Result := FSmartPOS;
end;

function TParamFaturamentoAutomatico.SmartPOS(const AValue: Boolean): IParamFaturamentoAutomatico;
begin
  FSmartPOS := AValue;
  Result := Self;
end;

function TParamFaturamentoAutomatico.EspDoc: String;
begin
  Result := FEspDoc;
end;

function TParamFaturamentoAutomatico.fGetDocument: String;
begin
  Result := Concat(FNumDoc, '-', FEspDoc, '-', FCodEmp);
end;

function TParamFaturamentoAutomatico.EspDoc(const AValue: String): IParamFaturamentoAutomatico;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TParamFaturamentoAutomatico.NumDoc(const AValue: String): IParamFaturamentoAutomatico;
begin
  FNumDoc := AValue;
  Result := Self;
end;

class function TParamFaturamentoAutomatico.New: IParamFaturamentoAutomatico;
begin
  Result := TParamFaturamentoAutomatico.Create();
end;

function TParamFaturamentoAutomatico.NumDoc: String;
begin
  Result := FNumDoc;
end;

{ TFaturamentoAutomaticoEmitirNFe }

procedure TFaturamentoAutomaticoEmitirNFe.OnSetParametros;
begin
  inherited;
  Self.SetFatAut(True);
end;

{ TFaturamentoAutomaticoEmitirNFCe }

procedure TFaturamentoAutomaticoEmitirNFCe.OnSetParametros;
begin
  inherited;
  Self.SetFatAut(True);
end;

{ TFaturamentoAutomaticoEmitirNFCeSmartPOS }

procedure TFaturamentoAutomaticoEmitirNFCeSmartPOS.OnSetParametros;
begin
  inherited;
  Self.SetSmartPOS(True);
end;

initialization
  TFaturamentoAutomatico.Mensagens  := TStringList.Create;

finalization
  FreeAndNil(TFaturamentoAutomatico.Mensagens);

end.
