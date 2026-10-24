unit Faturamento.Impostos.Servicos.Classe.IcmsSt;

interface

uses System.SysUtils,
     System.StrUtils,
     Faturamento.Impostos.Interfaces.Servicos.Classe.IcmsSt,
     Faturamento.Impostos.Interfaces.Icms,
     Faturamento.Impostos.Tipos.Icms,

     Faturamento.Impostos.Calculos.ST,
     Faturamento.Impostos.Interfaces.ST,
     Faturamento.Impostos.Tipos.ST,

     Faturamento.Impostos.Interfaces.IcmsSt,
     Faturamento.Impostos.Tipos.IcmsSt,

     Faturamento.Impostos.Calculos.Icms,
     Faturamento.Impostos.Interfaces.Model,
     Faturamento.Model.Cliente,
     Faturamento.Model.Fornecedor,
     Faturamento.Model.Empresa,
     Faturamento.Model.Produto,
     Shared.Functions.Core,

     Shared.Functions.Funcoes.Faturamento,
     Shared.Functions.Configuracoes,
     Shared.Functions.Constantes,
     Shared.Functions.DataSet,
     Shared.Functions.Types,

     Faturamento.Impostos.Servicos.Classe.Ipi,
     Faturamento.Impostos.Interfaces.Ipi,
     Faturamento.Impostos.Tipos.Ipi,

     Faturamento.Impostos.Regras.ZerarImpostos.Icms,
     Faturamento.Impostos.Interfaces.ZerarImpostos.Icms,
     Faturamento.Impostos.Tipos.ZerarImpostos.Icms,
     Faturamento.Impostos.Interfaces.ZerarImpostos.Types,

     Faturamento.Impostos.Tipos.Model,
     Faturamento.Model.AbreviacaoIcms,
     Faturamento.Impostos.Servicos.Funcoes,
     Faturamento.Impostos.Interfaces.Tributacao,
     Faturamento.Impostos.Tipos.Tributacao,
     Faturamento.Impostos.Regras.Tributacao.Factory,

     Shared.Functions.Utils,
     Shared.Functions.Interfaces,
     Shared.Functions.Tipos,

     Faturamento.Impostos.Tipos.ZerarImpostos.ST,
     Faturamento.Impostos.Regras.ZerarImpostos.ST,
     Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo,
     Faturamento.Impostos.Tipos.Tributacao.DepoisDoCalculo,
     Faturamento.Impostos.Regras.Tributacao.DepoisDoCalculo,

     Faturamento.Impostos.Interfaces.Servicos.Classe.Icms,
     Faturamento.Impostos.Tipos.Servicos.Classe.Icms,
     Faturamento.Impostos.Servicos.Classe.Icms,
     Faturamento.Impostos.Interfaces.Servicos.Classe.St,
     Faturamento.Impostos.Tipos.Servicos.Classe.St,
     Faturamento.Impostos.Servicos.Classe.St,
     Faturamento.Impostos.Interfaces.Servicos.Classe.IcmsOrgaoPublico,
     Faturamento.Impostos.Tipos.Servicos.Classe.IcmsOrgaoPublico,
     Faturamento.Impostos.Servicos.Classe.IcmsOrgaoPublico,

     Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,
     Faturamento.Impostos.Tipos.IcmsOrgaoPublico,

     Faturamento.Impostos.Interfaces.AliquotasDeRetencao,
     Faturamento.Impostos.Tipos.AliquotasDeRetencao,
     Faturamento.Impostos.Regras.AliquotasDeRetencao,

     Faturamento.Impostos.Interfaces.Servicos.Classe.StCustoAquisicao,
     Faturamento.Impostos.Tipos.Servicos.Classe.StCustoAquisicao,
     Faturamento.Impostos.Servicos.Classe.StCustoAquisicao,
     Faturamento.Impostos.Interfaces.StCustoAquisicao,
     Faturamento.Impostos.Tipos.StCustoAquisicao;

type
  TFaturamentoImpostosServicosClasseIcmsSt = class(TInterfacedObject, IFaturamentoImpostosServicosClasseIcmsSt)
  private
    FDocumentoParaFornecedor      : Boolean;
    FSubstituicaoTributariaDoItem : Boolean;
    FSimplesNacional              : Boolean;
    FClassificacaoDeVenda         : String;
    FTipoDeAbreviacaoFiscal       : String;

    FUtilizaAmpara: Boolean;
    FEncontrouAbfIcmAmpara: Boolean;
    FAmparaAliquotaFCP: Double;

    FParametros             : IParametrosServicoIcmsSt;
    FModelClienteFornecedor : IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelEmpresa           : IResultadoFaturamentoImpostosModelEmpresa;
    FModelProduto           : IResultadoFaturamentoImpostosModelProduto;
    FModelAbreviacaoIcms    : IResultadoFaturamentoImpostosModelAbreviacaoIcms;

    FResultadoTributacaoAntesDoCalculo: IResultadoRegrasTributacaoIcmsSt;
    FValorCalculadoIPI: Double;
    FValorCalculadoIpiEntrada: Double;

    FCalculouOValorDoIcms: Boolean;

    FDentroDoEstado: Boolean;

    FResultadoIcmsOrgaoPublico: IResultadoClasseIcmsOrgaoPublico;
    FResultadoIcms: IResultadoClasseIcms;
    FResultadoSt: IResultadoClasseSt;
    FResultadoStCustoAquisicao: IResultadoClasseStCustoAquisicao;
    FResultadoTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;
    FClienteAplicaCargaLiquidaCE: Boolean;

    procedure SetarModelClienteFornecedor;
    procedure SetarModelEmpresa;
    procedure SetarModelProduto;
    procedure SetarModelAbreviacaoIcms;

    Function fTemMIFFEntreOsDevolvidos : Boolean;
    Function CalcBeneficioReducaoBaseIcmsST : Boolean;
    Function DentroDoEstado : Boolean;
    Function RetornarTrocaUFEndEntrega: String;

    function RetornarTipoDeAbreviacao: String;
    function TipoDeAbreviacaoFiscal: String;

    function ValidarEntradaDeIPInaBaseIcms: Boolean;
    function ClienteIVAEspecialMT(const AValorIVAEspecialClienteMT: Double): Boolean;

    function RetornarTotalGeralDoItem(const ACalcularSubstituido: Boolean) : Double;
    function RetornarTotalGeralDoItemPreUlt(const ACalcularSubstituido: Boolean) : Double;

    function ParametrosCalculoIcms: IParametrosCalculoIcms;
    function ParametrosCalculoIPI: IParametrosServicoIPI;
    function ParametrosCalculoST(const AResultadoIcms: IResultadoClasseIcms): IParametrosCalculoST;
    function ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
    function ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;

    function ZerarValorDoIcms : Boolean;

    function ZerarValorDoSt : Boolean;
    function RetornarValorCalculadoDoIpi : Double;
    function RetornarValorCalculadoDoIpiEntrada: Double;
    function RetornaEstadoParaAbreviacao: String;
    function NotaDeImportacao: Boolean;
    function RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
    function DentroDoEstadoCFOP: Boolean;
    function AtividadeConstrutora: Boolean;
    function AlqIcmEstEmpFaturamento: Double;
    function AlqIcmEstEmpSimples: Double;

    function ParametrosRegrasTributacao : IParametrosRegrasTributacao;


    function CalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean;

    function CalculaSubTributariaPorDentro: Boolean;
    function RetornarEstadoParaAbreviacaoComum: String;
    function UtilizarAmpara: Boolean;

    function CalcularIcms: IResultadoClasseIcms;
    function CalcularIcmsFinal: IResultadoClasseIcms;

    function RetornarAbreviacaoIcmsComum: IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;
    function RetornarAbreviacaoIcmsComum(const ATipoDeAbreviacaoFiscal: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms; overload;

    function CalcularSt(const AResultadoIcms: IResultadoClasseIcms): IResultadoClasseSt;
    function CalcularStFinal(const AResultadoIcms: IResultadoClasseIcms): IResultadoClasseSt;

    procedure SetarVariaveisAmpara;

    function ClienteTARE: String;
    function ClienteDEFIT: String;
    function EhItemConcreto: Boolean;

    function RegrasDeTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;
    function RetornarValorDoIcms(const AResultadoIcms: IResultadoClasseIcms): Double;

    function CalcularIcmsOrgaoPublico: IResultadoClasseIcmsOrgaoPublico;
    function CalcularIcmsOrgaoPublicoFinal: IResultadoClasseIcmsOrgaoPublico;

    function CalcularStCustoAquisicao: IResultadoClasseStCustoAquisicao;

    function ResultadoCalculoIcmsSt: IResultadoServicosClasseIcmsSt;

    function RetornarDadosAbfFornecedor: IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
    function RetornarEstadoFornecedor: String;
    function PrecoDeCompraComDescontos: Double;
    function DefineEmpresaParaCalculoPrecoCompraMenosDescontoFornecedor: String;

    function UtilizaDecretoReducaoRICMSdaAbreviacao: Boolean;

    function RegraParaRetornarAliquotaDaSubstituicaoTributariaDoItem: Double;

    function ResultadoAliquotasRetencao : IResultadoAliquotasDeRetencao;

    function AliquotaCalculoDesoneracaoDeSubstituicaoTributaria: Double;

    function CalculaDesoneracaoDeSubstituicaoTributaria: Boolean;
  public
    function CalcularValorIcmsSt: IResultadoServicosClasseIcmsSt;
    function CalcularValorIcmsStFinal: IResultadoServicosClasseIcmsSt;

    class function New(AParametros: IParametrosServicoIcmsSt): IFaturamentoImpostosServicosClasseIcmsSt;

    constructor Create(AParametros: IParametrosServicoIcmsSt); overload;
  end;

implementation

{ TFaturamentoImpostosServicosClasseIcmsSt }

function TFaturamentoImpostosServicosClasseIcmsSt.AlqIcmEstEmpFaturamento: Double;
  Var
    LTipoDaAbreviacaoFiscal: String;
    LModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LTipoDaAbreviacaoFiscal := RetornarTipoDeAbreviacao;

  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.CodigoDoProduto)
       .CodigoDaAbreviacaoFiscal(FModelProduto.CodigoDaAbreviacaoFiscal)
       .Estado(FModelEmpresa.EmpresaEstado)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .CodigoDaEmpresaAbf(FParametros.CodigoDaEmpresaAbf)
       .TipoDaAbreviacaoFiscal(LTipoDaAbreviacaoFiscal);

  LModelAbreviacaoIcms :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);

  Result := LModelAbreviacaoIcms.AliquotaDeIcms;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.AlqIcmEstEmpSimples: Double;
