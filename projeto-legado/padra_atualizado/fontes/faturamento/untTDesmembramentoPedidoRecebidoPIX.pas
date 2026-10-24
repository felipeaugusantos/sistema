unit untTDesmembramentoPedidoRecebidoPIX;

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
  Faturamento.Classes.TFaturador.Base;

Const
  IdMonitorDesmembramentoPedidoRecebidoPIX = 'MONITOR_DESMEMBRAMENTO_PEDIDO_PIX_%s';
  IdInactivityMonitorDesmembramentoPedidoRecebidoPIX = 'TESTE_INATIVIDADE_%s';
  DesmembramentoPedidoRecebidoPIXMonitorExeName = 'autcom.exe';
  DesmembramentoPedidoRecebidoPIXMonitorExeParam = 'DESMEMBRAMENTO_PEDIDO_PIX';
  TimeLimitMonitorDesmembramentoPedidoRecebidoPIX = 60;
  AttemptsLockMonitorDesmembramentoPedidoRecebidoPIX = 30;
  MinutosNovaTentativaDesmembramentoPedidoRecebidoPIX = 15;

  { Instruções SQL }
  sqlPedidosParaDesmembramentoPedidoRecebidoPIX =
    ' SELECT                                         ' +
    '    FATGOR.AUTOINCREM,                          ' +
    '    FGO_NUMDOC,                                 ' +
    '    FGO_ESPDOC,                                 ' +
    '    FGO_CODEMP,                                 ' +
    '    SUM(FDO_JAFATU) AS ITENS_FAT,               ' +
    '    SUM(FDO_QTDBAI) AS ITENS_BAI,               ' +
    '    SUM(FDO_QTDEXP) AS ITENS_EXP,               ' +
    '    FGO_VLRCON,                                 ' +
    '    IFNULL(                                     ' +
    '      (SELECT                                   ' +
    '        SUM(                                    ' +
    '          IF(                                   ' +
    '            ADT_TIPLAN = "C",                   ' +
    '            ADT_VALLAN,                         ' +
    '            - ADT_VALLAN                        ' +
    '          )                                     ' +
    '        )                                       ' +
    '      FROM                                      ' +
    '        ADTCLI                                  ' +
    '      WHERE ADT_NUMDOC = FGO_NUMDOC             ' +
    '        AND ADT_ESPDOC = FGO_ESPDOC             ' +
    '        AND ADT_CODEMP = FGO_CODEMP             ' +
    '        AND ADT_CODCLI = FGO_CODCLI),           ' +
    '      0                                         ' +
    '    ) AS RECEB_ADT,                             ' +
    '    MPX_VALPIX,                                 ' +
    '    MPX_STATUS,                                 ' +
    '    TIMEDIFF(                                   ' +
    '      CURRENT_TIMESTAMP,                        ' +
    '      CAST(                                     ' +
    '        CONCAT(MPX_DTAREC, " ", MPX_HORREC) AS DATETIME ' +
    '      )                                         ' +
    '    ) AS RECEB_MIN,                             ' +
    '    FGO_CONPAG,                                 ' +
    '    FGO_CODFPG,                                 ' +
    '    FGO_ENT_CD,                                 ' +
    '    FGO_EMP_TE,                                 ' +
    '    FGO_ESPORI                                  ' +
    '  FROM                                          ' +
    '    FATGOR                                      ' +
    '    JOIN EXTGOR                                 ' +
    '      ON FGO_SEQFGO = FATGOR.AUTOINCREM         ' +
    '    JOIN MOVPIX                                 ' +
    '      ON FGO_EMPPIX = MPX_CODEMP                ' +
    '      AND FGO_TX_PIX = MPX_TX_ID_               ' +
    '    JOIN FATDOR                                 ' +
    '      ON FDO_SEQGER = FATGOR.AUTOINCREM         ' +
    '    JOIN EXTDOR                                 ' +
    '      ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM  ' +
    '  WHERE TRUE                                    ' +
    '    AND FGO_ESPDOC = "PD"                       ' +
    '    AND FGO_CODEMP = :CODEMP                    ' +
    '    AND FGO_JAFATU = "0"                        ' +
    '  GROUP BY FATGOR.AUTOINCREM                    ' +
    '  HAVING TRUE                                   ' +
    '    AND ITENS_FAT = 0                           ' +//Nao pode ter itens faturados
    '    AND ITENS_BAI = 0                           ' +//Nao pode ter itens baixados
    '    AND ITENS_EXP = 0                           ' +//Nao pode ter itens expedidos
    '    AND FGO_CONPAG = "01000"                    ' +//somente pedidos condicao pgto a vista
    '    AND FGO_CODFPG = "012"                      ' +//forma de pagamento ORDEM DE PAGAMENTO
    '    AND FGO_ENT_CD = "N"                        ' +//Nao pode ser pedido de entrega pelo cd
    '    AND IFNULL(FGO_EMP_TE, "") = ""             ' +//Nao pode ser pedido de abastecimento entre lojas
    '    AND IFNULL(FGO_ESPORI, "") <> "PD"          ' +//Nao pode ter sido originado em outro pedido
    '    AND RECEB_ADT = FGO_VLRCON                  ' +//Recebimento pix no valor total
    '    AND MPX_STATUS="CONCLUIDA"                  ' +//Operacao do pix ja concluida
    '    AND RECEB_MIN > "00:01:00"                  ' ;//Processar pedidos recebidos a mais de um minuto evitando "Esse Documento está sendo utilizado em outra Estação"

