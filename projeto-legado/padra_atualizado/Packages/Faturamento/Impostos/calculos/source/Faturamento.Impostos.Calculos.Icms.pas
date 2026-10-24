unit Faturamento.Impostos.Calculos.Icms;

interface

uses Faturamento.Impostos.Interfaces.Icms, Faturamento.Impostos.Tipos.Icms,
  Shared.Functions.Core, Shared.Functions.Funcoes.Faturamento;

type
  TCalculoImpostosIcms = class(TInterfacedObject, ICalculoImpostosIcms)
  private
    FParametros: IParametrosCalculoIcms;

    FAliquotaIcms :Double;
    FBaseIcms     :Double;
    FValorIcms    :Double;

    FValorDaDiferencaDeIcms :Double;
    FPercentualDaBaseDeIcms :Double;

    function ClienteZonaFrancaOrgaoPublico: Boolean;
    function ArredondaValorIcms(AValor: Double; AQtdDec: Integer): Double;
    function ValidarImportacaoDireta: Boolean;

    procedure ZerandoAliquotaBaseValorIcms;

    procedure CalculoIcmsParaItemComSubstituicaoTributaria;
    Procedure CalcularIcmsParaItemComSubstituicaoTributaria;
    procedure CalcularIcmsParaItemSemSubstituicaoTributaria;

    procedure CalcularValorDaDiferencaIcmsParaReducaoRICMPR;

    function ZerarValorSemImportacaoDiretaESemReducaoDaBaseIcmsSt : Boolean;
    function ValidarReducaoRICMPR : Boolean;
    procedure CalculoIcmsForaDoEstado;

    function ValidarDentroDoEstado : Boolean;
    Function ZerandoAliquotaBaseValorIcmsSemImportacaoDiretaESemReducaoDaBaseIcmsSt: Boolean;

    function ValidarSubstituicaoTributariaDoItem : Boolean;
    procedure CalcularIcmsForaDoEstado;
    procedure CalcularValorDoIcms;
    procedure CalcularIcmsDentroDoEstado;
    procedure CalcularIcmsForaDaZonaFranca;
    function RetornarValorDoIpiDoItem: double;
    procedure ValidarSeDeveZerarValoresIcms;    


  public
    function CalcularValorIcms(AParametros: IParametrosCalculoIcms): IResultadoCalculoIcms;
    class function New(): ICalculoImpostosIcms;
  end;

  function CalcularValorIcms(AParametros: IParametrosCalculoIcms): IResultadoCalculoIcms; stdCall;

implementation

function CalcularValorIcms(AParametros: IParametrosCalculoIcms): IResultadoCalculoIcms; stdCall;
begin
  Result := TCalculoImpostosIcms.New.CalcularValorIcms(AParametros);
end;

{ TCalculoImpostosIcms }

procedure TCalculoImpostosIcms.CalculoIcmsParaItemComSubstituicaoTributaria;
begin
  FBaseIcms  := objCore.fFormataFloat((((FParametros.TotalGeralDoItem + RetornarValorDoIpiDoItem) * FParametros.PercentualDaBaseDeIcmsDoItem) / 100), 2);
  FValorIcms := ArredondaValorIcms((FBaseIcms * FParametros.AliquotaDeIcmsDoItem) / 100, 2);
end;

procedure TCalculoImpostosIcms.CalcularIcmsParaItemComSubstituicaoTributaria;
begin
  If ZerandoAliquotaBaseValorIcmsSemImportacaoDiretaESemReducaoDaBaseIcmsSt Then
    Exit;

  CalculoIcmsParaItemComSubstituicaoTributaria;
end;

procedure TCalculoImpostosIcms.CalcularIcmsParaItemSemSubstituicaoTributaria;
begin
  FBaseIcms  := objCore.fFormataFloat((((FParametros.TotalGeralDoItem + RetornarValorDoIpiDoItem) * FParametros.PercentualDaBaseDeIcmsDoItem) / 100), 2);
  FValorIcms := ArredondaValorIcms((FBaseIcms * FParametros.AliquotaDeIcmsDoItem) / 100, 2);
end;

procedure TCalculoImpostosIcms.CalcularValorDaDiferencaIcmsParaReducaoRICMPR;
begin
  If not ValidarReducaoRICMPR Then
    Exit;

  FValorDaDiferencaDeIcms := FValorIcms;
  FPercentualDaBaseDeIcms := 100 - FParametros.PercentualDeReducaoDaBaseDeIcms;

  FValorIcms := ArredondaValorIcms(FValorIcms * (FPercentualDaBaseDeIcms/100), 2);
  FValorDaDiferencaDeIcms := FValorDaDiferencaDeIcms - FValorIcms;
end;

procedure TCalculoImpostosIcms.ValidarSeDeveZerarValoresIcms;
begin
  If FValorIcms > 0 Then
    Exit;

  FAliquotaIcms := 0.0;
  FBaseIcms := 0.0;
  FValorIcms := 0.0;
end;

function TCalculoImpostosIcms.CalcularValorIcms(
  AParametros: IParametrosCalculoIcms): IResultadoCalculoIcms;
var
  LBaseIcmsBenST: Double;
