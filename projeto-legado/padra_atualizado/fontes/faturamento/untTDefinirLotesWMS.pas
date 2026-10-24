unit untTDefinirLotesWMS;

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
  untUtilMonitor,
  UniClientDataSet,
  untFuncoesSimples,
  untDefineLotesWMS,
  System.Generics.Collections,
  untTSituacaoPedidoVenda;

Const
  spIdMonitorLotWMS = 'MONITOR_DEFINE_LOTE_WMS_%s';
  spIdInactivityMonitorLotWMS = 'TESTE_INATIVIDADE_%s';
  spLotWMSMonitorExeName = 'autcom.exe';
  spLotWMSMonitorExeParam = 'DEFINE_LOTE_WMS';
  spTimeLimitMonitorLotWMS = 30;
  spAttemptsLockMonitorLotWMS = 30;
  spMensagemAbortarOperacao = 'Não foi possível definir os lotes, operação abortada.';
  spTituloInconsistencia = 'INCONSISTÊNCIAS NA DEFINIÇÃO DE LOTES DO PEDIDO Nº %s';

  spTipoNormal = 1;
  spTipoReprocessar = 2;

  { Instruções SQL }
  sqlPedidosSemLoteDefinidoNaoProcessados =
    '  SELECT ' +
    '    SQL_NO_CACHE DISTINCT ' +
    '    1 AS TIPO , ' +
    '    FGO_NUMDOC, ' +
    '    FGO_ESPDOC, ' +
    '    FGO_CODEMP, ' +
    '    FGO_CODCLI  ' +
    '  FROM  ' +
    '    FATGOR  ' +
    '    INNER JOIN EXTGOR ' +
    '      ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    '    LEFT JOIN DEFLOT ' +
    '      ON DFL_NUMDOC = FGO_NUMDOC ' +
    '      AND DFL_ESPDOC = FGO_ESPDOC ' +
    '      AND DFL_CODEMP = FGO_CODEMP ' +
    '  WHERE FGO_ESPDOC = "PD" ' +
    '    AND FGO_CODEMP = :CODEMP ' +
    '    AND FGO_EMPEXP = :CODEMP ' +
    '    AND FGO_JAFATU = 0 ' +
    '    AND FGO_LIBERA > 0 ' +
    '    AND FGO_LIBCOM > 0 ' +
    '    AND FGO_EXTSEP <> "S" ' +
    '    AND DFL_NUMDOC IS NULL ' +
    '    AND EXISTS ' +
    '      (SELECT ' +
    '        FDO_CODITE ' +
    '      FROM ' +
    '        FATDOR ' +
    '      WHERE FDO_SEQGER = FATGOR.AUTOINCREM ' +
    '        AND FDO_QTDITE > FDO_QTDBAI ' +
    '        AND FDO_JAFATU = 0 ' +
    '        AND FDO_CODITE <> :ITESER ' +
    '        AND FDO_CODITE <> :SERTER ' +
    '        AND FDO_ENTFUT <> "S" ' +
    '        AND FDO_PROEMB <> "S") ' +
    '    AND NOT EXISTS ' +
    '      (SELECT ' +
    '        LDO_SEQFDO ' +
    '      FROM ' +
    '        FATDOR ' +
    '        INNER JOIN LOTDOR ' +
    '          ON LDO_SEQFDO = FATDOR.AUTOINCREM ' +
    '      WHERE FDO_SEQGER = FATGOR.AUTOINCREM)  ';

  sqlPedidosParaNovaTentativaApos_X_Minutos =
    '  SELECT ' +
    '    SQL_NO_CACHE DISTINCT ' +
    '    2 AS TIPO , ' +
    '    FGO_NUMDOC, ' +
    '    FGO_ESPDOC, ' +
    '    FGO_CODEMP, ' +
    '    FGO_CODCLI  ' +
    '  FROM ' +
    '    DEFLOT ' +
    '    INNER JOIN FATGOR ' +
    '      ON DFL_NUMDOC = FGO_NUMDOC ' +
    '      AND DFL_ESPDOC = FGO_ESPDOC ' +
    '      AND DFL_CODEMP = FGO_CODEMP ' +
    '    INNER JOIN EXTGOR ' +
    '      ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    '  WHERE FGO_ESPDOC = "PD" ' +
    '    AND FGO_CODEMP = :CODEMP ' +
    '    AND FGO_EMPEXP = :CODEMP ' +
    '    AND FGO_JAFATU = 0 ' +
    '    AND FGO_LIBERA > 0 ' +
    '    AND FGO_LIBCOM > 0 ' +
    '    AND FGO_EXTSEP <> "S" ' +
    '    AND DFL_DTAMSG <= DATE_SUB(NOW(), INTERVAL :REPDFL MINUTE) ';

