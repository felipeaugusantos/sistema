unit Faturamento.Impostos.Servicos.Classe.FcpDifal;

interface

uses System.SysUtils, System.StrUtils, Faturamento.Impostos.Interfaces.Servicos.Classe.FcpDifal,
  Faturamento.Impostos.Interfaces.FcpDifal, Faturamento.Impostos.Tipos.FcpDifal,
  Faturamento.Impostos.Interfaces.Model, Faturamento.Model.Empresa,
  Faturamento.Model.Fornecedor, Faturamento.Model.Cliente, Faturamento.Model.AbreviacaoIcms,
  Shared.Functions.Constantes, Faturamento.Impostos.Servicos.Funcoes, Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Configuracoes, Shared.Functions.Core, Faturamento.Impostos.Tipos.Model,
  Faturamento.Impostos.Interfaces.FCP, Faturamento.Impostos.Tipos.FCP, Shared.Functions.Interfaces,
  Shared.Functions.Tipos, Faturamento.Impostos.Servicos.Classe.Fcp,
  Faturamento.Impostos.Interfaces.Servicos.Classe.Fcp, Faturamento.Impostos.Tipos.Servicos.Classe.Fcp,
  Faturamento.Impostos.Tipos.ZerarImpostos.Fcp,
  Faturamento.Impostos.Regras.ZerarImpostos.Fcp, Shared.Functions.Types,

  Faturamento.Impostos.Interfaces.Servicos.Classe.DifalFcp,
  Faturamento.Impostos.Tipos.Servicos.Classe.DifalFcp,
  Faturamento.Impostos.Servicos.Classe.DifalFcp,

  Faturamento.Impostos.Interfaces.Servicos.Classe.Devolucao.DifalFcp,
  Faturamento.Impostos.Tipos.Servicos.Classe.Devolucao.DifalFcp,
  Faturamento.Impostos.Servicos.Classe.Devolucao.DifalFcp,
  Faturamento.Impostos.Interfaces.Difal, Faturamento.Impostos.Tipos.Difal,
  Faturamento.Impostos.Servicos.Classe.Difal,
  Faturamento.Impostos.Interfaces.Servicos.Classe.Difal,
  Faturamento.Impostos.Tipos.Servicos.Classe.Difal,
  Faturamento.Impostos.Tipos.ZerarImpostos.Difal,
  Faturamento.Impostos.Regras.ZerarImpostos.Difal,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos;

type
  TFaturamentoImpostosServicosClasseFcpDifal = class(TInterfacedObject, IFaturamentoImpostosServicosClasseFcpDifal)
  private
    FParametros: IParametrosServicoFcpDifal;

    FZeraDifal: Boolean;
    FBaseDestino: Double;
    FIcmsDestino: Double;
    FIcmsOrigem: Double;
    FValorFCP: Double;
    FBaseFCP: Double;
    FAliquotaFCP: Double;
    FPerBasDifalOrigem: Double;
    FPerBasDifalDestino: Double;
    FAlqInterestadualCalc: Double;
    FBaseIcmsItem: Double;
    FBaseIcmsItemBenST: Double;
    FAliquotaInternaEstadoDestino: Double;
    FPercentualProvisorioPartilha: Double;
    FDevolucaoOuEntradaGarantia: Boolean;
//    FSairDoProcedimento: Boolean;
    FRecordDifalFCP: TRecDifalFCP;
    FAliquotaFCPST: Double; //difal
    FGravarOsRegistros: Boolean;

    FSimplesNacional: Boolean;

    FModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    FModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelAbreviacaoIcms: IResultadoFaturamentoImpostosModelAbreviacaoIcms;

    FDocumentoParaFornecedor: Boolean;

    FfltValorFCPFaturamentoConsignacao : Double;

    FProdutoEmbalagem: String;
    FEstadosQueCalculamFcpProprio_e_FcpSt: String;

    procedure SetarModelEmpresa;
    procedure SetarModelClienteFornecedor;
    procedure SetarModelAbreviacaoIcms;

    procedure IniciandoVariaveisFcpDifal;

    procedure PreencherAliquotasParaCalculoDoDifal;
    procedure PreencherParametrosResultadoDevolucao(const AResultadoDevolucaoDifalFcp: IResultadoClasseDevolucaoDifalFcp);
    procedure PreencherRecordFcp;
    procedure CarregarDifalFCPDocumentoDevolvido;
    procedure PreencherParametrosResultadoDifal(const AResultadoClasseDifal: IResultadoClasseDifal);
    procedure PreencherParametrosResultadoDifalFcp(const AResultadoClasseDifalFcp: IResultadoClasseDifalFcp);
    procedure VerificarSeDeveZerarIcmsDestinoEOrigemDifalFcp;

    function AtendeRegrasDifal: Boolean;
    function ProdutoRevenda: Boolean;
    function ProdutoIndustrializadoDentroDoEstado: Boolean;
    function ProdutoRevendaDentroDoEstado: Boolean;
    function DentroDoEstado: Boolean;
    function RetornarTrocaUFEndEntrega: String;
    function NotaDeImportacao: Boolean;
    function RetornarEstadoParaAbreviacao: String;
    function PercentualProvisorioPartilha: Double;
    function CalcularValorDoFcpFinal: IResultadoClasseFcp;
    function AtividadeConstrutora: Boolean;
    function TipoDeAbreviacaoDoCliente(ACodigoDoCliente, ACodigoDaEmpresa: String): String;
    function DevolucaoOuEntradaGarantia: Boolean;
    function EntradaRecebimentoGarantia: Boolean;
    function DevolucaoNotaEspecial: Boolean;
    function CalcBeneficioReducaoBaseIcmsST: Boolean;
    function ZerarFCP: Boolean;

    function ParametrosCalculoFcp: IParametrosCalculoFcp;
    function ParametrosCalculoDifal: IParametrosCalculoDifal;
    function ResultadoServicosClasseFcpDifal(const AResultadoClasseFcp: IResultadoClasseFcp): IResultadoServicosClasseFcpDifal; overload;
    function ResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal; overload;
    function ResultadoServicosClasseFcpDifalSairDoProcedimento: IResultadoServicosClasseFcpDifal; overload;
    function ResultadoServicosClasseFcpDifalAliquotaInternaEstadoDestino: IResultadoServicosClasseFcpDifal; overload;
    function ResultadoServicosClasseFcpDifalDevolucao: IResultadoServicosClasseFcpDifal; overload;
    function ResultadoCalculoFcpDifalFinal(const AResultadoClasseFcp: IResultadoClasseFcp): IResultadoCalculoFcpDifalFinal; overload;
    function ResultadoCalculoFcpDifalFinal: IResultadoCalculoFcpDifalFinal; overload;
    function CalculaAliquotaInterestadual: Double;

    function ZerarDifal: Boolean; overload;
    function SairDoProcedimento: Boolean;
    function NaoEhDevolucaoEAliquotaInternaEstadoDestinoZerada: Boolean;
    function ProdutoST: Boolean;
    function ZerarDifalFcp: Boolean;
    function TipoDeAbreviacaoFiscalEmpresa: String;
    function ConsultarAbreviacaoIcmsEmpresa: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
    function CalcularValorDoDifal: IResultadoClasseDifal;
    function ZerarValorDifal: Boolean;
    function ParametrosClasseDevolucaoDifalFcp: IParametrosClasseDevolucaoDifalFcp;

    procedure ZerarVariaveisDifal;
    function fZeraVariaveisFCPST: Boolean;
    procedure ZerarVariaveisFcp;
    procedure ZerarVariaveisDifalEFcp;
    function CalcularValorDoDifalFcp: IResultadoClasseDifalFcp;
    function ZeraFcpDifal(AZeraFcp, ACfgSimplesNacional, ACfgDestinoPartilha: Boolean): Boolean;
    function ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp;
    function ZerarDifalNoResultadoCalculoFcpDifalFinal(const AResultadoClasseFcp: IResultadoClasseFcp):Boolean;
    function DevolucaoInterestadualComProdutoSt: Boolean;
    function CalculaFCPComReducaoBaseIcmsST: Boolean;
    function UtilizaDifalFCPDocumentoDevolvido: Boolean;

  public
    function CalcularValorFcpDifalFinal: IResultadoServicosClasseFcpDifal;

    constructor Create(AParametros: IParametrosServicoFcpDifal); overload;

    class function New(AParametros: IParametrosServicoFcpDifal): IFaturamentoImpostosServicosClasseFcpDifal;
  end;

