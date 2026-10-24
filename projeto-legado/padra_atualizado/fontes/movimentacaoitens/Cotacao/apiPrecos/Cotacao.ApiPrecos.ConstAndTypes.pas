unit Cotacao.ApiPrecos.ConstAndTypes;

interface

  const idRedeAncora = 1;
  const idRedePitStop = 2;
  const idRedeSkyPecas = 3;
  const idRedeDelta = 4;
  const psUsuarioNaoEncotrado = 'Usuário não encontrado';
  const psFalhaAutenticacao =  'Falha na autenticação';
  Type

  TPitStopTipoConsulta = (pstcBalcao, pstcCotacao, pstcCotacaoSegundaEtapa, pstcFaturaPedido);

  TStatusConsultaPitStop = (scpsPendente, scpsProcessando, scpsConcluidoPrimeiraEtapa, scpsPendenteSegundaEtapa, scpsProcessandoSegundaEtapa, scpsConcluido, scpsCancelado);

  TStatusPitStopCotacao = (spscSemApi, spscComApi, spscPendenteConsultaPreco, spscIntegrandoConsultaPreco, spscPendenteImportarConsultaPreco,
                           spscPendenteRecotarPreco, spscIntegrandoRecotarPreco, spscPendenteImportarRecotarPreco, spscConcluido);



implementation

end.
