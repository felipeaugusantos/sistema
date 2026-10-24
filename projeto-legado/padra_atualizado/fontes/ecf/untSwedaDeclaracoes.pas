unit untSwedaDeclaracoes;

interface
{$WARN SYMBOL_PLATFORM OFF}

// Funções de Comunicação  ---------------------------------------------------------------------------------------------------------------
function ECF_AbrePortaSerial: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FechaPortaSerial: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_MsgLog(Conteudo:Pchar):Integer; StdCall; External 'CONVECF.dll' delayed;
//Funções de Início de Dia
function ECF_AberturaDoDia( ValorInicioDia:AnsiString ; Pagto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções de Leituras Fiscais  ---------------------------------------------------------------------------------------------------------------
function ECF_LeituraX: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraMemoriaFiscalData( cDatai: AnsiString; cDataf: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraMemoriaFiscalDataMFD( cDatai: AnsiString; cDataf: AnsiString; tipo:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraMemoriaFiscalReducao( cCRZi: AnsiString; cCRZf: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraMemoriaFiscalReducaoMFD( cCRZi: AnsiString; cCRZf: AnsiString; tipo:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções do Cupom Fiscal  ---------------------------------------------------------------------------------------------------------------
function ECF_AbreCupom( CGC_CPF: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AbreCupomMFD( CGC_CPF, Nome, Endereco: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_IdentificaConsumidor( CGC_CPF, Nome, Endereco: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AumentaDescricaoItem( nome: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_UsaUnidadeMedida ( unidade: AnsiString ):Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_VendeItem( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; TipoQuantidade: AnsiString; Quantidade: AnsiString; CasasDecimais: Integer; ValorUnitario: AnsiString; TipoDesconto: AnsiString; Desconto: AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_VendeItemTresDecimais( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; Quantidade: AnsiString; ValorUnitario: AnsiString; TipoDesconto: AnsiString; Taxa: AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_VendeItemDepartamento( Codigo: AnsiString; Descricao: AnsiString; Aliquota: AnsiString; ValorUnitario: AnsiString; Quantidade: AnsiString; Acrescimo: AnsiString; Desconto: AnsiString; IndiceDepto: AnsiString; UM:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_DescontoSobreItemVendido(Item:AnsiString; TipoDesc:AnsiString; ValorDesc:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AcrescimoDescontoItemMFD(Item:AnsiString; TipoDescAcres:AnsiString; TipoDesc:AnsiString; ValorDesc:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaItemAnterior: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaItemGenerico( NumeroItem: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaAcrescimoDescontoItemMFD( Tipo: AnsiString ; Item:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_IniciaFechamentoCupom(DescAcres:AnsiString ; TipoDescontoACres:AnsiString; Valor:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_IniciaFechamentoCupomMFD(DescAcres:AnsiString ; TipoDescontoACres:AnsiString; ValorAcrescimo:AnsiString; ValorDesconto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AcrescimoDescontoSubtotalMFD(DescAcres:AnsiString ; TipoDescontoACres:AnsiString; Valor:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaAcrescimoDescontoSubtotalMFD( Tipo: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_TotalizaCupomMFD: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EfetuaFormaPagamento( Pagto:AnsiString;Valor:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EfetuaFormaPagamentoDescricaoForma( Pagto:AnsiString;Valor:AnsiString ;Texto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EfetuaFormaPagamentoMFD( Pagto:AnsiString;Valor:AnsiString ;Parcelas:AnsiString; Texto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_TerminaFechamentoCupom(Texto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FechaCupom( FormaPagamento: AnsiString; AcrescimoDesconto: AnsiString; TipoAcrescimoDesconto: AnsiString; ValorAcrescimoDesconto: AnsiString; ValorPago: AnsiString; Mensagem: AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FechaCupomResumido( FormaPagamento: AnsiString; Mensagem: AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AtivaDesativaCorteProximoMFD(tipocorte:Integer): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CupomAdicionalMFD: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_ProgramaArredondamento: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_ProgramaTruncamento: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EstornoFormasPagamento(Oritem:AnsiString; Destino:AnsiString; Valor:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;


// Funções de Cancelamento  ---------------------------------------------------------------------------------------------------------------
function ECF_CancelaCupom: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaCupomMFD( CGC_CPF, Nome, Endereco: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções de COmprovante Crédito e Débito (TEF) ---------------------------------------------------------------------------------------------------------------
function ECF_IniciaModoTEF:Integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_FinalizaModoTEF:Integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_AbreComprovanteNaoFiscalVinculado( FormaPagamento: AnsiString; Valor: AnsiString; NumeroCupom: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AbreComprovanteNaoFiscalVinculadoMFD( FormaPagamento: AnsiString; Valor: AnsiString; NumeroCupom: AnsiString ; CPF:AnsiString; Nome:AnsiString; Endereco: AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_UsaComprovanteNaoFiscalVinculadoTEF( Texto: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_UsaComprovanteNaoFiscalVinculado( Texto: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FechaComprovanteNaoFiscalVinculado: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_SegundaViaNaoFiscalVinculadoMFD(): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_ReimpressaoNaoFiscalVinculadoMFD(): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EstornoNaoFiscalVinculadoMFD(CPF:AnsiString ;NomeConsumidor:AnsiString ;EnderecoCOnsumidor:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_TEF_ImprimirRespostaCartao(NomeArquivo:AnsiString; Pagto:AnsiString; Trava:AnsiString; Valor:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_TEF_FechaRelatorio(): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_RelatorioGerencialTEF( Texto: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_UsaRelatorioGerencialMFDTEF( Texto: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções de Comprovantes  ---------------------------------------------------------------------------------------------------------------
function ECF_Suprimento( ValorInicioDia:AnsiString ; Pagto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_Sangria( ValorInicioDia:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AbreRecebimentoNaoFiscalMFD( CGC_CPF, Nome, Endereco: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AbreRecebimentoNaoFiscal(Item:AnsiString; TipoDesc:AnsiString; AcresDesconto:AnsiString; ValorDesc:AnsiString ;ValorReceb:AnsiString; texto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_RecebimentoNaoFiscal( Totalizador:AnsiString; Valor:AnsiString ; Pagto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EfetuaRecebimentoNaoFiscalMFD( Totalizador:AnsiString; Valor:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaItemNaoFiscalMFD( NumeroItem: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AcrescimoItemNaoFiscalMFD(Item:AnsiString; TipoDescAcres:AnsiString; TipoDesc:AnsiString; ValorDesc:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AcrescimoDescontoSubtotalRecebimentoMFD(DescAcres:AnsiString ; TipoDescontoACres:AnsiString; Valor:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_TotalizaRecebimentoMFD: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_IniciaFechamentoRecebimentoNaoFiscalMFD(DescAcres:AnsiString ; TipoDescontoACres:AnsiString; ValorAcrescimo:AnsiString; ValorDesconto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FechaRecebimentoNaoFiscalMFD(Texto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaRecebimentoNaoFiscalMFD( CGC_CPF, Nome, Endereco: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EfetuaFormaPagamentoNaoFiscal( Pagto:AnsiString;Valor:AnsiString; Texto:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções de Relatório Gerencial  ---------------------------------------------------------------------------------------------------------------

function ECF_AbreRelatorioGerencial: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AbreRelatorioGerencialMFD(Indice:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_EnviarTextoCNF( nome: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_RelatorioGerencial( nome: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_UsaRelatorioGerencialMFD( nome: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FechaRelatorioGerencial: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FechaRelatorioXouZ: Integer; StdCall; External 'CONVECF.dll' delayed;


// Funções de Fechamento do dia ---------------------------------------------------------------------------------------------------------------
function ECF_FechamentoDoDia: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_ReducaoZ( cData: AnsiString; cHora: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções de Autenticações ---------------------------------------------------------------------------------------------------------------
function ECF_Autenticacao: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AutenticacaoMFD(Linha: AnsiString; Texto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_AutenticacaoStr(Texto:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaDocAutenticacao: Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções de Gaveta ---------------------------------------------------------------------------------------------------------------
function ECF_AcionaGaveta: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaEstadoGaveta(Var Estado:Integer): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaEstadoGavetaStr(Var Estado:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;

//Funções de Cheque ---------------------------------------------------------------------------------------------------------------
function ECF_ProgramaMoedaSingular(Nome:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_ProgramaMoedaPlural(Nome:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_IncluiCidadeFavorecido(Cidade:AnsiString; Favorecido:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaStatusCheque(Var Estado:Integer): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaStatusChequeStr(Var Estado:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_ImprimeCheque(Banco:AnsiString; Valor:AnsiString;Favorecido:AnsiString;Cidade:AnsiString; Data:AnsiString; Texto:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_ImprimeChequeMFD(Banco:AnsiString; Valor:AnsiString;Favorecido:AnsiString;Cidade:AnsiString; Data:AnsiString; Texto:AnsiString; Verso:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraChequeMFD(CMC7: AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraLeiautesCheques: Integer; StdCall; External 'CONVECF.dll' delayed;

//Funções de Status ---------------------------------------------------------------------------------------------------------------
function ECF_RetornaTipoEcf(Tipo:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VersaoDll(Versao:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VersaoFirmware(Versao:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroSerie(NumeroSerie:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroSerieMFD(NumeroSerie:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroSerieMemoriaMFD(NumeroSerie:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_MarcaModeloTipoImpressoraMFD(Marca:AnsiString; Modelo:AnsiString; Tipo:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_CGC_IE(CGC:AnsiString; IE:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_CNPJMFD(CGC:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_InscricaoEstadualMFD(IE:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_InscricaoMunicipalMFD(IM:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroSubstituicoesProprietario(Proprietario:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_SimboloMoeda(Moeda:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_ClicheProprietario(Linhas:pchar): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroLoja(Loja:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroCaixa(Caixa:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_DataHoraImpressora(Data:AnsiString; Hora:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_LerAliquotasComIndice(Tribut:Pchar ):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaTotalizadoresNaoFiscaisMFD(Nome:Pchar ):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaModoOperacao(Modo:AnsiString):integer;StdCall; External 'CONVECF.dll' delayed;
function ECF_VerificaDescricaoFormasPagamento(Pagtos:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaTotalizadoresNaoFiscaisEx(Nomes:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaRelatorioGerencialProgMFD(Nomes:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_CasasDecimaisProgramada(Unitario:AnsiString; Quantidade:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaTruncamento(Status:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;

function ECF_VerificaEstadoImpressoraMFD( ACK: Integer;  ST1: Integer;  ST2: Integer; ST3: Integer ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornoImpressoraMFD(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer; Var ST3: Integer ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornoAliquotas(Aliquotas:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ImprimeCopiaCheque: Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CancelaImpressaoCheque: Integer; StdCall; External 'CONVECF.dll' delayed;

//Funções de Status Ultima Transacao ---------------------------------------------------------------------------------------------------------------
function ECF_TipoUltimoDocumento(Tipo:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_SubTotal(Subt:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_SubTotalComprovanteNaoFiscalMFD(Subt:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ValorPagoUltimoCupom(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroCupom(COO:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaFormasPagamento(Texto:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_TotaisVenda(Texto:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ValorAcrescimosUltimoCupom(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ValorDescontosUltimoCupom(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ValorCancelamentosUltimoCupom(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ValorCancelamentosUltimoCupomISS(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;

//Funções de Status Acumuladores Diários ---------------------------------------------------------------------------------------------------------------
function ECF_Acrescimos(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_Descontos(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaRecebimentoNaoFiscal(Texto:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaRecebimentoNaoFiscalMFD(Texto:Pchar ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_Cancelamentos(Texto:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_GrandeTotal(Texto:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VendaBruta(Texto:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornaAcrescimoNF(Texto:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornaDescontoNF(Texto:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornaCancelamentoNF(Texto:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornaTroco(Texto:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;

//Funções de Staus Contadores  ---------------------------------------------------------------------------------------------------------------
function ECF_NumeroIntervencoes(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ContadorCupomFiscalMFD(Valor: AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroCuponsCancelados(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroOperacoesNaoFiscais(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ContadorComprovantesCreditoMFD(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ComprovantesNaoFiscaisNaoEmitidosMFD(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ContadorOperacoesNaoFiscaisCanceladasMFD(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ContadorFitaDetalheMFD(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_ContadorRelatoriosGerenciaisMFD(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_NumeroReducoes(Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornaCOO(Valor:AnsiString): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_COO(ValorIni:AnsiString;Valor:AnsiString ): Integer; StdCall; External 'CONVECF.DLL' delayed;

//Funções de Staus do ECF  ---------------------------------------------------------------------------------------------------------------
function ECF_FlagsFiscais(Var Valor:Integer ): Integer; StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaEstadoImpressora( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_RetornoImpressora( var ACK: Integer;  var ST1: Integer;  var ST2: Integer ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaTipoImpressora( var Tipo: Integer ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_StatusEstendidoMFD( var Tipo: Integer ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_StatusCupomFiscal( Tipo: AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_StatusRelatorioGerencial( Tipo: AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_StatusComprovanteNaoFiscalVinculado( Tipo: AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_StatusComprovanteNaoFiscalNaoVinculado( Tipo: AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaModeloEcf: Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaHorarioVerao( Tipo: AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaZPendente( Tipo: AnsiString ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaDiaAberto( Tipo: AnsiString ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_VerificaFlagCorteMFD( Tipo: AnsiString ): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_GeraRFD( Texto: Pchar ): Integer;StdCall; External 'CONVECF.DLL' delayed;

// Funções Status Diversos---------------------------------------------------------------------
function ECF_PercentualLivreMFD(Livre:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_TotalLivreMFD(Livre:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_ReducoesRestantesMFD(Livre:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_TamanhoTotalMFD(Livre:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_TempoRestanteComprovanteMFD(Livre:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_DataMovimento(Livre:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;

// Status de Valores após a Redução Z ---------------------------------------------------------------
function ECF_DataHoraUltimoDocumentoMFD(DAtaHora:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_DataHoraReducao(Data:AnsiString; Hora:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_DataMovimentoUltimaReducaoMFD(Data:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_InicioFimCOOsMFD(Inicial:AnsiString; Final:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_InicioFimGTsMFD(Inicial:AnsiString; Final:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_GrandeTotalUltimaReducaoMFD(GT:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_DadosUltimaReducaoMFD(Texto:PAnsiChar): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_MapaResumoMFD:Integer;StdCall; External 'CONVECF.DLL' delayed;


// Funções SINTEGRA ---------------------------------------------------------------------
function ECF_RelatorioSintegraMFD(TipoRel:Integer; Arquivo:AnsiString;MesInic:AnsiString;AnoInic:AnsiString;Razao:AnsiString;Endereco:AnsiString; numero:AnsiString;Complemento:AnsiString;Bairro:AnsiString;Cidade:AnsiString; Cep:AnsiString; telefone:AnsiString; fax:AnsiString; Contato:AnsiString): Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_RegistrosTipo60: Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_RelatorioTipo60Mestre: Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_RelatorioTipo60Analitico: Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_RelatorioTipo60AnaliticoMFD: Integer;StdCall; External 'CONVECF.DLL' delayed;

// Funções CAptura Movimento Gravado ECF ---------------------------------------------------------------------
function ECF_LeituraXSerial: Integer;StdCall; External 'CONVECF.DLL' delayed;
function ECF_LeituraMemoriaFiscalSerialData( cDatai: AnsiString; cDataf: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraMemoriaFiscalSerialDataMFD( cDatai: AnsiString; cDataf: AnsiString; tipo:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraMemoriaFiscalSerialReducao( cCRZi: AnsiString; cCRZf: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_LeituraMemoriaFiscalSerialReducaoMFD( cCRZi: AnsiString; cCRZf: AnsiString; tipo:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_DownloadSB( nome: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_DownloadMF( nome: AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_DownloadMFD( nome: AnsiString ; tipo: AnsiString; inicio: AnsiString ; fim: AnsiString ; usuario: AnsiString  ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_FormatoDadosMFD(Origem:AnsiString; Destino:AnsiString; Formato:AnsiString;Tipo:AnsiString; Inicio:AnsiString; Fim:AnsiString; Usuario:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CapturaDocumentos(Tipo:AnsiString; Destino:AnsiString; Inicio:AnsiString; Fim:AnsiString; Exibe:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;

// Funções COTEPE --------------------------------------------------------------------------------------------------------------
function ECF_TabelaMercadoriasServicos3404(Arquivo:AnsiString; Inicio:AnsiString; Fim:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_ReproduzirMemoriaFiscalMFD(Tipo:AnsiString; Inicio:AnsiString; Fim:AnsiString; Arquivo:AnsiString; Binario:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_GeraRegistrosCAT52MFD(Binario:AnsiString; Data:AnsiString ): Integer; StdCall; External 'CONVECF.dll' delayed;

//Funções Código de Barras--------------------------------------------------------------------
function ECF_ConfiguraCodigoBarrasMFD( Altura:AnsiString; largura:AnsiString; posicao:AnsiString; fonte:AnsiString; Margem:AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CodigoBarrasCODABARMFD( Codigo :AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CodigoBarrasCODE39MFD( Codigo :AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CodigoBarrasEAN13MFD( Codigo :AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CodigoBarrasEAN8MFD( Codigo :AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CodigoBarrasITFMFD( Codigo :AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CodigoBarrasUPCAMFD( Codigo :AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;
function ECF_CodigoBarrasUPCEMFD( Codigo :AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;

function ECF_VerificaImpressoraLigada: Integer StdCall; External 'CONVECF.dll' delayed;
function ECF_DataHoraGravacaoUsuarioSWBasicoMFAdicional(DataUsuario, DataSoftware, Adicional: PAnsiChar): Integer StdCall; External 'CONVECF.dll' delayed;
function ECF_UltimoItemVendido(Codigo: AnsiString): Integer; StdCall; External 'CONVECF.dll' delayed;

implementation

end.