implementation

{ TFaturamentoImpostosServicosClasseFcpDifal }

function TFaturamentoImpostosServicosClasseFcpDifal.NaoEhDevolucaoEAliquotaInternaEstadoDestinoZerada: Boolean;
begin
  Result := False;

  If ZerarValorDifal Then
    Exit;

  If FParametros.OpcaoDeDocumento = DEVOLUCAO Then
    Exit;

  If FParametros.OpcaoDeDocumentoVerdadeira = SFA_MOBILE Then
    Exit;

  If FAliquotaInternaEstadoDestino > 0 Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.AtendeRegrasDifal: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      fAtendeRegrasDifal(FModelClienteFornecedor.ClienteInscricaoEstadual,
                         False,
                         FParametros.ClienteConsumidorFinal,
                         FDocumentoParaFornecedor,
                         DentroDoEstado,
                         FParametros.ClienteFilial,
                         FParametros.OpcaoDeDocumento,
                         TFunctionFuncoesFaturamento.fEhProdutorRural(FModelClienteFornecedor.ClienteProdutorRural),
                         TFunctionFuncoesFaturamento.fRetornaIesUni(FModelClienteFornecedor.ClienteNaoContribuinteDeIcms),
                         AtividadeConstrutora,
                         TipoDeAbreviacaoDoCliente(FParametros.CodigoDoCliente, FParametros.CodigoDaEmpresa));
end;

function TFaturamentoImpostosServicosClasseFcpDifal.AtividadeConstrutora: Boolean;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes
      .AtividadeConstrutora(FModelClienteFornecedor.ClienteAtividade, FParametros.CodigoDaEmpresa);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.CalcBeneficioReducaoBaseIcmsST: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      fCalcBeneficioReducaoBaseIcmsST(FParametros.TipoDaAbreviacaoFiscal
                                     ,FParametros.CodigoDaSubstituicaoTributariaDoItem
                                     ,DentroDoEstado);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.CalculaAliquotaInterestadual: Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      fCalculaAliquotaInterestadual(FParametros.CodigoDaSubstituicaoTributariaDoItem,
                                    FModelEmpresa.EmpresaEstado,
                                    RetornarTrocaUFEndEntrega);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.CalcularValorDoFcpFinal: IResultadoClasseFcp;
begin
  Result :=
    TServicosClasseFcp.New(
      TParametrosClasseFcp.New
        .ParametrosCalculoFCP(ParametrosCalculoFcp)
    ).CalcularFcpFinal;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.CalcularValorFcpDifalFinal: IResultadoServicosClasseFcpDifal;
var
  LResultadoClasseFcp: IResultadoClasseFcp;
begin
  If SairDoProcedimento Then
  Begin
    Result := ResultadoServicosClasseFcpDifalSairDoProcedimento;
    Exit;
  End;

  SetarModelAbreviacaoIcms;

  LResultadoClasseFcp := CalcularValorDoFcpFinal;

  If LResultadoClasseFcp.CalculouOValorDoFcp Then
  Begin
    Result := ResultadoServicosClasseFcpDifal(LResultadoClasseFcp);
    Exit;
  End;

  PreencherAliquotasParaCalculoDoDifal;

  If NaoEhDevolucaoEAliquotaInternaEstadoDestinoZerada Then
  Begin
    Result := ResultadoServicosClasseFcpDifalAliquotaInternaEstadoDestino;
    Exit;
  End;

  If FParametros.OpcaoDeDocumento = DEVOLUCAO Then
  Begin
    If UtilizaDifalFCPDocumentoDevolvido Then
    Begin
      Result := ResultadoServicosClasseFcpDifalDevolucao;
      Exit;
    End;
  End;

  //Difal e Fcp
  Result := ResultadoServicosClasseFcpDifal;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.UtilizaDifalFCPDocumentoDevolvido: Boolean;
var
  LClasseDevolucaoDifalFcp: IServicoClasseDevolucaoDifalFcp;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
  LResultadoDevolucaoDifalFcp: IResultadoClasseDevolucaoDifalFcp;
