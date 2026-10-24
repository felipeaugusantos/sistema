unit Faturamento.Impostos.Calculos.ST;

interface

uses
  System.StrUtils, Faturamento.Impostos.Interfaces.ST, Faturamento.Impostos.Tipos.ST,
  Shared.Functions.Core, Shared.Functions.Funcoes.Faturamento, Shared.Functions.Configuracoes,
  Shared.Functions.Constantes;

type
  TCalculoImpostosST = class(TInterfacedObject, ICalculoImpostosST)
  private
    FIcmFatorNegativo: double;
    FAliquotaDaSubstituicaoTributaria: double;
    FPercentualDaBaseDeCalculoDaSTDoItem: double;
    FBasRetReduzido: double;
    FValRetReduzido: double;
    FValRetMinimo: Double;
    FBaseDeCalculoDaSubstituicaoTributaria: double;
    FBaseDeCalculoDeDesoneracaoDeSubstituicaoTributaria: double;
    FValorDesoneradoDaSubstituicaoTributariaDoItem: double;
    FValorDaSubstituicaoTributaria: double;
    FPercentualDoFcp: double;
    FValorDoFcp: double;
    FAmpara_TipAbf: String;
    FAmpara_AliquotaFCP: Double;
    FAliquotaPrimeiraParte: Double;
    FAliquotaSegundaParte: Double;

    function ClienteZonaFrancaOrgaoPublico(const AParametros: IParametrosCalculoST): Boolean;
    function CalcularValorSTDentroDoEstado(
      AParametros: IParametrosCalculoST): IResultadoCalculoST;
    function CalcularValorSTForaDoEstado(
      AParametros: IParametrosCalculoST): IResultadoCalculoST;
    function CalcularSTSomenteParaNaoConsumidorFinal(const AParametros: IParametrosCalculoST): Boolean;
    procedure AmparaRSOperacaoComST(const AParametros: IParametrosCalculoST);
    procedure ZerarValoresDaSubstituicaoTributaria;
    procedure CalcularValorSTDentroDoEstadoParaClienteNaoZonaFrancaOrgaoPublico(
      AParametros: IParametrosCalculoST);
    procedure CalcularSTBeneficioReducaoBaseIcmsST(const AParametros: IParametrosCalculoST);
    procedure CalculaDesoneracaoDeSubstituicaoTributaria(const AParametros: IParametrosCalculoST);
    procedure CalcularSTParaNaoBeneficioReducaoBaseIcmsST(const AParametros: IParametrosCalculoST);
    function ValidarSeDeveCalcularSTDentroDoEstadoParaClienteNaoZonaFrancaOrgaoPublico(const AParametros: IParametrosCalculoST): boolean;
    function ValidarSeDeveCalcularSTForaDoEstado(const AParametros: IParametrosCalculoST): boolean;
    function RetornarFatorNegativoIcms(const AParametros: IParametrosCalculoST): double;
    procedure DefinirCalculoStConformeBeneficioReducaoBaseIcmsSt(const AParametros: IParametrosCalculoST);
    procedure AplicarRegraSubstituicaoTributariaPorDentro(const AParametros: IParametrosCalculoST);
    function CalcularSTSomenteParaNaoConsumidorFinalDentroDoEstado(
      const AParametros: IParametrosCalculoST): Boolean;
    procedure CalcularStUilizaAmpara(const AParametros: IParametrosCalculoST);
    function RetornarResultadoValorStForaDoEstado: IResultadoCalculoST;
    function RetornarValorSTBeneficioReducaoBaseIcmsST: double;
    procedure CarregarDadosAmpara(const AParametros: IParametrosCalculoST);
    procedure CalcularValorStUtilizaAmpara;
    procedure CarregarDadosFcpUtilizaAmpara;
    function RetornarCalculoValorSt(
      const AParametros: IParametrosCalculoST): IResultadoCalculoST;
    function RetornarCalculoValorStForaDoEstado(
      const AParametros: IParametrosCalculoST): IResultadoCalculoST;
    function UtilizarReducaoDeBaseDeCalculoDeSTNaVendaRioLog(const AParametros: IParametrosCalculoST): Boolean;
    function PercentualDaBaseDeCalculoDaSTDoItem(const AParametros: IParametrosCalculoST): Double;
    procedure CalculaBaseDeDesoneracaoDeSubstituicaoTributaria(const AParametros: IParametrosCalculoST);
  public
    function CalcularValorST(AParametros: IParametrosCalculoST): IResultadoCalculoST;
    class function New(): ICalculoImpostosST;
  end;

