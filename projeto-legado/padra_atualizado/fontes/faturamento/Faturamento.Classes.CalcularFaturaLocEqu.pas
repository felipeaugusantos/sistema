unit Faturamento.Classes.CalcularFaturaLocEqu;

interface

uses
  Classes, Math, System.DateUtils, System.SysUtils;

Type

  ICalcularPeriodoFatura = Interface['{6543FB61-7235-4E4A-BFD1-2E4F9F7EE8BA}']
    function CalcularDiariasFaturar(const ADtaUltFat, ADtaIps, ADtaIpe, ADtaRef: TDateTime;
      AConsiderar24hrs: Boolean; ADiaMen: Integer = 0): Integer;
    function ObtemDataInicialCobranca(const ADtaIps, ADtaUltFat: TDateTime) : TDateTime;
    function ObtemDataFinalCobranca(const ADtaIpe, ADtaRef, ADtaIni: TDateTime; ADiaMen: Integer; AConsiderar24hrs: Boolean) : TDateTime;
    function CalculaTotalDiasContratoComIntervalo24hrs(const ADtaIni, ADtaFin: TDateTime): Integer;
    function CalculaTotalDias(const ADtaIni, ADtaFin: TDateTime; AConsiderar24hrs: Boolean = True): Integer;
    function CalculaTotalMeses(const aDataInicial, aDataFinal: TDateTime; blnUtilizaDtaRef: Boolean = False): Integer;
    function CalculaTotalHoras(const aDataInicial, aDataFinal: TDateTime): Double;
  End;

  TCalcularPeriodoFatura =  class(TInterfacedObject, ICalcularPeriodoFatura)
  strict private
    FQuantidadeDiariasCalculada: Integer;
    FDataInicialCobranca: TDateTime;
    FDataFinalCobranca: TDateTime;

    function CalculaTotalDiasContratoComIntervalo24hrs(const ADtaIni, ADtaFin: TDateTime): Integer;
    function CalculaTotalDiasContratoSemIntervalo24hrs(const ADtaIni, ADtaFin: TDateTime): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    class function New(): ICalcularPeriodoFatura;
    function CalcularDiariasFaturar(const ADtaUltFat, ADtaIps, ADtaIpe, ADtaRef: TDateTime;
      AConsiderar24hrs: Boolean; ADiaMen: Integer = 0): Integer;
    function ObtemDataInicialCobranca(const ADtaIps, ADtaUltFat: TDateTime) : TDateTime;
    function ObtemDataFinalCobranca(const ADtaIpe, ADtaRef, ADtaIni: TDateTime; ADiaMen: Integer; AConsiderar24hrs: Boolean) : TDateTime;
    function CalculaTotalDias(const ADtaIni, ADtaFin: TDateTime; AConsiderar24hrs: Boolean= True): Integer;
    function CalculaTotalMeses(const aDataInicial, aDataFinal: TDateTime; blnUtilizaDtaRef: Boolean = False): Integer;
    function CalculaTotalHoras(const aDataInicial, aDataFinal: TDateTime): Double;
  End;

  ICalcularDecontoFatura = Interface['{5BE3F54E-4637-43DD-B9BA-C1BF6192DC51}']
    function CalcularDescontoPorValorLiquidoRestante(const ATotalBruto: Double; AValorRestante: Double; AValorJaFaturado: Double): Double;
  End;

  TCalcularDescontoFatura = Class(TInterfacedObject, ICalcularDecontoFatura)
  strict private
  public
    constructor Create;
    destructor Destroy; override;

    function CalcularDescontoPorValorLiquidoRestante(const ATotalBruto: Double; AValorRestante: Double; AValorJaFaturado: Double): Double;

    class function New(): ICalcularDecontoFatura;
  End;

implementation

uses
  untFuncoesSimples, untFuncoesLocEqu;

{ TCalcularPeriodoFatura }

function TCalcularPeriodoFatura.ObtemDataFinalCobranca(Const ADtaIpe, ADtaRef, ADtaIni: TDateTime;
  ADiaMen: Integer; AConsiderar24hrs: Boolean): TDateTime;
var
  LQtdDias: Integer;
  LDataFinal: TDateTime;
begin
  LDataFinal := IIF(ADtaIpe > 0, ADtaIpe, ADtaRef);

  If ADiaMen > 0 Then
  Begin
    LQtdDias := CalculaTotalDias(ADtaIni, LDataFinal, AConsiderar24hrs);

    If (LQtdDias >= ADiaMen) Then
    Begin
      Result := ADtaIni + ADiaMen;
    End
    Else
    Begin
      Result := LDataFinal;
    End;
  End
  Else
  Begin
    Result := LDataFinal;
  End;
end;

function TCalcularPeriodoFatura.ObtemDataInicialCobranca(const ADtaIps, ADtaUltFat: TDateTime): TDateTime;
begin
  Result := IIF(ADtaUltFat <= 0, ADtaIps, ADtaUltFat);
end;

