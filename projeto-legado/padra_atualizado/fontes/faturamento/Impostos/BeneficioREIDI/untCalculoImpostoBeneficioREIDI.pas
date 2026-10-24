unit untCalculoImpostoBeneficioREIDI;

interface

uses untTypesBeneficioREIDI, Shared.Functions.Core;

type
  TCalculoImpostoBeneficioREIDI = class
  private
    FCore: IFunctionsCore;
    FValDesBenRei: Double;
    function EhDevolucao(const AParametros: TParametrosCalculoBeneficioREIDI): Boolean;
    procedure BaixaDeEntregaFuturaComDesconto(var AValDesBenRei: Double; const AParametros: TParametrosCalculoBeneficioREIDI);
    procedure SomarPisCofins(const AParametros: TParametrosCalculoBeneficioREIDI);
    procedure DeduzirIcmsDoBeneficioREIDI(const AParametros: TParametrosCalculoBeneficioREIDI);
  public
    constructor Create(const ACore: IFunctionsCore);
    function CalcularBeneficioREIDI(const AParametros: TParametrosCalculoBeneficioREIDI): TResultadoCalculoBeneficioREIDI;
  End;

implementation

uses SysUtils;

{ TCalculoImpostoBeneficioREIDI }

procedure TCalculoImpostoBeneficioREIDI.BaixaDeEntregaFuturaComDesconto(var AValDesBenRei: Double; const AParametros: TParametrosCalculoBeneficioREIDI);
begin
  If Not AParametros.BeneficioREIDI Then
    Exit;

  If (EhDevolucao(AParametros)) Then
    Exit;

  If (Not AParametros.EhBaixaDeEntregaFutura) Then
    Exit;

  If (AParametros.DescontoEspecialBaixaDeEntregaFutura <= 0) Then
    Exit;

  AValDesBenRei := AParametros.DescontoEspecialBaixaDeEntregaFutura;
end;

function TCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(
  const AParametros: TParametrosCalculoBeneficioREIDI): TResultadoCalculoBeneficioREIDI;
begin
  FValDesBenRei := 0;
  FillChar(Result, SizeOf(Result), #0);
  SomarPisCofins(AParametros);
  DeduzirIcmsDoBeneficioREIDI(AParametros);
  BaixaDeEntregaFuturaComDesconto(FValDesBenRei, AParametros);
  Result.ValorDoDescontoBeneficioREIDI := FValDesBenRei;
end;

constructor TCalculoImpostoBeneficioREIDI.Create(const ACore: IFunctionsCore);
begin
  FCore := ACore;
end;

function TCalculoImpostoBeneficioREIDI.EhDevolucao(const AParametros: TParametrosCalculoBeneficioREIDI): Boolean;
begin
  Result := (Not AParametros.EspecieDeDevolucao.IsEmpty);
end;

procedure TCalculoImpostoBeneficioREIDI.SomarPisCofins(const AParametros: TParametrosCalculoBeneficioREIDI);
begin
  If (Not AParametros.BeneficioREIDI) Then
    Exit;

  If (AParametros.EhOptanteDoSimples) Then
    Exit;

  If (EhDevolucao(AParametros)) Then
    Exit;

  FValDesBenRei := FValDesBenRei + FCore.fFormataFloat((AParametros.BasePis * AParametros.AliquotaPis) / 100, 2);
  FValDesBenRei := FValDesBenRei + FCore.fFormataFloat((AParametros.BaseCofins * AParametros.AliquotaCofins) / 100, 2);
end;

procedure TCalculoImpostoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI(const AParametros: TParametrosCalculoBeneficioREIDI);
begin
  If Not AParametros.BeneficioREIDI Then
    Exit;

  If (AParametros.EhOptanteDoSimples) Then
    Exit;

  If (EhDevolucao(AParametros)) Then
    Exit;

  If Not AParametros.DeduzirIcmsDoBeneficioREIDI Then
    Exit;

  If AParametros.AliquotaDeIcmsDoItem <= 0 Then
    Exit;

  If AParametros.ValorDoIcmsDoItem <= 0 Then
    Exit;

  FValDesBenRei := FValDesBenRei + AParametros.ValorDoIcmsDoItem;
  FValDesBenRei := FCore.fFormataFloat((AParametros.ValorTotalDoItem - ( (AParametros.ValorTotalDoItem - FValDesBenRei) / (1- (AParametros.AliquotaDeIcmsDoItem / 100)) )), 2);
end;

end.
