unit untTBancoDoBrasilAPI;

interface

Uses Classes, SysUtils, IPPeerClient, IPPeerCommon,
     REST.Json, System.Json, untConstantes, System.Net.URLClient, IdIOHandler,
     IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
     IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSLHeaders, Vcl.StdCtrls, Forms,
     System.Generics.Collections, UniClientDataSet, DB, Uni, untGravando,
     untFuncoesSimples, IdCoder, IdCoder3to4, IdCoderMIME,untTRegBol,StrUtils,
     DateUtils,untFuncAutban,Winapi.Windows,untFuncoesBoleto,REST.Types, REST.Client,
     untTypesSistema,untCNFOCO_Class, untCNFOCO_Dao,untLogCtr,HTTPSend, blcksock,
     synautil, ssl_openssl, untArqNaoGravados;

Type
  TDadosToken = class
  private
    Access_Token : String;
    Expiracao: Integer;
    RefreshTime: TTime;
    Exception : String;
    function GetAccessToken: String;
    Function RefreshToken:Boolean;
  Public
    Property AccessToken  : String  Read GetAccessToken  Write Access_Token;
  end;

Type
  TDetalhamento = Record
    ValorPago,
    ValorCreditado,
    ValorIOF,
    ValorTarifa,
    CanalPagamento,
    EndToEndID,
    TextoMensagemBloqueto,
    CodigoModalidadeTitulo,

    NumeroTituloCedenteCobranca,
    DataVencimentoTituloCobranca,
    ValorOriginalTituloCobranca,
    DataEmissaoTituloCobranca : String;

    NumeroCarteiraCobranca,
    NumeroVariacaoCarteiraCobranca,
    CodigoLinhaDigitavel,
    TextoCodigoBarrasTituloCobranca,
    NumeroContratoCobranca : String;

    qrCodeURL,
    qrCodeTxId,
    qrCodeEmv : String;

  private
    function RetornaCodigoModalidadeTitulo: String;
    function RetornaValorTarifa: String;
    function DataEmissaoTituloCobrancaAsDate: String;
    function DataVencimentoTituloCobrancaAsDate: String;
  public
    Property TipoDeCobranca  : String  Read RetornaCodigoModalidadeTitulo  Write CodigoModalidadeTitulo;
    Property Tarifa          : String  Read RetornaValorTarifa             Write ValorTarifa;

    Property ADataVencimentoTituloCobranca  : String  Read DataVencimentoTituloCobrancaAsDate  Write DataVencimentoTituloCobranca;
    Property ADataEmissaoTituloCobranca     : String  Read DataEmissaoTituloCobrancaAsDate     Write DataEmissaoTituloCobranca;
  End;

Type
  TRetornoPesquisaBancoDoBrasilApi = class
  private
    function GetNossoNumero: String;
    function DataRegistroAsDate: String;
    function DataMovimentoAsDate: String;
    function DataVencimentoAsDate: String;
    function DataCreditoAsDate: String;
    function ValorPagoCedente:String;
  public
    indicadorContinuidade,
    quantidadeRegistros,
    proximoIndice,
    BoletoNumeroBoletoBB,
    BoletoEstadoTituloCobranca,
    BoletoDataRegistro,
    BoletoDataVencimento,
    BoletoDataMovimento,
    BoletoValorOriginal,
    BoletoValorAtual,
    BoletoValorPago,
    BoletoContrato,
    BoletoCarteiraConvenio,
    BoletoVariacaoCarteiraConvenio,
    BoletoCodigoEstadoTituloCobranca,
    BoletoDataCredito,
    ValorDesconto,
    ValorJuros,
    NomeDoArquivo: String;
    FDetalhamento : TDetalhamento;
    Property NossoNumero            : String  Read GetNossoNumero        Write BoletoNumeroBoletoBB;
    Property ABoletoDataRegistro    : String  Read DataRegistroAsDate    Write BoletoDataRegistro;
    Property ABoletoDataVencimento  : String  Read DataVencimentoAsDate  Write BoletoDataVencimento;
    Property ABoletoDataMovimento   : String  Read DataMovimentoAsDate   Write BoletoDataMovimento;
    Property ABoletoDataCredito     : String  Read DataCreditoAsDate     Write BoletoDataCredito;
    Property ABoletoValorPago       : String  Read ValorPagoCedente      Write BoletoValorPago;
  end;


Type
  TDadosCarteira = class
  private
    LHomologacao : Boolean;
    LCarteiraBanco,
    LEmpresaCarteira,
    LLinkConsulta,
    LLinkInclusao,
    LlinkBaixa,
    FLinkConsultaDetalhada,
    FLinkAlteracao,
    FLinkConsultaPix,
    FLinkGerarPix,
    FOcorrenciasDeEncargo,
    LLinkApi,
    LLinkTokenAPI,
    LKeyUser,
    LAuthorization,
    LConvenio,
    LCodCarteira,
    LVariacaoCarteira,
    LQtdDiasProtesto,
    LQtdDiasLimitePagto,
    LObservacao1,
    LObservacao2,
    LObservacao3,
    LObservacao4,
    LObservacao5,
    LPercenMulta,
    LOrgaoNegativador,
    LQtdDiasNegativacao,
    LAceite,
    LPastaBancoDoBrasil,
    LContaCorrente,
    LAgencia,
    LContaCaucao,
    LTipoCobranca,
    LGerarQRCodePix,
    LAutoIncremChavePix : String;
  public
    property QtdDiasLimitePagto: String Read LQtdDiasLimitePagto Write LQtdDiasLimitePagto;
  end;

Type
  TBancoDoBrasilAPI = class(TObject)
  private
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;
    LRequisicao: TidHTTP;

    FHandleRequisicoes: THandle;
    FHTTPSend: THTTPSend;

    LDadosCarteira : TDadosCarteira;
    LDadosToken: TDadosToken;

    LPercentualMulta,
    LPercentualMora: Double;
    LFaturamento: Boolean;
    FTentarNovamente: Boolean;
    LNossoNumeroCancelamento : String;
    LCancelarRegistro : Boolean;
    LDuplicataCancelamento: String;
    LProximoNossoNumero : String;
    FAlteracoes: String;

    ListaRequisicaoRegistroBoleto : TList<TRequisicaoRegistroBoleto>;
    LRetornoBandoDoBrasilAPI: TRetornoBoletoBancoDoBrasil;

    RestExecute : function (const AMetodo, AUrl,AToken : WideString;
                            out AJsonRetorno: WideString; AJsonEnvio: WideString = ''): Integer; stdcall;


    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure CriarComponenteRequisicao;
    procedure CriarProtocoloSSL;
    Procedure GerarToken;
    procedure GerarTokenSynalist;
    procedure DefinirURL;
    procedure CarregaDadosCarteira(ACarteira: String);
    function RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente: TDataset;ANosNum:String): String;
    function RetornaDadosDaRequisicaoBaixa: String;
    function RetornaDadosDaRequisicaoGerarPix: String;
    function RetornaDadosDaRequisicaoAlteracao(ADadosDuplicata: TDataSet):String;
    function RetornaCampoDecimalJSON(AValor: String): String;
    function RetornaValorString(AValor: String; ATamanho: Integer = 0): String;
    function RetornaDesconto(ADadosDuplicata : TDataSet): TJsonObject;
    function UtilizaDescontoDePontualidade(AValDes:Double): Boolean;
    function RetornaJurosMora(ADadosDuplicata : TDataSet): TJsonObject;
    function RetornaMulta(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaNovaDataVencimento(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaNovoEnderecoPagador(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaNovaQuantidadeDiasRecebimentoAposVencimento:TJsonObject;
    function RetornaPagador(ADadosCliente : TDataSet): TJsonObject;
    function RetornaDescontoPontualidade(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaSegundoDesconto(ADadosDuplicata : TDataSet):TJsonObject;
    function RetornaCampoNossoNumero(ANosNum: String):String;
    function PrettyJSON(jsonstring:String):String;
    function FormataAutorizacao(AAutorizacao: String): String;
    procedure Aguarde(msecs: Integer);
    procedure AguardeCincoSegundos;
    function RetornaJsonRegistroBoleto(AAutoIncrem: String): String;
    function EncontrarJsonRegistroBoleto(AAutoIncrem: String):String;
    procedure AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
                                             ADadosRetorno: TRetornoBoletoBancoDoBrasil);
    function RetornaLinkBaixa(ANosNum:String):String;
    function RetornaLinkGerarPix(ANosNum:String):String;
    function RetornaLinkAlteracao(ADadosDuplicata : TDataSet):String;
    function NossoNumeroDuplicado(AErro:String):Boolean;
    function RetornaPixBoleto(ANossoNumero,Autoincrem: String): String;

    procedure VerificaSeRegistrouBoleto(ANosNum: String;
                                        ADuplicata: TDataSet;
                                    Var AStatus:Integer;
                                    Var ARetorno: WideString);
    function BoletoEncontrado(ADuplicata: TDataSet; ADetalhamento: TDetalhamento): Boolean;
    procedure ConsultaProximoNossoNumero;
    function RetornaUltimaDataDeRegistro: String;
    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function AlteracaoSelecionada(AAlteracao: String): Boolean;
    function RetornaDetalheBoleto(ANossoNumero: String):TDetalhamento;
    function RetornaLinkConsultaDetalhada(ANosNum: String): String;
    procedure AddParameterList(Var AList:TStringList; AParameter,AValor: String);
    function RetornaPeriodo(ASituacao: String):String;
    procedure CarregaOcorrenciasDeEncargosBancarios;
    function RetornaErro(AStatus:Integer;AErro:String):String;
    function ImportarDetalhamento(ADadosBoleto:TRetornoPesquisaBancoDoBrasilApi): Boolean;

    procedure ValidaStatusErro(AStatus: Integer; ARetornoGet: String);
    procedure RetornaDataCreditoMovimento(AJsonBoleto: TJsonValue;
                                          var ADadosBoleto: TRetornoPesquisaBancoDoBrasilApi);
    procedure RetornaValorJurosDescontos(var ADadosBoleto: TRetornoPesquisaBancoDoBrasilApi);

    function ExecutaRequisicao(const AMetodo, AUrl,AToken : WideString;
                               out AJsonRetorno: WideString; AJsonEnvio: WideString = ''): Integer;

    function RetornaTextoDoJsonDeErros(AErro: String): String;
    procedure ExibeFormMensagemErro(AMensagem: String);
    function RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
    Function ExtrairMensagensErro(const LJsonObject: TJsonObject): String;

  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    function CadastrarNovoBoleto(ADadosDuplicata, ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoBancoDoBrasil;
    procedure BaixaBoletoRegistrado(ADataSet: TDataSet);
    procedure GerarPixBoleto(ADataSet:TDataSet);
    procedure AlterarBoletoRegistrado(ADuplicata:TDataSet);
    procedure CancelarRegistroBoleto;
    procedure ReimpressaoDeBoleto(AAutoIncrem: String);

    function ConsultaBoletosPorPeriodo(ADataInicial,
                                       ADataFinal: String;
                                       AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoDoBrasilApi>;

    procedure CancelarBoletos(ADataSet:TDataSet);
    procedure AlterarBoletos(ADataSet:TDataSet);
    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoDoBrasilApi; out ADuplicata: TDuplicataCtr): Boolean;

    procedure RetornaDadosPagamentoPixBoleto(ADadosBoleto: TRetornoPesquisaBancoDoBrasilApi);
    procedure GravarDadosRequisicaoRegistroBoleto;

    property PercentualMulta  : Double    Read LPercentualMulta  Write LPercentualMulta;
    property PercentualMora   : Double    Read LPercentualMora   Write LPercentualMora;
    property Faturamento      : Boolean   Read LFaturamento      Write LFaturamento;
    property DadosCarteira    : TDadosCarteira Read LDadosCarteira Write LDadosCarteira;
    property Alteracoes       : String    Read FAlteracoes        Write FAlteracoes;
    property TentarNovamente  : Boolean   Read FTentarNovamente  Write FTentarNovamente;
    property CancelarRegistro : Boolean   Read LCancelarRegistro Write LCancelarRegistro;

    property NossoNumeroCancelamento  : String    Read LNossoNumeroCancelamento Write LNossoNumeroCancelamento;
    property DuplicataCancelamento    : String    Read LDuplicataCancelamento   Write LDuplicataCancelamento;

    property RetornoBandoDoBrasilAPI  : TRetornoBoletoBancoDoBrasil Read  LRetornoBandoDoBrasilAPI  Write LRetornoBandoDoBrasilAPI;

  End;

const
  C_URL            = 'https://api.bb.com.br/cobrancas/v2';
  C_URL_HOM        = 'https://api.hm.bb.com.br/cobrancas/v2';

  C_URL_OAUTH_PROD = 'https://oauth.bb.com.br/oauth/token';
  C_URL_OAUTH_HOM  = 'https://oauth.hm.bb.com.br/oauth/token';

  INDICADOR_SITUACAO: Array of String = ['A', 'B'];

  C_ERRO_AUTENTICACAO_BB = 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

implementation

uses IdCTypes;

{$IF CompilerVersion <= 30.0}
type
  TSNIBancoDoBrasilAPI = class
    class procedure OnStatusInfoEx(ASender: TObject; const AsslSocket: PSSL;
      const AWhere, Aret: TIdC_INT; const AType, AMsg: String);
  end;

class procedure TSNIBancoDoBrasilAPI.OnStatusInfoEx(ASender: TObject;
  const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT; const AType, AMsg: String);
begin
  If ((AWhere And SSL_CB_HANDSHAKE_START) = 0) Then
    Exit;

  If Not (ASender Is TIdSSLIOHandlerSocketOpenSSL) Then
    Exit;

  If Trim(TIdSSLIOHandlerSocketOpenSSL(ASender).Host) <> '' Then
    SSL_set_tlsext_host_name(AsslSocket, Trim(TIdSSLIOHandlerSocketOpenSSL(ASender).Host));
end;
{$IFEND}

{ TBancoDoBrasilAPI }

procedure TBancoDoBrasilAPI.AddParameterList(var AList: TStringList; AParameter,
  AValor: String);
begin
  If fEmptyStr(AValor) Then
    Exit;

  AParameter := AParameter + '=' + AValor;
  AList.Add(AParameter);
end;

procedure TBancoDoBrasilAPI.Aguarde(msecs: Integer);
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;

procedure TBancoDoBrasilAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;


procedure TBancoDoBrasilAPI.AlterarBoletoRegistrado(ADuplicata: TDataSet);
  Var
    LRetornoPatch: WideString;
    LDadosRequisicao: String;
    LRequisicaoAlteraBoleto : TRequisicaoRegistroBoleto;
    LStatus: Integer;
begin
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;
  Self.FTentarNovamente := True;

  LRequisicaoAlteraBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoAlteraBoleto.LCodBco := '001';
  LRequisicaoAlteraBoleto.FDescricao := 'ALTERAÇÃO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := RetornaDadosDaRequisicaoAlteracao(ADuplicata);
  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := RetornaLinkAlteracao(ADuplicata);

  Try
    Try
      If LDadosToken.RefreshToken Then
        TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

      LStatus := ExecutaRequisicao('PATCH',
                                   RetornaLinkAlteracao(ADuplicata),
                                   'Bearer ' + LDadosToken.AccessToken,
                                   LRetornoPatch,
                                   LDadosRequisicao);

      If (LStatus = 404) And fEmptyStr(LRetornoPatch) Then
        LRetornoPatch :=
          '{'+
            '"errors":[ '+
              '{ '+
                '"status": "404",'+
                '"message": "Boleto já baixado/cancelado ou inexistente."'+
              '}'+
            ']'+
          '}';

      If LStatus <> 200 Then
        Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPatch);

      Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetornoPatch;

      untLogCtr.GravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                           'ALTERAÇÃO DE BOLETO - BANCO DO BRASIL [ONLINE]' ,
                           'TBancoDoBrasilAPI');
    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Begin
      ListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
    End;
  End;
end;

procedure TBancoDoBrasilAPI.AlterarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;


    While (LContadorTentativas <= 4) Do
    Begin
      Try

        While Not ADataSet.Eof Do
        Begin
          AlterarBoletoRegistrado(ADataSet);

          ADataSet.Next;
          pStep(frmGravandoGenericProcedure.pgbStatus);
          LContadorTentativas := 0;
        End;

        LErroAPI := False;

      Except
        On E:Exception Do
        begin

          LErroAPI := True;


          If (LContadorTentativas >= 4) Or Not Self.FTentarNovamente Then
          Begin
            LDocumentosRestantes := '';

            While Not ADataSet.Eof Do
            Begin
              LDocumentosRestantes := LDocumentosRestantes + ADataSet.FieldByName('CTR_NUMDUP').AsString +
                                                             ADataSet.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                             ADataSet.FieldByName('CTR_CODEMP').AsString + ', ';
              ADataSet.Next;
            End;

            LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

            ExibeFormMensagemErro('Ocorreram erros ao alterar o(s) boleto(s) no Banco do Brasil [Online].' + #13#10 +
                                  'Erro gerado: ' + RetornaTextoDoJsonDeErros(E.Message) + #13#10 +
                                  'Documento(s) ficaram sem alterar o boleto: ' + LDocumentosRestantes);
          End;

          Inc(LContadorTentativas);

        End;

      End;


      If Not LErroAPI Then
      Begin
        pMensagemOk('Alteração realizada com sucesso!');
        Break;
      End;
    End;

    frmGravandoGenericProcedure.pgbStatus.Visible := False;
  Finally
    GravarDadosRequisicaoRegistroBoleto;
  End;
end;

procedure TBancoDoBrasilAPI.AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
  ADadosRetorno: TRetornoBoletoBancoDoBrasil);
  Var
    LCadRec: TUniQuery;
    LSql: String;
begin
  Try
    LCadRec := fCriaQuery(Nil);

    LSql := LSql + 'UPDATE    ';
    LSql := LSql + '  CADREC  ';
    LSql := LSql + 'SET ';
    LSql := LSql + '  CTR_BCOENV = :CODBCO, ';
    LSql := LSql + '  CTR_DTAENV = ' + fCurrentDate + ', ';
    LSql := LSql + '  CTR_TX_BOL = :TX_BOL, ';
    LSql := LSql + '  CTR_QRCODE = :QRCODE, ';
    LSql := LSql + '  CTR_PIXLOC = :PIXLOC, ';
    LSql := LSql + '  CTR_LNKCIT = :LNKCIT ';
    LSql := LSql + 'WHERE ';
    LSql := LSql + '  CTR_NUMDUP = :NUMDUP AND ';
    LSql := LSql + '  CTR_PARCEL = :PARCEL AND ';
    LSql := LSql + '  CTR_ESPDOC = :ESPDOC AND ';
    LSql := LSql + '  CTR_CODEMP = :CODEMP AND ';
    LSql := LSql + '  CTR_CODCLI = :CODCLI AND ';
    LSql := LSql + '  CTR_SEQBAI = 0 ';

    Try
      LCadRec.Close;
      LCadRec.Sql.Clear;
      LCadRec.Sql.Add(LSql);
      LCadRec.ParamByName('CODBCO').AsString := '001';

      If Not ADadosRetorno.QrCodeTxId.IsEmpty Then
      Begin
        LCadRec.ParamByName('TX_BOL').AsString := ADadosRetorno.QrCodeTxId;
        LCadRec.ParamByName('QRCODE').AsString := ADadosRetorno.QrCodeEmv;
        LCadRec.ParamByName('PIXLOC').AsString := ADadosRetorno.QrCodeUrl;
        LCadRec.ParamByName('LNKCIT').AsString := ADadosRetorno.QrCodeLinkCitel;
      End;

      LCadRec.ParamByName('NUMDUP').AsString := ACadRec.FieldByName('CTR_NUMDUP').AsString;
      LCadRec.ParamByName('PARCEL').AsString := ACadRec.FieldByName('CTR_PARCEL').AsString;
      LCadRec.ParamByName('ESPDOC').AsString := ACadRec.FieldByName('CTR_ESPDOC').AsString;
      LCadRec.ParamByName('CODEMP').AsString := ACadRec.FieldByName('CTR_CODEMP').AsString;
      LCadRec.ParamByName('CODCLI').AsString := ACadRec.FieldByName('CTR_CODCLI').AsString;
      LCadRec.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCadRec);
  End;
