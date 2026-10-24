unit untCalculoUltimaCompraImpostos;

interface

Type
  TCalculoUltimaCompraImpostos = class(TObject)
  strict private
    fltTotalItem: Double;
    fltDescontoEspecial: Double;
    fltAliquotaPis: Double;
    fltAliquotaCofins: Double;
    fltValorIpi: Double;
    fltValorIpiNaoCreditado: Double;
    fltFrete: Double;
    fltConhecimentoFrete: Double;
    fltOutrasDespesas: Double;
    fltVendor: Double;
    fltValorFundoCombateAPobreza: Double;
    fltDespesaAcessoria: Double;
    fltValorIcms: Double;
    fltValorIcmsNaoCreditado: Double;
    fltValorIcmsAntecipado: Double;
    fltValorIcmsAntecipadoFrete: Double;
    fltValorGNRE: Double;
    fltValorTCIF: Double;
    fltValorTS: Double;
    fltRpaFre: Double;
    fltValorRetido: Double;
    fltValorIcmsNotaImportacao: Double;
    fltValorSiscomex: Double;
    fltValorRetidoNaoCreditado: Double;
    fltAliquotaICMSdoFrete: Double;
    blnItemIncidePis,
    blnForFil: Boolean;

    constructor Create;
    procedure pValidarValores;

   function fFormataValor(Valor: Double; intDecimais: Integer = 2): String;

  public
    blnUltPis: Boolean;
    blnMontaDescricao: Boolean;
    ValorFreteCalculado: Double;
    ValorConhecimentoCalculado: Double;

    strDescricaoCalculo: String;
    strDescricaoCalculoDescontoPisCofins,
    strDescricaoCalculoValorRetido: String;
    strDescricaoCalculoValorIPI: String;

    class function fCriaImpUlt: TCalculoUltimaCompraImpostos;

    function TotalItem(fltValor: Double): TCalculoUltimaCompraImpostos;
    function DescontoEspecial(fltValor: Double): TCalculoUltimaCompraImpostos;
    function AliquotaPis(fltValor: Double): TCalculoUltimaCompraImpostos;
    function AliquotaCofins(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorIpi(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorIpiNaoCreditado(fltValor: Double): TCalculoUltimaCompraImpostos;
    function Frete(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ConhecimentoFrete(fltValor: Double): TCalculoUltimaCompraImpostos;
    function OutrasDespesas(fltValor: Double): TCalculoUltimaCompraImpostos;
    function Vendor(fltValor: Double): TCalculoUltimaCompraImpostos;
    function DespesaAcessoria(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorIcms(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorIcmsNaoCreditado(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorIcmsAntecipado(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorIcmsAntecipadoFrete(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorGNRE(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorTCIF(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorTS(fltValor: Double): TCalculoUltimaCompraImpostos;

    function ValorRetido(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorRetidoNaoCreditado(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorFundoCombateAPobreza(fltValor: Double): TCalculoUltimaCompraImpostos;
    function AliquotaICMSdoFrete(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorIcmsNotaImportacao(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ValorSiscomex(fltValor: Double): TCalculoUltimaCompraImpostos;
    function ItemIncidePis(strValue: string): TCalculoUltimaCompraImpostos;
    function FornecedorFilial(blnValue: Boolean): TCalculoUltimaCompraImpostos;
    function fTotal: Double;
    function fUnitario(fltQuantidade: Double): Double;
    function fRecebimentoPagamentoAutonomoFrete(fltValor: Double): TCalculoUltimaCompraImpostos;

  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  StrUtils,
  SysUtils;

{ TCalculoUltimaCompraImpostos }

constructor TCalculoUltimaCompraImpostos.Create;
begin
  blnForFil := False;
  blnItemIncidePis := False;
  ValorFreteCalculado := 0;
  ValorConhecimentoCalculado := 0;
  fltValorIcmsNotaImportacao := 0;

  fltTotalItem := -1.0;
  fltDescontoEspecial := -1.0;
  fltAliquotaPis := -1.0;
  fltAliquotaCofins := -1.0;
  fltValorIpi := -1.0;
  fltValorIpiNaoCreditado := -1.0;
  fltFrete := -1.0;
  fltConhecimentoFrete := -1.0;
  fltOutrasDespesas := -1.0;
  fltVendor := -1.0;
  fltDespesaAcessoria := -1.0;
  fltValorIcms := 0;
  fltValorIcmsNaoCreditado := 0;
  fltValorIcmsAntecipado := -1.0;
  fltValorIcmsAntecipadoFrete := -1.0;
  fltValorGNRE := -1.0;
  fltValorTCIF := 0;
  fltValorTS := 0;
  fltValorRetido := -1.0;
  fltValorRetidoNaoCreditado := -1.0;
  fltRpaFre := 0;
  fltAliquotaICMSdoFrete := 0;
  fltValorSiscomex := 0;
  blnMontaDescricao := False;
  strDescricaoCalculo := '';
  strDescricaoCalculoDescontoPisCofins := '';
  strDescricaoCalculoValorRetido := '';
  strDescricaoCalculoValorIPI := '';
end;

function TCalculoUltimaCompraImpostos.AliquotaCofins(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltAliquotaCofins := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.AliquotaICMSdoFrete(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltAliquotaICMSdoFrete := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.AliquotaPis(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltAliquotaPis := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ConhecimentoFrete(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltConhecimentoFrete := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.DescontoEspecial(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltDescontoEspecial := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.DespesaAcessoria(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltDespesaAcessoria := fltValor;
  Result := Self;
end;

class function TCalculoUltimaCompraImpostos.fCriaImpUlt: TCalculoUltimaCompraImpostos;
begin
  Result := TCalculoUltimaCompraImpostos.Create;
end;

function TCalculoUltimaCompraImpostos.fRecebimentoPagamentoAutonomoFrete(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltRpaFre := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.Frete(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltFrete := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.OutrasDespesas(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltOutrasDespesas := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.TotalItem(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltTotalItem := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorGNRE(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorGNRE := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorTCIF(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorTCIF := fltValor;
  Result := Self;

end;

function TCalculoUltimaCompraImpostos.ValorTS(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorTS := fltValor;
  Result := Self;

end;

function TCalculoUltimaCompraImpostos.ValorIcmsAntecipado(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorIcmsAntecipado := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorIcms(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorIcms := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorIcmsNaoCreditado(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorIcmsNaoCreditado := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorIcmsNotaImportacao(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
 fltValorIcmsNotaImportacao := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorIcmsAntecipadoFrete(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorIcmsAntecipadoFrete := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorIpi(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorIpi := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorIpiNaoCreditado(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorIpiNaoCreditado := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorRetido(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorRetido := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorRetidoNaoCreditado(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorRetidoNaoCreditado := fltValor;
  Result := Self;
end;


function TCalculoUltimaCompraImpostos.ValorSiscomex(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorSiscomex := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.ValorFundoCombateAPobreza(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltValorFundoCombateAPobreza := fltValor;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.Vendor(
  fltValor: Double): TCalculoUltimaCompraImpostos;
begin
  fltVendor := fltValor;
  Result := Self;
end;

procedure TCalculoUltimaCompraImpostos.pValidarValores;
begin
  If fltTotalItem < 0 Then
    Raise Exception.Create('O total do item deve ser informado.');

  If fltDescontoEspecial < 0 Then
    Raise Exception.Create('O desconto especial deve ser informado.');

  If fltAliquotaPis < 0 Then
    Raise Exception.Create('A alíquota do PIS deve ser informada.');

  If fltAliquotaCofins < 0 Then
    Raise Exception.Create('A alíquota do COFINS deve ser informada.');

  If fltValorIpi < 0 Then
    Raise Exception.Create('O valor do IPI deve ser informado.');

  If fltValorIpiNaoCreditado < 0 Then
    Raise Exception.Create('O valor do IPI não creditado deve ser informado.');

  If fltFrete < 0 Then
    Raise Exception.Create('O frete deve ser informado.');

  If fltConhecimentoFrete < 0 Then
    Raise Exception.Create('O conhecimento de frete deve ser informado.');

  If (fltOutrasDespesas < 0) And (fCfgSis('ADIOUT') = 'N') Then
    Raise Exception.Create('O valor de outras despesas deve ser informado.');

  If fltVendor < 0 Then
    Raise Exception.Create('O valor de vendor deve ser informado.');

  If fltDespesaAcessoria < 0 Then
    Raise Exception.Create('O valor de despesa acessória deve ser informado.');

  If fltValorIcms < 0 Then
    Raise Exception.Create('O valor de ICMS deve ser informado.');

  If fltValorIcmsAntecipado < 0 Then
    Raise Exception.Create('O valor de ICMS antecipado deve ser informado.');

  If fltValorIcmsAntecipadoFrete < 0 Then
    Raise Exception.Create('O valor de ICMS antecipado do frete deve ser informado.');

  If fltValorGNRE < 0 Then
    Raise Exception.Create('O valor da GNRE deve ser informado.');

  If fltValorRetido < 0 Then
    Raise Exception.Create('O valor do retido deve ser informado.');

  If fltValorRetidoNaoCreditado < 0 Then
    Raise Exception.Create('O valor do retido não creditado deve ser informado.');

  If (fltValorIcmsNaoCreditado > 0) And (fltValorIcms > 0) Then
    Raise Exception.Create('Os valores de ICMS e ICMS não creditado não podem ser ambos maiores que zero.');
end;

function TCalculoUltimaCompraImpostos.fTotal: Double;
var fltValorIpiCalculado: Double;
    fltValorRetidoCalculado: Double;
    blnDeduzirPisCofinsDoIpi: Boolean;
    blnDeduzirPisConfisDoSt: Boolean;
    blnContribuinteIPI,
    blnIpiNaoCreditado,
    blnDeduzirICMSdaBaseCalculoPisCofins,
    blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia,
    blnSomarFretenaBaseCalculoPisCofins,
    blnSomarIPInaBaseCalculoPisCofins: Boolean;

    fltIpiFin,
    fltTotSubFreCon: Double;
    fltToTSubFrete: Double;

    fltBasPisCof,
    fltTotPisCof: Double;
begin
  If blnMontaDescricao Then
  Begin
    strDescricaoCalculo := '';
    strDescricaoCalculoDescontoPisCofins := '';
    strDescricaoCalculoValorRetido := '';
    strDescricaoCalculoValorIPI := '';
  End;

  blnDeduzirICMSdaBaseCalculoPisCofins := fCfgSis('DIPCPU') = 'S';
  blnSomarIPInaBaseCalculoPisCofins    := fCfgSis('IPIPIS') = '2';
  blnSomarFretenaBaseCalculoPisCofins  := fCfgSis('PISFRU') = 'S';
  blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia := fCfgSis('TRDPCI') = 'S';
  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));

  pValidarValores;
  ValorFreteCalculado := fltFrete;
  ValorConhecimentoCalculado := fltConhecimentoFrete;

  fltToTSubFrete  := 0;
  fltTotSubFreCon := 0;

  If blnUltPis And (fCfgSis('DPCPUL') = 'S') and blnItemIncidePis Then
  Begin
    fltToTSubFrete := ((ValorFreteCalculado * (fltAliquotaPis+fltAliquotaCofins)) /100);
    fltTotSubFreCon := ((fltConhecimentoFrete * (fltAliquotaPis+fltAliquotaCofins)) /100);
  End;

  If fCfgSis('DEDFRE') = 'S' Then
  Begin
    fltToTSubFrete := fltToTSubFrete + ((ValorFreteCalculado * fltAliquotaICMSdoFrete) /100);
    fltTotSubFreCon := fltTotSubFreCon + ((fltConhecimentoFrete * fltAliquotaICMSdoFrete) /100);
  End;

  ValorFreteCalculado := ValorFreteCalculado - fltToTSubFrete;
  ValorConhecimentoCalculado := ValorConhecimentoCalculado - fltTotSubFreCon;

  blnDeduzirPisCofinsDoIpi := fCfgSis('DPCIPU') = 'S';
  blnDeduzirPisConfisDoSt :=  fCfgSis('DPCSTU') = 'S';

  fltValorIpiCalculado  := fltValorIpi + fltValorIpiNaoCreditado;
  blnIpiNaoCreditado := fltValorIpiNaoCreditado > 0;

  fltIpiFin := 0;

  If blnContribuinteIpi and blnIpiNaoCreditado then
  Begin
    fltIpiFin := (fltValorIpiCalculado);

    If blnMontaDescricao Then
    Begin
      strDescricaoCalculoValorIPI := 'Valor do IPI = ' + #$A;
      strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '  (Valor do IPI (' + fFormataValor(fltValorIpi) + ') ';
      strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '+ Valor IPI Não Creditado(' + fFormataValor(fltValorIpiNaoCreditado) + '))' + #$A;
    End;

    If blnDeduzirPisCofinsDoIpi And ((blnItemIncidePis) And blnUltPis And ((Not blnForFil) Or (blnForFil And blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia))) Then
    Begin
      fltIpiFin := (fltIpiFin * (1- ((fltAliquotaPis+fltAliquotaCofins) / 100)));

      If blnMontaDescricao Then
      Begin
        strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '   * (1 - ((Alíquota de PIS(' + fFormataValor(fltAliquotaPis, 4) + ') ';
        strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '+ Alíquota COFINS(' + fFormataValor(fltAliquotaCofins, 4) + ')) / 100))';
      End;
    End;

  End
  Else If (Not blnContribuinteIpi) Then
  Begin
    If ((fCfgSis('IMPDIR', varBoolean) And blnIpiNaoCreditado) Or ((Not fCfgSis('IMPDIR', varBoolean)))) Then
    Begin
      fltIpiFin := (fltValorIpiCalculado);

      If blnMontaDescricao Then
      Begin
        strDescricaoCalculoValorIPI := 'Valor do IPI = ' + #$A;
        strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '  (Valor do IPI (' + fFormataValor(fltValorIpi) + ') ';
        strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '+ Valor IPI Não Creditado(' + fFormataValor(fltValorIpiNaoCreditado) + '))' + #$A;
      End;

      If blnDeduzirPisCofinsDoIpi And ((blnItemIncidePis) And blnUltPis And ((Not blnForFil) Or (blnForFil And blnPermiteDeduzirPisCofins_e_Icms_Em_Transferencia))) Then
      Begin
        fltIpiFin := (fltIpiFin * (1- ((fltAliquotaPis+fltAliquotaCofins) / 100)));

        If blnMontaDescricao Then
        Begin
          strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '   * (1 - ((Alíquota de PIS(' + fFormataValor(fltAliquotaPis, 4) + ') ';
          strDescricaoCalculoValorIPI := strDescricaoCalculoValorIPI + '+ Alíquota COFINS(' + fFormataValor(fltAliquotaCofins, 4) + ')) / 100))';
        End;
      End;
    End;
  End;

  fltValorRetidoCalculado := fltValorRetido + fltValorRetidoNaoCreditado;

  If blnMontaDescricao Then
  Begin
    strDescricaoCalculoValorRetido := 'Valor Retido = ' + #$A;
    strDescricaoCalculoValorRetido := strDescricaoCalculoValorRetido + '  (Valor ICMS Retido(' + fFormataValor(fltValorRetido) + ') ';
    strDescricaoCalculoValorRetido := strDescricaoCalculoValorRetido + '+ Valor ICMS Retido Não Creditado(' + fFormataValor(fltValorRetidoNaoCreditado) + '))' + #$A;
  End;

  If blnUltPis And  blnDeduzirPisConfisDoSt and blnItemIncidePis Then
  Begin
    fltValorRetidoCalculado := (fltValorRetidoCalculado * (1-(fltAliquotaPis+fltAliquotaCofins)/100));

    If blnMontaDescricao Then
    Begin
      strDescricaoCalculoValorRetido := strDescricaoCalculoValorRetido + '   * (1 - ((Alíquota de PIS(' + fFormataValor(fltAliquotaPis, 4) + ') ';
      strDescricaoCalculoValorRetido := strDescricaoCalculoValorRetido + '+ Alíquota COFINS(' + fFormataValor(fltAliquotaCofins, 4) + ')) / 100))';
    End;
  End;


  fltBasPisCof := (fltTotalItem - fltDescontoEspecial);

  If blnMontaDescricao Then
  Begin
    strDescricaoCalculoDescontoPisCofins := 'Desconto de Pis/Cofins = ' + #$A;
    strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '  (Total do Item(' + fFormataValor(fltTotalItem) + ')' + #$A;
    strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '   - Desconto Especial(' + fFormataValor(fltDescontoEspecial) + ')' + #$A;
  End;

  If blnDeduzirICMSdaBaseCalculoPisCofins Then
  Begin
    fltBasPisCof := fltBasPisCof - (fltValorIcms + fltValorIcmsNaoCreditado);

    If blnMontaDescricao Then
    Begin
      strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '   - Valor do ICMS(' + fFormataValor(fltValorIcms) + ') ';
      strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '- Valor do ICMS Não Creditado(' + fFormataValor(fltValorIcmsNaoCreditado) + ')' + #$A;
    End;

  End;

  If blnSomarIPInaBaseCalculoPisCofins Then
  Begin
    fltBasPisCof := fltBasPisCof + fltIpiFin;

    If blnMontaDescricao Then
      strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '   - Valor do IPI(' + fFormataValor(fltIpiFin) + ')' + #$A;
  End;

  If blnSomarFretenaBaseCalculoPisCofins Then
  Begin
    fltBasPisCof := fltBasPisCof + fltFrete + fltConhecimentoFrete;

    If blnMontaDescricao Then
      strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '   + Frete(' + fFormataValor(fltFrete + fltConhecimentoFrete) + ')' + #$A;
  End;

  fltTotPisCof := fltBasPisCof * (fltAliquotaPis + fltAliquotaCofins) / 100;

  If blnMontaDescricao Then
  Begin
    strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '  ) * (Alíquota de PIS(' + fFormataValor(fltAliquotaPis, 4) + ') ';
    strDescricaoCalculoDescontoPisCofins := strDescricaoCalculoDescontoPisCofins + '+ ' + 'Alíquota COFINS(' + fFormataValor(fltAliquotaCofins, 4) + ')) / 100)' + #$A;
  End;

  Result := (  fltTotalItem
               - fltDescontoEspecial
               - fltTotPisCof
               + fltIpiFin
               + ValorFreteCalculado
               + ValorConhecimentoCalculado
               + fltRpaFre
               + fltOutrasDespesas
               + fltVendor
               + fltDespesaAcessoria
               + fltValorIcmsAntecipado
               + fltValorIcmsAntecipadoFrete
               + fltValorGNRE
               + fltValorTCIF
               + fltValorTS
               + fltValorRetidoCalculado
               + fltValorFundoCombateAPobreza
               + fltValorIcmsNotaImportacao
               + fltValorSiscomex
               - fltValorIcms);

  Result := fFormataFloat(Result, 4);

  If blnMontaDescricao Then
  Begin
    strDescricaoCalculo := 'Preço + Impostos: '+ #$A;

    strDescricaoCalculo := strDescricaoCalculo + '  Total do Item(' + fFormataValor(fltTotalItem) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  - Desconto Especial(' + fFormataValor(fltDescontoEspecial) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  - Desconto de Pis/Cofins(' + fFormataValor(fltTotPisCof) + ')' + #$A;
    If fltValorIcmsNotaImportacao > 0 then
      strDescricaoCalculo := strDescricaoCalculo + '  + Valor de ICMS (' + fFormataValor(fltValorIcmsNotaImportacao) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor do IPI(' + fFormataValor(fltIpiFin) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor do Frete(' + fFormataValor(ValorFreteCalculado) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor do Conhec. Frete(' + fFormataValor(ValorConhecimentoCalculado) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor Recebimento Pag. Autônomo de Frete (RPA)(' + fFormataValor(fltRpaFre) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor das Descepesas(' + fFormataValor(fltOutrasDespesas) + ')' + #$A;
    If fltValorSiscomex > 0 Then
      strDescricaoCalculo := strDescricaoCalculo + '  + Siscomex(' + fFormataValor(fltValorSiscomex) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor Vendor(' + fFormataValor(fltVendor) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor das Descepesas Acess.(' + fFormataValor(fltDespesaAcessoria) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor do ICMS Antec.(' + fFormataValor(fltValorIcmsAntecipado) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor do ICMS Antec. Frete(' + fFormataValor(fltValorIcmsAntecipadoFrete) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor da GNRE(' + fFormataValor(fltValorGNRE) + ')' + #$A;

    If fCfgSis('SUFRAM', varBoolean) And (fCfgSis('FRMCUS', varString) = '4') Then
    Begin
      strDescricaoCalculo := strDescricaoCalculo + '  + Valor TCFI(' + fFormataValor(fltValorTCIF) + ')' + #$A;
      strDescricaoCalculo := strDescricaoCalculo + '  + Valor TS(' + fFormataValor(fltValorTS) + ')' + #$A;
    End;

    strDescricaoCalculo := strDescricaoCalculo + '  + Valor Retido(' + fFormataValor(fltValorRetidoCalculado) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  + Valor do FCP(' + fFormataValor(fltValorFundoCombateAPobreza) + ')' + #$A;
    strDescricaoCalculo := strDescricaoCalculo + '  - Valor do ICMS(' + fFormataValor(fltValorIcms) + ')' + #$A;

    strDescricaoCalculo := strDescricaoCalculo + #$A;
    strDescricaoCalculo := strDescricaoCalculo + strDescricaoCalculoDescontoPisCofins;
    strDescricaoCalculo := strDescricaoCalculo + #$A;
    strDescricaoCalculo := strDescricaoCalculo + strDescricaoCalculoValorIPI;
    strDescricaoCalculo := strDescricaoCalculo + #$A;
    strDescricaoCalculo := strDescricaoCalculo + strDescricaoCalculoValorRetido;
    strDescricaoCalculo := strDescricaoCalculo + #$A;
  End;

end;

function TCalculoUltimaCompraImpostos.fUnitario(fltQuantidade: Double): Double;
begin
  If  fltQuantidade <= 0 Then
    Result := 0
  Else
    Result := fFormataFloat(fTotal / fltQuantidade, 4);
end;

function TCalculoUltimaCompraImpostos.ItemIncidePis(
  strValue: string): TCalculoUltimaCompraImpostos;
begin
  blnItemIncidePis :=  strValue= 'S';
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.FornecedorFilial(blnValue: Boolean): TCalculoUltimaCompraImpostos;
begin
  blnForFil := blnValue;
  Result := Self;
end;

function TCalculoUltimaCompraImpostos.fFormataValor(Valor: Double; intDecimais: Integer = 2): String;
begin
  Result := FormatFloat(fMskDigitos(intDecimais), StrToFloat(AnsiReplaceStr(FloatToStr(Valor), '.', '')));
end;

end.
