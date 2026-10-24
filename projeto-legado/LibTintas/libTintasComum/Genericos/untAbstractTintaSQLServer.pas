unit untAbstractTintaSQLServer;

interface

uses
{$IFNDEF LINUX}
  ADODB,
  Forms,
{$ENDIF}
SysUtils, StrUtils, Uni, Classes, DB, untBaseAutomotiva;

Type
  TTipoPreparoTinta = (tpsConcentrado, tpsDiluido, tpsResina325);

Type
  TFormulaTintasSQLServer = class(TObject)
  private

    function GetBases(Index: Integer): TBaseAutomotiva;
    function GetCount(): Integer;
  public
    lstBases: TList;
    Constructor Create;
    Destructor Destroy; Override;
    property Base[Index: Integer]: TBaseAutomotiva Read GetBases;
    property Count: Integer Read GetCount;
  End;

Type
  TAbstractTintaSQLServer = class abstract(TObject)
    constructor Create(strIdCor: String; strLinha:String);
    destructor Destroy; Override;
  public
    strIdCor: String;
    strLinha: String;
    function fCalculaFormulacao(fltVolume:Double;
      tpsTipoPreparo: TTipoPreparoTinta): TFormulaTintasSQLServer; virtual;
{$IFNDEF LINUX}
    function fExecutarProcedureCalculoFormula(fltVolume:Double;
      tpsTipoPreparo: TTipoPreparoTinta): TADOQuery; virtual;
{$ENDIF}
    function fFormulaDiluida(tpsTipoPreparo: TTipoPreparoTinta): Boolean; virtual;
    function fFormulaResina325(tpsTipoPreparo: TTipoPreparoTinta): Boolean; virtual;
  end;

implementation


{ TFormulaTintasSQLServer }

constructor TFormulaTintasSQLServer.Create;
begin
  lstBases := TList.Create;
end;

destructor TFormulaTintasSQLServer.Destroy;
Var
  obj: TObject;
  ptn: Pointer;
begin
  For ptn In lstBases Do
  Begin
    obj := TObject(ptn);
    FreeAndNil(obj);
  End;

  lstBases.Clear;
  FreeAndNil(lstBases);
  inherited;
end;

function TFormulaTintasSQLServer.GetBases(Index: Integer): TBaseAutomotiva;
begin
  Result := TBaseAutomotiva(lstBases[Index]);
end;


function TFormulaTintasSQLServer.GetCount: Integer;
begin
  Result := lstBases.Count;
end;

{ TAbstractTintaSQLServer }

constructor TAbstractTintaSQLServer.Create(strIdCor, strLinha: String);
begin
  Self.strIdCor := strIdCor;
  Self.strLinha := strLinha;
end;

destructor TAbstractTintaSQLServer.Destroy;
begin
  inherited;
end;

function TAbstractTintaSQLServer.fCalculaFormulacao(fltVolume: Double;
  tpsTipoPreparo: TTipoPreparoTinta): TFormulaTintasSQLServer;
begin
  Result := Nil;
end;

{$IFNDEF LINUX}
function TAbstractTintaSQLServer.fExecutarProcedureCalculoFormula(
  fltVolume: Double; tpsTipoPreparo: TTipoPreparoTinta): TADOQuery;
begin
  Result := Nil;
end;
{$ENDIF}

function TAbstractTintaSQLServer.fFormulaDiluida(
  tpsTipoPreparo: TTipoPreparoTinta): Boolean;
begin
  Result := False;
end;

function TAbstractTintaSQLServer.fFormulaResina325(
  tpsTipoPreparo: TTipoPreparoTinta): Boolean;
begin
  Result := False;
end;

end.