end;

procedure TBancoDoBrasilAPI.BaixaBoletoRegistrado(ADataSet:TDataSet);
  Var
    LRetornoPost: WideString;
    LDadosRequisicao: String;
    LRequisicaoAlteraBoleto : TRequisicaoRegistroBoleto;
    LStatus: Integer;
begin
  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoAlteraBoleto.LCodBco := '001';
  LRequisicaoAlteraBoleto.FDescricao := 'CANCELAMENTO';
  LRequisicaoAlteraBoleto.LLocImp := 'ATB';

  LDadosRequisicao := RetornaDadosDaRequisicaoBaixa;
  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := RetornaLinkBaixa(ADataSet.FieldByName('CTR_NOSNUM').AsString);

  Try
    Try
      If LDadosToken.RefreshToken Then
        TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

      LStatus := ExecutaRequisicao('POST',
                                   RetornaLinkBaixa(ADataSet.FieldByName('CTR_NOSNUM').AsString),
                                   'Bearer ' + LDadosToken.AccessToken,
                                   LRetornoPost,
                                   LDadosRequisicao);


      If LStatus <> 200 Then
        Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPost);

      Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetornoPost;

      LimpaDadosBoleto(ADataSet.FieldByName('AUTOINCREM').AsString);

      untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                           'CANCELAMENTO DE BOLETO - BANCO DO BRASIL [ONLINE]',
                           'TBancoDoBrasilAPI');

      If Not fEmptyStr(ADataSet.FieldByName('CTR_LNKCIT').AsString) Then
        TFuncoesPixBoleto.RemoverLinkCitelPixBoleto(fRetCGCEmpresa(ADataSet.FieldByName('CTR_CODEMP').AsString),
                                                    ADataSet.FieldByName('CTR_CODEMP').AsString,
                                                    ADataSet.FieldByName('CTR_TX_BOL').AsString,
                                                    LDadosCarteira.LAutoIncremChavePix,
                                                    True);

    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Begin
      ListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
    End;
  End;
end;


function TBancoDoBrasilAPI.BoletoEncontrado(ADuplicata: TDataSet;
  ADetalhamento: TDetalhamento): Boolean;
  Var
   LDuplicata: String;
begin
  Result := True;

  LDuplicata := Copy(Trim(UpperCase(ADuplicata.FieldByName('CTR_NUMDUP').AsString +
                                    ADuplicata.FieldByName('CTR_PARCEL').AsString)),0,15);


  If (ADetalhamento.NumeroTituloCedenteCobranca <> LDuplicata) Then
    Exit(False);

  If (StrToDate(ADetalhamento.ADataVencimentoTituloCobranca) <> ADuplicata.FieldByName('CTR_DTAVEN').AsDateTime) Then
    Exit(False);

  If (StrToDate(ADetalhamento.ADataEmissaoTituloCobranca) <> ADuplicata.FieldByName('CTR_DTACAD').AsDateTime) Then
    Exit(False);

  If (fFormataFloat((fStrToFloat(ADetalhamento.ValorOriginalTituloCobranca)/100),2) <> fFormataFloat(RetornaValorDuplicata(ADuplicata),2)) Then
    Exit(False);

end;


function TBancoDoBrasilAPI.CadastrarNovoBoleto(ADadosDuplicata,ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoBancoDoBrasil;
  Var
    LRetornoPost: WideString;
    LDadosRequisicao: String;

    LJsonRetorno: TJSONObject;
    LJsonObjectGroup: TJsonObject;
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
    LStatus : Integer;
    LJsonPixGerado: String;
    LContadorTentativas : Integer;
begin
  Self.FTentarNovamente := True;
  LJsonPixGerado := '';
  LContadorTentativas := 0;
  Result := TRetornoBoletoBancoDoBrasil.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoRegistroBoleto.LCodBco := '001';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.LFaturamento,'FAT','CTR');
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente, ANosNum);
  LRequisicaoRegistroBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := LDadosCarteira.LLinkInclusao;

  Try
    Try
      TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

      LStatus := ExecutaRequisicao('POST',
                                   LDadosCarteira.LLinkInclusao,
                                   'Bearer ' + LDadosToken.AccessToken,
                                   LRetornoPost,
                                   LDadosRequisicao);

      VerificaSeRegistrouBoleto(ANosNum,
                                ADadosDuplicata,
                                LStatus,
                                LRetornoPost);

      If LStatus <> 201 Then
        Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPost);

      Self.FTentarNovamente := False;

      LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPost) as TJSONObject;

      Result.nossoNumero    := RetornaValorJson(LJsonRetorno,'numero');
      Result.linhaDigitavel := RetornaValorJson(LJsonRetorno,'linhaDigitavel');
      Result.codigoDeBarras := RetornaValorJson(LJsonRetorno,'codigoBarraNumerico');

      {Beneficiairo}
      LJsonObjectGroup := LJsonRetorno.GetValue('beneficiario') as TJSONObject;
      If Assigned(LJsonObjectGroup) Then
      Begin
        Result.BeneficiarioAgencia              :=  RetornaValorJson(LJsonObjectGroup,'agencia');
        Result.BeneficiarioContaCorrente        :=  RetornaValorJson(LJsonObjectGroup,'contaCorrente');
        Result.BeneficiarioTipoEndereco         :=  RetornaValorJson(LJsonObjectGroup,'tipoEndereco');
        Result.BeneficiarioLogradouro           :=  RetornaValorJson(LJsonObjectGroup,'logradouro');
        Result.BeneficiarioBairro               :=  RetornaValorJson(LJsonObjectGroup,'bairro');
        Result.BeneficiarioCidade               :=  RetornaValorJson(LJsonObjectGroup,'cidade');
        Result.BeneficiarioCodigoCidade         :=  RetornaValorJson(LJsonObjectGroup,'codigoCidade');
        Result.BeneficiarioUf                   :=  RetornaValorJson(LJsonObjectGroup,'uf');
        Result.BeneficiarioCep                  :=  RetornaValorJson(LJsonObjectGroup,'cep');
        Result.BeneficiarioIndicadorComprovacao :=  RetornaValorJson(LJsonObjectGroup,'indicadorComprovacao');
      End;
      {QrCode}
      LJsonObjectGroup := LJsonRetorno.GetValue('qrCode') as TJSONObject;
      If Assigned(LJsonObjectGroup) Then
      Begin

        If RetornaValorJson(LJsonObjectGroup,'txId').Equals('Pix não registrado') Then
        Begin
          Repeat
            Try
              LJsonPixGerado := RetornaPixBoleto(ANosNum,ADadosDuplicata.FieldByName('AUTOINCREM').AsString);
              LJsonObjectGroup := TJSONObject.ParseJSONValue(LJsonPixGerado) as TJSONObject;

              If Assigned(LJsonObjectGroup) Then
              Begin
                If Not RetornaValorJson(LJsonObjectGroup,'qrCode.txId').Equals('Pix não registrado') Then
                Begin
                  Result.QrCodeUrl  :=  RetornaValorJson(LJsonObjectGroup,'qrCode.url');
                  Result.QrCodeTxId :=  RetornaValorJson(LJsonObjectGroup,'qrCode.txId');
                  Result.QrCodeEmv  :=  RetornaValorJson(LJsonObjectGroup,'qrCode.emv');
                  Break;
                End;
              End;

            Except
             // não faz nada porque o boleto já até registrou, vai seguir sem o pix mesmo.
            End;

            Inc(LContadorTentativas);
          Until (LContadorTentativas = 2);
        End
        Else
        Begin
          Result.QrCodeUrl  :=  RetornaValorJson(LJsonObjectGroup,'url');
          Result.QrCodeTxId :=  RetornaValorJson(LJsonObjectGroup,'txId');
          Result.QrCodeEmv  :=  RetornaValorJson(LJsonObjectGroup,'emv');
        End;

        Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('001',
                                                                              Result.QrCodeTxId,
                                                                              Result.QrCodeEmv,
                                                                              FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                              LDadosCarteira.LAutoIncremChavePix,
                                                                              IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                     StrToIntDef(LDadosCarteira.LQtdDiasLimitePagto, 0)) + StrToTime('23:59:59'));
      End;

      AtualizaDadosExportacaoRemessa(ADadosDuplicata,
                                     Result);

    Except

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;

        If NossoNumeroDuplicado(E.Message) Then
        Begin

          if Not fEmptyStr(LProximoNossoNumero) then
          Begin
            LProximoNossoNumero := IntToStr(StrToInt64(LProximoNossoNumero)+1);
            LProximoNossoNumero.PadLeft(10,'0');
            ANosNum := LProximoNossoNumero;
            Raise Exception.Create(RetornaTextoDoJsonDeErros(E.Message));
          End;

          TfrmGravando.fExecutarModalA(ConsultaProximoNossoNumero,'Aguarde... Consultando próximo nosso número.', '');
          ANosNum := LProximoNossoNumero;
          Raise Exception.Create(RetornaTextoDoJsonDeErros(E.Message));
        End;

        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(RetornaTextoDoJsonDeErros(E.Message));
      End;
    End;
  Finally
    Begin
      ListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);
    End;
  End;
