unit untTMonitoriaContabil;

interface

uses untUtilMonitor, untIContabilidade, Classes, Contabilidade.Interfaces,
     Uni, Data.DB;

type
  TMonitoriaContabil = class sealed(TInterfacedObject, IMonitorProcedure)
  private
    FintTamanhoBloco: Integer ;
    FstrTipLan: String ;
    FstrTabela: String ;
    FintModLan: Integer ;
    FstrEmpLan: String ;
    procedure pAgrupaArrIncDoc(var AblnExecutaBloco: Boolean; var AarrIncDoc: TArrIncDoc; const LQryDados: TUniQuery) ;
    procedure pGravaArrIncDoc(var AarrIncDoc: TArrIncDoc; const AQryDados: TUniQuery) ;
    function fTemDiferencaAgrupamento(const AQryDados: TUniQuery): Boolean ;
  protected
    FParams: IParametrosMonitorContabil;
    constructor Create(AParams: IParametrosMonitorContabil);
  public
    destructor Destroy; Override;
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;
    class function New(AParams: IParametrosMonitorContabil = nil): IMonitorProcedure;
  end;

implementation

uses untFuncoesSimples, untTParametrosGeracaoLanCon, SysUtils,
  untTFactoryLancarLanCon;

{ TMonitoriaContabil }

constructor TMonitoriaContabil.Create(AParams: IParametrosMonitorContabil);
begin
  FParams := AParams;
  FintTamanhoBloco := 50 ;
  FstrTipLan := '' ;
  FstrTabela := '' ;
  FintModLan := 0 ;
  FstrEmpLan := '' ;
end;

destructor TMonitoriaContabil.Destroy;
begin
  inherited;
end;

function TMonitoriaContabil.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TMonitoriaContabil.fTemDiferencaAgrupamento(
  const AQryDados: TUniQuery): Boolean;
begin
  Result := True ;

  if FstrTipLan <> AQryDados.FieldByName('LOG_TIPLAN').AsString then
    Exit ;

  if FstrTabela <> AQryDados.FieldByName('LOG_TABELA').AsString then
    Exit ;

  if FintModLan <> AQryDados.FieldByName('LOG_MODLAN').AsInteger then
    Exit ;

  if FstrEmpLan <> AQryDados.FieldByName('LOG_EMPLAN').AsString then
    Exit ;

  Result := False ;
end;

procedure TMonitoriaContabil.pAgrupaArrIncDoc(var AblnExecutaBloco: Boolean; var AarrIncDoc: TArrIncDoc; const LQryDados: TUniQuery);
var
  Litem : TinfoIncDocConLog ;
