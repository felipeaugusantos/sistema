unit TestController.Faturamento.Impostos.IcmsSt;

interface


Uses
  TestFramework,
  untFuncoes,
  untFuncFatTypes,
  untTestObjMyCampoTabela,
  Shared.Functions.Types,
  Shared.Functions.Configuracoes,
  Controller.Faturamento.Impostos.IcmsSt,
  Controller.Faturamento.Interfaces.Impostos.IcmsSt,
  Controller.Faturamento.Tipos.Impostos.IcmsSt,
  Faturamento.Impostos.Interfaces.IcmsSt,
  Faturamento.Impostos.Tipos.IcmsSt,
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
  Controller.Faturamento.Tipos.Impostos.Parametros.Comum;


Type
  TestControllerFatImpostosIcmsSt = class(TTestCase)
  private
    FMatItens : TMatrizFechamento;
    procedure SetarValoresModels;
    procedure SetarValoresModelAbreviacao(Const ATipoDaAbreviacaoFiscal: String);
    procedure SetarConfiguracoes;
    procedure ModelAbreviacaoIcms(const ATipoDaAbreviacaoFiscal: String);
    procedure PreencherMatriz;

  Published
    Procedure TestCalcularValorIcmsSt; // : IResultadoCalculoIcmsSt; Overload;

    Procedure TestCalcularValorIcmsStParametrosBasicos; // (const AParametrosCalculoValorIcmsSt: IParametrosCalculoValorIcmsSt): IResultadoCalculoIcmsSt; Overload;

    Procedure TestCalcularValorIcmsStFinal; // : IResultadoImpostosFatControllerIcmsSt;

    Procedure TestItemReducaoRICMPR_Sim;
    Procedure TestItemReducaoRICMPR_Nao;
    Procedure TestZerarValorIcms;
    Procedure TestZerarDadosIcms_false;
    Procedure TestZerarDadosIcms_true;
    Procedure TestZerarDadosSt;
    Procedure TestZerarDadosDoOrgaoPublicoDeTodosOsItens;

  Public
    procedure SetUp; override;
    procedure TearDown; override;
  end;


implementation

{ TestControllerFatImpostosIcmsSt }

procedure TestControllerFatImpostosIcmsSt.SetarConfiguracoes;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERFIL_ICMS_CCO_CONTRIBUINTE_CONSUMIDOR_CALCULO_NORMAL_E_CALCULO_POR_DENTRO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_LEGISLACAO_AMPARA_VENDA_PARA_OS_ESTADOS_MG_RS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NFCE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_DECRETO_REDUCAO_BASE_IMPOSTOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOMENTE_PARA_NAO_CONSUMIDOR_FINAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_REDUCAO_BASE_CALCULO_SUBSTITUICAO_TRIBUTARIA_NA_VENDA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ISENCAO_ICMS_VENDAS_ZONA_FRANCA_SOMENTE_PARA_PRODUTOS_NACIONAIS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_PRECO_UTILIZADO_CALCULO_SUBST_OPERACOES_PROPRIAS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_FATURAR_ORCAMENTOS_OUTRAS_LOJAS_QUANTO_UTILIZAR_F11, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VIDRO_PRODUTO_PARA_VENDA_DE_ESTRUTURAS, '');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_REVENDA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR,'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICMS_DA_ABREVIACAO_FISCAL,'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_QUANDO_SIMPLES_NACIONAL_DENTRO_ESTADO_CALCULAR_VALOR_ST_COM_ALIQUOTA_INTERNA_SIMPLES_NACIONAL,'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SIMPLES_NACIONAL_CST41_PRODUTOS_TRIBUTADOS_E_VALOR_ICMS_ZERO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASES_ICMS_E_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NOTA_FISCAL_CONCRETO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CAMPO_PRECO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_MINIMO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DIRETORIO_PARA_OPCOES_FISCAIS_INI, '');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VENDA_FORA_ESTADO_NAO_CONTRIBUINTE_TRIBUTAR_ALIQUOTA_INTERNA_ESTADO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_MODELO_CALCULO_SUBST_OPERACOES_PROPRIAS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_QUANDO_OPTANTE_SIMPLES_NACIONAL_UTILIZAR_ALIQUOTA_DA_ABREVIACAO_PARA_ENVIAR_ICMS_EFETIVO, 'N');

end;