var
  LSQL: String;

  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  LSQL := TFunctionFuncoesFaturamento.GetSelectAlqIcmEstEmp;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(LSQL);

  Result :=
    objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect,
                         LDesmembrarSelectParaCampoTabela.NomeTabela,
                         LDesmembrarSelectParaCampoTabela.CampoChave,
                         [FModelProduto.CodigoDaAbreviacaoFiscal, FModelEmpresa.EmpresaEstado],
                         False).Fields(0);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.AtividadeConstrutora: Boolean;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes
      .AtividadeConstrutora(FModelClienteFornecedor.ClienteAtividade, FParametros.CodigoDaEmpresa);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcBeneficioReducaoBaseIcmsST: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      fCalcBeneficioReducaoBaseIcmsST(TipoDeAbreviacaoFiscal
                                     ,FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem
                                     ,FDentroDoEstado);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularIcms: IResultadoClasseIcms;
begin
  Result :=
    TServicosClasseIcms.New(
      TParametrosClasseIcms.New
        .ParametrosCalculoIcms(ParametrosCalculoIcms)
        .RegrasTributacaoIcmsSt(FResultadoTributacaoAntesDoCalculo)
    ).CalcularIcms;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularIcmsFinal: IResultadoClasseIcms;
begin
  Result :=
    TServicosClasseIcms.New(
      TParametrosClasseIcms.New
        .ParametrosCalculoIcms(ParametrosCalculoIcms)
        .RegrasTributacaoIcmsSt(FResultadoTributacaoAntesDoCalculo)
    ).CalcularIcmsFinal(ZerarValorDoIcms);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularIcmsOrgaoPublico: IResultadoClasseIcmsOrgaoPublico;
begin
  Result :=
    TServicosClasseIcmsOrgaoPublico.New(
      TParametrosClasseIcmsOrgaoPublico.New
        .ParametrosCalculoIcmsOrgaoPublico(ParametrosCalculoIcmsOrgaoPublico)
        .RegrasTributacaoIcmsSt(FResultadoTributacaoAntesDoCalculo)
    ).CalcularIcmsOrgaoPublico;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularIcmsOrgaoPublicoFinal: IResultadoClasseIcmsOrgaoPublico;
begin
  Result :=
    TServicosClasseIcmsOrgaoPublico.New(
      TParametrosClasseIcmsOrgaoPublico.New
        .ParametrosCalculoIcmsOrgaoPublico(ParametrosCalculoIcmsOrgaoPublico)
        .RegrasTributacaoIcmsSt(FResultadoTributacaoAntesDoCalculo)
    ).CalcularIcmsOrgaoPublicoFinal;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularSt(const AResultadoIcms: IResultadoClasseIcms): IResultadoClasseSt;
begin
  Result :=
    TServicosClasseSt.New(
      TParametrosClasseSt.New
        .ParametrosCalculoSt(ParametrosCalculoSt(AResultadoIcms))
        .RegrasTributacaoIcmsSt(FResultadoTributacaoAntesDoCalculo)
    ).CalcularSt;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularStCustoAquisicao: IResultadoClasseStCustoAquisicao;
begin
  Result :=
    TServicosClasseStCustoAquisicao.New(
      TParametrosClasseStCustoAquisicao.New
        .ParametrosCalculoStCustoAquisicao(ParametrosCalculoStCustoAquisicao)
    ).CalcularStCustoAquisicao;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularStFinal(const AResultadoIcms: IResultadoClasseIcms): IResultadoClasseSt;
begin
  Result :=
    TServicosClasseSt.New(
      TParametrosClasseSt.New
        .ParametrosCalculoSt(ParametrosCalculoSt(AResultadoIcms))
        .RegrasTributacaoIcmsSt(FResultadoTributacaoAntesDoCalculo)
    ).CalcularStFinal(ZerarValorDoSt);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularValorIcmsSt: IResultadoServicosClasseIcmsSt;
begin
  FResultadoIcmsOrgaoPublico := CalcularIcmsOrgaoPublico;
  FResultadoIcms := CalcularIcms;
  FResultadoSt := CalcularSt(FResultadoIcms);
  FResultadoStCustoAquisicao := CalcularStCustoAquisicao;
  FResultadoTributacaoDepoisDoCalculo := RegrasDeTributacaoDepoisDoCalculo;

  Result := ResultadoCalculoIcmsSt;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalcularValorIcmsStFinal: IResultadoServicosClasseIcmsSt;
