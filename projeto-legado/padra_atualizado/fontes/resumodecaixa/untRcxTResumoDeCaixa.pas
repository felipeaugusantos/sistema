{*********************************************}
{* ESSE NOME É PARA BLOQUEAR O COMMIT NO SVN *}
{******************************************AJ*}
unit untRcxTResumoDeCaixa;

interface

Uses Uni, System.Sysutils, Classes, StrUtils, Variants, Data.DB, DateUtils,
  untTypesSistema, cxProgressBar, frxClass, System.Generics.Collections;

Type
  TTipoDataTransferencia = (tdtfDataTransferencia, tdtfDataMovimentoCaixa);

Type
  TResumoDeCaixa = class(TPersistent)

  private
    FTipoSaldoCaixa,
    FPortadorOrdemPagamento: String;

    FTransferenciaCega,
    FTransferenciaVinculada,
    FOperadorTransferenciaVinculadaDeveSerDaVenda,
    FOperadorTransferenciaDeveSerLogadoCaixa,
    FTransferenciaOrdemPagamentoAutomatica,
    FTransferenciaOrdemPagamentoAutomaticaFaturamento,
    FDeveEscolherPortadorOrdemPagamentoAut,
    FValidarDiaUtilPortadorOrdemPagamentoAut,
    FValidarArquivoPAF,
    FUtilizaContabilidade,
    FFechamentoDeveSerZerado: Boolean;

    FTipoDataTFCaixa: TTipoDataTransferencia;

    FDataGrvMovBanAdiantamento: TDateTime;
    FSeqLanTransferencia: String;

    procedure pRetornaUltimoFechamento(out fltSaldoUltimoFechamento: Double;
                                       out dtaDataUltimoFechamento: TDateTime;
                                       strCodigoCaixa: String;
                                       strCodigoEmpresa: String = '');

    function fRetornaSaldoDoCaixaPeloCampo(strCampo: String;
                                           strCodigoCaixa: String;
                                           strCodigoEmpresa: String = '';
                                           strCodigoOperador: String = '';
                                           ARecebidoPorPix: Boolean = False;
                                           ARecebidoPorPixAvulso: Boolean = False;
                                           AApenasOrdemPagamento: Boolean = False): Double;

    function fVerificaSaldoMaximoDoCaixa(fltValor: Double;
                                         strCodigoOperador: String;
                                         strCodigoCaixa: String): Boolean;

    function fExisteMovimentoNoCaixa(strCodigoCaixa: String;
                                     dtaDataCaixa: TDateTime;
                                     qryRegistrosCaixa: TUniQuery;
                                     strCodigoEmpresa: String = '';
                                     blnSoma: Boolean = False;
                                     dtaDtaFin: TDateTime = 0): Boolean;

    function fRetornaSaldoDoCaixa(strCodigoCaixa: String;
                                  Var dtaDataCaixa: TDateTime;
                                  strCodigoEmpresa: String = ''): Double;

    function fRetornaSQLTransferenciaDeValores(strCodigoCaixa: String;
                                               strCodigoOperador: String;
                                               blnAgruparOperador: Boolean = False): String;

    function fEhNecessarioFecharOCaixa(blnFaturamento: Boolean;
                                       out dtaDataLancamento: TDateTime;
                                       strCodigoCaixa: String;
                                       blnMostraMensagem: Boolean;
                                       strCodigoEmpresa: String): Boolean;

    class function RetornaSQLOperadoresDireitosDeAcessoLiberaTF: String;

    class procedure EnviaMensagemLiberacao(ADatasetOperadores: TDataset;
                                           ADireitoAcesso,
                                           ACodigoCaixa: String;
                                           AValorModalidade: Double);

    procedure GravaReciboTransferenciaAutomatica(ASeqRcx,
                                                 ACodigoEmpresa,
                                                 ARecibo,
                                                 ACodigoOperador: String;
                                                 ASeqConTrf: Integer);
  public
    strTipoFechamento: String;

    constructor Create(strCfgFechamento: String = '');

    function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;

    procedure pCriarRegistroInicial(strCodigoOperador: String;
                                    strCodigoCaixa: String = '');

    function fRetornaUltimoFechamento(out fltSaldoUltimoFechamento: Double;
                                      out dtaDataUltimoFechamento: TDateTime;
                                      strCodigoCaixa: String;
                                      strCodigoEmpresa: String = ''): Boolean;

    function fNecessitaFecharCaixa(blnFaturamento: Boolean;
                                   out dtaDataLancamento: TDateTime;
                                   strCodigoCaixa: String = '';
                                   blnMostraMensagem: Boolean = True;
                                   strCodigoEmpresa: String = ''): Boolean;

    function fRetornaSaldoCaixa(strCodigoCaixa: String;
                                Var dtaDataCaixa: TDateTime;
                                strCodigoEmpresa: String = ''): Double;

    function fRetornaFundoDeCaixaInformadoNaTransferencia(strCodigoCaixa: String;
                                                          ADataDoCaixa: TDateTime): Double;

    function RetornaSaldoRestanteEmDinheiroDoFundoDeCaixa(ACodigoCaixa: String;
                                                          ADataGravacao: TDateTime;
                                                          ADataDoCaixa: TDateTime): Double;

    function fLancaDiferencaNoCaixa(strCodigoCaixa,
                                    strCodigoOperador: String;
                                    fltValorDiferenca: Double;
                                    dtaDataDoCaixa: TDateTime): Boolean;

    function fRetornaSaldoCaixaCampo(strCampo: String;
                                     strCodigoCaixa: String;
                                     strCodigoEmpresa: String = '';
                                     strCodigoOperador: String = '';
                                     ARecebidoPorPix: Boolean = False;
                                     ARecebidoPorPixAvulso: Boolean = False;
                                     AApenasOrdemPagamento: Boolean = False): Double;

    function fCaixaDebaixaCtrDiferenteDoCaixaDeEstorno(strChaveDuplicata,
                                                       strCodigoCaixaLogado,
                                                       strCodigoEmpresaCaixa: String;
                                                       intSeqCon: Integer): Boolean;

    function fCaixaDeBaixaCtpDiferenteDoCaixaDeEstorno(strCodigoCaixaLogado,
                                                       strCodigoEmpresaCaixa: String;
                                                       intSeqCon: Integer): Boolean;

    function fVerificaSaldoMaximo(fltValor: Double; strCodigoOperador,
      strCodigoCaixa: String; const blnEmTransacao: Boolean = False): Boolean;

    function fCupomFiscalImpresso(strCodigoCaixa: String;
                                  dtaDataDoCaixa: TDateTime): Boolean;

    function fCaixaTemMovimento(strCodigoCaixa: String;
                                dtaDataCaixa: TDateTime;
                                qryRegistrosCaixa: TUniQuery;
                                strCodigoEmpresa: String = '';
                                blnSoma: Boolean = False;
                                dtaDtaFin: TDateTime = 0): Boolean;

    procedure pAtualizaRegistrosDoCaixaParaFechados(strCodigoCaixa: String;
                                                    strCodigoEmpresa: String;
                                                    dtaDataCaixa: TDateTime;
                                                    strNumeroDoLacre: String);

    procedure pAtualizaRegistrosDoCaixaParaAbertos(strCodigoCaixa: String;
                                                   strCodigoEmpresa: String;
                                                   dtaDataCaixa: TDateTime);

    function fRetornaTextoDaTravaDaTransferencia(strCodigoCaixa: String): String;
    function fRetornaTextoDaTravaDoContasAPagar(strCodigoCaixa: String): String;
    function fRetornaTextoDaTravaDoFechamento(strCodigoCaixa: String): String;

    function fRetornaFechamentosDoCaixa(strCodigoCaixa: String; dtaDataInicial, dtaDataFinal: TDateTime): TDataset;

    function RetornaTransferenciasLacresMalotesDoCaixa(ACodigoCaixa: String;
                                                       ADataInicial,
                                                       ADataFinal: TDateTime;
                                                       AFechamentos: TDataset): TDataset;

    function fRetornaDadosUltimoFechamento(ACodigoCaixa,
                                           ACodigoEmpresa: String;
                                           ACriarNovaConexao: Boolean = False): TDataset;

    function fRetornaDadosLancamentosCaixaSeqCon(strSeqCon,
                                                 strCodigoEmpresa: String;
                                                 ADataRecebimento: TDateTime;
                                                 ACodigoCaixa: String = ''): TDataset;

    function fRetornaUsuarioDoCaixa(strCodigoCaixa, strCodigoEmpresa: String; strCodOpeIgnora: String = ''): TStringArray;

    function fGetSQLTransfValores(strCodigoGrupo: String = '';
                                  strCodigoOperador: String = '';
                                  blnAgruparOperador: Boolean = False;
                                  strCodigoCaixa: String = ''): String;

    function fTodosOsCaixasEstaoFechados(strCodigoEmpresa: String = ''): Boolean;

    function fExisteTransferenciaEmDinheiro(strCodigoCaixa: String): Boolean;

    function fAbrirLayoutTermoDeFechamento(var frxTermo:TfrxReport;
                                               strTipoRelatorio,
                                               strLayout: String): Boolean;

    function VerificaBaixaVinculadaComCartoesECheques(ADataFechamento,
                                                      ADataBaixa: TDateTime;
                                                      ASeqCon: Integer;
                                                      AEmpresaBaixa,
                                                      ACodigoCaixa: String): Boolean;

    procedure CorrigeFundoDeCaixaNaTrocaDeModalidade(AAutoIncremLancamento: String;
                                                     AValorDoAjuste,
                                                     AValorAnterior: Double;
                                                     ACodigoDoCaixa,
                                                     ACodigoEmpresa: String);

    function RetornaValorDePixSemTransferir(ADataCaixa: TDateTime;
                                            ACodigoCaixa: String;
                                            ACodigoOperador: String = ''): Double;

    function CaixaJaFoiFechado(ADataCaixa: TDate): Boolean;

    function VerificaSeArquivoPAFFoiCriado(ADataCaixa: TDateTime): Boolean;

    function RecebimentoFoiLancadoNaCADRCXX(ASeqCon: Integer;
                                            ACodigoEmpresa: String;
                                            ADataCaixa: TDateTime;
                                            ACodigoDoCaixa: String): Boolean;

    function RetornaPortadorCADRECNoResumoDeCaixa(AAutoIncremChavePix,
                                                  APortadorCaixa,
                                                  APortadorTFAutomatica: String;
                                                  AValorPix,
                                                  ASomaModalidades: Double;
                                                  ARecebidoQRCode: Boolean;
                                                  const AValidarValorModalidade : Boolean): String;

    function RetornaPortadorTFAutomatica(AFaturamento: Boolean = False; APortadorCredito:String = ''): String;

    function RetornaRegistrosAtualizadosCadRcxx(ASeqcon,
                                                ACodigoEmpresa,
                                                ACodigoCaixa: String;
                                                ADataLancamento: TDateTime): TDataset;

    class function fRealizarLiberacaoDeFechamentos(cdsRegistros: TDataset;
                                                   blnLiberar: Boolean;
                                                   prgStatus: TcxProgressBar): Boolean;

    class procedure RetornaTransferenciasDoCaixaParaLiberacao(ALancamentos: TDataset);

    class procedure EnviaMensagemLiberacaoUsuariosTransferencia(ASequencialTF,
                                                                ACodigoEmpresa,
                                                                ACodigoCaixa: String;
                                                                ADataCaixa: TDateTime);

    class function RetornaDataDoLancamentoCaixa(ASeqcon: Integer;
                                                ADataCadastro: TDateTime;
                                                ACodigoEmpresa,
                                                ACodigoCaixa: String): TDateTime;

    class function RetornaCodigoDoCaixaDoLancamento(ASeqcon: Integer;
                                                    ADataCadastro: TDateTime;
                                                    ACodigoEmpresa: String): String;

    function InserirRegistroTFOrdemPagtoCaixa(AOperadorCaixa,
                                              AEmpresaCaixa: String;
                                              ADataCaixa: TDate;
                                              AVlrOrdPgto: Double;
                                              ACodigoDoCaixa: String;
                                              ASeqConTransf,
                                              ASeqConRecebimento: Integer;
                                              ARecebidoPix,
                                              APortador: String): Boolean;

    function InserirRegistroTFOrdemPagtoNaMOVBAN(AOperadorCaixa,
                                                 AEmpresaCaixa: String;
                                                 ADataCaixa: TDate;
                                                 AVlrOrdPgto: Double;
                                                 ACodigoDoCaixa,
                                                 ACodigoCliente: String;
                                                 ASeqConTransf: Integer;
                                                 APortador,
                                                 ANomeFormulario,
                                                 ASeqRcx: String;
                                                 AStrAutoInc : String = ''): Boolean;

    procedure pAtualizaDataLanctoCadRec(AAutoIncremList: String; ADataAlterada: TDateTime);

    procedure AtualizaTipoDeDataDeTransferencia;

    function PermitidoFecharOCaixaComOSaldoAtual(ASaldoCaixaAtual: Double): Boolean;

    function RetornaDataMovimentacaoBancariaTransferenciaAutomatica(ACodigoPortador: String;
                                                                    ADataCaixa: TDateTime): TDateTime;

    function CaixaFoiFechadoNoMeioDaBaixa(ADataCaixa,
                                          ADataHoraInicialBaixa: TDateTime;
                                          ACodigoCaixa: String;
                                          var AOperador: String): Boolean;

    class procedure ValidaArquivosPAFJaGerados(var AListaArquivos: TStringList;
                                               ADataCaixa: TDateTime);

    property TipoSaldoCaixa: String read FTipoSaldoCaixa;
    property OperadorTransferenciaDeveSerLogadoCaixa: Boolean read FOperadorTransferenciaDeveSerLogadoCaixa;
    property TransferenciaOrdemPagamentoAutomatica: Boolean read FTransferenciaOrdemPagamentoAutomatica;
    property TransferenciaOrdemPagamentoAutomaticaFaturamento: Boolean read FTransferenciaOrdemPagamentoAutomaticaFaturamento;
    property TransferenciaCega: Boolean read FTransferenciaCega;
    property TransferenciaVinculada: Boolean read FTransferenciaVinculada;
    property OperadorTransferenciaVinculadaDeveSerDaVenda: Boolean read FOperadorTransferenciaVinculadaDeveSerDaVenda;
    property DeveEscolherPortadorOrdemPagamentoAut: Boolean read FDeveEscolherPortadorOrdemPagamentoAut;
    property PortadorOrdemPagamento: String read FPortadorOrdemPagamento;
    property FechamentoDeveSerZerado: Boolean read FFechamentoDeveSerZerado;
    property TipoDataTFCaixa: TTipoDataTransferencia read FTipoDataTFCaixa;
    property DataGrvMovBanAdiantamento: TDatetime read FDataGrvMovBanAdiantamento;
    property SeqLanTransferencia : String read FSeqLanTransferencia;
  end;