//  function CalcularValorST(AParametros: IParametrosCalculoST): IResultadoCalculoST; stdcall;

implementation

//function CalcularValorST(AParametros: IParametrosCalculoST): IResultadoCalculoST; stdcall;
//begin
//  Result := TCalculoImpostosST.New.CalcularValorST(AParametros);
//end;

{ TCalculoImpostosST }

function TCalculoImpostosST.ValidarSeDeveCalcularSTDentroDoEstadoParaClienteNaoZonaFrancaOrgaoPublico(const AParametros: IParametrosCalculoST): boolean;
begin
  result := True;

  if (AParametros.CalculaBeneficioReducaoBaseIcmsST) then
    Exit;

  result := False;

  if (not AParametros.CalculaSubstituicaoTributariaSimples) then
    Exit;

  if (not CalcularSTSomenteParaNaoConsumidorFinal(AParametros)) then
    Exit;

  if (not AParametros.UtilizaImportacaoDireta) then
    Exit;

  if (not AParametros.ItemImportacaoDireta) then
    Exit;

  result := True;
end;

function TCalculoImpostosST.ValidarSeDeveCalcularSTForaDoEstado(const AParametros: IParametrosCalculoST): boolean;
begin
  result := False;

  If not AParametros.SubstituicaoTributariaDoItem then
    Exit;

  if not CalcularSTSomenteParaNaoConsumidorFinal(AParametros) Then
    Exit;

  result := True;
end;

function TCalculoImpostosST.RetornarValorSTBeneficioReducaoBaseIcmsST: double;
begin
  result := FValRetMinimo;

  If FValRetReduzido <= FValRetMinimo Then
    Exit;

  result := FValRetReduzido;
end;

function TCalculoImpostosST.UtilizarReducaoDeBaseDeCalculoDeSTNaVendaRioLog(const AParametros: IParametrosCalculoST): Boolean;
begin
  Result := True;

  If not (AParametros.ModeloBeneficioReducaoBaseIcmsST = 3) Then
    Exit;

  If not AParametros.CalculaDesoneracaoDeSubstituicaoTributaria Then
    Exit;

  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_REDUCAO_BASE_CALCULO_SUBSTITUICAO_TRIBUTARIA_NA_VENDA_DO_RIOLOG, varBoolean) Then
    Exit;

  Result := False;
end;

function TCalculoImpostosST.PercentualDaBaseDeCalculoDaSTDoItem(const AParametros: IParametrosCalculoST): Double;
begin
  Result := 100;

  If not UtilizarReducaoDeBaseDeCalculoDeSTNaVendaRioLog(AParametros) Then
    Exit;

  If not AParametros.UtilizarReducaoDeBaseDeCalculoDeSTNaVenda Then
    Exit;

  Result := AParametros.PercentualDaBaseDeCalculoDaSTDoItem;

end;

procedure TCalculoImpostosST.CalculaBaseDeDesoneracaoDeSubstituicaoTributaria(const AParametros: IParametrosCalculoST);
var
  LBasRetReduzido: Double;
begin
  LBasRetReduzido := 0;

  case AParametros.ModeloBeneficioReducaoBaseIcmsST of
    1: LBasRetReduzido := (AParametros.TotalGeralDoItemPreUlt + AParametros.ValorDoIpiDoItem);
    2: LBasRetReduzido := (AParametros.TotalGeralDoItemPreUlt + AParametros.ValorDoIpiDeEntrada);
    3: LBasRetReduzido := (AParametros.TotalGeralDoItem + AParametros.ValorDoIpiDoItem);
  end;

  LBasRetReduzido := objCore.fFormataFloat((LBasRetReduzido * AParametros.ValorDoIva),2);
  LBasRetReduzido := objCore.fFormataFloat(((LBasRetReduzido * PercentualDaBaseDeCalculoDaSTDoItem(AParametros)) / 100), 2);

  FBaseDeCalculoDeDesoneracaoDeSubstituicaoTributaria := LBasRetReduzido;
end;