begin
  FResultadoIcmsOrgaoPublico := CalcularIcmsOrgaoPublicoFinal;
  FResultadoIcms := CalcularIcmsFinal;
  FResultadoSt := CalcularStFinal(FResultadoIcms);
  FResultadoStCustoAquisicao := CalcularStCustoAquisicao;
  FResultadoTributacaoDepoisDoCalculo := RegrasDeTributacaoDepoisDoCalculo;

  Result := ResultadoCalculoIcmsSt;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalculaSTClienteConsumidorFinalNCOEspiritoSanto: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      CalcSTCliConNCOEspSto(FModelEmpresa.EmpresaEstado,
                            TipoDeAbreviacaoFiscal,
                            FModelClienteFornecedor.ConsumidorFinal,
                            FDentroDoEstado,
                            FModelProduto.ImportacaoDireta = 'S',
                            FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalculaSubTributariaPorDentro: Boolean;
var
  LModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  LAbreviacaoFiscalICMS: Boolean;
begin
  LModelAbreviacaoIcms := RetornarAbreviacaoIcmsComum;

  LAbreviacaoFiscalICMS := (Not (LModelAbreviacaoIcms.CodigoDaAbreviacaoFiscal.IsEmpty));

  If (Pos(SAIDAS_PRODUTOR_RURAL, FTipoDeAbreviacaoFiscal) > 0) Then
  Begin
    Result :=
      TFunctionFuncoesFaturamento.
        CalculaSubTributariaPorDentro(FTipoDeAbreviacaoFiscal, LAbreviacaoFiscalICMS, LModelAbreviacaoIcms.CalcularSTSaiPRU);
  End
  Else
  Begin
    Result :=
      TFunctionFuncoesFaturamento.
        CalculaSubTributariaPorDentro(FTipoDeAbreviacaoFiscal, LAbreviacaoFiscalICMS, LModelAbreviacaoIcms.CalcularSTSaiCCO);
  End;
end;

constructor TFaturamentoImpostosServicosClasseIcmsSt.Create(
  AParametros: IParametrosServicoIcmsSt);
begin
  FParametros := AParametros;

  FDocumentoParaFornecedor :=
    TFunctionFuncoesFaturamento.
      fDocumentoParaFornecedor(FParametros.OpcaoDoDocumento,
                               FParametros.NotaComplementoFornecedor,
                               FParametros.NotaEspecialFornecedor,
                               NotaDeImportacao,
                               FParametros.CodigoDoCliente,
                               FParametros.CodigoDoFornecedor,
                               FParametros.RegimeEspecialPorEmpresa);

  SetarModelClienteFornecedor;
  SetarModelEmpresa;
  SetarModelProduto;

  FTipoDeAbreviacaoFiscal := RetornarTipoDeAbreviacao;

  FDentroDoEstado := DentroDoEstado;

  SetarModelAbreviacaoIcms;

  FClassificacaoDeVenda :=
    TFunctionFuncoesFaturamento.
      Transform(objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA), 4);

  FSimplesNacional := objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL,varBoolean);

  FValorCalculadoIPI := RetornarValorCalculadoDoIpi;
  FValorCalculadoIpiEntrada := RetornarValorCalculadoDoIpiEntrada;

  FResultadoTributacaoAntesDoCalculo := RegrasTributacaoIcmsSt;

  FSubstituicaoTributariaDoItem :=
    TFunctionFuncoesFaturamento.
      SubstituicaoTributaria(FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem);

  SetarVariaveisAmpara;

  FCalculouOValorDoIcms := False;

  FClienteAplicaCargaLiquidaCE := TFunctionFuncoesFaturamento.fAplicaCargaLiquidaCE(FModelClienteFornecedor.ClienteEstado,
                                                                                    FModelClienteFornecedor.ClienteReducaoCargaLiquida);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.DefineEmpresaParaCalculoPrecoCompraMenosDescontoFornecedor: String;
begin
  Result := FParametros.CodigoDaEmpresa;

  If Not TFunctionFuncoesFaturamento.OrcamentoOutraLojaF11(FParametros.OrigemF11, FParametros.CodigoDaEmpresaOriginal, FParametros.CodigoDaEmpresa, FParametros.NumeroDoOrcamento) Then
    Exit;

  If objCore.fEmptyStr(FParametros.CodigoDaEmpresaOriginal) Then
    Exit;

  Result := FParametros.CodigoDaEmpresaOriginal;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.DentroDoEstado: Boolean;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      VendaDentroDoEstado(RetornarTrocaUFEndEntrega,
                          FModelEmpresa.EmpresaEstado,
                          FParametros.VendaPresencial);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.DentroDoEstadoCFOP: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .fDentroDoEstadoCFOP(FParametros.VendaPresencial, FModelClienteFornecedor.ClienteEstado, FDentroDoEstado);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.EhItemConcreto: Boolean;
begin
  Result := TFaturamentoImpostosServicosFuncoes.EhItemConcreto(FParametros.CodigoDoProduto, FModelProduto.ItemConcreto);
end;

procedure TFaturamentoImpostosServicosClasseIcmsSt.SetarModelAbreviacaoIcms;
var
  LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.CodigoDoProduto)
       .CodigoDaAbreviacaoFiscal(FModelProduto.CodigoDaAbreviacaoFiscal)
       .Estado(RetornaEstadoParaAbreviacao)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .CodigoDaEmpresaAbf(FParametros.CodigoDaEmpresaAbf)
       .TipoDaAbreviacaoFiscal(FTipoDeAbreviacaoFiscal);

  FModelAbreviacaoIcms :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);
end;

procedure TFaturamentoImpostosServicosClasseIcmsSt.SetarModelClienteFornecedor;
begin
  If FDocumentoParaFornecedor Then
  begin
    FModelClienteFornecedor :=
      TFaturamentoImpostosModelFornecedor.New.Consultar(FParametros.CodigoDoCliente);
    Exit;
  end;

  FModelClienteFornecedor :=
    TFaturamentoImpostosModelCliente.New.Consultar(FParametros.CodigoDoCliente, FParametros.SequencialEnderecoEntrega, FParametros.GerandoCasosTestes, FParametros.ClienteConsumidorFinal, FParametros.ParametrosClienteConsumidor, FParametros.CodigoDaFazenda);
end;

procedure TFaturamentoImpostosServicosClasseIcmsSt.SetarModelEmpresa;
begin
  FModelEmpresa :=
    TFaturamentoImpostosModelEmpresa.New.Consultar(FParametros.CodigoDaEmpresa);
end;

procedure TFaturamentoImpostosServicosClasseIcmsSt.SetarModelProduto;
begin
  FModelProduto :=
    TFaturamentoImpostosModelProduto.New.Consultar(
      FParametros.CodigoDoProduto,
      FParametros.CodigoDaEmpresa,
      FParametros.CodigoDaEmpresaTE,
      FParametros.CodigoDoFornecedorDoItem,
      FParametros.GerandoCasosTestes,
      FParametros.CodigoDaEmpresaAbf);
end;

procedure TFaturamentoImpostosServicosClasseIcmsSt.SetarVariaveisAmpara;
var
  LAbreviacaoAmpara: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  FUtilizaAmpara         := UtilizarAmpara;
  FEncontrouAbfIcmAmpara := False;
  FAmparaAliquotaFCP     := 0.0;

  If FUtilizaAmpara Then
  Begin
    LAbreviacaoAmpara      := RetornarAbreviacaoIcmsComum;
    FEncontrouAbfIcmAmpara := (Not LAbreviacaoAmpara.CodigoDaAbreviacaoFiscal.IsEmpty);
    FAmparaAliquotaFCP     := LAbreviacaoAmpara.AliquotaDeFcp;
  End;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.AliquotaCalculoDesoneracaoDeSubstituicaoTributaria: Double;
var
  LAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  LDesoneracaoAliquotaFCP: Double;
begin
  Result := 0;

  if not CalculaDesoneracaoDeSubstituicaoTributaria then
    Exit;

  LDesoneracaoAliquotaFCP := 0;

  LAbreviacaoIcms := RetornarAbreviacaoIcmsComum;

  If (Not LAbreviacaoIcms.CodigoDaAbreviacaoFiscal.IsEmpty) Then
    LDesoneracaoAliquotaFCP := LAbreviacaoIcms.AliquotaDeFcp;

  Result := FParametros.AliquotaDeIcmsDoItem + LDesoneracaoAliquotaFCP;

end;

