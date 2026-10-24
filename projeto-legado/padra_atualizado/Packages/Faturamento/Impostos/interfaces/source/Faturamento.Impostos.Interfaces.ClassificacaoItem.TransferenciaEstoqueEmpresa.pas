unit Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa;

interface

type
//  IParametrosClassificacaoItemTransferenciaEstoqueEmpresa = interface
//    ['{00EFBDB8-0BDF-46AB-9A1D-1B044629AAF9}']
//
//    function CodigoDoCliente: String; overload;
//    function CodigoDoCliente(AValue: String): IParametrosClassificacaoItemTransferenciaEstoqueEmpresa; overload;
//
//    function CodigoDaEmpresa: String; overload;
//    function CodigoDaEmpresa(AValue: String): IParametrosClassificacaoItemTransferenciaEstoqueEmpresa; overload;
//  end;

  IResultadoClassificacaoItemTransferenciaEstoqueEmpresa = interface
    ['{B8BB5847-F10F-4CD8-8B29-E73A19E50013}']

    function TipoDeOperacao: String; overload;
    function TipoDeOperacao(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de venda
    function ClassificacaoDeVendaTributadoSaida: String; overload;
    function ClassificacaoDeVendaTributadoSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeVendaSubstCombLubrificanteSaida: String; overload;
    function ClassificacaoDeVendaSubstCombLubrificanteSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeVendaSubstDemaisProdutosSaida: String; overload;
    function ClassificacaoDeVendaSubstDemaisProdutosSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de transferencia
    function ClassificacaoDeTransferenciaTributadoSaida: String; overload;
    function ClassificacaoDeTransferenciaTributadoSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeTransferenciaSubstCombLubrificanteSaida: String; overload;
    function ClassificacaoDeTransferenciaSubstCombLubrificanteSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeTransferenciaSubstDemaisProdutosSaida: String; overload;
    function ClassificacaoDeTransferenciaSubstDemaisProdutosSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de compra
    function ClassificacaoDeCompraSubstDemaisProdutosEntrada: String; overload;
    function ClassificacaoDeCompraSubstDemaisProdutosEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeCompraTributadoEntrada: String; overload;
    function ClassificacaoDeCompraTributadoEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Classificao de transferecia
    function ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada: String; overload;
    function ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function ClassificacaoDeTransferenciaTributadoEntrada: String; overload;
    function ClassificacaoDeTransferenciaTributadoEntrada(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function RetornouInformacoes: Boolean; overload;
    function RetornouInformacoes(AValue: Boolean): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

    //Cont. Classificao de venda
    function ClassificacaoDeVendaSubstImpDiretaSaida: String; overload;
    function ClassificacaoDeVendaSubstImpDiretaSaida(AValue: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa; overload;

  end;

  ITransferenciaEstoqueEmpresaDadosDB = interface
    ['{3CF95C90-9682-4D74-A98D-7CA0CA4CBDDE}']

    function TransferenciaEstoqueEmpresa(ASQL: String; ACodigoDoCliente:
      String; ACodigoDaEmpresa: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
  end;

  procedure SetObjTransferenciaEstoqueEmpresaDadosDB(AValue: ITransferenciaEstoqueEmpresaDadosDB);

Var
  objTransferenciaEstoqueEmpresa: ITransferenciaEstoqueEmpresaDadosDB;

implementation

procedure SetObjTransferenciaEstoqueEmpresaDadosDB(AValue: ITransferenciaEstoqueEmpresaDadosDB);
begin
  objTransferenciaEstoqueEmpresa := AValue;
end;

end.