procedure TCalculoImpostosST.CalcularSTBeneficioReducaoBaseIcmsST(const AParametros: IParametrosCalculoST);
begin
  FIcmFatorNegativo := 0;
  FBasRetReduzido   := 0;

  case AParametros.ModeloBeneficioReducaoBaseIcmsST of
    1: FBasRetReduzido := (AParametros.TotalGeralDoItemPreUlt + AParametros.ValorDoIpiDoItem);
    2: FBasRetReduzido := (AParametros.TotalGeralDoItemPreUlt + AParametros.ValorDoIpiDeEntrada);
    3: FBasRetReduzido := (AParametros.TotalGeralDoItem + AParametros.ValorDoIpiDoItem);
  end;

  FBasRetReduzido := objCore.fFormataFloat((FBasRetReduzido * AParametros.ValorDoIva),2);
  FBasRetReduzido := objCore.fFormataFloat(((FBasRetReduzido * objCore.IfThen(AParametros.UtilizarReducaoDeBaseDeCalculoDeSTNaVenda, AParametros.PercentualDaBaseDeCalculoDaSTDoItem, 100)) / 100), 2);
  FValRetReduzido := (FBasRetReduzido * FAliquotaDaSubstituicaoTributaria) / 100;
  FValRetReduzido := (FValRetReduzido - AParametros.ValorDoIcmsDoItem);
  FValRetMinimo   := (FBasRetReduzido * AParametros.PercentualMinimoReducaoDeBaseDeCalculoDosImpostos) / 100;

  FBaseDeCalculoDaSubstituicaoTributaria := FBasRetReduzido;
  FValorDaSubstituicaoTributaria := RetornarValorSTBeneficioReducaoBaseIcmsST;
end;

procedure TCalculoImpostosST.CalculaDesoneracaoDeSubstituicaoTributaria(const AParametros: IParametrosCalculoST);
begin
  If not AParametros.CalculaDesoneracaoDeSubstituicaoTributaria Then
    Exit;

  FAliquotaPrimeiraParte := (1 - (AParametros.AliquotaCalculoDesoneracaoDeSubstituicaoTributaria / 100 *
                                 (objCore.IfThen(AParametros.UtilizarReducaoDeBaseDeCalculoDeSTNaVenda,
                                                       AParametros.PercentualDaBaseDeCalculoDaSTDoItem, 100)) / 100));

  FAliquotaSegundaParte  := (1 - (AParametros.AliquotaCalculoDesoneracaoDeSubstituicaoTributaria / 100));

  FValorDesoneradoDaSubstituicaoTributariaDoItem := ((FBaseDeCalculoDeDesoneracaoDeSubstituicaoTributaria * FAliquotaPrimeiraParte) / FAliquotaSegundaParte) - FBaseDeCalculoDeDesoneracaoDeSubstituicaoTributaria;

  FValorDesoneradoDaSubstituicaoTributariaDoItem := objCore.fFormataFloat(FValorDesoneradoDaSubstituicaoTributariaDoItem, 2);
end;

procedure TCalculoImpostosST.CalcularSTParaNaoBeneficioReducaoBaseIcmsST(const AParametros: IParametrosCalculoST);
begin
  FBaseDeCalculoDaSubstituicaoTributaria :=
    objCore.fFormataFloat(((((AParametros.TotalGeralDoItem + AParametros.ValorDoIpiDoItem) *
                                    objCore.IfThen((Not AParametros.ClienteConsumidorFinal) Or (AParametros.CalculaSTClienteConsumidorFinalNCOEspiritoSanto), AParametros.ValorDoIva, 1)) *
                                    objCore.IfThen(AParametros.UtilizarReducaoDeBaseDeCalculoDeSTNaVenda, AParametros.PercentualDaBaseDeCalculoDaSTDoItem, 100)) / 100), 2);

  FValorDaSubstituicaoTributaria := objCore.fFormataFloat(((FBaseDeCalculoDaSubstituicaoTributaria * FAliquotaDaSubstituicaoTributaria) / 100), 2);
end;

function TCalculoImpostosST.RetornarFatorNegativoIcms(const AParametros: IParametrosCalculoST): double;
begin
  If (AParametros.AplicaCargaLiquidaCE) Then
  Begin
    Result := 0;
    Exit;
  End;
  result := AParametros.ValorDoIcmsDoItem;

  If not AParametros.SimplesNacional Then
    Exit;

  result := AParametros.ValorDoIcmsDoEstado;
end;

