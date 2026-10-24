unit untTefCitelIntervalos;

interface

uses
  untInterfaceTefCitel, System.SysUtils, System.Generics.Collections, System.Classes, System.StrUtils ;

type
  TIntervalo = class(TInterfacedObject, IIntervalo)
  private
    FInicio: TDatetime;
    FFim: TDateTime;
    FTipo: TTipoIntervalo;
  public
    function Inicio: TDateTime; overload;
    function Inicio(AValue: TDateTime): IIntervalo; overload;
    function Fim: TDateTime; overload;
    function Fim(AValue: TDateTime): IIntervalo; overload;
    function Tipo: TTipoIntervalo; overload;
    function Tipo(AValue: TTipoIntervalo): IIntervalo; overload;

    class function New: IIntervalo;
  End;

  TIntervalosTEF = class(TInterfacedObject, IIntervalosTEF)
  private
    FTransacao: IIntervalo;
    FEspera: TList<IIntervalo>;
  public
    function Transacao: IIntervalo;
    function Espera: TList<IIntervalo>;

    constructor Create;
    destructor Destroy; override;
    class function New: TIntervalosTEF;
  End;

  TRegistraIntervalos = class
  private
    FIntervalos: IIntervalosTEF;
    FEmRegistro: Boolean;
    function fEsperaContemTipo(ATipo: TTipoIntervalo): Boolean;

    function fUltimoIntervaloEspera: IIntervalo;
  public
    procedure pResetar;
    function fIntervaloEmRegistro: Boolean;
    function fObjIntervalos: IIntervalosTEF;

    procedure pInicioTransacao;
    procedure pFimTransacao;
    procedure pInicioEspera(ATipo: TTipoIntervalo);
    procedure pFimEspera(ATipo: TTipoIntervalo; AblnPrimeiraOcorrencia: Boolean = False);
    procedure pFinalizaUltimaEspera;

    constructor Create();
  end;

implementation

{ TIntervalo }

function TIntervalo.Fim: TDateTime;
begin
  Result := FFim;
end;

function TIntervalo.Fim(AValue: TDateTime): IIntervalo;
begin
  FFim := AValue;
  Result := Self;
end;

function TIntervalo.Inicio: TDateTime;
begin
  Result := FInicio;
end;

function TIntervalo.Inicio(AValue: TDateTime): IIntervalo;
begin
  FInicio := AValue;
  Result := Self;
end;

class function TIntervalo.New: IIntervalo;
begin
  Result := Self.Create;
end;

function TIntervalo.Tipo: TTipoIntervalo;
begin
  Result := FTipo;
end;

function TIntervalo.Tipo(AValue: TTipoIntervalo): IIntervalo;
begin
  FTipo := AValue;
  Result := Self;
end;

{ TIntervalosTEF }

constructor TIntervalosTEF.Create;
begin
  FTransacao := TIntervalo.New.Tipo(tiTransacao);
  FEspera := TList<IIntervalo>.Create;
end;

function TIntervalosTEF.Espera: TList<IIntervalo>;
begin
  Result := FEspera;
end;

destructor TIntervalosTEF.Destroy;
begin
  FreeAndNil(FEspera);
  inherited;
end;

class function TIntervalosTEF.New: TIntervalosTEF;
begin
  Result := Self.Create;
end;

function TIntervalosTEF.Transacao: IIntervalo;
begin
  Result := FTransacao;
end;

{ TRegistraIntervalos }

constructor TRegistraIntervalos.Create();
begin
  FIntervalos := TIntervalosTEF.New;
  pResetar;
end;

function TRegistraIntervalos.fIntervaloEmRegistro: Boolean;
begin
  Result := Self.FEmRegistro;
end;

function TRegistraIntervalos.fObjIntervalos: IIntervalosTEF;
var LIntervalo: IIntervalo;
begin
  Result := Nil;

  if FIntervalos.Transacao.Inicio = 0 then
    Exit;

  Result := TIntervalosTEF.New;

  Result.Transacao.Inicio(FIntervalos.Transacao.Inicio).Fim(FIntervalos.Transacao.Fim);

  for LIntervalo in FIntervalos.Espera do
    Result.Espera.Add(LIntervalo);
end;

function TRegistraIntervalos.fEsperaContemTipo(ATipo: TTipoIntervalo): Boolean;
var LIntervalo: IIntervalo;
begin
  Result := False;
  for LIntervalo in Self.FIntervalos.Espera do
  begin
    Result := LIntervalo.Tipo = tiSenha;

    if Result then
      break;
  end;
end;

function TRegistraIntervalos.fUltimoIntervaloEspera: IIntervalo;
begin
  Result := nil;
  if FIntervalos.Espera.Count > 0 then
  Result := FIntervalos.Espera[FIntervalos.Espera.Count - 1];
end;

procedure TRegistraIntervalos.pFimEspera(ATipo: TTipoIntervalo; AblnPrimeiraOcorrencia: Boolean = False);
var
  LUltimoIntervalo: IIntervalo;
begin
  LUltimoIntervalo := fUltimoIntervaloEspera;

  if not Assigned(LUltimoIntervalo) then
    Exit;

  if LUltimoIntervalo.Tipo <> ATipo then
    Exit;

  if AblnPrimeiraOcorrencia and (LUltimoIntervalo.Fim <> 0) then
    Exit;

  LUltimoIntervalo.Fim(Now());
end;

procedure TRegistraIntervalos.pFimTransacao;
begin
  pFinalizaUltimaEspera;
  FIntervalos.Transacao.Fim(Now());
  FEmRegistro := False;
end;

procedure TRegistraIntervalos.pFinalizaUltimaEspera;
var
  LUltimoIntervalo: IIntervalo;
begin
  LUltimoIntervalo := fUltimoIntervaloEspera;
  if Assigned(LUltimoIntervalo) then
    Self.pFimEspera(LUltimoIntervalo.Tipo, true);
end;

procedure TRegistraIntervalos.pInicioEspera(ATipo: TTipoIntervalo);
var
  LUltimoIntervalo: IIntervalo;
begin
  LUltimoIntervalo := fUltimoIntervaloEspera;

  if Assigned(LUltimoIntervalo) and (ATipo = LUltimoIntervalo.Tipo) then
    Exit;

  if (ATipo = tiRetirarCartao) and (not fEsperaContemTipo(tiSenha)) then
    Exit;

  pFinalizaUltimaEspera;

  FIntervalos.Espera.Add(TIntervalo.New.Tipo(ATipo).Inicio(Now()));
end;

procedure TRegistraIntervalos.pInicioTransacao;
begin
  Self.pResetar;
  FIntervalos.Transacao.Inicio(Now());
  FEmRegistro := True;
end;

procedure TRegistraIntervalos.pResetar;
begin
  FIntervalos.Transacao.Inicio(0).Fim(0);
  FIntervalos.Espera.Clear;
  FEmRegistro := False;
end;

end.