function TFaturamentoImpostosServicosClasseIcmsSt.CalculaDesoneracaoDeSubstituicaoTributaria: Boolean;
begin
  Result := CalcBeneficioReducaoBaseIcmsST And
            (objConfiguracoes.fGetValorConfiguracao(CFG_BENEFICIO_ICMSST_MODO_DE_CALCULO_FCP_ST) = '2') And
            (objConfiguracoes.fGetValorConfiguracao(CFG_MODELO_DE_CALCULO_DECRETO_REDUCAO_BASE_IMPOSTOS) = '3') And
            (RightStr(FParametros.CodigoDaSituacaoTributaria, 2) = '70');
end;

function TFaturamentoImpostosServicosClasseIcmsSt.fTemMIFFEntreOsDevolvidos: Boolean;
begin
  Result := TFunctionFuncoesFaturamento.ValidarDocumentosMIFF(FParametros.EspecieDeDevolucao);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.TipoDeAbreviacaoFiscal: String;
Var
  LParametros : IParametrosTipoDeAbreviacaoDoCliente;
begin
  LParametros :=
    TParametrosTipoDeAbreviacaoDoCliente.New
      .CodigoDoCliente(FParametros.CodigoDoCliente)
      .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
      .ClienteConsumidorFinal(FModelClienteFornecedor.ConsumidorFinal)
      .ClienteIndustria(FParametros.ClienteIndustria)
      .InscricaoEstadual(FModelClienteFornecedor.ClienteInscricaoEstadual)
      .ClienteFisicoOuJurico(FModelClienteFornecedor.ClienteFisJur)
      .DocumentoParaFornecedor(FDocumentoParaFornecedor)
      .CodigoDaEmpresaTransferencia(FModelClienteFornecedor.CodigoDaEmpresaTransferencia);

  Result :=
    TFaturamentoImpostosServicosFuncoes
      .RetornarTipoDeAbreviacaoClienteFornecedor(LParametros);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.UtilizaDecretoReducaoRICMSdaAbreviacao: Boolean;
var
  LModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  LModelAbreviacaoIcms := RetornarAbreviacaoIcmsComum(TipoDeAbreviacaoFiscal);

  Result :=
    TFunctionFuncoesFaturamento
      .UtilizaDecretoReducaoRICMSdaAbreviacao(LModelAbreviacaoIcms.DecretoReducaoRICMPR);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.UtilizarAmpara: Boolean;
var
  LItemAmpara: Boolean;
begin
  LItemAmpara := TFunctionFuncoesFaturamento.ItemAmpara(FModelProduto.UtilizaAmpara);

  Result := TFunctionFuncoesFaturamento.UtilizaAmpara(FModelClienteFornecedor.ClienteEstado, LItemAmpara);
end;

class function TFaturamentoImpostosServicosClasseIcmsSt.New(
  AParametros: IParametrosServicoIcmsSt): IFaturamentoImpostosServicosClasseIcmsSt;
begin
  Result := Self.Create(AParametros);
end;


function TFaturamentoImpostosServicosClasseIcmsSt.NotaDeImportacao: Boolean;
begin
  Result := SameText(TFaturamentoImpostosServicosFuncoes.RetornarNotaDeImportacao(FParametros.ClassificacaoFiscalDoItem), 'S');
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ParametrosCalculoIcms: IParametrosCalculoIcms;
var
  LAliquotaDeIcmsDoItem: Double;
begin
  LAliquotaDeIcmsDoItem :=
    TFunctionFuncoesFaturamento
      .RetornaAliquotaIcmConformeRegraMatoGrosso(FResultadoTributacaoAntesDoCalculo.AliquotaDeIcms,
                                                 FResultadoTributacaoAntesDoCalculo.AliquotaDaSubstituicaoTributaria,
                                                 FDentroDoEstado,
                                                 FModelClienteFornecedor.ConsumidorFinal,
                                                 True);

  Result :=
    TParametrosCalculoIcms.New()
      .VendaDentroDoEstado(FDentroDoEstado)
      .SubstituicaoTributariaDoItem(FSubstituicaoTributariaDoItem)
      .UtilizaImportacaoDireta(objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varBoolean))
      .ItemImportacaoDireta(FModelProduto.ImportacaoDireta = 'S')
      .CalculaBeneficioReducaoBaseIcmsST(CalcBeneficioReducaoBaseIcmsST)
      .SimplesNacional(FSimplesNacional)
      .TotalGeralDoItem(RetornarTotalGeralDoItem(False))
      .EntraIPINaBaseIcms(ValidarEntradaDeIPInaBaseIcms)
      .AliquotaDeIcmsDoItem(LAliquotaDeIcmsDoItem)
      .ValorDoIpiDoItem(FValorCalculadoIPI)
      .PercentualDaBaseDeIcmsDoItem(FResultadoTributacaoAntesDoCalculo.PercentualDaBaseDeIcms)
      .MetodoArredondamentoICMSECF(FParametros.MetodoArredondamentoICMSECF)
      .UtilizarReducaoRICMPR(FResultadoTributacaoAntesDoCalculo.ReducaoRICMPR = 'S')
      .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
      .CalcularDescontoIcmsOrgaoPublico(FModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico)
      .ClienteZonaFranca(FModelClienteFornecedor.ZonaFranca)
      .ClienteConsumidorFinal(FModelClienteFornecedor.ConsumidorFinal)
      .PercentualDeReducaoDaBaseDeIcms(FResultadoTributacaoAntesDoCalculo.PercentualDeReducaoDaBaseDeIcms)
      .TipoDaAbreviacaoFiscal(FTipoDeAbreviacaoFiscal);
end;


function TFaturamentoImpostosServicosClasseIcmsSt.ResultadoAliquotasRetencao: IResultadoAliquotasDeRetencao;
var
  LParametros : IParametrosAliquotasDeRetencao;
begin
 LParametros :=
   TParametrosAliquotasDeRetencao.New
     .CodigoDoCliente(FParametros.CodigoDoCliente);

  Result :=
    TRegrasAliquotasDeRetencao.New(LParametros)
      .UtilizarModelCliente(FModelClienteFornecedor, FParametros.ParametrosClienteConsumidor)
        .CarregarAliquotasRetencao;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico;
var
  LIsencaoDeIcmsVendasZonaFrancaProdutosNacionais: Boolean;
  LValorFreteDespesaAcessoriaItem: Double;
  LResultadoAliquotasRetencao : IResultadoAliquotasDeRetencao;

begin
  LIsencaoDeIcmsVendasZonaFrancaProdutosNacionais :=
    objConfiguracoes.fGetValorConfiguracao(CFG_ISENCAO_ICMS_VENDAS_ZONA_FRANCA_SOMENTE_PARA_PRODUTOS_NACIONAIS, varBoolean);

  LValorFreteDespesaAcessoriaItem :=
    TFunctionFuncoesFaturamento
      .ValorFreteDespesaAcessoriaItem(FParametros.ValorFreteDoItem,
                                      FParametros.DespesaAcessoriaDoItem,
                                      FModelClienteFornecedor.OrgaoPublico,
                                      FModelClienteFornecedor.ZonaFranca,
                                      FDentroDoEstado,
                                      FParametros.OpcaoDoDocumento,
                                      False,
                                      False);

  LResultadoAliquotasRetencao := ResultadoAliquotasRetencao;

  Result :=
    TParametrosCalculoIcmsOrgaoPublico.New
      .DentroDoEstado(FDentroDoEstado)
      .SubstituicaoTributariaDoItem(FSubstituicaoTributariaDoItem)
      .OpcaoDeDocumento(FParametros.OpcaoDoDocumento)
      .ValorTotalDoItem(FParametros.TotalGeralDoItem)
      .AliquotaDoPis(LResultadoAliquotasRetencao.AliquotaPIS)
      .AliquotaDoCofins(LResultadoAliquotasRetencao.AliquotaCOFINS)
      .CodigoDaSituacaoTributaria(FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem)
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(LIsencaoDeIcmsVendasZonaFrancaProdutosNacionais)
      .PercentualDaBaseDeCalculoDoItem(FResultadoTributacaoAntesDoCalculo.PercentualDaBaseDeIcms)
      .ValorFreteDespesasAcessoriasItem(LValorFreteDespesaAcessoriaItem)
      .DescontoEspecialDoItem(FParametros.DescontoEspecial)
      .AliquotaDeIcmsDoItem(FResultadoTributacaoAntesDoCalculo.AliquotaDeIcms)
      .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
      .ClienteZonaFranca(FModelClienteFornecedor.ZonaFranca)
      .ClienteConsumidorFinal(FModelClienteFornecedor.ConsumidorFinal)
      .AplicarDescontoPisCofinsOrgaoPublico(FModelClienteFornecedor.AplicarDescontoPisCofinsOrgaoPublico)
      .CalcularDescontoIcmsOrgaoPublico(FModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico)
      .EntraIPINaBaseIcms(ValidarEntradaDeIPInaBaseIcms)
      .ValorDoIpiDoItem(FValorCalculadoIPI)
      .ConsideraDescontoNaBaseDeCalculo(FParametros.ConsideraDescontoNaBaseDeCalculoOrgaoPublico)
      .OrgaoPublicoForaDoEstado(FModelClienteFornecedor.OrgaoPublicoForaDoEstado);

