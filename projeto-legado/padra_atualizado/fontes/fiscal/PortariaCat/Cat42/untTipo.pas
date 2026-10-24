unit untTipo;

interface

type
  TRegime = (rCompetencia, rCaixa);
  TTipoExportacao = (tePagar, teReceber, teTransfBanco, teCheque, teCartao);
  TTipoExportacaoFiscal = (tefEntrada, tefSaida, teReducaoZ, tefClientes, tefProdutos, tefFornecedores, tefServicos);
  TTipoAnaliticoSintetico = (tAnalitico, tSintetico);
  TConfiguracaoContiMatic = (cConfiguracao, cPortador, cPlanoContas);
  TTipoContabil = (tcDebito, tcCredito);
  TTipoCat = (Cat42);
  TTipoEnquadramentoCat = (teConsumidorFinal, teFatoGeradorNaoRealizado, teSaidasOutroEstado, teSaidasIsencao);
  TTipoInventario = (tiComum, tiAdjudicacao, tiSantaCatarina);
  TTipoConferenciaCat = (tccSim, tccNao, tccConf);

implementation

end.