begin
  Result := True;

  LParametros := ParametrosClasseDevolucaoDifalFcp;

  LClasseDevolucaoDifalFcp := TServicoClasseDevolucaoDifalFcp.New(LParametros).CarregarDocumentoDevolvido;

  If Not LClasseDevolucaoDifalFcp.DocumentoExiste Then
    Exit;

  LResultadoDevolucaoDifalFcp := LClasseDevolucaoDifalFcp.CalcularProporcional.RetornarResultado;

  Result := (objCore.fFormataFloat(FParametros.BaseDeCalculoDoIcmsDoItem, 2) = objCore.fFormataFloat(LResultadoDevolucaoDifalFcp.BaseIcmsItemDevolucao, 2));
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.CarregarDifalFCPDocumentoDevolvido;
var
  LClasseDevolucaoDifalFcp: IServicoClasseDevolucaoDifalFcp;
  LParametros: IParametrosClasseDevolucaoDifalFcp;
  LResultadoDevolucaoDifalFcp: IResultadoClasseDevolucaoDifalFcp;
begin
  LParametros := ParametrosClasseDevolucaoDifalFcp;

  LClasseDevolucaoDifalFcp := TServicoClasseDevolucaoDifalFcp.New(LParametros).CarregarDocumentoDevolvido;

  If Not LClasseDevolucaoDifalFcp.DocumentoExiste Then
    Exit;

  LResultadoDevolucaoDifalFcp := LClasseDevolucaoDifalFcp.CalcularProporcional.RetornarResultado;
  PreencherParametrosResultadoDevolucao(LResultadoDevolucaoDifalFcp);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ConsultarAbreviacaoIcmsEmpresa: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
var
  LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.CodigoDoItemDaAbreviacaoFiscal)
       .CodigoDaAbreviacaoFiscal(FParametros.CodigoDaAbreviacaoFiscal)
       .Estado(FModelEmpresa.EmpresaEstado)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .CodigoDaEmpresaAbf(FParametros.CodigoDaEmpresaAbf)
       .TipoDaAbreviacaoFiscal(TipoDeAbreviacaoFiscalEmpresa);

  Result :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);
end;

constructor TFaturamentoImpostosServicosClasseFcpDifal.Create(
  AParametros: IParametrosServicoFcpDifal);
begin
  FParametros := AParametros;

  FDocumentoParaFornecedor :=
    TFunctionFuncoesFaturamento.
      fDocumentoParaFornecedor(FParametros.OpcaoDeDocumento,
                               FParametros.NotaComplementoFornecedor,
                               FParametros.NotaEspecialFornecedor,
                               NotaDeImportacao,
                               FParametros.CodigoDoCliente,
                               FParametros.CodigoDoFornecedor);

  FEstadosQueCalculamFcpProprio_e_FcpSt :=
    TFunctionFuncoesFaturamento.
      Transform(objConfiguracoes.fGetValorConfiguracao(CFG_ESTADOS_QUE_CALCULAM_FCP_PROPRIO_E_FCP_ST_DENTRO_DO_ESTADO), 2);

  SetarModelEmpresa;
  SetarModelClienteFornecedor;

  IniciandoVariaveisFcpDifal;

  FSimplesNacional := objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, VarBoolean);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.DentroDoEstado: Boolean;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      VendaDentroDoEstado(RetornarTrocaUFEndEntrega,
                          FModelEmpresa.EmpresaEstado,
                          FParametros.VendaPresencial);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.DevolucaoOuEntradaGarantia: Boolean;
begin
  Result := True;

  If FParametros.OpcaoDeDocumento = DEVOLUCAO Then
    Exit;

  If EntradaRecebimentoGarantia Then
    Exit;

  If DevolucaoNotaEspecial Then
    Exit;
    
  Result := False;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.EntradaRecebimentoGarantia: Boolean;
begin
  Result := False;

  If Not TFunctionFuncoesFaturamento.fEhRecGarantia(FParametros.OpcaoDeDocumento, FParametros.ClassificacaoFiscalRecebimentoGarantia) Then
    Exit;

  If FParametros.ClassificacaoFiscalDoItem >= '5000' Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.DevolucaoNotaEspecial: Boolean;
begin
  Result := False;
  If (FParametros.OpcaoDeDocumento = NOTA_ESPECIAL) Then
    If (Length(FParametros.ClassificacaoFiscal) = 4) Then
      If (FParametros.ClassificacaoFiscal < '5000') Then
        Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ParametrosCalculoDifal: IParametrosCalculoDifal;
var
  LModelAbreviacaoIcmsEmpresa: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
  LAbreviacaoIcmsProdutoUfEmpresa: Boolean;
  LPercentualBaseOrigem: Double;
  LTipoDeAbreviacaoFiscal: String;
  LAbreviacaoIcmsProduto: Boolean;
  LAliquotaEfetivaOrigem: Double;
