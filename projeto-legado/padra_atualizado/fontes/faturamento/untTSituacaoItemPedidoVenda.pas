unit untTSituacaoItemPedidoVenda;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  CRAccess,
  untUtilMonitor,
  Forms,
  untConstantes,
{$ENDIF LINUX}
  System.DateUtils,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections;

const
  spIdMonitorStatusItem            = 'MONITOR_STATUS_ITEM_%s';
  spIdInactivityMonitorStatusItem  = 'TEST_INACTIVITY_STATUS_ITEM_%s';
  spStatusItemPedidoMonitorExeName = 'StatusItemPedidoMonitor.exe';
  spTimeLimitMonitorStatusItem     = 30;
  spAttemptsLockMonitorStatusItem  = 30;

  sqlListaTodosItemsNaoFaturados   = 'SELECT                                 '+
                                     '  FD.AUTOINCREM AS SEQFDO,             '+
                                     '  ED.FDO_STATUS AS STATUS,             '+
                                     '  ED.FDO_REPSTA AS REPSTA,             '+
                                     '  ED.FDO_DTASTA AS DTASTA,             '+
                                     '  ED.FDO_HRASTA AS HRASTA              '+
                                     'FROM EXTDOR ED                         '+
                                     '  INNER JOIN FATDOR FD ON              '+
                                     '    FD.AUTOINCREM = ED.FDO_SEQFDO      '+
                                     '  INNER JOIN FATGOR FG ON              '+
                                     '    FD.FDO_SEQGER = FG.AUTOINCREM      '+
                                     '  INNER JOIN EXTGOR EG ON              '+
                                     '    EG.FGO_SEQFGO = FG.AUTOINCREM      '+
                                     ' WHERE FD.FDO_JAFATU = 0               '+
                                     '   AND FD.FDO_ESPDOC = "PD"            '+
                                     '   AND IFNULL(FGO_EMP_TE, "") <> FD.FDO_CODEMP '+
                                     '   AND IFNULL(FGO_EMP_CD, "") <> FD.FDO_CODEMP '+
                                     '   AND FD.FDO_CODEMP = :CODEMP         '+
                                     'UNION ALL                              '+
                                     'SELECT                                 '+
                                     '  FD.AUTOINCREM AS SEQFDO,             '+
                                     '  ED.FDO_STATUS AS STATUS,             '+
                                     '  ED.FDO_REPSTA AS REPSTA,             '+
                                     '  ED.FDO_DTASTA AS DTASTA,             '+
                                     '  ED.FDO_HRASTA AS HRASTA              '+
                                     'FROM EXTDOR ED                         '+
                                     '  INNER JOIN FATDOR FD ON              '+
                                     '    FD.AUTOINCREM = ED.FDO_SEQFDO      '+
                                     '  INNER JOIN FATGOR FG ON              '+
                                     '    FD.FDO_SEQGER = FG.AUTOINCREM      '+
                                     '  INNER JOIN EXTGOR EG ON              '+
                                     '    EG.FGO_SEQFGO = FG.AUTOINCREM      '+
                                     ' WHERE FD.FDO_JAFATU = 0               '+
                                     '   AND FD.FDO_ESPDOC = "PD"            '+
                                     '   AND EG.FGO_EMP_TE = :CODEMP         '+
                                     'UNION ALL                              '+
                                     'SELECT                                 '+
                                     '  FD.AUTOINCREM AS SEQFDO,             '+
                                     '  ED.FDO_STATUS AS STATUS,             '+
                                     '  ED.FDO_REPSTA AS REPSTA,             '+
                                     '  ED.FDO_DTASTA AS DTASTA,             '+
                                     '  ED.FDO_HRASTA AS HRASTA              '+
                                     'FROM EXTDOR ED                         '+
                                     '  INNER JOIN FATDOR FD ON              '+
                                     '    FD.AUTOINCREM = ED.FDO_SEQFDO      '+
                                     '  INNER JOIN FATGOR FG ON              '+
                                     '    FD.FDO_SEQGER = FG.AUTOINCREM      '+
                                     '  INNER JOIN EXTGOR EG ON              '+
                                     '    EG.FGO_SEQFGO = FG.AUTOINCREM      '+
                                     ' WHERE FD.FDO_JAFATU = 0               '+
                                     '   AND FD.FDO_ESPDOC = "PD"            '+
                                     '   AND EG.FGO_EMP_CD = :CODEMP         ';

  sqlListaTodosItemsReprocessar    = 'SELECT                                 '+
                                     '  FD.AUTOINCREM AS SEQFDO,             '+
                                     '  ED.FDO_STATUS AS STATUS,             '+
                                     '  ED.FDO_REPSTA AS REPSTA,             '+
                                     '  ED.FDO_DTASTA AS DTASTA,             '+
                                     '  ED.FDO_HRASTA AS HRASTA              '+
                                     'FROM EXTDOR ED                         '+
                                     '  INNER JOIN FATDOR FD ON              '+
                                     '    FD.AUTOINCREM = ED.FDO_SEQFDO      '+
                                     '  INNER JOIN FATGOR FG ON              '+
                                     '    FD.FDO_SEQGER = FG.AUTOINCREM      '+
                                     '  INNER JOIN EXTGOR EG ON              '+
                                     '    EG.FGO_SEQFGO = FG.AUTOINCREM      '+
                                     ' WHERE ED.FDO_REPSTA = "S"             '+
                                     '   AND FD.FDO_ESPDOC = "PD"            '+
                                     '   AND IFNULL(FGO_EMP_TE, "") <> FD.FDO_CODEMP '+
                                     '   AND IFNULL(FGO_EMP_CD, "") <> FD.FDO_CODEMP '+
                                     '   AND FD.FDO_CODEMP = :CODEMP         '+
                                     'UNION ALL                              '+
                                     'SELECT                                 '+
                                     '  FD.AUTOINCREM AS SEQFDO,             '+
                                     '  ED.FDO_STATUS AS STATUS,             '+
                                     '  ED.FDO_REPSTA AS REPSTA,             '+
                                     '  ED.FDO_DTASTA AS DTASTA,             '+
                                     '  ED.FDO_HRASTA AS HRASTA              '+
                                     'FROM EXTDOR ED                         '+
                                     '  INNER JOIN FATDOR FD ON              '+
                                     '    FD.AUTOINCREM = ED.FDO_SEQFDO      '+
                                     '  INNER JOIN FATGOR FG ON              '+
                                     '    FD.FDO_SEQGER = FG.AUTOINCREM      '+
                                     '  INNER JOIN EXTGOR EG ON              '+
                                     '    EG.FGO_SEQFGO = FG.AUTOINCREM      '+
                                     ' WHERE ED.FDO_REPSTA = "S"             '+
                                     '   AND FD.FDO_ESPDOC = "PD"            '+
                                     '   AND EG.FGO_EMP_TE = :CODEMP         '+
                                     'UNION ALL                              '+
                                     'SELECT                                 '+
                                     '  FD.AUTOINCREM AS SEQFDO,             '+
                                     '  ED.FDO_STATUS AS STATUS,             '+
                                     '  ED.FDO_REPSTA AS REPSTA,             '+
                                     '  ED.FDO_DTASTA AS DTASTA,             '+
                                     '  ED.FDO_HRASTA AS HRASTA              '+
                                     'FROM EXTDOR ED                         '+
                                     '  INNER JOIN FATDOR FD ON              '+
                                     '    FD.AUTOINCREM = ED.FDO_SEQFDO      '+
                                     '  INNER JOIN FATGOR FG ON              '+
                                     '    FD.FDO_SEQGER = FG.AUTOINCREM      '+
                                     '  INNER JOIN EXTGOR EG ON              '+
                                     '    EG.FGO_SEQFGO = FG.AUTOINCREM      '+
                                     ' WHERE ED.FDO_REPSTA = "S"             '+
                                     '   AND FD.FDO_ESPDOC = "PD"            '+
                                     '   AND EG.FGO_EMP_CD = :CODEMP         ';

  strAuditaStatusFaturados =         ' UPDATE                                '+
                                     '   FATDOR                              '+
                                     '   JOIN EXTDOR                         '+
                                     '     ON FATDOR.AUTOINCREM = FDO_SEQFDO '+
                                     '   JOIN FGOSTA                         '+
                                     '     ON FDO_STATUS = STA_CODIGO        '+
                                     ' SET FDO_REPSTA = "S"                  '+
                                     ' WHERE FDO_JAFATU = 1                  '+
                                     '   AND FDO_ESPDOC = "PD"               '+
                                     '   AND FDO_CODEMP = :CODEMP            '+
                                     '   AND STA_DESCRI NOT LIKE "%FATURADO%"'+
                                     '   AND STA_DESCRI NOT LIKE "%BAIXADO%" ';


  sqlStatusItemPedido              = 'SELECT SQL_NO_CACHE                     '+
                                     '  FD.FDO_NUMDOC, FD.FDO_ESPDOC,         '+
                                     '  FD.FDO_CODEMP, FD.FDO_CODCLI,         '+
                                     '  FD.AUTOINCREM, ED.FDO_STATUS          '+
                                     'FROM EXTDOR ED                          '+
                                     '  INNER JOIN FATDOR FD ON               '+
                                     '    FD.AUTOINCREM = ED.FDO_SEQFDO       '+
                                     ' WHERE ED.FDO_SEQFDO = :SEQFDO          ';

  sqlUpdateStatusItemPedido        = 'UPDATE EXTDOR SET FDO_STATUS = :STATUS, '+
                                     '                  FDO_DTASTA = :DTASTA, '+
                                     '                  FDO_HRASTA = :HRASTA, '+
                                     '                  FDO_REPSTA = "N"      '+
                                     'WHERE FDO_SEQFDO = :SEQFDO              ';


