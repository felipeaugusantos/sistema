unit Faturamento.Auditoria.Cat17;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  System.SysUtils, Data.DB, System.Math,
  Faturamento.Auditoria.Interfaces.Cat17, Core.Funcoes;

type
  TAuditoriaCat17 = class(TInterfacedObject, IAuditoriaCat17)
  private
    FC17Mod: Integer;
    FCodSit: String;
    FAlqRet: Double;
    FValIva: Double;
    FMCAT17: String;
    FResTot: Double;
    FDocumentoUltimaCompra: String;
    FFornecedorUltimaCompra: String;
    FTeveReducao: Boolean;
    FCodIte: String;
    FCdsAuditoriaCat17: TUniClientDataSet;

    function CriarClientAuditoriaCat17: TUniClientDataSet;
    function RetornarValorDouble(const AValue: Double): Double;
  public
    function GetC17Mod: Integer;
    function SetC17Mod(AValue: Integer): IAuditoriaCat17;

    function GetCodSit: String;
    function SetCodSit(AValue: String): IAuditoriaCat17;

    function GetAlqRet: Double;
    function SetAlqRet(AValue: Double): IAuditoriaCat17;

    function GetValIva: Double;
    function SetValIva(AValue: Double): IAuditoriaCat17;

    function GetMCAT17: String;
    function SetMCAT17(AValue: String): IAuditoriaCat17;

    function GetResTot: Double;
    function SetResTot(AValue: Double): IAuditoriaCat17;

    function GetDocumentoUltimaCompra: String;
    function SetDocumentoUltimaCompra(AValue: String): IAuditoriaCat17;

    function GetFornecedorUltimaCompra: String;
    function SetFornecedorUltimaCompra(AValue: String): IAuditoriaCat17;

    function GetTeveReducao: Boolean;
    function SetTeveReducao(AValue: Boolean): IAuditoriaCat17;

    function GetCodIte: String;
    function SetCodIte(AValue: String): IAuditoriaCat17;

    procedure Adicionar;
    procedure Limpar;
    function GetCdsAuditoriaCat17: TUniClientDataSet;

    constructor Create;
    destructor Destroy; override;

    class function New(): IAuditoriaCat17;
  end;

implementation

{ TAuditoriaCat17 }

procedure TAuditoriaCat17.Adicionar;
begin
  If Not FTeveReducao Then
    Exit;

  If FCdsAuditoriaCat17.Locate('ITE_CAT17_CODITE', FCodIte, []) Then
    Exit;

  FCdsAuditoriaCat17.Append;
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_C17MOD').AsInteger   := FC17Mod;
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_CODSIT').AsString    := FCodSit;
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_ALQRET').AsFloat     := RetornarValorDouble(FAlqRet);
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_VALIVA').AsFloat     := RetornarValorDouble(FValIva);
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_MCAT17').AsString    := FMCAT17;
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_RESTOT').AsFloat     := RetornarValorDouble(FResTot);
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_DOCULTCOM').AsString := FDocumentoUltimaCompra;
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_FORULTCOM').AsString := FFornecedorUltimaCompra;
  FCdsAuditoriaCat17.FieldByName('ITE_CAT17_CODITE').AsString    := FCodIte;
  FCdsAuditoriaCat17.Post;
end;

constructor TAuditoriaCat17.Create;
begin
  inherited Create;
  Limpar;
  FCdsAuditoriaCat17 := CriarClientAuditoriaCat17;
end;

function TAuditoriaCat17.CriarClientAuditoriaCat17: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_C17MOD', ftInteger);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_CODSIT', ftString, 3);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_ALQRET', ftFloat);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_VALIVA', ftFloat);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_MCAT17', ftString, 1);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_RESTOT', ftFloat);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_DOCULTCOM', ftString, 50);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_FORULTCOM', ftString, 8);

  TCoreFuncoes.pAddFieldDefs(Result, 'ITE_CAT17_CODITE', ftString, 5);

  Result.CreateDataSet;
  Result.LogChanges := False;
