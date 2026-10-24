unit untLibCartoesConstantes;

interface

Uses Winapi.Messages, Vcl.Menus;

Const
  VERSAO_LIB: String = '2.5.11'; {Importação Banrisul: passa a ler a versão Excel dos arquivos (legendas e campos separados por ponto e vírgula) e os arquivos de todas as bandeiras BJRVC21 e BJRVC41, e resume na tela os arquivos não importados - Req 447015 }
  //VERSAO_LIB: String = '2.5.10'; {Conciliação GetNet: a opção Exibir inconsistência de taxas administrativas só aparecia com configuração da Sipag ligada e, marcada, não trazia as divergências de taxa no relatório; passa a aparecer sempre e a valer no relatório - Req 471246 }
  //VERSAO_LIB: String = '2.5.9';   {Exibida na tela de baixa de cartões, de forma informativa, o Pix recebido via QRCode, sem permitir seu processamento na baixa - Req 451011}
  //VERSAO_LIB: String = '2.5.8'; {Conciliação Sipag: na tela de baixa, o cancelamento/ajuste mostrava o valor líquido também na coluna Vl. Bruto; passa a mostrar o bruto do arquivo, como o relatório - Req 471018 }
  //VERSAO_LIB: String = '2.5.7'; {Log da baixa nas conciliações em lote (Cielo, Redecard e PagSeguro): a LOGMCA gravava o cartão como era antes da baixa e a LOGCTP da taxa não era gravada - Req 470944 }
  //VERSAO_LIB: String = '2.5.6'; {Conciliação Sipag ainda somava em dobro os cartões VISA que a SIPAG reenvia em outro arquivo do mesmo dia: a referência do adquirente deixa de ser comparada ao apagar o registro do arquivo anterior - Req 470555 }
  //VERSAO_LIB: String = '2.5.5'; {Conciliação Redecard Online com antecipação: a parcela desagendada (UNBOOK) entrava no acerto da taxa de antecipação do último cartão do pagamento e a conciliação ficava menor que o depósito - Req 470234 }
  //VERSAO_LIB: String = '2.5.4'; {Conciliação Amazon: pedido com mais de um item gravava só o último item na importação e a conciliação ficava abaixo do depósito; os itens do mesmo pedido passam a ser somados - Req 469585 }
  //VERSAO_LIB: String = '2.5.3'; {Conciliação Sipag somava em dobro o pagamento que a SIPAG reenvia em outro arquivo do mesmo dia: a importação passa a substituir o registro do arquivo anterior - Req 469411 }
  //VERSAO_LIB: String = '2.5.2'; {Venda cancelada sem MovCar no sistema. Lançada como Cancelamentos/Ajustes na Redecard API (CFG_REDVCA) - Req 456013 }  
  //VERSAO_LIB: String = '2.5.1'; {Relatório da Conciliação Getnet trazia linhas de conciliações antigas: as linhas do relatório passam a ser apagadas junto com o cabeçalho - Req 468860 }
  //VERSAO_LIB: String = '2.5.0'; {Inclusão das vendas não encontradas na Conciliação/Baixa de Recebíveis ML, gerando o lançamento de cartão pela Manutenção de Cartões - Req 446492 }
  //VERSAO_LIB: String = '2.4.5'; {Estorno de venda paga com saldo do Mercado Pago lançado como ajuste sem o crédito da venda na Conciliação ML - Req 468426 }
  //VERSAO_LIB: String = '2.4.4'; {Corrigido o sinal do ajuste positivo de pedido devolvido com renda negativa na conciliação Shopee - Req 467357 }
  //VERSAO_LIB: String = '2.4.3'; {Correção de vendas no marketplace sendo confundidas com maquininha no ML - Req 467374 }
  //VERSAO_LIB: String = '2.4.2'; {Correção de descrição de tipo de ajuste 20 para a GETNET - Req 467473 }
  //VERSAO_LIB: String = '2.4.1'; {Correção de venda com tipo "shipping" sendo tratado como ajuste na Conciliação ML - Req 466823 }
  //VERSAO_LIB: String = '2.4.0'; {Adaptada a conciliação da Sempre Pronto (Mobbuy) à nova versão da API: importação, conciliação, baixa e portador do recebimento - Req 444043 }
  //VERSAO_LIB: String = '2.3.8'; {Corrigido valor liquido em venda desmembrada com mesmo valor bruto na Redecard API - Req 464433 }
  //VERSAO_LIB: String = '2.3.7'; {Exclusão de arquivos Shopee - Req 455823 }
  //VERSAO_LIB: String = '2.3.6'; {Ajuste na pesquisa de ponto de venda Redecard Online - Req 459939 }
  //VERSAO_LIB: String = '2.3.5'; {Feito uma melhoria para tentar importar arquivo do Mercado Livre fora do padrão (com quebras no meio da linha) - Req 465684 }
  //VERSAO_LIB: String = '2.3.4'; {Corrigida a baixa sintética do Magalu quando possuir: Apenas Baixa Zerada e não tiver pagamento positivo no período - Req 465665 }
  //VERSAO_LIB: String = '2.3.3'; {Modificada a forma de validar estabelecimentos duplicados na conciliação da PAGSEGURO, para validar com e sem zeros a esquerda - Req 465163 }
  //VERSAO_LIB: String = '2.3.2'; {Ajustado importacao da Sicredi para verificar colunas atraves de um array of string - Req 458606 }
  //VERSAO_LIB: String = '2.3.1'; {Ajustado no Magazine Luiza - campo descrição como observaçõ em ajustes - Req 446885 }
  //VERSAO_LIB: String = '2.3.0'; {Adicionado o tratamento para cartões de maquininha do Mercado Livre na conciliação de recebíveis - Req 463096 }
  //VERSAO_LIB: String = '2.2.2'; {Corrigido o cancelamento da Stone que vinha com o valor bruto/líquido do pagamento e sumia da conciliação - Req 463096 }
  //VERSAO_LIB: String = '2.2.1'; {Gerada uma melhoria na conciliação da Cielo para gravação em lote e manter aberta a transação por menos tempo - Req 449872 }
  //VERSAO_LIB: String = '2.1.1'; {Ajustado o agrupamento de ajustes do Mercado Livre (agora começou mandar refund positivo com payment) - Req 461093 }
  //VERSAO_LIB: String = '2.1.0'; {Adição lib Amazon - Req:440064 }
  //VERSAO_LIB: String = '2.0.5'; {Corrigido o valor bruto da conciliação REDECARD API em venda com alteração de valor, que exibia o valor original da parcela - Req: 460724}
  //VERSAO_LIB: String = '2.0.4'; {Mapeado um novo ajuste de crédito na Shoppe - drc_adjustable_refund - Req: 459957}
  //VERSAO_LIB: String = '2.0.3'; {Feito um contorno para não dar erro quando a Stone não enviar a tag POI em FinancialTransactionsAccounts - Req: 459496}
  //VERSAO_LIB: String = '2.0.2'; {Correção do número da parcela quando o total form maior que 12 para Sicredi - Req: 459232}
  //VERSAO_LIB: String = '2.0.1'; {Desabilitar botão relatório Market Placee CFG_PGMREI vazia - Reqs: 458387 e 458366}
  //VERSAO_LIB: String = '2.0.0'; {Realizados ajustes para melhor consumo de memória de toda a rotina - req: 448479}

  DATA_LIB: String = '20/10/2026';

  ERR_UNKNOW_ERROR    = 0000000;
  ERR_UNKNOW_DATABASE = 0000001;
  ERR_ACCESS_DENIED   = 0000002;
  ERR_TABLE_NOT_EXIST = 0000003;
  ERR_FIELD_NOT_FOUND = 0000004;
  ERR_TABLE_READONLY  = 0000005;
  ERR_NOT_VALID_INT   = 0000006;
  ERR_NOT_VALID_DATE  = 0000007;
  ERR_NOT_VALID_FLOAT = 0000008;
  ERR_NOT_IN_EDIT     = 0000009; //Not in EDIT or INSERT mode
  ERR_SQL_SYNTAX      = 0000010;
  ERR_BD_NOT_ACTIVE   = 0000011;
  ERR_FIELD_NOT_NULL  = 0000012;
  ERR_PRIMARY_KEY     = 0000013;
  ERR_ORDER_BY        = 0000014;
  ERR_DEFAULT_PRINTER = 0000015;

  {*****************************************}
  {* CODIGOS DE ERRO ESPECIFICOS DO MYSQL  *}
  {**************************************MV*}
  ERROR_FOREIGN_KEY_DELETE = 1217;
  ERROR_FOREIGN_KEY_INSERT = 1216;
  ERROR_PRIMARY_KEY_INSERT = 1062;
  ERROR_USUARIO_SENHA_INV =  1045;
  ERRO_NAO_CONECTOU = 2003;
  CM_AVISOS = WM_USER + 1;


