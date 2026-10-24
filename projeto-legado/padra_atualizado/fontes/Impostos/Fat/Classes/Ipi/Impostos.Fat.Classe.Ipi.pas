unit Impostos.Fat.Classe.Ipi;


interface

Uses
  System.SysUtils,
  Shared.Functions.Constantes,
  Shared.Functions.Types,
  untFatCalcularImpostos, Uni,
  Faturamento.Impostos.Interfaces.Ipi,
  Faturamento.Impostos.Tipos.Ipi,
  Impostos.Fat.Classe.Interfaces.Ipi,
  Impostos.Fat.Parametros.Interfaces.Ipi,
  Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Configuracoes,
  Impostos.Fat.Connections.Functions,
  Impostos.Fat.Model.Cliente,
  Impostos.Fat.Model.Empresa,
  Impostos.Fat.Model.Produto,
  Impostos.Fat.Model.Cliente.Interfaces,
  Impostos.Fat.Model.Empresa.Interfaces,
  Impostos.Fat.Model.Produto.Interfaces,
  Shared.Functions.Faturamento.Impostos.Regras,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos;

Type
  IResultadoAbreviacaoIpi = interface
    ['{E3EE02A3-E122-4216-B60D-FFA8E119165E}']
    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;
  end;

Type
  TResultadoAbreviacaoIpi =  class(TInterfacedObject, IResultadoAbreviacaoIpi)
  private
    FBaseDeCalculoIPI    : Double;
    FAliquotaDeCalculoIPI: Double;
  public
    function BaseDeCalculoIPI: Double; overload;
    function BaseDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;

    function AliquotaDeCalculoIPI: Double; overload;
    function AliquotaDeCalculoIPI(AValue: Double): IResultadoAbreviacaoIpi; overload;

    class function New(): IResultadoAbreviacaoIpi;
  end;

Type
  TImpostosFatClasseIpi = class(TInterfacedObject, IImpostosFatClasseIpi)
  Private
    FParametros                       : IImpostosFatParametrosIpi;
    FResultadoImpostosFatModelCliente : IResultadoImpostosFatModelCliente;
    FResultadoImpostosFatModelEmpresa : IResultadoImpostosFatModelEmpresa;
    FResultadoImpostosFatModelProduto : IResultadoImpostosFatModelProduto;

    procedure SetarModelCliente;
    procedure SetarModelEmpresa;
    procedure SetarModelProduto;

    function RetornarClassificacaoDeVenda : String ;
    Function ValidarConfirmacaoNotaFiscalConcreto : Boolean;
    Function TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento : String ; AConfirmandoNotaFiscalConcreto : Boolean) : Boolean;
    Function EhItemConcreto: Boolean;
    Function ZerarEspecie : String;
    Function TemMIFFEntreOsDevolvidos : Boolean;
    Function RetornarEspecieDeDocumento : String;
    Function ZerarIpiMIFF : Boolean;
    Function ZerarValorFinalDoIpi : Boolean;
    function ZerarMeiaNotaParaDocumentosMIFF : Boolean;
    function ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto : Boolean;
    function ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota : Boolean;
  public
    function CalcularValorDoIpi: IResultadoCalculoIPI;
    function CalcularValorDoIpiFinal: IResultadoCalculoIPI;
    Function VendaDentroDoEstado : Boolean;
    Function ValorDoIpiAbreviacao : IResultadoAbreviacaoIpi;
    Function ValorIpiSaida : IResultadoAbreviacaoIpi;

    class function New(AParametros: IImpostosFatParametrosIpi): IImpostosFatClasseIpi;

    constructor Create(AParametros: IImpostosFatParametrosIpi); overload;
  end;


implementation

function TImpostosFatClasseIpi.CalcularValorDoIpi : IResultadoCalculoIPI;
Var
  LValorDaAliquotaIpi : Double;
  LPercentualDaBase   : Double;
  LValorBaseDoIpi     : Double;
  LResultadoAbreviacao: IResultadoAbreviacaoIpi;
