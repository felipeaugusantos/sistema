unit untTBancoSafraAPI;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untGravando, untFuncoesSimples, UniClientDataset, WinApi.Windows, Vcl.Forms,
{$ENDIF}
  Classes, SysUtils, IPPeerClient, IPPeerCommon,
  REST.Json, System.Json, untConstantes, System.Net.URLClient, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  System.Generics.Collections, DB, Uni,
  IdCoder, IdCoder3to4, IdCoderMIME,untTRegBol,StrUtils,
  DateUtils,untFuncAutban,untFuncoesBoleto,REST.Types, REST.Client,
  untTypesSistema,untCNFOCO_Class, untCNFOCO_Dao,untLogCtr,
  untTRestSynalistAutban, untfuncBancarias;

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
  TRetornoPesquisaBancoSafraApi = class
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
    LinhaDigitavel,
    BoletoDataRegistro,
    BoletoDataVencimento,
    BoletoCooperativa,
    BoletoCodigoBeneficiario,
    BoletoCooperativaPostoBeneficiario,
    BoletoNumeroBoleto,
    BoletoNumControle,
    BoletoTipoCarteira,
    BoletoDataPagamento,
    BoletoDataMovimento,
    BoletoValorOriginal,
    BoletoValorPago,
    BoletoValorJuros,
    BoletoValorDesconto,
    ValorMulta,
    BoletoValorAbatimentoLiquido,
    BoletoTipoLiquidacao,
    BoletoCarteiraConvenio,
    BoletoVariacaoCarteiraConvenio,
    BoletoDataCredito,
    BoletoCodigoBarras,
    BoletoSeuNumero,
    BoletoDataEmissao,
    ValorDesconto,
    ValorJuros,
    BoletoCodigoPagador,
    BoletoDocumentoPagador,
    BoletonomePagador,
    TxIdPix,
    QrCodeEmv,
    NomeDoArquivo: String;
    Property NossoNumero            : String  Read GetNossoNumero        Write BoletoNumeroBoleto;
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
    LCarteiraCompleta,
    LLinkInclusao,
    FLinkConsultaBoletoNossoNumero,
    FLinkConsultaBoletoNossoNumero_Completo,
    FOcorrenciasDeEncargo,
    LLinkApi,
    LLinkTokenAPI,
    LLinkApiBase,
    LClient_ID,
    LUserName,
    LPassword,

    LContaCorrente,
    LCodigoAgencia,
    LDigitoAgencia,
    LTipoDesc,
    LCodigoCarteira,

    LQtdDiasProtesto,
    LQtdDiasLimitePagto,
    LObservacao1,
    LObservacao2,
    LObservacao3,
    LObservacao4,
    LPercenMulta,
    LQtdDiasDevolucao,
    LAceite,
    GerarQRCodePix,
    AutoIncremChavePix,

    UsaSacadorAvalista,
    NomeBeneficiario,
    EnderecoBeneficiario,
    //ComplementoBeneficiario,
    BairroBeneficiario,
    CidadeBeneficiario,
    UFBeneficiario,
    CEPBeneficiario,
    CNPJBeneficiario : String;
  end;

