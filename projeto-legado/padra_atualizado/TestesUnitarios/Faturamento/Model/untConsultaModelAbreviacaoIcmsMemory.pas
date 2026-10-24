unit untConsultaModelAbreviacaoIcmsMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TConsultaModelAbreviacaoIcmsMemory = class(TInterfacedObject, IResultadoFaturamentoImpostosModelAbreviacaoIcms)
  private
    FAliquotaDeIcms: Double;
    FPercentualDaBaseDeIcms: Double;
    FCodigoDaSituacaoTributaria: String;
    FAliquotaDeSt: Double;
    FPercentualDeIva: Double;
    FPercentualDaBaseDeSt: Double;
    FCalcularSTSaiCCO: String;
    FCodigoDaAbreviacaoFiscal: String;
    FAliquotaDeFcp: Double;
    FAliquotaInternaEstadoDestino: Double;
    FPercentualBaseDifalOrigem: Double;
    FPercentualBaseDifalDestino: Double;
    FAliquotaEfetivaOrigem: Double;
    FRegistroExiste: Boolean;
    FDecretoReducaoRICMPR: Boolean;
    FAliquotaDiferenciadaRICMPR: Double;
    FAliquotaReduzidaDeSt: Double;
    FCalcularSTSaiPRU: String;
  public
    function AliquotaDeIcms: Double; overload;
    function AliquotaDeIcms(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function PercentualDaBaseDeIcms: Double; overload;
    function PercentualDaBaseDeIcms(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function CodigoDaSituacaoTributaria: String; overload;
    function CodigoDaSituacaoTributaria(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function AliquotaDeSt: Double; overload;
    function AliquotaDeSt(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function PercentualDeIva: Double; overload;
    function PercentualDeIva(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function PercentualDaBaseDeSt: Double; overload;
    function PercentualDaBaseDeSt(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function CalcularSTSaiCCO: String; overload;
    function CalcularSTSaiCCO(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function CodigoDaAbreviacaoFiscal: String; overload;
    function CodigoDaAbreviacaoFiscal(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function AliquotaDeFcp: Double; overload;
    function AliquotaDeFcp(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function AliquotaInternaEstadoDestino: Double; overload;
    function AliquotaInternaEstadoDestino(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function PercentualBaseDifalOrigem: Double; overload;
    function PercentualBaseDifalOrigem(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function PercentualBaseDifalDestino: Double; overload;
    function PercentualBaseDifalDestino(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function AliquotaEfetivaOrigem: Double; overload;
    function AliquotaEfetivaOrigem(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function RegistroExiste: Boolean; overload;
    function RegistroExiste(AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function DecretoReducaoRICMPR: Boolean; overload;
    function DecretoReducaoRICMPR(AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function AliquotaDiferenciadaRICMPR: Double; overload;
    function AliquotaDiferenciadaRICMPR(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function AliquotaReduzidaDeSt: Double; overload;
    function AliquotaReduzidaDeSt(AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function CalcularSTSaiPRU: String; overload;
    function CalcularSTSaiPRU(AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    class function New: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  End;

implementation

{ TConsultaModelAbreviacaoIcmsMemory }

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDeFcp: Double;
begin
  Result := FAliquotaDeFcp;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDeFcp(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDeFcp := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDeIcms(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDeIcms := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDeIcms: Double;
begin
  Result := FAliquotaDeIcms;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDeSt: Double;
begin
  Result := FAliquotaDeSt;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDeSt(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDeSt := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDiferenciadaRICMPR(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaDiferenciadaRICMPR := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaDiferenciadaRICMPR: Double;
begin
  Result := FAliquotaDiferenciadaRICMPR;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaEfetivaOrigem(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaEfetivaOrigem := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaEfetivaOrigem: Double;
begin
  Result := FAliquotaEfetivaOrigem;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaInternaEstadoDestino(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaInternaEstadoDestino := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaInternaEstadoDestino: Double;
begin
  Result := FAliquotaInternaEstadoDestino;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaReduzidaDeSt(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FAliquotaReduzidaDeSt := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.AliquotaReduzidaDeSt: Double;
begin
  Result := FAliquotaReduzidaDeSt;
end;

function TConsultaModelAbreviacaoIcmsMemory.CalcularSTSaiCCO: String;
begin
  Result := FCalcularSTSaiCCO;
end;

function TConsultaModelAbreviacaoIcmsMemory.CalcularSTSaiCCO(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCalcularSTSaiCCO := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.CalcularSTSaiPRU: String;
begin
  Result := FCalcularSTSaiPRU;
end;

function TConsultaModelAbreviacaoIcmsMemory.CalcularSTSaiPRU(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCalcularSTSaiPRU := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.CodigoDaAbreviacaoFiscal(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaAbreviacaoFiscal := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.CodigoDaAbreviacaoFiscal: String;
begin
  Result := FCodigoDaAbreviacaoFiscal;
end;

function TConsultaModelAbreviacaoIcmsMemory.CodigoDaSituacaoTributaria(
  AValue: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FCodigoDaSituacaoTributaria := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.CodigoDaSituacaoTributaria: String;
begin
  Result := FCodigoDaSituacaoTributaria;
end;

function TConsultaModelAbreviacaoIcmsMemory.DecretoReducaoRICMPR(
  AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FDecretoReducaoRICMPR := AValue;
end;

class function TConsultaModelAbreviacaoIcmsMemory.New: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self.Create;
end;

function TConsultaModelAbreviacaoIcmsMemory.DecretoReducaoRICMPR: Boolean;
begin
  Result := FDecretoReducaoRICMPR;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualBaseDifalDestino: Double;
begin
  Result := FPercentualBaseDifalDestino;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualBaseDifalDestino(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualBaseDifalDestino := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualBaseDifalOrigem(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualBaseDifalOrigem := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualBaseDifalOrigem: Double;
begin
  Result := FPercentualBaseDifalOrigem;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualDaBaseDeIcms(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeIcms := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualDaBaseDeIcms: Double;
begin
  Result := FPercentualDaBaseDeIcms;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualDaBaseDeSt(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualDaBaseDeSt := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualDaBaseDeSt: Double;
begin
  Result := FPercentualDaBaseDeSt;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualDeIva(
  AValue: Double): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FPercentualDeIva := AValue;
end;

function TConsultaModelAbreviacaoIcmsMemory.PercentualDeIva: Double;
begin
  Result := FPercentualDeIva;
end;

function TConsultaModelAbreviacaoIcmsMemory.RegistroExiste: Boolean;
begin
  Result := FRegistroExiste;
end;

function TConsultaModelAbreviacaoIcmsMemory.RegistroExiste(
  AValue: Boolean): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self;
  FRegistroExiste := AValue;
end;

end.