type
  IParamDefineLoteWMS = Interface
    ['{05DE5C13-8550-4270-BC08-EE5A11BBF0C4}']
    function Tipo(const AValue: Integer): IParamDefineLoteWMS; overload;
    function NumDoc(const AValue: String): IParamDefineLoteWMS; overload;
    function EspDoc(const AValue: String): IParamDefineLoteWMS; overload;
    function CodEmp(const AValue: String): IParamDefineLoteWMS; overload;
    function CodCli(const AValue: String): IParamDefineLoteWMS; overload;

    function Tipo: Integer; overload;
    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function CodCli: String; overload;

    function fGetDocument: String;
  end;

  TParamDefineLoteWMS = class sealed(TInterfacedObject, IParamDefineLoteWMS)
  protected
    FTipo: Integer;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;

    constructor Create;
  public
    function Tipo(const AValue: Integer): IParamDefineLoteWMS; overload;
    function NumDoc(const AValue: String): IParamDefineLoteWMS; overload;
    function EspDoc(const AValue: String): IParamDefineLoteWMS; overload;
    function CodEmp(const AValue: String): IParamDefineLoteWMS; overload;
    function CodCli(const AValue: String): IParamDefineLoteWMS; overload;

    function Tipo: Integer; overload;
    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function CodCli: String; overload;

    function fGetDocument: String;

    class function New: IParamDefineLoteWMS;
  end;

  TDefinirLotesWMS = class sealed(TInterfacedObject, IMonitorProcedure)
  private
    FDefineLotes: TDefineLotesWMS;

    class var UsuariosNotificar: TArray<String>;
    class var Mensagens: TStringList;
    function GetKeyLock: String;
    function LockPedido: Boolean;
    procedure LoadUsuarios;
    procedure Cancelar;
    procedure EnviarMsg;
    procedure UnlockPedido;
    procedure ClearLog;
    procedure SaveLog;

    function fValidaLotesDefinidos: Boolean;
    function fCarregarProdutos(blnSemLotes: Boolean = False): TUniClientDataSet;
    function fChamouDefinicaoDeLotePeloRobo: Boolean;
  protected
    FParams: IParamDefineLoteWMS;
    FUsaWMSRastreavelTinta: Boolean;
    FAutIncTinta: String;
    constructor Create(AParams: IParamDefineLoteWMS);
  public
    procedure pExecuteAll;
    procedure pExecute;
    function fExecute: TResultExecute;

    class procedure AddLog(AText: String);
    class function New(AParams: IParamDefineLoteWMS = nil): IMonitorProcedure;
  end;

implementation

uses
  Vcl.Forms,
  untConstantes,
  Winapi.Windows,
  System.UITypes,
  System.Variants,
  System.DateUtils,
  System.Generics.Defaults,
  UntMsgInterna;

{ TDefinirLotesWMS }

function TDefinirLotesWMS.GetKeyLock: String;
begin
  Result := 'FATGOR' + FParams.NumDoc() + FParams.EspDoc() + FParams.CodEmp();
end;

class procedure TDefinirLotesWMS.AddLog(AText: String);
begin
  TDefinirLotesWMS.Mensagens.Add(AText);
end;

procedure TDefinirLotesWMS.ClearLog;
begin
  Self.Mensagens.Clear;
  fExecutaSQL( ' DELETE FROM DEFLOT ' +
               ' WHERE DFL_NUMDOC = ' + FParams.NumDoc().QuotedString +
               '   AND DFL_ESPDOC = ' + FParams.EspDoc().QuotedString +
               '   AND DFL_CODEMP = ' + FParams.CodEmp().QuotedString );
end;

