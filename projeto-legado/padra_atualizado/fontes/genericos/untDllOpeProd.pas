unit untDllOpeProd;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses Classes, Forms, SysUtils, Uni, Windows, untFuncoesSimples, untILiberacao,
  untTypesSistema, untIFuncIns, untFuncoesRel,untClassPanelCx;

Type
  TOpeProd = (CadSalBalanco, AltPrecoProduto, DigCodBarLocFis, ManECommerce, AltPrecoIndividual, AltEfetivacaoPrecos, RelacSimilaridade,
              RelacSemelhanca, ProdutosAgrupados, TransfLinGru, TransfCodProduto, GeracaoCodBarras, ImportCatalogoPreco, SelListPreco, CadManutInvSel, ManutInventario,
              GerInventario, AltPrecoGlobalCatalogo, AltPrecoGlobal, AltGlobalServico, BalancoEstoqueGravar, RelBalancoEstoqueDiferenca, BalancoEstoqueDigManual, BalancoEstoqueImportar,
              BalancoEstoqueZera, CadBocaCaixaAlt, ExpFunBosh, EtiquetasNotaEntrada,
              AltNumLote, BalancoEstoqueDigMotorola, AltEfetivacaoPrecosTab,
              AlteraEstMinMax, ExpBuscaPreco, ExpBuscaPrecoGertec, AltPrecoGlobalFornecedor,
              EfetivacaoPrecosFornecedor, AltPrecoGlobalNota, RelConDet,
              BalancoEstoqueDigColetivo, ManDesIte, ManutCustoProdutos, BalancoEstoqueDigCompex260, AltPrecoMedio,
              ImportComisVendTabPreco, ImportTabPreIteger,ImportCadProduto, ImportCadEstrutura, ImportMarBruTabPreco, ImportPreVenTabPreco,
              AltGlobalPromocoes, GeracaoFCI_Exportacao, GeracaoFCI_Importacao, ManutancaoDescontoEmbalagem, ManutancaoDescontoEmbalagemExcluir, ManutencaoEmpresaCentraliza, ImportaProdFranq, ExpPricer,
              ReplicacaoLotes, ManutInventarioLote, BalancoIniciaArmazem, BalancoFinalizaArmazem, AtualizaDolarCatalogos, AltGlobalProdutosAcabados, AltGeralProdutos,
              RelMapaDeContagem, AtualizacaoMargemParaFranquia,RelClienteProdutoGarantia, MapaDeInventarioParaColetores, AtivacaoTabelaPreco, ApiSaneamento, ImportCadNCM, ImportCadNOP, ImportCadNCE,
              ImportaPROSER, DivergenciasSeparacao);

  TOpeProdModulos = Record
    Banco: TUniConnection;
  End;

  TProcedureOpeProd = procedure (prmDllOpe: Pointer);

  TOpeProdVariaveis = Record
    dtaVSDate : TDateTime;
    strLogUsu : String[3];
    strDesUsu : String[30];
    strEmpUsu : String;
    strEmpEst : String;
    strEmpCod : String[3];
    objTraceViewer: ITraceViewer;
    blnModoClassico: Boolean;
    utcRegist : TUltConsultas;

    intConEst,
    intConAcu: Integer;
  End;

  TOpeProdParam = Record
    fGMovGer : TfGravaMovGer;
    fGMovDet : TfGravaMovDet;
    fGDetLoc : TfGravaDetLoc;
    pAtuEstoqueLoc: TpAtuEstoqueLoc;
    prcExecutaRelatorio :  TExecutaRelatorio;
    strTabPre: String; //Parametro Utilizado Na Exportação para busca preço (automático)
    strStatus: String; //Parametro Utilizado Na Exportação para busca preço (automático)
    blnTraBar: Boolean; // Se Transfere o código de Barras
    strCodBar: String;
    strCodTab: String;  // Tabela de Preço do Fornecedor
    HandleOrigin: HWND;
    strCodIte: String;
  End;

  TparamOpeProd = class(TObject)
    public
      intDebugH : Byte;
      frmTipOpe : TOpeProd;
      modRecMod : TOpeProdModulos;
      varRecVar : TOpeProdVariaveis;
      varParam  : TOpeProdParam;
      objLibera : ILiberacao;
      objFuncIns: IFuncIns;
      PrcIniciaProcessoDivisaoDeChapa :TPrcIniciaProcessoDivisaoDeChapa;
      PrcSuspenteTimerPrincipal: TPrcSuspenteTimerPrincipal;
      FuncExternaprcRetCfgRelacionadaArquivo: TprcRetCfgRelacionadaArquivo;
      Form: TPanelCx;
  End;


implementation


end.