procedure TestControllerFatImpostosIcmsSt.SetarValoresModelAbreviacao(
  const ATipoDaAbreviacaoFiscal: String);
begin
  objMyCampoTabelaAdd.Add('ABF_ALQICM' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM' + ATipoDaAbreviacaoFiscal, 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT' + ATipoDaAbreviacaoFiscal, '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST_SAI_CCO','666');

  objMyCampoTabelaAdd.Add('ABF_IVA_ST'+ ATipoDaAbreviacaoFiscal, '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET'+ ATipoDaAbreviacaoFiscal, '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST', '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF', '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP'+ ATipoDaAbreviacaoFiscal, '090');
  objMyCampoTabelaAdd.Add('ABF_ALQIED'+ ATipoDaAbreviacaoFiscal, 17);
  objMyCampoTabelaAdd.Add('ABF_BASDOR'+ ATipoDaAbreviacaoFiscal, 30);
  objMyCampoTabelaAdd.Add('ABF_BASDDS'+ ATipoDaAbreviacaoFiscal, 20);
  objMyCampoTabelaAdd.Add('ABF_ALQEFO'+ ATipoDaAbreviacaoFiscal, 12);

  objMyCampoTabelaAdd.Add('ABF_ALQICM_SAI_CNC',18);
end;