Type
  TBancoSafraAPI = class(TObject)
  private

    FHandleRequisicoes: THandle;
    LDadosCarteira : TDadosCarteira;
    LPercentualMulta,
    LPercentualMora: Double;
    LFaturamento: Boolean;
    FTentarNovamente: Boolean;
    LNossoNumeroCancelamento : String;
    LCancelarRegistro : Boolean;
    LDuplicataCancelamento: String;

    ListaRequisicaoRegistroBoleto : TList<TRequisicaoRegistroBoleto>;
    LRetornoBancoSafraAPI: TRetornoBoletoBancoSafra;

    FPastaAutcom: String;

    FRestSynalist: TRestSynalistAutban;

    FTokenUsoAtual: String;

    RestExecute : function (const AMetodo, AUrl,AToken : WideString;
                            out AJsonRetorno: WideString; AJsonEnvio: WideString = '';
                            AKeyUser : WideString = ''; ACooperativa : WideString = ''; APosto: WideString = ''; ABeneficiario: WideString = ''): Integer; stdcall;


    procedure CriarComponenteRequisicao;
    function DeveAdicionarDuplicata(ARetorno: TRetornoPesquisaBancoSafraApi;
                                    ADataInicial,
                                    ADataFinal: TDateTime): Boolean;
    Procedure GerarToken;
    procedure DefinirURL;
    procedure CarregaDadosCarteira(ACarteira: String);
    procedure Aguarde(msecs: Integer);
    procedure AguardeCincoSegundos;
    procedure AtualizaDadosExportacaoRemessa(ACadRec: TDataSet; ADadosRetorno: TRetornoBoletoBancoSafra);
    procedure CarregaOcorrenciasDeEncargosBancarios;
    procedure ValidaStatusErro(AStatus: Integer; ARetornoGet: String);

    function RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente: TDataset;ANosNum:String): String;
    function RetornaCampoDecimalJSON(AValor: String): String;
    function RetornaValorString(AValor: String; ATamanho: Integer = 0): String;
    function UtilizaDescontoDePontualidade(AValDes:Double): Boolean;
    function RetornaPagador(ADadosCliente : TDataSet): TJsonObject;
    function RetornaCampoNossoNumero(ANosNum: String):String;
    function PrettyJSON(jsonstring:String):String;
    function RetornaJsonRegistroBoleto(AAutoIncrem: String): String;
    function EncontrarJsonRegistroBoleto(AAutoIncrem: String):String;

    function RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function RetornaLinkConsultaBoletosNossoNumero(AAgencia, AConta, ANosNum, ANumeroCliente : String): String;
    function RetornaLinkConsultaBoletosNossoNumero_Completa(AAgencia, AConta, ANosNum, ANumeroDup : String): String;

    function RetornaDocumento(ADadosDuplicata, ADadosCliente: TDataset; ANosNum: String): TJsonObject;
    function RetornaGrupoDescontos(ADadosDuplicata: TDataSet): TJsonObject;
    function RetornaMultaEJuros(ADadosDuplicata: TDataSet): TJsonObject;
    function RetornaPagamentoParcial(ADadosDuplicata: TDataSet): TJsonObject;
    function RetornaEnderecoPagador(ADadosCliente: TDataSet): TJsonObject;
    function RetornaBeneficiario(): TJsonObject;
    function RetornaEnderecoBeneficiario(): TJsonObject;

    function RetornaTextoErro(ADadosRetorno: String): String;
    function ExtrairMensagemErro(const AJsonStr: string): string;

  public
    constructor Create(ACarteira: String);
    Destructor Destroy; Override;

    function RetornaLinhaDigitavelDoCodigoBarras(Codigo : String) : string;
    function GenerateCorrelationID: string;
    function fRetornaCodigoBarrasLinDig(strLinDig: String): String;
    function ExtrairJsonObject(AObjeto: TJsonObject; ANomeJson: String): TJsonObject;
    function CadastrarNovoBoleto(ADadosDuplicata, ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoBancoSafra;
    procedure CancelarRegistroBoleto;
    procedure ReimpressaoDeBoleto(AAutoIncrem: String);
    Function fVerificaSeTemQrCodePix(AAutoIncrem: String) : Boolean;
    function RetornaQRCodeBoletoCadastrado(ANumDup, ANossoNumero: String): TRetornoPesquisaBancoSafraApi;

    function RetonaDuplicatasBoletoGerado(ACarteira: String;
                                          ADataInicial,
                                          ADataFinal: TDateTime): TUniClientDataSet;

    function ConsultaBoletosPorPeriodo(ADataInicial, ADataFinal: TDateTime{$IFNDEF LINUX};AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoSafraApi>;
    function RetornaDadosPesquisaBoleto(ADadosRetorno: String): TRetornoPesquisaBancoSafraApi;
    function RetornaValorJsonValue(AObjeto: TJsonValue; ANomeCampo: String): String;

    function RetornaDadosPesquisaBoleto_Completo(ADadosRetorno: String): TRetornoPesquisaBancoSafraApi;

    procedure CancelarBoletos(ADataSet:TDataSet);
    function VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoSafraApi; out ADuplicata: TDuplicataCtr): Boolean;
    procedure GravarDadosRequisicaoRegistroBoleto;

    Function Valida_Configuracao_Token(LClient_ID,
                                       LUserName,
                                       LPassword : String;
                                       LAmbiente : Integer;
                                       LCarteira : String ): String;

    Function VerificaRetornoValidacaoToken(AStatusCode: Integer; ARetorno: String): String;

    property PercentualMulta  : Double    Read LPercentualMulta  Write LPercentualMulta;
    property PercentualMora   : Double    Read LPercentualMora   Write LPercentualMora;
    property Faturamento      : Boolean   Read LFaturamento      Write LFaturamento;
    property TentarNovamente  : Boolean   Read FTentarNovamente  Write FTentarNovamente;
    property CancelarRegistro : Boolean   Read LCancelarRegistro Write LCancelarRegistro;

    property NossoNumeroCancelamento  : String    Read LNossoNumeroCancelamento Write LNossoNumeroCancelamento;
    property DuplicataCancelamento    : String    Read LDuplicataCancelamento   Write LDuplicataCancelamento;

    property RetornoBancoSafraAPI  : TRetornoBoletoBancoSafra Read  LRetornoBancoSafraAPI Write LRetornoBancoSafraAPI;

  End;

const
  C_URL            = 'https://api.safranegocios.com.br/gateway/cobrancas/v1/boletos';
  C_URL_HOM        = 'https://api-hml.safranegocios.com.br/gateway/cobrancas/v1/boletos';

  C_URL_OAUTH_PROD = 'https://api.safranegocios.com.br/gateway/v1/oauth2/token';
  C_URL_OAUTH_HOM  = 'https://api-hml.safranegocios.com.br/gateway/v1/oauth2/token';

  C_URL_BASE_PROD = 'https://api.safranegocios.com.br/gateway';
  C_URL_BASE_HOM  = 'https://api-hml.safranegocios.com.br/gateway';

  INDICADOR_SITUACAO: Array of String = ['A', 'B'];

implementation

{ TBancoSafraAPI }

uses untFuncoesGenerica;

procedure TBancoSafraAPI.Aguarde(msecs: Integer);
{$IFDEF LINUX}
begin
  Sleep(msecs);
end;
{$ELSE}
  var
    FirstTickCount: LongInt;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages;
  until ((LongInt(GetTickCount) - LongInt(FirstTickCount)) >= LongInt(msecs));
end;
{$ENDIF}

procedure TBancoSafraAPI.AguardeCincoSegundos;
begin
  Aguarde(5000);
end;

procedure TBancoSafraAPI.AtualizaDadosExportacaoRemessa(ACadRec: TDataSet;
  ADadosRetorno: TRetornoBoletoBancoSafra);
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
      LCadRec.ParamByName('CODBCO').AsString := '422';

      If Not ADadosRetorno.QrCodeEmv.IsEmpty Then
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

function TBancoSafraAPI.RetornaLinhaDigitavelDoCodigoBarras(Codigo : String) : string;
{
   A linha digitável é baseada na informações do código de barras.
   As informações que fazem parte do código de barras são:
   Posição         Conteúdo
   1 a 3           Número do banco
   4               Código da Moeda - 9 para Real
   5               Digito verificador do Código de Barras
   6 a 19          Valor (12 inteiros e 2 decimais)
   20 a 44         Campo Livre definido por cada banco
}
var
   p1, p2, p3, p4, p5, p6,
   Campo1, Campo2, Campo3, Campo4, Campo5 : string;
begin
   {
      Campo 1 - composto pelo código do banco, código da moeda, as cinco primeiras posições
      do campo livre e DV (modulo10) desse campo
   }
   p1 := Copy(Codigo,1,4);
   p2 := Copy(Codigo,20,5);
   p3 := fCalcDigitoModulo10(p1+p2);
   p4 := p1+p2+p3;
   p5 := Copy(p4,1,5);
   p6 := Copy(p4,6,5);
   //Campo1 := p5+'.'+p6;
   Campo1 := p5+p6; // sem formatação

   {
      Campo 2 - composto pelas posiçoes 6 a 15 do campo livre
      e DV (modulo10) deste campo
   }
   p1 := Copy(Codigo,25,10);
   p2 := fCalcDigitoModulo10(p1);
   p3 := p1+p2;
   p4 := Copy(p3,1,5);
   p5 := Copy(p3,6,6);
   //Campo2 := p4+'.'+p5;
   Campo2 := p4+p5;  // sem formatação

   {
      Campo 3 - composto pelas posicoes 16 a 25 do campo livre
      e DV (modulo10) deste campo
   }
   p1 := Copy(Codigo,35,10);
   p2 := fCalcDigitoModulo10(p1);
   p3 := p1+p2;
   p4 := Copy(p3,1,5);
   p5 := Copy(p3,6,6);
   Campo3 := p4+p5;

   {
      Campo 4 - digito verificador do codigo de barras
   }
   Campo4 := Copy(Codigo,5,1);

   {
      Campo 5 - composto pelo valor nominal do documento, sem indicacao
      de zeros a esquerda e sem edicao (sem ponto e virgula). Quando se
      tratar de valor zerado, a representacao deve ser 000 (tres zeros).
   }
   Campo5 := Copy(Codigo,6,14);

   //Result := Campo1 + ' ' + Campo2 + ' ' + Campo3 + ' ' + Campo4 + ' ' + Campo5;
   Result := Campo1 + Campo2 + Campo3 + Campo4 + Campo5;
end;

function TBancoSafraAPI.GenerateCorrelationID: string;
var
  Guid: TGUID;
begin
  // Gera o GUID
  Guid := TGuid.NewGuid;

  // Converte o GUID para uma string no formato padrão (com hífens)
  Result := GUIDToString(Guid);

  // Remove os caracteres "{" e "}" que são parte da representação padrão do GUID
  Result := Copy(Result, 2, Length(Result) - 2);
end;

function TBancoSafraAPI.fRetornaCodigoBarrasLinDig(strLinDig: String): String;
begin

  Result := Copy(strLinDig, 01, 04) + Copy(strLinDig, 33, 15) + Copy(strLinDig, 05, 05) +
            Copy(strLinDig, 11, 08) + Copy(strLinDig, 19, 02) + Copy(strLinDig, 22, 10);

end;

function TBancoSafraAPI.ExtrairJsonObject(AObjeto: TJsonObject;
  ANomeJson: String): TJsonObject;
begin
  Result := Nil;
  Try
    Result := AObjeto.GetValue<TJSONObject>(ANomeJson) as TJSONObject;
  Except
    //
  End;
end;

function TBancoSafraAPI.CadastrarNovoBoleto(ADadosDuplicata,ADadosCliente: TDataSet; Var ANosNum: String): TRetornoBoletoBancoSafra;
  Var
    LRetornoPost: String;
    LDadosRequisicao: String;
    LJsonRetorno: TJSONObject;
    LRequisicaoRegistroBoleto : TRequisicaoRegistroBoleto;
    LParametros : TStringList;
    sCorrelationId : string;

    LDadosRetorno: TRetornoPesquisaBancoSafraApi;
begin

  Self.FTentarNovamente := True;
  Result := TRetornoBoletoBancoSafra.Create;
  LRequisicaoRegistroBoleto := TRequisicaoRegistroBoleto.Create;

  LRequisicaoRegistroBoleto.LCartei :=  LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira;
  LRequisicaoRegistroBoleto.LCodBco := '422';
  LRequisicaoRegistroBoleto.LLocImp := IIF(Self.LFaturamento,'FAT','CTR');
  LRequisicaoRegistroBoleto.FDescricao := 'REGISTRO';

  LDadosRequisicao := RetornaDadosDaRequisicao(ADadosDuplicata, ADadosCliente, ANosNum);
  LRequisicaoRegistroBoleto.FRequisicao := LDadosRequisicao;
  LRequisicaoRegistroBoleto.LDuplic := ADadosDuplicata.FieldByName('AUTOINCREM').AsString;
  LRequisicaoRegistroBoleto.LLnkApi := LDadosCarteira.LLinkInclusao;

  LRequisicaoRegistroBoleto.LJsoEnv := LDadosRequisicao;

  Try
    Try
      GerarToken;

      sCorrelationId := GenerateCorrelationID;

      LParametros := TStringList.Create;
      LParametros.Add('Authorization: Bearer ' + FTokenUsoAtual);
      LParametros.Add('Safra-Correlation-ID:'  + sCorrelationId);

      Try
        FRestSynalist.ExecuteRestSynalist('POST',
                                          LDadosCarteira.LLinkInclusao,
                                          LParametros,
                                          LRetornoPost,
                                          LDadosRequisicao);

      Finally
        FreeAndNil(LParametros);
      End;

      Self.FTentarNovamente := False;

      LRequisicaoRegistroBoleto.LJsoRec := LRetornoPost;
      LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoPost) as TJSONObject;

      LJsonRetorno := ExtrairJsonObject(LJsonRetorno,'data');

      Result.nossoNumero               := RetornaValorJson(LJsonRetorno,'numero');
      Result.codigoDeBarras            := RetornaValorJson(LJsonRetorno,'codigoBarras');
      Result.linhaDigitavel            := RetornaLinhaDigitavelDoCodigoBarras( Result.codigoDeBarras );
      Result.BeneficiarioAgencia       := LDadosCarteira.LCodigoAgencia + LDadosCarteira.LDigitoAgencia;
      Result.BeneficiarioContaCorrente := LDadosCarteira.LContaCorrente;
      Result.CodigoCarteira            := LDadosCarteira.LCodigoCarteira;

      Result.nossoNumero := fStrZero(Result.nossoNumero, 9);

      // FAZ NOVA SOLICITAÇÃO PAR PEGAR OS DADOS DO PIX QRCODE DO BOLETO - "copiaECola"
      If (Not FemptyStr(Result.nossoNumero)) And (LDadosCarteira.GerarQRCodePix = 'S') Then
      Begin

          Try
            LDadosRetorno := RetornaQRCodeBoletoCadastrado(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString, Result.nossoNumero);

            Try
              If Not LDadosRetorno.QrCodeEmv.IsEmpty Then
              Begin

                Result.QrCodeEmv := LDadosRetorno.QrCodeEmv;

                Result.QrCodeTxId := fRetAutoIncrem('GERACAOTXIDPIX', VS_strCodEmp);

                Result.QrCodeTxId := untFuncoesSimples.GetMD5(Concat(fRetCGCEmpresa(VS_strCodEmp),
                                                                     Result.QrCodeTxId,
                                                                     DateTimeToStr(fRetDtaHraServidor),
                                                                     strLoginUsuarioLogado));

                Result.QrCodeLinkCitel := TFuncoesPixBoleto.IncluirLinkCitelPixBoleto('422',
                                                                                      Result.QrCodeTxId,
                                                                                      Result.QrCodeEmv,
                                                                                      FormatFloat(',0.00', RetornaValorDuplicata(ADadosDuplicata)),
                                                                                      LDadosCarteira.AutoIncremChavePix,
                                                                                      IncDay(ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                             StrToIntDef(LDadosCarteira.LQtdDiasLimitePagto, 0)) + StrToTime('23:59:59'));

              End;
            Finally
              FreeAndNil(LDadosRetorno);
            End;

          Except
            On E: Exception Do
            Begin
              LRequisicaoRegistroBoleto.LExcept := 'QR CODE PIX: ' + E.Message;
            End;
          End;

      End;

      AtualizaDadosExportacaoRemessa(ADadosDuplicata,
                                     Result);

    Except

      On E: Exception Do
      Begin
        LRequisicaoRegistroBoleto.LExcept := E.Message;

       {$IFDEF LINUX}
        AguardeCincoSegundos;
       {$ELSE}
        TfrmGravando.fExecutarModalA(AguardeCincoSegundos,'Falha na comunicação, Nova tentativa em 5 segundos.', '');
       {$ENDIF}
        Raise Exception.Create(RetornaTextoErro(E.Message));
      End;
    End;
  Finally
    ListaRequisicaoRegistroBoleto.Add(LRequisicaoRegistroBoleto);
  End;