begin
  LResultadoAbreviacao := ValorIpiSaida;
  LValorDaAliquotaIpi  := LResultadoAbreviacao.AliquotaDeCalculoIPI;
  LPercentualDaBase    := LResultadoAbreviacao.BaseDeCalculoIPI;

  LValorBaseDoIpi      := 0;

  If FParametros.AliquotaDeCalculoIPI > 0 Then
  begin
    LValorBaseDoIpi :=
          TFunctionFuncoesFaturamento.
            TotalGeralItem(FResultadoImpostosFatModelCliente.ClienteConsumidor,
                           FParametros.DescontoEspecial,
                           FParametros.ValorFreteDoItem,
                           FParametros.TotalGeralDoItem,
                           FParametros.DespesaAcessoriaDoItem,
                           FResultadoImpostosFatModelCliente.OrgaoPublico,
                           FResultadoImpostosFatModelCliente.ZonaFranca,
                           VendaDentroDoEstado,
                           FParametros.OpcaoDoDocumento,
                           false,
                           true);
  end;

  Result :=
    CalcularValorIPI(
      TParametrosCalculoIPI.New()
        .ClienteConsumidor(FResultadoImpostosFatModelCliente.ClienteConsumidor)
        .OpcaoDeDocumento(FParametros.OpcaoDoDocumento)
        .ClienteZonaFranca(FResultadoImpostosFatModelCliente.ZonaFranca)
        .ClienteOrgaoPublico(FResultadoImpostosFatModelCliente.OrgaoPublico)
        .ClienteDoExterior(FResultadoImpostosFatModelCliente.ClienteExterior)
        .VendaDentroDoEstado(VendaDentroDoEstado)
        .SituacaoTributariaIPI(FResultadoImpostosFatModelCliente.SituacaoDoIpi)
        .PercentualDaBase(LPercentualDaBase)
        .BaseDoIpi(LValorBaseDoIpi)
        .AliquotaDeCalculoIPI(LValorDaAliquotaIpi)
     );
end;

function TImpostosFatClasseIpi.CalcularValorDoIpiFinal: IResultadoCalculoIPI;
begin
  If ZerarValorFinalDoIpi Then
  Begin
    Result :=
      TResultadoCalculoIPI.New()
        .ValorCalculadoIPI(0)
        .BaseDeCalculoIPI(0)
        .AliquotaDeCalculoIPI(FParametros.AliquotaDeCalculoIPI);

    Exit;
  End;

  Result := CalcularValorDoIpi;

end;


constructor TImpostosFatClasseIpi.Create(AParametros: IImpostosFatParametrosIpi);
begin
  FParametros := AParametros;

  SetarModelCliente;
  SetarModelEmpresa;
  SetarModelProduto;
end;

function TImpostosFatClasseIpi.EhItemConcreto: Boolean;
Var
  LEhItemEstrutura : Boolean;
  LProdutoConcreto : String;
  LCount           : Integer;
  LItemConcreto    : Boolean;
  LSimplesRemessaConcretoDadosCliente : Boolean;
begin

  LCount :=
    fCampoTabelaFat('COUNT(*)', 'GERMAT', ['GMT_CODITE'], [FParametros.CodigoDoProduto], False);

  LEhItemEstrutura :=
    TFunctionFuncoesFaturamento.
      fItemEstrutura(LCount);

  LProdutoConcreto :=
    fCampoTabelaFat('ITE_ITECCR', 'CADITE', ['ITE_CODITE'], [FParametros.CodigoDoProduto]);

  LItemConcreto :=
    TFunctionFuncoesFaturamento.
      fItemConcreto(LEhItemEstrutura, '' , LProdutoConcreto);

  LSimplesRemessaConcretoDadosCliente :=
    (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = CONCREMASSA);

  Result :=
    TFunctionFuncoesFaturamento.
      fEhItemConcreto( LSimplesRemessaConcretoDadosCliente,
                       LItemConcreto);
end;

class function TImpostosFatClasseIpi.New(AParametros: IImpostosFatParametrosIpi): IImpostosFatClasseIpi;
begin
  Result := Self.Create(AParametros);
end;

function TImpostosFatClasseIpi.RetornarClassificacaoDeVenda: String;
Var
  LCfgClassificacaoVenda : String;
begin
  LCfgClassificacaoVenda := objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA );

  Result := TFunctionFuncoesFaturamento.Transform(LCfgClassificacaoVenda, 4);
end;

function TImpostosFatClasseIpi.RetornarEspecieDeDocumento: String;
begin
  Result := FParametros.EspecieDoDocumento;

  if Not (Result = EmptyStr) Then
    Exit;

  Result := FParametros.OpcaoDoDocumento;
end;

procedure TImpostosFatClasseIpi.SetarModelCliente;
begin
  FResultadoImpostosFatModelCliente :=
    TImpostosFatModelCliente.New.Consultar(FParametros.CodigoDoCliente);
end;