type
  TUpdateStatusItemPedido =  class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  private
    class var FLastAuditFaturados: TDateTime;
  private
    FSeqFdo: String;
    FStaNov: Integer;
    FCommand: TStringList;
  protected
    procedure pVerify;

    constructor Create(const ASeqDet: String);
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;

    destructor Destroy; Override;

    class function New(ASeqFdo: String = ''):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
  end;

implementation

uses
{$IFDEF LINUX}

{$ELSE }
  untFuncoesSimples,
{$ENDIF LINUX}
  System.StrUtils,
  untTSituacaoPedidoVenda;

{ TUpdateStatusItemPedido }

constructor TUpdateStatusItemPedido.Create(const ASeqDet: String);
begin
  FSeqFdo   := ASeqDet;
  FCommand  := TStringList.Create();
end;

destructor TUpdateStatusItemPedido.Destroy;
begin
  FCommand.Free();
  inherited;
end;

function TUpdateStatusItemPedido.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

class function TUpdateStatusItemPedido.New(ASeqFdo: String):
  {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TUpdateStatusItemPedido.Create(ASeqFdo);
end;

procedure TUpdateStatusItemPedido.pExecute;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LOpenedTransaction: Boolean;
begin
  If (Not fCfgSis('EXISTA', varBoolean)) Then
    Exit;

  LQry := fCriaQuery();

  Try
    pVerify();

    If (Not (FCommand.Count > 0)) Then
      Exit;

    LOpenedTransaction := fInTransaction();

    If (Not LOpenedTransaction) Then
      fStartTransaction();

    Try
      LQry.SQL.Add(FCommand.Text);
      LQry.ParamByName('SEQFDO').AsString   := FSeqFdo;
      LQry.ParamByName('STATUS').AsInteger  := FStaNov;
      LQry.ParamByName('DTASTA').AsDateTime := VS_Date;
      LQry.ParamByName('HRASTA').AsDateTime := Time;
      LQry.ExecSQL();

      If (Not LOpenedTransaction) Then
        fCommit();
    Except
      If (Not LOpenedTransaction) Then
        fRollBack();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  End;
end;

procedure TUpdateStatusItemPedido.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LKey: String;
  LLastUpdate: TDateTime;
  LTempoReprocessar: Integer;
begin
  If (Not fCfgSis('EXISTA', varBoolean)) Then
    Exit;

  Try
    LTempoReprocessar := fCfgSis('REPSTA', VarInteger);
  Except
    LTempoReprocessar := 10;
  End;

  LQry := fCriaQuery();

  Try
    If MinutesBetween(VS_Date + Time, FLastAuditFaturados) > 10 Then
    Begin
      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add(strAuditaStatusFaturados);
      LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQry.ExecSQL();
      FLastAuditFaturados := VS_Date + Time;
    End;

    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(sqlListaTodosItemsNaoFaturados + ' UNION ALL ' +
                 sqlListaTodosItemsReprocessar);

    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open();

    While (Not LQry.Eof) Do
    Begin
      LKey := LQry.FieldByName('SEQFDO').AsString;

      If Not LQry.FieldByName('REPSTA').AsString.Equals('S') Then
      Begin
        LLastUpdate := LQry.FieldByName('DTASTA').AsDateTime +
                       LQry.FieldByName('HRASTA').AsDateTime;

        If MinutesBetween(VS_Date + Time, LLastUpdate) <= LTempoReprocessar Then
        Begin
          LQry.Next;
          Continue;
        End;
      End;

      {$IFDEF LINUX}
      If Not GetParamValue('-s').IsEmpty Then
        Sleep(StrToIntDef(GetParamValue('-s'), 100))
      Else
        Sleep(100);
      {$ENDIF LINUX}

      TUpdateStatusItemPedido.New(LKey).pExecute();

      If (LQry.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitorStatusItem, [VS_strCodEmp]));
        Sleep(2000);
        {$IFNDEF LINUX}
        pTrimAppMemorySize();
        {$ENDIF LINUX}
      End;

      LQry.Next();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
    Sleep(3000);
  End;