begin
  LAbreviacaoIcmsProduto := FModelAbreviacaoIcms.RegistroExiste;
  LAliquotaEfetivaOrigem := FModelAbreviacaoIcms.AliquotaEfetivaOrigem;

  LModelAbreviacaoIcmsEmpresa := ConsultarAbreviacaoIcmsEmpresa;
  LAbreviacaoIcmsProdutoUfEmpresa := LModelAbreviacaoIcmsEmpresa.RegistroExiste;
  LPercentualBaseOrigem           := LModelAbreviacaoIcmsEmpresa.PercentualDaBaseDeIcms;
  LTipoDeAbreviacaoFiscal         := LModelAbreviacaoIcmsEmpresa.CodigoDaSituacaoTributaria;

  Result :=
    TParametrosCalculoDifal.New
      .ValorIpiDoItem(FParametros.ValorDoIpi)
      .ValorFreteDoItem(FParametros.ValorDoFrete)
      .AliquotaInterestadualCalc(FAlqInterestadualCalc)
      .ValorIcmsBase(FParametros.BaseDeCalculoDoIcmsDoItem)
      .TotalDoItem(FParametros.ValorTotalDoItem)
      .DescontoEspecialDoItem(FParametros.DescontoEspecial)
      .DespesaAcessoriaDoItem(FParametros.DespesasAcessorias)
      .PercentualBaseOrigem(LPercentualBaseOrigem)
      .PercentualBaseDestino(FParametros.PercentualBaseDoIcmsDoItem)
      .PercentualBaseDifalOrigem(FPerBasDifalOrigem)
      .PercentualBaseDifalDestino(FPerBasDifalDestino)
      .CalculaAliquotaInterestadual(CalculaAliquotaInterestadual)
      .CalculaAliquotaEfetivaOrigem(LAliquotaEfetivaOrigem)
      .AliquotaInternaEstadoDestino(FAliquotaInternaEstadoDestino)
      .PercentualProvisorioPartilha(FPercentualProvisorioPartilha)
      .ProdutoSt(ProdutoST)
      .SimplesNacional(FSimplesNacional)
      .AbreviacaoIcmsProduto(LAbreviacaoIcmsProduto)
      .AbreviacaoIcmsProdutoUfEmpresa(LAbreviacaoIcmsProdutoUfEmpresa)
      .HabilitarPercentualBase(objConfiguracoes.fGetValorConfiguracao(CFG_HABILITAR_PERCENTUAL_BASE_DIFAL, VarBoolean))
      .CodigoSituacaoTributaria(RightStr(FParametros.CodigoDaSituacaoTributaria, 2))
      .CalculaTipoDeAbreviacaoFiscal(RightStr(LTipoDeAbreviacaoFiscal, 2) = '60')
      .SituacaoReducaoBaseCalculo(RightStr(FParametros.CodigoDaSubstituicaoTributariaDoItem, 2) = '20')
      .CalculaBaseReduzidaAliquotaEfetiva(objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_DIFAL_COM_BASE_REDUZIDA_UTILIZANDO_ALIQUOTA_EFETIVA, VarBoolean))
      .CalculaDiferencialAliquotaProdutosSt(objConfiguracoes.fGetValorConfiguracao(CFG_CALCULAR_DIFERENCIAL_ALIQUOTA_PRODUTOS_ST, VarBoolean))
      .ProdutoDeOrigemEstrangeira(Pos(LeftStr(FParametros.CodigoDaSubstituicaoTributariaDoItem, 1), '1_2') > 0)
      .ConsiderarAliquotaEfetivaProdutosImportados(objConfiguracoes.fGetValorConfiguracao(CFG_CONSIDERAR_ALIQUOTA_EFETIVA_DO_ESTADO_CALCULAR_DIFAL_PRODUTOS_IMPORTADOS, VarBoolean))
      .RecordDifalFCP(FParametros.RecordDifalFCP)
      .EntraIPInaBaseIcms(FParametros.EntraIPInaBaseIcms)
      .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
      .HabilitarNovoCalculoDifalComPercentualBase(FParametros.HabilitarNovoCalculoDifalComPercentualBase); // Provisório feito para atender a necessidades dos clientes até o início da NT 2020.005
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ParametrosCalculoFcp: IParametrosCalculoFcp;
  const
    BaseFcpStSemDeducaoDeBaseIcms : string = '2';
begin
  Result :=
    TParametrosCalculoFCP.New
      .OpcaoDeDocumento(FParametros.OpcaoDeDocumento)
      .EspecieDoDocumento(FParametros.EspecieDoDocumento)
      .AtendeRegrasDIFAL(AtendeRegrasDIFAL)
      .VendaPresencial(FParametros.VendaPresencial)
      .SubstituicaoTributariaDoItem(TFunctionFuncoesFaturamento.SubstituicaoTributaria(FParametros.CodigoDaSituacaoTributaria))
      .BaseDeCalculoDoIcmsDoItem(FParametros.BaseDeCalculoDoIcmsDoItem)
      .AliquotaFCPAbrevicaoIcms(FModelAbreviacaoIcms.AliquotaDeFcp)
      .DocumentoDeDevolucao(FParametros.DocumentoDeDevolucao)
      .DiferencaFCPST(FParametros.DiferencaFCPST)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(FParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem)
      .AliquotaFCPST(FParametros.AliquotaFCPST)
      .CalcularBeneficioReducaoBaseIcmsST(CalcBeneficioReducaoBaseIcmsST)
      .ClienteEstado(FModelClienteFornecedor.ClienteEstado)
      .OutrasSaidasParaFornecedores(FParametros.OpcaoDeDocumento = OUTRAS_SAIDAS_FORNECEDOR)
      .RecordDifalFCP(FParametros.RecordDifalFCP)
      .ZerarFCP(ZerarFcp)
      .ProdutoIndustrializadoDentroDoEstado(ProdutoIndustrializadoDentroDoEstado)
      .SimplesNacional(FSimplesNacional)
      .BeneficioReducaoBaseIcmsSTBaseFcpStSemDeducaoDeBaseIcms(objConfiguracoes.fGetValorConfiguracao(CFG_BENEFICIO_ICMSST_MODO_DE_CALCULO_FCP_ST, varString) = BaseFcpStSemDeducaoDeBaseIcms)
      .DevolucaoInterestadualComProdutoSt(DevolucaoInterestadualComProdutoSt)
      .CalculaFCPComReducaoBaseIcmsST(CalculaFCPComReducaoBaseIcmsST)
      .ProdutoRevendaDentroDoEstado(ProdutoRevendaDentroDoEstado)
      .ProdutoEmbalagem(FParametros.ProdutoEmbalagem)
      .BaseDeCalculoDoIcmsDoItemBenST(FBaseIcmsItemBenST)
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ParametrosClasseDevolucaoDifalFcp: IParametrosClasseDevolucaoDifalFcp;
begin
  Result :=
    TParametrosClasseDevolucaoDifalFcp.New
      .CodigoDoCliente(FParametros.CodigoDoCliente)
      .CodigoDoItem(FParametros.CodigoDoItem)
      .NumeroDoDocumentoDeDevolucao(FParametros.NumeroDoDocumentoDeDevolucao)
      .EspecieDoDocumentoDeDevolucao(FParametros.EspecieDoDocumentoDeDevolucao)
      .EmpresaDoDocumentoDeDevolucao(FParametros.EmpresaDoDocumentoDeDevolucao)
      .QuantidadeDoItem(FParametros.QuantidadeDoItem)
      .ProdutoST(ProdutoST)
      .HabilitarNovoCalculoDifalComPercentualBase(FParametros.HabilitarNovoCalculoDifalComPercentualBase);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.PercentualProvisorioPartilha: Double;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      PercentualProvisorioPartilha(FParametros.DataDoSistema);
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.IniciandoVariaveisFcpDifal;
begin
  FZeraDifal                    := False;
  FBaseDestino                  := 0;
  FIcmsDestino                  := 0;
  FIcmsOrigem                   := 0;
  FValorFCP                     := 0;
  FBaseFCP                      := 0;
  FAliquotaFCP                  := 0;
  FPerBasDifalOrigem            := 0;
  FPerBasDifalDestino           := 0;
  FAlqInterestadualCalc         := FParametros.AliquotaDeIcmsDoItem;
  FBaseIcmsItem                 := FParametros.BaseDeCalculoDoIcmsDoItem;
  FBaseIcmsItemBenST            := FParametros.BaseDeCalculoDoIcmsDoItemBenST;
  FAliquotaInternaEstadoDestino := 0;
  FPercentualProvisorioPartilha := PercentualProvisorioPartilha;
  FDevolucaoOuEntradaGarantia   := DevolucaoOuEntradaGarantia;
  FRecordDifalFCP               := FParametros.RecordDifalFCP;
  FProdutoEmbalagem             := FParametros.ProdutoEmbalagem;
  FfltValorFCPFaturamentoConsignacao := 0;