implementation
Uses untFuncoesSimples, untCadRcxx, untILiberacao, untLiberacaoFactory,
     untMsgInterna, untRcxGeracaoArquivoPAF, untTPixDao, untDigPortador,
     untTBanTrf, untMovBan, untLogCba, untModulo;
{ TResumoDeCaixa }

procedure TResumoDeCaixa.CorrigeFundoDeCaixaNaTrocaDeModalidade(
  AAutoIncremLancamento: String; AValorDoAjuste, AValorAnterior: Double; ACodigoDoCaixa,
  ACodigoEmpresa: String);
  Var
    LConsulta: TUniQuery;

    LDataGravacao,
    LDataCaixa: TDateTime;
begin
  If strTipoFechamento <> 'C' Then
    Exit;

  If FTransferenciaCega Then
    Exit;

  Try
    LConsulta := fCriarQuery('SELECT RCX_DTAGRV, RCX_DTACAD ' +
                             'FROM CADRCXX ' +
                             'WHERE AUTOINCREM="' + AAutoIncremLancamento + '"');
    LConsulta.Open;
    LDataGravacao := LConsulta.FieldByName('RCX_DTAGRV').AsDateTime;
    LDataCaixa := LConsulta.FieldByName('RCX_DTACAD').AsDateTime;

    LConsulta := fCriarQuery('SELECT AUTOINCREM, RCX_FUNCAX ' +
                             'FROM CADRCXX ' +
                             'WHERE RCX_DTACAD = "' + FormatDateTime('yyyy/mm/dd', LDataCaixa) + '" AND ' +
                             '      RCX_CODEMP = "' + ACodigoEmpresa + '" AND ' +
                             '      RCX_ESPDOC = "TF" AND RCX_TFCANC <> "S" AND ' +
                             '      RCX_CODCAX = "' + ACodigoDoCaixa + '"  AND ' +
                             '      RCX_DTAGRV > "' + FormatDateTime('yyyy/mm/dd hh:mm:ss', LDataGravacao) + '" AND ' +
                             '      RCX_DINREC <> 0 AND RCX_LANFEC<>"S" ');
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LConsulta.Edit;
      LConsulta.FieldByName('RCX_FUNCAX').AsFloat := fFormataFloat(LConsulta.FieldByName('RCX_FUNCAX').AsFloat -
                                                     AValorAnterior +
                                                     AValorDoAjuste, 2);
      LConsulta.Post;

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

constructor TResumoDeCaixa.Create(strCfgFechamento: String);
begin
  strTipoFechamento := strCfgFechamento;

  If strTipoFechamento.IsEmpty Then
    strTipoFechamento := fCfgSis('TPFCCX');

  FTipoSaldoCaixa := fCfgSis('SALRCX');

  FOperadorTransferenciaDeveSerLogadoCaixa := fCfgSis('OPTFLG', varBoolean);

  FTransferenciaCega := fCfgSis('TRFCEG', varBoolean);

  FTransferenciaVinculada := fCfgSis('RCXTCC') = '2';

  FTransferenciaOrdemPagamentoAutomatica := fCfgSis('CXMVTP') = '2';
  If Not FTransferenciaOrdemPagamentoAutomatica Then
    FTransferenciaOrdemPagamentoAutomatica := Concat(strTipoFechamento, FTipoSaldoCaixa).Equals('CC');

  FTransferenciaOrdemPagamentoAutomaticaFaturamento := FTransferenciaOrdemPagamentoAutomatica;
  If Concat(strTipoFechamento, FTipoSaldoCaixa).Equals('CC') Then
  Begin
    If fCfgSis('F11TFO', varBoolean) Then
      FTransferenciaOrdemPagamentoAutomaticaFaturamento := fCfgSis('CXMVTP') = '2';
  End;

  FOperadorTransferenciaVinculadaDeveSerDaVenda := Not Concat(strTipoFechamento, FTipoSaldoCaixa).Equals('CC');
  If Not FOperadorTransferenciaVinculadaDeveSerDaVenda Then
    FOperadorTransferenciaVinculadaDeveSerDaVenda := FTransferenciaCega;

  FValidarArquivoPAF := Not strTipoFechamento.Equals('C');
  If FValidarArquivoPAF Then
    FValidarArquivoPAF := Not fCfgSis('PAFRCX', varBoolean);

  FDeveEscolherPortadorOrdemPagamentoAut := fCfgSis('PTFAUT', varBoolean);
  FPortadorOrdemPagamento := fCfgSis('PORORD', varString);

  FUtilizaContabilidade := fCfgSis('UTICON', varBoolean);

  FFechamentoDeveSerZerado := fCfgSis('FECZER', varBoolean);

  FValidarDiaUtilPortadorOrdemPagamentoAut := fCfgSis('ORDUTL', varBoolean);

  FTipoDataTFCaixa := tdtfDataTransferencia;
  If fCfgSis('DTATFX', varString) = '2' Then
    FTipoDataTFCaixa := tdtfDataMovimentoCaixa
  Else If FUtilizaContabilidade Then
    FTipoDataTFCaixa := tdtfDataMovimentoCaixa;

  fCfgSis('RCXNEG');
end;

class procedure TResumoDeCaixa.EnviaMensagemLiberacao(
  ADatasetOperadores: TDataset; ADireitoAcesso, ACodigoCaixa: String;
  AValorModalidade: Double);
  Var
    LModalidade,
    LMensagem: String;

    LMensagemInterna: TMsgInterna;
begin
  If AValorModalidade = 0 Then
    Exit;

  LMensagem := 'Transferência do caixa ' + ACodigoCaixa + ' em ';

  LModalidade := 'DINHEIRO';
  If ADireitoAcesso = 'VISMODCARLIBCAX' Then
    LModalidade := 'CARTÃO'
  Else If ADireitoAcesso = 'VISMODORDLIBCAX' Then
    LModalidade := 'ORDEM PAGAMENTO'
  Else If ADireitoAcesso = 'VISMODCHVLIBCAX' Then
    LModalidade := 'CHEQUE A VISTA'
  Else If ADireitoAcesso = 'VISMODCHPLIBCAX' Then
    LModalidade := 'CHEQUE PRÉ';
  LMensagem := LMensagem + LModalidade + ' gerada e aguardando fechamento para realizar liberação.';

  LMensagemInterna := TMsgInterna.Create(Nil);

  ADatasetOperadores.Filter := 'DIR_NOMFRM=' + ADireitoAcesso.QuotedString;
  ADatasetOperadores.Filtered := True;

  ADatasetOperadores.First;
  While Not ADatasetOperadores.Eof Do
  Begin
    LMensagemInterna.fEnviaMensagem('Liberação de transferências em ' + LModalidade + ' no caixa ' + ACodigoCaixa,
                                    LMensagem,
                                    strLoginUsuarioLogado,
                                    ADatasetOperadores.FieldByName('OPE_CODOPE').AsString,
                                    'N',
                                    NullAsStringValue);

    ADatasetOperadores.Next;
  End;

  FreeAndNil(LMensagemInterna);
end;

class procedure TResumoDeCaixa.EnviaMensagemLiberacaoUsuariosTransferencia(ASequencialTF,
                                                                           ACodigoEmpresa,
                                                                           ACodigoCaixa: String;
                                                                           ADataCaixa: TDateTime);
  Var
    LTransferencia,
    LOperadores: TUniQuery;
begin
  If Not fCfgSis('USAAUT', varBoolean) Then
    Exit;

  Try
    LOperadores := fCriaQuery;
    LOperadores.SQL.Text := RetornaSQLOperadoresDireitosDeAcessoLiberaTF;
    LOperadores.Open;

    If LOperadores.IsEmpty Then
      Exit;

    LTransferencia := fCriaQuery;
    LTransferencia.SQL.Text := 'SELECT IFNULL(SUM(RCX_DINREC), 0) AS RCX_DINREC, ' +
                               '       IFNULL(SUM(RCX_CARREC), 0) AS RCX_CARREC, ' +
                               '       IFNULL(SUM(RCX_ORDREC), 0) AS RCX_ORDREC, ' +
                               '       IFNULL(SUM(RCX_CHQAVI), 0) AS RCX_CHQAVI, ' +
                               '       IFNULL(SUM(RCX_CHQPRE), 0) AS RCX_CHQPRE ' +
                               'FROM CADRCXX ' +
                               'WHERE RCX_DTACAD="' + FormatDateTime('yyyy/mm/dd', ADataCaixa) + '" ' +
                               '  AND RCX_CODEMP="' + ACodigoEmpresa + '" ' +
                               '  AND RCX_SEQCON=' + ASequencialTF +
                               '  AND RCX_CODCAX="' + ACodigoCaixa + '" ';

    LTransferencia.Open;

    While Not LTransferencia.Eof Do
    Begin
      //Dinheiro
      EnviaMensagemLiberacao(LOperadores,
                             'VISMODDINLIBCAX',
                             ACodigoCaixa,
                             LTransferencia.FieldByName('RCX_DINREC').AsFloat);

      //Cartão
      EnviaMensagemLiberacao(LOperadores,
                             'VISMODCARLIBCAX',
                             ACodigoCaixa,
                             LTransferencia.FieldByName('RCX_CARREC').AsFloat);

      //Ordem Pagamento
      EnviaMensagemLiberacao(LOperadores,
                             'VISMODORDLIBCAX',
                             ACodigoCaixa,
                             LTransferencia.FieldByName('RCX_ORDREC').AsFloat);

      //Cheque a Vista
      EnviaMensagemLiberacao(LOperadores,
                             'VISMODCHVLIBCAX',
                             ACodigoCaixa,
                             LTransferencia.FieldByName('RCX_CHQAVI').AsFloat);

      //Cheque Pre
      EnviaMensagemLiberacao(LOperadores,
                             'VISMODCHPLIBCAX',
                             ACodigoCaixa,
                             LTransferencia.FieldByName('RCX_CHQPRE').AsFloat);

      LTransferencia.Next;
    End;
  Finally
    FreeAndNil(LOperadores);

    If Assigned(LTransferencia) Then
      FreeAndNil(LTransferencia);
  End;
end;

procedure TResumoDeCaixa.pAtualizaRegistrosDoCaixaParaAbertos(strCodigoCaixa,
  strCodigoEmpresa: String; dtaDataCaixa: TDateTime);
begin
  Try
    fExecutaSQL('UPDATE CADRCXX SET RCX_LANFEC="N", RCX_NUMLAC=NULL ' +
                ' WHERE RCX_DTACAD = ' + FormatDateTime('yyyy-mm-dd', dtaDataCaixa).QuotedString +
                '   AND RCX_CODEMP = ' + strCodigoEmpresa.QuotedString +
                '   AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString +
                '   AND RCX_ESPDOC <> "FC" ' +
                '   AND RCX_DTAGRV >       ' +
                FormatDateTime('yyyy-mm-dd hh:mm:ss',  fRetornaDadosUltimoFechamento(strCodigoCaixa,
                                                                                     strCodigoEmpresa)
                                                       .FieldByName('RCX_DTAGRV').AsDateTime).QuotedString);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao cancelar o fechamento do caixa. ' + #13 +
                             'Erro gerado: '  + E.Message);
  End;
end;

procedure TResumoDeCaixa.pAtualizaRegistrosDoCaixaParaFechados(strCodigoCaixa,
  strCodigoEmpresa: String; dtaDataCaixa: TDateTime; strNumeroDoLacre: String);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM, ' +
                          '       RCX_LANFEC, ' +
                          '       RCX_NUMLAC, ' +
                          '       RCX_DTACAD, ' +
                          '       RCX_CODEMP, ' +
                          '       RCX_CODCAX, ' +
                          '       RCX_ESPDOC, ' +
                          '       RCX_DTAGRV  ' +
                          'FROM CADRCXX ' +
                          'WHERE RCX_DTACAD = :DTACAD ' +
                          '  AND RCX_CODEMP = :CODEMP ' +
                          '  AND RCX_CODCAX = :CODCAX ' +
                          '  AND RCX_LANFEC <> "S" ' +
                          '  AND RCX_ESPDOC <> "FC" ' +
                          '  AND RCX_DTAGRV <= CURRENT_TIMESTAMP ';

    LConsulta.ParamByName('DTACAD').AsDateTime := dtaDataCaixa;
    LConsulta.ParamByName('CODEMP').AsString := strCodigoEmpresa;
    LConsulta.ParamByName('CODCAX').AsString := strCodigoCaixa;
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LConsulta.Edit;
      LConsulta.FieldByName('RCX_LANFEC').AsString := 'S';
      LConsulta.FieldByName('RCX_NUMLAC').Value := Null;
      If Not strNumeroDoLacre.IsEmpty Then
        LConsulta.FieldByName('RCX_NUMLAC').AsString := strNumeroDoLacre;
      LConsulta.Post;

      LConsulta.Next;
    End;
  Finally
    If Assigned(LConsulta) Then
    Begin
      LConsulta.Close;
      FreeAndNil(LConsulta);
    End;
  End;
end;

