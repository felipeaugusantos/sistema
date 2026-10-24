unit Faturamento.Impostos.Regras.ZerarImpostos.Icms;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.Icms,
  Faturamento.Impostos.Tipos.ZerarImpostos.Icms,
  Faturamento.Impostos.Interfaces.Model,
  Shared.Functions.Configuracoes, System.StrUtils,
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos,
  Shared.Functions.Faturamento.Impostos.Regras, Shared.Functions.Funcoes.Faturamento;

type
  TRegraImpostosZerarImpostosIcms = class(TInterfacedObject, IRegraImpostosZerarImpostosIcms)
  private
    function fSimplesNacionalECupomFiscal(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;

    function fZerarIcmsGeral(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): IResultadoRegraZerarImpostosIcms;
    function ZerarIcmsGeral(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;

    function fZerarIcmsValorMenorIgualAZero(const AParametros: IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero): IResultadoRegraZerarImpostosIcms;

    function fZerarIcmsZonaFrancaOrgaoPublico(const AParametros: IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico): IResultadoRegraZerarImpostosIcms;
    function ZerarIcmsZonaFrancaOrgaoPublico(const AParametros: IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico): Boolean;

    function fRetornaCST_TributacaoZonaFranca: String;
    function fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function fClienteZonaFrancaProdutoNacionalOuConfirmacaoDeCupomEmNota(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function fClienteZonaFrancaProdutoImportado(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function fClienteZonaFrancaProdutoSemSimilar(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function fEhEntregaFuturaNaoControleDeEntrega(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function fAlterarTributacaoIcmsPara41eZerarValores(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;

    function ClienteZonaFrancaOrgaoPublico(const AParametros: IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico): Boolean;
    function fParamentrosIcmsGeral(
      const AParametros: IParametrosRegraZerarImpostosIcms): IParametrosRegraZerarImpostosIcmsGeral;
    function fParamentrosIcmsValorMenorIgualAZero(
      const AParametros: IParametrosRegraZerarImpostosIcms): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero;
    function fParamentrosIcmsZonaFrancaOrgaoPublico(
      const AParametros: IParametrosRegraZerarImpostosIcms): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;

    function ZerarIcmsDocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(
      const AParametros: IParametrosRegraZerarImpostosIcms): Boolean;
    function CupomFiscalEGravacaoLivroFiscalCupomNfeSat(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function CupomFiscalEGravacaoLivroFiscalNotaFiscal(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
    function TributarZonaFrancaManausUsoConsumo(const AParametros: IParametrosRegraZerarImpostosIcms): Boolean;
  public
    function ZerarIcms(const AParametros: IParametrosRegraZerarImpostosIcms): IResultadoRegraZerarImpostosIcms;Overload;
    function ZerarValorDoIcms(const AParametros: IParametrosRegraZerarImpostosIcms): Boolean; Overload;

    class function New(): IRegraImpostosZerarImpostosIcms;
  end;

implementation

{ TRegraImpostosZerarImpostosIcms }

function TRegraImpostosZerarImpostosIcms.ClienteZonaFrancaOrgaoPublico(const AParametros: IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.ClienteZonaFrancaOrgaoPublico(
      AParametros.ClienteOrgaoPublico, AParametros.CalcularDescontoIcmsOrgaoPublico,
      AParametros.ClienteZonaFranca, AParametros.ClienteConsumidorFinal);
end;

function TRegraImpostosZerarImpostosIcms.fAlterarTributacaoIcmsPara41eZerarValores(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := TFunctionsRegrasImpostosFaturamento.
    fAlterarTributacaoIcmsPara41eZerarValores(AParametros.EstadoDaEmpresa,
      AParametros.EmpresaOptanteSimples, AParametros.OpcaoDeDocumento, AParametros.EspecieDoDocumento,
      AParametros.ItemTributado, AParametros.ConfiguradoParaTrocarParaX41, AParametros.ConfiguradoParaTrocarParaX41noParana);
end;

function TRegraImpostosZerarImpostosIcms.fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := TFunctionsRegrasImpostosFaturamento.
    fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(AParametros.ClassificacaoFiscalDoItem);
end;

function TRegraImpostosZerarImpostosIcms.fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := TFunctionsZerarImpostosRegrasImpostosFaturamento.
    fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros.ClassificacaoFiscalDoItem,
      AParametros.OpcaoDeDocumento, AParametros.TaxaBombeamentoPedidoOrcamento,
      AParametros.ClassificacaoFiscalDoItem, AParametros.OpcaoItensNFEspTinta,
      AParametros.ClassificacaoDeVenda, AParametros.ClienteEstado, AParametros.ClienteZonaFranca, AParametros.DentroDoEstado);
end;

function TRegraImpostosZerarImpostosIcms.fEhEntregaFuturaNaoControleDeEntrega(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := TFunctionsRegrasImpostosFaturamento.
    fEhEntregaFuturaNaoControleDeEntrega(AParametros.BaixaDeEntregaFutura,
      AParametros.EntregaFuturaDoItem);
end;

function TRegraImpostosZerarImpostosIcms.CupomFiscalEGravacaoLivroFiscalCupomNfeSat(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result :=
    (TFunctionsRegrasImpostosFaturamento.fEhCupomFiscal(AParametros.EspecieDoDocumento) And
     objConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, varBoolean));
end;

function TRegraImpostosZerarImpostosIcms.CupomFiscalEGravacaoLivroFiscalNotaFiscal(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := ((Not TFunctionsRegrasImpostosFaturamento.fEhCupomFiscal(AParametros.EspecieDoDocumento)) And
              objConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, varBoolean));
end;

function TRegraImpostosZerarImpostosIcms.fSimplesNacionalECupomFiscal(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := False;

  If AParametros.SimplesNacional Then
    Result := CupomFiscalEGravacaoLivroFiscalCupomNfeSat(AParametros) Or CupomFiscalEGravacaoLivroFiscalNotaFiscal(AParametros);
end;

function TRegraImpostosZerarImpostosIcms.fRetornaCST_TributacaoZonaFranca: String;
var
  LCstZonaFranca: String;
begin
  LCstZonaFranca := objConfiguracoes.fGetValorConfiguracao(CFG_ZONA_FRANCA_DE_MANAUS_TRIBUTAR_PRODUTOS_QUE_INICIAM_COM_A_CST, varString);

  Result := TFunctionFuncoesFaturamento.Transform(LCstZonaFranca, 1);
end;

function TRegraImpostosZerarImpostosIcms.fClienteZonaFrancaProdutoImportado(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := False;

  If not AParametros.ClienteZonaFranca Then
    Exit;

  If not (Pos(LeftStr(AParametros.CodigoDaSituacaoTributaria, 1), fRetornaCST_TributacaoZonaFranca) > 0) Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosIcms.fClienteZonaFrancaProdutoSemSimilar(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := False;

  If not AParametros.ClienteZonaFranca Then
    Exit;

  If not (Pos(LeftStr(AParametros.CodigoDaSituacaoTributaria, 1), '6_7_') > 0) Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosIcms.fClienteZonaFrancaProdutoNacionalOuConfirmacaoDeCupomEmNota(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := False;

  If not Self.fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros) Then
    Exit;

  If fClienteZonaFrancaProdutoImportado(AParametros) Then
    Exit;

  If fClienteZonaFrancaProdutoSemSimilar(AParametros) Then
    Exit;

  Result := True;
end;

function TRegraImpostosZerarImpostosIcms.ZerarIcmsGeral
(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): Boolean;
begin
  Result := true;

  If Self.fSimplesNacionalECupomFiscal(AParametros) Then
    Exit;

  If fClienteZonaFrancaProdutoNacionalOuConfirmacaoDeCupomEmNota(AParametros) Then
    Exit;

  If Self.fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(AParametros) Then
    Exit;

  If Self.fEhEntregaFuturaNaoControleDeEntrega(AParametros) Then
    Exit;

  If Self.fAlterarTributacaoIcmsPara41eZerarValores(AParametros) Then
    Exit;

  If TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarIcmsFaturamentoConsignacao(AParametros.ClassificacaoFiscalDoItem,
                                                                                       AParametros.CodigoDaSituacaoTributaria) Then
    Exit;

  Result := False;
end;

function TRegraImpostosZerarImpostosIcms.ZerarIcmsZonaFrancaOrgaoPublico(
  const AParametros: IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico): Boolean;
begin
  Result := False;

  If Not AParametros.DentroDoEstado Then
    Exit;

  If Not ClienteZonaFrancaOrgaoPublico(AParametros) Then
    Exit;

  Result := true;
end;



function TRegraImpostosZerarImpostosIcms.fZerarIcmsGeral
(const AParametros: IParametrosRegraZerarImpostosIcmsGeral): IResultadoRegraZerarImpostosIcms;
  Var
    LAliquotaDeIcmsDoItem: Double;
    LBaseDeCalculoDoIcmsDoItem: Double;
    LValorDoIcmsDoItem: Double;
begin
  LAliquotaDeIcmsDoItem := AParametros.AliquotaDeIcmsDoItem;
  LBaseDeCalculoDoIcmsDoItem := AParametros.BaseDeCalculoDoIcmsDoItem;
  LValorDoIcmsDoItem := AParametros.ValorDoIcmsDoItem;

  If Self.fSimplesNacionalECupomFiscal(AParametros) Or
     Self.fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros) Or
     Self.fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(AParametros) Or
     Self.fEhEntregaFuturaNaoControleDeEntrega(AParametros) Or
     Self.fAlterarTributacaoIcmsPara41eZerarValores(AParametros) Then
  Begin
    LAliquotaDeIcmsDoItem := 0.0;
    LBaseDeCalculoDoIcmsDoItem := 0.0;
    LValorDoIcmsDoItem := 0.0;
  End;

  Result :=
    TResultadoRegraZerarImpostosIcms.New
      .AliquotaDeIcmsDoItem(LAliquotaDeIcmsDoItem)
      .BaseDeCalculoDoIcmsDoItem(LBaseDeCalculoDoIcmsDoItem)
      .ValorDoIcmsDoItem(LValorDoIcmsDoItem);
end;

function TRegraImpostosZerarImpostosIcms.fZerarIcmsValorMenorIgualAZero
(const AParametros: IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero): IResultadoRegraZerarImpostosIcms;
Var
  LAliquotaDeIcmsDoItem: Double;
  LBaseDeCalculoDoIcmsDoItem: Double;
  LValorDoIcmsDoItem: Double;
begin
  LAliquotaDeIcmsDoItem := AParametros.AliquotaDeIcmsDoItem;
  LBaseDeCalculoDoIcmsDoItem := AParametros.BaseDeCalculoDoIcmsDoItem;
  LValorDoIcmsDoItem := AParametros.ValorDoIcmsDoItem;

  If TFunctionsRegrasImpostosFaturamento.fValorDoIcmsMenorIgualAZero(LValorDoIcmsDoItem) Then
  Begin
    LAliquotaDeIcmsDoItem := 0.0;
    LBaseDeCalculoDoIcmsDoItem := 0.0;
    LValorDoIcmsDoItem := 0.0;
  End;

  Result :=
    TResultadoRegraZerarImpostosIcms.New
      .AliquotaDeIcmsDoItem(LAliquotaDeIcmsDoItem)
      .BaseDeCalculoDoIcmsDoItem(LBaseDeCalculoDoIcmsDoItem)
      .ValorDoIcmsDoItem(LValorDoIcmsDoItem);
end;

function TRegraImpostosZerarImpostosIcms.fZerarIcmsZonaFrancaOrgaoPublico
(const AParametros: IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico): IResultadoRegraZerarImpostosIcms;
Var
  LAliquotaDeIcmsDoItem: Double;
  LBaseDeCalculoDoIcmsDoItem: Double;
  LValorDoIcmsDoItem: Double;
begin
  LAliquotaDeIcmsDoItem := AParametros.AliquotaDeIcmsDoItem;
  LBaseDeCalculoDoIcmsDoItem := AParametros.BaseDeCalculoDoIcmsDoItem;
  LValorDoIcmsDoItem := AParametros.ValorDoIcmsDoItem;

  If AParametros.DentroDoEstado Then
  Begin
    If ClienteZonaFrancaOrgaoPublico(AParametros) Then
    Begin
      LAliquotaDeIcmsDoItem := 0.0;
      LBaseDeCalculoDoIcmsDoItem := 0.0;
      LValorDoIcmsDoItem := 0.0;
    End;
  End;

  Result :=
    TResultadoRegraZerarImpostosIcms.New
      .AliquotaDeIcmsDoItem(LAliquotaDeIcmsDoItem)
      .BaseDeCalculoDoIcmsDoItem(LBaseDeCalculoDoIcmsDoItem)
      .ValorDoIcmsDoItem(LValorDoIcmsDoItem);
end;

class function TRegraImpostosZerarImpostosIcms.New: IRegraImpostosZerarImpostosIcms;
begin
  Result := Self.Create;
end;

function TRegraImpostosZerarImpostosIcms.TributarZonaFrancaManausUsoConsumo(
  const AParametros: IParametrosRegraZerarImpostosIcms): Boolean;
begin
  Result := False;
  if ((AParametros.ClienteZonaFranca) and (not AParametros.ClienteOrgaoPublico)) then
  begin
    Result := AParametros.TributaClienteZonaFranca;
  end;
end;

function TRegraImpostosZerarImpostosIcms.ZerarValorDoIcms(
  const AParametros: IParametrosRegraZerarImpostosIcms): Boolean;
begin
  Result := True;

  if TributarZonaFrancaManausUsoConsumo(AParametros) then
  begin
    Result := False;
    Exit;
  end;

  If ZerarIcmsDocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(AParametros) Then
    Exit;

  If ZerarIcmsZonaFrancaOrgaoPublico(fParamentrosIcmsZonaFrancaOrgaoPublico(AParametros))Then
    Exit;

  If ZerarIcmsGeral(fParamentrosIcmsGeral(AParametros)) Then
    Exit;

  Result := False;
end;

function TRegraImpostosZerarImpostosIcms.fParamentrosIcmsZonaFrancaOrgaoPublico
  (const AParametros: IParametrosRegraZerarImpostosIcms): IParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico;
begin
  Result :=
    TParametrosRegraZerarImpostosIcmsZonaFrancaOrgaoPublico.New
      .AliquotaDeIcmsDoItem(AParametros.AliquotaDeIcmsDoItem)
      .BaseDeCalculoDoIcmsDoItem(AParametros.BaseDeCalculoDoIcmsDoItem)
      .ValorDoIcmsDoItem(AParametros.ValorDoIcmsDoItem)
      .DentroDoEstado(AParametros.DentroDoEstado)
      .ClienteOrgaoPublico(AParametros.ClienteOrgaoPublico)
      .CalcularDescontoIcmsOrgaoPublico(AParametros.CalcularDescontoIcmsOrgaoPublico)
      .ClienteZonaFranca(AParametros.ClienteZonaFranca)
      .ClienteConsumidorFinal(AParametros.ClienteConsumidorFinal);
end;

function TRegraImpostosZerarImpostosIcms.fParamentrosIcmsGeral
  (const AParametros: IParametrosRegraZerarImpostosIcms): IParametrosRegraZerarImpostosIcmsGeral;
begin
  Result :=
    TParametrosRegraZerarImpostosIcmsGeral.New
      .AliquotaDeIcmsDoItem(AParametros.AliquotaDeIcmsDoItem)
      .BaseDeCalculoDoIcmsDoItem(AParametros.BaseDeCalculoDoIcmsDoItem)
      .ValorDoIcmsDoItem(AParametros.ValorDoIcmsDoItem)
      .SimplesNacional(AParametros.SimplesNacional)
      .ClassificacaoFiscalDoItem(AParametros.ClassificacaoFiscalDoItem)
      .OpcaoDeDocumento(AParametros.OpcaoDeDocumento)
      .TaxaBombeamentoPedidoOrcamento(AParametros.TaxaBombeamentoPedidoOrcamento)
      .OpcaoItensNFEspTinta(AParametros.OpcaoItensNFEspTinta)
      .BaixaDeEntregaFutura(AParametros.BaixaDeEntregaFutura)
      .EntregaFuturaDoItem(AParametros.EntregaFuturaDoItem)
      .EstadoDaEmpresa(AParametros.EstadoDaEmpresa)
      .CodigoDaSubstituicaoTributariaDoItem(AParametros.CodigoDaSubstituicaoTributariaDoItem)
      .EspecieDoDocumento(AParametros.EspecieDoDocumento)
      .ClassificacaoDeVenda(AParametros.ClassificacaoDeVenda)
      .EmpresaOptanteSimples(AParametros.EmpresaOptanteSimples)
      .ItemTributado(AParametros.ItemTributado)
      .ConfiguradoParaTrocarParaX41(AParametros.ConfiguradoParaTrocarParaX41)
      .ClienteZonaFranca(AParametros.ClienteZonaFranca)
      .ClienteEstado(AParametros.ClienteEstado)
      .CodigoDaSituacaoTributaria(AParametros.CodigoDaSituacaoTributaria)
      .ConfiguradoParaTrocarParaX41noParana(AParametros.ConfiguradoParaTrocarParaX41noParana)
      .DentroDoEstado(AParametros.DentroDoEstado);
end;

function TRegraImpostosZerarImpostosIcms.fParamentrosIcmsValorMenorIgualAZero
  (const AParametros: IParametrosRegraZerarImpostosIcms): IParametrosRegraZerarImpostosIcmsValorMenorIgualAZero;
begin
  Result :=
    TParametrosRegraZerarImpostosIcmsValorMenorIgualAZero.New
      .AliquotaDeIcmsDoItem(AParametros.AliquotaDeIcmsDoItem)
      .BaseDeCalculoDoIcmsDoItem(AParametros.BaseDeCalculoDoIcmsDoItem)
      .ValorDoIcmsDoItem(AParametros.ValorDoIcmsDoItem);
end;


function TRegraImpostosZerarImpostosIcms.ZerarIcms(const AParametros: IParametrosRegraZerarImpostosIcms): IResultadoRegraZerarImpostosIcms;
begin
  case AParametros.TipoZerarIcms of
    tziZonaFrancaOrgaoPublico: Result := fZerarIcmsZonaFrancaOrgaoPublico(fParamentrosIcmsZonaFrancaOrgaoPublico(AParametros));
    tziGeral:                  Result := fZerarIcmsGeral(fParamentrosIcmsGeral(AParametros));
    tziValorMenorIgualAZero:   Result := fZerarIcmsValorMenorIgualAZero(fParamentrosIcmsValorMenorIgualAZero(AParametros));
  end;
end;

function TRegraImpostosZerarImpostosIcms.ZerarIcmsDocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(
  const AParametros: IParametrosRegraZerarImpostosIcms): Boolean;
begin
  Result := False;

  If Not AParametros.DentroDoEstado Then
    Exit;

  If Not TFunctionFuncoesFaturamento.
      DocumentosDeConfirmacaoClienteOrgaoPublicoNaoCalcularIcms(
        AParametros.OpcaoDeDocumento, AParametros.ClienteOrgaoPublico, AParametros.CalcularDescontoIcmsOrgaoPublico) Then
    Exit;

  Result := True;
end;

end.