end;

class function TFaturamentoImpostosServicosClasseFcpDifal.New(
  AParametros: IParametrosServicoFcpDifal): IFaturamentoImpostosServicosClasseFcpDifal;
begin
  Result := Self.Create(AParametros);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.NotaDeImportacao: Boolean;
begin
  Result := SameText(TFaturamentoImpostosServicosFuncoes.RetornarNotaDeImportacao(FParametros.ClassificacaoFiscalDoItem), 'S');
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.PreencherParametrosResultadoDevolucao(
  const AResultadoDevolucaoDifalFcp: IResultadoClasseDevolucaoDifalFcp);
begin
  FBaseDestino                  := AResultadoDevolucaoDifalFcp.BaseDestino;
  FAliquotaFCP                  := AResultadoDevolucaoDifalFcp.AliquotaFCP;
  FAliquotaInternaEstadoDestino := AResultadoDevolucaoDifalFcp.AliquotaInternaEstadoDestino;
  FPercentualProvisorioPartilha := AResultadoDevolucaoDifalFcp.PercentualProvisorioPartilha;
  FValorFCP                     := AResultadoDevolucaoDifalFcp.ValorFCP;
  FAlqInterestadualCalc         := AResultadoDevolucaoDifalFcp.AliquotaInterestadualCalc;
  FIcmsDestino                  := AResultadoDevolucaoDifalFcp.IcmsDestino;
  FIcmsOrigem                   := AResultadoDevolucaoDifalFcp.IcmsOrigem;
  FBaseFCP                      := AResultadoDevolucaoDifalFcp.BaseFCP;

  FRecordDifalFCP.fltAlDifa := FAliquotaInternaEstadoDestino - FAlqInterestadualCalc;
  FRecordDifalFCP.fltDifDes := FIcmsDestino;
  FRecordDifalFCP.fltDifOri := FIcmsOrigem;
  FRecordDifalFCP.fltAlqIne := FAlqInterestadualCalc;
  FRecordDifalFCP.fltAlqUfd := FAliquotaInternaEstadoDestino;
  FRecordDifalFCP.fltBcuFde := FBaseDestino;
  FRecordDifalFCP.fltPerPar := FPercentualProvisorioPartilha;
  FRecordDifalFCP.fltBasFcp := FBaseFCP;
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.PreencherParametrosResultadoDifal(
  const AResultadoClasseDifal: IResultadoClasseDifal);
begin
  FAlqInterestadualCalc := AResultadoClasseDifal.ResultadoCalculoDifal.AliquotaInterestadualCalc;
  FBaseDestino          := AResultadoClasseDifal.ResultadoCalculoDifal.ValorBaseDestino;
  FIcmsOrigem           := AResultadoClasseDifal.ResultadoCalculoDifal.ValorIcmsOrigem;
  FIcmsDestino          := AResultadoClasseDifal.ResultadoCalculoDifal.ValorIcmsDestino;
  FRecordDifalFCP       := AResultadoClasseDifal.ResultadoCalculoDifal.RecordDifalFCP;
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.PreencherParametrosResultadoDifalFcp(
  const AResultadoClasseDifalFcp: IResultadoClasseDifalFcp);
begin
  FRecordDifalFCP.fltAlDifa := AResultadoClasseDifalFcp.ResultadoCalculoDifalFcp.AliquotaDifalDoItem;
  FIcmsOrigem  := AResultadoClasseDifalFcp.ResultadoCalculoDifalFcp.IcmsDeOrigem;
  FIcmsDestino := AResultadoClasseDifalFcp.ResultadoCalculoDifalFcp.IcmsDeDestino;
  FBaseFCP     := AResultadoClasseDifalFcp.ResultadoCalculoDifalFcp.BaseFCP;
  FValorFCP    := AResultadoClasseDifalFcp.ResultadoCalculoDifalFcp.ValorFCP;
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.PreencherAliquotasParaCalculoDoDifal;
begin
  FAliquotaFCP                  := FModelAbreviacaoIcms.AliquotaDeFcp;
  FAliquotaInternaEstadoDestino := FModelAbreviacaoIcms.AliquotaInternaEstadoDestino;
  FPerBasDifalOrigem            := FModelAbreviacaoIcms.PercentualBaseDifalOrigem;
  FPerBasDifalDestino           := FModelAbreviacaoIcms.PercentualBaseDifalDestino;

  If (FParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem > 0) Then
    FAliquotaFCPST := FAliquotaFCP;
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.PreencherRecordFcp;
begin
  FRecordDifalFCP.fltValFcp := FValorFCP;
  FRecordDifalFCP.fltPerFcp := FAliquotaFCP;
  FRecordDifalFCP.fltBasFcp := FBaseFCP;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ProdutoRevenda: Boolean;
begin
  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit(True);

  If (Not FParametros.ProdutoRevenda) Then
    Exit(False);

  Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ProdutoIndustrializadoDentroDoEstado: Boolean;
begin
  Result := False;

  If not pos(FModelEmpresa.EmpresaEstado, FEstadosQueCalculamFcpProprio_e_FcpSt) > 0 Then
    Exit;

  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_CONTRIBUINTE_IPI, varBoolean)) Then
    Exit;

  If (Not FParametros.ProdutoIndustrializado) Then
    Exit;

  If Not DentroDoEstado Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ProdutoRevendaDentroDoEstado: Boolean;
