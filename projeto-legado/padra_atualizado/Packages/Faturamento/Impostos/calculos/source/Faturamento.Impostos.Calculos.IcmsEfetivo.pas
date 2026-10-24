unit Faturamento.Impostos.Calculos.IcmsEfetivo;

interface

uses Faturamento.Impostos.Interfaces.IcmsEfetivo, Faturamento.Impostos.Tipos.IcmsEfetivo,
  Shared.Functions.Configuracoes, Shared.Functions.Core;

type
  TCalculoImpostosIcmsEfetivo= class(TInterfacedObject, ICalculoImpostosIcmsEfetivo)
  private
    function EncontrouDocumentoComValorRetido(Const AParametros : IParametrosCalculoIcmsEfetivo) : Boolean;
    function CalcularIcmsEfetivo(Const AParametros : IParametrosCalculoIcmsEfetivo) : Boolean;
    function ClienteConsumidorFinalCalculaEfetivo(Const AParametros: IParametrosCalculoIcmsEfetivo): Boolean;
  public
    function CalcularValorIcmsEfetivo(AParametros: IParametrosCalculoIcmsEfetivo): IResultadoCalculoIcmsEfetivo;
    class function New(): ICalculoImpostosIcmsEfetivo;
  end;

  function CalcularValorIcmsEfetivo(AParametros: IParametrosCalculoIcmsEfetivo): IResultadoCalculoIcmsEfetivo; stdcall;

implementation


function CalcularValorIcmsEfetivo(AParametros: IParametrosCalculoIcmsEfetivo): IResultadoCalculoIcmsEfetivo; stdcall;
begin
  Result := TCalculoImpostosIcmsEfetivo.New.CalcularValorIcmsEfetivo(AParametros);
end;

{ TCalculoImpostosIPI }

function TCalculoImpostosIcmsEfetivo.EncontrouDocumentoComValorRetido(
  const AParametros: IParametrosCalculoIcmsEfetivo): Boolean;
begin
  Result := False;

  If Not (AParametros.EncontrouDocumento) Then
    Exit;

  If Not (AParametros.ValorRetido > 0) Then
    Exit;

  Result := True;
end;

function TCalculoImpostosIcmsEfetivo.CalcularIcmsEfetivo(
  const AParametros: IParametrosCalculoIcmsEfetivo): Boolean;
begin
  result := false;

  If Not (AParametros.EncontrouDocumento) Then
   Exit;

  If (AParametros.Quantidade <= 0) Then
   Exit;

  result := true;
end;

function TCalculoImpostosIcmsEfetivo.ClienteConsumidorFinalCalculaEfetivo(Const AParametros: IParametrosCalculoIcmsEfetivo): Boolean;
begin
  Result := AParametros.ClienteConsumidorFinal;

  If Result And objConfiguracoes.fGetValorConfiguracao(CFG_ENVIAR_REPASSE_ICMS_COBRADO_ANTERIORMENTE_POR_SUBSTITUICAO_TRIBUTARIA, varBoolean) Then
    Exit(False);
end;

function TCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(
  AParametros: IParametrosCalculoIcmsEfetivo): IResultadoCalculoIcmsEfetivo;
Var
  LValorIcmsEfetiva                 : Double;
  LPercentualReducaoBaseCalcEfetiva : Double;
  LValorBaseCalculoEfetiva          : Double;
  LAliquotaIcmsEfetiva              : Double;
  LValorBaseRetida                  : Double;
  LValorRetido                      : Double;
  LValorBaseCalculoIcmsStRetido     : Double;
  LValorIcmsStRetido                : Double;
  LValorIcmsSubstituto              : Double;
  LfltBaseOperacaoPropriaICMSEntrada,
  LfltAliquotaOperacaoPropriaICMSEntrada,
  LfltValorOperacaoPropriaIMCSEntrada : Double;
  LValorOperacaoPropriaICMSSaida : Double;
