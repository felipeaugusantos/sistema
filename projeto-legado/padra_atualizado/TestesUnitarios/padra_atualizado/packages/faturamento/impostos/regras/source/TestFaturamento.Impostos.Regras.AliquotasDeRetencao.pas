unit TestFaturamento.Impostos.Regras.AliquotasDeRetencao;

interface

uses
  TestFramework,
  Faturamento.Impostos.Interfaces.AliquotasDeRetencao,
  Faturamento.Impostos.Tipos.AliquotasDeRetencao,
  Faturamento.Impostos.regras.AliquotasDeRetencao,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Model.Cliente,
  untTestObjMyCampoTabela,
  Shared.Functions.Core,
  Shared.Functions.Configuracoes,
  Shared.Functions.DataSet,
  Math;

type

  TestRegrasAliquotasRetencao  = class(TTestCase)
  strict private
    Procedure ModelCliente;
  private
    FModelCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;


    FParametros : IParametrosAliquotasDeRetencao;

    Procedure SetarParametros;


    procedure SetarConfiguracoesAliquotasProduto;
    procedure SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
    procedure SetarConfiguracoesAliquotasServicosOrgaoPublico;
    procedure SetarConfiguracoesValorMinimoRetencao;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    Procedure TestAliquotasRetencaoPessoaFisicaSemRetencaoIrfEPisCofins;
    Procedure TestAliquotasRetencaoPessoaJuridicaSemRetencaoIrfEPisCofins;
    Procedure TestAliquotasRetencaoPessoaJuridicaCarregaAliquotasCliente;
    Procedure TestAliquotasRetencaoPessoaJuridicaRetencaoIRFNao;
    Procedure TestAliquotasRetencaoPessoaJuridicaRetencaoPisCofinsNao;
    Procedure TestAliquotasRetencaoPessoaJuridicaOrgaoPublicoNao;
    Procedure TestAliquotasRetencaoPessoaJuridicaOrgaoPublicoNaoRetencaoIRFNao;
    Procedure TestAliquotasRetencaoPessoaJuridicaOrgaoPublicoNaoRetencaoPisCofinsNao;
    Procedure TestAliquotasRetencaoPessoaJuridicaCadastroDeClientesValoresZerado;
    Procedure TestAliquotasRetencaoCadastroDeClientesValoresZeradoUtilizandoMetodoCarregarModelCliente;

  end;

implementation

procedure TestRegrasAliquotasRetencao.ModelCliente;
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

  objMyCampoTabelaAdd.Add('ENT_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('ENT_COIBGE', '3543402');
  objMyCampoTabelaAdd.Add('CLI_DESPIS','S');

  objMyCampoTabelaAdd.Add('CLI_SIBICM', 'N');
  objMyCampoTabelaAdd.Add('CLI_STREES', 'N');
  objMyCampoTabelaAdd.Add('CLI_REDICM', 0);
  objMyCampoTabelaAdd.Add('CLI_DIF_ST', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPURD', 'N');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415');

  objMyCampoTabelaAdd.Add('CLI_ALQIRF',10);
  objMyCampoTabelaAdd.Add('CLI_ALQPIS',10);
  objMyCampoTabelaAdd.Add('CLI_ALQCOF',10);
  objMyCampoTabelaAdd.Add('CLI_ALQCSL',10);


  objMyCampoTabelaAdd.Add('CLI_RETPCO','N');
  objMyCampoTabelaAdd.Add('CLI_RETIRF','N');

  objMyCampoTabelaAdd.Add('CLI_BENREI','N');
  objMyCampoTabelaAdd.Add('CLI_ICMREI','N');


end;

procedure TestRegrasAliquotasRetencao.SetarConfiguracoesAliquotasProduto;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PRODUTO_ALIQUOTA_COFINS,'7,6');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PRODUTO_ALIQUOTA_CSLL,'1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PRODUTO_ALIQUOTA_IRPJ,'1,2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PRODUTO_ALIQUOTA_PIS,'1,65');
End;

procedure TestRegrasAliquotasRetencao.SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_COFINS,'7,6');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_CSLL,'0');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_IRPJ,'0');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_PIS,'1,65');
end;

procedure TestRegrasAliquotasRetencao.SetarConfiguracoesAliquotasServicosOrgaoPublico;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_COFINS,'7,6');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_CSLL,'1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_IRPJ,'4,8');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_ORGAO_PUBLICO_ALIQUOTA_PIS,'1,65');
End;

procedure TestRegrasAliquotasRetencao.SetarConfiguracoesValorMinimoRetencao;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VALOR_MINIMO_RETENCAO_IRPJ,'1');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VALOR_MINIMO_RETENCAO_PIS_COFINS_CSLL,'1');
end;

procedure TestRegrasAliquotasRetencao.SetarParametros;
Var
  ACodigoDoCliente,
  ASequencialEnderecoEntrega : String;