end;

function TBancoSafraAPI.RetornaQRCodeBoletoCadastrado(ANumDup, ANossoNumero: String): TRetornoPesquisaBancoSafraApi;
var
  LRetornoGetS,
  sCorrelationId : String;
  LParametrosC: TStringList;
  LTentativa: Integer;
  LStatus : Integer;
  LDadosRet : TRetornoPesquisaBancoSafraApi;
begin

    Result := Nil;
    LDadosRet := Nil;
    LParametrosC := Nil;
    Try

      LParametrosC := TStringList.Create;
      for LTentativa := 1 to 3 do
      begin

         sCorrelationId := GenerateCorrelationID;

         LParametrosC.Clear;
         LParametrosC.Add('Safra-Correlation-ID:' + sCorrelationId);
         LParametrosC.Add('Content-Type: application/json');
         LParametrosC.Add('Authorization: Bearer ' + FTokenUsoAtual);

         LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                       RetornaLinkConsultaBoletosNossoNumero_Completa(LDadosCarteira.LCodigoAgencia+LDadosCarteira.LDigitoAgencia,
                                                                                                      LDadosCarteira.LContaCorrente,
                                                                                                      ANossoNumero,
                                                                                                      ANumDup),
                                                       LParametrosC,
                                                       LRetornoGetS,
                                                       '');

         If ((LStatus = 200) Or (LStatus = 201)) Then
         Begin
            FreeAndNil(LDadosRet);
            LDadosRet := RetornaDadosPesquisaBoleto_Completo(LRetornoGetS);
            If Not LDadosRet.QrCodeEmv.IsEmpty Then
               Exit(LDadosRet);
         End;

         if LTentativa < 3 then
            Sleep(2000);

      End;

      raise Exception.Create(
        'SAFRA-Não foi possível consultar o QR Code do boleto, pois o servidor do banco apresenta lentidão ' +
        'no processamento da cobrança e não retornou os dados necessários após 3 tentativas. ');

    Finally
      If Not Assigned(Result) Then FreeAndNil(LDadosRet);
      FreeAndNil(LParametrosC);
    End;
End;

procedure TBancoSafraAPI.CancelarBoletos(ADataSet: TDataSet);
begin
end;

procedure TBancoSafraAPI.CancelarRegistroBoleto;
begin
end;

procedure TBancoSafraAPI.CarregaDadosCarteira(ACarteira: String);
begin
  LDadosCarteira := TDadosCarteira.Create;
  LDadosCarteira.LCarteiraBanco       := LeftStr(ACarteira,14);
  LDadosCarteira.LEmpresaCarteira     := RightStr(ACarteira, 3);
  LDadosCarteira.LCarteiraCompleta    := ACarteira;

  LDadosCarteira.LCodigoCarteira      := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'CODCART'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LAceite              := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'PROACEI'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasProtesto     := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'DIAPROT'      ,'0',LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasDevolucao    := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'QTDIASDEV'    ,'0',LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LQtdDiasLimitePagto  := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'DIALIMR'      ,'0',LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao1         := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'OBSERV1'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao2         := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'OBSERV2'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao3         := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'OBSERV3'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LObservacao4         := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'OBSERV4'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LPercenMulta         := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'PERMULT'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LClient_ID           := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'CLIENT_ID'    ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LUsername            := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'USERNAME'     ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LPassword            := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'PASSWORD'     ,'', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.AutoIncremChavePix   := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'CHAPIX'       ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.GerarQRCodePix       := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'GERAPIX'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LDigitoAgencia       := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'DIGAGEN'      ,'', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.LContaCorrente       := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'NUMCTAC'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LCodigoAgencia       := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'CODAGEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.LTipoDesc            := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'TIPO_DESC'    ,'', LDadosCarteira.LEmpresaCarteira);

  LDadosCarteira.UsaSacadorAvalista   := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'SACAVAL'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.NomeBeneficiario     := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'NOMEBEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.EnderecoBeneficiario := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'ENDEBEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.BairroBeneficiario   := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'BAIRBEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.CidadeBeneficiario   := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'CIDABEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.UFBeneficiario       := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'ESTABEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.CEPBeneficiario      := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'CEP_BEN'      ,'', LDadosCarteira.LEmpresaCarteira);
  LDadosCarteira.CNPJBeneficiario     := fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'CNPJBEN'      ,'', LDadosCarteira.LEmpresaCarteira);

  CarregaOcorrenciasDeEncargosBancarios;
  LDadosCarteira.LHomologacao         := (fArqIniAutban(0, LDadosCarteira.LCarteiraBanco, 'TPAMBIENTE'  ,'', LDadosCarteira.LEmpresaCarteira) = '0');

