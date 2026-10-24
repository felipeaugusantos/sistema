unit untTypesTabelaPreco;

interface
  Type
  TTipoLocalizacaoItem = (tliCodBarOuFornecedor_CodFabrica, tliCodBarras, tliFornecedor_CodFabrica, tliCodItem);

  TopcMarPre = (opcMargem, opcPrecoVenda);
  TopcAltPre = (opcAlteraItem, opcIncluiItem, opcGlobalComuns, opcGlobalPreco);
  TTipoCalculoMargemPreven = (tcmNaoDefinido,tcmVenda, tcmMargem);
  TOpcTabelasReprocessa = (topctrTodas, topctrApenasAtivas);
  TOpcRecalculoTabelas = record
    OpcTabelasReprocessa : TOpcTabelasReprocessa;
    TipoCalculoMargemPreven: TTipoCalculoMargemPreven;
  End;
  TOrigemCalculo = (tocPadrao, tocCadEmpresa, tocCalcGeral);


implementation

end.