begin
  FModelCliente :=
    TFaturamentoImpostosModelCliente.New
      .Consultar(ACodigoDoCliente,ASequencialEnderecoEntrega, false, False);

  FParametros := TParametrosAliquotasDeRetencao.New.CodigoDoCliente('10320');
end;

procedure TestRegrasAliquotasRetencao.SetUp;
begin

end;

procedure TestRegrasAliquotasRetencao.TearDown;
begin

end;


procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoCadastroDeClientesValoresZeradoUtilizandoMetodoCarregarModelCliente;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','S');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','S');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','S');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');

  objMyCampoTabelaAdd.Add('CLI_ALQIRF',0);
  objMyCampoTabelaAdd.Add('CLI_ALQPIS',0);
  objMyCampoTabelaAdd.Add('CLI_ALQCOF',0);
  objMyCampoTabelaAdd.Add('CLI_ALQCSL',0);


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_IRPJ,'10');

  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := CarregarAliquotasRetencao(FParametros);

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('4,8')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('1,65')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('7,6')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('1')) And

    (ReturnValue.AliquotaProdutoIRPJ   = objCore.fStrToFloat('1,2')) And
    (ReturnValue.AliquotaProdutoPIS    = objCore.fStrToFloat('1,65')) And
    (ReturnValue.AliquotaProdutoCOFINS = objCore.fStrToFloat('7,6')) And
    (ReturnValue.AliquotaProdutoCSLL   = objCore.fStrToFloat('1')) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));

end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaFisicaSemRetencaoIrfEPisCofins;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = 0) And
    (ReturnValue.AliquotaPIS    = 0) And
    (ReturnValue.AliquotaCOFINS = 0) And
    (ReturnValue.AliquotaCSLL   = 0) And

    (ReturnValue.AliquotaProdutoIRPJ   = 0) And
    (ReturnValue.AliquotaProdutoPIS    = 0) And
    (ReturnValue.AliquotaProdutoCOFINS = 0) And
    (ReturnValue.AliquotaProdutoCSLL   = 0) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = 0) And
    (ReturnValue.ValorMinimoRetencaoIRPJ = 0));
end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaCadastroDeClientesValoresZerado;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','S');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','S');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','S');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');

  objMyCampoTabelaAdd.Add('CLI_ALQIRF',0);
  objMyCampoTabelaAdd.Add('CLI_ALQPIS',0);
  objMyCampoTabelaAdd.Add('CLI_ALQCOF',0);
  objMyCampoTabelaAdd.Add('CLI_ALQCSL',0);


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_IRPJ,'10');

  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('4,8')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('1,65')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('7,6')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('1')) And

    (ReturnValue.AliquotaProdutoIRPJ   = objCore.fStrToFloat('1,2')) And
    (ReturnValue.AliquotaProdutoPIS    = objCore.fStrToFloat('1,65')) And
    (ReturnValue.AliquotaProdutoCOFINS = objCore.fStrToFloat('7,6')) And
    (ReturnValue.AliquotaProdutoCSLL   = objCore.fStrToFloat('1')) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));

end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaCarregaAliquotasCliente;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','S');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','S');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','S');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('10')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('10')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('10')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('10')) And

    (ReturnValue.AliquotaProdutoIRPJ   = IfThen(objMyCampoTabela.FieldByName('CLI_ALQIRF').AsFloat<=0, objCore.fStrToFloat('1,2'),  ReturnValue.AliquotaIRPJ)) And
    (ReturnValue.AliquotaProdutoPIS    = IfThen(objMyCampoTabela.FieldByName('CLI_ALQPIS').AsFloat<=0, objCore.fStrToFloat('1,65'), ReturnValue.AliquotaPIS)) And
    (ReturnValue.AliquotaProdutoCOFINS = IfThen(objMyCampoTabela.FieldByName('CLI_ALQCOF').AsFloat<=0, objCore.fStrToFloat('7,6'),  ReturnValue.AliquotaCOFINS)) And
    (ReturnValue.AliquotaProdutoCSLL   = IfThen(objMyCampoTabela.FieldByName('CLI_ALQCSL').AsFloat<=0, objCore.fStrToFloat('1'),    ReturnValue.AliquotaCSLL)) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));

end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaOrgaoPublicoNao;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','S');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','S');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','N');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('1,65')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('7,6')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('0')) And

    (ReturnValue.AliquotaProdutoIRPJ   = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoPIS    = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoCOFINS = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoCSLL   = objCore.fStrToFloat('0')) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));

end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaOrgaoPublicoNaoRetencaoIRFNao;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','S');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','N');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','N');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_IRPJ,'10');

  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('1,65')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('7,6')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('0')) And

    (ReturnValue.AliquotaProdutoIRPJ   = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoPIS    = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoCOFINS = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoCSLL   = objCore.fStrToFloat('0')) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));