function TResumoDeCaixa.fCaixaDeBaixaCtpDiferenteDoCaixaDeEstorno(
  strCodigoCaixaLogado, strCodigoEmpresaCaixa: String;
  intSeqCon: Integer): Boolean;
  Var
    qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriarQuery('SELECT RCX_CODCAX       ' +
                               ' FROM CADRCXX           ' +
                               'WHERE RCX_SEQCON = ' + intSeqCon.ToString +
                               '  AND RCX_ESPDOC = "LD" '+
                               '  AND RCX_CODEMP = ' + strCodigoEmpresaCaixa.QuotedString);

    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty) And
              (qryConsulta.FieldByName('RCX_CODCAX').AsString <> strCodigoCaixaLogado);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TResumoDeCaixa.fCaixaDebaixaCtrDiferenteDoCaixaDeEstorno(strChaveDuplicata,
  strCodigoCaixaLogado, strCodigoEmpresaCaixa: String; intSeqCon: Integer): Boolean;
  Var
    qryConsulta: TUniQuery;

    stlChaveDuplicata: TStringList;
begin
  Try
    stlChaveDuplicata := TStringList.Create;
    stlChaveDuplicata.Delimiter     := '-';
    stlChaveDuplicata.DelimitedText := strChaveDuplicata;

    qryConsulta := fCriarQuery('SELECT RCX_CODCAX  ' +
                               ' FROM CADRCXX      ' +
                               'WHERE RCX_NUMDUP = ' + stlChaveDuplicata[0].QuotedString +
                               '  AND RCX_PARCEL = ' + stlChaveDuplicata[1].QuotedString +
                               '  AND RCX_ESPDOC = ' + stlChaveDuplicata[2].QuotedString +
                               '  AND RCX_EMPDUP = ' + stlChaveDuplicata[3].QuotedString +
                               '  AND RCX_CODCLI = ' + stlChaveDuplicata[4].QuotedString +
                               '  AND RCX_SEQBAI = ' + stlChaveDuplicata[5] +
                               '  AND RCX_SEQCON = ' + intSeqCon.ToString +
                               '  AND RCX_CODEMP = ' + strCodigoEmpresaCaixa.QuotedString);

    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty) And
              (qryConsulta.FieldByName('RCX_CODCAX').AsString <> strCodigoCaixaLogado);
  Finally
    FreeAndNil(stlChaveDuplicata);
    FreeAndNil(qryConsulta);
  End;
end;

function TResumoDeCaixa.fCaixaTemMovimento(strCodigoCaixa: String; dtaDataCaixa: TDateTime;
  qryRegistrosCaixa: TUniQuery; strCodigoEmpresa: String; blnSoma: Boolean;
  dtaDtaFin: TDateTime): Boolean;
begin
  If (strTipoFechamento <> 'C') Then
    Result := untCadRcxx.fCaixaTemMovimento(dtaDataCaixa,
                                            qryRegistrosCaixa,
                                            strCodigoEmpresa,
                                            blnSoma,
                                            dtaDtaFin)
  Else
    Result := fExisteMovimentoNoCaixa(strCodigoCaixa,
                                      dtaDataCaixa,
                                      qryRegistrosCaixa,
                                      strCodigoEmpresa,
                                      blnSoma,
                                      dtaDtaFin);
end;

function TResumoDeCaixa.fNecessitaFecharCaixa(blnFaturamento: Boolean;
  out dtaDataLancamento: TDateTime; strCodigoCaixa: String;
  blnMostraMensagem: Boolean; strCodigoEmpresa: String): Boolean;
begin
  If fEmptyStr(strCodigoEmpresa) Then
    strCodigoEmpresa := VS_strCodEmp;

  If strTipoFechamento <> 'C' Then
    Result := untCadRcxx.fNecessitaFecharCaixa(blnFaturamento,
                                               dtaDataLancamento,
                                               blnMostraMensagem,
                                               strCodigoEmpresa)
  Else
    Result := Not fEhNecessarioFecharOCaixa(blnFaturamento,
                                            dtaDataLancamento,
                                            strCodigoCaixa,
                                            blnMostraMensagem,
                                            strCodigoEmpresa);
end;

function TResumoDeCaixa.fRetornaUltimoFechamento(
  out fltSaldoUltimoFechamento: Double; out dtaDataUltimoFechamento: TDateTime;
  strCodigoCaixa, strCodigoEmpresa: String): Boolean;
begin
  Result := True;

  If strTipoFechamento = 'C' Then
    pRetornaUltimoFechamento(fltSaldoUltimoFechamento,
                             dtaDataUltimoFechamento,
                             strCodigoCaixa,
                             strCodigoEmpresa)
  Else
    untCadRcxx.pRetornaUltimoFechamento(fltSaldoUltimoFechamento,
                                        dtaDataUltimoFechamento,
                                        strCodigoEmpresa);
end;

function TResumoDeCaixa.fRetornaUsuarioDoCaixa(strCodigoCaixa,
  strCodigoEmpresa, strCodOpeIgnora: String): TStringArray;
  Var
    qryConsulta: TUniQuery;

    ADataCaixa: TDateTime;

    AValorFechamento: Double;
begin
  Try
    fRetornaUltimoFechamento(AValorFechamento,
                             ADataCaixa,
                             strCodigoCaixa,
                             strCodigoEmpresa);

    qryConsulta := fCriarQuery('SELECT ' +
                               'CONCAT(RCX_CODOPE,"-",OPE_NOMOPE) RCX_CODOPE ' +
                               'FROM CADRCXX ' +
                               'JOIN CADOPE ON (OPE_CODOPE = RCX_CODOPE) ' +
                               'WHERE RCX_CODEMP = :CODEMP ' +
                               '  AND RCX_CODCAX = :CODCAX ' +
                               '  AND RCX_DTACAD >= :DTACAD ' +
                               IIF(strCodOpeIgnora <> '', ' AND RCX_CODOPE <> :CODOPE ', '') +
                               '  AND RCX_LANFEC = "N" ' +
                               '  AND RCX_ESPDOC <> "FC" ' +
                               'GROUP BY RCX_CODOPE ' +
                               'ORDER BY RCX_CODOPE');

    qryConsulta.ParamByName('CODEMP').AsString := strCodigoEmpresa;
    qryConsulta.ParamByName('CODCAX').AsString := strCodigoCaixa;
    qryConsulta.ParamByName('DTACAD').AsDateTime := ADataCaixa;

    If strCodOpeIgnora <> '' Then
      qryConsulta.ParamByName('CODOPE').AsString := strCodOpeIgnora;

    qryConsulta.Open;

    SetLength(Result, qryConsulta.RecordCount);

    qryConsulta.First;
    While Not qryConsulta.Eof Do
    Begin
      Result[qryConsulta.RecNo -1] := qryConsulta.FieldByName('RCX_CODOPE').AsString;

      qryConsulta.Next;
    End;

    qryConsulta.Close;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TResumoDeCaixa.fTodosOsCaixasEstaoFechados(
  strCodigoEmpresa: String): Boolean;
  Var
    dtaDataLancamento: TDateTime;

    qryConsulta,
    qryAuxiliar: TUniQuery;
begin
  Result := True;

  If strCodigoEmpresa.IsEmpty Then
    strCodigoEmpresa := VS_strCodEmp;

  If strTipoFechamento <> 'C' Then
    Result := untCadRcxx.fNecessitaFecharCaixa(False, dtaDataLancamento, False)
  Else
  Begin
    qryAuxiliar := fCriaQuery;

    qryConsulta := fCriarQuery('SELECT CAX_CODCAX ' +
                               'FROM CADCAX       ' +
                               'WHERE CAX_CODEMP =' + strCodigoEmpresa.QuotedString);
    qryConsulta.Open;

    While Not qryConsulta.Eof Do
    Begin
      If (fEhNecessarioFecharOCaixa(False, dtaDataLancamento, qryConsulta.FieldByName('CAX_CODCAX').AsString, False, strCodigoEmpresa)) Or
         (fCaixaTemMovimento(qryConsulta.FieldByName('CAX_CODCAX').AsString, dtaDataLancamento, qryAuxiliar)) Then
      Begin
        Result := False;
        Break;
      End;

      qryConsulta.Next;
    End;

    FreeAndNil(qryAuxiliar);
    FreeAndNil(qryConsulta);
  End;
end;

procedure TResumoDeCaixa.pRetornaUltimoFechamento(
  out fltSaldoUltimoFechamento: Double; out dtaDataUltimoFechamento: TDateTime;
  strCodigoCaixa, strCodigoEmpresa: String);
  Var
    qryConsulta: TUniQuery;
begin

  If strCodigoEmpresa.IsEmpty Then
    strCodigoEmpresa := VS_strCodEmp;

  qryConsulta := fCriaQuery;

  Try
    fltSaldoUltimoFechamento := 0.00;
    dtaDataUltimoFechamento  := 0;

    qryConsulta.SQL.Text := 'SELECT            ' +
                            '  RCX_ESPDOC,     ' +
                            '  RCX_VALDOC,     ' +
                            '  RCX_DTACAD      ' +
                            'FROM              ' +
                            '  CADRCXX         ' +
                            'WHERE             ' +
                            '     RCX_CODEMP = "' + strCodigoEmpresa + '" ' +
                            ' AND RCX_CODCAX = "' + strCodigoCaixa + '" ' +
                            ' AND RCX_IDEFEC = "X" ' +
                            ' ORDER BY         ' +
                            '  RCX_IDEFEC DESC,' +
                            '  RCX_DTAGRV DESC ' +
                            'LIMIT 1           ';

    qryConsulta.Open;

    If (Not qryConsulta.IsEmpty) And
       (qryConsulta.FieldByName('RCX_ESPDOC').AsString = 'FC') Then
    Begin
      fltSaldoUltimoFechamento := qryConsulta.FieldByName('RCX_VALDOC').AsFloat;
      dtaDataUltimoFechamento  := qryConsulta.FieldByName('RCX_DTACAD').AsDateTime;
    End;

  Finally
    qryConsulta.Close;

    FreeAndNil(qryConsulta);
  End;
end;

procedure TResumoDeCaixa.pCriarRegistroInicial(strCodigoOperador,
                                               strCodigoCaixa: String);
  Var
    qryConsulta  : TUniQuery;
    strAutoIncrem: String;