procedure TImpostosFatClasseIpi.SetarModelEmpresa;
begin
  FResultadoImpostosFatModelEmpresa :=
    TImpostosFatModelEmpresa.New.Consultar(FParametros.CodigoDaEmpresa);
end;

procedure TImpostosFatClasseIpi.SetarModelProduto;
begin
  FResultadoImpostosFatModelProduto :=
    TImpostosFatModelProduto.New.Consultar(FParametros.CodigoDoProduto, FParametros.CodigoDaEmpresa);
end;

function TImpostosFatClasseIpi.TaxaBombeamentoPedidoOrcamento(
  AOpcaoDeDocumento: String; AConfirmandoNotaFiscalConcreto: Boolean): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
       TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento, AConfirmandoNotaFiscalConcreto);
end;

function TImpostosFatClasseIpi.TemMIFFEntreOsDevolvidos: Boolean;
begin
  Result := true;

  If TFunctionFuncoesFaturamento.ValidarDocumentosMIFF(FParametros.EspecieDeDevolucao) Then
    Exit;

  Result := False;;
end;

function TImpostosFatClasseIpi.ValorIpiSaida: IResultadoAbreviacaoIpi;
Var
  LAliquotaDeCalculoIPI : Double;
  LBaseDeCalculoIpi     : Double;
  LResultadoAbreviacao  : IResultadoAbreviacaoIpi;
begin
  LAliquotaDeCalculoIPI := 0;
  LBaseDeCalculoIpi     := 0;

  If TFunctionFuncoesFaturamento.ValidarIpiSaida(FParametros.EspecieDoDocumento) Then
    LAliquotaDeCalculoIPI := FResultadoImpostosFatModelProduto.IpiDeSaida
  Else
  Begin
    If TFunctionFuncoesFaturamento.ValidarSituacaoDoIpi(FResultadoImpostosFatModelCliente.SituacaoDoIpi) = Integer(sitTributado) Then
    begin
      LResultadoAbreviacao  := ValorDoIpiAbreviacao;
      LAliquotaDeCalculoIPI := LResultadoAbreviacao.AliquotaDeCalculoIPI;;
      LBaseDeCalculoIpi     := LResultadoAbreviacao.BaseDeCalculoIPI;
    end;

  End;

  Result :=
      TResultadoAbreviacaoIpi.New
        .BaseDeCalculoIPI(LBaseDeCalculoIpi)
        .AliquotaDeCalculoIPI(LAliquotaDeCalculoIPI);
end;


function TImpostosFatClasseIpi.ValidarConfirmacaoNotaFiscalConcreto: Boolean;
begin
  Result := TFunctionFuncoesFaturamento.
              ValidarConfirmacaoNotaFiscalConcreto(EhItemConcreto,
                                                   FParametros.DesmembrarNotaProdutosServicos);
end;

Function TImpostosFatClasseIpi.ValorDoIpiAbreviacao: IResultadoAbreviacaoIpi;
  Var
    qryAbf : TUniQuery;
    strSQL : String;
begin
  qryAbf := fCriaQueryFat(Nil);

  Try
    strSQL :=
      TFunctionFuncoesFaturamento.
        GetSelectAbreviacaoIpi(FParametros.ClassificacaoFiscalDoItem);

    qryAbf.SQL.Add(strSQL);

    qryAbf.ParamByName('CODITE').AsString := FParametros.CodigoDoProduto;

    If objConfiguracoes.fGetValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI) = '2' Then
      qryAbf.ParamByName('CODEMP').AsString := FParametros.CodigoDaEmpresa;

    qryAbf.ParamByName('CFOP').AsString := FParametros.ClassificacaoFiscalDoItem;
    qryAbf.Open;

    Result :=
      TResultadoAbreviacaoIpi.New
        .BaseDeCalculoIPI(qryAbf.FieldByName('BASE').AsFloat)
        .AliquotaDeCalculoIPI(qryAbf.FieldByName('ALQ').AsFloat);
  Finally
    FreeAndNil(qryAbf);
  End;
end;



function TImpostosFatClasseIpi.VendaDentroDoEstado: Boolean;
Var
  LDentroDoEstado : Boolean;
begin

  LDentroDoEstado :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstado(FResultadoImpostosFatModelCliente.ClienteEstado,
                      FResultadoImpostosFatModelEmpresa.EmpresaEstado);

  Result :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstadoFaturamento(LDentroDoEstado,
                                 FParametros.VendaPresencial);
end;

