unit untConfEmb;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untIConfEmb, Uni,  Variants;

Type
  TConfEmb = class(TInterfacedObject, IConfEmb)
  private
    strIdePro: String;
    qryConf: TUniQuery;
    function fExisteConfiguracao(strCodCfg, strEmbala, strLinha_:String): Boolean;
  public
    constructor Create(strIdePro: String); virtual;
    function fGet(strCodCfg: String): String; virtual;
    procedure pSet(strCodCfg: String; strValCfg: String); virtual;
    destructor Destroy; override;
    procedure pInsereCodigo(strCodCfg, strEmbala, strLinha_, strCodIte: String);
  End;

implementation

uses
  SysUtils, DB, StrUtils,untConstantes;

{ TConfEmb }

constructor TConfEmb.Create(strIdePro: String);
begin
  Self.strIdePro := strIdePro;
  qryConf := fCriaQuery();
  
  qryConf.SQL.Add(' SELECT ');
  qryConf.SQL.Add('   CFG_CODEMP, ');
  qryConf.SQL.Add('   CFG_IDEPRO, ');
  qryConf.SQL.Add('   CFG_CODCFG, ');
  qryConf.SQL.Add('   CFG_EMBALA, ');
  qryConf.SQL.Add('   CFG_LINHA_, ');
  qryConf.SQL.Add('   CFG_CODITE, ');
  qryConf.SQL.Add('   CFG_PRINCI  ');
  qryConf.SQL.Add(' FROM CFGEMB ');
  qryConf.SQL.Add(' WHERE CFG_CODEMP = :CODEMP ');
  qryConf.SQL.Add('     AND CFG_IDEPRO = :IDEPRO ');

  qryConf.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConf.ParamByName('IDEPRO').AsString := strIdePro;
  qryConf.Open;

end;

destructor TConfEmb.Destroy;
begin
  FreeAndNil(qryConf);
  inherited;
end;

function TConfEmb.fExisteConfiguracao(strCodCfg, strEmbala,
  strLinha_: String): Boolean;
var
  qryCon: TUniQuery;
begin
  Result := False;
  qryCon := nil;
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT TRUE   ');
        SQL.Add('   FROM CFGEMB ');
        SQL.Add('  WHERE CFG_CODEMP = :CODEMP ');
        SQL.Add('    AND CFG_IDEPRO = :IDEPRO ');
        SQL.Add('    AND CFG_CODCFG = :CODCFG ');
        SQL.Add('    AND CFG_EMBALA = :EMBALA ');
        SQL.Add('    AND CFG_LINHA_ = :LINHA_ ');
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('IDEPRO').AsString := strIdePro;
        ParamByName('CODCFG').AsString := strCodCfg;
        ParamByName('EMBALA').AsString := strEmbala;
        ParamByName('LINHA_').AsString := strLinha_;
        Open;

        Result := Not IsEmpty;
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryCon) then FreeAndNil(qryCon);
  End;
end;

function TConfEmb.fGet(strCodCfg: String): String;
begin
  Result := '';
  If qryConf.Locate('CFG_CODCFG;CFG_PRINCI', VarArrayOf([strCodCfg,'S']), []) Then
    Result := qryConf.FieldByName('CFG_CODITE').AsString;
end;

procedure TConfEmb.pInsereCodigo(strCodCfg, strEmbala, strLinha_, strCodIte: String);
  Var
    qryGen: TUniQuery;
begin
  If (Not fExisteConfiguracao(strCodCfg, strEmbala, strLinha_)) And (Not fEmptyStr(strCodIte)) Then
  Begin
    Try
      qryGen := fCriaQuery(Nil);
      qryGen.SQL.Add(' INSERT INTO CFGEMB ');
      qryGen.SQL.Add('             (CFG_CODEMP, ');
      qryGen.SQL.Add('              CFG_IDEPRO, ');
      qryGen.SQL.Add('              CFG_CODCFG, ');
      qryGen.SQL.Add('              CFG_EMBALA, ');
      qryGen.SQL.Add('              CFG_LINHA_, ');
      qryGen.SQL.Add('              CFG_CODITE, ');
      qryGen.SQL.Add('              CFG_PRINCI) ');
      qryGen.SQL.Add(' VALUES (:CFG_CODEMP, ');
      qryGen.SQL.Add('         :CFG_IDEPRO, ');
      qryGen.SQL.Add('         :CFG_CODCFG, ');
      qryGen.SQL.Add('         :CFG_EMBALA, ');
      qryGen.SQL.Add('         :CFG_LINHA_, ');
      qryGen.SQL.Add('         :CFG_CODITE, ');
      qryGen.SQL.Add('         :CFG_PRINCI); ');

      qryGen.ParamByName('CFG_CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('CFG_IDEPRO').AsString := strIdePro;
      qryGen.ParamByName('CFG_CODCFG').AsString := strCodCfg;
      qryGen.ParamByName('CFG_EMBALA').AsString := UpperCase(strEmbala);
      qryGen.ParamByName('CFG_LINHA_').AsString := UpperCase(strLinha_);
      qryGen.ParamByName('CFG_CODITE').AsString := strCodIte;
      qryGen.ParamByName('CFG_PRINCI').AsString := 'S';

      Try
        qryGen.ExecSQL;
        fCommit;
      Except
        On E: EUniError Do
        Begin
          If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT  Then
            Raise;
        End;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;

  qryConf.Close;
  qryConf.Open;
end;

procedure TConfEmb.pSet(strCodCfg, strValCfg: String);
begin
  If qryConf.Locate('CFG_CODCFG;CFG_PRINCI', VarArrayOf([strCodCfg,'S']), []) Then
  Begin
    qryConf.Edit;
    qryConf.FieldByName('CFG_CODITE').AsString := strValCfg;
    qryConf.Post;
  End;
end;

end.