begin
  Try
    qryConsulta := fCriaQuery;

    qryConsulta.SQL.Text := 'SELECT         ' +
                            '  RCX_DTACAD   ' +
                            'FROM           ' +
                            '  CADRCXX      ' +
                            'WHERE          ' +
                            '  RCX_CODEMP = ' + VS_strCodEmp.QuotedString;

    If strCodigoCaixa.IsEmpty Then
      qryConsulta.SQL.Add(' AND RCX_CODCAX IS NULL ')
    Else
      qryConsulta.SQL.Add(' AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString);

    qryConsulta.SQL.Add(' LIMIT 1');

    qryConsulta.Open;

    If (qryConsulta.IsEmpty) Then
    Begin
      fStartTransaction;
      untCadRcxx.fGravaCadRcx(strAutoIncrem,
                              '',
                              strCodigoOperador,
                              '',
                              'FC',
                              VS_strCodEmp,
                              IncDay(VS_Date, -1),
                              fTime(),
                              '',
                              '',
                              'FECHAMENTO DE CAIXA',
                              '',
                              'X',
                              '',
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              '',
                              0,
                              0,
                              fCfgSisL('SQFCRX'),
                              '',
                              '',
                              2,
                              0,
                              0,
                              0,
                              0,
                              0,
                              'N',
                              '',
                              strCodigoCaixa);

      fCommit;
    End;

    qryConsulta.Close;

  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TResumoDeCaixa.PermitidoFecharOCaixaComOSaldoAtual(
  ASaldoCaixaAtual: Double): Boolean;
  Var
    LPermiteNegativo: String;
begin
  If fFormataFloat(ASaldoCaixaAtual, 2) >= 0.00 Then
    Exit(True);

  LPermiteNegativo := fCampoTabela('SIS_VALCFG',
                                   'CFGSIS',
                                   ['SIS_CODCFG', 'SIS_CODEMP'],
                                   ['CFG_RCXNEG', VS_strCodEmp]);

  If Not LPermiteNegativo.Equals('N') Then
    Exit(True);

  fMensagem('ATENÇÃO', 'O sistema está configurado para não permitir o fechamento do caixa com o saldo negativo.' + #13 +
                       IIF(FTransferenciaCega, EmptyStr, 'Saldo atual: ' + FormatFloat(',0.00', ASaldoCaixaAtual) + #13) +
                       'Analise os lançamentos e faça os ajustes necessários.', ['&Ok']);

  Result := False;
end;

class function TResumoDeCaixa.fRealizarLiberacaoDeFechamentos(
  cdsRegistros: TDataset; blnLiberar: Boolean; prgStatus: TcxProgressBar): Boolean;
  Var
    strSQL,
    strAutoIncrem: String;
    intContador  : Integer;
begin
  strSQL := 'UPDATE CADRCXX SET ';
  If blnLiberar Then
    strSQL := strSQL + ' RCX_OPELIB=' + strLoginUsuarioLogado.QuotedString + ', ' +
                       ' RCX_DTALIB=CURRENT_TIMESTAMP '
  Else
    strSQL := strSQL + ' RCX_OPELIB=NULL, RCX_DTALIB=NULL ';

  strSQL := strSQL + ' WHERE AUTOINCREM IN ';

  Try
    fStartTransaction;

    intContador := 0;

    cdsRegistros.Filter   := 'RCX_MARDES=''M'' ';
    cdsRegistros.Filtered := True;

    prgStatus.Properties.Max := cdsRegistros.RecordCount;

    cdsRegistros.First;
    While not cdsRegistros.Eof Do
    Begin
      strAutoIncrem := strAutoIncrem + cdsRegistros.FieldByName('AUTOINCREM').AsString.QuotedString + ',';

      Inc(intContador);
      cdsRegistros.Next;

      pStepStatusGravacao(prgStatus);

      If (cdsRegistros.Eof) Or (intContador >= 50) Then
      Begin
        fExecutaSQL(strSQL + '(' + LeftStr(strAutoIncrem, strAutoIncrem.Length - 1) + ')');

        intContador := 0;

        strAutoIncrem := '';
      End;
    End;

    fCommit;
    Result := True;

    cdsRegistros.Filter   := '';
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TResumoDeCaixa.fRetornaDadosLancamentosCaixaSeqCon(strSeqCon,
  strCodigoEmpresa: String; ADataRecebimento: TDateTime;
  ACodigoCaixa: String = ''): TDataset;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM CADRCXX ' +
                          'WHERE RCX_SEQCON = :SEQCON ' +
                          '  AND RCX_CODEMP = :CODEMP ' +
                          '  AND RCX_DTACAD = :DTACAD ';

    If Not ACodigoCaixa.IsEmpty Then
    Begin
      LConsulta.SQL.Add('  AND RCX_CODCAX=:CODCAX ');

      LConsulta.ParamByName('CODCAX').AsString := ACodigoCaixa;
    End;

    LConsulta.SQL.Add('ORDER BY RCX_DTAGRV DESC');

    LConsulta.ParamByName('SEQCON').AsInteger := StrToInt(strSeqCon);
    LConsulta.ParamByName('CODEMP').AsString := strCodigoEmpresa;
    LConsulta.ParamByName('DTACAD').AsDateTime := ADataRecebimento;

    LConsulta.Open;

    Result := fCriaClientDatset(LConsulta);
    Result.Open;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TResumoDeCaixa.fRetornaDadosUltimoFechamento(
  ACodigoCaixa, ACodigoEmpresa: String; ACriarNovaConexao: Boolean): TDataset;
  Var
    LConsulta: TUniQuery;

    LConexao: TCriarConexao;
begin
  LConexao := Nil;
  LConsulta := Nil;
  Try
    If ACriarNovaConexao Then
    Begin
      LConexao := TCriarConexao.Create;
      LConsulta := fCriaQuery(Nil, LConexao.objConexao);
    End
    Else
      LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT *, OPE_NOMOPE AS RCX_NOMOPE ' +
                          ' FROM CADRCXX                      ' +
                          ' LEFT JOIN CADOPE ON               ' +
                          '          OPE_CODOPE=RCX_CODOPE    ' +
                          ' WHERE RCX_ESPDOC = "FC"           ' +
                          '   AND RCX_CODEMP = "' + ACodigoEmpresa + '" ';

    If Not ACodigoCaixa.IsEmpty Then
    Begin
      LConsulta.SQL.Add('   AND RCX_CODCAX = "' + ACodigoCaixa + '" ');
      LConsulta.SQL.Add(' ORDER BY RCX_DTAGRV DESC LIMIT 1  ');
    End
    Else
      LConsulta.SQL.Add(' ORDER BY RCX_DTACAD DESC LIMIT 1  ');

    LConsulta.Open;

    Result := fCriaClientDatset(LConsulta);
  Finally
    If Assigned(LConsulta) Then
    Begin
      LConsulta.Close;
      FreeAndNil(LConsulta);
    End;

    If Assigned(LConexao) Then
      FreeAndNil(LConexao);
  End;
end;

function TResumoDeCaixa.fRetornaFechamentosDoCaixa(strCodigoCaixa: String;
  dtaDataInicial, dtaDataFinal: TDateTime): TDataset;
  Var
    qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriarQuery('SELECT *           ' +
                               'FROM CADRCXX       ' +
                               'WHERE RCX_CODEMP = ' + VS_strCodEmp.QuotedString +
                               '  AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString +
                               '  AND RCX_DTACAD BETWEEN ' + FormatDateTime('yyyy/mm/dd', dtaDataInicial).QuotedString +
                               '                     AND ' + FormatDateTime('yyyy/mm/dd', dtaDataFinaL).QuotedString +
                               '  AND RCX_ESPDOC = "FC"  ' +
                               'ORDER BY RCX_DTACAD, RCX_DTAGRV ');
    qryConsulta.Open;

    Result := fCriaClientDatset(qryConsulta);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

class procedure TResumoDeCaixa.RetornaTransferenciasDoCaixaParaLiberacao(
  ALancamentos: TDataset);
  Var
    LDataFechamentoAnterior: TDateTime;

    LConsulta: TUniQuery;
Begin
  Try
    ALancamentos.First;

    LDataFechamentoAnterior := ALancamentos.FieldByName('RCX_DTACAD').AsDateTime + StrToTime('00:00:00');

    While Not ALancamentos.Eof Do
    Begin
      LConsulta := fCriarQuery('SELECT                                       ' +
                               '       SUM(RCX_VALDOC) * (-1) AS RCX_VALDOC, ' +
                               '       SUM(RCX_DINREC) * (-1) AS RCX_DINREC, ' +
                               '       SUM(RCX_CHQAVI) * (-1) AS RCX_CHQAVI, ' +
                               '       SUM(RCX_CHQPRE) * (-1) AS RCX_CHQPRE, ' +
                               '       SUM(RCX_CARREC) * (-1) AS RCX_CARREC, ' +
                               '       SUM(RCX_ORDREC) * (-1) AS RCX_ORDREC, ' +
                               '       SUM(RCX_VALFIN) * (-1) AS RCX_VALFIN  ' +
                               'FROM CADRCXX       ' +
                               'WHERE RCX_CODEMP = ' + ALancamentos.FieldByName('RCX_CODEMP').AsString.QuotedString +
                               '  AND RCX_CODCAX = ' + ALancamentos.FieldByName('RCX_CODCAX').AsString.QuotedString +
                               '  AND RCX_DTACAD = ' + FormatDateTime('yyyy/mm/dd', ALancamentos.FieldByName('RCX_DTACAD').AsDateTime).QuotedString +
                               '  AND RCX_DTAGRV BETWEEN ' + FormatDateTime('yyyy/mm/dd hh:mm:ss', LDataFechamentoAnterior).QuotedString +
                               '                     AND ' + FormatDateTime('yyyy/mm/dd hh:mm:ss', ALancamentos.FieldByName('RCX_DTAGRV').AsDateTime).QuotedString +
                               '  AND RCX_ESPDOC = "TF"  ');
      LConsulta.Open;

      ALancamentos.Edit;
      ALancamentos.FieldByName('RCX_FUNCAX').AsString := ALancamentos.FieldByName('RCX_DINREC').AsString;
      ALancamentos.FieldByName('RCX_VALTRA').AsString := LConsulta.FieldByName('RCX_VALDOC').AsString;
      ALancamentos.FieldByName('RCX_DINREC').AsString := LConsulta.FieldByName('RCX_DINREC').AsString;
      ALancamentos.FieldByName('RCX_CHQAVI').AsString := LConsulta.FieldByName('RCX_CHQAVI').AsString;
      ALancamentos.FieldByName('RCX_CHQPRE').AsString := LConsulta.FieldByName('RCX_CHQPRE').AsString;
      ALancamentos.FieldByName('RCX_CARREC').AsString := LConsulta.FieldByName('RCX_CARREC').AsString;
      ALancamentos.FieldByName('RCX_ORDREC').AsString := LConsulta.FieldByName('RCX_ORDREC').AsString;
      ALancamentos.FieldByName('RCX_VALFIN').AsString := LConsulta.FieldByName('RCX_VALFIN').AsString;
      ALancamentos.Post;

      LDataFechamentoAnterior := ALancamentos.FieldByName('RCX_DTAGRV').AsDateTime;

      ALancamentos.Next;
    End;
  Finally
    ALancamentos.First;

    If Assigned(LConsulta) Then
      FreeAndNil(LConsulta);
  End;
end;

function TResumoDeCaixa.RetornaTransferenciasLacresMalotesDoCaixa(ACodigoCaixa: String;
  ADataInicial, ADataFinal: TDateTime; AFechamentos: TDataset): TDataset;
  Var
    LDataFechamentoAnterior: TDateTime;

    LConsulta: TUniQuery;
Begin
  Try
    Result := fCriaClientDatSet(AFechamentos);

    LDataFechamentoAnterior := ADataInicial + StrToTime('00:00:00');

    Result.First;
    While Not Result.Eof Do
    Begin
      LConsulta := fCriarQuery('SELECT                                       ' +
                               '       SUM(RCX_VALDOC) * (-1) AS RCX_VALDOC, ' +
                               '       SUM(RCX_DINREC) * (-1) AS RCX_DINREC, ' +
                               '       SUM(RCX_CHQAVI) * (-1) AS RCX_CHQAVI, ' +
                               '       SUM(RCX_CHQPRE) * (-1) AS RCX_CHQPRE, ' +
                               '       SUM(RCX_CARREC) * (-1) AS RCX_CARREC, ' +
                               '       SUM(RCX_ORDREC) * (-1) AS RCX_ORDREC, ' +
                               '       SUM(RCX_VALFIN) * (-1) AS RCX_VALFIN  ' +
                               'FROM CADRCXX       ' +
                               'WHERE RCX_CODEMP = ' + VS_strCodEmp.QuotedString +
                               '  AND RCX_CODCAX = ' + ACodigoCaixa.QuotedString +
                               '  AND RCX_DTACAD = ' + FormatDateTime('yyyy/mm/dd', Result.FieldByName('RCX_DTACAD').AsDateTime).QuotedString +
                               '  AND RCX_DTAGRV BETWEEN ' + FormatDateTime('yyyy/mm/dd hh:mm:ss', LDataFechamentoAnterior).QuotedString +
                               '                     AND ' + FormatDateTime('yyyy/mm/dd hh:mm:ss', Result.FieldByName('RCX_DTAGRV').AsDateTime).QuotedString +
                               '  AND RCX_ESPDOC = "TF"  ');
      LConsulta.Open;

      Result.Edit;
      Result.FieldByName('RCX_FUNCAX').AsString := Result.FieldByName('RCX_DINREC').AsString;
      Result.FieldByName('RCX_VALDOC').AsString := LConsulta.FieldByName('RCX_VALDOC').AsString;
      Result.FieldByName('RCX_DINREC').AsString := LConsulta.FieldByName('RCX_DINREC').AsString;
      Result.FieldByName('RCX_CHQAVI').AsString := LConsulta.FieldByName('RCX_CHQAVI').AsString;
      Result.FieldByName('RCX_CHQPRE').AsString := LConsulta.FieldByName('RCX_CHQPRE').AsString;
      Result.FieldByName('RCX_CARREC').AsString := LConsulta.FieldByName('RCX_CARREC').AsString;
      Result.FieldByName('RCX_ORDREC').AsString := LConsulta.FieldByName('RCX_ORDREC').AsString;
      Result.FieldByName('RCX_VALFIN').AsString := LConsulta.FieldByName('RCX_VALFIN').AsString;
      Result.Post;

      LDataFechamentoAnterior := Result.FieldByName('RCX_DTAGRV').AsDateTime;

      Result.Next;
    End;
  Finally
    If Assigned(LConsulta) Then
      FreeAndNil(LConsulta);
  End;
End;

function TResumoDeCaixa.RetornaValorDePixSemTransferir(ADataCaixa: TDateTime;
  ACodigoCaixa: String; ACodigoOperador: String = ''): Double;
  Var
    LConsulta: TUniQuery;
Begin
  If fCampoTabela('SIS_VALCFG',
                  'CFGSIS',
                  ['SIS_CODCFG', 'SIS_CODEMP'],
                  ['CFG_RCXTCC', VS_strCodEmp]) = '1' Then
    Exit(0.00);

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT IFNULL(SUM(IF(RCX_RECPIX="S", RCX_ORDREC, 0)), 0) AS TOTAL ' +
                          'FROM CADRCXX ' +
                          'WHERE RCX_DTACAD=:DTACAD ' +
                          '  AND RCX_CODEMP=:CODEMP ';

    If Not ACodigoOperador.IsEmpty Then
      LConsulta.SQL.Add('  AND RCX_CODOPE="' + ACodigoOperador + '"');

    If Not ACodigoCaixa.IsEmpty Then
      LConsulta.SQL.Add('  AND RCX_CODCAX="' + ACodigoCaixa + '" ' +
                        '  AND RCX_LANFEC="N" ' +
                        '  AND RCX_ESPDOC<>"FC"');

    LConsulta.ParamByName('DTACAD').AsDateTime := ADataCaixa;
    LConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;

    LConsulta.Open;

    Result := fFormataFloat(LConsulta.FieldByName('TOTAL').AsFloat, 2);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TResumoDeCaixa.fRetornaFundoDeCaixaInformadoNaTransferencia(
  strCodigoCaixa: String; ADataDoCaixa: TDateTime): Double;
  Var
    qryConsulta: TUniQuery;
begin
  Result := 0.00;

  If (strTipoFechamento <> 'C') Or
     (fCfgSis('FECZER', varBoolean)) Then
    Exit;

  qryConsulta := fCriarQuery('SELECT IFNULL(RCX_FUNCAX, 0) AS RCX_FUNCAX, ' +
                             '   RCX_DTAGRV             ' +
                             ' FROM  CADRCXX            ' +
                             ' WHERE RCX_DTACAD=        ' + FormatDateTime('yyyy-mm-dd', ADataDoCaixa).QuotedString +
                             '   AND RCX_CODEMP=        ' + VS_strCodEmp.QuotedString +
                             '   AND RCX_CODCAX=        ' + strCodigoCaixa.QuotedString +
                             '   AND RCX_ESPDOC="TF"    ' +
                             '   AND RCX_LANFEC="N"     ' +
                             '   AND RCX_TFCANC<>"S"    ' +
                             '   AND RCX_DINREC<>0.00   ' +
                             ' ORDER BY RCX_DTAGRV DESC ' +
                             ' LIMIT 1                  ');
  qryConsulta.Open;

  If Not qryConsulta.IsEmpty Then
    Result := fFormataFloat(qryConsulta.FieldByName('RCX_FUNCAX').AsFloat, 2);

  If (Not FTransferenciaCega) Then
    Result := Result + RetornaSaldoRestanteEmDinheiroDoFundoDeCaixa(strCodigoCaixa,
                                                                    qryConsulta.FieldByName('RCX_DTAGRV').AsDateTime,
                                                                    ADataDoCaixa);

  FreeAndNil(qryConsulta);
end;

function TResumoDeCaixa.RecebimentoFoiLancadoNaCADRCXX(ASeqCon: Integer;
  ACodigoEmpresa: String; ADataCaixa: TDateTime;
  ACodigoDoCaixa: String): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADRCXX ' +
                          'WHERE RCX_DTACAD=:DTACAD ' +
                          '  AND RCX_CODEMP=:CODEMP ' +
                          '  AND RCX_SEQCON=:SEQCON ';

    If Not ACodigoDoCaixa.IsEmpty Then
    Begin
      LConsulta.SQL.Add('  AND RCX_CODCAX=:CODCAX ');
      LConsulta.ParamByName('CODCAX').AsString := ACodigoDoCaixa;
    End;

    LConsulta.SQL.Add('ORDER BY RCX_DTACAD DESC ' +
                      'LIMIT 1 ');

    LConsulta.ParamByName('DTACAD').AsDateTime := ADataCaixa;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger := ASeqcon;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TResumoDeCaixa.RetornaCodigoDoCaixaDoLancamento(ASeqcon: Integer;
  ADataCadastro: TDateTime; ACodigoEmpresa: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  Result := '';

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT RCX_CODCAX ' +
                          'FROM CADRCXX ' +
                          'WHERE RCX_DTACAD<=:DTACAD ' +
                          '  AND RCX_CODEMP=:CODEMP  ' +
                          '  AND RCX_SEQCON=:SEQCON  ';

    LConsulta.SQL.Add('ORDER BY RCX_DTACAD DESC ' +
                      'LIMIT 1 ');

    LConsulta.ParamByName('DTACAD').AsDateTime := ADataCadastro;
    LConsulta.ParamByName('CODEMP').AsString   := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger  := ASeqcon;

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
      Result := LConsulta.FieldByName('RCX_CODCAX').AsString;

  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
End;

class function TResumoDeCaixa.RetornaDataDoLancamentoCaixa(ASeqcon: Integer;
  ADataCadastro: TDateTime; ACodigoEmpresa, ACodigoCaixa: String): TDateTime;
  Var
    LConsulta: TUniQuery;
Begin
  Result := 0;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT RCX_DTACAD ' +
                          'FROM CADRCXX ' +
                          'WHERE RCX_DTACAD<=:DTACAD ' +
                          '  AND RCX_CODEMP=:CODEMP ' +
                          '  AND RCX_SEQCON=:SEQCON ';

    If Not ACodigoCaixa.IsEmpty Then
      LConsulta.SQL.Add('  AND RCX_CODCAX=:CODCAX ');

    LConsulta.SQL.Add('ORDER BY RCX_DTACAD DESC ' +
                      'LIMIT 1 ');

    LConsulta.ParamByName('DTACAD').AsDateTime := ADataCadastro;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger := ASeqcon;

    If Not ACodigoCaixa.IsEmpty Then
      LConsulta.ParamByName('CODCAX').AsString := ACodigoCaixa;

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
      Result := LConsulta.FieldByName('RCX_DTACAD').AsDateTime;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
End;

function TResumoDeCaixa.RetornaDataMovimentacaoBancariaTransferenciaAutomatica(ACodigoPortador: String;
  ADataCaixa: TDateTime): TDateTime;
begin
  Result := VS_Date;
  If FUtilizaContabilidade Then
    Result := ADataCaixa;

  If FTipoDataTFCaixa = tdtfDataMovimentoCaixa Then
    Result := ADataCaixa;

  If Not FValidarDiaUtilPortadorOrdemPagamentoAut Then
    Exit;

  If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [ACodigoPortador]) = 'S' Then
    Result := fAcertaDataParaDiaUtil(Result);
end;

function TResumoDeCaixa.RetornaPortadorCADRECNoResumoDeCaixa(AAutoIncremChavePix,
  APortadorCaixa, APortadorTFAutomatica: String; AValorPix, ASomaModalidades: Double; ARecebidoQRCode: Boolean; const AValidarValorModalidade : Boolean): String;
  Var
    LPortadorPix: String;
begin
  Result := APortadorCaixa;

  If fFormataFloat(AValorPix, 2) <= 0.00 Then
    Exit;

  If (AValidarValorModalidade) Then
  Begin
    If fFormataFloat(AValorPix, 2) < fFormataFloat(ASomaModalidades, 2) Then
      Exit;
  End;

  If Not ARecebidoQRCode Then
    LPortadorPix := APortadorTFAutomatica
  Else
    LPortadorPix := TPixDao.Create.RetornaPortadorChavePix(AAutoIncremChavePix);

  If LPortadorPix.IsEmpty Then
    Exit;

  Result := LPortadorPix;
end;

function TResumoDeCaixa.RetornaPortadorTFAutomatica(AFaturamento: Boolean = False; APortadorCredito: String = ''): String;
  Var
    LDigPortador : TfrmDigPortador;
begin
  Result := EmptyStr;

  If AFaturamento Then
  Begin
    If Not FTransferenciaOrdemPagamentoAutomaticaFaturamento Then
      Exit;
  End
  Else If Not FTransferenciaOrdemPagamentoAutomatica Then
    Exit;

  If Not FDeveEscolherPortadorOrdemPagamentoAut Then
    Exit(FPortadorOrdemPagamento);

  If Not fEmptyStr(APortadorCredito) Then
    Exit(APortadorCredito);

  pCriarFormularios(TfrmDigPortador, LDigPortador);
  Try
    Try
      LDigPortador.bolMostraVendedor := False;
      LDigPortador.pnlHistorico.Visible := False;
      LDigPortador.edtPorBai.Text :=  FPortadorOrdemPagamento;
      LDigPortador.pCarregaPortador;
      LDigPortador.ShowModal;
      If LDigPortador.blnConfirma Then
        Result := LDigPortador.strCodPor;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LDigPortador);
  End;
end;

function TResumoDeCaixa.RetornaRegistrosAtualizadosCadRcxx(
  ASeqcon, ACodigoEmpresa, ACodigoCaixa: String;
  ADataLancamento: TDateTime): TDataset;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * FROM CADRCXX ' +
                          'WHERE RCX_DTACAD=:DTACAD ' +
                          '  AND RCX_CODEMP=:CODEMP ' +
                          '  AND RCX_SEQCON=:SEQCON ';

    If Not ACodigoCaixa.IsEmpty Then
    Begin
      LConsulta.SQL.Add('  AND RCX_CODCAX=:CODCAX');
      LConsulta.ParamByName('CODCAX').AsString := ACodigoCaixa;
    End;

    LConsulta.ParamByName('DTACAD').AsDateTime := ADataLancamento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('SEQCON').AsInteger := StrToInt(ASeqcon);
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TResumoDeCaixa.RetornaSaldoRestanteEmDinheiroDoFundoDeCaixa(ACodigoCaixa: String;
  ADataGravacao: TDateTime; ADataDoCaixa: TDateTime): Double;
  Var
    qryConsulta: TUniQuery;
begin
  Result := 0.00;

  If (strTipoFechamento <> 'C') Then
    Exit;

   If (fCfgSis('FECZER', varBoolean)) Then
    Exit;

   If ADataGravacao = 0 Then
     Exit;

  qryConsulta := fCriarQuery('SELECT SUM(IFNULL(RCX_DINREC, 0)) AS RCX_DINREC, ' +
                             '   RCX_DTAGRV             ' +
                             ' FROM  CADRCXX            ' +
                             ' WHERE RCX_DTACAD=        ' + FormatDateTime('yyyy-mm-dd', ADataDoCaixa).QuotedString +
                             '   AND RCX_CODEMP=        ' + VS_strCodEmp.QuotedString +
                             '   AND RCX_CODCAX=        ' + ACodigoCaixa.QuotedString +
                             '   AND RCX_DTAGRV >       ' + FormatDateTime('yyyy-mm-dd hh:mm:ss', ADataGravacao).QuotedString +
                             '   AND RCX_ESPDOC<>"FC"   ' +
                             '   AND RCX_LANFEC="N"     ' +
                             '   AND RCX_TFCANC<>"S"    ' +
                             '   AND RCX_DINREC<>0.00   ');
  qryConsulta.Open;

  If Not qryConsulta.IsEmpty Then
    Result := fFormataFloat(qryConsulta.FieldByName('RCX_DINREC').AsFloat, 2);

  FreeAndNil(qryConsulta);
End;

class function TResumoDeCaixa.RetornaSQLOperadoresDireitosDeAcessoLiberaTF: String;
begin
  Result := 'SELECT OPE_CODOPE, ' +
            '       DIR_NOMFRM  ' +
            'FROM DIROPE ' +
            'WHERE DIR_NOMFRM IN ("VISMODDINLIBCAX",' +
            '                     "VISMODCARLIBCAX", ' +
            '                     "VISMODCHVLIBCAX", ' +
            '                     "VISMODCHPLIBCAX", ' +
            '                     "VISMODORDLIBCAX", ' +
            '                     "VISDIVLIBCAX") ' +
            'ORDER BY DIR_NOMFRM, ' +
            '         OPE_CODOPE ';
end;

class procedure TResumoDeCaixa.ValidaArquivosPAFJaGerados(
  var AListaArquivos: TStringList; ADataCaixa: TDateTime);
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT PAF_ARQUIV ' +
                          'FROM RELPAF ' +
                          'WHERE PAF_DINGER>=:DTACAI ' +
                          '  AND PAF_DFIGER<=:DTACAI ' +
                          '  AND PAF_EMPLOG=:CODEMP ' +
                          '  AND PAF_SUCESS="S" ' +
                          'GROUP BY PAF_ARQUIV ' +
                          'ORDER BY PAF_DTAGER DESC, PAF_HRAGER DESC ';

    LConsulta.ParamByName('DTACAI').AsDateTime := ADataCaixa;
    LConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      If AListaArquivos.IndexOf(LConsulta.FieldByName('PAF_ARQUIV').AsString) >= 0 Then
        AListaArquivos.Delete(AListaArquivos.IndexOf(LConsulta.FieldByName('PAF_ARQUIV').AsString));

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TResumoDeCaixa.VerificaBaixaVinculadaComCartoesECheques(
  ADataFechamento, ADataBaixa: TDateTime; ASeqCon: Integer;
  AEmpresaBaixa, ACodigoCaixa: String): Boolean;
  Var
    LFechamento,
    LLancamentos,
    LDocumentos: TDataset;

    LNaoTransferido: Boolean;

    LMensagem: String;
begin
  LMensagem := '';

  LFechamento := fRetornaDadosUltimoFechamento(ACodigoCaixa,
                                               AEmpresaBaixa);

  LLancamentos := fRetornaDadosLancamentosCaixaSeqCon(ASeqCon.ToString,
                                                      AEmpresaBaixa,
                                                      ADataFechamento);

  Try
    LNaoTransferido := LFechamento.FieldByName('RCX_DTACAD').AsDateTime >=
                       ADataFechamento;
    If LNaoTransferido Then
      LNaoTransferido := LLancamentos.FieldByName('RCX_LANFEC').AsString.Equals('S');

    LDocumentos := untFuncoesSimples.fCarregaCartoesTransferidos(ASeqCon,
                                                                 AEmpresaBaixa,
                                                                 ADataBaixa,
                                                                 LNaoTransferido);
    If Not LDocumentos.IsEmpty Then
      LMensagem := 'Há cartões '+IfThen(LNaoTransferido,'não','') + ' transferidos relativos a essa baixa!.' + #13 +
                   IfThen(LNaoTransferido,'Deve ser transferido o cartão referente a liberação: '+ LDocumentos.FieldByName('MCA_NUMCCD').AsString  +  ' antes do estorno ser efetuado.'
                   ,'Para estornar este documento cancelar o sequencial: '+LDocumentos.FieldByName('MCA_SEQTRF').AsString+'.' + #13 +
                   'F1 - LANÇAMENTOS > TF - TRANSFERÊNCIA > [F8] CANCELAMENTO DE TRANSFERÊNCIAS');

    If LDocumentos.IsEmpty Then
    Begin
      LDocumentos := untFuncoesSimples.fCarregaChequesTransferidos(ASeqCon,
                                                                   AEmpresaBaixa,
                                                                   ADataBaixa,
                                                                   LNaoTransferido);

      If Not LDocumentos.IsEmpty Then
        LMensagem := 'Há cheques '+IfThen(LNaoTransferido,'não','') +  ' transferidos relativos a essa baixa!' + #13 +
                      IfThen(LNaoTransferido,'Devem ser transferidos os cheques: '+LDocumentos.FieldByName('CHQ_NUMCHQ').AsString+ ' antes do estorno ser efetuado.',
                      'Para estornar este documento cancelar o sequencial: '+ LDocumentos.FieldByName('CHQ_SEQTRF').AsString+'.' + #13 +
                      'F1 - LANÇAMENTOS > TF - TRANSFERÊNCIA > [F8] CANCELAMENTO DE TRANSFERÊNCIAS');
    End;

    Result := Not LDocumentos.IsEmpty;

    If Result Then
      fMensagem('ATENÇÃO', LMensagem, ['OK']);
  Finally
    FreeAndNil(LFechamento);
    FreeAndNil(LLancamentos);

    If Assigned(LDocumentos) Then
      FreeAndNil(LDocumentos);
  End;
end;

function TResumoDeCaixa.VerificaSeArquivoPAFFoiCriado(ADataCaixa: TDateTime): Boolean;
  Var
    LTipoArquivos: TStringList;

    LRcxGeracaoArquivoPAF: TfrmRcxGeracaoArquivoPAF;
begin
  If Not FValidarArquivoPAF Then
    Exit(True);

  LTipoArquivos := TStringList.Create;
  LTipoArquivos.Add('I');
  LTipoArquivos.Add('II');
  LTipoArquivos.Add('IV');

  Try
    TResumoDeCaixa.ValidaArquivosPAFJaGerados(LTipoArquivos, ADataCaixa);

    Result := LTipoArquivos.Count = 0;

    If Not Result Then
    Begin
      pCriarFormularios(TfrmRcxGeracaoArquivoPAF, LRcxGeracaoArquivoPAF);
      LRcxGeracaoArquivoPAF.DataCaixa := ADataCaixa;
      LRcxGeracaoArquivoPAF.ListaArquivosNaoGerados := LTipoArquivos;
      LRcxGeracaoArquivoPAF.ShowModal;

      FreeAndNil(LRcxGeracaoArquivoPAF);
    End;
  Finally
    FreeAndNil(LTipoArquivos);
  End;
end;

function TResumoDeCaixa.fRetornaSaldoCaixa(strCodigoCaixa: String;
  var dtaDataCaixa: TDateTime; strCodigoEmpresa: String): Double;
begin
  If strTipoFechamento = 'C' Then
    Result := fRetornaSaldoDoCaixa(strCodigoCaixa,
                                   dtaDataCaixa,
                                   strCodigoEmpresa)
  Else
    Result := untCadRcxx.fRetornaSaldoCaixa(dtaDataCaixa,
                                            strCodigoEmpresa);
end;

function TResumoDeCaixa.fRetornaSaldoCaixaCampo(strCampo, strCodigoCaixa,
  strCodigoEmpresa, strCodigoOperador: String;
  ARecebidoPorPix: Boolean; ARecebidoPorPixAvulso: Boolean; AApenasOrdemPagamento: Boolean): Double;
begin
  If strTipoFechamento = 'C' Then
    Result := fRetornaSaldoDoCaixaPeloCampo(strCampo,
                                            strCodigoCaixa,
                                            strCodigoEmpresa,
                                            strCodigoOperador,
                                            ARecebidoPorPix,
                                            ARecebidoPorPixAvulso,
                                            AApenasOrdemPagamento)
  Else
    Result := untCadRcxx.fRetornaSaldoCaixaCampo(strCampo,
                                                 strCodigoEmpresa,
                                                 strCodigoOperador,
                                                 ARecebidoPorPix,
                                                 ARecebidoPorPixAvulso,
                                                 AApenasOrdemPagamento);
end;

function TResumoDeCaixa.fRetornaSaldoDoCaixaPeloCampo(strCampo: String;
                                                      strCodigoCaixa: String;
                                                      strCodigoEmpresa: String = '';
                                                      strCodigoOperador: String = '';
                                                      ARecebidoPorPix: Boolean = False;
                                                      ARecebidoPorPixAvulso: Boolean = False;
                                                      AApenasOrdemPagamento: Boolean = False): Double;
  Var
    qryConsulta: TUniQuery;
    fltSaldo   : Double;

    strSQL,
    strOperadorFechamento: String;

    dtaDataUltimoFechamento: TDateTime;
begin
  If strCodigoEmpresa.IsEmpty Then
    strCodigoEmpresa := VS_strCodEmp;

  qryConsulta := fCriaQuery(nil);
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT                              ';
    strSQL := strSQL + '  ' + strCampo + ',                 ';
    strSQL := strSQL + '  RCX_DTACAD,                       ';
    strSQL := strSQL + '  RCX_CODOPE                        ';
    strSQL := strSQL + 'FROM                                ';
    strSQL := strSQL + '  CADRCXX                           ';
    strSQL := strSQL + 'WHERE                               ';
    strSQL := strSQL + '     RCX_CODEMP = ' + strCodigoEmpresa.QuotedString;
    strSQL := strSQL + ' AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString;
    strSQL := strSQL + ' AND RCX_IDEFEC = "X"               ';

    strSQL := strSQL + 'ORDER BY                            ';
    strSQL := strSQL + '  RCX_IDEFEC DESC, RCX_DTACAD DESC, ';
    strSQL := strSQL + '  RCX_DTAGRV DESC                   ';
    strSQL := strSQL + 'LIMIT 1                             ';

    qryConsulta.SQL.Text := strSQL;
    qryConsulta.Open;

    dtaDataUltimoFechamento := qryConsulta.FieldByName('RCX_DTACAD').AsDateTime;
    fltSaldo                := qryConsulta.FieldByName(strCampo).AsFloat;
    strOperadorFechamento   := qryConsulta.FieldByName('RCX_CODOPE').AsString;

    strSQL := '';
    strSQL := strSQL + 'SELECT                            ';
    strSQL := strSQL + '  SUM(' + strCampo + ') AS TOTLAN ';
    strSQL := strSQL + 'FROM                              ';
    strSQL := strSQL + '  CADRCXX                         ';
    strSQL := strSQL + 'WHERE RCX_DTACAD >= ' + FormatDateTime('yyyy-mm-dd', dtaDataUltimoFechamento).QuotedString;
    strSQL := strSQL + '  AND RCX_CODEMP = ' + strCodigoEmpresa.QuotedString;
    strSQL := strSQL + '  AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString;
    strSQL := strSQL + '  AND ' + strCampo + ' <> 0       ';
    strSQL := strSQL + '  AND (RCX_IDEFEC <> "X" OR RCX_IDEFEC IS NULL) ';
    strSQL := strSQL + '  AND RCX_LANFEC = "N"            ';
    If Not strCodigoOperador.IsEmpty Then
      strSQL := strSQL + '  AND RCX_CODOPE = ' + strCodigoOperador.QuotedString;

    If ARecebidoPorPix Then
    Begin
      If ARecebidoPorPixAvulso Then
        strSQL := strSQL + '  AND (RCX_RECPIX="S") '
      Else
        strSQL := strSQL + '  AND NOT (RCX_ESPDOC="TF" AND RCX_RECPIX="S") ';
    End
    Else If AApenasOrdemPagamento Then
      strSQL := strSQL + '  AND (RCX_RECPIX="N") ';

    qryConsulta.Close;
    qryConsulta.SQL.Text := strSQL;
    qryConsulta.Open;

    If ((strCodigoOperador.IsEmpty) Or (strCodigoOperador = strOperadorFechamento)) And
       (Not (ARecebidoPorPix And ARecebidoPorPixAvulso)) Then
      fltSaldo  := fltSaldo + qryConsulta.FieldByName('TOTLAN').AsFloat
    Else
      fltSaldo  := qryConsulta.FieldByName('TOTLAN').AsFloat;

    Result := fltSaldo;
  finally
    FreeAndNil(qryConsulta);
  end;
End;

function TResumoDeCaixa.fRetornaSQLTransferenciaDeValores(strCodigoCaixa,
  strCodigoOperador: String; blnAgruparOperador: Boolean): String;
  Var
    cdsUltimoFechamento: TDataset;
begin
  Result := ' SELECT ';

  If (blnAgruparOperador) Then
  Begin
    Result := Result + ' CONCAT(RCX_CODOPE, "-", CADOPE.OPE_NOMOPE) AS RCX_CODOPE, ';
    Result := Result + ' SUM(RCX_DINREC + RCX_CHQAVI + RCX_CHQPRE + RCX_CARREC + RCX_ORDREC + RCX_VALFIN) AS RCX_TOTGER,  ';
  End;

  Result := Result + '  SUM(RCX_DINREC) AS RCX_DINREC, ';
  Result := Result + '  SUM(RCX_CHQAVI) AS RCX_CHQAVI, ';
  Result := Result + '  SUM(RCX_CHQPRE) AS RCX_CHQPRE, ';
  Result := Result + '  SUM(RCX_CARREC) AS RCX_CARREC, ';
  Result := Result + '  SUM(RCX_ORDREC) AS RCX_ORDREC, ';
  Result := Result + '  SUM(RCX_VALFIN) AS RCX_VALFIN  ';
  Result := Result + ' FROM ';
  Result := Result + '  CADRCXX ';

  If (blnAgruparOperador) Then
    Result := Result + ' LEFT JOIN CADOPE ON RCX_CODOPE = CADOPE.OPE_CODOPE ';

  cdsUltimoFechamento := fRetornaDadosUltimoFechamento(strCodigoCaixa, VS_strCodEmp);

  Result := Result + ' WHERE ';
  Result := Result + ' ((CADRCXX.AUTOINCREM = "' + cdsUltimoFechamento.FieldByName('AUTOINCREM').AsString + '") OR (';

  Result := Result + '  RCX_DTACAD >= :DTACAD AND ';

  Result := Result + '  RCX_CODEMP = :CODEMP AND ';

  If Not  strCodigoOperador.IsEmpty Then
    Result := Result + ' RCX_CODOPE = ' + strCodigoOperador.QuotedString + ' AND ';

  Result := Result + ' RCX_CODCAX = ' + strCodigoCaixa.QuotedString + ' AND ';
  Result := Result + ' RCX_ESPDOC <> "FC" AND ';
  Result := Result + ' RCX_LANFEC = "N"))     ';

  If (blnAgruparOperador) Then
    Result := Result + ' GROUP BY RCX_CODOPE ';

  FreeAndNil(cdsUltimoFechamento);
end;

function TResumoDeCaixa.fRetornaTextoDaTravaDaTransferencia(
  strCodigoCaixa: String): String;
begin
  Result := 'TRANSF' + VS_strCodEmp;
  If strTipoFechamento = 'C' Then
    Result := Result + '-' + strCodigoCaixa;
end;

function TResumoDeCaixa.fRetornaTextoDaTravaDoContasAPagar(
  strCodigoCaixa: String): String;
begin
  Result := 'BAIXA_CTAPAG' + VS_strCodEmp;
  If strTipoFechamento = 'C' Then
    Result := Result + '-' + strCodigoCaixa;
end;

function TResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(
  strCodigoCaixa: String): String;
begin
  Result := 'RCXF7_' + VS_strCodEmp;
  If strTipoFechamento = 'C' Then
    Result := Result + '-' + strCodigoCaixa;
end;

function TResumoDeCaixa.fVerificaSaldoMaximo(fltValor: Double; strCodigoOperador, strCodigoCaixa: String;
  const blnEmTransacao: Boolean = False): Boolean;
begin
  If strTipoFechamento = 'C' Then
    Result := fVerificaSaldoMaximoDoCaixa(fltValor,
                                          strCodigoOperador,
                                          strCodigoCaixa)
  Else
    Result := untCadRcxx.fVerificaSaldoMaximo(fltValor,
                                              strCodigoOperador,
                                              blnEmTransacao);
end;

function TResumoDeCaixa.fVerificaSaldoMaximoDoCaixa(fltValor: Double;
                                                    strCodigoOperador: String;
                                                    strCodigoCaixa: String): Boolean;
var
  fltValConfig : Double;
  fltSaldo     : Double;
  objLiberacao : ILiberacao;
begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao();

  fltValConfig := fFormataFloat(fCfgSis('RCXSDM', varDouble), 2);
  Result := True;

  If (fltValConfig > 0) And (fltValor > 0) Then
  Begin
    fltSaldo := fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa, '', strCodigoOperador);
    If (fFormataFloat(fltSaldo + fltValor, 2) > fltValConfig) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Liberar saldo maior que o permitido nas configurações');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('Com esta operação de R$ ' + FormatFloat('#,##0.00', fltValor) + ' em DINHEIRO,');
      objLiberacao.objMsgLibera.pAddTexto('o caixa do operador ' + strCodigoOperador + ' - ' + fRetNomeOperador(strCodigoOperador));
      objLiberacao.objMsgLibera.pAddTexto('irá ultrapassar o valor máximo permitido de R$ ' + FormatFloat('#,##0.00', fltValConfig));
      objLiberacao.objMsgLibera.pAddTexto('Será necessário senha de liberação para prosseguir.');

      objLiberacao.strDirAce := 'DIRRCXSALDOMAIORQUEPERMITIDO';
      objLiberacao.strMsgSen := 'Lançamento no caixa  - Saldo maior que o máximo permitido';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strCodigoOperador;
      objLiberacao.strCodDig := strCodigoOperador;

      Result := objLiberacao.fLibera;
    End;
  End;