end;

procedure TBancoDoBrasilAPI.CancelarBoletos(ADataSet: TDataSet);
  Var
    LDocumentosRestantes : String;
    LErroAPI : Boolean;
    LContadorTentativas : Integer;
begin
  Try
    LContadorTentativas := 1;
    LErroAPI := False;
    ADataSet.First;

    frmGravandoGenericProcedure.pgbStatus.Visible := True;
    frmGravandoGenericProcedure.pgbStatus.Position := 0;
    frmGravandoGenericProcedure.pgbStatus.Properties.Max := ADataSet.RecordCount;


    While (LContadorTentativas <= 4) Do
    Begin
      Try

        While Not ADataSet.Eof Do
        Begin
          BaixaBoletoRegistrado(ADataSet);

          ADataSet.Next;

          pStep(frmGravandoGenericProcedure.pgbStatus);
          LContadorTentativas := 0;
        End;

        LErroAPI := False;

      Except
        On E:Exception Do
        begin

          LErroAPI := True;


          If (LContadorTentativas >= 4) Or Not Self.FTentarNovamente  Then
          Begin
            LDocumentosRestantes := '';

            While Not ADataSet.Eof Do
            Begin
              LDocumentosRestantes := LDocumentosRestantes + ADataSet.FieldByName('CTR_NUMDUP').AsString +
                                                             ADataSet.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                             ADataSet.FieldByName('CTR_CODEMP').AsString + ', ';
              ADataSet.Next;
            End;

            LDocumentosRestantes := LeftStr(LDocumentosRestantes, LDocumentosRestantes.Length - 2);

            ExibeFormMensagemErro('Não foi possível cancelar o(s) boleto(s) no Banco do Brasil [Online].' + #13#10 +
                                  'Motivo: ' + RetornaTextoDoJsonDeErros(E.Message) + #13#10 +
                                  'Documento(s) que ficaram sem cancelar o boleto: ' + LDocumentosRestantes);
          End;

          Inc(LContadorTentativas);

        End;

      End;


      If Not LErroAPI Then
      Begin
        pMensagemOk('Cancelamento realizado com sucesso!');
        Break;
      End;
    End;

    frmGravandoGenericProcedure.pgbStatus.Visible := False;
  Finally
    GravarDadosRequisicaoRegistroBoleto;
  End
end;

procedure TBancoDoBrasilAPI.CancelarRegistroBoleto;
begin
  BaixaBoletoRegistrado(Nil);
end;

