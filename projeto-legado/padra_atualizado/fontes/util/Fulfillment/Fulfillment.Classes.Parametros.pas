unit Fulfillment.Classes.Parametros;

interface

Uses
  Classes, System.SysUtils, Rtti;

Type

  TFulfillment = Class
  private
    FEhOperacaoFulfillment  : Boolean;
    FEhOperacaoDeRemessa    : Boolean;
    FEhEstoqueExterno       : Boolean;
    FSiglaHubMarketPlace    : String;
    FCodigoDoEstoqueExterno : String;
    FChaveDeAcesso          : String;
    FNumeroPedido           : String;
    FEmpresaPedido          : String;
    FClassificacaoFiscal    : String;
    FDataDeEntrada          : TDateTime;
  public

    constructor New; Reintroduce;
    destructor Destroy; Override;

    procedure Limpar;
    procedure CopyFrom(AOrigem : TFulfillment);

    property EhOperacaoFulfillment  : Boolean   Read FEhOperacaoFulfillment   Write FEhOperacaoFulfillment;
    property EhOperacaoDeRemessa    : Boolean   Read FEhOperacaoDeRemessa     Write FEhOperacaoDeRemessa;
    property EhEstoqueExterno       : Boolean   Read FEhEstoqueExterno        Write FEhEstoqueExterno;
    property SiglaHubMarketPlace    : String    Read FSiglaHubMarketPlace     Write FSiglaHubMarketPlace;
    property CodigoDoEstoqueExterno : String    Read FCodigoDoEstoqueExterno  Write FCodigoDoEstoqueExterno;
    property ChaveDeAcesso          : String    Read FChaveDeAcesso           Write FChaveDeAcesso;
    property NumeroPedido           : String    Read FNumeroPedido            Write FNumeroPedido;
    property EmpresaPedido          : String    Read FEmpresaPedido           Write FEmpresaPedido;
    property ClassificacaoFiscal    : String    Read FClassificacaoFiscal     Write FClassificacaoFiscal;
    property DataDeEntrada          : TDateTime Read FDataDeEntrada           Write FDataDeEntrada;

  End;

implementation

{ TFulfillment }

procedure TFulfillment.CopyFrom(AOrigem: TFulfillment);
var
  ctx  : TRttiContext;
  rType: TRttiType;
  rProp: TRttiProperty;

  LValue, LSource, LTarget: TValue;

begin

  If Not Assigned(AOrigem) Then
    Exit;

  ctx := TRttiContext.Create;

  rType   := ctx.GetType(AOrigem.ClassInfo);
  LSource := TValue.From<TFulfillment>(AOrigem);
  LTarget := TValue.From<TFulfillment>(Self);

  for rProp in rType.GetProperties do
  begin

    If Not rProp.IsWritable Then
      Continue;

    LValue := rProp.GetValue(LSource.AsObject);
    rProp.SetValue(LTarget.AsObject, LValue);

  end;

end;

destructor TFulfillment.Destroy;
begin
  inherited;
end;

procedure TFulfillment.Limpar;
begin
  Self.FEhOperacaoFulfillment  := False;
  Self.FEhOperacaoDeRemessa    := False;
  Self.FEhEstoqueExterno       := False;
  Self.FSiglaHubMarketPlace    := EmptyStr;
  Self.FCodigoDoEstoqueExterno := EmptyStr;
  Self.FChaveDeAcesso          := EmptyStr;
  Self.FNumeroPedido           := EmptyStr;
  Self.FEmpresaPedido          := EmptyStr;
  Self.FClassificacaoFiscal    := EmptyStr;
  Self.FDataDeEntrada          := 0;
end;

constructor TFulfillment.New;
begin
  Self.Limpar;
  inherited;
end;

end.