constructor TDefinirLotesWMS.Create(AParams: IParamDefineLoteWMS);
begin
  FParams := AParams;
  FAutIncTinta := '';
  FUsaWMSRastreavelTinta := (fCfgSis('TMWMSR', varBoolean)) And
                            (fCfgSis('EXIDOC') = 'PD');
end;

procedure TDefinirLotesWMS.EnviarMsg;
var
  LUsuario: String;
  LMensagem: String;
  LObjMensagem: TMsgInterna;
begin
  Self.LoadUsuarios;
  LMensagem := AnsiReplaceStr(Self.Mensagens.Text, STRING_ENTER, STRING_QUEBRA);
  For LUsuario In Self.UsuariosNotificar Do
  Begin
    LObjMensagem := TMsgInterna.Create(nil);
    Try
      LObjMensagem.fEnviaMensagem(Format(spTituloInconsistencia, [FParams.NumDoc()]),
                                  LMensagem,
                                  LOG_ADM,
                                  LUsuario,
                                  'N',
                                  '');
    Finally
      FreeAndNil(LObjMensagem);
    End;
  End;
end;

procedure TDefinirLotesWMS.LoadUsuarios;
begin
  If Length(Self.UsuariosNotificar) > 0 Then
    Exit;

  Self.UsuariosNotificar := String(fCampoTabela(
       'GROUP_CONCAT(OPE_CODOPE ORDER BY OPE_CODOPE)',
       'CADOPE',
      ['OPE_MSGDFL', 'CONCAT("_", OPE_EMPACE, "_") LIKE "%_' + VS_strCodEmp + '_%"', 'OPE_STATUS'],
      ['S', '1', 'A'])
    ).Split([',']);
end;

function TDefinirLotesWMS.LockPedido: Boolean;
begin
  Result := True;
  If Not fLock_Unlock(GetKeyLock(), True, False) Then
  Begin
    Self.AddLog('Esse Documento está sendo utilizado em Outra Estação por ' +
      fGetHostLock(GetKeyLock()) + '!');
    Result := False;
  End;
end;

class function TDefinirLotesWMS.New(AParams: IParamDefineLoteWMS = nil)
  : IMonitorProcedure;
begin
  Result := TDefinirLotesWMS.Create(AParams);
end;

procedure TDefinirLotesWMS.Cancelar;
begin
  Self.AddLog(spMensagemAbortarOperacao);
  Self.EnviarMsg;
end;

procedure TDefinirLotesWMS.pExecute;
var
  LProdutos: TUniClientDataSet;
