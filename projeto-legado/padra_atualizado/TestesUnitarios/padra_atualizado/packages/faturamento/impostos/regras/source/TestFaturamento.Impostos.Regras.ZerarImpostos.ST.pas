unit TestFaturamento.Impostos.Regras.ZerarImpostos.ST;

interface

uses
  TestFramework, Faturamento.Impostos.Interfaces.ZerarImpostos.ST,
  Faturamento.Impostos.Tipos.ZerarImpostos.ST,
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types,
  Shared.Functions.Faturamento.Impostos.Regras,
  Faturamento.Impostos.Regras.ZerarImpostos.ST,
  Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Tipos.Model,
  Shared.Functions.Configuracoes, Shared.Functions.Types, Shared.Functions.Core,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos;

type
  // Test methods for class TRegraImpostosZerarImpostosIcms

  TestTRegraImpostosZerarImpostosST = class(TTestCase)
  strict private
    Const
      CLASSIFICACAO_DE_VENDA = '5102_6102_5403_6403_5405_6404_6108_5655_6655_'+
                               '5656_6656_5101_6101_1202_2202_1411_2411_5922_'+
                               '6922_5933_6933_7102_3202_7654_5110_6110_6401_'+
                               '5401_5910_6107_1152_5104_6104_';

    Var
      FSimplesNacional: Boolean;
      FClassificacaoFiscalDoItem: String;
      FOpcaoDeDocumento: String;
      FTaxaBombeamentoPedidoOrcamento: Boolean;
      FOpcaoItensNFEspTinta: TOpcItensNFespTinta;
      FBaixaDeEntregaFutura: Boolean;
      FEntregaFuturaDoItem: Boolean;
      FEstadoDaEmpresa: String;
      FCodigoDaSubstituicaoTributariaDoItem: String;
      FEspecieDoDocumento: String;
      FClassificacaoDeVenda: String;
      FDentroDoEstado: Boolean;
      FEmpresaOptanteSimples: Boolean;
      FItemTributado: Boolean;
      FConfiguradoParaTrocarParaX41: Boolean;
      FClienteOrgaoPublico: Boolean;
      FCalcularDescontoIcmsOrgaoPublico: Boolean;
      FClienteZonaFranca: Boolean;
      FClienteConsumidorFinal: Boolean;
      FClienteEstado: String;
      FClienteTARE: String;
      FClienteDEFIT: String;
      FDesmembrarMeiaNotaComNotaNormal: Boolean;
      FMeiaNotaFatorExpedicao : Boolean;
      FTipoDePedidoFaturamento: String;
      FDesmembrarNotaProdutosServicos : Boolean;
      FEhItemConcreto: Boolean;

    procedure pSetarParametrosDefault;
    Function RetornarClasseDeParametros : IParametrosRegraZerarImpostosST;
    procedure pSetarConfiguracoesDefault;


  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestZerarValorDoST_False;
    procedure TestZerarValorDoSTClienteZonaFrancaOuConfirmacaoDeCupomEmNota_False;
    procedure TestZerarValorDoSTClienteZonaFrancaOuConfirmacaoDeCupomEmNota_true;
    procedure TestZerarValorDoSTClienteTare_True;
    procedure TestZerarValorDoSTClienteDefit_True;
    procedure TestZerarValorDoSTClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia_True;
    procedure TestZerarValorDoSTZerarMeiaNotaParaDocumentosMIFFDesmembrarMeiaNotaComNotaNormalFatorExpedicao_True;
    procedure TestZerarValorDoSTZerarMeiaNotaParaDocumentosMIFFDesmembrarMeiaNotaComNotaNormalFatorExpedicao_False;
    procedure TestZerarValorDoSTZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto_True;

  end;

implementation



{ TestTRegraImpostosZerarImpostosST }

procedure TestTRegraImpostosZerarImpostosST.pSetarConfiguracoesDefault;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASES_ICMS_E_IPI, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_PARA_PEDIDO_ORCAMENTO, 'S');
end;

procedure TestTRegraImpostosZerarImpostosST.pSetarParametrosDefault;
begin
  pSetarConfiguracoesDefault;

  FSimplesNacional                      := false;
  FClassificacaoFiscalDoItem            := '6108';
  FOpcaoDeDocumento                     := 'VN';
  FTaxaBombeamentoPedidoOrcamento       := false;
  FOpcaoItensNFEspTinta                 := opcVazio;
  FBaixaDeEntregaFutura                 := False;
  FEntregaFuturaDoItem                  := False;
  FEstadoDaEmpresa                      := 'SP';
  FCodigoDaSubstituicaoTributariaDoItem := '000';
  FEspecieDoDocumento                   := 'NF';
  FClassificacaoDeVenda                 := CLASSIFICACAO_DE_VENDA;
  FDentroDoEstado                       := true;
  FEmpresaOptanteSimples                := False;
  FItemTributado                        := False;
  FConfiguradoParaTrocarParaX41         := False;
  FClienteOrgaoPublico                  := False;
  FCalcularDescontoIcmsOrgaoPublico     := False;
  FClienteZonaFranca                    := False;
  FClienteConsumidorFinal               := False;
  FClienteEstado                        := 'SP';
  FClienteTARE                          := '';
  FClienteDEFIT                         := '';
  FDesmembrarMeiaNotaComNotaNormal      := False;
  FMeiaNotaFatorExpedicao               := False;
  FTipoDePedidoFaturamento              := '';
  FDesmembrarNotaProdutosServicos       := false;
  FEhItemConcreto                       := false;
end;