end;

function TFaturamentoImpostosServicosClasseIcmsSt.ParametrosCalculoIPI: IParametrosServicoIPI;
Begin
  Result := TParametrosServicoIPI.New()
      .CodigoDoCliente(FParametros.CodigoDoCliente)
      .ClienteConsumidorFinal(FParametros.ClienteConsumidorFinal)
      .CodigoDoProduto(FParametros.CodigoDoProduto)
      .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
      .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
      .VendaPresencial(FParametros.VendaPresencial)
      .EspecieDoDocumento(FParametros.EspecieDocumento)
      .DesmembrarNotaProdutosServicos(FParametros.DesmembrarNotaProdutosServicos)
      .OpcaoDoDocumento(FParametros.OpcaoDoDocumento)
      .OpcaoDeItemNfEspiritoSanto(FParametros.OpcaoDeItemNfEspiritoSanto)
      .EspecieDeDevolucao(FParametros.EspecieDeDevolucao)
      .DesmembrarMeiaNotaComNotaNormal(FParametros.DesmembrarMeiaNotaComNotaNormal)
      .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
      .EntregaFutura(FParametros.EntregaFuturaDoItem)
      .MeiaNotaFatorExpedicao(FParametros.MeiaNotaFatorExpedicao)
      .TotalGeralDoItem(FParametros.TotalGeralDoItem)
      .ValorFreteDoItem(FParametros.ValorFreteDoItem)
      .DespesaAcessoriaDoItem(FParametros.DespesaAcessoriaDoItem)
      .DescontoEspecial(FParametros.DescontoEspecial)
      .NotaComplementoFornecedor(FParametros.NotaComplementoFornecedor)
      .NotaEspecialFornecedor(FParametros.NotaEspecialFornecedor)
      .CodigoDoFornecedor(FParametros.CodigoDoFornecedor)
      .SequencialEnderecoEntrega(FParametros.SequencialEnderecoEntrega)
      .GerandoCasosTestes(FParametros.GerandoCasosTestes)
      .ParametrosClienteConsumidor(FParametros.ParametrosClienteConsumidor)
      .TotalGeralDoItemPreUlt(RetornarTotalGeralDoItemPreUlt(True))
      .TipoDePedidoFaturamento(FParametros.TipoDePedidoFaturamento)
      .TipoDeBaixaEntregaFutura(FParametros.TipoDeBaixaEntregaFutura)
      .CodigoDaFazenda(FParametros.codigoDaFazenda)
end;


function TFaturamentoImpostosServicosClasseIcmsSt.ParametrosCalculoST(const AResultadoIcms: IResultadoClasseIcms): IParametrosCalculoST;
begin
  Result :=
    TParametrosCalculoST.New
      .VendaDentroDoEstado(FDentroDoEstado)
      .SubstituicaoTributariaDoItem(FSubstituicaoTributariaDoItem)
      .CalculaSubstituicaoTributariaSimples(TFunctionFuncoesFaturamento.CalculaSubsTribSimples)
      .CalcularSTSomenteParaNaoConsumidorFinal(objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOMENTE_PARA_NAO_CONSUMIDOR_FINAL, varBoolean))
      .ClienteConsumidorFinal(FModelClienteFornecedor.ConsumidorFinal)
      .CalculaSTClienteConsumidorFinalNCOEspiritoSanto(CalculaSTClienteConsumidorFinalNCOEspiritoSanto)
      .UtilizaImportacaoDireta(objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varBoolean))
      .ItemImportacaoDireta(FModelProduto.ImportacaoDireta = 'S')
      .CalculaBeneficioReducaoBaseIcmsST(CalcBeneficioReducaoBaseIcmsST)
      .SimplesNacional(TFunctionFuncoesFaturamento.OptantePorSimplesNacional = 'S')
      .ValorDoIcmsDoItem(RetornarValorDoIcms(AResultadoIcms))
      .ValorDoIcmsDoEstado(FResultadoTributacaoAntesDoCalculo.ValorIcmsEstado)
      .AliquotaDaSubstituicaoTributariaDoItem(FResultadoTributacaoAntesDoCalculo.AliquotaDaSubstituicaoTributaria)
      .ValorDoIpiDoItem(FValorCalculadoIPI)
      .ValorDoIva(FResultadoTributacaoAntesDoCalculo.ValorDoIva)
      .UtilizarReducaoDeBaseDeCalculoDeSTNaVenda(objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_REDUCAO_BASE_CALCULO_SUBSTITUICAO_TRIBUTARIA_NA_VENDA, varBoolean))
      .PercentualMinimoReducaoDeBaseDeCalculoDosImpostos(objConfiguracoes.fGetValorConfiguracao(CFG_PERCENTUAL_MINIMO_DECRETO_44498_2013_REDUCAO_BASE_CALCULO_IMPOSTOS, varDouble))
      .PercentualDaBaseDeCalculoDaSTDoItem(FResultadoTributacaoAntesDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem)
      .TotalGeralDoItemPreUlt(RetornarTotalGeralDoItemPreUlt(True))
      .TotalGeralDoItem(RetornarTotalGeralDoItem(True))
      .UtilizaAmpara(FUtilizaAmpara)  //ampara
      .EncontrouAbreviacaoDeIcms(FEncontrouAbfIcmAmpara) //ampara
      .AmparaAliquotaFCP(FAmparaAliquotaFCP)  //ampara
      .TipoDeAbreviacaoFiscal(FTipoDeAbreviacaoFiscal)
      .PercentualDoFCPDoItem(FParametros.PercentualDoFcpDoItem) //Valor para iniciar variavel de retorno DifalFCP/Ampara
      .ValorDoFCPDoItem(FParametros.ValorDoFcpDoItem) //Valor para iniciar variavel de retorno DifalFCP/Ampara
      .CalculaSubstituicaoTributariaPorDentro(CalculaSubTributariaPorDentro)
      .ContribuinteDeIpi(objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean))
      .ClienteIVAEspecialMT(ClienteIVAEspecialMT(FResultadoTributacaoAntesDoCalculo.ValorIVAEspecialClienteMTSt))
      .AliquotaDeIcmsDoItem(AResultadoIcms.ResultadoCalculoIcms.AliquotaDoIcms)
      .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
      .CalcularDescontoIcmsOrgaoPublico(FModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico)
      .ClienteZonaFranca(FModelClienteFornecedor.ZonaFranca)
      .ClienteConsumidorFinal(FModelClienteFornecedor.ConsumidorFinal)
      .AliquotaOriginalDeIcmsDoItem(FParametros.AliquotaDeIcmsDoItem)
      .ValorDoIpiDeEntrada( FValorCalculadoIpiEntrada )
      .ModeloBeneficioReducaoBaseIcmsST(objConfiguracoes.fGetValorConfiguracao(CFG_MODELO_DE_CALCULO_DECRETO_REDUCAO_BASE_IMPOSTOS, varInteger))
      .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
      .AliquotaCalculoDesoneracaoDeSubstituicaoTributaria(AliquotaCalculoDesoneracaoDeSubstituicaoTributaria)
      .CalculaDesoneracaoDeSubstituicaoTributaria(CalculaDesoneracaoDeSubstituicaoTributaria)
      .AliquotaReducaoDeSt(FResultadoTributacaoAntesDoCalculo.AliquotaReduzidaDaSt)
      .AplicaCargaLiquidaCE(FClienteAplicaCargaLiquidaCE);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;
