unit TestController.Faturamento.Impostos.FcpDifal;

interface

Uses
  TestFramework,
  untFuncFatTypes,
  Shared.Functions.Configuracoes,
  untTestObjMyCampoTabela,
  Shared.Functions.Types,
  Controller.Faturamento.Impostos.FcpDifal,
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
  Controller.Faturamento.Tipos.Impostos.Parametros.Comum,
  Faturamento.Impostos.Interfaces.FcpDifal,
  Faturamento.Impostos.Tipos.FcpDifal;

Type
  TestControllerFatImpostosFcpDifal = class(TTestCase)
  Private
    procedure SetarValoresTabelaECfg(Const ATipoDaAbreviacaoFiscal : String);
  Public
    procedure SetUp; override;
    procedure TearDown; override;
  Published
    procedure TestCalcularValorDifal;
    procedure TestProdutoRevendaDentroDoEstado;
  end;

implementation


{ TestControllerFatImpostosFcpDifal }

procedure TestControllerFatImpostosFcpDifal.SetUp;
begin
  inherited;

end;

procedure TestControllerFatImpostosFcpDifal.TearDown;
begin
  inherited;

end;

procedure TestControllerFatImpostosFcpDifal.TestCalcularValorDifal;
Var
  LRecDifalFCP   : TRecDifalFCP;
  LMatFechamento : Array Of TDadosFechamento;
  ReturnValue    : IResultadoCalculoFcpDifalFinal;
begin
  SetarValoresTabelaECfg('_SAI_CNC');

  SetLength(LMatFechamento, Length(LMatFechamento) + 1);
  LMatFechamento[0].strIteAbf   := '00001';
  LMatFechamento[0].strCodAbf   := '004';
  LMatFechamento[0].strCodSit   := '000';
  LMatFechamento[0].fltBasIcm   := 100;
  LMatFechamento[0].strDocDev   := '';
  LMatFechamento[0].strCodFis   := '';
  LMatFechamento[0].recDifalFCP := LRecDifalFCP;
  LMatFechamento[0].strIndRev   := 'R';
  LMatFechamento[0].strClaFis   := '5402';
  LMatFechamento[0].strEntFut   := 'N';
  LMatFechamento[0].strDocDev   := '';
  LMatFechamento[0].strEspDev   := '';
  LMatFechamento[0].strEmpDev   := '';
  LMatFechamento[0].strCodIte   := '45350';
  LMatFechamento[0].fltQtdIte   := 1;
  LMatFechamento[0].opcINFesp   := opcVazio;
  LMatFechamento[0].fltValRet   := 100;
  LMatFechamento[0].fltAlqIcm   := 10;
  LMatFechamento[0].fltBasRet   := 10;
  LMatFechamento[0].fltValIpi   := 10;
  LMatFechamento[0].fltValFre   := 10;
  LMatFechamento[0].fltTotIte   := 10;
  LMatFechamento[0].fltDesEsp   := 10;
  LMatFechamento[0].fltDesAce   := 10;
  LMatFechamento[0].fltBas__S   := 10;

  SetImpostosFatParametrosComumFcpDifal(
    TImpostosFatParametrosComumFcpDifal.New
      .CodigoDoCliente('10001000')
      .SequencialEnderecoEntrega('')
      .VendaPresencial(false)
      .OpcaoDoDocumento('VN')
      .CodigoDoFornecedor('000000001')
      .NotaComplementoFornecedor(False)
      .NotaEspecialFornecedor(False)
      .ClienteConsumidorFinal(False)
      .ParametrosClienteConsumidor(Nil)
      .TipoDaAbreviacaoFiscal('_SAI_CNC')
      .ClienteFilial(false)
      .DiferencaFCPST(False)
      .CodigoDaEmpresa('777')
      .CodigoDaEmpresaTE('')
      .ClienteIndustria(false)
      .ClassificacaoFiscalRecebimentoGarantia('')
      .AliquotaFCPST(0)
      .BaixaDeEntregaFutura(False)
      .EspecieDoDocumento('VN'));

  ReturnValue :=
    TImpostosFatControllerFcpDifal.New(LMatFechamento[0])
      .CalcularValorFcpDifalFinal;

  CheckTrue
  ( ( ReturnValue.BaseDestino = 0 ) And
    ( ReturnValue.IcmsDestino = 0)  And
    ( ReturnValue.IcmsOrigem = 0)   And
    ( ReturnValue.AlqInterestadualCalc = 12)    And
    ( ReturnValue.RecordDifalFCP.fltAlDifa = 0) And
    ( ReturnValue.RecordDifalFCP.fltDifDes = 0) And
    ( ReturnValue.RecordDifalFCP.fltDifOri = 0) And
    ( ReturnValue.RecordDifalFCP.fltValFcp = 0) And
    ( ReturnValue.RecordDifalFCP.fltPerFcp = 0) And
    ( ReturnValue.RecordDifalFCP.fltAlqIne = 0) And
    ( ReturnValue.RecordDifalFCP.fltAlqUfd = 0) And
    ( ReturnValue.RecordDifalFCP.fltBcuFde = 0) And
    ( ReturnValue.RecordDifalFCP.fltPerPar = 0) And
    ( ReturnValue.RecordDifalFCP.fltBasFcp = 0) And
    ( ReturnValue.RecordDifalFCP.blnGrvInf = false));