end;

procedure TBancoSafraAPI.CarregaOcorrenciasDeEncargosBancarios;
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

function TBancoSafraAPI.ConsultaBoletosPorPeriodo(ADataInicial, ADataFinal: TDateTime{$IFNDEF LINUX};AProgresso: TfrmGravando{$ENDIF}): TList<TRetornoPesquisaBancoSafraApi>;
  Var
    //LRetornoGet: WideString;
    LRetornoGetS: String;
    LJsonRetorno: TJSONObject;
    LStatus : Integer;
    LParametros: TStringList;
    LConsultaBoletosGerados: TUniClientDataset;
    LDadosRetorno: TRetornoPesquisaBancoSafraApi;
    sCorrelationId : String;
begin

    Result       := TList<TRetornoPesquisaBancoSafraApi>.Create;
    LJsonRetorno := TJsonObject.Create;
    //LStatus := 0;

    LConsultaBoletosGerados := RetonaDuplicatasBoletoGerado(LDadosCarteira.LCarteiraCompleta,
                                                            ADataInicial,
                                                            ADataFinal);

  Try
    LConsultaBoletosGerados.First;

   {$IFNDEF LINUX}
    AProgresso.pgbStatus.Position := 0;
    AProgresso.pgbStatus.Properties.Max := LConsultaBoletosGerados.RecordCount;
   {$ENDIF}

    While Not LConsultaBoletosGerados.Eof Do
    Begin
       Try

          GerarToken;

          sCorrelationId := GenerateCorrelationID;

          LParametros := TStringList.Create;

          LParametros.Add('Safra-Correlation-ID:' + sCorrelationId);
          LParametros.Add('Content-Type: application/json');
          LParametros.Add('Authorization: Bearer ' + FTokenUsoAtual);

          Try
             LStatus := FRestSynalist.ExecuteRestSynalist('GET',
                                                          RetornaLinkConsultaBoletosNossoNumero(LDadosCarteira.LCodigoAgencia+LDadosCarteira.LDigitoAgencia,
                                                                                                LDadosCarteira.LContaCorrente,
                                                                                                LConsultaBoletosGerados.FieldByName('CTR_NOSNUM').AsString,
                                                                                                LConsultaBoletosGerados.FieldByName('CTR_CODCLI').AsString),
                                                          LParametros,
                                                          LRetornoGetS,
                                                          '');

          Finally
            FreeAndNil(LParametros);
          End;


          If (LStatus = 404) Then
          Begin
             LConsultaBoletosGerados.Next;
            {$IFNDEF LINUX}
             pStep(AProgresso.pgbStatus);
            {$ENDIF}
             Continue;
          End;

          ValidaStatusErro(LStatus, LRetornoGetS);

          LDadosRetorno := RetornaDadosPesquisaBoleto(LRetornoGetS);

          Application.ProcessMessages;
         {$IFNDEF LINUX}
          pStepStatusGravacao(AProgresso.pgbStatus);
         {$ENDIF}

          If LConsultaBoletosGerados.FieldByName('CTR_DTAENV').AsDateTime = VS_Date Then
          Begin
            If LDadosRetorno.LinhaDigitavel.IsEmpty Then
            Begin
             {$IFNDEF LINUX}
              pStep(AProgresso.pgbStatus);
             {$ENDIF}

              LConsultaBoletosGerados.Next;

              Continue;
            End;
          End;

          LDadosRetorno.NomeDoArquivo := Concat(FormatDateTime('dd/mm/yy', ADataInicial),' - ',
                                                FormatDateTime('dd/mm/yy', ADataFinal) );

         If DeveAdicionarDuplicata(LDadosRetorno,ADataInicial,ADataFinal) Then
           Result.Add(LDadosRetorno);

         {$IFNDEF LINUX}
          pStep(AProgresso.pgbStatus);
         {$ENDIF}

          LConsultaBoletosGerados.Next;

        Except

          On E: Exception Do
          Begin
            Raise Exception.Create(E.Message);
          End;

        End;

    End;

  Finally
    FreeAndNil(LJsonRetorno);
  End;

end;

function TBancoSafraAPI.RetornaDadosPesquisaBoleto(ADadosRetorno: String): TRetornoPesquisaBancoSafraApi;
  Var
    LJSONRetorno,
    LJsonExtracao : TJSONObject;
begin
  Result := TRetornoPesquisaBancoSafraApi.Create;

  If ADadosRetorno.IsEmpty Then
     Exit;

  LJSONRetorno := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONObject;
  LJSONRetorno := ExtrairJsonObject(LJSONRetorno,'data');

  Try
     LJsonExtracao := LJsonRetorno.GetValue('documento') as TJSONObject;
     If Assigned(LJsonExtracao) Then
     Begin
       Result.BoletoCodigoBarras := RetornaValorJsonValue(LJsonExtracao, 'codigoBarras');
       If Not fEmptyStr(Result.BoletoCodigoBarras) Then
       Begin
          Result.linhaDigitavel     := RetornaLinhaDigitavelDoCodigoBarras( Result.BoletoCodigoBarras );
          Result.NossoNumero        := RetornaValorJsonValue(LJsonExtracao, 'numero');
          Result.BoletoCodigoPagador    := RetornaValorJson(LJsonExtracao, 'numeroCliente');
       End;
     End;

  Finally
    FreeAndNil(LJSONRetorno);
  End;
end;

function TBancoSafraAPI.RetornaDadosPesquisaBoleto_Completo(ADadosRetorno: String): TRetornoPesquisaBancoSafraApi;
  Var
    LJSONRetorno,
    LJsonExtracao,
    LJSONData : TJSONObject;
    LJsonDadosConsulta: TJSONObject;
begin
  Result := TRetornoPesquisaBancoSafraApi.Create;

  Try
    If ADadosRetorno.IsEmpty Then
       Exit;

    LJSONRetorno := TJSONObject.ParseJSONValue(ADadosRetorno) as TJSONObject;

    Try
       LJSONData := ExtrairJsonObject(LJSONRetorno,'data');

       LJsonDadosConsulta := ExtrairJsonObject(LJSONData, 'dadosConsulta');

       If Assigned(LJsonDadosConsulta) Then
       Begin
         LJsonExtracao := LJsonDadosConsulta.GetValue('codigoCopiaECola') as TJSONObject;
         If Assigned(LJsonExtracao) Then
         Begin
           Result.QrCodeEmv := RetornaValorJsonValue(LJsonExtracao, 'copiaECola');
         End;
       End;

    Finally
      FreeAndNil(LJSONRetorno);
    End;

  Except
    FreeAndNil(Result);
    Raise;
  End;
end;