var
  LModelAbreviacaoIcmsFornecedor: IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  LModelAbreviacaoIcmsFornecedor := RetornarDadosAbfFornecedor;

  Result :=
    TParametrosCalculoSTCustoAquisicao.New
      .VendaDentroDoEstado(FDentroDoEstado)
      .SubstituicaoTributaria(FSubstituicaoTributariaDoItem)
      .ClienteConsumidorFinal(FModelClienteFornecedor.ConsumidorFinal)
      .PrecoDeCompraComDescontos(PrecoDeCompraComDescontos)
      .ModeloCalculoSubstituicaoDeOperacoesProprias(objConfiguracoes.fGetValorConfiguracao(CFG_MENSAGEM_IMPOSTO_RETIDO_INDUSTRIA_MODELO_CALCULO_SUBST_OPERACOES_PROPRIAS))
      .PercetualBaseIcmsDoFornecedor(LModelAbreviacaoIcmsFornecedor.PercentualDaBaseDeIcmsFornecedor)
      .IvaDoFornecedor(LModelAbreviacaoIcmsFornecedor.PercentualDeIvaFornecedor)
      .PercetualBaseSTDoFornecedor(LModelAbreviacaoIcmsFornecedor.PercentualDaBaseDeStFornecedor)
      .AliquotaDeSubstituicaoTributaria(FResultadoTributacaoAntesDoCalculo.AliquotaDaSubstituicaoTributaria)
      .AliquotaDeIcms(LModelAbreviacaoIcmsFornecedor.AliquotaFatorNegativo)
      .AliquotaDeOperacoesProprias(LModelAbreviacaoIcmsFornecedor.AliquotaOperacoesProprias)
      .IpiDeEntrada(FModelProduto.IpiDeEntrada)
      .FreteDeEntrada(FModelProduto.FreteDeEntrada)
      .CalculaSTClienteConsumidorFinalNotaEspiritoSanto(CalculaSTClienteConsumidorFinalNCOEspiritoSanto);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ParametrosRegrasTributacao: IParametrosRegrasTributacao;
begin
  Result :=
    TParametrosRegrasTributacao.New
      .ModelClienteFornecedor(FModelClienteFornecedor)
      .ModelProduto(FModelProduto)
      .ModelEmpresa(FModelEmpresa)
      .ModelAbreviacaoIcms(FModelAbreviacaoIcms)
      .DentroDoEstado(FDentroDoEstado)
      .NotaDeImportacao(NotaDeImportacao)
      .CodigoDaSituacaoTributaria(FParametros.CodigoDaSituacaoTributaria)
      .AliquotaDeIcmsDoItem(FParametros.AliquotaDeIcmsDoItem)
      .EspecieDoDocumento(FParametros.EspecieDocumento)
      .UtilizaSat(FParametros.UtilizaSat)
      .ClienteComercializacao(FParametros.ClienteComercializacao)
      .CalcularSatEcf(FParametros.CalcularSatEcf)
      .DentroDoEstadoCFOP(DentroDoEstadoCFOP)
      .AtividadeConstrutora(AtividadeConstrutora)
      .TipoOperacaoPedidoVenda(FParametros.TipoOperacaoPedidoVenda)
      .AlqIcmEstEmpFaturamento(AlqIcmEstEmpFaturamento)
      .ValorDeIpiDoItem(FValorCalculadoIPI)
      .DocumentoParaFornecedor(FDocumentoParaFornecedor)
	    .TotalGeralDoItem(RetornarTotalGeralDoItem(False))
      .ImportacaoDiretaDoItem(FModelProduto.ImportacaoDireta)
      .ValorUnitarioDoItem(FParametros.ValorUnitarioDoItem)
      .QuantidadeDoItem(FParametros.QuantidadeDoItem)
      .AlqIcmEstEmpSimples(AlqIcmEstEmpSimples)
      .TipoDaAbreviacaoFiscal(TipoDeAbreviacaoFiscal)
      .TotalGeralDoItemST_Simulado(RetornarTotalGeralDoItem(True))
      .ExisteNaTabelaCEDEM(TFaturamentoImpostosServicosFuncoes.ExisteNaTabelaCEDEM(FParametros.ClassificacaoDeIpi, FParametros.GerandoCasosTestes))
      .UtilizaDecretoReducaoRICMSdaAbreviacao(UtilizaDecretoReducaoRICMSdaAbreviacao);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.PrecoDeCompraComDescontos: Double;
begin
  If FParametros.IdePro <> 'NOR' Then
  Begin
    Result := FParametros.PrecoDeCompraDaTinta * FParametros.QuantidadeDoItem;
    Exit;
  End;

  If TFunctionFuncoesFaturamento.EhItemVendaVidro(FParametros.CodigoDoProduto) Then
  Begin
    Result := FParametros.PrecoDeCustoDoItemSemImpostos * FParametros.QuantidadeDoItem;
    Exit;
  End;

  Result :=
    TFaturamentoImpostosServicosFuncoes
      .RetornarPrecoCompraMenosDescontoFornecedor(FParametros.CodigoDoProduto, DefineEmpresaParaCalculoPrecoCompraMenosDescontoFornecedor) * FParametros.QuantidadeDoItem;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ClienteDEFIT: String;
var
  LResultado: IMyCampoTabela;

  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  Result := '';

  if not TFunctionFuncoesFaturamento.ValidarDocumentoParaClienteDefit(FDocumentoParaFornecedor, FModelClienteFornecedor.ClienteInscricaoEstadual, FModelClienteFornecedor.ClienteEstado) then
    Exit;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(TFunctionFuncoesFaturamento.RetornarSQLClienteDefit);

  LResultado := objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect, LDesmembrarSelectParaCampoTabela.NomeTabela, LDesmembrarSelectParaCampoTabela.CampoChave, [FParametros.CodigoDoCliente], False);

  Result := LResultado.FieldByName('CLI_DEFIT_').AsString;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ClienteIVAEspecialMT(const AValorIVAEspecialClienteMT: Double): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      ClienteIVAEspecialMT( FModelClienteFornecedor.ClienteEstado,
                            FModelEmpresa.EmpresaEstado,
                            AValorIVAEspecialClienteMT); // Executar
end;


function TFaturamentoImpostosServicosClasseIcmsSt.ClienteTARE: String;
var
  LResultado: IMyCampoTabela;

  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  Result := '';

  if not TFunctionFuncoesFaturamento.ValidarDocumentoParaClienteTare(FDocumentoParaFornecedor, FModelClienteFornecedor.ClienteInscricaoEstadual, FModelClienteFornecedor.ClienteEstado) then
    Exit;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(TFunctionFuncoesFaturamento.RetornarSQLClienteTare);

  LResultado := objCore.fCampoTabela(LDesmembrarSelectParaCampoTabela.CamposSelect, LDesmembrarSelectParaCampoTabela.NomeTabela, LDesmembrarSelectParaCampoTabela.CampoChave, [FParametros.CodigoDoCliente], False);

  Result := LResultado.FieldByName('CLI_TARE__').AsString;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RegraParaRetornarAliquotaDaSubstituicaoTributariaDoItem: Double;