end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaOrgaoPublicoNaoRetencaoPisCofinsNao;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','N');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','S');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','N');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_SERVICO_NAO_ORGAO_PUBLICO_ALIQUOTA_IRPJ,'10');

  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('10')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('0')) And

    (ReturnValue.AliquotaProdutoIRPJ   = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoPIS    = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoCOFINS = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaProdutoCSLL   = objCore.fStrToFloat('0')) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));
end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaRetencaoIRFNao;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','S');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','N');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','S');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('10')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('10')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('10')) And

    (ReturnValue.AliquotaProdutoIRPJ   = IfThen(objMyCampoTabela.FieldByName('CLI_ALQIRF').AsFloat<=0, objCore.fStrToFloat('0'),    ReturnValue.AliquotaIRPJ)) And
    (ReturnValue.AliquotaProdutoPIS    = IfThen(objMyCampoTabela.FieldByName('CLI_ALQPIS').AsFloat<=0, objCore.fStrToFloat('1,65'), ReturnValue.AliquotaPIS)) And
    (ReturnValue.AliquotaProdutoCOFINS = IfThen(objMyCampoTabela.FieldByName('CLI_ALQCOF').AsFloat<=0, objCore.fStrToFloat('7,6'),  ReturnValue.AliquotaCOFINS)) And
    (ReturnValue.AliquotaProdutoCSLL   = IfThen(objMyCampoTabela.FieldByName('CLI_ALQCSL').AsFloat<=0, objCore.fStrToFloat('1'),    ReturnValue.AliquotaCSLL)) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));
end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaRetencaoPisCofinsNao;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_RETPCO','N');

  objMyCampoTabelaAdd.Add('CLI_RETIRF','S');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB','S');

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');


  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = objCore.fStrToFloat('10')) And
    (ReturnValue.AliquotaPIS    = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaCOFINS = objCore.fStrToFloat('0')) And
    (ReturnValue.AliquotaCSLL   = objCore.fStrToFloat('0')) And

    (ReturnValue.AliquotaProdutoIRPJ   = IfThen(objMyCampoTabela.FieldByName('CLI_ALQIRF').AsFloat<=0, objCore.fStrToFloat('1,2'), ReturnValue.AliquotaIRPJ)) And
    (ReturnValue.AliquotaProdutoPIS    = IfThen(objMyCampoTabela.FieldByName('CLI_ALQPIS').AsFloat<=0, objCore.fStrToFloat('0'),   ReturnValue.AliquotaPIS)) And
    (ReturnValue.AliquotaProdutoCOFINS = IfThen(objMyCampoTabela.FieldByName('CLI_ALQCOF').AsFloat<=0, objCore.fStrToFloat('0'),   ReturnValue.AliquotaCOFINS)) And
    (ReturnValue.AliquotaProdutoCSLL   = IfThen(objMyCampoTabela.FieldByName('CLI_ALQCSL').AsFloat<=0, objCore.fStrToFloat('0'),   ReturnValue.AliquotaCSLL)) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = objCore.fStrToFloat('1')) And
    (ReturnValue.ValorMinimoRetencaoIRPJ          = objCore.fStrToFloat('1')));
end;

procedure TestRegrasAliquotasRetencao.TestAliquotasRetencaoPessoaJuridicaSemRetencaoIrfEPisCofins;
Var
  ReturnValue : IResultadoAliquotasDeRetencao;
begin
  ModelCliente;

  objMyCampoTabelaAdd.Add('CLI_C_G_C_','35035485415111111111');

  SetarConfiguracoesAliquotasProduto;
  SetarConfiguracoesAliquotasServicosNaoOrgaoPublico;
  SetarConfiguracoesAliquotasServicosOrgaoPublico;
  SetarConfiguracoesValorMinimoRetencao;
  SetarParametros;

  ReturnValue := TRegrasAliquotasDeRetencao.New(FParametros)
                  .UtilizarModelCliente(FModelCliente)
                    .CarregarAliquotasRetencao;

  CheckTrue(
    (ReturnValue.AliquotaIRPJ   = 0) And
    (ReturnValue.AliquotaPIS    = 0) And
    (ReturnValue.AliquotaCOFINS = 0) And
    (ReturnValue.AliquotaCSLL   = 0) And

    (ReturnValue.AliquotaProdutoIRPJ   = 0) And
    (ReturnValue.AliquotaProdutoPIS    = 0) And
    (ReturnValue.AliquotaProdutoCOFINS = 0) And
    (ReturnValue.AliquotaProdutoCSLL   = 0) And

    (ReturnValue.ValorMinimoRetencaoPisCofinsCsll = 0) And
    (ReturnValue.ValorMinimoRetencaoIRPJ = 0));

end;

initialization
  RegisterTest(TestRegrasAliquotasRetencao.Suite);
end.