begin
  FillChar(Litem, SizeOf(Litem), #0);
  Litem.IncDoc := LQryDados.FieldByName('LOG_INCDOC').AsString ;
  Litem.ConLog := LQryDados.FieldByName('AUTOINCREM').AsLargeInt ;

  SetLength(AarrIncDoc, Length(AarrIncDoc) + 1) ;
  AarrIncDoc[High(AarrIncDoc)] := Litem ;

  AblnExecutaBloco := Length(AarrIncDoc) = FintTamanhoBloco ;

end;

class function TMonitoriaContabil.New(
  AParams: IParametrosMonitorContabil): IMonitorProcedure;
begin
  Result := Self.Create(AParams);
end;

procedure TMonitoriaContabil.pExecute;
  var
    LQryDados: TUniQuery;
    LarrIncDoc : TArrIncDoc ;
    LblnProcessaBloco: Boolean ;
begin
  SetLength(LarrIncDoc, 0);
  LQryDados := fCriaQuery;
  Try
    LQryDados.SQL.Clear;
    LQryDados.SQL.Add(' SELECT LOG_TIPLAN, LOG_INCDOC, LOG_TABELA, LOG_MODLAN, LOG_EMPLAN, AUTOINCREM, LOG_DTALAN ');
    LQryDados.SQL.Add('   FROM CONLOG ');
    LQryDados.SQL.Add('  WHERE TRUE ');

    if FParams.IdLancamento > 0 then
      LQryDados.SQL.Add('  AND AUTOINCREM = :AUTOIN ')
    else
      LQryDados.SQL.Add('  AND LOG_PROCES = 0 ');

    LQryDados.SQL.Add('  ORDER BY LOG_TIPLAN, LOG_TABELA, LOG_MODLAN, LOG_EMPLAN, LOG_DTALAN ');

    if FParams.IdLancamento > 0 then
      LQryDados.ParamByName('AUTOIN').AsInteger := FParams.IdLancamento
    else
      LQryDados.SQL.Add('  LIMIT 200 ');

    LQryDados.Open;
    if (not LQryDados.IsEmpty) then
    begin
      LQryDados.First;
      FstrTipLan := LQryDados.FieldByName('LOG_TIPLAN').AsString ;
      FstrTabela := LQryDados.FieldByName('LOG_TABELA').AsString ;
      FintModLan := LQryDados.FieldByName('LOG_MODLAN').AsInteger ;
      FstrEmpLan := LQryDados.FieldByName('LOG_EMPLAN').AsString ;
      LblnProcessaBloco := False ;
      While (Not LQryDados.Eof) Do
      Begin
        if (LQryDados.FieldByName('LOG_INCDOC').AsString.IsEmpty) then
        begin
          LQryDados.Next;
          Continue;
        end;

        if fTemDiferencaAgrupamento(LQryDados) and
           (Length(LarrIncDoc) > 0) then
        begin
          pGravaArrIncDoc(LarrIncDoc, LQryDados) ;
        end ;

        pAgrupaArrIncDoc(LblnProcessaBloco, LarrIncDoc, LQryDados) ;

        if LblnProcessaBloco then
        begin
          pGravaArrIncDoc(LarrIncDoc, LQryDados) ;
        end ;

        FstrTipLan := LQryDados.FieldByName('LOG_TIPLAN').AsString ;
        FstrTabela := LQryDados.FieldByName('LOG_TABELA').AsString ;
        FintModLan := LQryDados.FieldByName('LOG_MODLAN').AsInteger ;
        FstrEmpLan := LQryDados.FieldByName('LOG_EMPLAN').AsString ;

        LQryDados.Next;
      End;

      if Length(LarrIncDoc) > 0 then
        pGravaArrIncDoc(LarrIncDoc, LQryDados) ;

    end;

    if FParams.IdLancamento > 0 then
      VS_blnExitMonitor := True;
  Finally
    FreeAndNil(LQryDados);
  End;
end;

procedure TMonitoriaContabil.pExecuteAll;
begin
  pExecute;
end;

procedure TMonitoriaContabil.pGravaArrIncDoc(var AarrIncDoc: TArrIncDoc;
  const AQryDados: TUniQuery);
var
  LstrEmpSav: String ;
begin
  LstrEmpSav := VS_strCodEmp;
  try
    VS_strCodEmp := AQryDados.FieldByName('LOG_EMPLAN').AsString;

    TFactoryLancarLanCon.New
      .Execute( TParametrosGeracaoLanCon.New
                  .TipLan(AQryDados.FieldByName('LOG_TIPLAN').AsString)
                  .IncDoc(AQryDados.FieldByName('LOG_INCDOC').AsString)
                  .Tabela(AQryDados.FieldByName('LOG_TABELA').AsString)
                  .ModLan(AQryDados.FieldByName('LOG_MODLAN').AsInteger)
                  .Incremento(AQryDados.FieldByName('AUTOINCREM').AsLargeInt)
                .Reenvio(FParams.IdLancamento > 0)
                .EmpLan(AQryDados.FieldByName('LOG_EMPLAN').AsString)
                .DtaLan(AQryDados.FieldByName('LOG_DTALAN').AsDateTime)
                .ArrIncDoc(AarrIncDoc)
            );
     SetLength(AarrIncDoc, 0);
  finally
    VS_strCodEmp := LstrEmpSav;
  end;
end;

end.
