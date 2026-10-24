unit untCalculoImpostoIPI;

interface

uses Shared.Functions.Core,
     Shared.Functions.Configuracoes,
     Shared.Functions.Types,
     Faturamento.Impostos.Interfaces.Model,
     Shared.Functions.Funcoes.Faturamento,
     Shared.Functions.DataSet,
     untConsultaModelFaturamento,
     untFuncFatTypes,
     untTypesIPI;

type
  TCalculoImpostoIPI = class
  private
    FCore: IFunctionsCore;
    FConfiguracoes: IConfiguracoes;
    FModelProduto: IResultadoFaturamentoImpostosModelProduto;
    FModelClienteFornecedor : IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
    FConsultaModel: IConsultaModelFaturamento;
    function DocumentoParaFornecedor(AParametros : TParametrosServicoIPI): Boolean;
    function RetornarValorIpi(Const AParametros: TParametrosCalculoIPI; Const AValorBaseIpi : Double): Double;
    procedure SetarValorFinalMatriz(AResultadoCalculoIPI: TResultadoCalculoIPI; var AMatItens: TMatrizFechamento; const APosicaoMatriz: Integer);
    function ZerarValorDoIpi(AParametros : TParametrosServicoIPI): Boolean;
    function ZerarResultadosIpi(Const AAliquotaIpi: double; AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
    function ZerarResultadosIpiZerandoAliquota(AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
    function ParametrosCalculoIPI(const AEstadoEntrega: String; const AValorBaseDoIpi: Double; const AValorDaAliquotaIpi: Double; const AVendaPresencial: Boolean): TParametrosCalculoIPI;
    function RetornarTrocaUFEndEntrega (AParametros : TParametrosServicoIPI) : String;
    procedure CarregarModels(AParametros : TParametrosServicoIPI);
    procedure SetarModelClienteFornecedor(AParametros : TParametrosServicoIPI);
    procedure SetarModelEmpresa(AParametros : TParametrosServicoIPI);
    procedure SetarModelProduto(AParametros : TParametrosServicoIPI);
    Function ZerarValorFinalDoIpi (AParametros : TParametrosServicoIPI) : Boolean;
    function ZerarResultadosIpiRetornandoAliquota(AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi; overload;
    function ZerarResultadosIpiRetornandoAliquotaSetandoIpiConsignado(const AValorCalculadoIPIConsignacao: double; AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
    function ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros : TParametrosServicoIPI): Boolean;
    function ZerarMeiaNotaParaDocumentosMIFF(AParametros : TParametrosServicoIPI): Boolean;
    function ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto(AParametros : TParametrosServicoIPI): Boolean;
    function ValorDaAliquotaDeCalculoIpi(AParametros : TParametrosServicoIPI): Double;
    function TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento : String; AConfirmandoNotaFiscalConcreto : Boolean; AItemConcreto: Boolean): Boolean;
    function ValidarConfirmacaoNotaFiscalConcreto(AParametros : TParametrosServicoIPI): Boolean;
    function EhItemConcreto(AParametros : TParametrosServicoIPI): Boolean;
    function RetornarClassificacaoDeVenda: String;
    function ZerarIpiMIFF(AParametros : TParametrosServicoIPI): Boolean;
    function ZerarEspecie(AParametros : TParametrosServicoIPI): String;
    function ValidarSeDeveRetornarAliquotaZero(AParametros : TParametrosServicoIPI): boolean;
    function RetornarEspecieDeDocumento(AParametros : TParametrosServicoIPI): String;
    function TemMIFFEntreOsDevolvidos(AParametros : TParametrosServicoIPI): Boolean;
    function EhClienteZonaFranca(AParametros: TParametrosCalculoIPI): Boolean;
    function CalculaIpiParaClienteZonaFranca(AParametros: TParametrosServicoIPI): Boolean;
    function CalcularValorIpi(AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi; overload;
    function CalcularValorIpiProduto(AParametros: TParametrosServicoIPI): TResultadoServicosClasseIpi; overload;
    function CalcularValorIpiFinal(AParametros: TParametrosServicoIPI): TResultadoServicosClasseIpi; overload;
  public
    function CalcularValorIPI(AParametros: TParametrosCalculoIPI): TResultadoCalculoIPI; overload;
    function CalcularValorIPI(AParametros: TParametrosCalculoValorIpi): TResultadoCalculoIPI; overload;
    function CalcularValorIpiFinal(var AMatItens: TMatrizFechamento; const APosicaoMatriz: Integer): Boolean; overload;
    procedure ZerarDadosIpi(const AZerarAliquota: boolean; var AMatItens: TMatrizFechamento; const APosicaoMatriz: Integer);
    constructor Create(ACore: IFunctionsCore; AConfiguracoes: IConfiguracoes; AConsultaModel: IConsultaModelFaturamento);
  end;

implementation

uses SysUtils,
     Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos,
     Shared.Functions.Faturamento.Impostos.Regras,
     Shared.Functions.Constantes,
     Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
     untFaturamentoImpostosFuncoes;

{ TCalculoImpostoIPI }

function TCalculoImpostoIPI.CalcularValorIPI(AParametros: TParametrosCalculoIPI): TResultadoCalculoIPI;
  Var
    LValorIPI : Double;
    LBaseIPI  : Double;
begin
  LBaseIPI := AParametros.BaseDoIpi;

  LValorIPI := RetornarValorIpi(AParametros, LBaseIPI);

  If EhClienteZonaFranca(AParametros) Then
    LValorIPI := 0;

  If (AParametros.SituacaoTributariaIPI <> IPITributado) Then
  Begin
    LValorIPI := 0;
    LBaseIPI  := 0;
  End;

  If AParametros.ClienteDoExterior Then
    LValorIPI := 0;

  If AParametros.AliquotaDeCalculoIPI <= 0 Then
  Begin
    LValorIPI := 0;
    LBaseIPI  := 0;
  End;

  FillChar(Result, SizeOf(Result), #0);
  Result.ValorCalculadoIPI := LValorIPI;
  Result.BaseDeCalculoIPI := LBaseIPI;
  Result.AliquotaDeCalculoIPI := AParametros.AliquotaDeCalculoIPI;
  Result.ValorCalculadoIPIConsignacao := LValorIPI;
end;

function TCalculoImpostoIPI.CalcularValorIPI(
  AParametros: TParametrosCalculoValorIpi): TResultadoCalculoIPI;
  var
    recParametrosServicoIPI : TParametrosServicoIPI;
begin
  FillChar(recParametrosServicoIPI, SizeOf(recParametrosServicoIPI), #0);
  recParametrosServicoIPI.CodigoDoCliente := AParametros.CodigoDoCliente;
  recParametrosServicoIPI.ClienteConsumidorFinal := AParametros.ClienteConsumidorFinal;
  recParametrosServicoIPI.CodigoDoProduto := AParametros.CodigoDoProduto;
  recParametrosServicoIPI.CodigoDaEmpresa := AParametros.CodigoDaEmpresa;
  recParametrosServicoIPI.ClassificacaoFiscalDoItem := '';
  recParametrosServicoIPI.VendaPresencial := false;
  recParametrosServicoIPI.EspecieDoDocumento := '';
  recParametrosServicoIPI.DesmembrarNotaProdutosServicos := false;
  recParametrosServicoIPI.OpcaoDoDocumento := '';
  recParametrosServicoIPI.OpcaoDeItemNfEspiritoSanto := opcVazio;
  recParametrosServicoIPI.DesmembrarMeiaNotaComNotaNormal := false;
  recParametrosServicoIPI.BaixaDeEntregaFutura := AParametros.BaixaDeEntregaFutura;
  recParametrosServicoIPI.EntregaFutura := false;
  recParametrosServicoIPI.MeiaNotaFatorExpedicao := false;
  recParametrosServicoIPI.TotalGeralDoItem := AParametros.TotalGeralDoItem;
  recParametrosServicoIPI.ValorFreteDoItem := 0;
  recParametrosServicoIPI.DespesaAcessoriaDoItem := 0;
  recParametrosServicoIPI.DescontoEspecial := 0;
  recParametrosServicoIPI.SequencialEnderecoEntrega := '';
  recParametrosServicoIPI.NotaComplementoFornecedor := false;
  recParametrosServicoIPI.NotaEspecialFornecedor := false;
  recParametrosServicoIPI.CodigoDoFornecedor := '';
  recParametrosServicoIPI.CodigoDaFazenda := '';
  FillChar(Result, SizeOf(Result), #0);
  Result := CalcularValorIpiProduto(recParametrosServicoIPI).ResultadoCalculoIPI;
end;

function TCalculoImpostoIPI.CalcularValorIpi(AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
Var
  LValorDaAliquotaIpi   : Double;
  LPercentualDaBase     : Double;
  LValorBaseDoIpi       : Double;
  LResultadoAbreviacao  : TResultadoAbreviacaoIpi;
  LParametrosCalculoIPI : TParametrosCalculoIPI;
  LResultadoCalculoIPI  : TResultadoCalculoIPI;
begin
  if (ZerarValorDoIpi(AParametros)) then
  Begin
    FillChar(Result, SizeOf(Result), #0);
    Result := ZerarResultadosIpiZerandoAliquota(AParametros);
    Exit;
  End;

  LResultadoAbreviacao :=
    TFaturamentoImpostosFuncoes.
      CarregarDadosIpi(AParametros.EspecieDoDocumento,
                       AParametros.ClassificacaoFiscalDoItem,
                       AParametros.CodigoDoProduto,
                       AParametros.CodigoDaEmpresa,
                       FModelProduto.IpiDeSaida,
                       FModelClienteFornecedor.SituacaoDoIpi);


  LValorDaAliquotaIpi := LResultadoAbreviacao.AliquotaDeCalculoIPI;
  LPercentualDaBase   := LResultadoAbreviacao.BaseDeCalculoIPI;

  LValorBaseDoIpi     := 0;

  If LValorDaAliquotaIpi > 0 Then
  begin
    LValorBaseDoIpi :=
          TFunctionFuncoesFaturamento.
            TotalGeralItem(AParametros.ClienteConsumidorFinal,
                           AParametros.DescontoEspecial,
                           AParametros.ValorFreteDoItem,
                           AParametros.TotalGeralDoItem,
                           AParametros.DespesaAcessoriaDoItem,
                           FModelClienteFornecedor.OrgaoPublico,
                           FModelClienteFornecedor.ZonaFranca,
                           TFaturamentoImpostosFuncoes.
                             VendaDentroDoEstado(RetornarTrocaUFEndEntrega(AParametros),
                                                 FModelEmpresa.EmpresaEstado,
                                                 AParametros.VendaPresencial),
                           AParametros.OpcaoDoDocumento,
                           false,
                           true,
                           false);
  end;


  If FConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, varBoolean) Then
  begin
    LValorBaseDoIpi := FCore.fFormataFloat(LValorBaseDoIpi * LPercentualDaBase / 100, 2);
  end;

  LParametrosCalculoIPI := ParametrosCalculoIPI(RetornarTrocaUFEndEntrega(AParametros), LValorBaseDoIpi, LValorDaAliquotaIpi, AParametros.VendaPresencial);

  FillChar(LResultadoCalculoIPI, SizeOf(LResultadoCalculoIPI), #0);
  LResultadoCalculoIPI := CalcularValorIPI(LParametrosCalculoIPI);

  FillChar(Result, SizeOf(Result), #0);
  Result.ResultadoCalculoIPI := LResultadoCalculoIPI;
  Result.ParametrosCalculoIPI := LParametrosCalculoIPI;
end;

function TCalculoImpostoIPI.CalcularValorIpiFinal(
  AParametros: TParametrosServicoIPI): TResultadoServicosClasseIpi;
begin
  CarregarModels(AParametros);
  FillChar(Result, SizeOf(Result), #0);

  If ZerarValorFinalDoIpi(AParametros) Then
  Begin
    Result := ZerarResultadosIpiRetornandoAliquota(AParametros);
    Exit;
  End;

  if TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarIpiFaturamentoConsignacao(AParametros.ClassificacaoFiscalDoItem) then
  begin
    Result := ZerarResultadosIpiRetornandoAliquotaSetandoIpiConsignado(CalcularValorIpi(AParametros).ResultadoCalculoIPI.ValorCalculadoIPI, AParametros);
    Exit;
  end;

  Result := CalcularValorIpi(AParametros);
end;

function TCalculoImpostoIPI.CalcularValorIpiFinal(var AMatItens: TMatrizFechamento; const APosicaoMatriz: Integer): Boolean;
var
  LResultadoServicosClasseIpi: TResultadoServicosClasseIpi;
  FParametrosIpi : TParametrosServicoIPI;
begin
  Result := True;
  FillChar(FParametrosIpi, SizeOf(FParametrosIpi), #0);
  FParametrosIpi.CodigoDoCliente := GetImpostosFatParametrosComum.CodigoDoCliente;
  FParametrosIpi.ClienteConsumidorFinal := GetImpostosFatParametrosComum.ClienteConsumidorFinal;
  FParametrosIpi.CodigoDoProduto := AMatItens[APosicaoMatriz].strCodIte;
  FParametrosIpi.CodigoDaEmpresa := GetImpostosFatParametrosComum.CodigoDaEmpresa;
  FParametrosIpi.SequencialEnderecoEntrega := GetImpostosFatParametrosComum.SequencialEnderecoEntrega;
  FParametrosIpi.ClassificacaoFiscalDoItem := AMatItens[APosicaoMatriz].strClaFis;
  FParametrosIpi.VendaPresencial := GetImpostosFatParametrosComum.VendaPresencial;
  FParametrosIpi.EspecieDoDocumento := GetImpostosFatParametrosComum.EspecieDoDocumento;
  FParametrosIpi.DesmembrarNotaProdutosServicos := GetImpostosFatParametrosComum.DesmembrarNotaProdutosServicos;
  FParametrosIpi.OpcaoDoDocumento := GetImpostosFatParametrosComum.OpcaoDoDocumento;
  FParametrosIpi.OpcaoDeItemNfEspiritoSanto := AMatItens[APosicaoMatriz].opcINFesp;
  FParametrosIpi.DesmembrarMeiaNotaComNotaNormal := GetImpostosFatParametrosComum.DesmembrarMeiaNotaComNotaNormal;
  FParametrosIpi.BaixaDeEntregaFutura := GetImpostosFatParametrosComum.BaixaDeEntregaFutura;
  FParametrosIpi.EntregaFutura := GetImpostosFatParametrosComum.EntregaFutura;
  FParametrosIpi.MeiaNotaFatorExpedicao := AMatItens[APosicaoMatriz].blnMeiaNotaFatorExpedicao;
  FParametrosIpi.TotalGeralDoItem := AMatItens[APosicaoMatriz].fltTotIte;
  FParametrosIpi.ValorFreteDoItem := AMatItens[APosicaoMatriz].fltValFre;
  FParametrosIpi.DespesaAcessoriaDoItem := AMatItens[APosicaoMatriz].fltDesAce;
  FParametrosIpi.DescontoEspecial := AMatItens[APosicaoMatriz].fltDesEsp;
  FParametrosIpi.NotaComplementoFornecedor := GetImpostosFatParametrosComum.NotaComplementoFornecedor;
  FParametrosIpi.NotaEspecialFornecedor := GetImpostosFatParametrosComum.NotaEspecialFornecedor;
  FParametrosIpi.CodigoDoFornecedor := GetImpostosFatParametrosComum.CodigoDoFornecedor;
  FParametrosIpi.EspecieDeDevolucao := AMatItens[APosicaoMatriz].strEspDev;
  FParametrosIpi.CodigoDaFazenda := GetImpostosFatParametrosComum.CodigoDaFazenda;

  If Assigned(GetImpostosFatParametrosComum.ParametrosClienteConsumidor) Then
  Begin
    FParametrosIpi.ParametrosClienteConsumidor.ClienteEstado := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteEstado;
    FParametrosIpi.ParametrosClienteConsumidor.ClienteFisicoOuJuridico := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteFisicoOuJuridico;
    FParametrosIpi.ParametrosClienteConsumidor.ClienteInscricaoEstadual := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteInscricaoEstadual;
    FParametrosIpi.ParametrosClienteConsumidor.ClienteAtividade := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.ClienteAtividade;
    FParametrosIpi.ParametrosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico;
    FParametrosIpi.ParametrosClienteConsumidor.CodigoDaEmpresaTransferencia := GetImpostosFatParametrosComum.ParametrosClienteConsumidor.CodigoDaEmpresaTransferencia;
  End;

  FParametrosIpi.TipoDeBaixaEntregaFutura := GetImpostosFatParametrosComum.TipoDeBaixaEntregaFutura;
  FParametrosIpi.OpcaoDoDocumentoVerdadeira := GetImpostosFatParametrosComum.OpcaoDoDocumentoVerdadeira;
  LResultadoServicosClasseIpi := CalcularValorIpiFinal(FParametrosIpi);
  SetarValorFinalMatriz(LResultadoServicosClasseIpi.ResultadoCalculoIPI, AMatItens, APosicaoMatriz);
end;

function TCalculoImpostoIPI.CalcularValorIpiProduto(AParametros: TParametrosServicoIPI): TResultadoServicosClasseIpi;
  Var
    LValorDaAliquotaIpi : Double;
    LValorBaseDoIpi     : Double;
    LParametrosCalculoIPI : TParametrosCalculoIPI;
    LResultadoCalculoIPI  : TResultadoCalculoIPI;
begin
  CarregarModels(AParametros);
  FillChar(Result, SizeOf(Result), #0);

  if (ZerarValorDoIpi(AParametros)) then
  Begin
    result := ZerarResultadosIpiZerandoAliquota(AParametros); // retornando um record!
    Exit;
  End;

  LValorDaAliquotaIpi := FModelProduto.IpiDeSaida;
  LValorBaseDoIpi     := AParametros.TotalGeralDoItem;

  LParametrosCalculoIPI :=
    ParametrosCalculoIPI(FModelClienteFornecedor.ClienteEstado, LValorBaseDoIpi, LValorDaAliquotaIpi, AParametros.VendaPresencial);

  FillChar(LResultadoCalculoIPI, SizeOf(LResultadoCalculoIPI), #0);
  LResultadoCalculoIPI := Self.CalcularValorIPI(LParametrosCalculoIPI);

  Result.ResultadoCalculoIPI := LResultadoCalculoIPI;
  Result.ParametrosCalculoIPI := LParametrosCalculoIPI;
end;

procedure TCalculoImpostoIPI.CarregarModels(AParametros : TParametrosServicoIPI);
begin
  SetarModelClienteFornecedor(AParametros);
  SetarModelEmpresa(AParametros);
  SetarModelProduto(AParametros);
end;

constructor TCalculoImpostoIPI.Create(ACore: IFunctionsCore; AConfiguracoes: IConfiguracoes; AConsultaModel: IConsultaModelFaturamento);
begin
  FCore := ACore;
  FConfiguracoes := AConfiguracoes;
  FConsultaModel := AConsultaModel;
end;

function TCalculoImpostoIPI.DocumentoParaFornecedor(AParametros : TParametrosServicoIPI): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      fDocumentoParaFornecedor(AParametros.OpcaoDoDocumento,
                               AParametros.NotaComplementoFornecedor,
                               AParametros.NotaEspecialFornecedor,
                               SameText(TFaturamentoImpostosFuncoes.RetornarNotaDeImportacao(AParametros.ClassificacaoFiscalDoItem), 'S'),
                               AParametros.CodigoDoCliente,
                               AParametros.CodigoDoFornecedor);
end;

Function TCalculoImpostoIPI.RetornarValorIpi(
 Const AParametros: TParametrosCalculoIPI; Const AValorBaseIpi : Double) : Double;
begin
  Result := FCore.fFormataFloat(AValorBaseIpi * AParametros.AliquotaDeCalculoIPI / 100, 2);
end;

procedure TCalculoImpostoIPI.SetarValorFinalMatriz(AResultadoCalculoIPI: TResultadoCalculoIPI; var AMatItens: TMatrizFechamento; const APosicaoMatriz: Integer);
begin
  AMatItens[APosicaoMatriz].fltValIpi := AResultadoCalculoIPI.ValorCalculadoIPI;
  AMatItens[APosicaoMatriz].fltBasIpi := AResultadoCalculoIPI.BaseDeCalculoIPI;
  AMatItens[APosicaoMatriz].fltAlqIpi := AResultadoCalculoIPI.AliquotaDeCalculoIPI;
  AMatItens[APosicaoMatriz].fltIpiCon := AResultadoCalculoIPI.ValorCalculadoIPIConsignacao;
end;

procedure TCalculoImpostoIPI.ZerarDadosIpi(const AZerarAliquota: boolean; var AMatItens: TMatrizFechamento; const APosicaoMatriz: Integer);
begin
  AMatItens[APosicaoMatriz].fltValIpi := 0;
  AMatItens[APosicaoMatriz].fltBasIpi := 0;
  if (not AZerarAliquota) then
    Exit;
  AMatItens[APosicaoMatriz].fltAlqIpi := 0;
end;

procedure TCalculoImpostoIPI.SetarModelClienteFornecedor(AParametros : TParametrosServicoIPI);
begin
  if DocumentoParaFornecedor(AParametros) Then
    FModelClienteFornecedor := FConsultaModel.ConsultarFornecedor(AParametros.CodigoDoCliente)
  else
    FModelClienteFornecedor := FConsultaModel.ConsultarCliente(AParametros.CodigoDoCliente, AParametros.SequencialEnderecoEntrega, AParametros.GerandoCasosTestes, AParametros.ClienteConsumidorFinal, AParametros.ParametrosClienteConsumidor, AParametros.CodigoDaFazenda);
end;

procedure TCalculoImpostoIPI.SetarModelEmpresa(AParametros : TParametrosServicoIPI);
begin
  FModelEmpresa := FConsultaModel.ConsultarEmpresa(AParametros.CodigoDaEmpresa);
end;

procedure TCalculoImpostoIPI.SetarModelProduto(AParametros : TParametrosServicoIPI);
begin
  FModelProduto := FConsultaModel.ConsultarProduto(AParametros.CodigoDoProduto, AParametros.CodigoDaEmpresa, '', EmptyStr, AParametros.GerandoCasosTestes);
end;

Function TCalculoImpostoIPI.ZerarValorFinalDoIpi(AParametros : TParametrosServicoIPI) : Boolean;
begin
  Result := True;

  if (ZerarValorDoIpi(AParametros)) then
    Exit;

  If ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros) Then
    Exit;

  If TFunctionsRegrasImpostosFaturamento.
    fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(AParametros.ClassificacaoFiscalDoItem) Then
  Begin
    Exit;
  End;

  If ZerarMeiaNotaParaDocumentosMIFF(AParametros) Then
    Exit;

  If ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto(AParametros) Then
    Exit;

  Result := false;
end;

function TCalculoImpostoIPI.ZerarResultadosIpiRetornandoAliquota(AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
var
  LAliquota: Double;
begin
  LAliquota := ValorDaAliquotaDeCalculoIpi(AParametros);
  FillChar(Result, SizeOf(Result), #0);
  Result := ZerarResultadosIpi(LAliquota, AParametros);
end;

function TCalculoImpostoIPI.ZerarResultadosIpiRetornandoAliquotaSetandoIpiConsignado(const AValorCalculadoIPIConsignacao: double; AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result := ZerarResultadosIpiRetornandoAliquota(AParametros);
  Result.ResultadoCalculoIPI.ValorCalculadoIPIConsignacao := AValorCalculadoIPIConsignacao;
end;

function TCalculoImpostoIPI.ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros : TParametrosServicoIPI): Boolean;
Var
  LTaxaBombeamentoPedOrc: Boolean;
begin
  Result := false;

  LTaxaBombeamentoPedOrc :=
    TaxaBombeamentoPedidoOrcamento(AParametros.OpcaoDoDocumento,
                                   ValidarConfirmacaoNotaFiscalConcreto(AParametros),
                                   EhItemConcreto(AParametros));

  If CalculaIpiParaClienteZonaFranca(AParametros) Then
  Begin
    Exit;
  End;

  If Not TFunctionsZerarImpostosRegrasImpostosFaturamento.
            fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(AParametros.ClassificacaoFiscalDoItem,
                                                         AParametros.OpcaoDoDocumento,
                                                         LTaxaBombeamentoPedOrc,
                                                         AParametros.ClassificacaoFiscalDoItem,
                                                         AParametros.OpcaoDeItemNfEspiritoSanto,
                                                         RetornarClassificacaoDeVenda,
                                                         FModelClienteFornecedor.ClienteEstado,
                                                         FModelClienteFornecedor.ZonaFranca,
                                                         TFaturamentoImpostosFuncoes.VendaDentroDoEstado(RetornarTrocaUFEndEntrega(AParametros),
                                                                                                                 FModelEmpresa.EmpresaEstado,
                                                                                                                 AParametros.VendaPresencial)) Then
  Begin
    Exit;
  End;

  Result := true;
end;

function TCalculoImpostoIPI.ZerarMeiaNotaParaDocumentosMIFF(AParametros : TParametrosServicoIPI): Boolean;
begin
  Result := False;

  If Not TFunctionsZerarImpostosRegrasImpostosFaturamento.DesmembrarMeiaNotaComNotaNormalFatorExpedicao(
    AParametros.DesmembrarMeiaNotaComNotaNormal, AParametros.EspecieDoDocumento, AParametros.MeiaNotaFatorExpedicao) Then
    Exit;

  If Not ZerarIpiMIFF(AParametros) Then
    Exit;

  Result := true;
end;

function TCalculoImpostoIPI.ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto(AParametros : TParametrosServicoIPI): Boolean;
begin
  Result := false;

  If Not TFunctionsRegrasImpostosFaturamento.
           IsentaImpostosEspeciesZerarBaixaEntregaFuturaVendaItemConcreto(AParametros.EspecieDoDocumento,
                                                                          ZerarEspecie(AParametros),
                                                                          AParametros.OpcaoDoDocumento,
                                                                          FModelClienteFornecedor.OrgaoPublico ,
                                                                          FModelClienteFornecedor.ZonaFranca,
                                                                          AParametros.BaixaDeEntregaFutura,
                                                                          AParametros.EntregaFutura ,
                                                                          EhItemConcreto(AParametros),
                                                                          AParametros.DesmembrarNotaProdutosServicos)then
  Begin
    Exit;
  End;

  If Not ZerarIpiMIFF(AParametros) Then
    Exit;

  Result := true;
end;

function TCalculoImpostoIPI.ValorDaAliquotaDeCalculoIpi(AParametros : TParametrosServicoIPI): Double;
begin
  result := 0;

  if (ValidarSeDeveRetornarAliquotaZero(AParametros)) then
    Exit;

  Result :=
    TFaturamentoImpostosFuncoes.
      CarregarDadosIpi(AParametros.EspecieDoDocumento,
                       AParametros.ClassificacaoFiscalDoItem,
                       AParametros.CodigoDoProduto,
                       AParametros.CodigoDaEmpresa,
                       FModelProduto.IpiDeSaida,
                       FModelClienteFornecedor.SituacaoDoIpi).AliquotaDeCalculoIPI;
end;

function TCalculoImpostoIPI.TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento              : String;
                                                            AConfirmandoNotaFiscalConcreto : Boolean;
                                                            AItemConcreto                  : Boolean): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
       TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento, AConfirmandoNotaFiscalConcreto, AItemConcreto);
end;

function TCalculoImpostoIPI.ValidarConfirmacaoNotaFiscalConcreto(AParametros : TParametrosServicoIPI): Boolean;
begin
  Result := TFunctionFuncoesFaturamento.
              ValidarConfirmacaoNotaFiscalConcreto(EhItemConcreto(AParametros),
                                                   AParametros.DesmembrarNotaProdutosServicos,
                                                   AParametros.OpcaoDoDocumento);
end;

function TCalculoImpostoIPI.EhItemConcreto(AParametros : TParametrosServicoIPI): Boolean;
Var
  LEhItemEstrutura : Boolean;
  LCount           : IMyCampoTabela;
  LItemConcreto    : Boolean;
  LSimplesRemessaConcretoDadosCliente : Boolean;
begin
  LCount :=
    FCore.fCampoTabela(['COUNT(*)'], 'GERMAT', ['GMT_CODITE'], [AParametros.CodigoDoProduto], False);

  LEhItemEstrutura :=
    TFunctionFuncoesFaturamento.
      fItemEstrutura(LCount.FieldByName('COUNT(*)'));

  LItemConcreto :=
    TFunctionFuncoesFaturamento.
      fItemConcreto(LEhItemEstrutura, '' , FModelProduto.ItemConcreto);

  LSimplesRemessaConcretoDadosCliente :=
    (FConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = CONCREMASSA);

  Result :=
    TFunctionFuncoesFaturamento.
      fEhItemConcreto( LSimplesRemessaConcretoDadosCliente,
                       LItemConcreto);
end;

function TCalculoImpostoIPI.RetornarClassificacaoDeVenda: String;
Var
  LCfgClassificacaoVenda : String;
begin
  LCfgClassificacaoVenda := FConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA );

  Result := TFunctionFuncoesFaturamento.Transform(LCfgClassificacaoVenda, 4);
end;

function TCalculoImpostoIPI.ZerarIpiMIFF(AParametros : TParametrosServicoIPI): Boolean;
begin
  Result := TFunctionFuncoesFaturamento.ZerarIpi(RetornarEspecieDeDocumento(AParametros),
                                                 TemMIFFEntreOsDevolvidos(AParametros),
                                                 AParametros.OpcaoDoDocumento,
                                                 AParametros.TipoDePedidoFaturamento,
                                                 AParametros.BaixaDeEntregaFutura,
                                                 AParametros.TipoDeBaixaEntregaFutura,
                                                 AParametros.OpcaoDoDocumentoVerdadeira);
end;

function TCalculoImpostoIPI.ZerarEspecie(AParametros : TParametrosServicoIPI): String;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      IsentaImpostosEspeciesZerar(AParametros.DesmembrarMeiaNotaComNotaNormal);
end;

function TCalculoImpostoIPI.ValidarSeDeveRetornarAliquotaZero(AParametros : TParametrosServicoIPI): boolean;
begin
  result := False;

  if (not AParametros.BaixaDeEntregaFutura) then
    Exit;

  if not FConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, varBoolean) then
    Exit;

  result := True;
end;

function TCalculoImpostoIPI.RetornarEspecieDeDocumento(AParametros : TParametrosServicoIPI): String;
begin
  Result := AParametros.EspecieDoDocumento;

  if Not (Result = EmptyStr) Then
    Exit;

  Result := AParametros.OpcaoDoDocumento;
end;

function TCalculoImpostoIPI.TemMIFFEntreOsDevolvidos(AParametros : TParametrosServicoIPI): Boolean;
begin
  Result := true;

  If TFunctionFuncoesFaturamento.ValidarDocumentosMIFF(AParametros.EspecieDeDevolucao) Then
    Exit;

  Result := False;;
end;

function TCalculoImpostoIPI.ZerarValorDoIpi(AParametros : TParametrosServicoIPI): Boolean;
begin
  Result := False;

  If Not AParametros.BaixaDeEntregaFutura Then
    Exit;

  {******************************************************}
  {* CFG_ENFUOP no momento da emissão da entrega futura *}
  {*REQ.144458****************************************RP*}
  If AParametros.TipoDeBaixaEntregaFutura = '2' Then
    Exit;

  Result := True;
end;

function TCalculoImpostoIPI.ZerarResultadosIpi(Const AAliquotaIpi: double; AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
var
  LResultadoCalculoIPI  : TResultadoCalculoIPI;
  LParametrosCalculoIPI : TParametrosCalculoIPI;
begin
  FillChar(Result, SizeOf(Result), #0);
  LParametrosCalculoIPI := ParametrosCalculoIPI(RetornarTrocaUFEndEntrega(AParametros), 0, AAliquotaIpi, AParametros.VendaPresencial);

  FillChar(LResultadoCalculoIPI, SizeOf(LResultadoCalculoIPI), #0);
  LResultadoCalculoIPI.ValorCalculadoIPI := 0;
  LResultadoCalculoIPI.BaseDeCalculoIPI := 0;
  LResultadoCalculoIPI.AliquotaDeCalculoIPI := AAliquotaIpi;
  LResultadoCalculoIPI.ValorCalculadoIPIConsignacao := 0;

  Result.ResultadoCalculoIPI := LResultadoCalculoIPI;
  Result.ParametrosCalculoIPI := LParametrosCalculoIPI;
end;

function TCalculoImpostoIPI.ZerarResultadosIpiZerandoAliquota(AParametros : TParametrosServicoIPI): TResultadoServicosClasseIpi;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result := ZerarResultadosIpi(0, AParametros);
end;

function TCalculoImpostoIPI.ParametrosCalculoIPI(const AEstadoEntrega: String; const AValorBaseDoIpi: Double; const AValorDaAliquotaIpi: Double; const AVendaPresencial: Boolean): TParametrosCalculoIPI;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.ClienteZonaFranca := FModelClienteFornecedor.ZonaFranca;
  Result.ClienteOrgaoPublico := FModelClienteFornecedor.OrgaoPublico;
  Result.ClienteDoExterior := FModelClienteFornecedor.ClienteExterior;
  Result.VendaDentroDoEstado := TFaturamentoImpostosFuncoes.VendaDentroDoEstado(AEstadoEntrega, FModelEmpresa.EmpresaEstado, AVendaPresencial);
  Result.SituacaoTributariaIPI := FModelClienteFornecedor.SituacaoDoIpi;
  Result.BaseDoIpi := AValorBaseDoIpi;
  Result.AliquotaDeCalculoIPI := AValorDaAliquotaIpi;
end;

function TCalculoImpostoIPI.RetornarTrocaUFEndEntrega(AParametros : TParametrosServicoIPI) : String;
begin
  Result :=
    TFaturamentoImpostosFuncoes.
      RetornarTrocaUFEndEntrega(FModelClienteFornecedor,
                                AParametros.CodigoDaEmpresa,
                                AParametros.OpcaoDoDocumento,
                                DocumentoParaFornecedor(AParametros));
end;

function TCalculoImpostoIPI.EhClienteZonaFranca(AParametros: TParametrosCalculoIPI): Boolean;
begin
  Result := AParametros.ClienteZonaFranca;

  If not Result Then
    Exit;

  if not FConfiguracoes.fGetValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, varBoolean) then
    Exit;

  If not TFunctionFuncoesFaturamento.fEhIbgeRegraZonaFranca(FModelEmpresa.EmpresaIbge) Then
    Exit;

  Result := False;
end;

function TCalculoImpostoIPI.CalculaIpiParaClienteZonaFranca(AParametros: TParametrosServicoIPI): Boolean;
begin
  Result := False;

  if not FConfiguracoes.fGetValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, varBoolean) then
    Exit;

  Result := TFunctionFuncoesFaturamento.fCalculaIpiParaClienteZonaFranca(FModelEmpresa.EmpresaIbge,
                                                                         FModelClienteFornecedor.ClienteIbgeEntrega,
                                                                         FModelClienteFornecedor.Suframa,
                                                                         FModelClienteFornecedor.ZonaFranca,
                                                                         AParametros.VendaPresencial);
end;

end.