procedure TBancoDoBrasilAPI.CarregaDadosCarteira(ACarteira: String);
begin
  LDadosCarteira := TDadosCarteira.Create;
  LDadosCarteira.LCarteiraBanco := LeftStr(ACarteira,14);
  LDadosCarteira.LEmpresaCarteira := RightStr(ACarteira, 3);


  LDadosCarteira.LAgencia             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CODAGEN', '',LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LContaCorrente       := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NUMCTAC', '',LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LAceite              := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'PROACEI'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LConvenio            := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CODCONV'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCodCarteira         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NUMCART'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LVariacaoCarteira    := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'VARCART'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasProtesto     := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIAPROT'      ,'0', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasLimitePagto  := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIALIMI'      ,'0', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LObservacao1         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV1'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao2         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV2'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao3         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV3'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao4         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV4'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao5         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'OBSERV5'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LPercenMulta         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'PERMULT'      ,'', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LQtdDiasNegativacao  := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'DIANEGA'      ,'0', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LOrgaoNegativador    := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'NUMORGAO'      ,'', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LKeyUser             := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'KEY_USER'     ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LAuthorization       := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'AUTHORIZATION','', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LContaCaucao          := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CONTA_CAUCAO','', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoCobranca         := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'TIPO_COBRANCA','', LDadosCarteira.LEmpresaCarteira);

  CarregaOcorrenciasDeEncargosBancarios;
  LDadosCarteira.LHomologacao := (LeftStr(LDadosCarteira.LKeyUser,2) = 'd2');

  LDadosCarteira.LGerarQRCodePix := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'GERAPIX', '' , LDadosCarteira.LEmpresaCarteira);
  If LDadosCarteira.LGerarQRCodePix.IsEmpty Then
    LDadosCarteira.LGerarQRCodePix := 'N';

  LDadosCarteira.LAutoIncremChavePix := fGetBancoConfig(0, LDadosCarteira.LCarteiraBanco, 'CHAPIX', '' , LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LPastaBancoDoBrasil := ExtractFilePath(Application.ExeName)+ 'API_COBRANCA_BB\';
  If Not DirectoryExists(LDadosCarteira.LPastaBancoDoBrasil) Then
    CreateDir(ExtractFilePath(LDadosCarteira.LPastaBancoDoBrasil));
end;

procedure TBancoDoBrasilAPI.CarregaOcorrenciasDeEncargosBancarios;
  Var
    lstCnfOco: TObjectList<TCnfOco>;
    objCnfOco: TCnfOco;
    objCnfDao: TCnfOcoDao;
    strOcoBco: String;
    strOcoLay: String;
    strNumPos: String;
    strOcoEsp: String;
    strOcoEmp: String;
    intOcoCar: Integer;
begin
  Try
    pDesmembraCarteira(LDadosCarteira.LCarteiraBanco + '-' + LDadosCarteira.LEmpresaCarteira,
                       strOcoBco, strOcoLay, strNumPos, strOcoEsp, strOcoEmp, intOcoCar);

    objCnfDao := TCnfOcoDao.Create(strOcoBco, strOcoLay, strNumPos,
                                   strOcoEsp, strOcoEmp, intOcoCar);

    lstCnfOco := objCnfDao.fBuscaTodas;
    If Assigned(lstCnfOco) Then
    Begin
      For objCnfOco in lstCnfOco Do
      Begin
        If fEmptyStr(LDadosCarteira.FOcorrenciasDeEncargo) Then
          LDadosCarteira.FOcorrenciasDeEncargo := '"'+objCnfOco.strCodOco+'"'
        Else
          LDadosCarteira.FOcorrenciasDeEncargo := LDadosCarteira.FOcorrenciasDeEncargo + ',"'+objCnfOco.strCodOco+'"';
      End;
    End;

  Finally
    If Assigned(lstCnfOco) Then
      FreeAndNil(lstCnfOco);

    If Assigned(objCnfDao) Then
      FreeAndNil(objCnfDao);
  End;
end;

function TBancoDoBrasilAPI.ConsultaBoletosPorPeriodo(ADataInicial,ADataFinal: String;
  AProgresso: TfrmGravando): TList<TRetornoPesquisaBancoDoBrasilApi>;
  Var
    LRetornoGet: WideString;
    LIndice    : String;

    LPagina: Integer;

    LPaginaFinal: Boolean;
    LJsonRetorno: TJSONObject;
    LDadosBoleto: TRetornoPesquisaBancoDoBrasilApi;
    Parametros  : TStringList;
    LJsonArrayBoletos: TJsonArray;
    LJsonBoleto : TJSONValue;
    IndSituacao : Integer;
    LStatus : Integer;
    LSituacao: String;
begin
  LPagina := 0;
  Try
    Result := TList<TRetornoPesquisaBancoDoBrasilApi>.Create;
    Parametros := TStringList.Create;
    LJsonRetorno := TJsonObject.Create;

    For IndSituacao := 0 To Length(INDICADOR_SITUACAO) - 1 Do
    Begin

      LPaginaFinal := False;
      LIndice := '';
      LSituacao := INDICADOR_SITUACAO[IndSituacao];

      While (Not LPaginaFinal) Do
      Begin

        Try
          AProgresso.lblGravando.Caption := 'Aguarde... Recebendo requisição ' + (LPagina + 1).ToString + ' da API.';
          Application.ProcessMessages;

          TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

          Parametros.Clear;
          Parametros.Delimiter := '&';
          AddParameterList(Parametros,'indicadorSituacao',LSituacao);
          AddParameterList(Parametros,'agenciaBeneficiario',LDadosCarteira.LAgencia);
          AddParameterList(Parametros,'contaBeneficiario',LDadosCarteira.LContaCorrente);

          AddParameterList(Parametros,'dataInicio'+RetornaPeriodo(LSituacao),ADataInicial);
          AddParameterList(Parametros,'dataFim'+RetornaPeriodo(LSituacao),ADataFinal);

          AddParameterList(Parametros,'indice',LIndice);

          LStatus := ExecutaRequisicao('GET',
                                       LDadosCarteira.LLinkConsulta + '&' + Parametros.DelimitedText,
                                       'Bearer ' + LDadosToken.AccessToken,
                                       LRetornoGet);

          If (LStatus = 404) Then
          Begin
            LPaginaFinal := True;
            Continue;
          End;

          ValidaStatusErro(LStatus, LRetornoGet);

          LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

          If (LJsonRetorno.GetValue<Integer>('quantidadeRegistros') > 0) Then
          Begin

            AProgresso.pgbStatus.Visible := True;
            AProgresso.pgbStatus.Properties.Max := LJsonRetorno.GetValue<Integer>('quantidadeRegistros');
            AProgresso.pgbStatus.Position := 0;

            LJsonArrayBoletos := LJsonRetorno.GetValue<TJSONArray>('boletos');

            For LJsonBoleto in LJsonArrayBoletos do
            begin

              LDadosBoleto := TRetornoPesquisaBancoDoBrasilApi.Create;
              LDadosBoleto.indicadorContinuidade   := LJsonRetorno.GetValue<String>('indicadorContinuidade');
              LDadosBoleto.quantidadeRegistros     := LJsonRetorno.GetValue<String>('quantidadeRegistros');
              LDadosBoleto.proximoIndice           := LJsonRetorno.GetValue<String>('proximoIndice');

              LDadosBoleto.BoletoNumeroBoletoBB              := LJsonBoleto.GetValue<String>('numeroBoletoBB');
              LDadosBoleto.BoletoEstadoTituloCobranca        := LJsonBoleto.GetValue<String>('estadoTituloCobranca');
              LDadosBoleto.BoletoDataRegistro                := LJsonBoleto.GetValue<String>('dataRegistro');
              LDadosBoleto.BoletoDataVencimento              := LJsonBoleto.GetValue<String>('dataVencimento');
              LDadosBoleto.BoletoValorOriginal               := LJsonBoleto.GetValue<String>('valorOriginal');
              LDadosBoleto.BoletoValorAtual                  := LJsonBoleto.GetValue<String>('valorAtual');
              LDadosBoleto.BoletoValorPago                   := LJsonBoleto.GetValue<String>('valorPago');
              LDadosBoleto.BoletoContrato                    := LJsonBoleto.GetValue<String>('contrato');
              LDadosBoleto.BoletoCarteiraConvenio            := LJsonBoleto.GetValue<String>('carteiraConvenio');
              LDadosBoleto.BoletoVariacaoCarteiraConvenio    := LJsonBoleto.GetValue<String>('variacaoCarteiraConvenio');
              LDadosBoleto.BoletoCodigoEstadoTituloCobranca  := LJsonBoleto.GetValue<String>('codigoEstadoTituloCobranca');

              RetornaDataCreditoMovimento(LJsonBoleto, LDadosBoleto);

              RetornaValorJurosDescontos(LDadosBoleto);

              If ImportarDetalhamento(LDadosBoleto) Then
                LDadosBoleto.FDetalhamento := RetornaDetalheBoleto(LDadosBoleto.BoletoNumeroBoletoBB);

              LDadosBoleto.NomeDoArquivo := Concat('[',LDadosBoleto.FDetalhamento.TipoDeCobranca,'] ',ADataInicial.Replace('.','/'),' - ',ADataFinal.Replace('.','/'));


              Result.Add(LDadosBoleto) ;
              Application.ProcessMessages;
              pStepStatusGravacao(AProgresso.pgbStatus);
            end;

          End;

          pTrimAppMemorySize;
          LPaginaFinal := (LJsonRetorno.GetValue<String>('indicadorContinuidade') <> 'S');

          If Not LPaginaFinal Then
            LIndice := LJsonRetorno.GetValue<String>('proximoIndice');

          Inc(LPagina);

        Except

          On E: Exception Do
          Begin
            If (Pos(C_ERRO_AUTENTICACAO_BB, E.Message) > 0) Then
              Raise Exception.Create(E.Message);

            Raise Exception.Create(RetornaTextoDoJsonDeErros(E.Message));
          End;

        End;
      End;

    End;

  Finally
    FreeAndNil(Parametros);
    FreeAndNil(LJsonRetorno);
  End;
end;


procedure TBancoDoBrasilAPI.ConsultaProximoNossoNumero;
  Var
    LRetornoGet: WideString;
    LIndice    : String;

    LPaginaFinal: Boolean;
    LJsonRetorno: TJSONObject;
    Parametros  : TStringList;
    LJsonArrayBoletos: TJsonArray;
    LJsonBoleto : TJSONValue;
    LDataInicial: String;
    LDataFinal: String;
    LStatus: Integer;
begin
  LPaginaFinal := False;
  Try
    Parametros := TStringList.Create;
    LProximoNossoNumero := '';


    While (Not LPaginaFinal) Do
    Begin

      Try
        Application.ProcessMessages;

        TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

        LDataInicial := RetornaUltimaDataDeRegistro;
        LDataFinal   := FormatDateTime('DD.MM.YYYY',VS_Date);

        Parametros.Clear;
        Parametros.Delimiter := '&';
        Parametros.Add(Concat('indicadorSituacao='   ,'A'));
        Parametros.Add(Concat('agenciaBeneficiario=' ,LDadosCarteira.LAgencia));
        Parametros.Add(Concat('contaBeneficiario='   ,LDadosCarteira.LContaCorrente));
        Parametros.Add(Concat('dataInicioRegistro=' ,LDataInicial));
        Parametros.Add(Concat('dataFimRegistro='    ,LDataFinal));

        If Not fEmptyStr(LIndice) And (StrToInt(LIndice) > 0) Then
          Parametros.Add(Concat('indice=',LIndice));

        LStatus := ExecutaRequisicao('GET',
                                     LDadosCarteira.LLinkConsulta + '&' + Parametros.DelimitedText,
                                     'Bearer ' + LDadosToken.AccessToken,
                                     LRetornoGet);


        If LStatus <> 200 Then
          Raise Exception.Create(RetornaErro(LStatus,LRetornoGet));

        LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

        If (LJsonRetorno.GetValue<Integer>('quantidadeRegistros') > 0) Then
        Begin

          LJsonArrayBoletos := LJsonRetorno.GetValue<TJSONArray>('boletos');

          For LJsonBoleto in LJsonArrayBoletos do
          begin
            LIndice := LJsonRetorno.GetValue<String>('proximoIndice');

            If StrToInt64Def(RightStr(LJsonBoleto.GetValue<String>('numeroBoletoBB'),10),0) > StrToInt64Def(LProximoNossoNumero,0) Then
              LProximoNossoNumero := RightStr(LJsonBoleto.GetValue<String>('numeroBoletoBB'),10);
          end;


          For LJsonBoleto in LJsonArrayBoletos do
          begin
            If StrToInt64Def(RightStr(LJsonBoleto.GetValue<String>('numeroBoletoBB'),10),0) > StrToInt64Def(LProximoNossoNumero,0) Then
              LProximoNossoNumero := RightStr(LJsonBoleto.GetValue<String>('numeroBoletoBB'),10);
          end;

        End;
        LPaginaFinal := (LJsonRetorno.GetValue<String>('indicadorContinuidade') <> 'S');
      Except

        On E: Exception Do
        Begin
          Self.FTentarNovamente := False;
          ExibeFormMensagemErro(E.Message);
          Exit;
        End;

      End;

    end;

    LProximoNossoNumero := IntToStr(StrToInt64(LProximoNossoNumero)+1);
    LProximoNossoNumero.PadLeft(10,'0');

  Finally
    FreeAndNil(Parametros);
  End;
end;

constructor TBancoDoBrasilAPI.Create(ACarteira: String);
begin
  CarregaDadosCarteira(ACarteira);
  CriarProtocoloSSL;
  CriarComponenteRequisicao;
  DefinirURL;
  ListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  LRetornoBandoDoBrasilAPI := TRetornoBoletoBancoDoBrasil.Create;
end;

procedure TBancoDoBrasilAPI.CriarComponenteRequisicao;
  Var
    LCaminhoDll : String;
begin
  LRequisicao := TIdHTTP.Create(Nil);
  LRequisicao.IOHandler := FProtocoloSSL;
  LRequisicao.Request.Connection := 'keep-alive';
  LRequisicao.Request.ContentType := 'application/json';
  LRequisicao.Response.KeepAlive := True;
  LRequisicao.HTTPOptions := [];
  LRequisicao.OnWork := OnWork;

  LRequisicao.HandleRedirects := True;

  LCaminhoDll := ExtractFilePath(Application.ExeName) + 'RestApiBoleto.dll';

  If fCfgSis('DLLBOL', varBoolean) Then
  Begin
    If Not FileExists(LCaminhoDll) Then
      Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

    FHandleRequisicoes := LoadLibrary(PChar(LCaminhoDll));
    RestExecute := GetProcAddress(FHandleRequisicoes, 'Execute');
  End;

  FHTTPSend :=THTTPSend.Create;
  FHTTPSend.MimeType  := 'application/json; charset=utf-8';
  FHTTPSend.UserAgent := 'Mozilla/4.0';
  FHTTPSend.Protocol  := '1.1';
  FHTTPSend.KeepAlive := True;

  FHTTPSend.Sock.SSL.SSLType:= LT_TLSv1_2;

  FHTTPSend.Sock.SetTimeout( 90000 );
  FHTTPSend.Sock.ConnectionTimeout   := 90000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 90000;
  FHTTPSend.Sock.SocksTimeout        := 90000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
  FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;
end;

procedure TBancoDoBrasilAPI.CriarProtocoloSSL;
begin
  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
  {$IF CompilerVersion <= 30.0}
  FProtocoloSSL.OnStatusInfoEx := TSNIBancoDoBrasilAPI.OnStatusInfoEx;
  {$IFEND}
end;

procedure TBancoDoBrasilAPI.DefinirURL;
begin
  LDadosCarteira.LLinkTokenAPI := IIF(LDadosCarteira.LHomologacao,C_URL_OAUTH_HOM, C_URL_OAUTH_PROD);
  LDadosCarteira.LLinkApi      := IIF(LDadosCarteira.LHomologacao,C_URL_HOM, C_URL);


  LDadosCarteira.LLinkInclusao          := Concat(LDadosCarteira.LLinkApi,'/boletos?gw-dev-app-key=',LDadosCarteira.LKeyUser);
  LDadosCarteira.LLinkConsulta          := Concat(LDadosCarteira.LLinkApi,'/boletos?gw-dev-app-key=',LDadosCarteira.LKeyUser);
  LDadosCarteira.LLinkBaixa             := Concat(LDadosCarteira.LLinkApi,'/boletos/[ID]/baixar?gw-dev-app-key=',LDadosCarteira.LKeyUser);
  LDadosCarteira.FLinkAlteracao         := Concat(LDadosCarteira.LLinkApi,'/boletos/[ID]?gw-dev-app-key=',LDadosCarteira.LKeyUser);
  LDadosCarteira.FLinkConsultaDetalhada := Concat(LDadosCarteira.LLinkApi,'/boletos/[NOSSO_NUMERO]?gw-dev-app-key=',LDadosCarteira.LKeyUser,'&numeroConvenio=[NUMERO_CONVENIO]');
  LDadosCarteira.FLinkConsultaPix       := Concat(LDadosCarteira.LLinkApi,'/boletos/[NOSSO_NUMERO]/pix?gw-dev-app-key=',LDadosCarteira.LKeyUser, '&numeroConvenio=[NUMERO_CONVENIO]');
  LDadosCarteira.FLinkGerarPix          := Concat(LDadosCarteira.LLinkApi,'/boletos/[NOSSO_NUMERO]/gerar-pix?gw-dev-app-key=',LDadosCarteira.LKeyUser);

end;

destructor TBancoDoBrasilAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;
  FreeAndNil(ListaRequisicaoRegistroBoleto);
  FreeAndNil(LRequisicao);
  FreeAndNil(FProtocoloSSL);
  FreeAndNil(LRetornoBandoDoBrasilAPI);
  FreeAndNil(FHTTPSend);

  If FHandleRequisicoes <> 0 Then
  Begin
    FHandleRequisicoes := 0;
    FreeLibrary(FHandleRequisicoes);
  End;
  inherited;
end;


{****************************************************************
 * FUNÇÃO CRIADA PARA ENCONTRAR DUPLICATAS GRAVADAS COM O CAMPO *
 * REG_DUPLIC INCORRETO                                         *
 *************************************************REQ: 242707*MT*}

function TBancoDoBrasilAPI.EncontrarJsonRegistroBoleto(AAutoIncrem: String): String;
  Var
    LRegBol : TUniQuery;
    LNosNumCadRec : String;
    LDtaVenCadRec : String;
    LJsonRetorno: TJSONObject;
begin
  Result := '';

  Try
    LRegBol := fCriaQuery(Nil);
    Try
      LRegBol.Close;
      LRegBol.Sql.Text := 'SELECT                             '+
                          '  REG_JSOENV,                      '+
                          '  REG_JSOREC                       '+
                          'FROM                               '+
                          '  REGBOL WHERE REG_CODBCO = "001"  '+
                          '  AND REG_EXCEPT IS NULL           '+
                          '  AND REG_JSOREC IS NOT NULL       '+
                          '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
                          'ORDER BY REG_DTAREG DESC,          '+
                          '  REG_HRAREG DESC                  ';
      LRegBol.Open;

      LNosNumCadRec := fCampoTabela('CTR_NOSNUM', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);
      LDtaVenCadRec := fCampoTabela('CTR_DTAVEN', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);

      LRegBol.First;
      While Not LRegBol.Eof Do
      Begin
        If LRegBol.FieldByName('REG_JSOENV').AsString.IsEmpty Then
        Begin
          LRegBol.Next;
          Continue;
        End;

        LJsonRetorno := TJSONObject.ParseJSONValue(LRegBol.FieldByName('REG_JSOENV').AsString) as TJSONObject;

        If RightStr(LJsonRetorno.GetValue<String>('numeroTituloCliente'),10).Equals(LNosNumCadRec) Then
        Begin
          If LJsonRetorno.GetValue<String>('dataVencimento').Equals(LDtaVenCadRec.Replace('/','.')) Then
          Begin
            Result := LRegBol.FieldByName('REG_JSOREC').AsString;
            Break;
          End;
        End;

        LRegBol.Next;
      End;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LRegBol);
    FreeAndNil(LJsonRetorno);
  End;

end;

function TBancoDoBrasilAPI.ExecutaRequisicao(const AMetodo, AUrl,
  AToken: WideString; out AJsonRetorno: WideString;
  AJsonEnvio: WideString): Integer;
  Var
    LFDataResp,
    LFDataReq: TMemoryStream;
begin
  Result := 0;

  FHTTPSend.Document.Clear;
  FHTTPSend.MimeType := 'application/json; charset=utf-8';

  If fCfgSis('DLLBOL', varBoolean) Then
  Begin
    Result := RestExecute(AMetodo,
                          AUrl,
                          AToken,
                          AJsonRetorno,
                          AJsonEnvio);

  End


  Else If Not fCfgSis('DLLBOL', varBoolean) Then
  Begin

    Try
      FHTTPSend.Headers.Clear;
      FHTTPSend.Headers.Add('Authorization: ' + AToken);
      FHTTPSend.Headers.Add('Accept: application/json');

      If Not fEmptyStr(AJsonEnvio) Then
      Begin
        Try
          LFDataReq := TMemoryStream.Create;
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(AJsonEnvio)));
          FHTTPSend.Document.LoadFromStream(LFDataReq);
        Finally
          FreeAndNil(LFDataReq);
        End;
      End;

      Application.ProcessMessages;

      If FHTTPSend.HTTPMethod(AMetodo, AUrl) Then
      Begin
        FHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(FHTTPSend.Document);

          LFDataResp.Position := 0;

          AJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
          Result :=  FHTTPSend.ResultCode;

        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
        AJsonRetorno := 'Falha na comunicação com o banco: ' + FHTTPSend.Sock.LastErrorDesc;


    Except
    On E:Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  End;

end;

procedure TBancoDoBrasilAPI.ExibeFormMensagemErro(AMensagem: String);
  Var
    LArqNaoGravados: TfrmArqNaoGravados;
begin
  Try
    pCriarFormularios(TfrmArqNaoGravados,LArqNaoGravados);
    LArqNaoGravados.Caption := 'AVISO';
    LArqNaoGravados.memResumo.WantReturns := True;
    LArqNaoGravados.memResumo.Lines.Add(AMensagem);
    LArqNaoGravados.ShowModal;
  Finally
    FreeAndNil(LArqNaoGravados);
  End;
end;

function TBancoDoBrasilAPI.RetornaTextoDoJsonDeErros(
  AErro: String): String;
  Var
    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LErroArray: String;
    LJsonErro: String;

    LErroInstabilidade,
    LErroAutenticacao,
    msgErro : String;
begin
  Result := AErro;
  LJsonErro := Copy(AErro,(Pos('Erro:',AErro) + 5),AErro.Length);
  msgErro := '';

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';
  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  Try
    LJsonObject := TJSONObject.ParseJSONValue(LJsonErro) As TJsonObject;

    If LJsonObject = Nil Then
    Begin

       // Verifica se é erro de authenticação - gerar token
       If (Pos(LErroAutenticacao, Result) > 0) Then
           Result := LErroAutenticacao
       Else
           Result := LErroInstabilidade;

       Exit;
    End;

    If LJsonObject.TryGetValue('errors', LJsonArray) Then
    Begin
      msgErro := '';
      For LJsonValue In LJsonArray Do
      Begin
        If (LJsonValue As TJsonObject).TryGetValue('message', LErroArray) Then
          msgErro := msgErro + LErroArray;
      End;

    End;

    If fEmptyStr(msgErro) Then
       msgErro := ExtrairMensagensErro(LJsonObject);

    If fEmptyStr(msgErro) Then
       If (Pos('NOSSO NÚMERO JÁ INCLUÍDO ANTERIORMENTE.',AnsiUpperCase(Result)) > 0) Then
           msgErro := 'Nosso número já incluído anteriormente.';

    If fEmptyStr(msgErro) Then
       Result := LErroInstabilidade
    Else
       Result := msgErro;

    FreeAndNil(LJsonObject);
  Except
    Result := LErroInstabilidade;
  End;