end;

procedure TUpdateStatusItemPedido.pVerify;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LStaAtu: Integer;
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlStatusItemPedido);
    LQry.ParamByName('SEQFDO').AsString := FSeqFdo;
    LQry.Open();

    LStaAtu := LQry.FieldByName('FDO_STATUS').AsInteger;

    FStaNov := TStatus.New(
      TParamStatus.New()
        .NumDoc(LQry.FieldByName('FDO_NUMDOC').AsString)
        .EspDoc(LQry.FieldByName('FDO_ESPDOC').AsString)
        .CodEmp(LQry.FieldByName('FDO_CODEMP').AsString)
        .CodCli(LQry.FieldByName('FDO_CODCLI').AsString)
        .SeqFdo(LQry.FieldByName('AUTOINCREM').AsString)
    ).fGetStatus().fGetId;

    { Se nao houve alteracao no status nao vamos replicar o comando que atualiza
      a data e hora da modificacao do status, ira gerar muitas instrucoes desnecessarias
      na tabela LOGREP.
      No entanto, como usamos a data e hora para controlar a proxima verificacao,
      precisamos continuar atualizando estes campos. }
    {$IFDEF LINUX}
    If LStaAtu <> FStaNov Then
      FCommand.Add(sqlUpdateStatusItemPedido)
    Else
      FCommand.Add(STR_SQL_NAO_REPLICAR + sqlUpdateStatusItemPedido);
    {$ELSE}
    If LStaAtu <> FStaNov Then
      FCommand.Add(sqlUpdateStatusItemPedido);
    {$ENDIF}
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  End;
end;


initialization

finalization

end.