function TestTRegraImpostosZerarImpostosST.RetornarClasseDeParametros: IParametrosRegraZerarImpostosST;
begin
  Result :=
    TParametrosRegraZerarImpostosST.New
      .SimplesNacional(FSimplesNacional)
      .ClassificacaoFiscalDoItem(FClassificacaoFiscalDoItem)
      .OpcaoDeDocumento(FOpcaoDeDocumento)
      .TaxaBombeamentoPedidoOrcamento(FTaxaBombeamentoPedidoOrcamento)
      .OpcaoItensNFEspTinta(FOpcaoItensNFEspTinta)
      .BaixaDeEntregaFutura(FBaixaDeEntregaFutura)
      .EntregaFuturaDoItem(FEntregaFuturaDoItem)
      .EstadoDaEmpresa(FEstadoDaEmpresa)
      .CodigoDaSubstituicaoTributariaDoItem(FCodigoDaSubstituicaoTributariaDoItem)
      .EspecieDoDocumento(FEspecieDoDocumento)
      .ClassificacaoDeVenda(FClassificacaoDeVenda)
      .DentroDoEstado(FDentroDoEstado)
      .EmpresaOptanteSimples(FEmpresaOptanteSimples)
      .ItemTributado(FItemTributado)
      .ConfiguradoParaTrocarParaX41(FConfiguradoParaTrocarParaX41)
      .ClienteOrgaoPublico(FClienteOrgaoPublico)
      .CalcularDescontoIcmsOrgaoPublico(FCalcularDescontoIcmsOrgaoPublico)
      .ClienteZonaFranca(FClienteZonaFranca)
      .ClienteConsumidorFinal(FClienteConsumidorFinal)
      .ClienteEstado(FClienteEstado)
      .ClienteTARE(FClienteTARE)
      .ClienteDEFIT(FClienteDEFIT)
      .DesmembrarMeiaNotaComNotaNormal(FDesmembrarMeiaNotaComNotaNormal)
      .MeiaNotaFatorExpedicao(FMeiaNotaFatorExpedicao)
      .TipoDePedidoFaturamento(FTipoDePedidoFaturamento)
      .DesmembrarNotaProdutosServicos(FDesmembrarNotaProdutosServicos)
      .EhItemConcreto(FEhItemConcreto);
end;

procedure TestTRegraImpostosZerarImpostosST.SetUp;
begin
  inherited;

end;

procedure TestTRegraImpostosZerarImpostosST.TearDown;
begin
  inherited;

end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia_True;
Var
  ReturnValue : Boolean;
begin
  pSetarParametrosDefault;

  FClassificacaoFiscalDoItem := '915_916';
  FClienteZonaFranca := true;

  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(ReturnValue);
end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTClienteDefit_True;
Var
  ReturnValue : Boolean;
begin
  pSetarParametrosDefault;

  FClienteZonaFranca := true;
  FClienteDEFIT      := 'SIM';

  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(ReturnValue);
end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTClienteTare_True;
Var
  ReturnValue : Boolean;
begin

  pSetarParametrosDefault;

  FClienteZonaFranca := true;
  FClienteTARE       := 'SIM';

  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(ReturnValue);
end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTClienteZonaFrancaOuConfirmacaoDeCupomEmNota_False;
Var
  ReturnValue : Boolean;
begin

  pSetarParametrosDefault;

  FClienteZonaFranca := true;

  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(Not ReturnValue);
end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTClienteZonaFrancaOuConfirmacaoDeCupomEmNota_true;
Var
  ReturnValue : Boolean;
begin
  pSetarParametrosDefault;

  FOpcaoDeDocumento := 'CN';
  FTaxaBombeamentoPedidoOrcamento := True;

  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(ReturnValue);
end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto_True;
Var
  ReturnValue : Boolean;
begin
  pSetarParametrosDefault;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, 'N');

  FClienteZonaFranca               := true;
  FDesmembrarMeiaNotaComNotaNormal := true;
  FEspecieDoDocumento              := '';
  FOpcaoDeDocumento                := 'TR';
  FMeiaNotaFatorExpedicao          := true;
  FTipoDePedidoFaturamento         := 'B';

  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(ReturnValue);

end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTZerarMeiaNotaParaDocumentosMIFFDesmembrarMeiaNotaComNotaNormalFatorExpedicao_False;
Var
  ReturnValue : Boolean;
begin
  pSetarParametrosDefault;


  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, 'S');

  FClienteZonaFranca               := true;
  FDesmembrarMeiaNotaComNotaNormal := true;
  FEspecieDoDocumento              := 'MI_FF_';
  FMeiaNotaFatorExpedicao          := true;
  FTipoDePedidoFaturamento         := 'B';


  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(Not ReturnValue);

end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoSTZerarMeiaNotaParaDocumentosMIFFDesmembrarMeiaNotaComNotaNormalFatorExpedicao_True;
Var
  ReturnValue : Boolean;
begin
  pSetarParametrosDefault;


  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_ST_PARA_DOCUMENTOS_COM_ESPECIE_FF, 'N');

  FClienteZonaFranca               := true;
  FDesmembrarMeiaNotaComNotaNormal := true;
  FEspecieDoDocumento              := 'MI_FF_';
  FMeiaNotaFatorExpedicao          := true;
  FTipoDePedidoFaturamento         := 'B';


  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(ReturnValue);
end;

procedure TestTRegraImpostosZerarImpostosST.TestZerarValorDoST_False;
Var
  ReturnValue : Boolean;
begin

  pSetarParametrosDefault;

  ReturnValue := TRegraImpostosZerarImpostosST.New.ZerarValorDoST(RetornarClasseDeParametros);

  CheckTrue(ReturnValue = false);
end;

initialization
  RegisterTest(TestTRegraImpostosZerarImpostosST.Suite);
end.