end;

procedure TResumoDeCaixa.GravaReciboTransferenciaAutomatica(ASeqRcx,
  ACodigoEmpresa, ARecibo, ACodigoOperador: String; ASeqConTrf: Integer);
  Var
    LInsert: TUniQuery;
begin

  If fEmptyStr(ASeqRcx) Then
    Exit;

  LInsert := fCriaQuery(Nil);

  Try
    LInsert.SQL.Text := 'SELECT * FROM CADRTF WHERE FALSE';
    LInsert.Open;

    LInsert.Insert;
    LInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADRTF', VS_strCodEmp);
    LInsert.FieldByName('RTF_SEQRCX').AsString := ASeqRcx;
    LInsert.FieldByName('RTF_CODEMP').AsString := ACodigoEmpresa;
    LInsert.FieldByName('RTF_RECIBO').AsString := ARecibo;
    LInsert.FieldByName('RTF_CODOPE').AsString := ACodigoOperador;
    LInsert.FieldByName('RTF_RCXCON').AsInteger := ASeqConTrf;
    LInsert.Post;
  Finally
    LInsert.Close;

    FreeAndNil(LInsert);
  End;
end;

function TResumoDeCaixa.InserirRegistroTFOrdemPagtoCaixa(AOperadorCaixa,
  AEmpresaCaixa: String; ADataCaixa: TDate; AVlrOrdPgto: Double;
  ACodigoDoCaixa: String; ASeqConTransf, ASeqConRecebimento: Integer; ARecebidoPix,
  APortador: String): Boolean;
  Var
    LEmpresaCaixa,
    LAutoIncrem: String;
