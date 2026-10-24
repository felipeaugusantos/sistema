unit untConfTinta;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, System.Generics.Collections,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untIConfTinta, Uni, System.SysUtils, System.Classes;

Type
  TConfTinta = class(TInterfacedObject, IConfTinta)
  private
    strIdePro: String;
   {$IFDEF LINUX}
    class var FMREW: TMultiReadExclusiveWriteSynchronizer;
    class var dicConf: TDictionary<NativeUInt, TUniQuery>;
    procedure IniciarQryConf;
    function qryConf: TUniQuery;
   {$ELSE}
    class var qryConf: TUniQuery;
   {$ENDIF}
    procedure CarregaConfTinta;
  public
    constructor Create(strIdePro: String); virtual;
    function fGet(strCodCfg: String): String; virtual;
    procedure pSet(strCodCfg: String; strValCfg: String); virtual;
    destructor Destroy; override;
    function fGetBoolean(strCodcfg: String): Boolean;
    function fGetDouble(strCodCfg: String): Double;
    function fGetInteger(strCodCfg: String): Integer;
    procedure pSetBoolean(strCodCfg: String; blnValCfg: Boolean);
    procedure pSetDouble(strCodCfg: String; fltValCfg: Double);
    procedure pSetInteger(strCodCfg: String; intValCfg: Integer);
    procedure pInsereCodigo(strCodCfg, strDescri, strDefault: String);
    function fGetDate(strCodCfg: String): TDateTime;
    procedure pSetDate(strCodCfg: String; dtaValCfg: TDateTime);
  End;

implementation

uses
  TypInfo, DB, StrUtils,untConstantes;

{ TConfTinta }

procedure TConfTinta.CarregaConfTinta;
begin
  If (qryConf.Active) And (qryConf.FieldByName('CFG_IDEPRO').AsString = strIdePro) And
    (qryConf.ParamByName('CODEMP').AsString = VS_strCodEmp) Then
    Exit;

  qryConf.Close;
  qryConf.SQL.Text :=
    ' SELECT                               ' +
    '   CFG_CODEMP                         ' +
    '   , CFG_IDEPRO                       ' +
    '   , CFG_CODCFG                       ' +
    '   , CFG_VALCFG                       ' +
    ' FROM                                 ' +
    '   CFGTIN                             ' +
    ' WHERE CFG_CODEMP = :CODEMP           ' +
    '   AND CFG_GRUCFG = :GRUCFG           ' +
    '   AND CFG_IDEPRO = :IDEPRO           ';

  qryConf.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConf.ParamByName('GRUCFG').AsString := 'CONFIGURACOES';
  qryConf.ParamByName('IDEPRO').AsString := strIdePro;

  Try
    qryConf.Open;
  Except
    On E: Exception Do
      Raise Exception.Create('Não foi possível carregar as configurações da tinta "' +
        strIdePro + '". Erro na abertura da tabela CFGTIN!');
  End;
end;

constructor TConfTinta.Create(strIdePro: String);
begin
  Self.strIdePro := strIdePro;

 {$IFDEF LINUX}
  IniciarQryConf();
 {$ELSE}
  If qryConf = nil Then
    qryConf := fCriaQuery(nil);
 {$ENDIF}

  CarregaConfTinta;
end;

destructor TConfTinta.Destroy;
begin
  inherited Destroy;
end;

function TConfTinta.fGet(strCodCfg: String): String;
begin
  Result := '';
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
    Result := qryConf.FieldByName('CFG_VALCFG').AsString;
end;

function TConfTinta.fGetBoolean(strCodcfg: String): Boolean;
begin
  Result := False;
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
    Result := qryConf.FieldByName('CFG_VALCFG').AsString = 'S';
end;

function TConfTinta.fGetDate(strCodCfg: String): TDateTime;
begin
  Result := 0;
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
    Result := StrToDateTime(qryConf.FieldByName('CFG_VALCFG').AsString);
end;

function TConfTinta.fGetDouble(strCodCfg: String): Double;
begin
  Result := 0.0;
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
    Result := fStrToFloat(qryConf.FieldByName('CFG_VALCFG').AsString);
end;

function TConfTinta.fGetInteger(strCodCfg: String): Integer;
begin
  Result := 0;
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
    Result := StrToIntDef(qryConf.FieldByName('CFG_VALCFG').AsString, 0);
end;

{$IFDEF LINUX}
procedure TConfTinta.IniciarQryConf;
var
  LKey: NativeUInt;
  LQry: TUniQuery;