begin
  ZerandoAliquotaBaseValorIcms;

  FParametros    := AParametros;
  FAliquotaIcms  := AParametros.AliquotaDeIcmsDoItem;

  FPercentualDaBaseDeIcms := AParametros.PercentualDaBaseDeIcmsDoItem;
  FValorDaDiferencaDeIcms := 0;

  CalcularValorDoIcms;

  LBaseIcmsBenST := FBaseIcms;

  ValidarSeDeveZerarValoresIcms;

  Result := TResultadoCalculoIcms.New
              .AliquotaDoIcms(FAliquotaIcms)
              .BaseDeCalculoDoIcms(FBaseIcms)
              .ValorCalculadoDoIcms(FValorIcms)
              .PercentualDaBaseDeIcms(FPercentualDaBaseDeIcms)
              .ValorDaDiferencaDeIcms(FValorDaDiferencaDeIcms)
              .PercentualDeReducaoDaBaseDeIcms(FParametros.PercentualDeReducaoDaBaseDeIcms)
              .EntraIPINaBaseIcms(FParametros.EntraIPINaBaseIcms)
              .BaseDeCalculoDoIcmsDoItemBenST(LBaseIcmsBenST);
end;

procedure TCalculoImpostosIcms.CalcularValorDoIcms;
begin
  If ValidarDentroDoEstado Then
  Begin
    CalcularIcmsDentroDoEstado;
    Exit;
  End;

  CalcularIcmsForaDoEstado;
end;

procedure TCalculoImpostosIcms.CalcularIcmsDentroDoEstado;
begin
  If (Not ClienteZonaFrancaOrgaoPublico) then
    CalcularIcmsForaDaZonaFranca;

  CalcularValorDaDiferencaIcmsParaReducaoRICMPR;
end;

procedure TCalculoImpostosIcms.CalcularIcmsForaDaZonaFranca;
begin
  If ValidarSubstituicaoTributariaDoItem  Then
  begin
    CalcularIcmsParaItemComSubstituicaoTributaria;
    Exit;
  end;

  CalcularIcmsParaItemSemSubstituicaoTributaria;
end;

procedure TCalculoImpostosIcms.CalcularIcmsForaDoEstado;
begin
  CalculoIcmsForaDoEstado;
end;

Function TCalculoImpostosIcms.ZerandoAliquotaBaseValorIcmsSemImportacaoDiretaESemReducaoDaBaseIcmsSt : Boolean;
begin
  Result := True;

  If ZerarValorSemImportacaoDiretaESemReducaoDaBaseIcmsSt Then
  Begin
    ZerandoAliquotaBaseValorIcms;
    Exit;
  End;

  Result := False;
end;

procedure TCalculoImpostosIcms.CalculoIcmsForaDoEstado;
begin
  FBaseIcms  := objCore.fFormataFloat(((FParametros.TotalGeralDoItem * FParametros.PercentualDaBaseDeIcmsDoItem) / 100) + RetornarValorDoIpiDoItem, 2);
  FValorIcms := ArredondaValorIcms((FBaseIcms * FParametros.AliquotaDeIcmsDoItem) / 100, 2);
end;

function TCalculoImpostosIcms.ClienteZonaFrancaOrgaoPublico: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.ClienteZonaFrancaOrgaoPublico(
      FParametros.ClienteOrgaoPublico, FParametros.CalcularDescontoIcmsOrgaoPublico,
      FParametros.ClienteZonaFranca, FParametros.ClienteConsumidorFinal);
end;

function TCalculoImpostosIcms.ArredondaValorIcms(AValor: Double;
  AQtdDec: Integer): Double;
begin
  Result := objCore.fFormataFloat(AValor, AQtdDec);

  If Assigned(FParametros.MetodoArredondamentoICMSECF) Then
    Result := FParametros.MetodoArredondamentoICMSECF(AValor);
end;

function TCalculoImpostosIcms.ValidarImportacaoDireta: Boolean;
begin
  Result := false;

  If FParametros.UtilizaImportacaoDireta Then
    Result := FParametros.ItemImportacaoDireta;
end;

class function TCalculoImpostosIcms.New: ICalculoImpostosIcms;
begin
  Result := Self.Create;
end;

procedure TCalculoImpostosIcms.ZerandoAliquotaBaseValorIcms;
begin
  FAliquotaIcms := 0.0;
  FBaseIcms     := 0.0;
  FValorIcms    := 0.0;
end;

function TCalculoImpostosIcms.ValidarDentroDoEstado: Boolean;
begin
  Result := true;

  If FParametros.VendaDentroDoEstado Then
    Exit;

  Result := false;
end;

function TCalculoImpostosIcms.ValidarReducaoRICMPR: Boolean;
begin
  Result := True;

  If FParametros.UtilizarReducaoRICMPR Then
    Exit;

  Result := false;
end;

function TCalculoImpostosIcms.ValidarSubstituicaoTributariaDoItem: Boolean;
begin
  Result := True;

  If FParametros.SubstituicaoTributariaDoItem Then
    Exit;

  Result := False;
end;

function TCalculoImpostosIcms.ZerarValorSemImportacaoDiretaESemReducaoDaBaseIcmsSt: Boolean;
begin
  Result := false;

  If ValidarImportacaoDireta Then
    Exit;

  if FParametros.CalculaBeneficioReducaoBaseIcmsST Then
    Exit;

  Result := true;
end;

function TCalculoImpostosIcms.RetornarValorDoIpiDoItem: double;
begin
  result := 0;
  
  If not FParametros.EntraIPINaBaseIcms Then
    Exit;

  result := FParametros.ValorDoIpiDoItem; 
end;

// exports CalcularValorIcms;

end.