procedure TCalculoImpostosST.DefinirCalculoStConformeBeneficioReducaoBaseIcmsSt(const AParametros: IParametrosCalculoST);
begin
  If AParametros.CalculaBeneficioReducaoBaseIcmsST Then
  begin
    CalcularSTBeneficioReducaoBaseIcmsST(AParametros);
    CalculaBaseDeDesoneracaoDeSubstituicaoTributaria(AParametros);
    Exit;
  end;

  CalcularSTParaNaoBeneficioReducaoBaseIcmsST(AParametros);
end;

procedure TCalculoImpostosST.CalcularValorSTDentroDoEstadoParaClienteNaoZonaFrancaOrgaoPublico(
  AParametros: IParametrosCalculoST);
begin
  If not AParametros.SubstituicaoTributariaDoItem Then
    Exit;

  {*******************************************}
  {* CONFIGURADO SE LEI REVOGADA OU NAUM :-p *}
  {****************************************AF*}
  If (not ValidarSeDeveCalcularSTDentroDoEstadoParaClienteNaoZonaFrancaOrgaoPublico(AParametros)) Then
    Exit;

  {*****************************************}
  {* ICMS FATOR NEGATIVO: QUANDO NÃO É     *}
  {* SIMPLES, É O PROPRIO ICMS. QUANDO É   *}
  {* SIMPLES, USA O ICMANT, POIS O ICMS    *}
  {* SERÁ ZERADO NOS PRODUTOS SUBSTITUIDOS *}
  {**************************************MV*}
  FIcmFatorNegativo := RetornarFatorNegativoIcms(AParametros);

  FAliquotaDaSubstituicaoTributaria := AParametros.AliquotaDaSubstituicaoTributariaDoItem;

  DefinirCalculoStConformeBeneficioReducaoBaseIcmsSt(AParametros);

  CalculaDesoneracaoDeSubstituicaoTributaria(AParametros);

  {***************************************}
  {* AMPARA RS - OPERAÇÃO INTERNA COM ST *}
  {***************************************}
  AmparaRSOperacaoComST(AParametros);
  ZerarValoresDaSubstituicaoTributaria;
end;

function TCalculoImpostosST.CalcularValorSTDentroDoEstado(
  AParametros: IParametrosCalculoST): IResultadoCalculoST;
begin
  If (Not ClienteZonaFrancaOrgaoPublico(AParametros)) then
    CalcularValorSTDentroDoEstadoParaClienteNaoZonaFrancaOrgaoPublico(AParametros);

  Result := TResultadoCalculoST.New
            .BaseDeCalculoDaSubstituicaoTributariaDoItem(FBaseDeCalculoDaSubstituicaoTributaria)
            .ValorDaSubstituicaoTributariaDoItem(FValorDaSubstituicaoTributaria)
            .PercentualDoFCPDoItem(FPercentualDoFcp)
            .ValorDoFCPDoItem(FValorDoFcp)
            .PercentualDaSubstituicaoDaBase(AParametros.PercentualDaBaseDeCalculoDaSTDoItem)
            .ValorDesoneradoDaSubstituicaoTributariaDoItem(FValorDesoneradoDaSubstituicaoTributariaDoItem);

end;

procedure TCalculoImpostosST.AplicarRegraSubstituicaoTributariaPorDentro(const AParametros: IParametrosCalculoST);
begin
  If not AParametros.CalculaSubstituicaoTributariaPorDentro Then
    Exit;

  FIcmFatorNegativo := 0;

  If AParametros.SimplesNacional Then
    FAliquotaDaSubstituicaoTributaria := FAliquotaDaSubstituicaoTributaria - AParametros.AliquotaOriginalDeIcmsDoItem;

  If not AParametros.SimplesNacional Then
    FAliquotaDaSubstituicaoTributaria := FAliquotaDaSubstituicaoTributaria - AParametros.AliquotaDeIcmsDoItem;
end;

function TCalculoImpostosST.RetornarResultadoValorStForaDoEstado: IResultadoCalculoST;
begin
  Result := TResultadoCalculoST.New
            .BaseDeCalculoDaSubstituicaoTributariaDoItem(FBaseDeCalculoDaSubstituicaoTributaria)
            .ValorDaSubstituicaoTributariaDoItem(FValorDaSubstituicaoTributaria)
            .PercentualDoFCPDoItem(FPercentualDoFcp)
            .ValorDoFCPDoItem(FValorDoFcp)
            .PercentualDaSubstituicaoDaBase(FPercentualDaBaseDeCalculoDaSTDoItem)
            .ValorDesoneradoDaSubstituicaoTributariaDoItem(FValorDesoneradoDaSubstituicaoTributariaDoItem);
