unit untTefCitelUtil;

interface

uses
  untInterfaceTefCitel, System.SysUtils,Uni, UniClientDataSet, forms,
  System.Classes, Vcl.Controls, Vcl.ExtCtrls, untTypesSistema;

  Const
    arrMsg : array  [1..31] of string = ('-1 Módulo não inicializado',
                                         '-2 Operação cancelada pelo operador.',
                                         '-3 Fornecido um código de função inválido',
                                         '-4 Falta de memória para rodar a função',
                                         '-6 Operação cancelada!',
                                         'Erro: -7',
                                         'Erro: -8',
                                         'Erro: -9',
                                         'Erro: -10',
                                         'Erro: -12',
                                         'Erro: -13',
                                         'Erro: -15',
                                         'Erro: -20',
                                         'Erro: -21',
                                         'Erro: -25',
                                         'Erro: -30',
                                         '-40 Transação negada pelo SiTef',
                                         'Erro: -41',
                                         'Erro: -42',
                                         '-43 Falha no pinpad',
                                         '-50 Transação não segura',
                                         '-100 Result interno do módulo',
                                         'Negada pelo autorizador',
                                         'Nao existe conf.',
                                         'Terminal inoperante, CNPJ/CPF divergente',
                                         'Documento Invalido',
                                         '43 - Cartao Removido',
                                         'Sem conexao Servidor',
                                         '51NAO AUTORIZADA',
                                         'Carteira Digital - Trn. nao habilitada',
                                         'Sem conexão com o serviço de TEF, verifique sua internet!');

    strMsgIpInvalido         = 'Endereço IP inválido ou não resolvido';
    strMsgCodLojaIpInvalido  = 'Código da loja inválido';
    strMsgCodTermInvalido    = 'Código de terminal inválido';
    strMsgErroIniTcp         = 'Erro na inicialização do Tcp/Ip';
    strMsgMemoria            = 'Falta de memória';
    strMsgNaoEncontrouCliSit = 'Não encontrou a CliSiTef ou ela está com problemas';
    strMsgConfServExcedida   = 'Configuração de servidores SiTef foi excedida.';
    strMsgErroAcessoPasta    = 'Erro de acesso na pasta CliSiTef (possível falta de permissão para escrita)';
    strMsgDadosInvalidos     = 'Dados inválidos passados pela automação.';
    strMsgModoSeguro         = 'Modo seguro não ativo (possível falta de configuração no servidor SiTef do arquivo .cha).';
    strMsgCaminhoDllInvalido = 'Caminho DLL inválido (o caminho completo das bibliotecas está muito grande).';

    SEPARADORBLOCOCLISI = 'SiTef' ;

  type

  TInfoBandeiraRedePixScope = record
    CodigoRede: String;
    CodigoBandeira: String;
    CodigoServico: String;
    Descricao: String;
  end;

  TArrayBandeiraRedePixScope = array of TInfoBandeiraRedePixScope;

  TImplEventosTefCitel = class
  public
    class function fAntesPassarCartaoEvent(): Boolean ;
    class procedure pDepoisPassarCartaoEvent(AobjRetorno: IRetornoTEFCitel) ;
    class procedure pDepoisFinalizarTransacaoEvent() ;
    class function fAntesCancelarTransacaoEvent(): Boolean ;
    class procedure pDepoisCancelarTransacaoEvent(AobjRetorno: IRetornoTEFCitel) ;
    class function fAntesReimpressaoEvent(): Boolean ;
    class procedure pDepoisReimpressaoEvent(AobjRetorno: IRetornoTEFCitel) ;
    class procedure pSucessoTefCartaoEvent(var ADadosTransacao: IRetornoTEFCitel) ;
    class procedure pGravarErroTef(const AblnGravarErro:Boolean; AstrMensagemErro:String; AstrRelatorio: String= ''; AstrUltSQL: String='');
  end ;

  TDadosValidaParcelasCartao = class(TInterfacedObject, IDadosValidaParcelas)
  private
    FblnF11: Boolean ;
    FintQtdNeg: Integer ;
    FstrCodFin: String ;
    FCfgTFPF11: Boolean;
    FCfgCNTF11: Boolean;
    FCfgSOLCAR: Boolean;
  public
    constructor Create ;
    class function New: IDadosValidaParcelas ;
    function F11(const AValue: Boolean): IDadosValidaParcelas ; overload ;
    function F11: Boolean ; overload ;
    function QtdNeg(const AValue: Integer): IDadosValidaParcelas ; overload ;
    function QtdNeg: Integer ; Overload ;
    function CodFin(const AValue: String): IDadosValidaParcelas ; overload ;
    function CodFin: String ; overload ;
    function fTravouQtdParcelaInformada(const AParcInformada: Integer): Boolean ;
    function fTravarQuantidadeNegociada: Boolean;
    function fObrigarQuantidadeNegociada: Boolean;
  end ;

  TDadosAdicionaisTefTra = Class(TInterfacedObject, IDadosAdicionaisTefTra)
  private
    FstrPixS_N: String ;
    FstrOpcDoc: String ;
    FArrDocs: TArrayInfoTraDoc ;
    FstrOpeRcx: String ;
    FstrNumDoc: String ;
    FfltValor: Double ;
    FintOperacao: integer ;
    FstrModalidade: String ;
    FintQtdParcelas: integer ;
    FstrPrePago: String ;
    FstrParcAdm: String ;
    FstrStatus: String ;
  public
    function PixS_N(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function PixS_N: String ; overload ;
    function OpcDoc(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function OpcDoc: String ; overload ;
    function ArrDocs(const AarrValor: TArrayInfoTraDoc): IDadosAdicionaisTefTra ; overload ;
    function ArrDocs: TArrayInfoTraDoc ; overload ;
    function OpeRcx(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function OpeRcx: String ; overload ;
    function NumDoc(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function NumDoc: String ; overload ;
    function Valor(const AfltValor: Double): IDadosAdicionaisTefTra ; overload ;
    function Valor: Double ; overload ;
    function Operacao(const AintValor: Integer): IDadosAdicionaisTefTra ; overload ;
    function Operacao: Integer ; overload ;
    function Modalidade(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function Modalidade: String ; overload ;
    function PrePago(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function PrePago: String ; overload ;
    function ParcAdm(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function ParcAdm: String ; overload ;
    function QtdParcelas(const AintValor: Integer): IDadosAdicionaisTefTra ; overload ;
    function QtdParcelas: Integer ; overload ;
    constructor Create ;
    class function New: IDadosAdicionaisTefTra ;
    function Status(const AstrValor: String): IDadosAdicionaisTefTra ; overload ;
    function Status: String ; overload ;
  end ;

  var
    objTefCitel: ITefCitel;
    VS_TefPixLigado : String = 'N';
    VS_TefPix_PXCEMP: String = '';
    VS_TefPix_PXCPDV: String = '';
    VS_TefPix_TEFCIT: String = '';
    VS_TefPix_PATDIR: String = '';
    VS_TefPix_TEFDVC: String = 'N';
    VS_InfoPinPad: String = '';
    qryTefTra : TUniQuery;
    FIniciado : boolean = False;
    FCGCEmp : AnsiString;
    FCGCCit : AnsiString;
    RetornoTEFCitel: IRetornoTEFCitel;
    blnFechar : Boolean;

  type
  { Espelha untTefCitelDvc.TfuncConfirmaTomadaPinpadTef, da libTefCitel.dll
    (Req. 456190, RF27/RN16, Passo 6). As duas declaracoes precisam ser
    IDENTICAS, stdcall inclusive - qualquer diferenca de convencao de chamada
    aqui e corrupcao de pilha, nao erro de compilacao. }
  TfuncConfirmaTomadaPinpadTef = function(const AstrMensagem: String): Boolean; stdcall;

  { Espelha untTefCitelDvcAtualizacao.TprocProgressoAtualizacaoTef, da
    libTefCitel.dll (Req. 456190, Fase 6). As duas declaracoes precisam ser
    IDENTICAS, stdcall inclusive - qualquer diferenca de convencao de chamada
    aqui e corrupcao de pilha, nao erro de compilacao.

    AintTotal = 0 e etapa sem progresso mensuravel (consulta, espera pelo
    servico voltar): so o texto vale. }
  TprocProgressoAtualizacaoTef = procedure(const AstrEtapa: String;
    const AintFeito, AintTotal: Integer); stdcall;

  { Como pIniciaTefCitel devolve o andamento para quem tem tela.

    Existe para a barra de progresso NAO precisar chegar ate esta unit: quem
    a tem e o fIniciarTefCitel (untPrincipal.pas), e untTefCitelUtil nao
    linka DevExpress nem deve passar a linkar por causa disto. }
  TprocStatusCargaTef = procedure(const AstrTexto: String;
    const AintFeito, AintTotal: Integer) of object;

  function fCriarTefCitel(const AstrPath, AstrOpcao: String; const AblnUsaDvc: Boolean = False) : ITefCitel; stdcall; External 'libTefCitel.dll' delayed;
  { Registra em quem a DLL vai perguntar, ao operador, se ele quer assumir o
    pinpad de um AUTCOM que parou de responder (RF27/RN16). A DLL nao linka
    libFuncoes e nao enxerga o fMensagem - a pergunta precisa sair daqui. }
  procedure pSetConfirmaTomadaPinpadTef(AFunc: TfuncConfirmaTomadaPinpadTef); stdcall; External 'libTefCitel.dll' delayed;
  { Atualizacao de arquivos da estacao (Req. 456190, Fase 6). Os dois sao
    exports NOVOS: autcom.exe novo com libTefCitel.dll anterior a esta fase
    levanta excecao na primeira chamada - ver o try/except em
    fAtualizaEstacaoNaCarga, que degrada para "nao atualiza" em vez de
    derrubar o login do TEF. }
  function fAtualizaEstacaoTefDll(ATef: ITefCitel; const AstrDirAutcom,
    AstrOpcaoTefCit, AstrDirIniTerminal: String;
    out AstrMensagem: String): Integer; stdcall; External 'libTefCitel.dll' delayed;
  procedure pSetProgressoAtualizacaoTef(AProc: TprocProgressoAtualizacaoTef); stdcall; External 'libTefCitel.dll' delayed;
  { Acerta, na DLL, qual e a thread principal do autcom. Export NOVO: ver o
    try/except em fInstanciaPixTef, que degrada para o comportamento
    anterior quando a DLL e antiga. }
  procedure pSetThreadPrincipalHost(AdwThreadId: Cardinal); stdcall; External 'libTefCitel.dll' delayed;

  function fCancelaTransacaoEfetivada(const ANumeroControleOuNsu: string;
    const AValorTransacao: Double; const ADataTransacao: string;
    const ACodigoCarteiraDigital, ACodigoTipoOperacaoCartao,
    ACodigoBandeira: string): Boolean;

  procedure pInicializaVariavelGlobalPixScope;
  function fImpCupom(strViaCli, strViaLoj: String) : Boolean;
  function fInstanciaPixTef(const ACodigoLoja, ACodigoTerminal: String;
                            out AMensagem: String): ITefCitel;
  { Req. 470363 - confirmacao que nao chegou a estacao do TEF DVC. }
  function fFinalizacaoTefNaoRealizada(out AblnSeraReenviada: Boolean;
    const ATefCitel: ITefCitel = nil): Boolean;
  procedure pDescreveFinalizacaoTef(const AstrDescricao: String;
    const ATefCitel: ITefCitel = nil);
  procedure pAvisaFinalizacaoTefNaoRealizada(const AblnSeraReenviada: Boolean;
    const AfltValor: Double; const AstrControle: String);
  function fFinalizaCartao(strNumDoc,
                           strDtaTra,
                           strHraTra,
                           strViaCli,
                           strViaLoj,
                           strNumNsu,
                           strIncDoc,
                           strTabela : String;
                           fltValCar: Double;
                           strComImp : String;
                           strSeqCon : String;
                           const AstrControle: String) : Boolean;
  function fVerificaPendenciasTEFCitel : Boolean;
  function fCancelamentoNormal(strCodOpe: String;
                             dtaDtaTra: TDate;
                             hraHraTra: TTime;
                             numdoc: String;
                             fltValor: Double;
                             strTipCar: String;
                             strSeqCon : String;
                             strCodigoCarteiraDigital : String) : IRetornoTEFCitel;
  function fConsultaTransacoesPendentes : TUniClientDataSet;
  function fReimpressaoTefCitel(intFuncao: Integer;
                                strNumDoc: AnsiString;
                                strDtaTra: TDate;
                                strCodOpe: AnsiString;
                                fltValTra: Double) : IRetornoTEFCitel;
  procedure pSepararViasDoCupom(const ATextoCupom: String; var AConteudoViaCliente, AConteudoViaLojista: String);
  procedure pPreparaDadosReimpressaoViaTefTra(const AstrAutoInc: String;
                                              var AConteudoViaCliente, AConteudoViaLojista, AMensagem: string);
  procedure pPreparaDadosReimpressaoViaMovTef(const AstrNumDoc: String;
                                              const AdtaDtaCar: TDate;
                                              const AfltValCar: Double;
                                              var AstrConteudoViaCliente, AstrConteudoViaLojista: string) ;

  function fUsaControleScope(const AdtaData: TDateTime; const AstrControle: String): Boolean ;

  function fRetornaDadosBandeiraRedePixScope(out AInfo: TArrayBandeiraRedePixScope; out AMensagemErro: String): Boolean;
  function fTryTraduzirErro(const ATefCitel: ITefCitel; const AIntCodigoErro: Integer): String;

  function fBuscaDesTra(strOperacao, strModalidade : String; blnCancelamento : Boolean; strCodigoCarteiraDigital: string) : String;
  function fTefLogImplementado(const ATefCitel: ITefCitel): Boolean ;
  function fPassaCartao(intOperacao,
                         intQtdParc : Integer;
                         strModalidade,
                         strNumDoc : String;
                         fltValor : Double;
                         strRcxCodOpe : String;
                         blnPagueFacil : Boolean = False;
                         strCodigoCarteiraDigital : string = '';
                         AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra = Nil;
                         strJsonInfoAdicPix: String = '';
                         const ATefCitel: ITefCitel = Nil) : IRetornoTefCitel;
  { ADadosTransacao = nil grava sem dados do cartao: inicio da transacao,
    escolha de modalidade na tela e cancelamento. }
  procedure pAtualizaTefTraComDadosAdicionais(const AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
    const ADadosTransacao: IRetornoTEFCitel) ;
  function fVerificaMsgTefCitel(const AStrMsg: String): Boolean;
  function fTraduzErrosConexao(intResult : Integer) : String;
  function fVerificaQuebraLinha(strCaracter : String) : Boolean;
  function fPassaCartaoPagueFacil(strTipoCartao : String;
                                  var intQtdParcelas,
                                  intOperacao : Integer;
                                  fltValor : Double;
                                  strNumDoc,
                                  strCodOpe : String;
                                  var strModalidade : String;
                                  AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra) : IRetornoTEFCitel;
  function fVerificaMsgInsereCartao(msgPanelTef : String): Boolean;

  function fMostrarOpcaoPix: Boolean ;

  function fDataDebitoPreDatadoScope: TDateTime ;

  procedure pGravaTransacaoCliSiTef(strNumDoc,
                                    strAutInc,
                                    strNumNsu,
                                    strDtaTra,
                                    strHraTra,
                                    strPixS_N,
                                    strOpeRcx,
                                    strOpcDoc: String;
                                    fltValor: Double;
                                    blnFinalizado,
                                    blnEstornado,
                                    blnCancelamento : Boolean;
                                    strNumCcd : String;
                                    strComImp : String;
                                    strSeqCon : String;
                                    strTipOpe : String = '';
                                    strModali : String = '';
                                    strIncDoc : String = '';
                                    strTabela : String = '';
                                    intQtdPar : Integer = 0;
                                    strCodigoCarteiraDigital : String =  '';
                                    const AstrControle: String = '';
                                    const AstrStatus: String = '';
                                    const AstrComAux: String = '';
                                    const AblnUpdateEmLib: Boolean = False);
  procedure pGravaDocumentosTefTra(const AarrDocs: TArrayInfoTraDoc) ;
  procedure pGravaTransacaoEstornada(strNumDoc,
                                     strNsu,
                                     strDtaTra,
                                     strHraTra,
                                     strIncDoc,
                                     strTabela: String;
                                     fltValor : Double;
                                     const AstrControle: String);
  procedure pGravaTransacaoFinalizada(strNumDoc,
                                    strNsu,
                                    strDtaTra,
                                    strHraTra,
                                    strIncDoc,
                                    strTabela : String;
                                    fltValor : Double;
                                    strComImp : String;
                                    strSeqCon : String;
                                    const AstrControle: String);
  function fValidouPinPad(const ATefCitel: ITefCitel): Boolean;
  procedure pIniciaTefCitel(var AblnEscondeMenuAdmTef: Boolean;
    AprocStatus: TprocStatusCargaTef = nil);
  function fDiretorioPorTerminal(const AstrTerminal: String): String ;
  procedure pEstornaTransacaoPendente(Confirma: Boolean; strData, strHora, strNumDoc, strParamAdc : String);
  procedure pFinalizaTranscacao(blnFinaliza: Boolean; strDtaTra, strHraTra, strNumDoc, strParamAdc : String; const ATefCitel: ITefCitel = Nil);
  procedure pRetornaIncDocTabela(strNumDoc,
                                 strEspDoc,
                                 strEmpDoc,
                                 strCodCli : String;
                                 out strIncDoc : String;
                                 out strTabela : String);
  procedure pGravaTransacaoCancelada(strNumDoc : String; dtDtaTra : TDate; out strTipOpe, strModali, strSeqCon : String);
  procedure pMontaConteudoCupom(strConteudo, strRede, strBandeira, strEstabeleci: String; var stlConteudo : TStringList);
  procedure pImprimirCliente(strViaCli, strViaLoj : String; const AblnQtdViasExterna: Boolean = False);
  procedure pImprimirLojista(strViaCli, strViaLoj : String; const AblnQtdViasExterna: Boolean = False);
  procedure pInfo34(fltValTra : Double);
  procedure pInfo21(strModalidade : String);
  procedure pInfo30(strNumDoc : String; dtaData : TDate; intQtdParc : Integer);
  procedure pInfo30DebitoPreDatado(const AdtaDataPre: TDate) ;
  procedure pInfo30DebitoCredito1Minuto(const AintParcelaCdc: Integer) ;
  procedure pInfo30DebitoParcelado(const AintQtdParc, AintIntervaloParc, AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate) ;

  function fObtemDadoPinPadDireto(AintTipoDocumento: Integer): String;

  function fRetornaCarteiraDigital(const AstrNumNsu : String; const AdtaDtaMca : TDate; const AfltValor : double):string ;
  procedure pMostraArquivosVerificacaoScope ;
  function fTrataTefCitTerminal: String ;
  function fVerificaCnpjScope(const AstrCnpjEmpresa, AstrNumLoj, AstrPathTef: String; var AstrMsgErro: String): Boolean ;
  function fRetornaSeparador: String ;
  procedure pGravaTransacaoErro(const AstrNumDoc: String; const AfltValor: Double) ;
  function fExibeMenuAdmTef: Boolean;
  procedure pCarregaDadosTerminalPorTipTer(var AqryTerminal: TUniQuery);
  function fTipoViasImpressaoTef: string;
  function fVerificaConexaoApiScope: Boolean ;
  function fObterAutoIncrTransacao(const ANSU, ACodRede: string; const AData: TDate; const AValTrn: Double): string;
  function fRetornaInfoContaPix(const AItemPix: TInfoBandeiraRedePixScope): String;
  function fGerarQrCodeImagemPinPad(const ATexto: String;
                                    const AValor: String;
                                          AOwner: TWinControl;
                                    var   APathDiretorio, ANomeArquivo: String): Boolean ;
  function fAutoConfirmaTransacaoPendenteEstaAtivada: Boolean;
  function fAutoConfirmarTransacaoTef(
    const AItemCartao: TCartoesResumoCaixa): Boolean;
  procedure pAtualizaDadosFaturamentoTef(
    const AIncDoc, ATabela, ASeqCon, AViaCli, AViaLoj: String;
    const ANumDoc, ADtaTra: String);
  function fRetornaBandeiraPorCodigoSugestao(const ACodigo: string): string;
  function fAjustaIdentificadorEstornoTef(const AItem: TCartoesResumoCaixa): string;
  function fCapturaInfoPinPad(const ATefCitel: ITefCitel): String;

implementation

uses
  untQckFatImpNFCe, untFuncoesSimples, untPrincipal, untTefCitelDadosCartao,
  untTefCitelInfoMsg, untWorkStationInfo, strUtils, untLogTef,
  untConsultaDadosScope, untMemo, DateUtils, untTefCitelTransacaoController,
  untTefCitelTransacaoInterfaces, System.IOUtils, dxBarCode, dxGDIPlusClasses,
  cxGraphics, Vcl.Graphics, untTefCitelCancelamentoTransacao, untFuncMacro,
  Data.DB;

function fTruncaCampoLimiteDB(const AValor: String; AField: TField): String;
begin
  Result := AValor;
  if (AField.DataType in [ftString, ftWideString]) and (AField.Size > 0) and (Length(Result) > AField.Size) then
  begin
    pGravaLogErro(Format('[fTruncaCampoLimiteDB] Campo %s truncado de %d para %d caracteres',
      [AField.FieldName, Length(Result), AField.Size]));
    Result := Copy(Result, 1, AField.Size);
  end;
end;

procedure pMensagemLogErroTef ;
const
  TAMANHO_BOTOES_MSG : Integer = 200 ;
  NOME_ARQUIVO_LOG : String = 'libTefCitelErro.log' ;
  VER_ARQUIVO_LOG : Integer = 1 ;
var
  LintRetorno: Integer ;
  LlstConteudo: TStrings ;
  LqryTefTra: TUniQuery ;
  LstrNumTer: String ;
  LstrPathTef: String ;
  LstrConteudo: String ;
begin
  LintRetorno := fMensagem('ATENÇÃO!', 'Problemas ao carregar DLL do TEF' + #13 + 'Verifique o arquivo ' + NOME_ARQUIVO_LOG + ' para mais informações!', ['&Ver libTefCitelErro.log', '&Iniciar sem TEF'], 2, False, 1, TAMANHO_BOTOES_MSG);
  if LintRetorno = VER_ARQUIVO_LOG then
  begin

    { COM CFG_TEFDVC = 'S' O ARQUIVO NAO ESTA AQUI (Req. 456190, 2026-09-20).

      Quem carrega a DLL do TEF e o servico DA ESTACAO, e e la, ao lado dela,
      que o libTefCitelErro.log e escrito - ver pLogError em untTefCitelNCR.
      Ler o caminho do servidor mostrava ao operador um arquivo de outra
      maquina, velho, ou nenhum: exatamente quando ele precisa do motivo real.
      Apareceu no primeiro teste em estacao, com o Scope respondendo
      "ScopeSrv off-line" na estacao e o autcom exibindo outro conteudo.

      O pedido vai pelo canal DVC. Se ele nao responder, degrada com o motivo
      em vez de propagar: esta tela JA e a tela de erro do TEF, e deixar uma
      excecao subir daqui trocaria uma informacao incompleta por um dialogo
      do madExcept (mesma licao de C.8/C.9). }
    if (fCfgSis('TEFDVC', varString) = 'S') and Assigned(objTefCitel) then
    begin
      LstrConteudo := '' ;
      try
        LstrConteudo := objTefCitel.fConteudoLogErro ;
      except
        on E: Exception do
          LstrConteudo := '' ;
      end ;

      if fEmptyStr(LstrConteudo) then
      begin
        VS_ExibirMensagemStayOnTop := True ;
        try
          pMensagemOk('Não foi possível ler o arquivo ' + NOME_ARQUIVO_LOG +
            ' da estação.' + #13#10#13#10 +
            'Com o TEF DVC esse arquivo fica NA ESTAÇÃO, na mesma pasta do ' +
            'serviço TefEstacaoService - não na pasta do AUTCOM. Se o serviço ' +
            'da estação não estiver respondendo, acione o suporte.',
            700, 260) ;
        finally
          VS_ExibirMensagemStayOnTop := False ;
        end ;
        Exit ;
      end ;

      LlstConteudo := TStringList.Create ;
      try
        LlstConteudo.Text := LstrConteudo ;
       {$IFDEF LINUX}
        pMensagemOk(LlstConteudo.Text);
       {$ELSE}
        TfrmMemo.pShowMessage(LlstConteudo, 11, True, 0, 0, True) ;
       {$ENDIF}
      finally
        FreeAndNil(LlstConteudo) ;
      end ;

      Exit ;
    end ;

    LqryTefTra := fCriaQuery() ;
    try
      pCarregaDadosTerminalPorTipTer(LqryTefTra) ;
      LstrNumTer := LqryTefTra.FieldByName('TFC_NUMTER').AsString;

      LstrPathTef := fDiretorioPorTerminal(LstrNumTer) ;

    finally
      FreeAndNil(LqryTefTra) ;
    end ;

    if fEmptyStr(LstrPathTef) then
      LstrPathTef := TPath.Combine(ExtractFilePath(ParamStr(0)), NOME_ARQUIVO_LOG)
    else
      LstrPathTef := TPath.Combine(LstrPathTef, NOME_ARQUIVO_LOG);

    if not FileExists(LstrPathTef) then
    begin
      pMensagemOk('Arquivo de log [' + LstrPathTef + '] não encontrado!');
      Exit ;
    end ;

    LlstConteudo := TStringList.Create ;
    try
      LlstConteudo.LoadFromFile(LstrPathTef);
      TfrmMemo.pShowMessage(LlstConteudo, 11, True, 0, 0, True) ;
    finally
      FreeAndNil(LlstConteudo) ;
    end ;

  end ;
end ;

{ RN16 (Req. 456190, Passo 6) - a confirmacao humana antes de tomar o pinpad
  de outro AUTCOM.

  Registrada na libTefCitel.dll por pSetConfirmaTomadaPinpadTef e chamada de
  la, sempre na thread principal (o fChamaRpc do lado DVC roda nela). A
  estacao nunca toma o pinpad sozinha no caso "travado", e o motivo e um
  falso positivo conhecido: a closure do hook de vivacidade pode estar atras
  de um fMensagem MODAL na fila FIFO, e ai um AUTCOM saudavel deixa de
  responder a sonda no prazo. Com o operador no circuito, esse falso positivo
  vira um "Nao" e nao uma transacao quebrada em silencio.

  Foco no botao 2 ("Nao") de proposito: um Enter distraido nao pode tomar o
  pinpad de ninguem. }
function fConfirmaTomadaPinpadTefEvent(const AstrMensagem: String): Boolean; stdcall;
begin
  { GUARDA DE THREAD (apontamento do DelphAI, 2026-09-23).

    O comentario acima afirma que a DLL chama isto na thread principal, e hoje
    chama - mas era afirmacao sem verificacao, e este e codigo que a libTefCitel
    evolui sem revisar o callback. Modal de VCL fora da thread principal e
    Access Violation ou travamento.

    DEVOLVE False EM VEZ DE SINCRONIZAR OU LEVANTAR, e os dois motivos estao
    documentados neste proprio requisito:

    - `TThread.Synchronize` aqui seria o deadlock de 2026-08-31 de volta
      (IA\rules\tef-dvc.md: "nunca despachar hook/evento de forma
      sincrona-bloqueante na thread de leitura"). Se a chamada viesse da thread
      de leitura do canal, sincronizar prende quem entregaria o ACK - espera
      circular garantida, ja vista duas vezes (28/08 e 31/08);
    - excecao cruzando a fronteira EXE/DLL e a outra coisa em que este requisito
      ja se queimou, e `Assert` sai do binario com $ASSERTIONS OFF.

    False significa "o operador disse Nao": o pinpad NAO e tomado. E o mesmo
    desfecho do botao que ja e o padrao (foco no 2), entao falhar assim nao
    inventa comportamento novo - so recusa, e deixa rastro no log. }
  if TThread.CurrentThread.ThreadID <> MainThreadID then
  begin
    pGravaLogErro('[fConfirmaTomadaPinpadTefEvent] chamado FORA da thread '  +
      'principal - tomada do pinpad RECUSADA por seguranca. A libTefCitel.dll '  +
      'passou a chamar este callback de outra thread; ver RN16.');
    Exit(False);
  end;

  { try/except em volta do modal: este e um callback stdcall chamado DE DENTRO
    da DLL, e excecao cruzando a fronteira EXE/DLL e onde este requisito ja se
    queimou. A guarda de thread acima cobre um caminho; esta cobre o resto -
    form nao encontrado, Application em shutdown, qualquer coisa que o fMensagem
    levante. O desfecho e o mesmo e pelo mesmo motivo: False = pinpad NAO tomado.
    (apontamento do DelphAI, 2026-09-25) }
  try
    Result := fMensagem('ATENÇÃO!', AstrMensagem, ['&Sim', '&Não'], 2) = 1;
  except
    on E: Exception do
    begin
      Result := False;
      try
        pGravaLogErro('[fConfirmaTomadaPinpadTefEvent] excecao no dialogo - '  +
          'tomada do pinpad RECUSADA. ' + E.ClassName + ': ' + E.Message);
      except
        // nada: nao deixar o log derrubar o que a guarda existe para evitar
      end;
    end;
  end;
end;

function fRetornaChaveLockTefCitel: String;
const
  TEF_CITEL = 'TEF_CITEL_' ;
var
  LstrChave: String ;
  LScopeEmpresaFilial: String;
  LScopePdv: String;
begin
  if fCfgSis('TIPTER', varString) = '1' then
  begin
    LstrChave := TEF_CITEL + VS_UserFromWindows + VS_ComputerNetName ;
  end
  else if fCfgSis('TIPTER', varString) = '2' then
  begin
    LstrChave := TEF_CITEL + VS_WorkStationIP + VS_WorkstationID ;
  end
  else // 3
  begin
    LstrChave := TEF_CITEL + VS_WorkstationID + VS_strCodEmp ;
  end ;
  if (not Assigned(objTefCitel)) and (fCfgSis('PIXSCP') = 'S') then
  begin
    LScopeEmpresaFilial := fCfgSis('PXCEMP');
    LScopePdv := fCfgSis('PXCPDV');
    LstrChave := TEF_CITEL + Format('_%s_%s_%s', ['PIX', LScopeEmpresaFilial, LScopePdv]);
  end;
  Result := LstrChave ;
end;

function fLockUnlockTefCitel(const AblnLock: boolean; const AblnIgnorarLock: Boolean = False): Boolean;
var
  LstrChaveLock: String ;
begin

  if AblnIgnorarLock then
    Exit(True) ;

  LstrChaveLock := fRetornaChaveLockTefCitel ;

  Result := fLock_Unlock(LstrChaveLock,
                         AblnLock,
                         False,
                         False,
                         '',
                         True,
                         '',
                         False,
                         True) ;
end;

function fCancelaTransacaoEfetivada(const ANumeroControleOuNsu: string;
    const AValorTransacao: Double; const ADataTransacao: string;
    const ACodigoCarteiraDigital, ACodigoTipoOperacaoCartao,
    ACodigoBandeira: string): Boolean;
var
  LTentarNovamente: Boolean;
  LDataTransacao: TDateTime;
  LintAno, LintMes, LintDia: Integer;
begin
  if not (TryStrToInt(copy(ADataTransacao, 1, 4), LintAno) and
          TryStrToInt(copy(ADataTransacao, 5, 2), LintMes) and
          TryStrToInt(copy(ADataTransacao, 7, 2), LintDia) and
          TryEncodeDate(LintAno, LintMes, LintDia, LDataTransacao)) then
  begin
    LDataTransacao := Trunc(fNow());
  end;

  LTentarNovamente := False;
  repeat
    Result := TfrmTefCitelCancelamentoTransacao.fExecutar(
      ANumeroControleOuNsu, AValorTransacao, LDataTransacao,
      ACodigoCarteiraDigital, ACodigoTipoOperacaoCartao, ACodigoBandeira);

    if Result then
      Break;

    LTentarNovamente :=
      fMensagem('ATENÇÃO',
        'Não foi possível cancelar a transação TEF.' + #13#10 +
        'Deseja tentar novamente?',
        ['&Sim', '&Não'], 1) = 1;
  until not LTentarNovamente;

  if not Result then
    fMensagem('INFORMAÇÃO',
      'O cancelamento da transação TEF não foi concluído.' + #13#10 + #13#10 +
      'Anote o Nº Controle/NSU: ' + ANumeroControleOuNsu + #13#10 +
      'Ele será necessário para concluir o cancelamento em:' + #13#10 +
      'Útil > ADM - Administração TEF > botão Cancelamento.',
      ['&Ok'], 1);
end;

function fSomenteCarregarLib: Boolean ;
var
  AblnConseguiuTravar: Boolean ;
begin
  Result := False ;

  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
  begin
    AblnConseguiuTravar := fLockUnlockTefCitel(True) ;
    if not AblnConseguiuTravar then
    begin
      Result := True ;
      Exit ;
    end ;
    fLockUnlockTefCitel(False) ;
  end ;

end ;

procedure pCarregaDadosTerminal(var AqryTerminal: TUniQuery; const AstrCodEmp: String = '');
begin
  AqryTerminal.Close ;
  AqryTerminal.SQL.Clear;
  AqryTerminal.SQL.Add(' SELECT');
  { AUTOINCREM (PK) no SELECT fixo, como no 74.150. Ate o Req. 456190 nao havia
    Edit/Post nesta query nesta linha e por isso a PK nunca esteve aqui; a
    feature DVC passou a gravar TFC_VERDVC/UPTDVC/USODVC, e sem a PK o UniDAC
    nao monta o WHERE do UPDATE ('Update failed. Found 0 records').
    Incondicional de proposito (apontamento do DelphAI, 2026-09-25): deixar a PK
    atras de um 'if' e armadilha para o proximo Edit/Post, que nao tem por que
    saber disso. Uma coluna a mais no SELECT nao custa nada. }
  AqryTerminal.SQL.Add('   AUTOINCREM, ');
  AqryTerminal.SQL.Add('   TFC_NUMTER,');
  AqryTerminal.SQL.Add('   TFC_NUMLOJ,');
  AqryTerminal.SQL.Add('   TFC_NUM_IP,');
  AqryTerminal.SQL.Add('   TFC_COMTEF');

  { Req. 456190 - as três colunas da estação DVC entram no SELECT SOMENTE com
    o caminho DVC ligado, e a razão é raio de alcance, não economia.

    Elas precisam estar aqui para o Edit/Post do pIniciaTefCitel alcançá-las
    (é assim que o TFC_VERDLL já é gravado). Mas pedi-las sempre significaria
    que uma base que ainda não rodou o ALTER TABLE deixa de carregar o TEF em
    TODO terminal - inclusive os que nem usam DVC, que são hoje a maioria.
    Com a guarda, a exigência do ALTER acompanha exatamente quem ligou a
    configuração nova.

    fCfgSis é a mesma fonte que o pIniciaTefCitel consulta para decidir se
    grava: as duas pontas não têm como divergir. }
  if fCfgSis('TEFDVC', varString) = 'S' then
  begin
    AqryTerminal.SQL.Add('   ,TFC_VERDVC');
    AqryTerminal.SQL.Add('   ,TFC_UPTDVC');
    AqryTerminal.SQL.Add('   ,TFC_USODVC');
  end;

  AqryTerminal.SQL.Add(' FROM');
  AqryTerminal.SQL.Add('   TEFCFG ');
  AqryTerminal.SQL.Add(' WHERE TFC_TIPTEF = :TIPTEF');
  AqryTerminal.ParamByName('TIPTEF').AsString := fTrataTefCitTerminal;

  if fCfgSis('TIPTER', varString) = '1' then
  begin
    AqryTerminal.SQL.Add('   AND TFC_NOMUSU = :NOMUSU');
    AqryTerminal.SQL.Add('   AND TFC_NOMMAQ = :NOMMAQ');
    AqryTerminal.SQL.Add('   AND TFC_CODEMP = :CODEMP');

    AqryTerminal.ParamByName('NOMUSU').AsString := VS_UserFromWindows;
    AqryTerminal.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
    AqryTerminal.ParamByName('CODEMP').AsString := VS_strCodEmp;
  end
  else if fCfgSis('TIPTER', varString) = '2' then
  begin
    AqryTerminal.SQL.Add('   AND TFC_LOC_IP = :LOC_IP');
    AqryTerminal.SQL.Add('   AND TFC_NOMMAQ = :NOMMAQ');
    if not fEmptyStr(AstrCodEmp) then
    begin
      AqryTerminal.SQL.Add('   AND TFC_EMPTIP = :EMPTIP');
      AqryTerminal.ParamByName('EMPTIP').AsString := AstrCodEmp;
    end
    else
    begin
      AqryTerminal.SQL.Add('   AND COALESCE(TFC_EMPTIP, "") = ""');
    end ;
    AqryTerminal.ParamByName('LOC_IP').AsString := VS_WorkStationIP;
    AqryTerminal.ParamByName('NOMMAQ').AsString := VS_WorkstationID;
  end
  else // 3
  begin
    AqryTerminal.SQL.Add('   AND TFC_NOMMAQ = :NOMMAQ');
    AqryTerminal.SQL.Add('   AND TFC_EMPTIP = :EMPTIP');
    if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
      AqryTerminal.SQL.Add(' AND LENGTH(TRIM(TFC_NUMTER)) = 3 ')
    else if fCfgSis('TEFCIT', varString) = OPCAO_CLISITEF then
      AqryTerminal.SQL.Add(' AND LENGTH(TRIM(TFC_NUMTER)) > 3 ') ;

    AqryTerminal.ParamByName('EMPTIP').AsString := AstrCodEmp;
    AqryTerminal.ParamByName('NOMMAQ').AsString := VS_WorkstationID;
  end ;
  AqryTerminal.Open;
end ;

procedure pCarregaDadosTerminalPorTipTer(var AqryTerminal: TUniQuery);
begin
  if fCfgSis('TIPTER', varString) = '1' then
  begin
    pCarregaDadosTerminal(AqryTerminal) ;
  end
  else if fCfgSis('TIPTER', varString) = '2' then
  begin
    pCarregaDadosTerminal(AqryTerminal, VS_strCodEmp) ;
    if AqryTerminal.IsEmpty then
    begin
      pCarregaDadosTerminal(AqryTerminal) ;
    end ;
  end
  else // 3
  begin
    pCarregaDadosTerminal(AqryTerminal, VS_strCodEmp) ;
  end ;
end ;

function fExtraiCodigoCarteiraDigital(const AstrValor: string): string;
var
  LintCnt: integer ;
  LstrRetorno: string ;
begin
  LstrRetorno := '' ;
  for LintCnt := 1 to Length(AstrValor) do
  begin
    if CharInSet(AstrValor[LintCnt], ['0'..'9']) then
    begin
      LstrRetorno := LstrRetorno + AstrValor[LintCnt] ;
    end ;
  end ;
  Result := LstrRetorno ;
end;

function fDiretorioPorTerminal(const AstrTerminal: String): String ;
var
  LstrPathTef: String ;
begin
  LstrPathTef := trim(fCfgSis('PTTFCT')) ;
  if fEmptyStr(LstrPathTef) then
  begin
    Result := '' ;
    Exit ;
  end ;

  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
  begin
    Result := '' ;
    Exit ;
  end ;

  if not EndsStr('\', LstrPathTef) then
    LstrPathTef := LstrPathTef + '\' ;

  LstrPathTef := LstrPathTef + AstrTerminal ;

  if DirectoryExists(LstrPathTef) then
    Result := LstrPathTef + '\'
  else
    Result := '' ; //zera o path para usar as DLLs do diretorio do .exe

end ;

function fValidouPinPad(const ATefCitel: ITefCitel): Boolean;
  Const
    PINPAD_TENTAR_NOVAMENTE : Integer = 1;
    PINPAD_INICIAR_SEM_TEF : Integer = 2;
    TAMANHO_BOTOES_MSG : Integer = 200;
  Var
    intRetornoEscolhaPinPad : Integer;
    LStatusPinPad : TStatusPinPad;
    strMsgPinPad : String;
begin
  Result := True;

  if fSomenteCarregarLib then
    Exit ;

  If (Not fCfgSis('PINPRE', varBoolean)) Then
    Exit;

  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
    Exit;

  strMsgPinPad := EmptyStr;
  strMsgPinPad := strMsgPinPad + 'Leitor de cartão com fio [PINPAD] não localizado!' + sLineBreak + sLineBreak;
  strMsgPinPad := strMsgPinPad + '** Verificar se o cabo do leitor de cartão com fio [PINPAD] está plugado corretamente no computador.' + sLineBreak;
  strMsgPinPad := strMsgPinPad + 'Se for o caso, desconecte, aguarde 5 segundos e reconecte-o';

  intRetornoEscolhaPinPad := PINPAD_TENTAR_NOVAMENTE;

  repeat
    LStatusPinPad := ATefCitel.fVerificaPresencaPinPad;
    If (LStatusPinPad <> sppOperacional) Then
      intRetornoEscolhaPinPad := fMensagem('ATENÇÃO!', strMsgPinPad, ['&Tentar Novamente', '&Iniciar sem TEF'], 1, False, 1, TAMANHO_BOTOES_MSG);
  until (intRetornoEscolhaPinPad = PINPAD_INICIAR_SEM_TEF) or (LStatusPinPad = sppOperacional);

  Result := (LStatusPinPad = sppOperacional);
end;


{$IFNDEF LINUX}
{ ---------------------------------------------------------------------------
  Atualização de arquivos da estação na carga do TEF (Req. 456190, Fase 6).
  Contrato em IA\specs\456190\specs.md seção 11.
  --------------------------------------------------------------------------- }

const
  { Espelham os TEF_ATU_RET_* de untTefCitelDvcAtualizacao, dentro da
    libTefCitel.dll. São espelhados, e não compartilhados por unit, de
    propósito: untTefCitelUtil compila também para LINUX (os serviços a
    incluem), e arrastar mais uma unit para esse caminho por causa de cinco
    constantes seria arriscar o build dos serviços para ganhar pouco. Mesma
    decisão já tomada para TprocProgressoAtualizacaoTef, logo acima. }
  TEF_ATU_RET_NADA_A_FAZER = 0;
  TEF_ATU_RET_APLICADO     = 1;
  TEF_ATU_RET_ADIADO       = 2;
  TEF_ATU_RET_FALHA        = -1;
  TEF_ATU_RET_SEM_VOLTA    = -2;

  { Espelha TEF_ATU_ZIP_SERVICO de untTefCitelAtuComum, pelo mesmo motivo dos
    TEF_ATU_RET_* acima: arrastar aquela unit para ca puxaria System.Hash
    para dentro do caminho que também compila para LINUX. }
  TEF_ATU_ZIP_SERVICO = 'TefEstacaoService.zip';

var
  { Para onde o callback stdcall devolve o andamento.

    É variável de unit porque o callback atravessa a fronteira da DLL e
    precisa ser um procedure simples, sem "of object" para carregar
    instância - o mesmo motivo do VS_funcConfirmaTomadaPinpadTef do outro
    lado. Não é estado compartilhado vivendo entre chamadas: é atribuída e
    limpa DENTRO de fAtualizaEstacaoNaCarga, que é síncrona. }
  VprocStatusCargaTef: TprocStatusCargaTef = nil;

{ Data/hora do TefEstacaoService.zip que este autcom manda para a estação -
  o que vai para TFC_VERDVC (Req. 456190, decisão do Rafael em 2026-09-19).

  A origem é a MESMA que a DLL usa em fDescobrePacotes: o diretório do
  autcom.exe. Lido aqui, e não devolvido pela DLL, de propósito - seria um
  export novo para um dado que o host já tem na mão, e cada export novo é
  mais um acoplamento de versão entre autcom.exe e libTefCitel.dll (o
  try/except de fAtualizaEstacaoNaCarga existe por causa de dois deles).

  NÃO é o hash: a identidade de versão do pacote no protocolo continua sendo
  o SHA-256, que tem 64 caracteres e não caberia no VARCHAR(35). Este campo é
  para o suporte ler, e a data/hora do arquivo responde a pergunta que ele faz
  ("a estação está com o serviço de quando?").

  Vazio quando o arquivo não existe - loja rodando sem o pacote do serviço
  não tem versão a declarar, e vazio diz isso melhor que uma data inventada. }
function fVersaoZipServicoEstacao: String;
var
  LdtaArquivo: TDateTime;
  LstrArquivo: String;
begin
  Result := '';
  LstrArquivo := TPath.Combine(ExtractFilePath(ParamStr(0)), TEF_ATU_ZIP_SERVICO);

  if not FileExists(LstrArquivo) then
    Exit;

  if not FileAge(LstrArquivo, LdtaArquivo) then
    Exit;

  Result := FormatDateTime('yyyy-mm-dd hh:nn:ss', LdtaArquivo);
end;

procedure pProgressoAtualizacaoTef(const AstrEtapa: String;
  const AintFeito, AintTotal: Integer); stdcall;
begin
  if not Assigned(VprocStatusCargaTef) then
    Exit;
  try
    VprocStatusCargaTef(AstrEtapa, AintFeito, AintTotal);
  except
    { A tela de quem chamou não pode derrubar a atualização, nem a carga.

      Sem log aqui de propósito: este callback roda DENTRO da chamada da
      DLL, e gravar log em banco daqui é exatamente o que não se quer no
      meio da carga do TEF. }
  end;
end;

{ Devolve False quando a carga do TEF tem que parar aqui - só acontece
  quando o serviço da estação foi reiniciado e não voltou. }
function fAtualizaEstacaoNaCarga(var AblnEscondeMenuAdmTef: Boolean;
  AprocStatus: TprocStatusCargaTef; const AstrDirIniTerminal: String;
  out AblnAplicou: Boolean): Boolean;
var
  LintRetorno: Integer;
  LstrMensagem: String;
begin
  Result := True;
  { Falso desde a primeira linha: o except logo abaixo sai por Exit quando a
    DLL é anterior à Fase 6, e ali não se aplicou nada. }
  AblnAplicou := False;
  LstrMensagem := '';

  { O try/except NÃO é decorativo, e é o mesmo caso do
    pSetConfirmaTomadaPinpadTef algumas linhas acima: os dois exports são
    NOVOS e entram com "delayed". Se este autcom.exe rodar com uma
    libTefCitel.dll anterior à Fase 6, a chamada levanta exceção aqui - e
    derrubar o login do TEF por causa da atualização seria exatamente o
    contrário do que ela existe para fazer.

    Engolir é o desfecho certo: uma DLL sem os exports também não tem o
    código da atualização. O sistema degrada para "não atualiza a estação",
    que é o comportamento de antes desta fase. }
  try
    VprocStatusCargaTef := AprocStatus;
    try
      pSetProgressoAtualizacaoTef(pProgressoAtualizacaoTef);
      LintRetorno := fAtualizaEstacaoTefDll(objTefCitel,
                                            ExtractFilePath(ParamStr(0)),
                                            fCfgSis('TEFCIT', varString),
                                            AstrDirIniTerminal,
                                            LstrMensagem);
    finally
      VprocStatusCargaTef := nil;
      try
        pSetProgressoAtualizacaoTef(nil);
      except
        // DLL antiga: já falhou na chamada acima, não há o que desfazer
      end;
    end;
  except
    on E: Exception do
    begin
      { try aninhado pelo mesmo motivo do pSetConfirmaTomadaPinpadTef:
        pGravarErroTef desce em pGravarErro, que grava em banco, e no login
        do TEF a conexão pode não estar em estado de aceitar isso. }
      try
        TImplEventosTefCitel.pGravarErroTef(True,
          'libTefCitel.dll sem os exports da atualização de arquivos da estação ' +
          '(versão anterior ao Req. 456190, Fase 6) - o TEF segue funcionando, mas ' +
          'a estação NÃO será atualizada. Atualize a libTefCitel.dll. ' +
          E.ClassName + ': ' + E.Message, '', '');
      except
        // não abrir mão do login do TEF por causa do registro do log
      end;
      Exit;
    end;
  end;

  { Só APLICADO conta como atualização (decisão do Rafael, 2026-09-19).
    ADIADO transferiu bytes mas não trocou arquivo nenhum na estação - o
    preparo fica para a próxima carga, e datar isso como atualização faria o
    TFC_UPTDVC mentir sobre o que a estação tem instalado. }
  AblnAplicou := LintRetorno = TEF_ATU_RET_APLICADO;

  { Os quatro primeiros desfechos seguem a carga: a atualização é um
    adicional, nunca um motivo para o TEF não subir (RN23). O log de
    diagnóstico de cada um já saiu do lado da DLL. }
  if LintRetorno <> TEF_ATU_RET_SEM_VOLTA then
    Exit;

  { Único caso em que a carga para, e pelo MESMO caminho que ela já usa para
    CNPJ do Scope divergente, DLL sem o evento TEFTRA e serviço parado: o
    autcom sobe com o TEF desabilitado e o operador sabe o que pedir ao
    suporte. Sem dizer que é o serviço DA ESTAÇÃO, ele não tem como saber. }
  AblnEscondeMenuAdmTef := True;
  VS_strUsaTef := 'N';
  FIniciado    := False;
  VS_ExibirMensagemStayOnTop := True;
  try
    { Largura e altura explicitas: pMensagemOk chama fMensagem com
      blnAutosize = False, e no tamanho padrao uma mensagem de tres blocos
      aparece cortada em cima e embaixo - o operador le o miolo e nao ve nem
      a primeira linha nem o fim (campo 2026-09-19). }
    pMensagemOk(LstrMensagem + #13#10#13#10 +
      'O AUTCOM vai abrir com o TEF DESABILITADO. Verifique se o serviço ' +
      'TefEstacaoService está em execução na estação e reabra o AUTCOM.',
      700, 260);
  finally
    VS_ExibirMensagemStayOnTop := False;
  end;
  Result := False;
end;
{$ENDIF}

function fCapturaInfoPinPad(const ATefCitel: ITefCitel): String;
var
  LTefCitelV2: ITefCitelV2;
begin
  Result := '';

  if not Supports(ATefCitel, ITefCitelV2, LTefCitelV2) then
    Exit;

  try
    Result := LTefCitelV2.fObtemInfoPinPad;
  except
    on E: Exception do
      pGravaLogErro('[fCapturaInfoPinPad] ' + E.ClassName + ': ' + E.Message);
  end;
end;

procedure pIniciaTefCitel(var AblnEscondeMenuAdmTef: Boolean;
  AprocStatus: TprocStatusCargaTef = nil);
var
  qryTefTra : TUniQuery;
  strNum_ip: AnsiString;
  strNumLoj: AnsiString;
  strParAdd: AnsiString;
  intResult: Integer;
  LstrPathTef: String;
  LstrComTef: AnsiString;
  LstrMsgPP: AnsiString;
  LstrMsgErro: String ;
  LblnSomenteCarregarLib: Boolean ;
  { Req. 456190 - desfecho da atualização da estação, para o TFC_UPTDVC. }
  LblnAplicouAtualizacao: Boolean ;
  { Lido uma vez: decide o parâmetro do fCriarTefCitel E o tratamento da
    falha logo abaixo. As duas coisas têm de concordar. }
  LblnUsaDvc: Boolean ;
begin
  AblnEscondeMenuAdmTef := False ;
  FIniciado := False;
  qryTefTra := fCriaQuery(qryTefTra);
  try
    pCarregaDadosTerminalPorTipTer(qryTefTra) ;

    strNum_ip := qryTefTra.FieldByName('TFC_NUM_IP').AsAnsiString;
    strNumLoj := qryTefTra.FieldByName('TFC_NUMLOJ').AsAnsiString;
    VS_NumTerTef := String(qryTefTra.FieldByName('TFC_NUMTER').AsAnsiString);
    LstrComTef := qryTefTra.FieldByName('TFC_COMTEF').AsAnsiString;
    LstrMsgPP := AnsiString(fCfgSis('PP_MSG', varString)) ;

    FCGCEmp := AnsiString(fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False));
    FCGCCit := AnsiString(fCfgSis('SFTSAT', varString));

    if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
      strParAdd := 'ComPort='+LstrComTef+';MsgPP='+LstrMsgPP
    else
      strParAdd := '[ParmsClient=1='+FCGCEmp+';2='+FCGCCit+']';

    LstrPathTef := fDiretorioPorTerminal(String(VS_NumTerTef)) ;

    // em caso de logoff para reiniciar o objeto TEFCitel, para atualizar o path caso precise.
    if Assigned(objTefCitel) then
    begin
      objTefCitel := Nil ;
      VS_InfoPinPad := '';
    end;

    if not Assigned(objTefCitel) then
    begin
      { Antes de criar: a DLL guarda a funcao numa global e so a usa quando a
        disputa de pinpad acontecer (Req. 456190, RF27/RN16, Passo 6).
        Registrar sempre, e nao so no caminho DVC - custa uma atribuicao, e
        deixar isto amarrado a um "if" e como um dia ele nao valer mais e a
        pergunta sumir sem ninguem notar.

        O try/except NAO e decorativo (2026-09-10). pSetConfirmaTomadaPinpadTef
        e um export NOVO da libTefCitel.dll, importado com "delayed": se o
        autcom.exe novo rodar com uma DLL antiga, esta linha levanta excecao
        AQUI - antes do fCriarTefCitel - e derruba o login do TEF inteiro, por
        um motivo que nao tem nenhuma relacao aparente com a mensagem de erro.
        Era um acoplamento de versao que este requisito criou: fCriarTefCitel
        existe ha muito tempo, este export nao.

        Engolir e o desfecho certo, e nao um remendo: uma DLL sem o export
        tambem nao tem o codigo de disputa que usaria o callback. O sistema
        degrada para "nao pergunta ao operador", que e exatamente o
        comportamento anterior ao Passo 6, em vez de nao abrir o TEF. E se a
        disputa chegar a acontecer nessa combinacao, o log do lado DVC diz o
        que faltou: "nao ha funcao de confirmacao registrada pelo host". }
      try
        pSetConfirmaTomadaPinpadTef(fConfirmaTomadaPinpadTefEvent);
      except
        on E: Exception do
          { O try aninhado importa: pGravarErroTef desce em pGravarErro, que
            grava em banco. No login do TEF a conexao pode nao estar em
            estado de aceitar isso, e uma excecao levantada DENTRO deste
            except voltaria a subir - a blindagem nao blindaria nada. }
          try
            TImplEventosTefCitel.pGravarErroTef(True,
              'libTefCitel.dll sem o export pSetConfirmaTomadaPinpadTef (versao anterior ao ' +
              'Req. 456190, Passo 6) - o TEF segue funcionando, mas a tomada de pinpad de um ' +
              'AUTCOM travado nao vai perguntar ao operador. Atualize a libTefCitel.dll. ' +
              E.ClassName + ': ' + E.Message, '', '');
          except
            // nada: nao abrir mao do login do TEF por causa do registro do log
          end;
      end;

      { ESTAÇÃO SEM O CANAL DVC INSTALADO (Req. 456190, campo 2026-09-19).

        O guarda "if not Assigned" abaixo existe desde sempre e NÃO cobria
        este caso: com CFG_TEFDVC = 'S' o fCriarTefCitel abre o canal DENTRO
        do construtor (TTefCitelDvcTransporte.Create -> pAbreCanal), então uma
        estação sem o plug-in cliente registrado levanta exceção e ela sobe
        por cima do guarda, direto para o madExcept - o operador via um diálogo
        de erro técnico com "WTSVirtualChannelOpenEx" e não tinha o que fazer
        com aquilo.

        O desfecho é o MESMO já usado aqui para CNPJ do Scope divergente, DLL
        sem o evento TEFTRA e serviço da estação parado: abre sem TEF e diz ao
        operador o que pedir. Não é degradação nova - é a que existe, aplicada
        a mais uma causa.

        NÃO há queda para o caminho clássico: o pinpad está fisicamente na
        estação, e rodar o TEF dentro do autcom falaria com a porta COM do
        SERVIDOR. Sem canal, não há TEF - e dizer isso é melhor que fingir.

        Fora do caminho DVC nada muda: a exceção volta a subir como sempre
        subiu. Engolir falha do caminho clássico esconderia defeito em código
        que roda em toda loja, para ganhar nada. }
      LblnUsaDvc := fCfgSis('TEFDVC', varString) = 'S';
      try
        objTefCitel := fCriarTefCitel(LstrPathTef, fCfgSis('TEFCIT', varString),
          LblnUsaDvc);
      except
        on E: Exception do
        begin
          if not LblnUsaDvc then
            raise;

          AblnEscondeMenuAdmTef := True ;
          VS_strUsaTef := 'N';
          FIniciado    := False;
          VS_ExibirMensagemStayOnTop := True;
          try
            { Tamanho explicito - ver o comentário em fAtualizaEstacaoNaCarga.
              Este é o balao que o campo pegou cortado em 2026-09-19. }
            pMensagemOk('Não foi possível abrir o canal de comunicação com o TEF ' +
              'desta estação. A instalação do TEF nesta estação não está completa.' +
              #13#10#13#10 +
              'O AUTCOM vai abrir com o TEF DESABILITADO. Acione o suporte para ' +
              'concluir a instalação e reabra o AUTCOM.' +
              #13#10#13#10 + 'Detalhe: ' + E.Message,
              700, 320);
          finally
            VS_ExibirMensagemStayOnTop := False;
          end;
          exit ;
        end;
      end;

      if not Assigned(objTefCitel) then
      begin
        AblnEscondeMenuAdmTef := True ;
        VS_strUsaTef := 'N';
        FIniciado    := False;
        pMensagensErro('Problemas ao instanciar TEF Citel!', '', '');
        exit ;
      end ;

      if not fVerificaCnpjScope(String(FCGCEmp), String(strNumLoj), LstrPathTef, LstrMsgErro) then
      begin
        AblnEscondeMenuAdmTef := True ;
        VS_strUsaTef := 'N';
        FIniciado    := False;
        pMensagemOk(LstrMsgErro);
        exit ;
      end ;

      VS_blnTefContingencia := LstrMsgErro.Contains('contingência');

      //configurar os eventos para tratar o lck
      objTefCitel.AntesPassarCartao := TImplEventosTefCitel.fAntesPassarCartaoEvent ;
      objTefCitel.DepoisPassarCartao := TImplEventosTefCitel.pDepoisPassarCartaoEvent ;
      objTefCitel.DepoisFinalizarTransacao := TImplEventosTefCitel.pDepoisFinalizarTransacaoEvent ;
      objTefCitel.AntesCancelarTransacao := TImplEventosTefCitel.fAntesCancelarTransacaoEvent ;
      objTefCitel.DepoisCancelarTransacao := TImplEventosTefCitel.pDepoisCancelarTransacaoEvent ;
      objTefCitel.AntesReimpressao := TImplEventosTefCitel.fAntesReimpressaoEvent ;
      objTefCitel.DepoisReimpressao := TImplEventosTefCitel.pDepoisReimpressaoEvent ;
      try
        objTefCitel.SucessoTefCartao  := TImplEventosTefCitel.pSucessoTefCartaoEvent ;
      except
        on E: Exception do
        begin
          AblnEscondeMenuAdmTef := True ;
          VS_strUsaTef := 'N';
          FIniciado    := False;
          pMensagemOk('Problemas ao instanciar TEF Citel [Evento TEFTRA não encontrado na DLL]!'+#13+#10+'Atualize a LibTefCitel.dll');
          exit ;
        end ;
      end ;
    end;

    try
      objTefCitel.pSetLogErr(TImplEventosTefCitel.pGravarErroTef);
      objTefCitel.AddInfo(VS_MacAddress, VS_IPAddressAsString, VS_UserFromWindows, VS_ComputerNetName, VS_NumTerTef);
    except
      on E: Exception do
      begin
        // ignora o erro, caso tenha
      end ;
    end ;

    if not qryTefTra.IsEmpty  then
    begin
      { Req. 456190, Fase 6 - atualização de arquivos da estação.

        AQUI, e não lá em cima junto do fCriarTefCitel: fora desta guarda o
        objeto existe mas o terminal NÃO tem TEF configurado, e falar com a
        estação custaria até 30 s em todo login de um terminal que nem tem
        pinpad (RN32).

        E ANTES do fConfiguraTefCitel logo abaixo, que é o que permite
        consertar estação com DLL quebrada pela própria atualização (RN33) -
        a decisão do Rafael, aceitando que uma estação com o serviço parado
        espere 30 s aqui e mais 30 s no login.

        Também antes do fLockUnlockTefCitel: a trava LCKATC pertence ao TEF,
        e a atualização não tem nada a ver com ela.

        A trava de homologação NÃO está aqui - ela mora dentro da DLL, que é
        o ponto que não dá para contornar por esquecimento de quem chama
        (plans.md §11.15). }
      if fCfgSis('TEFDVC', varString) = 'S' then
      begin
        if not fAtualizaEstacaoNaCarga(AblnEscondeMenuAdmTef, AprocStatus,
                                       LstrPathTef, LblnAplicouAtualizacao) then
          exit ;

        { O que a estação passou a ter, e quando (Req. 456190, 2026-09-19).

          Gravado AQUI, e não junto do TFC_VERDLL lá embaixo: a atualização
          já aconteceu. Se o fConfiguraTefCitel falhar depois, os arquivos na
          estação continuam sendo os novos, e o registro tem de dizer isso -
          prender a gravação ao sucesso do login do TEF faria o suporte
          procurar uma atualização que de fato ocorreu e não está em lugar
          nenhum.

          Os dois campos andam juntos de propósito: TFC_VERDVC sozinho não diz
          desde quando, e TFC_UPTDVC sozinho não diz o quê. }
        if LblnAplicouAtualizacao then
        begin
          qryTefTra.Edit;
          qryTefTra.FieldByName('TFC_VERDVC').AsString   := fVersaoZipServicoEstacao;
          qryTefTra.FieldByName('TFC_UPTDVC').AsDateTime := fNow();
          qryTefTra.Post;
        end;

        { Último uso do TEF nesta estação (Req. 456190, decisão do Rafael em
          2026-09-19: na CARGA, uma gravação por login de operador, e não a
          cada transação - o campo responde "esta estação ainda é usada?", e
          para isso um UPDATE dentro do fluxo de venda seria caro à toa).

          Só no caminho DVC: fora dele não há estação separada do autcom e o
          campo não significaria nada.

          Edit/Post próprio, e não dentro do "if" acima: o TFC_VERDLL depende
          de o fObtemVersao ter respondido, e o uso do TEF não depende disso.
          Este ponto já está guardado por FIniciado + VS_strUsaTef = 'S' +
          objTefCitel atribuído, que é exatamente "o TEF subiu". }
        if fCfgSis('TEFDVC', varString) = 'S' then
        begin
          qryTefTra.Edit;
          qryTefTra.FieldByName('TFC_USODVC').AsDateTime := fNow();
          qryTefTra.Post;
        end;
      end;

      LblnSomenteCarregarLib := fSomenteCarregarLib ;

      { A TELA NÃO PODE FICAR NA ETAPA ANTERIOR (Req. 456190, 2026-09-20).

        Aqui a atualização já terminou e a tela ainda mostra a última etapa
        dela - normalmente "Estação do TEF atualizada.". O que vem a seguir
        é o fConfiguraTefCitel, que fala com o servidor do TEF e pode
        demorar bastante quando esse servidor não responde (VPN fora do ar,
        ScopeSrv parado, IP errado no scope.ini).

        Sem esta linha, operador e suporte leem "atualizada" durante uma
        espera que não tem nada a ver com a atualização, e o chamado chega
        como "travou atualizando a estação" - procurando defeito na Fase 6
        quando o problema é de comunicação com o TEF (campo, 2026-09-20).

        AintTotal = 0 de propósito: em pStatusCargaTefCitel esse valor cai
        no ramo que só troca o texto e repinta, sem mexer na barra - que
        deve continuar onde a atualização a deixou.

        Só no caminho DVC: fora dele não houve etapa de atualização e não há
        texto velho a corrigir. }
      if (fCfgSis('TEFDVC', varString) = 'S') and Assigned(AprocStatus) then
        AprocStatus('Aguarde, comunicando com o servidor TEF...', 0, 0) ;

      fLockUnlockTefCitel(True, LblnSomenteCarregarLib) ;
      try
        try
          intResult := objTefCitel.fConfiguraTefCitel(PAnsiChar(strNum_ip),
                                                      PAnsiChar(strNumLoj),
                                                      PAnsiChar(AnsiString(VS_NumTerTef)),
                                                      0,
                                                      PAnsiChar(strParAdd),
                                                      LblnSomenteCarregarLib);
        except
          { SERVICO DA ESTACAO PARADO NA CARGA (Req. 456190, 2026-09-12).

            Com CFG_TEFDVC = S o login do TEF vai ate o servico da estacao. Se
            ele estiver parado, o pedido fica enfileirado no plugin e nunca e
            respondido - e ate 12/09 o autcom ficava parado AQUI, na carga,
            sem tela e sem mensagem, ate alguem subir o servico.

            A DLL agora desiste quando o servico nao confirma a entrega (ver o
            comentario extenso em TTefCitelDvc.fChamaRpcUmaVez: quem desiste e
            so quem tem PROVA de que o pedido nao chegou ao servico; uma
            transacao de verdade, ja aceita, continua com espera infinita).

            O desfecho e o MESMO ja usado aqui para CNPJ do Scope divergente e
            para DLL sem o evento TEFTRA: avisa o operador e deixa o autcom
            subir com o TEF desabilitado. Nao e degradacao nova - e a que
            existe, aplicada a mais uma causa.

            Vale saber ao ler o codigo: com o TEF desabilitado assim, ele so
            volta reabrindo o autcom. Nao ha tentativa automatica de reconexao
            depois da carga. Decisao do Rafael em 12/09, e o mesmo
            comportamento das outras causas acima.

            A mensagem nao e generica de proposito: sem dizer que e o servico
            DA ESTACAO, o operador nao tem como saber o que pedir ao suporte. }
          on E: Exception do
          begin
            AblnEscondeMenuAdmTef := True ;
            VS_strUsaTef := 'N';
            FIniciado    := False;

            { TEF CLASSICO (Req. 469438, 2026-10-13). Este except tambem pega
              a falha do Scope rodando dentro do AUTCOM, com CFG_TEFDVC = N -
              campo: External exception C0000006 numa queda de rede. Ali o
              aviso do servico da estacao manda procurar o que nao existe, e
              devolver a excecao nao serve: nesta altura da carga o madExcept
              fecha o AUTCOM inteiro. Mesmo desfecho do DVC (abre sem TEF),
              com aviso proprio e o erro no LOGERR. }
            if fCfgSis('TEFDVC', varString) <> 'S' then
            begin
              { try aninhado pelo mesmo motivo do pSetConfirmaTomadaPinpadTef
                acima: pGravarErroTef grava em banco, e uma excecao dele
                subiria por cima do aviso. }
              try
                TImplEventosTefCitel.pGravarErroTef(True,
                  'Falha no login do TEF na carga do AUTCOM - ' +
                  E.ClassName + ': ' + E.Message, '', '');
              except
                // nada: o aviso ao operador vale mais que o registro do log
              end;

              VS_ExibirMensagemStayOnTop := True;
              try
                pMensagemOk('Não foi possível comunicar com o TEF.' +
                  #13#10#13#10 +
                  'O AUTCOM vai abrir com o TEF DESABILITADO. Verifique a ' +
                  'conexão com o servidor do TEF e reabra o AUTCOM. Se o ' +
                  'problema continuar, acione o suporte.' +
                  #13#10#13#10 + 'Detalhe: ' + E.Message,
                  700, 320);
              finally
                VS_ExibirMensagemStayOnTop := False;
              end ;
              exit ;
            end;

            VS_ExibirMensagemStayOnTop := True;
            try
              { Tamanho explicito pelo mesmo motivo do balao da atualização -
                ver o comentário em fAtualizaEstacaoNaCarga. Mais alto que
                aquele porque o "Detalhe:" traz a mensagem da exceção. }
              pMensagemOk('Não foi possível falar com o serviço de TEF da estação.' +
                #13#10#13#10 +
                'O AUTCOM vai abrir com o TEF DESABILITADO. Verifique se o serviço ' +
                'TefEstacaoService está em execução na estação e reabra o AUTCOM.' +
                #13#10#13#10 + 'Detalhe: ' + E.Message,
                700, 320);
            finally
              VS_ExibirMensagemStayOnTop := False;
            end ;
            exit ;
          end;
        end;
      finally
        fLockUnlockTefCitel(False, LblnSomenteCarregarLib) ;
      end ;

      if intResult = -2 then
      begin
        AblnEscondeMenuAdmTef := True ;
        VS_strUsaTef := 'N';
        FIniciado    := False;
        pMensagemLogErroTef ;
        exit ;
      end ;

      if (intResult = -3) and (fCfgSis('TEFCIT', varString) = OPCAO_NCR) then
      begin
        AblnEscondeMenuAdmTef := True ;
        VS_strUsaTef := 'N';
        FIniciado    := False;
        pMostraArquivosVerificacaoScope ;
        exit ;
      end ;

      If (intResult = 0) And (Not fValidouPinPad(objTefCitel)) Then
      Begin
        VS_strUsaTef := 'N';
        FIniciado := False;
        Exit;
      End;

      If (intResult = -4) Then
      Begin
        If (Not fValidouPinPad(objTefCitel)) Then
        Begin
          VS_strUsaTef := 'N';
          FIniciado := False;
          Exit;
        End;

        intResult := 0;
      End;

      VS_strUsaTef := 'S';
      FIniciado := True;
      if intResult <> 0 then
      begin
        AblnEscondeMenuAdmTef := True ;
        fTraduzErrosConexao(intResult);
        VS_strUsaTef := 'N';
      end
      else
        VS_InfoPinPad := fCapturaInfoPinPad(objTefCitel);
    end
    else
    begin
      AblnEscondeMenuAdmTef := True ;
      VS_strUsaTef := 'N';
      FIniciado    := False;
    end;

  finally
    if (VS_strUsaTef = 'S') and FIniciado and Assigned(objTefCitel) then
    begin
      VS_blnTefCitel             := True;
      VS_blnTefCitelIndisponivel := False;
    end
    else
    begin
      VS_blnTefCitel             := False;
      VS_strUsaTef               := 'N';
      VS_blnTefCitelIndisponivel := True;
    end;

    FreeAndNil(qryTefTra);
  end;
end;

procedure pInicializaVariavelGlobalPixScope;
begin
  VS_TefPixLigado  := fCfgSis('PIXSCP');
  VS_TefPix_PXCEMP := fCfgSis('PXCEMP');
  VS_TefPix_PXCPDV := fCfgSis('PXCPDV');
  VS_TefPix_TEFCIT := OPCAO_NCR;
  VS_TefPix_PATDIR := fDiretorioPorTerminal(VS_TefPix_PXCPDV);
  VS_TefPix_TEFDVC := fCfgSis('TEFDVC');
end;

function fImpCupom(strViaCli, strViaLoj: String): Boolean;
var
  intQtdVias, intContVias : Integer;
  LblnQtdViasExterna : Boolean;
  LstrOpcaoImp: string;
begin
  Result := False;

  intQtdVias := 1;
  if not fEmptyStr(fCfgSisL('QTDVIA')) then
    intQtdVias := StrToInt(fCfgSisL('QTDVIA'));

  if intQtdVias = 0 then
  begin
    Result := True;
    Exit;
  end;

  LblnQtdViasExterna := intQtdVias > 1 ;
  LstrOpcaoImp := fTipoViasImpressaoTef ;

  if fEmptyStr(LstrOpcaoImp) then
  begin
    Result := True;
    Exit;
  end;

  for intContVias := 1 to intQtdVias do
  begin
    if LstrOpcaoImp = 'A' then
    begin
      pImprimirCliente(strViaCli, strViaLoj, LblnQtdViasExterna);
      pImprimirLojista(strViaCli, strViaLoj, LblnQtdViasExterna);
      Result := True;
    end;

    if LstrOpcaoImp = 'C' then
    begin
      pImprimirCliente(strViaCli, strViaLoj, LblnQtdViasExterna);
      Result := True;
    end;

    if LstrOpcaoImp = 'E' then
    begin
      pImprimirLojista(strViaCli, strViaLoj, LblnQtdViasExterna);
      Result := True;
    end;
  end;
end;

function fInstanciaPixTef(const ACodigoLoja, ACodigoTerminal: String;
                          out AMensagem: String): ITefCitel;
var
  LPararametrosAdicionais: String;
  LPathTef: String;
begin
  Result := Nil;
  AMensagem := '';

  if fEmptyStr(ACodigoLoja) then
  begin
    AMensagem := 'Código Loja/Filial não informada!';
    Exit;
  end;

  if fEmptyStr(ACodigoTerminal) then
  begin
    AMensagem := 'Código Terminal não informado!';
    Exit;
  end;

  if Length(ACodigoLoja) <> 8 then
  begin
    AMensagem := 'Código Loja/Filial deve ter 8 digitos!';
    Exit;
  end;

  LPathTef := VS_TefPix_PATDIR;
  LPararametrosAdicionais := 'ComPort=;MsgPP=';

  { Acerta o MainThreadID da libTefCitel.dll - causa completa em
    pSetThreadPrincipalHost (untFuncoesLibTefCitel.pas).

    AQUI, e so aqui, porque este e o unico caminho que carrega a DLL fora da
    thread principal: fInstanciaPixTef roda dentro de um TTask
    (TFatVendaBase.CarregaLibRequisicoesPix -> CarregaLibIntegracaoPixCitel ->
    TPixTefBridgeAutcom.Create). Se ele chegar antes da carga do TEF, a DLL
    nasce com o MainThreadID da thread de pool e nenhum evento chega a tela.
    Como o import e "delayed", esta e a PRIMEIRA chamada a DLL neste caminho:
    carrega e acerta no mesmo passo. Sem Pix, quem carrega a DLL e a carga do
    TEF, na thread principal, e nao ha o que acertar - por isso nao existe
    chamada no login, e maquina sem Pix e sem TEF nunca toca na DLL.

    Chamar de dentro do TTask e seguro: MainThreadID aqui e o do autcom.exe,
    que e a thread da tela seja qual for a thread que executa esta linha.

    So com CFG_TEFDVC e CFG_PIXSCP = 'S': o defeito vive no TTefCitelDvc.
    Falha e silenciosa (erros.txt) - o pSetConfirmaTomadaPinpadTef logo
    abaixo ja reporta a DLL ausente, com a mensagem propria dele. }
  if (VS_TefPix_TEFDVC = 'S') and (VS_TefPixLigado = 'S') then
  begin
    try
      pSetThreadPrincipalHost(MainThreadID);
    except
      on E: Exception do
        try
          pGravaLogErro('[fInstanciaPixTef] pSetThreadPrincipalHost indisponivel ' +
            '(DLL ausente ou anterior a correcao) - ' + E.ClassName + ': ' + E.Message);
        except
          // log e melhor esforco: nunca derrubar o Pix por causa dele
        end;
    end;
  end;

  { try/except pelo mesmo motivo de pIniciaTefCitel: export novo com "delayed"
    derrubaria este caminho com uma DLL antiga (RF27/RN16, Passo 6). }
  try
    pSetConfirmaTomadaPinpadTef(fConfirmaTomadaPinpadTefEvent);
  except
    on E: Exception do
      try
        TImplEventosTefCitel.pGravarErroTef(True,
          'libTefCitel.dll sem o export pSetConfirmaTomadaPinpadTef - ver pIniciaTefCitel. ' +
          E.ClassName + ': ' + E.Message, '', '');
      except
        // ver o comentario em pIniciaTefCitel
      end;
  end;
  { ESTAÇÃO SEM O CANAL DVC INSTALADO, pelo caminho do PIX (Req. 456190,
    C.9 - campo 2026-09-19).

    Mesmo defeito consertado no pIniciaTefCitel na véspera: com
    CFG_TEFDVC = 'S' o canal é aberto DENTRO do construtor, então a exceção
    sobe por fCriarTefCitel. Quem chamava sem try/except via o diálogo do
    madExcept - foi o caso do botão "Assoc. Chave Pix Scope" no cadastro de
    contas bancárias.

    A saída é o contrato que esta função JÁ tem para as outras falhas: nil com
    AMensagem preenchida. Os dois chamadores já tratam isso e nada muda de
    forma para eles - fRetornaDadosBandeiraRedePixScope sai pelo
    AMensagemErro (e o untCadCCa o registra em log e mostra), e
    TPixTefBridgeAutcom.fInstanciaTefCitel cai no MESMO Exit(False) de antes,
    agora com um texto que diz o que aconteceu em vez de "Falha ao instanciar
    TEF Scope para Pix: <excecao>".

    O texto vai CURTO de propósito. Quem o exibe é um fMensagem comum, sem
    tamanho explicito, e fMensagem tambem nasce com blnAutosize = False -
    mensagem de três blocos apareceria cortada, como aconteceu em 19/09 no
    balão da carga. O detalhe técnico vai para o log, que é onde o suporte
    procura.

    Só o caminho DVC: fora dele a exceção sobe como sempre subiu. }
  { Le do GLOBAL, e nao de fCfgSis, pelo mesmo motivo dos VS_TefPix_* acima
    (campo 2026-09-24).

    Este caminho roda dentro de um TTask - TFatVendaBase.CarregaLibRequisicoesPix
    -> CarregaLibIntegracaoPixCitel -> TPixTefBridgeAutcom.Create -> aqui. Chamar
    fCfgSis nessa thread encerrava por <CFGSIS_CODEMP_VAZIO>: o pSetaEmpresaCfg
    nao consegue deduzir a empresa fora da thread principal.

    O pInicializaVariavelGlobalPixScope ja resolve isso para PXCEMP, PXCPDV e
    PATDIR - le tudo na thread principal e guarda no global. O TEFDVC entra na
    mesma lista, pelo mesmo motivo. }
  try
    Result := fCriarTefCitel(LPathTef, VS_TefPix_TEFCIT,
      VS_TefPix_TEFDVC = 'S');
  except
    on E: Exception do
    begin
      if VS_TefPix_TEFDVC <> 'S' then
        raise;

      Result := nil;
      AMensagem := 'Não foi possível abrir o canal de comunicação com o TEF ' +
        'desta estação. A instalação do TEF nesta estação não está completa - ' +
        'acione o suporte.';

      { try aninhado pelo mesmo motivo de sempre nesta unit: pGravarErroTef
        desce em pGravarErro, que grava em banco, e perder a mensagem ao
        usuário por causa do log seria trocar o certo pelo duvidoso. }
      try
        TImplEventosTefCitel.pGravarErroTef(True,
          'PIX via Scope: canal DVC da estação indisponível. ' +
          E.ClassName + ': ' + E.Message, '', '');
      except
        // nada
      end;

      Exit;
    end;
  end;

  try
    Result.fConfiguraTefCitel(PAnsiChar(AnsiString('')),
                              PAnsiChar(AnsiString(ACodigoLoja)),
                              PAnsiChar(AnsiString(ACodigoTerminal)),
                              0,
                              PAnsiChar(AnsiString(LPararametrosAdicionais)),
                              True);
    ///associa os eventos
    Result.AntesPassarCartao := TImplEventosTefCitel.fAntesPassarCartaoEvent ;
    Result.DepoisPassarCartao := TImplEventosTefCitel.pDepoisPassarCartaoEvent ;
    Result.DepoisFinalizarTransacao := TImplEventosTefCitel.pDepoisFinalizarTransacaoEvent ;
    Result.AntesCancelarTransacao := TImplEventosTefCitel.fAntesCancelarTransacaoEvent ;
    Result.DepoisCancelarTransacao := TImplEventosTefCitel.pDepoisCancelarTransacaoEvent ;
    Result.AntesReimpressao := TImplEventosTefCitel.fAntesReimpressaoEvent ;
    Result.DepoisReimpressao := TImplEventosTefCitel.pDepoisReimpressaoEvent ;
    Result.SucessoTefCartao  := TImplEventosTefCitel.pSucessoTefCartaoEvent ;
  except
    Result := nil;
    raise;
  end;
  //
end;

{ Req. 470363 - so o TEF DVC responde; no classico Supports e False e o
  fechamento segue como sempre. ATefCitel nil = objTefCitel (a ponte do Pix
  usa instancia propria). }
function fFinalizacaoTefNaoRealizada(out AblnSeraReenviada: Boolean;
  const ATefCitel: ITefCitel = nil): Boolean;
var
  LTefCitel: ITefCitel;
  LFinalizacao: ITefCitelFinalizacao;
begin
  AblnSeraReenviada := False;
  LTefCitel := ATefCitel;
  if not Assigned(LTefCitel) then
    LTefCitel := objTefCitel;
  Result := Supports(LTefCitel, ITefCitelFinalizacao, LFinalizacao) and
            LFinalizacao.fUltimaFinalizacaoNaoRealizada;
  if Result then
    AblnSeraReenviada := LFinalizacao.fUltimaFinalizacaoSeraReenviada;
end;

procedure pDescreveFinalizacaoTef(const AstrDescricao: String;
  const ATefCitel: ITefCitel = nil);
var
  LTefCitel: ITefCitel;
  LFinalizacao: ITefCitelFinalizacao;
begin
  LTefCitel := ATefCitel;
  if not Assigned(LTefCitel) then
    LTefCitel := objTefCitel;
  if Supports(LTefCitel, ITefCitelFinalizacao, LFinalizacao) then
    LFinalizacao.pDescreveFinalizacaoPendente(AstrDescricao);
end;

{ Fora da thread principal (ponte do Pix, que roda em TTask) o modal vai pela
  fila da thread principal: fMensagem e VCL. }
procedure pAvisaFinalizacaoTefNaoRealizada(const AblnSeraReenviada: Boolean;
  const AfltValor: Double; const AstrControle: String);
var
  LstrAviso: String;
begin
  if AblnSeraReenviada then
    LstrAviso := 'A confirmação do cartão não chegou ao TEF da estação (a conexão caiu). '
  else
    LstrAviso := 'A confirmação do cartão não chegou ao TEF da estação (o serviço de TEF foi reiniciado). ';
  LstrAviso := LstrAviso + 'O faturamento foi concluído, mas a transação de R$ ' +
    FormatFloat('#,##0.00', AfltValor) + ' (Controle ' + AstrControle + ') ficou PENDENTE no TEF.';

  if TThread.CurrentThread.ThreadID = MainThreadID then
    fMensagem('ATENÇÃO!', LstrAviso, ['&Ok'], 1)
  else
    TThread.Queue(nil,
      procedure
      begin
        fMensagem('ATENÇÃO!', LstrAviso, ['&Ok'], 1);
      end);
end;

function fFinalizaCartao(strNumDoc,
                         strDtaTra,
                         strHraTra,
                         strViaCli,
                         strViaLoj,
                         strNumNsu,
                         strIncDoc,
                         strTabela : String;
                         fltValCar: Double;
                         strComImp : String;
                         strSeqCon : String;
                         const AstrControle: String) : Boolean;
var
  LblnImprimiuCupom : Boolean;
  LblnComita : Boolean;
  LblnNaoConfirmada : Boolean;
  LblnSeraReenviada : Boolean;
begin
  LblnImprimiuCupom := fImpCupom(strViaCli, strViaLoj);
  LblnComita := False;
  LblnNaoConfirmada := False;
  LblnSeraReenviada := False;

  If (Not fInTransaction) Then
  Begin
    fStartTransaction;
    LblnComita := True;
  End;

  try
    if LblnImprimiuCupom then
    begin
      try
        pFinalizaTranscacao(True, strDtaTra, strHraTra, strNumDoc, '');
        { A confirmacao nao chegou a estacao que aprovou (canal caiu, ou o
          servico reiniciou): a TEFTRA fica PENDENTE, que e o unico registro
          honesto - o desfecho no Scope ainda nao se sabe (Req. 470363). }
        LblnNaoConfirmada := fFinalizacaoTefNaoRealizada(LblnSeraReenviada);
        if LblnSeraReenviada then
          pDescreveFinalizacaoTef('R$ ' + FormatFloat('#,##0.00', fltValCar) +
                                  ' (Controle ' + AstrControle + ')');
        if not LblnNaoConfirmada then
          pGravaTransacaoFinalizada(strNumDoc,
                                    fPadL(strNumNsu, 14, '0'),
                                    strDtaTra,
                                    strHraTra,
                                    strIncDoc,
                                    strTabela,
                                    fltValCar,
                                    strComImp,
                                    strSeqCon,
                                    AstrControle);
      except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[fFinalizaCartao-TEF-Finaliza]');
        End;
      end ;
      Result := True;
    end
    else
    begin
      pFinalizaTranscacao(False, strDtaTra, strHraTra, strNumDoc, '');
      pGravaTransacaoEstornada(strNumDoc,
                               fPadL(strNumNsu, 14, '0'),
                               strDtaTra,
                               strHraTra,
                               strIncDoc,
                               strTabela,
                               fltValCar,
                               AstrControle);
      Result := False;
    end;
    If (LblnComita) Then
    begin
      fCommit;
    end ;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fFinalizaCartao]');
    End;
  End;

  { Depois do commit: o modal nao segura a transacao do banco aberta. }
  if LblnNaoConfirmada then
    pAvisaFinalizacaoTefNaoRealizada(LblnSeraReenviada, fltValCar, AstrControle);
end;

procedure pGravaTransacaoCliSiTef(strNumDoc,
                                  strAutInc,
                                  strNumNsu,
                                  strDtaTra,
                                  strHraTra,
                                  strPixS_N,
                                  strOpeRcx,
                                  strOpcDoc: String;
                                  fltValor: Double;
                                  blnFinalizado,
                                  blnEstornado,
                                  blnCancelamento : Boolean;
                                  strNumCcd : String;
                                  strComImp : String;
                                  strSeqCon : String;
                                  strTipOpe : String = '';
                                  strModali : String = '';
                                  strIncDoc : String = '';
                                  strTabela : String = '';
                                  intQtdPar : Integer = 0;
                                  strCodigoCarteiraDigital : String = '';
                                  const AstrControle: String = '';
                                  const AstrStatus: String = '';
                                  const AstrComAux: String = '';
                                  const AblnUpdateEmLib: Boolean = False);
var
  strStatus : String;
  strDescTra : String;
  DataTra : TDate;
  HoraTra : TTime;
  qryTefTra: TUniQuery;
begin
  qryTefTra := fCriaQuery(nil);
  Try
    qryTefTra.SQL.Clear;
    qryTefTra.SQL.Add(' SELECT * ');
    qryTefTra.SQL.Add('   FROM TEFTRA ');
    qryTefTra.SQL.Add('  WHERE TFT_NUMDOC = :NUMDOC ');
    qryTefTra.SQL.Add('    AND TFT_DTATRA = :DATA ');
    qryTefTra.SQL.Add('    AND TFT_CODEMP = :CODEMP ');
    qryTefTra.SQL.Add('    AND TFT_NOMMAQ = :NOMMAQ ');

    qryTefTra.ParamByName('NUMDOC').AsString := strNumDoc;
    qryTefTra.ParamByName('DATA').AsString   := strDtaTra;
    qryTefTra.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTefTra.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
    qryTefTra.Open;

    strStatus := 'PENDENTE';

    if blnFinalizado then
      strStatus := 'EFETUADA PDV'
    else if blnEstornado then
      strStatus := 'CANCELADA PDV'
    else if not fEmptyStr(AstrStatus) then
      strStatus := AstrStatus ;

    strDescTra := fBuscaDesTra(strTipOpe, strModali, blnCancelamento, strCodigoCarteiraDigital);

    DataTra := StrToDate(copy(strDtaTra, 7,2) +'/'+ copy(strDtaTra, 5, 2) +'/'+ copy(strDtaTra,1,4));
    HoraTra := StrToTime(copy(strHraTra,1,2)+':'+copy(strHraTra,3,2) + ':' + copy(strHraTra,5,2));

    If qryTefTra.IsEmpty Then
    Begin
      if strOpeRcx = '' then
        strOpeRcx := VS_strCodigoOperadorLogadoCaixa;

      if strOpeRcx = '' then
        strOpeRcx := strLoginUsuarioLogado;

      qryTefTra.Append;
      qryTefTra.FieldByName('AUTOINCREM').AsString   := strAutInc;
      qryTefTra.FieldByName('TFT_DTATRA').AsDateTime := DataTra;
      qryTefTra.FieldByName('TFT_HRATRA').AsDateTime := HoraTra;
      qryTefTra.FieldByName('TFT_NUMDOC').AsString   := strNumDoc;
      qryTefTra.FieldByName('TFT_VALTRA').AsFloat    := fltValor;
      qryTefTra.FieldByName('TFT_STATUS').AsString   := strStatus;
      qryTefTra.FieldByName('TFT_NUMNSU').AsString   := strNumNsu;
      qryTefTra.FieldByName('TFT_MACADD').AsString   := VS_MacAddress;
      qryTefTra.FieldByName('TFT_NOMUSU').AsString   := VS_UserFromWindows;
      qryTefTra.FieldByName('TFT_CODEMP').AsString   := VS_strCodEmp;
      qryTefTra.FieldByName('TFT_PIXS_N').AsString   := strPixS_N;
      qryTefTra.FieldByName('TFT_OPERCX').AsString   := strOpeRcx;
      qryTefTra.FieldByName('TFT_OPCDOC').AsString   := strOpcDoc;
      qryTefTra.FieldByName('TFT_QTDPAR').AsInteger  := intQtdPar;
      qryTefTra.FieldByName('TFT_MODALI').AsString   := strModali;
      qryTefTra.FieldByName('TFT_NUMCCD').AsString   := strNumCcd;
      qryTefTra.FieldByName('TFT_TIPOPE').AsString   := strTipOpe;
      qryTefTra.FieldByName('TFT_DESTRA').AsString   := strDescTra;
      qryTefTra.FieldByName('TFT_COMIMP').AsString   := strComImp;
      qryTefTra.FieldByName('TFT_SEQCON').AsString   := strSeqCon;
      qryTefTra.FieldByName('TFT_NUM_IP').AsString   := VS_IPAddressAsString;
      qryTefTra.FieldByName('TFT_NOMMAQ').AsString   := VS_ComputerNetName;
      qryTefTra.FieldByName('TFT_NUMTER').AsString   := VS_NumTerTef;
      qryTefTra.FieldByName('TFT_CONTRO').AsString   := AstrControle;
      qryTefTra.FieldByName('TFT_COMAUX').AsString   := AstrComAux;

      qryTefTra.FieldByName('TFT_PINPAD').AsString   :=
        fTruncaCampoLimiteDB(VS_InfoPinPad, qryTefTra.FieldByName('TFT_PINPAD'));

      qryTefTra.Post;
    End
    Else
    begin
      qryTefTra.Edit;
      qryTefTra.FieldByName('TFT_STATUS').AsString := strStatus;
      qryTefTra.FieldByName('TFT_INCDOC').AsString := strIncDoc;
      qryTefTra.FieldByName('TFT_TABELA').AsString := strTabela;
      qryTefTra.FieldByName('TFT_COMIMP').AsString := strComImp;
      qryTefTra.FieldByName('TFT_SEQCON').AsString := strSeqCon;
      qryTefTra.FieldByName('TFT_CONTRO').AsString   := AstrControle;
      qryTefTra.FieldByName('TFT_COMAUX').AsString   := AstrComAux;
      if AblnUpdateEmLib then
      begin
        qryTefTra.FieldByName('TFT_DTATRA').AsDateTime := DataTra;
        qryTefTra.FieldByName('TFT_HRATRA').AsDateTime := HoraTra;
        qryTefTra.FieldByName('TFT_NUMNSU').AsString   := strNumNsu;
        qryTefTra.FieldByName('TFT_PIXS_N').AsString   := strPixS_N;
        qryTefTra.FieldByName('TFT_QTDPAR').AsInteger  := intQtdPar;
        qryTefTra.FieldByName('TFT_MODALI').AsString   := strModali;
        qryTefTra.FieldByName('TFT_NUMCCD').AsString   := strNumCcd;
        qryTefTra.FieldByName('TFT_TIPOPE').AsString   := strTipOpe;
        qryTefTra.FieldByName('TFT_DESTRA').AsString   := strDescTra;
      end ;

      if not VS_InfoPinPad.IsEmpty then
      begin
        qryTefTra.FieldByName('TFT_PINPAD').AsString :=
          fTruncaCampoLimiteDB(VS_InfoPinPad, qryTefTra.FieldByName('TFT_PINPAD'));
      end;

      qryTefTra.Post;
    end;
  Finally
    FreeAndNil(qryTefTra);
  End;
end;

procedure pGravaDocumentosTefTra(const AarrDocs: TArrayInfoTraDoc) ;
var
  LintCnt: Integer ;
  LqryTraDoc: TUniQuery ;
begin

  if not Assigned(AarrDocs) then
    Exit ;

  if Length(AarrDocs) = 0 then
    Exit ;

  LqryTraDoc := fCriaQuery ;
  try
    LqryTraDoc.SQL.Clear ;
    LqryTraDoc.SQL.Add('SELECT * FROM TRADOC WHERE FALSE') ;
    LqryTraDoc.Open ;

    for LintCnt := Low(AarrDocs) to High(AarrDocs) do
    begin
      LqryTraDoc.Insert ;
      LqryTraDoc.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('TRADOC', VS_strCodEmp) ;
      LqryTraDoc.FieldByName('TRD_NUMDOC').AsString := AarrDocs[LintCnt].NumDoc ;
      LqryTraDoc.FieldByName('TRD_DTATRA').AsDateTime := AarrDocs[LintCnt].DtaTra ;
      LqryTraDoc.FieldByName('TRD_CODEMP').AsString := AarrDocs[LintCnt].CodEmp ;
      LqryTraDoc.FieldByName('TRD_NUMDUP').AsString := AarrDocs[LintCnt].NumDup ;
      LqryTraDoc.FieldByName('TRD_ESPDOC').AsString := AarrDocs[LintCnt].EspDoc ;
      LqryTraDoc.FieldByName('TRD_PARCEL').AsString := AarrDocs[LintCnt].Parcel ;
      LqryTraDoc.FieldByName('TRD_EMPDOC').AsString := AarrDocs[LintCnt].EmpDoc ;
      LqryTraDoc.Post ;
    end ;
  finally
    FreeAndNil(LqryTraDoc) ;
  end ;

end ;

procedure pGravaTransacaoEstornada(strNumDoc,
                                   strNsu,
                                   strDtaTra,
                                   strHraTra,
                                   strIncDoc,
                                   strTabela: String;
                                   fltValor : Double;
                                   const AstrControle: String);
var
  LstrCodigoCarteiraDigital: string ;
begin
  LstrCodigoCarteiraDigital := fRetornaCarteiraDigital(strNsu, StrToDate(copy(strDtaTra, 7,2) +'/'+ copy(strDtaTra, 5, 2) +'/'+ copy(strDtaTra,1,4)), fltValor) ;
  pGravaTransacaoCliSiTef(strNumDoc,
                          fRetAutoIncrem('TEFTRA', VS_strCodEmp),
                          strNsu,
                          strDtaTra,
                          strHraTra,
                          '',
                          '',
                          '',
                          fltValor,
                          false,
                          True,
                          false,
                          '',
                          '',
                          '',
                          '',
                          '',
                          strIncDoc,
                          strTabela,
                          0,
                          LstrCodigoCarteiraDigital,
                          AstrControle);

end;

procedure pGravaTransacaoFinalizada(strNumDoc,
                                    strNsu,
                                    strDtaTra,
                                    strHraTra,
                                    strIncDoc,
                                    strTabela : String;
                                    fltValor : Double;
                                    strComImp : String;
                                    strSeqCon : String;
                                    const AstrControle: String);
var
  LstrCodigoCarteiraDigital : String ;
begin
  LstrCodigoCarteiraDigital := fRetornaCarteiraDigital(strNsu, StrToDate(copy(strDtaTra, 7,2) +'/'+ copy(strDtaTra, 5, 2) +'/'+ copy(strDtaTra,1,4)), fltValor) ;
  pGravaTransacaoCliSiTef(strNumDoc,
                          fRetAutoIncrem('TEFTRA', VS_strCodEmp),
                          strNsu,
                          strDtaTra,
                          strHraTra,
                          '',
                          '',
                          '',
                          fltValor,
                          True,
                          false,
                          false,
                          '',
                          strComImp,
                          strSeqCon,
                          '',
                          '',
                          strIncDoc,
                          strTabela,
                          0,
                          LstrCodigoCarteiraDigital,
                          AstrControle);
end;

procedure pGravaTransacaoPendente(strNumDoc,
                                  strNsu,
                                  strDtaTra,
                                  strHraTra,
                                  strPixS_N,
                                  strOpeRcx,
                                  strOpcDoc : String;
                                  fltValor : Double;
                                  AstrComAux: String ;
                                  intQtdPar : Integer = 0;
                                  strModali: String = '';
                                  strNumCcd: String = '';
                                  strTipOpe: String = '';
                                  strCodigoCarteiraDigital: String = '';
                                  const AstrControle: String = '';
                                  const AarrDocs: TArrayInfoTraDoc = Nil;
                                  const AstrStatus: String = '');
var
  LblnUpdateInLib: Boolean ;
begin
  LblnUpdateInLib := True ;
  pGravaTransacaoCliSiTef(strNumDoc,
                          fRetAutoIncrem('TEFTRA', VS_strCodEmp),
                          strNsu,
                          strDtaTra,
                          strHraTra,
                          strPixS_N,
                          strOpeRcx,
                          strOpcDoc,
                          fltValor,
                          false,
                          false,
                          false,
                          strNumCcd,
                          '',
                          '',
                          strTipOpe,
                          strModali,
                          '',
                          '',
                          intQtdPar,
                          strCodigoCarteiraDigital,
                          AstrControle,
                          AstrStatus,
                          AstrComAux,
                          LblnUpdateInLib);

  pGravaDocumentosTefTra(AarrDocs) ;
end;

procedure pEstornaTransacaoPendente(Confirma: Boolean; strData, strHora, strNumDoc, strParamAdc : String);
begin
  objTefCitel.fFinalizarTransacao(False, AnsiString(strData), AnsiString(strHora), AnsiString(strNumDoc), AnsiString(strParamAdc));
end;

function fVerificaPendenciasTEFCitel : Boolean;
var
  frmTefCitelDadosCartao : TfrmTefCitelDadosCartao;
  cdsPendencias : TUniClientDataSet;
  LblnEscondeMenuAdmTef: Boolean ;
begin
  Result := False;

  if not FIniciado then
    pIniciaTefCitel(LblnEscondeMenuAdmTef);

  cdsPendencias := fConsultaTransacoesPendentes;

  if Assigned(cdsPendencias) then
  begin
    if not cdsPendencias.IsEmpty then
    begin
      Result := True;
      pCriarFormularios(TfrmTefCitelDadosCartao, frmTefCitelDadosCartao);
      try
        frmTefCitelDadosCartao.CdsDados := CdsPendencias;
        frmTefCitelDadosCartao.ShowModal;
      finally
        FreeAndNil(cdsPendencias);
        pFreeAndNil(frmTefCitelDadosCartao);
      end;
    end;
  end;
end;

procedure pFinalizaTranscacao(blnFinaliza: Boolean; strDtaTra, strHraTra, strNumDoc, strParamAdc : String; const ATefCitel: ITefCitel = Nil);
var
  LTefCitel: ITefCitel;
begin
  if Assigned(ATefCitel) then
    LTefCitel := ATefCitel
  else
    LTefCitel := objTefCitel;

  LTefCitel.fFinalizarTransacao(blnFinaliza, AnsiString(strDtaTra), AnsiString(strHraTra), AnsiString(strNumDoc), AnsiString(strParamAdc));
end;

function fCancelamentoNormal(strCodOpe: String;
                             dtaDtaTra: TDate;
                             hraHraTra: TTime;
                             numdoc: String;
                             fltValor: Double;
                             strTipCar: String;
                             strSeqCon : String;
                             strCodigoCarteiraDigital: String) : IRetornoTEFCitel;
var
  strNovoNumDoc : String;
  strArqViaCliente: String;
  strArqViaLojista: String;
  strDtaTra: String;
  strHraTra: String;
  strTipOpe : String;
  strModali : String;
  intOperacao : Integer;
  LstrControle : String ;
  LstrAutoInc: string;
  LstrDataHora: String ;
  LdtaAgora: TDateTime ;
begin
  strNovoNumDoc := fRetNumDocTransacaoTef;
  LstrAutoInc   := fRetAutoIncrem('TEFTRA', VS_strCodEmp);

  LdtaAgora := fNow();
  LstrDataHora := Format('%.*d',[4, YearOf(LdtaAgora)]) + Format('%.*d',[2, MonthOf(LdtaAgora)]) + Format('%.*d',[2, DayOf(LdtaAgora)]) + Format('%.*d',[2, HourOf(LdtaAgora)]) + Format('%.*d',[2, MinuteOf(LdtaAgora)]) + Format('%.*d',[2, SecondOf(LdtaAgora)]) ;
  strDtaTra := copy(LstrDataHora,1,8);
  strHraTra := copy(LstrDataHora,9,6);

  //CNC INICIADO
  pGravaTransacaoCliSiTef(strNovoNumDoc,
                        LstrAutoInc,
                        '00000000000000',
                        strDtaTra,
                        strHraTra,
                        'N',
                        strLoginUsuarioLogado,
                        'DM',
                        fltValor,
                        False,
                        False,
                        True,
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        0,
                        strCodigoCarteiraDigital,
                        '',
                        CANCELAMENTO_INICIADO,
                        '',
                        True);

  intOperacao := 200;
  if strTipCar = '123' then
    intOperacao := StrToInt(strTipCar);

  { 9o parametro (strModoEntrada) exigido pela interface do modulo
    ^/libTefCitel. Esta linha e anterior ao recurso de modo de entrada e nao
    tem o fRetornaModoEntradaTransacao; vazio e o caminho suportado - o
    fAjustaMsgModoEntrada sai por 'if FModoEntrada.IsEmpty then Exit' e devolve
    a mensagem intacta, que e o comportamento de antes do recurso. }
  Result := objTefCitel.fCancelaTransacaoTerminal(intOperacao,
                                                  AnsiString(strCodOpe),
                                                  dtaDtaTra,
                                                  hraHraTra,
                                                  AnsiString(numdoc),
                                                  fltValor,
                                                  strTipCar,
                                                  strCodigoCarteiraDigital,
                                                  EmptyStr);

  if fTefLogImplementado(objTefCitel) then
    TLogTef.pLogaBloco(objTefCitel.pRetornaLog) ;

  if (not Assigned(Result)) or fEmptyStr(Result.DadosCartao.strConteudoViaCliente) then
  begin
    Result := nil;

    //CNC CANCEL
    pGravaTransacaoCliSiTef(strNovoNumDoc,
                          LstrAutoInc,
                          '00000000000000',
                          strDtaTra,
                          strHraTra,
                          'N',
                          strLoginUsuarioLogado,
                          'DM',
                          fltValor,
                          False,
                          False,
                          True,
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          0,
                          strCodigoCarteiraDigital,
                          '',
                          CANCELAMENTO_CANCELADO,
                          '',
                          True);
  end
  else
  begin
    strArqViaCliente := Result.DadosCartao.strConteudoViaCliente;
    strArqViaLojista := Result.DadosCartao.strConteudoViaLojista;
    strDtaTra        := copy(Result.DadosCartao.strDataHoraTrans,1,8);
    strHraTra        := copy(Result.DadosCartao.strDataHoraTrans,9,6);
    LstrControle     := Result.DadosCartao.strControle;

    pGravaTransacaoCancelada(numdoc, dtaDtaTra, strTipOpe, strModali, strSeqCon);

    pGravaTransacaoCliSiTef(strNovoNumDoc,
                            LstrAutoInc,
                            fPadL(Result.DadosCartao.strNSU, 14, '0'),
                            strDtaTra,
                            strHraTra,
                            'N',
                            strLoginUsuarioLogado,
                            'DM',
                            fltValor,
                            True,
                            False,
                            True,
                            Result.DadosCartao.strAutorizacao,
                            strArqViaCliente + #13 + strArqViaLojista,
                            strSeqCon,
                            strTipOpe,
                            strModali,
                            '',
                            '',
                            0,
                            strCodigoCarteiraDigital,
                            LstrControle,
                            '',
                            '',
                            True);

    fImpCupom(strArqViaCliente, strArqViaLojista);
  end;
end;

function fConsultaTransacoesPendentes : TUniClientDataSet;
begin
  Result := objTefCitel.fConsultaTransacoesPendentesTerminal;
end;

procedure pRetornaIncDocTabela(strNumDoc,
                               strEspDoc,
                               strEmpDoc,
                               strCodCli : String;
                               out strIncDoc : String;
                               out strTabela : String);
var
  QryIncDoc : TUniQuery;
begin
  if (Pos(strEspDoc, 'PD_OR_') <= 0) then
  begin
    QryIncDoc := fCriaQuery(nil);
    try
      QryIncDoc.Close;
      QryIncDoc.SQL.Clear;
      QryIncDoc.SQL.Add('SELECT ''MOVGER'' AS TABELA, AUTOINCREM AS INCDOC');
      QryIncDoc.SQL.Add('  FROM MOVGER');
      QryIncDoc.SQL.Add('WHERE GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND GER_CODEMP = :CODEMP AND GER_CODCLI = :CODCLI');
      QryIncDoc.SQL.Add('UNION ALL');
      QryIncDoc.SQL.Add('SELECT ''NOTGER'' AS TABELA, AUTOINCREM AS INCDOC');
      QryIncDoc.SQL.Add('  FROM MOVGER');
      QryIncDoc.SQL.Add('WHERE GER_NUMDOC = :NUMDOC AND GER_ESPDOC = :ESPDOC AND GER_CODEMP = :CODEMP AND GER_CODCLI = :CODCLI');

      QryIncDoc.ParamByName('NUMDOC').AsString := strNumDoc;
      QryIncDoc.ParamByName('ESPDOC').AsString := strEspDoc;
      QryIncDoc.ParamByName('CODEMP').AsString := strEmpDoc;
      QryIncDoc.ParamByName('CODCLI').AsString := strCodCli;

      QryIncDoc.Open;
    finally
      strIncDoc := QryIncDoc.FieldByName('INCDOC').AsString;
      strTabela := QryIncDoc.FieldByName('TABELA').AsString;

      FreeAndNil(QryIncDoc);
    end;
  end;
end;

function fReimpressaoTefCitel(intFuncao: Integer;
                              strNumDoc: AnsiString;
                              strDtaTra: TDate;
                              strCodOpe: AnsiString;
                              fltValTra: Double) : IRetornoTEFCitel;
begin
  Result := objTefCitel.fReimpressao(intFuncao, strNumDoc, strDtaTra, strCodOpe, fltValTra);

  if fTefLogImplementado(objTefCitel) then
    TLogTef.pLogaBloco(objTefCitel.pRetornaLog) ;
end;

procedure pSepararViasDoCupom(const ATextoCupom: String; var AConteudoViaCliente, AConteudoViaLojista: String);
  Const
    REIMPRESSAO = '============ REIMPRESSAO =============' ;
  Var
    LViaCliente: Boolean ;
    LLinhasCupom : TStringList;
    LCnt : Integer;
begin
  LViaCliente := True;
  AConteudoViaCliente := EmptyStr;
  AConteudoViaLojista := EmptyStr;

  LLinhasCupom := TStringList.Create;
  Try
    pTextToStringList(ATextoCupom, LLinhasCupom);

    For LCnt := 0 To Pred(LLinhasCupom.Count) Do
    Begin
      If LViaCliente Then
        AConteudoViaCliente := AConteudoViaCliente + LLinhasCupom.Strings[LCnt] + sLineBreak
      Else
        AConteudoViaLojista := AConteudoViaLojista + LLinhasCupom.Strings[LCnt] + sLineBreak;

      If pos(LowerCase(fRetornaSeparador), LowerCase(LLinhasCupom.Strings[LCnt])) > 0 then
        LViaCliente := False;
    End;

    AConteudoViaCliente := REIMPRESSAO + sLineBreak + AConteudoViaCliente + REIMPRESSAO + sLineBreak;
    if not fEmptyStr(AConteudoViaLojista) then
      AConteudoViaLojista := REIMPRESSAO + sLineBreak + AConteudoViaLojista + REIMPRESSAO + sLineBreak;
  Finally
    FreeAndNil(LLinhasCupom);
  End;
end;

procedure pPreparaDadosReimpressaoViaMovTef(const AstrNumDoc: String;
                                            const AdtaDtaCar: TDate;
                                            const AfltValCar: Double;
                                            var AstrConteudoViaCliente, AstrConteudoViaLojista: string) ;
  const
    REIMPRESSAO = '============ REIMPRESSAO =============' ;
  var
    LqryDados: TUniQuery ;
    LblnCliente: Boolean ;
    LblnControle: Boolean ;
begin
  AstrConteudoViaCliente := '' ;
  AstrConteudoViaLojista := '' ;
  LblnCliente := True ;

  LblnControle := fUsaControleScope(AdtaDtaCar, AstrNumDoc) ;

  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add(' SELECT ') ;
    LqryDados.SQL.Add('   MOVTEF.TEF_DESREG ') ;
    LqryDados.SQL.Add(' FROM ') ;
    LqryDados.SQL.Add('   ( SELECT MOVCAR.MCA_NUMDUP, MOVCAR.MCA_CODEMP, MOVCAR.MCA_CODCLI ') ;
    LqryDados.SQL.Add('       FROM MOVCAR ') ;
    LqryDados.SQL.Add('      WHERE MOVCAR.MCA_DTACAD = :DTACAD ') ;
    LqryDados.SQL.Add('        AND ' + ifthen(LblnControle, 'MOVCAR.MCA_CONTRO',  'MOVCAR.MCA_NUMNSU') + ' = :NUMNSU ') ;
    LqryDados.SQL.Add('      GROUP BY MOVCAR.MCA_NUMDUP, MOVCAR.MCA_CODEMP ') ;
    LqryDados.SQL.Add('     HAVING SUM(MOVCAR.MCA_VALSTA) = :VALSTA ') ;
    LqryDados.SQL.Add('   ) AS MOVCAR ') ;
    LqryDados.SQL.Add('   INNER JOIN MOVTEF ON MOVCAR.MCA_NUMDUP = MOVTEF.TEF_DUPCAR ');
    LqryDados.SQL.Add('                    AND MOVCAR.MCA_CODEMP = MOVTEF.TEF_EMPCAR ');
    LqryDados.SQL.Add('                    AND MOVCAR.MCA_CODCLI = MOVTEF.TEF_CLICAR ');
    LqryDados.SQL.Add(' WHERE LEFT(MOVTEF.TEF_CODREG, 3) = "029" ') ;
    LqryDados.SQL.Add(' ORDER BY TEF_CODREG  ') ;
    LqryDados.ParamByName('DTACAD').AsDate := AdtaDtaCar ;
    LqryDados.ParamByName('NUMNSU').AsString := ifthen(LblnControle, AstrNumDoc, fPadL(AstrNumDoc, 14, '0')) ;
    LqryDados.ParamByName('VALSTA').AsFloat := AfltValCar ;
    LqryDados.Open ;
    if LqryDados.IsEmpty then
    begin
      exit ;
    end ;

    LqryDados.First ;
    while not LqryDados.Eof do
    begin
      if SEPARADORBLOCONCR = LqryDados.FieldByName('TEF_DESREG').asString then
      begin
        LblnCliente := False ;
        LqryDados.Next ;
        Continue ;
      end ;

      if LblnCliente then
        AstrConteudoViaCliente := AstrConteudoViaCliente + LqryDados.FieldByName('TEF_DESREG').asString + sLineBreak
      else
        AstrConteudoViaLojista := AstrConteudoViaLojista + LqryDados.FieldByName('TEF_DESREG').asString + sLineBreak ;

      if pos(LowerCase(fRetornaSeparador), LowerCase(LqryDados.FieldByName('TEF_DESREG').asString)) > 0 then
        LblnCliente := False ;

      LqryDados.Next ;
    end ;

    AstrConteudoViaCliente := REIMPRESSAO + sLineBreak + AstrConteudoViaCliente + REIMPRESSAO + sLineBreak ;
    if not fEmptyStr(AstrConteudoViaLojista) then
      AstrConteudoViaLojista := REIMPRESSAO + sLineBreak + AstrConteudoViaLojista + REIMPRESSAO + sLineBreak ;

  finally
    FreeAndNil(LqryDados) ;
  end ;

end ;

procedure pGravaTransacaoCancelada(strNumDoc : String; dtDtaTra : TDate; out strTipOpe, strModali, strSeqCon : String);
  var
    qryTefTra: TUniQuery;
    LblnControle: Boolean ;
begin

  LblnControle := fUsaControleScope(dtDtaTra, strNumDoc) ;

  qryTefTra := fCriaQuery(nil);
  try
    qryTefTra.SQL.Clear;
    qryTefTra.SQL.Add(' SELECT '+
                      '   * '+
                      ' FROM '+
                      '   TEFTRA '+
                      ' WHERE ' + ifthen(LblnControle, 'TFT_CONTRO',  'TFT_NUMNSU') + ' = :NUMNSU '+
                      '   AND TFT_DTATRA = :DATA '+
                      '   AND TFT_CODEMP = :CODEMP '+
                      '   AND TFT_NOMMAQ = :NOMMAQ');
    qryTefTra.ParamByName('NUMNSU').AsString := ifthen(LblnControle, strNumDoc, fPadL(strNumDoc, 14, '0'));
    qryTefTra.ParamByName('DATA').AsDate     := dtDtaTra;
    qryTefTra.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTefTra.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
    qryTefTra.Open;

    if not qryTefTra.IsEmpty then
    begin
      qryTefTra.Edit;
      qryTefTra.FieldByName('TFT_STATUS').AsString := 'ESTORNADA';
      qryTefTra.FieldByName('TFT_COMIMP').AsString := '';

      strTipOpe                                    := qryTefTra.FieldByName('TFT_TIPOPE').AsString;
      strModali                                    := qryTefTra.FieldByName('TFT_MODALI').AsString;
      strSeqCon                                    := qryTefTra.FieldByName('TFT_SEQCON').AsString;
      qryTefTra.Post;


    end;
  finally
    FreeAndNil(qryTefTra);
  end;
end;

function fUsaControleScope(const AdtaData: TDateTime; const AstrControle: String): Boolean ;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT TFT_CONTRO FROM TEFTRA WHERE TFT_CONTRO = :CONTRO AND TFT_DTATRA = :DTATRA ;') ;
    LqryConsulta.ParamByName('CONTRO').AsString := AstrControle ;
    LqryConsulta.ParamByName('DTATRA').AsDate := AdtaData ;
    LqryConsulta.Open ;

    Result := not LqryConsulta.IsEmpty ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;

end ;

function fRetornaDadosBandeiraRedePixScope(out AInfo: TArrayBandeiraRedePixScope; out AMensagemErro: String): Boolean;
var
  LListaInfo: TArrayInfoPix;
  LInfoOut: TInfoBandeiraRedePixScope;
  LInfo: TInfoPix;
  LConteudo: String;
  LMensagemErro: String;
  LRetFunc: Integer;
  LScopeEmpresaFilial: String;
  LScopePdv: String;
  LTefCitel: ITefCitel;
begin
  Result := False;
  SetLength(AInfo, 0);
  if (not Assigned(objTefCitel)) or (fCfgSis('TEFCIT') = OPCAO_CLISITEF) then
  begin
    LScopeEmpresaFilial := fCfgSis('PXCEMP');
    LScopePdv := fCfgSis('PXCPDV');
    LTefCitel := fInstanciaPixTef(LScopeEmpresaFilial, LScopePdv, LMensagemErro);
    if not fEmptyStr(LMensagemErro) then
    begin
      AMensagemErro := LMensagemErro;
      exit;
    end;
  end
  else
    LTefCitel := objTefCitel;

  LRetFunc := LTefCitel.fInfoPixCadastro(LListaInfo);
  if LRetFunc = 0 then
  begin
    for LInfo in LListaInfo do
    begin
      LConteudo := Format('Rede: %s - %s | Band: %s - %s', [LInfo.CodigoRede,
                                                            LInfo.NomeRede,
                                                            LInfo.CodigoBandeira,
                                                            LInfo.NomeBandeira]);

      LInfoOut                := Default(TInfoBandeiraRedePixScope);
      LInfoOut.CodigoRede     := LInfo.CodigoRede;
      LInfoOut.CodigoBandeira := LInfo.CodigoBandeira;
      LInfoOut.CodigoServico  := '0';
      LInfoOut.Descricao      := LConteudo;

      SetLength(AInfo, Length(AInfo)+1);
      AInfo[High(AInfo)]      := LInfoOut;
    end;
  end
  else
  begin
    AMensagemErro := Concat('Não foi possível carregar dados do pix!', sLineBreak,
                            fTryTraduzirErro(LTefCitel, LRetFunc));

    Exit;
  end;

  Result := True;
end;

function fTryTraduzirErro(const ATefCitel: ITefCitel; const AIntCodigoErro: Integer): String;
var
  LTefCitelV2: ITefCitelV2;
begin
  if Supports(ATefCitel, ITefCitelV2, LTefCitelV2) then
    Exit(LTefCitelV2.fTraduzirErro(AIntCodigoErro));

  pGravaLogErro(Format('[fTryTraduzirErro] libTefCitel.dll desatualizada — ' +
                       'fTraduzirErro indisponível. Código: %d', [AIntCodigoErro]));

  Result := Format('Erro[%d]: libTefCitel.dll desatualizada.', [AIntCodigoErro]);
end;

function fBuscaDesTra(strOperacao, strModalidade : String; blnCancelamento : Boolean; strCodigoCarteiraDigital: String) : String;
var
  strEstorno : String;
  LstrDescrCarDig : String;
begin
  strEstorno := '';
  if blnCancelamento then
    strEstorno := 'ESTORNO ';

  if strOperacao = '2' then
    Result := strEstorno + 'DEBITO A VISTA'
  else
  if strOperacao = '3' then
  begin
    if strModalidade = '' then
      Result := strEstorno + 'CREDITO';

    if strModalidade = '1' then
      Result := strEstorno + 'CREDITO A VISTA';

    if strModalidade = '2' then
      Result := strEstorno + 'CREDITO PARC. LOJA';

    if strModalidade = '3' then
      Result := strEstorno + 'CREDITO PARC. ADM';
  end
  else
  if strOperacao = '122' then
  begin
    if fEmptyStr(strCodigoCarteiraDigital) then
    begin
      Result := strEstorno + 'COMPRA PIX';
    end
    else
    begin
      LstrDescrCarDig := fCampoTabela('DIG_DESCRI', 'CARDIG', ['DIG_CARDSE'], [fExtraiCodigoCarteiraDigital(strCodigoCarteiraDigital)]) ;
      Result := strEstorno + 'COMPRA ' + UpperCase(LstrDescrCarDig) ;
    end ;
  end ;
end;

function fTefLogImplementado(const ATefCitel: ITefCitel): Boolean ;
begin
  result := True ;
  try
    ATefCitel.pRetornaLog ;
  except
    on E: Exception do
    begin
      result := False ;
      pGravarErro(True, 'pRetornaLog não implementada, atualizar a LibTefCitel.dll') ;
    end ;
  end ;
end ;

function fPassaCartao(intOperacao,
                       intQtdParc : Integer;
                       strModalidade,
                       strNumDoc : String;
                       fltValor : Double;
                       strRcxCodOpe : String;
                       blnPagueFacil : Boolean = False;
                       strCodigoCarteiraDigital : string = '';
                       AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra = Nil;
                       strJsonInfoAdicPix: String = '';
                       const ATefCitel: ITefCitel = Nil) : IRetornoTefCitel;
var
  LTefCitel: ITefCitel;
begin
  if Assigned(ATefCitel) then
    LTefCitel := ATefCitel
  else
    LTefCitel := objTefCitel;

  { TEFTRA gravada AQUI, no autcom, e nao mais pela DLL (Req. 456190).

    Ate a convergencia para o external ^/libTefCitel, quem gravava a linha da
    TEFTRA durante a transacao nesta linha era a propria DLL: o
    pAtualizaDadosTefTraEmLib preenchia modalidade, operacao, parcelas e
    status e chamava o SucessoTefCartao, que gravava o pendente. O external
    nao tem essa rotina - o Scope nunca chama o SucessoTefCartao, e no modo
    DVC o hook nem viaja. Sem isto a linha so nascia no
    pGravaTransacaoFinalizada, com operacao vazia: TFT_DESTRA, TFT_TIPOPE,
    TFT_MODALI, TFT_QTDPAR, TFT_NUMCCD e os comprovantes em branco, e a
    TRADOC sem vinculo (campo 2026-09-29).

    Mesmo desenho da linha 74.150: INICIADA antes, PENDENTE com retorno,
    CANCELADA sem retorno, e as escolhas de modalidade da tela no meio
    (untTefCitelOperacoes). }
  if Assigned(AobjDadosAdicionaisTefTra) then
  begin
    AobjDadosAdicionaisTefTra.Status(TRANSACAO_INICIADA)
                             .Operacao(intOperacao)
                             .Modalidade(strModalidade)
                             .QtdParcelas(intQtdParc)
                             .Valor(fltValor) ;
    pAtualizaTefTraComDadosAdicionais(AobjDadosAdicionaisTefTra, Nil) ;
  end ;

  LTefCitel.pSetDadosAdicionaisTefTra(AobjDadosAdicionaisTefTra);
  Result := Nil;
  try
    Result := LTefCitel.fPassarCartao(intOperacao,
                                        intQtdParc,
                                        strModalidade,
                                        strNumDoc,
                                        fltValor,
                                        strRcxCodOpe,
                                        blnPagueFacil,
                                        strCodigoCarteiraDigital,
                                        strJsonInfoAdicPix);
  except
    { O TEF levantou excecao: marca a TEFTRA como cancelada em MELHOR ESFORCO
      e repropaga a excecao ORIGINAL. Falha de banco aqui so vai para o log -
      se subisse, trocaria a causa real (canal DVC caido, pinpad) por um erro
      de banco, e e justamente o diagnostico que este caminho precisa
      preservar. Nao e um finally de proposito: no caminho normal, logo
      abaixo, erro de banco TEM de subir - engolir la perderia em silencio a
      TEFTRA de uma transacao aprovada. }
    if Assigned(AobjDadosAdicionaisTefTra) then
      try
        AobjDadosAdicionaisTefTra.PixS_N(IfThen(intOperacao=NCR_OPERACAO_CARTEIRA_DIGITAL_PIX, 'S', 'N')) ;
        AobjDadosAdicionaisTefTra.Status(TRANSACAO_CANCELADA) ;
        pAtualizaTefTraComDadosAdicionais(AobjDadosAdicionaisTefTra, Nil) ;
      except
        on E: Exception do
          try
            pGravaLogErro('[fPassaCartao] TEFTRA nao marcada como cancelada apos falha do TEF - ' +
              E.ClassName + ': ' + E.Message);
          except
            // log e melhor esforco: nunca trocar a excecao do TEF pela dele
          end;
      end;
    raise;
  end ;

  if Assigned(AobjDadosAdicionaisTefTra) then
  begin
    AobjDadosAdicionaisTefTra.PixS_N(IfThen(intOperacao=NCR_OPERACAO_CARTEIRA_DIGITAL_PIX, 'S', 'N')) ;
    if Assigned(Result) then
      AobjDadosAdicionaisTefTra.Status(TRANSACAO_PENDENTE)
    else
      AobjDadosAdicionaisTefTra.Status(TRANSACAO_CANCELADA) ;
    pAtualizaTefTraComDadosAdicionais(AobjDadosAdicionaisTefTra, Result) ;
  end ;

  if fTefLogImplementado(LTefCitel) then
    TLogTef.pLogaBloco(LTefCitel.pRetornaLog) ;

end;

procedure pAtualizaTefTraComDadosAdicionais(const AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra;
  const ADadosTransacao: IRetornoTEFCitel) ;
var
  LstrData, LstrHora: String ;
  LstrNsu: String ;
  LstrComprovantes: String ;
  LstrCodigoCarteiraDigital: String ;
  LstrControle: String ;
  LstrAutorizacao: String ;
  LarrDocs: TArrayInfoTraDoc ;
  LstrNumDoc, LstrPix, LstrOpeRcx, LstrOpcDoc, LstrModalidade, LstrStatus: String ;
  LfltValor: Double ;
  LintQtdParc, LintOperacao: Integer ;
  LdtaAgora: TDateTime ;
begin
  if not Assigned(AobjDadosAdicionaisTefTra) then
    Exit ;

  { Lidos para variaveis, e nao passados direto na chamada, como faz o
    pSucessoTefCartaoEvent: os getters do IDadosAdicionaisTefTra sao
    sobrecarregados com os setters. }
  LstrNumDoc     := AobjDadosAdicionaisTefTra.NumDoc ;
  LstrPix        := AobjDadosAdicionaisTefTra.PixS_N ;
  LstrOpeRcx     := AobjDadosAdicionaisTefTra.OpeRcx ;
  LstrOpcDoc     := AobjDadosAdicionaisTefTra.OpcDoc ;
  LfltValor      := AobjDadosAdicionaisTefTra.Valor ;
  LintQtdParc    := AobjDadosAdicionaisTefTra.QtdParcelas ;
  LstrModalidade := AobjDadosAdicionaisTefTra.Modalidade ;
  LintOperacao   := AobjDadosAdicionaisTefTra.Operacao ;
  LstrStatus     := AobjDadosAdicionaisTefTra.Status ;

  LdtaAgora := fNow ;
  LstrData := FormatDateTime('YYYYMMDD', LdtaAgora) ;
  LstrHora := FormatDateTime('HHMMSS', LdtaAgora) ;
  LstrNsu := '' ;
  LstrComprovantes := '' ;
  LstrCodigoCarteiraDigital := '' ;
  LstrControle := '' ;
  LstrAutorizacao := '' ;
  LarrDocs := Nil ;

  if Assigned(ADadosTransacao) then
  begin
    if Length(ADadosTransacao.DadosCartao.strDataHoraTrans) >= 14 then
    begin
      LstrData := Copy(ADadosTransacao.DadosCartao.strDataHoraTrans, 1, 8) ;
      LstrHora := Copy(ADadosTransacao.DadosCartao.strDataHoraTrans, 9, 6) ;
    end ;
    LstrNsu := ADadosTransacao.DadosCartao.strNSU ;
    LstrComprovantes := Trim(ADadosTransacao.DadosCartao.strConteudoViaCliente + sLineBreak +
                             ADadosTransacao.DadosCartao.strConteudoViaLojista) ;
    LstrCodigoCarteiraDigital := ADadosTransacao.DadosCartao.strCodigoCarteiraDigital ;
    LstrControle := ADadosTransacao.DadosCartao.strControle ;
    LstrAutorizacao := ADadosTransacao.DadosCartao.strAutorizacao ;

    { TRADOC so aqui, na gravacao com retorno. pGravaDocumentosTefTra insere
      sem conferir se o vinculo ja existe, e esta rotina roda de 3 a 4 vezes
      por transacao - nas outras vezes os vinculos sairiam repetidos.
      Transacao cancelada nao tem vinculo. E o mesmo momento em que o fluxo
      antigo desta linha gravava. }
    LarrDocs := AobjDadosAdicionaisTefTra.ArrDocs ;
  end ;

  pGravaTransacaoPendente(LstrNumDoc,
                          fPadL(LstrNsu, 14, '0'),
                          LstrData,
                          LstrHora,
                          LstrPix,
                          LstrOpeRcx,
                          LstrOpcDoc,
                          LfltValor,
                          LstrComprovantes,
                          LintQtdParc,
                          LstrModalidade,
                          LstrAutorizacao,
                          IntToStr(LintOperacao),
                          LstrCodigoCarteiraDigital,
                          LstrControle,
                          LarrDocs,
                          LstrStatus);
end;

function fVerificaMsgTefCitel(const AStrMsg: String): Boolean;
var
  I : Integer;
begin
  Result := False;
  for I := Low(arrMsg) to High(arrMsg) do
  begin
    if arrMsg[i] = AStrMsg then
      Exit(True);
  end;
end;

function fTraduzErrosConexao(intResult : Integer) : String;
begin
  case intResult of
    1:  fMensagem('ATENÇÃO!', strMsgIpInvalido, ['&Ok']);
    2:  fMensagem('ATENÇÃO!', strMsgCodLojaIpInvalido, ['&Ok']);
    3:  fMensagem('ATENÇÃO!', strMsgCodTermInvalido, ['&Ok']);
    6:  fMensagem('ATENÇÃO!', strMsgErroIniTcp, ['&Ok']);
    7:  fMensagem('ATENÇÃO!', strMsgMemoria, ['&Ok']);
    8:  fMensagem('ATENÇÃO!', strMsgNaoEncontrouCliSit, ['&Ok']);
    9:  fMensagem('ATENÇÃO!', strMsgConfServExcedida, ['&Ok']);
    10: fMensagem('ATENÇÃO!', strMsgErroAcessoPasta, ['&Ok']);
    11: fMensagem('ATENÇÃO!', strMsgDadosInvalidos, ['&Ok']);
    12: fMensagem('ATENÇÃO!', strMsgModoSeguro, ['&Ok']);
    13: fMensagem('ATENÇÃO!', strMsgCaminhoDllInvalido, ['&Ok']);
  end;

end;

procedure pMontaConteudoCupom(strConteudo, strRede, strBandeira, strEstabeleci: String; var stlConteudo : TStringList);
var
  strAux, strLinha: String;
  i, tamanho, intCod: Integer;
const
  lineBreakA = #$A;
  lineBreakD = #$D;
  strCodLin = '029';
begin
  stlConteudo.Add('010' +'-'+ '000' +'='+strBandeira);
  stlConteudo.Add('010' +'-'+ '001' +'='+strRede);

  tamanho := Length(strConteudo);
  strLinha := '';
  intCod := 1;
  for i := 1 to tamanho do
  begin
    strAux := Copy(strConteudo,i,1);
    if fVerificaQuebraLinha(strAux) then
    begin
      if trim(strLinha) <> '' then
      begin
        stlConteudo.Add(strCodLin +'-'+ fStrZero(IntToStr(intCod), 3)+'='+strLinha);
        strLinha := '';
        Inc(intCod);
      end;
    end
    else
      strLinha := strLinha + strAux;
  end;

  if not strEstabeleci.IsEmpty then
    stlConteudo.Add('150' +'-'+ '000' +'='+strEstabeleci);
end;

procedure pImprimirCliente(strViaCli, strViaLoj : String; const AblnQtdViasExterna: Boolean = False);
begin
  if not fEmptyStr(strViaCli) then
    pImprimirTef(strViaCli, '', AblnQtdViasExterna)
  else
    pImprimirTef(strViaLoj, '', AblnQtdViasExterna);
end;

procedure pImprimirLojista(strViaCli, strViaLoj : String; const AblnQtdViasExterna: Boolean = False);
begin
  if not fEmptyStr(strViaLoj) then
    pImprimirTef(strViaLoj, '', AblnQtdViasExterna)
  else
    pImprimirTef(strViaCli, '', AblnQtdViasExterna);
end;

procedure pInfo34(fltValTra : Double);
begin
  objTefCitel.pInfo34(fltValTra);
end;

procedure pInfo21(strModalidade : String);
begin
  objTefCitel.pInfo21(strModalidade);
end;

procedure pInfo30(strNumDoc : String; dtaData : TDate; intQtdParc : Integer);
begin
  objTefCitel.pInfo30(strNumDoc,dtaData,intQtdParc);
end;

procedure pInfo30DebitoPreDatado(const AdtaDataPre: TDate) ;
begin
  objTefCitel.pInfo30DebitoPreDatado(AdtaDataPre);
end ;

procedure pInfo30DebitoCredito1Minuto(const AintParcelaCdc: Integer) ;
begin
  objTefCitel.pInfo30DebitoCredito1Minuto(AintParcelaCdc);
end ;

procedure pInfo30DebitoParcelado(const AintQtdParc, AintIntervaloParc, AintPrimParcAvista: Integer; const AdtaPrimParcela: TDate) ;
begin
  objTefCitel.pInfo30DebitoParcelado(AintQtdParc, AintIntervaloParc, AintPrimParcAvista, AdtaPrimParcela) ;
end ;

function fObtemDadoPinPadDireto(AintTipoDocumento: Integer): String;
var
  LstrRetorno: AnsiString ;
  LstrIdentificador: AnsiString ;
  LstrChaveAcesso: AnsiString ;
begin
  LstrIdentificador := AnsiString(fCfgSis('PINIDE')) ;
  LstrChaveAcesso := AnsiString(fCfgSis('PINCHA')) ;

  LstrRetorno := objTefCitel.fObtemDadoPinPadDireto(AintTipoDocumento,
                                                    LstrChaveAcesso,
                                                    LstrIdentificador) ;
  result := String(LstrRetorno) ;
end ;

function fVerificaQuebraLinha(strCaracter : String) : Boolean;
const
  lineBreakA = #$A;
  lineBreakD = #$D;
begin
  Result := False;

  if strCaracter = lineBreakA then
    Result := True;

  if strCaracter = lineBreakD then
    Result := True;
end;

function fPassaCartaoPagueFacil(strTipoCartao : String;
                                var intQtdParcelas,
                                intOperacao : Integer;
                                fltValor : Double;
                                strNumDoc,
                                strCodOpe : String;
                                var strModalidade : String;
                                AobjDadosAdicionaisTefTra: IDadosAdicionaisTefTra) : IRetornoTEFCitel;
const
  carCredito = 3;
  creditoAVista = '1';
  creditoParcelado = '2';

  carDebito = 2;
  debitoAVista = '1';
begin
  if strTipoCartao = 'C' then
    intOperacao := carCredito
  else
    intOperacao := carDebito;

  case intOperacao of
    carCredito :
    begin
      if intQtdParcelas > 1 then
        strModalidade := creditoParcelado
      else
        strModalidade := creditoAVista;
    end;
    carDebito : strModalidade := debitoAVista;
  end;

  Result := fPassaCartao(intOperacao,
                         intQtdParcelas,
                         strModalidade,
                         strNumDoc,
                         fltValor,
                         strCodOpe,
                         True,
                         '',
                         AobjDadosAdicionaisTefTra);
end;

function fMostrarOpcaoPix: Boolean ;
var
  LstrOpcaoTEF: string;
begin
  Result := True ;

  // desabilita apenas na operação Tef
  if fCfgSis('PIXSCP', varString) = 'S' then
    Exit(False);

  LstrOpcaoTEF := fCfgSis('TEFCIT', varString);

  if LstrOpcaoTEF = OPCAO_NCR then
  begin
    if fCfgSis('PXTFSC', varString) = 'S' then
      Exit ;
  end;

  if LstrOpcaoTEF = OPCAO_CLISITEF then
  begin
    if fCfgSis('PXTFSI', varString) = 'S' then
      Exit;
  end;

  Result := False ;
end ;

function fDataDebitoPreDatadoScope: TDateTime ;
var
  LstrDias: String ;
  LintDias: Integer ;
  LdtaAux: TDateTime ;
  LFeriadoOuFDS: TFeriadoFimDeSemana ;
begin
  Result := IncDay(VS_Date, 7) ;

  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
  begin
    LstrDias := fCfgSis('TEFDPP', varString) ;
    if fEmptyStr(LstrDias) then
      Exit ;

    LintDias := StrToInt(LstrDias) ;

    LdtaAux := IncDay(VS_Date, LintDias) ;
    LFeriadoOuFDS := fBuscaProxDiaUtil(LdtaAux, '') ;

    Result := LFeriadoOuFDS.dtaProximoDiaUtil ;
  end ;

end ;

function fVerificaMsgInsereCartao(msgPanelTef : String): Boolean;
begin
  Result := False;

  if (Pos('INSIRA OU PASSE', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('PASSE OU INSIRA', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('INSIRA OU APROXIME', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('APROXIME OU INSIRA', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('PASSE OU APROXIME', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('APROXIME OU PASSE', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('INSIRA O CARTAO', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('APROXIME O CARTAO', UpperCase(msgPanelTef)) > 0) then
    Result := True;

  if (Pos('PASSE O CARTAO', UpperCase(msgPanelTef)) > 0) then
    Result := True;
end;

function fRetornaCarteiraDigital(
  const AstrNumNsu: String; const AdtaDtaMca: TDate;
  const AfltValor: double): string;
var
  LqryVerifica: TUniQuery ;
  LblnControle: Boolean ;
begin

  LblnControle := fUsaControleScope(AdtaDtaMca, AstrNumNsu) ;

  LqryVerifica := fCriaQuery() ;
  try
    LqryVerifica.SQL.Clear ;
    LqryVerifica.SQL.Add(' SELECT MCA_CARDIG ') ;
    LqryVerifica.SQL.Add(' FROM MOVCAR ') ;
    LqryVerifica.SQL.Add(' WHERE MCA_DTACAD = :DTACAD ') ;
    LqryVerifica.SQL.Add('       AND MCA_VALSTA = :VALSTA ') ;
    LqryVerifica.SQL.Add('       AND ' + ifthen(LblnControle, 'MCA_CONTRO',  'MCA_NUMNSU') + ' = :NUMNSU ') ;
    LqryVerifica.SQL.Add('       AND MCA_CODEMP = :CODEMP ') ;
    LqryVerifica.ParamByName('DTACAD').AsDate := AdtaDtaMca ;
    LqryVerifica.ParamByName('NUMNSU').AsString := ifthen(LblnControle, AstrNumNsu, fPadL(AstrNumNsu, 14, '0')) ;
    LqryVerifica.ParamByName('VALSTA').AsFloat := AfltValor ;
    LqryVerifica.ParamByName('CODEMP').AsString := VS_strCodEmp  ;
    LqryVerifica.Open ;

    result := LqryVerifica.FieldByName('MCA_CARDIG').AsString ;

  finally
    FreeAndNil(LqryVerifica) ;
  end ;
end;

procedure pPreparaDadosReimpressaoViaTefTra(const AstrAutoInc: String;
                                            var AConteudoViaCliente, AConteudoViaLojista, AMensagem: string);
Var
  LTefTra : TUniQuery;
  LStatus: string;
  LComprovante: String;
begin
  AConteudoViaCliente := EmptyStr;
  AConteudoViaLojista := EmptyStr;
  AMensagem := EmptyStr;

  LTefTra := fCriaQuery();
  Try
    LTefTra.Close;
    LTefTra.SQL.Clear;
    LTefTra.SQL.Add(' SELECT TFT_COMIMP, TFT_COMAUX, TFT_CONTRO, TFT_DTATRA, TFT_STATUS');
    LTefTra.SQL.Add('  FROM TEFTRA ');
    LTefTra.SQL.Add('  WHERE AUTOINCREM = :AUTOINCREM ');
    LTefTra.ParamByName('AUTOINCREM').AsString := AstrAutoInc;
    LTefTra.Open;

    If LTefTra.IsEmpty Then
    begin
      AMensagem := 'Comprovante não encontrado!';
      Exit;
    end;


    LComprovante := LTefTra.FieldByName('TFT_COMIMP').AsString;
    LStatus := LTefTra.FieldByName('TFT_STATUS').AsString.ToUpper;

    if fEmptyStr(LComprovante) and
       (LStatus = 'PENDENTE')
    then
      LComprovante := LTefTra.FieldByName('TFT_COMAUX').AsString;

    if fEmptyStr(LComprovante) then
    begin
      AMensagem := 'Não foi possível recuperar dados do comprovante!';
      Exit;
    end;

    pSepararViasDoCupom(LComprovante, AConteudoViaCliente, AConteudoViaLojista);
  Finally
    FreeAndNil(LTefTra);
  End;
end;

function fObterAutoIncrTransacao(const ANSU, ACodRede: string; const AData: TDate; const AValTrn: Double): string;
var
  LSQL: string;
  LQry: TUniQuery;
begin
  LSQL := ' SELECT '            +
          ' TEFTRA.AUTOINCREM ' +
          ' FROM TEFTRA '       +
          ' WHERE TFT_NUMNSU = :NUMNSU ' +
          ' AND TFT_DTATRA   = :DTATRA ' +
          ' AND (TFT_CODRED  = :CODRED OR NULLIF(TRIM(TFT_CODRED),'''') IS NULL) ' +
          ' AND TFT_VALTRA   = :VALTRA ';

  LQry := fCriarQuery(LSQL, nil);
  try
    LQry.ParamByName('DTATRA').AsDateTime := AData;
    LQry.ParamByName('NUMNSU').AsString   := ANSU;
    LQry.ParamByName('CODRED').AsString   := ACodRede;
    LQry.ParamByName('VALTRA').AsFloat    := AValTrn;
    LQry.Open;
    Result := LQry.FieldByName('AUTOINCREM').AsString;
  finally
    FreeAndNil(LQry);
  end;

end;

function fRetornaInfoContaPix(const AItemPix: TInfoBandeiraRedePixScope): String;
const
  BASE_TEXTO = 'SCOPE:%s:%s:%s';
begin
  Result := Format(BASE_TEXTO, [AItemPix.CodigoBandeira,
                                AItemPix.CodigoRede,
                                AItemPix.CodigoServico]);
end;

function fGerarQrCodeImagemPinPad(const ATexto: String;
                                    const AValor: String;
                                          AOwner: TWinControl;
                                    var   APathDiretorio, ANomeArquivo: String): Boolean ;
var
  LpnlCodigoBarras: TPanel ;
  LpnlValor: TPanel ;
  LCodigoBarras: TdxBarCode ;
  //
  LPngImage: TdxPNGImage;
  LBitmap: TcxBitmap;
  LstrPathImagem: String ;
begin
  if not Assigned(AOwner) then
  begin
    Result := False;
    Exit;
  end;

  APathDiretorio := ExtractFileDir(TPath.GetTempFileName);

  if not EndsStr('\', APathDiretorio) then
    APathDiretorio := APathDiretorio + '\' ;

  ANomeArquivo := ExtractFileName(TPath.GetTempFileName) ;
  ANomeArquivo := ReplaceStr(ANomeArquivo, ExtractFileExt(ANomeArquivo), '.png') ;

  LstrPathImagem := APathDiretorio + ANomeArquivo ;

  LpnlCodigoBarras := Nil ;
  LpnlValor := Nil ;
  LCodigoBarras := Nil;
  try
    LpnlCodigoBarras := TPanel.Create(AOwner) ;
    LpnlValor := TPanel.Create(LpnlCodigoBarras) ;
    LCodigoBarras := TdxBarCode.Create(LpnlCodigoBarras);

    LpnlCodigoBarras.Parent := AOwner ;
    LpnlValor.Parent := LpnlCodigoBarras ;
    LpnlCodigoBarras.Left   := 82 ;
    LpnlCodigoBarras.Top    := 178 ;
    LpnlCodigoBarras.Width  := 220 ;
    LpnlCodigoBarras.Height := 220 ;
    LpnlCodigoBarras.BorderStyle := bsSingle ;
    LpnlCodigoBarras.Visible := False ;

    LpnlValor.Left          := 1 ;
    LpnlValor.Top           := 1 ;
    LpnlValor.Width         := 218 ;
    LpnlValor.Height        := 24 ;
    LpnlValor.Align         := alTop ;
    LpnlValor.BevelOuter    := bvNone ;
    LpnlValor.Caption       := AValor ;
    LpnlValor.Font.Style    := [fsBold] ;
    LpnlValor.ParentFont    := False ;


    LCodigoBarras.Parent := LpnlCodigoBarras ;
    LCodigoBarras.Left := 1 ;
    LCodigoBarras.Top := 25 ;
    LCodigoBarras.Align := alClient ;
    LCodigoBarras.Text := ATexto ;
    LCodigoBarras.Properties.BarCodeSymbologyClassName := 'TdxBarCodeQRCodeSymbology' ;
    LCodigoBarras.Properties.FitMode := ifmProportionalStretch ;
    LCodigoBarras.Properties.ShowText := False ;
    LCodigoBarras.Transparent := False ;
    Application.ProcessMessages ;

    LBitmap := TcxBitmap.Create;
    try

      LBitmap.SetSize(LpnlCodigoBarras.BoundsRect);
       LpnlCodigoBarras.Visible := True ;
      try
        cxPaintToBitmap(LpnlCodigoBarras, LBitmap);
      finally
         LpnlCodigoBarras.Visible := False ;
      end ;

      LPngImage := TdxPNGImage.CreateFromBitmap(LBitmap);
      try
        LPngImage.SaveToFile(LstrPathImagem);
      finally
        LPngImage.Free;
      end ;

    finally
      FreeAndNil(LBitmap) ;
    end ;

  finally
    FreeAndNil(LpnlValor) ;
    FreeAndNil(LCodigoBarras) ;
    FreeAndNil(LpnlCodigoBarras) ;
  end ;

  Result := True ;
end;

function fAutoConfirmaTransacaoPendenteEstaAtivada: Boolean;
begin
  Result := False;
  if fCfgSis('PENCNF', varString) = 'S' then
    Result := True;
end;

function fAutoConfirmarTransacaoTef(
  const AItemCartao: TCartoesResumoCaixa): Boolean;
var
  LblnComita: Boolean;
  LblnSeraReenviada: Boolean;
  LblnNaoConfirmada: Boolean;
begin
  Result := False;

  if not VS_blnTefCitel then
    Exit;

  if (AItemCartao.strTipCar = 'POS') then
    Exit;

  LblnComita := False;
  LblnNaoConfirmada := False;
  If (Not fInTransaction) Then
  Begin
    fStartTransaction;
    LblnComita := True;
  End;

  try
    pFinalizaTranscacao(True, AItemCartao.strDtaTra,
      AItemCartao.strHraTra, AItemCartao.strNumDoc, '');
    { Req. 470363 - confirmacao que nao chegou a estacao (canal caiu, ou o
      servico reiniciou) CONTINUA contando como autoconfirmada: devolver
      False aqui leva o Resumo de Caixa (PENCNF) a ESTORNAR o cartao logo
      depois de gravar o recebimento (medido em 16/10). Na queda, a DLL
      reenvia a confirmacao antes da proxima operacao; no reinicio do
      servico nao ha o que reenviar, e o operador e avisado depois do commit. }
    LblnNaoConfirmada := fFinalizacaoTefNaoRealizada(LblnSeraReenviada);
    if LblnNaoConfirmada and LblnSeraReenviada then
      pDescreveFinalizacaoTef('R$ ' + FormatFloat('#,##0.00', AItemCartao.fltValDig) +
                              ' (Controle ' + AItemCartao.strControle + ')');
    Result := True;
    pGravaTransacaoFinalizada(AItemCartao.strNumDoc,
                              fPadL(AItemCartao.strNumNsu, 14, '0'),
                              AItemCartao.strDtaTra,
                              AItemCartao.strHraTra,
                              EmptyStr,
                              EmptyStr,
                              AItemCartao.fltValDig,
                              AItemCartao.strViaCli +#13+ AItemCartao.strViaLoj,
                              EmptyStr,
                              AItemCartao.strControle);
    If LblnComita Then
      fCommit;
  except
    On E: Exception Do
    Begin
      If LblnComita Then
        fRollBack;

      pGravarErro(True,
        Format('Falha ao autoconfirmar TEF (NumDoc=%s NSU=%s Valor=%.2f): %s',
          [AItemCartao.strNumDoc, AItemCartao.strNumNsu,
           AItemCartao.fltValDig, E.Message]),
        '[fAutoConfirmarTransacaoTef]');
    End;
  end;

  { Depois do commit: o modal nao segura a transacao do banco aberta. }
  if LblnNaoConfirmada and (not LblnSeraReenviada) then
    fMensagem('ATENÇÃO!',
      'A confirmação do cartão de R$ ' + FormatFloat('#,##0.00', AItemCartao.fltValDig) +
      ' (Controle ' + AItemCartao.strControle + ') não chegou ao TEF da estação ' +
      '(o serviço de TEF foi reiniciado) e ficou PENDENTE no TEF.',
      ['&Ok'], 1);
end;

procedure pAtualizaDadosFaturamentoTef(
    const AIncDoc, ATabela, ASeqCon, AViaCli, AViaLoj: String;
    const ANumDoc, ADtaTra: String);
var
  LTefTra: TUniQuery;
  LTransacaoLocal: Boolean;
begin
  LTransacaoLocal := False;
  fImpCupom(AViaCli, AViaLoj);

  If (Not fInTransaction) Then
  Begin
    fStartTransaction;
    LTransacaoLocal := True;
  End;

  try
    LTefTra := fCriaQuery(nil);
    Try
      LTefTra.SQL.Clear;
      LTefTra.SQL.Add(' SELECT * ');
      LTefTra.SQL.Add('   FROM TEFTRA ');
      LTefTra.SQL.Add('  WHERE TFT_NUMDOC = :NUMDOC ');
      LTefTra.SQL.Add('    AND TFT_DTATRA = :DATA ');
      LTefTra.SQL.Add('    AND TFT_CODEMP = :CODEMP ');
      LTefTra.SQL.Add('    AND TFT_NOMMAQ = :NOMMAQ ');
      LTefTra.ParamByName('NUMDOC').AsString := ANumDoc;
      LTefTra.ParamByName('DATA').AsString   := ADtaTra;
      LTefTra.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LTefTra.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
      LTefTra.Open;

      if not LTefTra.IsEmpty then
      begin
        LTefTra.Edit;
        LTefTra.FieldByName('TFT_INCDOC').AsString := AIncDoc;
        LTefTra.FieldByName('TFT_TABELA').AsString := ATabela;
        LTefTra.FieldByName('TFT_SEQCON').AsString := ASeqCon;
        LTefTra.FieldByName('TFT_STATUS').AsString := 'EFETUADA PDV';
        LTefTra.Post;
      end;

      If LTransacaoLocal Then
        fCommit;

    Finally
      FreeAndNil(LTefTra);
    End;
  Except
    On E: Exception Do
    Begin
      If LTransacaoLocal Then
        fRollBack;
      pMensagensErro(E.Message, '[pAtualizaDadosFaturamentoTef]');
    End;
  End;

end;

function fRetornaBandeiraPorCodigoSugestao(const ACodigo: string): string;
var
  LConsulta: TUniQuery;
begin
  Result := EmptyStr;
  LConsulta := fCriaQuery(nil);
  try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add(' SELECT SUG_NOMBAN FROM BANSUG');
    LConsulta.SQL.Add(' WHERE SUG_CODBAN = :CODBAN AND SUG_FORTEF = :FORTEF');
    LConsulta.ParamByName('CODBAN').AsString := ACodigo;
    LConsulta.ParamByName('FORTEF').AsString := fCfgSis('TEFCIT', varString);
    LConsulta.Open;
    if not LConsulta.IsEmpty then
      Result := LConsulta.FieldByName('SUG_NOMBAN').AsString;
  finally
    FreeAndNil(LConsulta);
  end;
end;

function fAjustaIdentificadorEstornoTef(const AItem: TCartoesResumoCaixa): string;
begin
  Result := '';
  if fCfgSis('TEFCIT', varString) = OPCAO_NCR then
  begin
    Result := AItem.strControle;
  end
  else
  begin
    Result := IntToStr(StrToInt64Def(Trim(AItem.strNumNsu), 0)) ;
  end;
end;

procedure pMostraArquivosVerificacaoScope ;
begin
  fMensagem('ATENÇÃO!', 'Verificar o arquivo libTefCitelErro.log na pasta do Autcom e atualizar o pacote de arquivos do TEF parametrizado na CFG_TEFCIT!', ['&Ok']);
end ;

function fVerificaCnpjScope(const AstrCnpjEmpresa, AstrNumLoj, AstrPathTef: String; var AstrMsgErro: String): Boolean ;
var
  LstrTefCit: String ;
  LobjConsulta: TConsultaDadosScopeEnvio ;
  LstrCodigoEmpresa, LstrCodigoFilial: String ;
begin
  result := True ;

  LstrTefCit := fCfgSis('TEFCIT', varString) ;
  if LstrTefCit <> OPCAO_NCR then
    Exit ;

  if fEmptyStr(AstrNumLoj) then
    Exit ;

  LstrCodigoEmpresa := copy(AstrNumLoj, 1, 4) ;
  LstrCodigoFilial := copy(AstrNumLoj, 5, 4) ;

  LobjConsulta := TConsultaDadosScopeEnvio.Create ;
  try
    Result := LobjConsulta.fEmpresaAtiva(AstrCnpjEmpresa, LstrCodigoEmpresa, LstrCodigoFilial, AstrPathTef, AstrMsgErro) ;
  finally
    FreeAndNil(LobjConsulta) ;
  end ;

end ;

function fRetornaSeparador: String ;
var
  LstrTefCit: String ;
begin
  result := SEPARADORBLOCOCLISI ;
  LstrTefCit := fCfgSis('TEFCIT', varString) ;
  if LstrTefCit = OPCAO_NCR then
    result := SEPARADORBLOCONCR ;
end ;

procedure pGravaTransacaoErro(const AstrNumDoc: String; const AfltValor: Double) ;
var
  LstrData, LstrHora: String ;
begin
  LstrData  := FormatDateTime('YYYYMMDD', fNow);
  LstrHora  := FormatDateTime('HHMMSS', fNow);

  pGravaTransacaoCliSiTef(AstrNumDoc,
                          fRetAutoIncrem('TEFTRA', VS_strCodEmp),
                          '',
                          LstrData,
                          LstrHora,
                          '',
                          '',
                          '',
                          AfltValor,
                          false,
                          false,
                          false,
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          0,
                          '',
                          '',
                          'ERRO CONEXÃO');
end ;

function fExibeMenuAdmTef: Boolean;
begin
  Result := False;

  if fCfgSis('TEFCIT') <> OPCAO_NCR then
    Exit;

  if fCfgSis('RLTFHB') <> 'S'  then
    Exit;

  Result := True;
end;

function fTrataTefCitTerminal: String ;
var
  LstrTefCit: String ;
begin
  Result := 'S' ;
  LstrTefCit := fCfgSis('TEFCIT', varString) ;
  if LstrTefCit = OPCAO_NCR then
    Result := LstrTefCit
  else if LstrTefCit = OPCAO_CLISITEF then
    Result := LstrTefCit ;
end ;

{ TImplEventosTefCitel }

class function TImplEventosTefCitel.fAntesReimpressaoEvent: Boolean;
begin
  Result := True ;
  if not fLockUnlockTefCitel(True) then
  begin
    Result := False;
    fMensagem('', 'Concluir o recebimento pelo TEF ' + #13 +
                  'da outra sessão do Autcom antes de iniciar esta. ' + #13 +
                  fGetHostLock(fRetornaChaveLockTefCitel) + '!', ['&Ok']);
    exit ;
  end ;
end;

class procedure TImplEventosTefCitel.pDepoisCancelarTransacaoEvent(
  AobjRetorno: IRetornoTEFCitel);
begin
  fLockUnlockTefCitel(False) ;
end;

class procedure TImplEventosTefCitel.pDepoisFinalizarTransacaoEvent;
begin
  fLockUnlockTefCitel(False) ;
end;

class procedure TImplEventosTefCitel.pDepoisPassarCartaoEvent(
  AobjRetorno: IRetornoTEFCitel);
begin
  if not Assigned(AobjRetorno) then
  begin
    fLockUnlockTefCitel(False) ;
  end ;
end;

class function TImplEventosTefCitel.fAntesCancelarTransacaoEvent: Boolean;
begin
  Result := True ;
  if not fLockUnlockTefCitel(True) then
  begin
    Result := False;
    fMensagem('', 'Concluir o recebimento pelo TEF ' + #13 +
                  'da outra sessão do Autcom antes de iniciar esta. ' + #13 +
                  fGetHostLock(fRetornaChaveLockTefCitel) + '!', ['&Ok']);
    exit ;
  end ;
end;

class procedure TImplEventosTefCitel.pDepoisReimpressaoEvent(
  AobjRetorno: IRetornoTEFCitel);
begin
  fLockUnlockTefCitel(False) ;
end;

class procedure TImplEventosTefCitel.pGravarErroTef(
  const AblnGravarErro: Boolean; AstrMensagemErro, AstrRelatorio,
  AstrUltSQL: String);
begin
  pGravarErro(AblnGravarErro, AstrMensagemErro, AstrRelatorio, AstrUltSQL, nil) ;
end;

class procedure TImplEventosTefCitel.pSucessoTefCartaoEvent(
  var ADadosTransacao: IRetornoTEFCitel);
var
  LstrData, LstrHora: String ;
  LstrOpeRcx: String ;
  LstrPix: String ;
  LstrOpcDoc: String ;
  LarrDocs: TArrayInfoTraDoc ;
  LintQtdParc: Integer ;
  LstrNumDoc: String ;
  LfltValDig: Double ;
  LstrModalidade: String ;
  LintOperacao: Integer ;
  LstrStatus: String ;
begin
  if not Assigned(ADadosTransacao) then
  begin
    Raise Exception.Create('Problemas ao receber dados para gerar a TEFTRA.' + #13+#10+
                           'Favor entrar em contato com a Citel!');
  end ;

  // no processo de estorno o processo de gerar a TEFTRA não foi alterado
  if not Assigned(ADadosTransacao.DadosAdicionaisTefTra) then
    Exit ;

  LstrData       := copy(ADadosTransacao.DadosCartao.strDataHoraTrans,1,8);
  LstrHora       := copy(ADadosTransacao.DadosCartao.strDataHoraTrans,9,6);
  LstrOpeRcx     := ADadosTransacao.DadosAdicionaisTefTra.OpeRcx ;
  LstrPix        := ADadosTransacao.DadosAdicionaisTefTra.PixS_N ;
  LstrOpcDoc     := ADadosTransacao.DadosAdicionaisTefTra.OpcDoc ;
  LarrDocs       := ADadosTransacao.DadosAdicionaisTefTra.ArrDocs ;
  LintQtdParc    := ADadosTransacao.DadosAdicionaisTefTra.QtdParcelas ;
  LstrNumDoc     := ADadosTransacao.DadosAdicionaisTefTra.NumDoc ;
  LfltValDig     := ADadosTransacao.DadosAdicionaisTefTra.Valor ;
  LstrModalidade := ADadosTransacao.DadosAdicionaisTefTra.Modalidade ;
  LintOperacao   := ADadosTransacao.DadosAdicionaisTefTra.Operacao ;
  LstrStatus     := ADadosTransacao.DadosAdicionaisTefTra.Status ;

  pGravaTransacaoPendente(LstrNumDoc,
                          fPadL(ADadosTransacao.DadosCartao.strNSU, 14, '0'),
                          LstrData,
                          LstrHora,
                          LstrPix,
                          LstrOpeRcx,
                          LstrOpcDoc,
                          LfltValDig,
                          trim(ADadosTransacao.DadosCartao.strConteudoViaCliente + sLineBreak + ADadosTransacao.DadosCartao.strConteudoViaLojista),
                          LintQtdParc,
                          LstrModalidade,
                          ADadosTransacao.DadosCartao.strAutorizacao,
                          LintOperacao.ToString,
                          ADadosTransacao.DadosCartao.strCodigoCarteiraDigital,
                          ADadosTransacao.DadosCartao.strControle,
                          LarrDocs,
                          LstrStatus);


end;

class function TImplEventosTefCitel.fAntesPassarCartaoEvent: Boolean;
begin
  Result := True ;
  if not fLockUnlockTefCitel(True) then
  begin
    Result := False;
    fMensagem('', 'Concluir o recebimento pelo TEF ' + #13 +
                  'da outra sessão do Autcom antes de iniciar esta. ' + #13 +
                  fGetHostLock(fRetornaChaveLockTefCitel) + '!', ['&Ok']);
    exit ;
  end ;
end;

function fTipoViasImpressaoTef: string;
var
  LintRetorno: Integer;
begin
  Result := '';

  if (not fInTransaction) and (fCfgSisL('PIMPTF') = 'S') then
  begin
    LintRetorno := fMensagem('ATENÇÃO!', 'Deseja imprimir o comprovante da transação de cartão?',
      ['&1-Lojista', '&2-Cliente', '&3-Ambas', '&F-Fechar'], 3, True, 1, 120, False, 0, False, False, True, 0, 540);

    case LintRetorno of
      0: Result := 'A';
      1: Result := 'E';
      2: Result := 'C';
      3: Result := 'A';
    end;
  end
  else
    Result := fCfgSisL('TIPVIA');
end;

function fVerificaConexaoApiScope: Boolean ;
var
  LTransacaoApi: TTransacaoTefController ;
  LParam: TTransacaoTefBuscaParam ;
begin
  LTransacaoApi := TTransacaoTefController.Create ;
  try
    try
      FillChar(LParam, SizeOf(TTransacaoTefBuscaParam), #0);
      LParam.DtaTrn := Date ;
      LParam.NumNsu := '000000' ;
      result := LTransacaoApi.fBuscarTransacaoEspecifica(LParam) ;
    except
      on TE: TTrasacaoTefNotFoundException do
      begin
        Result := True ;
      end ;
      on E: Exception do
      begin
        Result := False ;
      end ;
    end ;
  finally
    FreeAndNil(LTransacaoApi) ;
  end ;
end ;

{ TDadosAdicionaisTefTra }

function TDadosAdicionaisTefTra.ArrDocs(
  const AarrValor: TArrayInfoTraDoc): IDadosAdicionaisTefTra;
begin
  FArrDocs := AarrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.ArrDocs: TArrayInfoTraDoc;
begin
  Result := FArrDocs ;
end;

constructor TDadosAdicionaisTefTra.Create;
begin
  FstrPixS_N := '' ;
  FstrOpcDoc := '' ;
  FstrOpeRcx := '' ;
  FArrDocs := Nil ;
  FintQtdParcelas := 0 ;
  FstrNumDoc     := '' ;
  FfltValor      := 0.00 ;
  FintOperacao   := 0 ;
  FstrModalidade := '' ;
  FstrStatus     := '' ;
end;

function TDadosAdicionaisTefTra.Modalidade(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrModalidade := AstrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.Modalidade: String;
begin
  Result := FstrModalidade ;
end;

class function TDadosAdicionaisTefTra.New: IDadosAdicionaisTefTra;
begin
  Result := Self.Create ;
end;

function TDadosAdicionaisTefTra.NumDoc: String;
begin
  Result := FstrNumDoc ;
end;

function TDadosAdicionaisTefTra.NumDoc(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrNumDoc := AstrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.OpcDoc: String;
begin
  Result := FstrOpcDoc ;
end;

function TDadosAdicionaisTefTra.OpeRcx(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrOpeRcx := AstrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.Operacao(
  const AintValor: Integer): IDadosAdicionaisTefTra;
begin
  FintOperacao := AintValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.Operacao: Integer;
begin
  Result := FintOperacao ;
end;

function TDadosAdicionaisTefTra.OpeRcx: String;
begin
  Result := FstrOpeRcx ;
end;

function TDadosAdicionaisTefTra.OpcDoc(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrOpcDoc := AstrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.PixS_N: String;
begin
  Result := FstrPixS_N ;
end;

function TDadosAdicionaisTefTra.PrePago(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrPrePago := AstrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.PrePago: String;
begin
  Result := FstrPrePago ;
end;

function TDadosAdicionaisTefTra.ParcAdm(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrParcAdm := AstrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.ParcAdm: String;
begin
  Result := FstrParcAdm ;
end;

function TDadosAdicionaisTefTra.QtdParcelas(
  const AintValor: Integer): IDadosAdicionaisTefTra;
begin
  FintQtdParcelas := AintValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.QtdParcelas: Integer;
begin
  Result := FintQtdParcelas ;
end;

function TDadosAdicionaisTefTra.Status(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrStatus := AstrValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.Status: String;
begin
  Result := FstrStatus ;
end;

function TDadosAdicionaisTefTra.Valor: Double;
begin
  Result := FfltValor ;
end;

function TDadosAdicionaisTefTra.Valor(
  const AfltValor: Double): IDadosAdicionaisTefTra;
begin
  FfltValor := AfltValor ;
  Result := Self ;
end;

function TDadosAdicionaisTefTra.PixS_N(
  const AstrValor: String): IDadosAdicionaisTefTra;
begin
  FstrPixS_N := AstrValor ;
  Result := Self ;
end;

{ TDadosValidaParcelasCartao }

function TDadosValidaParcelasCartao.CodFin: String;
begin
  Result := FstrCodFin ;
end;

function TDadosValidaParcelasCartao.CodFin(
  const AValue: String): IDadosValidaParcelas;
begin
  FstrCodFin := AValue ;
  Result := Self ;
end;

constructor TDadosValidaParcelasCartao.Create;
begin
  FblnF11 := False ;
  FintQtdNeg := 0 ;
  FstrCodFin := '' ;
  FCfgTFPF11 := fCfgSis('TFPF11', varBoolean);
  FCfgCNTF11 := fCfgSis('CNTF11', varBoolean);
  FCfgSOLCAR := fCfgSis('SOLCAR', varBoolean);
end;

function TDadosValidaParcelasCartao.F11: Boolean;
begin
  Result := FblnF11 ;
end;

function TDadosValidaParcelasCartao.fTravarQuantidadeNegociada: Boolean;
begin
  Result := False;

  if not (FblnF11 or FCfgSOLCAR) then Exit;
  if FintQtdNeg <= 0 then Exit;
  if not FCfgTFPF11 then Exit;

  Result := fEmptyStr(FstrCodFin);
end;

function TDadosValidaParcelasCartao.fObrigarQuantidadeNegociada: Boolean;
begin
  Result := False;

  if not FCfgCNTF11 then Exit;
  if not FblnF11 then Exit;
  if FintQtdNeg <= 0 then Exit;

  Result := fEmptyStr(FstrCodFin);
end;

function TDadosValidaParcelasCartao.fTravouQtdParcelaInformada(
  const AParcInformada: Integer): Boolean;
begin
  Result := fTravarQuantidadeNegociada And (FintQtdNeg < AParcInformada);
end;

function TDadosValidaParcelasCartao.F11(
  const AValue: Boolean): IDadosValidaParcelas;
begin
  FblnF11 := AValue ;
  Result := Self ;
end;

class function TDadosValidaParcelasCartao.New: IDadosValidaParcelas;
begin
  Result := Self.Create ;
end;

function TDadosValidaParcelasCartao.QtdNeg(
  const AValue: Integer): IDadosValidaParcelas;
begin
  FintQtdNeg := AValue ;
  Result := Self ;
end;

function TDadosValidaParcelasCartao.QtdNeg: Integer;
begin
  Result := FintQtdNeg ;
end;

end.