end;

procedure TestControllerFatImpostosFcpDifal.TestProdutoRevendaDentroDoEstado;
Var
  LRecDifalFCP   : TRecDifalFCP;
  LMatFechamento : Array Of TDadosFechamento;
  ReturnValue    : IResultadoCalculoFcpDifalFinal;
begin
  SetarValoresTabelaECfg('_SAI_CNC');

  objMyCampoTabelaAdd.Add('CLI_ORGPUB',  'N');
  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'RJ');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3304557');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'RJ');
  objMyCampoTabelaAdd.Add('CONSUM',      'N');

  objMyCampoTabelaAdd.Add('ABF_ALQICM',  12);
  objMyCampoTabelaAdd.Add('ABF_ALQRET',  18);
  objMyCampoTabelaAdd.Add('ABF_ALQFCP',   2);
  objMyCampoTabelaAdd.Add('ABF_BASICM', 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT', '010');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI , 'S');

  SetLength(LMatFechamento, Length(LMatFechamento) + 1);
  LMatFechamento[0].strIteAbf   := '00001';
  LMatFechamento[0].strCodAbf   := '004';
  LMatFechamento[0].strCodSit   := '010';
  LMatFechamento[0].fltBasIcm   := 100;
  LMatFechamento[0].strDocDev   := '';
  LMatFechamento[0].strCodFis   := '';
  LMatFechamento[0].recDifalFCP := LRecDifalFCP;
  LMatFechamento[0].strIndRev   := 'R';
  LMatFechamento[0].strClaFis   := '5403';
  LMatFechamento[0].strEntFut   := 'N';
  LMatFechamento[0].strDocDev   := '';
  LMatFechamento[0].strEspDev   := '';
  LMatFechamento[0].strEmpDev   := '';
  LMatFechamento[0].strCodIte   := '45350';
  LMatFechamento[0].fltQtdIte   := 1;
  LMatFechamento[0].opcINFesp   := opcVazio;
  LMatFechamento[0].fltValRet   := 120;
  LMatFechamento[0].fltAlqIcm   := 12;
  LMatFechamento[0].fltBasRet   := 135;
  LMatFechamento[0].fltValIpi   := 0;
  LMatFechamento[0].fltValFre   := 0;
  LMatFechamento[0].fltTotIte   := 100;
  LMatFechamento[0].fltDesEsp   := 0;
  LMatFechamento[0].fltDesAce   := 0;
  LMatFechamento[0].fltBas__S   := 100;
  LMatFechamento[0].strImpDir   := 'S';
  LMatFechamento[0].strIndRev   := 'R';

  SetImpostosFatParametrosComumFcpDifal(
    TImpostosFatParametrosComumFcpDifal.New
      .CodigoDoCliente('10001000')
      .SequencialEnderecoEntrega('')
      .VendaPresencial(false)
      .OpcaoDoDocumento('VN')
      .CodigoDoFornecedor('000000001')
      .NotaComplementoFornecedor(False)
      .NotaEspecialFornecedor(False)
      .ClienteConsumidorFinal(False)
      .ParametrosClienteConsumidor(Nil)
      .TipoDaAbreviacaoFiscal('_SAI_CNC')
      .ClienteFilial(false)
      .DiferencaFCPST(False)
      .CodigoDaEmpresa('777')
      .CodigoDaEmpresaTE('')
      .ClienteIndustria(false)
      .ClassificacaoFiscalRecebimentoGarantia('')
      .AliquotaFCPST(2)
      .BaixaDeEntregaFutura(False)
      .EspecieDoDocumento('VN'));

  ReturnValue :=
    TImpostosFatControllerFcpDifal.New(LMatFechamento[0])
      .CalcularValorFcpDifalFinal;

  CheckTrue
  ( ( ReturnValue.BaseDestino = 100 ) And
    ( ReturnValue.IcmsDestino = 0)  And
    ( ReturnValue.IcmsOrigem = 0)   And
    ( ReturnValue.AlqInterestadualCalc = 12) And
    ( ReturnValue.RecordDifalFCP.blnGrvInf = false));
end;

procedure TestControllerFatImpostosFcpDifal.SetarValoresTabelaECfg(Const ATipoDaAbreviacaoFiscal : String);
begin

  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'S');
  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');

  objMyCampoTabelaAdd.Add('ABF_ALQICM', 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET', 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM', 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT', '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST','666');
  objMyCampoTabelaAdd.Add('ATI_CODATI', '001');

  objMyCampoTabelaAdd.Add('ABF_IVA_ST' + ATipoDaAbreviacaoFiscal, '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET' + ATipoDaAbreviacaoFiscal, '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST' + ATipoDaAbreviacaoFiscal, '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF' + ATipoDaAbreviacaoFiscal, '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP' + ATipoDaAbreviacaoFiscal, '090');
  objMyCampoTabelaAdd.Add('ABF_ALQIED' + ATipoDaAbreviacaoFiscal, 17);
  objMyCampoTabelaAdd.Add('ABF_BASDOR' + ATipoDaAbreviacaoFiscal, 30);
  objMyCampoTabelaAdd.Add('ABF_BASDDS' + ATipoDaAbreviacaoFiscal, 20);
  objMyCampoTabelaAdd.Add('ABF_ALQEFO' + ATipoDaAbreviacaoFiscal, 12);

  objMyCampoTabelaAdd.Add('ABF_ALQICM' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_ALQRET' + ATipoDaAbreviacaoFiscal, 18);
  objMyCampoTabelaAdd.Add('ABF_BASICM' + ATipoDaAbreviacaoFiscal, 100);
  objMyCampoTabelaAdd.Add('ABF_CODSIT' + ATipoDaAbreviacaoFiscal, '000');

  objMyCampoTabelaAdd.Add('ABF_CAL_ST' + ATipoDaAbreviacaoFiscal,'666');

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

  objMyCampoTabelaAdd.Add('FISJUR', 'F');
  objMyCampoTabelaAdd.Add('I_E_S_', '12345678');
  objMyCampoTabelaAdd.Add('CONSUM', 'S');
  objMyCampoTabelaAdd.Add('CODATI', '002');
  objMyCampoTabelaAdd.Add('PRORUR', 'N');
  objMyCampoTabelaAdd.Add('MICEMP', 'N');
  objMyCampoTabelaAdd.Add('REGTRI', 'N');
  objMyCampoTabelaAdd.Add('INDUST', 'C');
  objMyCampoTabelaAdd.Add('CLI_CGCCPF', 2);

  objMyCampoTabelaAdd.Add('GROUP_CONCAT(EMP_CLIFIL)', '00000002,00000003,00000007,00000010,00000014,00000048');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERFIL_ICMS_CCO_CONTRIBUINTE_CONSUMIDOR_CALCULO_NORMAL_E_CALCULO_POR_DENTRO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_LEGISLACAO_AMPARA_VENDA_PARA_OS_ESTADOS_MG_RS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NFCE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_DECRETO_REDUCAO_BASE_IMPOSTOS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CAMPO_PRECO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_MINIMO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOMENTE_PARA_NAO_CONSUMIDOR_FINAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_REDUCAO_BASE_CALCULO_SUBSTITUICAO_TRIBUTARIA_NA_VENDA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DIRETORIO_PARA_OPCOES_FISCAIS_INI, '');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VENDA_FORA_ESTADO_NAO_CONTRIBUINTE_TRIBUTAR_ALIQUOTA_INTERNA_ESTADO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ISENCAO_ICMS_VENDAS_ZONA_FRANCA_SOMENTE_PARA_PRODUTOS_NACIONAIS, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_MODELO_CALCULO_SUBST_OPERACOES_PROPRIAS, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_INDUSTRIALIZACAO_OU_REVENDA, '1');

end;

Initialization
  RegisterTest(TestControllerFatImpostosFcpDifal.Suite);
end.