begin
  Result := 0.0;

  If FResultadoSt.BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota <= 0.0 Then
    Exit;

  Result := FResultadoTributacaoAntesDoCalculo.AliquotaDaSubstituicaoTributaria;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RegrasDeTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;
var
  LParametrosRegrasTributacaoDepoisDoCalculo: IParametrosRegrasTributacaoDepoisDoCalculo;
begin
  LParametrosRegrasTributacaoDepoisDoCalculo :=
    TParametrosRegrasTributacaoDepoisDoCalculo.New()
      .ReducaoRICMPR(FResultadoTributacaoAntesDoCalculo.ReducaoRICMPR = 'S')
      .PercentualDaBaseDaSubstituicaoTributariaDoItem(FResultadoTributacaoAntesDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem)
      .AliquotaDaSubstituicaoTributariaDoItem(RegraParaRetornarAliquotaDaSubstituicaoTributariaDoItem)
      .PercentualDeReducaoDaBaseDeIcmsDoItem(FResultadoTributacaoAntesDoCalculo.PercentualDeReducaoDaBaseDeIcms);

  Result :=
    TRegraImpostosTributacaoDepoisDoCalculo.New(LParametrosRegrasTributacaoDepoisDoCalculo)
      .ReducaoPercentualBaseSubstituicaoTributaria
       .AliquotaDaSubstituicaoTributariaDoItem
        .ResultadoRegrasTributacaoDepoisDoCalculo;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt;
begin
  Result :=
    TFaturamentoImpostosRegrasTributacaoFactory.New(ParametrosRegrasTributacao)
      .Tributacao
        .IcmsSt;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ResultadoCalculoIcmsSt: IResultadoServicosClasseIcmsSt;
begin
  Result :=
    TResultadoServicosClasseIcmsSt.New()
      .ResultadoCalculoIcms(FResultadoIcms.ResultadoCalculoIcms)
      .ParametrosCalculoIcms(FResultadoIcms.ParametrosCalculoIcms)
      .ResultadoCalculoSt(FResultadoSt.ResultadoCalculoSt)
      .ParametrosCalculoSt(FResultadoSt.ParametrosCalculoSt)
      .ResultadoCalculoIcmsOrgaoPublico(FResultadoIcmsOrgaoPublico.ResultadoCalculoIcmsOrgaoPublico)
      .ParametrosCalculoIcmsOrgaoPublico(FResultadoIcmsOrgaoPublico.ParametrosCalculoIcmsOrgaoPublico)
      .ResultadoCalculoStCustoAquisicao(FResultadoStCustoAquisicao.ResultadoCalculoStCustoAquisicao)
      .ParametrosCalculoStCustoAquisicao(FResultadoStCustoAquisicao.ParametrosCalculoStCustoAquisicao)
      .CodigoDaSubstituicaoTributariaDoItem(FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem)
      .ResultadoRegrasTributacaoDepoisDoCalculo(FResultadoTributacaoDepoisDoCalculo)
      .AtendeRegrasAtoDeclaratorioDF(FResultadoTributacaoAntesDoCalculo.AtendeRegrasAtoDeclaratorioDF)
      .STAtribuidaPorRegimeEspecial(FResultadoTributacaoAntesDoCalculo.STAtribuidaPorRegimeEspecial)
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornaEstadoParaAbreviacao: String;
begin
  result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornaEstadoParaAbreviacao(FDentroDoEstado,
                                  FModelEmpresa.EmpresaEstado,
                                  RetornarTrocaUFEndEntrega);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarAbreviacaoIcmsComum: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
var
  LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.CodigoDoProduto)
       .CodigoDaAbreviacaoFiscal(FModelProduto.CodigoDaAbreviacaoFiscal)
       .Estado(RetornarEstadoParaAbreviacaoComum)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .CodigoDaEmpresaAbf(FParametros.CodigoDaEmpresaAbf)
       .TipoDaAbreviacaoFiscal(FTipoDeAbreviacaoFiscal);

  Result :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarAbreviacaoIcmsComum(
  const ATipoDeAbreviacaoFiscal: String): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
var
  LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.CodigoDoProduto)
       .CodigoDaAbreviacaoFiscal(FModelProduto.CodigoDaAbreviacaoFiscal)
       .Estado(RetornarEstadoParaAbreviacaoComum)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .CodigoDaEmpresaAbf(FParametros.CodigoDaEmpresaAbf)
       .TipoDaAbreviacaoFiscal(ATipoDeAbreviacaoFiscal);

  Result :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarDadosAbfFornecedor: IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
var
  LEstadoDoFornecedor: String;
  LTipoAbreviacaoFiscalFornecedor: String;
  LParametrosModelAbreviacaoIcmsFornecedor: IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  LEstadoDoFornecedor := RetornarEstadoFornecedor;

  LTipoAbreviacaoFiscalFornecedor :=
    TFaturamentoImpostosServicosFuncoes.
      TipoDeAbreviacaoDoFornecedor(FModelProduto.CodigoDoFornecedor);

  LParametrosModelAbreviacaoIcmsFornecedor :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor.New
      .CodigoDaAbreviacaoFiscal(FModelProduto.CodigoDaAbreviacaoFiscal)
      .Estado(LEstadoDoFornecedor)
      .TipoDaAbreviacaoFiscal(LTipoAbreviacaoFiscalFornecedor);

  Result :=
    TFaturamentoImpostosModelAbreviacaoIcmsFornecedor.New
      .Consultar(LParametrosModelAbreviacaoIcmsFornecedor);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarEstadoFornecedor: String;
var
  LModelFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  LModelFornecedor := TFaturamentoImpostosModelFornecedor.New.Consultar(FModelProduto.CodigoDoFornecedor);

  If objCore.fEmptyStr(LModelFornecedor.ClienteEstado) Then
  Begin
    Result := FModelClienteFornecedor.ClienteEstado;
    Exit;
  End;

  Result := LModelFornecedor.ClienteEstado;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarEstadoParaAbreviacaoComum: String;
begin
  Result := FModelClienteFornecedor.ClienteEstadoEntrega;

  If Not objCore.fEmptyStr(FModelClienteFornecedor.ClienteEstadoEntrega) Then
    Exit;

  Result := FModelClienteFornecedor.ClienteEstado;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarTipoDeAbreviacao: String;
begin
  result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornarTipoDeAbreviacaoNotaEspiritoSanto(FParametros.OpcaoDeItemNfEspiritoSanto, TipoDeAbreviacaoFiscal);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarTotalGeralDoItem(const ACalcularSubstituido: Boolean): Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      TotalGeralItem(FParametros.ClienteConsumidorFinal,
                     FParametros.DescontoEspecial,
                     FParametros.ValorFreteDoItem,
                     FParametros.TotalGeralDoItem,
                     FParametros.DespesaAcessoriaDoItem,
                     FModelClienteFornecedor.OrgaoPublico,
                     FModelClienteFornecedor.ZonaFranca,
                     TFaturamentoImpostosServicosFuncoes.
                       VendaDentroDoEstado(RetornarTrocaUFEndEntrega,
                                           FModelEmpresa.EmpresaEstado,
                                           FParametros.VendaPresencial),
                     FParametros.OpcaoDoDocumento,
                     ACalcularSubstituido,
                     false,
                     FModelClienteFornecedor.ClienteZonaFrancaComDescontoEspecial);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarTotalGeralDoItemPreUlt(
  const ACalcularSubstituido: Boolean): Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      TotalGeralItemPreUlt(FParametros.ClienteConsumidorFinal,
                           FParametros.DescontoEspecial,
                           FParametros.PrecoDeCustoDoItem,
                           FParametros.PrecoDeUltimaCompraDoItem,
                           FParametros.PrecoEImpostosDeUltimaCompraDoItem,
                           FParametros.QuantidadeDoItem,
                           FParametros.ValorFreteDoItem,
                           FParametros.DespesaAcessoriaDoItem,
                           FModelClienteFornecedor.OrgaoPublico,
                           FModelClienteFornecedor.ZonaFranca,
                           TFaturamentoImpostosServicosFuncoes.
                             VendaDentroDoEstado(RetornarTrocaUFEndEntrega,
                                                 FModelEmpresa.EmpresaEstado,
                                                 FParametros.VendaPresencial),
                           FParametros.OpcaoDoDocumento,
                           ACalcularSubstituido,
                           false);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ValidarEntradaDeIPInaBaseIcms: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      EntraIPInaBaseIcms(FParametros.ClienteConsumidorFinal,
                         ClienteIVAEspecialMT(FResultadoTributacaoAntesDoCalculo.ValorIVAEspecialClienteMTIcms),
                         FParametros.ClienteComercializacao,
                         FModelClienteFornecedor.SomarIpiBaseIcms,
                         FParametros.BaixaDeEntregaFutura);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ZerarValorDoIcms: Boolean;