begin
  FMREW.BeginWrite;
  try
    LKey := TThread.CurrentThread.ThreadID;
    if dicConf.TryGetValue(LKey, LQry) then
    begin
      if LQry.Active and (LQry.FieldByName('CFG_IDEPRO').AsString = strIdePro) then
        Exit;
      LQry.Free;
    end;
    LQry := fCriaQuery();
    dicConf.AddOrSetValue(LKey, LQry);
  finally
    FMREW.EndWrite;
  end;
end;
{$ENDIF}

procedure TConfTinta.pInsereCodigo(strCodCfg, strDescri, strDefault: String);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();

      qryGen.SQL.Text :=
        ' SELECT * FROM CFGTIN WHERE TRUE  ' +
        '     AND CFG_CODEMP = :CFG_CODEMP ' +
        '     AND CFG_IDEPRO = :CFG_IDEPRO ' +
        '     AND CFG_CODCFG = :CFG_CODCFG ' +
        '     AND CFG_GRUCFG = :CFG_GRUCFG ' ;

      qryGen.ParamByName('CFG_CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('CFG_IDEPRO').AsString := strIdePro;
      qryGen.ParamByName('CFG_CODCFG').AsString := strCodCfg;
      qryGen.ParamByName('CFG_GRUCFG').AsString := 'CONFIGURACOES';

      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Close;
        qryGen.SQL.Text :=
          ' INSERT INTO CFGTIN (  ' +
          '   CFG_CODEMP          ' +
          '   , CFG_IDEPRO        ' +
          '   , CFG_CODCFG        ' +
          '   , CFG_VALCFG        ' +
          '   , CFG_DESCRI        ' +
          '   , CFG_GRUCFG        ' +
          ' )                     ' +
          ' VALUES                ' +
          '   (                   ' +
          '     :CFG_CODEMP       ' +
          '     , :CFG_IDEPRO     ' +
          '     , :CFG_CODCFG     ' +
          '     , :CFG_VALCFG     ' +
          '     , :CFG_DESCRI     ' +
          '     , :CFG_GRUCFG     ' +
          '   )                   ';

        qryGen.ParamByName('CFG_CODEMP').AsString := VS_strCodEmp;
        qryGen.ParamByName('CFG_IDEPRO').AsString := strIdePro;
        qryGen.ParamByName('CFG_CODCFG').AsString := strCodCfg;
        qryGen.ParamByName('CFG_VALCFG').AsString := strDefault;
        qryGen.ParamByName('CFG_DESCRI').AsString := strDescri;
        qryGen.ParamByName('CFG_GRUCFG').AsString := 'CONFIGURACOES';

        Try
          qryGen.ExecSQL;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT  Then
              Raise;
          End;
        End;
      End;

      qryConf.Close;
      qryConf.Open;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;

end;

procedure TConfTinta.pSet(strCodCfg, strValCfg: String);
begin
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_VALCFG').AsString := strValCfg;
    qryConf.Post;
  End;
end;

procedure TConfTinta.pSetBoolean(strCodCfg: String; blnValCfg: Boolean);
begin
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_VALCFG').AsString := IfThen(blnValCfg, 'S', 'N');
    qryConf.Post;
  End;
end;

procedure TConfTinta.pSetDate(strCodCfg: String; dtaValCfg: TDateTime);
begin
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_VALCFG').AsString:= DateTimeToStr(dtaValCfg);
    qryConf.Post;
  End;
end;

procedure TConfTinta.pSetDouble(strCodCfg: String; fltValCfg: Double);
begin
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_VALCFG').AsString := FloatToStr(fltValCfg);
    qryConf.Post;
  End;
end;

procedure TConfTinta.pSetInteger(strCodCfg: String; intValCfg: Integer);
begin
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_VALCFG').AsString := IntToStr(intValCfg);
    qryConf.Post;
  End;
end;

{$IFDEF LINUX}
function TConfTinta.qryConf: TUniQuery;
var
  LKey: NativeUInt;
  LQry: TUniQuery;
begin
  FMREW.BeginRead;
  try
    LKey := TThread.CurrentThread.ThreadID;
    if dicConf.TryGetValue(LKey, LQry) then
      Exit(LQry);
    raise EThread.Create('No current qryConf for thread');
  finally
    FMREW.EndRead;
  end;
end;
{$ENDIF}

initialization
{$IFDEF LINUX}
  TConfTinta.FMREW := TMultiReadExclusiveWriteSynchronizer.Create;
  TConfTinta.dicConf := TDictionary<NativeUInt, TUniQuery>.Create;
{$ENDIF}

finalization
{$IFDEF LINUX}
  FreeAndNil(TConfTinta.dicConf);
  FreeAndNil(TConfTinta.FMREW);
{$ELSE}
  if Assigned(TConfTinta.qryConf) Then FreeAndNil(TConfTinta.qryConf);
{$ENDIF}
end.