end;

Function TBancoDoBrasilAPI.ExtrairMensagensErro(const LJsonObject: TJsonObject): String;
Var
  LJsonArray: TJSONArray;
  LJsonValue: TJsonValue;
  LErroObj: TJsonObject;
  LMensagem: String;
Begin
  Result := '';
  If LJsonObject.TryGetValue('erros', LJsonArray) Then
  Begin
    For LJsonValue in LJsonArray Do
    Begin
      If LJsonValue IS TJsonObject Then
      Begin
        LErroObj := TJsonObject(LJsonValue);
        If LErroObj.TryGetValue('mensagem', LMensagem) Then
           Result := Result + LMensagem + sLineBreak;
      End;
    End;
  End;
End;

function TBancoDoBrasilAPI.FormataAutorizacao(AAutorizacao: String): String;
begin
  Result := AAutorizacao;

  If Trim(LeftStr(AAutorizacao,5)) <> 'Basic' Then
    Result := 'Basic ' + AAutorizacao;
end;

function TBancoDoBrasilAPI.RetornaPixBoleto(ANossoNumero,Autoincrem: String): String;
  Var
    LRetornoPost: WideString;
    LDadosRequisicao: String;
    LRequisicaoAlteraBoleto : TRequisicaoRegistroBoleto;
    LStatus: Integer;
begin
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoAlteraBoleto.LCodBco := '001';
  LRequisicaoAlteraBoleto.FDescricao := 'GERAR PIX';
  LRequisicaoAlteraBoleto.LLocImp := IIF(Self.LFaturamento,'FAT','CTR');

  LDadosRequisicao := RetornaDadosDaRequisicaoGerarPix;
  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := Autoincrem;
  LRequisicaoAlteraBoleto.LLnkApi := RetornaLinkGerarPix(ANossoNumero);

  Try
    Try
      TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

      LStatus := ExecutaRequisicao('POST',
                                   RetornaLinkGerarPix(ANossoNumero),
                                   'Bearer ' + LDadosToken.AccessToken,
                                   LRetornoPost,
                                   LDadosRequisicao);


      If LStatus <> 200 Then
        Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPost);


      LRequisicaoAlteraBoleto.LJsoRec := LRetornoPost;
      Result := LRetornoPost;
    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Begin
      ListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
    End;
  End;
End;

procedure TBancoDoBrasilAPI.GerarPixBoleto(ADataSet: TDataSet);
  Var
    LRetornoPost: WideString;
    LDadosRequisicao: String;
    LJsonRetorno: TJSONObject;
    LRequisicaoAlteraBoleto : TRequisicaoRegistroBoleto;
    LStatus: Integer;
    LDadosPix : TRetornoBoletoBancoDoBrasil;
begin
  Self.FTentarNovamente := True;
  LRequisicaoAlteraBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoAlteraBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoAlteraBoleto.LCodBco := '001';
  LRequisicaoAlteraBoleto.FDescricao := 'GERAR PIX';
  LRequisicaoAlteraBoleto.LLocImp := IIF(Self.LFaturamento,'FAT','CTR');

  LDadosRequisicao := RetornaDadosDaRequisicaoGerarPix;
  LRequisicaoAlteraBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoAlteraBoleto.LDuplic := ADataSet.FieldByName('AUTOINCREM').AsString;
  LRequisicaoAlteraBoleto.LLnkApi := RetornaLinkGerarPix(ADataSet.FieldByName('CTR_NOSNUM').AsString);

  Try
    Try
      TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

      LStatus := ExecutaRequisicao('POST',
                                   RetornaLinkGerarPix(ADataSet.FieldByName('CTR_NOSNUM').AsString),
                                   'Bearer ' + LDadosToken.AccessToken,
                                   LRetornoPost,
                                   LDadosRequisicao);


      If LStatus <> 200 Then
        Raise Exception.Create('Status: ' + LStatus.ToString + ' Erro: ' + LRetornoPost);

      Self.FTentarNovamente := False;

      LRequisicaoAlteraBoleto.LJsoRec := LRetornoPost;
      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPost) as TJSONObject;
      LDadosPix := TRetornoBoletoBancoDoBrasil.Create;

      {QrCode}
      LJsonRetorno := LJsonRetorno.GetValue('qrCode') as TJSONObject;
      If Assigned(LJsonRetorno) Then
      Begin
        LDadosPix.QrCodeUrl  :=  RetornaValorJson(LJsonRetorno,'url');
        LDadosPix.QrCodeTxId :=  RetornaValorJson(LJsonRetorno,'txId');
        LDadosPix.QrCodeEmv  :=  RetornaValorJson(LJsonRetorno,'emv');


        If Not fEmptyStr(ADataSet.FieldByName('CTR_LNKCIT').AsString) Then
          TFuncoesPixBoleto.RemoverLinkCitelPixBoleto(fRetCGCEmpresa(ADataSet.FieldByName('CTR_CODEMP').AsString),
                                                      ADataSet.FieldByName('CTR_CODEMP').AsString,
                                                      ADataSet.FieldByName('CTR_TX_BOL').AsString,
                                                      LDadosCarteira.LAutoIncremChavePix,
                                                      True);

        LDadosPix.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('001',
                                                                                 LDadosPix.QrCodeTxId,
                                                                                 LDadosPix.QrCodeEmv,
                                                                                 FormatFloat(',0.00', RetornaValorDuplicata(ADataSet)),
                                                                                 LDadosCarteira.LAutoIncremChavePix,
                                                                                 IncDay(ADataSet.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                        StrToIntDef(LDadosCarteira.LQtdDiasLimitePagto, 0)) + StrToTime('23:59:59'));

        AtualizaPixBoleto(ADataSet.FieldByName('AUTOINCREM').AsString,
                          LDadosPix.QrCodeTxId,
                          LDadosPix.QrCodeEmv,
                          LDadosPix.QrCodeUrl,
                          LDadosPix.QrCodeLinkCitel);

        untLogCtr.GravaLogCtr(ADataSet.FieldByName('AUTOINCREM').AsString,
                             'GEROU QRCODE PIX BOLETO - BANCO DO BRASIL [ONLINE]' ,
                             'TBancoDoBrasilAPI');
      End;



    Except
      On E: Exception Do
      Begin
        LRequisicaoAlteraBoleto.LExcept := E.Message;
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Begin
      ListaRequisicaoRegistroBoleto.Add(LRequisicaoAlteraBoleto);
      FreeAndNil(LJsonRetorno);
      FreeAndNil(LDadosPix);
    End;
  End;
End;

procedure TBancoDoBrasilAPI.GerarToken;
  Var
    LRequisicao: TidHTTP;
    LParametros: TStringList;
    LResposta: String;
    LJsonObject: TJSONObject;
begin

  If Not fCfgSis('DLLBOL', varBoolean) Then
  Begin
    GerarTokenSynalist;
  End;

  If Assigned(LDadosToken) Then
  Begin
    If Not LDadosToken.RefreshToken Then
    Begin
      Exit;
    End;
    FreeAndNil(LDadosToken);
  End;

  Try
    Try
      LDadosToken := TDadosToken.Create;
      LParametros := TStringList.Create;
      LParametros.Add('grant_type=client_credentials');
      LParametros.Add('scope=cobrancas.boletos-info cobrancas.boletos-requisicao');

      LRequisicao := TIdHTTP.Create(Nil);
      LRequisicao.OnWork := OnWork;
      LRequisicao.IOHandler := FProtocoloSSL;
      LRequisicao.Request.ContentType := 'application/x-www-form-urlencoded';

      LRequisicao.Request.CustomHeaders.Add('Authorization: ' + FormataAutorizacao(LDadosCarteira.LAuthorization));

      Application.ProcessMessages;

      LResposta := LRequisicao.Post(LDadosCarteira.LLinkTokenAPI, LParametros);

      LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
      LDadosToken.Access_Token := LJsonObject.GetValue<String>('access_token');;
      LDadosToken.Expiracao    := LJsonObject.GetValue<Integer>('expires_in');
      LDadosToken.RefreshTime  := IncSecond(fNow, LJsonObject.GetValue<Integer>('expires_in'));

      LDadosToken.RefreshTime  := IncMinute(LDadosToken.RefreshTime,-2);
    Finally
      If Assigned(LParametros) Then
        FreeAndNil(LRequisicao);

      If Assigned(LParametros) Then
        FreeAndNil(LParametros);

      If Assigned(LJsonObject) Then
        FreeAndNil(LJsonObject);
    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      LDadosToken.Exception :=  'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                IIF(LDadosCarteira.LHomologacao,'HOMOLOGAÇÃO', 'PRODUÇÃO') + '.' + ' Erro:' +
                                IIF(Pos('<HTML', UpperCase(E.ErrorMessage)) > 0, E.Message, E.ErrorMessage);
    End;

    On E: Exception Do
    Begin
      LDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                IIF(LDadosCarteira.LHomologacao,'HOMOLOGAÇÃO', 'PRODUÇÃO') + '.' + ' Erro:' + E.Message;
    End;

  End;
end;

procedure TBancoDoBrasilAPI.GerarTokenSynalist;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp,
    LFDataReq: TMemoryStream;

    LResposta,
    LDadosRequisicao: String;
    LJsonObject: TJSONObject;
begin

  If Assigned(LDadosToken) Then
  Begin
    If Not LDadosToken.RefreshToken Then
    Begin
      Exit;
    End;
    FreeAndNil(LDadosToken);
  End;

  LHTTPSend := THTTPSend.Create;
  LDadosToken := TDadosToken.Create;

  Try
    LHTTPSend.MimeType  := 'application/x-www-form-urlencoded';
    LHTTPSend.Protocol  := '1.1';

    LHTTPSend.Sock.SSL.SSLType:= LT_all;

    LHTTPSend.Sock.SetTimeout( 90000 );
    LHTTPSend.Sock.ConnectionTimeout   := 90000;
    LHTTPSend.Sock.InterPacketTimeout  := False;
    LHTTPSend.Sock.NonblockSendTimeout := 90000;
    LHTTPSend.Sock.SocksTimeout        := 90000;
    LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

    Try
      LDadosRequisicao := 'grant_type=client_credentials&' +
                          'scope=cobrancas.boletos-info cobrancas.boletos-requisicao';

      LHTTPSend.Headers.Clear;
      LHTTPSend.Headers.Add('Authorization: ' + FormataAutorizacao(LDadosCarteira.LAuthorization));

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If LHTTPSend.HTTPMethod('POST', LDadosCarteira.LLinkTokenAPI) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          If LHTTPSend.ResultCode <> 200 Then
          Begin
            Raise Exception.Create(LHTTPSend.ResultCode.ToString + ' - ' +
                                   LResposta);
          End;

          LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
          LDadosToken.Access_Token := LJsonObject.GetValue<String>('access_token');;
          LDadosToken.Expiracao    := LJsonObject.GetValue<Integer>('expires_in');
          LDadosToken.RefreshTime  := IncSecond(fNow, LJsonObject.GetValue<Integer>('expires_in'));

          LDadosToken.RefreshTime  := IncMinute(LDadosToken.RefreshTime,-2);
        Finally
          FreeAndNil(LFDataResp);

          If Assigned(LJsonObject) Then
            FreeAndNil(LJsonObject);
        End;

      End

    Except
      On E:EIdHTTPProtocolException Do
      Begin
        LDadosToken.Exception :=  'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                                  'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                  IIF(LDadosCarteira.LHomologacao,'HOMOLOGAÇÃO', 'PRODUÇÃO') + '.' + ' Erro:' + E.ErrorMessage;
      End;

      On E: Exception Do
      Begin
        LDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                  IIF(LDadosCarteira.LHomologacao,'HOMOLOGAÇÃO', 'PRODUÇÃO') + '.' + ' Erro:' + E.Message;
      End;
    End;
  Finally
    FreeAndNil(LHTTPSend);
  End;
end;

procedure TBancoDoBrasilAPI.GravarDadosRequisicaoRegistroBoleto;
  Var
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
begin
  If Assigned(ListaRequisicaoRegistroBoleto) Then
  Begin
    If ListaRequisicaoRegistroBoleto.Count > 0 Then
    Begin
      // GRAVA DADOS DAS REQUISIÇÕES
      For LRequisicaoRegistroBoleto In ListaRequisicaoRegistroBoleto Do
      Begin
        TRegBol.GravarRequisicaoReqistroBoleto(LRequisicaoRegistroBoleto);
      End;

      ListaRequisicaoRegistroBoleto.Clear;
    End;
  End;
end;

function TBancoDoBrasilAPI.ImportarDetalhamento(
  ADadosBoleto: TRetornoPesquisaBancoDoBrasilApi): Boolean;
begin
  Result := False;

  If fStrToFloat(ADadosBoleto.BoletoValorPago) > 0 Then
    Exit(True);

  If Pos(ADadosBoleto.BoletoCodigoEstadoTituloCobranca, LDadosCarteira.FOcorrenciasDeEncargo) > 0 Then
    Exit(True);

end;

function TBancoDoBrasilAPI.NossoNumeroDuplicado(AErro: String): Boolean;
begin
  Result := (Pos('NOSSO NÚMERO JÁ INCLUÍDO ANTERIORMENTE.',AnsiUpperCase(AErro)) > 0);
end;

procedure TBancoDoBrasilAPI.OnWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;