end;

destructor TAuditoriaCat17.Destroy;
begin
  FreeAndNil(FCdsAuditoriaCat17);
  inherited;
end;

function TAuditoriaCat17.GetAlqRet: Double;
begin
  Result := FAlqRet;
end;

function TAuditoriaCat17.GetC17Mod: Integer;
begin
  Result := FC17Mod;
end;

function TAuditoriaCat17.GetCdsAuditoriaCat17: TUniClientDataSet;
begin
  Result := FCdsAuditoriaCat17;
end;

function TAuditoriaCat17.GetCodIte: String;
begin
  Result := FCodIte;
end;

function TAuditoriaCat17.GetCodSit: String;
begin
  Result := FCodSit;
end;

function TAuditoriaCat17.GetDocumentoUltimaCompra: String;
begin
  Result := FDocumentoUltimaCompra;
end;

function TAuditoriaCat17.GetFornecedorUltimaCompra: String;
begin
  Result := FFornecedorUltimaCompra;
end;

function TAuditoriaCat17.GetMCAT17: String;
begin
  Result := FMCAT17;
end;

function TAuditoriaCat17.GetResTot: Double;
begin
  Result := FResTot;
end;

function TAuditoriaCat17.GetTeveReducao: Boolean;
begin
  Result := FTeveReducao;
end;

function TAuditoriaCat17.GetValIva: Double;
begin
  Result := FValIva;
end;

procedure TAuditoriaCat17.Limpar;
begin
  FC17Mod := 0;
  FCodSit := '';
  FAlqRet := 0;
  FValIva := 0;
  FMCAT17 := '';
  FResTot := 0;
  FDocumentoUltimaCompra := '';
  FFornecedorUltimaCompra := '';
  FTeveReducao := False;
  FCodIte := '';
end;

class function TAuditoriaCat17.New: IAuditoriaCat17;
begin
  Result := Self.Create;
end;

function TAuditoriaCat17.RetornarValorDouble(const AValue: Double): Double;
begin
  Result := 0.0;

  If IsInfinite(AValue) Then
    Exit;

  If IsNan(AValue) Then
    Exit;

  Result := AValue;
end;

function TAuditoriaCat17.SetAlqRet(AValue: Double): IAuditoriaCat17;
begin
  Result := Self;
  FAlqRet := AValue;
end;

function TAuditoriaCat17.SetC17Mod(AValue: Integer): IAuditoriaCat17;
begin
  Result := Self;
  FC17Mod := AValue;
end;

function TAuditoriaCat17.SetCodIte(AValue: String): IAuditoriaCat17;
begin
  Result := Self;
  FCodIte := AValue;
end;

function TAuditoriaCat17.SetCodSit(AValue: String): IAuditoriaCat17;
begin
  Result := Self;
  FCodSit := AValue;
end;

function TAuditoriaCat17.SetDocumentoUltimaCompra(
  AValue: String): IAuditoriaCat17;
begin
  Result := Self;
  FDocumentoUltimaCompra := AValue;
end;

function TAuditoriaCat17.SetFornecedorUltimaCompra(
  AValue: String): IAuditoriaCat17;
begin
  Result := Self;
  FFornecedorUltimaCompra := AValue;
end;

function TAuditoriaCat17.SetMCAT17(AValue: String): IAuditoriaCat17;
begin
  Result := Self;
  FMCAT17 := AValue;
end;

function TAuditoriaCat17.SetResTot(AValue: Double): IAuditoriaCat17;
begin
  Result := Self;
  FResTot := AValue;
end;

function TAuditoriaCat17.SetTeveReducao(AValue: Boolean): IAuditoriaCat17;
begin
  Result := Self;
  FTeveReducao := AValue;
end;

function TAuditoriaCat17.SetValIva(AValue: Double): IAuditoriaCat17;
begin
  Result := Self;
  FValIva := AValue;
end;

end.
