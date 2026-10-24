unit untTypesLocEqu;

interface

Type
  TTpSituacaoEquipamentoLocacao = (tpAtivo, tpInativo, tpBloqueado);
  TTpEquipamentoLocacao = (tpPrincipal, tpAcessorio);
  TTipoCalculoValorLocacao = (tpHoras = 0, tpDiaria = 1, tpNone = 2, tpMensal = 3);
  TStatusContratoLocacao = (stNone, stOrcamento, stAtivo, stFaturado, stCancelado, stEncerrado);
  TTipoFaturamentoLocacao = (tpTotal, tpParcial);
  TTipoInspecao = (tpInspSaidaEqu, tpInspSaidaAce, tpInspEntraEqu, tpInspEntraAce, tpInspNone);
  TTipoManutencao = (tpAlterarInspecao, tpAlterarCobranca, tpCancelar);
  TPrecoContrato = (preCompraLiq = 1, preCusto = 2, preMedio = 3, preTabela1 = 4, preTabela2 = 5, preTabela3 = 6, preTabela4 = 7, preTabela5 = 8, preTabela6 = 9, preTabela7 = 10, preCaucao = 11);
  TEspDocLocEqu = (tpEspNF = 0, tpEspFF = 1, tpEspRL = 2, tpEspNS = 3, tpEspDL = 4);

  TOperacaoLocacao = (opNenhum,
                      opDigContrato,
                      opInspecao,
                      opEnvioDocumento,
                      opRetornoDocumento,
                      opFatIndividual,
                      opFatMensal,
                      opCancelaFatura,
                      opTroca,
                      opProrrogacao,
                      opManutencao);

  TRecImpVar = Record
    strNomVar: String;
    strTexto: String;
  End;

const
  arrTpSituacaoEquipamentoLocacao: array[TTpSituacaoEquipamentoLocacao] of string = ('A', 'I', 'B');
  arrTpEquipamentoLocacao : array[TTpEquipamentoLocacao] of string = ('P', 'A');
  arrTpCalculoVlLocacao: array[TTipoCalculoValorLocacao] of string = ('H', 'D', '', 'M');
  arrSitContratoLocacao: array[TStatusContratoLocacao] of string = ('', 'O', 'A', 'F', 'C', 'E');
  arrEspDocLocEqu: array[TEspDocLocEqu] of string = ('NF', 'FF', 'RL', 'NS', 'DL');
  arrDescTpCalculoVlLocacao: array[TTipoCalculoValorLocacao] of string = ('HORAS', 'DIÁRIAS', '', 'MENSAL');

  cst_QTD_MAXIMA_RESPONSAVEIS_CONTRATO : Integer = 2;

  cst_TRAVA_FATMEN_LOCEQU = 'FATMENSAL';
  cst_TRAVA_CADCTR_LOCEQU = 'CADCTR_LOCEQU';
  cst_TRAVA_PRORRO_LOCEQU = 'PRORRO_LOCEQU';
  cst_TRAVA_INSPEC_LOCEQU = 'INSPEC_LOCEQU';
  cst_TRAVA_FATURA_LOCEQU = 'FATURA_LOCEQU';
  cst_TRAVA_MANUTE_LOCEQU = 'MANUTE_LOCEQU';
  cst_TRAVA_REIMPC_LOCEQU = 'REIMPC_LOCEQU';
  cst_TRAVA_LIBERA_LOCEQU = 'LIBERA_LOCEQU';
  cst_TRAVA_ENVIO__LOCEQU = 'ENVIO__LOCEQU';
  cst_TRAVA_RETORN_LOCEQU = 'RETORN_LOCEQU';
  cst_TRAVA_TROCAS_LOCEQU = 'TROCAS_LOCEQU';
  cst_TRAVA_CANCEL_LOCEQU = 'CANCEL_LOCEQU';

  cstMsgTravaFaturaIndiv = 'Não é possivel realizar o faturamento do contrato de locação';
  cstMsgTravaFaturaMensal= 'Não é possível realizar o faturamento mensal';
  cstMsgTravaCadContrato = 'Não é possivel editar o contrato de locação';
  cstMsgTravaProrrogacao = 'Não é possivel realizar a prorrogação do contrato de locação';
  cstMsgTravaInspecaoEqu = 'Não é possivel realizar inspeção para locação de equipamentos';
  cstMsgTravaManutLocEqu = 'Não será possível realizar manutenção na inspeção do contrato';
  cstMsgTravaReimpLocEqu = 'Não será possível realizar reimpressão do comprovante da inspeção do contrato';
  cstMsgTravaLiberLocEqu = 'Não será possível realizar a liberação de equipamento';
  cstMsgTravaEnvioLocEqu = 'Não será possível realizar o envio de equipamento para locação';
  cstMsgTravaRetorLocEqu = 'Não será possível realizar o retorno de equipamento para locação';
  cstMsgTravaTrocaLocEqu = 'Não será possível realizar a troca de equipamento para locação';
  cstMsgTravaCanceLocEqu = 'Não será possível realizar o cancelamento da fatura de locação';

  cstIMP_ESFEQU = 'ESPECIFICACOES_EQUIPAMENTOS';
  cstIMP_EQUGER = 'EQUIPAMENTOS_GERAL';
  cstIMP_EQUINT = 'EQUGER';
  cstIMP_GRPEQU = 'GRPEQU';

implementation

end.