procedure TestControllerFatImpostosIcmsSt.SetarValoresModels;
begin
  objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
  objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
  objMyCampoTabelaAdd.Add('CLI_SUFRAM', 'N');
  objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('CLI_CONSUM', 'N');
  objMyCampoTabelaAdd.Add('CLI_CODATI', '002');
  objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
  objMyCampoTabelaAdd.Add('CLI_I_E_S_', '105006071117');
  objMyCampoTabelaAdd.Add('CLI_MICEMP', 'N');
  objMyCampoTabelaAdd.Add('CLI_CALICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_INDCOM', 'C');
  objMyCampoTabelaAdd.Add('CLI_IVAESP', 0);
  objMyCampoTabelaAdd.Add('CLI_IVASIM', 0);
  objMyCampoTabelaAdd.Add('CLI_IVANAC', 0);

  objMyCampoTabelaAdd.Add('COUNT(*)', 0);
  objMyCampoTabelaAdd.Add('ENT_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('ENT_COIBGE', '3543402');

  objMyCampoTabelaAdd.Add('CLI_SIBICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_STREES', 'N');
  objMyCampoTabelaAdd.Add('CLI_REDICM', 0);
  objMyCampoTabelaAdd.Add('CLI_DIF_ST', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPURD', 'N');

  objMyCampoTabelaAdd.Add('CLI_DESPIS', 'N');
  objMyCampoTabelaAdd.Add('CLI_BENREI', 'N');
  objMyCampoTabelaAdd.Add('CLI_ICMREI', 'N');
  objMyCampoTabelaAdd.Add('CLI_PRORUR', 'N');
  objMyCampoTabelaAdd.Add('CLI_IESUNI', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPUDF', 'N');

  objMyCampoTabelaAdd.Add('FISJUR', 'F');
  objMyCampoTabelaAdd.Add('I_E_S_', '12345678');
  objMyCampoTabelaAdd.Add('CONSUM', 'S');
  objMyCampoTabelaAdd.Add('CODATI', '002');
  objMyCampoTabelaAdd.Add('PRORUR', 'N');
  objMyCampoTabelaAdd.Add('MICEMP', 'N');
  objMyCampoTabelaAdd.Add('REGTRI', 'N');
  objMyCampoTabelaAdd.Add('INDUST', 'C');
  objMyCampoTabelaAdd.Add('CLI_CGCCPF', 2);

  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');

  objMyCampoTabelaAdd.Add('ITE_IPISAI', 0);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', 'N');
  objMyCampoTabelaAdd.Add('ITEGER_CODABF', '004');
  objMyCampoTabelaAdd.Add('CADITE_CODABF', '002');
  objMyCampoTabelaAdd.Add('ITEGER_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('CADITE_IMPDIR', 'N');
  objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');

  objMyCampoTabelaAdd.Add('FOR_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('FOR_I_E_S_', '');

  objMyCampoTabelaAdd.Add('CODATI', '002');

  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', '00000002,00000003,00000007,00000010,00000014,00000048');

  objMyCampoTabelaAdd.Add('ATI_CODATI', '001');

  objMyCampoTabelaAdd.Add('ITE_PREULT', 110);
  objMyCampoTabelaAdd.Add('ITE_PRECOM', 111);
  objMyCampoTabelaAdd.Add('ITE_DESF01', 10);
  objMyCampoTabelaAdd.Add('ITE_DESF02', 20);
  objMyCampoTabelaAdd.Add('ITE_DESF03', 30);
  objMyCampoTabelaAdd.Add('ITE_DESF04', 40);
  objMyCampoTabelaAdd.Add('ITE_DESF05', 50);
  objMyCampoTabelaAdd.Add('ITE_DESF06', 60);
end;

procedure TestControllerFatImpostosIcmsSt.SetUp;
begin
  //inherited;
  SetImpostosFatParametrosComum(
      TImpostosFatParametrosComum.New
        .CodigoDoCliente('90090000')
        .ClienteConsumidorFinal(false)
        .CodigoDaEmpresa('001')
        .TaxaBombeamentoPedidoOrcamento(false)
        .BaixaDeEntregaFutura(false)
        .NotaComplementoFornecedor(false)
        .NotaEspecialFornecedor(false)
        .CodigoDoFornecedor('')
        .SequencialEnderecoEntrega('')
        .OpcaoDoDocumento('VN')
        .EspecieDoDocumento('NF')
        .VendaPresencial(false)
        .CodigoDaEmpresaTE('')
        .TipoOperacaoPedidoVenda('V')
        .ClienteIndustria(false)
        .ClienteComercializacao(false)
        .UtilizaSat(false)
        .CalcularSatEcf(false)
        .DesmembrarNotaProdutosServicos(false)
        .DesmembrarMeiaNotaComNotaNormal(false)
        .TipoDePedidoFaturamento('')
        .OrigemF11(false)
        .CodigoDaEmpresaOriginal('001')
        .NumeroDoOrcamento('')
        .ParametrosClienteConsumidor(Nil));

end;

procedure TestControllerFatImpostosIcmsSt.TearDown;
begin
  inherited;

end;

procedure TestControllerFatImpostosIcmsSt.TestCalcularValorIcmsSt;
Var
  ReturnValue : IResultadoCalculoIcmsSt;
begin
  PreencherMatriz;

  SetarConfiguracoes;
  SetarValoresModels;
  SetarValoresModelAbreviacao('_SAI_NCO');
  SetarValoresModelAbreviacao('_SAI_CNC');
  ModelAbreviacaoIcms('_ENT_PEF');

  ReturnValue :=
    TImpostosFatControllerIcmsSt.New(FMatItens, 0)
        .CalcularValorIcmsSt;

  CheckTrue(
             (ReturnValue.ResultadoCalculoIcms.AliquotaDoIcms = 18) And
             (ReturnValue.ResultadoCalculoIcms.BaseDeCalculoDoIcms = 150) And
             (ReturnValue.ResultadoCalculoIcms.ValorCalculadoDoIcms = 27) And
             (ReturnValue.ResultadoCalculoIcms.PercentualDaBaseDeIcms = 100) And
             (ReturnValue.ResultadoCalculoIcms.ValorDaDiferencaDeIcms = 0) And
             (ReturnValue.ResultadoCalculoIcms.AliquotaDeIcmsAnterior = 18) And
             (ReturnValue.ResultadoCalculoIcms.BaseDeCalculoDoIcmsAnterior = 150) And
             (ReturnValue.ResultadoCalculoIcms.ValorDoIcmsAnterior = 27) And
             (ReturnValue.ResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms = 0) And
             (ReturnValue.ResultadoCalculoIcms.ReducaoRICMPR = 'N'));

end;

procedure TestControllerFatImpostosIcmsSt.ModelAbreviacaoIcms(const ATipoDaAbreviacaoFiscal: String);
begin
  objMyCampoTabelaAdd.Add('ABF_ALQICM' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM' + ATipoDaAbreviacaoFiscal, 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT' + ATipoDaAbreviacaoFiscal, '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST_SAI_CCO','666');

  objMyCampoTabelaAdd.Add('ABF_IVA_ST'+ ATipoDaAbreviacaoFiscal, '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET'+ ATipoDaAbreviacaoFiscal, '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST', '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF', '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP'+ ATipoDaAbreviacaoFiscal, '090');
  objMyCampoTabelaAdd.Add('ABF_ALQIED'+ ATipoDaAbreviacaoFiscal, 17);
  objMyCampoTabelaAdd.Add('ABF_BASDOR'+ ATipoDaAbreviacaoFiscal, 30);
  objMyCampoTabelaAdd.Add('ABF_BASDDS'+ ATipoDaAbreviacaoFiscal, 20);
  objMyCampoTabelaAdd.Add('ABF_ALQEFO'+ ATipoDaAbreviacaoFiscal, 12);
end;


procedure TestControllerFatImpostosIcmsSt.TestCalcularValorIcmsStFinal;
Var
  ReturnValue : IResultadoImpostosFatControllerIcmsSt;
begin
  PreencherMatriz;

  SetarConfiguracoes;
  SetarValoresModels;
  SetarValoresModelAbreviacao('_SAI_NCO');
  SetarValoresModelAbreviacao('_SAI_CNC');
  ModelAbreviacaoIcms('_ENT_PEF');

  FMatItens[0].strCodSit := '610';

	objMyCampoTabelaAdd.Add('ABF_CODSIT_SAI_NCO', '610');
	objMyCampoTabelaAdd.Add('ABF_CODSIT_SAI_CNC', '610');
  objMyCampoTabelaAdd.Add('ABF_CODSIT_ENT_PEF', '610');

  ReturnValue :=
    TImpostosFatControllerIcmsSt.New(FMatItens, 0)
        .CalcularValorIcmsStFinal;

  CheckTrue(
    (CompararValores(ReturnValue.BaseDaSubstituicaoTributariaSimulada , 1350)) And
    (CompararValores(ReturnValue.AliquotaDaSubstituicaoTributariaSimulada ,18)) And
    (CompararValores(ReturnValue.ValorDaSubstituicaoTributariaSimulada, 216))And
    (CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem , 0)) And
    (CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem ,0)) And
    (CompararValores(ReturnValue.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao, 0)) And
    (CompararValores(ReturnValue.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao, 0)) And
    (CompararValores(ReturnValue.BaseDaSTCustoAquisicao , 2970)) And
    (CompararValores(ReturnValue.ValorDaSTCustoAquisicao , 534.6)) And
    (CompararValores(ReturnValue.FatorPositivo , 534.6)) And
    (ReturnValue.FatorNegativo = 0));

end;

procedure TestControllerFatImpostosIcmsSt.PreencherMatriz;
begin
  SetLength(FMatItens, Length(FMatItens) + 1);

  FMatItens[0].strCodIte := '40294';
  FMatItens[0].opcINFesp := opcVazio;
  FMatItens[0].strEntFut := 'N';
  FMatItens[0].fltTotIte := 150;
  FMatItens[0].fltValFre := 0;
  FMatItens[0].fltDesAce := 0;
  FMatItens[0].fltDesEsp := 0;
  FMatItens[0].strCodFor := '';
  FMatItens[0].strClaFis := '5102';
  FMatItens[0].strCodSit := '000';
  FMatItens[0].fltAlq__S := 0;
  FMatItens[0].fltUniTar := 50;
  FMatItens[0].fltQtdIte := 3;
  FMatItens[0].strEspDev := '';
  FMatItens[0].blnMeiaNotaFatorExpedicao:= false;
  FMatItens[0].fltPreCus := 0;
  FMatItens[0].fltPreUlt := 0;
  FMatItens[0].fltImpUlt := 0;
  FMatItens[0].recDifalFCP.fltPerFcp := 0;
  FMatItens[0].recDifalFCP.fltValFcp := 0;
  FMatItens[0].strIdePro := 'NOR';
  FMatItens[0].fltPrcTin := 0;
  FMatItens[0].fltCusIte := 0;
  FMatItens[0].strClaIpi := '';
  FMatItens[0].strRICMPR := 'N';
end;

procedure TestControllerFatImpostosIcmsSt.TestCalcularValorIcmsStParametrosBasicos;
Var
  FMatItens   : TMatrizFechamento;
  ReturnValue : IResultadoCalculoIcmsSt;
  LParametrosCalculoValorIcmsSt: IParametrosCalculoValorIcmsSt;
begin
  PreencherMatriz;

  SetarConfiguracoes;
  SetarValoresModels;
  SetarValoresModelAbreviacao('_SAI_NCO');
  SetarValoresModelAbreviacao('_SAI_CNC');
  ModelAbreviacaoIcms('_ENT_PEF');

  objMyCampoTabelaAdd.Add('FISJUR', 'F');
  objMyCampoTabelaAdd.Add('I_E_S_', '12345678');
  objMyCampoTabelaAdd.Add('CONSUM', 'S');
  objMyCampoTabelaAdd.Add('CODATI', '002');
  objMyCampoTabelaAdd.Add('PRORUR', 'N');
  objMyCampoTabelaAdd.Add('MICEMP', 'N');
  objMyCampoTabelaAdd.Add('REGTRI', 'N');
  objMyCampoTabelaAdd.Add('INDUST', 'C');

  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', '00000002,00000003,00000007,00000010,00000014,00000048');

  objMyCampoTabelaAdd.Add('ATI_CODATI', '001');

  LParametrosCalculoValorIcmsSt:=
    TParametrosCalculoValorIcmsSt.New
      .CodigoDoCliente('90090000')
      .CodigoDoProduto('40294')
      .CodigoDaEmpresa('001')
      .TotalGeralDoItem(150)
      .ClienteConsumidorFinal(false)
      .ClienteIndustria(false)
      .ClienteComercializacao(false);

  ReturnValue :=
    TImpostosFatControllerIcmsSt.New(FMatItens, 0)
      .CalcularValorIcmsSt(LParametrosCalculoValorIcmsSt);

  CheckTrue(
             (ReturnValue.ResultadoCalculoIcms.AliquotaDoIcms = 18) And
             (ReturnValue.ResultadoCalculoIcms.BaseDeCalculoDoIcms = 150) And
             (ReturnValue.ResultadoCalculoIcms.ValorCalculadoDoIcms = 27) And
             (ReturnValue.ResultadoCalculoIcms.PercentualDaBaseDeIcms = 100) And
             (ReturnValue.ResultadoCalculoIcms.ValorDaDiferencaDeIcms = 0) And
             (ReturnValue.ResultadoCalculoIcms.AliquotaDeIcmsAnterior = 18) And
             (ReturnValue.ResultadoCalculoIcms.BaseDeCalculoDoIcmsAnterior = 150) And
             (ReturnValue.ResultadoCalculoIcms.ValorDoIcmsAnterior = 27) And
             (ReturnValue.ResultadoCalculoIcms.PercentualDeReducaoDaBaseDeIcms = 0) And
             (ReturnValue.ResultadoCalculoIcms.ReducaoRICMPR = 'N')
           );
end;

procedure TestControllerFatImpostosIcmsSt.TestItemReducaoRICMPR_Nao;
Var
  ReturnValue : String;
begin
  PreencherMatriz;

  ReturnValue := TImpostosFatControllerIcmsSt.New(FMatItens, 0).ItemReducaoRICMPR('N');

  CheckTrue(ReturnValue = FMatItens[0].strRICMPR);

end;

procedure TestControllerFatImpostosIcmsSt.TestItemReducaoRICMPR_Sim;
Var
  ReturnValue : String;
begin
  ReturnValue := TImpostosFatControllerIcmsSt.New(FMatItens, 0).ItemReducaoRICMPR('S');

  CheckTrue(ReturnValue = 'S');
end;

procedure TestControllerFatImpostosIcmsSt.TestZerarDadosDoOrgaoPublicoDeTodosOsItens;
begin
  PreencherMatriz;
  TImpostosFatControllerIcmsSt.New(FMatItens, 0).ZerarDadosDoOrgaoPublicoDeTodosOsItens;
end;

procedure TestControllerFatImpostosIcmsSt.TestZerarDadosIcms_false;
begin
  PreencherMatriz;
  TImpostosFatControllerIcmsSt.New(FMatItens, 0).ZerarDadosIcms(false);
end;

procedure TestControllerFatImpostosIcmsSt.TestZerarDadosIcms_true;
begin
  PreencherMatriz;
  TImpostosFatControllerIcmsSt.New(FMatItens, 0).ZerarDadosIcms(true);
end;

procedure TestControllerFatImpostosIcmsSt.TestZerarDadosSt;
begin
  PreencherMatriz;
  TImpostosFatControllerIcmsSt.New(FMatItens, 0).ZerarDadosSt;
end;

procedure TestControllerFatImpostosIcmsSt.TestZerarValorIcms;
begin
  PreencherMatriz;
  TImpostosFatControllerIcmsSt.New(FMatItens, 0).ZerarValorIcms;
end;

Initialization
  RegisterTest(TestControllerFatImpostosIcmsSt.Suite);
end.
