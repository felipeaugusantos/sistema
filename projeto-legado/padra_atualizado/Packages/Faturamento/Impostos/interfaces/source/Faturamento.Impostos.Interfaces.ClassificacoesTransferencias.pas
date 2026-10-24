unit Faturamento.Impostos.Interfaces.ClassificacoesTransferencias;

interface

type
  IParametrosRegraClassificacoesTransferencias = interface
    ['{862E98D4-9C90-4CA0-8457-5DC3085F11D6}']

    function CodigoDaEmpresaTE: String; overload;
    function CodigoDaEmpresaTE(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function CodigoDaEmpresaOrigemTE: String; overload;
    function CodigoDaEmpresaOrigemTE(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function CstTransfEstoqueEmpresa: Boolean; overload;
    function CstTransfEstoqueEmpresa(AValue: Boolean): IParametrosRegraClassificacoesTransferencias; overload;

    function TipoDeOperacao: String; overload;
    function TipoDeOperacao(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoTributado: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaTributado: String; overload;
    function TransfDeEstoqueClassifVendaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifVendaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifVendaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaTributado: String; overload;
    function TransfDeEstoqueCSTDeVendaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueCSTDeVendaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueCSTDeVendaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeTransferenciaTributado: String; overload;
    function TransfDeEstoqueCSTDeTransferenciaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueCSTDeTransferenciaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueCSTDeTransferenciaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaSubstImpDireta: String; overload;
    function TransfDeEstoqueClassifVendaSubstImpDireta(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaTributado(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstCombustivelLubrificante(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeTransferenciaSubstDemaisProdutos(AValue: String): IParametrosRegraClassificacoesTransferencias; overload;
  end;

  IResultadoRegraClassificacoesTransferencias = interface
    ['{862E98D4-9C90-4CA0-8457-5DC3085F11D6}']

    function TipoDeEmissaoTE: String; overload;
    function TipoDeEmissaoTE(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifIndustrializacaoOuTransferenciaProdutosIndustrializacaoSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaTributado: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaOuTransferenciaTributado: String; overload;
    function TransfDeEstoqueCSTDeVendaOuTransferenciaTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueCSTDeVendaOuTransferenciaSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta: String; overload;
    function TransfDeEstoqueClassifVendaOuTransferenciaSubstImpDireta(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueClassifTransferenciaDepositoFechadoSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaTributado(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstCombustivelLubrificante(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;

    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos: String; overload;
    function TransfDeEstoqueDepositoFechadoCSTDeVendaOuTransferenciaSubstDemaisProdutos(AValue: String): IResultadoRegraClassificacoesTransferencias; overload;
  end;

  IRegraImpostosClassificacoesTransferencias = interface
    ['{C09BE7E9-FDD5-44BE-940A-BF14AEB9F024}']

    function ClassificacoesTransferenciasRegra(AParametros: IParametrosRegraClassificacoesTransferencias): IResultadoRegraClassificacoesTransferencias; overload;
    function ClassificacoesTransferenciasSQL: String; overload;
  end;

implementation

end.