begin
  Result :=
    TRegraImpostosZerarImpostosIcms.New.
      ZerarValorDoIcms(
        TParametrosRegraZerarImpostosIcms.New
          .AliquotaDeIcmsDoItem(0)
          .BaseDeCalculoDoIcmsDoItem(0)
          .ValorDoIcmsDoItem(0)
          .SimplesNacional(FSimplesNacional)
          .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
          .OpcaoDeDocumento(FParametros.OpcaoDoDocumento)
          .TaxaBombeamentoPedidoOrcamento(FParametros.TaxaBombeamentoPedidoOrcamento)
          .OpcaoItensNFEspTinta(FParametros.OpcaoDeItemNfEspiritoSanto)
          .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
          .EntregaFuturaDoItem(FParametros.EntregaFuturaDoItem)
          .EstadoDaEmpresa(FModelEmpresa.EmpresaEstado)
          .CodigoDaSubstituicaoTributariaDoItem(FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem)
          .EspecieDoDocumento(FParametros.EspecieDocumento)
          .ClassificacaoDeVenda(FClassificacaoDeVenda)
          .DentroDoEstado(FDentroDoEstado)
          .EmpresaOptanteSimples(TFunctionFuncoesFaturamento.EmpresaOptanteSimples(objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL)))
          .ItemTributado(TFunctionFuncoesFaturamento.ItemTributado(FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem))
          .ConfiguradoParaTrocarParaX41(TFunctionFuncoesFaturamento.ConfiguradoParaTrocarParaX41)
          .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
          .CalcularDescontoIcmsOrgaoPublico(FModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico)
          .ClienteZonaFranca(FModelClienteFornecedor.ZonaFranca)
          .ClienteConsumidorFinal(FParametros.ClienteConsumidorFinal)
          .ClienteEstado(FModelClienteFornecedor.ClienteEstado)
          .CodigoDaSituacaoTributaria(FParametros.CodigoDaSituacaoTributaria)
          .ConfiguradoParaTrocarParaX41noParana(TFunctionFuncoesFaturamento.ConfiguradoParaTrocarParaX41noParana)
          .TributaClienteZonaFranca(FParametros.TributaClienteZonaFranca)
        );
end;

function TFaturamentoImpostosServicosClasseIcmsSt.ZerarValorDoSt: Boolean;
begin
  Result :=
    TRegraImpostosZerarImpostosST.New
      .ZerarValorDoST(
        TParametrosRegraZerarImpostosST.New
          .SimplesNacional(FSimplesNacional)
          .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
          .OpcaoDeDocumento(FParametros.OpcaoDoDocumento)
          .TaxaBombeamentoPedidoOrcamento(FParametros.TaxaBombeamentoPedidoOrcamento)
          .OpcaoItensNFEspTinta(FParametros.OpcaoDeItemNfEspiritoSanto)
          .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
          .EntregaFuturaDoItem(FParametros.EntregaFuturaDoItem)
          .EstadoDaEmpresa(FModelEmpresa.EmpresaEstado)
          .CodigoDaSubstituicaoTributariaDoItem(FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem)
          .EspecieDoDocumento(FParametros.EspecieDocumento)
          .ClassificacaoDeVenda(FClassificacaoDeVenda)
          .DentroDoEstado(FDentroDoEstado)
          .EmpresaOptanteSimples(TFunctionFuncoesFaturamento.EmpresaOptanteSimples(objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL)))
          .ItemTributado(TFunctionFuncoesFaturamento.ItemTributado(FResultadoTributacaoAntesDoCalculo.CodigoDaSubstituicaoTributariaDoItem))
          .ConfiguradoParaTrocarParaX41(TFunctionFuncoesFaturamento.ConfiguradoParaTrocarParaX41)
          .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
          .CalcularDescontoIcmsOrgaoPublico(FModelClienteFornecedor.CalcularDescontoIcmsOrgaoPublico)
          .ClienteZonaFranca(FModelClienteFornecedor.ZonaFranca)
          .ClienteConsumidorFinal(FParametros.ClienteConsumidorFinal)
          .ClienteEstado(FModelClienteFornecedor.ClienteEstado)
          .ClienteTARE(ClienteTARE)
          .ClienteDEFIT(ClienteDEFIT)
          .DesmembrarMeiaNotaComNotaNormal(FParametros.DesmembrarMeiaNotaComNotaNormal)
          .MeiaNotaFatorExpedicao(FParametros.MeiaNotaFatorExpedicao)
          .TipoDePedidoFaturamento(FParametros.TipoDePedidoFaturamento)
          .DesmembrarNotaProdutosServicos(FParametros.DesmembrarNotaProdutosServicos)
          .EhItemConcreto(EhItemConcreto)
          .ConfiguradoParaTrocarParaX41noParana(TFunctionFuncoesFaturamento.ConfiguradoParaTrocarParaX41noParana)
          .TipoDeBaixaEntregaFutura(FParametros.TipoDeBaixaEntregaFutura)
          .TemMIFFEntreOsDevolvidos(fTemMIFFEntreOsDevolvidos)
          .TributaClienteZonaFranca(FParametros.TributaClienteZonaFranca)
      );
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarTrocaUFEndEntrega: String;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornarTrocaUFEndEntrega(FModelClienteFornecedor, FParametros.CodigoDaEmpresa, FParametros.OpcaoDoDocumento, FDocumentoParaFornecedor);
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarValorCalculadoDoIpi: Double;
Var
  LParametrosCalculoIPI: IParametrosServicoIPI;
  LResultadoServicosClasseIPI: IResultadoServicosClasseIPI;
begin
  LParametrosCalculoIPI := ParametrosCalculoIPI;

  LResultadoServicosClasseIPI :=
    TFaturamentoImpostosServicosClasseIpi.New(LParametrosCalculoIPI).CalcularValorIpi;

  result := LResultadoServicosClasseIPI.ResultadoCalculoIPI.ValorCalculadoIPI;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarValorCalculadoDoIpiEntrada: Double;
Var
  LParametrosCalculoIPI: IParametrosServicoIPI;
begin
  LParametrosCalculoIPI := ParametrosCalculoIPI;

  Result := TFaturamentoImpostosServicosClasseIpi.New(LParametrosCalculoIPI).CalcularValorIpiEntrada ;
end;

function TFaturamentoImpostosServicosClasseIcmsSt.RetornarValorDoIcms(const AResultadoIcms: IResultadoClasseIcms): Double;
begin
  Result := AResultadoIcms.ResultadoCalculoIcms.ValorCalculadoDoIcms;

  If AResultadoIcms.CalculouOValorDoIcms Then
    Exit;

  Result := CalcularIcms.ResultadoCalculoIcms.ValorCalculadoDoIcms;
end;

end.