Var
  VS_TimeZone: Integer;
  NewGravando: Boolean;
  COR_ZEBRA: Integer;

  MenuImportacaoCartoes,
  MenuConciliacaoCartoes: TMenuItem;

Const
  AUTCOM_STYLE_NAME: String = 'Sapphire Kamri';

  {** Hitórico **}

  //VERSAO_LIB: String = '1.13.4'; {Ajustado comportamento para não substituir registros anteriormente conciliados GETNET - Req 456613}
  //VERSAO_LIB: String = '1.13.3'; {Ajustado quando a Shopee envia Renda do Pedido em dias anteriores e depois um "ajuste conciliável" para o mesmo pedido - Req 457376}
  //VERSAO_LIB: String = '1.13.2'; {Corrigido o erro de importação da Pagar.me, que está enviando Json com "\ " - Req 457285}
  //VERSAO_LIB: String = '1.13.1'; {Corrigido ajustes do tipo reserve_for_refund positivos do Mercado Livre  - Req 456150}
  //VERSAO_LIB: String = '1.13.0'; {Alterada a Getnet para aceitar arquivos com a versão 10.3 - Req 456784}
  //VERSAO_LIB: String = '1.12.5'; {Corrigido registro da Shopee quando possui estorno parcial com Desconto de Pix - Req 456143}
  //VERSAO_LIB: String = '1.12.4'; {Corrigido gravação de ctpdet negativo - Mercado livre req 455971 }
  //VERSAO_LIB: String = '1.12.3'; {Ajustado o agrupamento de ajustes do Mercado Livre - Req 455580}
  //VERSAO_LIB: String = '1.12.2'; {realizada alteração portador gravame GetNet - req 443049/432807 }
  //VERSAO_LIB: String = '1.12.1'; {Corrigida importação de registro REDECARD API do tipo credito que era interpretado como antecipacao - req 454897}
  //VERSAO_LIB: String = '1.12.0'; {Alterado layout pagar-me para adaptar a atualização - req 452861 }
  //VERSAO_LIB: String = '1.11.4'; {Corrigido o SHO_CONCIL da Shopee de vendas canceladas e com registros nas tabelas SHO_SHPGTO e SHO_SHAJUS - req: 454532}
  //VERSAO_LIB: String = '1.11.3'; {Alterado comportamento para documentar ao usuário a ausencia de campos obrigatórios e não levantar exception - REDECARD - req: 454257}
  //VERSAO_LIB: String = '1.11.2'; {Alterado o tamanho do campo MER_CODAUT do Mercado Livre para poder receber o EXTERNAL_REFERENCE completo - req: 454059}
  //VERSAO_LIB: String = '1.11.1'; {Alterada a conciliação do Mercado Livre para poder considerar frete como ajuste e não como venda - req: 453119}
  //VERSAO_LIB: String = '1.11.0'; {Alterada a conciliação do Mercado Livre para poder considerar o campo FINANCING_FEE_AMOUNT - req: 450639}
  //VERSAO_LIB: String = '1.10.9'; {Ajustado comportamento de conciliacao de registros do tipo GL e AL da GETNET - req: 450360}
  //VERSAO_LIB: String = '1.10.8'; {Ajustado comportamento de gravação do estabelecimento CIELO - req: 450255}
  //VERSAO_LIB: String = '1.10.7'; {Criada uma trava para parcelas fora do padrão Magazine Luiza - req: 449741}
  //VERSAO_LIB: String = '1.10.6'; {ajuste de comparação de diferença na conciliação da REDECARDAPI - req: 449264}
  //VERSAO_LIB: String = '1.10.5'; {conciliação da getnet não estava considerando a configuração de estabelecimento de ecomerce correta para lançamentos dos ajustes - req: 447630}
  //VERSAO_LIB: String = '1.10.4'; {Corrigido o filtro da Banrisul estava filtrando registros apenas com BAN_CONCIL=0. - Req: 446521}
  //VERSAO_LIB: String = '1.10.3'; {Feito uma proteção para quando o operador importar na lib antiga e depois da lib nova - Req: 445936}
  //VERSAO_LIB: String = '1.10.2'; {Corrigida a gravação e exibição do valor das taxas de antecipação da Pagar.me - Req: 445361}
  //VERSAO_LIB: String = '1.10.1'; {Alterado o nome da Mobbuy visualmente para Sempre Pronto - Req: 441961}
  //VERSAO_LIB: String = '1.9.6'; {Corrigido cenario de não filtrar os registros de cancelamento/ajustes por estabelecimento SIPAG - Req: 441891}
  //VERSAO_LIB: String = '1.9.5'; {Corrigido cenario de atribuicao do plano e portador de negociacao Cielo - Req: 442158}
  //VERSAO_LIB: String = '1.9.4'; {Corrigido um erro no arquivo do Mercado Livre para "fee_for_divergence_in_package_dimensions_cancel" positivos, que não vinha dados corretos - Req: 442374}
  //VERSAO_LIB: String = '1.9.3'; {Ajustada a Conciliação da Shopee quando pagamento e cancelamento vem como Ajuste - Req: 442238}
  //VERSAO_LIB: String = '1.9.2'; {Corrigido replace de registros durante a importacao a chave substituia registros indevidamente, tambem foi feito ajuste do select de conciliacao - Req: 439837}
  //VERSAO_LIB: String = '1.9.1'; {Corrigido replace de registros já conciliados na redecard - Req: 439926}
  //VERSAO_LIB: String = '1.9.0'; {Alterada a conciliação do Mercado Livre para vendas com mais de uma parcela e liberadas em dias distintos - Req: 432621}
  //VERSAO_LIB: String = '1.8.23'; {Corrigido cenário de registros de cartão baixados no resumo e recebidos no mesmo dia  - Req: 438010}
  //VERSAO_LIB: String = '1.8.22'; {Corrigido um erro no arquivo do Mercado Livre para "fee_for_divergence_in_package_dimensions" negativos, que não vinha dados corretos - Req: 438003}
  //VERSAO_LIB: String = '1.8.21'; {Corrigida marcação de registros da Equals quando utilizada a opção "Marcar Todos" - Req: 437310}
  //VERSAO_LIB: String = '1.8.20'; {Corrigido valor bruto apresentado para a baixa de registros da Cielo - Req: 437421}
  //VERSAO_LIB: String = '1.8.19'; {Corrigido loop de marcação de registros da Equals - Req: 437310}
  //VERSAO_LIB: String = '1.8.18'; {Corrigido um erro no arquivo do Mercado Livre para Payments negativos - Req: 437195}
  //VERSAO_LIB: String = '1.8.17'; {Corrigido no Mercado Livre o lançamento de ajuste "fee_for_divergence_in_package_dimensions" quando esse é conciliado - Req: 436829}
  //VERSAO_LIB: String = '1.8.16'; {atualizado conversao de encoding na importacao de json da FiservBin req: 436355}
  //VERSAO_LIB: String = '1.8.15'; {atualizado requisição de pedido de consentimento da stone red: 434925}
  //VERSAO_LIB: String = '1.8.14'; {Corrigido conciliação redecard api para considerar vendas canceladas que não consta no valor recebido: Req:434479}
  //VERSAO_LIB: String = '1.8.13'; {Mapeado um novo desconto adicionado pela Shopee na conciliação - ads_escrow_top_up_fee_or_technical_support_fee - Req: 434089}
  //VERSAO_LIB: String = '1.8.12'; {Corrigido divergencia de valor bruto e liquido da conciliação da SIPAG - Req: 431803}
  //VERSAO_LIB: String = '1.8.11'; {Corrigido erro da falta do campo MCA_TRFLIB que não existe na versão 30.72 - Req: 431702}
  //VERSAO_LIB: String = '1.8.10'; {Corrigido o erro no Magalu quando o Magalu precisa reparcelar, mas a venda vem parcelado mais de uma vez com quantidades diferentes - Req: 431646}
  //VERSAO_LIB: String = '1.8.9'; {Ajuste Mercado Livre de um novo tipo de registro "fee_for_divergence_in_package_dimensions" - Req: 430844}
  //VERSAO_LIB: String = '1.8.8'; {Ajuste importação redecard api em periodo superior a 15 dias - Req: 431399}
  //VERSAO_LIB: String = '1.8.7'; {Ajuste no Mercado livre para Shipping ID com mais de uma venda possuir e a soma do liquido forigual a zero - Req: 431060}
  //VERSAO_LIB: String = '1.8.6'; {Corrigido o erro no Magalu quando a chave do reparcelamento é quebrada pelo operador, pela integração ter gravado o pedido com caracteres a mais - Req: 430781}
  //VERSAO_LIB: String = '1.8.5'; {Alterada a conciliação da Shopee para conciliar arquivos que possuam apenas Saques/Ajustes - Req: 431400}
  //VERSAO_LIB: String = '1.8.4'; {Correção na baixa do Mercado Livre quando há cartões sem taxa - Req:430613}
  //VERSAO_LIB: String = '1.8.3'; {Correção na conciliação da GETNET quando cartões já baixados anteriormente N - Req:430613}
  //VERSAO_LIB: String = '1.8.2'; {Correção no filtro de ajustes da conciliação FISERV-BIN - Req:429901}
  //VERSAO_LIB: String = '1.8.1'; {Refeita a trava de estabelecimentos das CFG_CIEEST e CFG_CIELNK - Req:430414}
  //VERSAO_LIB: String = '1.8.0'; {Adição lib Granito - Req:426526}
  //VERSAO_LIB: String = '1.7.5'; {Adição da CFG_CIEDNE para desconsiderar os registros 03 - Reqs: 429847 e 430535}
  //VERSAO_LIB: String = '1.7.4'; {Remoção de aspas duplas na leitura do arquivo Magalu - Req: 428857}
  //VERSAO_LIB: String = '1.7.3'; {Adição de mais um desconto novo da Shopee (discount_pix) - Req: 429854}
  //VERSAO_LIB: String = '1.7.2'; {Correção de quebra de linha importação Magalu - Req: 427403}
  //VERSAO_LIB: String = '1.7.1'; {Correção do desmembramento do valor bruto quando pagamento unico na redecard api - Req: 428984}
  //VERSAO_LIB: String = '1.7.0'; {Adição de uma nova configuração no ML (CFG_MERCRE) - Req: 428353}
  //VERSAO_LIB: String = '1.6.3'; {Correção Negociação de recebíveis Cielo tipo E e B - Req: 428353}
  //VERSAO_LIB: String = '1.6.2'; {Correção configuração de estabelecimento na Stone - Req: 427129}
  //VERSAO_LIB: String = '1.6.1'; {Correção erro unknown na conciliação Getnet - Req: 428357}
  //VERSAO_LIB: String = '1.6.0'; {Adição lib B2W - Req:415362}
  //VERSAO_LIB: String = '1.5.9'; {Correção configuração de estabelecimento na Stone - Req: 427129}
  //VERSAO_LIB: String = '1.5.8'; {Correção numccd e valor bruto conciliação PagSeguro arquivo - Req 427076}
  //VERSAO_LIB: String = '1.5.7'; {Correção portadores ajustes CFG_MEREMP = N - Req 427554}
  //VERSAO_LIB: String = '1.5.6'; {Criação de mais uma trava na importação do Mercado Livre, para arquivos já conciliados - Req 427465}
  //VERSAO_LIB: String = '1.5.5'; {Criação de trava arquivo exportado incorreto Magalu - Req 424793}
  //VERSAO_LIB: String = '1.5.4'; {Criação de trava e direito de acesso na importação do Mercado Livre - Req 425807}
  //VERSAO_LIB: String = '1.5.3'; {Correção transferência YAPAY - Reqs 425760}
  //VERSAO_LIB: String = '1.5.2'; {Correção portadores CFG_MEREMP = N - Reqs 425329}
  //VERSAO_LIB: String = '1.5.1'; {Correção mensagem importação Pagar.Me - Reqs 424056}
  //VERSAO_LIB: String = '1.5.0'; {Adição libCartoesBanrisul - Reqs 415365}
  //VERSAO_LIB: String = '1.4.3'; {Correção payment como ajuste - Req 423345}
  //VERSAO_LIB: String = '1.4.2'; {Correção número NSU Fiserv-Bin - Req 423174}
  //VERSAO_LIB: String = '1.4.1'; {Adição inconsistência caixa sem transferir - Req 421944}
  //VERSAO_LIB: String = '1.4.0'; {Adição libCartoesPagarMe - Reqs 393422 e 401266}
  //VERSAO_LIB: String = '1.3.0'; {Adição lib Equals - Req:393418}
  //VERSAO_LIB: String = '1.2.0'; {Adição lib Fiserv - Req:415364}
  //VERSAO_LIB: String = '1.1.1'; {Mapeamentos novos descontos Shopee Req 419778 }
  //VERSAO_LIB: String = '1.1.0'; {Adição libCartoesGetNet}
  //VERSAO_LIB: String = '1.0.0'; {Adição do Controle de Versão da Lib}

implementation

end.