type
  IParamDesmembramentoPedidoRecebidoPIX = Interface
    ['{05DE5C13-8550-4270-BC08-EE5A11BBF0C4}']
    function NumDoc(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX; overload;
    function EspDoc(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX; overload;
    function CodEmp(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX; overload;

    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;

    function fGetDocument: String;
  end;

  TParamDesmembramentoPedidoRecebidoPIX = class sealed(TInterfacedObject, IParamDesmembramentoPedidoRecebidoPIX)
  protected
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;

    constructor Create;
  public
    function NumDoc(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX; overload;
    function EspDoc(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX; overload;
    function CodEmp(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX; overload;

    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;

    function fGetDocument: String;

    class function New: IParamDesmembramentoPedidoRecebidoPIX;
  end;

  TDesmembramentoPedidoRecebidoPIX = class sealed(TInterfacedObject, IMonitorProcedure)
  private
    class var FMensagens: TStringList;
    class var FAttempts: TDictionary<string, TDateTime>;
  private
    class function fValidarConfiguracoes: Boolean;
  private
    FParams: IParamDesmembramentoPedidoRecebidoPIX;
  private
    procedure ClearLog;
  private
    function ExecutarDesmembramentoPedido: Boolean;
  protected
    constructor Create(AParams: IParamDesmembramentoPedidoRecebidoPIX);
  public
    procedure pExecuteAll;
    procedure pExecute;
    function fExecute: TResultExecute;
    class procedure ExecutarRobo();
    class procedure AddLog(AText: String);
    class function New(AParams: IParamDesmembramentoPedidoRecebidoPIX = nil): IMonitorProcedure;
  end;

type
  TDesmembrarPedidoPIX = class(TFaturadorBase)
  protected
    procedure OnSetParametros; override;
  end;

Var
  VS_strLockMonitorDesmembramentoPedidoRecebidoPIX: String;
  VS_dtaUltimaExecucaoMonitorDesmembramentoPedidoRecebidoPIX: TDateTime;
  VS_objProcessoMonitorDesmembramentoPedidoRecebidoPIX: TProcessInformation;

implementation

uses
  untLibNFe,
  Vcl.Forms,
  untConstantes,
  System.UITypes,
  System.Variants,
  System.DateUtils,
  System.Generics.Defaults,
  untImpEtiDespacho,
  untConstantesNFe,
  untFuncFatImp,
  untDicSis;

{ TDesmembramentoPedidoRecebidoPIX }

class procedure TDesmembramentoPedidoRecebidoPIX.AddLog(AText: String);
begin
  Self.FMensagens.Add(DateTimeToStr(fNow()) + ' - ' + AText);
end;

procedure TDesmembramentoPedidoRecebidoPIX.ClearLog;
begin
  Self.FMensagens.Clear;
end;

constructor TDesmembramentoPedidoRecebidoPIX.Create(AParams: IParamDesmembramentoPedidoRecebidoPIX);
begin
  FParams := AParams;
end;

function TDesmembramentoPedidoRecebidoPIX.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

class function TDesmembramentoPedidoRecebidoPIX.fValidarConfiguracoes: Boolean;
begin
  If Not fCfgSis('DMPPIX', varBoolean) Then
    Exit(False);

  If Not fCfgSis('EMPFAT', VarBoolean) Then
    Exit(False);

  //REQ.: 305545
  If Not fValidarCFG_TXJCNI Then
    Exit(False);

  Result := True;
end;

class procedure TDesmembramentoPedidoRecebidoPIX.ExecutarRobo;
var
  LIdMonitor: string;
begin
  If Not fValidarConfiguracoes Then
    Exit;

  LIdMonitor := Format(IdMonitorDesmembramentoPedidoRecebidoPIX, [VS_strCodEmp]);

  TUtilMonitor.pTestInactivity(IdInactivityMonitorDesmembramentoPedidoRecebidoPIX,
                               TimeLimitMonitorDesmembramentoPedidoRecebidoPIX,
                               VS_objProcessoMonitorDesmembramentoPedidoRecebidoPIX,
                               VS_dtaUltimaExecucaoMonitorDesmembramentoPedidoRecebidoPIX);

  TUtilMonitor.pRunMonitor(LIdMonitor,
                           VS_objProcessoMonitorDesmembramentoPedidoRecebidoPIX,
                           VS_dtaUltimaExecucaoMonitorDesmembramentoPedidoRecebidoPIX,
                           ExtractFileName(ParamStr(0)),
                           Concat(DesmembramentoPedidoRecebidoPIXMonitorExeParam, ' ', VS_strCodEmp));

  TUtilMonitor.pClearAttemptsLock(LIdMonitor, AttemptsLockMonitorDesmembramentoPedidoRecebidoPIX);
end;

function TDesmembramentoPedidoRecebidoPIX.ExecutarDesmembramentoPedido: Boolean;
var
  objDmpPix: TDesmembrarPedidoPIX;
begin
  objDmpPix := TDesmembrarPedidoPIX.Create(FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp());
  try
    objDmpPix.FaturarDocumento();
    Result := Length(objDmpPix.arrDocumentosEmitidos) > 0;
  finally
    objDmpPix.Free;
  end;
end;

class function TDesmembramentoPedidoRecebidoPIX.New(AParams: IParamDesmembramentoPedidoRecebidoPIX = nil)
  : IMonitorProcedure;
begin
  Result := TDesmembramentoPedidoRecebidoPIX.Create(AParams);
end;

procedure TDesmembramentoPedidoRecebidoPIX.pExecute;
const
  MSG_ERRO = '[TDesmembramentoPedidoRecebidoPIX.pExecute] %s-%s-%s >> %s';
begin
  If Not fValidarConfiguracoes Then
    Exit;

  If FParams.EspDoc() <> 'PD' Then
    Exit;

  Self.ClearLog;
  Try
    Self.ExecutarDesmembramentoPedido;
  Except
    On E: Exception Do
    Begin
      Self.AddLog(E.Message);
      pGravarErro(True, Format(MSG_ERRO, [FParams.NumDoc(), FParams.EspDoc(),
        FParams.CodEmp(), E.Message]), Self.FMensagens.Text);
    End;
  End;
end;

procedure TDesmembramentoPedidoRecebidoPIX.pExecuteAll;
var
  LQuery: TUniQuery;
  LKey: String;
  LIdMonitor: String;
  LUltimaTentativa: TDateTime;
begin
  If Not fValidarConfiguracoes Then
    Exit;

  LIdMonitor := Format(IdMonitorDesmembramentoPedidoRecebidoPIX, [VS_strCodEmp]);

  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Add(sqlPedidosParaDesmembramentoPedidoRecebidoPIX);
    LQuery.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    LQuery.Open();

    While (Not LQuery.Eof) Do
    Begin
      If Not FAttempts.TryGetValue(LQuery.FieldByName('AUTOINCREM').AsString, LUltimaTentativa) Then
        LUltimaTentativa := VS_Date;

      If MinutesBetween(fNow(), LUltimaTentativa) > MinutosNovaTentativaDesmembramentoPedidoRecebidoPIX Then
      Begin
        LKey := 'DMPPIX_' + LQuery.FieldByName('AUTOINCREM').AsString;

        pDestravaLockForcado(LKey, AttemptsLockMonitorDesmembramentoPedidoRecebidoPIX);

        If fLock_Unlock(LKey, True, False, False, '', False) Then
        Begin
          Try
            TDesmembramentoPedidoRecebidoPIX.New(TParamDesmembramentoPedidoRecebidoPIX.New()
              .NumDoc(LQuery.FieldByName('FGO_NUMDOC').AsString)
              .EspDoc(LQuery.FieldByName('FGO_ESPDOC').AsString)
              .CodEmp(LQuery.FieldByName('FGO_CODEMP').AsString)).pExecute();

            pZerarTentativasLock(LIdMonitor);
            Sleep(500);
            pTrimAppMemorySize();
          Finally
            fLock_Unlock(LKey, False, False, False, '', False);
          End;
        End;

        FAttempts.AddOrSetValue(LQuery.FieldByName('AUTOINCREM').AsString, fNow());
      End;
      LQuery.Next();
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

{ TParamDesmembramentoPedidoRecebidoPIX }

function TParamDesmembramentoPedidoRecebidoPIX.CodEmp: String;
begin
  Result := FCodEmp;
end;

constructor TParamDesmembramentoPedidoRecebidoPIX.Create;
begin
  FCodEmp := '';
  FNumDoc := '';
  FEspDoc := '';
end;

function TParamDesmembramentoPedidoRecebidoPIX.CodEmp(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX;
begin
  FCodEmp := AValue;
  Result := Self;
end;

function TParamDesmembramentoPedidoRecebidoPIX.EspDoc: String;
begin
  Result := FEspDoc;
end;

function TParamDesmembramentoPedidoRecebidoPIX.fGetDocument: String;
begin
  Result := Concat(FNumDoc, '-', FEspDoc, '-', FCodEmp);
end;

function TParamDesmembramentoPedidoRecebidoPIX.EspDoc(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TParamDesmembramentoPedidoRecebidoPIX.NumDoc(const AValue: String): IParamDesmembramentoPedidoRecebidoPIX;
begin
  FNumDoc := AValue;
  Result := Self;
end;

class function TParamDesmembramentoPedidoRecebidoPIX.New: IParamDesmembramentoPedidoRecebidoPIX;
begin
  Result := TParamDesmembramentoPedidoRecebidoPIX.Create();
end;

function TParamDesmembramentoPedidoRecebidoPIX.NumDoc: String;
begin
  Result := FNumDoc;
end;

{ TDesmembrarPedidoPIX }

procedure TDesmembrarPedidoPIX.OnSetParametros;
begin
  inherited;
  Self.SetEspFat('PD');
  Self.SetDmpPix(True);
end;

initialization
  TDesmembramentoPedidoRecebidoPIX.FMensagens := TStringList.Create;
  TDesmembramentoPedidoRecebidoPIX.FAttempts := TDictionary<string, TDateTime>.Create;

finalization
  FreeAndNil(TDesmembramentoPedidoRecebidoPIX.FMensagens);
  FreeAndNil(TDesmembramentoPedidoRecebidoPIX.FAttempts);

end.