begin
  Result := False;

  If not pos(FModelEmpresa.EmpresaEstado, FEstadosQueCalculamFcpProprio_e_FcpSt) > 0 Then
    Exit;

  If (Not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, varBoolean)) Then
    Exit;

  If (Not FParametros.ProdutoImportacaoDireta) Then
    Exit;

  If (Not ProdutoRevenda) Then
    Exit;

  If Not (Pos(FParametros.ClassificacaoFiscalDoItem, '5403_5409_') > 0) Then
    Exit;

  If Not DentroDoEstado Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ProdutoST: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento
      .ProdutoSubstituidoFaturamento(FParametros.CodigoDaSubstituicaoTributariaDoItem)
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ZerarDifalNoResultadoCalculoFcpDifalFinal(const AResultadoClasseFcp: IResultadoClasseFcp):Boolean;
begin
  Result := False;

  If not AResultadoClasseFcp.ResultadoCalculoFcp.GravarOsRegistros Then
    Exit;

  If not AResultadoClasseFcp.ResultadoCalculoFcp.ZerarDifal Then
    Exit;

  Result := True;
end;


function TFaturamentoImpostosServicosClasseFcpDifal.ResultadoCalculoFcpDifalFinal(
  const AResultadoClasseFcp: IResultadoClasseFcp): IResultadoCalculoFcpDifalFinal;
begin
  FRecordDifalFCP := AResultadoClasseFcp.ResultadoCalculoFcp.RecordDifalFCP;
  FBaseDestino    := AResultadoClasseFcp.ResultadoCalculoFcp.BaseDestino;

  If ZerarDifalNoResultadoCalculoFcpDifalFinal(AResultadoClasseFcp) Then
    ZerarVariaveisDifal;

  If Not (AResultadoClasseFcp.ResultadoCalculoFcp.ValorFCP > 0) Then
    ZerarVariaveisFCP;

  Result :=
    TResultadoCalculoFcpDifalFinal.New
      .BaseDestino(FBaseDestino)
      .AliquotaFCP(AResultadoClasseFcp.ResultadoCalculoFcp.AliquotaDoFCPDoItem)
      .AliquotaInternaEstadoDestino(FAliquotaInternaEstadoDestino)
      .AlqInterestadualCalc(FAlqInterestadualCalc)
      .PercentualProvisorioPartilha(FPercentualProvisorioPartilha)
      .ValorFCP(AResultadoClasseFcp.ResultadoCalculoFcp.ValorFCP)
      .IcmsDestino(FIcmsDestino)
      .IcmsOrigem(FIcmsOrigem)
      .DevolucaoOuEntradaGarantia(FDevolucaoOuEntradaGarantia)
      .BaseFCP(AResultadoClasseFcp.ResultadoCalculoFcp.BaseFCP)
      .AliquotaFcpST(AResultadoClasseFcp.ResultadoCalculoFcp.AliquotaFCPST)
      .RecordDifalFCP(FRecordDifalFCP)
      .GravarOsRegistros(AResultadoClasseFcp.ResultadoCalculoFcp.GravarOsRegistros)
      .SairDoProcedimento(False);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ResultadoServicosClasseFcpDifalSairDoProcedimento: IResultadoServicosClasseFcpDifal;
begin
  Result :=
    TResultadoServicosClasseFcpDifal.New
      .ResultadoCalculoFcpDifalFinal(
         TResultadoCalculoFcpDifalFinal.New
           .SairDoProcedimento(True)
      );
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ResultadoCalculoFcpDifalFinal: IResultadoCalculoFcpDifalFinal;
begin
  If Not (FValorFCP > 0) Then
    ZerarVariaveisFCP;

  FGravarOsRegistros := True;

  If FProdutoEmbalagem = 'S' Then
  Begin
    FGravarOsRegistros := False;
    ZerarVariaveisFCP;
  End;

  FfltValorFCPFaturamentoConsignacao := 0;
  if TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarSTFaturamentoConsignacao(FParametros.ClassificacaoFiscalDoItem) then
  Begin
    FfltValorFCPFaturamentoConsignacao := FValorFCP;
    ZerarVariaveisFcp;
  End;

  Result :=
    TResultadoCalculoFcpDifalFinal.New
      .BaseDestino(FBaseDestino)
      .AliquotaFCP(FAliquotaFCP)
      .AliquotaInternaEstadoDestino(FAliquotaInternaEstadoDestino)
      .AlqInterestadualCalc(FAlqInterestadualCalc)
      .PercentualProvisorioPartilha(FPercentualProvisorioPartilha)
      .ValorFCP(FValorFCP)
      .IcmsDestino(FIcmsDestino)
      .IcmsOrigem(FIcmsOrigem)
      .DevolucaoOuEntradaGarantia(FDevolucaoOuEntradaGarantia)
      .BaseFCP(FBaseFCP)
      .AliquotaFcpST(FAliquotaFCPST)
      .RecordDifalFCP(FRecordDifalFCP)
      .GravarOsRegistros(FGravarOsRegistros)
      .SairDoProcedimento(False)
      .ValorCalculadoFCPSTConsignacao(FfltValorFCPFaturamentoConsignacao);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.CalcularValorDoDifal: IResultadoClasseDifal;
begin
  Result :=
    TServicosClasseDifal.New(
      TParametrosClasseDifal.New
        .ParametrosCalculoDifal(ParametrosCalculoDifal)
    ).CalcularDifalFinal;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ResultadoServicosClasseFcpDifal: IResultadoServicosClasseFcpDifal;
var
  LResultadoClasseDifal: IResultadoClasseDifal;
  LResultadoClasseDifalFcp: IResultadoClasseDifalFcp;
begin
  LResultadoClasseDifal := CalcularValorDoDifal;
  PreencherParametrosResultadoDifal(LResultadoClasseDifal);

  VerificarSeDeveZerarIcmsDestinoEOrigemDifalFcp;

  LResultadoClasseDifalFcp := CalcularValorDoDifalFcp;
  PreencherParametrosResultadoDifalFcp(LResultadoClasseDifalFcp);

  PreencherRecordFcp;

  ZerarVariaveisDifalEFcp;

  Result :=
    TResultadoServicosClasseFcpDifal.New
      .ResultadoCalculoDifal(LResultadoClasseDifal.ResultadoCalculoDifal)
      .ParametrosCalculoDifal(LResultadoClasseDifal.ParametrosCalculoDifal)
      .ResultadoCalculoDifalFcp(LResultadoClasseDifalFcp.ResultadoCalculoDifalFcp)
      .ParametrosCalculoDifalFcp(LResultadoClasseDifalFcp.ParametrosCalculoDifalFcp)
      .ResultadoCalculoFcpDifalFinal(ResultadoCalculoFcpDifalFinal);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ResultadoServicosClasseFcpDifalAliquotaInternaEstadoDestino: IResultadoServicosClasseFcpDifal;
