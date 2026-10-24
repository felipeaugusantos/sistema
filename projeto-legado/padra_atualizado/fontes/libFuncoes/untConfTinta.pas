unit untConfTinta;

interface

uses
  untIConfTinta, Uni, untConstantes, cxEdit;

Type
  TConfTinta = class(TInterfacedObject, IConfTinta)
  private
    qryConf: TUniQuery;
    strIdePro: String;
    strCodEmp: String;
  public
    constructor Create(strIdePro, strCodEmp: String); virtual;

    function fRetornaDataset: TUniQuery;

    function fGet(strCodCfg: String): String; virtual;
    procedure pSet(strCodCfg: String; strValCfg: String); virtual;
    destructor Destroy; override;
    function fGetBoolean(strCodcfg: String): Boolean;
    function fGetDouble(strCodCfg: String): Double;
    function fGetInteger(strCodCfg: String): Integer;
    procedure pSetBoolean(strCodCfg: String; blnValCfg: Boolean);
    procedure pSetDouble(strCodCfg: String; fltValCfg: Double);
    procedure pSetInteger(strCodCfg: String; intValCfg: Integer);
    procedure pInsereCodigo(strCodCfg, strDescri, strDefault, strProPri: String);
    function fGetDate(strCodCfg: String): TDateTime;
    procedure pSetDate(strCodCfg: String; dtaValCfg: TDateTime);
  End;

implementation

uses
  TypInfo, SysUtils, DB, StrUtils, untFuncoesGen;

{ TConfTinta }

constructor TConfTinta.Create(strIdePro, strCodEmp: String);
begin
  Self.strIdePro := strIdePro;
  Self.strCodEmp := strCodEmp;
  qryConf := fCriaQuery(Nil);

  qryConf.SQL.Add(' SELECT                             ');
  qryConf.SQL.Add('   CFG_CODCFG,                      ');
  qryConf.SQL.Add('   CFG_DESCRI,                      ');
  qryConf.SQL.Add('   CFG_VALCFG                       ');
  qryConf.SQL.Add(' FROM                               ');
  qryConf.SQL.Add('   CFGTIN                           ');
  qryConf.SQL.Add(' WHERE                              ');
  qryConf.SQL.Add('   CFG_CODEMP = :CODEMP AND         ');
  qryConf.SQL.Add('   CFG_GRUCFG = "CONFIGURACOES" AND ');
  qryConf.SQL.Add('   CFG_IDEPRO = :IDEPRO             ');

  qryConf.ParamByName('CODEMP').AsString := strCodEmp;
  qryConf.ParamByName('IDEPRO').AsString := strIdePro;
  qryConf.Open;
end;

destructor TConfTinta.Destroy;
begin
  FreeAndNil(qryConf);
  inherited;
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
    Result := qryConf.FieldByName('CFG_VALCFG').AsDateTime;
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

function TConfTinta.fRetornaDataset: TUniQuery;
begin
  Result := qryConf;
end;

procedure TConfTinta.pInsereCodigo(strCodCfg, strDescri, strDefault, strProPri: String);
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);

  qryConf.Filter := 'CFG_CODCFG = ' + QuotedStr(strCodCfg);
  qryConf.Filtered := True;

  If Not qryConf.IsEmpty Then
  Begin
    qryGen.SQL.Add(' UPDATE CFGTIN SET ');
    qryGen.SQL.Add('    CFG_PROPRI = :CFG_PROPRI ');
    qryGen.SQL.Add(' WHERE ');
    qryGen.SQL.Add('    CFG_CODEMP = :CFG_CODEMP AND ');
    qryGen.SQL.Add('    CFG_IDEPRO = :CFG_IDEPRO AND ');
    qryGen.SQL.Add('    CFG_CODCFG = :CFG_CODCFG AND ');
    qryGen.SQL.Add('    CFG_GRUCFG = :CFG_GRUCFG ');

    qryGen.ParamByName('CFG_CODEMP').AsString := strCodEmp;
    qryGen.ParamByName('CFG_IDEPRO').AsString := strIdePro;
    qryGen.ParamByName('CFG_CODCFG').AsString := strCodCfg;
    qryGen.ParamByName('CFG_GRUCFG').AsString := 'CONFIGURACOES';
    qryGen.ParamByName('CFG_PROPRI').AsString := strProPri;
  End
  Else
  Begin
    qryGen.SQL.Add(' INSERT INTO CFGTIN ');
    qryGen.SQL.Add('   (CFG_CODEMP, ');
    qryGen.SQL.Add('    CFG_IDEPRO, ');
    qryGen.SQL.Add('    CFG_CODCFG, ');
    qryGen.SQL.Add('    CFG_VALCFG, ');
    qryGen.SQL.Add('    CFG_DESCRI, ');
    qryGen.SQL.Add('    CFG_GRUCFG, ');
    qryGen.SQL.Add('    CFG_PROPRI) ');
    qryGen.SQL.Add(' VALUES ');
    qryGen.SQL.Add('   (:CFG_CODEMP, ');
    qryGen.SQL.Add('    :CFG_IDEPRO, ');
    qryGen.SQL.Add('    :CFG_CODCFG, ');
    qryGen.SQL.Add('    :CFG_VALCFG, ');
    qryGen.SQL.Add('    :CFG_DESCRI, ');
    qryGen.SQL.Add('    :CFG_GRUCFG, ');
    qryGen.SQL.Add('    :CFG_PROPRI) ');

    qryGen.ParamByName('CFG_CODEMP').AsString := strCodEmp;
    qryGen.ParamByName('CFG_IDEPRO').AsString := strIdePro;
    qryGen.ParamByName('CFG_CODCFG').AsString := strCodCfg;
    qryGen.ParamByName('CFG_VALCFG').AsString := strDefault;
    qryGen.ParamByName('CFG_DESCRI').AsString := strDescri;
    qryGen.ParamByName('CFG_GRUCFG').AsString := 'CONFIGURACOES';
    qryGen.ParamByName('CFG_PROPRI').AsString := strProPri;
  End;

  Try
    qryGen.ExecSQL;
  Except
    On E: EUniError Do
    Begin
      If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT  Then
        Raise;
    End;
  End;
  qryConf.Filtered := False;
  qryConf.Filter := '';

  FreeAndNil(qryGen);

  qryConf.Close;
  qryConf.Open;
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
    qryConf.FieldByName('CFG_VALCFG').AsDateTime := dtaValCfg;
    qryConf.Post;
  End;
end;

procedure TConfTinta.pSetDouble(strCodCfg: String; fltValCfg: Double);
begin
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_VALCFG').AsFloat := fltValCfg;
    qryConf.Post;
  End;
end;

procedure TConfTinta.pSetInteger(strCodCfg: String; intValCfg: Integer);
begin
  If qryConf.Locate('CFG_CODCFG', strCodCfg, []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_VALCFG').AsInteger := intValCfg;
    qryConf.Post;
  End;
end;

end.
