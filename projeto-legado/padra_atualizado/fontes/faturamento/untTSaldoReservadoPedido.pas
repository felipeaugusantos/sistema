unit untTSaldoReservadoPedido;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  CRAccess,
  untUtilMonitor,
  Forms,
{$ENDIF LINUX}
  System.DateUtils,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections;

const
  spIdMonitorReservaItem            = 'MONITOR_RESERVA_ITEM_%s';
  spIdInactivityMonitorReservaItem  = 'TEST_INACTIVITY_RESERVA_ITEM_%s';
  spReservaItemPedidoMonitorExeName = 'ReservaItemPedidoMonitor.exe';
  spTimeLimitMonitorReservaItem     = 30;
  spAttemptsLockMonitorReservaItem  = 30;

  sqlListaTodosItemsNaoFaturados    = 'SELECT D.AUTOINCREM AS SEQFDO          '+
                                      '  FROM FATDOR D                        '+
                                      ' WHERE D.FDO_JAFATU = 0                '+
                                      '   AND D.FDO_CODEMP = :CODEMP          '+
                                      '   AND D.FDO_ESPDOC = "PD"             ';

  sqlQuantidadeReservadaItem       = 'SELECT FDO_QTDRES,                      '+
                                     '   FDO_RESERV                           '+
                                     ' FROM EXTDOR                            '+
                                     ' WHERE FDO_SEQFDO = :SEQFDO             ';

  sqlUpdateQuantidadeReservadaItem = 'UPDATE EXTDOR SET FDO_QTDRES = %s       '+
                                     'WHERE FDO_SEQFDO = :SEQFDO              ';

  sqlUpdateRepAudIteger            = 'UPDATE ITEGER SET ITE_REPAUD = "S"      '+
                                     'WHERE ITE_CODITE = :CODITE              ';

  sqlRetornaItensDoPedidoVenda     = 'SELECT F.AUTOINCREM AS SEQFDO,          '+
                                     '  F.FDO_CODITE, F.FDO_CODEMP, F.FDO_EMPITE,'+
                                     '  F.FDO_NUMLOT, F.FDO_CODCLI            '+
                                     '  FROM FATDOR F                         '+
                                     ' WHERE F.FDO_NUMDOC = :NUMDOC           '+
                                     '   AND F.FDO_ESPDOC = :ESPDOC           '+
                                     '   AND F.FDO_CODEMP = :CODEMP           ';

type
  IMarcaRepAud = interface
  ['{E216D193-3FAC-4DA0-995F-D13A897C1906}']
    function CodIte(const AValue: String): IMarcaRepAud;

    procedure Execute;
  end;

  IInvokerMarcaRepAud = Interface
  ['{3E08E785-7FA2-43FC-94BC-C5BBED5CDE5C}']
    procedure Add(ACommand: IMarcaRepAud);

    procedure Execute;
  end;

  TUpdateReservaItem =  class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  private
    FSeqFdo: String;
    FCommand: TStringList;
    FLevantarExcecao: Boolean;
  private
    class var FDicProcessados: TDictionary<String,TDateTime>;
  protected
    procedure pVerify;

    constructor Create(const ASeqDet: String; ALevantarExcecao: Boolean = False);
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;

    destructor Destroy; Override;

    function LevantarExcecao: Boolean;

    class function New(ASeqFdo: String = ''; ALevantarExcecao: Boolean = False):
  {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
  end;

implementation

uses
{$IFDEF LINUX}
  
{$ELSE }
  untFuncoesSimples,
{$ENDIF LINUX}
  System.StrUtils,
  untTFatReservaSaldo,
  untIFatReservaSaldo,
  untTFatEntregaFutura,
  untIFatEntregaFutura;

{ TUpdateReservaItem }

constructor TUpdateReservaItem.Create(const ASeqDet: String; ALevantarExcecao: Boolean = False);
begin
  FSeqFdo := ASeqDet;
  FCommand := TStringList.Create();
  FLevantarExcecao := ALevantarExcecao;
end;

destructor TUpdateReservaItem.Destroy;
begin
  FCommand.Free();
  inherited;
end;

function TUpdateReservaItem.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TUpdateReservaItem.LevantarExcecao: Boolean;
begin
  Result := FLevantarExcecao;
end;

class function TUpdateReservaItem.New(ASeqFdo: String = ''; ALevantarExcecao: Boolean = False):
  {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TUpdateReservaItem.Create(ASeqFdo, ALevantarExcecao);
end;

procedure TUpdateReservaItem.pExecute;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LOpenedTransaction: Boolean;
begin
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
      LQry.ParamByName('SEQFDO').AsString := FSeqFdo;
      LQry.ExecSQL();

      If (Not LOpenedTransaction) Then
        fCommit();
    Except
      If (Not LOpenedTransaction) Then
        fRollBack();
  
      if LevantarExcecao then
        Raise;
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  End;
end;

procedure TUpdateReservaItem.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LKey: String;
  LTempoReprocessar: Integer;
begin
  Try
    LTempoReprocessar := fCfgSis('REPSRP', VarInteger);
  Except
    LTempoReprocessar := 10;
  End;

  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlListaTodosItemsNaoFaturados);
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open();

    While (Not LQry.Eof) Do
    Begin
      {$IFDEF LINUX}
      If Not GetParamValue('-s').IsEmpty Then
        Sleep(StrToIntDef(GetParamValue('-s'), 100))
      Else
        Sleep(100);
      {$ENDIF LINUX}

      LKey := LQry.FieldByName('SEQFDO').AsString;

      If FDicProcessados.ContainsKey(LKey) Then
        If MinutesBetween(fTime(), FDicProcessados[LKey]) <= LTempoReprocessar Then
        Begin
          LQry.Next;
          Continue;
        End;

      TUpdateReservaItem.New(LKey).pExecute();

      FDicProcessados.AddOrSetValue(LKey, fTime());

      If (LQry.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitorReservaItem, [VS_strCodEmp]));
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
  End;
end;

procedure TUpdateReservaItem.pVerify;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LQtdAtu: Double;
  LQtdCal: Double;
  LQtdSQL: String;
  LReserv: String;
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlQuantidadeReservadaItem);
    LQry.ParamByName('SEQFDO').AsString := FSeqFdo;
    LQry.Open();

    LReserv := LQry.FieldByName('FDO_RESERV').AsString;
    LQtdAtu := LQry.FieldByName('FDO_QTDRES').AsFloat;
    LQtdCal := TSaldoReservado.New(
                 TReservaParametros.New()
                   .SeqFdo(FSeqFdo)
                   .FiltrarEmpresa(False)
                 ).fGetQuantidade();

    If (Not (LQtdCal = LQtdAtu)) And (LReserv = 'S') Then
    Begin
      LQtdSQL := AnsiReplaceStr(AnsiReplaceStr(FloatToStr(LQtdCal), '.', ''), ',', '.');
      FCommand.Add(Format(sqlUpdateQuantidadeReservadaItem, [LQtdSQL]));
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  End;
end;


initialization
  If Not Assigned(TUpdateReservaItem.FDicProcessados) Then
    TUpdateReservaItem.FDicProcessados := TDictionary<String,TDateTime>.Create();

finalization
  If Assigned(TUpdateReservaItem.FDicProcessados) Then
    FreeAndNil(TUpdateReservaItem.FDicProcessados);
end.