procedure TBancoDoBrasilAPI.ReimpressaoDeBoleto(AAutoIncrem: String);
  Var
    LJsonRetorno: TJSONObject;
    LJsonObjectGroup: TJsonObject;
    LJsonRegistro: String;
    LCadRec: TUniQuery;
begin
  Try
    LRetornoBandoDoBrasilAPI := TRetornoBoletoBancoDoBrasil.Create;
    Try
      LJsonRegistro := RetornaJsonRegistroBoleto(AAutoIncrem);

      If fEmptyStr(LJsonRegistro) Then
      Begin

        LCadRec := fCriaQuery(Nil);
        LCadRec.Close;
        LCadRec.SQL.Clear;
        LCadRec.SQL.Add('SELECT CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE, CTR_LINDIG ' +
                        'FROM CADREC WHERE AUTOINCREM = :AUTOINC');

        LCadRec.ParamByName('AUTOINC').AsString := AAutoIncrem;
        LCadRec.Open;

        LRetornoBandoDoBrasilAPI.nossoNumero               := RetornaCampoNossoNumero(LCadRec.FieldByName('CTR_NOSNUM').AsString);
        LRetornoBandoDoBrasilAPI.BeneficiarioAgencia       := LDadosCarteira.LAgencia;
        LRetornoBandoDoBrasilAPI.BeneficiarioContaCorrente := LDadosCarteira.LContaCorrente;
        LRetornoBandoDoBrasilAPI.QrCodeTxId                := LCadRec.FieldByName('CTR_TX_BOL').AsString;
        LRetornoBandoDoBrasilAPI.QrCodeEmv                 := LCadRec.FieldByName('CTR_QRCODE').AsString;
        LRetornoBandoDoBrasilAPI.linhaDigitavel            := LCadRec.FieldByName('CTR_LINDIG').AsString;
        LRetornoBandoDoBrasilAPI.codigoDeBarras            := Copy(LRetornoBandoDoBrasilAPI.linhaDigitavel, 01, 04) +
                                                              Copy(LRetornoBandoDoBrasilAPI.linhaDigitavel, 33, 15) +
                                                              Copy(LRetornoBandoDoBrasilAPI.linhaDigitavel, 05, 05) +
                                                              Copy(LRetornoBandoDoBrasilAPI.linhaDigitavel, 11, 08) +
                                                              Copy(LRetornoBandoDoBrasilAPI.linhaDigitavel, 19, 02) +
                                                              Copy(LRetornoBandoDoBrasilAPI.linhaDigitavel, 22, 10);

        Exit;
      End;

      LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRegistro) as TJSONObject;

      LRetornoBandoDoBrasilAPI.nossoNumero    := RetornaValorJson(LJsonRetorno,'numero');
      LRetornoBandoDoBrasilAPI.linhaDigitavel := RetornaValorJson(LJsonRetorno,'linhaDigitavel');
      LRetornoBandoDoBrasilAPI.codigoDeBarras := RetornaValorJson(LJsonRetorno,'codigoBarraNumerico');

      {Beneficiairo}
      LJsonObjectGroup := LJsonRetorno.GetValue('beneficiario') as TJSONObject;
      If Assigned(LJsonObjectGroup) Then
      Begin
        LRetornoBandoDoBrasilAPI.BeneficiarioAgencia              :=  RetornaValorJson(LJsonObjectGroup,'agencia');
        LRetornoBandoDoBrasilAPI.BeneficiarioContaCorrente        :=  RetornaValorJson(LJsonObjectGroup,'contaCorrente');
        LRetornoBandoDoBrasilAPI.BeneficiarioTipoEndereco         :=  RetornaValorJson(LJsonObjectGroup,'tipoEndereco');
        LRetornoBandoDoBrasilAPI.BeneficiarioLogradouro           :=  RetornaValorJson(LJsonObjectGroup,'logradouro');
        LRetornoBandoDoBrasilAPI.BeneficiarioBairro               :=  RetornaValorJson(LJsonObjectGroup,'bairro');
        LRetornoBandoDoBrasilAPI.BeneficiarioCidade               :=  RetornaValorJson(LJsonObjectGroup,'cidade');
        LRetornoBandoDoBrasilAPI.BeneficiarioCodigoCidade         :=  RetornaValorJson(LJsonObjectGroup,'codigoCidade');
        LRetornoBandoDoBrasilAPI.BeneficiarioUf                   :=  RetornaValorJson(LJsonObjectGroup,'uf');
        LRetornoBandoDoBrasilAPI.BeneficiarioCep                  :=  RetornaValorJson(LJsonObjectGroup,'cep');
        LRetornoBandoDoBrasilAPI.BeneficiarioIndicadorComprovacao :=  RetornaValorJson(LJsonObjectGroup,'indicadorComprovacao');
      End;
      {QrCode}
      LJsonObjectGroup := LJsonRetorno.GetValue('qrCode') as TJSONObject;
      If Assigned(LJsonObjectGroup) Then
      Begin
        LRetornoBandoDoBrasilAPI.QrCodeUrl  :=  RetornaValorJson(LJsonObjectGroup,'url');
        LRetornoBandoDoBrasilAPI.QrCodeTxId :=  RetornaValorJson(LJsonObjectGroup,'txId');
        LRetornoBandoDoBrasilAPI.QrCodeEmv  :=  RetornaValorJson(LJsonObjectGroup,'emv');
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LJsonRetorno) Then
      FreeAndNil(LJsonRetorno);

    If Assigned(LCadRec) Then
      FreeAndNil(LCadRec);
  End;
end;
function TBancoDoBrasilAPI.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

function TBancoDoBrasilAPI.RetornaCampoNossoNumero(ANosNum: String): String;
begin
  Result := fPadL('000'                    , 003)      +
            fPadL(LDadosCarteira.LConvenio , 007, '0') +
            fPadL(ANosNum                  , 010, '0') ;
end;

function TBancoDoBrasilAPI.RetornaDadosDaRequisicao(ADadosDuplicata,ADadosCliente: TDataset; ANosNum: String): String;
  Var
    Json: TJSONObject;
begin
  Json := TJsonObject.Create;

  try
    Json.AddPair('numeroConvenio'                           ,StrToInt64Def(LDadosCarteira.LConvenio,0).ToString);
    Json.AddPair('numeroCarteira'                           ,StrToIntDef(LDadosCarteira.LCodCarteira,0).ToString);
    Json.AddPair('numeroVariacaoCarteira'                   ,StrToIntDef(LDadosCarteira.LVariacaoCarteira,0).ToString);
    Json.AddPair('codigoModalidade'                         ,IIF(fEmptyStr(LDadosCarteira.LTipoCobranca),'1',LeftStr(LDadosCarteira.LTipoCobranca,1)));
    Json.AddPair('dataEmissao'                              ,FormatDateTime('DD.MM.YYYY', ADadosDuplicata.FieldByName('CTR_DTACAD').AsDateTime));
    Json.AddPair('dataVencimento'                           ,FormatDateTime('DD.MM.YYYY', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));
    Json.AddPair('valorOriginal'                            ,RetornaCampoDecimalJSON(RetornaValorDuplicata(ADadosDuplicata).ToString()));
    Json.AddPair('valorAbatimento'                          ,'0.00');
    Json.AddPair('quantidadeDiasProtesto'                   ,Trunc(StrToIntDef(LDadosCarteira.LQtdDiasProtesto,0)).ToString);
    Json.AddPair('indicadorAceiteTituloVencido'             ,IIF((StrToIntDef(LDadosCarteira.LQtdDiasLimitePagto,0) > 0),'S','N'));
    Json.AddPair('numeroDiasLimiteRecebimento'              ,Trunc(StrToIntDef(LDadosCarteira.LQtdDiasLimitePagto,0)).ToString);
    Json.AddPair('codigoAceite'                             ,IIF(LDadosCarteira.LAceite = 'S', 'A', 'N'));
    Json.AddPair('codigoTipoTitulo'                         ,'02');
    Json.AddPair('descricaoTipoTitulo'                      ,'DM');
    Json.AddPair('indicadorPermissaoRecebimentoParcial'     ,'N');
    Json.AddPair('numeroTituloBeneficiario'                 ,Copy(Trim(UpperCase(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString +
                                                                                 ADadosDuplicata.FieldByName('CTR_PARCEL').AsString)),0,15));
    Json.AddPair('numeroTituloCliente'                      ,RetornaCampoNossoNumero(ANosNum));
    Json.AddPair('mensagemBloquetoOcorrencia'               ,RetornaValorString(UpperCase(Copy(Trim(LDadosCarteira.LObservacao1 +' '+LDadosCarteira.LObservacao2 +' '+
                                                                                                    LDadosCarteira.LObservacao3 +' '+LDadosCarteira.LObservacao4 +' '+
                                                                                                    LDadosCarteira.LObservacao5),0,165))));
    If UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) then
    Begin
      Json.AddPair('desconto',  RetornaDescontoPontualidade(ADadosDuplicata));
      If (ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0) Then
        Json.AddPair('segundoDesconto',  RetornaSegundoDesconto(ADadosDuplicata));
    End
    Else
      Json.AddPair('desconto',  RetornaDesconto(ADadosDuplicata));

    Json.AddPair('jurosMora',  RetornaJurosMora(ADadosDuplicata));
    Json.AddPair('multa'    ,  RetornaMulta(ADadosDuplicata));
    Json.AddPair('pagador'  ,  RetornaPagador(ADadosCliente));

    if (StrToIntDef(LDadosCarteira.LQtdDiasNegativacao,0) > 0) then
    begin
      Json.AddPair('quantidadeDiasNegativacao'           ,LDadosCarteira.LQtdDiasNegativacao);
      Json.AddPair('orgaoNegativador'                    ,LeftStr(LDadosCarteira.LOrgaoNegativador,2)) ;
    end;

    Json.AddPair('indicadorPix', LDadosCarteira.LGerarQRCodePix);

    Result := PrettyJSON(Json.ToString);

  Finally
    FreeAndNil(Json);
  End;
end;

function TBancoDoBrasilAPI.RetornaDadosDaRequisicaoAlteracao(ADadosDuplicata: TDataSet): String;
  Var
    Json: TJSONObject;
begin

  Try
    Json  := TJsonObject.Create;
    Json.AddPair('numeroConvenio',StrToInt64Def(LDadosCarteira.LConvenio,0).ToString);

    If AlteracaoSelecionada('Vencimento') Then
      If (ADadosDuplicata.FieldByName('VENCIMENTO_REGISTRADO').AsDateTime <>
          ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime) Then
      Begin
        Json.AddPair('indicadorNovaDataVencimento','S');
        Json.AddPair('alteracaoData'              ,RetornaNovaDataVencimento(ADadosDuplicata));
      End;


    If AlteracaoSelecionada('Endereço do Pagador') Then
      If ADadosDuplicata.FieldByName('ENDERECO_PAGADOR_REGISTRADO').AsString <>
         ADadosDuplicata.FieldByName('ENDERECO_ATUAL_PAGADOR').AsString  Then
      Begin
        Json.AddPair('indicadorAlterarEnderecoPagador', 'S');
        Json.AddPair('alteracaoEndereco', RetornaNovoEnderecoPagador(ADadosDuplicata));
      End;

    If AlteracaoSelecionada('Prazo para recebimento de boleto vencido') Then
      If (ADadosDuplicata.FieldByName('QTD_DIAS_RECEBIMENTO_APOS_VENCIMENTO_REGISTRADO').AsString <>
          LDadosCarteira.QtdDiasLimitePagto) Then
      Begin
        Json.AddPair('indicadorAlterarPrazoBoletoVencido', 'S');
        Json.AddPair('alteracaoPrazo', RetornaNovaQuantidadeDiasRecebimentoAposVencimento);
      End;

    Result := PrettyJSON(Json.ToString);

  Finally
    FreeAndNil(Json);
  End;
end;

function TBancoDoBrasilAPI.RetornaDadosDaRequisicaoBaixa: String;
  Var
    Json: TJSONObject;
begin
  Json := TJsonObject.Create;
  Try
    Json.AddPair('numeroConvenio',StrToInt64Def(LDadosCarteira.LConvenio,0).ToString);
    Result := PrettyJSON(Json.ToString);
  Finally
    FreeAndNil(Json);
  End;

end;

function TBancoDoBrasilAPI.RetornaDadosDaRequisicaoGerarPix: String;
  Var
    Json: TJSONObject;
begin
  Json := TJsonObject.Create;
  Try
    Json.AddPair('numeroConvenio',StrToInt64Def(LDadosCarteira.LConvenio,0).ToString);
    Result := PrettyJSON(Json.ToString);
  Finally
    FreeAndNil(Json);
  End;
end;

procedure TBancoDoBrasilAPI.RetornaDadosPagamentoPixBoleto(
  ADadosBoleto: TRetornoPesquisaBancoDoBrasilApi);
  Var
    LRetornoGet: WideString;

    LDadosTexto: String;

    LJsonRetorno,
    LJsonPix: TJSONObject;

    LStatus: Integer;
