unit TestFaturamento.Impostos.Regras.DadosFiscais.Aliquota;

interface

uses
  TestFramework,
  Shared.Functions.Configuracoes,
  Shared.Functions.Constantes,
  Faturamento.Impostos.Regras.DadosFiscais.Aliquota,
  Faturamento.Impostos.Tipos.DadosFiscais.Aliquota,
  Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota;

type
  // Test methods for class TClassificaoUsoEConsumo

  TestTDadosFiscaisAliquota = class(TTestCase)
  strict private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDadosFiscaisAliquotaDentroDoEstadoCFOP;
    procedure TestDadosFiscaisAliquotaDentroDoEstadoCFOPRioGrandeDoSul;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteSulOuSudente;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBAhia;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteAlagoas;

    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBahiaAtividadeConstrutora;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBahiaSemInscricaoEstadual;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBahiaAtividadeConstrutoraSemInscricaoEstadualEMicroempreendedor;

    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteRioGrandeDoSulAtividadeConstrutora;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteRioGrandeDoSulSemInscricaoEstadual;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteRioGrandeDoSulAtividadeConstrutoraSemInscricaoEstadualEMicroempreendedor;

    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalDocumentoDeVenda;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalSantaCatarina;

    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalZearAliquotaGravacaoCupom;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalZearAliquotaGravacaoNotaFiscal;

    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalGravacaoCupomEspeciePedido;

    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalAlagoasGravacaoNota;
    procedure TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalExteriorGravacaoCupom;

  end;

implementation

procedure TestTDadosFiscaisAliquota.SetUp;
begin


end;

procedure TestTDadosFiscaisAliquota.TearDown;
begin

end;


procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaDentroDoEstadoCFOP;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(SAO_PAULO)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(SAO_PAULO)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(true)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 18);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaDentroDoEstadoCFOPRioGrandeDoSul;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(RIO_GRANDE_DO_SUL)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(RIO_GRANDE_DO_SUL)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(true)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 17);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteAlagoas;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(ALAGOAS)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(ALAGOAS)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 12);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBahia;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(BAHIA)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(BAHIA)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 7);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBahiaAtividadeConstrutora;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(BAHIA)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(BAHIA)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(true)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 18);


end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBahiaAtividadeConstrutoraSemInscricaoEstadualEMicroempreendedor;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(BAHIA)
       .InscricaoEstadual('123456789')
       .MicroEmpreendedor(True)
       .EmpresaEstado(BAHIA)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(True)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 18);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteBahiaSemInscricaoEstadual;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(BAHIA)
       .InscricaoEstadual('')
       .MicroEmpreendedor(false)
       .EmpresaEstado(BAHIA)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 18);

end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteRioGrandeDoSulAtividadeConstrutora;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(RIO_GRANDE_DO_SUL)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(RIO_GRANDE_DO_SUL)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(true)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 17);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteRioGrandeDoSulAtividadeConstrutoraSemInscricaoEstadualEMicroempreendedor;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(RIO_GRANDE_DO_SUL)
       .InscricaoEstadual('123456789')
       .MicroEmpreendedor(True)
       .EmpresaEstado(RIO_GRANDE_DO_SUL)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(True)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 17);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteRioGrandeDoSulSemInscricaoEstadual;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(RIO_GRANDE_DO_SUL)
       .InscricaoEstadual('')
       .MicroEmpreendedor(false)
       .EmpresaEstado(RIO_GRANDE_DO_SUL)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 17);

end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPClienteSulOuSudente;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(SANTA_CATARINA)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(SANTA_CATARINA)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 12);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalDocumentoDeVenda;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '33');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(SANTA_CATARINA)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(SANTA_CATARINA)
       .DocumentoDeVenda(true)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 33);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalGravacaoCupomEspeciePedido;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '33');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(SANTA_CATARINA)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(SANTA_CATARINA)
       .DocumentoDeVenda(true)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('PD');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 12);

end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalExteriorGravacaoCupom;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '33');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, 'S');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(EXTERIOR)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(EXTERIOR)
       .DocumentoDeVenda(False)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('IV');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 7);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalAlagoasGravacaoNota;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '33');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(ALAGOAS)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(ALAGOAS)
       .DocumentoDeVenda(False)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('PD');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 12);
end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalSantaCatarina;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '33');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(SANTA_CATARINA)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(SANTA_CATARINA)
       .DocumentoDeVenda(false)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('OU');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 12);



end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalZearAliquotaGravacaoCupom;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '33');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, 'N');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(ALAGOAS)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(SANTA_CATARINA)
       .DocumentoDeVenda(true)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('IF');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 0);

end;

procedure TestTDadosFiscaisAliquota.TestDadosFiscaisAliquotaForaDoEstadoCFOPSimplesNacionalZearAliquotaGravacaoNotaFiscal;
var
  ReturnValue: IResultadoDadosFiscaisAliquota;
  AParametros: IParametrosDadosFiscaisAliquota;
begin
  // TODO: Setup method call parameters

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '33');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, 'S');

  AParametros :=
     TParametrosDadosFiscaisAliquota.New
       .ClienteEstado(ALAGOAS)
       .InscricaoEstadual('123')
       .MicroEmpreendedor(false)
       .EmpresaEstado(SANTA_CATARINA)
       .DocumentoDeVenda(true)
       .DentroDoEstadoCFOP(false)
       .AtividadeConstrutora(false)
       .EspecieDocumento('PD');

  ReturnValue := DadosFiscaisAliquotaDoItem(AParametros);

  CheckTrue(ReturnValue.AliquotaIcm = 0);
end;

initialization
  RegisterTest(TestTDadosFiscaisAliquota.Suite);
end.