begin
  Try
    LAutoIncrem := '';

    LEmpresaCaixa := VS_strCodEmp;
    If Not AEmpresaCaixa.IsEmpty Then
      LEmpresaCaixa := AEmpresaCaixa;

    Result := fGravaCadRcx(LAutoIncrem,                                                  //autoincrem
                           '',                                                           //Código do Cliente
                           AOperadorCaixa,                                               //Operador
                           '',                                                           //Documento
                           'TF',                                                         //Espécie
                           LEmpresaCaixa,                                                //Empresa
                           ADataCaixa,                                                   //Data de Cadastro
                           fTime(),                                                         //Hora de Cadastro
                           '',                                                           //Duplicata {**Req. 97805**20/04/2018**WS**}
                           '',                                                           //Parcela   {**Req. 97805**20/04/2018**WS**}
                           'REF. TRANSF. CX./PORT: ' + APortador +'/',                   //Descrição
                           '',                                                           //Juros / Dessconto
                           '',                                                           //Identificação de Fechamento
                           '',                                                           //Forma de Pagamento
                           AVlrOrdPgto * (-1),                                           //Valor do Documento
                           0.00,                                                         //Desconto Recebido
                           0.00,                                                         //Juros Recebido
                           0.00,                                                         //Valor em dinheiro
                           0.00,                                                         //Valor em Cheque à Vista
                           0.00,                                                         //Valor em Cheque Pré
                           0.00,                                                         //Valor em Cartão
                           AVlrOrdPgto * (-1),                                           //Valor em Ordem de Pagamento
                           0.00,                                                         //Valor de Crédito de Cliente
                           0.00,                                                         //Valor em Financiamento
                           0.0,                                                          //Valor em outras modalidades
                           0.0,                                                          //Valor de venda a prazo
                           '',                                                           //Num. do Romaneio
                           ASeqConTransf,                                                //Sequencial de Controle
                           0,                                                            //Sequencial de Baixa (Duplicata)
                           fCfgSisL('SQFCRX'),                                           //Sequencial de Fechamento parcial de caixa
                           LEmpresaCaixa,                                                //Empresa da duplicata
                           '',                                                           //Motivo do desconto
                           2,                                                            //Identificação do Caixa
                           0.00,
                           0.00,
                           0.00,
                           0.00,
                           0.00,
                           'N',
                           '',
                           ACodigoDoCaixa,
                           '',
                           0.00,
                           False,
                           0.00,
                           '',
                           0,
                           ARecebidoPix,                                                 //Recebido por Pix
                           ASeqConRecebimento);

      If Not Result Then
        Raise Exception.Create('Não foi possível gravar a transferência da ordem de pagamento no caixa.');
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TResumoDeCaixa.InserirRegistroTFOrdemPagtoNaMOVBAN(AOperadorCaixa,
  AEmpresaCaixa: String; ADataCaixa: TDate; AVlrOrdPgto: Double; ACodigoDoCaixa,
  ACodigoCliente: String; ASeqConTransf: Integer; APortador, ANomeFormulario,
  ASeqRcx: String; AStrAutoInc : String = ''): Boolean;
  Var
    LBanTrf: TBanTrfDS;

    LListaBanTrf: TListaBanTrf;

    LSeqLan,
    LEmpresaCaixa,
    LCliente,
    LPortadorDescricao,
    LPlanodeContas,
    LImpressao,
    LDescricao: String;

    LDataMovimentacaoBancaria: TDateTime;
    LTransferenciaLiberada: String;