begin
  Try
    Try
      TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

      LStatus := ExecutaRequisicao('GET',
                                   LDadosCarteira.FLinkConsultaPix.Replace('[NOSSO_NUMERO]', ADadosBoleto.BoletoNumeroBoletoBB)
                                                                  .Replace('[NUMERO_CONVENIO]', LDadosCarteira.LConvenio),
                                   'Bearer ' + LDadosToken.AccessToken,
                                   LRetornoGet);

      If (LStatus = 404) Then
        Exit;

      If LStatus <> 200 Then
        Raise Exception.Create(LRetornoGet);

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

      ADadosBoleto.FDetalhamento.qrCodeURL   := RetornaValorJson(LJsonRetorno,'qrCode.url');
      ADadosBoleto.FDetalhamento.qrCodeTxId  := RetornaValorJson(LJsonRetorno,'qrCode.txId');
      ADadosBoleto.FDetalhamento.qrCodeEmv   := RetornaValorJson(LJsonRetorno,'qrCode.emv');


      If LJsonRetorno.GetValue('pix') <> Nil Then
      Begin
        LJsonPix := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue<string>('pix')) as TJSONObject;
        LDadosTexto := LJsonPix.GetValue<String>('textoRetorno');
        ADadosBoleto.FDetalhamento.EndToEndID := LDadosTexto;
      End;


      If LJsonRetorno.GetValue('qrCode') <> Nil Then
      Begin
        LJsonPix := TJSONObject.ParseJSONValue(LJsonRetorno.GetValue<string>('qrCode')) as TJSONObject;
        ADadosBoleto.FDetalhamento.qrCodeURL   := RetornaValorJson(LJsonPix,'url');
        ADadosBoleto.FDetalhamento.qrCodeTxId  := RetornaValorJson(LJsonPix,'txId');
        ADadosBoleto.FDetalhamento.qrCodeEmv   := RetornaValorJson(LJsonPix,'emv');
      End;

    Except

      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;

    End;
  Finally
    If Assigned(LJsonRetorno) Then
      FreeAndNil(LJsonRetorno);

    If Assigned(LJsonPix) Then
      FreeAndNil(LJsonPix);
  End;
end;

procedure TBancoDoBrasilAPI.RetornaDataCreditoMovimento(
  AJsonBoleto: TJsonValue; var ADadosBoleto: TRetornoPesquisaBancoDoBrasilApi);
begin
  If MatchStr(AJsonBoleto.GetValue<String>('codigoEstadoTituloCobranca').PadLeft(2,'0'), ['06','12']) Then
  Begin
    ADadosBoleto.BoletoDataCredito                 := AJsonBoleto.GetValue<String>('dataCredito');
    ADadosBoleto.BoletoDataMovimento               := AJsonBoleto.GetValue<String>('dataMovimento');
  End;
end;

function TBancoDoBrasilAPI.PrettyJSON(JsonString:String):String;
  Var
    Jdoc:TJSONObject;
begin
  Try
    Jdoc:=TJSONObject.ParseJSONValue(JsonString) as TJSONObject;
    result:=TJSON.Format(Jdoc);
  Finally
    FreeAndNil(Jdoc);
  End;
end;


function TBancoDoBrasilAPI.RetornaDesconto(ADadosDuplicata : TDataSet): TJsonObject;
  var
    LDataExpiracao : TDateTime;
begin
  Result := TJSONObject.Create;

  If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
  Begin
    LDataExpiracao := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -  ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

    Result.AddPair('tipo'             ,'1'); //Valor fixo por dia de atraso
    Result.AddPair('dataExpiracao'    ,FormatDateTime('DD.MM.YYYY', LDataExpiracao));
    Result.AddPair('valor'            ,RetornaCampoDecimalJSON(fFormataFloat(ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat,2).ToString));
  End
  Else
  Begin
    Result.AddPair('tipo'  ,'0');// 0 - Dispensar;
  End;

End;

function TBancoDoBrasilAPI.RetornaJsonRegistroBoleto(AAutoIncrem: String): String;
  Var
    LRegBol : TUniQuery;
    LSql: String;
begin
  LRegBol := fCriaQuery(Nil);

  Try
    LSql := 'SELECT                        '+
            '  REG_JSOREC                  '+
            'FROM                          '+
            '  REGBOL                      '+
            'WHERE REG_DUPLIC = :DUPLIC    '+
            '  AND REG_EXCEPT IS NULL      '+
            '  AND REG_JSOREC IS NOT NULL  '+
            '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
            'ORDER BY REG_DTAREG DESC,     '+
            '  REG_HRAREG DESC             ';
    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;
      Result := LRegBol.FieldByName('REG_JSOREC').AsString;

      If fEmptyStr(Result) Or (LRegBol.RecordCount > 1) Then
      Begin
        Result := EncontrarJsonRegistroBoleto(AAutoIncrem);
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
  End;
end;

function TBancoDoBrasilAPI.RetornaJurosMora(ADadosDuplicata: TDataSet): TJsonObject;
  Var
    LValorMora : Double;
begin
  Result := TJSONObject.Create;
  LValorMora := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (Self.LPercentualMora/100), 2);

  If (LValorMora > 0) Then
  Begin
    Result.AddPair('tipo'    ,'1'); //Valor fixo por dia de atraso
    Result.AddPair('data'    ,FormatDateTime('DD.MM.YYYY', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)));
    Result.AddPair('valor'   ,RetornaCampoDecimalJSON(LValorMora.ToString));
  End
  Else
  Begin
    Result.AddPair('tipo'    ,'0'); // 0 - Dispensar
  End;
end;

function TBancoDoBrasilAPI.RetornaLinkAlteracao(
  ADadosDuplicata: TDataSet): String;
begin
  Result := StringReplace(LDadosCarteira.FLinkAlteracao, '[ID]', RetornaCampoNossoNumero(ADadosDuplicata.FieldByName('CTR_NOSNUM').AsString), [rfReplaceAll]);
end;

function TBancoDoBrasilAPI.RetornaLinkBaixa(ANosNum: String): String;
begin
  Result := StringReplace(LDadosCarteira.LLinkBaixa, '[ID]', RetornaCampoNossoNumero(ANosNum), [rfReplaceAll]);
end;

function TBancoDoBrasilAPI.RetornaLinkConsultaDetalhada(ANosNum: String): String;
  Var
    LConvenio : String;
begin
  Result := StringReplace(LDadosCarteira.FLinkConsultaDetalhada, '[NOSSO_NUMERO]', ANosNum, [rfReplaceAll]);

  LConvenio := Copy(ANosNum,4,7);
  Result := StringReplace(Result, '[NUMERO_CONVENIO]',LConvenio, [rfReplaceAll]);
end;

function TBancoDoBrasilAPI.RetornaLinkGerarPix(ANosNum: String): String;
begin
  Result := StringReplace(LDadosCarteira.FLinkGerarPix, '[NOSSO_NUMERO]', RetornaCampoNossoNumero(ANosNum), [rfReplaceAll]);
end;

function TBancoDoBrasilAPI.RetornaDescontoPontualidade(ADadosDuplicata : TDataSet):TJsonObject;
  Var
    LValorCorrigido: Double;
    LDataExpiracao : TDateTime;
begin
  Result := TJSONObject.Create;
  LValorCorrigido := (ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * ( ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat / 100.00));
  LDataExpiracao  := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime - ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

  Result.AddPair('tipo','1');
  Result.AddPair('dataExpiracao', FormatDateTime('DD.MM.YYYY', LDataExpiracao));
  Result.AddPair('valor', RetornaCampoDecimalJSON(fFormataFloat(LValorCorrigido,2).ToString));
end;

function TBancoDoBrasilAPI.RetornaDetalheBoleto(ANossoNumero: String): TDetalhamento;
  Var
    LRetornoGet: WideString;
    LJsonRetorno: TJSONObject;
    LStatus: Integer;
Begin
  Try
    Try
      If LDadosToken.RefreshToken Then
        TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');

      LStatus := ExecutaRequisicao('GET',
                                   RetornaLinkConsultaDetalhada(ANossoNumero),
                                   'Bearer ' + LDadosToken.AccessToken,
                                   LRetornoGet);

      If LStatus <> 200 Then
        Exit;

      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;

      Result.ValorPago      :=  RetornaValorJson(LJsonRetorno,'valorPagoSacado');
      Result.ValorCreditado :=  RetornaValorJson(LJsonRetorno,'valorCreditoCedente');
      Result.ValorIOF       :=  RetornaValorJson(LJsonRetorno,'valorImpostoSobreOprFinanceirasRecebidoTitulo');
      Result.ValorTarifa    := FloatToStrF(fStrToFloat(Result.ValorPago.Replace('.',',')) - fStrToFloat(Result.ValorCreditado.Replace('.',',')), ffFixed, 12, 2).Replace(',','.');
      Result.CanalPagamento := RetornaValorJson(LJsonRetorno, 'codigoCanalPagamento');
      Result.TextoMensagemBloqueto := RetornaValorJson(LJsonRetorno, 'textoMensagemBloquetoTitulo');
      Result.CodigoModalidadeTitulo := RetornaValorJson(LJsonRetorno, 'codigoModalidadeTitulo');

      Result.EndToEndID := ''; //aguardando pgto

      Result.NumeroTituloCedenteCobranca  := RetornaValorJson(LJsonRetorno, 'numeroTituloCedenteCobranca');
      Result.DataVencimentoTituloCobranca := RetornaValorJson(LJsonRetorno, 'dataVencimentoTituloCobranca');
      Result.ValorOriginalTituloCobranca  := RetornaValorJson(LJsonRetorno, 'valorOriginalTituloCobranca');
      Result.DataEmissaoTituloCobranca    := RetornaValorJson(LJsonRetorno, 'dataEmissaoTituloCobranca');

      Result.NumeroCarteiraCobranca          := RetornaValorJson(LJsonRetorno, 'numeroCarteiraCobranca');
      Result.NumeroVariacaoCarteiraCobranca  := RetornaValorJson(LJsonRetorno, 'numeroVariacaoCarteiraCobranca');
      Result.CodigoLinhaDigitavel            := RetornaValorJson(LJsonRetorno, 'codigoLinhaDigitavel');
      Result.TextoCodigoBarrasTituloCobranca := RetornaValorJson(LJsonRetorno, 'textoCodigoBarrasTituloCobranca');
      Result.NumeroContratoCobranca          := RetornaValorJson(LJsonRetorno, 'numeroContratoCobranca');

    Except

      On E:EIdHTTPProtocolException Do
      Begin
        If (E.ErrorCode = 404) Then  // Sem Registro
            Exit;

        Raise Exception.Create(E.Message);
      End;

      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    Begin
      FreeAndNil(LJsonRetorno);
    End;
  End;
end;

function TBancoDoBrasilAPI.RetornaNovaDataVencimento(ADadosDuplicata: TDataSet):TJsonObject;
Begin
  Result  := TJSONObject.Create;
  Result.AddPair('novaDataVencimento', FormatDateTime('DD.MM.YYYY', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));
End;

function TBancoDoBrasilAPI.RetornaNovaQuantidadeDiasRecebimentoAposVencimento: TJsonObject;
begin
  Result  := TJsonObject.Create;
  Result.AddPair('quantidadeDiasAceite', Trunc(StrToIntDef(LDadosCarteira.LQtdDiasLimitePagto,0)).ToString);
end;

function TBancoDoBrasilAPI.RetornaNovoEnderecoPagador(
  ADadosDuplicata: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;
  Result.AddPair('enderecoPagador'              ,RetornaValorString(RetornaEnderecoENumeroCom30Caracteres(ADadosDuplicata.FieldByName('CLI_ENDERE').AsString,
                                                                                                          ADadosDuplicata.FieldByName('CLI_ENDNUM').AsString)));
  Result.AddPair('bairroPagador'                ,RetornaValorString(ADadosDuplicata.FieldByName('CLI_BAIRRO').AsString, 30));
  Result.AddPair('cidadePagador'                ,RetornaValorString(ADadosDuplicata.FieldByName('CID_NOMCID').AsString, 30));
  Result.AddPair('UFPagador'                    ,ADadosDuplicata.FieldByName('CID_ESTADO').AsString);
  Result.AddPair('CEPPagador'                   ,fRetSomenteNumeros(ADadosDuplicata.FieldByName('CLI_C_E_P_').AsString));
end;

function TBancoDoBrasilAPI.RetornaErro(AStatus: Integer; AErro: String): String;
Var
    LErroInstabilidade,
    LErroAutenticacao : String;
begin
  Result := 'Status: ' + AStatus.ToString + ' Erro: ' + AErro;

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  If (AStatus = 404) Then
  Begin
    Result := 'Status: ' + AStatus.ToString + ' Erro: ' + AErro + #13#10 +
              'Verifique se a agência, conta-corrente e convênio estão configurados corretamente na carteira.';
    Exit;
  End;

  If fEmptyStr(AErro) Then
  Begin
     Result := LErroInstabilidade;
     exit;
  End;

  If (Pos(LErroAutenticacao, AErro) > 0) Then
      Result := LErroAutenticacao;

end;

function TBancoDoBrasilAPI.RetornaMulta(ADadosDuplicata: TDataSet):TJsonObject;
  Var
    LValorMulta : Double;
begin
  Result  := TJSONObject.Create;

  If Self.LPercentualMulta = 0 Then
    Self.LPercentualMulta := fStrToFloat(LDadosCarteira.LPercenMulta);

  LValorMulta := fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * (Self.LPercentualMulta/100), 2);

  If (LValorMulta > 0) Then
  Begin
    Result.AddPair('tipo'   ,'1');
    Result.AddPair('data'   ,FormatDateTime('DD.MM.YYYY', IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime, 1)));
    Result.AddPair('valor'  ,RetornaCampoDecimalJSON(LValorMulta.ToString));
  End
  Else
  Begin
    Result.AddPair('tipo'   ,'0');
  End;
end;

function TBancoDoBrasilAPI.RetornaPagador(ADadosCliente: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;

  Result.AddPair('tipoInscricao'         ,IIF(Length(fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString)) = 11,'1','2'));
  Result.AddPair('numeroInscricao'       ,fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString));
  Result.AddPair('nome'                  ,RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 30));
  Result.AddPair('endereco'              ,RetornaValorString(RetornaEnderecoENumeroCom30Caracteres(ADadosCliente.FieldByName('CLI_ENDERE').AsString,
                                                                                                   ADadosCliente.FieldByName('CLI_ENDNUM').AsString)));
  Result.AddPair('cep'                   ,fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));
  Result.AddPair('cidade'                ,RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 30));
  Result.AddPair('bairro'                ,RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 30));
  Result.AddPair('uf'                    ,ADadosCliente.FieldByName('CID_ESTADO').AsString);
end;

function TBancoDoBrasilAPI.RetornaPeriodo(ASituacao: String): String;
begin
  Result := 'Movimento';

  If ASituacao.Equals('A') Then
    Result := 'Registro';