begin
  If Not fUsaRotinaWMS Then
    Exit;

  If fCfgSis('WMSSEP') <> '2' Then
    Exit;

  If FParams.EspDoc() <> 'PD' Then
    Exit;

  Self.ClearLog;

  Self.AddLog('Iniciando definição de Lotes do Pedido ' + FParams.NumDoc() +
    '-' + FParams.EspDoc() + '-' + FParams.CodEmp());

  FDefineLotes := TDefineLotesWMS.CreateInstance(nil, FParams.NumDoc(),
    FParams.CodEmp(), FAutIncTinta, FUsaWMSRastreavelTinta, '', '');

  Try
    If Not LockPedido Then
    Begin
      Self.Cancelar;
      Exit;
    End;

    Self.AddLog('Carregando itens do pedido.');
    LProdutos := fCarregarProdutos;

    Try
      Try
        If LProdutos.RecordCount = 0 Then
        Begin
          Self.AddLog('Não foram encontrados produtos nesse pedido para definir os lotes.');
          Self.Cancelar;
          Exit;
        End;

        Self.AddLog('Atualizando lotes.');
        FDefineLotes.blnExpedicao := True;
        FDefineLotes.pAtualizaLotes(LProdutos, True);

        Self.AddLog('Validando cadastro de lotes e produtos.');
        If Not FDefineLotes.fValidaCadastroLotesProdutos Then
        Begin
          Self.Cancelar;
          Exit;
        End;

        Self.AddLog('Validando lotes selecionados.');
        If Not FDefineLotes.fValidarLotes(LProdutos, fChamouDefinicaoDeLotePeloRobo) Then
        Begin
          Self.Cancelar;
          Exit;
        End;

        Self.AddLog('Salvando quantidade dos lotes selecionados.');
        If Not FDefineLotes.fSalvarQuantidadeDigitadaBD(LProdutos, nil) Then
        Begin
          Self.Cancelar;
          Exit;
        End;

        Self.AddLog('Validando se os lotes foram definidos.');
        if Not fValidaLotesDefinidos Then
        Begin
          Self.Cancelar;
          Exit;
        End;

        If Not FDefineLotes.fExisteDefinicaoLotesParaDocumento(
          FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp()) Then
        Begin
          Self.AddLog('Não foi possível definir os lotes de nenhum dos itens '+
            'deste pedido, verifique se existem lotes com saldo disponível '+
            'destes itens!');
          Self.Cancelar;

          FDefineLotes.pMovimentacaoProgramadaFinal( False );

          Exit;
        End;

        FDefineLotes.pMovimentacaoProgramadaFinal( True );

        If Not fMarcarPedidoComoImpresso(FParams.NumDoc(),
          FParams.EspDoc(), FParams.CodEmp(), True, True) Then
        Begin
          Self.AddLog('Não foi possível definir a separação como impressa!');
          Self.Cancelar;
          Exit;
        End;

        TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(FParams.NumDoc())
                          .EspDoc(FParams.EspDoc())
                          .CodEmp(FParams.CodEmp())).pExecute();

        Self.ClearLog; //Apaga o log no caso de sucesso. Pois assim só vai gerar log quando possuir erros

      Except
        On E: Exception Do
        Begin
          Self.AddLog(E.Message);
          Self.AddLog(fRetornaStack);
          Self.Cancelar;
          Exit;
        End;
      End;

    Finally
      FreeAndNil(LProdutos);
    End;

  Finally
    Self.SaveLog;
    Self.UnlockPedido;
    FreeAndNil(FDefineLotes);
  End;

end;

procedure TDefinirLotesWMS.pExecuteAll;
var
  LQuery: TUniQuery;
begin
  If Not fUsaRotinaWMS Then
    Exit;

  If fCfgSis('WMSSEP') <> '2' Then
    Exit;

  If TUtilMonitor.fMonitorSuspenso(spIdMonitorLotWMS) Then
    Exit;

  LQuery := fCriaQuery();

  Try
    LQuery.SQL.Add(sqlPedidosSemLoteDefinidoNaoProcessados);
    LQuery.SQL.Add('UNION');
    LQuery.SQL.Add(sqlPedidosParaNovaTentativaApos_X_Minutos);
    LQuery.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    LQuery.ParamByName('ITESER').AsString  := fCfgSis('ITESER');
    LQuery.ParamByName('SERTER').AsString  := fCfgSis('SERTER');
    LQuery.ParamByName('REPDFL').AsInteger := fCfgSis('REPDFL', VarInteger);
    LQuery.Open();

    While (Not LQuery.Eof) Do
    Begin
      TDefinirLotesWMS.New(TParamDefineLoteWMS.New()
        .Tipo(LQuery.FieldByName('TIPO').AsInteger)
        .NumDoc(LQuery.FieldByName('FGO_NUMDOC').AsString)
        .EspDoc(LQuery.FieldByName('FGO_ESPDOC').AsString)
        .CodEmp(LQuery.FieldByName('FGO_CODEMP').AsString)
        .CodCli(LQuery.FieldByName('FGO_CODCLI').AsString)).pExecute();

      If (LQuery.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitorLotWMS, [VS_strCodEmp]));
        Sleep(2000);
        pTrimAppMemorySize();
      End;

      LQuery.Next();
    End;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TDefinirLotesWMS.SaveLog;
Var
  LQuery: TUniQuery;
begin
  If Self.Mensagens.Count = 0 Then Exit;
  LQuery := fCriaQuery();
  Try
    LQuery.SQL.Text := 'SELECT * FROM DEFLOT WHERE FALSE';
    LQuery.Open;
    LQuery.Append;
    LQuery.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('DEFLOT', VS_strCodEmp);
    LQuery.FieldByName('DFL_NUMDOC').AsString   := FParams.NumDoc();
    LQuery.FieldByName('DFL_ESPDOC').AsString   := FParams.EspDoc();
    LQuery.FieldByName('DFL_CODEMP').AsString   := FParams.CodEmp();
    LQuery.FieldByName('DFL_DTAMSG').AsDateTime := fRetDataServidor + fRetHoraServidor;
    LQuery.FieldByName('DFL_MENSAG').AsString   := AnsiReplaceStr(Self.Mensagens.Text, STRING_ENTER, STRING_QUEBRA);
    LQuery.Post;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure TDefinirLotesWMS.UnlockPedido;