function TBancoSafraAPI.RetornaValorJsonValue(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  If Not AObjeto.TryGetValue<String>(ANomeCampo, Result) Then
    Result := '';
end;

constructor TBancoSafraAPI.Create(ACarteira: String);
begin
  FPastaAutcom := ExtractFilePath(Application.ExeName).Replace('autban\', EMptyStr)
                                                      .Replace('Autban\', EMptyStr)
                                                      .Replace('AUTBAN\', EMptyStr)
                                                      .Replace('AutBan\', EMptyStr);

  CarregaDadosCarteira(ACarteira);
  CriarComponenteRequisicao;
  DefinirURL;
  ListaRequisicaoRegistroBoleto := TList<TRequisicaoRegistroBoleto>.Create;
  LRetornoBancoSafraAPI := TRetornoBoletoBancoSafra.Create;
  FRestSynalist := TRestSynalistAutban.Create;
end;

procedure TBancoSafraAPI.CriarComponenteRequisicao;
  Var
    LCaminhoDll : String;
begin

  If fUtilizaRestApiBoletoDLL Then
  Begin
    LCaminhoDll := ExtractFilePath(Application.ExeName) + 'RestApiBoleto.dll';

    If Not FileExists(LCaminhoDll) Then
      Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

    FHandleRequisicoes := LoadLibrary(PChar(LCaminhoDll));
    RestExecute := GetProcAddress(FHandleRequisicoes, 'Execute_');
  End;

end;

procedure TBancoSafraAPI.DefinirURL;
begin
  LDadosCarteira.LLinkTokenAPI := IIF(LDadosCarteira.LHomologacao,C_URL_OAUTH_HOM, C_URL_OAUTH_PROD);
  LDadosCarteira.LLinkApi      := IIF(LDadosCarteira.LHomologacao,C_URL_HOM, C_URL);
  LDadosCarteira.LLinkApiBase  := IIF(LDadosCarteira.LHomologacao,C_URL_BASE_HOM, C_URL_BASE_PROD);

  LDadosCarteira.LLinkInclusao                  := LDadosCarteira.LLinkApi;
  LDadosCarteira.FLinkConsultaBoletoNossoNumero := LDadosCarteira.LLinkApi;
  LDadosCarteira.FLinkConsultaBoletoNossoNumero_Completo := LDadosCarteira.LLinkApiBase + '/cobrancas-consulta/v1/consultarBoleto';
end;

destructor TBancoSafraAPI.Destroy;
begin
  GravarDadosRequisicaoRegistroBoleto;
  FreeAndNil(ListaRequisicaoRegistroBoleto);
  FreeAndNil(LRetornoBancoSafraAPI);

  If FHandleRequisicoes <> 0 Then
  Begin
    FHandleRequisicoes := 0;
    FreeLibrary(FHandleRequisicoes);
  End;
  inherited;
end;

function TBancoSafraAPI.DeveAdicionarDuplicata(ARetorno: TRetornoPesquisaBancoSafraApi; ADataInicial, ADataFinal: TDateTime): Boolean;
begin

  Result := DateTimeInRange(StrToDateTime(ARetorno.BoletoDataEmissao),
                            ADataInicial,
                            ADataFinal);

  If Not ARetorno.BoletoDataPagamento.IsEmpty Then
  Begin

    Result := DateTimeInRange(StrToDateTime(ARetorno.BoletoDataPagamento),
                              ADataInicial,
                              ADataFinal);

  End;
end;

{****************************************************************
 * FUNÇÃO CRIADA PARA ENCONTRAR DUPLICATAS GRAVADAS COM O CAMPO *
 * REG_DUPLIC INCORRETO                                         *
 *************************************************REQ: 242707*MT*}

function TBancoSafraAPI.EncontrarJsonRegistroBoleto(AAutoIncrem: String): String;
  Var
    LRegBol : TUniQuery;
    LNosNumCadRec : String;
    LDtaVenCadRec,
    LstrDataConv,
    LstrDataNova : String;
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
                          '  REGBOL WHERE REG_CODBCO = "422"  '+
                          '  AND REG_EXCEPT IS NULL           '+
                          '  AND REG_JSOREC IS NOT NULL       '+
                          '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
                          'ORDER BY REG_DTAREG DESC,          '+
                          '  REG_HRAREG DESC                  ';
      LRegBol.Open;

      LNosNumCadRec := fCampoTabela('CTR_NUMDUP', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False)+
                       fCampoTabela('CTR_PARCEL', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);

      LDtaVenCadRec := fCampoTabela('CTR_DTAVEN', 'CADREC', ['AUTOINCREM'], [AAutoIncrem], False);

      LRegBol.First;
      While Not LRegBol.Eof Do
      Begin
        LJsonRetorno := TJSONObject.ParseJSONValue(LRegBol.FieldByName('REG_JSOENV').AsString) as TJSONObject;

        If RightStr(LJsonRetorno.GetValue<String>('seuNumero'),10).Equals( RightStr(LNosNumCadRec,10) ) Then
        Begin

          LstrDataConv := LJsonRetorno.GetValue<String>('dataVencimento');
          LstrDataNova := copy(LstrDataConv,9,2) +'-'+ copy(LstrDataConv,6,2) +'-'+ copy(LstrDataConv,1,4);

          //If LJsonRetorno.GetValue<String>('dataVencimento').Equals(LDtaVenCadRec.Replace('/','.')) Then
          If LstrDataNova = LDtaVenCadRec.Replace('/','-') Then
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

procedure TBancoSafraAPI.GerarToken;
  Var
    LDadosEnvio: String;
    LParametros: TStringList;
begin
  LParametros := TStringList.Create;

  LDadosEnvio := 'client_id=' + (LDadosCarteira.LClient_ID) + '&' +
                 'username='  + (LDadosCarteira.LUserName)  + '&' +
                 'password='  + (LDadosCarteira.LPassword)  + '&' +
                 'grant_type=password';

  Try
    Try
      FTokenUsoAtual := FRestSynalist.GetToken('POST',
                                                LDadosCarteira.LLinkTokenAPI,
                                                LParametros,
                                                LDadosCarteira.LCarteiraBanco + '-' +  LDadosCarteira.LEmpresaCarteira,
                                                LDadosEnvio,
                                                'application/x-www-form-urlencoded');
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                IIF(LDadosCarteira.LHomologacao,'HOMOLOGAÇÃO', 'PRODUÇÃO') + '.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LParametros);
  End;

end;

Function TBancoSafraAPI.Valida_Configuracao_Token(LClient_ID,
                                                  LUserName,
                                                  LPassword : String;
                                                  LAmbiente : Integer;
                                                  LCarteira : String ): String;
  Var
    LResposta : String;
    LStatusCode : Integer;

    LDadosEnvio: String;
    LParametros: TStringList;
begin

  Result := '';

  LParametros := TStringList.Create;

  LDadosEnvio := 'client_id=' + LClient_ID + '&' +
                 'username='  + LUserName + '&' +
                 'password='  + LPassword + '&' +
                 'grant_type=password';

  Try
    Try

      FRestSynalist.GetToken('POST',
                             IIF( LAmbiente = 0, C_URL_OAUTH_HOM, C_URL_OAUTH_PROD),
                             LParametros,
                             LCarteira,
                             LResposta,
                             LStatusCode,
                             LDadosEnvio,
                             'application/x-www-form-urlencoded'
                            );

      Result := VerificaRetornoValidacaoToken(LStatusCode, LResposta);

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao realizar a autenticação na API do Banco.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    FreeAndNil(LParametros);
  End;

end;

Function TBancoSafraAPI.VerificaRetornoValidacaoToken(AStatusCode: Integer; ARetorno: String) : String;
begin
  If AStatusCode <> 200 Then
  Begin

     If (Pos('INVALID USER CREDENTIALS',AnsiUpperCase(ARetorno)) > 0) Then
         Result := 'Credenciais de acesso inválidas.'
     Else
     If (Pos('IDENTIFIED BY HEADER X-API-KEY, IS INVALID',AnsiUpperCase(ARetorno)) > 0) Then
         Result := 'Chave de acesso informada é inválida.'
     Else
     If (Pos('ACCESS DENIED FOR THIS ENVIRONMENT.',AnsiUpperCase(ARetorno)) > 0) Then
         Result := 'Acesso negado para este ambiente.'
     Else
         Result := 'Erro encontrado durante a validação das credenciais.' + #13 + ARetorno;
         //Raise Exception.Create('Chave de acesso informada é inválida.');

  End
  Else
     Result := 'Credenciais validadas com sucesso.';
end;


procedure TBancoSafraAPI.GravarDadosRequisicaoRegistroBoleto;
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

Function TBancoSafraAPI.fVerificaSeTemQrCodePix(AAutoIncrem: String) : Boolean;
  Var
    LCadRec: TUniQuery;
begin
  LCadRec := Nil;
  Result := False;
  Try
    Try
      LCadRec := fCriaQuery(Nil);
      LCadRec.Close;
      LCadRec.SQL.Clear;
      LCadRec.SQL.Add('SELECT CTR_QRCODE ' +
                      'FROM CADREC WHERE AUTOINCREM = :AUTOINC AND IFNULL(CTR_QRCODE,'''') <> '''' ');

      LCadRec.ParamByName('AUTOINC').AsString := AAutoIncrem;
      LCadRec.Open;

      If Not LCadRec.IsEmpty Then
         Result := True;

    Except
      On E: Exception Do
      Begin
        Raise;
      End;
    End;
  Finally
    If Assigned(LCadRec) Then
      FreeAndNil(LCadRec);
  End;
End;

procedure TBancoSafraAPI.ReimpressaoDeBoleto(AAutoIncrem: String);
  Var
    LJsonRetorno: TJSONObject;
    LJsonRegistro: String;
    LCadRec: TUniQuery;
    blnTemPixQRCode : Boolean;
begin
  LJsonRetorno := Nil;
  LCadRec := Nil;
  Try
    LRetornoBancoSafraAPI := TRetornoBoletoBancoSafra.Create;
    Try
      LJsonRegistro := RetornaJsonRegistroBoleto(AAutoIncrem);

      blnTemPixQRCode := fVerificaSeTemQrCodePix(AAutoIncrem);

      If (fEmptyStr(LJsonRegistro) Or (blnTemPixQRCode)) Then
      Begin

        LCadRec := fCriaQuery(Nil);
        LCadRec.Close;
        LCadRec.SQL.Clear;
        LCadRec.SQL.Add('SELECT CTR_LINDIG, CTR_NOSNUM, CTR_TX_BOL, CTR_QRCODE ' +
                        'FROM CADREC WHERE AUTOINCREM = :AUTOINC');

        LCadRec.ParamByName('AUTOINC').AsString := AAutoIncrem;
        LCadRec.Open;

        LRetornoBancoSafraAPI.nossoNumero      := RetornaCampoNossoNumero(LCadRec.FieldByName('CTR_NOSNUM').AsString);
        LRetornoBancoSafraAPI.QrCodeTxId       := LCadRec.FieldByName('CTR_TX_BOL').AsString;
        LRetornoBancoSafraAPI.QrCodeEmv        := LCadRec.FieldByName('CTR_QRCODE').AsString;
        LRetornoBancoSafraAPI.codigoAgencia    := LDadosCarteira.LCodigoAgencia;
        LRetornoBancoSafraAPI.digitoAgencia    := LDadosCarteira.LDigitoAgencia;
        LRetornoBancoSafraAPI.linhaDigitavel   := LCadRec.FieldByName('CTR_LINDIG').AsString;
        LRetornoBancoSafraAPI.codigoDeBarras   := Copy(LRetornoBancoSafraAPI.linhaDigitavel, 01, 04) +
                                                  Copy(LRetornoBancoSafraAPI.linhaDigitavel, 33, 15) +
                                                  Copy(LRetornoBancoSafraAPI.linhaDigitavel, 05, 05) +
                                                  Copy(LRetornoBancoSafraAPI.linhaDigitavel, 11, 08) +
                                                  Copy(LRetornoBancoSafraAPI.linhaDigitavel, 19, 02) +
                                                  Copy(LRetornoBancoSafraAPI.linhaDigitavel, 22, 10);
        Exit;
      End;

      LJsonRetorno := TJSONObject.ParseJSONValue(LJsonRegistro) as TJSONObject;
      LJsonRetorno := ExtrairJsonObject(LJsonRetorno,'data');

      LRetornoBancoSafraAPI.nossoNumero    := RetornaValorJson(LJsonRetorno,'numero');
      LRetornoBancoSafraAPI.codigoDeBarras := RetornaValorJson(LJsonRetorno,'codigoBarras');

      LRetornoBancoSafraAPI.linhaDigitavel            := RetornaLinhaDigitavelDoCodigoBarras( LRetornoBancoSafraAPI.codigoDeBarras );
      LRetornoBancoSafraAPI.BeneficiarioAgencia       := LDadosCarteira.LCodigoAgencia + LDadosCarteira.LDigitoAgencia;
      LRetornoBancoSafraAPI.BeneficiarioContaCorrente := LDadosCarteira.LContaCorrente;
      LRetornoBancoSafraAPI.CodigoCarteira            := LDadosCarteira.LCodigoCarteira;

      LRetornoBancoSafraAPI.nossoNumero := fStrZero(LRetornoBancoSafraAPI.nossoNumero, 9);

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
function TBancoSafraAPI.RetornaCampoDecimalJSON(AValor: String): String;
begin
  Result := AValor.Replace('.', EmptyStr);
  Result := Result.Replace(',', '.');
end;

function TBancoSafraAPI.RetornaCampoNossoNumero(ANosNum: String): String;
begin
  Result := fPadL(ANosNum, 09, '0') ;
end;

function TBancoSafraAPI.RetornaDocumento(ADadosDuplicata,ADadosCliente: TDataset; ANosNum: String): TJsonObject;
begin
  Result  := TJsonObject.Create;

  Result.AddPair('numero'                ,RetornaValorString(ANosNum, 9)); // nosso numero
  Result.AddPair('numeroCliente'         ,RightStr(ADadosDuplicata.FieldByName('CTR_NUMDUP').AsString,10));
  Result.AddPair('diasDevolucao'         ,LDadosCarteira.LQtdDiasDevolucao);
  Result.AddPair('especie'               ,'01');
  Result.AddPair('dataVencimento'        ,FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime) );
  Result.AddPair('valor'                 ,RetornaCampoDecimalJSON( fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat,2).ToString ));
  Result.AddPair('codigoMoeda'           ,'9');
  Result.AddPair('quantidadeDiasProtesto',LDadosCarteira.LQtdDiasProtesto);
  Result.AddPair('campoLivre'            ,'');
  Result.AddPair('valorAbatimento'       ,'0');
  Result.AddPair('identificacaoAceite'   ,LDadosCarteira.LAceite);

  If (( UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) ) Or
      ( ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 )) Then
  Begin
    Result.AddPair('desconto',RetornaGrupoDescontos(ADadosDuplicata));
  End;

  Result.AddPair('multa',RetornaMultaEJuros(ADadosDuplicata) );

  Result.AddPair('pagamentoParcial', RetornaPagamentoParcial(ADadosDuplicata));

  Result.AddPair('pagador'  ,RetornaPagador(ADadosCliente));

  If LDadosCarteira.UsaSacadorAvalista = 'S' Then
  Begin
     Result.AddPair('beneficiario',RetornaBeneficiario());
  End;

  Result.AddPair('mensagem','['+ Copy(Trim(LDadosCarteira.LObservacao1),1,80) + ', '
                               + Copy(Trim(LDadosCarteira.LObservacao2),1,80) + ', '
                               + Copy(Trim(LDadosCarteira.LObservacao3),1,80) + ', '
                               + Copy(Trim(LDadosCarteira.LObservacao4),1,80) + ']');

end;

function TBancoSafraAPI.RetornaGrupoDescontos(ADadosDuplicata: TDataSet): TJsonObject;
  Var
    LValorCorrigido: Double;
    LDataExpiracao : TDateTime;
    LValorCalc     : Double;
begin
  Result  := TJsonObject.Create;

  // Descontos
  If UtilizaDescontoDePontualidade(ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat) then
  Begin
     LValorCalc := 0;
     LValorCorrigido := (ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat * ( ADadosDuplicata.FieldByName('CTR_PERDPO').AsFloat / 100.00));
     LDataExpiracao  := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime - ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

     // desconto pontualidade;
     If LValorCorrigido > 0 Then
     Begin
       If LDadosCarteira.LTipoDesc = '0' Then // Valor R&
          LValorCalc := LValorCorrigido
       Else                                    // Percentual %
          LValorCalc := (( LValorCorrigido / ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat ) * 100);

       Result.AddPair('data', FormatDateTime('YYYY-MM-DD', LDataExpiracao));
       Result.AddPair('valor', RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
     End;

     // desconto duplicata;
     If (ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0) Then
     Begin
        LDataExpiracao := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -  ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

        If LDadosCarteira.LTipoDesc = '0' Then // Valor R$
           LValorCalc := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat
        Else                                    // Percentual %
           LValorCalc := (( ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat / ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat ) * 100);

        Result.AddPair('data2'  ,FormatDateTime('YYYY-MM-DD', LDataExpiracao));
        Result.AddPair('valor2' ,RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
     End;

     Result.AddPair('valorAbatimento' ,RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
     // 1 - Desconto;  2 - Percentual;
     Result.AddPair('tipoDesconto', IIF( (LDadosCarteira.LTipoDesc = '0'), '1', '2'));

  End
  Else
  Begin

      LValorCalc := 0;
      If ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat > 0 Then
      Begin
        LDataExpiracao := (ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime -  ADadosDuplicata.FieldByName('CTR_QTDDAV').AsInteger);

        If LDadosCarteira.LTipoDesc = '0' Then // Valor R$
           LValorCalc := ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat
        Else                                    // Percentual %
           LValorCalc := (( ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat / ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat ) * 100);

        Result.AddPair('data'  ,FormatDateTime('YYYY-MM-DD', LDataExpiracao));
        Result.AddPair('valor' ,RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
      End;

      Result.AddPair('valorAbatimento' ,RetornaCampoDecimalJSON(fFormataFloat(LValorCalc,2).ToString));
      // 1 - Desconto;  2 - Percentual;
      Result.AddPair('tipoDesconto', IIF( (LDadosCarteira.LTipoDesc = '0'), '1', '2'));

  End;

End;

function TBancoSafraAPI.RetornaMultaEJuros(ADadosDuplicata: TDataSet): TJsonObject;
Begin

  Result := TJSONObject.Create;

  // Data Multa
  If Self.LPercentualMulta > 0 Then
     Result.AddPair('dataMulta'  , FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));

  // Data Juros
  If Self.LPercentualMora > 0 Then
     Result.AddPair('dataJuros'  , FormatDateTime('YYYY-MM-DD', ADadosDuplicata.FieldByName('CTR_DTAVEN').AsDateTime));

  // Taxa Juros
  If Self.LPercentualMora > 0 Then
     Result.AddPair('taxaJuros' , RetornaCampoDecimalJSON(fFormataFloat((Self.LPercentualMora/100),2).ToString));

  // Taxa Multa
  If Self.LPercentualMulta > 0 Then
     Result.AddPair('taxaMulta' , RetornaCampoDecimalJSON(fFormataFloat((Self.LPercentualMulta/100),2).ToString));

end;

function TBancoSafraAPI.RetornaPagamentoParcial(ADadosDuplicata: TDataSet): TJsonObject;
Begin
  Result := TJSONObject.Create;

  Result.AddPair('valorMaximo'       , RetornaCampoDecimalJSON( fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat,2).ToString ) );
  Result.AddPair('valorMinimo'       , RetornaCampoDecimalJSON( fFormataFloat(ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat,2).ToString ) );
  Result.AddPair('quantidadeParcelas', '1');
  Result.AddPair('tipoPagamento'     , '1');
  Result.AddPair('tipoValor'         , '1');
end;

function TBancoSafraAPI.RetornaDadosDaRequisicao(ADadosDuplicata,ADadosCliente: TDataset; ANosNum: String): String;
  Var
    Json: TJSONObject;
begin
  Json := TJsonObject.Create;

  try

    Json.AddPair('conta'     ,LDadosCarteira.LContaCorrente);
    Json.AddPair('agencia'   ,LDadosCarteira.LCodigoAgencia + LDadosCarteira.LDigitoAgencia);
    Json.AddPair('documento' ,RetornaDocumento(ADadosDuplicata, ADadosCliente, ANosNum));
    Result := PrettyJSON(Json.ToString);

  Finally
    FreeAndNil(Json);
  End;

end;

function TBancoSafraAPI.PrettyJSON(JsonString:String):String;
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

function TBancoSafraAPI.RetornaJsonRegistroBoleto(AAutoIncrem: String): String;
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

function TBancoSafraAPI.RetornaLinkConsultaBoletosNossoNumero(AAgencia, AConta, ANosNum, ANumeroCliente : String): String;
  Var
    LLink_: String;
begin
  LLink_ := LDadosCarteira.FLinkConsultaBoletoNossoNumero + '?agencia=' + AAgencia
                                                          + '&conta='   + AConta
                                                          + '&numero='  + ANosNum
                                                          + '&numeroCliente=' + ANumeroCliente;
  Result := LLink_;
end;

function TBancoSafraAPI.RetornaLinkConsultaBoletosNossoNumero_Completa(AAgencia, AConta, ANosNum, ANumeroDup : String): String;
  Var
    LLink_: String;
begin
  LLink_ := LDadosCarteira.FLinkConsultaBoletoNossoNumero_Completo + '?agencia=' + RightStr(AAgencia,5)
                                                                   + '&conta='   + RightStr(AConta,9)
                                                                   + '&numeroDoBoleto='  + RightStr(ANosNum,9)
                                                                   + '&seuNumero=' + RightStr(ANumeroDup,9);
  Result := LLink_;
end;

function TBancoSafraAPI.RetornaPagador(ADadosCliente: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;

  Result.AddPair('nome'           ,RetornaValorString(ADadosCliente.FieldByName('CLI_NOMCLI').AsString, 40));
  Result.AddPair('tipoPessoa'     ,IIF(Length(fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString)) = 11,'F','J'));
  Result.AddPair('numeroDocumento',fTiraCaracEspeciaisPonto(ADadosCliente.FieldByName('CLI_C_G_C_').AsString));
  Result.AddPair('endereco'       ,RetornaEnderecoPagador(ADadosCliente));
end;

function TBancoSafraAPI.RetornaEnderecoPagador(ADadosCliente: TDataSet): TJsonObject;
begin
  Result  := TJsonObject.Create;

  Result.AddPair('logradouro' ,RetornaValorString(RetornaEnderecoENumeroCom30Caracteres(ADadosCliente.FieldByName('CLI_ENDERE').AsString,
                                                                                        ADadosCliente.FieldByName('CLI_ENDNUM').AsString)));
  Result.AddPair('bairro'     ,RetornaValorString(ADadosCliente.FieldByName('CLI_BAIRRO').AsString, 10));
  Result.AddPair('cidade'     ,RetornaValorString(ADadosCliente.FieldByName('CID_NOMCID').AsString, 15));
  Result.AddPair('uf'         ,ADadosCliente.FieldByName('CID_ESTADO').AsString);
  Result.AddPair('cep'        ,fRetSomenteNumeros(ADadosCliente.FieldByName('CLI_C_E_P_').AsString));
End;

function TBancoSafraAPI.RetornaBeneficiario(): TJsonObject;
begin
  Result  := TJsonObject.Create;

  Result.AddPair('nome'           ,RetornaValorString(fTiraCaracEspeciais(LDadosCarteira.NomeBeneficiario), 40));
  Result.AddPair('tipoPessoa'     ,IIF(Length(fTiraCaracEspeciais(LDadosCarteira.CNPJBeneficiario,true,true,true,true,true,true)) = 11,'F','J'));
  Result.AddPair('email'          ,'');
  Result.AddPair('numeroDocumento',fTiraCaracEspeciais(LDadosCarteira.CNPJBeneficiario,true,true,true,true,true,true));
  Result.AddPair('endereco'       ,RetornaEnderecoBeneficiario());

End;

function TBancoSafraAPI.RetornaEnderecoBeneficiario(): TJsonObject;
begin
  Result  := TJsonObject.Create;

  // beneficiario
  Result.AddPair('logradouro'    ,RetornaValorString(RetornaEnderecoENumeroCom30Caracteres(LDadosCarteira.EnderecoBeneficiario, '')));
  Result.AddPair('bairro'        ,RetornaValorString(fTiraCaracEspeciais(LDadosCarteira.BairroBeneficiario), 10));
  Result.AddPair('cidade'        ,RetornaValorString(fTiraCaracEspeciais(LDadosCarteira.CidadeBeneficiario), 15));
  Result.AddPair('uf'            ,LDadosCarteira.UFBeneficiario);
  Result.AddPair('cep'           ,fRetSomenteNumeros(fTiraCaracEspeciais(LDadosCarteira.CEPBeneficiario)));
End;

function TBancoSafraAPI.RetornaValorDuplicata(ADadosDuplicata: TDataSet): Double;
begin
  Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat;

  If fCfgSis('VALIMP', varBoolean, LDadosCarteira.LEmpresaCarteira) then
    Result := ADadosDuplicata.FieldByName('CTR_VALDUP').AsFloat +
              ADadosDuplicata.FieldByName('CTR_JURSUJ').AsFloat +
              ADadosDuplicata.FieldByName('CTR_DESCOB').AsFloat;

  If fCfgSis('DESBOL', varBoolean, LDadosCarteira.LEmpresaCarteira) Then
    Result := Result -
              ADadosDuplicata.FieldByName('CTR_DESSUJ').AsFloat;
end;

function TBancoSafraAPI.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
  Begin
    Try
      Result := AObjeto.GetValue<string>(ANomeCampo);
    Except
      Result := AObjeto.GetValue(ANomeCampo).ToString;
    End;
  End;
end;

function TBancoSafraAPI.RetornaValorString(AValor: String;
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

function TBancoSafraAPI.UtilizaDescontoDePontualidade(
  AValDes: Double): Boolean;
begin
  Result := False;

  If fCfgSis('DESPON', varBoolean, LDadosCarteira.LEmpresaCarteira) Then
  Begin
    If (AValDes > 0) Then
      Result := True;
  End;

end;

procedure TBancoSafraAPI.ValidaStatusErro(AStatus: Integer; ARetornoGet: String);
begin
  If AStatus <> 200 Then
    Raise Exception.Create(ARetornoGet);
end;

function TBancoSafraAPI.VerificaSeADuplicataExisteCadrec(ABoleto: TRetornoPesquisaBancoSafraApi;out ADuplicata: TDuplicataCtr): Boolean;
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
                          'CTR_END_ID, CTR_DTAVEN                         ' +
                          'FROM CADREC                                    ' +
                          'WHERE CTR_NOSNUM = :NOSNUM           ' +
                          '  AND CTR_BCOENV=:BCOENV                       ' +
                        //'  AND CTR_DTAVEN=:DTAVEN                       ' +
                          '  AND CTR_SEQBAI=0                             ';

    LPesquisa.ParamByName('NOSNUM').AsString   := ABoleto.NossoNumero;
    LPesquisa.ParamByName('BCOENV').AsString   := '422';
  //LPesquisa.ParamByName('DTAVEN').AsDateTime := StrToDate(ABoleto.ABoletoDataVencimento);

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
    ADuplicata.strCartei := LPesquisa.FieldByName('CTR_CARTEI').AsString;
    ADuplicata.EndToEndPix := LPesquisa.FieldByName('CTR_END_ID').AsString;

    //Atualiza a data de vencimento de acorodo co o registro do banco.
    ABoleto.BoletoDataVencimento := LPesquisa.FieldByName('CTR_DTAVEN').AsString;

    If LPesquisa.RecordCount > 1 Then
    Begin
      LPesquisa.Filter := 'CTR_CARTEI=' + QuotedStr(LDadosCarteira.LCarteiraBanco + '-' + LDadosCarteira.LEmpresaCarteira);
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

function TBancoSafraAPI.RetonaDuplicatasBoletoGerado(
  ACarteira: String; ADataInicial, ADataFinal: TDateTime): TUniClientDataSet;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM, ' +
                          '  CTR_NUMDUP, ' +
                          '  CTR_PARCEL, ' +
                          '  CTR_ESPDOC, ' +
                          '  CTR_CODEMP, ' +
                          '  CTR_CODCLI, ' +
                          '  CTR_CARTEI, ' +
                          '  CTR_NOSNUM, ' +
                          '  CTR_DTACAD, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_DTAVEN, ' +
                          '  CTR_VALDUP, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_TX_BOL  ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DTAREC IS NULL ' +
                          '  AND CTR_BCOBOL="422" ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_DTAENV<=:DTAENV ' +

                          'UNION ' +

                          'SELECT AUTOINCREM, ' +
                          '  CTR_NUMDUP, ' +
                          '  CTR_PARCEL, ' +
                          '  CTR_ESPDOC, ' +
                          '  CTR_CODEMP, ' +
                          '  CTR_CODCLI, ' +
                          '  CTR_CARTEI, ' +
                          '  CTR_NOSNUM, ' +
                          '  CTR_DTACAD, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_DTAVEN, ' +
                          '  CTR_VALDUP, ' +
                          '  CTR_DTAENV, ' +
                          '  CTR_TX_BOL  ' +
                          'FROM CADREC ' +
                          'WHERE CTR_DTAREC BETWEEN :DTAINI AND :DTAFIM ' +
                          '  AND CTR_BCOBOL="422" ' +
                          '  AND CTR_CARTEI=:CARTEI ' +
                          '  AND CTR_SEQBAI=0 ' +

                          'ORDER BY CTR_DTAVEN';

    LConsulta.ParamByName('CARTEI').AsString := ACarteira;
    LConsulta.ParamByName('DTAENV').AsDateTime := ADataFinal;
    LConsulta.ParamByName('DTAINI').AsDateTime := ADataInicial;
    LConsulta.ParamByName('DTAFIM').AsDateTime := ADataFinal;

    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TRetornoPesquisaBancoSafraApi.DataCreditoAsDate: String;
begin
  Result := Self.BoletoDataCredito.Replace('.','/');
end;

function TRetornoPesquisaBancoSafraApi.DataMovimentoAsDate: String;
begin
  Result := Self.BoletoDataMovimento.Replace('.','/');
end;

function TRetornoPesquisaBancoSafraApi.DataRegistroAsDate: String;
begin
  Result := Self.BoletoDataRegistro.Replace('.','/');
end;

function TRetornoPesquisaBancoSafraApi.DataVencimentoAsDate: String;
begin
  Result := Self.BoletoDataVencimento.Replace('.','/');
end;

function TRetornoPesquisaBancoSafraApi.GetNossoNumero: String;
begin
  Result := RightStr(Self.BoletoNumeroBoleto,9);
end;

function TRetornoPesquisaBancoSafraApi.ValorPagoCedente: String;
begin

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

function TBancoSafraAPI.RetornaTextoErro(ADadosRetorno: String): String;
  Var
    LJsonObject: TJsonObject;

    LMensagem: String;
    LErroInstabilidade,
    LErroAutenticacao : String;
begin
  Result := 'Erro: ' + ADadosRetorno;

  LErroInstabilidade := 'Ocorreu um erro não identificado no servidor do banco. Tente novamente mais tarde! ';

  LErroAutenticacao  := 'Ocorreu um erro ao realizar a autenticação na API do Banco.';

  Try
    LJsonObject := TJSONObject.ParseJSONValue(ADadosRetorno) As TJsonObject;

    If LJsonObject = Nil Then
    Begin
       Result := LErroInstabilidade;

       If (Pos(LErroAutenticacao, ADadosRetorno) > 0) Then
          Result := LErroAutenticacao;

       Exit;
    End;

    If fEmptyStr(ADadosRetorno) Then
    Begin
       Result := LErroInstabilidade;
       exit;
    End;

    LMensagem := ExtrairMensagemErro(ADadosRetorno);
    If Not fEmptyStr(LMensagem) Then
       Result := LMensagem;

    FreeAndNil(LJsonObject);
  Except
    Result := LErroInstabilidade;
  End;
end;

function TBancoSafraAPI.ExtrairMensagemErro(const AJsonStr: string): string;
var
  LJsonObj: TJSONObject;
begin
  Result := '';
  try
    LJsonObj := TJSONObject.ParseJSONValue(AJsonStr) as TJSONObject;
    try
      if Assigned(LJsonObj) then
        LJsonObj.TryGetValue<string>('message', Result);
    finally
      LJsonObj.Free;
    end;
  except
    on E: Exception do
      Result := 'Erro ao interpretar o JSON: ' + E.Message;
  end;
end;

end.