end;

function TCalculoImpostosST.RetornarCalculoValorStForaDoEstado(const AParametros: IParametrosCalculoST): IResultadoCalculoST;
begin
  {*****************************************}
  {* ICMS FATOR NEGATIVO: QUANDO NÃO É     *}
  {* SIMPLES, É O PROPRIO ICMS. QUANDO É   *}
  {* SIMPLES, USA O ICMANT, POIS O ICMS    *}
  {* SERÁ ZERADO NOS PRODUTOS SUBSTITUIDOS *}
  {**************************************MV*}
  FIcmFatorNegativo := RetornarFatorNegativoIcms(AParametros);

  If (AParametros.AplicaCargaLiquidaCE) Then
    FAliquotaDaSubstituicaoTributaria := AParametros.AliquotaReducaoDeSt
  Else
    FAliquotaDaSubstituicaoTributaria := AParametros.AliquotaDaSubstituicaoTributariaDoItem;

  AplicarRegraSubstituicaoTributariaPorDentro(AParametros);

  If (AParametros.AplicaCargaLiquidaCE) Then
  Begin
    FBaseDeCalculoDaSubstituicaoTributaria := ((AParametros.TotalGeralDoItem * (AParametros.PercentualDaBaseDeCalculoDaSTDoItem / 100)) + objCore.IfThen(AParametros.UtilizaImportacaoDireta Or AParametros.ContribuinteDeIpi, AParametros.ValorDoIpiDoItem, 0));
  End
  Else
  Begin
    FBaseDeCalculoDaSubstituicaoTributaria :=
      objCore.fFormataFloat(((((AParametros.TotalGeralDoItem + objCore.IfThen(AParametros.UtilizaImportacaoDireta Or AParametros.ContribuinteDeIpi, AParametros.ValorDoIpiDoItem, 0)) *
                                      objCore.IfThen((Not AParametros.ClienteConsumidorFinal) Or (AParametros.ClienteIVAEspecialMT), AParametros.ValorDoIva, 1)) *
                                      objCore.IfThen(AParametros.UtilizarReducaoDeBaseDeCalculoDeSTNaVenda, AParametros.PercentualDaBaseDeCalculoDaSTDoItem, 100)) / 100), 2);
  End;

  FValorDaSubstituicaoTributaria := objCore.fFormataFloat(((FBaseDeCalculoDaSubstituicaoTributaria * FAliquotaDaSubstituicaoTributaria) / 100), 2);

  {*********************************************}
  {* AMPARA RS - OPERAÇÃO INTERESTADUAL COM ST *}
  {*********************************************}
  AmparaRSOperacaoComST(AParametros);

  ZerarValoresDaSubstituicaoTributaria;

  Result := RetornarResultadoValorStForaDoEstado;
end;

function TCalculoImpostosST.CalcularValorSTForaDoEstado(
  AParametros: IParametrosCalculoST): IResultadoCalculoST;
begin
  if (not ValidarSeDeveCalcularSTForaDoEstado(AParametros)) then
  begin
    Result := RetornarResultadoValorStForaDoEstado;
    Exit;
  end;

  result := RetornarCalculoValorStForaDoEstado(AParametros);
end;

function TCalculoImpostosST.CalcularSTSomenteParaNaoConsumidorFinalDentroDoEstado(const AParametros: IParametrosCalculoST): Boolean;
begin
  result := True;

  if ((Not AParametros.ClienteConsumidorFinal)) then
    Exit;

  if (AParametros.CalculaSTClienteConsumidorFinalNCOEspiritoSanto) then
    Exit;

  result := False;
end;

function TCalculoImpostosST.CalcularSTSomenteParaNaoConsumidorFinal(const AParametros: IParametrosCalculoST): Boolean;
begin
  Result := true;

  if not AParametros.CalcularSTSomenteParaNaoConsumidorFinal then
    Exit;

  if AParametros.VendaDentroDoEstado then
  begin
    Result := CalcularSTSomenteParaNaoConsumidorFinalDentroDoEstado(AParametros);
    Exit;
  end;

  Result := (Not AParametros.ClienteConsumidorFinal)
end;