begin
  Try
    LImpressao := EmptyStr;
    LDescricao := EmptyStr;

    LTransferenciaLiberada := 'S';
    If fCfgSis('USAAUT', varBoolean) Then
    Begin
      If fCfgSis('RCXTCC', varString) = '2' Then
        LTransferenciaLiberada := 'N';
    End;

    LEmpresaCaixa := VS_strCodEmp;
    If Not AEmpresaCaixa.IsEmpty Then
      LEmpresaCaixa := AEmpresaCaixa;

    LDataMovimentacaoBancaria := RetornaDataMovimentacaoBancariaTransferenciaAutomatica(APortador, ADataCaixa);

    FDataGrvMovBanAdiantamento := LDataMovimentacaoBancaria;

    LPlanodeContas := fCfgSis('CTTROP');
    LPortadorDescricao := APortador + '-' + fRetNomPortador(APortador);

    If Not ACodigoCliente.IsEmpty Then
      LCliente := ACodigoCliente + '-' + fRetNomCliente(ACodigoCliente);

    LDescricao := 'TRANSF. DE CAIXA ( ORDEM DE PAGAMENTO )';

    LImpressao := LImpressao + LDescricao + #13#10;
    LImpressao := LImpressao + fPadR('PORTADOR: ' + LPortadorDescricao ,39) + #13#10;
    LImpressao := LImpressao +       'VALOR...: ' + fPadL(FloatToStrF(AVlrOrdPgto,ffFixed,12,2),12) + #13#10 + #13#10;

    GravaReciboTransferenciaAutomatica(ASeqRcx,
                                       LEmpresaCaixa,
                                       LImpressao,
                                       AOperadorCaixa,
                                       ASeqConTransf);

    LBanTrf := TBanTrfDS.Create;
    LBanTrf.strCodOpe := AOperadorCaixa;
    LBanTrf.strCodEmp := LEmpresaCaixa;
    LBanTrf.strDescri := 'TF CAIXA (ORD) - ' + IIF(LCliente <> '', LCliente, LPortadorDescricao);
    LBanTrf.fltValDoc := AVlrOrdPgto;
    LBanTrf.fltDinRec := 0.00;
    LBanTrf.fltChqAvi := 0.00;
    LBanTrf.fltChqPre := 0.00;
    LBanTrf.fltCarRec := 0.00;
    LBanTrf.fltOrdRec := AVlrOrdPgto;
    LBanTrf.fltValFin := 0.00;

    LListaBanTrf := TListaBanTrf.Create;
    LListaBanTrf.Add(LBanTrf);

    {*******************************************}
    {* REALIZA GRAVAÇÃO DO MOVBAN              *}
    {****************************************AF*}
    LSeqLan := fGravaMovBan(LPlanoDeContas,                                    // Centro de Custo
                            APortador,                                         // Portador da Baixa
                            AOperadorCaixa,                                    // Operador da Baixa
                            LDataMovimentacaoBancaria,                         // Data do Lançamento
                            fTime(),                                           // Hora do Lançamento
                            '',                                                // Numero do Documento
                            'C',                                               // Credito / Debito
                            LEmpresaCaixa,                                     // Empresa da Baixa
                            AVlrOrdPgto,                                       // Valor Do Lançamento
                            'TF CAIXA (ORD) - ' + IIF(Not LCliente.IsEmpty, LCliente, LPortadorDescricao), // Histórico 1
                            '',                                                // Histórico 2
                            '',                                                // Cliente da Duplicata
                            '',                                                // Fornecedor da Duplicata
                            '',                                                // Número da Duplicata
                            0,                                                 // Sequencial de Baixa
                            'A',                                               // Parcela da Duplicata
                            LEmpresaCaixa,                                     // Empresa da Duplicata
                            '',                                                // Série
                            '',                                                // Codigo do Evento
                            '',                                                // Documento da Baixa
                            Nil,                                               // Log Bancário
                            ASeqConTransf,                                     // Sequencial de Transf.
                            0,
                            '',
                            '',
                            '',
                            '',
                            '',
                            '',
                            1,
                            True,
                            LListaBanTrf,
                            '',
                            LTransferenciaLiberada);

    FreeAndNil(LBanTrf);
    FreeAndNil(LListaBanTrf);

    FSeqLanTransferencia := LSeqLan;

    If LSeqLan.IsEmpty Then
      Raise Exception.Create('Ocorreu um erro na gravação do MOVBAN da transferência da Ordem de Pagamento automática.!');

    Result := True;

    untLogCba.GravaLogCba(fCampoTabela('AUTOINCREM', 'MOVBAN', ['CTB_SEQLAN'], [LSeqLan]),
                          'INCLUSÃO - TRANSFERÊNCIA',
                          ANomeFormulario,
                          '',
                          Nil,
                          AOperadorCaixa);

    If Not FEmptyStr(AStrAutoInc) Then
       pAtualizaDataLanctoCadRec(AStrAutoInc, LDataMovimentacaoBancaria);

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TResumoDeCaixa.fCupomFiscalImpresso(strCodigoCaixa: String;
                                             dtaDataDoCaixa: TDateTime): Boolean;
  Var
    qryConsulta: TUniQuery;
    strSQL     : String;
begin

  Try

    qryConsulta := fCriaQuery;

    strSQL := ' SELECT "TRUE"                     ' +
              '   FROM MOVGER                     ' +
              '  WHERE GER_DTAENT = :DTAENT       ' +
              '    AND GER_CODEMP = :CODEMP       ' +
              '    AND GER_ESPDOC IN ("IF", "IV") ' +
              '    AND GER_IMPRES = 0             ';

    If (strTipoFechamento = 'C') Then
    Begin
      strSQL := strSQL + ' AND (GER_NUMDOC, GER_CODEMP, GER_ESPDOC) IN    ' +
                         '     (SELECT RCX_NUMDOC, RCX_EMPDUP, RCX_ESPDOC ' +
                         '        FROM CADRCXX WHERE                      ' +
                         '             RCX_DTACAD = :DTAENT               ' +
                         '         AND RCX_CODEMP = :CODEMP               ' +
                         '         AND RCX_CODCAX = :CODCAX)              ';
    End;

    strSQL := strSQL + '  UNION ALL ';

    strSQL := strSQL + ' SELECT "TRUE"                     ' +
                       '   FROM NOTGER                     ' +
                       '  WHERE GER_DTAENT = :DTAENT       ' +
                       '    AND GER_CODEMP = :CODEMP       ' +
                       '    AND GER_ESPDOC IN ("IF", "IV") ' +
                       '    AND GER_IMPRES = 0             ';

    If (strTipoFechamento = 'C') Then
    Begin
      strSQL := strSQL + ' AND (GER_NUMDOC, GER_CODEMP, GER_ESPDOC) IN    ' +
                         '     (SELECT RCX_NUMDOC, RCX_EMPDUP, RCX_ESPDOC ' +
                         '        FROM CADRCXX WHERE                      ' +
                         '             RCX_DTACAD = :DTAENT               ' +
                         '         AND RCX_CODEMP = :CODEMP               ' +
                         '         AND RCX_CODCAX = :CODCAX)              ';
    End;

    qryConsulta.SQL.Text := strSQL;
    qryConsulta.ParamByName('DTAENT').AsDateTime := dtaDataDoCaixa;
    qryConsulta.ParamByName('CODEMP').AsString   := VS_strCodEmp;

    If (strTipoFechamento = 'C') Then
      qryConsulta.ParamByName('CODCAX').AsString   := strCodigoCaixa;

    qryConsulta.Open;

    Result := qryConsulta.IsEmpty;


  Finally

    FreeAndNil(qryConsulta);

  End;

end;

function TResumoDeCaixa.fEhNecessarioFecharOCaixa(blnFaturamento: Boolean;
  out dtaDataLancamento: TDateTime; strCodigoCaixa: String;
  blnMostraMensagem: Boolean; strCodigoEmpresa: String): Boolean;
  Var
    qryConsulta: TUniQuery;
begin
  If fEmptyStr(strCodigoEmpresa) Then
    strCodigoEmpresa := VS_strCodEmp;

  dtaDataLancamento := VS_Date;

  If Not fCfgSis('USARCX', varBoolean, strCodigoEmpresa) Then
    Exit(False);

  qryConsulta := fCriarQuery('SELECT                      ' +
                             '  RCX_DTACAD,               ' +
                             '  RCX_ESPDOC                ' +
                             'FROM                        ' +
                             '  CADRCXX                   ' +
                             'WHERE                       ' +
                             '  RCX_CODEMP = ' + strCodigoEmpresa.QuotedString +
                             ' AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString +
                             ' AND RCX_LANFEC <> "S"      ' +
                             ' ORDER BY RCX_DTAGRV DESC LIMIT 1');

  qryConsulta.Open;

  Result := (Not qryConsulta.IsEmpty) And
            (qryConsulta.FieldByName('RCX_ESPDOC').AsString <> 'FC') And
            (qryConsulta.FieldByName('RCX_DTACAD').AsDateTime <> VS_Date);

  If Not qryConsulta.IsEmpty Then
  Begin
    If qryConsulta.FieldByName('RCX_ESPDOC').AsString <> 'FC' Then
      dtaDataLancamento := qryConsulta.FieldByName('RCX_DTACAD').AsDateTime;
  End;

  qryConsulta.Close;


  If (Result) And (blnMostraMensagem) Then
  Begin

    If (blnFaturamento) Then
      fMensagem('', 'O caixa do dia ' + DateToStr(dtaDataLancamento) + ' ainda não foi fechado!', ['&Ok'])
    Else
      fMensagem('', 'O caixa do dia ' + DateToStr(dtaDataLancamento) + ' ainda não foi fechado,' + #13#10 +
                    'por isso, todos os lançamentos efetuados serão gravados com a data acima!', ['&Ok']);
  End;

  FreeAndNil(qryConsulta);

end;

function TResumoDeCaixa.fExisteMovimentoNoCaixa(strCodigoCaixa: String;
                                                dtaDataCaixa: TDateTime;
                                                qryRegistrosCaixa: TUniQuery;
                                                strCodigoEmpresa: String = '';
                                                blnSoma: Boolean = False;
                                                dtaDtaFin: TDateTime = 0): Boolean;
  Var
    strSQL: String;
    blnAssigned: Boolean;
