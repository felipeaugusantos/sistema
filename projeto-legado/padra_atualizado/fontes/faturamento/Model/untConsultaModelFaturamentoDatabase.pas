unit untConsultaModelFaturamentoDatabase;

interface

uses untConsultaModelFaturamento, Faturamento.Impostos.Interfaces.Model, Shared.Functions.Core,
     Shared.Functions.DataSet, Shared.Functions.Types, Shared.Functions.Interfaces,
     Shared.Functions.Configuracoes, untTypesIPI, untTypesGenericosImpostos;

type
  TConsultaModelFaturamentoDatabase = class(TInterfacedObject, IConsultaModelFaturamento)
  private
    FCore: IFunctionsCore;
    FConfiguracoes: IConfiguracoes;
    FConnection: IMyConnection;
    function RetornarCampoCLI_SIBICM(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_CEDESP(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_CEDNAC(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_CEDSIM(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_ICMREI(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_IVASIM(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_ORPUDF(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCli_RECALI(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoITEGER_ITE_INDREV(const AGerandoCasosTestes: boolean): string;
    function CodigoDaAbreviacaoFiscal(const AResultadoCampoTabela: IMyCampoTabela; const ACodigoDaEmpresa, ACodigoDaEmpresaTE: String): String;
    function ImportacaoDiretaDoItem(const AResultadoCampoTabela: IMyCampoTabela): String;
    function DefinirCodigoDoFornecedorDoItem(const ACodigoDoFornecedorDoCadastro, ACodigoDoFornecedor: String): String;
    function RetornaTipoDoFornecedorDaUltimaNotaDeCompra(ACodigoDoFornecedorDaUltimaCompra: String): String;
    function RetornaFornecedorDaUltimaNotaDeCompra(ACodigoDoProduto, ACodigoDaEmpresa: String) : String;
    function IndustrializacaoOuRevenda(const AResultadoCampoTabela: IMyCampoTabela): TOpcIndustrializacaoOuRevenda;
    function UtilizaFornecedorDaUltimaNotaDeCompra: Boolean;
    function RetornarListaFornecedorFilial : String;
    function RetornarUltimaNotaItem(Const ACodigoDoItem : String; Const ADadosUltimasNotas : IMyQuery) : IResultadoDecodificaChaveNota;
  public
    function ConsultarFornecedor(const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ConsultarCliente(const ACodigoDoCliente: String; const ASequencialEnderecoEntrega : String; const AGerandoCasosTestes: boolean; const AClienteConsumidorFinal: boolean;
      AParametrosClienteConsumidor : TFaturamentoImpostosClienteConsumidor; const ACodigoDaFazenda: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ConsultarProduto(const ACodigoDoProduto: String; const ACodigoDaEmpresa: String; const ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
      const AGerandoCasosTestes: Boolean; const ACodigoDaEmpresaAbf: String = ''): IResultadoFaturamentoImpostosModelProduto;
    function ConsultarEmpresa(const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;
    constructor Create(ACore: IFunctionsCore; AConfiguracoes: IConfiguracoes; AConnection: IMyConnection);
  End;

implementation

uses Faturamento.Impostos.Tipos.Model, Shared.Functions.Funcoes.Faturamento, System.StrUtils, System.SysUtils,
  Shared.Functions.SQL, Shared.Functions.Tipos, untFaturamentoImpostosFuncoes;

{ TImplConsultaModel }

function TConsultaModelFaturamentoDatabase.ConsultarCliente(const ACodigoDoCliente: String;
  const ASequencialEnderecoEntrega : String; const AGerandoCasosTestes: boolean; const AClienteConsumidorFinal: boolean;
  AParametrosClienteConsumidor : TFaturamentoImpostosClienteConsumidor; const ACodigoDaFazenda: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
var
  LSituacaoDoIpi          : String;
  LZonaFranca             : Boolean;
  LOrgaoPublico           : Boolean;
  LClienteExterior        : Boolean;
  LZonaFrancaDesEsp       : Boolean;
  LClienteEstado          : String;
  FClienteEstadoEntrega   : String;
  LClienteAtividade       : String;
  LClienteRegraFiscal     : String;
  LSomarIpiBaseIcms       : Boolean;
  LClienteInscricao       : String;
  LMicroEmpreendedor      : Boolean;

  LValorIVAEspecialClienteMT : Double;
  LValorIVASimClienteMT      : Double;
  LValorIVANacClienteMT      : Double;

  LCalcularDescontoIcmsOrgaoPublico: Boolean;
  LSujeitoPassivoSTRegimeEspecial  : Boolean;
  LReducaoDeBaseDeIcmsTributados   : Double;
  LUtilizarDiferimetoST            : Boolean;
  LTipoDeDescontoRateioDescEspecial: String;

  LClienteZonaFrancaComDescontoEspecial: Boolean;
  LAplicarDescontoPisCofinsOrgaoPublico: Boolean;
  LBeneficioREIDI: Boolean;
  LDeduzirIcmsDoBeneficioREIDI: Boolean;

  LRetornoCampoTabela: IMyCampoTabela;
  LRetornoCampoTabelaEnderecoDeEntrega: IMyCampoTabela;

  LValorAliquotaIRF : Double;
  LValorAliquotaPIS : Double;
  LValorAliquotaCOF : Double;
  LValorAliquotaCSL : Double;

  LRetencaoDeIRPF : String;
  LRetencaoDePisCofins : String;

  LClienteC_G_C_ : String;
  LClienteFisJur : String;

  LClienteProdutorRural: String;
  LClienteNaoContribuinteDeIcms: String;

  LClienteOrgaoPublicoDifal: Boolean;

  LValorIVAEspecialClienteMTCedem: Double;
  LValorIVASimClienteMTCedem: Double;
  LValorIVANacClienteMTCedem: Double;
  LCodigoDaEmpresaTransferencia : String;
  LAtoDeclaratorioDF: Boolean;
  LClienteReducaoCargaLiquida: Boolean;
  LSuframa: String;
  LClienteIbgeEntrega: String;
  LOrgaoPublicoForaDoEstado: Boolean;
begin

  LRetornoCampoTabela :=
    FCore.fCampoTabela(['CLI_SITIPI', 'CLI_ZONFRA', 'CLI_CODATI', 'CLI_REGFIS',
                          'CLI_ORGPUB', 'CID_ESTADO AS CLI_ESTADO', 'CLI_CONSUM', RetornarCampoCLI_SIBICM(AGerandoCasosTestes),
                          'CLI_I_E_S_', 'CLI_MICEMP', 'CLI_IVAESP', RetornarCampoCLI_IVASIM(AGerandoCasosTestes),
                          'CLI_CALICM', 'CLI_STREES', 'CLI_REDICM', 'CLI_DIF_ST', RetornarCampoCLI_ICMREI(AGerandoCasosTestes),
                          'CLI_ORPURD', 'CLI_IVANAC', 'CLI_DESPIS', 'CLI_BENREI',
                          'CLI_ALQIRF','CLI_ALQPIS','CLI_ALQCOF','CLI_ALQCSL',
                          'CLI_RETIRF', 'CLI_RETPCO', 'CLI_C_G_C_', 'CLI_CGCCPF', 'CLI_PRORUR',
                          'CLI_IESUNI', 'CLI_ATODDF', 'CLI_DESZON', 'CLI_SUFRAM', RetornarCampoCLI_ORPUDF(AGerandoCasosTestes),
                          RetornarCampoCLI_CEDESP(AGerandoCasosTestes),
                          RetornarCampoCLI_CEDSIM(AGerandoCasosTestes),
                          RetornarCampoCLI_CEDNAC(AGerandoCasosTestes),
                          RetornarCampoCli_RECALI(AGerandoCasosTestes),
                          'CLI_NOMCLI'],

      'CADCLI LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID', ['CLI_CODCLI'], [ACodigoDoCliente], False);

  If ACodigoDaFazenda.IsEmpty Then
    LRetornoCampoTabelaEnderecoDeEntrega :=
      FCore.fCampoTabela(['CID_ESTADO AS ENT_ESTADO','CID_COIBGE AS ENT_COIBGE'],
        'ENTCLI INNER JOIN CADCID ON CID_CODCID = ETC_CIDENT ', ['ENTCLI.AUTOINCREM'], [ASequencialEnderecoEntrega], False)
  Else
    LRetornoCampoTabelaEnderecoDeEntrega :=
      FCore.fCampoTabela(['CID_ESTADO AS ENT_ESTADO','CID_COIBGE AS ENT_COIBGE'],
        'CADFAZ INNER JOIN CADCID ON CID_CODCID = FAZ_CODCID ', ['FAZ_CODCLI','FAZ_CODFAZ'], [ACodigoDoCliente, ACodigoDaFazenda], False);

  LSituacaoDoIpi      := LRetornoCampoTabela.FieldByName('CLI_SITIPI');
  LZonaFranca         := LRetornoCampoTabela.FieldByName('CLI_ZONFRA');
  LZonaFrancaDesEsp   := LRetornoCampoTabela.FieldByName('CLI_DESZON');
  LOrgaoPublico       := LRetornoCampoTabela.FieldByName('CLI_ORGPUB');
  LSuframa            := LRetornoCampoTabela.FieldByName('CLI_SUFRAM');

  LClienteRegraFiscal := LRetornoCampoTabela.FieldByName('CLI_REGFIS');
  LMicroEmpreendedor  := LRetornoCampoTabela.FieldByName('CLI_MICEMP').AsString = 'S';

  LClienteC_G_C_ := LRetornoCampoTabela.FieldByName('CLI_C_G_C_');

  LValorAliquotaIRF   := LRetornoCampoTabela.FieldByName('CLI_ALQIRF').AsFloat;
  LValorAliquotaPIS   := LRetornoCampoTabela.FieldByName('CLI_ALQPIS').AsFloat;
  LValorAliquotaCOF   := LRetornoCampoTabela.FieldByName('CLI_ALQCOF').AsFloat;
  LValorAliquotaCSL   := LRetornoCampoTabela.FieldByName('CLI_ALQCSL').AsFloat;

  LRetencaoDeIRPF     := LRetornoCampoTabela.FieldByName('CLI_RETIRF').AsString;
  LRetencaoDePisCofins:= LRetornoCampoTabela.FieldByName('CLI_RETPCO').AsString;

  LValorIVAEspecialClienteMT        := LRetornoCampoTabela.FieldByName('CLI_IVAESP');
  LValorIVASimClienteMT             := LRetornoCampoTabela.FieldByName('CLI_IVASIM');
  LValorIVANacClienteMT             := LRetornoCampoTabela.FieldByName('CLI_IVANAC');

  LValorIVAEspecialClienteMTCedem   := LRetornoCampoTabela.FieldByName('CLI_CEDESP');
  LValorIVASimClienteMTCedem        := LRetornoCampoTabela.FieldByName('CLI_CEDSIM');
  LValorIVANacClienteMTCedem        := LRetornoCampoTabela.FieldByName('CLI_CEDNAC');


  FClienteEstadoEntrega := LRetornoCampoTabelaEnderecoDeEntrega.FieldByName('ENT_ESTADO');
  LClienteIbgeEntrega   := LRetornoCampoTabelaEnderecoDeEntrega.FieldByName('ENT_COIBGE');

  LSomarIpiBaseIcms     := LRetornoCampoTabela.FieldByName('CLI_SIBICM').AsString  = 'S';

  LSujeitoPassivoSTRegimeEspecial := LRetornoCampoTabela.FieldByName('CLI_STREES').AsString = 'S';
  LReducaoDeBaseDeIcmsTributados  := LRetornoCampoTabela.FieldByName('CLI_REDICM');
  LUtilizarDiferimetoST           := LRetornoCampoTabela.FieldByName('CLI_DIF_ST').AsString = 'S';

  LTipoDeDescontoRateioDescEspecial := LRetornoCampoTabela.FieldByName('CLI_ORPURD');

  LAplicarDescontoPisCofinsOrgaoPublico := LRetornoCampoTabela.FieldByName('CLI_DESPIS').AsString = 'S';
  LBeneficioREIDI := LRetornoCampoTabela.FieldByName('CLI_BENREI').AsString = 'S';
  LDeduzirIcmsDoBeneficioREIDI := LRetornoCampoTabela.FieldByName('CLI_ICMREI').AsString = 'S';

  LClienteInscricao                 := LRetornoCampoTabela.FieldByName('CLI_I_E_S_');
  LClienteEstado                    := LRetornoCampoTabela.FieldByName('CLI_ESTADO');
  LClienteAtividade                 := LRetornoCampoTabela.FieldByName('CLI_CODATI');
  LCalcularDescontoIcmsOrgaoPublico := LRetornoCampoTabela.FieldByName('CLI_CALICM');

  LClienteFisJur :=
    TFunctionFuncoesFaturamento
      .RetornarClienteFisicoOuJuridico(LRetornoCampoTabela.FieldByName('CLI_CGCCPF').AsInteger);

  LClienteProdutorRural := LRetornoCampoTabela.FieldByName('CLI_PRORUR').AsString;
  LClienteNaoContribuinteDeIcms := LRetornoCampoTabela.FieldByName('CLI_IESUNI').AsString;
  LClienteOrgaoPublicoDifal := LRetornoCampoTabela.FieldByName('CLI_ORPUDF').AsString = 'S';

  If (TFaturamentoImpostosFuncoes.fClienteConsumidor(LRetornoCampoTabela.FieldByName('CLI_NOMCLI').AsString, False, True)) Then
  Begin
    LClienteInscricao                 := AParametrosClienteConsumidor.ClienteInscricaoEstadual;
    LClienteEstado                    := AParametrosClienteConsumidor.ClienteEstado;
    LClienteAtividade                 := AParametrosClienteConsumidor.ClienteAtividade;
    LCalcularDescontoIcmsOrgaoPublico := AParametrosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico;
    LClienteFisJur                    := AParametrosClienteConsumidor.ClienteFisicoOuJuridico;
    LCodigoDaEmpresaTransferencia     := AParametrosClienteConsumidor.CodigoDaEmpresaTransferencia;
  End;

  LClienteZonaFrancaComDescontoEspecial := (LZonaFranca And LZonaFrancaDesEsp);

  If LClienteZonaFrancaComDescontoEspecial Then
    LZonaFranca := False;

  LClienteExterior := LClienteEstado = 'EX';
  LAtoDeclaratorioDF := LRetornoCampoTabela.FieldByName('CLI_ATODDF').AsString = 'S';
  LClienteReducaoCargaLiquida := LRetornoCampoTabela.FieldByName('CLI_RECALI').AsString = 'S';
  LOrgaoPublicoForaDoEstado := LRetornoCampoTabela.FieldByName('CLI_ORGFDE').AsString = 'S';

  If not ACodigoDaFazenda.IsEmpty Then
    LClienteEstado := FClienteEstadoEntrega;

  Result :=
    TResultadoFaturamentoImpostosModelClienteFornecedor.New
      .Codigo(ACodigoDoCliente)
      .SituacaoDoIpi(LSituacaoDoIpi)
      .ZonaFranca(LZonaFranca)
      .OrgaoPublico(LOrgaoPublico)
      .OrgaoPublicoForaDoEstado(LOrgaoPublicoForaDoEstado)
      .ClienteExterior(LClienteExterior)
      .ClienteEstado(LClienteEstado)
      .ClienteEstadoEntrega(FClienteEstadoEntrega)
      .ClienteAtividade(LClienteAtividade)
      .ClienteRegraFiscal(LClienteRegraFiscal)
      .SomarIpiBaseIcms(LSomarIpiBaseIcms)
      .ClienteInscricaoEstadual(LClienteInscricao)
      .ClienteMicroEmpreendedor(LMicroEmpreendedor)
      .ValorIVAEspecialClienteMT(LValorIVAEspecialClienteMT)
      .ValorIVASimClienteMT(LValorIVASimClienteMT)
      .CalcularDescontoIcmsOrgaoPublico(LCalcularDescontoIcmsOrgaoPublico)
      .SujeitoPassivoSTRegimeEspecial(LSujeitoPassivoSTRegimeEspecial)
      .ReducaoDeBaseDeIcmsTributados(LReducaoDeBaseDeIcmsTributados)
      .UtilizarDiferimetoST(LUtilizarDiferimetoST)
      .TipoDeDescontoRateioDescEspecial(LTipoDeDescontoRateioDescEspecial)
      .ValorIVANacClienteMT(LValorIVANacClienteMT)
      .AplicarDescontoPisCofinsOrgaoPublico(LAplicarDescontoPisCofinsOrgaoPublico)
      .BeneficioREIDI(LBeneficioREIDI)
      .DeduzirIcmsDoBeneficioREIDI(LDeduzirIcmsDoBeneficioREIDI)
      .ValorAliquotaIRF(LValorAliquotaIRF)
      .ValorAliquotaPIS(LValorAliquotaPIS)
      .ValorAliquotaCOF(LValorAliquotaCOF)
      .ValorAliquotaCSL(LValorAliquotaCSL)
      .RetencaoDeIRPF(LRetencaoDeIRPF)
      .RetencaoDePisCofins(LRetencaoDePisCofins)
      .ClienteC_G_C_(LClienteC_G_C_)
      .ClienteFisJur(LClienteFisJur)
      .ConsumidorFinal(AClienteConsumidorFinal)
      .ClienteProdutorRural(LClienteProdutorRural)
      .ClienteNaoContribuinteDeIcms(LClienteNaoContribuinteDeIcms)
      .ClienteOrgaoPublicoDifal(LClienteOrgaoPublicoDifal)
      .ValorIVAEspecialClienteMTCedem(LValorIVAEspecialClienteMTCedem)
      .ValorIVASimClienteMTCedem(LValorIVASimClienteMTCedem)
      .ValorIVANacClienteMTCedem(LValorIVANacClienteMTCedem)
      .CodigoDaEmpresaTransferencia(LCodigoDaEmpresaTransferencia)
      .AtoDeclaratorioDF(LAtoDeclaratorioDF)
      .ClienteZonaFrancaComDescontoEspecial(LClienteZonaFrancaComDescontoEspecial)
      .ClienteReducaoCargaLiquida(LClienteReducaoCargaLiquida)
      .Suframa(LSuframa)
      .ClienteIbgeEntrega(LClienteIbgeEntrega);
end;

function TConsultaModelFaturamentoDatabase.ConsultarEmpresa(
  const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;
var
  LEmpresaEstado: String;
  LEmpresaIbge: String;
  LRetornoCampoTabela: IMyCampoTabela;
begin
  LRetornoCampoTabela := FCore.fCampoTabela(['CID_ESTADO AS EMP_ESTADO','CID_COIBGE AS EMP_COIBGE'], 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID', ['EMP_CODEMP'], [ACodigoDaEmpresa], False);

  LEmpresaEstado := LRetornoCampoTabela.FieldByName('EMP_ESTADO');
  LEmpresaIbge   := LRetornoCampoTabela.FieldByName('EMP_COIBGE');

  Result :=
    TResultadoFaturamentoImpostosModelEmpresa.New
      .EmpresaEstado(LEmpresaEstado)
      .EmpresaIbge(LEmpresaIbge);
end;

function TConsultaModelFaturamentoDatabase.ConsultarFornecedor(
  const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
var
  LSituacaoDoIpi: String;
  LZonaFranca: Boolean;
  LOrgaoPublico: Boolean;
  LFornecedorExterior: Boolean;
  LFornecedorEstado: String;
  LInscricaoEstadual : String;
  LFornecedorFisJur  : String;

  LRetornoCampoTabela: IMyCampoTabela;

begin
  LRetornoCampoTabela :=
    FCore.fCampoTabela(['CID_ESTADO AS FOR_ESTADO', 'FOR_I_E_S_', 'FOR_CGCCPF'],
                         'CADFOR JOIN CADCID ON CID_CODCID = FOR_CODCID',
                         ['FOR_CODFOR'],
                         [ACodigoDoFornecedor],
                         False);


  LSituacaoDoIpi        := '';
  LZonaFranca           := False;
  LOrgaoPublico         := False;
  LFornecedorEstado     := LRetornoCampoTabela.FieldByName('FOR_ESTADO');
  LFornecedorExterior   := LFornecedorEstado = 'EX';

  LInscricaoEstadual       := LRetornoCampoTabela.FieldByName('FOR_I_E_S_');

  LFornecedorFisJur :=
    TFunctionFuncoesFaturamento
      .RetornarClienteFisicoOuJuridico(LRetornoCampoTabela.FieldByName('FOR_CGCCPF').AsInteger);

  Result :=
    TResultadoFaturamentoImpostosModelClienteFornecedor.New
      .Codigo(ACodigoDoFornecedor)
      .SituacaoDoIpi(LSituacaoDoIpi)
      .ZonaFranca(LZonaFranca)
      .OrgaoPublico(LOrgaoPublico)
      .ClienteExterior(LFornecedorExterior)
      .ClienteEstado(LFornecedorEstado)
      .ClienteEstadoEntrega('')
      .ClienteInscricaoEstadual(LInscricaoEstadual)
      .ClienteFisJur(LFornecedorFisJur)
      .ConsumidorFinal(False);
end;

function TConsultaModelFaturamentoDatabase.ConsultarProduto(const ACodigoDoProduto,
  ACodigoDaEmpresa, ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
  const AGerandoCasosTestes: Boolean;
  const ACodigoDaEmpresaAbf: String): IResultadoFaturamentoImpostosModelProduto;
var
  LResultadoCampoTabela: IMyCampoTabela;
  LCodigoDaAbreviacaoFiscal: String;
  LImportacaoDireta: String;
  LUtilizaAmpara: String;
  LCodigoDoFornecedor: String;
  LCodigoDoFornecedorDaUltimaCompra: String;
  LTipoDoFornecedorDaUltimaCompra: String;
  LIpiDeEntrada: Double;
  LFreteDeEntrada: Double;
  LIndustrializacaoOuRevenda: TOpcIndustrializacaoOuRevenda;
  LAtoDeclaratorioDF: Boolean;
begin
  LResultadoCampoTabela :=
    FCore.fCampoTabela(['ITE_IPISAI', 'ITE_ITECCR', 'I.ITE_CODABF AS ITEGER_CODABF', 'C.ITE_CODABF AS CADITE_CODABF',
                          'I.ITE_IMPDIR AS ITEGER_IMPDIR', 'C.ITE_IMPDIR AS CADITE_IMPDIR', 'C.ITE_UTIAMP',
                          'C.ITE_CODFOR', 'I.ITE_IPIENT', 'I.ITE_FREENT', 'I.ITE_ATODDF',
                          RetornarCampoITEGER_ITE_INDREV(AGerandoCasosTestes), 'C.ITE_INDREV AS CADITE_INDREV'],
                         'ITEGER I INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE',
                         ['I.ITE_CODITE', 'I.ITE_CODEMP'],
                         [ACodigoDoProduto, IfThen(ACodigoDaEmpresaAbf.IsEmpty, ACodigoDaEmpresa, ACodigoDaEmpresaAbf)], False);

  LCodigoDaAbreviacaoFiscal := CodigoDaAbreviacaoFiscal(LResultadoCampoTabela,
                                                        IfThen(ACodigoDaEmpresaAbf.IsEmpty, ACodigoDaEmpresa, ACodigoDaEmpresaAbf),
                                                        ACodigoDaEmpresaTE);
  LImportacaoDireta := ImportacaoDiretaDoItem(LResultadoCampoTabela);
  LUtilizaAmpara := LResultadoCampoTabela.FieldByName('ITE_UTIAMP').AsString;
  LCodigoDoFornecedor := DefinirCodigoDoFornecedorDoItem( LResultadoCampoTabela.FieldByName('ITE_CODFOR').AsString, ACodigoDoFornecedorDoItem);
  LIpiDeEntrada := LResultadoCampoTabela.FieldByName('ITE_IPIENT').AsFloat;
  LFreteDeEntrada := LResultadoCampoTabela.FieldByName('ITE_FREENT').AsFloat;

  LIndustrializacaoOuRevenda := IndustrializacaoOuRevenda(LResultadoCampoTabela);

  LCodigoDoFornecedorDaUltimaCompra := RetornaFornecedorDaUltimaNotaDeCompra(ACodigoDoProduto, ACodigoDaEmpresa);
  LTipoDoFornecedorDaUltimaCompra   := RetornaTipoDoFornecedorDaUltimaNotaDeCompra(LCodigoDoFornecedorDaUltimaCompra);
  LAtoDeclaratorioDF := LResultadoCampoTabela.FieldByName('ITE_ATODDF').AsString = 'S';

  Result :=
    TResultadoFaturamentoImpostosModelProduto.New
      .IpiDeSaida(LResultadoCampoTabela.FieldByName('ITE_IPISAI'))
      .ItemConcreto(LResultadoCampoTabela.FieldByName('ITE_ITECCR'))
      .CodigoDaAbreviacaoFiscal(LCodigoDaAbreviacaoFiscal)
      .ImportacaoDireta(LImportacaoDireta)
      .UtilizaAmpara(LUtilizaAmpara)
      .CodigoDoFornecedor(LCodigoDoFornecedor)
      .IpiDeEntrada(LIpiDeEntrada)
      .FreteDeEntrada(LFreteDeEntrada)
      .IndustrializacaoOuRevenda(LIndustrializacaoOuRevenda)
      .CodigoDoFornecedorDaUltimaCompra(LCodigoDoFornecedorDaUltimaCompra)
      .TipoDoFornecedorDaUltimaCompra(LTipoDoFornecedorDaUltimaCompra)
      .AtoDeclaratorioDF(LAtoDeclaratorioDF)
end;

constructor TConsultaModelFaturamentoDatabase.Create(ACore: IFunctionsCore; AConfiguracoes: IConfiguracoes; AConnection: IMyConnection);
begin
  FCore := ACore;
  FConfiguracoes := AConfiguracoes;
  FConnection := AConnection;
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCLI_SIBICM(const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_SIBICM';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_SIBICM') then
    result := '"S" AS CLI_SIBICM';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCLI_CEDESP(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_CEDESP';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_CEDESP') then
    result := '0.00 AS CLI_CEDESP';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCLI_CEDNAC(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_CEDNAC';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_CEDNAC') then
    result := '0.00 AS CLI_CEDNAC';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCLI_CEDSIM(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_CEDSIM';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_CEDSIM') then
    result := '0.00 AS CLI_CEDSIM';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCLI_ICMREI(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_ICMREI';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_ICMREI') then
    result := '"N" AS CLI_ICMREI';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCLI_IVASIM(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_IVASIM';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_IVASIM') then
    result := '0 AS CLI_IVASIM';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCLI_ORPUDF(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_ORPUDF';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_ORPUDF') then
    result := '"N" AS CLI_ORPUDF';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoCli_RECALI(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_RECALI';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not FCore.fCampoExiste('CADCLI','CLI_RECALI') then
    result := '"N" AS CLI_RECALI';
end;

function TConsultaModelFaturamentoDatabase.RetornarCampoITEGER_ITE_INDREV(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'I.ITE_INDREV AS ITEGER_INDREV';

  if (not AGerandoCasosTestes) then
    Exit;

  if not FCore.fCampoExiste('ITEGER','ITE_INDREV') then
    result := '"" AS ITEGER_INDREV';
end;

function TConsultaModelFaturamentoDatabase.CodigoDaAbreviacaoFiscal(
  const AResultadoCampoTabela: IMyCampoTabela; const ACodigoDaEmpresa,
  ACodigoDaEmpresaTE: String): String;
begin
  If TFunctionFuncoesFaturamento.CadastroDeAbreviacaoFiscalIgualParaTodasAsEmpresas(ACodigoDaEmpresaTE, ACodigoDaEmpresa) Then
  Begin
    Result := AResultadoCampoTabela.FieldByName('CADITE_CODABF');
    Exit;
  End;

  Result := AResultadoCampoTabela.FieldByName('ITEGER_CODABF');
end;

function TConsultaModelFaturamentoDatabase.ImportacaoDiretaDoItem(
  const AResultadoCampoTabela: IMyCampoTabela): String;
begin
  Result :=
    TFunctionFuncoesFaturamento.ImportacaoDiretaDoItem(AResultadoCampoTabela.FieldByName('CADITE_IMPDIR'), AResultadoCampoTabela.FieldByName('ITEGER_IMPDIR'));
end;

function TConsultaModelFaturamentoDatabase.DefinirCodigoDoFornecedorDoItem(const ACodigoDoFornecedorDoCadastro, ACodigoDoFornecedor: String): String;
begin
  Result := ACodigoDoFornecedor;

  If not FCore.fEmptyStr(Result)  Then
    Exit;

  Result := ACodigoDoFornecedorDoCadastro;
end;

function TConsultaModelFaturamentoDatabase.IndustrializacaoOuRevenda(
  const AResultadoCampoTabela: IMyCampoTabela): TOpcIndustrializacaoOuRevenda;
var
  LIndustrializacaoOuRevenda: String;
begin
  LIndustrializacaoOuRevenda :=
    TFunctionFuncoesFaturamento
      .fItemRevInd(AResultadoCampoTabela.FieldByName('CADITE_INDREV').AsString,
                   AResultadoCampoTabela.FieldByName('ITEGER_INDREV').AsString);

  Result := OpcRevenda;

  Case AnsiIndexStr(UpperCase(LIndustrializacaoOuRevenda), ['I', 'R']) Of
    0 : Result := OpcIndustrializacao;
    1 : Result := OpcRevenda;
  End;
end;

function TConsultaModelFaturamentoDatabase.RetornaFornecedorDaUltimaNotaDeCompra(ACodigoDoProduto, ACodigoDaEmpresa: String) : String;
Var
  FDadosUltNotas: IMyQuery;
  LResultadoUltimaNota : IResultadoDecodificaChaveNota;
begin
  Result := '';

  If UtilizaFornecedorDaUltimaNotaDeCompra Then
  Begin
    FDadosUltNotas := FConnection.CreateQuery;
    FDadosUltNotas.SQL.Text :=
      TFunctionsSQL.GetSQLUltimasNotas(ACodigoDoProduto,
                                       RetornarListaFornecedorFilial,
                                       ACodigoDaEmpresa);

    LResultadoUltimaNota := RetornarUltimaNotaItem(ACodigoDoProduto, FDadosUltNotas);

    If Assigned(LResultadoUltimaNota) Then
      Result := LResultadoUltimaNota.CodigoDoFornecedor;
  End;
end;

function TConsultaModelFaturamentoDatabase.RetornaTipoDoFornecedorDaUltimaNotaDeCompra(ACodigoDoFornecedorDaUltimaCompra: String): String;
var
  LResultadoCampoTabela: IMyCampoTabela;
begin
  Result := '';

  If UtilizaFornecedorDaUltimaNotaDeCompra Then
  Begin
    LResultadoCampoTabela :=  FCore.fCampoTabela(['FOR_MATREV'],'CADFOR',['FOR_CODFOR'],[ACodigoDoFornecedorDaUltimaCompra], False);
    Result := LResultadoCampoTabela.FieldByName('FOR_MATREV').AsString;
  End;
end;

function TConsultaModelFaturamentoDatabase.UtilizaFornecedorDaUltimaNotaDeCompra: Boolean;
begin
  Result := False;

  If not FConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_DECRETO_REDUCAO_BASE_IMPOSTOS, varBoolean) Then
    Exit;

  If FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA) <> '2' Then
    Exit;

  If FConfiguracoes.fGetValorConfiguracao(CFG_MODELO_DE_CALCULO_DECRETO_REDUCAO_BASE_IMPOSTOS) <> '2' Then
    Exit;

  Result := True;
end;

function TConsultaModelFaturamentoDatabase.RetornarListaFornecedorFilial : String;
var
  LRetornoForncedorFilial : IMyCampoTabela;
begin
  LRetornoForncedorFilial :=
    FCore.fCampoTabelaDados(TFunctionFuncoesFaturamento.GetSelectFornecedorFilial, [], []);

  Result :=
    TFunctionFuncoesFaturamento.
      RetornarListaDeFornecedorFilial(LRetornoForncedorFilial.Fields(0).AsString, true);
end;

function TConsultaModelFaturamentoDatabase.RetornarUltimaNotaItem(Const ACodigoDoItem : String; Const ADadosUltimasNotas : IMyQuery) : IResultadoDecodificaChaveNota;
Var
  LParametrosDecodificacao : IParametrosDecodificaChaveNota;
Begin
  result := Nil;

  ADadosUltimasNotas.Open;

  If not FCore.fEmptyStr(ADadosUltimasNotas.FieldByName('ITE_NOTULT').AsString) Then
  Begin
    LParametrosDecodificacao :=
        TParametrosDecodificaChaveNota.New
          .Chave(ADadosUltimasNotas.FieldByName('ITE_NOTULT').AsString)
          .TamanhoCampoDocumento( FCore.RetornarTamanhoDoCampoNumeroDoDocumento);

    result := TFunctionFuncoesFaturamento.DecodificaChaveNota(LParametrosDecodificacao);
  End;

end;

end.
