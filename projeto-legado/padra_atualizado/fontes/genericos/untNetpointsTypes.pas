unit untNetpointsTypes;

interface

type
  TTipoIdPagto = (tipVarejo, tipCartao, tipCartaoPL);

  TTipoStatusNps = (tsnPendenteDeAcumulo, tsnCancelado, tsnAcumulado, tsnNull,
                    tsnAcumuloJaEnviado, tsnAcumuloNaoEncontradoParaEstorno,
                    tsnPendenteDesfazimento, tsnPedidoOrcamento);

  TTipoTransacaoAcumulo = (ttaConfirmacaoAcumulo, ttaDesfazimentoAcumulo);

const
  STATUS_TIPO_ID_PAGTO : Array[TTipoIdPagto] Of Integer = (1, 2, 3);
  STATUS_TIPO_TRA_ACUM : Array[TTipoTransacaoAcumulo] Of Integer = (1, 2);

  STATUS_NPS : Array[TTipoStatusNps] Of String = ('PENDENTE DE ACUMULO', 'CANCELADO',
                                                  'ACUMULADO', 'NULL', 'ACUMULO JA ENVIADO',
                                                  'ACUMULO NAO ENCONTRADO PARA ESTORNO',
                                                  'PENDENTE DESFAZIMENTO', 'PEDIDO/ORÇAMENTO');

  CODSTS_NPS : Array[TTipoStatusNps] Of Integer = (1, 2, 3, 4, 5, 6, 7, 8);

  STATUS_ASSOCIADO_NAO_CADASTRADO_1 : Integer = 1;
  STATUS_ASSOCIADO_NAO_CADASTRADO_2 : Integer = 2;
  STATUS_ASSOCIADO_CADASTRADO_COM_SUCESSO : Integer = 1;

  STATUS_ERRO_OBRIGATORIEDADE : Integer = 1;
  STATUS_ERRO_INCONSISTENCIA : Integer = 2;
  STATUS_ACUMULO_JA_ENVIADO : Integer = 3;
  STATUS_ACUMULO_NAO_ENCONTRADO_PARA_ESTORNO : Integer = 4;

  STATUS_ACUMULO_ONLINE_SUCESSO : Integer = 0;

  QTD_VERIFICA_PENDENCIA : Integer = 20;

  URL_WS_NETPONTS_PRODUCAO : String = 'http://webservices.netpoints.com.br/ws/';

implementation

end.