begin
  If fEmptyStr(strCodigoEmpresa) Then
    strCodigoEmpresa := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If Not blnSoma Then
    strSQL := strSQL + '  * '
  Else
  Begin
    strSQL := strSQL + ' SUM(RCX_DINREC) AS RCX_DINREC, ';
    strSQL := strSQL + ' SUM(RCX_CHQAVI) AS RCX_CHQAVI, ';
    strSQL := strSQL + ' SUM(RCX_CHQPRE) AS RCX_CHQPRE, ';
    strSQL := strSQL + ' SUM(RCX_CARREC) AS RCX_CARREC, ';
    strSQL := strSQL + ' SUM(RCX_ORDREC) AS RCX_ORDREC, ';
    strSQL := strSQL + ' SUM(RCX_VALFIN) AS RCX_VALFIN  ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADRCXX ';
  strSQL := strSQL + 'WHERE ';

  If blnSoma Then
    strSQL := strSQL + '  RCX_DTACAD BETWEEN :DTAINI AND :DTAFIN AND '
  Else
    strSQL := strSQL + '  RCX_DTACAD >= :DTACAD AND ';

  strSQL := strSQL + '  RCX_CODCAX = :CODCAX AND ';
  strSQL := strSQL + '  RCX_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  RCX_LANFEC <> "S" AND    ';
  strSQL := strSQL + '  RCX_ESPDOC <> "FC" '; // AND ';
  //strSQL := strSQL + '  ( RCX_VENPRZ <= 0 OR ( RCX_VENPRZ > 0 AND RCX_DINREC+RCX_CHQAVI+RCX_CHQPRE+RCX_CARREC+RCX_ORDREC+ABS(RCX_VALCRE)+RCX_VALFIN <> 0 )) ';

  If blnSoma Then
  Begin
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  RCX_CODEMP ';
  End
  Else
  Begin
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  RCX_DTAGRV, RCX_ESPDOC, RCX_NUMDOC ';
  End;

  blnAssigned := Assigned(qryRegistrosCaixa);

  If Not blnAssigned Then
    qryRegistrosCaixa := fCriaQuery;

  qryRegistrosCaixa.Close;
  qryRegistrosCaixa.SQL.Text := strSQL;

  If blnSoma Then
  Begin
    qryRegistrosCaixa.ParamByName('DTAINI').AsDateTime := dtaDataCaixa - 1;
    qryRegistrosCaixa.ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
  End
  Else
    qryRegistrosCaixa.ParamByName('DTACAD').AsDateTime := dtaDataCaixa - 1;

  qryRegistrosCaixa.ParamByName('CODCAX').AsString   := strCodigoCaixa;
  qryRegistrosCaixa.ParamByName('CODEMP').AsString   := strCodigoEmpresa;
  qryRegistrosCaixa.Open;

  Result := Not qryRegistrosCaixa.IsEmpty;

  If Not blnAssigned Then
    FreeAndNil(qryRegistrosCaixa);
end;

procedure TResumoDeCaixa.AtualizaTipoDeDataDeTransferencia;
begin
  FTipoDataTFCaixa := tdtfDataTransferencia;
  If fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTATFX', VS_strCodEmp]) = '2' Then
    FTipoDataTFCaixa := tdtfDataMovimentoCaixa
  Else If FUtilizaContabilidade Then
    FTipoDataTFCaixa := tdtfDataMovimentoCaixa;
end;

function TResumoDeCaixa.CaixaFoiFechadoNoMeioDaBaixa(ADataCaixa,
  ADataHoraInicialBaixa: TDateTime; ACodigoCaixa: String;
  var AOperador: String): Boolean;
  Var
    LDatasetFechamento: TDataset;
begin
  Result := False;
  AOperador := EmptyStr;

  If fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_RCXTCC', VS_strCodEmp]) = '1' Then
    Exit;

  LDatasetFechamento := fRetornaDadosUltimoFechamento(ACodigoCaixa, VS_strCodEmp, True);
  Try
    If LDatasetFechamento.IsEmpty Then
      Exit;

    Result := LDatasetFechamento.FieldByName('RCX_DTACAD').AsDateTime >= ADataCaixa;

    If Result Then
    Begin
      If strTipoFechamento.Equals('C') Then
        Result := ADataHoraInicialBaixa <= LDatasetFechamento.FieldByName('RCX_DTAGRV').AsDateTime;

      If Result Then
        AOperador := Concat(LDatasetFechamento.FieldByName('RCX_CODOPE').AsString, '-',
                            LDatasetFechamento.FieldByName('RCX_NOMOPE').AsString);

    End;
  Finally
    If Assigned(LDatasetFechamento) Then
    Begin
      LDatasetFechamento.Close;
      FreeAndNil(LDatasetFechamento);
    End;
  End;
end;

function TResumoDeCaixa.CaixaJaFoiFechado(ADataCaixa: TDate): Boolean;
  Var
    LSadoUltimoFechamento: Double;

    LDataUltimoFechamento: TDateTime;
begin
  Result := False;

  If strTipoFechamento = 'C' Then
    Exit;

  fRetornaUltimoFechamento(LSadoUltimoFechamento,
                           LDataUltimoFechamento,
                           '');

  If LDataUltimoFechamento = VS_Date Then
  Begin
    fMensagem('ATENÇÃO', 'A operação não pode ser finalizada pois o caixa já foi fechado.', ['&OK']);
    Exit(True);
  End;

  If LDataUltimoFechamento >= ADataCaixa Then
  Begin
    fMensagem('ATENÇÃO', 'A operação não pode ser finalizada pois o caixa já foi fechado.', ['&OK']);
    Exit(True);
  End;
end;

function TResumoDeCaixa.fExisteTransferenciaEmDinheiro(
  strCodigoCaixa: String): Boolean;
  Var
    qryConsulta: TUniQuery;
begin
  Try
    qryConsulta := fCriarQuery('SELECT AUTOINCREM FROM CADRCXX ' +
                               ' WHERE RCX_CODCAX = ' + strCodigoCaixa.QuotedString +
                               '   AND RCX_CODEMP = ' + VS_strCodEmp.QuotedString +
                               '   AND RCX_ESPDOC = "TF"  ' +
                               '   AND RCX_LANFEC = "N"   ' +
                               '   AND RCX_TFCANC <> "S"  ' +
                               '   AND RCX_DINREC <> 0.00 ');
    qryConsulta.Open;

    Result := Not qryConsulta.IsEmpty;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TResumoDeCaixa.fGetSQLTransfValores(strCodigoGrupo, strCodigoOperador: String;
  blnAgruparOperador: Boolean; strCodigoCaixa: String): String;
begin
  If strTipoFechamento <> 'C' Then
    Result := untCadRcxx.fGetSQLTransfValores(strCodigoGrupo,
                                              strCodigoOperador,
                                              blnAgruparOperador)
  Else
    Result := fRetornaSQLTransferenciaDeValores(strCodigoCaixa,
                                                strCodigoOperador,
                                                blnAgruparOperador);
end;

function TResumoDeCaixa.fLancaDiferencaNoCaixa(strCodigoCaixa,
  strCodigoOperador: String; fltValorDiferenca: Double;
  dtaDataDoCaixa: TDateTime): Boolean;
  Var
    intFat   : Integer;
    strSeqRcx: String;
Begin
  Result := True;

  Try
    fStartTransaction;
    intFat := 1;
    If fFormataFloat(fltValorDiferenca, 2) > 0 Then
      intFat := -1;

    If (Not fGravaCadRcx(strSeqRcx,
                         '',                                                     // Cliente
                         strCodigoOperador,                                      // Operador
                         '',                                                     // Documento
                         IIF(fFormataFloat(fltValorDiferenca,2) > 0, 'LD', 'LC'),// Espécie
                         VS_strCodEmp,                                           // Empresa
                         dtaDataDoCaixa,                                         // Data de Cadastro
                         fTime(),                                                // Hora de Cadastro
                         '',                                                     // Duplicata
                         '',                                                     // Parcela
                         'ACERTO AUT. DIFERENÇA FECHAMENTO CAIXA',               // Descrição
                         '',                                                     // Juros / Desconto
                         '',                                                     // Identificação de Fechamento
                         '',                                                     // Formade Pagamento
                         Abs(fltValorDiferenca) * intFat,                        // Valor do Documento
                         0.0,                                                    // Valor do Desconto
                         0.0,                                                    // Valor do Juros
                         Abs(fltValorDiferenca) * intFat,                        // Dinheiro recebido
                         0.0,                                                    // Cheque a vista
                         0.0,                                                    // Cheque pre datado
                         0.0,                                                    // Valor em Cartão
                         0.0,                                                    // Valor em Ordem de Pagamento
                         0.0,                                                    // Valor do Crédito
                         0.0,                                                    // Valor em Financiamento
                         0.0,                                                    // Valor de outros
                         0.0,                                                    // Venda a prazo
                         '',                                                     // Num. do Romaneio
                         0,                                                      // Sequencial de Controle
                         0,                                                      // Sequencial de Baixa (Duplicata)
                         fCfgSisL('SQFCRX'),                                     // Sequencial de Fechamento parcial de caixa
                         '',                                                     // Empresa da duplicata
                         '',                                                     // Motivo do desconto
                         2,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         'N',
                         '',
                         strCodigoCaixa)) Then
    Begin
      Raise Exception.Create('Não foi possível fazer o acerto do caixa! Favor entrar em contato com a Citel!');
    End;

    fCommit;
    Sleep(1000); //RCX_DTAGRV
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.message,'');
    End;
  End;

end;

function TResumoDeCaixa.fRetornaSaldoDoCaixa(strCodigoCaixa: String;
                                             Var dtaDataCaixa: TDateTime;
                                             strCodigoEmpresa: String = ''): Double;
  Var
    fltSaldoUltimoFechamento: Double;
    dtaDataFechamento: TDateTime;
    qryConsulta: TUniQuery;
begin
  If fEmptyStr(strCodigoEmpresa) Then
    strCodigoEmpresa := VS_strCodEmp;

  qryConsulta := fCriaQuery(nil);

  Self.fRetornaUltimoFechamento(fltSaldoUltimoFechamento,
                                dtaDataFechamento,
                                strCodigoCaixa,
                                strCodigoEmpresa);

  Self.fNecessitaFecharCaixa(False, dtaDataCaixa, strCodigoCaixa, False, strCodigoEmpresa);

  If (fCaixaTemMovimento(strCodigoCaixa, dtaDataFechamento+1, qryConsulta, strCodigoEmpresa)) Then
  Begin
    While (Not qryConsulta.Eof) Do
    Begin
      fltSaldoUltimoFechamento := fltSaldoUltimoFechamento + qryConsulta.FieldByName('RCX_VALDOC').AsFloat;
      qryConsulta.Next;
    End;
    qryConsulta.Close;
  End;

  Result := fltSaldoUltimoFechamento;

  FreeAndNil(qryConsulta);
end;

function TResumoDeCaixa.fBetween(fltValor, fltMinimo,
  fltMaximo: Double): Boolean;
begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
end;

function TResumoDeCaixa.fAbrirLayoutTermoDeFechamento(var frxTermo:TfrxReport; strTipoRelatorio, strLayout: String): Boolean;
  Var
    mmsLoad: TStream;
    FLayImp: TUniQuery;
Begin
  Result := False;

  Try
    Try
      FLayImp := fCriarQuery('SELECT * FROM   ' +
                             '  LAYIMP        ' +
                             'WHERE           ' +
                             '  LAY_TIPLAY = "' + strTipoRelatorio + '" AND ' +
                             '  LAY_CODEMP = "' + VS_strCodEmp + '" AND ' +
                             '  LAY_CODLAY = "' + strLayout + '" ' +
                             'ORDER BY          ' +
                             '  LAY_DTAALT DESC,' +
                             '  LAY_HORALT DESC ' +
                             'LIMIT 1           ');



      FLayImp.Open;

      If Not FLayImp.IsEmpty Then
      Begin
        Result := True;
        mmsLoad := FLayImp.CreateBlobStream(FLayImp.FieldByName('LAY_RELFR3'), bmRead);
        frxTermo.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fLoadReport]');
      End;

    End;

  Finally
    If Assigned(FLayImp) Then
      FreeAndNil(FLayImp);
  End;

End;

procedure TResumoDeCaixa.pAtualizaDataLanctoCadRec(AAutoIncremList: String; ADataAlterada: TDateTime);
Var
  qryCadRec : TUniQuery;
  LConsulta : TUniQuery;
begin

  Try
    If Not FEmptyStr(AAutoIncremList) Then
    Begin

       qryCadRec := fCriaQuery(Nil);
       LConsulta := fCriaQuery(Nil);

      Try
        LConsulta.Close;
        LConsulta.SQL.Text := 'SELECT                                                 '+
                              '  CTR_SEQCON,                                          '+
                              '  CTR_EMPBAI,                                          '+
                              '  CTR_DTABAI                                           '+
                              'FROM                                                   '+
                              '  CADREC WHERE AUTOINCREM IN (' + AAutoIncremList + ') '+
                              'GROUP BY CTR_SEQCON,CTR_EMPBAI,CTR_DTABAI              ';
        LConsulta.Open;
        LConsulta.First;

        While Not LConsulta.Eof Do
        Begin
          qryCadRec.Close;
          qryCadRec.SQL.Clear;
          qryCadRec.SQL.Add(' UPDATE CADREC ');
          qryCadRec.SQL.Add('    SET CTR_DTABAN = :DTABAN ');
          qryCadRec.SQL.Add(' WHERE CTR_SEQCON = :SEQCON  ');
          qryCadRec.SQL.Add('   AND CTR_EMPBAI = :EMPBAI  ');
          qryCadRec.SQL.Add('   AND CTR_DTABAI = :DTABAI  ');

          qryCadRec.ParamByName('DTABAN').AsDateTime := ADataAlterada;

          qryCadRec.ParamByName('SEQCON').AsInteger  := LConsulta.FieldByName('CTR_SEQCON').AsInteger;
          qryCadRec.ParamByName('EMPBAI').AsString   := LConsulta.FieldByName('CTR_EMPBAI').AsString;
          qryCadRec.ParamByName('DTABAI').AsDateTime := LConsulta.FieldByName('CTR_DTABAI').AsDateTime;

          qryCadRec.ExecSQL;
          LConsulta.Next;
        End;
      Finally
        FreeAndNil(qryCadRec);
        FreeAndNil(LConsulta);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TRcxTResumoCaixa.AlteracaoDataLanctoCadRec] ' +E.Message);
    End;
  End;
end;

initialization
  RegisterClass(TResumoDeCaixa);

finalization
  UnRegisterClass(TResumoDeCaixa);

end.