begin
  Result :=
    TResultadoServicosClasseFcpDifal.New
      .ParametrosCalculoDifal(ParametrosCalculoDifal)
      .ParametrosCalculoDifalFcp(ParametrosCalculoDifalFcp)
      .ResultadoCalculoFcpDifalFinal(
         TResultadoCalculoFcpDifalFinal.New
           .ExibirMensagemAliquotaInternaEstadoDestino(True)
      );
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ResultadoServicosClasseFcpDifalDevolucao: IResultadoServicosClasseFcpDifal;
begin
  CarregarDifalFCPDocumentoDevolvido;
  PreencherRecordFcp;
  ZerarVariaveisDifalEFcp;

  Result :=
    TResultadoServicosClasseFcpDifal.New
      .ParametrosCalculoDifal(ParametrosCalculoDifal)
      .ParametrosCalculoDifalFcp(ParametrosCalculoDifalFcp)
      .ResultadoCalculoFcpDifalFinal(ResultadoCalculoFcpDifalFinal);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ResultadoServicosClasseFcpDifal(
  const AResultadoClasseFcp: IResultadoClasseFcp): IResultadoServicosClasseFcpDifal;
begin
  Result :=
    TResultadoServicosClasseFcpDifal.New
      .ResultadoCalculoFcp(AResultadoClasseFcp.ResultadoCalculoFcp)
      .ParametrosCalculoFcp(AResultadoClasseFcp.ParametrosCalculoFcp)
      .ParametrosCalculoDifal(ParametrosCalculoDifal)
      .ResultadoCalculoFcpDifalFinal(ResultadoCalculoFcpDifalFinal(AResultadoClasseFcp));
end;

function TFaturamentoImpostosServicosClasseFcpDifal.RetornarEstadoParaAbreviacao: String;
begin
  Result := FModelEmpresa.EmpresaEstado;

  If FParametros.VendaPresencial Then
    Exit;

  Result := RetornarTrocaUFEndEntrega;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.RetornarTrocaUFEndEntrega: String;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornarTrocaUFEndEntrega(FModelClienteFornecedor,
                                FParametros.CodigoDaEmpresa,
                                FParametros.OpcaoDeDocumento,
                                FDocumentoParaFornecedor);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.SairDoProcedimento: Boolean;
begin
  Result := False;

  If Not FParametros.VendaPresencial Then
    Exit;

  If Not FModelClienteFornecedor.ClienteExterior Then
    Exit;

  Result := True;
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.SetarModelAbreviacaoIcms;
var
  LParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  LParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
       .CodigoDoItem(FParametros.CodigoDoItemDaAbreviacaoFiscal)
       .CodigoDaAbreviacaoFiscal(FParametros.CodigoDaAbreviacaoFiscal)
       .Estado(RetornarEstadoParaAbreviacao)
       .CodigoDaEmpresaTE(FParametros.CodigoDaEmpresaTE)
       .CodigoDaEmpresa(FParametros.CodigoDaEmpresa)
       .CodigoDaEmpresaAbf(FParametros.CodigoDaEmpresaAbf)
       .TipoDaAbreviacaoFiscal(FParametros.TipoDaAbreviacaoFiscal)
       .CalculandoPrecoDeVendaComDifal(FParametros.CalculandoPrecoDeVendaComDifal);

  FModelAbreviacaoIcms :=
    TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(LParametros);
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.SetarModelClienteFornecedor;
begin
  If FDocumentoParaFornecedor Then
  Begin
    FModelClienteFornecedor :=
      TFaturamentoImpostosModelFornecedor.New.Consultar(FParametros.CodigoDoCliente);
    Exit;
  End;

  FModelClienteFornecedor :=
    TFaturamentoImpostosModelCliente.New.Consultar(FParametros.CodigoDoCliente,
                                                   FParametros.SequencialEnderecoEntrega,
                                                   FParametros.GerandoCasosTestes,
                                                   FParametros.ClienteConsumidorFinal,
                                                   FParametros.ParametrosClienteConsumidor);
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.SetarModelEmpresa;
begin
  FModelEmpresa := TFaturamentoImpostosModelEmpresa.New.Consultar(FParametros.CodigoDaEmpresa);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.TipoDeAbreviacaoDoCliente(
  ACodigoDoCliente, ACodigoDaEmpresa: String): String;
Var
  LParametros : IParametrosTipoDeAbreviacaoDoCliente;
begin
  LParametros :=
    TParametrosTipoDeAbreviacaoDoCliente.New
      .CodigoDoCliente(ACodigoDoCliente)
      .CodigoDaEmpresa(ACodigoDaEmpresa)
      .ClienteConsumidorFinal(FParametros.ClienteConsumidorFinal)
      .ClienteIndustria(FParametros.ClienteIndustria)
      .InscricaoEstadual(FModelClienteFornecedor.ClienteInscricaoEstadual)
      .ClienteFisicoOuJurico(FModelClienteFornecedor.ClienteFisJur)
      .CodigoDaEmpresaTransferencia(FModelClienteFornecedor.CodigoDaEmpresaTransferencia);

  Result :=
    TFaturamentoImpostosServicosFuncoes
      .TipoDeAbreviacaoDoCliente(LParametros);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.TipoDeAbreviacaoFiscalEmpresa: String;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornarTipoDeAbreviacaoNotaEspiritoSanto(FParametros.OpcaoDeItemNfEspiritoSanto,
                                                FParametros.TipoDaAbreviacaoFiscal);
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.VerificarSeDeveZerarIcmsDestinoEOrigemDifalFcp;
begin
  If (FIcmsDestino < 0) Then
    FIcmsDestino := 0;

  If (FIcmsOrigem < 0) Then
    FIcmsOrigem := 0;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ZerarValorDifal: Boolean;