function TImpostosFatClasseIpi.ZerarEspecie : String;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      IsentaImpostosEspeciesZerar(FParametros.DesmembrarMeiaNotaComNotaNormal);
end;

function TImpostosFatClasseIpi.ZerarIpiMIFF : Boolean;
begin
  Result := true;

  If TFunctionFuncoesFaturamento.
    ZerarIpi(RetornarEspecieDeDocumento, TemMIFFEntreOsDevolvidos) Then
  Begin
    Exit;
  End;

  Result := False;
end;

function TImpostosFatClasseIpi.ZerarValorFinalDoIpi: Boolean;
begin
  Result := True;

  If ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota Then
    Exit;

  If TFunctionsRegrasImpostosFaturamento.
    fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(FParametros.ClassificacaoFiscalDoItem) Then
  Begin
    Exit;
  End;

  if ZerarMeiaNotaParaDocumentosMIFF Then
    Exit;

  If ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto Then
    Exit;

  Result := false;
end;


Function TImpostosFatClasseIpi.ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota : Boolean;
Var
  LTaxaBombeamentoPedOrc: Boolean;
begin
  Result := false;

  LTaxaBombeamentoPedOrc :=
    TaxaBombeamentoPedidoOrcamento(FParametros.OpcaoDoDocumento,
                                   ValidarConfirmacaoNotaFiscalConcreto);

  If Not TFunctionsZerarImpostosRegrasImpostosFaturamento.
            fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(FParametros.ClassificacaoFiscalDoItem,
                                                         FParametros.OpcaoDoDocumento,
                                                         LTaxaBombeamentoPedOrc,
                                                         FParametros.ClassificacaoFiscalDoItem,
                                                         FParametros.OpcaoDeItemNfEspiritoSanto,
                                                         RetornarClassificacaoDeVenda,
                                                         FResultadoImpostosFatModelCliente.ClienteEstado,
                                                         FResultadoImpostosFatModelCliente.ZonaFranca) Then
  Begin
    Exit;
  End;

  Result := true;
end;

Function TImpostosFatClasseIpi.ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto : Boolean;
begin
  Result := false;

  If Not TFunctionsRegrasImpostosFaturamento.
           IsentaImpostosEspeciesZerarBaixaEntregaFuturaVendaItemConcreto(FParametros.EspecieDoDocumento,
                                                                          ZerarEspecie,
                                                                          FParametros.OpcaoDoDocumento,
                                                                          FResultadoImpostosFatModelCliente.OrgaoPublico ,
                                                                          FResultadoImpostosFatModelCliente.ZonaFranca,
                                                                          FParametros.BaixaDeEntregaFutura,
                                                                          FParametros.EntregaFutura ,
                                                                          EhItemConcreto,
                                                                          FParametros.DesmembrarNotaProdutosServicos)then
  begin
    Exit;
  end;


  If Not ZerarIpiMIFF Then
    Exit;

  Result := true;
end;



Function TImpostosFatClasseIpi.ZerarMeiaNotaParaDocumentosMIFF : Boolean;
begin
  Result := False;

  If Not FParametros.DesmembrarMeiaNotaComNotaNormal Then
    Exit;

  if Not TFunctionFuncoesFaturamento.
    ValidarDocumentosMIFF(FParametros.EspecieDoDocumento) Then
  Begin
    Exit;
  End;

  If Not FParametros.MeiaNotaFatorExpedicao Then
    Exit;

  If Not ZerarIpiMIFF Then
    Exit;

  Result := true;
end;

{ TResultadoAbreviacaoIpi }

function TResultadoAbreviacaoIpi.AliquotaDeCalculoIPI: Double;
begin
  Result := FAliquotaDeCalculoIPI;
end;

function TResultadoAbreviacaoIpi.AliquotaDeCalculoIPI(
  AValue: Double): IResultadoAbreviacaoIpi;
begin
  Result := Self;
  FAliquotaDeCalculoIPI := AValue;
end;

function TResultadoAbreviacaoIpi.BaseDeCalculoIPI: Double;
begin
  Result := FBaseDeCalculoIPI;
end;

function TResultadoAbreviacaoIpi.BaseDeCalculoIPI(
  AValue: Double): IResultadoAbreviacaoIpi;
begin
  Result := Self;
  FBaseDeCalculoIPI := AValue;
end;

class function TResultadoAbreviacaoIpi.New: IResultadoAbreviacaoIpi;
begin
  Result := Self.Create;
end;

end.