procedure TCalculoImpostosST.CarregarDadosAmpara(const AParametros: IParametrosCalculoST);
begin
  FAmpara_TipAbf := '';
  FAmpara_AliquotaFCP := 0;

  If Not AParametros.EncontrouAbreviacaoDeIcms Then
    Exit;

  FAmpara_TipAbf := AnsiReplaceStr(AnsiReplaceStr(AParametros.TipoDeAbreviacaoFiscal,'_ENT_',''),'_SAI_','');
  FAmpara_AliquotaFCP := AParametros.AmparaAliquotaFCP; //cdsAbfIcm.FieldByName('ABF_ALQFCP' + strTipAbf).AsFloat;
end;

procedure TCalculoImpostosST.CalcularValorStUtilizaAmpara;
begin
  IF FAmpara_TipAbf = SAIDAS_CONTRIBUINTE_CONSUMIDOR Then
  Begin
    FValorDaSubstituicaoTributaria := objCore.fFormataFloat((FValorDaSubstituicaoTributaria + FIcmFatorNegativo), 2);
    Exit;
  End;

  FValorDaSubstituicaoTributaria := objCore.fFormataFloat((FValorDaSubstituicaoTributaria - FIcmFatorNegativo), 2);
end;

procedure TCalculoImpostosST.CarregarDadosFcpUtilizaAmpara;
begin
  If FAmpara_TipAbf = SAIDAS_NAO_CONTRIBUINTE Then
    Exit;

  FPercentualDoFcp := FAmpara_AliquotaFCP;
  FValorDoFcp := objCore.fFormataFloat(FBaseDeCalculoDaSubstituicaoTributaria * FAmpara_AliquotaFCP / 100, 2);
end;

procedure TCalculoImpostosST.CalcularStUilizaAmpara(const AParametros: IParametrosCalculoST);
begin
  CarregarDadosAmpara(AParametros);
  CalcularValorStUtilizaAmpara;
  CarregarDadosFcpUtilizaAmpara;
end;

procedure TCalculoImpostosST.AmparaRSOperacaoComST(const AParametros: IParametrosCalculoST);
begin
  If (AParametros.UtilizaAmpara) Then
  Begin
    CalcularStUilizaAmpara(AParametros);
    Exit;
  End;

  FValorDaSubstituicaoTributaria := objCore.fFormataFloat((FValorDaSubstituicaoTributaria - FIcmFatorNegativo), 2);
end;

procedure TCalculoImpostosST.ZerarValoresDaSubstituicaoTributaria;
begin
  If FValorDaSubstituicaoTributaria >= 0 Then
    Exit;

  FValorDaSubstituicaoTributaria := 0;
  FBaseDeCalculoDaSubstituicaoTributaria := 0;
  FBaseDeCalculoDeDesoneracaoDeSubstituicaoTributaria := 0;
end;

function TCalculoImpostosST.RetornarCalculoValorSt(const AParametros: IParametrosCalculoST): IResultadoCalculoST;
begin
  If AParametros.VendaDentroDoEstado Then
  Begin
    result := CalcularValorSTDentroDoEstado(AParametros);
    Exit;
  End;

  result := CalcularValorSTForaDoEstado(AParametros);
end;

function TCalculoImpostosST.CalcularValorST(
  AParametros: IParametrosCalculoST): IResultadoCalculoST;
begin
  FBaseDeCalculoDaSubstituicaoTributaria := 0;
  FValorDaSubstituicaoTributaria := 0;
  FValorDesoneradoDaSubstituicaoTributariaDoItem := 0;
  FBaseDeCalculoDeDesoneracaoDeSubstituicaoTributaria := 0;

  FPercentualDaBaseDeCalculoDaSTDoItem := AParametros.PercentualDaBaseDeCalculoDaSTDoItem;

  FPercentualDoFcp := AParametros.PercentualDoFCPDoItem; //Variaveis de retorno
  FValorDoFcp := AParametros.ValorDoFCPDoItem; //Variaveis de retorno
  result := RetornarCalculoValorST(AParametros);
end;

function TCalculoImpostosST.ClienteZonaFrancaOrgaoPublico(const AParametros: IParametrosCalculoST): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.ClienteZonaFrancaOrgaoPublico(
      AParametros.ClienteOrgaoPublico, AParametros.CalcularDescontoIcmsOrgaoPublico,
      AParametros.ClienteZonaFranca, AParametros.ClienteConsumidorFinal);
end;

class function TCalculoImpostosST.New: ICalculoImpostosST;
begin
  Result := Self.Create;
end;

//exports CalcularValorST;

end.