begin
  Result :=
    TRegraImpostosZerarImpostosDifal.New
      .ZerarValorDoDifal(
        TParametrosRegraZerarImpostosDifal.New
          .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
          .ClienteOrgaoPublicoDifal(FModelClienteFornecedor.ClienteOrgaoPublicoDifal)
          .VendaPresencial(FParametros.VendaPresencial)
      );
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.ZerarVariaveisDifal;
begin
  FBaseDestino              := 0;
  FIcmsDestino              := 0;
  FIcmsOrigem               := 0;
  FAlqInterestadualCalc     := CalculaAliquotaInterestadual;
  FRecordDifalFCP.fltAlDifa := 0;
  FRecordDifalFCP.fltDifDes := 0;
  FRecordDifalFCP.fltDifOri := 0;
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.ZerarVariaveisDifalEFcp;
begin
  If ZerarDifal Then
    ZerarVariaveisDifal;

  If ZerarDifalFcp Then
    ZerarVariaveisFcp;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.fZeraVariaveisFCPST: Boolean;
begin
  Result := True;

  If DevolucaoInterestadualComProdutoSt Then
    Exit(False);

  If FSimplesNacional Then
    Exit(False);
end;

procedure TFaturamentoImpostosServicosClasseFcpDifal.ZerarVariaveisFcp;
begin
  FAliquotaFCP := 0;
  FValorFCP    := 0;
  FBaseFCP     := 0;

  If fZeraVariaveisFCPST Then
  Begin
    FRecordDifalFCP.fltValFcp := FValorFCP;
    FRecordDifalFCP.fltPerFcp := FAliquotaFCP;
    FRecordDifalFCP.fltBasFcp := FBaseFCP;
  End;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ZerarDifal: Boolean;
begin
  Result := True;

  If ZerarValorDifal Then
    Exit;

  If FIcmsDestino <= 0 Then
    Exit;

  If FProdutoEmbalagem = 'S' Then
    Exit;

  If (not FParametros.CalculaDifalParaCombustiveis_e_LubrificantesNaoTributados) And
     (Pos(RightStr(FParametros.CodigoDaSubstituicaoTributariaDoItem, 2), '30,60') > 0) Then
    Exit;

  Result := False;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ZerarFCP: Boolean;
begin
  Result :=
    TRegraImpostosZerarImpostosFcp.New
      .ZerarValorDoFcp(
        TParametrosRegraZerarImpostosFcp.New
          .ProdutoST(ProdutoST)
          .CodigoDaSubstituicaoTributariaDoItem(FParametros.CodigoDaSubstituicaoTributariaDoItem)
          .BaseDeCalculoDaSubstituicaoTributariaDoItem(FParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem)
          .ValorDaSubstituicaoTributariaDoItem(FParametros.ValorDaSubstituicaoTributariaDoItem)
          .EntregaFuturaDoItem(FParametros.EntregaFuturaDoItem)
          .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
          .EspecieDoDocumento(FParametros.EspecieDoDocumento)
          .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
          .ClienteOrgaoPublicoDifal(FModelClienteFornecedor.ClienteOrgaoPublicoDifal)
          .VendaPresencial(FParametros.VendaPresencial)
          .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
          .ValorDaSTDoItemNoFatuamentoConsignacao(FParametros.ValorDaSTDoItemNoFatuamentoConsignacao)
          .STAtribuidaPorRegimeEspecial(FParametros.STAtribuidaPorRegimeEspecial)
          .DentroDoEstado(DentroDoEstado)
      );
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ZerarDifalFcp: Boolean;
begin
  Result := True;

  If ZerarFCP Then
    Exit;

  If FValorFCP = 0 Then
    Exit;

  If FProdutoEmbalagem = 'S' Then
    Exit;

  Result := False;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.CalcularValorDoDifalFcp: IResultadoClasseDifalFcp;
begin
  Result :=
    TServicosClasseDifalFcp.New(
      TParametrosClasseDifalFcp.New
        .ParametrosCalculoDifalFCP(ParametrosCalculoDifalFcp)
    ).CalcularDifalFcp;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ZeraFcpDifal(AZeraFcp, ACfgSimplesNacional, ACfgDestinoPartilha: Boolean): Boolean;
begin
  Result := AZeraFcp;

  If not ACfgSimplesNacional Then
    Exit;

  If ACfgDestinoPartilha Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp;
Var
  LCfgRemetentePartilha : Boolean;
  LCfgDestinoPartilha   : Boolean;
  LCfgSimplesNacional   : Boolean;
  LZeraFCP: Boolean;
begin
  LCfgRemetentePartilha :=
    objConfiguracoes.
      fGetValorConfiguracao(CFG_OPTANTE_SIMPLES_NACIONAL_ENVIAR_ICMS_DIFAL_REMETENTE_PARTILHA, varBoolean);

  LCfgDestinoPartilha :=
    objConfiguracoes.
      fGetValorConfiguracao(CFG_OPTANTE_SIMPLES_NACIONAL_ENVIAR_ICMS_DIFAL_DESTINO_PARTILHA, varBoolean);

  LCfgSimplesNacional :=
    objConfiguracoes.
      fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, varBoolean);

  LZeraFCP := ZeraFcpDifal(ZerarFCP, LCfgSimplesNacional, LCfgDestinoPartilha);

  Result :=
    TParametrosCalculoDifalFCP.New
      .AliquotaFCPDoItem(FAliquotaFCP)
      .AliquotaDifalDoItem(FRecordDifalFCP.fltAlDifa)
      .SimplesNacional(LCfgSimplesNacional)
      .EnviarIcmsDifalDoRemetenteNaPartilha(LCfgRemetentePartilha)
      .EnviarIcmsDifalDoDestinoNaPartilha(LCfgDestinoPartilha)
      .IcmsDeOrigem(FIcmsOrigem)
      .IcmsDeDestino(FIcmsDestino)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(FParametros.BaseDeCalculoDaSubstituicaoTributariaDoItem)
      .BaseDestino(FBaseDestino)
      .ZerarFCP(LZeraFCP);
end;

function TFaturamentoImpostosServicosClasseFcpDifal.DevolucaoInterestadualComProdutoSt: Boolean;
begin
  Result := False;

  If DentroDoEstado Then
    Exit;

  If not (pos(FParametros.ClassificacaoFiscalDoItem, objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_DEVOLUCAO, varString)) > 0) Then
    Exit;

  If not ProdutoST Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosServicosClasseFcpDifal.CalculaFCPComReducaoBaseIcmsST: Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      fCalculaFCPComReducaoBaseIcmsST(FParametros.TipoDaAbreviacaoFiscal
                                     ,FParametros.CodigoDaSubstituicaoTributariaDoItem
                                     ,DentroDoEstado);
end;

end.