begin
  fLock_Unlock(GetKeyLock(), False, False);
end;

function TDefinirLotesWMS.fValidaLotesDefinidos: Boolean;
var
  LProdutos: TUniClientDataSet;
  strItens: String;
begin
  LProdutos := fCarregarProdutos(True);
  try
    Result := LProdutos.RecordCount = 0;
    if not Result then
    begin
      strItens := '';
      LProdutos.First;
      while not LProdutos.Eof do
      begin
        strItens := strItens + LProdutos.FieldByName('FDO_CODITE').AsString + ', ';
        LProdutos.Next;
      end;
      Delete(strItens, Length(strItens)-1, 2);
      Self.AddLog('Não foi possível definir o lote dos itens: ' + strItens + '.');
    end;
  finally
    FreeAndNil(LProdutos);
  end;
end;

function TDefinirLotesWMS.fCarregarProdutos(blnSemLotes: Boolean = False): TUniClientDataSet;
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery(nil);
  Try
    LQuery.SQL.Text := FDefineLotes.fGetSqlItensPedido;
    if (FParams.Tipo = spTipoReprocessar) or blnSemLotes then
      LQuery.SQL.Add(' AND NOT EXISTS (SELECT AUTOINCREM FROM LOTDOR WHERE LDO_SEQFDO = FATDOR.AUTOINCREM) ');

    LQuery.Open;
    Result := fCriaClientDatset(LQuery);
  Finally
    FreeAndNil(LQuery);
  End;
end;

function TDefinirLotesWMS.fChamouDefinicaoDeLotePeloRobo: Boolean;
begin
  Result := (ParamCount > 0) and (SameText(ParamStr(1), spLotWMSMonitorExeParam));
end;

function TDefinirLotesWMS.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

{ TParamDefineLoteWMS }

function TParamDefineLoteWMS.CodCli(const AValue: String): IParamDefineLoteWMS;
begin
  FCodCli := AValue;
  Result := Self;
end;

function TParamDefineLoteWMS.CodCli: String;
begin
  Result := FCodCli;
end;

function TParamDefineLoteWMS.CodEmp: String;
begin
  Result := FCodEmp;
end;

constructor TParamDefineLoteWMS.Create;
begin
  FTipo := 0;
  FCodEmp := '';
  FCodCli := '';
  FNumDoc := '';
  FEspDoc := '';
end;

function TParamDefineLoteWMS.CodEmp(const AValue: String): IParamDefineLoteWMS;
begin
  FCodEmp := AValue;
  Result := Self;
end;

function TParamDefineLoteWMS.EspDoc: String;
begin
  Result := FEspDoc;
end;

function TParamDefineLoteWMS.fGetDocument: String;
begin
  Result := Concat(FNumDoc, '-', FEspDoc, '-', FCodEmp);
end;

function TParamDefineLoteWMS.EspDoc(const AValue: String): IParamDefineLoteWMS;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TParamDefineLoteWMS.NumDoc(const AValue: String): IParamDefineLoteWMS;
begin
  FNumDoc := AValue;
  Result := Self;
end;

class function TParamDefineLoteWMS.New: IParamDefineLoteWMS;
begin
  Result := TParamDefineLoteWMS.Create();
end;

function TParamDefineLoteWMS.NumDoc: String;
begin
  Result := FNumDoc;
end;

function TParamDefineLoteWMS.Tipo(const AValue: Integer): IParamDefineLoteWMS;
begin
  FTipo := AValue;
  Result := Self;
end;

function TParamDefineLoteWMS.Tipo: Integer;
begin
  Result := FTipo;
end;

initialization
  TDefinirLotesWMS.Mensagens := TStringList.Create;

finalization
  FreeAndNil(TDefinirLotesWMS.Mensagens);

end.