end;

function TBancoDoBrasilAPI.RetornaSegundoDesconto(ADadosDuplicata: TDataSet): TJsonObject;
  Var
    LDataExpiracao : TDateTime;
begin
  Result := TJSONObject.Create;
  LDataExpiracao := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime - ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

  Result.AddPair('dataExpiracao', FormatDateTime('DD.MM.YYYY', LDataExpiracao));
  Result.AddPair('valor'        , RetornaCampoDecimalJSON(fFormataFloat(ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat,2).ToString));
end;

function TBancoDoBrasilAPI.RetornaUltimaDataDeRegistro: String;
  Var
    LRegBol : TUniQuery;
    LSql: String;
begin
  LRegBol := fCriaQuery(Nil);

  Try
    LSql := 'SELECT                                     '+
            '  MAX(REG_DTAREG) AS DATA_ULTIMO_REGISTRO  '+
            'FROM                                       '+
            '  REGBOL                                   '+
            'WHERE REG_EXCEPT IS NULL                   '+
            '  AND REG_JSOREC IS NOT NULL               '+
            '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
            '  AND REG_CODBCO = "001"                   '+
            '  AND REG_CODEMP = :CODEMP                 ';

    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LRegBol.Open;

      If LRegBol.IsEmpty Then
        Exit(FormatDateTime('DD.MM.YYYY',  VS_Date));

      Result := FormatDateTime('DD.MM.YYYY',  LRegBol.FieldByName('DATA_ULTIMO_REGISTRO').AsDateTime);
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LRegBol);
  End;
end;

function TBancoDoBrasilAPI.RetornaValorDuplicata(
  ADadosDuplicata: TDataSet): Double;
begin
  Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat;

  If fCfgSis('VALIMP', varBoolean, LDadosCarteira.LEmpresaCarteira) then
  Begin
    Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat +
              ADadosDuplicata.FieldByName('CTR_JURSUJ').AsFloat +
              ADadosDuplicata.FieldByName('CTR_DESCOB').AsFloat;

  End;
end;

function TBancoDoBrasilAPI.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
  Begin
    Try
      Result := AObjeto.GetValue<string>(ANomeCampo);
    Except
      Result := AObjeto.GetValue(ANomeCampo).ToString;
      Result := Result.Replace('"','');
    End;
  End;
end;

procedure TBancoDoBrasilAPI.RetornaValorJurosDescontos(
  var ADadosBoleto: TRetornoPesquisaBancoDoBrasilApi);
begin
  If (fStrToFloat(ADadosBoleto.BoletoValorPago) > fStrToFloat(ADadosBoleto.BoletoValorOriginal)) Then
    ADadosBoleto.valorJuros := (fStrToFloat(ADadosBoleto.BoletoValorPago) - fStrToFloat(ADadosBoleto.BoletoValorOriginal)).ToString;

  If (fStrToFloat(ADadosBoleto.BoletoValorOriginal) < fStrToFloat(ADadosBoleto.BoletoValorOriginal)) Then
    ADadosBoleto.valorDesconto := (fStrToFloat(ADadosBoleto.BoletoValorOriginal) - fStrToFloat(ADadosBoleto.BoletoValorPago)).ToString;
end;

function TBancoDoBrasilAPI.RetornaValorString(AValor: String;
  ATamanho: Integer): String;
begin
  Result := AValor;

  If Result.IsEmpty Then
    Exit;

  If ATamanho > 0 Then
    Result := LeftStr(Result, ATamanho);

  Result := fRemoveAcento(Result);
  Result := fTiraCaracEspeciais(Result);
  Result := RetiraQuebraLinha(Result);
end;

function TBancoDoBrasilAPI.UtilizaDescontoDePontualidade(
  AValDes: Double): Boolean;
begin
  Result := False;

  If fCfgSis('DESPON', varBoolean, LDadosCarteira.LEmpresaCarteira) Then
  Begin
    If (AValDes > 0) Then
      Result := True;
  End;

end;

procedure TBancoDoBrasilAPI.ValidaStatusErro(AStatus: Integer; ARetornoGet: String);
begin
  If AStatus <> 200 Then
    Raise Exception.Create(ARetornoGet);
end;

function TBancoDoBrasilAPI.VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoDoBrasilApi;out ADuplicata: TDuplicataCtr): Boolean;
  Var
    LPesquisa: TUniQuery;
begin
  ADuplicata.strAutoIn := EmptyStr;
  ADuplicata.strNumDup := EmptyStr;
  ADuplicata.strParcel := EmptyStr;
  ADuplicata.strEspdoc := EmptyStr;
  ADuplicata.strCodEmp := EmptyStr;
  ADuplicata.strCodCli := EmptyStr;
  ADuplicata.EndToEndPix := EmptyStr;

  Try
    LPesquisa := fCriaQuery;
    LPesquisa.SQL.Text := 'SELECT AUTOINCREM, CTR_NUMDUP, CTR_CODEMP,     ' +
                          'CTR_PARCEL, CTR_ESPDOC, CTR_CODCLI, CTR_CARTEI,' +
                          'CTR_END_ID                                     ' +
                          'FROM CADREC                                    ' +
                          'WHERE RIGHT(CTR_NOSNUM, 10) = :NOSNUM                       ' +
                          '  AND CTR_BCOENV=:BCOENV                       ' +
                          '  AND CTR_DTAVEN=:DTAVEN                       ' +
                          '  AND CTR_SEQBAI=0                             ';

    LPesquisa.ParamByName('NOSNUM').AsString   := ABoleto.NossoNumero;
    LPesquisa.ParamByName('BCOENV').AsString   := '001';
    LPesquisa.ParamByName('DTAVEN').AsDateTime := StrToDate(ABoleto.ABoletoDataVencimento);

    LPesquisa.Open;

    Result := Not LPesquisa.IsEmpty;
    If Not Result Then
      Exit;

    ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
    ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
    ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
    ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
    ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
    ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
    ADuplicata.EndToEndPix := LPesquisa.FieldByName('CTR_END_ID').AsString;

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + LDadosCarteira.LCarteiraBanco.QuotedString;
      LPesquisa.Filtered := True;

      If Not LPesquisa.IsEmpty Then
      Begin
        ADuplicata.strAutoIn := LPesquisa.FieldByName('AUTOINCREM').AsString;
        ADuplicata.strNumDup := LPesquisa.FieldByName('CTR_NUMDUP').AsString;
        ADuplicata.strParcel := LPesquisa.FieldByName('CTR_PARCEL').AsString;
        ADuplicata.strEspdoc := LPesquisa.FieldByName('CTR_ESPDOC').AsString;
        ADuplicata.strCodEmp := LPesquisa.FieldByName('CTR_CODEMP').AsString;
        ADuplicata.strCodCli := LPesquisa.FieldByName('CTR_CODCLI').AsString;
        ADuplicata.EndToEndPix := LPesquisa.FieldByName('CTR_END_ID').AsString;
      End;
    End;
  Finally
    FreeAndNil(LPesquisa);
  End;
end;

function TBancoDoBrasilAPI.AlteracaoSelecionada(AAlteracao: String): Boolean;
begin
  Result := False;

  If Trim(FAlteracoes).Equals('Todas') Then
    Exit(True);

  If(Pos(AAlteracao,FAlteracoes) > 0) Then
     Exit(True);
end;

procedure TBancoDoBrasilAPI.VerificaSeRegistrouBoleto(ANosNum: String;
                                                      ADuplicata: TDataSet;
                                                  var AStatus: Integer;
                                                  var ARetorno: WideString);
  Var
    LDetalhamento: TDetalhamento;
    LDadosPix    : TRetornoPesquisaBancoDoBrasilApi;

    LBoleto: TJSONObject;
    LBeneficiario: TJSONObject;
    LqrCode: TJSONObject;
begin

  If Not MatchStr(AStatus.ToString, ['500', // Internal Server Error
                                     '501', // Not Implemented
                                     '502', // Bad Gateway
                                     '503', // Service Unavailable
                                     '504', // Gateway Timeout
                                     '505', // HTTP Version Not Supported
                                     '506', // Variant Also Negotiates
                                     '507', // Insufficient Storage
                                     '508', // Loop Detected
                                     '510', // Not Extended
                                     '511'  // Network Authentication Required
                                    ])  Then
    Exit;

  Try

    Try
      LDetalhamento := RetornaDetalheBoleto(RetornaCampoNossoNumero(ANosNum));
      LDadosPix := TRetornoPesquisaBancoDoBrasilApi.Create;
      LBoleto := TJSONObject.Create;

      If Not BoletoEncontrado(ADuplicata,LDetalhamento) Then
        Exit;

      LDadosPix.BoletoNumeroBoletoBB := RetornaCampoNossoNumero(ANosNum);
      If UpperCase(LDadosCarteira.LGerarQRCodePix).Equals('S') Then
        RetornaDadosPagamentoPixBoleto(LDadosPix);


      LBoleto.AddPair('numero',RetornaCampoNossoNumero(ANosNum));
      LBoleto.AddPair('numeroCarteira', LDetalhamento.NumeroCarteiraCobranca);
      LBoleto.AddPair('numeroVariacaoCarteira',LDetalhamento.NumeroVariacaoCarteiraCobranca);
      LBoleto.AddPair('codigoCliente','XXXXXXXXX');
      LBoleto.AddPair('linhaDigitavel', LDetalhamento.CodigoLinhaDigitavel);
      LBoleto.AddPair('codigoBarraNumerico', LDetalhamento.TextoCodigoBarrasTituloCobranca);
      LBoleto.AddPair('numeroContratoCobranca', LDetalhamento.numeroContratoCobranca);

      LBeneficiario := TJSONObject.Create;
      LBeneficiario.AddPair('agencia',LDadosCarteira.LAgencia);
      LBeneficiario.AddPair('contaCorrente',LDadosCarteira.LContaCorrente);
      LBeneficiario.AddPair('tipoEndereco','X');
      LBeneficiario.AddPair('logradouro','XXXXXXXXXXX');
      LBeneficiario.AddPair('bairro','XXXXXXXXXXX');
      LBeneficiario.AddPair('cidade','XXXXXXXXXXX');
      LBeneficiario.AddPair('codigoCidade','XXXXXXXXXXX');
      LBeneficiario.AddPair('uf','XXXXXXXXXXX');
      LBeneficiario.AddPair('cep','XXXXXXXXXXX');
      LBeneficiario.AddPair('indicadorComprovacao','XXXXXXXXXXX');

      LqrCode := TJSONObject.Create;
      LqrCode.AddPair('url',LDadosPix.FDetalhamento.qrCodeURL);
      LqrCode.AddPair('txId',LDadosPix.FDetalhamento.qrCodeTxId);
      LqrCode.AddPair('emv',LDadosPix.FDetalhamento.qrCodeEmv);

      LBoleto.AddPair('beneficiario',LBeneficiario);
      LBoleto.AddPair('qrCode',LqrCode);

      AStatus := 201;
      ARetorno := PrettyJSON(LBoleto.ToString);

    Except
      On E: Exception Do
      Begin
        Exit;
      End;
    End;

  Finally
    If Assigned(LDadosPix) Then
      FreeAndNil(LDadosPix);

    If Assigned(LBoleto) Then
      FreeAndNil(LBoleto);
  End;

end;

{ TDadosToken }

function TDadosToken.GetAccessToken: String;
begin
  If Not fEmptyStr(Self.Exception) Then
    Raise SysUtils.Exception.Create(Self.Exception)
  Else
    Result := Self.Access_Token;
end;

function TDadosToken.RefreshToken: Boolean;
begin
   Result := False;

  If Not Assigned(Self) Then
    Exit(True);

  If (fNow > Self.RefreshTime) Then
    Exit(True);

 If Not fEmptyStr(Self.Exception) Then
   Exit(True);

end;

{ TRetornoPesquisaBancoDoBrasilApi }

function TRetornoPesquisaBancoDoBrasilApi.DataCreditoAsDate: String;
begin
  Result := Self.BoletoDataCredito.Replace('.','/');
end;

function TRetornoPesquisaBancoDoBrasilApi.DataMovimentoAsDate: String;
begin
  Result := Self.BoletoDataMovimento.Replace('.','/');
end;

function TRetornoPesquisaBancoDoBrasilApi.DataRegistroAsDate: String;
begin
  Result := Self.BoletoDataRegistro.Replace('.','/');
end;

function TRetornoPesquisaBancoDoBrasilApi.DataVencimentoAsDate: String;
begin
  Result := Self.BoletoDataVencimento.Replace('.','/');
end;

function TRetornoPesquisaBancoDoBrasilApi.GetNossoNumero: String;
begin
  Result := RightStr(Self.BoletoNumeroBoletoBB,10);
end;

function TRetornoPesquisaBancoDoBrasilApi.ValorPagoCedente: String;
begin
  Result := '0';

  If Not Self.FDetalhamento.TipoDeCobranca.Equals('6') Then // 6 = descontada
    Result := Self.FDetalhamento.ValorCreditado;

  If (fStrToFloat(Result) = 0) Then
    Result := Self.BoletoValorPago;

end;

{ TDetalhamento }

function TDetalhamento.DataEmissaoTituloCobrancaAsDate: String;
begin
  Result := Self.DataEmissaoTituloCobranca.Replace('.','/');
end;

function TDetalhamento.DataVencimentoTituloCobrancaAsDate: String;
begin
  Result := Self.DataVencimentoTituloCobranca.Replace('.','/');
end;

function TDetalhamento.RetornaCodigoModalidadeTitulo: String;
begin
  Result := Self.CodigoModalidadeTitulo;

  If fEmptyStr(Result) Then
    Result := '1';
end;

function TDetalhamento.RetornaValorTarifa: String;
begin
  Result := Self.ValorTarifa;

  If Self.TipoDeCobranca.Equals('6') Then // 6 = descontada
    Result := '0';

end;

end.