begin
  LPercentualReducaoBaseCalcEfetiva      := 0;
  LValorBaseCalculoEfetiva               := 0;
  LAliquotaIcmsEfetiva                   := 0;
  LValorIcmsEfetiva                      := 0;
  LValorBaseCalculoIcmsStRetido          := 0;
  LValorIcmsStRetido                     := 0;
  LfltBaseOperacaoPropriaICMSEntrada     := 0;
  LfltAliquotaOperacaoPropriaICMSEntrada := 0;
  LfltValorOperacaoPropriaIMCSEntrada    := 0;

  LValorIcmsSubstituto := AParametros.ValorIcmsSubstitutoItem;

  If CalcularIcmsEfetivo(AParametros) Then
  Begin

    If ClienteConsumidorFinalCalculaEfetivo(AParametros) Then
    Begin
      LPercentualReducaoBaseCalcEfetiva := AParametros.PercentualReducaoBaseCalcEfetiva;
      LValorBaseCalculoEfetiva          := objCore.fFormataFloat(AParametros.ValorBaseCalculoEfetiva,2);
      LAliquotaIcmsEfetiva              := AParametros.AliquotaIcmsEfetiva;
      LValorIcmsEfetiva                 := objCore.fFormataFloat(LValorBaseCalculoEfetiva * LAliquotaIcmsEfetiva / 100, 2);
    End
    Else
    Begin
      LValorBaseRetida := objCore.fFormataFloat(AParametros.ValorBaseRetida,2);
      LValorOperacaoPropriaICMSSaida := objCore.fFormataFloat(AParametros.ValorOperacaoPropriaICMSSaida, 2);
      LValorRetido := objCore.fFormataFloat(AParametros.ValorRetido, 2);

      If not EncontrouDocumentoComValorRetido(AParametros) Then
        LValorRetido := objCore.fFormataFloat(AParametros.ValorRetido, 2) - LValorOperacaoPropriaICMSSaida;

      If (LValorRetido <= 0) Then
        LValorRetido := 0;

      LValorBaseCalculoIcmsStRetido := LValorBaseRetida * AParametros.QuantidadeItem;
      LValorIcmsStRetido            := LValorRetido * AParametros.QuantidadeItem;

      If (objCore.fFormataFloat(LValorOperacaoPropriaICMSSaida, 2) > 0) And (objCore.fFormataFloat(LValorRetido, 2) > 0) Then
        LValorIcmsSubstituto := LValorOperacaoPropriaICMSSaida * AParametros.QuantidadeItem
      Else
      Begin
        LValorIcmsSubstituto := objCore.fFormataFloat(LValorIcmsSubstituto / AParametros.Quantidade,2);
        LValorIcmsSubstituto := LValorIcmsSubstituto * AParametros.QuantidadeItem;
      End;
    End;
  End;

  If ClienteConsumidorFinalCalculaEfetivo(AParametros) Then
  Begin
    LfltBaseOperacaoPropriaICMSEntrada     := AParametros.ValorBaseOperacaoPropriaICMSEntrada;
    LfltAliquotaOperacaoPropriaICMSEntrada := AParametros.AliquotaOperacaoPropriaICMSEntrada;
    LfltValorOperacaoPropriaIMCSEntrada    := AParametros.ValorOperacaoPropriaICMSEntrada;

    if AParametros.EncontrouDocumentoOperacaoPropriaICMSEntrada then
    Begin
      LfltBaseOperacaoPropriaICMSEntrada     := AParametros.ValorBaseOperacaoPropriaICMSEntrada * AParametros.QuantidadeItem;
      LfltAliquotaOperacaoPropriaICMSEntrada := AParametros.AliquotaOperacaoPropriaICMSEntrada;
      LfltValorOperacaoPropriaIMCSEntrada    := AParametros.ValorOperacaoPropriaICMSEntrada * AParametros.QuantidadeItem;
    End;
  End;

  Result := TResultadoCalculoIcmsEfetivo.New
    .PercentualReducaoBaseCalcEfetivaItem(LPercentualReducaoBaseCalcEfetiva)
    .ValorBaseCalculoEfetivaItem(LValorBaseCalculoEfetiva)
    .ValorIcmsEfetivaItem(LValorIcmsEfetiva)
    .AliquotaIcmsEfetivaItem(LAliquotaIcmsEfetiva)
    .ValorBaseCalculoIcmsStRetidoItem(LValorBaseCalculoIcmsStRetido)
    .ValorIcmsStRetidoItem(LValorIcmsStRetido)
    .ValorIcmsSubstitutoItem(LValorIcmsSubstituto)
    .ValorBaseOperacaoPropriaICMSEntrada(LfltBaseOperacaoPropriaICMSEntrada)
    .AliquotaOperacaoPropriaICMSEntrada(LfltAliquotaOperacaoPropriaICMSEntrada)
    .ValorOperacaoPropriaICMSEntrada(LfltValorOperacaoPropriaIMCSEntrada);

end;

class function TCalculoImpostosIcmsEfetivo.New: ICalculoImpostosIcmsEfetivo;
begin
  Result := Self.Create;
end;

// exports CalcularValorIcmsEfetivo;

end.