function TCalcularPeriodoFatura.CalcularDiariasFaturar(const ADtaUltFat,
  ADtaIps, ADtaIpe, ADtaRef: TDateTime; AConsiderar24hrs: Boolean; ADiaMen: Integer): Integer;
begin
  FDataInicialCobranca := ObtemDataInicialCobranca(ADtaIps, ADtaUltFat);
  FDataFinalCobranca := ObtemDataFinalCobranca(ADtaIpe, ADtaRef, FDataInicialCobranca, ADiaMen, AConsiderar24hrs);

  FQuantidadeDiariasCalculada := CalculaTotalDias(FDataInicialCobranca, FDataFinalCobranca, AConsiderar24hrs);
  Result :=  FQuantidadeDiariasCalculada;
end;

function TCalcularPeriodoFatura.CalculaTotalDias(const ADtaIni,
  ADtaFin: TDateTime; AConsiderar24hrs: Boolean = True): Integer;
begin
  If AConsiderar24hrs Then
    Result := CalculaTotalDiasContratoComIntervalo24hrs(ADtaIni, ADtaFin)
  Else
    Result := CalculaTotalDiasContratoSemIntervalo24hrs(ADtaIni, ADtaFin);
end;

function TCalcularPeriodoFatura.CalculaTotalDiasContratoComIntervalo24hrs(
  const ADtaIni, ADtaFin: TDateTime): Integer;
var
  auxDias: Double;
  dtaIni: TDateTime;
  dtaFin: TDateTime;
begin
  dtaIni := ADtaIni;
  dtaFin := ADtaFin;

  auxDias := dtaFin - dtaIni;
  Result := Ceil(auxDias);

  If Result <= 0 Then
  Begin
    auxDias := ADtaFin - ADtaIni;

    If (auxDias < 1) And (auxDias > 0) Then
    Begin
      Result := 1
    End
    Else
      Result := Ceil(auxDias);
  End;
end;

function TCalcularPeriodoFatura.CalculaTotalDiasContratoSemIntervalo24hrs(
  const ADtaIni, ADtaFin: TDateTime): Integer;
var
  auxDias: Double;
  dtaIni: TDateTime;
  dtaFin: TDateTime;
begin
  dtaIni := fObtemData(ADtaIni);
  dtaFin := fObtemData(ADtaFin);

  auxDias := dtaFin - dtaIni;
  Result := Ceil(auxDias);
  If Result <= 0 Then
  Begin
    auxDias := ADtaFin - ADtaIni;
    If (auxDias < 1) Then
     Result := 0
    Else
     Result := Ceil(auxDias);
  End;
end;

function TCalcularPeriodoFatura.CalculaTotalHoras(const aDataInicial,
  aDataFinal: TDateTime): Double;
var
  LfltPeriodo: Double;
begin
  LfltPeriodo := (aDataFinal - aDataInicial);
  Result  := LfltPeriodo * HoursPerDay;
  Result  := Ceil(Result);
end;

function TCalcularPeriodoFatura.CalculaTotalMeses(const aDataInicial,
  aDataFinal: TDateTime; blnUtilizaDtaRef: Boolean): Integer;
var
  LIntAnoInicial, LIntAnoFinal: Word;
  LIntMesInicial, LIntMesFinal: Word;
  LTotalMeses: Integer;
begin
  If ((aDataInicial = 0) or (aDataFinal = 0)) Then
  Begin
    Result := 0;
    Exit;
  End;

  LIntAnoInicial := YearOf(aDataInicial);
  LIntMesInicial := MonthOf(aDataInicial);
  LIntAnoFinal := YearOf(aDataFinal);
  LIntMesFinal := MonthOf(aDataFinal);

  LTotalMeses := (LIntAnoFinal - LIntAnoInicial) * 12 +
                 (LIntMesFinal - LIntMesInicial) + 1;

  Result := LTotalMeses;
end;

constructor TCalcularPeriodoFatura.Create;
begin
  inherited;
end;

destructor TCalcularPeriodoFatura.Destroy;
begin
  inherited;
end;


class function TCalcularPeriodoFatura.New: ICalcularPeriodoFatura;
begin
  Result := TCalcularPeriodoFatura.Create;
end;

{ TCalcularDescontoFatura }

function TCalcularDescontoFatura.CalcularDescontoPorValorLiquidoRestante(
  const ATotalBruto: Double; AValorRestante, AValorJaFaturado: Double): Double;
var
  LValorDesconto,
  LPercentualDesconto,
  LValorAFaturar: Double;
begin
  LValorAFaturar :=  (ATotalBruto - AValorJaFaturado);

  LPercentualDesconto := (AValorRestante * 100) / LValorAFaturar;

  LValorDesconto := LValorAFaturar * (LPercentualDesconto/100);

  Result := LValorDesconto;
end;

constructor TCalcularDescontoFatura.Create;
begin
  inherited;
end;

destructor TCalcularDescontoFatura.Destroy;
begin

  inherited;
end;

class function TCalcularDescontoFatura.New: ICalcularDecontoFatura;
begin
  Result := TCalcularDescontoFatura.Create;
end;

end.
